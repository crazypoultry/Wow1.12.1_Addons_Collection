--[[---------------------------------------------------------------------------------
  This is a template for the plugin/module system for XAD.

  Plugins are used in XAD to a specify a  button action/use.
  
  Plugins are registered with XAD with a shortname that is used for all
  commands.  In addition they are required to have a fullname parameter that is
  used in all display messages
----------------------------------------------------------------------------------]]

-- Create the object and expose the name of the mod for options setting
local core=XAD

local Plugin = core:NewModule("healthpotions")
Plugin.fullname = "Health Potions"

local BZ = AceLibrary("Babble-Zone-2.2")
local metro = AceLibrary:GetInstance("Metrognome-2.0")
local PT = PeriodicTableEmbed:GetInstance("1")
local compost = AceLibrary:HasInstance("Compost-2.0") and AceLibrary("Compost-2.0")

PT:RegisterCustomSet("11951:800", "XADWRT")
-- register our custom item set w/ PT
--PT:RegisterCustomSet("5512:100 19004:110 19005:120 5511:250 19006:275 19007:300 5509:500 19008:550 19009:600 5510:800 19010:880 19011:960 9421:1200 19012:1320 19013:1440","XADhealthstone")
Plugin.Spells = {
	'Create Healthstone (Major)',
	'Create Healthstone (Greater)',
	'Create Healthstone',
	'Create Healthstone (Lesser)',
	'Create Healthstone (Minor)',
}

-- Plugin:OnEnable() is called if Plugin:Test() is true, and the mod hasn't been explicitly
-- disabled.  This is where you should handle all your hooks, etc.
function Plugin:OnEnable()
	--custom set to track cooldown timers by stone rank and which spell crates each stone from the spells table
	PT:RegisterCustomSet("5512:5 19004:5 19005:5 5511:4 19006:4 19007:4 5509:3 19008:3 19009:3 5510:2 19010:2 19011:2 9421:1 19012:1 19013:1","XADhealthstoneranks")
end

function Plugin:OnDisable()
end

--ShowItem return bag, slot, spells, showcount
--	bag, slot = iventory location of item to display in the button
--	spells = table of spells that can be cast to create new items
--	showcount = true/false to show item counts on the button
function Plugin:ShowItem()
	--see if we have a stone not on cooldown and show it
	local bag, slot = PT:GetBest("healthstone", nil, function(bag,slot,val) return GetContainerItemCooldown(bag,slot) == 0 end)
	if not bag then bag, slot = PT:GetBest("XADWRT", nil, function(bag,slot,val) return GetContainerItemCooldown(bag,slot) == 0 end) end
	if not bag and GetRealZoneText()==BZ["Alterac Valley"] then bag, slot = PT:GetBest("potionhealalterac") end
	if not bag then bag, slot = PT:GetBest("potionhealall") end
	return bag, slot, self.Spells, true
end

--UseItem return bag, slot, spells, trade, leftaction, rightaction
--	bag, slot = iventory location of item to be uses
--	spells = table of spells that can be cast to create new items
--	trade = true/false to allow trading of the item
-- 	leftaction/rightaction = optional custom functions to be called on left/right clicking the button
--	refreshdelay = delay to refresh the button,  this is needed for example when a item can be used and not consumed.
--				This is useful to start the cooldowntimer after the casting the spell on the item.
function Plugin:UseItem()
	--check for healthstone first
	local bag, slot = PT:GetBest("healthstone", nil, function(bag,slot,val) return GetContainerItemCooldown(bag,slot) == 0 end)
	if not bag then bag, slot = PT:GetBest("XADWRT", nil, function(bag,slot,val) return GetContainerItemCooldown(bag,slot) == 0 end) end
	-- from pothead added check for cooldown
	local h = UnitHealthMax("player") - UnitHealth("player")
	local v = function(bag,slot,val) return val/2 <= h end
	local f = function(a1,a2,a3,b1,b2,b3) return (a3*1.125) <= h and (b3*.875) > h or (a3*1.125) <= h and a3 > b3 or a3 > h and b3 > h and a3 < b3 end
	if not bag and GetRealZoneText()==BZ["Alterac Valley"] then bag, slot = PT:GetBest("potionhealalterac", f, v) end
	if not bag then bag, slot = PT:GetBest("potionhealall", f, v) end
	return bag, slot, self.Spells, true, nil, "CreateStone", 123
end

function Plugin:ItemInList(itemlink, spellid)
	if itemlink then
		--local itemlink = GetContainerItemLink(bag,slot)
		return PT:ItemInSet(itemlink,{"healthstone","potionhealalterac", "potionhealall", "XADWRT"})
	elseif spellid then
		local name, rank = GetSpellName(spellid, SpellBookFrame.bookType)
		for i,v in self.Spells do
			if v==name then return true end
		end
	end
end

function Plugin:CreateStone()
	-- if we have a friendly target then instead of creating a stone trade it
	if UnitIsPlayer("target") and UnitIsFriend("player","target") then
		local bag, slot  = PT:GetBest("healthstone")
		core:Trade(bag, slot)
		return
	end
	--copy the spell list over to a temp table
	local sl = compost:GetTable()
	for key, val in pairs(self.Spells) do sl[key] = val end
	-- look for stones already in our bags and remove thier creation spells from the spell list
	for bag,slot,val in self:BagIter("XADhealthstoneranks") do
		-- just blank out the spell name so we can't cast it
		sl[val] = ""
	end
	--ok try to create a stone with the spells that are left
	core:CastSpell(sl)
	compost:Reclaim(sl)
end

local iterbag, iterslot, iterset
local iter = function()
	if iterslot > GetContainerNumSlots(iterbag) then iterbag, iterslot = iterbag + 1, 1 end
	if iterbag > 4 then return end

	for b=iterbag,4 do
		for s=iterslot,GetContainerNumSlots(b) do
			iterslot = s + 1

			local link = GetContainerItemLink(b,s)
			local val = link and PT:ItemInSet(link, iterset)
			if val then return b, s, val end
		end

		iterbag, iterslot = b+1, 1
	end
end


-- Iterator for scanning bags for set matches
-- Returns back bag, slot, value
function Plugin:BagIter(set)
	if not set then return end

	iterbag, iterslot, iterset = 0, 1, set
	return iter
end

--[[---------------------------------------------------------------------------------
  This is a template for the plugin/module system for XAD.

  Plugins are used in XAD to a specify a  button action/use.
  
  Plugins are registered with XAD with a shortname that is used for all
  commands.  In addition they are required to have a fullname parameter that is
  used in all display messages
----------------------------------------------------------------------------------]]

-- Create the object and expose the name of the mod for options setting
local core=XAD

local Plugin = core:NewModule("merpotions")
Plugin.fullname = "Mana/Energy/Rage Potions"

local BZ = AceLibrary("Babble-Zone-2.2")
local metro = AceLibrary:GetInstance("Metrognome-2.0")
local PT = PeriodicTableEmbed:GetInstance("1")
local compost = AceLibrary:HasInstance("Compost-2.0") and AceLibrary("Compost-2.0")

Plugin:SetDebugLevel(2)
-- register our custom item set w/ PT
--PT:RegisterCustomSet("5513:600 5514:400 8007:850 8008:1100","XADmanastone")
PT:RegisterCustomSet("7676","XADenergy")
Plugin.Spells = {
	"Conjure Mana Ruby",
	"Conjure Mana Citrine",
	"Conjure Mana Jade",
	"Conjure Mana Agate",
}

-- Plugin:OnEnable() is called if Plugin:Test() is true, and the mod hasn't been explicitly
-- disabled.  This is where you should handle all your hooks, etc.
function Plugin:OnEnable()
	PT:RegisterCustomSet("5514:4 5513:3 8007:2 8008:1","XADmanastoneranks")
end

function Plugin:OnDisable()
end

--ShowItem return bag, slot, spells, showcount
--	bag, slot = iventory location of item to display in the button
--	spells = table of spells that can be cast to create new items
--	showcount = true/false to show item counts on the button
function Plugin:ShowItem()
	local bag, slot
	local p = UnitPowerType('player') --0==mana, 1=rage, 3=energy
	if p==1 then
		bag, slot = PT:GetBest("potionrage")
		return bag, slot, nil, true
	elseif p==3 then
		bag, slot = PT:GetBest("XADenergy")
		return bag, slot, nil, true
	else
		--see if we have a stone not on cooldown and show it
		local bag, slot = PT:GetBest("manastone", nil, function(bag,slot,val) return GetContainerItemCooldown(bag,slot) == 0 end)
		if not bag and GetRealZoneText()==BZ["Alterac Valley"] then bag, slot = PT:GetBest("potionmanaalterac") end
		if not bag then bag, slot = PT:GetBest("potionmanaall") end
		return bag, slot, self.Spells, true
	end
end

--UseItem return bag, slot, spells, trade, leftaction, rightaction
--	bag, slot = iventory location of item to be uses
--	spells = table of spells that can be cast to create new items
--	trade = true/false to allow trading of the item
-- 	leftaction/rightaction = optional custom functions to be called on left/right clicking the button
function Plugin:UseItem()
	local p = UnitPowerType('player') --0==mana, 1=rage, 3=energy
	self:LevelDebug(2, "power type %s", p)
	local bag, slot
	if p==1 then
		bag, slot = PT:GetBest("potionrage")
		return bag, slot, nil, false
	elseif p==3 then
		bag, slot = PT:GetBest("XADenergy")
		return bag, slot, nil, false
	else
		--check for healthstone first
		local bag, slot = PT:GetBest("manastone", nil, function(bag,slot,val) return GetContainerItemCooldown(bag,slot) == 0 end)
		-- from pothead added check for cooldown
		local m = UnitManaMax("player") - UnitMana("player")
		local v = function(bag,slot,val) return val/2 <= m end
		local f = function(a1,a2,a3,b1,b2,b3) return a3 <= m and b3 > m or a3 <= m and a3 > b3 or a3 > m and b3 > m and a3 < b3 end
		if not bag and GetRealZoneText()==BZ["Alterac Valley"] then bag, slot = PT:GetBest("potionmanaalterac", f, v) end
		if not bag then bag, slot = PT:GetBest("potionmanaall", f, v) end
		return bag, slot, self.Spells, true, nil, "CreateStone", 123
	end
end

function Plugin:ItemInList(itemlink, spellid)
	if itemlink then
		--local itemlink = GetContainerItemLink(bag,slot)
		return PT:ItemInSet(itemlink,{"potionrage","XADenergy", "manastone", "potionmanaalterac", "potionmanaall"})
	elseif spellid then
		local name, rank = GetSpellName(spellid, SpellBookFrame.bookType)
		for i,v in self.Spells do
			if v==name then return true end
		end
	end
end

function Plugin:CreateStone()
	--copy the spell list over to a temp table
	local sl = compost:GetTable()
	for key, val in pairs(self.Spells) do sl[key] = val end
	-- look for stones already in our bags and remove thier creation spells from the spell list
	for bag,slot,val in self:BagIter("XADmanastoneranks") do
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
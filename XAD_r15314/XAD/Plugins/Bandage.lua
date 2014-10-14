--[[---------------------------------------------------------------------------------
  This is a template for the plugin/module system for XAD.

  Plugins are used in XAD to a specify a  button action/use.
  
  Plugins are registered with XAD with a shortname that is used for all
  commands.  In addition they are required to have a fullname parameter that is
  used in all display messages
----------------------------------------------------------------------------------]]

-- Create the object and expose the name of the mod for options setting
local core=XAD

local Plugin = core:NewModule("bandage")
Plugin.fullname = "Bandage"

local PT = PeriodicTableEmbed:GetInstance("1")
local BZ = AceLibrary("Babble-Zone-2.2")

-- Plugin:OnEnable() is called if Plugin:Test() is true, and the mod hasn't been explicitly
-- disabled.  This is where you should handle all your hooks, etc.
function Plugin:OnEnable()
end

--ShowItem return bag, slot, spells, showcount
--	bag, slot = iventory location of item to display in the button
--	spells = table of spells that can be cast to create new items
--	showcount = true/false to show item counts on the button
function Plugin:ShowItem()
	local bag, slot
	if GetRealZoneText()==BZ["Warsong Gulch"] then 
		bag, slot = PT:GetBest("bandageswarsong")
	elseif GetRealZoneText()==BZ["Arathi Basin"] then 
		bag, slot = PT:GetBest("bandagesarathi")
	elseif GetRealZoneText()==BZ["Alterac Valley"] then 
		bag, slot = PT:GetBest("bandagesalterac")
	end
	if not bag then bag, slot = PT:GetBest("bandagesgeneral") end
	return bag, slot, nil, true
end

--UseItem return bag, slot, spells, trade, leftaction, rightaction
--	bag, slot = iventory location of item to be uses
--	spells = table of spells that can be cast to create new items
--	trade = true/false to allow trading of the item
-- 	leftaction/rightaction = optional custom functions to be called on left/right clicking the button
function Plugin:UseItem()
	-- since using bandages also needs to be able to use them on a friendly target we'll use a custom left click function.
	return nil, nil, nil, nil, "UseBandage"
end

function Plugin:ItemInList(itemlink)
	if not itemlink then return end
	--local itemlink = GetContainerItemLink(bag,slot)
	return PT:ItemInSet(itemlink,"bandages")
end

function Plugin:UseBandage()
	local unit = UnitExists("target") and UnitIsFriend("target", "player") and "target" or "player"
	local bag, slot
	local h = UnitHealthMax(unit) - UnitHealth(unit)
	if h == 0 then return end
	local v = function(bag,slot,val) return val/2 <= h end
	local f = function(a1,a2,a3,b1,b2,b3) return a3 <= h and b3 > h or a3 <= h and a3 > b3 or a3 > h and b3 > h and a3 < b3 end
	if GetRealZoneText()==BZ["Warsong Gulch"] then 
		bag, slot = PT:GetBest("bandageswarsong", f, v)
	elseif GetRealZoneText()==BZ["Arathi Basin"] then 
		bag, slot = PT:GetBest("bandagesarathi", f, v)
	elseif GetRealZoneText()==BZ["Alterac Valley"] then 
		bag, slot = PT:GetBest("bandagesalterac", f, v)
	end
	if not bag then bag, slot, val = PT:GetBest("bandagesgeneral", f, v) end
	if bag and slot then
		core:UseItem(bag, slot)
		if SpellIsTargeting() then SpellTargetUnit(unit) end
	end
end

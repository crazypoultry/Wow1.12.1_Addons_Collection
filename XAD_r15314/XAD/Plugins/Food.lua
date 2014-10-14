--[[---------------------------------------------------------------------------------
  This is a template for the plugin/module system for XAD.

  Plugins are used in XAD to a specify a  button action/use.
  
  Plugins are registered with XAD with a shortname that is used for all
  commands.  In addition they are required to have a fullname parameter that is
  used in all display messages
----------------------------------------------------------------------------------]]

-- Create the object and expose the name of the mod for options setting
local core=XAD

local Plugin = core:NewModule("food")
Plugin.fullname = "Food"

local PT = PeriodicTableEmbed:GetInstance("1")
local BZ = AceLibrary("Babble-Zone-2.2")

-- register our custom item set w/ PT
PT:RegisterCustomSet({"food", "foodbonus", "foodstat","foodcombohealth"},"XADfood")
PT:RegisterCustomSet({"foodperc", "foodpercbonus", "foodcomboperc"},"XADfoofperc")
Plugin.Spells = {
	"Conjure Food"
}

-- Plugin:OnEnable() is called if Plugin:Test() is true, and the mod hasn't been explicitly
-- disabled.  This is where you should handle all your hooks, etc.
function Plugin:OnEnable()
end

--ShowItem return bag, slot, spells, showcount
--	bag, slot = iventory location of item to display in the button
--	spells = table of spells that can be cast to create new items
--	showcount = true/false to show item counts on the button
function Plugin:ShowItem()
	local bag, slot = PT:GetBest("foodbreadconjured")
	if not bag and GetRealZoneText()==BZ["Arathi Basin"] then 
		bag, slot = PT:GetBest("foodarathi")
	end
	if not bag then 
		bag, slot, val = PT:GetBest("XADfood") 
		local bagp, slotp, valp = PT:GetBest("XADfoofperc") 
		-- if we don't have normal food and only precent food then use it
		if not bag and bagp then 
			bag, slot = bagp, slotp
		-- if we have both types and the percent heal item restores more than the normal item use it
		elseif bagp and bag then 
			if (valp*UnitHealthMax("player")/100) > val then 
				bag, slot = bagp, slotp 
			end 
		end
	end
	return bag, slot, self.Spells, true
end

--UseItem return bag, slot, spells, trade, leftaction, rightaction
--	bag, slot = iventory location of item to be uses
--	spells = table of spells that can be cast to create new items
--	trade = true/false to allow trading of the item
-- 	leftaction/rightaction = optional custom functions to be called on left/right clicking the button
function Plugin:UseItem()
	local h = UnitHealthMax("player") - UnitHealth("player")
	if h == 0 then return nil, nil, self.Spells, true end
	local f = function(a1,a2,a3,b1,b2,b3) return a3 <= h and b3 > h or a3 <= h and a3 > b3 or a3 > h and b3 > h and a3 < b3 end
	local bag, slot = PT:GetBest("foodbreadconjured", f)
	if not bag then
		bag, slot, val = PT:GetBest("XADfood", f)
		h = UnitHealth("player")/UnitHealthMax("player") * 100
		local bagp, slotp, valp = PT:GetBest("xadf2oofperc") 
		-- if we don't have normal food and only precent food then use it
		if not bag and bagp then 
			bag, slot = bagp, slotp
		-- if we have both types and the percent heal item restores more than the normal item use it
		elseif bagp and bag then 
			if (valp*UnitHealthMax("player")/100) > val then 
				bag, slot = bagp, slotp 
			end 
		end
	end
	return bag, slot, self.Spells, true
end

function Plugin:ItemInList(itemlink, spellid)
	if itemlink then
		--local itemlink = GetContainerItemLink(bag,slot)
		return PT:ItemInSet(itemlink,{"XADfood","XADfoofperc"})
	elseif spellid then
		local name, rank = GetSpellName(spellid, SpellBookFrame.bookType)
		for i,v in self.Spells do
			if v==name then return true end
		end
	end
end


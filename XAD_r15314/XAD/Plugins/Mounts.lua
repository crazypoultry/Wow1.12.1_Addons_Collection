--[[---------------------------------------------------------------------------------
  This is a template for the plugin/module system for XAD.

  Plugins are used in XAD to a specify a  button action/use.
  
  Plugins are registered with XAD with a shortname that is used for all
  commands.  In addition they are required to have a fullname parameter that is
  used in all display messages
----------------------------------------------------------------------------------]]

-- Create the object and expose the name of the mod for options setting
local core=XAD

local Plugin = core:NewModule("mounts")
Plugin.fullname = "Mounts"

local PT = PeriodicTableEmbed:GetInstance("1")
local BZ = AceLibrary("Babble-Zone-2.2")
-- register our custom item set w/ PT
Plugin.Spells = {
	"Summon Dreadsteed",
	"Summon Felsteed",
	"Summon Charger",
	"Summon Warhorse"
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
	local bag, slot
	if GetRealZoneText()==BZ["Ahn'Qiraj"] then 
		bag, slot = PT:GetBest("mountsaq")
	end
	local bag, slot = PT:GetBest("mounts")
	return bag, slot, self.Spells, false
end

--UseItem return bag, slot, spells, trade, leftaction, rightaction
--	bag, slot = iventory location of item to be uses
--	spells = table of spells that can be cast to create new items
--	trade = true/false to allow trading of the item
-- 	leftaction/rightaction = optional custom functions to be called on left/right clicking the button
function Plugin:UseItem()
	return nil, nil, self.Spells, false, "Mount"
end

function Plugin:ItemInList(itemlink, spellid)
	if itemlink then
		return PT:ItemInSet(itemlink,"mountsall")
	elseif spellid then
		local name, rank = GetSpellName(spellid, SpellBookFrame.bookType)
		for i,v in self.Spells do
			if v==name then return true end
		end
	end
end

function Plugin:Mount()
	local bag, slot
	if GetRealZoneText()==BZ["Ahn'Qiraj"] then 
		bag, slot = PT:GetBest("mountsaq")
	end
	if not bag then  bag, slot = PT:GetBest("mounts") end
	if bag then
		core:UseItem(bag, slot)
	else
		core:CastSpell(self.Spells)
	end
end
local dewdrop = DewdropLib:GetInstance('1.0')
local tablet = TabletLib:GetInstance('1.0')

--[[
EmoteFu
by Cilraaz of Cenarion Circle

This mod is a port of Titan Summoner by kyzac.  It has been adapted to work with FuBar.  Credit for the majority of
functions within goes to kyzac.

This is a plugin for FuBar, which allows Warlocks easy access to their demon pets, stones, mounts, and party abilities.

Change Log:
v0.1.2 (TOC 11100)
-- Added the ability for Left Clicking to re-cast the last pet or mount used
-- Set the tooltip and icon to update to indicate the last pet or mount used
v0.1.1a (TOC 11100)
-- Re-upped the archive. It now includes a directory structure so that the user only needs to unzip it to the AddOns folder, rather than needing to create a folder for it.
v0.1.1 (TOC 11100)
-- No changes needed other than TOC update
v0.1.0 (TOC 11000)
-- Initial Release

To do:
-- Add localization
]]

SummonFu = FuBarPlugin:GetInstance("1.2"):new({
	name          = SummonFuLocals.NAME,
	description   = SummonFuLocals.DESCRIPTION,
	version       = "0.1.2",
	releaseDate   = "07-02-2006",
	aceCompatible = 103,
	fuCompatible  = 101,
	author        = "Cilraaz",
	email         = "Cilraaz@gmail.com",
	website       = "http://cilraaz.wowinterface.com/",
	category      = "others",
	db            = AceDatabase:new("SummonFuDB"),
	cmd           = AceChatCmd:new(SummonFuLocals.COMMANDS, SummonFuLocals.CMD_OPTIONS),
	loc           = SummonFuLocals,
	hasIcon       = "Interface\\Icons\\Ability_Creature_Cursed_03",
	hasText 	  = "SummonFu",
	cannotDetachTooltip = TRUE
	})
	
	SummonFu.profileCode = true;
	
local summoner_Abilities = {
	[SummonFuLocals.SUMMONFU_TEXT_IMP] = 0,
	[SummonFuLocals.SUMMONFU_TEXT_VOIDWALKER] = 0,
	[SummonFuLocals.SUMMONFU_TEXT_SUCCUBUS] = 0,
	[SummonFuLocals.SUMMONFU_TEXT_FELHUNTER] = 0,
	[SummonFuLocals.SUMMONFU_TEXT_INFERNAL] = 0,
	[SummonFuLocals.SUMMONFU_TEXT_DOOMGUARD] = 0,
	[SummonFuLocals.SUMMONFU_TEXT_ENSLAVE] = 0,
}
local mount_Abilities = {
	[SummonFuLocals.SUMMONFU_TEXT_FELSTEED] = 0,
	[SummonFuLocals.SUMMONFU_TEXT_DREADSTEED] = 0,
}
local stone_Abilities = {
	[SummonFuLocals.SUMMONFU_TEXT_HEALTHSTONEMIN] = 0,
	[SummonFuLocals.SUMMONFU_TEXT_HEALTHSTONEL] = 0,
	[SummonFuLocals.SUMMONFU_TEXT_HEALTHSTONE] = 0,
	[SummonFuLocals.SUMMONFU_TEXT_HEALTHSTONEG] = 0,
	[SummonFuLocals.SUMMONFU_TEXT_HEALTHSTONEM] = 0,
	[SummonFuLocals.SUMMONFU_TEXT_SOULSTONEMIN] = 0,
	[SummonFuLocals.SUMMONFU_TEXT_SOULSTONEL] = 0,
	[SummonFuLocals.SUMMONFU_TEXT_SOULSTONE] = 0,
	[SummonFuLocals.SUMMONFU_TEXT_SOULSTONEG] = 0,
	[SummonFuLocals.SUMMONFU_TEXT_SOULSTONEM] = 0,
	[SummonFuLocals.SUMMONFU_TEXT_FIRESTONEL] = 0,
	[SummonFuLocals.SUMMONFU_TEXT_FIRESTONE] = 0,
	[SummonFuLocals.SUMMONFU_TEXT_FIRESTONEG] = 0,
	[SummonFuLocals.SUMMONFU_TEXT_FIRESTONEM] = 0,
	[SummonFuLocals.SUMMONFU_TEXT_SPELLSTONE] = 0,
	[SummonFuLocals.SUMMONFU_TEXT_SPELLSTONEG] = 0,
	[SummonFuLocals.SUMMONFU_TEXT_SPELLSTONEM] = 0,
}
local ritual_Abilities = {
	[SummonFuLocals.SUMMONFU_TEXT_RITUAL] = 0,
	[SummonFuLocals.SUMMONFU_TEXT_EYE] = 0,
}

function SummonFu:Initialize()
	local dummy, unitClass= UnitClass("player");
	if (unitClass ~= "WARLOCK") then
		return;
	end
	self.ttText = SummonFuLocals.SUMMONFU_TOOLTIP_TEXT;
	self.doWhat = "Summon Imp";
end
	
function SummonFu:UpdateTooltip()
	local cat = tablet:AddCategory()
		cat:AddLine(
			"text", self.ttText
		)
end

function SummonFu:SetPetType(petType, petIcon)
	self.doWhat = petType;
	self.petString = string.gsub(petType, "Summon ", "");
	self.ttTextTemp = "Hint: Left Click to summon your replaceme";
	self.ttText = string.gsub(self.ttTextTemp, "replaceme", self.petString);
	self:SetIcon(petIcon);
	self:UpdateTooltip();
	dewdrop:Close();
end

function SummonFu:OnClick()
	CastSpellByName(self.doWhat)
end

function SummonFu:MenuSettings(self, level, value)

	for spellName, id in ipairs(summoner_Abilities) do
		if (id > 0) then
			summoner_Abilities[spellName] = 0;
		end
	end
	
	local numTotalSpells = 0;
	for i=1, MAX_SKILLLINE_TABS do
		local name, texture, offset, numSpells = GetSpellTabInfo(i);
		if (name) then
			numTotalSpells = numTotalSpells + numSpells
		end
	end
	
	local summonerFound = 0;
	local mountFound = 0;
	local ritualFound = 0;
	local stoneFound = 0;
	
	for i=1, numTotalSpells do
		local spellName, subSpellName = GetSpellName(i, SpellBookFrame.bookType);
		if (spellName) then
			if (summoner_Abilities[spellName]) then
				summoner_Abilities[spellName] = i;
				summonerFound = 1;
			elseif (mount_Abilities[spellName]) then
				mount_Abilities[spellName] = i;
				mountFound = 1;
			elseif (ritual_Abilities[spellName]) then
				ritual_Abilities[spellName] = i;
				ritualFound = 1;
			elseif (stone_Abilities[spellName]) then
				stone_Abilities[spellName] = i;
				stoneFound = 1;
			end
		end
	end
	
	if (summonerFound == 1) then
	
		dewdrop:AddLine(
			'text', SummonFuLocals.SUMMONFU_SET_SUMMONER_TEXT,
			'isTitle', TRUE
		)
		
		if (summoner_Abilities[SummonFuLocals.SUMMONFU_TEXT_IMP] > 0) then
			local p = summoner_Abilities[SummonFuLocals.SUMMONFU_TEXT_IMP];
			dewdrop:AddLine(
				'text', SummonFuLocals.SUMMONFU_TEXT_IMP,
				'func', function() CastSpell(p, "spell") SummonFu:SetPetType(SummonFuLocals.SUMMONFU_TEXT_IMP, SummonFuLocals.SUMMONFU_IMP_ICON) end,
				'notcheckable', true
			)
		end
		if (summoner_Abilities[SummonFuLocals.SUMMONFU_TEXT_VOIDWALKER] > 0) then
			local p = summoner_Abilities[SummonFuLocals.SUMMONFU_TEXT_VOIDWALKER];
			dewdrop:AddLine(
				'text', SummonFuLocals.SUMMONFU_TEXT_VOIDWALKER,
				'func', function() CastSpell(p, "spell") SummonFu:SetPetType(SummonFuLocals.SUMMONFU_TEXT_VOIDWALKER, SummonFuLocals.SUMMONFU_VOID_ICON) end
			)
		end
		if (summoner_Abilities[SummonFuLocals.SUMMONFU_TEXT_SUCCUBUS] > 0) then
			local p = summoner_Abilities[SummonFuLocals.SUMMONFU_TEXT_SUCCUBUS];
			dewdrop:AddLine(
				'text', SummonFuLocals.SUMMONFU_TEXT_SUCCUBUS,
				'func', function() CastSpell(p, "spell") SummonFu:SetPetType(SummonFuLocals.SUMMONFU_TEXT_SUCCUBUS, SummonFuLocals.SUMMONFU_SUCCUBUS_ICON) end
			)
		end
		if (summoner_Abilities[SummonFuLocals.SUMMONFU_TEXT_FELHUNTER] > 0) then
			local p = summoner_Abilities[SummonFuLocals.SUMMONFU_TEXT_FELHUNTER];
			dewdrop:AddLine(
				'text', SummonFuLocals.SUMMONFU_TEXT_FELHUNTER,
				'func', function() CastSpell(p, "spell") SummonFu:SetPetType(SummonFuLocals.SUMMONFU_TEXT_FELHUNTER, SummonFuLocals.SUMMONFU_FELHUNTER_ICON) end
			)
		end
		if (summoner_Abilities[SummonFuLocals.SUMMONFU_TEXT_ENSLAVE] > 0) then
			local p = summoner_Abilities[SummonFuLocals.SUMMONFU_TEXT_ENSLAVE];
			dewdrop:AddLine(
				'text', SummonFuLocals.SUMMONFU_TEXT_ENSLAVE,
				'func', function() CastSpell(p, "spell") end
			)
		end
		if (summoner_Abilities[SummonFuLocals.SUMMONFU_TEXT_INFERNAL] > 0) then
			local p = summoner_Abilities[SummonFuLocals.SUMMONFU_TEXT_INFERNAL];
			dewdrop:AddLine(
				'text', SummonFuLocals.SUMMONFU_TEXT_INFERNAL,
				'func', function() CastSpell(p, "spell") end
			)
		end
		if (summoner_Abilities[SummonFuLocals.SUMMONFU_TEXT_DOOMGUARD] > 0) then
			local p = summoner_Abilities[SummonFuLocals.SUMMONFU_TEXT_DOOMGUARD];
			dewdrop:AddLine(
				'text', SummonFuLocals.SUMMONFU_TEXT_DOOMGUARD,
				'func', function() CastSpell(p, "spell") end
			)
		end
	end
	
	if (mountFound == 1) then
		dewdrop:AddLine()
		dewdrop:AddLine(
			'text', SummonFuLocals.SUMMONFU_SET_MOUNT_TEXT,
			'isTitle', TRUE
		)
		if (mount_Abilities[SummonFuLocals.SUMMONFU_TEXT_FELSTEED] > 0) then
			local p = mount_Abilities[SummonFuLocals.SUMMONFU_TEXT_FELSTEED];
			dewdrop:AddLine(
				'text', SummonFuLocals.SUMMONFU_TEXT_FELSTEED,
				'func', function() CastSpell(p, "spell") SummonFu:SetPetType(SummonFuLocals.SUMMONFU_TEXT_FELSTEED, SummonFuLocals.SUMMONFU_FELSTEED_ICON) end
			)
		end
		if (mount_Abilities[SummonFuLocals.SUMMONFU_TEXT_DREADSTEED] > 0) then
			local p = mount_Abilities[SummonFuLocals.SUMMONFU_TEXT_DREADSTEED];
			dewdrop:AddLine(
				'text', SummonFuLocals.SUMMONFU_TEXT_DREADSTEED,
				'func', function() CastSpell(p, "spell") SummonFu:SetPetType(SummonFuLocals.SUMMONFU_TEXT_DREADSTEED, SummonFuLocals.SUMMONFU_DREADSTEED_ICON) end
			)
		end
	end
	
	if (ritualFound == 1) then
		dewdrop:AddLine()
		dewdrop:AddLine(
			'text', SummonFuLocals.SUMMONFU_SET_PARTY_TEXT,
			'isTitle', TRUE
		)
		if (ritual_Abilities[SummonFuLocals.SUMMONFU_TEXT_RITUAL] > 0) then
			local p = ritual_Abilities[SummonFuLocals.SUMMONFU_TEXT_RITUAL];
			dewdrop:AddLine(
				'text', SummonFuLocals.SUMMONFU_TEXT_RITUAL,
				'func', function() CastSpell(p, "spell") end
			)
		end
		if (ritual_Abilities[SummonFuLocals.SUMMONFU_TEXT_EYE] > 0) then
			local p = ritual_Abilities[SummonFuLocals.SUMMONFU_TEXT_EYE];
			dewdrop:AddLine(
				'text', SummonFuLocals.SUMMONFU_TEXT_EYE,
				'func', function() CastSpell(p, "spell") end
			)
		end
	end
	
	if (stoneFound == 1) then
		dewdrop:AddLine()
		dewdrop:AddLine(
			'text', SummonFuLocals.SUMMONFU_SET_STONE_TEXT,
			'isTitle', TRUE
		)
		
		if (stone_Abilities[SummonFuLocals.SUMMONFU_TEXT_HEALTHSTONEM] > 0) then
			local p = stone_Abilities[SummonFuLocals.SUMMONFU_TEXT_HEALTHSTONEM];
			dewdrop:AddLine(
				'text', SummonFuLocals.SUMMONFU_TEXT_HEALTHSTONEM,
				'func', function() CastSpell(p, "spell") end
			)
		elseif (stone_Abilities[SummonFuLocals.SUMMONFU_TEXT_HEALTHSTONEG] > 0) then
			local p = stone_Abilities[SummonFuLocals.SUMMONFU_TEXT_HEALTHSTONEG];
			dewdrop:AddLine(
				'text', SummonFuLocals.SUMMONFU_TEXT_HEALTHSTONEG,
				'func', function() CastSpell(p, "spell") end
			)
		elseif (stone_Abilities[SummonFuLocals.SUMMONFU_TEXT_HEALTHSTONE] > 0) then
			local p = stone_Abilities[SummonFuLocals.SUMMONFU_TEXT_HEALTHSTONE];
			dewdrop:AddLine(
				'text', SummonFuLocals.SUMMONFU_TEXT_HEALTHSTONE,
				'func', function() CastSpell(p, "spell") end
			)
		elseif (stone_Abilities[SummonFuLocals.SUMMONFU_TEXT_HEALTHSTONEL] > 0) then
			local p = stone_Abilities[SummonFuLocals.SUMMONFU_TEXT_HEALTHSTONEL];
			dewdrop:AddLine(
				'text', SummonFuLocals.SUMMONFU_TEXT_HEALTHSTONEL,
				'func', function() CastSpell(p, "spell") end
			)
		elseif (stone_Abilities[SummonFuLocals.SUMMONFU_TEXT_HEALTHSTONEMIN] > 0) then
			local p = stone_Abilities[SummonFuLocals.SUMMONFU_TEXT_HEALTHSTONEMIN];
			dewdrop:AddLine(
				'text', SummonFuLocals.SUMMONFU_TEXT_HEALTHSTONEMIN,
				'func', function() CastSpell(p, "spell") end
			)
		end
		
		if (stone_Abilities[SummonFuLocals.SUMMONFU_TEXT_SOULSTONEM] > 0) then
			local p = stone_Abilities[SummonFuLocals.SUMMONFU_TEXT_SOULSTONEM];
			dewdrop:AddLine(
				'text', SummonFuLocals.SUMMONFU_TEXT_SOULSTONEM,
				'func', function() CastSpell(p, "spell") end
			)
		elseif (stone_Abilities[SummonFuLocals.SUMMONFU_TEXT_SOULSTONEG] > 0) then
			local p = stone_Abilities[SummonFuLocals.SUMMONFU_TEXT_SOULSTONEG];
			dewdrop:AddLine(
				'text', SummonFuLocals.SUMMONFU_TEXT_SOULSTONEG,
				'func', function() CastSpell(p, "spell") end
			)
		elseif (stone_Abilities[SummonFuLocals.SUMMONFU_TEXT_SOULSTONE] > 0) then
			local p = stone_Abilities[SummonFuLocals.SUMMONFU_TEXT_SOULSTONE];
			dewdrop:AddLine(
				'text', SummonFuLocals.SUMMONFU_TEXT_SOULSTONE,
				'func', function() CastSpell(p, "spell") end
			)
		elseif (stone_Abilities[SummonFuLocals.SUMMONFU_TEXT_SOULSTONEL] > 0) then
			local p = stone_Abilities[SummonFuLocals.SUMMONFU_TEXT_SOULSTONEL];
			dewdrop:AddLine(
				'text', SummonFuLocals.SUMMONFU_TEXT_SOULSTONEL,
				'func', function() CastSpell(p, "spell") end
			)
		elseif (stone_Abilities[SummonFuLocals.SUMMONFU_TEXT_SOULSTONEMIN] > 0) then
			local p = stone_Abilities[SummonFuLocals.SUMMONFU_TEXT_SOULSTONEMIN];
			dewdrop:AddLine(
				'text', SummonFuLocals.SUMMONFU_TEXT_SOULSTONEMIN,
				'func', function() CastSpell(p, "spell") end
			)
		end
		
		if (stone_Abilities[SummonFuLocals.SUMMONFU_TEXT_FIRESTONEM] > 0) then
			local p = stone_Abilities[SummonFuLocals.SUMMONFU_TEXT_FIRESTONEM];
			dewdrop:AddLine(
				'text', SummonFuLocals.SUMMONFU_TEXT_FIRESTONEM,
				'func', function() CastSpell(p, "spell") end
			)
		elseif (stone_Abilities[SummonFuLocals.SUMMONFU_TEXT_FIRESTONEG] > 0) then
			local p = stone_Abilities[SummonFuLocals.SUMMONFU_TEXT_FIRESTONEG];
			dewdrop:AddLine(
				'text', SummonFuLocals.SUMMONFU_TEXT_FIRESTONEG,
				'func', function() CastSpell(p, "spell") end
			)
		elseif (stone_Abilities[SummonFuLocals.SUMMONFU_TEXT_FIRESTONE] > 0) then
			local p = stone_Abilities[SummonFuLocals.SUMMONFU_TEXT_FIRESTONE];
			dewdrop:AddLine(
				'text', SummonFuLocals.SUMMONFU_TEXT_FIRESTONE,
				'func', function() CastSpell(p, "spell") end
			)
		elseif (stone_Abilities[SummonFuLocals.SUMMONFU_TEXT_FIRESTONEL] > 0) then
			local p = stone_Abilities[SummonFuLocals.SUMMONFU_TEXT_FIRESTONEL];
			dewdrop:AddLine(
				'text', SummonFuLocals.SUMMONFU_TEXT_FIRESTONEL,
				'func', function() CastSpell(p, "spell") end
			)
		end
		
		if (stone_Abilities[SummonFuLocals.SUMMONFU_TEXT_SPELLSTONEM] > 0) then
			local p = stone_Abilities[SummonFuLocals.SUMMONFU_TEXT_SPELLSTONEM];
			dewdrop:AddLine(
				'text', SummonFuLocals.SUMMONFU_TEXT_SPELLSTONEM,
				'func', function() CastSpell(p, "spell") end
			)
		elseif (stone_Abilities[SummonFuLocals.SUMMONFU_TEXT_SPELLSTONEG] > 0) then
			local p = stone_Abilities[SummonFuLocals.SUMMONFU_TEXT_SPELLSTONEG];
			dewdrop:AddLine(
				'text', SummonFuLocals.SUMMONFU_TEXT_SPELLSTONEG,
				'func', function() CastSpell(p, "spell") end
			)
		elseif (stone_Abilities[SummonFuLocals.SUMMONFU_TEXT_SPELLSTONE] > 0) then
			local p = stone_Abilities[SummonFuLocals.SUMMONFU_TEXT_SPELLSTONE];
			dewdrop:AddLine(
				'text', SummonFuLocals.SUMMONFU_TEXT_SPELLSTONE,
				'func', function() CastSpell(p, "spell") end
			)
		end
	end
end

SummonFu:RegisterForLoad()

local selearn = AceLibrary("SpecialEvents-LearnSpell-2.0")
local tablet = AceLibrary("Tablet-2.0")
local dewdrop = AceLibrary("Dewdrop-2.0")
local BS = AceLibrary("Babble-Spell-2.0")

local core, mybuff = FuBar_CorkFu, -1
local defaultspell = BS["Find Herbs"]
local icons, spells = {}, {
	[BS["Find Herbs"]]       = "Interface\\Icons\\INV_Misc_Flower_02",
	[BS["Find Minerals"]]    = "Interface\\Icons\\Spell_Nature_Earthquake",
	[BS["Find Treasure"]]    = "Interface\\Icons\\Racial_Dwarf_FindTreasure",
	[BS["Track Beasts"]]     = "Interface\\Icons\\Ability_Tracking",
	[BS["Track Humanoids"]]  = "Interface\\Icons\\Spell_Holy_PrayerOfHealing",
	[BS["Track Hidden"]]     = "Interface\\Icons\\Ability_Stealth",
	[BS["Track Elementals"]] = "Interface\\Icons\\Spell_Frost_SummonWaterElemental",
	[BS["Track Undead"]]     = "Interface\\Icons\\Spell_Shadow_DarkSummoning",
	[BS["Track Demons"]]     = "Interface\\Icons\\Spell_Shadow_SummonFelHunter",
	[BS["Track Giants"]]     = "Interface\\Icons\\Ability_Racial_Avatar",
	[BS["Track Dragonkin"]]  = "Interface\\Icons\\INV_Misc_Head_Dragon_01",
	[BS["Sense Undead"]]     = "Interface\\Icons\\Spell_Holy_SenseUndead",
	[BS["Sense Demons"]]     = "Interface\\Icons\\Spell_Shadow_Metamorphosis",
}
for i,v in pairs(spells) do icons[v] = i end


local track = core:NewModule("Tracking")
track.target = "Custom"


function track:OnEnable()
	for i in pairs(spells) do if selearn:SpellKnown(i) then defaultspell = i end end

	self:RegisterEvent("CorkFu_Rescan")
	self:RegisterEvent("PLAYER_AURAS_CHANGED")
	self:PLAYER_AURAS_CHANGED()
end


----------------------------
--      Cork Methods      --
----------------------------

function track:ItemValid()
	for i in pairs(spells) do
		if selearn:SpellKnown(i) then return true end
	end
end


function track:UnitValid(unit)
	return unit == "player"
end


function track:GetIcon()
	local filter = self.db.char["Filter Everyone"]
	return filter and spells[filter] or defaultspell and spells[defaultspell]
end


function track:GetTopItem()
	if not self:ItemValid() or mybuff or self.db.char["Filter Everyone"] == -1 then return end

	local spell = self.db.char["Filter Everyone"] or defaultspell
	return spells[spell], spell
end


function track:PutACorkInIt()
	local _, spell = self:GetTopItem()
	if not spell then return end
	CastSpellByName(spell)
	return true
end


function track:OnTooltipUpdate()
	if not self:ItemValid() or mybuff or self.db.char["Filter Everyone"] == -1 then return end

	local spell = self.db.char["Filter Everyone"] or defaultspell
	local cat = tablet:AddCategory("hideBlankLine", true)
	cat:AddLine("text", spell, "hasCheck", true, "checked", true, "checkIcon", spells[spell],
		"func", self.PutACorkInIt, "arg1", self)
end


function track:OnMenuRequest()
	local val = self.db.char["Filter Everyone"] or defaultspell

	dewdrop:AddLine("text", core.loc.disabled, "func", self.SetFilter, "isRadio", true, "checked", val == -1, "arg1", self,
		"arg2", "Everyone", "arg3", -1, "arg4", "char")
	for v in pairs(spells) do
		if selearn:SpellKnown(v) then
			dewdrop:AddLine("text", v, "func", self.SetFilter, "isRadio", true, "checked", val == v,
				"arg1", self, "arg2", "Everyone", "arg3", v, "arg4", "char")
		end
	end
end


------------------------------
--      Event Handlers      --
------------------------------


function track:CorkFu_Rescan(spell)
	if spells[spell] or spell == "All" then self:PLAYER_AURAS_CHANGED() end
end


function track:PLAYER_AURAS_CHANGED()
	local x = GetTrackingTexture()
	local tex = x and icons[x]
	if tex == mybuff then return end

	mybuff = tex
	self:TriggerEvent("CorkFu_Update")
end



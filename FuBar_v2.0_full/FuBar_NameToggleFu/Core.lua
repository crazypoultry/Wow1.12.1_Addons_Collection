FuBar_NameToggle = AceLibrary("AceAddon-2.0"):new("FuBarPlugin-2.0", "AceDB-2.0")
FuBar_NameToggle:RegisterDB("FuBar_NameToggleDB")
FuBar_NameToggle.hasIcon = "Interface\\Icons\\Ability_Hunter_Pathfinding"
FuBar_NameToggle.clickableTooltip = true

local tablet = AceLibrary("Tablet-2.0")
local dewdrop = AceLibrary("Dewdrop-2.0")
local L = AceLibrary("AceLocale-2.0"):new("FuBar_NameToggleFu")
L:RegisterTranslations("enUS", function()
	return {
		["menupnames"] = "Show player names",
		["menupguild"] = "Show player guilds",
		["menuptitle"] = "Show player titles",
		["menunpcnames"] = "Show NPC names",
		["menunpcplates"] = "Show NPC nameplates",

		["tipshown"] = "|cff00ff00Shown",
		["tiphidden"] = "|cffff0000Hidden",
		["tipplayers"] = "Players",
		["tipnpcs"] = "NPCs",
		["tipnames"] = "Names:",
		["tipguild"] = "Guilds:",
		["tiptitle"] = "Titles:",
		["tipplates"] = "Nameplates:",

		["hint"] = "Click to toggle player names.\nHint: Shift-Click to toggle NPC names.",
	}
end)

function FuBar_NameToggle:OnTooltipUpdate()
	local cat = tablet:AddCategory("text", L["tipplayers"], "columns", 2)
	cat:AddLine(
		"text", L["tipnames"],
		"text2", GetCVar("UnitNamePlayer") == "1" and L["tipshown"] or L["tiphidden"],
		"func", "ToggleCVar",
		"arg1", self,
		"arg2", "UnitNamePlayer"
	)
	cat:AddLine(
		"text", L["tipguild"],
		"text2", GetCVar("UnitNamePlayerGuild") == "1" and L["tipshown"] or L["tiphidden"],
		"func", "ToggleCVar",
		"arg1", self,
		"arg2", "UnitNamePlayerGuild"
	)
	cat:AddLine(
		"text", L["tiptitle"],
		"text2", GetCVar("UnitNamePlayerPVPTitle") == "1" and L["tipshown"] or L["tiphidden"],
		"func", "ToggleCVar",
		"arg1", self,
		"arg2", "UnitNamePlayerPVPTitle"
	)

	cat = tablet:AddCategory("text", L["tipnpcs"], "columns", 2)
	cat:AddLine(
		"text", L["tipnames"],
		"text2", GetCVar("UnitNameNPC") == "1" and L["tipshown"] or L["tiphidden"],
		"func", "ToggleCVar",
		"arg1", self,
		"arg2", "UnitNameNPC"
	)
	cat:AddLine(
		"text", L["tipplates"],
		"text2", NAMEPLATES_ON and L["tipshown"] or L["tiphidden"],
		"func", "ToggleNamePlates",
		"arg1", self
	)

	tablet:SetHint(L["hint"])
end


function FuBar_NameToggle:ToggleCVar(var)
	SetCVar(var, GetCVar(var) == "1" and 0 or 1)
end

function FuBar_NameToggle:ToggleNamePlates()
	if NAMEPLATES_ON then
		HideNameplates()
		NAMEPLATES_ON = nil
	else
		ShowNameplates()
		NAMEPLATES_ON = 1
	end
end

function FuBar_NameToggle:ToggleClickable()
	if self.db.profile.clickableTooltip then
		self.clickableTooltip = false
		self.db.profile.clickableTooltip = false
	else
		self.clickableTooltip = true
		self.db.profile.clickableTooltip = true
	end
end

function FuBar_NameToggle:OnClick()
	if not IsShiftKeyDown() then
		self:ToggleCVar("UnitNamePlayer")
	else
		self:ToggleCVar("UnitNameNPC")
	end
end

function FuBar_NameToggle:OnMenuRequest()
	dewdrop:AddLine(
		"text", L["menupnames"],
		"func", "ToggleCVar",
		"arg1", self,
		"arg2", "UnitNamePlayer",
		"checked", GetCVar("UnitNamePlayer") == "1",
		"keepShownOnClick", true
	)
	dewdrop:AddLine(
		"text", L["menupguild"],
		"func", "ToggleCVar",
		"arg1", self,
		"arg2", "UnitNamePlayerGuild",
		"checked", GetCVar("UnitNamePlayerGuild") == "1",
		"keepShownOnClick", true
	)
	dewdrop:AddLine(
		"text", L["menuptitle"],
		"func", "ToggleCVar",
		"arg1", self,
		"arg2", "UnitNamePlayerPVPTitle",
		"checked", GetCVar("UnitNamePlayerPVPTitle") == "1",
		"keepShownOnClick", true
	)

	dewdrop:AddLine()

	dewdrop:AddLine(
		"text", L["menunpcnames"],
		"func", "ToggleCVar",
		"arg1", self,
		"arg2", "UnitNameNPC",
		"checked", GetCVar("UnitNameNPC") == "1",
		"keepShownOnClick", true
	)
	dewdrop:AddLine(
		"text", L["menunpcplates"],
		"func", "ToggleNamePlates",
		"arg1", self,
		"checked", NAMEPLATES_ON,
		"keepShownOnClick", true
	)
end

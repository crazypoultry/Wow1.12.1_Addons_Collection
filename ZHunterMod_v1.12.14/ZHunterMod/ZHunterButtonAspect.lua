ZHunterMod_Saved["ZHunterButtonAspect"] = {}
ZHunterMod_Saved["ZHunterButtonAspect"]["spells"] = {1, 2, 3, 4, 5, 6}
ZHunterMod_Saved["ZHunterButtonAspect"]["rows"] = 1
ZHunterMod_Saved["ZHunterButtonAspect"]["count"] = 6
ZHunterMod_Saved["ZHunterButtonAspect"]["horizontal"] = nil
ZHunterMod_Saved["ZHunterButtonAspect"]["vertical"] = nil
ZHunterMod_Saved["ZHunterButtonAspect"]["firstbutton"] = "RIGHT"
ZHunterMod_Saved["ZHunterButtonAspect"]["tooltip"] = 1
ZHunterMod_Saved["ZHunterButtonAspect"]["parent"] = {}
ZHunterMod_Saved["ZHunterButtonAspect"]["parent"]["size"] = 36
ZHunterMod_Saved["ZHunterButtonAspect"]["parent"]["hide"] = nil
ZHunterMod_Saved["ZHunterButtonAspect"]["parent"]["circle"] = 1
ZHunterMod_Saved["ZHunterButtonAspect"]["children"] = {}
ZHunterMod_Saved["ZHunterButtonAspect"]["children"]["size"] = 36
ZHunterMod_Saved["ZHunterButtonAspect"]["children"]["hideonclick"] = 1

ZHunterMod_Aspect_Spells = {
	ZHUNTER_ASPECT_HAWK,
	ZHUNTER_ASPECT_MONKEY,
	ZHUNTER_ASPECT_CHEETAH,
	ZHUNTER_ASPECT_WILD,
	ZHUNTER_ASPECT_BEAST,
	ZHUNTER_ASPECT_PACK
}

function ZHunterButtonAspect_OnLoad()
	this:RegisterEvent("VARIABLES_LOADED")
end

function ZHunterButtonAspect_OnEvent()
	if event == "VARIABLES_LOADED" then
		if UnitClass("player") ~= ZHUNTER_HUNTER then
			ZHunterButtonAspect:UnregisterAllEvents()
			ZHunterButtonAspect:Hide()
			return
		end
		ZHunterButtonAspect_CreateButtons()
		ZHunterButtonAspect.options = ZHunterButtonAspectOptions
		ZHunterButtonAspectAdjustment = CreateFrame("Frame", "ZHunterButtonAspectAdjustment")
		ZHunterButtonAspectAdjustment:RegisterEvent("PLAYER_AURAS_CHANGED")
		ZHunterButtonAspectAdjustment:RegisterEvent("PLAYER_ENTERING_WORLD")
		ZHunterButtonAspectAdjustment:SetScript("OnEvent", ZHunterButtonAspectAdjustment_OnEvent)
		ZHunterButtonAspect_Tooltip = CreateFrame("GameTooltip", "ZHunterButtonAspect_Tooltip", nil, "GameTooltipTemplate")
		ZHunterButtonAspect_SetupOptions()
		ZHunterButtonAspect_SetupSizeAndPosition()
	end
end

function ZHunterButtonAspect_CreateButtons()
	ZSpellButton_CreateChildren(ZHunterButtonAspect, "ZHunterButtonAspect", 6)
	local info = {}
	for i=1, table.getn(ZHunterMod_Aspect_Spells) do
		if not tonumber(ZHunterMod_Saved["ZHunterButtonAspect"]["spells"][i]) then
			info = ZHunterMod_Aspect_Spells
			ZHunterMod_Saved["ZHunterButtonAspect"]["spells"] = {1, 2, 3, 4, 5, 6}
			break
		end
		info[i] = ZHunterMod_Aspect_Spells[ZHunterMod_Saved["ZHunterButtonAspect"]["spells"][i]]
	end
	ZHunterButtonAspect.found = ZSpellButton_SetButtons(ZHunterButtonAspect, info)
	if ZHunterButtonAspect.found > 0 and ZHunterButtonAspect.found < ZHunterMod_Saved["ZHunterButtonAspect"]["count"] then
		ZHunterMod_Saved["ZHunterButtonAspect"]["count"] = ZHunterButtonAspect.found
	end
end

function ZHunterButtonAspect_SetupSizeAndPosition()
	ZSpellButton_SetSize(ZHunterButtonAspect, ZHunterMod_Saved["ZHunterButtonAspect"]["parent"]["size"])
	ZSpellButton_SetSize(ZHunterButtonAspect, ZHunterMod_Saved["ZHunterButtonAspect"]["children"]["size"], 1)
	ZSpellButton_SetExpandDirection(ZHunterButtonAspect, ZHunterMod_Saved["ZHunterButtonAspect"]["firstbutton"])
	ZSpellButton_ArrangeChildren(ZHunterButtonAspect, ZHunterMod_Saved["ZHunterButtonAspect"]["rows"], 
		ZHunterMod_Saved["ZHunterButtonAspect"]["count"], ZHunterMod_Saved["ZHunterButtonAspect"]["horizontal"],
		ZHunterMod_Saved["ZHunterButtonAspect"]["vertical"])
end

function ZHunterButtonAspect_Reset()
	ZHunterMod_Saved["ZHunterButtonAspect"] = {}
	ZHunterMod_Saved["ZHunterButtonAspect"]["spells"] = {1, 2, 3, 4, 5, 6}
	ZHunterMod_Saved["ZHunterButtonAspect"]["rows"] = 1
	ZHunterMod_Saved["ZHunterButtonAspect"]["count"] = 6
	ZHunterMod_Saved["ZHunterButtonAspect"]["horizontal"] = nil
	ZHunterMod_Saved["ZHunterButtonAspect"]["vertical"] = nil
	ZHunterMod_Saved["ZHunterButtonAspect"]["firstbutton"] = "RIGHT"
	ZHunterMod_Saved["ZHunterButtonAspect"]["tooltip"] = 1
	ZHunterMod_Saved["ZHunterButtonAspect"]["parent"] = {}
	ZHunterMod_Saved["ZHunterButtonAspect"]["parent"]["size"] = 36
	ZHunterMod_Saved["ZHunterButtonAspect"]["parent"]["hide"] = nil
	ZHunterMod_Saved["ZHunterButtonAspect"]["parent"]["circle"] = 1
	ZHunterMod_Saved["ZHunterButtonAspect"]["children"] = {}
	ZHunterMod_Saved["ZHunterButtonAspect"]["children"]["size"] = 36
	ZHunterMod_Saved["ZHunterButtonAspect"]["children"]["hideonclick"] = 1
end

function ZHunterButtonAspectAdjustment_OnEvent()
	if event == "PLAYER_AURAS_CHANGED" or event == "PLAYER_ENTERING_WORLD" then
		if not ZHunterButtonAspect1.id then
			return
		end
		local buttontextures = {}
		local button
		for i=1, ZHunterButtonAspect.count do
			button = getglobal(ZHunterButtonAspect.name..i)
			button.icon = nil
			if button.id then
				buttontextures[GetSpellTexture(button.id, "spell")] = button
			end
		end
		local i = 1
		local texture = GetSpellTexture(ZHunterButtonAspect1.id, "spell")
		local buff = UnitBuff("player", i)
		local spellname, buffname
		ZHunterButtonAspect.id = ZHunterButtonAspect1.id
		while buff do
			if texture == buff and ZHunterButtonAspect2.id then
				ZHunterButtonAspect.id = ZHunterButtonAspect2.id
			end
			if buttontextures[buff] then
				ZHunterButtonAspect_Tooltip:SetOwner(this, "ANCHOR_NONE")
				ZHunterButtonAspect_Tooltip:SetUnitBuff("player", i)
				buffname = ZHunterButtonAspect_TooltipTextLeft1:GetText()
				spellname = GetSpellName(buttontextures[buff].id, "spell")
				if buffname == spellname then
					buttontextures[buff].icon = "Interface\\Icons\\Spell_Nature_WispSplode"
				end
			end
			i = i + 1
			buff = UnitBuff("player", i)
		end
		ZSpellButton_UpdateButton(ZHunterButtonAspect)
		ZSpellButton_UpdateCooldown(ZHunterButtonAspect)
		for i=1, ZHunterButtonAspect.count do
			button = getglobal(ZHunterButtonAspect.name..i)
			if button.id then
				ZSpellButton_UpdateButton(button)
			end
		end
		if GameTooltip:IsOwned(ZHunterButtonAspect) then
			ZSpellButtonParent_OnEnter(ZHunterButtonAspect)
		end
	end
end

function ZHunterButtonAspect_KeyBinding(index)
	local button
	if index then
		button = getglobal("ZHunterButtonAspect"..index)
	else
		button = ZHunterButtonAspect
	end
	if button.id then
		CastSpell(button.id, "spell")
		if ZHunterButtonAspect.hideonclick then
			ZHunterButtonAspect.children:Hide()
		end
	end
end

SLASH_ZHunterButtonAspect1 = "/ZAspect"
SlashCmdList["ZHunterButtonAspect"] = function(msg)
	if msg == "reset" then
		ZHunterButtonAspect_Reset()
		ZHunterButtonAspect:ClearAllPoints()
		ZHunterButtonAspect:SetPoint("CENTER", UIParent, "CENTER", -60, 0)
	elseif msg == "options" then
		ZHunterButtonAspect.options:Show()
	else
		DEFAULT_CHAT_FRAME:AddMessage("Possible Commands: \"options\", \"reset\"", 0, 1, 1)
	end
end
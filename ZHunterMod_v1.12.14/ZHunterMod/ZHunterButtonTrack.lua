ZHunterMod_Saved["ZHunterButtonTrack"] = {}
ZHunterMod_Saved["ZHunterButtonTrack"]["spells"] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11}
ZHunterMod_Saved["ZHunterButtonTrack"]["rows"] = 1
ZHunterMod_Saved["ZHunterButtonTrack"]["count"] = 11
ZHunterMod_Saved["ZHunterButtonTrack"]["horizontal"] = nil
ZHunterMod_Saved["ZHunterButtonTrack"]["vertical"] = nil
ZHunterMod_Saved["ZHunterButtonTrack"]["firstbutton"] = "RIGHT"
ZHunterMod_Saved["ZHunterButtonTrack"]["tooltip"] = 1
ZHunterMod_Saved["ZHunterButtonTrack"]["parent"] = {}
ZHunterMod_Saved["ZHunterButtonTrack"]["parent"]["size"] = 36
ZHunterMod_Saved["ZHunterButtonTrack"]["parent"]["hide"] = nil
ZHunterMod_Saved["ZHunterButtonTrack"]["parent"]["circle"] = 1
ZHunterMod_Saved["ZHunterButtonTrack"]["children"] = {}
ZHunterMod_Saved["ZHunterButtonTrack"]["children"]["size"] = 36
ZHunterMod_Saved["ZHunterButtonTrack"]["children"]["hideonclick"] = 1

ZHunterMod_Track_Spells = {
	ZHUNTER_TRACK_HIDDEN,
	ZHUNTER_TRACK_HUMANOIDS,
	ZHUNTER_TRACK_UNDEAD,
	ZHUNTER_TRACK_BEASTS,
	ZHUNTER_TRACK_DEMONS,
	ZHUNTER_TRACK_ELEMENTALS,
	ZHUNTER_TRACK_DRAGONKIN,
	ZHUNTER_TRACK_GIANTS,
	ZHUNTER_TRACK_MINERALS,
	ZHUNTER_TRACK_HERBS,
	ZHUNTER_TRACK_TREASURE
}

function ZHunterButtonTrack_OnLoad()
	this:RegisterEvent("VARIABLES_LOADED")
end

function ZHunterButtonTrack_OnEvent()
	if event == "VARIABLES_LOADED" then
		if UnitClass("player") ~= ZHUNTER_HUNTER then
			ZHunterButtonTrack:UnregisterAllEvents()
			ZHunterButtonTrack:Hide()
			return
		end
		ZHunterButtonTrack_CreateButtons()
		ZHunterButtonTrack.options = ZHunterButtonTrackOptions
		ZHunterButtonTrackAdjustment = CreateFrame("Frame", "ZHunterButtonTrackAdjustment")
		ZHunterButtonTrackAdjustment:RegisterEvent("PLAYER_AURAS_CHANGED")
		ZHunterButtonTrackAdjustment:RegisterEvent("PLAYER_ENTERING_WORLD")
		ZHunterButtonTrackAdjustment:SetScript("OnEvent", ZHunterButtonTrackAdjustment_OnEvent)
		ZHunterButtonTrack_SetupOptions()
		ZHunterButtonTrack_SetupSizeAndPosition()
	end
end

function ZHunterButtonTrack_CreateButtons()
	ZSpellButton_CreateChildren(ZHunterButtonTrack, "ZHunterButtonTrack", 11)
	local info = {}
	for i=1, table.getn(ZHunterMod_Track_Spells) do
		if not tonumber(ZHunterMod_Saved["ZHunterButtonTrack"]["spells"][i]) then
			info = ZHunterMod_Track_Spells
			ZHunterMod_Saved["ZHunterButtonTrack"]["spells"] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11}
			break
		end
		info[i] = ZHunterMod_Track_Spells[ZHunterMod_Saved["ZHunterButtonTrack"]["spells"][i]]
	end
	ZHunterButtonTrack.found = ZSpellButton_SetButtons(ZHunterButtonTrack, info)
	if ZHunterButtonTrack.found > 0 and ZHunterButtonTrack.found < ZHunterMod_Saved["ZHunterButtonTrack"]["count"] then
		ZHunterMod_Saved["ZHunterButtonTrack"]["count"] = ZHunterButtonTrack.found
	end
end

function ZHunterButtonTrack_SetupSizeAndPosition()
	ZSpellButton_SetSize(ZHunterButtonTrack, ZHunterMod_Saved["ZHunterButtonTrack"]["parent"]["size"])
	ZSpellButton_SetSize(ZHunterButtonTrack, ZHunterMod_Saved["ZHunterButtonTrack"]["children"]["size"], 1)
	ZSpellButton_SetExpandDirection(ZHunterButtonTrack, ZHunterMod_Saved["ZHunterButtonTrack"]["firstbutton"])
	ZSpellButton_ArrangeChildren(ZHunterButtonTrack, ZHunterMod_Saved["ZHunterButtonTrack"]["rows"], 
		ZHunterMod_Saved["ZHunterButtonTrack"]["count"], ZHunterMod_Saved["ZHunterButtonTrack"]["horizontal"],
		ZHunterMod_Saved["ZHunterButtonTrack"]["vertical"])
end

function ZHunterButtonTrack_Reset()
	ZHunterMod_Saved["ZHunterButtonTrack"] = {}
	ZHunterMod_Saved["ZHunterButtonTrack"]["spells"] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11}
	ZHunterMod_Saved["ZHunterButtonTrack"]["rows"] = 1
	ZHunterMod_Saved["ZHunterButtonTrack"]["count"] = 11
	ZHunterMod_Saved["ZHunterButtonTrack"]["horizontal"] = nil
	ZHunterMod_Saved["ZHunterButtonTrack"]["vertical"] = nil
	ZHunterMod_Saved["ZHunterButtonTrack"]["firstbutton"] = "RIGHT"
	ZHunterMod_Saved["ZHunterButtonTrack"]["tooltip"] = 1
	ZHunterMod_Saved["ZHunterButtonTrack"]["parent"] = {}
	ZHunterMod_Saved["ZHunterButtonTrack"]["parent"]["size"] = 36
	ZHunterMod_Saved["ZHunterButtonTrack"]["parent"]["hide"] = nil
	ZHunterMod_Saved["ZHunterButtonTrack"]["parent"]["circle"] = 1
	ZHunterMod_Saved["ZHunterButtonTrack"]["children"] = {}
	ZHunterMod_Saved["ZHunterButtonTrack"]["children"]["size"] = 36
	ZHunterMod_Saved["ZHunterButtonTrack"]["children"]["hideonclick"] = 1
end

function ZHunterButtonTrackAdjustment_OnEvent()
	if event == "PLAYER_AURAS_CHANGED" or event == "PLAYER_ENTERING_WORLD" then
		local i = 1
		local texture = ZHunterButtonTrack1IconTexture:GetTexture()
		local buff = GetTrackingTexture()
		if texture == buff and ZHunterButtonTrack2.id then
			ZHunterButtonTrack.id = ZHunterButtonTrack2.id
		else
			ZHunterButtonTrack.id = ZHunterButtonTrack1.id			
		end
		ZSpellButton_UpdateButton(ZHunterButtonTrack)
		ZSpellButton_UpdateCooldown(ZHunterButtonTrack)
		if GameTooltip:IsOwned(ZHunterButtonTrack) then
			ZSpellButtonParent_OnEnter(ZHunterButtonTrack)
		end
	end
end

function ZHunterButtonTrack_KeyBinding(index)
	local button
	if index then
		button = getglobal("ZHunterButtonTrack"..index)
	else
		button = ZHunterButtonTrack
	end
	if button.id then
		CastSpell(button.id, "spell")
		if ZHunterButtonTrack.hideonclick then
			ZHunterButtonTrack.children:Hide()
		end
	end
end

SLASH_ZHunterButtonTrack1 = "/ZTrack"
SlashCmdList["ZHunterButtonTrack"] = function(msg)
	if msg == "reset" then
		ZHunterButtonTrack_Reset()
		ZHunterButtonTrack:ClearAllPoints()
		ZHunterButtonTrack:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
	elseif msg == "options" then
		ZHunterButtonTrack.options:Show()
	else
		DEFAULT_CHAT_FRAME:AddMessage("Possible Commands: \"options\", \"reset\"", 0, 1, 1)
	end
end
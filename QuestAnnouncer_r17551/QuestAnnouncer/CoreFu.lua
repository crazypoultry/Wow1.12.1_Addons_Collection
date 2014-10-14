if not QuestAnnouncer then
	return
end

local L = AceLibrary("AceLocale-2.2"):new("QuestAnnouncer")
local tablet = AceLibrary("Tablet-2.0")

QuestAnnouncerFu = AceLibrary("AceAddon-2.0"):new("FuBarPlugin-2.0")
QuestAnnouncerFu.hasNoColor = true
QuestAnnouncerFu.hasNoText = true
QuestAnnouncerFu.cannotDetachTooltip = true
QuestAnnouncerFu.hasIcon = true

QuestAnnouncerFu.OnMenuRequest = {
	type = 'group',
	args = {
		debug = {
			type = 'toggle',
			name = L["OPT_SHOWDEBUG_NAME"],
			desc = L["OPT_SHOWDEBUG_DESC"],
			get = "IsShowDebug",
			set = "ToggleShowDebug",
		},
		announce = {
			type = 'text',
			name = L["OPT_ANNOUNCE_NAME"],
			desc = L["OPT_ANNOUNCE_DESC"],
			get = "GetAnnounceType",
			set = "SetAnnounceType",
			validate = { "addon", "chat", "both", "none" },
		},
		display = {
			type = 'text',
			name = L["OPT_DISPLAY_NAME"],
			desc = L["OPT_DISPLAY_DESC"],
			get = "GetDisplayType",
			set = "SetDisplayType",
			validate = { "ui", "chat", "both", "none" },
		},
	},
}

function QuestAnnouncerFu:OnTooltipUpdate()
	local cat = tablet:AddCategory("columns", 1)
	if QuestAnnouncer:IsShowDebug() then
		cat:AddLine("text", L["OPT_SHOWDEBUG_ON"])
	else
		cat:AddLine("text", L["OPT_SHOWDEBUG_OFF"])
	end
	if QuestAnnouncer:GetAnnounceType() == "addon" then
		cat:AddLine("text", L["OPT_ANNOUNCE_ADDON"])
	elseif QuestAnnouncer:GetAnnounceType() == "chat" then
		cat:AddLine("text", L["OPT_ANNOUNCE_CHAT"])
	elseif QuestAnnouncer:GetAnnounceType() == "both" then
		cat:AddLine("text", L["OPT_ANNOUNCE_BOTH"])
	elseif QuestAnnouncer:GetAnnounceType() == "none" then
		cat:AddLine("text", L["OPT_ANNOUNCE_NONE"])
	end
	if QuestAnnouncer:GetDisplayType() == "ui" then
		cat:AddLine("text", L["OPT_DISPLAY_UI"])
	elseif QuestAnnouncer:GetDisplayType() == "chat" then
		cat:AddLine("text", L["OPT_DISPLAY_CHAT"])
	elseif QuestAnnouncer:GetDisplayType() == "both" then
		cat:AddLine("text", L["OPT_DISPLAY_BOTH"])
	elseif QuestAnnouncer:GetDisplayType() == "none" then
		cat:AddLine("text", L["OPT_DISPLAY_NONE"])
	end
	tablet:SetHint(L["FUBAR_TOOLTIP_HINT"])
end

function QuestAnnouncerFu:IsShowDebug()
	return QuestAnnouncer:IsShowDebug()
end

function QuestAnnouncerFu:ToggleShowDebug()
	QuestAnnouncer:ToggleShowDebug()
end

function QuestAnnouncerFu:GetAnnounceType()
	return QuestAnnouncer:GetAnnounceType()
end

function QuestAnnouncerFu:SetAnnounceType(name)
	QuestAnnouncer:SetAnnounceType(name)
end

function QuestAnnouncerFu:GetDisplayType()
	return QuestAnnouncer:GetDisplayType()
end

function QuestAnnouncerFu:SetDisplayType(name)
	QuestAnnouncer:SetDisplayType(name)
end

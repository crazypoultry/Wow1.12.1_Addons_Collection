local L = AceLibrary("AceLocale-2.2"):new("QuestAnnouncer")

local options = {
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

QuestAnnouncer = AceLibrary("AceAddon-2.0"):new("AceConsole-2.0", "AceEvent-2.0", "AceDB-2.0" )
QuestAnnouncer:RegisterChatCommand( {L["SLASHCMD_LONG"], L["SLASHCMD_SHORT"]}, options )
QuestAnnouncer:RegisterDB( "QuestAnnouncerDB", "QuestAnnouncerDBPC" )
QuestAnnouncer:RegisterDefaults( "profile", {
	showDebug = false,
	announcet = "addon",
	displayt = "both",
} )

function QuestAnnouncer:OnEnable()
	self:RegisterEvent("CHAT_MSG_ADDON")
	self:RegisterEvent("UI_INFO_MESSAGE")
end

function QuestAnnouncer:CHAT_MSG_ADDON( prefix, message, mode, sender )
	if (prefix == L["ADDON_PREFIX"]) and (message ~= nil) and (mode == "PARTY") and (sender ~= UnitName("player")) then
		if (self:GetDisplayType() == "ui") or (self:GetDisplayType() == "both") then
			UIErrorsFrame:AddMessage(sender..": "..message,0.75,1.0,0.5,1.0,UIERRORS_HOLD_TIME)
		end
		if (self:GetDisplayType() == "chat") or (self:GetDisplayType() == "both") then
			self:Print(sender..": "..message)
		end
	end
end

function QuestAnnouncer:UI_INFO_MESSAGE( message )
	-- does the message fits our schema?
	local questUpdateText = gsub(message,"(.*):%s*([-%d]+)%s*/%s*([-%d]+)%s*$","%1",1)
	if (questUpdateText ~= message) then
		local outmessage
		local ii, jj, strItemName, iNumItems, iNumNeeded = string.find(message, "(.*):%s*([-%d]+)%s*/%s*([-%d]+)%s*$")
		local stillneeded = iNumNeeded-iNumItems
		if stillneeded < 1 then
			outmessage=L["FINMSG"];
			outmessage=string.gsub(outmessage,"$NumItems",iNumItems)
			outmessage=string.gsub(outmessage,"$NumNeeded",iNumNeeded)
			outmessage=string.gsub(outmessage,"$ItemName",strItemName)
			outmessage=string.gsub(outmessage,"$NumLeft",stillneeded)
		end
		if stillneeded > 0 then
			outmessage=L["ADVMSG"]
			outmessage=string.gsub(outmessage,"$NumItems",iNumItems)
			outmessage=string.gsub(outmessage,"$NumNeeded",iNumNeeded)
			outmessage=string.gsub(outmessage,"$ItemName",strItemName)
			outmessage=string.gsub(outmessage,"$NumLeft",stillneeded)
		end
		if self:IsShowDebug() then
			self:Print(outmessage)
		end
		if (GetNumPartyMembers()>0) and (outmessage ~= nil) and ((self:GetAnnounceType() == "chat") or (self:GetAnnounceType() == "both")) then
			SendChatMessage(outmessage, "PARTY")
		end
		if (GetNumPartyMembers()>0) and (outmessage ~= nil) and ((self:GetAnnounceType() == "addon") or (self:GetAnnounceType() == "both")) then
			SendAddonMessage(L["ADDON_PREFIX"], outmessage, "PARTY")
		end
	end
end

function QuestAnnouncer:IsShowDebug()
	return self.db.profile.showDebug
end

function QuestAnnouncer:ToggleShowDebug()
	self.db.profile.showDebug = not self.db.profile.showDebug
	if self.db.profile.showDebug then
		self:Print(L["OPT_SHOWDEBUG_ON"])
	else
		self:Print(L["OPT_SHOWDEBUG_OFF"])
	end
end

function QuestAnnouncer:GetAnnounceType()
	return self.db.profile.announcet
end

function QuestAnnouncer:SetAnnounceType(name)
	self.db.profile.announcet = name
	if name == "addon" then
		self:Print(L["OPT_ANNOUNCE_ADDON"])
	elseif name == "chat" then
		self:Print(L["OPT_ANNOUNCE_CHAT"])
	elseif name == "both" then
		self:Print(L["OPT_ANNOUNCE_BOTH"])
	elseif name == "none" then
		self:Print(L["OPT_ANNOUNCE_NONE"])
	end
end

function QuestAnnouncer:GetDisplayType()
	return self.db.profile.displayt
end

function QuestAnnouncer:SetDisplayType(name)
	self.db.profile.displayt = name
	if name == "ui" then
		self:Print(L["OPT_DISPLAY_UI"])
	elseif name == "chat" then
		self:Print(L["OPT_DISPLAY_CHAT"])
	elseif name == "both" then
		self:Print(L["OPT_DISPLAY_BOTH"])
	elseif name == "none" then
		self:Print(L["OPT_DISPLAY_NONE"])
	end
end


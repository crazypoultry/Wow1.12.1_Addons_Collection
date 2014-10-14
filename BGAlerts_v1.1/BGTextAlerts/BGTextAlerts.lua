ALLIANCE_COLORS = { r = 0.1, g = 0.2, b = 1 };
HORDE_COLORS = { r = 1, g = 0, b = 0 };
NEUTRAL_COLORS = { r = 1, g = 1, b = 0 };

ALLIANCE_ICON = "Interface\\AddOns\\BGTextAlerts\\AllianceTexture.blp";
HORDE_ICON = "Interface\\AddOns\\BGTextAlerts\\HordeTexture.blp";

BGTextAlerts_FlagCarrierName = "";
BGTextAlerts_FlagHealthAnnounced = false;

BGTextAlerts_HasBerserking = false;
BGTextAlerts_HasSpeed = false;
BGTextAlerts_HasRestoration = false;

local CURRENT_PATCH_VERSION = 2.2;
local NEW_VERSION_ALERTS = 0;

function BGTextAlerts_OnLoad()
	
	BGTextAlertsMainFrame:RegisterEvent("CHAT_MSG_BG_SYSTEM_ALLIANCE");
	BGTextAlertsMainFrame:RegisterEvent("CHAT_MSG_BG_SYSTEM_HORDE");
	BGTextAlertsMainFrame:RegisterEvent("CHAT_MSG_BG_SYSTEM_NEUTRAL");
	BGTextAlertsMainFrame:RegisterEvent("CHAT_MSG_BATTLEGROUND");
	BGTextAlertsMainFrame:RegisterEvent("CHAT_MSG_BATTLEGROUND_LEADER");
	BGTextAlertsMainFrame:RegisterEvent("CHAT_MSG_RAID");
	BGTextAlertsMainFrame:RegisterEvent("CHAT_MSG_RAID_LEADER");
	BGTextAlertsMainFrame:RegisterEvent("CHAT_MSG_RAID_WARNING");
	BGTextAlertsMainFrame:RegisterEvent("CHAT_MSG_YELL");
	BGTextAlertsMainFrame:RegisterEvent("CHAT_MSG_MONSTER_YELL");
	BGTextAlertsMainFrame:RegisterEvent("CHAT_MSG_ADDON");
	BGTextAlertsMainFrame:RegisterEvent("CHAT_MSG_GUILD");
	BGTextAlertsMainFrame:RegisterEvent("UNIT_HEALTH");
	BGTextAlertsMainFrame:RegisterEvent("ZONE_CHANGED");
	BGTextAlertsMainFrame:RegisterEvent("RAID_ROSTER_UPDATE");
	BGTextAlertsMainFrame:RegisterEvent("PLAYER_AURAS_CHANGED");
	BGTextAlertsMainFrame:RegisterEvent("VARIABLES_LOADED");
	
	StaticPopupDialogs["BGTEXTALERTS_NEWVERSION"] = {
		text = TEXT("BGTextAlerts Version "  .. CURRENT_PATCH_VERSION .. " installed!"),
		button1 = TEXT("Close"),
		timeout = 60
	};
	
	-- Register for a tab with the BGAlerts interface
	BGAlerts_RegisterAddon("BGTextAlerts",BGTextAlerts_Accept,BGTextAlerts_Show,
							     BGTextAlertsOptionsFrame);
	
	SlashCmdList["BG_TEXT_ALERTS"] = BGTextAlerts_ShowUI;
	SLASH_BG_TEXT_ALERTS1 = "/bgtalerts";

end

function BGTextAlerts_ShowUI(cmd)
	ShowUIPanel(BGAlertsMainFrame);
	BGAlerts_ShowAddonPanel("BGTextAlerts");
end

function BGTextAlerts_OnEvent(eventType,chatMsg,chatAuthor)

	if (eventType == "UNIT_HEALTH") then
		if (WSGTextHealth == 1) then
			BGTextAlerts_CheckFlagHealth(chatMsg);
		end
	end
	
	if (eventType == "ZONE_CHANGED") then
		if (GetRealZoneText() ~= "Warsong Gulch") then
			BGTextAlerts_FlagCarrierName = "";
			BGTextAlerts_FlagHealthAnnounced = false;
		end
	end

	if (eventType == "CHAT_MSG_BG_SYSTEM_ALLIANCE") then
		BGTextAlerts_AllianceText(chatMsg);
		return;
	end
		
	if (eventType == "CHAT_MSG_BG_SYSTEM_HORDE") then
		BGTextAlerts_HordeText(chatMsg);
		return;
	end
	
	if (eventType == "CHAT_MSG_BG_SYSTEM_NEUTRAL") then
		BGTextAlerts_NeutralText(chatMsg);
		return;
	end
	
	if (eventType == "CHAT_MSG_YELL" or eventType == "CHAT_MSG_MONSTER_YELL") then
		BGTextAlerts_AVText(chatMsg,chatAuthor);
		return;
	end
	
	if (eventType == "PLAYER_AURAS_CHANGED") then
		BGTextAlerts_CheckForBuffs();
	end
	
	if (eventType == "VARIABLES_LOADED") then
		BGTextAlerts_Initiate();
 		-- Check with your guild mates and your current raid or party for new versions of BGTextAlerts
		--BGTextAlerts_CheckForNewVersion("GUILD");
		--BGTextAlerts_CheckForNewVersion("RAID");
		return;
	end
	
	if (eventType == "CHAT_MSG_GUILD" or eventType == "RAID_ROSTER_UPDATE") then
		-- Check with your guild mates and your current raid or party for new versions of BGSoundAlerts
		-- DEFAULT_CHAT_FRAME:AddMessage("Checking version once again.");
		BGTextAlerts_CheckForNewVersion("GUILD");
		BGTextAlerts_CheckForNewVersion("RAID");
		return;
	end
	
	if (eventType == "CHAT_MSG_BATTLEGROUND" or eventType == "CHAT_MSG_BATTLEGROUND_LEADER" or
		eventType == "CHAT_MSG_RAID_WARNING" or eventType == "CHAT_MSG_RAID" or
		eventType == "CHAT_MSG_RAID_LEADER") then
		BGTextAlerts_IncomingText(chatMsg);
	end
	
	if (eventType == "CHAT_MSG_ADDON" and chatMsg == "BGSAlertsVersion"
		and chatAuthor == "VersionCheck") then
		BGTextAlerts_SendVersion(extraArg);
		
	end
	
	if (eventType == "CHAT_MSG_ADDON" and chatMsg == "BGSAlertsVersion"
	    and tonumber(chatAuthor)) then
		-- Received a version number
		-- DEFAULT_CHAT_FRAME:AddMessage("Receiving version from ".. arg4 .. "(using version " .. chatAuthor .. ")");
		BGTextAlerts_CompareVersion(chatAuthor);
	end
	
	if (eventType == "UPDATE_WORLD_STATES") then
		-- Check for new BGSoundAlerts version with the rest of the battleground
		BGTextAlerts_CheckForNewVersion("BATTLEGROUND");
	end
		
end

function BGTextAlerts_CheckForNewVersion(checkDest)
	
	-- Send a message to checkDest to request BGSoundAlerts version number
	-- DEFAULT_CHAT_FRAME:AddMessage("Checking version on" .. checkDest);
	if (checkDest == "GUILD" and not IsInGuild()) then
		return;
	end
	SendAddonMessage("BGTAlertsVersion","VersionCheck",checkDest);
	
end

function BGTextAlerts_SendVersion(checkDest)
	
	-- Send our version number
	-- DEFAULT_CHAT_FRAME:AddMessage("Sending our version to " .. checkDest);
	if (checkDest == "GUILD" and not IsInGuild()) then
		return;
	end
	SendAddonMessage("BGTAlertsVersion",CURRENT_PATCH_VERSION,checkDest);
	
end

function BGTextAlerts_CompareVersion(number)
	
	-- Compare our version with the received one
	if (NEW_VERSION_ALERT == 0 and tonumber(number) > CURRENT_PATCH_VERSION) then
		-- There's a new version so show messages
		if (BGTextAlerts_VersionChecking == 1) then
			UIErrorsFrame:AddMessage("New |cFFFF0000BGTextAlerts|r out (Version " .. number .. ") is out. Go to http://|cFFFF0000ui.worldofwar.net|r/ to get the latest one!",1,1,0,10);
		end
		BGTextAlerts_NewVersionText:SetText("New |cFFFF0000BGTextAlerts|r out (Version " .. number .. ") is out. Go to http://|cFFFF0000ui.worldofwar.net|r/ to get the latest one!");
		BGTextAlerts_NewVersionText:Show();
		NEW_VERSION_ALERT = 1;
	end
	
end

function BGTextAlerts_Initiate()
	
	DEFAULT_CHAT_FRAME:AddMessage("|cFF00FF00BGTextAlerts|r (|cFF0050FF" .. CURRENT_PATCH_VERSION .. "|r) by |cFF00FF00Klishu|r Loaded. Type /bgtalerts to choose what text you see.",0.0,1.0,0.0,1.0);
	
	if (WSGTextEvents == nil) then
		WSGTextEvents = 1;
	end
	
	if (WSGTextScore == nil) then
		WSGTextScore = 1;
	end
	
	if (WSGTextHealth == nil) then
		WSGTextHealth = 1;
	end
	
	if (ABTextEvents == nil) then
		ABTextEvents = 1;
	end
	
	if (AVTextEvents == nil) then
		AVTextEvents = 1;
	end
	
	if (IncomingTexts == nil) then
		IncomingTexts = 1;
	end
	
	if (BGTextAlerts_AnimatedText == nil) then
		BGTextAlerts_AnimatedText = 1;
	end
	
	if (BGTextAlerts_VersionChecking == nil) then
		BGTextAlerts_VersionChecking = 1;
	end
	
	if (MultiKillsText == nil) then
		MultiKillsText = 1;
	end
	
	if (BGTextAlerts_PatchVersion == nil or BGTextAlerts_PatchVersion < CURRENT_PATCH_VERSION) then
		BGTextAlerts_PatchVersion = CURRENT_PATCH_VERSION;
		StaticPopup_Show("BGTEXTALERTS_NEWVERSION");
	end
	
end

function BGTextAlerts_InitiateOpp()
	-- This function will check if any checkboxes are unchecked and set the vars to 0 rather than nil
	if (WSGTextEvents == nil) then
		WSGTextEvents = 0;
	end
	
	if (WSGTextScore == nil) then
		WSGTextScore = 0;
	end
	
	if (WSGTextHealth == nil) then
		WSGTextHealth = 0;
	end
	
	if (ABTextEvents == nil) then
		ABTextScore = 0;
	end
	
	if (AVTextEvents == nil) then
		AVTextScore = 0;
	end
	
	if (IncomingText == nil) then
		IncomingText = 0;
	end
	
	if (BGTextAlerts_AnimatedText == nil) then
		BGTextAlerts_AnimatedText = 0;
	end
	
	if (BGTextAlerts_VersionChecking == nil) then
		BGTextAlerts_VersionChecking = 0;
	end
	
	if (MultiKillsText == nil) then
		MultiKillsText = 0;
	end
	
end

function BGTextAlerts_Show()

	WSGTextScore_Check:SetChecked(WSGTextScore);
	WSGTextEvents_Check:SetChecked(WSGTextEvents);
	WSGTextHealth_Check:SetChecked(WSGTextHealth);
	ABTextEvents_Check:SetChecked(ABTextEvents);
	AVTextEvents_Check:SetChecked(AVTextEvents);
	IncomingTexts_Check:SetChecked(IncomingTexts_Check);
	MultiKillsText_Check:SetChecked(MultiKillsText);
	TextVersionChecking_Check:SetChecked(BGTextAlerts_VersionChecking);
	AnimatedTexts_Check:SetChecked(BGTextAlerts_AnimatedText);
	
end

function BGTextAlerts_Accept()
	
	WSGTextScore = WSGTextScore_Check:GetChecked();
	WSGTextEvents = WSGTextEvents_Check:GetChecked();
	WSGTextHealth = WSGTextHealth_Check:GetChecked();
	ABTextEvents = ABTextEvents_Check:GetChecked();
	AVTextEvents = AVTextEvents_Check:GetChecked();
	IncomingTexts = IncomingTexts_Check:GetChecked();
	MultiKillsText = MultiKillsText_Check:GetChecked();
	BGTextAlerts_VersionChecking = TextVersionChecking_Check:GetChecked();
	BGTextAlerts_AnimatedText = AnimatedTexts_Check:GetChecked();
	
	-- Check for nils
	BGTextAlerts_InitiateOpp();
	
end

function BGTextAlerts_Text_OnShow()

	-- Flash the frame in and then out
	UIFrameFlash(this,0,1.2,4.2,false,0,3);
	
end

function BGTextAlerts_Text_OnHide()
	
	-- Stop flashing the frame in and then out
	UIFrameFlashStop(this);
	
end

function BGTextAlerts_AllianceText(msg)

	if (string.find(msg,"The Alliance Flag was returned") ~= nil and WSGTextEvents == 1) then
		BGTextAlerts_ShowText("The Alliance Flag has been returned to its base.",ALLIANCE_COLORS,ALLIANCE_ICON);
		return;
	end
	
	if (string.find(msg,"The Horde flag was picked up") ~= nil) then
		if (WSGTextEvents == 1) then
			BGTextAlerts_ShowText("The Horde Flag has been picked up.",ALLIANCE_COLORS,ALLIANCE_ICON);
		end
		if (UnitFactionGroup("player") == "Alliance") then
			-- Mark flag carrier
			BGTextAlerts_FlagCarrierName = string.sub(msg,33,string.len(msg)-1);
			BGTextAlerts_FlagHealthAnnounced = false;
		end
		return;
	end
	
	if (string.find(msg,"The Alliance Flag was dropped") ~= nil) then
		if (UnitFactionGroup("player") == "Horde") then
			-- Mark flag carrier
			BGTextAlerts_FlagCarrierName = "";
			BGTextAlerts_FlagHealthAnnounced = false;
		end
		return;
	end
	
	if (string.find(msg,"captured the Horde flag") ~= nil) then
		if (WSGTextEvents == 1) then
			BGTextAlerts_ShowText("The Alliance have captured the Horde flag.",ALLIANCE_COLORS,ALLIANCE_ICON);
		end
		if (UnitFactionGroup("player") == "Alliance") then
			-- Mark flag carrier
			BGTextAlerts_FlagCarrierName = "";
			BGTextAlerts_FlagHealthAnnounced = false;
		end
		return;
	end
	
	if (string.find(msg,"assaulted the stables") ~= nil and ABTextEvents == 1) then
		BGTextAlerts_ShowText("The Alliance have assaulted the Stables.",ALLIANCE_COLORS,ALLIANCE_ICON);
		return;
	end
	
	if (string.find(msg,"assaulted the lumber") ~= nil and ABTextEvents == 1) then
		BGTextAlerts_ShowText("The Alliance have assaulted the Lumber Mill.",ALLIANCE_COLORS,ALLIANCE_ICON);
		return;
	end
	
	if (string.find(msg,"assaulted the blacksmith") ~= nil and ABTextEvents == 1) then
		BGTextAlerts_ShowText("The Alliance have assaulted the Blacksmith.",ALLIANCE_COLORS,ALLIANCE_ICON);
		return;
	end
	
	if (string.find(msg,"assaulted the mine") ~= nil and ABTextEvents == 1) then
		BGTextAlerts_ShowText("The Alliance have assaulted the Gold Mine.",ALLIANCE_COLORS,ALLIANCE_ICON);
		return;
	end
	
	if (string.find(msg,"assaulted the farm") ~= nil and ABTextEvents == 1) then
		BGTextAlerts_ShowText("The Alliance have assaulted the Farm.",ALLIANCE_COLORS,ALLIANCE_ICON);
		return;
	end
	
	if (string.find(msg,"taken the stables") ~= nil and ABTextEvents == 1) then
		BGTextAlerts_ShowText("The Alliance have taken the Stables.",ALLIANCE_COLORS,ALLIANCE_ICON);
		return;
	end
	
	if (string.find(msg,"taken the lumber") ~= nil and ABTextEvents == 1) then
		BGTextAlerts_ShowText("The Alliance have taken the Lumber Mill.",ALLIANCE_COLORS,ALLIANCE_ICON);
		return;
	end
	
	if (string.find(msg,"taken the blacksmith") ~= nil and ABTextEvents == 1) then
		BGTextAlerts_ShowText("The Alliance have taken the Blacksmith.",ALLIANCE_COLORS,ALLIANCE_ICON);
		return;
	end
	
	if (string.find(msg,"taken the mine") ~= nil and ABTextEvents == 1) then
		BGTextAlerts_ShowText("The Alliance have taken the Gold Mine.",ALLIANCE_COLORS,ALLIANCE_ICON);
		return;
	end
	
	if (string.find(msg,"taken the farm") ~= nil and ABTextEvents == 1) then
		BGTextAlerts_ShowText("The Alliance have taken the Farm.",ALLIANCE_COLORS,ALLIANCE_ICON);
		return;
	end
	
	if (string.find(msg,"claims the stables") ~= nil and ABTextEvents == 1) then
		BGTextAlerts_ShowText("The Alliance have assaulted the Stables.",ALLIANCE_COLORS,ALLIANCE_ICON);
		return;
	end
	
	if (string.find(msg,"claims the lumber") ~= nil and ABTextEvents == 1) then
		BGTextAlerts_ShowText("The Alliance have assaulted the Lumber Mill.",ALLIANCE_COLORS,ALLIANCE_ICON);
		return;
	end
	
	if (string.find(msg,"claims the blacksmith") ~= nil and ABTextEvents == 1) then
		BGTextAlerts_ShowText("The Alliance have assaulted the Blacksmith.",ALLIANCE_COLORS,ALLIANCE_ICON);
		return;
	end
	
	if (string.find(msg,"claims the mine") ~= nil and ABTextEvents == 1) then
		BGTextAlerts_ShowText("The Alliance have assaulted the Gold Mine.",ALLIANCE_COLORS,ALLIANCE_ICON);
		return;
	end
	
	if (string.find(msg,"claims the farm") ~= nil and ABTextEvents == 1) then
		BGTextAlerts_ShowText("The Alliance have assaulted the Farm.",ALLIANCE_COLORS,ALLIANCE_ICON);
		return;
	end
end

function BGTextAlerts_HordeText(msg)

	if (string.find(msg,"The Horde flag was returned") ~= nil and WSGTextEvents == 1) then
		BGTextAlerts_ShowText("The Horde Flag has been returned to its base.",HORDE_COLORS,HORDE_ICON);
		return;
	end
	
	if (string.find(msg,"The Alliance Flag was picked up") ~= nil) then
		if (WSGTextEvents == 1) then
			BGTextAlerts_ShowText("The Alliance Flag has been picked up.",HORDE_COLORS,HORDE_ICON);
		end
		if (UnitFactionGroup("player") == "Horde") then
			-- Mark flag carrier
			BGTextAlerts_FlagCarrierName = string.sub(msg,36,string.len(msg)-1);
			BGTextAlerts_FlagHealthAnnounced = false;
		end
		return;
	end
	
	if (string.find(msg,"The Horde flag was dropped") ~= nil) then
		if (UnitFactionGroup("player") == "Alliance") then
			-- Mark flag carrier
			BGTextAlerts_FlagCarrierName = "";
			BGTextAlerts_FlagHealthAnnounced = false;
		end
	end
	
	if (string.find(msg,"captured the Alliance flag") ~= nil) then
		if (WSGTextEvents == 1) then
			BGTextAlerts_ShowText("The Horde have captured the Alliance flag.",HORDE_COLORS,HORDE_ICON);
		end
		if (UnitFactionGroup("player") == "Horde") then
			BGTextAlerts_FlagCarrierName = "";
			BGTextAlerts_FlagHealthAnnounced = false;
		end
		return;
	end
	
	if (string.find(msg,"assaulted the stables") ~= nil and ABTextEvents == 1) then
		BGTextAlerts_ShowText("The Horde have assaulted the Stables.",HORDE_COLORS,HORDE_ICON);
		return;
	end
	
	if (string.find(msg,"assaulted the lumber") ~= nil and ABTextEvents == 1) then
		BGTextAlerts_ShowText("The Horde have assaulted the Lumber Mill.",HORDE_COLORS,HORDE_ICON);
		return;
	end
	
	if (string.find(msg,"assaulted the blacksmith") ~= nil and ABTextEvents == 1) then
		BGTextAlerts_ShowText("The Horde have assaulted the Blacksmith.",HORDE_COLORS,HORDE_ICON);
		return;
	end
	
	if (string.find(msg,"assaulted the mine") ~= nil and ABTextEvents == 1) then
		BGTextAlerts_ShowText("The Horde have assaulted the Gold Mine.",HORDE_COLORS,HORDE_ICON);
		return;
	end
	
	if (string.find(msg,"assaulted the farm") ~= nil and ABTextEvents == 1) then
		BGTextAlerts_ShowText("The Horde have assaulted the Farm.",HORDE_COLORS,HORDE_ICON);
		return;
	end
	
	if (string.find(msg,"taken the stables") ~= nil and ABTextEvents == 1) then
		BGTextAlerts_ShowText("The Horde have taken the Stables.",HORDE_COLORS,HORDE_ICON);
		return;
	end
	
	if (string.find(msg,"taken the lumber") ~= nil and ABTextEvents == 1) then
		BGTextAlerts_ShowText("The Horde have taken the Lumber Mill.",HORDE_COLORS,HORDE_ICON);
		return;
	end
	
	if (string.find(msg,"taken the blacksmith") ~= nil and ABTextEvents == 1) then
		BGTextAlerts_ShowText("The Horde have taken the Blacksmith.",HORDE_COLORS,HORDE_ICON);
		return;
	end
	
	if (string.find(msg,"taken the mine") ~= nil and ABTextEvents == 1) then
		BGTextAlerts_ShowText("The Horde have taken the Gold Mine.",HORDE_COLORS,HORDE_ICON);
		return;
	end
	
	if (string.find(msg,"taken the farm") ~= nil and ABTextEvents == 1) then
		BGTextAlerts_ShowText("The Horde have taken the Farm.",HORDE_COLORS,HORDE_ICON);
		return;
	end
	
	if (string.find(msg,"claims the stables") ~= nil and ABTextEvents == 1) then
		BGTextAlerts_ShowText("The Horde have assaulted the Stables.",HORDE_COLORS,HORDE_ICON);
		return;
	end
	
	if (string.find(msg,"claims the lumber") ~= nil and ABTextEvents == 1) then
		BGTextAlerts_ShowText("The Horde have assaulted the Lumber Mill.",HORDE_COLORS,HORDE_ICON);
		return;
	end
	
	if (string.find(msg,"claims the blacksmith") ~= nil and ABTextEvents == 1) then
		BGTextAlerts_ShowText("The Horde have assaulted the Blacksmith.",HORDE_COLORS,HORDE_ICON);
		return;
	end
	
	if (string.find(msg,"claims the mine") ~= nil and ABTextEvents == 1) then
		BGTextAlerts_ShowText("The Horde have assaulted the Gold Mine.",HORDE_COLORS,HORDE_ICON);
		return;
	end
	
	if (string.find(msg,"claims the farm") ~= nil and ABTextEvents == 1) then
		BGTextAlerts_ShowText("The Horde have assaulted the Farm.",HORDE_COLORS,HORDE_ICON);
		return;
	end
end

function BGTextAlerts_NeutralText(msg)

	BGTextAlerts_Texture:Hide();

	if(string.find(msg,"placed at their bases") ~= nil and WSGTextScore == 1) then
		BGTextAlerts_ScoreText();
		return;
	end
	
	if (string.find(msg,"The Horde flag has returned") ~= nil and WSGTextEvents == 1) then
		BGTextAlerts_ShowText("The Horde Flag has been returned to its base.",HORDE_COLORS,HORDE_ICON);
		return;
	end
	
	if (string.find(msg,"The Alliance Flag has returned") ~= nil and WSGTextEvents == 1) then
		BGTextAlerts_ShowText("The Alliance Flag has been returned to its base.",ALLIANCE_COLORS,ALLIANCE_ICON);
		return;
	end
	
end

function BGTextAlerts_ScoreText()

	local  _, AllianceScore = GetWorldStateUIInfo(1);
	local  _, HordeScore = GetWorldStateUIInfo(2);
	
	if (AllianceScore == "0/3" and HordeScore == "0/3") then
		-- Do not display text as this is the start of the game
		return;
	end
	
	if (AllianceScore == "0/3" and HordeScore == "1/3") then
		BGTextAlerts_ShowText("Alliance: 0/3 - Horde: 1/3",NEUTRAL_COLORS);
		return;
	end
	
	if (AllianceScore == "0/3" and HordeScore == "2/3") then
		BGTextAlerts_ShowText("Alliance: 0/3 - Horde 2/3",NEUTRAL_COLORS);
		return;
	end
	
	if (AllianceScore == "1/3" and HordeScore == "0/3") then
		BGTextAlerts_ShowText("Alliance: 1/3 - Horde 0/3",NEUTRAL_COLORS);
		return;
	end
	
	if (AllianceScore == "1/3" and HordeScore == "1/3") then
		BGTextAlerts_ShowText("Alliance: 1/3 - Horde 1/3",NEUTRAL_COLORS);
		return;
	end

	if (AllianceScore == "1/3" and HordeScore == "2/3") then
		BGTextAlerts_ShowText("Alliance: 1/3 - Horde 2/3",NEUTRAL_COLORS);
		return;
	end
	
	if (AllianceScore == "2/3" and HordeScore == "0/3") then
		BGTextAlerts_ShowText("Alliance: 2/3 - Horde 0/3",NEUTRAL_COLORS);
		return;
	end
	
	if (AllianceScore == "2/3" and HordeScore == "1/3") then
		BGTextAlerts_ShowText("Alliance: 2/3 - Horde 1/3",NEUTRAL_COLORS);
		return;
	end
	
	if (AllianceScore == "2/3" and HordeScore == "2/3") then
		BGTextAlerts_ShowText("Alliance: 2/3 - Horde 2/3",NEUTRAL_COLORS);
		return;
	end
	
end

-- The following is the very BIG list of events that happen in AV
function BGTextAlerts_AVText(chatMsg,chatAuthor)
	
	BGTextAlerts_Texture:Hide();
	
	if (AVTextEvents == 1) then
		-- Alliance Assaulted Graveyards
		if (string.find(chatMsg,"Iceblood Graveyard is under attack!  If left unchecked, the Alliance") ~= nil and chatAuthor == "Herald") then
			BGTextAlerts_ShowText("The Alliance has assaulted the Iceblood Graveyard.",ALLIANCE_COLORS,ALLIANCE_ICON);
			return;
		end
		
		if (string.find(chatMsg,"Stonehearth Graveyard is under attack!  If left unchecked, the Alliance") ~= nil and chatAuthor == "Herald") then
			BGTextAlerts_ShowText("The Alliance has assaulted the Stonehearth Graveyard.",ALLIANCE_COLORS,ALLIANCE_ICON);
			return;
		end
		
		if (string.find(chatMsg,"Snowfall Graveyard is under attack!  If left unchecked, the Alliance") ~= nil and chatAuthor == "Herald") then
			BGTextAlerts_ShowText("The Alliance has assaulted the Snowfall Graveyard.",ALLIANCE_COLORS,ALLIANCE_ICON);
			return;
		end
		
		if (string.find(chatMsg,"Frostwolf Graveyard is under attack!  If left unchecked, the Alliance") ~= nil and chatAuthor == "Herald") then
			BGTextAlerts_ShowText("The Alliance has assaulted the Frostwolf Graveyard.",ALLIANCE_COLORS,ALLIANCE_ICON);
			return;
		end
		
		if (string.find(chatMsg,"Stormpike Graveyard is under attack!  If left unchecked, the Alliance") ~= nil and chatAuthor == "Herald") then
			BGTextAlerts_ShowText("The Alliance has assaulted the Stormpike Graveyard.",ALLIANCE_COLORS,ALLIANCE_ICON);
			return;
		end
		
		if (string.find(chatMsg,"Frostwolf Relief Hut is under attack!  If left unchecked, the Alliance") ~= nil and chatAuthor == "Herald") then
			BGTextAlerts_ShowText("The Alliance has assaulted the Frostwolf Relief Hut.",ALLIANCE_COLORS,ALLIANCE_ICON);
			return;
		end
		
		if (string.find(chatMsg,"Stormpike Aid Station is under attack!  If left unchecked, the Alliance") ~= nil and chatAuthor == "Herald") then
			BGTextAlerts_ShowText("The Alliance has assaulted the Stormpike Aid Station.",ALLIANCE_COLORS,ALLIANCE_ICON);
			return;
		end

		-- Alliance taken Graveyards
		if (string.find(chatMsg,"Iceblood Graveyard was taken by the Alliance") ~= nil and chatAuthor == "Herald") then
			BGTextAlerts_ShowText("The Alliance has taken the Iceblood Graveyard.",ALLIANCE_COLORS,ALLIANCE_ICON);
			return;
		end
		
		if (string.find(chatMsg,"Stonehearth Graveyard was taken by the Alliance") ~= nil and chatAuthor == "Herald") then
			BGTextAlerts_ShowText("The Alliance has taken the Stonehearth Graveyard.",ALLIANCE_COLORS,ALLIANCE_ICON);
			return;
		end
		
		if (string.find(chatMsg,"Snowfall Graveyard was taken by the Alliance") ~= nil and chatAuthor == "Herald") then
			BGTextAlerts_ShowText("The Alliance has taken the Snowfall Graveyard.",ALLIANCE_COLORS,ALLIANCE_ICON);
			return;
		end
		
		if (string.find(chatMsg,"Frostwolf Graveyard was taken by the Alliance") ~= nil and chatAuthor == "Herald") then
			BGTextAlerts_ShowText("The Alliance has taken the Frostwolf Graveyard.",ALLIANCE_COLORS,ALLIANCE_ICON);
			return;
		end
		
		if (string.find(chatMsg,"Stormpike Graveyard was taken by the Alliance") ~= nil and chatAuthor == "Herald") then
			BGTextAlerts_ShowText("The Alliance has taken the Stormpike Graveyard.",ALLIANCE_COLORS,ALLIANCE_ICON);
			return;
		end
		
		if (string.find(chatMsg,"Frostwolf Relief Hut was taken by the Alliance") ~= nil and chatAuthor == "Herald") then
			BGTextAlerts_ShowText("The Alliance has taken the Frostwolf Relief Hut.",ALLIANCE_COLORS,ALLIANCE_ICON);
			return;
		end
		
		if (string.find(chatMsg,"Stormpike Aid Station was taken by the Alliance") ~= nil and chatAuthor == "Herald") then
			BGTextAlerts_ShowText("The Alliance has taken the Stormpike Aid Station.",ALLIANCE_COLORS,ALLIANCE_ICON);
			return;
		end
		
		-- Horde Assaulted Graveyards
		if (string.find(chatMsg,"Iceblood Graveyard is under attack!  If left unchecked, the Horde") ~= nil and chatAuthor == "Herald") then
			BGTextAlerts_ShowText("The Horde has assaulted the Iceblood Graveyard.",HORDE_COLORS,HORDE_ICON);
			return;
		end
		
		if (string.find(chatMsg,"Stonehearth Graveyard is under attack!  If left unchecked, the Horde") ~= nil and chatAuthor == "Herald") then
			BGTextAlerts_ShowText("The Horde has assaulted the Stonehearth Graveyard.",HORDE_COLORS,HORDE_ICON);
			return;
		end
		
		if (string.find(chatMsg,"Snowfall Graveyard is under attack!  If left unchecked, the Horde") ~= nil and chatAuthor == "Herald") then
			BGTextAlerts_ShowText("The Horde has assaulted the Snowfall Graveyard.",HORDE_COLORS,HORDE_ICON);
			return;
		end
		
		if (string.find(chatMsg,"Frostwolf Graveyard is under attack!  If left unchecked, the Horde") ~= nil and chatAuthor == "Herald") then
			BGTextAlerts_ShowText("The Horde has assaulted the Frostwolf Graveyard.",HORDE_COLORS,HORDE_ICON);
			return;
		end
		
		if (string.find(chatMsg,"Stormpike Graveyard is under attack!  If left unchecked, the Horde") ~= nil and chatAuthor == "Herald") then
			BGTextAlerts_ShowText("The Horde has assaulted the Stormpike Graveyard.",HORDE_COLORS,HORDE_ICON);
			return;
		end
		
		if (string.find(chatMsg,"Frostwolf Relief Hut is under attack!  If left unchecked, the Horde") ~= nil and chatAuthor == "Herald") then
			BGTextAlerts_ShowText("The Horde has assaulted the Frostwolf Relief Hut.",HORDE_COLORS,HORDE_ICON);
			return;
		end
		
		if (string.find(chatMsg,"Stormpike Aid Station is under attack!  If left unchecked, the Horde") ~= nil and chatAuthor == "Herald") then
			BGTextAlerts_ShowText("The Horde has assaulted the Stormpike Aid Station.",HORDE_COLORS,HORDE_ICON);
			return;
		end

		-- Horde taken Graveyards
		if (string.find(chatMsg,"Iceblood Graveyard was taken by the Horde") ~= nil and chatAuthor == "Herald") then
			BGTextAlerts_ShowText("The Horde has taken the Iceblood Graveyard.",HORDE_COLORS,HORDE_ICON);
			return;
		end
		
		if (string.find(chatMsg,"Stonehearth Graveyard was taken by the Horde") ~= nil and chatAuthor == "Herald") then
			BGTextAlerts_ShowText("The Horde has taken the Stonehearth Graveyard.",HORDE_COLORS,HORDE_ICON);
			return;
		end
		
		if (string.find(chatMsg,"Snowfall Graveyard was taken by the Horde") ~= nil and chatAuthor == "Herald") then
			BGTextAlerts_ShowText("The Horde has taken the Snowfall Graveyard.",HORDE_COLORS,HORDE_ICON);
			return;
		end
		
		if (string.find(chatMsg,"Frostwolf Graveyard was taken by the Horde") ~= nil and chatAuthor == "Herald") then
			BGTextAlerts_ShowText("The Horde has taken the Frostwolf Graveyard.",HORDE_COLORS,HORDE_ICON);
			return;
		end
		
		if (string.find(chatMsg,"Stormpike Graveyard was taken by the Horde") ~= nil and chatAuthor == "Herald") then
			BGTextAlerts_ShowText("The Horde has taken the Stormpike Graveyard.",HORDE_COLORS,HORDE_ICON);
			return;
		end
		
		if (string.find(chatMsg,"Frostwolf Aid Station was taken by the Horde") ~= nil and chatAuthor == "Herald") then
			BGTextAlerts_ShowText("The Horde has taken the Frostwolf Aid Station.",HORDE_COLORS,HORDE_ICON);
			return;
		end
		
		if (string.find(chatMsg,"Stormpike Aid Station was taken by the Horde") ~= nil and chatAuthor == "Herald") then
			BGTextAlerts_ShowText("The Horde has taken the Stormpike Aid Station.",HORDE_COLORS,HORDE_ICON);
			return;
		end
		
		-- Towers Assaulted
		if (string.find(chatMsg,"Stonehearth Bunker is under attack!  If left unchecked, the Horde") ~= nil and chatAuthor == "Herald") then
			BGTextAlerts_ShowText("The Horde has assaulted the Stonehearth Bunker.",HORDE_COLORS,HORDE_ICON);
			return;
		end
		
		if (string.find(chatMsg,"Icewing Bunker is under attack!  If left unchecked, the Horde") ~= nil and chatAuthor == "Herald") then
			BGTextAlerts_ShowText("The Horde has assaulted the Icewing Bunker.",HORDE_COLORS,HORDE_ICON);
			return;
		end
		
		if (string.find(chatMsg,"South Bunker is under attack!  If left unchecked, the Horde") ~= nil and chatAuthor == "Herald") then
			BGTextAlerts_ShowText("The Horde has assaulted the Dun Baldar South Bunker.",HORDE_COLORS,HORDE_ICON);
			return;
		end
		
		if (string.find(chatMsg,"North Bunker is under attack!  If left unchecked, the Horde") ~= nil and chatAuthor == "Herald") then
			BGTextAlerts_ShowText("The Horde has assaulted the Dun Baldar North Bunker.",HORDE_COLORS,HORDE_ICON);
			return;
		end
		
		if (string.find(chatMsg,"Iceblood Tower is under attack!  If left unchecked, the Alliance") ~= nil and chatAuthor == "Herald") then
			BGTextAlerts_ShowText("The Alliance has assaulted the Iceblood Tower.",ALLIANCE_COLORS,ALLIANCE_ICON);
			return;
		end
		
		if (string.find(chatMsg,"Tower Point is under attack!  If left unchecked, the Alliance") ~= nil and chatAuthor == "Herald") then
			BGTextAlerts_ShowText("The Alliance has assaulted Tower Point.",ALLIANCE_COLORS,ALLIANCE_ICON);
			return;
		end
		
		if (string.find(chatMsg,"West Frostwolf Tower is under attack!  If left unchecked, the Alliance") ~= nil and chatAuthor == "Herald") then
			BGTextAlerts_ShowText("The Alliance has assaulted the West Frostwolf Tower.",ALLIANCE_COLORS,ALLIANCE_ICON);
			return;
		end
		
		if (string.find(chatMsg,"East Frostwolf Tower is under attack!  If left unchecked, the Alliance") ~= nil and chatAuthor == "Herald") then
			BGTextAlerts_ShowText("The Alliance has assaulted the East Frostwolf Tower.",ALLIANCE_COLORS,ALLIANCE_ICON);
			return;
		end
		
		-- Towers Taken
		if (string.find(chatMsg,"Stonehearth Bunker was taken by the Alliance") ~= nil and chatAuthor == "Herald") then
			BGTextAlerts_ShowText("The Alliance has taken the Stonehearth Bunker.",ALLIANCE_COLORS,ALLIANCE_ICON);
			return;
		end
		
		if (string.find(chatMsg,"Icewing Bunker was taken by the Alliance") ~= nil and chatAuthor == "Herald") then
			BGTextAlerts_ShowText("The Alliance has taken the Icewing Bunker.",ALLIANCE_COLORS,ALLIANCE_ICON);
			return;
		end
		
		if (string.find(chatMsg,"South Bunker was taken by the Alliance") ~= nil and chatAuthor == "Herald") then
			BGTextAlerts_ShowText("The Alliance has taken the Dun Baldar South Bunker.",ALLIANCE_COLORS,ALLIANCE_ICON);
			return;
		end
		
		if (string.find(chatMsg,"North Bunker was taken by the Alliance") ~= nil and chatAuthor == "Herald") then
			BGTextAlerts_ShowText("The Alliance has taken the Dun Baldar North Bunker.",ALLIANCE_COLORS,ALLIANCE_ICON);
			return;
		end
		
		if (string.find(chatMsg,"Iceblood Tower was taken by the Horde") ~= nil and chatAuthor == "Herald") then
			BGTextAlerts_ShowText("The Horde has taken the Iceblood Tower.",HORDE_COLORS,HORDE_ICON);
			return;
		end
		
		if (string.find(chatMsg,"Tower Point was taken by the Horde") ~= nil and chatAuthor == "Herald") then
			BGTextAlerts_ShowText("The Horde has taken Tower Point.",HORDE_COLORS,HORDE_ICON);
			return;
		end
		
		if (string.find(chatMsg,"West Frostwolf Tower was taken by the Horde") ~= nil and chatAuthor == "Herald") then
			BGTextAlerts_ShowText("The Horde has taken the West Frostwolf Tower.",HORDE_COLORS,HORDE_ICON);
			return;
		end
		
		if (string.find(chatMsg,"East Frostwolf Tower was taken by the Horde") ~= nil and chatAuthor == "Herald") then
			BGTextAlerts_ShowText("The Horde has taken the East Frostwolf Tower.",HORDE_COLORS,HORDE_ICON);
			return;
		end
		
		-- Towers destroyed
		if (string.find(chatMsg,"Stonehearth Bunker was destroyed by the Horde") ~= nil and chatAuthor == "Herald") then
			BGTextAlerts_ShowText("The Horde has destroyed the Stonehearth Bunker.",HORDE_COLORS,HORDE_ICON);
			return;
		end
		
		if (string.find(chatMsg,"Icewing Bunker was destroyed by the Horde") ~= nil and chatAuthor == "Herald") then
			BGTextAlerts_ShowText("The Horde has destroyed the Icewing Bunker.",HORDE_COLORS,HORDE_ICON);
			return;
		end
		
		if (string.find(chatMsg,"South Bunker was destroyed by the Horde") ~= nil and chatAuthor == "Herald") then
			BGTextAlerts_ShowText("The Horde has destroyed the Dun Baldar South Bunker.",HORDE_COLORS,HORDE_ICON);
			return;
		end
		
		if (string.find(chatMsg,"North Bunker was destroyed by the Horde") ~= nil and chatAuthor == "Herald") then
			BGTextAlerts_ShowText("The Horde has destroyed the Dun Baldar North Bunker.",HORDE_COLORS,HORDE_ICON);
			return;
		end
		
		if (string.find(chatMsg,"Iceblood Tower was destroyed by the Alliance") ~= nil and chatAuthor == "Herald") then
			BGTextAlerts_ShowText("The Alliance has destroyed the Iceblood Tower.",ALLIANCE_COLORS,ALLIANCE_ICON);
			return;
		end
		
		if (string.find(chatMsg,"Tower Point was destroyed by the Alliance") ~= nil and chatAuthor == "Herald") then
			BGTextAlerts_ShowText("The Alliance has destroyed Tower Point.",ALLIANCE_COLORS,ALLIANCE_ICON);
			return;
		end
		
		if (string.find(chatMsg,"West Frostwolf Tower was destroyed by the Alliance") ~= nil and chatAuthor == "Herald") then
			BGTextAlerts_ShowText("The Alliance has destroyed the West Frostwolf Tower.",ALLIANCE_COLORS,ALLIANCE_ICON);
			return;
		end
		
		if (string.find(chatMsg,"East Frostwolf Tower was destroyed by the Alliance") ~= nil and chatAuthor == "Herald") then
			BGTextAlerts_ShowText("The Alliance has destroyed the East Frostwolf Tower.",ALLIANCE_COLORS,ALLIANCE_ICON);
			return;
		end
		
		-- Gold Mines
		if (string.find(chatMsg,"Horde has taken the Coldtooth Mine") ~= nil and chatAuthor == "Herald") then
			BGTextAlerts_ShowText("The Horde has taken the Coldtooth Mine.",HORDE_COLORS,HORDE_ICON);
			return;
		end
		
		if (string.find(chatMsg,"Alliance has taken the Coldtooth Mine") ~= nil and chatAuthor == "Herald") then
			BGTextAlerts_ShowText("The Alliance has taken the Coldtooth Mine.",ALLIANCE_COLORS,ALLIANCE_ICON);
			return;
		end
		
		if (string.find(chatMsg,"Snivvle claims the Coldtooth mine") ~= nil and chatAuthor == "Taskmaster Snivvle") then
			BGTextAlerts_ShowText("Kobolds have infested the Coldtooth Mine.",NEUTRAL_COLORS);
			return;
		end
		
		if (string.find(chatMsg,"Horde has taken the Irondeep Mine") ~= nil and chatAuthor == "Herald") then
			BGTextAlerts_ShowText("The Horde has taken the Irondeep Mine.",HORDE_COLORS,HORDE_ICON);
			return;
		end
		
		if (string.find(chatMsg,"Alliance has taken the Irondeep Mine") ~= nil and chatAuthor == "Herald") then
			BGTextAlerts_ShowText("The Alliance has taken the Irondeep Mine.",ALLIANCE_COLORS,ALLIANCE_ICON);
			return;
		end
		
		if (string.find(chatMsg,"Irondeep Mine is... MINE") ~= nil and chatAuthor == "Morloch") then
			BGTextAlerts_ShowText("Troggs have infested the Irondeep Mine.",NEUTRAL_COLORS);
			return;
		end
		
		-- Alliance Ram Riders
		if (chatAuthor == "Stormpike Ram Rider Commander") then
			BGTextAlerts_ShowText("The Alliance are launching their Ram Riders.",ALLIANCE_COLORS,ALLIANCE_ICON);
			return;
		end
		
		-- Horde Frostwolf Riders
		if (chatAuthor == "Frostwolf Wolf Rider Commander") then
			BGTextAlerts_ShowText("The Horde are launching their Wolf Riders.",HORDE_COLORS,HORDE_ICON);
			return;
		end
		
		-- Captains under attack
		if (string.find(chatMsg,"Die!") ~= nil and chatAuthor == "Captain Galvangar") then
			BGTextAlerts_ShowText("Captain Galvangar is under attack.",HORDE_COLORS,HORDE_ICON);
			return;
		end
		
		-- Can't remember whole phrase
		if (string.find(chatMsg,"scum") ~= nil and chatAuthor == "Captain Balinda Stonehearth") then
			BGTextAlerts_ShowText("Captain Balinda Stonehearth is under attack.",ALLIANCE_COLORS,ALLIANCE_ICON);
			return;
		end
		
		-- Unit Upgrades
		if (chatAuthor == "Murgot Deepforge") then
			BGTextAlerts_ShowText("The Alliance are upgrading their troops.",ALLIANCE_COLORS,ALLIANCE_ICON);
			return;
		end
		
		if (chatAuthor == "Smith Regzar") then
			BGTextAlerts_ShowText("The Horde are upgrading their troops.",HORDE_COLORS,HORDE_ICON);
			return;
		end
		
		-- Generals Under Attack
		if (string.find(chatMsg,"filth") ~= nil and chatAuthor == "Drek'Thar") then
			BGTextAlerts_ShowText("The Horde General Drek'Thar is under attack.",HORDE_COLORS,HORDE_ICON);
			return;
		end

		if (string.find(chatMsg,"I require aid") ~= nil and chatAuthor == "Vanndar Stormpike") then
			BGTextAlerts_ShowText("The Alliance General Vanndar Stormpike is under attack.",ALLIANCE_COLORS,ALLIANCE_ICON);
			return;
		end
	end
	
end

function BGTextAlerts_IncomingText(incmsg)
	
	if (IncomingTexts == 0) then
		return;
	end
	
	local outputtext = "";				-- The text to output
	
	-- Capitalize msg for easier parsing
	local msg = string.upper(incmsg);
	local begindigit, enddigit;
	
	-- Are we in a battleground
	if (GetRealZoneText() == "Warsong Gulch" or GetRealZoneText() == "Arathi Basin" 
		or GetRealZoneText() == "Alterac Valley") then
			
			-- Check for 'Inc'
			if (string.find(msg,"INC")) then
				outputtext = outputtext .. "Incoming ";
				-- If Inc is found check for more detail
				-- Check for numbers
				begindigit, enddigit = string.find(msg,"(%d+)");
				-- Check for these if in Arathi Basin
				if (GetRealZoneText() == "Arathi Basin") then
					if (string.find(msg,"FARM")) then
						-- Inc Farm
						outputtext = outputtext .. "Farm";
					elseif (string.find(msg,"STABLES") or string.find(msg,"STAB")) then
						-- Inc Stables
						IncomingFile = outputtext .. "Stables";
					elseif (string.find(msg,"LM") or string.find(msg,"MILL") or string.find(msg,"LUMBER")) then
						-- Inc Lumbermill
						outputtext = outputtext .. "Lumbermill";
					elseif (string.find(msg,"GM") or string.find(msg,"MINE") or string.find(msg,"GOLD")) then
						-- Inc Gold Mine
						outputtext = outputtext .. "Gold Mine ";
					elseif (string.find(msg,"BS") or string.find(msg,"SMITH") or string.find(msg,"BLACK")) then
						-- Inc Blacksmith
						outputtext = outputtext .. "Blacksmith";
					elseif (string.find(msg,"BIG") or string.find(msg,"A(%s+)LOT") or string.find(msg,"MANY")) then
						-- Incoming Big
						outputtext = outputtext .. "Big";
					elseif (begindigit) then
						local number = tonumber(string.sub(msg,begindigit,enddigit));
						if (number <= 10 and number > 0) then
							-- Incoming Number
							outputtext = outputtext .. number;
						else
							-- Incoming Big
							outputtext = outputtext .. "Big";
						end
					end
				-- Check for these if in Warsong Gulch
				elseif (GetRealZoneText() == "Warsong Gulch") then
					if (string.find(msg,"BASE")) then
						-- Incoming Base
						outputtext = outputtext .. "Base";
					elseif (string.find(msg,"BIG") or string.find(msg,"A(%s+)LOT") or string.find(msg,"MANY")) then
						-- Incoming Big
						outputtext = outputtext .. "Big";
					elseif (begindigit) then
						local number = tonumber(string.sub(msg,begindigit,enddigit));
						if (number <= 10 and number > 0) then
							-- Incoming Number
							outputtext = outputtext .. number;
						else
							-- Incoming Big
							outputtext = outputtext .. "Big";
						end
					end
				-- Check for these if in Alterac Valley
				elseif (GetRealZoneText() == "Alterac Valley") then
					if (string.find(msg,"SF") or string.find(msg,"SNOW") or string.find(msg,"FALL")) then
						-- Incoming Snowfall Graveyard
						outputtext = outputtext .. "Snowfall Graveyard ";
					elseif ((string.find(msg,"IB") or string.find(msg,"ICE(%s+)BLOOD")) and (string.find(msg,"GY") or string.find(msg,"GRAVE(%s+)YARD"))) then
						-- Incoming Iceblood Graveyard
						outputtext = outputtext .. "Iceblood Graveyard ";
					elseif (string.find(msg,"IB") or string.find(msg,"ICE(%s+)BLOOD")) then
						-- Incoming Iceblood Tower
						outputtext = outputtext .. "Iceblood Tower ";
					elseif ((string.find(msg,"SH") or string.find(msg,"STONE(%s+)HEARTH")) and (string.find(msg,"BUNKER"))) then
						-- Incoming Stonehearth Bunker
						outputtext = outputtext .. "Stonehearth Bunker ";
					elseif (string.find(msg,"SH") or string.find(msg,"STONE(%s+)HEARTH")) then
						-- Incoming Stonehearth Graveyard
						outputtext = outputtext .. "Stonehearth Graveyard ";
					elseif (((string.find(msg,"FW") or string.find(msg,"FROST(%s+)WOLF")) and (string.find(msg,"RELIEF(%s+)HUT") or string.find(msg,"RH")))
							or (string.find(msg,"RELIEF(%s+)HUT")) or (string.find(msg,"BASE(%s+)GY") and UnitFactionGroup("player") == "Horde")) then
						-- Incoming Frostwolf Relief Hut
						outputtext = outputtext .. "Frostwolf Relief Hut ";
					elseif (string.find(msg,"FW") or string.find(msg,"FROST(%s+)WOLF")) then
						-- Incoming Frostwolf Graveyard
						outputtext = outputtext .. "Frostwolf Graveyard ";
					elseif (((string.find(msg,"SP") or string.find(msg,"STORM(%s+)PIKE")) and (string.find(msg,"AID(%s+)STATION") or string.find(msg,"AS")))
							or (string.find(msg,"AID(%s+)STATION")) or (string.find(msg,"BASE(%s+)GY") and UnitFactionGroup("player") == "Alliance")) then
						-- Incoming Stormpike Aid Station
						outputtext = outputtext .. "Stormpike Aid Station ";
					elseif (string.find(msg,"SP") or string.find(msg,"STORM(%s+)PIKE")) then
						-- Incoming Stormpike Graveyard
						outputtext = outputtext .. "Stormpike Graveyard ";
					elseif (string.find(msg,"EAST") and string.find(msg,"TOWER")) then
						-- Incoming East Frostwolf Tower
						outputtext = outputtext .. "East Frostwolf Tower ";
					elseif (string.find(msg,"WEST") and string.find(msg,"TOWER")) then
						-- Incoming West Frostwolf Tower
						outputtext = outputtext .. "West Frostwolf Tower ";
					elseif (string.find(msg,"NORTH") and string.find(msg,"BUNKER")) then
						-- Incoming Dun Baldar North Bunker
						outputtext = outputtext .. "Dun Baldar North Bunker ";
					elseif (string.find(msg,"SOUTH") and string.find(msg,"BUNKER")) then
						-- Incoming Dun Baldar South Bunker
						outputtext = outputtext .. "Dun Baldar South Bunker ";
					elseif (string.find(msg,"BOSS") and UnitFactionGroup("player") == "Horde") then
						-- Incoming Drek'Thar
						outputtext = outputtext .. "Drek Thar ";
					elseif (string.find(msg,"BOSS") and UnitFactionGroup("player") == "Alliance") then
						-- Incoming Vanndar Stormpike
						outputtext = outputtext .. "Vanndar Stormpike ";
					elseif (string.find(msg,"BIG") or string.find(msg,"A(%s+)LOT") or string.find(msg,"MANY")) then
						-- Incoming Big
						outputtext = outputtext .. "Many ";
					elseif (begindigit) then
						local number = tonumber(string.sub(msg,begindigit,enddigit));
						if (number <= 10 and number > 0) then
							-- Incoming Number
							outputtext = outputtext .. number;
						else
							-- Incoming Big
							outputtext = outputtext .. "Many";
						end
					end
				end
			BGTextAlerts_ShowText(outputtext,NEUTRAL_COLORS);
		end
	end
end

function BGTextAlerts_CheckForBuffs()

	if  not ((GetRealZoneText() == "Alterac Valley") or (GetRealZoneText() == "Warsong Gulch") or (GetRealZoneText() == "Arathi Basin")) then
		BGTextAlerts_HasBerserking = false;
		BGTextAlerts_HasSpeed = false;
		BGTextAlerts_HasRestoration = false;
		return;
	end

	local hasSpeed = false;
	local hasBerserking = false;
	local hasRestoration = false;
	
	-- Check for new power ups and play a sounds if there is a power up
	local i;
	for i = 1, 40 do
		local name = UnitBuff("player",i);
		if (not name) then
			-- No more debuffs
			i = 40;					-- Terminate loop
		else
			if (name == "Interface\\Icons\\INV_Enchant_EssenceNetherLarge") then
				-- Found speed
				if (not BGTextAlerts_HasSpeed) then
					-- Gained speed
					BGTextAlerts_ShowText("You gain Speed.",NEUTRAL_COLORS);
				end
				hasSpeed = true;
			elseif (name == "Interface\\Icons\\INV_Misc_Fork&Knife") then
				-- Found restoration
				if (not BGTextAlerts_HasRestoration) then
					-- Gained restoration
					BGTextAlerts_ShowText("You gain Restoration.",NEUTRAL_COLORS);
				end
				hasRestoration = true;
			elseif (name == "Interface\\Icons\\Spell_Nature_BloodLust") then
				-- Found berserking
				if (not BGTextAlerts_HasBerserking) then
					-- Gained berserking
					BGTextAlerts_ShowText("You gain Berserking.",NEUTRAL_COLORS);
				end
				hasBerserking = true;
			end
		end
	end
	for i = 1, 40 do
		local name = UnitDebuff("player",i);
		if (not name) then
			-- No more debuffs
			i = 40;					-- Terminate loop
		else
			if (name == "Speed") then
				-- Found speed
				if (not BGTextAlerts_HasSpeed) then
					-- Gained speed
					BGTextAlerts_ShowText("You gain Speed.",NEUTRAL_COLORS);
				end
				hasSpeed = true;
			elseif (name == "Restoration") then
				-- Found restoration
				if (not BGTextAlerts_HasRestoration) then
					-- Gained restoration
					BGTextAlerts_ShowText("You gain Restoration.",NEUTRAL_COLORS);
				end
				hasRestoration = true;
			elseif (name == "Berserking") then
				-- Found berserking
				if (not BGTextAlerts_HasBerserking) then
					-- Gained berserking
					BGTextAlerts_ShowText("You gain Berserking.",NEUTRAL_COLORS);
				end
				hasBerserking = true;
			end
		end
	end
	
	
	BGTextAlerts_HasBerserking = hasBerserking;
	BGTextAlerts_HasSpeed = hasSpeed;
	BGTextAlerts_HasRestoration = hasRestoration;

end	

function BGTextAlerts_CheckFlagHealth(unit)

	if (UnitName(unit) ~= BGTextAlerts_FlagCarrierName) then
		return;			-- Not flag carrier
	end
	
	if (UnitHealth(unit) / UnitHealthMax(unit) * 100) <= 25 then
		-- Critically injured
		if (not BGTextAlerts_FlagHealthAnnounced) then
			BGTextAlerts_FlagHealthAnnounced = true;
			BGTextAlerts_ShowText("The " .. UnitFactionGroup("player") .. " flag carrier is critically injured. (" .. tostring(floor(UnitHealth(unit) / UnitHealthMax(unit) * 100 + 0.5)) .. "%)",getglobal(string.upper(UnitFactionGroup("player")) .. "_COLORS"),getglobal(string.upper(UnitFactionGroup("player")) .. "_ICON"));
		end
	else
		BGTextAlerts_FlagHealthAnnounced = false;
	end
	
end

function BGTextAlerts_TextTest()

	BGTextAlerts_ShowText("The quick brown fox jumps over the lazy dog!?.",NEUTRAL_COLORS,ALLIANCE_ICON);
	
end
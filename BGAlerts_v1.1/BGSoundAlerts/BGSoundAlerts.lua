WOW_DEF_DIR = "Interface\\AddOns\\BGSoundAlerts\\";
local CURRENT_PATCH_VERSION = 2.3;
local NEW_VERSION_ALERT = 0;
local _ERRORMESSAGE_TEMP = _ERRORMESSAGE;

BGSoundAlerts_FlagCarrierName = "";
BGSoundAlerts_FlagHealthAnnounced = false;

BGSoundAlerts_HasRestoration = false;
BGSoundAlerts_HasBerserking = false;
BGSoundAlerts_HasSpeed = false;

-- BGSoundAlerts Debug processes
function BGSoundAlerts_OutputErrorFunction(uncapmessage)
	
	message = string.upper(uncapmessage);
	
	if (string.find(message,"BGSOUNDALERTS") ~= nil) then
		-- It's a BGSoundAlerts Error
		StaticPopupDialogs["BGSOUNDALERTS_ERROR"] = {
			text = TEXT("BGSoundAlerts has encountered an error. Please check the error and report it.");
			button1 = TEXT("Check Error"),
			button2 = TEXT("Close"),
			OnAccept = function()
						ShowUIPanel(BGSoundAlertsErrorFrame);
						BGSoundAlertsErrorFrame_EditBox:HighlightText();
					   end,
			timeout = 180
			};
	
		StaticPopup_Show("BGSOUNDALERTS_ERROR");
	
		-- Set the error into the error frame text
		BGSoundAlertsErrorFrame_EditBox:SetText(uncapmessage);
		
		-- Update the scroll child rectangle
		BGSoundAlertsErrorFrame_ScrollFrame:UpdateScrollChildRect();
		
		-- Run normal ErrorMessage
		_ERRORMESSAGE_TEMP(uncapmessage);
		
		ScriptErrors:Hide();
	else
		-- Run normal ErrorMessage
		_ERRORMESSAGE_TEMP(uncapmessage);
	end

end

-- BGSoundAlerts Functions

function BGSoundAlerts_Load()

	UIPanelWindows["BGSoundAlertsPatchNotes"] = { area = "left", pushable = 0 };
	UIPanelWindows["BGSoundAlertsErrorFrame"] = { area = "left", pushable = 0 };
	
	this:RegisterEvent("CHAT_MSG_BG_SYSTEM_ALLIANCE");
	this:RegisterEvent("CHAT_MSG_BG_SYSTEM_HORDE");
	this:RegisterEvent("CHAT_MSG_BG_SYSTEM_NEUTRAL");
	this:RegisterEvent("CHAT_MSG_BATTLEGROUND");
	this:RegisterEvent("CHAT_MSG_BATTLEGROUND_LEADER");
	this:RegisterEvent("CHAT_MSG_RAID");
	this:RegisterEvent("CHAT_MSG_RAID_LEADER");
	this:RegisterEvent("CHAT_MSG_RAID_WARNING");
	this:RegisterEvent("CHAT_MSG_YELL");
	this:RegisterEvent("CHAT_MSG_MONSTER_YELL");
	this:RegisterEvent("CHAT_MSG_ADDON");
	this:RegisterEvent("CHAT_MSG_GUILD");
	this:RegisterEvent("UNIT_HEALTH");
	this:RegisterEvent("ZONE_CHANGED");
	this:RegisterEvent("PLAYER_AURAS_CHANGED");
	this:RegisterEvent("RAID_ROSTER_UPDATE");
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("UPDATE_BATTLEFIELD_SCORE");
	
	StaticPopupDialogs["BGSOUNDALERTS_NEWVERSION"] = {
		text = TEXT("BGSoundAlerts Version "  .. CURRENT_PATCH_VERSION .. " installed!"),
		button1 = TEXT("See Patch Notes"),
		button2 = TEXT("Close"),
		OnAccept = BGSoundAlerts_ShowPatchNotes,
		timeout = 60
	};
	
	-- Register for a tab with the BGAlerts interface
	BGAlerts_RegisterAddon("BGSoundAlerts",BGSoundAlerts_Accept,BGSoundAlerts_Show,
							     BGSoundAlertsMainFrame);
							     	
	SlashCmdList["BG_SOUND_ALERTS"] = BGSoundAlerts_ShowUI;
	SLASH_BG_SOUND_ALERTS1 = "/bgsalerts";
	
	-- Hook the error message frame
	--_ERRORMESSAGE = BGSoundAlerts_OutputErrorFunction;
	-- seterrorhandler(BGSoundAlerts_OutputErrorFunction);
	
end

function BGSoundAlerts_ShowUI(cmd)
	ShowUIPanel(BGAlertsMainFrame);
	BGAlerts_ShowAddonPanel("BGSoundAlerts");
	
	-- SetupFullscreenScale(BGAlertsMainFrame);
end

function BGSoundAlerts_Event(eventType,chatMsg,chatAuthor,extraArg)

	if (eventType == "UNIT_HEALTH") then
		if (WSGHealth == 1) then
			BGSoundAlerts_CheckFlagHealth(chatMsg);
		end
	end
	
	if (eventType == "ZONE_CHANGED") then
		if (GetRealZoneText() ~= "Warsong Gulch") then
			BGSoundAlerts_FlagCarrierName = "";
			BGSoundAlerts_FlagHealthAnnounced = false;
		end
	end

	if (eventType == "CHAT_MSG_BG_SYSTEM_ALLIANCE") then
		BGSoundAlerts_AllianceSound(chatMsg);
		return;
	end
		
	if (eventType == "CHAT_MSG_BG_SYSTEM_HORDE") then
		BGSoundAlerts_HordeSound(chatMsg);
		return;
	end
	
	if (eventType == "CHAT_MSG_BG_SYSTEM_NEUTRAL") then
		BGSoundAlerts_NeutralSound(chatMsg);
		return;
	end

	if (eventType == "CHAT_MSG_YELL" or eventType == "CHAT_MSG_MONSTER_YELL") then
		BGSoundAlerts_AVSound(chatMsg,chatAuthor);
		return;
	end
	
	if (eventType == "VARIABLES_LOADED") then
		BGSoundAlerts_Initiate();
		BGTextAlerts_NextKillUpdate = 25;				-- This is temporary so that it will reflect BGSoundAlert's NextKillUpdate variable
		-- This here disabled
		-- Check with your guild mates and your current raid or party for new versions of BGSoundAlerts
		--BGSoundAlerts_CheckForNewVersion("GUILD");
		--BGSoundAlerts_CheckForNewVersion("RAID");
		return;
	end

	if (eventType == "CHAT_MSG_GUILD" or eventType == "RAID_ROSTER_UPDATE") then
		-- Check with your guild mates and your current raid or party for new versions of BGSoundAlerts
		-- DEFAULT_CHAT_FRAME:AddMessage("Checking version once again.");
		BGSoundAlerts_CheckForNewVersion("GUILD");
		BGSoundAlerts_CheckForNewVersion("BATTLEGROUND");
		return;
	end
	
	if (eventType == "CHAT_MSG_BATTLEGROUND" or eventType == "CHAT_MSG_BATTLEGROUND_LEADER" or
		eventType == "CHAT_MSG_RAID_WARNING" or eventType == "CHAT_MSG_RAID" or
		eventType == "CHAT_MSG_RAID_LEADER") then
		BGSoundAlerts_IncomingSound(chatMsg);
	end
	
	if (eventType == "CHAT_MSG_ADDON" and chatMsg == "BGSAlertsVersion"
		and chatAuthor == "VersionCheck") then
		BGSoundAlerts_SendVersion(extraArg);
	end
	
	if (eventType == "CHAT_MSG_ADDON" and chatMsg == "BGSAlertsVersion"
	    and tonumber(chatAuthor)) then
		-- Received a version number
		-- ChatFrame2:AddMessage("Receiving version from ".. arg4 .. "(using version " .. chatAuthor .. ")");
		BGSoundAlerts_CompareVersion(chatAuthor);
	end
	
	if (eventType == "PLAYER_AURAS_CHANGED") then
		-- Changed debuffs
		BGSoundAlerts_CheckForBuffs();
	end
	
	if (eventType == "UPDATE_WORLD_STATES") then
		-- Check for new BGSoundAlerts version with the rest of the battleground
		BGSoundAlerts_CheckForNewVersion("BATTLEGROUND");
	end
	
end

function BGSoundAlerts_CheckForNewVersion(checkDest)
	
	-- Send a message to checkDest to request BGSoundAlerts version number
	-- DEFAULT_CHAT_FRAME:AddMessage("Checking version on" .. checkDest);
	if (checkDest == "GUILD" and (not IsInGuild())) then
		return;
	end
	SendAddonMessage("BGSAlertsVersion","VersionCheck",checkDest);
	
end

function BGSoundAlerts_SendVersion(checkDest)
	
	-- Send our version number
	-- DEFAULT_CHAT_FRAME:AddMessage("Sending our version to " .. checkDest);
	if (checkDest == "GUILD" and (not IsInGuild())) then
		return;
	end
	SendAddonMessage("BGSAlertsVersion",CURRENT_PATCH_VERSION,checkDest);
	
end

function BGSoundAlerts_CompareVersion(number)
	
	-- Compare our version with the received one
	if (NEW_VERSION_ALERT == 0 and tonumber(number) > CURRENT_PATCH_VERSION) then
		if (BGSoundAlerts_VersionChecking == 1) then
			UIErrorsFrame:AddMessage(string.format(BGS_S_NEWVERSIONTEXT,number),1,1,0,10);
		end
		BGSoundAlerts_NewVersionText:SetText(string.format(BGS_S_NEWVERSIONTEXT,number));
		BGSoundAlerts_NewVersionText:Show();
		NEW_VERSION_ALERT = 1;
	end
	
end

function BGSoundAlerts_Initiate()
	
	DEFAULT_CHAT_FRAME:AddMessage(string.format(BGS_S_LOADED,CURRENT_PATCH_VERSION),0.0,1.0,0.0,1.0);
	
	if (WSGEvents == nil) then
		WSGEvents = 1;
	end
	
	if (WSGScore == nil) then
		WSGScore = 1;
	end
	
	if (WSGHealth == nil) then
		WSGHealth = 1;
	end
	
	if (ABEvents == nil) then
		ABEvents = 1;
	end
	
	if (ABScore == nil) then
		ABScore = 1;
	end
	
	if (ABScoreDelay == nil) then
		ABScoreDelay = 5;
	end
	
	if (AVMainEvents == nil) then
		AVMainEvents = 1;
	end
	
	if (AVExtraEvents == nil) then
		AVExtraEvents = 1;
	end
	
	if (SoundsPack == nil) then
		SoundsPack = "DefaultPack";
	end
	
	if (VictoryDefeatSounds == nil) then
		VictoryDefeatSounds = 1;
	end
	
	if (IncomingSounds == nil) then
		IncomingSounds = 1;
	end
	
	if (MultiKillSounds == nil) then
		MultiKillSounds = 1;
	end
	
	if (BGSoundAlerts_ResourcesByUpdate == nil) then
		BGSoundAlerts_ResourcesByUpdate = 1;
	end
	
	if (FirstBloodSounds == nil) then
		FirstBloodSounds = 1;
	end
	
	if (BGSoundAlerts_VersionChecking == nil) then
		BGSoundAlerts_VersionChecking = 1;
	end
	
	if (BuffSounds == nil) then
		BuffSounds = 1;
	end
	
	if (PauseInVoiceChat == nil) then
		PauseInVoiceChat = 1;
	end
	
	if (BGSoundAlerts_PatchVersion == nil or BGSoundAlerts_PatchVersion < CURRENT_PATCH_VERSION) then
	--	BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. "\\NewPatchInstalled.wav");
		BGSoundAlerts_PatchVersion = CURRENT_PATCH_VERSION;
		StaticPopup_Show("BGSOUNDALERTS_NEWVERSION");
	end
			
end

function BGSoundAlerts_InitiateOpp()
	-- This function will check if any checkboxes are unchecked and set the vars to 0 rather than nil
	if (WSGEvents == nil) then
		WSGEvents = 0;
	end
	
	if (WSGScore == nil) then
		WSGScore = 0;
	end
	
	if (WSGHealth == nil) then
		WSGHealth = 0;
	end
	
	if (ABEvents == nil) then
		ABEvents = 0;
	end
	
	if (ABScore == nil) then
		ABScore = 0;
	end
	
	if (AVMainEvents == nil) then
		AVMainEvents = 0;
	end
	
	if (AVExtraEvents == nil) then
		AVExtraEvents = 0;
	end
	
	if (VictoryDefeatSounds == nil) then
		VictoryDefeatSounds = 0;
	end
	
	if (IncomingSounds == nil) then
		IncomingSounds = 0;
	end
	
	if (MultiKillSounds == nil) then
		MultiKillSounds = 0;
	end
	
	if (BGSoundAlerts_ResourcesByUpdate == nil) then
		BGSoundAlerts_ResourcesByUpdate = 0;
	end
	
	if (FirstBloodSounds == nil) then
		FirstBloodSounds = 0;
	end
	
	if (BGSoundAlerts_VersionChecking == nil) then
		BGSoundAlerts_VersionChecking = 0;
	end
	
	if (BuffSounds == nil) then
		BuffSounds = 0;
	end
	
	if (PauseInVoiceChat == nil) then
		PauseInVoiceChat = 0;
	end
	
end

function BGSoundAlerts_Show()

	WSGSoundScore_Check:SetChecked(WSGScore);
	WSGSoundEvents_Check:SetChecked(WSGEvents);
	WSGSoundHealth_Check:SetChecked(WSGHealth);
	ABSoundEvents_Check:SetChecked(ABEvents);
	ABSoundScore_Check:SetChecked(ABScore);
	ResourcesByUpdate_Check:SetChecked(BGSoundAlerts_ResourcesByUpdate);
	BGSoundAlerts_ABScoreInterval:SetText(tostring(ABScoreDelay));
	AVSoundMainEvents_Check:SetChecked(AVMainEvents);
	AVSoundExtraEvents_Check:SetChecked(AVExtraEvents);
	VictoryDefeatSounds_Check:SetChecked(VictoryDefeatSounds);
	IncomingSounds_Check:SetChecked(IncomingSounds);
	MultiKillSounds_Check:SetChecked(MultiKillSounds);
	FirstBloodSounds_Check:SetChecked(FirstBloodSounds);
	BGSoundAlerts_PackName:SetText(tostring(SoundsPack));
	VersionChecking_Check:SetChecked(BGSoundAlerts_VersionChecking);
	BuffSounds_Check:SetChecked(BuffSounds);
	PauseInVoiceChat_Check:SetChecked(PauseInVoiceChat);
	
end

function BGSoundAlerts_Accept()
	
	-- Check if it's a number. Show error and options panel again if not
	if (tonumber(BGSoundAlerts_ABScoreInterval:GetText())) then
		if (tonumber(BGSoundAlerts_ABScoreInterval:GetText()) >= 1) then
			ABScoreDelay = tonumber(BGSoundAlerts_ABScoreInterval:GetText());
			ABScoreDelay = floor(ABScoreDelay);					-- Round the number down
		end
	else
		UIErrorsFrame:AddMessage("Invalid Number Entry. Please enter the ABScoreDelay value again.");
		ShowUIPanel(BGAlertsMainFrame);
		BGAlerts_ShowAddonPanel("BGSoundAlerts");
		return;
	end
	WSGScore = WSGSoundScore_Check:GetChecked();
	WSGEvents = WSGSoundEvents_Check:GetChecked();
	WSGHealth = WSGSoundHealth_Check:GetChecked();
	ABEvents = ABSoundEvents_Check:GetChecked();
	ABScore = ABSoundScore_Check:GetChecked();
	BGSoundAlerts_ResourcesByUpdate = ResourcesByUpdate_Check:GetChecked();
	AVMainEvents = AVSoundMainEvents_Check:GetChecked();
	AVExtraEvents = AVSoundExtraEvents_Check:GetChecked();
	VictoryDefeatSounds = VictoryDefeatSounds_Check:GetChecked();
	IncomingSounds = IncomingSounds_Check:GetChecked();
	FirstBloodSounds = FirstBloodSounds_Check:GetChecked();
	MultiKillSounds = MultiKillSounds_Check:GetChecked();
	SoundsPack = BGSoundAlerts_PackName:GetText();
	BuffSounds = BuffSounds_Check:GetChecked();
	PauseInVoiceChat = PauseInVoiceChat_Check:GetChecked();
	BGSoundAlerts_VersionChecking = VersionChecking_Check:GetChecked();
	
	-- Check for nils
	BGSoundAlerts_InitiateOpp();
	
end
	
function BGSoundAlerts_AllianceSound(msg)

	if (string.find(msg,BGS_S_ALLIANCEFLAGRETURNED) ~= nil and WSGEvents == 1) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\AllianceFlagReturned.wav");
		return;
	end
	
	if (string.find(msg,BGS_S_HORDEFLAGPICKEDUP) ~= nil) then
		if (WSGEvents == 1) then
			BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\HordeFlagTaken.wav");
		end
		if (UnitFactionGroup("player") == "Alliance") then
			-- Mark flag carrier
			BGSoundAlerts_FlagCarrierName = string.sub(msg,33,string.len(msg)-1);
			BGSoundAlerts_FlagHealthAnnounced = false;
		end
		return;
	end
	
	if (string.find(msg,BGS_S_ALLIANCEFLAGDROPPED) ~= nil) then
		if (UnitFactionGroup("player") == "Horde") then
			-- Mark flag carrier
			BGSoundAlerts_FlagCarrierName = "";
			BGSoundAlerts_FlagHealthAnnounced = false;
		end
		return;
	end
	
	_, _, AllianceScore = GetWorldStateUIInfo(1);
	
	if (string.find(msg,BGS_S_HORDEFLAGCAPTURED) ~= nil) then
		if (WSGEvents == 1 and AllianceScore ~= "3/3") then
			BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\HordeFlagCaptured.wav");
		end
		if (UnitFactionGroup("player") == "Alliance") then
			-- Mark flag carrier
			BGSoundAlerts_FlagCarrierName = "";
			BGSoundAlerts_FlagHealthAnnounced = false;
		end
		return;
	end
	
	if (string.find(msg,BGS_S_STABLESASSAULTED) ~= nil and ABEvents == 1) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\AllianceAssaultedStables.wav");
		return;
	end
	
	if (string.find(msg,BGS_S_LUMBERMILLASSAULTED) ~= nil and ABEvents == 1) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\AllianceAssaultedLumbermill.wav");
		return;
	end
	
	if (string.find(msg,BGS_S_BLACKSMITHASSAULTED) ~= nil and ABEvents == 1) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\AllianceAssaultedBlacksmith.wav");
		return;
	end
	
	if (string.find(msg,BGS_S_MINEASSAULTED) ~= nil and ABEvents == 1) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\AllianceAssaultedGoldMine.wav");
		return;
	end
	
	if (string.find(msg,BGS_S_FARMASSAULTED) ~= nil and ABEvents == 1) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\AllianceAssaultedFarm.wav");
		return;
	end
	
	if (string.find(msg,BGS_S_STABLESTAKEN) ~= nil and ABEvents == 1) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\AllianceTakenStables.wav");
		return;
	end
	
	if (string.find(msg,BGS_S_LUMBERMILLTAKEN) ~= nil and ABEvents == 1) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\AllianceTakenLumbermill.wav");
		return;
	end
	
	if (string.find(msg,BGS_S_BLACKSMITHTAKEN) ~= nil and ABEvents == 1) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\AllianceTakenBlacksmith.wav");
		return;
	end
	
	if (string.find(msg,BGS_S_MINETAKEN) ~= nil and ABEvents == 1) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\AllianceTakenGoldMine.wav");
		return;
	end
	
	if (string.find(msg,BGS_S_FARMTAKEN) ~= nil and ABEvents == 1) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\AllianceTakenFarm.wav");
		return;
	end
	
	if (string.find(msg,BGS_S_LUMBERMILLCLAIMS) ~= nil and ABEvents == 1) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\AllianceAssaultedLumbermill.wav");
		return;
	end
	
	if (string.find(msg,BGS_S_BLACKSMITHCLAIMS) ~= nil and ABEvents == 1) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\AllianceAssaultedBlacksmith.wav");
		return;
	end
	
	if (string.find(msg,BGS_S_MINECLAIMS) ~= nil and ABEvents == 1) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\AllianceAssaultedGoldMine.wav");
		return;
	end
	
	if (string.find(msg,BGS_S_FARMCLAIMS) ~= nil and ABEvents == 1) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\AllianceAssaultedFarm.wav");
		return;
	end
	
	if (string.find(msg,BGS_S_STABLESCLAIMS) ~= nil and ABEvents == 1) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\AllianceAssaultedStables.wav");
		return;
	end
	
	if (AVMainEvents == 1) then
		
		if (string.find(msg,BGS_S_SNOWFALLGRAVEYARDCLAIMS)) then
			BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\AllianceAssaultedSnowfallGraveyard.wav");
			return;
		end
	
	end
	
	if (string.find(msg,BGS_S_WINS) ~= nil) then
		BGSoundAlerts_ClearSoundQueue();
		BGSoundAlerts_EndGameSound(msg);
	end
end

function BGSoundAlerts_HordeSound(msg)

	if (string.find(msg,BGS_S_HORDEFLAGRETURNED) ~= nil and WSGEvents == 1) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\HordeFlagReturned.wav");
		return;
	end
	
	if (string.find(msg,BGS_S_ALLIANCEFLAGPICKED) ~= nil) then
		if (WSGEvents == 1) then
			BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\AllianceFlagTaken.wav");
		end
		if (UnitFactionGroup("player") == "Horde") then
			-- Mark flag carrier
			BGSoundAlerts_FlagCarrierName = string.sub(msg,36,string.len(msg)-1);
			BGSoundAlerts_FlagHealthAnnounced = false;
		end
		return;
	end
	
	if (string.find(msg,BGS_S_HORDEFLAGDROPPED) ~= nil) then
		if (UnitFactionGroup("player") == "Alliance") then
			-- Mark flag carrier
			BGSoundAlerts_FlagCarrierName = "";
			BGSoundsAlerts_FlagHealthAnnounced = false;
		end
	end
	
	_, _, HordeScore = GetWorldStateUIInfo(2);
	
	if (string.find(msg,BGS_S_ALLIANCEFLAGCAPTURED) ~= nil) then
		if (WSGEvents == 1 and HordeScore ~= "3/3") then
			BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\AllianceFlagCaptured.wav");
		end
		if (UnitFactionGroup("player") == "Horde") then
			BGSoundAlerts_FlagCarrierName = "";
			BGSoundAlerts_FlagHealthAnnounced = false;
		end
		return;
	end
	
	if (string.find(msg,BGS_S_STABLESASSAULTED) ~= nil and ABEvents == 1) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\HordeAssaultedStables.wav");
		return;
	end
	
	if (string.find(msg,BGS_S_LUMBERMILLASSAULTED) ~= nil and ABEvents == 1) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\HordeAssaultedLumbermill.wav");
		return;
	end
	
	if (string.find(msg,BGS_S_BLACKSMITHASSAULTED) ~= nil and ABEvents == 1) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\HordeAssaultedBlacksmith.wav");
		return;
	end
	
	if (string.find(msg,BGS_S_MINEASSAULTED) ~= nil and ABEvents == 1) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\HordeAssaultedGoldMine.wav");
		return;
	end
	
	if (string.find(msg,BGS_S_FARMASSAULTED) ~= nil and ABEvents == 1) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\HordeAssaultedFarm.wav");
		return;
	end
	
	if (string.find(msg,BGS_S_STABLESTAKEN) ~= nil and ABEvents == 1) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\HordeTakenStables.wav");
		return;
	end
	
	if (string.find(msg,BGS_S_LUMBERMILLTAKEN) ~= nil and ABEvents == 1) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\HordeTakenLumbermill.wav");
		return;
	end
	
	if (string.find(msg,BGS_S_BLACKSMITHTAKEN) ~= nil and ABEvents == 1) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\HordeTakenBlacksmith.wav");
		return;
	end
	
	if (string.find(msg,BGS_S_MINETAKEN) ~= nil and ABEvents == 1) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\HordeTakenGoldMine.wav");
		return;
	end
	
	if (string.find(msg,BGS_S_FARMTAKEN) ~= nil and ABEvents == 1) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\HordeTakenFarm.wav");
		return;
	end
	
	if (string.find(msg,BGS_S_STABLESCLAIMS) ~= nil and ABEvents == 1) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\HordeAssaultedStables.wav");
		return;
	end
	
	if (string.find(msg,BGS_S_LUMBERMILLCLAIMS) ~= nil and ABEvents == 1) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\HordeAssaultedLumbermill.wav");
		return;
	end
	
	if (string.find(msg,BGS_S_BLACKSMITHCLAIMS) ~= nil and ABEvents == 1) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\HordeAssaultedBlacksmith.wav");
		return;
	end
	
	if (string.find(msg,BGS_S_MINECLAIMS) ~= nil and ABEvents == 1) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\HordeAssaultedGoldMine.wav");
		return;
	end
	
	if (string.find(msg,BGS_S_FARMCLAIMS) ~= nil and ABEvents == 1) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\HordeAssaultedFarm.wav");
		return;
	end
	
	if (AVMainEvents == 1) then
		
		if (string.find(msg,BGS_S_SNOWFALLGRAVEYARDCLAIMS)) then
			BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\HordeAssaultedSnowfallGraveyard.wav");
			return;
		end
	
	end
	
	if (string.find(msg,BGS_S_WINS) ~= nil) then
		BGSoundAlerts_ClearSoundQueue();
		BGSoundAlerts_EndGameSound(msg);
	end
	
end

function BGSoundAlerts_NeutralSound(msg)

	if (string.find(msg,BGS_S_PLACEDATBASES) ~= nil and WSGScore == 1) then
		BGSounds_ScoreSound();
		return;
	end
	
	if (string.find(msg,BGS_S_HORDEFLAGRETURNED_2) ~= nil and WSGEvents == 1) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\HordeFlagReturned.wav");
		return;
	end
	
	if (string.find(msg,BGS_S_ALLIANCEFLAGRETURNED_2) ~= nil and WSGEvents == 1) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\AllianceFlagReturned.wav");
		return;
	end
	
	if (string.find(msg,BGS_S_WINS) ~= nil) then
		BGSoundAlerts_EndGameSound(msg);
	end
	
end

-- The following is the very BIG list of events that happen in AV
function BGSoundAlerts_AVSound(chatMsg,chatAuthor)
	
	if (AVMainEvents == 1) then
	-- Alliance Assaulted Graveyards
	if (string.find(chatMsg,BGS_S_ALLIANCEATTACKICEBLOODGRAVEYARD) ~= nil and chatAuthor == BGS_S_HERALD) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\AllianceAssaultedIcebloodGraveyard.wav");
		return;
	end
	
	if (string.find(chatMsg,BGS_S_ALLIANCEATTACKSTONEHEARTHGRAVEYARD) ~= nil and chatAuthor == BGS_S_HERALD) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\AllianceAssaultedStonehearthGraveyard.wav");
		return;
	end
	
	if (string.find(chatMsg,BGS_S_ALLIANCEATTACKSNOWFALLGRAVEYARD) ~= nil and chatAuthor == BGS_S_HERALD) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\AllianceAssaultedSnowfallGraveyard.wav");
		return;
	end
	
	if (string.find(chatMsg,BGS_S_ALLIANCEATTACKFROSTWOLFGRAVEYARD) ~= nil and chatAuthor == BGS_S_HERALD) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\AllianceAssaultedFrostwolfGraveyard.wav");
		return;
	end
	
	if (string.find(chatMsg,BGS_S_ALLIANCEATTACKSTORMPIKEGRAVEYARD) ~= nil and chatAuthor == BGS_S_HERALD) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\AllianceAssaultedStormpikeGraveyard.wav");
		return;
	end
	
	if (string.find(chatMsg,BGS_S_ALLIANCEATTACKFROSTWOLFRELIEFHUT) ~= nil and chatAuthor == BGS_S_HERALD) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\AllianceAssaultedFrostwolfAidStation.wav");
		return;
	end
	
	if (string.find(chatMsg,BGS_S_ALLIANCEATTACKSTORMPIKEAIDSTATION) ~= nil and chatAuthor == BGS_S_HERALD) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\AllianceAssaultedStormpikeAidStation.wav");
		return;
	end

	-- Alliance taken Graveyards
	if (string.find(chatMsg,BGS_S_ALLIANCETAKENICEBLOODGRAVEYARD) ~= nil and chatAuthor == BGS_S_HERALD) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\AllianceTakenIcebloodGraveyard.wav");
		return;
	end
	
	if (string.find(chatMsg,BGS_S_ALLIANCETAKENSTONEHEARTHGRAVEYARD) ~= nil and chatAuthor == BGS_S_HERALD) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\AllianceTakenStonehearthGraveyard.wav");
		return;
	end
	
	if (string.find(chatMsg,BGS_S_ALLIANCETAKENSNOWFALLGRAVEYARD) ~= nil and chatAuthor == BGS_S_HERALD) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\AllianceTakenSnowfallGraveyard.wav");
		return;
	end
	
	if (string.find(chatMsg,BGS_S_ALLIANCETAKENFROSTWOLFGRAVEYARD) ~= nil and chatAuthor == BGS_S_HERALD) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\AllianceTakenFrostwolfGraveyard.wav");
		return;
	end
	
	if (string.find(chatMsg,BGS_S_ALLIANCETAKENSTORMPIKEGRAVEYARD) ~= nil and chatAuthor == BGS_S_HERALD) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\AllianceTakenStormpikeGraveyard.wav");
		return;
	end
	
	if (string.find(chatMsg,BGS_S_ALLIANCETAKENFROSTWOLFRELIEFHUT) ~= nil and chatAuthor == BGS_S_HERALD) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\AllianceTakenFrostwolfAidStation.wav");
		return;
	end
	
	if (string.find(chatMsg,BGS_S_ALLIANCETAKENSTORMPIKEAIDSTATION) ~= nil and chatAuthor == BGS_S_HERALD) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\AllianceTakenStormpikeAidStation.wav");
		return;
	end
	
	-- Horde Assaulted Graveyards
	if (string.find(chatMsg,BGS_S_HORDEATTACKICEBLOODGRAVEYARD) ~= nil and chatAuthor == BGS_S_HERALD) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\HordeAssaultedIcebloodGraveyard.wav");
		return;
	end
	
	if (string.find(chatMsg,BGS_S_HORDEATTACKSTONEHEARTHGRAVEYARD) ~= nil and chatAuthor == BGS_S_HERALD) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\HordeAssaultedStonehearthGraveyard.wav");
		return;
	end
	
	if (string.find(chatMsg,BGS_S_HORDEATTACKSNOWFALLGRAVEYARD) ~= nil and chatAuthor == BGS_S_HERALD) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\HordeAssaultedSnowfallGraveyard.wav");
		return;
	end
	
	if (string.find(chatMsg,BGS_S_HORDEATTACKFROSTWOLFGRAVEYARD) ~= nil and chatAuthor == BGS_S_HERALD) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\HordeAssaultedFrostwolfGraveyard.wav");
		return;
	end
	
	if (string.find(chatMsg,BGS_S_HORDEATTACKSTORMPIKEGRAVEYARD) ~= nil and chatAuthor == BGS_S_HERALD) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\HordeAssaultedStormpikeGraveyard.wav");
		return;
	end
	
	if (string.find(chatMsg,BGS_S_HORDEATTACKFROSTWOLFRELIEFHUT) ~= nil and chatAuthor == BGS_S_HERALD) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\HordeAssaultedFrostwolfAidStation.wav");
		return;
	end
	
	if (string.find(chatMsg,BGS_S_HORDEATTACKSTORMPIKEAIDSTATION) ~= nil and chatAuthor == BGS_S_HERALD) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\HordeAssaultedStormpikeAidStation.wav");
		return;
	end

	-- Horde taken Graveyards
	if (string.find(chatMsg,BGS_S_HORDETAKENICEBLOODGRAVEYARD) ~= nil and chatAuthor == BGS_S_HERALD) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\HordeTakenIcebloodGraveyard.wav");
		return;
	end
	
	if (string.find(chatMsg,BGS_S_HORDETAKENSTONEHEARTHGRAVEYARD) ~= nil and chatAuthor == BGS_S_HERALD) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\HordeTakenStonehearthGraveyard.wav");
		return;
	end
	
	if (string.find(chatMsg,BGS_S_HORDETAKENSNOWFALLGRAVEYARD) ~= nil and chatAuthor == BGS_S_HERALD) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\HordeTakenSnowfallGraveyard.wav");
		return;
	end
	
	if (string.find(chatMsg,BGS_S_HORDETAKENFROSTWOLFGRAVEYARD) ~= nil and chatAuthor == BGS_S_HERALD) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\HordeTakenFrostwolfGraveyard.wav");
		return;
	end
	
	if (string.find(chatMsg,BGS_S_HORDETAKENSTORMPIKEGRAVEYARD) ~= nil and chatAuthor == BGS_S_HERALD) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\HordeTakenStormpikeGraveyard.wav");
		return;
	end
	
	if (string.find(chatMsg,BGS_S_HORDETAKENFROSTWOLFRELIEFHUT) ~= nil and chatAuthor == BGS_S_HERALD) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\HordeTakenFrostwolfAidStation.wav");
		return;
	end
	
	if (string.find(chatMsg,BGS_S_HORDETAKENSTORMPIKEAIDSTATION) ~= nil and chatAuthor == BGS_S_HERALD) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\HordeTakenStormpikeAidStation.wav");
		return;
	end
	
	-- Towers Assaulted
	if (string.find(chatMsg,BGS_S_HORDEATTACKSTONEHEARTHBUNKER) ~= nil and chatAuthor == BGS_S_HERALD) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\StonehearthBunkerAssaulted.wav");
		return;
	end
	
	if (string.find(chatMsg,BGS_S_HORDEATTACKICEWINGBUNKER) ~= nil and chatAuthor == BGS_S_HERALD) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\IcewingBunkerAssaulted.wav");
		return;
	end
	
	if (string.find(chatMsg,BGS_S_HORDEATTACKSOUTHBUNKER) ~= nil and chatAuthor == BGS_S_HERALD) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\DunBalderSouthBunkerAssaulted.wav");
		return;
	end
	
	if (string.find(chatMsg,BGS_S_HORDEATTACKNORTHBUNKER) ~= nil and chatAuthor == BGS_S_HERALD) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\DunBalderNorthBunkerAssaulted.wav");
		return;
	end
	
	if (string.find(chatMsg,BGS_S_ALLIANCEATTACKICEBLOODTOWER) ~= nil and chatAuthor == BGS_S_HERALD) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\IcebloodTowerAssaulted.wav");
		return;
	end
	
	if (string.find(chatMsg,BGS_S_ALLIANCEATTACKTOWERPOINT) ~= nil and chatAuthor == BGS_S_HERALD) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\TowerPointAssaulted.wav");
		return;
	end
	
	if (string.find(chatMsg,BGS_S_ALLIANCEATTACKWESTTOWER) ~= nil and chatAuthor == BGS_S_HERALD) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\WestFrostwolfTowerAssaulted.wav");
		return;
	end
	
	if (string.find(chatMsg,BGS_S_ALLIANCEATTACKEASTTOWER) ~= nil and chatAuthor == BGS_S_HERALD) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\EastFrostwolfTowerAssaulted.wav");
		return;
	end
	
	-- Towers Taken
	if (string.find(chatMsg,BGS_S_ALLIANCETAKESTONEHEARTHBUNKER) ~= nil and chatAuthor == BGS_S_HERALD) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\StonehearthBunkerTaken.wav");
		return;
	end
	
	if (string.find(chatMsg,BGS_S_ALLIANCETAKEICEWINGBUNKER) ~= nil and chatAuthor == BGS_S_HERALD) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\IcewingBunkerTaken.wav");
		return;
	end
	
	if (string.find(chatMsg,BGS_S_ALLIANCETAKESOUTHBUNKER) ~= nil and chatAuthor == BGS_S_HERALD) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\DunBalderSouthBunkerTaken.wav");
		return;
	end
	
	if (string.find(chatMsg,BGS_S_ALLIANCETAKENORTHBUNKER) ~= nil and chatAuthor == BGS_S_HERALD) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\DunBalderNorthBunkerTaken.wav");
		return;
	end
	
	if (string.find(chatMsg,BGS_S_HORDETAKEICEBLOODTOWER) ~= nil and chatAuthor == BGS_S_HERALD) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\IcebloodTowerTaken.wav");
		return;
	end
	
	if (string.find(chatMsg,BGS_S_HORDETAKETOWERPOINT) ~= nil and chatAuthor == BGS_S_HERALD) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\TowerPointTaken.wav");
		return;
	end
	
	if (string.find(chatMsg,BGS_S_HORDETAKEWESTTOWER) ~= nil and chatAuthor == BGS_S_HERALD) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\WestFrostwolfTowerTaken.wav");
		return;
	end
	
	if (string.find(chatMsg,BGS_S_HORDETAKEEASTTOWER) ~= nil and chatAuthor == BGS_S_HERALD) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\EastFrostwolfTowerTaken.wav");
		return;
	end
	
	-- Towers destroyed
	if (string.find(chatMsg,BGS_S_HORDEDESTROYSTONEHEARTHBUNKER) ~= nil and chatAuthor == BGS_S_HERALD) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\StonehearthBunkerDestroyed.wav");
		return;
	end
	
	if (string.find(chatMsg,BGS_S_HORDEDESTROYICEWINGBUNKER) ~= nil and chatAuthor == BGS_S_HERALD) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\IcewingBunkerDestroyed.wav");
		return;
	end
	
	if (string.find(chatMsg,BGS_S_HORDEDESTROYSOUTHBUNKER) ~= nil and chatAuthor == BGS_S_HERALD) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\DunBalderSouthBunkerDestroyed.wav");
		return;
	end
	
	if (string.find(chatMsg,BGS_S_HORDEDESTROYNORTHBUNKER) ~= nil and chatAuthor == BGS_S_HERALD) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\DunBalderNorthBunkerDestroyed.wav");
		return;
	end
	
	if (string.find(chatMsg,BGS_S_ALLIANCEDESTROYICEBLOODTOWER) ~= nil and chatAuthor == BGS_S_HERALD) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\IcebloodTowerDestroyed.wav");
		return;
	end
	
	if (string.find(chatMsg,BGS_S_ALLIANCEDESTROYTOWERPOINT) ~= nil and chatAuthor == BGS_S_HERALD) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\TowerPointDestroyed.wav");
		return;
	end
	
	if (string.find(chatMsg,BGS_S_ALLIANCEDESTROYWESTTOWER) ~= nil and chatAuthor == BGS_S_HERALD) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\WestFrostwolfTowerDestroyed.wav");
		return;
	end
	
	if (string.find(chatMsg,BGS_S_ALLIANCEDESTROYEASTTOWER) ~= nil and chatAuthor == BGS_S_HERALD) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\EastFrostwolfTowerDestroyed.wav");
		return;
	end
	
	-- Gold Mines
	if (string.find(chatMsg,BGS_S_HORDETAKECOLDTOOTHMINE) ~= nil and chatAuthor == BGS_S_HERALD) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\HordeTakenColdtoothMine.wav");
		return;
	end
	
	if (string.find(chatMsg,BGS_S_ALLIANCETAKECOLDTOOTHMINE) ~= nil and chatAuthor == BGS_S_HERALD) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\AllianceTakenColdtoothMine.wav");
		return;
	end
	
	if (chatAuthor == BGS_S_TASKMASTERSNIVVLE) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\NeutralTakenColdtoothMine.wav");
		return;
	end
	
	if (string.find(chatMsg,BGS_S_HORDETAKEIRONDEEPMINE) ~= nil and chatAuthor == BGS_S_HERALD) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\HordeTakenIrondeepMine.wav");
		return;
	end
	
	if (string.find(chatMsg,BGS_S_ALLIANCETAKEIRONDEEPMINE) ~= nil and chatAuthor == BGS_S_HERALD) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\AllianceTakenIrondeepMine.wav");
		return;
	end
	
	if (chatAuthor == BGS_S_MORLOCH) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\NeutralTakenIrondeepMine.wav");
		return;
	end
	end
	
	if (AVExtraEvents == 1) then
	-- Alliance Ram Riders
	if (chatAuthor == BGS_S_STORMPIKERAMRIDERCOMMANDER) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\AllianceLaunchingRamRiders.wav");
		return;
	end
	
	-- Horde Frostwolf Riders
	if (chatAuthor == BGS_S_FROSTWOLFRIDERCOMMANDER) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\HordeLaunchingFrostwolfRiders.wav");
		return;
	end
	
	-- Captains under attack
	if (string.find(chatMsg,BGS_S_CAPTAINGALVANGARATTACK) ~= nil and chatAuthor == BGS_S_CAPTAINGALVANGAR) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\CaptianGalvangarUnderAttack.wav");
		return;
	end
	
	-- Can't remember whole phrase
	if (string.find(chatMsg,BGS_S_CAPTAINBALINDASTONEHEARTHATTACK) ~= nil and chatAuthor == BGS_S_CAPTAINBALINDASTONEHEARTH) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\CaptainBalindaStonehearthUnderAttack.wav");
		return;
	end
	
	-- Unit Upgrades
	if (chatAuthor == BGS_S_MURGOTDEEPFORGE) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\AllianceUpgradingUnits.wav");
		return;
	end
	
	if (chatAuthor == BGS_S_SMITHREGZAR) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\HordeUpgradingUnits.wav");
		return;
	end

	-- Generals under attack
	if (string.find(chatMsg,BGS_S_DREKTHARATTACK) ~= nil and chatAuthor == BGS_S_DREKTHAR) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\HordeGeneralUnderAttack.wav",1);
		return;
	end

	if (string.find(chatMsg,BGS_S_VANNDARSTORMPIKEATTACK) ~= nil and chatAuthor == BGS_S_VANNDARSTORMPIKE) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\AllianceGeneralUnderAttack.wav");
		return;
	end
	
	-- Horde Launching Air Support
	--[[if (string.find(chatMsg,"is joining the battle") ~= nil and chatAuthor == "Wing Commander Guse") then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\HordeAirLaunching.wav");
		return;
	end
	
	if (string.find(chatMsg,"coming for you") ~= nil and chatAuthor == "Wing Commander Jeztor") then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\HordeAirLaunching.wav");
		return;
	end]]--
	
	-- Alliance Launching Air Support
	--[[if (string.find(chatMsg,"feel the flames") ~= nil and chatAuthor == "Wing Commander Sildore") then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\AllianceAirLaunching.wav");
		return;
	end
	
	
	if (string.find(chatMsg,"for a swift death") ~= nil and chatAuthor == "Wing Commander Vipore") then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\AllianceAirLaunching.wav");
		return;
	end]]--
	
	-- Launching Ulimate Unit
	if (string.find(chatMsg,BGS_S_IVUSATTACK) ~= nil and chatAuthor == BGS_S_IVUS) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\AllianceLaunchingUltimateUnit.wav");
		return;
	end

	if (string.find(chatMsg,BGS_S_PRIMALISTTHURLOGAATTACK) ~= nil and chatAuthor == BGS_S_PRIMALISTTHURLOGA) then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\HordeLaunchingUltimateUnit.wav");
		return;
	end
	end
	
	-- Win message
	if (string.find(chatMsg,BGS_S_WINS) ~= nil and chatAuthor == BGS_S_HERALD) then
		BGSoundAlerts_ClearSoundQueue();
		BGSoundAlerts_EndGameSound(chatMsg);
		return;
	end
end
	
function BGSounds_ScoreSound()

	local _,AllianceScore = GetWorldStateUIInfo(1);
	local _,HordeScore = GetWorldStateUIInfo(2);
	
	if (AllianceScore == "0/3" and HordeScore == "0/3") then
		-- Do not play a sound as this is the start of the game
		return;
	end
	
	if (AllianceScore == "0/3" and HordeScore == "1/3") then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\Alliance0Horde1.wav");
		return;
	end
	
	if (AllianceScore == "0/3" and HordeScore == "2/3") then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\Alliance0Horde2.wav");
		return;
	end
	
	if (AllianceScore == "1/3" and HordeScore == "0/3") then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\Alliance1Horde0.wav");
		return;
	end
	
	if (AllianceScore == "1/3" and HordeScore == "1/3") then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\Alliance1Horde1.wav");
		return;
	end

	if (AllianceScore == "1/3" and HordeScore == "2/3") then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\Alliance1Horde2.wav");
		return;
	end
	
	if (AllianceScore == "2/3" and HordeScore == "0/3") then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\Alliance2Horde0.wav");
		return;
	end
	
	if (AllianceScore == "2/3" and HordeScore == "1/3") then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\Alliance2Horde1.wav");
		return;
	end
	
	if (AllianceScore == "2/3" and HordeScore == "2/3") then
		BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\Alliance2Horde2.wav");
		return;
	end
	
end

function BGSoundAlerts_ShowHelpTooltip(helpstring)
	
	if (helpstring) then
		GameTooltip:ClearLines();
		GameTooltip:SetOwner(this,"ANCHOR_RIGHT");
		GameTooltip:AddLine(helpstring);		
		GameTooltip:Show();
	end
	
end

function BGSoundAlerts_HideHelpTooltip()
	GameTooltip:Hide();
end

-- This function will check the end game winner
function BGSoundAlerts_PlayerWon(msg)
	local PlayerRace = UnitFactionGroup("player");
	
	-- DEFAULT_CHAT_FRAME:AddMessage("PlayerWon?");
		
	if (string.find(msg,"Horde") and PlayerRace == "Horde") then
	--	DEFAULT_CHAT_FRAME:AddMessage("WIN")
		return 1;
	end
		
	if (string.find(msg,"Alliance") and PlayerRace == "Alliance") then
		return 1;
	end
		
	return nil;
	
 end
  
 -- This function will  return the intensity of a win or loss
 function BGSoundAlerts_EndGameIntensity()
	
	-- DEFAULT_CHAT_FRAME:AddMessage("EndGameIntensity");
	
	local _,AllianceScore = GetWorldStateUIInfo(1);
	local _,HordeScore = GetWorldStateUIInfo(2);
	
	-- Warsong Gulch
	if (GetRealZoneText() == "Warsong Gulch") then
		-- 1 intensity
		if ((AllianceScore == "3/3" and HordeScore == "0/3") or 
			(AllianceScore == "0/3" and HordeScore == "3/3")) then
		--		DEFAULT_CHAT_FRAME:AddMessage("Intensity 1");
				return "1";
		end
	end	
	
	-- Bases: 0  Resources: 1000/2000
	if (GetRealZoneText() == "Arathi Basin") then
		-- Check the scores
		AllianceScore = tonumber(string.sub(AllianceScore,21,string.find(AllianceScore,"/") - 1));
		HordeScore = tonumber(string.sub(HordeScore,21,string.find(HordeScore,"/") - 1));
		
		-- 1 intensity
		if ((AllianceScore >= 1000 and HordeScore < 1000) or
		    (AllianceScore < 1000 and HordeScore >= 1000)) then
				return "1";
		end
	end
	
	-- 3 intensity	
	return "3";
	
end

-- This function will play an end game sound
function BGSoundAlerts_EndGameSound(msg)
	if (VictoryDefeatSounds == 1) then
		local SoundFile = WOW_DEF_DIR .. SoundsPack;
		
		if not (GetBattlefieldWinner()) then
			-- No one still won
			return;
		end
		
		if not (msg) then
			if (GetBattlefieldWinner() == 0) then
				msg = "Horde";
			else
				msg = "Alliance";
			end
		end
		
		if (BGSoundAlerts_PlayerWon(msg)) then
			-- Set Victory Sound
			SoundFile = SoundFile .. "\\Victory";
			-- Set Intensity
			SoundFile = SoundFile .. BGSoundAlerts_EndGameIntensity() .. ".wav";
		else
			-- Set Defeat Sound
			SoundFile = SoundFile .. "\\Defeat";
			-- Set Intensity
			SoundFile = SoundFile .. BGSoundAlerts_EndGameIntensity() .. ".wav";
		end
		
		BGSoundAlerts_AddToQueue(SoundFile);
		-- DEFAULT_CHAT_FRAME:AddMessage("Playing Sound");
	end
end

function BGSoundAlerts_IncomingSound(incmsg)
	
	if (IncomingSounds == 0 or not (SoundsPack == "DefaultPack")) then
		-- Incoming Sounds not enabled or SoundsPack not DefaultPack (this feature requires sound queues
		return;
	end
	
	-- We will be building up a string to a sound dir according to the received message	
	local IncomingFile = WOW_DEF_DIR .. SoundsPack .. "\\";				-- The string to the sound dir
	
	-- Capitalize msg for easier parsing
	local msg = string.upper(incmsg);
	local begindigit, enddigit;
	
	if ((GetRealZoneText() == "Alterac Valley") and (string.find(msg,"DREK") or string.find(msg,"VANNDAR")) and (not string.find(msg,"INC"))) then
		-- We've received a Drek'Thar/Vanndar Health Report
		if ((string.find(msg,"|37") or string.find(msg,"AT")) and string.find(msg,"(%d+)")) then
			local begindigit, enddigit = string.find(msg,"(%d+)");
			local digit = string.sub(msg,begindigit,enddigit);
			local i, x;
			-- The following piece of code isn't simplified!!
			if (string.find(msg,"DREK")) then
				-- Say that Drek'Thar is at a certain health level
				BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\DrekThar.wav");
				BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\IsAt.wav");
				if ((tonumber(digit) > 10) and (tonumber(digit) < 20)) then
					BGSoundAlerts_AddToQueue("WOW_DEF_DIR" .. SoundsPack .. "\\" .. digit);
				else
					digit = tostring(digit);
					for i = 1, string.len(digit) do
						local file = WOW_DEF_DIR .. SoundsPack .. "\\" .. string.sub(digit,i,i);
						for x = string.len(digit) - 1, i, -1 do
							file = file .. "0";
						end
						file = file .. ".wav";
						BGSoundAlerts_AddToQueue(file);
					end
				end
				BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\PerCent.wav");
			elseif (string.find(msg,"VANNDAR")) then
				-- Say that Vanndar is at a certain health level
				BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\Vanndar.wav");
				BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\IsAt.wav");
				if ((tonumber(digit) > 10) and (tonumber(digit) < 20)) then
					BGSoundAlerts_AddToQueue("WOW_DEF_DIR" .. SoundsPack .. "\\" .. digit);
				else
					digit = tostring(digit);
					for i = 1, string.len(digit) do
						local file = WOW_DEF_DIR .. SoundsPack .. "\\" .. string.sub(digit,i,i);
						for x = string.len(digit) - 1, i, -1 do
							file = file .. "0";
						end
						file = file .. ".wav";
						BGSoundAlerts_AddToQueue(file);
					end
				end
				BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\PerCent.wav");
			end
		elseif (string.find(msg,"DEAD") or string.find(msg,"DIEING") or string.find(msg,"TO(%s+)DIE") or string.find(msg,"DYING")) then
			if (string.find(msg,"DREK")) then
				BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\DrekThar.wav");
			elseif (string.find(msg,"VANNDAR")) then
				BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\Vanndar.wav");
			end
			BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\IsCriticallyInjured.wav");
		elseif ((string.find(msg,"OK")) or (string.find(msg,"FINE")) or (string.find(msg,"OKAY")) or (string.find(msg,"ALL(%s+)RIGHT")) or string.find(msg,"AL(%s+)RIGHT") or (string.find(msg,"GOOD")) or (string.find(msg,"SAFE")) or (string.find(msg,"CALM"))) then
			if (string.find(msg,"DREK")) then
				BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\DrekThar.wav");
			elseif (string.find(msg,"VANNDAR")) then
				BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\Vanndar.wav");
			end
			BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\IsSafe.wav");
		end
	elseif (GetRealZoneText() == "Warsong Gulch" or GetRealZoneText() == "Arathi Basin" 
		or GetRealZoneText() == "Alterac Valley") then
		-- Are we in a battleground	
			-- Check for 'Inc'
			if (string.find(msg,"INC")) then
				IncomingFile = IncomingFile .. "Incoming";
				-- If Inc is found check for more detail
				-- Check for numbers
				begindigit, enddigit = string.find(msg,"(%d+)");
				-- Check for these if in Arathi Basin
				if (GetRealZoneText() == "Arathi Basin") then
					if (string.find(msg,"FARM")) then
						-- Inc Farm
						IncomingFile = IncomingFile .. "Farm";
					elseif (string.find(msg,"STABLES") or string.find(msg,"STAB")) then
						-- Inc Stables
						IncomingFile = IncomingFile .. "Stables";
					elseif (string.find(msg,"LM") or string.find(msg,"MILL") or string.find(msg,"LUMBER")) then
						-- Inc Lumbermill
						IncomingFile = IncomingFile .. "Lumbermill";
					elseif (string.find(msg,"GM") or string.find(msg,"MINE") or string.find(msg,"GOLD")) then
						-- Inc Gold Mine
						IncomingFile = IncomingFile .. "GoldMine";
					elseif (string.find(msg,"BS") or string.find(msg,"SMITH") or string.find(msg,"BLACK")) then
						-- Inc Blacksmith
						IncomingFile = IncomingFile .. "Blacksmith";
					elseif (string.find(msg,"BIG") or string.find(msg,"A(%s+)LOT") or string.find(msg,"MANY") or string.find(msg,"HEAVY")) then
						-- Incoming Big
						IncomingFile = IncomingFile .. "Big";
					elseif (begindigit) then
						local number = tonumber(string.sub(msg,begindigit,enddigit));
						if (number <= 10 and number > 0) then
							-- Incoming Number
							IncomingFile = IncomingFile .. number;
						else
							-- Incoming Big
							IncomingFile = IncomingFile .. "Big";
						end
					end
				-- Check for these if in Warsong Gulch
				elseif (GetRealZoneText() == "Warsong Gulch") then
					if (string.find(msg,"BASE")) then
						-- Incoming Base
						IncomingFile = IncomingFile .. "Base";
					elseif (string.find(msg,"BALC")) then
						-- Incoming Balcony
						IncomingFile = IncomingFile .. "Balcony";
					elseif (string.find(msg,"TUN")) then
						-- Incoming Tunnel
						IncomingFile = IncomingFile .. "Tunnel";
					elseif (string.find(msg,"BIG") or string.find(msg,"A(%s+)LOT") or string.find(msg,"MANY") or string.find(msg,"HEAVY")) then
						-- Incoming Big
						IncomingFile = IncomingFile .. "Big";
					elseif (begindigit) then
						local number = tonumber(string.sub(msg,begindigit,enddigit));
						if (number <= 10 and number > 0) then
							-- Incoming Number
							IncomingFile = IncomingFile .. number;
						else
							-- Incoming Big
							IncomingFile = IncomingFile .. "Big";
						end
					end
				-- Check for these if in Alterac Valley
				elseif (GetRealZoneText() == "Alterac Valley") then
					if (string.find(msg,"SF") or string.find(msg,"SNOW") or string.find(msg,"FALL")) then
						-- Incoming Snowfall Graveyard
						IncomingFile = IncomingFile .. "SnowfallGraveyard";
					elseif ((string.find(msg,"IB") or string.find(msg,"ICE(%s+)BLOOD")) and (string.find(msg,"GY") or string.find(msg,"GRAVE(%s+)YARD"))) then
						-- Incoming Iceblood Graveyard
						IncomingFile = IncomingFile .. "IcebloodGraveyard";
					elseif (string.find(msg,"IB") or string.find(msg,"ICE(%s+)BLOOD")) then
						-- Incoming Iceblood Tower
						IncomingFile = IncomingFile .. "IcebloodTower";
					elseif ((string.find(msg,"SH") or string.find(msg,"STONE(%s+)HEARTH")) and (string.find(msg,"BUNKER"))) then
						-- Incoming Stonehearth Bunker
						IncomingFile = IncomingFile .. "StonehearthBunker";
					elseif (string.find(msg,"SH") or string.find(msg,"STONE(%s+)HEARTH")) then
						-- Incoming Stonehearth Graveyard
						IncomingFile = IncomingFile .. "StonehearthGraveyard";
					elseif (((string.find(msg,"FW") or string.find(msg,"FROST(%s+)WOLF")) and (string.find(msg,"RELIEF(%s+)HUT") or string.find(msg,"RH")))
							or (string.find(msg,"RELIEF(%s+)HUT")) or (string.find(msg,"BASE(%s+)GY") and UnitFactionGroup("player") == "Horde")) then
						-- Incoming Frostwolf Relief Hut
						IncomingFile = IncomingFile .. "FrostwolfReliefHut";
					elseif (string.find(msg,"FW") or string.find(msg,"FROST(%s+)WOLF")) then
						-- Incoming Frostwolf Graveyard
						IncomingFile = IncomingFile .. "FrostwolfGraveyard";
					elseif (((string.find(msg,"SP") or string.find(msg,"STORM(%s+)PIKE")) and (string.find(msg,"AID(%s+)STATION") or string.find(msg,"AS")))
							or (string.find(msg,"AID(%s+)STATION")) or (string.find(msg,"BASE(%s+)GY") and UnitFactionGroup("player") == "Alliance")) then
						-- Incoming Stormpike Aid Station
						IncomingFile = IncomingFile .. "StormpikeAidStation";
					elseif (string.find(msg,"SP") or string.find(msg,"STORM(%s+)PIKE")) then
						-- Incoming Stormpike Graveyard
						IncomingFile = IncomingFile .. "StormpikeGraveyard";
					elseif (string.find(msg,"EAST") and string.find(msg,"TOWER")) then
						-- Incoming East Frostwolf Tower
						IncomingFile = IncomingFile .. "EastFrostwolfTower";
					elseif (string.find(msg,"WEST") and string.find(msg,"TOWER")) then
						-- Incoming West Frostwolf Tower
						IncomingFile = IncomingFile .. "WestFrostwolfTower";
					elseif (string.find(msg,"NORTH") and string.find(msg,"BUNKER")) then
						-- Incoming Dun Baldar North Bunker
						IncomingFile = IncomingFile .. "DunBaldarNorthBunker";
					elseif (string.find(msg,"SOUTH") and string.find(msg,"BUNKER")) then
						-- Incoming Dun Baldar South Bunker
						IncomingFile = IncomingFile .. "DunBaldarSouthBunker";
					elseif (string.find(msg,"BOSS") and UnitFactionGroup("player") == "Horde") then
						-- Incoming Drek'Thar
						IncomingFile = IncomingFile .. "DrekThar";
					elseif (string.find(msg,"BOSS") and UnitFactionGroup("player") == "Alliance") then
						-- Incoming Vanndar Stormpike
						IncomingFile = IncomingFile .. "VanndarStormpike";
					elseif (string.find(msg,"BIG") or string.find(msg,"A(%s+)LOT") or string.find(msg,"MANY") or string.find(msg,"HEAVY")) then
						-- Incoming Big
						IncomingFile = IncomingFile .. "Big";
					elseif (begindigit) then
						local number = tonumber(string.sub(msg,begindigit,enddigit));
						if (number <= 10 and number > 0) then
							-- Incoming Number
							IncomingFile = IncomingFile .. number;
						else
							-- Incoming Big
							IncomingFile = IncomingFile .. "Big";
						end
					end
				end
			IncomingFile = IncomingFile .. ".wav";
			BGSoundAlerts_AddToQueue(IncomingFile);
		end
	end
end

function BGSoundAlerts_CheckForBuffs()

	if (not BuffSounds) then
		return;
	end

	if  not ((GetRealZoneText() == "Alterac Valley") or (GetRealZoneText() == "Warsong Gulch") or (GetRealZoneText() == "Arathi Basin")) then
		BGSoundAlerts_HasBerserking = false;
		BGSoundAlerts_HasSpeed = false;
		BGSoundAlerts_HasRestoration = false;
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
				if (not BGSoundAlerts_HasSpeed) then
					-- Gained speed
					BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\Speed.wav");
				end
				hasSpeed = true;
			elseif (name == "Interface\\Icons\\INV_Misc_Fork&Knife") then
				-- Found restoration
				if (not BGSoundAlerts_HasRestoration) then
					-- Gained restoration
					BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\Restoration.wav");
				end
				hasRestoration = true;
			elseif (name == "Interface\\Icons\\Spell_Nature_BloodLust") then
				-- Found berserking
				if (not BGSoundAlerts_HasBerserking) then
					-- Gained berserking
					BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\Berserking.wav");
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
				if (not BGSoundAlerts_HasSpeed) then
					-- Gained speed
					BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\Speed.wav");
				end
				hasSpeed = true;
			elseif (name == "Restoration") then
				-- Found restoration
				if (not BGSoundAlerts_HasRestoration) then
					-- Gained restoration
					BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\Restoration.wav");
				end
				hasRestoration = true;
			elseif (name == "Berserking") then
				-- Found berserking
				if (not BGSoundAlerts_HasBerserking) then
					-- Gained berserking
					BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\Berserking.wav");
				end
				hasBerserking = true;
			end
		end
	end
	
	BGSoundAlerts_HasBerserking = hasBerserking;
	BGSoundAlerts_HasSpeed = hasSpeed;
	BGSoundAlerts_HasRestoration = hasRestoration;

end	

function BGSoundAlerts_CheckFlagHealth(unit)

	if (UnitName(unit) ~= BGSoundAlerts_FlagCarrierName) then
		return;			-- Not flag carrier
	end
	
	if (UnitHealth(unit) / UnitHealthMax(unit) * 100) <= 45 then
		-- Critically injured
		if (not BGSoundAlerts_FlagHealthAnnounced) then
			BGSoundAlerts_FlagHealthAnnounced = true;
			BGSoundAlerts_AddToQueue(WOW_DEF_DIR .. SoundsPack .. "\\FlagCriticallyInjured.wav");
		end
	else
		BGTextAlerts_FlagHealthAnnounced = false;
	end
	
end

function BGSoundAlerts_ShowPatchNotes()
	
	ShowUIPanel(BGSoundAlertsPatchNotes);
	
end
--[[
	ImmersionRP Alpha 4 main script file.
	Author: Seagale.
	Last update: March 10th, 2007.
]]

IRP_VERSION = "Alpha 4";
BINDING_HEADER_IRP_TOGGLE = "ImmersionRP";
ImmersionRP = {
	Active = 1,
	PlayerName = UnitName("player"),
	RealmName = GetRealmName(),
	RPMode = 0,
	PlayerAFK = 0
};
ImmersionRPSettings = {};
ImmersionRPCharacterInfo = {};
ImmersionRPInfoboxBlocks = {};

function ImmersionRP.OnLoad()
	ImmersionRPMainFrame:RegisterEvent("VARIABLES_LOADED");
	
	ImmersionRPMainFrame:RegisterEvent("CHAT_MSG_SYSTEM");
	ImmersionRPMainFrame:RegisterEvent("CHAT_MSG_CHANNEL");
	
	ImmersionRPMainFrame:RegisterEvent("UPDATE_MOUSEOVER_UNIT");
	ImmersionRPMainFrame:RegisterEvent("PLAYER_TARGET_CHANGED");
	
	ImmersionRPMainFrame:RegisterEvent("PLAYER_LOGOUT");
	
	ImmersionRPflagRSPHandler.LastPostLow = GetTime();
	ImmersionRPflagRSPHandler.LastPostHigh = GetTime();
end

function ImmersionRP.PrintMessage(message)
	PREFIX = "|c002BAB31ImmersionRP:|r ";
	DEFAULT_CHAT_FRAME:AddMessage(PREFIX .. message);
end

function ImmersionRP.ToggleAddonActivity()
	if (ImmersionRP.Active == 1) then
		ImmersionRP.Active = 0;
		ImmersionRPMainFrame:UnregisterEvent("CHAT_MSG_CHANNEL");
		ImmersionRPMainFrame:UnregisterEvent("UPDATE_MOUSEOVER_UNIT");
		ImmersionRPMainFrame:UnregisterEvent("PLAYER_TARGET_CHANGED");
		UnitPopupButtons["IRP_DISABLE"].text = IRP_STRING_MENU_ENABLE;
	else
		ImmersionRP.Active = 1;
		ImmersionRPMainFrame:RegisterEvent("CHAT_MSG_CHANNEL");
		ImmersionRPMainFrame:RegisterEvent("UPDATE_MOUSEOVER_UNIT");
		ImmersionRPMainFrame:RegisterEvent("PLAYER_TARGET_CHANGED");
		UnitPopupButtons["IRP_DISABLE"].text = IRP_STRING_MENU_DISABLE;
	end
end

function ImmersionRP.OnEvent(event)
	if (event == "VARIABLES_LOADED") then
		--ImmersionRP.PrintMessage(IRP_STRING_LOADED);
		ImmersionRP.PrintMessage("\"I can't bring this ship into Tortuga all by me onesies, savvy?\"");
		ImmersionRP.InitialiseDefaultSettings();
		ImmersionRP.InitialiseSlashCommands();
		ImmersionRP.InitialiseUnitPopupMenus();
		ImmersionRP.InitialiseStaticPopups();
		ImmersionRP.InitialiseDefaultCharacterInfo();
		ImmersionRPDatabaseHandler.InitialiseDatabase();
		ImmersionRPDatabaseHandler.PurgePlayers();
	elseif (event == "CHAT_MSG_SYSTEM") then
		if (arg1 == string.format(MARKED_AFK_MESSAGE, DEFAULT_AFK_MESSAGE) or arg1 == MARKED_AFK) then
			ImmersionRP.PlayerAFK = 1;
		elseif (arg1 == CLEARED_AFK) then
			ImmersionRP.PlayerAFK = 0;
		end
	elseif (event == "CHAT_MSG_CHANNEL") then
		if (string.lower(arg9) == string.lower(ImmersionRPSettings["COMM_CHANNEL"])) then
			arg1 = string.gsub(arg1, string.format(SLURRED_SPEECH, ""), "");
			--if (ImmersionRPSettings["COMM_PROTOCOL"] == 2) then -- flagRSP protocol
			ImmersionRPflagRSPHandler.ParseChatMessage(arg1,arg2);
			--elseif (ImmersionRPSettings["COMM_PROTOCOL"] == 1) then -- ImmersionRP protocol
				--TODO: Route messages to ImmersionRP protocol handler.
			--end
		end
	elseif (event == "UPDATE_MOUSEOVER_UNIT") then
		if (ImmersionRPSettings["MODIFY_TOOLTIP"] == 1 and UnitIsPlayer("mouseover")) then
			ImmersionRPTooltipHandler.ProcessTooltip();
			ImmersionRPTooltipHandler.DestroyTooltip();
			ImmersionRPTooltipHandler.ConstructTooltip();
		end
	elseif (event == "PLAYER_TARGET_CHANGED") then
		if (UnitName("target") ~= nil and UnitIsPlayer("target") and ImmersionRPInfoboxHandler.InfoboxChange and not UnitAffectingCombat("player") and ImmersionRPInfoboxBlocks[UnitName("target")] == nil) then
			ImmersionRPInfoboxHandler.SetPlayer(UnitName("target"));
		elseif (ImmersionRPInfoboxHandler.InfoboxChange) then
			ImmersionRPInfobox:Hide();
		end
	elseif (event == "PLAYER_LOGOUT") then
		ImmersionRPInfoboxHandler.SaveNotes();
		ImmersionRPInfoboxHandler.InfoboxMode = 1;
		ImmersionRPInfoboxHandler.ModeUpdate();
		ImmersionRPInfoboxHandler.Reanchor();
	end
end

function ImmersionRP.UnitPopupHook()
	local button = this.value;
	if (button == "IRP_TOGGLE") then
		ImmersionRP.ToggleMainFrame();
	elseif (button == "IRP_FLAGRSP_NORPSTATUS") then
		ImmersionRP.ChangeRPStatus(0);
	elseif (button == "IRP_FLAGRSP_OOC") then
		ImmersionRP.ChangeRPStatus(1);
	elseif (button == "IRP_FLAGRSP_IC") then
		ImmersionRP.ChangeRPStatus(2);
	elseif (button == "IRP_FLAGRSP_ICFFA") then
		ImmersionRP.ChangeRPStatus(3);
	elseif (button == "IRP_FLAGRSP_STORYTELLER") then
		ImmersionRP.ChangeRPStatus(4);
	elseif (button == "IRP_FIND") then
		StaticPopup_Show("IRP_CHARACTERLOOKUP");
	elseif (button == "IRP_TOGGLEHELM") then
		ImmersionRP.ToggleHelm();
	elseif (button == "IRP_TOGGLECLOAK") then
		ImmersionRP.ToggleCloak();
	elseif (button == "IRP_TOGGLEINFOBOX") then
		if (ImmersionRPInfoboxBlocks[UnitName("target")] ~= nil) then -- blocked
			ImmersionRPInfoboxBlocks[UnitName("target")] = nil;
			if (not ImmersionRPInfobox:IsVisible()) then ImmersionRPInfoboxHandler.SetPlayer(UnitName("target")); end
		else -- not blocked
			ImmersionRPInfoboxBlocks[UnitName("target")] = true;
			if (ImmersionRPInfoboxHandler.InfoboxPlayer == UnitName("target")) then ImmersionRPInfobox:Hide(); ImmersionRPInfoboxHandler.Clear(); end
		end
	elseif (button == "IRP_DISABLE") then
		ImmersionRP.ToggleAddonActivity();
	end
end

function ImmersionRP.ToggleHelm()
	ShowHelm(not ShowingHelm());
end

function ImmersionRP.ToggleCloak()
	ShowCloak(not ShowingCloak());
end

function ImmersionRP.ChangeRPStatus(newstatus)
	ImmersionRPCharacterInfo["RPSTATUS"] = newstatus;
	if (newstatus == 0) then
		ImmersionRP.PrintMessage(string.format(IRP_STRING_STATUSCHANGED, IRP_STRING_MENU_NORPSTATUS));
	elseif (newstatus == 1) then
		ImmersionRP.PrintMessage(string.format(IRP_STRING_STATUSCHANGED, IRP_STRING_RSP_OOC_TOOLTIP));
	elseif (newstatus == 2) then
		ImmersionRP.PrintMessage(string.format(IRP_STRING_STATUSCHANGED, IRP_STRING_RSP_IC_TOOLTIP));
	elseif (newstatus == 3) then
		ImmersionRP.PrintMessage(string.format(IRP_STRING_STATUSCHANGED, IRP_STRING_RSP_ICFFA_TOOLTIP));
	elseif (newstatus == 4) then
		ImmersionRP.PrintMessage(string.format(IRP_STRING_STATUSCHANGED, IRP_STRING_RSP_STORYTELLER_TOOLTIP));
	end
	ImmersionRPflagRSPHandler.PostHigh();
end

function ImmersionRP.OnUpdate(elapsed)
	
	if (ImmersionRP.OwnTooltip == 1) then
		ImmersionRPTooltipHandler.ShowOwnTooltip();
	end
	
	if (ImmersionRPSettings["COMM_PROTOCOL"] == 2) then
	
		if (GetTime() > ImmersionRPflagRSPHandler.LastPostLow + ImmersionRPflagRSPHandler.PostInterval) then
			ImmersionRPflagRSPHandler.PostLow();
			ImmersionRPflagRSPHandler.LastPostLow = GetTime();
		end
		
		if (GetTime() > ImmersionRPflagRSPHandler.LastPostHigh + ImmersionRPflagRSPHandler.PostIntervalHigh) then
			ImmersionRPflagRSPHandler.PostHigh();
			ImmersionRPflagRSPHandler.LastPostHigh = GetTime();
		end
		
		if (GetTime() > ImmersionRPInfoboxHandler.LastUpdate + ImmersionRPInfoboxHandler.UpdateInterval) then
			ImmersionRPInfoboxHandler.Update();
			ImmersionRPInfoboxHandler.LastUpdate = GetTime();
		end
		
		ImmersionRPChatHandler.ExecuteQueue();
	end
end

function ImmersionRP.HandleMinimapDropdown()
	local id = this:GetID();
	if (id == 2) then
		ImmersionRP.ToggleMainFrame();
	elseif (id == 3) then
		ImmersionRP.ChangeRPStatus(1)
	elseif (id == 4) then
		ImmersionRP.ChangeRPStatus(2)
	elseif (id == 5) then
		ImmersionRP.ChangeRPStatus(3)
	elseif (id == 6) then
		ImmersionRP.ChangeRPStatus(4)
	elseif (id == 7) then
		ImmersionRP.ChangeRPStatus(0)
	elseif (id == 8) then
		StaticPopup_Show("IRP_CHARACTERLOOKUP");
	elseif (id == 9) then
		ImmersionRP.ToggleHelm();
	elseif (id == 10) then
		ImmersionRP.ToggleCloak();
	elseif (id == 11) then
		ImmersionRP.ToggleAddonActivity();
	end
end

function ImmersionRP.InitialiseMinimapDropdown()
	local info = {};
	info.func = ImmersionRP.HandleMinimapDropdown;
	
	info.isTitle = 1;
	info.text = "ImmersionRP";
	UIDropDownMenu_AddButton(info);
	
	info.isTitle = nil;
	info.disabled = nil;
	info.text = IRP_STRING_MENU_TOGGLE;
	UIDropDownMenu_AddButton(info);
	
	if (ImmersionRPSettings["COMM_PROTOCOL"] == 2) then --flagRSP protocol
		info.text = IRP_STRING_RSP_OOC_TOOLTIP;
		info.checked = ImmersionRPCharacterInfo["RPSTATUS"] == 1;
		UIDropDownMenu_AddButton(info);
		
		info.text = IRP_STRING_RSP_IC_TOOLTIP;
		info.checked = ImmersionRPCharacterInfo["RPSTATUS"] == 2;
		UIDropDownMenu_AddButton(info);
		
		info.text = IRP_STRING_RSP_ICFFA_TOOLTIP;
		info.checked = ImmersionRPCharacterInfo["RPSTATUS"] == 3;
		UIDropDownMenu_AddButton(info);
		
		info.text = IRP_STRING_RSP_STORYTELLER_TOOLTIP;
		info.checked = ImmersionRPCharacterInfo["RPSTATUS"] == 4;
		UIDropDownMenu_AddButton(info);
		
		info.text = IRP_STRING_MENU_NORPSTATUS;
		info.checked = ImmersionRPCharacterInfo["RPSTATUS"] == 0;
		UIDropDownMenu_AddButton(info);
	end
	
	info.text = IRP_STRING_MENU_FIND;
	info.checked = nil;
	UIDropDownMenu_AddButton(info);
	
	info.text = IRP_STRING_MENU_TOGGLEHELM;
	UIDropDownMenu_AddButton(info);
	
	info.text = IRP_STRING_MENU_TOGGLECLOAK;
	UIDropDownMenu_AddButton(info);
	
	if (ImmersionRP.Active == 1) then
		info.text = IRP_STRING_MENU_DISABLE;
	else
		info.text = IRP_STRING_MENU_ENABLE;
	end
	UIDropDownMenu_AddButton(info);
end
function ImmersionRP.HandleCheckbox()
	if (this:GetName() == "ImmersionRPSettingsModifyTooltip") then
		if (this:GetChecked() == nil) then
			ImmersionRPSettings["MODIFY_TOOLTIP"] = 0;
		else
			ImmersionRPSettings["MODIFY_TOOLTIP"] = 1;
		end
	elseif (this:GetName() == "ImmersionRPSettingsHideUnknown") then
		if (this:GetChecked() == nil) then
			ImmersionRPSettings["HIDE_UNKNOWN_PLAYERS"] = 0;
		else
			ImmersionRPSettings["HIDE_UNKNOWN_PLAYERS"] = 1;
		end
	elseif (this:GetName() == "ImmersionRPSettingsRelativeLevels") then
		if (this:GetChecked() == nil) then
			ImmersionRPSettings["SHOW_RELATIVE_LEVELS"] = 0;
		else
			ImmersionRPSettings["SHOW_RELATIVE_LEVELS"] = 1;
		end
	end
end

function ImmersionRP.HandleGuildDropdown()
	UIDropDownMenu_SetSelectedID(ImmersionRPSettingsGuildNames, this:GetID());
	ImmersionRPSettings["SHOW_GUILDS"] = UIDropDownMenu_GetSelectedID(ImmersionRPSettingsGuildNames);
end


function ImmersionRP.InitialiseGuildDropdown()
	local info = {};
	info.func = ImmersionRP.HandleGuildDropdown;
	
	info.text = IRP_STRING_ALWAYS_SHOW_GUILDS;
	info.checked = ImmersionRPSettings["SHOW_GUILDS"] == 1;
	UIDropDownMenu_AddButton(info);

	info.text = IRP_STRING_NEVER_SHOW_GUILDS;
	info.checked = ImmersionRPSettings["SHOW_GUILDS"] == 2;
	UIDropDownMenu_AddButton(info);

	info.text = IRP_STRING_KNOWN_SHOW_GUILDS;
	info.checked = ImmersionRPSettings["SHOW_GUILDS"] == 3;
	UIDropDownMenu_AddButton(info);
end

function ImmersionRP.HandlePvPDropdown()
	UIDropDownMenu_SetSelectedID(ImmersionRPSettingsPvPRanks, this:GetID());
	ImmersionRPSettings["SHOW_RANKS"] = UIDropDownMenu_GetSelectedID(ImmersionRPSettingsPvPRanks);
end


function ImmersionRP.InitialisePvPDropdown()
	local info = {};
	info.func = ImmersionRP.HandlePvPDropdown;
	
	info.text = IRP_STRING_ALWAYS_SHOW_PVP;
	info.checked = ImmersionRPSettings["SHOW_RANKS"] == 1;
	UIDropDownMenu_AddButton(info);

	info.text = IRP_STRING_NEVER_SHOW_PVP;
	info.checked = ImmersionRPSettings["SHOW_RANKS"] == 2;
	UIDropDownMenu_AddButton(info);

	info.text = IRP_STRING_KNOWN_SHOW_PVP;
	info.checked = ImmersionRPSettings["SHOW_RANKS"] == 3;
	UIDropDownMenu_AddButton(info);
end

function ImmersionRP.ImmersionRPSettingsChangeChannel_OnClick()
	--ImmersionRPSettings["COMM_PROTOCOL"] = UIDropDownMenu_GetSelectedID(ImmersionRPSettingsCommProtocol);
	if (ImmersionRPSettings["COMM_CHANNEL"] ~= ImmersionRPSettingsCommChannel:GetText()) then LeaveChannelByName(ImmersionRPSettings["COMM_CHANNEL"]); end
	ImmersionRPSettings["COMM_CHANNEL"] = ImmersionRPSettingsCommChannel:GetText();
	JoinChannelByName(ImmersionRPSettings["COMM_CHANNEL"]);
	ChatFrame_RemoveChannel(ChatFrame1, ImmersionRPSettings["COMM_CHANNEL"]);
end

function ImmersionRP.ImmersionRPSettingsJoinChannel_OnClick()
	JoinChannelByName(ImmersionRPSettings["COMM_CHANNEL"]);
	ChatFrame_RemoveChannel(ChatFrame1, ImmersionRPSettings["COMM_CHANNEL"]);
end

--[[function ImmersionRP.HandleProtocolDropdown()
	UIDropDownMenu_SetSelectedID(ImmersionRPSettingsCommProtocol, this:GetID());
	if (this:GetID() == 1) then
		ImmersionRPSettingsCommChannel:SetText("immersioncomm");
	elseif (this:GetID() == 2) then
		ImmersionRPSettingsCommChannel:SetText("xtensionxtooltip2");
	end
end]]


--[[function ImmersionRP.InitialiseProtocolDropdown()
	local info = {};
	info.func = ImmersionRP.HandleProtocolDropdown;
	
	info.text = "ImmersionRP";
	info.checked = ImmersionRPSettings["COMM_PROTOCOL"] == 1;
	UIDropDownMenu_AddButton(info);

	info.text = "flagRSP";
	info.checked = ImmersionRPSettings["COMM_PROTOCOL"] == 2;
	UIDropDownMenu_AddButton(info);
end]]

function ImmersionRP.ImmersionRPCharacterRevert_OnClick()
	ImmersionRP.RefreshCharacterInfoTab();
end

function ImmersionRP.EncodeDescription(desc)
	return string.gsub(string.gsub(string.gsub(desc, "<", "\\%("), ">", "\\%)"), "\n", "\\l");
end

function ImmersionRP.DecodeDescription(desc)
	return string.gsub(string.gsub(string.gsub(desc, "\\%(", "<"), "\\%)", ">"), "\\l", "\n");
end

function ImmersionRP.SaveCharacterInfo()
	
	if (ImmersionRPCharacterInfo["FIRSTNAME"] ~= ImmersionRPCharacterFirstName:GetText()) then
		if (ImmersionRPCharacterFirstName:GetText() == "") then
			ImmersionRP.PrintMessage(IRP_STRING_FIRSTNAMECLEARED);
		else
			ImmersionRP.PrintMessage(string.format(IRP_STRING_FIRSTNAMECHANGED, ImmersionRPCharacterFirstName:GetText()));
		end
		ImmersionRPCharacterInfo["FIRSTNAME"] = ImmersionRPCharacterFirstName:GetText();
	end
	
	if (ImmersionRPCharacterInfo["LASTNAME"] ~= ImmersionRPCharacterLastName:GetText()) then
		if (ImmersionRPCharacterLastName:GetText() == "") then
			ImmersionRP.PrintMessage(IRP_STRING_LASTNAMECLEARED);
		else
			ImmersionRP.PrintMessage(string.format(IRP_STRING_LASTNAMECHANGED, ImmersionRPCharacterLastName:GetText()));
		end
		ImmersionRPCharacterInfo["LASTNAME"] = ImmersionRPCharacterLastName:GetText();
	end
	
	
	if (ImmersionRPCharacterInfo["TITLE"] ~= ImmersionRPCharacterTitle:GetText()) then
		if (ImmersionRPCharacterTitle:GetText() == "" or ImmersionRPCharacterTitle:GetText() == nil) then
			ImmersionRP.PrintMessage(IRP_STRING_TITLECLEARED);
		else
			ImmersionRP.PrintMessage(string.format(IRP_STRING_TITLECHANGED, ImmersionRPCharacterTitle:GetText()));
		end
		ImmersionRPCharacterInfo["TITLE"] = ImmersionRPCharacterTitle:GetText();
	end
	
	if (ImmersionRPSettings["COMM_PROTOCOL"] == 2) then 
		if (ImmersionRPCharacterInfo["DESCMETA"] == nil or ImmersionRPCharacterInfo["DESCMETA"] == "") then ImmersionRPCharacterInfo["DESCMETA"] = 0; end
		if (ImmersionRP.EncodeDescription(ImmersionRPCharacterDescription:GetText()) ~= ImmersionRPCharacterInfo["DESCRIPTION"]) then
			if (ImmersionRPCharacterDescription:GetText() == "" or ImmersionRPCharacterDescription:GetText() == nil) then
				ImmersionRPCharacterInfo["DESCMETA"] = 0;
				ImmersionRPCharacterInfo["DESCRIPTION"] = "";
				ImmersionRP.PrintMessage(IRP_STRING_DESCRIPTIONCLEARED);

			else
				ImmersionRPCharacterInfo["DESCMETA"] = ImmersionRPCharacterInfo["DESCMETA"] + 1;
				ImmersionRPCharacterInfo["DESCRIPTION"] = ImmersionRP.EncodeDescription(ImmersionRPCharacterDescription:GetText());
				ImmersionRP.PrintMessage(IRP_STRING_DESCRIPTIONCHANGED);
			end
			ImmersionRPflagRSPHandler.LastDescPost = 0;
		end
		if (ImmersionRPCharacterInfo["RPSTYLE"] ~= UIDropDownMenu_GetSelectedID(ImmersionRPCharacterRPStyle)-1) then
			ImmersionRPCharacterInfo["RPSTYLE"] = UIDropDownMenu_GetSelectedID(ImmersionRPCharacterRPStyle)-1;
			ImmersionRP.PrintMessage(string.format(IRP_STRING_STYLECHANGED, UIDropDownMenu_GetText(ImmersionRPCharacterRPStyle)));
		end
		ImmersionRPflagRSPHandler.PostLow(); 
		ImmersionRPflagRSPHandler.PostHigh(true);
	end
end

function ImmersionRP.HandleRPStyleDropdown()
	if (this:GetID() ~= UIDropDownMenu_GetSelectedID(ImmersionRPCharacterRPStyle)) then
		UIDropDownMenu_SetSelectedID(ImmersionRPCharacterRPStyle, this:GetID());
		ImmersionRPCharacterRevert:Enable();
	end
end


function ImmersionRP.InitialiseRPStyleDropdown()
	if (ImmersionRPSettings["COMM_PROTOCOL"] == 2) then
		local info = {};
		info.func = ImmersionRP.HandleRPStyleDropdown;
		
		info.text = IRP_STRING_RSP_NORP;
		info.value = 0;
		info.checked = ImmersionRPCharacterInfo["RPSTYLE"] == info.value;
		UIDropDownMenu_AddButton(info);
	
		info.text = IRP_STRING_RSP_RP;
		info.value = 1;
		info.checked = ImmersionRPCharacterInfo["RPSTYLE"] == info.value;
		UIDropDownMenu_AddButton(info);
		
		info.text = IRP_STRING_RSP_CASUALRP;
		info.value = 2;
		info.checked = ImmersionRPCharacterInfo["RPSTYLE"] == info.value;
		UIDropDownMenu_AddButton(info);
		
		info.text = IRP_STRING_RSP_FULLTIMERP;
		info.value = 3;
		info.checked = ImmersionRPCharacterInfo["RPSTYLE"] == info.value;
		UIDropDownMenu_AddButton(info);
		
		info.text = IRP_STRING_RSP_BEGINNERRP;
		info.value = 4;
		info.checked = ImmersionRPCharacterInfo["RPSTYLE"] == info.value;
		UIDropDownMenu_AddButton(info);
	end
end

function ImmersionRP.InitialiseDefaultSettings()
	if (ImmersionRPSettings["COMM_CHANNEL"] == nil) then 
		ImmersionRPSettings["COMM_CHANNEL"] = "xtensionxtooltip2";
	end
	if (ImmersionRPSettings["COMM_PROTOCOL"] == nil) then 
		ImmersionRPSettings["COMM_PROTOCOL"] = 2;
	end
	if (ImmersionRPSettings["MODIFY_TOOLTIP"] == nil) then 
		ImmersionRPSettings["MODIFY_TOOLTIP"] = 1;
	end
	if (ImmersionRPSettings["HIDE_UNKNOWN_PLAYERS"] == nil) then 
		ImmersionRPSettings["HIDE_UNKNOWN_PLAYERS"] = 0;
	end
	if (ImmersionRPSettings["SHOW_GUILDS"] == nil) then 
		ImmersionRPSettings["SHOW_GUILDS"] = 1;
	end
	if (ImmersionRPSettings["SHOW_RANKS"] == nil) then 
		ImmersionRPSettings["SHOW_RANKS"] = 1;
	end
	if (ImmersionRPSettings["SHOW_RELATIVE_LEVELS"] == nil) then
		ImmersionRPSettings["SHOW_RELATIVE_LEVELS"] = 0;
	end
	if (ImmersionRPSettings["SHOW_MINIMAP_ICON"] ~= nil) then
		ImmersionRPMinimapIcon:Show();
	end
end

function ImmersionRP.InitialiseDefaultCharacterInfo()
	if (ImmersionRPCharacterInfo["RPSTYLE"] == nil) then 
		ImmersionRPCharacterInfo["RPSTYLE"] = 0;
	end
	if (ImmersionRPCharacterInfo["RPSTATUS"] == nil) then 
		ImmersionRPCharacterInfo["RPSTATUS"] = 0;
	end
	if (ImmersionRPCharacterInfo["TITLE"] == nil) then 
		ImmersionRPCharacterInfo["TITLE"] = "";
	end
	if (ImmersionRPCharacterInfo["FIRSTNAME"] == nil) then 
		ImmersionRPCharacterInfo["FIRSTNAME"] = "";
	end
	if (ImmersionRPCharacterInfo["LASTNAME"] == nil) then 
		ImmersionRPCharacterInfo["LASTNAME"] = "";
	end
	if (ImmersionRPCharacterInfo["DESCMETA"] == nil) then 
		ImmersionRPCharacterInfo["DESCMETA"] = 0;
	end
	if (ImmersionRPCharacterInfo["DESCRIPTION"] == nil) then
		ImmersionRPCharacterInfo["DESCRIPTION"] = "";
	end
	if (ImmersionRPCharacterInfo["EXTRANAME1"] ~= nil and ImmersionRPCharacterInfo["EXTRANAME1"] ~= "") then
		if (ImmersionRPCharacterInfo["NAMETYPE"] == 0 or ImmersionRPCharacterInfo["NAMETYPE"] == nil) then
			ImmersionRPCharacterInfo["LASTNAME"] = ImmersionRPCharacterInfo["EXTRANAME1"];
		else
			ImmersionRPCharacterInfo["FIRSTNAME"] = ImmersionRPCharacterInfo["EXTRANAME1"];
		end
	end
	ImmersionRPCharacterInfo["EXTRANAME1"] = nil;
	ImmersionRPCharacterInfo["NAMETYPE"] = nil;
end

function ImmersionRP.InitialiseSlashCommands()
	SLASH_IMMERSIONRPTOGGLE1 = "/immersionrp";
	SLASH_IMMERSIONRPTOGGLE2 = "/irp";
	SlashCmdList["IMMERSIONRPTOGGLE"] = ImmersionRP.HandleSlashCommands;
end

function ImmersionRP.InitialiseStaticPopups()
	StaticPopupDialogs["IRP_CHARACTERLOOKUP"] = {
		text = IRP_STRING_CHARACTERLOOKUP_TEXT,
		button1 = IRP_STRING_CHARACTERLOOKUP_FIND,
		button2 = CANCEL,
		OnAccept = function()
			ImmersionRP.FindCharacter(getglobal(this:GetParent():GetName().."EditBox"):GetText());
		end,
		EditBoxOnEnterPressed = function()
			ImmersionRP.FindCharacter(getglobal(this:GetParent():GetName().."EditBox"):GetText());
		end,		
		timeout = 0,
		whileDead = 1,
		hideOnEscape = 1,
		hasEditBox = 1
	};
	
	StaticPopupDialogs["IRP_JOINCHANNEL"] = {
		text = IRP_STRING_NOTINCHANNEL,
		button1 = OKAY,
		button2 = CANCEL,
		OnAccept = function()
			ImmersionRP.ImmersionRPSettingsJoinChannel_OnClick();
		end,
		timeout = 0,
		whileDead = 1,
		hideOnEscape = 1
	};
end

function ImmersionRP.FindCharacter(nametyped)
	if (nametyped ~= "" and nametyped ~= nil) then
		local normalisedname = string.upper(string.sub(nametyped,1,1)) .. string.lower(string.sub(nametyped,2,string.len(nametyped)));
		if (ImmersionRPDatabase[ImmersionRP.RealmName][normalisedname] ~= nil) then
			if (not ImmersionRPInfoboxHandler.SetPlayer(normalisedname)) then 
				UIErrorsFrame:AddMessage(string.format(IRP_STRING_CHARACTERLOOKUP_NOINFO, normalisedname),1,0,0);
			else
				ImmersionRPInfoboxHandler.InfoboxChange = false;
			end
			return nil;
		end
		for name in pairs(ImmersionRPDatabase[ImmersionRP.RealmName]) do
			if (string.find(name, normalisedname) ~= nil or string.find(string.lower(ImmersionRPDatabaseHandler.GetPlayerName(name)), string.lower(normalisedname)) ~= nil) then
				if (not ImmersionRPInfoboxHandler.SetPlayer(name)) then 
					UIErrorsFrame:AddMessage(string.format(IRP_STRING_CHARACTERLOOKUP_NOINFO, nametyped),1,0,0);
				else
					ImmersionRPInfoboxHandler.InfoboxChange = false;
				end
				return nil;
			end
		end
		UIErrorsFrame:AddMessage(string.format(IRP_STRING_CHARACTERLOOKUP_NOMATCH, nametyped),1,0,0);
	end
end

function ImmersionRP.InitialiseUnitPopupMenus()
	UnitPopupButtons["IRP_MENU"] = { text = "ImmersionRP", dist = 0, nested = 1 };
	UnitPopupButtons["IRP_TOGGLE"] = { text = IRP_STRING_MENU_TOGGLE, dist = 0 };
	UnitPopupButtons["IRP_FIND"] = { text = IRP_STRING_MENU_FIND, dist = 0 };
	UnitPopupButtons["IRP_TOGGLEINFOBOX"] = { text = IRP_STRING_MENU_TOGGLEINFOBOX, dist = 0};
	UnitPopupButtons["IRP_DISABLE"] = { text = IRP_STRING_MENU_DISABLE, dist=0 };
	UnitPopupButtons["IRP_TOGGLEHELM"] = { text = IRP_STRING_MENU_TOGGLEHELM, dist=0 };
	UnitPopupButtons["IRP_TOGGLECLOAK"] = { text = IRP_STRING_MENU_TOGGLECLOAK, dist=0 };
	if (ImmersionRPSettings["COMM_PROTOCOL"] == 2) then --flagRSP protocol
		UnitPopupButtons["IRP_FLAGRSP_OOC"] = { text = IRP_STRING_RSP_OOC_TOOLTIP, dist = 0 };
		UnitPopupButtons["IRP_FLAGRSP_IC"] = { text = IRP_STRING_RSP_IC_TOOLTIP, dist = 0 };
		UnitPopupButtons["IRP_FLAGRSP_ICFFA"] = { text = IRP_STRING_RSP_ICFFA_TOOLTIP, dist = 0 };
		UnitPopupButtons["IRP_FLAGRSP_STORYTELLER"] = { text = IRP_STRING_RSP_STORYTELLER_TOOLTIP, dist = 0 };
		UnitPopupButtons["IRP_FLAGRSP_NORPSTATUS"] = { text = IRP_STRING_MENU_NORPSTATUS, dist = 0 };
		UnitPopupMenus["IRP_MENU"] = { "IRP_TOGGLE", "IRP_FLAGRSP_OOC", "IRP_FLAGRSP_IC", "IRP_FLAGRSP_ICFFA", "IRP_FLAGRSP_STORYTELLER", "IRP_FLAGRSP_NORPSTATUS", "IRP_FIND", "IRP_TOGGLEHELM", "IRP_TOGGLECLOAK", "IRP_DISABLE" };
	end
	table.insert(UnitPopupMenus["SELF"],table.getn(UnitPopupMenus["SELF"]),"IRP_MENU");
	table.insert(UnitPopupMenus["PLAYER"],table.getn(UnitPopupMenus["PLAYER"]),"IRP_TOGGLEINFOBOX");
	table.insert(UnitPopupMenus["PARTY"],table.getn(UnitPopupMenus["PARTY"]),"IRP_TOGGLEINFOBOX");
	table.insert(UnitPopupMenus["RAID"],table.getn(UnitPopupMenus["RAID"]),"IRP_TOGGLEINFOBOX");
end

function ImmersionRP.HandleSlashCommands(command)
	if (command == "") then
		ImmersionRP.ToggleMainFrame();
	elseif (string.lower(command) == "rpmode") then
		ImmersionRP.ToggleRPMode();
	elseif (string.lower(command) == "help") then
		ImmersionRPMainFrame:Show();
		ImmersionRP.ShowHelp();
	elseif (string.lower(command) == "character") then
		ImmersionRPMainFrame:Show();
		ImmersionRP.ShowCharacterInfo();
	elseif (string.lower(command) == "settings") then
		ImmersionRPMainFrame:Show();
		ImmersionRP.ShowSettings();
	elseif (string.lower(command) == "social" and ImmersionRPSocialHandler ~= nil) then
		ImmersionRPMainFrame:Show();
		ImmersionRP.ShowSocial();
	elseif (string.lower(command) == "toggleicon") then
		if (ImmersionRPMinimapIcon:IsVisible()) then
			ImmersionRPMinimapIcon:Hide();
			ImmersionRPSettings["SHOW_MINIMAP_ICON"] = nil;
		else
			ImmersionRPMinimapIcon:Show();
			ImmersionRPSettings["SHOW_MINIMAP_ICON"] = true;
		end
	elseif (string.lower(command) == "owntooltip") then
		if (ImmersionRP.OwnTooltip == nil) then
			ImmersionRP.OwnTooltip = 1;
		elseif (ImmersionRP.OwnTooltip == 1) then
			ImmersionRP.OwnTooltip = nil;
		end
	elseif (string.lower(command) == "moverpbutton") then
		if (not ImmersionRPRPModeButton.Draggable) then
			ImmersionRPRPModeButton:RegisterForDrag("LeftButton");
			ImmersionRPRPModeButton.Draggable = true;
		else
			ImmersionRPRPModeButton:RegisterForDrag("");
			ImmersionRPRPModeButton.Draggable = nil;
		end
	elseif (string.lower(command) == "centerrpbutton") then
		ImmersionRPRPModeButton:SetPoint("TOP", "UIParent", "CENTER", 0, ImmersionRPRPModeButton:GetHeight()/2)
	elseif (string.lower(string.sub(command, 1, 4)) == "find") then
		if (string.sub(command, 6, string.len(command)) ~= "") then
			ImmersionRP.FindCharacter(string.sub(command, 6, string.len(command)));
		else
			StaticPopup_Show ("IRP_CHARACTERLOOKUP");
		end
	end 
end

function ImmersionRP.ToggleMainFrame()
	if (ImmersionRPMainFrame:IsVisible()) then
		ImmersionRPMainFrame:Hide();
	else
		ImmersionRPMainFrame:Show();
	end 
end

function ImmersionRP.ShowHelp()
	if (ImmersionRPSocialFrame ~= nil) then ImmersionRPSocialFrame:Hide(); end
	ImmersionRPCharacterFrame:Hide();
	ImmersionRPSettingsFrame:Hide();
	ImmersionRPHelpFrame:Show();
end

function ImmersionRP.ShowSettings()
	if (ImmersionRPSocialFrame ~= nil) then ImmersionRPSocialFrame:Hide(); end
	ImmersionRPCharacterFrame:Hide();
	ImmersionRPHelpFrame:Hide();
	if (not ImmersionRPSettingsFrame:IsVisible()) then
		ImmersionRP.RefreshSettingsTab();
	end
	ImmersionRPSettingsFrame:Show();
end

function ImmersionRP.RefreshSettingsTab()
	ImmersionRPSettingsModifyTooltip:SetChecked(ImmersionRPSettings["MODIFY_TOOLTIP"]);
	ImmersionRPSettingsHideUnknown:SetChecked(ImmersionRPSettings["HIDE_UNKNOWN_PLAYERS"]);
	ImmersionRPSettingsRelativeLevels:SetChecked(ImmersionRPSettings["SHOW_RELATIVE_LEVELS"]);
	ImmersionRPSettingsCommChannel:ClearFocus();
	ImmersionRPSettingsCommChannel:SetText(ImmersionRPSettings["COMM_CHANNEL"]);
end

function ImmersionRP.RefreshCharacterInfoTab()
	ImmersionRPCharacterDescription:SetText(ImmersionRP.DecodeDescription(ImmersionRPCharacterInfo["DESCRIPTION"]));
	ImmersionRPCharacterFirstName:SetText(ImmersionRPCharacterInfo["FIRSTNAME"]);
	ImmersionRPCharacterLastName:SetText(ImmersionRPCharacterInfo["LASTNAME"]);
	ImmersionRPCharacterTitle:SetText(ImmersionRPCharacterInfo["TITLE"]);
	
	HideDropDownMenu(1);
	UIDropDownMenu_Initialize(ImmersionRPCharacterRPStyle, ImmersionRP.InitialiseRPStyleDropdown);
	UIDropDownMenu_SetSelectedID(ImmersionRPCharacterRPStyle,ImmersionRPCharacterInfo["RPSTYLE"] + 1,false);
	UIDropDownMenu_SetWidth(245, ImmersionRPCharacterRPStyle);
	ImmersionRPCharacterRevert:Disable()
end

function ImmersionRP.ShowCharacterInfo()
	if (ImmersionRPSocialFrame ~= nil) then ImmersionRPSocialFrame:Hide(); end
	ImmersionRPSettingsFrame:Hide();
	ImmersionRPHelpFrame:Hide();
	if (not ImmersionRPCharacterFrame:IsVisible()) then
		ImmersionRP.RefreshCharacterInfoTab();
	end
	ImmersionRPCharacterFrame:Show();
end

function ImmersionRP.ShowSocial()
	ImmersionRPSettingsFrame:Hide();
	ImmersionRPHelpFrame:Hide();
	ImmersionRPCharacterFrame:Hide();
	ImmersionRPSocialFrame:Show();
end

function ImmersionRP.BindFrameToWorldFrame(frame)
	local scale = UIParent:GetEffectiveScale();
	frame:SetParent(WorldFrame);
	frame:SetScale(scale);
end

function ImmersionRP.BindFrameToUIParent(frame)
	frame:SetParent(UIParent);
	frame:SetScale(1);
end

function ImmersionRP.ToggleRPMode()
	if (ImmersionRP.RPMode == 0) then
		ImmersionRP.EnableRPMode();
	else
		ImmersionRP.DisableRPMode();
	end
end

function ImmersionRP.EnableRPMode()
	ImmersionRP.BindFrameToWorldFrame(GameTooltip);
	ImmersionRP.BindFrameToWorldFrame(ChatFrameEditBox);
	ImmersionRP.BindFrameToWorldFrame(ChatFrameMenuButton);
	ImmersionRP.BindFrameToWorldFrame(ChatMenu);
	--ImmersionRP.BindFrameToWorldFrame(ImmersionRPInfobox);
	for i = 1, 7 do
		ImmersionRP.BindFrameToWorldFrame(getglobal("ChatFrame" .. i));
		ImmersionRP.BindFrameToWorldFrame(getglobal("ChatFrame" .. i .. "Tab"));
		ImmersionRP.BindFrameToWorldFrame(getglobal("ChatFrame" .. i .. "TabDockRegion"));
	end
	ImmersionRP.RPMode = 1;
	CloseAllWindows();
	UIParent:Hide();
	ImmersionRPRPModeFrame:Show();
end

function ImmersionRP.DisableRPMode()
	ImmersionRP.BindFrameToUIParent(GameTooltip);
	GameTooltip:SetFrameStrata("TOOLTIP");
	ImmersionRP.BindFrameToUIParent(ChatFrameEditBox);
	ChatFrameEditBox:SetFrameStrata("DIALOG");
	ImmersionRP.BindFrameToUIParent(ChatFrameMenuButton);
	ChatFrameMenuButton:SetFrameStrata("DIALOG");
	ImmersionRP.BindFrameToUIParent(ChatMenu);
	ChatMenu:SetFrameStrata("DIALOG");
	--ImmersionRP.BindFrameToUIParent(ImmersionRPInfobox);
	for i = 1, 7 do
		ImmersionRP.BindFrameToUIParent(getglobal("ChatFrame" .. i));
		ImmersionRP.BindFrameToUIParent(getglobal("ChatFrame" .. i .. "Tab"));
		ImmersionRP.BindFrameToUIParent(getglobal("ChatFrame" .. i .. "TabDockRegion"));
	end
	ImmersionRP.RPMode = 0;
	if (ImmersionRPRPModeFrame:IsVisible()) then ImmersionRPRPModeFrame:Hide(); end
	UIParent:Show();
end
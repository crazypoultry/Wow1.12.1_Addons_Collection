GRAY_FONT_COLOR_CODE = "|cff808080";
TITANFRIENDS_ARTWORK_PATH = "Interface\\AddOns\\TitanFriends\\"

function TitanPanelFriendsButton_OnLoad()
	this.registry = { 
		id = "Friends",
		menuText = TITAN_FRIENDS_MENU_TEXT, 
		buttonTextFunction = "TitanPanelFriendsButton_GetButtonText", 
		tooltipTitle = TITAN_FRIENDS_TOOLTIP,
		tooltipCustomFunction = TitanPanelFriendsButton_SetTooltipText,
		icon = TITANFRIENDS_ARTWORK_PATH.."TitanFriends",
		iconWidth = 16,
		savedVariables = {
			ShowIcon = 1,
			ShowLabelText = 1,
		}

	};

	-------------------------------------------------
	-- DEFAULT VARIABLES
	-------------------------------------------------
	if( not TitanFriends_showoffline ) then TitanFriends_showoffline = 0; end;
	if( not TitanFriends_showignored ) then TitanFriends_showignored = 0; end;
	if( not TitanFriends_showclass ) then TitanFriends_showclass = 1; end;

	-------------------------------------------------
	-- SLASH COMMANDS
	-------------------------------------------------
	SlashCmdList["TITANFRIENDS"] = TitanPanelFriends_SlashCommand;
  	SLASH_TITANFRIENDS1 = "/titanfriends";
	SLASH_TITANFRIENDS2 = "/tf";

	this:RegisterEvent("FRIENDLIST_SHOW");
	this:RegisterEvent("FRIENDLIST_UPDATE");
	DEFAULT_CHAT_FRAME:AddMessage("<Titan Friends> Loaded. v"..TITAN_FRIENDS_VERSION..". Type /tf help or /titanfriends help for slash commands.", 1, 1, 1);
end

function TitanPanelFriends_SlashCommand(cmd)
	local cmd = string.lower(cmd);
	if    ( cmd == "showoffline") then
		if TitanFriends_showoffline == 0 then 
			TitanFriends_showoffline = 1;
			DEFAULT_CHAT_FRAME:AddMessage("<Titan Friends> Offline friends will now be shown.", 1, 1, 1);
		else 
			TitanFriends_showoffline = 0; 
			DEFAULT_CHAT_FRAME:AddMessage("<Titan Friends> Offline friends will no longer be shown.", 1, 1, 1);
		end;	
	elseif    ( cmd == "showclass") then
		if TitanFriends_showclass == 0 then 
			TitanFriends_showclass = 1;
			DEFAULT_CHAT_FRAME:AddMessage("<Titan Friends> Your friends class will no longer be shown.", 1, 1, 1);
		else 
			TitanFriends_showclass = 0; 
			DEFAULT_CHAT_FRAME:AddMessage("<Titan Friends> Your friends class will now be shown.", 1, 1, 1);
		end;
	elseif    ( cmd == "showignored") then
		if TitanFriends_showignored == 0 then 
			TitanFriends_showignored = 1;
			DEFAULT_CHAT_FRAME:AddMessage("<Titan Friends> Your ignored list will now be shown.", 1, 1, 1);
		else 
			TitanFriends_showignored = 0; 
			DEFAULT_CHAT_FRAME:AddMessage("<Titan Friends> Your ignored list will no longer be shown.", 1, 1, 1);
		end;
	elseif    ( cmd == "help") then 
		DEFAULT_CHAT_FRAME:AddMessage(TITAN_FRIENDS_HELP[1], 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage(TITAN_FRIENDS_HELP[2], 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage(TITAN_FRIENDS_HELP[3], 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage(TITAN_FRIENDS_HELP[4], 1, 1, 1);
	end;	
end


function TitanPanelFriendsButton_OnEvent(event, arg1, arg2, arg3)
		
	TitanPanelButton_UpdateButton("Friends");	
	TitanPanelButton_UpdateTooltip();
end

function TitanPanelFriendsButton_OnEnter()
	-- refresh the friends list
	ShowFriends();
end

function TitanPanelFriendsButton_OnClick()
	if (arg1 == "LeftButton") then
		ToggleFriendsFrame(1)
	else
		TitanPanelButton_OnClick(arg1);
	end
end

function TitanPanelRightClickMenu_PrepareFriendsMenu()
	local info = {};
	local id = "Friends";


	-- create the Whisper submenu items

	if ( UIDROPDOWNMENU_MENU_LEVEL == 2 ) then

		if ( UIDROPDOWNMENU_MENU_VALUE == TITAN_FRIENDS_MENU_WHISPER ) then

			-- generate a list of online friends and set up whisper
			local NumFriends = GetNumFriends();

			local friend_name, friend_level, friend_class, friend_area, friend_connected
			local friendIndex

			-- get a count of the number of online friends
			for friendIndex=1, NumFriends do
				friend_name, friend_level, friend_class, friend_area, friend_connected = GetFriendInfo(friendIndex);
				if ( friend_connected ) then
					info = {};
					info.text = friend_name;
					info.func = friendWhisper;
					info.value = friend_name;
					UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
				end
			end
		end

		if ( UIDROPDOWNMENU_MENU_VALUE == TITAN_FRIENDS_MENU_REMOVE ) then

			-- generate a list of online friends and set up whisper
			local NumFriends = GetNumFriends();

			local friend_name, friend_level, friend_class, friend_area, friend_connected
			local friendIndex

			-- get a count of the number of online friends
			for friendIndex=1, NumFriends do
				friend_name, friend_level, friend_class, friend_area, friend_connected = GetFriendInfo(friendIndex);
				if ( friend_connected ) then
					info = {};
					info.text = friend_name;
					info.func = friendRemove;
					info.value = friend_name;
					UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
				end
			end
		end


		if ( UIDROPDOWNMENU_MENU_VALUE == TITAN_FRIENDS_MENU_INVITE ) then

			-- generate a list of online friends and set up whisper
			local NumFriends = GetNumFriends();

			local friend_name, friend_level, friend_class, friend_area, friend_connected
			local friendIndex

			-- get a count of the number of online friends
			for friendIndex=1, NumFriends do
				friend_name, friend_level, friend_class, friend_area, friend_connected = GetFriendInfo(friendIndex);
				if ( friend_connected ) then
					info = {};
					info.text = friend_name;
					info.func = friendInvite;
					info.value = friend_name;
					UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
				end
			end
		end
		return;
	end

	TitanPanelRightClickMenu_AddTitle(TitanPlugins[id].menuText);

	-- create the title for the Whisper submenu
	info = {};
	info.text = TITAN_FRIENDS_MENU_WHISPER;
	info.value = TITAN_FRIENDS_MENU_WHISPER;
	info.hasArrow = 1;
	UIDropDownMenu_AddButton(info);

	-- create the title for the Invite submenu
	info = {};
	info.text = TITAN_FRIENDS_MENU_INVITE;
	info.value = TITAN_FRIENDS_MENU_INVITE;
	info.hasArrow = 1;
	UIDropDownMenu_AddButton(info);

	-- create the title for the Ignore submenu
	info = {};
	info.text = TITAN_FRIENDS_MENU_REMOVE;
	info.value = TITAN_FRIENDS_MENU_REMOVE;
	info.hasArrow = 1;
	UIDropDownMenu_AddButton(info);

	TitanPanelRightClickMenu_AddSpacer();

	TitanPanelRightClickMenu_AddToggleIcon("Friends");
	TitanPanelRightClickMenu_AddToggleLabelText("Friends");

	-- default Titan Panel right-click menu options
	TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_CUSTOMIZE..TITAN_PANEL_MENU_POPUP_IND, id, TITAN_PANEL_MENU_FUNC_CUSTOMIZE);
	TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, id, TITAN_PANEL_MENU_FUNC_HIDE);

end

function friendRemove()
	local IgnoreRemove = this.value;
	RemoveFriend( this.value );
end

function friendInvite()
	InviteByName( this.value );
end

function friendWhisper()
	if ( not ChatFrameEditBox:IsVisible() ) then
		ChatFrame_OpenChat("/w "..this.value.." ");
	else
		ChatFrameEditBox:SetText("/w "..this.value.." ");
	end
end

function TitanPanelFriendsButton_GetButtonText(id)
	local id = TitanUtils_GetButton(id, true);
	local NumFriends = GetNumFriends();
	local NumIgnore = GetNumIgnores();
	local NumFriendsOnline = 0;

	local friend_name, friend_level, friend_class, friend_area, friend_connected
	local friendIndex

	-- get a count of the number of online friends
	for friendIndex=1, NumFriends do
		friend_name, friend_level, friend_class, friend_area, friend_connected = GetFriendInfo(friendIndex);
		if ( friend_connected ) then
			NumFriendsOnline = NumFriendsOnline + 1;
		end
	end

	-- create string for Titan bar display
	local buttonRichText = format(TITAN_FRIENDS_BUTTON_TEXT, TitanUtils_GetGreenText(NumFriendsOnline), TitanUtils_GetHighlightText(NumFriends), TitanUtils_GetRedText(NumIgnore));
	return TITAN_FRIENDS_BUTTON_LABEL, buttonRichText;
end


function TitanPanelFriends_PopulateName(status, level, class, name)		
		local colorCode = "";
		if (status) then status = status.." "; end;

		if (class == "Hexenmeister") then colorCode = "|cff9382C9";
		elseif (class == "J\195\164ger") then colorCode = "|cffaad372";
		elseif (class == "Priester") then colorCode = "|cffffffff";
		elseif (class == "Paladin") then colorCode = "|cfff48cba";
		elseif (class == "Magier") then colorCode = "|cff68ccef";
		elseif (class == "Schurke") then colorCode = "|cfffff468";
		elseif (class == "Druide") then colorCode = "|cffff7c0a";
		elseif (class == "Schamane") then colorCode = "|cfff48cba";
		elseif (class == "Krieger") then colorCode = "|cffc69b6d";
		else colorCode = "|cffc69b6d";
		end

		if ( TitanFriends_showclass == 1 ) then
		return "  "..status.."("..TitanUtils_GetHighlightText(level)..") "..colorCode..name..FONT_COLOR_CODE_CLOSE;
		elseif ( TitanFriends_showclass == 0 ) then
		return "  "..status..name.." ("..TitanUtils_GetHighlightText(level).." "..colorCode..class..FONT_COLOR_CODE_CLOSE..")";
		end
end


function TitanPanelFriendsButton_SetTooltipText()

	local NumFriendsOn = TitanPanelFriends_GetNumOnline;

-- Tooltip title
	GameTooltip:SetText(TITAN_FRIENDS_TOOLTIP, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	GameTooltip:AddLine(GRAY_FONT_COLOR_CODE.."Need some help? Type /titanfriends help"..FONT_COLOR_CODE_CLOSE);
	GameTooltip:AddLine("\n");
	GameTooltip:AddLine("<"..TitanUtils_GetHighlightText(TITAN_FRIENDS_TOOLTIP_ONLINE)..">");
	

	local NumFriends = GetNumFriends();
	local OnlineFriends = 0;

	local Onlinefriend_name, Onlinefriend_level, Onlinefriend_class, Onlinefriend_area, Onlinefriend_connected, Onlinefriend_status
	local OnlinefriendIndex

	-- create tooltip for online friends
	if (NumFriends == 0) then GameTooltip:AddLine("You currently have no one on your friends list");
	else for OnlinefriendIndex=1, NumFriends do
		Onlinefriend_name, Onlinefriend_level, Onlinefriend_class, Onlinefriend_area, Onlinefriend_connected, Onlinefriend_status = GetFriendInfo(OnlinefriendIndex);
			if ( Onlinefriend_connected ) then
			GameTooltip:AddDoubleLine(TitanPanelFriends_PopulateName(Onlinefriend_status, Onlinefriend_level, Onlinefriend_class, Onlinefriend_name), TitanUtils_GetHighlightText(Onlinefriend_area));
			OnlineFriends = OnlineFriends + 1;
			end
		end
	
		if ( OnlineFriends == 0 ) then 
			GameTooltip:AddLine("None of your friends are currently online"); 
		end

		-- create tooltip, if enabled, for offline friends
		if ( TitanFriends_showoffline == 1 ) then
			GameTooltip:AddLine("\n");
			GameTooltip:AddLine("<"..TitanUtils_GetHighlightText(TITAN_FRIENDS_TOOLTIP_OFFLINE)..">");

			local Offlinefriend_name, Offlinefriend_level, Offlinefriend_class, Offlinefriend_area, Offlinefriend_connected
			local OfflinefriendIndex
	
			-- create tooltip
			for OfflinefriendIndex=1, NumFriends do
				Offlinefriend_name, Offlinefriend_level, Offlinefriend_class, Offlinefriend_area, Offlinefriend_connected = GetFriendInfo(OfflinefriendIndex);
				if (not Offlinefriend_connected ) then
				GameTooltip:AddLine("  "..TitanUtils_GetNormalText(Offlinefriend_name));
				end
			end
		end
	end

	if ( TitanFriends_showignored == 1 ) then
		GameTooltip:AddLine("\n");
		GameTooltip:AddLine("<"..TitanUtils_GetHighlightText(TITAN_FRIENDS_TOOLTIP_IGNORE)..">");


		Numignored = GetNumIgnores();

		local ignored_name, ignored_level, ignored_class, ignored_area, ignored_connected
		local ignoredIndex

		-- create tooltip
		if (Numignored == 0) then GameTooltip:AddLine("Your ignore list is currently empty.");
			else for ignoredIndex=1, Numignored do
				if (not Offlinefriend_connected ) then
					GameTooltip:AddLine("  "..TitanUtils_GetNormalText(GetIgnoreName(ignoredIndex)));
				end
			end
		end
	end		
end




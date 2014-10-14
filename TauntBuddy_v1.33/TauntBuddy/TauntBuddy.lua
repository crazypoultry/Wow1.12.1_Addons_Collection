--[[
-	Taunt Buddy v1.33
-	Author: Artun Subasi
-	Kane from Magtherion EU (retired)
-	Contact: http://www.curse-gaming.com | USER NAME: Kane
--]]

function TB_OnLoad()
	local playerClass, englishClass = UnitClass("player");
	if (englishClass ~= "WARRIOR") then
		return;
	end
		
	TauntBuddyFrame:RegisterEvent("VARIABLES_LOADED");					-- Jump to event function when variables are loaded
	SlashCmdList["TBSLASH"] = TB_SlashCommandHandler;					-- List of slash commands
	SLASH_TBSLASH1 = "/tauntbuddy";								-- /tauntbuddy
	SLASH_TBSLASH2 = "/tb";										-- /tb
end

function TB_OnEvent(event)
 										
	-- Execute this function whenever you get a string in the self damage spells section, or when variables are loaded.
	if(event == "CHAT_MSG_SPELL_SELF_DAMAGE") then
		local _, _, taunt = string.find(arg1, TB_tauntLine); 	-- Searchs the string for the following regular expression 
		local _, _, mb = string.find(arg1, TB_mb);
		if (taunt) then 										-- Checks if your taunt was resisted
	
		-- Your taunt was resisted, now announce in channel according to options --
			-- Channel option: AUTO --
			if (TBSettings.channel == "auto") then
				if (GetNumRaidMembers() > 0) then					-- Checks if you are in a raid
					if (IsAddOnLoaded("CT_RaidAssist")) then
						CT_RA_AddMessage("MS " .. TBSettings.text_t);	-- Announcement in CT raid channel (if you can)
					end		
					SendChatMessage(TBSettings.text_t,"RAID");			-- Announcement in raid channel
				elseif (GetNumPartyMembers() > 0) then				-- Not in a raid, check if you are in a party
					SendChatMessage(TBSettings.text_t,"PARTY"); 		-- Announcement in party channel
				else
					SendChatMessage(TBSettings.text_t,"SAY"); 		-- Announcement in say channel
				end

			-- Channel option: RAID --
			elseif (TBSettings.channel == "raid") then
				if (GetNumRaidMembers() > 0) then					-- Checks if you are in a raid
					SendChatMessage(TBSettings.text_t,"RAID");			-- Announcement in raid channel
				end
		
			-- Channel option: PARTY --
			elseif (TBSettings.channel == "party") then
				if (GetNumPartyMembers() > 0) then					-- Checks if you are in a party
					SendChatMessage(TBSettings.text_t,"PARTY"); 			-- Announcement in raid channel
				end

			-- Channel option: SAY --
			elseif (TBSettings.channel == "say") then			
				SendChatMessage(TBSettings.text_t,"SAY"); 			-- Announcement in say channel

			-- Channel option: CTRAID --
			elseif (TBSettings.channel == "ctraid") then
				if (GetNumRaidMembers() > 0) then					-- Checks if you are in a raid
					if (IsAddOnLoaded("CT_RaidAssist")) then			-- Checks if CT_RaidAssist is loaded
						CT_RA_AddMessage("MS " .. TBSettings.text_t);	-- Announcement in CT raid channel (if you can)					
					end
					SendChatMessage(TBSettings.text_t,"RAID");		-- Announcement in raid channel	
				end

			-- Channel option: CHANNEL --
			elseif (TBSettings.channel == "channel") then
				local TB_channelId, TB_channelName = GetChannelName(TBSettings.channelName);
				if (TB_channelId > 0) then						-- Checks if you are still in that channel
					SendChatMessage(TBSettings.text_t, "CHANNEL", common, GetChannelName(TBSettings.channelName));
				end			
			end
		end
		
		if (mb) then			-- Checks if the string has the words "Mocking Blow"
			local mbHit = string.find(arg1, TB_mbHitLine);						-- Checks if your mocking blow was hit
			if (mbHit == nil) then			-- If your mocking blow didnt hit, then do ..
	
			-- Your mocking blow was failed, now announce in channel according to options --
				-- Channel option: AUTO --
				if (TBSettings.channel == "auto") then
					if (GetNumRaidMembers() > 0) then					-- Checks if you are in a raid
						if (IsAddOnLoaded("CT_RaidAssist")) then
							CT_RA_AddMessage("MS " .. TBSettings.text_mb);	-- Announcement in CT raid channel (if you can)
						end		
						SendChatMessage(TBSettings.text_mb,"RAID");			-- Announcement in raid channel
					elseif (GetNumPartyMembers() > 0) then				-- Not in a raid, check if you are in a party
						SendChatMessage(TBSettings.text_mb,"PARTY"); 		-- Announcement in party channel
					else
						SendChatMessage(TBSettings.text_mb,"SAY"); 		-- Announcement in say channel
					end

				-- Channel option: RAID --
				elseif (TBSettings.channel == "raid") then
					if (GetNumRaidMembers() > 0) then					-- Checks if you are in a raid
						SendChatMessage(TBSettings.text_mb,"RAID");			-- Announcement in raid channel
					end
		
				-- Channel option: PARTY --
				elseif (TBSettings.channel == "party") then
					if (GetNumPartyMembers() > 0) then					-- Checks if you are in a party
						SendChatMessage(TBSettings.text_mb,"PARTY"); 			-- Announcement in raid channel
					end

				-- Channel option: SAY --
				elseif (TBSettings.channel == "say") then
					SendChatMessage(TBSettings.text_mb,"SAY"); 			-- Announcement in say channel
					
				-- Channel option: CTRAID --
				elseif (TBSettings.channel == "ctraid") then
					if (GetNumRaidMembers() > 0) then					-- Checks if you are in a raid
						if (IsAddOnLoaded("CT_RaidAssist")) then			-- Checks if CT_RaidAssist is loaded
							CT_RA_AddMessage("MS " .. TBSettings.text_mb);	-- Announcement in CT raid channel (if you can)					
						end
						SendChatMessage(TBSettings.text_mb,"RAID");		-- Announcement in raid channel	
					end

				-- Channel option: CHANNEL --
				elseif (TBSettings.channel == "channel") then
					local TB_channelId, TB_channelName = GetChannelName(TBSettings.channelName);
					if (TB_channelId > 0) then						-- Checks if you are still in that channel
						SendChatMessage(TBSettings.text_mb, "CHANNEL", common, GetChannelName(TBSettings.channelName));
					end
				end			
			end
		end

	elseif(event == "VARIABLES_LOADED") then
		if (TBSettings == nil) then								-- SavedVariables
			TBSettings = {};
		end
		if (TBSettings.channel == nil) then							
			TBSettings.channel = "auto";							-- Default value for channel
		end
		if (TBSettings.text_t == nil) then
			TBSettings.text_t = TB_defaultText_t;					-- Default value for text_t
		end
		if (TBSettings.text_mb == nil) then
			TBSettings.text_mb = TB_defaultText_mb;					-- Default value for text_mb
		end
		if (TBSettings.status == nil) then
			TBSettings.status = 1;									-- Default value is 1 for status
		end
		if (TBSettings.channelName == nil) then
			TBSettings.channelName = "";							-- Default value for custom channel number
		end
		
		UIDropDownMenu_Initialize(TB_ChannelDropDown, TB_ChannelDropDown_Initialize);
		if (TBSettings.channel == "auto") then
			UIDropDownMenu_SetSelectedID(TB_ChannelDropDown, 1);
		elseif (TBSettings.channel == "ctraid") then
			UIDropDownMenu_SetSelectedID(TB_ChannelDropDown, 2);
		elseif (TBSettings.channel == "raid") then
			UIDropDownMenu_SetSelectedID(TB_ChannelDropDown, 3);
		elseif (TBSettings.channel == "party") then
			UIDropDownMenu_SetSelectedID(TB_ChannelDropDown, 4);
		elseif (TBSettings.channel == "say") then
			UIDropDownMenu_SetSelectedID(TB_ChannelDropDown, 5);
		elseif (TBSettings.channel == "channel") then
			UIDropDownMenu_SetSelectedID(TB_ChannelDropDown, 6);
		end

		TB_Sendmsg("Taunt Buddy " .. TB_version .. TB_output_startup);			-- Taunt Buddy loading message
		if (TBSettings.status == 1) then
			TB_register();										-- Registers the event of self spell damage on startup
		else
			TauntBuddyFrameCheckButton:SetChecked(0);
		end
	end
end	

-- SLASH COMMAND HANDLER --
function TB_SlashCommandHandler( msg )
	local command = string.lower(msg);
	local TB_cmd_channel_argFound = string.find(command, "channel (%w+)"); 		-- Searchs the string for "channel x"
	local TB_cmd_text_argFound_t = string.find(command, "text taunt (.+)"); 	-- Searchs the string for "text taunt"
	local TB_cmd_text_argFound_mb = string.find(command, "text mb (.+)"); 		-- Searchs the string for "text mb"

	-- Console command: /TB ON --
	if (command == TB_cmd_on) then
		if (TBSettings.status == 1) then							-- Checks if Taunt Buddy is already enabled
			TB_Sendmsg(TB_output_alreadyOn);
		else										-- If not enabled..
			TB_Sendmsg(TB_output_on);
			TBSettings.status = 1;								-- Enables Taunt Buddy
			TB_register();
			TauntBuddyFrameCheckButton:SetChecked(1);
		end

	-- Console command: /TB OFF --
	elseif (command == TB_cmd_off) then
		if (TBSettings.status == 0) then							-- Checks if Taunt Buddy is already disabled
			TB_Sendmsg(TB_output_alreadyOff);			
		else										-- if not disabled..
			TB_Sendmsg(TB_output_off);				
			TBSettings.status = 0;								-- Disables Taunt Buddy
			TB_unregister();
			TauntBuddyFrameCheckButton:SetChecked(0);
		end

	-- Console command: /TB STATUS --
	elseif (command == TB_cmd_status) then

		-- Print Status --
		if (TBSettings.status == 1) then
			TB_Sendmsg(TB_output_on);
			
			-- Print the channel option --
			if (TBSettings.channel == "auto") then
				TB_Sendmsg(TB_output_channel_auto);
			elseif (TBSettings.channel == "raid") then
				TB_Sendmsg(TB_output_channel_raid);
			elseif (TBSettings.channel == "party") then
				TB_Sendmsg(TB_output_channel_party);
			elseif (TBSettings.channel == "say") then
				TB_Sendmsg(TB_output_channel_say);
			elseif (TBSettings.channel == "ctraid") then
				TB_Sendmsg(TB_output_channel_ctraid);
			elseif (TBSettings.channel == "channel") then
				TB_Sendmsg(TB_output_channel_channel .. TBSettings.channelName);
			end
		else
			TB_Sendmsg(TB_output_off);
		end

	-- Console Command: /TB channel --	
	elseif (TB_cmd_channel_argFound) then
		local TB_channel = string.sub(command, 9); 					-- TB_channel is a new string without the "channel" part
		local TB_channelId, TB_channelName = GetChannelName(TB_channel);
		if (TB_channelId > 0) then
			TBSettings.channel = "channel";
			TBSettings.channelName = TB_channelName;
	 		TB_Sendmsg(TB_output_channel_channel .. TBSettings.channelName);
			UIDropDownMenu_SetSelectedID(TB_ChannelDropDown, 6);
		else
			TB_Sendmsg(TB_output_channelNotFound);
		end

	-- Console Commands: [ /TB AUTO | /TB RAID | /TB PARTY | /TB CTRAID | /TB SAY] --
	elseif (command == "auto") then
		TBSettings.channel = "auto";
		TB_Sendmsg(TB_output_channel_auto);
		UIDropDownMenu_SetSelectedID(TB_ChannelDropDown, 1);
	elseif (command == "raid") then
		TBSettings.channel = "raid";
		TB_Sendmsg(TB_output_channel_raid);
		UIDropDownMenu_SetSelectedID(TB_ChannelDropDown, 3);
	elseif (command == "party") then
		TBSettings.channel = "party";
		TB_Sendmsg(TB_output_channel_party);
		UIDropDownMenu_SetSelectedID(TB_ChannelDropDown, 4);
	elseif (command == "ctraid") then
		TBSettings.channel = "ctraid";
		TB_Sendmsg(TB_output_channel_ctraid);
		UIDropDownMenu_SetSelectedID(TB_ChannelDropDown, 2);
	elseif (command == "say") then
		TBSettings.channel = "say";
		TB_Sendmsg(TB_output_channel_say);
		UIDropDownMenu_SetSelectedID(TB_ChannelDropDown, 5);
   
	
	-- Console Command: /TB text --
	elseif (TB_cmd_text_argFound_t) then
		TBSettings.text_t = string.sub(msg, 12);
		TB_Sendmsg(TB_output_textChange_t .. TBSettings.text_t);
	elseif (TB_cmd_text_argFound_mb) then
		TBSettings.text_mb = string.sub(msg, 9);
		TB_Sendmsg(TB_output_textChange_mb .. TBSettings.text_mb);
	elseif (command == "text" or command == "text taunt" or command == "text mb") then
		TB_Sendmsg(TB_output_usage_text);

	-- Console Command: /TB --
	elseif (command == "") then
		TauntBuddyFrame:Show();		

	-- Console Command: Unknown command or syntax error --
	else
		TauntBuddyFrame:Show();
	end
end
-- END OF SLASH COMMAND HANDLER --

function TB_register()
	TauntBuddyFrame:RegisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE");
end

function TB_unregister()
	TauntBuddyFrame:UnregisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE");
end

function TB_Sendmsg( msg )
	if(DEFAULT_CHAT_FRAME) then
		DEFAULT_CHAT_FRAME:AddMessage(msg, 0.0, 1.0, 0.0, 1.0);
	end	
end

function TB_ChannelDropDown_OnLoad()	
	UIDropDownMenu_SetWidth(100);
end

function TB_ChannelDropDown_Initialize()
	local channel_info = {};
	channel_info.text = TB_GUI_Channel_Auto;
	channel_info.func = TB_ChannelDropDown_OnClick;
	UIDropDownMenu_AddButton(channel_info);

	channel_info = {};
	channel_info.text = TB_GUI_Channel_Ctraid;
	channel_info.func = TB_ChannelDropDown_OnClick;
	UIDropDownMenu_AddButton(channel_info);

	channel_info = {};
	channel_info.text = TB_GUI_Channel_Raid;
	channel_info.func = TB_ChannelDropDown_OnClick;
	UIDropDownMenu_AddButton(channel_info);

	channel_info = {};
	channel_info.text = TB_GUI_Channel_Party;
	channel_info.func = TB_ChannelDropDown_OnClick;
	UIDropDownMenu_AddButton(channel_info);

	channel_info = {};
	channel_info.text = TB_GUI_Channel_Say;
	channel_info.func = TB_ChannelDropDown_OnClick;
	UIDropDownMenu_AddButton(channel_info);

	channel_info = {};
	channel_info.text = TB_GUI_Channel_Custom;
	channel_info.func = TB_ChannelDropDown_OnClick;
	UIDropDownMenu_AddButton(channel_info);
end

function TB_ChannelDropDown_OnClick()
	UIDropDownMenu_SetSelectedID(TB_ChannelDropDown, this:GetID());
	if ( this:GetID() == 1 ) then
		TBSettings.channel = "auto";
	elseif ( this:GetID() == 2 ) then
		TBSettings.channel = "ctraid";
	elseif ( this:GetID() == 3 ) then
		TBSettings.channel = "raid";
	elseif ( this:GetID() == 4 ) then
		TBSettings.channel = "party";
	elseif ( this:GetID() == 5 ) then
		TBSettings.channel = "say";
	elseif ( this:GetID() == 6 ) then
		TBSettings.channel = "channel";
		if (TBSettings.channelName == "") then
			TB_SetCustomChannel();
		end
	end
--Functions	
end

function TB_toggleStatus()
	if (TBSettings.status == 0) then
		TBSettings.status = 1;
		TB_register();
	else
		TBSettings.status = 0;
		TB_unregister();
	end
end

function TB_SetCustomChannel()
	SetCustomChannel:Show();
	EditboxCustomChannel:SetText(TBSettings.channelName);
end

function TB_CloseCustomChannel()
	SetCustomChannel:Hide();
	local TB_channelName_argFound = string.find(EditboxCustomChannel:GetText(), "(%w+)");
	if (TB_channelName_argFound) then
		TBSettings.channelName = EditboxCustomChannel:GetText();
		TBSettings.channel = "channel";
		UIDropDownMenu_SetSelectedID(TB_ChannelDropDown, 6);
	end
end

function TB_SetTauntText()
	SetTauntText:Show();
	EditboxTauntText:SetText(TBSettings.text_t);
end

function TB_CloseTauntText()
	SetTauntText:Hide();
	local TB_tauntText_argFound = string.find(EditboxTauntText:GetText(), "(.+)");
	if (TB_tauntText_argFound) then
		TBSettings.text_t = EditboxTauntText:GetText();
	end
end

function TB_SetMBText()
	SetMBText:Show();
	EditboxMBText:SetText(TBSettings.text_mb);
end

function TB_CloseMBText()
	SetMBText:Hide();
	local TB_MBText_argFound = string.find(EditboxMBText:GetText(), "(.+)");
	if (TB_MBText_argFound) then
		TBSettings.text_mb = EditboxMBText:GetText();
	end
end

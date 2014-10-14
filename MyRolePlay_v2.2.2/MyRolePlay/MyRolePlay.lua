-- The Global Variables to be saved. The Player's Personal Character Information. --

mrpUniversalFrameState = 0; -- 0 = CharacterFrame is not visible, 1 = it is visible.
mrpEnterInformationLocation = nil;
mrpUnitIsAFK = 0;
mrpMessageToSend = 1;

-- 0 = before
-- 1 = after
-- 2 = always
-- 3 = both
MRP_TOOLTIP_TEXT_BEFORE = 0;
MRP_TOOLTIP_TEXT_AFTER = 1;
MRP_TOOLTIP_TEXT_ALWAYS = 2;
MRP_TOOLTIP_TEXT_BOTH = 3;

-- Options Variables --
mrpTooltipsEnabled = 1;

MRP_ALWAYS_DECLINE = 0;
MRP_ALWAYS_ALLOW = 1;
MRP_PROMPT = 2;


mrpSendDataFlagRSPInit = 0;
mrpSendDataInit = 1;

mrpCurrentTarget = "";


function mrp_OnLoad()
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("UPDATE_MOUSEOVER_UNIT");
	this:RegisterEvent("CHAT_MSG_CHANNEL");
	this:RegisterEvent("PLAYER_TARGET_CHANGED");
	this:RegisterEvent("CHAT_MSG_CHANNEL_NOTICE");
	this:RegisterEvent("CHAT_MSG_CHANNEL_JOIN");
	this:RegisterEvent("CHAT_MSG_CHANNEL_LEAVE");
	this:RegisterEvent("PLAYER_LOGOUT");
	this:RegisterEvent("PLAYER_LOGIN");

	--Slash Commands
	SLASH_MYROLEPLAY1 = "/mrp";
	SLASH_MYROLEPLAY2 = "/MyRolePlay";

	SlashCmdList["MYROLEPLAY"] = function(args)
		--[[if (string.find(args, "[Tt][Oo][Oo][Ll][Tt][Ii][Pp]%s%a*")) then
			args = string.gsub(args, "[Tt][Oo][Oo][Ll][Tt][Ii][Pp]%s", "");
			if (string.lower(args) == "disable") then
				mrpTooltipsEnabled = 0;
				mrpDisplayMessage("Tooltips Disabled.");
			elseif (string.lower(args) == "enable") then
				mrpTooltipsEnabled = 1;
				mrpDisplayMessage("Tooltips Enabled.");
			else
				mrpDisplayMessage("Not a MyRolePlay command, type /mrp help for help.");
			end
		elseif (string.find(args, "[Rr][Ee][Ll][Aa][Tt][Ii][Vv][Ee]%s%a*")) then
			args = string.gsub(args, "[Rr][Ee][Ll][Aa][Tt][Ii][Vv][Ee]%s", "");
			if (string.lower(args) == "disable") then
				MyRolePlay.Settings.Relative = 0;
				mrpDisplayMessage("Relative level display in tooltips disabled.");
			elseif (string.lower(args) == "enable") then
				MyRolePlay.Settings.Relative = 1;
				mrpDisplayMessage("Relative level display in tooltips enabled.");
			else
				mrpDisplayMessage("Not a MyRolePlay command, type /mrp help for help.")
			end]]
		if (string.lower(args) == MRP_LOCALE_Slash_Help_Option) then
			mrpDisplayMessage(MRP_LOCALE_Slash_Help);
		else
			mrpDisplayMessage(MRP_LOCALE_Slash_Not_A_Command);
		end


	end;
end

function mrp_OnEvent(event)
	if (event == "VARIABLES_LOADED") then
		mrpInit();
	end
	if (event == "PLAYER_LOGOUT") then
		--LeaveChannelByName("MyRolePlay");
	end
	if (event == "PLAYER_LOGIN") then
		mrpInitWaitTime = GetTime();
	end
	if (event == "UPDATE_MOUSEOVER_UNIT" and mrpTooltipsEnabled == 1) then
		mrpDisplayTooltip("mouseover", "MOUSEOVER");
	end

	if (event == "PLAYER_TARGET_CHANGED" and mrpInitialized == 1) then
		
		mrpCurrentTarget = UnitName("target");

		if (mrpIsPlayerInMRP("target") or mrpIsPlayerInFlagRSP("target")) then
			mrpButtonIconFrame:Show();
		else
			mrpButtonIconFrame:Hide();
		end
	end

	if (event == "CHAT_MSG_CHANNEL") then
		if (mrpInitialized == 1) then
			mrpChannelEvent(event);
		end		
	end

	if (event == "CHAT_MSG_CHANNEL_NOTICE") then
		if (arg9 == "MyRolePlay") then
			if (arg1 == "YOU_JOINED") then
				mrpSendDataInit = 1;
			end
		elseif (arg9 == "xtensionxtooltip2") then
			if (arg1 == "YOU_JOINED") then
				mrpSendDataFlagRSPInit = 1;
			end
		end
		
	end

	if (event == "CHAT_MSG_CHANNEL_JOIN") then
		if (arg9 == "MyRolePlay" and mrpInitialized == 1) then
			--table.setn(mrpPlayerList, table.getn(mrpPlayerList) + 1);
			--/script mrpDisplayMessage(mrpPlayerList[table.getn(mrpPlayerList)].Prefix);
			local index = table.getn(mrpPlayerList) + 1;
			table.setn(mrpPlayerList, index);
			mrpPlayerList[index] = {};
			mrpPlayerList[index].CharacterName = arg2;
			mrpPlayerList[index].Title = "";
			mrpPlayerList[index].Surname = "";
			mrpPlayerList[index].Roleplay = "";
			mrpPlayerList[index].Character = "";
			mrpPlayerList[index].Firstname = "";
			mrpPlayerList[index].Middlename = "";
			mrpPlayerList[index].Nickname = "";
			mrpPlayerList[index].Prefix = "";
			mrpPlayerList[index].Housename = "";
			mrpPlayerList[index].HasInfo = false;
		elseif (arg9 == "xtensionxtooltip2" and mrpInitialized == 1) then
			--table.setn(mrpFlagRSPPlayerList, table.getn(mrpFlagRSPPlayerList) + 1);
			local index1 = table.getn(mrpFlagRSPPlayerList) + 1;
			table.setn(mrpFlagRSPPlayerList, index1);
			mrpFlagRSPPlayerList[index1] = {};
			mrpFlagRSPPlayerList[index1].CharacterName = arg2;
			mrpFlagRSPPlayerList[index1].Title = "";
			mrpFlagRSPPlayerList[index1].Surname = "";
			mrpFlagRSPPlayerList[index1].Roleplay = "";
			mrpFlagRSPPlayerList[index1].Character = "";
			mrpFlagRSPPlayerList[index1].HasInfo = false;
		end
	end

	if (event == "CHAT_MSG_CHANNEL_LEAVE") then
		if (arg9 == "MyRolePlay") then
			local mrpPlayerListTemp = {};

			for i = 1, table.getn(mrpPlayerList) do
				if (mrpPlayerList[i].CharacterName == arg2) then
					for k = 1, table.getn(mrpPlayerList) do
						if (k < i) then
							table.setn(mrpPlayerListTemp, k);
							mrpPlayerListTemp[k] = {};
							mrpPlayerListTemp[k].CharacterName = mrpPlayerList[k].CharacterName;
							mrpPlayerListTemp[k].Title = mrpPlayerList[k].Title;
							mrpPlayerListTemp[k].Surname = mrpPlayerList[k].Surname;
							mrpPlayerListTemp[k].Roleplay = mrpPlayerList[k].Roleplay;
							mrpPlayerListTemp[k].Character = mrpPlayerList[k].Character;
							mrpPlayerListTemp[k].Firstname = mrpPlayerList[k].Firstname;
							mrpPlayerListTemp[k].Middlename = mrpPlayerList[k].Middlename;
							mrpPlayerListTemp[k].Nickname = mrpPlayerList[k].Nickname;
							mrpPlayerListTemp[k].Prefix = mrpPlayerList[k].Prefix;
							mrpPlayerListTemp[k].Housename = mrpPlayerList[k].Housename;
							mrpPlayerListTemp[k].HasInfo = mrpPlayerList[k].HasInfo;
						elseif (k > i) then
							table.setn(mrpPlayerListTemp, k - 1);
							mrpPlayerListTemp[k - 1] = {};
							mrpPlayerListTemp[k - 1].CharacterName = mrpPlayerList[k].CharacterName;
							mrpPlayerListTemp[k - 1].Title = mrpPlayerList[k].Title;
							mrpPlayerListTemp[k - 1].Surname = mrpPlayerList[k].Surname;
							mrpPlayerListTemp[k - 1].Roleplay = mrpPlayerList[k].Roleplay;
							mrpPlayerListTemp[k - 1].Character = mrpPlayerList[k].Character;
							mrpPlayerListTemp[k - 1].Firstname = mrpPlayerList[k].Firstname;
							mrpPlayerListTemp[k - 1].Middlename = mrpPlayerList[k].Middlename;
							mrpPlayerListTemp[k - 1].Nickname = mrpPlayerList[k].Nickname;
							mrpPlayerListTemp[k - 1].Prefix = mrpPlayerList[k].Prefix;
							mrpPlayerListTemp[k - 1].Housename = mrpPlayerList[k].Housename;
							mrpPlayerListTemp[k - 1].HasInfo = mrpPlayerList[k].HasInfo;
						end
					end
				end
			end

			mrpPlayerList = mrpPlayerListTemp;

		elseif (arg9 == "xtensionxtooltip2") then
			local mrpFlagRSPPlayerListTemp = {};

			for i = 1, table.getn(mrpFlagRSPPlayerList) do
				if (mrpFlagRSPPlayerList[i].CharacterName == arg2) then
					for k = 1, table.getn(mrpFlagRSPPlayerList) do
						if (k < i) then
							table.setn(mrpFlagRSPPlayerListTemp, k);
							mrpFlagRSPPlayerListTemp[k] = {};
							mrpFlagRSPPlayerListTemp[k] = mrpFlagRSPPlayerList[k];							
						elseif (k > i) then
							table.setn(mrpFlagRSPPlayerListTemp, k - 1);
							mrpFlagRSPPlayerListTemp[k - 1] = {};
							mrpFlagRSPPlayerListTemp[k - 1] = mrpFlagRSPPlayerList[k];
						end
					end					
				end
			end

			mrpFlagRSPPlayerList = mrpFlagRSPPlayerListTemp;
		end
	end
end

function mrpOnUpdate()
	
end

--[[ Outfitter
	mrpOnMRPEvent takes an 'event' that an addon generates and does something with that even. Much like the WoW OnEvent script works.
	For this addon, please insert the following code right AFTER you change gOutfitter_Settings.Outfits.Complete.Name (when you switch outfits).
	This is all the code you need to put into your addon to be compatible with MyRolePlay. ]]
--mrpOnMRPEvent("CHANGE_OUTFIT", gOutfitter_Settings.Outfits.Complete.Name);

function mrpOnMRPEvent(event, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
	if (event == "CHANGE_OUTFIT") then
		if (arg2 ~= nil and arg2 ~= "") then
			local profileExists = false;

			for i = 1, table.getn(MyRolePlay.Profile) do
				if (MyRolePlay.Profile[i].ProfileName == arg2) then
					mrpChangeProfile(arg2);
					profileExists = true;
					break;
				end				
			end

			if (profileExists == false) then
				mrpSaveProfile(arg2);
			else
				mrpChangeProfile(arg2);
			end
		end
	elseif (event == "WEAR_OUTFIT") then
		if (arg2 ~= nil and arg2 ~= "") then
			local profileExists = false;

			for i = 1, table.getn(MyRolePlay.Profile) do
				if (MyRolePlay.Profile[i].ProfileName == arg2) then
					mrpChangeProfile(arg2);
					profileExists = true;
					break;
				end				
			end

			if (profileExists == false) then
				mrpSaveProfile(arg2);
			else
				mrpChangeProfile(arg2);
			end
		end
	end
end

function mrpInit()
	
	if (not MyRolePlay) then
		MyRolePlay = {}; --initialize MyRolePlay namespace.
		MyRolePlay.Status = {};
		MyRolePlay.Identification = {};
		MyRolePlay.Appearance = {};
		MyRolePlay.Lore = {};
		MyRolePlay.Character = {};
		MyRolePlay.curProfile = MRP_LOCALE_DEFAULT_PROFILE;
		MyRolePlay.Profile = {};
		MyRolePlay.Settings = {};
		MyRolePlay.Settings.Colours = {};
		MyRolePlay.Settings.Colours.Saved = {};
		MyRolePlay.Settings.Tooltip = {};
		MyRolePlay.Settings.Share = {};
		
		MyRolePlay.Identification.Firstname = UnitName("player"); --initialize player's first name.
		MyRolePlay.Identification.Middlename = "";
		MyRolePlay.Identification.Surname = "";
		MyRolePlay.Identification.Prefix = "";
		MyRolePlay.Identification.Title = "";
		MyRolePlay.Identification.Nickname = "";
		MyRolePlay.Identification.Housename = "";
		MyRolePlay.Identification.DateOfBirth = "";

		MyRolePlay.Status.Roleplay = "";
		MyRolePlay.Status.Character = "";

		MyRolePlay.Appearance.EyeColour = "";
		MyRolePlay.Appearance.Height = "";
		MyRolePlay.Appearance.Weight = "";
			MyRolePlay.Appearance.Description1 = "";
			MyRolePlay.Appearance.Description2 = "";
			MyRolePlay.Appearance.Description3 = "";
			MyRolePlay.Appearance.Description4 = "";
			MyRolePlay.Appearance.Description5 = "";
			MyRolePlay.Appearance.Description6 = "";
		MyRolePlay.Appearance.CurrentEmotion = "";
	
			MyRolePlay.Lore.History1 = "";
			MyRolePlay.Lore.History2 = "";
			MyRolePlay.Lore.History3 = "";
			MyRolePlay.Lore.History4 = "";
			MyRolePlay.Lore.History5 = "";
			MyRolePlay.Lore.History6 = "";
		MyRolePlay.Lore.Motto = "";
		MyRolePlay.Lore.Homecity = "";
		MyRolePlay.Lore.Birthcity = "";
---------------------------------------------------------------------------------
		MyRolePlay.Profile[1] = {};
		MyRolePlay.Profile[1].ProfileName = MyRolePlay.curProfile;
		MyRolePlay.Profile[1].Identification = {};
		MyRolePlay.Profile[1].Appearance = {};
		MyRolePlay.Profile[1].Lore = {};
		MyRolePlay.Profile[1].Character = {};
		MyRolePlay.Profile[1].Status = {};

		MyRolePlay.Profile[1].Identification.Firstname = MyRolePlay.Identification.Firstname;
		MyRolePlay.Profile[1].Identification.Middlename = "";
		MyRolePlay.Profile[1].Identification.Surname = "";
		MyRolePlay.Profile[1].Identification.Prefix = "";
		MyRolePlay.Profile[1].Identification.Title = "";
		MyRolePlay.Profile[1].Identification.Nickname = "";
		MyRolePlay.Profile[1].Identification.Housename = "";
		MyRolePlay.Profile[1].Identification.DateOfBirth = "";

		MyRolePlay.Profile[1].Status.Roleplay = "";
		MyRolePlay.Profile[1].Status.Character = "";

		MyRolePlay.Profile[1].Appearance.EyeColour = "";
		MyRolePlay.Profile[1].Appearance.Height = "";
		MyRolePlay.Profile[1].Appearance.Weight = "";
			MyRolePlay.Profile[1].Appearance.Description1 = "";
			MyRolePlay.Profile[1].Appearance.Description2 = "";
			MyRolePlay.Profile[1].Appearance.Description3 = "";
			MyRolePlay.Profile[1].Appearance.Description4 = "";
			MyRolePlay.Profile[1].Appearance.Description5 = "";
			MyRolePlay.Profile[1].Appearance.Description6 = "";
		MyRolePlay.Profile[1].Appearance.CurrentEmotion = "";
	
			MyRolePlay.Profile[1].Lore.History1 = "";
			MyRolePlay.Profile[1].Lore.History2 = "";
			MyRolePlay.Profile[1].Lore.History3 = "";
			MyRolePlay.Profile[1].Lore.History4 = "";
			MyRolePlay.Profile[1].Lore.History5 = "";
			MyRolePlay.Profile[1].Lore.History6 = "";
		MyRolePlay.Profile[1].Lore.Motto = "";
		MyRolePlay.Profile[1].Lore.Homecity = "";
		MyRolePlay.Profile[1].Lore.Birthcity = "";

		MyRolePlay.Settings.Colours.Enabled = 1;
		MyRolePlay.Settings.Colours.PrefixNonPvp = { red = 0.5, green = 0.5, blue = 1.0 };
		MyRolePlay.Settings.Colours.PrefixPvp = { red = 0, green = 0.6, blue = 0 };
		MyRolePlay.Settings.Colours.FirstnameNonPvp = { red = 0.5, green = 0.5, blue = 1.0 };
		MyRolePlay.Settings.Colours.FirstnamePvp = { red = 0, green = 0.6, blue = 0 };
		MyRolePlay.Settings.Colours.MiddlenameNonPvp = { red = 0.5, green = 0.5, blue = 1.0 };
		MyRolePlay.Settings.Colours.MiddlenamePvp = { red = 0, green = 0.6, blue = 0 };
		MyRolePlay.Settings.Colours.SurnameNonPvp = { red = 0.5, green = 0.5, blue = 1.0 };
		MyRolePlay.Settings.Colours.SurnamePvp = { red = 0, green = 0.6, blue = 0 };
		MyRolePlay.Settings.Colours.EnemyNonPvp = { red = 0.5, green = 0.5, blue = 1.0 };
		MyRolePlay.Settings.Colours.EnemyPvpHostile = { red = 1.0, green = 0, blue = 0 };
		MyRolePlay.Settings.Colours.EnemyPvpNotHostile = { red = 1.0, green = 1.0, blue = 0.0 };
		MyRolePlay.Settings.Colours.FactionHorde = { red = 1.0, green = 0.0, blue = 0.0 };
		MyRolePlay.Settings.Colours.FactionAlliance = { red = 0.3, green = 0.3, blue = 1.0 };
		MyRolePlay.Settings.Colours.Title = { red = 1.0, green = 1.0, blue = 1.0 };
		MyRolePlay.Settings.Colours.Guild = { red = 1.0, green = 1.0, blue = 1.0 };
		MyRolePlay.Settings.Colours.Level = { red = 1.0, green = 1.0, blue = 0 };
		MyRolePlay.Settings.Colours.Class = { red = 1.0, green = 1.0, blue = 0 };
		MyRolePlay.Settings.Colours.Race = { red = 1.0, green = 1.0, blue = 0 };
		MyRolePlay.Settings.Colours.HouseName = { red = 1.0, green = 1.0, blue = 1.0 };
		MyRolePlay.Settings.Colours.Roleplay = { red = 1.0, green = 1.0, blue = 0.6 };
		MyRolePlay.Settings.Colours.CharacterText = { red = 1.0, green = 1.0, blue = 1.0 };
		MyRolePlay.Settings.Colours.CharacterStat = { red = 1.0, green = 1.0, blue = 0.6 };
		MyRolePlay.Settings.Colours.Nickname = { red = 1.0, green = 1.0, blue = 1.0 };
		MyRolePlay.Settings.Colours.FriendlyPvp = { red = 0, green = 0.6, blue = 0 };
		MyRolePlay.Settings.Colours.EnemyPvp = { red = 1.0, green = 0, blue = 0 };

		MyRolePlay.Settings.Colours.ClassSpecific = {};
		MyRolePlay.Settings.Colours.ClassSpecific.Rogue = { red = 1.0, green = 1.0, blue = 0 };
		MyRolePlay.Settings.Colours.ClassSpecific.Warrior = { red = 1.0, green = 1.0, blue = 0 };
		MyRolePlay.Settings.Colours.ClassSpecific.Priest = { red = 1.0, green = 1.0, blue = 0 };
		MyRolePlay.Settings.Colours.ClassSpecific.Mage = { red = 1.0, green = 1.0, blue = 0 };
		MyRolePlay.Settings.Colours.ClassSpecific.Shaman = { red = 1.0, green = 1.0, blue = 0 };
		MyRolePlay.Settings.Colours.ClassSpecific.Paladin = { red = 1.0, green = 1.0, blue = 0 };
		MyRolePlay.Settings.Colours.ClassSpecific.Druid = { red = 1.0, green = 1.0, blue = 0 };
		MyRolePlay.Settings.Colours.ClassSpecific.Warlock = { red = 1.0, green = 1.0, blue = 0 };
		MyRolePlay.Settings.Colours.ClassSpecific.Hunter = { red = 1.0, green = 1.0, blue = 0 };

		MyRolePlay.Settings.Colours.Saved.PrefixNonPvp = { red = 0.5, green = 0.5, blue = 1.0 };
		MyRolePlay.Settings.Colours.Saved.PrefixPvp = { red = 0, green = 0.6, blue = 0 };
		MyRolePlay.Settings.Colours.Saved.FirstnameNonPvp = { red = 0.5, green = 0.5, blue = 1.0 };
		MyRolePlay.Settings.Colours.Saved.FirstnamePvp = { red = 0, green = 0.6, blue = 0 };
		MyRolePlay.Settings.Colours.Saved.MiddlenameNonPvp = { red = 0.5, green = 0.5, blue = 1.0 };
		MyRolePlay.Settings.Colours.Saved.MiddlenamePvp = { red = 0, green = 0.6, blue = 0 };
		MyRolePlay.Settings.Colours.Saved.SurnameNonPvp = { red = 0.5, green = 0.5, blue = 1.0 };
		MyRolePlay.Settings.Colours.Saved.SurnamePvp = { red = 0, green = 0.6, blue = 0 };
		MyRolePlay.Settings.Colours.Saved.EnemyNonPvp = { red = 0.5, green = 0.5, blue = 1.0 };
		MyRolePlay.Settings.Colours.Saved.EnemyPvpHostile = { red = 1.0, green = 0, blue = 0 };
		MyRolePlay.Settings.Colours.Saved.EnemyPvpNotHostile = { red = 1.0, green = 1.0, blue = 0.0 };
		MyRolePlay.Settings.Colours.Saved.FactionHorde = { red = 1.0, green = 0.0, blue = 0.0 };
		MyRolePlay.Settings.Colours.Saved.FactionAlliance = { red = 0.3, green = 0.3, blue = 1.0 };
		MyRolePlay.Settings.Colours.Saved.Title = { red = 1.0, green = 1.0, blue = 1.0 };
		MyRolePlay.Settings.Colours.Saved.Guild = { red = 1.0, green = 1.0, blue = 1.0 };
		MyRolePlay.Settings.Colours.Saved.Level = { red = 1.0, green = 1.0, blue = 0 };
		MyRolePlay.Settings.Colours.Saved.Class = { red = 1.0, green = 1.0, blue = 0 };
		MyRolePlay.Settings.Colours.Saved.Race = { red = 1.0, green = 1.0, blue = 0 };
		MyRolePlay.Settings.Colours.Saved.HouseName = { red = 1.0, green = 1.0, blue = 1.0 };
		MyRolePlay.Settings.Colours.Saved.Roleplay = { red = 1.0, green = 1.0, blue = 0.6 };
		MyRolePlay.Settings.Colours.Saved.CharacterText = { red = 1.0, green = 1.0, blue = 1.0 };
		MyRolePlay.Settings.Colours.Saved.CharacterStat = { red = 1.0, green = 1.0, blue = 0.6 };
		MyRolePlay.Settings.Colours.Saved.Nickname = { red = 1.0, green = 1.0, blue = 1.0 };
		MyRolePlay.Settings.Colours.Saved.FriendlyPvp = { red = 0, green = 0.6, blue = 0 };
		MyRolePlay.Settings.Colours.Saved.EnemyPvp = { red = 1.0, green = 0, blue = 0 };


		MyRolePlay.Settings.Relative = 0;

		MyRolePlay.Settings.Tooltip.Enabled = 1;
		MyRolePlay.Settings.Tooltip.PrefixEnabled = 1;
		MyRolePlay.Settings.Tooltip.FirstnameEnabled = 1;
		MyRolePlay.Settings.Tooltip.MiddlenameEnabled = 1;
		MyRolePlay.Settings.Tooltip.SurnameEnabled = 1;
		MyRolePlay.Settings.Tooltip.TitleEnabled = 1;
		MyRolePlay.Settings.Tooltip.NicknameEnabled = 1;
		MyRolePlay.Settings.Tooltip.HousenameEnabled = 1;

		MyRolePlay.Settings.Tooltip.EyeColourEnabled = 0;
		MyRolePlay.Settings.Tooltip.HeightEnabled = 0;
		MyRolePlay.Settings.Tooltip.WeightEnabled = 0;
		MyRolePlay.Settings.Tooltip.CurrentEmotionEnabled = 0;

		MyRolePlay.Settings.Tooltip.HomeCityEnabled = 0;
		MyRolePlay.Settings.Tooltip.BirthCityEnabled = 0;
		MyRolePlay.Settings.Tooltip.MottoEnabled = 0;

		MyRolePlay.Settings.Tooltip.RPFlagEnabled = 1;
		MyRolePlay.Settings.Tooltip.CSFlagEnabled = 1;

		
		MyRolePlay.Settings.Tooltip.Order = {};
		MyRolePlay.Settings.Tooltip.Order.MRP = {};
		MyRolePlay.Settings.Tooltip.Order.Regular = {};
		MyRolePlay.Settings.Tooltip.Order.MRP_TEXT = {};

		MyRolePlay.Settings.Tooltip.Order.MRP[1] = {};
		MyRolePlay.Settings.Tooltip.Order.MRP[1][1] = MRP_PREFIX;
		MyRolePlay.Settings.Tooltip.Order.MRP[1][2] = MRP_FIRSTNAME;
		MyRolePlay.Settings.Tooltip.Order.MRP[1][3] = MRP_MIDDLENAME;
		MyRolePlay.Settings.Tooltip.Order.MRP[1][4] = MRP_SURNAME;

		MyRolePlay.Settings.Tooltip.Order.MRP[2] = {};
		MyRolePlay.Settings.Tooltip.Order.MRP[2][1] = "";
		MyRolePlay.Settings.Tooltip.Order.MRP[2][2] = MRP_HOUSENAME;

		MyRolePlay.Settings.Tooltip.Order.MRP[3] = {};
		MyRolePlay.Settings.Tooltip.Order.MRP[3][1] = MRP_TITLE;

		MyRolePlay.Settings.Tooltip.Order.MRP[4] = {};
		--MyRolePlay.Settings.Tooltip.Order.MRP[4][1] = MRP_CONDITIONAL_NEWLINE[1];

		MyRolePlay.Settings.Tooltip.Order.MRP[5] = {};
		MyRolePlay.Settings.Tooltip.Order.MRP[5][1] = "";
		MyRolePlay.Settings.Tooltip.Order.MRP[5][2] = MRP_NICKNAME;

		MyRolePlay.Settings.Tooltip.Order.MRP[6] = {};
		MyRolePlay.Settings.Tooltip.Order.MRP[6][1] = MRP_GUILDRANK;
		MyRolePlay.Settings.Tooltip.Order.MRP[6][2] = "";
		MyRolePlay.Settings.Tooltip.Order.MRP[6][3] = MRP_GUILD;
		MyRolePlay.Settings.Tooltip.Order.MRP[6][4] = "";

		MyRolePlay.Settings.Tooltip.Order.MRP[7] = {};
		MyRolePlay.Settings.Tooltip.Order.MRP[7][1] = MRP_PVPRANK;

		MyRolePlay.Settings.Tooltip.Order.MRP[8] = {};
		--MyRolePlay.Settings.Tooltip.Order.MRP[8][1] = MRP_CONDITIONAL_NEWLINE[2];

		MyRolePlay.Settings.Tooltip.Order.MRP[9] = {};
		MyRolePlay.Settings.Tooltip.Order.MRP[9][1] = MRP_RPSTYLE;

		MyRolePlay.Settings.Tooltip.Order.MRP[10] = {};
		MyRolePlay.Settings.Tooltip.Order.MRP[10][1] = "";
		MyRolePlay.Settings.Tooltip.Order.MRP[10][2] = MRP_CSSTATUS;

		MyRolePlay.Settings.Tooltip.Order.MRP[11] = {};
		--MyRolePlay.Settings.Tooltip.Order.MRP[11][1] = MRP_CONDITIONAL_NEWLINE[3];

		MyRolePlay.Settings.Tooltip.Order.MRP[12] = {};
		--MyRolePlay.Settings.Tooltip.Order.MRP[12][1] = "";
		MyRolePlay.Settings.Tooltip.Order.MRP[12][1] = MRP_LEVEL;
		MyRolePlay.Settings.Tooltip.Order.MRP[12][2] = MRP_RACE;
		MyRolePlay.Settings.Tooltip.Order.MRP[12][3] = MRP_CLASS;

		MyRolePlay.Settings.Tooltip.Order.MRP[13] = {};
		MyRolePlay.Settings.Tooltip.Order.MRP[13][1] = MRP_PVPSTATUS;

		MyRolePlay.Settings.Tooltip.Order.MRP[14] = {};
		MyRolePlay.Settings.Tooltip.Order.MRP[14][1] = MRP_EMPTY;

		MyRolePlay.Settings.Tooltip.Order.MRP[15] = {};
		MyRolePlay.Settings.Tooltip.Order.MRP[15][1] = MRP_EMPTY;

		MyRolePlay.Settings.Tooltip.Order.MRP[16] = {};
		MyRolePlay.Settings.Tooltip.Order.MRP[16][1] = MRP_EMPTY;

		MyRolePlay.Settings.Tooltip.Order.MRP[17] = {};
		MyRolePlay.Settings.Tooltip.Order.MRP[17][1] = MRP_EMPTY;

		MyRolePlay.Settings.Tooltip.Order.MRP[18] = {};
		MyRolePlay.Settings.Tooltip.Order.MRP[18][1] = MRP_EMPTY;

		MyRolePlay.Settings.Tooltip.Order.MRP[19] = {};
		MyRolePlay.Settings.Tooltip.Order.MRP[19][1] = MRP_EMPTY;

		MyRolePlay.Settings.Tooltip.Order.MRP[20] = {};
		MyRolePlay.Settings.Tooltip.Order.MRP[20][1] = MRP_EMPTY;

		MyRolePlay.Settings.Tooltip.Order.MRP[21] = {};
		MyRolePlay.Settings.Tooltip.Order.MRP[21][1] = MRP_EMPTY;

		MyRolePlay.Settings.Tooltip.Order.MRP[22] = {};
		MyRolePlay.Settings.Tooltip.Order.MRP[22][1] = MRP_EMPTY;

		MyRolePlay.Settings.Tooltip.Order.MRP[23] = {};
		MyRolePlay.Settings.Tooltip.Order.MRP[23][1] = MRP_EMPTY;

		MyRolePlay.Settings.Tooltip.Order.MRP[24] = {};
		MyRolePlay.Settings.Tooltip.Order.MRP[24][1] = MRP_EMPTY;

		MyRolePlay.Settings.Tooltip.Order.MRP[25] = {};
		MyRolePlay.Settings.Tooltip.Order.MRP[25][1] = MRP_EMPTY;

		MyRolePlay.Settings.Tooltip.Order.MRP[26] = {};
		MyRolePlay.Settings.Tooltip.Order.MRP[26][1] = MRP_EMPTY;

		MyRolePlay.Settings.Tooltip.Order.MRP[27] = {};
		MyRolePlay.Settings.Tooltip.Order.MRP[27][1] = MRP_EMPTY;

		MyRolePlay.Settings.Tooltip.Order.MRP[28] = {};
		MyRolePlay.Settings.Tooltip.Order.MRP[28][1] = MRP_EMPTY;

		MyRolePlay.Settings.Tooltip.Order.MRP[29] = {};
		MyRolePlay.Settings.Tooltip.Order.MRP[29][1] = MRP_EMPTY;

		MyRolePlay.Settings.Tooltip.Order.MRP[30] = {};
		MyRolePlay.Settings.Tooltip.Order.MRP[30][1] = MRP_EMPTY;


		MyRolePlay.Settings.Tooltip.Order.Regular[1] = {};
		MyRolePlay.Settings.Tooltip.Order.Regular[1][1] = MRP_UNITNAME;

		MyRolePlay.Settings.Tooltip.Order.Regular[2] = {};
		MyRolePlay.Settings.Tooltip.Order.Regular[2][1] = MRP_LEVEL;
		MyRolePlay.Settings.Tooltip.Order.Regular[2][2] = MRP_RACE;
		MyRolePlay.Settings.Tooltip.Order.Regular[2][3] = MRP_CLASS;

		MyRolePlay.Settings.Tooltip.Order.Regular[3] = {};
		MyRolePlay.Settings.Tooltip.Order.Regular[3][1] = MRP_GUILDRANK;

		MyRolePlay.Settings.Tooltip.Order.Regular[4] = {};
		MyRolePlay.Settings.Tooltip.Order.Regular[4][1] = MRP_PVPRANK;		

		MyRolePlay.Settings.Tooltip.Order.Regular[5] = {};
		MyRolePlay.Settings.Tooltip.Order.Regular[5][1] = MRP_PVPSTATUS;

	
		MyRolePlay.Settings.Tooltip.Order.MRP_TEXT = {};

		MyRolePlay.Settings.Tooltip.Order.MRP_TEXT[1] = {};
		MyRolePlay.Settings.Tooltip.Order.MRP_TEXT[1].Text = MRP_LOCALE_TOOLTIP_DEFAULT_HOUSE;
		MyRolePlay.Settings.Tooltip.Order.MRP_TEXT[1].BoA = MRP_TOOLTIP_TEXT_AFTER;
		MyRolePlay.Settings.Tooltip.Order.MRP_TEXT[1].Colours = MyRolePlay.Settings.Colours.HouseName;

		MyRolePlay.Settings.Tooltip.Order.MRP_TEXT[2] = {};
		MyRolePlay.Settings.Tooltip.Order.MRP_TEXT[2].Text = MRP_LOCALE_TOOLTIP_DEFAULT_NICKNAME;
		MyRolePlay.Settings.Tooltip.Order.MRP_TEXT[2].BoA = MRP_TOOLTIP_TEXT_AFTER;
		MyRolePlay.Settings.Tooltip.Order.MRP_TEXT[2].Colours = MyRolePlay.Settings.Colours.Nickname;
		
		MyRolePlay.Settings.Tooltip.Order.MRP_TEXT[3] = {};
		MyRolePlay.Settings.Tooltip.Order.MRP_TEXT[3].Text = MRP_LOCALE_TOOLTIP_DEFAULT_GUILD;
		MyRolePlay.Settings.Tooltip.Order.MRP_TEXT[3].BoA = MRP_TOOLTIP_TEXT_AFTER;
		MyRolePlay.Settings.Tooltip.Order.MRP_TEXT[3].Colours = MyRolePlay.Settings.Colours.Guild;
		
		MyRolePlay.Settings.Tooltip.Order.MRP_TEXT[4] = {};
		MyRolePlay.Settings.Tooltip.Order.MRP_TEXT[4].Text = MRP_LOCALE_TOOLTIP_DEFAULT_CHARSTATUS;
		MyRolePlay.Settings.Tooltip.Order.MRP_TEXT[4].BoA = MRP_TOOLTIP_TEXT_AFTER;
		MyRolePlay.Settings.Tooltip.Order.MRP_TEXT[4].Colours = MyRolePlay.Settings.Colours.CharacterText;

		MyRolePlay.Settings.Tooltip.Order.MRP_TEXT[5] = {};
		MyRolePlay.Settings.Tooltip.Order.MRP_TEXT[5].Text = MRP_LOCALE_TOOLTIP_DEFAULT_GUILDQUOTE;
		MyRolePlay.Settings.Tooltip.Order.MRP_TEXT[5].BoA = MRP_TOOLTIP_TEXT_BEFORE;
		MyRolePlay.Settings.Tooltip.Order.MRP_TEXT[5].Colours = MyRolePlay.Settings.Colours.Guild;
		
		--[[MyRolePlay.Settings.Tooltip.Order.MRP_TEXT[5] = {};
		MyRolePlay.Settings.Tooltip.Order.MRP_TEXT[5].Text = MRP_LOCALE_TOOLTIP_DEFAULT_LEVELKNOWN;
		MyRolePlay.Settings.Tooltip.Order.MRP_TEXT[5].BoA = MRP_TOOLTIP_TEXT_ALWAYS;
		MyRolePlay.Settings.Tooltip.Order.MRP_TEXT[5].Colours = MyRolePlay.Settings.Colours.Level;]]

		MyRolePlay.Settings.Tooltip.Order.MRP[2][1] = MyRolePlay.Settings.Tooltip.Order.MRP_TEXT[1];
		MyRolePlay.Settings.Tooltip.Order.MRP[5][1] = MyRolePlay.Settings.Tooltip.Order.MRP_TEXT[2];
		MyRolePlay.Settings.Tooltip.Order.MRP[6][2] = MyRolePlay.Settings.Tooltip.Order.MRP_TEXT[3];
		MyRolePlay.Settings.Tooltip.Order.MRP[6][4] = MyRolePlay.Settings.Tooltip.Order.MRP_TEXT[5];
		MyRolePlay.Settings.Tooltip.Order.MRP[10][1] = MyRolePlay.Settings.Tooltip.Order.MRP_TEXT[4];
		--MyRolePlay.Settings.Tooltip.Order.MRP[12][1] = MyRolePlay.Settings.Tooltip.Order.MRP_TEXT[5];

		MyRolePlay.Settings.Tooltip.Order.CharSheetTooltip = {};

		MyRolePlay.Settings.Tooltip.Order.CharSheetTooltip[1] = {};
		MyRolePlay.Settings.Tooltip.Order.CharSheetTooltip[1][1] = MRP_FIRSTNAME;
		MyRolePlay.Settings.Tooltip.Order.CharSheetTooltip[1][2] = MRP_MIDDLENAME;
		MyRolePlay.Settings.Tooltip.Order.CharSheetTooltip[1][3] = MRP_SURNAME;

		MyRolePlay.Settings.Tooltip.Order.CharSheetTooltip[2] = {};
		MyRolePlay.Settings.Tooltip.Order.CharSheetTooltip[2][1] = MRP_LEVEL;
		MyRolePlay.Settings.Tooltip.Order.CharSheetTooltip[2][2] = MRP_RACE;
		MyRolePlay.Settings.Tooltip.Order.CharSheetTooltip[2][3] = MRP_CLASS;

		MyRolePlay.Settings.Tooltip.Order.CharSheetTooltip[3] = {};
		MyRolePlay.Settings.Tooltip.Order.CharSheetTooltip[3][1] = MRP_GUILDRANK;

		MyRolePlay.Settings.Tooltip.Order.MRP[4][1] = MRP_CONDITIONAL_NEWLINE[1];
		MyRolePlay.Settings.Tooltip.Order.MRP[8][1] = MRP_CONDITIONAL_NEWLINE[2];
		MyRolePlay.Settings.Tooltip.Order.MRP[11][1] = MRP_CONDITIONAL_NEWLINE[3];

		
		MyRolePlay.Settings.Share.Enabled = true;
		MyRolePlay.Settings.Share.PrefixEnabled = MRP_ALWAYS_ALLOW;
		MyRolePlay.Settings.Share.FirstnameEnabled = MRP_ALWAYS_ALLOW;
		MyRolePlay.Settings.Share.MiddlenameEnabled = MRP_ALWAYS_ALLOW;
		MyRolePlay.Settings.Share.SurnameEnabled = MRP_ALWAYS_ALLOW;
		MyRolePlay.Settings.Share.TitleEnabled = MRP_ALWAYS_ALLOW;
		MyRolePlay.Settings.Share.NicknameEnabled = MRP_ALWAYS_ALLOW;
		MyRolePlay.Settings.Share.HousenameEnabled = MRP_ALWAYS_ALLOW;
		MyRolePlay.Settings.Share.GuildEnabled = MRP_ALWAYS_ALLOW;

		MyRolePlay.Settings.Share.EyeColourEnabled = MRP_ALWAYS_ALLOW;
		MyRolePlay.Settings.Share.HeightEnabled = MRP_ALWAYS_ALLOW;
		MyRolePlay.Settings.Share.WeightEnabled = MRP_ALWAYS_ALLOW;
		MyRolePlay.Settings.Share.CurrentEmotionEnabled = MRP_ALWAYS_ALLOW;
		MyRolePlay.Settings.Share.CharacterDescription = MRP_ALWAYS_ALLOW;

		MyRolePlay.Settings.Share.HomeCityEnabled = MRP_PROMPT;
		MyRolePlay.Settings.Share.BirthCityEnabled = MRP_PROMPT;
		MyRolePlay.Settings.Share.MottoEnabled = MRP_PROMPT;
		MyRolePlay.Settings.Share.CharacterHistory = MRP_PROMPT;

		MyRolePlay.Settings.Share.RPFlagEnabled = MRP_ALWAYS_ALLOW;
		MyRolePlay.Settings.Share.CSFlagEnabled = MRP_ALWAYS_ALLOW;
		MyRolePlay.Settings.CharacterSheet = 0;
		MyRolePlay.Settings.FlagRSPCompatability = 1;
		MyRolePlay.Settings.ColourClassSpecific = 0;
		MyRolePlay.Settings.PopupDescriptions = 1;
	end

	mrpTarget = {};
	mrpTarget.Status = {};
	mrpTarget.Identification = {};
	mrpTarget.Appearance = {};
	mrpTarget.Lore = {};
	mrpTarget.Character = {};

	mrpTarget.Identification.Charactername = "";
	mrpTarget.Identification.Firstname = "";
	mrpTarget.Identification.Middlename = "";
	mrpTarget.Identification.Surname = "";
	mrpTarget.Identification.Prefix = "";
	mrpTarget.Identification.Title = "";
	mrpTarget.Identification.Nickname = "";
	mrpTarget.Identification.Housename = "";
	mrpTarget.Identification.DateOfBirth = "";
	mrpTarget.Identification.FactionRank = "";

	mrpTarget.Status.Roleplay = "";
	mrpTarget.Status.Character = "";

	mrpTarget.Appearance.EyeColour = "";
	mrpTarget.Appearance.Height = "";
	mrpTarget.Appearance.Weight = "";
	mrpTarget.Appearance.Description1 = "";
	mrpTarget.Appearance.Description2 = "";
	mrpTarget.Appearance.Description3 = "";
	mrpTarget.Appearance.Description4 = "";
	mrpTarget.Appearance.Description5 = "";
	mrpTarget.Appearance.Description6 = "";
	mrpTarget.Appearance.CurrentEmotion = "";

	mrpTarget.Lore.History1 = "";
	mrpTarget.Lore.History2 = "";
	mrpTarget.Lore.History3 = "";
	mrpTarget.Lore.History4 = "";
	mrpTarget.Lore.History5 = "";
	mrpTarget.Lore.History6 = "";
	mrpTarget.Lore.Motto = "";
	mrpTarget.Lore.Homecity = "";
	mrpTarget.Lore.Birthcity = "";

	mrpWaitTime = GetTime();
	
	--This is a really nasty hack. I am resetting the OnShow and OnHide scripts for the PaperDollFrame from Blizzard (the character sheet) and adding my own stuff to it.
	getglobal("PaperDollFrame"):SetScript("OnShow", function() PaperDollFrame_OnShow() if (mrpUniversalFrameState == 1) then mrpUniversalFrame:Show() end mrpUniversalFrameToggle:Show() end);
	getglobal("PaperDollFrame"):SetScript("OnHide", function() PaperDollFrame_OnHide() mrpUniversalFrame:Hide() mrpUniversalFrameToggle:Hide() end);

	getglobal("PlayerFrame"):SetScript("OnEnter", function() 
		if ( SpellIsTargeting() ) then
			if ( SpellCanTargetUnit(this.unit) ) then
				SetCursor("CAST_CURSOR");
			else
				SetCursor("CAST_ERROR_CURSOR");
			end
		end
		
		--GameTooltip_SetDefaultAnchor(GameTooltip, this);
		GameTooltipTextLeft1:Hide();
		GameTooltipTextRight1:Hide();
		GameTooltip_SetDefaultAnchor(GameTooltip, UIParent);
		mrpDisplayTooltip("player", "PLAYER");
	end);

	if (DUF_PlayerFrame) then
		getglobal("DUF_PlayerFrame"):SetScript("OnEnter", function()
			DUF_UnitFrame_OnEnter();
			GameTooltipTextLeft1:Hide();
			GameTooltipTextRight1:Hide();
			GameTooltip_SetDefaultAnchor(GameTooltip, UIParent);
			mrpDisplayTooltip("player", "PLAYER");
		end);
	end
	

	if (MyRolePlay.Identification.Firstname ~= nil) then
		mrp_SetText("Identification.Firstname");
	end
	if (MyRolePlay.Identification.Middlename ~= nil) then
		mrp_SetText("Identification.Middlename");
	end
	if (MyRolePlay.Identification.Surname ~= nil) then
		mrp_SetText("Identification.Surname");
	end
	if (MyRolePlay.Identification.Prefix ~= nil) then
		mrp_SetText("Identification.Prefix");
	end
	if (MyRolePlay.Identification.Title ~= nil) then
		mrp_SetText("Identification.Title");
	end
	if (MyRolePlay.Identification.Nickname ~= nil) then
		mrp_SetText("Identification.Nickname");
	end
	if (MyRolePlay.Identification.Housename ~= nil) then
		mrp_SetText("Identification.Housename");
	end
	if (MyRolePlay.Identification.DateOfBirth ~= nil) then
		mrp_SetText("Identification.DateOfBirth");
	end
	if (MyRolePlay.Identification.FactionRank ~= nil) then
		mrp_SetText("Identification.FactionRank");
	end



	if (MyRolePlay.Appearance.EyeColour ~= nil) then
		mrp_SetText("Appearance.EyeColour");
	end
	if (MyRolePlay.Appearance.Height ~= nil) then
		mrp_SetText("Appearance.Height");
	end
	if (MyRolePlay.Appearance.Weight ~= nil) then
		mrp_SetText("Appearance.Weight");
	end
	if (MyRolePlay.Appearance.Description1 ~= nil) then
		mrp_SetText("Appearance.Description");
	end
	if (MyRolePlay.Appearance.CurrentEmotion ~= nil) then
		mrp_SetText("Appearance.CurrentEmotion");
	end
	

	
	if (MyRolePlay.Lore.History1 ~= nil) then
		mrp_SetText("Lore.History");
	end
	if (MyRolePlay.Lore.Motto ~= nil) then
		mrp_SetText("Lore.Motto");
	end
	if (MyRolePlay.Lore.Homecity ~= nil) then
		mrp_SetText("Lore.Homecity");
	end
	if (MyRolePlay.Lore.Birthcity ~= nil) then
		mrp_SetText("Lore.Birthcity");
	end



	if (MyRolePlay.Character.Subclass ~= nil) then
		mrp_SetText("Character.Subclass");
	end


	mrpCharacterButton:SetChecked(1);
	mrpCharacterButton:Disable();
	mrpOptionsPage1Button:SetChecked(1);
	SetOptionsCheckButtons();
	mrpOptionsPage1Button:Disable();

	if (MyRolePlay.Settings.PopupDescriptions == nil) then
		MyRolePlay.Settings.PopupDescriptions = 1;
	end
	
	mrpMoveIcon();
	mrpLocalizeXML();

	if (Outfitter_RegisterOutfitEvent) then
		Outfitter_RegisterOutfitEvent("WEAR_OUTFIT", mrpOnMRPEvent);
	end
end


function mrpLocalizeXML()
	mrpUniversalFrameToggle:SetText(MRP_LOCALE_UNIVERSAL_FRAME_TOGGLE);
	IdentityText:SetText(MRP_LOCALE_MRPXML_IDENTITY_TEXT);
	AppearanceText:SetText(MRP_LOCALE_MRPXML_APPEARANCE_TEXT);
	LoreText:SetText(MRP_LOCALE_MRPXML_LORE_TEXT);
	FirstnameTextHeader:SetText(MRP_LOCALE_MRPXML_FIRSTNAME_HEADER);
	MiddlenameTextHeader:SetText(MRP_LOCALE_MRPXML_MIDDLENAME_HEADER);
	SurnameTextHeader:SetText(MRP_LOCALE_MRPXML_SURNAME_HEADER);
	PrefixTextHeader:SetText(MRP_LOCALE_MRPXML_PREFIX_HEADER);
	TitleTextHeader:SetText(MRP_LOCALE_MRPXML_TITLE_HEADER);
	FullNicknameHeader:SetText(MRP_LOCALE_MRPXML_NICKNAME_HEADER);
	HousenameTextHeader:SetText(MRP_LOCALE_MRPXML_HOUSENAME_HEADER);
	EyeColourTextHeader:SetText(MRP_LOCALE_MRPXML_EYECOLOUR_HEADER);
	HeightTextHeader:SetText(MRP_LOCALE_MRPXML_HEIGHT_HEADER);
	WeightTextHeader:SetText(MRP_LOCALE_MRPXML_WEIGHT_HEADER);
	CurrentEmotionTextHeader:SetText(MRP_LOCALE_MRPXML_EMOTION_HEADER);
	DescriptionTextHeader:SetText(MPR_LOCALE_MRPXML_DESCRIPTION_HEADER);
	mrpCharFrameNextPageText:SetText(MRP_LOCALE_MRPXML_NEXTPAGE_TEXT);
	mrpCharFramePrevPageText:SetText(MRP_LOCALE_MRPXML_PREVPAGE_TEXT);
	mrpProfileSaveButton:SetText(MRP_LOCALE_MRPXML_PROFILE_SAVE_TEXT);
	mrpProfileNewButton:SetText(MRP_LOCALE_MRPXML_PROFILE_NEW_TEXT);
	mrpProfileDeleteButton:SetText(MRP_LOCALE_MRPXML_PROFILE_DELETE_TEXT);
	mrpProfileDropDownPreText:SetText(MRP_LOCALE_MRPXML_PROFILE_DROPDOWN_TEXT);
	HomecityTextHeader:SetText(MRP_LOCALE_MRPXML_HOME_HEADER);
	BirthcityTextHeader:SetText(MRP_LOCALE_MRPXML_BIRTH_HEADER);
	MottoTextHeader:SetText(MRP_LOCALE_MRPXML_MOTTO_HEADER);
	HistoryTextHeader:SetText(MRP_LOCALE_MRPXML_HISTORY_HEADER);
	mrpEnterInformationSaveButton:SetText(MRP_LOCALE_MRPXML_INFOSAVE);
	mrpEnterInformationCancelButton:SetText(MRP_LOCALE_MRPXML_INFOCANCEL);
	mrpTooltipOrderBuilderViewElementsButton:SetText(MRP_LOCALE_TOOLTIPXML_VIEW_ELEMENTS);
	mrpTooltipOrderBuilderCreateRegularTooltipButton:SetText(MRP_LOCALE_TOOLTIPXML_CREATEREGULARTOOLTIP);
	mrpTooltipOrderBuilderSaveButton:SetText(MRP_LOCALE_TOOLTIPXML_SAVEBUTTON);
	mrpTooltipOrderBuilderSaveConditionalNewlineButton:SetText(MRP_LOCALE_TOOLTIPXML_SAVENEWLINEBUTTON);
	mrpTooltipOrderBuilderCancelButton:SetText(MRP_LOCALE_TOOLTIPXML_CANCELBUTTON);
	mrpTooltipOrderBuilderHelpText:SetText(MRP_LOCALE_MRPXML_TOOLTIPEDITOR_TEXT);
end

function mrp_SaveVariable(varToSave, location)

	local i = 1;
	local index = nil;

	for i = 1, table.getn(MyRolePlay.Profile), 1 do
		if (MyRolePlay.Profile[i].ProfileName == MyRolePlay.curProfile) then
			index = i;
			break;
		end
	end

	if (location == "Identification.Firstname") then
		MyRolePlay.Identification.Firstname = varToSave;
		MyRolePlay.Profile[index].Identification.Firstname = varToSave;
		mrpSendInfoTime = 1;
		mrp_SetText(location);
	end
	if (location == "Identification.Middlename") then
		MyRolePlay.Identification.Middlename = varToSave;
		MyRolePlay.Profile[index].Identification.Middlename = varToSave;
		mrpSendInfoTime = 1;
		mrp_SetText(location);
	end
	if (location == "Identification.Surname") then
		MyRolePlay.Identification.Surname = varToSave;
		MyRolePlay.Profile[index].Identification.Surname = varToSave;
		mrpSendInfoTime = 1;
		mrp_SetText(location);

		local mrpIndexOfChannel = GetChannelName("xtensionxtooltip2");	

		if (mrpIndexOfChannel ~= nil) then
			SendChatMessage("<N>" .. MyRolePlay.Identification.Surname .. "<T>" .. MyRolePlay.Identification.Title, "CHANNEL", GetDefaultLanguage("player"), mrpIndexOfChannel);
		end
		mrpFlagRSPTime = GetTime();
	end
	if (location == "Identification.Prefix") then
		MyRolePlay.Identification.Prefix = varToSave;
		MyRolePlay.Profile[index].Identification.Prefix = varToSave;
		mrpSendInfoTime = 1;
		mrp_SetText(location);
	end
	if (location == "Identification.Title") then
		MyRolePlay.Identification.Title = varToSave;
		MyRolePlay.Profile[index].Identification.Title = varToSave;
		mrpSendInfoTime = 1;
		mrp_SetText(location);

		local mrpIndexOfChannel = GetChannelName("xtensionxtooltip2");	

		if (mrpIndexOfChannel ~= nil) then
			SendChatMessage("<N>" .. MyRolePlay.Identification.Surname .. "<T>" .. MyRolePlay.Identification.Title, "CHANNEL", GetDefaultLanguage("player"), mrpIndexOfChannel);
		end
		mrpFlagRSPTime = GetTime();
	end
	if (location == "Identification.Nickname") then
		MyRolePlay.Identification.Nickname = varToSave;
		MyRolePlay.Profile[index].Identification.Nickname = varToSave;
		mrpSendInfoTime = 1;
		mrp_SetText(location);
	end
	if (location == "Identification.Housename") then
		MyRolePlay.Identification.Housename = varToSave;
		MyRolePlay.Profile[index].Identification.Housename = varToSave;
		mrpSendInfoTime = 1;
		mrp_SetText(location);
	end
	if (location == "Identification.DateOfBirth") then
		MyRolePlay.Identification.DateOfBirth = varToSave;
		MyRolePlay.Profile[index].Identification.DateOfBirth = varToSave;
		mrp_SetText(location);
	end
	if (location == "Identification.FactionRank") then
		MyRolePlay.Identification.FactionRank = varToSave;
		MyRolePlay.Profile[index].Identification.FactionRank = varToSave;
		mrp_SetText(location);
	end


	if (location == "Appearance.EyeColour") then
		MyRolePlay.Appearance.EyeColour = varToSave;
		MyRolePlay.Profile[index].Appearance.EyeColour = varToSave;
		mrp_SetText(location);
	end
	if (location == "Appearance.Height") then
		MyRolePlay.Appearance.Height = varToSave;
		MyRolePlay.Profile[index].Appearance.Height = varToSave;
		mrp_SetText(location);
	end
	if (location == "Appearance.Weight") then
		MyRolePlay.Appearance.Weight = varToSave;
		MyRolePlay.Profile[index].Appearance.Weight = varToSave;
		mrp_SetText(location);
	end
	if (location == "Appearance.Description") then
		local limit = 239;
		local i = 1;
		local length = string.len(varToSave);
		local numTimes = length / limit;

		if (numTimes > 5) then
			MyRolePlay.Appearance.Description1 = string.sub(varToSave, 1, limit);
			MyRolePlay.Profile[index].Appearance.Description1 = string.sub(varToSave, 1, limit);
			varToSave = string.gsub(varToSave, ".", "", limit);
			MyRolePlay.Appearance.Description2 = string.sub(varToSave, 1, limit);
			MyRolePlay.Profile[index].Appearance.Description2 = string.sub(varToSave, 1, limit);
			varToSave = string.gsub(varToSave, ".", "", limit);
			MyRolePlay.Appearance.Description3 = string.sub(varToSave, 1, limit);
			MyRolePlay.Profile[index].Appearance.Description3 = string.sub(varToSave, 1, limit);
			varToSave = string.gsub(varToSave, ".", "", limit);
			MyRolePlay.Appearance.Description4 = string.sub(varToSave, 1, limit);
			MyRolePlay.Profile[index].Appearance.Description4 = string.sub(varToSave, 1, limit);
			varToSave = string.gsub(varToSave, ".", "", limit);
			MyRolePlay.Appearance.Description5 = string.sub(varToSave, 1, limit);
			MyRolePlay.Profile[index].Appearance.Description5 = string.sub(varToSave, 1, limit);
			varToSave = string.gsub(varToSave, ".", "", limit);
			MyRolePlay.Appearance.Description6 = string.sub(varToSave, 1, limit);
			MyRolePlay.Profile[index].Appearance.Description6 = string.sub(varToSave, 1, limit);
		elseif (numTimes > 4) then
			MyRolePlay.Appearance.Description1 = string.sub(varToSave, 1, limit);
			MyRolePlay.Profile[index].Appearance.Description1 = string.sub(varToSave, 1, limit);
			varToSave = string.gsub(varToSave, ".", "", limit);
			MyRolePlay.Appearance.Description2 = string.sub(varToSave, 1, limit);
			MyRolePlay.Profile[index].Appearance.Description2 = string.sub(varToSave, 1, limit);
			varToSave = string.gsub(varToSave, ".", "", limit);
			MyRolePlay.Appearance.Description3 = string.sub(varToSave, 1, limit);
			MyRolePlay.Profile[index].Appearance.Description3 = string.sub(varToSave, 1, limit);
			varToSave = string.gsub(varToSave, ".", "", limit);
			MyRolePlay.Appearance.Description4 = string.sub(varToSave, 1, limit);
			MyRolePlay.Profile[index].Appearance.Description4 = string.sub(varToSave, 1, limit);
			varToSave = string.gsub(varToSave, ".", "", limit);
			MyRolePlay.Appearance.Description5 = string.sub(varToSave, 1, limit);
			MyRolePlay.Profile[index].Appearance.Description5 = string.sub(varToSave, 1, limit);
			MyRolePlay.Appearance.Description6 = "";
			MyRolePlay.Profile[index].Appearance.Description6 = "";
		elseif (numTimes > 3) then
			MyRolePlay.Appearance.Description1 = string.sub(varToSave, 1, limit);
			MyRolePlay.Profile[index].Appearance.Description1 = string.sub(varToSave, 1, limit);
			varToSave = string.gsub(varToSave, ".", "", limit);
			MyRolePlay.Appearance.Description2 = string.sub(varToSave, 1, limit);
			MyRolePlay.Profile[index].Appearance.Description2 = string.sub(varToSave, 1, limit);
			varToSave = string.gsub(varToSave, ".", "", limit);
			MyRolePlay.Appearance.Description3 = string.sub(varToSave, 1, limit);
			MyRolePlay.Profile[index].Appearance.Description3 = string.sub(varToSave, 1, limit);
			varToSave = string.gsub(varToSave, ".", "", limit);
			MyRolePlay.Appearance.Description4 = string.sub(varToSave, 1, limit);
			MyRolePlay.Profile[index].Appearance.Description4 = string.sub(varToSave, 1, limit);
			MyRolePlay.Appearance.Description5 = "";
			MyRolePlay.Profile[index].Appearance.Description5 = "";
			MyRolePlay.Appearance.Description6 = "";
			MyRolePlay.Profile[index].Appearance.Description6 = "";
		elseif (numTimes > 2) then
			MyRolePlay.Appearance.Description1 = string.sub(varToSave, 1, limit);
			MyRolePlay.Profile[index].Appearance.Description1 = string.sub(varToSave, 1, limit);
			varToSave = string.gsub(varToSave, ".", "", limit);
			MyRolePlay.Appearance.Description2 = string.sub(varToSave, 1, limit);
			MyRolePlay.Profile[index].Appearance.Description2 = string.sub(varToSave, 1, limit);
			varToSave = string.gsub(varToSave, ".", "", limit);
			MyRolePlay.Appearance.Description3 = string.sub(varToSave, 1, limit);
			MyRolePlay.Profile[index].Appearance.Description3 = string.sub(varToSave, 1, limit);
			MyRolePlay.Appearance.Description4 = "";
			MyRolePlay.Profile[index].Appearance.Description4 = "";
			MyRolePlay.Appearance.Description5 = "";
			MyRolePlay.Profile[index].Appearance.Description5 = "";
			MyRolePlay.Appearance.Description6 = "";
			MyRolePlay.Profile[index].Appearance.Description6 = "";
		elseif (numTimes > 1) then
			MyRolePlay.Appearance.Description1 = string.sub(varToSave, 1, limit);
			MyRolePlay.Profile[index].Appearance.Description1 = string.sub(varToSave, 1, limit);
			varToSave = string.gsub(varToSave, ".", "", limit);
			MyRolePlay.Appearance.Description2 = string.sub(varToSave, 1, limit);
			MyRolePlay.Profile[index].Appearance.Description2 = string.sub(varToSave, 1, limit);
			MyRolePlay.Appearance.Description3 = "";
			MyRolePlay.Profile[index].Appearance.Description3 = "";
			MyRolePlay.Appearance.Description4 = "";
			MyRolePlay.Profile[index].Appearance.Description4 = "";
			MyRolePlay.Appearance.Description5 = "";
			MyRolePlay.Profile[index].Appearance.Description5 = "";
			MyRolePlay.Appearance.Description6 = "";
			MyRolePlay.Profile[index].Appearance.Description6 = "";
		elseif (numTimes >= 0) then
			MyRolePlay.Appearance.Description1 = string.sub(varToSave, 1, limit);
			MyRolePlay.Profile[index].Appearance.Description1 = string.sub(varToSave, 1, limit);
			MyRolePlay.Appearance.Description2 = "";
			MyRolePlay.Profile[index].Appearance.Description2 = "";
			MyRolePlay.Appearance.Description3 = "";
			MyRolePlay.Profile[index].Appearance.Description3 = "";
			MyRolePlay.Appearance.Description4 = "";
			MyRolePlay.Profile[index].Appearance.Description4 = "";
			MyRolePlay.Appearance.Description5 = "";
			MyRolePlay.Profile[index].Appearance.Description5 = "";
			MyRolePlay.Appearance.Description6 = "";
			MyRolePlay.Profile[index].Appearance.Description6 = "";
		end

		mrp_SetText(location);
		mrpDV = mrpDV + 1;
	end
	if (location == "Appearance.CurrentEmotion") then
		MyRolePlay.Appearance.CurrentEmotion = varToSave;
		MyRolePlay.Profile[index].Appearance.CurrentEmotion = varToSave;
		mrp_SetText(location);
	end


	if (location == "Lore.History") then
		local limit = 239;
		local i = 1;
		local length = string.len(varToSave);
		local numTimes = length / limit;

		if (numTimes > 5) then
			MyRolePlay.Lore.History1 = string.sub(varToSave, 1, limit);
			MyRolePlay.Profile[index].Lore.History1 = string.sub(varToSave, 1, limit);
			varToSave = string.gsub(varToSave, ".", "", limit);
			MyRolePlay.Lore.History2 = string.sub(varToSave, 1, limit);
			MyRolePlay.Profile[index].Lore.History2 = string.sub(varToSave, 1, limit);
			varToSave = string.gsub(varToSave, ".", "", limit);
			MyRolePlay.Lore.History3 = string.sub(varToSave, 1, limit);
			MyRolePlay.Profile[index].Lore.History3 = string.sub(varToSave, 1, limit);
			varToSave = string.gsub(varToSave, ".", "", limit);
			MyRolePlay.Lore.History4 = string.sub(varToSave, 1, limit);
			MyRolePlay.Profile[index].Lore.History4 = string.sub(varToSave, 1, limit);
			varToSave = string.gsub(varToSave, ".", "", limit);
			MyRolePlay.Lore.History5 = string.sub(varToSave, 1, limit);
			MyRolePlay.Profile[index].Lore.History5 = string.sub(varToSave, 1, limit);
			varToSave = string.gsub(varToSave, ".", "", limit);
			MyRolePlay.Lore.History6 = string.sub(varToSave, 1, limit);
			MyRolePlay.Profile[index].Lore.History6 = string.sub(varToSave, 1, limit);
		elseif (numTimes > 4) then
			MyRolePlay.Lore.History1 = string.sub(varToSave, 1, limit);
			MyRolePlay.Profile[index].Lore.History1 = string.sub(varToSave, 1, limit);
			varToSave = string.gsub(varToSave, ".", "", limit);
			MyRolePlay.Lore.History2 = string.sub(varToSave, 1, limit);
			MyRolePlay.Profile[index].Lore.History2 = string.sub(varToSave, 1, limit);
			varToSave = string.gsub(varToSave, ".", "", limit);
			MyRolePlay.Lore.History3 = string.sub(varToSave, 1, limit);
			MyRolePlay.Profile[index].Lore.History3 = string.sub(varToSave, 1, limit);
			varToSave = string.gsub(varToSave, ".", "", limit);
			MyRolePlay.Lore.History4 = string.sub(varToSave, 1, limit);
			MyRolePlay.Profile[index].Lore.History4 = string.sub(varToSave, 1, limit);
			varToSave = string.gsub(varToSave, ".", "", limit);
			MyRolePlay.Lore.History5 = string.sub(varToSave, 1, limit);
			MyRolePlay.Profile[index].Lore.History5 = string.sub(varToSave, 1, limit);
			MyRolePlay.Lore.History6 = "";
			MyRolePlay.Profile[index].Lore.History6 = "";
		elseif (numTimes > 3) then
			MyRolePlay.Lore.History1 = string.sub(varToSave, 1, limit);
			MyRolePlay.Profile[index].Lore.History1 = string.sub(varToSave, 1, limit);
			varToSave = string.gsub(varToSave, ".", "", limit);
			MyRolePlay.Lore.History2 = string.sub(varToSave, 1, limit);
			MyRolePlay.Profile[index].Lore.History2 = string.sub(varToSave, 1, limit);
			varToSave = string.gsub(varToSave, ".", "", limit);
			MyRolePlay.Lore.History3 = string.sub(varToSave, 1, limit);
			MyRolePlay.Profile[index].Lore.History3 = string.sub(varToSave, 1, limit);
			varToSave = string.gsub(varToSave, ".", "", limit);
			MyRolePlay.Lore.History4 = string.sub(varToSave, 1, limit);
			MyRolePlay.Profile[index].Lore.History4 = string.sub(varToSave, 1, limit);
			MyRolePlay.Lore.History5 = "";
			MyRolePlay.Profile[index].Lore.History5 = "";
			MyRolePlay.Lore.History6 = "";
			MyRolePlay.Profile[index].Lore.History6 = "";
		elseif (numTimes > 2) then
			MyRolePlay.Lore.History1 = string.sub(varToSave, 1, limit);
			MyRolePlay.Profile[index].Lore.History1 = string.sub(varToSave, 1, limit);
			varToSave = string.gsub(varToSave, ".", "", limit);
			MyRolePlay.Lore.History2 = string.sub(varToSave, 1, limit);
			MyRolePlay.Profile[index].Lore.History2 = string.sub(varToSave, 1, limit);
			varToSave = string.gsub(varToSave, ".", "", limit);
			MyRolePlay.Lore.History3 = string.sub(varToSave, 1, limit);
			MyRolePlay.Profile[index].Lore.History3 = string.sub(varToSave, 1, limit);
			MyRolePlay.Lore.History4 = "";
			MyRolePlay.Profile[index].Lore.History4 = "";
			MyRolePlay.Lore.History5 = "";
			MyRolePlay.Profile[index].Lore.History5 = "";
			MyRolePlay.Lore.History6 = "";
			MyRolePlay.Profile[index].Lore.History6 = "";
		elseif (numTimes > 1) then
			MyRolePlay.Lore.History1 = string.sub(varToSave, 1, limit);
			MyRolePlay.Profile[index].Lore.History1 = string.sub(varToSave, 1, limit);
			varToSave = string.gsub(varToSave, ".", "", limit);
			MyRolePlay.Lore.History2 = string.sub(varToSave, 1, limit);
			MyRolePlay.Profile[index].Lore.History2 = string.sub(varToSave, 1, limit);
			MyRolePlay.Lore.History3 = "";
			MyRolePlay.Profile[index].Lore.History3 = "";
			MyRolePlay.Lore.History4 = "";
			MyRolePlay.Profile[index].Lore.History4 = "";
			MyRolePlay.Lore.History5 = "";
			MyRolePlay.Profile[index].Lore.History5 = "";
			MyRolePlay.Lore.History6 = "";
			MyRolePlay.Profile[index].Lore.History6 = "";
		elseif (numTimes >= 0) then
			MyRolePlay.Lore.History1 = string.sub(varToSave, 1, limit);
			MyRolePlay.Profile[index].Lore.History1 = string.sub(varToSave, 1, limit);
			MyRolePlay.Lore.History2 = "";
			MyRolePlay.Profile[index].Lore.History2 = "";
			MyRolePlay.Lore.History3 = "";
			MyRolePlay.Profile[index].Lore.History3 = "";
			MyRolePlay.Lore.History4 = "";
			MyRolePlay.Profile[index].Lore.History4 = "";
			MyRolePlay.Lore.History5 = "";
			MyRolePlay.Profile[index].Lore.History5 = "";
			MyRolePlay.Lore.History6 = "";
			MyRolePlay.Profile[index].Lore.History6 = "";
		end
		mrp_SetText(location);
	end
	if (location == "Lore.Motto") then
		MyRolePlay.Lore.Motto = varToSave;
		MyRolePlay.Profile[index].Lore.Motto = varToSave;
		mrp_SetText(location);
	end
	if (location == "Lore.Homecity") then
		MyRolePlay.Lore.Homecity = varToSave;
		MyRolePlay.Profile[index].Lore.Homecity = varToSave;
		mrp_SetText(location);
	end
	if (location == "Lore.Birthcity") then
		MyRolePlay.Lore.Birthcity = varToSave;
		MyRolePlay.Profile[index].Lore.Birthcity = varToSave;
		mrp_SetText(location);
	end


	if (location == "Character.Subclass") then
		MyRolePlay.Character.Subclass = varToSave;
		MyRolePlay.Profile[index].Character.Subclass = varToSave;
		mrp_SetText(location);
	end


	if (location == "Status.Roleplay") then
		varToSave = mrpEncodeStatus(varToSave);
		MyRolePlay.Status.Roleplay = varToSave;
		MyRolePlay.Profile[index].Status.Roleplay = varToSave;
		mrpSendInfoTime = 1;

		local mrpIndexOfChannel = GetChannelName("xtensionxtooltip2");	

		if (mrpIndexOfChannel ~= nil) then
			SendChatMessage("<" .. MyRolePlay.Status.Roleplay .. ">", "CHANNEL", GetDefaultLanguage("player"), mrpIndexOfChannel);
		end
		mrpFlagRSPTime = GetTime();
	end
	if (location == "Status.Character") then
		varToSave = mrpEncodeStatus(varToSave);
		MyRolePlay.Status.Character = varToSave;
		MyRolePlay.Profile[index].Status.Character = varToSave;
		mrpSendInfoTime = 1;

		local mrpIndexOfChannel = GetChannelName("xtensionxtooltip2");	

		if (mrpIndexOfChannel ~= nil) then
			SendChatMessage("<CSTATUS>" .. MyRolePlay.Status.Character, "CHANNEL", GetDefaultLanguage("player"), mrpIndexOfChannel);
		end
		mrpFlagRSPTime = GetTime();
	end

	if (location == "curProfile") then
		mrpSaveProfile(varToSave, false);
	end
	if (location == "makeNewProfile") then
		mrpSaveProfile(varToSave, true);
	end	
end

function mrp_SetText(location)
	if (location == "Identification.Firstname") then
		FirstnameText:SetText(MyRolePlay.Identification.Firstname);
		PlayerName:SetText(MyRolePlay.Identification.Firstname);
	end
	if (location == "Identification.Middlename") then
		MiddlenameText:SetText(MyRolePlay.Identification.Middlename);
	end
	if (location == "Identification.Surname") then
		SurnameText:SetText(MyRolePlay.Identification.Surname);
	end
	if (location == "Identification.Prefix") then
		PrefixText:SetText(MyRolePlay.Identification.Prefix);
	end
	if (location == "Identification.Title") then
		TitleText:SetText(MyRolePlay.Identification.Title);
	end
	if (location == "Identification.Nickname") then
		NicknameText:SetText(MyRolePlay.Identification.Nickname);
	end
	if (location == "Identification.Housename") then
		HousenameText:SetText(MyRolePlay.Identification.Housename);
	end
	if (location == "Identification.DateOfBirth") then
		--DateOfBirthText:SetText(MyRolePlay.Identification.DateOfBirth);
	end
	if (location == "Identification.FactionRank") then
		--FactionRankText:SetText(MyRolePlay.Identification.FactionRank);
	end



	if (location == "Appearance.EyeColour") then
		EyeColourText:SetText(MyRolePlay.Appearance.EyeColour);
	end
	if (location == "Appearance.Height") then
		HeightText:SetText(MyRolePlay.Appearance.Height);
	end
	if (location == "Appearance.Weight") then
		WeightText:SetText(MyRolePlay.Appearance.Weight);
	end
	if (location == "Appearance.Description") then
		DescriptionText:SetText(MyRolePlay.Appearance.Description1 .. MyRolePlay.Appearance.Description2 .. MyRolePlay.Appearance.Description3 .. MyRolePlay.Appearance.Description4 .. MyRolePlay.Appearance.Description5 .. MyRolePlay.Appearance.Description6);
	end
	if (location == "Appearance.CurrentEmotion") then
		CurrentEmotionText:SetText(MyRolePlay.Appearance.CurrentEmotion);
	end



	if (location == "Lore.History") then
		HistoryText:SetText(MyRolePlay.Lore.History1 .. MyRolePlay.Lore.History2 .. MyRolePlay.Lore.History3 .. MyRolePlay.Lore.History4 .. MyRolePlay.Lore.History5 .. MyRolePlay.Lore.History6);		
	end
	if (location == "Lore.Motto") then
		MottoText:SetText(MyRolePlay.Lore.Motto);
	end
	if (location == "Lore.Homecity") then
		HomecityText:SetText(MyRolePlay.Lore.Homecity);
	end
	if (location == "Lore.Birthcity") then
		BirthcityText:SetText(MyRolePlay.Lore.Birthcity);
	end



	if (location == "Character.Subclass") then
		SubclassText:SetText(MyRolePlay.Character.Subclass);
	end
end

function mrpEncodeText(text)
	text = string.gsub(text, "%%", "`p");
	text = string.gsub(text, "0", "`z");

	return (text);
end

function mrpDecodeText(text)
	text = string.gsub(text, "`p", "%%");
	text = string.gsub(text, "`z", "0");

	return (text);
end

function mrpEncodeStatus(status)
	if (status == MRP_LOCALE_DropDownCSNone) then
		status = "none";
	elseif (status == MRP_LOCALE_DropDownCSOOC) then
		status = "ooc";
	elseif (status == MRP_LOCALE_DropDownCSIC) then
		status = "ic";
	elseif (status == MRP_LOCALE_DropDownCSFFAIC) then
		status = "ffa-ic";
	elseif (status == MRP_LOCALE_DropDownCSST) then
		status = "st";
	elseif (status == MRP_LOCALE_DropDownCSNone) then
		status = "CS0";
	elseif (status == MRP_LOCALE_DropDownCSOOC) then
		status = "CS1";
	elseif (status == MRP_LOCALE_DropDownCSIC) then
		status = "CS2";
	elseif (status == MRP_LOCALE_DropDownCSFFAIC) then
		status = "CS3";
	elseif (status == MRP_LOCALE_DropDownCSST) then
		status = "CS4";
	elseif (status == MRP_LOCALE_DropDownRP0) then
		status = "RP0";
	elseif (status == MRP_LOCALE_DropDownRP1) then
		status = "RP1";
	elseif (status == MRP_LOCALE_DropDownRP1) then
		status = "RP";
	elseif (status == MRP_LOCALE_DropDownRP2) then
		status = "RP2";
	elseif (status == MRP_LOCALE_DropDownRP3) then
		status = "RP3";
	elseif (status == MRP_LOCALE_DropDownRP4) then
		status = "RP4";
	end

	return status;
end

function mrpDecodeStatus(status)
	if (status == "none") then
		status = MRP_LOCALE_DropDownCSNone;
	elseif (status == "ooc") then
		status = MRP_LOCALE_DropDownCSOOC;
	elseif (status == "ic") then
		status = MRP_LOCALE_DropDownCSIC;
	elseif (status == "ffa-ic") then
		status = MRP_LOCALE_DropDownCSFFAIC;
	elseif (status == "st") then
		status = MRP_LOCALE_DropDownCSST;
	elseif (status == "CS0") then
		status = MRP_LOCALE_DropDownCSNone;
	elseif (status == "CS1") then
		status = MRP_LOCALE_DropDownCSOOC;
	elseif (status == "CS2") then
		status = MRP_LOCALE_DropDownCSIC;
	elseif (status == "CS3") then
		status = MRP_LOCALE_DropDownCSFFAIC;
	elseif (status == "CS4") then
		status = MRP_LOCALE_DropDownCSST;
	elseif (status == "RP0") then
		status = MRP_LOCALE_DropDownRP0;
	elseif (status == "RP1") then
		status = MRP_LOCALE_DropDownRP1;
	elseif (status == "RP") then
		status = MRP_LOCALE_DropDownRP1;
	elseif (status == "RP2") then
		status = MRP_LOCALE_DropDownRP2;
	elseif (status == "RP3") then
		status = MRP_LOCALE_DropDownRP3;
	elseif (status == "RP4") then
		status = MRP_LOCALE_DropDownRP4;
	end

	return status;
end

function mrpRelativeLevelCheck(level)
	if ((level) == -1) then
	return (MRP_LOCALE_mrpRelative10h);
	elseif ((level) <= (UnitLevel("player") - 7)) then
	return(MRP_LOCALE_mrpRelative7l);		
	elseif ( ((level) >= (UnitLevel("player")) - 6) and ((level) <= (UnitLevel("player") - 5  ))) then
	return (MRP_LOCALE_mrpRelative5to6l);
	elseif ( ((level) >= (UnitLevel("player")) - 4) and ((level) <= (UnitLevel("player") - 2  ))) then
	return (MRP_LOCALE_mrpRelative2to4l);
	elseif ( ((level) >= (UnitLevel("player")) - 1) and ((level) <= (UnitLevel("player") + 2  ))) then
	return (MRP_LOCALE_mrpRelative1to1h);
	elseif ( ((level) >= (UnitLevel("player")) + 2) and ((level) <= (UnitLevel("player") + 3  ))) then
	return (MRP_LOCALE_mrpRelative2to3h);
	elseif ( ((level) >= (UnitLevel("player")) + 4) and ((level) <= (UnitLevel("player") + 6  ))) then
	return (MRP_LOCALE_mrpRelative4to6h);
	elseif ( ((level) >= (UnitLevel("player")) + 7) and ((level) <= (UnitLevel("player") + 9  ))) then
	return (MRP_LOCALE_mrpRelative7to9h);
	else
	return (MRP_LOCALE_mrpRelative10h);
	end
	
end

function mrpDisplayMessage(txt, r, g, b)
	if (r == nil or g == nil or b == nil) then
		r = 1;
		g = 1;
		b = 0;
	end
	if (DEFAULT_CHAT_FRAME) then
		DEFAULT_CHAT_FRAME:AddMessage("|CFF0066FF<MyRolePlay>|r " .. txt, r, g, b);
	end	
end

function mrpResetTarget()
	mrpTarget.Identification.Charactername = "";
	mrpTarget.Identification.Firstname = "";
	mrpTarget.Identification.Middlename = "";
	mrpTarget.Identification.Surname = "";
	mrpTarget.Identification.Prefix = "";
	mrpTarget.Identification.Title = "";
	mrpTarget.Identification.Nickname = "";
	mrpTarget.Identification.Housename = "";
	mrpTarget.Identification.DateOfBirth = "";
	mrpTarget.Identification.FactionRank = "";

	mrpTarget.Status.Roleplay = "";
	mrpTarget.Status.Character = "";

	mrpTarget.Appearance.EyeColour = "";
	mrpTarget.Appearance.Height = "";
	mrpTarget.Appearance.Weight = "";
	mrpTarget.Appearance.Description1 = "";
	mrpTarget.Appearance.Description2 = "";
	mrpTarget.Appearance.Description3 = "";
	mrpTarget.Appearance.Description4 = "";
	mrpTarget.Appearance.Description5 = "";
	mrpTarget.Appearance.Description6 = "";
	mrpTarget.Appearance.CurrentEmotion = "";

	mrpTarget.Lore.History1 = "";
	mrpTarget.Lore.History2 = "";
	mrpTarget.Lore.History3 = "";
	mrpTarget.Lore.History4 = "";
	mrpTarget.Lore.History5 = "";
	mrpTarget.Lore.History6 = "";
	mrpTarget.Lore.Motto = "";
	mrpTarget.Lore.Homecity = "";
	mrpTarget.Lore.Birthcity = "";
end

function mrpSetTargetFactionRank(fromWhere)
	if (UnitPlayerControlled("mouseover") or UnitPlayerControlled("player")) then
		mrpRank = nil;
		if (fromWhere == "MOUSEOVER" or fromWhere == "CHATMESSAGE") then
			mrpRank = string.split(UnitPVPName("mouseover"), " ");
		elseif (fromWhere == "PLAYER") then
			mrpRank = string.split(UnitPVPName("player"), " ");
		end
		local num = table.getn(mrpRank);

		if (num == 1) then
			mrpTarget.Identification.FactionRank = "";
		elseif (num == 2) then
			mrpTarget.Identification.FactionRank = mrpRank[1];
		elseif (num == 3) then
			mrpTarget.Identification.FactionRank = mrpRank[1] .. " " .. mrpRank[2];
		end
	end
end

function mrpSetTargetFirstname(wowDefault)
	if (wowDefault) then
		mrpTarget.Identification.Firstname = UnitName("mouseover");
	else
		mrpTarget.Identification.Firstname = "";
	end	
end

--------------------------------------------------------------------------------------------------------

function mrpEnterInformationDialog(location, text, numLetters)
	local locationEdit = {};

	for i in string.gfind(location, "%w*") do
		if (i ~= "") then
			locationEdit[table.getn(locationEdit) + 1] = i;
		end		
	end
	
	mrpEnterInformationLocation = location;
	mrpEnterInformationText:SetText(text);
	mrpEnterInformationEditBox:SetMaxLetters(numLetters);
	if (location == "Appearance.Description") then
		mrpEnterInformationEditBox:SetText(MyRolePlay.Appearance.Description1 .. MyRolePlay.Appearance.Description2 .. MyRolePlay.Appearance.Description3 .. MyRolePlay.Appearance.Description4 .. MyRolePlay.Appearance.Description5 .. MyRolePlay.Appearance.Description6);
	elseif (location == "Lore.History") then
		mrpEnterInformationEditBox:SetText(MyRolePlay.Lore.History1 .. MyRolePlay.Lore.History2 .. MyRolePlay.Lore.History3 .. MyRolePlay.Lore.History4 .. MyRolePlay.Lore.History5 .. MyRolePlay.Lore.History6);
	else
		mrpEnterInformationEditBox:SetText(MyRolePlay[locationEdit[1]][locationEdit[2]]);
	end	
	
	mrpEnterInformation:Show();
end

function mrp_EditTextPopup(location, whatToDoMessage, numLetters)
	local locationEdit = {};

	for i in string.gfind(location, "%w*") do
		if (i ~= "") then
			locationEdit[table.getn(locationEdit) + 1] = i;
		end		
	end

	StaticPopupDialogs["MRP_EDITDIALOG"] = {
	text = "%s",
	hasEditBox = 1,
	maxLetters = numLetters,
	button1 = "OK",
	button2 = MRP_LOCALE_CANCEL,
	OnAccept = function()
		local text = getglobal(this:GetParent():GetName().."EditBox"):GetText();
		RenamePetition(text);
		mrp_SaveVariable(text, location);
	end,
	EditBoxOnEnterPressed = function()
		local text = getglobal(this:GetParent():GetName().."EditBox"):GetText();
		RenamePetition(text);
		mrp_SaveVariable(text, location);
	end,
	OnShow = function()
		getglobal(this:GetName().."EditBox"):SetFocus();
		if (location ~= "curProfile" and location ~= "makeNewProfile") then
			getglobal(this:GetName().."EditBox"):SetText(MyRolePlay[locationEdit[1]][locationEdit[2]]);
		end				
	end,
	OnHide = function()
		if ( ChatFrameEditBox:IsVisible() ) then
			ChatFrameEditBox:SetFocus();
		end
		getglobal(this:GetName().."EditBox"):SetText("");
	end,
	timeout = 0,
	exclusive = 0,
	hideOnEscape = 1,
	whileDead = 1
	};

	StaticPopup_Show("MRP_EDITDIALOG", whatToDoMessage);
end

function mrpErrorMessageBox(message)
	
	StaticPopupDialogs["MRP_ERRORMESSAGEBOX"] = {
	text = "%s",
	button1 = "OK",
	timeout = 0,
	exclusive = 0,
	hideOnEscape = 0,
	whileDead = 1
	};

	StaticPopup_Show("MRP_ERRORMESSAGEBOX", message);
end

function mrpUpdateEditBoxScroller(editBox)

	local scrollbar = getglobal(editBox:GetParent():GetParent():GetName() .. "ScrollBar");
	editBox:GetParent():GetParent():UpdateScrollChildRect();
	local min, max = scrollbar:GetMinMaxValues();

	if max > 0 and editBox.max ~= max then
		editBox.max = max;
		scrollbar:SetValue(max);
	end
end

-- splits the specified text into an array on the specified separator
function string.split( text, separator, limit )
    local parts, position, length, last, jump, count = {}, 1, string.len( text ), nil, string.len( separator ), 0
    while true do
        last = string.find( text, separator, position, true )
        if last and ( not limit or count < limit ) then
            table.insert( parts, string.sub( text, position, last - 1 ) )
            position, count = last + jump, count + 1
        else
            table.insert( parts, string.sub( text, position ) )
            break
        end
    end
    --return unpack( parts )
    return parts;
end

function mrpCharacterFrameNextPage_OnClick()
	if (mrpCharacterFrameIdentityFrame:IsShown()) then
		mrpCharacterFrameIdentityFrame:Hide();
		mrpCharacterFrameAppearanceFrame:Hide();
		mrpCharacterFrameLoreFrame:Show();
	end
end

function mrpCharacterFramePrevPage_OnClick()
	if (mrpCharacterFrameLoreFrame:IsShown()) then
		mrpCharacterFrameLoreFrame:Hide();
		mrpCharacterFrameIdentityFrame:Show();
		mrpCharacterFrameAppearanceFrame:Show();		
	end
end

mrpRPFirstRun = 1;

function mrpRPDropDownHandler()
	UIDropDownMenu_Initialize(mrpRPDropDown, mrpRPDropDown_Initialize);
	if (mrpRPFirstRun == 1) then
		if (MyRolePlay.Status.Roleplay ~= nil) then
			UIDropDownMenu_SetSelectedValue(mrpRPDropDown, mrpDecodeStatus(MyRolePlay.Status.Roleplay));
		else
			UIDropDownMenu_SetSelectedValue(mrpRPDropDown, MRP_LOCALE_DropDownRP0);
		end		
		mrpRPFirstRun = 0;
	end	
	UIDropDownMenu_SetWidth(200, mrpRPDropDown);
end

function mrpRPDropDown_Initialize()
	local tempInfo = {};

	tempInfo.text = MRP_LOCALE_DropDownRP0;
	tempInfo.func = mrpRPDropDown_OnClick;
	tempInfo.tooltipTitle = MRP_LOCALE_DropDownRP0;
	tempInfo.tooltipText = MRP_LOCALE_DropDownRP0Expl;
	tempInfo.checked = nil;

	UIDropDownMenu_AddButton(tempInfo);

	tempInfo.text = MRP_LOCALE_DropDownRP1;
	tempInfo.func = mrpRPDropDown_OnClick;
	tempInfo.tooltipTitle = MRP_LOCALE_DropDownRP1;
	tempInfo.tooltipText = MRP_LOCALE_DropDownRP1Expl;
	tempInfo.checked = nil;	

	UIDropDownMenu_AddButton(tempInfo);

	tempInfo.text = MRP_LOCALE_DropDownRP2;
	tempInfo.func = mrpRPDropDown_OnClick;
	tempInfo.tooltipTitle = MRP_LOCALE_DropDownRP2;
	tempInfo.tooltipText = MRP_LOCALE_DropDownRP2Expl;
	tempInfo.checked = nil;

	UIDropDownMenu_AddButton(tempInfo);

	tempInfo.text = MRP_LOCALE_DropDownRP3;
	tempInfo.func = mrpRPDropDown_OnClick;
	tempInfo.tooltipTitle = MRP_LOCALE_DropDownRP3;
	tempInfo.tooltipText = MRP_LOCALE_DropDownRP3Expl;
	tempInfo.checked = nil;

	UIDropDownMenu_AddButton(tempInfo);

	tempInfo.text = MRP_LOCALE_DropDownRP4;
	tempInfo.func = mrpRPDropDown_OnClick;
	tempInfo.tooltipTitle = MRP_LOCALE_DropDownRP4;
	tempInfo.tooltipText = MRP_LOCALE_DropDownRP4Expl;
	tempInfo.checked = nil;

	UIDropDownMenu_AddButton(tempInfo);
end

function mrpRPDropDown_OnClick()
	UIDropDownMenu_SetSelectedValue(mrpRPDropDown, this.value);
	mrp_SaveVariable(UIDropDownMenu_GetSelectedValue(mrpRPDropDown), "Status.Roleplay");
end

mrpCSFirstRun = 1;

function mrpCSDropDownHandler()
	UIDropDownMenu_Initialize(mrpCSDropDown, mrpCSDropDown_Initialize);
	if (mrpCSFirstRun == 1) then
		if (MyRolePlay.Status.Character ~= nil) then
			UIDropDownMenu_SetSelectedValue(mrpCSDropDown, mrpDecodeStatus(MyRolePlay.Status.Character));
		else
			UIDropDownMenu_SetSelectedValue(mrpCSDropDown, MRP_LOCALE_DropDownCSNone);
		end		
		mrpCSFirstRun = 0;
	end	
	UIDropDownMenu_SetWidth(200, mrpCSDropDown);
end

function mrpCSDropDown_Initialize()
	local tempInfo = {};

	tempInfo.text = MRP_LOCALE_DropDownCSNone;
	tempInfo.func = mrpCSDropDown_OnClick;
	tempInfo.tooltipTitle = MRP_LOCALE_DropDownCSNone;
	tempInfo.tooltipText = MRP_LOCALE_DropDownCSNoneExpl;
	tempInfo.checked = nil;

	UIDropDownMenu_AddButton(tempInfo);

	tempInfo.text = MRP_LOCALE_DropDownCSOOC;
	tempInfo.func = mrpCSDropDown_OnClick;
	tempInfo.tooltipTitle = MRP_LOCALE_DropDownCSOOC;
	tempInfo.tooltipText = MRP_LOCALE_DropDownCSOOCExpl;
	tempInfo.checked = nil;	

	UIDropDownMenu_AddButton(tempInfo);

	tempInfo.text = MRP_LOCALE_DropDownCSIC;
	tempInfo.func = mrpCSDropDown_OnClick;
	tempInfo.tooltipTitle = MRP_LOCALE_DropDownCSIC;
	tempInfo.tooltipText = MRP_LOCALE_DropDownCSICExpl;
	tempInfo.checked = nil;

	UIDropDownMenu_AddButton(tempInfo);

	tempInfo.text = MRP_LOCALE_DropDownCSFFAIC;
	tempInfo.func = mrpCSDropDown_OnClick;
	tempInfo.tooltipTitle = MRP_LOCALE_DropDownCSFFAIC;
	tempInfo.tooltipText = MRP_LOCALE_DropDownCSFFAICExpl;
	tempInfo.checked = nil;

	UIDropDownMenu_AddButton(tempInfo);

	tempInfo.text = MRP_LOCALE_DropDownCSST;
	tempInfo.func = mrpCSDropDown_OnClick;
	tempInfo.tooltipTitle = MRP_LOCALE_DropDownCSST;
	tempInfo.tooltipText = MRP_LOCALE_DropDownCSSTExpl;
	tempInfo.checked = nil;

	UIDropDownMenu_AddButton(tempInfo);
end

function mrpCSDropDown_OnClick()
	UIDropDownMenu_SetSelectedValue(mrpCSDropDown, this.value);
	mrp_SaveVariable(UIDropDownMenu_GetSelectedValue(mrpCSDropDown), "Status.Character");
end


function mrpProfileDropDownHandler()
	UIDropDownMenu_Initialize(mrpProfileDropDown, mrpProfileDropDown_Initialize);

	UIDropDownMenu_SetSelectedValue(mrpProfileDropDown, MyRolePlay.curProfile);	

	UIDropDownMenu_SetWidth(125, mrpProfileDropDown);
end

function mrpProfileDropDown_Initialize()
	local tempInfo = {};
	local i = 1;

	for i = 1, table.getn(MyRolePlay.Profile), 1 do
		tempInfo.text = MyRolePlay.Profile[i].ProfileName;
		tempInfo.func = mrpProfileDropDown_OnClick;
		tempInfo.checked = nil;

		UIDropDownMenu_AddButton(tempInfo);
	end
end

function mrpProfileDropDown_OnClick()
	UIDropDownMenu_SetSelectedValue(mrpProfileDropDown, this.value);
	mrpChangeProfile(UIDropDownMenu_GetSelectedValue(mrpProfileDropDown));
end

function mrpDeleteProfile()
	if (table.getn(MyRolePlay.Profile) == 1) then
		mrpErrorMessageBox(MRP_LOCALE_One_Profile);
		return;
	end
	for i = 1, table.getn(MyRolePlay.Profile) do
		if (MyRolePlay.Profile[i].ProfileName == MyRolePlay.curProfile) then
			table.remove(MyRolePlay.Profile, i);
			mrpChangeProfile(MyRolePlay.Profile[1].ProfileName);
			break;
		end
	end
end

function mrpSaveProfile(mrpProfileName, isNew)
	local index = 1;
	local mrpIsProfileFound = false;
	local newIndex = (table.getn(MyRolePlay.Profile) + 1);

	for i = 1, table.getn(MyRolePlay.Profile) do
		if (MyRolePlay.Profile[i].ProfileName == mrpProfileName) then
			index = i
			mrpIsProfileFound = true;
			break;
		end
	end

	if (mrpIsProfileFound == true) then
		if (isNew == true) then
			mrpErrorMessageBox(MRP_LOCALE_Profile_Exists_1 .. mrpProfileName .. MRP_LOCALE_Profile_Exists_2);
			return;
		end
		MyRolePlay.Profile[index].Identification.Firstname = MyRolePlay.Identification.Firstname;
		MyRolePlay.Profile[index].Identification.Middlename = MyRolePlay.Identification.Middlename;
		MyRolePlay.Profile[index].Identification.Surname = MyRolePlay.Identification.Surname;
		MyRolePlay.Profile[index].Identification.Prefix = MyRolePlay.Identification.Prefix;
		MyRolePlay.Profile[index].Identification.Title = MyRolePlay.Identification.Title;
		MyRolePlay.Profile[index].Identification.Nickname = MyRolePlay.Identification.Nickname;
		MyRolePlay.Profile[index].Identification.Housename = MyRolePlay.Identification.Housename;
		MyRolePlay.Profile[index].Identification.DateOfBirth = MyRolePlay.Identification.DateOfBirth;

		MyRolePlay.Profile[index].Status.Roleplay = MyRolePlay.Status.Roleplay;
		MyRolePlay.Profile[index].Status.Character = MyRolePlay.Status.Character;

		MyRolePlay.Profile[index].Appearance.EyeColour = MyRolePlay.Appearance.EyeColour;
		MyRolePlay.Profile[index].Appearance.Height = MyRolePlay.Appearance.Height;
		MyRolePlay.Profile[index].Appearance.Weight = MyRolePlay.Appearance.Weight;
			MyRolePlay.Profile[index].Appearance.Description1 = MyRolePlay.Appearance.Description1;
			MyRolePlay.Profile[index].Appearance.Description2 = MyRolePlay.Appearance.Description2;
			MyRolePlay.Profile[index].Appearance.Description3 = MyRolePlay.Appearance.Description3;
			MyRolePlay.Profile[index].Appearance.Description4 = MyRolePlay.Appearance.Description4;
			MyRolePlay.Profile[index].Appearance.Description5 = MyRolePlay.Appearance.Description5;
			MyRolePlay.Profile[index].Appearance.Description6 = MyRolePlay.Appearance.Description6;
		MyRolePlay.Profile[index].Appearance.CurrentEmotion = MyRolePlay.Appearance.CurrentEmotion;
	
			MyRolePlay.Profile[index].Lore.History1 = MyRolePlay.Lore.History1;
			MyRolePlay.Profile[index].Lore.History2 = MyRolePlay.Lore.History2;
			MyRolePlay.Profile[index].Lore.History3 = MyRolePlay.Lore.History3;
			MyRolePlay.Profile[index].Lore.History4 = MyRolePlay.Lore.History4;
			MyRolePlay.Profile[index].Lore.History5 = MyRolePlay.Lore.History5;
			MyRolePlay.Profile[index].Lore.History6 = MyRolePlay.Lore.History6;
		MyRolePlay.Profile[index].Lore.Motto = MyRolePlay.Lore.Motto;
		MyRolePlay.Profile[index].Lore.Homecity = MyRolePlay.Lore.Homecity;
		MyRolePlay.Profile[index].Lore.Birthcity = MyRolePlay.Lore.Birthcity;

	else
		if (isNew == true) then
			MyRolePlay.Identification.Firstname = UnitName("player");
			MyRolePlay.Identification.Middlename = "";
			MyRolePlay.Identification.Surname = "";
			MyRolePlay.Identification.Prefix = "";
			MyRolePlay.Identification.Title = "";
			MyRolePlay.Identification.Nickname = "";
			MyRolePlay.Identification.Housename = "";
			MyRolePlay.Identification.DateOfBirth = "";

			MyRolePlay.Status.Roleplay = "";
			MyRolePlay.Status.Character = "";

			MyRolePlay.Appearance.EyeColour = "";
			MyRolePlay.Appearance.Height = "";
			MyRolePlay.Appearance.Weight = "";
				MyRolePlay.Appearance.Description1 = "";
				MyRolePlay.Appearance.Description2 = "";
				MyRolePlay.Appearance.Description3 = "";
				MyRolePlay.Appearance.Description4 = "";
				MyRolePlay.Appearance.Description5 = "";
				MyRolePlay.Appearance.Description6 = "";
			MyRolePlay.Appearance.CurrentEmotion = "";
		
				MyRolePlay.Lore.History1 = "";
				MyRolePlay.Lore.History2 = "";
				MyRolePlay.Lore.History3 = "";
				MyRolePlay.Lore.History4 = "";
				MyRolePlay.Lore.History5 = "";
				MyRolePlay.Lore.History6 = "";
			MyRolePlay.Lore.Motto = "";
			MyRolePlay.Lore.Homecity = "";
			MyRolePlay.Lore.Birthcity = "";
			
			table.insert(MyRolePlay.Profile, newIndex);

			MyRolePlay.Profile[newIndex] = {};
			MyRolePlay.Profile[newIndex].ProfileName = mrpProfileName;
			MyRolePlay.Profile[newIndex].Identification = {};
			MyRolePlay.Profile[newIndex].Appearance = {};
			MyRolePlay.Profile[newIndex].Lore = {};
			MyRolePlay.Profile[newIndex].Character = {};
			MyRolePlay.Profile[newIndex].Status = {};

			MyRolePlay.Profile[newIndex].Identification.Firstname = MyRolePlay.Identification.Firstname;
			MyRolePlay.Profile[newIndex].Identification.Middlename = MyRolePlay.Identification.Middlename;
			MyRolePlay.Profile[newIndex].Identification.Surname = MyRolePlay.Identification.Surname;
			MyRolePlay.Profile[newIndex].Identification.Prefix = MyRolePlay.Identification.Prefix;
			MyRolePlay.Profile[newIndex].Identification.Title = MyRolePlay.Identification.Title;
			MyRolePlay.Profile[newIndex].Identification.Nickname = MyRolePlay.Identification.Nickname;
			MyRolePlay.Profile[newIndex].Identification.Housename = MyRolePlay.Identification.Housename;
			MyRolePlay.Profile[newIndex].Identification.DateOfBirth = MyRolePlay.Identification.DateOfBirth;

			MyRolePlay.Profile[newIndex].Status.Roleplay = MyRolePlay.Status.Roleplay;
			MyRolePlay.Profile[newIndex].Status.Character = MyRolePlay.Status.Character;

			MyRolePlay.Profile[newIndex].Appearance.EyeColour = MyRolePlay.Appearance.EyeColour;
			MyRolePlay.Profile[newIndex].Appearance.Height = MyRolePlay.Appearance.Height;
			MyRolePlay.Profile[newIndex].Appearance.Weight = MyRolePlay.Appearance.Weight;
				MyRolePlay.Profile[newIndex].Appearance.Description1 = MyRolePlay.Appearance.Description1;
				MyRolePlay.Profile[newIndex].Appearance.Description2 = MyRolePlay.Appearance.Description2;
				MyRolePlay.Profile[newIndex].Appearance.Description3 = MyRolePlay.Appearance.Description3;
				MyRolePlay.Profile[newIndex].Appearance.Description4 = MyRolePlay.Appearance.Description4;
				MyRolePlay.Profile[newIndex].Appearance.Description5 = MyRolePlay.Appearance.Description5;
				MyRolePlay.Profile[newIndex].Appearance.Description6 = MyRolePlay.Appearance.Description6;
			MyRolePlay.Profile[newIndex].Appearance.CurrentEmotion = MyRolePlay.Appearance.CurrentEmotion;
		
				MyRolePlay.Profile[newIndex].Lore.History1 = MyRolePlay.Lore.History1;
				MyRolePlay.Profile[newIndex].Lore.History2 = MyRolePlay.Lore.History2;
				MyRolePlay.Profile[newIndex].Lore.History3 = MyRolePlay.Lore.History3;
				MyRolePlay.Profile[newIndex].Lore.History4 = MyRolePlay.Lore.History4;
				MyRolePlay.Profile[newIndex].Lore.History5 = MyRolePlay.Lore.History5;
				MyRolePlay.Profile[newIndex].Lore.History6 = MyRolePlay.Lore.History6;
			MyRolePlay.Profile[newIndex].Lore.Motto = MyRolePlay.Lore.Motto;
			MyRolePlay.Profile[newIndex].Lore.Homecity = MyRolePlay.Lore.Homecity;
			MyRolePlay.Profile[newIndex].Lore.Birthcity = MyRolePlay.Lore.Birthcity;
		else
			table.insert(MyRolePlay.Profile, newIndex);

			MyRolePlay.Profile[newIndex] = {};
			MyRolePlay.Profile[newIndex].ProfileName = mrpProfileName;
			MyRolePlay.Profile[newIndex].Identification = {};
			MyRolePlay.Profile[newIndex].Appearance = {};
			MyRolePlay.Profile[newIndex].Lore = {};
			MyRolePlay.Profile[newIndex].Character = {};
			MyRolePlay.Profile[newIndex].Status = {};

			MyRolePlay.Profile[newIndex].Identification.Firstname = MyRolePlay.Identification.Firstname;
			MyRolePlay.Profile[newIndex].Identification.Middlename = MyRolePlay.Identification.Middlename;
			MyRolePlay.Profile[newIndex].Identification.Surname = MyRolePlay.Identification.Surname;
			MyRolePlay.Profile[newIndex].Identification.Prefix = MyRolePlay.Identification.Prefix;
			MyRolePlay.Profile[newIndex].Identification.Title = MyRolePlay.Identification.Title;
			MyRolePlay.Profile[newIndex].Identification.Nickname = MyRolePlay.Identification.Nickname;
			MyRolePlay.Profile[newIndex].Identification.Housename = MyRolePlay.Identification.Housename;
			MyRolePlay.Profile[newIndex].Identification.DateOfBirth = MyRolePlay.Identification.DateOfBirth;

			MyRolePlay.Profile[newIndex].Status.Roleplay = MyRolePlay.Status.Roleplay;
			MyRolePlay.Profile[newIndex].Status.Character = MyRolePlay.Status.Character;

			MyRolePlay.Profile[newIndex].Appearance.EyeColour = MyRolePlay.Appearance.EyeColour;
			MyRolePlay.Profile[newIndex].Appearance.Height = MyRolePlay.Appearance.Height;
			MyRolePlay.Profile[newIndex].Appearance.Weight = MyRolePlay.Appearance.Weight;
				MyRolePlay.Profile[newIndex].Appearance.Description1 = MyRolePlay.Appearance.Description1;
				MyRolePlay.Profile[newIndex].Appearance.Description2 = MyRolePlay.Appearance.Description2;
				MyRolePlay.Profile[newIndex].Appearance.Description3 = MyRolePlay.Appearance.Description3;
				MyRolePlay.Profile[newIndex].Appearance.Description4 = MyRolePlay.Appearance.Description4;
				MyRolePlay.Profile[newIndex].Appearance.Description5 = MyRolePlay.Appearance.Description5;
				MyRolePlay.Profile[newIndex].Appearance.Description6 = MyRolePlay.Appearance.Description6;
			MyRolePlay.Profile[newIndex].Appearance.CurrentEmotion = MyRolePlay.Appearance.CurrentEmotion;
		
				MyRolePlay.Profile[newIndex].Lore.History1 = MyRolePlay.Lore.History1;
				MyRolePlay.Profile[newIndex].Lore.History2 = MyRolePlay.Lore.History2;
				MyRolePlay.Profile[newIndex].Lore.History3 = MyRolePlay.Lore.History3;
				MyRolePlay.Profile[newIndex].Lore.History4 = MyRolePlay.Lore.History4;
				MyRolePlay.Profile[newIndex].Lore.History5 = MyRolePlay.Lore.History5;
				MyRolePlay.Profile[newIndex].Lore.History6 = MyRolePlay.Lore.History6;
			MyRolePlay.Profile[newIndex].Lore.Motto = MyRolePlay.Lore.Motto;
			MyRolePlay.Profile[newIndex].Lore.Homecity = MyRolePlay.Lore.Homecity;
			MyRolePlay.Profile[newIndex].Lore.Birthcity = MyRolePlay.Lore.Birthcity;
		end
	end

	MyRolePlay.curProfile = mrpProfileName;

	mrpChangeProfile(MyRolePlay.curProfile);
end

function mrpChangeProfile(mrpProfileName)
	
	local i = 1;
	local index = nil;

	for i = 1, table.getn(MyRolePlay.Profile) do
		if (MyRolePlay.Profile[i].ProfileName == mrpProfileName) then
			index = i;
			break;
		end
	end

	MyRolePlay.curProfile = mrpProfileName;

	mrp_SaveVariable(MyRolePlay.Profile[index].Identification.Firstname, "Identification.Firstname");
	mrp_SaveVariable(MyRolePlay.Profile[index].Identification.Middlename, "Identification.Middlename");
	mrp_SaveVariable(MyRolePlay.Profile[index].Identification.Surname, "Identification.Surname");
	mrp_SaveVariable(MyRolePlay.Profile[index].Identification.Prefix, "Identification.Prefix");
	mrp_SaveVariable(MyRolePlay.Profile[index].Identification.Title,"Identification.Title");
	mrp_SaveVariable(MyRolePlay.Profile[index].Identification.Nickname, "Identification.Nickname");
	mrp_SaveVariable(MyRolePlay.Profile[index].Identification.Housename, "Identification.Housename");
	mrp_SaveVariable(MyRolePlay.Profile[index].Identification.DateOfBirth, "Identification.DateOfBirth");

	mrp_SaveVariable(MyRolePlay.Profile[index].Status.Roleplay, "Status.Roleplay");
	mrp_SaveVariable(MyRolePlay.Profile[index].Status.Character, "Status.Character");

	mrp_SaveVariable(MyRolePlay.Profile[index].Appearance.EyeColour, "Appearance.EyeColour");
	mrp_SaveVariable(MyRolePlay.Profile[index].Appearance.Height, "Appearance.Height");
	mrp_SaveVariable(MyRolePlay.Profile[index].Appearance.Weight, "Appearance.Weight");
	local tempDescription = MyRolePlay.Profile[index].Appearance.Description1 .. MyRolePlay.Profile[index].Appearance.Description2 .. MyRolePlay.Profile[index].Appearance.Description3 .. MyRolePlay.Profile[index].Appearance.Description4 .. MyRolePlay.Profile[index].Appearance.Description5 .. MyRolePlay.Profile[index].Appearance.Description6;
	mrp_SaveVariable(tempDescription, "Appearance.Description");
	mrp_SaveVariable(MyRolePlay.Profile[index].Appearance.CurrentEmotion, "Appearance.CurrentEmotion");

	local tempHistory = MyRolePlay.Profile[index].Lore.History1 .. MyRolePlay.Profile[index].Lore.History2 .. MyRolePlay.Profile[index].Lore.History3 .. MyRolePlay.Profile[index].Lore.History4 .. MyRolePlay.Profile[index].Lore.History5 .. MyRolePlay.Profile[index].Lore.History6;
	mrp_SaveVariable(tempHistory, "Lore.History");
	mrp_SaveVariable(MyRolePlay.Profile[index].Lore.Motto, "Lore.Motto");
	mrp_SaveVariable(MyRolePlay.Profile[index].Lore.Homecity, "Lore.Homecity");
	mrp_SaveVariable(MyRolePlay.Profile[index].Lore.Birthcity, "Lore.Birthcity");

	mrpProfileDropDownHandler();
end

function mrpViewTargetCharacterSheet()
	if (mrpCharacterSheet1Main:IsShown()) then
		mrpCharacterSheet1Main:Hide();
	else
	
		if (not UnitExists("target")) then
				mrpDisplayMessage(MRP_LOCALE_CHARACTER_SHEET_NO_TARGET);
		elseif (mrpUser(UnitName("target"))) then
			if (MyRolePlay.Settings.CharacterSheet == 0) then
				mrpDisplayMessage(MRP_LOCALE_CHARACTER_SHEET_MRP_USER);
				mrpCharacterSheet1Main:Show();

			else
				mrpDisplayMessage(MRP_LOCALE_CHARACTER_SHEET_STYLE_UNAVAILABLE);
				mrpDisplayMessage(MRP_LOCALE_CHARACTER_SHEET_STYLE_UNAVAILABLE_CHOOSE);
				mrpCharacterSheet1Main:Show();
			end
		elseif (mrpFlagRSPUser(UnitName("target"))) then
			if (MyRolePlay.Settings.CharacterSheet == 0) then
				mrpCharacterSheet1Main:Show();
				mrpDisplayMessage(MRP_LOCALE_CHARACTER_SHEET_RSP_USER);
	
			else
				mrpDisplayMessage(MRP_LOCALE_CHARACTER_SHEET_STYLE_UNAVAILABLE);
				mrpDisplayMessage(MRP_LOCALE_CHARACTER_SHEET_STYLE_UNAVAILABLE_CHOOSE);
			end
		else
			mrpDisplayMessage(MRP_LOCALE_CHARACTER_SHEET_NOT_VALID_TARGET);
		end
	end
end

function mrpUser(name)
	for j = 1, table.getn(mrpPlayerList) do
		if (mrpPlayerList[j].CharacterName == name) then
			return true;
		end
	end
	return false;
end

function mrpFlagRSPUser(name)
	for j = 1, table.getn(mrpFlagRSPPlayerList) do
		if (mrpFlagRSPPlayerList[j].CharacterName == name) then
			return true;
		end		
	end
	return false;
end


mrpUnitPopup_OnClick = UnitPopup_OnClick;

function UnitPopup_OnClick()
	local index = this.value;
	local dropdownFrame = getglobal(UIDROPDOWNMENU_INIT_MENU);
	local button = UnitPopupMenus[this.owner][index];
	local unit = dropdownFrame.unit;
	local name = dropdownFrame.name;

	if (button == "MRP_CHARACTER_SHEET") then
		for i = 1, table.getn(mrpPlayerList) do
			if (mrpPlayerList[i] == UnitName("target")) then
				mrpViewTargetCharacterSheet();
				break;
			end
		end		
	end

	mrpUnitPopup_OnClick();
end

function mrpConvertEditInformation(text)
	text = string.gsub(text, "\n", "\r");
	--text = string.gsub(text, "%%", "|p");

	return (text);
end

function mrpButtonIconDraggingFrameOnUpdate(arg1)
	local xpos, ypos = GetCursorPosition();
	local xmin, ymin = Minimap:GetLeft(), Minimap:GetBottom();

	xpos = xmin - xpos / UIParent:GetScale() + 70;
	ypos = ypos / UIParent:GetScale() - ymin - 70;

	mrpIconPos = math.deg(math.atan2(ypos, xpos));
	mrpMoveIcon();
end

function mrpButtonIconFrameOnClick(arg1)

	if arg1 == "LeftButton" and mrplocked == 0 then
		mrpLocked = 1;
		mrpViewTargetCharacterSheet();
	elseif arg1 == "LeftButton" then
		mrpLocked = 0;
		mrpViewTargetCharacterSheet();	
	end
end

-- moves the minimap icon to last position in settings or default angle of 45
function mrpMoveIcon()
	mrpButtonIconFrame:SetPoint("CENTER", "TargetFrame", "CENTER", 65, 30);
end

function mrpIsPlayerInMRP(target)
	-- Checks to see if target has MyRolePlay
	if (mrpInitialized ~= 1) then
		return (nil);
	end

	local mrpPlayerIndex = nil;

	for i = 1, table.getn(mrpPlayerList) do
		if (mrpPlayerList[i].CharacterName == UnitName(target)) then
			mrpPlayerIndex = i;
			break;
		end
	end

	return (mrpPlayerIndex);
end

function mrpIsPlayerInFlagRSP(target)
	-- Checks to see if target has FlagRSP
	if (mrpInitialized ~= 1) then
		return (nil);
	end

	local mrpFlagRSPPlayerIndex = nil;

	for i = 1, table.getn(mrpFlagRSPPlayerList) do
		if (mrpFlagRSPPlayerList[i].CharacterName == UnitName(target)) then
			mrpFlagRSPPlayerIndex = i;
			break;
		end
	end

	return (mrpFlagRSPPlayerIndex);
end

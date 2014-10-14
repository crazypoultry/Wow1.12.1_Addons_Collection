-- MetaGuild
-- Written by MetaHawk aka Urshurak

MG_TOC = 11100;
MG_VERSION = MG_TOC.."-"..2;
MG_NAME = "MetaGuild";
MG_HEADER = MG_NAME.." v"..MG_VERSION;
MG_IMAGE_PATH = "Interface\\AddOns\\MetaGuild\\Images\\"
MG_ICON = MG_IMAGE_PATH.."Button"

-- Constants
MG_GUILDMEMBERS_TO_DISPLAY = 21;
MG_RAID_TO_DISPLAY = 21;
MG_DKP_TO_DISPLAY = 21;
MG_FRAME_HEIGHT = 16;
MG_BUTTON_SIZE=16;
BINDING_NAME_MetaGuild = "Toggle MetaGuild";
BINDING_HEADER_MetaGuild = "MetaGuild";

--Tables
MG_Options = {};
MG_GuildList = {};
MG_RaidList = {};
MG_DKPList = nil;
MG_OnlineCount = {};
MG_RaidCount = {};
MG_CheckedCount = {};
MG_HighRolls = {};

--Variables
MG_Faction = "Horde";
MG_Tolerance = 0;
MG_Window_Open = 0;
MG_ButtonMenu_Count = 0;
MG_Options_Visible = 0;
MG_currentRankIndex = nil;
MG_RaidStats_Visible = 0;
MG_SetRaid_Visible = 0;
MG_SetRaid_Event_Visible = 0;
MG_Raid_Current = 0;
MG_Raid_Event_Current = 0;
MG_MemberDKP_Visible = 0;
MG_ShowDKPRaidMembers = false;
MG_RaidRoll_Visible = 0;
MG_SortType = "Name";
MG_ReverseSort = 0;
MG_DKP_SortType = "Name";
MG_DKP_ReverseSort = 0;
MG_SetRaid_Event_Timer = 0;
MG_BroadCast = 0;
MG_BroadcastTimer = 0;
MG_Broadcast_Message = 1;
MG_Channel = "Guild";
MG_invite = 0;
MG_invitecounter = 0;
MG_invitetime = 0;
MG_ChatFrame = nil;
MG_DKPDetached = 0;
MG_RollKeyWord = "MGroll";
MG_RollInProgress = 0;
MG_currentItemlink = nil;
MG_currentItemslot = nil;
MG_CurrentDKPvalue = nil;
MG_CurrentWinner = nil;
MG_RaidStarted = 0;
MG_UseDKPRoll = false;

MG_ButtonListIndex = {};
MG_ShowOfflineMembers = 0;
MG_ShowMembersInRaid = 0;
MG_Variables_Loaded = 0;
MG_NumOnline = 0;
MG_TotalNumGuildMembers = 1;
MG_NumGuildMembersToDisplay = 0;
MG_NumAlts = 0;
MG_PublicToggle = "Rank";
MG_PrivateToggle = 1;
MG_RaidClassDisplay = "none";
MG_SendTellOnInvite = 1;

MG_OnlineCount = {
	["Warrior"] = 0,
	["Mage"] = 0,
	["Druid"] = 0,
	["Warlock"] = 0,
	["Shaman"] = 0,
	["Paladin"] = 0,
	["Hunter"] = 0,
	["Rogue"] = 0,
	["Priest"] = 0,
	["Total"] = 0
};

MG_RaidCount = {
	["Warrior"] = 0,
	["Mage"] = 0,
	["Druid"] = 0,
	["Warlock"] = 0,
	["Shaman"] = 0,
	["Paladin"] = 0,
	["Hunter"] = 0,
	["Rogue"] = 0,
	["Priest"] = 0,
	["Total"] = 0
};

MG_CheckedCount = {
	["Warrior"] = 0,
	["Mage"] = 0,
	["Druid"] = 0,
	["Warlock"] = 0,
	["Shaman"] = 0,
	["Paladin"] = 0,
	["Hunter"] = 0,
	["Rogue"] = 0,
	["Priest"] = 0,
	["Total"] = 0
};

MG_InviteCount = {
	["Warrior"] = 0,
	["Mage"] = 0,
	["Druid"] = 0,
	["Warlock"] = 0,
	["Shaman"] = 0,
	["Paladin"] = 0,
	["Hunter"] = 0,
	["Rogue"] = 0,
	["Priest"] = 0,
	["Total"] = 0
};

function MG_OnLoad()
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("GUILD_ROSTER_UPDATE");
	this:RegisterEvent("PLAYER_GUILD_UPDATE");
	this:RegisterEvent("WHO_LIST_UPDATE");
	tinsert(UISpecialFrames,"MetaGuild");
	MG_Repair();
	MG_Print(MG_HEADER.." Loaded!");
	if (IsAddOnLoaded("FuBar")) then
		MG_FuBar_OnLoad();
	end
end

------------------------------------------
-- RaidStats Panel Load
------------------------------------------
function MG_RaidStats_OnLoad()
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("PARTY_MEMBERS_CHANGED");
	this:RegisterEvent("PARTY_LEADER_CHANGED");
	this:RegisterEvent("RAID_ROSTER_UPDATE");
end

------------------------------------------
-- Raid Event Panel Load
------------------------------------------
function MetaGuild_SetRaid_Event_OnLoad()
	this:RegisterEvent("CHAT_MSG_CHANNEL");
	this:RegisterEvent("CHAT_MSG_WHISPER");
end

------------------------------------------
-- DKP Panel Load
------------------------------------------
function MetaGuild_MemberDKP_OnLoad()
	this:RegisterEvent("LOOT_OPENED");
	this:RegisterEvent("LOOT_CLOSED");
	this:RegisterEvent("LOOT_SLOT_CLEARED");
--	this:RegisterEvent("CHAT_MSG_SAY");
end

------------------------------------------
--Called by the UI when an event we've registered for occurs.
------------------------------------------
function MG_OnEvent()
	if(event == "VARIABLES_LOADED") then
		MG_Variables_Loaded = 1;
		MG_NewFields();
		MG_UpdateMemberTable();
		MG_Init_Columns();
		if(MG_Options.LootLevel == nil) then MG_Options.LootLevel = 1; end
		if(MG_Options.AnnounceLevel == nil) then MG_Options.AnnounceLevel = 1; end
		if(MG_Options.UseGMroll == nil) then MG_Options.UseGMroll = false; end
		if(MG_Options.MiniButton == nil) then MG_Options.MiniButton = true; end
		if(MG_Options.MenuOnClick == nil) then MG_Options.MenuOnClick = false; end
		if(MG_Options.MinimapArcOffset == nil) then MG_Options.MinimapArcOffset = 235; end
		if(MG_Options.StatsLevel == nil) then MG_Options.StatsLevel = 50; end
		MG_ArcSlider:SetValue(MG_Options.MinimapArcOffset);
		MG_MenuClickCheck:SetChecked(MG_Options.MenuOnClick);
		MG_UseGMrollCheck:SetChecked(MG_Options.UseGMroll);
		MG_UpdateMinimapIcon();
		MG_Update();
	end

	if(event == "GUILD_ROSTER_UPDATE" or event == "PLAYER_GUILD_UPDATE" or event == "PLAYER_ENTERING_WORLD") then
		if (MG_Window_Open == 1 or MG_BroadCast == 1) then
			if (GetNumRaidMembers() == 0) then
				MG_Reset_InRaid();
			else		
				MG_Update_InRaid_All();
			end
			GuildRoster();
			MG_UpdateMemberTable();
			MG_Update();
		end
	end

	if (event == "RAID_ROSTER_UPDATE") then
		if (MG_Window_Open == 1 or MG_BroadCast == 1) then
			if (GetNumRaidMembers() == 0) then
				MG_Reset_InRaid();
			else		
				MG_Update_InRaid_All();
			end
			MG_Update();
		end
	end
end

function MG_RaidRoll_OnEvent()
	local MG_lootMethod, MG_masterLooter = GetLootMethod();

	if(event == "LOOT_OPENED") then
		if(MG_lootMethod == "master" and MG_masterLooter == 0 and GetNumLootItems() > 0) then
			MG_AnnounceLoot();
			UIDropDownMenu_ClearAll(MG_DropDownLootList);
			UIDropDownMenu_Initialize(MG_DropDownLootList, MG_LootListAdd);
		end
	end	

	if(event == "LOOT_SLOT_CLEARED") then
		if(MG_lootMethod == "master" and MG_masterLooter == 0) then
			UIDropDownMenu_ClearAll(MG_DropDownLootList);
			UIDropDownMenu_Initialize(MG_DropDownLootList, MG_LootListAdd);
		end
	end

	if(event == "LOOT_CLOSED") then
		UIDropDownMenu_ClearAll(MG_DropDownLootList);
	end
end

function MG_ClassLang(className)
  if(className == MG_DRUID_TITLE) then
    className = "DRUID";
  elseif(className == MG_HUNTER_TITLE) then
    className = "HUNTER";
  elseif(className == MG_MAGE_TITLE) then
    className = "MAGE";
  elseif(className == MG_PALADIN_TITLE) then
    className = "PALADIN";
  elseif(className == MG_PRIEST_TITLE) then
    className = "PRIEST";
  elseif(className == MG_ROGUE_TITLE) then
    className = "ROGUE";
  elseif(className == MG_SHAMAN_TITLE) then
    className = "SHAMAN";
  elseif(className == MG_WARLOCK_TITLE) then
    className = "WARLOCK";
  elseif(className == MG_WARRIOR_TITLE) then
    className = "WARRIOR";
  end
  return className;
end

------------------------------------------
-- RaidStats Events, only fired when player enters the world
------------------------------------------
function MG_RaidStats_OnEvent()

	MG_Faction = UnitFactionGroup("player");
	getglobal("MG_RaidButton1RaidClass"):SetText(MG_WARRIOR_TITLE);
	getglobal("MG_RaidButton2RaidClass"):SetText(MG_MAGE_TITLE);
	getglobal("MG_RaidButton3RaidClass"):SetText(MG_WARLOCK_TITLE);
	getglobal("MG_RaidButton4RaidClass"):SetText(MG_HUNTER_TITLE);
	getglobal("MG_RaidButton5RaidClass"):SetText(MG_ROGUE_TITLE);
	if (MG_Faction=="Horde") then
		getglobal("MG_RaidButton6RaidClass"):SetText(MG_SHAMAN_TITLE);
	else
		getglobal("MG_RaidButton6RaidClass"):SetText(MG_PALADIN_TITLE);
	end
	getglobal("MG_RaidButton7RaidClass"):SetText(MG_DRUID_TITLE);
	getglobal("MG_RaidButton8RaidClass"):SetText(MG_PRIEST_TITLE);
	
	local color;
	color = RAID_CLASS_COLORS["WARRIOR"];
	getglobal("MG_RaidButton1RaidClass"):SetTextColor(color.r, color.g, color.b);
	getglobal("MG_RaidButton1RaidOnline"):SetTextColor(color.r, color.g, color.b);
	getglobal("MG_RaidButton1RaidInRaid"):SetTextColor(color.r, color.g, color.b);
	getglobal("MG_RaidButton1CheckCount"):SetTextColor(color.r, color.g, color.b);
	getglobal("MG_RaidButton1RaidTotals"):SetTextColor(color.r, color.g, color.b);
	getglobal("MG_MiniClass1Text"):SetTextColor(color.r, color.g, color.b);
	getglobal("MG_Warrior_EventTitle"):SetTextColor(color.r, color.g, color.b);
	color = RAID_CLASS_COLORS["MAGE"];
	getglobal("MG_RaidButton2RaidClass"):SetTextColor(color.r, color.g, color.b);
	getglobal("MG_RaidButton2RaidOnline"):SetTextColor(color.r, color.g, color.b);
	getglobal("MG_RaidButton2RaidInRaid"):SetTextColor(color.r, color.g, color.b);
	getglobal("MG_RaidButton2CheckCount"):SetTextColor(color.r, color.g, color.b);
	getglobal("MG_RaidButton2RaidTotals"):SetTextColor(color.r, color.g, color.b);
	getglobal("MG_MiniClass2Text"):SetTextColor(color.r, color.g, color.b);
	getglobal("MG_Mage_EventTitle"):SetTextColor(color.r, color.g, color.b);
	color = RAID_CLASS_COLORS["WARLOCK"];
	getglobal("MG_RaidButton3RaidClass"):SetTextColor(color.r, color.g, color.b);
	getglobal("MG_RaidButton3RaidOnline"):SetTextColor(color.r, color.g, color.b);
	getglobal("MG_RaidButton3RaidInRaid"):SetTextColor(color.r, color.g, color.b);
	getglobal("MG_RaidButton3CheckCount"):SetTextColor(color.r, color.g, color.b);
	getglobal("MG_RaidButton3RaidTotals"):SetTextColor(color.r, color.g, color.b);
	getglobal("MG_MiniClass3Text"):SetTextColor(color.r, color.g, color.b);
	getglobal("MG_Warlock_EventTitle"):SetTextColor(color.r, color.g, color.b);
	color = RAID_CLASS_COLORS["HUNTER"];
	getglobal("MG_RaidButton4RaidClass"):SetTextColor(color.r, color.g, color.b);
	getglobal("MG_RaidButton4RaidOnline"):SetTextColor(color.r, color.g, color.b);
	getglobal("MG_RaidButton4RaidInRaid"):SetTextColor(color.r, color.g, color.b);
	getglobal("MG_RaidButton4CheckCount"):SetTextColor(color.r, color.g, color.b);
	getglobal("MG_RaidButton4RaidTotals"):SetTextColor(color.r, color.g, color.b);
	getglobal("MG_MiniClass4Text"):SetTextColor(color.r, color.g, color.b);
	getglobal("MG_Hunter_EventTitle"):SetTextColor(color.r, color.g, color.b);
	color = RAID_CLASS_COLORS["ROGUE"];
	getglobal("MG_RaidButton5RaidClass"):SetTextColor(color.r, color.g, color.b);
	getglobal("MG_RaidButton5RaidOnline"):SetTextColor(color.r, color.g, color.b);
	getglobal("MG_RaidButton5RaidInRaid"):SetTextColor(color.r, color.g, color.b);
	getglobal("MG_RaidButton5CheckCount"):SetTextColor(color.r, color.g, color.b);
	getglobal("MG_RaidButton5RaidTotals"):SetTextColor(color.r, color.g, color.b);
	getglobal("MG_MiniClass5Text"):SetTextColor(color.r, color.g, color.b);
	getglobal("MG_Rogue_EventTitle"):SetTextColor(color.r, color.g, color.b);
	
	if (MG_Faction=="Horde") then
		color = RAID_CLASS_COLORS["SHAMAN"];
		getglobal("MG_Paladin_EventTitle"):SetText(MG_SHAMAN_TITLE);
		getglobal("MG_Paladin_EventTitle"):SetTextColor(color.r, color.g, color.b);
	else
		color = RAID_CLASS_COLORS["PALADIN"];
		getglobal("MG_Paladin_EventTitle"):SetText(MG_PALADIN_TITLE);
		getglobal("MG_Paladin_EventTitle"):SetTextColor(color.r, color.g, color.b);
	end
	getglobal("MG_RaidButton6RaidClass"):SetTextColor(color.r, color.g, color.b);
	getglobal("MG_RaidButton6RaidOnline"):SetTextColor(color.r, color.g, color.b);
	getglobal("MG_RaidButton6RaidInRaid"):SetTextColor(color.r, color.g, color.b);
	getglobal("MG_RaidButton6CheckCount"):SetTextColor(color.r, color.g, color.b);
	getglobal("MG_RaidButton6RaidTotals"):SetTextColor(color.r, color.g, color.b);
	getglobal("MG_MiniClass6Text"):SetTextColor(color.r, color.g, color.b);
	color = RAID_CLASS_COLORS["DRUID"];
	getglobal("MG_RaidButton7RaidClass"):SetTextColor(color.r, color.g, color.b);
	getglobal("MG_RaidButton7RaidOnline"):SetTextColor(color.r, color.g, color.b);
	getglobal("MG_RaidButton7RaidInRaid"):SetTextColor(color.r, color.g, color.b);
	getglobal("MG_RaidButton7CheckCount"):SetTextColor(color.r, color.g, color.b);
	getglobal("MG_RaidButton7RaidTotals"):SetTextColor(color.r, color.g, color.b);
	getglobal("MG_MiniClass7Text"):SetTextColor(color.r, color.g, color.b);
	getglobal("MG_Druid_EventTitle"):SetTextColor(color.r, color.g, color.b);
	color = RAID_CLASS_COLORS["PRIEST"];
	getglobal("MG_RaidButton8RaidClass"):SetTextColor(color.r, color.g, color.b);
	getglobal("MG_RaidButton8RaidOnline"):SetTextColor(color.r, color.g, color.b);
	getglobal("MG_RaidButton8RaidInRaid"):SetTextColor(color.r, color.g, color.b);
	getglobal("MG_RaidButton8CheckCount"):SetTextColor(color.r, color.g, color.b);
	getglobal("MG_RaidButton8RaidTotals"):SetTextColor(color.r, color.g, color.b);
	getglobal("MG_MiniClass8Text"):SetTextColor(color.r, color.g, color.b);
	getglobal("MG_Priest_EventTitle"):SetTextColor(color.r, color.g, color.b);

end

---------------------------------------------------------------
-- Called when a guild member on the guild list is clicked.
---------------------------------------------------------------
function MG_Button_OnClick()
	local	id = this:GetID();
	local tmp_row = MG_ButtonListIndex[id];
	
	if ( IsShiftKeyDown() ) then
		if(MG_GuildList[tmp_row].f_checked == 0) then
			MG_Shift_Click(MG_GuildList[tmp_row].f_class, 1);
		else
			MG_Shift_Click(MG_GuildList[tmp_row].f_class, 0);
		end
	else
		if(MG_GuildList[tmp_row].f_checked == 0) then
			MG_GuildList[tmp_row].f_checked = 1;
	
			MG_GuildList[tmp_row].f_expand = 1;
			local i = 1;
			local tmp_target = MG_FindRowByAssc(MG_GuildList[tmp_row].f_id, i)
			while( (i < 100) and (tmp_target > 0) ) do
				MG_GuildList[tmp_target].f_checked = 1;
				i = i + 1;
				tmp_target = MG_FindRowByAssc(MG_GuildList[tmp_row].f_id, i);
			end
		else
			MG_GuildList[tmp_row].f_checked = 0;
	
			MG_GuildList[tmp_row].f_expand = 0;
			local i = 1;
			local tmp_target = MG_FindRowByAssc(MG_GuildList[tmp_row].f_id, i)
			while( (i < 100) and (tmp_target > 0) ) do
				MG_GuildList[tmp_target].f_checked = 0;
				i = i + 1;
				tmp_target = MG_FindRowByAssc(MG_GuildList[tmp_row].f_id, i);
			end
		end
	end
	MG_UpdateCount();
	MG_Update();
end

-----------------------------------------------------------------------
--Shift Click handler for main window.  Select/Deslect by class
-----------------------------------------------------------------------
function MG_Shift_Click(sc_class, sc_value)
	if(MG_ShowOfflineMembers == 1) then
		for i=1, table.getn(MG_GuildList),1 do
			if (MG_GuildList[i].f_class == sc_class) then
				MG_GuildList[i].f_checked = sc_value;
			end
		end
	else
		for i=1, table.getn(MG_GuildList),1 do
			if ((MG_GuildList[i].f_class == sc_class) and (MG_GuildList[i].f_online == 1)) then
				MG_GuildList[i].f_checked = sc_value;
				
			end
		end
	end
end

-----------------------------------------------------------------------
--Executed when main window is shown to the user
-----------------------------------------------------------------------
function MG_OnShow()
	MG_Window_Open = 1;
	MG_SetAllOffline();
	ClearChecks();
	SetGuildRosterSelection(0);
	SetGuildRosterShowOffline(1);
	GuildRoster();
	MG_UpdateMemberTable();
	if (MG_RaidStats_Visible == 1) then
		MetaGuild_RaidStats:Show();
	elseif (MG_SetRaid_Visible == 1) then
	
	elseif (MG_SetRaid_Event_Visible == 1) then
	
	end
end

----------------------------------------------------------------------------------
---Updates the MG_GuildList table. Checks the guild roster and adds any non existing entries.
----------------------------------------------------------------------------------
function MG_UpdateMemberTable()
	if (MG_Variables_Loaded == 0) then
		return;
	end
	
	local MG_numGuildMembers = GetNumGuildMembers();
	local MG_name, MG_rank, MG_rankIndex, MG_level, MG_class, MG_zone, MG_note, MG_pnote, MG_officernote, MG_online;
	local MG_guildName, MG_GuildRankName, MG_guildRankIndex = GetGuildInfo("player");
	local MG_maxRankIndex = GuildControlGetNumRanks() - 1;
	local MG_guildOffset = FauxScrollFrame_GetOffset(MG_ScrollFrame);
	local MG_guildIndex;
	local MG_row;
	local MG_new_entry;
	
	--Reset the online count
	MG_NumOnline = 0;
	
	for i=1,MG_numGuildMembers, 1 do
		MG_guildIndex = i;
		MG_name, MG_rank, MG_rankIndex, MG_level, MG_class, MG_zone, MG_note, MG_officernote, MG_online = GetGuildRosterInfo(MG_guildIndex);
		--Returns 0 if Entry does not exist already.
		MG_row = MG_CheckForEntry(MG_name);
		if(MG_online == 1) then
			MG_NumOnline = MG_NumOnline + 1;
		end

		if (MG_row > 0) then
			--If entry exists in our stored table then update the data.
			MG_GuildList[MG_row].f_inGuild = 1;
			MG_GuildList[MG_row].f_rank = MG_rank;
			MG_GuildList[MG_row].f_rankIndex = MG_rankIndex;
			MG_GuildList[MG_row].f_lvl = MG_level;
			MG_GuildList[MG_row].f_class = MG_class;
			MG_GuildList[MG_row].f_zone = MG_zone;
			MG_GuildList[MG_row].f_note = MG_note;
			MG_GuildList[MG_row].f_officernote = MG_officernote;
			MG_GuildList[MG_row].f_online = MG_online;
			MG_GuildList[MG_row].f_guild = MG_guildName;

			if(MG_GuildList[MG_row].f_checked == nil) then
				MG_GuildList[MG_row].f_checked = 0;
			end
			if(MG_GuildList[MG_row].f_expand == nil) then
				MG_GuildList[MG_row].f_expand = 0;
			end
			if(MG_GuildList[MG_row].f_id == 0) then
				MG_GuildList[MG_row].f_id = MG_FindNextID();
			end
			if(MG_GuildList[MG_row].f_alt == nil) then
				MG_GuildList[MG_row].f_alt = " ";
			end

		 MG_GuildList[MG_row].f_inRaid = MG_Is_InRaid(MG_name);
			
		else
			--Else it's a new entry so add a new row.
			MG_new_entry = {f_name = MG_name, f_rank = MG_rank, f_rankIndex = MG_rankIndex, f_lvl = MG_level, f_class = MG_class, f_zone = MG_zone, f_group = 0, f_note = MG_note, f_officernote = MG_officernote, f_online = MG_online, f_p_note = " ",f_guild = MG_guildName, f_assc = 0, f_id = MG_FindNextID(), f_checked = 0, f_expand = 0, f_alt = " ", f_inGuild = 1, f_inRaid = 0};
			table.insert(MG_GuildList,MG_new_entry);
--			MG_Print("Adding - "..MG_name)
		end
		
	end
	--Update global counts.
	MG_UpdateCount();
end

---------------------------------------------------------------------------
---Updates the main display with all data from MG_GuildList.
---------------------------------------------------------------------------
function MG_Update()
	local MG_name, MG_rank, MG_rankIndex, MG_level, MG_class, MG_zone, MG_note, MG_pnote, MG_officernote, MG_p_note, MG_online;
	name, rank, rankIndex, level, class, zone, group, note, officernote, online = GetGuildRosterInfo(GetGuildRosterSelection());
	local MG_guildName, MG_GuildRankName, MG_guildRankIndex = GetGuildInfo("player"); 		--Pull the current players guild info.
	local MG_maxRankIndex = GuildControlGetNumRanks() - 1;
	local MG_input_offset = FauxScrollFrame_GetOffset(MG_ScrollFrame);
	local MG_guildOffset = MG_CalculateOffset(MG_input_offset);
	local MG_guildIndex = 0;
	local MG_showScrollBar = nil;
	local MG_WrongGuild = 0;
	local MG_MembersDisplayed = 0;
	MG_NonPrimary = 0;
	local MG_guildcounter = 0;
	local color
	
	for i=1, MG_GUILDMEMBERS_TO_DISPLAY, 1 do
		MG_guildIndex = MG_guildIndex + 1;
		local MG_member = MG_GuildList[MG_guildIndex];
		MG_button = getglobal("MG_Button"..i);
		MG_button.guildIndex = MG_guildIndex;
			
		if(MG_member) then
			if(MG_GuildList[MG_guildIndex].f_guild == MG_guildName) then
				if(MG_ShowOfflineMembers == 1) then
					MG_guildcounter = MG_guildcounter + 1;
				else
					if(MG_member.f_online == 1) then
						MG_guildcounter = MG_guildcounter + 1;
					end
				end
										
				if(MG_guildcounter > MG_guildOffset) then
					if( ((MG_ShowMembersInRaid == 1) or (MG_GuildList[MG_guildIndex].f_inRaid == 0)) and ( (MG_GuildList[MG_guildIndex].f_online) or (MG_ShowOfflineMembers == 1)) ) then
						MG_button:Show();
						MG_RenderButtons((MG_button:GetID()),MG_member.f_expand,MG_member.f_checked,MG_guildIndex);
						if((MG_FindRowByAssc(MG_GuildList[MG_guildIndex].f_id, 1)) > 0) then
							getglobal("MG_ExpandButton"..MG_button:GetID()):Show();
						else
							getglobal("MG_ExpandButton"..MG_button:GetID()):Hide();
						end
	
						MG_ButtonListIndex[i] = MG_guildIndex;
	
						getglobal("MG_Button"..i.."Name"):SetText(MG_member.f_name);					
						getglobal("MG_Button"..i.."Lvl"):SetText(MG_member.f_lvl);
						getglobal("MG_Button"..i.."Class"):SetText(MG_member.f_class);
						getglobal("MG_Button"..i.."Zone"):SetText(MG_member.f_zone);
						if(MG_PublicToggle == "Rank") then
							getglobal("MG_Button"..i.."Note"):SetText(MG_member.f_rank);
						elseif(MG_PublicToggle == "Officer") then
							getglobal("MG_Button"..i.."Note"):SetText(MG_member.f_officernote);
						elseif(MG_PublicToggle == "privNote") then
							getglobal("MG_Button"..i.."Note"):SetText(MG_member.f_p_note);
						else
							getglobal("MG_Button"..i.."Note"):SetText(MG_member.f_note)
						end
	
						if ( not MG_member.f_online ) then
							getglobal("MG_Button"..i.."Name"):SetTextColor(0.5, 0.5, 0.5);
							getglobal("MG_Button"..i.."Zone"):SetTextColor(0.5, 0.5, 0.5);
							getglobal("MG_Button"..i.."Lvl"):SetTextColor(0.5, 0.5, 0.5);
							getglobal("MG_Button"..i.."Class"):SetTextColor(0.5, 0.5, 0.5);
							getglobal("MG_Button"..i.."Note"):SetTextColor(0.5, 0.5, 0.5);
						else
							color = RAID_CLASS_COLORS[MG_ClassLang(MG_member.f_class)];
							getglobal("MG_Button"..i.."Name"):SetTextColor(color.r, color.g, color.b);
							getglobal("MG_Button"..i.."Zone"):SetTextColor(color.r, color.g, color.b);
							getglobal("MG_Button"..i.."Lvl"):SetTextColor(color.r, color.g, color.b);
							getglobal("MG_Button"..i.."Class"):SetTextColor(color.r, color.g, color.b);
							getglobal("MG_Button"..i.."Note"):SetTextColor(color.r, color.g, color.b);
						end
					else
						---Not a primary, decrement i so this iteration doesnt count. Increment non-primary count
						i = i - 1;
					end
				else
					--Either offline or a skipped online member, decrement i so this iteration doesnt count
					i = i - 1;
				end
			else
				if(MG_guildName == MG_member.f_guild) then
					table.remove(MG_GuildList, i);
				end
				i = i - 1;
			end
		else
			MG_button:Hide();
			t_id = MG_button:GetID();
			getglobal("MG_CheckButton"..t_id):Hide();
			getglobal("MG_ExpandButton"..t_id):Hide();
		end
	end
		
	MG_UpdateOnlineCounts();
	MG_UpdateRaidCounts();
	MG_UpdateCheckCounts();
	MG_UpdateRaidTotals();
	MG_RaidClassDisplay = "none";
	MG_Classlist();
	MG_FuBarUpdate();

	if(MG_ShowOfflineMembers == 0 and MG_ShowMembersInRaid == 0 and (MG_NumOnline-GetNumRaidMembers()) < MG_GUILDMEMBERS_TO_DISPLAY) then
		FauxScrollFrame_Update(MG_ScrollFrame, (MG_NumOnline-GetNumRaidMembers()), MG_GUILDMEMBERS_TO_DISPLAY, MG_FRAME_HEIGHT);
	else
		FauxScrollFrame_Update(MG_ScrollFrame, MG_NumGuildMembersToDisplay, MG_GUILDMEMBERS_TO_DISPLAY, MG_FRAME_HEIGHT);
	end
end

--------------------------------------------------------------
--Updates the check box and expand buttons depending on the settings on the person being displayed.
-------------------------------------------------------------
function MG_RenderButtons(render_id,render_expand,render_checked, render_row)
	getglobal("MG_CheckButton"..render_id):Show();

	if(render_checked == 1) then
		getglobal("MG_CheckButton"..render_id):SetChecked(1);
	else
		getglobal("MG_CheckButton"..render_id):SetChecked(0);
	end

	if(render_expand == 1) then
		getglobal("MG_ExpandButton"..render_id):SetChecked(1);
	else
		getglobal("MG_ExpandButton"..render_id):SetChecked(0);
	end
end

----------------------------------------
--Calculates actual FauxScrollFrame offset
-----------------------------------------
function MG_CalculateOffset(input_offset)
	local MG_guildName, MG_GuildRankName, MG_guildRankIndex = GetGuildInfo("player");                 --Pull the current players guildinfo.
	local s = table.getn(MG_GuildList);
	local i = 1;

	--Loop will iterate through the entire list or until input_offset decrements to 0
	while(input_offset > 0 and i <= s) do
		--Is evaluated row in the same guild and a primary?
		if(MG_GuildList[i].f_guild == MG_guildName and MG_GuildList[i].f_assc == 0) then
			--reset the number of alts for this row.
			local num_alts = 0;
			--If this is expanded it may have alts we need to take into account for the offset.
			if(MG_GuildList[i].f_expand > 0) then
				num_alts = MG_NumberOfAlts(MG_GuildList[i].f_id);
			end
			--I'd rather not end up with a negative number..
			--If we get here we need to return the current i. Because the offset puts us somewhere in this rows alts.
			if(num_alts > input_offset) then
				return i;
			else
				--Subtract the primary from the offset.
				input_offset = input_offset - 1;
				--And subtract the number of alts from the offset.
				input_offset = input_offset - num_alts;
			end
		end
		--Continue to the next row.
		i = i + 1;
	end
	--End of loop means we are done... need to decrement i to undo the last incrementation.
	i = i - 1;
	return i;
end

-----------------------------------------------------------------
--Updates global MG_NumOnline, MG_TotalNumGuildMembers,MG_NumGuildMembersToDisplay
--------------------------------------------------
function MG_UpdateCount()
	local MG_guildName, MG_GuildRankName, MG_guildRankIndex = GetGuildInfo("player");

	----------Reset globals to 0
	MG_NumOnline = 0;
	MG_TotalNumGuildMembers = 0;
	MG_NumGuildMembersToDisplay = 0;
	MG_NumAlts = 0;

	if(MG_guildName == nil) then
		MG_guildName = MG_GUILD_NONSTATUS;
	end
	
	----Iterate through the table.
	for p = 1, table.getn(MG_GuildList),1 do
		if(MG_GuildList[p].f_guild == nil) then
			table.remove(MG_GuildList, p);
			break;
		end
		if(MG_GuildList[p].f_guild == MG_guildName) then

			---A valid guild member.
			MG_TotalNumGuildMembers = MG_TotalNumGuildMembers + 1;

			--Also online
			if(MG_GuildList[p].f_online == 1) then
				MG_NumOnline = MG_NumOnline + 1;
			end

			if(MG_ShowOfflineMembers > 0) then
				MG_NumGuildMembersToDisplay = MG_NumGuildMembersToDisplay + 1;
			elseif(MG_GuildList[p].f_online == 1) then
				MG_NumGuildMembersToDisplay = MG_NumGuildMembersToDisplay + 1;
			end
		end
	end

	MG_Guild_Name:SetText(MG_GUILD_TEXT..MG_guildName);
	MG_Member_Totals:SetText(MG_GUILD_MEMBERS..MG_TotalNumGuildMembers.."       Online: "..MG_NumOnline);

	MG_NumGuildMembersToDisplay = MG_NumGuildMembersToDisplay + MG_Tolerance;
end

----------------------------------------------------------------------
-- Sets the Column Width for each column in the guild display.
----------------------------------------------------------------------
function MG_FrameColumn_SetWidth(width, frame)
	if ( not frame ) then
		frame = this;
	end
	frame:SetWidth(width);
	getglobal(frame:GetName().."Middle"):SetWidth(width - 9);
end

--------------------------------------------------------------------------------
---Checks guildtable to find out if an entry for that person already exists. Returns the saved table data if found.
--------------------------------------------------------------------------------
function MG_CheckForEntry(MG_Entry)
	local i = 1;
	while (i <= table.getn(MG_GuildList)) do
		if(MG_GuildList[i].f_name == MG_Entry) then
			return i;
		end
		i = i + 1;
	end
	return 0;
end

-------------------------------------------------------------------------------
--Finds a given (in case of multiple only returns the first) assc in the GuildList table by assc and returns the row. 0 for not found.
-------------------------------------------------------------------------------
function MG_FindRowByAssc(tmp_assc, count)
	if(count == nil) then
		count = 1;
	end

	local z_count = 1;
	for i=1, table.getn(MG_GuildList),1 do
		if(MG_GuildList[i].f_assc == tmp_assc) then
			if(z_count == count) then
				return i;
			else
				z_count = z_count + 1;
			end
		end
	end
	----Didn't find that assc.
	return 0;
end

----------------------------------------------------------
---Created specifically to add new fields after a version update.
-----------------------------------
function MG_NewFields()
	for i=1, table.getn(MG_GuildList),1 do
		if(MG_GuildList[i].f_alt == nil) then
		 MG_GuildList[i].f_alt = " ";
		end
		MG_GuildList[i].f_inGuild = 0;
	end
end

-------------------
--Corrects certain corrupt data in the SavedVariables.lua file
--------------------
function MG_Repair()
	local size = table.getn(MG_GuildList);
	for i=1, size,1 do
		if(MG_GuildList[i].f_alt == nil) then
			MG_GuildList[i].f_alt = " ";
		end
		if(MG_GuildList[i].f_name == nil) then
			MG_GuildList[i].f_name = " ";
		end
		if(MG_GuildList[i].f_rank == nil) then
			MG_GuildList[i].f_rank = " ";
		end
		if(MG_GuildList[i].f_rankIndex == nil) then
			MG_GuildList[i].f_rankIndex = " ";
		end
		if(MG_GuildList[i].f_lvl == nil) then
			MG_GuildList[i].f_lvl = " ";
		end
		if(MG_GuildList[i].f_class == nil) then
			MG_GuildList[i].f_class = " ";
		end
		if(MG_GuildList[i].f_zone == nil) then
			MG_GuildList[i].f_zone= " ";
		end
		if(MG_GuildList[i].f_group == nil) then
			MG_GuildList[i].f_group= " ";
		end
		if(MG_GuildList[i].f_note == nil) then
			MG_GuildList[i].f_note= " ";
		end
		if(MG_GuildList[i].f_officernote == nil) then
			MG_GuildList[i].f_officernote= " ";
		end
		if(MG_GuildList[i].f_guild == nil) then	
			MG_GuildList[i].f_guild = " ";
		end
		if(MG_GuildList[i].f_expand == nil) then	
			MG_GuildList[i].f_expand = " ";
		end
		if(MG_GuildList[i].f_id == nil) then
			MG_GuildList[i].f_id = " ";
		end
		if(MG_GuildList[i].f_dkp == nil) then
			MG_GuildList[i].f_dkp = 0;
		end
		if(MG_GuildList[i].f_invited == nil) then
			MG_GuildList[i].f_invited = 0;
		end
	end
end

-------------------
--Initializes the last 2 columns since they can vary.
------------
function MG_Init_Columns()
	if(MG_PublicToggle == "Rank") then
		MG_FrameColumnHeader6:SetText(MG_COLUMN_TEXT5);
	elseif(MG_PublicToggle == "Officer") then
		MG_FrameColumnHeader6:SetText(MG_COLUMN_TEXT13);
	elseif(MG_PublicToggle == "Note") then
		MG_FrameColumnHeader6:SetText(MG_COLUMN_TEXT15);
	else
		MG_FrameColumnHeader6:SetText(MG_COLUMN_TEXT14);
	end
end

---------------------------------------------------------------
---Returns the number of entries that are associated to MG_id
------------------------------------------------------------
function MG_NumberOfAlts(MG_id)
	local num_found = 0;

	--Scan the table for entries with that association.
	for p = 1, table.getn(MG_GuildList),1 do
		if(MG_GuildList[p].f_assc == MG_id) then
			num_found = num_found + 1;
		end
	end
	return num_found;
end

------------------------------------------------
-----Finds the next available ID
-----------------------------------------------
function MG_FindNextID()
	local highest_id = 0;
	for i = 1,table.getn(MG_GuildList),1 do
		if(MG_GuildList[i].f_id > highest_id) then
			highest_id = MG_GuildList[i].f_id;
		end
	end
	highest_id = highest_id + 1;
	return highest_id;
end

----------------------------------------------------------------------------
-- Sets all members as offline.
-------------------------------------------------------------
function MG_SetAllOffline()
	for i=1, table.getn(MG_GuildList),1 do
		MG_GuildList[i].f_online = nil;
	end
end

-----------------------------------------------------------------
--Clears all checkmarks.
------------------------------------------------------------------
function ClearChecks()

	for i = 1, MG_GUILDMEMBERS_TO_DISPLAY, 1 do
		getglobal("MG_CheckButton"..i):SetChecked(False);
	end
	for i = 1, table.getn(MG_GuildList), 1 do
		MG_GuildList[i].f_checked = 0;
	end

end

--------------------------------------------------------------------
--Toggle showoffline members.
--------------------------------------------------------------------
function MG_ShowOffline()
	if( this:GetChecked()) then
		MG_ShowOfflineMembers = 1;
		MG_UpdateCount();
		MG_Update();
	else
		MG_ShowOfflineMembers = 0;
		MG_UpdateCount();
--		FauxScrollFrame_Update(MG_ScrollFrame, 1, MG_GUILDMEMBERS_TO_DISPLAY, MG_FRAME_HEIGHT);
		MG_Update();
	end
end

--------------------------------------------------------------------
--Toggle Show Members In Raid
--------------------------------------------------------------------
function MG_ShowRaidMembers()
	if( this:GetChecked()) then
		MG_ShowMembersInRaid = 1;
		MG_UpdateCount();
--		FauxScrollFrame_Update(MG_ScrollFrame, 1, MG_GUILDMEMBERS_TO_DISPLAY, MG_FRAME_HEIGHT);
		MG_Update();
	else
		MG_ShowMembersInRaid = 0;
		MG_UpdateCount();
--		FauxScrollFrame_Update(MG_ScrollFrame, 1, MG_GUILDMEMBERS_TO_DISPLAY, MG_FRAME_HEIGHT);
		MG_Update();
	end
end

--------------------------------------------------------------------------
--- This function will sort the guild list and Update the view.
---------------------------------------------------------------
function MG_Sort()
	if(MG_GuildList) then
		MG_Repair();
		table.sort(MG_GuildList, MG_Predicate);
	end
	MG_Update();
end

function MG_Predicate(lhs, rhs)
	if (lhs == nil) then
		if (rhs == nil) then
			return false;
		else
			return true;
		end
	elseif (rhs == nil) then
		return false;
	end

	if(MG_ReverseSort == 0) then
		if(MG_SortType == "Name") then
			if(lhs.f_name < rhs.f_name) then
				return true;
			elseif (rhs.f_name < lhs.f_name) then
				return false;
			end
		elseif(MG_SortType == "Alts") then
			if(lhs.f_alt < rhs.f_alt) then
				return true;
			elseif (rhs.f_alt < lhs.f_alt) then
				 return false;
			end
		elseif(MG_SortType == "Lvl") then
			if(lhs.f_lvl < rhs.f_lvl) then
				return true;
			elseif (rhs.f_lvl < lhs.f_lvl) then
				return false;
			end
		elseif(MG_SortType  == "Class") then
			if(lhs.f_class < rhs.f_class) then
				return true;
			elseif (rhs.f_class < lhs.f_class) then
				return false;
			end
		elseif(MG_SortType  == "Zone") then
			if(lhs.f_zone < rhs.f_zone) then
				return true;
			elseif (rhs.f_zone < lhs.f_zone) then
				return false;
			end
		elseif(MG_SortType  == "Note") then
			if(lhs.f_note < rhs.f_note) then
				return true;
			elseif (rhs.f_note < lhs.f_note) then
				return false;
			end
		elseif(MG_SortType  == "PNote") then
			if(lhs.f_p_note < rhs.f_p_note) then
				return true;
			elseif (rhs.f_p_note < lhs.f_p_note) then
				return false;
			end
		elseif(MG_SortType  == "Rank") then
			if(lhs.f_rank < rhs.f_rank) then
				return true;
			elseif (rhs.f_rank < lhs.f_rank) then
				return false;
			end
		elseif(MG_SortType  == "Officer") then
			if(lhs.f_officernote < rhs.f_officernote) then
				return true;
			elseif (rhs.f_officernote < lhs.f_officernote) then
				return false;
			end
		end

		if( not (MG_SortType == "Name") ) then
			if(lhs.f_name < rhs.f_name) then
				return true;
			elseif (rhs.f_name < lhs.f_name) then
				return false;
			end
		end

		if(not (MG_SortType  == "Lvl")) then
			if(lhs.f_lvl < rhs.f_lvl) then
				return true;
			elseif (rhs.f_lvl < lhs.f_lvl) then
				return false;
			end
		end
	end

	if(MG_ReverseSort > 0) then
		if(MG_SortType == "Name") then
			if(lhs.f_name > rhs.f_name) then
				return true;
			elseif (rhs.f_name > lhs.f_name) then
				return false;
			end
		elseif(MG_SortType == "Alts") then
			if(lhs.f_alt > rhs.f_alt) then
				return true;
			elseif (rhs.f_alt > lhs.f_alt) then
				return false;
			end
		elseif(MG_SortType == "Lvl") then
			if(lhs.f_lvl > rhs.f_lvl) then
				return true;
			elseif (rhs.f_lvl > lhs.f_lvl) then
				return false;
			end
		elseif(MG_SortType  == "Class") then
			if(lhs.f_class > rhs.f_class) then
				return true;
			elseif (rhs.f_class > lhs.f_class) then
				return false;
			end
		elseif(MG_SortType  == "Zone") then
			if(lhs.f_zone > rhs.f_zone) then
				return true;
			elseif (rhs.f_zone > lhs.f_zone) then
				return false;
			end
		elseif(MG_SortType  == "Note") then
			if(lhs.f_note > rhs.f_note) then
				return true;
			elseif (rhs.f_note > lhs.f_note) then
				return false;
			end
		elseif(MG_SortType  == "PNote") then
			if(lhs.f_p_note > rhs.f_p_note) then
				return true;
			elseif (rhs.f_p_note > lhs.f_p_note) then
				return false;
			end
		elseif(MG_SortType  == "Rank") then
			if(lhs.f_rank > rhs.f_rank) then
				return true;
			elseif (rhs.f_rank > lhs.f_rank) then
				return false;
			end
		elseif(MG_SortType  == "Officer") then
			if(lhs.f_officernote > rhs.f_officernote) then
				return true;
			elseif (rhs.f_officernote > lhs.f_officernote) then
				return false;
			end
		end

		if( not (MG_SortType == "Name") ) then	
			if(lhs.f_name > rhs.f_name) then
				return true;
			elseif (rhs.f_name > lhs.f_name) then
				return false;
			end
		end

		if(not (MG_SortType  == "Lvl")) then
			if(lhs.f_lvl > rhs.f_lvl) then
				return true;
			elseif (rhs.f_lvl > lhs.f_lvl) then
				return false;
			end
		end
	end
	return false;
end

-------------------------------------------------------------------------------
----- Column buttons set this for sorting the guild list.
--------------------------------------------------------------------------------
function MG_SetSortType(MG_type)
	if(MG_type == "Note") then
		local c_text = MG_FrameColumnHeader6:GetText();
		if(c_text == "Rank") then
			if(MG_SortType == "Rank") then
				if(MG_ReverseSort > 0) then
					MG_ReverseSort = 0;
				else
					MG_ReverseSort = 1;
				end
			end
			MG_SortType = "Rank";
		elseif(c_text == "Officer Note") then
			if(MG_SortType == "Officer") then
				if(MG_ReverseSort > 0) then
					MG_ReverseSort = 0;
				else
					MG_ReverseSort = 1;
				end
			end
			MG_SortType = "Officer";
		else
			if(MG_SortType == "Note") then
				if(MG_ReverseSort > 0) then
					MG_ReverseSort = 0;
				else
					MG_ReverseSort = 1;
				end
			end
			MG_SortType = "Note";
		end
	end

	if (MG_type == "PNote")    then
		return;
	elseif (MG_type == "Note") then
		return;
	end

	if(MG_SortType == MG_type) then
		if(MG_ReverseSort > 0) then
			MG_ReverseSort = 0;
		else
			MG_ReverseSort = 1;
		end
	end
	MG_SortType = MG_type;
end

--------------------------------------------------------------------------
--- This function will sort the DKP list and Update the view.
---------------------------------------------------------------
function MG_Sort_DKP()
	local lastSortType = MG_DKP_SortType;
	local lastReverseSort = MG_DKP_ReverseSort;
	
	if(MG_RollInProgress == 1) then
		MG_DKP_SortType = "Rolled";
		MG_DKP_ReverseSort = 1;
	end
	if(MG_DKPList) then
   	table.sort(MG_DKPList, MG_Predicate_DKP);
	end
	MG_MemberDKP_ScrollUpdate();
	MG_DKP_SortType = lastSortType;
	MG_DKP_ReverseSort = lastReverseSort;
end

-------------------------------------------------------------------------------------
--Predicate Sort function for DKP and Roll Sorting
--------------------------------------------------------------------
function MG_Predicate_DKP(lhs, rhs)
	if (lhs == nil) then
		if (rhs == nil) then
			return false;
		else
			return true;
		end
	elseif (rhs == nil) then
		return false;
	end

	if(MG_DKP_ReverseSort == 0) then
		if(MG_DKP_SortType == "Name") then
			if(lhs.Name < rhs.Name) then
				return true;
			elseif (rhs.Name < lhs.Name) then
				return false;
			end
		elseif(MG_DKP_SortType == "Class") then
			if(lhs.Class < rhs.Class) then
				return true;
			elseif (rhs.Class < lhs.Class) then
			   return false;
			end
		elseif(MG_DKP_SortType == "Points") then
			if(lhs.Points < rhs.Points) then
				return true;
			elseif (rhs.Points < lhs.Points) then
				return false;
			end
		elseif(MG_DKP_SortType == "Rolled") then
			if(lhs.Rolled < rhs.Rolled) then
				return true;
			elseif (rhs.Rolled < lhs.Rolled) then
				return false;
			end
		end
		if(not (MG_SortType  == "Points")) then
			if(lhs.Points < rhs.Points) then
				return true;
			elseif (rhs.Points < lhs.Points) then
				return false;
			end
		end
		if( not (MG_SortType == "Name") ) then
			if(lhs.Name < rhs.Name) then
				return true;
			elseif (rhs.Name < lhs.Name) then
				return false;
			end
		end
	end

	if(MG_DKP_ReverseSort > 0) then
		if(MG_DKP_SortType == "Name") then
			if(lhs.Name > rhs.Name) then
				return true;
			elseif (rhs.Name > lhs.Name) then
				return false;
			end
		elseif(MG_DKP_SortType == "Class") then
			if(lhs.Class > rhs.Class) then
				return true;
			elseif (rhs.Class > lhs.Class) then
				return false;
			end
		elseif(MG_DKP_SortType == "Points") then
			if(lhs.Points > rhs.Points) then
				return true;
			elseif (rhs.Points > lhs.Points) then
				return false;
			end
		elseif(MG_DKP_SortType == "Rolled") then
			if(lhs.Rolled > rhs.Rolled) then
				return true;
			elseif (rhs.Rolled > lhs.Rolled) then
				return false;
			end
		end
		if(not (MG_SortType  == "Points")) then
			if(lhs.Points > rhs.Points) then
				return true;
			elseif (rhs.Points > lhs.Points) then
				return false;
			end
		end
		if( not (MG_SortType == "Name") ) then
			if(lhs.Name > rhs.Name) then
				return true;
			elseif (rhs.Name > lhs.Name) then
				return false;
			end
		end
	end
	return false;
end

-------------------------------------------------------------------------------
----- Column buttons set this for sorting the raid list.
--------------------------------------------------------------------------------
function MG_DKP_SetSortType(sort_type)
	MG_DKP_SortType = sort_type;
	
	if(MG_DKP_ReverseSort > 0) then
		MG_DKP_ReverseSort = 0;
	else
		MG_DKP_ReverseSort = 1;
	end
end

-------------------
--Resets GuildList Alts
--------------------
function MG_GuildList_AltReset()
	local size = table.getn(MG_GuildList);
	for i=1, size,1 do
		MG_GuildList[i].f_expand = 0;
	end
end

---------------------------------
--Column toggles on click (Second to last column)
-------------------------------
function MG_PublicToggle_OnClick()
	if(MG_PublicToggle == "Rank") then
		MG_PublicToggle = "Officer";
		MG_FrameColumnHeader6:SetText(MG_COLUMN_TEXT13);
	elseif(MG_PublicToggle == "Officer") then
		MG_PublicToggle = "Note";
		MG_FrameColumnHeader6:SetText(MG_COLUMN_TEXT14);
	elseif(MG_PublicToggle == "Note") then
		MG_PublicToggle = "privNote";
		MG_FrameColumnHeader6:SetText(MG_COLUMN_TEXT15);
	else
		MG_PublicToggle = "Rank";
		MG_FrameColumnHeader6:SetText(MG_COLUMN_TEXT5);
	end

	MG_Update();
end

---------------------------------------------------------------
-- Called when a checkbox (other than show offline) is clicked.
---------------------------------------------------------------

function MG_CheckButton_OnClick()
	local	id = this:GetID();
	local tmp_row = MG_ButtonListIndex[id];

	if(MG_GuildList[tmp_row].f_checked == 0) then
		MG_GuildList[tmp_row].f_checked = 1;
	else
		MG_GuildList[tmp_row].f_checked = 0;
	end
end

---------------------------------------------------------------
-- Called when Raid Invite Button is Clicked.  Invites all checked members to the raid
---------------------------------------------------------------
function MG_RaidInvite_OnClick()
	MG_invite = 1;
	MG_invitecounter = 0;
	MG_invitetime = GetTime();
end

----------------------------------------------------------------------------------
---MetaGuild main frame update event
----------------------------------------------------------------------------------
function MG_OnUpdate(elapsed)
	if(MG_BroadCast == 1) then
		if(MG_BroadcastTimer > 0) then
			MG_BroadcastTimer = MG_BroadcastTimer - elapsed;
		else
			MG_BroadcastRaidInfo();
		end
	end

	if (MG_BroadCast == 1) then
		if(GetNumPartyMembers() ~= 0 and GetNumRaidMembers() == 0) then
			ConvertToRaid();
			MG_RaidStarted = 0;
		elseif(GetNumRaidMembers() > 1) then
			for i=1, table.getn(MG_GuildList),1 do
				if ((MG_GuildList[i].f_checked == 1) and (MG_GuildList[i].f_invited == 0)) then
					if(MG_CheckRaidClass(MG_GuildList[i].f_class, MG_GuildList[i].f_name)) then
						InviteByName(MG_GuildList[i].f_name);
						if(MG_SendConfirmButton:GetChecked()) then
							SendChatMessage(MG_RAID_INVITE_ISSUED, "WHISPER", this.language, MG_GuildList[i].f_name);
						end
						MG_GuildList[i].f_invited = 1;
						MG_UpdateRaidCounts();
					end
					MG_GuildList[i].f_checked = 0;
				end
			end
		end
	elseif (MG_invite == 1) then
		local guildlist_checked = 0
		if (GetNumRaidMembers() > 0) then
			for i=1, table.getn(MG_GuildList),1 do
				if ((MG_GuildList[i].f_checked == 1) and (MG_GuildList[i].f_online == 1)) then
					guildlist_checked = guildlist_checked + 1;
					if (guildlist_checked > MG_invitecounter) then
						InviteByName(MG_GuildList[i].f_name);
						if MG_SendTellOnInvite then
							SendChatMessage(MG_RAID_INVITE_ISSUED, "WHISPER", this.language, MG_GuildList[i].f_name);
						end
					end
				end
			end
			
			MG_invite = 0;
			MG_invitecounter = 0;
			MG_invitetime = 0;
			
		elseif (GetTime() > MG_invitetime) then
			if MG_invitecounter > 4 then
				if (MG_invitecounter < MG_CheckedCount.Total) then
					for i=1, table.getn(MG_GuildList),1 do
						if ((MG_GuildList[i].f_checked == 1) and (MG_GuildList[i].f_online == 1)) then
							guildlist_checked = guildlist_checked + 1;
							if (guildlist_checked == MG_invitecounter + 1) then
								InviteByName(MG_GuildList[i].f_name);
								if MG_SendTellOnInvite then
									SendChatMessage(MG_RAID_INVITE_ISSUED, "WHISPER", this.language, MG_GuildList[i].f_name);
								end
							end
						end
					end
					MG_invitecounter = MG_invitecounter + 1;
					MG_invitetime = GetTime() + 5;
				else
					MG_invitetime = GetTime() + 10;
					MG_invitecounter = 1;
				end
			elseif (MG_invitecounter ~= 0) then
				MG_invite = 0;
				MG_invitecounter = 0;
				MG_invitetime = 0;
			else
				for i=1, table.getn(MG_GuildList),1 do
					if ((MG_GuildList[i].f_checked == 1) and (MG_GuildList[i].f_online == 1) and (MG_invitecounter < 4)) then
						InviteByName(MG_GuildList[i].f_name);
						if MG_SendTellOnInvite then
							SendChatMessage(MG_RAID_INVITE_ISSUED, "WHISPER", this.language, MG_GuildList[i].f_name);
						end
						MG_invitecounter = MG_invitecounter + 1;
					end
				end
				MG_invitetime = GetTime() + 10;
			end
		end
	end
end


----------------------------------------------------------------------------------
---Updates online counts
----------------------------------------------------------------------------------
function MG_UpdateOnlineCounts()

	local MG_numGuildMembers = GetNumGuildMembers();
	local MG_name, MG_rank, MG_rankIndex, MG_level, MG_class, MG_zone, MG_note, MG_pnote, MG_officernote, MG_online;

	--Reset the online count
	MG_OnlineCount.Warrior = 0
	MG_OnlineCount.Mage = 0
	MG_OnlineCount.Druid = 0
	MG_OnlineCount.Warlock = 0
	MG_OnlineCount.Shaman = 0
	MG_OnlineCount.Paladin = 0
	MG_OnlineCount.Hunter = 0
	MG_OnlineCount.Rogue = 0
	MG_OnlineCount.Priest = 0


	for i=1,MG_numGuildMembers, 1 do
		MG_name, MG_rank, MG_rankIndex, MG_level, MG_class, MG_zone, MG_note, MG_officernote, MG_online = GetGuildRosterInfo(i);
		if(MG_online == 1) then
			if (MG_level >= MG_Options.StatsLevel) then
				if (MG_class == MG_WARRIOR_TITLE) then
					MG_OnlineCount.Warrior = MG_OnlineCount.Warrior + 1
				elseif (MG_class == MG_MAGE_TITLE) then
					MG_OnlineCount.Mage = MG_OnlineCount.Mage + 1
				elseif (MG_class == MG_DRUID_TITLE) then
					MG_OnlineCount.Druid = MG_OnlineCount.Druid + 1
				elseif (MG_class == MG_WARLOCK_TITLE) then
					MG_OnlineCount.Warlock = MG_OnlineCount.Warlock + 1
				elseif (MG_class == MG_SHAMAN_TITLE) then
					MG_OnlineCount.Shaman = MG_OnlineCount.Shaman + 1
				elseif (MG_class == MG_PALADIN_TITLE) then
					MG_OnlineCount.Paladin = MG_OnlineCount.Paladin + 1
				elseif (MG_class == MG_HUNTER_TITLE) then
					MG_OnlineCount.Hunter = MG_OnlineCount.Hunter + 1
				elseif (MG_class == MG_ROGUE_TITLE) then
					MG_OnlineCount.Rogue = MG_OnlineCount.Rogue + 1
				elseif (MG_class == MG_PRIEST_TITLE) then
					MG_OnlineCount.Priest = MG_OnlineCount.Priest + 1
				end
			end
		end
	end
	

	MG_OnlineCount.Total = MG_OnlineCount.Warrior + MG_OnlineCount.Mage + MG_OnlineCount.Druid + MG_OnlineCount.Warlock + MG_OnlineCount.Shaman + MG_OnlineCount.Paladin + MG_OnlineCount.Hunter + MG_OnlineCount.Rogue + MG_OnlineCount.Priest

	getglobal("MG_RaidButton1RaidOnline"):SetText(MG_OnlineCount.Warrior);
	getglobal("MG_RaidButton2RaidOnline"):SetText(MG_OnlineCount.Mage);
	getglobal("MG_RaidButton3RaidOnline"):SetText(MG_OnlineCount.Warlock);
	getglobal("MG_RaidButton4RaidOnline"):SetText(MG_OnlineCount.Hunter);
	getglobal("MG_RaidButton5RaidOnline"):SetText(MG_OnlineCount.Rogue);
	if (MG_Faction=="Horde") then
		getglobal("MG_RaidButton6RaidOnline"):SetText(MG_OnlineCount.Shaman);
	else
		getglobal("MG_RaidButton6RaidOnline"):SetText(MG_OnlineCount.Paladin);
	end
	getglobal("MG_RaidButton7RaidOnline"):SetText(MG_OnlineCount.Druid);
	getglobal("MG_RaidButton8RaidOnline"):SetText(MG_OnlineCount.Priest);

end

----------------------------------------------------------------------------------
---Updates raid counts
----------------------------------------------------------------------------------
function MG_UpdateRaidCounts()

		local MG_name, MG_rank, MG_subgroup, MG_level, MG_class, MG_filename, MG_zone, MG_online, MG_isdead;

		--Reset the raid counts
		MG_RaidCount.Warrior = 0;
		MG_RaidCount.Mage = 0;
		MG_RaidCount.Druid = 0;
		MG_RaidCount.Warlock = 0;
		MG_RaidCount.Shaman = 0;
		MG_RaidCount.Paladin = 0;
		MG_RaidCount.Hunter = 0;
		MG_RaidCount.Rogue = 0;
		MG_RaidCount.Priest = 0;

		if GetNumRaidMembers() > 0 then
				for i=1,40, 1 do
						MG_name, MG_rank, MG_subgroup, MG_level, MG_class, MG_filename, MG_zone, MG_online, MG_isdead = GetRaidRosterInfo(i);
						if (MG_name ~= nil) then
								if (MG_class == MG_WARRIOR_TITLE) then
										MG_RaidCount.Warrior = MG_RaidCount.Warrior + 1
								elseif (MG_class == MG_MAGE_TITLE) then
										MG_RaidCount.Mage = MG_RaidCount.Mage + 1
								elseif (MG_class == MG_DRUID_TITLE) then
										MG_RaidCount.Druid = MG_RaidCount.Druid + 1
								elseif (MG_class == MG_WARLOCK_TITLE) then
										MG_RaidCount.Warlock = MG_RaidCount.Warlock + 1
								elseif (MG_class == MG_SHAMAN_TITLE) then
										MG_RaidCount.Shaman = MG_RaidCount.Shaman + 1
								elseif (MG_class == MG_PALADIN_TITLE) then
										MG_RaidCount.Paladin = MG_RaidCount.Paladin + 1
								elseif (MG_class == MG_HUNTER_TITLE) then
										MG_RaidCount.Hunter = MG_RaidCount.Hunter + 1
								elseif (MG_class == MG_ROGUE_TITLE) then
										MG_RaidCount.Rogue = MG_RaidCount.Rogue + 1
								elseif (MG_class == MG_PRIEST_TITLE) then
										MG_RaidCount.Priest = MG_RaidCount.Priest + 1
								end
						end
				end
		end
		
		MG_RaidCount.Total = MG_RaidCount.Warrior + MG_RaidCount.Mage + MG_RaidCount.Druid + MG_RaidCount.Warlock + MG_RaidCount.Shaman + MG_RaidCount.Paladin + MG_RaidCount.Hunter + MG_RaidCount.Rogue + MG_RaidCount.Priest


	getglobal("MG_RaidButton1RaidInRaid"):SetText(MG_RaidCount.Warrior);
	getglobal("MG_RaidButton2RaidInRaid"):SetText(MG_RaidCount.Mage);
	getglobal("MG_RaidButton3RaidInRaid"):SetText(MG_RaidCount.Warlock);
	getglobal("MG_RaidButton4RaidInRaid"):SetText(MG_RaidCount.Hunter);
	getglobal("MG_RaidButton5RaidInRaid"):SetText(MG_RaidCount.Rogue);
	if (MG_Faction=="Horde") then
		getglobal("MG_RaidButton6RaidInRaid"):SetText(MG_RaidCount.Shaman);
	else
		getglobal("MG_RaidButton6RaidInRaid"):SetText(MG_RaidCount.Paladin);
	end
	getglobal("MG_RaidButton7RaidInRaid"):SetText(MG_RaidCount.Druid);
	getglobal("MG_RaidButton8RaidInRaid"):SetText(MG_RaidCount.Priest);
	
	getglobal("MG_MiniClass1Text"):SetText("W:"..MG_RaidCount.Warrior);
	getglobal("MG_MiniClass2Text"):SetText("M:"..MG_RaidCount.Mage);
	getglobal("MG_MiniClass3Text"):SetText("W:"..MG_RaidCount.Warlock);
	getglobal("MG_MiniClass4Text"):SetText("H:"..MG_RaidCount.Hunter);
	getglobal("MG_MiniClass5Text"):SetText("R:"..MG_RaidCount.Rogue);
	if (MG_Faction=="Horde") then
		getglobal("MG_MiniClass6Text"):SetText("S:"..MG_RaidCount.Shaman);
	else
		getglobal("MG_MiniClass6Text"):SetText("P:"..MG_RaidCount.Paladin);
	end
	getglobal("MG_MiniClass7Text"):SetText("D:"..MG_RaidCount.Druid);
	getglobal("MG_MiniClass8Text"):SetText("P:"..MG_RaidCount.Priest);
	getglobal("MG_MiniClass9Text"):SetText("T:"..MG_RaidCount.Total);

end


----------------------------------------------------------------------------------
---Updates Checked counts
----------------------------------------------------------------------------------
function MG_UpdateCheckCounts()

	local MG_guildName, MG_GuildRankName, MG_guildRankIndex = GetGuildInfo("player");

	MG_CheckedCount.Warrior = 0;
	MG_CheckedCount.Mage = 0;
	MG_CheckedCount.Druid = 0;
	MG_CheckedCount.Warlock = 0;
	MG_CheckedCount.Shaman = 0;
	MG_CheckedCount.Paladin = 0;
	MG_CheckedCount.Hunter = 0;
	MG_CheckedCount.Rogue = 0;
	MG_CheckedCount.Priest = 0;

	for i = 1,table.getn(MG_GuildList),1 do
		if((MG_GuildList[i].f_guild == MG_guildName) and (MG_GuildList[i].f_checked == 1)) then
			if (MG_GuildList[i].f_class == MG_WARRIOR_TITLE) then
				MG_CheckedCount.Warrior = MG_CheckedCount.Warrior + 1
			elseif (MG_GuildList[i].f_class == MG_MAGE_TITLE) then
				MG_CheckedCount.Mage = MG_CheckedCount.Mage + 1
			elseif (MG_GuildList[i].f_class == MG_DRUID_TITLE) then
				MG_CheckedCount.Druid = MG_CheckedCount.Druid + 1
			elseif (MG_GuildList[i].f_class == MG_WARLOCK_TITLE) then
				MG_CheckedCount.Warlock = MG_CheckedCount.Warlock + 1
			elseif (MG_GuildList[i].f_class == MG_SHAMAN_TITLE) then
				MG_CheckedCount.Shaman = MG_CheckedCount.Shaman + 1
			elseif (MG_GuildList[i].f_class == MG_PALADIN_TITLE) then
				MG_CheckedCount.Paladin = MG_CheckedCount.Paladin + 1
			elseif (MG_GuildList[i].f_class == MG_HUNTER_TITLE) then
				MG_CheckedCount.Hunter = MG_CheckedCount.Hunter + 1
			elseif (MG_GuildList[i].f_class == MG_ROGUE_TITLE) then
				MG_CheckedCount.Rogue = MG_CheckedCount.Rogue + 1
			elseif (MG_GuildList[i].f_class == MG_PRIEST_TITLE) then
				MG_CheckedCount.Priest = MG_CheckedCount.Priest + 1
			end
		end
	end
	
	MG_CheckedCount.Total = MG_CheckedCount.Warrior + MG_CheckedCount.Mage + MG_CheckedCount.Druid + MG_CheckedCount.Warlock + MG_CheckedCount.Shaman + MG_CheckedCount.Paladin + MG_CheckedCount.Hunter + MG_CheckedCount.Rogue + MG_CheckedCount.Priest;

	getglobal("MG_RaidButton1CheckCount"):SetText(MG_CheckedCount.Warrior);
	getglobal("MG_RaidButton2CheckCount"):SetText(MG_CheckedCount.Mage);
	getglobal("MG_RaidButton3CheckCount"):SetText(MG_CheckedCount.Warlock);
	getglobal("MG_RaidButton4CheckCount"):SetText(MG_CheckedCount.Hunter);
	getglobal("MG_RaidButton5CheckCount"):SetText(MG_CheckedCount.Rogue);
	if (MG_Faction=="Horde") then
		getglobal("MG_RaidButton6CheckCount"):SetText(MG_CheckedCount.Shaman);
	else
		getglobal("MG_RaidButton6CheckCount"):SetText(MG_CheckedCount.Paladin);
	end
	getglobal("MG_RaidButton7CheckCount"):SetText(MG_CheckedCount.Druid);
	getglobal("MG_RaidButton8CheckCount"):SetText(MG_CheckedCount.Priest);
 
end

----------------------------------------------------------------------------------
---Updates Totals Display
----------------------------------------------------------------------------------
function MG_UpdateRaidTotals()

	getglobal("MG_RaidButton1RaidTotals"):SetText(MG_CheckedCount.Warrior + MG_RaidCount.Warrior);
	getglobal("MG_RaidButton2RaidTotals"):SetText(MG_CheckedCount.Mage + MG_RaidCount.Mage);
	getglobal("MG_RaidButton3RaidTotals"):SetText(MG_CheckedCount.Warlock + MG_RaidCount.Warlock);
	getglobal("MG_RaidButton4RaidTotals"):SetText(MG_CheckedCount.Hunter + MG_RaidCount.Hunter);
	getglobal("MG_RaidButton5RaidTotals"):SetText(MG_CheckedCount.Rogue + MG_RaidCount.Rogue);
	if (MG_Faction=="Horde") then
		getglobal("MG_RaidButton6RaidTotals"):SetText(MG_CheckedCount.Shaman + MG_RaidCount.Shaman);
	else
		getglobal("MG_RaidButton6RaidTotals"):SetText(MG_CheckedCount.Paladin + MG_RaidCount.Paladin);
	end
	getglobal("MG_RaidButton7RaidTotals"):SetText(MG_CheckedCount.Druid + MG_RaidCount.Druid);
	getglobal("MG_RaidButton8RaidTotals"):SetText(MG_CheckedCount.Priest + MG_RaidCount.Priest);

	getglobal("MG_RaidButton9RaidOnline"):SetText(MG_OnlineCount.Total);
	getglobal("MG_RaidButton9RaidInRaid"):SetText(MG_RaidCount.Total);
	getglobal("MG_RaidButton9CheckCount"):SetText(MG_CheckedCount.Total);
	getglobal("MG_RaidButton9RaidTotals"):SetText(MG_CheckedCount.Total + MG_RaidCount.Total);

end

----------------------------------------------------------------------------------
---Resets InRaid flag to 0 for all guild members
----------------------------------------------------------------------------------
function MG_Reset_InRaid()
	for i = 1,table.getn(MG_GuildList),1 do
		MG_GuildList[i].f_inRaid = 0
	end
end

----------------------------------------------------------------------------------
---Updates InRaid flag for all guild members
----------------------------------------------------------------------------------
function MG_Update_InRaid_All()
	local MG_name, MG_rank, MG_subgroup, MG_level, MG_class, MG_filename, MG_zone, MG_online, MG_isdead;
	MG_Reset_InRaid()

	for i=1,40, 1 do
		MG_name, MG_rank, MG_subgroup, MG_level, MG_class, MG_filename, MG_zone, MG_online, MG_isdead = GetRaidRosterInfo(i);
				if (MG_name ~= nil) then
			for j = 1,table.getn(MG_GuildList),1 do
				if (MG_name == MG_GuildList[j].f_name) then
					MG_GuildList[j].f_inRaid = 1;
					MG_GuildList[j].f_checked = 0;
					break;
				end
			end
		end
	end
end

----------------------------------------------------------------------------------
---Search the current Raid to determine if playername is in the raid
----------------------------------------------------------------------------------
function MG_Is_InRaid(playername)
	local MG_name, MG_rank, MG_subgroup, MG_level, MG_class, MG_filename, MG_zone, MG_online, MG_isdead;

	if GetNumRaidMembers() > 0 then
		for i=1,40, 1 do
			MG_name, MG_rank, MG_subgroup, MG_level, MG_class, MG_filename, MG_zone, MG_online, MG_isdead = GetRaidRosterInfo(i);
			if (MG_name == playername) then
				return 1;
			end
		end
	end
	return 0;
end

----------------------------------------------------------------------------------
---Display Class Name List
----------------------------------------------------------------------------------
function MG_Classlist()
	local buttoncounter = 11;
	
	if (GetNumRaidMembers() > 0 and MG_RaidClassDisplay ~= "none") then
				for i=1,40, 1 do
			if buttoncounter > 21 then
				--do nothing
			else
				MG_name, MG_rank, MG_subgroup, MG_level, MG_class, MG_filename, MG_zone, MG_online, MG_isdead = GetRaidRosterInfo(i);
				if (MG_class == MG_RaidClassDisplay) then
					getglobal("MG_RaidButton"..buttoncounter.."RaidClass"):SetText(MG_name);
					getglobal("MG_RaidButton"..buttoncounter.."RaidLocation"):SetText(MG_zone);
					buttoncounter = buttoncounter + 1;
				end
			end
				end
		end
		
		if buttoncounter <=21 then
		for i=buttoncounter,21,1 do
			getglobal("MG_RaidButton"..i.."RaidClass"):SetText("");
			getglobal("MG_RaidButton"..i.."RaidLocation"):SetText("");
		end
	end
end


----------------------------------------------------------------------------------
---Set Check for all players
----------------------------------------------------------------------------------
function MG_SetCheck(checkvalue)
	local MG_guildName, MG_GuildRankName, MG_guildRankIndex = GetGuildInfo("player"); 

	for i = 1,table.getn(MG_GuildList),1 do
		if(MG_GuildList[i].f_guild == MG_guildName) then
			if( ((MG_ShowMembersInRaid == 1) or (MG_GuildList[i].f_inRaid == 0)) and ( (MG_GuildList[i].f_online) or (MG_ShowOfflineMembers == 1)) ) then
				MG_GuildList[i].f_checked = checkvalue;
			end
		end
	end
	MG_Update();
end


----------------------------------------------------------------------------------
---Set Check for all players
----------------------------------------------------------------------------------
function MG_ToggleCheck()
	local is_all_checked = 1;

	for i = 1, MG_GUILDMEMBERS_TO_DISPLAY, 1 do
		if (getglobal("MG_CheckButton"..i):GetChecked() == nil) and (getglobal("MG_CheckButton"..i):IsVisible() == 1) then
			is_all_checked = 0;
		end
	end
	
	if (is_all_checked == 1) then
		MG_SetCheck(0);
	else
		MG_SetCheck(1);
	end
end

----------------------------------------------------------------------------------
---Select a Raid
----------------------------------------------------------------------------------
function MG_SetRaid_Button_OnClick()
	
	local id = this:GetID();
	local text;
	
	MG_Raid_Current = id;
	text = getglobal("MG_SetRaid_Button"..id.."Description"):GetText();
	if (text == nil) then
		text = "Untitled Raid"
	end
	MetaGuild_SetRaid_Event_Title:SetText(text);
	MetaGuild_SetRaid:Hide();
	MetaGuild_SetRaid_Event:Show();
	MetaGuild_SetRaid_Event_Update();

end

----------------------------------------------------------------------------------
---Update a Raid Button Click Handler
----------------------------------------------------------------------------------
function MetaGuild_SetRaid_Update_Click()

	local raid_entry;
	
	for i = 1, table.getn(MG_RaidList), 1 do
		raid_entry = MG_RaidList[i];
		if (raid_entry) then
			if (raid_entry.raid_selected == 1) then
				MG_RaidList[i].RaidName = MG_SetRaid_EditBox:GetText();
			end
		end
	end
	MG_SetRaid_EditBox:SetText("");
	MetaGuild_SetRaid_Update();
end

----------------------------------------------------------------------------------
---Delete a Raid Button Click Handler
----------------------------------------------------------------------------------
function MetaGuild_SetRaid_Delete_Click()

	local raid_entry;
	
	for i = 1, table.getn(MG_RaidList), 1 do
		raid_entry = MG_RaidList[i];
		if (raid_entry) then
			if (raid_entry.raid_selected == 1) then
				table.remove(MG_RaidList,i);
				i = 0;
			end
		end
	end
	MG_SetRaid_EditBox:SetText("");
	MetaGuild_SetRaid_Update();
end

----------------------------------------------------------------------------------
---Add a Raid
----------------------------------------------------------------------------------
function MetaGuild_SetRaid_Add()
	
	local r_id, r_datetime, r_description, r_new_entry
	
	r_id = Set_Raid_GetID()
	r_datetime = date();
	r_description = MG_SetRaid_EditBox:GetText();
	
	r_new_entry = { raid_id = r_id, RaidName = r_description, raid_selected = 0, RaidSize = "40", MinLevel = "58", MaxLevel = "60", BcastInt = "120", Warrior = "0", Mage = "0", Warlock = "0", Hunter = "0", Rogue = "0", Paladin = "0", Druid = "0", Priest = "0"};
	table.insert(MG_RaidList,r_new_entry);
	MG_Print("Adding Raid - "..r_description);
	MG_SetRaid_EditBox:SetText("");
	MetaGuild_SetRaid_Update();
end

----------------------------------------------------------------------------------
---Get New Raid ID
----------------------------------------------------------------------------------
function Set_Raid_GetID()
	local nextID = 1;
	local raid_entry;
	
	for i = 1, table.getn(MG_RaidList), 1 do
		raid_entry = MG_RaidList[i];
		if (raid_entry) then
			if MG_RaidList[i].raid_id > nextID then
				nextID = MG_RaidList[i].raid_id;
			end
		end
	end
	nextID = nextID + 1;
	return nextID
end

----------------------------------------------------------------------------------
---Raid window update display
----------------------------------------------------------------------------------
function MetaGuild_SetRaid_Update()

	local MG_raidOffset = FauxScrollFrame_GetOffset(MG_SetRaid_ScrollFrame);
	local MG_raidIndex;
	local raid_entry;
	
	for i=1, MG_RAID_TO_DISPLAY, 1 do
		MG_raidIndex = MG_raidOffset + i;
		raid_entry = MG_RaidList[MG_raidIndex];
		if(raid_entry) then
			getglobal("MG_SetRaid_Button"..i.."ID"):SetText(raid_entry.raid_id);
			getglobal("MG_SetRaid_Button"..i.."Description"):SetText(raid_entry.RaidName);
			if (raid_entry.raid_selected == 0) then
				getglobal("MG_SetRaid_Button"..i.."Description"):SetTextColor(1, 1, 1);
				getglobal("MG_SetRaid_CheckButton"..i):SetChecked(0);
				getglobal("MG_SetRaid_CheckButton"..i):Show();
				getglobal("MG_SetRaid_Button"..i):Show();
			else
				getglobal("MG_SetRaid_Button"..i.."Description"):SetTextColor(1, 0, 0);
				getglobal("MG_SetRaid_CheckButton"..i):SetChecked(1);
				getglobal("MG_SetRaid_CheckButton"..i):Show();
				getglobal("MG_SetRaid_Button"..i):Show();
			end
		else
			getglobal("MG_SetRaid_Button"..i.."ID"):SetText("");
			getglobal("MG_SetRaid_Button"..i.."Description"):SetText("");
			getglobal("MG_SetRaid_Button"..i.."Description"):SetTextColor(1, 1, 1);
			getglobal("MG_SetRaid_CheckButton"..i):SetChecked(0);
			getglobal("MG_SetRaid_CheckButton"..i):Hide();
			getglobal("MG_SetRaid_Button"..i):Hide();
		end
	end
	FauxScrollFrame_Update(MG_SetRaid_ScrollFrame, table.getn(MG_RaidList), MG_RAID_TO_DISPLAY, MG_FRAME_HEIGHT);
end

----------------------------------------------------------------------------------
---Raid Check Button Event
----------------------------------------------------------------------------------
function MG_SetRaid_CheckButton_OnClick()
	local id = this:GetID();

	if (MG_RaidList[id].raid_selected == 0) then
		MG_RaidList[id].raid_selected = 1;
		MG_SetRaid_EditBox:SetText(MG_RaidList[id].RaidName);
	else
		MG_SetRaid_EditBox:SetText("");
		MG_RaidList[id].raid_selected = 0;
	end
	MetaGuild_SetRaid_Update();
end

----------------------------------------------------------------------------------
---Update Raid Events Display
----------------------------------------------------------------------------------
function MetaGuild_SetRaid_Event_Update()
	if(not MG_RaidList[MG_Raid_Current]["InviteKey"]) then
		MG_RaidList[MG_Raid_Current]["InviteKey"] = "Invite";
	end
	MG_SetRaidSize_EditBox:SetText(MG_RaidList[MG_Raid_Current]["RaidSize"]);
	MG_SetRaidMinLev_EditBox:SetText(MG_RaidList[MG_Raid_Current]["MinLevel"]);
	MG_SetRaidMaxLev_EditBox:SetText(MG_RaidList[MG_Raid_Current]["MaxLevel"]);
	MG_BcTimer_EditBox:SetText(MG_RaidList[MG_Raid_Current]["BcastInt"]);
	MG_InviteKey_EditBox:SetText(MG_RaidList[MG_Raid_Current]["InviteKey"]);
	MG_SilentBroadcastButton:SetChecked(MG_RaidList[MG_Raid_Current]["BcastSilent"]);
	MG_SendConfirmButton:SetChecked(MG_RaidList[MG_Raid_Current]["SendConfirm"]);
	MG_Warrior_EditBox:SetText(MG_RaidList[MG_Raid_Current]["Warrior"]);
	MG_Mage_EditBox:SetText(MG_RaidList[MG_Raid_Current]["Mage"]);
	MG_Warlock_EditBox:SetText(MG_RaidList[MG_Raid_Current]["Warlock"]);
	MG_Hunter_EditBox:SetText(MG_RaidList[MG_Raid_Current]["Hunter"]);
	MG_Rogue_EditBox:SetText(MG_RaidList[MG_Raid_Current]["Rogue"]);
	MG_Paladin_EditBox:SetText(MG_RaidList[MG_Raid_Current]["Paladin"]);
	MG_Druid_EditBox:SetText(MG_RaidList[MG_Raid_Current]["Druid"]);
	MG_Priest_EditBox:SetText(MG_RaidList[MG_Raid_Current]["Priest"]);
end

----------------------------------------------------------------------------------
---Save template function
----------------------------------------------------------------------------------
function MG_SetRaidSave()
	MG_RaidList[MG_Raid_Current]["RaidSize"] = MG_SetRaidSize_EditBox:GetText();
	MG_RaidList[MG_Raid_Current]["MinLevel"] = MG_SetRaidMinLev_EditBox:GetText();
	MG_RaidList[MG_Raid_Current]["MaxLevel"] = MG_SetRaidMaxLev_EditBox:GetText();
	MG_RaidList[MG_Raid_Current]["BcastInt"] = MG_BcTimer_EditBox:GetText();
	MG_RaidList[MG_Raid_Current]["InviteKey"] = MG_InviteKey_EditBox:GetText();
	MG_RaidList[MG_Raid_Current]["BcastSilent"] = MG_SilentBroadcastButton:GetChecked();
	MG_RaidList[MG_Raid_Current]["SendConfirm"] = MG_SendConfirmButton:GetChecked();
	MG_RaidList[MG_Raid_Current]["Warrior"] = MG_Warrior_EditBox:GetText();
	MG_RaidList[MG_Raid_Current]["Mage"] = MG_Mage_EditBox:GetText();
	MG_RaidList[MG_Raid_Current]["Warlock"] = MG_Warlock_EditBox:GetText();
	MG_RaidList[MG_Raid_Current]["Hunter"] = MG_Hunter_EditBox:GetText();
	MG_RaidList[MG_Raid_Current]["Rogue"] = MG_Rogue_EditBox:GetText();
	MG_RaidList[MG_Raid_Current]["Paladin"] = MG_Paladin_EditBox:GetText();
	MG_RaidList[MG_Raid_Current]["Druid"] = MG_Druid_EditBox:GetText();
	MG_RaidList[MG_Raid_Current]["Priest"] = MG_Priest_EditBox:GetText();
end

----------------------------------------------------------------------------------
---Member DKP routines
----------------------------------------------------------------------------------
function MG_MemberDKP_Update()
	local MG_guildName, MG_GuildRankName, MG_guildRankIndex = GetGuildInfo("player");
	if(MG_guildName == nil or not ScenRaidData) then
		MG_MemberDKP_Title:SetText(MG_MEMBERDKP_SRTEXT);
		MG_DKP_UpdateButton:Disable();
		MG_ShowDKPRaidButton:Hide();
		MG_RaidRollDKPCheck:Hide();
		return;
	end
	MG_DKPList = {};
	local new_entry = {};
	local index = 0;

	for i=1, table.getn(ScenRaidData), 1 do
		if(ScenRaidData[i][1] == MG_guildName) then
			index = i;
		end
	end
	if(index == 0) then return; end

	for i=1, table.getn(MG_GuildList), 1 do
		if(ScenRaidData[index]["RP"][MG_GuildList[i].f_name]) then
			if(MG_ShowDKPRaidMembers) then
				if(MG_Is_InRaid(MG_GuildList[i].f_name)== 1) then
					local rp = ScenRaidData[index]["RP"][MG_GuildList[i].f_name]["c"];
					new_entry = {Name = MG_GuildList[i].f_name, Class = MG_GuildList[i].f_class, Points = rp, Rolled = 0};
					table.insert(MG_DKPList,new_entry);
				end
			else
				local rp = ScenRaidData[index]["RP"][MG_GuildList[i].f_name]["c"];
				new_entry = {Name = MG_GuildList[i].f_name, Class = MG_GuildList[i].f_class, Points = rp, Rolled = 0};
				table.insert(MG_DKPList,new_entry);
			end
		end
	end
	MG_Sort_DKP();
end

function MG_MemberDKP_ScrollUpdate()
	local MG_dkpOffset = FauxScrollFrame_GetOffset(MG_MemberDKP_ScrollFrame);
	local MG_NumRolled = 0;
	local MG_dkpIndex;
	local dkp_entry;
	local color;
	local pcolor;
	
	for i=1, MG_DKP_TO_DISPLAY, 1 do
		MG_dkpIndex = MG_dkpOffset + i;
		dkp_entry = MG_DKPList[MG_dkpIndex];
		if(dkp_entry) then
			color = RAID_CLASS_COLORS[string.upper(dkp_entry.Class)];
			if(MG_RaidRoll_Visible == 1) then
				if(dkp_entry.Rolled > 0) then
					getglobal("MG_MemberDKP_Button"..i.."ID"):SetText(i);
					getglobal("MG_MemberDKP_Button"..i.."DKPName"):SetText(dkp_entry.Name);
					getglobal("MG_MemberDKP_Button"..i.."DKPClass"):SetText(dkp_entry.Class);
					getglobal("MG_MemberDKP_Button"..i.."DKPName"):SetTextColor(color.r, color.g, color.b);
					getglobal("MG_MemberDKP_Button"..i.."DKPClass"):SetTextColor(color.r, color.g, color.b);
					getglobal("MG_MemberDKP_Button"..i.."DKPValue"):SetText(dkp_entry.Rolled);
					getglobal("MG_MemberDKP_Button"..i.."DKPValue"):SetTextColor(1, 1, 1);
					for r=1, table.getn(MG_HighRolls), 1 do
						if(dkp_entry.Name == MG_HighRolls[r].Name) then
							getglobal("MG_MemberDKP_Button"..i.."DKPValue"):SetTextColor(0, 1, 0);
						end
					end
					getglobal("MG_MemberDKP_Button"..i):Show();
					MG_NumRolled = MG_NumRolled + 1;
				else
					getglobal("MG_MemberDKP_Button"..i):Hide();
				end
			else
				getglobal("MG_MemberDKP_Button"..i.."ID"):SetText(i);
				getglobal("MG_MemberDKP_Button"..i.."DKPName"):SetText(dkp_entry.Name);
				getglobal("MG_MemberDKP_Button"..i.."DKPClass"):SetText(dkp_entry.Class);
				getglobal("MG_MemberDKP_Button"..i.."DKPName"):SetTextColor(color.r, color.g, color.b);
				getglobal("MG_MemberDKP_Button"..i.."DKPClass"):SetTextColor(color.r, color.g, color.b);
				getglobal("MG_MemberDKP_Button"..i.."DKPValue"):SetText(dkp_entry.Points);
				pcolor = tonumber(dkp_entry.Points);
				if(pcolor > 0) then
					getglobal("MG_MemberDKP_Button"..i.."DKPValue"):SetTextColor(0, 1, 0);
				elseif(pcolor < 0) then
					getglobal("MG_MemberDKP_Button"..i.."DKPValue"):SetTextColor(1, 0, 0);
				else
					getglobal("MG_MemberDKP_Button"..i.."DKPValue"):SetTextColor(1, 1, 1);
				end
				getglobal("MG_MemberDKP_Button"..i):Show();
			end
		else
			getglobal("MG_MemberDKP_Button"..i):Hide();
		end
	end
	if(MG_RaidRoll_Visible == 1) then
		FauxScrollFrame_Update(MG_MemberDKP_ScrollFrame, MG_NumRolled, MG_DKP_TO_DISPLAY, MG_FRAME_HEIGHT);
	else
		FauxScrollFrame_Update(MG_MemberDKP_ScrollFrame, table.getn(MG_DKPList), MG_DKP_TO_DISPLAY, MG_FRAME_HEIGHT);
	end
end

---------------------------------------------------------------------
--RaidRoller routines.
---------------------------------------------------------------------
function MG_ToggleRaidRoll(startroll)
	local msg;
	local dkpText;
	local MG_Winner = "";
	if(MG_CurrentDKPvalue ~= nil and MG_UseDKPRoll) then
		dkpText = " for "..MG_CurrentDKPvalue.."DKP";
	else dkpText = ""; end

	if(startroll) then
		if(MG_currentItemlink ~= nil) then
			msg = MG_RAIDROLL_ROLLFOR..MG_currentItemlink..dkpText;
			SendChatMessage(msg, MG_GetAnnounceChannel());
			if(MG_Options.UseGMroll) then
				msg = "Use '"..MG_RollKeyWord.."' to roll";
				SendChatMessage(msg, MG_GetAnnounceChannel());
			end
			MG_HighRolls = {};
			MG_MemberDKP_Update();
			for i=1, MG_DKP_TO_DISPLAY, 1 do
				getglobal("MG_MemberDKP_Button"..i):Hide();
			end
			MG_SetRaidRoll_Back:Disable();
			MG_CurrentWinner = nil;
			MG_RollInProgress = 1;
			MG_ChatFrame_Open();
			MG_RaidRoll_Assign:Disable();
			MG_RaidRoll_End:Enable();
		end
	else
		MG_ChatFrame_Close();
		if(MG_RollInProgress == 1 and MG_HighRolls[1] ~= nil) then
			local numWins = 0;
			for r=1, table.getn(MG_HighRolls), 1 do
				MG_Winner = MG_Winner..MG_HighRolls[r].Name.." ";
				numWins = numWins +1;
			end
			if(numWins > 1) then
				msg = MG_RAIDROLL_TIEDROLL1..MG_Winner;
				SendChatMessage(msg, MG_GetAnnounceChannel());
				msg = MG_RAIDROLL_TIEDROLL2;
				SendChatMessage(msg, MG_GetAnnounceChannel());
				MG_ToggleRaidRoll(true);
				return;
			else
				MG_CurrentWinner = MG_HighRolls[1].Name;
				msg = "MG-Roll: "..MG_CurrentWinner.." wins "..MG_currentItemlink.." with a roll of "..MG_HighRolls[1].Rolled;
				SendChatMessage(msg, MG_GetAnnounceChannel());
				MG_RaidRoll_Assign:Enable();
			end
		end
		MG_RollInProgress = 0;
		MG_HighRolls = {};
		MG_MemberDKP_ScrollUpdate();
		MG_SetRaidRoll_Back:Enable();
	end
end

function MG_RaidRoll_Update(pName, rValue)
	local new_entry = {};
	local capRoll = 0;
	local seed;
	local msg;

	for i=1, table.getn(MG_DKPList), 1 do
		if(MG_DKPList[i].Name == pName) then
			if(MG_DKPList[i].Rolled > 0) then
				return;
			end
			if(MG_Options.UseGMroll) then
				if(MG_UseDKPRoll) then
					if(MG_DKPList[i].Points < 1) then
						msg = "MG-Roll: "..pName.." roll invalid ("..MG_DKPList[i].Points.." DKP)";
						SendChatMessage(msg, MG_GetAnnounceChannel());
						return;
					end
					seed = MG_DKPList[i].Points;
				else
					seed = 100;
				end
				capRoll = random(seed);
				msg = "MG-Roll: "..pName.." rolls "..capRoll.." (1-"..seed..")";
				SendChatMessage(msg, MG_GetAnnounceChannel());
			else
				capRoll = tonumber(rValue);
			end
				MG_DKPList[i].Rolled = capRoll;

			if(table.getn(MG_HighRolls) > 0) then
				for r=1, table.getn(MG_HighRolls), 1 do
					if(capRoll > MG_HighRolls[r].Rolled) then
						MG_HighRolls = {};
						new_entry = {Name = pName, Rolled = capRoll};
						table.insert(MG_HighRolls,new_entry);
					elseif(MG_HighRolls[r].Rolled == capRoll) then
						new_entry = {Name = pName, Rolled = capRoll};
						table.insert(MG_HighRolls,new_entry);
					end
				end
			else
				new_entry = {Name = pName, Rolled = capRoll};
				table.insert(MG_HighRolls,new_entry);
			end
		end
	end
	MG_Sort_DKP();
end

function MG_AnnounceLoot()
	if(MG_RollInProgress == 0 and not MG_currentItemlink) then
		local i;
		local j=0;
		local nLine="";
		local MG_Rarity;
		local msg = "MG-LootList: ";

		for i=1, GetNumLootItems(), 1 do
			local MG_icon, MG_name, MG_quantity, MG_rarity = GetLootSlotInfo(i);
			if(LootSlotIsItem(i) and MG_rarity >= MG_Options.LootLevel) then
				local tmpMsg = msg..GetLootSlotLink(i).." ";
				msg = tmpMsg;
				j=j+1;
			end
			-- Split announcement 3 items per announce maximum.
			if((j == 3 or j == 6 or j == 9 or j == 12 or j == 15) and msg ~= "MG-LootList: " and msg ~= "MG-LootList ("..nLine.."): ") then
				SendChatMessage(msg, MG_GetAnnounceChannel());
				nLine = (j/3) + 1;
				msg = "MG-LootList("..nLine.."): ";
			end
			MG_Rarity = MG_rarity;
		end
		if(msg ~= "MG-LootList("..nLine.."): " and msg ~= "MG-LootList: ") then
			SendChatMessage(msg, MG_GetAnnounceChannel());
		end
		if(msg ~= "MG-LootList: ") then
			if(MG_Rarity >= MG_Options.AnnounceLevel and IsAddOnLoaded("CT_RaidAssist")) then
				CT_RA_AddMessage("MS MG-Announce: New loot found!");
			end
		end
	end
end

function MG_LootListAdd()
	MG_currentItemlink = nil;
	MG_currentItemslot = nil;

	for i=1, GetNumLootItems(), 1 do
		local MG_icon, MG_name, MG_quantity, MG_rarity = GetLootSlotInfo(i);
		local info = {};
		local dkpVal = 0;

		if(SCR_ItemDKP ~= nil) then
			for i=1, table.getn(SCR_ItemDKP), 1 do
				if(SCR_ItemDKP[i]["n"] == MG_name) then
					dkpVal = SCR_ItemDKP[i]["e"];
				end
			end
		end
		
		if(not LootSlotIsCoin(i) and LootSlotIsItem(i) and (MG_rarity >= MG_Options.LootLevel)) then
			info.text = GetLootSlotLink(i).." ("..dkpVal.." DKP)";
			info.checked = nil;
			info.value = i;
			info.dkpVal = dkpVal;
			info.func = MG_LootListOnClick;
			UIDropDownMenu_AddButton(info);
			if(not MG_currentItemlink) then
				MG_CurrentDKPvalue = info.dkpVal;
				MG_currentItemslot = info.value;
				MG_currentItemlink = GetLootSlotLink(MG_currentItemslot);
				UIDropDownMenu_SetSelectedID(MG_DropDownLootList, i);
			end
		end
	end
end

function MG_AssignLoot()
	local MG_LootListName = GetMasterLootCandidate(MG_GetLootCandidateID(MG_CurrentWinner));

	if(MG_CurrentWinner and MG_LootListName) then
		MG_CONFIRMLOOT = "Transfer "..MG_currentItemlink.." to "..MG_LootListName.." ?";
		
		-- build static dialog with freshly made strings
		StaticPopupDialogs["CONFIRM_TRANSFER"] = {
			text = TEXT(MG_CONFIRMLOOT),
			button1 = TEXT(ACCEPT),
			button2 = TEXT(DECLINE),
			OnAccept = function()
				MG_TransferLoot();
			end,
			timeout = 60,
			showAlert = 1,
		};
		StaticPopup_Show("CONFIRM_TRANSFER");
	else
		MG_Print(MG_ERR_NOWINID);	
	end
	MG_RaidRoll_Assign:Disable();
end

function MG_TransferLoot()
	local MG_icon, MG_name, MG_quantity, MG_rarity = GetLootSlotInfo(MG_currentItemslot);
	if(GetMasterLootCandidate(MG_GetLootCandidateID(MG_CurrentWinner))) then
		GiveMasterLoot(MG_currentItemslot, MG_GetLootCandidateID(MG_CurrentWinner));	
		if(MG_rarity >= MG_Options.AnnounceLevel) then
			msg = "MG-Announce: "..MG_CurrentWinner.." wins "..MG_currentItemlink;
			SendChatMessage(msg, MG_Channel);
		end
	else
		MG_Print(MG_ERR_NOGIVE);
	end
end

function MG_LootListOnClick()
	if(MG_RollInProgress == 0) then
		UIDropDownMenu_SetSelectedID(MG_DropDownLootList, this:GetID());
		MG_CurrentDKPvalue = this.dkpVal;
		MG_currentItemslot = this.value;
		MG_currentItemlink = GetLootSlotLink(MG_currentItemslot);
		MG_Print("(Debug) Item value: "..MG_CurrentDKPvalue.." DKP");
	end
end

function MG_GetLootCandidateID(NameCheck)
	local RaidTotal = GetNumRaidMembers();
	local i, lootName, lootID;
	lootID = 0;
	for i=1, RaidTotal, 1 do
		lootName = GetMasterLootCandidate(i);
		if(lootName and NameCheck == lootName) then
			lootID = i;
			return lootID;
		end
	end
end
---------------------------------------------------------------------
-- Toggles MetaGuild Window.
---------------------------------------------------------------------
function MG_Toggle(arg1)
	if(arg1 == "noClick" and not MG_Options.MenuOnClick) then
		MG_OptionsMenu:Show();
	elseif(arg1 == "RightButton" and MG_Options.MenuOnClick) then
		MG_OptionsMenu:Show();
	elseif(arg1 == "LeftButton") then
		if (MetaGuild:IsVisible()) then
			MetaGuild:Hide();
		else
			MetaGuild:Show();
		end
	end
end

function MG_ToggleOptions()
	if (MG_Options_Visible == 0) then
		local MG_motd = GetGuildRosterMOTD();
		if(MG_motd == nil) then MG_motd = ""; end
		MG_MOTDText1:SetText("MOTD: "..MG_motd);
		MG_ShowRaidMembersButton:Hide();
		MetaGuildBackdrop4:Hide()
		MetaGuildBackdrop5:Show()
		MG_HelpButton1:Hide();
		MG_MOTDText1:Show();
		MG_MOTDText2:Show();
		MG_Options_Visible = 1;
	else
		MG_UtilsReset();
		MG_MOTDText1:Hide();
		MG_MOTDText2:Hide();
		MetaGuildBackdrop5:Hide()
		MetaGuildBackdrop4:Show()
		MG_ShowRaidMembersButton:Show();
		MG_HelpButton1:Show();
		MG_Options_Visible = 0;
		MG_Update();
	end
end

------------------------------------
--Sets the MG_Window_Open variable.
-------------------------------------
function MG_ToggleOpenStatus()
	if(MetaGuild:IsVisible()) then
		return;
	end
	MG_Window_Open = 0
end

----------------------------------------------------------------------------------
---Toggle Stats Window
----------------------------------------------------------------------------------
function MG_ToggleRaidStats()
	if (MG_RaidStats_Visible == 0) then
		MetaGuild_RaidStats:Show();
		MetaGuild_SetRaid:Hide();
		MetaGuild_SetRaid_Event:Hide();
		MetaGuild_MemberDKP:Hide();
		getglobal(MG_ClassLevelSelectText:SetText(MG_Options.StatsLevel));
	else
		MetaGuild_RaidStats:Hide();
	end
end
	
----------------------------------------------------------------------------------
---Toggle Raid Settings Window
----------------------------------------------------------------------------------
function MG_ToggleSetRaid()
	MG_RaidStats_Visible = 0;
	MetaGuild_RaidStats:Hide();
	MetaGuild_MemberDKP:Hide();
	local textSet = getglobal("MetaGuild_SetRaid_Event_Title"):GetText();

	if ((MG_SetRaid_Visible == 0) and (MG_SetRaid_Event_Visible == 0)) then
		if (textSet == nil) then
			MetaGuild_SetRaid:Show();
			MetaGuild_SetRaid_Event:Hide();
		else
			MetaGuild_SetRaid:Hide();
			MetaGuild_SetRaid_Event:Show();
		end
	else
		MetaGuild_SetRaid:Hide();
		MetaGuild_SetRaid_Event:Hide();
	end
end

function MG_ToggleRemote()
	if(MG_RaidRemote:IsVisible()) then
		MetaGuild_SetRaid_EventBackdrop2:SetParent("MetaGuild_SetRaid_Event");
		MetaGuild_SetRaid_EventBackdrop3:SetParent("MetaGuild_SetRaid_Event");
		MetaGuild_SetRaid_EventBackdrop2:SetPoint("TOP", "MetaGuild_SetRaid_EventBackdrop", "BOTTOM", 0, 4);
		MetaGuild_SetRaid_EventBackdrop3:SetPoint("TOP", "MetaGuild_SetRaid_EventBackdrop2", "BOTTOM", 0, 4);
		MG_RaidRemote:Hide();
		MetaGuild:Show();
		MetaGuild_SetRaid_Event:Show();
	else
		MetaGuild_SetRaid_EventBackdrop2:SetParent("MG_RaidRemote");
		MetaGuild_SetRaid_EventBackdrop3:SetParent("MG_RaidRemote");
		MetaGuild_SetRaid_EventBackdrop2:SetPoint("TOP", "MG_RaidRemote", "TOP", 0, 0);
		MetaGuild_SetRaid_EventBackdrop3:SetPoint("TOP", "MetaGuild_SetRaid_EventBackdrop2", "BOTTOM", 0, 4);
		MetaGuild:Hide();
		MG_RaidRemote:Show();
	end
end

----------------------------------------------------------------------------------
---Toggle DKP Display Window
----------------------------------------------------------------------------------
function MG_ToggleDKPFrame()
	if (MG_MemberDKP_Visible == 0) then
		MetaGuild_RaidStats:Hide();
		MetaGuild_SetRaid:Hide();
		MetaGuild_SetRaid_Event:Hide();
		MetaGuild_MemberDKP:Show();
		if(MG_RollInProgress == 1) then
			MG_SetRaidRoll(true);
		else
			MG_MemberDKP_Update();
		end
	else
		MetaGuild_MemberDKP:Hide();
	end
end

function MG_ToggleDKPRemote()
	if(MG_DKPDetached == 0) then
		MG_DKPDetached = 1;
		MetaGuild_MemberDKP:SetMovable(true);
		MetaGuild_MemberDKP:SetPoint("CENTER", "UIParent", "CENTER", 0, 0);
		MetaGuild:Hide();
		MetaGuild_MemberDKP:Show();
		MG_DKPRemoteButton:Show();
	else
		MetaGuild_MemberDKP:ClearAllPoints();
		MetaGuild_MemberDKP:SetPoint("LEFT", "MetaGuild", "RIGHT", -4, 0);
		MetaGuild_MemberDKP:SetMovable(false);
		MetaGuild:Show();
		if(not MetaGuild_MemberDKPBackdrop:IsVisible()) then
			MG_DKP_SetRemote();
		end		
		MG_DKPRemoteButton:Hide();
		MetaGuild_MemberDKP:ClearAllPoints();
		MetaGuild_MemberDKP:SetPoint("LEFT", "MetaGuild", "RIGHT", -4, 0);
		MetaGuild_MemberDKP:Show();
		MG_DKPDetached = 0;
	end
end

function MG_DKP_SetRemote()
	if(MG_DKPDetached == 1) then
		if(MG_DKPRemote:IsVisible()) then
			local x, y = MG_DKPRemote:GetCenter();
			MetaGuild_MemberDKP:ClearAllPoints();
			MetaGuild_MemberDKP:SetPoint("BOTTOM", "MG_DKPRemote", "BOTTOM", 0, 11);
			MetaGuild_MemberDKP:Show();
			MetaGuild_MemberDKPBackdrop:Show();
			MetaGuild_MemberDKPBackdrop1:Show();
			MetaGuild_MemberDKPBackdrop2:SetParent("MetaGuild_MemberDKP");
			MetaGuild_MemberDKPBackdrop3:SetParent("MetaGuild_MemberDKP");
			MetaGuild_MemberDKPBackdrop2:SetPoint("TOP", "MetaGuild_MemberDKPBackdrop", "BOTTOM", 0, 4);
			MetaGuild_MemberDKPBackdrop3:SetPoint("TOP", "MetaGuild_MemberDKPBackdrop2", "BOTTOM", 0, 4);
			MG_DKPRemote:Hide();
		else
			MetaGuild_MemberDKPBackdrop:Hide();
			MetaGuild_MemberDKPBackdrop1:Hide();
			MetaGuild_MemberDKPBackdrop2:SetParent("MG_DKPRemote");
			MetaGuild_MemberDKPBackdrop3:SetParent("MG_DKPRemote");
			MetaGuild_MemberDKPBackdrop2:SetPoint("TOP", "MG_DKPRemote", "TOP", 0, 0);
			MetaGuild_MemberDKPBackdrop3:SetPoint("TOP", "MetaGuild_MemberDKPBackdrop2", "BOTTOM", 0, 4);
			MetaGuild_MemberDKP:Hide();
			MG_DKPRemote:Show();
		end
	end	
end

function MG_SetRaidRoll(show)
	if(show) then
		MG_RaidRoll_Assign:Disable();
		MG_RaidRoll_End:Disable();
		MG_ShowDKPRaidButton:Hide();
		MG_DKP_UpdateButton:Hide();
		MG_DKP_Roller:Hide();
		MG_SetRaidRoll_Back:Show();
		MG_MemberDKP_Title:SetText("");
		MG_DKPColumnHeader3:SetText(MG_COLUMN_TEXT12);
		MG_RaidRollDKPCheck:Show();
		MG_RaidRoll_Start:Show();
		MG_RaidRoll_Assign:Show();
		MG_RaidRoll_End:Show();
		MG_DropDownLootList:Show();
		for i=1, MG_DKP_TO_DISPLAY, 1 do
			getglobal("MG_MemberDKP_Button"..i):Hide();
		end
		MG_RaidRollDKPCheck:SetChecked(MG_UseDKPRoll);
		MG_MemberDKP_Update()
	else
		MG_SetRaidRoll_Back:Hide();
		MG_RaidRoll_Start:Hide();
		MG_RaidRoll_Assign:Hide();
		MG_RaidRoll_End:Hide();
		MG_RaidRollDKPCheck:Hide();
		MG_DropDownLootList:Hide();
		MG_DKP_UpdateButton:Show();
		MG_DKP_Roller:Show();
		MG_ShowDKPRaidButton:Show();
		MG_DKPColumnHeader3:SetText(MG_COLUMN_TEXT11);
		MG_MemberDKP_Update()
	end
end

function MG_ClassLevelSelect()
	MG_Options.StatsLevel = MG_Options.StatsLevel +1;
	if(MG_Options.StatsLevel > 60) then
		MG_Options.StatsLevel = 50;
	end
	getglobal(MG_ClassLevelSelectText:SetText(MG_Options.StatsLevel));
	MG_Update();
end

----------------------------------------------------------------------------------
---Messaging handlers
----------------------------------------------------------------------------------
function MG_Print(msg, r, g, b, frame)
	msg = "<"..MG_NAME..">: "..msg;
	if ( not r ) then r=1.0; end;
	if ( not g ) then g=1.0; end;
	if ( not b ) then b=1.0; end;
	if ( frame ) then
		frame:AddMessage(msg,r,g,b);
	else
		DEFAULT_CHAT_FRAME:AddMessage(msg, r, g, b);
	end
end

function MG_GetAnnounceChannel()
	local MG_AnnounceChannel;
	if(GetNumRaidMembers() ~= 0) then
		MG_AnnounceChannel="RAID";
	elseif(GetNumPartyMembers() ~= 0) then
		MG_AnnounceChannel="PARTY";
	end
	return MG_AnnounceChannel;
end

function MG_ChatFrame_Open()
	if(MG_ChatFrame == nil) then
		MG_ChatFrame = ChatFrame_OnEvent;
		ChatFrame_OnEvent = MG_ChatFrame_OnEvent;
	end
end

function MG_ChatFrame_Close()
	if(MG_ChatFrame ~= nil) then
		ChatFrame_OnEvent = MG_ChatFrame;
		MG_ChatFrame = nil;
	end
end

function MG_ChatFrame_OnEvent(event)
	local msg = arg1;
	local plr = arg2;

	if(event == "CHAT_MSG_WHISPER" and MG_BroadCast == 1) then
		local InviteKey = MG_InviteKey_EditBox:GetText();
		if(strlower(msg) == strlower(InviteKey)) then
			MG_AutoInvite(plr);
			return;
		end
	end

	if(event == "CHAT_MSG_SYSTEM" and MG_RollInProgress == 1 and not MG_Options.UseGMroll) then
		if(string.find(msg, "rolls", 1, true)) then
			local i, j, MG_rollerName, MG_rollValue;
			i, j, MG_rollerName, MG_rollValue = string.find(arg1, "([^ ]+) rolls ([^ ]+) ");
			MG_RaidRoll_Update(MG_rollerName, MG_rollValue);
		end
	end

	if(event == "CHAT_MSG_PARTY" or event == "CHAT_MSG_RAID" or event == "CHAT_MSG_CTRAID" or event == "CHAT_MSG_SAY") then
		local MG_lootMethod, MG_masterLooter = GetLootMethod();
		if(MG_RollInProgress == 1 and MG_Options.UseGMroll and MG_lootMethod == "master" and MG_masterLooter == 0) then
			if(strlower(msg) == strlower(MG_RollKeyWord) and MG_RollInProgress == 1) then
				MG_RaidRoll_Update(plr);
				return;
			end
		end
	end
	MG_ChatFrame(event);
end

function MG_BroadcastRaidInfo()
	local myName = UnitName("Player");
	local curRaid = MG_RaidList[MG_Raid_Current]["RaidName"];
	local raidSize = MG_SetRaidSize_EditBox:GetText();
	local minLev = MG_SetRaidMinLev_EditBox:GetText();
	local maxLev = MG_SetRaidMaxLev_EditBox:GetText();
	local InviteKey = MG_InviteKey_EditBox:GetText();
	MG_BroadcastTimer = tonumber(MG_BcTimer_EditBox:GetText()) *2;
	MG_BcastWarning_Text:Show();
	local msg = "MG-Announce: Invites for "..curRaid.." started. ";
	if(minLev == nil or minLev == "")then
		msg = msg.."Lvl "..maxLev.." required";
	else
		msg = msg.."Lvl "..minLev.. " - "..maxLev.." required. ";
	end
	msg = msg.."[/w "..myName.." "..InviteKey.."] Currently "..GetNumRaidMembers().." of "..raidSize.." in raid."

	if(not MG_SilentBroadcastButton:GetChecked()) then
		SendChatMessage(msg, "GUILD", this.language, GetChannelName(MG_Channel));
	end
	MG_BroadCast = 1;
	MG_ChatFrame_Open();
end

function MG_StopBroadcast()
	MG_BroadCast = 0;
	MG_Print(MG_BCAST_STATUS);
	MG_BcastWarning_Text:Hide();
	MG_ChatFrame_Close()
end

function MG_AutoInvite(arg2)
	local index = nil;

	for i = 1, table.getn(MG_GuildList),1 do
		if(MG_GuildList[i].f_name == arg2) then
			index = i;
		end
	end
	if(index == nil) then
		SendChatMessage("You are not a member of this Guild!", "WHISPER", GetDefaultLanguage("player"), arg2);
		return;
	end

	if(MG_GuildList[index].f_checked == 1 or MG_GuildList[index].f_invited == 1) then
		return;
	end
	MG_GuildList[index].f_checked = 1;
	if(GetNumPartyMembers() == 0 and GetNumRaidMembers() == 0 and MG_RaidStarted == 0) then
		InviteByName(MG_GuildList[index].f_name);
		MG_GuildList[index].f_checked = 0;
		MG_GuildList[index].f_invited = 1;
		local pClass, eClass = UnitClass("player");
		MG_InviteCount[pClass] = MG_InviteCount[pClass] + 1;
		local uClass = MG_GuildList[index].f_class;
		MG_InviteCount[uClass] = MG_InviteCount[uClass] + 1;
		MG_InviteCount.Total = MG_InviteCount.Total + 2;
		MG_RaidStarted = 1;
	end
end

function MG_UpdateInviteList()
	MG_InviteCount.Warrior = MG_RaidCount.Warrior;
	MG_InviteCount.Mage = MG_RaidCount.Mage;
	MG_InviteCount.Druid = MG_RaidCount.Druid;
	MG_InviteCount.Warlock = MG_RaidCount.Warlock;
	MG_InviteCount.Shaman = MG_RaidCount.Shaman;
	MG_InviteCount.Paladin = MG_RaidCount.Paladin;
	MG_InviteCount.Hunter = MG_RaidCount.Hunter;
	MG_InviteCount.Rogue = MG_RaidCount.Rogue;
	MG_InviteCount.Priest = MG_RaidCount.Priest;
	MG_InviteCount.Total = MG_RaidCount.Total;
	for i = 1,table.getn(MG_GuildList),1 do
		MG_GuildList[i].f_invited = 0;
	end
end

function MG_CheckRaidClass(uClass, uName)
	local raidLimit = tonumber(MG_SetRaidSize_EditBox:GetText()) - 1;

	if(MG_InviteCount.Total > raidLimit) then
		SendChatMessage("Sorry, Raid is now full.", "WHISPER", GetDefaultLanguage("player"), uName);
		return false;
	end
	local Class_Limit = {
		[MG_WARRIOR_TITLE] = tonumber(MG_Warrior_EditBox:GetText()),
		[MG_WARLOCK_TITLE] = tonumber(MG_Warlock_EditBox:GetText()),
		[MG_PRIEST_TITLE] = tonumber(MG_Priest_EditBox:GetText()),
		[MG_ROGUE_TITLE] = tonumber(MG_Rogue_EditBox:GetText()),
		[MG_DRUID_TITLE] = tonumber(MG_Druid_EditBox:GetText()),
		[MG_PALADIN_TITLE] = tonumber(MG_Paladin_EditBox:GetText()),
		[MG_SHAMAN_TITLE] = tonumber(MG_Paladin_EditBox:GetText()),
		[MG_HUNTER_TITLE] = tonumber(MG_Hunter_EditBox:GetText()),
		[MG_MAGE_TITLE] = tonumber(MG_Mage_EditBox:GetText())
	};

	if (MG_InviteCount[uClass] < Class_Limit[uClass]) then
		MG_InviteCount[uClass] = MG_InviteCount[uClass] + 1;
		MG_InviteCount.Total = MG_InviteCount.Total + 1;
		return true;
	else
		SendChatMessage("Class Limit for '" .. uClass .. "' reached. Please await final status of raid.", "WHISPER", GetDefaultLanguage("player"), uName);
		return false;
	end
end

----------------------------------------------------------------------------------
---Guild Utilities
----------------------------------------------------------------------------------
function MG_SetMOTD_OnClick()
	if(MG_SetMOTDButton:GetText() == "MOTD") then
		MetaGuildBackdrop6:Show();
		MetaGuildBackdrop3:Hide();
		MG_SetMOTDButton:SetText("Save");
		MG_InviteButton:Hide();
		MG_SetRankButton:Hide()
		MG_RemoveCharButton:Hide();
		MG_SetNoteButton:Hide();
	else
		local text = MG_Utils_EditBox:GetText();
		if (text ~= "") then
			GuildSetMOTD(text);
		end
		MG_UtilsReset();
	end
end

function MG_GuildInvite_OnClick()
	if(MG_InviteButton:GetText() == "GuildInvite") then
		MetaGuildBackdrop6:Show();
		MetaGuildBackdrop3:Hide();
		MG_InviteButton:SetText("Invite");
		MG_SetMOTDButton:Hide();
		MG_SetRankButton:Hide()
		MG_RemoveCharButton:Hide();
		MG_SetNoteButton:Hide();
	else
	local text = MG_Utils_EditBox:GetText();
		if (text ~= "") then
			GuildInviteByName(text);
		end
		MG_UtilsReset();
	end
end

function MG_SetRanks_OnClick()
	if(MG_SetRankButton:GetText() == "SetRanks") then
		MetaGuildBackdrop6:Show();
		MetaGuildBackdrop3:Hide();
		MG_Utils_EditBox:Hide();
		MG_SetRankButton:SetText("Update");
		MG_SetMOTDButton:Hide();
		MG_InviteButton:Hide();
		MG_RemoveCharButton:Hide();
		MG_SetNoteButton:Hide();
		UIDropDownMenu_ClearAll(MG_DropDownRankList);
		UIDropDownMenu_Initialize(MG_DropDownRankList, MG_RankList_Init);
		MG_DropDownRankList:Show();
	else
		MG_SetGuildRank();
		MG_UtilsReset();
	end
end

function MG_RankList_Init()
	local info = {};
	local ranks = GuildControlGetNumRanks();
	for i=1, ranks,1 do
		info.text = GuildControlGetRankName(i);
		info.checked = nil;
		info.value = i;
		info.func = MG_RankListOnClick;
		UIDropDownMenu_AddButton(info);
		if(MG_currentRankIndex == nil) then
			MG_currentRankIndex = i;
			UIDropDownMenu_SetSelectedID(MG_DropDownRankList, i);
		end
	end
end

function MG_RankListOnClick()
	UIDropDownMenu_SetSelectedID(MG_DropDownRankList, this:GetID());
	MG_currentRankIndex = this.value;
end

function MG_SetGuildRank()
	local ranks = GuildControlGetNumRanks();
	for i=1, table.getn(MG_GuildList),1 do
		if(MG_GuildList[i].f_checked == 1) then
			MG_GuildList[i].f_checked = 0;
			for i=1, ranks,1 do
				if(MG_currentRankIndex > MG_GuildList[i].f_rankIndex) then
					GuildPromoteByName(MG_GuildList[i].f_name);
					MG_GuildList[i].f_rankIndex = MG_GuildList[i].f_rankIndex +1;
				elseif(MG_currentRankIndex < MG_GuildList[i].f_rankIndex) then
					GuildDemoteByName(MG_GuildList[i].f_name);
					MG_GuildList[i].f_rankIndex = MG_GuildList[i].f_rankIndex -1;
				end
			end
		end
	end
end

function MG_ConfirmRemoveChar()
	StaticPopupDialogs["CONFIRM_TRANSFER"] = {
		text = TEXT(MG_CONFIRM_REMOVE),
		button1 = TEXT(ACCEPT),
		button2 = TEXT(DECLINE),
		OnAccept = function()
			MG_RemoveGuildChar();
		end,
		timeout = 60,
		showAlert = 1,
	};
	StaticPopup_Show("CONFIRM_TRANSFER");
end

function MG_RemoveGuildChar()
	for i=1, table.getn(MG_GuildList),1 do
		if(MG_GuildList[i].f_checked == 1) then
			MG_GuildList[i].f_checked = 0;
			GuildUninviteByName(MG_GuildList[i].f_name) 
			table.remove(MG_GuildList, i);
		end
	end
end

function MG_SetGuildNote()
	if(MG_SetNoteButton:GetText() == "SetNote") then
		MetaGuildBackdrop6:Show();
		MetaGuildBackdrop3:Hide();
		MG_SetNoteButton:SetText("Save");
		MG_SetMOTDButton:Hide();
		MG_InviteButton:Hide();
		MG_SetRankButton:Hide()
		MG_RemoveCharButton:Hide();
		MG_NoteTypeFrame:Show();
	else
		local text = MG_Utils_EditBox:GetText();
		for i=1, table.getn(MG_GuildList),1 do
			if(MG_GuildList[i].f_checked == 1) then
				MG_GuildList[i].f_checked = 0;
				local index = MG_ReturnRosterIndex(MG_GuildList[i].f_name);
				if(index > 0) then
					if(MG_NoteTypeSelectText:GetText() == MG_SETNOTE_TYPE1) then
						GuildRosterSetPublicNote(index, text);
						MG_GuildList[i].f_note = text;
					elseif(MG_NoteTypeSelectText:GetText() == MG_SETNOTE_TYPE2) then
						MG_GuildList[i].f_p_note = text;
					elseif(MG_NoteTypeSelectText:GetText() == MG_SETNOTE_TYPE3) then
						GuildRosterSetOfficerNote(index, text);
						MG_GuildList[i].f_officernote = text;
					end
				end
			end
		end
		MG_UtilsReset();
	end
end

function MG_ToggleNoteType()
	if(MG_NoteTypeSelectText:GetText() == MG_SETNOTE_TYPE1) then
		MG_NoteTypeSelectText:SetText(MG_SETNOTE_TYPE2);
	elseif(MG_NoteTypeSelectText:GetText() == MG_SETNOTE_TYPE2) then
		MG_NoteTypeSelectText:SetText(MG_SETNOTE_TYPE3);
	elseif(MG_NoteTypeSelectText:GetText() == MG_SETNOTE_TYPE3) then
		MG_NoteTypeSelectText:SetText(MG_SETNOTE_TYPE1);
	end
end

function MG_UtilsReset()
	MG_currentRankIndex = nil;
	MG_Utils_EditBox:Show();
	MG_DropDownRankList:Hide();
	MG_NoteTypeFrame:Hide();
	MG_SetMOTDButton:SetText("MOTD");
	MG_InviteButton:SetText("GuildInvite");
	MG_SetRankButton:SetText("SetRanks");
	MG_SetNoteButton:SetText("SetNote");
	MG_SetMOTDButton:Show();
	MG_InviteButton:Show();
	MG_SetRankButton:Show()
	MG_RemoveCharButton:Show();
	MG_SetNoteButton:Show();
	MetaGuildBackdrop3:Show();
	MetaGuildBackdrop6:Hide();
	MG_Options_Visible = 0;
	MG_Update();
	MG_ToggleOptions();
end

function MG_ReturnRosterIndex(fName)
	local MG_numGuildMembers = GetNumGuildMembers();

	for i=1,MG_numGuildMembers, 1 do
		MG_name, MG_rank, MG_rankIndex, MG_level, MG_class, MG_zone, MG_note, MG_officernote, MG_online = GetGuildRosterInfo(i);
		if(MG_name == fName) then
			return i;
		end
	end
	return 0;
end

----------------------------------------------------------------------------------
---Help & Tooltips
----------------------------------------------------------------------------------
function MG_ShowExtNote(id)
	local Button = getglobal("MG_Button"..id.."Note");
	MG_Tooltip:SetOwner(Button, "ANCHOR_CENTER");
	MG_Tooltip:AddLine(Button:GetText(), 1, 1, 0.5, true);
	MG_Tooltip:SetScale(0.85);
	MG_Tooltip:Show();
end

function MG_ShowHelp1()
	local hText = MG_HELP1_TEXT1.."\n\n"..MG_HELP1_TEXT2;
	MG_Tooltip:SetOwner(this, "ANCHOR_CENTER");
	MG_Tooltip:AddLine(hText, 1, 1, 0.5, true);
	MG_Tooltip:SetScale(0.85);
	MG_Tooltip:Show();
end

function MG_ShowHelp2()
	local hText = MG_HELP2_TEXT1;
	MG_Tooltip:SetOwner(this, "ANCHOR_CENTER");
	MG_Tooltip:AddLine(hText, 1, 1, 0.5, true);
	MG_Tooltip:SetScale(0.85);
	MG_Tooltip:Show();
end

----------------------------------------------------------------------------------
---Minimap button
----------------------------------------------------------------------------------
function MG_UpdateMinimapIcon()
	MG_Options.MinimapArcOffset = MG_ArcSlider:GetValue();
	MG_MinimapButton:SetPoint( "TOPLEFT", "Minimap", "TOPLEFT",
		54 - ((84) * cos(MG_Options.MinimapArcOffset)),
		((84) * sin(MG_Options.MinimapArcOffset)) - 54);
end

function MG_ButtonMenu_OnShow()
	local MG_guildName = GetGuildInfo("player");
	if(MG_guildName == nil) then
		MG_guildName = MG_GUILD_NONSTATUS;
	end
	MG_ChatFrame_Open();
	MG_ButtonMenu_Count = 0;
	MG_RaidInfoTitle:SetText("");
	RequestRaidInfo();
	MG_Update();
	MG_GuildInfoMenuHeader:SetText(MG_guildName);
	MG_GuildInfoMenu:SetText("|cffffffffMembers: |cff00ff00"..MG_TotalNumGuildMembers.."  |cffffffffOnline: |cff00ff00"..MG_NumOnline);
	getglobal(MG_SetLootLevelBG:SetTexture(MG_IMAGE_PATH.."Color"..MG_Options.LootLevel));
	getglobal(MG_SetAnnounceLevelBG:SetTexture(MG_IMAGE_PATH.."Color"..MG_Options.AnnounceLevel));
	if(GetNumSavedInstances() > 0) then
		for i=1, GetNumSavedInstances() do
			local name, ID, remaining = GetSavedInstanceInfo(i);
			remaining = SecondsToTime(remaining);
			MG_RaidInfoTitle:SetText("|cffffffff"..name.." "..ID.."\n|cff00ff00"..remaining);
			MG_ButtonMenu_Count = MG_ButtonMenu_Count +1;
		end
	else
		MG_RaidInfoTitle:SetText(MG_RAIDINFO_NOSAVE);
		MG_ButtonMenu_Count = 1;
	end
	MG_OptionsMenu:SetHeight((MG_ButtonMenu_Count * 30) +240);
	MG_OptionsMenuBackdrop1:SetHeight((MG_ButtonMenu_Count * 30) +70);
	MG_ShowMiniButton:SetChecked(MG_Options.MiniButton);
	local x, y = GetCursorPosition();
	x = x / UIParent:GetEffectiveScale() +5;
	y = y / UIParent:GetEffectiveScale() +5;
	MG_OptionsMenu:ClearAllPoints();
	MG_OptionsMenu:SetPoint("TOPRIGHT", UIParent, "BOTTOMLEFT", x, y);
end

function MG_SetLootLevel_OnClick()
	MG_Options.LootLevel = MG_Options.LootLevel +1;
	if(MG_Options.LootLevel > 5) then
		MG_Options.LootLevel = 1;
	end
	getglobal(MG_SetLootLevelBG:SetTexture(MG_IMAGE_PATH.."Color"..MG_Options.LootLevel));
end

function MG_SetAnnounceLevel_OnClick()
	MG_Options.AnnounceLevel = MG_Options.AnnounceLevel +1;
	if(MG_Options.AnnounceLevel > 5) then
		MG_Options.AnnounceLevel = 1;
	end
	getglobal(MG_SetAnnounceLevelBG:SetTexture(MG_IMAGE_PATH.."Color"..MG_Options.AnnounceLevel));
end

function MG_ButtonMenu_OnUpdate()
	if (MG_OptionsMenu:IsVisible()) then
		if (not MouseIsOver(MG_OptionsMenu) and not MouseIsOver(MG_MinimapButton) and not MouseIsOver(MG_ArcSlider)) then
			MG_OptionsMenu:Hide();
		end
	end
end

function MG_ButtonMenu_OnClick()
	MG_Options.MiniButton = not MG_Options.MiniButton;
	if(MG_Options.MiniButton) then
		MG_MinimapButton:Show();
	else
		MG_MinimapButton:Hide();
	end
end

----------------
-- FuBar Support
----------------
function MG_FuBarUpdate()
	if (IsAddOnLoaded("FuBar")) then
		MetaGuildFu:UpdateText();
	end
end

function MG_FuBar_OnLoad()
	local dewdrop = DewdropLib:GetInstance('1.0')
	
	MetaGuildFu 		= FuBarPlugin:GetInstance("1.2"):new({
	name          = MG_NAME,
	version       = MG_VERSION,
	description   = MG_DESC,
	aceCompatible = 103,
	category      = "map",
	hasIcon 			= MG_ICON,
	})

	function MetaGuildFu:Enable()
		if(MG_Options.MiniButton) then
			MG_MinimapButton:Show();
		else
			MG_MinimapButton:Hide();
		end
	end

	function MetaGuildFu:OnClick()
		MG_Toggle(arg1);
	end
	function MetaGuild:UpdateTooltip()
	end

	function MetaGuildFu:MenuSettings(level, value)		
		local info = {}
		if ( level == 1 ) then
			dewdrop:AddLine(
				'text', MG_SHOWBUTTON_TEXT,
				'func', function()
					MG_ButtonMenu_OnClick() 
					self:Update()
				end,
				'checked', MG_Options.MiniButton,
				'level', 1,
				'closeWhenClicked', false
			)		
		end
	end

	function MetaGuildFu:UpdateText()
		self:SetText("|cff00ff00"..MG_TotalNumGuildMembers.."/|cff00ff00"..MG_NumOnline);
	end

	MetaGuildFu:RegisterForLoad();
end

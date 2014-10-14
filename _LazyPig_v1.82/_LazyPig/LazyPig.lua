local Original_SelectGossipActiveQuest = SelectGossipActiveQuest;
local Original_SelectGossipAvailableQuest = SelectGossipAvailableQuest;
local OriginalLootFrame_OnEvent = LootFrame_OnEvent;
local OriginalLootFrame_Update = LootFrame_Update;
local OriginalUseContainerItem = UseContainerItem;

local roster_task_refresh = 0
local roster_check = true
local player_summon_confirm = false
local player_summon_message = false
local player_bg_confirm = false
local player_bg_message = false
local player_invite_start = nil
local afk_active = false
local dnd_active = false
local save_time = 0
local last_click = 0
local QuestRecord = {}

LPCONFIG = {CAM = false, GINV = true, FINV = false, SUMM = true, REZ = true, BG = true, LOOT = true, EPLATE = false, SPLIT = true}
LPSPLIT = {VALUE = 1}

function LazyPig_OnLoad()
	SelectGossipActiveQuest = LazyPig_SelectGossipActiveQuest;
	SelectGossipAvailableQuest = LazyPig_SelectGossipAvailableQuest;
	LootFrame_OnEvent = LazyPig_LootFrame_OnEvent;
	LootFrame_Update = LazyPig_LootFrame_Update;
	UseContainerItem = LazyPig_UseContainerItem;
	
	SLASH_LAZYPIG1 = "/lp";
	SLASH_LAZYPIG2 = "/lazypig";
	SlashCmdList["LAZYPIG"] = LazyPig_Command;
	
	SLASH_LAZYPIGSPLIT1 = "/lps";
	SlashCmdList["LAZYPIGSPLIT"] = LazyPigSplit_Command;
	
	this:RegisterEvent("PLAYER_ENTERING_WORLD")
	if(DEFAULT_CHAT_FRAME) then	DEFAULT_CHAT_FRAME:AddMessage("_LazyPig by Ogrisch loaded type |cff00ff00 /lp |cffffffff for options")	end
end

function LazyPig_Command(cmd)
	if(cmd ~= "") then
		for i=1,10 do
			if i == 10 then
				DEFAULT_CHAT_FRAME:AddMessage("|cffff0000".."LazyPig: The syntax of the command is incorrect")
			elseif tonumber(cmd) == i then
				LazyPig_ToggleOption(i)
				LazyPig_StatusList()
				break			
			end
		end
	else
		LazyPig_StatusList()
	end
end

function LazyPigSplit_Command(cmd)
	for i=1,100 do
		if not LPCONFIG.SPLIT then
			DEFAULT_CHAT_FRAME:AddMessage("|cffff0000".."LazyPig: Value cannot be set enable Auto Split first")
			break		
		elseif i == 100 then
			DEFAULT_CHAT_FRAME:AddMessage("|cffff0000".."LazyPig: Value must be between 1-99")
		elseif tonumber(cmd) == i then
			DEFAULT_CHAT_FRAME:AddMessage("LazyPig: Split value set to "..i)
			LPSPLIT.VALUE = i
			break			
		end
	end
end

function LazyPig_ToggleOption(i)
	if i == 1 then LPCONFIG.CAM = not LPCONFIG.CAM
		if LPCONFIG.CAM then SetCVar("cameraDistanceMax",50) else SetCVar("cameraDistanceMax",15) end
	elseif i == 2 then LPCONFIG.GINV = not LPCONFIG.GINV 
	elseif i == 3 then LPCONFIG.FINV = not LPCONFIG.FINV 
	elseif i == 4 then LPCONFIG.SUMM = not LPCONFIG.SUMM 
	elseif i == 5 then LPCONFIG.REZ = not LPCONFIG.REZ
	elseif i == 6 then LPCONFIG.BG = not LPCONFIG.BG 
	elseif i == 7 then LPCONFIG.LOOT = not LPCONFIG.LOOT 
		if LPCONFIG.LOOT then UIPanelWindows["LootFrame"] = nil end
	elseif i == 8 then LPCONFIG.SPLIT = not LPCONFIG.SPLIT
	elseif i == 9 then LPCONFIG.EPLATE = not LPCONFIG.EPLATE 
		if LPCONFIG.EPLATE then ShowNameplates() else HideNameplates() end 
	end	
end

function LazyPig_ReturnOptionState(i)
	if i == 1 and LPCONFIG.CAM
	or i == 2 and LPCONFIG.GINV
	or i == 3 and LPCONFIG.FINV
	or i == 4 and LPCONFIG.SUMM
	or i == 5 and LPCONFIG.REZ
	or i == 6 and LPCONFIG.BG 
	or i == 7 and LPCONFIG.LOOT
	or i == 8 and LPCONFIG.SPLIT
	or i == 9 and LPCONFIG.EPLATE then return " |cff00ff00 ON"
	else return " |cffff0000 OFF" 
	end	
end

function LazyPig_StatusList()
	DEFAULT_CHAT_FRAME:AddMessage("type /lp".."|cff00ff00 index ".."|cffffffff".."- to toggle state");
	DEFAULT_CHAT_FRAME:AddMessage("> |cff00ff00".."1".."|cffffffff".." - Extended Camera Distance"..LazyPig_ReturnOptionState(1));
	DEFAULT_CHAT_FRAME:AddMessage("> |cff00ff00".."2".."|cffffffff".." - Auto Invite form Guildmates "..LazyPig_ReturnOptionState(2));
	DEFAULT_CHAT_FRAME:AddMessage("> |cff00ff00".."3".."|cffffffff".." - Auto Invite from Friends "..LazyPig_ReturnOptionState(3));
	DEFAULT_CHAT_FRAME:AddMessage("> |cff00ff00".."4".."|cffffffff".." - Auto Summon Confirm"..LazyPig_ReturnOptionState(4));
	DEFAULT_CHAT_FRAME:AddMessage("> |cff00ff00".."5".."|cffffffff".." - Auto Resurrection Confirm"..LazyPig_ReturnOptionState(5));
	DEFAULT_CHAT_FRAME:AddMessage("> |cff00ff00".."6".."|cffffffff".." - Auto BG Enter/Leave"..LazyPig_ReturnOptionState(6));
	DEFAULT_CHAT_FRAME:AddMessage("> |cff00ff00".."7".."|cffffffff".." - Auto Loot Window"..LazyPig_ReturnOptionState(7));
	DEFAULT_CHAT_FRAME:AddMessage("> |cff00ff00".."8".."|cffffffff".." - Auto Split (/lps value - to change split result)"..LazyPig_ReturnOptionState(8));
	DEFAULT_CHAT_FRAME:AddMessage("> |cff00ff00".."9".."|cffffffff".." - Enemy Name Plates"..LazyPig_ReturnOptionState(9));
end

function LazyPig_OnUpdate()
	local current_time = GetTime()
	if(not dnd_active and not afk_active) then
		if(player_bg_confirm) then
			Check_Bg_Status()
		end
		if(player_summon_confirm) then
			LazyPig_AutoSummon()
		end
	end	
	
	if((current_time - roster_task_refresh) > 29) then
		roster_task_refresh = GetTime()
		roster_check = true	
	
	elseif(roster_check) then
		roster_check = false
		GuildRoster()
	end
	
	if((save_time ~= 0) and not GetBattlefieldWinner() and (GetTime() - save_time) > 3 and not UnitAffectingCombat("player")) then	
		save_time = 0
		SaveData()
	end
	
	if player_invite_start and (GetTime() + 0.5) > player_invite_start then
		player_invite_start = nil
		AcceptGroup()
		StaticPopup_Hide("PARTY_INVITE");
		PlaySoundFile("Sound\\Doodad\\BellTollNightElf.wav")
		UIErrorsFrame:AddMessage("Auto Accept Group")
	end	
end

function LazyPig_OnEvent(event)	  
	if (event == "PLAYER_ENTERING_WORLD") then
		this:RegisterEvent("CHAT_MSG_SYSTEM")
		this:RegisterEvent("PARTY_INVITE_REQUEST")
		this:RegisterEvent("CONFIRM_SUMMON")
		this:RegisterEvent("CANCEL_SUMMON")
		this:RegisterEvent("RESURRECT_REQUEST")
		this:RegisterEvent("UPDATE_BATTLEFIELD_STATUS")
		this:RegisterEvent("BATTLEFIELDS_SHOW")
		this:RegisterEvent("GOSSIP_SHOW")
		this:RegisterEvent("UI_ERROR_MESSAGE")
		this:RegisterEvent("CHAT_MSG_LOOT")
		this:RegisterEvent("QUEST_PROGRESS")
		this:RegisterEvent("QUEST_COMPLETE")

		Check_Bg_Status()
		LazyPig_AutoLeaveBG()
		LazyPig_AutoSummon()
		
		if LPCONFIG.EPLATE then ShowNameplates() end
		if LPCONFIG.CAM then SetCVar("cameraDistanceMax",50) end
		if LPCONFIG.LOOT then UIPanelWindows["LootFrame"] = nil end
		
		if(LPCONFIG.SPLIT and MailTo_Option) then -- and not MailTo_Option.noauction
			MailTo_Option.noshift = true -- to avoid conflicts with mailto addon
		end

		--TargetUnit("player")
		--SendChatMessage(".exp 5", "SAY") --scriptcraft version
	
	elseif(event == "CHAT_MSG_LOOT") then
		if((string.find(arg1 ,"You won") or string.find(arg1 ,"You receive")) and (string.find(arg1 ,"cffa335e") or string.find(arg1, "cff0070d") and not string.find(arg1 ,"Bijou") and not string.find(arg1 ,"Idol") and not string.find(arg1 ,"Shard"))) then
			save_time = GetTime()
		end
	
	elseif(event == "UI_ERROR_MESSAGE" and string.find(arg1, "mounted")) then
		LazyPig_Dismount()
		
	elseif (event == "CHAT_MSG_SYSTEM") then
		if(arg1 == CLEARED_DND or arg1 == CLEARED_AFK) then
			dnd_active = false
			afk_active = false
			UIErrorsFrame:AddMessage("Lazy Pig Status: Active")
			
		elseif(string.find(arg1, string.sub(MARKED_DND, 1, string.len(MARKED_DND) -3))) then
			dnd_active = true
			UIErrorsFrame:AddMessage("Lazy Pig Status: Inactive")
		
		elseif(LPCONFIG.BG and not dnd_active and string.find(arg1, string.sub(MARKED_AFK, 1, string.len(MARKED_AFK) -2))) then
			UIErrorsFrame:AddMessage("Lazy Pig Status: Auto join BG inactive")
			afk_active = true
		
		elseif string.find(arg1,"completed") then
			LazyPig_ReplyQuest(nil, true)
		end
	
	elseif(event == "GOSSIP_SHOW") then
		local GossipOptions = {};
		local gossipnr = nil
		local gossipbreak = nil
		_,GossipOptions[1],_,GossipOptions[2],_,GossipOptions[3],_,GossipOptions[4],_,GossipOptions[5]=  GetGossipOptions()
		for i=1, getn(GossipOptions) do
			if GetGossipAvailableQuests() or GetGossipActiveQuests() then
				gossipbreak = true
			end
			if (GossipOptions[i] == "taxi" or GossipOptions[i] == "battlemaster") then 
				gossipnr = i
				LazyPig_Dismount()
			end
		end
		if not gossipbreak and gossipnr then
			SelectGossipOption(gossipnr)
		end
		LazyPig_RecordQuest()
		LazyPig_ReplyQuest(event)
		--DEFAULT_CHAT_FRAME:AddMessage(event)

	elseif(event == "QUEST_PROGRESS" or event == "QUEST_COMPLETE") then
		LazyPig_ReplyQuest(event)
		--DEFAULT_CHAT_FRAME:AddMessage(event)
	
	elseif(not dnd_active) then
		if (event == "UPDATE_BATTLEFIELD_STATUS" and not afk_active) then
			Check_Bg_Status()
			LazyPig_AutoLeaveBG()
		
		elseif (event == "BATTLEFIELDS_SHOW" and not afk_active) then
			Check_Bg_Status()
		
		elseif (event == "CONFIRM_SUMMON") then	
			LazyPig_AutoSummon()
		
		elseif (event == "CANCEL_SUMMON") then	
			player_summon_confirm = false	
		
		elseif (event == "PARTY_INVITE_REQUEST") then
			if LPCONFIG.GINV and IsGuildMate(arg1) then
				player_invite_start = GetTime()
			elseif LPCONFIG.FINV and IsFriend(arg1) then
				player_invite_start = GetTime()
			end
		
		elseif (event == "RESURRECT_REQUEST") and LPCONFIG.REZ then
			if (GetCorpseRecoveryDelay() == 0) then
				AcceptResurrect()
				StaticPopup_Hide("RESURRECT_NO_TIMER"); 
				StaticPopup_Hide("RESURRECT_NO_SICKNESS");
				StaticPopup_Hide("RESURRECT");
				--UIErrorsFrame:AddMessage("Auto Resurection")
			end
		end
		
	end
	--DEFAULT_CHAT_FRAME:AddMessage(event);	
end 

--code taken from quickloot
local function LazyPig_ItemUnderCursor()
	if not QuickLoot_AutoHide and LPCONFIG.LOOT then
		local index;
		local x, y = GetCursorPosition();
		local scale = LootFrame:GetEffectiveScale();

		x = x / scale;
		y = y / scale;

		LootFrame:ClearAllPoints();

		for index = 1, LOOTFRAME_NUMBUTTONS, 1 do
			local button = getglobal("LootButton"..index);
			if( button:IsVisible() ) then
				x = x - 42;
				y = y + 56 + (40 * index);
				LootFrame:SetPoint("TOPLEFT", "UIParent", "BOTTOMLEFT", x, y);
				return;
			end
		end

		if( LootFrameDownButton:IsVisible() ) then
			x = x - 158;
			y = y + 223;
		else
			if GetNumLootItems() == 0  then
				HideUIPanel(LootFrame);
				return
			end
			x = x - 173;
			y = y + 25;
		end
		
		LootFrame:SetPoint("TOPLEFT", "UIParent", "BOTTOMLEFT", x, y);
	end	
end

function LazyPig_LootFrame_OnEvent(event)
	OriginalLootFrame_OnEvent(event);
	if ( event == "LOOT_SLOT_CLEARED" ) then
		LazyPig_ItemUnderCursor();
	end
end

function LazyPig_LootFrame_Update()
	OriginalLootFrame_Update();
	LazyPig_ItemUnderCursor();
end

function LazyPig_SelectGossipActiveQuest(index)
	LazyPig_RecordQuest(index)
	Original_SelectGossipActiveQuest(index)
end

function LazyPig_SelectGossipAvailableQuest(index)
	Original_SelectGossipAvailableQuest(index)
end

function LazyPig_RecordQuest(questindex)
	local isshift = IsShiftKeyDown()
	local npc = GetUnitName("target")
	
	if isshift and questindex then
		if QuestRecord["qindex"] ~= questindex or QuestRecord["npc"] ~= npc then
			UIErrorsFrame:AddMessage("Quest Record Complete")
			QuestRecord["npc"] = npc
			QuestRecord["qindex"] = questindex
		end	
	elseif not isshift and QuestRecord["qindex"] then
		UIErrorsFrame:AddMessage("Quest Record Reset")
		QuestRecord["npc"] = nil
		QuestRecord["qindex"] = nil
	end
end

function LazyPig_ReplyQuest(event, complete)
	if IsShiftKeyDown() and QuestRecord["npc"] == GetUnitName("target") and QuestRecord["qindex"] then
		if event == "GOSSIP_SHOW" then
			Original_SelectGossipActiveQuest(QuestRecord["qindex"])
		elseif event == "QUEST_PROGRESS" then
			CompleteQuest()
		elseif event == "QUEST_COMPLETE" then
			GetQuestReward(0)
			QuestRecord["complete"] = true
		elseif complete and QuestRecord["complete"] then
			UIErrorsFrame:AddMessage("Quest Replay Complete")
			QuestRecord["complete"] = nil
		end
	end
end

function IsFriend(name)
	for i = 1, GetNumFriends() do
		if GetFriendInfo(i) == name then
			
			return true
		end
	end
	return nil
end

function IsGuildMate(name)
	if (IsInGuild()) then
		local ngm=GetNumGuildMembers()
		for i=1, ngm do
			n, rank, rankIndex, level, class, zone, note, officernote, online, status, classFileName = GetGuildRosterInfo(i);
			if strlower(n) == strlower(name) then
			  return true
			end
		end
	end
	return nil
end

function LazyPig_AutoSummon()
	if LPCONFIG.SUMM then
		local expireTime = GetSummonConfirmTimeLeft()
		expireTime = math.floor(expireTime);
		
		if(not player_summon_message and (expireTime ~= 0)) then
			player_summon_message = true
			player_summon_confirm = true
			DEFAULT_CHAT_FRAME:AddMessage("LazyPig: Auto Summon in "..expireTime.."s");
		elseif((expireTime == 3) or (expireTime == 2)) then
			player_summon_confirm = false
			player_summon_message = false
			ConfirmSummon()
			StaticPopup_Hide("CONFIRM_SUMMON");
			--UIErrorsFrame:AddMessage("Auto Summon")
		end
	end
end

function Check_Bg_Status()
	local bgStatus = { };	
	local player_bg_active = false
	local player_bg_request = false
	
	for i=1, MAX_BATTLEFIELD_QUEUES do
		local status, mapName, instanceID = GetBattlefieldStatus(i);
		bgStatus[i] = { };
		bgStatus[i]["status"] = status;
		bgStatus[i]["map"] = mapName;
		bgStatus[i]["id"] = instanceID;
		
		if(status == "confirm" ) then
			player_bg_request = true
		elseif((status == "active") and not (mapName == "Eastern Kingdoms") and not (mapName == "Kalimdor")) then
			player_bg_active = true
		end
	end
	
	player_bg_confirm = player_bg_request
	
	if(player_bg_message and not player_bg_active and not player_bg_request) then
		player_bg_message = false
	end
	
	if(not player_bg_active and player_bg_request) then
		local index = 1
		while bgStatus[index] do
			if(bgStatus[index]["status"] == "confirm" ) then
				LazyPig_AutoJoinBG(index, bgStatus[index]["map"])
			end
			index = index + 1
		end
	end	
end

function LazyPig_AutoJoinBG(index, map_name)	
	if LPCONFIG.BG then	
		local expireTime = GetBattlefieldPortExpiration(index)/1000
		expireTime = math.floor(expireTime);
		if(not player_bg_message and (expireTime > 3)) then
			player_bg_message = true
			DEFAULT_CHAT_FRAME:AddMessage("LazyPig: Auto Join ".. map_name.." in "..expireTime.."s", 1.0, 1.0, 0.0)

		elseif(expireTime <= 3) then
			AcceptBattlefieldPort(index, true);
			StaticPopup_Hide("CONFIRM_BATTLEFIELD_ENTRY")
			if(player_bg_message) then
				--UIErrorsFrame:AddMessage("Auto Join "..map_name)
				player_bg_message = false
			end
		end	
	end	
end

function LazyPig_AutoLeaveBG()
	if LPCONFIG.BG then
		local bg_winner = GetBattlefieldWinner()
		local winner_name = "Alliance"
		if(bg_winner ~= nil) then	
			save_time = GetTime()
			if(bg_winner == 0) then
				winner_name = "Horde"
			end
			UIErrorsFrame:AddMessage(winner_name.." Wins")
			LeaveBattlefield();
		end	
	end
end

function SaveData()
	SendChatMessage(".save", "SAY")
	UIErrorsFrame:AddMessage("Data saved")
end

function LazyPig_Dismount()
	for i=0,15 do
		local buffIndex, untilCancelled = GetPlayerBuff(i, "HELPFUL");
		local texture = GetPlayerBuffTexture(buffIndex)
		if texture then
			if string.find(texture,"Mount") or string.find(string.lower(texture),"_qirajicrystal_") then
				CancelPlayerBuff(buffIndex);
				--UIErrorsFrame:AddMessage("Auto Dismount")
			end
		end
	end
end

function LazyPig_FreeSpaceReturn()
	local link = nil
	local bagslots = nil
	for bag=0,NUM_BAG_FRAMES do
		bagslots = GetContainerNumSlots(bag)
		if bagslots and bagslots > 0 then
			for slot=1,bagslots do
				link = GetContainerItemLink(bag, slot)
				if not link then
					return bag, slot
				end
			end
		end
	end
	return nil
end

function LazyPig_UseContainerItem(ParentID,ItemID)
	if(LPCONFIG.SPLIT and not CursorHasItem() and (IsShiftKeyDown() or IsAltKeyDown())) then
		if(GetTime()-last_click<0.5) then return end
		local bag, slot = LazyPig_FreeSpaceReturn()
		if(bag and slot) then
			local _, itemCount, locked, _, _ = GetContainerItemInfo(ParentID, ItemID)
			if not locked and itemCount then	
				local splitval = function() if IsAltKeyDown() and itemCount > 3 then return math.floor(itemCount/2) elseif IsShiftKeyDown() and itemCount > LPSPLIT.VALUE then return LPSPLIT.VALUE else return 1 end end
				last_click = GetTime()
				SplitContainerItem(ParentID, ItemID, splitval())
				PickupContainerItem(bag, slot)
				return
			end	
		end
	end
	OriginalUseContainerItem(ParentID,ItemID)
end
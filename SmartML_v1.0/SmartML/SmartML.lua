-- saved variables

SL_ENTRIES = {};
SL_OPTIONS = {};

-- global variables

SL_RAID_ROLL = nil;
SL_UNWANTED = {};
SL_GIVELOOT = {};
SL_IGNOREWHISPERS = {};
SL_MULE_CONFIRMED = false;

-- TODO/IDEAS:
-- o command num <name> to whisper raidroll number
-- o log non bidded items

StaticPopupDialogs["SL_GIVELOOT"] = {
	text = TEXT("Handout loot to winner(s) ?"),
	button1 = TEXT(ACCEPT),
	button2 = TEXT(CANCEL),
	OnAccept = function()
		SL_AcceptHandout();
	end,
	OnCancel = function()
		SL_CancelHandout();
	end,
	timeout = 0,
	whileDead = 1,
};

StaticPopupDialogs["SL_CONFIRM_MULE"] = {
	text = TEXT("Use previously configured mule %s ?"),
	button1 = TEXT(YES),
	button2 = TEXT(NO),
	OnAccept = function()
		SL_MULE_CONFIRMED = true;
		-- redo handout
		SL_MuleHandout();
	end,
	OnCancel = function()
		-- reset mule
		SL_OPTIONS.Shortcut = nil;
	end,
	timeout = 0,
	whileDead = 1,
};


StaticPopupDialogs["SL_DKP_DATA_CHANGED"] = {
	text = TEXT("DKP data is from different session, do you wish to start new bid log?"),
	button1 = TEXT(YES),
	button2 = TEXT(NO),
	OnAccept = function()
		SL_ClearLog();
	end,
	OnCancel = function()
	end,
	timeout = 0,
	whileDead = 1,
};


function SL_InitOption(option, value)
	if (SL_OPTIONS[option]==nil) then SL_OPTIONS[option]=value; end;
end

function SL_OnLoad(this)
	SL_Print("SmartML by Paranoidi loaded");
	
	SLASH_SMARTML1 = "/smartml";
	SLASH_SMARTML2 = "/sl";
	-- if shopping list present use slash command /sml instead of original /sl !
	if (SLASH_FSL2) then
		SLASH_SMARTML2 = "/sml";
	end
	SlashCmdList["SMARTML"] = function(msg)
		SL_Command(msg);
	end
	
	-- register events
	this:RegisterEvent("CHAT_MSG_WHISPER");
	this:RegisterEvent("CHAT_MSG_SYSTEM");
	this:RegisterEvent("CHAT_MSG_CHANNEL");
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("CHAT_MSG_WHISPER_INFORM");
	this:RegisterEvent("LOOT_OPENED");
	this:RegisterEvent("LOOT_SLOT_CLEARED");
	this:RegisterEvent("CHAT_MSG_ADDON");
	
	table.insert(UISpecialFrames, "SL_UI");
	table.insert(UISpecialFrames, "SL_LogFrame");
	table.insert(UISpecialFrames, "SL_ConfigFrame");
	
	-- add menuitems to masterloot menu, clever hook but for some reason font stays smaller than other items in there ...
	-- if you ripoff this, remember atleast to credit :)
	-- TODO: test if it works better with "LootFrame" instead of "GroupLootDropDown" (I doubt)
	local dropdown = getglobal("GroupLootDropDown");
	UIDropDownMenu_Initialize(dropdown, SL_GroupLootDropDown_Initialize, "MENU");
end

function SL_VariablesLoaded()
	-- internal
	SL_InitOption("Test", false);
	SL_InitOption("Silent", false);
	SL_InitOption("Pool", nil);
	-- bidding
	SL_InitOption("AnnounceBids", false);
	SL_InitOption("AllowExceed", true);
	SL_InitOption("AllowRebid", true);
	SL_InitOption("AnnouncePoolChanges", true);
	SL_InitOption("DisableHandout", false);
	SL_InitOption("2ndPlus1", false);
	-- raid roll settings
	SL_InitOption("WhisperNumbers", true);
	SL_InitOption("AnnounceRRStart", true);
	SL_InitOption("AnnounceRREnd", true);
	SL_InitOption("AutoHandoutUpToGreen", false);
	-- mule settings
	SL_InitOption("MuleItems", {});
	-- serious geeks only :)
	SL_InitOption("FaderLength", 30);
	SL_InitOption("QueueTimeout", 3);
	SL_InitOption("UnwantedTimeout", 300);
	
	-- for players who upgrade ...
	if (table.getn(SL_LOG_LIST)==0) then
		SL_LOG={};
	end
	
	if (SL_IsDkpIntegrated()) then
		-- reset pool if it doesn't exist anymore
		if (not SL_PoolExists(SL_OPTIONS.Pool)) then
			SL_OPTIONS.Pool = nil;
		end
	else
		-- reset if no DKP integration
		SL_OPTIONS.Pool = nil;
	end
	
	SL_InitDkpIntegration();
end

function SL_Command(msg)
	local sp,ep,command = string.find(msg, "(%w+)");
	if (not command) then
		SL_UI:Show();
		SL_Print("Use |cffffffff/sl help|r to see list of available commands.");
		return;
	end
	
	command = trim(command);
	local param = trim(string.sub(msg, ep+1, string.len(msg)));
	
	if (command == "bid" or command=="b" or command == "start") then
		SL_StartBiddingCmd(param);
	elseif (command == "help") then
		if (param=="full") then
			SL_HelpCmd(true);
		else
			SL_HelpCmd(false);
		end
	elseif (command == "announce") then
		SL_AnnounceCmd();
	elseif (command == "close") then
		SL_CloseCmd();	
	elseif (command == "pool") then
		SL_PoolCmd(param);	
	elseif (command == "cancel") then
		SL_CancelBiddingCmd(param);
	elseif (command == "warn") then
		SL_WarnClosing();
	elseif (command == "silent") then
		SL_SilentCmd(param)
	elseif (command == "log") then
		SL_LogCmd(param);
	elseif (command == "sync") then
		SL_SyncCmd(param);
	elseif (command == "give") then
		SL_GiveLoot();
	elseif (command == "sc" or command == "mule") then
		SL_ShortcutCmd(param);
	elseif (command == "muleitem" or command == "muleitems") then
		SL_MuleItemCmd(param);
	elseif (command == "rr" or command == "raidroll") then
		SL_StartRaidRollCmd(param);
	elseif (command == "roll" or command == "pr") then
		SL_StartPlayersRollCmd(param);
	elseif (command == "config" or command == "menu") then
		SL_ConfigFrame:Show();
	elseif (command == "test") then
		for i=1,5 do
			local item = {};
			item["id"] = 123;
			item["name"] = "test item "..i;
			item["link"] = "test item link "..i;
			local entry = {};
			entry["started"] = time();
			entry["lastaction"] = time();
			entry["item"] = item;
			entry["bids"] = {};
			for j=1,11 do
				local bid = {};
				bid["player"] = "foobar"..j;
				bid["amount"] = 10*j;
				table.insert(entry.bids, bid);
			end
			table.insert(SL_ENTRIES, entry);
		end
		SL_UpdateUI();
	elseif (command == "dump") then
		for i=1,40 do 
			SL_Print("id "..tostring(i).."="..tostring(GetMasterLootCandidate(i)));
		end 
	elseif (command == "clear") then
		SL_Print("Clearing log");
		SL_ClearLog();
	else
		SL_Print("Unknown command '"..command.."'");
		SL_HelpCmd(false);
	end
end

function SL_HelpCmd(full)
	local function cmd(s)
		return "|cffffffff"..s.."|r"
	end
	local function param(s)
		return " |cff00ff00"..string.upper(s).."|r"
	end
	local sep = " |cffcccccc-|r ";
	
	SL_Print("Available parameters:");
	SL_Print(cmd("menu")..sep.."addon preferences");
	SL_Print(cmd("bid")..param("itemlinks")..sep.."start bidding on item");
	if (full) then SL_Print(cmd("cancel")..param("itemlink")..sep.."cancel bidding on item"); end;
	if (full) then SL_Print(cmd("close")..sep.."close all open bids"); end
	SL_Print(cmd("announce")..sep.."re-announce open biddings");
	if (full) then SL_Print(cmd("warn")..sep.."warn that bids are about to be closed"); end
	SL_Print(cmd("roll").." or "..cmd("pr")..param("itemlink")..sep.."players roll for item");
	SL_Print(cmd("raidroll").." or "..cmd("rr")..param("itemlink")..sep.."raidroll item");
	SL_Print(cmd("log")..sep.."display log");
	SL_Print(cmd("log")..param("itemlink")..param("player")..param("bid")..sep.."add item to log");
	if (full) then SL_Print(cmd("clear")..sep.."clear log"); end
	if (full) then SL_Print(cmd("silent")..param("on").." |"..param("off")..sep.."set silent operation for testing purposes"); end
	if (full) then SL_Print(cmd("sync")..param("player")..sep.."sync log with another player running smart ml"); end
	if (full) then SL_Print(cmd("mule")..param("player")..sep.."create shortcut for player in masterloot menu"); end
	
	if (not full) then
		SL_Print("Use "..cmd("help full").." to see all commands");
	end
end

function SL_SilentCmd(param)
	if (param=="on") then
		SL_OPTIONS["Silent"] = true;
		SL_Print("Silent operation, no announces!");
	elseif (param=="off") then
		SL_OPTIONS["Silent"] = false;
		SL_Print("Normal operation!");
	else
		SL_Print("Invalid parameter (expected: on | off)");
	end
end

function SL_OnEvent(event)
	if (event == "CHAT_MSG_WHISPER") then
		-- arg1 = message
		-- arg2 = player name
		
		-- check if its a bid
		if (not SL_IsEmpty(SL_ENTRIES) and tonumber(arg1) ~= nil) then
			--SL_Print("Instructed "..arg2.. " because msg="..tostring(arg1));
			SL_WhisperBidHelp(arg2);
			return;
		end
		if (string.find(string.lower(arg1),"itemlink %d")) then
			SL_WhisperBidHelp(arg2);
			return;
		end
		SL_HandleBid(arg2, trim(arg1));
		-- is it a dkp check?
		local lmsg = string.lower(arg1);
		if (lmsg=="?dkp" or lmsg=="dkp?" or lmsg=="dkp") then
			SL_AskDKP(arg2);
		end
		-- is it a log sync message?
		if (string.sub(arg1, 1, 6)=="SLSYNC") then
			SL_ReceiveSync(arg1);
		end
		
	elseif (event=="VARIABLES_LOADED") then
		SL_VariablesLoaded();
	elseif (event == "CHAT_MSG_SYSTEM") then
		
		-- handle raidrolls (made by the current player)
		local _,_,raidroll = string.find(arg1, UnitName("player").." rolls (%d+)");
		raidroll = tonumber(raidroll);
		if (raidroll and SL_RAID_ROLL) then
			SL_HandleRaidRoll(raidroll);
			return;
		end
		
		-- handle player rolls
		local _,_,player = string.find(arg1, "(.*) rolls %d+ %(1%-100%)");
		local _,_,roll = string.find(arg1, ".* rolls (%d+) %(1%-100%)");
		if (player and roll) then
			SL_HandleRoll(player, tonumber(roll));
			return;
		end
	end

	if (event=="CHAT_MSG_ADDON") then
		-- arg1 prefix 
		-- arg2 message 
		-- arg3 distribution type ("PARTY","RAID","GUILD" or "BATTLEGROUND") 
		-- arg4 sender
		if (arg1=="SML" and arg4~=UnitName("player")) then
			SL_ParseMsg(arg2, arg4);
		end
	end
	
	if (event=="LOOT_OPENED") then
		SL_UpdateLootItemHilights();
		SL_MuleHandout();
	end
	
	if (event=="LOOT_SLOT_CLEARED") then
		SL_UpdateLootItemHilights();
		-- Todo: Handle next handout from here? Instead of using timer (not 100%, bc of lag ...)
	end
	
end

-- hide whispers made by the addon or ment to be processed by addon, DO NOT PUT ANY LOGIC IN HERE!
local helpfilter = {};
local Orig_ChatFrame_OnEvent = ChatFrame_OnEvent;
function ChatFrame_OnEvent(event)
	local msg = arg1;
	local player = arg2;
    if (msg and player) then
		-- outgoing
		if (event == "CHAT_MSG_WHISPER_INFORM") then
			-- extremely clever way to filter all mod made whispers :)
			if (SL_IGNOREWHISPERS[msg]) then
				-- remove all hidings that are over 20s old
				local now = time();
				for key,hide in SL_IGNOREWHISPERS do
					if (now-hide > 20) then
						SL_IGNOREWHISPERS[key] = nil;
					end
				end
				return;
			end
		end
		
        -- incoming, this block should contain code that HIDES data from chat
        -- NOT functionality
    	if ( event == "CHAT_MSG_WHISPER" ) then
    		-- leading spaces do not count when parsing bid
    		local bmsg = trim(msg);
    		-- is it a bid?
			local item = SL_ParseItem(bmsg);
			local sp,_,_ = string.find(bmsg, "(|c.-|r)");
			local _,_,amount = string.find(bmsg, "|h|r%s-(%d+)");
			local entry = nil;
			
			if (item) then
				entry = SL_GetEntry(item.name);
			end
			if (entry and amount and sp==1) then
				--SL_Print("Filtered out valid bid ("..msg..")");
				return;
			end
			
			local lmsg = string.lower(msg);
			if (lmsg=="?dkp" or lmsg=="dkp?" or lmsg=="dkp") then
				return;
			end
			-- filter out sync messages
			if (string.sub(msg, 1, 6)=="SLSYNC") then
				return;
			end
		end
    end
    Orig_ChatFrame_OnEvent(event);
end

function SL_PoolCmd(param)
	if (param=="") then
		if (SL_OPTIONS.Pool) then
			SL_Print("Current pool is |cffffffff"..SL_OPTIONS.Pool.."|r");
		else
			SL_Print("Current pool is |cffff0000none|r");
		end
		SL_PrintAvailablePools();
		return;
	end

	local pools = SL_GetDKPPoolNames();
	for i,pool in pools do
		if (string.lower(pool) == string.lower(param)) then
			SL_SetPool(pool);
			return;
		end
	end
	-- if dkp integration available, do not allow selecting nonexisting pools, without it's ok
	if (SL_IsDkpIntegrated()) then
		SL_Print("ERROR: Unable to find such DKP pool.");
		SL_PrintAvailablePools();
		return;
	end
	
	SL_SetPool(param);
end

function SL_PrintAvailablePools()
	local pools = SL_GetDKPPoolNames();
	if (SL_IsEmpty(pools)) then
		SL_Print("No predefined DKP pools available");
	else
		local text = "";
		for i,pool in pools do
			text = text.." "..pool;
		end
		text = trim(text);
		SL_Print("Available pools: |cffffffff"..text.."|r");
	end
end

function SL_SetPool(pool, callback, automated)
	if (SL_OPTIONS.Pool==pool and not callback) then
		SL_Print("Pool is already "..tostring(pool));
		return;
	end
	if (SL_OPTIONS.Pool==pool) then return; end; -- *1

	-- if changed while there is open biddings, we must cancel them
	if (not SL_IsEmpty(SL_ENTRIES)) then
		SL_Print("INFORMATION: Canceling all biddings because pool was changed!");
		SL_CancelAllBidding();
	end

	-- note: pool can be setted to nil!
	if (pool and not automated) then
		if (SL_OPTIONS.AnnouncePoolChanges) then
			SL_Announce("Bidding has been switched to pool "..pool.." ! You can whisper me anytime DKP to check your current points.");
		else
			SL_Print("Selected DKP pool is now '"..pool.."'");
		end
	end

	-- must be set before SmartDKP call, otherwise *1 wont affect and bidding will be changed twice
	SL_OPTIONS.Pool = pool;
	
	if (SDKP and not callback) then -- callback prevents infinite recursion between SmartDKP & SmartML
		SDKP_SetSelectedPool(pool);
	end
end

function SL_ShortcutCmd(playername)
	if (SL_InRaid(playername)) then
		SL_OPTIONS["Shortcut"] = playername;
		SL_Print("Shortcut set successfully");
		SL_MULE_CONFIRMED = true;
	else
		SL_Print("ERROR: Player "..playername.." is not in raid.");
	end
end

function SL_MuleItemCmd(param)
	local items = SL_ParseItems(param);
	for _,item in items do
		table.insert(SL_OPTIONS.MuleItems, item.name);
		SL_Print("Added "..item.link);
	end
	SL_UpdateMule();
	SL_MuleHandout();
end

------------------------------------------------------------------------------
-- MASTERLOOTER RELATED FUNCTIONALITY
------------------------------------------------------------------------------

function SL_GroupLootDropDown_Initialize()
	local info;
	-- add buttons to masterloot menu
	if (UIDROPDOWNMENU_MENU_LEVEL==1) then
		info = {};
		info.text = "Smart ML:";
		info.notCheckable = 1;
		info.isTitle = 1;
		UIDropDownMenu_AddButton(info);
	
		info = {};
		info.notCheckable = 1;
		info.text = "Start bidding";
		info.func = SL_MenuStartBidding;
		UIDropDownMenu_AddButton(info);	
	
		info = {};
		info.text = "Raid roll";
		info.notCheckable = 1;
		info.func = SL_MenuRaidRoll;
		UIDropDownMenu_AddButton(info);	
	
		info = {};
		info.text = "Players roll";
		info.notCheckable = 1;
		info.func = SL_MenuPlayersRoll;
		UIDropDownMenu_AddButton(info);
		
		if (SL_InRaid(SL_OPTIONS.Shortcut)) then
			info = {};
			info.text = "Give to "..SL_OPTIONS.Shortcut;
			info.notCheckable = 1;
			info.value = SL_GetPlayerLootIndex(SL_OPTIONS.Shortcut);
			info.func = GroupLootDropDown_GiveLoot; -- standard handout in LootFrame.lua
			if (info.value) then
				UIDropDownMenu_AddButton(info);
			else
				SL_Print("ERROR: Unable to detemine mule loot index");
			end
		end
		
		-- in party add separating title
		if (GetNumRaidMembers() == 0) then
			info = {};
			info.text = GIVE_LOOT;
			info.notCheckable = 1;
			info.isTitle = 1;
			UIDropDownMenu_AddButton(info);
		end
	end
	
	-- continue to initialize blizzard masterloot menu
	GroupLootDropDown_Initialize();
end

function SL_MenuStartBidding()
	--GiveMasterLoot(LootFrame.selectedSlot, this.value);
	--local lootIcon, lootName, lootQuantity, rarity = GetLootSlotInfo(LootFrame.selectedSlot);
	local link = GetLootSlotLink(LootFrame.selectedSlot);
	if (not link) then
		SL_Print("ERROR: Unable to get slot loot link!");
	else
		local items = {};
		local item = SL_ParseItem(link);
		table.insert(items, item);
		SL_StartBidding(items);
	end
end

function SL_MenuRaidRoll()
	local link = GetLootSlotLink(LootFrame.selectedSlot);
	if (not link) then
		SL_Print("ERROR: Unable to get slot loot link!");
	else
		local item = SL_ParseItem(link);
		SL_RaidRoll(item);
	end
end

function SL_MenuPlayersRoll()
	local link = GetLootSlotLink(LootFrame.selectedSlot);
	if (not link) then
		SL_Print("ERROR: Unable to get slot loot link!");
	else
		local item = SL_ParseItem(link);
		SL_StartPlayersRoll(item);
	end
end


function SL_GiveLootDialog()
	if (SL_OPTIONS.DisableHandout) then
		SL_GIVELOOT = {};
		return;
	end
	-- check if there is unconfirmed handouts
	local unconfirmed = false;
	for _,handout in SL_GIVELOOT do
		if (not handout.confirmed) then
			unconfirmed = true;
		end
	end
	-- show confirmation only if player is masterlooter and there is unconfirmed loot
	if (SL_PlayerIsMasterLooter() and unconfirmed) then
		StaticPopup_Show("SL_GIVELOOT");
	end
end

function SL_PlayerIsMasterLooter()
	local method, id = GetLootMethod();
	if (method=="master" and id==0) then return true; end
end

function SL_AcceptHandout()
	-- mark loot currently in the queue to be confirmed
	for item,handout in SL_GIVELOOT do
		handout["confirmed"] = true;
	end
	SL_StartHandout();
end

function SL_CancelHandout()
	for item,handout in SL_GIVELOOT do
		if (not handout.confirmed) then
			-- remove the item and start again (recursive)
			-- this is because removing elements inside for doesn't work :)
			SL_GIVELOOT[item] = nil;
			SL_CancelHandout();
			return;
		end
	end
end

-- insert item to be handed out on accept
function SL_AddToHandout(player, itemname, confirmed)
	local handout = {};
	handout["player"] = player;
	handout["item"] = itemname;
	handout["confirmed"] = confirmed;
	SL_GIVELOOT[itemname] = handout;
	-- if confirmed, start progressing queue
	if (confirmed) then
		SL_StartHandout();
	end
end

SL_GIVELOOT_TIMER = 0;
SL_PENDING_COUNT = 0;

function SL_StartHandout()
	SL_GIVELOOT_TIMER = 0;
	SL_PENDING_COUNT = 0;
	SL_GiveLootTimerFrame:Show();
end

-- TODO: perhaps this timer is unneccessary and not so stable in lag situations.. 
-- better perhaps to parse reiceves loot events and move to next item when previous has been given out successfully
function SL_GiveLootTimer(elapsed)
	SL_GIVELOOT_TIMER = SL_GIVELOOT_TIMER - elapsed;
	if (SL_GIVELOOT_TIMER>0) then return; end;
	SL_GIVELOOT_TIMER = 2;
	
	if (GetNumLootItems()>0) then
		SL_PENDING_COUNT = 0;
		if (SL_GiveLoot() == false) then
			-- nothing to handout anymore
			SL_GiveLootTimerFrame:Hide();
		end
	elseif (not SL_IsEmpty(SL_GIVELOOT)) then
		-- unable to give loot (loot window not open) - but some items in give list !
		if (SL_PENDING_COUNT == 0) then
			SL_Print(SL_TableSize(SL_GIVELOOT).." items pending in handout, please re-loot the corpse!");
		end
		SL_PENDING_COUNT = SL_PENDING_COUNT + 1;
		if (SL_PENDING_COUNT == 20) then -- note: to get actual time multiply by 2 ... (SL_GIVELOOT_TIMER)
			SL_Print("Looting inactive too long, removed "..SL_TableSize(SL_GIVELOOT).." items from handout list! Handout these items manually.");
			for loot,entry in SL_GIVELOOT do
				SL_Print("Item: "..loot.." to "..entry.player);
			end
			-- stop trying, its a wipe
			SL_PENDING_COUNT = 0;
			SL_GIVELOOT = {};
			SL_GiveLootTimerFrame:Hide();
		end
	end
end

-- handout next item in queue
function SL_GiveLoot()
	if (SL_IsEmpty(SL_GIVELOOT)) then return false; end;
	for li = 1, GetNumLootItems() do
		local lootIcon, lootName, lootQuantity, rarity = GetLootSlotInfo(li);
		local handout = SL_GIVELOOT[lootName];
		if (handout) then
			if (handout.confirmed) then
				local ci = SL_GetPlayerLootIndex(handout.player);
				if (ci) then
					SL_Print("Handing out "..lootName.." to "..tostring(handout.player));
					GiveMasterLoot(li, ci);
				else
					SL_Print("ERROR: "..tostring(handout.player).." was too far away or not able to reiceve "..tostring(lootName).." !");
				end
				-- clear giveloot for this item
				SL_GIVELOOT[lootName] = nil;
				return true;
			end
		end
	end
end

function SL_GetPlayerLootIndex(name)
	--local mode, members = SL_GetIterInfo();
	-- index is not atm related to the number of raid players! unlike wowwiki claims
	for i = 1, 40 do
		local candidate = GetMasterLootCandidate(i);
		if (candidate) then
			if (string.lower(candidate) == string.lower(name)) then return i; end
		end
	end
	return nil;
end

-- updates the standard loot dialog texture hilights
function SL_UpdateLootItemHilights()
	-- incase we have some mod that increases button amount
	for i=1,20 do
		local texture = getglobal("LootButton"..i.."IconTexture");
		if (texture and GetLootSlotLink(i)) then
			local loot = getglobal("LootButton"..i.."Text"):GetText();
			local link = GetLootSlotLink(i);
			local item = SL_ParseItem(link);
			local unwanted = false;
			if (SL_UNWANTED[item.name]) then
				if (time() - SL_UNWANTED[item.name] > SL_OPTIONS.UnwantedTimeout) then
					SL_UNWANTED[item.name] = nil;
				else
					unwanted = true;
				end
			end
			if (SL_GetEntry(loot) or SL_InQueue(loot)) then
				texture:SetVertexColor(0,1,0,1);
			elseif (unwanted) then
				texture:SetVertexColor(1,0,0,1);
			else
				texture:SetVertexColor(1,1,1,1);
			end
		end
	end
end

function SL_IsMuleItem(name)
	for _,item in SL_OPTIONS.MuleItems do
		if (item==name) then return true; end;
	end
end

function SL_MuleHandout()
	-- TODO: only if ML!

	-- if mule is not in raid, abort
	if (not SL_InRaid(SL_OPTIONS.Shortcut)) then return; end
	if (not SL_MULE_CONFIRMED) then
		StaticPopup_Show("SL_CONFIRM_MULE", SL_OPTIONS.Shortcut);
		return;
	end
	
	for i = 1, GetNumLootItems(), 1 do
		if (GetLootSlotLink(i)) then
			local link = GetLootSlotLink(i);
			local item = SL_ParseItem(link);
			if (SL_IsMuleItem(item.name)) then
				SL_Print("Found muled item "..item.link);
				SL_AddToHandout(SL_OPTIONS.Shortcut, item.name, true);
			end
		end
	end
end

local origLootFrameItem_OnClick = LootFrameItem_OnClick;
function LootFrameItem_OnClick(button)
	-- queue item to be bidded if alt down
	if (IsAltKeyDown()) then
		local link = GetLootSlotLink(this:GetID());
		if (link) then
			local item = SL_ParseItem(link);
			SL_AddToAnnounceQueue(item);
			return;
		end
	end
	origLootFrameItem_OnClick(button);
end

local SL_ANNOUNCE_TIMER = 5;
SL_ANNOUNCE_QUEUE = {};
function SL_AnnounceTimer(elapsed)
	SL_ANNOUNCE_TIMER = SL_ANNOUNCE_TIMER - elapsed;
	if (SL_ANNOUNCE_TIMER>0) then return; end;
	SL_ANNOUNCE_TIMER = SL_OPTIONS.QueueTimeout;
	-- start and clear queue
	SL_StartBidding(SL_ANNOUNCE_QUEUE);
	SL_ANNOUNCE_QUEUE = {};
	SL_AnnounceTimerFrame:Hide();
end

function SL_AddToAnnounceQueue(item)
	if (not SL_AnnounceTimerFrame:IsVisible()) then
		SL_Print("Queued item. Queued items are announced when you cease adding new ones.");
	end
	table.insert(SL_ANNOUNCE_QUEUE, item);
	SL_AnnounceTimerFrame:Show();
	SL_ANNOUNCE_TIMER = SL_OPTIONS.QueueTimeout;
	SL_UpdateLootItemHilights();
end

function SL_InQueue(name)
	for _,item in SL_ANNOUNCE_QUEUE do
		if (item.name == name) then 
			return true;
		end
	end
end

------------------------------------------------------------------------------
-- RAID ROLL
------------------------------------------------------------------------------

function SL_StartRaidRollCmd(param)
	local items = SL_ParseItems(param);
	if (table.getn(items)==0 or table.getn(items)>1) then
		SL_Print("You can run roll for only one item at the time");
		return;
	end
	if (SL_GetRollEntry()) then
		SL_Print("Can't raidroll while running roll for item");
		return;
	end

	SL_RaidRoll(items[1]);
end

function SL_HandleRaidRoll(roll)
	local winner;
	for _,candidate in SL_RAID_ROLL.candidates do
		if (SL_RAID_ROLL.precise) then
			if (candidate.precise == roll) then
				winner = candidate;
				break;
			end
		else
			if (roll >= candidate.min and roll <= candidate.max) then
				winner = candidate;
				break;
			end
		end
	end
	if (not winner) then
		SL_Print("ERROR: Unable to figure winner, propably a bug!");
	else
		if (SL_OPTIONS.AnnounceRREnd) then
			SL_Announce(winner.name.." wins "..SL_RAID_ROLL.item.link.." !");
		else
			SL_Print(winner.name.." wins "..SL_RAID_ROLL.item.link.." !");
		end
		-- get rarity, incase of auto accept
		local _, _, itemRarity, _, _, _, _, _= GetItemInfoFromItemLink(SL_RAID_ROLL.item.link);
		local confirmed = false;
		if (itemRarity) then
			if (SL_OPTIONS.AutoHandoutUpToGreen and itemRarity<=2) then -- (FIXED?) crashed here: smartml.lue: 696: attempt to compare nil with number.
				confirmed = true;
			end
		else
			SL_Print("WARNING: Couldn't determine item level");
		end
		SL_AddToHandout(winner.name, SL_RAID_ROLL.item.name, confirmed);
		SL_GiveLootDialog();
	end
	-- reset raidroller
	SL_RAID_ROLL = nil;
end

function SL_RaidRoll(item)
	local candidates = SL_GetCandidates();
	if (not candidates) then
		SL_Print("ERROR: You must be in party / raid!");
		return;
	end;
	
	if (SL_OPTIONS.AnnounceRRStart) then
		SL_Announce("RaidRolling "..item.link);
	end
	
	local maxroll = table.getn(candidates);

	SL_RAID_ROLL = {};
	SL_RAID_ROLL["item"] = item;
	SL_RAID_ROLL["candidates"] = candidates;
	if (maxroll<=15) then
		maxroll = maxroll * 10;
	else
		SL_RAID_ROLL["precise"] = true;
	end
	if (SL_OPTIONS.WhisperNumbers) then
		SL_WhisperLuckyNumbers();
	end
	RandomRoll(1, maxroll);
end

local SL_PREV_WHISPERS = {};
function SL_WhisperLuckyNumbers()
	for _,candidate in SL_RAID_ROLL.candidates do
		-- whisper only if numbers have changed
		local last = SL_PREV_WHISPERS[candidate.name];
		local whispered = false;
		if (last) then
			if (last.min == candidate.min and last.max == candidate.max and last.precise == candidate.precise) then
				whispered = true;
			end
		end
		
		if (not whispered) then
			if (SL_RAID_ROLL.precise) then
				SL_Whisper(candidate.name, "You are number "..tostring(candidate.precise).." on raid rolls");
			else
				SL_Whisper(candidate.name, "You are numbers "..tostring(candidate.min).."-"..tostring(candidate.max).." on raid rolls");
			end
			SL_PREV_WHISPERS[candidate.name] = candidate;
		end
	end
end

function SL_GetCandidates()
	local candidates = {};
	local mode, members = SL_GetIterInfo();
	if (mode==nil or members==nil) then return nil; end;
	for i = 1, members do
		local candidate = {};
		candidate["unitID"] = mode..i;
		candidate["name"] = UnitName(mode..i);
		candidate["min"] = i * 10 - 9;
		candidate["max"] = i * 10;
		candidate["precise"] = i;
		table.insert(candidates, candidate);
	end
	-- add myself to the list, but only in party mode!
	if (mode=="party") then
		local i = members + 1;
		local candidate = {};
		candidate["unitID"] = "player";
		candidate["name"] = UnitName("player");
		candidate["min"] = i * 10 - 9;
		candidate["max"] = i * 10;
		candidate["precise"] = i;
		table.insert(candidates, candidate);
	end
	return candidates;
end

------------------------------------------------------------------------------
-- PLAYER ROLL
-- roll is basicly bidding which amount is taken from the roll
------------------------------------------------------------------------------

function SL_StartPlayersRollCmd(param)
	local items = SL_ParseItems(param);
	if (table.getn(items)==0 or table.getn(items)>1 or SL_GetRollEntry()) then
		SL_Print("You can run roll for only one item at the time");
		return;
	end
	if (SL_GetEntry(items[1].name)) then
		SL_Print("Cannot run roll and bidding for same item at same time!");
		return;
	end
	SL_StartPlayersRoll(items[1]);
end

-- param bid is option DKP price of the rolled item, logging purposes
function SL_StartPlayersRoll(item, bid)
	SL_Announce("Roll for "..item.link);
	local entry = {};
	entry["item"] = item;
	entry["bids"] = {};
	entry["bid"] = bid;
	entry["roll"] = true;
	entry["started"] = time();
	entry["lastaction"] = time();
	table.insert(SL_ENTRIES, entry);
	SL_UI:Show();
	SL_UpdateUI();
	SL_UpdateLootItemHilights();
end

function SL_GetRollEntry()
	for _,v in SL_ENTRIES do
		if (v.roll) then
			return v;
		end
	end
end

function SL_HandleRoll(player, amount)
	local entry = SL_GetRollEntry();
	if (entry) then
		local rolled = false;
		for k,v in entry.bids do
			if (v.player == player) then
				rolled = true;
			end
		end
		if (not rolled) then
			SL_Whisper(player, "Your roll on "..entry.item.link.." has been accepted!");
			-- update entry
			entry["lastaction"] = time();
			-- add "bid" (roll really)
			local bid = {};
			bid["player"] = player;
			bid["amount"] = amount;
			table.insert(entry.bids, bid);
			table.sort(entry.bids, function(a,b) return SL_SortBids(a,b) end);
			SL_UpdateUI();
		else
			SL_Whisper(player, "You have already rolled once!");
		end
	end
end

------------------------------------------------------------------------------
-- BIDDING
------------------------------------------------------------------------------

function SL_StartBiddingCmd(param)
	local items = SL_ParseItems(param);
	if (table.getn(items)==0) then
		SL_Print("Invalid parameter. Usage: bid [itemlinks]");
		return;
	end
	if (table.getn(items)>3) then
		SL_Print("ERROR: Does not support starting more than 3 items at once!");
		return;
	end
	SL_StartBidding(items);
end

function SL_AnnounceCmd()
	local text = "";
	for _,entry in SL_ENTRIES do
		if (not entry.roll) then
			text = text.." "..entry.item.link;
		end
	end
	text = trim(text);
	-- todo: if more than 3 items, text should be splitted .....
	
	if (text~="") then
		SL_Announce("Taking bids on "..text.." ! To bid whisper me: ITEMLINK AMOUNT");
	end
end

function SL_StartBidding(items)
	if (SL_IsDkpIntegrated()) then
		-- check that we have valid pool if DKP Table is intergated
		if (not SL_PoolExists(SL_OPTIONS.Pool)) then
			SL_Print("ERROR: Current pool is not set or unavailable. Please select point pool to be used.");
			return;
		end
	end
	
	local text = "";
	for _,item in items do
		local entry = {};
		entry["started"] = time();
		entry["lastaction"] = time();
		entry["item"] = item;
		entry["bids"] = {};
		if (SL_GetEntry(item.name)) then
			SL_Print("Already running bidding on "..item.link.." !");
		else
			table.insert(SL_ENTRIES, entry);
			text = text.." "..item.link;
			
			-- if SmartDKP present invoke item detail broadcast
			if (SDKP_SendItemInfo) then
				SDKP_SendItemInfo(item.name);
			end
			-- broadcast starting item as addon message (ie. SmartBid)
			SL_BroadcastItemStart(item.link);
		end
	end
	text = trim(text);
	
	if (text~="") then
		SL_Announce("Bidding started on "..text.." ! To bid whisper me: ITEMLINK AMOUNT");
	end
	
	SL_UI:Show();
	SL_UpdateUI();
	SL_UpdateLootItemHilights();
end

function SL_CancelBiddingCmd(param)
	local item = SL_ParseItem(param);
	if (not item) then
		SL_Print("Invalid parameter. Usage: cancel [itemlink]");
		return;
	end
	SL_CancelBidding(item);
end

function SL_CancelAllBidding()
	local items={};
	for _,entry in SL_ENTRIES do
		table.insert(items, entry.item);
	end
	for _,item in items do
		SL_CancelBidding(item);
	end
end

function SL_CancelBidding(item)
	if (not item) then return; end;
	local entry = SL_GetEntry(item.name);
	if (not entry) then
		SL_Print("Cannot cancel: You're not running bid on that item!");
		return;
	end
	if (entry.roll) then
		SL_Announce("Canceling rolling on "..item.link);
	else
		SL_Announce("Canceling bidding on "..item.link);
	end
	SL_RemoveEntry(item.name);
	for _,bid in entry.bids do
		if (entry.roll) then
			SL_Whisper(bid.player, "Your roll on "..item.link.." has been canceled!");
		else 
			SL_Whisper(bid.player, "Your bid on "..item.link.." has been canceled!");
		end
	end
	SL_UpdateUI();
	SL_UpdateLootItemHilights();
	SL_UpdateAllExceedStates(); -- refresh exceed statuses in open bids, canceling bid may have resolved some exceed states!
	-- if there are no more bids running, hide the ui
	if (SL_IsEmpty(SL_ENTRIES)) then
		SL_UI:Hide();
	end
end

function SL_Disqualify(item, player)
	local entry = SL_GetEntry(item.name);
	for i, bid in entry.bids do
		if (bid.player == player) then
			SL_Print("Disqualified "..bid.player);
			SL_Whisper(bid.player, "Your participation in "..item.link.." has been disqualified!");
			table.remove(entry.bids, i);
			if (SL_OPTIONS.AnnounceBids) then
				SL_Announce(bid.player.." participation in "..item.link.." has been disqualified!");
			end
			SL_UpdateExceedState(player); -- disqualifying may have resolved some exceed states in other open bids
			return;
		end
	end
end

function SL_WarnClosing()
	local items = "";
	for _,entry in SL_ENTRIES do
		if (not entry.roll) then
			items = items .. " " .. entry.item.link;
		end
	end
	items = trim(items);
	SL_Announce("Closing soon bidding for "..items.." !");
	SL_Announce("If you haven't received confirmating whisper about your bid then it has not been registered!");
end

function SL_CloseCmd()
	SL_CloseAll();
end

function SL_CloseAll()
	local items={};
	for _,entry in SL_ENTRIES do
		table.insert(items, entry.item);
	end
	for _,item in items do
		SL_Close(item, true);
	end
	SL_GiveLootDialog();
end

-- skipgive is used when closing all (can popup only one dialog)
function SL_Close(item, skipgive)
	local entry = SL_GetEntry(item.name);
	table.sort(entry.bids, function(a,b) return SL_SortBids(a,b) end);
	
	local prev_amount = -1;
	local winners = {};
	local text = "";
	local number = 0;
	local second = 0;
	for _,bid in entry.bids do
		if (bid.amount>0) then
			if (bid.amount ~= prev_amount and prev_amount ~= -1) then
				second = bid.amount;
				break;
			end
			prev_amount = bid.amount;
			table.insert(winners, bid);
			text = text.." ".. bid.player;
			number = number + 1;
		end
	end
	text = trim(text);
	
	local price = 0;
	if (number>0) then
		price = winners[1].amount;
	end
	
	if (SL_OPTIONS["2ndPlus1"]) then
		price = second + 1;
	end
	
	if (entry.roll) then
		-- rolled item
		if (number==0) then
			SL_Announce("Closed "..entry.item.link.." - No rolls!");
		elseif (number==1) then
			SL_Announce("Closed "..entry.item.link.." - Winner is "..text.." with roll of "..winners[1].amount);
		else
			SL_Announce("Closed "..entry.item.link.." - "..text.." rolled same amount of "..winners[1].amount.."! Please roll again!");
			SL_StartPlayersRoll(entry.item, entry.bid); -- on re-roll we cant use winners[1].amount because that's roll value!
		end
	else
		-- bidded item
		if (number==0) then
			SL_Announce("Closed "..entry.item.link.." - No bids!");
		elseif (number==1) then
			SL_Announce("Closed "..entry.item.link.." - Winner is "..text.." with "..price.." points!");
		else
			if (SL_GetRollEntry()) then
				SL_Print("Unable to close "..entry.item.link..". Item would be player rolled but there is already one item being rolled for. Close this item after roll has been completed!");
				return;
			end
			SL_Announce("Closed "..entry.item.link.." - "..text.." bid same amount of "..price.." points!");
			SL_StartPlayersRoll(entry.item, price);
		end
	end
	
	if (number==0) then
		SL_UNWANTED[item.name] = time();
	end
	
	-- give loot and log win
	if (number==1) then
		SL_AddToHandout(winners[1].player, entry.item.name);
		local logged = {};
		logged["item"] = entry.item;
		logged["player"] = winners[1].player;
		logged["pool"] = SL_OPTIONS.Pool;
		if (not entry.roll) then
			-- normal bidded win
			logged["bid"] = price;
		elseif (entry.bid) then
			-- rolled win, but bid involved (tie bid) !
			logged["bid"] = entry.bid;
		end
		-- if bid involved, add to log and deduct points!
		if (logged.bid) then
			SL_AddToLog(logged);
			SL_UpdateLog();
		end
	end	
	
	if (not entry.roll) then
		-- broadcast closed item as addon message (ie. SmartBid)
		SL_BroadcastItemClosed(entry.item.link);
	end	
	
	SL_RemoveEntry(item.name);
	SL_UpdateUI();
	SL_UpdateLootItemHilights();
	SL_UpdateAllExceedStates(); -- refresh exceed statuses in open bids, closing bid may have resolved some exceed states!
	
	if (not skipgive) then
		SL_GiveLootDialog()
	end
	
	-- if there are no more bids running, hide the ui
	if (SL_IsEmpty(SL_ENTRIES)) then
		SL_UI:Hide();
	end
end

function SL_SortBids(a,b)
	return a.amount > b.amount;
end

function SL_WhisperBidHelp(player)
	SL_Print("Received invalid bid. Sent detailed instructions to "..player);
	SL_Whisper(player, "Bid not registered! Whisper must be in format 'ITEMLINK AMOUNT' ! Tip: Use shift-click item from chat to enter ITEMLINK in whisper.");
end

-- |cffa335ee|Hitem:21128:0:0:0|h[Staff of the Qiraji Prophets]|h|r

function SL_HandleBid(player, param)
	if (string.find(param, "^%d+%s-|c.-|r")) then
		SL_Print("Received invalid bid. Sent detailed instructions to "..player);
		SL_Whisper(player, "Bid not registered! ITEMLINK must become before AMOUNT!");
		return;
	end

	local item = SL_ParseItem(param);
	local sp,ep,_ = string.find(param, "(|c.-|r)");
	local _,_,amount = string.find(param, "|h|r%s-(%d+)");
	amount = tonumber(amount);
	
	if (item and amount and sp==1) then
		local entry = SL_GetEntry(item.name);
		
		if (not entry) then
			SL_Whisper(player, "Bid not registered! I'm not currently running bidding on that item!");
			return;
		end
		if (amount > 65000 or amount < 0) then
			SL_Whisper(player, "Bid not registered! Invalid amount!");
			return;
		end
		-- check for existing bids
		for k,bid in entry.bids do
			if (bid.player == player) then
				if (SL_OPTIONS.AllowRebid) then
					table.remove(entry.bids, k);
					SL_Whisper(player, "Removed your previous bid ("..tostring(bid.amount)..")!");
				else
					SL_Whisper(player, "You have already bidded on that item. Rebidding has been disabled.");
					return;
				end
			end
		end
		-- add new bid
		local bid = {};
		bid["player"] = player;
		bid["amount"] = amount;
		-- check if has enough points, if proper dkp storage mod is present
		local pending = SL_GetPointsPending(player);
		if (SL_IsDkpIntegrated() and SL_GetPlayerPoints(player) - amount - pending < 0) then
			if (SL_OPTIONS.AllowExceed) then
				SL_Whisper(player, "Your bid ("..tostring(bid.amount)..") for "..item.link.." exceeds your points ("..SL_GetPlayerPoints(player)..")! "..UnitName("player").." will review your bid and decide if it will be accepted!");
				if (SL_OPTIONS.AllowRebid) then
					SL_Whisper(player, "If you exceeded your points accidentally you can change your bid by re-bidding the item.");
				end
			else
				SL_Whisper(player, "Bid not registered! Your bid exceeds your current points ("..SL_GetPlayerPoints(player)..") !");
				return;
			end
		else
			SL_Whisper(player, "Your bid ("..tostring(bid.amount)..") for "..item.link.." has been accepted!");
		end
		
		if (SL_OPTIONS.AnnounceBids) then
			SL_Announce(player.." bid "..tostring(bid.amount).." to "..item.link);
		end
		-- insert bid
		table.insert(entry.bids, bid);
		table.sort(entry.bids, function(a,b) return SL_SortBids(a,b) end);
		-- update entry
		entry["lastaction"] = time();
		SL_UpdateExceedState(player);
		SL_UpdateUI();
	end
end

------------------------------------------------------------------------------
-- exceed flag handling
------------------------------------------------------------------------------

function SL_UpdateAllExceedStates()
	if (not SL_IsDkpIntegrated()) then return; end;
	local candidates = SL_GetCandidates();
	if (candidates) then
		for _,candidate in candidates do
			SL_UpdateExceedState(candidate.name, true);
		end
		SL_UpdateUI();
	end
end

function SL_UpdateExceedState(player, noupdate)
	if (not SL_IsDkpIntegrated()) then return; end;
	
	local pending = SL_GetPointsPending(player);
	local left = SL_GetPlayerPoints(player);
	if (left - pending < 0) then
		SL_SetExceedState(player, true);
	else
		SL_SetExceedState(player, false);
	end
	-- prevent 40+ update requests on SL_UpdateAllExceedStates
	if (not noupdate) then
		SL_UpdateUI();
	end
end

function SL_SetExceedState(player, value)
	for _,entry in SL_ENTRIES do
		for _,bid in entry.bids do
			if (bid.player == player) then
				bid["exceeds"] = value;
			end
		end
	end
end

------------------------------------------------------------------------------
-- LOG - see also SmartML_Log.lua !
------------------------------------------------------------------------------

function SL_LogCmd(param)
	if (param=="") then
		SL_LogFrame:Show();
		SL_UpdateLog();
		return;
	end
	local items = SL_ParseItems(param);
	if (table.getn(items)~=1) then
		SL_LogCmdHelp();
		return;
	end
	for player,bid in string.gfind(param, "|c.-|r%s(.*)%s(%d+)") do
		local logged = {};
		logged["item"] = items[1];
		logged["player"] = player;
		logged["bid"] = bid;
		logged["pool"] = SL_OPTIONS.Pool;
		SL_AddToLog(logged);
		SL_Print("Added to log");
		SL_UpdateLog();
		return;
	end
	SL_Print("Invalid format");
	SL_LogCmdHelp();
end

function SL_LogCmdHelp()
	SL_Print("You can add items manually to log with parameters: ITEM PLAYER BID");
end

function SL_SyncCmd(param)
	-- TODO: check that valid player!
	local player = param;
	for _,entry in SL_LOG[SL_LOG_CURRENT] do
		SL_Whisper(player, "SLSYNC;"..entry.item.link..";"..entry.player..";"..entry.pool..";"..entry.bid);
	end
	SL_Print("Sync data sent");
end


function SL_ReceiveSync(msg)
	-- TODO: confirmation dialog!
	local data = split(msg, ";");
	--SL_Print(data[1].." "..data[2].." "..data[3].." "..data[4].." "..data[5]);
	local item = SL_ParseItem(data[2]);
	local logged = {};
	logged["item"] = item;
	logged["player"] = data[3];
	logged["pool"] = data[4];
	logged["bid"] = tonumber(data[5]);
	-- check if exists in log already
	local exists = false;
	for _,entry in SL_LOG[SL_LOG_CURRENT] do
		if (entry.player == logged.player and 
			entry.pool == logged.pool and 
			entry.bid == logged.bid and 
			entry.item.name == logged.item.name) 
		then
			exists = true;
		end
	end
	if (not exists) then
		SL_AddToLog(logged);
	end
end

------------------------------------------------------------------------------
-- DKP integration (SmartDKP only atm)
------------------------------------------------------------------------------

function SL_AskDKP(player)
	if (not SL_IsDkpIntegrated()) then
		SL_Whisper(player, UnitName("player").." does not have any DKP addon that could be used to check your points");
		return;
	end
	if (not SL_OPTIONS.Pool) then
		SL_Whisper(player, UnitName("player").." has not yet selected DKP pool to be used");
		return;
	end
	local points=SL_GetPlayerPoints(player);
	if (not points) then
		SL_Whisper(player, "Error: Unable to get your points");
		return;
	end
	SL_Whisper(player, "You have "..points.." points left in pool "..SL_OPTIONS.Pool);
end

function SL_GetDKPPoolNames()
	if (not SL_IsDkpIntegrated()) then return {}; end;
	return SDKP_POOLS;
end

function SL_PoolExists(name)
	if (not SL_IsDkpIntegrated()) then return false; end;
	return SDKP_PoolExists(name);
end

function SL_InitDkpIntegration()
	if (SDKP) then
		SDKP_RegisterPoolChange(SL_PoolChanged);
		SDKP_RegisterNewDataSet(SL_DkpDataChanged);
	end
end

-- callback from SmartDKP
function SL_DkpDataChanged()
	if (not SL_IsEmpty(SL_LOG[SL_LOG_CURRENT])) then
		StaticPopup_Show("SL_DKP_DATA_CHANGED");
	end
end

-- callback from SmartDKP
function SL_PoolChanged(pool, automated)
	SL_SetPool(pool, true, automated);
end

	
function SL_ModifyUsedDKP(playername, amount, poolname)
	if (not SL_IsDkpIntegrated()) then return false; end;
	if (not SDKP_ModifyPoints(playername, amount, poolname)) then
		SL_Print("WARNING: Unable to modify player "..playername.." points!");
		return false;
	end
	return true;
end

function SL_IsDkpIntegrated()
	-- check if SmartDKP is present
	if (SDKP) then 
		return true;
	else 
		return false; 
	end
end

-- return number of points in current pool
function SL_GetPlayerPoints(player)
	if (not SL_IsDkpIntegrated()) then return 0; end;
	local points = SDKP_GetCurrentPoints(player);
	if (not points) then
		SL_Print("ERROR: Couldn't get points from SmartDKP for player "..player);
		return 0;
	end
	return points;
end

-- return points pending in other bids
function SL_GetPointsPending(player)
	local total = 0;
	for _,entry in SL_ENTRIES do
		for _,bid in entry.bids do
			if (bid.player == player) then
				total = total + bid.amount;
			end
		end
	end
	return total;
end

function SL_GetPointsUsedFromDKP(pool, player)
	return SDKP_GetSpentPoints(player, pool);
end

function SL_GetPointsUsedFromLog(pool, player)
	local used = 0;
	for _,entry in SL_LOG[SL_LOG_CURRENT] do
		if (entry.player==player and pool==entry.pool and entry.bid) then
			used = used + entry.bid;
		end
	end
	return used;
end

------------------------------------------------------------------------------
-- UTILS
------------------------------------------------------------------------------

function SL_Whisper(player, message)
	SL_IGNOREWHISPERS[message] = time();
	SendChatMessage(message, "WHISPER", nil, player);
end

function SL_GetEntry(name)
	for _,entry in SL_ENTRIES do
		if (entry.item.name == name) then
			return entry;
		end
	end
end

function SL_RemoveEntry(name)
	for i,entry in SL_ENTRIES do
		if (entry.item.name == name) then
			table.remove(SL_ENTRIES,i);
			return true;
		end
	end
end

function SL_GetPartyMode()
	if (SL_OPTIONS.Test) then
		return "GUILD";
	end
	if (GetNumRaidMembers()>0) then
		return "RAID";
	elseif (GetNumPartyMembers()>0) then
		return "PARTY";
	end
end

function SL_Announce(msg)
	if (SL_OPTIONS.Silent or SL_GetPartyMode()==nil) then 
		SL_Print("Announce: "..msg);
		return; 
	end
	local mode = SL_GetPartyMode();
	SendChatMessage(msg, mode, nil);
end

function SL_GetIterInfo()
	local mode, members = nil;
	if (GetNumRaidMembers()>0) then
		mode = "raid";
		members = GetNumRaidMembers();
	elseif (GetNumPartyMembers()>0) then
		mode = "party";
		members = GetNumPartyMembers();
	end
	return mode, members;
end

function SL_GetPlayerClass(name)
	local mode, members = SL_GetIterInfo();
	if (mode==nil or members==nil) then return nil; end;
	
	for i = 1, members do
		if (UnitName(mode..i)==name) then
			local localClass, enClass = UnitClass(mode..i);
			return enClass;
		end
	end
end

function SL_IsEmpty(list)
	if (not list) then 
		return true; 
	end;
	for _,v in list do
		return false;
	end
	return true;
end

function SL_TableSize(t)
	size = 0;
	for k,v in t do
		size = size + 1;
	end
	return size;
end

function GetItemInfoFromItemLink(link)
	local itemId = nil;
	if ( type(link) == "string" ) then
  		_,_, itemId = string.find(link, "item:(%d+):");
 	end
 	if ( itemId ) then
  		return GetItemInfo(itemId);
 	end
end

-- |cffa335ee|Hitem:21128:0:0:0|h[Staff of the Qiraji Prophets]|h|r

--  for color, item, name in string.gfind(text, "|c(%x+)|Hitem:(%d+:%d+:%d+:%d+)|h%[(.-)%]|h|r") do

function SL_ParseItem(s)
	local item = {};
	local _,_,name = string.find(s, "%[(.-)%]");
	local _,_,id = string.find(s, "|H(.-)|h%[");
	local _,_,link = string.find(s, "(|c.-|r)");
	if (id==nil or name==nil or link==nil) then
		return nil;
	end
	item["id"] = id;
	item["name"] = name;
	item["link"] = link;
	return item;
end

function SL_ParseItems(s)
	local items = {};
	local function helper(s)
		local item = SL_ParseItem(s);
		table.insert(items, item);
	end
	string.find( string.gsub(s, "(|c.-|r)", helper), "%S" );
	return items;
end

function trim(s)
	return (string.gsub(s, "^%s*(.-)%s*$", "%1"))
end

function split(str, pat)
   local t = {n = 0}
   local fpat = "(.-)"..pat
   local last_end = 1
   local s,e,cap = string.find(str, fpat, 1)
   while s ~= nil do
      if s~=1 or cap~="" then
	 table.insert(t,cap)
      end
      last_end = e+1
      s,e,cap = string.find(str, fpat, last_end)
   end
   if last_end<=string.len(str) then
      cap = string.sub(str,last_end)
      table.insert(t,cap)
   end
   return t
end

function SL_Print(message)
	DEFAULT_CHAT_FRAME:AddMessage(message, 0, 0.8, 1);
end

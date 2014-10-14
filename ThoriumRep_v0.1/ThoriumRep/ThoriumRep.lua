--[[

ThoriumRep by Tim Mullin

This mod allows for auto turning in of Thorium Brotherhood rep quests. 
The quest turning in is based off of BGAssist's turning in AV quests

]]

THORIUMREP_VERSION = "0.1";
--BINDING_HEADER_THORIUMREP_SEP = "ThoriumRep";

local TBR_debug = false;

local BATTLEFIELD_INDEXES = {
	[1] = SEARINGGORGE;
	[2] = BLACKROCKDEPTHS;
};

local EVENTSINBATTLEGROUND = {
	-- Bag item tracking
	"BAG_UPDATE",
	-- Track into quest windows for autocomplete
	"QUEST_PROGRESS",
	"QUEST_COMPLETE",
	"QUEST_GREETING",
	"QUEST_DETAIL",
	-- "GOSSIP_SHOW",
};

ThoriumRep_Player = nil; -- global;
local ThoriumRep_Config_Loaded = nil;
local ThoriumRep_InBattleGround = nil;
local ThoriumRep_TrackedItems = {};
local ThoriumRep_ItemInfo = {};
local ThoriumRep_LastUpdate = 0;

local function ThoriumRep_LinkDecode(link)
	local id, name;
	_, _, id, name = string.find(link,"|Hitem:(%d+):%d+:%d+:%d+|h%[([^]]+)%]|h|r$");
	-- Only first number of itemid is significant in this.
	if (id and name) then
		id = id * 1;
		return name, id;
	end
end

local function ThoriumRep_BagCheck()
	local bag, slot, size;
	ThoriumRep_TrackedItems = {};
	for bag = 0, 4, 1 do
		if (bag == 0) then
			size = 16;
		else
			size = GetContainerNumSlots(bag);
		end
		if (size and size > 0) then
			for slot = 1, size, 1 do
				local itemLink = GetContainerItemLink(bag,slot);
				if (itemLink) then
					local itemName, itemID = ThoriumRep_LinkDecode(itemLink);
					local texture, itemCount = GetContainerItemInfo(bag,slot);
					if (itemID and ThoriumRep_ItemTrack[itemID]) then
						if (not ThoriumRep_TrackedItems[itemID]) then
							ThoriumRep_TrackedItems[itemID] = 0;
						end
						ThoriumRep_ItemInfo[itemID] = {
							["name"] = itemName,
							["texture"] = texture;
						};
						ThoriumRep_TrackedItems[itemID] = ThoriumRep_TrackedItems[itemID] + itemCount;
					end
				end
			end
		end
	end
end

local function ThoriumRep_Alterac_SelectQuest(...)
	if (IsControlKeyDown()) then return; end

	local i;
	local idx = 0;
	for i = 1, arg.n, 2 do
		idx = idx + 1;
		if (ThoriumRep_Alterac_Quests[arg[i]]) then
			local item, min, max;
			if (type(ThoriumRep_Alterac_Quests[arg[i]]) == "table") then
				item = ThoriumRep_Alterac_Quests[arg[i]].item;
				min = ThoriumRep_Alterac_Quests[arg[i]].min;
				max = ThoriumRep_Alterac_Quests[arg[i]].max;
			else
				item = true;
			end
			if (not min or min < 1) then min = 1; end
			if (not max) then max = 1000; end
			local count = ThoriumRep_TrackedItems[item];
			if (not count) then count = 0; end
			if (item == true or (count >= min and count <= max)) then
				if (not ThoriumRep_Config[ThoriumRep_Player].turnins[arg[i]]) then
					ThoriumRep_Config[ThoriumRep_Player].turnins[arg[i]] = 0;
				end
				ThoriumRep_Config[ThoriumRep_Player].turnins[arg[i]] = ThoriumRep_Config[ThoriumRep_Player].turnins[arg[i]] + min;
				SelectGossipAvailableQuest(idx);
			end
		end
	end
end

local function ThoriumRep_Alterac_AutoProcess(method)
	if (IsControlKeyDown()) then return; end
	
	if (ThoriumRep_Alterac_Quests[GetTitleText()]) then
		if (method == "QUEST_COMPLETE") then
			QuestRewardCompleteButton_OnClick();
		elseif (method == "QUEST_PROGRESS") then
			QuestProgressCompleteButton_OnClick();
		elseif (method == "QUEST_DETAIL") then
			QuestDetailAcceptButton_OnClick();
		else
			Debug_msg("Unknown METHOD: "..method.." for "..GetTitleText());
		end
	end
end

local function ThoriumRep_ConfigInit()
	if (not ThoriumRep_Config) then
		ThoriumRep_Config = {};
	end
	if (not ThoriumRep_Config[ThoriumRep_Player]) then
		ThoriumRep_Config[ThoriumRep_Player] = {};
	end
	if (not ThoriumRep_Config[ThoriumRep_Player].turnins) then
		ThoriumRep_Config[ThoriumRep_Player].turnins = {};
	end

end

function ThoriumRep_OnLoad()
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	-- Autoenter
	this:RegisterEvent("GOSSIP_SHOW");
	this:RegisterEvent("ZONE_CHANGED_NEW_AREA");

	local playerName = UnitName("player");
--	if (playerName ~= UKNOWNBEING and playerName ~= UNKNOWNOBJECT) then
		ThoriumRep_Player = playerName;
--	end

	SlashCmdList["THORIUMREP"] = ThoriumRep_Console;
	SLASH_THORIUMREP1 = "/tbr";
--	SLASH_THORIUMREP2 = "/bgassist";

	DEFAULT_CHAT_FRAME:AddMessage("ThoriumRep Loaded", 1,1,0);
end

function ThoriumRep_OnEvent(event)
	if (event == "VARIABLES_LOADED") then
		ThoriumRep_Config_Loaded = 1;
		if (ThoriumRep_Player) then
			ThoriumRep_ConfigInit();
		end
	elseif (event == "ZONE_CHANGED_NEW_AREA" or event =="PLAYER_ENTERING_WORLD") then
		ThoriumRep_Reset();
	elseif (event == "BAG_UPDATE") then
		if (ThoriumRep_InBattleGround == SEARINGGORGE) then
			ThoriumRep_BagCheck();
		end;
	elseif (event == "QUEST_PROGRESS" or event == "QUEST_COMPLETE" or event == "QUEST_DETAIL") then
		if (not ThoriumRep_Config.noautoquest and ThoriumRep_InBattleGround == SEARINGGORGE) then
			ThoriumRep_Alterac_AutoProcess(event);
		end
	elseif (event == "GOSSIP_SHOW") then
		if (not ThoriumRep_Config.noautoquest and ThoriumRep_InBattleGround == SEARINGGORGE) then
			ThoriumRep_Alterac_SelectQuest(GetGossipAvailableQuests());
		end
	end
end

function ThoriumRep_Reset()
	Debug_msg("ThoriumRep: RESET");

	ThoriumRep_InBattleGround = nil;

	local idx, event;
	for idx, event in EVENTSINBATTLEGROUND do
		ThoriumRep:UnregisterEvent(event);
	end

	Debug_msg("ThoriumRep: variables/events deleted");

	local i, status, mapName, instanceID;
	local tmpmapName = GetRealZoneText();
	for _, val in BATTLEFIELD_INDEXES do
		if (tmpmapName == val) then
			mapName = tmpmapName;

			DEFAULT_CHAT_FRAME:AddMessage("ThoriumRep: "..DISPLAY_TEXT_ENTERINGZONE..": "..mapName);
			ThoriumRep_InBattleGround = mapName;
			ThoriumRep_BagCheck();
			local idx,event;
			for idx,event in EVENTSINBATTLEGROUND do
				ThoriumRep:RegisterEvent(event);
			end
		end
	end
end

function ThoriumRep_Console( msg )
	-- Options
	if ( msg == "debug" ) then
		if (TBR_debug) then
			TBR_debug = false;
			DEFAULT_CHAT_FRAME:AddMessage("DEBUG: off");
		else
			TBR_debug = true;
			DEFAULT_CHAT_FRAME:AddMessage("DEBUG: on");
		end
	elseif ( msg == "center" ) then
--		ThoriumRep_Timers:SetPoint("TOPLEFT", 300, -300);

	elseif ( msg == "reset" ) then
		ThoriumRep_Reset();
	elseif ( msg == "status" ) then
		local str;

		if (ThoriumRep_InBattleGround) then
			str = "In " .. ThoriumRep_InBattleGround .. " and processing turn-ins";
		else
			str = "Not in a turn-in zone";
		end

		DEFAULT_CHAT_FRAME:AddMessage("ThoriumRep: " .. str);
	end
end

function Debug_msg(msg)
	if TBR_debug then
		DEFAULT_CHAT_FRAME:AddMessage(msg);
	end;
end


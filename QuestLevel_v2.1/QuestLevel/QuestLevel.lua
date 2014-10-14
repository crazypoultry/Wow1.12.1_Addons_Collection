-- --------------------- --
--                       --
--  Elkano's QuestLevel  --
--                       --
--      version 2.1      --
--                       --
-- --------------------- --


-- ---------------------- --
-- hooking game functions --
-- ---------------------- --
local QuestLevel_original_GetQuestLogTitle = GetQuestLogTitle;
local QuestLevel_original_GetTitleText = GetTitleText;

-- GossipFrame
-- local QuestLevel_original_GossipFrameUpdate = GossipFrameUpdate;
local QuestLevel_original_GetGossipAvailableQuests = GetGossipAvailableQuests;
local QuestLevel_original_GetGossipActiveQuests = GetGossipActiveQuests;

-- QuestFrame
-- local QuestLevel_original_QuestFrameGreetingPanel_OnShow = QuestFrameGreetingPanel_OnShow;
local QuestLevel_original_GetActiveTitle = GetActiveTitle;
local QuestLevel_original_GetAvailableTitle = GetAvailableTitle;


-- -------------- --
-- storage system --
-- -------------- --

QuestLevel_StorageKeys = { };
QuestLevel_StorageKeys["levelmin"] = "<";
QuestLevel_StorageKeys["levelmax"] = ">";
QuestLevel_StorageKeys["elite"] = "@";

function QuestLevel_StorageSet(storage, key, value)
	if (not QuestLevel_StorageKeys[key]) then
		return storage;
	end
	if (storage == nil) then
		storage = "";
	end
	local storagearray = {};
	for storagekey, storagevalue in QuestLevel_StorageKeys do
		s1, s2, storagearray[storagekey] = string.find(storage, storagevalue.."(.-)¤");
	end
	storagearray[key] = value;
	local newstorage = "";
	for storagekey, storagevalue in storagearray do
		newstorage = newstorage..QuestLevel_StorageKeys[storagekey]..storagevalue.."¤";
	end
	return newstorage;
end

function QuestLevel_StorageGet(storage, key)
	if (not QuestLevel_StorageKeys[key]) then
		return nil;
	end
	if (storage == nil) then
		storage = "";
	end
	s1, s2, value = string.find(storage, QuestLevel_StorageKeys[key].."(.-)¤");
	if ( value ) then
		return value;
	else
		return nil;
	end
end


-- -------------- --
-- main functions --
-- -------------- --

local function QuestLevel_VariablesLoaded()
	if( not QuestLevel_Quest2Level ) then
		QuestLevel_Quest2Level = { };
	end

	-- convert to new storage -- beta2
	for quest, data in QuestLevel_Quest2Level do
		if ( type(data) == "table" or string.find(data, QuestLevel_StorageKeys["levelmin"]) == nil ) then
			if ( type(data) == "table" ) then
				local queststorage = "";
				queststorage = QuestLevel_StorageSet(queststorage, "levelmin", data["min"]);
				queststorage = QuestLevel_StorageSet(queststorage, "levelmax", data["max"]);
				QuestLevel_Quest2Level[quest] = queststorage;
			else
				local queststorage = "";
				queststorage = QuestLevel_StorageSet(queststorage, "levelmin", data);
				QuestLevel_Quest2Level[quest] = queststorage;
			end
		else
			break; -- data is valid storage -> table had been converted before
		end
	end

	-- convert to new storage -- beta3
	for quest, data in QuestLevel_Quest2Level do
		local levelmin = QuestLevel_StorageGet(data, "levelmin");
		local levelmax = QuestLevel_StorageGet(data, "levelmax");
		if ( levelmax == nil ) then
			break; -- data is valid storage -> table had been converted before
		end
		if ( tonumber(levelmin) >= tonumber(levelmax) ) then
			data = QuestLevel_StorageSet(data, "levelmax", nil);
			QuestLevel_Quest2Level[quest] = data;
		end
	end
end

function QuestLevel_OnLoad()
	this:RegisterEvent("VARIABLES_LOADED");
end

function QuestLevel_OnEvent()
	if( event == "VARIABLES_LOADED" ) then
		QuestLevel_VariablesLoaded();
	end
end

function QuestLevel_StoreLevel(name, level, elite)
	if ( not QuestLevel_Quest2Level[name] ) then
		local queststorage = "";
		queststorage = QuestLevel_StorageSet(queststorage, "levelmin", level);
		if (elite) then
			queststorage = QuestLevel_StorageSet(queststorage, "elite", "");
		end
		QuestLevel_Quest2Level[name] = queststorage;
	else
		local queststorage = QuestLevel_Quest2Level[name];
		local levelmin = tonumber(QuestLevel_StorageGet(queststorage, "levelmin"));
		local levelmax = QuestLevel_StorageGet(queststorage, "levelmax");
		if ( levelmax == nil ) then
			levelmax = levelmin;
		else
			levelmax = tonumber(levelmax);
		end
		if (levelmin > level) then
			queststorage = QuestLevel_StorageSet(queststorage, "levelmin", level);
			queststorage = QuestLevel_StorageSet(queststorage, "levelmax", levelmax);
		end
		if (levelmax < level) then
			queststorage = QuestLevel_StorageSet(queststorage, "levelmax", level);
		end
		if (elite and QuestLevel_StorageGet(queststorage, "elite") == nil) then
			queststorage = QuestLevel_StorageSet(queststorage, "elite", "");
		end
		QuestLevel_Quest2Level[name] = queststorage;
	end
end

function GetQuestLogTitle(questIndex)
	questLogTitleText, level, questTag, isHeader, isCollapsed, isComplete = QuestLevel_original_GetQuestLogTitle(questIndex);
	if ( isHeader  or not questLogTitleText ) then
	else
		QuestLevel_StoreLevel(questLogTitleText, level, questTag)
		local leveltag = level;
		if (questTag) then
			leveltag = level.."+";
		end
		questLogTitleText = "["..leveltag.."] "..questLogTitleText;
	end
	return questLogTitleText, level, questTag, isHeader, isCollapsed, isComplete;
end

local function QuestLevel_AddLevelFromTable(questname)
	if ( QuestLevel_Quest2Level[questname] ) then
		local levelmin = tonumber(QuestLevel_StorageGet(QuestLevel_Quest2Level[questname], "levelmin"));
		local levelmax = QuestLevel_StorageGet(QuestLevel_Quest2Level[questname], "levelmax");
		if ( levelmax == nil ) then
			levelmax = levelmin;
		else
			levelmax = tonumber(levelmax);
		end
		local leveltag = "";
		if ( levelmin < levelmax ) then
			leveltag = leveltag..levelmin.."-"..levelmax;
		else
			leveltag = leveltag..levelmin;
		end
		if (QuestLevel_StorageGet(QuestLevel_Quest2Level[questname], "elite")) then
			leveltag = leveltag.."+";
		end
		return "["..leveltag.."] "..questname;
	end
	return "[?] "..questname;
end

function GetTitleText()
	local titletext = QuestLevel_original_GetTitleText();
--	if( DEFAULT_CHAT_FRAME ) then
--		DEFAULT_CHAT_FRAME:AddMessage("[QuestLevel] DEBUG: GetTitleText -> "..titletext);
--	end
	return QuestLevel_AddLevelFromTable(titletext);
end

local function QuestLevel_addLevelGossip(...)
	if ( arg.n == 0) then
		return
	end
	for i=1, arg.n, 2 do
-- 		if( DEFAULT_CHAT_FRAME ) then
-- 			DEFAULT_CHAT_FRAME:AddMessage("[QuestLevel] DEBUG: arg["..i.."] -> "..arg[i]);
-- 		end
		QuestLevel_StoreLevel(arg[i], arg[i+1])
		arg[i] = QuestLevel_AddLevelFromTable(arg[i]);
	end
	return unpack(arg);
end

-- function GossipFrameUpdate()
-- 	if( DEFAULT_CHAT_FRAME ) then
-- 		DEFAULT_CHAT_FRAME:AddMessage("[QuestLevel] DEBUG: |cffffff00GossipFrameUpdate|r called");
-- 	end
-- 	return QuestLevel_original_GossipFrameUpdate();
-- end

function GetGossipAvailableQuests()
-- 	if( DEFAULT_CHAT_FRAME ) then
-- 		DEFAULT_CHAT_FRAME:AddMessage("[QuestLevel] DEBUG: |cffffff00GetGossipAvailableQuests|r called");
-- 	end
	return QuestLevel_addLevelGossip(QuestLevel_original_GetGossipAvailableQuests());
end

function GetGossipActiveQuests()
-- 	if( DEFAULT_CHAT_FRAME ) then
-- 		DEFAULT_CHAT_FRAME:AddMessage("[QuestLevel] DEBUG: |cffffff00GetGossipActiveQuests|r called");
-- 	end
	return QuestLevel_addLevelGossip(QuestLevel_original_GetGossipActiveQuests());
end

-- function QuestFrameGreetingPanel_OnShow()
-- 	if( DEFAULT_CHAT_FRAME ) then
-- 		DEFAULT_CHAT_FRAME:AddMessage("[QuestLevel] DEBUG: |cffffff00QuestFrameGreetingPanel_OnShow|r called");
-- 	end
-- 	return QuestLevel_original_QuestFrameGreetingPanel_OnShow();
-- end

function GetActiveTitle(i)
-- 	if( DEFAULT_CHAT_FRAME ) then
-- 		DEFAULT_CHAT_FRAME:AddMessage("[QuestLevel] DEBUG: |cffffff00GetActiveTitle("..i..")|r called");
-- 	end
	return QuestLevel_AddLevelFromTable(QuestLevel_original_GetActiveTitle(i));
end

function GetAvailableTitle(i)
-- 	if( DEFAULT_CHAT_FRAME ) then
-- 		DEFAULT_CHAT_FRAME:AddMessage("[QuestLevel] DEBUG: |cffffff00GetAvailableTitle("..i..")|r called");
-- 	end
	return QuestLevel_AddLevelFromTable(QuestLevel_original_GetAvailableTitle(i));
end
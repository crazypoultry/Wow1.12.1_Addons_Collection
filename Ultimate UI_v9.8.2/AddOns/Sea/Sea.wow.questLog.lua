--[[
--	Sea.wow.questLog
--		Basic Quest Log Functions
--	
--	$LastChangedBy: Sinaloit $
--	$Rev: 2025 $
--	$Date: 2005-07-02 16:51:34 -0700 (Sat, 02 Jul 2005) $
--]]

Sea.wow.questLog = {
	-- Quest Log Max
	QUESTLOG_MAX = 20;

	-- Protection Data
	ProtectionData = {};

	--
	--	storeCollapsedQuests
	--	
	--	 Stores the currently collapsed quests and returns them
	--
	-- Returns:
	-- 	(table quests)
	-- 	quests - a list containing the title of the collapsed quests
	--	 
	storeCollapsedQuests = function ()
		local collapsed = {};
		for i=1, Sea.wow.questLog.QUESTLOG_MAX do
			local title, level, questTag, isHeader, isCollapsed, isComplete = GetQuestLogTitle(i);
			if ( isCollapsed ) then 
				table.insert(collapsed, title);
			end
		end
		
		return collapsed; 
	end;

	--
	--	collapseStoredQuests (collapseTitles)
	--		Collapses all quests whose titles are in the list
	--
	-- Args: 
	--	(table collapseTitles)
	--	collapseTitles - the titles which will be collapsed
	--
	-- Returns:
	-- 	nil
	--
	collapseStoredQuests = function (collapseThese) 
		for i=1, Sea.wow.questLog.QUESTLOG_MAX do
			local title, level, questTag, isHeader, isCollapsed, isComplete = GetQuestLogTitle(i);
			if ( Sea.list.isInList(collapseThese, title) ) then 
				CollapseQuestHeader(i);
			end
		end
	end;


	-- 
	-- 	protectQuestLog()
	-- 		Preserves the quest log state.
	-- 		Don't forget to call unprotectQuestLog() 
	-- 		after modifying the log.
	--
	--		This will return false if someone else
	--		has protected the quest log and
	--		not unprotected it yet. 
	-- 		
	--	Args:
	--		none
	--	Returns:
	--		true - the log was protected
	--		false - someone else is modifying the log now
	-- 
	protectQuestLog = function ()
		if ( Sea.wow.questLog.ProtectionData.protected ) then 
			return nil;
		end
	
		-- Store the protected state
		Sea.wow.questLog.ProtectionData.protected = true;

		-- Store the event 
		Sea.wow.questLog.ProtectionData.ql_OnEvent = QuestLog_OnEvent;
		QuestLog_OnEvent = function() end;

		-- Store the collapsed
		Sea.wow.questLog.ProtectionData.collapsed = Sea.wow.questLog.storeCollapsedQuests();

		-- Store the selection
		Sea.wow.questLog.ProtectionData.savedID = GetQuestLogSelection();
	
		return true;
	end;

	--
	--	unprotectQuestLog()
	--		Restores the state of the quest log. 
	--		Useful if you're going to mess with the
	--		quest log in order to get info out, and 
	--		don't want the user to notice. 
	--
	--	Args:
	--		none
	--	Returns:
	--		nil
	--
	unprotectQuestLog = function ()
		-- Restore the selection
		SelectQuestLogEntry(Sea.wow.questLog.ProtectionData.savedID);
	
		-- Collapse again
		Sea.wow.questLog.collapseStoredQuests(Sea.wow.questLog.ProtectionData.collapsed);

		-- Restore the event
		QuestLog_OnEvent = Sea.wow.questLog.ProtectionData.ql_OnEvent;
		Sea.wow.questLog.ProtectionData.ql_OnEvent = nil;
		
		-- Unprotect
		Sea.wow.questLog.ProtectionData.protected = false;
	end;

	--
	--	getPlayerQuestTree()
	--		Returns a formatted table containing all of
	--		the quests the player currently has.
	--
	--	Returns:
	--		
	--	questTree  - list of zones
	--	{
	--		["zone name"] - list of quests
	--		{
	--			{
	--				flatid - (string) id when fully expanded
	--				title - (string) quest title
	--				level - (number) quest level 
	--				tag - (string) Elite or Raid
	--				complete - (boolean) is quest completed
	--			}
	--		}
	--	}
	--	
	getPlayerQuestTree = function()
		if ( not Sea.wow.questLog.protectQuestLog() ) then 
			return nil; 
		end
	
		-- Expand everything
		ExpandQuestHeader(0);

		-- Build our quest list
		local numEntries, numQuests = GetNumQuestLogEntries();

		local questList = {};
		local activeTable = nil;

		for i=1, Sea.wow.questLog.QUESTLOG_MAX + numEntries, 1 do
			local questIndex = i;
			if ( questIndex <= numEntries ) then
				local title, level, questTag, isHeader, isCollapsed, isComplete = GetQuestLogTitle(questIndex);
				local color;
				if ( title ) then 
					if ( isHeader ) then
						questList[title] = {};
						activeTable = questList[title]; 
					else
						if ( activeTable == nil ) then 
							activeTable = questList; 
						end

						local entry = {}; 
						entry.id = i;
						entry.flatid = i;
						entry.title = title; 
						entry.level = level;
						entry.tag = questTag; 
						entry.complete = isComplete;

						table.insert(activeTable, entry);
					end
				end
			end
		end

		-- Unprotect
		Sea.wow.questLog.unprotectQuestLog();

		return questList;

	end;

	--
	--	getPlayerQuestData ( number id )
	--
	--		Returns a formatted table containing the quest's information
	--		If you specify its id when the table is flat.
	--
	--	Args:
	--		id - flattened (expanded) id of the quest
	--
	--	Returns:
	--		questData - (table)
	--		{
	--			id - flattened id (number)
	--			title - quest title (string)
	--			level - quest level (number)
	--			tag - quest tag (string)
	--			failed - (boolean)
	--			pushable - (boolean)
	--			timer - (number) 
	--			description - full description text (string)
	--			objective - objective text (string)
	--			objectives - objective status (table)
	--				{
	--					text - description (string)
	--					questType - monster, reputation or item (string)
	--					finished - (boolean)
	--					info - status information (table)
	--					{
	--						name - monster/item/faction name
	--						done 	- number - number obtained or killed
	--							- string - faction achieved
	--						total 	- number - amount needed 
	--							- string - faction required
	--					}
	--				}	
	--			choices - choices of items (table)
	--				{
	--					name - item name
	--					texture - item texture
	--					numItems - count of items (number)
	--					quality - item quality (number)
	--					isUsable - (boolean)
	--					info - link information (table)
	--						{
	--							color - color string (string)
	--							link - item link (string)
	--							linkname - [Item of Power] (string)
	--						}
	--				}
	--			rewards - items always recieved (table)
	--				{
	--					name - item name
	--					texture - item texture
	--					numItems - count of items (number)
	--					quality - item quality (number)
	--					isUsable - (boolean)
	--					info - link information (table)
	--						{
	--							color - color string (string)
	--							link - item link (string)
	--							linkname - [Item of Power] (string)
	--						}
	--				}
	--			spellReward - the spell given to you after the quest (table)
	--				{
	--					name - spell name (string)
	--					texture - spell texture (string)
	--				}
	--		}
	--		
	getPlayerQuestData = function ( id ) 
		if ( not Sea.wow.questLog.protectQuestLog() ) then 
			return false;
		end

		if ( not id ) then
			-- Unprotect
			Sea.wow.questLog.unprotectQuestLog();	
			return nil;
		end

		local questInfo = {};
	
		-- Expand everything
		ExpandQuestHeader(0);
	
		-- Select it
		SelectQuestLogEntry(id);

		questInfo.id = id;
		questInfo.title, questInfo.level, questInfo.tag = GetQuestLogTitle(id);
		questInfo.failed = IsCurrentQuestFailed();	
		questInfo.description, questInfo.objective = GetQuestLogQuestText();
		questInfo.pushable = GetQuestLogPushable();
		questInfo.timer = GetQuestLogTimeLeft();
	
		questInfo.objectives = {};

		for i=1, GetNumQuestLeaderBoards(), 1 do
			local item = {};

			item.text, item.questType, item.finished = GetQuestLogLeaderBoard(i);

			if ( item.questType == "item" ) then 
				local realGlobal = QUEST_ITEMS_NEEDED;
				QUEST_ITEMS_NEEDED = "%s:%d:%d";
				local info = Sea.string.split(GetQuestLogLeaderBoard(i),":");
				QUEST_ITEMS_NEEDED = realGlobal;
				
				item.info = {};
				item.info.name = info[1];
				item.info.done = tonumber(info[2]);
				item.info.total = tonumber(info[3]);	
			elseif ( item.questType == "monster" ) then 
				local realGlobal = QUEST_MONSTERS_KILLED;
				QUEST_MONSTERS_KILLED = "%s:%d:%d";
				local info = Sea.string.split(GetQuestLogLeaderBoard(i),":");
				QUEST_MONSTERS_KILLED = realGlobal;

				item.info = {};
				item.info.name = info[1];
				item.info.done = tonumber(info[2]);
				item.info.total = tonumber(info[3]);
			elseif ( item.questType == "reputation" ) then 
				local realGlobal = QUEST_FACTION_NEEDED;
				QUEST_FACTION_NEEDED = "%s:%s:%s";
				local info = Sea.string.split(GetQuestLogLeaderBoard(i),":");
				QUEST_FACTION_NEEDED = realGlobal;
				
				item.info = {};
				item.info.name = info[1];
				item.info.done = info[2];
				item.info.total = info[3];
			end
			table.insert(questInfo.objectives, item);
		end
	
		if ( GetQuestLogRequiredMoney() > 0 ) then
			questInfo.requiredMoney = GetQuestLogRequiredMoney();
		end
		questInfo.rewardMoney = GetQuestLogRewardMoney();
	
		questInfo.rewards = {};
		questInfo.choices = {};
		
		for i=1, GetNumQuestLogChoices(), 1 do	
			local item = {};
			item.name, item.texture, item.numItems, item.quality, item.isUsable = GetQuestLogChoiceInfo(i);

			local info = GetQuestLogItemLink("choice", i );
			if ( info ) then 
				item.info = {};		
				item.info.color = string.gsub(info, "|c(.*)|H(.*)|h(.*)|h|r.*", "%1");
				item.info.link = string.gsub(info, "|c(.*)|H(.*)|h(.*)|h|r.*", "%2");
				item.info.linkname = string.gsub(info, "|c(.*)|H(.*)|h(.*)|h|r.*", "%3");
			end		
			table.insert(questInfo.choices, item);
		end
		for i=1, GetNumQuestLogRewards(), 1 do
			local item = {};
			item.name, item.texture, item.numItems, item.quality, item.isUsable = GetQuestLogRewardInfo(i);

			local info = GetQuestLogItemLink("reward", i );
			if ( info ) then 
				item.info = {};
				item.info.color = string.gsub(info, "|c(.*)|H(.*)|h(.*)|h|r.*", "%1");
				item.info.link = string.gsub(info, "|c(.*)|H(.*)|h(.*)|h|r.*", "%2");
				item.info.linkname = string.gsub(info, "|c(.*)|H(.*)|h(.*)|h|r.*", "%3");
			end

			table.insert(questInfo.rewards, item);
		end

		if ( GetRewardSpell() ) then		
			questInfo.spellReward={};
			questInfo.spellReward.texture, questInfo.spellReward.name = GetQuestLogRewardSpell();
		end		
	
		-- Unprotect
		Sea.wow.questLog.unprotectQuestLog();		

		return questInfo;
	end;
};

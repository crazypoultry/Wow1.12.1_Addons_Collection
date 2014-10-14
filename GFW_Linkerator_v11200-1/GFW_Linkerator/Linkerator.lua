------------------------------------------------------
-- Linkerator.lua
-- Link scanning code based on LootLink 1.9. Thanks Telo!
------------------------------------------------------
FLT_VERSION = "11200.1";
------------------------------------------------------

FLT_BasicItemLinks = { };
FLT_RandomItemIDs = { };
FLT_RandomPropIDs = { };
FLT_RandomItemCombos = { };
FLT_EnchantLinks = { };

FLT_Locale = GetLocale();
FLT_BasicItemLinks[FLT_Locale] = { };
FLT_RandomItemIDs[FLT_Locale] = { };
FLT_RandomPropIDs[FLT_Locale] = { };
FLT_RandomItemCombos[FLT_Locale] = { };
FLT_EnchantLinks[FLT_Locale] = { };

local ChatMessageTypes = {
	"CHAT_MSG_SYSTEM",
	"CHAT_MSG_SAY",
	"CHAT_MSG_TEXT_EMOTE",
	"CHAT_MSG_YELL",
	"CHAT_MSG_WHISPER",
	"CHAT_MSG_PARTY",
	"CHAT_MSG_GUILD",
	"CHAT_MSG_OFFICER",
	"CHAT_MSG_CHANNEL",
	"CHAT_MSG_RAID",
	"CHAT_MSG_LOOT",
};

local INVENTORY_SLOT_LIST = {
	{ name = "HeadSlot" },
	{ name = "NeckSlot" },
	{ name = "ShoulderSlot" },
	{ name = "BackSlot" },
	{ name = "ChestSlot" },
	{ name = "ShirtSlot" },
	{ name = "TabardSlot" },
	{ name = "WristSlot" },
	{ name = "HandsSlot" },
	{ name = "WaistSlot" },
	{ name = "LegsSlot" },
	{ name = "FeetSlot" },
	{ name = "Finger0Slot" },
	{ name = "Finger1Slot" },
	{ name = "Trinket0Slot" },
	{ name = "Trinket1Slot" },
	{ name = "MainHandSlot" },
	{ name = "SecondaryHandSlot" },
	{ name = "RangedSlot" },
};

-- number greater than the highest known item ID, used to import link names from client cache.
-- may need updating as future patches/expansions add items to the game.
FLT_MAX_ITEM_ID = 30000;

-- Anti-freeze code borrowed from ReagentInfo (in turn, from Quest-I-On):
-- keeps WoW from locking up if we try to scan the tradeskill window too fast.
FLT_TradeSkillLock = { };
FLT_TradeSkillLock.NeedScan = false;
FLT_TradeSkillLock.Locked = false;
FLT_TradeSkillLock.EventTimer = 0;
FLT_TradeSkillLock.EventCooldown = 0;
FLT_TradeSkillLock.EventCooldownTime = 1;
FLT_CraftLock = { };
FLT_CraftLock.NeedScan = false;
FLT_CraftLock.Locked = false;
FLT_CraftLock.EventTimer = 0;
FLT_CraftLock.EventCooldown = 0;
FLT_CraftLock.EventCooldownTime = 1;

StaticPopupDialogs["FLT_UPGRADE_DB"] = {
	text = "Your database from earlier versions of Linkerator should be upgraded to a new format for better performance. Do so now? (This may lock up the WoW UI for up to a minute.) To perform the upgrade later, type '/link import' at any time.",
	button1 = "Upgrade",
	button2 = TEXT(CANCEL),
	OnAccept = function(data)
		FLT_ImportLinks();
	end,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = 1
};

function FLT_ChatEdit_OnChar()
	
	local text = this:GetText();
	
	if (string.find(text, "^/script") or string.find(text, "^/dump")) then
		if (FLT_Orig_ChatEdit_OnChar) then FLT_Orig_ChatEdit_OnChar(); end
		return; -- don't parse these
	end

	-- if the text contains any completed (brackets on both sides) links, "linkify" them
    local newText = FLT_ParseChatMessage(text);
	if (newText ~= text) then
		this:SetText(newText);
		FLT_PartialText = nil;
		FLT_Matches = nil;
		FLT_LastCompletion = nil;
		return;
	end

	-- if we just typed a ']' and had highlighted completion text, finish it
	local _, _, closedPart = string.find(text, "%[([^]]-)%]$");
	if (closedPart and FLT_LastCompletion) then
		local lowerQuery = string.lower(closedPart); -- for case insensitive lookups
		if (string.sub(FLT_LastCompletion, 1, string.len(lowerQuery)) == lowerQuery) then
			local newText = string.gsub(text, "%[([^]]-)%]$", "["..FLT_LastCompletion.."]");
		    newText = FLT_ParseChatMessage(newText);
			if (newText ~= text) then
				this:SetText(newText);
				FLT_PartialText = nil;
				FLT_Matches = nil;
				FLT_LastCompletion = nil;
				return;
			end
		end
	end
	
	-- otherwise, see if there's a partial link typed and provide highlighted completion
	local textlen = strlen(text);
    local _, _, query = string.find(text, "%[([^]]-)$");
	if (query and string.len(query) > 0) then
		FLT_PartialText = text;
		FLT_Matches = FLT_LinkPrefixMatches(query);
		FLT_MatchCount = 1;
		
		if (FLT_Matches and FLT_Matches[FLT_MatchCount]) then
			local lowerQuery = string.lower(query); -- for case insensitive lookups
			lowerQuery = string.gsub(lowerQuery, "([%$%(%)%.%[%]%*%+%-%?%^%%])", "%%%1"); -- convert regex special characters
			local completion = string.gsub(FLT_Matches[FLT_MatchCount], "^"..lowerQuery, query);
			local newText = string.gsub(text, "%[([^]]-)$", "["..completion);
			FLT_LastCompletion = completion;
			this:SetText(newText);
			this:HighlightText(textlen, -1);
			FLT_HighlightStart = textlen;
			return;
		end
	end

	if (FLT_Orig_ChatEdit_OnChar) then FLT_Orig_ChatEdit_OnChar(); end
	
end

FLT_Orig_ChatEdit_SendText = ChatEdit_SendText;
function ChatEdit_SendText(editBox, addHistory)
	local text = editBox:GetText();	
	if (string.find(text, "^/script") or string.find(text, "^/dump")) then
		 -- don't parse these
	else
		-- if the text contains any completed (brackets on both sides) links, "linkify" them
	    local newText = FLT_ParseChatMessage(text);
		if (newText ~= text) then
			editBox.ignoreTextChange = 1;
			editBox:SetText(newText);
			editBox.ignoreTextChange = nil;
		end
	end
	FLT_Orig_ChatEdit_SendText(editBox, addHistory);
end

FLT_Orig_ChatEdit_OnTextChanged = ChatEdit_OnTextChanged;
function ChatEdit_OnTextChanged()
    local text = this:GetText();
	if (string.find(text, "^/script") or string.find(text, "^/dump") or this.ignoreTextChange) then
		return;
	end
	if (FLT_PartialText and string.len(text) < string.len(FLT_PartialText)) then
		FLT_PartialText = text;
	    local _, _, query = string.find(FLT_PartialText, "%[([^]]-)$");
		if (query and string.len(query) > 0) then
			FLT_Matches = FLT_LinkPrefixMatches(query);
		end
	end
	FLT_Orig_ChatEdit_OnTextChanged(this);
	if (FLT_HighlightStart and FLT_HighlightStart < string.len(text)) then
		this:HighlightText(FLT_HighlightStart, -1);
		FLT_HighlightStart = nil;
	end
end

FLT_Orig_ChatEdit_OnTabPressed = ChatEdit_OnTabPressed;
function ChatEdit_OnTabPressed()
	if (FLT_Matches and table.getn(FLT_Matches) > 0) then

		local prefix = FLT_CommonPrefixFromList(FLT_Matches);
			
	    local _, _, query = string.find(FLT_PartialText, "%[([^]]-)$");
		local lowerQuery = string.lower(query); -- for case insensitive lookups
		lowerQuery = string.gsub(lowerQuery, "([%$%(%)%.%[%]%*%+%-%?%^%%])", "%%%1"); -- convert regex special characters
		if (prefix and string.len(prefix) > string.len(query)) then
			local expandedPrefix = string.gsub(prefix, "^"..lowerQuery, query);
			local newText = string.gsub(FLT_PartialText, "%[([^]]-)$", "["..expandedPrefix);
			if (FLT_PartialText ~= newText) then
				this:SetText(newText);
				FLT_ChatEdit_OnChar(this);
				FLT_PartialText = newText;
			    local _, _, newQuery = string.find(FLT_PartialText, "%[([^]]-)$");
				if (newQuery and string.len(newQuery) > 0) then
					FLT_Matches = FLT_LinkPrefixMatches(newQuery);
				end
			end
			return;
		elseif (FLT_Matches and table.getn(FLT_Matches) > 0) then
			-- we've hit tab and there's no prefix to expand
			FLT_MatchCount = FLT_MatchCount + 1;
			if (FLT_MatchCount > table.getn(FLT_Matches)) then
				FLT_MatchCount = 1;
			end
		
			-- if we add a display of the match list, it should go here...

			local completion = string.gsub(FLT_Matches[FLT_MatchCount], "^"..lowerQuery, query);
			newText = string.gsub(FLT_PartialText, "%[([^]]-)$", "["..completion);
			FLT_LastCompletion = completion;
			this:SetText(newText);
			this:HighlightText(string.len(FLT_PartialText), -1);
			return;
		end
	end
	FLT_Orig_ChatEdit_OnTabPressed(this);
end

FLT_Orig_QuestLog_UpdateQuestDetails = QuestLog_UpdateQuestDetails;
function QuestLog_UpdateQuestDetails()
	for i = 1, GetNumQuestLogChoices() do
		link = GetQuestLogItemLink("choice", i);
		if (link) then
			FLT_ProcessLinks(link);
		end
	end
	for i = 1, GetNumQuestLogRewards() do
		link = GetQuestLogItemLink("reward", i);
		if (link) then
			FLT_ProcessLinks(link);
		end
	end
	FLT_Orig_QuestLog_UpdateQuestDetails();
end

function FLT_OnLoad()
	--GFWUtils.Debug = 1;
	-- Register Slash Commands
	SLASH_FLT1 = "/linkerator";
	SLASH_FLT2 = "/link";
	SlashCmdList["FLT"] = function(msg)
		FLT_ChatCommandHandler(msg);
	end
	
	for index, value in ChatMessageTypes do
		this:RegisterEvent(value);
	end

	for index = 1, getn(INVENTORY_SLOT_LIST), 1 do
		INVENTORY_SLOT_LIST[index].id = GetInventorySlotInfo(INVENTORY_SLOT_LIST[index].name);
	end
		
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("PLAYER_LEAVING_WORLD");
	this:RegisterEvent("PLAYER_TARGET_CHANGED");
	this:RegisterEvent("BANKFRAME_OPENED");
	this:RegisterEvent("MERCHANT_SHOW");
	this:RegisterEvent("TRADE_SKILL_SHOW");
	this:RegisterEvent("TRADE_SKILL_UPDATE");
	this:RegisterEvent("CRAFT_SHOW");
	this:RegisterEvent("CRAFT_UPDATE");
	this:RegisterEvent("QUEST_COMPLETE");
	this:RegisterEvent("QUEST_DETAIL");
	this:RegisterEvent("QUEST_FINISHED");
	this:RegisterEvent("QUEST_PROGRESS");
	this:RegisterEvent("QUEST_GREETING");
	this:RegisterEvent("AUCTION_ITEM_LIST_UPDATE");
	
	FLT_Orig_ChatEdit_OnChar = ChatFrameEditBox:GetScript("OnChar");
	ChatFrameEditBox:SetScript("OnChar", FLT_ChatEdit_OnChar);
	
	GFWUtils.Print("Fizzwidget Linkerator "..FLT_VERSION.." initialized!");
	
end

function FLT_OnUpdate(elapsed)
	-- If it's been more than a second since our last tradeskill update,
	-- we can allow the event to process again.
	FLT_TradeSkillLock.EventTimer = FLT_TradeSkillLock.EventTimer + elapsed;
	if (FLT_TradeSkillLock.Locked) then
		FLT_TradeSkillLock.EventCooldown = FLT_TradeSkillLock.EventCooldown + elapsed;
		if (FLT_TradeSkillLock.EventCooldown > FLT_TradeSkillLock.EventCooldownTime) then

			FLT_TradeSkillLock.EventCooldown = 0;
			FLT_TradeSkillLock.Locked = false;
		end
	end
	FLT_CraftLock.EventTimer = FLT_CraftLock.EventTimer + elapsed;
	if (FLT_CraftLock.Locked) then
		FLT_CraftLock.EventCooldown = FLT_CraftLock.EventCooldown + elapsed;
		if (FLT_CraftLock.EventCooldown > FLT_CraftLock.EventCooldownTime) then

			FLT_CraftLock.EventCooldown = 0;
			FLT_CraftLock.Locked = false;
		end
	end
	
	if (FLT_TradeSkillLock.NeedScan) then
		FLT_TradeSkillLock.NeedScan = false;
		FLT_ScanTradeSkill();
	end
	if (FLT_CraftLock.NeedScan) then
		FLT_CraftLock.NeedScan = false;
		FLT_ScanCraft();
	end
end

function FLT_OnEvent(event)
	if( event == "PLAYER_TARGET_CHANGED" ) then
		if( UnitIsUnit("target", "player") ) then
			return;
		elseif( UnitIsPlayer("target") ) then
			FLT_Inspect("target");
		end
	elseif( event == "PLAYER_ENTERING_WORLD" ) then
		FLT_ScanInventory();
		FLT_Inspect("player");
		if (FLT_ItemLinks) then
			local hasContent;
			for key, value in FLT_ItemLinks do
				hasContent = true;
				break;
			end
			if (hasContent) then
				StaticPopup_Show("FLT_UPGRADE_DB");
			else
				FLT_ItemLinks = nil;
			end
		end
		this:RegisterEvent("UNIT_INVENTORY_CHANGED");
	elseif( event == "PLAYER_LEAVING_WORLD" ) then
		this:UnregisterEvent("UNIT_INVENTORY_CHANGED");
	elseif( event == "UNIT_INVENTORY_CHANGED" ) then
		if( arg1 == "player" ) then
			FLT_ScanInventory();
			FLT_Inspect("player");
		end
	elseif( event == "MERCHANT_SHOW" ) then
		for i=1, GetMerchantNumItems() do
			local link = GetMerchantItemLink(i);
			if ( link ) then
				FLT_ProcessLinks(link);
			end
		end
	elseif( event == "BANKFRAME_OPENED" ) then
		FLT_ScanBank();
	elseif( event == "AUCTION_ITEM_LIST_UPDATE" ) then
		FLT_ScanAuction();
	elseif ( event == "QUEST_COMPLETE" or event == "QUEST_DETAIL" or event == "QUEST_FINISHED" or event == "QUEST_PROGRESS" or event == "QUEST_GREETING") then
		FLT_ScanQuestgiver();
	elseif ( event == "TRADE_SKILL_SHOW" or event == "TRADE_SKILL_UPDATE" ) then
		FLT_ScanTradeSkill();
	elseif ( event == "CRAFT_SHOW" or event == "CRAFT_UPDATE" ) then
		FLT_ScanCraft();
	elseif (event == "CHAT_MSG_CHANNEL") then
		--DevTools_Dump({event=event, args={arg1=arg1,arg2=arg2,arg3=arg3,arg4=arg4,arg5=arg5,arg6=arg6,arg7=arg7,arg8=arg8,arg9=arg9,}});
		if (FLT_Debug) then
			debugprofilestart();
		end
		local gotLink = FLT_ProcessLinks(arg1);
		if (FLT_Debug) then
			local parseTime = debugprofilestop();
			if (gotLink) then
				FLT_MaxFoundTime = math.max((FLT_MaxFoundTime or 0), parseTime);
			else
				FLT_MaxNotFoundTime = math.max((FLT_MaxNotFoundTime or 0), parseTime);
			end
		end
	else
		FLT_ProcessLinks(arg1);
	end
end

function FLT_ChatCommandHandler(msg)

	-- Print Help
	if ( msg == "help" ) or ( msg == "" ) then
		GFWUtils.Print("Fizzwidget Linkerator "..FLT_VERSION..":");
		GFWUtils.Print("/linkerator (or /link) <command>");
		GFWUtils.Print("- "..GFWUtils.Hilite("help").." - Print this helplist.");
		GFWUtils.Print("- "..GFWUtils.Hilite("<item name>").." - Print a hyperlink to the chat window for an item known by name.");
		GFWUtils.Print("- "..GFWUtils.Hilite("<item id #>").." - Print a hyperlink to the chat window for a generic item whose ID number is known.");
		GFWUtils.Print("- "..GFWUtils.Hilite("<code>").." - Print a hyperlink to the chat window for an item whose complete link code is known.");
		return;
	end
	
	if (msg == "version") then
		GFWUtils.Print("Fizzwidget Linkerator "..FLT_VERSION);
		return;
	end
		
	if (msg == "count") then
		local totalCount, knownCount = 0, 0;
		for name, linkInfo in FLT_BasicItemLinks[FLT_Locale] do
			if (type(linkInfo) == "number") then
				totalCount = totalCount + 1;
				if (GetItemInfo(linkInfo)) then
					knownCount = knownCount + 1;
				end
			elseif (type(linkInfo) == "table") then
				for _, linkID in linkInfo do
					totalCount = totalCount + 1;
					if (GetItemInfo(linkID)) then
						knownCount = knownCount + 1;
					end
				end
			end
		end
		GFWUtils.Print(GFWUtils.Hilite(totalCount).." basic items in history, "..GFWUtils.Hilite(knownCount).." known to client.");
		
		local baseCount, propCount = 0, 0;
		for baseName, baseID in FLT_RandomItemIDs[FLT_Locale] do
			baseCount = baseCount + 1;
		end
		for propID, propName in FLT_RandomPropIDs[FLT_Locale] do
			propCount = propCount + 1;
		end
		GFWUtils.Print(GFWUtils.Hilite(baseCount).." base items and "..GFWUtils.Hilite(propCount).." property IDs in history.");

		totalCount, knownCount = 0, 0;
		for baseID, propTable in FLT_RandomItemCombos[FLT_Locale] do
			for _, propID in propTable do
				totalCount = totalCount + 1;
				if (GetItemInfo(string.format("item:%d:0:%d:0", baseID, propID))) then
					knownCount = knownCount + 1;
				end
			end
		end
		GFWUtils.Print(GFWUtils.Hilite(totalCount).." observed random-property variations, "..GFWUtils.Hilite(knownCount).." known to client.");
		
		totalCount = 0;
		for name, linkInfo in FLT_EnchantLinks[FLT_Locale] do
			totalCount = totalCount + 1;
			-- enchant links are always known to the WoW client
		end
		GFWUtils.Print(GFWUtils.Hilite(totalCount).." enchants in history.");
		return;
	end
	
	if (FLT_Debug and msg == "time") then
		GFWUtils.Print(string.format("Max parse time "..GFWUtils.Hilite("%.2f").." ms (no links found)", FLT_MaxNotFoundTime * 1000));
		GFWUtils.Print(string.format("Max parse time "..GFWUtils.Hilite("%.2f").." ms (links found)", FLT_MaxFoundTime * 1000));
		return;
	end
	
	if (msg == "debug") then
		if (FLT_Debug) then
			FLT_Debug = nil;
			GFWUtils.Print("Linkerator debugging messages off.");
		else
			FLT_Debug = 1;
			GFWUtils.Print("Linkerator debugging messages on.");
		end
		return;
	end
	
	if (msg == "import" or msg == "audit") then
		FLT_ImportLinks();
		return;
	end
	
	if (msg and msg ~= "") then
		if (FLT_PrintLinkSearch(msg)) then return; end
	end
	
	-- If we're this far, we probably have bad input.
	FDP_ChatCommandHandler("help");
end

function FLT_ImportLinks()

	-- import any cached items
	local cacheCount = 0;
	for itemID = 1, FLT_MAX_ITEM_ID do
		local _, added = FLT_GetItemLink(itemID, 1);
		if (added) then
			cacheCount = cacheCount + 1;
			if (itemID > FLT_MAX_ITEM_ID - 100) then
				GFWUtils.PrintOnce("In-game item IDs approaching "..FLT_MAX_ITEM_ID.."; seek a new version of Linkerator from fizzwidget.com");
			end
		end
	end
	GFWUtils.Print("Imported "..GFWUtils.Hilite(cacheCount).. " items from WoW client's cache.");
	
	-- import from LootLink
	local lootLinkCount = 0;
	if (ItemLinks and type(ItemLinks) == "table") then
		for itemName, lootLinkInfo in ItemLinks do
			if (lootLinkInfo.i and type(lootLinkInfo.i) == "string") then
				local itemLink = "item:"..lootLinkInfo.i;
				local addedLink = FLT_AddLink(itemName, itemLink);
				if (addedLink) then
					lootLinkCount = lootLinkCount + 1;
				end
			end
		end
	end
	GFWUtils.Print("Imported "..GFWUtils.Hilite(lootLinkCount).. " items from LootLink.");

	-- go thru our own DB and move entries to the new format
	if (FLT_ItemLinks) then
		local purgedCount, migratedCount = 0, 0;
		for key, linkInfo in FLT_ItemLinks do
			if (type(linkInfo) == "string" or type(linkInfo) == "number") then
				local actualName = GetItemInfo(linkInfo);
				if (actualName and string.lower(actualName) ~= key) then
					purgedCount = purgedCount + 1;
				else
					FLT_AddLink(key, linkInfo);
					migratedCount = migratedCount + 1;
				end
				FLT_ItemLinks[key] = nil;
			elseif (type(linkInfo) == "table") then
				for _, aLink in linkInfo do
					if (type(aLink) == "string" or type(aLink) == "number") then
						local actualName = GetItemInfo(aLink);
						if (actualName and string.lower(actualName) ~= key) then
							purgedCount = purgedCount + 1;
						else
							FLT_AddLink(key, aLink);
							migratedCount = migratedCount + 1;
						end
					end
				end
				FLT_ItemLinks[key] = nil;
			end
		end
		GFWUtils.Print("Purged "..GFWUtils.Hilite(purgedCount).." invalid entries.");
		GFWUtils.Print("Migrated "..GFWUtils.Hilite(migratedCount).." entries from old data format.");
		FLT_ItemLinks = nil;
	end
end

function FLT_GetItemLink(linkInfo, shouldAdd)
	if (linkInfo == nil) then
		FLT_DebugLog(debugstack(1, 3, 0));
		error("invalid argument #1 to FLT_GetItemLink()", 2);
	end
	local sName, sLink, iQuality, iLevel, sType, sSubType, iCount = GetItemInfo(linkInfo);
	if (sName) then
		local _, _, _, color = GetItemQualityColor(iQuality);
		local linkFormat = "%s|H%s|h[%s]|h|r";
		local added;
		if (shouldAdd) then
			added = FLT_AddLink(sName, sLink); -- add it to our name index if we're getting it from another source
		end
		return string.format(linkFormat, color, sLink, sName), added;
	else
		return nil, nil;
	end
end

function FLT_PrintLinkSearch(msg)
	if (tonumber(msg)) then
		--DevTools_Dump({msg=msg});
		local link = FLT_GetItemLink(msg, 1);
		if (link) then
			GFWUtils.Print("Item ID "..msg..": "..link);
		else
			GFWUtils.Print("Item ID "..msg.." is unknown to this WoW client.");
		end
		return true;
	end
	
	local _, _, itemLink = string.find(msg, "(item:%d+:%d+:%d+:%d+)");
	local _, _, enchantLink = string.find(msg, "(enchant:%d+)");
	if (itemLink) then
		--DevTools_Dump({msg=msg, itemLink=itemLink});
		local link = FLT_GetItemLink(itemLink);
		if (link) then
			GFWUtils.Print(itemLink..": "..link);
		else
			GFWUtils.Print(itemLink.." is unknown to this WoW client.");
		end
		return true;
	elseif (enchantLink) then
		--DevTools_Dump({msg=msg, itemLink=itemLink});
		local _, _, enchantID = string.find(msg, "enchant:(%d+)");
		local link = FLT_EnchantLink(enchantID, 1);
		if (link) then
			GFWUtils.Print(enchantLink..": "..link);
		else
			GFWUtils.Print(enchantLink.." is unknown.");
		end
		return true;
	end
		
	-- start with basic item links (no random property)
	local foundCount = 0;
	msg = string.lower(msg);
	for itemName, linkInfo in FLT_BasicItemLinks[FLT_Locale] do
		-- exact matches will be found again at the end, so we won't print them here
		if (itemName ~= msg and string.find(itemName, msg, 1, true)) then
			if (type(linkInfo) == "number") then
				local link = FLT_GetItemLink(linkInfo);
				if (link) then
					if (FLT_Debug) then
						GFWUtils.Print(link.." ("..linkInfo..")");
					else
						GFWUtils.Print(link);
					end
					foundCount = foundCount + 1;
				end
			elseif (type(linkInfo) == "table") then
				for _, aLink in linkInfo do
					local link = FLT_GetItemLink(aLink);
					if (link) then
						if (FLT_Debug) then
							GFWUtils.Print(link.." ("..aLink..")");
						else
							GFWUtils.Print(link);
						end
						foundCount = foundCount + 1;
					end
				end
			else
				GFWUtils.Print(GFWUtils.Red("Linkerator error: ").."Unexpected data in FLT_BasicItemLinks["..FLT_Locale.."] for "..GFWUtils.Hilite(itemName)..".");
			end
		end
	end
	
	-- search random-property items
	for baseName, itemID in FLT_RandomItemIDs[FLT_Locale] do
		if (string.find(msg, baseName, 1, true)) then
			-- if the query string entirely contains the base name, search for observed variations that match
			local observedVariations = FLT_RandomItemCombos[FLT_Locale][itemID];
			if (observedVariations) then
				for _, propID in observedVariations do
					local propName = FLT_RandomPropIDs[FLT_Locale][propID];
					if (propName) then
						--DevTools_Dump({baseName=baseName, propName=propName, itemID=itemID, propID=propID})
						local fullName = string.format(propName, baseName);
						if (string.find(fullName, msg, 1, true)) then
							local fullLink = string.format("item:%d:0:%d:0", itemID, propID);
							local link = FLT_GetItemLink(fullLink);
							if (link) then
								if (FLT_Debug) then
									GFWUtils.Print(link.." ("..fullLink..")");
								else
									GFWUtils.Print(link);
								end
								foundCount = foundCount + 1;
							end
						end
					end
				end
			end
		elseif (string.find(baseName, msg, 1, true)) then
			-- if the query string is a substring of the base name, just list the base item with some info on the variations
			local observedVariations = FLT_RandomItemCombos[FLT_Locale][itemID];
			local variationCount = 0;
			if (observedVariations) then
				variationCount = table.getn(observedVariations);
			end
			local link = FLT_GetItemLink(itemID);
			if (link) then
				local extraText = string.format(": random-property item (%s variants seen), type %s to see them all", GFWUtils.Hilite(variationCount), GFWUtils.Hilite("/link "..baseName));
				if (FLT_Debug) then
					GFWUtils.Print(link.." ("..itemID..")"..extraText);
				else
					GFWUtils.Print(link..extraText);
				end
				foundCount = foundCount + 1;
			end
		end
	end
	
	-- search enchants too
	for name, id in FLT_EnchantLinks[FLT_Locale] do
		if (string.find(name, msg, 1, true)) then
			local link = FLT_EnchantLink(id);
			if (link) then
				if (FLT_Debug) then
					GFWUtils.Print(link.." (enchant:"..id..")");
				else
					GFWUtils.Print(link);
				end
				foundCount = foundCount + 1;
			end
		end
	end
	
	-- also search for exact matches and query strings with parenthesized descriptors
	local foundLinks = FLT_GetLinkByName(msg, true);
	if (foundLinks) then
		if (type(foundLinks) == "string") then
			foundCount = foundCount + 1;
			if (FLT_Debug) then
				local _, _, linkInfo = string.find(foundLinks, "(item:%d+:%d+:%d+:%d+)");
				if (linkInfo == nil) then
					_, _, linkInfo = string.find(foundLinks, "(enchant:%d+)");
				end
				GFWUtils.Print(foundLinks.." ("..linkInfo..")");
			else
				GFWUtils.Print(foundLinks);
			end
		elseif (type(foundLinks) == "table") then
			for _, aLink in foundLinks do
				foundCount = foundCount + 1;
				if (FLT_Debug) then
					local _, _, linkInfo = string.find(aLink, "(item:%d+:%d+:%d+:%d+)");
					if (linkInfo == nil) then
						_, _, linkInfo = string.find(aLink, "(enchant:%d+)");
					end
					GFWUtils.Print(aLink.." ("..linkInfo..")");
				else
					GFWUtils.Print(aLink);
				end
			end
		else
			GFWUtils.Print(GFWUtils.Red("Linkerator error: ").."Unexpected result from FLT_GetLinkByName().");
		end
	end
	
	if (foundCount > 0) then
		GFWUtils.Print(GFWUtils.Hilite(foundCount).." links found for '"..GFWUtils.Hilite(msg).."'");
	else
		GFWUtils.Print("Could not find '"..GFWUtils.Hilite(msg).."' in Linkerator's item history.");
		GFWUtils.Print("Type '"..GFWUtils.Hilite("/link help").."' for options.");
	end
	return true;
end

function FLT_GetLinkByName(text, returnAll)
	
	-- if we're passed some form of link code, just resolve it
	if (string.find(text, "^(item:%d+:%d+:%d+:%d+)$")) then
		local link = FLT_GetItemLink(text);
		if (link) then return link; end
	elseif (string.find(text, "^(enchant:%d+)$")) then
		local _, _, enchantID = string.find(text, "enchant:(%d+)");
		local link = FLT_EnchantLink(enchantID);
		if (link) then return link; end
	elseif (string.find(text, "^#%d+$")) then
		local link = FLT_GetItemLink(string.sub(text,2));
		if (link) then return link; end
	end

	-- otherwise, we get into searching for matches by name
	local lowerText = string.lower(text);
	local allResults = {};
	
	-- try to find exact matches for the text in basic (no random property) items
	local basicResult = FLT_BasicItemLinks[FLT_Locale][lowerText];
	if (type(basicResult) == "number") then
		local link = FLT_GetItemLink(basicResult);
		if (link) then 
			if (returnAll) then
				table.insert(allResults, link);
			else
				return link;
			end
		end
	elseif (type(basicResult) == "table") then
		-- if there are multiple basic items with the same name and we're not in returnAll mode, return the first
		for _, aLink in basicResult do
			local link = FLT_GetItemLink(aLink);
			if (link) then 
				if (returnAll) then
					table.insert(allResults, link);
				else
					return link;
				end
			end
		end
	elseif (basicResult) then
		FLT_DebugLog("Unexpected data in FLT_BasicItemLinks["..FLT_Locale.."] for "..GFWUtils.Hilite(lowerText or "(nil)"));
		if (DevTools_Dump) then DevTools_Dump(basicResult); end
	end
		
	-- try to find exact matches in the random-property items
	for baseName, itemID in FLT_RandomItemIDs[FLT_Locale] do
		if (string.find(lowerText, baseName, 1, true)) then
			-- if the query string entirely contains the base name, search for observed variations that match
			local observedVariations = FLT_RandomItemCombos[FLT_Locale][itemID];
			if (observedVariations) then
				for _, propID in observedVariations do
					local propName = FLT_RandomPropIDs[FLT_Locale][propID];
					if (propName) then
						--DevTools_Dump({baseName=baseName, propName=propName, itemID=itemID, propID=propID})
						local fullName = string.format(propName, baseName);
						if (fullName == lowerText) then
							local fullLink = string.format("item:%d:0:%d:0", itemID, propID);
							local link = FLT_GetItemLink(fullLink);
							if (link) then 
								if (returnAll) then
									table.insert(allResults, link);
								else
									return link;
								end
							end
						end
					end
				end
			end
		end
	end
	
	-- try to find exact matches in enchants
	local enchantResult = FLT_EnchantLinks[FLT_Locale][lowerText];
	if (enchantResult) then
		local link = FLT_EnchantLink(enchantResult);
		if (link) then 
			if (returnAll) then
				table.insert(allResults, link);
			else
				return link;
			end
		end
	end
	
	-- no exact matches, so we prepare to look for parenthesized description elements and search based on those
	local _, _, name, description = string.find(lowerText, "(.+)%((.-)%)" );
	-- 'description' here is some text from the item's tooltip, such as part of a slot name or a stat line
	-- e.g. "warblade of the hakkari (main)" or "funky boots of the eagle (11 int)"
	if (name and description) then
		name = string.gsub(name, " +$", ""); -- drop trailing spaces
	
		-- back in the basic (no random property) items, now looking based on description
		local basicResult = FLT_BasicItemLinks[FLT_Locale][name];
		if (type(basicResult) == "number") then
			-- only one exact match for the name, no description needed
			local link = FLT_GetItemLink(basicResult);
			if (link) then 
				if (returnAll) then
					table.insert(allResults, link);
				else
					return link;
				end
			end
		elseif (type(basicResult) == "table") then
			-- see if the description matches the item type or equip location
			for _, itemLink in basicResult do
				if (FLT_ItemLinkMatchesDescriptor(itemLink, description)) then
					local link = FLT_GetItemLink(itemLink);
					if (link) then 
						if (returnAll) then
							table.insert(allResults, link);
						else
							return link;
						end
					end
				end
			end
			-- failing that, see if the description matches any text from the item tooltip
			for _, itemLink in basicResult do
				if (FLT_FindInItemTooltip(description, itemLink)) then
					local link = FLT_GetItemLink(itemLink);
					if (link) then 
						if (returnAll) then
							table.insert(allResults, link);
						else
							return link;
						end
					end
				end
			end 
		elseif (basicResult) then
			FLT_DebugLog("Unexpected data in FLT_BasicItemLinks["..FLT_Locale.."] for "..GFWUtils.Hilite(name or "(nil)"));
			if (DevTools_Dump) then DevTools_Dump(basicResult); end
		end
	
		-- look for random-property items based on description
		for baseName, itemID in FLT_RandomItemIDs[FLT_Locale] do
			if (string.find(name, baseName, 1, true)) then
				-- if the query string entirely contains the base name, search for observed variations that match
				local observedVariations = FLT_RandomItemCombos[FLT_Locale][itemID];
				if (observedVariations) then
					for _, propID in observedVariations do
						local propName = FLT_RandomPropIDs[FLT_Locale][propID];
						if (propName) then
							--DevTools_Dump({baseName=baseName, propName=propName, itemID=itemID, propID=propID})
							local fullName = string.format(propName, baseName);
							if (fullName == name) then
								local fullLink = string.format("item:%d:0:%d:0", itemID, propID);
								-- see if the description matches the item type or equip location
								if (FLT_ItemLinkMatchesDescriptor(fullLink, description)) then
									local link = FLT_GetItemLink(fullLink);
									if (link) then 
										if (returnAll) then
											table.insert(allResults, link);
										else
											return link;
										end
									end
								end
								-- failing that, see if the description matches any text from the item tooltip
								if (FLT_FindInItemTooltip(description, fullLink)) then
									local link = FLT_GetItemLink(fullLink);
									if (link) then 
										if (returnAll) then
											table.insert(allResults, link);
										else
											return link;
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end
	
	if (returnAll and table.getn(allResults) > 0) then
		return allResults;
	end
end

function FLT_ItemLinkMatchesDescriptor(itemLink, description)
	-- see if the description matches the item type or equip location
	local _, _, _, _, type, subType, _, equipLoc = GetItemInfo(itemLink);
	if ((type and string.find(string.lower(type), description, 1, true)) 
	 or (subType and string.find(string.lower(subType), description, 1, true))
	 or (getglobal(equipLoc) and string.find(string.lower(getglobal(equipLoc)), description, 1, true))) then
		return true;
	end
end

function FLT_ProcessLinks(text)
	local lastLink;
	if ( text ) then
		local link, name;
		for link, name in string.gfind(text, "|c%x+|H(item:%d+:%d+:%d+:%d+)|h%[(.-)%]|h|r") do
			if (link and name and name ~= "") then
				lastLink = FLT_AddLink(name, link);
				if (lastLink) then 
					pcall(setHyperlink, LinkeratorTip, link); -- get our WoW client to cache it if possible
				end
			end
		end
		for link, name in string.gfind(text, "|c%x+|H(enchant:%d+)|h%[(.-)%]|h|r") do
			if (link and name and name ~= "") then
				lastLink = FLT_AddLink(name, link);
			end
		end
	end
	return lastLink;
end

function FLT_AddLink(name, link)
	name = string.lower(name); -- so we can do case-insensitive lookups
	local itemID, randomProp;
	if (type(link) == "number") then
		itemID = link;
	elseif (type(link) == "string") then
		_, _, itemID, randomProp = string.find(link, "item:(%d+):%d+:(%d+):%d+");
		itemID, randomProp = tonumber(itemID), tonumber(randomProp);
		if (itemID == nil) then
			itemID = tonumber(link);
		end
	end
	--DevTools_Dump({name=name, link=link, itemID=itemID, randomProp=randomProp})
	if (itemID and (randomProp == 0 or randomProp == nil)) then
		return FLT_AddBasicItemLink(name, itemID);
	elseif (itemID) then
		return FLT_AddRandomPropertyItemLink(name, link);
	else
		local _, _, enchantLink = string.find(link, "(enchant:%d+)");
		if (enchantLink) then
			return FLT_AddEnchantLink(name, enchantLink);
		end
	end

	-- if we got down to here, it's bad input
	GFWUtils.Print("Error: unparseable link passed to FLT_AddLink()");
	FLT_DebugLog("Name: "..GFWUtils.Hilite(name or "(nil)").." Link: "..GFWUtils.Hilite(link or "(nil)"));
	FLT_DebugLog(debugstack(2, 1, 0));
end

function FLT_AddBasicItemLink(name, itemID)
	itemID = tonumber(itemID);
	if (itemID == nil) then
		GFWUtils.Print("Error: nil itemID passed to FLT_AddBasicItemLink()");
		FLT_DebugLog("Name: "..GFWUtils.Hilite(name or "(nil)").." Link: "..GFWUtils.Hilite(itemID or "(nil)"));
		FLT_DebugLog(debugstack(2, 1, 0));
		return;
	end
	
	if (FLT_RandomItemIDs[FLT_Locale][name]) then
		-- random-property items never occur without their random properties, so we shouldn't list them as base items
		FLT_BasicItemLinks[FLT_Locale][name] = nil;
		return;
	end
	local existingLink = FLT_BasicItemLinks[FLT_Locale][name];
	if (existingLink == itemID) then
		return;
	elseif (existingLink == nil) then
		-- this is a new item name
		FLT_BasicItemLinks[FLT_Locale][name] = itemID;
		FLT_DebugLog("Added "..(FLT_GetItemLink(itemID) or name).." ("..itemID..") to FLT_BasicItemLinks["..FLT_Locale.."]");
		return itemID;
	elseif (type(existingLink) == "number") then
		FLT_BasicItemLinks[FLT_Locale][name] = {};
		table.insert(FLT_BasicItemLinks[FLT_Locale][name], existingLink);
		table.insert(FLT_BasicItemLinks[FLT_Locale][name], itemID);
		table.sort(FLT_BasicItemLinks[FLT_Locale][name]);
		FLT_DebugLog("Added "..(FLT_GetItemLink(itemID) or name).." ("..itemID..") to FLT_BasicItemLinks["..FLT_Locale.."]; changed to table");
		return itemID;
	elseif (type(existingLink) == "table") then
		local newLinks = {};
		table.insert(newLinks, itemID);
		for i, aLink in existingLink do
			if (GFWTable.KeyOf(newLinks, aLink) == nil) then
				table.insert(newLinks, aLink);
			end
		end
		if (table.getn(newLinks) == 1) then
			FLT_BasicItemLinks[FLT_Locale][name] = itemID;
			FLT_DebugLog("Changed "..(FLT_GetItemLink(itemID) or name).." ("..itemID..") in FLT_BasicItemLinks["..FLT_Locale.."] to item ID only, eliminated table");
			return itemID;
		elseif ( table.getn(newLinks) ~= table.getn(existingLink)) then
			table.sort(newLinks);
			FLT_BasicItemLinks[FLT_Locale][name] = newLinks;
			FLT_DebugLog("Added "..(FLT_GetItemLink(itemID) or name).." ("..itemID..") to FLT_BasicItemLinks["..FLT_Locale.."]; table count is now "..GFWTable.Count(FLT_BasicItemLinks[FLT_Locale][name]));
			return itemID;
		end
	else
		FLT_BasicItemLinks[FLT_Locale][name] = itemID;
		FLT_DebugLog("Corrupt entry for "..(FLT_GetItemLink(itemID) or name).." in FLT_BasicItemLinks["..FLT_Locale.."]; replacing with ("..itemID..").");
		return itemID;
	end
end

function FLT_AddRandomPropertyItemLink(name, link)
	local cleanLink = string.gsub(link, "item:(%d+):%d+:(%d+):%d+", "item:%1:0:%2:0"); -- strip uniqID, enchant
	local _, _, itemID, randomProp = string.find(link, "item:(%d+):%d+:(%d+):%d+");
	itemID, randomProp = tonumber(itemID), tonumber(randomProp);
	
	local baseName = GetItemInfo(itemID); -- the item name without the "of the Boar", etc suffix for random property
	if (baseName == nil) then return; end
	local lowerBase = string.lower(baseName);
	
	local existingID = FLT_RandomItemIDs[FLT_Locale][lowerBase];
	if (FLT_BasicItemLinks[FLT_Locale][lowerBase]) then
		-- random-property items never occur without their random properties, so we shouldn't list them as base items
		FLT_BasicItemLinks[FLT_Locale][lowerBase] = nil;
	end
	if (existingID == itemID) then
		-- nothing to see here, move along
	elseif (existingID == nil) then
		FLT_RandomItemIDs[FLT_Locale][lowerBase] = itemID;
		FLT_DebugLog("Added "..GFWUtils.Hilite(baseName).." ("..itemID..") to FLT_RandomItemIDs["..FLT_Locale.."], new base item");
	else
		FLT_RandomItemIDs[FLT_Locale][lowerBase] = itemID;
		FLT_DebugLog(GFWUtils.Red("Duplicate: ").."replaced ("..existingID..") with "..GFWUtils.Hilite(baseName).." ("..itemID..") in FLT_RandomItemIDs["..FLT_Locale.."]");
	end
	
	local searchBase = string.gsub(lowerBase, "([%$%(%)%.%[%]%*%+%-%?%^%%])", "%%%1"); -- convert regex special characters
	local propertyName = string.gsub(name, searchBase, "%%s"); -- format string for just the suffix (or whatever alteration to the name) with token for inserting the base name
	local existingProp = FLT_RandomPropIDs[FLT_Locale][randomProp];
	if (existingProp == propertyName) then
		-- these aren't the droids you're looking for
	elseif (existingProp == nil) then
		FLT_RandomPropIDs[FLT_Locale][randomProp] = propertyName;
		FLT_DebugLog("Added "..GFWUtils.Hilite(propertyName).." ("..randomProp..") to FLT_RandomPropIDs["..FLT_Locale.."], new property name");
	else
		FLT_RandomPropIDs[FLT_Locale][randomProp] = propertyName;
		FLT_DebugLog(GFWUtils.Red("Duplicate: ").."replaced "..GFWUtils.Hilite(existingProp).." with "..GFWUtils.Hilite(propertyName).." ("..randomProp..") in FLT_RandomPropIDs["..FLT_Locale.."]");
	end
	
	local verifiedLink = FLT_GetItemLink(cleanLink);
	if (verifiedLink) then
		if (FLT_RandomItemCombos[FLT_Locale][itemID] == nil) then
			FLT_RandomItemCombos[FLT_Locale][itemID] = {};
		end
		if (GFWTable.KeyOf(FLT_RandomItemCombos[FLT_Locale][itemID], randomProp) == nil) then
			table.insert(FLT_RandomItemCombos[FLT_Locale][itemID], randomProp);
			FLT_DebugLog("Added "..verifiedLink.." ("..cleanLink..") to FLT_RandomItemCombos["..FLT_Locale.."]");
		end
	end
end

function FLT_AddEnchantLink(name, link)
	local _, _, id = string.find(link, "enchant:(%d+)");
	id = tonumber(id);
	if (id == nil) then return; end
	
	local enchantLinkText = FLT_EnchantLink(id);
	local _, _, actualName = string.find(enchantLinkText, "|c%x+|Henchant:%d+|h%[(.-)%]|h|r");
	if (actualName) then
		actualName = string.lower(actualName); -- so we can do case-insensitive lookups
		local existingLink = FLT_EnchantLinks[FLT_Locale][actualName];
		if ( existingLink == id ) then
			return;
		elseif (existingLink == nil) then
			FLT_DebugLog("Adding enchant "..enchantLinkText.."("..id..")");
			FLT_EnchantLinks[FLT_Locale][actualName] = id;
			return link;
		else
			FLT_DebugLog("Replacing existing link ("..existingLink..") with "..enchantLinkText.."("..id..")");
			FLT_EnchantLinks[FLT_Locale][actualName] = id;
			return link;
		end
	end
end

function FLT_InspectSlot(unit, id)
	local link = GetInventoryItemLink(unit, id);
	if ( link ) then
		FLT_ProcessLinks(link);
	end
end

function FLT_Inspect(who)
	local index;
	
	for index = 1, getn(INVENTORY_SLOT_LIST), 1 do
		FLT_InspectSlot(who, INVENTORY_SLOT_LIST[index].id)
	end
end

function FLT_ScanTradeSkill()
	if (not TradeSkillFrame or not TradeSkillFrame:IsVisible() or FLT_TradeSkillLock.Locked) then return; end
	-- This prevents further update events from being handled if we're already processing one.
	-- This is done to prevent the game from freezing under certain conditions.
	FLT_TradeSkillLock.Locked = true;

	local skillLineName, skillLineRank, skillLineMaxRank = GetTradeSkillLine();
	if not (skillLineName) then
		FLT_TradeSkillLock.NeedScan = true;
		return; -- apparently sometimes we're called too early, this is nil, and all hell breaks loose.
	end

	for id = 1, GetNumTradeSkills() do 
		local skillName, skillType, numAvailable, isExpanded = GetTradeSkillInfo(id);
		if ( skillType ~= "header" ) then				
			local itemLink = GetTradeSkillItemLink(id);
			if (itemLink == nil) then
				FLT_TradeSkillLock.NeedScan = true;
			else
				FLT_ProcessLinks(itemLink);
				for i=1, GetTradeSkillNumReagents(id), 1 do
					local link = GetTradeSkillReagentItemLink(id, i);
					if (link == nil) then
						FLT_TradeSkillLock.NeedScan = true;
						break;
					else
						FLT_ProcessLinks(link);
					end
				end
			end
		end
	end

end

function FLT_ScanCraft()
	if (not CraftFrame or not CraftFrame:IsVisible() or FLT_CraftLock.Locked) then return; end
	-- This prevents further update events from being handled if we're already processing one.
	-- This is done to prevent the game from freezing under certain conditions.
	FLT_CraftLock.Locked = true;

	-- This is used only for Enchanting
	local skillLineName, rank, maxRank = GetCraftDisplaySkillLine();
	if not (skillLineName) then
		return; -- Hunters' Beast Training also uses the CraftFrame, but doesn't have a SkillLine.
	end

	for id = GetNumCrafts(), 1, -1 do
		if ( craftType ~= "header" ) then
			local itemLink = GetCraftItemLink(id);
			if (itemLink == nil) then
				FLT_TradeSkillLock.NeedScan = true;
			else
				FLT_ProcessLinks(itemLink);
				
				for i=1, GetCraftNumReagents(id), 1 do
					local link = GetCraftReagentItemLink(id, i);
					if (link == nil) then
						FLT_CraftLock.NeedScan = true;
						break;
					else
						FLT_ProcessLinks(link);
					end
				end
			end
		end
	end
end

function FLT_ScanQuestgiver()
	local link;
	for i = 1, GetNumQuestItems() do
		link = GetQuestItemLink("required", i);
		if (link) then
			FLT_ProcessLinks(link);
		end
	end
	for i = 1, GetNumQuestChoices() do
		link = GetQuestItemLink("choice", i);
		if (link) then
			FLT_ProcessLinks(link);
		end
	end
	for i = 1, GetNumQuestRewards() do
		link = GetQuestItemLink("reward", i);
		if (link) then
			FLT_ProcessLinks(link);
		end
	end
end

function FLT_ScanInventory()
	local bagid, size, slotid, link;
	
	for bagid = 0, 4, 1 do
		size = GetContainerNumSlots(bagid);
		if( size ) then
			for slotid = size, 1, -1 do
				link = GetContainerItemLink(bagid, slotid);
				if( link ) then
					FLT_ProcessLinks(link);
				end
			end
		end
	end
end

function FLT_ScanAuction()
	local numBatchAuctions, totalAuctions = GetNumAuctionItems("list");
	local auctionid, link;

	if( numBatchAuctions > 0 ) then
		for auctionid = 1, numBatchAuctions do
			link = GetAuctionItemLink("list", auctionid);
			if( link ) then
				FLT_ProcessLinks(link);
			end
		end
	end
end

function FLT_ScanBank()
	local index, bagid, size, slotid, link;
	local lBankBagIDs = { BANK_CONTAINER, 5, 6, 7, 8, 9, 10, };
	
	for index, bagid in lBankBagIDs do
		size = GetContainerNumSlots(bagid);
		if( size ) then
			for slotid = size, 1, -1 do
				link = GetContainerItemLink(bagid, slotid);
				if( link ) then
					FLT_ProcessLinks(link);
				end
			end
		end
	end
end

function FLT_LinkifyName(head, text, tail)
	if (head ~= "|h" and tail ~= "|h") then -- only linkify things text that isn't linked already
		local link = FLT_GetLinkByName(text);
		if (link) then return link; end
	end
	return head.."["..text.."]"..tail;
end

function FLT_FindInItemTooltip(text, link)
	LinkeratorTip:ClearLines();
	LinkeratorTip:SetHyperlink(link);
	for lineNum = 1, LinkeratorTip:NumLines() do
		local leftText = getglobal("LinkeratorTipTextLeft"..lineNum):GetText();
		if (leftText and string.find(string.lower(leftText), text, 1, true)) then return true; end
		local rightText = getglobal("LinkeratorTipTextRight"..lineNum):GetText();
		if (rightText and string.find(string.lower(rightText), text, 1, true)) then return true; end
	end
	for lineNum = 1, LinkeratorTip:NumLines() do
		-- for some reason ClearLines alone isn't clearing the right-side text
		getglobal("LinkeratorTipTextLeft"..lineNum):SetText(nil);
		getglobal("LinkeratorTipTextRight"..lineNum):SetText(nil);
	end
end

function FLT_ParseChatMessage(text)
	return string.gsub(text, "([|]?[h]?)%[(.-)%]([|]?[h]?)", FLT_LinkifyName);
end

function FLT_LinkPrefixMatches(text)
	text = string.lower(text) -- for case insensitive lookups
	
	-- build list of known links prefixed with the search string
	local matches = {};
	for name in FLT_BasicItemLinks[FLT_Locale] do
		if (string.sub(name, 1, string.len(text)) == text) then
			table.insert(matches, name);
		end
	end
	-- need to search random-property links too
	for baseName, itemID in FLT_RandomItemIDs[FLT_Locale] do
		if (string.sub(text, 1, string.len(baseName)) == baseName) then
			local observedVariations = FLT_RandomItemCombos[FLT_Locale][itemID];
			if (observedVariations) then
				for _, propID in observedVariations do
					local propName = FLT_RandomPropIDs[FLT_Locale][propID];
					if (propName) then
						--DevTools_Dump({baseName=baseName, propName=propName, itemID=itemID, propID=propID})
						local fullName = string.format(propName, baseName);
						if (string.sub(fullName, 1, string.len(text)) == text) then
							table.insert(matches, fullName);
						end
					end
				end
			end
		elseif (string.sub(baseName, 1, string.len(text)) == text) then
			table.insert(matches, baseName);
		end
	end
	for name in FLT_EnchantLinks[FLT_Locale] do
		if (string.sub(name, 1, string.len(text)) == text) then
			table.insert(matches, name);
		end
	end
	table.sort(matches);
	return matches;
	
end

function FLT_CommonPrefixFromList(list, minLength)
	if (table.getn(list) == 1) then
		return list[1];
	elseif (table.getn(list) == 2) then
		return FLT_CommonPrefix(list[1], list[2]);
	elseif (table.getn(list) > 2) then
		local previousCommon;
		local lastCommon = FLT_CommonPrefix(list[1], list[2]);
		local i = 3;
		while (lastCommon) do
			previousCommon = lastCommon;
			lastCommon = FLT_CommonPrefix(previousCommon, list[i]);
			if (lastCommon and minLength and string.len(lastCommon) <= minLength) then
				break;
			end
			i = i + 1;
		end
		return previousCommon;
	end
end

function FLT_CommonPrefix(strA, strB)
	
	if (strA == nil or strB == nil) then return; end
	
    -- shorter string first
    if (string.len(strA) > string.len(strB)) then
        strA, strB = strB, strA;
    end
    
    for length = string.len(strA), 1, -1 do
        local subA = string.sub(strA, 1, length);
        local subB = string.sub(strB, 1, length);
        if (subA == subB) then
            return subA;
        end
    end    
end

-- substitute for GetItemInfo() for "enchant:0000" style links
-- only way to check validity for those is to actually set a tooltip
function FLT_GetEnchantInfo(id)
    LinkeratorTip:ClearLines();
    LinkeratorTip:SetOwner(UIParent, "ANCHOR_NONE");
    local setHyperlink = LinkeratorTip.SetHyperlink;
    if (pcall(setHyperlink, LinkeratorTip,"enchant:"..id)) then
        return LinkeratorTipTextLeft1:GetText();
    else
        return nil;
    end
end

function FLT_EnchantLink(id, shouldAdd)
	if (tonumber(id) == nil) then
		error("argument #1 to FLT_EnchantLink is not a number", 2);
	end
    local linkFormat = "|cffffffff|Henchant:%s|h[%s]|h|r";
    local name = FLT_GetEnchantInfo(id);
    if (name) then
		if (shouldAdd) then
			FLT_AddEnchantLink(name, "enchant:"..id);
		end
        return string.format(linkFormat, id, name);
    else
        return nil;
    end 
end

function FLT_DebugLog(text)
	if (FLT_Debug) then
		GFWUtils.Print(text, GFW_DEBUG_COLOR.r, GFW_DEBUG_COLOR.g, GFW_DEBUG_COLOR.b);
	end
end
-- Hooks


-- verions
BEH_VERSION = "1.0.7";
-- debug
local BEH_DEBUG = false;
-- text color configuration
local BEH_TEXT_R = 0;
local BEH_TEXT_G = 1;
local BEH_TEXT_B = 1;

local playerName;

-- reference to the tool tip
local toolTip;
-- name of the current shown item
local currentItem;
-- tooltip text
local toolTipText = "";
-- array holding enchants for the current item
local usedBy = {};

local toolTipParts = {
	["needed_reags"] = BEH_STRING_NEEDED,
	["enchants"] = BEH_STRING_ENCHANT,
	["NPCs"] = "NPC's",
	["classes"] = BEH_STRING_CLASSES
};

local BookEnchants_Old_SetItemRef = nil;

function BookEnchants_OnLoad()
	BookEnchants_ChatMessage(string.format("BookEnchants Version %s loaded.", BEH_VERSION));
	
	-- to implement in further development 
	-- this:RegisterEvent("VARIABLES_LOADED");
	
	-- to implement in further development
	-- Slash commands
	-- SLASH_BOOKENCHANTS1 = "/beh";
	-- SlashCmdList["BOOKENCHANTS"] = BookEnchants_SlashHandler;
end

function BookEnchantsToolTip_OnLoad()
	-- nothing to do right now
end

function BookEnchantsToolTip_OnShow()
	-- set toolTip
	toolTip = GameTooltip;
	-- add Intformation
	BookEnchantsToolTip_AddInformation();
end

function BookEnchantsLinkFrame_OnLoad()
	-- nothing to do rught now
	BookEnchants_Old_SetItemRef = SetItemRef; --Chat links
	SetItemRef = BookEnchants_SetItemRef;
end

function BookEnchantsLinkFrame_OnShow()
	-- set toolTip
	toolTip = ItemRefTooltip;
	-- add Intformation
	-- BookEnchantsToolTip_AddInformation();
end

function BookEnchants_SetItemRef(link, text, button)
	BookEnchants_Old_SetItemRef(link, text, button);
	DEBUG_MSG(link);
	-- add Intformation
	local _,pos = string.find(link, ":");
	local type = string.sub(link, 0, pos-1);
	-- react only on items
	if type  == "item" then
		BookEnchantsToolTip_AddInformation();
	end
end

function BookEnchantsToolTip_AddInformation()
	local itemName = BookEnchants_GetItemName();
	if (itemName and itemName ~= " ") then
		currentItem = itemName;
		
		-- Quest-Items
		BookEnchants_AddQuestItemInfo(currentItem);
		
		if (BookEnchants_IsArcanumOrEnchant(currentItem)) then
			foreach(toolTipParts, BookEnchants_AddTooltipLine);
		else
			local usedByString = BookEnchants_ReagUsedBy(currentItem);
			if (usedByString ~= nil) then
				toolTipText = toolTipText..string.format("%s: %s\n", BEH_STRING_NEEDEDFOR, usedByString);
			end
		end
		if (toolTipText ~= "") then
			BookEnchants_AddLine(toolTipText);
		end
		
		toolTip:Show();
	end
	-- reset
	usedBy = {};
	toolTipText = "";
end

function BookEnchants_GetItemName()
	local lbl = getglobal(toolTip:GetName().."TextLeft1");
	if (lbl) then
		return lbl:GetText();
	end
	return;
end

function BookEnchants_GetClassName()
	local lbl = getglobal(toolTip:GetName().."TextLeft3");
	if (lbl) then
		local line = lbl:GetText();
		local sStart, sEnd = string.find(line, " ");
		return string.sub(line, (sStart + 1));
	end
	return;
end

function BookEnchants_AddTooltipLine(k, v)
	local line = BookEnchants_GetItemAdsInfo(currentItem, k);
	if (line ~= nil) then
		toolTipText = toolTipText..string.format("%s: %s\n", v, line);
	end
end

function BookEnchants_AddLine(text)
	toolTip:AddLine(text, BEH_TEXT_R, BEH_TEXT_G, BEH_TEXT_B);
end

function BookEnchants_GetItemAdsInfo(itemName, property)
	-- if data base exists
	if (BOOK_ENCHANTS_ITEMS ~= nil) then 
		
		-- Look for librams within database
		if (BOOK_ENCHANTS_ITEMS[itemName]) then
			-- get the property by name
			local val = BOOK_ENCHANTS_ITEMS[itemName][property];
			if (type(val) == "table") then
				-- if property is a list, concatenate the entries
				local ret = "\n   "..table.concat(val, "\n   ");
				-- check the entries for Arcanum and add the needed reags
				if (property == "needed_reags") then
					for k, v in pairs(val) do 
						if (BookEnchants_IsArcanumOrEnchant(v)) then
							if (BOOK_ENCHANTS_ITEMS[v][property] and type(BOOK_ENCHANTS_ITEMS[v][property]) == "table") then
								ret = ret.."\n      "..table.concat(BOOK_ENCHANTS_ITEMS[v][property], "\n      ");
							end
						end
					end
				end
				return ret;
			else
				-- if property is a string return it
				return val;
			end
		end
		
	end
	return;
end

function BookEnchants_IsArcanumOrEnchant(item)
	if (BOOK_ENCHANTS_ITEMS ~= nil and BOOK_ENCHANTS_ITEMS[item]) then
		return true;
	else
		return false;
	end
end

function BookEnchants_IsQuestItem(item)
	if (BOOK_ENCHANTS_QUESTS ~= nil and BOOK_ENCHANTS_QUESTS[item]) then
		return true;
	else
		return false;
	end
end

function BookEnchants_AddQuestItemInfo(item)
	if (BookEnchants_IsQuestItem(item)) then
		BookEnchants_AddLine(BEH_STRING_QUESTITEM..": "..table.concat(BOOK_ENCHANTS_QUESTS[item], ", "));
	end
end

function BookEnchants_ReagUsedBy(item)
	
	if (BOOK_ENCHANTS_ITEMS ~= nil) then
		table.foreach(BOOK_ENCHANTS_ITEMS, BookEnchants_ReagUsedByEnchant)
		
		if (table.getn(usedBy) > 0) then
			if (table.getn(usedBy) == 1) then
				return BookEnchants_GetCompleteEnchantTT(usedBy[1]);
			else
				return "\n   "..table.concat(usedBy, "\n   ");
			end
		end
		
	end
	return;
end

function BookEnchants_ReagUsedByEnchant(enchant, val)
	if (BOOK_ENCHANTS_ITEMS[enchant]["needed_reags"]) then
		for j, reag in ipairs(BOOK_ENCHANTS_ITEMS[enchant]["needed_reags"]) do
			if (type(reag) == "string" and (reag == currentItem or string.sub(reag, 4) == currentItem)) then
				-- handle Voodoo Doll
				if (reag == BEH_ITEM_DOLL) then
					local cls = BookEnchants_GetClassName();
					if cls then
						if (BOOK_ENCHANTS_ITEMS[enchant]["classes"] == cls) then
							table.insert(usedBy, enchant);
							break;
						end
					end
				else
					table.insert(usedBy, enchant);
					break;
				end
			end
		end
	end
end

function BookEnchants_GetCompleteEnchantTT(enchant)
	-- save current item
	local currentItemSave = currentItem;
	-- change current Item
	currentItem = enchant;
	-- add Enchant Text
	toolTipText = toolTipText..string.format("%s: %s\n", BEH_STRING_NEEDEDFOR, enchant);
	-- get tooltip for new item
	foreach(toolTipParts, BookEnchants_AddTooltipLine);
	-- restore currentItem
	currentItem = currentItemSave;
	return nil;
end

function BookEnchants_GetEnchantToolTipEntries(item)
	return "";
end

function BookEnchants_GetReagToolTipEntries(item)
	return ""
end

function BookEnchants_ConcatString(tbl)
	local ret = "";
	
	for index,value in ipairs(tbl) do 
		if value ~= nil then
			ret = ret.."\n   "..value;
		end
	end
	
	return ret;
end

function BookEnchants_ChatMessage(msg)
	if (msg ~= nil) then
		ChatFrame1:AddMessage(msg, 0,1,1);
	end
end

function DEBUG_MSG(msg)
	if (BEH_DEBUG) then
		if (msg ~= nil) then
			ChatFrame1:AddMessage("BEH: "..msg, 1.0, 1.0, 0.5);
		else
			ChatFrame1:AddMessage("BEH: Value is nil", 1.0, 1.0, 0.5);
		end
	end
end

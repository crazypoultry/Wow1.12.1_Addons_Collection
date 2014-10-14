--[[

	InventoryOnPar : An Inventory addon that shows when you have outgrown your equipment
		copyright 2006 by Pericles

]]

--[[

v0.01 - Initial release

v0.02 - Added /iop version
		Fixed problem with loading of polearms

v0.03 - Fixed problem with loading of thrown weapons

v0.04 - Now shows empty slots in white

v0.10 - Now uses a graphical window to display data

v0.11 - Fixed issue with no Helm giving colour error

v0.20 - Added a button on character inventory screen to open On Par
        Added description field for slots
        Left justified text

v0.21 - Tidied up no longer needed local vars
        Added localization

v0.22 - Changed Item Level routine to take player level and return colour as well as item level

v0.30 - Changed Item Level to account for items with multiple levels

V1.00 - Added Item Level to game tooltip - still need to work out "Required Level" text from item tooltip

v1.10 - now works with chat text tooltip and lootlink tooltips

v1.20 - now also works with EquipCompare comparison tooltips

v1.21 - deals with items that contain " of ..." e.g., "of the boar" and looks up the shortened name instead

v1.30 - deals with items that have multiple levels by reading "Required Level" text from item tooltip after
		v1.21 they were always showing as -3, -5 etc thus always grey.

v1.40 - shows item ITEM_RARITY in brackets after item name

v1.41 - fix bug for lootlink

v1.50 - updated for patch 1.10

v1.51 - fix for missing Item Levels on main tooltip post patch 1.10

v2.00 - added new items content from patch 1.10 includes librams, idols, totems & dungeon sets

v2.01 - fixed item levels of multi level items

v2.02 - added InventoryOnPar Score and Titan Panel display (initial testing version)

v2.03 - modified window textbox to larger size - fixed crash if an empty slot

v2.10 - fixed bugs in TitanButton version ready for public release

v2.20 - added scans of other players

v2.30 - added average itemLevel for players with good kit above lvl 60, added help to the /iop command line and changed the default behaviour to show help, added a fix to try to hide window when character window closes

v3.00 - added UI screen to view captured player data

v3.10 - added Options Editor

v3.20 - added weighted score calculation

v3.30 - replaced name lookups with itemID lookups, enlarged result window

v3.31 - fixed item level zero or 1 (all level items) from dragging down score

v3.40 - added raid and party options to scan all players in a raid/party
	 added level tooltip to atlasloot tooltip
	 fixed sorting options, fixed colours in table, added back in the option to scan or not to scan others

v3.41 - added in data for Librams, Totems and Idols

v3.50 - the view list now shows the kit of a player when you click on their name
	    empty slots that cannot be filled at your level now score zero instead of -level

v3.51 - fixed bug with two-handed weapons

v3.52 - fixed bug with localisations not having weights

v3.53 - added german localisations - thanks to fuersthoelle for the translations

v3.54 - updated toc to patch 1.12

v3.55 - added fix for error on 316 when itemRarity is nil, also moved rarity strings to localisation.lua
           added german localisation for two handed items - thanks to fuersthoelle for the translations
	 changed min levels for empty slots as values in v3.54 seemed too low in actual playtesting giving large negative scores
	 fixed a problem if you started a character on a new realm (name nil line 316 error)
		
v3.60 - added extra items introduced in patch 1.12 and 1.12.1
--]]

local INVENTORYONPAR_VERSION = 3.60;

--------------------------------------------------------------------------------------------------
-- Local variables
--------------------------------------------------------------------------------------------------

MAX_LEVEL = 60;

colourRed    = "ffff0000";	-- red = 5 lvls above char lvl or better
colourOrange = "ffff8000";	-- orange = 2 to 4 lvls above char lvl
colourYellow = "ffffff00";	-- yellow = 1 lvl below to 1 lvl above char lvl
colourGreen  = "ff1eff00";	-- green = 2 to 4 lvls below char lvl
colourGrey   = "ff9d9d9d";	-- gray = 5 lvls below char lvl or worse
colourBlue   = "ff20d0ff";	-- unknown, light blue
colourWhite  = "ffffffff";	-- slot empty - white

colourDarkBlue = "ff0070dd"; -- item ITEM_RARITY dark blue
colourPurple = "ffa335ee";   -- item ITEM_RARITY purple
colourGold   = "ffffd700";   -- item ITEM_RARITY gold

ITEM_RARITY = {};
ITEM_RARITY[7]={ name=IOP_UNKNOWN, colour=colourBlue };
ITEM_RARITY[0]={ name=IOP_POOR, colour=colourGrey };
ITEM_RARITY[1]={ name=IOP_COMMON, colour=colourWhite };
ITEM_RARITY[2]={ name=IOP_UNCOMMON, colour=colourGreen };
ITEM_RARITY[3]={ name=IOP_RARE, colour=colourDarkBlue };
ITEM_RARITY[4]={ name=IOP_EPIC, colour=colourPurple };
ITEM_RARITY[5]={ name=IOP_LEGENDARY, colour=colourOrange };
ITEM_RARITY[6]={ name=IOP_ARTIFACT, colour=colourGold };

--------------------------------------------------------------------------------------------------
-- Create empty main tables
--------------------------------------------------------------------------------------------------

ITEMS_DB = {};
NAME_ITEMS_DB = {};

--------------------------------------------------------------------------------------------------
-- Event functions
--------------------------------------------------------------------------------------------------

function InventoryOnPar_Initialise()
	IOP_ThisRealm = GetRealmName();
	if (IOP.Data == nil) then
		IOP.Data = {};
		IOP.Data.lastUpdated = time();
		if(IOP.Data.version == nil or IOP.Data.version ~= 3) then
			IOP.Data[IOP_ThisRealm] = {}; -- If not weighted version calc then zap all prior history
		end
	end
	if(IOP.Data[IOP_ThisRealm]== nil) then
		IOP.Data[IOP_ThisRealm] = {};
	end
	-- Register our slash command
	SlashCmdList["INVENTORYONPAR"] = function(msg)
		InventoryOnPar_SlashCommandHandler(msg);
	end
	SLASH_INVENTORYONPAR1 = "/iop";

	if(DEFAULT_CHAT_FRAME) then
		DEFAULT_CHAT_FRAME:AddMessage("\nPericles's InventoryOnPar AddOn v"..INVENTORYONPAR_VERSION.." loaded");
	end
	InventoryOnParOption.InitializeOptions();
	IOP_HookTooltips();
	InventoryOnParFrame:Hide();
	IOP_ReloadTables();
end

function InventoryOnPar_OnLoad()
	-- setup data block
	if (IOP == nil) then
		IOP = {};
		IOP.Options = {};
		IOP.Data = {};
	end
	IOP_ReloadTables();
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("PLAYER_TARGET_CHANGED");
end

function InventoryOnPar_OnEvent()
	if (event == "VARIABLES_LOADED") then
		InventoryOnPar_Initialise();
	elseif (event == "PLAYER_TARGET_CHANGED") then
		IOP.currentTarget = nil;
		if (IOP.Options.scanPlayers == 1) then
			if (UnitExists("target") and UnitIsPlayer("target") and UnitCanCooperate("player", "target")) then
				if (CheckInteractDistance("target", 1)) then
					IOP_RequestTargetScore("target", nil);
				end
			end
		end
	end
end

function InventoryOnPar_OnHide()
	getglobal("InventoryOnParFrame"):Hide();
end
--------------------------------------------------------------------------------------------------
-- Other Player functions
--------------------------------------------------------------------------------------------------

function IOP_RequestTargetScore(unit, override)
	if (UnitExists(unit) and UnitIsPlayer(unit) and UnitCanCooperate("player", unit)) then
		if (UnitLevel(unit) >= IOP.Options.minLevel and UnitLevel(unit) <= IOP.Options.maxLevel) then
			local playerName = UnitName(unit);
			if (override or IOP_DoesPlayerNeedUpdate(playerName)) then
				IOP.currentTarget = {};
				IOP.currentTarget.realmName = GetRealmName();
				IOP.currentTarget.playerName = playerName;
				IOP.currentTarget.playerLevel = UnitLevel(unit);
				IOP.currentTarget.class = UnitClass(unit);
				IOP.currentTarget.guild = GetGuildInfo(unit);
				IOP.currentTarget.tooltipText, IOP.currentTarget.IOP_Score = IOP_GetItemLevels(unit);
				IOP.currentTarget.recordedTime = time();
				NotifyInspect(unit);
				IOP_AddPlayerRecord(IOP.currentTarget);
				IOP.Data.lastUpdated = time();
				DEFAULT_CHAT_FRAME:AddMessage("InventoryOnPar captured Par Score of "..format("%.2f", IOP.currentTarget.IOP_Score).." for "..IOP.currentTarget.playerName);
			end
		end
	end
end

function IOP_DoesPlayerNeedUpdate(playerName)
	local playerInfo = IOP_GetPlayerRecord(playerName);
	local needsUpdate = false;

	if (playerInfo ~= nil) then
		local currentTime = time();
		if (currentTime - playerInfo.recordedTime > IOP.Options.minutesTilUpdate * 60) then
			needsUpdate = true;
		end
	else
		needsUpdate = true;
	end

	return needsUpdate;
end

function IOP_GetPlayerRecord(playerName)
	-- will return player record
	if (playerName == nil) then
		return nil;
	end
	local IOP_ThisRealm = GetRealmName();
	return IOP.Data[IOP_ThisRealm][playerName];
end

function IOP_AddPlayerRecord(playerRecord)
	-- will check if player exists if not adds player to array.
	if (playerRecord ~= nil) then
		local IOP_ThisRealm = GetRealmName();
		if(IOP.Data[IOP_ThisRealm][playerRecord.playerName] == nil) then
			IOP.Data[IOP_ThisRealm][playerRecord.playerName] = {};
		end
		IOP.Data[IOP_ThisRealm][playerRecord.playerName] = playerRecord;
		IOP.Data.lastUpdated = time();
	end
end

function IOP_AddCurrentPlayer()
	IOP.currentTarget = {};
	IOP.currentTarget.realmName = GetRealmName();
	IOP.currentTarget.playerName = UnitName("player");
	IOP.currentTarget.playerLevel = UnitLevel("player");
	IOP.currentTarget.class = UnitClass("player");
	IOP.currentTarget.tooltipText, IOP.currentTarget.IOP_Score = IOP_GetItemLevels("player");
	IOP.currentTarget.recordedTime = time();
	IOP_AddPlayerRecord(IOP.currentTarget);
	IOP_UI_tableIndexLastUpdated = time();
end

function IOP_GetPlayers()
	local IOP_ThisRealm = GetRealmName();
	return IOP.Data[IOP_ThisRealm];
end

function IOP_HasUpdates(atime)
	if (atime and IOP.Data.lastUpdated) then
		if (atime > IOP.Data.lastUpdated) then
			return true;
		end
	end
	return nil;
end

--------------------------------------------------------------------------------------------------
-- API functions
--------------------------------------------------------------------------------------------------

function IOP_GetItemLevels(unitName)
	iopTotal = 0;
	unitLevel = UnitLevel(unitName);
	if (unitLevel == MAX_LEVEL and unitName == "player") then
		-- scanning player character and player has his level cap so use his average item level to determine the colour scheme
		unitLevel = IOP_GetAverageItemLevel();
		if (unitLevel < MAX_LEVEL) then
			unitLevel = MAX_LEVEL; -- force level back if players kit is beneath his level which is the MAX_LEVEL
		end
	end
	textstring="|c"..colourWhite.."Inventory Status : (Player Level : "..unitLevel..")\n";
	iopTwoHanded = "false";
	for index = 1, getn(INVENTORY_SLOT_LIST), 1 do
		INVENTORY_SLOT_LIST[index].id = GetInventorySlotInfo(INVENTORY_SLOT_LIST[index].name);
		local slotLink = GetInventoryItemLink(unitName, INVENTORY_SLOT_LIST[index].id);
		if (slotLink ~= nil) then
			local _, _, itemCode = strfind(slotLink, "(%d+):");
			local itemName, _, itemRarity, itemMinLevel, itemType, itemSubType = GetItemInfo(itemCode);
			if (itemName == nil) then
				itemName = "unknown";
			end
			if (itemRarity == nil) then
				itemRarity = 0;
			end
			if (itemCode) then
				local itemLevel, levelColour = IOP_GetItemLevel(itemCode, unitLevel, itemMinLevel);
				textstring=textstring.."\n|c"..levelColour..INVENTORY_SLOT_LIST[index].desc.." - |c"..levelColour.." lvl:"..itemLevel.." - "..itemName;
				if(ITEM_RARITY[itemRarity].name) then
					textstring=textstring.."  |c"..ITEM_RARITY[itemRarity].colour.."["..ITEM_RARITY[itemRarity].name.."]";
				end
				local levelOK = IOP_CheckLevel(itemLevel);
				if(levelOK) then
					local itemScore = itemLevel - UnitLevel(unitName);
					if(itemRarity>2) then  -- we have a rare or better item so add a bonus
						itemScore = itemScore + 5 * (itemRarity - 2);
					end
					if(itemSubType== IOP_TH_MACE or itemSubType == IOP_TH_SWORD or itemSubType == IOP_TH_AXE or itemSubType == IOP_STAVES or itemSubType == IOP_POLEARMS) then
						-- compensate for two handed weapon by doubling score
						itemScore = itemScore * 2;
						iopTwoHanded = "true";
					end
					iopValue = itemScore  * INVENTORY_SLOT_LIST[index].weight * 1.5; -- 1.5 reweights values to similar score to before
					iopTotal = iopTotal + iopValue;
					textstring=textstring.."  ("..format("%.2f", iopValue)..")";
				end
			else
				textstring=textstring.."\n|c"..colourWhite..INVENTORY_SLOT_LIST[index].desc.." - |c"..colourWhite.." Not Found";
			end
		else
			textstring=textstring.."\n|c"..colourWhite..INVENTORY_SLOT_LIST[index].desc.." - |c"..colourWhite.." Slot Empty";
			if(INVENTORY_SLOT_LIST[index].name == "SecondaryHandSlot" and iopTwoHanded == "true") then
				-- make no adjustment if using two handed weapon
				iopValue = 0;
			elseif(IOP_TooLowLevel(index, UnitLevel(unitName), UnitClass(unitName))) then
				iopValue = 0;
			else
				iopValue = - UnitLevel(unitName) * INVENTORY_SLOT_LIST[index].weight * 1.5;
				iopTotal = iopTotal + iopValue;
			end
			textstring=textstring.."  ("..format("%.2f", iopValue)..")";
		end
	end
	textstring = textstring.."\n\n|c"..colourWhite.."Inventory On Par Score : "..format("%.2f", iopTotal);
	return textstring, iopTotal;
end

function IOP_CheckLevel(itemLevel)
	if (itemLevel == "not found") then
		return nil;
	elseif (type(itemLevel) == "number") then
		if(itemLevel == 0 or itemLevel == 1) then
			return nil;
		end
	elseif (type(itemLevel) == "string") then
		if(itemLevel =="0" or itemLevel == "1") then
			return nil;
		end
	end
	return "itemok";
end

function IOP_TooLowLevel(index, unitLevel, unitClass)
	--DEFAULT_CHAT_FRAME:AddMessage("Checking slot "..INVENTORY_SLOT_LIST[index].name.." class :"..unitClass.." level :"..unitLevel);
	if (unitLevel == MAX_LEVEL) then
		return nil; -- this unit is max level no reason for empty slot
	end
	if (INVENTORY_SLOT_LIST[index].name == "RangedSlot" and unitLevel < 55) then
		-- paladins, shamans & druids need to be level 52 to use Libram, Totem or Idol - give them to lvl 55 to get something before penalty
		if(unitClass == "Paladin" or unitClass == "Shaman" or unitClass == "Druid") then
			return 1;
		elseif(unitLevel < 10) then
			if (unitClass == "Mage" or unitClass == "Priest" or unitClass == "Warlock") then
				return 1; -- min wand level is 7 give them to level 10 to get something
			else
				return nil; -- no reason for under lvl 7 other class to have this slot empty
			end
		else
			return nil; -- no reason for level >=7 to have this slot empty
		end
	end
	if (INVENTORY_SLOT_LIST[index].name == "SecondaryHandSlot" and unitLevel <5) then
		if (unitClass == "Warrior" or unitClass == "Paladin" or unitClass == "Shaman") then
			return nil; -- no reason for these classes to have no shield
		else
			return 1; -- other classes must be level 5+ to use off-hand item
		end
	end
	if (INVENTORY_SLOT_LIST[index].minLevel > unitLevel) then
		return 1; -- item slot is higher than unit level so they cant use slot
	else
		return nil; -- default no reason for slot to be empty
	end
end

function IOP_GetAverageItemLevel()
	local totalLevels = 0;
	local itemCount = 0;
	for index = 1, getn(INVENTORY_SLOT_LIST), 1 do
		INVENTORY_SLOT_LIST[index].id = GetInventorySlotInfo(INVENTORY_SLOT_LIST[index].name);
		local slotLink = GetInventoryItemLink("player", INVENTORY_SLOT_LIST[index].id);
		if (slotLink ~= nil) then
			local _, _, itemCode = strfind(slotLink, "(%d+):");
			local itemName, _, itemRarity, itemMinLevel, _, itemType, itemSubType = GetItemInfo(itemCode);
			local itemLevel = IOP_GetItemLevel(itemCode, unitLevel, itemMinLevel);
			if(itemLevel ~= "not found" and itemLevel ~= 0) then
				totalLevels = totalLevels + itemLevel;
				itemCount = itemCount +1;
			end
		end
	end
	if (itemCount > 0) then
		return math.floor(totalLevels / itemCount);
	else
		return 0;
	end
end

function IOP_ShowItemLevels()
	InventoryOnParText:SetJustifyH("LEFT");
	InventoryOnParText:SetJustifyV("MIDDLE");
	InventoryOnParText:SetText(IOP_GetItemLevels("player"));
	InventoryOnParFrame:Show();
end

function IOP_ShowPlayerData()
	local IOP_ThisRealm = GetRealmName();
	if(IOP.Data[IOP_ThisRealm] ~= nil) then
		for index, player in IOP.Data[IOP_ThisRealm] do
			DEFAULT_CHAT_FRAME:AddMessage(player.playerName.." a lvl "..player.playerLevel.." "..player.class.." on "..date(IOP.Options.dateFormat, player.recordedTime).." had par of : "..player.IOP_Score);
		end
	else
		DEFAULT_CHAT_FRAME:AddMessage("No data recorded for "..IOP_ThisRealm.." realm yet.");
	end
end

function IOP_ScanMembers(partyType)
	local numberInParty = 0;
	if(partyType=="party") then
		numberInParty = GetNumPartyMembers();
	elseif(partyType=="raid") then
		numberInParty = GetNumRaidMembers();
	end
	if (numberInParty==0) then
		DEFAULT_CHAT_FRAME:AddMessage("[IOP Scan] Error you are not in a "..partyType,1,0,0);
	else
		for i=1, numberInParty, 1 do
			if (CheckInteractDistance(partyType..i, 1)) then
				IOP_RequestTargetScore(partyType..i, 1);
			else
				DEFAULT_CHAT_FRAME:AddMessage(UnitName(partyType..i).." is out of inspect range.");
			end
		end
	end
end

function IOP_DebugItemIDs()
	for index = 1, getn(INVENTORY_SLOT_LIST), 1 do
		INVENTORY_SLOT_LIST[index].id = GetInventorySlotInfo(INVENTORY_SLOT_LIST[index].name);
		local slotLink = GetInventoryItemLink("player", INVENTORY_SLOT_LIST[index].id);
		if (slotLink ~= nil) then
			local _, _, itemCode = strfind(slotLink, "(%d+):");
			local itemName, _, itemRarity, itemMinLevel, _, itemType, itemSubType = GetItemInfo(itemCode);
			DEFAULT_CHAT_FRAME:AddMessage(INVENTORY_SLOT_LIST[index].name.." - "..itemCode.." : "..itemName);
		end
	end
end

function IOP_ReloadTables()
	if(not ITEMS_DB["2374"]) then
		IOP_LoadNumericData();
	end
	if(not NAME_ITEMS_DB["Libram of Divinity"]) then
		IOP_LoadStringData();
	end
end

--------------------------------------------------------------------------------------------------
-- Handler functions
--------------------------------------------------------------------------------------------------

function InventoryOnPar_SlashCommandHandler(msg)
	if(msg == "version") then
		DEFAULT_CHAT_FRAME:AddMessage("InventoryOnPar Version : "..INVENTORYONPAR_VERSION);
	elseif(msg == "show") then
		ShowUIPanel(InventoryOnParUIFrame);
	elseif(msg == "data") then
		IOP_ShowItemLevels();
	elseif(msg == "options") then
		ShowUIPanel(InventoryOnParOptionFrame)
	elseif(msg == "debug") then
		IOP_DebugItemIDs();
	elseif(msg == "raid") then
		IOP_ScanMembers("raid");
	elseif(msg == "party") then
		IOP_ScanMembers("party");
	elseif(msg == "reload") then
		IOP_ReloadTables();
	else
		DEFAULT_CHAT_FRAME:AddMessage("InventoryOnPar Commands");
		DEFAULT_CHAT_FRAME:AddMessage("/iop version - shows version information");
		DEFAULT_CHAT_FRAME:AddMessage("/iop show - displays other player data collected");
		DEFAULT_CHAT_FRAME:AddMessage("/iop data - displays current character data");
		DEFAULT_CHAT_FRAME:AddMessage("/iop options - displays options setup panel");
		DEFAULT_CHAT_FRAME:AddMessage("/iop party - scans all party members in inspect range");
		DEFAULT_CHAT_FRAME:AddMessage("/iop raid - scans all raid members in inspect range");
	end
end

function IOP_HookTooltips()
	-- hook the item tooltip
	IOP_GameTooltip_Orig = GameTooltip:GetScript("OnShow");
	GameTooltip:SetScript("OnShow", IOP_GameTooltip_OnShow);
	IOP_ItemRefTooltip_Orig = ItemRefTooltip:GetScript("OnShow");
	ItemRefTooltip:SetScript("OnShow", IOP_ItemRefTooltip_OnShow);
	if (LootLinkTooltip) then
		IOP_LootLinkTooltip_Orig = LootLinkTooltip:GetScript("OnShow");
		LootLinkTooltip:SetScript("OnShow", IOP_LootLinkTooltip_OnShow);
	end
	-- now check if EquipCompare Comparison tooltips loaded
	if (ComparisonTooltip1) then
		IOP_ComparisonTooltip1_Orig = ComparisonTooltip1:GetScript("OnShow");
		ComparisonTooltip1:SetScript("OnShow", IOP_ComparisonTooltip1_OnShow);
	end
	if (ComparisonTooltip2) then
		IOP_ComparisonTooltip2_Orig = ComparisonTooltip2:GetScript("OnShow");
		ComparisonTooltip2:SetScript("OnShow", IOP_ComparisonTooltip2_OnShow);
	end
	if (AtlasLootTooltip) then
		IOP_AtlasLootTooltip_Orig = AtlasLootTooltip:GetScript("OnShow");
		AtlasLootTooltip:SetScript("OnShow", IOP_AtlasLootTooltip_OnShow);
	end
end


function IOP_GameTooltip_OnShow()
	-- call original event for GameTooltip:OnShow()
	if IOP_GameTooltip_Orig then
		IOP_GameTooltip_Orig(event)
	end

	-- add Item Level info to tooltip if the tooltip has at least 1 line
	local IOP_tooltip = getglobal("GameTooltipTextLeft1");
	if (IOP_tooltip) then
		local reqLevel = IOP_GetReqLevel("GameTooltip");
		local itemLevel, levelColour = IOP_GetItemLevelByName(IOP_tooltip:GetText(), UnitLevel("player"), reqLevel);
		if (levelColour ~= colourBlue) then
			-- suppress tooltip line if unknown
			GameTooltip:AddLine("|c"..levelColour.."Item Level : "..itemLevel);
			GameTooltip:Show()
		end
	else
		DEFAULT_CHAT_FRAME:AddMessage("|c00bfffff hmm it is null");
	end
end

function IOP_ItemRefTooltip_OnShow()
	-- call original event for ItemRefTooltip:OnShow()
	if IOP_ItemRefTooltip_Orig then
		IOP_ItemRefTooltip_Orig(event)
	end

	-- add Item Level info to tooltip if the tooltip has at least 1 line
	local IOP_tooltip = getglobal("ItemRefTooltipTextLeft1");
	if (IOP_tooltip) then
		local reqLevel = IOP_GetReqLevel("ItemRefTooltip");
		local itemLevel, levelColour = IOP_GetItemLevelByName(IOP_tooltip:GetText(), UnitLevel("player"), reqLevel);
		if (levelColour ~= colourBlue) then
			-- suppress tooltip line if unknown
			ItemRefTooltip:AddLine("|c"..levelColour.."Item Level : "..itemLevel);
			ItemRefTooltip:Show()
		end
	end
end

function IOP_LootLinkTooltip_OnShow()
	-- call original event for LootLinkTooltip:OnShow()
	if IOP_LootLinkTooltip_Orig then
		IOP_LootLinkTooltip_Orig(event)
	end

	-- add Item Level info to tooltip if the tooltip has at least 1 line
	local IOP_tooltip = getglobal("LootLinkTooltipTextLeft1");
	if (IOP_tooltip) then
		local reqLevel = IOP_GetReqLevel("LootLinkTooltip");
		local itemLevel, levelColour = IOP_GetItemLevelByName(IOP_tooltip:GetText(), UnitLevel("player"), reqLevel);
		if (levelColour ~= colourBlue) then
			-- suppress tooltip line if unknown
			LootLinkTooltip:AddLine("|c"..levelColour.."Item Level : "..itemLevel);
			LootLinkTooltip:Show()
		end
	end
end

function IOP_ComparisonTooltip1_OnShow()
	-- call original event for ComparisonTooltip1TextLeft1:OnShow()
	if IOP_ComparisonTooltip1_Orig then
		IOP_ComparisonTooltip1_Orig(event)
	end

	-- add Item Level info to tooltip if the tooltip has at least 1 line
	local IOP_tooltip = getglobal("ComparisonTooltip1TextLeft1");
	if (IOP_tooltip) then
		local reqLevel = IOP_GetReqLevel("ComparisonTooltip1");
		local itemLevel, levelColour = IOP_GetItemLevelByName(IOP_tooltip:GetText(), UnitLevel("player"), reqLevel);
		if (levelColour ~= colourBlue) then
			-- suppress tooltip line if unknown
			ComparisonTooltip1:AddLine("|c"..levelColour.."Item Level : "..itemLevel);
			ComparisonTooltip1:Show()
		end
	end
end

function IOP_ComparisonTooltip2_OnShow()
	-- call original event for ComparisonTooltip1TextLeft2:OnShow()
	if IOP_ComparisonTooltip2_Orig then
		IOP_ComparisonTooltip2_Orig(event)
	end

	-- add Item Level info to tooltip if the tooltip has at least 1 line
	local IOP_tooltip = getglobal("ComparisonTooltip2TextLeft1");
	if (IOP_tooltip) then
		local reqLevel = IOP_GetReqLevel("ComparisonTooltip2");
		local itemLevel, levelColour = IOP_GetItemLevelByName(IOP_tooltip:GetText(), UnitLevel("player"), reqLevel);
		if (levelColour ~= colourBlue) then
			-- suppress tooltip line if unknown
			ComparisonTooltip2:AddLine("|c"..levelColour.."Item Level : "..itemLevel);
			ComparisonTooltip2:Show()
		end
	end
end

function IOP_AtlasLootTooltip_OnShow()
	-- call original event for ComparisonTooltip1TextLeft2:OnShow()
	if IOP_AtlasLootTooltip_Orig then
		IOP_AtlasLootTooltip_Orig(event)
	end

	-- add Item Level info to tooltip if the tooltip has at least 1 line
	local IOP_tooltip = getglobal("AtlasLootTooltipTextLeft1");
	if (IOP_tooltip) then
		local reqLevel = IOP_GetReqLevel("AtlasLootTooltip");
		local itemLevel, levelColour = IOP_GetItemLevelByName(IOP_tooltip:GetText(), UnitLevel("player"), reqLevel);
		if (levelColour ~= colourBlue) then
			-- suppress tooltip line if unknown
			AtlasLootTooltip:AddLine("|c"..levelColour.."Item Level : "..itemLevel);
			AtlasLootTooltip:Show()
		end
	end
end


function xIOP_ShowTooltip()
	-- add Item Level info to tooltip if the tooltip has at least 1 line
	local IOP_tooltip = getglobal(this:GetName().."TextLeft1");
	if (IOP_tooltip) then
		local reqLevel = IOP_GetReqLevel(this:GetName());
		local itemLevel, levelColour = IOP_GetItemLevelByName(IOP_tooltip:GetText(), UnitLevel("player"), reqLevel);
		if (levelColour ~= colourBlue) then
			-- suppress tooltip line if unknown
			this:AddLine("|c"..levelColour.."Item Level : "..itemLevel);
			this:Show()
		end
	else
		DEFAULT_CHAT_FRAME:AddMessage("|c00bfffff hmm it is null");
	end
end

function xIOP_Tooltip_OnShow()          ----------------Possible Generic Call - Test it
	local IOP_Tooltip = getglobal("IOP_"..this:GetName().."_Orig");
	if (IOP_Tooltip) then
		IOP_Tooltip(event)
	end
	IOP_ShowTooltip();
end

function xIOP_GameTooltip_OnShow()
	-- call original event for GameTooltip:OnShow()
	if IOP_GameTooltip_Orig then
		IOP_GameTooltip_Orig(event)
	end
	IOP_ShowTooltip();
end

function xIOP_ItemRefTooltip_OnShow()
	-- call original event for ItemRefTooltip:OnShow()
	if IOP_ItemRefTooltip_Orig then
		IOP_ItemRefTooltip_Orig(event)
	end
	IOP_ShowTooltip();
end

function xIOP_LootLinkTooltip_OnShow()
	-- call original event for LootLinkTooltip:OnShow()
	if IOP_LootLinkTooltip_Orig then
		IOP_LootLinkTooltip_Orig(event)
	end
	IOP_ShowTooltip();
end

function xIOP_ComparisonTooltip1_OnShow()
	-- call original event for ComparisonTooltip1TextLeft1:OnShow()
	if IOP_ComparisonTooltip1_Orig then
		IOP_ComparisonTooltip1_Orig(event)
	end
	IOP_ShowTooltip();
end

function xIOP_ComparisonTooltip2_OnShow()
	-- call original event for ComparisonTooltip1TextLeft2:OnShow()
	if IOP_ComparisonTooltip2_Orig then
		IOP_ComparisonTooltip2_Orig(event)
	end
	IOP_ShowTooltip();
end

--------------------------------------------------------------------------------------------------
-- Main functions
--------------------------------------------------------------------------------------------------

function IOP_GetReqLevel(fieldname)
	local iStart, iEnd, value;
	for index = 2, 30 do
		field = getglobal(fieldname.."TextLeft"..index);
		if(field and field:IsVisible()) then
			linetext = field:GetText();
			if (linetext) then
				iStart, iEnd, value = string.find(linetext, "Requires Level (%d+)");
				if (value) then
					return value;
				end
			end
		end
	end
	return 0;
end

function IOP_GetItemLevelByName(itemName, playerLevel, itemMinLevel)
	if (itemName) then
		local item = NAME_ITEMS_DB[itemName];
		local first, last = string.find(itemName, " of ");
		if (not item and first) then
			local shortName = string.sub(itemName, 1, first - 1);
			item = NAME_ITEMS_DB[shortName];
		end
		if (item) then
			if (item.level == "(multiple)") then
				return item.level, colourBlue;
			else
				local level, colour = IOP_GetLevelColour(item.level, playerLevel);
				return level, colour;
			end
		else
			return "not found", colourBlue;
		end
	end
end

function IOP_GetItemLevel(itemCode, playerLevel, itemMinLevel)
	if (itemCode) then
		itemCode = itemCode.."";
		local item = ITEMS_DB[itemCode];
		if (item) then
			local level, colour = IOP_GetLevelColour(item.level, playerLevel);
			return level, colour;
		end
	end
	return "not found", colourBlue;
end

function IOP_GetLevelColour(itemLevel, playerLevel)
	local levelDiff = 0;
	local colour = colourWhite;
	if (itemLevel == nil) then
		return 0, colourWhite;
	end
	if (itemLevel == "0" or itemLevel == "-1") then
		return 0, colourWhite;
	end
	levelDiff = itemLevel - playerLevel;
	if (levelDiff >= 5) then
		colour = colourRed;
	end
	if (levelDiff <= 4 and levelDiff >=2) then
		colour = colourOrange;
	end
	if (levelDiff <= 1 and levelDiff >=-1) then
		colour = colourYellow;
	end
	if (levelDiff <= -2 and levelDiff >=-4) then
		colour = colourGreen;
	end
	if (levelDiff <= -5) then
		colour = colourGrey;
	end
	return itemLevel, colour;
end
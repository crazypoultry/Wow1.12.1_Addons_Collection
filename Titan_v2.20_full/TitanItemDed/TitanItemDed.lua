TITAN_ITEMDED_ID = "ItemDed";
TITAN_ITEMDED_AUCTIONEERADDONNAME = "Auctioneer";

--TPID_debug = true;

-- Vars that really need to be made into saved preferences
local TPID_DropThreshold = 3; 		-- Number of free bag slots to maintain
local TPID_RoundWithin = 10; 			-- Round to full stack if within this many items of having a full stack

-- Local variables
local TPID_safetodrop = false;
local TPID_dropnum = 0;
local TPID_indrop = false;
local TPID_ignored = {};
local TPID_ignoredRD = {};
local TPID_autodropRD = {};
local TPID_ItemList = {}; 
local TPID_player = GetCVar("RealmName").. UnitName("player");
local TPID_Color = {};

local function GexHex(r)
	return string.format("|cFF%02X%02X%02X", (255*r.r), (255*r.g), (255*r.b))
end

for i,value in ITEM_QUALITY_COLORS do
	TPID_Color[i] = {GexHex(ITEM_QUALITY_COLORS[i]), getglobal("ITEM_QUALITY".. i.. "_DESC")}
end

function TitanItemDed_OnLoad()
	this.registry = { 
		id = TITAN_ITEMDED_ID,
		menuText = TITAN_ITEMDED_MENU_TEXT, 
		buttonTextFunction = "TitanPanelItemDedButton_GetButtonText", 
		tooltipTitle = TITAN_ITEMDED_TOOLTIP_TITLE,
		tooltipTextFunction = "TitanPanelItemDedButton_GetTooltipText", 
		icon = "",	
		iconWidth = 16,
		savedVariables = {
			ShowIcon = 1,
			ShowIcon2 = 1,
			ShowLabelText = 1,
			ShowChatFeedback = 1,
			ShowTTHelp = 1,
			IgnoreFaire = 1,
			RoundStacks = 1,
			RoundOnlyIfFullStack = 1,
		}
	};
	
	this:RegisterEvent("VARIABLES_LOADED");
	
	if (TitanItemDed_OverridePrices) then
		for itemid,val in TitanItemDed_OverridePrices do
			if (not TitanItemDed_itemsbyid[itemid]) then TitanItemDed_itemsbyid[itemid] = {} end
			TitanItemDed_itemsbyid[itemid].s = val;
			TitanItemDed_itemsbyid[itemid].isusr = true;
		end
	end
end

function TitanPanelItemDedButton_UpdateIcon()
	TitanItemDed_Debug("TitanPanelItemDedButton_UpdateIcon");
	TitanItemDed_MakeList();
	local iconon = TitanGetVar(TITAN_ITEMDED_ID, "ShowIcon");
	local iconon2 = TitanGetVar(TITAN_ITEMDED_ID, "ShowIcon2");
	
	local button = TitanUtils_GetButton(TITAN_ITEMDED_ID, true);
	
	if (TPID_ItemList[1]) then
		button.registry.icon = TPID_ItemList[1].tex;
		if (iconon2) then 
			TitanItemDed_Debug("Icon shown");
			if (not iconon) then TitanToggleVar(TITAN_ITEMDED_ID, "ShowIcon"); end
		else 
			TitanItemDed_Debug("Icon hidden");
			if (iconon) then TitanToggleVar(TITAN_ITEMDED_ID, "ShowIcon"); end
		end
	else
		button.registry.icon = "";
		if (iconon) then TitanToggleVar(TITAN_ITEMDED_ID, "ShowIcon"); end
	end
	
	TitanPanelButton_UpdateButton(TITAN_ITEMDED_ID);
end

function TitanPanelItemDedButton_GetButtonText(id)
	local entry = TPID_ItemList[1];
	local numempty = TitanItemDed_GetEmpties();
	local itemtext;
	local numtxt = string.format(TITAN_ITEMDED_BUTTON_EMPTIES, numempty);

	if (entry) then
		local ad = "";
		if (TitanItemDed_IsAutodroppable(entry)) then ad = "*"; end

		local stack = "";
		if ((entry.totstack == entry.stack) and (entry.totstack ~= 1)) then stack = TITAN_ITEMDED_TOOLTIP_STACK;
		elseif (entry.numstacks > 1) then 
			stack = string.format(TITAN_ITEMDED_TOOLTIP_STACKS, entry.numstacks, TitanItemDed_GetTextGSC(entry.price * entry.numstacks));
		elseif (entry.totstack > 1) then 
			stack = string.format(TITAN_ITEMDED_BUTTON_STACK, entry.stack); 
			if (entry.rounded) then stack = stack.. "^"; end
		end
		
		local bind = entry.bound;
		if (bind) then bind = string.format(TITAN_ITEMDED_TOOLTIP_BIND, bind);
		else bind = ""; end

		itemtext = string.format(TITAN_ITEMDED_BUTTON_ITEM, ad, entry.link, bind, stack);
	else
		itemtext = TITAN_ITEMDED_BUTTON_NOITEM;
	end
		
	if (numempty < TPID_DropThreshold) then
		numtxt = TitanUtils_GetRedText(numtxt);
	else
		numtxt = TitanUtils_GetNormalText(numtxt);
	end
	
	return itemtext, numtxt;
end

function TitanPanelItemDedButton_GetTooltipText()
	local retstr = "";
	local totsum = 0;
	
	if (TitanGetVar(TITAN_ITEMDED_ID, "ShowTTHelp")) then retstr = TITAN_ITEMDED_TOOLTIP_BAGS; end
	
	if (TPID_ItemList[1]) then
		if (TitanGetVar(TITAN_ITEMDED_ID, "ShowTTHelp")) then
			if (MerchantFrame:IsVisible()) then
				retstr = retstr.. TITAN_ITEMDED_TOOLTIP_SELL;
				retstr = retstr.. TITAN_ITEMDED_TOOLTIP_IGNORE;		
			else
				retstr = retstr.. TITAN_ITEMDED_TOOLTIP_DESTROY;
				retstr = retstr.. TITAN_ITEMDED_TOOLTIP_IGNORE;
			end
		end
		
		retstr = retstr.. "\n";
		for i,entry in TPID_ItemList do
			local stack = "";
			if ((entry.totstack == entry.stack) and (entry.totstack ~= 1) and (entry.numstacks == 1)) then stack = TITAN_ITEMDED_TOOLTIP_STACK;
			elseif (entry.numstacks > 1) then 
				stack = string.format(TITAN_ITEMDED_TOOLTIP_STACKS, entry.numstacks, TitanItemDed_GetTextGSC(entry.price * entry.numstacks));
			elseif (entry.totstack > 1) then 
				stack = string.format(TITAN_ITEMDED_TOOLTIP_PARTSTACK, entry.stack, entry.totstack); 
				if (entry.rounded) then stack = stack.. "^"; end
			end
			
			local bind = entry.bound;
			if (bind) then bind = string.format(TITAN_ITEMDED_TOOLTIP_BIND, bind);
			else bind = ""; end

			local ad = "";
			if (TitanItemDed_IsAutodroppable(entry)) then ad = "*"; end
			
			local debugdetails = "";
			if (TPID_debug) then debugdetails = entry.sortprice.. " " end
			
			local aucstr = TITAN_ITEMDED_TOOLTIP_ISVEN;
			if (entry.isauc) then aucstr = TITAN_ITEMDED_TOOLTIP_ISAUC; 
			elseif (entry.isusr) then aucstr = TITAN_ITEMDED_TOOLTIP_ISUSR; end
			
			retstr = retstr.. string.format(TITAN_ITEMDED_TOOLTIP_ITEM, ad, debugdetails, entry.link, bind, stack, TitanItemDed_GetTextGSC(entry.price), aucstr);
			totsum = totsum + entry.price * entry.numstacks
		end
		retstr = retstr.. string.format(TITAN_ITEMDED_TOOLTIP_TOTALVALUE, TitanItemDed_GetTextGSC(totsum));
	else
		retstr = retstr.. TITAN_ITEMDED_NOITEMDESTROY;
	end
	
	return retstr;	
end

function TitanItemDed_Auctioneer_Event_FinishedAuctionScan()
	TitanItemDed_ScanAuctioneerData();
	TitanItemDed_Old_Auctioneer_Event_FinishedAuctionScan();
end

function TitanItemDed_OnEvent()
	if ((event == "ADDON_LOADED") and (arg1 == TITAN_ITEMDED_AUCTIONEERADDONNAME)) then
		--Hook AH scan complete
		TitanItemDed_Old_Auctioneer_Event_FinishedAuctionScan = Auctioneer_Event_FinishedAuctionScan;
		Auctioneer_Event_FinishedAuctionScan = TitanItemDed_Auctioneer_Event_FinishedAuctionScan;
		
		TitanItemDed_ScanAuctioneerData();
	end
	if (event == "VARIABLES_LOADED") then
		TitanItemDed_Debug("VARIABLES_LOADED");
		this:RegisterEvent("ADDON_LOADED");
		this:RegisterEvent("BAG_UPDATE");
		this:RegisterEvent("MERCHANT_SHOW");
		this:RegisterEvent("LOOT_OPENED");
		this:RegisterEvent("LOOT_CLOSED");
		this:RegisterEvent("LOOT_SLOT_CLEARED");
		TitanItemDed_Init();
	end
	if (event == "BAG_UPDATE") then
		TitanItemDed_Debug("BAG_UPDATE");
		if (not TitanItemDed_AutoDrop()) then
			TitanPanelItemDedButton_UpdateIcon();
		end
	end
	if ((event == "LOOT_OPENED") or (event == "LOOT_CLOSED") or (event == "LOOT_SLOT_CLEARED")) then
		TitanItemDed_Debug(event);
		TitanItemDed_Debug("Safe to drop");
		TPID_safetodrop = true;
	end
end

function TitanItemDed_AutoDrop()
	if (not TPID_UseAutodrop) then return false end;
	TitanItemDed_Debug("TitanItemDed_AutoDrop");
	
	if (TPID_indrop) then
		if (TPID_dropnum == TitanItemDed_GetEmpties()) then 
			TitanItemDed_Debug("Still dropping");
			return true;
		else
			TPID_indrop = false; 
		end
	end

	
	TitanItemDed_MakeList();
	if (TPID_DropThreshold > TitanItemDed_GetEmpties() and TPID_safetodrop and (not TPID_indrop)) then
		TitanItemDed_Debug("Empty: ".. TitanItemDed_GetEmpties().. " Threshold: ".. TPID_DropThreshold );
		if(TPID_ItemList[1]) then
			TitanItemDed_Debug("Quality: ".. TPID_ItemList[1].qual.. " ".. TPID_ItemList[1].fullname);
			if (TitanItemDed_IsAutodroppable(TPID_ItemList[1])) then
				TitanItemDed_Debug("Dropping Item");
				TPID_indrop = true;
				TPID_dropnum = TitanItemDed_GetEmpties();
				TitanItemDed_TrashItem();
				if (TPID_DropThreshold <= TitanItemDed_GetEmpties()) then
					TPID_safetodrop = false;
					TitanItemDed_Debug("Not safe to drop again");
				end
				return true;
			else
				DEFAULT_CHAT_FRAME:AddMessage(TITAN_ITEMDED_CHAT_CANNOTDROP);
				TitanPanelItemDedButton_UpdateIcon();
			end
		end
	end
	TitanItemDed_Debug("Not safe to drop");
	TPID_safetodrop = false;
end

function TitanPanelRightClickMenu_PrepareItemDedMenu(level)
	if (level == 1) then TitanItemDed_MenuBase() end
	if (level == 2) then TitanItemDed_MenuSubmenu() end

end
	
function TitanItemDed_MenuBase()
	local info;
	
	TitanPanelRightClickMenu_AddTitle(TitanPlugins[TITAN_ITEMDED_ID].menuText);
	TitanPanelRightClickMenu_AddSpacer();		

	if (TPID_ItemList[1]) then 
		if (MerchantFrame:IsVisible() and (not IsAddOnLoaded("Sell-O-Matic"))) then 
			info = {};
			info.text = TITAN_ITEMDED_MENU_SELLALLJUNK;
			info.func = TitanItemDed_SellJunk;
				UIDropDownMenu_AddButton(info);
		end

		info = {};
		if (MerchantFrame:IsVisible()) then info.text = "Sell Item";
		else info.text = TITAN_ITEMDED_MENU_DROPTHISITEM; end
		info.func = TitanItemDed_TrashItem;
		UIDropDownMenu_AddButton(info);
	
		TitanPanelRightClickMenu_AddSpacer();		

		info = {};
		info.text = TITAN_ITEMDED_MENU_IGNORETHISITEM;
		info.value = TPID_ItemList[1];
		info.func = TitanItemDed_IgnoreItem;
		UIDropDownMenu_AddButton(info);

		info = {};
		info.text = TITAN_ITEMDED_MENU_ALWAYSIGNORETHISITEM;
		info.value = TPID_ItemList[1];
		info.func = TitanItemDed_IgnoreAlwaysItem;
		UIDropDownMenu_AddButton(info);
	
		info = {};
		info.text = TITAN_ITEMDED_MENU_AUTODROPTHISITEM;
		info.value = TPID_ItemList[1].name;
		info.func = TitanItemDed_ToggleAutodropItem;
		UIDropDownMenu_AddButton(info);

		info = {};
		info.text = TITAN_ITEMDED_MENU_USEAUCTHISITEM;
		info.value = TPID_ItemList[1].name;
		info.value = {TPID_ItemList[1].id, TPID_ItemList[1].link};
		info.func = TitanItemDed_ToggleAuctioneerItem;
		info.checked = (TitanItemDedAuctioneerVals[TPID_ItemList[1].id] ~= nil);
		UIDropDownMenu_AddButton(info);
	
		TitanPanelRightClickMenu_AddSpacer();		

		info = {};
		info.text = TITAN_ITEMDED_MENU_IGNOREITEM;
		info.value = TITAN_ITEMDED_MENU_IGNOREITEM;
		info.hasArrow = 1;
		UIDropDownMenu_AddButton(info);

		info = {};
		info.text = TITAN_ITEMDED_MENU_ALWAYSIGNOREITEM;
		info.value = TITAN_ITEMDED_MENU_ALWAYSIGNOREITEM;
		info.hasArrow = 1;
		UIDropDownMenu_AddButton(info);
	
		info = {};
		info.text = TITAN_ITEMDED_MENU_AUTODROPITEM;
		info.value = TITAN_ITEMDED_MENU_AUTODROPITEM;
		info.hasArrow = 1;
		UIDropDownMenu_AddButton(info);

		info = {};
		info.text = TITAN_ITEMDED_MENU_USEAUCPRICE;
		info.value = TITAN_ITEMDED_MENU_USEAUCPRICE;
		info.hasArrow = 1;
		UIDropDownMenu_AddButton(info);

		TitanPanelRightClickMenu_AddSpacer();		
	end

	info = {};
	info.text = TITAN_ITEMDED_MENU_IGNORESET;
	info.value = TITAN_ITEMDED_MENU_IGNORESET;
	info.hasArrow = 1;
	UIDropDownMenu_AddButton(info);

	info = {};
	info.text = TITAN_ITEMDED_MENU_AUTODROPSET;
	info.value = TITAN_ITEMDED_MENU_AUTODROPSET;
	info.hasArrow = 1;
	UIDropDownMenu_AddButton(info);

	info = {};
	info.text = TITAN_ITEMDED_MENU_RESET;
	info.value = TITAN_ITEMDED_MENU_RESET;
	info.hasArrow = 1;
	UIDropDownMenu_AddButton(info);

	TitanPanelRightClickMenu_AddSpacer();		

	info = {};
	info.text = TITAN_ITEMDED_MENU_THRESHOLD;
	info.value = TITAN_ITEMDED_MENU_THRESHOLD;
	info.hasArrow = 1;
	UIDropDownMenu_AddButton(info);
	
	info = {};
	info.text = TITAN_ITEMDED_MENU_OPTIONS;
	info.value = TITAN_ITEMDED_MENU_OPTIONS;
	info.hasArrow = 1;
	UIDropDownMenu_AddButton(info);
end

function TitanItemDed_MenuSubmenu()
	local info;
	local cat = UIDROPDOWNMENU_MENU_VALUE;
	local level = 2;
	
	if (cat == TITAN_ITEMDED_MENU_THRESHOLD) then
		TitanPanelRightClickMenu_AddTitle(TITAN_ITEMDED_MENU_THRESHOLD, level);
		TitanPanelRightClickMenu_AddSpacer(level);		
	
		local i;
		for i=0,table.getn(TPID_Color) do
			info = {};
			info.text = TPID_Color[i][1].. TPID_Color[i][2];
			info.value = i;
			info.func = TitanItemDed_SetThreshold;
			info.checked = (i == TitanItemDedSettings[TPID_player].Threshold);
			UIDropDownMenu_AddButton(info, level);
		end
	end
	if (cat == TITAN_ITEMDED_MENU_IGNORESET) then		
		TitanPanelRightClickMenu_AddTitle(TITAN_ITEMDED_MENU_IGNORESET, level);
		
		for i,val in TITAN_ITEMDED_CLASSES do
			local color = "";
			if (TitanItemDedSettings[TPID_player].AutodropSets[val]) then
				color = "|cffff8000"
			end
			info = {};
			info.text = color.. val;
			info.value = val;
			info.keepShownOnClick = 1;
			info.func = TitanItemDed_ToggleIgnoreSet;
			info.checked = (TitanItemDedSettings[TPID_player].IgnoredSets[val]);
			UIDropDownMenu_AddButton(info, level);
		end
		
		info = {};
		info.text = TITAN_ITEMDED_MENU_DMFAIRESET;
		info.func = TitanItemDed_Toggle;
		info.value = "IgnoreFaire";
		info.keepShownOnClick = 1;
		info.checked = TitanGetVar(TITAN_ITEMDED_ID, "IgnoreFaire");
		UIDropDownMenu_AddButton(info, level);
		
		if (ReagentData) then
			local prof = {};
			local gath = {};
			for i,name in ReagentData['professions'] do
				table.insert(prof, name);
			end
			for i,name in ReagentData['gathering'] do
				table.insert(gath, name);
			end
			table.sort(prof, function(a,b) return a < b end);
			table.sort(gath, function(a,b) return a < b end);
			
			TitanPanelRightClickMenu_AddSpacer(level);
			for i,val in TITAN_ITEMDED_RDCLASSES do
				local color = "";
				if (TitanItemDedSettings[TPID_player].AutodropRDSets[val[2]]) then
					color = "|cffff8000"
				end
				info = {};
				info.text = color.. val[1];
				info.value = val[2];
				info.keepShownOnClick = 1;
				info.func = TitanItemDed_ToggleIgnoreRDSet;
				info.checked = (TitanItemDedSettings[TPID_player].IgnoredRDSets[val[2]]);
				UIDropDownMenu_AddButton(info, level);			
			end	
			TitanPanelRightClickMenu_AddSpacer(level);
			for i,name in prof do
				local profname = ReagentData['reverseprofessions'][name];
				local color = "";
				if (TitanItemDedSettings[TPID_player].AutodropRDSets[profname]) then
					color = "|cffff8000"
				end
				info = {};
				info.text = color.. name;
				info.value = profname;
				info.keepShownOnClick = 1;
				info.func = TitanItemDed_ToggleIgnoreRDSet;
				info.checked = (TitanItemDedSettings[TPID_player].IgnoredRDSets[profname]);
				UIDropDownMenu_AddButton(info, level);
			end
			TitanPanelRightClickMenu_AddSpacer(level);
			for i,name in gath do
				local gathname = ReagentData['reversegathering'][name];
				local color = "";
				if (TitanItemDedSettings[TPID_player].AutodropRDSets[gathname]) then
					color = "|cffff8000"
				end
				info = {};
				info.text = color.. name;
				info.value = gathname;
				info.keepShownOnClick = 1;
				info.func = TitanItemDed_ToggleIgnoreRDSet;
				info.checked = (TitanItemDedSettings[TPID_player].IgnoredRDSets[gathname]);
				UIDropDownMenu_AddButton(info, level);
			end
		end
	end
	if (cat == TITAN_ITEMDED_MENU_AUTODROPSET) then		
		TitanPanelRightClickMenu_AddTitle(TITAN_ITEMDED_MENU_AUTODROPSET, level);
		
		for i,val in TITAN_ITEMDED_CLASSES do
			local color = "";
			if (TitanItemDedSettings[TPID_player].IgnoredSets[val]) then
				color = "|cff9d9d9d"
			end
			info = {};
			info.text = color.. val;
			info.value = val;
			info.keepShownOnClick = 1;
			info.func = TitanItemDed_ToggleAutodropSet;
			info.checked = (TitanItemDedSettings[TPID_player].AutodropSets[val]);
			UIDropDownMenu_AddButton(info, level);
		end
		
		if (ReagentData) then
			local prof = {};
			local gath = {};
			for i,name in ReagentData['professions'] do
				table.insert(prof, name);
			end
			for i,name in ReagentData['gathering'] do
				table.insert(gath, name);
			end
			table.sort(prof, function(a,b) return a < b end);
			table.sort(gath, function(a,b) return a < b end);
			
			TitanPanelRightClickMenu_AddSpacer(level);
			for i,val in TITAN_ITEMDED_RDCLASSES do
				local color = "";
				if (TitanItemDedSettings[TPID_player].IgnoredRDSets[val[2]]) then
					color = "|cff9d9d9d"
				end
				info = {};
				info.text = color.. val[1];
				info.value = val[2];
				info.keepShownOnClick = 1;
				info.func = TitanItemDed_ToggleAutodropRDSet;
				info.checked = (TitanItemDedSettings[TPID_player].AutodropRDSets[val[2]]);
				UIDropDownMenu_AddButton(info, level);			
			end	
			TitanPanelRightClickMenu_AddSpacer(level);
			for i,name in prof do
				local profname = ReagentData['reverseprofessions'][name];
				local color = "";
				if (TitanItemDedSettings[TPID_player].IgnoredRDSets[profname]) then
					color = "|cff9d9d9d"
				end
				info = {};
				info.text = color.. name;
				info.value = profname;
				info.keepShownOnClick = 1;
				info.func = TitanItemDed_ToggleAutodropRDSet;
				info.checked = (TitanItemDedSettings[TPID_player].AutodropRDSets[profname]);
				UIDropDownMenu_AddButton(info, level);
			end
			TitanPanelRightClickMenu_AddSpacer(level);
			for i,name in gath do
				local gathname = ReagentData['reversegathering'][name];
				local color = "";
				if (TitanItemDedSettings[TPID_player].IgnoredRDSets[gathname]) then
					color = "|cff9d9d9d"
				end
				info = {};
				info.text = color.. name;
				info.keepShownOnClick = 1;
				info.value = gathname;
				info.func = TitanItemDed_ToggleAutodropRDSet;
				info.checked = (TitanItemDedSettings[TPID_player].AutodropRDSets[gathname]);
				UIDropDownMenu_AddButton(info, level);
			end
		end
	end
	if (cat == TITAN_ITEMDED_MENU_USEAUCPRICE) then		
		TitanPanelRightClickMenu_AddTitle(TITAN_ITEMDED_MENU_USEAUCPRICE, level);
		TitanPanelRightClickMenu_AddSpacer(level);		
		
		local lastname = "";
		local condlist = {};
		for i,val in TPID_ItemList do
			if (lastname ~= val.name) then
				table.insert(condlist, val);
			end
			lastname = val.name
		end

		for i,val in condlist do
			if (val.qual > 0) then
				info = {};
				info.keepShownOnClick = 1;
				info.text = val.link;
				info.value = {val.id, val.link};
				info.func = TitanItemDed_ToggleAuctioneerItem;
				info.checked = (TitanItemDedAuctioneerVals[val.id] ~= nil);
				UIDropDownMenu_AddButton(info, level);
			end
		end
	end
	if (cat == TITAN_ITEMDED_MENU_AUTODROPITEM) then		
		TitanPanelRightClickMenu_AddTitle(TITAN_ITEMDED_MENU_AUTODROPITEM, level);
		TitanPanelRightClickMenu_AddSpacer(level);		
		
		local lastname = "";
		local condlist = {};
		for i,val in TPID_ItemList do
			if (lastname ~= val.name) then
				table.insert(condlist, val);
			end
			lastname = val.name
		end

		for i,val in condlist do
			if (val.qual > 0) then
				info = {};
				info.keepShownOnClick = 1;
				info.text = val.link;
				info.value = val.name;
				info.func = TitanItemDed_ToggleAutodropItem;
				info.checked = (TitanItemDedSettings[TPID_player].Autodropable[val.name]);
				UIDropDownMenu_AddButton(info, level);
			end
		end
	end
	if (cat == TITAN_ITEMDED_MENU_IGNOREITEM) then		
		TitanPanelRightClickMenu_AddTitle(TITAN_ITEMDED_MENU_IGNOREITEM, level);
		TitanPanelRightClickMenu_AddSpacer(level);		
		
		local lastname = "";
		local condlist = {};
		for i,val in TPID_ItemList do
			if (lastname ~= val.name) then
				table.insert(condlist, val)
			end
			lastname = val.name
		end

		for i,val in condlist do
			if (val.qual > 0) then
				info = {};
				info.text = val.link;
				info.value = val;
				info.keepShownOnClick = 1;
				info.func = TitanItemDed_IgnoreItem;
				UIDropDownMenu_AddButton(info, level);
			end
		end
	end
	if (cat == TITAN_ITEMDED_MENU_ALWAYSIGNOREITEM) then		
		TitanPanelRightClickMenu_AddTitle(TITAN_ITEMDED_MENU_ALWAYSIGNOREITEM, level);
		TitanPanelRightClickMenu_AddSpacer(level);		
		
		local lastname = "";
		local condlist = {};
		for i,val in TPID_ItemList do
			if (lastname ~= val.name) then
				table.insert(condlist, val)
			end
			lastname = val.name
		end

		for i,val in condlist do
			if (val.qual > 0) then
				info = {};
				info.text = val.link;
				info.value = val;
				info.keepShownOnClick = 1;
				info.func = TitanItemDed_IgnoreAlwaysItem;
				UIDropDownMenu_AddButton(info, level);
			end
		end
	end
	if (cat == TITAN_ITEMDED_MENU_RESET) then
		TitanPanelRightClickMenu_AddTitle(TITAN_ITEMDED_MENU_RESET, level);
		TitanPanelRightClickMenu_AddSpacer(level);		
	
		info = {};
		info.text = TITAN_ITEMDED_MENU_IGNORED;
		info.value = "r";
		info.func = TitanItemDed_Listman;
		UIDropDownMenu_AddButton(info, level);
	
		info = {};
		info.text = TITAN_ITEMDED_MENU_ALWAYSIGNORED;
		info.value = "ra";
		info.func = TitanItemDed_Listman;
		UIDropDownMenu_AddButton(info, level);
	
		info = {};
		info.text = TITAN_ITEMDED_MENU_AUTODROP;
		info.value = "rad";
		info.func = TitanItemDed_Listman;
		UIDropDownMenu_AddButton(info, level);
	end
	
	if (cat == TITAN_ITEMDED_MENU_OPTIONS) then
		info = {};
		info.text = string.format(TITAN_ITEMDED_MENU_AUTODROPITEMS, TPID_DropThreshold);
		info.func = TitanItemDed_ToggleAutodrop;
		info.checked = TPID_UseAutodrop;
		info.keepShownOnClick = 1;
		UIDropDownMenu_AddButton(info, level);
	
		info = {};
		info.text = string.format(TITAN_ITEMDED_MENU_ROUND, TPID_RoundWithin);
		info.value = "RoundStacks";
		info.func = TitanItemDed_Toggle;
		info.keepShownOnClick = 1;
		info.checked = TitanGetVar(TITAN_ITEMDED_ID, "RoundStacks");
		UIDropDownMenu_AddButton(info, level);

		info = {};
		info.text = TITAN_ITEMDED_MENU_ROUNDSTACK;
		info.func = TitanItemDed_Toggle;
		info.value = "RoundOnlyIfFullStack";
		info.keepShownOnClick = 1;
		info.checked = TitanGetVar(TITAN_ITEMDED_ID, "RoundOnlyIfFullStack");
		UIDropDownMenu_AddButton(info, level);

		TitanPanelRightClickMenu_AddSpacer(level);		

		info = {};
		info.text = TITAN_ITEMDED_MENU_CHATFEEDBACK;
		info.func = TitanItemDed_Toggle;
		info.value = "ShowChatFeedback";
		info.keepShownOnClick = 1;
		info.checked = TitanGetVar(TITAN_ITEMDED_ID, "ShowChatFeedback");
		UIDropDownMenu_AddButton(info, level);
	
		info = {};
		info.text = TITAN_ITEMDED_MENU_SHOWTTHELP;
		info.func = TitanItemDed_Toggle;
		info.value = "ShowTTHelp";
		info.keepShownOnClick = 1;
		info.checked = TitanGetVar(TITAN_ITEMDED_ID, "ShowTTHelp");
		UIDropDownMenu_AddButton(info, level);
	
		TitanPanelRightClickMenu_AddSpacer(level);		

		info = {};
		info.text = TITAN_PANEL_MENU_SHOW_ICON;
		info.value = "ShowIcon2";
		info.func = TitanItemDed_Toggle;
		info.checked = TitanGetVar(TITAN_ITEMDED_ID, "ShowIcon2");
		info.keepShownOnClick = 1;
		UIDropDownMenu_AddButton(info, level);

		info = {};
		info.text = TITAN_PANEL_MENU_SHOW_LABEL_TEXT;
		info.value = {TITAN_ITEMDED_ID, "ShowLabelText", nil};
		info.func = TitanPanelRightClickMenu_ToggleVar;
		info.keepShownOnClick = 1;
		info.keepShownOnClick = 1;
		info.checked = TitanGetVar(TITAN_ITEMDED_ID, "ShowLabelText");
		UIDropDownMenu_AddButton(info, level);
	
		TitanPanelRightClickMenu_AddSpacer(level);		
		TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, TITAN_ITEMDED_ID, TITAN_PANEL_MENU_FUNC_HIDE, level);
	end	
end

function TitanItemDed_ToggleIgnoreSet()
	local set = this.value;
	
	if (TitanItemDedSettings[TPID_player].IgnoredSets[set]) then
		TitanItemDedSettings[TPID_player].IgnoredSets[set] = nil;
	else
		TitanItemDedSettings[TPID_player].IgnoredSets[set] = true;
		TitanItemDedSettings[TPID_player].AutodropSets[set] = nil;
	end
	TPID_safetodrop = true;
	TitanItemDed_AutoDrop();
	TitanPanelItemDedButton_UpdateIcon();
end

function TitanItemDed_ToggleIgnoreRDSet()
	local set = this.value;
	
	if (TitanItemDedSettings[TPID_player].IgnoredRDSets[set]) then
		TitanItemDedSettings[TPID_player].IgnoredRDSets[set] = nil;
	else
		TitanItemDedSettings[TPID_player].IgnoredRDSets[set] = true;
		TitanItemDedSettings[TPID_player].AutodropRDSets[set] = nil;
	end
	TitanItemDed_BuildRDIgnoreSet();
	TitanItemDed_BuildAutodropRDSet();
	TPID_safetodrop = true;
	TitanItemDed_AutoDrop();
	TitanPanelItemDedButton_UpdateIcon();
end

function TitanItemDed_BuildRDIgnoreSet()
	TPID_ignoredRD = {};
	for set,val in TitanItemDedSettings[TPID_player].IgnoredRDSets do
		if (set) then
			local temparr = ReagentData_GetItemClass(set);
			if (temparr) then
				for idx,name in temparr do
					if (idx) then TPID_ignoredRD[name] = true; end
				end
			end
		end
	end
end

function TitanItemDed_ToggleAutodropRDSet()
	local set = this.value;
	
	if (TitanItemDedSettings[TPID_player].AutodropRDSets[set]) then
		TitanItemDedSettings[TPID_player].AutodropRDSets[set] = nil;
	else
		TitanItemDedSettings[TPID_player].AutodropRDSets[set] = true;
		TitanItemDedSettings[TPID_player].IgnoredRDSets[set] = nil;
	end
	TitanItemDed_BuildRDIgnoreSet();
	TitanItemDed_BuildAutodropRDSet();
	TPID_safetodrop = true;
	TitanItemDed_AutoDrop();
	TitanPanelItemDedButton_UpdateIcon();
end

function TitanItemDed_BuildAutodropRDSet()
	TPID_autodropRD = {};
	for set,val in TitanItemDedSettings[TPID_player].AutodropRDSets do
		if (set) then
			local temparr = ReagentData_GetItemClass(set);
			if (temparr) then
				for idx,name in temparr do
					if (idx) then TPID_autodropRD[name] = true; end
				end
			end
		end
	end
end


function TitanItemDed_ToggleAuctioneerItem()
	local item = this.value;
	
	if (TitanItemDedAuctioneerVals[item[1]]) then
		TitanItemDedAuctioneerVals[item[1]] = nil;
		TitanItemDed_itemsbyid[item[1]].s = TitanItemDed_itemsbyid[item[1]].oprice;
		TitanItemDed_itemsbyid[item[1]].isauc = nil; 
	else
		TitanItemDedAuctioneerVals[item[1]] = {item[2], nil};
	end
	TitanItemDed_ScanAuctioneerData();
end

function TitanItemDed_ToggleAutodropItem()
	local item = this.value;
	
	if (TitanItemDedSettings[TPID_player].Autodropable[item]) then
		TitanItemDedSettings[TPID_player].Autodropable[item] = nil;
	else
		TitanItemDedSettings[TPID_player].Autodropable[item] = true;
	end
	TPID_safetodrop = true;
	TitanItemDed_AutoDrop();
	TitanPanelItemDedButton_UpdateIcon();
end

function TitanItemDed_ToggleAutodropSet()
	local set = this.value;
	
	if (TitanItemDedSettings[TPID_player].AutodropSets[set]) then
		TitanItemDedSettings[TPID_player].AutodropSets[set] = nil;
	else
		TitanItemDedSettings[TPID_player].AutodropSets[set] = true;
		TitanItemDedSettings[TPID_player].IgnoredSets[set] = nil;
	end
	TPID_safetodrop = true;
	TitanItemDed_AutoDrop();
	TitanPanelItemDedButton_UpdateIcon();
end

function TitanItemDed_OnClick(button)
	if (button == "LeftButton") then
		if(IsShiftKeyDown()) then
			TitanItemDed_TrashItem();
		else
			OpenAllBags();
		end
	end
end

function TitanItemDed_OnDoubleClick(button)
	if (button == "LeftButton") then
		if(IsAltKeyDown()) then
			TitanItemDed_IgnoreAlwaysItem();
		else
			TitanItemDed_IgnoreItem();
		end
	end
end

function TitanItemDed_SetThreshold()
	TitanItemDedSettings[TPID_player].Threshold = this.value;

	local str = TPID_Color[this.value][1].. TPID_Color[this.value][2];
	TitanItemDed_Chatback(string.format(TITAN_ITEMDED_CHAT_THRESHOLDSET, str));

	TitanPanelItemDedButton_UpdateIcon();
end

function TitanItemDed_Chatback(str)
	if (TitanGetVar(TITAN_ITEMDED_ID, "ShowChatFeedback")) then
		DEFAULT_CHAT_FRAME:AddMessage(string.format(TITAN_ITEMDED_CHAT_HEADER, str));
	end
end

function TitanItemDed_Debug(str)
	if (TPID_debug) then
		ChatFrame5:AddMessage("|cffff00ff<ItemDed> ".. str);
	end
end

function TitanItemDed_MakeList()
	TitanItemDed_Debug("TitanItemDed_MakeList");
	
	TPID_ItemList2 = {};
	local hasfullstack = {};
	
	for bag=0,NUM_BAG_FRAMES do
		for slot=1,GetContainerNumSlots(bag) do
		  local price, item_name, itemid, sName, sLink, iQuality, iLevel, sType, sSubType, iCount;
      local itemlink = GetContainerItemLink(bag, slot);
      local item_texture, stackCount = GetContainerItemInfo(bag, slot);
		
		  if itemlink then
				_, _, itemid, _, _, _, item_name = string.find(itemlink, "|Hitem:(%d+):(%d+):(%d+):(%d+)|h[[]([^]]+)[]]|h");
				itemid = tonumber(itemid);
		  end
		  
      if (itemid) then sName, sLink, iQuality, iLevel, sType, sSubType, iCount = GetItemInfo(itemid); end
			
		  if (sName and stackCount) then
		  	TitanItemDed_Debug(sName.. " ".. stackCount);
		  	if (TitanItemDed_itemsbyid[itemid]) then
		  		price = TitanItemDed_itemsbyid[itemid].s;
				end

				if (price) then
					TitanItemDed_Debug(price)
					if TitanItemDed_IsDroppable(item_name, itemid, bag, slot) then
						local round = nil;
						
						local n = {};
						if (TitanGetVar(TITAN_ITEMDED_ID, "RoundStacks") and ((iCount - stackCount - 1) < TPID_RoundWithin)) then
							n.sortprice = price*iCount + stackCount/1000;
							round = true;
						end
						if (not n.sortprice) then n.sortprice = price*stackCount; end
						
						if ((iCount == stackCount) and (iCount > 1)) then hasfullstack[item_name] = true; end

						if (TitanItemDed_itemsbyid[itemid].c == TITAN_ITEMDED_CLASSES[3]) then
							if (TitanItemDed_IsBound(bag, slot)) then n.cat = TITAN_ITEMDED_CLASSES[1];
							elseif (TitanItemDed_IsBoE(bag, slot)) then n.cat = TITAN_ITEMDED_CLASSES[2];
							else n.cat = TITAN_ITEMDED_CLASSES[3]; end end

						local btag = "";
						if (TitanItemDed_IsBound(bag, slot)) then btag = TITAN_ITEMDED_ITEM_BOUND;
						elseif (TitanItemDed_IsBoE(bag, slot)) then btag = TITAN_ITEMDED_ITEM_BOE; end
						
						if (TitanItemDed_IsBoE(bag, slot)) then n.bound = TITAN_ITEMDED_ITEM_BOE end
						if (TitanItemDed_IsBound(bag, slot)) then n.bound = TITAN_ITEMDED_ITEM_BOUND end
						n.fullname = GetContainerItemLink(bag, slot).. " x".. stackCount.. btag;
						n.numstacks = 1;
						n.totstack = iCount;
						n.rounded = round;
						n.id = itemid;
						n.isauc = TitanItemDed_itemsbyid[itemid].isauc;
						n.isusr = TitanItemDed_itemsbyid[itemid].isusr;
						n.link = GetContainerItemLink(bag, slot);
						n.price = price * stackCount;
						n.qual = iQuality;
						n.name = item_name;
						n.stack = stackCount;
						n.bag = bag;
						n.slot = slot;
						n.tex = item_texture;
						table.insert(TPID_ItemList2, n);
					end
				end
			end

			if (ID_Debug and sName and item_isGray and price) then debug_message(sName, price.." Gray");	end		
			if (ID_Debug and sName and item_isGray == false and price) then debug_message(sName, price); end
		end
	end

	for i,val in TPID_ItemList2 do
		if (TitanGetVar(TITAN_ITEMDED_ID, "RoundOnlyIfFullStack") and (not hasfullstack[val.name])) then
			TPID_ItemList2[i].sortprice = TPID_ItemList2[i].price;
			TPID_ItemList2[i].rounded = nil;
		end
	end
		
	table.sort(TPID_ItemList2, function(a,b) return a.sortprice < b.sortprice end);
	
	TPID_ItemList = {};
	local lastval = "";
	local lastname = "";
	local lasti = 0;
	for i,val in TPID_ItemList2 do
		TitanItemDed_Debug(val.name.. " ".. val.price.. " ".. val.sortprice .. ((val.rounded and " rounded") or " not rounded"));
		if ((lastname == val.name) and (lastval == val.stack) and (val.totstack == val.stack)) then
			TPID_ItemList[lasti].numstacks = TPID_ItemList[lasti].numstacks + 1;
		else
			lasti = lasti + 1;
			TPID_ItemList[lasti] = val;
			lastval = val.stack;
			lastname = val.name;
		end
	end
end

function TitanItemDed_Init()
	if (TitanItemDed_alwaysIgnored == nil) then TitanItemDed_alwaysIgnored = {}; end
	if (TitanItemDed_newItems == nil) then TitanItemDed_newItems = {}; end
	
	if (not TitanItemDedSettings) then
		TitanItemDedSettings = {};
	end

	if (not TitanItemDedSettings[TPID_player]) then
		TitanItemDedSettings[TPID_player] = {};
		TitanItemDedSettings[TPID_player].Ignored = {};
		TitanItemDedSettings[TPID_player].Threshold = 0;
	end

	if (not TitanItemDedSettings[TPID_player].Ignored) then
		TitanItemDedSettings[TPID_player].Ignored = {};
	end

	if (not TitanItemDedSettings[TPID_player].IgnoredSets) then
		TitanItemDedSettings[TPID_player].IgnoredSets = {};
	end

	if (not TitanItemDedSettings[TPID_player].IgnoredRDSets) then
		TitanItemDedSettings[TPID_player].IgnoredRDSets = {};
	end

	if (not TitanItemDedSettings[TPID_player].AutodropSets) then
		TitanItemDedSettings[TPID_player].AutodropSets = {};
	end

	if (not TitanItemDedSettings[TPID_player].AutodropRDSets) then
		TitanItemDedSettings[TPID_player].AutodropRDSets = {};
	end

	if (not TitanItemDedSettings[TPID_player].Autodropable) then
		TitanItemDedSettings[TPID_player].Autodropable = {};
	end

	if (not TitanItemDedSettings[TPID_player].Threshold) then
		TitanItemDedSettings[TPID_player].Threshold = 1;
	end
	
	if (not TitanItemDed_unknowns) then
		TitanItemDed_unknowns = {};
	end
	
	TitanItemDed_BuildAutodropRDSet();
	TitanItemDed_BuildRDIgnoreSet();
	TitanItemDed_ImportAuctioneerData();
	
	TitanPanelItemDedButton_UpdateIcon();
	
	return;
end

function TitanItemDed_IgnoreItem()
	local item = this.value;
	if (not item) then item = TPID_ItemList[1]; end
	
	if item then TPID_ignored[item.name] = 1; end
	if item then TitanItemDed_Chatback(string.format(TITAN_ITEMDED_CHAT_IGNORED, item.link)); 
	else TitanItemDed_Chatback(TITAN_ITEMDED_CHAT_NOTHINGTOIGNORE); end

	TPID_safetodrop = true;
	TitanItemDed_AutoDrop();
	TitanPanelItemDedButton_UpdateIcon();
end

function TitanItemDed_IgnoreAlwaysItem()
	local item = this.value;
	if (not item) then item = TPID_ItemList[1].name; end
	
	if item then TitanItemDedSettings[TPID_player]["Ignored"][item.name] = 1; end
	if item then TitanItemDed_Chatback(stirng.format(TITAN_ITEMDED_CHAT_ALWAYSIGNORED, item.link));
	else TitanItemDed_Chatback(TITAN_ITEMDED_CHAT_NOTHINGTOIGNORE); end

	TPID_safetodrop = true;
	TitanItemDed_AutoDrop();
	TitanPanelItemDedButton_UpdateIcon();
end

function TitanItemDed_Listman(cmd, itemidx)
	local act = cmd;
	local item = TPID_ItemList[itemidx];
	if (not act) then act = this.value; end
	if (not item) then item = TPID_ItemList[1]; end
	
	if (act == "r") then
		TPID_ignored = {};
		TitanItemDed_Chatback(TITAN_ITEMDED_CHAT_RESETIGNORED);
	end
	if (act == "ra") then
		TPID_ignored = {};
		TitanItemDedSettings[TPID_player]["Ignored"] = {};
		TitanItemDed_Chatback(TITAN_ITEMDED_CHAT_RESETALWAYSIGNORED);
	end
	if (act == "rad") then
		if item then 
			TitanItemDedSettings[TPID_player].Autodropable = {}; 
			TitanItemDed_Chatback(TITAN_ITEMDED_CHAT_RESETAUTODROP);
		end
	end
	TitanPanelItemDedButton_UpdateIcon();
end

function TitanItemDed_TrashItem(itemidx)
	local item = TPID_ItemList[itemidx];
	if (not item) then item = TPID_ItemList[1]; end
	
	TitanItemDed_Debug("TitanItemDed_Trashitem");
	if item then 
		if (MerchantFrame:IsVisible()) then
			UseContainerItem(item.bag, item.slot);
		else
			TitanItemDed_Chatback(string.format(TITAN_ITEMDED_CHAT_DELETE, item.link, TitanItemDed_GetTextGSC(item.price)));
			PickupContainerItem(item.bag, item.slot);
			DeleteCursorItem();
			TPID_safetodrop = true;
		end
	else
		TitanItemDed_Chatback(TITAN_ITEMDED_NOITEMDESTROY);
	end
end

function TitanItemDed_SellJunk()
	for i,item in TPID_ItemList do
		if ((item.qual == 0) and (MerchantFrame:IsVisible())) then
			UseContainerItem(item.bag, item.slot);
		end
	end
end

-------------------------------------------------------------------------------
-- Bag Search functions
-------------------------------------------------------------------------------

function TitanItemDed_IsBound(bag, slot)
	TPIDTooltip:Hide()
--	TPIDTooltip:SetOwner(this, "ANCHOR_LEFT");
	TPIDTooltip:SetBagItem(bag, slot);
	
	--Search for soulbound line
	local isbound = nil;
	for i=2, 15, 1 do
		tmpText = getglobal("TPIDTooltipTextLeft"..i);
		lval = nil;
		if (tmpText:GetText()) then
			if (string.find(tmpText:GetText(), TITAN_ITEMDED_ITEM_FIND_BOUND)) then return true end
		end
	end
	TPIDTooltip:Hide()
end

function TitanItemDed_IsBoE(bag, slot)
	TPIDTooltip:Hide()
--	TPIDTooltip:SetOwner(this, "ANCHOR_LEFT");
	TPIDTooltip:SetBagItem(bag, slot);
	
	--Search for BoE line
	local isbound = nil;
	for i=2, 15, 1 do
		tmpText = getglobal("TPIDTooltipTextLeft"..i);
		lval = nil;
		if (tmpText:GetText()) then
			if (string.find(tmpText:GetText(), TITAN_ITEMDED_ITEM_FIND_BOE)) then return true end
		end
	end
	TPIDTooltip:Hide()
end

function TitanItemDed_GetItemName(bag, slot)
  local link = nil;
  
  if (bag == -1) then
    link = GetInventoryItemLink("player", slot);
  else
    link = GetContainerItemLink(bag, slot);
  end

  if link then
		local i,j, itemID, _, _, _, name = string.find(link, "|Hitem:(%d+):(%d+):(%d+):(%d+)|h[[]([^]]+)[]]|h");
		return name, tonumber(itemID or 0);
  else
    return nil;
  end
end

function TitanItemDed_IsAutodroppable(val)
	if (val.qual == 0) then return true end
	if (TPID_autodropRD[val.name]) then return true end
	if (TitanItemDedSettings[TPID_player].Autodropable[val.name]) then return true end
	if (val.cat) then if (TitanItemDedSettings[TPID_player].AutodropSets[val.cat]) then return true end end
end

function TitanItemDed_IsDroppable(itemname, itemid, bag, slot)
	local _, _, iQuality = GetItemInfo(itemid);
	if (TitanItemDed_OverrideItems) then if (TitanItemDed_OverrideItems[itemid]) then return true end end
	if (TPID_ignoredRD[itemname]) then return false end
	
	local cat = TitanItemDed_itemsbyid[itemid].c;
	if (cat == TITAN_ITEMDED_CLASSES[3]) then
		if (TitanItemDed_IsBound(bag, slot)) then cat = TITAN_ITEMDED_CLASSES[1]; 
		elseif (TitanItemDed_IsBoE(bag, slot)) then cat = TITAN_ITEMDED_CLASSES[2]; end 
	end
	if (TitanItemDedSettings[TPID_player].IgnoredSets[cat]) then return false end
	
	if (TitanItemDed_FaireItems[itemid] and TitanGetVar(TITAN_ITEMDED_ID, "IgnoreFaire")) then return false; end
	if TPID_ignored[itemname] then return false; end;
	if TitanItemDedSettings[TPID_player]["Ignored"][itemname] then return false; end;
	if (iQuality > TitanItemDedSettings[TPID_player].Threshold) then return false; end;
	
	return true;
end

function TitanItemDed_GetEmpties()
	local numempty = 0;
	
	for bag=0,NUM_BAG_FRAMES do
		if (TitanItemDed_IsAmmoBag(bag)) then
			-- Do Nothing
		else
			for slot=1,GetContainerNumSlots(bag) do
			  local item = GetContainerItemLink(bag, slot);
			  if (not item) then numempty = numempty+1; end
			end
		end
	end
	
	return numempty;
end

function TitanItemDed_IsAmmoBag(bag)
	local bagname = GetBagName(bag);
	
	if (bagname) then
	  if (string.find(bagname, "Quiver") or string.find(bagname, "Ammo") or string.find(bagname, "Bandolier")) then
			return true;
	  end
	end
	  
  return false;
end

function TitanItemDed_Toggle()
	TitanToggleVar(TITAN_ITEMDED_ID, this.value);
	TitanPanelItemDedButton_UpdateIcon();
end

function TitanItemDed_ToggleAutodrop()
	if (TPID_UseAutodrop) then TPID_UseAutodrop = false;
	else 
		TPID_UseAutodrop = true;
		TPID_safetodrop = true; 
		TitanItemDed_AutoDrop(); 
	end
end

-------------------------------------------------------------------------------
-- Gold formatting code, shamelessly "borrowed" from Auctioneer
-------------------------------------------------------------------------------

function TitanItemDed_GetGSC(money)
	if (money == nil) then money = 0; end
	local g = math.floor(money / 10000);
	local s = math.floor((money - (g*10000)) / 100);
	local c = math.floor(money - (g*10000) - (s*100));
	return g,s,c;
end

GSC_GOLD="ffd100";
GSC_SILVER="e6e6e6";
GSC_COPPER="c8602c";
GSC_START="|cff%s%d|r";
GSC_PART=".|cff%s%02d|r";
GSC_NONE="|cffa0a0a0none|r";

function TitanItemDed_GetTextGSC(money)
	local g, s, c = TitanItemDed_GetGSC(money);
	local gsc = "";
	if (g > 0) then
		gsc = format(GSC_START, GSC_GOLD, g);
		if ((s > 0) or (c > 0)) then
			if (c > 50) then s = s+1; end
			gsc = gsc..format(GSC_PART, GSC_SILVER, s);
		end
	elseif (s > 0) then
		gsc = format(GSC_START, GSC_SILVER, s);
		if (c > 0) then
			gsc = gsc..format(GSC_PART, GSC_COPPER, c);
		end
	elseif (c > 0) then
		gsc = gsc..format(GSC_START, GSC_COPPER, c);
	else
		gsc = GSC_NONE;
	end

	return gsc;
end

-------------------------------------------------------------------------------
-- External Mod search functions
-------------------------------------------------------------------------------

function TitanItemDed_GetEconPrice(item_name)
	if (WOWEcon_Prices[item_name]) then return WOWEcon_Prices[item_name][1]; end
	return nil;
end

-- This code was "borrowed" from Auctioneer and edited down to retreive only relavant infos
function TitanItemDed_GetAuctioneerData(bag, slot)
	local link = GetContainerItemLink(bag, slot)
	if (not IsAddOnLoaded(TITAN_ITEMDED_AUCTIONEERADDONNAME)) then TitanItemDed_Debug("Auc not loaded!"); return -1; end
	if (not link) then TitanItemDed_Debug("No Link"); return; end
	
	local auctKey = Auctioneer_GetAuctionKey();
	
	local itemID, randomProp, enchant = EnhTooltip.BreakLink(link);
	local itemKey = itemID..":"..randomProp..":"..enchant;
	
	if (itemID > 0) then
		local auctionPriceItem = Auctioneer_GetAuctionPriceItem(itemKey, auctKey);
		local aCount,minCount,minPrice,bidCount,bidPrice,buyCount,buyPrice = Auctioneer_GetAuctionPrices(auctionPriceItem.data);
		
		if (aCount == 0) then -- Never seen at auction
			TitanItemDed_Debug(link.. " No Auc data");
			return;
		else -- (aCount > 0)
			local hsp = Auctioneer_GetHSP(itemKey, auctKey);
			if hsp == 0 and buyCount > 0 then
				hsp = math.floor(buyPrice / buyCount); -- use mean buyout if median not available
			end
			local buyPrice = Auctioneer_RoundDownTo95(nullSafe(hsp));
			TitanItemDed_Debug(link.. " Auc: ".. buyPrice);
			return buyPrice, itemID, link;
		end -- (aCount > 0)
	end -- if (itemID > 0)
end

function TitanItemDed_ScanAuctioneerData()
	for bag=0,NUM_BAG_FRAMES do
		for slot=1,GetContainerNumSlots(bag) do
			local auc, itemID, link = TitanItemDed_GetAuctioneerData(bag, slot);
			
			if (auc ~= -1) then -- Auc loaded
				if (TitanItemDedAuctioneerVals[itemID]) then 
					TitanItemDedAuctioneerVals[itemID] = {link, auc}; 
				end
			end
		end
	end
	TitanItemDed_ImportAuctioneerData()
end

function TitanItemDed_ImportAuctioneerData()
	if (not TitanItemDedAuctioneerVals) then TitanItemDedAuctioneerVals = {}; return; end
	for id,val in TitanItemDedAuctioneerVals do
		if (val[2]) then 
			if (not TitanItemDed_itemsbyid[id].oprice) then TitanItemDed_itemsbyid[id].oprice = TitanItemDed_itemsbyid[id].s; end
			TitanItemDed_itemsbyid[id].s = val[2]; 
			TitanItemDed_itemsbyid[id].isauc = true; 
		end
	end
	TitanPanelItemDedButton_UpdateIcon();
end

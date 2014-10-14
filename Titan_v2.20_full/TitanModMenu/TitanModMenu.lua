TITAN_MODMENU_ID = "ModMenu";
TITAN_MODMENURIGHT_ID = "ModMenuRight";
TITAN_MODMENU_ICON = "Interface\\Icons\\Trade_Engineering"
--TITAN_MODMENU_ICON = "Interface\\Icons\\Spell_Holy_BlessingOfAgility"
TITAN_MODMENU_ENCH = false;
TITAN_MODMENU_MINER = false;

loadedmodlist = {};
local maxmods = 23;

--------------------------------------------
--                 Debug                  --
--------------------------------------------

TitanPanelModMenu_DebugOutput = false;

function TPMM_Debug(msg)
	if (TitanPanelModMenu_DebugOutput) then DEFAULT_CHAT_FRAME:AddMessage("MM Debug: ".. msg); end
end

--------------------------------------------
--              onFunctions               --
--------------------------------------------

function TitanPanelModMenuButton_OnLoad()
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("ADDON_LOADED");
	this.registry = { 
		id = TITAN_MODMENU_ID,
		category = "Interface",
		menuText = TITAN_MODMENU_MENU_TEXT, 
		buttonTextFunction = "TitanPanelModMenuButton_GetButtonText", 
		icon = TITAN_MODMENU_ICON,	
		iconWidth = 16,
		savedVariables = {
			ShowIcon = 1,
			ShowLabelText = 1,
		}
	};
end

function TitanPanelModMenuRightButton_OnLoad()
	this.registry = { 
		id = TITAN_MODMENURIGHT_ID,
		category = "Interface",
		menuText = TITAN_MODMENU_MENU_TEXTRIGHT, 
		buttonTextFunction = "TitanPanelModMenuButton_GetButtonText", 
		icon = TITAN_MODMENU_ICON,	
		iconWidth = 16,
		savedVariables = {
			ShowIcon = 1,
			ShowLabelText = 1,
		}
	};
end

function TitanPanelModMenuButton_OnEvent()
	if(event == "ADDON_LOADED") then
		if(TitanModMenu_modsets) then
			TitanPanelModMenu_MakeLoadedList();
			TitanPanelModMenu_PopulateSet();
		end
	end
	if(event == "VARIABLES_LOADED") then
		if (TitanModMenu_UserMenuItems) then
			for name,val in TitanModMenu_UserMenuItems do
				TitanModMenu_MenuItems[name] = val;
			end
		end
		if (TitanModMenu_UserSystemMenuItems) then
			for name,val in TitanModMenu_UserSystemMenuItems do
				TitanModMenu_SystemMenuItems[name] = val
			end
		end
		if (TitanModMenu_UserBaseMenu) then
			TitanModMenu_BaseMenu = TitanModMenu_UserBaseMenu;
		end
	
		if (not TitanModMenu_modsets) then TitanModMenu_modsets = {}; end
		if (not TitanModMenu_modsets["Default"]) then TitanModMenu_modsets["Default"] = {}; end
		if (not TitanModMenu_loadedset) then TitanModMenu_loadedset = "Default"; end
		
		TitanPanelModMenu_MakeLoadedList();
		TitanPanelModMenu_PopulateSet();
		
		SlashCmdList["MODMENU"] = TitanPanelModMenu_Cmd;
		SLASH_MODMENU1 = "/mm";
	end
end

--------------------------------------------
--             Mod Functions              --
--------------------------------------------

function TitanPanelModMenu_Cmd(msg)
	local params = msg;
	local command = params;
	local index = strfind(command, " ");
	if ( index ) then
		command = strsub(command, 1, index-1);
		params = strsub(params, index+1);
	else
		params = "";
	end
	
	if (command == "add") then TitanPanelModMenu_CreateSet(params); end
	if (command == "del") then TitanPanelModMenu_DeleteSet(params); end
end

function TitanPanelModMenu_SetHelp()
	TitanPanelModMenu_Chat("Add set: /mm add SetName");
	TitanPanelModMenu_Chat("Delete set: /mm del SetName");
end

function TitanPanelModMenu_Chat(txt)
	DEFAULT_CHAT_FRAME:AddMessage("<ModMenu> ".. txt);
end

function TitanPanelModMenu_CreateSet(name)
	if (TitanModMenu_modsets[name]) then 
		TitanPanelModMenu_Chat("Set already exists: ".. name);
		return;
	end
	if (not TitanModMenu_modsets[name]) then TitanModMenu_modsets[name] = {}; end
	TitanModMenu_loadedset = name;
	TitanPanelModMenu_PopulateSet();
	TitanPanelModMenu_Chat("Set created: ".. name);
end

function TitanPanelModMenu_PopulateSet()
	for i,addon in loadedmodlist do
		TitanModMenu_modsets[TitanModMenu_loadedset][addon.name] = addon.enabled;
	end
end

function TitanPanelModMenu_DeleteSet(name)
	if (name == "Default") then 
		TitanPanelModMenu_Chat("Cannot delete Default!"); 
		return; 
	end
	if (not TitanModMenu_modsets[name]) then
		TitanPanelModMenu_Chat("Set does not exist: ".. name); 
		return; 		
	end
	if (TitanModMenu_loadedset == name) then TitanPanelModMenu_LoadSet("Default"); end
	TitanModMenu_modsets[name] = nil;
	TitanPanelModMenu_Chat("Deleted set: ".. name); 
end

function TitanPanelModMenu_LoadSet(name)
	local setname = name;
	if (not setname) then setname = this.value; end
	if (not TitanModMenu_modsets[setname]) then return; end

	TitanModMenu_loadedset = setname;
	
	local i;
	for i=1,GetNumAddOns() do
		local modname, _, _, enabled = GetAddOnInfo(i);
		if (TitanModMenu_modsets[setname][modname]) then
			if (not enabled) then EnableAddOn(modname); end
		else
			if (enabled) then DisableAddOn(modname); end
		end
	end
	
	TitanPanelModMenu_Chat("Loaded set: ".. setname);
end

function TitanPanelModMenu_ToggleFrame(f)
	local fram = getglobal(f);
	if (not fram) then fram = getglobal(this.value); end
	DropDownList1:Hide();
	if (fram:IsVisible()) then
		HideUIPanel(fram, true);
	else 
		ShowUIPanel(fram, true);
	end
end

function TitanPanelModMenu_PassSlashCmd(c)
	local cmd = c;
	if (not cmd) then cmd = this.value; end
	DropDownList1:Hide();
	TitanPanelModMenuEditBox:SetText(cmd);
	ChatEdit_SendText(TitanPanelModMenuEditBox);
end

function TitanPanelModMenu_CallFunction(f)
	local funct = f;
	if (not funct) then funct = this.value; end
	DropDownList1:Hide();
	local func = getglobal(funct);
	func();
end

function TitanPanelModMenu_RegisterMenu(addon, infoarray)
	TitanModMenu_MenuItems[addon] = infoarray;
end

--------------------------------------------
--            Titan Functions             --
--------------------------------------------

function TitanPanelModMenuButton_GetButtonText(id)
	return TITAN_MODMENU_MENU_BARTEXT, "";
end

function TitanPanelModMenu_ToggleIconText()
	if (TitanGetVar(TITAN_MODMENU_ID, "ShowIcon") == TitanGetVar(TITAN_MODMENU_ID, "ShowLabelText")) then
			TitanToggleVar(TITAN_MODMENU_ID, "ShowLabelText");
	else
		TitanToggleVar(TITAN_MODMENU_ID, "ShowIcon");
		TitanToggleVar(TITAN_MODMENU_ID, "ShowLabelText");
	end
	TitanPanelButton_UpdateButton(TITAN_MODMENU_ID, 1);
end

function TitanPanelModMenu_ToggleIcon()
	if ((TitanGetVar(TITAN_MODMENU_ID, "ShowIcon")) and (not TitanGetVar(TITAN_MODMENU_ID, "ShowLabelText"))) then
		TitanToggleVar(TITAN_MODMENU_ID, "ShowLabelText");
	end
	TitanToggleVar(TITAN_MODMENU_ID, "ShowIcon");
	TitanPanelButton_UpdateButton(TITAN_MODMENU_ID, 1);
end

function TitanPanelModMenu_ToggleText()
	if ((not TitanGetVar(TITAN_MODMENU_ID, "ShowIcon")) and (TitanGetVar(TITAN_MODMENU_ID, "ShowLabelText"))) then
		TitanToggleVar(TITAN_MODMENU_ID, "ShowIcon");
	end
	TitanToggleVar(TITAN_MODMENU_ID, "ShowLabelText");
	TitanPanelButton_UpdateButton(TITAN_MODMENU_ID, 1);
end

function TitanPanelModMenu_Hide()
	TitanPanel_RemoveButton(TITAN_MODMENU_ID);
end

function TitanPanelModMenuRight_Hide()
	TitanPanel_RemoveButton(TITAN_MODMENURIGHT_ID);
end

function TitanPanelRightClickMenu_PrepareModMenuMenu(level)
	if (level == 1) then TitanPanelModMenu_BuildRootMenu(TITAN_MODMENU_ID); end
	if (level == 2) then TitanPanelModMenu_BuildCatMenu(TITAN_MODMENU_ID); end
	if (level == 3) then TitanPanelModMenu_BuildAddonMenu(TITAN_MODMENU_ID); end
end

function TitanPanelRightClickMenu_PrepareModMenuRightMenu(level)
	if (level == 1) then TitanPanelModMenu_BuildRootMenu(TITAN_MODMENURIGHT_ID); end
	if (level == 2) then TitanPanelModMenu_BuildCatMenu(TITAN_MODMENURIGHT_ID); end
	if (level == 3) then TitanPanelModMenu_BuildAddonMenu(TITAN_MODMENURIGHT_ID); end
end

function TitanPanelModMenu_BuildRootMenu(id)
	local level = 1;
	
	local loadedmodcats = {};
	
	for i,cat in TitanModMenu_SystemMenus do
		loadedmodcats[cat] = true;
	end
	
	if (TitanPanelModMenu_PortalsEmbeddable) then loadedmodcats[TITAN_MODMENU_CAT_PORTALS] = true; end
	
	--TitanPanelModMenu_MakeLoadedList();

	for i,v in loadedmodlist do
		if (not v.cat) then
			v.cat = TITAN_MODMENU_CAT_OTHER;
		end
		
		loadedmodcats[v.cat] = true;
	end

	TitanPanelRightClickMenu_AddTitle(TitanPlugins[id].menuText, level);
	TitanPanelRightClickMenu_AddSpacer(level);
	
	local lastspace = false;
	for i,cat in TitanModMenu_BaseMenu do
		if ((not lastspace) and (cat == TITAN_MODMENU_SPACER)) then
			lastspace = true;
			TitanPanelRightClickMenu_AddSpacer(level);
		elseif (loadedmodcats[cat]) then
			lastspace = false;
			local info = {};
			info.text = cat;
			info.value = cat;
			info.hasArrow = 1;
			UIDropDownMenu_AddButton(info, level);
		end
	end
end

function TitanPanelModMenu_BuildCatMenu()
	local level = 2;
	local cat = UIDROPDOWNMENU_MENU_VALUE;	
	
	if (cat == TITAN_MODMENU_CAT_PORTALS) then
		TitanPortals_RightClickMenu(true);
	end
	
	if ((cat == TITAN_MODMENU_CAT_EMOTES) and TitanPanelModMenu_EmoteMenuEmbeddable) then
		TitanPanelEmoteMenu_BuildRootMenu(true);
		return;
	end
	
	for i,sysmen in TitanModMenu_SystemMenus do
		if (cat == sysmen) then
			TitanPanelModMenu_BuildSystemMenu(sysmen);
			return;
		end
	end
	
--	TitanPanelModMenu_MakeLoadedList();
	
	for i,v in loadedmodlist do
		local loc = GetLocale();
		local locdata;
		local menudata = TitanModMenu_MenuItems[v.name];
		if (cat == v.cat) then
			local addname = TitanPanelModMenu_GetOnDemandText(v);
			if (v.submenu) then 
				local info = {};
				info.text = addname;
				info.value = v;
				info.func = TitanPanelModMenu_HandleModClick;
				if (v.loaded) then info.hasArrow = 1; end
				UIDropDownMenu_AddButton(info, level);
			else
				local info = {};
				info.text = TitanPanelModMenu_GetOnDemandText(v);
				info.value = v;
				info.func = TitanPanelModMenu_HandleModClick;
				
				UIDropDownMenu_AddButton(info, level);
			end		
		end
	end
end

function TitanPanelModMenu_BuildSystemMenu(sysmen)
	local level = 2;

	if (sysmen == TITAN_MODMENU_CAT_MODSETS) then
		TitanPanelModMenu_BuildSetMenu();
		return;
	end

	if (sysmen == TITAN_MODMENU_CAT_TRADESKILLS) then
		TitanPanelModMenu_BuildTradeMenu();
		return;
	end

	local sysmensort = {};
	for n,val in TitanModMenu_SystemMenuItems do
		table.insert(sysmensort, n);
	end
	table.sort(sysmensort);

	for i,n in sysmensort do
		local val = TitanModMenu_SystemMenuItems[n];
		local loc = GetLocale();
		local skip;
		if (val.loc) then 
			if (val.loc ~= loc) then skip = true; end 
		end
			
		if ((not skip) and (sysmen == val.cat)) then
			if (val.name == TITAN_MODMENU_SPACER) then
				TitanPanelRightClickMenu_AddSpacer(level);
			elseif (val.submenu) then 
				local info = {};
				info.text = val.name;
				info.value = val;
				info.hasArrow = 1;
				UIDropDownMenu_AddButton(info, level);
			elseif (val.toggle) then
				TitanPanelRightClickMenu_AddCommand(val.name, val.toggle, "TitanPanelModMenu_ToggleFrame", level);
			elseif (val.cmd) then
				TitanPanelRightClickMenu_AddCommand(val.name, val.cmd, "TitanPanelModMenu_PassSlashCmd", level);
			elseif (val.func) then
				TitanPanelRightClickMenu_AddCommand(val.name, val.func, "TitanPanelModMenu_CallFunction", level);
			else
				TitanPanelRightClickMenu_AddTitle(val.name, level);
			end
		end
	end
end

function TitanPanelModMenu_BuildAddonMenu()
	local level = 3;

	if (UIDROPDOWNMENU_MENU_VALUE.isemotemenu) then
		TitanPanelEmoteMenu_BuildCatMenu(true);
		return;
	end

	local addon = UIDROPDOWNMENU_MENU_VALUE.name;
	local title = UIDROPDOWNMENU_MENU_VALUE.title;
	local submenudata = UIDROPDOWNMENU_MENU_VALUE.submenu;
	if (not submenudata) then return; end
	
	TPMM_Debug("Level 3, ".. addon);
	
	if (not title) then
		local _, title = GetAddOnInfo(addon);
	end
	TitanPanelRightClickMenu_AddTitle(title, level);
	TitanPanelRightClickMenu_AddSpacer(level);
	
	for i,entryarray in submenudata do			
		if (entryarray == TITAN_MODMENU_SPACER) then
			TitanPanelRightClickMenu_AddSpacer(level);
		elseif (entryarray.toggle) then
			TitanPanelRightClickMenu_AddCommand(entryarray.text, entryarray.toggle, "TitanPanelModMenu_ToggleFrame", level);
		elseif (entryarray.cmd) then
			TitanPanelRightClickMenu_AddCommand(entryarray.text, entryarray.cmd, "TitanPanelModMenu_PassSlashCmd", level);
		elseif (entryarray.func) then
			TitanPanelRightClickMenu_AddCommand(entryarray.text, entryarray.func, "TitanPanelModMenu_CallFunction", level);
		else
			TitanPanelRightClickMenu_AddTitle(entryarray.text, level);
		end
	end
end

function TitanPanelModMenu_BuildSetMenu()
	local level = 2;
	local sets = {};

	for name,val in TitanModMenu_modsets do
		table.insert(sets, name);
	end
	table.sort(sets, function(a,b) return a<b end)
	
	for i,name in sets do
		local info = {};
		info.text = name;
		info.value = name;
		info.func = TitanPanelModMenu_LoadSet;
		info.checked = (TitanModMenu_loadedset == name);
		UIDropDownMenu_AddButton(info, level);
	end
	
	TitanPanelRightClickMenu_AddSpacer(level);
	TitanPanelRightClickMenu_AddCommand("Edit Sets", "", "TitanPanelModMenu_SetHelp", level);	

	TitanPanelRightClickMenu_AddSpacer(level);
	TitanPanelRightClickMenu_AddCommand(TITAN_MODMENU_MENU_RELOADUI, "/console reloadui", "TitanPanelModMenu_PassSlashCmd", level);	
end

function TitanPanelModMenu_BuildTradeMenu()
	local level=2
--	ExpandSkillHeader(0);
	for i=1, GetNumSkillLines(), 1 do
		local skillName, _, _, skillRank, _, skillModifier, skillMaxRank = GetSkillLineInfo(i);
		if (skillName) then
			if (skillName == TITAN_MODMENU_TRADE_HERB) then
				local slot = TitanPanelModMenu_GetSlot(TITAN_MODMENU_TRADE_FINDHERB);
				local txt = TitanPanelModMenu_GetSkillText(skillName, skillRank, skillModifier, skillMaxRank);
				TitanPanelRightClickMenu_AddCommand(txt, slot, "TitanPanelModMenu_OpenCraft", level);
			elseif (skillName == TITAN_MODMENU_TRADE_MINING) then
				local slot = TitanPanelModMenu_GetSlot(TITAN_MODMENU_TRADE_FINDORE);
				local txt = TitanPanelModMenu_GetSkillText(skillName, skillRank, skillModifier, skillMaxRank);
				TitanPanelRightClickMenu_AddCommand(txt, slot, "TitanPanelModMenu_OpenCraft", level);				
			elseif (skillName == TITAN_MODMENU_TRADE_FIRSTAID)
				or (skillName == TITAN_MODMENU_TRADE_ALCHEMY)
				or (skillName == TITAN_MODMENU_TRADE_TAILOR)
				or (skillName == TITAN_MODMENU_TRADE_BLACKSMITH)
				or (skillName == TITAN_MODMENU_TRADE_ENGINEER)
				or (skillName == TITAN_MODMENU_TRADE_LEATHER)
				or (skillName == TITAN_MODMENU_TRADE_SKINNING)
				or (skillName == TITAN_MODMENU_TRADE_ENCHANTING)
				or (skillName == TITAN_MODMENU_TRADE_COOKING)
				or (skillName == TITAN_MODMENU_TRADE_FISHING)
				then
				local slot = TitanPanelModMenu_GetSlot(skillName);
				local txt = TitanPanelModMenu_GetSkillText(skillName, skillRank, skillModifier, skillMaxRank)
				TitanPanelRightClickMenu_AddCommand(txt, slot, "TitanPanelModMenu_OpenCraft", level);
			end
			if (skillName == TITAN_MODMENU_TRADE_ENCHANTING) then
				TITAN_MODMENU_ENCH = true;
			end
			if (skillName == TITAN_MODMENU_TRADE_MINING) then
				TITAN_MODMENU_MINER = true;
			end
		end
	end  
	
	if(TITAN_MODMENU_ENCH) then
		local slot = TitanPanelModMenu_GetSlot(TITAN_MODMENU_TRADE_DISENCHANTING);
		TitanPanelRightClickMenu_AddSpacer(level);
		TitanPanelRightClickMenu_AddCommand(TITAN_MODMENU_TRADE_DISENCHANTING, slot, "TitanPanelModMenu_OpenCraft", level);
	end
	if(TITAN_MODMENU_MINER) then
		local slot = TitanPanelModMenu_GetSlot(TITAN_MODMENU_TRADE_SMELTING);
		TitanPanelRightClickMenu_AddSpacer(level);
		TitanPanelRightClickMenu_AddCommand(TITAN_MODMENU_TRADE_SMELTING, slot, "TitanPanelModMenu_OpenCraft", level);
	end
end

function TitanPanelModMenu_GetSkillText(skillName, skillRank, skillModifier, skillMaxRank)
	local txt = skillName.." ".. skillRank;
	if (skillModifier > 0) then
		txt = txt.. " (+".. skillModifier.. ")";
	end
	txt = txt.. "/".. skillMaxRank;
	
	return txt;
end

function TitanPanelModMenu_GetSlot(craft)
	local _, _, _, numSpells = GetSpellTabInfo(1);
	
	for i=1, numSpells do
		local spellName = GetSpellName(i, TITAN_MODMENU_TRADE_SPELLBOOKGENERAL);
		if (spellName == craft) then return i; end
	end
end

function TitanPanelModMenu_OpenCraft()
	DropDownList1:Hide();
	local id = this.value;
	CastSpell(id, TITAN_MODMENU_TRADE_SPELLBOOKGENERAL)
end

-- These functions are here because I don't know how 
-- to pass args with the current implementation
function TPMM_TogCharFrame()
	ToggleCharacter("PaperDollFrame");
end

function TPMM_TogSpellFrame()
	ToggleSpellBook(BOOKTYPE_SPELL);
end

function TitanPanelModMenu_HandleModClick()
	local addon = this.value;
	
	if(IsShiftKeyDown()) then
		if (addon.enabled) then
			DisableAddOn(addon.name);
		else
			EnableAddOn(addon.name);
		end
		
		TitanPanelModMenu_MakeLoadedList();
		TitanPanelModMenu_PopulateSet();
	else
		if (addon.loaded) then
			if (addon.func) then
				TitanPanelModMenu_CallFunction(addon.func);
			elseif (addon.toggle) then
				TitanPanelModMenu_ToggleFrame(addon.toggle);
			elseif (addon.cmd) then
				TitanPanelModMenu_PassSlashCmd(addon.cmd);
			end
		else
			if (addon.loadable and addon.isondemand and (not addon.loaded) and addon.enabled) then
				UIParentLoadAddOn(addon.name);
				TitanPanelModMenu_MakeLoadedList();
			end
		end
	end
end

function TitanPanelModMenu_MakeLoadedList()
	local i;
	loadedmodlist = {};
	local mysterymod = {};
	
	for i=1,GetNumAddOns() do
		local name, title, notes, enabled, loadable, reason, security = GetAddOnInfo(i);
		local isondemand = IsAddOnLoadOnDemand(i);
		local loaded = IsAddOnLoaded(i); 
		
		local item = {};
		item.name = name;
		item.title = title;
		item.notes = notes;
		item.isondemand = isondemand;
		item.enabled = enabled;
		item.loadable = loadable;
		item.loaded = loaded;
		item.reason = reason;
		item.security = security;
		if (TitanModMenu_MenuItems[name]) then
			local loc = GetLocale();
			if (TitanModMenu_MenuItems[name].text) then 
				item.title = TitanModMenu_MenuItems[name].text; 
			end
			if (TitanModMenu_MenuItems[name][loc]) then 
				item.submenu = TitanModMenu_MenuItems[name][loc].submenu;
				if (TitanModMenu_MenuItems[name][loc].text) then
					item.title = TitanModMenu_MenuItems[name][loc].text;
				end
			else item.submenu = TitanModMenu_MenuItems[name].submenu;
			end
			item.func = TitanModMenu_MenuItems[name].func;
			item.toggle = TitanModMenu_MenuItems[name].toggle;
			item.cmd = TitanModMenu_MenuItems[name].cmd;
			item.cat = TitanModMenu_MenuItems[name].cat;
			if (not item.cat) then item.cat = TITAN_MODMENU_CAT_OTHER; end
			table.insert(loadedmodlist, item);
		else
			table.insert(mysterymod, item);
		end
	end

	table.sort(mysterymod, function(a,b) return a.name<b.name end);
	
	for i=1,table.getn(mysterymod) do
		mysterymod[i]["cat"] = TITAN_MODMENU_CAT_UNKNOWN.. " ".. floor((i-1)/maxmods)+1,
		table.insert(loadedmodlist, mysterymod[i]);
	end

	table.sort(loadedmodlist, function(a,b) return a.name<b.name end);
end

function TitanPanelModMenu_GetOnDemandText(v)
	local color, note;
	
	if (v.reason == "DISABLED") then 	 
		color = "ff9d9d9d";		-- Grey
		note = " (".. TEXT(getglobal("ADDON_"..v.reason)).. ")";
	elseif (v.reason == "NOT_DEMAND_LOADED") then	
		color = "ff0070dd";		-- Blue
		note = " (".. TEXT(getglobal("ADDON_"..v.reason)).. ")";
	elseif(v.reason) then
		color = "ffff8000";		-- Orange
		note = " (".. TEXT(getglobal("ADDON_"..v.reason)).. ")";
	elseif (v.loadable and v.isondemand and (not v.loaded) and v.enabled) then 
		color = "ff1eff00"; 	-- Green 
		note = " (Loadable OnDemand)";
	elseif (v.loaded and (not v.enabled)) then
		color = "ffa335ee"; 	-- Purple
		note = " (Disabled on reloadUI)";
	else 						 
		return v.title;				-- White
	end	

	return "|c".. color.. v.title.. "|c".. color.. note.. FONT_COLOR_CODE_CLOSE;
end

-- ****************************************************************************************************
-- Title: TitanWindFury aka TWF, created by Seaquest.
-- Description: Tracks WindFury data
--
-- Version: 1.4 for Wow: 11100
-- ****************************************************************************************************


-- ****************************************************************************************************
-- Start: Variables

WF = {}
TWFS = {}

WF_DPS = 0;
WF_SHIT = 0;
WF_CRIT = 0;
WF_LEFT = 0;
WF_THIS = 0;
WF_NIL = "0";
WF_WEAPON_NAME = "";
local WF_STATUS = false;

WF_UPD_TIME = 0;
WF_NOW_TIME = 0;

-- End: Variables
-- ****************************************************************************************************


-- ****************************************************************************************************
-- Start: TWF OnLoad

function TWF_OnLoad()
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("UNIT_NAME_UPDATE");
	TWF_DB("TitanWindFury "..WF_VERSION.." loaded");
end

-- End: TWF OnLoad
-- ****************************************************************************************************


-- ****************************************************************************************************
-- Start: TWF OnEvent

function TWF_OnEvent()
	if ( event == "PLAYER_ENTERING_WORLD" ) or ( event == "UNIT_NAME_UPDATE" and arg1 == "player" ) then
		TWF_Init();
		TWF_WeaponCheck(); -- this should fire a check after zoning also (untested)
		return;
	end
	if ( event == "UNIT_INVENTORY_CHANGED" ) then
		if ( arg1 == "player" ) then
			TWF_WeaponCheck();
		end
	end
	if ( event == "CHAT_MSG_SPELL_SELF_BUFF" and strfind( arg1, WF_loc_SEARCHSTRING ) and WF_STATUS ) then
		
		WF_LEFT = 3;
		WF_THIS = 0;
		WF_CRIT = 0;

		WF_NOW_TIME = 3+GetTime();
		
		TWF_AddValue("HITS",1,"SESSION");
		TWF_AddValue("WF_ALL_HITS",1,"LIFETIME");

		TWF_AddValue("PROCS",1,"SESSION");
		TWF_AddValue("WF_ALL_PROCS",1,"LIFETIME");
		
	end
	if ( event == "CHAT_MSG_COMBAT_SELF_MISSES" and WF_STATUS ) then
		if ( WF_LEFT > 0 and WF_NOW_TIME > GetTime() ) then
			WF_LEFT = WF_LEFT - 1;
		else
			TWF_AddValue("HITS",1,"SESSION");
			TWF_AddValue("WF_ALL_HITS",1,"LIFETIME");
		end
	end
	if ( event == "CHAT_MSG_COMBAT_SELF_HITS" and WF_STATUS ) then
		if ( WF_LEFT > 0 and WF_NOW_TIME > GetTime() ) then
			--TWF_DB("WF hits");
			tdamage = 0;
			WF_SHIT = 0;
			for creatureName, tdamage in string.gfind(arg1, WF_loc_YOUHIT) do
				WF_THIS = WF_THIS + tdamage;
				WF_SHIT = WF_SHIT + tdamage;
				TWF_AddValue("WF_ALL_TOTAL",tdamage,"LIFETIME");
				TWF_AddValue("TOTAL",tdamage,"SESSION");

			end

			for creatureName, tdamage in string.gfind(arg1, WF_loc_YOUCRIT) do
				WF_THIS = WF_THIS + tdamage;
				WF_SHIT = WF_SHIT + tdamage;
				WF_CRIT = WF_CRIT + 1;

				TWF_AddValue("WF_ALL_TOTAL",tdamage,"LIFETIME");
				TWF_AddValue("TOTAL",tdamage,"SESSION");

				TWF_AddValue("CRITS",1,"SESSION");
				TWF_AddValue("WF_ALL_CRITS",1,"LIFETIME");
			end
			WF_LEFT = WF_LEFT - 1;
			if ( WF_SHIT > WF[WF_WEAPON_NAME]["SHIT"] ) then
				WF[WF_WEAPON_NAME]["SHIT"] = WF_SHIT;
				TWF_DB("Setting best single hit to (session): "..WF_SHIT);
			end
			if ( WF_SHIT > TWFS[WF_WEAPON_NAME]["WF_ALL_SHIT"] ) then
				TWFS[WF_WEAPON_NAME]["WF_ALL_SHIT"] = WF_SHIT;
				TWF_DB("Setting best single hit to (lifetime): "..WF_SHIT);
			end
			if ( WF_LEFT < 1 ) then
				WF[WF_WEAPON_NAME]["CRIT"][5] = WF[WF_WEAPON_NAME]["CRIT"][4];
				WF[WF_WEAPON_NAME]["CRIT"][4] = WF[WF_WEAPON_NAME]["CRIT"][3];
				WF[WF_WEAPON_NAME]["CRIT"][3] = WF[WF_WEAPON_NAME]["CRIT"][2];
				WF[WF_WEAPON_NAME]["CRIT"][2] = WF[WF_WEAPON_NAME]["CRIT"][1];
				WF[WF_WEAPON_NAME]["CRIT"][1] = WF_CRIT;

				WF[WF_WEAPON_NAME]["LAST"][5] = WF[WF_WEAPON_NAME]["LAST"][4];
				WF[WF_WEAPON_NAME]["LAST"][4] = WF[WF_WEAPON_NAME]["LAST"][3];
				WF[WF_WEAPON_NAME]["LAST"][3] = WF[WF_WEAPON_NAME]["LAST"][2];
				WF[WF_WEAPON_NAME]["LAST"][2] = WF[WF_WEAPON_NAME]["LAST"][1];
				WF[WF_WEAPON_NAME]["LAST"][1] = WF_THIS;

				WF_CRIT = 0;
				if ( TitanGetVar(WF_ID, "WF_OPT_SCTDI") ) then
					SCT_Display_Only("SHOWHIT", "WindFury: "..WF[WF_WEAPON_NAME]["LAST"][1], 1);
				end
			end
			if ( WF[WF_WEAPON_NAME]["LAST"][1] > WF[WF_WEAPON_NAME]["BEST"] ) then
				WF[WF_WEAPON_NAME]["BEST"] = WF[WF_WEAPON_NAME]["LAST"][1];
			end
			if ( WF[WF_WEAPON_NAME]["LAST"][1] > TWFS[WF_WEAPON_NAME]["WF_ALL_BEST"] ) then
				TWFS[WF_WEAPON_NAME]["WF_ALL_BEST"] = WF[WF_WEAPON_NAME]["LAST"][1];
				TWF_DB("Setting best to: "..TWFS[WF_WEAPON_NAME]["WF_ALL_BEST"]);
			end

			return;
		else
			TWF_AddValue("HITS",1,"SESSION");
			TWF_AddValue("WF_ALL_HITS",1,"LIFETIME");

			--TWF_DB("Hits: "..WF[WF_WEAPON_NAME]["HITS"]);
		end

	end
end

-- End: TWF OnEvent
-- ****************************************************************************************************

-- ****************************************************************************************************
-- Start: TWF Functions

function TWF_AddValue(var,val,type)
	if ( type == "LIFETIME" ) then
		TWFS[WF_WEAPON_NAME][var] = TWFS[WF_WEAPON_NAME][var] + val;
	end
	if ( type == "SESSION" ) then
		WF[WF_WEAPON_NAME][var] = WF[WF_WEAPON_NAME][var] + val;
	end
end
function TWF_Init()

	this:RegisterEvent("PLAYER_DEAD");
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("UNIT_INVENTORY_CHANGED");
	this:RegisterEvent("CHAT_MSG_SPELL_SELF_BUFF");
	this:RegisterEvent("CHAT_MSG_COMBAT_SELF_HITS");
	this:RegisterEvent("CHAT_MSG_COMBAT_SELF_MISSES");

	if ( TWFS["UPDATE"] == nil or TWFS["UPDATE"] ~= WF_VERSION ) then
		
		TWFS["VERSION"] = WF_VERSION;
		TWFS["UPDATE"] = WF_VERSION;

		TWF_DB("Installed "..WF_VERSION.." succesfully!");

	end

	TWF_WeaponCheck();

end
function TWF_Setup(weapon,type)
	if ( type == "LIFETIME" ) then
		nw = nil;
		nw = {}
		nw.WF_ALL_TOTAL = 0;
		nw.WF_ALL_PROCS = 0;
		nw.WF_ALL_HITS = 0;
		nw.WF_ALL_CRITS = 0;
		nw.WF_ALL_BEST = 0;
		nw.WF_ALL_SHIT = 0;

		TWFS[weapon] = nw;

		TWF_DB("Setting up lifetime data for: "..weapon);
	end
	if ( type == "SESSION" ) then
		nw = nil;
		nw = {}
		nw.BEST = 0;
		nw.LAST = { 0,0,0,0,0 }
		nw.CRIT = { 0,0,0,0,0 }
		nw.HITS = 0;
		nw.CRITS = 0;
		nw.PROCS = 0;
		nw.TOTAL = 0;
		nw.SHIT = 0;

		WF[weapon] = nw;

		TWF_DB("Setting up session data for: "..weapon);
	end
end
function TWF_WeaponCheck()
	WF_STATUS = TWF_IsBuffWF();
	mainHandLink = GetInventoryItemLink("player",GetInventorySlotInfo("MainHandSlot"));
	if ( mainHandLink == nil ) then
		itemName = "none";
		WF_WEAPON_NAME = "none";
	else
		_, _, itemCode = strfind(mainHandLink, "(%d+):");
		itemName = GetItemInfo(itemCode);
	end
	if ( WF_WEAPON_NAME ~= itemName ) then
		TWF_DB("Weapon changed to: "..itemName);
		WF_WEAPON_NAME = itemName;
	end
	if ( TWFS[WF_WEAPON_NAME] == nil ) then
		TWF_Setup(WF_WEAPON_NAME, "LIFETIME");
	end
	if ( WF[WF_WEAPON_NAME] == nil ) then
		TWF_Setup(WF_WEAPON_NAME, "SESSION");
	end
	if ( TWFS[WF_WEAPON_NAME]["WF_ALL_SHIT"] == nil ) then
		TWFS[WF_WEAPON_NAME]["WF_ALL_SHIT"] = 0;
		TWF_DB("Added WF_ALL_SHIT to weapon: "..WF_WEAPON_NAME);
	end
	return;
end
function TWF_IsBuffWF()
	if (GetWeaponEnchantInfo()) then
		TWF_TempTooltip:SetOwner(TWF_TempTooltip, "ANCHOR_NONE")

		slotID, _ = GetInventorySlotInfo("MainHandSlot")
		hasItem = TWF_TempTooltip:SetInventoryItem("player", slotID)

		if (hasItem) then
			local twf_dpssearch,twf_dummy,twf_tempdps;
			local lines = TWF_TempTooltip:NumLines();
			--TWF_DB("Numlines: "..lines);
			for i = 1, lines, 1 do

				local textobj = getglobal(TWF_TempTooltip:GetName() .. "TextLeft" .. i);
				local textstr = textobj:GetText();
				if ( textstr ) then
					--TWF_DB("Read("..i.."/"..lines.."): "..textstr);
					-- Extract DPS info
					twf_dpssearch, twf_dummy, twf_tempdps = string.find(textstr, "^%((%d+%.?%d*) [%a%s]+%)");
					if ( twf_dpssearch ~= nil ) and ( twf_tempdps ~= nil ) then
						TWF_DB("Found dps info. ("..textstr..") in line "..i.." -> "..twf_tempdps);
						WF_DPS = twf_tempdps;
					end
					-- Look for an enchant we know
					if ( string.find(textstr, "^"..WF_loc_SPELLNAME_TOTEM.."([^%(]+)%s*%(?.*%)?$") ) then
						TWF_DB("WF Totem Enchant found.");
						return false;
					elseif ( string.find(textstr, "^"..WF_loc_SPELLNAME.."([^%(]+)%s*%(?.*%)?$") ) then
						TWF_DB("WF Enchant found.");
						return true;
					end
				end
			end
			TWF_DB("WF Enchant NOT found.");
		else
			TWF_DB("isBuffWF-hasItem is false");
		end

		return false;
	else
		TWF_DB("No Enchant found at all.");
		return false;
	end
end
function TWF_oldIsBuffWF()
	local hasMainHandEnchant = GetWeaponEnchantInfo();
 	if ( hasMainHandEnchant == 0 ) then 
		return false; 
	end
	local slotid,hasItem,lines;
	TWF_TempTooltip:SetOwner(UIParent, "ANCHOR_NONE");
	slotid, _ = GetInventorySlotInfo("MainHandSlot");
	hasItem = TWF_TempTooltip:SetInventoryItem("player", slotid);
	lines = TWF_TempTooltip:NumLines(); 
	if ( hasItem ) then
		for i = 1, lines, 1 do			
			tmpText = getglobal("TWF_TempTooltipTextLeft"..i);
			if ( tmpText:GetText() ) then
				tmpText = tmpText:GetText();
				if (i == 5) then
					WF_DPS = string.sub(tmpText,2,5);
				end
				if ( tmpText ) then
 					iStart, iEnd = string.find(tmpText, "^"..WF_loc_SPELLNAME.."([^%(]+) %(.+%)$");
					if ( iStart ) then
						return true; 
					end
				end
			end
		end
	end
	return false;
end
function TWF_DB(msg)
	if ( TitanGetVar(WF_ID, "WF_OPT_DEBUG") ) then
		msg = "|cff50ff50[TWF]: |cffb0ffb0" .. msg;
		DEFAULT_CHAT_FRAME:AddMessage(msg);
	end
end

-- End: TWF Functions
-- ****************************************************************************************************


-- ****************************************************************************************************
-- Start: TitanPanel Registers

function TitanWindFuryButton_OnLoad()
	this.registry={
		id=WF_ID,
		version = WF_VERSION..".11000",
		category = "Combat",
		menuText=WF_loc_TITLE,
		buttonTextFunction="TitanWindFuryButton_GetButtonText",
		frequency = 1,
		tooltipTitle = WF_loc_TOOLTITLE,
		tooltipTextFunction = "TitanWindFury_GetTooltipText",
		savedVariables = {
			showIcon = 1,
			WF_OPT_DTEXT = 1,
			WF_OPT_DBEST = 1,
			WF_OPT_DLAST = 1,
			WF_OPT_DFIVE = 1,
			WF_OPT_DEBUG = TITAN_NIL,
			WF_OPT_SCTDI = TITAN_NIL,
		}
	};
end
function TitanWindFuryButton_DeleteStats()
	WF[WF_WEAPON_NAME] = {}
	TWFS[WF_WEAPON_NAME] = {}
	TWF_DB(WF_loc_DELETED);
	TWF_Setup(WF_WEAPON_NAME, "SESSION");
	TWF_Setup(WF_WEAPON_NAME, "LIFETIME");
end
function TitanWindFuryButton_GetButtonText()
	--TWF_DB("Updating button text!");
	local str = WF_loc_SHORTTITLE.." ";
	if ( TitanGetVar(WF_ID, "WF_OPT_DTEXT") ) then

		if ( TitanGetVar(WF_ID, "WF_OPT_DLAST") ) then
			str = str .. WF_loc_LAST ..": |c00FFFFFF" .. WF[WF_WEAPON_NAME]["LAST"][1] .. "|r";
		end
		if ( TitanGetVar(WF_ID, "WF_OPT_DBEST") ) then
			if ( strlen(str) > 4 ) then
				str = str .. "  ";
			end
			str = str .. WF_loc_BEST ..": |c00FFFFFF" .. TWFS[WF_WEAPON_NAME]["WF_ALL_BEST"] .. "|r";
		end
		if ( WF_STATUS ) then
			str = str .. " " .. WF_loc_STATUS .. ": |cff20ff20ON|r";
		else
			str = str .. " " .. WF_loc_STATUS .. ": |cffff2020OFF|r";
		end
	else
		if ( TitanGetVar(WF_ID, "WF_OPT_DLAST") ) then
			str = str .. "(|c00FFFFFF" .. WF[WF_WEAPON_NAME]["LAST"][1] .. "|r) - ";
		end
		if ( TitanGetVar(WF_ID, "WF_OPT_DBEST") ) then			
			str = str .. "(|c00FFFFFF" .. TWFS[WF_WEAPON_NAME]["WF_ALL_BEST"] .. "|r) - ";
		end
		if ( WF_STATUS ) then
			str = str .. "(|cff20ff20ON|r)";
		else
			str = str .. "(|cffff2020OFF|r)";
		end
	end
	return str;
end
function TitanWindFury_GetTooltipText()
	if (WF[WF_WEAPON_NAME]["TOTAL"] == 0) then
		WF_AVERAGE = "0";
	else
		WF_AVERAGE = ceil(WF[WF_WEAPON_NAME]["TOTAL"] / WF[WF_WEAPON_NAME]["PROCS"]);
	end
	if (TWFS[WF_WEAPON_NAME]["WF_ALL_TOTAL"] == 0) then
		WF_ALL_AVERAGE = "0";
	else
		WF_ALL_AVERAGE = ceil(TWFS[WF_WEAPON_NAME]["WF_ALL_TOTAL"] / TWFS[WF_WEAPON_NAME]["WF_ALL_PROCS"]);
	end
	if (WF[WF_WEAPON_NAME]["CRITS"] == 0) then
		WF_OUT_CRITS = "0";
	else
		WF_OUT_CRITS = ceil((WF[WF_WEAPON_NAME]["CRITS"] / (WF[WF_WEAPON_NAME]["PROCS"]*3))*100);
	end
	if (WF[WF_WEAPON_NAME]["PROCS"] == 0) then
		WF_OUT_PROCS = "0";
	else
		WF_OUT_PROCS = ceil((WF[WF_WEAPON_NAME]["PROCS"] / WF[WF_WEAPON_NAME]["HITS"])*100);
	end
	if (TWFS[WF_WEAPON_NAME]["WF_ALL_PROCS"] == 0) then
		WF_ALL_OUT_PROCS = "0";
	else
		WF_ALL_OUT_PROCS = ceil((TWFS[WF_WEAPON_NAME]["WF_ALL_PROCS"] / TWFS[WF_WEAPON_NAME]["WF_ALL_HITS"])*100);
	end
	if (TWFS[WF_WEAPON_NAME]["WF_ALL_CRITS"] == 0) then
		WF_ALL_OUT_CRITS = "0";
	else
		WF_ALL_OUT_CRITS = ceil((TWFS[WF_WEAPON_NAME]["WF_ALL_CRITS"] / (TWFS[WF_WEAPON_NAME]["WF_ALL_PROCS"]*3))*100);
	end
	
	out_put = "\n|c00FFFFFF"..WF_WEAPON_NAME.."|r\t|c00FFFFFF"..WF_DPS.." DPS|r\n\n|c00FFFFFF"..WF_loc_SESSION.."|r";

	if ( TitanGetVar(WF_ID, "WF_OPT_DFIVE") ) then
		
		out_put = out_put .. "\n"..WF_loc_LASTFIR..": \t|c00FFFFFF("..WF[WF_WEAPON_NAME]["CRIT"][1]..") "..WF[WF_WEAPON_NAME]["LAST"][1].."|r";
		out_put = out_put .. "\n"..WF_loc_LASTSEC..": \t|c00FFFFFF("..WF[WF_WEAPON_NAME]["CRIT"][2]..") "..WF[WF_WEAPON_NAME]["LAST"][2].."|r";
		out_put = out_put .. "\n"..WF_loc_LASTTHI..": \t|c00FFFFFF("..WF[WF_WEAPON_NAME]["CRIT"][3]..") "..WF[WF_WEAPON_NAME]["LAST"][3].."|r";
		out_put = out_put .. "\n"..WF_loc_LASTFOU..": \t|c00FFFFFF("..WF[WF_WEAPON_NAME]["CRIT"][4]..") "..WF[WF_WEAPON_NAME]["LAST"][4].."|r";
		out_put = out_put .. "\n"..WF_loc_LASTFIF..": \t|c00FFFFFF("..WF[WF_WEAPON_NAME]["CRIT"][5]..") "..WF[WF_WEAPON_NAME]["LAST"][5].."|r\n";

	else
		out_put = out_put .. "\n"..WF_loc_LAST..": \t|c00FFFFFF("..WF[WF_WEAPON_NAME]["CRIT"][1]..") "..WF[WF_WEAPON_NAME]["LAST"][1].."|r";
	end

	out_put = out_put .. "\n"..WF_loc_SHIT..": \t|c00FFFFFF"..WF[WF_WEAPON_NAME]["SHIT"].."|r";
	out_put = out_put .. "\n"..WF_loc_BEST..": \t|c00FFFFFF"..WF[WF_WEAPON_NAME]["BEST"].."|r";
	out_put = out_put .. "\n"..WF_loc_PROCS..": \t|c00FFFFFF("..WF[WF_WEAPON_NAME]["PROCS"]..") "..WF_OUT_PROCS.."|r%";
	out_put = out_put .. "\n"..WF_loc_CRITS..": \t|c00FFFFFF("..WF[WF_WEAPON_NAME]["CRITS"]..") "..WF_OUT_CRITS.."|r%";
	out_put = out_put .. "\n"..WF_loc_AVERAGE..": \t|c00FFFFFF"..WF_AVERAGE.."|r";
	out_put = out_put .. "\n"..WF_loc_TOTAL..": \t|c00FFFFFF"..WF[WF_WEAPON_NAME]["TOTAL"].."|r\n";
	out_put = out_put .. "\n|c00FFFFFF"..WF_loc_LIFETIME.."|r";
	out_put = out_put .. "\n"..WF_loc_SHIT..": \t|c00FFFFFF"..TWFS[WF_WEAPON_NAME]["WF_ALL_SHIT"].."|r";
	out_put = out_put .. "\n"..WF_loc_BEST..": \t|c00FFFFFF"..TWFS[WF_WEAPON_NAME]["WF_ALL_BEST"].."|r";
	out_put = out_put .. "\n"..WF_loc_PROCS..": \t|c00FFFFFF("..TWFS[WF_WEAPON_NAME]["WF_ALL_PROCS"]..") "..WF_ALL_OUT_PROCS.."|r%";
	out_put = out_put .. "\n"..WF_loc_CRITS..": \t|c00FFFFFF("..TWFS[WF_WEAPON_NAME]["WF_ALL_CRITS"]..") "..WF_ALL_OUT_CRITS.."|r%";
	out_put = out_put .. "\n"..WF_loc_AVERAGE..": \t|c00FFFFFF"..WF_ALL_AVERAGE.."|r";
	out_put = out_put .. "\n"..WF_loc_TOTAL..": \t|c00FFFFFF"..TWFS[WF_WEAPON_NAME]["WF_ALL_TOTAL"].."|r";
	
	out_put = out_put .. "\n"..TitanUtils_GetGreenText("Hint: Shift + left-click to add stats").."\n"..TitanUtils_GetGreenText("info into chat message.");
	return out_put;
end
function TitanPanelWindFury_ToggleVar()
	TitanToggleVar(WF_ID, this.value);
	TitanPanelButton_UpdateButton(WF_ID);
end
function TitanPanelWindFuryButton_OnClick(button)
	if (button == "LeftButton" and IsShiftKeyDown()) then
		if (ChatFrameEditBox:IsVisible()) then
			message = WF_WEAPON_NAME.." Stats - Best WF: "..TWFS[WF_WEAPON_NAME]["WF_ALL_BEST"].." - Average WF dmg: "..WF_ALL_AVERAGE.." - Best hit during WF: "..TWFS[WF_WEAPON_NAME]["WF_ALL_SHIT"];
			ChatFrameEditBox:Insert(message);
		end
	end
end
function TitanPanelRightClickMenu_PrepareWindFuryMenu()

	if ( UIDROPDOWNMENU_MENU_LEVEL == 2 ) then
		if ( UIDROPDOWNMENU_MENU_VALUE == "WFDispOptions" ) then

			TitanPanelRightClickMenu_AddTitle(WF_loc_DISPOPTIONS, UIDROPDOWNMENU_MENU_LEVEL);

			-- Show Last Windfury Hit
			info = {};
			info.text = WF_loc_DISPLASTWFHIT;
			info.value = "WF_OPT_DLAST";
			info.func = TitanPanelWindFury_ToggleVar;
			info.checked = TitanGetVar(WF_ID, "WF_OPT_DLAST");
			info.keepShownOnClick = 1;
			UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

			-- Show Last Windfury Hit
			info = {};
			info.text = WF_loc_DISPBESTWFHIT;
			info.value = "WF_OPT_DBEST";
			info.func = TitanPanelWindFury_ToggleVar;
			info.checked = TitanGetVar(WF_ID, "WF_OPT_DBEST");
			info.keepShownOnClick = 1;
			UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

			-- Show Last Windfury Hit
			info = {};
			info.text = WF_loc_DISPSCTDISP;
			info.value = "WF_OPT_SCTDI";
			info.func = TitanPanelWindFury_ToggleVar;
			info.checked = TitanGetVar(WF_ID, "WF_OPT_SCTDI");
			info.keepShownOnClick = 1;
			UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

			TitanPanelRightClickMenu_AddSpacer(UIDROPDOWNMENU_MENU_LEVEL);

			-- Debug text
			info = {};
			info.text = WF_loc_DISPDEBUGTEXT;
			info.value = "WF_OPT_DEBUG";
			info.func = TitanPanelWindFury_ToggleVar;
			info.checked = TitanGetVar(WF_ID, "WF_OPT_DEBUG");
			info.keepShownOnClick = 1;
			UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);


		end
		if ( UIDROPDOWNMENU_MENU_VALUE == "WFToolOptions" ) then

			TitanPanelRightClickMenu_AddTitle(WF_loc_TOOLOPTIONS, UIDROPDOWNMENU_MENU_LEVEL);

			-- Show 5 Last WF's
			info = {};
			info.text = WF_loc_DISPFIVELAST;
			info.value = "WF_OPT_DFIVE";
			info.func = TitanPanelWindFury_ToggleVar;
			info.checked = TitanGetVar(WF_ID, "WF_OPT_DFIVE");
			info.keepShownOnClick = 1;
			UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);


		end
		return;
	end

	TitanPanelRightClickMenu_AddTitle(TitanPlugins[WF_ID].menuText);


	-- Show label text
	info = {};
	info.text = WF_loc_DISPTEXTLABELS;
	info.value = "WF_OPT_DTEXT";
	info.func = TitanPanelWindFury_ToggleVar;
	info.checked = TitanGetVar(WF_ID, "WF_OPT_DTEXT");
	info.keepShownOnClick = 1;
	UIDropDownMenu_AddButton(info);


	TitanPanelRightClickMenu_AddSpacer();


	-- Display Options
	info = {};
	info.text = WF_loc_DISPOPTIONS;
	info.value = "WFDispOptions";
	info.hasArrow = 1;
	UIDropDownMenu_AddButton(info);

	-- Tooltip Options
	info = {};
	info.text = WF_loc_TOOLOPTIONS;
	info.value = "WFToolOptions";
	info.hasArrow = 1;
	UIDropDownMenu_AddButton(info);


	TitanPanelRightClickMenu_AddSpacer();

	-- Delete Stats
	info = {};
	info.text = WF_loc_DELETESTATS;
	info.func = TitanWindFuryButton_DeleteStats;
	info.checked = nil;
	UIDropDownMenu_AddButton(info);

	TitanPanelRightClickMenu_AddSpacer();
	TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, WF_ID, TITAN_PANEL_MENU_FUNC_HIDE);

end

-- End: TitanPanel Registers
-- ****************************************************************************************************
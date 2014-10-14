--[[
TitanTradeCooldown v0.33 (11200)
	By tsigo, goliathvt, and totalpackage

	Lists tradeskill cooldowns across all characters.

	Features
		- TitanPanel module
		- At-a-glance view of the status of tradeskills with cooldowns (Mooncloth/Transmutes)

	Thanks
		- WoW Wiki for the excellent resource

	ChangeLog
	v0.35 09/18/06
		- Added Aglarfuin's Evergreen Pouch support and made it optional (disabled by default)
		- Updated some localization (untested), thanks worldofwar and curse community
		- Some memory/performance optimizations
		- Fixed bug (again) that cause alert to go off multiple times.
		- TOC updated for 1.12
	
	v0.33 05/21/06
		- Fixed bug where alerts kept firing when tradeskill window is open.
		- Added option to show only current realm's cooldowns.
		- Minor tooltip reformatting.
		- Possible German support added.  Thanks Katano.
		
	v0.32 04/02/06
		- Added Elune's Lantern
		- Disabled FR localization (need updates please!)
		- TOC updated for 1.10   
    
	v0.31 02/01/06
		- Changed the way Snow and Salt are recorded due to possible issues from server resets
		- Added notification when ready or almost ready
		- Some French localization, will need more
            
	v0.3 01/25/06
		- Added support for the Engineer's SnowMaster 9000 cooldown by totalpackage
		- Added an option to clear all data.
		- Additional UI Tweaks.
        
	v0.21 10/07/05
		- Added support for the Leatherworker's Salt Shaker cooldown by goliathvt

	v0.2 09/23/05
		- Changed time() calls to the correct time(), thanks Thorarin

	v0.1 09/22/05
		- Initial release.

]]--

-- Global Vars
TITAN_TRADECOOLDOWN_ID = "TradeCooldown";
TITAN_TRADECOOLDOWN_READY_COLOR = "|cff00FF00";
TITAN_TRADECOOLDOWN_NOTREADY_COLOR = "|cffFF0000";
TITAN_TRADECOOLDOWN_ALMOSTREADY_COLOR = "|cffF0F000";

--Time remaining to notify if the cooldown is almost ready
TITAN_TRADECOOLDOWN_NOTIFYTIME = 60;

-- Localization
-- For some stupid reason I couldn't get this to work with a localization.lua file, 
-- and yes I updated the XML file to include it.  These strings are here more as a 
-- "look to the future" and maybe later I can have translations.
TITAN_TRADECOOLDOWN_BUTTON_LABEL = "TradeCooldown: ";
TITAN_TRADECOOLDOWN_TOOLTIP_LABEL = "TradeCooldown";
TITAN_TRADECOOLDOWN_FORMAT = "%d/%d";
TITAN_TRADECOOLDOWN_READY = "Ready!";
TITAN_TRADECOOLDOWN_MOONCLOTH = "Mooncloth";
TITAN_TRADECOOLDOWN_SALTSHAKER = "Salt Shaker";
TITAN_TRADECOOLDOWN_REFINEDSALT = "Refined Deeprock Salt";
TITAN_TRADECOOLDOWN_SNOWMASTER = "SnowMaster 9000";
TITAN_TRADECOOLDOWN_SNOWBALL = "Snowball";
TITAN_TRADECOOLDOWN_EVERGREENPOUCH = "Evergreen Pouch";
TITAN_TRADECOOLDOWN_EVERGREENHERBCASING = "Evergreen Herb Casing";
TITAN_TRADECOOLDOWN_ELUNESLANTERN = "Elune's Lantern";
TITAN_TRADECOOLDOWN_ELUNESTONE = "Elune Stone";
TITAN_TRADECOOLDOWN_TRANSMUTE_MATCH = "Transmute";
TITAN_TRADECOOLDOWN_TRANSMUTES = "Transmutes";
TITAN_TRADECOOLDOWN_CONFIRM = "Are you sure you want to clear all data for Titan TradeCooldown?";
TITAN_TRADECOOLDOWN_NODATA = "No Data";
TITAN_TRADECOOLDOWN_NOTIFYENABLE = "Enable Alert";
TITAN_TRADECOOLDOWN_CURRENTREALM = "Show Only Current Realm";
TITAN_TRADECOOLDOWN_SHOWEVERGREEN = "Enable Evergreen Pouch";
TITAN_TRADECOOLDOWN_CLEARALL = "Clear all data";
TITAN_TRADECOOLDOWN_CREATESEARCH = "You create (.*).";
TITAN_TRADECOOLDOWN_READYNOTIFY0 = "|cff00FF00TradeCooldown:|r %s for %s:%s is ready.";
TITAN_TRADECOOLDOWN_READYNOTIFY1 = "|cff00FF00TradeCooldown:|r %s for %s:%s will be ready in %ss.";
TITAN_TRADECOOLDOWN_WARN = "|cff00FF00TradeCooldown:|r Item created while tradeskill window is closed; mooncloth/transmutes cooldown may not update until you reopen the window.";


if ( GetLocale() == "deDE" ) then
	TITAN_TRADECOOLDOWN_BUTTON_LABEL = "TradeCooldown: ";
	TITAN_TRADECOOLDOWN_TOOLTIP_LABEL = "TradeCooldown";
	TITAN_TRADECOOLDOWN_FORMAT = "%d/%d";
	TITAN_TRADECOOLDOWN_READY = "Fertig!";
	TITAN_TRADECOOLDOWN_MOONCLOTH = "Mondstoff";
	TITAN_TRADECOOLDOWN_SALTSHAKER = "Salzstreuer";
	TITAN_TRADECOOLDOWN_REFINEDSALT = "Raffiniertes Tiefsteinsalz";
	TITAN_TRADECOOLDOWN_SNOWMASTER = "Schneemeister 9000";
	TITAN_TRADECOOLDOWN_SNOWBALL = "Schneeball";
	TITAN_TRADECOOLDOWN_EVERGREENPOUCH = "Immergr\195\188nbeutel";
	TITAN_TRADECOOLDOWN_EVERGREENHERBCASING = "Immergr\195\188nkrautgeh\195\164use";
	TITAN_TRADECOOLDOWN_ELUNESLANTERN = "Elunes Laterne";
	TITAN_TRADECOOLDOWN_ELUNESTONE = "Elunes Stein";
	TITAN_TRADECOOLDOWN_TRANSMUTE_MATCH = "Transmutieren";
	TITAN_TRADECOOLDOWN_TRANSMUTES = "Transmutationen";
	TITAN_TRADECOOLDOWN_CONFIRM = "Sind Sie sicher das Sie alle Daten von Titan TradeCooldown l\195\182schen wollen?";
	TITAN_TRADECOOLDOWN_NODATA = "Keine Daten";
	TITAN_TRADECOOLDOWN_CLEARALL = "Alle Daten l\195\182schen";
	--TITAN_TRADECOOLDOWN_CREATESEARCH = "Ihr stellt her (.*).";
	TITAN_TRADECOOLDOWN_CREATESEARCH = "Ihr erschafft (.*).";
	TITAN_TRADECOOLDOWN_READYNOTIFY0 = "|cff00FF00TradeCooldown:|r %s f\195\188r %s:%s ist bereit.";
	TITAN_TRADECOOLDOWN_READYNOTIFY1 = "|cff00FF00TradeCooldown:|r %s f\195\188r %s:%s wird in %ss bereit sein.";
	
elseif ( GetLocale() == "frFR" ) then
	TITAN_TRADECOOLDOWN_BUTTON_LABEL = "TradeCooldown: ";
	TITAN_TRADECOOLDOWN_TOOLTIP_LABEL = "TradeCooldown";
	TITAN_TRADECOOLDOWN_FORMAT = "%d/%d";
	TITAN_TRADECOOLDOWN_READY = "Pr\195\170t!";
	TITAN_TRADECOOLDOWN_MOONCLOTH = "Etoffe lunaire";
	TITAN_TRADECOOLDOWN_SALTSHAKER = "Tamis \195\160 sel";
	TITAN_TRADECOOLDOWN_REFINEDSALT = "Sel";
	TITAN_TRADECOOLDOWN_SNOWMASTER = "Ma\195\174treNeige 9000";
	TITAN_TRADECOOLDOWN_SNOWBALL = "Neige";
	TITAN_TRADECOOLDOWN_EVERGREENPOUCH = "Sacoche de printemps";
	TITAN_TRADECOOLDOWN_EVERGREENHERBCASING = "Jardini\232res de printemps";
	TITAN_TRADECOOLDOWN_ELUNESLANTERN = "Lanterne d'Elune";
	TITAN_TRADECOOLDOWN_ELUNESTONE = "Pierre d'Elune";
	TITAN_TRADECOOLDOWN_TRANSMUTE_MATCH = "Transmutation";
	TITAN_TRADECOOLDOWN_TRANSMUTES = "Transmutations";
	TITAN_TRADECOOLDOWN_CONFIRM = "Etes vous s\195\187re de vouloir effacer toutes les informations de Titan TradeCooldown?";
	TITAN_TRADECOOLDOWN_NODATA = "Pas de donn\195\169es";
	TITAN_TRADECOOLDOWN_NOTIFYENABLE = "Autoriser les alertes";
	TITAN_TRADECOOLDOWN_CURRENTREALM = "Montrer seulement le royaume courant";
	TITAN_TRADECOOLDOWN_CLEARALL = "Effacer les donn\195\169es";
	TITAN_TRADECOOLDOWN_CREATESEARCH = "Vous creez (.*).";
	TITAN_TRADECOOLDOWN_READYNOTIFY0 = "|cff00FF00TradeCooldown:|r %s pour %s:%s est pr\195\170t.";
	TITAN_TRADECOOLDOWN_READYNOTIFY1 = "|cff00FF00TradeCooldown:|r %s pour %s:%s sera pr\195\170t dans %ss.";
	TITAN_TRADECOOLDOWN_WARN = "|cff00FF00TradeCooldown:|r Les cooldown des objets cre\195\169 alors que la fen\196\170tre d'artisanat est ferm\195\169 ne seront pas \195\160 jour jusqu'a rouverture de la fen\195\180tre";
end


TTC_Save    = {};
TTC_SaveKey = "";

-- {{{ TitanPanelTradeCooldownButton_OnLoad()

function TitanPanelTradeCooldownButton_OnLoad()
    -- Titan Panel Registry
    this.registry = {
        id = TITAN_TRADECOOLDOWN_ID,
        menuText = TITAN_TRADECOOLDOWN_TOOLTIP_LABEL,
        buttonTextFunction = "TitanPanelTradeCooldownButton_GetButtonText",
        tooltipTitle = TITAN_TRADECOOLDOWN_TOOLTIP_LABEL,
        tooltipTextFunction = "TitanPanelTradeCooldownButton_GetTooltipText",
        category = "Profession",
        icon = "Interface\\Icons\\Spell_Nature_TimeStop.blp",
        iconWidth = 16,
        savedVariables = {
            ShowIcon = 1,
            ShowLabelText = TITAN_NIL,
            NotifyEnable = 1,
            ShowOnlyCurrentRealm = TITAN_NIL,
            ShowEvergreen = TITAN_NIL,
        }
    };
    
    -- Events
    this:RegisterEvent("TRADE_SKILL_UPDATE");
    this:RegisterEvent("CHAT_MSG_SPELL_TRADESKILLS");
    this:RegisterEvent("CHAT_MSG_LOOT");

    -- Variables
    TTC_SaveKey = GetCVar("realmName") .. "|" .. UnitName("player");
end

-- }}}
-- {{{ TitanPanelTradeCooldownButton_OnEvent()

function TitanPanelTradeCooldownButton_OnEvent(event)
	if ( event == "TRADE_SKILL_UPDATE" ) then
		-- This is when the TTC_Save table is populated
		local numSkills = GetNumTradeSkills();
		for i=1, numSkills do
			local skillName = GetTradeSkillInfo(i);
			local cooldown = GetTradeSkillCooldown(i);

			-- Condense all transmute entries into one, since they share a cooldown
			if ( string.find(skillName, TITAN_TRADECOOLDOWN_TRANSMUTE_MATCH) ) then
				skillName = TITAN_TRADECOOLDOWN_TRANSMUTES;
			end

			if ( skillName == TITAN_TRADECOOLDOWN_TRANSMUTES or skillName == TITAN_TRADECOOLDOWN_MOONCLOTH ) then
				if ( cooldown == nil ) then
					cooldown = 0;
				end

				-- If this Realm/Player combination doesn't have a table entry, make one.
				if ( TTC_Save[TTC_SaveKey] == nil ) then
					TTC_Save[TTC_SaveKey] = {};
				end

				-- By now the SaveKey entry has either been verified as existing, or has been created
				-- Do the same for the skillName entry
				if ( TTC_Save[TTC_SaveKey][skillName] == nil ) then
					TTC_Save[TTC_SaveKey][skillName] = {};
				end

				-- SaveKey and skillName tables exist
				-- Store the remaining cooldown on the skill, and a timestamp of when this was saved
				-- so we can calculate if the skill is ready or not based on what its cooldown was
				-- when we last saw it.
				TTC_Save[TTC_SaveKey][skillName].Cooldown = cooldown;
				if not (TTC_Save[TTC_SaveKey][skillName].Cooldown <= 60 and TTC_Save[TTC_SaveKey][skillName].IsReady == 1) then
					TTC_Save[TTC_SaveKey][skillName].LastCheck = time();
					TTC_Save[TTC_SaveKey][skillName].IsReady = 0; 
				end
			end
		end
	elseif ( event == "CHAT_MSG_SPELL_TRADESKILLS" ) then
		local _, _, created = string.find(arg1, TITAN_TRADECOOLDOWN_CREATESEARCH);
		if ( created and string.find(created, TITAN_TRADECOOLDOWN_SNOWBALL) ) then
			local skillName = TITAN_TRADECOOLDOWN_SNOWMASTER;
			if ( TTC_Save[TTC_SaveKey] == nil ) then
				TTC_Save[TTC_SaveKey] = {};
			end
			if ( TTC_Save[TTC_SaveKey][skillName] == nil ) then
				TTC_Save[TTC_SaveKey][skillName] = {};
			end
			TTC_Save[TTC_SaveKey][skillName].Cooldown = 86400;
			TTC_Save[TTC_SaveKey][skillName].LastCheck = time();
			TTC_Save[TTC_SaveKey][skillName].IsReady = 0;
		elseif ( created and string.find(created, TITAN_TRADECOOLDOWN_REFINEDSALT) ) then
			local skillName = TITAN_TRADECOOLDOWN_SALTSHAKER;
			if ( TTC_Save[TTC_SaveKey] == nil ) then
				TTC_Save[TTC_SaveKey] = {};
			end
			if ( TTC_Save[TTC_SaveKey][skillName] == nil ) then
				TTC_Save[TTC_SaveKey][skillName] = {};
			end
			TTC_Save[TTC_SaveKey][skillName].Cooldown = 259200;
			TTC_Save[TTC_SaveKey][skillName].LastCheck = time();
			TTC_Save[TTC_SaveKey][skillName].IsReady = 0; 
		elseif ( created and not TradeSkillFrame:IsVisible() ) then
			DEFAULT_CHAT_FRAME:AddMessage(TITAN_TRADECOOLDOWN_WARN);
		end
	elseif ( event == "CHAT_MSG_LOOT" ) then
		if ( string.find(arg1, TITAN_TRADECOOLDOWN_ELUNESTONE) ) then
			local skillName = TITAN_TRADECOOLDOWN_ELUNESLANTERN;
			if ( TTC_Save[TTC_SaveKey] == nil ) then
				TTC_Save[TTC_SaveKey] = {};
			end
			if ( TTC_Save[TTC_SaveKey][skillName] == nil ) then
				TTC_Save[TTC_SaveKey][skillName] = {};
			end
			TTC_Save[TTC_SaveKey][skillName].Cooldown = 86400;
			TTC_Save[TTC_SaveKey][skillName].LastCheck = time();
			TTC_Save[TTC_SaveKey][skillName].IsReady = 0;
		end
		if ( string.find(arg1, TITAN_TRADECOOLDOWN_EVERGREENHERBCASING) and TitanGetVar(TITAN_TRADECOOLDOWN_ID, "ShowEvergreen") == 1 ) then
			local skillName = TITAN_TRADECOOLDOWN_EVERGREENPOUCH;
			if ( TTC_Save[TTC_SaveKey] == nil ) then
				TTC_Save[TTC_SaveKey] = {};
			end
			if ( TTC_Save[TTC_SaveKey][skillName] == nil ) then
				TTC_Save[TTC_SaveKey][skillName] = {};
			end
			TTC_Save[TTC_SaveKey][skillName].Cooldown = 600;
			TTC_Save[TTC_SaveKey][skillName].LastCheck = time();
			TTC_Save[TTC_SaveKey][skillName].IsReady = 0;
		end
	end
	TitanPanelButton_UpdateButton(TITAN_TRADECOOLDOWN_ID);
	TitanPanelButton_UpdateTooltip();
end

-- }}}
-- {{{ TitanPanelTradeCooldownButton_GetButtonText()

function TitanPanelTradeCooldownButton_GetButtonText(id)
	local retval = "";

	local totalCount = 0;
	local readyCount = 0;

	-- Increment the total number of cooldowns, and the number of "Ready" cooldowns
	for k, v in TTC_Save do
		local _, _, realm, player = string.find(k, "^(.+)\|(.+)$");
        
		if TitanGetVar(TITAN_TRADECOOLDOWN_ID, "ShowOnlyCurrentRealm") ~= 1 or realm == GetRealmName() then
			for skillName, skillTable in v do
				local remaining = ((skillTable.Cooldown + skillTable.LastCheck) - time());

				totalCount = totalCount + 1;

				if ( remaining <= 0 ) then
					readyCount = readyCount + 1;
				end
			end
		end
	end

	-- Color the counts for the label text
	local colorCode = TITAN_TRADECOOLDOWN_READY_COLOR;
	if ( readyCount == 0 ) then
		colorCode = TITAN_TRADECOOLDOWN_NOTREADY_COLOR;
	end

	retval = format(colorCode .. TITAN_TRADECOOLDOWN_FORMAT .. FONT_COLOR_CODE_CLOSE, readyCount, totalCount);

	return TITAN_TRADECOOLDOWN_BUTTON_LABEL, retval;
end

-- }}}
-- {{{ TitanPanelTradeCooldownButton_GetToolTipText()

function TitanPanelTradeCooldownButton_GetTooltipText()
	local retval = "";

	for k, v in TTC_Save do
		local _, _, realm, player = string.find(k, "^(.+)\|(.+)$");
        
		if TitanGetVar(TITAN_TRADECOOLDOWN_ID, "ShowOnlyCurrentRealm") ~= 1 or realm == GetRealmName() then
			local name = "";
			if TitanGetVar(TITAN_TRADECOOLDOWN_ID, "ShowOnlyCurrentRealm") == 1 then
				retval = retval .. player .. "\n";
			else
				retval = retval .. realm .. ": " .. player .. "\n";
			end
			for skillName, skillTable in v do
				local remaining = ((skillTable.Cooldown + skillTable.LastCheck) - time());

				if ( remaining <= 0 ) then
					retval = retval .. TitanUtils_GetHighlightText("  "..skillName..":") .. "\t" .. TITAN_TRADECOOLDOWN_READY_COLOR .. TITAN_TRADECOOLDOWN_READY .. "|r\n";
				else
					local d,h,m,s = ChatFrame_TimeBreakDown(remaining);
					local timeString = string.format("%dd %02dh %02dm %02ds", d, h, m, s);
					if ( (d == 0) and (h == 0) ) then
						retval = retval .. TitanUtils_GetHighlightText("  "..skillName..":") .. "\t" .. TITAN_TRADECOOLDOWN_ALMOSTREADY_COLOR .. timeString .. "|r\n";
					else
						retval = retval .. TitanUtils_GetHighlightText("  "..skillName..":") .. "\t" .. TITAN_TRADECOOLDOWN_NOTREADY_COLOR .. timeString .. "|r\n";
					end
				end
			end
		end

	end
	if( retval == "" ) then
		return TITAN_TRADECOOLDOWN_NODATA.."\n";
	else
		return retval;
	end
end

-- }}}

function TitanPanelRightClickMenu_PrepareTradeCooldownMenu()
	TitanPanelRightClickMenu_AddTitle(TitanPlugins[TITAN_TRADECOOLDOWN_ID].menuText);
	TitanPanelRightClickMenu_AddToggleIcon(TITAN_TRADECOOLDOWN_ID);
	TitanPanelRightClickMenu_AddToggleLabelText(TITAN_TRADECOOLDOWN_ID);

	TitanPanelRightClickMenu_AddSpacer();
	info = {};
	info.text = TITAN_TRADECOOLDOWN_NOTIFYENABLE;
	info.func = TitanPanelTradeCooldown_ToggleNotify;
	info.checked = TitanGetVar(TITAN_TRADECOOLDOWN_ID, "NotifyEnable");
	info.keepShownOnClick = 1;
	UIDropDownMenu_AddButton(info);
	
	info = {};
	info.text = TITAN_TRADECOOLDOWN_CURRENTREALM;
	info.func = TitanPanelTradeCooldown_ToggleRealm;
	info.checked = TitanGetVar(TITAN_TRADECOOLDOWN_ID, "ShowOnlyCurrentRealm");
	info.keepShownOnClick = 1;
	UIDropDownMenu_AddButton(info);
	
	info = {};
	info.text = TITAN_TRADECOOLDOWN_SHOWEVERGREEN;
	info.func = TitanPanelTradeCooldown_ToggleEvergreen;
	info.checked = TitanGetVar(TITAN_TRADECOOLDOWN_ID, "ShowEvergreen");
	info.keepShownOnClick = 1;
	UIDropDownMenu_AddButton(info);

	TitanPanelRightClickMenu_AddSpacer();
	info = {};
	info.text = TITAN_TRADECOOLDOWN_CLEARALL;
	info.func = TitanPanelTradeCooldown_ClearConfirm;
	UIDropDownMenu_AddButton(info);
	
	TitanPanelRightClickMenu_AddSpacer();
	TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, TITAN_TRADECOOLDOWN_ID, TITAN_PANEL_MENU_FUNC_HIDE);
end

function TitanPanelTradeCooldown_Clear()
	TTC_Save = {};
	TitanPanelButton_UpdateButton(TITAN_TRADECOOLDOWN_ID);
end

function TitanPanelTradeCooldown_ClearConfirm()
	StaticPopupDialogs["TITANPANELTRADECOOLDOWN_CLEAR"] = {
		text = TEXT(TITAN_TRADECOOLDOWN_CONFIRM),
		button1 = TEXT(OKAY),
		button2 = TEXT(CANCEL),
		OnAccept = function()
			TitanPanelTradeCooldown_Clear();
		end,
		timeout = 0,
		exclusive = 1
	};
	StaticPopup_Show("TITANPANELTRADECOOLDOWN_CLEAR");
end

local tcelapsed = 0;
function TitanPanelTradeCooldown_OnUpdate(elapsed)
	tcelapsed = tcelapsed + elapsed;
	if tcelapsed < 2 then
		return;
	end
	tcelapsed = 0;
	TitanPanelButton_UpdateButton(TITAN_TRADECOOLDOWN_ID);
	if( TitanGetVar(TITAN_TRADECOOLDOWN_ID, "NotifyEnable") == 1 ) then
		for k, v in TTC_Save do
			local _, _, realm, player = string.find(k, "^(.+)\|(.+)$");
			if TitanGetVar(TITAN_TRADECOOLDOWN_ID, "ShowOnlyCurrentRealm") ~= 1 or realm == GetRealmName() then
				for skillName, skillTable in v do
					local remaining = ((skillTable.Cooldown + skillTable.LastCheck) - time());
					if (remaining <= TITAN_TRADECOOLDOWN_NOTIFYTIME) then
						if (TTC_Save[k][skillName].IsReady ~= 1) then
	        					local _, _, realm, player = string.find(k, "^(.+)\|(.+)$");
	        					if (remaining <= 0) then
								DEFAULT_CHAT_FRAME:AddMessage(format(TITAN_TRADECOOLDOWN_READYNOTIFY0, skillName, realm, player)); 
							else
								DEFAULT_CHAT_FRAME:AddMessage(format(TITAN_TRADECOOLDOWN_READYNOTIFY1, skillName, realm, player, floor(remaining+0.9))); 
							end
							PlaySound("AuctionWindowOpen");
							TTC_Save[k][skillName].IsReady = 1;
						end
					end
				end
			end
		end
	end
end


function TitanPanelTradeCooldown_ToggleNotify()
	TitanToggleVar(TITAN_TRADECOOLDOWN_ID, "NotifyEnable");
end

function TitanPanelTradeCooldown_ToggleRealm()
	TitanToggleVar(TITAN_TRADECOOLDOWN_ID, "ShowOnlyCurrentRealm");
	TitanPanelButton_UpdateButton(TITAN_TRADECOOLDOWN_ID);
end

function TitanPanelTradeCooldown_ToggleEvergreen()
	TitanToggleVar(TITAN_TRADECOOLDOWN_ID, "ShowEvergreen");
	TitanPanelButton_UpdateButton(TITAN_TRADECOOLDOWN_ID);
end

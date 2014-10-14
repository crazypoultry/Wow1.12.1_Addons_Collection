local STATUS_COLOR = "|c000066FF";
CCWatchEffectSelection = "";
local bModify = false;
local AR_DiagOpen = false;

local DisplayTable = {}

function POBJI(k, v)
	str = k.." : ";
	if type(v) ~= "table" and type(v) ~= "userdata" and type(v) ~= "function" and type(v) ~= "nil" then
		CCWatch_AddMessage(str..v);
	else
		str = str.."type = "..type(v);
		if type(v) == "table" then
			CCWatch_AddMessage(str.." -> ");
			POBJ(v);
		else
			CCWatch_AddMessage(str);
		end
	end
end

function POBJ(obj)
	table.foreach(obj, POBJI);
end


function UpdateSortTable()
	DisplayTable = {}
	table.foreach(CCWATCH.CCS, function (k, v) table.insert(DisplayTable, k) end);
	table.sort(DisplayTable);
end

function CCWatchOptions_Toggle()
	if(CCWatchOptionsFrame:IsVisible()) then
		CCWatchOptionsFrame:Hide();
	else
		CCWatchOptionsFrame:Show();
	end
end

function CCWatchOptions_MageCCToggle()
	local bState = not CCWATCH.MONITORMAGE;
	CCWATCH.MONITORMAGE = bState;
	CCWatch_Save[CCWATCH.PROFILE].MonitorMage = bState;
	CCWATCH.CCS[CCWATCH_POLYMORPH].MONITOR = bState;
	CCWATCH.CCS[CCWATCH_FROSTNOVA].MONITOR = bState;
	CCWATCH.CCS[CCWATCH_FROSTBITE].MONITOR = bState;
	CCWATCH.CCS[CCWATCH_ICEBLOCK].MONITOR = bState;
	if CCWatch_ConfigDebuff ~= nil then
		CCWATCH.CCS[CCWATCH_FROSTBOLT].MONITOR = bState;
		CCWATCH.CCS[CCWATCH_CONEOFCOLD].MONITOR = bState;
		CCWATCH.CCS[CCWATCH_COUNTERSPELL].MONITOR = bState;
		CCWATCH.CCS[CCWATCH_FIREBALL].MONITOR = bState;
		CCWATCH.CCS[CCWATCH_PYROBLAST].MONITOR = bState;
		CCWATCH.CCS[CCWATCH_IGNITE].MONITOR = bState;
		CCWATCH.CCS[CCWATCH_FLAMESTRIKE].MONITOR = bState;
		CCWATCH.CCS[CCWATCH_BLASTWAVE].MONITOR = bState;
		CCWATCH.CCS[CCWATCH_FROSTARMOR].MONITOR = bState;
	end
end

function CCWatchOptions_PriestCCToggle()
	local bState = not CCWATCH.MONITORPRIEST;
	CCWATCH.MONITORPRIEST = bState;
	CCWatch_Save[CCWATCH.PROFILE].MonitorPriest = bState;
	CCWATCH.CCS[CCWATCH_SHACKLE].MONITOR = bState;
	CCWATCH.CCS[CCWATCH_PSYCHICSCREAM].MONITOR = bState;
	CCWATCH.CCS[CCWATCH_BLACKOUT].MONITOR = bState;
end


function CCWatchOptions_DruidCCToggle()
	local bState = not CCWATCH.MONITORDRUID;
	CCWATCH.MONITORDRUID = bState;
	CCWatch_Save[CCWATCH.PROFILE].MonitorDruid = bState;
	CCWATCH.CCS[CCWATCH_ROOTS].MONITOR = bState;
	CCWATCH.CCS[CCWATCH_HIBERNATE].MONITOR = bState;
	CCWATCH.CCS[CCWATCH_FERALCHARGE].MONITOR = bState;
	CCWATCH.CCS[CCWATCH_POUNCE].MONITOR = bState;
	CCWATCH.CCS[CCWATCH_BASH].MONITOR = bState;
	CCWATCH.CCS[CCWATCH_IMPSTARFIRE].MONITOR = bState;
end

function CCWatchOptions_HunterCCToggle()
	local bState = not CCWATCH.MONITORHUNTER;
	CCWATCH.MONITORHUNTER = bState;
	CCWatch_Save[CCWATCH.PROFILE].MonitorHunter = bState;
	CCWATCH.CCS[CCWATCH_FREEZINGTRAP].MONITOR = bState;
	CCWATCH.CCS[CCWATCH_IMPCS].MONITOR = bState;
	CCWATCH.CCS[CCWATCH_SCAREBEAST].MONITOR = bState;
	CCWATCH.CCS[CCWATCH_SCATTERSHOT].MONITOR = bState;
	CCWATCH.CCS[CCWATCH_INTIMIDATION].MONITOR = bState;
	CCWATCH.CCS[CCWATCH_COUNTERATTACK].MONITOR = bState;
	CCWATCH.CCS[CCWATCH_WYVERNSTING].MONITOR = bState;
	CCWATCH.CCS[CCWATCH_IMPROVEDWINGCLIP].MONITOR = bState;
	CCWATCH.CCS[CCWATCH_ENTRAPMENT].MONITOR = bState;
end

function CCWatchOptions_PaladinCCToggle()
	local bState = not CCWATCH.MONITORPALADIN;
	CCWATCH.MONITORPALADIN = bState;
	CCWatch_Save[CCWATCH.PROFILE].MonitorPaladin = bState;
	CCWATCH.CCS[CCWATCH_HOJ].MONITOR = bState;
	CCWATCH.CCS[CCWATCH_REPENTANCE].MONITOR = bState;
	CCWATCH.CCS[CCWATCH_TURNUNDEAD].MONITOR = bState;
end

function CCWatchOptions_WarlockCCToggle()
	local bState = not CCWATCH.MONITORWARLOCK;
	CCWATCH.MONITORWARLOCK = bState;
	CCWatch_Save[CCWATCH.PROFILE].MonitorWarlock = bState;
	CCWATCH.CCS[CCWATCH_SEDUCE].MONITOR = bState;
	CCWATCH.CCS[CCWATCH_FEAR].MONITOR = bState;
	CCWATCH.CCS[CCWATCH_BANISH].MONITOR = bState;
	CCWATCH.CCS[CCWATCH_HOWLOFTERROR].MONITOR = bState;
	CCWATCH.CCS[CCWATCH_DEATHCOIL].MONITOR = bState;
	if CCWatch_ConfigDebuff ~= nil then
		CCWATCH.CCS[CCWATCH_IMMOLATE].MONITOR = bState;
		CCWATCH.CCS[CCWATCH_CORRUPTION].MONITOR = bState;
		CCWATCH.CCS[CCWATCH_CURSEOFAGONY].MONITOR = bState;
		CCWATCH.CCS[CCWATCH_CURSEOFEXHAUSTION].MONITOR = bState;
		CCWATCH.CCS[CCWATCH_CURSEOFELEMENTS].MONITOR = bState;
		CCWATCH.CCS[CCWATCH_CURSEOFSHADOW].MONITOR = bState;
		CCWATCH.CCS[CCWATCH_CURSEOFTONGUES].MONITOR = bState;
		CCWATCH.CCS[CCWATCH_CURSEOFWEAKNESS].MONITOR = bState;
		CCWATCH.CCS[CCWATCH_CURSEOFRECKLESSNESS].MONITOR = bState;
		CCWATCH.CCS[CCWATCH_CURSEOFDOOM].MONITOR = bState;
	end
end

function CCWatchOptions_WarriorCCToggle()
	local bState = not CCWATCH.MONITORWARRIOR;
	CCWATCH.MONITORWARRIOR = bState;
	CCWatch_Save[CCWATCH.PROFILE].MonitorWarrior = bState;
	CCWATCH.CCS[CCWATCH_INTERCEPT].MONITOR = bState;
	CCWATCH.CCS[CCWATCH_MACESPE].MONITOR = bState;
	CCWATCH.CCS[CCWATCH_IMPHAMSTRING].MONITOR = bState;
	CCWATCH.CCS[CCWATCH_INTIMIDATINGSHOUT].MONITOR = bState;
	CCWATCH.CCS[CCWATCH_IMPREVENGE].MONITOR = bState;
	CCWATCH.CCS[CCWATCH_CONCUSSIONBLOW].MONITOR = bState;
end

function CCWatchOptions_RogueCCToggle()
	local bState = not CCWATCH.MONITORROGUE;
	CCWATCH.MONITORROGUE = bState;
	CCWatch_Save[CCWATCH.PROFILE].MonitorRogue = bState;
	CCWATCH.CCS[CCWATCH_GOUGE].MONITOR = bState;
	CCWATCH.CCS[CCWATCH_BLIND].MONITOR = bState;
	CCWATCH.CCS[CCWATCH_SAP].MONITOR = bState;
	CCWATCH.CCS[CCWATCH_KS].MONITOR = bState;
	CCWATCH.CCS[CCWATCH_CS].MONITOR = bState;
end

function CCWatchOptions_MiscCCToggle()
	local bState = not CCWATCH.MONITORMISC;
	CCWATCH.MONITORMISC = bState;
	CCWatch_Save[CCWATCH.PROFILE].MonitorMisc = bState;
	CCWATCH.CCS[CCWATCH_WARSTOMP].MONITOR = bState;
	CCWATCH.CCS[CCWATCH_SLEEP].MONITOR = bState;
	CCWATCH.CCS[CCWATCH_NETOMATIC].MONITOR = bState;
	if CCWatch_ConfigBuff ~= nil then
		CCWATCH.CCS[CCWATCH_WOTF].MONITOR = bState;
		CCWATCH.CCS[CCWATCH_PERCEPTION].MONITOR = bState;
	end
end


function CCWatchOptions_MonitorCCToggle()
	CCWATCH.MONITORING = bit.bxor(CCWATCH.MONITORING, ETYPE_CC);
	CCWatch_Save[CCWATCH.PROFILE].Monitoring = CCWATCH.MONITORING;
	if bit.band(CCWATCH.MONITORING, ETYPE_DEBUFF) == 0 then
		if bit.band(CCWATCH.MONITORING, ETYPE_CC) ~= 0 then
			CCWatchObject:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE");
			CCWatchObject:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE");
		else
			CCWatchObject:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE");
			CCWatchObject:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE");
		end
	end
end

function CCWatchOptions_MonitorDebuffToggle()
	CCWATCH.MONITORING = bit.bxor(CCWATCH.MONITORING, ETYPE_DEBUFF);
	CCWatch_Save[CCWATCH.PROFILE].Monitoring = CCWATCH.MONITORING;
	if bit.band(CCWATCH.MONITORING, ETYPE_CC) == 0 then
		if bit.band(CCWATCH.MONITORING, ETYPE_DEBUFF) ~= 0 then
			CCWatchObject:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE");
			CCWatchObject:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE");
		else
			CCWatchObject:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE");
			CCWatchObject:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE");
		end
	end
end

function CCWatchOptions_MonitorBuffToggle()
	CCWATCH.MONITORING = bit.bxor(CCWATCH.MONITORING, ETYPE_BUFF);
	CCWatch_Save[CCWATCH.PROFILE].Monitoring = CCWATCH.MONITORING;
	if bit.band(CCWATCH.MONITORING, ETYPE_BUFF) ~= 0 then
		CCWatchObject:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS");
		CCWatchObject:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_BUFFS");
	else
		CCWatchObject:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS");
		CCWatchObject:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_BUFFS");
	end
end


function CCWatchOptions_UnlockToggle()
	if CCWATCH.STATUS == 2 then
		CCWatch_BarLock();
		CCWatch_AddMessage(CCWATCH_LOCKED);
	else
		CCWatch_BarUnlock();
		CCWatch_AddMessage(CCWATCH_UNLOCKED);
	end
end

function CCWatchOptions_InvertToggle()
	CCWATCH.INVERT = not CCWATCH.INVERT;
	CCWatch_Save[CCWATCH.PROFILE].invert = CCWATCH.INVERT;
	if CCWATCH.INVERT then
		CCWatch_AddMessage(CCWATCH_INVERSION_ON);
	else
		CCWatch_AddMessage(CCWATCH_INVERSION_OFF);
	end
end

function CCWatchOptions_ArcanistToggle()
	CCWATCH.ARCANIST = not CCWATCH.ARCANIST;
	CCWatch_Save[CCWATCH.PROFILE].arcanist = CCWATCH.ARCANIST;
	if CCWATCH.ARCANIST then
		CCWATCH.CCS[CCWATCH_POLYMORPH].LENGTH = CCWATCH.CCS[CCWATCH_POLYMORPH].LENGTH + 15;
		CCWatch_AddMessage(CCWATCH_ARCANIST_ON);
	else
		CCWATCH.CCS[CCWATCH_POLYMORPH].LENGTH = CCWATCH.CCS[CCWATCH_POLYMORPH].LENGTH - 15;
		CCWatch_AddMessage(CCWATCH_ARCANIST_OFF);
	end
	CCWatchOptionsFrameArcanist:SetChecked(CCWATCH.ARCANIST);
end

function CCWatchGrowthDropDown_OnInit()
	UIDROPDOWNMENU_INIT_MENU = "CCWatch_OptionsMenuGrowthDropDown";
	local info = { };

	info.text = CCWATCH_OPTION_GROWTH_OFF;
	info.value = "off";
	info.owner = this;
	info.func = CCWatchGrowthDropDown_OnClick;
	UIDropDownMenu_AddButton(info);

	info.text = CCWATCH_OPTION_GROWTH_UP;
	info.value = "up";
	info.owner = this;
	info.func = CCWatchGrowthDropDown_OnClick;
	UIDropDownMenu_AddButton(info);
	
	info.text = CCWATCH_OPTION_GROWTH_DOWN;
	info.value = "down";
	info.owner = this;
	info.func = CCWatchGrowthDropDown_OnClick;
	UIDropDownMenu_AddButton(info);
end

function CCWatchTimersDropDown_OnInit()
	UIDROPDOWNMENU_INIT_MENU = "CCWatch_OptionsMenuTimersDropDown";
	local info = { };

	info.text = CCWATCH_OPTION_TIMERS_OFF;
	info.value = "off";
	info.owner = this;
	info.func = CCWatchTimersDropDown_OnClick;
	UIDropDownMenu_AddButton(info);

	info.text = CCWATCH_OPTION_TIMERS_ON;
	info.value = "on";
	info.owner = this;
	info.func = CCWatchTimersDropDown_OnClick;
	UIDropDownMenu_AddButton(info);
	
	info.text = CCWATCH_OPTION_TIMERS_REVERSE;
	info.value = "reverse";
	info.owner = this;
	info.func = CCWatchTimersDropDown_OnClick;
	UIDropDownMenu_AddButton(info);
end

function CCWatchOptionsEffectTypeDropDown_OnInit()
	UIDROPDOWNMENU_INIT_MENU = "CCWatch_OptionsEffectTypeDropDown";
	local info = { };

	info.text = "CC";
	info.value = "cc";
	info.owner = this;
	info.func = CCWatchOptionsEffectTypeDropDown_OnClick;
	UIDropDownMenu_AddButton(info);

	info.text = "DEBUFF";
	info.value = "debuff";
	info.owner = this;
	info.func = CCWatchOptionsEffectTypeDropDown_OnClick;
	UIDropDownMenu_AddButton(info);
	
	info.text = "BUFF";
	info.value = "buff";
	info.owner = this;
	info.func = CCWatchOptionsEffectTypeDropDown_OnClick;
	UIDropDownMenu_AddButton(info);
end

function CCWatchOptionsEffectGroupDropDown_OnInit()
	UIDROPDOWNMENU_INIT_MENU = "CCWatch_OptionsEffectGroupDropDown";
	local info = { };

	info.text = "1";
	info.value = "1";
	info.owner = this;
	info.func = CCWatchOptionsEffectGroupDropDown_OnClick;
	UIDropDownMenu_AddButton(info);

	info.text = "2";
	info.value = "2";
	info.owner = this;
	info.func = CCWatchOptionsEffectGroupDropDown_OnClick;
	UIDropDownMenu_AddButton(info);

	info.text = "3";
	info.value = "3";
	info.owner = this;
	info.func = CCWatchOptionsEffectGroupDropDown_OnClick;
	UIDropDownMenu_AddButton(info);

	info.text = "4";
	info.value = "4";
	info.owner = this;
	info.func = CCWatchOptionsEffectGroupDropDown_OnClick;
	UIDropDownMenu_AddButton(info);

	info.text = "5";
	info.value = "5";
	info.owner = this;
	info.func = CCWatchOptionsEffectGroupDropDown_OnClick;
	UIDropDownMenu_AddButton(info);
end

function CCWatchOptionsStyleDropDown_OnInit()
	UIDROPDOWNMENU_INIT_MENU = "CCWatch_OptionsStyleDropDown";
	local info = { };

	info.text = CCWATCH_OPTION_STYLE_CURRENT;
	info.value = "normal";
	info.owner = this;
	info.func = CCWatchOptionsStyleDropDown_OnClick;
	UIDropDownMenu_AddButton(info);

	info.text = CCWATCH_OPTION_STYLE_RECENT;
	info.value = "recent";
	info.owner = this;
	info.func = CCWatchOptionsStyleDropDown_OnClick;
	UIDropDownMenu_AddButton(info);
	
	info.text = CCWATCH_OPTION_STYLE_ALL;
	info.value = "all";
	info.owner = this;
	info.func = CCWatchOptionsStyleDropDown_OnClick;
	UIDropDownMenu_AddButton(info);
end


function CCWatchGrowthDropDown_OnClick()
	if (this.value == "off") then
		CCWatch_Save[CCWATCH.PROFILE].growth = 0;
		CCWATCH.GROWTH = CCWatch_Save[CCWATCH.PROFILE].growth;
		CCWatchGrowthDropDownText:SetText(CCWATCH_OPTION_GROWTH_OFF);
		CCWatch_AddMessage(CCWATCH_GROW_OFF);
	elseif( this.value == "up" ) then
		CCWatch_Save[CCWATCH.PROFILE].growth = 1;
		CCWATCH.GROWTH = CCWatch_Save[CCWATCH.PROFILE].growth;
		CCWatchGrowthDropDownText:SetText(CCWATCH_OPTION_GROWTH_UP);
		CCWatch_AddMessage(CCWATCH_GROW_UP);
	elseif( this.value == "down" ) then
		CCWatch_Save[CCWATCH.PROFILE].growth = 2;
		CCWATCH.GROWTH = CCWatch_Save[CCWATCH.PROFILE].growth;
		CCWatchGrowthDropDownText:SetText(CCWATCH_OPTION_GROWTH_DOWN);
		CCWatch_AddMessage(CCWATCH_GROW_DOWN);
	end
end

function CCWatchTimersDropDown_OnClick()
	if (this.value == "off") then
		CCWatch_Save[CCWATCH.PROFILE].timers = 0;
		CCWATCH.TIMERS = CCWatch_Save[CCWATCH.PROFILE].timers;
		CCWatchTimersDropDownText:SetText(CCWATCH_OPTION_TIMERS_OFF);
		CCWatch_AddMessage(CCWATCH_TIMERS_OFF);
	elseif( this.value == "on" ) then
		CCWatch_Save[CCWATCH.PROFILE].timers = 1;
		CCWATCH.TIMERS = CCWatch_Save[CCWATCH.PROFILE].timers;
		CCWatchTimersDropDownText:SetText(CCWATCH_OPTION_TIMERS_ON);
		CCWatch_AddMessage(CCWATCH_TIMERS_ON);
	elseif( this.value == "reverse" ) then
		CCWatch_Save[CCWATCH.PROFILE].timers = 2;
		CCWATCH.TIMERS = CCWatch_Save[CCWATCH.PROFILE].timers;
		CCWatchTimersDropDownText:SetText(CCWATCH_OPTION_TIMERS_REVERSE);
		CCWatch_AddMessage(CCWATCH_TIMERS_REVERSE);
	end
end

function CCWatchOptionsEffectTypeDropDown_OnClick()
	if (this.value == "cc") then
		CCWatchOptionsEffectTypeDropDownText:SetText("CC");
	elseif( this.value == "debuff" ) then
		CCWatchOptionsEffectTypeDropDownText:SetText("DEBUFF");
	elseif( this.value == "buff" ) then
		CCWatchOptionsEffectTypeDropDownText:SetText("BUFF");
	end
end

function CCWatchOptionsEffectGroupDropDown_OnClick()
	CCWatchOptionsEffectGroupDropDownText:SetText(this.value);
end

function CCWatchOptionsStyleDropDown_OnClick()
	if (this.value == "normal") then
		CCWatch_Save[CCWATCH.PROFILE].style = 0;
		CCWATCH.STYLE = CCWatch_Save[CCWATCH.PROFILE].style;
		CCWatchOptionsStyleDropDownText:SetText(CCWATCH_OPTION_STYLE_CURRENT);
		CCWatch_AddMessage(CCWATCH_STYLE_CURRENT);
	elseif( this.value == "recent" ) then
		CCWatch_Save[CCWATCH.PROFILE].style = 1;
		CCWATCH.STYLE = CCWatch_Save[CCWATCH.PROFILE].style;
		CCWatchOptionsStyleDropDownText:SetText(CCWATCH_OPTION_STYLE_RECENT);
		CCWatch_AddMessage(CCWATCH_STYLE_RECENT);
	elseif( this.value == "all" ) then
		CCWatch_Save[CCWATCH.PROFILE].style = 2;
		CCWATCH.STYLE = CCWatch_Save[CCWATCH.PROFILE].style;
		CCWatchOptionsStyleDropDownText:SetText(CCWATCH_OPTION_STYLE_ALL);
		CCWatch_AddMessage(CCWATCH_STYLE_ALL);
	end
end

function CCWatchOptionsBarsTab_OnClick()
	CCWatchOptionsBarsFrame:Show();
	CCWatchOptionsEffectsFrame:Hide();
	CCWatchOptionsLearnFrame:Hide();

	PlaySound("igMainMenuOptionCheckBoxOn");
end

function CCWatchOptionsEffectsTab_OnClick()
	CCWatchOptionsBarsFrame:Hide();
	CCWatchOptionsEffectsFrame:Show();
	CCWatchOptionsLearnFrame:Hide();

	PlaySound("igMainMenuOptionCheckBoxOn");
end

function CCWatchOptionsLearnTab_OnClick()
	CCWatchOptionsBarsFrame:Hide();
	CCWatchOptionsEffectsFrame:Hide();
	CCWatchOptionsLearnFrame:Show();

	PlaySound("igMainMenuOptionCheckBoxOn");
end

function CCWatchOptionsBarsFrame_OnShow()
	CCWatchOptionsBarsTabTexture:Show();
	CCWatchOptionsBarsTab:SetBackdropBorderColor(1, 1, 1, 1);
--	CCWatchOptionsBarsFrame_Refresh();
end

function CCWatchOptionsEffectsFrame_OnShow()
	CCWatchOptionsEffectsTabTexture:Show();
	CCWatchOptionsEffectsTab:SetBackdropBorderColor(1, 1, 1, 1);
--	CCWatchOptionsEffectsFrame_Refresh();
end

function CCWatchOptionsLearnFrame_OnShow()
	CCWatchOptionsLearnTabTexture:Show();
	CCWatchOptionsLearnTab:SetBackdropBorderColor(1, 1, 1, 1);
--	CCWatchOptionsLearnFrame_Refresh();
end

function CCWatchOptionsBarsFrame_OnHide()
	CCWatchOptionsBarsTabTexture:Hide();
	CCWatchOptionsBarsTab:SetBackdropBorderColor(0.25, 0.25, 0.25, 1.0);
end

function CCWatchOptionsEffectsFrame_OnHide()
	CCWatchOptionsEffectsTabTexture:Hide();
	CCWatchOptionsEffectsTab:SetBackdropBorderColor(0.25, 0.25, 0.25, 1.0);
end

function CCWatchOptionsLearnFrame_OnHide()
	CCWatchOptionsLearnTabTexture:Hide();
	CCWatchOptionsLearnTab:SetBackdropBorderColor(0.25, 0.25, 0.25, 1.0);
end


function CCWatchOptionsLearnClear_OnClick()
	CCWatchOptionsEffectNameEdit:SetText("");
	CCWatchOptionsEffectDurationEdit:SetText("");
-- TODO: check control selection coherency
	CCWatchOptionsEffectTypeDropDownText:SetText("CC");
	CCWatchOptionsEffectGroupDropDownText:SetText("1");
	CCWatchOptionsLearnModify:SetText("Add");
	bModify = false;
end

function CCWatchOptionsLearnModify_OnClick()
	local effect = CCWatchOptionsEffectNameEdit:GetText();
	local duration = CCWatchOptionsEffectDurationEdit:GetText();
	local group = CCWatchOptionsEffectGroupDropDownText:GetText();
	local stype = CCWatchOptionsEffectTypeDropDownText:GetText();
	local etype;
	if stype == "BUFF" then
		etype = ETYPE_BUFF;
	elseif stype == "DEBUFF" then
		etype = ETYPE_DEBUFF;
	else
		etype = ETYPE_CC;
	end

	local nDuration = tonumber(duration);

	if effect == "" then
		message("Invalid Effect name");
		return;
	end
	if nDuration == nil or nDuration <= 0 then
		message("Invalid duration.");
		return;
	end

	if bModify then
-- TODO: confirm modify (?)
-- modifying
		if effect ~= CCWatchEffectSelection then -- skillname change...
			-- remove old effect
			CCWATCH.CCS[CCWatchEffectSelection] = nil;
			CCWatch_SavedCC[CCWatchEffectSelection] = nil;
		end
		-- add/update effect
		CCWatchAddEffect(effect, group, etype, duration, 2);
	else
-- add
		if CCWATCH.CCS[effect] ~= nil then
			message("Effect '"..effect.."' already exist.\nPlease select Edit to modify it");
			return;
		else
			CCWatchAddEffect(effect, group, etype, duration, 2);
		end
	end
	UpdateSortTable();	
	CCWatchOptionsEffects_Update();
	CCWatch_AddMessage(CCWATCH_EFFECT.." "..effect..CCWATCH_ADDEDMODIFIED);
end

function CCWatchAddEffect(effect, group, etype, duration, diminishes)
	CCWATCH.CCS[effect] = {
		GROUP = tonumber(group),
		ETYPE = etype,
		LENGTH = duration,
		DIMINISHES = diminishes,

		TARGET = "",
		PLAYER = nil,
		TIMER_START = 0,
		TIMER_END = 0,
		DIMINISH = 1,
		MONITOR = true
	};
	CCWatch_SavedCC[effect] = {
		GROUP = tonumber(group),
		ETYPE = etype,
		LENGTH = duration,
		DIMINISHES = diminishes,
	};
end

function CCWatchOptionsLearnFillFields(mod)
	if CCWatchEffectSelection == nil then
		return;
	end
	CCWatchOptionsEffectNameEdit:SetText(CCWatchEffectSelection);
	CCWatchOptionsEffectDurationEdit:SetText(CCWATCH.CCS[CCWatchEffectSelection].LENGTH);

	if CCWATCH.CCS[CCWatchEffectSelection].ETYPE == ETYPE_BUFF then
		CCWatchOptionsEffectTypeDropDownText:SetText("BUFF");
	elseif CCWATCH.CCS[CCWatchEffectSelection].ETYPE == ETYPE_DEBUFF then
		CCWatchOptionsEffectTypeDropDownText:SetText("DEBUFF");
	else
		CCWatchOptionsEffectTypeDropDownText:SetText("CC");
	end
	CCWatchOptionsEffectGroupDropDownText:SetText(CCWATCH.CCS[CCWatchEffectSelection].GROUP);

-- TODO: <add control for diminishing returns>
	bModify = mod;
	if mod then
		CCWatchOptionsLearnModify:SetText("Modify");
	else
		CCWatchOptionsLearnModify:SetText("Add");
	end
end


function CCWatchOptionsLearnEdit_OnClick()
	CCWatchOptionsLearnFillFields(true);
end

function CCWatchOptionsLearnDelete_OnClick()
-- 1. Pop alert to confirm deletion
	CCWatch_ShowDeletePrompt();
end

function CCWatch_DeleteLearntEffect()
	CCWATCH.CCS[CCWatchEffectSelection] = nil;
--	CCWatch_SavedCC[CCWatchEffectSelection] = nil;
	CCWatch_SavedCC[CCWatchEffectSelection] = {}

	UpdateSortTable();
	CCWatchOptionsEffects_Update();
	CCWatch_OpenDiagToggle();

	CCWatch_AddMessage(CCWATCH_REMOVED_NOTICE..CCWatchEffectSelection..".");
	CCWatchEffectSelection = "";
end


function CCWatchOptions_OnLoad()
	UIPanelWindows['CCWatchOptionsFrame'] = {area = 'center', pushable = 1};
end

function CCWatchOptions_Init()

	CCWatchOptionsFrameMageCC:SetChecked(CCWATCH.MONITORMAGE);
	CCWatchOptionsFramePriestCC:SetChecked(CCWATCH.MONITORPRIEST);
	CCWatchOptionsFrameDruidCC:SetChecked(CCWATCH.MONITORDRUID);
	CCWatchOptionsFrameHunterCC:SetChecked(CCWATCH.MONITORHUNTER);
	CCWatchOptionsFramePaladinCC:SetChecked(CCWATCH.MONITORPALADIN);
	CCWatchOptionsFrameWarlockCC:SetChecked(CCWATCH.MONITORWARLOCK);
	CCWatchOptionsFrameWarriorCC:SetChecked(CCWATCH.MONITORWARRIOR);
	CCWatchOptionsFrameRogueCC:SetChecked(CCWATCH.MONITORROGUE);
	CCWatchOptionsFrameMiscCC:SetChecked(CCWATCH.MONITORMISC);
	CCWatchSliderAlpha:SetValue(CCWATCH.ALPHA);
	CCWatchSliderScale:SetValue(CCWATCH.SCALE);
	CCWatchSliderWidth:SetValue(CCWATCH.WIDTH);

	CCWatchOptionsFrameMonitorCC:SetChecked(bit.band(CCWATCH.MONITORING, ETYPE_CC));
	CCWatchOptionsFrameMonitorDebuff:SetChecked(bit.band(CCWATCH.MONITORING, ETYPE_DEBUFF));
	CCWatchOptionsFrameMonitorBuff:SetChecked(bit.band(CCWATCH.MONITORING, ETYPE_BUFF));

	CCWatchOptionsFrameUnlock:SetChecked(CCWATCH.STATUS == 2);
	CCWatchOptionsFrameInvert:SetChecked(CCWATCH.INVERT);
	CCWatchOptionsFrameArcanist:SetChecked(CCWATCH.ARCANIST);

	CCWatchOptionsEffectTypeDropDownText:SetText("CC");
	CCWatchOptionsEffectGroupDropDownText:SetText("1");

	if CCWATCH.GROWTH == 0 then
		CCWatchGrowthDropDownText:SetText(CCWATCH_OPTION_GROWTH_OFF);
	elseif CCWATCH.GROWTH == 1 then
		CCWatchGrowthDropDownText:SetText(CCWATCH_OPTION_GROWTH_UP);
	else
		CCWatchGrowthDropDownText:SetText(CCWATCH_OPTION_GROWTH_DOWN);
	end

	if CCWATCH.TIMERS == 0 then
		CCWatchTimersDropDownText:SetText(CCWATCH_OPTION_TIMERS_OFF);
	elseif CCWATCH.TIMERS == 1 then
		CCWatchTimersDropDownText:SetText(CCWATCH_OPTION_TIMERS_ON);
	else
		CCWatchTimersDropDownText:SetText(CCWATCH_OPTION_TIMERS_REVERSE);
	end

	if CCWATCH.STYLE == 0 then
		CCWatchOptionsStyleDropDownText:SetText(CCWATCH_OPTION_STYLE_CURRENT);
	elseif CCWATCH.STYLE == 1 then
		CCWatchOptionsStyleDropDownText:SetText(CCWATCH_OPTION_STYLE_RECENT);
	else
		CCWatchOptionsStyleDropDownText:SetText(CCWATCH_OPTION_STYLE_ALL);
	end

	UpdateSortTable();
	CCWatchOptionsEffects_Update();

	CCWatchOptionsBarsFrame:Show();
	CCWatchOptionsEffectsTabTexture:Hide();
	CCWatchOptionsEffectsTab:SetBackdropBorderColor(0.25, 0.25, 0.25, 1.0);
	CCWatchOptionsLearnTabTexture:Hide();
	CCWatchOptionsLearnTab:SetBackdropBorderColor(0.25, 0.25, 0.25, 1.0);
end

local item;
local CCcount;
local curoffset;


local function EffectsUpdate(k, v)
	item = item + 1;
	if (curoffset > item) or ((item - curoffset) >= 11) then
		return;
	end

	local itemSlot = getglobal("CCWatchOptionsEffectsItem"..(item-curoffset+1));
	local name = v;
	if (name == CCWatchEffectSelection) then
		itemSlot:SetTextColor(1, 1, 0);
	else
		itemSlot:SetTextColor(1, 1, 1);
	end
	itemSlot:SetText(name);
	itemSlot:Show();
end

function CCWatchOptionsEffects_Update()
--	CCWatch_AddMessage("CCWatchOptionsEffects_Update");

	CCcount = 0;

	CCcount = table.getn(DisplayTable);

	FauxScrollFrame_Update(CCWatchOptionsEffectsListScrollFrame, CCcount, 11, 16);

	item = -1;
	curoffset = FauxScrollFrame_GetOffset(CCWatchOptionsEffectsListScrollFrame);
--	CCWatch_AddMessage("We're at "..curoffset);

	table.foreach(DisplayTable, EffectsUpdate);
end

function CCWatchOptionsEffects_OnEnter()
--	CCWatch_AddMessage("CCWatchOptionsEffects_OnEnter");
	
	GameTooltip:SetOwner(this, "ANCHOR_RIGHT");

	local spellname = this:GetText();
	if spellname == nil then
		return;
	end

	if CCWATCH.CCS[spellname] == nil then
		CCWatch_AddMessage("Error : '"..spellname.."' not found in effect array.");
		return;
	end
	local str = spellname.."\nDuration: "..CCWATCH.CCS[spellname].LENGTH.."\nType: ";
	if CCWATCH.CCS[spellname].ETYPE == ETYPE_BUFF then
		str = str.."Buff";
	elseif CCWATCH.CCS[spellname].ETYPE == ETYPE_DEBUFF then
		str = str.."DeBuff";
	else
		str = str.."CC";
	end
	GameTooltip:SetText(str, 1, 1, 1);
end


-------------

function CCWatch_OpenDiagToggle()
	if (CCWatch_DiagOpen) then
		CCWatch_DiagOpen = false;
	else
		CCWatch_DiagOpen = true;
	end
end

function CCWatch_ShowDeletePrompt(cost) 
	StaticPopupDialogs["CCWATCH_DELETE_EFFECT"] = {
		text = TEXT(STATUS_COLOR..CCWATCH_FULLVERSION.." (Elwen)\n\n\n"..CCWATCH_LEARN_DELETE_PROMPT.."'"..CCWatchEffectSelection.."' ?"),
		button1 = TEXT(OKAY),
		button2 = TEXT(CANCEL),
		OnAccept = function()
			CCWatch_DeleteLearntEffect();
		end,
		OnShow = function()
			CCWatch_OpenDiagToggle();
		end,
		OnHide = function()
			CCWatch_OpenDiagToggle();
		end,
		showAlert = 1,
		timeout = 0,
		exclusive = 0,
		whileDead = 1,
		interruptCinematic = 1
	};
	PlaySound("QUESTADDED");
	StaticPopup_Show("CCWATCH_DELETE_EFFECT");
end


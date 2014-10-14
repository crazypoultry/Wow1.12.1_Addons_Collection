-- Pollymorph Helper
--
-- Written by Chria.
--
-- This is an addon for World of Warcraft that adds extra functionality 
-- for mages when casting Pollymorph
--
--

-- Constants
POLYHELPER_OHNOTICE_HOLD = UIERRORS_HOLD_TIME;
POLYHELPER_OHWARNING_HOLD = 0.5;
POLYHELPER_OHERROR_HOLD = UIERRORS_HOLD_TIME;
POLYHELPER_OHOTHER_HOLD = 0.01;
POLYHELPER_VERSION = "1.2.5";
POLYHELPER_VERSION_IB = 125;

-- SavedVariables
PolyHelper_Options = {};

-- MiscOptionVariables
PolyHelper_DingSchemes = {"AuctionWindowOpen","igMainMenuOpen","igMainMenuClose","igMainMenuContinue"};
PolyHelper_Frequency = 0.25;

-- RunTimeVariables
PolyHelper_Running = false;
PolyHelper_Casting = false;
PolyHelper_StartClock = false;
PolyHelper_StartTime = nil;
PolyHelper_SpellID = 0;
PolyHelper_WarnSpellID = 0;
PolyHelper_Duration = 0;
PolyHelper_DurationBonus = 0;
PolyHelper_CurName = "";
PolyHelper_Resume = false;
PolyHelper_RetargetLast = false;

PolyHelper_IsPlayer = false;
PolyHelper_Diminished = 1;
PolyHelper_LastUnit = "";
PolyHelper_LastEnd = 0;

function PolyHelper_GetType()
	local phtype = "Solo";
	if GetPartyMember(1) then
		phtype = "Party";
		if GetNumRaidMembers() > 0 then
			phtype = "Raid";
		end
	end
	return phtype;
end
function PolyHelper_GetChannel()
	return PolyHelper_Options.Channel[PolyHelper_GetType()];
end
function PolyHelper_PostMSG(mode,...)
	local msg = "";
	if mode == "warn" then
		msg = POLYHELPER_WARN_MSG;
	elseif mode == "cast" then
		msg = POLYHELPER_CAST_MSG;
	elseif mode == "fail" then
		msg = POLYHELPER_FAIL_MSG;
	end

	local target = "";
	local level = "";
	local classification = "";
	local creature = "";
	local gender = "";
	local race = "";
	local class = "";
	local arg1 = "";
	if arg.n >= 1 then arg1 = arg[1]; end

	local str = "%M <<%T>>";

	if mode == "fail" then
		str = str..": %A";

		target = PolyHelper_CurName;
	else
		if PolyHelper_Options.MessageLength == "short" then
			str = "%M <<%T>>";
		elseif PolyHelper_Options.MessageLength == "normal" then
			str = "%M <<%T>> [%L";
			if UnitIsPlayer("target") then
				str = str.." %G %R %C";
			else
				str = str.." %I %E";
			end
			str = str.."]";
		elseif PolyHelper_Options.MessageLength == "long" then
			str = "%M <<%T>> [%L %G %I %R %C %E]";
		end

		target = UnitName("target");
		level = POLYHELPER_LEVEL_TEXT.." "..UnitLevel("target");
		classification = UnitClassification("target");
		creature = UnitCreatureType("target");

		if creature == POLYHELPER_CREATURE_TYPE_HUMANOID then
			gender = POLYHELPER_GENDER_MALE;
			if UnitSex("target") == 1 then
				gender = POLYHELPER_GENDER_FEMALE;
			elseif UnitSex("target") == 2 then
				gender = "";
			end
			if UnitRace("target") then
				race = UnitRace("target");
			end
			if UnitClass("target") then
				class = UnitClass("target");
			end
		end
	end

	str = string.gsub(str,"%%M",msg);
	str = string.gsub(str,"%%T",target);
	str = string.gsub(str,"%%L",level);
	str = string.gsub(str,"%%I",classification);
	str = string.gsub(str,"%%E",creature);
	str = string.gsub(str,"%%G",gender);
	str = string.gsub(str,"%%R",race);
	str = string.gsub(str,"%%C",class);
	str = string.gsub(str,"%%A",arg1);

	local channel = "NONE";
	if (PolyHelper_Options.Notify.Combat == "yes" or not UnitAffectingCombat("player")) and 
	   (PolyHelper_Options.Notify.PVP == "yes" or not (UnitIsPVP("target") or UnitIsPVPFreeForAll("target") or PolyHelper_IsPlayer)) and 
	   (PolyHelper_Options.Notify.PVPRaw == "yes" or not (UnitIsPVP("target") or UnitFactionGroup("player") == UnitFactionGroup("target"))) and 
	   (PolyHelper_Options.Notify.Recast == "yes" or not PolyHelper_IsRecast()) then
		channel = PolyHelper_GetChannel();
	end
	if channel ~= "NONE" then
		if channel == "EMOTE" then str = POLYHELPER_EMOTEPREPEND[mode]..str; end
		SendChatMessage(str,channel);
	end
	if PolyHelper_Options.Mode == "verbose" or PolyHelper_Options.Mode == "debug" then
		PolyHelper_ChatPrint(POLYHELPER_TEXT..": "..POLYHELPER_METHOD_TEXT..": "..mode.."; "..POLYHELPER_CHANNEL_TEXT..": "..channel.."; "..POLYHELPER_STRING_TEXT..": "..str, "yellow");
	end
	if mode == "fail" then
		if PolyHelper_Options.OverHeadWarning == "on" then
			PolyHelper_OverHeadPrint(POLYHELPER_TEXT..": "..str, POLYHELPER_OHERROR_HOLD, "orange");
		end
	else
		if PolyHelper_Options.OverHeadNotice == "on" then
			PolyHelper_OverHeadPrint(POLYHELPER_TEXT..": "..str, POLYHELPER_OHNOTICE_HOLD, "yellow");
		end
	end
end
function PolyHelper_IsRecast()
	if PolyHelper_LastUnit ~= PolyHelper_CurName then return false; end
	if not PolyHelper_Running and GetTime() > PolyHelper_LastEnd + 5 then
		return false;
	end
	return true;
end
function PolyHelper_IsMorphed()
	local i = 1;
	while true do
		local debuffTexture = UnitDebuff("target", i);
		if not debuffTexture then
			do break end;
		end
		if string.find(debuffTexture,"Polymorph") then
			return true;
		end
		i = i + 1;
	end
	return false;
end
function PolyHelper_GetPolyMorphSpell()
	PolyHelper_SpellID = 0;
	PolyHelper_Duration = 0;
	local i = 1; local rank = 0;
	while true do
		local spellName, spellRank = GetSpellName(i, BOOKTYPE_SPELL);
		if not spellName then
			do break end;
		end
		if spellName == POLYHELPER_SPELLNAME_POLYMORPH then
			local _, _, _, rankNumber = string.find(spellRank, "(.+) (.+)");
			if tonumber(rankNumber) > rank then
				PolyHelper_SpellID = i; rank = tonumber(rankNumber);
				PolyHelper_Duration = (rank * 10) + PolyHelper_DurationBonus + 10;
			end
		elseif spellName == POLYHELPER_SPELLNAME_DETECTMAGIC then
			PolyHelper_WarnSpellID = i;
		end
		i = i + 1;
	end
end
function PolyHelper_IsMage(errorDisplay)
	if UnitClass("player") ~= POLYHELPER_CLASS_MAGE then
		if errorDisplay then
			PolyHelper_OverHeadPrint(POLYHELPER_TEXT..": "..POLYHELPER_ERRORS_NOTMAGE, POLYHELPER_OHERROR_HOLD, "red");
		end
		return false;
	end
	return true
end
function PolyHelper_MiscChecks()
	if not PolyHelper_IsMage(true) then
		return false;
	end

	PolyHelper_GetPolyMorphSpell();
	if PolyHelper_SpellID == 0 then
		PolyHelper_OverHeadPrint(POLYHELPER_TEXT..": "..POLYHELPER_ERRORS_NOPOLY, POLYHELPER_OHERROR_HOLD, "red");
		return false;
	end

	if (UnitIsCorpse("target") or UnitHealth("target") <= 0) then
		PolyHelper_OverHeadPrint(POLYHELPER_TEXT..": "..POLYHELPER_ERRORS_TARGET_DEAD, POLYHELPER_OHERROR_HOLD, "red");
		return false;
	elseif not UnitCanAttack("player","target") then
		PolyHelper_OverHeadPrint(POLYHELPER_TEXT..": "..POLYHELPER_ERRORS_TARGET_FRIEND, POLYHELPER_OHERROR_HOLD, "red");
		return false;
	elseif not UnitIsPlayer("target") and UnitCreatureType("target") ~= POLYHELPER_CREATURE_TYPE_BEAST and UnitCreatureType("target") ~= POLYHELPER_CREATURE_TYPE_CRITTER and UnitCreatureType("target") ~= POLYHELPER_CREATURE_TYPE_HUMANOID then
		PolyHelper_OverHeadPrint(POLYHELPER_TEXT..": "..POLYHELPER_ERRORS_TARGET_INVALIDCREATURE, POLYHELPER_OHERROR_HOLD, "red");
		return false;
	end
	return true
end

function Toggle_PolyHelper_Warn()
	if not PolyHelper_MiscChecks() then
		return;
	end
	PolyHelper_PostMSG("warn");
	if PolyHelper_Options.WarnShow == "on" and PolyHelper_WarnSpellID ~= 0 then
		CastSpell(PolyHelper_WarnSpellID,SpellBookFrame.bookType);
	end
end
function Toggle_PolyHelper_Cast()
	if not PolyHelper_MiscChecks() then
		return;
	end

	PolyHelper_Casting = true;
	PolyHelper_CurName = UnitName("target");
	PolyHelper_IsPlayer = UnitIsPlayer("target");

	if (PolyHelper_IsPlayer) then
		if ((GetTime() > PolyHelper_LastEnd + 15 and not PolyHelper_Running) or PolyHelper_LastUnit ~= PolyHelper_CurName) then
			PolyHelper_Diminished = 1;
		end
		PolyHelper_Duration = 15 / PolyHelper_Diminished;
	elseif UnitCreatureType("target") == POLYHELPER_CREATURE_TYPE_CRITTER and PolyHelper_Duration > 30 then
		PolyHelper_Duration = 30;
	end

	if PolyHelper_Options.StopCast == "yes" then
		SpellStopCasting();
	end

	PolyHelper_PostMSG("cast");

	PolyHelper_Running = true;
	PolyHelper_StartClock = false;
	PolyHelper_StartTime = nil;

	CastSpell(PolyHelper_SpellID,SpellBookFrame.bookType);
	PolyHelper_LastUnit = PolyHelper_CurName;

	PolyHelper_RetargetLast = true;
	PolyHelper_Casting = false;
end
function Toggle_PolyHelper_Resume()
	if not PolyHelper_IsMage(true) then return; end
	PolyHelper_Resume = true;
end
function Toggle_PolyHelper_Retarget()
	if not PolyHelper_IsMage(true) then return; end
	if not PolyHelper_CurName then return; end
	if UnitName("target") == PolyHelper_CurName and PolyHelper_Running and PolyHelper_IsMorphed() then
		return;
	end
	if PolyHelper_RetargetLast then
		TargetLastTarget();
		if UnitName("target") == PolyHelper_CurName and ((PolyHelper_Running and PolyHelper_IsMorphed()) or not PolyHelper_Running) then
			return;
		end
		if UnitName("target") ~= PolyHelper_CurName then
			TargetByName(PolyHelper_CurName);
		end

		if PolyHelper_Running then
			local f1 = 0; local f2 = 0;
			while (not PolyHelper_IsMorphed() or UnitName("target") ~= PolyHelper_CurName) and f1 < 10 and f2 < 10 do
				TargetNearestEnemy();
				if UnitName("target") == PolyHelper_CurName then f1 = f1 + 1; f2 = 0; else f2 = f2 + 1; end
			end
			if not PolyHelper_IsMorphed() then PolyHelper_RetargetLast = false; end
		else PolyHelper_RetargetLast = false; end
	else
		local f = 0;
		while UnitName("target") ~= PolyHelper_CurName and f < 10 do
			TargetNearestEnemy();
			if UnitName("target") ~= PolyHelper_CurName then f = f + 1; end
		end
	end
end

function PolyHelper_DefaultOptions()
	if not PolyHelper_Options.Channel          then PolyHelper_Options.Channel          = {};       end
	if not PolyHelper_Options.Channel.Solo     then PolyHelper_Options.Channel.Solo     = "NONE";   end
	if not PolyHelper_Options.Channel.Party    then PolyHelper_Options.Channel.Party    = "PARTY";  end
	if not PolyHelper_Options.Channel.Raid     then PolyHelper_Options.Channel.Raid     = "PARTY";  end
	if not PolyHelper_Options.Notify           then PolyHelper_Options.Notify           = {};       end
	if not PolyHelper_Options.Notify.Combat    then PolyHelper_Options.Notify.Combat    = "yes";    end
	if not PolyHelper_Options.Notify.PVP       then PolyHelper_Options.Notify.PVP       = "yes";    end
	if not PolyHelper_Options.Notify.PVPRaw    then PolyHelper_Options.Notify.PVPRaw    = "yes";    end
	if not PolyHelper_Options.Notify.Recast    then PolyHelper_Options.Notify.Recast    = "no";     end
	if not PolyHelper_Options.CountDown        then PolyHelper_Options.CountDown        = 10;       end
	if not PolyHelper_Options.PVPCountDown     then PolyHelper_Options.PVPCountDown     = 5;        end
	if not PolyHelper_Options.VisualCountDown  then PolyHelper_Options.VisualCountDown  = "shown";  end
	if not PolyHelper_Options.DingOnWarning    then PolyHelper_Options.DingOnWarning    = "on";     end
	if not PolyHelper_Options.PVPDingOnWarning then PolyHelper_Options.PVPDingOnWarning = "on";     end
	if not PolyHelper_Options.DingOnFaded      then PolyHelper_Options.DingOnFaded      = "on";     end
	if not PolyHelper_Options.DingSchemeID     then PolyHelper_Options.DingSchemeID     = 1;        end
	if not PolyHelper_Options.MenuDisplay      then PolyHelper_Options.MenuDisplay      = "on";     end
	if not PolyHelper_Options.MenuAnchor       then PolyHelper_Options.MenuAnchor       = "auto";   end
	if not PolyHelper_Options.OverHeadNotice   then PolyHelper_Options.OverHeadNotice   = "on";     end
	if not PolyHelper_Options.OverHeadWarning  then PolyHelper_Options.OverHeadWarning  = "on";     end
	if not PolyHelper_Options.MessageLength    then PolyHelper_Options.MessageLength    = "normal"; end
	if not PolyHelper_Options.WarnShow         then PolyHelper_Options.WarnShow         = "off";    end
	if not PolyHelper_Options.StopCast         then PolyHelper_Options.StopCast         = "yes";    end
	if not PolyHelper_Options.Mode             then PolyHelper_Options.Mode             = "normal"; end
	PolyHelper_Options.Version = POLYHELPER_VERSION;
end
function PolyHelper_OnLoad()
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");

	this:RegisterEvent("CHAT_MSG_SPELL_FAILED_LOCALPLAYER");
	this:RegisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE");

	this:RegisterEvent("CHAT_MSG_SPELL_BREAK_AURA");
	this:RegisterEvent("CHAT_MSG_SPELL_AURA_GONE_OTHER");

	this:RegisterEvent("PLAYER_REGEN_ENABLED");
	this:RegisterEvent("PLAYER_DEAD");

	SLASH_POLYHELPER1 = "/polymorphhelper";
	SLASH_POLYHELPER2 = "/polyhelper";
	SLASH_POLYHELPER3 = "/ph";
	SlashCmdList["POLYHELPER"] = function(msg)
		PolyHelper_Command(msg);
	end

	SLASH_POLYHELPER_WARN1 = "/phwarn";
	SlashCmdList["POLYHELPER_WARN"] = function(msg)
		Toggle_PolyHelper_Warn();
	end
	SLASH_POLYHELPER_CAST1 = "/phcast";
	SlashCmdList["POLYHELPER_CAST"] = function(msg)
		Toggle_PolyHelper_Cast();
	end
	SLASH_POLYHELPER_RESUME1 = "/phresume";
	SlashCmdList["POLYHELPER_RESUME"] = function(msg)
		Toggle_PolyHelper_Resume();
	end
	SLASH_POLYHELPER_RETARGET1 = "/phretarget";
	SlashCmdList["POLYHELPER_RETARGET"] = function(msg)
		Toggle_PolyHelper_Retarget();
	end

	PolyHelper_GetPolyMorphSpell();

	PolyHelper_CurTime = 0;
	PolyHelper_UpdateTime = 0;

	PolyHelper_DefaultOptions();

	PolyHelper_ChatPrint(POLYHELPER_WELCOME, "notice");
	PolyHelper_OverHeadPrint(POLYHELPER_WELCOME, 5, "notice");
end
function PolyHelperUI_OnLoad()
	PolyHelperUI_CountDown:Hide();
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
end

function IB_PolyHelperUI_OnLoad()
	this.info = {
		name = POLYHELPER_NAME.." ("..POLYHELPER_DISABLED_TEXT..")",
		version = POLYHELPER_VERSION_IB,
	};
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
end

function TitanPanel_PolyHelperUI_OnLoad()
	this.registry = {
		id = "PolyHelperUI",
		menuText = POLYHELPER_NAME.." ("..POLYHELPER_DISABLED_TEXT..")",
		buttonTextFunction = "TitanPanel_GetPolyHelperUIText",
		iconWidth = 0,
		savedVariables = {
			ShowIcon = 1,
			ShowLabelText = 1,
			ShowColoredText = 1,
		},
	};
	TitanPanelButton_OnLoad();
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
end
function TitanPanel_GetPolyHelperUIText(id)
	local button,id = TitanUtils_GetButton(id,true);
	if not TitanPanel_PolyHelperText then TitanPanel_PolyHelperText = ""; end
	if TitanGetVar("PolyHelperUI", "ShowColoredText") then
		if not TitanPanel_PolyHelperTextColor then TitanPanel_PolyHelperTextColor = "ffffff"; end
		return "|cff"..TitanPanel_PolyHelperTextColor..TitanPanel_PolyHelperText.."|r";
	else
		return TitanPanel_PolyHelperText;
	end
end
function TitanPanelRightClickMenu_PreparePolyHelperUIMenu()
	TitanPanelRightClickMenu_AddTitle(TitanPlugins["PolyHelperUI"].menuText);

	TitanPanelRightClickMenu_AddToggleIcon("PolyHelperUI");
	TitanPanelRightClickMenu_AddToggleLabelText("PolyHelperUI");
	TitanPanelRightClickMenu_AddToggleColoredText("PolyHelperUI");

	TitanPanelRightClickMenu_AddSpacer();	
	TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, "PolyHelperUI", TITAN_PANEL_MENU_FUNC_HIDE);
end

function PolyHelperUI_OnEvent(event)
	if not PolyHelper_IsMage() then return; end

	if (event == "PLAYER_ENTERING_WORLD") then
		if (this:GetName() == "PolyHelperUI_CountDown") then
			PolyHelperUI_CountDownTimer:SetTextHeight(16);
			PolyHelperUI_CountDownTimer:Show();
			PolyHelperUI_CountDownIcon:SetTexture("Interface\\AddOns\\PolyHelper\\Icons\\Polymorph");
			PolyHelperUI_CountDownIcon:SetWidth(16);
		elseif (this:GetName() == "IB_PolyHelperUI_CountDown") then
			this.info.name = POLYHELPER_NAME;
			IB_PolyHelperUI_CountDownIcon:SetTexture("Interface\\AddOns\\PolyHelper\\Icons\\Polymorph");
			IB_PolyHelperUI_CountDownIcon:SetWidth(16);
		elseif (this:GetName() == "TitanPanelPolyHelperUIButton") then
			this.registry.menuText = POLYHELPER_NAME;
			this.registry.icon = "Interface\\AddOns\\PolyHelper\\Icons\\Polymorph";
			this.registry.iconWidth = 16;
		end
	end
end

function PolyHelper_OnEvent(event)
	if not arg1 then arg1 = ""; end
	if PolyHelper_Options.Mode == "debug" then
		PolyHelper_ChatPrint(POLYHELPER_TEXT..": Event: "..event.."; Arg: "..arg1, "yellow");
	end

	if (event == "VARIABLES_LOADED") then
		if (myAddOnsFrame) then
			myAddOnsList.PolyHelper = {name = POLYHELPER_NAME, description = POLYHELPER_DESC_TEXT, version = POLYHELPER_VERSION, releaseDate = 'September 11, 2005', author = 'Chria', email = 'chria.wow@gmail.com', category = MYADDONS_CATEGORY_CLASS,};
		end
		PolyHelper_DefaultOptions();
		PolyHelperUI_InitializeMenu();
		return;
	end

	if not PolyHelper_IsMage() then return; end

	if (event == "PLAYER_ENTERING_WORLD") then
		if (myAddOnsFrame) then
			if (not myAddOnsList.PolyHelper) then
				myAddOnsList.PolyHelper = {name = POLYHELPER_NAME, description = POLYHELPER_DESC_TEXT, version = POLYHELPER_VERSION, releaseDate = 'September 11, 2005', author = 'Chria', email = 'chria.wow@gmail.com', category = MYADDONS_CATEGORY_CLASS,};
			end
			myAddOnsList.PolyHelper.frame = this:GetName();
		end
		PolyHelper_Running = false;
	end

	if (event == "PLAYER_REGEN_ENABLED" or event == "PLAYER_DEAD") and PolyHelper_Running then
		PolyHelper_CurName = "";
		PolyHelper_Running = false;
		PolyHelper_StartClock = false;
		PolyHelper_StartTime = nil;
	end

	if PolyHelper_Running then
		if not strfind(arg1, POLYHELPER_SPELLNAME_POLYMORPH) then
			return;
		end
		if (event == "CHAT_MSG_SPELL_FAILED_LOCALPLAYER") then
			local failReason = string.sub(arg1,strfind(arg1,": ")+2);
			PolyHelper_PostMSG("fail",failReason);
			PolyHelper_CurName = "";
			PolyHelper_Running = false;
		elseif ((event == "CHAT_MSG_SPELL_SELF_DAMAGE" or event == "CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE") and not PolyHelper_StartClock) then
			if not strfind(arg1, PolyHelper_CurName) then
				return;
			end
			if PolyHelper_Options.OverHeadWarning == "on" then
				PolyHelper_OverHeadPrint(POLYHELPER_TEXT..": "..string.format(POLYHELPER_WARNINGS_FADES,PolyHelper_CurName,PolyHelper_Duration), POLYHELPER_OHNOTICE_HOLD, "orange");
			end
			PolyHelper_StartClock = true;
			PolyHelper_StartTime = nil;
			if (PolyHelper_IsPlayer) then
				PolyHelper_Diminished = PolyHelper_Diminished * 2;
			end
		elseif (event == "CHAT_MSG_SPELL_BREAK_AURA") then
			if not strfind(arg1, PolyHelper_CurName) then
				return;
			end
			if PolyHelper_StartTime == nil or (PolyHelper_CurTime - PolyHelper_StartTime) < 1 then
				return;
			end
			if PolyHelper_Options.OverHeadWarning == "on" then
				PolyHelper_OverHeadPrint(POLYHELPER_TEXT..": "..string.format(POLYHELPER_WARNINGS_BROKEN,PolyHelper_CurName), POLYHELPER_OHNOTICE_HOLD, "orange");
			end
			PolyHelper_LastEnd = GetTime();
			PolyHelper_Running = false;
			if PolyHelper_Options.DingOnFaded == "on" then
				PlaySound(PolyHelper_DingSchemes[PolyHelper_Options.DingSchemeID]);
			end
		elseif (event == "CHAT_MSG_SPELL_AURA_GONE_OTHER") then
			if not strfind(arg1, PolyHelper_CurName) then
				return;
			end
			if PolyHelper_StartTime == nil or (PolyHelper_CurTime - PolyHelper_StartTime) < 1 then
				return;
			end
			if PolyHelper_Options.OverHeadWarning == "on" then
				PolyHelper_OverHeadPrint(POLYHELPER_TEXT..": "..string.format(POLYHELPER_WARNINGS_FADED,PolyHelper_CurName), POLYHELPER_OHNOTICE_HOLD, "orange");
			end
			PolyHelper_LastEnd = GetTime();
			PolyHelper_Running = false;
			if PolyHelper_Options.DingOnFaded == "on" then
				PlaySound(PolyHelper_DingSchemes[PolyHelper_Options.DingSchemeID]);
			end
		end
	end
end
function PolyHelper_OnUpdate(elapsed)
	PolyHelper_CurTime = PolyHelper_CurTime + elapsed;

	local timeLeft = PolyHelper_UpdateTime - elapsed;
	if timeLeft > 0 then
		PolyHelper_UpdateTime = timeLeft;
		return;
	end
	PolyHelper_UpdateTime = PolyHelper_Frequency;

	if not PolyHelper_IsMage() then return; end

	if not PolyHelper_Running and not PolyHelper_Casting and PolyHelper_CurName ~= "" and GetTime() > PolyHelper_LastEnd + 50 then
		PolyHelper_CurName = "";
	end

	if (PolyHelperUI_Popup:IsVisible()) then
		if (not MouseIsOver(PolyHelperUI_Popup) and not MouseIsOver(PolyHelperUI_CountDown) and not MouseIsOver(IB_PolyHelperUI_CountDown) and not MouseIsOver(TitanPanelPolyHelperUIButton)) then
			PolyHelperUI_HideMenu();
		end
	end

	if PolyHelper_Resume and not PolyHelper_Running and PolyHelper_StartClock and PolyHelper_StartTime ~= nil then
		if (PolyHelper_Duration - math.floor(PolyHelper_CurTime - PolyHelper_StartTime)) > 0 then
			PolyHelper_Running = true;
			if PolyHelper_Options.OverHeadNotice == "on" then
				PolyHelper_OverHeadPrint(POLYHELPER_TEXT..": "..POLYHELPER_NOTICES_RESUME, POLYHELPER_OHNOTICE_HOLD, "yellow");
			end
		end
	end
	PolyHelper_Resume = false;

	if PolyHelper_Running then
		this.TimerReset = false;
		if not PolyHelperUI_CountDown:IsVisible() and (PolyHelper_Options.VisualCountDown == "shown" or PolyHelper_Options.VisualCountDown == "auto") then
			PolyHelperUI_CountDown:Show();
		end
		if PolyHelper_StartTime == nil then
			PolyHelper_StartTime = PolyHelper_CurTime;
			if PolyHelper_IsPlayer then
				this.CountDown = PolyHelper_Options.PVPCountDown;
			else
				this.CountDown = PolyHelper_Options.CountDown;
			end
		end
		local timeDiff = math.floor(PolyHelper_CurTime - PolyHelper_StartTime);
		if PolyHelper_StartClock then
			local secLeft = PolyHelper_Duration - timeDiff;
			if secLeft <= -10 then
				if PolyHelper_Options.OverHeadWarning == "on" then
					PolyHelper_OverHeadPrint(POLYHELPER_TEXT..": "..string.format(POLYHELPER_WARNINGS_FADE_TIMEOUT,PolyHelper_CurName), POLYHELPER_OHWARNING_HOLD, "red");
				end
				PolyHelper_LastEnd = GetTime() - 10;
				PolyHelper_Running = false;
				if PolyHelper_Options.DingOnFaded == "on" then
					PlaySound(PolyHelper_DingSchemes[PolyHelper_Options.DingSchemeID]);
				end
			elseif (secLeft <= this.CountDown and secLeft > 0) then
				if PolyHelper_Options.OverHeadWarning == "on" then
					PolyHelper_OverHeadPrint(POLYHELPER_TEXT..": "..string.format(POLYHELPER_WARNINGS_FADES,PolyHelper_CurName,secLeft), POLYHELPER_OHWARNING_HOLD, "orange");
				end
				if PolyHelper_IsPlayer and this.CountDown == PolyHelper_Options.PVPCountDown and PolyHelper_Options.PVPDingOnWarning == "on" then
					PlaySound(PolyHelper_DingSchemes[PolyHelper_Options.DingSchemeID]);
				elseif not PolyHelper_IsPlayer and this.CountDown == PolyHelper_Options.CountDown and PolyHelper_Options.DingOnWarning == "on" then
					PlaySound(PolyHelper_DingSchemes[PolyHelper_Options.DingSchemeID]);
				end
				this.CountDown = secLeft - 1;
			end
			local color = PolyHelper_Colors("white",{n=0});
			if secLeft < 0 then
				color = PolyHelper_Colors("red",{n=0});
			end
			if PolyHelperUI_CountDown:IsVisible() then
				PolyHelperUI_CountDownTimer:SetText(secLeft);
				PolyHelperUI_CountDownTimer:SetTextColor(color.r, color.g, color.b);
			end
			if IB_PolyHelperUI_CountDown:IsVisible() then
				IB_PolyHelperUI_CountDownComboText:SetText(secLeft);
				IB_PolyHelperUI_CountDownComboText:SetTextColor(color.r, color.g, color.b);
			end
			TitanPanel_PolyHelperText = secLeft;
			TitanPanel_PolyHelperTextColor = colortohex(color);
		else
			local secLeft = 10 - timeDiff;
			if secLeft <= 0 then
				PolyHelper_OverHeadPrint(POLYHELPER_TEXT..": "..string.format(POLYHELPER_WARNINGS_CAST_TIMEOUT,PolyHelper_CurName), POLYHELPER_OHWARNING_HOLD, "red");
				PolyHelper_CurName = "";
				PolyHelper_Running = false;
			end
			local color = PolyHelper_Colors("magenta",{n=0});
			if PolyHelperUI_CountDown:IsVisible() then
				PolyHelperUI_CountDownTimer:SetText(secLeft);
				PolyHelperUI_CountDownTimer:SetTextColor(color.r, color.g, color.b);
			end
			if IB_PolyHelperUI_CountDown:IsVisible() then
				IB_PolyHelperUI_CountDownComboText:SetText(secLeft);
				IB_PolyHelperUI_CountDownComboText:SetTextColor(color.r, color.g, color.b);
			end
			TitanPanel_PolyHelperText = secLeft;
			TitanPanel_PolyHelperTextColor = colortohex(color);
		end
	else
		if not PolyHelperUI_CountDown:IsVisible() and PolyHelper_Options.VisualCountDown == "shown" then
			PolyHelperUI_CountDown:Show();
		elseif PolyHelperUI_CountDown:IsVisible() and PolyHelper_Options.VisualCountDown ~= "shown" then
			PolyHelperUI_CountDown:Hide();
		end
		if not this.TimerReset then
			local color = PolyHelper_Colors("notice",{n=0});
			local defaulttext = "--";
			if PolyHelperUI_CountDown:IsVisible() then
				PolyHelperUI_CountDownTimer:SetText(defaulttext);
				PolyHelperUI_CountDownTimer:SetTextColor(color.r, color.g, color.b);
			end
			if IB_PolyHelperUI_CountDown:IsVisible() then
				IB_PolyHelperUI_CountDownComboText:SetText(defaulttext);
				IB_PolyHelperUI_CountDownComboText:SetTextColor(color.r, color.g, color.b);
			end
			TitanPanel_PolyHelperText = defaulttext;
			TitanPanel_PolyHelperTextColor = colortohex(color);
			this.TimerReset = true;
		end
	end
	if (TitanPanelBarButton~=nil) then
		TitanPanelButton_UpdateButton("PolyHelperUI");
	end
end
function PolyHelper_Command(command)
	if not PolyHelper_IsMage(true) then return; end

	local i,j, cmd, param = string.find(command, "^([^ ]+) (.+)$");
	if (not cmd) then cmd = command; end
	if (not cmd) then cmd = ""; end
	if (not param) then param = ""; end


	local value = "";

	if ((cmd == "") or (cmd == POLYHELPER_CMD_HELP)) then
		PolyHelper_ChatPrint(POLYHELPER_CMD_USAGE,"green");
		PolyHelper_ChatPrint(POLYHELPER_CMD_COMMANDS,"white");
		PolyHelper_PrintHelpLN(POLYHELPER_CMD_SOLO,         "multi",  POLYHELPER_GLOBAL_VALID_CHANNELS.SOLO,  POLYHELPER_VALID_CHANNELS.SOLO,  PolyHelper_Options.Channel.Solo,     "white", "ffaaaaff", POLYHELPER_CMD_SOLO_INFO,         "ff66ff66");
		PolyHelper_PrintHelpLN(POLYHELPER_CMD_PARTY,        "multi",  POLYHELPER_GLOBAL_VALID_CHANNELS.PARTY, POLYHELPER_VALID_CHANNELS.PARTY, PolyHelper_Options.Channel.Party,    "white", "ffaaaaff", POLYHELPER_CMD_PARTY_INFO,        "ff66ff66");
		PolyHelper_PrintHelpLN(POLYHELPER_CMD_RAID,         "multi",  POLYHELPER_GLOBAL_VALID_CHANNELS.RAID,  POLYHELPER_VALID_CHANNELS.RAID,  PolyHelper_Options.Channel.Raid,     "white", "ffaaaaff", POLYHELPER_CMD_RAID_INFO,         "ff66ff66");
		PolyHelper_PrintHelpLN(POLYHELPER_CMD_NOTIFYCOMBAT, "multi",  POLYHELPER_GLOBAL_VALID_STATES_YESNO,   POLYHELPER_VALID_STATES_YESNO,   PolyHelper_Options.Notify.Combat,    "white", "ffaaaaff", POLYHELPER_CMD_NOTIFYCOMBAT_INFO, "ff66ff66");
		PolyHelper_PrintHelpLN(POLYHELPER_CMD_NOTIFYPVP,    "multi",  POLYHELPER_GLOBAL_VALID_STATES_YESNO,   POLYHELPER_VALID_STATES_YESNO,   PolyHelper_Options.Notify.PVP,       "white", "ffaaaaff", POLYHELPER_CMD_NOTIFYPVP_INFO,    "ff66ff66");
		PolyHelper_PrintHelpLN(POLYHELPER_CMD_NOTIFYRECAST, "multi",  POLYHELPER_GLOBAL_VALID_STATES_YESNO,   POLYHELPER_VALID_STATES_YESNO,   PolyHelper_Options.Notify.Recast,    "white", "ffaaaaff", POLYHELPER_CMD_NOTIFYRECAST_INFO, "ff66ff66");
		PolyHelper_PrintHelpLN(POLYHELPER_CMD_CDWARN,       "single", nil,                                    POLYHELPER_CMD_CDWARN_DISP,      PolyHelper_Options.CountDown,        "white", "ffaaaaff", POLYHELPER_CMD_CDWARN_INFO,       "ff66ff66");
		PolyHelper_PrintHelpLN(POLYHELPER_CMD_PVPCDWARN,    "single", nil,                                    POLYHELPER_CMD_PVPCDWARN_DISP,   PolyHelper_Options.PVPCountDown,     "white", "ffaaaaff", POLYHELPER_CMD_PVPCDWARN_INFO,    "ff66ff66");
		PolyHelper_PrintHelpLN(POLYHELPER_CMD_CDDISPLAY,    "multi",  POLYHELPER_GLOBAL_VALID_STATES_DISPLAY, POLYHELPER_VALID_STATES_DISPLAY, PolyHelper_Options.VisualCountDown,  "white", "ffaaaaff", POLYHELPER_CMD_CDDISPLAY_INFO,    "ff66ff66");
		PolyHelper_PrintHelpLN(POLYHELPER_CMD_DINGWARN,     "multi",  POLYHELPER_GLOBAL_VALID_STATES_ONOFF,   POLYHELPER_VALID_STATES_ONOFF,   PolyHelper_Options.DingOnWarning,    "white", "ffaaaaff", string.format(POLYHELPER_CMD_DINGWARN_INFO,    PolyHelper_Options.CountDown),       "ff66ff66");
		PolyHelper_PrintHelpLN(POLYHELPER_CMD_PVPDINGWARN,  "multi",  POLYHELPER_GLOBAL_VALID_STATES_ONOFF,   POLYHELPER_VALID_STATES_ONOFF,   PolyHelper_Options.PVPDingOnWarning, "white", "ffaaaaff", string.format(POLYHELPER_CMD_PVPDINGWARN_INFO, PolyHelper_Options.PVPCountDown),    "ff66ff66");
		PolyHelper_PrintHelpLN(POLYHELPER_CMD_DINGFADE,     "multi",  POLYHELPER_GLOBAL_VALID_STATES_ONOFF,   POLYHELPER_VALID_STATES_ONOFF,   PolyHelper_Options.DingOnFaded,      "white", "ffaaaaff", POLYHELPER_CMD_DINGFADE_INFO,     "ff66ff66");
		PolyHelper_PrintHelpLN(POLYHELPER_CMD_DINGSCHEME,   "single", nil,                                    POLYHELPER_CMD_DINGSCHEME_DISP,  PolyHelper_Options.DingSchemeID,     "white", "ffaaaaff", string.format(POLYHELPER_CMD_DINGSCHEME_INFO,  table.getn(PolyHelper_DingSchemes)), "ff66ff66");
		PolyHelper_PrintHelpLN(POLYHELPER_CMD_MENUDISPLAY,  "multi",  POLYHELPER_GLOBAL_VALID_STATES_ONOFF,   POLYHELPER_VALID_STATES_ONOFF,   PolyHelper_Options.MenuDisplay,      "white", "ffaaaaff", POLYHELPER_CMD_MENUDISPLAY_INFO,  "ff66ff66");
		PolyHelper_PrintHelpLN(POLYHELPER_CMD_MENUPOS,      "multi",  POLYHELPER_GLOBAL_VALID_STATES_ANCHOR,  POLYHELPER_VALID_STATES_ANCHOR,  PolyHelper_Options.MenuAnchor,       "white", "ffaaaaff", POLYHELPER_CMD_MENUPOS_INFO,      "ff66ff66");
		PolyHelper_PrintHelpLN(POLYHELPER_CMD_OHN,          "multi",  POLYHELPER_GLOBAL_VALID_STATES_ONOFF,   POLYHELPER_VALID_STATES_ONOFF,   PolyHelper_Options.OverHeadNotice,   "white", "ffaaaaff", POLYHELPER_CMD_OHN_INFO,          "ff66ff66");
		PolyHelper_PrintHelpLN(POLYHELPER_CMD_OHW,          "multi",  POLYHELPER_GLOBAL_VALID_STATES_ONOFF,   POLYHELPER_VALID_STATES_ONOFF,   PolyHelper_Options.OverHeadWarning,  "white", "ffaaaaff", POLYHELPER_CMD_OHW_INFO,          "ff66ff66");
		PolyHelper_PrintHelpLN(POLYHELPER_CMD_MSGLENGTH,    "multi",  POLYHELPER_GLOBAL_VALID_LENGTHS,        POLYHELPER_VALID_LENGTHS,        PolyHelper_Options.MessageLength,    "white", "ffaaaaff", POLYHELPER_CMD_MSGLENGTH_INFO,    "ff66ff66");
		PolyHelper_PrintHelpLN(POLYHELPER_CMD_WARNSHOW,     "multi",  POLYHELPER_GLOBAL_VALID_STATES_ONOFF,   POLYHELPER_VALID_STATES_ONOFF,   PolyHelper_Options.WarnShow,         "white", "ffaaaaff", POLYHELPER_CMD_WARNSHOW_INFO,     "ff66ff66");
		PolyHelper_PrintHelpLN(POLYHELPER_CMD_STOPCAST,     "multi",  POLYHELPER_GLOBAL_VALID_STATES_YESNO,   POLYHELPER_VALID_STATES_YESNO,   PolyHelper_Options.StopCast,         "white", "ffaaaaff", POLYHELPER_CMD_STOPCAST_INFO,     "ff66ff66");
		PolyHelper_PrintHelpLN(POLYHELPER_CMD_MODE,         "multi",  POLYHELPER_GLOBAL_VALID_MODES,          POLYHELPER_VALID_MODES,          PolyHelper_Options.Mode,             "white", "ffaaaaff", POLYHELPER_CMD_MODE_INFO,         "ff66ff66");
		PolyHelper_PrintHelpLN(POLYHELPER_CMD_HELP,         "",       nil,                                    nil,                             nil,                                 "white", nil,        POLYHELPER_CMD_HELP_INFO,         "ff66ff66");

	elseif (cmd == POLYHELPER_CMD_SOLO) then
		value = PolyHelper_PeformCommand(string.upper(param), "multi", POLYHELPER_GLOBAL_VALID_CHANNELS.SOLO, POLYHELPER_VALID_CHANNELS.SOLO, POLYHELPER_CMD_SOLO_NOTICE, "");
		if value ~= nil then
			PolyHelper_Options.Channel.Solo = string.upper(value);
		end
	elseif (cmd == POLYHELPER_CMD_PARTY) then
		value = PolyHelper_PeformCommand(string.upper(param), "multi", POLYHELPER_GLOBAL_VALID_CHANNELS.PARTY, POLYHELPER_VALID_CHANNELS.PARTY, POLYHELPER_CMD_PARTY_NOTICE, "");
		if value ~= nil then
			PolyHelper_Options.Channel.Party = string.upper(value);
		end
	elseif (cmd == POLYHELPER_CMD_RAID) then
		value = PolyHelper_PeformCommand(string.upper(param), "multi", POLYHELPER_GLOBAL_VALID_CHANNELS.RAID, POLYHELPER_VALID_CHANNELS.RAID, POLYHELPER_CMD_RAID_NOTICE, "");
		if value ~= nil then
			PolyHelper_Options.Channel.Raid = string.upper(value);
		end

	elseif (cmd == POLYHELPER_CMD_NOTIFYCOMBAT) then
		value = PolyHelper_PeformCommand(string.lower(param), "multi", POLYHELPER_GLOBAL_VALID_STATES_YESNO, POLYHELPER_VALID_STATES_YESNO, POLYHELPER_CMD_NOTIFYCOMBAT_NOTICE, "");
		if value ~= nil then
			PolyHelper_Options.Notify.Combat = value;
		end
	elseif (cmd == POLYHELPER_CMD_NOTIFYPVP) then
		value = PolyHelper_PeformCommand(string.lower(param), "multi", POLYHELPER_GLOBAL_VALID_STATES_YESNO, POLYHELPER_VALID_STATES_YESNO, POLYHELPER_CMD_NOTIFYPVP_NOTICE, "");
		if value ~= nil then
			PolyHelper_Options.Notify.PVP = value;
		end
	elseif (cmd == POLYHELPER_CMD_NOTIFYRECAST) then
		value = PolyHelper_PeformCommand(string.lower(param), "multi", POLYHELPER_GLOBAL_VALID_STATES_YESNO, POLYHELPER_VALID_STATES_YESNO, POLYHELPER_CMD_NOTIFYRECAST_NOTICE, "");
		if value ~= nil then
			PolyHelper_Options.Notify.Recast = value;
		end

	elseif (cmd == POLYHELPER_CMD_CDWARN) then
		value = PolyHelper_PeformCommand(param, "single", nil, "numeric", POLYHELPER_CMD_CDWARN_NOTICE, "");
		if value ~= nil then
			PolyHelper_Options.CountDown = value;
		end
	elseif (cmd == POLYHELPER_CMD_PVPCDWARN) then
		value = PolyHelper_PeformCommand(param, "single", nil, "numeric", POLYHELPER_CMD_PVPCDWARN_NOTICE, POLYHELPER_CMD_PVPCDWARN_NOTICEXTRA);
		if value ~= nil then
			PolyHelper_Options.PVPCountDown = value;
		end
	elseif (cmd == POLYHELPER_CMD_CDDISPLAY) then
		value = PolyHelper_PeformCommand(string.lower(param), "multi", POLYHELPER_GLOBAL_VALID_STATES_DISPLAY, POLYHELPER_VALID_STATES_DISPLAY, POLYHELPER_CMD_CDDISPLAY_NOTICE, "");
		if value ~= nil then
			PolyHelper_Options.VisualCountDown = value;
			if not PolyHelperUI_CountDown:IsVisible() and (PolyHelper_Options.VisualCountDown == "shown") then
				PolyHelperUI_CountDown:Show();
			elseif PolyHelperUI_CountDown:IsVisible() and (PolyHelper_Options.VisualCountDown == "hidden") then
				PolyHelperUI_CountDown:Hide();
			end
			if PolyHelper_Options.VisualCountDown == "shown" then
				PolyHelperUI_CountDown:Show();
			elseif PolyHelper_Options.VisualCountDown == "hidden" then
				PolyHelperUI_CountDown:Hide();
			end
		end

	elseif (cmd == POLYHELPER_CMD_DINGWARN) then
		value = PolyHelper_PeformCommand(string.lower(param), "multi", POLYHELPER_GLOBAL_VALID_STATES_ONOFF, POLYHELPER_VALID_STATES_ONOFF, POLYHELPER_CMD_DINGWARN_NOTICE, "");
		if value ~= nil then
			PolyHelper_Options.DingOnWarning = value;
		end
	elseif (cmd == POLYHELPER_CMD_PVPDINGWARN) then
		value = PolyHelper_PeformCommand(string.lower(param), "multi", POLYHELPER_GLOBAL_VALID_STATES_ONOFF, POLYHELPER_VALID_STATES_ONOFF, POLYHELPER_CMD_PVPDINGWARN_NOTICE, POLYHELPER_CMD_PVPDINGWARN_NOTICEXTRA);
		if value ~= nil then
			PolyHelper_Options.PVPDingOnWarning = value;
		end
	elseif (cmd == POLYHELPER_CMD_DINGFADE) then
		value = PolyHelper_PeformCommand(string.lower(param), "multi", POLYHELPER_GLOBAL_VALID_STATES_ONOFF, POLYHELPER_VALID_STATES_ONOFF, POLYHELPER_CMD_DINGFADE_NOTICE, "");
		if value ~= nil then
			PolyHelper_Options.DingOnFaded = value;
		end
	elseif (cmd == POLYHELPER_CMD_DINGSCHEME) then
		value = PolyHelper_PeformCommand(param, "range", nil, {mode = "numeric", min = 1, max = table.getn(PolyHelper_DingSchemes)}, POLYHELPER_CMD_DINGSCHEME_NOTICE, "");
		if value ~= nil then
			PolyHelper_Options.DingSchemeID = value;
			PlaySound(PolyHelper_DingSchemes[PolyHelper_Options.DingSchemeID]);
		end

	elseif (cmd == POLYHELPER_CMD_MENUDISPLAY) then
		value = PolyHelper_PeformCommand(string.lower(param), "multi", POLYHELPER_GLOBAL_VALID_STATES_ONOFF, POLYHELPER_VALID_STATES_ONOFF, POLYHELPER_CMD_MENUDISPLAY_NOTICE, "");
		if value ~= nil then
			PolyHelper_Options.MenuDisplay = value;
		end
	elseif (cmd == POLYHELPER_CMD_MENUPOS) then
		value = PolyHelper_PeformCommand(string.lower(param), "multi", POLYHELPER_GLOBAL_VALID_STATES_ANCHOR, POLYHELPER_VALID_STATES_ANCHOR, POLYHELPER_CMD_MENUPOS_NOTICE, "");
		if value ~= nil then
			PolyHelper_Options.MenuAnchor = value;
		end

	elseif (cmd == POLYHELPER_CMD_OHN) then
		value = PolyHelper_PeformCommand(string.lower(param), "multi", POLYHELPER_GLOBAL_VALID_STATES_ONOFF, POLYHELPER_VALID_STATES_ONOFF, POLYHELPER_CMD_OHN_NOTICE, "");
		if value ~= nil then
			PolyHelper_Options.OverHeadNotice = value;
		end
	elseif (cmd == POLYHELPER_CMD_OHW) then
		value = PolyHelper_PeformCommand(string.lower(param), "multi", POLYHELPER_GLOBAL_VALID_STATES_ONOFF, POLYHELPER_VALID_STATES_ONOFF, POLYHELPER_CMD_OHW_NOTICE, "");
		if value ~= nil then
			PolyHelper_Options.OverHeadWarning = value;
		end

	elseif (cmd == POLYHELPER_CMD_MSGLENGTH) then
		value = PolyHelper_PeformCommand(string.lower(param), "multi", POLYHELPER_GLOBAL_VALID_LENGTHS, POLYHELPER_VALID_LENGTHS, POLYHELPER_CMD_MSGLENGTH_NOTICE, "");
		if value ~= nil then
			PolyHelper_Options.MessageLength = value;
		end
	elseif (cmd == POLYHELPER_CMD_WARNSHOW) then
		value = PolyHelper_PeformCommand(string.lower(param), "multi", POLYHELPER_GLOBAL_VALID_STATES_ONOFF, POLYHELPER_VALID_STATES_ONOFF, POLYHELPER_CMD_WARNSHOW_NOTICE, "");
		if value ~= nil then
			PolyHelper_Options.WarnShow = value;
		end
	elseif (cmd == POLYHELPER_CMD_STOPCAST) then
		value = PolyHelper_PeformCommand(string.lower(param), "multi", POLYHELPER_GLOBAL_VALID_STATES_YESNO, POLYHELPER_VALID_STATES_YESNO, POLYHELPER_CMD_STOPCAST_NOTICE, "");
		if value ~= nil then
			PolyHelper_Options.StopCast = value;
		end
	elseif (cmd == POLYHELPER_CMD_MODE) then
		value = PolyHelper_PeformCommand(string.lower(param), "multi", POLYHELPER_GLOBAL_VALID_MODES, POLYHELPER_VALID_MODES, POLYHELPER_CMD_MODE_NOTICE, "");
		if value ~= nil then
			PolyHelper_Options.Mode = value;
		end
	end
end

function PolyHelper_PrintHelpLN(command,mode,arg1,arg2,arg3,color,highlight,desc,descolor)
	local lineFormat = "  /polyhelper "..command.." %s |c"..descolor.."- "..desc.."|r";
	local optionsValue = "";
	if mode == "single" then
		optionsValue = "<"..arg2.."> |c"..highlight.."("..POLYHELPER_CURRENT_TEXT..":|r "..arg3.."|c"..highlight..")|r";
	elseif mode == "multi" then
		for id,option in arg2 do
			if optionsValue ~= "" then
				optionsValue = optionsValue.." | ";
			end
			if string.lower(arg1[id]) == string.lower(arg3) then
				optionsValue = optionsValue.."|c"..highlight..option.."|r";
			else
				optionsValue = optionsValue..option;
			end
		end
		if optionsValue ~= "" then
			optionsValue = "<"..optionsValue..">";
		end
	end
	PolyHelper_ChatPrint(string.format(lineFormat, optionsValue),color);
end
function PolyHelper_PeformCommand(param,mode,arg1,arg2,str,xtra)
	if param == "" then
		PolyHelper_OverHeadPrint(POLYHELPER_TEXT..": "..string.format(POLYHELPER_CMD_ERROR_NOTPASSED,str,xtra),POLYHELPER_OHERROR_HOLD,"red");
		return nil;
	end
	if mode == "multi" then
		local id = PolyHelper_InArray(param,arg2,true);
		if not id then
			PolyHelper_OverHeadPrint(POLYHELPER_TEXT..": "..string.format(POLYHELPER_CMD_ERROR_INVALID,str,xtra),POLYHELPER_OHERROR_HOLD,"red");
			return nil;
		end
		param = arg1[id];
	elseif mode == "single" then
		if arg2 == "numeric" then
			param = tonumber(param);
			if param == nil then
				PolyHelper_OverHeadPrint(POLYHELPER_TEXT..": "..string.format(POLYHELPER_CMD_ERROR_NOTNUMBER,str,xtra),POLYHELPER_OHERROR_HOLD,"red");
				return nil;
			end
		end
	elseif mode == "range" then
		if arg2.mode == "numeric" then
			param = tonumber(param);
			if param == nil then
				PolyHelper_OverHeadPrint(POLYHELPER_TEXT..": "..string.format(POLYHELPER_CMD_ERROR_NOTNUMBER,str,xtra),POLYHELPER_OHERROR_HOLD,"red");
				return nil;
			end

			if param < arg2.min or param > arg2.max then
				PolyHelper_OverHeadPrint(POLYHELPER_TEXT..": "..string.format(POLYHELPER_CMD_ERROR_OUTOFRANGE,str,arg2.min,arg2.max,xtra),POLYHELPER_OHERROR_HOLD,"red");
				return nil;
			end
		end
	end
	PolyHelper_OverHeadPrint(POLYHELPER_TEXT..": "..string.format(POLYHELPER_CMD_SUCCESS,str,param,xtra),POLYHELPER_OHOTHER_HOLD,"green");
	return param;
end

function PolyHelper_Colors(color,custom)
	if color == "custom" and custom.n == 3 then
		return {r=custom[1], g=custom[2], b=custom[3]};
	end
	local colors = {
		red     = {r=1.0, g=0.0, b=0.0},
		orange  = {r=1.0, g=0.5, b=0.0},
		yellow  = {r=1.0, g=1.0, b=0.0},
		green   = {r=0.0, g=1.0, b=0.0},
		cyan    = {r=0.0, g=1.0, b=1.0},
		blue    = {r=0.0, g=0.0, b=1.0},
		magenta = {r=1.0, g=0.0, b=1.0},
		white   = {r=1.0, g=1.0, b=1.0},
		black   = {r=0.0, g=0.0, b=0.0},

		notice  = {r=0.8, g=0.8, b=0.2},
	};
	if colors[color] then
		return colors[color];
	end
	return colors.notice;
end
function PolyHelper_OverHeadPrint(str,time,color,...)
	if (PolyHelperUI_MessageFrame) then
		local colors = PolyHelper_Colors(color,arg);
		PolyHelperUI_MessageFrame:AddMessage(str, colors.r, colors.g, colors.b, 1.0, time);
	end
end
function PolyHelper_ChatPrint(str,color,...)
	if (DEFAULT_CHAT_FRAME) then
		local colors = PolyHelper_Colors(color,arg);
		DEFAULT_CHAT_FRAME:AddMessage(str, colors.r, colors.g, colors.b);
	end
end
function PolyHelper_InArray(needle,haystack,insensitive)
	if insensitive == nil then insensitive = false; end
	for id,item in haystack do
		if insensitive and string.lower(item) == string.lower(needle) then
			return id;
		elseif not insensitive and item == needle then
			return id;
		end
	end
	return false;
end

-- UI Functions

PolyHelperUI_QuickMenu = {};

POLYHELPERUI_BORDER_WIDTH  = 15;
POLYHELPERUI_NUM_BUTTONS   = 10;
POLYHELPERUI_BUTTON_HEIGHT = 12;

function PolyHelperUI_CountDownFrameOnEnter()
	if not PolyHelper_IsMage() then return; end

	if (PolyHelper_Options.MenuDisplay == "off") then
		return;
	end

	PolyHelperUI_InitializeMenu();

	PolyHelperUI_Popup:ClearAllPoints();

	local PointX_A = "LEFT";
	local PointX_B = "LEFT";
	local PointY_A = "TOP";
	local PointY_B = "BOTTOM";

	if (PolyHelper_Options.MenuAnchor == "bl") then
		PointX_A = "LEFT";
		PointX_B = "LEFT";
		PointY_A = "TOP";
		PointY_B = "BOTTOM";
	elseif (PolyHelper_Options.MenuAnchor == "br") then
		PointX_A = "RIGHT";
		PointX_B = "LEFT";
		PointY_A = "BOTTOM";
		PointY_B = "BOTTOM";
	elseif (PolyHelper_Options.MenuAnchor == "tr") then
		PointX_A = "RIGHT";
		PointX_B = "RIGHT";
		PointY_A = "BOTTOM";
		PointY_B = "TOP";
	elseif (PolyHelper_Options.MenuAnchor == "tl") then
		PointX_A = "LEFT";
		PointX_B = "RIGHT";
		PointY_A = "TOP";
		PointY_B = "TOP";
	else
		if this:GetLeft() * UIParent:GetEffectiveScale() > UIParent:GetWidth() - (PolyHelperUI_Popup:GetWidth() + 5) * UIParent:GetEffectiveScale() then
			PointX_A = "RIGHT";
			PointX_B = "RIGHT";
		end
		if UIParent:GetHeight() - this:GetBottom() * UIParent:GetEffectiveScale() > UIParent:GetHeight() - (PolyHelperUI_Popup:GetHeight() + 5) * UIParent:GetEffectiveScale() then
			PointY_A = "BOTTOM";
			PointY_B = "TOP";
		end
	end

	PolyHelperUI_Popup:SetPoint(PointY_A..PointX_A, this:GetName(), PointY_B..PointX_B);

	PolyHelperUI_ShowMenu();
end
function PolyHelperUI_ShowMenu()
	if PolyHelper_Options.VisualCountDown == "shown" or (not MouseIsOver(IB_PolyHelperUI_CountDown) and not MouseIsOver(TitanPanelPolyHelperUIButton)) then
		PolyHelperUI_Popup:Show();
	end
end
function PolyHelperUI_HideMenu()
	if PolyHelperUI_Popup:IsVisible() then
		PolyHelperUI_Popup:Show();
	end
end
function PolyHelperUI_HideMenu()
	PolyHelperUI_Popup:Hide();
end
function PolyHelperUI_ButtonClick(id)
	local menuItem = PolyHelperUI_QuickMenu[id];
	if menuItem.values ~= nil then
		local newVal = menuItem.values[1];
		for id,value in menuItem.values do
			if table.getn(menuItem.values) ~= id and string.lower(value) == string.lower(menuItem.option) then
				newVal = menuItem.values[id + 1];
			end
		end
		PolyHelper_Command(menuItem.command.." "..newVal);
	elseif menuItem.range ~= nil then
		local newVal = menuItem.option;
		if newVal >= menuItem.range[2] or newVal < menuItem.range[1] then
			newVal = menuItem.range[1]
		else
			newVal = newVal + 1;
		end
		PolyHelper_Command(menuItem.command.." "..newVal);
	end
	PolyHelperUI_InitializeMenu();
end
function PolyHelperUI_InitializeMenu()
	PolyHelperUI_QuickMenu = {
		{name=POLYHELPER_CMD_SOLO_MENU,         option=PolyHelper_Options.Channel.Solo,     command=POLYHELPER_CMD_SOLO,         values=POLYHELPER_VALID_CHANNELS.SOLO,  default=POLYHELPER_GLOBAL_VALID_CHANNELS.SOLO},
		{name=POLYHELPER_CMD_PARTY_MENU,        option=PolyHelper_Options.Channel.Party,    command=POLYHELPER_CMD_PARTY,        values=POLYHELPER_VALID_CHANNELS.PARTY, default=POLYHELPER_GLOBAL_VALID_CHANNELS.PARTY},
		{name=POLYHELPER_CMD_RAID_MENU,         option=PolyHelper_Options.Channel.Raid,     command=POLYHELPER_CMD_RAID,         values=POLYHELPER_VALID_CHANNELS.RAID,  default=POLYHELPER_GLOBAL_VALID_CHANNELS.RAID},
		{name=POLYHELPER_CMD_NOTIFYCOMBAT_MENU, option=PolyHelper_Options.Notify.Combat,    command=POLYHELPER_CMD_NOTIFYCOMBAT, values=POLYHELPER_VALID_STATES_YESNO,   default=POLYHELPER_GLOBAL_VALID_STATES_YESNO},
		{name=POLYHELPER_CMD_NOTIFYPVP_MENU,    option=PolyHelper_Options.Notify.PVP,       command=POLYHELPER_CMD_NOTIFYPVP,    values=POLYHELPER_VALID_STATES_YESNO,   default=POLYHELPER_GLOBAL_VALID_STATES_YESNO},
		{name=POLYHELPER_CMD_NOTIFYRECAST_MENU, option=PolyHelper_Options.Notify.Recast,    command=POLYHELPER_CMD_NOTIFYRECAST, values=POLYHELPER_VALID_STATES_YESNO,   default=POLYHELPER_GLOBAL_VALID_STATES_YESNO},
		{name=POLYHELPER_CMD_DINGWARN_MENU,     option=PolyHelper_Options.DingOnWarning,    command=POLYHELPER_CMD_DINGWARN,     values=POLYHELPER_VALID_STATES_ONOFF,   default=POLYHELPER_GLOBAL_VALID_STATES_ONOFF},
		{name=POLYHELPER_CMD_PVPDINGWARN_MENU,  option=PolyHelper_Options.PVPDingOnWarning, command=POLYHELPER_CMD_PVPDINGWARN,  values=POLYHELPER_VALID_STATES_ONOFF,   default=POLYHELPER_GLOBAL_VALID_STATES_ONOFF},
		{name=POLYHELPER_CMD_DINGFADE_MENU,     option=PolyHelper_Options.DingOnFaded,      command=POLYHELPER_CMD_DINGFADE,     values=POLYHELPER_VALID_STATES_ONOFF,   default=POLYHELPER_GLOBAL_VALID_STATES_ONOFF},
		{name=POLYHELPER_CMD_DINGSCHEME_MENU,   option=PolyHelper_Options.DingSchemeID,     command=POLYHELPER_CMD_DINGSCHEME,   range={1, table.getn(PolyHelper_DingSchemes)}},
		{name=POLYHELPER_CMD_OHN_MENU,          option=PolyHelper_Options.OverHeadNotice,   command=POLYHELPER_CMD_OHN,          values=POLYHELPER_VALID_STATES_ONOFF,   default=POLYHELPER_GLOBAL_VALID_STATES_ONOFF},
		{name=POLYHELPER_CMD_OHW_MENU,          option=PolyHelper_Options.OverHeadWarning,  command=POLYHELPER_CMD_OHW,          values=POLYHELPER_VALID_STATES_ONOFF,   default=POLYHELPER_GLOBAL_VALID_STATES_ONOFF},
		{name=POLYHELPER_CMD_MSGLENGTH_MENU,    option=PolyHelper_Options.MessageLength,    command=POLYHELPER_CMD_MSGLENGTH,    values=POLYHELPER_VALID_LENGTHS,        default=POLYHELPER_GLOBAL_VALID_LENGTHS},
		{name=POLYHELPER_CMD_WARNSHOW_MENU,     option=PolyHelper_Options.WarnShow,         command=POLYHELPER_CMD_WARNSHOW,     values=POLYHELPER_VALID_STATES_ONOFF,   default=POLYHELPER_GLOBAL_VALID_STATES_ONOFF},
		{name=POLYHELPER_CMD_STOPCAST_MENU,     option=PolyHelper_Options.StopCast,         command=POLYHELPER_CMD_STOPCAST,     values=POLYHELPER_VALID_STATES_YESNO,   default=POLYHELPER_GLOBAL_VALID_STATES_YESNO},
	};

	local count = 0;
	for _,quickoption in PolyHelperUI_QuickMenu do
		count = count + 1;
		local button = getglobal("PolyHelperUI_PopupButton"..count);
		button.OptionID = count;
		if quickoption.values ~= nil then
			local id = PolyHelper_InArray(quickoption.option,quickoption.default,true);
			if not id then id = 1; PolyHelper_Command(quickoption.command.." "..quickoption.values[id]); end
			button:SetText(quickoption.name.." |cff00ff00[|cffffffff"..quickoption.values[id].."|r|cff00ff00]|r");
		else
			button:SetText(quickoption.name.." |cff00ff00[|cffffffff"..quickoption.option.."|r|cff00ff00]|r");
		end
		button:Show();
	end
	local width = PolyHelperUI_PopupButton0:GetWidth();
	for i = 1, count, 1 do
		local button = getglobal("PolyHelperUI_PopupButton"..i);
		local w = button:GetTextWidth();
		if (w > width) then
			width = w;
		end
	end
	PolyHelperUI_Popup:SetWidth(width + 2 * POLYHELPERUI_BORDER_WIDTH);
	for i = 1, count, 1 do
		local button = getglobal("PolyHelperUI_PopupButton"..i);
		button:SetWidth(width);
	end
	for i = count + 1, POLYHELPERUI_NUM_BUTTONS, 1 do
		local button = getglobal("PolyHelperUI_PopupButton"..i);
		button:Hide();
	end
	PolyHelperUI_Popup:SetHeight(POLYHELPERUI_BUTTON_HEIGHT + ((count + 1) * POLYHELPERUI_BUTTON_HEIGHT) + (2 * POLYHELPERUI_BORDER_WIDTH));
end


function colortohex(color)
	local hexcodes = {"0","1","2","3","4","5","6","7","8","9","a","b","c","d","e","f"};

	local r = math.floor(255 * color.r);
	local g = math.floor(255 * color.g);
	local b = math.floor(255 * color.b);

	local hexcolor = "";

	local r1 = math.floor(r / 16);
	local r2 = r - (r1 * 16);
	hexcolor = hexcolor..hexcodes[r1+1]..hexcodes[r2+1];

	local g1 = math.floor(g / 16);
	local g2 = g - (g1 * 16);
	hexcolor = hexcolor..hexcodes[g1+1]..hexcodes[g2+1];

	local b1 = math.floor(b / 16);
	local b2 = b - (b1 * 16);
	hexcolor = hexcolor..hexcodes[b1+1]..hexcodes[b2+1];

	return hexcolor;
end


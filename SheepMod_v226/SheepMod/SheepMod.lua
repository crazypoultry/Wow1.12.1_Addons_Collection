SheepModOptions = {};	-- Enabled, Timer, Resheep, ResheepAnimal, WarnPlayers, FFAPvP, MCed, WarnOnMC, EmoteOnMC, MCIgnoreZone, MCRank, PvPWarning, Resist, TimedEmoteOn, TimedEmote, SheepTime, Language, Type, Nef and AutoSetDefaults are all stored individually for each character.
SheepMod = {};		-- The following variables are also stored for each character, but are less obvious: StickyMobs, DisallowedMobs, DisallowedZones, Version, 1.
SheepModFrameHeight = 412;
local command, NullFoundA, NullFoundB, CurrentCheck, CurrentDebuff, i, x, y, z, s;

function SheepMod.OnLoad()
	SM_Version = "2.25"
	SlashCmdList["SheepMod"] = SheepMod.SlashHandler;
	SLASH_SheepMod1 = "/SM";
	SLASH_SheepMod2 = "/"..sm_string_sheep;
	SLASH_SheepMod3 = "/sheep";
	local _, temp = UnitClass("player")
	if temp ~= "MAGE" then
	    return;	-- Disables event checking.
	end
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("SPELLCAST_START");
	this:RegisterEvent("SPELLCAST_STOP");
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("SPELLCAST_INTERRUPTED");
	this:RegisterEvent("CHAT_MSG_SPELL_BREAK_AURA");
	this:RegisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH");
	this:RegisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_AURA_GONE_OTHER");
end

function SheepMod.OnEnterWorld()
    if SheepModOptions.HideLoad ~= 1 then
	DEFAULT_CHAT_FRAME:AddMessage(sm_mod_loaded, 0, 1, 0)
    end
    SM_UIData = {};
    Realm = GetRealmName();
    Player = UnitName("player")
    SheepModOptions.Temp = {};	-- Temporary variables: LastMCName, LastSheepName, SheepTime, IsChecking, IsCasting, Type, PreSheepName, PreSheepSex, SheepName, SheepNum and ResheepNum.
    SheepMod.SetConstants();
    sm_lowercase = SheepMod.Split(sm_lowercase, ", ")
    if SheepModOptions[Realm] == nil then
	SheepModOptions[Realm] = {};
    end
    if SheepModOptions[Realm][Player] == nil then
	SheepModOptions[Realm][Player] = {};
    end
    if SheepModOptions[Realm][Player].DisallowedZones == nil then
	SheepModOptions[Realm][Player].DisallowedZones = {};
    end
    if SheepModOptions[Realm][Player].DisallowedMobs == nil then
	SheepModOptions[Realm][Player].DisallowedMobs = {};
    end
    if SheepModOptions[Realm][Player].StickyMobs == nil then
	SheepModOptions[Realm][Player].StickyMobs = {};
    end
    if SheepModOptions[Realm][Player].Version ~= SM_Version then
	SheepMod.UpdateVersion();
    end
    if SheepModOptions[Realm][Player].AutoSetDefaults == nil then
	DEFAULT_CHAT_FRAME:AddMessage(sm_set_defaults, 0, 1, 0)
	SheepMod.SetDefaults(3);
    end

    SheepMod_HelpFrame_Intro:SetText(format(sm_helpframe_intro, SheepMod.pronoun(UnitSex("player"), 3)));
    SheepMod_HelpFrame_TextVersion:SetText(format(sm_helpframe_version, SM_Version))
    SheepMod_HelpFrame_Text1:SetText(format(sm_helpframe_text1, "\n|cffffff00    /"..sm_string_sheep.." "..sm_string_sheep.."\n    /script --CastSpellByName(\""..sm_string_polymorph.."\");|r\n"))
    SheepMod_HelpFrame_Text2:SetText(sm_helpframe_text2)
    SheepMod_HelpFrame_Text3:SetText(sm_helpframe_text3)
    SM_SetDefaultsConfirm:SetText(sm_string_confirm)
    SM_RefreshMain:SetText(sm_string_refresh)
    SM_ChangeToSpecials:SetText(sm_string_gotospecials)
    SM_GoToHelp:SetText(sm_string_help)
    SheepMod_SpecialsFrame_GoToMainOptions:SetText(sm_string_gotomain)
    SheepMod_HelpFrame_Title_Text:SetText("Turkeyii's Sheep Mod: "..sm_string_help)
    SheepModOptions[Realm][Player]["1"] = true;
    local r, g, b = SM_PolyLocationString:GetTextColor();
    for i, x in {"MCRankDropDown", "TimedDropDownA", "TimedDropDownB", "LanguageDropDown", "TypeDropDown"} do
	if getglobal("SM_"..x..Location.."Text") then
	    getglobal("SM_"..x..Location.."Text"):SetTextColor(r, g, b);
	end
    end
    SheepMod.Set_Emotes();
end

function SheepMod.SlashHandler(msg)
	local _, temp = UnitClass("player")
	if string.upper(temp) ~= "MAGE" then
	    UIErrorsFrame:AddMessage(sm_not_mage, 1, 0, 0, 1, UIERRORS_HOLD_TIME)
	    return
	end
	while string.sub(msg, 1, 1) == " " do
	    msg = string.sub(msg, 2)
	end
	if msg == "" then
	    SheepMod.ShowUI();
	    return
	end
	command = SheepMod.Split(msg, " ");
	if command[1] then
	    command[1] = string.lower(command[1]);
	end
	if command[1] == "help" or command[1] == string.lower(sm_string_help) then
	    SheepModFrame:Hide();
	    SheepMod_SpecialsFrame:Hide();
	    SheepModFrameDisallowedZones:Hide();
	    SheepModFrameDisallowedMobs:Hide();
	    SheepModFrameStickyMobs:Hide();
	    SheepMod_HelpFrame:Show();
	elseif command[1] == "message" or command[1] == sm_string_message then
	    local sm_chosen_animal = SheepMod.RandomAnimal();
	    SheepMod.Message(0, sm_chosen_animal);
	elseif command[1] == sm_string_sheep or command[1] == "sheep" then
	    SheepMod.check();
	elseif command[1] == "buff" then
	    SheepMod.Misc(command);
	elseif command[1] == sm_string_special or command[1] == "special" then
	    SheepMod.ShowSpecialUI();
	else
	    DEFAULT_CHAT_FRAME:AddMessage(sm_no_command, 0, 1, 0)
	end
end

function SheepMod.OnEvent(event, sm_arg1)
    if SheepModOptions == nil then
	return
    end
    local _, temp = UnitClass("player")
    if event == "VARIABLES_LOADED" then
	SheepMod.OnEnterWorld();
    end
    if SheepModOptions ~= nil and SheepModOptions.Temp ~= nil and event == "SPELLCAST_START" then
	SheepModOptions.Temp.IsCasting = sm_arg1
	if string.find(sm_arg1, sm_string_polymorph) then
	    SheepModOptions.Temp.PreSheepName = UnitName("target");
	    SheepModOptions.Temp.PreSheepSex  = UnitSex("target");
	end
    elseif event == "PLAYER_ENTERING_WORLD" then
	SheepModFrame:Hide();
	SheepMod_SpecialsFrame:Hide();
	SheepModFrameDisallowedZones:Hide();
	SheepModFrameDisallowedMobs:Hide();
	SheepModFrameStickyMobs:Hide();
	SheepMod_HelpFrame:Hide();
    elseif event == "CHAT_MSG_SPELL_AURA_GONE_OTHER" and SheepModOptions.Temp.SheepName ~= nil and SheepModOptions.Temp.Type ~= nil and sm_arg1 ~= nil and string.lower(sm_arg1) == format(sm_fades_from, SheepModOptions.Temp.Type, string.lower(SheepModOptions.Temp.SheepName)) then
	SM_TimerFrame:Hide();
    elseif event == "CHAT_MSG_SPELL_BREAK_AURA" and SheepModOptions.Temp.SheepName ~= nil and SheepModOptions.Temp.Type ~= nil and sm_arg1 ~= nil and string.lower(sm_arg1) == format(sm_is_removed, string.lower(SheepModOptions.Temp.SheepName), SheepModOptions.Temp.Type) then
	SM_TimerFrame:Hide();
    elseif event == "CHAT_MSG_SPELL_SELF_DAMAGE"  and SheepModOptions[Realm][Player].Enabled and SheepModOptions[Realm][Player].Resist and SheepModOptions.Temp.Type and SheepModOptions.Temp.PreSheepName and string.lower(sm_arg1) == string.lower(format(sm_string_resisted, SheepModOptions.Temp.Type, SheepModOptions.Temp.PreSheepName)) then
	SheepMod.Message(5);
    elseif event == "CHAT_MSG_SPELL_SELF_DAMAGE" and sm_arg1 ~= nil and string.find(sm_arg1, sm_you_cast) and string.find(sm_arg1, sm_string_polymorph) and string.find(sm_arg1, sm_string_on) then
	local _, sm_temp, spellTexture = string.find(sm_arg1, sm_string_polymorph..sm_string_colon)
	if not(sm_temp) or not(SheepModConstants.Icons[ string.lower(tostring(string.sub(arg1, sm_temp+1, string.find(arg1, sm_string_on)-1))) ]) then
	    spellTexture = SheepModConstants.Icons[ sm_string_sheep ];
	else
	    spellTexture = SheepModConstants.Icons[ string.lower(tostring(string.lower(string.sub(arg1, sm_temp+1, string.find(arg1, sm_string_on)-1)))) ];
	end
	SM_TimerFrame_Icon:SetTexture(spellTexture)
	spellTexture = SheepModConstants.IconID[ spellTexture ];
	if GetActionText(SheepModOptions[Realm][Player].SheepSlot) then
	    local name, _, body, localVar = GetMacroInfo( GetMacroIndexByName(GetActionText(SheepModOptions[Realm][Player].SheepSlot)) )
	    EditMacro( GetMacroIndexByName(GetActionText(SheepModOptions[Realm][Player].SheepSlot)), name, spellTexture, body, localVar);
	end
	_, sm_temp = string.find(sm_arg1, sm_string_on)
	SheepMod.StartTimer(string.sub(sm_arg1, sm_temp+1, -2));
    elseif SheepModOptions ~= nil and SheepModOptions[Realm] ~= nil and SheepModOptions[Realm][Player] ~= nil and event == "SPELLCAST_STOP" or event == "SPELLCAST_INTERRUPTED" then
	SheepModOptions.Temp.IsCasting = nil
    end
end

function SheepMod.OnUpdate()
    if time() ~= SM_LastUpdate then
	if not(UnitAffectingCombat("player")) and SheepModOptions.Temp.CastStart ~= nil and (time() ~= SheepModOptions.Temp.CastStart and time() ~= SheepModOptions.Temp.CastStart + 1) then
	    SM_TimerFrame:Hide();
	elseif SheepModOptions.Temp.CastStart ~= nil and time() - SheepModOptions.Temp.CastStart <= 60 then
	    SM_TimerFrame_Number:SetText(time() - SheepModOptions.Temp.CastStart.."s")
	else
	    SM_TimerFrame:Hide();
	end
	SM_LastUpdate = time();
    end
end

function SheepMod.UpdateVersion()			-- Updates users who've just downloaded a newer version.
    if tonumber(SheepModOptions[Realm][Player].Version) == nil then
	SheepModOptions[Realm][Player].Version = "0.00"
    end
    if SheepModOptions.Version ~= nil then
	SheepModOptions[Realm][Player].Version = SheepModOptions.Version;
	SheepModOptions.Version = nil
    end
    if (tonumber(SheepModOptions[Realm][Player].Version) ~= nil and tonumber(SheepModOptions[Realm][Player].Version) < 2.00) then
	SheepModOptions.StopCasting = nil
	SheepModOptions.WarnPlayer = nil
	SheepModOptions.FFAPvP = nil
	SheepModOptions.PvPWarning = nil
	SheepModOptions.Resheep = nil
	SheepModOptions.WarnOnMC = nil
	SheepModOptions.MCed = nil
	SheepModOptions.Nef = nil		-- The new data storage system in v2.00 requires all variables using the old system to be reset.
	SheepModOptions.Enabled = nil
	SheepModOptions.LastMCName = nil
	SheepModOptions.IsChecking = nil
	SheepModOptions.IsCasting = nil
	SheepModOptions.SheepNum = nil
	SheepModOptions.ResheepNum = nil
	DisallowedZones = nil;
	DisallowedMobs = nil;
	StickyMobs = nil;
	SheepModOptions[Realm][Player].AutoSetDefaults = nil;
    end
    if tonumber(SheepModOptions[Realm][Player].Version) < 2.10 then
	SheepModOptions[Realm][Player].Resist = true
	SheepModOptions[Realm][Player].EmoteOnMC = true
    end
    if tonumber(SheepModOptions[Realm][Player].Version) < 2.20 then
	for x = 1, 3 do
	    SheepModOptions[Realm][Player][ SheepModConstants.Specials[x] ][ getn(SheepModOptions[Realm][Player][ SheepModConstants.Specials[x] ]) + 1 ] = SheepModOptions[Realm][Player][ SheepModConstants.Specials[0] ]
	    SheepModOptions[Realm][Player][ SheepModConstants.Specials[x] ][0] = nil
	end		-- Moves all three 0 indices to the end, in keeping with the getn() function's requirements.
	for i, x in SheepModOptions[Realm][Player] do
	    if x == 1 then
		SheepModOptions[Realm][Player][i] = true;
	    end
	end
	SheepModOptions[Realm][Player].VarLength = nil;
	SheepModOptions[Realm][Player].MCRank = 1;
	SheepModOptions[Realm][Player].MCRankOn = true;
	SheepModOptions[Realm][Player].ResheepAnimal = true;
	SheepModOptions[Realm][Player].SheepTime = 3;
	SheepModOptions[Realm][Player].TimedEmoteOn = true;
	SheepModOptions[Realm][Player].TimedEmote = sm_string_the_same;
	if (Location ~= "" and Location ~= "France") or SheepModOptions[Realm][Player].Language == nil then
	    SheepModOptions[Realm][Player].Language = sm_language;
	    SheepModOptions[Realm][Player].AutoSetDefaults = nil;
	end
    end
    DEFAULT_CHAT_FRAME:AddMessage(sm_version_update, 0, 1, 0)
    SheepModOptions[Realm][Player].Version = SM_Version;
end

-----------------------------------------------------------------------------
-----------------------------------------------------------------------------

function SheepMod.Refresh()
	SheepModOptions[Realm][Player].SheepSlot = 0
	SM_UIData["MacroFailed"] = nil
	for i = 72, 1, -1 do
	    if GetActionText(i) ~= nil and (string.find(string.lower(GetActionText(i)), sm_string_sheep) or string.find(string.lower(GetActionText(i)), sm_string_polymorph) or string.find(string.lower(GetActionText(i)), "poly")) then
		SheepModOptions[Realm][Player].SheepSlot = i
	    else
		for x, y in SheepModConstants.Icons do
		    if GetActionTexture(i) == y then
			SheepModOptions[Realm][Player].SheepSlot = i
		    end
		end
	    end		
	end
	if not(GetActionText(SheepModOptions[Realm][Player].SheepSlot)) then
	    return
	end
	local _, _, MacroText, _ = GetMacroInfo(GetMacroIndexByName(GetActionText(SheepModOptions[Realm][Player].SheepSlot)))
	MacroText = string.gsub(MacroText, "-", "AbXydP")	-- An arbitrary string that is unlikely to be found naturally in the macro.
	local _, found = string.find(MacroText, "/script AbXydPAbXydPCastSpellByName")
	if found == nil then
	    SM_UIData["MacroFailed"] = 1
	    return
	end			-- NB. The long algorithms are due to the fact that one cannot search strings for "--" or "(" due to bad commands.
	local MacroTextPartTwo
	SM_UIData["MacroFailed"] = 1
	while string.find(MacroText, "/script AbXydPAbXydPCastSpellByName") do
	    local _, found = string.find(MacroText, "/script AbXydPAbXydPCastSpellByName")
	    MacroTextPartTwo = string.sub(MacroText, found+2, found+4+string.len(sm_string_polymorph))
	    if MacroTextPartTwo == "\""..sm_string_polymorph.."\")" and string.sub(MacroText, found+1, found+1) == string.char(40) then
		SM_UIData["MacroFailed"] = nil
	    end
	    MacroText = string.gsub(MacroText, "/script AbXydPAbXydPCastSpellByName", "Checked", 1)
	end
end

function SheepMod.Misc()
    local BuffDur = {};
    command[2] = command[2] - 1			-- So the first buff is index 1, not 0.
    if tonumber(command[2]) ~= nil then
        BuffDur[0] = GetPlayerBuffTimeLeft(command[2])
    end
      if BuffDur[0] ~= nil and BuffDur[0] ~= "" then
	command[2] = command[2] + 1
        if BuffDur[0] > 86400 then
	    BuffDur[4] = (BuffDur[0]/86400) - math.mod(BuffDur[0]/86400, 1)			-- Days
	else
	    BuffDur[4] = 0
	end
        if BuffDur[0] > 3600 then
	    BuffDur[3] = ((BuffDur[0]/3600) - math.mod(BuffDur[0]/3600, 1)) - 24*BuffDur[4]	-- Hours
	else
	    BuffDur[3] = 0
	end
        if BuffDur[0] > 60 then
	    BuffDur[2] = ((BuffDur[0]/60) - math.mod(BuffDur[0]/60, 1)) - 60*BuffDur[3]		-- Minutes
	else
	    BuffDur[2] = 0
	end
	BuffDur[1] = (math.mod(BuffDur[0], 60) - math.mod(math.mod(BuffDur[0], 60), 1))		-- Seconds
	if BuffDur[4] ~= 0 then
	    DEFAULT_CHAT_FRAME:AddMessage(format(sm_buffdur_days, command[2], BuffDur[4], BuffDur[3], BuffDur[2], BuffDur[1]),0,1,0)
	elseif BuffDur[3] ~= 0 then
	    DEFAULT_CHAT_FRAME:AddMessage(format(sm_buffdur_hours, command[2], BuffDur[3], BuffDur[2], BuffDur[1]),0,1,0)
	elseif BuffDur[2] ~= 0 then
	    DEFAULT_CHAT_FRAME:AddMessage(format(sm_buffdur_mins, command[2], BuffDur[2], BuffDur[1]),0,1,0)
	elseif BuffDur[0] ~= 0 and BuffDur[0] ~= "" then
	    DEFAULT_CHAT_FRAME:AddMessage(format(sm_buffdur_sec, command[2], BuffDur[1]),0,1,0)	
	elseif BuffDur[0] == 0 then
	    DEFAULT_CHAT_FRAME:AddMessage(format(sm_buffdur_none, command[2]),0,1,0)	
	end
      end
end

function SheepMod.check()
    SheepMod.Refresh();
    _, CurrentCheck = UnitClass("player");
    if CurrentCheck ~= "MAGE" then
	DEFAULT_CHAT_FRAME:AddMessage(sm_not_mage, 1, 0, 0);
	checklist = 2						-- You aren't a mage.
    end
    local MobName;
    local mcname = string.lower(SheepModOptions[Realm][Player].MCName)
    local GroupMembers
    local grouptype = ""
    local Smorp = SheepModOptions[Realm][Player];
    if GetNumPartyMembers() > 0 and GetNumRaidMembers() == 0 then
	grouptype = "party"
    else
	grouptype = "raid"
    end
    if grouptype == "raid" then
	GroupMembers = GetNumRaidMembers()
    else
	GroupMembers = GetNumPartyMembers()
    end
    local MCedAgain;
    for i = 1, GroupMembers do
	_, CurrentCheck = UnitClass(grouptype..i)
	if UnitIsCharmed(grouptype..i) and not(UnitIsUnit(grouptype..i, "target")) and not(UnitIsUnit(grouptype..i, "player")) and CurrentCheck ~= "DRUID" and not(UnitIsCharmed("target")) and CheckInteractDistance(grouptype..i, 4) and ((Smorp.MCed == "All valid players" and UnitName(grouptype..i) ~= SheepModOptions.Temp.LastMCName) or UnitName(grouptype..i) == Smorp.MCName) then
	    TargetUnit(grouptype..i);
	    SheepModOptions.Temp.LastMCName = UnitName(grouptype..i)
	    mcname = UnitName(grouptype..i)		-- This will not be confused with the previously entered name because of the case difference.
	elseif UnitIsCharmed(grouptype..i) and not(UnitIsUnit(grouptype..i, "target")) and not(UnitIsUnit(grouptype..i, "player") and CurrentCheck ~= "DRUID") and not(UnitIsCharmed("target")) and CheckInteractDistance(grouptype..i, 4) and (Smorp.MCed == "All valid players" or mcname == string.lower(UnitName(grouptype..i))) then
	    MCedAgain = grouptype..i;			-- If no player met the above conditions, ignore the not-sheeping-last-target condition.
	end
    end
    if mcname == string.lower(mcname) and MCedAgain then
	SheepModOptions.Temp.LastMCName = UnitName(MCedAgain)	-- MCedAgain stores the unit ID (eg "raid27").
	TargetUnit(MCedAgain);
	mcname = UnitName(MCedAgain)
    end

    local Zone = string.lower(GetZoneText())
    MobName = string.lower(tostring(UnitName("target")))
    local checklist = 0						-- Emote can be hidden for various reasons:
    if not(Smorp.Enabled) then
	checklist = 1						-- If the mod is disabled.
    end
    if not(Smorp.WarnPlayers) and UnitIsPlayer("target") and not(UnitIsCharmed("target")) then
	checklist = 1						-- If you're set to not emote for players, and your target is a (non-MCed) player.
    end
    if not(Smorp.FFAPvP) and UnitIsPVPFreeForAll("target") and UnitIsPlayer("target") then
	checklist = 1						-- If you are set to not emote for FFA-PvP-Enabled players, and your target is one.
    end
    if not(Smorp.EmoteOnMC) and UnitIsCharmed("target") then
	checklist = 1						-- If you are set to not emote for Mind Controlled players, and your target is one.
    end
    if UnitClassification("target") == "worldboss" then
	checklist = 1						-- If your target is a world boss.
    end
    if tonumber(SheepModOptions.Temp.SheepTime) and Smorp.TimedEmoteOn and (Smorp.TimedEmote == sm_string_any or SheepModOptions.Temp.PreSheepName == UnitName("target")) and (time() - SheepModOptions.Temp.SheepTime <= Smorp.SheepTime) then
	checklist = 1						-- If you have sheeped that/any target recently.
    else
	SheepModOptions.Temp.SheepTime = time();
	SheepModOptions.Temp.PreSheepName = UnitName("target");
    end
    if Smorp.PvPWarning == true and UnitIsPVP("target") and not(UnitIsPVPFreeForAll("target")) and not(UnitIsPVP("player")) and UnitIsPlayer("target") and UnitIsEnemy("player", "target") then
	DEFAULT_CHAT_FRAME:AddMessage(format(sm_pvp_warning, UnitName("target")), 0, 1, 0);
    end
	i = 0
	StopLoop = 0
	local PendingZoneDisable = 0
	local PendingDisableZoneDisable = 0
	while StopLoop == 0 do
	    if MobName == string.lower(tostring(Smorp.DisallowedMobs[i])) then
		checklist = 1					-- If target is disallowed.
	    end
	    if Zone == string.lower(tostring(Smorp.DisallowedZones[i])) then
		PendingZoneDisable = 1				-- If your zone is disallowed, try to disable emote...
	    end
	    if MobName == string.lower(tostring(Smorp.StickyMobs[i])) then
		PendingDisableZoneDisable = 1			-- ...but cancel this if your target is a sticky mob...
	    end
	    if UnitIsCharmed("target") and Smorp.MCIgnoreZone then
		PendingDisableZoneDisable = 1			-- ...or your target is Mind Controlled and you're set to ignore zone for that.
	    end
	    CurrentCheck = tostring(UnitBuff("player", i))
	    if string.find(CurrentCheck, "Interface\\Icons\\Ability_Mount_") or string.find(CurrentCheck, "Interface\\Icons\\INV_Misc_QirajiCrystal_") then
		checklist = 1					-- If you're mounted.
	    end
	    CurrentCheck, _ = tostring(UnitDebuff("target", i))
	    for x in SheepModConstants.Icons do
		if string.find(CurrentCheck, SheepModConstants.Icons[x]) then
		    if Smorp.Resheep == true then
			checklist = checklist + 0.5		-- If your target is sheeped already, flag this.
		    else
			checklist = 1				-- Or disable it if it's set to do that.
		    end
		end
	    end
	    if i > getn(Smorp.DisallowedMobs) and i > getn(Smorp.DisallowedZones) and i > getn(Smorp.StickyMobs) and i > 40 then
		StopLoop = 1
	    end
	    i = i + 1
	end
	if PendingZoneDisable == 1 and PendingDisableZoneDisable == 0 then
	    checklist = 1	-- Disables emote if zone is disabled and unit is not sticky.
	end
    if UnitIsDeadOrGhost("target") then
	checklist = 2						-- Target is dead.
    end
    if (SheepModOptions.Temp.IsCasting and not(Smorp.StopCasting)) or string.find(tostring(SheepModOptions.Temp.IsCasting), sm_string_polymorph) then
	checklist = 2						-- You're casting and you aren't set to stop casting.
    end
    if MobName == "nil" then
	checklist = 2						-- You have no target.
    end
    if not(Smorp.MCRankOn) and (Smorp.Type == sm_string_sheep and UnitMana("player") < (60+30*(Smorp.Rank)) or Smorp.Type ~= sm_string_sheep and UnitMana("player") < 150) then
	checklist = 2						-- You do not have enough mana to cast the spell.
    elseif Smorp.MCRankOn and UnitMana("player") < (60+30*(Smorp.MCRank)) then
	checklist = 2
    end
    if UnitCreatureType("target") ~= sm_string_humanoid and UnitCreatureType("target") ~= sm_string_beast and UnitCreatureType("target") ~= sm_string_critter then
	checklist = 2						-- Your target is an invalid type.
    end
    if not(UnitCanAttack("player","target")) then
	checklist = 2						-- Your target is friendly, or otherwise not attackable.
    end
    if not(CheckInteractDistance("target", 4)) then
	checklist = 2						-- Your target is out of range.
    end
    _,CurrentCheck,_ = GetActionCooldown(Smorp.SheepSlot)
    if CurrentCheck == nil then
	CurrentCheck = 0
    end
    if CurrentCheck > 0 and Smorp.SheepSlot ~= 0 then
	checklist = 2						-- Polymorph is on cooldown.
    end
    if (GetMinimapZoneText() == sm_nefarians_lair and GetRealZoneText() == sm_string_bwl) and not(UnitIsCharmed("target") and UnitIsPlayer("target")) then
	checklist = 2						-- You're fighting Nefarian (Special rules apply then).
    end
  SheepMod.CastSheep(checklist, mcname);
end

function SheepMod.CastSheep(checklist, mcname)
    if checklist <= 1 and SheepModOptions[Realm][Player].StopCasting == true and SheepModOptions.Temp.IsCasting ~= nil and not(string.find(SheepModOptions.Temp.IsCasting, sm_string_polymorph)) then
	SpellStopCasting();
    end
    local pronoun = {};
    for i = 1, 5 do
	pronoun[i] = SheepMod.pronoun(UnitSex("target"), i, SheepModOptions[Realm][Player].Language)
    end
    sm_chosen_animal = SheepMod.RandomAnimal();
    if sm_chosen_animal == sm_string_sheep then
	i = 1
	failed = 1
	while GetSpellName(i, BOOKTYPE_SPELL) do
	    if GetSpellName(i, BOOKTYPE_SPELL) == sm_string_polymorph then
		failed = nil
		break
	    end
	    i = i + 1
	end
	if failed == 1 then
	    checklist = 2
	    UIErrorsFrame:AddMessage(sm_no_spell_at_all, 1, 0, 0, 1, UIERRORS_HOLD_TIME)
	end
    end
    if sm_chosen_animal == sm_string_sheep then
	SheepModOptions.Temp.Type = string.lower(sm_string_polymorph)
    else
	SheepModOptions.Temp.Type = string.lower(sm_string_polymorph..sm_string_colon..sm_chosen_animal)
    end
    if checklist < 1 then
	SheepMod.Message(checklist, sm_chosen_animal);
    end
    SheepModOptions.Temp.IsChecking = 1
    local sm_SpellToCast = sm_string_polymorph;
    if (GetMinimapZoneText() == sm_nefarians_lair and GetRealZoneText() == sm_string_bwl) and not(UnitIsCharmed("target") and UnitIsPlayer("target")) and (mcname == string.lower(mcname) or mcname == nil) then
	sm_SpellToCast = SheepModOptions[Realm][Player].Nef;		-- Casts Blizzard, Flamestrike or Arcane Explosion in the Nefarian fight instead of Polymorph.
    elseif UnitIsCharmed("target") and SheepModOptions[Realm][Player].MCRankOn then
	sm_SpellToCast = sm_string_polymorph.."("..sm_string_rank..SheepModOptions[Realm][Player].MCRank..")";
    elseif sm_chosen_animal == sm_string_sheep then
	sm_SpellToCast = sm_string_polymorph
    else
	sm_SpellToCast = sm_string_polymorph..sm_string_colon..sm_chosen_animal
    end
    CastSpellByName(sm_SpellToCast)		 -- NB. This will cast Polymorph whatever happens, so as to give the correct UI error message.
    if mcname ~= nil and mcname ~= string.lower(mcname)then
	if SheepModOptions[Realm][Player].WarnOnMC == true and checklist < 2 then
	    local Temp = ""
	    if Location == "France" and UnitSex("target") == 3 then
		Temp = "e"
	    end
	    pronoun[2] = SheepMod.pronoun(UnitSex("target"), 2, Location)
	    pronoun[3] = SheepMod.pronoun(UnitSex("target"), 4, Location)
	    DEFAULT_CHAT_FRAME:AddMessage(format(sm_mc_poly, mcname, pronoun[2], Temp, pronoun[3]), 0, 1, 0)
	end
	TargetLastTarget();
    end
    SheepModOptions.Temp.IsChecking = nil
end

function SheepMod.Message(checklist, sm_animal)
    SheepMod.Set_Emotes();
    math.randomseed = time()
    local SheepLang = SheepModOptions[Realm][Player].Language;
    if sm_animal == sm_string_sheep and SheepLang == sm_english then
	sm_animal = "sheep"
    elseif sm_animal == sm_string_pig and SheepLang == sm_english then		-- NB. This does not take into account Polymorph shapes
	sm_animal = "pig"							-- yet to be released. Any new animals will use the
    elseif sm_animal == sm_string_turtle and SheepLang == sm_english then	-- localised names (eg. vache).
	sm_animal = "turtle"
    end
    local sm_creature = sm_animal
    if sm_animal ~= "sheep" and sm_animal ~= "pig" and sm_animal ~= "turtle" and sm_animal ~= sm_string_sheep and sm_animal ~= sm_string_pig and sm_animal ~= sm_string_turtle then
	sm_creature = "Other"
    end
    if SheepLang == "Deutsch" then
	sm_animal = CaseControl(sm_animal);
    end
    local pronoun = {};
    for i = 1, 5 do
	pronoun[i] = SheepMod.pronoun(UnitSex("target"), i, SheepLang)
    end
    for i = -4, -1 do
	if SheepModConstants.Genders[sm_animal] then
	    pronoun[i] = SheepMod.pronoun(SheepModConstants.Genders[sm_animal], i, SheepLang)
	else
	    pronoun[i] = SheepMod.pronoun(UnitSex("target"), i, SheepLang)
	end
    end
    if UnitName("target") == nil then
	return				-- For /sheep message; checklist will have disabled this earlier otherwise.
    end
    if checklist == 5 then		-- If the Polymorph was resisted. This formats a random index of the sm_resisted array, inserting the unit's name and the relevent "he/she/it" pronoun (if necessary), in that order.
	for i = 1, getn(SheepModOptions[Realm][Player].DisallowedZones) do
	    if SheepModOptions[Realm][Player].DisallowedZones[i] == GetRealZoneText() then
		return
	    end
	end
	SendChatMessage(format(sm_resisted[ math.random(1, 3) ], SheepModOptions.Temp.PreSheepName, SheepMod.pronoun(SheepModOptions.Temp.PreSheepSex, 2, SheepLang) ), "emote")
	return
    elseif checklist == 0.5 then
	RandomNum = SheepModOptions.Temp.ResheepNum
	while RandomNum == SheepModOptions.Temp.ResheepNum do
	    RandomNum = math.random(1, 3)
	end
	SheepModOptions.Temp.ResheepNum = RandomNum
	if RandomNum == 1 then SendChatMessage(format(sm_resheep[1], UnitName("target")), "emote");end
	if RandomNum == 2 then SendChatMessage(format(sm_resheep[2], UnitName("target"), pronoun[1]), "emote");end
	if RandomNum == 3 then SendChatMessage(format(sm_resheep[3], UnitName("target"), pronoun[-1], sm_animal, pronoun[-2], pronoun[1]), "emote");end
	return
    end
    RandomNum = SheepModOptions.Temp.SheepNum
    while RandomNum == SheepModOptions.Temp.SheepNum do
	RandomNum = math.random(1, 5)
    end
    if RandomNum == 3 and SheepLang == "Deutsch" then
	sm_animal = pronoun[-3].." "..sm_animal
    elseif RandomNum == 4 and SheepLang == "Deutsch" then
	sm_animal = pronoun[-4].." "..sm_animal
    end
    SheepModOptions.Temp.SheepNum = RandomNum
    local sm_meal
    if tonumber(date("%H")) < 11 then
	sm_meal = sm_breakfast
    elseif tonumber(date("%H")) < 15 then
	sm_meal = sm_lunch
    else
	sm_meal = sm_dinner
    end
    if RandomNum == 1 then SendChatMessage(format(sm_polymorph[sm_creature.."1"], UnitName("target"), sm_animal), "emote");end
    if RandomNum == 2 then SendChatMessage(format(sm_polymorph[sm_creature.."2"], UnitName("target"), sm_animal), "emote");end
    if RandomNum == 3 then SendChatMessage(format(sm_polymorph[3], UnitName("target"), sm_animal), "emote");end
    if RandomNum == 4 then SendChatMessage(format(sm_polymorph[4], UnitName("target"), sm_meal, pronoun[2], sm_animal), "emote");end
    if RandomNum == 5 then SendChatMessage(format(sm_polymorph[5], UnitName("target"), pronoun[4], pronoun[5], pronoun[1]), "emote");end
end

-----------------------------------------------------------------------------
-----------------------------------------------------------------------------

function CaseControl(inputstring, index)		-- Capitalizes the first letter and lowercases the rest, with a few exceptions.
    if type(inputstring) == "table" then
	for i, _ in inputstring do
	    inputstring[i] = CaseControl(inputstring[i], i)
	end
	return inputstring
    elseif type(inputstring) == "nil" then
	return inputstring
    end
    local outputstring = ""
    for i = 1, string.len(inputstring) do	-- Uppercasing some accented characters destroys them, so we must ensure they are normal letters.
	if i ~= 1 and IsLetter(string.sub(inputstring, i, i)) then
	    outputstring = outputstring..string.lower(string.sub(inputstring, i, i))
	elseif i == 1 and IsLetter(string.sub(inputstring, i, i)) then
	    outputstring = outputstring..string.upper(string.sub(inputstring, i, i))
	else
	    outputstring = outputstring..string.sub(inputstring, i, i)	-- If any character is accented, it is left unchanged.
	end
    end
    if index ~= 1 then
	for i = 1, getn(sm_lowercase) do
	    if outputstring == sm_lowercase[i] then
		outputstring = string.lower(outputstring);
	    end
	end
    end
    if index ~= 1 and (string.sub(outputstring, 1, 2) == "D'" or string.sub(outputstring, 1, 2) == "L'") and IsLetter(string.sub(outputstring, 3, 3)) then
	outputstring = string.lower(string.sub(outputstring, 1, 1)).."'"..string.upper(string.sub(outputstring, 3, 3))..string.lower(string.sub(outputstring, 4))				-- Converts to d'Name or l'Name
    elseif index ~= 1 and (string.sub(outputstring, 1, 2) == "D'" or string.sub(outputstring, 1, 2) == "L'") and not(IsLetter(string.sub(outputstring, 3, 3))) then
	outputstring = string.lower(string.sub(outputstring, 1, 1)).."'"..string.sub(outputstring, 3, 4)..string.lower(string.sub(outputstring, 5))						-- Similar to the above, but ignoring the third character.
    end
    for i = 1, getn(sm_special_names) do		-- Corrects the exceptions to the rule.
	outputstring = string.gsub(outputstring, string.upper(string.sub(sm_special_names[i], 1, 1))..string.lower(string.sub(sm_special_names[i], 2)) , sm_special_names[i])
    end
    return outputstring
end

function IsLetter(sm_character)
    if strbyte(sm_character) >= 97 and strbyte(sm_character) <= 122 then
	return 1
    end
    return nil
end

function SheepMod.RandomAnimal()
    if SheepModOptions[Realm][Player].MCRankOn and UnitIsCharmed("target") then
	return sm_string_sheep;
    end
    local sm_Animals = {[1] = sm_string_sheep};
    i = 1
    while CurrentCheck ~= nil do
	CurrentCheck = GetSpellName(i, BOOKTYPE_SPELL)
	if CurrentCheck ~= nil and string.find(string.lower(CurrentCheck), string.lower(sm_string_polymorph..sm_string_colon)) then
	    local _, TempNum = string.find(CurrentCheck, sm_string_colon)
	    TempNum = TempNum + 1
	    tinsert(sm_Animals, string.lower(string.sub(CurrentCheck, TempNum)))
	end
	i = i + 1
    end
    x = 1
    while SheepModOptions[Realm][Player].ResheepAnimal and UnitDebuff("target", x) do	-- Checks for each debuff on the target...
	for y in SheepModConstants.Icons do						-- ...looking for any polymorph debuff...
	    if UnitDebuff("target", x) == SheepModConstants.Icons[y] then		-- ...and if it finds one...
		for z = 1, getn(sm_Animals) do						-- ...it checks if the player can cast that...
		    if sm_Animals[z] == y then						-- ...and if so...
			return y							-- ...recasts it.
		    end
		end
	    end
	end
	x = x + 1
    end
    if SheepModOptions[Realm][Player].Type ~= sm_string_random_animal then
	return SheepModOptions[Realm][Player].Type;
    end
    math.randomseed = time();
    return sm_Animals[math.random(1, getn(sm_Animals))]    
end

function SheepMod.SetConstants()
    SheepModConstants = {};
    SheepModConstants.Specials = {};
    SheepModConstants.Specials[1] = "DisallowedZones"
    SheepModConstants.Specials[2] = "DisallowedMobs"
    SheepModConstants.Specials[3] = "StickyMobs"
    SheepModConstants.Genders = {};
    SheepModConstants.Genders["sheep"]	= 1	-- English.
    SheepModConstants.Genders["pig"]	= 1
    SheepModConstants.Genders["turtle"]	= 1
    SheepModConstants.Genders["mouton"]	= 2	-- French.
    SheepModConstants.Genders["cochon"]	= 2
    SheepModConstants.Genders["tortue"]	= 3
    SheepModConstants.Genders["oveja"]	= 2	-- Spanish.
    SheepModConstants.Genders["cerdo"]	= 2
    SheepModConstants.Genders["tortuga"]= 3
    SheepModConstants.Genders["schaf"]	= 1	-- German.
    SheepModConstants.Genders["schwein"]= 1
    SheepModConstants.Genders["schildkröte"] = 3
    SheepModConstants.Icons = {};
    SheepModConstants.Icons[sm_string_sheep] = "Interface\\Icons\\Spell_Nature_Polymorph"
    i = 1
    while GetSpellName(i, BOOKTYPE_SPELL) do
	if string.find(GetSpellName(i, BOOKTYPE_SPELL), sm_string_polymorph..sm_string_colon) then
	    SheepModConstants.Icons[ string.sub(GetSpellName(i, BOOKTYPE_SPELL), string.len(sm_string_polymorph..sm_string_colon)+1) ] = GetSpellTexture(i, BOOKTYPE_SPELL);
	end
	i = i + 1;
    end
    SheepModConstants.IconID = {};
    SheepModConstants.IconID[ tostring(SheepModConstants.Icons[sm_string_sheep ]) ] = 394
    SheepModConstants.IconID[ tostring(SheepModConstants.Icons[sm_string_pig   ]) ] = 337
    SheepModConstants.IconID[ tostring(SheepModConstants.Icons[sm_string_turtle]) ] = 77
    SheepModConstants.IconID[ tostring(SheepModConstants.Icons[sm_string_cow   ]) ] = 395
    SheepModConstants.IconID[ "nil" ] = nil;
    SheepModConstants.Objects = {};
    local objects	  = SheepMod.Split("SM_EnableMod, SM_TimerBox, SM_Resheep, SM_ResheepAnimal, SM_Players, SM_FFAPvP, SM_MC, SM_MCEmote, SM_MCWarning, SM_MCIgnoreZone, SM_MCRank, SM_ResistEmote, SM_ResistZone, SM_PvPWarning, SM_TimedSheep, SM_StopCasting", ", ");
    local objectVariables = SheepMod.Split("Enabled, Timer, Resheep, ResheepAnimal, WarnPlayers, FFAPvP, MCed, EmoteOnMC, WarnOnMC, MCIgnoreZone, MCRankOn, Resist, ResistZone, PvPWarning, TimedEmoteOn, StopCasting", ", ");
    local objectText	  = SheepMod.Split("enable, timerbox, resheep, resheep_animal, players, ffapvp, mc, mcemote, mcwarning, mcignorezone, mcrank, resist, resistzone, pvpwarning, timed, stopcasting", ", ");
    local disableThis	  = SheepMod.Split("1, Enabled, Enabled, Enabled, Enabled, Enabled, Enabled, MCed, MCed, MCed, MCed, Enabled, Resist, Enabled, Enabled, Enabled", ", ");
    local disableOther	  = SheepMod.Split("SM_TimerBox; SM_Resheep; SM_ResheepAnimal; SM_Players; SM_FFAPvP; SM_MC; SM_ResistEmote; SM_PvPWarning; SM_TimedSheep; SM_StopCasting, none, none, none, none, none, SM_SetMCName; SM_MCEmote; SM_MCWarning; SM_MCIgnoreZone; SM_MCRank, none, none, none, SM_MCRankDropDown"..Location.."Button, SM_ResistZone, none, none, SM_TimedDropDownA"..Location.."Button; SM_TimedDropDownB"..Location.."Button, none", ", ");
    for i, x in objects do
	SheepModConstants.Objects[x] = {};
	SheepModConstants.Objects[x].variable	  = objectVariables[i];
	SheepModConstants.Objects[x].text	  = getglobal("sm_button_"..objectText[i])
	SheepModConstants.Objects[x].disableThis  = disableThis[i];
	SheepModConstants.Objects[x].disableOther = SheepMod.Split(disableOther[i], "; ");
    end
end

function SheepMod.pronoun(gender, returntype, returnLanguage)
    if returnLanguage == sm_english then
	returnLanguage = ""
    else
	returnLanguage = Location
    end
    if gender == nil then
	gender = 4
    end
    local pronoun = {}
    if returnLanguage == "France" and gender == 2 then		-- Masculine: French.
	pronoun[1]  = "le"
	pronoun[2]  = "il"
    elseif returnLanguage == "France" and gender == 3 then	-- Feminine: French.
	pronoun[-2] = "ne";
	pronoun[-1] = "e";
	pronoun[1]  = "la"
	pronoun[2]  = "elle"
    elseif returnLanguage == "France" and gender == 1 then	-- None: French.
	pronoun[1]  = "le"
	pronoun[2]  = "il"
    elseif returnLanguage == "France" and gender == 4 then	-- Unknown: French.
	pronoun[1]  = "le (la)"
	pronoun[2]  = "il (elle)"
    elseif returnLanguage == "Spain" and gender == 2 then	-- Masculine: Spanish.
	pronoun[-2] = "le"	-- dejarle/dejarla
	pronoun[-1] = "el"
	pronoun[1]  = "el"
	pronoun[2]  = ""
	pronoun[3]  = "o"
	pronoun[4]  = "lo"
	pronoun[5]  = "él"
    elseif returnLanguage == "Spain" and gender == 3 then	-- Feminine: Spanish.
	pronoun[-2] = "la"
	pronoun[-1] = "la"
	pronoun[1]  = "la"
	pronoun[2]  = ""
	pronoun[3]  = "a"
	pronoun[4]  = "la"
	pronoun[5]  = "ella"
    elseif returnLanguage == "Spain" and gender == 1 then	-- None: Spanish.
	pronoun[-1] = "el"
	pronoun[1]  = "el"
	pronoun[2]  = ""
	pronoun[3]  = "o"
	pronoun[4]  = "lo"
	pronoun[5]  = "él"
    elseif returnLanguage == "Spain" and gender == 4 then	-- Unknown: Spanish.
	pronoun[1]  = "el"
	pronoun[2]  = ""
	pronoun[3]  = "o"
    elseif returnLanguage == "Germany" and gender == 2 then	-- Masculine: German.
	pronoun[-4] = "ein"
	pronoun[-3] = "dem"
	pronoun[1]  = "ihn"
	pronoun[2]  = "er"
    elseif returnLanguage == "Germany" and gender == 3 then	-- Feminine: German.
	pronoun[-4] = "eine"
	pronoun[-3] = "der"
	pronoun[1]  = "sie"
	pronoun[2]  = "sie"
    elseif returnLanguage == "Germany" and gender == 1 then	-- None: German.
	pronoun[-4] = "ein"
	pronoun[-3] = "dem"
	pronoun[1]  = "es"
	pronoun[2]  = "es"
    elseif returnLanguage == "Germany" and gender == 4 then	-- Unknown: German.
	pronoun[-4] = "ein"
	pronoun[-3] = "dem"
	pronoun[1]  = "ihn"
	pronoun[2]  = "er"
    elseif gender == 2 then					-- Masculine: English.
	pronoun[1] = "him"
	pronoun[2] = "he"
    elseif gender == 3 then					-- Feminine: English.
	pronoun[1] = "her"
	pronoun[2] = "she"
    elseif gender == 1 then					-- None: English.
	pronoun[1] = "it"
	pronoun[2] = "it"
    elseif gender == 4 then					-- Unknown: English.
	pronoun[1] = "them"
	pronoun[2] = "they"
    end
    for i = -4, 5 do
	if pronoun[i] == nil then
	    pronoun[i] = "";
	end
    end
    pronoun[0] = "";
    if pronoun[returntype] == nil then
	returntype = 0;
    end
    return pronoun[returntype]
end

function SheepMod.Split(toCut, separator)
    if tostring(toCut) == nil then
	return
    else
	toCut = tostring(toCut)
    end
    local splitted = {};
    i = 0;
    if separator == nil then
	separator = " ";
    end

    while string.sub(toCut, 1, 1) == separator or string.sub(toCut, 1, 1) == " " do		-- Removes all spaces from the beginning.
	    toCut = string.sub(toCut, 2);
    end
    while string.sub(toCut, -1, -1) == separator or string.sub(toCut, -1, -1) == " " do		-- Removes all spaces from the end.
	    toCut = string.sub(toCut, 1, -2);
    end
    while string.find(toCut, separator) do
	_, CurrentCheck = string.find(toCut, separator)
	i = i + 1
	splitted[i] = string.sub(toCut, 1, string.find(toCut, separator) - 1);
	toCut = string.sub(toCut, CurrentCheck + 1);
    end
    splitted[i+1] = toCut;

    for i = 1, getn(splitted) do
	if string.lower(splitted[i]) == "%n" or string.lower(splitted[i]) == "%t" and UnitName("target") ~= nil then
	    splitted[i] = UnitName("target")
	elseif string.lower(splitted[i]) == "%n" or string.lower(splitted[i]) == "%t" and UnitName("target") == nil then
	    splitted[i] = sm_target_empty
	end
    end
    return splitted;
end

function GetObjectIndex(ObjName)
    if tonumber(string.sub(this:GetName(), -2, -1)) ~= nil then
	SM_Number = tonumber(string.sub(this:GetName(), -2));
	SM_VariableName = string.sub(this:GetName(), 14, -10);
    else
	SM_Number = tonumber(string.sub(this:GetName(), -1));
	SM_VariableName = string.sub(this:GetName(), 14, -9);
    end
end

------------------------------ Main Options UI. ------------------------------

function SheepMod.ShowUI()
    SheepModFrameDisallowedZones:Hide();
    SheepModFrameDisallowedMobs:Hide();
    SheepModFrameStickyMobs:Hide();
    SheepMod_SpecialsFrame:Hide();
    SheepMod_HelpFrame:Hide();
    SheepModFrame:Show();
    SheepMod.change_main_escape();
    SM_UIData = {};
    SheepMod.Refresh();
    SM_RefreshMain:Enable();						-- Set all default text values, and decide what should be shown.
    SM_SetDefaultsInitial:Enable();
    SM_SetDefaultsInitial:SetText(sm_string_set_defaults);
    SM_SetDefaultsConfirm:Enable();
    SM_SetDefaultsConfirm:Hide();
    SM_MC:Enable();
    SM_LanguageString:SetText(sm_string_language);
    UIDropDownMenu_Initialize(getglobal("SM_TypeDropDown"..Location),   SheepMod.TypeDropDown_Initialize);
    UIDropDownMenu_Initialize(getglobal("SM_NefDropDown"..Location),    SheepMod.NefDropDown_Initialize);
    UIDropDownMenu_Initialize(getglobal("SM_MCRankDropDown"..Location), SheepMod.MCRankDropDown_Initialize);
    UIDropDownMenu_Initialize(getglobal("SM_TimedDropDownA"..Location), SheepMod.TimedDropDownA_Initialize);
    UIDropDownMenu_Initialize(getglobal("SM_TimedDropDownB"..Location), SheepMod.TimedDropDownB_Initialize);
    if Location ~= "" then
	UIDropDownMenu_Initialize(getglobal("SM_LanguageDropDown"..Location), SheepMod.LanguageDropDown_Initialize);
    end
    if SheepModOptions[Realm][Player].MCed == 2 then
	SM_MCText:SetText(format(sm_button_mcandname, SheepModOptions[Realm][Player].MCName));
	SM_SetMCName:SetText(sm_string_set_player)
    else
	SM_MCText:SetText(sm_button_mc);	-- Set up the Mind Control text and button.
	SM_SetMCName:SetText(sm_string_set_player)
    end
    SM_EditBoxMCName:Hide();
    if tonumber(SheepModOptions[Realm][Player].SheepSlot) ~= nil and SheepModOptions[Realm][Player].SheepSlot ~= 0 and SM_UIData["MacroFailed"] ~= 1 then
	if SheepModOptions[Realm][Player].SheepSlot > 0 and SheepModOptions[Realm][Player].SheepSlot < 73 then
	    if math.mod(SheepModOptions[Realm][Player].SheepSlot, 12) ~= 0 and GetActionText(SheepModOptions[Realm][Player].SheepSlot) ~= nil then
		SM_PolyLocationString:SetText(format(sm_macro_summary_misc, GetActionText(SheepModOptions[Realm][Player].SheepSlot), 1+(SheepModOptions[Realm][Player].SheepSlot/12)-math.mod(SheepModOptions[Realm][Player].SheepSlot/12, 1), math.mod(SheepModOptions[Realm][Player].SheepSlot,12)), 0, 1, 0)
	    elseif math.mod(SheepModOptions[Realm][Player].SheepSlot, 12) == 0 and GetActionText(SheepModOptions[Realm][Player].SheepSlot) ~= nil then
		SM_PolyLocationString:SetText(format(sm_macro_summary_12, GetActionText(SheepModOptions[Realm][Player].SheepSlot), (SheepModOptions[Realm][Player].SheepSlot/12)-math.mod(SheepModOptions[Realm][Player].SheepSlot/12, 1)), 0, 1, 0)
	    elseif math.mod(SheepModOptions[Realm][Player].SheepSlot, 12) ~= 0 then
		SM_PolyLocationString:SetText(format(sm_spell_summary_misc, 1+(SheepModOptions[Realm][Player].SheepSlot/12)-math.mod(SheepModOptions[Realm][Player].SheepSlot/12, 1), math.mod(SheepModOptions[Realm][Player].SheepSlot,12)), 0, 1, 0)
	    elseif math.mod(SheepModOptions[Realm][Player].SheepSlot, 12) == 0 then
		SM_PolyLocationString:SetText(format(sm_spell_summary_12, (SheepModOptions[Realm][Player].SheepSlot/12)-math.mod(SheepModOptions[Realm][Player].SheepSlot/12, 1)), 0, 1, 0)
	    end
	end								-- The above checks which action bar/slot your macro/spell is on.
	getglobal("SM_TypeDropDown"..Location):Show();
	SM_TypeStringUI:SetText(sm_type);
	if Location ~= "" then
	    getglobal("SM_LanguageDropDown"..Location):Show();
	end
    elseif tonumber(SheepModOptions[Realm][Player].SheepSlot) ~= nil and SheepModOptions[Realm][Player].SheepSlot ~= 0 and SM_UIData["MacroFailed"] == 1 then
	if Location == "" then
	    SM_LanguageString:Show();
	else								-- Show the warning saying you have an incorrect macro.
	    getglobal("SM_LanguageDropDown"..Location):Hide();
	end
	getglobal("SM_TypeDropDown"..Location):Hide();
	SheepModFrame:SetHeight(SheepModFrameHeight+20);
	SM_LanguageString:SetText(format(sm_no_macro_ui_line3, GetActionText(SheepModOptions[Realm][Player].SheepSlot)));
	SM_TypeStringUI:SetText(sm_no_macro_ui_line4);
	SM_PolyLocationString:SetText(sm_no_macro_ui_line2);
    else
	getglobal("SM_TypeDropDown"..Location):Hide();
	SM_TypeStringUI:SetText(sm_no_macro_ui_line1);			-- Show the warning saying you do not have a macro.
	SM_PolyLocationString:SetText(sm_no_macro_ui_line2)
    end
    if SheepModOptions[Realm][Player].MCed == "All valid players" or SheepModOptions[Realm][Player].MCed == false then
	SM_SetMCName:SetText(sm_string_set_player)
    else
	SM_SetMCName:SetText(sm_string_edit)				-- Set up the Mind Control string.
    end
    if Location == "" and SM_UIData["MacroFailed"] ~= 1 then
	SM_LanguageString:Hide();
	SheepModFrame:SetHeight(SheepModFrameHeight);			-- Toggle the Language dropdown.
    elseif SM_UIData["MacroFailed"] ~= 1 then
	SM_LanguageString:Show();
	SheepModFrame:SetHeight(SheepModFrameHeight+20);
    end
    if GetRealZoneText() == sm_string_bwl and SM_UIData["MacroFailed"] ~= 1 and SM_PolyLocationString:GetText() ~= sm_no_macro_ui_line2 then
	SM_PolyLocationString:SetText(sm_nef)				-- Enable the Nefarian dropdown and disable the location information line.
	SM_RefreshMain:Hide();
	getglobal("SM_NefDropDown"..Location):Show();
    elseif GetRealZoneText() ~= sm_string_bwl and SM_UIData["MacroFailed"] ~= 1 and SM_PolyLocationString:GetText() ~= sm_no_macro_ui_line2 then
	SM_RefreshMain:Show();						-- Disable the Nefarian dropdown and enable the location information line.
	getglobal("SM_NefDropDown"..Location):Hide();
    else
	SM_RefreshMain:Show();						-- Disable the dropdown and enable the Refresh button, because the macro's wrong.
	getglobal("SM_NefDropDown"..Location):Hide();	
    end
end

function SheepMod.change_main_escape()
    if SheepModOptions[Realm][Player].MCed == false or SheepModOptions[Realm][Player].MCed == "All valid players" then
	getglobal(SM_MC:GetName().."Text"):SetText(sm_button_mc)
	SM_SetMCName:SetText(sm_string_set_player)
    else
	getglobal("SM_MC".."Text"):SetText(format(sm_button_mcandname, SheepModOptions[Realm][Player].MCName))
	SM_SetMCName:SetText(sm_string_edit)
    end
    if SheepModOptions[Realm][Player].MCed ~= false then
	SM_MC:Enable();
	SM_SetMCName:Enable();
	SM_MCWarning:Enable();
	SM_MCEmote:Enable();
	SM_MCRank:Enable();
	SM_MCIgnoreZone:Enable();
	if SheepModOptions[Realm][Player].MCRankOn then
	    getglobal("SM_MCRankDropDown"..Location.."Button"):Enable();
	end
    end
    SM_UIData["IsEditingMCName"] = nil
    SM_UIData["IsEditingType"] = nil
    getglobal("SM_EditBoxMCName"..Location):Hide();			-- Reverts everything to how it is when the frame is shown.
    SM_SetDefaultsInitial:Enable();
    SM_MC:Enable();
    SM_RefreshMain:Enable();
end

function SheepMod.ToggleMainObject(objectName, actionType)
    if not(getglobal(objectName)) then
	return;
    end
    if SheepModConstants.Objects[objectName] and SheepModConstants.Objects[objectName].disableOther[1] ~= "none" then
	if actionType == "disable" or SheepModOptions[Realm][Player][ SheepModConstants.Objects[objectName].variable ] then
	    for i = 1, getn(SheepModConstants.Objects[objectName].disableOther) do
		SheepMod.ToggleMainObject(SheepModConstants.Objects[objectName].disableOther[i], actionType);	-- Calls this function one "tier" down.
	    end
	end
    end
    if actionType == "disable" then
	getglobal(objectName):Disable();
    elseif actionType == "enable" then
	getglobal(objectName):Enable();
    end
end

function SheepMod.InitMainCheckButton()
    i = SheepModConstants.Objects[ this:GetName() ];
    local sm_Variable, sm_TextVar, sm_DisableThis, sm_DisableOther = i.variable, i.text, i.disableThis, i.disableOther;		-- DisableThis is a variable that disables this checkbox; DisableOther is a list of other objects to be disabled if this button's variable is false.
    this:SetChecked(SheepModOptions[Realm][Player][sm_Variable])
    getglobal(this:GetName().."Text"):SetText(sm_TextVar)
    if not(SheepModOptions[Realm][Player][sm_DisableThis]) then
	this:Disable();
    end
    for i, x in sm_DisableOther do
	if getglobal(x) and not(SheepModOptions[Realm][Player][sm_Variable] and SheepModOptions[Realm][Player][sm_DisableThis]) then
	    SheepMod.ToggleMainObject(x, "disable");
	elseif getglobal(x) then
	    SheepMod.ToggleMainObject(x, "enable");
	end
    end
end

function SheepMod.ClickMainCheckButton()
    local sm_Variable, sm_Disabled = SheepModConstants.Objects[ this:GetName() ].variable, SheepModConstants.Objects[ this:GetName() ].disableOther;
    if not(SheepModOptions[Realm][Player][sm_Variable]) then
	SheepModOptions[Realm][Player][sm_Variable] = true;
    else
	SheepModOptions[Realm][Player][sm_Variable] = false;
    end
    for i = 1, getn(sm_Disabled) do
	if SheepModOptions[Realm][Player][sm_Variable] then
	    SheepMod.ToggleMainObject(sm_Disabled[i], "enable");
	else
	    SheepMod.ToggleMainObject(sm_Disabled[i], "disable");
	end
    end
end

function SheepMod.SetMCName_Click()
    if SM_UIData["IsEditingMCName"] == nil then
	this:SetText(sm_string_confirm)
	SM_UIData["IsEditingMCName"] = 1
	SM_MC:Disable();
	SM_MCWarning:Disable();
	SM_MCEmote:Disable();
	SM_MCRank:Disable();
	SM_MCIgnoreZone:Disable();
	getglobal("SM_MCRankDropDown"..Location.."Button"):Disable();
	if SheepModOptions[Realm][Player].MCName == "" and UnitIsPlayer("target") and UnitFactionGroup("player") == UnitFactionGroup("target") and not(UnitIsUnit("player", "target")) then
	    getglobal("SM_EditBoxMCName"..Location):SetText(UnitName("target"))
	    getglobal("SM_EditBoxMCName"..Location):HighlightText();
	else
	    getglobal("SM_EditBoxMCName"..Location):SetText(SheepModOptions[Realm][Player].MCName)
	    getglobal("SM_EditBoxMCName"..Location):HighlightText();
	end
	getglobal("SM_EditBoxMCName"..Location):Show();
	getglobal(SM_MC:GetName().."Text"):SetText(format(sm_button_mcandname, ""))
	SM_RefreshMain:Disable();
	SM_SetDefaultsInitial:SetText(sm_string_set_defaults);
	SM_SetDefaultsInitial:Disable();
	SM_SetDefaultsConfirm:Enable();
	SM_SetDefaultsConfirm:Hide();
    else
	SheepMod.change_mcname_enter();
    end
end
function SheepMod.change_mcname_enter()
    local temp = getglobal("SM_EditBoxMCName"..Location):GetText();
    temp = string.gsub(temp, " ", "")	-- Remove all spaces.
    temp = CaseControl(temp)
    if temp == "" or temp == nil then
	getglobal(SM_MC:GetName().."Text"):SetText(sm_button_mc)
	SheepModOptions[Realm][Player].MCed = "All valid players"
	SheepModOptions[Realm][Player].MCName = ""
	SM_SetMCName:SetText(sm_string_set_player)
    else
	SheepModOptions[Realm][Player].MCed = 2
	SheepModOptions[Realm][Player].MCName = temp
	getglobal(SM_MC:GetName().."Text"):SetText(format(sm_button_mcandname, SheepModOptions[Realm][Player].MCName))
	SM_SetMCName:SetText(sm_string_edit)
    end
    SM_MC:Enable();
    SM_MCWarning:Enable();
    SM_MCEmote:Enable();
    SM_MCRank:Enable();
    SM_MCIgnoreZone:Enable();
    if SheepModOptions[Realm][Player].MCRankOn then
	getglobal("SM_MCRankDropDown"..Location.."Button"):Enable();
    end
    getglobal("SM_EditBoxMCName"..Location):Hide();
    SM_UIData["IsEditingMCName"] = nil
    SM_RefreshMain:Enable();
    SM_SetDefaultsInitial:Enable();
end


function SheepMod.TypeDropDown_Initialize()
    local info = {}
    info.text = sm_string_random_animal
    info.func = SheepMod.TypeDropDown_OnClick;
    UIDropDownMenu_AddButton(info);
    if SheepModOptions[Realm][Player].Type == sm_string_random_animal then
	UIDropDownMenu_SetSelectedID(getglobal("SM_TypeDropDown"..Location), 1);
    end
    info = {}
    info.text = sm_string_sheep
    info.func = SheepMod.TypeDropDown_OnClick;
    if Location == "Germany" then
	info.text = CaseControl(info.text);
    end
    UIDropDownMenu_AddButton(info);
    if SheepModOptions[Realm][Player].Type == sm_string_sheep then
	UIDropDownMenu_SetSelectedID(getglobal("SM_TypeDropDown"..Location), 2);
    end
    local x = 2
    i = 1
    while GetSpellName(i, BOOKTYPE_SPELL) ~= nil do
	if string.find(GetSpellName(i, BOOKTYPE_SPELL), sm_string_polymorph..sm_string_colon) then
	    local _, temp = string.find(GetSpellName(i, BOOKTYPE_SPELL), sm_string_polymorph..sm_string_colon)
	    info = {}
	    info.text = string.lower(string.sub(GetSpellName(i, BOOKTYPE_SPELL), temp+1))
	    info.func = SheepMod.TypeDropDown_OnClick;
	    if Location == "Germany" then
		info.text = CaseControl(info.text);
	    end
	    UIDropDownMenu_AddButton(info);
	    x = x + 1
	    if SheepModOptions[Realm][Player].Type == string.lower(string.sub(GetSpellName(i, BOOKTYPE_SPELL), temp+1)) then
		UIDropDownMenu_SetSelectedID(getglobal("SM_TypeDropDown"..Location), x);
	    end
	end
	i = i + 1
    end
end
function SheepMod.TypeDropDown_OnLoad()
	UIDropDownMenu_SetWidth(75);
	UIDropDownMenu_SetButtonWidth(24);
	UIDropDownMenu_JustifyText("LEFT", getglobal("SM_TypeDropDown"..Location));
end
function SheepMod.TypeDropDown_OnClick()
	if this:GetText() == sm_string_sheep then
	    i = 1
	    while GetSpellName(i, BOOKTYPE_SPELL) ~= nil do
		if GetSpellName(i, BOOKTYPE_SPELL) == sm_string_polymorph then
		    local _, Temp = GetSpellName(i, BOOKTYPE_SPELL);
		    SheepModOptions[Realm][Player].Rank = tonumber(string.sub(Temp, -1))
		end
		i = i + 1
	    end
	end
	if Location == "Germany" and this:GetText() == sm_string_random_animal then
	    SheepModOptions[Realm][Player].Type = this:GetText();
	else
	    SheepModOptions[Realm][Player].Type = string.lower(this:GetText());
	end
	UIDropDownMenu_SetSelectedID(getglobal("SM_TypeDropDown"..Location), this:GetID());
end

function SheepMod.LanguageDropDown_Initialize()
    local info;
    info = { };
    info.text = sm_language
    info.func = SheepMod.LanguageDropDown_OnClick;
    UIDropDownMenu_AddButton(info);
    info.text = sm_english
    info.func = SheepMod.LanguageDropDown_OnClick;
    UIDropDownMenu_AddButton(info);
    if SheepModOptions[Realm][Player].Language == sm_language then
	UIDropDownMenu_SetSelectedID(getglobal("SM_LanguageDropDown"..Location), 1)
    else
	UIDropDownMenu_SetSelectedID(getglobal("SM_LanguageDropDown"..Location), 2)
    end
end
function SheepMod.LanguageDropDown_OnLoad()
	UIDropDownMenu_SetWidth(75);
	UIDropDownMenu_SetButtonWidth(24);
	UIDropDownMenu_JustifyText("LEFT", getglobal("SM_LanguageDropDown"..Location));
end
function SheepMod.LanguageDropDown_OnClick()
	UIDropDownMenu_SetSelectedID(getglobal("SM_LanguageDropDown"..Location), this:GetID());
	SheepModOptions[Realm][Player].Language = this:GetText();
end

function SheepMod.TimedDropDownA_Initialize()
    local info;
    info = { };
    info.text = sm_string_any
    info.func = SheepMod.TimedDropDownA_OnClick;
    UIDropDownMenu_AddButton(info);
    info.text = sm_string_the_same
    info.func = SheepMod.TimedDropDownA_OnClick;
    UIDropDownMenu_AddButton(info);
    if SheepModOptions[Realm][Player].TimedEmote == sm_string_any then
	UIDropDownMenu_SetSelectedID(getglobal("SM_TimedDropDownA"..Location), 1)
    else
	UIDropDownMenu_SetSelectedID(getglobal("SM_TimedDropDownA"..Location), 2)
    end
end
function SheepMod.TimedDropDownA_OnLoad()
	UIDropDownMenu_SetWidth(78);
	UIDropDownMenu_SetButtonWidth(24);
	UIDropDownMenu_JustifyText("LEFT", getglobal("SM_TimedDropDownA"..Location));
	if getglobal("SM_TimedDropDownA"..Location) then
	    getglobal("SM_TimedDropDownA"..Location):Show();
	end
end
function SheepMod.TimedDropDownA_OnClick()
	UIDropDownMenu_SetSelectedID(getglobal("SM_TimedDropDownA"..Location), this:GetID());
	SheepModOptions[Realm][Player].TimedEmote = this:GetText();
end

function SheepMod.TimedDropDownB_Initialize()
    local info;
    for i, x in {1, 2, 3, 5, 10, 15, 20, 30} do
	info = { };
	info.text = tostring(x)
	info.func = SheepMod.TimedDropDownB_OnClick;
	UIDropDownMenu_AddButton(info);
	if SheepModOptions[Realm][Player].SheepTime == x or x == 1 then
	    UIDropDownMenu_SetSelectedID(getglobal("SM_TimedDropDownB"..Location), i)
	end
    end
end
function SheepMod.TimedDropDownB_OnLoad()
	UIDropDownMenu_SetWidth(40);
	UIDropDownMenu_SetButtonWidth(24);
	UIDropDownMenu_JustifyText("LEFT", getglobal("SM_TimedDropDownB"..Location));
	if getglobal("SM_TimedDropDownB"..Location) then
	    getglobal("SM_TimedDropDownB"..Location):Show();
	end
end
function SheepMod.TimedDropDownB_OnClick()
	UIDropDownMenu_SetSelectedID(getglobal("SM_TimedDropDownB"..Location), this:GetID());
	SheepModOptions[Realm][Player].SheepTime = tonumber(this:GetText());
end

function SheepMod.MCRankDropDown_Initialize()
    local info;
    info = { };
    info.text = "1"
    info.func = SheepMod.MCRankDropDown_OnClick;
    UIDropDownMenu_AddButton(info);
    local NoPoly = true;
    i = 1
    while GetSpellName(i, BOOKTYPE_SPELL) do
	TempA, TempB = GetSpellName(i, BOOKTYPE_SPELL)
	if TempA == sm_string_polymorph and string.sub(TempB, -1) ~= "1" then
	    info = { };
	    info.text = string.sub(TempB, -1)
	    info.func = SheepMod.MCRankDropDown_OnClick;
	    UIDropDownMenu_AddButton(info);
	    NoPoly = false;
	    if SheepModOptions[Realm][Player].MCRank == tonumber(info.text) then
		UIDropDownMenu_SetSelectedID(getglobal("SM_MCRankDropDown"..Location), tonumber(info.text));
	    end
	    
	end
	i = i + 1
    end
    if NoPoly or SheepModOptions[Realm][Player].MCRank == 1 then
	SheepModOptions[Realm][Player].MCRank = 1;
	UIDropDownMenu_SetSelectedID(getglobal("SM_MCRankDropDown"..Location), 1);
    end
end
function SheepMod.MCRankDropDown_OnLoad()
	UIDropDownMenu_SetWidth(33);
	UIDropDownMenu_SetButtonWidth(24);
	UIDropDownMenu_JustifyText("LEFT", getglobal("SM_MCRankDropDown"..Location));
	if getglobal("SM_MCRankDropDown"..Location) then
	    getglobal("SM_MCRankDropDown"..Location):Show();
	end
end
function SheepMod.MCRankDropDown_OnClick()
	UIDropDownMenu_SetSelectedID(getglobal("SM_MCRankDropDown"..Location), this:GetID());
	SheepModOptions[Realm][Player].MCRank = tonumber(this:GetText());
end

function SheepMod.NefDropDown_Initialize()
    local info;
    info = { };
    info.text = sm_string_blizzard
    info.func = SheepMod.NefDropDown_OnClick;
    UIDropDownMenu_AddButton(info);
    if SheepModOptions[Realm][Player].Nef == sm_string_blizzard then
	UIDropDownMenu_SetSelectedID(getglobal("SM_NefDropDown"..Location), 1);
    end
    info = { };
    info.text = sm_string_flamestrike
    info.func = SheepMod.NefDropDown_OnClick;
    UIDropDownMenu_AddButton(info);
    if SheepModOptions[Realm][Player].Nef == sm_string_flamestrike then
	UIDropDownMenu_SetSelectedID(getglobal("SM_NefDropDown"..Location), 2);
    end
    info = { };
    info.text = sm_string_ae
    info.func = SheepMod.NefDropDown_OnClick;
    UIDropDownMenu_AddButton(info);
    if SheepModOptions[Realm][Player].Nef == sm_string_ae then
	UIDropDownMenu_SetSelectedID(getglobal("SM_NefDropDown"..Location), 3);
    end
end
function SheepMod.NefDropDown_OnLoad()
	UIDropDownMenu_SetWidth(75);
	UIDropDownMenu_SetButtonWidth(24);
	UIDropDownMenu_JustifyText("LEFT", getglobal("SM_NefDropDown"..Location));
end
function SheepMod.NefDropDown_OnClick()
	UIDropDownMenu_SetSelectedID(getglobal("SM_NefDropDown"..Location), this:GetID());
	SheepModOptions[Realm][Player].Nef = this:GetText();
end

function SheepMod.SetDefaults(Button)
    if Button == 1 then
	if SM_UIData["SettingDefaults"] == nil then
	    SM_UIData["SettingDefaults"] = 1;
	    this:SetText(sm_string_cancel);
	    SM_SetDefaultsConfirm:Show();
	    SM_MC:Disable();
	    SM_SetMCName:Disable();
	    SM_RefreshMain:Disable();
	else
	    SM_UIData["SettingDefaults"] = nil;
	    if SheepModOptions[Realm][Player].MCed ~= false then
		SM_SetMCName:Enable();
	    end
	    SM_MC:Enable();
	    SM_RefreshMain:Enable();
	    SM_SetDefaultsConfirm:Hide();
	    SM_SetDefaultsInitial:SetText(sm_string_set_defaults);
	end
    elseif Button == 2 then
	this:Hide();
	SM_UIData["SettingDefaults"] = nil;
	SM_SetMCName:Enable();
	SM_RefreshMain:Enable();
	SM_MC:Enable();
	SM_SetDefaultsConfirm:Hide();
	SM_SetDefaultsInitial:SetText(sm_string_set_defaults);
	SheepMod.SetDefaults(3);
	SheepModFrame:Hide();
	SheepMod.ShowUI();
    else
	local CurrentCheck
	i = 1
	while CurrentCheck ~= nil do
	    CurrentCheck, CurrentCheck2 = GetSpellName(i, BOOKTYPE_SPELL);
	    if CurrentCheck ~= nil and (string.lower(CurrentCheck) == string.lower(sm_string_polymorph)..sm_string_colon..sm_string_sheep) or (CurrentCheck == sm_string_polymorph and temp == sm_string_sheep) then
		SheepModOptions[Realm][Player].Rank = tonumber(string.sub(CurrentCheck2, -1, -1));
		SheepModOptions[Realm][Player].Type = sm_string_sheep;
	    end
	i = i + 1
	end
	if SheepModOptions[Realm][Player].Rank == nil then
	    SheepModOptions[Realm][Player].Rank = 4;
	end
	SheepModOptions[Realm][Player].Language = sm_language;
	SheepModOptions[Realm][Player].AutoSetDefaults = "Defaults have been set since download.";
	SheepModOptions[Realm][Player].StopCasting = true;
	SheepModOptions[Realm][Player].Resist = true;
	SheepModOptions[Realm][Player].Enabled = true;
	SheepModOptions[Realm][Player].MCed = "All valid players";
	SheepModOptions[Realm][Player].MCName = "";
	SheepModOptions[Realm][Player].FFAPvP = false;
	SheepModOptions[Realm][Player].WarnPlayers = true;
	SheepModOptions[Realm][Player].WarnOnMC = true;
	SheepModOptions[Realm][Player].EmoteOnMC = true;
	SheepModOptions[Realm][Player].MCIgnoreZone = false;
	SheepModOptions[Realm][Player].TimedEmoteOn = true;
	SheepModOptions[Realm][Player].TimedEmote = sm_string_the_same;
	SheepModOptions[Realm][Player].SheepTime = 3;
	SheepModOptions[Realm][Player].MCRank = 1;
	SheepModOptions[Realm][Player].MCRankOn = true;
	SheepModOptions[Realm][Player].Timer = true;
	SheepModOptions[Realm][Player].PvPWarning = true;
	SheepModOptions[Realm][Player].Resheep = false;
	SheepModOptions[Realm][Player].Type = sm_string_sheep;
	SheepModOptions[Realm][Player].Nef = sm_string_blizzard;
	for x = 1, 3 do
	    for i = 1, getn(sm_defaults[ SheepModConstants.Specials[x] ]) do
		SheepModOptions[Realm][Player][ SheepModConstants.Specials[x] ][i] = sm_defaults[ SheepModConstants.Specials[x] ][i]
	    end
	    for i = getn(sm_defaults[SheepModConstants.Specials[x]]) + 1, getn(SheepModOptions[Realm][Player][ SheepModConstants.Specials[x] ]) do
		SheepModOptions[Realm][Player][ SheepModConstants.Specials[x] ][i] = nil
	    end
	end
    end
end

function SheepMod.StartTimer(sm_name)
    if SheepModOptions[Realm][Player].Timer == false then		-- If the timer has been disabled in the Options.
	return;
    end
    SheepModOptions.Temp.SheepName = sm_name;
    SheepModOptions.Temp.CastStart = time();
    SM_TimerFrame_Number:SetText("0s");
    SM_TimerFrame:Show();
end

--------------------------- Special Zones/Mobs UI. ---------------------------

function SheepMod.ShowSpecialUI()
    SheepMod.Refresh();
    SheepModFrame:Hide();
    SheepMod_HelpFrame:Hide();
    SheepMod_SpecialsFrame:Show();
    SheepModFrameDisallowedZones:Show();
    SheepModFrameDisallowedMobs:Show();
    SheepModFrameStickyMobs:Show();
    SM_UIData = {};
    SM_UIData.Page = {};
    SM_UIData.Page["DisallowedZones"] = 0
    SM_UIData.Page["DisallowedMobs"] = 0
    SM_UIData.Page["StickyMobs"] = 0
    SM_UIData.PageIncrement = 2			-- Constant.
    for i = 1, 3 do
	getglobal("SheepModFrame"..SheepModConstants.Specials[i].."_Up"):SetText(sm_string_up);
	getglobal("SheepModFrame"..SheepModConstants.Specials[i].."_Down"):SetText(sm_string_down);
    end
    SheepMod.UpdateSpecialUI();
    SheepMod.special_swap_enable("enable")
end

function SheepMod.change_special_click()
    GetObjectIndex(this:GetName());
    local SM_Index = SM_Number+SM_UIData["PageIncrement"]*SM_UIData.Page[SM_VariableName]
    if SM_UIData["IsEditing"..SM_VariableName..SM_Number] == nil then
	this:SetText(sm_string_confirm)
	SM_UIData["IsEditing"..SM_VariableName..SM_Number] = 1
	local CurrentEditBox = getglobal("SheepModFrame"..SM_VariableName.."_EditBox"..SM_Number);
	local CurrentString  = getglobal("SheepModFrame"..SM_VariableName.."_String"..SM_Number);
	if SheepModOptions[Realm][Player][SM_VariableName][SM_Index] ~= nil then
	    CurrentEditBox:SetText(SheepModOptions[Realm][Player][SM_VariableName][SM_Index])
	else
	    local CurrentIsFound = nil
	    local CurrentValue = ""
	    if SM_VariableName == "DisallowedZones" then
		CurrentValue = GetRealZoneText();
	    elseif UnitCreatureType("target") == sm_string_humanoid or UnitCreatureType("target") == sm_string_beast or UnitCreatureType("target") == sm_string_critter then
		CurrentValue = UnitName("target")
	    else
		CurrentValue = ""
	    end
	    for i = 1, getn(SheepModOptions[Realm][Player][SM_VariableName]) do
		if SheepModOptions[Realm][Player][SM_VariableName][i] ~= nil and string.lower(CurrentValue) == string.lower(SheepModOptions[Realm][Player][SM_VariableName][i]) then
		    CurrentIsFound = 1
		end
	    end
	    if CurrentIsFound == nil and (SM_VariableName == "DisallowedZones" or (UnitExists("target") and not(UnitIsPlayer("target")) and UnitCanAttack("player", "target"))) then
		CurrentEditBox:SetText(CurrentValue)
	    else
		CurrentEditBox:SetText("")
	    end
	end	
	CurrentEditBox:HighlightText();
	CurrentString:Hide();
	CurrentEditBox:Show();
	SheepMod.special_swap_enable("disable")
    else
	SheepMod.change_special_enter();
    end
end

function SheepMod.change_special_enter()
    local SM_Index = SM_Number+SM_UIData["PageIncrement"]*SM_UIData.Page[SM_VariableName]
    local CurrentEditBox = getglobal("SheepModFrame"..SM_VariableName.."_EditBox"..SM_Number);
    local CurrentString  = getglobal("SheepModFrame"..SM_VariableName.."_String"..SM_Number);
    local CurrentButton  = getglobal("SheepModFrame"..SM_VariableName.."_Change"..SM_Number);
    local temp = CurrentEditBox:GetText()
    SM_UIData["IsEditing"..SM_VariableName..SM_Number] = nil
    while string.sub(temp, 1, 1) == " " do
	temp = string.sub(temp, 2);
    end
    temp = SheepMod.Split(temp, " ")		-- Tear it apart...
    for i = 1, getn(temp) do
	temp[i] = CaseControl(temp[i], i)	-- ...analyze the pieces...
	if i ~= 1 then 
	    temp[0] = temp[0].." "..temp[i]	-- ...and put it back together.
	else
	   temp[0] = temp[i]
	end
    end
    temp = temp[0]
    local OppositeVar = nil
    if SM_VariableName == "DisallowedMobs" then
	OppositeVar = "StickyMobs"
    elseif SM_VariableName == "StickyMobs" then
	OppositeVar = "DisallowedMobs"
    end
    if OppositeVar ~= nil then		-- Removes the unit from DisallowedMobs if put in StickyMobs, and vice versa.
	for i = 1, getn(SheepModOptions[Realm][Player][OppositeVar]) do
	    if SheepModOptions[Realm][Player][OppositeVar][i] == temp then
		for x = i, getn(SheepModOptions[Realm][Player][OppositeVar]) do
		    SheepModOptions[Realm][Player][OppositeVar][x] = SheepModOptions[Realm][Player][OppositeVar][x+1]
		end
	    end
	end
	if SheepModOptions[Realm][Player][OppositeVar][ 8 + SM_UIData.PageIncrement*SM_UIData.Page[OppositeVar] ] == nil and SM_UIData.Page[OppositeVar] > 0 then
	    SM_UIData.Page[OppositeVar] = SM_UIData.Page[OppositeVar] - 1
	end
    end
    for i = 1, getn(SheepModOptions[Realm][Player][SM_VariableName]) do
	if SheepModOptions[Realm][Player][SM_VariableName][i] ~= nil and temp ~= nil and string.lower(temp) == string.lower(SheepModOptions[Realm][Player][SM_VariableName][i]) and i ~= SM_Index then
	    UIErrorsFrame:AddMessage(sm_duplicate_found, 1, 0, 0, UIERRORS_HOLD_TIME)
	    temp = nil
	end
    end
    if temp == "" then
	for i = SM_Index, getn(SheepModOptions[Realm][Player][SM_VariableName]) do
	    SheepModOptions[Realm][Player][SM_VariableName][i] = SheepModOptions[Realm][Player][SM_VariableName][(i+1)]
	end
	while (getn(SheepModOptions[Realm][Player][SM_VariableName]) < (9 - 1) + SM_UIData.PageIncrement*(SM_UIData.Page[SM_VariableName]) and SM_UIData.Page[SM_VariableName] > 0) do
	    SM_UIData.Page[SM_VariableName] = SM_UIData.Page[SM_VariableName] - 1
	end
    elseif SheepModOptions[Realm][Player][SM_VariableName][SM_Index] == nil then
	SheepModOptions[Realm][Player][SM_VariableName][SM_Index] = temp
    else
	SheepModOptions[Realm][Player][SM_VariableName][SM_Index] = temp
    end
    CurrentButton:SetText(sm_string_edit)
    CurrentString:Show();
    CurrentEditBox:Hide();
    SheepMod.UpdateSpecialUI();
end

function SheepMod.change_special_escape()
   local SM_Index = SM_Number+SM_UIData["PageIncrement"]*SM_UIData.Page[SM_VariableName]
    local CurrentEditBox = getglobal("SheepModFrame"..SM_VariableName.."_EditBox"..SM_Number);
    local CurrentString  = getglobal("SheepModFrame"..SM_VariableName.."_String"..SM_Number);
    local CurrentButton  = getglobal("SheepModFrame"..SM_VariableName.."_Change"..SM_Number);
    if SM_UIData["IsEditing"..SM_VariableName..SM_Number] == nil then
	SheepModFrameDiallowedZones:Hide();
    else
	CurrentString:Show();
	CurrentEditBox:Hide();
	CurrentButton:SetText(sm_string_edit)
	SM_UIData["IsEditing"..SM_VariableName..i] = nil
	SheepMod.UpdateSpecialUI();
	SheepMod.special_swap_enable("enable")
    end
end

function SheepMod.special_swap_enable(Command)
    local CurrentButton
    for x = 1, 3 do
	for i = 1, 11 do
	    CurrentButton  = getglobal("SheepModFrame"..SheepModConstants.Specials[x].."_Change"..i);
	    CurrentString  = getglobal("SheepModFrame"..SheepModConstants.Specials[x].."_String"..i);
	    if Command == "enable" then
		CurrentButton:Enable();
		if i < 11 then
		    CurrentString:Show();
		end
	    elseif Command == "disable" and not(SM_VariableName == SheepModConstants.Specials[x] and SM_Number == i) then
		CurrentButton:Disable();
	    end
	end
	CurrentButton  = getglobal("SheepModFrame"..SheepModConstants.Specials[x].."_Up");
	if Command == "enable" then
	    CurrentButton:Enable();
	    CurrentButton  = getglobal("SheepModFrame"..SheepModConstants.Specials[x].."_Down");
	    CurrentButton:Enable();
	elseif Command == "disable" then
	    CurrentButton:Disable();
	    CurrentButton  = getglobal("SheepModFrame"..SheepModConstants.Specials[x].."_Down");
	    CurrentButton:Disable();
	end
    end
end

function SheepMod.UpdateSpecialUI()
    local SM_Index
    local CurrentButton
    local CurrentString
    local CurrentEditBox
    local ButtonToAdd = {}
    for x = 1, 3 do
	ButtonToAdd[x] = nil
	for i = 1, 10 do
	    SM_Index = i+SM_UIData.PageIncrement*SM_UIData.Page[SheepModConstants.Specials[x]]
	    CurrentString = getglobal("SheepModFrame"..SheepModConstants.Specials[x].."_String"..i)
	    CurrentEditBox = getglobal("SheepModFrame"..SheepModConstants.Specials[x].."_EditBox"..i)
	    CurrentButton = getglobal("SheepModFrame"..SheepModConstants.Specials[x].."_Change"..i)
	    if SheepModOptions[Realm][Player][SheepModConstants.Specials[x]][SM_Index] ~= nil then
		CurrentString:SetText(SheepModOptions[Realm][Player][SheepModConstants.Specials[x]][SM_Index])
		CurrentButton:SetText(sm_string_edit)
		CurrentButton:Show();
	    else
		if ButtonToAdd[x] == nil then
		    ButtonToAdd[x] = i
		end
		CurrentString:SetText("")
		CurrentButton:Hide();
	    end
	    SM_UIData["IsEditing"..SheepModConstants.Specials[x]..i] = nil
	    CurrentEditBox:Hide();
	end
	CurrentString = getglobal("SheepModFrame"..SheepModConstants.Specials[x].."_String".."10")
	if CurrentString:GetText() == nil or CurrentString:GetText() == "" then
	    CurrentButton = getglobal("SheepModFrame"..SheepModConstants.Specials[x].."_Down")
	    CurrentButton:Hide();
	    CurrentButton = getglobal("SheepModFrame"..SheepModConstants.Specials[x].."_Change".."11")
	    CurrentButton:Hide();
	else
	    CurrentButton = getglobal("SheepModFrame"..SheepModConstants.Specials[x].."_Down")
	    CurrentButton:Show();
	    CurrentButton = getglobal("SheepModFrame"..SheepModConstants.Specials[x].."_Change".."11")
	    CurrentButton:Show();
	end
	CurrentButton = getglobal("SheepModFrame"..SheepModConstants.Specials[x].."_Up")
	if SM_UIData.Page[SheepModConstants.Specials[x]] == 0 then
	    CurrentButton:Hide();
	else
	    CurrentButton:Show();
	end
	if ButtonToAdd[x] == nil then
	    ButtonToAdd[x] = 11
	end
	CurrentButton = getglobal("SheepModFrame"..SheepModConstants.Specials[x].."_Change"..ButtonToAdd[x])
	CurrentButton:SetText(sm_string_add)
	CurrentButton:Show();
	SheepMod.special_swap_enable("enable")
    end
    for i = 1, 3 do
	if getn(SheepModOptions[Realm][Player][SheepModConstants.Specials[i]]) == 1 then
	    getglobal("SheepModFrame"..SheepModConstants.Specials[i].."_Intro"):SetText(sm_list[SheepModConstants.Specials[i].."1"])
	else
	    getglobal("SheepModFrame"..SheepModConstants.Specials[i].."_Intro"):SetText(format(sm_list[SheepModConstants.Specials[i]], getn(SheepModOptions[Realm][Player][SheepModConstants.Specials[i]])))
	end
    end
end

function SheepMod.end_add_click()
    GetObjectIndex(this:GetName());
    SM_Number = 10
    while SheepModOptions[Realm][Player][SM_VariableName][ SM_Number+SM_UIData.Page[SM_VariableName]*SM_UIData.PageIncrement ] ~= nil do
	SM_UIData.Page[SM_VariableName] = SM_UIData.Page[SM_VariableName] + 1
    end
    while SheepModOptions[Realm][Player][SM_VariableName][ SM_Number+SM_UIData.Page[SM_VariableName]*SM_UIData.PageIncrement ] == nil do
	SM_Number = SM_Number - 1;
    end
    SM_Number = SM_Number + 1
    this = getglobal("SheepModFrame"..SM_VariableName.."_Change"..SM_Number);
    SheepMod.UpdateSpecialUI();
    SheepMod.change_special_click();
end
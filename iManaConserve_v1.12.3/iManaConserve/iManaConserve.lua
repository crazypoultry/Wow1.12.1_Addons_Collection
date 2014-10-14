---------------------------------------------------------------------------------------------
iMCVERSION = "iManaConserve v1.12.3"
---------------------------------------------------------------------------------------------
-- Author
--
--	WakeZero (Maleena on Kel'Thuzad | Force)
-- 
-- Description
--
--	This mod will cancel a heal if the unit's health is less then the threshold healed and
--	the spell has less then the desired casting time remaining. Note that the unit does not
--	have to be selected, but must be in your raid/party. Also note that it will only check/cancel
--	a heal everytime the 'Check Current Heal' key is pressed. This can be done by mashing the
--	action bar key used to cast the heal spell, or assigning a special key in the key bindings.
--
-- Example
--
--	A Flash Heal (1234hp) is cast on party member Leeroy Jenkins. The threshold is set at
--	90% and the casttimer threshold is 0.5 seconds. The Flash Heal will be cancelled on
--	Leeroy if he needs less than 1234 * 0.90 health (1110hp) and has less then 0.5 seconds
--	to cast.
--
-- TODO
--
--	(*) Add localization for more languages
--
-- Changelog
--
--	v1.12.3 [2006-09-26] : Fixed Shaman Chain Heal bug. Thanks pyktis!
--			     : Refixed the blizzard casting bar bug that I rebroke last patch o.O
--
--	v1.12.2 [2006-09-25] : Added option to turn off actionbar feature
--			     : Fixed the way the actionbar feature works, may have fixed druid shift problem
--			     : Fixed the mousewheel feature so that when it's turned off it's off =p
--
--	v1.12.1 [2006-08-27] : Fixed bug that cancelled heals when they shouldn't be cancelled
--
--	v1.12.0 [2006-08-22] : Added ability to mash action button to check for mana conserve
--			     : Fixed several targeting bugs
--			     : Fixed bug that continued to overwrite mousewheel when mod is turned off
--
--	v1.10.4 [2006-06-15] : Fixed imcthresh initialization bug
--			     : Updated French spell names (thanks to Feu)
--
--	v1.10.3 [2006-06-15] : Added Options GUI (Use /imc or new keybinding to open!)
--			     : Added casttimer threshold option
--			     : Added German spell names (thanks to dArkjON [ToF])
--
--	v1.10.2 [2006-06-14] : Added Shaman healing spells
--			     : Added French spell names (thanks to Lokhy)
--			     : Added mousewheel support
--			     : Fixed enhanced tooltip bug
--
--
--	v1.10.1 [2006-06-12] : Added Druid and Paladin healing spells
--			     : Fixed bug where unit wasn't detected if cast on current target
--
--
--	v1.10.0 [2006-06-11] : First Release
--
-- Shoutouts
--
--	Jesus Christ - For joy, life and eternal love (and the whole forgiveness of sins bit)
--
--	Snoweave [Druid] & Drewmilsom [Paladin] - For being such good test subjects
--
--	Blackberrie [Priest] - For helping me work out the tooltip bug =p
--
--	Lokhy - For the Shaman and French spell names!
--
--	www.wowwiki.com - Should have mentioned them from the start! Great stuff ^.^
--
--	dArkjON [ToF] - For the German spell names!
--
--	www.curse-gaming.com - For hosting mods like mine!
--
--	pyktis - For the shaman chain heal bug fix
--
---------------------------------------------------------------------------------------------
-- Variables
---------------------------------------------------------------------------------------------
-- Player Profile
iMCProfile = {}
PlayerName = nil;

-- Key Bindings
BINDING_HEADER_iMANACONSERVE = "iManaConserve";

-- iManaConserve Options Variables
imcbaron = nil;
imctimer = nil;
imcwheel = nil;
imccombat = nil;
imcthresh = 100;
imcrunning = nil;

-- iManaConserve Spell Variables
imcaction = 0;
imcbutton = nil;
imcstart = nil;
imcspell = nil;
imctarget = nil;
imcamount = nil;
imctarname = nil;
imccasting = nil;

---------------------------------------------------------------------------------------------
-- Setup/Profile Functions
---------------------------------------------------------------------------------------------
function iMC_OnLoad()

	-- Setup Slash Commands
	iMC_SetupCommands();
	
	-- Set Events
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("SPELLCAST_START");
	this:RegisterEvent("SPELLCAST_STOP");

	-- Setup Everything Else
	iMC_Setup();
end

function iMC_SetupCommands()

	-- Toggles iMC on and off
	SlashCmdList["iMC"] = iMC_ShowOptions;
	SLASH_iMC1 = "/imc";
	SLASH_iMC2 = "/imanaconserve";

	-- Command List
	SlashCmdList["iMCHELP"] = iMC_Help;
	SLASH_iMCHELP1 = "/imchelp";
	SLASH_iMCHELP2 = "/imanaconservehelp";

	-- Toggles whether iMC cancels heals in combat
	SlashCmdList["imccombat"] = iMC_ToggleCombat;
	SLASH_imccombat1 = "/imccombat";
	SLASH_imccombat2 = "/imanaconservecombat";

	-- Sets heal threshold
	SlashCmdList["imcthresh"] = iMC_SetThresh;
	SLASH_imcthresh1 = "/imcthresh";
	SLASH_imcthresh2 = "/imanaconservethresh";

	-- Sets the wheel settings
	SlashCmdList["imcwheel"] = iMC_ToggleWheel;
	SLASH_imcwheel1 = "/imcwheel";
	SLASH_imcwheel2 = "/imanaconservewheel";
end

function iMC_Setup()

	-- Overwrite any blizzard functions needed
	old_SpellTargetUnit = SpellTargetUnit;
	SpellTargetUnit = iMC_SpellTargetUnit;

	old_CameraZoomIn = CameraZoomIn;
	CameraZoomIn = iMC_CameraZoomIn;

	old_CameraZoomOut = CameraZoomOut;
	CameraZoomOut = iMC_CameraZoomOut;

	oldUseAction = UseAction;
	UseAction = iMC_UseAction;
end

function iMC_InitializeProfile()

	if ( UnitName("player") ) then
		PlayerName = UnitName("player").."|"..iMC_Trim(GetCVar("realmName"));
		iMC_LoadSettings();
	end

	iMC_Report();
end

function iMC_LoadSettings()

	if ( iMCProfile[PlayerName] == nil ) then
		iMCProfile[PlayerName] = {};
		iMCProfile[PlayerName]["mcthresh"] = 100;
		iMCProfile[PlayerName]["mcrunning"] = 'true';
		iMCProfile[PlayerName]["mcbaron"] = 'true';
		iMCProfile[PlayerName]["mccombat"] = 'true';
		iMCProfile[PlayerName]["mcwheel"] = "onzoom";
		iMCProfile[PlayerName]["mctimer"] = nil;
	end

	imcthresh = iMCProfile[PlayerName]["mcthresh"];
	imcrunning = iMCProfile[PlayerName]["mcrunning"];
	imcbaron = iMCProfile[PlayerName]["mcbaron"];
	imccombat = iMCProfile[PlayerName]["mccombat"];
	imcwheel = iMCProfile[PlayerName]["mcwheel"];
	imctimer = iMCProfile[PlayerName]["mctimer"];

	-- imcthresh initialization bug
	if not(imcthresh) then
		imcthresh = 100;
	end
end

function iMC_ResetSettings()
	iMCProfile[PlayerName] = nil;
	iMC_LoadSettings();
	iMC_UpdateOptions();
end

function iMC_SaveVar(varname, value)

	if ( PlayerName ) then
		if ( iMCProfile[PlayerName] ) then
			iMCProfile[PlayerName][varname] = value;
		end
	end
end

---------------------------------------------------------------------------------------------
-- Event Handlers
---------------------------------------------------------------------------------------------
function iMC_OnEvent()

        if (event == "VARIABLES_LOADED") then
		iMC_InitializeProfile();
	elseif (event == "SPELLCAST_START") then
		if(imcrunning) then
			iMC_SpellCastStart(arg1, arg2);
		end
	elseif (event == "SPELLCAST_STOP") then
		if(imcrunning) then
			iMC_SpellCastStop();
		end
	end
end

---------------------------------------------------------------------------------------------
-- Options GUI Functions
---------------------------------------------------------------------------------------------
function iMC_ShowOptions()

	if (iMCOptionsFrame:IsVisible()) then
		HideUIPanel(iMCOptionsFrame);
	else
		iMC_UpdateOptions();
		ShowUIPanel(iMCOptionsFrame);
	end
end

function iMC_UpdateOptions()
	iMCSliderThreshold:SetValue(imcthresh);
	iMCBOXCOMBAT:SetChecked(imccombat);
	iMCBOXONOFF:SetChecked(imcrunning);
	iMCBOXACTIONBAR:SetChecked(imcbaron);

	UIDropDownMenu_Initialize(iMCOptionsMouseWheelDropDown, iMCOptionsMouseWheelDropDown_Initialize);
	UIDropDownMenu_SetWidth(100, iMCOptionsMouseWheelDropDown);
	if(imcwheel == "onzoom") then
		UIDropDownMenu_SetText(iMC_LOCALE_MWSETTING2, iMCOptionsMouseWheelDropDown);
	elseif(imcwheel == "disablezoom") then
		UIDropDownMenu_SetText(iMC_LOCALE_MWSETTING3, iMCOptionsMouseWheelDropDown);
	else
		UIDropDownMenu_SetText(iMC_LOCALE_MWSETTING1, iMCOptionsMouseWheelDropDown);
	end

	UIDropDownMenu_Initialize(iMCOptionsCastTimerDropDown, iMCOptionsCastTimerDropDown_Initialize);
	UIDropDownMenu_SetWidth(100, iMCOptionsCastTimerDropDown);
	if(imctimer) then
		UIDropDownMenu_SetText(imctimer.." seconds", iMCOptionsCastTimerDropDown);
	else
		UIDropDownMenu_SetText(iMC_LOCALE_ALWAYS, iMCOptionsCastTimerDropDown);
	end
end

function iMCOptionsCheckButton_OnLoad()

	-- Setup Check Boxes
	if(this == iMCBOXCOMBAT) then
		getglobal(this:GetName().."Text"):SetText(iMC_LOCALE_INCOMBAT);
	elseif(this == iMCBOXONOFF) then
		getglobal(this:GetName().."Text"):SetText(iMC_LOCALE_RUNNING);
	elseif(this == iMCBOXACTIONBAR) then
		getglobal(this:GetName().."Text"):SetText(iMC_LOCALE_ACTIONBAR);
	end

end

function iMCOptionsMouseWheelDropDown_Initialize()

	local info;
	for i=1,3  do
		info = {};
		info.text = getglobal("iMC_LOCALE_MWSETTING"..i);
		info.func = iMCOptionsMouseWheelDropDown_OnClick;
		
		if(i == 1) then
			info.value = nil;
		elseif(i == 2) then
			info.value = "onzoom";
		elseif(i == 3) then
			info.value = "disablezoom";
		end

		UIDropDownMenu_AddButton(info);
	end
end

function iMCOptionsCastTimerDropDown_Initialize()

	local info;
	for i=0, 2, 0.25 do
		info = {};
		info.func = iMCOptionsCastTimerDropDown_OnClick;

		if (i == 0) then
			info.text = iMC_LOCALE_ALWAYS;
			info.value = nil;
			UIDropDownMenu_AddButton(info);
		elseif (i >= 0.5) then
			info.text = i.." seconds";
			info.value = i;
			UIDropDownMenu_AddButton(info);
		end
	end

end

function iMCOptionsMouseWheelDropDown_OnClick()

	UIDropDownMenu_SetSelectedValue(iMCOptionsMouseWheelDropDown, this.value);
	imcwheel = this.value;
	iMC_SaveVar("mcwheel", imcwheel);
end

function iMCOptionsCastTimerDropDown_OnClick()

	UIDropDownMenu_SetSelectedValue(iMCOptionsCastTimerDropDown, this.value);
	if(this.value == iMC_LOCALE_ALWAYS) then
		imctimer = nil;
	else
		imctimer = this.value;
	end
	iMC_SaveVar("mctimer", imctimer);
end

function iMCOptionsCheckButton_OnClick()

	-- Check which box was clicked
	if(this == iMCBOXCOMBAT) then
		imccombat = this:GetChecked();
		iMC_SaveVar("mccombat", imccombat);
	elseif(this == iMCBOXONOFF) then
		imcrunning = this:GetChecked();
		iMC_SaveVar("mcrunning", imcrunning);
	elseif(this == iMCBOXACTIONBAR) then
		imcbaron = this:GetChecked();
		iMC_SaveVar("mcbaron", imcbaron);
	end

end

---------------------------------------------------------------------------------------------
-- Spell/Action Functions
---------------------------------------------------------------------------------------------
function iMC_SpellTargetUnit(unit)
	imctarget = unit;
	imctarname = UnitName(unit);
	old_SpellTargetUnit(unit);
end

function iMC_SpellCastStart(spellname, castingtime)

	imccasting = 'true';

	-- Check if spell being cast is a heal
	for spell in iMCHealSpells do if(iMCHealSpells[spell] == spellname) then

		imcspell = spellname;

		-- Check to see if we have a target, if not find one
		if not (imctarget) then

			-- First check current target
			if(UnitIsFriend("player","target")) then

				imctarget = "target";
				imctarname = UnitName(imctarget);
			
			-- Check cursor
			else

				imctarname = iMC_getlastword(getglobal("GameTooltipTextLeft1"):GetText());
				imctarget = iMC_getunitID(imctarname);
			end
		end

		-- Calculate the desired time to start checking the spell
		if(imctimer) then
			imcstart = GetTime() + ((castingtime / 1000) - imctimer);
		end

		iMCTooltip:SetOwner(UIParent, "ANCHOR_NONE");

		-- Find how much the spell heals for and add in +healing
		for i=1,120 do if(IsCurrentAction(i)) then

			local resetubertooltips = nil;
			if(GetCVar("UberTooltips") == "0") then
				resetubertooltips = 'true';
				SetCVar("UberTooltips", "1");
			end

			iMCTooltip:ClearLines();
			iMCTooltip:SetAction(i);
			imcamount = iMC_parsenumber(getglobal("iMCTooltipTextLeft"..iMCTooltip:NumLines()):GetText(),2);

			-- Give warning that no healing amount could be found off tooltip
			if not (imcamount) then

				iMC_print("iMCWarning: Could not detect heal amount from tooltip!");
			end

			-- If BonusScanner is on, account for plus healing
			if(BonusScanner and imcamount) then
				local plusheal = BonusScanner:GetBonus("HEAL");

				-- Account for Greater Heal talent
				if(spellname == "Greater Heal") then castingtime = 3000; end;

				-- Account for Healing Touch talent
				if(spellname == "Healing Touch") then castingtime = 3500; end;

				-- Minimum casting time is 1500
				if(castingtime < 1500) then castingtime = 1500; end;
	
				-- Maximum casting time is 3500
				if(castingtime > 3500) then castingtime = 3500; end;

				-- Modify plushealing based on casting time of spell
				plusheal = math.floor(plusheal * (castingtime / 3500));

				--iMC_print(imcamount.." + "..plusheal.." = "..(imcamount+plusheal));

				imcamount = imcamount + plusheal;
			end

			if(resetubertooltips) then
				SetCVar("UberTooltips", "0");
			end

			break;
		end; end
	end; end
end

function iMC_SpellCastStop()
	imcspell = nil;
	imcamount = nil;
	imctarget = nil;
	imcstart = nil;
	imctarname = nil;
	imccasting = nil;
end

function iMC_CheckSpell()

	-- Only run if iManaConserve is suppose to be active
	if (imcrunning and (UnitAffectingCombat("player") or imccombat)) then

		-- Make sure Unit and UnitName match up
		if(imctarget == "target") then
			if not(UnitName(imctarget) == imctarname) then
				imctarget = iMC_getunitID(imctarname);
			end
		end

		-- Can only cancel spell if the spell, target and heal amount are known
		if(imcspell and imctarget and imcamount) then

			-- Make sure spell isn't cancelled early
			if(imcstart and (GetTime() < imcstart)) then
				-- Do Nothing!
			else
				-- If the Unit's health cannot be determined, do nothing
				-- TODO: Find out unit's health (may not be possible)
				if(UnitHealthMax(imctarget) == 100) then
					-- Do Nothing!
				
				-- If the Unit's health is less then the threshold healed, cancel spell
				elseif(UnitHealthMax(imctarget) - UnitHealth(imctarget) < imcamount * (imcthresh/100)) then
					
					SpellStopCasting();
					
					-- Make a time buffer before another actionbar spell is cast (to fix UI bug)
					imcaction = GetTime() + 1;

				end
			end
		end	
	end
end

function iMC_UseAction(button, oncursor, onself)

	if (imcbaron) and (imcrunning) and (button == imcbutton) and ((GetTime() < imcaction) or (IsCurrentAction(button) and not SpellIsTargeting())) then

		iMC_CheckSpell();
	else
		imcbutton = button;
		oldUseAction(button, oncursor, onself);
	end
end

---------------------------------------------------------------------------------------------
-- Mousewheel Functions (Replaces camera zoom in/out functions)
---------------------------------------------------------------------------------------------
function iMC_CameraZoomIn(increment)

	if(imcrunning) then

		if not (imcwheel == "Off") then
			iMC_CheckSpell();
		end
	
		if(imcwheel == "disablezoom") then
			--Do Nothing!
		else
			old_CameraZoomIn(increment);
		end
	else
		old_CameraZoomIn(increment);
	end
end

function iMC_CameraZoomOut(increment)

	if(imcrunning) then

		if not (imcwheel == "Off") then
			iMC_CheckSpell();
		end
	
		if(imcwheel == "disablezoom") then
			--Do Nothing!
		else
			old_CameraZoomOut(increment);
		end
	else
		old_CameraZoomOut(increment);
	end
end

---------------------------------------------------------------------------------------------
-- Utility Functions
---------------------------------------------------------------------------------------------
function iMC_print(msg)
	DEFAULT_CHAT_FRAME:AddMessage(msg);
end

function iMC_parsenumber(text, index)
  	if not text then return nil end

  	local i = 1;
  	for number in string.gfind(text, '%d+[.,]?%d*') do
     	if i == index then
		number = string.gsub(number, ",", ".");
        	return tonumber(number);
      	end
      	i = i + 1;
   	end
end

function iMC_getlastword(text)
	if not text then return nil end
	local lastword = nil;
	for word in string.gfind(text, '%w+') do
		lastword = word;
	end
	return lastword;
end

function iMC_Trim(s)
	return (string.gsub(s, "^%s*(.-)%s*$", "%1"));
end

function iMC_getunitID(unitName)
	if(unitName == UnitName("player")) then
        	return "player";
	end

	if(GetNumRaidMembers() > 0) then
		for i=1,40 do
			local trialUnit = "raid"..i;
			if(unitName == UnitName(trialUnit)) then
				return trialUnit;
			end
		end
	elseif(GetNumPartyMembers() > 0) then
		for i = 1,4 do
			local trialUnit = "party"..i;
			if(unitName == UnitName(trialUnit)) then
				return trialUnit;
			end
		end
	end
end

---------------------------------------------------------------------------------------------
-- Slash Command Functions
---------------------------------------------------------------------------------------------
function iMC_Report()
	if(imcrunning) then
		iMC_print("iManaConserve is |cFF00FF00ON".."|cFFFFFFFF ["..iMC_LOCALE_HELP.."]");
	else
		iMC_print("iManaConserve is |cFFFF0000OFF".."|cFFFFFFFF ["..iMC_LOCALE_HELP.."]");
	end
end

function iMC_Help()

	iMC_print("|cFFFFFF00"..iMC_LOCALE_HELP);
end

function iMC_ToggleRun()
	
	if (imcrunning == nil) then
		iMC_print("iManaConserve is now |cFF00FF00ON");
		imcrunning = 'true';
	else
		iMC_print("iManaConserve is now |cFFFF0000OFF");
		imcrunning = nil;
	end

	iMC_SaveVar("mcrunning", imcrunning);
end

function iMC_ToggleCombat()

	if (imccombat == nil) then
		iMC_print("iManaConserve will now work out of combat");
		imccombat = 'true';
	else
		iMC_print("iManaConserve will no longer work out of combat");
		imccombat = nil;
	end

	iMC_SaveVar("mccombat", imccombat);
end

function iMC_SetThresh(arg1)

	local thresh = iMC_parsenumber(arg1, 1);

	if(thresh >= 0 and thresh <= 100) then
		imcthresh = thresh;
	else
		iMC_print("The healing threshold must be between 0 and 100!");
	end
	iMC_print("The healing threshold is set at: |cFF00FF00"..imcthresh.."%");

	iMC_SaveVar("mcthresh", imcthresh);
end

function iMC_ToggleWheel()

	if(imcwheel == "off") then
		iMC_print("iManaConserve will now Check Current Heal |cFF00FF00ON CAMERA ZOOM");
		imcwheel = "onzoom";
	elseif(imcwheel == "onzoom") then
		iMC_print("iManaConserve will now |cFFFF0000REPLACE CAMERA ZOOM");
		imcwheel = "disablezoom";
	else
		iMC_print("iManaConserve |cFFFF0000WILL NOT |cFFFFFFFFuse the mousewheel");
		imcwheel = "off";
	end
	
	iMC_SaveVar("mcwheel", imcwheel);
end


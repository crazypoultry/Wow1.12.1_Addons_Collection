--[[
-----------------------------
M. Stoyanov aka Screamer aka Screamerka
Heroes Of Beer @ EU Dragonmaw (http://towerhills.spnet.net)
Titan [Aggro] download pages http://ui.worldofwar.net/ui.php?id=1608 and http://www.curse-gaming.com/mod.php?addid=2666
-----------------------------

Changes
2.8.9
* Patch 1.12 ready
* UnitName modified to use new format specified for Cross-Realm battlegrounds.

2.8.8
* Patch 1.11 ready
* PlayerFrame menu fix. It will no longer produce errors

2.8.7
* Patch 1.10 ready
* Small first-time-run fix

2.8.6
* French locatization updated, thanks to Childounette

2.8.5
* The configuration menu can be called from "Addons Config" section in the PlayerFrame (where are the loot type options, "Leave Party" and etc)
* Changed the command line option from '/ta' to '/aggro' (also '/taggro'). '/ta' still usable
* Added "Include Pets" option to "Auto-Detect Aggro" section. Enabling it means that TitanAggro will use pets (yours and party/raid) target's target to detect aggro
* Fixed player pet aggro icon for "Auto-Detect Aggro" functionality. Now TitanAggro will make visual notification if your pet got the aggro
* Fixed Titan Panel 2.12 detection

2.8.4
* Updated .toc files due to WoW patch 1.9
* German localization fixes

2.8.3
* German localization is fixed now (thanks to Farook)

2.8.2
* Fixed classes localization problems when reporting
* Fixed bug with remembering the settings of "Report When Aggro Switches To"
* Fixed player class "Rogue" for section "Custom" in "Report When Aggro Switches To"
* Added option to section "Sounds when aggro switch". The new option is "In Party/Raid"
* Added option "Player" for section "Custom" in "Report When Aggro Switches To"
* Added report channel "Whisper to target". It will whisper "YOU GOT THE AGGRO!" to your target's target

2.8.1
* Added options to section "Sounds when aggro switch". The new options are "In Party" and "In Raid"

2.8
* HP/MP status bar is now dragable/moveable
* Placing Titan Panel on bottom will make the addon to append HP/MP status to target frame
* Fixed HP/MP status bar frames bug, where the status was not hiding when u hide the whole user interface (Alt+Z)
* Fixed French localization (thanks to Beug)
* Added "All but Player" class selection for option "Report When Aggro Switches To"
* Changed name of class selection "Me" to "Player" for option "Report When Aggro Switches To"
* Fixed error when running Titan Aggro for the first time

2.7.6
* Forgot some debug info in previous release :S

2.7.5
* Added feature to report to multiple channels
* Added custom class selection for option "Report When Aggro Switches To"
* Added key binding to turn on/off reports. Exit from WoW before updating
* Removed classes Paladin and Shaman from Healer section

2.7.3
* Fixed bug when reporting to console

2.7.2
* Fixed '/ta help' command line option

2.7.1
* HP/MP bar auto relocated when TitanPanel is not present
* Fixed errors when bar is relocated

2.7
* Titan Aggro no longer requires TitanPanel. Of course it's an option to use TitanPanel for easier config
* Added own call timers and etc.
* Fixed few little bugs in the command line options code

2.6
* Added target's target name when HP/MP bar is relocated
* If you click over the HP/MP bar when it's relocated it will select target's target as your target
* The whole settings code is changed. Full exit of WoW is required before updating
* Added command line options. Try '/ta help'
* Too sleepy to write the rest :)

2.5
* Added sounds when aggro switch to player
* Added different report formats
* Added "Auto-Detect Aggro". This is a whole new way to find which one of your party/you got aggro and make visual notification. Actually it scans all the party/raid members target's targets. Thanks to Beug
* HP/Mana bar can be relocated just above the target tooltip
* Splitted the addon code to many files. Full exit of WoW is required before updating

2.4.5
* Holding Ctrl/Alt + Click over the addon will select your previous target

2.4.4
* Added report option when aggro switch "All but Warriors"
* Added player class Shaman

2.4.3
* Fixed report bugs and more bugs

2.4
* Added report channel 'Screen'
* Added option "Reports" which controls overall reporting - ON/OFF
* Added mouse-over tooltip
* Fixed DE and FR localization but still they are not finished
* Fixed target's target position when TitanBar is placed on bottom
* Code cleanup

2.3
* Addon was renamed to 'Titan [Aggro]'
* Introduced CT_RaidAssist reports (requires CT_RaidAssist) - similar to '/rs' command. You can make announces only if you are in raid and you are promoted/leader
* Introduced localization files. Expect more supported languages soon
* Intruduced time interval between reports so you won't flood a certain channel. Any report events during the 'silence' time will not be reported (yeah, got ignored by some players when a Lava Surger started to switch targets ^^)

2.2-beta
* Added target's target HP/Mana status bars just below the addon button (thanks to Beug)
* Fixed colors of the mana bar for every class (red for warriors, yellow for rogues)
* Added class type if target's target is player
* The mod now respond more quickly when you select a target
* Introduced target cache to save some CPU time
* Clicking over the bar will make the script assist on your target's target
]]

function TitanAggroButton_OnLoad()
	this:RegisterEvent("PLAYER_TARGET_CHANGED");
	SLASH_AGGRO1 = "/aggro";
	SLASH_AGGRO2 = "/taggro";
	SLASH_AGGRO3 = "/ta";
	SlashCmdList["AGGRO"] = function(msg)
		TitanAggro_CommandHandler(msg);
	end
	this.registry={
		id=TITAN_AGGRO_ID,
		menuText=TITAN_AGGRO_MENU_TEXT,
		buttonTextFunction="TitanAggroButton_GetButtonText",
		tooltipTitle = TITAN_AGGRO_MENU_TEXT,
		tooltipTextFunction = "TitanAggroButton_GetTooltipText",
		frequency = TITAN_AGGRO_FREQUENCY,
		savedVariables = {
			ShowLabelText = 1,
			ShowColoredText = 1,
			DoReports = 0,
			ReportChans = {},
			ReportType = 0,
			ReportTypeCustom = 0,
			ReportTypeCustomClasses = {},
			ReportFormat = 0,
			ReportTime = 0,
			TankMode = 0,
			ShowTT_HP = 1,
			RelocateTT_HP = 1,
			HideFlashTT_HP = 0,
			MoveableTT_HP = 0,
			AggroDetect = 0,
			AggroDetectPets = 0,
			Sounds = 1,
		}
	}
	DEFAULT_CHAT_FRAME:AddMessage(TITAN_AGGRO_MENU_TEXT..": Running");
	if (AggroVars.TitanPanel) then
		TitanPanelButton_OnLoad();
	end
end

function TitanAggroButton_OnEvent()
--	DEFAULT_CHAT_FRAME:AddMessage("Target changed");
	if (AggroVars.TitanPanel) then
		TitanPanelButton_UpdateButton(TITAN_AGGRO_ID);
		TitanPanelButton_UpdateTooltip();
	else
		TitanAggro_UpdateStatus();
	end
end

function TitanAggroButton_OnClick(button, SendToTitanPanel)
--	DEFAULT_CHAT_FRAME:AddMessage("Click");
	if (( button == "LeftButton" ) and (IsAltKeyDown() or IsControlKeyDown()) and AggroVars.LastSavedTarget) then
		TargetByName(AggroVars.LastSavedTarget);
	elseif ( button ==  "LeftButton" and UnitName("targettarget")) then
		if ( CursorHasItem() ) then
			DropItemOnUnit("targettarget");
		else
			AggroVars.LastSavedTarget = UnitName("target");
			TargetUnit("targettarget");
		end
	end
	if (AggroVars.TitanPanel and SendToTitanPanel) then
		TitanPanelButton_OnClick(button);
	end
end

function TitanAggro_UpdateStatus()
	local buttontext = "";
	local target = {};

	AggroVars.TitanAggroRunning = 1;
	AggroVars.Cycles=AggroVars.Cycles+1;
	if (not AggroVars.ConfigLoaded) then
		TitanAggro_LoadConfig();
	end

	if (TitanAggroGetVar("DragableTT_HP") and TitanAggroGetVar("DragableTT_HP") == 1) then
		return TITAN_AGGRO_BUTTON_LABEL, format(TITAN_AGGRO_BUTTON_TEXT, TitanAggro_GetColoredText("Dragging", GREEN_FONT_COLOR));
	end

	if (UnitName("target") and UnitName("targettarget") and UnitName("targettarget") ~= "Unknown Entity") then
	-- Target has a target
		target.source = UnitName("target");
		target.source_friendly = UnitIsFriend("player", "target");
		target.name = UnitName("targettarget");
		target.friendly = UnitIsFriend("player", "targettarget");
		target.shown_class, target.class = UnitClass("targettarget");
		target.is_player = UnitIsPlayer("targettarget");
		AggroVars.Inactive = nil;
	end

	if (target.source == AggroVars.PrevTarget.source and target.name == AggroVars.PrevTarget.name and AggroVars.UseCache) then
	-- No change in target and target's target. Use the cache to save some CPU cycles
		color = AggroVars.LastColor;
		if (AggroVars.LastTargetIsPlayer and not target.source_friendly) then
			if (TitanAggroGetVar("TankMode") > 0) then
				TitanAggro_TitanAggro_AggroStatusBGUpdate(0,1,0);
			else
				TitanAggro_TitanAggro_AggroStatusBGUpdate(1,0,0);
			end
		else
			TitanAggro_TitanAggro_AggroStatusBGReset();
		end
	else
		if (target.name and UnitName("player") ~= target.source) then
--		if (target.name) then
		-- This area controls the button..
			if (target.name == UnitName("player")) then
			-- it has you targeted
				color = TitanAggro_Colorize("red", target.class);
				if (not target.source_friendly) then
					if (TitanAggroGetVar("TankMode") > 0) then
						if (TitanAggroGetVar("Sounds") > 0 and (TitanAggroGetVar("Sounds") == 1 or (TitanAggroGetVar("Sounds") == 2 and GetNumPartyMembers()>0) or (TitanAggroGetVar("Sounds") == 3 and GetNumRaidMembers() > 0) or (TitanAggroGetVar("Sounds") == 4 and (GetNumPartyMembers()>0 or GetNumRaidMembers() > 0)))) then
							PlaySoundFile("Sound\\Doodad\\BellTollAlliance.wav");
						end
						TitanAggro_TitanAggro_AggroStatusBGUpdate(0,1,0);
					else
						if (TitanAggroGetVar("Sounds") > 0 and (TitanAggroGetVar("Sounds") == 1 or (TitanAggroGetVar("Sounds") == 2 and GetNumPartyMembers()>0) or (TitanAggroGetVar("Sounds") == 3 and GetNumRaidMembers() > 0) or (TitanAggroGetVar("Sounds") == 4 and (GetNumPartyMembers()>0 or GetNumRaidMembers() > 0)))) then
							PlaySoundFile("Sound\\Doodad\\BellTollHorde.wav");
						end
						TitanAggro_TitanAggro_AggroStatusBGUpdate(1,0,0);
					end
				else
					TitanAggro_TitanAggro_AggroStatusBGReset();
				end
				AggroVars.LastTargetIsPlayer = 1;
			else
				if (target.class == "Warrior") then
					color = TitanAggro_Colorize("green", target.class);
					TitanAggro_TitanAggro_AggroStatusBGReset();
				else
					color = TitanAggro_Colorize("normal", target.class);
					TitanAggro_TitanAggro_AggroStatusBGReset();
				end
				AggroVars.LastTargetIsPlayer = nil;
			end

		-- This area controls reporting
			if (AggroVars.PrevTarget.source ~= target.source) then
			-- we have point to another target
				AggroVars.PrevTarget.source = target.source;
				AggroVars.PrevTarget.name = target.name;
				AggroVars.PrevTarget.class = target.class;
			else
				if (target.name ~= AggroVars.PrevTarget.name and not target.source_friendly) then
				-- theres a change in targets
					local report_custom_classes = TitanAggroGetVar("ReportTypeCustomClasses");
					if (TitanAggroGetVar("ReportType") == 1 or (TitanAggroGetVar("ReportType") == 10 and target.name == UnitName("player")) or (TitanAggroGetVar("ReportType") == 11 and target.name ~= UnitName("player"))) then
						TitanAggro_SendReport(target.source, target.name, TitanAggroGetVar("ReportChans"), target.friendly, target.is_player);
					elseif (TitanAggroGetVar("ReportTypeCustom") == 1 and (report_custom_classes[target.class] or (report_custom_classes["PLAYER"] == true and target.name == UnitName("player")))) then
						TitanAggro_SendReport(target.source, target.name, TitanAggroGetVar("ReportChans"), target.friendly, target.is_player);
					elseif (AggroVars.ReportMatrix[target.class] and AggroVars.ReportMatrix[target.class][TitanAggroGetVar("ReportType")]) then
						TitanAggro_SendReport(target.source, target.name, TitanAggroGetVar("ReportChans"), target.friendly, target.is_player);
					end
					AggroVars.PrevTarget.name = target.name;
				end
			end
			AggroVars.UseCache = 1;
		else
		-- It is inactive
--			AggroVars.PrevTarget = {};
			AggroVars.Inactive = 1;
			color = GRAY_FONT_COLOR;
			target.name = AggroVars.Inactive_Text;
			TitanAggro_TitanAggro_AggroStatusBGReset();
			AggroVars.UseCache = nil;
		end

		if (color ~= GRAY_FONT_COLOR and target.source_friendly) then
			color = GREEN_FONT_COLOR;
			AggroVars.LastTargetIsPlayer = nil;
		end
	end

	TitanAggro_StatusBarBGUpdate();
	TitanAggro_StatusBarUpdate();

	if (not AggroVars.Inactive and UnitIsPlayer("targettarget")) then
		target_text = " ("..target.shown_class..")";
	else
		target_text = "";
	end

	if (TitanAggroGetVar("AggroDetect") and TitanAggroGetVar("AggroDetect") > 0) then
		TitanAggro_CheckUpdatedAggroList();
	else
		TitanAggro_Icons_ResetIcon();
	end

	AggroVars.LastColor = color;
	buttontext = format(TITAN_AGGRO_BUTTON_TEXT, TitanAggro_GetColoredText(target.name, color)..target_text);
	return TITAN_AGGRO_BUTTON_LABEL, buttontext;
end

function TitanAggro_Colorize(level, class)
	if (TitanAggroGetVar("TankMode") > 0) then
		if (level == "red") then return GREEN_FONT_COLOR; end
		if (level == "normal") then return RED_FONT_COLOR; end
		if (level == "green") then
			if (class == "Paladin") then return RED_FONT_COLOR; else return NORMAL_FONT_COLOR; end
		end
	else
		if (level == "red") then return RED_FONT_COLOR; end
		if (level == "normal") then return NORMAL_FONT_COLOR; end
		if (level == "green") then return GREEN_FONT_COLOR; end
	end
end

function TitanAggro_SendReport(source, target, report_chans, friendly, is_player)
	local message = format(AggroVars.ReportFormats[TitanAggroGetVar("ReportFormat")], source, target);

	if (TitanAggroGetVar("DoReports") ~= 1) then return; end;

	-- duplicate report check
	if (AggroVars.LastReportedSource == source and AggroVars.LastReportedTarget == target) then
		return;
	else
		AggroVars.LastReportedSource = source;
		AggroVars.LastReportedTarget = target;
	end

	for channel=0, 10 do
		if (report_chans[channel]) then
			if (channel == 0) then
				DEFAULT_CHAT_FRAME:AddMessage(TITAN_AGGRO_NAME..": "..message, 1.0, 1.0, 0.5);
			end

			if (channel == 1) then
				UIErrorsFrame:AddMessage(TITAN_AGGRO_NAME..": "..message, 1.0, 1.0, 0.0, 1.0, UIERRORS_HOLD_TIME);
			end

			-- flood control
			if (TitanAggroGetVar("ReportTimeSec") and AggroVars.Cycles < AggroVars.LastReport + TitanAggroGetVar("ReportTimeSec")) then
				return;
			end

			AggroVars.LastReport = AggroVars.Cycles;
			if (channel == 8 and is_player and friendly and target ~= UnitName("player")) then
				SendChatMessage(AggroVars.YouGotTheAggro_Text, "WHISPER", DEFAULT_CHAT_FRAME.editBox, target);
			elseif (channel == 7) then
				CT_RA_AddMessage("MS " .. message);
			elseif (channel ~= 0 and channel ~= 1 and channel ~= 8) then
				SendChatMessage(message, AggroVars.ReportChans2Command[channel]);
			end
		end
	end
end

function TitanAggro_StatusBarUpdate()
	if (TitanAggroGetVar("MoveableTT_HP") and TitanAggroGetVar("MoveableTT_HP") == 1) then
		-- will add border for the frame in next version... may be
	else
		if (TitanAggroGetVar("RelocateTT_HP") == 1 or not AggroVars.TitanPanel) then
			if (TitanAggroGetVar("RelocateTT_HP") ~= AggroVars.TTHP_Relocated) then
				TitanAggro_HPStatusBar:ClearAllPoints();
				TitanAggro_HPStatusBar:SetPoint("BOTTOM", "TargetFrame", "TOPLEFT", 62, 2);
				TitanAggro_ToT:ClearAllPoints();
				TitanAggro_ToT:SetPoint("TOP", "TitanAggro_HPStatusBar", "TOP", 1, -16);
				TitanAggro_ToTText:Show();
				AggroVars.TTHP_Relocated = TitanAggroGetVar("RelocateTT_HP");
				AggroVars.LastTitanPanel_Pos = 100;
			end
		elseif (AggroVars.TitanPanel and TitanPanelGetVar("Position") ~= AggroVars.LastTitanPanel_Pos) then
			if (TitanPanelGetVar("Position") == TITAN_PANEL_PLACE_TOP) then
				TitanAggro_HPStatusBar:ClearAllPoints();
				TitanAggro_HPStatusBar:SetPoint("BOTTOM", "TitanPanelAggroButton", "BOTTOM", 0, 1);
				TitanAggro_ToT:ClearAllPoints();
				TitanAggro_ToT:SetPoint("TOP", "TitanAggro_HPStatusBar", "TOP", 1, -16);
				TitanAggro_ToTText:Hide();
			else
				TitanAggro_HPStatusBar:ClearAllPoints();
				TitanAggro_HPStatusBar:SetPoint("BOTTOM", "TargetFrame", "TOPLEFT", 62, 2);
				TitanAggro_ToT:ClearAllPoints();
				TitanAggro_ToT:SetPoint("TOP", "TitanAggro_HPStatusBar", "TOP", 1, -16);
				TitanAggro_ToTText:Show();
				TitanAggroSetVar("RelocateTT_HP", 1);
				TitanAggroSetVar("DragableTT_HP", 0);
				TitanAggroSetVar("MoveableTT_HP", 0);
			end
			AggroVars.LastTitanPanel_Pos = TitanPanelGetVar("Position");
			AggroVars.TTHP_Relocated = 100;
		end
	end

	if (not AggroVars.Inactive and TitanAggroGetVar("ShowTT_HP") > 0) then
		TitanAggro_ToTText:SetText(UnitName("targettarget"));
		if (not TitanAggro_HPStatus:IsVisible()) then
			TitanAggro_HPStatus:Show();
			TitanAggro_MPStatus:Show();
			if (TitanAggroGetVar("RelocateTT_HP") > 0 or TitanAggroGetVar("MoveableTT_HP") > 0 or not AggroVars.TitanPanel) then
				TitanAggro_ToT:Show();
			end
		end
		local maxValue = UnitHealthMax("targettarget");
		if (maxValue) then
			local currentValue = UnitHealth("targettarget");
			TitanAggro_HPStatus:SetMinMaxValues(0, maxValue);
			TitanAggro_HPStatus:SetValue(currentValue);
		else
			TitanAggro_HPStatusBG:SetMinMaxValues(0, 0);
			TitanAggro_HPStatusBG:SetValue(0);
		end

		maxValue = UnitManaMax("targettarget");
		if (maxValue) then
			local currentValue = UnitMana("targettarget");
			TitanAggro_MPStatus:SetMinMaxValues(0, maxValue);
			TitanAggro_MPStatus:SetValue(currentValue);
		else
			TitanAggro_MPStatusBG:SetMinMaxValues(0, 0);
			TitanAggro_MPStatusBG:SetValue(0);
		end
		if (UnitClass("targettarget")) then
			local _, uclass = UnitClass("targettarget");
			if (uclass and AggroVars.ColorizeManaBar[uclass]) then
				TitanAggro_MPStatus:SetStatusBarColor(AggroVars.ColorizeManaBar[uclass].r * 2,AggroVars.ColorizeManaBar[uclass].g * 2,AggroVars.ColorizeManaBar[uclass].b * 2);
			end
		end
	else
		if (TitanAggro_HPStatus:IsVisible()) then
			TitanAggro_HPStatus:Hide();
			TitanAggro_MPStatus:Hide();
			TitanAggro_ToT:Hide();
		end
	end
end

function TitanAggro_StatusBarBGUpdate()
	if (not AggroVars.Inactive and TitanAggroGetVar("ShowTT_HP") > 0) then
		if(not TitanAggro_HPStatusBG:IsVisible()) then
			TitanAggro_HPStatusBG:Show();
			TitanAggro_MPStatusBG:Show();
		end
		local maxValue = UnitHealthMax("targettarget");
		if (maxValue) then
			TitanAggro_HPStatusBG:SetMinMaxValues(0, maxValue);
			TitanAggro_HPStatusBG:SetValue(maxValue);
		else
			TitanAggro_HPStatusBG:SetMinMaxValues(0, 0);
			TitanAggro_HPStatusBG:SetValue(0);
		end

		maxValue = UnitManaMax("targettarget");
		if (maxValue) then
			TitanAggro_MPStatusBG:SetMinMaxValues(0, maxValue);
			TitanAggro_MPStatusBG:SetValue(maxValue);
		else
			TitanAggro_MPStatusBG:SetMinMaxValues(0, 0);
			TitanAggro_MPStatusBG:SetValue(0);
		end
		if (UnitClass("targettarget")) then
			local _, uclass = UnitClass("targettarget");
			if (uclass and AggroVars.ColorizeManaBar[uclass]) then
				TitanAggro_MPStatusBG:SetStatusBarColor(AggroVars.ColorizeManaBar[uclass].r,AggroVars.ColorizeManaBar[uclass].g,AggroVars.ColorizeManaBar[uclass].b);
			end
		end
	else
		if(TitanAggro_HPStatusBG:IsVisible()) then
			TitanAggro_HPStatusBG:Hide();
			TitanAggro_MPStatusBG:Hide();
		end
	end
end

function TitanAggro_TitanAggro_AggroStatusBGUpdate(r,g,b)
	if (not AggroVars.Inactive and TitanAggroGetVar("ShowTT_HP") > 0 and TitanAggroGetVar("HideFlashTT_HP") == 0) then
		TitanAggro_AggroStatusBG:SetStatusBarColor(r,g,b,currentAlpha);
		if (currentAlpha == 1) then
			currentAlpha = 0;
		else
			currentAlpha = 1;
		end
	else
		TitanAggro_TitanAggro_AggroStatusBGReset();
	end
end

function TitanAggro_TitanAggro_AggroStatusBGReset()
	TitanAggro_AggroStatusBG:SetStatusBarColor(0,0,0,0);
end

function TitanAggro_Debug(text)
--	TITAN_AGGRO_DEBUG = 1;
	if (TITAN_AGGRO_DEBUG) then
		DEFAULT_CHAT_FRAME:AddMessage("[Aggro] "..text);
	end
end

function TitanAggro_ToggleReport()
	if (TitanAggroGetVar("DoReports") and TitanAggroGetVar("DoReports") == 1) then
		TitanAggroSetVar("DoReports", 0);
		DEFAULT_CHAT_FRAME:AddMessage(TITAN_AGGRO_NAME..": Reports OFF");
	else
		TitanAggroSetVar("DoReports", 1);
		DEFAULT_CHAT_FRAME:AddMessage(TITAN_AGGRO_NAME..": Reports ON");
	end
end
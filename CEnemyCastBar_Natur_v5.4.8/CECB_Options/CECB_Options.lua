-- Natur EnemyCastBar Options LUA


necbmenuesizex = 500;
necbmshrinksizex = 260;
necbmenuesizey = 555;
necbmshrinksizey = 140;

CECBOptionsFrame:SetHeight(necbmenuesizey); -- set optionframe size, not needed atm
CECBOptionsFrame:SetWidth(necbmenuesizex);

CEnemyCastBar_SetBarColors("SetColors");

-- set frames to be hidden if addon disabled
NECBOptionFrameNames = { CECBOptionsFrameCECB_pvp_check, CECBOptionsFrameCECB_globalpvp_check, CECBOptionsFrameCECB_gainsonly_check,
	CECBOptionsFrameCECB_cdown_check, CECBOptionsFrameCECB_cdownshort_check, CECBOptionsFrameCECB_usecddb_check, CECBOptionsFrameCECB_spellbreak_check,
	CECBOptionsFrameCECB_gains_check, CECBOptionsFrameCECB_pve_check, CECBOptionsFrameCECB_pvew_check, CECBOptionsFrameCECB_afflict_check,
	CECBOptionsFrameCECB_globalfrag_check, CECBOptionsFrameCECB_magecold_check, CECBOptionsFrameCECB_solod_check,
	CECBOptionsFrameCECB_drtimer_check, CECBOptionsFrameCECB_classdr_check, CECBOptionsFrameCECB_sdots_check,
	CECBOptionsFrameCECB_affuni_check,
	CECBOptionsFrameCECB_timer_check, CECBOptionsFrameCECB_targetM_check, CECBOptionsFrameCECB_parseC_check,
	CECBOptionsFrameCECB_broadcast_check, CECBOptionsFrameBGFrameNet,
	CECBOptionsFrameCECB_flipb_check, CECBOptionsFrameCECB_tsize_check, CECBOptionsFrameCECB_flashit_check,
	CECBOptionsFrameCECB_showicon_check,
	CECBOptionsFrameCECB_scale_Slider, CECBOptionsFrameCECB_alpha_Slider, CECBOptionsFrameCECB_numbars_Slider,
	CECBOptionsFrameCECB_space_Slider, CECBOptionsFrameCECB_MiniMap_Slider, CECBOptionsFrameCECB_blength_Slider,
	CECBOptionsFrameCECB_Throttle_Slider, CECBOptionsFrameBGLine1, CECBOptionsFrameBGLine2,
	CECBOptionsFrameBGFrame2, CECBOptionsFrameBGFrame3, CECBOptionsFrameEPTimer, CECBOptionsFrameEPTimerReset,
	CECBOptionsFrameMoveBar, CECBOptionsFrameColors, CECBOptionsFrameBGFrameFPSBar, CECBOptionsFrameBGFrameFPSBar_check };


-- Options Handler -----------------------
function CEnemyCastBar_Options(msg) --Options

	if (msg == "enable") then

		CEnemyCastBar.bStatus = true;
		CEnemyCastBar_RegisterEvents();
		DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r AddOn |cff99ff99enabled|cffffffff. (Events |cff99ff99registered|cffffffff.)")
		
	elseif (msg == "disable") then

		CEnemyCastBar_Handler("clear");
		CEnemyCastBar.bStatus = false;
		CEnemyCastBar_RegisterEvents("unregister");
		DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r AddOn |cffff9999disabled|cffffffff. (Events |cffff9999unregistered|cffffffff.)")
		
	elseif (msg == "lock") then

		CEnemyCastBar_LockPos()

	elseif (msg == "show") then

		CEnemyCastBar_Handler("clear");

			if (CEnemyCastBar.bLocked) then

				CEnemyCastBar_LockPos();

			end

		CEnemyCastBar_Show("(unlocked)", "Move this bar!", 15.0, "friendly", nil, "Spell_Holy_Renew");

		lockshow = 1;
		
	elseif (msg == "reset") then

		-- reset can only be applied through the options frame, so it has been loaded ;-)
		CEnemyCastBar_Handler("clear");
		local lockcheck = CEnemyCastBar.bLocked; -- check if there is a difference after restoring (because of unlocking through "show")
		CEnemyCastBar_DefaultVars(); CECB_FPSBarFree:Hide(); 
		CEnemyCastBar_ResetPos();
		CEnemyCastBar_SetTextSize();
		CECBOptionsFrameCECB_scale_Slider:SetValue(CEnemyCastBar.bScale); -- set sliders to default
		CECBOptionsFrameCECB_alpha_Slider:SetValue(CEnemyCastBar.bAlpha);

			if (not lockcheck == CEnemyCastBar.bLocked) then
				CEnemyCastBar.bLocked = lockcheck;
				CEnemyCastBar_LockPos();
			end

		CECBPickColorOptions:Hide(); CECBOptionsFrame:SetAlpha(1);
		CEnemyCastBar_SetBarColors();
		CEnemyCastBar_SetBarColors("SetColors");

		CECB_ReloadOptionsUI();
		CECB_FPSBarFree:SetPoint("TOPLEFT", "UIParent", 50, -550);
		DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r AddOn is now |cff99ff99restored")
		
	elseif (msg == "pvp") then

		if (CEnemyCastBar.bPvP) then
	
			CEnemyCastBar.bPvP = false;
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r CastBars for PvP spells |cffff9999completely disabled")
	
		else
		
			CEnemyCastBar.bPvP = true;
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r CastBars for PvP spells |cff99ff99enabled")
		end

		CECB_ReloadOptionsUI();

	elseif (msg == "gains") then

		if (CEnemyCastBar.bGains) then
	
			CEnemyCastBar.bGains = false;
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Show 'gains' (and their cooldown) |cffff9999disabled")
		
		else
		
			CEnemyCastBar.bGains = true;
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Show 'gain type spells' |cff99ff99enabled")

		end

		CECB_ReloadOptionsUI();

	elseif (msg == "globalpvp") then

		if (CEnemyCastBar.bGlobalPvP) then
	
			CEnemyCastBar.bGlobalPvP = false;
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Show all PvP spells in range even w/o a target |cffff9999disabled")
		
		else
		
			CEnemyCastBar.bGlobalPvP = true;
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Show all PvP spells in range even w/o a target |cff99ff99enabled")

		end

		CECB_ReloadOptionsUI();

	elseif (msg == "gainsonly") then

		if (CEnemyCastBar.bGainsOnly) then
	
			CEnemyCastBar.bGainsOnly = false;
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Only 'gains' will be displayed |cffff9999disabled")
		
		else
		
			CEnemyCastBar.bGainsOnly = true;
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Only 'gains' will be displayed |cff99ff99enabled")
		end

		CECB_ReloadOptionsUI();

	elseif (msg == "cdown") then

		if (CEnemyCastBar.bCDown) then

			NECB_CD_DB = { };
			CECBOptionsFrameCECB_usecddb_checkText:SetText(CECB_usecddb_txt);
			CEnemyCastBar.bCDown = false;
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Show some CoolDowns |cffff9999disabled")
		
		else
		
			CEnemyCastBar.bCDown = true;
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Show some CoolDowns |cff99ff99enabled")
		end

		CECB_ReloadOptionsUI();

	elseif (msg == "cdownshort") then

		if (CEnemyCastBar.bCDownShort) then
	
			CEnemyCastBar.bCDownShort = false;
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Only show short cooldowns |cffff9999disabled")
		
		else
		
			CEnemyCastBar.bCDownShort = true;
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Only show short cooldowns |cff99ff99enabled")

		end

	elseif (msg == "usecddb") then

		if (CEnemyCastBar.bUseCDDB) then

			NECB_CD_DB = { };
			CECBOptionsFrameCECB_usecddb_checkText:SetText(CECB_usecddb_txt);
			CEnemyCastBar.bUseCDDB = false;
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Dynamic CoolDowns |cffff9999disabled")
		
		else

			CEnemyCastBar.bUseCDDB = true;
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Dynamic CoolDowns |cff99ff99enabled")

		end

	elseif (msg == "spellbreak") then

		if (CEnemyCastBar.bSpellBreakLight) then
	
			CEnemyCastBar.bSpellBreakLight = false;
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Don't detect Spell Interruptions in raids |cffff9999disabled")
		
		else
		
			CEnemyCastBar.bSpellBreakLight = true;
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Don't detect Spell Interruptions in raids |cff99ff99enabled")

		end

	elseif (msg == "pve") then

		if (CEnemyCastBar.bPvE) then
	
			CEnemyCastBar.bPvE = false;
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r CastBars for PvE spells |cffff9999disabled")
		
		else
		
			CEnemyCastBar.bPvE = true;
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r CastBars for PvE spells |cff99ff99enabled")
		end

		CECB_ReloadOptionsUI();

	elseif (msg == "pveraidw") then

		if (CEnemyCastBar.bPvEWarn) then
	
			CEnemyCastBar.bPvEWarn = false;
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r RaidWarnings for flashing PvE/Raid spells |cffff9999disabled")
		
		else
		
			CEnemyCastBar.bPvEWarn = true;
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r RaidWarnings for flashing PvE/Raid spells |cff99ff99enabled")
		
		end

	elseif (msg == "afflict") then

		if (CEnemyCastBar.bShowafflict) then
	
			CEnemyCastBar.bShowafflict = false;
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Show Debuffs |cffff9999completely disabled")

		else
		
			CEnemyCastBar.bShowafflict = true;
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Show Debuffs |cff99ff99enabled")
		end

		CECB_ReloadOptionsUI();

	elseif (msg == "globalfrag") then

		if (CEnemyCastBar.bGlobalFrag) then
	
			CEnemyCastBar.bGlobalFrag = false;
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Show 'Mob Outs' even w/o target |cffff9999disabled")
		
		else
		
			CEnemyCastBar.bGlobalFrag = true;
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Show 'Mob Outs' even w/o target |cff99ff99enabled")

		end

	elseif (msg == "solod") then

		if (CEnemyCastBar.bSoloD) then
	
			CEnemyCastBar.bSoloD = false;
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Show 'Solo Debuffs' (e.g. most stuns) |cffff9999disabled")
		
		else
		
			CEnemyCastBar.bSoloD = true;
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Show 'Solo Debuffs' (e.g. most stuns) |cff99ff99enabled")
		end

		CECB_ReloadOptionsUI();

	elseif (msg == "magecold") then

		if (CEnemyCastBar.bMageC) then
	
			CEnemyCastBar.bMageC = false;
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Show 'Mages Cold Effects' (DeBuffs) |cffff9999disabled")
		
		else
		
			CEnemyCastBar.bMageC = true;
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Show 'Mages Cold Effects' (DeBuffs) |cff99ff99enabled")

		end

	elseif (msg == "drtimer") then

		if (CEnemyCastBar.bDRTimer) then
	
			CEnemyCastBar.bDRTimer = false;
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Consider 'Diminishing Return' for biggest stun-family |cffff9999disabled")
		
		else
		
			CEnemyCastBar.bDRTimer = true;
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Consider 'Diminishing Return' for biggest stun-family |cff99ff99enabled")

		end

	elseif (msg == "classdr") then

		if (CEnemyCastBar.bClassDR) then
	
			CEnemyCastBar.bClassDR = false;
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Consider Class specific 'Diminishing Return' |cffff9999disabled")
		
		else
		
			CEnemyCastBar.bClassDR = true;
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Consider Class specific 'Diminishing Return' |cff99ff99enabled")

		end

	elseif (msg == "sdots") then

		if (CEnemyCastBar.bSDoTs) then
	
			CEnemyCastBar.bSDoTs = false;
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r CastBars to watch your DoT duration |cffff9999disabled")
		
		else
		
			CEnemyCastBar.bSDoTs = true;
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r CastBars to watch your DoT duration |cff99ff99enabled")

		end

	elseif (msg == "affuni") then

		if (CEnemyCastBar.bAfflictuni) then
	
			CEnemyCastBar.bAfflictuni = false;
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Only show RaidDebuffs |cffff9999disabled")
		
		else

			CEnemyCastBar.bAfflictuni = true;
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Only show RaidDebuffs |cff99ff99enabled")
		end

		CECB_ReloadOptionsUI();

	elseif (msg == "parsec") then

		if (CEnemyCastBar.bParseC) then
	
			CEnemyCastBar.bParseC = false;
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Parse Raid/Party/AddonChannel for commands |cffff9999disabled")
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|cffff3333 This is needed to benefit from RaidSpell synchronisation!")
		
		else
		
			CEnemyCastBar.bParseC = true;
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Parse Raid/Party/AddonChannel for commands |cff99ff99enabled")
		end

		CECB_ReloadOptionsUI();

	elseif (msg == "broadcast") then

		if (CEnemyCastBar.bBCaster) then
	
			CEnemyCastBar.bBCaster = false;
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Broadcast Spells through AddOn channel |cffff9999disabled")
		
		else
		
			CEnemyCastBar.bBCaster = true;
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Broadcast Spells through AddOn channel |cff99ff99enabled")
		
		end

	elseif (msg == "fpsbar") then

		if (CEnemyCastBar.bTempFPSBar) then
	
			CEnemyCastBar.bTempFPSBar = false;
			CECB_FPSBarFree:Hide();
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Standalone FPS-Bar |cffff9999disabled")
		
		else
		
			CEnemyCastBar.bTempFPSBar = true;
			CECB_FPSBarFree:Show();
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Standalone FPS-Bar |cff99ff99enabled")

		end

	elseif (msg == "timer") then

		if (CEnemyCastBar.bTimer) then

			for i=1, 20 do
		
				getglobal("Carni_ECB_"..i.."_CastTimeText"):SetText( );
				
			end

			CEnemyCastBar.bTimer = false;
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r CastBar time display |cffff9999disabled")
		
		else
		
			CEnemyCastBar.bTimer = true;
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r CastBar time display |cff99ff99enabled")
		
		end

	elseif (msg == "targetm") then

		if (CEnemyCastBar.bTargetM) then
	
			CEnemyCastBar.bTargetM = false;
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Target on BarLeftClick |cffff9999disabled")
		
		else
		
			CEnemyCastBar.bTargetM = true;
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Target on BarLeftClick |cff99ff99enabled")
		
		end

	elseif (msg == "tsize") then

		if (CEnemyCastBar.bSmallTSize) then
	
			CEnemyCastBar.bSmallTSize = false;
			CEnemyCastBar_SetTextSize();
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Small textsize of CastBars |cffff9999disabled")
		
		else
		
			CEnemyCastBar.bSmallTSize = true;
			CEnemyCastBar_SetTextSize();
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Small textsize of CastBars |cff99ff99enabled")

		end

	elseif (msg == "flipb") then

		if (CEnemyCastBar.bFlipB) then
	
			CEnemyCastBar.bFlipB = false;
			CEnemyCastBar_FlipBars();
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Bars now appear from first bar upwards. 'FlipOver' |cffff9999disabled")
		
		else
		
			CEnemyCastBar.bFlipB = true;
			CEnemyCastBar_FlipBars();
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Bars now appear from first bar downwards. 'FlipOver' |cff99ff99enabled")

		end

	elseif (msg == "flashit") then

		if (CEnemyCastBar.bFlashit) then
	
			CEnemyCastBar.bFlashit = false;
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r 'Flash' CastBars at their end |cffff9999disabled")
		
		else
		
			CEnemyCastBar.bFlashit = true;
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r 'Flash' CastBars at their end |cff99ff99enabled")

		end

	elseif (msg == "showicon") then

		if (CEnemyCastBar.bShowIcon) then
	
			CEnemyCastBar.bShowIcon = false;
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Display a Spell Icon next to the CastBar |cffff9999disabled")
		
		else
		
			CEnemyCastBar.bShowIcon = true;
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Display a Spell Icon next to the CastBar |cff99ff99enabled")

		end

	end
end

-- Show/hide Options
function CECB_ShowHideOptionsUI()
	if (CECBOptionsFrame:IsVisible()) then
		CECBOptionsFrame:Hide();
	else
		CECBOptionsFrame:Show();

		if (CEnemyCastBar.bPvP) then
			--cdown also triggers 'gains', 'globalpvp', 'spellbreak'
			CECB_Checkbox_toggle("cdown", "enable");
			if (CEnemyCastBar.bCDown) then
				CECB_Checkbox_toggle("cdownshort", "enable");
			else
				CECB_Checkbox_toggle("cdownshort", "disable");
			end

			if (CEnemyCastBar.bGains) then
				CECB_Checkbox_toggle("gainsonly", "enable");
			else
				CECB_Checkbox_toggle("gainsonly", "disable");
			end
		else
			CECB_Checkbox_toggle("cdown", "disable");
			CECB_Checkbox_toggle("cdownshort", "disable");
			CECB_Checkbox_toggle("gainsonly", "disable");
		end

		if (CEnemyCastBar.bShowafflict) then
			-- + 'solo debuffs' + all DR Checkboxes under 'globalfrag'
			CECB_Checkbox_toggle("affuni", "enable");
			if (CEnemyCastBar.bAfflictuni) then
				CECB_Checkbox_toggle("globalfrag", "disable");
			else
				CECB_Checkbox_toggle("globalfrag", "enable");
			end
		else
			CECB_Checkbox_toggle("affuni", "disable");
			CECB_Checkbox_toggle("globalfrag", "disable");
		end

		if (CEnemyCastBar.bPvE) then
			CECB_Checkbox_toggle("pveraidw", "enable");
		else
			CECB_Checkbox_toggle("pveraidw", "disable");			
		end

		if (CEnemyCastBar.bParseC) then
			CECB_Checkbox_toggle("broadcast", "enable");
		else
			CECB_Checkbox_toggle("broadcast", "disable");			
		end

	end
end

function CECB_ReloadOptionsUI()
	CECB_ShowHideOptionsUI();
	CECB_ShowHideOptionsUI();
end

function CECB_Checkbox_toggle(which, todo) --toggle

	if (which == "status") then
	
		if (todo == "enable") then
			CECBOptionsFrameCECB_status_check:Enable();
			CECBOptionsFrameCECB_status_checkText:SetText(CECB_status_txt);

		elseif (CECBOptionsFrameCECB_status_check:IsEnabled() ) then
			CECBOptionsFrameCECB_status_check:Disable();
			CECBOptionsFrameCECB_status_checkText:SetText("|cffaaaaaa"..CECB_status_txt);
		end

	elseif (which == "cdown") then
	
		if (todo == "enable") then
			CECBOptionsFrameCECB_cdown_check:Enable();
			CECBOptionsFrameCECB_cdown_checkText:SetText(CECB_cdown_txt);
			CECBOptionsFrameCECB_globalpvp_check:Enable();
			CECBOptionsFrameCECB_globalpvp_checkText:SetText(CECB_globalpvp_txt);
			CECBOptionsFrameCECB_gains_check:Enable();
			CECBOptionsFrameCECB_gains_checkText:SetText(CECB_gains_txt);
			CECBOptionsFrameCECB_spellbreak_check:Enable();
			CECBOptionsFrameCECB_spellbreak_checkText:SetText(CECB_spellbreak_txt);
		else
			CECBOptionsFrameCECB_cdown_check:Disable();
			CECBOptionsFrameCECB_cdown_checkText:SetText("|cffaaaaaa"..CECB_cdown_txt);
			CECBOptionsFrameCECB_globalpvp_check:Disable();
			CECBOptionsFrameCECB_globalpvp_checkText:SetText("|cffaaaaaa"..CECB_globalpvp_txt);
			CECBOptionsFrameCECB_gains_check:Disable();
			CECBOptionsFrameCECB_gains_checkText:SetText("|cffaaaaaa"..CECB_gains_txt);
			CECBOptionsFrameCECB_spellbreak_check:Disable();
			CECBOptionsFrameCECB_spellbreak_checkText:SetText("|cffaaaaaa"..CECB_spellbreak_txt);
		end

	elseif (which == "gainsonly") then
	
		if (todo == "enable") then
			CECBOptionsFrameCECB_gainsonly_check:Enable();
			CECBOptionsFrameCECB_gainsonly_checkText:SetText(CECB_gainsonly_txt);
		else
			CECBOptionsFrameCECB_gainsonly_check:Disable();
			CECBOptionsFrameCECB_gainsonly_checkText:SetText("|cffaaaaaa"..CECB_gainsonly_txt);
		end

	elseif (which == "cdownshort") then
	
		if (todo == "enable") then
			CECBOptionsFrameCECB_cdownshort_check:Enable();
			CECBOptionsFrameCECB_cdownshort_checkText:SetText(CECB_cdownshort_txt);
			CECBOptionsFrameCECB_usecddb_check:Enable();
			if (not CEnemyCastBar.bUseCDDB) then -- will be set through menue updater otherwise!
				CECBOptionsFrameCECB_usecddb_checkText:SetText(CECB_usecddb_txt);
			end
		else
			CECBOptionsFrameCECB_cdownshort_check:Disable();
			CECBOptionsFrameCECB_cdownshort_checkText:SetText("|cffaaaaaa"..CECB_cdownshort_txt);
			CECBOptionsFrameCECB_usecddb_check:Disable();
			CECBOptionsFrameCECB_usecddb_checkText:SetText("|cffaaaaaa"..CECB_usecddb_txt);
		end

	elseif (which == "affuni") then
	
		if (todo == "enable") then
			CECBOptionsFrameCECB_affuni_check:Enable();
			CECBOptionsFrameCECB_affuni_checkText:SetText(CECB_affuni_txt);

		else
			CECBOptionsFrameCECB_affuni_check:Disable();
			CECBOptionsFrameCECB_affuni_checkText:SetText("|cffaaaaaa"..CECB_affuni_txt);

		end

	-- plus 'solo debuffs', plus 'mages cold effects'
	elseif (which == "globalfrag") then
	
		if (todo == "enable") then
			CECBOptionsFrameCECB_magecold_check:Enable();
			CECBOptionsFrameCECB_magecold_checkText:SetText(CECB_magecold_txt);
			CECBOptionsFrameCECB_solod_check:Enable();
			CECBOptionsFrameCECB_solod_checkText:SetText(CECB_solod_txt);
			CECBOptionsFrameCECB_globalfrag_check:Enable();
			CECBOptionsFrameCECB_globalfrag_checkText:SetText(CECB_globalfrag_txt);
			CECBOptionsFrameCECB_drtimer_check:Enable();
			CECBOptionsFrameCECB_drtimer_checkText:SetText(CECB_drtimer_txt);
			CECBOptionsFrameCECB_classdr_check:Enable();
			CECBOptionsFrameCECB_classdr_checkText:SetText(CECB_classdr_txt);
			CECBOptionsFrameCECB_sdots_check:Enable();
			CECBOptionsFrameCECB_sdots_checkText:SetText(CECB_sdots_txt);
		else
			CECBOptionsFrameCECB_magecold_check:Disable();
			CECBOptionsFrameCECB_magecold_checkText:SetText("|cffaaaaaa"..CECB_magecold_txt);
			CECBOptionsFrameCECB_solod_check:Disable();
			CECBOptionsFrameCECB_solod_checkText:SetText("|cffaaaaaa"..CECB_solod_txt);
			CECBOptionsFrameCECB_globalfrag_check:Disable();
			CECBOptionsFrameCECB_globalfrag_checkText:SetText("|cffaaaaaa"..CECB_globalfrag_txt);
			CECBOptionsFrameCECB_drtimer_check:Disable();
			CECBOptionsFrameCECB_drtimer_checkText:SetText("|cffaaaaaa"..CECB_drtimer_txt);
			CECBOptionsFrameCECB_classdr_check:Disable();
			CECBOptionsFrameCECB_classdr_checkText:SetText("|cffaaaaaa"..CECB_classdr_txt);
			CECBOptionsFrameCECB_sdots_check:Disable();
			CECBOptionsFrameCECB_sdots_checkText:SetText("|cffaaaaaa"..CECB_sdots_txt);
		end

	elseif (which == "pveraidw") then
	
		if (todo == "enable") then
			CECBOptionsFrameCECB_pvew_check:Enable();
			CECBOptionsFrameCECB_pvew_checkText:SetText(CECB_pvew_txt);
		else
			CECBOptionsFrameCECB_pvew_check:Disable();
			CECBOptionsFrameCECB_pvew_checkText:SetText("|cffaaaaaa"..CECB_pvew_txt);
		end

	elseif (which == "broadcast") then
	
		if (todo == "enable") then
			CECBOptionsFrameCECB_broadcast_check:Enable();
			CECBOptionsFrameCECB_broadcast_checkText:SetText(CECB_broadcast_txt);
		else
			CECBOptionsFrameCECB_broadcast_check:Disable();
			CECBOptionsFrameCECB_broadcast_checkText:SetText("|cffaaaaaa"..CECB_broadcast_txt);
		end
	end
end

-- Show/hide ApplyReset
function CECB_ApplyResetFrame()
	if (CECBApplyResetFrame:IsVisible()) then
		CECBApplyResetFrame:Hide();

	else
		CECBApplyResetFrame:Show();
	end
end

function CECB_Options_Sub(todo, value) --options sub

	local i = 1;
	while (NECBOptionFrameNames[i]) do

		if (todo == "alpha") then NECBOptionFrameNames[i]:SetAlpha(value);
		elseif (todo == "hide") then NECBOptionFrameNames[i]:Hide();
		elseif (todo == "show") then NECBOptionFrameNames[i]:Show();
		end

		i = i + 1;
	end
end

function CEnemyCastBar_Options_OnUpdate() --Menue on update

	local BarupTime = GetTime();
	if (not CECBOptionsFrame.updated or BarupTime - CECBOptionsFrame.updated > CEnemyCastBar.bThrottle) then
		CECBOptionsFrame.updated = BarupTime;

		if (not cecbmaxsize and CECBOptionsFrame:GetHeight() > (necbmenuesizey - 1)) then
			bgalpha = 1; CECB_Options_Sub("show");
			cecbmaxsize = true; cecbminsize = false;
			CECB_Checkbox_toggle("status", "enable");
		elseif (not cecbminsize and CECBOptionsFrame:GetHeight() < (necbmshrinksizey + 1)) then
			bgalpha = 0; CECB_Options_Sub("hide");
			cecbminsize = true; cecbmaxsize = false;
			CECB_Checkbox_toggle("status", "enable");
		end

		local framerate = GetFramerate();
		local stepping = 2/framerate;
		if (stepping > 0.4 ) then stepping = 0.4; -- security for very low fps (< 5fps)
		elseif (stepping < CEnemyCastBar.bThrottle*2 ) then stepping = CEnemyCastBar.bThrottle*2; -- if fps is higher than barupdate
		end
	
		-- add fps-meter
		local g = framerate/30;
		local r = 30/framerate;
	
		if (g > 1) then g = 1;	end
		if (r > 1) then r = 1;	end
	
		if (framerate > 100) then frameratesafe = 100;
		else frameratesafe = framerate;
		end
	
		CECBOptionsFrameBGFrameFPSBar_StatusBar:SetMinMaxValues(1,100);
		CECBOptionsFrameBGFrameFPSBar_StatusBar:SetValue(frameratesafe);
		CECBOptionsFrameBGFrameFPSBar_StatusBar_Spark:SetPoint("CENTER", "CECBOptionsFrameBGFrameFPSBar_StatusBar", "LEFT", frameratesafe*1.95, 0);
		CECBOptionsFrameBGFrameFPSBar_Text:SetText("|cffffffaaFPS: |cffffcc00"..ceil(framerate));
		CECBOptionsFrameBGFrameFPSBar_StatusBar:SetStatusBarColor(r,g,0);
		-- fps-meter finished
	
		-- EPTimer
		local eptimertext = "EngageProtection: ";
		if (necbengagecd and necbEPTime - floor(GetTime() - necbengagecd) > 0) then
			eptimertext = eptimertext .. "|cffff9999active! |r(|cffffffff" .. necbEPTime - floor(GetTime() - necbengagecd) .. "|r)";
		else
			eptimertext = eptimertext .. "|cff99ff99disabled";
		end
	
		CECBOptionsFrameEPTimerText:SetText(eptimertext);
		if (CEnemyCastBar.bUseCDDB and CEnemyCastBar.bCDown) then
			CECBOptionsFrameCECB_usecddb_checkText:SetText(CECB_usecddb_txt.." |cffaaaaaa"..table.getn(NECB_CD_DB).."/50");
		end
	
	-- now we start
		if (necbfademenue == 1) then
			local malpha = CECBOptionsFrame:GetAlpha() - stepping*2;
			if (malpha > 0) then
				CECBOptionsFrame:SetAlpha(malpha);
			else
				CECBOptionsFrame:Hide();
				necbfademenue = false;
			end
	
		elseif (necbfademenue == 2) then
			local malpha = CECBOptionsFrame:GetAlpha() + stepping*2;
			if (malpha < 1) then
				CECBOptionsFrame:SetAlpha(malpha);
			else
				CECBOptionsFrame:SetAlpha(1);
				necbfademenue = false;
			end
		end
	
		if (not CEnemyCastBar.bStatus) then
	
			if (not cecbminsize) then
	
				local optionsheight = CECBOptionsFrame:GetHeight();
				local optionswidth = CECBOptionsFrame:GetWidth();
				if ((optionsheight - stepping*200) > (necbmshrinksizey +1)) then
					CECB_Checkbox_toggle("status", "disable");
					optionsheight = optionsheight - stepping*200;
					CECBOptionsFrame:SetHeight(optionsheight);
					
					if ((optionswidth - stepping*200) > (necbmshrinksizex +1)) then
						optionswidth = optionswidth - stepping*200;
						CECBOptionsFrame:SetWidth(optionswidth);
					else
						CECBOptionsFrame:SetWidth(necbmshrinksizex);
					end
		
					if ((bgalpha - stepping) >= 0) then bgalpha = bgalpha - stepping;
						CECB_Options_Sub("alpha", bgalpha);
						CECBOptionsFrameBGFrame1:SetBackdropBorderColor(1 - bgalpha, 0, 0);
					else
						CECB_Options_Sub("alpha", 0);
					end
	
				else
					CECB_Options_Sub("hide");
					CECBOptionsFrame:SetHeight(necbmshrinksizey);
				end
			end
	
		elseif (not cecbmaxsize) then
	
			local optionsheight = CECBOptionsFrame:GetHeight();
			local optionswidth = CECBOptionsFrame:GetWidth();
			CECBOptionsFrameBGFrame1:SetBackdropBorderColor(0.4, 0.4, 0.4);
	
			CECB_Options_Sub("show");
	
			if ((optionsheight + stepping*200) < (necbmenuesizey -1)) then
				CECB_Checkbox_toggle("status", "disable");
				optionsheight = optionsheight + stepping*200;
				CECBOptionsFrame:SetHeight(optionsheight);
	
				if ((optionswidth + stepping*200) < (necbmenuesizex -1)) then
					optionswidth = optionswidth + stepping*200;
					CECBOptionsFrame:SetWidth(optionswidth);
				else
					CECBOptionsFrame:SetWidth(necbmenuesizex);
				end
	
				if ((bgalpha + stepping) <= 1) then bgalpha = bgalpha + stepping;
					CECB_Options_Sub("alpha", bgalpha);
				else
					CECB_Options_Sub("alpha", 1);
				end
			else
				CECBOptionsFrame:SetHeight(necbmenuesizey);
				CECB_Options_Sub("alpha", 1);
			end
		end
	end
end

function CECB_MiniMap_Slider_OnShow()
	getglobal(this:GetName().."High"):SetText("360\194\176");
	getglobal(this:GetName().."Low"):SetText(CECB_minimapoff_txt);

	if (CEnemyCastBar.bMiniMap == 0) then
		getglobal(this:GetName() .. "Text"):SetText(CECB_minimap_txt .."|cffffffff".. CECB_minimapoff_txt);
	else
		getglobal(this:GetName() .. "Text"):SetText(CECB_minimap_txt .."|cffffffff".. CEnemyCastBar.bMiniMap .."\194\176");
	end

	this:SetMinMaxValues(0, 360);
	this:SetValueStep(2);
	this:SetValue(CEnemyCastBar.bMiniMap);
end

function CECB_MiniMap_Slider_OnValueChanged()

	CEnemyCastBar.bMiniMap = this:GetValue();

	if (CEnemyCastBar.bMiniMap == 0) then
		CECBMiniMapButton:Hide();
		getglobal(this:GetName() .. "Text"):SetText(CECB_minimap_txt .."|cffffffff".. CECB_minimapoff_txt);
	else
		CECBMiniMapButton:SetPoint("TOPLEFT", "Minimap", "TOPLEFT", 52 - (80 * cos(this:GetValue())), (80 * sin(this:GetValue())) - 52);
		CECBMiniMapButton:Show();
		getglobal(this:GetName() .. "Text"):SetText(CECB_minimap_txt .."|cffffffff".. CEnemyCastBar.bMiniMap .."\194\176");
	end
end

function CECB_scale_Slider_OnShow()
	getglobal(this:GetName().."High"):SetText("130%");
	getglobal(this:GetName().."Low"):SetText("30%");

	getglobal(this:GetName() .. "Text"):SetText(CECB_scale_txt .."|cffffffff".. CEnemyCastBar.bScale * 100 .. "%");

	this:SetMinMaxValues(0.3, 1.3);
	this:SetValueStep(0.1);
	this:SetValue(CEnemyCastBar.bScale);
end

function CECB_scale_Slider_OnValueChanged()

	local delta = abs(CEnemyCastBar.bScale - this:GetValue()) * 100;
	local BarScaleOld = CEnemyCastBar.bScale;
	-- DEFAULT_CHAT_FRAME:AddMessage("old: " .. CEnemyCastBar.bScale .. " | new: " .. this:GetValue() .." | delta "..delta)

	CEnemyCastBar.bScale = this:GetValue() * 10;

	if (CEnemyCastBar.bScale < 0) then
		CEnemyCastBar.bScale = ceil(CEnemyCastBar.bScale - 0.5)
	else
		CEnemyCastBar.bScale = floor(CEnemyCastBar.bScale + 0.5)
	end

	CEnemyCastBar.bScale = CEnemyCastBar.bScale / 10;

	getglobal(this:GetName() .. "Text"):SetText(CECB_scale_txt .."|cffffffff".. CEnemyCastBar.bScale * 100 .. "%");

	if (delta >= 1) then

		CEnemyCastBar_Handler("clear");
	
		local BarScaleFactor = BarScaleOld / CEnemyCastBar.bScale;

		local frame = getglobal("Carni_ECB_1");
		local p, rf, rp, x, y = frame:GetPoint();
		
		--DEFAULT_CHAT_FRAME:AddMessage("p="..p..", rp="..rp..", x="..x..", y="..y);
		x = (x + 102.5 - 102.5 * 1/BarScaleFactor)* BarScaleFactor;
		y = (y - 10 + 10 * 1/BarScaleFactor) * BarScaleFactor;
		frame:SetPoint("TOPLEFT", "UIParent", x, y);
	
		CEnemyCastBar_Show("Info", "New CastBarStyle!", 10.0, "friendly", nil, "Spell_Holy_Renew");

	end

end


function CECB_alpha_Slider_OnShow()
	getglobal(this:GetName().."High"):SetText("1");
	getglobal(this:GetName().."Low"):SetText("0.1");

	getglobal(this:GetName() .. "Text"):SetText(CECB_alpha_txt .."|cffffffff".. CEnemyCastBar.bAlpha);

	this:SetMinMaxValues(0.1, 1.0);
	this:SetValueStep(0.1);
	this:SetValue(CEnemyCastBar.bAlpha);
end

function CECB_alpha_Slider_OnValueChanged()

	local delta = abs(CEnemyCastBar.bAlpha - this:GetValue()) * 100;

	CEnemyCastBar.bAlpha = this:GetValue() * 10;
	if (CEnemyCastBar.bAlpha < 0) then
		CEnemyCastBar.bAlpha = ceil(CEnemyCastBar.bAlpha - 0.5)
	else
		CEnemyCastBar.bAlpha = floor(CEnemyCastBar.bAlpha + 0.5)
	end
	CEnemyCastBar.bAlpha = CEnemyCastBar.bAlpha / 10;

	getglobal(this:GetName() .. "Text"):SetText(CECB_alpha_txt .."|cffffffff".. CEnemyCastBar.bAlpha);

	CECB_PrintBar_OnMove(delta);

end

function CECB_numbars_Slider_OnShow()
	getglobal(this:GetName().."High"):SetText("20");
	getglobal(this:GetName().."Low"):SetText("5");

	getglobal(this:GetName() .. "Text"):SetText(CECB_numbars_txt .."|cffffffff".. CEnemyCastBar.bNumBars);

	this:SetMinMaxValues(5, 20);
	this:SetValueStep(1);
	this:SetValue(CEnemyCastBar.bNumBars);
end

function CECB_numbars_Slider_OnValueChanged()

	local delta = abs(CEnemyCastBar.bNumBars - this:GetValue()) * 10;
	--DEFAULT_CHAT_FRAME:AddMessage("old: " .. CEnemyCastBar.bNumBars .. " | new: " .. this:GetValue() .." | delta "..delta)

	if (delta >= 1) then

		CEnemyCastBar_Handler("clear");
	
		CEnemyCastBar.bNumBars = this:GetValue();
	
		getglobal(this:GetName() .. "Text"):SetText(CECB_numbars_txt .."|cffffffff".. CEnemyCastBar.bNumBars);
	
		for i=1, CEnemyCastBar.bNumBars do
			CEnemyCastBar_Show("Info", "CastBarNumbers", 5.0, "friendly", nil, "Spell_Holy_Renew");
		end

	end

end

function CECB_space_Slider_OnShow()
	getglobal(this:GetName().."High"):SetText("50");
	getglobal(this:GetName().."Low"):SetText("10");

	getglobal(this:GetName() .. "Text"):SetText(CECB_space_txt .."|cffffffff".. CEnemyCastBar.bSpace);

	this:SetMinMaxValues(10, 50);
	this:SetValueStep(1);
	this:SetValue(CEnemyCastBar.bSpace);
end

function CECB_space_Slider_OnValueChanged()

	local delta = abs(CEnemyCastBar.bSpace - this:GetValue()) * 10;

	if (delta >= 1) then

		CEnemyCastBar_Handler("clear");
	
		CEnemyCastBar.bSpace = this:GetValue();
	
		getglobal(this:GetName() .. "Text"):SetText(CECB_space_txt .."|cffffffff".. CEnemyCastBar.bSpace);
	
		CEnemyCastBar_FlipBars(); -- sets the space, too!
		for i=1, CEnemyCastBar.bNumBars do
			CEnemyCastBar_Show("Info", "Space between CastBars!", 5.0, "friendly", nil, "Spell_Holy_Renew");
		end

	end

end

function CECB_blength_Slider_OnShow()
	getglobal(this:GetName().."High"):SetText("+150");
	getglobal(this:GetName().."Low"):SetText("-50");

	if (CEnemyCastBar.bnecbCBLBias >= 0) then
		getglobal(this:GetName() .. "Text"):SetText(CECB_blength_txt .."|cffffffff+" .. CEnemyCastBar.bnecbCBLBias);
	else
		getglobal(this:GetName() .. "Text"):SetText(CECB_blength_txt .."|cffffffff".. CEnemyCastBar.bnecbCBLBias);
	end

	this:SetMinMaxValues(-50, 150);
	this:SetValueStep(10);
	this:SetValue(CEnemyCastBar.bnecbCBLBias);
end

function CECB_blength_Slider_OnValueChanged()

	local delta = abs(CEnemyCastBar.bnecbCBLBias - this:GetValue()) * 10;

	if (delta >= 1) then

		CEnemyCastBar_Handler("clear");
	
		CEnemyCastBar.bnecbCBLBias = this:GetValue();
	
		if (CEnemyCastBar.bnecbCBLBias >= 0) then
			getglobal(this:GetName() .. "Text"):SetText(CECB_blength_txt .."|cffffffff+" .. CEnemyCastBar.bnecbCBLBias);
		else
			getglobal(this:GetName() .. "Text"):SetText(CECB_blength_txt .."|cffffffff".. CEnemyCastBar.bnecbCBLBias);
		end
	
		CEnemyCastBar_FlipBars(); -- sets the space, too!

		CEnemyCastBar_Show("Info", "Width of CastBars!", 5.0, "friendly", nil, "Spell_Holy_Renew");


	end

end

function CECB_Throttle_Slider_OnShow()
	getglobal(this:GetName().."High"):SetText("max");
	getglobal(this:GetName().."Low"):SetText("5");

	local necbfpsup;
	if (CEnemyCastBar.bThrottle > 0) then
		necbfpsup = ceil(1/CEnemyCastBar.bThrottle);
	else
		necbfpsup = "max";
	end
	getglobal(this:GetName() .. "Text"):SetText(CECB_throttle_txt .."|cffffffff".. necbfpsup);

	this:SetMinMaxValues(0, 20);
	this:SetValueStep(5);
	this:SetValue(20 - CEnemyCastBar.bThrottle*100);
end

function CECB_Throttle_Slider_OnValueChanged()

	local delta = abs(20 - CEnemyCastBar.bThrottle*100 - this:GetValue()) * 10;
 
	if (delta >= 1) then

		CEnemyCastBar_Handler("clear");

		CEnemyCastBar.bThrottle = 0.2 - this:GetValue()/100;
	
		local necbfpsup;
		if (CEnemyCastBar.bThrottle > 0) then
			necbfpsup = ceil(1/CEnemyCastBar.bThrottle);
		else
			necbfpsup = "max";
		end
		getglobal(this:GetName() .. "Text"):SetText(CECB_throttle_txt .."|cffffffff".. necbfpsup);

		CEnemyCastBar_Show("Info", "Updating with "..necbfpsup.." fps", 5.0, "friendly", nil, "Spell_Holy_Renew");


	end

end

function CECB_PrintBar_OnMove(delta)

	if (delta >= 1) then

		CEnemyCastBar_Handler("clear");
	
		CEnemyCastBar_Show("Info", "New CastBarStyle!", 10.0, "friendly", nil, "Spell_Holy_Renew");


	end
end

--Color wheel functions
function CEnemyCastBar_ColorWheel()
	local button = this;
	local cecboldcolor1 = CEnemyCastBar.tColor[button:GetID()][1];
	local cecboldcolor2 = CEnemyCastBar.tColor[button:GetID()][2];
	local cecboldcolor3 = CEnemyCastBar.tColor[button:GetID()][3];
	ColorPickerFrame.func = function() CEnemyCastBar_SetBarColor(button) end;
	ColorPickerFrame:SetColorRGB(button[1], button[2], button[3]);
	ColorPickerFrame.cancelFunc = function() CEnemyCastBar_SetBarColor(button, cecboldcolor1, cecboldcolor2, cecboldcolor3) end;
	ColorPickerFrame:Show();
end

function CEnemyCastBar_SetBarColor(button, r, g, b)
	if (not r) then
		--Set Bar Color from color wheel
		local r,g,b = ColorPickerFrame:GetColorRGB();
		CEnemyCastBar_SetBarColorSub(button, r, g, b);
	else
		--Restore old colors, canceled
		CEnemyCastBar_SetBarColorSub(button, r, g, b)
	end
end

function CEnemyCastBar_SetBarColorSub(button, r, g, b)
	local CECBno = button:GetID();
	getglobal("CECBPickColorOptions_"..cecbcolors[CECBno].."NormalTexture"):SetVertexColor(r, g, b);

	CEnemyCastBar.tColor[CECBno][1] = r;
	CEnemyCastBar.tColor[CECBno][2] = g;
	CEnemyCastBar.tColor[CECBno][3] = b;

	for j=1, 3 do
		getglobal("CECBPickColorOptions_"..cecbcolors[CECBno])[j] = CEnemyCastBar.tColor[CECBno][j];
	end
end

function CEnemyCastBar_ShowHideColorOptions(msg)

	if ( CECBPickColorOptions:IsVisible() or msg == "hide") then

		if (msg ~= "hide") then
			CECBOptionsFrame:SetAlpha(1);
		end
		CECBPickColorOptions:Hide();
	else
		CECBOptionsFrame:SetAlpha(0.5);
		CECBPickColorOptions:Show();
	end
end
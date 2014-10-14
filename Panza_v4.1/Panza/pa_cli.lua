--[[

pa_cli.lua
Panza Command Line Processor
Revision 4.0

--]]

---------------------------
-- Handle the command line
---------------------------
function Panza_SlashHandler(msg)

	if (PA:AbortHealCheck()) then
		return false;
	end

	local unit = "target";

	msg = strlower(msg);

	local CTRLDown = (IsControlKeyDown()==1);
	local ALTDown = (IsAltKeyDown()==1);
	local IgnoreDistance = (CTRLDown and not ALTDown);
	local ManualRez = (CTRLDown and not ALTDown);
	local SaveForPlayer = (CTRLDown and not ALTDown and PASettings.Switches.EnableSave==true);
	local ForceSelf = (ALTDown and not CTRLDown and PASettings.Switches.EnableSelf==true);
	local ForceReset = (ALTDown and not CTRLDown);
	local ForceGroupHeals = (ALTDown and CTRLDown);
	local ForceGroupBuffs = (ALTDown and CTRLDown and PASettings.Switches.EnableGroup==true);

	-----------------------------------------------------------
	-- 1.21 Use settings to determine if we monitor the alt key
	-----------------------------------------------------------
	if (ForceSelf) then
		unit = "player";
	end

	if (msg == "") then
		PA:Message("Panza v"..PANZA_VERSION);
		PA:Message("/pa raidstatus		"..PANZA_HELP_RAIDSTATUS);
		PA:Message("/pa paw				"..PANZA_HELP_PAW);
		PA:Message("/pa annc			"..PANZA_HELP_ANNC);
		PA:Message("/pa pawresp			"..PANZA_HELP_PAWRESP);
		PA:Message("/pa quiet			"..PANZA_HELP_QUIET);
		PA:Message("/pa show			"..PANZA_HELP_SHOW);
		PA:Message("/pa enableself		"..PANZA_HELP_ENABLESELF);
		PA:Message("/pa enablesave		"..PANZA_HELP_ENABLESAVE);
		PA:Message("/pa nopvp			"..PANZA_HELP_NOPVP);
		PA:Message("/pa options		 	"..PANZA_HELP_OPTIONS);
		PA:Message("/pa listparty		"..PANZA_HELP_LISTPARTY);
		PA:Message("/pa listraid		"..PANZA_HELP_LISTRAID);
		PA:Message("/pa listall		 	"..PANZA_HELP_LISTALL);
		PA:Message("/pa showspells		"..PANZA_HELP_SHOWSPELLS);
		PA:Message("/pa cleartarget		"..PANZA_HELP_CLEARTARGET);
		PA:Message("/pa clearall		"..PANZA_HELP_CLEARALL);
		PA:Message("/pa reset	 		"..PANZA_HELP_RESET);
		PA:Message("/pa listmouse		"..PANZA_HELP_MOUSE);
		PA:Message("/pa guildmsg		"..PANZA_HELP_DESTGUILD);
		PA:Message("/pa raidmsg			"..PANZA_HELP_DESTRAID);
		PA:Message("/pa setseals seal1 seal2    "..PANZA_HELP_SETSEALS);
		PA:Message("/pa setpvpseals	seal1 seal2 "..PANZA_HELP_SETPVPSEALS);
		PA:Message("/script PA:ClearName(\"name\") 	"..PANZA_HELP_CLEARNAME);
		PA:Message(" ");
		if (PASettings.Switches.EnableSelf == true) then
			PA:Message(PANZA_HELP_ENABLESELF_TEXT);
		end
		if (PASettings.Switches.EnableSave == true) then
			PA:Message(PANZA_HELP_ENABLESAVE_TEXT1);
			PA:Message(PANZA_HELP_ENABLESAVE_TEXT2);
			PA:Message(" ");
		end

	elseif (msg == "show") then

		PA:Message(format(PANZA_CURRENTSETTINGS,PANZA_VERSION));

		----------------------------------------
		-- 2.0 Expiring Blessing Warning System
		----------------------------------------
		PA:Message(format(PANZA_BUFFEXPIREWARNINGS,PASettings.BuffExpire));

		if (PASettings.Switches.EnableWarn == true) then
			PA:Message(PANZA_WARNINGS);
		else
			PA:Message(PANZA_NOWARNINGS);
		end

		if (PASettings.Switches.EnableSelf == true) then
			PA:Message(PANZA_SELFBLESSING_ENABLED);
		else
			PA:Message(PANZA_SELFBLESSING_DISABLED);
		end

		if (PASettings.Switches.EnableSave == true) then
			PA:Message(PANZA_SAVEBLESSING_ENABLED);
		else
			PA:Message(PANZA_SAVEBLESSING_DISABLED);
		end

		if (PASettings.Switches.NoPVP.enabled==true) then
			PA:Message(PANZA_NO_PVP_ENABLED);
		else
			PA:Message(PANZA_NO_PVP_DISABLED);
		end

		PA:Message(format(PANZA_MINHEALTH_THRESHOLD,(PASettings.Heal.MinTH * 100).."%"));
		PA:Message(format(PANZA_FOL_HEALTH_THRESHOLD,(PASettings.Heal.Flash * 100).."%"));
		PA:Message(format(PANZA_FOL_MANA_THRESHOLD,(PASettings.Heal.FolTH * 100).."%"));

		if (PASettings.Switches.AutoList == true) then
			PA:Message(PANZA_AUTOLIST_ENABLED);
		else
			PA:Message(PANZA_AUTOLIST_DISABLED);
		end
		PA:Message(format(PANZA_SAVELIST, PA:TableSize(PASettings.BlessList)));


	elseif (msg == "bginfo") then
		-- 1.9 info
    	PA:Message("BG Info" );
		for i=1, MAX_BATTLEFIELD_QUEUES do

			local status, mapName, instanceID = GetBattlefieldStatus(i);

			if ( instanceID ~= 0 ) then
				mapName = mapName.." "..instanceID;
    		end
    		PA:Message(i.." status="..status.." Map="..mapName);
    	end

	---------------------------------
	-- Bring up the GUI
	---------------------------------
	elseif (msg == "options" or	msg == "config" ) then
		PanzaTreeFrame:Show();

	---------------------------------
	-- Bring up the general options
	---------------------------------
	elseif (msg == "general" ) then
		PanzaOptsFrame:Show();

	-------------------------------------
	-- Switch to PanzaComm's Guild Channel
	-------------------------------------
	elseif (msg == "guildmsg") then
		if (PASettings.Heal.Coop.Channel~="Guild") then
			if (PA:CheckMessageLevel("Core",1)) then
				PA:Message4("(Panza) Switching to PanzaComm \"Guild\" Msg Destination.");
			end
			PASettings.Heal.Coop.Channel="Guild"
			if (type(PanzaComm_Register)=="function") then
				PanzaComm_Register("Panza", Panza_CoopRcvr, 1, PASettings.Heal.Coop.Channel);
				if (not Broadcast_Register) then
					PanzaComm_Register("Genesis", Panza_CoopRcvr, 2, PASettings.Heal.Coop.Channel);
					PanzaComm_Register("Heart", Panza_CoopRcvr, 2, PASettings.Heal.Coop.Channel);
				end
				
			end
		else
			PA:Message("(Panza) Already on PanzaComm Guild Msg Destination.");
		end

	-------------------------------------
	-- Switch to PanzaComm's Auto Channel
	-------------------------------------
	elseif (msg == "raidmsg") then
		if (PASettings.Heal.Coop.Channel~="Raid") then
			if (PA:CheckMessageLevel("Core",1)) then
				PA:Message4("(Panza) Switching to PanzaComm \"Raid\" Msg Destination.");
			end
			PASettings.Heal.Coop.Channel="Raid"
			if (type(PanzaComm_Register)=="function") then
				PanzaComm_Register("Panza", Panza_CoopRcvr, 1, PASettings.Heal.Coop.Channel);
				if (not Broadcast_Register) then
					PanzaComm_Register("Genesis", Panza_CoopRcvr, 2, PASettings.Heal.Coop.Channel);
					PanzaComm_Register("Heart", Panza_CoopRcvr, 2, PASettings.Heal.Coop.Channel);
				end
			end
		else
			PA:Message("(Panza) Already on PanzaComm Raid Msg Destination.");
		end

	--------------------------------
	-- Set Seals
	--------------------------------
	elseif (string.sub(msg, 1, 9) == "setseals ") then
	
		local _, _, Seal1, Seal2 = string.find(msg, "^setseals (%a+)%s+(%a+)$")
		if (Seal1~=nil and Seal2~=nil) then
			PA:SetSeals(Seal1, Seal2, false);
		end

	elseif (string.sub(msg, 1, 12) == "setpvpseals ") then
	
		local _, _, Seal1, Seal2 = string.find(msg, "^setpvpseals (%a+)%s+(%a+)$")
		if (Seal1~=nil and Seal2~=nil) then
			PA:SetSeals(Seal1, Seal2, true);
		end

	--------------------------------
	-- AsCombo (Free Cure Bless)
	--------------------------------
	elseif (msg == "ascomb") then

		if (PASettings.Switches.BoSafOnPVP==true and UnitIsPVP("player") and PA:AutoBoSaf(false)) then
			return;
		end
		--if (PA:IsInWSG()) then
		--	PA:ShowText("We are in WSG");
		--end
		if (PA:AsCure(unit, false, ForceSelf)) then
			return;
		end
		if (PA:Free(unit)) then
			return;
		end
		PA:AsBless(unit, ForceReset, ForceSelf);

	------------------------------------------------------------------------------------------------------
	--- AutoSelect Modes
	--- AS Modes act in the followinbg way:
	--- If there is a target and you are not in a party and target is not a friend then
	---    Heal/Bless/Cure Yourself
	--- otherwise there is a target and you are not in a party and Its a Friend, and the pass Muster then
	--     Heal/Bless/Cure the Friend
	--  Otherwise if you are in a Party Heal/Bless/Cure the Party/Raid/Pets
	--  and Finally if there is no target, and you are not in a Party, Heal/Buff/Cure Yourself
	------------------------------------------------------------------------------------------------------

	--------------------------------
	------ Blessing Functions ------
	--------------------------------

	---------------------------
	-- Autoselect Blessing Mode
	---------------------------
	elseif (msg == "asbless" or msg == "asbuff") then

		PA:AsBless(unit, ForceReset, ForceSelf);

	------------------------------------------
	-- Regular Target Based Blessing using DCB
	------------------------------------------
	elseif (msg == "autobless") then
		PA:AutoBless(unit);

	--------------------------
	-- Priest PowerWord:Shield
	--------------------------
	elseif (msg == "pws") then
		PA:PriestPWS(unit);

	-----------------------------------------
	-- Individual Target Based Saved/Blessing
	------------------------------------------
	elseif (PA.SpellBook.Buffs[msg]~=nil and PA:GetSpellProperty(msg, "Duration")~=nil) then

		--PA:ShowText("Manual buff ", msg);

		if (msg=="bosaf") then
			if (unit~=nil and (UnitPlayerOrPetInRaid(unit) or UnitPlayerOrPetInParty(unit))) then
				PA:BlessByLevel(msg, unit, true, false);
			elseif (UnitIsPVP("player")) then
				PA:AutoBoSaf(true);
			end
		else

			local Target = PA:GetSpellProperty(msg, "Target");
			if (Target~=nil) then
			end


			---------------------------------------------
			-- Check if we are saving for an Named player
			---------------------------------------------
			if (ForceGroupBuffs==false and SaveForPlayer and PA:GetSpellProperty(msg, "Duration")>=300) then
				PA.Cycles.Buff.Saving = true;
			end

			------------------------------------------
			-- 2.0 Select self if conditions are right
			-------------------------------------------
			--PA:ShowText("unit=", unit, " UnitIsMyFriend=", PA:UnitIsMyFriend(unit));
			if ((unit and not PA:UnitIsMyFriend(unit)) or ForceSelf) then
				PA:BlessByLevel(msg, "player", true, false, ForceGroupBuffs);

			elseif (unit and PA:UnitIsMyFriend(unit)) then
				local TargetOK, Exists, Status = PA:CheckTarget(unit, false, PA.Spells.Default.Bless, PASettings.Switches.UseActionRange.Bless);
				if (TargetOK) then
					PA:BlessByLevel(msg, unit, true, true, ForceGroupBuffs);
				else
					if (Status~=nil) then
						if (PA:CheckMessageLevel("Bless", 1)) then
							PA:Message4("Blessing failed: "..Status);
						end
					else
						if (PA:CheckMessageLevel("Bless", 1)) then
							PA:Message4("Blessing failed (Status nil)");
						end
					end
				end

			else
				PA:BlessByLevel(msg, "player", true, false, ForceGroupBuffs);
			end
		end


	-------------------------
	-- Blessing List Commands
	-------------------------
	elseif (msg == "listraid"		or
			msg == "listparty"		or
			msg == "listall"		or
			msg == "listcycle"		or
			msg == "clearall"		or
			msg == "listactions" 	or
			msg == "listfailed" 	or
			msg == "listspells" 	or
			msg == "listgroup" 		or
			msg == "showspells" 	or
			msg == "showdamage" 	or
			msg == "showbuffs" 		or
			msg == "listrez" 		or
			msg == "cleartarget")	then
		PA:BlessList(msg);

	-------------------------------------------------------------------------------
	-- Start with Party and go from there
	-- 1.2.1.6 Even though it was a mistake in the documentation, accept cycleparty
	-------------------------------------------------------------------------------
	elseif (msg == "cyclebless" or msg == "cycleparty" or msg == "cyclebuff") then
		PA:CycleBless(ForceReset);

	------------------------------
	-- Buff everyone that is close
	------------------------------
	elseif (msg == "cyclenear") then
		PA:CycleBlessNear(ForceReset, ForceSelf);

	------------------------------
	-- Reset Cycle
	------------------------------
	elseif (msg == "resetcycle") then
		PA:SpellListReset();

	-------------------------------
	------  HEAL FUNCTIONS --------
	-------------------------------

	-----------------------
	-- AutoSelect Heal
	-----------------------
	elseif (msg == "asheal") then

		if (ForceSelf or (unit and (not PA:IsInRaid() and not PA:IsInParty()) and not PA:UnitIsMyFriend(unit))) then
			PA:BestHeal("player", true, IgnoreDistance, ForceGroupHeals);

		elseif (unit and (not PA:IsInRaid() and not PA:IsInParty()) and PA:UnitIsMyFriend(unit) and PA:CheckTarget(unit, false, PA.Spells.Default.Heal, PASettings.Switches.UseActionRange.Heal) and
			not UnitIsUnit(unit, "player") and (UnitHealth(unit) < 100)) then
			PA:BestHeal(unit, false, IgnoreDistance, ForceGroupHeals);

		elseif (unit and (PA:IsInParty() or PA:IsInRaid()) and PA:UnitIsMyFriend(unit) and PA:CheckTarget(unit, false, PA.Spells.Default.Heal, false) and
			(not UnitPlayerOrPetInParty(unit) and not UnitPlayerOrPetInRaid(unit)) and PASettings.Switches.EnableOutside == true and
			(UnitHealth(unit) < 100)) then
			PA:BestHeal(unit, false, IgnoreDistance, ForceGroupHeals);
		else
			PA:AutoHeal(true, IgnoreDistance, ForceGroupHeals, ForceReset);
		end

	-------------------------------
	-- AutoHeal Party/Raid/Pets
	-------------------------------
	elseif (msg == "autoheal") then
		PA:AutoHeal(true, IgnoreDistance, ForceGroupHeals, ForceReset);

	-------------------------------
	-- Best heal the target
	-------------------------------
	elseif (msg == "bestheal") then

		PA:BestHeal(unit, ForceSelf, IgnoreDistance, ForceGroupHeals);

	--------------------------------
	-------- FREE FUNCTIONS --------
	--------------------------------

	------------------------------------------------------
	-- Autoselect Free
	------------------------------------------------------
	elseif (msg == "asfree") then
		if (not PA:AsFree() and PASettings.Switches.QuietOnNotRequired~=true) then
			if (PA:CheckMessageLevel("Bless", 1)) then
				PA:Message4(PANZA_MSG_FREE_NO);
			end
		end

	------------------------------------------------------
	-- Autoselect Hammer of Wrath
	------------------------------------------------------
	elseif (msg == "ashow") then
		PA:AutoHow();

	-------------------------------------
	-------- RESURRECT FUNCTIONS --------
	-------------------------------------

	------------------------------------------------------
	-- Autoselect Resurrect
	------------------------------------------------------
	elseif (msg == "asrez") then
		if (not PA.InCombat or PA.PlayerClass=="DRUID") then
			if (PA:SpellInSpellBook("rez")) then
				if (ManualRez) then
					PA.Cycles.Spell.Type = "Rez";
					PA.Cycles.Spell.Active.msgtype = "ManualRez";
					PA.Cycles.Spell.Active.target = "Corpse"; -- Real target is determined in SpellStart
					PA.Cycles.Spell.Active.spell = PA.SpellBook.rez.Name;
					PA.Cycles.Spell.Active.rank = PA.SpellBook.rez.MaxRank;
					CastSpellByName(PA:CombineSpell(PA.SpellBook.rez.Name, PA.SpellBook.rez.MaxRank));
					if (PA:CheckMessageLevel("Rez", 1)) then
						PA:Message4("Select target to resurrect manually");
					end
					return;
				end

				-- Check if target is rezzable
				if (UnitExists("target")) then
					-- Check if friendly and not self
					if (not UnitIsUnit("target", "player") and PA:UnitIsMyFriend("target")) then

						-- Check tooltip for rezzable?

						-- Check not just rezzed
						local Name = PA:UnitName("target");
						if (Name~="target" and (PA.Rez[Name]==nil or (GetTime() - PA.Rez[Name])>120)) then
							local TargetOK, Exists, Status = PA:CheckTarget("target", true, PA.Spells.Default.Rez, PASettings.Switches.UseActionRange.Rez);
							PA:Debug("TargetOK=", TargetOK, " Exists=", Exists, " Status=", Status, " InRange=", InRange);
							if (TargetOK==true) then
								if (PA_CastResurrect({Unit="target"})) then
									return;
								end
							end
						end
					end
				end

				if (PA:IsInParty() or PA:IsInRaid()) then
					if (PA:AutoResurrect()~=false) then
						return;
					end
				end
				if (PASettings.Switches.QuietOnNotRequired~=true) then
					if (PA:CheckMessageLevel("Rez", 1)) then
						PA:Message4(PANZA_MSG_RESURRECT_NO);
					end
				end
			else
				if (PA:CheckMessageLevel("Rez", 1)) then
					PA:Message4(PANZA_MSG_RESURRECT_MISSING);
				end
			end
		else
			if (PA:CheckMessageLevel("Rez", 1)) then
				PA:Message4(PANZA_MSG_RESURRECT_COMBAT);
			end
		end

	--------------------------------
	-------- CURE FUNCTIONS --------
	--------------------------------

	------------------------------------------------------
	-- 2.0 Autoselect Cure
	-- Little extra AI here to not waste mana on BestCures
	------------------------------------------------------
	elseif (msg == "ascure") then

		if (not PA:AsCure(unit, false, ForceSelf) and PASettings.Switches.QuietOnNotRequired~=true) then
			if (PA:CheckMessageLevel("Cure", 1)) then
				PA:Message4(PANZA_MSG_CURE_NO);
			end
		end

	--------------------------------
	--   Autocure
	--------------------------------
	elseif (msg == "autocure") then
		PA:AutoCure(true);

	-------------------------------
	-- Best Cure Target
	-------------------------------
	elseif (msg == "bestcure") then
		PA:BestCure(unit, false, ForceSelf);

	-------------------------------
	-- Panic!
	-------------------------------
	elseif (msg == "panic") then
		PA:Panic(true);
		
	elseif (msg=="showranges") then
		PA:ShowActionBarRanges();
		
	-- Target info
	-------------------------------
	elseif (msg == "target") then
		local Name = PA:UnitName(unit);
		PA:Message("Target Info:");
		PA:DisplayText("  Name=",Name);
		PA:DisplayText("  IsVisible=", tostring(UnitIsVisible(unit)));
		PA:DisplayText("  Dead=", tostring(UnitIsDead(unit)));
		PA:DisplayText("  Ghost=", tostring(UnitIsGhost(unit)));
		PA:DisplayText("  DeadorGhost=", tostring(UnitIsDeadOrGhost(unit)));
		PA:DisplayText("  Corpse=", tostring(UnitIsCorpse(unit)));
		PA:DisplayText("  Interactive=", tostring(CheckInteractDistance(unit, 4)));
		PA:DisplayText("  20yrd Action=", IsActionInRange(PA.ActionId[20]));
		PA:DisplayText("  30yrd Action=", IsActionInRange(PA.ActionId[30]));
		PA:DisplayText("  40yrd Action=", IsActionInRange(PA.ActionId[40]));
		PA:DisplayText("  Range=", PA:RangeToUnit(unit));
		PA:DisplayText("  InternalRange=", PA:RangeToUnitInternal(unit));
		local px, py = GetPlayerMapPosition("player");
		PA:DisplayText("  SelfxPos=", px);
		PA:DisplayText("  SelfyPos=", py);
		PA:DisplayText("  Continent = ",GetCurrentMapContinent());
		PA:DisplayText("  PlayerControlled=", UnitPlayerControlled(unit));
		PA:DisplayText("  GuildInfo=", GetGuildInfo(unit));

		local Temp = {};
		PA:ResetTooltip();
		PanzaTooltip:SetUnit(unit);
		PA:CaptureTooltip(Temp);
		PA:DisplayText("  Left1 =", Temp.Tooltip.Left1);
		PA:DisplayText("  Right1=", Temp.Tooltip.Right1);
		PA:DisplayText("  Left2 =", Temp.Tooltip.Left2);
		PA:DisplayText("  Right2=", Temp.Tooltip.Right2);
		PA:DisplayText("  Left3 =", Temp.Tooltip.Left3);
		PA:DisplayText("  Right3=", Temp.Tooltip.Right3);

		PA:DisplayText("  Owner=", PA:GetUnitsOwner(unit));

		PA:DisplayText("  impPS=", tostring(PA:UnitHasBlessing(unit, "impPS")));
		PA:DisplayText("  Prowl=", tostring(PA:UnitHasBlessing(unit, "Prowl")));
		PA:DisplayText("  MindControl=", tostring(PA:UnitHasDebuff(unit, "MindControl")));
		PA:DisplayText("  MindVision=", tostring(PA:UnitHasDebuff(unit, "MindVision")));

		PA:Message("  Check Target:");
		local TargetOK, Exists, Status = PA:CheckTarget(unit, false);
		PA:DisplayText("    TargetOK=", tostring(TargetOK));
		PA:DisplayText("    Exists=", tostring(Exists));
		PA:DisplayText("    Status=", Status);

		PA:Message("  Check Player:");
		local OldTarget = PA:UnitName("target");
		PA:DisplayText("  OldTarget=", OldTarget);
		PA:DisplayText("  TargetInCombat=", UnitAffectingCombat("target"));
		PA:DisplayText("  Attacking=", UnitAffectingCombat("player"));
		PA:DisplayText("  IsCurrentAction=", IsCurrentAction(1));
		local InCombat = PA.InCombat;
		PA:DisplayText("  InCombat=", tostring(InCombat));
		TargetUnit("Player");
		PA:DisplayText("  20yrd Action=", IsActionInRange(PA.ActionId[20]));
		if (OldTarget~=nil and OldTarget~=PA:UnitName("target")) then
			TargetLastTarget();
			PA:DisplayText("  UnitCanAttack=", tostring(UnitCanAttack("player", "target")));
			PA:DisplayText("  InCombat=", tostring(PA.InCombat));
			PA.ForceCombat = false;
			PA.ForceCombat = (InCombat and UnitCanAttack("player", "target"));
		end
		
	-------------------------------------------
	-- 2.0 Generic Command for Testing anything
	-------------------------------------------
	elseif (msg == "test") then
		-- subgroup = 1;
		--if (PA:CheckMessageLevel("Bless", 3)) then
			-- PA:Message4("Skipping"..PA_BLUE.." "..PA:UnitName(unit).." "..PA_YEL.." in group "..PA_BLUE.." "..subgroup.." "..PA_YEL..". Disabled "..PA_BLUE.."Blessings"..PA_YEL.." in RGS.") ;
		--end

		-- Fall through without unknown command

	elseif (msg == "raidstatus") then
		PA:RaidSettingsStatus();

	--------------------------------------------------------------
	-- 1.21 Switches for blessing features save and self
	--------------------------------------------------------------
	elseif (msg == "enablesave") then
		if (PASettings.Switches.EnableSave == false) then
			PASettings.Switches.EnableSave = true;
			if (PA:CheckMessageLevel("Core",1)) then
				PA:Message4(PANZA_SAVEBLESSING_ENABLED);
			end
		else
			PASettings.Switches.EnableSave = false;
			if (PA:CheckMessageLevel("Core",1)) then
				PA:Message4(PANZA_SAVEBLESSING_DISABLED);
			end
		end

	--------------------------------------------------------------
	-- 1.21 Switches for blessing features save and self
	--------------------------------------------------------------
	elseif (msg == "enableself") then
		if (PASettings.Switches.EnableSelf == false) then
			PASettings.Switches.EnableSelf = true;
			if (PA:CheckMessageLevel("Core", 1)) then
				PA:Message4(PANZA_SELFBLESSING_ENABLED);
			end
		else
			PASettings.Switches.EnableSelf = false;
			if (PA:CheckMessageLevel("Core", 1)) then
				PA:Message4(PANZA_SELFBLESSING_DISABLED);
			end
		end

	--------------------------------------------------------------
	-- 2.0 Switches for Looking outside party/raid
	--------------------------------------------------------------
	elseif (msg == "enableout") then
		if (PASettings.Switches.EnableOutside == false) then
			PASettings.Switches.EnableOutside = true;
			if (PA:CheckMessageLevel("Core", 1)) then
				PA:Message4(PANZA_OUTSIDE_ENABLED);
			end
		else
			PASettings.Switches.EnableOutside = false;
			if (PA:CheckMessageLevel("Core", 1)) then
				PA:Message4(PANZA_OUTSIDE_DISABLED);
			end
		end

	--------------------------------------------------------------
	-- 2.0 Switch for RGS enable
	--------------------------------------------------------------
	elseif (msg == "enablergs") then
		if (PASettings.Switches.UseRGS.enabled == false) then
			PASettings.Switches.UseRGS.enabled = true;
			if (PA:CheckMessageLevel("Core", 1)) then
				PA:Message4(PANZA_RGS_ENABLED);
			end
		else
			PASettings.Switches.UseRGS.enabled = false;
			if (PA:CheckMessageLevel("Core", 1)) then
				PA:Message4(PANZA_RGS_DISABLED);
			end
		end

	-----------------------------------------
	-- 1.3 Heal Progress enable toggle switch
	-----------------------------------------
	elseif (msg =="healprogress") then
		if (PASettings.Switches.HealProgress == false) then
			PASettings.Switches.HealProgress = true;
			if (PA:CheckMessageLevel("Core", 1)) then
				PA:Message4(PANZA_HEALREPORT_ENABLED);
			end
		else
			PASettings.Switches.HealProgress = false;
			if (PA:CheckMessageLevel("Core", 1)) then
				PA:Message4(PANZA_HEALREPORT_DISABLED);
			end
		end

	-------------------------------------------------------------------------------------------
	-- @ WoW release 1.6 DI should be castable on anyone in your party, or raid. Outside Those?
	-------------------------------------------------------------------------------------------
	elseif (msg == "di") then
		if (PA:IsInRaid() or PA:IsInParty()) then
			PA:DivineIntervention();
		else
			if (PA:CheckMessageLevel("Heal", 1)) then
				PA:Message4("You cannot use Divine Intervention unless you are in a Party or Raid.");
			end
		end

	----------------
	-- Delete macros
	----------------
	elseif (msg == "deletemacros") then
		PA:DeleteMacros();

	-----------------------------------------------------------------------------
	-- Switches
	-----------------------------------------------------------------------------

	elseif (msg == "warn") then
		if (PASettings.Switches.EnableWarn == true) then
			PASettings.Switches.EnableWarn = false;
			PA:Message(PANZA_NOWARNINGS);
		else
			PASettings.Switches.EnableWarn = true;
			PA:Message(PANZA_WARNINGS);
		end

		if (PanzaSTAFrame:IsVisible()) then
			PA:STA_SetValues();
		end

	----------------------------
	-- 2.0 Enable Pets from DCB
	----------------------------
	elseif (msg == "dcbpets") then

		if (PASettings.Switches.Pets.Bless == false) then
			PASettings.Switches.Pets.Bless = true;
			if (PA:CheckMessageLevel("Core", 1)) then
				PA:Message4("Pet blessing is enabled.");
			end
		else
			PASettings.Switches.Pets.Bless = false;
			if (PA:CheckMessageLevel("Core", 1)) then
				PA:Message4("Pet blessing is disabled.");
			end
		end

	---------------------------------------------
	-- 2.1 Enable Ignoring Party in Raid from DCB
	---------------------------------------------
	elseif (msg == "dcbignoreparty") then

		if (PASettings.Switches.IgnorePartyInRaid.enabled == false) then
			PASettings.Switches.IgnorePartyInRaid.enabled = true;
			if (PA:CheckMessageLevel("Core", 1)) then
				PA:Message4("Party blessings will be ignored in a raid.");
			end
		else
			PASettings.Switches.IgnorePartyInRaid.enabled = false;
			if (PA:CheckMessageLevel("Core", 1)) then
				PA:Message4("Party blessings will now be used in preference to raid blessings.");
			end
		end

	-----------------------------------------
	-- 2.0 PA:Notify on Spell Failures Toggle
	-----------------------------------------
	elseif (msg == "notfail") then


		if (PASettings.Switches.NotifyFail == false) then
			PASettings.Switches.NotifyFail = true;
			if (PA:CheckMessageLevel("Core", 1)) then
				PA:Message4("Spell cast failure notification is enabled.");
			end
		else
			PASettings.Switches.NotifyFail = false;
			if (PA:CheckMessageLevel("Core", 1)) then
				PA:Message4("Spell cast failure notification is disabled.");
			end
		end

	-----------------------------------------
	-- 2.0 PA:Notify on Spell Failures Toggle
	-----------------------------------------
	elseif (msg == "showranks") then


		if (PASettings.Switches.ShowRanks.enabled == false) then
			PASettings.Switches.ShowRanks.enabled = true;
			if (PA:CheckMessageLevel("Core", 1)) then
				PA:Message4("Spell ranks will now be shown.");
			end
		else
			PASettings.Switches.ShowRanks.enabled = false;
			if (PA:CheckMessageLevel("Core", 1)) then
				PA:Message4("Spell ranks will now be hidden.");
			end
		end

	-----------------------------------------
	-- 2.0 Bless NPCs with CycleNear
	-----------------------------------------
	elseif (msg == "enablenpc") then

		if (PASettings.Switches.EnableNPC == false) then
			PASettings.Switches.EnableNPC = true;
			if (PA:CheckMessageLevel("Core", 1)) then
				PA:Message4("CycleNear will bless nearby NPCs and Players .");
			end
		else
			PASettings.Switches.EnableNPC = false;
			if (PA:CheckMessageLevel("Core", 1)) then
				PA:Message4("CycleNear will only bless nearby Players.");
			end
		end

	-----------------------------------------
	-- 2.0 AutoSelect Cyclebless Toggle
	-----------------------------------------
	elseif (msg == "enablecycle") then

		if (PASettings.Switches.EnableCycle == false) then
			PASettings.Switches.EnableCycle = true;
			if (PA:CheckMessageLevel("Core", 1)) then
				PA:Message4("AutoSelect Bless (AsBless) will use CycleBless when in a Party or Raid.");
			end
		else
			PASettings.Switches.EnableCycle = false;
			if (PA:CheckMessageLevel("Core", 1)) then
				PA:Message4("AutoSelect Bless (AsBless) will only bless single group targets or self when in a Party or Raid. See the \"Enable Outside\" option also.");
			end
		end

	-----------------------------------------
	-- 2.1 AutoSelect BoW on low mana Toggle
	-----------------------------------------
	elseif (msg == "enablebowonlowmana") then

		if (PASettings.Switches.BlessBowOnLowMana.enabled == false) then
			PASettings.Switches.BlessBowOnLowMana.enabled = true;
			if (PA:CheckMessageLevel("Core", 1)) then
				PA:Message4("Will switch to casting BoW when target low on mana.");
			end
		else
			PASettings.Switches.BlessBowOnLowMana.enabled = false;
			if (PA:CheckMessageLevel("Core", 1)) then
				PA:Message4("Will not switch to casting BoW when target low on mana.");
			end
		end

	-----------------------------------------------
	-- 2.1 Use BG blessings when PVP flag on Toggle
	-----------------------------------------------
	elseif (msg == "enablebgonpvp") then

		if (PASettings.Switches.PVPUseBG.enabled == false) then
			PASettings.Switches.PVPUseBG.enabled = true;
			if (PA:CheckMessageLevel("Core", 1)) then
				PA:Message4("Will uses BattleGround blessings for users with PVP flag on.");
			end
		else
			PASettings.Switches.PVPUseBG.enabled = false;
			if (PA:CheckMessageLevel("Core", 1)) then
				PA:Message4("Will uses normal blessings independant of PVP flags.");
			end
		end

	--------------------
	-- 2.0 Skip PVP Flag
	--------------------
	elseif (msg == "nopvp") then
		PASettings.Switches.NoPVP.enabled = not PASettings.Switches.NoPVP.enabled;
		if (PASettings.Switches.NoPVP.enabled==true) then
			if (PA:CheckMessageLevel("Core", 1)) then
				PA:Message4(PANZA_NO_PVP_ENABLED);
			end
		else
			if (PA:CheckMessageLevel("Core", 1)) then
				PA:Message4(PANZA_NO_PVP_DISABLED);
			end
		end

	elseif (msg == "buffs") then
		PA:ShowAllBuffs(unit);

	elseif (msg == "debuffs") then
		PA:ShowAllDebuffs(unit);

	elseif (msg=="dump") then
		PA:Dump();
		PA:Message("State dumped to");
		PA:Message("WTF \\ Account \\ <ACCOUNT> \\ "..GetRealmName().." \\ "..PA.PlayerName.." \\ SavedVariables \\ Panza.lua");
		PA:Message("You must log-out to save the values to disk (at end of fight/raid is fine)");

	-----------------
	-- 3.0 PAW toggle
	-----------------
	elseif (msg == "paw") then
		PASettings.Switches.Whisper.enabled = not PASettings.Switches.Whisper.enabled;

		if (PASettings.Switches.Whisper.enabled == true) then
			if (PA:CheckMessageLevel("Core",1)) then
				PA:Message4(PANZA_PAW_ENABLED);
			end
		else
			if (PA:CheckMessageLevel("Core",1)) then
				PA:Message4(PANZA_PAW_DISABLED);
			end
		end

	------------------------
	-- 3.0 PAW Announcements
	------------------------
	elseif (msg == "annc") then
		PA:PAW_Annc();

	---------------------------
	-- 3.0 PAW Responses toggle
	---------------------------
	elseif (msg == "pawresp") then
		PASettings.Switches.Whisper.feedback = not PASettings.Switches.Whisper.feedback;

		if (PASettings.Switches.Whisper.feedback == true) then
			if (PA:CheckMessageLevel("Core",1)) then
				PA:Message4(PANZA_PAW_RESP_ENABLED);
			end
		else
			if (PA:CheckMessageLevel("Core",1)) then
				PA:Message4(PANZA_PAW_RESP_DISABLED);
			end
		end

	---------------
	-- Quiet Please
	---------------
	elseif (msg == "quiet") then
		PASettings.Switches.HealProgress 		= false;
		PASettings.Switches.NotifyFail		 	= false;

		PASettings.Switches.MsgGroup.Heal.Party		= false;
		PASettings.Switches.MsgGroup.Bless.Party	= false;
		PASettings.Switches.MsgGroup.Cure.Party		= false;
		PASettings.Switches.MsgGroup.Rez.Party		= false;

		PASettings.Switches.MsgGroup.Heal.Raid		= false;
		PASettings.Switches.MsgGroup.Bless.Raid		= false;
		PASettings.Switches.MsgGroup.Cure.Raid		= false;
		PASettings.Switches.MsgGroup.Rez.Raid		= false;

		PASettings.Switches.MsgGroup.Heal.Whisper 	= false;
		PASettings.Switches.MsgGroup.Bless.Whisper	= false;
		PASettings.Switches.MsgGroup.Cure.Whisper 	= false;
		PASettings.Switches.MsgGroup.Rez.Whisper 	= false;

		PASettings.Switches.MsgGroup.Heal.Say 		= false;
		PASettings.Switches.MsgGroup.Bless.Say		= false;
		PASettings.Switches.MsgGroup.Cure.Say 		= false;
		PASettings.Switches.MsgGroup.Rez.Say 		= false;

		PASettings.Switches.MsgGroup.Heal.EM 		= false;
		PASettings.Switches.MsgGroup.Bless.EM		= false;
		PASettings.Switches.MsgGroup.Cure.EM 		= false;
		PASettings.Switches.MsgGroup.Rez.EM 		= false;

		PASettings.Switches.MsgLevel.Heal		= 0;
		PASettings.Switches.MsgLevel.Bless		= 0;
		PASettings.Switches.MsgLevel.Cure		= 0;
		PASettings.Switches.MsgLevel.Core		= 0;
		PASettings.Switches.MsgLevel.UI			= 0;
		PASettings.Switches.MsgLevel.Coop		= 0;
		PASettings.Switches.MsgLevel.Offen		= 0;
		
		PASettings.Switches.QuietOnNotRequired = true;

		if (PanzaPAMFrame:IsVisible()) then
			PA:PAM_SetValues()
		end

		PA:Message(PANZA_SHOW_QUIET);

	--------------------------------
	-- PAM Healing Checkbox Commands
	--------------------------------
	elseif (msg == "pamhealparty") then
		if (PASettings.Switches.MsgGroup.Heal.EM == true) then
			PASettings.Switches.MsgGroup.Heal.EM = false;
		end
		if (PASettings.Switches.MsgGroup.Heal.Party == true) then
			PASettings.Switches.MsgGroup.Heal.Party = false;
		else
			PASettings.Switches.MsgGroup.Heal.Party = true;
		end
		cbxPanzaPAMHealEM:SetChecked(PASettings.Switches.MsgGroup.Heal.EM == true);

	elseif (msg == "pamhealraid") then
		if (PASettings.Switches.MsgGroup.Heal.EM == true) then
			PASettings.Switches.MsgGroup.Heal.EM = false;
		end
		if (PASettings.Switches.MsgGroup.Heal.Raid == true) then
			PASettings.Switches.MsgGroup.Heal.Raid = false;
		else
			PASettings.Switches.MsgGroup.Heal.Raid = true;
		end
		cbxPanzaPAMHealEM:SetChecked(PASettings.Switches.MsgGroup.Heal.EM == true);

	elseif (msg == "pamhealwhisper") then
		if (PASettings.Switches.MsgGroup.Heal.EM == true) then
			PASettings.Switches.MsgGroup.Heal.EM = false;
		end
		if (PASettings.Switches.MsgGroup.Heal.Say == true) then
			PASettings.Switches.MsgGroup.Heal.Say = false;
		end
		if (PASettings.Switches.MsgGroup.Heal.Whisper == true) then
			PASettings.Switches.MsgGroup.Heal.Whisper = false;
		else
			PASettings.Switches.MsgGroup.Heal.Whisper = true;
		end
		cbxPanzaPAMHealSay:SetChecked(PASettings.Switches.MsgGroup.Heal.Say == true);
		cbxPanzaPAMHealEM:SetChecked(PASettings.Switches.MsgGroup.Heal.EM == true);

	elseif (msg == "pamhealsay") then
		if (PASettings.Switches.MsgGroup.Heal.EM == true) then
			PASettings.Switches.MsgGroup.Heal.EM = false;
		end
		if (PASettings.Switches.MsgGroup.Heal.Whisper == true) then
			PASettings.Switches.MsgGroup.Heal.Whisper = false;
		end
		if (PASettings.Switches.MsgGroup.Heal.Say == true) then
			PASettings.Switches.MsgGroup.Heal.Say = false;
		else
			PASettings.Switches.MsgGroup.Heal.Say = true;
		end
		cbxPanzaPAMHealWhis:SetChecked(PASettings.Switches.MsgGroup.Heal.Whisper == true);
		cbxPanzaPAMHealEM:SetChecked(PASettings.Switches.MsgGroup.Heal.EM == true);

	elseif (msg == "pamhealem") then
		if (PASettings.Switches.MsgGroup.Heal.Whisper == true) then
			PASettings.Switches.MsgGroup.Heal.Whisper = false;
		end
		if (PASettings.Switches.MsgGroup.Heal.Say == true) then
			PASettings.Switches.MsgGroup.Heal.Say = false;
		end
		if (PASettings.Switches.MsgGroup.Heal.Party == true) then
			PASettings.Switches.MsgGroup.Heal.Party = false;
		end
		if (PASettings.Switches.MsgGroup.Heal.Raid == true) then
			PASettings.Switches.MsgGroup.Heal.Raid = false;
		end
		if (PASettings.Switches.MsgGroup.Heal.EM == true) then
			PASettings.Switches.MsgGroup.Heal.EM = false;
		else
			PASettings.Switches.MsgGroup.Heal.EM = true;
		end
		cbxPanzaPAMHealWhis:SetChecked(PASettings.Switches.MsgGroup.Heal.Whisper == true);
		cbxPanzaPAMHealSay:SetChecked(PASettings.Switches.MsgGroup.Heal.Say == true);
		cbxPanzaPAMHealParty:SetChecked(PASettings.Switches.MsgGroup.Heal.Party == true);
		cbxPanzaPAMHealRaid:SetChecked(PASettings.Switches.MsgGroup.Heal.Raid == true);

	---------------------------------
	-- PAM Blessing Checkbox Commands
	---------------------------------
	elseif (msg == "pamblessparty") then
		if (PASettings.Switches.MsgGroup.Bless.EM == true) then
			PASettings.Switches.MsgGroup.Bless.EM = false;
		end
		if (PASettings.Switches.MsgGroup.Bless.Party == true) then
			PASettings.Switches.MsgGroup.Bless.Party = false;
		else
			PASettings.Switches.MsgGroup.Bless.Party = true;
		end
		cbxPanzaPAMBlessEM:SetChecked(PASettings.Switches.MsgGroup.Bless.EM == true);

	elseif (msg == "pamblessraid") then
		if (PASettings.Switches.MsgGroup.Bless.EM == true) then
			PASettings.Switches.MsgGroup.Bless.EM = false;
		end
		if (PASettings.Switches.MsgGroup.Bless.Raid == true) then
			PASettings.Switches.MsgGroup.Bless.Raid = false;
		else
			PASettings.Switches.MsgGroup.Bless.Raid = true;
		end
		cbxPanzaPAMBlessEM:SetChecked(PASettings.Switches.MsgGroup.Bless.EM == true);

	elseif (msg == "pamblesswhisper") then
		if (PASettings.Switches.MsgGroup.Bless.Say == true) then
			PASettings.Switches.MsgGroup.Bless.Say = false;
		end
		if (PASettings.Switches.MsgGroup.Bless.EM == true) then
			PASettings.Switches.MsgGroup.Bless.EM = false;
		end
		if (PASettings.Switches.MsgGroup.Bless.Whisper == true) then
			PASettings.Switches.MsgGroup.Bless.Whisper = false;
		else
			PASettings.Switches.MsgGroup.Bless.Whisper = true;
		end
		cbxPanzaPAMBlessSay:SetChecked(PASettings.Switches.MsgGroup.Bless.Say == true);
		cbxPanzaPAMBlessEM:SetChecked(PASettings.Switches.MsgGroup.Bless.EM == true);

	elseif (msg == "pamblesssay") then
		if (PASettings.Switches.MsgGroup.Bless.Whisper == true) then
			PASettings.Switches.MsgGroup.Bless.Whisper = false;
		end
		if (PASettings.Switches.MsgGroup.Bless.EM == true) then
			PASettings.Switches.MsgGroup.Bless.EM = false;
		end
		if (PASettings.Switches.MsgGroup.Bless.Say == true) then
			PASettings.Switches.MsgGroup.Bless.Say = false;
		else
			PASettings.Switches.MsgGroup.Bless.Say = true;
		end
		cbxPanzaPAMBlessWhis:SetChecked(PASettings.Switches.MsgGroup.Bless.Whisper == true);
		cbxPanzaPAMBlessEM:SetChecked(PASettings.Switches.MsgGroup.Bless.EM == true);

	elseif (msg == "pamblessem") then
		if (PASettings.Switches.MsgGroup.Bless.Whisper == true) then
			PASettings.Switches.MsgGroup.Bless.Whisper = false;
		end
		if (PASettings.Switches.MsgGroup.Bless.Say == true) then
			PASettings.Switches.MsgGroup.Bless.Say = false;
		end
		if (PASettings.Switches.MsgGroup.Bless.Party == true) then
			PASettings.Switches.MsgGroup.Bless.Party = false;
		end
		if (PASettings.Switches.MsgGroup.Bless.Raid == true) then
			PASettings.Switches.MsgGroup.Bless.Raid = false;
		end
		if (PASettings.Switches.MsgGroup.Bless.EM == true) then
			PASettings.Switches.MsgGroup.Bless.EM = false;
		else
			PASettings.Switches.MsgGroup.Bless.EM = true;
		end
		cbxPanzaPAMBlessWhis:SetChecked(PASettings.Switches.MsgGroup.Bless.Whisper == true);
		cbxPanzaPAMBlessSay:SetChecked(PASettings.Switches.MsgGroup.Bless.Say == true);
		cbxPanzaPAMBlessParty:SetChecked(PASettings.Switches.MsgGroup.Bless.Party == true);
		cbxPanzaPAMBlessRaid:SetChecked(PASettings.Switches.MsgGroup.Bless.Raid == true);

	-----------------------------
	-- PAM Cure Checkbox Commands
	-----------------------------
	elseif (msg == "pamcureparty") then
		if (PASettings.Switches.MsgGroup.Cure.EM == true) then
			PASettings.Switches.MsgGroup.Cure.EM = false;
		end
		if (PASettings.Switches.MsgGroup.Cure.Party == true) then
			PASettings.Switches.MsgGroup.Cure.Party = false;
		else
			PASettings.Switches.MsgGroup.Cure.Party = true;
		end
		cbxPanzaPAMCureEM:SetChecked(PASettings.Switches.MsgGroup.Cure.EM == true);

	elseif (msg == "pamcureraid") then
		if (PASettings.Switches.MsgGroup.Cure.EM == true) then
			PASettings.Switches.MsgGroup.Cure.EM = false;
		end
		if (PASettings.Switches.MsgGroup.Cure.Raid == true) then
			PASettings.Switches.MsgGroup.Cure.Raid = false;
		else
			PASettings.Switches.MsgGroup.Cure.Raid = true;
		end
		cbxPanzaPAMCureEM:SetChecked(PASettings.Switches.MsgGroup.Cure.EM == true);

	elseif (msg == "pamcurewhisper") then
		if (PASettings.Switches.MsgGroup.Cure.Say == true) then
			PASettings.Switches.MsgGroup.Cure.Say = false;
		end
		if (PASettings.Switches.MsgGroup.Cure.EM == true) then
			PASettings.Switches.MsgGroup.Cure.EM = false;
		end
		if (PASettings.Switches.MsgGroup.Cure.Whisper == true) then
			PASettings.Switches.MsgGroup.Cure.Whisper = false;
		else
			PASettings.Switches.MsgGroup.Cure.Whisper = true;
		end
		cbxPanzaPAMCureSay:SetChecked(PASettings.Switches.MsgGroup.Cure.Say == true);
		cbxPanzaPAMCureEM:SetChecked(PASettings.Switches.MsgGroup.Cure.EM == true);

	elseif (msg == "pamcuresay") then
		if (PASettings.Switches.MsgGroup.Cure.Whisper == true) then
			PASettings.Switches.MsgGroup.Cure.Whisper = false;
		end
		if (PASettings.Switches.MsgGroup.Cure.EM == true) then
			PASettings.Switches.MsgGroup.Cure.EM = false;
		end
		if (PASettings.Switches.MsgGroup.Cure.Say == true) then
			PASettings.Switches.MsgGroup.Cure.Say = false;
		else
			PASettings.Switches.MsgGroup.Cure.Say = true;
		end
		cbxPanzaPAMCureWhis:SetChecked(PASettings.Switches.MsgGroup.Cure.Whisper == true);
		cbxPanzaPAMCureEM:SetChecked(PASettings.Switches.MsgGroup.Cure.EM == true);

	elseif (msg == "pamcureem") then
		if (PASettings.Switches.MsgGroup.Cure.Whisper == true) then
			PASettings.Switches.MsgGroup.Cure.Whisper = false;
		end
		if (PASettings.Switches.MsgGroup.Cure.Say == true) then
			PASettings.Switches.MsgGroup.Cure.Say = false;
		end
		if (PASettings.Switches.MsgGroup.Cure.Party == true) then
			PASettings.Switches.MsgGroup.Cure.Party = false;
		end
		if (PASettings.Switches.MsgGroup.Cure.Raid == true) then
			PASettings.Switches.MsgGroup.Cure.Raid = false;
		end
		if (PASettings.Switches.MsgGroup.Cure.EM == true) then
			PASettings.Switches.MsgGroup.Cure.EM = false;
		else
			PASettings.Switches.MsgGroup.Cure.EM = true;
		end
		cbxPanzaPAMCureWhis:SetChecked(PASettings.Switches.MsgGroup.Cure.Whisper == true);
		cbxPanzaPAMCureSay:SetChecked(PASettings.Switches.MsgGroup.Cure.Say == true);
		cbxPanzaPAMCureParty:SetChecked(PASettings.Switches.MsgGroup.Cure.Party == true);
		cbxPanzaPAMCureRaid:SetChecked(PASettings.Switches.MsgGroup.Cure.Raid == true);

	-----------------------------
	-- PAM Rez Checkbox Commands
	-----------------------------
	elseif (msg == "pamrezparty") then
		if (PASettings.Switches.MsgGroup.Rez.EM == true) then
			PASettings.Switches.MsgGroup.Rez.EM = false;
		end
		if (PASettings.Switches.MsgGroup.Rez.Party == true) then
			PASettings.Switches.MsgGroup.Rez.Party = false;
		else
			PASettings.Switches.MsgGroup.Rez.Party = true;
		end
		cbxPanzaPAMRezEM:SetChecked(PASettings.Switches.MsgGroup.Rez.EM == true);

	elseif (msg == "pamrezraid") then
		if (PASettings.Switches.MsgGroup.Rez.EM == true) then
			PASettings.Switches.MsgGroup.Rez.EM = false;
		end
		if (PASettings.Switches.MsgGroup.Rez.Raid == true) then
			PASettings.Switches.MsgGroup.Rez.Raid = false;
		else
			PASettings.Switches.MsgGroup.Rez.Raid = true;
		end
		cbxPanzaPAMRezEM:SetChecked(PASettings.Switches.MsgGroup.Rez.EM == true);

	elseif (msg == "pamrezwhisper") then

		if (PASettings.Switches.MsgGroup.Rez.Say == true) then
			PASettings.Switches.MsgGroup.Rez.Say = false;
		end
		if (PASettings.Switches.MsgGroup.Rez.EM == true) then
			PASettings.Switches.MsgGroup.Rez.EM = false;
		end
		if (PASettings.Switches.MsgGroup.Rez.Whisper == true) then
			PASettings.Switches.MsgGroup.Rez.Whisper = false;
		else
			PASettings.Switches.MsgGroup.Rez.Whisper = true;
		end
		cbxPanzaPAMRezSay:SetChecked(PASettings.Switches.MsgGroup.Rez.Say == true);
		cbxPanzaPAMRezEM:SetChecked(PASettings.Switches.MsgGroup.Rez.EM == true);

	elseif (msg == "pamrezsay") then
		if (PASettings.Switches.MsgGroup.Rez.Whisper == true) then
			PASettings.Switches.MsgGroup.Rez.Whisper = false;
		end
		if (PASettings.Switches.MsgGroup.Rez.EM == true) then
			PASettings.Switches.MsgGroup.Rez.EM = false;
		end
		if (PASettings.Switches.MsgGroup.Rez.Say == true) then
			PASettings.Switches.MsgGroup.Rez.Say = false;
		else
			PASettings.Switches.MsgGroup.Rez.Say = true;
		end
		cbxPanzaPAMRezWhis:SetChecked(PASettings.Switches.MsgGroup.Rez.Whisper == true);
		cbxPanzaPAMRezEM:SetChecked(PASettings.Switches.MsgGroup.Rez.EM == true);

	elseif (msg == "pamrezem") then
		if (PASettings.Switches.MsgGroup.Rez.Whisper == true) then
			PASettings.Switches.MsgGroup.Rez.Whisper = false;
		end
		if (PASettings.Switches.MsgGroup.Rez.Say == true) then
			PASettings.Switches.MsgGroup.Rez.Say = false;
		end
		if (PASettings.Switches.MsgGroup.Rez.Party == true) then
			PASettings.Switches.MsgGroup.Rez.Party = false;
		end
		if (PASettings.Switches.MsgGroup.Rez.Raid == true) then
			PASettings.Switches.MsgGroup.Rez.Raid = false;
		end
		if (PASettings.Switches.MsgGroup.Rez.EM == true) then
			PASettings.Switches.MsgGroup.Rez.EM = false;
		else
			PASettings.Switches.MsgGroup.Rez.EM = true;
		end
		cbxPanzaPAMRezWhis:SetChecked(PASettings.Switches.MsgGroup.Rez.Whisper == true);
		cbxPanzaPAMRezSay:SetChecked(PASettings.Switches.MsgGroup.Rez.Say == true);
		cbxPanzaPAMRezParty:SetChecked(PASettings.Switches.MsgGroup.Rez.Party == true);
		cbxPanzaPAMRezRaid:SetChecked(PASettings.Switches.MsgGroup.Rez.Raid == true);

	elseif (msg == "reset") then
		PA:Reset(true);
	elseif (msg == "window") then
		PA:ToggleWindowState();
	elseif (msg == "listmouse") then
		PA:listMouse();
	else
		PA:Message("Panza - Unknown command: "..msg..".");
	end
end



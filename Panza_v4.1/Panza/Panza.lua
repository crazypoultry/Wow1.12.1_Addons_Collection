--[[

AddOn:	Panza - The Healer's Sidekick

By:		The PADevs AddOn Team
		--------------------------------
		Drowsey
		Smacker
		JMR
		Stephen
		Tom
		Lei

Base Version: 	4.0

Check for the latest update at: http://ui.worldofwar.net/ui.php?id=1042

Review index.html for documentation, changes, history, and known issues for this AddOn.
Also see readme-notes.txt for latest patch information, and to-do.txt for what is planned.

Other Addons Recommended for optimal operation of Panza are:

MapLibrary		Included with Distribution for range calculations if not using ActionBars.
PanzaComm		Included with Distribution for Cooperative healing support.
BonusScanner	http://ui.worldofwar.net/ui.php?id=1461 (required for +healing support)
Titan			http://ui.worldofwar.net/ui.php?576  	(required for TitanPA)
CT_RaidAssist	http://ctmod.net (used for enhanced rez target selection, and main tank priority)

Acknowledgements:
Thanks to Mars for the MarsMessageParser
Thanks to Gello for the TrinketMenu framework we have used for our SealMenu

Delevopers Notes:
Tabulation: Set to Indent=4, Tab=4 + do not convert to spaces (for TextPad need to change from defaults)

--]]

------------------------------------------------------------
-- 2.1 Class name reverse lookups
------------------------------------------------------------
PA.ClassName = {};
PA.ClassName["DRUID"]	= PANZA_DRUID;
PA.ClassName["HUNTER"]	= PANZA_HUNTER;
PA.ClassName["MAGE"]	= PANZA_MAGE;
PA.ClassName["PALADIN"]	= PANZA_PALADIN;
PA.ClassName["PRIEST"]	= PANZA_PRIEST;
PA.ClassName["ROGUE"]	= PANZA_ROGUE;
PA.ClassName["WARLOCK"]	= PANZA_WARLOCK;
PA.ClassName["WARRIOR"]	= PANZA_WARRIOR;
PA.ClassName["SHAMAN"]	= PANZA_SHAMAN;


PA.FactionEn 			= {[PANZA_FACTION_HORDE]="Horde", [PANZA_FACTION_ALLIANCE]="Alliance"}
PanzaHelp = {};
PanzaHelp[1] = PANZA_HELP_PAGE1;
PanzaHelp[2] = PANZA_HELP_PAGE1;

PA.Events = {"CHARACTER_POINTS_CHANGED",
			"SPELLCAST_DELAYED",
			"SPELLCAST_FAILED",
			"SPELLCAST_INTERRUPTED",
			"SPELLCAST_START",
			"SPELLCAST_STOP",
			"PLAYER_DEAD",
			"UNIT_INVENTORY_CHANGED",
			"UNIT_HEALTH",
			"PLAYER_ENTER_COMBAT",
			"PLAYER_LEAVE_COMBAT",
			"ACTIONBAR_SLOT_CHANGED",
			"ACTIONBAR_HIDEGRID",
			"CHAT_MSG_SPELL_FAILED_LOCALPLAYER",
			"DUEL_FINISHED",
			"DUEL_INBOUNDS",
			"RAID_ROSTER_UPDATE",
			"CHAT_MSG_SPELL_SELF_DAMAGE",
			"CHAT_MSG_BG_SYSTEM_ALLIANCE",
    		"CHAT_MSG_BG_SYSTEM_HORDE",
    		"CHAT_MSG_BG_SYSTEM_NEUTRAL",
			"LEARNED_SPELL_IN_TAB"};


------------------------------------------------------------------
-- Function to toggle the setup dialog box from the minimap button
------------------------------------------------------------------
function PA:OptsToggle()
	if (not PA:FrameToggle(PanzaTreeFrame)) then
		PA:HideAll();
	end
end

------------------------------------------------------------------
-- Hide all other option windows
------------------------------------------------------------------
function PA:HideAll()
	-- Autohide all other Dialogs when main one is closed
	for FrameName, Frame in pairs(PA.GUIFrames) do
		--PA:ShowText("Frame=", FrameName);
		if (Frame:IsVisible()) then
			Frame:Hide();
		end
	end				
end

----------------------------------------------------
-- Update Transparency for given frame, if displayed
----------------------------------------------------
function PA:UpdateFrameAlpha(frame)
	if (frame and frame:IsVisible()) then
		frame:SetAlpha(PASettings.Alpha);
	end
end

------------------------
-- Update Transparencies
------------------------
function PA:UpdateAlpha()

	if (PA:CheckMessageLevel("UI", 5)) then
		PA:Message4(PA_WHITE.."PA:UpdateAlpha() Alpha Setting: "..PASettings.Alpha);
	end

	for FrameName, Frame in pairs(PA.GUIFrames) do
		--PA:ShowText("Frame=", FrameName);
		PA:UpdateFrameAlpha(Frame);
	end
end

------------------------------------------
-- Function to toggle a frame's visibility
------------------------------------------
function PA:FrameToggle(frame)
	if (frame~=nil) then
		if (frame:IsVisible()) then
			frame:Hide();
			return false;
		else
			frame:Show();
			return true;
		end
	end
	return nil;
end

-------------------------------------------------------------------
-- Target checking for Buffs/Heals/Cures/Rez
-- Returns CheckFlag, ExistsFlag and CheckFailReason
-------------------------------------------------------------------
function PA:CheckTarget(unit, isRez, shortSpell, checkActionRange)
	local name = nil;
	
	if (unit==nil) then
		return false, false, nil;
	end

	if (not UnitExists(unit)) then
		if (PA:CheckMessageLevel("Core", 2)) then
			PA:Message4(format(PANZA_UNIT_DOESNT_EXIST, unit));
		end
		PA:RemoveUnitSpell(unit);
		PA:RemoveFromFailed(unit);
		return false, false, "Non-Existant";
	end

	-- Vanity Pet Check
	if (PA:IsVanityPet(unit)) then
		if (PA:CheckMessageLevel("Core", 2)) then
			PA:Message4(PANZA_TARGET_VANITYPET);
		end
		PA:RemoveUnitSpell(unit);
		return false, false, "VanityPet";
	end

	name = PA:UnitName(unit);

	if (not UnitIsConnected(unit)) then
		if (PA:CheckMessageLevel("Core", 2)) then
			PA:Message4(PANZA_TARGET_NOT_CONNECTED);
		end
		PA:RemoveUnitSpell(unit);
		PA:RemoveFromFailed(unit);
		return false, true, "Disconnected";
	end

	local IsDead = false;
	if (UnitIsDead(unit) or UnitIsCorpse(unit)) then
		if (PA:CheckMessageLevel("Core", 2)) then
			PA:Message4(format(PANZA_TARGET_DEAD, name));
		end
		PA:RemoveUnitSpell(unit);
		PA:RemoveFromFailed(unit);
		if (not isRez) then
			return false, true, "Dead";
		end
		IsDead = true;
	end

	local inBG = PA:IsInBG();
	--PA:ShowText("inBG=", inBG);

	if UnitIsGhost(unit) then
		if (PA:CheckMessageLevel("Core", 2)) then
			PA:Message4(format(PANZA_TARGET_GHOST, name));
		end
		PA:RemoveUnitSpell(unit);
		PA:RemoveFromFailed(unit);
		if (isRez and not inBG) then
			PA.ReleasedCount = PA.ReleasedCount + 1;
			PA.ReleasedList[PA.ReleasedCount] = unit;
			return false, true, "Corpse";
		end
		return false, true, "Dead";
	end

	if (isRez and not IsDead) then
		return false, true, "NotDead";
	end

	-- Make sure our target (including self) is not burning from Vael. Skip the "soon to be dead anyway" unlucky sap.
	if (PA:UnitHasDebuff(unit, "Burning")) then
		if (PA:CheckMessageLevel("Core", 2)) then
			PA:Message4(format(PANZA_TARGET_BURNING, name));
		end
		return false, true, "Burning";
	end

	if (not isRez and UnitIsUnit(unit, "player")) then
		if (PA:CheckMessageLevel("Core", 2)) then
			PA:Message4(PANZA_TARGET_SELF);
		end
		return true, true, nil;
	end

	----------------------------------------------------------------
	-- If we are dueling then ignore everyone else
	----------------------------------------------------------------
	if (not isRez and PA.Dueling) then
		if (PA:CheckMessageLevel("Core", 2)) then
			PA:Message4(PANZA_TARGET_NOT_FRIEND);
		end
		return false, true, "NotFriendly";
	end

	-------------------------------
	-- Check unit visible to client
	-------------------------------
	if (not UnitIsVisible(unit)) then
		if (PA:CheckMessageLevel("Core", 2)) then
			PA:Message4(PANZA_TARGET_NOT_VISABLE);
		end
		return false, true, "OutOfRange";
	end

	if (UnitIsEnemy(unit, "player")) then
		--PA:Debug("Enemy target: ", unit);
		if (PA:CheckMessageLevel("Core", 2)) then
			PA:Message4(PANZA_TARGET_ENEMY);
		end
		return false, true, "Enemy";
	end

	if (not PA:UnitIsMyFriend(unit)) then
		if (PA:CheckMessageLevel("Core", 2)) then
			PA:Message4(PANZA_TARGET_NOT_FRIEND)
		end
		return false, true, "NotFriendly";
	end
	
	--------------------------------------------------------------------------------
	-- Check for PVP Flag only if we care, or we are not in a Battlefield
	--------------------------------------------------------------------------------
	if (PASettings.Switches.NoPVP.enabled==true and UnitIsPVP(unit) and (UnitIsPlayer(unit) or UnitPlayerControlled(unit))) then
		if (not inBG) then
			----------------------------------------------------------------
			-- Also does not affect anyone else if we ourselves are flagged.
			----------------------------------------------------------------
			if (not UnitIsPVP("player")) then
				if (PA:CheckMessageLevel("Core", 2)) then
					PA:Message4(format(PANZA_NO_PVP, name, "inactive"));
				end
				return false, true, "NoPVP";
			end
		end
	end

	------------------------------------
	-- Only check these for live targets
	------------------------------------
	if (not IsDead) then
		if (UnitCanAttack(unit, "player")) then
			if (PA:CheckMessageLevel("Core", 2)) then
				PA:Message4(PANZA_TARGET_CAN_ATTACK);
			end
			return false, true, "CanAttackMe";
		end

		if (not UnitCanCooperate("player", unit) and UnitIsPlayer(unit)) then
			if (PA:CheckMessageLevel("Core", 2)) then
				PA:Message4(PANZA_CANNOT_COOP_TARGET);
			end
			return false, true, "CannotCoop";
		end

		------------------------
		-- Check for Phase Shift
		------------------------
		if (PA:UnitHasBlessing(unit, "impPS")) then
			if (PA:CheckMessageLevel("Core", 2)) then
				PA:Message4(PANZA_TARGET_PHASE_SHIFT);
			end
			return false, false, "DoNotBless", nil; -- can never bless this one
		end
		
		---------------------------------------
		-- Check if we are ignoring this player
		---------------------------------------
		if (PASettings.Switches.UseIgnore.enabled==true and UnitIsPlayer(unit) and PA:IsIgnored(name)) then
			if (PA:CheckMessageLevel("Core", 2)) then
				PA:Message4("(Panza) "..name.." is being Ignored.");
			end
			return false, true, "Ignored";
		end	
	
	end

	PA:Debug("  shortSpell=", shortSpell);
	if (shortSpell~=nil) then
		local InRange, State = PA:SpellCastableCheck(unit, shortSpell, checkActionRange);
		PA:Debug("  InRange=", InRange, " State=", State);
		return InRange, true, State;
	end

	return true, true, nil;

end


-------------------------
-- Onxxx methods
-------------------------
function PA:OnLoad()
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("PLAYER_LOGIN");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("PLAYER_LEAVING_WORLD");
	this:RegisterEvent("CHAT_MSG_WHISPER");
	this:RegisterEvent("UPDATE_CHAT_WINDOWS");	
end

function PA:VariablesLoaded()
	--PA:Message("VariablesLoaded");

	Panza = nil;

	PA.PlayerName = UnitName("player");
	if (PACurrentSpells==nil or PACurrentSpells.Indi==nil or PACurrentSpells.Group==nil
	 or PACurrentSpells.LastTime==nil or PACurrentSpells.LastTime>GetTime()) then
		PA:Debug("Resetting PACurrentSpells");
		PACurrentSpells = {Indi={}, Group={}, LastTime=GetTime()};
	end

	-- Correct Self Buff and group times with time we were logged off
	if (PASettings~=nil and PASettings.LeftWorld~=nil) then
		local TimeAway = GetTime() - PASettings.LeftWorld;
		--PA:ShowText("Time off=", TimeAway);
		local Set = PACurrentSpells.Indi[PA.PlayerName];
		if (Set~=nil) then
			for _, value in pairs(Set) do
				value.Time = value.Time + TimeAway;
			end
		end
		for Class, Set in pairs(PACurrentSpells.Group) do
			for Id, Info in pairs(Set) do
				Info.Time = Info.Time + TimeAway;
			end
		end
	end
	PA:CleanupSpells();

	PA:Message(format(PA_GREN..PANZA_WELCOME,PANZA_VERSION));

	SlashCmdList["PANZA"] = Panza_SlashHandler;
	SLASH_PANZA1 = "/panza";
	SLASH_PANZA2 = "/pa";
	QUEST_FADING_ENABLE = nil;

	-----------------------------
	-- 2.0 support for myAddOns 2
	-----------------------------
	if (myAddOnsFrame_Register) then
		myAddOnsFrame_Register(PanzaDetails,PanzaHelp);
	end

	------------------------------
	-- Stock Settings, new install
	------------------------------
	PA.ResetFlag = false;
	if (PASettings==nil or PAVersion==nil) then
		PA:Reset(true, true);
		PA.ResetFlag = true;
	end

	------------------------------------
	-- Initialize (Save) Mouse Functions
	------------------------------------
	if (PASettings~=nil and PASettings.Switches~=nil and PASettings.Switches["clickmode"] ~=nil and PASettings.Switches["clickmode"].enabled == true) then
		PA:InitClickMode();
	end
end

-- Rebind the WoW UI Errors Frame OnEvent function
function PA:RebindErrorMessages()
	if (PA.UIErrorsFrame_OnEvent_Original==nil) then
		PA.UIErrorsFrame_OnEvent_Original = UIErrorsFrame_OnEvent;
		UIErrorsFrame_OnEvent = function(event, messageText)
			if (event=="UI_ERROR_MESSAGE") then
				if (PA:CheckMessageLevel("Core", 5)) then
					PA:Message4("WoW Error message! Message="..tostring(messageText));
				end
				local CastWhileMoving = format(CAST_WHILE_MOVING, "");
				if (messageText==SPELL_FAILED_MOVING or string.find(CastWhileMoving, messageText)~=nil) then
					if (PA.Cycles.Spell.Active.target~="blank"
					and PASettings.Heal.HoTOnMove==true
					and PA.Cycles.Spell.Type=="Heal") then
						if (PA:CheckMessageLevel("Heal", 4)) then
							PA:Message4("Healing Moving Violation, supress WoW error");
						end
						return;
					end
				end
			end
			PA.UIErrorsFrame_OnEvent_Original(event, messageText);
		end
	end
end

function PA:PlayerLogin()
	PA.WSG = {};
	--PA:Message("PlayerLogin");
	if (PA.ResetFlag==true or _Paladin_is_Ready~=true) then

		if (PA:CheckMessageLevel("Core", 2)) then
			PA:Message4(PANZA_INITIALIZING);
		end

		---------------------------
		-- Make windows ESCable
		---------------------------
		--PA:ShowText("ESCable #Frames=", (PA:TableSize(PA.GUIFrames)));
		for FrameName, Frame in pairs(PA.GUIFrames) do
			--PA:ShowText("Frame=", FrameName);
			table.insert(UISpecialFrames, FrameName);
		end
		
	
		PA:ButtonUpdatePicture();
		UpdateSpells();
		PA:SetupClasses();
		PA:SetupDCB();
		PA:SetupPCS();
		PA:SetupPFM();
		PA:SetupPHMBias();
		PA:SetupPCM();
		PA:SetupPanic();
		-- Must reset again because Faction may not have been set properly
		if (PA.ResetFlag==true) then
			PA:Reset(true, false);
			PA.ResetFlag = false;
		end

		if (PA:CheckMessageLevel("Core", 4)) then
			PA:Message4(PANZA_UPDATE_SPELL_DB);
		end
		PA:SetupSpells();
		local count = PA:ScanSpellbook();
		PA:SetupBuffs();
		PA:CreateMacros(true); -- Change macro bodies for cooldowns
		if (PA:CheckMessageLevel("Core", 2)) then
			PA:Message4(format(PANZA_INITIALIZATION_COMPLETE, count));
		end

		PA:CheckAllDCB();
		PA:SetupRez();

		-------------------------------------------------------------------------------
		-- Temp global flag, remove it after testing and move to Paladin.Settings Perm.
		-------------------------------------------------------------------------------
		_MapLibrary = PASettings.Switches.EnableMLS;

		-----------------------------------------------------------
		-- Now Check the Class of Player and see if we can continue
		-----------------------------------------------------------
		if (PA.AllowedClasses[PA.PlayerClass]~=true) then
			PASealMenu_MainFrame:Hide();
			PASealMenu_MenuFrame:Hide();
			local ClassList = "";
			local Sep = "";
			for key, value in pairs(PA.AllowedClasses) do
				ClassList = ClassList..Sep..key;
				Sep = ", ";
			end
			PA:Message("PA is not suited for a "..PA.PlayerClass..", only "..ClassList.."s may use PA. Unloading.");
			PASettings.Valid = false;
			PA:ButtonToggle();

			this:UnregisterEvent("VARIABLES_LOADED");
			this:UnregisterEvent("PLAYER_LOGIN");
			this:UnregisterEvent("PLAYER_ENTERING_WORLD")
			this:UnregisterEvent("PLAYER_LEAVING_WORLD")
			this:UnregisterEvent("CHAT_MSG_WHISPER");
			for _, Event in pairs(PA.Events) do
				this:UnregisterEvent(Event);
			end

			PanzaFrame:Hide();
			PanzaTreeFrame:Hide();
			PanzaButtonFrame:Hide();
			SlashCmdList["PANZA"] = nil;
			return;
		end
		
		PA:BuildOptionsMenuTree();		
		PA:RebindErrorMessages();

		if (PASettings.LastRaidState==nil) then
			PASettings.LastRaidState = PA:IsInRaid();
		end

		PA:Error("[ "..PANZA_TITLE.." - "..PANZA_VERSION.." ]");

		------------------
		--Check the Config
		------------------
		if (not PA:CheckConfig()) then
			PA:Message("Configuration check failed!");
			PA:Reset(false);
		end

		PA:Initialize();

		--------------------------------------------------------------------
		-- Register with the PanzaComm Addon for cooperative healing support
		-- Register Panza as Send/Receive = 1
		-- Let Panza process messages intended for Genesis, Heart, QuickHeal
		-- Panza uses the same message format.
		-- Register all other addons as Receive Only = 2
		-- Register on the Configured Destination
		--------------------------------------------------------------------
		if (type(PanzaComm_Register)=="function") then
			PanzaComm_Register("Panza", Panza_CoopRcvr, 1, PASettings.Heal.Coop.Channel);
			PanzaComm_Register("Genesis", Panza_CoopRcvr, 2, PASettings.Heal.Coop.Channel);
			PanzaComm_Register("Heart", Panza_CoopRcvr, 2, PASettings.Heal.Coop.Channel);
			PanzaComm_Register("QuickHeal", Panza_CoopRcvr, 2, PASettings.Heal.Coop.Channel);
		end
		
		-------------------------
		-- Panic reverse look-ups
		-------------------------
		PA.PanicLookup = {};
		for key, value in pairs(PASettings.PanicClass) do
			--PA:Message(PA_GREN..key..""..PA_WHITE.." - "..PA_BLUE..""..value);
			PA.PanicLookup[value] = key;
		end

		-----------------------------------------------
		-- Modify Localizations that are class specific
		-----------------------------------------------
		PA:ModifyUIClass(PA.PlayerClass)

		------------------------------
		-- Lock or Unlock Healing Bars
		------------------------------
		PanzaFrame_HealCurrentSpell.isLocked = PASettings.Heal.BarsLocked;
		PanzaFrame_HealBars1.isLocked = PASettings.Heal.BarsLocked;

		---------------------------------------
		-- Set Mouse functions based on setting
		---------------------------------------
		if (PASettings.Switches["clickmode"].enabled == true and PA.MouseInitialized==true) then
			PA:setClickMode(PASettings.Switches.clickmode.enabled);
		end
		
		if (PA.UnitTesting~=true) then
			PAState={};
		end	
	end
end


function PA:PlayerEnteringWorld()
end

function PA:OnEvent()

	if (event == "VARIABLES_LOADED") then
		PA:VariablesLoaded();

	elseif (event == "PLAYER_LOGIN") then

		PA:PlayerLogin();

	elseif (event == "PLAYER_LEAVING_WORLD") then
		PASettings.LeftWorld = GetTime();
		for _, Event in pairs(PA.Events) do
			this:UnregisterEvent(Event);
		end

	elseif (event == "PLAYER_ENTERING_WORLD") then
		for _, Event in pairs(PA.Events) do
			this:RegisterEvent(Event);
		end

		PA:PlayerEnteringWorld();

	elseif (event == "RAID_ROSTER_UPDATE") then
		local RaidState = PA:IsInRaid();
		if (PASettings.LastRaidState==nil) then
			PASettings.LastRaidState = RaidState;
			return;
		end
		if (PASettings.LastRaidState~=RaidState) then
			--Clear group spells
			if (PACurrentSpells~=nil) then
				--PA:ShowText("Raid state change, clearing group spells");
				PACurrentSpells.Group = {};
			end
			PASettings.LastRaidState = RaidState;
			return;
		end

	elseif (event == "UPDATE_CHAT_WINDOWS") then
		PA.UpdateChat.Timer = 0;
		PA.UpdateChat.Changed = true;

	elseif (event == "CHARACTER_POINTS_CHANGED") then
		--PA:ShowText(event, " arg1=", arg1, " arg2=", arg2);
		if (arg1==-1) then
			PA.Spells.Changed = true;
			PA.Spells.ChangedTimer = 0;
		end

	--elseif (event == "CURSOR_UPDATE") then
	--if (PA:CheckMessageLevel("Core", 1)) then
		--	PA:Message4("CURSOR_UPDATE");
	--end
	--	if (PA.ActionPickup==true) then
	--if (PA:CheckMessageLevel("Core", 1)) then
		--		PA:Message4("AB Put-down");
	--end
	--	end
	--	PA.ActionPickup = false;

	elseif (event == "ACTIONBAR_HIDEGRID") then
		if (PA:CheckMessageLevel("Core", 5)) then
			PA:Message4(event.." LastId="..tostring(PA.ActionBarLastId));
		end
		local ActionRemoved = false;
		if (PA.ActionBarLastId~=nil) then
			ActionRemoved = (HasAction(PA.ActionBarLastId)==nil);
		end
		if (ActionRemoved) then
			if (PA:CheckMessageLevel("Core", 5)) then
				PA:Message4("ActionRemoved");
			end
			PA:UpdateActionForSlot(PA.ActionBarLastId)
			PA.ActionBarDrop = false;
		else
			PA.ActionBarDrop = true;
		end

	elseif (event == "ACTIONBAR_SLOT_CHANGED") then
		local ActionBarDrop = PA.ActionBarDrop;
		PA.ActionBarDrop = false;
		if (_Paladin_is_Ready==true) then
			PA.ActionBarLastId = arg1;
			if (PA:CheckMessageLevel("Core", 5)) then
				PA:Message4("Action slot changed slot="..tostring(arg1));
			end
			if (PA.UpdateActionBar.Changed~=true and ActionBarDrop==true) then			
				PA:UpdateActionForSlot(arg1)
			end
		end

	elseif (event == "PLAYER_ENTER_COMBAT") then
		if (PA:CheckMessageLevel("Core", 5)) then
			PA:Message4("Entering Combat");
		end
		PA.InCombat = true;
		PA.ForceCombat = false;

	elseif( event == "PLAYER_LEAVE_COMBAT" ) then
		if (PA:CheckMessageLevel("Core", 5)) then
			PA:Message4("Leaving Combat");
		end
		if (PA.ForceCombat) then
			if (PA:CheckMessageLevel("Core", 5)) then
				PA:Message4("Forcing Combat");
			end
			AttackTarget();
		end
		PA.InCombat = false;
		PA.ForceCombat = false;

	elseif (event=="DUEL_FINISHED") then
		if (PA:CheckMessageLevel("Core", 5)) then
			PA:Message4("Duel Finished");
		end
		PA.Dueling = false;

	elseif (event=="DUEL_INBOUNDS") then
		if (PA.Dueling==false) then
			if (PA:CheckMessageLevel("Core", 5)) then
				PA:Message4("Duel Started");
			end
			PA.Dueling = true;
		end

	------------------------------------------
	-- 1.21 Addition. Track Spellcasting (PAM)
	------------------------------------------
	elseif (event == "SPELLCAST_START") then
		PA:SpellcastStart();

	elseif (event == "SPELLCAST_DELAYED") then
		PA:SpellcastDelayed();

	elseif (event == "SPELLCAST_INTERRUPTED") then
		PA:SpellcastInterrupted();

	elseif (event == "SPELLCAST_STOP") then
		PA:SpellcastStop();

	elseif (event == "SPELLCAST_FAILED") then
		PA:SpellcastFail();

	elseif (event == "PLAYER_DEAD") then
		if (PA:CheckMessageLevel("Core", 5)) then
			PA:Message4(PA_RED.."You are dead!");
		end
		PA:RemoveUnitSpell("player");
		PanzaFrame_HealCurrent:Hide();

	elseif (event == "UNIT_HEALTH") then
		-----------------------------------------
		-- 2.1 Check group members that have died
		-----------------------------------------
		if (arg1~=nil) then
			-- Hunters with Feign Death will have a detectable Buff
			if (UnitIsDeadOrGhost(arg1) and UnitBuff(arg1, 1)==nil) then
				if (PA:CheckMessageLevel("Core", 5)) then
					PA:Message4(PA_RED..arg1.." is dead!");
				end
				PA:RemoveUnitSpell(arg1);
				return;
			end
			-- Any change in health means unit is alive
			local Name = PA:UnitName(arg1);
			if (Name~="target") then
				PA.Rez[Name] = nil;
			end
		end

	------------------------
	-- 2.0 ItemBonus Support
	------------------------
	elseif (event == "UNIT_INVENTORY_CHANGED") then
		PA.Inventory.Timer = 0;
		PA.Inventory.Changed = true;
		PA:UpdateComponents();

	------------------------
	-- 2.1 Spell failures
	------------------------
	elseif (event == "CHAT_MSG_SPELL_FAILED_LOCALPLAYER") then
		if (PA:CheckMessageLevel("Core", 1)) then
			--PA:Message4(PA_RED.."Spell Failed: "..PA_YEL..arg1);
		end
		PA.LastFailedSpell = arg1;

	------------------------------
	-- 3.0 Process Wisper Requests
	------------------------------
	elseif (event == "CHAT_MSG_WHISPER") then
        if (arg1 and arg2) then
            PA:ProcessWhisper(arg2, arg1);
		end

	-------------------
	-- 3.0 Spell damage
	-------------------
	elseif (event == "CHAT_MSG_SPELL_SELF_DAMAGE") then
        if (arg1~=nil) then
			MarsMessageParser_ParseMessage("Panza", arg1);
		end

	elseif (event == "LEARNED_SPELL_IN_TAB") then
			--PA:ShowText(event, " arg1=", arg1, " arg2=", arg2);
			PA.Spells.Changed = true;
			PA.Spells.ChangedTimer = 0;

	elseif (event=="CHAT_MSG_BG_SYSTEM_ALLIANCE" or event=="CHAT_MSG_BG_SYSTEM_HORDE" or event=="CHAT_MSG_BG_SYSTEM_NEUTRAL") then
		if (PA:IsInWSG()) then
			--PA:ShowText("WSG:", arg1);
			PA:ProcessWSGChat(arg1);
			--for Faction, Name in pairs(PA.WSG) do
			--	PA:ShowText(Faction, " flag: ", Name);
			--end
		end
	end
end

--------------------------------------------
-- Timer update function
-- The elapsed time is fractions of a second
--------------------------------------------
function PA:OnUpdate(elapse)

	if (_Paladin_is_Ready == true) then
		PA.Inventory.Timer				= (PA.Inventory.Timer or 0) + elapse;
		PA.Spells.ChangedTimer          = (PA.Spells.ChangedTimer or 0) + elapse;
		PA.UpdateActionBar.Timer   		= (PA.UpdateActionBar.Timer or 0) + elapse;
		PA.SpellBookCheck.Timer   		= (PA.SpellBookCheck.Timer or 0) + elapse;
		PA.OffenseTimer   				= (PA.OffenseTimer or 0) + elapse;
		PA.GroupBuffTimer   			= (PA.GroupBuffTimer or 0) + elapse;
		PA.Cycles.Near.Timer  			= (PA.Cycles.Near.Timer or 0) + elapse;
		PA.Cycles.Spell.CoopTimer 		= (PA.Cycles.Spell.CoopTimer or 0) + elapse;
		PA.Cycles.Spell.HoTimer			= (PA.Cycles.Spell.HoTimer or 0) + elapse;
		PA.Cycles.Spell.BuffCheckTimer	= (PA.Cycles.Spell.BuffCheckTimer or 0) + elapse;
		PA.Cycles.Spell.HealCheckTimer	= (PA.Cycles.Spell.HealCheckTimer or 0) + elapse;
		PA.Cycles.Spell.BarsCheckTimer  = (PA.Cycles.Spell.BarsCheckTimer or 0) + elapse;
		PA.Cycles.Spell.BarsTestTimer	= (PA.Cycles.Spell.BarsTestTimer or 0) + elapse;

		-----------------------------------------------
		-- Reset Spells
		-----------------------------------------------
		if (PA.Cycles.Near.Timer >= 60) then
			PACurrentSpells.LastTime = GetTime();
			if (PA:CheckMessageLevel("Bless", 4)) then
				PA:Message4(PA_WHITE.."Clean-up spell list");
			end
			PA:CleanupSpells();
			PA.Cycles.Near.Timer = 0;

			--PA:ShowText("autoSelfCast=", GetCVar("autoSelfCast"));
			-------------------------------
			-- Check Auto Self Cast setting
			-------------------------------
			if (GetCVar("autoSelfCast")=="1") then
				PA:Message(PA_RED.."PANZA WARNING! The Blizzard setting Auto Self Cast must be off for Panza to function");
				PA:Message("Setting Blizzard setting Auto Self Cast to OFF");
				SetCVar("autoSelfCast", 0);
			end

		end
		-------------------------------------------------------------------------------
		-- Update group buff counts, anytime before the global cool-down should be fine
		-- but must leave enough time for newly cast buffs to register
		-------------------------------------------------------------------------------
		if (PA.GroupBuffTimer >= 0.5) then
			PA:UpdateGroupBuffs();
			PA.GroupBuffTimer = 0;
		end

		-----------------------
		-- Seal Menu Prediction
		-----------------------
		if (PA.OffenseTimer >= 0.5) then
			if (PASealMenu_MainFrame~=nil and PASettings.SealMenu.Visible==true and PASealMenu_MainFrame:IsVisible() and PA.PlayerClass=="PALADIN") then
				if (PASettings.SealMenu.Text~="off") then
					PA:SealPredict();
					local NextText = "";
					local TextFrame;
					local OtherTextFrame;
					if (PASettings.SealMenu.Text=="top") then
						TextFrame = PASealMenu_MainFrameNextTextTop;
						OtherTextFrame = PASealMenu_MainFrameNextTextBottom;
					else
						TextFrame = PASealMenu_MainFrameNextTextBottom;
						OtherTextFrame = PASealMenu_MainFrameNextTextTop;
					end
					if (not TextFrame:IsShown()) then
						TextFrame:Show();
					end
					if (OtherTextFrame:IsShown()) then
						TextFrame:Hide();
					end
					if (PA.Offense~=nil and PA.Offense.NextAction~=nil and PA.Offense.NextActionTime~=nil) then
						local Spell = PA:GetSpellProperty(PA.Offense.NextAction, "Name");
						if (Spell~=nil) then
							NextText = Spell;
						else
							NextText = PA.Offense.NextAction;
						end
						if (PA.Offense.NextActionTime<0.5) then
							TextFrame:SetTextColor(0.3, 1.0, 0.3);
						else
							TextFrame:SetTextColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
							NextText = NextText.." "..format("%.0f", PA.Offense.NextActionTime).."s";
						end
					end
					TextFrame:SetText(NextText);
				end
			end
			PA.OffenseTimer = 0;
		end

		-------------------------------------------------------------------
		-- Abort Heals (if enabled) when health is above OverHeal Threshold
		-------------------------------------------------------------------
		if (PA.Cycles.Spell.HealCheckTimer >= 0.30
			and PASettings.Heal.Abort.enabled
			and PA.Cycles.Spell.Type == "Heal"
			and PA.Cycles.Spell.Active.target
			and UnitHealth(PA.Cycles.Spell.Active.target) > 1
			and ((UnitHealth(PA.Cycles.Spell.Active.target) + PA:OtherHealing(PA.Cycles.Spell.Active.target)) / UnitHealthMax(PA.Cycles.Spell.Active.target) >= PASettings.Heal.OverHeal)) then
			PA.Cycles.Spell.Abort = true;
			if (PA.Cycles.Spell.AbortMsg == false) then
				  PA:Error("Healing to > "..(PASettings.Heal.OverHeal * 100).."% health warning on "..PA:UnitName(PA.Cycles.Spell.Active.target));
				  PA.Cycles.Spell.AbortMsg = true;
			end
			PA.Cycles.Spell.HealCheckTimer = 0;
		end

		------------------------------------------------------------------
		-- Cooperative Healing Support
		------------------------------------------------------------------
		if (PA.Cycles.Spell.CoopTimer >= 0.25) then -- Once per .25 sec
			PA:CoopHealing();
			PA.Cycles.Spell.CoopTimer = 0;	-- Reset the timer after the loop has completed.
		end

		---------------------------------------------------------------------
		-- Every 8 seconds check for stuck bars and remove them.
		-- Only Check the bars when not testing,
		---------------------------------------------------------------------
		if (PA.BarTest==false and PA.Cycles.Spell.BarsCheckTimer > 8.0) then

			--PA:ShowAction(2);
			--PA:ShowAction(43);
			--PA:ShowAction(44);

			PA:ResetHealingBars();
			PA.Cycles.Spell.BarsCheckTimer = 0;
		end

		-----------------------------------------------------------------------------
		-- If the bars are being set, expire the Current Healing Bar after 10 seconds
		-- otherwise make the current heal bar a little interesting....
		-- Heal Spell is Players Highest Rank Spell.
		-- Player is given 40% health and each update takes off.
		-- between 1 HP and 5% max health over the 15 second simulation.
		-- Current Heal Test Bars are updated every 0.25 seconds.
		-----------------------------------------------------------------------------
		if (PA.Cycles.Spell.BarsCheckTimer > 15.0 and PA.BarTest==true) then
			PanzaFrame_HealCurrent:Hide();
			if (PASettings.Heal.Bars.OwnBars == true) then
				PanzaFrame_HealCurrentSpell.isLocked=1;
				PASettings.Heal.BarsLocked = 1;
			end
			if (PASettings.Heal.Bars.OtherBars == true) then
				PanzaFrame_HealBars1.isLocked=1;
				PASettings.Heal.BarsLocked = 1;
			end
			PA:PHMAdvanced_UpdateBarLock();
			PA.BarTest=false;

		elseif (PA.Cycles.Spell.BarsTestTimer > 0.25 and PA.BarTest==true) then
			if (PASettings.Heal.Bars.OwnBars == true) then
				local maxrank, expected, book = nil, nil, nil;
				if (PA:SpellInSpellBook("GREATERHEAL")) then
					maxrank = PA:TableSize(PA.SpellBook["GREATERHEAL"]);
					book = "GREATERHEAL";
					-- PA:Message("Using Greater Heal Spells");
				elseif (PA:SpellInSpellBook("HEAL")) then
					maxrank = PA:TableSize(PA.SpellBook["HEAL"]);
					book = "HEAL";
					-- PA:Message("Using Heal Spells");
				elseif (PA:SpellInSpellBook("LESSERHEAL")) then
					maxrank = PA:TableSize(PA.SpellBook["LESSERHEAL"]);
					book = "LESSERHEAL";
					-- PA:Message("Using Lesser Heal Spells");
				end

				if (maxrank==nil) then
					maxrank=1;
					PA:Message("Maxrank was nil, set to 1");
				end

				if (PA.SpellBook[book] ~= nil and PA.SpellBook[book][maxrank] ~= nil and PA.SpellBook[book][maxrank].Min ~= nil and PA.SpellBook[book][maxrank].Max~=nil) then
					expected = math.floor(PA.SpellBook[book][maxrank].Min + ((PA.SpellBook[book][maxrank].Max - PA.SpellBook[book][maxrank].Min) / 2));
				else
					expected = 100;
				end

				local current = math.floor(UnitHealth("player") * 0.40) - math.random(1, UnitHealthMax("player") * 0.05);
				local after = current + expected;
				local max = UnitHealthMax("player");

				PanzaFrame_HealCurrentSpell:SetValue(15-PA.Cycles.Spell.BarsCheckTimer);
				PanzaFrame_HealCurrentTarget:SetValue(current);
				PanzaFrame_HealCurrentTargetText:SetText(PA.PlayerName .. " (" .. current .."/"..max.." " ..math.floor(((current/max) * 100)).."% ) ");
				PanzaFrame_HealCurrentAfter:SetValue(after);
				PanzaFrame_HealCurrentAfterText:SetText(after .. " (" .. math.floor(((after/max)*100)) .."%)");
			end
			PA.Cycles.Spell.BarsTestTimer = 0;
		end

		----------------------------------------------------------------------------------
		-- Buff Expire Warning System (BEWS)
		-- The system will warn you 3 times (at 10 second Internals) past the initial warning,
		-- and if you let the buffs expire we issue a final warning and shut up.
		-- Do not time short duration buffs
		-- Panza_Reset() can be used during operation, so monitor _Paladin_is_Ready
		----------------------------------------------------------------------------------
		if (PA.Cycles.Spell.BuffCheckTimer >= 1.0) then

			if (_Paladin_is_Ready==true) then
				if (PASettings.Switches.EnableWarn==true) then

					-- Normal blessings
					PA:CheckBEWS();

					if (PASettings.Switches.GreaterBlessings.Warn==true) then
						-- Group blessings
						--PA:ShowText("Checking Group blessings");
						PA:CheckGroupBEWS();
					end
				end
			end

			PA.Cycles.Spell.BuffCheckTimer = 0;
		end

		------------------------------------------------------------------------------------------------------
		-- Item Bonus Support. Give the app a couple of seconds to update, then update our display (if its up)
		------------------------------------------------------------------------------------------------------
		if (PA.Inventory.Timer >= 2.0 and PA.Inventory.Changed == true) then
			PA.Inventory.Changed = false;
			if (PA:CheckMessageLevel("HEAL",3)) then
				-- PA:Message4(PANZA_MSG_INVENTORY_CHANGED);
			end
			if (PanzaSTAFrame:IsVisible()) then
				PA:STA_SetValues();
			end
		end

		--------------------------------------------------------------------------------------
		-- Chat Frame Support. Give a couple of seconds to update, then update our frame names
		--------------------------------------------------------------------------------------
		if (PA.UpdateChat.Timer >= 2.0 and PA.UpdateChat.Changed == true) then
			PA.UpdateChat.Changed = false;

			-- Recan and store Frame Names
			PA:UpdateChatFrames();

			-- Update PAM if UP
			if (PanzaPAMFrame:IsVisible()) then
			  PA:PAM_SetValues();
			end
		end

		----------------------------------------------------------------------------------
		-- Spell Updates Occured. Give the WoW client a few of seconds to get tooltips set
		----------------------------------------------------------------------------------
		if (PA.Spells.ChangedTimer>=3.0 and PA.Spells.Changed==true) then
			UpdateSpells();
			--PA:ShowText("Spell RESCAN");
			--if (PA.SpellCheckCount==1) then
			--	PA:ShowText("Spell RESCAN");
			--end
			PA.Spells.Changed = false;
			PA:ScanSpellbook();
			PA:SetupBuffs();
			PA:InitializeSpellSearch();
			PA.UpdateActionBar = {Timer=0, Changed=true}; -- Signal ActionBar rescan
			PA:CreateMacros(true); -- Change macro bodies for new spells
			PA:CheckAllDCB();
			PA:InitializeSealMenu();
			PA:BuildOptionsMenuTree(); -- New spells may open-up new menu options
			PA.SpellBookCheck = {Timer=0}; -- Reset check timer
		end

		-----------------------------------------------
		-- Rescan ActionBar
		-----------------------------------------------
		if (PA.UpdateActionBar.Timer>=3 and PA.UpdateActionBar.Changed==true) then
			if (PA:CheckMessageLevel("Core", 4)) then
				PA:Message4("ActionBar RESCAN");
			end
			PA:SearchActionBar();
			PA.UpdateActionBar = {Timer=0, Changed=false};
		end

		-----------------------------------------------
		-- Check SpellBook
		-----------------------------------------------
		if (PA.SpellBookCheck.Timer>=1) then
			--PA:ShowText("SpellBookCheck Changed=", PA.Spells.Changed, " Verified=", PA.SpellBookVerified, " CheckSpell=", PA.CheckSpell);
			-- Check if last spell-scan was fubar and signal rescan if it is
			if (PA.Spells.Changed==false and PA.SpellBookVerified==false and PA.CheckSpell~=nil and PA.SpellCheckCount<20) then
				if (((PA.CheckSpell.Dur==true and PA:GetSpellProperty(PA.CheckSpell.Short, "Duration")==nil) or PA:GetSpellProperty(PA.CheckSpell.Short, "Mana", PA:GetSpellProperty(PA.CheckSpell.Short, "MinRank"))==nil or PA:GetSpellProperty(PA.CheckSpell.Short, "Range")==nil)) then
					UpdateSpells();
					if (PA.SpellCheckCount==0) then -- First time
						local Reason = "";
						if (not PA:SpellInSpellBook(PA.CheckSpell.Short)) then
							Reason = "Spell "..PA.CheckSpell.Short.." missing from spell-book";
						elseif (PA:GetSpellProperty(PA.CheckSpell, "Duration")==nil) then
							Reason = "Spell "..PA.CheckSpell.Short.." Duration is nil";
						elseif (PA:GetSpellProperty(PA.CheckSpell, "Mana", PA:GetSpellProperty(PA.CheckSpell.Short, "MinRank"))==nil) then
							Reason = "Spell "..PA.CheckSpell.Short.." Mana is nil";
						elseif (PA:GetSpellProperty(PA.CheckSpell, "Range")==nil) then
							Reason = "Spell "..PA.CheckSpell.Short.." Range is nil";
						end
						PA:DisplayText("Panza SpellBook FUBAR!!! ", Reason);
					end
					--PA:ShowText("Exists=", PA:SpellInSpellBook(PA.CheckSpell.Short), " Dur=", PA:GetSpellProperty(PA.CheckSpell.Short, "Duration"), " Mana=", PA:GetSpellProperty(PA.CheckSpell.Short, "Mana", PA:GetSpellProperty(PA.CheckSpell.Short, "MinRank")), " Range=", PA:GetSpellProperty(PA.CheckSpell.Short, "Range"));
					PA.Spells.ChangedTimer = 0;
					PA.Spells.Changed = true;
					PA.SpellCheckCount = PA.SpellCheckCount + 1;
				else
					--PA:ShowText("OK Exists=", PA:SpellInSpellBook(PA.CheckSpell.Short), " Dur=", PA:GetSpellProperty(PA.CheckSpell.Short, "Duration"), " Mana=", PA:GetSpellProperty(PA.CheckSpell.Short, "Mana", PA:GetSpellProperty(PA.CheckSpell.Short, "MinRank")), " Range=", PA:GetSpellProperty(PA.CheckSpell.Short, "Range"));
					PA.SpellCheckCount = 0;
					PA.SpellBookVerified = true;
				end
			end
			PA.SpellBookCheck = {Timer=0};
		end

		PA:SealMenu_InventoryFrame_OnUpdate(elapse);
		PA:SealMenu_MenuFrame_OnUpdate(elapse);
		PA:SealMenu_ScalingFrame_OnUpdate(elapse);
		PA:SealMenu_DockingFrame_OnUpdate(elapse);
		PA:SealMenu_CooldownCountFrame_OnUpdate(elapse);

	end
end

function PA:ProcessWSGChat(text)
	if (text==nil) then
		return;
	end
	local _, _, Faction, Who = string.find(text, PANZA_WSG_PICKED_MATCH);
	if (Who~=nil) then
		--PA:ShowText(Faction, " Flag pickup by ", Who);
		PA.WSG[PA.FactionEn[Faction]] = Who;
		return;
	end
	_, _, Faction, Who = string.find(text, PANZA_WSG_DROPPED_MATCH);
	if (Who~=nil) then
		--PA:ShowText(Faction, " Flag dropped by ", Who);
		PA.WSG[PA.FactionEn[Faction]] = nil;
		return;
	end
	_, _, Who, Faction = string.find(text, PANZA_WSG_CAPTURE_MATCH);
	if (Who~=nil) then
		--PA:ShowText(Faction, " Flag captured by ", Who);
		PA.WSG[PA.FactionEn[Faction]] = nil;
		return;
	end
	if (string.find(text, PANZA_WSG_PLACED_MATCH)~=nil) then
		--PA:ShowText("Flags replaced");
		PA.WSG = {};
		return;
	end
end

function PA:TargetFriendlyFlag()
	if (PA.WSG[PA.EnemyFaction]~=nil) then
		if (PA:CheckMessageLevel("Core", 1)) then
			PA:Message4("Targeting Fiendly flag carrier "..PA.WSG[PA.EnemyFaction]);
		end
		TargetByName(PA.WSG[PA.EnemyFaction]);
	end
end

function PA:TargetEnemyFlag()
	if (PA.WSG[PA.Faction]~=nil) then
		if (PA:CheckMessageLevel("Core", 1)) then
			PA:Message4("Targeting Enemy flag carrier "..PA.WSG[PA.Faction]);
		end
		TargetByName(PA.WSG[PA.Faction]);
	end
end

function PA:CheckBEWSForUnit(unit)
	if (PASettings.Switches.BEWS.all==true or UnitIsUnit(unit, "player")) then
		return true;
	end
	if (unit=="target") then
		return false;
	end
	if (PASettings.Switches.BEWS.party==true and PA:IsInParty() and (UnitInParty(unit) or UnitIsUnit(unit, "player"))) then
		return true;
	end
	if (PASettings.Switches.BEWS.raid==true and PA:IsInRaid() and UnitInRaid(unit)) then
		return true;
	end
	return false;
end

-- Output a BEWS message if required
function PA:CheckBEWS()
	if (PACurrentSpells~=nil and PACurrentSpells.Indi~=nil and PA.SpellBook~=nil) then
		for Name, Set in pairs(PACurrentSpells.Indi) do
			--PA:Debug("Name=", Name);
			for Id, SpellInfo in pairs(Set) do
				-- Only do configured units
				if (PA:CheckBEWSForUnit(SpellInfo.Unit)) then
					-- Skip greater blessings, they are done elsewhere
					if (PA.SpellBook.GroupBuffs[SpellInfo.Short]==nil) then
						local Expired;
						Expired, SpellInfo.BewsLevel = PA:ReportBEWS(SpellInfo, Name);
						if (Expired) then
							PACurrentSpells.Indi[Name][Id] = nil;
						end
					end
				else
					break;
				end
			end
		end
	end
end

-- Output a Group BEWS message if required
function PA:CheckGroupBEWS()
	if (PACurrentSpells~=nil and PACurrentSpells.Group~=nil and PA.SpellBook~=nil) then
		for GroupId, Set in pairs(PACurrentSpells.Group) do
			--PA:Debug("GroupId=", GroupId);
			for Id, SpellInfo in pairs(Set) do
				--PA:ShowText(i, " ", Class, " ", SpellInfo.Short, " ", SpellInfo.Duration);
				local Expired;
				Expired, SpellInfo.BewsLevel = PA:ReportBEWS(SpellInfo, GroupId);
				if (Expired) then
					PACurrentSpells.Group[GroupId][Id] = nil;
				end
			end
		end
	end
end

-- Determine if we need to output a BEWS and do so if required
function PA:ReportBEWS(spellInfo, who)
	local Expired = false;
	--PA:Debug("Short=", spellInfo.Short);
	local Duration = PA:GetSpellProperty(spellInfo.Short, "Duration");
	--PA:Debug("Duration=", Duration);
	if (Duration==nil or Duration<300) then
		return false; -- Spells not set-up yet or buff is short one
	end
	local Level = spellInfo.BewsLevel;
	if (Level==nil) then
		Level = 0;
	end
	-- Skip warnings if we missed them
	local ExpireTime = spellInfo.Time + Duration;
	local EstimatedLevel = math.floor((GetTime() - ExpireTime + PASettings.Switches.Rebless) / 10);
	--PA:Debug("EstimatedLevel=", EstimatedLevel);
	if (EstimatedLevel>Level) then
		Level = EstimatedLevel;
	end
	local Message = nil
	if (Level<4) then
		local TimeLeft = PASettings.Switches.Rebless - Level * 10;
		local WarnTime = spellInfo.Time + Duration - TimeLeft;
		--PA:Debug("Id=", Id, " Time=", GetTime() - spellInfo.Time, " Dur=", Duration);
		if (WarnTime<=GetTime() and TimeLeft>0) then
			Message = format(PANZA_WARN_EXPIRE, who, spellInfo.Spell, TimeLeft);
			Level = Level + 1;
		end
	else
		if (ExpireTime<GetTime()) then
			Message = format(PANZA_WARN_EXPIRE_FINAL, who, spellInfo.Spell);
			Expired = true;
		end
	end
	if (Message~=nil) then
		if (PASettings.Switches.BEWS.sounds==true) then
			if (Expired==true) then
				PlaySound("TalentScreenClose");
			else
				PlaySound("TalentScreenOpen");
			end
		end
		PA:Error(Message);
		if (PA:CheckMessageLevel("Bless", 3)) then
			PA:Message4(Message);
		end
	end
	return Expired, Level;
end


--------------------------------------------------
-- Store Names of Chat Frames for use when picking
-- desired frame for Panza Messages
-- Autopick the frame named Panza if it exists.
--------------------------------------------------
function PA:UpdateChatFrames()
	PA.chatframe=nil;

	for i=1, NUM_CHAT_WINDOWS do
		local name = GetChatWindowInfo(i);
		if (i==1) then name="General"; end;
		if (i==2) then name="Combat"; end;

		PA.ChatFrames[name] = (PA.ChatFrames[name] or {});
		PA.ChatFrames[name].Id=i;

		if (string.lower(name) == "panza") then
			PA.chatframe = i;
		end
	end
end

function PA:ShowAction(id)
	local Text = GetActionText(id);
	PA:DisplayText(GetTime(), " ", id, " HasAction=", HasAction(id), " ActionText=", Text, " InRange=", IsActionInRange(id));
	if (Text==nil) then
		PA:ResetTooltip();
		PanzaTooltip:SetAction(id);
		local Tips = {};
		PA:CaptureTooltip(Tips);
		for i, v in pairs(Tips.Tooltip) do
			PA:DisplayText(i, " ", v);
		end
	end
end

function PA:UpdateGroupBuffs()
	PA:Debug("UpdateGroupBuffs");
	for BuffTime, BuffInfo in pairs(PA.GroupBuffs) do
		PA:Debug("GetTime=", GetTime(), " BuffTime=", BuffTime, " Name=", BuffInfo.Name, " Spell=", BuffInfo.Spell);
		if ((GetTime()-BuffTime)>1.0) then
			PA:StoreGroupBuffRecipients(BuffInfo.Target, BuffInfo.Name, BuffInfo.Spell, BuffInfo.ShortSpell, BuffInfo.CastClass, BuffInfo.SpellType);
			PA.GroupBuffs[BuffTime] = nil;
		end
	end
end

function PA:SetupClasses()
	PA.LocClass, PA.PlayerClass = UnitClass("player");
	PA["Faction"] = UnitFactionGroup("player"); -- This is locale independant i.e.always english

	--PA:Message("PA:SetupClasses");
	--PA:Message("Class="..PA.PlayerClass);
	--PA:Message("Faction="..tostring(PA.Faction));

	if (PA.Faction=="Alliance") then
		PA.HybridClass = "PALADIN";
		PANZA_HYBRID = PANZA_PALADIN;
		PA.EnemyFaction = "Horde";
	else
		PA.HybridClass = "SHAMAN";
		PANZA_HYBRID = PANZA_SHAMAN;
		PA.EnemyFaction = "Alliance";
	end
	--PA:Message("HybridClass="..PA.HybridClass);

	---------------------------------
	-- 2.1 Class name numeric lookups
	---------------------------------
	PA.ClassIndex = {PA["HybridClass"], "DRUID", "HUNTER", "MAGE", "PRIEST", "ROGUE", "WARLOCK", "WARRIOR"};
	PA.IndexClass = {};
	for key, value in pairs(PA.ClassIndex) do
		PA.IndexClass[value] = key;
	end
	if (PA.PlayerClass~="PALADIN") then
		if (PASettings.SealMenu~=nil) then
			PASettings.SealMenu.Visible = false;
		end
	end
end

-----------------------------------------------------------------------------------------------------------
-- Initialize Function
-- 1.2 Fix. In all Previous Versions, this function was broken until the player actually entered the world.
--	  This version uses a Marker to control how many times this function is run when PLAYER_ENTERING_WORLD
--	  occurs.
-----------------------------------------------------------------------------------------------------------
function PA:Initialize()
	local level = UnitLevel("player");

	if (level > 0) then

		-----------------------------------------------
		-- Ensure PA's tooltip function is called first
		-----------------------------------------------
		if (oldActionButton_SetTooltip==PA.ActionButton_SetTooltip) then
			local TempFunction = ActionButton_SetTooltip;
			ActionButton_SetTooltip = PA.ActionButton_SetTooltip;
			oldActionButton_SetTooltip = PA.OldActionButton_SetTooltip;
			PA.OldActionButton_SetTooltip = TempFunction;
		end

		-------------------------------------------------------------------------------
		-- Set the Initialize Marker after we did the first load and really initialized
		-------------------------------------------------------------------------------
		_Paladin_is_Ready = true;

		PA:InitializeSpellSearch();
		PA:SetupPAWTriggers();
		PA:SearchActionBar();
		PA:InitializeSealMenu();
		PA:UpdateComponents();

	end
end

----------------------------------------------------------------------------------------
-- 2.0 Get Base Healing Bonus +healing gear from BonusScanner (if Installed and Enabled)
----------------------------------------------------------------------------------------
function PA:HealingBonus(action)
	local value, txt 	= 0.0, "";
	local Ready, Enabled 	= 0, false;
	local support 		= {[0] = 'off',[1] = 'on'}
	local status  		= {[0] = 'is not', [1] = 'is'}

	------------------------------
	-- Perform the Function passed
	------------------------------
	if (not action) then action = 'STATUS' end

	if (action == 'TOGGLE') then
		PASettings.Heal.IB.enabled = (not PASettings.Heal.IB.enabled);
	end

	----------------------------------------
	-- Get the value. Part 1 of return Value
	----------------------------------------
	if (PASettings.Heal.IB.enabled == true) then
		Enabled = 1;

		if (BonusScanner ~= nil and
			BonusScanner.active ~= nil and
			BonusScanner.active == 1 and
			BonusScanner.bonuses and
			BonusScanner.bonuses["HEAL"] and
			PASettings.Heal.IB.BonusScan == true) then
			value = BonusScanner.bonuses["HEAL"];

			if (value == nil) then
				value = 0.0;
			end
		end
	else
		Enabled = 0;
	end

	--------------------------------
	-- Get the Addon Status and text
	--------------------------------
	if (BonusScanner ~= nil and BonusScanner.active ~= nil and BonusScanner.active == 1) then
		Ready = 1;
	else
		Ready = 0;
	end

	txt = format(PANZA_MSG_BONUSSCAN, support[Enabled], status[Ready], value);

	return value, txt;
end

-----------------------------------------------------
-- Panza Receiver for Coop Healing
-- PanzaComm will call this method every time someone
-- sends a message to the configured channel.
-----------------------------------------------------
function Panza_CoopRcvr(author, message)

	local bar, healtype = nil, nil;

	if (PA:CheckMessageLevel("Core",5)) then
		PA:Message4("(Coop) "..author.." sent "..message);
	end

	-- check for self, or this player is in the party or raid
	if (author==PA.PlayerName or not PA:FindUnitFromName(author)) then
		return;
	end

	-- PanzaComm_Message("Panza", "Update, " ..who.. ", " .. Spell .. ", " .. Heal .. ", " .. HoT .. ", " .. CastTime .. ", " .. TimeLeft);

	-- Extract healing message. This message could come from PA or Genesis.
	local start, stop, what, who, spell, heal, hot, casttime, timeleft = string.find(message, "^(.+), (.+), (.+), (%d+%.?%d*), (%d+%.?%d*), (%d+%.?%d*), (%d+%.?%d*)");

	-- message not understood
	if (not start) then return; end

	-- person being healed by author is not in party or raid
	if (not PA:FindUnitFromName(who)) then return; end

	-- If we have an existing target add to it
	PA.Healing[who] = (PA.Healing[who] or {});

	if (what == "Update") then
		-- general update:
		-- + someone started healing
		-- | or someone updated their casting time
		-- | or someone got delayed
		-- = we update the data
		heal = heal / 1.0;
		hot = hot / 1.0;
		casttime = casttime / 1.0;
		timeleft = timeleft / 1.0;

		if (hot > 0) then
			healtype="HOT";
		else
			healtype="HEAL"
		end

		if (PA.Healing[who][author]~=nil and PA.Healing[who][author][healtype] ~=nil and PA.Healing[who][author][healtype]["Bar"] ~=nil) then
			local bar = getglobal("Panza_HealBars" .. PA.Healing[who][author][healtype]["Bar"]);
			if (bar) then
				bar:SetMinMaxValues(666, 1337);
				bar:Hide();
			end
		end

		if (PA:CheckMessageLevel("Coop",3)) then
			PA:Message4("(CoOp): "..author.." healing "..who.." with "..spell.." for "..heal.." in "..casttime.." secs.");
		end

		-- Track HoT spells seperatly from heals so we don't overwrite hot data

		PA.Healing[who][author] = (PA.Healing[who][author] or {});

		PA.Healing[who][author][healtype] = {
				["Heal"] = heal,			-- amount expected
				["HoT"] = hot, 				-- amount total of Heal over Time
				["Spell"] = spell,			-- name of spell
				["Status"] = "Active",		-- Mark active
				["CastTime"] = casttime,	-- seconds to hit
				["TimeLeft"] = timeleft		-- secs left in casting or duration of hot
				};

	-- Else it's been completed, interrupted, failed, or aborted.
	else
		if (PA.Healing[who][author]["HEAL"] and PA.Healing[who][author]["HEAL"]["Status"] == "Active") then
			PA.Healing[who][author]["HEAL"]["Status"] = what;
			PA.Healing[who][author]["HEAL"]["TimeLeft"] = -1;
			if (PA.Healing[who][author] and PA.Healing[who][author]["HEAL"]["Bar"]) then
				local bar = getglobal("Panza_HealBars" .. PA.Healing[who][author]["HEAL"]["Bar"]);
				if (bar) then
					bar:SetMinMaxValues(666, 1337);
					bar:Hide();
				end
			end

		elseif (PA.Healing[who][author]["HOT"] and PA.Healing[who][author]["HOT"]["Status"] == "Active") then
			PA.Healing[who][author]["HOT"]["Status"] = what;
			PA.Healing[who][author]["HOT"]["TimeLeft"] = -1;
			if (PA.Healing[who][author] and PA.Healing[who][author]["HOT"]["Bar"]) then
				local bar = getglobal("Panza_HealBars" .. PA.Healing[who][author]["HOT"]["Bar"]);
				if (bar) then
					bar:SetMinMaxValues(666, 1337);
					bar:Hide();
				end
			end
		end
	end
end

function PA:ListAllHealing()
	local who, author, whodata, healtype = nil, nil, nil, nil;

	if (PA:CheckMessageLevel("Core",1)) then
		PA:Message4("All Healing Data");
	end

	for who, whodata in pairs(PA.Healing) do
		for author, authordata in pairs(PA.Healing[who]) do
			for healtype, typedata in pairs(PA.Healing[who][author]) do
				if (PA:CheckMessageLevel("Core",1)) then
					PA:Message4(who..", "..author..", "..healtype..","..PA.Healing[who][author][healtype].Spell.."."..PA.Healing[who][author][healtype].Heal);
				end
			end
		end
	end
end

function PA:ToggleWindowState()
	SetCVar("gxWindow", 1 - GetCVar("gxWindow"));
	ConsoleExec("gxRestart");
	PA:Message("Window state changed.");
end

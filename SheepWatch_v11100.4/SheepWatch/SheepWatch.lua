-- The idea of SheepWatch is orginally based on StunWatch by Vector.
-- 
-- The actual version got a rewrite in all relevant parts by
-- Andreas 'zapi' Broecking (Asmodean on Turalyon & Ania on Darksorrow)
-- 
-- Credits:
-- I hereby want to thank the authors of StunWatch, CastTime, MezHelper
-- and CTRA for some hints I got from their codes. The first version of
-- SheepWatch was released by Veighflo who resigned from developing it
-- after version 1.5
--
-- Version: 	11000.1
-- Date:		2006-03-38

--------------------------------------------------------
-- myAddOns support
--------------------------------------------------------
SheepWatchDetails = {
	name = "SheepWatch",
	version = "11000.1",
	releaseDate = "March 28, 2006",
	author = "zapi",
	email = "wow@gzipped.org",
	website = "http://www.curse-gaming.com/",
	category = MYADDONS_CATEGORY_CLASS,
	optionsframe = "SheepWatchConfig"
};

SheepWatchHelp = {};


--------------------------------------------------------
-- Initialization functions
--------------------------------------------------------
function SheepWatch_OnLoad()
	SheepWatch_Initialize();
	SheepWatch_EventRegister();
end

function SheepWatch_Initialize()
	SLASH_SHEEPWATCH1 = "/sheepwatch";
	SLASH_SHEEPWATCH2 = "/sheep";
	SLASH_SHEEPWATCH3 = "/sw";
	SlashCmdList["SHEEPWATCH"] = function(msg)
		SheepWatch_SlashCommandHandler(msg);
	end
	
	DEFAULT_CHAT_FRAME:AddMessage( SHEEPWATCH_TEXT_LOADED );
end

--------------------------------------------------------
-- Register the necessary UI API events.
--------------------------------------------------------
function SheepWatch_EventRegister()
--	this:RegisterEvent("ADDON_LOADED");
	this:RegisterEvent("PLAYER_LOGIN");
	this:RegisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE");
--	this:RegisterEvent("UNIT_AURA");
	this:RegisterEvent("CHAT_MSG_SPELL_BREAK_AURA");
	this:RegisterEvent("CHAT_MSG_SPELL_AURA_GONE_OTHER");
--	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE");
--	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE");
--	this:RegisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH");
	this:RegisterEvent("PLAYER_REGEN_ENABLED");
	this:RegisterEvent("PLAYER_DEAD");
	this:RegisterEvent("SPELLCAST_START");
	this:RegisterEvent("SPELLCAST_STOP");
	this:RegisterEvent("SPELLCAST_FAILED");
	this:RegisterEvent("SPELLCAST_INTERUPTED");
	this:RegisterEvent("PLAYER_TARGET_CHANGED");
end

--------------------------------------------------------
-- DEBUG Logging
--------------------------------------------------------
function SheepWatch_DebugLog(message)
	message = GetTime() .. " " .. message;
	DEFAULT_CHAT_FRAME:AddMessage("SW LOG: " .. message);
	local nn = table.getn(SheepWatch_Log);
	SheepWatch_Log[nn+1] = message;
end


--------------------------------------------------------
-- Handler for /sheepwatch
--------------------------------------------------------
function SheepWatch_SlashCommandHandler(msg)

	local a, b, command = string.find( msg, "(%w+)" );

	if( command == nil ) then
		SheepWatchConfig:Show();
		return;
	else
		command = string.lower( msg );
	end
	
	if( command == "unlock" ) then
		SHEEPWATCH.STATUS = 3;
		SheepWatch:Show();
		SheepWatchCounterText:SetText( "00.0s" );
		SheepWatchCounterText:Show();
		
		DEFAULT_CHAT_FRAME:AddMessage(SHEEPWATCH_TEXT_UNLOCKED);
		
	elseif( command == "lock" ) then
		SHEEPWATCH.STATUS = 1;
		SheepWatch:Hide();
		SheepWatchCounterText:Hide();
		DEFAULT_CHAT_FRAME:AddMessage(SHEEPWATCH_TEXT_LOCKED);
		
	elseif( command == "clear" ) then
		local pn = UnitName("player");
		if(pn ~= nil and pn ~= UNKNOWNBEING and pn ~= UKNOWNBEING and pn ~= UNKNOWNOBJECT) then
			SheepWatch_ClearProfile();
		else
			DEFAULT_CHAT_FRAME:AddMessage("SheepWatch: " .. SHEEPWATCH_TEXT_WORLD_NOT_LOADED);
		end

	elseif( command == "resetpos" ) then
		SHEEPWATCH.ALPHA = 1;
		SheepWatch_Settings.alpha = SHEEPWATCH.ALPHA;
		SheepWatch:ClearAllPoints();
		SheepWatch:SetPoint("CENTER", 0, 300);
		DEFAULT_CHAT_FRAME:AddMessage( SHEEPWATCH_TEXT_RESETPOS );
		
	elseif( command == "status" ) then
		SheepWatch_PrintStatus();

	elseif( command == "debug" ) then
		SHEEPWATCH.DEBUG = true;
		DEFAULT_CHAT_FRAME:AddMessage("SheepWatch: Debugging enabled for this session.");
	
	else
		SheepWatchConfig:Show();
	end
	
end


--------------------------------------------------------
-- Event handling
-- (Event handling rewritten and inspired by StunWatch)
--------------------------------------------------------
function SheepWatch_OnEvent(event)

	-- Don't do anything if SheepWatch isn't enabled
	if( SHEEPWATCH.STATUS == 0 and event ~= "PLAYER_LOGIN") then
		return
	end
	
	-- DEBUG
	--DEFAULT_CHAT_FRAME:AddMessage("SheepWatch: Event "..event);
	
	--SheepWatch_EventHandler[event](arg1, arg2, arg3, arg4, arg5);	
	SheepWatch_EventHandler[event](arg1, arg2);
end

SheepWatch_EventHandler = {}

SheepWatch_EventHandler["PLAYER_LOGIN"] = function()
		-- Register in myAddons
		if(myAddOnsFrame_Register) then
			myAddOnsFrame_Register(SheepWatchDetails, SheepWatchHelp);
		end
		-- Load the saved config
		SheepWatch_LoadVariables();
end

SheepWatch_EventHandler["UNIT_AURA"] = function()
	DEFAULT_CHAT_FRAME:AddMessage("UNIT_AURA triggered. Arg1: "..arg1);
end

SheepWatch_EventHandler["CHAT_MSG_SPELL_SELF_DAMAGE"] = function()
		local _, _, spell, mobname = string.find(arg1, SHEEPWATCH_EVENT_CAST);
		
		if( (mobname ~= nil and string.find(spell, SHEEPWATCH_SPELL) ) and ( UnitName("target") == mobname or ( SHEEPWATCH_TARGETCHANGED and SHEEPWATCH_POLYCASTED  ) ) ) then
			SHEEPWATCH_TARGETCHANGED = nil;
			SHEEPWATCH_POLYCASTED = nil;
			-- DEBUG
			if( SHEEPWATCH.DEBUG ) then
		 		DEFAULT_CHAT_FRAME:AddMessage("SheepWatch Debug:\nEvent CHAT_MSG_SPELL_SELF_DAMAGE triggered\nArgument: " .. arg1);
		 		SheepWatch_DebugLog("Event CHAT_MSG_SPELL_SELF_DAMAGE triggered. Argument: " .. arg1);
			end
			-- END DEBUG
		  if( SHEEPWATCH.VERBOSE ) then
		  	DEFAULT_CHAT_FRAME:AddMessage("SheepWatch: " .. SHEEPWATCH_SPELL .. " (" .. SHEEPWATCH.RANK .. ")" .. SHEEPWATCH_TEXT_ANNOUNCE_CAST .. mobname);
		  end
		  if( SHEEPWATCH.ANNOUNCE and SHEEPWATCH.ANNOUNCE_TIME_ID == 2) then
		  	SheepWatch_SendAnnounce(mobname, UnitLevel("target"));
		  end
			if( GetTime() > SHEEPWATCH.TIMER_END + 15 or mobname ~= SHEEPWATCH.MOBNAME ) then
				SHEEPWATCH.DIMINISH = 1;
				if( SHEEPWATCH.DEBUG ) then
					DEFAULT_CHAT_FRAME:AddMessage("SheepWatch Debug: Diminish set to: " .. SHEEPWATCH.DIMINISH);
				end	
			end
			SHEEPWATCH.MOBNAME = mobname;
			SHEEPWATCH.PLAYER = UnitIsPlayer("target");
			SHEEPWATCH.ACTIVE = 1;
			if( SHEEPWATCH.STATUS == 1 ) then
				SheepWatch:Show(); 
			else
				SheepWatch_OnShow();
			end
		end
end

SheepWatch_EventHandler["CHAT_MSG_SPELL_BREAK_AURA"] = function()		
		local currentTime = GetTime();
		local  _, _, mobname, spell = string.find(arg1, SHEEPWATCH_EVENT_BREAK);

		if( (mobname ~= nil and string.find(spell, SHEEPWATCH_SPELL) ) and mobname == SHEEPWATCH.MOBNAME ) then
			if ( SHEEPWATCH_TARGETCHANGED and SHEEPWATCH_POLYCASTED ) then
				SHEEPWATCH_TARGETCHANGED = nil; 
				SHEEPWATCH_POLYCASTED = nil;
				return
			end

			-- DEBUG
			if( SHEEPWATCH.DEBUG ) then
		 		DEFAULT_CHAT_FRAME:AddMessage("SheepWatch Debug:\nEvent CHAT_MSG_SPELL_BREAK_AURA triggered\nArgument: " .. arg1);
			end
			-- END DEBUG
		  if( SHEEPWATCH.VERBOSE ) then
		  	DEFAULT_CHAT_FRAME:AddMessage("SheepWatch: " .. SHEEPWATCH_TEXT_ANNOUNCE_BREAK  .. mobname);
		  end
			SHEEPWATCH.TIMER_END = currentTime;
			if( SHEEPWATCH.PLAYER ) then
				SHEEPWATCH.DIMINISH = SHEEPWATCH.DIMINISH * 2;
				if( SHEEPWATCH.DEBUG ) then
					DEFAULT_CHAT_FRAME:AddMessage("SheepWatch Debug: Diminish set to: " .. SHEEPWATCH.DIMINISH);
				end	
			end
			if( SHEEPWATCH.ACTIVE == 1 ) then
				SHEEPWATCH.ACTIVE = 0;
			end
		end
end

SheepWatch_EventHandler["CHAT_MSG_SPELL_AURA_GONE_OTHER"] = function()
		local currentTime = GetTime();
		local  _, spell, mobname = string.find(arg1, SHEEPWATCH_EVENT_FADE);
		if( (mobname ~= nil and string.find(spell, SHEEPWATCH_SPELL) ) and mobname == SHEEPWATCH.MOBNAME ) then

			-- DEBUG
			if( SHEEPWATCH.DEBUG ) then
		 		DEFAULT_CHAT_FRAME:AddMessage("SheepWatch Debug:\nEvent CHAT_MSG_SPELL_AURA_GONE_OTHER triggered\nArgument: " .. arg1);
			end
			-- END DEBUG
		  if( SHEEPWATCH.VERBOSE ) then
		  	DEFAULT_CHAT_FRAME:AddMessage("SheepWatch: " .. SHEEPWATCH_TEXT_ANNOUNCE_FADE .. mobname);
		  end
		  SHEEPWATCH.TIMER_END = currentTime;
		  if( SHEEPWATCH.PLAYER ) then
				SHEEPWATCH.DIMINISH = SHEEPWATCH.DIMINISH * 2;
				if( SHEEPWATCH.DEBUG ) then
					DEFAULT_CHAT_FRAME:AddMessage("SheepWatch Debug: Diminish set to: " .. SHEEPWATCH.DIMINISH);
				end	
			end
			if( SHEEPWATCH.ACTIVE == 1 ) then
				SHEEPWATCH.ACTIVE = 0;
			end
		end
end

SheepWatch_EventHandler["PLAYER_REGEN_ENABLED"] = function()
		-- DEBUG
		if( SHEEPWATCH.DEBUG ) then
			DEFAULT_CHAT_FRAME:AddMessage("SheepWatch Debug:\nEvent PLAYER_REGEN_ENABLED triggered");
		end
		-- END DEBUG
	  if( SHEEPWATCH.PLAYER and SHEEPWATCH.ACTIVE == 1 ) then
			-- DEBUG
			if( SHEEPWATCH.DEBUG ) then
				DEFAULT_CHAT_FRAME:AddMessage("SheepWatch Debug: Target is PLAYER. Not resetting..");
			end
			-- END DEBUG
			-- Returning, as we most likely didn't leave combat
			return;	
		end
		if( SHEEPWATCH.ACTIVE == 1 ) then
			SHEEPWATCH.ACTIVE = 0;
			SHEEPWATCH.TIMER_END = GetTime();
		  if( SHEEPWATCH.VERBOSE ) then
		  	DEFAULT_CHAT_FRAME:AddMessage( SHEEPWATCH_TEXT_ANNOUNCE_LEAVECOMBAT );
		  end			
		end
end

SheepWatch_EventHandler["PLAYER_DEAD"] = function()
		-- DEBUG
		if( SHEEPWATCH.DEBUG ) then
			DEFAULT_CHAT_FRAME:AddMessage("SheepWatch Debug:\nEvent PLAYER_DEAD triggered");
		end
		-- END DEBUG
		if( SHEEPWATCH.ACTIVE == 1 ) then
			SHEEPWATCH.ACTIVE = 0;
			SHEEPWATCH.TIMER_END = GetTime();
		  if( SHEEPWATCH.VERBOSE ) then
		  	DEFAULT_CHAT_FRAME:AddMessage( SHEEPWATCH_TEXT_ANNOUNCE_LEAVECOMBAT );
		  end			
		end
end

SheepWatch_EventHandler["SPELLCAST_START"] = function()
		local spell = arg1;
		if( SHEEPWATCH.DEBUG ) then
			DEFAULT_CHAT_FRAME:AddMessage("SheepWatch Debug:\nEvent SPELLCAST_START triggered");
			DEFAULT_CHAT_FRAME:AddMessage("Arg1: "..spell.." Arg2: "..arg2.."Spell: " .. SHEEPWATCH_SPELL );
		end
		if ( string.find(spell, SHEEPWATCH_SPELL) ) then
			SHEEPWATCH_CASTING = true;
			SHEEPWATCH_POLYCASTED = true;
			SHEEPWATCH.SHEEPTYPE = spell;
			if ( SHEEPWATCH.ANNOUNCE and SHEEPWATCH.ANNOUNCE_TIME_ID == 1 ) then
				SheepWatch_SendAnnounce(UnitName("target"), UnitLevel("target"));
			end
		end
end
		
SheepWatch_EventHandler["PLAYER_TARGET_CHANGED"] = function()
		SHEEPWATCH_TARGETCHANGED = true;
end

SheepWatch_EventHandler["SPELLCAST_STOP"] = function()
		SHEEPWATCH_CASTING = nil;
end

SheepWatch_EventHandler["SPELLCAST_FAILED"] = SheepWatch_EventHandler["SPELLCAST_STOP"];

SheepWatch_EventHandler["SPELLCAST_INTERRUPTED"] = SheepWatch_EventHandler["SPELLCAST_STOP"];


--------------------------------------------------------
-- Shows the statusbar
--------------------------------------------------------
function SheepWatch_OnShow()
	local isPlayer = ""
	local Status = GetTime()

	if( SHEEPWATCH.ACTIVE ~= 0 ) then
		SHEEPWATCH.TIMER_START = Status;
		if( SHEEPWATCH.PLAYER ) then
			SHEEPWATCH.TIMER_END = SHEEPWATCH.TIMER_START + (SHEEPWATCH.PVPLENGTH / SHEEPWATCH.DIMINISH);
		else
			SHEEPWATCH.TIMER_END = SHEEPWATCH.TIMER_START + (SHEEPWATCH.LENGTH / SHEEPWATCH.DIMINISH);
		end
		if( SHEEPWATCH.DEBUG ) then
			if ( SHEEPWATCH.PLAYER ) then isPlayer="Yes" else isPlayer="No" end
			DEFAULT_CHAT_FRAME:AddMessage("SheepWatch Debug:\nPlayer: "..isPlayer.."\nStart: "..SHEEPWATCH.TIMER_START.."\nLength: "..SHEEPWATCH.LENGTH.."\nEnd: "..SHEEPWATCH.TIMER_END);
		end
	end
	if( SHEEPWATCH.STATUS ~= 3 ) then
		SHEEPWATCH.STATUS = 2;
	end
	SheepWatch:SetScale(UIParent:GetScale() * SHEEPWATCH.SCALE);
	SheepWatch:SetAlpha( SHEEPWATCH.ALPHA );
	SheepWatchFrameStatusBar:SetStatusBarColor(SheepWatch_Settings["barcolor"].r, SheepWatch_Settings["barcolor"].g, SheepWatch_Settings["barcolor"].b);
	SheepWatchSpark:SetPoint("CENTER", "SheepWatchFrameStatusBar", "LEFT", 0, 0);
	SheepWatchText:SetText( SHEEPWATCH.SHEEPTYPE );

	if( SHEEPWATCH.COUNTER ) then
		SheepWatchCounterText:Show();
	end

end


--------------------------------------------------------
-- Update handler
--------------------------------------------------------
function SheepWatch_OnUpdate()
	if( SHEEPWATCH.STATUS == 3 ) then
		return;
	end

	local Status = GetTime();
	local Elapsed = SHEEPWATCH.TIMER_END - Status;
	
	if( SHEEPWATCH.DECIMALS ) then
		decimalcut = 0;
	else
		decimalcut = 2;
	end

	local subto = 4 - decimalcut;
	if (Elapsed < 10) then
		subto = 3 - decimalcut;
	end


	
	local seconds = string.sub(math.max(Elapsed,0)+0.001, 1, subto);
	
	if( SHEEPWATCH.ACTIVE > 0 and Status < SHEEPWATCH.TIMER_END ) then
		SheepWatchFrameStatusBar:SetMinMaxValues(SHEEPWATCH.TIMER_START, SHEEPWATCH.TIMER_END);
		if( SHEEPWATCH.COUNTER ) then
			SheepWatchCounterText:SetText( seconds .. "s");

		end
		local sparkPosition = ((Status - SHEEPWATCH.TIMER_START) / (SHEEPWATCH.TIMER_END - SHEEPWATCH.TIMER_START)) * 195;
		if( SHEEPWATCH.DIRECTION == 2 )then
			sparkPosition = 195 - sparkPosition;
			SheepWatchFrameStatusBar:SetValue(SHEEPWATCH.TIMER_START + SHEEPWATCH.TIMER_END - Status);
		else
			SheepWatchFrameStatusBar:SetValue(Status);
		end
		if( sparkPosition < 1 ) then
			sparkPosition = 1;
		end
		SheepWatchSpark:SetPoint("CENTER", "SheepWatchFrameStatusBar", "LEFT", sparkPosition, 0);
	elseif( this:GetAlpha() > 0 ) then
		if( SHEEPWATCH.STATUS == 2 ) then
			SHEEPWATCH.STATUS = 1;
			SHEEPWATCH.ACTIVE = 0;
			SheepWatchText:SetText("Timeout");
		end
		local alpha = this:GetAlpha() - SHEEPWATCH.ALPHA_STEP;
		if( alpha > 0 ) then
			this:SetAlpha(alpha);
		else
			this.fadeOut = nil;
			this:Hide();
			SheepWatchCounterText:Hide();
		end
	else
		this:Hide();
		SHEEPWATCH.STATUS = 1;
		SHEEPWATCH.ACTIVE = 0;
		SHEEPWATCH.MOBNAME = "";
		SHEEPWATCH.PLAYER = nil;
	end

end


--------------------------------------------------------
-- Check if a target is polymorhped.
--------------------------------------------------------
function isPolymorphed( unit ) 
  local i = 1;
  local debuff;

  if ( UnitIsDead("target") or UnitIsCorpse("target") ) then
  	return false
 	else
   	while ( UnitDebuff( unit, i ) ) do
 			if( SHEEPWATCH.DEBUG ) then
				DEFAULT_CHAT_FRAME:AddMessage("SheepWatch Debug: " .. unit .. " is debuffed with: " .. UnitDebuff( unit, i ));
			end
			if( string.find( UnitDebuff( unit, i ), SHEEPWATCH.DEBUFF ) ) then
				return true
    	end
    	i = i + 1;
  	end
  	return false
  end

end

--------------------------------------------------------
-- Helper function to be called from macros for debugging
-- (no direct call from the script)
--------------------------------------------------------
function showAllUnitDebuffs(unit) 
  local i = 1
  while (UnitDebuff(unit, i)) do
    DEFAULT_CHAT_FRAME:AddMessage(UnitDebuff(unit, i));
    i = i + 1;
  end
end

function showAllUnitBuffs(unit) 
  local i = 1
  while (UnitBuff(unit, i)) do
    DEFAULT_CHAT_FRAME:AddMessage(UnitBuff(unit, i));
    i = i + 1;
  end
end

--------------------------------------------------------
-- Polymorphs the current target with your highest rank
--------------------------------------------------------
function SheepWatch_SheepTarget()
	if ( UnitName("target") and UnitCanAttack("player", "target") ) then
	
--	if ( SHEEPWATCH.ANNOUNCE and SHEEPWATCH.ANNOUNCE_TIME_ID == 1) then
--		SheepWatch_SendAnnounce(UnitName("target"), UnitLevel("target"));
--	end
	CastSpellByName( SHEEPWATCH_SPELL .. "(" .. SHEEPWATCH.RANK .. ")");
	end
end

function SheepWatch_ReSheepTarget()
	if( SheepWatch_ReTargetMob() ) then
		CastSpellByName( SHEEPWATCH_SPELL .. "(" .. SHEEPWATCH.RANK .. ")");
	else
		DEFAULT_CHAT_FRAME:AddMessage( SHEEPWATCH_TEXT_ANNOUNCE_TARGETFAILED );
	end
end

--------------------------------------------------------
-- Tries to retargets our sheep when clicked on progessbar
--------------------------------------------------------
function SheepWatch_ReTargetMob()
	local i
	local foundSheep = false;
	-- Atfirst the obvisious ones..
	TargetLastEnemy();
	if ( isPolymorphed("target") ) then
		foundSheep = true;
	else
		TargetByName(SHEEPWATCH.MOBNAME);
		if ( isPolymorphed("target") ) then
			foundSheep = true;
		else 
		-- Let's cycle a bit (but not until Harry Potter 7 arrives in the stores :).
			for i=1,20 do
				if( SHEEPWATCH.DEBUG ) then
					DEFAULT_CHAT_FRAME:AddMessage("SheepWatch Debug: ReTargetMob Cycle: " .. i);
				end
				TargetNearestEnemy();
				if ( isPolymorphed("target") ) then
					if( SHEEPWATCH.DEBUG ) then
						DEFAULT_CHAT_FRAME:AddMessage("SheepWatch Debug: Found Sheep");
					end
					foundSheep = true;
					break
				end
			end
		end	
	end
	if( foundSheep ) then 
		if( SHEEPWATCH.VERBOSE ) then
		 	DEFAULT_CHAT_FRAME:AddMessage( SHEEPWATCH_TEXT_ANNOUNCE_TARGETSUCCESS );
		end
		return true
	else
		if( SHEEPWATCH.VERBOSE ) then
		 	DEFAULT_CHAT_FRAME:AddMessage( SHEEPWATCH_TEXT_ANNOUNCE_TARGETFAILED );
		end
		return false
	end
end


--------------------------------------------------------
-- Get the highest rank of Polymorph spell
--------------------------------------------------------
local function SheepWatch_GetSpellRank(spell)
	local rank = 0;
	for i = 1, 180 do 
		local spellName, spellRank = GetSpellName(i, BOOKTYPE_SPELL);

		if( spellName ) then
			if( string.find(spellName, spell, 1, true) and not string.find(spellName, ":", 1, true) ) then
				-- DEFAULT_CHAT_FRAME:AddMessage(spellName .. " " .. spellRank);
				rank = spellRank;
			end    	                
	            
		end
 	end
  return rank;
end


--------------------------------------------------------
-- Set SHEEPWATCH.LENGTH based on the highest spell rank
--------------------------------------------------------
function SheepWatch_SetTimerLength()
	
	local rank = SheepWatch_GetSpellRank( SHEEPWATCH_SPELL );
  if ( GetLocale() == "koKR" ) then
        	_, _, ranknumber = string.find( rank, "(.+) " );
  else
					_, _, _, ranknumber = string.find( rank, "(.+) (.+)" );
 	end
	SHEEPWATCH.RANK = rank;
	
	-- DEBUG
	if (SHEEPWATCH.DEBUG) then
		SheepWatch_DebugLog("Rank set to:" .. SHEEPWATCH.RANK);
	end

	if( ranknumber ) then
		DEFAULT_CHAT_FRAME:AddMessage("SheepWatch: " .. SHEEPWATCH.RANK .. SHEEPWATCH_TEXT_RANK);
		if( ranknumber == "1" ) then
			SHEEPWATCH.LENGTH = 20.0;
		elseif( ranknumber == "2" ) then
			SHEEPWATCH.LENGTH = 30.0;
		elseif( ranknumber == "3" ) then
			SHEEPWATCH.LENGTH = 40.0;
		elseif( ranknumber == "4" ) then
			SHEEPWATCH.LENGTH = 50.0;
		end
	else
		-- DEBUG
		if (SHEEPWATCH.DEBUG) then
			SheepWatch_DebugLog("No rank found.");
		end

		-- If we don't get a rank, we disable ourself.
		DEFAULT_CHAT_FRAME:AddMessage(SHEEPWATCH_TEXT_NORANK);
		SHEEPWATCH.STATUS = 0;
		DEFAULT_CHAT_FRAME:AddMessage(SHEEPWATCH_TEXT_DISABLED);
	end		
end


--------------------------------------------------------
-- Sends a message to the target"
--------------------------------------------------------
function SheepWatch_SendAnnounce( target, level )
	local chan = SHEEPWATCH.ANNOUNCE_TARGET
	local msg = SHEEPWATCH.ANNOUNCEPATTERN;
	msg = string.gsub(msg, "$t", target);
	msg = string.gsub(msg, "$l", level);
	msg = string.gsub(msg, "$s", SHEEPWATCH_SPELL);
	msg = string.gsub(msg, "$r", SHEEPWATCH.RANK);

	if ( chan == "SAY" ) then
		SendChatMessage(msg, "SAY");
	elseif ( chan == "YELL" ) then
        	SendChatMessage( msg, "YELL" ); 
	elseif ( chan == "PARTY" ) then
		if ( GetNumPartyMembers() > 0 ) then
			SendChatMessage( msg, "PARTY" );
		end
	elseif ( chan == "GUILD" ) then
		if ( IsInGuild() ) then
			SendChatMessage( msg, "GUILD" );
		end
	elseif ( chan == "RAID" ) then
		if ( GetNumRaidMembers() > 0 ) then
			SendChatMessage( msg, "RAID" );
		end
	elseif ( chan == "AUTO") then
		if ( GetNumRaidMembers() > 0 ) then
			SendChatMessage( msg, "RAID" );
		elseif ( GetNumPartyMembers() > 0 ) then
			SendChatMessage( msg, "PARTY" );
		else
			SendChatMessage( msg, "SAY" );
		end
	end

end


--------------------------------------------------------
-- Load the variables.
--------------------------------------------------------
function SheepWatch_LoadVariables()
	if SHEEPWATCH_VARIABLES_LOADED then
		return
	end
	

	
	-- Disable debugging by default
	SHEEPWATCH.DEBUG = false;
	if ( SheepWatch_Log == nil ) then
		SheepWatch_Log = { };
	end

	-- Get the actual Polymorph rank
	SheepWatch_SetTimerLength();

	-- Apply default settings to the profile if the aren't set yet
	-- Default settings are defined in SheepWatch_Globals.lua
	if( SheepWatch_Settings == nil ) then
		SheepWatch_Settings = { };
		SheepWatch_Settings.version = SHEEPWATCH_VERSION;
	else
		SheepWatch_CheckProfile();
	end

	if( SheepWatch_Settings.status == nil ) then
		SheepWatch_Settings.status = SHEEPWATCH.STATUS;
	end

	if( SheepWatch_Settings.direction == nil ) then
		SheepWatch_Settings.direction = SHEEPWATCH.DIRECTION;
	end

	if( SheepWatch_Settings.verbose == nil ) then
		SheepWatch_Settings.verbose = SHEEPWATCH.VERBOSE;
	end	

	if( SheepWatch_Settings.counter == nil ) then
		SheepWatch_Settings.counter = SHEEPWATCH.COUNTER;
	end	

	if( SheepWatch_Settings.decimals == nil ) then
		SheepWatch_Settings.decimals = SHEEPWATCH.DECIMALS;
	end	

	if (SheepWatch_Settings.announce == nil )then
		SheepWatch_Settings.announce = SHEEPWATCH.ANNOUNCE;
	end	

	if (SheepWatch_Settings.targetid == nil ) then
		SheepWatch_Settings.targetid = SHEEPWATCH.ANNOUNCE_TARGET_ID;
	end		

	if (SheepWatch_Settings.timeid == nil ) then
		SheepWatch_Settings.timeid = SHEEPWATCH.ANNOUNCE_TIME_ID;
	end

	if (SheepWatch_Settings.alpha == nil ) then
		SheepWatch_Settings.alpha = SHEEPWATCH.ALPHA;
	end

	if (SheepWatch_Settings.scale == nil ) then
		SheepWatch_Settings.scale = SHEEPWATCH.SCALE;
	end

	if (SheepWatch_Settings.pattern == nil ) then
		SheepWatch_Settings.pattern = SHEEPWATCH.ANNOUNCEPATTERN;
	end
	
	if (SheepWatch_Settings["barcolor"] == nil ) then
		SheepWatch_Settings["barcolor"] = { };
		SheepWatch_Settings["barcolor"].r = "1.0";
		SheepWatch_Settings["barcolor"].g = "1.0";
		SheepWatch_Settings["barcolor"].b = "0.0";
	end
	
	-- Read settings from the profile
	SHEEPWATCH.STATUS = SheepWatch_Settings.status;
	SHEEPWATCH.DIRECTION = SheepWatch_Settings.direction;
	SHEEPWATCH.VERBOSE = SheepWatch_Settings.verbose;
	SHEEPWATCH.COUNTER = SheepWatch_Settings.counter;
	SHEEPWATCH.DECIMALS = SheepWatch_Settings.decimals;
	SHEEPWATCH.ANNOUNCE = SheepWatch_Settings.announce;
	SHEEPWATCH.ANNOUNCE_TIME_ID = SheepWatch_Settings.timeid;
	SHEEPWATCH.ANNOUNCE_TARGET_ID = SheepWatch_Settings.targetid;
	SHEEPWATCH.ANNOUNCE_TARGET = SHEEPWATCH_LIST_ANNOUNCETARGETS[SHEEPWATCH.ANNOUNCE_TARGET_ID].name;
	SHEEPWATCH.ANNOUNCEPATTERN = SheepWatch_Settings.pattern;
	SheepWatchConfigBarColorSwatchNormalTexture:SetVertexColor(SheepWatch_Settings["barcolor"].r, SheepWatch_Settings["barcolor"].g, SheepWatch_Settings["barcolor"].b);
	SheepWatchFrameStatusBar:SetStatusBarColor(SheepWatch_Settings["barcolor"].r, SheepWatch_Settings["barcolor"].g, SheepWatch_Settings["barcolor"].b);
	SHEEPWATCH.ALPHA = SheepWatch_Settings.alpha;
	SHEEPWATCH.SCALE = SheepWatch_Settings.scale;
	SheepWatch:SetScale(UIParent:GetScale() * SHEEPWATCH.SCALE);
	
	SHEEPWATCH_VARIABLES_LOADED = true;

end


--------------------------------------------------------
-- Print the internal variables for debugging purposes.
--------------------------------------------------------
function SheepWatch_PrintStatus()

	DEFAULT_CHAT_FRAME:AddMessage("SheepWatch Status:");
	DEFAULT_CHAT_FRAME:AddMessage("Version: " .. SHEEPWATCH_VERSION);
	DEFAULT_CHAT_FRAME:AddMessage("Status: " .. SHEEPWATCH.STATUS .. " \(0=disabled, 1=enabled\)");
	DEFAULT_CHAT_FRAME:AddMessage("Spell: " .. SHEEPWATCH_SPELL);
	DEFAULT_CHAT_FRAME:AddMessage("Rank: " .. SHEEPWATCH.RANK .. " \(determined at loading time\)");	
	DEFAULT_CHAT_FRAME:AddMessage("Length: " .. SHEEPWATCH.LENGTH .. " \(defined through the rank\)");
	if( SHEEPWATCH.VERBOSE ) then
		DEFAULT_CHAT_FRAME:AddMessage("Verbose: On");
	else
		DEFAULT_CHAT_FRAME:AddMessage("Verbose: Off");
	end
	DEFAULT_CHAT_FRAME:AddMessage("Direction: " .. SHEEPWATCH.DIRECTION);
	if( SHEEPWATCH.COUNTER ) then
		DEFAULT_CHAT_FRAME:AddMessage("Counter: On");
	else
		DEFAULT_CHAT_FRAME:AddMessage("Counter: Off");
	end
	if( SHEEPWATCH.DECIMALS ) then
		DEFAULT_CHAT_FRAME:AddMessage("Decimals: On");
	else
		DEFAULT_CHAT_FRAME:AddMessage("Decimals: Off");
	end
	if( SHEEPWATCH.ANNOUNCE ) then
		DEFAULT_CHAT_FRAME:AddMessage("Announce: On");
	else
		DEFAULT_CHAT_FRAME:AddMessage("Announce: Off");
	end
	DEFAULT_CHAT_FRAME:AddMessage("Target: " .. SHEEPWATCH.ANNOUNCE_TARGET);
	DEFAULT_CHAT_FRAME:AddMessage("Time: " .. SHEEPWATCH_LIST_ANNOUNCETIME[SHEEPWATCH.ANNOUNCE_TIME_ID].name);
	

end


--------------------------------------------------------
-- Check if user's profile need to be cleared
--------------------------------------------------------
function SheepWatch_CheckProfile()
	local profileversion = nil;
	local version = SHEEPWATCH_VERSION;
	
	if( SheepWatch_Settings.version ~= nil ) then
		-- Get the actual version in the profile when already set.
		profileversion = SheepWatch_Settings.version;
	end
	
	if( profileversion == nil and SHEEPWATCH.CLEAR == 1 ) then
		-- Clear when we are asked to do so and no version was set yet.
		SheepWatch_ClearProfile();
		SheepWatch_Settings.version = version;
		-- DEFAULT_CHAT_FRAME:AddMessage( SHEEPWATCH_TEXT_PROFILECLEARED );
	elseif( version ~= profileversion and SHEEPWATCH.CLEAR ) then
		-- Clear because we are asked to do so.
		SheepWatch_ClearProfile();
		SheepWatch_Settings.version = version;
		-- DEFAULT_CHAT_FRAME:AddMessage( SHEEPWATCH_TEXT_PROFILECLEARED );
	end	 

end


--------------------------------------------------------
-- Clear user's profile from SavedVariables.lua
--------------------------------------------------------
function SheepWatch_ClearProfile()
	SheepWatch_Settings = nil;
	SHEEPWATCH_VARIABLES_LOADED = false;
	SheepWatch_LoadVariables();
end


--------------------------------------------------------
-- Print the help
--------------------------------------------------------
function SheepWatch_Help()
	DEFAULT_CHAT_FRAME:AddMessage("SheepWatch " .. SHEEPWATCH_VERSION .. SHEEPWATCH_HELP1);
end





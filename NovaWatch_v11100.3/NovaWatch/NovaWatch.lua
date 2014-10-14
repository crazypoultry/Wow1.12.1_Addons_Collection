-- NovaWatch is based on Veighflo's rewrite of StunWatch by Vector called NovaWatch.
-- The Frostnova functionality was removed from NovaWatch by me and put into its own
-- AddOn.
-- 
-- The actual version was rewritten and released by zapi@curse
-- (Asmodean on Turalyon & Ania on Darksorrow)
-- 
-- Credits:
-- Veighflo for the idea. Vector for StunWatch.
--
-- Version: 11000.1
-- Date:		2009-03-29

--------------------------------------------------------
-- myAddOns support
--------------------------------------------------------
NovaWatchDetails = {
	name = "NovaWatch",
	version = "11000.1",
	releaseDate = "March 29, 2006",
	author = "zapi",
	email = "wow@gzipped.org",
	website = "http://www.curse-gaming.com/",
	category = MYADDONS_CATEGORY_CLASS,
	optionsframe = "NovaWatchConfig"
};

NovaWatchHelp = {};


--------------------------------------------------------
-- Initialization functions
--------------------------------------------------------
function NovaWatch_OnLoad()
	NovaWatch_Initialize();
	NovaWatch_EventRegister();
end

function NovaWatch_Initialize()
	SLASH_NOVAWATCH1 = "/novawatch";
	SLASH_NOVAWATCH2 = "/nova";
	SLASH_NOVAWATCH3 = "/nw";
	SlashCmdList["NOVAWATCH"] = function(msg)
		NovaWatch_SlashCommandHandler(msg);
	end

	DEFAULT_CHAT_FRAME:AddMessage( NOVAWATCH_TEXT_LOADED );
end

--------------------------------------------------------
-- Register the necessary UI API events.
--------------------------------------------------------
function NovaWatch_EventRegister()
--	this:RegisterEvent("ADDON_LOADED");
	this:RegisterEvent("PLAYER_LOGIN");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_AURA_GONE_OTHER");
	this:RegisterEvent("CHAT_MSG_SPELL_BREAK_AURA");
	this:RegisterEvent("PLAYER_REGEN_ENABLED");
	this:RegisterEvent("PLAYER_DEAD");
end


--------------------------------------------------------
-- Handler for /novawatch
--------------------------------------------------------
function NovaWatch_SlashCommandHandler(msg)

	local a, b, command  = string.find( msg, "(%w+)" );

	if( command == nil ) then
		NovaWatchConfig:Show();
		return;
	else
		command = string.lower( msg );
	end
			
	if( command == "unlock" ) then
		NOVAWATCH.STATUS = 3;
		NovaWatch:Show();
		NovaWatchCounterText:SetText( "00.0s" );
		NovaWatchCounter:Show();
		DEFAULT_CHAT_FRAME:AddMessage(NOVAWATCH_TEXT_UNLOCKED);
		
	elseif( command == "lock" ) then
		NOVAWATCH.STATUS = 1;
		NovaWatch:Hide();
		NovaWatchCounter:Hide();
		DEFAULT_CHAT_FRAME:AddMessage(NOVAWATCH_TEXT_LOCKED);
		
	elseif( command == "clear" ) then
		local pn = UnitName("player");
		if(pn ~= nil and pn ~= UNKNOWNBEING and pn ~= UKNOWNBEING and pn ~= UNKNOWNOBJECT) then
			NovaWatch_ClearProfile();
		else
			DEFAULT_CHAT_FRAME:AddMessage("NovaWatch: " .. NOVAWATCH_TEXT_WORLD_NOT_LOADED);
		end

	elseif( command == "resetpos" ) then
		NOVAWATCH.ALPHA = 1;
		NovaWatch_Settings.alpha = NOVAWATCH.ALPHA;
		NovaWatch:ClearAllPoints();
		NovaWatch:SetPoint("CENTER", 0, 300);
		DEFAULT_CHAT_FRAME:AddMessage( NOVAWATCH_TEXT_RESETPOS );
				
	elseif( command == "status" ) then
		NovaWatch_PrintStatus();

	elseif( command == "debug" ) then
		NOVAWATCH.DEBUG = true;
		DEFAULT_CHAT_FRAME:AddMessage("NovaWatch: Debugging enabled for this session.");

	else
		NovaWatchConfig:Show();
	end
	
end


--------------------------------------------------------
-- Event handling
-- (Event handling rewritten and inspired by StunWatch)
--------------------------------------------------------
function NovaWatch_OnEvent()
	
	-- Don't do anything if SheepWatch isn't enabled
	if( NOVAWATCH.STATUS == 0 and event ~= "PLAYER_LOGIN") then
		return
	end
	
	-- DEBUG
	--DEFAULT_CHAT_FRAME:AddMessage("SheepWatch: Event "..event);
	
	NovaWatch_EventHandler[event](arg1, arg2, arg3, arg4, arg5);	
end

NovaWatch_EventHandler = {}

NovaWatch_EventHandler["PLAYER_LOGIN"] = function()
		-- Register in myAddons
		if(myAddOnsFrame_Register) then
			myAddOnsFrame_Register(NovaWatchDetails, NovaWatchHelp);
		end
		-- Load the saved config
		NovaWatch_LoadVariables();
end

NovaWatch_EventHandler["CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE"] = function()
		local _, _, mobname = string.find(arg1, NOVAWATCH_EVENT_ON);
		if( mobname ~= nil and UnitName("target") == mobname) then 
			-- DEBUG
			if( NOVAWATCH.DEBUG ) then
		 		DEFAULT_CHAT_FRAME:AddMessage("NovaWatch Debug:\nEvent CHAT_MSG_SPELL_SELF_DAMAGE triggered\nArgument: " .. arg1);
			end
			-- END DEBUG
		  if( NOVAWATCH.VERBOSE ) then
		  	DEFAULT_CHAT_FRAME:AddMessage("NovaWatch: " .. NOVAWATCH_SPELL .. NOVAWATCH_TEXT_ANNOUNCE_CAST .. mobname);
		  end
		  if( GetTime() > NOVAWATCH.TIMER_END + 15 or mobname ~= NOVAWATCH.MOBNAME ) then
				NOVAWATCH.DIMINISH = 1;
				if( NOVAWATCH.DEBUG ) then
		 			DEFAULT_CHAT_FRAME:AddMessage("NovaWatch Debug:\nDiminish set to: " .. NOVAWATCH.DIMINISH );
				end		
			end
			NOVAWATCH.MOBNAME = mobname;
			NOVAWATCH.PLAYER = UnitIsPlayer("target");
			NOVAWATCH.ACTIVE = 1;
			if( NOVAWATCH.STATUS == 1 ) then
				NovaWatch:Show(); 
			else
				NovaWatch_OnShow();
			end
		end
end

NovaWatch_EventHandler["CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE"] = NovaWatch_EventHandler["CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE"];


NovaWatch_EventHandler["CHAT_MSG_SPELL_BREAK_AURA"] = function()
		local currentTime = GetTime();
		local  _, _, mobname = string.find(arg1, NOVAWATCH_EVENT_BREAK);
		if( mobname ~= nil and mobname == NOVAWATCH.MOBNAME ) then
			-- DEBUG
			if( NOVAWATCH.DEBUG ) then
		 		DEFAULT_CHAT_FRAME:AddMessage("NovaWatch Debug:\nEvent CHAT_MSG_SPELL_BREAK_AURA triggered\nArgument: " .. arg1);
			end
			-- END DEBUG
		  if( NOVAWATCH.VERBOSE ) then
		  	DEFAULT_CHAT_FRAME:AddMessage("NovaWatch: " .. NOVAWATCH_TEXT_ANNOUNCE_BREAK  .. mobname);
		  end
		  if( NOVAWATCH.DIMINISHES == 1 or NOVAWATCH.DIMINISHES == 2 ) then
				NOVAWATCH.DIMINISH = 2 * NOVAWATCH.DIMINISH;
				if( NOVAWATCH.DEBUG ) then
		 			DEFAULT_CHAT_FRAME:AddMessage("NovaWatch Debug:\nDiminish set to: " .. NOVAWATCH.DIMINISH );
				end				
			end
			NOVAWATCH.TIMER_END = currentTime;

			if( NOVAWATCH.ACTIVE == 1 ) then
				NOVAWATCH.ACTIVE = 0;
			end
		end
end
		
NovaWatch_EventHandler["CHAT_MSG_SPELL_AURA_GONE_OTHER"] = function()
		local currentTime = GetTime();
		local  _, _, mobname = string.find(arg1, NOVAWATCH_EVENT_FADE);
		if( mobname ~= nil and mobname == NOVAWATCH.MOBNAME ) then
			-- DEBUG
			if( NOVAWATCH.DEBUG ) then
		 		DEFAULT_CHAT_FRAME:AddMessage("NovaWatch Debug:\nEvent CHAT_MSG_SPELL_AURA_GONE_OTHER triggered\nArgument: " .. arg1);
			end
			-- END DEBUG
		  if( NOVAWATCH.VERBOSE ) then
		  	DEFAULT_CHAT_FRAME:AddMessage("NovaWatch: " .. NOVAWATCH_TEXT_ANNOUNCE_FADE .. mobname);
		  end
		  NOVAWATCH.TIMER_END = currentTime;
			if( NOVAWATCH.DIMINISHES == 1
				or ( NOVAWATCH.DIMINISHES > 1 and NOVAWATCH.PLAYER ) ) then
				NOVAWATCH.DIMINISH = 2 * NOVAWATCH.DIMINISH;
				if( NOVAWATCH.DEBUG ) then
		 			DEFAULT_CHAT_FRAME:AddMessage("NovaWatch Debug:\nDiminish set to: " .. NOVAWATCH.DIMINISH );
				end		
			end			
			if( NOVAWATCH.ACTIVE == 1 ) then
				NOVAWATCH.ACTIVE = 0;
			end
		end
end
		
NovaWatch_EventHandler["PLAYER_REGEN_ENABLED"] = function()
		-- DEBUG
		if( NOVAWATCH.DEBUG ) then
			DEFAULT_CHAT_FRAME:AddMessage("NovaWatch Debug:\nEvent PLAYER_REGEN_ENABLED or PLAYER_DEAD triggered");
		end
		-- END DEBUG
		if( NOVAWATCH.ACTIVE == 1 ) then
			NOVAWATCH.ACTIVE = 0;
			NOVAWATCH.TIMER_END = GetTime();
		  if( NOVAWATCH.VERBOSE ) then
		  	DEFAULT_CHAT_FRAME:AddMessage( NOVAWATCH_TEXT_ANNOUNCE_LEAVECOMBAT );
		  end			
		end
end

NovaWatch_EventHandler["PLAYER_DEAD"] = NovaWatch_EventHandler["PLAYER_REGEN_ENABLED"];



--------------------------------------------------------
-- Shows the statusbar
--------------------------------------------------------
function NovaWatch_OnShow()
	local isPlayer = ""
	local Status = GetTime()
	if( NOVAWATCH.ACTIVE ~= 0 ) then
		if( NOVAWATCH.DIMINISH == 16 ) then
			return
		end
		NOVAWATCH.TIMER_START = Status;
		if( NOVAWATCH.PLAYER ) then
			NOVAWATCH.TIMER_END = ( NOVAWATCH.TIMER_START + NOVAWATCH.LENGTH ) / NOVAWATCH.DIMINISH;
		else
			NOVAWATCH.TIMER_END = NOVAWATCH.TIMER_START + NOVAWATCH.LENGTH;
		end
		if( NOVAWATCH.DEBUG ) then
			if ( NOVAWATCH.PLAYER ) then isPlayer="Yes" else isPlayer="No" end
			DEFAULT_CHAT_FRAME:AddMessage("NovaWatch Debug:\nPlayer: "..isPlayer.."\nStart: "..NOVAWATCH.TIMER_START.."\nLength: "..NOVAWATCH.LENGTH.."\nEnd: "..NOVAWATCH.TIMER_END);
		end
	end
	if( NOVAWATCH.STATUS ~= 3 ) then
		NOVAWATCH.STATUS = 2;
	end
	NovaWatch:SetScale(UIParent:GetScale() * NOVAWATCH.SCALE);
	NovaWatch:SetAlpha( NOVAWATCH.ALPHA );
	NovaWatchFrameStatusBar:SetStatusBarColor(NovaWatch_Settings["barcolor"].r, NovaWatch_Settings["barcolor"].g, NovaWatch_Settings["barcolor"].b);
	NovaWatchSpark:SetPoint("CENTER", "NovaWatchFrameStatusBar", "LEFT", 0, 0);
	NovaWatchText:SetText( NOVAWATCH_SPELL );

	if( NOVAWATCH.COUNTER ) then
		NovaWatchCounterText:Show();
	end


end


--------------------------------------------------------
-- Update handler
--------------------------------------------------------
function NovaWatch_OnUpdate()
	if( NOVAWATCH.STATUS == 3 ) then
		return;
	end

	local Status = GetTime();
	local Elapsed = NOVAWATCH.TIMER_END - Status;

	if( NOVAWATCH.DECIMALS ) then
		decimalcut = 0;
	else
		decimalcut = 2;
	end

	local subto = 3 - decimalcut;
	
	local seconds = string.sub(math.max(Elapsed,0)+0.001, 1, subto);
	
	if( NOVAWATCH.ACTIVE > 0 and Status < NOVAWATCH.TIMER_END ) then
		NovaWatchFrameStatusBar:SetMinMaxValues(NOVAWATCH.TIMER_START, NOVAWATCH.TIMER_END);
		if( NOVAWATCH.COUNTER ) then
			NovaWatchCounterText:SetText( seconds .. "s" );
		end
		local sparkPosition = ((Status - NOVAWATCH.TIMER_START) / (NOVAWATCH.TIMER_END - NOVAWATCH.TIMER_START)) * 195;
		if( NOVAWATCH.DIRECTION == 2)then
			sparkPosition = 195 - sparkPosition;
			NovaWatchFrameStatusBar:SetValue(NOVAWATCH.TIMER_START + NOVAWATCH.TIMER_END - Status);
		else
			NovaWatchFrameStatusBar:SetValue(Status);
		end
		if( sparkPosition < 1 ) then
			sparkPosition = 1;
		end
		NovaWatchSpark:SetPoint("CENTER", "NovaWatchFrameStatusBar", "LEFT", sparkPosition, 0);
	elseif( this:GetAlpha() > 0 ) then
		if( NOVAWATCH.STATUS == 2 ) then
			NOVAWATCH.STATUS = 1;
			NOVAWATCH.ACTIVE = 0;
			NovaWatchText:SetText("Timeout");
		end
		local alpha = this:GetAlpha() - NOVAWATCH.ALPHA_STEP;
		if( alpha > 0 ) then
			this:SetAlpha(alpha);
		else
			this.fadeOut = nil;
			this:Hide();
			NovaWatchCounterText:Hide();
		end
	else
		this:Hide();
		NOVAWATCH.STATUS = 1;
		NOVAWATCH.ACTIVE = 0;
		NOVAWATCH.MOBNAME = "";
		NOVAWATCH.PLAYER = nil;
	end

end


--------------------------------------------------------
-- Load the variables.
--------------------------------------------------------
function NovaWatch_LoadVariables(arg1)
	if NOVAWATCH_VARIABLES_LOADED then
		return
	end
	
	-- Disable debugging by default
	NOVAWATCH.DEBUG = false;

	local playerName
	local playerName=UnitName("player")
	if playerName==nil or playerName==UNKNOWNBEING or playerName==UKNOWNBEING or playerName==UNKNOWNOBJECT then
		return
	end

	-- Apply default settings to the profile if the aren't set yet
	-- Default settings are defined in NovaWatch_Globals.lua
	if( NovaWatch_Settings == nil ) then
		NovaWatch_Settings = { };
		NovaWatch_Settings.version = NOVAWATCH_VERSION;
	else
		NovaWatch_CheckProfile();
	end

	if( NovaWatch_Settings.status == nil ) then
		NovaWatch_Settings.status = NOVAWATCH.STATUS;
	end

	if( NovaWatch_Settings.direction == nil ) then
		NovaWatch_Settings.direction = NOVAWATCH.DIRECTION;
	end

	if( NovaWatch_Settings.verbose == nil ) then
		NovaWatch_Settings.verbose = NOVAWATCH.VERBOSE;
	end	

	if( NovaWatch_Settings.counter == nil ) then
		NovaWatch_Settings.counter = NOVAWATCH.COUNTER;
	end	

	if( NovaWatch_Settings.decimals == nil ) then
		NovaWatch_Settings.decimals = NOVAWATCH.DECIMALS;
	end

	if (NovaWatch_Settings.alpha == nil ) then
		NovaWatch_Settings.alpha = NOVAWATCH.ALPHA;
	end

	if (NovaWatch_Settings.scale == nil ) then
		NovaWatch_Settings.scale = NOVAWATCH.SCALE;
	end

	if (NovaWatch_Settings["barcolor"] == nil ) then
		NovaWatch_Settings["barcolor"] = { };
		NovaWatch_Settings["barcolor"].r = "1.0";
		NovaWatch_Settings["barcolor"].g = "1.0";
		NovaWatch_Settings["barcolor"].b = "0.0";
	end
	
	-- Read settings from the profile
	NOVAWATCH.STATUS = NovaWatch_Settings.status;
	NOVAWATCH.DIRECTION = NovaWatch_Settings.direction;
	NOVAWATCH.VERBOSE = NovaWatch_Settings.verbose;
	NOVAWATCH.COUNTER = NovaWatch_Settings.counter;
	NOVAWATCH.DECIMALS = NovaWatch_Settings.decimals;
	NovaWatchConfigBarColorSwatchNormalTexture:SetVertexColor(NovaWatch_Settings["barcolor"].r, NovaWatch_Settings["barcolor"].g, NovaWatch_Settings["barcolor"].b);
	NovaWatchFrameStatusBar:SetStatusBarColor(NovaWatch_Settings["barcolor"].r, NovaWatch_Settings["barcolor"].g, NovaWatch_Settings["barcolor"].b);
	NOVAWATCH.ALPHA = NovaWatch_Settings.alpha;
	NOVAWATCH.SCALE = NovaWatch_Settings.scale;
	NovaWatch:SetScale(UIParent:GetScale() * NOVAWATCH.SCALE);

	
	NOVAWATCH_VARIABLES_LOADED = true

end


--------------------------------------------------------
-- Print the internal variables for debugging purposes.
--------------------------------------------------------
function NovaWatch_PrintStatus()

	DEFAULT_CHAT_FRAME:AddMessage("NovaWatch Status:");
	DEFAULT_CHAT_FRAME:AddMessage("Version: " .. NOVAWATCH_VERSION);
	DEFAULT_CHAT_FRAME:AddMessage("Profile: " .. NOVAWATCH_PROFILE);
	DEFAULT_CHAT_FRAME:AddMessage("Status: " .. NOVAWATCH.STATUS .. " \(0=disabled, 1=enabled\)");
	DEFAULT_CHAT_FRAME:AddMessage("Spell: " .. NOVAWATCH_SPELL .. " \(determined at loading time\)");
	DEFAULT_CHAT_FRAME:AddMessage("Length: " .. NOVAWATCH.LENGTH .. " \(defined through the rank\)");
	if( NOVAWATCH.VERBOSE ) then
		DEFAULT_CHAT_FRAME:AddMessage("Verbose: On");
	else
		DEFAULT_CHAT_FRAME:AddMessage("Verbose: Off");
	end
	DEFAULT_CHAT_FRAME:AddMessage("Direction: " .. NOVAWATCH.DIRECTION);
	if( NOVAWATCH.COUNTER ) then
		DEFAULT_CHAT_FRAME:AddMessage("Counter: On");
	else
		DEFAULT_CHAT_FRAME:AddMessage("Counter: Off");
	end
	if( NOVAWATCH.DECIMALS ) then
		DEFAULT_CHAT_FRAME:AddMessage("Decimals: On");
	else
		DEFAULT_CHAT_FRAME:AddMessage("Decimals: Off");
	end

end


--------------------------------------------------------
-- Check if user's profile need to be cleared
--------------------------------------------------------
function NovaWatch_CheckProfile()
	local profileversion = nil;
	local version = NOVAWATCH_VERSION;
	
	if( NovaWatch_Settings.version ~= nil ) then
		-- Get the actual version in the profile when already set.
		profileversion = NovaWatch_Settings.version;
	end
	
	if( profileversion == nil and NOVAWATCH.CLEAR ) then
		-- Clear when we are asked to do so and no version was set yet.
		NovaWatch_ClearProfile();
		NovaWatch_Settings.version = version;
		DEFAULT_CHAT_FRAME:AddMessage( NOVAWATCH_TEXT_PROFILECLEARED );
	elseif( version ~= profileversion and NOVAWATCH.CLEAR ) then
		-- Clear because we are asked to do so.
		NovaWatch_ClearProfile();
		NovaWatch_Settings.version = version;
		DEFAULT_CHAT_FRAME:AddMessage( NOVAWATCH_TEXT_PROFILECLEARED );
	end	 

end


--------------------------------------------------------
-- Clear user's profile from SavedVariables.lua
--------------------------------------------------------
function NovaWatch_ClearProfile()
	NovaWatch_Settings = nil;
	NOVAWATCH_VARIABLES_LOADED = false;
	NovaWatch_LoadVariables();
end


--------------------------------------------------------
-- Print the help
--------------------------------------------------------
function NovaWatch_Help()
	DEFAULT_CHAT_FRAME:AddMessage("NovaWatch " .. NOVAWATCH_VERSION .. NOVAWATCH_HELP1);
	DEFAULT_CHAT_FRAME:AddMessage(NOVAWATCH_HELP2);
	DEFAULT_CHAT_FRAME:AddMessage(NOVAWATCH_HELP3);
	DEFAULT_CHAT_FRAME:AddMessage(NOVAWATCH_HELP4);
	DEFAULT_CHAT_FRAME:AddMessage(NOVAWATCH_HELP5);
	DEFAULT_CHAT_FRAME:AddMessage(NOVAWATCH_HELP6);
	DEFAULT_CHAT_FRAME:AddMessage(NOVAWATCH_HELP7);
	DEFAULT_CHAT_FRAME:AddMessage(NOVAWATCH_HELP8);
	DEFAULT_CHAT_FRAME:AddMessage(NOVAWATCH_HELP9);
	DEFAULT_CHAT_FRAME:AddMessage(NOVAWATCH_HELP10);
	DEFAULT_CHAT_FRAME:AddMessage(NOVAWATCH_HELP11);
end





--[[ 
	SSHonor By Shadowd of Icecrown (PVE)
	Original Release: September 16th (2006)
]]

local Orig_HonorFrame_OnShow;
local Orig_HonorFrame_OnHide;
local Orig_HonorFrame_Update;
local Orig_ChatFrame_OnEvent;
local Orig_InspectHonorFrame_Update;
local Orig_SCT_BlizzardCombatTextEvent;

local HKString;
local HBonusString;
local RepString;

local KillMessages = {};

local SlashCommmands = {};

local DIMINISHING_PER_KILL = 10;
local MAX_KILLS = 10;

local TimeElapsed = 0;
local StartTime = 0;
local HonorThisSession = 0;

local CurrentBGID = -1;

local HonorBonus = {	[1] = 1.0,
			[2] = 1.0,
			[3] = 1.15,
			[4] = 1.30,
			[5] = 1.40,
			[6] = 1.40,
			[7] = 1.40,
			[8] = 1.50 };

function SSHonor_OnLoad()
	this:RegisterEvent( "VARIABLES_LOADED" );
	this:RegisterEvent( "ADDON_LOADED" );

	this:RegisterEvent( "UPDATE_BATTLEFIELD_STATUS" );

	this:RegisterEvent( "CHAT_MSG_COMBAT_HONOR_GAIN" );
	this:RegisterEvent( "CHAT_MSG_COMBAT_FACTION_CHANGE" );

	this:RegisterEvent( "PLAYER_PVP_KILLS_CHANGED" );
	this:RegisterEvent( "PLAYER_PVP_RANK_CHANGED" );

	this:RegisterEvent( "PLAYER_LOGIN" );

	SLASH_SSHONOR1 = "/sshonor";
	SlashCmdList["SSHONOR"] = SSHonor_SlashHandler;
	
	SlashCommands = SSHonor_GetConfiguration();
end 

-- Inspect page
function SSHonor_InspectHonorFrame_Update()
	Orig_InspectHonorFrame_Update();
	
	-- Stuff that we only want ran when the honorframe is updated
	if( SSHonor_Config.showPercent ) then
		InspectHonorFrameCurrentPVPRank:SetText( InspectHonorFrameCurrentPVPRank:GetText() .. " (" .. string.format( "%.2f", GetInspectPVPRankProgress() * 100 ) .. "%)" );
	end
	
	if( SSHonor_Config.hideIcon ) then
		InspectHonorFramePvPIcon:Hide();
	end
	
	-- Now reposition it
	InspectHonorFrameCurrentPVPTitle:SetPoint( "TOP", "InspectHonorFrame", "TOP", -InspectHonorFrameCurrentPVPRank:GetWidth() / 2, -83 );
end

-- Player honor page
function SSHonor_HonorFrame_Update( updateAll )
	Orig_HonorFrame_Update( updateAll );

	-- Stuff that we only want ran when the honorframe is updated
	if( SSHonor_Config.showPercent ) then
		HonorFrameCurrentPVPRank:SetText( HonorFrameCurrentPVPRank:GetText() .. " (" .. string.format( "%.2f", GetPVPRankProgress() * 100 ) .. "%)" );
	end
	
	if( SSHonor_Config.hideIcon ) then
		HonorFramePvPIcon:Hide();
	end
	
	-- Now reposition for anything added
	HonorFrameCurrentPVPTitle:SetPoint( "TOP", "HonorFrame", "TOP", -HonorFrameCurrentPVPRank:GetWidth() / 2, -83 );
end

function SSHonor_CreateTooltip( day )
	local killTotal = math.floor( SSHonor_GetTotal( "kill", day ) );
	local bonusTotal = SSHonor_GetTotal( "bonus", day );
	
	local killPercent = "0%";
	local bonusPercent = "0%";
	
	local totalHonor = killTotal + bonusTotal;
	
	-- How much of bonus/kill honor makes up our total
	if( bonusTotal > 0 ) then
		bonusPercent = string.format( "%.2f%%", ( ( bonusTotal / totalHonor ) * 100 ) );
	end
	
	if( killTotal > 0 ) then
		killPercent = string.format( "%.2f%%", ( ( killTotal / totalHonor ) * 100 ) );
	end
		
	-- Create the tooltip
	-- Add kill honor
	local kill = "";
	
	if( SSHonor_Config[ day ]["killhonor"] ) then
		local killList = {};
	
		for zone, amount in SSHonor_Config[ day ]["killhonor"] do
			table.insert( killList, string.format( SSH_HONOR_ROW, zone, GREEN_FONT_COLOR_CODE .. math.floor( amount ) .. FONT_COLOR_CODE_CLOSE ) );
		end

		if( table.getn( killList ) > 0 ) then
			kill = "\n" .. table.concat( killList, "\n" ) .. "\n";
		end
	end

	-- Add bonus honor
	local bonus = "";
	
	if( SSHonor_Config[ day ]["bonushonor"] ) then
		local bonusList = {};
	
		for zone, amount in SSHonor_Config[ day ]["bonushonor"] do
			table.insert( bonusList, string.format( SSH_HONOR_ROW, zone, GREEN_FONT_COLOR_CODE .. amount .. FONT_COLOR_CODE_CLOSE ) );
		end

		if( table.getn( bonusList ) > 0 ) then
			bonus = "\n" .. table.concat( bonusList, "\n" );
		end
	end

	-- Add wins/loses
	local wins = SSHonor_GetWins( day );
	local loses = SSHonor_GetLoses( day );
	local totalMatches = wins + loses;
	local winPercent = "--";
	local losePercent = "--";
	local matchRecord = "";
	
	if( wins > 0 ) then
		winPercent = string.format( "%.2f%%", ( wins / totalMatches ) * 100 )
	end
	
	if( loses > 0 ) then
		losePercent = string.format( "%.2f%%", ( loses / totalMatches ) * 100 );
	end
	
	if( totalMatches > 0 ) then
		local records = {};
		for id, match in SSHonor_GetMatchRecord( day ) do
			table.insert( records, string.format( SSH_HONOR_ROW, match.name, GREEN_FONT_COLOR_CODE .. match.wins .. FONT_COLOR_CODE_CLOSE .. ":" .. RED_FONT_COLOR_CODE .. match.loses .. FONT_COLOR_CODE_CLOSE ) );
		end
	
		matchRecord = "\n" .. table.concat( records, "\n" );
	end
	
	-- Add rep
	local repList = {};
	local repution = "";
	
	if( SSHonor_Config[ day ]["rep"] ) then
		for rep, amount in SSHonor_Config[ day ]["rep"] do
			table.insert( repList, string.format( SSH_HONOR_ROW, rep, GREEN_FONT_COLOR_CODE .. amount .. FONT_COLOR_CODE_CLOSE ) );	
		end

		if( table.getn( repList ) > 0 ) then
			repution = "\n\n" .. string.format( SSH_HONOR_TT_REP, table.concat( repList, "\n" ) );
		end
	end
	
	-- Calculate honor per a minute/hour
	local honorSession = "";
	
	if( HonorThisSession > 0 and day == "today" ) then
		local elapsed = GetTime() - StartTime;
		local perHour = math.floor( ( HonorThisSession / elapsed ) * 3600 );
		local perMinute = math.floor( ( HonorThisSession / elapsed ) * 60 );
		
		if( elapsed < 3600 ) then
			perHour = "--";
		end

		if( elapsed < 60 ) then
			perMinute = "--";
		end
		
		honorSession = "\n\n" .. string.format( SSH_HONOR_TT_HONOR, 
				GREEN_FONT_COLOR_CODE .. SecondsToTime( elapsed ) .. FONT_COLOR_CODE_CLOSE,
				GREEN_FONT_COLOR_CODE .. math.floor( HonorThisSession ) .. FONT_COLOR_CODE_CLOSE,
				GREEN_FONT_COLOR_CODE .. perHour .. FONT_COLOR_CODE_CLOSE,
				GREEN_FONT_COLOR_CODE .. perMinute .. FONT_COLOR_CODE_CLOSE );
	end

	-- Now add it all together!
	local tooltip = string.format( SSH_HONOR_TT,
		GREEN_FONT_COLOR_CODE .. totalHonor .. FONT_COLOR_CODE_CLOSE,
		GREEN_FONT_COLOR_CODE .. killTotal .. FONT_COLOR_CODE_CLOSE,
		GREEN_FONT_COLOR_CODE .. killPercent .. FONT_COLOR_CODE_CLOSE,
		kill,
		GREEN_FONT_COLOR_CODE .. bonusTotal .. FONT_COLOR_CODE_CLOSE,
		GREEN_FONT_COLOR_CODE .. bonusPercent .. FONT_COLOR_CODE_CLOSE,
		bonus,
		GREEN_FONT_COLOR_CODE .. wins .. FONT_COLOR_CODE_CLOSE,
		--GREEN_FONT_COLOR_CODE .. winPercent .. FONT_COLOR_CODE_CLOSE,
		RED_FONT_COLOR_CODE .. loses .. FONT_COLOR_CODE_CLOSE,
		--RED_FONT_COLOR_CODE .. losePercent .. FONT_COLOR_CODE_CLOSE,
		matchRecord,
		honorSession
		) .. repution;
		
	return tooltip, SSH_HONOR_TT_TITLE;
end

function SSHonor_GetWins( day )
	local wins = 0;
	day = day or "today";
	
	for id, match in SSHonor_GetMatchRecord( day ) do
		wins = wins + match.wins;
	end
	
	return wins;
end

function SSHonor_GetLoses( day )
	local loses = 0;
	day = day or "today";
	
	for id, match in SSHonor_GetMatchRecord( day ) do
		loses = loses + match.loses;
	end
	
	return loses;
end

function SSHonor_GetMatchRecord( day )
	day = day or "today";
	local list = {};
	
	for name, match in SSHonor_Config[ day ]["matchrecord"] do
		table.insert( list, { name = name, wins = match.wins, loses = match.loses } );	
	end
	
	return list;
end

function SSHonor_UpdateHonorFrame( day )
	if( not SSHonor_Config.enabled ) then
		return;
	end
	
	day = day or "today";
	
	local HKFrame = "HonorFrame%sHK";
	local HonorFrame = "HonorFrame%sContribution";
		
	if( day == "today" ) then
		HKFrame = string.format( HKFrame, "Current" );
		HonorFrame = "SSHonorCurrentHonor";
		
		local row = getglobal( HKFrame .. "Value" );
		
		if( SSHonor_Config.killFix ) then
			row:SetText( SSHonor_GetTotalKills( "today" ) );
			row.killFix = true;
		
		-- We've disabled kill fix, reset it to the current data
		elseif( row.killFix ) then
			local todayKills = GetPVPSessionStats();
			row:SetText( todayKills );
			row.killFix = nil;
		end
		
		getglobal( HonorFrame .. "Value" ):SetText( math.floor( SSHonor_GetTotal( "kill" ) + 0.5 ) + SSHonor_GetTotal( "bonus" ) );
	elseif( day == "yesterday" ) then
		HKFrame = string.format( HKFrame, "Yesterday" );
		HonorFrame = string.format( HonorFrame, "Yesterday" );
	
	elseif( day == "thisweek" ) then
		HKFrame = string.format( HKFrame, "ThisWeek" );
		HonorFrame = string.format( HonorFrame, "ThisWeek" );
	
	elseif( day == "lastweek" ) then
		HKFrame = string.format( HKFrame, "LastWeek" );
		HonorFrame = string.format( HonorFrame, "LastWeek" );
	end
	
	local tooltip, title = SSHonor_CreateTooltip( day );
	getglobal( HKFrame ).title = title;

	HonorRow = getglobal( HonorFrame );
	HonorRow.tooltip = tooltip;
	
	if( not HonorRow.hooked ) then
		local Orig_OnEnter = HonorRow:GetScript( "OnEnter" );
		
		HonorRow:SetScript( "OnEnter", function() SSHonor_UpdateHonorFrame( this.day ); Orig_OnEnter(); end );
		HonorRow.day = day;
		HonorRow.hooked = true;
	end
end

function SSHonor_HonorFrame_OnShow()
	if( SSHonor_Config.enabled ) then
		SSHonorCurrentHonor:Show();
		HonorFrameCurrentDK:Hide();
	end

	SSHonor_CheckNewDay();
	SSHonor_UpdateHonorFrame( "today" );
	SSHonor_UpdateHonorFrame( "yesterday" );
	SSHonor_UpdateHonorFrame( "thisweek" );
	SSHonor_UpdateHonorFrame( "lastweek" );
	
	if( Orig_HonorFrame_OnShow ) then
		Orig_HonorFrame_OnShow();	
	end
end

function SSHonor_HonorFrame_OnHide()
	SSHonorCurrentHonor:Hide();
	
	if( Orig_HonorFrame_OnHide ) then
		Orig_HonorFrame_OnHide();
	end
end

function SSHonor_CheckNewDay()
	local yesterdayHK, _, yesterdayHonor = GetPVPYesterdayStats();
	local lastWeekHK, _, lastWeekHonor, lastWeekStanding = GetPVPLastWeekStats();
	local lifetimeHK = GetPVPLifetimeStats();	
	
	-- If we don't have kills in our lifetime and yesterday then
	-- data hasn't loaded yet, or we've never PvPed.
	if( lifetimeHK == 0 and yesterdayHK == 0 ) then
		return;
	end
	
	-- Check if hono rhas reset for the day
	if( yesterdayHonor ~= SSHonor_Config["yesterday"]["honor"] ) then
		local totalHonor = math.floor( SSHonor_GetTotal( "kill" ) + SSHonor_GetTotal( "bonus" ) );
		
		HonorThisSession = 0;
		
		-- Don't show the message if we didn't PVP
		if( yesterdayHonor ~= 0 and totalHonor ~= 0 ) then
			local difference = yesterdayHonor - totalHonor;

			if( difference < 0 ) then
				difference = difference * -1;
			end

			SSHonor_Message( string.format( SSH_HONOR_RESET, totalHonor, yesterdayHonor, difference ), ChatTypeInfo["SYSTEM"] );
		end
		
		-- Add this weeks data
		local merge = { "killed", "killhonor", "bonushonor", "rep" };
		for id, field in merge do
			for name, amount in SSHonor_Config["today"][ field ] do
				SSHonor_Config["thisweek"][ field ][ name ] = ( SSHonor_Config["thisweek"][ field ][ name ] or 0 ) + amount;
			end
		end

		for name, record in SSHonor_Config["today"]["matchrecord"] do
			if( not SSHonor_Config["thisweek"]["matchrecord"][ name ] ) then
				SSHonor_Config["thisweek"]["matchrecord"][ name ] = { wins = 0, loses = 0 };
			end
			
			SSHonor_Config["thisweek"]["matchrecord"][ name ].wins = ( SSHonor_Config["thisweek"]["matchrecord"][ name ].wins or 0 ) + record.wins;
			SSHonor_Config["thisweek"]["matchrecord"][ name ].loses = ( SSHonor_Config["thisweek"]["matchrecord"][ name ].loses or 0 ) + record.loses;
		end
				
		-- Update yesterdays data
		SSHonor_Config["yesterday"] = SSHonor_Config["today"];
		SSHonor_Config["yesterday"]["honor"] = yesterdayHonor;
		
		-- Reset todays data
		SSHonor_Config["today"] = SSHonor_GetDefaultTables();
	end

	-- Check if honor has reset for the week
	if( lastWeekHonor ~= SSHonor_Config["lastweek"]["honor"] ) then
		HonorThisSession = 0;
		
		SSHonor_Config["lastweek"] = SSHonor_Config["thisweek"];
		SSHonor_Config["lastweek"]["honor"] = lastWeekHonor;
		
		SSHonor_Config["thisweek"] = SSHonor_GetDefaultTables();
		
		SSHonor_UpdateHonorFrame( "thisweek" );
		SSHonor_UpdateHonorFrame( "lastweek" );

		if( lastWeekHK ~= 0 ) then
			SSHonor_Message( string.format( SSH_HONOR_RESET_WEEK, lastWeekHK, lastWeekHonor, lastWeekStanding ), ChatTypeInfo["SYSTEM"] );
		end
	end
end

function SSHonor_ParseString( text )
	text = string.gsub( text, "%)", "%%)" );
	text = string.gsub( text, "%(", "%%(" );
	text = string.gsub( text, "%:", "%%:" );

	text = string.gsub( text, "%%d", "([0-9]+)" );
	text = string.gsub( text, "%%s", "(.+)" );
	
	return text;
end

function SSHonor_PlayerLocation( returnCity )
	local zone = GetRealZoneText();
	
	if( zone == nil ) then
		return SSH_OTHER;
	end
	
	local _, PlayerFaction = UnitFactionGroup( "player" );
	
	if( returnCity ) then
		for id, city in SSH_CITIES do
			if( zone == city[1] and city[2] == PlayerFaction ) then
				return SSH_CITY;
			end
		end
	end
	
	return zone;
end

function SSHonor_PlayerInBG()
	for i=1, MAX_BATTLEFIELD_QUEUES do
		if( GetBattlefieldStatus( i ) == "active" ) then
			return true;
		end
	end
	
	return nil;
end

function SSHonor_GetOptionsEnabled()
	local options = { "actualhp", "estimatedhp", "killed", "split", "rankvalue" };
	local enabled = 0;
	
	for id, option in options do
		if( SSHonor_Config[ option ] ) then
			enabled = enabled + 1;
		end
	end
	
	return enabled;
end

function SSHonor_GetRankValue( name )
	for rankid, rank in SSH_RANKS do
		for _, rankName in rank.names do
			if( rankName == name ) then
				return rank.amount;
			end
		end
	end
	
	return 0;
end

function SSHonor_GetRankNumber( name )
	for rankid, rank in SSH_RANKS do
		for _, rankName in rank.names do
			if( rankName == name ) then
				return rankid;
			end
		end
	end
	
	return 0;
end


function SSHonor_ChatFrame_OnEvent( event )	
	if( event == "CHAT_MSG_COMBAT_HONOR_GAIN" ) then
		if( string.find( arg1, HKString ) ) then
			local _, _, name, rank, honor = string.find( arg1, HKString );
			
			if( KillMessages[ name ] ) then
				arg1 = KillMessages[ name ];
				KillMessages[ name ] = nil;
			end
		end
	end
	
	Orig_ChatFrame_OnEvent( event );
end

function SSHonor_KillMessageExample()
	DEFAULT_CHAT_FRAME:AddMessage( SSHonor_CreateKillMessage( SSH_KILL_EXAMPLE["name"], SSH_KILL_EXAMPLE["rank"], math.floor( SSHonor_GetRankValue( SSH_KILL_EXAMPLE["rank"] ) / 2 ), SSHonor_GetRankValue( SSH_KILL_EXAMPLE["rank"] ) ), ChatTypeInfo["COMBAT_HONOR_GAIN"].r, ChatTypeInfo["COMBAT_HONOR_GAIN"].g, ChatTypeInfo["COMBAT_HONOR_GAIN"].b );
end

function SSHonor_CreateKillMessage( name, rank, actualHonor, estimatedHonor )
	local killed = ( SSHonor_Config["today"]["killed"][ name ] or 1 );
	
	-- Work out what options are enabled
	local display = {};
	local enabledOptions = SSHonor_GetOptionsEnabled();

	if( SSHonor_Config.actualhp ) then
		if( enabledOptions > 2 ) then
			table.insert( display, string.format( SSH_ACTUAL, math.floor( actualHonor ) ) );	
		else
			table.insert( display, string.format( SSH_ACTUALHP, math.floor( actualHonor ) ) );
		end
	end

	if( SSHonor_Config.estimatedhp ) then
		if( enabledOptions > 2 ) then
			table.insert( display, string.format( SSH_ESTIMATED, estimatedHonor ) );	
		else
			table.insert( display, string.format( SSH_ESTIMATEDHP, estimatedHonor ) );
		end
	end

	if( SSHonor_Config.killed ) then
		table.insert( display, string.format( SSH_KILLED, killed ) );
	end
	
	if( SSHonor_Config.rankvalue ) then
		table.insert( display, string.format( SSH_RANKVALUE, SSHonor_GetRankValue( rank ) ) );
	end
	
	if( SSHonor_Config.ranknumber ) then
		rank = rank .. " (" .. SSHonor_GetRankNumber( rank ) .. ")";
	end

	if( SSHonor_Config.split ) then
		-- Figure out the honor split
		local rankWorth = SSHonor_GetRankValue( rank );

		if( rankWorth > 0 ) then
			table.insert( display, string.format( SSH_SPLIT, string.format( "%.2f", rankWorth / honor ) ) );
		end
	end

	if( enabledOptions > 0 ) then
		return string.format( SSH_COMBATLOG_HONORGAIN, name, rank, table.concat( display, ", " ) );
	end
	
	return nil;
end

function SSHonor_AddHonorKill( name, rank, honor )
	-- How many times have they died today?
	local killed = ( SSHonor_Config["today"]["killed"][ name ] or 0 ) + 1;
	local diminishing = 1.0;
	local actualHonor = 0;
	
	if( killed > 1 ) then
		diminishing = diminishing - ( ( killed - 1 ) / DIMINISHING_PER_KILL )
	end
	
	if( killed < MAX_KILLS ) then
		actualHonor = honor * diminishing;
	end
	
	-- Update records
	SSHonor_Config["today"]["killed"][ name ] = killed;
	SSHonor_AddHonor( actualHonor, "kill" );

	-- Add the kill message
	KillMessages[ name ] = SSHonor_CreateKillMessage( name, rank, actualHonor, honor );
end

function SSHonor_GetTotalKills( day )
	if( not day ) then
		day = "today";
	end
	
	if( not SSHonor_Config[ day ]["killed"] ) then
		return 0;
	end
	
	local total = 0;
	
	for name, killed in SSHonor_Config[ day ]["killed"] do
		total = total + killed;
	end
	
	return total;
end

function SSHonor_GetTotal( honortype, day )
	if( not day ) then
		day = "today";
	end
	
	if( not SSHonor_Config[ day ][ honortype .. "honor" ] ) then
		return 0;
	end
	
	local total = 0;
	for id, amount in SSHonor_Config[ day ][ honortype .. "honor" ] do
		total = total + amount;
	end
	
	return total
end

function SSHonor_AddHonor( amount, type )
	local location;
	if( type == "bonus" ) then
		location = SSHonor_PlayerLocation( true );
		
		if( location == SSH_CITY ) then
			location = SSH_MARK;
		end
	elseif( type == "kill" ) then
		location = SSHonor_PlayerLocation();
	end
	
	if( location == "" ) then
		location = SSH_UNKNOWN;
	end
	SSHonor_Config["today"][ type .. "honor" ][ location ] = ( SSHonor_Config["today"][ type .. "honor"][ location ] or 0 ) + amount;

	-- Update honor for this session
	HonorThisSession = HonorThisSession + amount;
	
	-- Display in SCT if loaded
	if( IsAddOnLoaded( "sct" ) and SCT and SCT.BlizzardCombatTextEvent ) then
		SCT.BlizzardCombatTextEvent( "HONOR_GAINED", math.floor( amount ), "SSHONOR" );
	end
	
	-- Update the estimation page if needed
	if( HonorFrame:IsVisible() ) then
		SSHonor_UpdateHonorFrame( "today" );
	end
end


function SSHonor_AddBonusHonor( honor )
	SSHonor_AddHonor( honor, "bonus" );
end

function SSHonor_AddRepution( rep, faction )
	if( faction == nil ) then
		return;
	end
	
	SSHonor_Config["today"]["rep"][ faction ] = ( SSHonor_Config["today"]["rep"][ faction ] or 0 ) + rep;
end

function SSHonor_SCT_BlizzardCombatTextEvent( larg1, larg2, larg3 )
	if( larg1 == "HONOR_GAINED" and larg3 == "SSHONOR" and SSHonor_Config.enabled ) then
		SCT:Display_Event( "SHOWHONOR", "+" .. math.floor( tonumber( larg2 ) ) .. " " .. HONOR );
	end
end

function SSHonor_SCTLoaded()
	if( not SCT or not SCT.Version ) then
		return;
	end
	
	if( not Orig_SCTBlizzardCombatTextEvent and SCT.BlizzardCombatTextEvent ) then
		Orig_SCT_BlizzardCombatTextEvent = SCT.BlizzardCombatTextEvent;
		SCT.BlizzardCombatTextEvent = SSHonor_SCT_BlizzardCombatTextEvent;
	end
end

function SSHonor_GetDefaultTables()
	defTable = {};
	defTable["killed"] = {};

	defTable["matchrecord"] = {};

	defTable["killhonor"] = {};
	defTable["bonushonor"] = {};

	defTable["rep"] = {};

	defTable["honor"] = 0;
	
	return defTable;
end

function SSHonor_AddBGWin( faction, day )
	local location = SSHonor_PlayerLocation();
	day = day or "today";
	
	if( not SSHonor_Config[ day ]["matchrecord"][ location ] ) then
		SSHonor_Config[ day ]["matchrecord"][ location ] = { wins = 0, loses = 0 };
	end
	
	local _, PlayerFaction = UnitFactionGroup( "player" );
	if( faction == PlayerFaction ) then
		SSHonor_Config[ day ]["matchrecord"][ location ].wins = ( SSHonor_Config[ day ]["matchrecord"][ location ].wins or 0 ) + 1;	
	else
		SSHonor_Config[ day ]["matchrecord"][ location ].loses = ( SSHonor_Config[ day ]["matchrecord"][ location ].loses or 0 ) + 1;	
	end
end

function SSHonor_OnEvent( event )
	if( event == "VARIABLES_LOADED" ) then
		if( SSHonor_Config == nil ) then
			SSHonor_Config = SSHonor_GetDefaultConfig( nil, true );	
		end		
		
		local days = { "yesterday", "today", "lastweek", "thisweek" };
		for _, day in days do
			if( not SSHonor_Config[ day ] ) then
				SSHonor_Config[ day ] = SSHonor_GetDefaultTables();
			end
			
			if( not SSHonor_Config[ day ]["matchrecord"] ) then
				SSHonor_Config[ day ]["matchrecord"] = {};
			end
		end

		-- Hook the honor frame
		Orig_HonorFrame_OnShow = HonorFrame:GetScript( "OnShow" );
		Orig_HonorFrame_OnHide = HonorFrame:GetScript( "OnHide" );
		Orig_HonorFrame_Update = HonorFrame_Update;
		
		HonorFrame:SetScript( "OnShow", SSHonor_HonorFrame_OnShow );
		HonorFrame:SetScript( "OnHide", SSHonor_HonorFrame_OnHide );
		HonorFrame_Update = SSHonor_HonorFrame_Update;
		
		-- Hook chat frames
		Orig_ChatFrame_OnEvent = ChatFrame_OnEvent;
		ChatFrame_OnEvent = SSHonor_ChatFrame_OnEvent;
		
		-- Parse out our string things
		HKString = SSHonor_ParseString( COMBATLOG_HONORGAIN );
		HBonusString = SSHonor_ParseString( COMBATLOG_HONORAWARD );
		RepString = SSHonor_ParseString( FACTION_STANDING_INCREASED );
		
		-- Misc stuff
		SSHonor_Config.version = SSHonorVersion;
		
		if( IsAddOnLoaded( "sct" ) ) then
			SSHonor_SCTLoaded();
		end

	-- Hook SCT if it hasn't loaded by the time we load
	elseif( event == "ADDON_LOADED" and arg1 == "sct" ) then
		SSHonor_SCTLoaded();
	
	-- Display the SSHonor this has been hooked message 
	elseif( event == "ADDON_LOADED" and arg1 == "sct_options" and SCT.OPTIONS ) then
		SCT.OPTIONS.FrameEventFrames[ SCT.LOCALS.OPTION_EVENT16.name ].tooltipText = SCT.OPTIONS.FrameEventFrames[ SCT.LOCALS.OPTION_EVENT16.name ].tooltipText .. SSH_SCTTOOLTIP;
	
	-- Hook for rank % and hiding the icon
	elseif( event == "ADDON_LOADED" and arg1 == "Blizzard_InspectUI" ) then
		Orig_InspectHonorFrame_Update = InspectHonorFrame_Update;
		InspectHonorFrame_Update = SSHonor_InspectHonorFrame_Update;

	-- For honor a minute/hour
	elseif( event == "PLAYER_LOGIN" ) then
		StartTime = GetTime();
		HonorThisSession = 0;
      	
      	-- Win/lose recording
	elseif( event == "UPDATE_BATTLEFIELD_STATUS" ) then
		for i=1, MAX_BATTLEFIELD_QUEUES do
			local status, map = GetBattlefieldStatus( i );
			
			if( status == "active" and GetBattlefieldWinner() == 0 ) then
				SSHonor_AddBGWin( "Horde" );
			elseif( status == "active" and GetBattlefieldWinner() == 1 ) then
				SSHonor_AddBGWin( "Alliance" );
			end
		end
		
	-- Reputation gain
	elseif( event == "CHAT_MSG_COMBAT_FACTION_CHANGE" ) then
		if( string.find( arg1, RepString ) ) then
			local _, _, factionName, amount = string.find( arg1, RepString );
			
			for id, faction in SSH_BGFACTIONS do
				if( faction == factionName ) then
					SSHonor_AddRepution( amount, faction );
					break;
				end
			end
		end
		
	
	-- Check new day
	elseif( event == "PLAYER_PVP_RANK_CHANGED" or event == "PLAYER_PVP_KILLS_CHANGED" ) then
		SSHonor_CheckNewDay();
		
	-- Honor gained through both killing and bonus
	elseif( event == "CHAT_MSG_COMBAT_HONOR_GAIN" ) then
		SSHonor_CheckNewDay();

		if( string.find( arg1, HKString ) ) then
			local _, _, name, rank, honor = string.find( arg1, HKString );
			
			SSHonor_AddHonorKill( name, rank, honor );			
		elseif( string.find( arg1, HBonusString ) ) then
			local _, _, honor = string.find( arg1, HBonusString );
			
			SSHonor_AddBonusHonor( honor );
		end
	end
end

function SSHonor_Message( msg, color )
	if( color == nil ) then
		color = { r = 1, g = 1, b = 1 };
	end
	
	DEFAULT_CHAT_FRAME:AddMessage( msg, color.r, color.g, color.b );
end

-- Variable management
function SSHonor_GetDefaultConfig( var, fullConfig )
	Config = {};
	Config.enabled = true;
	Config.showPercent = true;
	Config.hideIcon = true;
	Config.actualhp = true;
	Config.estimatedhp = true;
	Config.killed = true;
	Config.split = false;
	Config.killFix = false;
	Config.ranknumber = true;
	Config.rankvalue = false;
	
	if( fullConfig ) then
		return Config;
	elseif( var ) then
		return Config[ var ];
	end
	
	return nil;
end

function SSHonor_GetVariable( vars )
	if( SSHonor_Config[ vars[1] ] == nil ) then
		SSHonor_Config[ vars[1] ] = SSHonor_GetDefaultConfig( vars[1] );
	end
	
	return SSHonor_Config[ vars[1] ];
end

function SSHonor_SetVariable( vars, value )
	SSHonor_Config[ vars[1] ] = value;
end

function SSHonor_LoadUI()
	SSUI_RegisterVarType( "sshonor", "SSHonor_SetVariable", "SSHonor_GetVariable" );

	SSUI_AddTab( SSH_HONOR, "SSHonorConfig" );
	SSUI_AddFrame( "SSHonorConfig" );

	-- Add the elements
	local UIList = {
		{ name = "SSEnableSSHonor", text = SSH_UI_ENABLE, onClick = "HonorFrame_Update", type = "check", points = { "TOPLEFT", "TOPLEFT", 10, -10 }, varType = "sshonor", var = { "enabled" }, parent = "SSHonorConfig" },
		{ name = "SSShowPercent", text = SSH_UI_SHOWPERCENT, onClick = "HonorFrame_Update", type = "check", points = { "LEFT", "LEFT", 0, -30 }, varType = "sshonor", var = { "showPercent" }, parent = "SSHonorConfig" },
		{ name = "SSHideIcon", text = SSH_UI_HIDEICON, onClick = "HonorFrame_Update", type = "check", points = { "LEFT", "LEFT", 0, -30 }, varType = "sshonor", var = { "hideIcon" }, parent = "SSHonorConfig" },
		{ name = "SSShowActual", tooltip = SSH_UI_DEATHOPTIONS_TT, text = SSH_UI_SHOWACTUAL, type = "check", points = { "LEFT", "LEFT", 0, -30 }, varType = "sshonor", var = { "actualhp" }, parent = "SSHonorConfig" },
		{ name = "SSShowEstimated", tooltip = SSH_UI_DEATHOPTIONS_TT, text = SSH_UI_SHOWESTIMATED, type = "check", points = { "LEFT", "LEFT", 0, -30 }, varType = "sshonor", var = { "estimatedhp" }, parent = "SSHonorConfig" },
		{ name = "SSShowKilled", tooltip = SSH_UI_DEATHOPTIONS_TT, text = SSH_UI_SHOWKILLED, type = "check", points = { "LEFT", "LEFT", 0, -30 }, varType = "sshonor", var = { "killed" }, parent = "SSHonorConfig" },
		{ name = "SSRankNumber", tooltip = SSH_UI_RANKNUMBER_TT, text = SSH_UI_RANKNUMBER, type = "check", points = { "LEFT", "LEFT", 0, -30 }, varType = "sshonor", var = { "ranknumber" }, parent = "SSHonorConfig" },
		{ name = "SSRankValue", text = SSH_UI_RANKVALUE, tooltip = SSH_UI_RANKVALUE_TT, type = "check", points = { "LEFT", "LEFT", 0, -30 }, varType = "sshonor", var = { "rankvalue" }, parent = "SSHonorConfig" },
		{ name = "SSKillFix", text = SSH_UI_FIXKILLS, tooltip = SSH_UI_FIXKILLS_TT, type = "check", points = { "LEFT", "LEFT", 0, -30 }, varType = "sshonor", var = { "killFix" }, parent = "SSHonorConfig" },
		{ name = "SSKillTest", text = SSH_UI_KILLTEST, type = "button", onClick = "SSHonor_KillMessageExample", points = { "LEFT", "LEFT", -5, -30 }, parent = "SSHonorConfig" },
		--{ name = "SSShowSplit", text = SSH_UI_SHOWSPLIT, type = "check", points = { "LEFT", "LEFT", 0, -30 }, varType = "sshonor", var = { "split" }, parent = "SSHonorConfig" },
	}
	
	
	for _, element in UIList do
		SSUI_AddElement( element );
	end
end

-- For slash commands, Fubar and titan
function SSHonor_GetConfiguration()
	local config = {
		{ cmd = "enabled", var = "enabled", type = "toggle", localization = "MOD" }, 
		{ cmd = "reset", type = "execute", func = SSHonor_ResetHonor, localization = "RESET" }, 
		{ cmd = "actual", var = "actualhp", type = "toggle", localization = "ACTUALHP" }, 
		{ cmd = "estimated", var = "estimatedhp", type = "toggle", localization = "ESTIMATEDHP" }, 
		{ cmd = "killed", var = "killed", type = "toggle", localization = "KILLED" }, 
		{ cmd = "killfix", var = "killFix", type = "toggle", localization = "KILLFIX" }, 
		{ cmd = "percent", var = "showPercent", type = "toggle", localization = "PERCENT" }, 
		{ cmd = "icon", var = "hideIcon", type = "toggle", localization = "HIDEICON" }, 
		{ cmd = "example", type = "execute", func = SSHonor_KillMessageExample, localization = "EXAMPLE" }, 
		{ cmd = "rankn", var = "ranknumber", type = "toggle", localization = "RANKNUMBER" }, 
		{ cmd = "rankv", var = "rankvalue", type = "toggle", localization = "RANKVALUE" }, 
		{ cmd = "honor", type = "execute", func = function() ToggleCharacter( "HonorFrame" );  end, localization = "HONORFRAME" },
	};
	
	return config;
end

function SSHonor_ResetHonor()
	SSHonor_Config["yesterday"]["honor"] = -1;
	SSHonor_Config["lastweek"]["honor"] = -1;
	SSHonor_CheckNewDay();
end

function SSHonor_SlashHandler( msg )
	local command, commandArg, optionState, optionValue;
	
	if( msg ~= nil ) then
		command = string.gsub( msg, "(.+) (.+)", "%1" );
		commandArg = string.gsub( msg, "(.+) (.+)", "%2" );
		command = ( command or msg );
	end
	
	if( commandArg == "on" ) then
		optionState = GREEN_FONT_COLOR_CODE .. SSH_ON .. FONT_COLOR_CODE_CLOSE;
		optionValue = true;
	elseif( commandArg == "off" ) then
		optionState = RED_FONT_COLOR_CODE .. SSH_OFF .. FONT_COLOR_CODE_CLOSE;
		optionValue = false;
	end
	
	if( command == "on" ) then
		SSHonor_Config.enabled = true;
		SSHonor_Message( string.format( SSH_CMD_ENABLED, GREEN_FONT_COLOR_CODE .. SSH_ON .. FONT_COLOR_CODE_CLOSE ) );
		
		return;
	
	elseif( command == "off" ) then
		SSHonor_Config.enabled = false;
		SSHonor_Message( string.format( SSH_CMD_ENABLED, RED_FONT_COLOR_CODE .. SSH_OFF .. FONT_COLOR_CODE_CLOSE ) );
		
		return;
	
	elseif( command == "status" ) then
		-- Configuration status
		for _, config in SlashCommands do
			if( config.type == "toggle" ) then
				local state = RED_FONT_COLOR_CODE .. SSH_OFF .. FONT_COLOR_CODE_CLOSE;
				if( SSHonor_Config[ config.var ] ) then
					state = GREEN_FONT_COLOR_CODE .. SSH_ON .. FONT_COLOR_CODE_CLOSE;
				end
				
				SSHonor_Message( string.format( getglobal( "SSH_" .. config.localization .. "_CHANGED" ), state ) );
			end
		end
		
		return;
	else
		-- Now check slash commands
		for _, config in SlashCommands do
			if( config.cmd == command ) then
				
				if( config.type == "toggle" ) then
					SSHonor_Config[ config.var ] = optionValue;
					SSHonor_Message( string.format( getglobal( "SSH_" .. config.localization .. "_CHANGED" ), optionState ) );
					
					if( config.func ) then
						if( type( config.func ) == "string" ) then
							getglobal( config.func )();
						elseif( type( config.func ) == "function" ) then
							config.func();
						end
					end
				
					return;
					
				elseif( config.type == "execute" and config.func ) then
					local changed = getglobal( "SSH_" .. config.localization .. "_CHANGED" );
					if( changed ) then
						SSHonor_Message( changed );
					end
					
					if( config.func ) then
						if( type( config.func ) == "string" ) then
							getglobal( config.func )();
						elseif( type( config.func ) == "function" ) then
							config.func();
						end
					end
					
					return;
				end
			end
		end
	end
	
	-- Help
	for _, config in SlashCommands do
		if( config.type == "toggle" ) then
			SSHonor_Message( string.format( SSH_CMD_TOGGLE, config.cmd, getglobal( "SSH_" .. config.localization .. "_DESC" ) ), ChatTypeInfo["SYSTEM"] );
		elseif( config.type == "execute" ) then
			SSHonor_Message( string.format( SSH_CMD_EXECUTE, config.cmd, getglobal( "SSH_" .. config.localization .. "_DESC" ) ), ChatTypeInfo["SYSTEM"] );
		end
	end
end
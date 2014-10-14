--[[
	CensusPlus for World of Warcraft(tm).
	
	Copyright 2005 - 2006 Cooper Sellers and WarcraftRealms.com

	License:
		This program is free software; you can redistribute it and/or
		modify it under the terms of the GNU General Public License
		as published by the Free Software Foundation; either version 2
		of the License, or (at your option) any later version.

		This program is distributed in the hope that it will be useful,
		but WITHOUT ANY WARRANTY; without even the implied warranty of
		MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
		GNU General Public License for more details.

		You should have received a copy of the GNU General Public License
		along with this program(see GLP.txt); if not, write to the Free Software
		Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
]]


------------------------------------------------------------------------------------
--
-- CensusPlus - PVP section
-- A WoW UI customization by Cooper Sellers
--
--
------------------------------------------------------------------------------------

local damagedTable = { };

-----------------------------------------------------------------------------------
--
-- CensusPlus_PVPDeath --  Someone dies
--
-----------------------------------------------------------------------------------
function CensusPlus_PVPDeath( msg )

	
--	CensusPlus_Msg( "Msg = " .. msg );
--    local value = string.sub( msg, 0, index-1 );
end

-----------------------------------------------------------------------------------
--
-- CensusPlus_PVPDamage --  Damage is done
--
-----------------------------------------------------------------------------------
function CensusPlus_PVPDamage( victim, dmg )
	local dealer = "player";
	local vict   = "target";
	if( victim == "player" ) then
		-- Hit us instead
	end
end


-----------------------------------------------------------------------------------
--
-- CensusPlus_ProcefssHonorInpsect --  Process honor inspect
--
-----------------------------------------------------------------------------------
function CensusPlus_ProcessHonorInpsect()
	local todayHK, todayDK, 
	      yesterdayHK, yesterdayDK, 
	      thisweekHK, thisweekHonor, 
	      lastweekHK, lastweekHonor, lastweekStanding, 
	      lifetimeHK, lifetimeDK, lifetimeHighestRank = GetInspectHonorData() 
		
	if( g_CensusPlusLastTarget ~= nil ) then
		g_CensusPlusLastTarget[4] = lifetimeHK;
		g_CensusPlusLastTarget[5] = CensusPlus_DetermineServerDate() .. "&" .. lastweekHonor .. "&" .. lastweekStanding;
		g_CensusPlusLastTarget[6] = lifetimeHighestRank;

		g_CensusPlusLastTarget[7] = CensusPlus_DetermineServerDate() .. "";
	end

	local unit = InspectFrame.unit;
	
--	ClearInspectPlayer();
	g_CensusPlusLastTargetName = nil;
	g_CensusPlusLastTarget = nil;
--	InspectFrame.unit = nil;
end

-----------------------------------------------------------------------------------
--
-- CensusPlus_ProcessMyHonor --  Process player honor
--
-----------------------------------------------------------------------------------
function CensusPlus_ProcessMyHonor()
	--
	-- Get the portion of the database for this server
	--
	local realmName = g_CensusPlusLocale .. GetCVar("realmName");
	local realmDatabase = CensusPlus_Database["Servers"][realmName];
	if (realmDatabase == nil) then
		CensusPlus_Database["Servers"][realmName] = {};
		realmDatabase = CensusPlus_Database["Servers"][realmName];
	end

	--
	-- Get the portion of the database for this faction
	--
	local factionGroup = UnitFactionGroup("player");
	local factionDatabase = realmDatabase[factionGroup];
	if (factionDatabase == nil) then
		realmDatabase[factionGroup] = {};
		factionDatabase = realmDatabase[factionGroup];
	end
	
	--
	-- Get racial database
	--
	local raceGroup = UnitRace("player");
	local raceDatabase = factionDatabase[raceGroup];
	if (raceDatabase == nil) then
		factionDatabase[raceGroup] = {};
		raceDatabase = factionDatabase[raceGroup];
	end

	--
	-- Get class database
	--
	local classGroup = UnitClass( "player" );
	local classDatabase = raceDatabase[classGroup];
	if (classDatabase == nil) then
		raceDatabase[classGroup] = {};
		classDatabase = raceDatabase[classGroup];
	end

	--
	-- Get this player's entry
	--
	local playerName = UnitName( "player" );
	local entry = classDatabase[playerName];
	if (entry == nil) then
		classDatabase[playerName] = {};
		entry = classDatabase[playerName];
	end
	
	local honorableKills, dishonorableKills, highestRank = GetPVPLifetimeStats(); 
	local lwhk, lwdk, lwcontribution, lwrank = GetPVPLastWeekStats() 
	
	--
	-- Update the information
	--
	
	entry[1] = UnitLevel("player");
	entry[2], rank, index = GetGuildInfo("player");
	entry[3] = CensusPlus_DetermineServerDate() .. "";
	entry[4] = honorableKills;
	

	entry[5] = CensusPlus_DetermineServerDate() .. "&" .. lwcontribution .. "&" .. lwrank;
--	entry[5] = dishonorableKills;
	entry[6] = highestRank;

	entry[7] = CensusPlus_DetermineServerDate() .. "";
	
	if( entry ~= nil ) then
		rankNumber = UnitPVPRank("player");
		if( rankNumber ~= 0 ) then
--			rankName= GetPVPRankInfo( rankNumber ) 		
			entry[8] = rankNumber;  --  slot 8 will be current rank
		else
			entry[8] = 0;  --  slot 8 will be current rank
		end
	end
end

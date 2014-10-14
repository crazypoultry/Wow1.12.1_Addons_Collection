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
-- CensusPlus
-- A WoW UI customization by Cooper Sellers
--
--
------------------------------------------------------------------------------------

local g_PlayerList = {};			
local g_PlayerLookupTable = {};				
local CensusPlus_NumPlayerButtons = 20;
local g_MaxNumListed = 1000;

function CensusPlus_ShowPlayerList()
	CP_PlayerListWindow:Show();
end

function CensusPlus_PlayerListOnShow()

	debugprofilestart();
	
	local guildKey = nil;
	local raceKey = nil;
	local classKey = nil;
	local levelKey = nil;
	

	--
	--  Clear our character list
	--
	CensusPlus_ClearPlayerList();
	
	--
	-- Get realm and faction
	--
	local realmName = g_CensusPlusLocale .. GetCVar("realmName");
	if( realmName == nil ) then
		return;
	end

	local factionGroup = UnitFactionGroup("player");
	if( factionGroup == nil ) then
		return;
	end
	

	--
	-- Has the user made any selections?
	--
	if (g_GuildSelected > 0) then
		guildKey = CensusPlus_Guilds[g_GuildSelected].m_Name;
	end
	if (g_RaceSelected > 0) then
		local thisFactionRaces = CensusPlus_GetFactionRaces(factionGroup);
		raceKey = thisFactionRaces[g_RaceSelected];
	end
	if (g_ClassSelected > 0) then
		local thisFactionClasses = CensusPlus_GetFactionClasses(factionGroup);
		classKey = thisFactionClasses[g_ClassSelected];
	end
	if (g_LevelSelected > 0 or g_LevelSelected < 0) then
		levelKey = g_LevelSelected;
	end

	debugprofilestart();

	CensusPlus_ForAllCharacters( realmName, factionGroup, raceKey, classKey, guildKey, levelKey, CensusPlus_AddPlayerToList);
		
	if( CensusPlus_EnableProfiling ) then
		CensusPlus_Msg( "PROFILE: Time to do calcs 1 " .. debugprofilestop() / 1000000000 );
		debugprofilestart();
	end
		

	--
	--  Build our list
	--
	CensusPlus_UpdatePlayerListButtons();
	
	local totalCharactersText = format(CENSUSPlus_TOTALCHAR, table.getn( g_PlayerList ) );
	if( table.getn( g_PlayerList ) == g_MaxNumListed ) then
		totalCharactersText = totalCharactersText .. " -- " .. CENSUSPlus_MAXXED;
	end
	
	CensusPlayerListCount:SetText(totalCharactersText);

end

----------------------------------------------------------------------------------
--
-- Predicate function which can be used to compare two characters for sorting
--
---------------------------------------------------------------------------------
local function CharacterPredicate(lhs, rhs)
	--
	-- nil references are always less than
	--
	if (lhs == nil) then
		if (rhs == nil) then
			return false;
		else
			return true;
		end
	elseif (rhs == nil) then
		return false;
	end
	--
	-- Sort by name
	--
	if (lhs.m_name < rhs.m_name) then
		return true;
	elseif (rhs.m_name < lhs.m_name) then
		return false;
	end

	--
	-- Sort by level
	--
	if (lhs.m_level < rhs.m_level) then
		return true;
	elseif (rhs.m_level < lhs.m_level) then
		return false;
	end

	--
	-- identical
	--
	return false;
end

local function CensusPlus_UpdatePlayerLookup( index, entry )
	--
	--  Have to update our table
	--
	g_PlayerLookupTable[entry.m_name] = index;
end
		


----------------------------------------------------------------------------------
--
-- Update the Player button contents
--
---------------------------------------------------------------------------------
function CensusPlus_UpdatePlayerListButtons()
	--
	--  Sort the list
	--
	local size = table.getn(g_PlayerList);
	if (size) then
		table.sort(g_PlayerList, CharacterPredicate);
		
		table.foreach(g_PlayerList, CensusPlus_UpdatePlayerLookup );
		
	end
	
	--
	-- Determine where the scroll bar is
	--
	local offset = FauxScrollFrame_GetOffset( CensusPlusPlayerListScrollFrame );
	--
	-- Walk through all the rows in the frame
	--
	local i = 1;
	while( i <= CensusPlus_NumPlayerButtons ) do
		--
		-- Get the index to the ad displayed in this row
		--
		local iPlayer = i + offset;
		--
		-- Get the button on this row
		--
		local button = getglobal("CensusPlusPlayerButton"..i);
		--
		-- Is there a valid Player on this row?
		--
		if (iPlayer <= size) then
			local player = g_PlayerList[iPlayer];
			--
			-- Update the button text
			--
			button:Show();
			local textField = "CensusPlusPlayerButton"..i.."Name";
			if ( player.m_name == nil or player.m_name == "") then
				getglobal(textField):SetText( "None" );
			else
				getglobal(textField):SetText( player.m_name );
			end
			
			local textField = "CensusPlusPlayerButton"..i.."Level";
			if ( player.m_level == nil or player.m_level == "") then
				getglobal(textField):SetText( "n/a" );
			else
				getglobal(textField):SetText( player.m_level );
			end
			
			local textField = "CensusPlusPlayerButton"..i.."Class";
			if ( player.m_guild == nil or player.m_guild == "") then
				getglobal(textField):SetText( "Unguilded" );
			else
				getglobal(textField):SetText( player.m_guild );
			end
		else
			--
			-- Hide the button
			--
			button:Hide();
		end
		--
		-- Next row
		--
		i = i + 1;
	end
	--
	-- Update the scroll bar
	--
	FauxScrollFrame_Update(CensusPlusPlayerListScrollFrame, size, CensusPlus_NumPlayerButtons, CensusPlus_GUILDBUTTONSIZEY);
end

----------------------------------------------------------------------------------
--
-- Find a characters in the g_PlayerList array by name
--
---------------------------------------------------------------------------------
function CensusPlus_PlayerButton_OnClick()
	local id = this:GetID();
	local offset = FauxScrollFrame_GetOffset( CensusPlusPlayerListScrollFrame );
	local newSelection = id + offset;

	local player = g_PlayerList[newSelection];
	FriendsFrame_ShowDropdown(player.m_name, 1);
end

----------------------------------------------------------------------------------
--
-- Clear all the characters
--
---------------------------------------------------------------------------------
function CensusPlus_ClearPlayerList()
	g_PlayerList = nil;
	g_PlayerList = {};
	
	g_PlayerLookupTable = nil;
	g_PlayerLookupTable = {};
end

----------------------------------------------------------------------------------
--
-- Add a character to the list
--
---------------------------------------------------------------------------------
function CensusPlus_AddPlayerToList( name, level, guild )
	local size = table.getn( g_PlayerList );
	
	if( size >= g_MaxNumListed ) then
		return;
	end

	local index = g_PlayerLookupTable[name];
	if (index == nil) then
		local size = table.getn( g_PlayerList );
		index = size + 1;
		g_PlayerList[index] = { m_name = name, m_level = level, m_guild = guild };
		g_PlayerLookupTable[name] = index;
	end
end


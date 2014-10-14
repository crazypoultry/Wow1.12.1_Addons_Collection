--------------------------------------------------------------------------------
-- 
-- Name: TravelerUtil.lua
-- Author: Malex-Cenarius
-- Date: 11/21/2006
--
--------------------------------------------------------------------------------




--------------------------------------------------------------------------------
--
-- Method: out
-- Description: Used for debugging.
-- Arguments: 
--  text - [in] The text to output
--
--------------------------------------------------------------------------------
function out(text)
	DEFAULT_CHAT_FRAME:AddMessage(text);
	UIErrorsFrame:AddMessage(text, 1.0, 1.0, 0, 1, 10);
end


--------------------------------------------------------------------------------
--
-- Method: Traveler_GetValueByIndex
-- Description: A very bad way of getting an indexed value out of a table.  It
--  iterates through the table until the index counter reaches zero.
-- Arguments:
-- Notes:
--
--------------------------------------------------------------------------------
function Traveler_GetValueByIndex(data, index)
	
	if(index <= 0 or index > data.Size) then		
		return nil;
	end		
	
	for key, value in pairs(data) do
	
		if(type(value) == "table") then		
			index = index - 1;
			
			if(index == 0) then
				return value;
			end
		end		
	end
end

--------------------------------------------------------------------------------
--
-- Method: Traveler_IsUserInPartyOrRaid
-- Description: Used to determine if a particular user is in the player's party
--  or raid
-- Arguments:
--	name - The name of the user being queried
-- Returns:
--	True if [name] is in the player's party, false otherwise
--
--------------------------------------------------------------------------------
function Traveler_IsUserInPartyOrRaid(name)

	for i=1,GetNumPartyMembers() do
		unitId = "party" .. i;
		
		if(UnitName(unitId) == name) then
			return true;
		end
	end
	
	for i=1,GetNumRaidMembers() do
		unitId = "raid" .. i;
		
		if(UnitName(unitId) == name) then
			return true;
		end
	end
	
	return false;	
end

--------------------------------------------------------------------------------
--
-- Method: Traveler_GetTexCoordsForRaceGender
-- Description: Returns texture coordinates given a race/gender in the texture
--	that contains all the race/gender pictures
-- Arguments:
--	raceIndex - [in] The 1-based index of the race from the global TravelerRaces table
--	gender - [in] A character representing the race
--
--------------------------------------------------------------------------------
function Traveler_GetTexCoordsForRaceGender(raceIndex, gender)

	local texLeft = mod(raceIndex - 1, 4) * 0.25;
	
	local texTop = 0;
	if(tonumber(raceIndex) > 4) then
		texTop = 0.25;
	end
	
	if(gender == "F") then
		texTop = texTop + 0.5;
	end
	
	local texRight = texLeft + 0.25;
	local texBottom = texTop + 0.25;


	return texLeft, texRight, texTop, texBottom;

end

--------------------------------------------------------------------------------
--
-- Method: Traveler_IsWarlock
-- Description: Determines if the player is a warlock
-- Returns: True if the player is a warlock, false otherwise.
--
--------------------------------------------------------------------------------
function Traveler_IsWarlock()

	classLoc, class = UnitClass("player");
	if(string.lower(class) == "warlock") then
		return true;
	else
		return false;
	end

end

--------------------------------------------------------------------------------
--
-- Method: Traveler_IsMage
-- Description: Determines if the player is a mage
-- Returns: True if the player is a mage, false otherwise.
--
--------------------------------------------------------------------------------
function Traveler_IsMage()

	classLoc, class = UnitClass("player");
	if(string.lower(class) == "mage") then
		return true;
	else
		return false;
	end

end


--------------------------------------------------------------------------------
--
-- Method: Traveler_ShowTooltip
-- Description: Show's a tooltip for a control
-- Arguments:
--	header - [in] The header for the tooltip
--	message - [in] The message of the tooltip
--	conditional - [optional][in] A function that defines whether the tooltip 
--		is shown or not
--
--------------------------------------------------------------------------------
function Traveler_ShowTooltip(header, message, conditional)

	if(conditional == nil or conditional()) then
		GameTooltip:SetOwner( getglobal(this:GetName()), "ANCHOR_TOP" );
		GameTooltip:ClearLines();
		GameTooltip:ClearAllPoints();
		GameTooltip:SetPoint("TOPLEFT", this:GetName(), "BOTTOMLEFT", 0, -2);		
		GameTooltip:AddLine(header);
		GameTooltip:AddLine(message, 1, 1, 1, 1, 1 );
		GameTooltip:Show();
	end
	
end

--------------------------------------------------------------------------------
--
-- Method: Traveler_HideTooltip
-- Description: Hides the tooltip
--
--------------------------------------------------------------------------------
function Traveler_HideTooltip()

	GameTooltip:Hide();

end

--------------------------------------------------------------------------------
--
-- Method: Traveler_GetSubZone
-- Description: Returns the subzone of the player
--
--------------------------------------------------------------------------------
function Traveler_GetSubZone()
	local subZone = GetSubZoneText();
	if(subZone == "") then
		subZone = GetRealZoneText();
	end

	return subZone;

end

--------------------------------------------------------------------------------
--
-- Method: Traveler_GetZone
-- Description: Returns the zone of the player
--
--------------------------------------------------------------------------------
function Traveler_GetZone()
	return GetRealZoneText();
end


--------------------------------------------------------------------------------
--
-- Method: Traveler_CheckSpells
-- Description: Figures out which spells are available for summoning/porting
--
--------------------------------------------------------------------------------
function Traveler_CheckSpells()

	local i = 1;
	while true do
	
		local spellName, spellRank = GetSpellName(i, BOOKTYPE_SPELL);
		
		if(spellName == nil) then
			return;
		end
		
		if(strsub(spellName, 1, 6) == "Portal") then
			TravelerHasSummon = true;
		elseif(string.lower(spellName) == "ritual of summoning") then
			TravelerHasSummon = true;
		end
		
		i = i + 1;
	
	end

end
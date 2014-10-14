--[[
Reputation2
Author:   Gerhard Karnik
Version:  1.0
Release:  6/22/2006

Two functions:
1. On faction hits, shows numeric values for *all* factions involved not just the main faction.
2. Shows the numeric progress towards the next faction standing, like "(1200/6000)".

Note: In your Faction display window, you must have the faction row expanded, ("+" sign clicked),
to see the faction gain/loss messages for that faction. Conversely, if you want to ignore those
faction messages, then close that faction's row in the Faction display window.

This is a very simple, low-resource mod.

Based on "Reputation" by Egris & Karmond which is no longer being updated
(http://www.curse-gaming.com/mod.php?addid=299).

No slash commands or UI.
]]

Reputations = {};
REPUTATIONS_CHAT_FRAME = getglobal("ChatFrame2");	--Rep messages to Combat Window

function Reputation2_OnLoad()
	this:RegisterEvent("UPDATE_FACTION");
end

function Reputation2_OnEvent()
	local factionIndex, difference, txt;
	local name, standingID, barValue, barMin, barMax, isHeader;
	local numFactions = GetNumFactions();

	for factionIndex=1, numFactions, 1 do
		name, _, standingID, barMin, barMax, barValue, _, _, isHeader, _ = GetFactionInfo(factionIndex);
		if(not isHeader) then
			if(Reputations[name]) then
				difference = barValue - Reputations[name].Value;
				if(difference ~= 0) then
					if(difference > 0) then
						txt = FACTION_STANDING_INCREASED;	--Reputation went up
					else
						txt = FACTION_STANDING_DECREASED;	--Reputation went down
						difference = difference * -1;
					end;
					txt = format(txt, name, difference).." ("..barValue-barMin.."/"..barMax-barMin..")";
					REPUTATIONS_CHAT_FRAME:AddMessage(txt, 0.5, 0.5, 1.0);

					if(Reputations[name].standingID ~= standingID) then
						REPUTATIONS_CHAT_FRAME:AddMessage(format(FACTION_STANDING_CHANGED,getglobal("FACTION_STANDING_LABEL"..standingID),name), 1.0, 1.0, 0.0);
					end
				end
			else
				Reputations[name] = {};
			end

			Reputations[name].standingID = standingID;
			Reputations[name].Value = barValue;
		end
	end
end

local RED			= "|cffff0000";
local YELLOW		= "|cffffff00";
local GREEN			= "|cff00ff00";


function BGMinimapPlayerTracker_OnUpdate()
	if  (not WorldStateScoreFrame:IsVisible()) then
		RequestBattlefieldScoreData();
	end

	if (BGMinimapPlayerTracker_MouseCheck()) then
		-- only proceed if tooltip is showing
		if (GameTooltip:IsVisible()) then
			BGMinimapPlayerTracker_Process_Tooltip_MouseOver("Game");
		elseif (WorldMapTooltip:IsVisible()) then
			BGMinimapPlayerTracker_Process_Tooltip_MouseOver("World");
		end
	end
end

--------------------------------------------------------------------------------
-- checks if the mouse should be processed
--------------------------------------------------------------------------------
function BGMinimapPlayerTracker_MouseCheck()
	local result = false;
	if (Minimap and GetMouseFocus()) then
		frameName = GetMouseFocus():GetName();
		if (frameName and (frameName == "Minimap" or string.find(frameName, "WorldMap") or string.find(frameName, "BattlefieldMinimap"))) then
			result = true;
		end
	end
	return result;
end

--------------------------------------------------------------------------------
-- process the tooltip resulting from a mouse over
--------------------------------------------------------------------------------
function BGMinimapPlayerTracker_Process_Tooltip_MouseOver(tipToCheck)

	local tipline;
	if (tipToCheck == "World") then
		tipline = WorldMapTooltipTextLeft1:GetText();
	elseif (tipToCheck == "Game") then
		tipline = GameTooltipTextLeft1:GetText();
	end
	
	local numChars = GetNumBattlefieldScores();
	if (numChars > 0) then
		local text;
		-- For every posbile line in the tooltip
		for i = 1, 30 do
			nameFromToolTip = BGMinimapPlayerTracker_GetLine(tipline, i);
			-- If there stand someting on the line
			if (nameFromToolTip ~= "") then
				if (not string.find(nameFromToolTip, YELLOW)) then
					found = "Unknown";
					for p = 1, numChars do
						name, _, _, _, _, faction, _, _, class = GetBattlefieldScore(p);
						if (string.find(name, "-")) then
							name = string.sub(name, 0,  string.find(name,"-") - 1);
						end
						if (string.find(nameFromToolTip, "|")) then
							local from = string.find(nameFromToolTip, "|")
							local tmpString = string.sub(nameFromToolTip, 11);
							if (string.find(tmpString, "|")) then
								local to = string.find(tmpString, "|");
								nameFromToolTip = string.sub(tmpString, 0, to -1);
							end
						end
						if (name == nameFromToolTip) then
							found = true;
							local color;
							if (faction == 0) then
								color = RED;
							elseif (faction == 1) then
								color = GREEN;
							end
							if (i > 1 and text) then
								text = text .. "\n";
								text = text .. color .. name .. YELLOW .. "[" .. class .. "]";
							else
								text = color .. name .. YELLOW .. "[" .. class .. "]";
							end
							break;
						else
							found = "No";
						end
					end
					if (found == "No") then
						if (i > 1 and text) then
							text = text .. "\n";
							text = text .. nameFromToolTip .. YELLOW .. "[" .. "Unknown" .. "]";
						else
							text = nameFromToolTip .. YELLOW .. "[" .. "Unknown" .. "]";
						end
					end
				end
			else
				break;
			end
		end
		if (text) then
			if (tipToCheck == "World") then
				WorldMapTooltipTextLeft1:SetText(text);
				WorldMapTooltip:Show();
			elseif (tipToCheck == "Game") then
				GameTooltipTextLeft1:SetText(text);
				GameTooltip:Show();
			end
		end
	end
end


--------------------------------------------------------------------------------
-- retrieves the specified line from the string
--------------------------------------------------------------------------------
function BGMinimapPlayerTracker_GetLine(s,line)
   if (s) then
		local tmp = s;
		local curLineNum = 0;
		local result = "";
		while (curLineNum < line) do
		  curLineNum = curLineNum + 1;
		  local idx = string.find(tmp,"\n");
		  if (idx == nil) then
			 result = tmp;
			 break;
		  else
			 result = string.sub(tmp,1,idx-1);
			 tmp = string.sub(tmp,idx+1,string.len(tmp));
		  end
		end   
		if (curLineNum ~= line) then
		  result = "";
		end
		return result;
	else
		return nil;
	end
end
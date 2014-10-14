local NoteItOriginalSetItemRef;

function NoteIt_Init()
	NoteItOriginalSetItemRef = SetItemRef;
	SetItemRef = NoteIt_SetItemRef;
	noteItDeadTip = string.sub(CORPSE_TOOLTIP, 0, string.len(CORPSE_TOOLTIP)-2);
end

function NoteIt_OnShow()
	local firstLine;
	local change = false;
	if noteItAddGuild then
		local guildname = GetGuildInfo("mouseover");
		if(guildname) then
			GameTooltip:AddLine("<"..guildname..">", 1.0, 1.0, 1.0);
			change = true;
		end
	end
	if UnitExists("mouseover") then
		firstLine = UnitName("mouseover");
		--Print("Unit Tooltip!");
		
	else
		firstLine = getglobal("GameTooltipTextLeft1"):GetText();
		if string.find(firstLine, noteItDeadTip) then
			firstLine = string.sub(firstLine, string.len(noteItDeadTip)+1);
		end
	end
	if firstLine and noteIt then
		if noteIt[firstLine] then
			--Print("adding note");
			if UnitExists("mouseover") and noteItPlaySound then
				PlaySound("FriendJoinGame");
			end
			if (noteItMode == 1 and UnitName("player") == noteIt[firstLine][2]) or
				(noteItMode == 2 and GetCVar("realmName") ==  noteIt[firstLine][3]) or
				noteItMode == 3 then
				comment = noteIt[firstLine][1];
	
				local oneLine = GetNextBreak(comment);
				while oneLine do
					local firstLine = string.sub(comment, 0, oneLine);
					comment = string.sub(comment, oneLine+1);
					GameTooltip:AddLine(firstLine, noteItColour.r, noteItColour.g, noteItColour.b);
					--getglobal("GameTooltipTextLeft"..GameTooltip:NumLines()):Show();
					oneLine = GetNextBreak(comment);
				end

				GameTooltip:AddLine(comment, noteItColour.r, noteItColour.g, noteItColour.b);
				--getglobal("GameTooltipTextLeft"..GameTooltip:NumLines()):Show();
				change = true;
			end
		end
	end
	if change then
		GameTooltip:Show();
	end
end

function NoteIt_SetItemRef(link, arg1, arg2)
	NoteItOriginalSetItemRef(link, arg1, arg2);
	if ( strsub(link, 1, 6) == "player" ) then
		local name = strsub(link, 8);
		if ( name and (strlen(name) > 0) ) then
			if ( IsShiftKeyDown() ) then
				if noteIt[name] and DEFAULT_CHAT_FRAME then
					local colourString = NoteInputFrame_NumberToHex(noteItColour.r)..NoteInputFrame_NumberToHex(noteItColour.g)..NoteInputFrame_NumberToHex(noteItColour.b);
					DEFAULT_CHAT_FRAME:AddMessage("|cff"..colourString..noteIt[name][1].."|r");
				end
			end
		end
	end
end

function GetNextBreak(queryString)
	local oneLineSpace = string.find(comment, " " , 40);
	local oneLineFeed = string.find(comment, "\n");
	if oneLineSpace == nil then
		return oneLineFeed;
	end
	if oneLineFeed == nil then
		return oneLineSpace;
	end
	if oneLineSpace < oneLineFeed then
		return oneLineSpace;
	else
		return oneLineFeed;
	end
end

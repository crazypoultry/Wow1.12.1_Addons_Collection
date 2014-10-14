-- MetaMapNBK
-- Written by MetaHawk - aka Urshurak

NBK_TotalButtons = 0;
NBK_ButtonHeight = 12;
NBK_NoteList = {};

NBK_Default = {
	["Tooltips"]   = false,
	["ShowGuild"]  = false,
	["PlaySound1"] = false,
	["PlaySound2"] = false,
	["FrameScale"] = 1.0,
	["ListColor"] = {0.95, 0.80, 0.30},
	["HeadColor"] = {1.0, 1.0, 1.0},
	["TextColor"] = {0.0, 0.75, 0.75},
	["TtipColor"] = {0.0, 0.75, 0.75},
}

function NBK_OnLoad()
	this:RegisterEvent("ADDON_LOADED");
end

function NBK_OnEvent(event)
	if(event == "ADDON_LOADED" and arg1 == "MetaMapNBK") then
		if(NBK_Options == nil) then NBK_Options = {}; end
		for option, value in pairs(NBK_Default) do
			if(NBK_Options[option] == nil) then NBK_Options[option] = value; end
		end
		NBK_Default = nil;
		if(NBK_NoteBookData == nil) then NBK_NoteBookData = {}; end
		if(MetaMapNBK_NoteBook) then NBK_NoteBookData = MetaMapNBK_NoteBook; end
		MetaMapNBK_NoteBook = nil;
		NBK_NotesRefresh();
	end
end

function NBK_SortList()
	local tmp = MetaMap_sortType;
	MetaMap_sortType = METAMAP_SORTBY_NAME;
	NBK_NoteList = {};
	for index, value in pairs(NBK_NoteBookData) do
		tinsert(NBK_NoteList, {name = value.Header, Index = index});
	end
  table.sort(NBK_NoteList, MetaMap_SortCriteria);
	MetaMap_sortType = tmp;
end

function NBK_NotesRefresh(current)
	local R, G, B;
	local button;
	local buttonCount = 0;
	NBK_SortList();
	for index, value in pairs(NBK_NoteList) do
		if(getglobal("NBK_NoteButton"..index)) then
			button = getglobal("NBK_NoteButton"..index);
		else
			button = CreateFrame("Button" ,"NBK_NoteButton"..index, NBK_ScrollFrame, "MetaMap_ScrollButtonTemplate");
			NBK_TotalButtons = NBK_TotalButtons +1;
		end
		button:SetScript("OnClick", function() NBK_NoteBookOnClick(this:GetID()); end);
		button:SetWidth(button:GetParent():GetWidth());
		button:SetHeight(NBK_ButtonHeight);
		button:SetID(value.Index);
		R, G, B = unpack(NBK_Options.ListColor);
		getglobal("NBK_NoteButton"..index.."Text"):SetTextColor(R, G, B)
		getglobal("NBK_NoteButton"..index.."Text"):SetText(NBK_NoteBookData[value.Index].Header)
		if(index == 1) then
			button:SetPoint("TOPLEFT", "NBK_ScrollFrame", "TOPLEFT", 15, -5);
		else
			button:SetPoint("TOPLEFT", getglobal("NBK_NoteButton"..index -1), "TOPLEFT", 0, -15);
		end
		button:Show();
		buttonCount = index;
	end
	for i=buttonCount+1, NBK_TotalButtons do
		getglobal("NBK_NoteButton"..i):Hide()
	end
	R, G, B = unpack(NBK_Options.HeadColor);
	NBK_NoteTitle:SetTextColor(R, G, B);
	R, G, B = unpack(NBK_Options.TextColor);
	NBK_NoteBody:SetTextColor(R, G, B);
	if(current == -1) then
		NBK_NoteTitle:SetID(0);
		NBK_NoteTitle:SetText("");
		NBK_NoteBody:SetText("");
	elseif(current) then
		NBK_NoteTitle:SetID(current);
		NBK_NoteTitle:SetText(NBK_NoteBookData[current].Header);
		NBK_NoteBody:SetText(NBK_NoteBookData[current].Text);
	end
	NBK_ScrollFrame:SetHeight((NBK_TotalButtons * NBK_ButtonHeight) + NBK_ButtonHeight);
	NBK_ListFrame:UpdateScrollChildRect();
	NBK_NoteList = nil;
end

function NBK_NoteBookOnClick(id)
	NBK_NoteTitle:SetID(id);
	NBK_NoteTitle:SetText(NBK_NoteBookData[id].Header);
	NBK_NoteBody:SetText(NBK_NoteBookData[id].Text);
end

function NBK_NoteSave()
	local id = NBK_NoteTitle:GetID();
	if(strlen(NBK_NoteTitle:GetText()) < 1) then return; end
	if(not NBK_NoteBookData[id]) then
		id = MetaMap_TableSize(NBK_NoteBookData)+1;
		NBK_NoteBookData[id] = {};
	end
	NBK_NoteTitle:SetID(id);
	NBK_NoteBookData[id].Header = NBK_NoteTitle:GetText();
	NBK_NoteBookData[id].Text = NBK_NoteBody:GetText();
	NBK_NotesRefresh(id);
end

function NBK_NoteDelete()
	local id = NBK_NoteTitle:GetID();
	if(not id) then return; end
	if(NBK_NoteBookData[id]) then
		NBK_NoteBookData[id] = nil;
	end
	local TmpData = {};
	local new = 1;
	for index, value in pairs(NBK_NoteBookData) do
		TmpData[new] = {};
		TmpData[new] = value;
		new = new +1;
	end
	NBK_NoteBookData = {};
	NBK_NoteBookData = TmpData;
	TmpData = nil;
	NBK_NotesRefresh(-1);
end

function NBK_OnShow(mode)
	local firstLine;
	local found;
	local added = false;
	local NBK_DeadTip = string.sub(CORPSE_TOOLTIP, 0, string.len(CORPSE_TOOLTIP)-2);
	if(mode == 1 and NBK_Options.ShowGuild) then
		local guildname = GetGuildInfo("mouseover");
		if(guildname) then
			GameTooltip:AddLine("<"..guildname..">", 0, 1.0, 0);
			added = true;
		end
	end
	if(mode == 1 and UnitExists("mouseover")) then
		firstLine = UnitName("mouseover");
	else
		if(mode == 1) then
			firstLine = getglobal("GameTooltipTextLeft1"):GetText();
		else
			firstLine = getglobal("WorldMapTooltipTextLeft1"):GetText();
		end
		if string.find(firstLine, NBK_DeadTip) then
			firstLine = string.sub(firstLine, string.len(NBK_DeadTip)+1);
		end
	end
	if(firstLine and NBK_Options.Tooltips) then
		for index, Note in pairs(NBK_NoteBookData) do
			if(Note.Header == firstLine) then found = index; end
		end
		if(found) then
			if(mode == 1 and UnitExists("mouseover") and NBK_Options.PlaySound1) then
				PlaySound("FriendJoinGame");
			elseif(mode == 2 and NBK_Options.PlaySound2) then
				PlaySound("FriendJoinGame");
			end
			local info = "\n"..NBK_NoteBookData[found].Text;
			local oneLine = 0;
			local R, G, B = unpack(NBK_Options.TtipColor);
			while oneLine do
				info = string.sub(info, oneLine+1);
				oneLine = NBK_FormaTText(info);
				firstLine = string.sub(info, 0, oneLine);
				if(mode == 1) then
					GameTooltip:AddLine(firstLine, R, G, B);
				else
					WorldMapTooltip:AddLine(firstLine, R, G, B);
				end
			end
			added = true;
		end
	end
	if(added) then
		if(mode == 1) then
			GameTooltip:Show();
		else
			WorldMapTooltip:Show();
		end
	end
end

function NBK_FormaTText(text)
	local LineSpace = string.find(text, " " , 40);
	local LineFeed = string.find(text, "\n");
	if(LineFeed == nil) then
		return LineSpace;
	end
	if(LineSpace == nil) then
		return LineFeed;
	end
	if(LineSpace < LineFeed) then
		return LineSpace;
	else
		return LineFeed;
	end
end

function NBK_ToggleOptions(key, value)
	if(value) then
		NBK_Options[key] = value;
	else
		NBK_Options[key] = not NBK_Options[key];
	end
	return NBK_Options[key];
end

function NBK_SetTextColor(option, R, G, B)
	NBK_ToggleOptions(option, {R, G, B})
	getglobal("NBK_Check_"..option.."BG"):SetTexture(R, G, B);
	NBK_NotesRefresh();
end
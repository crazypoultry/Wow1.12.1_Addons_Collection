
--------------[[ Frame Functions ]]--------------

function EDB_Frame_Reagent_OnLoad()

	-- Set up default values for frame control
	EDB_Frame_Reagent.selection = 1;
	EDB_Frame_Reagent.numEntries = 15;

	-- Set up the reagent list
	EDB_Frame_Reagent.reagentListOffset = 0;
	EDB_Frame_Reagent.reagentListSize = table.getn(EDB_Reagent_Index);
	EDB_Frame_Reagent_ReagentList_SetSelection(1);

end


--------------[[ ReagentListEntry Functions ]]--------------

function EDB_Frame_Reagent_ReagentListEntry_OnClick()

	EDB_Frame_Reagent_ReagentList_SetSelection(this:GetID());

	-- do nothing if edit box isn't open
	if ( not ChatFrameEditBox:IsVisible() ) then
		return;
	end
	
	local link;

	-- Shift key links reagent
	if ( IsShiftKeyDown() ) then
		link = EDB_Reagent[EDB_Reagent_Index[this.index]];
	end

	if ( link ) then
		ChatFrameEditBox:Insert(link);
	end

end

function EDB_Frame_Reagent_ReagentListEntry_SetColor(button, color)

	if ( not button ) then
		return;
	end

	if ( not color ) then
		color = EDB_Colors.Normal;
	end

	getglobal(button:GetName().."_Name"):SetTextColor( color[1], color[2], color[3]);
	getglobal(button:GetName().."_NumBags"):SetTextColor( color[1], color[2], color[3]);
	getglobal(button:GetName().."_NumBank"):SetTextColor(color[1], color[2], color[3]);

end

function EDB_Frame_Reagent_ReagentListEntry_OnEnter()

	-- Set the text color to "highlighted"
	EDB_Frame_Reagent_ReagentListEntry_SetColor(this, EDB_Colors.Highlight);

end

function EDB_Frame_Reagent_ReagentListEntry_OnLeave()

	if ( not EDB_Frame_Reagent.selection ) then
		EDB_Frame_Reagent_ReagentListEntry_SetColor(this, EDB_Colors.Normal);
		return;
	end

	local line = EDB_Frame_Reagent.selection - EDB_Frame_Reagent.reagentListOffset;

	if ( this:GetID() == line ) then
		EDB_Frame_Reagent_ReagentListEntry_SetColor(this, EDB_Colors.Highlight);
	else
		EDB_Frame_Reagent_ReagentListEntry_SetColor(this, EDB_Colors.Normal);
	end

end


--------------[[ ReagentList Functions ]]--------------

-- Set the current reagentList selection
function EDB_Frame_Reagent_ReagentList_SetSelection(index)

	-- Set the new selection
	EDB_Frame_Reagent.selection = index + EDB_Frame_Reagent.reagentListOffset;

	EDB_Frame_Reagent_ReagentList_Update();

end

-- Build the reagentList
function EDB_Frame_Reagent_ReagentList_Build()

	local entry = 0;

end


-- Update the reagentList
function EDB_Frame_Reagent_ReagentList_Update()

	local line, lineplusoffset, entry, name, numBags, numBank, price;

	FauxScrollFrame_Update(EDB_Frame_Reagent_ReagentListScrollBar, EDB_Frame_Reagent.reagentListSize, EDB_Frame_Reagent.numEntries, 15);

	EDB_Frame_Reagent.reagentListOffset = FauxScrollFrame_GetOffset(EDB_Frame_Reagent_ReagentListScrollBar);

	for line = 1, EDB_Frame_Reagent.numEntries do

		entry = getglobal("EDB_Frame_Reagent_ReagentListEntry"..line);

		entry.index = line + EDB_Frame_Reagent.reagentListOffset;

		if ( entry.index <= EDB_Frame_Reagent.reagentListSize ) then

			local id = EDB_Reagent_Index[entry.index];

			name = EDB_ColorFromLink(EDB_Reagent[id]);

			if ( name ) then
				name = "|c"..name..EDB_NameFromLink(EDB_Reagent[id]).."|r";
			else
				name = EDB_NameFromLink(EDB_Reagent[id]);
			end

			if ( EDB_CSI ) and ( EDB_CSI.reagent ) and ( EDB_CSI.reagent[id] ) then
				numBags = EDB_CSI.reagent[id].bag;
				numBank = EDB_CSI.reagent[id].bank;
			end

			if ( not numBags ) then numBags = "?"; end
			if ( not numBank ) then numBank = "?"; end

			if ( EDB_CSI ) and ( EDB_CSI.reagentValue ) and ( EDB_CSI.reagentValue[id] ) then
				price = EDB_CSI.reagentValue[id];
			else
				price = 0;
			end

			getglobal("EDB_Frame_Reagent_ReagentListEntry"..line.."_Icon"):SetNormalTexture(EDB_ReagentIcon[id]);
			getglobal("EDB_Frame_Reagent_ReagentListEntry"..line.."_Name"):SetText(name);
			getglobal("EDB_Frame_Reagent_ReagentListEntry"..line.."_NumBags"):SetText(numBags);
			getglobal("EDB_Frame_Reagent_ReagentListEntry"..line.."_NumBank"):SetText(numBank);
			EDB_Money_SetText("EDB_Frame_Reagent_ReagentListEntry"..line.."_Price", price);
			EDB_Frame_Reagent_ReagentListEntry_SetColor(entry, EDB_Colors.Normal);
			entry:Show();
		else
			entry:Hide();
		end

	end

	EDB_Frame_Reagent_ReagentListHighlight_Update();

end

-- Properly position and show/hide the selection highlight
function EDB_Frame_Reagent_ReagentListHighlight_Update()

	if ( not EDB_Frame_Reagent.selection ) or ( EDB_Frame_Reagent.reagentListSize == 0 ) then

		EDB_Frame_Reagent_ReagentListHighlight.line = nil;
		EDB_Frame_Reagent_ReagentListHighlight:Hide();
		return;

	end

	local line = EDB_Frame_Reagent.selection - EDB_Frame_Reagent.reagentListOffset;

	if ( line < 1 ) or ( line > EDB_Frame_Reagent.numEntries ) then

		EDB_Frame_Reagent_ReagentListHighlight.line = nil;
		EDB_Frame_Reagent_ReagentListHighlight:Hide();

	else

		local color = EDB_Colors.Normal;

		EDB_Frame_Reagent_ReagentListHighlight.line = line;
		EDB_Frame_Reagent_ReagentListHighlight:SetPoint("TOPLEFT", "EDB_Frame_Reagent_ReagentListEntry"..line, "TOPLEFT");
		EDB_Frame_Reagent_ReagentListHighlight:Show();
		EDB_Frame_Reagent_ReagentListHighlight_ReagentListEntryHighlightTexture:SetVertexColor(color[1], color[2], color[3], 1);
		EDB_Frame_Reagent_ReagentListEntry_SetColor(getglobal("EDB_Frame_Reagent_ReagentListEntry"..line), EDB_Colors.Highlight);

	end

end

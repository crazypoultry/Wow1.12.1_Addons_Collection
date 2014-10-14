NOTEINPUTFRAME_SHOWN_ELEMENTS = 6;
BINDING_NAME_TOGGLENOTEDIALOG = "Toggle Note Input Dialog";
BINDING_HEADER_NOTEIT = "Note It";
local NoteInputOriginalContainerItemClick;
 
function NoteInputFrame_Init()
	SlashCmdList["INPUTNOTE"] = NoteInputFrame_Show;
	SLASH_INPUTNOTE1 = "/noteit";
	SLASH_INPUTNOTE2 = "/ni";
	if noteIt == nil then
		noteIt = { };
	end
	if noteItColour == nil then
		noteItColour = { r=0, g=0.8, b=1.0 };
	end
	if noteItMode == nil then
		noteItMode = 2;
	end
	if noteItSplash == nil then
		noteItSplash = true;
	end
	if noteItAddGuild == nil then
		noteItAddGuild = false;
	end
	if noteItPlaySound == nil then
		noteItPlaySound = false;
	end
	if DEFAULT_CHAT_FRAME and noteItSplash then
		local colourString = NoteInputFrame_NumberToHex(noteItColour.r)..NoteInputFrame_NumberToHex(noteItColour.g)..NoteInputFrame_NumberToHex(noteItColour.b);
		DEFAULT_CHAT_FRAME:AddMessage("|cff"..colourString.."NoteIt, by Zugreg, lets you write down notes about players or other things.|r");
		DEFAULT_CHAT_FRAME:AddMessage("|cff"..colourString.."Use |r|cffffffff/noteit|r|cff"..colourString.." or |r|cffffffff/ni|r|cff"..colourString.." to open the note input dialog.|r");
	end
	
	NoteInputOriginalContainerItemClick = ContainerFrameItemButton_OnClick;
	ContainerFrameItemButton_OnClick = NoteInputContainerItem_OnClick;
end

function NoteInputFrame_NumberToHex(number)
	number = number * 256;
	local msv = math.floor(number/16);
	number = number - (msv*16);
	local lsv = math.floor(number);
	if msv > 15 then
		msv = 15;
		lsv = 15;
	end
	local leftChar, rightChar;
	if msv < 10 then
		leftChar = 48+msv;
	else
		leftChar = 87+msv;
	end
	if lsv < 10 then
		rightChar = 48+lsv;
	else
		rightChar = 87+lsv;
	end
	return string.char(leftChar, rightChar);
end

function NoteInputFrame_DisplayNote(name)
	if noteIt[name] then
		NoteInputNameEditBox:SetText(name);
		NoteInputNoteEditBox:SetText(noteIt[name][1]);
		NoteInputPlayerLabel:SetText(noteIt[name][2]);
		NoteInputServerLabel:SetText(noteIt[name][3]);
		NoteInputNoteEditBox:SetFocus();
	else
		if name == "" then
			NoteInputNameEditBox:SetText("");
			NoteInputNoteEditBox:SetText("");
			NoteInputPlayerLabel:SetText(UnitName("player"));
			NoteInputServerLabel:SetText(GetCVar("realmName"));
			NoteInputNameEditBox:SetFocus();
		else
			NoteInputNameEditBox:SetText(name);
			NoteInputNoteEditBox:SetText("");
			NoteInputPlayerLabel:SetText(UnitName("player"));
			NoteInputServerLabel:SetText(GetCVar("realmName"));
			NoteInputNoteEditBox:SetFocus();
		end
	end
end

function NoteInputFrame_Show(arg)
	if NoteInputFrame:IsShown() then
		HideUIPanel(NoteInputFrame);
	else
		NoteInputFrame_BuildIndexList();

		ShowUIPanel(NoteInputFrame);
		
		if arg and arg ~= "" then
			 NoteInputFrame_DisplayNote(arg);
		else
			if UnitExists("target") then
				 NoteInputFrame_DisplayNote(UnitName("target"));
			else 
				 --NoteInputFrame_DisplayNote("");
			end
		end
	end

end

function NoteInputFrame_BuildIndexList()
	noteKeys = {};
	table.foreach(noteIt, function(k, v) table.insert(noteKeys, k); end);
	table.sort(noteKeys, function(a,b) return string.lower(a)<string.lower(b) end);
	NoteInputFrame_NameListUpdate();
end

function NoteInputFrame_Save()
	text = NoteInputNameEditBox:GetText();
	if text then
		if text ~= "" then
			noteIt[NoteInputNameEditBox:GetText()] = {NoteInputNoteEditBox:GetText(), UnitName("player"), GetCVar("realmName")};
		end
	end
	HideUIPanel(NoteInputFrame);
end

function NoteInputFrame_Delete()
	if NoteInputNameEditBox:GetText() then
		local name = NoteInputNameEditBox:GetText();
		if noteIt[name] ~= nil then
			local position = NoteInputFrame_SearchFirst(noteKeys);
			noteIt[name] = nil;
			table.remove(noteKeys, position);
			NoteInputFrame_DisplayNote("");
			NoteInputFrame_BuildIndexList();
			NoteInputFrame_NameListUpdate();
		end
	end
end

function NoteInputFrame_TextChanged()
	if NoteInputFrame_oldText ~= nil then
		if not (NoteInputNameEditBox:GetText() == NoteInputFrame_oldText) then
			NoteInputFrame_DoScroll(NoteInputFrame_SearchFirst(noteKeys));
		end
	else
		NoteInputFrame_DoScroll(NoteInputFrame_SearchFirst(noteKeys));
	end
	NoteInputFrame_oldText = NoteInputNameEditBox:GetText();
end

function NoteInputFrame_OnSelectNote()
	local nameBox = getglobal(this:GetName().."Name");
	NoteInputFrame_DisplayNote(nameBox:GetText());
	--NoteInputNameEditBox:SetText(nameBox:GetText());
	--NoteInputNoteEditBox:SetText(noteIt[nameBox:GetText()][1]);
end

function NoteInputFrame_NameListUpdate()
	local scrollBar = getglobal("NoteInputNameChooseFrameScrollBar");
	
	if table.getn(noteKeys) <= NOTEINPUTFRAME_SHOWN_ELEMENTS then
		scrollBar:SetMinMaxValues(0, 0);
	else
		scrollBar:SetMinMaxValues(0, table.getn(noteKeys)-NOTEINPUTFRAME_SHOWN_ELEMENTS);
		getglobal("NoteInputNameChooseFrameScrollBarScrollDownButton"):Enable();
	end

	local min, max = scrollBar:GetMinMaxValues();
	if scrollBar:GetValue() > max then
		scrollBar:SetValue(max);
	end
	
	--scrollBar:SetValue(0);
	scrollBar:SetValueStep(1);
	NoteInputFrame_DoScroll(NoteInputFrame_SearchFirst(noteKeys));
end

function NoteInputFrame_SearchFirst(list)
	local pattern = NoteInputNameEditBox:GetText();
	if pattern and pattern ~= "" and table.getn(list) > 0 then
		pattern = string.lower(pattern);
		local base = 0;
		local range = math.ceil(table.getn(list)/2);
		local notFound = true;
		local searching = true;
		local oldrange, veryoldrange;
		local text;
		while searching and (base+range) <= table.getn(list) do
			veryoldrange = oldrange;
			oldrange = range;
			text = string.lower(string.sub(list[base+range], 0, string.len(pattern)));
			--Print("Base: "..base.." Range: "..range.." Text: "..text);
			if text == pattern then
				notFound = false;
				searching = false;
			else
				if text < pattern then
					base = base+range;
				end
				range = math.ceil(range/2);
				if veryoldrange == range then
					notFound = true;
					searching = false;
				end
			end
		end
		if notFound == false then
			local position = base + range;
			while string.lower(string.sub(list[position], 0, string.len(pattern))) == pattern do
				position = position - 1;
				--Print("Go up: "..position);
				if position < 1 then
					return 0;
				end
			end
			--position = position +1;
			return position;
		else
			return nil;
		end
	else
		return nil;
	end
end

function NoteInputFrame_SetNames(k, noteKeys)
	if table.getn(noteKeys) <= NOTEINPUTFRAME_SHOWN_ELEMENTS then
		k = 0
	else
		if table.getn(noteKeys) > NOTEINPUTFRAME_SHOWN_ELEMENTS and k > table.getn(noteKeys)-NOTEINPUTFRAME_SHOWN_ELEMENTS then
			k = table.getn(noteKeys)-NOTEINPUTFRAME_SHOWN_ELEMENTS
		end
	end

	for j = 1, NOTEINPUTFRAME_SHOWN_ELEMENTS do
		local name = noteKeys[j+k];
		local button = getglobal("NameChooseFrameButton"..j);
		if name then
			button:Show();
			getglobal("NameChooseFrameButton"..j.."Name"):SetText(name);
			getglobal("NameChooseFrameButton"..j.."Text"):SetText(noteIt[name][1]);
			if name == NoteInputNameEditBox:GetText() then
				button:LockHighlight();
				NoteInputFrame_DisplayNote(NoteInputNameEditBox:GetText());
			else 
				button:UnlockHighlight();
			end
		else
			button:Hide();
		end
	end
end

function NoteInputFrame_DoScroll(arg1)
	local scrollBar = getglobal("NoteInputNameChooseFrameScrollBar");
	local current = scrollBar:GetValue();
	if arg1 ~= nil and (arg1<current or arg1>=current+NOTEINPUTFRAME_SHOWN_ELEMENTS) then
		scrollBar:SetValue(arg1);
	end
	NoteInputFrame_OnScroll()
end

function NoteInputFrame_OnScroll()
	local scrollBar = getglobal("NoteInputNameChooseFrameScrollBar");
	local scrollUpButton = getglobal("NoteInputNameChooseFrameScrollBarScrollUpButton" );
	local scrollDownButton = getglobal("NoteInputNameChooseFrameScrollBarScrollDownButton" );

	local min, max = scrollBar:GetMinMaxValues();

	if ( scrollBar:GetValue() == 0 ) then
		scrollUpButton:Disable();
	else
		scrollUpButton:Enable();
	end
	if ((scrollBar:GetValue() - max) == 0) then
		scrollDownButton:Disable();
	else
		scrollDownButton:Enable();
	end

	NoteInputFrame_SetNames(math.floor(scrollBar:GetValue()), noteKeys);
end

function NoteInputFrame_OnMouseWheel(value)
	local scrollBar = getglobal(this:GetName().."ScrollBar");
	if ( value > 0 ) then
		scrollBar:SetValue(scrollBar:GetValue() - 1);
	else
		scrollBar:SetValue(scrollBar:GetValue() + 1);
	end
end

function NoteInputFrame_OnShow()
	PlaySound("igCharacterInfoOpen");
end

function NoteInputFrame_OnHide()
	PlayerNotesOptionsFrame:Hide();
	PlaySound("igCharacterInfoClose");
end

function NoteInputOptionsFrameChangeColorButton_OnColorPick()
	local r,g,b = ColorPickerFrame:GetColorRGB();
	currentColour.r = r; currentColour.g = g; currentColour.b = b; 
	PlayerNotesOptionsColor:SetTexture(r, g, b);
end

function NoteInputOptionsFrameChangeColorButton_OnColorPickCancel(prevValues)
	currentColour.r = prevValues.r;
	currentColour.g = prevValues.g;
	currentColour.b = prevValues.b;
	PlayerNotesOptionsColor:SetTexture(prevValues.r, prevValues.g, prevValues.b);
end

function NoteInputOptionsFrameRadioButton_OnClick(id)
	for ijk = 1, 3 do
		if id == ijk then
			getglobal("NoteInputOptionsFrameRadioButton"..ijk):SetChecked(1);
			currentMode = id;
		else
			getglobal("NoteInputOptionsFrameRadioButton"..ijk):SetChecked(nil);
		end
	end
end

function NoteInputContainerItem_OnClick(button, ignoreShift)
	if ( button == "LeftButton" ) then
		if ( IsShiftKeyDown() and not ignoreShift ) then
			if ( NoteInputFrame:IsVisible() ) then
				local firstLine = getglobal("GameTooltipTextLeft1"):GetText();
				NoteInputFrame_DisplayNote(firstLine);
			return;
			end
		end
	end
	NoteInputOriginalContainerItemClick(button, ignoreShift);
end
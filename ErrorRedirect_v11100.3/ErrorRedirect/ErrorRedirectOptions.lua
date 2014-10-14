--
-- Error Redirect with GUI
--
-- by Thomas Watts
-- Original Error Redirect by Bastian Pflieger <wb@illogical.de>
-- Credits: Idea by Bunny, compiling original default filter lists
--
-- supports "myAddOns": http://www.curse-gaming.com/en/wow/addons-358-1-myaddons.html
--

local EROCFL = ERRORREDIRECT_FIXEDFILTERS;

function ErrorRedirectOptionsFrameOkay_OnClick()
	PlaySound("gsTitleOptionOK");
	HideUIPanel(ErrorRedirectOptionsFrame);
end

function ErrorRedirectOptionsFrameCombo_OnClick()
	local EROFC = this.value;

	UIDropDownMenu_SetSelectedID(this.owner, this:GetID());

	ErrorRedirect_Options["IsEnabled"] = EROFC[1];
	ErrorRedirect_Options["Frame"] = EROFC[2];
end

function ErrorRedirectOptionsFrameCombo_Initialize()
	local info1 = {
		text = ERRORREDIRECT_COMBOTEXT[1],
		value = {false, ERRORREDIRECT_DISCARDFILTER},
		func = ErrorRedirectOptionsFrameCombo_OnClick,
		owner = ErrorRedirectOptionsFrameCombo,
	};

	local info2 = {
		text = ERRORREDIRECT_COMBOTEXT[2],
		value = {true, ERRORREDIRECT_DISCARDFILTER},
		func = ErrorRedirectOptionsFrameCombo_OnClick,
		owner = ErrorRedirectOptionsFrameCombo,
	};

	local info3 = {
		text = ERRORREDIRECT_COMBOTEXT[3],
		value = {true, ERRORREDIRECT_PERFILTER},
		func = ErrorRedirectOptionsFrameCombo_OnClick,
		owner = ErrorRedirectOptionsFrameCombo,
	};

	local info4 = {
		text = ERRORREDIRECT_COMBOTEXT[4],
		value = {true, "ChatFrame1"},
		func = ErrorRedirectOptionsFrameCombo_OnClick,
		owner = ErrorRedirectOptionsFrameCombo,
	};

	local info5 = {
		text = ERRORREDIRECT_COMBOTEXT[5],
		value = {true, "ChatFrame2"},
		func = ErrorRedirectOptionsFrameCombo_OnClick,
		owner = ErrorRedirectOptionsFrameCombo,
	};

	UIDropDownMenu_AddButton(info1);
	UIDropDownMenu_AddButton(info2);
	UIDropDownMenu_AddButton(info3);
	UIDropDownMenu_AddButton(info4);
	UIDropDownMenu_AddButton(info5);
end

function ErrorRedirectOptionsFrameCombo_OnLoad()
	UIDropDownMenu_Initialize(this, ErrorRedirectOptionsFrameCombo_Initialize);
	UIDropDownMenu_SetWidth(200, this);
end

function ErrorRedirectOptionsFrameSuppress_OnClick()
	if( this:GetChecked() ) then
		if( geterrorhandler() == _ERRORMESSAGE ) then
			ErrorRedirect_Options["ModErrors"] = true;
			seterrorhandler(ErrorRedirect_ErrorMessage);
		else
			DEFAULT_CHAT_FRAME:AddMessage("Set error handler failed.  Another MOD is already overriding.");
		end
	else
		ErrorRedirect_Options["ModErrors"] = false;
		if( geterrorhandler() == ErrorRedirect_ErrorMessage ) then
			seterrorhandler(_ERRORMESSAGE);
		end
	end
end

function ErrorRedirectOptionsFrameHighlight_OnClick()
	ErrorRedirect_Options["Highlight"] = this:GetChecked();
	--if this:GetChecked() then
		--ErrorRedirect_Options["Highlight"] = true;
	--else
		--ErrorRedirect_Options["Highlight"] = false;
	--end
end

function ErrorRedirectOptionsFrame_OnLoad()
	table.insert(UISpecialFrames, this:GetName());
	--Cannot use UIPanelFrames for positioning because myAddOns uses :Show instead of ShowUIPanel
	--UIPanelFrames[this:GetName()] = { area = "left", pushable = 0, whileDead = 1 };
	PanelTemplates_SetNumTabs(this, 3);
	PanelTemplates_SetTab(this, 1);

	--ErrorRedirectOptionsFrameTitle:SetText(ERRORREDIRECT_NAME);

	ErrorRedirectOptionsFrameHighlightText:SetTextHeight(12);
	ErrorRedirectOptionsFrameHighlightText:SetText(ERRORREDIRECT_CUSTOMCOLOR);

	ErrorRedirectOptionsFrameSuppressText:SetTextHeight(12);
	ErrorRedirectOptionsFrameSuppressText:SetText(ERRORREDIRECT_SUPPRESSNIL);
end

local function ErrorRedirect_GetChatNumber(txt)
	if( not txt ) then
		return ErrorRedirect_AvailableFrames[1][2]; -- Default
	end
	for i, val in ErrorRedirect_AvailableFrames do
		if( val[1] == txt ) then
			return val[2];
		end
	end
	return ErrorRedirect_AvailableFrames[1][2]; -- Default
end

function ErrorRedirectOptionsFrame_OnShow()
	if( myAddOnsFrame ) then
		HideUIPanel(myAddOnsFrame);
	end

	local currentConfig = 0;
	local EROIE = ErrorRedirect_Options["IsEnabled"];
	local ERORF = ErrorRedirect_Options["Frame"];

	if( EROIE and ERORF == "ChatFrame2" ) then
		currentConfig = 5;
	elseif( EROIE and ERORF == "ChatFrame1" ) then
		currentConfig = 4;
	elseif( EROIE and ERORF == ERRORREDIRECT_PERFILTER ) then
		currentConfig = 3;
	elseif( EROIE ) then
		currentConfig = 2;
	else
		currentConfig = 1;
	end

	UIDropDownMenu_SetSelectedName(ErrorRedirectOptionsFrameCombo, ERRORREDIRECT_COMBOTEXT[currentConfig]);
	UIDropDownMenu_SetText(ERRORREDIRECT_COMBOTEXT[currentConfig], ErrorRedirectOptionsFrameCombo);

	if( ErrorRedirect_Options["Highlight"] ) then
		ErrorRedirectOptionsFrameHighlight:SetChecked(1);
	else
		ErrorRedirectOptionsFrameHighlight:SetChecked(0);
	end

	if( ErrorRedirect_Options["ModErrors"] ) then
		ErrorRedirectOptionsFrameSuppress:SetChecked(1);
	else
		ErrorRedirectOptionsFrameSuppress:SetChecked(0);
	end

	currentConfig = ErrorRedirect_Options["SuppressFrame"];
	EROIE = ErrorRedirect_GetChatNumber(currentConfig);
	currentConfig = tonumber(string.sub(currentConfig, 10));
	UIDropDownMenu_SetSelectedID(ErrorRedirectOptionsFrameSuppressCombo, currentConfig);
	UIDropDownMenu_SetText(EROIE, ErrorRedirectOptionsFrameSuppressCombo);

	ErrorRedirectOptionsFilterParent:Show();
end

function ErrorRedirectOptionsFrame_OnHide()
	ErrorRedirectOptionsFilterParent:Hide();
	--No way of getting current active addon from myAddOns
	--if( myAddOnsFrame and myAddOnsTree.selectedIndex == ERRORREDIRECT_NAME ) then
		--ShowUIPanel(myAddOnsFrame);
	--end
end

function ErrorRedirectOptionsFilterActive_OnClick()
	local index = this:GetParent().value;
	local filter = ErrorRedirect_Options[EROCFL][index];
	filter["Active"] = this:GetChecked();
end

local function ErrorRedirectOptions_CheckButton_Viability(bS, curr, bE)
	if( curr > bS ) then
		ErrorRedirectOptionsFilterParentPrevButton:Enable();
	else
		ErrorRedirectOptionsFilterParentPrevButton:Disable();
	end
	if( curr + 4 <= bE ) then
		ErrorRedirectOptionsFilterParentNextButton:Enable();
	else
		ErrorRedirectOptionsFilterParentNextButton:Disable();
	end
end

local function ErrorRedirectOptions_FillFilterContainers()
	if( PanelTemplates_GetSelectedTab(ErrorRedirectOptionsFrame) == 3 ) then
		return;
	end

	local index, frame, f1, f2, f3, f4, filters, fil;
	local filFrame, filColor, filStart;
	local i = 1;

	filters = ErrorRedirect_Options[EROCFL];
	filStart = ErrorRedirect_Options[EROCFL.."Start"];

	ErrorRedirectOptions_CheckButton_Viability(1, filStart, ErrorRedirect_Options[EROCFL.."Length"]);

	while i <= 4 do
		frame = "ErrorRedirectOptionsFilterParentFilter"..i;
		if( not getglobal(frame) ) then
			return;
		end

		index = filStart + i - 1;
		index = ErrorRedirect_RetrieveIndex(index, EROCFL);

		if( index ) then
			f1 = getglobal(frame.."Active");
			f2 = getglobal(frame.."LabelText");
			f3 = getglobal(frame.."RedirectCombo");
			f4 = getglobal(frame.."ColorCombo");

			frame = getglobal(frame);
			frame.value = index;
			frame:Show();

			fil = filters[index];
			if( not fil ) then
				return;
			end
			f1:SetChecked(fil["Active"]);
			-- String length should remain under 60 characters or so
			f2:SetText(fil["String"]);
			if( fil["Frame"] ) then
				filFrame = fil["Frame"];
			else
				filFrame = 0;
			end
			filFrame = ErrorRedirect_GetChatNumber(filFrame);
			UIDropDownMenu_SetSelectedName(f3, filFrame);
			UIDropDownMenu_SetText(filFrame, f3);
			if( fil["Color"] ) then
				filColor = fil["Color"];
			else
				filColor = "red";
			end
			UIDropDownMenu_SetSelectedName(f4, filColor);
			UIDropDownMenu_SetText(filColor, f4);
			filColor = ErrorRedirect_Colors[filColor];
			f2:SetTextColor(filColor.r, filColor.g, filColor.b, 1.0);
			i = i + 1;
		else -- No filter to use
			getglobal(frame):Hide();
			i = i + 1;
		end
	end
end

function ErrorRedirectOptionsFilterButton_OnClick()
	local start = ErrorRedirect_Options[EROCFL.."Start"];

	if( this:GetID() == 1 ) then
		start = start - 4;
	elseif( this:GetID() == 2 ) then
		start = start + 4;
	end

	ErrorRedirect_Options[EROCFL.."Start"] = start;
	ErrorRedirectOptions_FillFilterContainers();
end

function ErrorRedirectOptionsFilterParent_OnShow()
	ErrorRedirectOptions_FillFilterContainers();
end

function ErrorRedirectOptionsTab_OnLoad()
	local fN = this:GetName();

	PanelTemplates_TabResize(0);
	this:SetFrameLevel(this:GetFrameLevel() + 4);
	getglobal(fN.."Text"):SetPoint("CENTER", 0, 7);
	--getglobal(fN.."HighlightText"):SetPoint("CENTER", 0, 7);
	--getglobal(fN.."DisabledText"):SetPoint("CENTER", 0, 7);
	fN = getglobal(fN.."HighlightTexture");
	fN:SetPoint("LEFT", 10, 5);
	fN:SetPoint("RIGHT", -10, 5);
	fN:SetWidth(this:GetTextWidth() + 30);
end

function ErrorRedirectOptionsHelp_OnClick()
	PanelTemplates_Tab_OnClick(ErrorRedirectOptionsFrame);
	ErrorRedirectOptionsFilterParentFilter1:Hide();
	ErrorRedirectOptionsFilterParentFilter2:Hide();
	ErrorRedirectOptionsFilterParentFilter3:Hide();
	ErrorRedirectOptionsFilterParentFilter4:Hide();
	ErrorRedirectOptionsFilterParentPrevButton:Disable();
	ErrorRedirectOptionsFilterParentNextButton:Disable();
	ErrorRedirectOptionsFilterParentAdd:Disable();
	ErrorRedirectOptionsFilterParentReset:Disable();
	ErrorRedirectOptionsHelp:Show();
end

function ErrorRedirectOptionsTab_OnClick()
	ErrorRedirectOptionsHelp:Hide();
	ErrorRedirectOptionsFilterParentAdd:Enable();
	ErrorRedirectOptionsFilterParentReset:Enable();
	PanelTemplates_Tab_OnClick(ErrorRedirectOptionsFrame);
	if( this:GetID() == 1 ) then
		EROCFL = ERRORREDIRECT_FIXEDFILTERS;
	elseif( this:GetID() == 2 ) then
		EROCFL = ERRORREDIRECT_PARTIALFILTERS;
	end
	ErrorRedirectOptions_FillFilterContainers();
end

function ErrorRedirectOptionsFilterColorCombo_OnClick()
	UIDropDownMenu_SetSelectedID(this.owner, this:GetID());
	--UIDropDownMenu_SetText(this:GetText(), this.owner);
	local prnt = this.owner:GetParent();
	local index = prnt.value;
	local filter = ErrorRedirect_Options[EROCFL][index];
	local EROFC = this:GetText();
	local color = this.value;
	if( EROFC == "red" ) then
		filter["Color"] = nil;
	else
		filter["Color"] = EROFC;
	end
	getglobal(prnt:GetName().."LabelText"):SetTextColor(color.r, color.g, color.b, 1.0);
end

function ErrorRedirectOptionsFilterColorCombo_Initialize()
	local current_menu = UIDropDownMenu_GetCurrentDropDown();
	local eraf = ErrorRedirect_Colors;

	for i, fr in pairs(eraf) do
		UIDropDownMenu_AddButton( {
			text = i,
			value = fr,
			func = ErrorRedirectOptionsFilterColorCombo_OnClick,
			owner = current_menu,
		} );
	end
end

function ErrorRedirectOptionsFilterColorCombo_OnLoad()
	UIDropDownMenu_Initialize(this, ErrorRedirectOptionsFilterColorCombo_Initialize);
	UIDropDownMenu_SetWidth(100, this);
end

function ErrorRedirectOptionsFilterRedirectCombo_OnClick()
	UIDropDownMenu_SetSelectedID(this.owner, this:GetID());
	--UIDropDownMenu_SetText(this:GetText(), this.owner);
	local EROFC = this.value;
	local prnt = this.owner:GetParent();
	local index = prnt.value;
	local filter = ErrorRedirect_Options[EROCFL][index];
	if( not EROFC or EROFC == 0 ) then
		filter["Frame"] = nil;
	else
		filter["Frame"] = EROFC;
	end
end

function ErrorRedirectOptionsFilterRedirectCombo_Initialize()
	local current_menu = UIDropDownMenu_GetCurrentDropDown();
	local eraf = ErrorRedirect_AvailableFrames;

	for i, fr in ipairs(eraf) do
		UIDropDownMenu_AddButton( {
			text = fr[2],
			value = fr[1],
			func = ErrorRedirectOptionsFilterRedirectCombo_OnClick,
            owner = current_menu,
		} );
	end
end

function ErrorRedirectOptionsFilterRedirectCombo_OnLoad()
	UIDropDownMenu_Initialize(this, ErrorRedirectOptionsFilterRedirectCombo_Initialize);
	UIDropDownMenu_SetWidth(100, this);
end

function ErrorRedirectOptionsSuppressCombo_OnClick()
	UIDropDownMenu_SetSelectedID(this.owner, this:GetID());
	--UIDropDownMenu_SetText(this:GetText(), this.owner);
	local EROFC = this.value;
	ErrorRedirect_Options["SuppressFrame"] = EROFC;
end

function ErrorRedirectOptionsSuppressCombo_Initialize()
	local current_menu = UIDropDownMenu_GetCurrentDropDown();
	local eraf = ErrorRedirect_AvailableFrames;
	local skip = 3; --skip first three values

	for i, fr in ipairs(eraf) do
		if( skip <= 0 ) then
			UIDropDownMenu_AddButton( {
				text = fr[2],
				value = fr[1],
				func = ErrorRedirectOptionsSuppressCombo_OnClick,
				owner = current_menu,
			} );
		else
			skip = skip - 1;
		end
	end
end

function ErrorRedirectOptionsSuppressCombo_OnLoad()
	UIDropDownMenu_Initialize(this, ErrorRedirectOptionsSuppressCombo_Initialize);
	UIDropDownMenu_SetWidth(100, this);
end

-- Confirm and Edit functions
function ErrorRedirectOptionsEdit_Confirm(funcSetup, funcOkay, funcCancel)
	local frame = ErrorRedirectOptionsEditFilterFrame;
	local fName = frame:GetName();
	local f1 = getglobal(fName.."Message");
	local f2 = getglobal(fName.."Text");
	local f3 = getglobal(fName.."Title");

	funcSetup(this, frame, f1, f2, f3);
	ErrorRedirectOptionsEditFilterFrameOkay.func = funcOkay;
	ErrorRedirectOptionsEditFilterFrameCancel.func = funcCancel;
end

function ErrorRedirectOptionsFilterAdd_FuncSetup(originator, frame, message, text, title)
	frame.value = EROCFL;

	title:SetText("Add Filter");
	text:SetText("");
	message:Hide();
	text:Show();
	frame:Show();
end

function ErrorRedirectOptionsFilterAdd_FuncOkay(frame)
	local tFil = getglobal(frame:GetName().."Text"):GetText();
  
	if( not tFil or tFil == "" ) then
		ErrorRedirect_ErrorMessage("String not accepted, filter was not added");
		return;
	end
	ErrorRedirect_TableInsert(frame.value, { ["String"] = tFil, ["Active"] = true });
	frame:Hide();
	ErrorRedirectOptions_FillFilterContainers();
end

function ErrorRedirectOptionsFilterAdd_FuncCancel(frame)
	frame:Hide();
end

function ErrorRedirectOptionsFilterDelete_FuncSetup(originator, frame, message, text, title)
	local indVal = originator:GetParent().value;
	local filter = ErrorRedirect_Options[EROCFL][indVal];
	frame.value = { EROCFL, indVal, filter["String"] };

	title:SetText("Delete Filter?");
	message:SetText("Delete "..filter["String"].."?");
	text:Hide();
	message:Show();
	frame:Show();
end

function ErrorRedirectOptionsFilterDelete_FuncOkay(frame)
	local info = frame.value;
	local arr = ErrorRedirect_Options[info[1]];
	frame:Hide();
	if( arr[info[2]]["String"] == info[3] ) then
		ErrorRedirect_TableRemove(info[1], info[2]);
		ErrorRedirectOptions_FillFilterContainers();
	else
		DEFAULT_CHAT_FRAME:AddMessage("Filter "..info[3].." has already been deleted.");
	end
end

function ErrorRedirectOptionsFilterDelete_FuncCancel(frame)
	frame:Hide();
end

function ErrorRedirectOptionsFilterLabel_FuncSetup(originator, frame, message, text, title)
	local indVal = originator:GetParent().value;
	frame.value = { EROCFL, indVal };

	text:SetText(ErrorRedirect_Options[EROCFL][indVal]["String"]);
	title:SetText("Edit Filter");
	message:Hide();
	text:Show();
	frame:Show();
end

function ErrorRedirectOptionsFilterLabel_FuncOkay(frame)
	local info = frame.value;
	local indVal = ErrorRedirect_Options[info[1]][info[2]];
	local fAct, fCol, fStr;
	fAct = indVal["Active"];
	fCol = indVal["Color"];
	fStr = getglobal(frame:GetName().."Text"):GetText();
	if( not fStr or fStr == "" ) then
		ErrorRedirect_ErrorMessage("String change not accepted, "..indVal["String"].." not changed");
		return;
	end
	ErrorRedirect_TableRemove(info[1], info[2]);
	ErrorRedirect_TableInsert(info[1], { ["String"] = fStr, ["Active"] = fAct, ["Color"] = fCol } );
	frame:Hide();
	ErrorRedirectOptions_FillFilterContainers();
end

function ErrorRedirectOptionsFilterLabel_FuncCancel(frame)
	frame:Hide();
end

function ErrorRedirectOptionsFilterReset_FuncSetup(originator, frame, message, text, title)
	frame.value = EROCFL;
	message:SetText("Reset "..EROCFL.." to defaults?");
	title:SetText("Reset Filters?");
	text:Hide();
	message:Show();
	frame:Show();
end

function ErrorRedirectOptionsFilterReset_FuncOkay(frame)
	ErrorRedirect_IntializeFilters(frame.value, true);

	DEFAULT_CHAT_FRAME:AddMessage(frame.value.." reset to defaults.");
	frame:Hide();
	ErrorRedirectOptions_FillFilterContainers();
end

function ErrorRedirectOptionsFilterReset_FuncCancel(frame)
	frame:Hide();
end

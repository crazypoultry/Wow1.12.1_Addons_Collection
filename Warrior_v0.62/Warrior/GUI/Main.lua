WARRIOR.GUI = {};

-- *****************************************************************************
-- Function: Toggle 
-- Purpose: toggles the visibility of the configuration gui
-- *****************************************************************************
function WARRIOR.GUI:Toggle()
	if (WARRIORGUIFrame:IsVisible()) then WARRIORGUIFrame:Hide() else WARRIORGUIFrame:Show() end
end

-- *****************************************************************************
-- Function: OnLoad 
-- Purpose: initialization code
-- *****************************************************************************
function WARRIORGUI_OnLoad()
	this:RegisterEvent("VARIABLES_LOADED");
	this:SetBackdropColor(0, 0, 0, 1);
	this:SetBackdropBorderColor(1, 0, 0, 1);
	this:RegisterForDrag("LeftButton");

	SLASH_WARRIORCONFIG1 = "/wc";
	SlashCmdList["WARRIORCONFIG"] = function(msg) 
		if (msg == "r") then ConsoleExec("reloadui"); end
	
		if (WARRIORGUIFrame:IsVisible()) then WARRIORGUIFrame:Hide();
		else WARRIORGUIFrame:Show(); end
	end

	-- make gui escapable and force window to stay inbounds
	this:SetClampedToScreen(true);
	table.insert(UISpecialFrames,this:GetName());
	
	-- hook PickupSpell to record the spell that is picked up
	WARRIOR.Utils:Hook("PickupSpell",function(id,book)
		local name = GetSpellName(id,book);
		WGUI_SPELLONCURSOR = {id=id,book=book,name=name};
		return WARRIOR_oldPickupSpell(id,book);
	end);
end


-- *****************************************************************************
-- Function: WARRIORGUI_OnEvent
-- Purpose: handle all the events
-- *****************************************************************************
function WARRIORGUI_OnEvent(event)
	if (event == "VARIABLES_LOADED") then 
		tinsert(UISpecialFrames,"WARRIORGUIFrame");
		WARRIORGUIFrame:SetScale(1);
	end
end

-- *****************************************************************************
-- Function: WARRIORGUI_StopMoving
-- Purpose: handle the stopping of dragging
-- *****************************************************************************
function WARRIORGUI_StopMoving()
	this:StopMovingOrSizing();
	this.moving = nil;
end

-- *****************************************************************************
-- Function: WARRIORGUI_ClassSpellScrollFrame_Update
-- Purpose: update the scroll frame scrolling
-- *****************************************************************************
function WARRIORGUI_ClassSpellScrollFrame_Update(class)
	local offset = FauxScrollFrame_GetOffset(WARRIORGUI_ClassSpellScrollFrame);
	local index, button, buttontext, texture, icon, checkbutton;
	
	-- pick class proper class
	if (not WARRIORGUI_ClassSelection.prevvalue and not class) then class = WARRIOR.Classes._active; end
	if (class and WARRIOR.Utils.String:Trim(class) == "") then class = WARRIORGUI_ClassSelection.prevvalue; end
	
	if (class) then 
		WARRIORGUI_ClassSelection_Setting:SetText(class);
		WARRIORGUI_ClassSelection.prevvalue = class;
		WARRIORGUI_KeyBindingButton_Update(class);
		WARRIORGUI_ClassType:SetChecked(WARRIORGUI_ClassType.index());
		
		-- setup the elements of the page
		if (class == WARRIOR.Classes._active or WARRIOR.Classes._database[class].type == "system") then
			WARRIORGUI_ActivateClassButton:Disable();
			WARRIORGUI_DeleteClassButton:Disable();
			WARRIORGUI_ClassType:Disable();
			
			if (class ~= WARRIOR.Classes._active) then 
				WARRIORGUI_ClassKeybindingButton:Disable(); 
			else
				WARRIORGUI_ClassKeybindingButton:Enable(); 
				WARRIORGUI_ClassType:Enable();
			end
		else
			WARRIORGUI_ActivateClassButton:Enable();
			WARRIORGUI_DeleteClassButton:Enable();
			WARRIORGUI_ClassKeybindingButton:Enable();
			WARRIORGUI_ClassType:Enable();
		end
	end

	-- get the number of options
	local class = WARRIORGUI_ClassSelection.prevvalue;
	local numOptions = table.getn(WARRIOR.Classes._database[class].spells);

	for i=1,6 do
		index = offset + i;
		if (WARRIOR.Classes._database[class].spells[index]) then
			local spell = WARRIOR.Spells._spellbook[WARRIOR.Classes._database[class].spells[index]];			
			getglobal("WARRIORGUI_ClassSpellButton_"..i.."_SpellButton").spellID = spell.id;
			getglobal("WARRIORGUI_ClassSpellButton_"..i.."_SpellButton").spellName = spell.name;
			getglobal("WARRIORGUI_ClassSpellButton_"..i.."_Text"):SetText(spell.name);
			getglobal("WARRIORGUI_ClassSpellButton_"..i.."_SpellButton_Icon"):SetTexture(spell.texture);
			getglobal("WARRIORGUI_ClassSpellButton_"..i.."_RankText"):SetText(spell.rank or "");
			getglobal("WARRIORGUI_ClassSpellButton_"..i):Show();
		else
			getglobal("WARRIORGUI_ClassSpellButton_"..i):Hide();
		end
	end
	
	FauxScrollFrame_Update(WARRIORGUI_ClassSpellScrollFrame, numOptions, 6, 32);
end

-- *****************************************************************************
-- Function: WARRIORGUI_ClassDropMenu_OnClick
-- Purpose: handle the clicks for the class menu
-- *****************************************************************************
function WARRIORGUI_ClassDropMenu_OnClick()
	WARRIORGUI_ClassSpellScrollFrame_Update(getglobal(this:GetName().."_Text"):GetText());
	WARRIORGUI_DropMenu:Hide();
end

-- *****************************************************************************
-- Function: WARRIORGUI_ClassDropMenu_Edit
-- Purpose: handle changes made to the edit box
-- *****************************************************************************
function WARRIORGUI_ClassDropMenu_Edit()
	-- create class if their is no entry for the class
	local class = this:GetText();
	if (WARRIOR.Utils.String:Trim(class) ~= "" and not WARRIOR.Classes._database[class]) then
		WARRIOR.Classes:Add(class); 
	end
	
	WARRIORGUI_ClassSpellScrollFrame_Update(class);
	WARRIORGUI_DropMenu:Hide();
end

-- *****************************************************************************
-- Function: WARRIORGUI_MenuTimeout
-- Purpose: timer to hide the list after its been up for a while
-- *****************************************************************************
function WARRIORGUI_MenuTimeout(elapsed)
	if (this.timer) then
		this.timer = this.timer - elapsed;
		if (this.timer < 0) then
			this.timer = nil;
			this:Hide();
		end
	end
end

-- *****************************************************************************
-- Function: WARRIORGUI_ShowMenu
-- Purpose: toggle showing the droplist
-- *****************************************************************************
function WARRIORGUI_ShowMenu(toggle)
	if (toggle) then this = this:GetParent(); end
	
	-- hide the menu if it is visible
	local menu = getglobal(this.menu);
	if (menu:IsVisible()) then
		menu:Hide();
		return;
	end

	-- gain access to the table/index in this.table
	RunScript("setglobal('WARRIORGUI_TEMP'," .. this.table .. ");");

	-- populate the dropdown list
	local count = 0;
	for i=1,2 do
		for key,value in WARRIORGUI_TEMP do
			if ((i == 1 and value.type == "system") or (i == 2 and value.type ~= "system")) then
				count = count + 1;
				local option = this.menu .. "_Option" .. count;
				local prev = this.menu .. "_Option" .. (count - 1);
				
				getglobal(option):Show();
				getglobal(option):SetWidth(112);
				getglobal(option):SetScript("OnClick", this.clickFunc);
				getglobal(option.."_Text"):SetText(key);

				if (count > 1) then
					getglobal(option):ClearAllPoints();
					getglobal(option):SetPoint("TOP", prev, "BOTTOM", 0, 0);
				end
			end
		end
	end
	
	-- clean up temporary variable
	setglobal("WARRIORGUI_TEMP",nil);
	
	-- hide all the left over buttons
	for i=1, menu.count do
		if (i > count) then getglobal(this.menu.."_Option"..i):Hide(); end
	end
	
	-- set the width and height of the drop down
	menu:SetWidth(120);
	menu:SetHeight(count * 15 + 10);

	-- position the drop down
	menu:ClearAllPoints();
	menu:SetPoint("TOPLEFT", this:GetName(), "BOTTOMLEFT", -8, 8);

	menu.controlbox = this:GetName();
	menu:Show();
end

-- *****************************************************************************
-- Function: WARRIORGUI_SpellButton_OnClick
-- Purpose: handle the clicks for the spell menu
-- *****************************************************************************
function WARRIORGUI_SpellButton_OnClick(spellID)
	if (CursorHasSpell()) then return false; end

	PickupSpell(spellID,2);
	WARRIORGUI_ClassSpellScrollFrame_Update();
end

-- *****************************************************************************
-- Function: WARRIORGUI_SpellButton_DropZone
-- Purpose: recieve a spell from the drop zone
-- *****************************************************************************
function WARRIORGUI_SpellButton_DropZone(spell)
	if (not CursorHasSpell() or not WGUI_SPELLONCURSOR) then return false; end

	-- get the current class
	local class, newspell = WARRIORGUI_ClassSelection.prevvalue, WGUI_SPELLONCURSOR;
	
	local oldindex = WARRIOR.Utils.Table:Find(WARRIOR.Classes._database[class].spells,WGUI_SPELLONCURSOR.name);
	local newindex = WARRIOR.Utils.Table:Find(WARRIOR.Classes._database[class].spells,spell);
	
	-- if spell in not in the class replace the one it was dragged to
	if (not oldindex or not newindex) then
		WARRIORGUI_SpellDropZone();
		PickupSpell(newspell.id,newspell.book);
		local index = WARRIORGUI_SpellButton_DropZone(spell);
		table.remove(WARRIOR.Classes._database[class].spells, index + 1);
		WARRIORGUI_ClassSpellScrollFrame_Update();
		
		return index; 
	end
	
	table.remove(WARRIOR.Classes._database[class].spells,oldindex);
	table.insert(WARRIOR.Classes._database[class].spells,newindex,WGUI_SPELLONCURSOR.name);
	
	-- release the spell/action
	WARRIORGUI_ClassSpellScrollFrame_Update();
	PickupSpell(WGUI_SPELLONCURSOR.id,WGUI_SPELLONCURSOR.book);
	WGUI_SPELLONCURSOR = nil;

	return newindex;
end

-- *****************************************************************************
-- Function: WARRIORGUI_SpellDropZone
-- Purpose: recieve a spell from the drop zone
-- *****************************************************************************
function WARRIORGUI_SpellDropZone()
	if (not CursorHasSpell()) then return false; end

	-- place the spell in an action slot
	local class = WARRIORGUI_ClassSelection.prevvalue;

	-- add/remove spell to the class
	if (WARRIOR.Utils.Table:Find(WARRIOR.Classes._database[class].spells,WGUI_SPELLONCURSOR.name)) then
		WARRIOR.Classes:RemoveSpell(class,WGUI_SPELLONCURSOR.name);
	else
		WARRIOR.Classes:AddSpell(class,WGUI_SPELLONCURSOR.name);
	end
	
	-- set the texture
	getglobal(this:GetName().."_Icon"):SetTexture(WARRIOR.Spells._spellbook[WGUI_SPELLONCURSOR.name].texture);
	
	-- release the spell/action
	WARRIORGUI_ClassSpellScrollFrame_Update();
	PickupSpell(WGUI_SPELLONCURSOR.id,WGUI_SPELLONCURSOR.book);
	WGUI_SPELLONCURSOR = nil;
end

-- *****************************************************************************
-- Function: WARRIORGUI_KeybindingButton_OnClick
-- Purpose: setup to recieve a new keybinding
-- *****************************************************************************
function WARRIORGUI_KeybindingButton_OnClick(button,key)
	if (WARRIORGUI_SELECTED_KEYBINDING) then
		if (button == "LeftButton" or button == "RightButton") then
			WARRIORGUI_SELECTED_KEYBINDING = this;
			WARRIORGUI_KeyBindingButton_Update();
			return;
		end
		WARRIORGUI_KeyBindingButton_OnKeyDown(button);
	else
		getglobal(this:GetName().."_OnKey"):Show();
		WARRIORGUI_SELECTED_KEYBINDING = this;
		WARRIORGUI_KeyBindingButton_Update();
	end
end

-- *****************************************************************************
-- Function: WARRIORGUI_KeyBindingButton_Update
-- Purpose: update the kwybinding button
-- *****************************************************************************
function WARRIORGUI_KeyBindingButton_Update(class)
	local button = "WARRIORGUI_ClassKeybindingButton";
	
	if (not class and not getglobal(button).class) then return; end
	if (class) then getglobal(button).class = class; end

	local key = WARRIOR.Keybindings:GetKey(getglobal(button).class);
	getglobal(button.."_Text"):SetText(key);
	
	local width = getglobal(button.."_Text"):GetWidth() + 10;
	if (width < 40) then width = 40; end
	
	getglobal(button):SetWidth(width);

	getglobal(button):UnlockHighlight();
	if (WARRIORGUI_SELECTED_KEYBINDING and WARRIORGUI_SELECTED_KEYBINDING.class == getglobal(button).class) then
		getglobal(button):LockHighlight();
	end
end

-- *****************************************************************************
-- Function: WARRIORGUI_KeyBindingButton_OnKeyDown
-- Purpose: recieve keys the user
-- *****************************************************************************
function WARRIORGUI_KeyBindingButton_OnKeyDown(button)
	if (not WARRIORGUI_SELECTED_KEYBINDING) then return; end
	
	-- adjust for mouse buttons
	if (button == "LeftButton") then button = "BUTTON1";
	elseif (button == "RightButton") then button = "BUTTON2";
	elseif (button == "MiddleButton") then button = "BUTTON3";
	elseif (button == "Button4") then button = "BUTTON4";
	elseif (button == "Button5") then button = "BUTTON5"; end

	-- set the key/mouse that was pressed
	local keyPressed = arg1;
	if (button) then
		if (button == "BUTTON1" or button == "BUTTON2") then return; end
		keyPressed = button;
	end

	-- return so that the modifier key can be pressed
	if (keyPressed == "UNKNOWN" or keyPressed == "SHIFT" or keyPressed == "CTRL" or keyPressed == "ALT") then return; end
	
	if (IsAltKeyDown()) then keyPressed = "ALT-"..keyPressed; end
	if (IsShiftKeyDown()) then keyPressed = "SHIFT-"..keyPressed; end
	if (IsControlKeyDown()) then keyPressed = "CTRL-"..keyPressed; end

	-- set the keybinding
	WARRIOR.Keybindings:SetKey(WARRIORGUI_SELECTED_KEYBINDING.class,keyPressed);

	WARRIORGUI_KeyBindingButton_Update();
	WARRIORGUI_SELECTED_KEYBINDING:UnlockHighlight();
	
	getglobal(WARRIORGUI_SELECTED_KEYBINDING:GetName().."_OnKey"):Hide();
	WARRIORGUI_SELECTED_KEYBINDING = nil;
end


-- *****************************************************************************
-- Function: WARRIORGUI_Slider_Update
-- Purpose: update the slider for a slider template
-- *****************************************************************************
function WARRIORGUI_Slider_Update()
	if (not this.minmaxset) then return; end
	
	local setting = this.index();
	if (this.scale) then setting = setting * this.scale; end
	if (setting == this:GetValue()) then return; end
	
	local min, max = this:GetMinMaxValues();
	if (setting < min or setting > max) then return; end
	
	local value = this:GetValue();
	getglobal(this:GetName().."_Display"):SetText(value);
	if (this.scale) then value = value / this.scale; end
	
	this.func(value);	
end

-- *****************************************************************************
-- Function: WARRIORGUI_Slider_UpdateFromEditBox
-- Purpose: update the slider from the edit box
-- *****************************************************************************
function WARRIORGUI_Slider_UpdateFromEditBox()
	local value = this:GetNumber();
	if (not value) then value = 0; end
	
	local min, max = this:GetParent():GetMinMaxValues();
	
	if (this:GetParent().minlocked and value < min) then value = min; end
	if (this:GetParent().maxlocked and value > max) then value = max; end
	
	this:SetText(value);
	if (value >= min and value <= max) then this:GetParent():SetValue(value); end
	
	this:ClearFocus();
	if (this:GetParent().scale) then value = value / this:GetParent().scale; end
	
	-- gain access to the table/index in this.table
	this.GetParent().func(value);
end

-- *****************************************************************************
-- Function: WARRIORGUI_CheckBox_OnClick
-- Purpose: set the checkbox for a checkbox template
-- *****************************************************************************
function WARRIORGUI_CheckBox_OnClick()
	local value = true;
	if (not this:GetChecked()) then value = false; end

	this.func(value);
end

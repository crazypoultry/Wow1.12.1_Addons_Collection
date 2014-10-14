-- Handle all the option settings

FishingBuddy.OptionsFrame = {};

local function BroadcastSetting(value)
   local show = FBConstants.Broadcast[value];
   FishingBuddy.SetSetting("BroadcastFishies", value);
   local menu = getglobal("FishingBuddyOption_BroadcastFishies");
   if ( menu ) then
      local label = getglobal("FishingBuddyOption_BroadcastFishiesLabel");
      UIDropDownMenu_SetWidth(90, menu);
      UIDropDownMenu_SetSelectedValue(menu, show);
      UIDropDownMenu_SetText(show, menu);
      label:SetText(FBConstants.BROADCAST_LABEL_TEXT);
   end
end

local function SetKeyValue(what, value)
   local show = FBConstants.Keys[value];
   FishingBuddy.SetSetting(what, value);
   local menu = getglobal("FishingBuddyOption_"..what);
   if ( menu ) then
      local label = getglobal("FishingBuddyOption_"..what.."Label");
      UIDropDownMenu_SetWidth(90, menu);
      UIDropDownMenu_SetSelectedValue(menu, show);
      UIDropDownMenu_SetText(show, menu);
      label:SetText(FBConstants.KEYS_LABEL_TEXT);
   end
end
FishingBuddy.OptionsFrame.SetKeyValue = SetKeyValue;

FishingBuddy.CheckButton_OnShow = function()
   this:SetChecked(FishingBuddy.GetSetting(this.name));
   getglobal(this:GetName().."Text"):SetText(this.text);
end

local function CheckBox_Able(value, button)
   local color;
   if ( value == 1 ) then
      button:Enable();
      color = NORMAL_FONT_COLOR;
   else
      button:Disable();
      color = GRAY_FONT_COLOR;
   end
   getglobal(button:GetName().."Text"):SetTextColor(color.r, color.g, color.b);
end

local function CheckButton_OnClick(checkbox, quiet)
   local value = 0;
   if ( not checkbox ) then
      checkbox = this;
   end
   if ( checkbox:GetChecked() ) then
      if ( not quiet ) then
         PlaySound("igMainMenuOptionCheckBoxOn");
      end
      value = 1;
   else
      if ( not quiet ) then
         PlaySound("igMainMenuOptionCheckBoxOff");
      end
   end
   FishingBuddy.SetSetting(checkbox.name, value);
   if ( checkbox.update ) then
      checkbox.update();
   end
   if ( checkbox.deps ) then
      for button,what in pairs(checkbox.deps) do
         if ( what == "d" ) then
	    CheckBox_Able(value, button);
         elseif ( what == "h" ) then
	    button:Hide();
            if ( value == 1 ) then
	       if ( not button.visible or button.visible() == 1 ) then
		  button:Show();
	       end
            end
         end
      end
   end
end
FishingBuddy.CheckButton_OnClick = CheckButton_OnClick;

FishingBuddy.CheckButton_OnEnter = function()
   local tooltip = this.tooltip;
   if ( tooltip ) then
      GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
      GameTooltip:SetText(tooltip, nil, nil, nil, nil, 1);
      GameTooltip:Show();
   end
end

FishingBuddy.CheckButton_OnLeave = function()
   GameTooltip:Hide();
end

FishingBuddy.OptionsFrame.Setup = function()
   for name,option in pairs(FishingBuddy.OPTIONS) do
      local button = getglobal("FishingBuddyOption_"..name);
      if ( button ) then
	 if ( option.v ) then
	    local enable = true;
	    if ( option.check ) then
	       enable = option.check();
	    end
	    button.name = name;
	    button.update = option.update;
	    if ( option.text ) then
	       button.text = option.text;
	    else
	       button.text = "";
	    end
	    button.tooltip = option.tooltip;
	    if ( enable ) then
	       button:SetChecked(FishingBuddy.GetSetting(name));
	       CheckBox_Able(1, button);
	    else
	       CheckBox_Able(0, button);
	    end
	 end
	 local showit = 1;
	 if ( option.visible ) then
	    button.visible = option.visible;
	    showit = button.visible();
	 end
	 if ( showit ) then
	    button:Show();
	 else
	    button:Hide();
	 end
	 if ( option.deps ) then
	    for n,what in pairs(option.deps) do
	       local b = getglobal("FishingBuddyOption_"..n);
	       if ( b ) then
		  if ( not b.deps ) then
		     b.deps = {};
		  end
		  b.deps[button] = what;
	       end
	    end
	 end
      end
   end

   -- now that we've collected all of the dependencies, handle them
   for name,option in pairs(FishingBuddy.OPTIONS) do
      if ( option.v ) then
	 local button = getglobal("FishingBuddyOption_"..name);
	 if ( button ) then
	    CheckButton_OnClick(button, true);
	 end
      end
   end

   if ( FishingBuddy.UseButtonHole() ) then
      FishingBuddyOption_MinimapPosSlider:Hide();
   end
   local gs = FishingBuddy.GetSetting;
   SetKeyValue("EasyCastKeys", gs("EasyCastKeys"));
   BroadcastSetting(gs("BroadcastFishies"));
end

FishingBuddy.OptionsFrame.SetClockValues = function(value)
   FishingBuddy.SetClockOffset(value);
   if ( FBConstants.ClockOffsets ) then
      local menu = getglobal("FishingBuddyOption_ClockOffset");
      local label = getglobal("FishingBuddyOption_ClockOffsetLabel");
      UIDropDownMenu_SetWidth(60, menu);
      local sel = 1;
      if ( value == FBConstants.ClockOffsets[2] ) then
	 sel = 2;
      end
      UIDropDownMenu_SetSelectedValue(menu, sel);
      UIDropDownMenu_SetText(value, menu);
      label:SetText(FBConstants.OFFSET_LABEL_TEXT);
   end
   if ( FBConstants.ClockOffsets and
        FishingBuddy.GetSetting("STVTimer") == 1 ) then
      FishingBuddyOption_ClockOffset:Show();
   else
      FishingBuddyOption_ClockOffset:Hide();
   end
end

local function ClockOffsetMenuSetup()
   if ( FBConstants.ClockOffsets ) then
      local clockoff = FishingBuddy.GetClockOffset();
      for _,offset in pairs(FBConstants.ClockOffsets) do
         local off = offset;
	 local info = {};
         info.text = string.format("%4d", offset);
         info.func = function()
			FishingBuddy.OptionsFrame.SetClockValues(off);
		     end;
         info.checked = ( offset == clockoff )
         UIDropDownMenu_AddButton(info);
      end
   end
end

FishingBuddy.OptionsFrame.OffsetMenuSetup = function()
   UIDropDownMenu_Initialize(this, ClockOffsetMenuSetup);
end

FishingBuddy.OptionsFrame.LoadKeyMenu = function(what)
   local info = {};
   local setting = FishingBuddy.GetSetting(what);
   for value,label in pairs(FBConstants.Keys) do
      local v = value;
      local w = what;
      info.text = label;
      info.func = function() SetKeyValue(w, v); end;
      if ( setting == value ) then
	 info.checked = true;
      else
	 info.checked = false;
      end
      UIDropDownMenu_AddButton(info);
   end
end

FishingBuddy.OptionsFrame.KeyMenuSetup = function(what)
   UIDropDownMenu_Initialize(this,
			     function()
				local w = what;
				FishingBuddy.OptionsFrame.LoadKeyMenu(what);
			     end);
end

local function MakeSetter(value)
   local v = value;
   return function() BroadcastSetting(v) end;
end
FishingBuddy.MakeSetter = MakeSetter;

local function LoadBroadcastMenu()
   local info = {};
   local setting = FishingBuddy.GetSetting("BroadcastFishies");
   for value,label in pairs(FBConstants.Broadcast) do
      info.text = label;
      info.func = MakeSetter(value);
      if ( setting == value ) then
	 info.checked = true;
      else
	 info.checked = false;
      end
      UIDropDownMenu_AddButton(info);
   end
end

FishingBuddy.OptionsFrame.BroadcastMenuSetup = function()
   UIDropDownMenu_Initialize(this, LoadBroadcastMenu);
end

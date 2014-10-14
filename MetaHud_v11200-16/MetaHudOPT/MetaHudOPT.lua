MetaHudO_NUMTABS = 6;
if(MetaHudProfiles == nil) then
	MetaHudProfiles = {};
end
if(MetaHudProfiles["Default"] == nil) then
	MetaHudProfiles["Default"] = MetaHud.Config_default;
end

function MetaHudO_Header_OnLoad(x,y)
	this.setting_name = string.gsub( this:GetName() , "MetaHud_", "");
	local text = getglobal( this:GetName().."Text");
	text:SetText( " "..(MetaHudO_locale[this.setting_name] or "["..(this.setting_name).."]") );
	text:ClearAllPoints();
	text:SetHeight(20);
	text:SetPoint("TOPLEFT", "MetaHudOptionsFrame" , "TOPLEFT", x, y);
end

function MetaHudO_OnLoad()
	table.insert(UISpecialFrames, "MetaHudOptionsFrame");
	PanelTemplates_SetNumTabs(this, MetaHudO_NUMTABS);
	PanelTemplates_SetTab(this, 1);    
end

function MetaHudO_DropDown_Initialize()
	local info = {};
	local index;
	index = string.gsub( this:GetName() , "MetaHud_Edit_", "");
	index = string.gsub( index , "_Selection", "");
	index = string.gsub( index , "Button", "");
	local table = MetaHudO_SELECTION[index]["table"];
	for key, text in pairs(table) do
		info = {};
		info.text = text;
		info.func = MetaHudO_DropDown_OnClick;
		info.arg1 = index;
		UIDropDownMenu_AddButton(info);
	end
end

function MetaHudO_DropDown_OnClick(list)
	local sel = getglobal("MetaHud_Edit_"..list.."_Selection");
	local box = getglobal("MetaHud_Edit_"..list.."ScrollFrameText");
	local text = MetaHudO_SELECTION[list]["values"][ this:GetID() ];
	box:SetText(text);
	UIDropDownMenu_SetSelectedID( sel , this:GetID() );
	MetaHud:SetConfig( list, text );
	MetaHudO_updateTexts(list);
	MetaHud:init();
end

function MetaHud_ProfilesDropDown_Init()
	for name, value in pairs(MetaHudProfiles) do
		local menu = {
			text = name,
			value = name,
			func = MetaHud_ProfilesDropDown_OnClick,
		};
		UIDropDownMenu_AddButton(menu);
	end
	MetaHud_selectprofileText:SetText(MetaHudOptions.profile);
end

function MetaHud_ProfilesDropDown_OnClick()
	MetaHud_selectprofileText:SetText(this.value);
end

function MetaHud_ProfilesButton_OnClick(button)
	if(button == "saveprofile") then
		local name = MetaHud_newprofile:GetText();
		if(not name or name == "" or name == "Default") then return; end
		MetaHudOptions.profile = name;
		MetaHudProfiles[name] = {};
		for index, value in pairs(MetaHudOptions) do
			MetaHudProfiles[name][index] = value;
		end
		MetaHud_newprofile:SetText("");
		MetaHud_ProfilesDropDown_Init();
		return;
	elseif(button == "loadprofile") then
		local name = MetaHud_selectprofileText:GetText();
		for index, value in pairs(MetaHudProfiles[name]) do
			MetaHud:SetConfig(index, value);
		end
	elseif(button == "deleteprofile") then
		local name = MetaHud_selectprofileText:GetText();
		if(name == "Default") then return; end
		MetaHudProfiles[name] = nil;
		if(MetaHudOptions.profile == name) then
			for index, value in pairs(MetaHudProfiles["Default"]) do
				MetaHud:SetConfig(index, value);
			end
		end
		MetaHud_selectprofileText:SetText(MetaHudOptions.profile);
	end
	MetaHud_SwitchButton_Select("All");
end

function MetaHud_SwitchButton_Select(index)
	if(index == "All") then
		local set = {"layouttyp", "texturefile", "fontfile", "soundfile"};
		for x=1, 4, 1 do
			for i=1, 5, 1 do
				local switch = getglobal("MetaHud_"..set[x]..i);
				if(switch ~= nil) then
					if(i == MetaHudOptions[set[x]]) then
						switch:SetChecked(1);
					else
						switch:SetChecked(nil);
					end
				end
			end
		end
	else
		for i=1, 5, 1 do
			local switch = getglobal("MetaHud_"..index..i);
			if(switch ~= nil) then
				if(i == MetaHudOptions[index]) then
					switch:SetChecked(1);
				else
					switch:SetChecked(nil);
				end
			end
		end
	end
	MetaHud:transformFrames(MetaHudOptions.layouttyp);
	MetaHud:init();
end

function MetaHud_SwitchButton_OnClick(id)
	local index = string.gsub( this:GetName() , "MetaHud_", "");
	index = string.gsub( index , id, "");
	MetaHud:SetConfig(index, id);
	MetaHud_SwitchButton_Select(index);
end

function MetaHudO_updateTexts(name)
	MetaHud:initTextfield(getglobal(name),name);
	MetaHud:triggerTextEvent(name);
end
        
function MetaHudO_FrameSlider_OnLoad(low, high, step)
	this.setting_name = string.gsub( this:GetName() , "MetaHud_Slider_", "");
	this.st = step;
	if this.nullbase == 1 then
		getglobal(this:GetName().."Low"):SetText( (low - low) );
		getglobal(this:GetName().."High"):SetText( (high - low));     
		this.low = low;  
	else
		getglobal(this:GetName().."Low"):SetText(low);
		getglobal(this:GetName().."High"):SetText(high);        
	end
	this:SetMinMaxValues(low, high);
	this:SetValueStep(this.st);
end

function MetaHudO_FrameSlider_OnShow( key,text)
	getglobal(this:GetName()):SetValue(MetaHudOptions[key]);
	if this.nullbase == 1 then
		getglobal(this:GetName().."Text"):SetText(text.." |cff00ff00"..(MetaHudOptions[key] - this.low ).."|r ");
	else
		getglobal(this:GetName().."Text"):SetText(text.." |cff00ff00"..MetaHudOptions[key].."|r ");
	end
end

function MetaHudO_FrameSlider_OnValueChanged(key,text)
	local m;
	local value;
	if this.st == nil then m = 0; end
	if this.st == 1 then m = 0; end
	if this.st == 0.1 then m = 10; end
	if this.st == 0.5 then m = 50; end
	if this.st == 0.01 then m = 100; end
	if this.st == 0.001 then m = 1000; end
	if m > 0 then
		value =  math.floor( ( this:GetValue() + 0.00001) * m ) / m; 
	else
		value =  math.floor( this:GetValue() ); 
	end
     
	MetaHud:SetConfig( key, value );
	if this.nullbase == 1 then
		getglobal(this:GetName().."Text"):SetText(text.." |cff00ff00"..(MetaHudOptions[key] - this.low ).."|r ");
	else
		getglobal(this:GetName().."Text"):SetText(text.." |cff00ff00"..MetaHudOptions[key].."|r ");
	end
	MetaHud:init();
	 
	if this.triggertext then
		MetaHud:triggerAllTextEvents();
	end
end

function MetaHudO_ColorPicker_ColorChanged()
	local r, g, b = ColorPickerFrame:GetColorRGB();
	MetaHudOptions["colors"][ColorPickerFrame.objname][ColorPickerFrame.objindex] = MetaHud_DecToHex(r,g,b);
	MetaHudO_changeG(ColorPickerFrame.objname);
	MetaHud:init();
end

function MetaHudO_ColorPicker_OnClick(boxnumber)
	local name = string.gsub( this:GetName() , "MetaHud_Colorbox_", "");
	name = string.gsub( name , boxnumber, "");
	local Red, Green, Blue = unpack(MetaHud_hextodec(MetaHudOptions["colors"][name][boxnumber]));
	ColorPickerFrame.previousValues = {Red, Green, Blue}
	ColorPickerFrame.cancelFunc     = MetaHudO_ColorPicker_Cancelled
	ColorPickerFrame.func           = MetaHudO_ColorPicker_ColorChanged
	ColorPickerFrame.objname        = name
	ColorPickerFrame.objindex       = boxnumber
	ColorPickerFrame.tohue          = "MetaHud_Colorbox_"..name..boxnumber.."Texture";
	ColorPickerFrame.hasOpacity     = false
	ColorPickerFrame:SetColorRGB(Red, Green, Blue)
	ColorPickerFrame:ClearAllPoints()
	local x = MetaHudOptionsFrame:GetCenter()
	if (x < UIParent:GetWidth() / 2) then
		ColorPickerFrame:SetPoint("LEFT", "MetaHudOptionsFrame", "RIGHT", 0, 0)
	else
		ColorPickerFrame:SetPoint("RIGHT", "MetaHudOptionsFrame", "LEFT", 0, 0)
	end
	ColorPickerFrame:Show()
end

function MetaHudO_ColorPicker_Cancelled(color)
	local r,g,b = unpack(color);
	MetaHudOptions["colors"][ColorPickerFrame.objname][ColorPickerFrame.objindex] = MetaHud_DecToHex(r,g,b);
	MetaHudO_changeG(ColorPickerFrame.objname);
	MetaHud:init();
end

function MetaHudO_changeG(name)
	local Hcolor1 = MetaHudOptions["colors"][name][1];
	local Hcolor2 = MetaHudOptions["colors"][name][2];
	local Hcolor3 = MetaHudOptions["colors"][name][3];
	local c1r,c1g,c1b = unpack(MetaHud_hextodec(Hcolor1));
	local c2r,c2g,c2b = unpack(MetaHud_hextodec(Hcolor2));
	local c3r,c3g,c3b = unpack(MetaHud_hextodec(Hcolor3));
	local basename = "MetaHud_Colorbox_"..name;
	getglobal(basename.."1Texture"):SetTexture(c1r,c1g,c1b);
	getglobal(basename.."2Texture"):SetTexture(c2r,c2g,c2b);
	getglobal(basename.."3Texture"):SetTexture(c3r,c3g,c3b);
	getglobal(basename.."G1Texture"):SetGradient("HORIZONTAL",c1r,c1g,c1b, c2r,c2g,c2b);
	getglobal(basename.."G2Texture"):SetGradient("HORIZONTAL",c2r,c2g,c2b, c3r,c3g,c3b);
end


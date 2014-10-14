
BFC_InfoFrame = {
	headings = {},
	headingFrames = {},
};
BFC_InfoFrameObject = {
	frame,
	heading,
	name,
	visible,
	
};

local BFC_INFOFRAME_PADDING_TOP = 10;
local BFC_INFOFRAME_PADDING_BOTTOM = 10;
local BFC_INFOFRAME_PADDING_LEFT = 10;
local BFC_INFOFRAME_PADDING_RIGHT = 10;

function BFC_InfoFrame.Init()
	BFC_InfoFrame_singleton = BFC_InfoFrame:new();
	BFC_InfoFrame_Frame:Show();
	BFC_InfoFrame_singleton:update();
	UIDropDownMenu_Initialize(BFC_InfoFrame_DropDown, BFC_InfoFrame.DropDown_Initialize, "MENU");
	
	local bgcolor = BFC_Options.get("iframe_bgcolor");
	
	if(BFC_Options.get("iframe_hideborder")) then
		BFC_InfoFrame_Frame:SetBackdropBorderColor(bgcolor.r, bgcolor.g, bgcolor.b, 0.0);
	else
		BFC_InfoFrame_Frame:SetBackdropBorderColor(bgcolor.r, bgcolor.g, bgcolor.b, 0.5);
	end
	
	BFC_InfoFrame_Frame:SetBackdropColor(bgcolor.r, bgcolor.g, bgcolor.b, bgcolor.opacity);
end

-- Constructor for InfoFrame object
function BFC_InfoFrame:new()
	t = {};
	setmetatable(t, self);
	self.__index = self;
	
	--t.id = BFC_Timer.nextid;
	--BFC_Timer.nextid = BFC_Timer.nextid + 1;
	
	return t;
end


function BFC_InfoFrame:getInstance()
	return BFC_InfoFrame_singleton;
end


function BFC_InfoFrameObject:new(frame, heading, name)
	t = {};
	setmetatable(t, self);
	self.__index = self;
	
	--if frame then
	t.frame = frame;
	t.heading = heading;
	t.name = name;
	--end
	
	return t;
end


function BFC_InfoFrame:addFrame(frame, heading, name)
	self:addObject(BFC_InfoFrameObject:new(frame, heading, name));
end


function BFC_InfoFrame:addObject(obj)
	if(not obj) then
		BFC.Log(BFC.LOG_ERROR, BFC_Strings.Errors.nilobject);
		return
	end
	
	i = 0;
	-- if this is a new heading, create a new fontstring for it.
	if(not self.headings[obj.heading]) then
		BFC.Log(BFC.LOG_DEBUG, "creating heading " .. obj.heading);
		self.headings[obj.heading] = {};
		table.setn(self.headings[obj.heading], 0);
		local fname = "BFC_InfoFrame_Heading" .. i;
		self.headingFrames[obj.heading] = CreateFrame("Frame", fname, BFC_InfoFrame_Frame, "BFC_InfoFrameHeading");
		self.headingFrames[obj.heading]:CreateFontString(fname .. "Text", "ARTWORK", "GameFontNormalSmall");
		local tframe = getglobal(fname .. "Text");
		tframe:ClearAllPoints();
		tframe:SetPoint("TOPLEFT", fname, "TOPLEFT");
		if(self.headingFrames[obj.heading] ~= nil) then
			BFC.Log(BFC.LOG_DEBUG, "got name " .. self.headingFrames[obj.heading]:GetName());
			getglobal(self.headingFrames[obj.heading]:GetName() .. "Text"):SetText(obj.heading);
		else
			BFC.Log(BFC.LOG_DEBUG, "nil heading frame");
		end
	else
		BFC.Log(BFC.LOG_DEBUG, "skipping heading creation");
	end
	
	if(self.headings[obj.heading]) then
		BFC.Log(BFC.LOG_DEBUG, "heading " .. obj.heading .. " exists");
	end
	
	self.headings[obj.heading][obj.name] = obj;
	table.setn(self.headings[obj.heading], table.getn(self.headings[obj.heading]) + 1);
	self:update();
end


function BFC_InfoFrame:removeFrame(heading, name)
	self:removeObject(heading, name);
end

function BFC_InfoFrame:removeObject(heading, name)
	local obj = self.headings[heading][name];
	self.headings[heading][name] = nil;
	BFC.Log(BFC.LOG_DEBUG, name .. "getn for heading " .. heading .. " is " .. getn(self.headings[heading]));
	table.setn(self.headings[heading], table.getn(self.headings[heading]) - 1);
	if(table.getn(self.headings[heading]) == 0) then
		self.headings[heading] = nil;
	end
	
	obj.frame:Hide();
	obj = nil;
	
	self:update();
end


function BFC_InfoFrame:update()
	local ypos = BFC_INFOFRAME_PADDING_TOP;
	local maxwidth = 0;
	local numitems = 0;
	for k,v in pairs(self.headings) do
		--f = self.headingFrames[k];
		--f:ClearAllPoints();
		--f:SetParent("BFC_InfoFrame_Frame");
		--f:SetPoint("TOPLEFT", "BFC_InfoFrame_Frame", "TOPLEFT", BFC_INFOFRAME_PADDING_LEFT, -ypos);
		--f:Show();
		--BFC.Log(BFC.LOG_DEBUG, "adding height  " .. f:GetHeight() .. " for heading " .. k);
		--ypos = ypos + f:GetHeight();
		
		for j,q in pairs(self.headings[k]) do
			if(not q.hidden) then
				q.frame:ClearAllPoints();
				q.frame:SetParent("BFC_InfoFrame_Frame");
				q.frame:SetPoint("TOPLEFT", "BFC_InfoFrame_Frame", "TOPLEFT", BFC_INFOFRAME_PADDING_LEFT, -ypos);
				q.frame:Show();
				BFC.Log(BFC.LOG_DEBUG, "adding height  " .. q.frame:GetHeight());
				if(q.frame:GetWidth() > maxwidth) then
					maxwidth = q.frame:GetWidth();
				end
				ypos = ypos + q.frame:GetHeight();
				numitems = numitems + 1;
				BFC.Log(BFC.LOG_DEBUG, "showing frame " .. j);
			else
				BFC.Log(BFC.LOG_DEBUG, "frame " .. j .. " is hidden");
			end
		end
		
	end
	ypos = ypos + BFC_INFOFRAME_PADDING_BOTTOM;
	BFC_InfoFrame:SetHeight(ypos);
	BFC_InfoFrame:SetWidth(BFC_INFOFRAME_PADDING_LEFT + maxwidth + BFC_INFOFRAME_PADDING_RIGHT);
	
	if(numitems == 0) then
		BFC_InfoFrame_Frame:Hide();
	else
		if(BFC_Options.get("iframe_hidedefaultscore")) then
			WorldStateAlwaysUpFrame:Hide();
		end
		BFC_InfoFrame_Frame:Show();
	end
end

function BFC_InfoFrame:SetWidth(width)
	BFC_InfoFrame_Frame:SetWidth(width);
end

function BFC_InfoFrame:SetHeight(height)
	BFC_InfoFrame_Frame:SetHeight(height);
end


function BFC_InfoFrame.DropDown_Initialize()
	local checked;
	local info = {};
	-- Lock frame
	if ( BFC_Options.get("iframe_lock") ) then
		checked = 1;
	end
	info.text = BFC_Strings.InfoFrame.lock;
	info.func = BFC_InfoFrame.ToggleLock;
	info.checked = checked;
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	
	-- Hide default score
	checked = nil;
	if ( BFC_Options.get("iframe_hidedefaultscore") ) then
		checked = 1;
	end
	info.text = BFC_Strings.InfoFrame.hidedefaultscore;
	info.func = BFC_InfoFrame.ToggleDefaultScore;
	info.checked = checked;
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

	-- Hide border
	checked = nil;
	if ( BFC_Options.get("iframe_hideborder") ) then
		checked = 1;
	end
	info = {};
	info.text = BFC_Strings.InfoFrame.hideborder;
	info.func = BFC_InfoFrame.ToggleBorder;
	info.checked = checked;
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	
	-- Background color
	info = {};
	info.text = BACKGROUND;
	info.hasColorSwatch = 1;
	local bgcolor = BFC_Options.get("iframe_bgcolor");
	info.r = bgcolor.r;
	info.g = bgcolor.g;
	info.b = bgcolor.b;
	local a = bgcolor.opacity;
	-- Done because the slider is reversed
	if ( a ) then
		a = 1- a;
	end
	info.opacity = a;
	info.swatchFunc = BFC_InfoFrame.SetBackgroundColor;
	info.func = UIDropDownMenuButton_OpenColorPicker;
	--info.notCheckable = 1;
	info.hasOpacity = 1;
	info.opacityFunc = BFC_InfoFrame.SetOpacity;
	info.cancelFunc = BFC_InfoFrame.CancelWindowColorSettings;
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
end

function BFC_InfoFrame.ToggleLock()
	BFC_Options.toggle("iframe_lock");
end

function BFC_InfoFrame.ToggleDefaultScore()
	if(BFC_Options.toggle("iframe_hidedefaultscore")) then
		WorldStateAlwaysUpFrame:Hide();
	else
		WorldStateAlwaysUpFrame:Show();
	end

end

function BFC_InfoFrame.ToggleBorder()
	if(BFC_Options.toggle("iframe_hideborder")) then
		BFC_InfoFrame_Frame:SetBackdropBorderColor(TOOLTIP_DEFAULT_COLOR.r, TOOLTIP_DEFAULT_COLOR.g, TOOLTIP_DEFAULT_COLOR.b, 0.0);
	else
		BFC_InfoFrame_Frame:SetBackdropBorderColor(TOOLTIP_DEFAULT_COLOR.r, TOOLTIP_DEFAULT_COLOR.g, TOOLTIP_DEFAULT_COLOR.b, 0.5);
	end
end

function BFC_InfoFrame.SetBackgroundColor()
	local r,g,b = ColorPickerFrame:GetColorRGB();
	local bgcolor = BFC_Options.get("iframe_bgcolor");
	--if(not bgcolor) then
	--	bgcolor = { r = 0, g = 0, b = 0, a = 1 };
	--end
	bgcolor.r = r;
	bgcolor.g = g;
	bgcolor.b = b;
	BFC_Options.set("iframe_bgcolor", bgcolor);
	BFC_InfoFrame_Frame:SetBackdropColor(bgcolor.r, bgcolor.g, bgcolor.b, bgcolor.opacity);
end

function BFC_InfoFrame.SetOpacity()
	local alpha = 1.0 - OpacitySliderFrame:GetValue();
	local bgcolor = BFC_Options.get("iframe_bgcolor");

	bgcolor.opacity = alpha;
	BFC_Options.set("iframe_bgcolor", bgcolor);
	BFC_InfoFrame_Frame:SetBackdropColor(bgcolor.r, bgcolor.g, bgcolor.b, bgcolor.opacity);
end

function BFC_InfoFrame.CancelWindowColorSettings(old)
	
	if(old.r) then
		--this:SetBackdropBorderColor(TOOLTIP_DEFAULT_COLOR.r, TOOLTIP_DEFAULT_COLOR.g, TOOLTIP_DEFAULT_COLOR.b, 0.5);
		BFC_Options.set("iframe_bgcolor", old);
		if(old.a) then
			BFC_InfoFrame_Frame:SetBackdropColor(old.r, old.g, old.b, old.a);
		else
			BFC_InfoFrame_Frame:SetBackdropColor(old.r, old.g, old.b);
		end
	end

end
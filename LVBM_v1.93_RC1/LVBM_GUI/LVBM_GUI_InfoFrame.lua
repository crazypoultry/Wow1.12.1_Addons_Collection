-- -------------------------------------------------------------------------- --
-- InfoFrame for La Vendetta Boss Mods written by LV|Nitram & Destiny|Tandanu --
-- -------------------------------------------------------------------------- --
--  v1.00:	-- from InfoFrame
--  	Added functions:
--		myInfoFrame = LVBMGui:CreateInfoFrame(title, text)
--		myInfoFrame:SetTitle(title)
--		myInfoFrame:SetText(text)
--
--  		myInfoFrameStatusBar = myInfoFrame:CreateStatusBar(min, max, value, title)
--  		myInfoFrameStatusBar:SetValue(value)
--  		myInfoFrameStatusBar:SetTitle(title)
--
--  		myInfoFrameTextField = myInfoFrame:CreateTextField(text)
--  		myInfoFrameTextField:SetText(text)
--
--	these methods are also available for status bars and text fields
--		myInfoFrame:Show()
--		myInfoFrame:Hide()
--	  	myInfoFrame:GetObject() - returns the frame object
--	  	myInfoFrame:Delete() 	- you can not delete frames, but this function hides the frame and 
--	  				- moves it to a "trash can"...the frame will be re-used next time you create a frame of this type
--
--  	Added Function LVBMGui.InfoFrameRestoreFind(ftype)		(DO NOT CALL)		-- search in Trash
--		Added Function LVBMGui.InfoFrameGetNewName()		(DO NOT CALL)		-- used to get a new FrameName
--
--  	Added Function LVBM_Gui_CreateDistanceFrame() for a in Range Frame (C'Thun,...)
--  	Added Function LVBM_Gui_DistanceFrame() to show/hide the Range Frame
--  	Added Function LVBM_InfoFrameTemplate_OnUpdate() 	-- allways called by Frame:OnUpdate
--
--  v1.10:
--  	Updated Delete Function
--  	Updated Frame Positioning
--  	Updated Create Function
--
-- -------------------------------------------------------------------- --



LVBMGui = {		-- Create table
	["Trash"] = {			-- Unused Frames moved there for recycling 
	},
	["FrameID"] = 1;	-- hmm i can't find a function to change the Name of a Frame so i use my own with ID
};

-- Save Positions of InfoFrames - Frame by Frame
if( LVBMInfoFramePosition == nil ) then	LVBMInfoFramePosition = {}; end

-- Handler for Auto CleanUp
LVBMStatusBarHandler = {  "OnChar", "OnDragStart", "OnDragStop", "OnEnter", "OnEvent", "OnHide", "OnKeyDown",
		    "OnKeyUp", "OnLeave", "OnLoad", "OnMouseDown", "OnMouseUp", "OnMouseWheel", "OnReceiveDrag",
		    "OnShow", "OnSizeChanged", "OnUpdate", "OnValueChanged",
	};
LVBMFrameHandler = {  "OnChar", "OnDragStart", "OnDragStop", "OnEnter", "OnEvent", "OnHide", "OnKeyDown",
		    "OnKeyUp", "OnLeave", "OnLoad", "OnMouseDown", "OnMouseUp", "OnMouseWheel", "OnReceiveDrag",
		    "OnShow", "OnSizeChanged", "OnUpdate",
	};
LVBMFrameDefaultScripts = {
	["OnMouseDown"] = function()
		if ( arg1 == "RightButton" and IsShiftKeyDown() ) then
			this:Hide();
		elseif ( arg1 == "RightButton" ) then
			this:StartMoving();
		end
	end,
	["OnMouseUp"] = function()
		if ( arg1 == "RightButton" ) then
			this:StopMovingOrSizing();
			
			local xOfs, yOfs = this:GetCenter();
			yOfs = yOfs - (UIParent:GetHeight() / UIParent:GetEffectiveScale());

			LVBMInfoFramePosition[this.Name] = {
				["x"] = xOfs;
				["y"] = yOfs;
			}
		end
	end,
	["OnEnter"] = function()
		GameTooltip:Hide();
		GameTooltip:ClearLines();
		GameTooltip:SetOwner(this, "ANCHOR_CURSOR");
		GameTooltip:SetText(LVBMGUI_INFOFRAME_TOOLTIP_TITLE, 1,1,1);
		GameTooltip:AddLine(LVBMGUI_INFOFRAME_TOOLTIP_TEXT, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, 1);
		GameTooltip:Show();
	end,
	["OnLeave"] = function()
		GameTooltip:Hide();
	end,
	["OnHide"] = function()
		this:StopMovingOrSizing();
	end,
	["OnUpdate"] = function()
		LVBM_InfoFrameTemplate_OnUpdate(this, arg1);
	end,
};
	
LVBMGuiStatusBar = setmetatable({}, {["__index"] = LVBMGui});
LVBMGuiTextField = setmetatable({}, {["__index"] = LVBMGui});

function LVBM_InfoFrameTemplate_OnUpdate(frame, elapsed, forceUpdate)
	frame.elapsed = frame.elapsed + elapsed;
	if( frame.elapsed > 1 ) or forceUpdate then
		frame.elapsed = 0;
		frame.myTemp = 0;
		frame.myTempHeight = 0;
					
		frame.myWidth = getglobal(frame:GetName().."Text"):GetStringWidth();
		if( frame.myWidth < 84 ) then	frame.myWidth = 84;	end

		frame.myHeight = string.getnum( getglobal(frame:GetName().."Text"):GetText(), "\n" );
		frame.myHeight = frame.myHeight * 16;
		if( frame.myHeight < 16 ) then	frame.myHeight = 16;	end

		local subframes = { frame:GetChildren() };
		for _,child in ipairs(subframes) do

			child:SetPoint("TOP", frame, "TOP", 0, ((frame.myTempHeight + frame.myHeight + 23 + 10 )*(-1)));

			frame.myTemp = child:GetWidth();
			frame.myTempHeight = frame.myTempHeight + child:GetHeight();
			if( frame.myTemp > frame.myWidth ) then
				frame.myWidth = frame.myTemp;
			end
		end

		frame:SetWidth( frame.myWidth + 16 );
		frame:SetHeight( frame.myTempHeight + frame.myHeight + 23 + 16 );		-- Childs + Text + Title + Border 
	end
end

function LVBMGui.InfoFrameGetNewName()
	LVBMGui["FrameID"] = LVBMGui["FrameID"] + 1;
	return "LVBMInfoFrameID"..(LVBMGui["FrameID"] - 1);
end

LVBMGuiMetatable = {
	["__index"] = LVBMGui,
};

LVBMGuiStatusBarMetatable = {
	["__index"] = LVBMGuiStatusBar,
};

LVBMGuiTextFieldMetatable = {
	["__index"] = LVBMGuiTextField,
};

function LVBMGui:CreateInfoFrame(iTitle, iText)
	if self ~= LVBMGui then return; end
	local tempFrame;
	tempFrame = LVBMGui.InfoFrameRestoreFind("MainFrame");
	if( tempFrame ) then
		tempFrame:SetParent("UIParent");
		tempFrame:ClearAllPoints();
	else 
		tempFrame = CreateFrame("Frame", LVBMGui.InfoFrameGetNewName(), UIParent, "LVBMInfoFrameTemplate");
		tempFrame:EnableMouse(true)
		tempFrame.elapsed = 0;
		tempFrame.myWidth = tempFrame:GetWidth();
		tempFrame.myHeight = tempFrame:GetHeight();
		for index, value in pairs(LVBMFrameDefaultScripts) do
			if tempFrame:GetScript(index) ~= value then
				tempFrame:SetScript(index, value);
			end
		end
	end

	tempFrame.Name = iTitle; 	-- This field gives us the Memory function for InfoFrames

	if( LVBMInfoFramePosition[tempFrame.Name] ) then		-- FRAME Positioning Load Saved Value
		if( LVBMInfoFramePosition[tempFrame.Name].x < 0 
		 or LVBMInfoFramePosition[tempFrame.Name].x > (UIParent:GetWidth() / UIParent:GetEffectiveScale()) ) then
			LVBM.AddMsg("Corrected FramePoint X - Out of Screen - ("..LVBMInfoFramePosition[tempFrame.Name].x..")");
			LVBMInfoFramePosition[tempFrame.Name].x = (UIParent:GetWidth() / UIParent:GetEffectiveScale()) / 2;
		end
		if( LVBMInfoFramePosition[tempFrame.Name].y > 0 
		 or LVBMInfoFramePosition[tempFrame.Name].y < ((UIParent:GetHeight() / UIParent:GetEffectiveScale())*(-1)) ) then
			LVBM.AddMsg("Corrected FramePoint Y - Out of Screen - ("..LVBM.Options.Gui.InfoFramePointY..")");
			LVBMInfoFramePosition[tempFrame.Name].y = ((UIParent:GetHeight() / UIParent:GetEffectiveScale()) / (-2));
		end
		tempFrame:SetPoint("CENTER", "UIParent", "TOPLEFT", 
					LVBMInfoFramePosition[tempFrame.Name].x, 
					LVBMInfoFramePosition[tempFrame.Name].y
				);
	else	-- Use Middle of the Screen
		tempFrame:SetPoint("CENTER", "UIParent", "TOPLEFT", 
					((UIParent:GetWidth() / UIParent:GetEffectiveScale()) / 2), 
					((UIParent:GetHeight() / UIParent:GetEffectiveScale()) / (-2))
				);
	end

	tempFrame:SetBackdropColor(0, 0, 1, 0.5);
	if( iTitle ~= nil ) then
		getglobal(tempFrame:GetName().."Title"):SetText(iTitle);
	else
		getglobal(tempFrame:GetName().."Title"):SetText("");
	end
	if( iText ~= nil ) then
		getglobal(tempFrame:GetName().."Text"):SetText(iText);
	else
		getglobal(tempFrame:GetName().."Text"):SetText("");
	end
	tempFrame:Show();
	LVBM_InfoFrameTemplate_OnUpdate(tempFrame, 0, true);
	
	return setmetatable({
		["Frame"] = tempFrame,
		["SubFrames"] = {},
	}, LVBMGuiMetatable);
end

function LVBMGui:GetObject()
	if self == LVBMGui then return; end
	return self.Frame;
end

function LVBMGui:Hide()
	if self == LVBMGui then return; end
	self.Frame:Hide();
end

function LVBMGui:Show()
	if self == LVBMGui then return; end
	self.Frame:Show();
end

function LVBMGui:SetTitle(iTitle)
	if self == LVBMGui then return; end
	getglobal(self.Frame:GetName().."Title"):SetText(iTitle);
end

function LVBMGui:SetText(iText)
	if self == LVBMGui then return; end
	getglobal(self.Frame:GetName().."Text"):SetText(iText);
end

function LVBMGui:CreateStatusBar(iMin, iMax, iValue, iTitle, iLeftText, iRightText)
	if self == LVBMGui then return; end
	local tempFrame;
	tempFrame = LVBMGui.InfoFrameRestoreFind("StatusBar");
	if( tempFrame ) then
		tempFrame:SetParent(self.Frame);
		tempFrame:ClearAllPoints();
	else 
		tempFrame = CreateFrame("StatusBar", LVBMGui.InfoFrameGetNewName(), self.Frame, "LVBMInfoFrameTemplateBar");
	end
	tempFrame:SetWidth(140);
	tempFrame:SetHeight(16);
	tempFrame:SetPoint("TOP", self.Frame, "TOP", 0, -20);
	tempFrame:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar");
	tempFrame:SetStatusBarColor(0, 1, 0);
	tempFrame:SetMinMaxValues(tonumber(iMin), tonumber(iMax));
	tempFrame:SetValue(tonumber(iValue));
	if( iTitle ) then	getglobal(tempFrame:GetName().."Text"):SetText(iTitle);
	else			getglobal(tempFrame:GetName().."Text"):SetText("");
	end
	if( iLeftText ) then	getglobal(tempFrame:GetName().."LeftText"):SetText(iLeftText);
	else			getglobal(tempFrame:GetName().."LeftText"):SetText("");
	end
	if( iRightText ) then	getglobal(tempFrame:GetName().."RightText"):SetText(iRightText);
	else			getglobal(tempFrame:GetName().."RightText"):SetText("");
	end
	getglobal(tempFrame:GetName().."Text"):SetTextColor(1, 1, 1);
	getglobal(tempFrame:GetName().."LeftText"):SetTextColor(1, 1, 1);
	getglobal(tempFrame:GetName().."RightText"):SetTextColor(1, 1, 1);
	tempFrame:Show();
	LVBM_InfoFrameTemplate_OnUpdate(tempFrame:GetParent(), 0, true);
	
	table.insert(self.SubFrames, {
		["Type"] = "StatusBar",
		["Frame"] = tempFrame,
	});
	return setmetatable(self.SubFrames[table.getn(self.SubFrames)], LVBMGuiStatusBarMetatable);
end

function LVBMGuiStatusBar:SetValue(iValue)
	self.Frame:SetValue(tonumber(iValue));
end

function LVBMGuiStatusBar:SetTitle(iTitle)
	getglobal(self.Frame:GetName().."Text"):SetText(iTitle);
end

function LVBMGui:CreateTextField(iText)
	if self == LVBMGui then return; end
	local tempFrame;
	tempFrame = LVBMGui.InfoFrameRestoreFind("TextFrame");
	if( tempFrame ) then
		tempFrame:SetParent(self.Frame);
		tempFrame:ClearAllPoints();
	else 
		tempFrame = CreateFrame("Frame", LVBMGui.InfoFrameGetNewName(), self.Frame, "LVBMInfoFrameTemplateTextField");
	end
	tempFrame:SetPoint("TOP", self.Frame, "TOP", 0, -20);
	tempFrame:Show();
	LVBM_InfoFrameTemplate_OnUpdate(tempFrame:GetParent(), 0, true);
	if( iText ~= nil ) then
		getglobal(tempFrame:GetName().."Text"):SetText(iText);
	end

	table.insert(self.SubFrames, {
		["Ident"] = iSub,
		["Type"] = "TextFrame",
		["Frame"] = tempFrame,
	});	
	return setmetatable(self.SubFrames[table.getn(self.SubFrames)], LVBMGuiTextFieldMetatable);
end

function LVBMGuiTextField:SetText(iText)
	getglobal(self.Frame:GetName().."Text"):SetText(iText);
end

------------------
-- FRAME KILLER --
------------------
function LVBMGui:Delete()
	if self == LVBMGui then return; end
	if( self.SubFrames ) then	-- delete MainFrame
		for index, value in pairs(self.SubFrames) do		-- first delete all sub Frames
			value:Delete();
		end
	end
	self.Frame:ClearAllPoints();
	self.Frame:SetParent("LVBMInfoFrameTrash");
	self.Frame:SetPoint("TOPLEFT", 0, 0);
	self.Frame:UnregisterAllEvents();

	-- CleanUp Texts
	if getglobal(self.Frame:GetName().."Title") then		getglobal(self.Frame:GetName().."Title"):SetText("");		end
	if getglobal(self.Frame:GetName().."Text") then			getglobal(self.Frame:GetName().."Text"):SetText("");		end
	if getglobal(self.Frame:GetName().."LeftText") then		getglobal(self.Frame:GetName().."LeftText"):SetText("");	end
	if getglobal(self.Frame:GetName().."RightText") then		getglobal(self.Frame:GetName().."RightText"):SetText("");	end

	if self.Type == "StatusBar" then
		self.Frame:EnableMouse(false);
		self.Frame:SetValue(0);
		self.Frame:SetStatusBarColor(0, 1, 0)
		self.Frame:SetMinMaxValues(0, 1); 
		for index, value in pairs(LVBMStatusBarHandler) do
			if self.Frame:GetScript(value) then 	self.Frame:SetScript(value, nil);	end
		end
	elseif self.Type == "TextFrame" then
		self.Frame:EnableMouse(false);
		getglobal(self.Frame:GetName().."Text"):SetTextColor(1, 1, 1);
		for index, value in pairs(LVBMFrameHandler) do
			if self.Frame:GetScript(value) then 	self.Frame:SetScript(value, nil);	end
		end
	elseif not self.Type then --> main frame
		self.Frame:EnableMouse(true)
		self.Frame.elapsed = 0;
		self.Frame.myWidth = self.Frame:GetWidth();
		self.Frame.myHeight = self.Frame:GetHeight();		
		for index, value in pairs(LVBMFrameDefaultScripts) do
			if self.Frame:GetScript(index) ~= value then
				self.Frame:SetScript(index, value);
			end
		end
	end
	
	self.Frame:Hide();
	table.insert(LVBMGui["Trash"], { 
		["Type"] = self.Type or "MainFrame",
		["Frame"] = self.Frame,
	});

--[[local env = getfenv();
	for index, value in pairs(env) do
		if value == self then
			getfenv()[index] = nil;
			break;
		end
	end]]

end

function LVBMGui.InfoFrameRestoreFind(ftype) 		-- please DO NOT CALL THIS FUNCTION
	if( ftype == nil ) then return false; end
	for index, value in pairs(LVBMGui.Trash) do
		if( value.Type == ftype ) then
			LVBMGui.Trash[index] = nil;
			return value.Frame;
		end
	end
	return false;
end

--------------------------------------------------------------------------------
--
--   DistanceFrame - Usage via  /distance  loaded by GUI on "PLAYER_LOGIN"
--
--------------------------------------------------------------------------------


function LVBM_Gui_DistanceFrame(moption)
	if moption then moption = nil; end
	if( LVBMDistanceFrame ) then
		local mframe = LVBMDistanceFrame:GetObject();
		if( mframe:IsShown() and not moption ) then	LVBMDistanceFrame:Hide();
		else LVBMDistanceFrame:Show(); end
	else LVBM_Gui_CreateDistanceFrame();
	end
end

function LVBM_Gui_CreateDistanceFrame()
	LVBMDistanceFrame = LVBMGui:CreateInfoFrame(LVBMGUI_DISTANCE_FRAME_TITLE, LVBMGUI_DISTANCE_FRAME_TEXT);
	if( not LVBMDistanceFrame ) then 
		LVBM.AddMsg("Can't get Frame from CreateInfoFrame()");
		return false; 
	end
	LVBMDistanceFrame:GetObject():SetScript("OnUpdate", function() 
					LVBM_InfoFrameTemplate_OnUpdate(this, arg1); 
					LVBM_Gui_CreateDistanceFrame_OnUpdate(); 
				end);

	LVBMDistanceFramePlayer1 = LVBMDistanceFrame:CreateTextField("");
	getglobal(LVBMDistanceFramePlayer1:GetObject():GetName().."Text"):SetTextColor(1, 0, 0);
	LVBMDistanceFramePlayer2 = LVBMDistanceFrame:CreateTextField("");
	getglobal(LVBMDistanceFramePlayer2:GetObject():GetName().."Text"):SetTextColor(1, 0, 0);
	LVBMDistanceFramePlayer3 = LVBMDistanceFrame:CreateTextField("");
	getglobal(LVBMDistanceFramePlayer3:GetObject():GetName().."Text"):SetTextColor(1, 0, 0);
	LVBMDistanceFramePlayer4 = LVBMDistanceFrame:CreateTextField("");
	getglobal(LVBMDistanceFramePlayer4:GetObject():GetName().."Text"):SetTextColor(1, 0, 0);
	LVBMDistanceFramePlayer5 = LVBMDistanceFrame:CreateTextField("");
	getglobal(LVBMDistanceFramePlayer5:GetObject():GetName().."Text"):SetTextColor(1, 0, 0);
end

function LVBM_Gui_CreateDistanceFrame_OnUpdate()
	if( this.elapsed == nil ) then this.elapsed = 0; end
	this.elapsed = this.elapsed + arg1;
	if( this.elapsed > 0.5 ) then
		local x=1;

		for i=1, GetNumRaidMembers(), 1 do
			if( x <= 5 and CheckInteractDistance("raid"..i, 3) 
			and not UnitIsDeadOrGhost("raid"..i) 
			and UnitName("raid"..i) ~= UnitName("player") ) then

				if( getglobal("LVBMDistanceFramePlayer"..x) ) then
					getglobal("LVBMDistanceFramePlayer"..x):SetText(UnitName("raid"..i));
				end
				x = x + 1;

			end
		end

		if( x <= 5 ) then
			for i=x, 5, 1  do
				if( getglobal("LVBMDistanceFramePlayer"..i) ) then
					getglobal("LVBMDistanceFramePlayer"..i):SetText("");
				end
			end
		end
	end
end





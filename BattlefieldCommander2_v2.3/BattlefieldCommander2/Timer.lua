
-- Implemented the Timer in an object-oriented manner so I can have several easily.

BFC_Timer = {
	id = 0,
	nextid = 0,
	callback = nil,
	oldtime = 0,
	remaining = -1,
	label = nil,
	fontString = nil,
	started = false,
	timerColorCode = NORMAL_FONT_COLOR_CODE,
	labelColorCode = NORMAL_FONT_COLOR_CODE,
	format = "s",
};


-- Constructor for timer object
function BFC_Timer:new()
	t = {};
	setmetatable(t, self);
	self.__index = self;
	
	t.id = BFC_Timer.nextid;
	BFC_Timer.nextid = BFC_Timer.nextid + 1;
	
	return t;
end


function BFC_Timer:SetText(label)
	self.label = label;
end

function BFC_Timer:GetText()
	return self.label;
end


function BFC_Timer:SetFormat(format)
	self.format = format;
	self:UpdateDisplay();
end

function BFC_Timer:GetFormat()
	return self.format;
end


function BFC_Timer:SetFontString(fs)
	self.fontString = fs;
	self:UpdateDisplay();
end

function BFC_Timer:GetFontString()
	return self.fontString;
end


function BFC_Timer:SetTimerColorCode(code)
	self.timerColorCode = code;
	self:UpdateDisplay();
end

function BFC_Timer:GetTimerColorCode()
	return self.timerColorCode;
end

function BFC_Timer:SetLabelColorCode(code)
	self.labelColorCode = code;
	self:UpdateDisplay();
end

function BFC_Timer:GetLabelColorCode()
	return self.labelColorCode;
end


-- The callback is a function that will be called when the timer
-- counts down to zero
function BFC_Timer:SetCallback(func)
	self.callback = func;
end

function BFC_Timer:GetCallback()
	return func;
end


function BFC_Timer:SetTime(seconds)
	self.remaining = seconds;
	self:UpdateDisplay();
end

function BFC_Timer:GetTime()
	return self.remaining;
end


function BFC_Timer:UpdateDisplay()
	if self.fontString == nil then return end
	
	if(self.remaining < 0) then
		if(self.label == nil) then
			self.fontString:SetText("");
		else
			self.fontString:SetText(self.labelColorCode .. self.label .. ":");
		end
	elseif(self.label == nil) then
		if(self.format == "s") then
			self.fontString:SetText(math.ceil(self.remaining) .. "s");
		elseif(self.format == "ms") then
			self.fontString:SetText(BFC_Util.SecondsToMinutesSeconds(math.ceil(self.remaining)));
		end
	else
		if(self.format == "s") then
			self.fontString:SetText(self.labelColorCode .. self.label .. ": " .. self.timerColorCode .. math.ceil(self.remaining) .. "s");
		elseif(self.format == "ms") then
			self.fontString:SetText(self.labelColorCode .. self.label .. ": " .. self.timerColorCode .. BFC_Util.SecondsToMinutesSeconds(math.ceil(self.remaining)));
		end
	end
end


-- Called every OnUpdate
function BFC_Timer:Tick(elapsed)
	self.remaining = self.remaining - elapsed;

	if(self.remaining < 0) then
		self:Stop();
		self.remaining = 0;
	end
	
	self:UpdateDisplay();
	
	if(self.remaining == 0 and self.callback ~= nil) then
		self.callback(self); -- pass a reference to this timer back, the callback probably handles several timers
	end
end


function BFC_Timer:Start()
	if(self.remaining < 0) then
		BFC.Log(BFC.LOG_ERROR, BFC_Strings.Errors.uninitialized);
		return;
	end
	
	if(self.started == true) then
		return;
	end
	
	-- Voodoo! Collapse self.foo(self, x) to a new bar(x) so it can be registered as a callback
	BFC_Common.RegisterUpdateFunction("timer" .. self.id, function(x) self:Tick(x) end);
	self.started = true;
end


function BFC_Timer:Stop()
	if(self.started == true) then
		BFC_Common.UnregisterUpdateFunction("timer" .. self.id);
		self.started = false;
	end
end
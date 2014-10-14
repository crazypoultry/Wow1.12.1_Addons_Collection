LVBMStatusBars_DragFrameFunctions = { --we need these functions because we have to re-create the drag frame dynamically when we want to change the design
	["OnLoad"] = function(frame)
		frame.isMoving = false;
		frame.elapsed = 0;
		frame.timer = 20;
		frame:RegisterEvent("PLAYER_ENTERING_WORLD");
		getglobal(frame:GetName().."Bar"):SetMinMaxValues(0, 20);
		getglobal(frame:GetName().."BarText"):SetText("Drag me!");
		getglobal(frame:GetName().."BarTimer"):SetText(LVBM.SecondsToTime(this.timer));
	end,
	["OnUpdate"] = function()
		this.elapsed = this.elapsed + arg1;
		if this.elapsed >= this.timer then
			this.elapsed = 0;
			this.timer = 20;
			this:Hide();
			getglobal(this:GetName().."BarTimer"):SetText(LVBM.SecondsToTime(this.timer));					
		else
			getglobal(this:GetName().."BarTimer"):SetText(LVBM.SecondsToTime(this.timer - this.elapsed));
			
			if LVBM.Options.FillUpStatusBars then
				getglobal(this:GetName().."Bar"):SetValue(this.elapsed);
			else
				getglobal(this:GetName().."Bar"):SetValue(this.timer - this.elapsed);
			end
		end				
		
		if LVBM_StatusBarTimer1 and LVBM_StatusBarTimer1:IsShown() and LVBM_StatusBarTimer1:GetAlpha() >= 0.1 then
			LVBM_StatusBarTimer1:SetAlpha(0);
			if LVBM_StatusBarTimer1.table and LVBM_StatusBarTimer1.table.isFlashing then
				UIFrameFadeRemoveFrame(LVBM_StatusBarTimer1);
				UIFrameFlashRemoveFrame(LVBM_StatusBarTimer1);
				LVBM_StatusBarTimer1.flashTimer = nil;
				LVBM_StatusBarTimer1.fadeInTime = nil;
				LVBM_StatusBarTimer1.fadeOutTime = nil;
				LVBM_StatusBarTimer1.flashDuration = nil;
				LVBM_StatusBarTimer1.showWhenDone = nil;
				LVBM_StatusBarTimer1.flashTimer = nil;
				LVBM_StatusBarTimer1.flashMode = nil;
				LVBM_StatusBarTimer1.flashInHoldTime = nil;
				LVBM_StatusBarTimer1.flashOutHoldTime = nil;
				LVBM_StatusBarTimer1.fadeInfo = nil;
				LVBM_StatusBarTimer1.table.isFlashing = nil;
			end
			LVBM.Schedule(20.1, function() LVBM_StatusBarTimer1:SetAlpha(1); end)
		end
		
		local minValue, maxValue;
		minValue, maxValue = getglobal(this:GetName().."Bar"):GetMinMaxValues();
		if LVBM.Options.FillUpStatusBars then
			getglobal(this:GetName().."BarSpark"):SetPoint("CENTER", getglobal(this:GetName().."Bar"), "LEFT", (((getglobal(this:GetName().."Bar"):GetValue() - arg1) / maxValue) * getglobal(this:GetName().."Bar"):GetWidth()), LVBMStatusBars_Designs[LVBM.Options.StatusBarDesign].sparkOffset);
		else
			getglobal(this:GetName().."BarSpark"):SetPoint("CENTER", getglobal(this:GetName().."Bar"), "LEFT", ((getglobal(this:GetName().."Bar"):GetValue() / maxValue) * getglobal(this:GetName().."Bar"):GetWidth()), LVBMStatusBars_Designs[LVBM.Options.StatusBarDesign].sparkOffset);
		end
	end,	
	["OnHide"] = function()
		if this.isMoving then
			LVBM_StatusBarTimerAnchor:StopMovingOrSizing();
			this.isMoving = false;
		end
		this.elapsed = 0;
		this.timer = 20;
		getglobal(this:GetName().."BarTimer"):SetText(LVBM.SecondsToTime(this.timer));
		if LVBM_StatusBarTimer1 then
			LVBM_StatusBarTimer1:SetAlpha(1);
		end
	end,
	["OnEvent"] = function()
		if event == "PLAYER_ENTERING_WORLD" then
			this:SetUserPlaced(nil); --this sucks a bit...:O
			this:ClearAllPoints();
			this:SetPoint("CENTER", "LVBM_StatusBarTimerAnchor", "CENTER");
		end
	end,
	["OnMouseUp"] = function()
		if this.isMoving then
			LVBM_StatusBarTimerAnchor:StopMovingOrSizing();
			this.isMoving = false;
		end
		if arg1 == "RightButton" then
			this:Hide();
		end
	end,	
	["OnMouseDown"] = function()
		if arg1 == "LeftButton" then
			LVBM_StatusBarTimerAnchor:StartMoving();
			this.isMoving = true;
		end
	end,
	["OnEnter"] = function()
	end,
	["OnLeave"] = function()
	end,
};

LVBMStatusBars_Designs = {
	[1] = {
		["name"] = LVBM_BAR_STYLE_DEFAULT,
		["template"] = "LVBM_StatusBarTimerDefaultTemplate",
		["widthModifier"] = 8,
		["textWidthModifier"] = 59,
		["distance"] = -3,
		["sparkOffset"] = 0,
		["color"] = {
			["r"] = 1.0,
			["g"] = 0.7,
			["b"] = 0.0,
			["a"] = 1.0,
		},
		["width"] = 195,
		["scale"] = 1,
		["subFrameNames"] = {
			"Bar", "BarText", "BarTimer", "BarSpark", "BarBackground", "BarBar"
		},
		["initialize"] = function(frame)
			getglobal(frame:GetName().."BarSpark"):SetVertexColor(1, 1, 1, 1);
		end
	},
	[2] = {
		["name"] = LVBM_BAR_STYLE_MODERN,
		["template"] = "LVBM_StatusBarTimerExtraTemplate1",
		["widthModifier"] = 8,
		["textWidthModifier"] = 59,
		["distance"] = 0,
		["sparkOffset"] = -1,
		["color"] = {
			["r"] = 1.0,
			["g"] = 0.7,
			["b"] = 0.0,
			["a"] = 0.8,
		},
		["width"] = 245,
		["scale"] = 1,
		["subFrameNames"] = {
			"Bar", "BarText", "BarTimer", "BarSpark", "BarBackground", "BarBar"
		},
		["onColorChanged"] = function(frame, r, g, b, a)
			getglobal(frame:GetParent():GetName().."BarSpark"):SetVertexColor(r, g, b, a);
		end,
		["initialize"] = function(frame)
			getglobal(frame:GetName().."BarSpark"):SetVertexColor(LVBMStatusBars_Designs[2].color.r, LVBMStatusBars_Designs[2].color.g, LVBMStatusBars_Designs[2].color.b, LVBMStatusBars_Designs[2].color.a);
		end
	},
	[3] = {
		["name"] = LVBM_BAR_STYLE_CLOUDS,
		["template"] = "LVBM_StatusBarTimerExtraTemplate2",
		["widthModifier"] = 8,
		["textWidthModifier"] = 59,
		["distance"] = 0,
		["sparkOffset"] = -1,
		["color"] = {
			["r"] = 0.0,
			["g"] = 1.0,
			["b"] = 1.0,
			["a"] = 1.0,
		},
		["width"] = 245,
		["scale"] = 1,
		["subFrameNames"] = {
			"Bar", "BarText", "BarTimer", "BarSpark", "BarBackground", "BarBar"
		},
		["onColorChanged"] = function(frame, r, g, b, a)
			getglobal(frame:GetParent():GetName().."BarSpark"):SetVertexColor(r, g, b, a);
		end,
		["initialize"] = function(frame)
			getglobal(frame:GetName().."BarSpark"):SetVertexColor(LVBMStatusBars_Designs[3].color.r, LVBMStatusBars_Designs[3].color.g, LVBMStatusBars_Designs[3].color.b, LVBMStatusBars_Designs[3].color.a);
		end,
	},
	[4] = {
		["name"] = LVBM_BAR_STYLE_PERL,
		["template"] = "LVBM_StatusBarTimerExtraTemplate3",
		["widthModifier"] = 8,
		["textWidthModifier"] = 59,
		["distance"] = -3,
		["sparkOffset"] = 0,
		["color"] = {
			["r"] = 1.0,
			["g"] = 0.7,
			["b"] = 0.0,
			["a"] = 1.0,
		},
		["width"] = 195,
		["scale"] = 1,
		["subFrameNames"] = {
			"Bar", "BarText", "BarTimer", "BarSpark", "BarBackground", "BarBar"
		},		
		["initialize"] = function(frame)
			getglobal(frame:GetName().."BarSpark"):SetVertexColor(LVBMStatusBars_Designs[4].color.r, LVBMStatusBars_Designs[4].color.g, LVBMStatusBars_Designs[4].color.b, LVBMStatusBars_Designs[4].color.a);
		end,
	},
--[[[5] = {
		["name"] = "TEST",
		["template"] = "LVBM_StatusBarTimerTestTemplate",
		["widthModifier"] = 8,
		["textWidthModifier"] = 59,
		["distance"] = 0,
		["sparkOffset"] = -1,
		["color"] = {
			["r"] = 0.0,
			["g"] = 1.0,
			["b"] = 1.0,
			["a"] = 0.5,
		},
		["width"] = 195,
		["scale"] = 1,
		["subFrameNames"] = {
			"Bar", "BarText", "BarTimer", "BarSpark", "BarBackground", "BarBar", "BarBackgroundBar", "BarBackgroundBarBar"
		},
		["onSetMinMaxValues"] = function(frame, minValue, maxValue)
			getglobal(frame:GetName().."BackgroundBar"):SetMinMaxValues(minValue, maxValue);
		end,
		["onSetValue"] = function(frame, value)
			getglobal(frame:GetName().."BackgroundBar"):SetValue(value);
		end,
		["onColorChanged"] = function(frame, r, g, b, a)
			getglobal(frame:GetParent():GetName().."BarSpark"):SetVertexColor(r, g, b, a);
		end,
		["initialize"] = function(frame)
			getglobal(frame:GetName().."BarSpark"):SetVertexColor(LVBMStatusBars_Designs[5].color.r, LVBMStatusBars_Designs[5].color.g, LVBMStatusBars_Designs[5].color.b, LVBMStatusBars_Designs[5].color.a);
		end,
	},]]
};

function LVBMStatusBars_OnUpdate(elapsed)
	if this.isUsed and this.table then

		this.table.elapsed = this.table.elapsed + elapsed;
		if LVBM.Options.FillUpStatusBars then
			getglobal(this:GetName().."Bar"):SetValue(this.table.elapsed);
		else
			getglobal(this:GetName().."Bar"):SetValue(this.table.timer - this.table.elapsed);
		end
		getglobal(this:GetName().."BarTimer"):SetText(LVBM.SecondsToTime(this.table.timer - this.table.elapsed));
		if LVBM.Options.FlashBars and not this.table.isFlashing and this.table.timer - this.table.elapsed < 7.5 and this.table.timer > 12.5 then
			this.table.isFlashing = true;
			UIFrameFlash(this, 0.3, 0.3, this.table.timer - this.table.elapsed, 1, 0, 0.75);
		end
		if this.table.elapsed >= this.table.timer then
			if GameTooltip:IsShown() and GameTooltipTextLeft1 and GameTooltipTextLeft1:GetText() == getglobal(this:GetName().."BarText"):GetText() and ((not this.table.repetitions) or this.table.repetitions <= 1) then
				GameTooltip:Hide();
			end
			LVBM.EndStatusBarTimer(this.usedBy, true);
			return;
		end
		if LVBM.Options.AutoColorBars and this.startedBy ~= "Battlegrounds" then
			local percent = (this.table.timer - this.table.elapsed) / this.table.timer;
			if this.specialColor then
				getglobal(this:GetName().."Bar"):SetStatusBarColor(this.table.color.R + ((1 - this.table.color.R) * (1 - percent)), this.table.color.G * percent, this.table.color.B * percent, this.table.color.A);
			else
				getglobal(this:GetName().."Bar"):SetStatusBarColor(LVBM.Options.StatusBarColor.r + ((1 - LVBM.Options.StatusBarColor.r) * (1 - percent)), LVBM.Options.StatusBarColor.g * percent, LVBM.Options.StatusBarColor.b * percent, LVBM.Options.StatusBarColor.a);
			end
		end
		local minValue, maxValue;
		minValue, maxValue = getglobal(this:GetName().."Bar"):GetMinMaxValues();
		getglobal(this:GetName().."BarSpark"):ClearAllPoints();
		if LVBM.Options.FillUpStatusBars then
			getglobal(this:GetName().."BarSpark"):SetPoint("CENTER", (this:GetName().."Bar"), "LEFT", (((getglobal(this:GetName().."Bar"):GetValue() - elapsed) / maxValue) * getglobal(this:GetName().."Bar"):GetWidth()), LVBMStatusBars_Designs[LVBM.Options.StatusBarDesign].sparkOffset);
		else
			getglobal(this:GetName().."BarSpark"):SetPoint("CENTER", (this:GetName().."Bar"), "LEFT", (((getglobal(this:GetName().."Bar"):GetValue()) / maxValue) * getglobal(this:GetName().."Bar"):GetWidth()), LVBMStatusBars_Designs[LVBM.Options.StatusBarDesign].sparkOffset);
		end
		
		if GameTooltip:IsShown() and GameTooltipTextLeft1 and GameTooltipTextLeft1:GetText() == getglobal(this:GetName().."BarText"):GetText() then
			if GameTooltipTextRight2 then
				GameTooltipTextRight2:SetText(LVBM.SecondsToTime(this.table.timer - this.table.elapsed));
			end
			if GameTooltipTextRight3 then
				GameTooltipTextRight3:SetText(LVBM.SecondsToTime(this.table.elapsed));
			end
			if GameTooltipTextLeft5 and GameTooltipTextRight5 and GameTooltipTextLeft5:GetText() == LVBM_SBT_REPETITIONS then
				if not this.table.infinite then
					GameTooltipTextRight5:SetText(this.table.repetitions);
				end
			end
		end
	end
end

function LVBMStatusBars_OnEnter()
	if not this.table then
		return;
	end
	GameTooltip:Hide();
	GameTooltip:ClearLines();
	GameTooltip_SetDefaultAnchor(GameTooltip, UIParent);
	GameTooltip:SetText(getglobal(this:GetName().."BarText"):GetText());
	GameTooltip:AddDoubleLine(LVBM_SBT_TIMELEFT, LVBM.SecondsToTime(this.table.timer - this.table.elapsed), NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	GameTooltip:AddDoubleLine(LVBM_SBT_TIMEELAPSED, LVBM.SecondsToTime(this.table.elapsed), NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	GameTooltip:AddDoubleLine(LVBM_SBT_TOTALTIME, LVBM.SecondsToTime(this.table.timer), NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	if this.table.isRepeating and this.table.repetitions then
		if this.table.infinite then
			GameTooltip:AddDoubleLine(LVBM_SBT_REPETITIONS, LVBM_SBT_INFINITE, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
		else
			GameTooltip:AddDoubleLine(LVBM_SBT_REPETITIONS, this.table.repetitions, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
		end
	end
	if this.table.startedBy and this.table.startedBy ~= "UNKNOWN" then
		GameTooltip:AddDoubleLine(LVBM_SBT_BOSSMOD, this.table.startedBy, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	end
	if this.table.syncedBy and this.table.syncedBy ~= LVBM_LOCAL then	
		GameTooltip:AddDoubleLine(LVBM_SBT_STARTEDBY, this.table.syncedBy, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	else
		GameTooltip:AddDoubleLine(LVBM_SBT_STARTEDBY, UnitName("player"), NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	end
	GameTooltip:AddLine(LVBM_SBT_LEFTCLICK, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
	GameTooltip:AddLine(LVBM_SBT_RIGHTCLICK, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
	GameTooltip:Show();
end

function LVBMStatusBars_SetDefaultValues()
	LVBM.Options.StatusBarColor.r = LVBMStatusBars_Designs[LVBM.Options.StatusBarDesign].color.r;
	LVBM.Options.StatusBarColor.g = LVBMStatusBars_Designs[LVBM.Options.StatusBarDesign].color.g;
	LVBM.Options.StatusBarColor.b = LVBMStatusBars_Designs[LVBM.Options.StatusBarDesign].color.b;
	LVBM.Options.StatusBarColor.a = LVBMStatusBars_Designs[LVBM.Options.StatusBarDesign].color.a;
	LVBM.Options.StatusBarSize.Width = LVBMStatusBars_Designs[LVBM.Options.StatusBarDesign].width;
	LVBM.Options.StatusBarSize.Scale = LVBMStatusBars_Designs[LVBM.Options.StatusBarDesign].scale;	
	LVBM.Options.StatusBarsFlippedOver = false;
	LVBM.Options.FillUpStatusBars = true;
	LVBM.Options.EnableStatusBars = true;
end

function LVBMStatusBars_FlipOver()
	if LVBM.Options.StatusBarsFlippedOver then
		for i = 2, LVBM.StatusBarCount do
			getglobal("LVBM_StatusBarTimer"..i):ClearAllPoints()
			getglobal("LVBM_StatusBarTimer"..i):SetPoint("BOTTOM", "LVBM_StatusBarTimer"..(i-1), "TOP", 0, LVBMStatusBars_Designs[LVBM.Options.StatusBarDesign].distance);
		end
	else
		for i = 2, LVBM.StatusBarCount do
			getglobal("LVBM_StatusBarTimer"..i):ClearAllPoints()
			getglobal("LVBM_StatusBarTimer"..i):SetPoint("TOP", "LVBM_StatusBarTimer"..(i-1), "BOTTOM", 0, -LVBMStatusBars_Designs[LVBM.Options.StatusBarDesign].distance);
		end
	end
end

function LVBMStatusBars_PullTogether()
	for i = 2, LVBM.StatusBarCount do
		if getglobal("LVBM_StatusBarTimer"..i).isUsed and (not getglobal("LVBM_StatusBarTimer"..(i-1)).isUsed) then
			local j = i - 1;
			
			if getglobal("LVBM_StatusBarTimer"..i).specialColor then
				getglobal("LVBM_StatusBarTimer"..i.."Bar"):SetStatusBarColor(LVBM.Options.StatusBarColor.r, LVBM.Options.StatusBarColor.g, LVBM.Options.StatusBarColor.b, LVBM.Options.StatusBarColor.a);
			end
			
			for index, value in pairs(getglobal("LVBM_StatusBarTimer"..i)) do
				if type(value) ~= "userdata" then
					getglobal("LVBM_StatusBarTimer"..j)[index] = value;
				end
			end
			
			getglobal("LVBM_StatusBarTimer"..i):Hide();	
			getglobal("LVBM_StatusBarTimer"..i).isUsed = false;
			getglobal("LVBM_StatusBarTimer"..i).usedBy = "";
			getglobal("LVBM_StatusBarTimer"..i).isRepeating = false;
			getglobal("LVBM_StatusBarTimer"..i).repetitions = 0;
			getglobal("LVBM_StatusBarTimer"..i).specialColor = false;
			if getglobal("LVBM_StatusBarTimer"..i).table.isFlashing then
				UIFrameFadeRemoveFrame(getglobal("LVBM_StatusBarTimer"..i));
				UIFrameFlashRemoveFrame(getglobal("LVBM_StatusBarTimer"..i));
				getglobal("LVBM_StatusBarTimer"..i):SetAlpha(1.0);
				getglobal("LVBM_StatusBarTimer"..i).flashTimer = nil;
				getglobal("LVBM_StatusBarTimer"..i).fadeInTime = nil;
				getglobal("LVBM_StatusBarTimer"..i).fadeOutTime = nil;
				getglobal("LVBM_StatusBarTimer"..i).flashDuration = nil;
				getglobal("LVBM_StatusBarTimer"..i).showWhenDone = nil;
				getglobal("LVBM_StatusBarTimer"..i).flashTimer = nil;
				getglobal("LVBM_StatusBarTimer"..i).flashMode = nil;
				getglobal("LVBM_StatusBarTimer"..i).flashInHoldTime = nil;
				getglobal("LVBM_StatusBarTimer"..i).flashOutHoldTime = nil;
				getglobal("LVBM_StatusBarTimer"..i).fadeInfo = nil;
				
				UIFrameFlash(getglobal("LVBM_StatusBarTimer"..j), 0.3, 0.3, getglobal("LVBM_StatusBarTimer"..i).table.timer - getglobal("LVBM_StatusBarTimer"..i).table.elapsed, 1, 0, 0.75);
			else
				UIFrameFadeRemoveFrame(getglobal("LVBM_StatusBarTimer"..j));
				UIFrameFlashRemoveFrame(getglobal("LVBM_StatusBarTimer"..j));
				getglobal("LVBM_StatusBarTimer"..j):SetAlpha(1.0);
				getglobal("LVBM_StatusBarTimer"..j).flashTimer = nil;
				getglobal("LVBM_StatusBarTimer"..j).fadeInTime = nil;
				getglobal("LVBM_StatusBarTimer"..j).fadeOutTime = nil;
				getglobal("LVBM_StatusBarTimer"..j).flashDuration = nil;
				getglobal("LVBM_StatusBarTimer"..j).showWhenDone = nil;
				getglobal("LVBM_StatusBarTimer"..j).flashTimer = nil;
				getglobal("LVBM_StatusBarTimer"..j).flashMode = nil;
				getglobal("LVBM_StatusBarTimer"..j).flashInHoldTime = nil;
				getglobal("LVBM_StatusBarTimer"..j).flashOutHoldTime = nil;
				getglobal("LVBM_StatusBarTimer"..j).fadeInfo = nil;
			end
			getglobal("LVBM_StatusBarTimer"..i).table = nil;

			if getglobal("LVBM_StatusBarTimer"..j).specialColor and getglobal("LVBM_StatusBarTimer"..j).table and type(getglobal("LVBM_StatusBarTimer"..j).table.color) == "table" then
				getglobal("LVBM_StatusBarTimer"..j.."Bar"):SetStatusBarColor(getglobal("LVBM_StatusBarTimer"..j).table.color.R, getglobal("LVBM_StatusBarTimer"..j).table.color.G, getglobal("LVBM_StatusBarTimer"..j).table.color.B, getglobal("LVBM_StatusBarTimer"..j).table.color.A);
			else
				getglobal("LVBM_StatusBarTimer"..j.."Bar"):SetStatusBarColor(LVBM.Options.StatusBarColor.r, LVBM.Options.StatusBarColor.g, LVBM.Options.StatusBarColor.b, LVBM.Options.StatusBarColor.a);
			end
			getglobal("LVBM_StatusBarTimer"..j.."Bar"):SetMinMaxValues(0, getglobal("LVBM_StatusBarTimer"..j).table.timer);
			if type(LVBM_SBT[getglobal("LVBM_StatusBarTimer"..j).usedBy]) == "string" then
				getglobal("LVBM_StatusBarTimer"..j.."BarText"):SetText(LVBM_SBT[getglobal("LVBM_StatusBarTimer"..j).usedBy]);

			elseif type(LVBM_SBT[getglobal("LVBM_StatusBarTimer"..j).startedBy]) == "table" then
				-- Translation System for Bars with Dynamic Content "Injection: xxxx"
				local tempname = getglobal("LVBM_StatusBarTimer"..j).usedBy;
				for index, value in pairs(LVBM_SBT[getglobal("LVBM_StatusBarTimer"..j).startedBy]) do
					tempname = string.gsub(tempname, value[1], value[2]);
				end
				getglobal("LVBM_StatusBarTimer"..j.."BarText"):SetText(tempname);
			else
				getglobal("LVBM_StatusBarTimer"..j.."BarText"):SetText(getglobal("LVBM_StatusBarTimer"..j).usedBy);
			end
			getglobal("LVBM_StatusBarTimer"..j.."BarTimer"):SetText(LVBM.SecondsToTime(getglobal("LVBM_StatusBarTimer"..j).table.timer));
			getglobal("LVBM_StatusBarTimer"..j):Show();
	
			getglobal("LVBM_StatusBarTimer"..j).table.barId = j;
			getglobal("LVBM_StatusBarTimer"..j).table.frame = getglobal("LVBM_StatusBarTimer"..j);
		end
	end
end

function LVBMStatusBars_Resize()
	LVBM_StatusBarTimerDrag:SetScale(LVBM.Options.StatusBarSize.Scale);
	LVBM_StatusBarTimerDrag:SetWidth(LVBM.Options.StatusBarSize.Width);
	LVBM_StatusBarTimerDragBar:SetWidth(LVBM.Options.StatusBarSize.Width - LVBMStatusBars_Designs[LVBM.Options.StatusBarDesign].widthModifier);
	LVBM_StatusBarTimerDragBarTimer:SetJustifyH("RIGHT");
	LVBM_StatusBarTimerDragBarText:SetWidth(LVBM.Options.StatusBarSize.Width - LVBMStatusBars_Designs[LVBM.Options.StatusBarDesign].textWidthModifier);	
	for i = 1, LVBM.StatusBarCount do
		getglobal("LVBM_StatusBarTimer"..i):SetScale(LVBM.Options.StatusBarSize.Scale);
		getglobal("LVBM_StatusBarTimer"..i):SetWidth(LVBM.Options.StatusBarSize.Width);
		getglobal("LVBM_StatusBarTimer"..i.."Bar"):SetWidth(LVBM.Options.StatusBarSize.Width -  LVBMStatusBars_Designs[LVBM.Options.StatusBarDesign].widthModifier);
		getglobal("LVBM_StatusBarTimer"..i.."BarText"):SetWidth(LVBM.Options.StatusBarSize.Width - LVBMStatusBars_Designs[LVBM.Options.StatusBarDesign].textWidthModifier);		
	end
end

function LVBMStatusBars_CreateNewBar()
	if (LVBM.StatusBarCount + 1) > LVBM.Options.MaxStatusBars then
		return;
	end
	LVBM.StatusBarCount = LVBM.StatusBarCount + 1;
	local newBar = CreateFrame("Frame", "LVBM_StatusBarTimer"..LVBM.StatusBarCount, UIParent, LVBMStatusBars_Designs[LVBM.Options.StatusBarDesign].template);
	newBar:SetScale(LVBM.Options.StatusBarSize.Scale);
	newBar:SetWidth(LVBM.Options.StatusBarSize.Width);
	getglobal(newBar:GetName().."Bar"):SetWidth(LVBM.Options.StatusBarSize.Width - LVBMStatusBars_Designs[LVBM.Options.StatusBarDesign].widthModifier);
	getglobal(newBar:GetName().."Bar"):SetStatusBarColor(LVBM.Options.StatusBarColor.r, LVBM.Options.StatusBarColor.g, LVBM.Options.StatusBarColor.b, LVBM.Options.StatusBarColor.a);
	getglobal(newBar:GetName().."BarText"):SetWidth(LVBM.Options.StatusBarSize.Width - LVBMStatusBars_Designs[LVBM.Options.StatusBarDesign].textWidthModifier);
	if LVBM.StatusBarCount == 1 then
		newBar:SetPoint("CENTER", "LVBM_StatusBarTimerDrag", "CENTER", 0, 0);
	else
		if LVBM.Options.StatusBarsFlippedOver then
			newBar:SetPoint("BOTTOM", "LVBM_StatusBarTimer"..(LVBM.StatusBarCount - 1), "TOP", 0, LVBMStatusBars_Designs[LVBM.Options.StatusBarDesign].distance);
		else
			newBar:SetPoint("TOP", "LVBM_StatusBarTimer"..(LVBM.StatusBarCount - 1), "BOTTOM", 0, -LVBMStatusBars_Designs[LVBM.Options.StatusBarDesign].distance);
		end
	end
	
	if type(LVBMStatusBars_Designs[LVBM.Options.StatusBarDesign].initialize) == "function" then
		LVBMStatusBars_Designs[LVBM.Options.StatusBarDesign].initialize(getglobal("LVBM_StatusBarTimer"..LVBM.StatusBarCount));
	end
		
	if not LVBM.Hooks.oldSetStatusBarColor then
		LVBM.Hooks.oldSetStatusBarColor = getglobal("LVBM_StatusBarTimer"..LVBM.StatusBarCount.."Bar").SetStatusBarColor;
	end
	if not LVBM.Hooks.oldSetMinMaxValues then
		LVBM.Hooks.oldSetMinMaxValues = getglobal("LVBM_StatusBarTimer"..LVBM.StatusBarCount.."Bar").SetMinMaxValues;
	end
	if not LVBM.Hooks.oldSetValue then
		LVBM.Hooks.oldSetValue = getglobal("LVBM_StatusBarTimer"..LVBM.StatusBarCount.."Bar").SetValue;
	end
		
	getglobal("LVBM_StatusBarTimer"..LVBM.StatusBarCount.."Bar").SetStatusBarColor = function(frame, r, g, b, a)
		if type(LVBMStatusBars_Designs[LVBM.Options.StatusBarDesign].onColorChanged) == "function" then
			LVBMStatusBars_Designs[LVBM.Options.StatusBarDesign].onColorChanged(frame, r, g, b, a);
		end
		LVBM.Hooks.oldSetStatusBarColor(frame, r, g, b, a);
	end
	
	getglobal("LVBM_StatusBarTimer"..LVBM.StatusBarCount.."Bar").SetMinMaxValues = function(frame, minValue, maxValue)
		if type(LVBMStatusBars_Designs[LVBM.Options.StatusBarDesign].onSetMinMaxValues) == "function" then
			LVBMStatusBars_Designs[LVBM.Options.StatusBarDesign].onSetMinMaxValues(frame, minValue, maxValue);
		end
		LVBM.Hooks.oldSetMinMaxValues(frame, minValue, maxValue);
	end
	
	getglobal("LVBM_StatusBarTimer"..LVBM.StatusBarCount.."Bar").SetValue = function(frame, value)
		if type(LVBMStatusBars_Designs[LVBM.Options.StatusBarDesign].onSetValue) == "function" then
			LVBMStatusBars_Designs[LVBM.Options.StatusBarDesign].onSetValue(frame, value);
		end
		LVBM.Hooks.oldSetValue(frame, value);
	end
	
	LVBMGuiUpdateStatusbars();
	
	return LVBM.StatusBarCount;
end

function LVBMStatusBars_ChangeDesign(designID, forceReload)
	local oldDesign = LVBM.Options.StatusBarDesign;
	local oldBarCount = LVBM.StatusBarCount;
	local oldFrameSettings;
	if oldDesign == designID and not forceReload then
		return;
	end
	if oldDesign ~= designID then --don't need to reset the options if we forced a re-creation of the frames
		LVBM.Options.StatusBarDesign = designID;
		LVBM.StatusBarCount = 0;
		LVBM.Options.StatusBarColor.r = LVBMStatusBars_Designs[LVBM.Options.StatusBarDesign].color.r;
		LVBM.Options.StatusBarColor.g = LVBMStatusBars_Designs[LVBM.Options.StatusBarDesign].color.g;
		LVBM.Options.StatusBarColor.b = LVBMStatusBars_Designs[LVBM.Options.StatusBarDesign].color.b;
		LVBM.Options.StatusBarColor.a = LVBMStatusBars_Designs[LVBM.Options.StatusBarDesign].color.a;
		LVBM.Options.StatusBarSize.Width = LVBMStatusBars_Designs[LVBM.Options.StatusBarDesign].width;
		LVBM.Options.StatusBarSize.Scale = LVBMStatusBars_Designs[LVBM.Options.StatusBarDesign].scale;
	end
	if LVBM_StatusBarTimerDrag then
		LVBM_StatusBarTimerDrag:Hide();
	end

	for index, value in pairs(LVBMStatusBars_Designs[oldDesign].subFrameNames) do
		setglobal("LVBM_StatusBarTimerDrag"..value, nil);
	end
	setglobal("LVBM_StatusBarTimerDrag", nil);

	local newDragBar = CreateFrame("Frame", "LVBM_StatusBarTimerDrag", UIParent, LVBMStatusBars_Designs[LVBM.Options.StatusBarDesign].template);
	newDragBar:SetScale(LVBM.Options.StatusBarSize.Scale);
	newDragBar:SetWidth(LVBM.Options.StatusBarSize.Width);
	getglobal(newDragBar:GetName().."Bar"):SetWidth(LVBM.Options.StatusBarSize.Width - LVBMStatusBars_Designs[LVBM.Options.StatusBarDesign].widthModifier);
	getglobal(newDragBar:GetName().."Bar"):SetStatusBarColor(LVBM.Options.StatusBarColor.r, LVBM.Options.StatusBarColor.g, LVBM.Options.StatusBarColor.b, LVBM.Options.StatusBarColor.a);
	getglobal(newDragBar:GetName().."BarText"):SetWidth(LVBM.Options.StatusBarSize.Width - LVBMStatusBars_Designs[LVBM.Options.StatusBarDesign].textWidthModifier);
	newDragBar:EnableMouse(true);
	newDragBar:SetMovable(true);
	newDragBar:SetFrameStrata("HIGH");
	for index, value in pairs(LVBMStatusBars_DragFrameFunctions) do
		newDragBar:SetScript(index, value);
	end
	
	LVBMStatusBars_DragFrameFunctions["OnLoad"](LVBM_StatusBarTimerDrag);
	if type(LVBMStatusBars_Designs[LVBM.Options.StatusBarDesign].initialize) == "function" then
		LVBMStatusBars_Designs[LVBM.Options.StatusBarDesign].initialize(LVBM_StatusBarTimerDrag);
	end	
	
	if not LVBM.Hooks.oldSetStatusBarColor then
		LVBM.Hooks.oldSetStatusBarColor = newDragBar.SetStatusBarColor;
	end
	if not LVBM.Hooks.oldSetMinMaxValues then
		LVBM.Hooks.oldSetMinMaxValues = newDragBar.SetMinMaxValues;
	end
	if not LVBM.Hooks.oldSetValue then
		LVBM.Hooks.oldSetValue = newDragBar.SetValue;
	end
		
	newDragBar.SetStatusBarColor = function(frame, r, g, b, a)
		if type(LVBMStatusBars_Designs[LVBM.Options.StatusBarDesign].onColorChanged) == "function" then
			LVBMStatusBars_Designs[LVBM.Options.StatusBarDesign].onColorChanged(frame, r, g, b, a);
		end
		LVBM.Hooks.oldSetStatusBarColor(frame, r, g, b, a);
	end
	
	newDragBar.SetMinMaxValues = function(frame, minValue, maxValue)
		if type(LVBMStatusBars_Designs[LVBM.Options.StatusBarDesign].onSetMinMaxValues) == "function" then
			LVBMStatusBars_Designs[LVBM.Options.StatusBarDesign].onSetMinMaxValues(frame, minValue, maxValue);
		end
		LVBM.Hooks.oldSetMinMaxValues(frame, minValue, maxValue);
	end
	
	newDragBar.SetValue = function(frame, value)
		if type(LVBMStatusBars_Designs[LVBM.Options.StatusBarDesign].onSetValue) == "function" then
			LVBMStatusBars_Designs[LVBM.Options.StatusBarDesign].onSetValue(frame, value);
		end
		LVBM.Hooks.oldSetValue(frame, value);
	end	
	
	newDragBar:SetPoint("CENTER", "LVBM_StatusBarTimerAnchor", "CENTER");
	
	
	for i = 1, oldBarCount do
		local minValue, maxValue = getglobal("LVBM_StatusBarTimer"..i.."Bar"):GetMinMaxValues();
		oldFrameSettings = {
			["isUsed"] = getglobal("LVBM_StatusBarTimer"..i).isUsed,
			["usedBy"] = getglobal("LVBM_StatusBarTimer"..i).usedBy,
			["syncedBy"] = getglobal("LVBM_StatusBarTimer"..i).syncedBy,
			["startedBy"] = getglobal("LVBM_StatusBarTimer"..i).startedBy,
			["isRepeating"] = getglobal("LVBM_StatusBarTimer"..i).isRepeating,
			["repetitions"] = getglobal("LVBM_StatusBarTimer"..i).repetitions,
			["specialColor"] = getglobal("LVBM_StatusBarTimer"..i).specialColor,
			["text"] = getglobal("LVBM_StatusBarTimer"..i.."BarText"):GetText(),
			["timerText"] = getglobal("LVBM_StatusBarTimer"..i.."BarTimer"):GetText(),
			["table"] = getglobal("LVBM_StatusBarTimer"..i).table,
			["minValue"] = minValue,
			["maxValue"] = maxValue,
			["value"] = getglobal("LVBM_StatusBarTimer"..i.."Bar"):GetValue(),
			["shown"] = getglobal("LVBM_StatusBarTimer"..i):IsShown(),
		};		

		for index, value in pairs(LVBMStatusBars_Designs[oldDesign].subFrameNames) do
			setglobal("LVBM_StatusBarTimer"..i..value, nil);
		end
		getglobal("LVBM_StatusBarTimer"..i):Hide(); --there is no way to delete frames! but a status bar only needs ~5-10kb memory, so a few old hidden bars are no problem :)
		setglobal("LVBM_StatusBarTimer"..i, nil); --wtf? i need to set the old variables to nil before I create a new frame...

		LVBMStatusBars_CreateNewBar();
		if getglobal("LVBM_StatusBarTimer"..i) then
			getglobal("LVBM_StatusBarTimer"..i).isUsed = oldFrameSettings.isUsed;
			getglobal("LVBM_StatusBarTimer"..i).usedBy = oldFrameSettings.usedBy;
			getglobal("LVBM_StatusBarTimer"..i).syncedBy = oldFrameSettings.syncedBy;
			getglobal("LVBM_StatusBarTimer"..i).startedBy = oldFrameSettings.startedBy;
			getglobal("LVBM_StatusBarTimer"..i).isRepeating = oldFrameSettings.isRepeating;
			getglobal("LVBM_StatusBarTimer"..i).repetitions = oldFrameSettings.repetitions;
			getglobal("LVBM_StatusBarTimer"..i).specialColor = oldFrameSettings.specialColor;
			getglobal("LVBM_StatusBarTimer"..i).table = oldFrameSettings.table;
			if getglobal("LVBM_StatusBarTimer"..i).table and getglobal("LVBM_StatusBarTimer"..i).table.frame then
				getglobal("LVBM_StatusBarTimer"..i).table.frame = getglobal("LVBM_StatusBarTimer"..i);
			end
			getglobal("LVBM_StatusBarTimer"..i.."BarText"):SetText(oldFrameSettings.text);
			getglobal("LVBM_StatusBarTimer"..i.."BarTimer"):SetText(oldFrameSettings.timerText);
			getglobal("LVBM_StatusBarTimer"..i.."Bar"):SetMinMaxValues(oldFrameSettings.minValue, oldFrameSettings.maxValue);
			getglobal("LVBM_StatusBarTimer"..i.."Bar"):SetValue(oldFrameSettings.value);
			if oldFrameSettings.shown then
				getglobal("LVBM_StatusBarTimer"..i):Show();
			end
		end
	end
end

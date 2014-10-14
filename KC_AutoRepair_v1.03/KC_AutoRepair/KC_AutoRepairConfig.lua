KC_AUTOREPAIRCONFIG = {}
local locals   = KC_AUTOREPAIR_LOCALS;

KC_AUTOREPAIRCONFIG.config = {
	name		= "KC_AutoRepairConfig",
	type		= ACEGUI_DIALOG,
	title		= locals.config.title,
	backdrop	= "small",
	isSpecial	= TRUE,
	width		= 328,
	height		= 185,
	OnShow		= "OnShow",
	elements	= {
		Frame	 = {
			type	 = ACEGUI_OPTIONSBOX,
			title	 = "",
			width	 = 296,
			height	 = 110,
			anchors	 = {
				topleft	= {xOffset = 16, yOffset = -31}
			},
			elements = {
				PromptCheck = {
					type     = ACEGUI_CHECKBOX,
					title    = locals.config.prompt,
					disabled = FALSE,
					OnClick	 = "TogPrompt",
					width	 = 26,
					height	 = 26,
					anchors	 = {
						topleft = { xOffset = 23, yOffset = -10, }
					},
					OnEnter  = "ShowPromptTip",
					OnLeave  = "HideTip",
				},
				SkipInvCheck = {
					type     = ACEGUI_CHECKBOX,
					title    = locals.config.skipinv,
					disabled = FALSE,
					OnClick	 = "TogSkipinv",
					width	 = 26,
					height	 = 26,
					anchors	 = {
						topleft = { relTo = "$parentPromptCheck", relPoint = "bottomleft", xOffset = 0, yOffset = -5 }
					},
					OnLeave  = "HideTip",
					OnEnter  = "ShowSkipInvTip",
				},
				VerboseCheck = {
					type     = ACEGUI_CHECKBOX,
					title    = locals.config.verbose,
					disabled = FALSE,
					OnClick	 = "TogVerbose",
					width	 = 26,
					height	 = 26,
					anchors	 = {
						topleft = { relTo = "$parentSkipInvCheck", relPoint = "bottomleft", xOffset = 0, yOffset = -5 }
					},
					OnEnter  = "ShowVerboseTip",
					OnLeave  = "HideTip",
				},
				MincostGold = {
					type     = ACEGUI_INPUTBOX,
					title    = locals.config.mincost,
					disabled = FALSE,
					width	 = 30,
					height	 = 26,
					anchors	 = {
						topleft = { relTo = "$parentPromptCheck", relPoint = "topright", xOffset = 75, yOffset = -15 }
					},
					OnEnter	 = "ShowGoldTip",
					OnLeave	 = "HideTip",
				},
				MincostSilver = {
					type     = ACEGUI_INPUTBOX,
					title    = "",
					disabled = FALSE,
					width	 = 30,
					height	 = 26,
					anchors	 = {
						topleft = { relTo = "$parentMincostGold", relPoint = "topright", xOffset = 2, yOffset = 0 }
					},
					OnEnter	 = "ShowSilverTip",
					OnLeave	 = "HideTip",
				},
				MincostCopper = {
					type     = ACEGUI_INPUTBOX,
					title    = "",
					disabled = FALSE,
					width	 = 30,
					height	 = 26,
					anchors	 = {
						topleft = { relTo = "$parentMincostSilver", relPoint = "topright", xOffset = 2, yOffset = 0 }
					},
					OnEnter	 = "ShowCopperTip",
					OnLeave	 = "HideTip",
				},
				MincostSet  = {
					type	 = ACEGUI_BUTTON,
					title	 = locals.config.set,
					width	 = 49,
					height	 = 20,
					anchors	 = {
						topleft = {relTo = "$parentMincostCopper", relPoint = "topright", xOffset = 2, yOffset = -3}
					},
					OnClick	 = "SetMincost",
					OnEnter	 = "ShowMincostSetTip",
					OnLeave	 = "HideTip",
				},
				ThresholdGold = {
					type     = ACEGUI_INPUTBOX,
					title    = locals.config.threshold,
					disabled = FALSE,
					width	 = 30,
					height	 = 26,
					anchors	 = {
						topleft = { relTo = "$parentMincostGold", relPoint = "bottomleft", xOffset = 0, yOffset = -15 }
					},
					OnEnter	 = "ShowGoldTip",
					OnLeave	 = "HideTip",
				},
				ThresholdSilver = {
					type     = ACEGUI_INPUTBOX,
					title    = "",
					disabled = FALSE,
					width	 = 30,
					height	 = 26,
					anchors	 = {
						topleft = { relTo = "$parentThresholdGold", relPoint = "topright", xOffset = 2, yOffset = 0 }
					},
					OnEnter	 = "ShowSilverTip",
					OnLeave	 = "HideTip",
				},
				ThresholdCopper = {
					type     = ACEGUI_INPUTBOX,
					title    = "",
					disabled = FALSE,
					width	 = 30,
					height	 = 26,
					anchors	 = {
						topleft = { relTo = "$parentThresholdSilver", relPoint = "topright", xOffset = 2, yOffset = 0 }
					},
					OnEnter	 = "ShowCopperTip",
					OnLeave	 = "HideTip",
				},
				ThresholdSet  = {
					type	 = ACEGUI_BUTTON,
					title	 = locals.config.set,
					width	 = 49,
					height	 = 20,
					anchors	 = {
						topleft = {relTo = "$parentThresholdCopper", relPoint = "topright", xOffset = 2, yOffset = -3}
					},
					OnClick	 = "SetThreshold",
					OnEnter	 = "ShowThresholdSetTip",
					OnLeave	 = "HideTip",
				},
			},
		},
	}
}

if (AceGUI) then
	KC_AUTOREPAIRCONFIG.frame = AceGUI:new();	
else
	KC_AUTOREPAIRCONFIG.frame = AceGUIDummy:new();
end


local frame = KC_AUTOREPAIRCONFIG.frame;

function frame:OnShow()
	self.Frame.PromptCheck:SetValue(self.app.Get(self.app, "prompt"))
	self.Frame.SkipInvCheck:SetValue(self.app.Get(self.app, "skipinv"))
	self.Frame.VerboseCheck:SetValue(self.app.Get(self.app, "verbose"))

	local mincost = self.app.Get(self.app, "mincost") or 0;
	self.Frame.MincostGold:SetValue(mod(floor(mincost/10000), 100));
	self.Frame.MincostSilver:SetValue(mod(floor(mincost/100), 100));
	self.Frame.MincostCopper:SetValue(mod(floor(mincost +.5), 100));

	local threshold = self.app.Get(self.app, "threshold") or 0;
	self.Frame.ThresholdGold:SetValue(mod(floor(threshold/10000), 100));
	self.Frame.ThresholdSilver:SetValue(mod(floor(threshold/100), 100));
	self.Frame.ThresholdCopper:SetValue(mod(floor(threshold +.5), 100));
end

function frame:TogPrompt()
	self.app:TogPrompt();
end

function frame:TogSkipinv()
	self.app:TogSkipinv();
end

function frame:TogVerbose()
	self.app:TogVerbose();
end

function frame:SetMincost()
	local gold	 = tonumber(self.Frame.MincostGold:GetValue()) or 0;
	local silver = tonumber(self.Frame.MincostSilver:GetValue()) or 0;
	local copper = tonumber(self.Frame.MincostCopper:GetValue()) or 0;
	local sum	 = (gold * 10000) + (silver * 100) + copper;
	
	self.app:SetMinCost(sum);
end

function frame:SetThreshold()
	local gold	 = tonumber(self.Frame.ThresholdGold:GetValue()) or 0;
	local silver = tonumber(self.Frame.ThresholdSilver:GetValue()) or 0;
	local copper = tonumber(self.Frame.ThresholdCopper:GetValue()) or 0;
	local sum	 = (gold * 10000) + (silver * 100) + copper;
	
	self.app:SetThreshold(sum);
end

function frame:HideTip()
	KCAutoRepairTip:Hide();
	KCAutoRepairTip:ClearLines();
end

function frame:ShowPromptTip()
	KCAutoRepairTip:SetOwner(this, "ANCHOR_RIGHT");
	KCAutoRepairTip:AddLine(locals.config.tips.prompt1);
	KCAutoRepairTip:AddLine(locals.config.tips.prompt2);
	KCAutoRepairTip:Show();
end

function frame:ShowSkipInvTip()
	KCAutoRepairTip:SetOwner(this, "ANCHOR_RIGHT");
	KCAutoRepairTip:AddLine(locals.config.tips.skipinv1);
	KCAutoRepairTip:AddLine(locals.config.tips.skipinv2);
	KCAutoRepairTip:Show();
end

function frame:ShowVerboseTip()
	KCAutoRepairTip:SetOwner(this, "ANCHOR_RIGHT");
	KCAutoRepairTip:AddLine(locals.config.tips.verbose1);
	KCAutoRepairTip:AddLine(locals.config.tips.verbose2);
	KCAutoRepairTip:Show();
end

function frame:ShowGoldTip()
	KCAutoRepairTip:SetOwner(this, "ANCHOR_TOPLEFT");
	KCAutoRepairTip:AddLine(locals.colors.gold);
	KCAutoRepairTip:Show();
end

function frame:ShowSilverTip()
	KCAutoRepairTip:SetOwner(this, "ANCHOR_TOPLEFT");
	KCAutoRepairTip:AddLine(locals.colors.silver);
	KCAutoRepairTip:Show();
end

function frame:ShowCopperTip()
	KCAutoRepairTip:SetOwner(this, "ANCHOR_TOPLEFT");
	KCAutoRepairTip:AddLine(locals.colors.copper);
	KCAutoRepairTip:Show();	
end

function frame:ShowThresholdSetTip()
	KCAutoRepairTip:SetOwner(this, "ANCHOR_RIGHT");
	KCAutoRepairTip:AddLine(locals.config.tips.threshold1);
	KCAutoRepairTip:AddLine(locals.config.tips.threshold2);
	KCAutoRepairTip:AddLine(locals.config.tips.threshold3);
	KCAutoRepairTip:Show();	
end

function frame:ShowMincostSetTip()
	KCAutoRepairTip:SetOwner(this, "ANCHOR_RIGHT");
	KCAutoRepairTip:AddLine(locals.config.tips.mincost1);
	KCAutoRepairTip:AddLine(locals.config.tips.mincost2);
	KCAutoRepairTip:AddLine(locals.config.tips.mincost3);
	KCAutoRepairTip:Show();	
end
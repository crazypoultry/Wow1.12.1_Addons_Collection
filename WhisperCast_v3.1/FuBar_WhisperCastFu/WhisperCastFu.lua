WhisperCastFu = AceLibrary("AceAddon-2.0"):new("AceConsole-2.0", "AceDB-2.0", "FuBarPlugin-2.0");
local L = AceLibrary("AceLocale-2.2"):new("WhisperCastFu");
local Metro = AceLibrary("Metrognome-2.0");
local Tablet = AceLibrary("Tablet-2.0");

local label = "";
local queuetext = "";

L:RegisterTranslations("enUS", function() return {
	["hideLabelName"] = "Hide Label",
	["hideLabelDescription"] = "Toggle the WhisperCast label on FuBar.",
	["hideTooltipName"] = "Hide Tooltip Hint",
	["hideTooltipDescription"] = "Toggle the tooltip that shows queue details.",
	["whisperCastOptions"] = "WhisperCast Options",
	["queueDetails"] = "Queue Details:",
	["noQueueableAbilities"] = "No queueable abilities.",
	["tabletHint"] = "Left-click to cast\nShift+Left-click to clear",
	["featureNotSupported"] = "This feature is not yet supported.",
} end);

WhisperCastFu:RegisterDB("WhisperCastFuDB");
WhisperCastFu:RegisterDefaults("profile", {
	hideLabel = false,
	hideHint = false,
});

WhisperCastFu.hasIcon = true;
WhisperCastFu.defaultPosition = "CENTER";

local optionsTable = {
	handler = WhisperCastFu,
	type = "group",
	args = {
		wc = {
			type = "group",
			name = L["whisperCastOptions"],
			desc = L["whisperCastOptions"],
			order = 1.0,
			args = {
				header = {
					type = "header",
					name = format(WCLocale.UI.text.whisperCastVersion, WhisperCast_Version),
					order = 1.0,
				},
				blank = {
					type = "header",
					order = 1.1,
				},
				enable = {
					type = "toggle",
					name = WCLocale.UI.text.dropdownEnable,
					desc = WCLocale.UI.text.dropdownEnable,
					order = 1.2,
					get = function() return WhisperCast_getChecked(WhisperCast_Profile.enable); end,
					set = "ToggleEnabled",
				},
				grouponly = {
					type = "toggle",
					name = WCLocale.UI.text.dropdownGroupOnly,
					desc = WCLocale.UI.text.dropdownGroupOnly,
					order = 1.3,
					get = function() return WhisperCast_getChecked(WhisperCast_Profile.grouponly); end,
					set = "ToggleGroupOnly",
				},
				restrictcombat = {
					type = "toggle",
					name = WCLocale.UI.text.dropdownCombatOnly,
					desc = WCLocale.UI.text.dropdownCombatOnly,
					order = 1.4,
					get = function() return not WhisperCast_getChecked(WhisperCast_Profile.restrictcombat); end,
					set = "ToggleRestrictCombat",
				},
				hidewhispers = {
					type = "toggle",
					name = WCLocale.UI.text.dropdownHideWhispers,
					desc = WCLocale.UI.text.dropdownHideWhispers,
					order = 1.5,
					get = function() return WhisperCast_getChecked(WhisperCast_Profile.hidewhispers); end,
					set = "ToggleHideWhispers",
				},
				feedbackwhisper = {
					type = "toggle",
					name = WCLocale.UI.text.dropdownFeedbackWhispers,
					desc = WCLocale.UI.text.dropdownFeedbackWhispers,
					order = 1.6,
					get = function() return WhisperCast_getChecked(WhisperCast_Profile.feedbackwhisper); end,
					set = "ToggleFeedbackWhispers",
				},
				blank = {
					type = "header",
					order = 1.7,
				},
				sound = {
					type = "group",
					name = WCLocale.UI.text.dropdownSoundSub,
					desc = WCLocale.UI.text.dropdownSoundSub,
					order = 1.8,
					args = {
						firstqueue = {
							type = "toggle",
							name = WCLocale.UI.text.dropdownSoundFirstQueue,
							desc = WCLocale.UI.text.dropdownSoundFirstQueue,
							order = 1.0,
							get = function() return WhisperCast_getChecked(WhisperCast_Profile.playsound.firstqueue); end,
							set = "ToggleSoundFirstQueue",
						},
						emptyqueue = {
							type = "toggle",
							name = WCLocale.UI.text.dropdownSoundQueueEmpty,
							desc = WCLocale.UI.text.dropdownSoundQueueEmpty,
							order = 1.1,
							get = function() return WhisperCast_getChecked(WhisperCast_Profile.playsound.emptyqueue); end,
							set = "ToggleSoundQueueEmpty",
						},
					},
				},
				matching = {
					type = "group",
					name = WCLocale.UI.text.dropdownMatchingSub,
					desc = WCLocale.UI.text.dropdownMatchingSub,
					order = 1.9,
					args = {
						exact = {
							type = "toggle",
							name = WCLocale.UI.text.dropdownMatchingExact,
							desc = WCLocale.UI.text.dropdownMatchingExact,
							order = 1.0,
							get = function() return (WhisperCast_Profile.match == "exact"); end,
							set = "ToggleMatchingExact",
						},
						start = {
							type = "toggle",
							name = WCLocale.UI.text.dropdownMatchingStart,
							desc = WCLocale.UI.text.dropdownMatchingStart,
							order = 1.1,
							get = function() return (WhisperCast_Profile.match == "start"); end,
							set = "ToggleMatchingStart",
						},
						any = {
							type = "toggle",
							name = WCLocale.UI.text.dropdownMatchingAny,
							desc = WCLocale.UI.text.dropdownMatchingAny,
							order = 1.2,
							get = function() return (WhisperCast_Profile.match == "any"); end,
							set = "ToggleMatchingAny",
						},
					},
				},
				disabled = {
					type = "group",
					name = WCLocale.UI.text.dropdownDisabledSub,
					desc = WCLocale.UI.text.dropdownDisabledSub,
					order = 2.0,
					args = {
						header = {
							type = "header",
							name = L["featureNotSupported"],
							order = 1.0,
						},
					},
				},
			},
		},
		blank = {
			type = "header",
			order = 1.1,
		},
		hideLabel = {
			type = "toggle",
			name = L["hideLabelName"],
			desc = L["hideLabelDescription"],
			order = 1.2,
			get = "IsHideLabel",
			set = "ToggleHideLabel",
		},
		hideHint = {
			type = "toggle",
			name = L["hideTooltipName"],
			desc = L["hideTooltipDescription"],
			order = 1.3,
			get = "IsHideHint",
			set = "ToggleHideHint",
		},
	},
};

WhisperCastFu:RegisterChatCommand({ "/whispercastfu" }, optionsTable);
WhisperCastFu.OnMenuRequest = optionsTable;

function WhisperCastFu:IsHideLabel()
	return self.db.profile.hideLabel;
end

function WhisperCastFu:ToggleHideLabel()
	self.db.profile.hideLabel = not self.db.profile.hideLabel;
	self:Update();
end

function WhisperCastFu:IsHideHint()
	return self.db.profile.hideHint;
end

function WhisperCastFu:ToggleHideHint()
	self.db.profile.hideHint = not self.db.profile.hideHint;
	self:Update();
end

function WhisperCastFu:OnEnable()
	Metro:Register(self.name, self.Update, 1, self);
	Metro:Start(self.name);
end

function WhisperCastFu:OnDisable()
	Metro:Unregister(self.name);
end

function WhisperCastFu:ToggleEnabled()
	WhisperCast_ToggleEnabled();
end

function WhisperCastFu:ToggleGroupOnly()
	WhisperCast_ToggleProfileKey("grouponly");
end

function WhisperCastFu:ToggleRestrictCombat()
	WhisperCast_ToggleRestrictCombat();
end

function WhisperCastFu:ToggleHideWhispers()
	WhisperCast_ToggleProfileKey("hidewhispers");
end

function WhisperCastFu:ToggleFeedbackWhispers()
	WhisperCast_ToggleProfileKey("feedbackwhisper");
end

function WhisperCastFu:ToggleSoundFirstQueue()
	WhisperCast_ToggleProfileKey({"playsound","firstqueue"});
end

function WhisperCastFu:ToggleSoundQueueEmpty()
	WhisperCast_ToggleProfileKey({"playsound","emptyqueue"});
end

function WhisperCastFu:ToggleMatchingExact()
	WhisperCast_SetMatch("exact");
end

function WhisperCastFu:ToggleMatchingStart()
	WhisperCast_SetMatch("start");
end

function WhisperCastFu:ToggleMatchingAny()
	WhisperCast_SetMatch("any");
end

function WhisperCastFu:OnTextUpdate()
	if (WhisperCast_Spells) then
		queuetext = "|cffffffff"..WhisperCast_Runtime.queueBrief.."|r";
	else
		queuetext = "|cffffffff"..WCLocale.UI.text.queueBriefUnavailable.."|r";
	end

	if (self:IsHideLabel()) then
		label = "";
		queuetext = " "..queuetext;
	else
		label = WCLocale.UI.text.whisperCast..": ";
	end

	self:SetText(label..queuetext);
end

function WhisperCastFu:OnTooltipUpdate()
	if (WhisperCast_Spells) then
		local cat = Tablet:AddCategory(
			"text", L["queueDetails"],
			"columns", 1,
			"child_textR", 1,
			"child_textG", 1,
			"child_textB", 0
		);

		if (WhisperCast_Runtime.queueLength == 0) then
			cat:AddLine(
				"text", WCLocale.UI.text.queueBriefEmpty
			);
		else
			cat:AddLine(
				"text", WhisperCast_Runtime.queueDetail
			);
		end
	else
		local cat = Tablet:AddCategory(
			"text", L["noQueueableAbilities"],
			"columns", 1,
			"child_textR", 1,
			"child_textG", 1,
			"child_textB", 0
		);

		cat:AddLine("text", "");
	end

	if (not self:IsHideHint()) then
		Tablet:SetHint(L["tabletHint"]);
	end
end

function WhisperCastFu:OnClick()
	if (IsShiftKeyDown()) then
		WhisperCast_Clear();
	else
		WhisperCast_Cast();
	end
end
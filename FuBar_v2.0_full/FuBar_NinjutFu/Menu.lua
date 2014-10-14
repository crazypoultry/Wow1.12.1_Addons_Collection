local L = AceLibrary("AceLocale-2.2"):new("NinjutFu")

function NinjutFu:MenuRow(poison, hand, ordernr)
	local description
	description = format(L["Apply %s to "..hand], poison)
	execfunc = function() NinjutFu:ApplyPoison(poison, ((hand == "MH") and 16 or 17)) end
	hiddenfunc = function() return (NinjutFu.itemCounts[poison] <= 0) end

	return {type = "execute", name = poison, desc = description, func = execfunc, hidden = hiddenfunc, order = ordernr}
end

-- using an AceOptions data table
NinjutFu.OnMenuRequest = {type = "group", args = {
applymh = {type = "group", name = L["Apply to MH"], desc = L["Apply to MH"], order = 1, args = {
	cp1 = NinjutFu:MenuRow(L["Crippling Poison"], "MH", 10),
	cp2 = NinjutFu:MenuRow(L["Crippling Poison II"], "MH", 11),
	dp4 = NinjutFu:MenuRow(L["Deadly Poison IV"], "MH", 23),
	dp5 = NinjutFu:MenuRow(L["Deadly Poison V"], "MH", 24),
	ip6 = NinjutFu:MenuRow(L["Instant Poison VI"], "MH", 35),
	mp3 = NinjutFu:MenuRow(L["Mind-numbing Poison III"], "MH", 42),
	wp4 = NinjutFu:MenuRow(L["Wound Poison IV"], "MH", 53),
	space = {type="header", order = 53},
	ss5 = NinjutFu:MenuRow(L["Dense Sharpening Stone"], "MH", 74),
	ssc = NinjutFu:MenuRow(L["Consecrated Sharpening Stone"], "MH", 75),
	sse = NinjutFu:MenuRow(L["Elemental Sharpening Stone"], "MH", 76),
	ws5 = NinjutFu:MenuRow(L["Dense Weightstone"], "MH", 84),
}},
applyoh = {type = "group", name = L["Apply to OH"], desc = L["Apply to OH"], order = 2, args = {
	cp1 = NinjutFu:MenuRow(L["Crippling Poison"], "OH", 10),
	cp2 = NinjutFu:MenuRow(L["Crippling Poison II"], "OH", 11),
	dp4 = NinjutFu:MenuRow(L["Deadly Poison IV"], "OH", 23),
	dp5 = NinjutFu:MenuRow(L["Deadly Poison V"], "OH", 24),
	ip6 = NinjutFu:MenuRow(L["Instant Poison VI"], "OH", 35),
	mp3 = NinjutFu:MenuRow(L["Mind-numbing Poison III"], "OH", 42),
	wp4 = NinjutFu:MenuRow(L["Wound Poison IV"], "OH", 53),
	space = {type="header", order = 53},
	ss5 = NinjutFu:MenuRow(L["Dense Sharpening Stone"], "OH", 74),
	ssc = NinjutFu:MenuRow(L["Consecrated Sharpening Stone"], "OH", 75),
	sse = NinjutFu:MenuRow(L["Elemental Sharpening Stone"], "OH", 76),
	ws5 = NinjutFu:MenuRow(L["Dense Weightstone"], "OH", 84),
}},
space1 = {type = "header", order = 3},
options = {type = "group", name = L["Options"], desc = L["OptionsDesc"], order = 10, args = {
	buyFlash = {
		type = "toggle",
		name = L["buyFlash"],
		desc = L["buyFlashDesc"],
		get = function() return NinjutFu.db.profile.buyFlash end,
		set = function() NinjutFu.db.profile.buyFlash = not NinjutFu.db.profile.buyFlash end,
		order = 1,
	},
	threshCount = {
		type = "range",
		name = L["threshCount"],
		desc = L["threshCountDesc"],
		get = function() return NinjutFu.db.profile.threshCount end,
		set = function(v) NinjutFu.db.profile.threshCount = v end,
		min = 0,
		max = 100,
		step = 20,
		order = 2,
	},
	highend = {
		type = "toggle",
		name = L["highend"],
		desc = L["highendDesc"],
		get = function() return NinjutFu.db.profile.highend end,
		set = function() NinjutFu.db.profile.highend = not NinjutFu.db.profile.highend; NinjutFu:SetHighend(); NinjutFu:SetHighendMenu() end,
		order = 10,
	},
}},
barDisplay = {type = "group", name = L["Text Options"], desc = L["TextOptsDesc"], args = {
	showFlash = {
		type = "toggle",
		name = L["Show Flash Powder"],
		desc = L["ShowFlashDesc"],
		order = 1,
		get = function() return NinjutFu.db.profile.showFlash end,
		set = function()  NinjutFu.db.profile.showFlash = not NinjutFu.db.profile.showFlash; NinjutFu:UpdateText() end,
	},
	showBlind = {
		type = "toggle",
		name = L["Show Blinding Powder"],
		desc = L["ShowBlindDesc"],
		order = 2,
		get = function() return NinjutFu.db.profile.showBlind end,
		set = function()  NinjutFu.db.profile.showBlind = not NinjutFu.db.profile.showBlind; NinjutFu:UpdateText() end,
	},
	showTea = {
		type = "toggle",
		name = L["Show Thistle Tea"],
		desc = L["ShowTeaDesc"],
		order = 3,
		get = function() return NinjutFu.db.profile.showTea end,
		set = function()  NinjutFu.db.profile.showTea = not NinjutFu.db.profile.showTea; NinjutFu:UpdateText() end,
	},
	compactMode = {
		type = "toggle",
		name = L["Compact Mode"],
		desc = L["CompactModeDesc"],
		order = 4,
		get = function() return NinjutFu.db.profile.compactMode end,
		set = function()  NinjutFu.db.profile.compactMode = not NinjutFu.db.profile.compactMode; NinjutFu:UpdateText() end,
	}
}},
ttDisplay = {type = "group", name = L["Tooltip Options"], desc = L["TooltipOptsDesc"], args = {
	showTipTitles = {
		type = "toggle",
		name = L["Show Titles"],
		desc = L["ShowTitlesDesc"],
		order = 1,
		get = function() return NinjutFu.db.profile.showTipTitles end,
		set = function()  NinjutFu.db.profile.showTipTitles = not NinjutFu.db.profile.showTipTitles; NinjutFu:UpdateTooltip() end,
	},
	showTipPowders = {
		type = "toggle",
		name = L["Show Powders"],
		desc = L["ShowPowdersDesc"],
		order = 2,
		get = function() return NinjutFu.db.profile.showTipPowders end,
		set = function()  NinjutFu.db.profile.showTipPowders = not NinjutFu.db.profile.showTipPowders; NinjutFu:UpdateTooltip() end,
	},
	showTipTea = {
		type = "toggle",
		name = L["Show Thistle Tea"],
		desc = L["ShowPoisonsDesc"],
		order = 3,
		get = function() return NinjutFu.db.profile.showTipTea end,
		set = function()  NinjutFu.db.profile.showTipTea = not NinjutFu.db.profile.showTipTea; NinjutFu:UpdateTooltip() end,
	},
	showTipPoisons = {
		type = "toggle",
		name = L["Show Poisons"],
		desc = L["ShowPoisonsDesc"],
		order = 4,
		get = function() return NinjutFu.db.profile.showTipPoisons end,
		set = function()  NinjutFu.db.profile.showTipPoisons = not NinjutFu.db.profile.showTipPoisons; NinjutFu:UpdateTooltip() end,
	},
}},
}}

function NinjutFu:SetHighendMenu()
	if (self.db.profile.highend) then
		NinjutFu.OnMenuRequest.args.applymh.args.dp1 = nil
		NinjutFu.OnMenuRequest.args.applymh.args.dp2 = nil
		NinjutFu.OnMenuRequest.args.applymh.args.dp3 = nil
		NinjutFu.OnMenuRequest.args.applymh.args.ip1 = nil
		NinjutFu.OnMenuRequest.args.applymh.args.ip2 = nil
		NinjutFu.OnMenuRequest.args.applymh.args.ip3 = nil
		NinjutFu.OnMenuRequest.args.applymh.args.ip4 = nil
		NinjutFu.OnMenuRequest.args.applymh.args.ip5 = nil
		NinjutFu.OnMenuRequest.args.applymh.args.mp1 = nil
		NinjutFu.OnMenuRequest.args.applymh.args.mp2 = nil
		NinjutFu.OnMenuRequest.args.applymh.args.wp1 = nil
		NinjutFu.OnMenuRequest.args.applymh.args.wp2 = nil
		NinjutFu.OnMenuRequest.args.applymh.args.wp3 = nil
		NinjutFu.OnMenuRequest.args.applymh.args.ss1 = nil
		NinjutFu.OnMenuRequest.args.applymh.args.ss2 = nil
		NinjutFu.OnMenuRequest.args.applymh.args.ss3 = nil
		NinjutFu.OnMenuRequest.args.applymh.args.ss4 = nil
		NinjutFu.OnMenuRequest.args.applymh.args.ws1 = nil
		NinjutFu.OnMenuRequest.args.applymh.args.ws2 = nil
		NinjutFu.OnMenuRequest.args.applymh.args.ws3 = nil
		NinjutFu.OnMenuRequest.args.applymh.args.ws4 = nil

		NinjutFu.OnMenuRequest.args.applyoh.args.dp1 = nil
		NinjutFu.OnMenuRequest.args.applyoh.args.dp2 = nil
		NinjutFu.OnMenuRequest.args.applyoh.args.dp3 = nil
		NinjutFu.OnMenuRequest.args.applyoh.args.ip1 = nil
		NinjutFu.OnMenuRequest.args.applyoh.args.ip2 = nil
		NinjutFu.OnMenuRequest.args.applyoh.args.ip3 = nil
		NinjutFu.OnMenuRequest.args.applyoh.args.ip4 = nil
		NinjutFu.OnMenuRequest.args.applyoh.args.ip5 = nil
		NinjutFu.OnMenuRequest.args.applyoh.args.mp1 = nil
		NinjutFu.OnMenuRequest.args.applyoh.args.mp2 = nil
		NinjutFu.OnMenuRequest.args.applyoh.args.wp1 = nil
		NinjutFu.OnMenuRequest.args.applyoh.args.wp2 = nil
		NinjutFu.OnMenuRequest.args.applyoh.args.wp3 = nil
		NinjutFu.OnMenuRequest.args.applyoh.args.ss1 = nil
		NinjutFu.OnMenuRequest.args.applyoh.args.ss2 = nil
		NinjutFu.OnMenuRequest.args.applyoh.args.ss3 = nil
		NinjutFu.OnMenuRequest.args.applyoh.args.ss4 = nil
		NinjutFu.OnMenuRequest.args.applyoh.args.ws1 = nil
		NinjutFu.OnMenuRequest.args.applyoh.args.ws2 = nil
		NinjutFu.OnMenuRequest.args.applyoh.args.ws3 = nil
		NinjutFu.OnMenuRequest.args.applyoh.args.ws4 = nil
	else
		NinjutFu.OnMenuRequest.args.applymh.args.dp1 = NinjutFu:MenuRow(L["Deadly Poison"], "MH", 20)
		NinjutFu.OnMenuRequest.args.applymh.args.dp2 = NinjutFu:MenuRow(L["Deadly Poison II"], "MH", 21)
		NinjutFu.OnMenuRequest.args.applymh.args.dp3 = NinjutFu:MenuRow(L["Deadly Poison III"], "MH", 22)
		NinjutFu.OnMenuRequest.args.applymh.args.ip1 = NinjutFu:MenuRow(L["Instant Poison"], "MH", 30)
		NinjutFu.OnMenuRequest.args.applymh.args.ip2 = NinjutFu:MenuRow(L["Instant Poison II"], "MH", 31)
		NinjutFu.OnMenuRequest.args.applymh.args.ip3 = NinjutFu:MenuRow(L["Instant Poison III"], "MH", 32)
		NinjutFu.OnMenuRequest.args.applymh.args.ip4 = NinjutFu:MenuRow(L["Instant Poison IV"], "MH", 33)
		NinjutFu.OnMenuRequest.args.applymh.args.ip5 = NinjutFu:MenuRow(L["Instant Poison V"], "MH", 34)
		NinjutFu.OnMenuRequest.args.applymh.args.mp1 = NinjutFu:MenuRow(L["Mind-numbing Poison"], "MH", 40)
		NinjutFu.OnMenuRequest.args.applymh.args.mp2 = NinjutFu:MenuRow(L["Mind-numbing Poison II"], "MH", 41)
		NinjutFu.OnMenuRequest.args.applymh.args.wp1 = NinjutFu:MenuRow(L["Wound Poison"], "MH", 50)
		NinjutFu.OnMenuRequest.args.applymh.args.wp2 = NinjutFu:MenuRow(L["Wound Poison II"], "MH", 51)
		NinjutFu.OnMenuRequest.args.applymh.args.wp3 = NinjutFu:MenuRow(L["Wound Poison III"], "MH", 52)
		NinjutFu.OnMenuRequest.args.applymh.args.ss1 = NinjutFu:MenuRow(L["Rough Sharpening Stone"], "MH", 70)
		NinjutFu.OnMenuRequest.args.applymh.args.ss2 = NinjutFu:MenuRow(L["Coarse Sharpening Stone"], "MH", 71)
		NinjutFu.OnMenuRequest.args.applymh.args.ss3 = NinjutFu:MenuRow(L["Heavy Sharpening Stone"], "MH", 72)
		NinjutFu.OnMenuRequest.args.applymh.args.ss4 = NinjutFu:MenuRow(L["Solid Sharpening Stone"], "MH", 73)
		NinjutFu.OnMenuRequest.args.applymh.args.ws1 = NinjutFu:MenuRow(L["Rough Weightstone"], "MH", 80)
		NinjutFu.OnMenuRequest.args.applymh.args.ws2 = NinjutFu:MenuRow(L["Coarse Weightstone"], "MH", 81)
		NinjutFu.OnMenuRequest.args.applymh.args.ws3 = NinjutFu:MenuRow(L["Heavy Weightstone"], "MH", 82)
		NinjutFu.OnMenuRequest.args.applymh.args.ws4 = NinjutFu:MenuRow(L["Solid Weightstone"], "MH", 83)

		NinjutFu.OnMenuRequest.args.applyoh.args.dp1 = NinjutFu:MenuRow(L["Deadly Poison"], "OH", 20)
		NinjutFu.OnMenuRequest.args.applyoh.args.dp2 = NinjutFu:MenuRow(L["Deadly Poison II"], "OH", 21)
		NinjutFu.OnMenuRequest.args.applyoh.args.dp3 = NinjutFu:MenuRow(L["Deadly Poison III"], "OH", 22)
		NinjutFu.OnMenuRequest.args.applyoh.args.ip1 = NinjutFu:MenuRow(L["Instant Poison"], "OH", 30)
		NinjutFu.OnMenuRequest.args.applyoh.args.ip2 = NinjutFu:MenuRow(L["Instant Poison II"], "OH", 31)
		NinjutFu.OnMenuRequest.args.applyoh.args.ip3 = NinjutFu:MenuRow(L["Instant Poison III"], "OH", 32)
		NinjutFu.OnMenuRequest.args.applyoh.args.ip4 = NinjutFu:MenuRow(L["Instant Poison IV"], "OH", 33)
		NinjutFu.OnMenuRequest.args.applyoh.args.ip5 = NinjutFu:MenuRow(L["Instant Poison V"], "OH", 34)
		NinjutFu.OnMenuRequest.args.applyoh.args.mp1 = NinjutFu:MenuRow(L["Mind-numbing Poison"], "OH", 40)
		NinjutFu.OnMenuRequest.args.applyoh.args.mp2 = NinjutFu:MenuRow(L["Mind-numbing Poison II"], "OH", 41)
		NinjutFu.OnMenuRequest.args.applyoh.args.wp1 = NinjutFu:MenuRow(L["Wound Poison"], "OH", 50)
		NinjutFu.OnMenuRequest.args.applyoh.args.wp2 = NinjutFu:MenuRow(L["Wound Poison II"], "OH", 51)
		NinjutFu.OnMenuRequest.args.applyoh.args.wp3 = NinjutFu:MenuRow(L["Wound Poison III"], "OH", 52)
		NinjutFu.OnMenuRequest.args.applyoh.args.ss1 = NinjutFu:MenuRow(L["Rough Sharpening Stone"], "OH", 70)
		NinjutFu.OnMenuRequest.args.applyoh.args.ss2 = NinjutFu:MenuRow(L["Coarse Sharpening Stone"], "OH", 71)
		NinjutFu.OnMenuRequest.args.applyoh.args.ss3 = NinjutFu:MenuRow(L["Heavy Sharpening Stone"], "OH", 72)
		NinjutFu.OnMenuRequest.args.applyoh.args.ss4 = NinjutFu:MenuRow(L["Solid Sharpening Stone"], "OH", 73)
		NinjutFu.OnMenuRequest.args.applyoh.args.ws1 = NinjutFu:MenuRow(L["Rough Weightstone"], "OH", 80)
		NinjutFu.OnMenuRequest.args.applyoh.args.ws2 = NinjutFu:MenuRow(L["Coarse Weightstone"], "OH", 81)
		NinjutFu.OnMenuRequest.args.applyoh.args.ws3 = NinjutFu:MenuRow(L["Heavy Weightstone"], "OH", 82)
		NinjutFu.OnMenuRequest.args.applyoh.args.ws4 = NinjutFu:MenuRow(L["Solid Weightstone"], "OH", 83)
	end
end
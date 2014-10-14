local L = AceLibrary("AceLocale-2.2"):new("Bartender")

Bartender.options = {
	type = "group",
	args = {
		lock = {
			order = 1,
			name = L["Lock"], type = "toggle",
			desc = L["Toggle locking of the bars."],
			get = function() return not Bartender.unlock end,
			set = function(v)
				if Bartender.unlock then
					Bartender:Lock()
				else
					Bartender:Move()
				end
			end,
		},
		borders = {
			order = 2,
			name = L["Borders"], type = "toggle",
			desc = L["Toggle borders of the bars."],
			get = function() return not Bartender.db.profile.Extra.HideBorder end,
			set = function(v)
				Bartender:ToggleBorder()
			end,
		},
		resetall = {
			order = 7,
			name = L["Reset current Profile"], 
			type = "execute",
			desc = L["*WARNING* Reset ALL Bars to default with this Profile"],
			func = function() 
				StaticPopup_Show("BARTENDER2CONFIRM")
			end,
		},
		enableallbars = {
			order = 4,
			name = L["Keep bars enabled at login"], type = "toggle",
			desc = L["Toggle enabling all actionbars on/off at login"],
			get = function() return Bartender.db.profile.Extra.EnableAllBars end,
			set = function(val)
				Bartender.db.profile.Extra.EnableAllBars = val
			end,
		},
		clamp = {
			order = 5,
			name = L["Keep bars on screen"], type = "toggle",
			desc = L["Keep all the actionbars in the visible area."],
			get = function() return Bartender.db.profile.Extra.Clamp end,
			set = function(v)
				Bartender:ToggleStayOnScreen()
			end,
		},
		sticky = {
			order = 6,
			name = L["Sticky Frames"], type = "toggle",
			desc = L["Enable Sticky Frames when Moving."],
			get = function() return Bartender.db.profile.Extra.StickyFrames end,
			set = function(v)
				Bartender.db.profile.Extra.StickyFrames = v
			end,
		},
		stanceswap = {
			order = 3,
			name = L["Allow Bar1 Stanceswap"], type = "toggle",
			desc = L["Toggle the Bar1 stanceswap (Stance/Stealth/Shapeshift) on/off"],
			get = function() return not Bartender.db.profile.Extra.BonusNoSwap end,
			set = function(v)
				Bartender.db.profile.Extra.BonusNoSwap = not v
				Bartender:UPDATE_BONUS_ACTIONBAR()
			end,
		},
		hidetooltip = {
			order = 3,
			name = L["Hide Tooltip"], type = "toggle",
			desc = L["Toggle the display of the Tooltips"],
			get = function() return Bartender.db.profile.Extra.HideTooltip end,
			set = function(v)
				Bartender.db.profile.Extra.HideTooltip =  v
			end,
		},
		spacer = { type = "header", order = 8, },
	},
}

local order = 9
local _G = getfenv(0)
local opt = nil

for i = 1, 9 do
	local bar = getglobal("Bar"..i)
	local barName = "Bar"..i
	order = order + 1
	Bartender.options.args["Bar"..i] = {}
	opt = Bartender.options.args["Bar"..i]

	opt.type = "group"
	opt.order = order
	opt.name = L["Bar"..i]
	opt.desc = L["Bar"..i.." options."]
	opt.args = {}

	opt.args.show = {
		type = "toggle",
		name = L["Show"],
		desc = L["Toggle bar shown."],
		get = function() return not Bartender.db.profile[barName].Hide end,
		set = function(v)
			Bartender:ToggleBar(barName)
		end,
	}
	opt.args.swap = {
		type = "toggle",
		name = L["Swap"],
		desc = L["Swap bar horizontally/vertically."],
		get = function() return Bartender.db.profile[barName].Swap end,
	}
	opt.args.scale = {
		type = "range",
		name = L["Scale"],
		desc = L["Scale of the bar."],
		min = .1, max = 5, step = 0.05,
		isPercent = true,
		get = function() return Bartender.db.profile[barName].Scale or 1 end,
		set = function(s)
			Bartender:Scale(barName, s)
		end,
	}
	opt.args.alpha = {
		name = L["Alpha"], type = "range",
		desc = L["Alpha of the bar."],
		min = .1, max = 1,
		get = function() return Bartender.db.profile[barName].Alpha or 1 end,
		set = function(a)
			Bartender:Alpha(barName, a)
		end,
	}
	opt.args.padding = {
		name = L["Padding"], type = "range",
		desc = L["Padding of the bar."],
		min = -10, max = 30, step = 1,
		get = function() return Bartender.db.profile[barName].Padding or -1 end,
		set = function(p)
			Bartender:Padding(barName, p)
		end,
	}
	if i < 6 then
		opt.args.swap.set = function(v)
			if v then
				Bartender.db.profile[barName].Rows = 12
				Bartender:Rows(barName, 12)
			else
				Bartender.db.profile[barName].Rows = 1
				Bartender:Rows(barName, 1)
			end
			Bartender.db.profile[barName].Swap = v
		end
		opt.args.rows = {
			type = "range",
			name = L["Rows"],
			desc = L["Change the rows of the Bar"],
			max = 12, min = 1, step = 1,
			get = function() return Bartender.db.profile[barName].Rows end,
			set = function(v)
				Bartender.db.profile[barName].Swap = (v == 12)
				Bartender:Rows(barName, v)
			end,
		}
		opt.args.hotkey = {
			name = L["Hotkey"], type = "toggle",
			desc = L["Toggle the bar HotKey on/off"],
			get = function() return not Bartender.db.profile[barName].HideHotKey end,
			set = function(v)
				Bartender:ToggleHK(barName)
			end,
		}
	else
		opt.args.swap.set = function(v)
			Bartender:ToggleSwap(barName)
		end
	end
end

Bartender:RegisterChatCommand({ "/bar", "/bartender" }, Bartender.options )


--[[--------------------------------------------------------------------------------
HostelBar -  Main File
Version: 1.$Revision: 11604 $
Author: Sole
Credits: Ammo for CandyBar :) and the folks in the Ace community
----------------------------------------------------------------------------------]]
--[[--------------------------------------------------------------------------------
TODO: 
-----------------------------------------------------------------------------------]]
local defaults = {
	-- general opts
	TargetOnly = true, -- only show bars relating to your target
	Grouped = true, -- whether the bars are grouped seperately or not
	StopOnDeath = true, -- stop all bars on player death
	StopOnHDeath = true, -- when a hostile player/mob dies, stop all bars from that player/mob
	InterruptTime = true, -- when you interrupt a spell, show the duration of how long the player cannot cast spells from that school
	DRTimers = true, -- diminishing returns timers
	SelfDurations = true, -- only track your own durations or everyone's
	NoName = false, -- whether names are displayer in the timer text
	LongCD = true, -- whether long cooldowns are displayed (if a spell's cd value is over 180 sec)
	BgAlpha = 1.0, -- background opacity of the bars, ranges from 0.0 to 1.0 

	events = { -- registered events 
		hostile = true,
		player = true,
		friendly = true,
		mob = true, 
	},
	
	enabled = { -- whether bars will show
		Default		= true,
		Casts		= true,
		Cooldowns	= true,
		Buffs		= true,
		Durations	= true,
	},
	bargrowth = { -- direction the bars will grow in,  true = up, false = down
		Default		= false,
		Casts		= false,
		Cooldowns	= false,
		Buffs		= false,
		Durations	= false,
	},
	titles = { -- whether titles will be shown
		Default		= true,
		Casts		= true,
		Cooldowns	= true,
		Buffs		= true,
		Durations	= true,
	},
	barcolor = { -- possible values: type, class, school
		Casts		= "type",
		Cooldowns	= "type",
		Buffs		= "type",
		Durations	= "type",
	},
	bgcolor = { -- possible values: type, class, school
		Casts		= "class",
		Cooldowns	= "class",
		Buffs		= "class",
		Durations	= "class",
	},
	textcolor = { -- possible values: type, class, school, white
		Casts		= "white",
		Cooldowns	= "white",
		Buffs		= "white",
		Durations	= "white",
	},
	barscale = { -- size of the bars, ranges from 0.5 to 1.5
		Default		= 1.0,
		Casts		= 1.0,
		Cooldowns	= 1.0,
		Buffs		= 1.0,
		Durations	= 1.0,
	},
	texture = { -- texture of a bar
		Casts		= "1",
		Cooldowns	= "1",
		Buffs		= "1",
		Durations	= "1",
	},
	reversed = { -- whether the bar fills or depletes
		Casts		= false,
		Cooldowns	= false,
		Buffs		= false,
		Durations	= false,
	},
	positions = { -- used for anchor
		Default		= {},
		Casts		= {},
		Cooldowns	= {},
		Buffs		= {},
		Durations	= {},
	},
}
--[[--------------------------------------------------------------------------------
  Class Setup
-----------------------------------------------------------------------------------]]
HostelBar = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceDB-2.0", "AceConsole-2.0", "AceDebug-2.0", "CandyBar-2.0")
-- embedded libs
local parser = ParserLib:GetInstance("1.1")
local L = AceLibrary("AceLocale-2.0"):new("HostelBar")
local BS = AceLibrary("Babble-Spell-2.0")
local compost = AceLibrary("Compost-2.0")
local candy = AceLibrary("CandyBar-2.0")
local paint = AceLibrary("PaintChips-2.0")

function HostelBar:OnInitialize()
	-- set chat commands 
	local args = {
	type = "group",
	args = {
		to = {
			name = L["Target Only"],desc = L["DescTargetOnly"],type = "toggle",
			get = function () return self.db.profile.TargetOnly end,
			set = function (v) self.db.profile.TargetOnly = v end,
		},
		grouped = {
			name = L["Grouped"],desc = L["DescGrouped"],type = "toggle",
			get = function () return self.db.profile.Grouped end,
			set = function (v) self.db.profile.Grouped = v	end,
		},
		sod = {
			name = L["Stop On Death"],desc = L["DescStopOnDeath"],type = "toggle",
			get = function () return self.db.profile.StopOnDeath end,
			set = function (v) self.db.profile.StopOnDeath = v	self:RefreshRegisteredEvents() end,
		},
		shd = {
			name = L["Stop On Hostile Death"], desc = L["DescStopOnHostileDeath"], type = "toggle",
			get = function () return self.db.profile.StopOnHDeath end,
			set = function (v) self.db.profile.StopOnHDeath = v	self:RefreshRegisteredEvents() end,
		},
		it = {
			name = L["Interrupt Time"], desc = L["DescInterruptTime"], type = "toggle",
			get = function () return self.db.profile.InterruptTime end,
			set = function (v) self.db.profile.InterruptTime = v end,
		},
		dr = {
			name = L["Diminishing Returns"], desc = L["DescDiminishingReturns"], type = "toggle",
			get = function () return self.db.profile.DRTimers end,
			set = function (v) self.db.profile.DRTimers = v end,
		},
		sd = {
			name = L["Self Durations"], desc = L["DescSelfDurations"], type = "toggle",
			get = function () return self.db.profile.SelfDurations end,
			set = function (v) self.db.profile.SelfDurations = v end,
		},
		nn = {
			name = L["No Name"], desc = L["DescNoName"], type = "toggle",
			get = function () return self.db.profile.NoName end,
			set = function (v) self.db.profile.NoName = v end,
		},
		lcd = {
			name = L["Long CD"], desc = L["DescLongCD"], type = "toggle",
			get = function () return self.db.profile.LongCD end,
			set = function (v) self.db.profile.LongCD = v end,
		},
		bgalpha = {
			name = L["Background Alpha"],desc = L["DescBGAlpha"],type = "range",
			get = function () return self.db.profile.BgAlpha end,
			set = function (v) self.db.profile.BgAlpha = v end,
			min = 0.0, max = 1.0,
		},
		event = {
			name = L["Event"], desc = L["DescEvent"],	type = "group",	
			args = {
				hostile = {
					name = L["Hostile Player Events"], desc = L["DescEventsHPlayer"], type = "toggle",
					get = function () return self.db.profile.events.hostile end,
					set = function (v) self.db.profile.events.hostile = v	self:RefreshRegisteredEvents()	end,
					message = L["EventMsg"], map = {[false] = L["MapEventFalse"], [true] = L["MapEventTrue"]},
				},
				player = {
					name = L["Player Events"], desc = L["DescEventsPlayer"], type = "toggle",
					get = function () return self.db.profile.events.player end,
					set = function (v) self.db.profile.events.player = v	self:RefreshRegisteredEvents()	end,
					message = L["EventMsg"], map = {[false] = L["MapEventFalse"], [true] = L["MapEventTrue"]},
				},
				friendly = {
					name = L["Friendly Player Events"], desc = L["DescEventsFPlayer"], type = "toggle",
					get = function () return self.db.profile.events.friendly end,
					set = function (v) self.db.profile.events.friendly = v	self:RefreshRegisteredEvents()	end,
					message = L["EventMsg"], map = {[false] = L["MapEventFalse"], [true] = L["MapEventTrue"]},
				},
				mob = {
					name = L["Creature Events"], desc = L["DescEventsMobs"], type = "toggle",
					get = function () return self.db.profile.events.mob end,
					set = function (v) self.db.profile.events.mob = v	self:RefreshRegisteredEvents()	end,
					message = L["EventMsg"], map = {[false] = L["MapEventFalse"], [true] = L["MapEventTrue"]},
				},
			}
		},
		enabled = {
			name = L["Enabled"], desc=L["DescEnabled"], type="group",
			args = {
				casts = {	name = L["Casts"],  desc=L["DescCasts"], type = "toggle",
						get = function () return self.db.profile.enabled.Casts end,
						set = function (v) self.db.profile.enabled.Casts = v end, 
				},
				cooldowns = {	name = L["Cooldowns"],  desc=L["DescCooldowns"], type = "toggle",
						get = function () return self.db.profile.enabled.Cooldowns end,
						set = function (v) self.db.profile.enabled.Cooldowns = v end, 
				},
				buffs = {	name = L["Buffs"],  desc=L["DescBuffs"], type = "toggle",
						get = function () return self.db.profile.enabled.Buffs end,
						set = function (v) self.db.profile.enabled.Buffs = v end, 
				},
				durations = {	name = L["Durations"],  desc=L["DescDurations"], type = "toggle",
						get = function () return self.db.profile.enabled.Durations end,
						set = function (v) self.db.profile.enabled.Durations = v end, 
				},
			}
		},
		bargrowth = {
			name = L["Bar Growth"], desc=L["DescBarGrowth"], type = "group",
			args = {
				all = {		name = L["All"], desc=L["DescAll"], type = "toggle",
						get = function () return self.vars.toggleall end,
						set = function (v) if not self.vars.toggleall then self.vars.toggleall = true end self.vars.toggleall = v for i in self.db.profile.bargrowth do self.db.profile.bargrowth[i] = v self:SetCandyBarGroupGrowth("HostelBar"..i, self.db.profile.bargrowth[i]) end end,
				},
				default = {	name = L["Default"],  desc=L["DescDefault"], type = "toggle",
						get = function () return self.db.profile.bargrowth.Default end,
						set = function (v) self.db.profile.bargrowth.Default = v  
							self:SetCandyBarGroupGrowth("HostelBarDefault", self.db.profile.bargrowth.Default) end,
						map = { [false] = L["MapBarGrowthFalse"], [true] = L["MapBarGrowthTrue"],},
				},
				casts = {	name = L["Casts"],  desc=L["DescCasts"], type = "toggle",
						get = function () return self.db.profile.bargrowth.Casts end,
						set = function (v) self.db.profile.bargrowth.Casts = v  
							self:SetCandyBarGroupGrowth("HostelBarCasts", self.db.profile.bargrowth.Casts) end,
						map = { [false] = L["MapBarGrowthFalse"], [true] = L["MapBarGrowthTrue"],},
				},
				cooldowns = {	name = L["Cooldowns"],  desc=L["DescCooldowns"], type = "toggle",
						get = function () return self.db.profile.bargrowth.Cooldowns end,
						set = function (v) self.db.profile.bargrowth.Cooldowns = v  
							self:SetCandyBarGroupGrowth("HostelBarCooldowns", self.db.profile.bargrowth.Cooldowns) end,
						map = { [false] = L["MapBarGrowthFalse"], [true] = L["MapBarGrowthTrue"],},
				},
				buffs = {	name = L["Buffs"],  desc=L["DescBuffs"], type = "toggle",
						get = function () return self.db.profile.bargrowth.Buffs end,
						set = function (v) self.db.profile.bargrowth.Buffs = v  
							self:SetCandyBarGroupGrowth("HostelBarBuffs", self.db.profile.bargrowth.Buffs) end,
						map = { [false] = L["MapBarGrowthFalse"], [true] = L["MapBarGrowthTrue"],},
				},
				durations = {	name = L["Durations"],  desc=L["DescDurations"], type = "toggle",
						get = function () return self.db.profile.bargrowth.Durations end,
						set = function (v) self.db.profile.bargrowth.Durations = v  
							self:SetCandyBarGroupGrowth("HostelBarDurations", self.db.profile.bargrowth.Durations) end,
						map = { [false] = L["MapBarGrowthFalse"], [true] = L["MapBarGrowthTrue"],},
				},
			}
		},
		titles = {
			name = L["Titles"], desc=L["DescTitles"], type = "group",
			args = {
				all = {		name = L["All"], desc=L["DescAll"], type = "toggle",
						get = function () return self.vars.toggleall end,
						set = function (v) if not self.vars.toggleall then self.vars.toggleall = true end self.vars.toggleall = v for i in self.db.profile.titles do self.db.profile.titles[i] = v end end,
				},
				default = {	name = L["Default"],  desc=L["DescDefault"], type = "toggle",
						get = function () return self.db.profile.titles.Default end,
						set = function (v) self.db.profile.titles.Default = v end, 
				},
				casts = {	name = L["Casts"],  desc=L["DescCasts"], type = "toggle",
						get = function () return self.db.profile.titles.Casts end,
						set = function (v) self.db.profile.titles.Casts = v end, 
				},
				cooldowns = {	name = L["Cooldowns"],  desc=L["DescCooldowns"], type = "toggle",
						get = function () return self.db.profile.titles.Cooldowns end,
						set = function (v) self.db.profile.titles.Cooldowns = v end, 
				},
				buffs = {	name = L["Buffs"],  desc=L["DescBuffs"], type = "toggle",
						get = function () return self.db.profile.titles.Buffs end,
						set = function (v) self.db.profile.titles.Buffs = v end, 
				},
				durations = {	name = L["Durations"],  desc=L["DescDurations"], type = "toggle",
						get = function () return self.db.profile.titles.Durations end,
						set = function (v) self.db.profile.titles.Durations = v end, 
				},
			}
		},
		reversed = {
			name = L["Reversed"], desc=L["DescReversed"], type = "group",
			args = {
				all = {		name = L["All"], desc=L["DescAll"], type = "toggle",
						get = function () return self.vars.toggleall end,
						set = function (v) if not self.vars.toggleall then self.vars.toggleall = true end self.vars.toggleall = v for i in self.db.profile.reversed do self.db.profile.reversed[i] = v end end,
				},
				casts = {	name = L["Casts"],  desc=L["DescCasts"], type = "toggle",
						get = function () return self.db.profile.reversed.Casts end,
						set = function (v) self.db.profile.reversed.Casts = v end, 
				},
				cooldowns = {	name = L["Cooldowns"],  desc=L["DescCooldowns"], type = "toggle",
						get = function () return self.db.profile.reversed.Cooldowns end,
						set = function (v) self.db.profile.reversed.Cooldowns = v end, 
				},
				buffs = {	name = L["Buffs"],  desc=L["DescBuffs"], type = "toggle",
						get = function () return self.db.profile.reversed.Buffs end,
						set = function (v) self.db.profile.reversed.Buffs = v end, 
				},
				durations = {	name = L["Durations"],  desc=L["DescDurations"], type = "toggle",
						get = function () return self.db.profile.reversed.Durations end,
						set = function (v) self.db.profile.reversed.Durations = v end, 
				},
			}
		},
		barcolor = {
			name = L["Bar Color"], desc=L["DescBarColor"], type = "group",
			args = {
				all = {		name = L["All"], desc=L["DescAll"], type = "text",
						get = function () return nil end,
						set = function (v) for i in self.db.profile.barcolor do self.db.profile.barcolor[i] = v end end,
						validate = { L["class"], L["type"], L["school"]},						
				},
				casts = {	name = L["Casts"],  desc=L["DescCasts"], type = "text",
						get = function () return self.db.profile.barcolor.Casts end,
						set = function (v) self.db.profile.barcolor.Casts = v end, 
						validate = { L["class"], L["type"], L["school"]},
				},
				cooldowns = {	name = L["Cooldowns"],  desc=L["DescCooldowns"], type = "text",
						get = function () return self.db.profile.barcolor.Cooldowns end,
						set = function (v) self.db.profile.barcolor.Cooldowns = v end, 
						validate = { L["class"], L["type"], L["school"]},
				},
				buffs = {	name = L["Buffs"],  desc=L["DescBuffs"], type = "text",
						get = function () return self.db.profile.barcolor.Buffs end,
						set = function (v) self.db.profile.barcolor.Buffs = v end, 
						validate = { L["class"], L["type"], L["school"]},
				},
				durations = {	name = L["Durations"],  desc=L["DescDurations"], type = "text",
						get = function () return self.db.profile.barcolor.Durations end,
						set = function (v) self.db.profile.barcolor.Durations = v end, 
						validate = { L["class"], L["type"], L["school"]},
				},
			}
		},
		bgcolor = {
			name = L["Background Color"], desc=L["DescBgColor"], type = "group",
			args = {
				all = {		name = L["All"], desc=L["DescAll"], type = "text",
						get = function () return nil end,
						set = function (v) for i in self.db.profile.bgcolor do self.db.profile.bgcolor[i] = v end end,
						validate = {L["default"], L["class"], L["type"], L["school"]},						
				},
				casts = {	name = L["Casts"],  desc=L["DescCasts"], type = "text",
						get = function () return self.db.profile.bgcolor.Casts end,
						set = function (v) self.db.profile.bgcolor.Casts = v end, 
						validate = {L["default"], L["class"], L["type"], L["school"]},
				},
				cooldowns = {	name = L["Cooldowns"],  desc=L["DescCooldowns"], type = "text",
						get = function () return self.db.profile.bgcolor.Cooldowns end,
						set = function (v) self.db.profile.bgcolor.Cooldowns = v end, 
						validate = {L["default"], L["class"], L["type"], L["school"]},
				},
				buffs = {	name = L["Buffs"],  desc=L["DescBuffs"], type = "text",
						get = function () return self.db.profile.bgcolor.Buffs end,
						set = function (v) self.db.profile.bgcolor.Buffs = v end, 
						validate = {L["default"], L["class"], L["type"], L["school"]},
				},
				durations = {	name = L["Durations"],  desc=L["DescDurations"], type = "text",
						get = function () return self.db.profile.bgcolor.Durations end,
						set = function (v) self.db.profile.bgcolor.Durations = v end, 
						validate = {L["default"], L["class"], L["type"], L["school"]},
				},
			}
		},
		textcolor = {
			name = L["Text Color"], desc=L["DescTextColor"], type = "group",
			args = {
				all = {		name = L["All"], desc=L["DescAll"], type = "text",
						get = function () return nil end,
						set = function (v) for i in self.db.profile.textcolor do self.db.profile.textcolor[i] = v end end,
						validate = { L["class"], L["type"], L["school"], L["white"]},						
				},
				casts = {	name = L["Casts"],  desc=L["DescCasts"], type = "text",
						get = function () return self.db.profile.textcolor.Casts end,
						set = function (v) self.db.profile.textcolor.Casts = v end, 
						validate = { L["class"], L["type"], L["school"], L["white"]},
				},
				cooldowns = {	name = L["Cooldowns"],  desc=L["DescCooldowns"], type = "text",
						get = function () return self.db.profile.textcolor.Cooldowns end,
						set = function (v) self.db.profile.textcolor.Cooldowns = v end, 
						validate = { L["class"], L["type"], L["school"], L["white"]},
				},
				buffs = {	name = L["Buffs"],  desc=L["DescBuffs"], type = "text",
						get = function () return self.db.profile.textcolor.Buffs end,
						set = function (v) self.db.profile.textcolor.Buffs = v end, 
						validate = { L["class"], L["type"], L["school"], L["white"]},
				},
				durations = {	name = L["Durations"],  desc=L["DescDurations"], type = "text",
						get = function () return self.db.profile.textcolor.Durations end,
						set = function (v) self.db.profile.textcolor.Durations = v end, 
						validate = { L["class"], L["type"], L["school"], L["white"]},
				},
			}
		},
		barscale = {
			name = L["Bar Scale"], desc=L["DescBarScale"], type = "group",
			args = {
				all = {		name = L["All"], desc=L["DescAll"], type = "range",
						get = function () return nil end,
						set = function (v) for i in self.db.profile.barscale do self.db.profile.barscale[i] = v end end,
						min = 0.5, max = 1.5,					
				},
				default = {	name = L["Default"],  desc=L["DescDefault"], type = "range",
						get = function () return self.db.profile.barscale.Default end,
						set = function (v) self.db.profile.barscale.Default = v end,
						min = 0.5, max = 1.5,
				},
				casts = {	name = L["Casts"],  desc=L["DescCasts"], type = "range",
						get = function () return self.db.profile.barscale.Casts end,
						set = function (v) self.db.profile.barscale.Casts = v end,
						min = 0.5, max = 1.5,
				},
				cooldowns = {	name = L["Cooldowns"],  desc=L["DescCooldowns"], type = "range",
						get = function () return self.db.profile.barscale.Cooldowns end,
						set = function (v) self.db.profile.barscale.Cooldowns = v end,
						min = 0.5, max = 1.5,
				},
				buffs = {	name = L["Buffs"],  desc=L["DescBuffs"], type = "range",
						get = function () return self.db.profile.barscale.Buffs end,
						set = function (v) self.db.profile.barscale.Buffs = v end,
						min = 0.5, max = 1.5,
				},
				durations = {	name = L["Durations"],  desc=L["DescDurations"], type = "range",
						get = function () return self.db.profile.barscale.Durations end,
						set = function (v) self.db.profile.barscale.Durations = v end,
						min = 0.5, max = 1.5,
				},
			}
		},
		texture = {
			name = L["Texture"], desc=L["DescTexture"], type = "group",
			args = {
				all = {		name = L["All"], desc=L["DescAll"], type = "text",
						get = function () return nil end,
						set = function (v) for i in self.db.profile.texture do self.db.profile.texture[i] = v end end,
						validate = {"1","2","3","4","5"},
				},
				casts = {	name = L["Casts"],  desc=L["DescCasts"], type = "text",
						get = function () return self.db.profile.texture.Casts end,
						set = function (v) self.db.profile.texture.Casts = v end,
						validate = {"1","2","3","4","5"},
				},
				cooldowns = {	name = L["Cooldowns"],  desc=L["DescCooldowns"], type = "text",
						get = function () return self.db.profile.texture.Cooldowns end,
						set = function (v) self.db.profile.texture.Cooldowns = v end,
						validate = {"1","2","3","4","5"},
				},
				buffs = {	name = L["Buffs"],  desc=L["DescBuffs"], type = "text",
						get = function () return self.db.profile.texture.Buffs end,
						set = function (v) self.db.profile.texture.Buffs = v end,
						validate = {"1","2","3","4","5"},
				},
				durations = {	name = L["Durations"],  desc=L["DescDurations"], type = "text",
						get = function () return self.db.profile.texture.Durations end,
						set = function (v) self.db.profile.texture.Durations = v end,
						validate = {"1","2","3","4","5"},
				},
			}
		},
		anchors = {name = L["Show Anchors"], desc = L["DescShowAnchors"], type = "execute", func = "ToggleAnchor"},
		test = {name = L["Test"],desc = L["DescTest"],type = "execute",func = "RunTestTimer"},
	}
	}

    	-- register stuff 
	HostelBar:RegisterDB("HostelBarDB")
	HostelBar:RegisterDefaults('profile', defaults)

	HostelBar:RegisterChatCommand({"/hb", "/hostel", "/hostelbar"}, args)
	
	-- create the anchor frames	
	self.anchors = {}
	self.anchors.Default   =  self:CreateAnchor("Default",      0, L["Timer"]..L["GUIAnchorsString"],  0,1,0)
	self.anchors.Casts     =  self:CreateAnchor("Casts",	  -50, L["Cast"]..L["GUIAnchorsString"],     1, 0, 0)
	self.anchors.Cooldowns =  self:CreateAnchor("Cooldowns", -100, L["Cooldown"]..L["GUIAnchorsString"], 0,0,1)
	self.anchors.Buffs     =  self:CreateAnchor("Buffs",	 -150, L["Buff"]..L["GUIAnchorsString"],     1, 0.4, 1)
	self.anchors.Durations =  self:CreateAnchor("Durations", -200, L["Duration"]..L["GUIAnchorsString"], 0.3, 0.7, 0.4)
	
	-- create titles
	self.titles = {}
	self.titles.Default	 = self:CreateTitle(L["Hostel"],   self.anchors.Default, 0.4,1,0.4)
	self.titles.Casts	 = self:CreateTitle(L["Casts"],    self.anchors.Casts, 1,0.3,0.3)
	self.titles.Cooldowns	 = self:CreateTitle(L["Cooldowns"],self.anchors.Cooldowns, 0.4,0.4,1)
	self.titles.Buffs        = self:CreateTitle(L["Buffs"],    self.anchors.Buffs, 0.7,0.3,1)
	self.titles.Durations	 = self:CreateTitle(L["Durations"],self.anchors.Durations, 0.7,0.3,1)

	self:CreateCandyBarRegs()
	
	-- colors of the different types
	self.colors = {
		Default = "cyan",
		Casts = "red",
		Cooldowns = "blue",
		Buffs = "magenta",
		Durations = "orange",
		candybarbg = "candybarbg"
	}

	-- texture paths
	self.textures = {
		["1"] = candy.var.defaults.texture,
		["2"] = "Interface\\AddOns\\HostelBar\\Textures\\cilo.tga",
		["3"] = "Interface\\AddOns\\HostelBar\\Textures\\glaze.tga",
		["4"] = "Interface\\AddOns\\HostelBar\\Textures\\perl.tga",
		["5"] = "Interface\\AddOns\\HostelBar\\Textures\\smooth.tga",
	}

	paint:RegisterColor("candybarbg",  0, .5, .5)

	-- self.vars contains misc variables such as combo points and such
	self.vars = {}

	local _, class = UnitClass("player") 
	if class == "WARLOCK" then
		self.vars.curses = {}
	end
	class = nil
end

function HostelBar:OnEnable()
	self:RefreshRegisteredEvents()
end
function HostelBar:OnDisable()
	parser:UnregisterAllEvents("HostelBar")
end
--[[--------------------------------------------------------------------------------
  Event Registering
-----------------------------------------------------------------------------------]]
-- CandyBar group registrations
function HostelBar:CreateCandyBarRegs()
	self:RegisterCandyBarGroup("HostelBarDefault")
	self:RegisterCandyBarGroup("HostelBarCasts")
	self:RegisterCandyBarGroup("HostelBarCooldowns")
	self:RegisterCandyBarGroup("HostelBarBuffs")
	self:RegisterCandyBarGroup("HostelBarDurations")

	self:SetCandyBarGroupPoint("HostelBarDefault", "TOP", self.anchors.Default, "BOTTOM", 0, 0)
	self:SetCandyBarGroupPoint("HostelBarCasts", "TOP", self.anchors.Casts, "BOTTOM", 0, 0)
	self:SetCandyBarGroupPoint("HostelBarCooldowns", "TOP", self.anchors.Cooldowns, "BOTTOM", 0, 0)
	self:SetCandyBarGroupPoint("HostelBarBuffs", "TOP", self.anchors.Buffs, "BOTTOM", 0, 0)
	self:SetCandyBarGroupPoint("HostelBarDurations", "TOP", self.anchors.Durations, "BOTTOM", 0, 0)
	
	self:SetCandyBarGroupGrowth("HostelBarDefault", self.db.profile.bargrowth.Default) 
	self:SetCandyBarGroupGrowth("HostelBarCasts", self.db.profile.bargrowth.Casts) 
	self:SetCandyBarGroupGrowth("HostelBarCooldowns", self.db.profile.bargrowth.Cooldowns) 
	self:SetCandyBarGroupGrowth("HostelBarBuffs", self.db.profile.bargrowth.Buffs) 
	self:SetCandyBarGroupGrowth("HostelBarDurations", self.db.profile.bargrowth.Durations) 
end

-- Event registrations
function HostelBar:RefreshRegisteredEvents()
	self:RefreshHostileEvent("CHAT_MSG_SPELL_HOSTILEPLAYER_BUFF", "hostile")
	self:RefreshHostileEvent("CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_BUFFS", "hostile")
	self:RefreshHostileEvent("CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE", "hostile")
	self:RefreshHostileEvent("CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE", "hostile")
	 
	self:RefreshHostileEvent("CHAT_MSG_SPELL_SELF_DAMAGE", "player")
	self:RefreshHostileEvent("CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE", "player")
	self:RefreshHostileEvent("CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS", "player")
	
	self:RefreshMobEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE", "mob")
	self:RefreshMobEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF", "mob")
	self:RefreshMobEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE", "mob")
	self:RefreshMobEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS", "mob")
	
	self:RefreshFriendlyEvent("CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_BUFFS", "friendly")
	self:RefreshFriendlyEvent("CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE", "friendly")

	self:RegisterEvent("SpellStatus_SpellCastInstant", "ParseSpellStatus")
	self:RegisterEvent("SpellStatus_SpellCastCastingFinish", "ParseSpellStatus")
	
	local regevent = "CHAT_MSG_COMBAT_HOSTILE_DEATH"
	if self.db.profile.StopOnHDeath and not parser:IsEventRegistered("HostelBar", regevent) then  parser:RegisterEvent("HostelBar", regevent,  function(event, info) self:HostileDeath(event, info) end)
 	elseif parser:IsEventRegistered("HostelBar", regevent) then parser:UnregisterEvent("HostelBar", regevent)  end
	
	regevent = "PLAYER_DEAD"
	if self.db.profile.StopOnDeath and not self:IsEventRegistered(regevent) then self:RegisterEvent(regevent,  function() self:PlayerDead() end) 
	elseif self:IsEventRegistered(regevent) then self:UnregisterEvent(regevent)  end

	self:Debug("RefreshRegisteredEvents: Events refreshed.")
	regevent, englishClass = nil
end
-- Refresh the registration of a hostile player event
function HostelBar:RefreshHostileEvent(regevent, path)
	if self.db.profile.events[path] and not parser:IsEventRegistered("HostelBar", regevent) then
		parser:RegisterEvent("HostelBar", regevent, function (event, info) self:ParseHostileEvents(event, info) end)
	elseif not self.db.profile.events[path] and parser:IsEventRegistered("HostelBar", regevent) then
		parser:UnregisterEvent("HostelBar", regevent)				
	end
end
-- Refresh the registration of a mob event
function HostelBar:RefreshMobEvent(regevent, path)
	if self.db.profile.events[path] and not parser:IsEventRegistered("HostelBar", regevent) then
		parser:RegisterEvent("HostelBar", regevent, function (event, info) self:ParseMobEvents(event, info) end)
	elseif not self.db.profile.events[path] and parser:IsEventRegistered("HostelBar", regevent) then
		parser:UnregisterEvent("HostelBar", regevent)				
	end
end
-- Refresh the registration of a friendly player event
function HostelBar:RefreshFriendlyEvent(regevent, path)
	if self.db.profile.events[path] and not parser:IsEventRegistered("HostelBar", regevent) then
		parser:RegisterEvent("HostelBar", regevent, function (event, info) self:ParseFriendlyEvents(event, info) end)
	elseif not self.db.profile.events[path] and parser:IsEventRegistered("HostelBar", regevent) then
		parser:UnregisterEvent("HostelBar", regevent)				
	end
end
--[[--------------------------------------------------------------------------------
  Event Parsing
-----------------------------------------------------------------------------------]]
-- Parse hostile player events and player afflictions (caused by the player or friendly players)
function HostelBar:ParseHostileEvents(event, info)
	if info.type == "cast" then
		if info.source == ParserLib_SELF and not info.isBegin and info.victim then
			self:CheckInfo(info.victim, info.skill, "Durations", "hplayer", nil, "player")
			self.vars.lastspell = info.skill
			self:Debug("ParserHostileEvents: You cast a spell. s: "..info.skill.." v: "..info.victim)
		elseif info.isBegin then
			self:CheckInfo(info.source, info.skill, "Casts", "hplayer")
		else
			self:CheckInfo(info.source, info.skill, "Cooldowns", "hplayer")
		end
	elseif info.type == "buff" then
		self:CheckInfo(info.victim, info.skill, "Buffs", "hplayer")
	elseif info.type == "debuff" then
		if not self.db.profile.SelfDurations then
		self:Debug("ParserDebuff: s: "..info.skill.." t: "..info.victim)
		self:CheckInfo(info.victim, info.skill, "Durations", "hplayer") end
	elseif info.type == "fade" or (info.type == "dispel" and not info.isFailed)  then
		if self:IsCandyBarRegistered("HostelBar_"..info.victim..info.skill) then 
			self:StopCandyBar("HostelBar_"..info.victim..info.skill) 
		end
	elseif info.type == "miss" then
		self.vars.lastspellmiss = true
	elseif info.type == "interrupt" then
		self:InterruptTimer(info.victim, info.skill)
	
	end
end
-- Parse mob events and mob afflictions (caused by the player or friendly players)
function HostelBar:ParseMobEvents(event, info)
	if info.type == "cast" then
		self:Debug("MobParser: source: "..info.source.." spell: "..info.skill)
		if info.source == ParserLib_SELF and not info.isBegin and info.victim then
			self:CheckInfo(info.victim, info.skill, "Durations", "mob", nil, "player")
			self.vars.lastspell = info.skill
			self:Debug("ParseMobEvents: You cast a spell. s: "..info.skill.." v: "..info.victim)
		elseif info.isBegin then
			self:CheckInfo(info.source, info.skill, "Casts", "mob")
			self:Debug("ParseMobEvents: Mob casting a spell. spell: "..info.skill.." source: "..info.source)
		else
			self:CheckInfo(info.source, info.skill, "Cooldowns", "mob")
		end
	elseif info.type == "buff" then
		self:CheckInfo(info.victim, info.skill, "Buffs", "mob")
	elseif info.type == "debuff" then
		if not self.db.profile.SelfDurations then
		self:Debug("ParserDebuff: s: "..info.skill.." t: "..info.victim)
		self:CheckInfo(info.victim, info.skill, "Durations", "hplayer") end
	elseif info.type == "fade" or (info.type == "dispel" and not info.isFailed)  then
		if self:IsCandyBarRegistered("HostelBar_"..info.victim..info.skill) then 
			self:StopCandyBar("HostelBar_"..info.victim..info.skill) 
		end
	elseif info.type == "miss" then
		self.vars.lastspellmiss = true
	elseif info.type == "interrupt" then
		self:InterruptTimer(info.victim, info.skill)
	end
end
-- Parse friendly player events
function HostelBar:ParseFriendlyEvents(event, info)
	if info.type == "buff" and not self.db.profile.SelfDurations then
		self:CheckInfo(info.victim, info.skill, "Durations", "fplayer", true)
	elseif info.type == "cast" and info.source == ParserLib_SELF and not info.isBegin and info.victim then
		self:CheckInfo(info.victim, info.skill, "Durations", "fplayer", true)
	end
end
-- Parse SpellStatus events
function HostelBar:ParseSpellStatus(spellId, spellName)
	self.vars.lastspell = spellName
	if not self.db.profile.SelfDurations then return end

	local target 
	if UnitExists("target") then target = UnitName("target") else return end
	
	self:Debug("SpellStatus: s: "..spellName.." t: "..target)

	self:CheckInfo(target, spellName, "Durations", "hplayer", nil, "player")
	target = nil
end
-- remove bars from player who died
function HostelBar:HostileDeath(event, info)
	if self.db.profile.StopOnHDeath then
		self:Debug("HostileDeath: Stopping bars from: "..info.victim)
		for k,v in candy.var.handlers do
			if(string.find(k, "HostelBar_"..info.victim))then
				if(v.frame:IsShown()) then
					self:StopCandyBar(k)
				end
			end
		end
		self:RefreshTitles("Default")
		self:RefreshTitles("Casts")
		self:RefreshTitles("Cooldowns")
		self:RefreshTitles("Buffs")
		self:RefreshTitles("Durations")
	end
end

-- stops all bars and hides titles on player death
function HostelBar:PlayerDead()
	self:Debug("PlayerDead: Stopping all bars")
	if self.db.profile.StopOnDeath then
		for k,v in candy.var.handlers do
			if(string.find(k, "HostelBar_")) then
				if(v.frame:IsShown()) then
					self:StopCandyBar(k)
				end
			end
		end
		self:HideTitles()
	end
end 
--[[--------------------------------------------------------------------------------
  Main Processing
-----------------------------------------------------------------------------------]]
function HostelBar:CheckInfo(unit, spell, type, unittype, friendly, source)
	-- ParserLib can be silly sometimes ^_^
	if unit == 103 then unit = UnitName("player") end

	self:Debug("CheckInfo: u: "..unit.." s: "..spell.." type: "..type)

	-- did this spell hit the target?
	if source and source == "player" and spell == self.vars.lastspell and self.vars.lastspellmiss then
		self.vars.lastspellmiss = nil
		return
	end

	-- is this type enabled?
	if not self.db.profile.enabled[type] then return end

	-- are we friendly?
	if not friendly and self:IsFriendly(unit) then return end
	
	-- check the target 
	if self.db.profile.TargetOnly then
		if not UnitExists("target") then return
		elseif UnitName("target") ~= unit then return end
	end

	-- is it already running? excluding Durations bars
	if self:IsCandyBarRegistered("HostelBar_"..unit..spell) and type ~= "Durations" then self:Debug("CheckInfo: Bar "..unit..spell.." already running") return end
	
	-- change spell to english if it isnt
	spell = self:ReverseTranslateSpell(spell)
	
	-- warlock curse (only 1 can be on a unit at a time)
	local oldCurse 
	if self.vars.curses then
		if self.vars.curses[unit] then oldCurse = self.vars.curses[unit] end
	end
	-- have to use nesting because indexing past a nil field in a table causes an error
	if type == "Durations" and self.DurationsDB[spell]  then 
		if self.DurationsDB[spell].curse and source == "player" then 
			if oldCurse and self:IsCandyBarRegistered("HostelBar_"..unit..oldCurse) then
				self:StopCandyBar("HostelBar_"..unit..oldCurse)
				self:Debug("CheckInfo: Stopped curse timer. "..unit.." : "..oldCurse)
			end
			self.vars.curses[unit] = spell
		end
	end
	oldCurse = nil
	
	-- figure out which database is needed
	local database
	if unittype == "mob" then
		database = "MobSpellsDB"
	elseif type == "Durations" then 
		database = "DurationsDB"
	else
		database = "SpellsDB"
	end

	-- check if spell exists
	if not self[database][spell] then self:Debug("CheckInfo: spell doesnt exist. u: "..unit.." s: "..spell.." d: "..database) return end
	

	-- passed all checks, on to the formatting!
	self:FormatBar(unit, unittype, spell, type, database, friendly)

	-- spell cooldown bar - if its there
	if self[database][spell].cd then
		if self[database][spell].cd > 120 and not self.db.profile.LongCD then else -- does nothing if conditions are met
			self:FormatBar(unit, unittype, spell, "Cooldowns", database, friendly, self[database][spell].cd)
		end
	end

end

-- Formats the bar's appearance
function HostelBar:FormatBar(unit, unittype, spell, type, database, friendly, overTime) -- overTime overrides the time variable (cooldown bars)

	-- set school/class/icon variables
	local school = self[database][spell].school
	local class = self[database][spell].class
	local icon = self:GetSpellIcon(spell, database)
	
	
	local time 
	-- time by combo points
	if overTime then
		time = overTime
	elseif self[database][spell].cp and UnitName("target") == unit then 
		time = self[database][spell].time + ( GetComboPoints() - 1 ) * self[database][spell].cp
	else
		time = self[database][spell].time
	end 

	-- retrieve drtable of the spell (if it exists)
	local drtable
	if self[database][spell].drtable then
		drtable = self[database][spell].drtable
	end
	

	-- apply DR multiplier to time if DR is already running
	-- dont check if the DR option is enabled because if a DR bar is running then obviously it is enabled
	local id = "" -- set id to "" instead of nil so the self:IsCandyBarRegistered(id) doesnt error
	if drtable then id = "HostelBar_"..unit.."_DR_"..drtable end
	if drtable and self:IsCandyBarRegistered(id) then		
		if string.find(candy.var.handlers[id].text, "1/4") then
			time = time * 0.75
		elseif string.find(candy.var.handlers[id].text, "1/2") then
			time = time * 0.5
		elseif string.find(candy.var.handlers[id].text, "Imm") then
			self:Debug("CheckInfo: Diminishing returns ("..id..") is at the Immune stage. Stopping.")
			return		
		end
		self:Debug("CheckInfo: Diminishing returns multiplier applied to time. Spell: "..spell.." Time: "..time)
	end
	id = nil -- nil out id


	-- color the text prettiful
	local textcolor
	if self.db.profile.textcolor[type] == L["class"] and class ~= "general" then
		textcolor = class
	elseif self.db.profile.textcolor[type] == L["type"] then
		textcolor = self.colors[type]
	elseif self.db.profile.textcolor[type] == L["school"] then
		textcolor = self:GetSchoolColor(school)
	else
		textcolor = self.db.profile.textcolor[type]
	end
	
	-- color the background prettiful
	local bgcolor
	if self.db.profile.bgcolor[type] == L["class"] and class ~= "general" then
		bgcolor = class
	elseif self.db.profile.bgcolor[type] == L["type"] then
		bgcolor = self.colors[type]
	elseif self.db.profile.bgcolor[type] == L["school"] then
		bgcolor = self:GetSchoolColor(school)
	else
		-- the "default" option is covered by this also seeing as its the only one left
		bgcolor = "candybarbg"
	end
	
	-- color the bars prettiful
	local barcolor
	if self.db.profile.barcolor[type] == L["class"] and class ~= "general" then
		barcolor = class
	elseif self.db.profile.barcolor[type] == L["school"] then
		barcolor = self:GetSchoolColor(school)
	elseif self.db.profile.barcolor[type] == L["type"] then
		barcolor = self.colors[type]
	else
		barcolor = "red"
	end
	
	-- get the texture
	local texture = self.textures[self.db.profile.texture[type]]

	-- bar text
	local text = self:TranslateSpell(spell) 
	if not self.db.profile.NoName then
		text = text.." : "..unit	
	end
	
	-- formatting complete, start the bar 
	self:StartBar(unit, spell, text, type, time, icon, barcolor, textcolor, bgcolor, texture, drtable)

end
-- Register and start the timer
function HostelBar:StartBar(unit, spell, text, type, time, icon, barcolor, textcolor, bgcolor, texture, drtable)

	-- if the locale isnt english then translate the spell back to the original locale (we're now done with parsing)
	spell = self:TranslateSpell(spell)
	
	-- declare id var for ease of use 
	local id = "HostelBar_"..unit..spell
	
	
	-- register the bar
	self:RegisterCandyBar(id, time, text, icon, barcolor, barcolor, barcolor, "red")

	self:SetCandyBarTexture(id, texture)
	self:SetCandyBarTextColor(id, textcolor)
	self:SetCandyBarBackgroundColor(id, bgcolor, self.db.profile.BgAlpha)
	self:SetCandyBarReversed(id, self.db.profile.reversed[type])
	
	-- are the bars going to be in groups?
	if not self.db.profile.Grouped then type = "Default" end

	-- set scale after type has been determined in case type is Default
	self:SetCandyBarScale(id, self.db.profile.barscale[type])

	-- do we want titles?
	if self.db.profile.titles[type] then
		self.titles[type]:Show()
	end
	
	-- diminishing returns bar after spell ends
	if drtable then
		self:SetCandyBarCompletion(id, function(group, regedBar, victim, drtable) HostelBar:BarEnds(group, regedBar, victim, drtable) end, type, id, unit, drtable)
	else
		self:SetCandyBarCompletion(id, function(group, regedBar) HostelBar:RefreshTitles(group, regedBar) end, type, id)
	end

	-- register bar with group
	self:RegisterCandyBarWithGroup(id, "HostelBar"..type)
	
	-- start this bitch!
	self:StartCandyBar(id, true)
	
	self:Debug("StartBar: Bar started [caster: "..unit..". spell: "..spell..". type: "..type.."]")

	-- reset variables
	id, unit, spell, type, time, icon, barcolor, textcolor, bgcolor, texture, drtable = nil
end

-- Fired when a bar ends
function HostelBar:BarEnds(group, regedBar, victim, drtable)
	self:RefreshTitles(group, regedBar)
	-- warlock curses
	if self.vars.curses then
		if self.vars.curses[victim] then 
			self.vars.curses[victim] = nil
		end
	end
	-- diminishing returns
	if self.db.profile.DRTimers and drtable then
		self:RefreshDRTimers(victim, drtable)
	end
end
-- Refresh the diminishing returns timers
function HostelBar:RefreshDRTimers(victim,  drtable)
	-- declare id and type vars
	local id = "HostelBar_"..victim.."_DR_"..drtable
	local type
	if self.db.profile.Grouped then type = "Durations" else type = "Default" end 
	
	-- figure out the stage of diminishing returns (50%, or immune) if we are past the first stage
	local drcount = "1/4"
	if self:IsCandyBarRegistered(id) then 
	    if string.find(candy.var.handlers[id].text, "1/4") then
		drcount = "1/2"
	    else
		drcount ="Imm"
	    end
	end
	
	local text = "[|CFFED1C24"..drcount.."|CFFFFFFFF] DR("..drtable..")"
	if not self.db.profile.NoName then
		text = text.." : "..victim
	end

	-- register the bar
	self:RegisterCandyBar(id, 15, text,  "Interface\\Icons\\Spell_Frost_Stun", "blue", "blue", "cyan", "red")
	
	self:SetCandyBarScale(id, self.db.profile.barscale[type])

	-- register bar with group
	self:RegisterCandyBarWithGroup(id, "HostelBar"..type)

	-- start this bitch!
	self:StartCandyBar(id, true)
	self:Debug("RefreshDRTimers: DR timer started for victim: "..victim.."; drtable: "..drtable)

	type, text, id, drcount = nil
end
-- Starts an Interrupt timers
function HostelBar:InterruptTimer(victim, spell)
	-- if conditions are true then start a timer for how long the school of spell has been interrupted for
	if self:IsCandyBarRegistered("HostelBar_"..victim..spell) then
		
		self:StopCandyBar("HostelBar_"..victim..spell)
		self:RefreshTitles("Casts")
		
		self:Debug("InterruptTimer: interrupt detected; victim = "..victim.."; spell = "..spell)
		
		if self.db.profile.InterruptTime then
			-- are we friendly?
			if self:IsFriendly(victim) then return end

			-- check the target 
			if self.db.profile.TargetOnly then
				if not UnitExists("target") then return
				elseif UnitName("target") ~= victim then return end
			end
			
			-- checks passed, onto formatting
			
			-- set spell to english version for processing
			spell = self:ReverseTranslateSpell(spell)
			if not self.SpellsDB[spell] then return end
			
			local intrptSpell = self:ReverseTranslateSpell(self.vars.lastspell)
			if not self.InterruptTimes[intrptSpell] then return end

			-- set some formatting vars
			local time = self.InterruptTimes[intrptSpell].time
			local school = self.SpellsDB[spell].school
			local barcolor = self:GetSchoolColor(school)
			local icon = self:GetSchoolIcon(school)
			
			local text = "(Intrpt) "..school
			if not self.db.profile.NoName then
				text = text.." : "..victim
			end
			-- figure out the type
			local type
			if self.db.profile.Grouped then
				type = "Durations"
			else 
				type = "Default"
			end

			-- is this type enabled?
			if not self.db.profile.enabled[type] then return end
			
			local id = "HostelBar_Intrpt_"..victim..school

			-- register the bar
			self:RegisterCandyBar(id, time, text, icon, barcolor, barcolor, barcolor, "red")
				
			self:SetCandyBarBackgroundColor(id, "candybarbg", self.db.profile.BgAlpha)
			self:SetCandyBarScale(id, self.db.profile.barscale[type])

			self:SetCandyBarCompletion(id, function(group, regedBar) HostelBar:RefreshTitles(group, regedBar) end, type, id)

			-- register bar with group
			self:RegisterCandyBarWithGroup(id, "HostelBar"..type)
				
			-- start this bitch!
			self:StartCandyBar(id, true)
			
			-- nil out locals
			type, text, id, school, barcolor, icon, spell, victim = nil

			end
		end

end
-- Credit for this method goes to Ammo
-- Checks if name is a friendly
function HostelBar:IsFriendly( name )
	local i,n,unit
	if name == UnitName("player") then
		return true
	end
	if name == UnitName("pet") and UnitIsFriend("player", "pet") then
		return true
	end
	for i = 1, 4 do 
		unit = "party"..i
		if name == UnitName(unit) and UnitIsFriend("player", unit) then
			return true
		end
		unit = "partypet"..i
		if name == UnitName(unit) and UnitIsFriend("player", unit) then
			return true
		end			
	end
	n = GetNumRaidMembers()
	if n > 0 then
		for i = 1, n do
			unit = "raid"..i
			if name == UnitName(unit) and UnitIsFriend("player", unit) then
				return true
			end
			unit = "raidpet"..i
                        if name == UnitName(unit) and UnitIsFriend("player", unit) then
                                return true
			end
		end
	end
end
-- returns the color of a school (holy, fire, frost, shadow, arcane, nature, genmagic, physical)
function HostelBar:GetSchoolColor(school)
	if not school then return end

	if school == "Holy" then return "yellow"
	elseif school == "Fire" then return "red"
	elseif school == "Frost" then return "blue"
	elseif school == "Shadow" then	return "warlock"
	elseif school == "Arcane" then	return "white"
	elseif school == "Nature" then	return "green"
	elseif school == "Genmagic" then return "cyan"
	elseif school == "Physical" then return "druid"
	else	return "white" 	end
end
-- returns the icon of a spell
function HostelBar:GetSpellIcon(spell, database)
	local icon 
	if self[database][spell].icon then
		icon = self[database][spell].icon
	else 
		icon = BS:GetSpellIcon(spell)
	end
	return icon
end
-- returns the icon of a school (holy, fire, forst, shadow, arcane, nature, genamgic, physical)
function HostelBar:GetSchoolIcon(school)
	if not school then return end

	return "Interface\\Icons\\Spell_Fire_Fireball02"
end
-- returns reverse translation of a spell if it exists
function HostelBar:ReverseTranslateSpell(spell)
	-- change spell to english if it isnt
	if GetLocale() ~= "enUS" or GetLocale() ~= "enGB" then	
		if BS:HasReverseTranslation(spell) then 
			spell = BS:GetReverseTranslation(spell) 
		elseif L:HasReverseTranslation("Spell"..spell) then
			spell = L:GetReverseTranslation("Spell"..spell)
		else
			self:Debug("ReverseTranslateSpell: no reverse translation for spell: "..spell)
		end 
	end
	return spell
end
-- returns translation of a spell if it exists
function HostelBar:TranslateSpell(spell)
	-- if the locale isnt english then translate the spell back to the original locale (we're now done with parsing)
	if GetLocale() ~= "enUS" or GetLocale() ~= "enGB" then	
		if BS:HasTranslation(spell) then
			spell = BS:GetTranslation(spell) 
		elseif L:HasTranslation("Spell"..spell) then
			spell = L:GetTranslation("Spell"..spell)
		else
			self:Debug("TranslateSpell: no translation for spell: "..spell)
		end
	end
	return spell
end
--[[--------------------------------------------------------------------------------
  Command Handlers
-----------------------------------------------------------------------------------]]
-- Runs test bars
function HostelBar:RunTestTimer()
	
	local text = L["GUITestBarTextSpell"]
	if not self.db.profile.NoName then
		text = text.." : "..L["GUITestBarTextCaster"]
	end

	self:RegisterCandyBar("HostelBar_TestDefault", 10, text, "Interface\\Icons\\Spell_Fire_Fireball02", "green", "green","red")
	self:RegisterCandyBar("HostelBar_TestCasts", 10, text, "Interface\\Icons\\Spell_Fire_FlameBolt", "orange", "orange","red")
	self:RegisterCandyBar("HostelBar_TestCooldowns", 10, text, "Interface\\Icons\\Spell_Arcane_Blink", "cyan", "blue","red")
	self:RegisterCandyBar("HostelBar_TestBuffs", 10, text, "Interface\\Icons\\Spell_Holy_SealOfSacrifice", "blue","magenta","red")
	self:RegisterCandyBar("HostelBar_TestDurations", 10, text, "Interface\\Icons\\Ability_ShockWave", "druid","druid","red")
	
	self:RegisterCandyBarWithGroup("HostelBar_TestDefault", "HostelBarDefault")
	self:RegisterCandyBarWithGroup("HostelBar_TestCasts", "HostelBarCasts")
	self:RegisterCandyBarWithGroup("HostelBar_TestCooldowns", "HostelBarCooldowns")
	self:RegisterCandyBarWithGroup("HostelBar_TestBuffs", "HostelBarBuffs")
	self:RegisterCandyBarWithGroup("HostelBar_TestDurations", "HostelBarDurations")
	
	self:SetCandyBarTexture("HostelBar_TestDefault", self.textures["1"])
	self:SetCandyBarTexture("HostelBar_TestCasts", self.textures[self.db.profile.texture.Casts])
	self:SetCandyBarTexture("HostelBar_TestCooldowns", self.textures[self.db.profile.texture.Cooldowns])
	self:SetCandyBarTexture("HostelBar_TestBuffs",  self.textures[self.db.profile.texture.Buffs])
	self:SetCandyBarTexture("HostelBar_TestDurations",  self.textures[self.db.profile.texture.Durations])

	self:SetCandyBarScale("HostelBar_TestDefault", self.db.profile.barscale.Default)
	self:SetCandyBarScale("HostelBar_TestCasts", self.db.profile.barscale.Casts)
	self:SetCandyBarScale("HostelBar_TestCooldowns", self.db.profile.barscale.Cooldowns)
	self:SetCandyBarScale("HostelBar_TestBuffs", self.db.profile.barscale.Buffs)
	self:SetCandyBarScale("HostelBar_TestDurations", self.db.profile.barscale.Durations)
	
	self:SetCandyBarReversed("HostelBar_TestCasts", self.db.profile.reversed.Casts)
	self:SetCandyBarReversed("HostelBar_TestCooldowns", self.db.profile.reversed.Cooldowns)
	self:SetCandyBarReversed("HostelBar_TestBuffs", self.db.profile.reversed.Buffs)
	self:SetCandyBarReversed("HostelBar_TestDurations", self.db.profile.reversed.Durations)
	
	for k,v in self.db.profile.titles do
		if v then
			self.titles[k]:Show()
			self:SetCandyBarCompletion("HostelBar_Test"..k, function(group, regedBar) HostelBar:RefreshTitles(group, regedBar) end, k, "HostelBar_Test"..k)
		end
	end
	
	self:StartCandyBar("HostelBar_TestDefault", true)
	self:StartCandyBar("HostelBar_TestCasts", true)
	self:StartCandyBar("HostelBar_TestCooldowns", true)
	self:StartCandyBar("HostelBar_TestBuffs", true)
	self:StartCandyBar("HostelBar_TestDurations", true)
	
	text = nil

	self:Debug("RunTestTimer: test bars started")
end

-- Toggles the vis of the anchors
function HostelBar:ToggleAnchor()
	if self.anchors.Default:IsVisible() then
		self:HideAnchors()
	else
		self:ShowAnchors()
	end
end

--[[--------------------------------------------------------------------------------
  GUI Controls
-----------------------------------------------------------------------------------]]
-- Hides a title if it has no more bars running
-- group is either Default/Casts/Cooldowns/Buffs/Durations
-- regedBar is the bar this is called from, this is checked because the bar is unregistered after this method is called so we exclude this bar
function HostelBar:RefreshTitles(group, regedBar)
	if not group then return end

	for k,v in candy.var.handlers do
		if HostelBar:IsCandyBarRegisteredWithGroup(k, "HostelBar"..group) and k ~= regedBar then
			if(v.frame:IsShown()) then return end
		end
	end
	self.titles[group]:Hide()
end
-- Shows all titles
function HostelBar:ShowTitles()
		for k, v in self.titles do
			v:Show()
		end
		self:Debug("Titles shown")
end
-- Hides all titles
function HostelBar:HideTitles()
		for k, v in self.titles do
			v:Hide()
		end
		self:Debug("Titles hidden")
end
-- Shows all anchors
function HostelBar:ShowAnchors()
		for k, v in self.anchors do
			v:Show()
		end
		self:Debug("Anchors shown")
end
-- Hides all anchors
function HostelBar:HideAnchors()
		for k, v in self.anchors do
			v:Hide()
		end
		self:Debug("Anchors hidden")
end
--[[--------------------------------------------------------------------------------
  GUI Constructors
-----------------------------------------------------------------------------------]]

-- Creates the anchor frames
function HostelBar:CreateAnchor(group, yoff, text, cRed, cGreen, cBlue)
	local f = CreateFrame("Button", nil, UIParent)
	f:ClearAllPoints()
	f:SetWidth(200)
	f:SetHeight(25)
	
	f.owner = self
	
	if self.db.profile.positions[group].x and self.db.profile.positions[group].y then
		f:SetPoint("TOPLEFT", UIParent, "TOPLEFT", self.db.profile.positions[group].x, self.db.profile.positions[group].y)
	else
		f:SetPoint("TOP", UIErrorsFrame, "BOTTOM", 0, yoff)
	end

	f:SetScript("OnDragStart", function() this:StartMoving() end )
	f:SetScript("OnDragStop",
		function()
			this:StopMovingOrSizing()
			local _,_,_,x, y = this:GetPoint()
			x,y = math.floor(x), math.floor(y)
			this.owner.db.profile.positions[group].x = x
			this.owner.db.profile.positions[group].y = y
        end)


	f:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background",
                                            edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
                                            tile = false, tileSize = 16, edgeSize = 16,
                                            insets = { left = 5, right =5, top = 5, bottom = 5 }})
	f:SetBackdropColor(cRed,cGreen,cBlue,.6)
	f:SetMovable(true)
	f:RegisterForDrag("LeftButton")

	f.Text = f:CreateFontString(nil, "OVERLAY")
	f.Text:SetFontObject(GameFontNormalSmall)
	f.Text:ClearAllPoints()
	f.Text:SetTextColor(1, 1, 1, 1)
	f.Text:SetWidth(200)
	f.Text:SetHeight(25)
	f.Text:SetPoint("TOPLEFT", f, "TOPLEFT")
	f.Text:SetJustifyH("CENTER")
	f.Text:SetJustifyV("MIDDLE")
	f.Text:SetText(text)
	
	f:Hide()

	return f
end

-- Creates the titles
function HostelBar:CreateTitle(text, pframe, cRed, cGreen, cBlue)
	local f = CreateFrame("Button",nil,UIParent)
	f:ClearAllPoints()
	f:SetWidth(150)
	f:SetHeight(30)

	f:SetPoint("CENTER", pframe, "CENTER", 0,0)

	f.Text = f:CreateFontString(nil, "OVERLAY")
	f.Text:SetFont(L["Fonts\\skurri.ttf"], 20, "THICKOUTLINE")
	f.Text:ClearAllPoints()
	f.Text:SetTextColor(cRed,cGreen,cBlue, 1)
	f.Text:SetWidth(200)
	f.Text:SetHeight(25)
	f.Text:SetPoint("TOPLEFT", f, "TOPLEFT")
	f.Text:SetJustifyH("CENTER")
	f.Text:SetJustifyV("MIDDLE")
	f.Text:SetText(text)
	
	f:Hide()
	
	return f
end
-- Version & Date
local MAJOR_VERSION = "2.0"
local MINOR_VERSION = tonumber((string.gsub("$Revision: 16782 $", "^.-(%d+).-$", "%1")))

-- Libs
local metro = AceLibrary("Metrognome-2.0")

local L = AceLibrary("AceLocale-2.2"):new("Paparazzi")
Paparazzi = AceLibrary("AceAddon-2.0"):new("AceDB-2.0", "AceConsole-2.0")

-- Keybindings
BINDING_HEADER_PAPARAZZI = "Paparazzi"
BINDING_NAME_CLEAN_SCREENSHOT = L["Clean"]

-- About
local Paparazzi = Paparazzi
Paparazzi.title = "Paparazzi"
Paparazzi.version = MAJOR_VERSION .. "." .. MINOR_VERSION
Paparazzi.date = string.gsub("$Date: 2006-11-12 18:15:41 -0500 (Sun, 12 Nov 2006) $", "^.-(%d%d%d%d%-%d%d%-%d%d).-$", "%1")

-- Inititalize
	function Paparazzi:OnInitialize()
		self:RegisterDB("PaparazziDB")
		self:RegisterDefaults('profile', {
			dly = 0.8,
			qnt = 5
		})

		local args = {
			type="group",
			args = {
				delay = {
					name = 	L["Delay"], 
					type = 	"range",
					desc = 	L["Delay_Dsc"],
					get = 	function()
								return self.db.profile.dly
							end,
					set = 	function(v)
								self.db.profile.dly = v
								self.d = v
								metro:ChangeRate("Screen",self.d,"Show",self.d)
								metro:ChangeRate("Show2",((self.d *1.5) * self.q))
							end,
					min = 0.5,
					max = 60,
					step = 0.1
				},
				amount = {
					name = 	L["Amount"], 
					type = 	"range",
					desc = 	L["Amount_Dsc"],
					get = 	function()
								return self.db.profile.qnt
							end,
					set = 	function(v)
								self.db.profile.qnt = v
								self.q = v
								metro:ChangeRate("Show2",((self.d *1.5) * self.q))
							end,
					min = 1,
					max = 100,
					step = 1,
				},
				pc = {
					name = 	L["PC"], 
					type = 	"toggle",
					desc = 	string.format(L["Screen"],L["PC"]),
					get = 	function() return self.db.profile.PC end,
					set = 	function(v)
								self.db.profile.PC = v
							end,
				},
				own = {
					name = 	L["Own"], 
					type = 	"toggle",
					desc = 	string.format(L["Screen"],L["Own"]),
					get = 	function() return self.db.profile.Own end,
					set = 	function(v)
								self.db.profile.Own = v
							end,
				},
				pvp = {
					name = 	L["PvP"], 
					type = 	"toggle",
					desc = 	string.format(L["Screen"],L["PvP"]),
					get = 	function() return self.db.profile.PvP end,
					set = 	function(v)
								self.db.profile.PvP = v
							end,
				},

				guild = {
					name = 	L["Guild"], 
					type = 	"toggle",
					desc = 	string.format(L["Screen"],L["Guild"]),
					get = 	function() return self.db.profile.Guild end,
					set = 	function(v)
								self.db.profile.Guild = v
							end,
				},
				npc = {
					name = 	L["NPC"], 
					type = 	"toggle",
					desc = 	string.format(L["Screen"],L["NPC"]),
					get = 	function() return self.db.profile.NPC end,
					set = 	function(v)
								self.db.profile.NPC = v
							end,
				},
				reset = {
					name = L["Reset"], 
					type = "execute",
					desc = L["Reset_Dsc"],
					func = function()
							self:ResetDB("profile")
								self.d = self.db.profile.dly
								self.q = self.db.profile.qnt
								metro:ChangeRate("Screen",self.d,"Show",self.d)
								metro:ChangeRate("Show2",((self.d *1.5) * self.q))
							end				
				}
			}
		}
		self:RegisterChatCommand({ "/pap", "/paparazzi" }, args)
	end

-- OnEnable	
	function Paparazzi:OnEnable()
		self.d = self.db.profile.dly
		self.q = self.db.profile.qnt
		metro:Register("Show",self.Show,self.d,self)
		metro:Register("Show2",self.Show,((self.d *1.5) * self.q),self)
		metro:Register("Screen",self.Screen,self.d,self)
	end

-- OnDisable	
	function Paparazzi:OnDisable()
		metro:Unregister("Show","Show2","Screen")
	end

-- Screenshot functions	
	function Paparazzi:DoScreenie()
		self:CheckRunning()
		if show or show2 or scr then return end
		self:CheckToggles()
		HideUIPanel(UIParent)
		metro:Start("Show")
		TakeScreenshot()
	end
		
	function Paparazzi:DoAuto()
		self:CheckRunning()
		if show or show2 or scr then return end
		self:CheckToggles()
		HideUIPanel(UIParent)
		metro:Start("Show2")
		metro:Start("Screen", self.q)
	end
  
	function Paparazzi:Show()
		ShowUIPanel(UIParent)
		metro:Stop("Show")
		metro:Stop("Show2")
		self:ToggleBack()
	end
	
	function Paparazzi:Screen()
		TakeScreenshot()
	end
	
	function Paparazzi:CheckRunning()		
		local _,_,show = metro:Status("Show")
		local _,_,show2 = metro:Status("Show2")
		local _,_,scr = metro:Status("Screen")
	end

	function Paparazzi:CheckToggles()
		self.PC	= GetCVar("UnitNamePlayer")
		self.NPC = GetCVar("UnitNameNPC")
		self.Guild = GetCVar("UnitNamePlayerGuild")
		self.Own = GetCVar("UnitNameOwn")
		self.PvP = GetCVar("UnitNamePlayerPVPTitle")

		if self.db.profile.PC and self.PC == "1" then SetCVar("UnitNamePlayer", 0) self.hidePC = true end
		if self.db.profile.Own and self.Own == "1" then SetCVar("UnitNameOwn", 0) self.hideOwn = true end
		if self.db.profile.NPC and self.NPC == "1" then SetCVar("UnitNameNPC", 0) self.hideNPC = true end
		if self.db.profile.Guild and self.Guild == "1" then SetCVar("UnitNamePlayerGuild", 0) self.hideGuild = true end
		if self.db.profile.PvP and self.PvP == "1" then SetCVar("UnitNamePlayerPVPTitle", 0) self.hidePvP = true end
	end
	
	function Paparazzi:ToggleBack()
		if self.hidePC then SetCVar("UnitNamePlayer", self.PC) end
		if self.hideOwn then SetCVar("UnitNameOwn", self.Own) end	
		if self.hideNPC then SetCVar("UnitNameNPC", self.NPC) end
		if self.hideGuild then SetCVar("UnitNamePlayerGuild", self.Guild) end
		if self.hidePvP then SetCVar("UnitNamePlayerPVPTitle", self.PvP) end
		self.hidePC, self.hideNPC, self.hideGuild, self.hidePvP, self.hideOwn = nil, nil, nil, nil, nil
	end
	
-- The End
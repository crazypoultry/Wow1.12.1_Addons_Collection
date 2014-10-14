--[[---------------------------------------------------------------------------------
  MiniGroup2.h
  
  Ace Rewrite of MiniGroup
  Modded for healers.
------------------------------------------------------------------------------------]]

--[[--------------------------------------------------------------------------------
  << Thanks to Sairén@Windforce@EU-Malfurion
  << sairen@wind-force.net
  << www.wind-force.net
  
	Changes marked with --sai
-----------------------------------------------------------------------------------]]

--[[---------------------------------------------------------------------------------
  Index values
------------------------------------------------------------------------------------]]

-- version: if this number gets changed, MG will reset its configuration
local MiniGroup2Version = "0.6.h"

-- default colors for frames
local defaultColors  = {
	r = TOOLTIP_DEFAULT_BACKGROUND_COLOR.r,
	g = TOOLTIP_DEFAULT_BACKGROUND_COLOR.g,
	b = TOOLTIP_DEFAULT_BACKGROUND_COLOR.b,
	a = 1 }
local defaultTColors = {
	r = TOOLTIP_DEFAULT_BACKGROUND_COLOR.r,
	g = TOOLTIP_DEFAULT_BACKGROUND_COLOR.g,
	b = TOOLTIP_DEFAULT_BACKGROUND_COLOR.b,
	a = 1 }
local defaultBColors = {
	r = TOOLTIP_DEFAULT_COLOR.r,
	g = TOOLTIP_DEFAULT_COLOR.g,
	b = TOOLTIP_DEFAULT_COLOR.b }

-- used for hex conversion	
local MG_HexTable = {
	["a"] = 10,
	["b"] = 11,
	["c"] = 12,
	["d"] = 13,
	["e"] = 14,
	["f"] = 15
}

local MG_TargetReaction = {
	r = 0,
	g = 0,
	b = 0
}
local MG_ToTReaction = {
	r = 0,
	g = 0,
	b = 0
}

-- Configuration constants
local originalborder = 1
local thinborder =     2
local thickborder =    3
local text =           4
local background =     5
		
local AuraStyle_OneLine   	= 1
local AuraStyle_TwoLines 	= 2
local AuraStyle_OneDebuff   = 3
local AuraStyle_TwoDebuff 	= 4
local AuraStyle_Hide        = 5

local AuraPos_Above =  1
local AuraPos_Below =  2
local AuraPos_Right =  3
local AuraPos_Left =   4
local AuraPos_Inside = 5
local AuraPos_Auto = 6

local FrameGrowth_Down =  1
local FrameGrowth_Up =    2
local FrameGrowth_Right = 3
local FrameGrowth_Left =  4

local StatusTextStyle_Absolute =   1
local StatusTextStyle_Percent =    2
local StatusTextStyle_Difference = 3
local StatusTextStyle_Hide =       4
--sai new smart style
local StatusTextStyle_Smart =      5

local BarTextStyle_Absolute =   1
local BarTextStyle_Percent =    2
local BarTextStyle_Difference = 3
local BarTextStyle_Hide =       4
--sai new smart style
local BarTextStyle_Smart =      5

local PetGrouping_WithOwner     = 1
local PetGrouping_NotGrouped    = 2

local CastPartyOverrideMouse = { 
	[1] = "LeftButton",
	[2] = "RightButton",
	[3] = "MiddleButton",
	[4] = "CastPartySetting",
}

-- table of unitname for each unitframe
local UnitFrames = {
	["MGplayer"] = "player",
	["MGpet"] = "pet",
	["MGtarget"] = "target",
	["MGraid1"] = "raid1",
	["MGtargettarget"] = "targettarget"
}

-- dynamic dimention values
 MGFrames = { }
MGFrames["MGplayer"] = {
	FrameHeight = 46,
	FrameWidth = 1,
	BarWidth = 152,
	XPBarHeight = 4,
	HealthBarHeight = 6,
	ManaBarHeight = 6,
	Background = 1
}
MGFrames["MGpet"] = {
	FrameHeight = 46,
	FrameWidth = 1,
	BarWidth = 152,
	XPBarHeight = 4,
	HealthBarHeight = 6,
	ManaBarHeight = 6,
	Background = 1
}
MGFrames["MGparty"] = {
	FrameHeight = 46,
	FrameWidth = 1,
	BarWidth = 152,
	XPBarHeight = 4,
	HealthBarHeight = 6,
	ManaBarHeight = 6,
	Background = 1
}
MGFrames["MGpartypet"] = {
	FrameHeight = 46,
	FrameWidth = 1,
	BarWidth = 152,
	XPBarHeight = 4,
	HealthBarHeight = 6,
	ManaBarHeight = 6,
	Background = 1
}
MGFrames["MGraid"] = {
	FrameHeight = 46,
	FrameWidth = 1,
	BarWidth = 152,
	XPBarHeight = 4,
	HealthBarHeight = 6,
	ManaBarHeight = 6,
	Background = 1
}
MGFrames["MGraidpet"] = {
	FrameHeight = 46,
	FrameWidth = 1,
	BarWidth = 152,
	XPBarHeight = 4,
	HealthBarHeight = 6,
	ManaBarHeight = 6,
	Background = 1
}
MGFrames["MGtarget"] = {
	FrameHeight = 46,
	FrameWidth = 1,
	BarWidth = 152,
	XPBarHeight = 4,
	HealthBarHeight = 6,
	ManaBarHeight = 6,
	Background = 1
}
MGFrames["MGtargettarget"] = {
	FrameHeight = 46,
	FrameWidth = 1,
	BarWidth = 152,
	XPBarHeight = 4,
	HealthBarHeight = 6,
	ManaBarHeight = 6,
	Background = 1
}

local MG_FACTION_BAR_COLORS = {
	[1] = {r = 226/255, g = 45/255, b = 75/255},
	[2] = {r = 226/255, g = 45/255, b = 75/255},
	[3] = {r = 0.75, g = 0.27, b = 0},
	[4] = {r = 1, g = 1, b = 34/255},
	[5] = {r = 0.2, g = 0.8, b = 0.15},
	[6] = {r = 0.2, g = 0.8, b = 0.15},
	[7] = {r = 0.2, g = 0.8, b = 0.15},
	[8] = {r = 0.2, g = 0.8, b = 0.15},
};

local MG_HealthBar = {}
MG_HealthBar["r1"] = 0.2
MG_HealthBar["g1"] = 0.8
MG_HealthBar["b1"] = 0.15

local MG_HealthBarBG = {}
MG_HealthBarBG["r1"] = 0.20
MG_HealthBarBG["g1"] = 0.8
MG_HealthBarBG["b1"] = 0.15
 
local MG_ManaBar = {}
MG_ManaBar[0] = { r1 = 48/255, g1 = 113/255, b1 = 191/255} -- Mana
MG_ManaBar[1] = { r1 = 226/255, g1 = 45/255, b1 = 75/255} -- Rage
MG_ManaBar[2] = { r1 = 255/255, g1 = 178/255, b1 = 0} -- Focus
MG_ManaBar[3] = { r1 = 1.00, g1 = 1.00, b1 = 34/255} -- Energy
MG_ManaBar[4] = { r1 = 0.00, g1 = 1.00, b1 = 1.00} -- Happiness

local MG_classes = {
      [1] = "Paladin",
      [2] = "Priest",
      [3] = "Druid",
      [4] = "Hunter",
      [5] = "Warrior",
      [6] = "Warlock",
      [7] = "Rogue",
      [8] = "Mage",
}

local comboGFX = 1

local raidmenuID = 0

local MG_AnchorConnect = {}

local MG_AuraTable = {}

local MG_raidunits = {}		

-- list of units that have unit_combat numbers displaying
local FeedbackTable = {}

-- table that gets filled with class spells for the aura filter, taken from castparty ages ago :-)
local _best_spell_ids = {} 

-- used to determine how long the right button have been clicked
local MGclickTime = 0

-- for target of target
local timeSinceLastUpdate = 0

local TimeSinceLastScaleUpdate = 0
	
-- You get an error if you try to show blizzard frames if they're already shown. This is used to avoid that
local BlizzOptionUsedYet = 0

-- checks if spelldata is loaded yet
local spelldataloaded = 0

-- Are we in a raid or not?
local InsideRaid = 0

-- did we load the settings from the DB into variables? To save memory from functions that read options often
local settings_loaded = 0

-- did we load the scale yet?
local scale_loaded = 0

local anchoradjustment = 5	

local MG_spelldataloaded = 0

local dbname = "MiniGroup2DB"

local ScaleValue = 1

local MGSelectedFrame = nil

local MGCastingFrame = nil

local MGCast_UpdateInterval = 0.05;

local MGCast_TimeSinceLastUpdate = 0;

local MGRange_UpdateInterval = 0.5;

local MGRange_TimeSinceLastUpdate = 0;

local MGDirtyFramesUpdate = 0;
local MGFramesAreDirty = true;

local MGFSR_timer = 0;
local MGFSR_oldMana = 0;
local MGFSR_currMana = 0;
local MGFSR_lastspellstoptime = 0;


--[[---------------------------------------------------------------------------------
  Class Setup
------------------------------------------------------------------------------------]]

MiniGroup2 = AceAddon:new({
	name		  = MINIGROUP2.NAME,
	description   = MINIGROUP2.DESCRIPTION,
	version		  = MiniGroup2Version,
	releaseDate   = "01-11-2006",
	aceCompatible = "102",
	author		  = "andreasg & UniRing",
	email		  = "andreas@nabolaget.org | uniring2k@teleline.es",
	website		  = "http://www.wowace.com | http://www.uniring.net",
	category	  = "raid",
	db			  = AceDatabase:new(dbname),
	defaults	  = MINIGROUP2_DEFAULT_OPTIONS,
	cmd			  = AceChatCmd:new(MINIGROUP2.COMMANDS, MINIGROUP2.CMD_OPTIONS),
	
	Initialize = function(self)
		self.GetOpt =	function(var) 
							local option = self.db:get(self.profilePath,var)
							if option ~= nil then
								return option
							else
								return 0
							end
						end
		self.SetOpt = function(var,val) self.db:set(self.profilePath,var,val)	end
		
		
		self.TogOpt = 	function(var)
							local option = self.db:get(self.profilePath,var)
							if option == 0 then
								self.db:set(self.profilePath,var,1)
							else	
								self.db:set(self.profilePath,var,0)
							end
							return self.db:get(self.profilePath,var)
						end
		
		
		
		self.TogMsg = function(text, val) self.cmd:status(text, val, ACEG_MAP_ONOFF) end
	end,

	Enable = function(self)
		self.cmd:msg(MINIGROUP2.ENABLED)
		self:Setup()
		
		self:ACE_PROFILE_LOADED()
		self:RegisterEvent("ACE_PROFILE_LOADED")
		self:RegisterEvent("ACE_ADDONS_LOADED")
		self:RegisterEvents()	
	end,
	
	ACE_PROFILE_LOADED = function(self)
		if self.GetOpt("Version") == nil then
			self.db:reset(self.profilePath,self.defaults)
			return
		end
		if ( self.GetOpt("Version") ~= MiniGroup2Version ) then
			self.cmd:msg("New version "..MiniGroup2Version..": options reset from "..self.GetOpt("Version").."!")
			self:Reset()
		end
		self.SetOpt("Version",MiniGroup2Version )
		self.cmd:msg("Options loaded from version: "..self.GetOpt("Version").."!")
	
		defaultTColors = self.GetOpt("TargetFrameColors")
		defaultColors = self.GetOpt("PartyFrameColors")	
		MG_AnchorConnect = self.GetOpt("Anchors", MG_AnchorConnect)	
		MiniGroup2:ApplySettings()
	end,
	
	Reset = function(self)
		self.db:reset(self.profilePath,self.defaults)
		self.SetOpt("Version",MiniGroup2Version )
	end,
	
	Setup = function(self)
		if UnitFactionGroup("player") == "Horde" then
			MG_classes[1] = "Shaman"
		else
			MG_classes[1] = "Paladin"	
		end
		
		UnitPopupMenus["MGRAID"] = {  "WHISPER", "RAID_LEADER", "RAID_PROMOTE", "RAID_DEMOTE", "RAID_REMOVE", "TRADE", "FOLLOW", "CANCEL" };
		UnitPopupMenus["MGPARTY"] = { "WHISPER", "PROMOTE", "LOOT_PROMOTE", "UNINVITE", "TRADE", "FOLLOW", "DUEL", "CANCEL" };
		
		self:UpdateDynamicThemes()
	end,
	
	Disable = function(self)
		self.cmd:msg(MINIGROUP2.DISABLED)
	end,
	
	ACE_ADDONS_LOADED = function(self)		
	end,

	--[[---------------------------------------------------------------------------------
	Events
	------------------------------------------------------------------------------------]]
	RegisterEvents = function(self)
		self:RegisterEvent("PLAYER_LEAVING_WORLD","PlayerLeavingWorld")			
		self:Hook("ReputationWatchBar_Update", "PlayerXPUpdate")
		MiniGroup2:PlayerEnteringWorld()
	end,
	
	PlayerLeavingWorld = function(self)
		self:RegisterEvent("PLAYER_ENTERING_WORLD","PlayerEnteringWorld")
		self:UnregisterEvent("PLAYER_LEAVING_WORLD")
	
			self:UnregisterEvent("UNIT_AURA")
			self:UnregisterEvent("UNIT_COMBAT")
			self:UnregisterEvent("UNIT_SPELLMISS")
			self:UnregisterEvent("UNIT_PVP_UPDATE")
			self:UnregisterEvent("PLAYER_FLAGS_CHANGED")
			self:UnregisterEvent("UNIT_NAME_UPDATE")
			self:UnregisterEvent("UNIT_LEVEL")
	
			self:UnregisterEvent("UNIT_PET")
			self:UnregisterEvent("UNIT_HAPPINESS")
			self:UnregisterEvent("UNIT_PET_EXPERIENCE")
	
			self:UnregisterEvent("PLAYER_ENTER_COMBAT")
			self:UnregisterEvent("PLAYER_LEAVE_COMBAT")
			self:UnregisterEvent("PLAYER_UPDATE_RESTING")
			self:UnregisterEvent("PLAYER_REGEN_ENABLED")
			self:UnregisterEvent("PLAYER_REGEN_DISABLED")
	
			self:UnregisterEvent("PLAYER_TARGET_CHANGED")
			self:UnregisterEvent("PLAYER_COMBO_POINTS")
			
			self:UnregisterEvent("RAID_ROSTER_UPDATE")
			
			self:UnregisterEvent("PARTY_MEMBERS_CHANGED")
			self:UnregisterEvent("PARTY_MEMBER_ENABLE")
			self:UnregisterEvent("PARTY_MEMBER_DISABLE")
			self:UnregisterEvent("PARTY_LEADER_CHANGED")
			self:UnregisterEvent("PARTY_LOOT_METHOD_CHANGED")
		
			self:UnregisterEvent("UNIT_HEALTH")
			self:UnregisterEvent("UNIT_MAXHEALTH")
			self:UnregisterEvent("UNIT_FOCUS")
			self:UnregisterEvent("UNIT_MAXFOCUS")	
			self:UnregisterEvent("UNIT_MANA")	
			self:UnregisterEvent("UNIT_MAXMANA")
			self:UnregisterEvent("UNIT_RAGE")
			self:UnregisterEvent("UNIT_ENERGY")
			self:UnregisterEvent("UNIT_MAXENERGY")	
			self:UnregisterEvent("UNIT_MAXRAGE")
			self:UnregisterEvent("UNIT_DISPLAYPOWER")
			
			self:UnregisterEvent("PLAYER_XP_UPDATE")
			self:UnregisterEvent("UPDATE_EXHAUSTION")
			self:UnregisterEvent("PLAYER_LEVEL_UP")
			self:UnregisterEvent("UPDATE_FACTION")	
	
			self:UnregisterEvent("PET_ATTACK_START")
			self:UnregisterEvent("PET_ATTACK_STOP")	
			
			self:UnregisterEvent("UNIT_FACTION")	
	
			self:UnregisterEvent("UNIT_CLASSIFICATION_CHANGED")
			self:UnregisterEvent("UNIT_DYNAMIC_FLAGS")
			self:UnregisterEvent("UNIT_FLAGS")
			
			self:UnregisterEvent("SPELLS_CHANGED")
			self:UnregisterEvent("PLAYER_FLAGS_CHANGED")	

			self:UnregisterEvent("SPELLCAST_START","UpdateSpellCastBar")
			self:UnregisterEvent("SPELLCAST_STOP","UpdateSpellCastBar")
			self:UnregisterEvent("SPELLCAST_FAILED","UpdateSpellCastBar")
			self:UnregisterEvent("SPELLCAST_INTERRUPTED","UpdateSpellCastBar")
			self:UnregisterEvent("SPELLCAST_DELAYED","UpdateSpellCastBar")

	end,
	
	PlayerEnteringWorld = function(self)
		MGplayer.inCombat = nil
		MGplayer.onHateList = nil
		local playerName = UnitName("player").." of "..MiniGroup2:Trim(GetCVar("realmName"));
		--self:ApplySettings()
		MGFSR_currMana = UnitMana("player");
		MG2_TIMER_FRAME:Show()
		self:PlayerUpdateStatus()
		self:RegisterEvent("PLAYER_LEAVING_WORLD","PlayerLeavingWorld")
		self:UnregisterEvent("PLAYER_ENTERING_WORLD")
	
			self:RegisterEvent("UNIT_AURA","AuraUpdate")
			self:RegisterEvent("UNIT_COMBAT","UnitCombat")
			self:RegisterEvent("UNIT_SPELLMISS","UnitSpellmiss")
			self:RegisterEvent("UNIT_PVP_UPDATE","UpdatePVP")
			self:RegisterEvent("PLAYER_FLAGS_CHANGED","UpdatePVP")
			self:RegisterEvent("UNIT_NAME_UPDATE","UpdateName")
			self:RegisterEvent("UNIT_LEVEL","UpdateClass")
	
			self:RegisterEvent("UNIT_PET","UpdatePet")
			self:RegisterEvent("UNIT_HAPPINESS","PetSetHappiness")
			self:RegisterEvent("UNIT_PET_EXPERIENCE","PetXPUpdate")
	
			self:RegisterEvent("PLAYER_ENTER_COMBAT","PlayerEnterCombat")
			self:RegisterEvent("PLAYER_LEAVE_COMBAT","PlayerLeaveCombat")
			self:RegisterEvent("PLAYER_UPDATE_RESTING","PlayerUpdateStatus")
			self:RegisterEvent("PLAYER_REGEN_ENABLED","PlayerRegenEnabled")
			self:RegisterEvent("PLAYER_REGEN_DISABLED","PlayerRegenDisabled")
	
			self:RegisterEvent("PLAYER_TARGET_CHANGED","UpdateTarget")
			self:RegisterEvent("PLAYER_COMBO_POINTS","UpdateComboPoints")
			
			self:RegisterEvent("RAID_ROSTER_UPDATE","UpdateRaid")
			
			self:RegisterEvent("PARTY_MEMBERS_CHANGED","UpdateParty")
			self:RegisterEvent("PARTY_MEMBER_ENABLE","UpdatePartyEnabled")
			self:RegisterEvent("PARTY_MEMBER_DISABLE","UpdatePartyEnabled")
			self:RegisterEvent("PARTY_LEADER_CHANGED", "UpdateLeader")
			self:RegisterEvent("PARTY_LOOT_METHOD_CHANGED","UpdateLoot")
		
			self:RegisterEvent("UNIT_HEALTH","StatusBarsUpdateHealth")
			self:RegisterEvent("UNIT_MAXHEALTH","StatusBarsUpdateHealth")
			self:RegisterEvent("UNIT_FOCUS","StatusBarsUpdateMana")
			self:RegisterEvent("UNIT_MAXFOCUS","StatusBarsUpdateMana")	
			self:RegisterEvent("UNIT_MANA","StatusBarsUpdateMana")	
			self:RegisterEvent("UNIT_MAXMANA","StatusBarsUpdateMana")
			self:RegisterEvent("UNIT_RAGE","StatusBarsUpdateMana")
			self:RegisterEvent("UNIT_ENERGY","StatusBarsUpdateMana")
			self:RegisterEvent("UNIT_MAXENERGY","StatusBarsUpdateMana")	
			self:RegisterEvent("UNIT_MAXRAGE","StatusBarsUpdateMana")
			self:RegisterEvent("UNIT_DISPLAYPOWER","StatusBarsUpdateMana")
			
			self:RegisterEvent("PLAYER_XP_UPDATE","PlayerXPUpdate")
			self:RegisterEvent("UPDATE_EXHAUSTION","PlayerXPUpdate")
			self:RegisterEvent("PLAYER_LEVEL_UP","PlayerXPUpdate")
			self:RegisterEvent("UPDATE_FACTION","PlayerXPUpdate")	
	
			self:RegisterEvent("PET_ATTACK_START","PetAttack")
			self:RegisterEvent("PET_ATTACK_STOP","PetStop")	
			
			self:RegisterEvent("UNIT_FACTION","TargetCheckFaction")	
	
			self:RegisterEvent("UNIT_CLASSIFICATION_CHANGED","UpdateClass")
			self:RegisterEvent("UNIT_DYNAMIC_FLAGS","TargetCheckFaction")
			self:RegisterEvent("UNIT_FLAGS","TargetCheckFaction")
			
			self:RegisterEvent("SPELLS_CHANGED","LoadSpellData")
			self:RegisterEvent("PLAYER_FLAGS_CHANGED","UpdatePVP")

			self:RegisterEvent("SPELLCAST_START","UpdateSpellCastBar_Start")
			self:RegisterEvent("SPELLCAST_STOP","UpdateSpellCastBar_Stop")
			self:RegisterEvent("SPELLCAST_FAILED","UpdateSpellCastBar_Stop")
			self:RegisterEvent("SPELLCAST_INTERRUPTED","UpdateSpellCastBar_Stop")
			self:RegisterEvent("SPELLCAST_DELAYED","UpdateSpellCastBar_Delay")

	end,
	
	--[[---------------------------------------------------------------------------------
	  Updates
	------------------------------------------------------------------------------------]]

	UpdateRangeBars = function()
		if (UnitName("target")) then
			if (MGplayer.onHateList) then
				MGRange_TimeSinceLastUpdate = MGRange_TimeSinceLastUpdate + arg1;
			else
				MGRange_TimeSinceLastUpdate = MGRange_TimeSinceLastUpdate + (arg1*2);
			end
		else
			MGRange_TimeSinceLastUpdate = MGRange_TimeSinceLastUpdate + (arg1/2);
		end
		if (MGRange_TimeSinceLastUpdate > MGRange_UpdateInterval) then
			for key, value in UnitFrames do
				if (UnitName("target") == UnitName(value) and IsActionInRange(MiniGroup2.OORSpell) == 0 and MiniGroup2.HideOORAlerts == 0) then				
					getglobal(key.."OOR"):SetTexture("Interface\\AddOns\\MiniGroup2\\Images\\oor.tga")
					getglobal(key.."OOR"):SetBlendMode("BLEND");
					getglobal(key.."OOR"):SetAlpha(0.2);
					getglobal(key.."OOR"):Show();
				elseif (UnitIsVisible(value) ~= 1 and MiniGroup2.HideNotHereAlerts == 0) then
					if (MiniGroup2.HideNotHereAlertsOffline == 1 and not UnitIsConnected(value)) then
						getglobal(key.."OOR"):Hide();
					else
						getglobal(key.."OOR"):SetTexture("Interface\\AddOns\\MiniGroup2\\Images\\nothere.tga")
						getglobal(key.."OOR"):SetBlendMode("BLEND");
						getglobal(key.."OOR"):SetAlpha(0.7);
						getglobal(key.."OOR"):Show();
					end
				else
					getglobal(key.."OOR"):Hide();
				end
			end
			MGRange_TimeSinceLastUpdate = 0;
		end
	end,

	UpdateCastingBars = function()
		if (MGCastingFrame ~= nil) then
		MGCast_TimeSinceLastUpdate = MGCast_TimeSinceLastUpdate + arg1;
		if (MGCast_TimeSinceLastUpdate > MGCast_UpdateInterval) then	
			local castbar = getglobal(MGCastingFrame:GetName() .. "_CastBar");
			if (castbar.casting) then
				local status = GetTime();
				if ( status > castbar.maxValue ) then
					status = castbar.maxValue
				end
				castbar:SetValue(status);
			end
			MGCast_TimeSinceLastUpdate = 0;
		end
		end
	end,

	UpdateSpellCastBar_Start = function()
		if (MiniGroup2.HideCastBars == 0) then
		if (MGSelectedFrame ~= nil) then
			if (UnitInRaid("player") and (string.find(MGSelectedFrame:GetName(),"party") ~= nil or string.find(MGSelectedFrame:GetName(),"player") ~= nil)) then
				local MGSelectedUnit = string.gsub(MGSelectedFrame:GetName(),"MG","");
				for i = 1,40 do
					if (UnitName("raid"..i) == UnitName(MGSelectedUnit)) then
						MGSelectedFrame = getglobal("MGraid"..i);
					end
				end
				if (MGSelectedFrame == nil) then MGSelectedFrame = getglobal("MGplayer"); end
			end
--			DEFAULT_CHAT_FRAME:AddMessage("SelectedFrame: " .. MGSelectedFrame:GetName() .. "_CastBar");
			local castbar = getglobal(MGSelectedFrame:GetName() .. "_CastBar");
			castbar:Show();
			castbar.startTime = GetTime();
			castbar.maxValue = castbar.startTime + (arg2 / 1000) - 0.2;
			castbar.casting = 1;
			castbar:SetMinMaxValues(castbar.startTime, castbar.maxValue);
			castbar:SetValue(castbar.startTime);
			castbar:SetStatusBarColor(MiniGroup2.CastBarR,MiniGroup2.CastBarG,MiniGroup2.CastBarB);
			MGCastingFrame = MGSelectedFrame;
		else
			local castbar = getglobal("MGtarget_CastBar");
			castbar:Show();
			castbar.startTime = GetTime();
			castbar.maxValue = castbar.startTime + (arg2 / 1000) - 0.2;
			castbar.casting = 1;
			castbar:SetMinMaxValues(castbar.startTime, castbar.maxValue);
			castbar:SetValue(castbar.startTime);
			castbar:SetStatusBarColor(MiniGroup2.CastBarR,MiniGroup2.CastBarG,MiniGroup2.CastBarB);
			MGCastingFrame = getglobal("MGtarget");
		end
		end
	end,

	UpdateSpellCastBar_Delay = function()
		if (MGCastingFrame ~= nil) then
			local castbar = getglobal(MGCastingFrame:GetName() .. "_CastBar");
			castbar.startTime = castbar.startTime + (arg1 / 1000);
			castbar.maxValue = castbar.maxValue + (arg1 / 1000);
			castbar:SetMinMaxValues(castbar.startTime, castbar.maxValue);
		end
	end,

	UpdateFSR = function()
		MGFSRTimer = MGFSRTimer + arg1;
		if (MGFSRTimer > 5) then
			MG2_FSR_TIMER_FRAME:Hide();
			-- DEFAULT_CHAT_FRAME:AddMessage("You are now out of the FSR.");
			MGFSRTimer = 0;
			if (MGplayer.onHateList and MiniGroup2.HideOOFSR == 0) then
				MiniGroup2:LayoutBorderColors(0.4, 0.4, 1.0, 1.0)
			else
				MG_StatusTexture:Hide()
			end
		end
	end,

	UpdateSpellCastBar_FSR = function(self)
		MGFSR_oldMana = MGFSR_currMana;
		MGFSR_currMana = UnitMana("player");
		local deltamana = MGFSR_currMana - MGFSR_oldMana;
		if (MiniGroup2.HideFSR == 0) then
			if ( (deltamana < 0) and (abs(GetTime() - MGFSR_lastspellstoptime) < 0.5) ) then
				MG2_FSR_TIMER_FRAME:Show();
				if (MGFSRTimer == 0) then
					self:LayoutBorderTexture("Interface\\AddOns\\MiniGroup2\\Images\\MG_ThinBorders")
					MiniGroup2:LayoutBorderColors(1.0, 0, 0, 1.0)
					MG_StatusTexture:Show()
					-- DEFAULT_CHAT_FRAME:AddMessage("You are now into the FSR.");
				end
				MGFSRTimer = 0;
			end
		end
	end,

	UpdateSpellCastBar_Stop = function()
		MGFSR_lastspellstoptime = GetTime();
		if (MGCastingFrame ~= nil) then
--			DEFAULT_CHAT_FRAME:AddMessage("STOP: " .. MGCastingFrame:GetName() .. "_CastBar");
			local castbar = getglobal(MGCastingFrame:GetName() .. "_CastBar");
			castbar:Hide();
			castbar.casting = nil;
			MGCastingFrame = nil;
		end	
	end,

	UpdatePlayer = function(self)
		self:UpdateUnit("player")
	end,
	
	UpdatePet = function(self,unit)
		if unit == nil then
			unit = arg1
		end
		if string.find(unit,"party%a+%d+") or string.find(unit,"party%d+") then
			unit = string.gsub(unit,"pet","")
			unit = "partypet"..string.gsub(unit,"party","")
		elseif string.find(unit,"raid%a+%d+") or string.find(unit,"raid%d+") then
			unit = string.gsub(unit,"pet","")		
			unit = "raidpet"..string.gsub(unit,"raid","")
		elseif unit == "player" then
			unit = "pet"
		elseif unit == "target" or "targettarget" then
			return
		end
		
		if self:ShouldUnitBeVisible(unit,1) == 1 then
				if not getglobal("MG"..unit) then
					self:CreateUnitFrame(unit)
				end				
			self:StatusBarsUpdateHealth(unit)
			self:StatusBarsUpdateMana(unit)
			self:UpdateClass(unit)
			self:UpdateName(unit)
			if ( UnitExists(unit) ) then			
				self:UpdatePVP(unit)
				self:LabelsCheckLoot(unit)
				self:LabelsCheckLeader(unit)			
				self:AuraUpdate(unit)	
				if unit == "pet" then
					MGpet_Happiness:Hide()
					self:PetXPUpdate()
					self:PetSetHappiness()	
				end
			end
			if (string.find(unit,"partypet%d+") or unit == "pet") and ( not getglobal("MG"..unit):IsVisible()) then
				self:UnitGrouping()	
			elseif string.find(unit,"raidpet%d+") and ( not getglobal("MG"..unit):IsVisible()) then
				self:RaidUnitGrouping()
			end
			getglobal("MG"..unit):Show()
		elseif getglobal("MG"..unit) then
			if (string.find(unit,"partypet%d+") or unit == "pet") and (getglobal("MG"..unit):IsVisible()) then
				self:UnitGrouping()	
			elseif string.find(unit,"raidpet%d+") and (getglobal("MG"..unit):IsVisible()) then
				self:RaidUnitGrouping()
			end
			getglobal("MG"..unit):Hide()
		end
	end,
	
	UpdateParty = function(self)
		for partynum=1,4 do
			self:UpdateUnit("party"..partynum)
			self:UpdateUnit("partypet"..partynum)
		end
		self:UpdateLeader()
		self:UpdateLoot()
		self:UnitGrouping()
	end,
	
	UpdatePartyEnabled = function(self)
		for partynum=1,4 do
			self:UpdateUnit("party"..partynum)
		end
		self:UpdateLeader()
		self:UpdateLoot()
	end,
	
	UpdateRaid = function(self,argument1)
		if GetNumRaidMembers() > 0 then
			InsideRaid = 1
		else
			InsideRaid = 0
		end
		if ((not MG_raidunits) or (argument1 == 1) or InsideRaid == 0) then
		--	Compost:Erase(MG_raidunits)
			MG_raidunits = {}
		end	
		if MGraid1 then
			for i = 1,40 do
				--if UnitName("raid"..i) ~= MG_raidunits["raid"..i] or (MG_raidunits["raid"..i] == nil) then
					self:UpdateUnit("raid"..i)
					MG_raidunits["raid"..i] = UnitName("raid"..i)
				--end			
			end
			self:RaidUnitGrouping()
		end
		self:UpdateParty()
	end,
	
	UpdateUnit = function(self,unit)
		if not unit then unit = arg1 end
		if unit == "mouseover" then return end
		
		if not unit then return end
		
		if not MGraid1 and string.find(unit,"raid%a*%d+") then
			return
		end
		
		if string.find(unit,"pet") then
			self:UpdatePet(unit)
		else
			self:UpdatePet(unit)
			if self:ShouldUnitBeVisible(unit,1) == 1 then
				if not getglobal("MG"..unit) then
					self:CreateUnitFrame(unit)
				end			
				getglobal("MG"..unit):Show()
				if unit == "target" then
					self:TargetCheckFaction(unit)
				elseif unit == "targettarget" then
					self:TargetCheckFaction(unit)
				end
				self:UpdateClass(unit)
				self:UpdateName(unit)
				if ( UnitExists(unit) ) then			
					self:UpdatePVP(unit)
					self:LabelsCheckLoot(unit)
					self:LabelsCheckLeader(unit)			
					self:AuraUpdate(unit)		
					if unit == "player" then
						self:PlayerXPUpdate()
						self:PlayerUpdateStatus()	
					elseif unit == "pet" then
						MGpet_Happiness:Hide()
						self:PetXPUpdate()
						self:PetSetHappiness()	
					end
				end
			else
				if getglobal("MG"..unit) then
					getglobal("MG"..unit):Hide()
				end
			end
		end
		if getglobal("MG"..unit) then
			if getglobal("MG"..unit):IsVisible() then
				self:StatusBarsUpdateHealth(unit)
				self:StatusBarsUpdateMana(unit)
			end
		end
	end,
	
	UpdateTarget = function(self, unit)
		self:UpdateComboPoints()
		self:UpdateUnit("target")
		self:UpdateTargettarget()
		CloseDropDownMenus()	
		if ( UnitExists("target") ) then
			if ( UnitIsEnemy("target", "player") ) then
				PlaySound("igCreatureAggroSelect")
			elseif ( UnitIsFriend("player", "target") ) then
				PlaySound("igCharacterNPCSelect")
			else
				PlaySound("igCreatureNeutralSelect")
			end
			MG2_TIMER_FRAME:Show()
		else
			PlaySound("INTERFACESOUND_LOSTTARGETUNIT")
			CloseDropDownMenus()
			MG2_TIMER_FRAME:Hide()
		end
		self:LayoutCheckHighlight()
	end,
	
	UpdateComboPoints = function(self)
		local points = GetComboPoints()
			if comboGFX == 0 then
				MGtarget_ComboText:SetText(NORMAL_FONT_COLOR_CODE..points..FONT_COLOR_CODE_CLOSE.." "..MG_MSG_COMBOS)
			else
				MGtarget_ComboText:SetText("")
			end
			
			if points > 0 and comboGFX == 1 then
				MGtarget_Combo1:Show()
			else
				MGtarget_Combo1:Hide()
			end
			
			if points > 1 and comboGFX == 1 then
				MGtarget_Combo2:Show()
			else
				MGtarget_Combo2:Hide()
			end		
			
			if points > 2 and comboGFX == 1 then
				MGtarget_Combo3:Show()
			else
				MGtarget_Combo3:Hide()
			end
			
			if points > 3 and comboGFX == 1 then
				MGtarget_Combo4:Show()
			else
				MGtarget_Combo4:Hide()
			end
			
			if points > 4 and comboGFX == 1 then
				MGtarget_Combo5:Show()
			else
				MGtarget_Combo5:Hide()
			end
	end,
	
	UpdateTargettarget = function(self)
		self:UpdateUnit("targettarget")
	end,
	
	LayoutCheckHighlight = function(self)
		if ( MiniGroup2.HighlightSelected == 1 ) then
			MGSelectedFrame = nil;
			for key, value in UnitFrames do
				if ( UnitName("target") == UnitName(value) and UnitExists("target")) then
					if ( key ~= "MGtarget" and key ~= "MGtargettarget") then
						if not (getglobal(key.."Highlight") == nil) then
							getglobal(key.."Highlight"):Show()
							getglobal(key.."Highlight"):SetAlpha(0.7)
							MGSelectedFrame = getglobal(key);
						end				
					end
				else
					if ( key == "MGtarget" ) then
						--nothing
					elseif ( key == "MGplayer" ) then
						if ( (MiniGroup2.restingStyle == background and IsResting() )
						or   (MiniGroup2.aggroStyle == background and MGplayer.onHateList)
						or   (MiniGroup2.combatStyle == background and MGplayer.inCombat) ) then
							--keep showing
						else
							if not (getglobal(key.."Highlight") == nil) then
								getglobal(key.."Highlight"):Hide()
							end					
						end
					else
						if not (getglobal(key.."Highlight") == nil) then
							getglobal(key.."Highlight"):Hide()
						end				
					end
				end
			end
		else
			for key, value in UnitFrames do
				if ( key == "MGtarget" ) then
						 --nothing
				elseif ( key == "MGplayer" ) then
						if ( (MiniGroup2.RestingStyle == background and IsResting() )
						or   (MiniGroup2.AggroStyle == background and MGplayer.onHateList)
						or   (MiniGroup2.CombatStyle == background and MGplayer.inCombat) ) then
						 --keep showing
					else
						if not (getglobal(key.."Highlight") == nil) then
							getglobal(key.."Highlight"):Hide()
						end
					end
				else
					if not (getglobal(key.."Highlight") == nil) then
						getglobal(key.."Highlight"):Hide()
					end			
				end
			end
		end
	end,
	
	TargetCheckFaction = function(self,argument1)
		local unit = "target"
		local targetunit = unit
		local mgframe = nil
		local table = MG_TargetReaction
		if argument1 == "targettarget" then
			unit = "targettarget"
			table = MG_ToTReaction
		end
				
		mgframe = getglobal("MG"..unit)
		local r, g, b		
		local a = 0.5
		if ( UnitPlayerControlled(unit) ) then
			if ( UnitCanAttack(unit, "player") ) then
				-- Hostile players are red
				if ( not UnitCanAttack("player", unit) ) then
					r = MG_ManaBar[0].r1
					g = MG_ManaBar[0].g1
					b = MG_ManaBar[0].b1			
				else
					r = MG_ManaBar[1].r1
					g = MG_ManaBar[1].g1
					b = MG_ManaBar[1].b1			
				end
			elseif ( UnitCanAttack("player", unit) ) then
				-- Players we can attack but which are not hostile are yellow
					r = MG_ManaBar[3].r1
					g = MG_ManaBar[3].g1
					b = MG_ManaBar[3].b1
			elseif ( UnitIsPVP(unit) ) then
				-- Players we can assist but are PvP flagged are green
				--[[r = UnitReactionColor[6].r
				g = UnitReactionColor[6].g
				b = UnitReactionColor[6].b]]
				r = MG_HealthBar.r1
				g = MG_HealthBar.g1
				b = MG_HealthBar.b1			
			else
				-- All other players are blue (the usual state on the "blue" server)
				r = MG_ManaBar[0].r1
				g = MG_ManaBar[0].g1
				b = MG_ManaBar[0].b1
			end
			getglobal(mgframe:GetName().."_NameBackground"):SetVertexColor(r, g, b, a)
		elseif ( UnitIsTapped(unit) and not UnitIsTappedByPlayer(unit) ) or UnitIsDead(unit) then
			getglobal(mgframe:GetName().."_NameBackground"):SetVertexColor(0.5, 0.5, 0.5)
			r = 0.5
			g = 0.5
			b = 0.5
		else
			local reaction = UnitReaction(unit, "player")
			if ( reaction ) then
				if reaction == 5 or reaction == 6 or reaction == 7 then
					r = MG_HealthBar.r1
					g = MG_HealthBar.g1
					b = MG_HealthBar.b1
				elseif reaction == 4 then
					r = MG_ManaBar[3].r1
					g = MG_ManaBar[3].g1
					b = MG_ManaBar[3].b1
				elseif reaction == 1 or reaction == 2 or reaction == 3 then
					r = MG_ManaBar[1].r1
					g = MG_ManaBar[1].g1
					b = MG_ManaBar[1].b1			
				else
					r = UnitReactionColor[reaction].r
					g = UnitReactionColor[reaction].g
					b = UnitReactionColor[reaction].b
				end
				getglobal(mgframe:GetName().."_NameBackground"):SetVertexColor(r, g, b, a)
			else
				getglobal(mgframe:GetName().."_NameBackground"):SetVertexColor(0, 0, 1.0)
			end
		end
	
			table.r = r
			table.g = g
			table.b = b
			
		local factionGroup = UnitFactionGroup(unit)
		if MiniGroup2.HidePvPIcon == 0 then
			if ( UnitIsPVPFreeForAll(unit) ) then
				getglobal(mgframe:GetName().."_PVPIcon"):SetTexture("Interface\\TargetingFrame\\UI-PVP-FFA")
				getglobal(mgframe:GetName().."_PVPIcon"):Show()
			elseif ( factionGroup and UnitIsPVP(unit) ) then
				getglobal(mgframe:GetName().."_PVPIcon"):SetTexture("Interface\\TargetingFrame\\UI-PVP-"..factionGroup)
				getglobal(mgframe:GetName().."_PVPIcon"):Show()
			else
				getglobal(mgframe:GetName().."_PVPIcon"):Hide()
			end
		else
			getglobal(mgframe:GetName().."_PVPIcon"):Hide()
		end
		self:UpdateClass(unit)
		self:UpdatePVP(unit)
	end,
	
	OnUpdate = function(self,elapsed)
		timeSinceLastUpdate = timeSinceLastUpdate + elapsed
		if (MGFramesAreDirty) then MGDirtyFramesUpdate = MGDirtyFramesUpdate + elapsed; end
		if (timeSinceLastUpdate > 1.5) then 
			if UnitExists("targettarget") then
				self:UpdateTargettarget()
			else
				MGtargettarget:Hide()
			end
			timeSinceLastUpdate = 0
		end	
		if (MGFramesAreDirty and MGDirtyFramesUpdate > 6) then 
			MG2_TIMER_FRAME:Hide()
			self:ApplySettings();
			MGFramesAreDirty = false;
		end
	end,

	FrameType = function(self,unit)
		local string = string.gsub(unit,"%d+","")
		string = "MG"..string
		return string
	end,
	
	UpdateName = function(self,unit)
		if not unit then unit = arg1 end
		if not unit then
			return
		end
		if not getglobal("MG"..unit) then
			return
		end
		if unit == "mouseover" then return end
		
		local unitname = ""
		local textcolor = "|cff"..self:DecToHex(1,1,1)
		if string.find(unit,"pet") and MGFrames[self:FrameType(unit)].PetClassName == true and MiniGroup2[self:UnitCap(unit).."HideMana"] == 1 then
			unitname = self:UpdateClass(unit)
		else					
			if UnitExists(unit) then
				unitname = UnitName(unit)
			end
		
			if not UnitName(unit) then
				getglobal("MG"..unit.."_NameLabel"):SetText("Not available")
				return
			end
			
			if ( MiniGroup2.RaidColorName == 1 or (MGFrames[self:FrameType(unit)] and MGFrames[self:FrameType(unit)].RaidColorName == true)) and UnitExists(unit) and UnitIsPlayer(unit) then
				local raidColor = self:GetRaidColors(self:MemberUnitClass(unit))
				unitname = "|cff"..self:DecToHex(raidColor.r,raidColor.g,raidColor.b)..unitname
			else
				unitname = textcolor..unitname	
			end
			
			if unit == "targettarget" then
				if UnitExists("targettargettarget") and not (UnitName("player") == UnitName("targettargettarget")) then
		
		--			local currValue = UnitHealth("targettargettarget")
		--			local maxValue = UnitHealthMax("targettargettarget")
		--			local percValue = ""..((currValue/maxValue)*100)
		--			percValue = string.gsub(percValue, "(%d+)(%.)(%d+)", "%1").."%"
					local raidColor = self:GetRaidColors(self:MemberUnitClass("targettargettarget"))
		
					unitname = unitname..textcolor.."\[".."|cff"..self:DecToHex(raidColor.r,raidColor.g,raidColor.b)..UnitName("targettargettarget")..textcolor.."\]"			
		--			unitname = unitname.."\[".."|cff"..self:DecToHex(raidColor.r,raidColor.g,raidColor.b)..UnitName("targettargettarget")..textcolor.."\]"
		--			unitname = unitname.." ("..UnitName("targettargettarget").. " "..percValue..")"
				end
			end
		end
		
		local unitid = string.gsub(unit,"%a","")
		local bind = ""
		if ( MiniGroup2.ShowKeyBindings == 1 ) then
			if ( unit == "player" ) then
				if ( GetBindingKey("TARGETSELF") ) then
					bind = textcolor..GetBindingKey("TARGETSELF").."-"
				end
			elseif ( string.find(unit,"party") and not string.find(unit,"pet")) then
				if ( GetBindingKey("TARGETPARTYMEMBER"..unitid) ) then
					bind = textcolor..GetBindingKey("TARGETPARTYMEMBER"..unitid).."-"
				end
			end
		end
		getglobal("MG"..unit.."_NameLabel"):SetText(bind..unitname)
		
		self:UpdateClass(unit)
	end,
	
	UpdateClass = function(self,unit)
		if not unit then unit = arg1 end
		
		if not getglobal("MG"..unit) or not UnitExists(unit) then
			return ""
		end
		
		--DEFAULT_CHAT_FRAME:AddMessage(self:MemberUnitClass(unit).." "..unit)
		
		if unit == "player" then
			if ( MGplayer_XPBar.counter ) then
				return ""
			end
		elseif unit == "pet" then
			if ( MGpet_XPBar.counter ) then
				return ""
			end	
		end
		
		local color = GetDifficultyColor(UnitLevel(unit))
		
		local unitlevel = ""
		local ClassText = getglobal("MG"..unit.."_ClassText")
	
		local classstring = ""
		
		if UnitLevel(unit) then
			unitlevel = UnitLevel(unit)
		end
		if tonumber(unitlevel) == tonumber("-1") then
			unitlevel = "??"
		elseif tonumber(unitlevel) == tonumber(0) then
			unitlevel = ""
		end
		
		local levelcolor = "|cff"..self:DecToHex(color.r,color.g,color.b)
		local whitecolor = "|r"
		
		if unit == "target" then
			if (UnitIsTapped("target") and not UnitIsTappedByPlayer("target")) or not UnitCanAttack("player", unit) then
				levelcolor =  "|cff"..self:DecToHex(0.5,0.5,0.5)
			end
		end
		if not UnitIsFriend("player",unit) then
			unitlevel = levelcolor..unitlevel..whitecolor
		end
		if self:TargetGetMobType(unit) then
			unitlevel = self:TargetGetMobType(unit).." "..unitlevel
		end
		if ( MGPlayer and MiniGroup2.ShowClassText == 0 ) then
	
	--	elseif MiniGroup2.RaidColorName == 1 then
	--	elseif MiniGroup2.RaidColorName == 1 and UnitLevel(unit) == 60 then
	
		elseif ( UnitLevel(unit) and UnitCreatureFamily(unit) and not (unit == "target")) then
			classstring = (unitlevel.." "..UnitCreatureFamily(unit))
		elseif unit and string.find(unit, "pet") then
			local OwnerName = ""
			if UnitExists(string.gsub(unit, "pet", ""))then
				OwnerName = (OwnerName..UnitName(string.gsub(unit, "pet", "")))
			else
				OwnerName = string.gsub(unit, "pet", "")
			end
			if UnitInParty(string.gsub(unit, "pet", "")) or UnitInRaid(string.gsub(unit, "pet", "")) then
				local aposS = "'s"
				classstring = (OwnerName..aposS.." Pet")
			end
		elseif (( UnitLevel(unit) and UnitClass(unit) and not (unit == "target")) or (UnitIsPlayer("target") and UnitClass(unit))) then	
			if ( MiniGroup2.UsePartyRaidColors == 1 ) then
				local raidColor = self:GetRaidColors(self:MemberUnitClass(unit))
				classstring = (unitlevel.." |cff"..self:DecToHex(raidColor.r,raidColor.g,raidColor.b)..self:MemberUnitClass(unit,1).."|r")
			else
				classstring = (unitlevel.." "..self:MemberUnitClass(unit,1))
			end
		elseif ( UnitCreatureType(unit) ) then
			classstring = (unitlevel.." "..UnitCreatureType(unit))	
		else
			classstring = ""
		end
		if unit == "target" or unit == "targettarget" then
			if UnitRace(unit) and ClassText:GetText() then
				classstring = (classstring.." "..UnitRace(unit))
			end
			
			getglobal("MG"..unit):SetBackdropBorderColor(
			color.r,
			color.g,
			color.b,self:BorderAlpha(getglobal("MG"..unit)))
		end
		ClassText:SetText(classstring)
		return classstring
	end,
	
	TargetGetMobType = function(self,unit)
		local classification = UnitClassification(unit);
		if ( classification == "worldboss" ) then
			return "Boss";
		elseif ( classification == "rareelite"  ) then
			return "Rare-Elite";
		elseif ( classification == "elite"  ) then
			return "Elite";
		elseif ( classification == "rare"  ) then
			return "Rare";
		else
			return nil;
		end
	end,
	
	MemberUnitClass = function(self,unit,localized)
		if not getglobal("MG"..unit) then
			return
		end
		if ( UnitClass(unit) ) then
			lClass, eClass = UnitClass(unit)
			if ( localized ) then
				return lClass
			else
				return eClass
			end
		else
			return MG_MSG_UNKNOWNGENERIC
		end
	end,
	
	UpdatePVP = function(self,unit)
		if unit == "mouseover" then return end
		if not unit then unit = arg1 end
		if not getglobal("MG"..unit) then
			return
		end
		local icon = getglobal("MG"..unit.."_PVPIcon")
		local factionGroup = UnitFactionGroup(unit)
	
		if MiniGroup2.HidePvPIcon == 0 then
			if ( UnitIsPVPFreeForAll(unit) ) then
				icon:SetTexture("Interface\\TargetingFrame\\UI-PVP-FFA")
				icon:Show()	
			elseif ( factionGroup and UnitIsPVP(unit) ) then
				icon:SetTexture("Interface\\TargetingFrame\\UI-PVP-"..factionGroup)
				icon:Show()
			else
				icon:Hide()
			end
		else
			icon:Hide()
		end
		
		if self:UnitCap(unit) == "PartyPet" then
			local style = MiniGroup2.PartyPetFrameStyle
			if style == FrameStyle_Pet then
				icon:Hide()
			end
		end
		if self:UnitCap(unit) == "RaidPet" then
			local style = MiniGroup2.RaidPetFrameStyle
			if style == FrameStyle_Pet then
				icon:Hide()
			end
		end    
	end,
	
	LabelsCheckLeader = function(self,unit)
		if not unit then unit = arg1 end
		if unit == nil or not getglobal("MG"..unit) then
			return
		end
		if string.find(unit,"pet") then
			return
		end
		if not UnitExists(unit) then
			return
		end	
		if MiniGroup2.HideGroupIcons == 0 then
			if string.find(unit,"raid") then
				local name, rank, grp, lvl, lclass, class, zone, online, dead = GetRaidRosterInfo(string.gsub(unit,"%a",""))
				if rank == 2 and not string.find(unit,"pet") then
					getglobal("MG"..unit.."_LeaderIcon"):Show()
				else
					getglobal("MG"..unit.."_LeaderIcon"):Hide()
				end
			elseif string.find(unit,"party") then
				if ( GetPartyLeaderIndex() == tonumber(string.gsub(unit,"%a",""))) then
					getglobal("MG"..unit.."_LeaderIcon"):Show()
				else
					getglobal("MG"..unit.."_LeaderIcon"):Hide()
				end
			elseif unit == "player" then
				if ( IsPartyLeader() ) then
					MGplayer_LeaderIcon:Show()
				else
					MGplayer_LeaderIcon:Hide()
				end
			else
				getglobal("MG"..unit.."_LeaderIcon"):Hide()		
			end
		else
			getglobal("MG"..unit.."_LeaderIcon"):Hide()	
		end
	end,
	
	UpdateLeader = function(self)
		self:LabelsCheckLeader("player")
		for i=1,4 do
			self:LabelsCheckLeader("party"..i)
		end
		if MGraid1 then
			for i=1,40 do
				self:LabelsCheckLeader("raid"..i)
			end	
		end
	end,
	
	LabelsCheckLoot = function(self,unit)
		if not unit then unit = arg1 end
		if unit == nil or not getglobal("MG"..unit) then
			return
		end	
		if MiniGroup2.HideGroupIcons == 0 then
			if not string.find(unit,"raid") then
				local lootMethod, lootMaster = GetLootMethod()
				if lootMaster then
					if ( lootMaster == 0 and unit == "player" ) then
						getglobal("MG"..unit.."_MasterIcon"):Show()
					elseif lootMaster > 0 and unit ~= "player" then
						if ( (lootMaster == tonumber(string.gsub(unit,"%a",""))) and (not string.find(unit,"pet"))) then
							getglobal("MG"..unit.."_MasterIcon"):Show()
						end				
					else
						getglobal("MG"..unit.."_MasterIcon"):Hide()
					end
				else
					getglobal("MG"..unit.."_MasterIcon"):Hide()
				end
			else
				getglobal("MG"..unit.."_MasterIcon"):Hide()
			end
		else
			getglobal("MG"..unit.."_MasterIcon"):Hide()
		end
	end,
	
	UpdateLoot = function(self)
		self:LabelsCheckLoot("player")
		for i=1,4 do
			self:LabelsCheckLoot("party"..i)
		end
	end,
	
	PetAttack = function(self,combat)
	--	MGpet_ClassText:SetText("|cffff0000COMBAT!|r")
		MGpet.fadeStatus = 1
	end,
	
	PetStop = function(self,combat)
		MGpet.fadeStatus = 0
		MGpet_ClassText:SetAlpha(1)
			self:UpdateUnit("pet")
	end,
		
	PetOnUpdate = function(self,elapsed)
		if settings_loaded == 0 then
			return
		end	
		self:CombatFeedback_OnUpdate(elapsed)
		if not MGpet.attackModeCounter then
			MGpet.attackModeCounter = 0
		end
		if not MGpet.attackModeSign then
			MGpet.attackModeSign = -1
		end
		if ( MGpet.fadeStatus == 1 ) then
			local alpha = 255
			local counter = MGpet.attackModeCounter + elapsed
			local sign    = MGpet.attackModeSign
	
			if ( counter > 0.5 ) then
				sign = -sign
				MGpet.attackModeSign = sign
			end
			counter = mod(counter, 0.5)
			MGpet.attackModeCounter = counter
	
			if ( sign == 1 ) then
				alpha = (55  + (counter * 400)) / 255
			else
				alpha = (255 - (counter * 400)) / 255
			end
			MGpet_ClassText:SetAlpha(alpha)
		end
		if ( MGpet_XPBar.counter ) then
			if ( (GetTime() - MGpet_XPBar.counter ) > 8 ) then
				MGpet_XPBar.counter = nil
				self:UpdateUnit("pet")
			end
		end
	end,

	--[[---------------------------------------------------------------------------------
  Rest+combat indication
  ------------------------------------------------------------------------------------]]
  
	UnitCombat = function(self)
		if UnitName(arg1) == UnitName("targettarget") then
			if MiniGroup2.ShowTargettargetCombat == 1 then
				self:CombatFeedback_OnCombatEvent("targettarget", arg2, arg3, arg4, arg5)	
			end
			self:StatusBarsUpdateHealth("targettarget")
			self:StatusBarsUpdateMana("targettarget")
		end
		if MiniGroup2[("Show" .. self:UnitCap(arg1) .. "Combat")] == 1 then
			if string.find(arg1,"raid") and not MGraid1 then
				return
			end
			self:CombatFeedback_OnCombatEvent(arg1, arg2, arg3, arg4, arg5)
		end
	end,
	
	UnitSpellmiss = function(self)
		self:CombatFeedback_OnSpellMissEvent(arg1, arg2)
	end,
	
	CombatFeedback_OnCombatEvent = function(self,unit, event, flags, amount, type)		
		local feedbackText = getglobal("MG"..unit.."_HitIndicator")
		if not feedbackText then return end
		
		local fontHeight = 13
		local text = ""
		local r = 1.0
		local g = 1.0
		local b = 1.0
	
		if( event == "IMMUNE" ) then
			fontHeight = fontHeight * 0.75
			text = CombatFeedbackText[event]
		elseif ( event == "WOUND" ) then
			if ( amount ~= 0 ) then
				if ( flags == "CRITICAL" or flags == "CRUSHING" ) then
					fontHeight = fontHeight * 1.5
				elseif ( flags == "GLANCING" ) then
					fontHeight = fontHeight * 0.75
				end
				if ( type > 0 ) then
					r = 1.0
					g = 1.0
					b = 0.0
				end
				if UnitInParty(unit) or UnitInRaid(unit) then
					r = 1.0
					g = 0.0
					b = 0.0		
				end			
				text = "-"..amount
			elseif ( flags == "ABSORB" ) then
				fontHeight = fontHeight * 0.75
				text = CombatFeedbackText["ABSORB"]
			elseif ( flags == "BLOCK" ) then
				fontHeight = fontHeight * 0.75
				text = CombatFeedbackText["BLOCK"]
			elseif ( flags == "RESIST" ) then
				fontHeight = fontHeight * 0.75
				text = CombatFeedbackText["RESIST"]
			else
				text = CombatFeedbackText["MISS"]
			end
		elseif ( event == "BLOCK" ) then
			fontHeight = fontHeight * 0.75
			text = CombatFeedbackText[event]
		elseif ( event == "HEAL" ) then
			text = "+"..amount
			r = 0.0
			g = 1.0
			b = 0.0
			if ( flags == "CRITICAL" ) then
				fontHeight = fontHeight * 1.3
			end
		elseif ( event == "ENERGIZE" ) then
			text = amount
			r = 0.41
			g = 0.8
			b = 0.94
			if ( flags == "CRITICAL" ) then
				fontHeight = fontHeight * 1.3
			end
		else
			text = CombatFeedbackText[event]
		end
	
		feedbackText.feedbackStartTime = GetTime()
		
		local font = feedbackText:GetFont()
		feedbackText:SetFont(font,fontHeight,"OUTLINE")
		feedbackText:SetText(text)
		feedbackText:SetTextColor(r, g, b)
		feedbackText:SetAlpha(0.0)
		feedbackText:Show()
		feedbackText:SetPoint("CENTER","MG"..unit,"CENTER")
		FeedbackTable[unit] = "MG"..unit
		if unit ~= "player" and unit ~= "pet" then
			self:HookScript(getglobal(FeedbackTable[unit]), "OnUpdate", "CombatFeedback_OnUpdate")
		end
	end,
	
	CombatFeedback_OnUpdate = function(self,elapsed)
		local update = 0
		local maxalpha = 0.7
		local savedkey = nil
		local savedvalue = nil
		local unit = string.gsub(this:GetName(),"MG","")
		if FeedbackTable[unit] then
			update = 1
			savedkey = unit
			savedvalue = FeedbackTable[unit]
		end
		if update == 1 then
			local feedbackText = getglobal(savedvalue.."_HitIndicator")
			if ( feedbackText:IsVisible() ) then
				local elapsedTime = GetTime() - feedbackText.feedbackStartTime
				local fadeInTime = COMBATFEEDBACK_FADEINTIME
				if ( elapsedTime < fadeInTime ) then
					local alpha = maxalpha*(elapsedTime / fadeInTime)
					feedbackText:SetAlpha(alpha)
					return
				end
				local holdTime = COMBATFEEDBACK_HOLDTIME
				if ( elapsedTime < (fadeInTime + holdTime) ) then
					feedbackText:SetAlpha(maxalpha)
					return
				end
				local fadeOutTime = COMBATFEEDBACK_FADEOUTTIME
				if ( elapsedTime < (fadeInTime + holdTime + fadeOutTime) ) then
					local alpha = maxalpha - maxalpha*((elapsedTime - holdTime - fadeInTime) / fadeOutTime)
					feedbackText:SetAlpha(alpha)
					return
				end
				feedbackText:Hide()
				FeedbackTable[savedkey] = nil
				if savedkey ~= "player" and savedkey ~= "pet" then
					self:UnhookScript(getglobal(savedvalue), "OnUpdate")
				end
			end
		end
	end,
	
	
	PlayerEnterCombat = function(self)
		MGplayer.inCombat = 1
		self:PlayerUpdateStatus()
	end,
	
	PlayerLeaveCombat = function(self)
		MGplayer.inCombat = nil
		self:PlayerUpdateStatus()
	end,
	
	PlayerRegenEnabled = function(self)
		MGplayer.onHateList = nil
		self:PlayerUpdateStatus()
	end,
	
	PlayerRegenDisabled = function(self)
		MGplayer.onHateList = 1
		self:PlayerUpdateStatus()
	end,
	
	PlayerOnLoad = function(self)
		this:RegisterForClicks('LeftButtonUp', 'RightButtonUp', 'MiddleButtonUp', 'Button4Up', 'Button5Up');
		this.statusCounter = 0
		this.statusSign = -1
		
		--	MGplayer_XPBar:SetFrameLevel(MGplayer_XPBar_Rest:GetFrameLevel() + 1)	
	end,
	
	PlayerUpdateStatus = function(self)
		local originalborder = 1
		local thinborder =     2
		local thickborder =    3
		local text =           4
		local background =     5
	
		local CombatColor = 	{ r=1.0, g=0.0, b=0.0 }
		local AggroColor = 	{ r=1.0, g=0.5, b=0.0 }
		local RestColor = 	{ r=1.0, g=0.8, b=0.25 }
		local NormalColor =	{ r=1.0, g=0.82, b=0.0 }
	
		-- precedence for status indicators is (low to high): normal - resting - aggro - combat
		-- if a different element is used for each, all 3 may be shown simultaneously
		
		-- initialize to normal and change below for non-normal state
		BorderColor     = NormalColor
		BackgroundColor = NormalColor
		TextColor       = NormalColor
		
		borderFile = {
			[1] = "Interface\\AddOns\\MiniGroup2\\Images\\MG_Borders",
			[2] = "Interface\\AddOns\\MiniGroup2\\Images\\MG_ThinBorders",
			[3] = "Interface\\AddOns\\MiniGroup2\\Images\\MG_ThickBorders"
		}
		
		if ( IsResting() and UnitLevel("player") < 60 ) then
			if ( (MiniGroup2.restingStyle == originalborder)
			or   (MiniGroup2.restingStyle == thinborder)
			or   (MiniGroup2.restingStyle == thickborder) ) then
				BorderColor = RestColor
				self:LayoutBorderTexture(borderFile[MiniGroup2.restingStyle])
			elseif ( MiniGroup2.restingStyle == text ) then
				TextColor = RestColor
			elseif ( MiniGroup2.restingStyle == background ) then
				BackgroundColor = RestColor
			end
		end
	
		if ( MGplayer.onHateList ) then
			if ( (MiniGroup2.aggroStyle == originalborder)
			or   (MiniGroup2.aggroStyle == thinborder)
			or   (MiniGroup2.aggroStyle == thickborder) ) then
				BorderColor = AggroColor
				self:LayoutBorderTexture(borderFile[MiniGroup2.aggroStyle])
			elseif ( MiniGroup2.aggroStyle  == text ) then
				TextColor = AggroColor
			elseif ( MiniGroup2.aggroStyle  == background ) then
				BackgroundColor = AggroColor
			end
		end
		
		if ( MGplayer.inCombat ) then
			if ( (MiniGroup2.combatStyle == originalborder)
			or   (MiniGroup2.combatStyle == thinborder)
			or   (MiniGroup2.combatStyle == thickborder) ) then
				BorderColor = CombatColor
				self:LayoutBorderTexture(borderFile[MiniGroup2.combatStyle])
			elseif ( MiniGroup2.combatStyle == text ) then
				TextColor = CombatColor
			elseif ( MiniGroup2.combatStyle == background ) then
				BackgroundColor = CombatColor
			end
		end
	
		if (MGFSRTimer == 0 or MiniGroup2.HideFSR == 1) then
			if not (MGplayer.onHateList and MiniGroup2.HideOOFSR == 0) then
				MiniGroup2:LayoutBorderColors(BorderColor.r, BorderColor.g, BorderColor.b, 1.0)
			end
		end
		if ( BorderColor ~= NormalColor ) then
			MG_StatusTexture:Show()
		else
			if (MGFSRTimer == 0 or MiniGroup2.HideFSR == 1) then
				if (MGplayer.onHateList and MiniGroup2.HideOOFSR == 0) then
				else
					MG_StatusTexture:Hide()
				end
			end
		end
		
		MGplayerHighlight:SetVertexColor(BackgroundColor.r, BackgroundColor.g, BackgroundColor.b)
		if ( BackgroundColor ~= NormalColor ) then
			MGplayerHighlight:Show()
		else
			MGplayerHighlight:Hide()
		end
	end,
	
	PlayerOnUpdate = function(self,elapsed)
		if settings_loaded == 0 then
			return
		end
		self:CombatFeedback_OnUpdate(elapsed)
		if ( (MiniGroup2.restingStyle + MiniGroup2.restingFlash > 0)
		or   (MiniGroup2.aggroStyle   + MiniGroup2.aggroFlash   > 0)
		or   (MiniGroup2.combatStyle  + MiniGroup2.combatFlash  > 0) ) then
			local alpha = 255
			local counter = this.statusCounter + elapsed
			local sign    = this.statusSign
	
			if ( counter > 0.5 ) then
				sign = -sign
				this.statusSign = sign
			end
			counter = mod(counter, 0.5)
			this.statusCounter = counter
	
			if ( sign == 1 ) then
				alpha = (55  + (counter * 400)) / 255
			else
				alpha = (255 - (counter * 400)) / 255
			end
			
			local rest = 0
			local combat = 0
			local hate = 0
			if IsResting() and UnitLevel("player") < 60 then
				rest = 1
			end
			if ( MGplayer.onHateList ) then
				combat = 1
			end
			if ( MGplayer.inCombat ) then
				hate = 1
			end
			
			--set border
			if ( (MiniGroup2.restingStyle == originalborder and MiniGroup2.restingFlash == 1 and rest == 1) 
			or   (MiniGroup2.restingStyle == thickborder    and MiniGroup2.restingFlash == 1 and rest == 1) 
			or   (MiniGroup2.restingStyle == thinborder     and MiniGroup2.restingFlash == 1 and rest == 1) 
			or   (MiniGroup2.aggroStyle   == originalborder and MiniGroup2.aggroFlash   == 1 and hate == 1) 
			or   (MiniGroup2.aggroStyle   == thickborder    and MiniGroup2.aggroFlash   == 1 and hate == 1) 
			or   (MiniGroup2.aggroStyle   == thinborder     and MiniGroup2.aggroFlash   == 1 and hate == 1) 
			or   (MiniGroup2.combatStyle  == originalborder and MiniGroup2.combatFlash  == 1 and combat == 1)
			or   (MiniGroup2.combatStyle  == thickborder    and MiniGroup2.combatFlash  == 1 and combat == 1) 
			or   (MiniGroup2.combatStyle  == thinborder     and MiniGroup2.combatFlash  == 1 and combat == 1) ) then 
				MG_StatusTexture:SetAlpha(alpha)
			end
			
			--set name
			if ( (MiniGroup2.restingStyle == text and MiniGroup2.restingFlash == 1 and rest == 1) 
			or   (MiniGroup2.aggroStyle   == text and MiniGroup2.aggroFlash   == 1 and hate == 1) 
			or   (MiniGroup2.combatStyle  == text and MiniGroup2.combatFlash  == 1 and combat == 1) ) then
				MGplayer_NameLabel:SetAlpha(alpha)
			end
	
			--set background		
			if ( (MiniGroup2.restingStyle == background and MiniGroup2.restingFlash == 1 and rest == 1) 
			or   (MiniGroup2.aggroStyle   == background and MiniGroup2.aggroFlash   == 1 and hate == 1) 
			or   (MiniGroup2.combatStyle  == background and MiniGroup2.combatFlash  == 1 and combat == 1) ) then
				MGplayerHighlight:SetAlpha(alpha)
			end
			
		else
			MGplayer_NameLabel:SetAlpha(1.0)
			MG_StatusTexture:SetAlpha(1.0)
			MGplayerHighlight:SetAlpha(1.0)
		end
	
		if ( MGplayer_XPBar.counter ) then
			if ( (GetTime() - MGplayer_XPBar.counter ) > 8 ) then
				MGplayer_XPBar.counter = nil
				MiniGroup2:UpdateClass("player")
			end
		end
		
--		if ( MiniGroup2.UseMGScale == 1 or MiniGroup2.UseRaidScale == 1 ) then
			TimeSinceLastScaleUpdate = TimeSinceLastScaleUpdate + elapsed
			if ( TimeSinceLastScaleUpdate > 2 ) then
				self:UpdateScale()
				TimeSinceLastScaleUpdate = 0
			end
--		end
	end,
	
	GetSettings = function(self)
		settings_loaded = 1
	
		local table = self.GetOpt("Scaling")
		
		MiniGroup2.TargetShowHostile = self.GetOpt("TargetShowHostile")
		MiniGroup2.UseMGScale = table.UseMGScale
		MiniGroup2.UseRaidScale = table.UseRaidScale
	
		MiniGroup2.restingStyle = self.GetOpt("RestIndicator")
		MiniGroup2.restingFlash = self.GetOpt("FlashRestIndicator")
	
		MiniGroup2.aggroStyle = self.GetOpt("AggroIndicator")
		MiniGroup2.aggroFlash = self.GetOpt("FlashAggroIndicator")
	
		MiniGroup2.combatStyle = self.GetOpt("CombatIndicator")
		MiniGroup2.combatFlash = self.GetOpt("FlashCombatIndicator")	
		
		MiniGroup2.HidePvPIcon = self.GetOpt("HidePvPIcon")
		MiniGroup2.PartyPetFrameStyle = self.GetOpt("PartyPetFrameStyle")
		
		MiniGroup2.ShowPlayerXP = self.GetOpt("ShowPlayerXP")
		
		MiniGroup2.PetFrameStyle = self.GetOpt("PetFrameStyle")
		MiniGroup2.TargetFrameStyle = self.GetOpt("TargetFrameStyle")
		MiniGroup2.PlayerFrameStyle = self.GetOpt("PlayerFrameStyle")
		MiniGroup2.PartyPetFrameStyle = self.GetOpt("PartyPetFrameStyle")
		MiniGroup2.TargettargetFrameStyle = self.GetOpt("TargettargetFrameStyle")
		MiniGroup2.PartyFrameStyle = self.GetOpt("PartyFrameStyle")
		MiniGroup2.RaidPetFrameStyle = self.GetOpt("RaidPetFrameStyle")
		MiniGroup2.RaidFrameStyle = self.GetOpt("RaidFrameStyle")
		
		MiniGroup2.RaidGrouping = self.GetOpt("RaidGrouping")
		MiniGroup2.PlayerGrouping = self.GetOpt("PlayerGrouping")
		MiniGroup2.PetGrouping = self.GetOpt("PetGrouping")
		MiniGroup2.PartyGrouping = self.GetOpt("PartyGrouping")
		MiniGroup2.RaidPetGrouping = self.GetOpt("RaidPetGrouping")
		MiniGroup2.PartyPetGrouping = self.GetOpt("PartyPetGrouping")
		
		MiniGroup2.ShowKeyBindings = self.GetOpt("ShowKeyBindings")
		MiniGroup2.ShowClassText = self.GetOpt("ShowClassText")
		MiniGroup2.RaidColorName = self.GetOpt("RaidColorName")
		MiniGroup2.UsePartyRaidColors = self.GetOpt("UsePartyRaidColors")
		MiniGroup2.HideGroupIcons = self.GetOpt("HideGroupIcons")
	
		MiniGroup2.PlayerStatusTextStyle = self.GetOpt("PlayerStatusTextStyle")
		MiniGroup2.PlayerBarTextStyle = self.GetOpt("PlayerBarTextStyle")
	
		MiniGroup2.PetStatusTextStyle = self.GetOpt("PetStatusTextStyle")
		MiniGroup2.PetBarTextStyle = self.GetOpt("PetBarTextStyle")	
	
		MiniGroup2.PartyStatusTextStyle = self.GetOpt("PartyStatusTextStyle")
		MiniGroup2.PartyBarTextStyle = self.GetOpt("PartyBarTextStyle")
	
		MiniGroup2.PartyPetStatusTextStyle = self.GetOpt("PartyPetStatusTextStyle")
		MiniGroup2.PartyPetBarTextStyle = self.GetOpt("PartyPetBarTextStyle")
	
		MiniGroup2.RaidStatusTextStyle = self.GetOpt("RaidStatusTextStyle")
		MiniGroup2.RaidBarTextStyle = self.GetOpt("RaidBarTextStyle")
	
		MiniGroup2.RaidPetStatusTextStyle = self.GetOpt("RaidPetStatusTextStyle")
		MiniGroup2.RaidPetBarTextStyle = self.GetOpt("RaidPetBarTextStyle")
	
		MiniGroup2.TargetStatusTextStyle = self.GetOpt("TargetStatusTextStyle")
		MiniGroup2.TargetBarTextStyle = self.GetOpt("TargetBarTextStyle")
	
		MiniGroup2.TargettargetStatusTextStyle = self.GetOpt("TargettargetStatusTextStyle")
		MiniGroup2.TargettargetBarTextStyle = self.GetOpt("TargettargetBarTextStyle")
	
		MiniGroup2.RaidHideEverything = self.GetOpt("RaidHideEverything")
		MiniGroup2.RaidHideParty = self.GetOpt("RaidHideParty")
		MiniGroup2.AlwaysShowParty = self.GetOpt("AlwaysShowParty")
		MiniGroup2.AlwaysShowPartyPets = self.GetOpt("AlwaysShowPartyPets")
		MiniGroup2.AlwaysShowPet = self.GetOpt("AlwaysShowPet")
		
		MiniGroup2.PlayerFrameStyle = self.GetOpt("PlayerFrameStyle")
		MiniGroup2.PetFrameStyle = self.GetOpt("PetFrameStyle")
		MiniGroup2.PartyFrameStyle = self.GetOpt("PartyFrameStyle")
		MiniGroup2.PartyPetFrameStyle = self.GetOpt("PartyPetFrameStyle")
		MiniGroup2.RaidFrameStyle = self.GetOpt("RaidFrameStyle")
		MiniGroup2.RaidPetFrameStyle = self.GetOpt("RaidPetFrameStyle")
		MiniGroup2.TargetFrameStyle = self.GetOpt("TargetFrameStyle")
		MiniGroup2.TargettargetFrameStyle = self.GetOpt("TargettargetFrameStyle")
		
		local table = self.GetOpt("ShowBlizFrames")
		MiniGroup2.ShowBlizzTargetFrame = table.TargetFrame
		MiniGroup2.SmoothHealthBars = self.GetOpt("SmoothHealthBars")
		
		MiniGroup2.ShowPlayerCombat = self.GetOpt("ShowPlayerCombat")
		MiniGroup2.ShowPetCombat = self.GetOpt("ShowPetCombat")
		MiniGroup2.ShowPartyCombat = self.GetOpt("ShowPartyCombat")
		MiniGroup2.ShowPartyPetCombat = self.GetOpt("ShowPartyPetCombat")
		MiniGroup2.ShowRaidCombat = self.GetOpt("ShowRaidCombat")
		MiniGroup2.ShowRaidPetCombat = self.GetOpt("ShowRaidPetCombat")
		MiniGroup2.ShowTargetCombat = self.GetOpt("ShowTargetCombat")
		MiniGroup2.ShowTargettargetCombat = self.GetOpt("ShowTargettargetCombat")
	
		MiniGroup2.PlayerAuraDebuffC = self.GetOpt("PlayerAuraDebuffC")
		MiniGroup2.PetAuraDebuffC = self.GetOpt("PetAuraDebuffC")
		MiniGroup2.PartyAuraDebuffC = self.GetOpt("PartyAuraDebuffC")
		MiniGroup2.PartyPetAuraDebuffC = self.GetOpt("PartyPetAuraDebuffC")
		MiniGroup2.RaidAuraDebuffC = self.GetOpt("RaidAuraDebuffC")
		MiniGroup2.RaidPetAuraDebuffC = self.GetOpt("RaidPetAuraDebuffC")
		MiniGroup2.TargetAuraDebuffC = self.GetOpt("TargetAuraDebuffC")
		MiniGroup2.TargettargetAuraDebuffC = self.GetOpt("TargettargetAuraDebuffC")

		MiniGroup2.PlayerHideMana = self.GetOpt("PlayerHideMana")
		MiniGroup2.PetHideMana = self.GetOpt("PetHideMana")
		MiniGroup2.PartyHideMana = self.GetOpt("PartyHideMana")
		MiniGroup2.PartyPetHideMana = self.GetOpt("PartyPetHideMana")
		MiniGroup2.RaidHideMana = self.GetOpt("RaidHideMana")
		MiniGroup2.RaidPetHideMana = self.GetOpt("RaidPetHideMana")
		MiniGroup2.TargetHideMana = self.GetOpt("TargetHideMana")
		MiniGroup2.TargettargetHideMana = self.GetOpt("TargettargetHideMana")

		MiniGroup2.PlayerHideFrame = self.GetOpt("PlayerHideFrame")
		MiniGroup2.PetHideFrame = self.GetOpt("PetHideFrame")
		MiniGroup2.PartyHideFrame = self.GetOpt("PartyHideFrame")
		MiniGroup2.PartyPetHideFrame = self.GetOpt("PartyPetHideFrame")
		MiniGroup2.RaidHideFrame = self.GetOpt("RaidHideFrame")
		MiniGroup2.RaidPetHideFrame = self.GetOpt("RaidPetHideFrame")
		MiniGroup2.TargetHideFrame = self.GetOpt("TargetHideFrame")
		MiniGroup2.TargettargetHideFrame = self.GetOpt("TargettargetHideFrame")
		
		MiniGroup2.ShowPetXP = self.GetOpt("ShowPetXP")
		MiniGroup2.ShowEndcaps = self.GetOpt("ShowEndcaps")
		
		MiniGroup2.PlayerAuraPos = self.GetOpt("PlayerAuraPos")
		MiniGroup2.PlayerAuraStyle = self.GetOpt("PlayerAuraStyle")
		MiniGroup2.PlayerAuraFilter = self.GetOpt("PlayerAuraFilter")
		
		MiniGroup2.PetAuraPos = self.GetOpt("PetAuraPos")
		MiniGroup2.PetAuraStyle = self.GetOpt("PetAuraStyle")
		MiniGroup2.PetAuraFilter = self.GetOpt("PetAuraFilter")
		
		MiniGroup2.PartyAuraPos = self.GetOpt("PartyAuraPos")
		MiniGroup2.PartyAuraStyle = self.GetOpt("PartyAuraStyle")
		MiniGroup2.PartyAuraFilter = self.GetOpt("PartyAuraFilter")
		
		MiniGroup2.PartyPetAuraPos = self.GetOpt("PartyPetAuraPos")
		MiniGroup2.PartyPetAuraStyle = self.GetOpt("PartyPetAuraStyle")
		MiniGroup2.PartyPetAuraFilter = self.GetOpt("PartyPetAuraFilter")
		
		MiniGroup2.RaidAuraPos = self.GetOpt("RaidAuraPos")
		MiniGroup2.RaidAuraStyle = self.GetOpt("RaidAuraStyle")
		MiniGroup2.RaidAuraFilter = self.GetOpt("RaidAuraFilter")
		
		MiniGroup2.RaidPetAuraPos = self.GetOpt("RaidPetAuraPos")
		MiniGroup2.RaidPetAuraStyle = self.GetOpt("RaidPetAuraStyle")	
		MiniGroup2.RaidPetAuraFilter = self.GetOpt("RaidPetAuraFilter")	
		
		MiniGroup2.TargetAuraPos = self.GetOpt("TargetAuraPos")
		MiniGroup2.TargetAuraStyle = self.GetOpt("TargetAuraStyle")		
		MiniGroup2.TargetAuraFilter = self.GetOpt("TargetAuraFilter")		
	
		MiniGroup2.TargettargetAuraPos = self.GetOpt("TargettargetAuraPos")
		MiniGroup2.TargettargetAuraStyle = self.GetOpt("TargettargetAuraStyle")		
		MiniGroup2.TargettargetAuraFilter = self.GetOpt("TargettargetAuraFilter")		
	
		MiniGroup2.HighlightSelected = self.GetOpt("HighlightSelected")

		MiniGroup2.HideCastBars = self.GetOpt("HideCastBars")
		MiniGroup2.HideOORAlerts = self.GetOpt("HideOORAlerts")
		MiniGroup2.HideNotHereAlerts = self.GetOpt("HideNotHereAlerts")
		MiniGroup2.HideNotHereAlertsOffline = self.GetOpt("HideNotHereAlertsOffline")
		MiniGroup2.ShowBuffTimes = self.GetOpt("ShowBuffTimes")
		MiniGroup2.OORSpell = self.GetOpt("OORSpell")
		MiniGroup2.CastBarR = self.GetOpt("CastBarR")
		MiniGroup2.CastBarG = self.GetOpt("CastBarG")
		MiniGroup2.CastBarB = self.GetOpt("CastBarB")
		MiniGroup2.UseBigHealthFonts = self.GetOpt("UseBigHealthFonts")

		MiniGroup2.HideFSR = self.GetOpt("HideFSR")
		MiniGroup2.HideOOFSR = self.GetOpt("HideOOFSR")

		MiniGroup2.GroupSpace = self.GetOpt("GroupSpace")
	end,
	
	LayoutBorders = function(self,width,height)
		if width and height then
			MG_StatusTexture:SetHeight(height)
			MG_StatusTexture:SetWidth(width)
			MG_StatusTexture_LEFT:SetHeight(height - 24)
			MG_StatusTexture_RIGHT:SetHeight(height - 24)
			MG_StatusTexture_TOP:SetWidth(MG_StatusTexture:GetWidth()-24)
			MG_StatusTexture_BOTTOM:SetWidth(MG_StatusTexture:GetWidth()-24)	
		end
	end,
	
	LayoutBorderTexture = function(self,borderFile)
		MG_StatusTexture_TOPLEFT:SetTexture(borderFile)
		MG_StatusTexture_TOP:SetTexture(borderFile)
		MG_StatusTexture_TOPRIGHT:SetTexture(borderFile)
		MG_StatusTexture_LEFT:SetTexture(borderFile)
		MG_StatusTexture_RIGHT:SetTexture(borderFile)
		MG_StatusTexture_BOTTOMLEFT:SetTexture(borderFile)
		MG_StatusTexture_BOTTOM:SetTexture(borderFile)
		MG_StatusTexture_BOTTOMRIGHT:SetTexture(borderFile)
	end,
	
	LayoutBorderColors = function(self,r,g,b)
		MG_StatusTexture_TOPLEFT:SetVertexColor(r,g,b)
		MG_StatusTexture_TOP:SetVertexColor(r,g,b)
		MG_StatusTexture_TOPRIGHT:SetVertexColor(r,g,b)
		MG_StatusTexture_LEFT:SetVertexColor(r,g,b)
		MG_StatusTexture_RIGHT:SetVertexColor(r,g,b)
		MG_StatusTexture_BOTTOMLEFT:SetVertexColor(r,g,b)
		MG_StatusTexture_BOTTOM:SetVertexColor(r,g,b)
		MG_StatusTexture_BOTTOMRIGHT:SetVertexColor(r,g,b)
	end,
	
	--[[---------------------------------------------------------------------------------
	  Bars
	------------------------------------------------------------------------------------]]
				
	StatusBarsUpdateHealth = function(self,unit)
		if not unit then unit = arg1 end
		if unit == "mouseover" then return end
		if not getglobal("MG"..unit) then
			return
		end
		
		
		local currValue = UnitHealth(unit)
		local maxValue = UnitHealthMax(unit)
		local hpDiff = maxValue - currValue
		local showText,showDiff
		local barshowText,barshowDiff
		local style
		local barstyle
		local alive
		local percValue = ""..((currValue/maxValue)*100)
		percValue = string.gsub(percValue, "(%d+)(%.)(%d+)", "%1").."%"
		
		--DEFAULT_CHAT_FRAME:AddMessage(maxValue.." "..currValue)
		
		if ( not UnitExists(unit) or UnitIsDead(unit) or UnitIsGhost(unit) or not UnitIsConnected(unit) ) then
			alive = 0
			currValue = 0
			percValue = ""..((currValue/maxValue)*100)
			percValue = string.gsub(percValue, "(%d+)(%.)(%d+)", "%1").."%"
			getglobal("MG"..unit.."_HealthBar"):SetMinMaxValues(0,1)
			getglobal("MG"..unit.."_HealthBar"):SetValue(0)
		else
			if currValue > maxValue then
				maxValue = currValue
			end		
			alive = 1
			getglobal("MG"..unit.."_HealthBar"):SetMinMaxValues(0,maxValue)
		--	DEFAULT_CHAT_FRAME:AddMessage(UnitHealthMax(unit).. " "..unit)
			getglobal("MG"..unit.."_HealthBar"):SetValue(currValue)			
		end

		
		
		if maxValue == 0 or maxValue == nil then
			percValue = "0%"
		end
		
		style = MiniGroup2[(self:UnitCap(unit).."StatusTextStyle")]
		barstyle = MiniGroup2[(self:UnitCap(unit).."BarTextStyle")]
				
		if ( style ~= StatusTextStyle_Hide ) then
			showText = 1
		end
		if ( style == StatusTextStyle_Difference ) then
			showDiff = 1
		end
	
		if ( barstyle ~= BarTextStyle_Hide and alive == 1 ) then
			barshowText = 1
		end
		if ( barstyle == BarTextStyle_Difference ) then
			barshowDiff = 1
		end
			
		if ( showText ) then
--sai smart style (text)	
			if ( style == StatusTextStyle_Smart ) then
				
				if ( hpDiff > 0 ) then
					getglobal("MG"..unit.."_HealthText"):SetText("|cffff7f7f-"..hpDiff.."|r")
				else
					getglobal("MG"..unit.."_HealthText"):SetText("")
				end
--sai /
			elseif ( style == StatusTextStyle_Absolute or showDiff ) then
				local Telo = self:GetTelo(unit)
				if ( unit == "target" or unit == "targettarget") then
					if ( UnitIsUnit(unit,"pet") or UnitInParty(unit) or UnitIsUnit(unit, "player") or UnitInRaid(unit) ) then
						if ( showDiff and hpDiff > 0 ) then
							getglobal("MG"..unit.."_HealthText"):SetText(currValue.."|cffff7f7f-"..hpDiff.."|r")
						else
							getglobal("MG"..unit.."_HealthText"):SetText(currValue.."/"..maxValue)
						end
					elseif ( Telo ) then
						getglobal("MG"..unit.."_HealthText"):SetText(Telo)
					else
						getglobal("MG"..unit.."_HealthText"):SetText(percValue)
					end
				else
					if ( showDiff and hpDiff > 0 ) then
						getglobal("MG"..unit.."_HealthText"):SetText(currValue.."|cffff7f7f-"..hpDiff.."|r")
					else
						getglobal("MG"..unit.."_HealthText"):SetText(currValue.."/"..maxValue)
					end
				end
			else
				getglobal("MG"..unit.."_HealthText"):SetText(percValue)
			end
		else
			getglobal("MG"..unit.."_HealthText"):SetText("")
		end
		
		getglobal("MG"..unit.."_BarHealthText"):SetAlpha(0.75)
		if ( barshowText ) then
--sai smart style (bar)			
			if ( barstyle == BarTextStyle_Smart ) then
				
				if ( hpDiff > 0 ) then
					getglobal("MG"..unit.."_BarHealthText"):SetText("|cffff7f7f-"..hpDiff.."|r")
				else
					getglobal("MG"..unit.."_BarHealthText"):SetText("")
				end
--sai /
			elseif ( barstyle == BarTextStyle_Absolute or barshowDiff ) then
				local Telo = self:GetTelo(unit)
				if ( unit == "target" or unit == "targettarget") then
					if ( UnitIsUnit(unit,"pet") or UnitInParty(unit) or UnitIsUnit(unit, "player") or UnitInRaid(unit) ) then
						if ( barshowDiff and hpDiff > 0 ) then
							getglobal("MG"..unit.."_BarHealthText"):SetText(currValue.."|cffff7f7f-"..hpDiff.."|r")
						else
							getglobal("MG"..unit.."_BarHealthText"):SetText(currValue.."/"..maxValue)
						end
					elseif ( Telo ) then
						getglobal("MG"..unit.."_BarHealthText"):SetText(Telo)
					else
						getglobal("MG"..unit.."_BarHealthText"):SetText(percValue)
					end
				else
					if ( barshowDiff and hpDiff > 0 ) then
						getglobal("MG"..unit.."_BarHealthText"):SetText(currValue.."|cffff7f7f-"..hpDiff.."|r")
					else
						getglobal("MG"..unit.."_BarHealthText"):SetText(currValue.."/"..maxValue)
					end
				end
			else
				getglobal("MG"..unit.."_BarHealthText"):SetText(percValue)
			end
		else
			getglobal("MG"..unit.."_BarHealthText"):SetText("")
		end
		
--		local statustext = getglobal("MG"..unit.."_BarHealthText")
		
		if showText == 1 then
			statustext = getglobal("MG"..unit.."_HealthText")
		elseif barshowText == 1 then
			statustext = getglobal("MG"..unit.."_BarHealthText")
		end
		if statustext then
			if ( UnitIsDead(unit) ) then
				statustext:SetText(MG_MSG_DEAD)
			elseif ( UnitIsGhost(unit) ) then
				statustext:SetText(MG_MSG_GHOST)
			elseif ( not UnitIsConnected(unit) or maxValue == 1 ) then
				statustext:SetText(MG_MSG_OFFLINE)
			elseif (GetNumRaidMembers() > 0) then
				for k=1,40 do
					local name, _, _, _, _, _, _, online, isDead = GetRaidRosterInfo(k);
					if (name == UnitName(unit)) then
						if ( isDead ) then
							statustext:SetText(MG_MSG_DEAD)
						elseif ( not online ) then
							statustext:SetText(MG_MSG_OFFLINE)
						end
					end
				end
			end
		end
	end,
	
	StatusBarsUpdateMana = function(self,unit)
		self:UpdateSpellCastBar_FSR(self)
		if not unit then unit = arg1 end
		if unit == "mouseover" then return end
		if not getglobal("MG"..unit.."_ManaBar") then
			return
		end
		
		local currValue = UnitMana(unit)
		local maxValue = UnitManaMax(unit)
		local hpDiff = maxValue - currValue
		local showText
		local barshowText
		local style
		local barstyle
		local alive
		local percValue = ""..((currValue/maxValue)*100)
		percValue = string.gsub(percValue, "(%d+)(%.)(%d+)", "%1").."%"
	
		if ( not UnitExists(unit) or UnitIsDead(unit) or UnitIsGhost(unit) or not UnitIsConnected(unit) ) then
			alive = 0
			currValue = 0
			percValue = ""..((currValue/maxValue)*100)
			percValue = string.gsub(percValue, "(%d+)(%.)(%d+)", "%1").."%"			
			getglobal("MG"..unit.."_ManaBar"):SetMinMaxValues(0,1)
			getglobal("MG"..unit.."_ManaBar"):SetValue(0)
		else
			alive = 1
			getglobal("MG"..unit.."_ManaBar"):SetMinMaxValues(0,maxValue)
			getglobal("MG"..unit.."_ManaBar"):SetValue(currValue)		
		end
		
	--	self.cmd:msg("MG"..unit.."_ManaBar " .. maxValue .. " " .. currValue)
	
		
		style = MiniGroup2[(self:UnitCap(unit).."StatusTextStyle")]
		barstyle = MiniGroup2[(self:UnitCap(unit).."BarTextStyle")]
		
		if ( style ~= StatusTextStyle_Hide ) then
			showText = 1
		end
		if ( style == StatusTextStyle_Difference ) then
			showDiff = 1
		end
		
		if ( barstyle ~= BarTextStyle_Hide and alive == 1 ) then
			barshowText = 1
		end
		if ( barstyle == BarTextStyle_Difference ) then
			barshowDiff = 1
		end
		
		if ( showText ) then
--sai smart style (text)	
			if ( style == StatusTextStyle_Smart ) then
				getglobal("MG"..unit.."_ManaText"):SetText(currValue)
--sai /
			elseif style == StatusTextStyle_Percent then
				if maxValue > 0 then
					getglobal("MG"..unit.."_ManaText"):SetText(percValue)
				else
					getglobal("MG"..unit.."_ManaText"):SetText("")
				end
			elseif ( style == StatusTextStyle_Absolute or UnitPowerType(unit) == 1 ) then
				getglobal("MG"..unit.."_ManaText"):SetText(currValue.."/"..maxValue)
			elseif ( maxValue == 0 ) then
				getglobal("MG"..unit.."_ManaText"):SetText("0%")
			elseif (style == StatusTextStyle_Difference and hpDiff > 0) then
				getglobal("MG"..unit.."_ManaText"):SetText(currValue.."|cffff7f7f-"..hpDiff.."|r")
			elseif (style == StatusTextStyle_Difference) then
				getglobal("MG"..unit.."_ManaText"):SetText(currValue.."/"..maxValue)			
			end
		else
			getglobal("MG"..unit.."_ManaText"):SetText("")
		end
	
		getglobal("MG"..unit.."_BarManaText"):SetAlpha(0.75)
		if ( barshowText ) then
--sai smart style (bar)	
			if ( style == BarTextStyle_Smart ) then
				getglobal("MG"..unit.."_BarManaText"):SetText(currValue)
--sai /
			elseif barstyle == BarTextStyle_Percent then
				if maxValue > 0 then
					getglobal("MG"..unit.."_BarManaText"):SetText(percValue)
				else
					getglobal("MG"..unit.."_BarManaText"):SetText("")
				end
			elseif ( barstyle == BarTextStyle_Absolute or UnitPowerType(unit) == 1 ) then
				getglobal("MG"..unit.."_BarManaText"):SetText(currValue.."/"..maxValue)
			elseif ( maxValue == 0 ) then
				getglobal("MG"..unit.."_BarManaText"):SetText("0%")
			elseif (barstyle == BarTextStyle_Difference and hpDiff > 0) then
				getglobal("MG"..unit.."_BarManaText"):SetText(currValue.."|cffff7f7f-"..hpDiff.."|r")
			elseif (barstyle == BarTextStyle_Difference) then
				getglobal("MG"..unit.."_BarManaText"):SetText(currValue.."/"..maxValue)			
			else
				getglobal("MG"..unit.."_BarManaText"):SetText(percValue)
			end
		else
			getglobal("MG"..unit.."_BarManaText"):SetText("")	
		end
		
		local info = MG_ManaBar[UnitPowerType(unit)]
		
		local style = MiniGroup2[(self:UnitCap(unit).."FrameStyle")]
		local alpha = 1
		if not MGFrames[self:FrameType(unit)] or MGFrames[self:FrameType(unit)].AlphaBar == true then
			if UnitPowerType(unit) > 0 then
				alpha = 0.6
			else
				alpha = 0.8
			end
			getglobal("MG"..unit.."_ManaBar_BG"):SetVertexColor(info.r1,info.g1,info.b1,0.25)
		else
			getglobal("MG"..unit.."_ManaBar_BG"):SetVertexColor(0,0,0,0.25)
		end
		
		getglobal("MG"..unit.."_ManaBar"):SetStatusBarColor(info.r1,info.g1,info.b1,alpha)
	end,
	
	PlayerXPUpdate = function(self,newLevel)
		local style = MiniGroup2.PlayerFrameStyle
		local repname, repreaction, repmin, repmax, repvalue = GetWatchedFactionInfo();
		if ( MiniGroup2.ShowPlayerXP == 1 ) then
			if ( UnitLevel("player") < MAX_PLAYER_LEVEL ) or not repname then
				local priorXP = MGplayer_XPBar:GetValue()
				local pMin,pMax = MGplayer_XPBar:GetMinMaxValues()
				local currXP = UnitXP("player")
				local nextXP = UnitXPMax("player")
				local restXP = GetXPExhaustion()
				local changeXP
			
				MGplayer_XPBar:SetMinMaxValues(min(0, currXP), nextXP)
				MGplayer_XPBar_Rest:SetMinMaxValues(min(0, currXP), nextXP)
				MGplayer_XPBar:SetValue(currXP)
				
				if ( currXP > priorXP ) then
					changeXP = currXP - priorXP
				elseif ( (currXP <= priorXP) and (pMax ~= nextXP) ) then
					changeXP = (pMax - priorXP) + currXP
				end
				if ( changeXP and changeXP > 0 ) then
					MGplayer_XPBar.counter = GetTime()
					MGplayer_ClassText:SetText(NORMAL_FONT_COLOR_CODE.."XP: "..FONT_COLOR_CODE_CLOSE..changeXP)
				end
				if ( restXP ) then
					MGplayer_XPBar_Rest:Show()
					MGplayer_XPBar_Rest:SetValue(currXP+restXP)
				else
					MGplayer_XPBar_Rest:Hide()
				end
	
				MGplayer_XPBar:SetStatusBarColor(0.8, 0, 0.7)
				if not MGFrames[self:FrameType("player")] or MGFrames[self:FrameType("player")].BackgroundBarColor == true then
					MGplayer_XPBar_BG:SetVertexColor(0.8, 0, 0.7, 0.25)
				else
					MGplayer_XPBar_BG:SetVertexColor(0, 0, 0, 0.25)
				end
			elseif ( repname ) then
				local color = MG_FACTION_BAR_COLORS[repreaction]
		
				repmax = repmax - repmin;
				repvalue = repvalue - repmin;
				repmin = 0;
				
				MGplayer_XPBar_Rest:Hide()
				MGplayer_XPBar:SetMinMaxValues(repmin, repmax)
				MGplayer_XPBar:SetValue(repvalue)
				MGplayer_XPBar:SetStatusBarColor(color.r, color.g, color.b)
				MGplayer_XPBar_BG:SetVertexColor(color.r, color.g, color.b, 0.25)
			end
		end
		return self:CallHook("ReputationWatchBar_Update", newLevel)
	end,
	
	PetXPUpdate = function(self)
		if ( MiniGroup2.ShowPetXP == 0 ) then
			return
		end
		local currXP, nextXP = GetPetExperience()
	
		if ( nextXP ~= 0 ) then
			local priorXP = MGpet_XPBar:GetValue()
			local pMin,pMax = MGpet_XPBar:GetMinMaxValues()
			MGpet_XPBar:SetMinMaxValues(min(0, currXP), nextXP)
			MGpet_XPBar:SetValue(currXP)
			MGpet_XPBar:Show()
			if ( MiniGroup2.ShowEndcaps == 1 ) then
				MGpet_XPEndcapLeft:Show()
				MGpet_XPEndcapRight:Show()
			else
				MGpet_XPEndcapLeft:Hide()
				MGpet_XPEndcapRight:Hide()
			end
	
			local changeXP
			if ( currXP > priorXP ) then
				changeXP = currXP - priorXP
			elseif ( (currXP <= priorXP) and (pMax ~= nextXP) ) then
				changeXP = (pMax - priorXP) + currXP
			end
			if ( changeXP and changeXP > 0 ) then
				MGpet_XPBar.counter = GetTime()
				MGpet_ClassText:SetText(NORMAL_FONT_COLOR_CODE.."XP: "..FONT_COLOR_CODE_CLOSE..changeXP)
			end
		else
			MGpet_XPBar:Hide()
			MGpet_XPBar_BG:Hide()
			MGpet_XPEndcapLeft:Hide()
			MGpet_XPEndcapRight:Hide()
		end
	end,
	
	PetSetHappiness = function(self)
		local happiness, damagePercentage, loyaltyRate = GetPetHappiness()
		local a = 0.5
		local playerClass, englishClass = UnitClass("player");
		if ( not HasPetUI() or englishClass ~= "HUNTER" or englishClass == "WARLOCK" or self.GetOpt("HidePetHappy") == 1) then
			MGpet_Happiness:Hide()
			return	
		end
		if englishClass == "HUNTER" and not (MGFrames["MGpet"].HappinessBar == true) then
			MGpet_Happiness:Show()
		else
			MGpet_Happiness:Hide()
		end
		if ( happiness == 1 ) then
			MGpet_Happiness:SetVertexColor(1,0,0,a)
		elseif ( happiness == 2 ) then
			MGpet_Happiness:SetVertexColor(1,1,0,a)
		elseif ( happiness == 3 ) then
			MGpet_Happiness:SetVertexColor(0,1,0,a)
		end
		self:StatusBarsOnValueChanged(0,"pet")
		MGpet.tooltip = getglobal("PET_HAPPINESS"..happiness)
		MGpet.tooltipDamage = format(PET_DAMAGE_PERCENTAGE, damagePercentage)
		if ( loyaltyRate < 0 ) then
			MGpet.tooltipLoyalty = getglobal("LOSING_LOYALTY")
		elseif ( loyaltyRate > 0 ) then
			MGpet.tooltipLoyalty = getglobal("GAINING_LOYALTY")
		else
			MGpet.tooltipLoyalty = nil
		end
	end,
			
	StatusBarsOnValueChanged = function(self,value,pet)
		if pet then
			this = MGpet_HealthBar
		end
		local style = MiniGroup2[(self:UnitCap(string.gsub((this:GetParent()):GetName(),"MG","")).."FrameStyle")]
		local table
		if string.find(this:GetName(),"targettarget") then
			table =	MG_ToTReaction
		else
			table = MG_TargetReaction
		end
		local happiness = GetPetHappiness()
		--nissefar
		if ( happiness == 1 ) then
			table = {
					r = MG_ManaBar[1]["r1"],
					g = MG_ManaBar[1]["g1"],
					b = MG_ManaBar[1]["b1"]
				}
		elseif ( happiness == 2 ) then
			table = {
					r = MG_ManaBar[3]["r1"],
					g = MG_ManaBar[3]["g1"],
					b = MG_ManaBar[3]["b1"]
				}
		elseif ( happiness == 3 ) then
			table = {
					r = MG_HealthBarBG["r1"],
					g = MG_HealthBarBG["g1"],
					b = MG_HealthBarBG["b1"]
				}
		end
		
		if (MiniGroup2.TargetShowHostile == 1) and string.find(this:GetName(),"target") and not UnitIsFriend(string.gsub((this:GetParent()):GetName(),"MG",""), "player") and MiniGroup2.SmoothHealthBars == 0 then
			this:SetStatusBarColor(table["r"],table["g"],table["b"], 1)
			if not MGFrames[self:FrameType(string.gsub((this:GetParent()):GetName(),"MG",""))] or MGFrames[self:FrameType(string.gsub((this:GetParent()):GetName(),"MG",""))].BackgroundBarColor == true then
				getglobal((this:GetParent()):GetName().."_HealthBar_BG"):SetVertexColor(table["r"],table["g"],table["b"],0.25)
			else
				getglobal((this:GetParent()):GetName().."_HealthBar_BG"):SetVertexColor(0,0,0,0.25)
			end		
		else
			if ( MiniGroup2.SmoothHealthBars == 1 ) then
				self:SmoothHealthBarOnValueChanged(value)
			else
				HealthBar_OnValueChanged(value)
				this:SetStatusBarColor(MG_HealthBar.r1,MG_HealthBar.g1,MG_HealthBar.b1, 1)
			end
			if not MGFrames[self:FrameType(string.gsub((this:GetParent()):GetName(),"MG",""))] or MGFrames[self:FrameType(string.gsub((this:GetParent()):GetName(),"MG",""))].BackgroundBarColor == true then
				getglobal((this:GetParent()):GetName().."_HealthBar_BG"):SetVertexColor(MG_HealthBar.r1,MG_HealthBar.g1,MG_HealthBar.b1,0.25)
			else
				getglobal((this:GetParent()):GetName().."_HealthBar_BG"):SetVertexColor(0,0,0,0.25)
			end		
		end
		if string.find(this:GetName(),"MGpet") and MGFrames[self:FrameType(string.gsub((this:GetParent()):GetName(),"MG",""))].HappinessBar == true then
			this:SetStatusBarColor(table["r"],table["g"],table["b"], 1)
			if not MGFrames[self:FrameType(string.gsub((this:GetParent()):GetName(),"MG",""))] or MGFrames[self:FrameType(string.gsub((this:GetParent()):GetName(),"MG",""))].BackgroundBarColor == true then
				getglobal((this:GetParent()):GetName().."_HealthBar_BG"):SetVertexColor(table["r"],table["g"],table["b"],0.25)
			else
				getglobal((this:GetParent()):GetName().."_HealthBar_BG"):SetVertexColor(0,0,0,0.25)
			end
		end
		if ( MobHealthFrame ) then
			if MiniGroup2.ShowBlizzTargetFrame == 0 then
				MobHealthFrame:Hide()
			else
				MobHealthFrame:Show()
			end
		end
	end,
				
	SmoothTargetHealthBarOnValueChanged = function(self,value)
		local r1, g1, b1
		if string.find(this:GetName(),"targettarget") then
			r1 = MG_ToTReaction["r"]
			g1 = MG_ToTReaction["g"]
			b1 = MG_ToTReaction["b"]
		else
			r1 = MG_TargetReaction["r"]
			g1 = MG_TargetReaction["g"]
			b1 = MG_TargetReaction["b"]
		end
		if ( not value ) then
			return
		end
		local r, g, b
		local min, max = this:GetMinMaxValues()
		if ( (value < min) or (value > max) ) then
			return
		end
		if ( (max - min) > 0 ) then
			value = (value - min) / (max - min)
		else
			value = 0
		end
		
		if ( r1 ~= nil and r2 ~= nil and r3 ~= nil) then
			r = r1*(0.35*value+0.65)
			g = g1*(0.35*value+0.65)
			b = b1*(0.35*value+0.65)
			this:SetStatusBarColor(r, g, b)
		else
			this:SetStatusBarColor(0, 0, 0)
		end
	end,
	
	SmoothHealthBarOnValueChanged = function(self,value)
		if ( not value ) then
			return
		end
		local r, g, b
		local min, max = this:GetMinMaxValues()
		if ( (value < min) or (value > max) ) then
			return
		end
		if ( (max - min) > 0 ) then
			value = (value - min) / (max - min)
		else
			value = 0
		end
		
		if(value > 0.5) then
			r = (MG_HealthBar.r1) + (((1-value) * 2)* (1-(MG_HealthBar.r1)))
			g = MG_HealthBar.g1
		else
			r = 1.0
			g = (MG_HealthBar.g1) - (0.5 - value)* 2 * (MG_HealthBar.g1)
		end
	
		b = MG_HealthBar.b1
		this:SetStatusBarColor(r, g, b)
	end,
		
	--[[---------------------------------------------------------------------------------
	  Member functions
	------------------------------------------------------------------------------------]]
	
	TooltipOnLoad = function(self)
		this:SetBackdropBorderColor(TOOLTIP_DEFAULT_COLOR.r, TOOLTIP_DEFAULT_COLOR.g, TOOLTIP_DEFAULT_COLOR.b)
		this:SetBackdropColor(TOOLTIP_DEFAULT_BACKGROUND_COLOR.r, TOOLTIP_DEFAULT_BACKGROUND_COLOR.g, TOOLTIP_DEFAULT_BACKGROUND_COLOR.b)
	end,
	
	MemberOnLoad = function(self)
		this:RegisterForClicks('LeftButtonUp', 'RightButtonUp', 'MiddleButtonUp', 'Button4Up', 'Button5Up');
		this:SetBackdropColor(
			TOOLTIP_DEFAULT_BACKGROUND_COLOR.r,
			TOOLTIP_DEFAULT_BACKGROUND_COLOR.g,
			TOOLTIP_DEFAULT_BACKGROUND_COLOR.b)
		this:SetBackdropBorderColor(
			TOOLTIP_DEFAULT_COLOR.r,
			TOOLTIP_DEFAULT_COLOR.g,
			TOOLTIP_DEFAULT_COLOR.b)
		this:RegisterForDrag("LeftButton")
	end,
	
	MemberOnEnter = function(self)
		this.unit = string.gsub(this:GetName(),"MG","")
		
		--[[GameTooltip_SetDefaultAnchor(GameTooltip, this);
		
		if ( GameTooltip:SetUnit(this.unit) ) then
			this.updateTooltip = TOOLTIP_UPDATE_TIME;
		else
			this.updateTooltip = nil;
		end
		
		this.r, this.g, this.b = GameTooltip_UnitColor(this.unit);
		GameTooltipTextLeft1:SetTextColor(this.r, this.g, this.b);]]
		
		UnitFrame_OnEnter()
		
		if (not ( this:GetName() == "MGtarget" or this:GetName() == "MGtargettarget") 
		and MiniGroup2.HighlightSelected == 1) then
			getglobal(this:GetName().."Highlight"):Show()
			getglobal(this:GetName().."Highlight"):SetAlpha(0.7)
		end
	
		MiniGroup_Frame.showAura = this:GetName()
		self:TooltipUpdate(string.gsub(this:GetName(),"MG",""))
		
		if this.unit == "player" or this.unit == "pet" then
			local text = self:XPBarText()
			if text then
				GameTooltip:SetText(text)
			end
		end
	end,
	
	TooltipUpdate = function(self,unit)
		local aura,button,TipStyle
		local numBuffs = 0
		local numDebuffs = 0
		TipStyle = self.GetOpt(self:UnitCap(unit).."AuraTipStyle")
		-- 1 = off, 2 = buffs, 3 = debuffs, 4 = both
	
		if ( TipStyle == 1 ) then
			return
		end
		if ( TipStyle == 2 or TipStyle == 4 ) then
			for i = 1, 16 do
				aura = UnitBuff(unit, i)
				if ( aura ) then
					getglobal("MGAuraTip_Buff"..i.."Icon"):SetTexture(aura)
					getglobal("MGAuraTip_Buff"..i.."Overlay"):Hide()
					numBuffs = numBuffs + 1
					getglobal("MGAuraTip_Buff"..i):Show()
				else
					getglobal("MGAuraTip_Buff"..i):Hide()
				end
			end
		end
	
		if ( numBuffs == 0 ) then
			MGAuraTip_Debuff1:SetPoint("TOP", "MGAuraTip_Buff1", "TOP", 0, 0)
		elseif ( numBuffs <= 8 ) then
			MGAuraTip_Debuff1:SetPoint("TOP", "MGAuraTip_Buff1", "BOTTOM", 0, -2)
		else
			MGAuraTip_Debuff1:SetPoint("TOP", "MGAuraTip_Buff9", "BOTTOM", 0, -2)
		end
	
		if ( TipStyle == 3 or TipStyle == 4 ) then
			for i = 1, 8 do
				aura = UnitDebuff(unit, i)
				if ( aura ) then
					getglobal("MGAuraTip_Debuff"..i.."Icon"):SetTexture(aura)
					getglobal("MGAuraTip_Debuff"..i.."Overlay"):Show()
					numDebuffs = numDebuffs + 1
					getglobal("MGAuraTip_Debuff"..i):Show()
				else
					getglobal("MGAuraTip_Debuff"..i):Hide()
				end
			end
		end
	
		-- Size the tooltip
		local rows = ceil(numBuffs / 8) + ceil(numDebuffs / 8)
		local columns = min(8, max(numBuffs, numDebuffs))
		if ( (rows > 0) and (columns > 0) ) then
			MGAuraTip:SetWidth( (columns * 17) + 15 )
			MGAuraTip:SetHeight( (rows * 17) + 15 )
			MGAuraTip:SetPoint("TOPLEFT","MG"..unit.."_NameLabel","BOTTOMLEFT",0,0)
			MGAuraTip:Show()
		else
			MGAuraTip:Hide()
		end
	end,
	
	MemberOnLeave = function(self)
		this.updateTooltip = nil;
		if ( SHOW_NEWBIE_TIPS == "1" ) then
			GameTooltip:Hide();
		else
			GameTooltip:FadeOut();	
		end
	
		MiniGroup_Frame.showAura = ""
			MGAuraTip:Hide()
			if  ( UnitName("target") 
			and   UnitName("target") == UnitName(UnitFrames[this:GetName()]) ) then
				if ( self.GetOpt("HighlightSelected") == 0 ) then
					if (MGplayer.inCombat and self.GetOpt("CombatIndicator") == background) or
						(MGplayer.onHateList and self.GetOpt("AggroIndicator") == background) or
						(IsResting() and self.GetOpt("RestIndicator") == background) then
						--don't hide
					else
						getglobal(this:GetName().."Highlight"):Hide()
					end
				end
				return
			end
			if ( this:GetName() == "MGplayer") then
				if (MGplayer.inCombat and self.GetOpt("CombatIndicator") == background) or
					(MGplayer.onHateList and self.GetOpt("AggroIndicator") == background) or
					(IsResting() and self.GetOpt("RestIndicator") == background) then
					--don't hide
				else
					getglobal(this:GetName().."Highlight"):Hide()
				end
			else
				getglobal(this:GetName().."Highlight"):Hide()
			end
	end,
	
	MemberOnMouseUp = function(self,button)
		if this.GroupStart then
			MiniGroup2:AnchorOnMouseUp("LeftButton",this.GroupStart)
			if string.find(this.GroupStart:GetName(),"party") then
				self:SaveFramePos(this.GroupStart)
			end
		end
		if string.find(this:GetName(),"party") then
			self:SaveFramePos(this)		
		end
		this:StopMovingOrSizing()

		local aurapos = MiniGroup2[(self:UnitCap(UnitFrames[this:GetName()]).."AuraPos")]
	local id = this:GetName()
	if aurapos == AuraPos_Auto then
			if not ( self.GetOpt("LockMGFrames") ) then
				self:AuraUpdate(UnitFrames[this:GetName()])
				if MGraid1 and string.find(this:GetName(),"raid") then
					id = string.gsub(id, "MGraid","")
					local name, rank, unitsubgroup = GetRaidRosterInfo(id)
					for i=1,40 do
						local _, _, unitsubgroup2 = GetRaidRosterInfo(i)
						if unitsubgroup2==unitsubgroup then
							self:UnitFrameResize("raid"..i)
							self:UnitFrameResize("raidpet"..i)
						end
					end
				end
			end
		end
	end,
	
	MemberOnMouseDown = function(self,button)
		MGclickTime = GetTime()
		local frameName
		local frame
		
		if ( UnitFrames[frameName] == nil ) then
			frame = this
			frameName = this:GetName()
		end	
		
		if ( button == "LeftButton" ) then
			if not ( self.GetOpt("LockMGFrames") == 1 ) then
				if frame.GroupStart then
					--frame.GroupStart:StartMoving()
					MiniGroup2:AnchorOnMouseDown(button,frame.GroupStart)
				else
					frame:StartMoving()
				end
			end
			return
		end
	end,
	
	Overlap = function(self,frameA, frameB, number)
		local sA, sB = frameA:GetEffectiveScale(), frameB:GetEffectiveScale()
		if not frameA:GetLeft() or not frameA:GetBottom() or not frameA:GetRight() or not frameA:GetTop() then
			return false
		end
		if not frameB:GetLeft() or not frameB:GetBottom() or not frameB:GetRight() or not frameB:GetTop() then
			return false
		end
		if not sA or not sB then
			return false
		end
		
		local anchorvis = 0
		if number == 1 and (string.find(frameA:GetName(),"MGraid_achor")) then
			anchorvis = 1
		end
		
		if (not frameA:IsShown() or not frameB:IsShown()) and anchorvis == 0 then
			return false
		end
		
		return ((frameA:GetLeft()*sA) < (frameB:GetRight()*sB))
			and ((frameB:GetLeft()*sB) < (frameA:GetRight()*sA))
			and ((frameA:GetBottom()*sA) < (frameB:GetTop()*sB))
			and ((frameB:GetBottom()*sB) < (frameA:GetTop()*sA))
	end,
	
	AnchorOnMouseUp = function(self,button,moveframe)
		local thisframe
		if moveframe then
			thisframe = moveframe
		else
			thisframe = this
		end
		thisframe:StopMovingOrSizing()
		
		if string.find(this:GetName(),"achor") then
			if ( CastPartyOverrideMouse[self.GetOpt("CastPartyOverrideMouse")] == button ) then
				local shift, ctrl, alt = 0, 0, 0
				if ( IsShiftKeyDown() )   then shift = 1 end
				if ( IsControlKeyDown() ) then ctrl  = 1 end
				if ( IsAltKeyDown() )     then alt   = 1 end
	
				if ( self.GetOpt("CastPartyOverrideShift") == shift
				and  self.GetOpt("CastPartyOverrideCtrl")  == ctrl
				and  self.GetOpt("CastPartyOverrideAlt")   == alt   ) then
					if ( (GetTime() - MGclickTime ) > 0.25 ) then
						ToggleDropDownMenu(1, nil, MiniGroup_Dropdown, "cursor", 0, 0)
					end
				end
			end
		end
		
		if MGraid1 then
			if self.GetOpt("LockMGFrames") == 0 then
				local overlap = 0
				if button == "LeftButton" then
					for i = 1,8 do
						if thisframe:GetLeft() and getglobal("MGraid_achor"..i):GetLeft() then
							if (self:Overlap(thisframe, getglobal("MGraid_achor"..i),1)
							or self:Overlap(this, getglobal("MGraid_achor"..i),1) 
							or self:Overlap(thisframe, getglobal("MGraidgroup"..i),1) 
							or self:Overlap(this, getglobal("MGraidgroup"..i),1)) 
							and thisframe ~= getglobal("MGraid_achor"..i) then
								if MG_AnchorConnect["MGraid_achor"..i] ~= thisframe:GetName() and overlap == 0 then
									MG_AnchorConnect[thisframe:GetName()] = "MGraid_achor"..i
									overlap = 1
								end
							end
						end
					end
				end
				if overlap == 0 then
					MG_AnchorConnect[thisframe:GetName()] = nil			
				end
				MiniGroup2:AnchorUpdate()
			end
		end
	end,
	
	AnchorUpdate = function(self)
		if not MG_AnchorConnect then
			MG_AnchorConnect = self.GetOpt("Anchors")
		end
		
		if MGraid1 then
			local frameGrowth = self.GetOpt("FrameGrowth")
			local Relation1
			local Relation2
			local modifier = 1
					
			if frameGrowth == FrameGrowth_Up then
				Relation1 = "BOTTOMLEFT"
				Relation2 = "TOPLEFT"
				GroupFrameRelation1 = "BOTTOMLEFT"
				GroupFrameRelation2 = "BOTTOMLEFT"
			elseif frameGrowth == FrameGrowth_Down then
				Relation1 = "TOPLEFT"
				Relation2 = "BOTTOMLEFT"
				GroupFrameRelation1 = "TOPLEFT"
				GroupFrameRelation2 = "TOPLEFT"	
				modifier = -1
			end
					
			for key, value in MG_AnchorConnect do
				if value ~= nil then
					getglobal(key):ClearAllPoints()
	
					local groupheight = getglobal("MGraidgroup"..string.gsub(value,"[%a_]+","")):GetHeight() 
					
					if getglobal(value):IsVisible() then
						if getglobal("MGraidgroup"..string.gsub(value,"[%a_]+","")):IsVisible() then
							groupheight = groupheight - anchoradjustment*2
						else
							groupheight = - anchoradjustment
						end
					else
						if getglobal("MGraidgroup"..string.gsub(value,"[%a_]+","")):IsVisible() then
							groupheight = - anchoradjustment
						else
							groupheight = - (getglobal(value):GetHeight())
						end
					end
					groupheight = groupheight * modifier
					
					local checkvalue = key
					repeat
						checkvalue = MG_AnchorConnect[checkvalue]
					until checkvalue == nil or checkvalue == key
					
					if checkvalue == nil then					
						getglobal(key):SetPoint(Relation1, getglobal(value), Relation2, 0, groupheight)
					else
						MG_AnchorConnect[key] = nil
					end
				end
			end
			self.SetOpt("Anchors", MG_AnchorConnect)
		end
	end,
	
	AnchorOnMouseDown = function(self,button,moveframe)
		MGclickTime = GetTime()
		local thisframe
		if moveframe then
			thisframe = moveframe
		else
			thisframe = this
		end
		if ( button == "LeftButton" ) then
			if not ( self.GetOpt("LockMGFrames") == 1 ) then
				thisframe:StartMoving()
			end
			return
		end
	end,
	
	LeftClick = function(self)
		local unit = string.gsub(this:GetName(),"MG","")
		local frame = this
		MGSelectedFrame = this
		
--		if ( (GetTime() - MGclickTime) <= 0.75 ) then
--			if ( CursorHasItem() ) then
--				if ( unit == "player" ) then
--					AutoEquipCursorItem()
--				else
--					DropItemOnUnit(unit)
--				end
--			else
				TargetUnit(unit)
--			end
--		end
	end,
	
	RightClick = function(self)
		local unit = UnitFrames[this:GetName()]
		local frame = this
	
--		if ( (GetTime() - MGclickTime ) <= 0.25 ) then
--			self:DropDownUnit(unit)
--		else
			self:DropDownUnit(unit)
--		end
	end,
	
	DropDownOnLoad = function(self)
	end,
	
	OptionsDropDownOnLoad = function(self)
		UIDropDownMenu_Initialize(MiniGroup_Dropdown, function() MiniGroup2:OptionsDropdownInit() end, "MENU")
	end,

	MemberOnClick = function(self,button)
		if ( button == "LeftButton" and self.GetOpt("CastPartyEnabled") ~= 1) then
			self:LeftClick()
			return
		elseif ( button == "RightButton" and self.GetOpt("CastPartyEnabled") ~= 1) then
			self:RightClick()
			return
		end			
		if ( not (self.GetOpt("CastPartyEnabled") == 1)
		or   CastPartyConfig == nil
		or   ( this:GetName() == "MGtarget" and self.GetOpt("CastPartyTargetEnabled") == 0 ) ) then
			return
		else
			if ( this:GetName() ~= "MGtarget" or self.GetOpt("CastPartyTargetEnabled") == 1 ) then
				if ( CastPartyOverrideMouse[self.GetOpt("CastPartyOverrideMouse")] == button ) then
	
					local shift, ctrl, alt = 0, 0, 0
					if ( IsShiftKeyDown() )   then shift = 1 end
					if ( IsControlKeyDown() ) then ctrl  = 1 end
					if ( IsAltKeyDown() )     then alt   = 1 end
	
					if ( self.GetOpt("CastPartyOverrideShift") == shift
					and  self.GetOpt("CastPartyOverrideCtrl")  == ctrl
					and  self.GetOpt("CastPartyOverrideAlt")   == alt   ) then
						self:RightClick()
						return
					else
						CastParty_OnClickByUnit(button, UnitFrames[this:GetName()])
					end
	
				else
					CastParty_OnClickByUnit(button, UnitFrames[this:GetName()])
				end
			end	
		end
	end,
	
	XPBarText = function(self)
		local repname, repreaction, repmin, repmax, repvalue = GetWatchedFactionInfo();	
		if ( this:GetName() == "MGplayer" ) then
			local tipText
			if ( UnitLevel("player") < MAX_PLAYER_LEVEL ) or not repname then
				local currXP = UnitXP("player")
				local nextXP = UnitXPMax("player")
				local restXP = GetXPExhaustion()
				local XP2Go = nextXP - currXP
		
				if ( tonumber(UnitLevel("player")) == 60 ) then
					XP2Go = ""
				else
					XP2Go = MINIGROUP2.RXP..XP2Go
				end
		
				if ( restXP ) then
					tipText = NORMAL_FONT_COLOR_CODE..MINIGROUP2.XP..currXP.."/"..nextXP..XP2Go..FONT_COLOR_CODE_CLOSE..MINIGROUP2.RB..GetXPExhaustion()
				else
					tipText = NORMAL_FONT_COLOR_CODE..MINIGROUP2.XP..currXP.."/"..nextXP..XP2Go..FONT_COLOR_CODE_CLOSE
				end
			elseif ( repname ) then
				local Rep2Go = repmax - repvalue
				Rep2Go = MINIGROUP2.RREP..Rep2Go
				tipText = NORMAL_FONT_COLOR_CODE..repname..": "..repvalue.."/"..repmax..Rep2Go..FONT_COLOR_CODE_CLOSE
			end
			if ( GetLootMethod() and GetLootThreshold() ) then
				local color = ITEM_QUALITY_COLORS[GetLootThreshold()]
				tipText = tipText.."\n\n"..NORMAL_FONT_COLOR_CODE..UnitLootMethod[GetLootMethod()].text..FONT_COLOR_CODE_CLOSE.."\n|cff"..self:DecToHex(ITEM_QUALITY_COLORS[GetLootThreshold()].r,ITEM_QUALITY_COLORS[GetLootThreshold()].g,ITEM_QUALITY_COLORS[GetLootThreshold()].b)..getglobal("ITEM_QUALITY"..GetLootThreshold().."_DESC")..FONT_COLOR_CODE_CLOSE
			end
		
--			GameTooltip_SetDefaultAnchor(GameTooltip, this)
			return tipText
		else
			local totalPoints, spent = GetPetTrainingPoints()
			local currXP, nextXP = GetPetExperience()
			local XP2Go = nextXP - currXP
			local pettip = ""
	
			if ( tonumber(UnitLevel("pet")) == UnitLevel("player") ) then
				XP2Go = ""
			else
				XP2Go = MINIGROUP2.RXP..XP2Go
			end
	
			if ( this.tooltip ) then
				pettip = "\n\n"..this.tooltip
				if ( this.tooltipDamage ) then
					pettip = pettip.."\n"..NORMAL_FONT_COLOR_CODE..this.tooltipDamage..FONT_COLOR_CODE_CLOSE
				end
				if ( this.tooltipLoyalty ) then
					pettip = pettip.."\n"..NORMAL_FONT_COLOR_CODE..this.tooltipLoyalty..FONT_COLOR_CODE_CLOSE
				end
			end
	
--			GameTooltip_SetDefaultAnchor(GameTooltip, this)
			return NORMAL_FONT_COLOR_CODE..MINIGROUP2.XP..currXP.."/"..nextXP..XP2Go..FONT_COLOR_CODE_CLOSE..MINIGROUP2.TP..(totalPoints - spent).."/"..totalPoints..pettip
		end
	end,
	
	--[[--------------------------------------------------------------------------------
	  Handlers for Blizzard frames
	-----------------------------------------------------------------------------------]]
		
	HideBlizzardFrames = function(self)
		local table = self.GetOpt("ShowBlizFrames")
		
		if table.PlayerFrame == 0 then
			MiniGroup2:HideBlizzardPlayer(1)
		else
			MiniGroup2:HideBlizzardPlayer(nil)
		end
		
		if table.PartyFrame == 0 then
			MiniGroup2:HideBlizzardParty(1)
		else
			MiniGroup2:HideBlizzardParty(nil)	
		end
	
		if table.TargetFrame == 0 then
			MiniGroup2:HideBlizzardTarget(1)
		else
			MiniGroup2:HideBlizzardTarget(nil)
		end
	end,
		
	HideBlizzardPlayer = function(self,hide)
			if hide then
				PlayerFrame:UnregisterEvent("UNIT_LEVEL")
				PlayerFrame:UnregisterEvent("UNIT_COMBAT")
				PlayerFrame:UnregisterEvent("UNIT_SPELLMISS")
				PlayerFrame:UnregisterEvent("UNIT_PVP_UPDATE")
				PlayerFrame:UnregisterEvent("UNIT_MAXMANA")
				PlayerFrame:UnregisterEvent("PLAYER_ENTER_COMBAT")
				PlayerFrame:UnregisterEvent("PLAYER_LEAVE_COMBAT")
				PlayerFrame:UnregisterEvent("PLAYER_UPDATE_RESTING")
				PlayerFrame:UnregisterEvent("PARTY_MEMBERS_CHANGED")
				PlayerFrame:UnregisterEvent("PARTY_LEADER_CHANGED")
				PlayerFrame:UnregisterEvent("PARTY_LOOT_METHOD_CHANGED")
				PlayerFrame:UnregisterEvent("PLAYER_ENTERING_WORLD")
				PlayerFrame:UnregisterEvent("PLAYER_REGEN_DISABLED")
				PlayerFrame:UnregisterEvent("PLAYER_REGEN_ENABLED")
				PlayerFrameHealthBar:UnregisterEvent("UNIT_HEALTH")
				PlayerFrameHealthBar:UnregisterEvent("UNIT_MAXHEALTH")
				PlayerFrameManaBar:UnregisterEvent("UNIT_MANA")
				PlayerFrameManaBar:UnregisterEvent("UNIT_RAGE")
				PlayerFrameManaBar:UnregisterEvent("UNIT_FOCUS")
				PlayerFrameManaBar:UnregisterEvent("UNIT_ENERGY")
				PlayerFrameManaBar:UnregisterEvent("UNIT_HAPPINESS")
				PlayerFrameManaBar:UnregisterEvent("UNIT_MAXMANA")
				PlayerFrameManaBar:UnregisterEvent("UNIT_MAXRAGE")
				PlayerFrameManaBar:UnregisterEvent("UNIT_MAXFOCUS")
				PlayerFrameManaBar:UnregisterEvent("UNIT_MAXENERGY")
				PlayerFrameManaBar:UnregisterEvent("UNIT_MAXHAPPINESS")
				PlayerFrameManaBar:UnregisterEvent("UNIT_DISPLAYPOWER")
				PlayerFrame:UnregisterEvent("UNIT_NAME_UPDATE")
				PlayerFrame:UnregisterEvent("UNIT_PORTRAIT_UPDATE")
				PlayerFrame:UnregisterEvent("UNIT_DISPLAYPOWER")
				PlayerFrame:Hide()
			else
				PlayerFrame:RegisterEvent("UNIT_LEVEL")
				PlayerFrame:RegisterEvent("UNIT_COMBAT")
				PlayerFrame:RegisterEvent("UNIT_SPELLMISS")
				PlayerFrame:RegisterEvent("UNIT_PVP_UPDATE")
				PlayerFrame:RegisterEvent("UNIT_MAXMANA")
				PlayerFrame:RegisterEvent("PLAYER_ENTER_COMBAT")
				PlayerFrame:RegisterEvent("PLAYER_LEAVE_COMBAT")
				PlayerFrame:RegisterEvent("PLAYER_UPDATE_RESTING")
				PlayerFrame:RegisterEvent("PARTY_MEMBERS_CHANGED")
				PlayerFrame:RegisterEvent("PARTY_LEADER_CHANGED")
				PlayerFrame:RegisterEvent("PARTY_LOOT_METHOD_CHANGED")
				PlayerFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
				PlayerFrame:RegisterEvent("PLAYER_REGEN_DISABLED")
				PlayerFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
				PlayerFrameHealthBar:RegisterEvent("UNIT_HEALTH")
				PlayerFrameHealthBar:RegisterEvent("UNIT_MAXHEALTH")
				PlayerFrameManaBar:RegisterEvent("UNIT_MANA")
				PlayerFrameManaBar:RegisterEvent("UNIT_RAGE")
				PlayerFrameManaBar:RegisterEvent("UNIT_FOCUS")
				PlayerFrameManaBar:RegisterEvent("UNIT_ENERGY")
				PlayerFrameManaBar:RegisterEvent("UNIT_HAPPINESS")
				PlayerFrameManaBar:RegisterEvent("UNIT_MAXMANA")
				PlayerFrameManaBar:RegisterEvent("UNIT_MAXRAGE")
				PlayerFrameManaBar:RegisterEvent("UNIT_MAXFOCUS")
				PlayerFrameManaBar:RegisterEvent("UNIT_MAXENERGY")
				PlayerFrameManaBar:RegisterEvent("UNIT_MAXHAPPINESS")
				PlayerFrameManaBar:RegisterEvent("UNIT_DISPLAYPOWER")
				PlayerFrame:RegisterEvent("UNIT_NAME_UPDATE")
				PlayerFrame:RegisterEvent("UNIT_PORTRAIT_UPDATE")
				PlayerFrame:RegisterEvent("UNIT_DISPLAYPOWER")
				PlayerFrame:Show()
			end
		end,
	
		HideBlizzardTarget = function(self,hide)
			if hide then
				TargetFrame:UnregisterEvent("PLAYER_TARGET_CHANGED")
				TargetFrame:UnregisterEvent("UNIT_HEALTH")
				TargetFrame:UnregisterEvent("UNIT_LEVEL")
				TargetFrame:UnregisterEvent("UNIT_FACTION")
				TargetFrame:UnregisterEvent("UNIT_CLASSIFICATION_CHANGED")
				TargetFrame:UnregisterEvent("UNIT_AURA")
				TargetFrame:UnregisterEvent("PLAYER_FLAGS_CHANGED")
				TargetFrame:UnregisterEvent("PARTY_MEMBERS_CHANGED")
				TargetFrame:Hide()
				
				ComboFrame:UnregisterEvent("PLAYER_TARGET_CHANGED")
				ComboFrame:UnregisterEvent("PLAYER_COMBO_POINTS")
			else
				TargetFrame:RegisterEvent("PLAYER_TARGET_CHANGED")
				TargetFrame:RegisterEvent("UNIT_HEALTH")
				TargetFrame:RegisterEvent("UNIT_LEVEL")
				TargetFrame:RegisterEvent("UNIT_FACTION")
				TargetFrame:RegisterEvent("UNIT_CLASSIFICATION_CHANGED")
				TargetFrame:RegisterEvent("UNIT_AURA")
				TargetFrame:RegisterEvent("PLAYER_FLAGS_CHANGED")
				TargetFrame:RegisterEvent("PARTY_MEMBERS_CHANGED")
				if UnitExists(target) then TargetFrame:Show() end
				
				ComboFrame:RegisterEvent("PLAYER_TARGET_CHANGED")
				ComboFrame:RegisterEvent("PLAYER_COMBO_POINTS")
			end
		end,
		
		HideBlizzardBuff = function(self,hide)
			if hide then
				BuffFrame:Hide()
				TemporaryEnchantFrame:Hide()
				for bb=0, 23 do
					getglobal("BuffButton"..bb):UnregisterEvent("PLAYER_AURAS_CHANGED")
				end
				TempEnchant1:UnregisterEvent("PLAYER_AURAS_CHANGED")
				TempEnchant2:UnregisterEvent("PLAYER_AURAS_CHANGED")
			else
				BuffFrame:Show()
				TemporaryEnchantFrame:Show()
				for bb=0, 23 do
					getglobal("BuffButton"..bb):RegisterEvent("PLAYER_AURAS_CHANGED")
				end
				TempEnchant1:RegisterEvent("PLAYER_AURAS_CHANGED")
				TempEnchant2:RegisterEvent("PLAYER_AURAS_CHANGED")
			end
		end,
	
HideBlizzardParty = function(self,hide)
			if hide then
			    self:Hook("RaidOptionsFrame_UpdatePartyFrames", function() end)
				for partynum=1,4 do
					local frame = getglobal("PartyMemberFrame"..partynum)
					frame:UnregisterEvent("PARTY_MEMBERS_CHANGED")
					frame:UnregisterEvent("PARTY_LEADER_CHANGED")
					frame:UnregisterEvent("PARTY_MEMBER_ENABLE")
					frame:UnregisterEvent("PARTY_MEMBER_DISABLE")
					frame:UnregisterEvent("PARTY_LOOT_METHOD_CHANGED")
					frame:UnregisterEvent("UNIT_PVP_UPDATE")
					frame:UnregisterEvent("UNIT_AURA")
					frame:UnregisterEvent("UNIT_PET")
					frame:UnregisterEvent("VARIABLES_LOADED")
					frame:UnregisterEvent("UNIT_NAME_UPDATE")
					frame:UnregisterEvent("UNIT_PORTRAIT_UPDATE")
					frame:UnregisterEvent("UNIT_DISPLAYPOWER")
					frame:UnregisterAllEvents()
					frame:Hide()
				end
			else
			    self:Unhook("RaidOptionsFrame_UpdatePartyFrames")
				for partynum=1,4 do
					local frame = getglobal("PartyMemberFrame"..partynum)
					frame:RegisterEvent("PARTY_MEMBERS_CHANGED")
					frame:RegisterEvent("PARTY_LEADER_CHANGED")
					frame:RegisterEvent("PARTY_MEMBER_ENABLE")
					frame:RegisterEvent("PARTY_MEMBER_DISABLE")

					frame:RegisterEvent("PARTY_LOOT_METHOD_CHANGED")
					frame:RegisterEvent("UNIT_PVP_UPDATE")
					frame:RegisterEvent("UNIT_AURA")
					frame:RegisterEvent("UNIT_PET")
					frame:RegisterEvent("VARIABLES_LOADED")
			
					frame:RegisterEvent("UNIT_NAME_UPDATE")
					frame:RegisterEvent("UNIT_PORTRAIT_UPDATE")
					frame:RegisterEvent("UNIT_DISPLAYPOWER")

					UnitFrame_OnEvent("PARTY_MEMBERS_CHANGED")
			
--					if UnitExists("party"..partynum) then PartyMemberFrame_UpdateMember() end
				end
			end
	end,
	
	--[[---------------------------------------------------------------------------------
	  Style
	------------------------------------------------------------------------------------]]
	
	SetPoint = function(self,element, point, relativeTo, relativePoint, offsetx, offsety)
	--	if ( element ~= nil ) then
			element:ClearAllPoints()
			element:SetPoint(point, relativeTo, relativePoint, offsetx, offsety)
	--	end
	end,
	
	SetEndCaps = function(self,name)
		if ( MiniGroup2.ShowEndcaps == 1 ) then
			getglobal(name.."_HealthEndcapLeft"):Show()
			getglobal(name.."_HealthEndcapRight"):Show()
			getglobal(name.."_ManaEndcapLeft"):Show()
			getglobal(name.."_ManaEndcapRight"):Show()
		else
			getglobal(name.."_HealthEndcapLeft"):Hide()
		   getglobal(name.."_HealthEndcapRight"):Hide()
		   getglobal(name.."_ManaEndcapLeft"):Hide()
		   getglobal(name.."_ManaEndcapRight"):Hide()
		end
	end,
		
	Layout = function(self)
		self:LayoutXPBars()
	
		MiniGroup2:ApplyStyle(MGplayer)
		MiniGroup2:ApplyStyle(MGpet)
		MiniGroup2:ApplyStyle(MGtarget)	
		MiniGroup2:ApplyStyle(MGtargettarget)
			
		for id = 1, 4 do
			MiniGroup2:ApplyStyle(getglobal("MGparty"..id))
		end
	
		for id = 1, 4 do
			MiniGroup2:ApplyStyle(getglobal("MGpartypet"..id))
		end
	
		if MGraid1 then
			for id = 1, 40 do
				MiniGroup2:ApplyStyle(getglobal("MGraid"..id))
				MiniGroup2:ApplyStyle(getglobal("MGraidpet"..id))
			end
		end	
				
			self:LayoutResize()
			self:LayoutBars()	
			self:LayoutColor()
			self:LayoutBorders(MGplayer:GetWidth(),MGplayer:GetHeight())
			MiniGroup2:UpdateClass("player")
			for key,val in UnitFrames do
				self:AuraUpdate(val)
			end
	end,
	
	LayoutResize = function(self)
		self:UnitFrameResize("player")
		self:UnitFrameResize("pet")
		self:UnitFrameResize("target")
		self:UnitFrameResize("targettarget")
		
		
		for id = 1, 4 do
			self:UnitFrameResize("party"..id)
			self:UnitFrameResize("partypet"..id)
		end
			
		if MGraid1 then	
			for id = 1, 40 do
				self:UnitFrameResize("raid"..id)
				self:UnitFrameResize("raidpet"..id)
			end
		end
	end,

	UnitGrouping = function(self)
		local PlayerGrouping = MiniGroup2.PlayerGrouping
		local PetGrouping = MiniGroup2.PetGrouping
		local PartyGrouping = MiniGroup2.PartyGrouping
		local PartyPetGrouping = MiniGroup2.PartyPetGrouping
		local RaidGrouping = MiniGroup2.RaidGrouping
		local RaidPetGrouping = MiniGroup2.RaidPetGrouping
		local frameGrowth = self.GetOpt("FrameGrowth")
		local RelativeFrame = "none"
		local GroupHeight = 0
		local GroupStart = nil
		local Relation1 = "TOPLEFT"
		local Relation2 = "BOTTOMLEFT"
		local GroupFrameRelation1 = "TOPLEFT"
		local GroupFrameRelation2 = "TOPLEFT"
		local x = 0
		local y = 0
		local adjustment = 9 - MiniGroup2.GroupSpace
		local adjustment2 = 9 - MiniGroup2.GroupSpace
		local MergeBorders = 0
	
		if not MG_Colors then
			MG_Colors = {}
		end
		MGFrames["MGplayer"].Background = 1
		MGFrames["MGpet"].Background = 1
		MGFrames["MGparty"].Background = 1
		MGFrames["MGpartypet"].Background = 1
		
		if MiniGroup2.GroupSpace == 0 then
			MergeBorders = 1
		end
		
		local PetframeWidth = MGFrames["MGpet"].FrameWidth	
		local PartypetframeWidth = MGFrames["MGpartypet"].FrameWidth	
		local PlayerframeWidth = MGFrames["MGplayer"].FrameWidth	
		local PartyframeWidth = MGFrames["MGparty"].FrameWidth	

		MGpartygroup:SetWidth(math.max(PartyframeWidth,PartypetframeWidth))
		MGplayergroup:SetWidth(PlayerframeWidth)
	
		local playerHeight = MGplayer:GetHeight()
		
		local partyHeight = MGFrames["MGparty"].FrameHeight

		
		local modifier = 1
		
		MGpartygroup:SetFrameLevel(0)
		MGplayergroup:SetFrameLevel(0)
		MGpartygroup:Hide()
		MGplayergroup:Hide()
		
		local unitFrame, unitFrameName	
		
		getglobal("MGpet").GroupStart = nil
		
		for i=1,4 do
			if getglobal("MGparty"..i) then
				getglobal("MGparty"..i).GroupStart = nil
			end
			if getglobal("MGpartypet"..i) then
				getglobal("MGpartypet"..i).GroupStart = nil
			end
		end
	
		if frameGrowth == FrameGrowth_Up then
			adjustment = -adjustment
			modifier = -1
			Relation1 = "BOTTOMLEFT"
			Relation2 = "TOPLEFT"
			GroupFrameRelation1 = "BOTTOMLEFT"
			GroupFrameRelation2 = "BOTTOMLEFT"			
		elseif frameGrowth == FrameGrowth_Down then
			Relation1 = "TOPLEFT"
			Relation2 = "BOTTOMLEFT"
			GroupFrameRelation1 = "TOPLEFT"
			GroupFrameRelation2 = "TOPLEFT"		
		end
		
		for i=1,4 do
			if self:ShouldUnitBeVisible("party1") == 1 then
				if PlayerGrouping == 1 and self:ShouldUnitBeVisible("player") == 1 then
					MGpartygroup:ClearAllPoints()	
					RelativeFrame = "MGplayer"
					GroupStart = MGplayer
					GroupHeight = MGplayer:GetHeight()
					MGpartygroup:SetHeight(GroupHeight)
					MGpartygroup:Show()
					MGpartygroup:SetPoint(GroupFrameRelation1, MGplayer, GroupFrameRelation2, x, y)
					MGFrames["MGplayer"].Background = 0
				end
			end
		end
		
		if PetGrouping == PetGrouping_WithOwner and self:ShouldUnitBeVisible("player") == 1 then
			if self:ShouldUnitBeVisible("pet") == 1 then
				
				GroupStart = MGplayer
				
				RelativeFrame = "MGplayer"
				unitFrame = getglobal("MGpet")
	
				if RelativeFrame ~= "none" then
					unitFrame:ClearAllPoints()
					unitFrame:SetPoint(Relation1, getglobal(RelativeFrame), Relation2, x, y+adjustment+(MiniGroup2.GroupSpace*modifier))
				else
	
					GroupStart = unitFrame			
				end
				unitFrame.GroupStart = GroupStart
				MGFrames[string.gsub(unitFrame:GetName(),"%d+","")].Background = 0
				if PlayerGrouping == 1 and PartyGrouping == 1 and self:ShouldUnitBeVisible("party1") == 1 then
					RelativeFrame = "MGpet"
					GroupHeight = GroupHeight + MGpet:GetHeight() - adjustment2 - MiniGroup2.GroupSpace
					MGpartygroup:SetHeight(GroupHeight)
					MGpartygroup:ClearAllPoints()
					MGpartygroup:Show()
					MGpartygroup:SetPoint(GroupFrameRelation1, MGplayer, GroupFrameRelation2, x, y)
					MGplayergroup:SetWidth(math.max(PlayerframeWidth,PetframeWidth,PartyframeWidth))
				else
					GroupHeight = MGplayer:GetHeight() + MGpet:GetHeight() - adjustment2 - MiniGroup2.GroupSpace
					MGplayergroup:ClearAllPoints()
					MGplayergroup:Show()
					MGplayergroup:SetPoint(GroupFrameRelation1, MGplayer, GroupFrameRelation2, x, y)	
					MGplayergroup:SetHeight(GroupHeight)					
					RelativeFrame = "none"
					GroupHeight = 0
					MGplayergroup:SetWidth(math.max(PlayerframeWidth,PetframeWidth))
				end		
			end		
		end
		
		if PartyGrouping == 1 and self:ShouldUnitBeVisible("party1") == 1 then	
			for i=1,4 do
				if self:ShouldUnitBeVisible("party"..i) == 1 then
					unitFrame = getglobal("MGparty"..i)
					RelativeHeight = unitFrame:GetHeight()
	
					if RelativeFrame ~= "none" then
						unitFrame:ClearAllPoints()
						unitFrame:SetPoint(Relation1, getglobal(RelativeFrame), Relation2, x, y+adjustment)
					else
						MGpartygroup:ClearAllPoints()
						MGpartygroup:Show()
						MGpartygroup:SetPoint(GroupFrameRelation1, unitFrame, GroupFrameRelation2, x, y)
						GroupStart = unitFrame
						GroupHeight = adjustment2
					end
					unitFrame.GroupStart = GroupStart
					MGFrames[string.gsub(unitFrame:GetName(),"%d+","")].Background = 0
					RelativeFrame = "MGparty"..i
					GroupHeight = GroupHeight + unitFrame:GetHeight() - adjustment2
					MGpartygroup:SetHeight(GroupHeight)
					
				end
				if PartyPetGrouping == PetGrouping_WithOwner then
					if self:ShouldUnitBeVisible("partypet"..i) == 1 then
						unitFrame = getglobal("MGpartypet"..i)
		
						if RelativeFrame ~= "none" then
							unitFrame:ClearAllPoints()
							unitFrame:SetPoint(Relation1, getglobal(RelativeFrame), Relation2, x, y+adjustment+(MiniGroup2.GroupSpace*modifier))
						end
						MGFrames[string.gsub(unitFrame:GetName(),"%d+","")].Background = 0
						unitFrame.GroupStart = GroupStart														
						RelativeFrame = "MGpartypet"..i
						GroupHeight = GroupHeight + unitFrame:GetHeight() - adjustment2 - MiniGroup2.GroupSpace
						MGpartygroup:SetHeight(GroupHeight)	
					end
				end				
			end
		end


		
		RelativeFrame = "none"
		GroupHeight = 0
	
		if PartyPetGrouping == PetGrouping_WithOwner and PartyGrouping == 0 then
			for i=1,4 do
				if self:ShouldUnitBeVisible("party"..i) == 1 then
					if self:ShouldUnitBeVisible("partypet"..i) == 1 then
						unitFrame = getglobal("MGpartypet"..i)
		
						unitFrame:ClearAllPoints()
						unitFrame:SetPoint(Relation1, getglobal("MGparty"..i), Relation2, x, y+adjustment+(MiniGroup2.GroupSpace*modifier))													
						RelativeFrame = "none"
						MGFrames[string.gsub(unitFrame:GetName(),"%d+","")].Background = 0
						GroupStart = getglobal("MGparty"..i)
						unitFrame.GroupStart = GroupStart
						GroupHeight = getglobal("MGparty"..i):GetHeight() + unitFrame:GetHeight() - adjustment2 - MiniGroup2.GroupSpace
						
					end
				end
			end
		end				
		
		RelativeFrame = "none"
		GroupHeight = 0

		if PlayerGrouping == 1 and PartyGrouping == 1 and self:ShouldUnitBeVisible("party1") == 1 then
			self:LayoutBorders(MGpartygroup:GetWidth(),MGpartygroup:GetHeight())
		elseif self:ShouldUnitBeVisible("pet") == 1 and PetGrouping == PetGrouping_WithOwner then
			self:LayoutBorders(MGplayergroup:GetWidth(),MGplayergroup:GetHeight())
		else
			self:LayoutBorders(MGplayer:GetWidth(),MGplayer:GetHeight())
		end
		
		MG_StatusTexture:ClearAllPoints()
		MG_StatusTexture:SetPoint(Relation1, MGplayer, Relation1,0,0)
		self:UpdateColors()	
	end,
	
	RaidUnitGrouping = function(self)
		if not MGraid1 then
			return
		end
		local RaidGrouping = MiniGroup2.RaidGrouping
		local RaidPetGrouping = MiniGroup2.RaidPetGrouping
		local frameGrowth = self.GetOpt("FrameGrowth")
		local RelativeFrame = "none"
		local GroupHeight = 0
		local GroupStart = nil
		local Relation1 = "TOPLEFT"
		local Relation2 = "BOTTOMLEFT"
		local GroupFrameRelation1 = "TOPLEFT"
		local GroupFrameRelation2 = "TOPLEFT"
		local x = 0
		local y = 0
		local adjustment = 7 - MiniGroup2.GroupSpace
		local adjustment2 = 7 - MiniGroup2.GroupSpace
		local unitFrame, unitFrameName	
		local RaidframeWidth = MGFrames["MGraid"].FrameWidth	
		local RaidPetframeWidth = MGFrames["MGraidpet"].FrameWidth	
		local frameWidth = 0
		local MergeBorders = 0
		local modifier = 1
		local updated = {}
		
		MGFrames["MGraid"].Background = 1
		MGFrames["MGraidpet"].Background = 1
		
		if MiniGroup2.GroupSpace == 0 then
			MergeBorders = 1
		end
		
		if MiniGroup2.RaidPetHideFrame == 0 then
			frameWidth = math.max(RaidframeWidth, RaidPetframeWidth)
		else
			frameWidth = RaidframeWidth
		end
		
	--	if MGraid1 then
			for i=1,40 do
				if getglobal("MGraid"..i) then
					getglobal("MGraid"..i).GroupStart = nil
				end
				if getglobal("MGraidpet"..i) then
					getglobal("MGraidpet"..i).GroupStart = nil
				end
			end
	--	end
		
		if frameGrowth == FrameGrowth_Up then
			adjustment = -adjustment
			modifier = -1
			anchoradjustment = -anchoradjustment
			Relation1 = "BOTTOMLEFT"
			Relation2 = "TOPLEFT"
			GroupFrameRelation1 = "BOTTOMLEFT"
			GroupFrameRelation2 = "BOTTOMLEFT"			
		elseif frameGrowth == FrameGrowth_Down then
			Relation1 = "TOPLEFT"
			Relation2 = "BOTTOMLEFT"
			GroupFrameRelation1 = "TOPLEFT"
			GroupFrameRelation2 = "TOPLEFT"		
		end
		
		local subgroup = {}
	
	--	if MGraid1 then	
			for i = 1,8 do
				subgroup[i] = {}
				subgroup[i].start = "none"
				subgroup[i].relativeframe = "none"
				subgroup[i].height = 0
				local MGraidgroupframe = getglobal("MGraidgroup"..i)
				MGraidgroupframe:Hide()
				MGraidgroupframe:SetFrameLevel(0)
				MGraidgroupframe:SetWidth(frameWidth)
				getglobal("MGraid_achor"..i):SetWidth(frameWidth)
				if self.GetOpt("RaidByClass") == 0 then 
					getglobal("MGraid_achor"..i.."Count"):SetText("Group "..i)
				else
					getglobal("MGraid_achor"..i.."Count"):SetText(MG_classes[i].."s")
				end
				if self.GetOpt("AlwaysShowRaid") == 1 then
					getglobal("MGraid_achor"..i):Show()
				else
					getglobal("MGraid_achor"..i):Hide()
				end
			end
			
			if RaidGrouping == 1 then
				for i=1,40 do
					local name, rank, unitsubgroup, level, unitclass, fileName, zone, online, isDead = GetRaidRosterInfo(i)
					local unit = "raid"..i
					if self:ShouldUnitBeVisible(unit) == 1 then
						local unitFrame = getglobal("MGraid"..i)
						
						if UnitExists(unit) and getglobal("MG"..unit) then
							if self.GetOpt("RaidByClass") == 0 then 
								for subnumber=1,8 do
									local MGraidgroupframe = getglobal("MGraidgroup"..subnumber)
									if subnumber == unitsubgroup then
										if subgroup[subnumber].start ~= "none" then
											unitFrame:ClearAllPoints()
											unitFrame:SetPoint(Relation1, getglobal(subgroup[subnumber].relativeframe), Relation2, x, y+adjustment)					
										else
											MGraidgroupframe:ClearAllPoints()
											MGraidgroupframe:Show()
											if self.GetOpt("ShowAnchors") == 1 then
												getglobal("MGraid_achor"..subnumber):Show()
											end
											unitFrame:ClearAllPoints()
											unitFrame:SetPoint(Relation1, getglobal("MGraid_achor"..subnumber), Relation2, x, anchoradjustment)									
											
											MGraidgroupframe:SetPoint(GroupFrameRelation1, unitFrame, GroupFrameRelation2, x, y)
											subgroup[subnumber].start = getglobal("MGraid_achor"..subnumber)
											subgroup[subnumber].height = adjustment2
										end
		
										MGFrames[string.gsub(unitFrame:GetName(),"%d+","")].Background = 0
										unitFrame.GroupStart = subgroup[subnumber].start	
										subgroup[subnumber].relativeframe = "MGraid"..i
										subgroup[subnumber].height = subgroup[subnumber].height + unitFrame:GetHeight() - adjustment2
										MGraidgroupframe:SetHeight(subgroup[subnumber].height)
	
										if UnitName(unit) == UnitName("player") then
											getglobal("MGraid_achor"..subnumber.."Count"):SetText(getglobal("MGraid_achor"..subnumber.."Count"):GetText().." *")
										end									
									end
								end
							else
								for key, value in MG_classes do
									local MGraidgroupframe = getglobal("MGraidgroup"..key)
									local _, englishClass = UnitClass(unit);
									if string.lower(value) == string.lower(englishClass) then
										if subgroup[key].start ~= "none" then
											unitFrame:ClearAllPoints()
											unitFrame:SetPoint(Relation1, getglobal(subgroup[key].relativeframe), Relation2, x, y+adjustment)					
										else
											MGraidgroupframe:ClearAllPoints()
											MGraidgroupframe:Show()
											if self.GetOpt("ShowAnchors") == 1 then
												getglobal("MGraid_achor"..key):Show()
											end
											unitFrame:ClearAllPoints()
											unitFrame:SetPoint(Relation1, getglobal("MGraid_achor"..key), Relation2, x, adjustment)									
											
											MGraidgroupframe:SetPoint(GroupFrameRelation1, unitFrame, GroupFrameRelation2, x, y)
											subgroup[key].start = getglobal("MGraid_achor"..key)
											subgroup[key].height = adjustment2
										end
		
										MGFrames[string.gsub(unitFrame:GetName(),"%d+","")].Background = 0
										unitFrame.GroupStart = subgroup[key].start	
										subgroup[key].relativeframe = "MGraid"..i
										subgroup[key].height = subgroup[key].height + unitFrame:GetHeight() - adjustment2
										MGraidgroupframe:SetHeight(subgroup[key].height)
									end
								end						
							end
							if self:ShouldUnitBeVisible("raidpet"..i) == 1 then
								unitFrame = getglobal("MGraidpet"..i)
						
								unitFrame:ClearAllPoints()
								unitFrame:SetPoint(Relation1, getglobal(subgroup[unitsubgroup].relativeframe), Relation2, x, y+adjustment+(MiniGroup2.GroupSpace*modifier))
								unitFrame.GroupStart = subgroup[unitsubgroup].start
								MGFrames[string.gsub(unitFrame:GetName(),"%d+","")].Background = 0
								subgroup[unitsubgroup].relativeframe = "MGraidpet"..i
								subgroup[unitsubgroup].height = subgroup[unitsubgroup].height + unitFrame:GetHeight() - adjustment2 - MiniGroup2.GroupSpace
								getglobal("MGraidgroup"..unitsubgroup):SetHeight(subgroup[unitsubgroup].height)								
							end
						else
							if getglobal("MGraid"..i) then
								getglobal("MGraid"..i).GroupStart = nil
							end
						end
					end
				end
			end
	--	end
		RelativeFrame = "none"
		
		if RaidPetGrouping == PetGrouping_WithOwner and RaidGrouping == 0 then
			for i=1,40 do
				if self:ShouldUnitBeVisible("raid"..i) then
					if self:ShouldUnitBeVisible("raidpet"..i) then
						unitFrame = getglobal("MGraidpet"..i)
						
						unitFrame:ClearAllPoints()
						unitFrame:SetPoint(Relation1, getglobal("MGraid"..i), Relation2, x, y+adjustment +(MiniGroup2.GroupSpace*modifier))
							
						RelativeFrame = "none"
						MGFrames[string.gsub(unitFrame:GetName(),"%d+","")].Background = 0
						GroupStart = getglobal("MGraid"..i)
						unitFrame.GroupStart = GroupStart	
						GroupHeight = getglobal("MGraid"..i):GetHeight() + unitFrame:GetHeight() - adjustment2 - MiniGroup2.GroupSpace
					end
				end
			end
		end
	
		for i = 1,8 do 
			if subgroup[i].start == "none" then
				getglobal("MGraidgroup"..i):SetHeight(0);
			end
		end
		self:UpdateColors()
		self:AnchorUpdate()		
	end,
	
	
	IsGrouped = function(self,unit)
		if ( unit == "player" ) then
			if ( (MiniGroup2.PlayerGrouping == 1 and MiniGroup2.PartyGrouping == 1 and self:ShouldUnitBeVisible("party1") == 1) 
			or   (MGpet:IsVisible() and MiniGroup2.PetGrouping == PetGrouping_WithOwner ) ) then
				return 1
			else
				return nil
			end
	
		elseif ( unit == "pet" ) then
			if ( MiniGroup2.PetGrouping == PetGrouping_WithOwner ) then
				if ( MiniGroup2.PlayerGrouping == 0 and not MGplayer:IsVisible() ) then
					return nil
				elseif ( not MGplayer:IsVisible() and self:ShouldUnitBeVisible("party1") == 0 ) then
					return nil
				else
					return 1
				end
			elseif ( MiniGroup2.PetGrouping == PetGrouping_NotGrouped ) then
				return nil
			else
				return nil
			end
			
		elseif ( string.find(unit, "party") ~= nil ) then
			if ( (MiniGroup2.PartyGrouping == 1 and MiniGroup2.PlayerGrouping == 1 and MGplayer:IsVisible() )
			or   (MiniGroup2.PartyGrouping == 1 and self:ShouldUnitBeVisible("party1") == 1 ) ) then
				return 1
			else
				return nil
			end
		elseif ( string.find(unit, "raid") ~= nil and string.find(unit, "pet") == nil ) then
			if MiniGroup2.RaidGrouping == 1 then
				return 1
			else
				return nil
			end
		elseif ( string.find(unit, "raidpet") ~= nil ) then
			if MiniGroup2.RaidPetGrouping == 1 then
				return 1
			else
				return nil
			end
		else
			return nil
		end
	end,
	
	UnitFrameResize = function(self,unit)
		if not getglobal("MG"..unit) then return end
		local frameName = "MG"..unit
		local highlightName = "MG"..unit.."Highlight"
		local oorName = "MG"..unit.."OOR"
		local debuffName = "MG"..unit.."Debuff"
		local groupName = string.gsub(frameName, "%d", "")
		
		local frameHeight = MGFrames[groupName].FrameHeight
		local frameWidth = MGFrames[groupName].FrameWidth	
		local auraStyle = MiniGroup2[(self:UnitCap(unit).."AuraStyle")]
		local auraPos = MiniGroup2[(self:UnitCap(unit).."AuraPos")]
		local Aura1 = getglobal("MG"..unit.."_Aura1")
		local AuraSlotHeight = 0
		local space = 0
		local grouped = self:IsGrouped(unit)
		
		if getglobal(frameName):GetRight() and auraPos == AuraPos_Auto then
			local pos = ((getglobal(frameName):GetRight()-(frameWidth/2))*getglobal(frameName):GetScale())/(UIParent:GetRight())
			if  pos < 0.5 then
				auraPos = AuraPos_Right
			end
			if  pos >= 0.5 then
				auraPos = AuraPos_Left
			end
		end
		
		local scale = frameWidth/170
		for i=1,20 do
			getglobal("MG"..unit.."_Aura"..i):SetScale(scale)
		end
		
		if ( grouped == 1 ) then
			if ( (auraPos == AuraPos_Above or auraPos == AuraPos_Below) ) then
				auraPos = AuraPos_Inside
			end
		end
		
		if ( auraPos == AuraPos_Inside ) then
			if ( auraStyle == AuraStyle_TwoLines or auraStyle == AuraStyle_TwoDebuff) then
				AuraSlotHeight = 33
			elseif ( auraStyle == AuraStyle_Hide ) then
				AuraSlotHeight = 0
			else
				AuraSlotHeight = 16
			end
		elseif ( auraPos == AuraPos_Left ) then
			AuraSlotHeight = 0
		elseif ( auraPos == AuraPos_Right ) then
			AuraSlotHeight = 0
		elseif ( auraPos == AuraPos_Above ) then
			AuraSlotHeight = 0
		elseif ( auraPos == AuraPos_Below ) then
			AuraSlotHeight = 0
		end
	
		if ( auraPos == AuraPos_Inside ) then
			if ( auraStyle == AuraStyle_TwoLines or auraStyle == AuraStyle_TwoDebuff) then
				space = 23
			else
				space = 6
			end
		elseif ( auraPos == AuraPos_Below ) then
				space = -1
		elseif ( auraPos == AuraPos_Above ) then
			space = 0
			
		elseif ( auraPos == AuraPos_Right or auraPos == AuraPos_Left ) then
			if ( auraStyle == AuraStyle_TwoLines or auraStyle == AuraStyle_TwoDebuff) then
				space = 7.5
			else
				space = 0
			end
		else
			space = 6
		end
		
		frameHeight = (frameHeight + (AuraSlotHeight*scale))
		
		getglobal(frameName):SetWidth(frameWidth)
		getglobal(highlightName):SetWidth(frameWidth)
		getglobal(oorName):SetWidth(frameWidth-6)
		
		--getglobal(oorName):SetWidth(128)
		--getglobal(oorName):SetHeight(16)

		getglobal(debuffName):SetWidth(frameWidth)
		getglobal(debuffName):SetHeight(frameHeight-5)
		
		getglobal(frameName):SetHeight(frameHeight)
		getglobal(highlightName):SetHeight(frameHeight-5)
		getglobal(highlightName):SetPoint("CENTER", frameName, "CENTER", 0, 0)
		getglobal(oorName):SetHeight(frameHeight-9)
		getglobal(oorName):SetPoint("CENTER", frameName, "CENTER", 0, 0)
		
	--	if unit == "player" or unit == "target" or unit == "targettarget" or unit == "pet" then
			self:AuraPosUpdate(unit)
	--	end
	end,
	
	AuraPosUpdate = function(self,unit)
		local frameName = "MG"..unit
		local groupName = string.gsub(frameName, "%d", "")	
		local frameHeight = MGFrames[groupName].FrameHeight
		local frameWidth = MGFrames[groupName].FrameWidth	
		local auraPos = MiniGroup2[(self:UnitCap(unit).."AuraPos")]
		local Aura1 = getglobal("MG"..unit.."_Aura1")
		local space = 0
		local auraStyle = MiniGroup2[(self:UnitCap(unit).."AuraStyle")]
		local grouped = self:IsGrouped(unit)
	
		if auraPos == AuraPos_Auto and getglobal(frameName):GetRight() then
			local pos = ((getglobal(frameName):GetRight()-(frameWidth/2))*getglobal(frameName):GetScale())/(UIParent:GetRight())
			if  pos < 0.5 then
				auraPos = AuraPos_Right
			end
			if  pos >= 0.5 then
				auraPos = AuraPos_Left
			end
		end 
	
		if ( grouped == 1 ) then
			if ( (auraPos == AuraPos_Above or auraPos == AuraPos_Below) ) then
				auraPos = AuraPos_Inside
			end
		end
		
		if ( auraPos == AuraPos_Inside ) then
			if ( auraStyle == AuraStyle_TwoLines or auraStyle == AuraStyle_TwoDebuff ) then
				space = 23
			else
				space = 6
			end
		elseif ( auraPos == AuraPos_Below ) then
				space = -1
		elseif ( auraPos == AuraPos_Above ) then
			space = 0
			
		elseif ( auraPos == AuraPos_Right or auraPos == AuraPos_Left ) then
			if ( auraStyle == AuraStyle_TwoLines or auraStyle == AuraStyle_TwoDebuff ) then
				space = 7.5
			else
				space = 0
			end
		else
			space = 6
		end
	
	
		Aura1:ClearAllPoints()
		
		if ( auraPos == AuraPos_Below ) then
			if ( frameGrowth == FrameGrowth_Down and grouped == 1 ) then
				Aura1:SetPoint("BOTTOMLEFT",getglobal(frameName),"BOTTOMLEFT",5,space)
			else
				Aura1:SetPoint("TOPLEFT",getglobal(frameName),"BOTTOMLEFT",5,-space)
			end
		elseif ( auraPos == AuraPos_Above ) then
			Aura1:SetPoint("BOTTOMLEFT",getglobal(frameName),"TOPLEFT",5,space)
		elseif ( auraPos == AuraPos_Inside ) then
			Aura1:SetPoint("BOTTOMLEFT",getglobal(frameName),"BOTTOMLEFT",5,space)
		elseif ( auraPos == AuraPos_Right ) then
			Aura1:SetPoint("LEFT",getglobal(frameName),"RIGHT",0, space)
		elseif ( auraPos == AuraPos_Left ) then
			Aura1:SetPoint("RIGHT",getglobal(frameName),"LEFT",0, space)
		end
	
	
		if ( auraPos == AuraPos_Left ) then
			for i=2,20 do
				getglobal("MG"..unit.."_Aura"..i):ClearAllPoints()
				if i == 11 then
					getglobal("MG"..unit.."_Aura"..i):SetPoint("TOP",getglobal("MG"..unit.."_Aura"..1),"BOTTOM",0,-1)
				else
					getglobal("MG"..unit.."_Aura"..i):SetPoint("RIGHT",getglobal("MG"..unit.."_Aura"..i-1),"LEFT",1,0)
				end
			end	
		else
			for i=2,20 do
				getglobal("MG"..unit.."_Aura"..i):ClearAllPoints()
				if i == 11 then
					if auraPos == AuraPos_Above then
						getglobal("MG"..unit.."_Aura"..i):SetPoint("BOTTOM",getglobal("MG"..unit.."_Aura"..1),"TOP",0,1)
					else
						getglobal("MG"..unit.."_Aura"..i):SetPoint("TOP",getglobal("MG"..unit.."_Aura"..1),"BOTTOM",0,-1)
					end
				else
					getglobal("MG"..unit.."_Aura"..i):SetPoint("LEFT",getglobal("MG"..unit.."_Aura"..i-1),"RIGHT",1,0)
				end
			end	
		end
	end,

	LayoutUnitBars = function(self,unit)
		local width = 0
	
			local name = "MG"..unit
			local groupname = "MG"..string.gsub(unit,"%d+","")
			local textstyle = self.GetOpt(self:UnitCap(unit).."StatusTextStyle")
			local style = MiniGroup2[(self:UnitCap(unit) .. "FrameStyle")]
						
			if ( textstyle ~= StatusTextStyle_Hide ) then			
				if ( MGFrames[self:FrameType(unit)] and MGFrames[self:FrameType(unit)].ResizeBars == false) then 
					width = 0
				elseif ( textstyle == StatusTextStyle_Absolute or textstyle == StatusTextStyle_Difference ) then
					width = 60 --92
				else
					width = 28 --124
				end
			end
			if ( width < 0 ) then width = 0 end
					getglobal(name.."_HealthBar"):SetWidth(getglobal(name.."_HealthBar"):GetWidth() - width)
					getglobal(name.."_HealthBar_BG"):SetWidth(getglobal(name.."_HealthBar_BG"):GetWidth() - width)
					getglobal(name.."_ManaBar"):SetWidth(getglobal(name.."_ManaBar"):GetWidth() - width)
					getglobal(name.."_ManaBar_BG"):SetWidth(getglobal(name.."_ManaBar_BG"):GetWidth() - width)
					
					getglobal(name.."_HealthEndcapLeft"):SetHeight( getglobal(name.."_HealthBar_BG"):GetHeight() )
					getglobal(name.."_HealthEndcapRight"):SetHeight( getglobal(name.."_HealthBar_BG"):GetHeight() )
					getglobal(name.."_ManaEndcapLeft"):SetHeight( getglobal(name.."_ManaBar_BG"):GetHeight() )
					getglobal(name.."_ManaEndcapRight"):SetHeight( getglobal(name.."_ManaBar_BG"):GetHeight() )
					getglobal(name.."_HealthEndcapRight"):SetPoint("TOPLEFT",name.."_HealthBar","TOPRIGHT",0,0)
					getglobal(name.."_ManaEndcapRight"):SetPoint("TOPLEFT",name.."_ManaBar","TOPRIGHT",0,0)		
	end,
	
	LayoutBars = function(self)
		for key, value in UnitFrames do
			self:LayoutUnitBars(value)
		end					
	end,
	
	LayoutXPBars = function(self)
		MGplayer_XPEndcapLeft:SetHeight( MGplayer_XPBar_BG:GetHeight() )
		MGplayer_XPEndcapRight:SetHeight( MGplayer_XPBar_BG:GetHeight() )
		if ( self.GetOpt("ShowPlayerXP") == 1 ) then		
			MGplayer_XPBar:Show()
			if ( GetXPExhaustion() ) then
				MGplayer_XPBar_Rest:Show()
			end		
			MGplayer_XPBar_BG:Show()
	
			if ( MiniGroup2.ShowEndcaps == 1 ) then
				MGplayer_XPEndcapLeft:Show()
				MGplayer_XPEndcapRight:Show()
			else
				MGplayer_XPEndcapLeft:Hide()
				MGplayer_XPEndcapRight:Hide()
			end
			MiniGroup2:PlayerXPUpdate()
		else
			MGplayer_XPBar:Hide()
			MGplayer_XPBar_Rest:Hide()		
			MGplayer_XPBar_BG:Hide()
	
			MGplayer_XPEndcapLeft:Hide()
			MGplayer_XPEndcapRight:Hide()
		end
	
		MGpet_XPEndcapLeft:SetHeight( MGpet_XPBar_BG:GetHeight() )
		MGpet_XPEndcapRight:SetHeight( MGpet_XPBar_BG:GetHeight() )
		if ( self.GetOpt("ShowPetXP") == 1 ) then
			MGpet_XPBar:ClearAllPoints()
			MGpet_XPBar:SetPoint("LEFT","MGpet_XPBar_BG","LEFT")
			MGpet_XPBar:Show()
			MGpet_XPBar_BG:Show()
			if ( MiniGroup2.ShowEndcaps == 1 ) then
				MGpet_XPEndcapLeft:Show()
				MGpet_XPEndcapRight:Show()
			else
				MGpet_XPEndcapLeft:Hide()
				MGpet_XPEndcapRight:Hide()
			end
			self:PetXPUpdate()
		else
			MGpet_XPBar:Hide()
			MGpet_XPBar_BG:Hide()
			MGpet_XPEndcapLeft:Hide()
			MGpet_XPEndcapRight:Hide()
		end
	end,

	UpdateUnitScale = function(self,unit)
		local scale
		local raidscale
		local table = self.GetOpt("Scaling")
		
		if ( table.UseMGScale == 0 ) then
			scale = tonumber(GetCVar("uiscale"))
			if ( GetCVar("useUiScale") == "1" ) then
				scale = tonumber(GetCVar("uiscale"))
			else
				scale = tonumber(UIParent:GetScale())
			end
		else
			scale = table.MGScale
		end
		
		if ( table.UseRaidScale == 0 ) then
			raidscale = scale
		else
			raidscale = table.RaidScale
		end	
		if not string.find(unit,"raid") then
			self:SetEffectiveScale(getglobal("MG"..unit),scale)
			--getglobal("MG"..unit):SetScale(scale)
		else
			self:SetEffectiveScale(getglobal("MG"..unit),raidscale)
			--getglobal("MG"..unit):SetScale(scale)
		end
		self:SaveFramePos(getglobal("MG"..unit))
	end,
	
	UpdateScale = function(self,check)
		if check or UIParent:GetScale() ~= ScaleValue then
			--DEFAULT_CHAT_FRAME:AddMessage("UpdateScale")
			local scale
			local raidscale
			local table = self.GetOpt("Scaling")
			
			if ( table.UseMGScale == 0 ) then
				scale = tonumber(GetCVar("uiscale"))
				if ( GetCVar("useUiScale") == "1" ) then
					scale = tonumber(GetCVar("uiscale"))
				else
					scale = tonumber(UIParent:GetScale())
				end
			else
				scale = table.MGScale
			end
			
			if ( table.UseRaidScale == 0 ) then
				raidscale = scale
			else
				raidscale = table.RaidScale
			end	
		
		--[[	MGplayer:SetScale(scale)
			MGpet:SetScale(scale)
			MGtarget:SetScale(scale)
			MGtargettarget:SetScale(scale)
			MGpartygroup:SetScale(scale)
			
			for i=1,4 do
				getglobal("MGparty"..i):SetScale(scale)
				getglobal("MGpartypet"..i):SetScale(scale)
			end
			if MGraid1 then
				for i=1,40 do
					getglobal("MGraid"..i):SetScale(raidscale)
					getglobal("MGraidpet"..i):SetScale(raidscale)			
				end
				for i=1,8 do
					getglobal("MGraidgroup"..i):SetScale(raidscale)
					getglobal("MGraid_achor"..i):SetScale(raidscale)							
				end
			end]]
			
			self:SetEffectiveScale(MGplayer,scale)	
			self:SetEffectiveScale(MGpet,scale)
			self:SetEffectiveScale(MGtarget,scale)
			self:SetEffectiveScale(MGtargettarget,scale)
			self:SetEffectiveScale(MGpartygroup,scale)
			self:SetEffectiveScale(MGplayergroup,scale)
			
			for i=1,4 do
				local ScaleFrame = getglobal("MGpartypet"..i)
				self:SetEffectiveScale(getglobal("MGpartypet"..i),scale)			
				self:SaveFramePos(ScaleFrame)
				
				ScaleFrame = getglobal("MGparty"..i)
				self:SetEffectiveScale(getglobal("MGparty"..i),scale)
				self:SaveFramePos(ScaleFrame)
			end
			if MGraid1 then
				for i=1,40 do
					self:SetEffectiveScale(getglobal("MGraid"..i),raidscale)					
					self:SetEffectiveScale(getglobal("MGraidpet"..i),raidscale)					
				end
				for i=1,8 do
					self:SetEffectiveScale(getglobal("MGraidgroup"..i),raidscale)					
					self:SetEffectiveScale(getglobal("MGraid_achor"..i),raidscale)								
				end
			end
			ScaleValue = UIParent:GetScale()
		end
	end,
	
	SaveFramePos = function(self,ScaleFrame)
		if ScaleFrame then
			if ScaleFrame:GetLeft() and ScaleFrame:GetBottom() then
				local table = {}
				table.x = (ScaleFrame):GetLeft()*ScaleFrame:GetScale()
				table.y = (ScaleFrame):GetTop()*ScaleFrame:GetScale() -GetScreenHeight()
				MiniGroup2.SetOpt((ScaleFrame):GetName().."Pos",table)
				--MiniGroup2.SetOpt((ScaleFrame):GetName().."x",(ScaleFrame):GetLeft()*ScaleFrame:GetScale())
				--MiniGroup2.SetOpt((ScaleFrame):GetName().."y",(ScaleFrame):GetLeft()*ScaleFrame:GetScale() )
--				DEFAULT_CHAT_FRAME:AddMessage(table.x.." "..table.y)
--				DEFAULT_CHAT_FRAME:AddMessage(GetScreenHeight())
			end
		end
	end,
	
	UpdateScaleSettings = function(self)
	--[[	local scale
		local raidscale
		local table = self.GetOpt("Scaling")
		
		if ( table.UseMGScale == 0 ) then
			scale = tonumber(GetCVar("uiscale"))
			if ( GetCVar("useUiScale") == "1" ) then
				scale = tonumber(GetCVar("uiscale"))
			else
				scale = tonumber(UIParent:GetScale())
			end
		else
			scale = table.MGScale
		end
		
		if ( table.UseRaidScale == 0 ) then
			raidscale = scale
		else
			raidscale = table.RaidScale
		end	
		
		
	--	MGplayer:SetScale(scale)
	--	MGpet:SetScale(scale)
	--	MGtarget:SetScale(scale)
	--	MGtargettarget:SetScale(scale)
	--	MGpartygroup:SetScale(scale)
		
		self:Infield_Scale(MGplayer,scale)
		self:Infield_Scale(MGpet,scale)
		self:Infield_Scale(MGtarget,scale)
		self:Infield_Scale(MGtargettarget,scale)
		self:Infield_Scale(MGpartygroup,scale)
		
		for i=1,4 do
	--		getglobal("MGparty"..i):SetScale(scale)
	--		getglobal("MGpartypet"..i):SetScale(scale)
			self:Infield_Scale(getglobal("MGpartypet"..i),scale)		
			self:Infield_Scale(getglobal("MGparty"..i),scale)		
		end
		if MGraid1 then
			for i=1,40 do
	--			getglobal("MGraid"..i):SetScale(raidscale)
	--			getglobal("MGraidpet"..i):SetScale(raidscale)
				self:Infield_Scale(getglobal("MGraid"..i),raidscale)					
				self:Infield_Scale(getglobal("MGraidpet"..i),raidscale)					
			end
			for i=1,8 do
	--			getglobal("MGraidgroup"..i):SetScale(raidscale)
	--			getglobal("MGraid_achor"..i):SetScale(raidscale)
				self:Infield_Scale(getglobal("MGraidgroup"..i),raidscale)					
				self:Infield_Scale(getglobal("MGraid_achor"..i),raidscale)								
			end
		end	]]
	end,
	
	ShouldUnitBeVisible = function(self,unit,argument1)
		
		local style = MiniGroup2[(self:UnitCap(unit) .. "FrameStyle")]
		local owner = string.gsub(unit, "pet", "")
		local ownershown = 0
		local unitgroup = string.gsub(unit, "%d+", "")
		
		if MiniGroup2[(self:UnitCap(unit) .. "HideFrame")] == 1 then
			return 0
		end
				
		if not argument1 and not getglobal("MG"..unit) then
			return 0
		end
	
		if unitgroup == "raidpet" then
			if self:ShouldUnitBeVisible(owner) == 1 then
				ownershown = 1			
			end
		elseif unitgroup == "partypet" then
			if self:ShouldUnitBeVisible(owner) == 1 then
				ownershown = 1
			end
		elseif unit == "pet" then
			if self:ShouldUnitBeVisible("player") == 1 then
				ownershown = 1
			end
		end
		if InsideRaid == 1 then        
			if MiniGroup2.RaidHideParty == 1 then
				if unitgroup == "party" then
					return 0
				elseif unitgroup == "partypet" then
					return 0
				end
			end
			if MiniGroup2.RaidHideEverything == 1 and not (unit == "target" or unit == "targettarget") then
				return 0
			end
		end
		if not UnitExists(unit) then 
			if unitgroup == "party" and MiniGroup2.AlwaysShowParty == 1  then
				return 1
			elseif unitgroup == "partypet" and MiniGroup2.AlwaysShowPartyPets == 1  then
				return 1
			elseif unitgroup == "raidpet" and MiniGroup2.AlwaysShowRaidPets == 1  then
				return 1 			 
			elseif unit == "pet" and MiniGroup2.AlwaysShowPet == 1 then
				return 1
			end
		end	 
		if UnitExists(unit) then
			if (unit == "targettarget") then
				if (UnitName("targettarget") == UnitName("player")) and (UnitName("player") == UnitName("target")) then
					return 0
				else
					return 1
				end
			elseif (unit == "target") then
				return 1
			elseif (UnitInParty(unit) or UnitInRaid(unit)) then
				return 1
			elseif (unit == "pet") then
				return 1
			elseif ((unitgroup == "partypet" or unitgroup == "raidpet") and ownershown == 1) then
				return 1
			elseif unit == "player" then
				return 1
			else
				return 0
			end
		elseif unit == "player" then
			
			return 1
		else
			return 0
		end
		return 0		
	end,
	
	--[[---------------------------------------------------------------------------------
	  Auras
	------------------------------------------------------------------------------------]]
	
	ParseAuras = function(self,unit, filter)
		local aura, count
		local _,englishClass = UnitClass("player")
		
		if not MG_AuraTable[unit] then
			MG_AuraTable[unit] = {}
		end
		
		if not MG_AuraTable[unit]["buff"] then
			MG_AuraTable[unit]["buff"] = {}
		end

		if not MG_AuraTable[unit]["debuff"] then
			MG_AuraTable[unit]["debuff"] = {}
		end	
				
		local j = 1
		for i = 1,20 do
			aura, count = UnitBuff(unit, i, 0);
			if aura then
				if not MG_AuraTable[unit].buff[j] then
					MG_AuraTable[unit].buff[j] = {}
				end
				if _best_spell_ids[aura] == true
				or aura == "Interface\\Icons\\INV_BannerPVP_01"
				or aura == "Interface\\Icons\\INV_BannerPVP_02"
				or filter == 0 then
					MG_AuraTable[unit]["buff"][j].id = i
					MG_AuraTable[unit]["buff"][j].aura = aura
					if count == nil then
						MG_AuraTable[unit]["buff"][j].count = 0
					else
						MG_AuraTable[unit]["buff"][j].count = count
					end
					MG_AuraTable[unit]["buff"][j].buffFilter = "HELPFUL"
					MG_AuraTable[unit]["buff"][j].type = nil
					j = j + 1
				end
			else
				break
			end
		end
		for m = j,20 do
			if MG_AuraTable[unit]["buff"][m] then
				MG_AuraTable[unit]["buff"][m].aura = nil
			end
		end		
		j = 1
		for i = 1,16 do
			local type = nil
			aura, count, type = UnitDebuff(unit, i, 0);
			if aura then
				if not MG_AuraTable[unit].debuff[j] then
					MG_AuraTable[unit].debuff[j] = {}
				end
				if  (curetype1 == type or curetype2 == type or curetype3 == type)
				or   (englishClass == "PRIEST" and aura == "Interface\\Icons\\Spell_Holy_AshesToAshes") 
				or   (filter == 0) then
					MG_AuraTable[unit]["debuff"][j].id = i
					MG_AuraTable[unit]["debuff"][j].aura = aura
					if type then
						MG_AuraTable[unit]["debuff"][j].type = type
					else
						MG_AuraTable[unit]["debuff"][j].type = nil
					end
					if count == nil then
						MG_AuraTable[unit]["debuff"][j].count = 0
					else
						MG_AuraTable[unit]["debuff"][j].count = count
					end
					MG_AuraTable[unit]["debuff"][j].buffFilter = "HARMFUL"
					j = j + 1
				end
			else
				break
			end
		end
		for m = j,20 do
			if MG_AuraTable[unit]["debuff"][m] then	
				MG_AuraTable[unit]["debuff"][m].aura = nil
				MG_AuraTable[unit]["debuff"][m].type = nil
			end
		end				
	end,
	
	UnitBuff = function(self,unit, i, filter)
		if MG_AuraTable then
			local table = MG_AuraTable[unit]["buff"][i]
			if table then
				return table.aura, table.count, table.id, false, "HELPFUL"
			end
		end
	end,
	
	UnitDebuff = function(self,unit, i, filter)
		if MG_AuraTable then
			local table = MG_AuraTable[unit]["debuff"][i]
			if table then
				return table.aura, table.count, table.id, table.type, "HARMFUL"
			end	
		end
	end,
	
	LoadSpellData = function(self)	
		if ( GetLocale() == "deDE" ) then
			MG_MAGIC_TYPE = "Magie";
			MG_DISEASE_TYPE = "Krankheit";
			MG_POISON_TYPE = "Gift";
			MG_CURSE_TYPE = "Fluch";	
		elseif ( GetLocale() == "frFR" ) then
			MG_MAGIC_TYPE = "Magie";
			MG_DISEASE_TYPE = "Maladie";
			MG_POISON_TYPE = "Poison";
			MG_CURSE_TYPE = "Mal\195\169diction";	
		else
			MG_MAGIC_TYPE = "Magic";
			MG_DISEASE_TYPE = "Disease";
			MG_POISON_TYPE = "Poison";
			MG_CURSE_TYPE = "Curse";		
		end
		
		if not _best_spell_ids then
			_best_spell_ids = {}
		end
	   local i = 1
	   while true do
		  local spell_name = GetSpellTexture(i, SpellBookFrame.bookType)
		  
		  if not spell_name then
			 break
		  end
			MG_spelldataloaded = 1;
		  _best_spell_ids[spell_name] = true
		  i = i + 1
	   end
	   
		local _, englishClass = UnitClass("player")
		if englishClass == "PRIEST" then 
			curetype1 = MG_MAGIC_TYPE;
			curetype2 = MG_DISEASE_TYPE;
			curetype3 = "none";
		elseif englishClass == "SHAMAN" then
			curetype1 = MG_POISON_TYPE;
			curetype2 = MG_DISEASE_TYPE;
		elseif englishClass == "PALADIN" then
			curetype1 = MG_MAGIC_TYPE;
			curetype2 = MG_POISON_TYPE;
			curetype3 = MG_DISEASE_TYPE;
		elseif englishClass == "MAGE" then 
			curetype1 = MG_CURSE_TYPE;
			curetype2 = "none";
			curetype3 = "none";
		elseif englishClass == "DRUID" then
			curetype1 = MG_CURSE_TYPE;
			curetype2 = MG_POISON_TYPE;
			curetype3 = "none";
		end
	end,
	
	AuraUpdate = function(self,unit,hat,bleh)	
		if unit == nil then unit = arg1 end
		if unit == nil then return end	
		if MG_spelldataloaded == 0 then
			MiniGroup2:LoadSpellData()
			return
		end
		
		if not getglobal("MG"..unit.."_Aura1") then
			return
		end
		
		local style = MiniGroup2[(self:UnitCap(unit).."AuraStyle")]
		local aura_Pos = MiniGroup2[(self:UnitCap(unit).."AuraPos")]
		local filter = MiniGroup2[(self:UnitCap(unit).."AuraFilter")]
		local debuffc = MiniGroup2[(self:UnitCap(unit).."AuraDebuffC")]
		
		self:ParseAuras(unit, filter)
		
		if MG_AuraTable[unit]["buff"] == {} and MG_AuraTable[unit]["debuff"] == {} then
			return
		end
		if style == AuraStyle_OneDebuff or style == AuraStyle_TwoDebuff then
			MG_AuraTable[unit]["buff"] = {}
		end
		
		self:AuraPosUpdate(unit)
		
		--[[if hat and bleh then
			MG_AuraTable[unit]["debuff"] = {}
			for i = 1,20 do
				if i <= hat then
					MG_AuraTable[unit]["buff"][i] = {}
					MG_AuraTable[unit]["buff"][i].aura = "Interface\\Icons\\Spell_Holy_AshesToAshes"
					MG_AuraTable[unit]["buff"][i].type = nil
					MG_AuraTable[unit]["buff"][i].count = 0
					MG_AuraTable[unit]["buff"][i].buffFilter = "HELPFUL"
				else
					MG_AuraTable[unit]["buff"][i] = {}
				end
			end
			for i = 1,bleh do
				MG_AuraTable[unit]["debuff"][i] = {}
				MG_AuraTable[unit]["debuff"][i].aura = "Interface\\Icons\\Spell_Holy_AshesToAshes"
				MG_AuraTable[unit]["debuff"][i].type = "Magic"
				MG_AuraTable[unit]["debuff"][i].count = 0				
				MG_AuraTable[unit]["debuff"][i].buffFilter = "HARMFUL"
			end			
		end]]
		
		if style == AuraStyle_OneDebuff then
			style = AuraStyle_OneLine
		elseif style == AuraStyle_TwoDebuff then
			style = AuraStyle_TwoLines
		end
		
		self:UpdateDebuffColoring(unit,debuffc,filter)
		if style == AuraStyle_Hide then
			for i = 1, 20 do
				button = getglobal("MG"..unit.."_Aura"..i)
				button:Hide()
			end
		else
			self:UpdateAuraStyle(unit, style, aura_Pos)
		end
	end,
	
	UpdateDebuffColoring = function(self,unit,debuffc,filter)
		local red, green, blue
		local debuffed = 0
		local debuff_type = nil
		local aura
		if debuffc == 1 and UnitIsFriend("player",unit) then		
			for i = 1,16 do
				aura, _, debuff_type = UnitDebuff(unit, i, filter)
				if ( debuff_type ~= "none" and debuff_type ~= nil) then	
					break
				end		
			end
			if debuff_type == nil or debuff_type == "none" then
				debuffed = 0
			elseif debuff_type == MG_MAGIC_TYPE then
				red = 1
				green = 0
				blue = 0
				debuffed = 1
			elseif debuff_type == MG_POISON_TYPE then
				red = 0.25
				green = 1
				blue = 0
				debuffed = 1
			elseif debuff_type == MG_DISEASE_TYPE then
				red = 0
				green = 0.25
				blue = 1
				debuffed = 1
			elseif debuff_type == MG_CURSE_TYPE then
				red = 0.75
				green = 0
				blue = 0.75	
				debuffed = 1
			end	
		end
		if debuffed == 1 then
			getglobal("MG"..unit.."Debuff"):Show()
			getglobal("MG"..unit.."Debuff"):SetAlpha(0.7)	
			getglobal("MG"..unit.."Debuff"):SetVertexColor(red, green, blue)
		else
			getglobal("MG"..unit.."Debuff"):Hide()
		end
	end,
	
	UpdateAuraStyle = function(self,unit, style, aura_Pos, filter)
		local aura, button
		local numAuras = 0
		local numauras2 = 0
		local bufffound = 0
		for i = 1, 20 do
		   button = getglobal("MG"..unit.."_Aura"..i)
		   button.buffFilter = "empty"
		   button.aura = "empty"
		   button:Hide()
		end 
		for i = 1, 20 do
			getglobal("MG"..unit.."_Aura"..i.."Count"):SetText("")
			local aura = self:UnitBuff(unit, i, filter)
			local aura2 = self:UnitDebuff(unit, i, filter)
			if aura then
				numauras2 = numauras2 + 1
				bufffound = 1
			end
			if aura2 then
				numauras2 = numauras2 + 1
			end				
		end
		
		if ( style == AuraStyle_OneLine or numauras2 < 11) then
			if aura_Pos ~= AuraPos_Right and aura_Pos ~= AuraPos_Left and aura_Pos ~= AuraPos_Auto then
				for i = 1, 10 do
					button = getglobal("MG"..unit.."_Aura"..i)
					button.aura, button.count, button.id, _, button.buffFilter = self:UnitBuff(unit, i, filter)
					if button.aura then
						numAuras = numAuras + 1
					else
						break
					end					
				end
				if numAuras > 0 then
					for i = 10, 1, -1 do
						button = getglobal("MG"..unit.."_Aura"..i)
						local aura, count, id, _, buffFilter = self:UnitDebuff(unit, (10 - ( i - 1)), filter)
						if ( aura ) then
							button.aura = aura
							button.count = count
							button.id = id
							button.buffFilter = buffFilter
						else
							break
						end
					end
				else
					for i = 1,10 do
						button = getglobal("MG"..unit.."_Aura"..i)
						button.aura, button.count, button.id, _, button.buffFilter = self:UnitDebuff(unit, i, filter)
						if ( button.aura ) then
						else
							break
						end
					end				
				end
			else
				for i = 1, 10 do
					button = getglobal("MG"..unit.."_Aura"..i)
					button.aura, button.count, button.id, _, button.buffFilter = self:UnitBuff(unit, i, filter)
					if ( button.aura ) then
						numAuras = numAuras + 1
					else
						break
					end
				end
				for i = 1, 10 do
					k = (numAuras + i)
					if (numAuras + i) > 10 then
						k = (numAuras + 1 - i)
					end
					if k > 0 then
						button = getglobal("MG"..unit.."_Aura"..k)
						aura = self:UnitDebuff(unit, i, filter)
						if ( aura ) then
							button.aura, button.count, button.id, _, button.buffFilter = self:UnitDebuff(unit, i, filter)
						else
							break
						end
					end
				end
			end
		elseif ( style == AuraStyle_TwoLines ) then
			if not (UnitIsFriend("player", unit)) or bufffound == 0 then
				for i = 1, 16 do
					button = getglobal("MG"..unit.."_Aura"..i)
					button.aura, button.count, button.id, _, button.buffFilter = self:UnitDebuff(unit, i, filter)
					if not button.aura then
						break
					end					
				end
			else
				for i = 1, 20 do
					button = getglobal("MG"..unit.."_Aura"..i)
					local aura, count, id, _, buffFilter = self:UnitBuff(unit, i, filter)
					if ( aura ) then
						button.aura = aura
						button.count = count
						button.id = id
						button.buffFilter = buffFilter
					else
						break
					end
				end
				for i = 1, 16 do
					button = getglobal("MG"..unit.."_Aura"..(21-i))
					local aura, count, id, _, buffFilter = self:UnitDebuff(unit, i, filter)
					if ( aura ) then
						button.aura = aura
						button.count = count
						button.id = id
						button.buffFilter = buffFilter
					else
						break
					end
				end
			end
		end	
		for i = 1, 20 do
		   button = getglobal("MG"..unit.."_Aura"..i)	   
		   if button.aura ~= "empty" and button.aura ~= nil then
				button:Show()
				getglobal("MG"..unit.."_Aura"..i.."Icon"):SetTexture(button.aura)
				if button.count > 1 then
					getglobal("MG"..unit.."_Aura"..i.."Count"):SetText(button.count)
				end
				if button.buffFilter == "HARMFUL" then
					getglobal("MG"..unit.."_Aura"..i.."Overlay"):Show()
				else
					getglobal("MG"..unit.."_Aura"..i.."Overlay"):Hide()
				end			
			else
				button:Hide()
			end
		end
	end,
	
	AuraOnEnter = function(self)
		local unit = UnitFrames[this:GetParent():GetName()]
		local distance = ( UIParent:GetWidth() - this:GetParent():GetRight() )
		local anchor
		local offset
		
		if ( distance <= 100 ) then
		anchor = "ANCHOR_BOTTOMLEFT"
	
			offset = -15
		else
			anchor = "ANCHOR_BOTTOMRIGHT"
			offset = 15
		end
	
		GameTooltip:SetOwner(this, anchor, offset, 0)
		if ( this.buffFilter == "HELPFUL" or this.buffFilter == "HELPFUL_adjusted") then
			GameTooltip:SetUnitBuff(unit, this.id);
			if (CT_RA_BuffTextures ~= nil and MiniGroup2.ShowBuffTimes == 1) then
				local k,v,buffName,left;
				for k, v in CT_RA_BuffTextures do
					if ( "Interface\\Icons\\" .. v[1] == this.aura ) then
						buffName = k;
						break;
					end
				end
				if (buffName ~= nil and CT_RA_Stats[UnitName(unit)] ~= nil) then
					if (CT_RA_Stats[UnitName(unit)]["Buffs"][buffName] ~= nil) then
						left = CT_RA_Stats[UnitName(unit)]["Buffs"][buffName][2];
					end
				end
				if (left) then
					local mins, secs;
						if ( left >= 60 ) then
						secs = mod(left, 60);
						mins = (left-secs)/60;
					else
						mins = 0;
						secs = left;
					end
					if ( mins < 0 ) then mins = "00"; elseif ( mins < 10 ) then mins = "0" .. mins; end
					if ( secs < 0 ) then secs = "00"; elseif ( secs < 10 ) then secs = "0" .. secs; end
					GameTooltip:AddLine("Time left: " .. mins .. ":" .. secs .."\n",TOOLTIP_DEFAULT_COLOR.r, TOOLTIP_DEFAULT_COLOR.g, TOOLTIP_DEFAULT_COLOR.b);
					GameTooltip:SetHeight(GameTooltip:GetHeight()+10);
				end
			end
		elseif ( this.buffFilter == "HARMFUL" or this.buffFilter == "HARMFUL_adjusted") then
			GameTooltip:SetUnitDebuff(unit, this.id)		
		end
	end,
	
	--[[---------------------------------------------------------------------------------
	  Options
	------------------------------------------------------------------------------------]]
	--nissehat
	ShowOptions = function(self)
		ShowUIPanel(MGOptionsFrame)
	end,
	
	ToggleLock = function(self)
		self.TogMsg("Lock MiniGroup2 Frames", self.TogOpt("LockMGFrames"))
	end,
	
	ApplySettings = function(self)
		MGapplied = 1
		self:GetSettings()
		self:UpdateBorderStyle()
		
		if scale_loaded == 0 then
			self:UpdateScale(1)
			scale_loaded = 1
		elseif scale_loaded == 1 then
	--		self:UpdateScaleSettings()
			self:UpdateScale(1)
		end
			
		self:HideBlizzardFrames()
		self:MapButtonPosition()
		self:Layout()

		self:UpdateBarStyle()		
		self:UpdatePlayer()
		self:UpdatePlayer()
		self:UpdateParty()
		self:UpdateTarget()
		self:UpdateRaid(1)
		
		self:UnitGrouping()
		self:RaidUnitGrouping()
	end,
	
	HelpOnShow = function(self)
		MGHelpFrameText:SetText(MG_OPTIONS_HELPTEXT)
		MGHelpFrameCredits:SetText(MG_OPTIONS_HELPCREDITS)
		return
	end,
	
	--[[---------------------------------------------------------------------------------
	  Minimap
	------------------------------------------------------------------------------------]]
	
	MapButtonPosition = function(self)
		local IconPosition = 100
		if self.GetOpt("IconPosition") then
			IconPosition = self.GetOpt("IconPosition")
		end
		
		if ( self.GetOpt("ShowMapButton") == 0 ) then
			MG_MapButtonFrame:Hide()
		else
			MG_MapButtonFrame:Show()
			MG_MapButtonFrame:SetPoint("TOPLEFT", "Minimap", "TOPLEFT",52 - (80 * cos(IconPosition)),(80 * sin(IconPosition)) - 52)
		end
	end,
	
	MapButtonOnClick = function(self)
		ToggleDropDownMenu(1, nil, MiniGroup_Dropdown,this:GetName(), -125, 10)
	end,
	
	MapButtonOnEnter = function(self)
		GameTooltip:SetOwner(this, "ANCHOR_LEFT")
		GameTooltip:SetText("MiniGroup Options")
	end,
	
	MapButtonOnLeave = function(self)
		GameTooltip:Hide()
	end,
	
	--[[---------------------------------------------------------------------------------
	  Utility
	------------------------------------------------------------------------------------]]
	
	UnitCap = function(self,argument1)
		if not argument1 then return end
		argument1 = string.gsub(argument1, "pet", "Pet")
		argument1 = string.gsub(argument1, "party", "Party")
		argument1 = string.gsub(argument1, "player", "Player")
		argument1 = string.gsub(argument1, "raid", "Raid")
		argument1 = string.gsub(argument1, "target", "Target")
		argument1 = string.gsub(argument1, "TargetTarget", "Targettarget")
		argument1 = string.gsub(argument1, "%d", "")
		return argument1
	end,
	
	DecToHex = function(self,red,green,blue)
		if ( not red or not green or not blue ) then
			return "ffffff"
		end
		if red > 1 then
		red = 1
		end
		if green > 1 then
		green = 1
		end
		if blue > 1 then
		blue = 1
		end
		
		red = floor(red * 255)
		green = floor(green * 255)
		blue = floor(blue * 255)
	
		local a,b,c,d,e,f
	
		a = self:GiveHex(floor(red / 16))
		b = self:GiveHex(math.mod(red,16))
		c = self:GiveHex(floor(green / 16))
		d = self:GiveHex(math.mod(green,16))
		e = self:GiveHex(floor(blue / 16))
		f = self:GiveHex(math.mod(blue,16))
	
		return a..b..c..d..e..f
	end,
	
	GiveHex = function(self,dec)
		for key, value in MG_HexTable do
			if ( dec == value ) then
				return key
			end
		end
		return ""..dec
	end,
	
	GetRaidColors = function(self,class)
		if ( class ~= MG_MSG_UNKNOWNGENERIC ) then
			return RAID_CLASS_COLORS[class]
		else
			local colorVar = { r = 1.0, g = 1.0, b = 1.0 }
			return colorVar
		end
	end,
	
	GetTelo = function(self,unit)
		-- Ripped straight from Telo.  This is just to use Telo's info
		-- if it's available, and not meant to replicate functionality
		if ( UnitName(unit) and UnitLevel(unit) ) then
			local index = UnitName(unit)..":"..UnitLevel(unit)
			local text = ""
	
			if ( MobHealthDB and MobHealthDB[index] ) then
				local s, e
				local pts
				local pct
	
				if ( type(MobHealthDB[index]) ~= "string" ) then
					return
				end
				s, e, pts, pct = string.find(MobHealthDB[index], "^(%d+)/(%d+)$")
				if ( pts and pct ) then
					pts = pts + 0
					pct = pct + 0
					if( pct ~= 0 ) then
						pointsPerPct = pts / pct
					else
						pointsPerPct = 0
					end
				end
	
				local currentPct = UnitHealth(unit)
	
				if ( pointsPerPct > 0 ) then	
					if ( currentPct ) then
						local diff = ((100 * pointsPerPct) + 0.5) - ((currentPct * pointsPerPct) + 0.5)
						if ( self.GetOpt("ShowtargetTextDiff") == 1 and diff > 0 ) then
							text = string.format("%d|cffff7f7f-%d|r", (currentPct * pointsPerPct) + 0.5, ((100 * pointsPerPct) + 0.5) - ((currentPct * pointsPerPct) + 0.5))
						else
							text = self:FormatValue((currentPct * pointsPerPct) + 0.5).."/"..self:FormatValue((100 * pointsPerPct) + 0.5)
						end
					else
						text = string.format("???/%d", (100 * pointsPerPct) + 0.5)
					end
				end
				return text
			else
				return nil
			end
		else
			return nil
		end
	end,

	FormatValue = function(self,value)
		if value < 10000 then
			return string.format("%d", value);
		elseif value < 100000 then
			return string.format("%.1fk", value / 1000 + 0.05);
		elseif value < 1000000 then
			return string.format("%dk", value / 1000 + 0.5);
		else
			return string.format("%.2fm", value / 1000000 + 0.005);
		end
	end,
	
	--[[---------------------------------------------------------------------------------
	  color functions
	------------------------------------------------------------------------------------]]
	
	UpdateColors = function(self)
		self:FrameColor(MGtarget)
		self:FrameColor(MGtargettarget)
	
		self:FrameColor(MGplayer)
		
		self:FrameColor(MGpet)
		
		
		self:SetFrameColor(MGpartygroup)
		self:SetFrameColor(MGplayergroup)
		
		for i=1, 4 do
			self:FrameColor(getglobal("MGparty"..i))
			self:FrameColor(getglobal("MGpartypet"..i))
		end
			
		if MGraid1 then
			for i=1, 40 do
				self:FrameColor(getglobal("MGraid"..i))
				self:FrameColor(getglobal("MGraidpet"..i))
			end	
			for i=1,8 do
				self:SetFrameColor(getglobal("MGraidgroup"..i))
				if self.GetOpt("HideAnchorBackgrounds") == 1 then
					getglobal("MGraid_achor"..i):SetBackdropColor(0,0,0,0)
					getglobal("MGraid_achor"..i):SetBackdropBorderColor(0,0,0,0)
				else
					self:SetFrameColor(getglobal("MGraid_achor"..i))
				end
			end
		end
	end,
	
	FrameColor = function(self,frame)
		if not frame then return end
		framename = frame:GetName()
		if MGFrames[string.gsub(framename,"%d+","")].Background == 1 then
			self:SetFrameColor(frame)
		else
			frame:SetBackdropColor(0,0,0,0)
			frame:SetBackdropBorderColor(0,0,0,0)
		end
	end,
	
	SetFrameColor = function(self,frame, red, green, blue, alpha)
		if frame == nil then
			frame = MGplayer
		end
		if ( frame:GetName() == "MGtarget" ) then
			self.SetOpt("TargetFrameColors", defaultTColors)
	
			frame:SetBackdropColor(defaultTColors.r,defaultTColors.g,defaultTColors.b,defaultTColors.a)
			frame:SetBackdropBorderColor(
					TOOLTIP_DEFAULT_COLOR.r,
					TOOLTIP_DEFAULT_COLOR.g,
					TOOLTIP_DEFAULT_COLOR.b,
					self:BorderAlpha("MGtarget"))	
		else
		
			self.SetOpt("PartyFrameColors", defaultColors)
			frame:SetBackdropColor(defaultColors.r,defaultColors.g,defaultColors.b,defaultColors.a)		
			frame:SetBackdropBorderColor(
					TOOLTIP_DEFAULT_COLOR.r,
					TOOLTIP_DEFAULT_COLOR.g,
					TOOLTIP_DEFAULT_COLOR.b,
					self:BorderAlpha())
		end	
	end,
	
	BorderAlpha = function(self,frame)
		if frame == nil then
			frame = MGplayer
		end
		if frame == "MGtarget" then 
			if self.GetOpt("AlphaBorder") == 1 then
				return defaultTColors.a
			else
				return 1
			end	
		else
			if self.GetOpt("AlphaBorder") == 1 then
				return defaultColors.a
			else
				return 1
			end
		end
	end,
	
	LayoutColor = function(self)
		defaultColors = self.GetOpt("PartyFrameColors")
		defaultTColors = self.GetOpt("TargetFrameColors")
		self:UpdateColors()
	end,
	
	ToggleAlphaBorder = function(self)
		self.TogMsg("Transparent Borders", self.TogOpt("AlphaBorder"))		
		MiniGroup2:UpdateColors()
	end,
	
	
	--[[---------------------------------------------------------------------------------
	 Border style
	------------------------------------------------------------------------------------]]
	
	GetBorderStyle = function(self)
		if self.GetOpt("BorderStyle") == 1 then
			return "Interface\\Tooltips\\UI-Tooltip-Border",5,16
		elseif self.GetOpt("BorderStyle") == 2 then
			return "Interface\\DialogFrame\\UI-DialogBox-Border",5,16
		elseif self.GetOpt("BorderStyle") == 3 then
			return "Interface\\AddOns\\MiniGroup2\\Images\\MG_MapButton",3,0
		end
	end,
	
	UpdateUnitBorderStyle = function(self,unit)
		local texture,size,edgesize = MiniGroup2:GetBorderStyle()
		getglobal("MG"..unit):SetBackdrop({bgFile = "Interface\\AddOns\\MiniGroup2\\Images\\UI-Tooltip-Background-Solid", edgeFile = texture, tile = true, tileSize = 16, edgeSize = edgesize, insets = { left = size, right = size, top = size, bottom = size }});
	end,
	
	UpdateBorderStyle = function(self)
		local texture,size,edgesize = MiniGroup2:GetBorderStyle()
		if UIParent:IsShown() then
			MGplayer:SetBackdrop({bgFile = "Interface\\AddOns\\MiniGroup2\\Images\\UI-Tooltip-Background-Solid", edgeFile = texture, tile = true, tileSize = 16, edgeSize = edgesize, insets = { left = size, right = size, top = size, bottom = size }});
			
			MGtarget:SetBackdrop({bgFile = "Interface\\AddOns\\MiniGroup2\\Images\\UI-Tooltip-Background-Solid", edgeFile = texture, tile = true, tileSize = 16, edgeSize = edgesize, insets = { left = size, right = size, top = size, bottom = size }});
		
			
			MGtargettarget:SetBackdrop({bgFile = "Interface\\AddOns\\MiniGroup2\\Images\\UI-Tooltip-Background-Solid", edgeFile = texture, tile = true, tileSize = 16, edgeSize = edgesize, insets = { left = size, right = size, top = size, bottom = size }});
		
			
			MGpet:SetBackdrop({bgFile = "Interface\\AddOns\\MiniGroup2\\Images\\UI-Tooltip-Background-Solid", edgeFile = texture, tile = true, tileSize = 16, edgeSize = edgesize, insets = { left = size, right = size, top = size, bottom = size }});
			
			MGpartygroup:SetBackdrop({bgFile = "Interface\\AddOns\\MiniGroup2\\Images\\UI-Tooltip-Background-Solid", edgeFile = texture, tile = true, tileSize = 16, edgeSize = edgesize, insets = { left = size, right = size, top = size, bottom = size }});
		
			MGplayergroup:SetBackdrop({bgFile = "Interface\\AddOns\\MiniGroup2\\Images\\UI-Tooltip-Background-Solid", edgeFile = texture, tile = true, tileSize = 16, edgeSize = edgesize, insets = { left = size, right = size, top = size, bottom = size }});
		
			
			for i=1, 4 do
				if getglobal("MGparty"..i) then
					getglobal("MGparty"..i):SetBackdrop({bgFile = "Interface\\AddOns\\MiniGroup2\\Images\\UI-Tooltip-Background-Solid", edgeFile = texture, tile = true, tileSize = 16, edgeSize = edgesize, insets = { left = size, right = size, top = size, bottom = size }});
				end
				if getglobal("MGpartypet"..i) then
					getglobal("MGpartypet"..i):SetBackdrop({bgFile = "Interface\\AddOns\\MiniGroup2\\Images\\UI-Tooltip-Background-Solid", edgeFile = texture, tile = true, tileSize = 16, edgeSize = edgesize, insets = { left = size, right = size, top = size, bottom = size }});
				end
			end	
			
			if MGraid1 then
				for i=1, 40 do
					if getglobal("MGraid"..i) then
						getglobal("MGraid"..i):SetBackdrop({bgFile = "Interface\\AddOns\\MiniGroup2\\Images\\UI-Tooltip-Background-Solid", edgeFile = texture, tile = true, tileSize = 16, edgeSize = edgesize, insets = { left = size, right = size, top = size, bottom = size }});
					end
					if getglobal("MGraidpet"..i) then
						getglobal("MGraidpet"..i):SetBackdrop({bgFile = "Interface\\AddOns\\MiniGroup2\\Images\\UI-Tooltip-Background-Solid", edgeFile = texture, tile = true, tileSize = 16, edgeSize = edgesize, insets = { left = size, right = size, top = size, bottom = size }});
					end
				end	
				for i=1,8 do
					getglobal("MGraid_achor"..i):SetBackdrop({bgFile = "Interface\\AddOns\\MiniGroup2\\Images\\UI-Tooltip-Background-Solid", edgeFile = texture, tile = true, tileSize = 16, edgeSize = edgesize, insets = { left = size, right = size, top = size, bottom = size }});
					getglobal("MGraidgroup"..i):SetBackdrop({bgFile = "Interface\\AddOns\\MiniGroup2\\Images\\UI-Tooltip-Background-Solid", edgeFile = texture, tile = true, tileSize = 16, edgeSize = edgesize, insets = { left = size, right = size, top = size, bottom = size }});
				end
			end
			self:UpdateColors()
		end
	end,
	
	--[[---------------------------------------------------------------------------------
	 Bar style
	------------------------------------------------------------------------------------]]
	
	UpdateBarStyle = function(self)
		if self.GetOpt("BarStyle") == 1 then
			self:SetBarStyle("Interface\\TargetingFrame\\UI-StatusBar")
		elseif self.GetOpt("BarStyle") == 2 then
			self:SetBarStyle("Interface\\AddOns\\MiniGroup2\\images\\AceBarFrames.tga")
--sai new bar style
		elseif self.GetOpt("BarStyle") == 3 then
			self:SetBarStyle("Interface\\AddOns\\MiniGroup2\\images\\Smooth.tga")
		end
	end,

	SetUnitBarStyle = function(self,unit)
		local key = "MG"..unit
		if not getglobal(key) then return end
		local texture
		if self.GetOpt("BarStyle") == 1 then
			texture = "Interface\\TargetingFrame\\UI-StatusBar"
		elseif self.GetOpt("BarStyle") == 2 then
			texture = "Interface\\AddOns\\MiniGroup2\\images\\AceBarFrames.tga"
--sai new bar style
		elseif self.GetOpt("BarStyle") == 3 then
			texture = "Interface\\AddOns\\MiniGroup2\\images\\Smooth.tga"
		end		
		if getglobal(key) then
			getglobal(key.."_HealthBar"):SetStatusBarTexture(texture)
			getglobal(key.."_ManaBar"):SetStatusBarTexture(texture)
			getglobal(key.."_ManaBar_BG"):SetTexture(texture)
			getglobal(key.."_HealthBar_BG"):SetTexture(texture)
			
			local style = MiniGroup2[(unit.."FrameStyle")]
			if not MGFrames[self:FrameType(unit)] or MGFrames[self:FrameType(unit)].BackgroundBarColor == true then
				getglobal(key.."_HealthBar_BG"):SetVertexColor(MG_HealthBar.r1,MG_HealthBar.g1,MG_HealthBar.b1, 0.25)
			else
				getglobal(key.."_HealthBar_BG"):SetVertexColor(0,0,0, 0.25)
			end
			
			if getglobal(key.."_XPBar") then
				getglobal(key.."_XPBar"):SetStatusBarTexture(texture)		
				getglobal(key.."_XPBar_BG"):SetTexture(texture)
			if not MGFrames[self:FrameType(unit)] or MGFrames[self:FrameType(unit)].BackgroundBarColor == true then
					getglobal(key.."_XPBar_BG"):SetVertexColor(0.8,0,0.7, 0.25)
				else
					getglobal(key.."_XPBar_BG"):SetVertexColor(0,0,0, 0.25)
				end			
			end
			if getglobal(key.."_XPBar_Rest") then
				getglobal(key.."_XPBar_Rest"):SetStatusBarTexture(texture)		
			end
		end
	end,
	
	SetBarStyle = function(self,texture)
		for key, value in UnitFrames do
			if getglobal(key) then
				getglobal(key.."_HealthBar"):SetStatusBarTexture(texture)
				getglobal(key.."_ManaBar"):SetStatusBarTexture(texture)
				getglobal(key.."_ManaBar_BG"):SetTexture(texture)
				getglobal(key.."_HealthBar_BG"):SetTexture(texture)
				
				local style = MiniGroup2[(self:UnitCap(value).."FrameStyle")]
			if not MGFrames[self:FrameType(value)] or MGFrames[self:FrameType(value)].BackgroundBarColor == true then
					getglobal(key.."_HealthBar_BG"):SetVertexColor(MG_HealthBar.r1,MG_HealthBar.g1,MG_HealthBar.b1, 0.25)
				else
					getglobal(key.."_HealthBar_BG"):SetVertexColor(0,0,0, 0.25)
				end
				
				if getglobal(key.."_XPBar") then
					getglobal(key.."_XPBar"):SetStatusBarTexture(texture)		
					getglobal(key.."_XPBar_BG"):SetTexture(texture)
			if not MGFrames[self:FrameType(value)] or MGFrames[self:FrameType(value)].BackgroundBarColor == true then
						getglobal(key.."_XPBar_BG"):SetVertexColor(0.8,0,0.7, 0.25)
					else
						getglobal(key.."_XPBar_BG"):SetVertexColor(0,0,0, 0.25)
					end			
				end
				if getglobal(key.."_XPBar_Rest") then
					getglobal(key.."_XPBar_Rest"):SetStatusBarTexture(texture)		
				end
			end
		end
	end,
	
	SetEffectiveScale = function(self,frame, scale)
		if not frame then return end
	
	   frame.scale = scale;
	   local parent = frame:GetParent();
	
	   if ( parent ) then
		  scale = scale / parent:GetEffectiveScale();
	   end
	
	   frame:SetScale(scale);
	end,
	
	CreateUnitFrame = function(self, unit)
--		DEFAULT_CHAT_FRAME:AddMessage("CREATEFRAME: "..unit)
		
		-- frame creation
		local frameName = "MG"..unit
		local Frame = CreateFrame("Button",frameName)
		
		-- bar background creation
		Frame:CreateTexture(frameName.."_HealthBar_BG","BACKGROUND")
		Frame:CreateTexture(frameName.."_ManaBar_BG","BACKGROUND")
		Frame:CreateTexture(frameName.."_XPBar_BG","BACKGROUND")
	
		-- artwork layer fonts
		local text = Frame:CreateFontString(frameName.."_HealthText","ARTWORK")
		text:SetFont("Fonts\\FRIZQT__.TTF",8)
		text:SetShadowColor(0,0,0,1)
		text:SetShadowOffset(1, -1)
		text:SetJustifyH("RIGHT")
		text = Frame:CreateFontString(frameName.."_ManaText","ARTWORK")
		text:SetFont("Fonts\\FRIZQT__.TTF",8)
		text:SetShadowColor(0,0,0,1)
		text:SetShadowOffset(1, -1)
		text:SetJustifyH("RIGHT")
		text = Frame:CreateFontString(frameName.."_BarHealthText","ARTWORK")
		text:SetFont("Fonts\\FRIZQT__.TTF",8)
		text:SetShadowColor(0,0,0,1)
		text:SetShadowOffset(1, -1)
		text:SetJustifyH("RIGHT")
		text:SetPoint("CENTER",frameName.."_HealthBar_BG","CENTER")
		text = Frame:CreateFontString(frameName.."_BarManaText","ARTWORK")
		text:SetFont("Fonts\\FRIZQT__.TTF",8)
		text:SetShadowColor(0,0,0,1)
		text:SetShadowOffset(1, -1)
		text:SetJustifyH("RIGHT")
		text:SetPoint("CENTER",frameName.."_ManaBar_BG","CENTER")
		text = Frame:CreateFontString(frameName.."_StatusText","ARTWORK")		
		text:SetFont("Fonts\\FRIZQT__.TTF",8)
		text:SetJustifyH("CENTER")
		
		-- highlight
		Frame:CreateTexture(frameName.."Highlight","OVERLAY")
		getglobal(frameName.."Highlight"):SetTexture("Interface\\AddOns\\MiniGroup2\\Images\\highlight.tga")
		getglobal(frameName.."Highlight"):SetBlendMode("ADD")
		getglobal(frameName.."Highlight"):Hide()		
	
		-- debuff
		Frame:CreateTexture(frameName.."Debuff","OVERLAY")
		getglobal(frameName.."Debuff"):SetTexture("Interface\\AddOns\\MiniGroup2\\Images\\debuff2.tga")
		getglobal(frameName.."Debuff"):SetBlendMode("ADD")
		getglobal(frameName.."Debuff"):Hide()
		getglobal(frameName.."Debuff"):SetPoint("CENTER",Frame,"CENTER")
		getglobal(frameName.."Debuff"):SetWidth(Frame:GetWidth())
		getglobal(frameName.."Debuff"):SetHeight(Frame:GetHeight())

		-- oor
		Frame:CreateTexture(frameName.."OOR","OVERLAY")
		getglobal(frameName.."OOR"):SetTexture("Interface\\AddOns\\MiniGroup2\\Images\\oor.tga");
		getglobal(frameName.."OOR"):SetBlendMode("ADD");
		getglobal(frameName.."OOR"):Hide();
		
		-- classtext, name, hitindicator
		Frame:CreateFontString(frameName.."_ClassText","ARTWORK")		
		text = Frame:CreateFontString(frameName.."_NameLabel","ARTWORK")
		text:SetJustifyH("LEFT")
		text:SetFont("Fonts\\FRIZQT__.TTF",8)
		text:SetShadowColor(0,0,0,1)
		text:SetShadowOffset(1, -1)		
		text = Frame:CreateFontString(frameName.."_HitIndicator","OVERLAY")
		text:SetJustifyH("CENTER")
		text:SetFont("Fonts\\FRIZQT__.TTF",12,"OUTLINE")
		
		local logo = Frame:CreateTexture(frameName.."_PVPIcon","OVERLAY")
		logo:SetWidth(27)
		logo:SetHeight(27)
		
		logo = Frame:CreateTexture(frameName.."_LeaderIcon","OVERLAY")
		logo:SetWidth(12)
		logo:SetHeight(12)
		logo:SetTexture("Interface\\GroupFrame\\UI-Group-LeaderIcon")	
		logo:Hide()
		
		logo = Frame:CreateTexture(frameName.."_MasterIcon","OVERLAY")
		logo:SetWidth(10)
		logo:SetHeight(10)
		logo:SetTexture("Interface\\GroupFrame\\UI-Group-MasterLooter")
		logo:Hide()
		
		-- endcaps
		local endcap = Frame:CreateTexture(frameName.."_HealthEndcapRight","OVERLAY")
		endcap:SetTexture("Interface\\AddOns\\MiniGroup2\\Images\\Endcap")
		endcap:SetWidth(1)
		endcap:SetTexCoord(0,0.0625,0,0.875)
		endcap:SetPoint("TOPLEFT",frameName.."_HealthBar_BG","TOPRIGHT")
		endcap = Frame:CreateTexture(frameName.."_HealthEndcapLeft","OVERLAY")
		endcap:SetTexture("Interface\\AddOns\\MiniGroup2\\Images\\Endcap")
		endcap:SetWidth(1)
		endcap:SetTexCoord(0,0.0625,0,0.875)
		endcap:SetPoint("TOPRIGHT",frameName.."_HealthBar_BG","TOPLEFT")
		endcap = Frame:CreateTexture(frameName.."_ManaEndcapLeft","OVERLAY")
		endcap:SetTexture("Interface\\AddOns\\MiniGroup2\\Images\\Endcap")
		endcap:SetWidth(1)
		endcap:SetTexCoord(0,0.0625,0,0.875)
		endcap:SetPoint("TOPRIGHT",frameName.."_ManaBar_BG","TOPLEFT")
		endcap = Frame:CreateTexture(frameName.."_ManaEndcapRight","OVERLAY")
		endcap:SetTexture("Interface\\AddOns\\MiniGroup2\\Images\\Endcap")
		endcap:SetWidth(1)
		endcap:SetTexCoord(0,0.0625,0,0.875)
		endcap:SetPoint("TOPLEFT",frameName.."_ManaBar_BG","TOPRIGHT")
--		endcap = Frame:CreateTexture(frameName.."_XPEndcapLeft","OVERLAY")
--		endcap:SetTexture("Interface\\AddOns\\MiniGroup2\\Images\\Endcap")
--		endcap:SetWidth(1)
--		endcap:SetTexCoord(0,0.0625,0,0.875)
--		endcap:SetPoint("TOPRIGHT",,"TOPLEFT")
--		endcap = Frame:CreateTexture(frameName.."_XPEndcapRight","OVERLAY")
--		endcap:SetTexture("Interface\\AddOns\\MiniGroup2\\Images\\Endcap")
--		endcap:SetWidth(1)
--		endcap:SetTexCoord(0,0.0625,0,0.875)
--		endcap:SetPoint("TOPLEFT",,"TOPRIGHT")
		
		-- add to index
		UnitFrames[frameName] = unit
		
		-- create statusbars
		bar = CreateFrame("StatusBar",frameName.."_HealthBar")
		bar:SetParent(Frame)
		bar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
		bar:SetPoint("TOPLEFT",frameName.."_HealthBar_BG","TOPLEFT")
		bar:SetScript("OnValueChanged",function() MiniGroup2:StatusBarsOnValueChanged(arg1) end)
		bar:SetMinMaxValues(0,2)
		bar:SetValue(0)
		
		bar = CreateFrame("StatusBar",frameName.."_ManaBar")
		bar:SetParent(Frame)
		bar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
		bar:SetPoint("TOPLEFT",frameName.."_ManaBar_BG","TOPLEFT")
		bar:SetMinMaxValues(0,10)
		bar:SetValue(0)

		local bar = CreateFrame("StatusBar",frameName.."_CastBar")
		bar:SetParent(Frame)
		bar:SetStatusBarTexture("Interface\\AddOns\\MiniGroup2\\Images\\Smooth.tga")
		bar:SetPoint("LEFT",frameName,"LEFT",2.5,0.5)
		bar:SetScript("OnUpdate",function() MiniGroup2:UpdateCastingBars() end)
		bar:SetMinMaxValues(0,1)
		bar:SetValue(1)
		bar:SetStatusBarColor(0.8,0,0.5)
		bar:SetFrameLevel(0)
		bar:Hide()
		
		Frame:SetFrameStrata("LOW") 
		--CreateFrame("StatusBar",frameName.."_XPBar")
		
		-- create aura icons
		for i =1,20 do
			local icon = CreateFrame("Button",frameName.."_Aura"..i)
			local art = icon:CreateTexture(frameName.."_Aura"..i.."Icon","ARTWORK")
			local overlay = icon:CreateTexture(frameName.."_Aura"..i.."Overlay","OVERLAY")
			icon:SetParent(Frame)
			
			icon:SetWidth(15)
			art:SetWidth(15)
			overlay:SetWidth(15)
			art:SetHeight(15)
			icon:SetHeight(15)
			overlay:SetHeight(15)
			art:SetPoint("TOPLEFT", icon, "TOPLEFT")
			overlay:SetPoint("TOPLEFT", icon, "TOPLEFT")
			overlay:SetTexture("Interface\\AddOns\\MiniGroup2\\Images\\UI-Debuff-Border-Small")
			overlay:SetTexCoord(0,0.9375,0,0.9375)			
			icon:Hide()
			art:Show()
			overlay:Show()

			getglobal(frameName.."_Aura"..i.."Icon"):Show()
			
			text = icon:CreateFontString(frameName.."_Aura"..i.."Count","OVERLAY")
			text:SetFontObject(MGAuraFont)	
			text:SetFont("Fonts\\FRIZQT__.TTF",8)
			text:SetPoint("CENTER",icon,"CENTER")
			
			icon:RegisterForClicks('LeftButtonUp', 'RightButtonUp', 'MiddleButtonUp', 'Button4Up', 'Button5Up');
			icon:SetScript("OnEnter",function() MiniGroup2:AuraOnEnter() end)
			icon:SetScript("OnLeave",function() GameTooltip:Hide() end)
			
			if i == 1 then
				icon:SetPoint("TOPRIGHT",Frame,"TOPLEFT")
			else
				icon:SetPoint("TOPRIGHT",getglobal(frameName.."_Aura"..(i-1).."Icon","ARTWORK"),"TOPLEFT")
			end			
		end
		Frame:SetMovable(1)
		Frame:RegisterForDrag("LeftButton")
		Frame:SetParent(UIParent)

		Frame:RegisterForClicks('LeftButtonUp', 'RightButtonUp', 'MiddleButtonUp', 'Button4Up', 'Button5Up');
		
		Frame:SetScript("OnEnter",function() MiniGroup2:MemberOnEnter() end)
		Frame:SetScript("OnLeave",function() MiniGroup2:MemberOnLeave() end)
		Frame:SetScript("OnDragStart",function() MiniGroup2:MemberOnMouseDown(arg1) end)
		Frame:SetScript("OnDragStop",function() MiniGroup2:MemberOnMouseUp(arg1) end)
		Frame:SetScript("OnClick",function() MiniGroup2:MemberOnClick(arg1) end)
		Frame:SetScript("OnHide",function() this:StopMovingOrSizing() end)
		Frame:SetScript("OnEvent",function() MiniGroup2:MemberOnEvent(event) end)
			
		self:ApplyStyle(Frame)
		
		self:SetEffectiveScale(Frame,1.0)
		
		local postable = MiniGroup2.GetOpt(frameName.."Pos")
		if type(postable) == "table" then
			Frame:SetPoint("TOPLEFT",UIParent,"TOPLEFT",postable.x,postable.y)
		end
--		DEFAULT_CHAT_FRAME:AddMessage(postable.x.." "..postable.y)
--		DEFAULT_CHAT_FRAME:AddMessage(frameName.." "..Frame:GetLeft().." "..Frame:GetTop())
		
		local x1
		local y1
		if Frame:GetLeft() and Frame:GetTop() and WorldFrame:GetTop() and WorldFrame:GetEffectiveScale() then
			x1 = Frame:GetLeft()
			y1 = Frame:GetTop() - WorldFrame:GetTop()*WorldFrame:GetEffectiveScale()
		end
		self:UnitFrameResize(unit)
		self:SetUnitBarStyle(unit)
		self:LayoutUnitBars(unit)
		self:UpdateUnitScale(unit)
		self:UpdateUnitBorderStyle(unit)
		self:FrameColor(Frame)
		self:StatusBarsUpdateHealth(unit)
		self:StatusBarsUpdateMana(unit)
		self:AuraPosUpdate(unit)
--		self:CreateDropDownFrame(unit)
		if x1 and y1 then
			Frame:SetPoint("TOPLEFT",UIParent,"TOPLEFT",x1/Frame:GetScale(),y1/Frame:GetScale())
--			DEFAULT_CHAT_FRAME:AddMessage("CREATE"..Frame:GetName().." "..x.." "..y)
--			DEFAULT_CHAT_FRAME:AddMessage("CREATE"..Frame:GetName().." "..x*Frame:GetScale().." "..y*Frame:GetScale())
		end
		Frame:Hide()
		if Frame then
			return 1
		else
			return 0
		end
	end,

	DropDownUnit = function(self, unit)
		local type,x = nil,nil
	
		if unit == "player" then
			type = PlayerFrameDropDown
		elseif unit == "target" then     
			type = TargetFrameDropDown
		elseif unit == "pet" then
			type = PetFrameDropDown   
		end
		
		if not type and string.find(unit,"pet") then
			return
		end
		
		_,_,x = string.find(unit,"(%d+)")
		
		if x then this:SetID(x) end
		
		if type then
			HideDropDownMenu(1);
			type.unit = unit
			type.name = UnitName(unit)			
			ToggleDropDownMenu(1, nil, type, "cursor")
		elseif string.find(unit,"party") then
			HideDropDownMenu(1);
			this.unit = unit
			this.name = UnitName(unit)			
			FriendsDropDown.initialize = function() MiniGroup2:PartyFrameDropDown_Initialize() end
			FriendsDropDown.displayMode = "MENU";
			ToggleDropDownMenu(1, nil, FriendsDropDown, "cursor");
		elseif string.find(unit,"raid") then
			HideDropDownMenu(1);
			this.unit = unit
			this.name = UnitName(unit)
			this.userData = x;
			FriendsDropDown.initialize = function() MiniGroup2:RaidFrameDropDown_Initialize() end
			FriendsDropDown.displayMode = "MENU";
			ToggleDropDownMenu(1, nil, FriendsDropDown, "cursor");
		end
	end,

	PartyFrameDropDown_Initialize = function()
		UnitPopup_ShowMenu(getglobal(UIDROPDOWNMENU_OPEN_MENU), "MGPARTY", this.unit, this.name);
	end,
	
	RaidFrameDropDown_Initialize = function()
		UnitPopup_ShowMenu(getglobal(UIDROPDOWNMENU_OPEN_MENU), "MGRAID", this.unit, this.name, this.userData);
	end,
	
	OptionsDropdownInit = function()
		-- Show Config Window
		info = {}
		info.text = MG_OPTIONS_OPENCONFIGWINDOW
		info.notCheckable = 1
		info.func = function(x) ShowUIPanel(MGOptionsFrame) end
		UIDropDownMenu_AddButton(info)
	
		-- Spacer
		info = {}
		info.disabled = 1
		UIDropDownMenu_AddButton(info)
	
		-- Header
		info = {}
		info.text = MG_OPTIONS_WINDOWCOLORS
		info.notClickable = 1
		info.isTitle = 1
		info.notCheckable = 1
		UIDropDownMenu_AddButton(info)
	
		-- Set Party Background color
		info = {}
		info.text = MG_OPTIONS_PARTYWINDOW
		info.hasColorSwatch = 1
		info.r = defaultColors.r
		info.g = defaultColors.g
		info.b = defaultColors.b
		info.notCheckable = 1
		info.opacity = 1.0 - defaultColors.a
		info.swatchFunc = function() MiniGroup2:ColorPicker() end
		info.func = UIDropDownMenuButton_OpenColorPicker
		info.hasOpacity = 1
		info.opacityFunc = function() MiniGroup2:OpacityOption() end
		info.cancelFunc = function() MiniGroup2:ColorPickerCancel() end
		UIDropDownMenu_AddButton(info)
	
		-- Set Target Background color
		info = {}
		info.text = MG_OPTIONS_TARGETWINDOW
		info.hasColorSwatch = 1
		info.r = defaultTColors.r
		info.g = defaultTColors.g
		info.b = defaultTColors.b
		info.notCheckable = 1
		info.opacity = 1.0 - defaultTColors.a
		info.swatchFunc = function() MiniGroup2:TargetColorPicker() end
		info.func = UIDropDownMenuButton_OpenColorPicker
		info.hasOpacity = 1
		info.opacityFunc = function() MiniGroup2:TargetOpacityOption() end
		info.cancelFunc = function() MiniGroup2:TargetColorPickerCancel() end
		UIDropDownMenu_AddButton(info)
	
		-- Set Border color
	
		info = {}
		info.text = "Toggle Borders"
		--	info.notCheckable = 0
		info.func = function(x) MiniGroup2:ToggleAlphaBorder() end
	--	info.checked = self.GetOptAlphaSetting()
		info.notCheckable = 1
		UIDropDownMenu_AddButton(info)
	
			
		-- Spacer
		info = {}
		info.disabled = 1
		UIDropDownMenu_AddButton(info)
		
		-- All Lock
		info = {}
		info.func = function() MiniGroup2:ToggleLock() end
		info.notCheckable = 1
		info.text = "Toggle Lock"
		UIDropDownMenu_AddButton(info)
	
--sai no need for a help button ^^
--[[	
		-- Help
		-- Show Config Window
		info = {}
		info.text = MG_OPTIONS_HELP
		info.notCheckable = 1
		info.func = function(x) MGHelpFrame:Show() end
		UIDropDownMenu_AddButton(info)
]]
		
--sai adding shortcut for raidframe sorting (group/class)
		info = {}
		info.text = "Toggle sorting"
		info.notCheckable = 1
		info.func = function(x) MiniGroup2:ToggleRaidGroupSorting() end
		UIDropDownMenu_AddButton(info)

--uni adding shortcut for not here alerts
		info = {}
		info.text = "Toggle NH Alerts"
		info.notCheckable = 1
		info.func = function(x) MiniGroup2:ToggleNHAlerts() end
		UIDropDownMenu_AddButton(info)
	end,

--sai toggle raidframe sorting (group/class)
	ToggleRaidGroupSorting = function(self)
		if self.GetOpt("RaidByClass") == 1 then
			self.SetOpt("RaidByClass", 0)
		else
			self.SetOpt("RaidByClass", 1)
		end
		self:UpdateRaid()
	end,

--uni toggle not here alerts
	ToggleNHAlerts = function(self)
		if self.GetOpt("HideNotHereAlerts") == 1 then
			self.SetOpt("HideNotHereAlerts", 0)
		else
			self.SetOpt("HideNotHereAlerts", 1)
		end
		self:ApplySettings()
	end,
	
		--[[---------------------------------------------------------------------------------
	  Color menu functions
	------------------------------------------------------------------------------------]]
	
	 ColorPicker = function(self)
		defaultColors.r,defaultColors.g,defaultColors.b = ColorPickerFrame:GetColorRGB()
		MiniGroup2:UpdateColors()
	end,
	
	 OpacityOption = function(self)
		defaultColors.a = 1.0 - OpacitySliderFrame:GetValue()
		MiniGroup2:UpdateColors()
	end,
	
	 ColorPickerCancel = function(self)
		defaultColors.r = ColorPickerFrame.previousValues.r
		defaultColors.g = ColorPickerFrame.previousValues.g
		defaultColors.b = ColorPickerFrame.previousValues.b
		defaultColors.a = 1.0 - ColorPickerFrame.previousValues.opacity
		MiniGroup2:UpdateColors()
	end,
	
	 TargetColorPicker = function(self)
		defaultTColors.r,defaultTColors.g,defaultTColors.b = ColorPickerFrame:GetColorRGB()
		MiniGroup2:UpdateColors()
	end,
	
	 TargetOpacityOption = function(self)
		defaultTColors.a = 1.0 - OpacitySliderFrame:GetValue()
		MiniGroup2:UpdateColors()
	end,
	
	 TargetColorPickerCancel = function(self)
		defaultTColors.r = ColorPickerFrame.previousValues.r
		defaultTColors.g = ColorPickerFrame.previousValues.g
		defaultTColors.b = ColorPickerFrame.previousValues.b
		defaultTColors.a = 1.0 - ColorPickerFrame.previousValues.opacity
		MiniGroup2:UpdateColors()
	end,

	ApplyStyle = function(self,frame)
		if not frame then return end
		local framename = frame:GetName()
		local style = MiniGroup2[self:UnitCap(string.gsub(framename,"MG","")).."FrameStyle"]
		if MG_OPTIONS_DD9[style] == nil then
			style = 1
		end
		if MiniGroup2[self:UnitCap(string.gsub(framename,"MG","")).."HideFrame"] == 1 then
		
		else
			self:TestLayout(frame,MG_OPTIONS_DD9[style])	
		end
	end,
	
	UpdateDynamicThemes = function(self)
		MG_OPTIONS_DD9 = {}
		MG_OPTIONS_DD9.TEXT = "MiniGroup frame style"
		local i = 1
		for key, value in MiniGroup2themes do
			MG_OPTIONS_DD9["OPTION"..i.."_TEXT"] = value.Name
			MG_OPTIONS_DD9["OPTION"..i.."_TIP"] = value.Tip
			MG_OPTIONS_DD9[i] = value
			i = i + 1
		end
		MG_OPTIONS_DD9.OPTIONS = i-1		
	end,
	
	TestLayout = function(self,frame,themetable)
		local name = frame:GetName()
		local unit = string.gsub(name,"MG","")
		local unitcap = self:UnitCap(unit)
		local switchnameandclass = false
		local hiddens = {}
		local frametype = string.gsub(name, "%d", "")
		local manabarhide = false
		local xpbarhide = false

		if MiniGroup2[unitcap.."HideMana"] == 1 then
			manabarhide = true
		end

		if (unit ~= "player" and unit ~= "pet") or ((unit == "pet" or unit == "player") and MiniGroup2["Show"..unitcap.."XP"] == 0) then
			xpbarhide = true
		end
		
		if not MGFrames[frametype] then
			MGFrames[frametype] = {}
		end
		MGFrames[frametype].FrameHeight = 0
		MGFrames[frametype].ResizeBars = themetable.ResizeBars
		MGFrames[frametype].BackgroundBarColor = themetable.BackgroundBarColor
		MGFrames[frametype].AlphaBar = themetable.AlphaBar
		MGFrames[frametype].RaidColorName = themetable.RaidColorName
		MGFrames[frametype].Name = themetable.Name
		MGFrames[frametype].PetClassName = themetable.PetClassName
		MGFrames[frametype].HappinessBar = themetable.HappinessBar
		MGFrames[frametype].Background = 1
		if unit == "target" then
			if themetable.ComboGFX == true then
				comboGFX = 1
			else
				comboGFX = 0
			end
		end
		MGFrames[frametype].FrameHeight = themetable.ThemeData.all.FrameHeight
		MGFrames[frametype].FrameWidth = themetable.ThemeData.all.FrameWidth
		
		if themetable.ThemeData[string.lower(unitcap)] then
			if themetable.ThemeData[string.lower(unitcap)].FrameHeight then
				MGFrames[frametype].FrameHeight = themetable.ThemeData[string.lower(unitcap)].FrameHeight
			end
			if themetable.ThemeData[string.lower(unitcap)].FrameWidth then
				MGFrames[frametype].FrameWidth = themetable.ThemeData[string.lower(unitcap)].FrameWidth	
			end
		end
		
		if manabarhide == true then
			if string.find(unit,"pet") then
				switchnameandclass = true
			end
			MGFrames[frametype].RaidColorName = true
		else
			MGFrames[frametype].RaidColorName = false
		end
		
		local index = "all"
		for j = 1,2 do
			if j == 2 then
				index = string.lower(unitcap)
			end
			if themetable.ThemeData[index] then
				for key, value in themetable.ThemeData[index] do
					if getglobal(name.."_"..key) and value.Hidden ~= true and not (key == "ManaBar_BG" and manabarhide == true) and not (key == "XPBar_BG" and xpbarhide == true) and not hiddens[key] then
						if value.Hide then
							hiddens[value.Hide] = true
						end
						if value.HeightAdd then
							MGFrames[frametype].FrameHeight = MGFrames[frametype].FrameHeight + value.HeightAdd
						end						
						if value.Width then
							getglobal(name.."_"..key):SetWidth(value.Width)
						end
						if value.Height then
							if value.PetAdjust and string.find(unit,"pet") and manabarhide == true then
								getglobal(name.."_"..key):SetHeight(value.Height + value.PetAdjust)
								if value.HeightAdd then
									MGFrames[frametype].FrameHeight = MGFrames[frametype].FrameHeight + value.PetAdjust
								end
							else
								getglobal(name.."_"..key):SetHeight(value.Height)
							end
						end
						if value.Font then
							if (MiniGroup2.UseBigHealthFonts == 1 and key == "HealthText") then
								getglobal(name.."_"..key):SetFont(value.Font,value.FontSize+2)
							else
								getglobal(name.."_"..key):SetFont(value.Font,value.FontSize)
							end
						end
						local RelativeTo
						if value.RelativeTo then
							if themetable.ThemeData[index][value.RelativeTo] and themetable.ThemeData[index][value.RelativeTo].Hidden == true and value.RelativeToSecondary then
								RelativeTo = name.."_"..value.RelativeToSecondary
							else
								RelativeTo = name.."_"..value.RelativeTo
							end
						else
							RelativeTo = name
						end
						if value.x and value.y and value.Point and value.RelativePoint then
							getglobal(name.."_"..key):ClearAllPoints()
							getglobal(name.."_"..key):SetPoint(value.Point, RelativeTo, value.RelativePoint, value.x, value.y)
						end
						if value.Visibility then
							for k, v in value.Visibility do
								if getglobal(name.."_"..v) then
									getglobal(name.."_"..v):Show()
								end
							end
						end
						if value.Justify then
							getglobal(name.."_"..key):SetJustifyH(value.Justify)
						end
					elseif getglobal(name.."_"..key) and (value.Hidden or (key == "ManaBar_BG" and manabarhide == true) or (key == "XPBar_BG" and xpbarhide == true) ) then
--sai						Added set font function to hidden elements (could be avoided through changing the other functions to check if an element is hidden)				
						if value.Font then
							getglobal(name.."_"..key):SetFont(value.Font,value.FontSize)
						end
						getglobal(name.."_"..key):Hide()
						if value.Visibility then
							for k, v in value.Visibility do
								if getglobal(name.."_"..v) then
									getglobal(name.."_"..v):Hide()
								end
							end
						end
					end
				end	
			end
		end
		
		for key,value in hiddens do
			getglobal(name.."_"..key):Hide()
		end
		
		if getglobal(name.."_XPBar_Rest") then
			getglobal(name.."_XPBar_Rest"):ClearAllPoints()
			getglobal(name.."_XPBar_Rest"):SetPoint("LEFT",name.."_XPBar_BG","LEFT")
			getglobal(name.."_XPBar_Rest"):SetHeight(getglobal(name.."_XPBar_BG"):GetHeight())
			getglobal(name.."_XPBar_Rest"):SetWidth(getglobal(name.."_XPBar_BG"):GetWidth())
		end
		if getglobal(name.."_XPBar") then
			getglobal(name.."_XPBar"):ClearAllPoints()
			getglobal(name.."_XPBar"):SetPoint("LEFT",name.."_XPBar_BG","LEFT")	
			getglobal(name.."_XPBar"):SetHeight(getglobal(name.."_XPBar_BG"):GetHeight())
			getglobal(name.."_XPBar"):SetWidth(getglobal(name.."_XPBar_BG"):GetWidth())
		end
		if getglobal(name.."_HealthBar") then
			getglobal(name.."_HealthBar"):ClearAllPoints()
			getglobal(name.."_HealthBar"):SetPoint("LEFT",name.."_HealthBar_BG","LEFT")	
			getglobal(name.."_HealthBar"):SetHeight(getglobal(name.."_HealthBar_BG"):GetHeight())
			getglobal(name.."_HealthBar"):SetWidth(getglobal(name.."_HealthBar_BG"):GetWidth())
				
		end
		if getglobal(name.."_ManaBar") then
			getglobal(name.."_ManaBar"):ClearAllPoints()
			getglobal(name.."_ManaBar"):SetPoint("LEFT",name.."_ManaBar_BG","LEFT")		
			getglobal(name.."_ManaBar"):SetHeight(getglobal(name.."_ManaBar_BG"):GetHeight())
			getglobal(name.."_ManaBar"):SetWidth(getglobal(name.."_ManaBar_BG"):GetWidth())
		end		
		if getglobal(name.."_CastBar") then
			getglobal(name.."_CastBar"):ClearAllPoints()
			getglobal(name.."_CastBar"):SetPoint("LEFT",name,"LEFT",2.5,0.5)	
			getglobal(name.."_CastBar"):SetHeight(MGFrames[frametype].FrameHeight-7)
			getglobal(name.."_CastBar"):SetWidth(MGFrames[frametype].FrameWidth-6)
				
		end
		self:SetEndCaps(name)
	end,	
})

MiniGroup2:RegisterForLoad()
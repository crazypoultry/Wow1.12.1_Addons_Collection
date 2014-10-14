
--- Init Vars --
METAHUD_NAME = "MetaHud"
METAHUD_TOC = 11200;
METAHUD_VERSION = "v"..METAHUD_TOC.."-"..16;
METAHUD_ICON = "Interface\\AddOns\\MetaHud\\Layout\\Icon";
METAHUD_LAYOUTPATH = "Interface\\AddOns\\MetaHud\\Layout\\";

METAHUD_TEXT_EMPTY = "";
METAHUD_TEXT_HP2   = "<color_hp><hp_value></color>";
METAHUD_TEXT_HP3   = "<color_hp><hp_value></color>/<hp_max>";
METAHUD_TEXT_HP4   = "<color_hp><hp_percent></color>";
METAHUD_TEXT_HP5   = "<color_hp><hp_value></color> <color>999999(</color><hp_percent><color>999999)</color>";
METAHUD_TEXT_HP6   = "<color_hp><hp_value>/<hp_max></color> <color>999999(</color><hp_percent><color>999999)</color>";
METAHUD_TEXT_MP2   = "<color_mp><mp_value></color>";
METAHUD_TEXT_MP3   = "<color_mp><mp_value></color>/<mp_max>";
METAHUD_TEXT_MP4   = "<color_mp><mp_percent></color>";
METAHUD_TEXT_MP5   = "<color_mp><mp_value></color> <color>999999(</color><mp_percent><color>999999)</color>";
METAHUD_TEXT_MP6   = "<color_mp><mp_value>/<mp_max></color> <color>999999(</color><mp_percent><color>999999)</color>";
METAHUD_TEXT_MP7   = "<color_mp><mp_value_druid></color>";
METAHUD_TEXT_TA1   = "[<color_level><level><elite></color>] <color_reaction><pvp_rank> <name></color> [<color_class><class><type><pet><npc></color>] <raidgroup>";
METAHUD_TEXT_TA2   = "[<color_level><level><elite></color>] <color_reaction><name></color> [<color_class><class><type><pet><npc></color>]";
METAHUD_TEXT_TA3   = "[<color_level><level><elite></color>] <color_reaction><name></color>";
METAHUD_TEXT_CT1   = "<color>ffff00<casttime_remain></color>"; 
METAHUD_TEXT_CT2   = "<color>00ffff<spellname></color> <color>ffff00<casttime_remain></color>"; 
METAHUD_TEXT_CD1   = "<color>ff0000<casttime_delay></color>";

MetaHud = {
	debug             = nil,
	vars_loaded       = nil,
	enter             = nil,
	issetup           = nil,
	isinit            = nil,
	userID            = nil,
	Casting           = nil,
	inCombat          = nil,
	Attacking         = nil,
	onTaxi            = nil,
	TimerSet          = nil,
	inParty           = nil,
	Regen             = nil,
	Target            = nil,
	needMana          = nil,
	needHealth        = nil,
	playerDead        = nil,
	PetneedHealth     = nil,
	PetneedMana       = nil,
	has_target_health = nil,
	has_target_mana   = nil,
	has_pet_health    = nil, 
	has_pet_mana      = nil, 
	player_class      = nil,
	CastingAlpha      = 1,
	update_elapsed    = 0,
	step              = 0.005,
	stepfast          = 0.02,
	defaultfont       = "Fonts/FRIZQT__.TTF",  
	defaultfont_num   = METAHUD_LAYOUTPATH.."Number.TTF",  
    
	C_textures    = nil,
	C_frames      = nil,
	C_curLayout   = nil,
	C_tClips      = nil,
	C_names       = nil,

	timer         = 0,
	frame_level   = nil,
            
	---  current mana / health values
	bar_values    = {
		MetaHud_PlayerHealth_Bar  = 1,
		MetaHud_PlayerMana_Bar    = 1,
		MetaHud_TargetHealth_Bar  = 0,
		MetaHud_TargetMana_Bar    = 0,
		MetaHud_PetHealth_Bar     = 0,
		MetaHud_PetMana_Bar       = 0,    
	},

	---  animated mana / health values
	bar_anim      = {
		MetaHud_PlayerHealth_Bar  = 1,
		MetaHud_PlayerMana_Bar    = 1,
		MetaHud_TargetHealth_Bar  = 1,
		MetaHud_TargetMana_Bar    = 1,
		MetaHud_PetHealth_Bar     = 1,
		MetaHud_PetMana_Bar       = 1,       
	},
     
	---  flag for animation             
	bar_change    = {
		MetaHud_PlayerHealth_Bar  = 0,
		MetaHud_PlayerMana_Bar    = 0,
		MetaHud_TargetHealth_Bar  = 0,
		MetaHud_TargetMana_Bar    = 0,
		MetaHud_PetHealth_Bar     = 0,
		MetaHud_PetMana_Bar       = 0,        
	},
    
	---  powertypes
	powertypes    = { "mana", "rage", "focus", "energy", "happiness" },
                  
	---  font outlines
	Outline       = { "", "OUTLINE", "THICKOUTLINE" },
    
	name2unit     = {
		MetaHud_PlayerHealth_Bar  = "player",
		MetaHud_PlayerMana_Bar    = "player",
		MetaHud_TargetHealth_Bar  = "target",
		MetaHud_TargetMana_Bar    = "target",
		MetaHud_PetHealth_Bar     = "pet",
		MetaHud_PetMana_Bar       = "pet",
		MetaHud_Target_Text       = "target",
		MetaHud_ToTarget_Text     = "targettarget",
		MetaHud_Range_Text        = "target",
		MetaHud_Guild_Text        = "target",
		MetaHud_Casttime_Text     = "player",
		MetaHud_Castdelay_Text    = "player",
	},

	name2typ      = {
		MetaHud_PlayerHealth_Bar  = "health",
		MetaHud_PlayerMana_Bar    = "mana",
		MetaHud_TargetHealth_Bar  = "health",
		MetaHud_TargetMana_Bar    = "mana",
		MetaHud_PetHealth_Bar     = "health",
		MetaHud_PetMana_Bar       = "mana",
	},
    
	text2bar    = {
		MetaHud_PlayerHealth_Text = "MetaHud_PlayerHealth_Bar",
		MetaHud_PlayerMana_Text   = "MetaHud_PlayerMana_Bar",
		MetaHud_TargetHealth_Text = "MetaHud_TargetHealth_Bar",
		MetaHud_TargetMana_Text   = "MetaHud_TargetMana_Bar",
		MetaHud_PetHealth_Text    = "MetaHud_PetHealth_Bar",
		MetaHud_PetMana_Text      = "MetaHud_PetMana_Bar",
		MetaHud_Target_Text       = "MetaHud_Target_Text",
		MetaHud_ToTarget_Text     = "MetaHud_ToTarget_Text",
		MetaHud_Range_Text        = "MetaHud_Range_Text",
		MetaHud_Guild_Text        = "MetaHud_Guild_Text",
	},
    
	---  alphamode textures
	alpha_textures = {
		"MetaHud_LeftFrame_Texture",
		"MetaHud_RightFrame_Texture",
		"MetaHud_PlayerHealth_Bar_Texture",
		"MetaHud_PlayerMana_Bar_Texture",
		"MetaHud_TargetHealth_Bar_Texture",
		"MetaHud_TargetMana_Bar_Texture",
		"MetaHud_PetHealth_Bar_Texture",
		"MetaHud_PetMana_Bar_Texture",
		"MetaHud_PlayerResting",
		"MetaHud_TargetIcon",
		"MetaHud_PlayerAttacking",
		"MetaHud_PlayerLeader",
		"MetaHud_PlayerLooter",
		"MetaHud_PlayerPvP",
		"MetaHud_Casting_Bar",
		"MetaHud_Flash_Bar",
		"MetaHud_TargetElite",
		"MetaHud_PetHappy",
		"MetaHud_ToT_Frame",
	},

	---  alphamode text
	alpha2_textures = {
		"MetaHud_PlayerHealth_Text",
		"MetaHud_PlayerMana_Text",
		"MetaHud_TargetHealth_Text",
		"MetaHud_TargetMana_Text",
		"MetaHud_PetHealth_Text",
		"MetaHud_PetMana_Text",
		"MetaHud_Target_Text",
		"MetaHud_ToTarget_Text",
		"MetaHud_Range_Text",
		"MetaHud_Guild_Text",
	},

	---  reaction Colors
	ReacColors    = { "ff0000","ffff00","55ff55","8888ff","008800","cccccc" }, 
    
	---  prepared Colors
	BarColorTab   = {},
                 
	---  Main Events
	mainEvents    = { "UNIT_AURA","UNIT_PET","UNIT_HEALTH","UNIT_HEALTHMAX",
		"UNIT_MANA","UNIT_MANAMAX","UNIT_FOCUS","UNIT_FOCUSMAX","UNIT_RAGE","UNIT_RAGEMAX",
		"UNIT_ENERGY","UNIT_ENERGYMAX","UNIT_DISPLAYPOWER","PLAYER_AURAS_CHANGED",
		"PLAYER_ENTER_COMBAT","PLAYER_LEAVE_COMBAT","PLAYER_REGEN_ENABLED","PLAYER_REGEN_DISABLED",
		"PLAYER_TARGET_CHANGED","PLAYER_COMBO_POINTS","PLAYER_ALIVE","PLAYER_DEAD",
		"SPELLCAST_CHANNEL_START","SPELLCAST_CHANNEL_UPDATE","SPELLCAST_DELAYED","SPELLCAST_FAILED",
		"SPELLCAST_INTERRUPTED","SPELLCAST_START","SPELLCAST_STOP","SPELLCAST_CHANNEL_STOP",
		"UNIT_SPELLCAST_START","UNIT_SPELLCAST_STOP","UNIT_SPELLCAST_FAILED","UNIT_SPELLCAST_INTERRUPTED",
		"UNIT_SPELLCAST_DELAYED","UNIT_SPELLCAST_CHANNEL_START","UNIT_SPELLCAST_CHANNEL_UPDATE","UNIT_SPELLCAST_CHANNEL_STOP",
		"PLAYER_UPDATE_RESTING","UNIT_PVP_UPDATE","PLAYER_PET_CHANGED","UNIT_PVP_STATUS","PLAYER_UNGHOST",
		"UNIT_HAPPINESS","RAID_ROSTER_UPDATE","PARTY_LEADER_CHANGED","PARTY_LOOT_METHOD_CHANGED",
		"MIRROR_TIMER_START","MIRROR_TIMER_STOP","MIRROR_TIMER_PAUSE",
	},

	---  movable frame
	moveFrame     = {
		MetaHud_Main              = { "xoffset"         , "yoffset"               },
		MetaHud_LeftFrame         = { "hudspacing"      , ""               , "-"  },
		MetaHud_RightFrame        = { "hudspacing"      , ""                      },
		MetaHud_Target_Text       = { ""                , "targettexty"           },
		MetaHud_ToTarget_Text     = { ""                , "totargettexty"         },
		MetaHud_Range_Text        = { ""                , "rangetexty"            },
		MetaHud_Guild_Text        = { ""                , "guildtexty"            },
		MetaHud_PlayerHealth_Text = { "playerhptextx"   , "playerhptexty"         },
		MetaHud_PlayerMana_Text   = { "playermanatextx" , "playermanatexty"       },
		MetaHud_TargetHealth_Text = { "targethptextx"   , "targethptexty"         },
		MetaHud_TargetMana_Text   = { "targetmanatextx" , "targetmanatexty"       },
		MetaHud_PetHealth_Text    = { "pethptextx"      , "pethptexty"            },
		MetaHud_PetMana_Text      = { "petmanatextx"    , "petmanatexty"          }, 
		MetaHud_Casttime_Text     = { "casttextx"       , "casttexty"             },
		MetaHud_Castdelay_Text    = { "delaytextx"      , "delaytexty"            },
	},
                   
	---  default settings                
	Config_default = {
		["version"]            = METAHUD_VERSION,
		["layouttyp"]          = 1,
		["profile"]            = "Default",
		["combatalpha"]        = 0.8,
		["oocalpha"]           = 0,
		["selectalpha"]        = 0.5,
		["regenalpha"]         = 0.3,
		["textalpha"]          = 0,
		["scale"]              = 0.8,              
		["ttscale"]            = 1.0,
		["mmb"]                = {},
		["showmmb"]            = 1,
		["showresticon"]       = 1, 
		["showplayerleadericon"]  = 1,   
		["showplayerlootericon"]  = 1,   
		["showplayerpvpicon"]  = 1,   
		["showtargetpvpicon"]  = 1,  
		["showtargeticon"]     = 1,  
		["showpeticon"]        = 1, 
		["showeliteicon"]      = 1, 
		["showcombopoints"]    = 1, 
		["animatebars"]        = 1,
		["barborders"]         = 1,
		["showauras"]          = 1,
		["showauratips"]       = 1,
		["castingbar"]         = 1,
		["reversecasting"]     = 0,
		["shownpc"]            = 1,
		["showtarget"]         = 1,
		["showtotarget"]       = 1,
		["playsound"]          = 1,
		["texturefile"]        = 1,
		["soundfile"]          = 1,
		["fontfile"]           = 1,
		["showrange"]          = 1,
		["showguild"]          = 1,
		["activename"]         = 0,
		["showflash"]          = 1,
		["showflighttimer"]    = 1,
		["showelitetext"]      = 0,
		["showpet"]            = 1,
		["btarget"]            = 0,
		["bplayer"]            = 0,                
		["bcastingbar"]        = 0,
		["swaptargetauras"]    = 0,
		["ewcontrol"]    = 0,
		["flightmapx"]         = UIParent:GetWidth()/2,
		["flightmapy"]         = UIParent:GetHeight()/2,

		["MetaHud_Castdelay_Text"]    = "<color>ff0000<casttime_delay></color>",    
		["MetaHud_Casttime_Text"]     = "<color>00ffff<spellname></color> <color>ffff00<casttime_remain></color>",                                     
		["MetaHud_PlayerHealth_Text"] = "<color_hp><hp_value></color> <color>999999(</color><hp_percent><color>999999)</color>",
		["MetaHud_PlayerMana_Text"]   = "<color_mp><mp_value></color> <color>999999(</color><mp_percent><color>999999)</color>",
		["MetaHud_TargetHealth_Text"] = "<color_hp><hp_value></color> <color>999999(</color><hp_percent><color>999999)</color>",
		["MetaHud_TargetMana_Text"]   = "<color_mp><mp_value></color> <color>999999(</color><mp_percent><color>999999)</color>",
		["MetaHud_PetHealth_Text"]    = "<color_hp><hp_value></color>",
		["MetaHud_PetMana_Text"]      = "<color_mp><mp_value></color>",
		["MetaHud_Target_Text"]       = "[<color_level><level><elite></color>] <color_reaction><name></color> [<color_class><class><type><pet><npc></color>] <raidgroup>",
		["MetaHud_ToTarget_Text"]     = "<color_reaction><totarget></color>",
		["MetaHud_Range_Text"]        = "<range>",
		["MetaHud_Guild_Text"]        = "<guild>",

		["playerhpoutline"]     = 1,
		["playermanaoutline"]   = 1,
		["targethpoutline"]     = 1,
		["targetmanaoutline"]   = 1,
		["pethpoutline"]        = 1,
		["petmanaoutline"]      = 1,
		["casttimeoutline"]     = 1,
		["castdelayoutline"]    = 1,
		["targetoutline"]       = 1,
		["totargetoutline"]       = 1,
		["rangeoutline"]       = 1,
		["guildoutline"]       = 1,

		["fontsizepet"]        = 9,
		["fontsizeplayer"]     = 10,
		["fontsizetarget"]     = 10,	
		["fontsizetotarget"]   = 12,	
		["fontsizerange"]      = 12,	
		["fontsizeguild"]      = 12,	
		["fontsizetargetname"] = 12,	
		["fontsizecasttime"]   = 10,
		["fontsizecastdelay"]  = 10,

		["xoffset"]            = 0,
		["yoffset"]            = 0,
		["hudspacing"]         = 0,
		["targettexty"]        = 0,
		["totargettexty"]      = 0,
		["rangetexty"]         = 0,
		["guildtexty"]         = 0,
		["playerhptextx"]      = 0,
		["playerhptexty"]      = 0,
		["playermanatextx"]    = 0,
		["playermanatexty"]    = 0,
		["targethptextx"]      = 0,
		["targethptexty"]      = 0,
		["targetmanatextx"]    = 0,
		["targetmanatexty"]    = 0,
		["pethptextx"]         = 0,
		["pethptexty"]         = 0,
		["petmanatextx"]       = 0,
		["petmanatexty"]       = 0,

		["colors"] = {
			health_player = { "00FF00", "FFFF00", "FF0000" }, --
			health_target = { "00aa00", "aaaa00", "aa0000" }, --
			health_pet    = { "00FF00", "FFFF00", "FF0000" }, --
			mana_player   = { "00FFFF", "0000FF", "FF00FF" }, --
			mana_target   = { "00aaaa", "0000aa", "aa00aa" }, --
			mana_pet      = { "00FFFF", "0000FF", "FF00FF" }, --
			rage_player   = { "FF0000", "FF0000", "FF0000" }, --
			rage_target   = { "aa0000", "aa0000", "aa0000" }, --
			energy_player = { "FFFF00", "FFFF00", "FFFF00" }, --
			energy_target = { "aaaa00", "aaaa00", "aaaa00" }, --
			focus_target  = { "aa4400", "aa4400", "aa4400" }, --
			focus_pet     = { "aa4400", "aa4400", "aa4400" }, --
			castbar       = { "00FF00", "88FF00", "FFFF00" }, --
			channelbar    = { "E0E0FF", "C0C0FF", "A0A0FF" }, --
			tapped        = { "cccccc", "bbbbbb", "aaaaaa" }, --
		},
	},

	SoundFile = {
		"Sound\\Spells\\ColdBlood.wav",
		"Sound\\Spells\\Renew.wav",
		"Sound\\Spells\\Strike.wav",
		"Sound\\Spells\\ShaysBell.wav",
		METAHUD_LAYOUTPATH.."aggro.wav",
	},

	FontFile = {
		"default",
		"Fonts\\MORPHEUS.TTF",
		"Fonts\\SKURRI.TTF",
		"Fonts\\ARIALN.TTF",
		METAHUD_LAYOUTPATH.."font.ttf",
	},

	QuickMenu = {
		[1] = {"Main Options", "options"},
		[2] = {"Show ToT", "showtotarget"},
		[3] = {"Show Range", "showrange"},
		[4] = {"Show Auras", "showauras"},
		[5] = {"Show Aura Tips", "showauratips"},
		[6] = {"Text Full Alpha", "textalpha"},
		[7] = {"Active Target Name", "activename"},
		[8] = {"Audible Alert", "playsound"},
		[9] = {"Visual Alert", "showflash"},
	},

}

--- OnLoad --
function MetaHud:OnLoad()
	--- Event
	MetaHud_EventFrame:RegisterEvent("VARIABLES_LOADED");
	MetaHud_EventFrame:RegisterEvent("PLAYER_ENTERING_WORLD");
	MetaHud_EventFrame:RegisterEvent("PLAYER_LEAVING_WORLD");
	--- slash handler
	SLASH_MetaHud1 = "/MetaHud";
	SlashCmdList["MetaHud"] = function(msg)
		self:SCommandHandler(msg);
	end
	--- Init FuBar
	if(IsAddOnLoaded("FuBar")) then
		self:FuBar();
	end
	--- addon loaded 
	self:print("Loaded "..METAHUD_VERSION);
end

--- firstload
function MetaHud:firstload()
	self:printd("self.vars_loaded: "..(self.vars_loaded or "0") );
	self:printd("self.enter: "..(self.enter or "0") );
	if self.vars_loaded == 1 and self.enter == 1 and self.isinit == nil and self.issetup == nil then
		self:setup();
		self:init();
		UIDropDownMenu_Initialize(MetaHud_QuickMenu_DropDown, MetaHud_QuickMenu_DropDown_Initialize, "MENU");
	if(MetaHudOptions.layouttyp == "MetaHud_Standard_Layout") then
		MetaHud:SetConfig("layouttyp", 1);
	elseif(MetaHudOptions.layouttyp == "MetaHud_PlayerLeft_Layout") then
		MetaHud:SetConfig("layouttyp", 2);
	end
		return true;
	end
	return false;
end

--- OnEvent --
function MetaHud:OnEvent()
	---  debug
	self:printd("MainEvent: "..event);

	--- init HUD
	if event == "VARIABLES_LOADED" then    
		self.vars_loaded = 1;
		self:firstload();
	--- zoning    
	elseif event == "PLAYER_ENTERING_WORLD" then
		self.enter = 1;
		if self:firstload() then return; end       
		if self.issetup ~= 2 then return; end
		if self.isinit  ~= 2 then return; end
		self:init();
	--- update HEALTH Bars    
	elseif(event == "UNIT_HEALTH" or event == "UNIT_HEALTHMAX") then
		if arg1 == "player" then
			self:UpdateValues("MetaHud_PlayerHealth_Text");
		elseif arg1 == "target" then
			self:UpdateValues("MetaHud_TargetHealth_Text");
		elseif arg1 == "pet" then
			self:UpdateValues("MetaHud_PetHealth_Text");
		end
		self:updateAlpha();
	--- update MANA Bars    
	elseif(event == "UNIT_MANA" or event == "UNIT_MANAMAX" or event == "UNIT_FOCUS" or event == "UNIT_FOCUSMAX"
					or event == "UNIT_RAGE" or event == "UNIT_RAGEMAX" or event == "UNIT_ENERGY" or event == "UNIT_ENERGYMAX"
					or event == "UNIT_DISPLAYPOWER") then
		if arg1 == "player" then
			self:UpdateValues("MetaHud_PlayerMana_Text");
		elseif arg1 == "target" then
			self:UpdateValues("MetaHud_TargetMana_Text");
		elseif arg1 == "pet" then
			self:UpdateValues("MetaHud_PetMana_Text");
		end
		--- Druidbar support
		if DruidBarKey and self.player_class == "DRUID" then
			self:UpdateValues("MetaHud_PetMana_Text");
			self:triggerTextEvent("MetaHud_PlayerMana_Text");
			self:triggerTextEvent("MetaHud_PetMana_Text");
		end
		self:updateAlpha();
	elseif event == "PLAYER_AURAS_CHANGED" then
		self:triggerTextEvent("MetaHud_PlayerMana_Text");
		self:triggerTextEvent("MetaHud_PetMana_Text");
		self:UpdateValues("MetaHud_PlayerMana_Text");
		self:UpdateValues("MetaHud_PlayerHealth_Text");
		self:UpdateValues("MetaHud_PetMana_Text");
		self:ChangeBackgroundTexture();
		self:updateAlpha();
	--- target changed
	elseif event == "PLAYER_TARGET_CHANGED" then  
		self:TargetChanged();
		self:triggerTextEvent("MetaHud_Guild_Text");
		self:triggerTextEvent("MetaHud_ToTarget_Text");
	--- update target Auras
	elseif (event == "UNIT_AURA" and arg1 == "target") then
		self:Auras();
	--- update Combopoints
	elseif event == "PLAYER_COMBO_POINTS" then
		self:UpdateCombos();
	---  Combat / Regen / Attack check
	elseif event == "PLAYER_ENTER_COMBAT" then
		self.Attacking = true;
		self.inCombat  = true;
		self:updateStatus();
		self:updateAlpha();
	elseif event == "PLAYER_LEAVE_COMBAT" then
		self.Attacking = nil;
		if (self.Regen) then self.inCombat = nil; end
		self:updateStatus();
		self:updateAlpha();
	elseif event == "PLAYER_REGEN_ENABLED" then
		self.Regen = true;
		if (not self.Attacking) then self.inCombat = nil; end
		self:updateStatus();
		self:updateAlpha();
	elseif event == "PLAYER_REGEN_DISABLED" then
		self.Regen    = nil;
		self.inCombat = true;
		self:updateStatus();
		self:updateAlpha();
	elseif (event == "PLAYER_ALIVE" or event =="PLAYER_DEAD" or event =="PLAYER_UNGHOST") then
		self:UpdateValues("MetaHud_PlayerHealth_Text" , 1 );
		self:UpdateValues("MetaHud_PlayerMana_Text", 1 );
		self:ChangeBackgroundTexture();
		self:updateAlpha();
	elseif event == "PLAYER_UPDATE_RESTING" then
		self:updateStatus();
	elseif(event == "RAID_ROSTER_UPDATE" or event == "PARTY_LEADER_CHANGED" or event == "PARTY_LOOT_METHOD_CHANGED") then
		self:updateParty();
	elseif event == "UNIT_PVP_STATUS" or event == "UNIT_PVP_UPDATE" then
		self:updatePlayerPvP();
		self:updateTargetPvP();
	elseif event == "UNIT_PET" or event == "PLAYER_PET_CHANGED"then
		self:UpdateValues("MetaHud_PetHealth_Text", 1 );
		self:UpdateValues("MetaHud_PetMana_Text", 1 );
		self:ChangeBackgroundTexture();
		self:updatePetIcon();
		self:updateAlpha();
	elseif event == "UNIT_HAPPINESS" and arg1 == "pet" then
		self:updatePetIcon();
	end

	if self.issetup ~= 2 then return; end
	if self.isinit  ~= 2 then return; end
        
	---  castbar events
	if(MetaHudOptions["castingbar"] == 1) then
		if(event == "SPELLCAST_START") then
			self:SpellCast_Start(arg1, arg2);
		elseif(event == "UNIT_SPELLCAST_START") then
			if(arg1 ~= "player") then return; end
			local _, _, text, _, startTime, endTime = UnitCastingInfo(arg1);
			self:SpellCast_Start(text, endTime - startTime);
		elseif(event == "SPELLCAST_CHANNEL_START") then
			self:SpellChannel_Start(arg1, arg2);
		elseif(event == "UNIT_SPELLCAST_START") then
			if(arg1 ~= "player") then return; end
			local _, _, text, _, startTime, endTime = UnitChannelInfo(arg1);
			self:SpellChannel_Start(endTime - startTime, text);
		elseif((event == "SPELLCAST_STOP" or event == "MIRROR_TIMER_STOP" or event == "UNIT_SPELLCAST_STOP") and this.casting) then
			if(MetaHud_Casting_Bar:IsShown()) then
				if (not MetaHud_Casting_Bar:IsVisible()) then
					MetaHud_Casting_Bar:Hide();
				end
				this.casting    = nil;
				this.channeling = nil;
				this.flash      = 1;
				this.fadeOut    = 1;
				MetaHud_Casting_Bar_Texture:SetVertexColor(0, 1, 0);
				self:SetBarHeight("MetaHud_Casting_Bar",1);
				MetaHud_Flash_Bar:SetAlpha(0);
				MetaHud_Flash_Bar:Show();
			end
		elseif((event == "SPELLCAST_CHANNEL_STOP" or event == "MIRROR_TIMER_STOP" or event == "UNIT_SPELLCAST_CHANNEL_STOP") and this.channeling) then
			if(event == "UNIT_SPELLCAST_CHANNEL_STOP")then
				if(arg1 ~= "player") then return; end
				local _, _, text, _, _, _ = UnitChannelInfo(arg1);
				if(text == "BREATH" or text == "FATIGUE") then return; end
			else
				if(arg1 == "BREATH" or arg1 == "FATIGUE") then return; end
			end
			if(MetaHud_Casting_Bar:IsShown()) then
				this.casting    = nil;
				this.channeling = nil;
				this.flash      = nil;
				this.fadeOut    = 1;
				self.Casting    = nil;
				self:updateAlpha();
				self:SetBarHeight("MetaHud_Casting_Bar",0);
			end
		elseif(event == "SPELLCAST_FAILED" or event == "SPELLCAST_INTERRUPTED" or event == "UNIT_SPELLCAST_FAILED" or event == "UNIT_SPELLCAST_INTERRUPTED") then
			if(MetaHud_Casting_Bar:IsShown() and not this.fadeOut) then
				MetaHud_Casting_Bar_Texture:SetVertexColor(1, 0, 0);
				this.casting    = nil;
				this.channeling = nil;
				this.flash      = nil;
				this.fadeOut    = 1;
				this.holdTime = GetTime() + CASTING_BAR_HOLD_TIME;
				MetaHud_Flash_Bar:Hide();
				MetaHud_Flash_Bar:SetAlpha(0);
				self:updateAlpha();
				self:SetBarHeight("MetaHud_Casting_Bar",1);
			end
		elseif(event == "SPELLCAST_DELAYED") then
			if(MetaHud_Casting_Bar:IsShown()) then
				this.startTime = this.startTime + (arg1 / 1000);
				this.maxValue  = this.maxValue + (arg1 / 1000);
				this.delay     = this.delay + (arg1 / 1000);
				local time = GetTime();
				if (time > this.endTime) then
					time = this.endTime
				end
			end		
		elseif(event == "UNIT_SPELLCAST_DELAYED") then
			if(arg1 ~= "player") then return; end
			if(MetaHud_Casting_Bar:IsShown()) then
				local _, _, _, _, startTime, endTime = UnitCastingInfo(arg1);
				local delay = (startTime / 1000) - this.startTime;
				this.startTime = this.startTime + delay;
				this.maxValue = this.maxValue + delay;
				this.delay = this.delay + delay;
				local time = GetTime();
				if (time > this.endTime) then
					time = this.endTime
				end
			end		
		elseif(event == "SPELLCAST_CHANNEL_UPDATE") then
			if(arg1 == 0) then
				this.channeling = nil;
			elseif(MetaHud_Casting_Bar:IsShown()) then
				local origDuration = this.endTime - this.startTime;
				local elapsedTime = GetTime() - this.startTime;
				this.delay = (origDuration - elapsedTime) - (arg1/1000);
				this.endTime = GetTime() + (arg1 / 1000);
			end
		elseif(event == "UNIT_SPELLCAST_CHANNEL_UPDATE") then
			if(arg1 ~= "player") then return; end
			local _, _, _, _, startTime, endTime = UnitChannelInfo(arg1);
			if(startTime == 0) then
				this.channeling = nil;
			elseif(MetaHud_Casting_Bar:IsShown()) then
				local origDuration = this.endTime - this.startTime;
				local elapsedTime = GetTime() - this.startTime;
				this.delay = (startTime / 1000) - this.startTime;
				this.endTime = endTime / 1000;
			end
		elseif(event == "MIRROR_TIMER_START") then
			if(arg1 == "BREATH" or arg1 == "FATIGUE") then return; end
			if(this.channeling) then
				this.channeling = nil;
				local time = this.endTime - GetTime();
				self:SpellCast_Start(arg6, arg3/time);
			else
				self:SpellChannel_Start(arg3, arg6);
				MetaHud_Castdelay_Text:SetAlpha(0);
			end
			if(MetaHudOptions["bcastingbar"] == 0) then
				for index = 1, MIRRORTIMER_NUMTIMERS, 1 do
					getglobal("MirrorTimer"..index):Hide();
				end
			end
			self:updateAlpha();
		end
	end
end

--- init textfield
function MetaHud:initTextfield(ref,name)
	if MetaHudOptions[name] ~= nil then
		local bar = self.text2bar[name];
		ref.vars = {};
		ref:UnregisterAllEvents();
		ref.text = MetaHudOptions[name] or "";
		ref.unit = self.name2unit[bar];
		if ref.unit == nil then
			ref.unit = "player";
		end
		for var, value in pairs(MetaHud_variables) do
			if (string.find(ref.text, var)) then
				ref.vars[var] = true;
				for _,event in pairs(value.events) do
					ref:RegisterEvent(event);		
				end			
			end
		end
		ref:RegisterEvent("PLAYER_ENTERING_WORLD");
		if ref.unit == "target" then
			ref:RegisterEvent("PLAYER_TARGET_CHANGED");
		elseif ref.unit == "pet" then
			ref:RegisterEvent("UNIT_PET");
			ref:RegisterEvent("PLAYER_PET_CHANGED");
		end
		ref:SetScript("OnEvent", function() MetaHud:TextOnEvent(); end );
	end
end

--- events for vars
function MetaHud:TextOnEvent()
	if this.unit == arg1 or 
		event == "PLAYER_ENTERING_WORLD" or  
			( event == "PLAYER_TARGET_CHANGED" and this.unit == "target" ) or 
			( (event == "UNIT_PET" or event == "PLAYER_PET_CHANGED") and this.unit == "pet" ) then 
		self:doText( this:GetName() );    
	end
end

--- set Textbox
function MetaHud:doText(name)
    local font = getglobal(name.."_Text");

    ---  hide npc / target / pet ?
    if this.unit == "target" and MetaHudOptions["shownpc"] == 0 and self:TargetIsNPC() then 
        font:SetText(" ");
        return; 
    end
    if this.unit == "target" and MetaHudOptions["showtarget"] == 0 then 
        font:SetText(" ");
        return; 
    end
    if this.unit == "targettarget" and MetaHudOptions["showtotarget"] == 0 then 
        font:SetText(" ");
				MetaHud_ToT_Frame:Hide();
        return; 
    end
    if this.unit == "pet" and MetaHudOptions["showpet"] == 0 then 
        font:SetText(" ");
        return; 
    end
    
    local text  = this.text;
    local htext = this.text;
    for var, bol in pairs(this.vars) do
        text  = MetaHud_variables[var].func(text,this.unit);
        htext = self:gsub(htext, var, MetaHud_variables[var].hideval);
    end
    if text == htext then
        font:SetText(" ");
    else
        text = string.gsub(text, "  "," ");
        text = string.gsub(text,"(^%s+)","");
        text = string.gsub(text,"(%s+$)","");
        font:SetText(text);
    end

    font:SetWidth(1000);
    local frame = getglobal(name);
    local w = font:GetStringWidth() + 10;
    font:SetWidth(w);
    frame:SetWidth(w);
end
                    
--- trigger all textevents
function MetaHud:triggerAllTextEvents()
	self:triggerTextEvent("MetaHud_Target_Text");
	self:triggerTextEvent("MetaHud_ToTarget_Text");
	self:triggerTextEvent("MetaHud_Range_Text");
	self:triggerTextEvent("MetaHud_Guild_Text");
	self:triggerTextEvent("MetaHud_PlayerHealth_Text");
	self:triggerTextEvent("MetaHud_PlayerMana_Text");
	self:triggerTextEvent("MetaHud_TargetHealth_Text");
	self:triggerTextEvent("MetaHud_TargetMana_Text");
	self:triggerTextEvent("MetaHud_PetHealth_Text");
	self:triggerTextEvent("MetaHud_PetMana_Text");
	self:triggerTextEvent("MetaHud_Castdelay_Text");
	self:triggerTextEvent("MetaHud_Casttime_Text");
end

--- fake text event
function MetaHud:triggerTextEvent(p)
	this.unit = getglobal(p).unit;
	this.vars = getglobal(p).vars;
	this.text = getglobal(p).text;
	self:doText(p);
end

function MetaHud:FlightTimer()
	if(FlightMapTimesRecorderFrame) then
		return FlightMapTimesRecorderFrame.destName, FlightMapTimesRecorderFrame.started, FlightMapTimesRecorderFrame.endTime;
	else
		return FlightMapTimesFrame.endPoint, FlightMapTimesFrame.started, FlightMapTimesFrame.endTime;
	end
end

--- OnUpdate --
function MetaHud:OnUpdate()    
	---  update speed
	self.update_elapsed = self.update_elapsed + arg1;
	if self.update_elapsed < 0.3 then
		self.update_elapsed = 0;
		return;
	end

	if self.issetup ~= 2 then return; end
	if self.isinit  ~= 2 then return; end
                
	if(UnitOnTaxi("player") and IsAddOnLoaded("FlightMap") and MetaHudOptions["showflighttimer"] == 1) then
		local destination, started, ended = self:FlightTimer();
		if(this.onTaxi == nil and started and this.channeling ~= 1) then
			local duration = (ended - GetTime()) * 1000;
			if(duration == nil or duration < 1) then
				duration = 1000000;
			else
				duration = (ended - GetTime()) * 1000;
			end
			this.onTaxi = 1;
			self:SpellChannel_Start(duration, "Taxi");
			MetaHud_Casttime_Text:SetAlpha(0);
			MetaHud_Castdelay_Text:SetAlpha(0);
			MetaHud_Range_Text:EnableMouse(true);
		end
	else
		if(this.onTaxi == 1 and this.channeling == 1) then
			this.endTime = GetTime();
		end
		this.onTaxi = nil;
		MetaHud_Range_Text:EnableMouse(false);
	end

	self:triggerTextEvent("MetaHud_ToTarget_Text");
	self:triggerTextEvent("MetaHud_Range_Text");
	---  animate bars
	if MetaHudOptions["animatebars"] == 1 then
		self:Animate("MetaHud_PlayerHealth_Bar");
		self:Animate("MetaHud_PlayerMana_Bar");
	end
	if MetaHudOptions["showtarget"] == 1 then
		self:Animate("MetaHud_TargetHealth_Bar");
		self:Animate("MetaHud_TargetMana_Bar");
	end
	if MetaHudOptions["showpet"] == 1 then
		self:Animate("MetaHud_PetHealth_Bar");
		self:Animate("MetaHud_PetMana_Bar");
	end
	if DruidBarKey and self.player_class == "DRUID" and UnitPowerType("player") ~= 0 then
		self:Animate("MetaHud_PetMana_Bar");
	end

	---  castingbar
	if MetaHudOptions["castingbar"] == 1 then
		---  casting
		if this.casting then
			local time = GetTime();
			if (time > this.maxValue) then
				time = this.maxValue
			end
			MetaHud_Flash_Bar:Hide();
			local v = (time - this.startTime) / (this.maxValue - this.startTime);
			if MetaHudOptions["reversecasting"] == 1 then
				self:SetBarHeight("MetaHud_Casting_Bar", 1-v );
				MetaHud_Casting_Bar_Texture:SetVertexColor(self:Colorize("castbar",v));    
			else
				self:SetBarHeight("MetaHud_Casting_Bar", v );
				MetaHud_Casting_Bar_Texture:SetVertexColor(self:Colorize("castbar",v));       
			end
            
			self.casting_time_del = self:FormatTime(-this.delay);
			self.casting_time_rev = self:FormatTime(this.maxValue - time);
			self.casting_time     = self:FormatTime((time + this.delay) - this.startTime);
			self:triggerTextEvent("MetaHud_Casttime_Text");
			self:triggerTextEvent("MetaHud_Castdelay_Text");
                        
			---  channeling
		elseif this.channeling then
			local time = GetTime();
			if (time > this.endTime) then
				time = this.endTime
			end
			local barValue = this.startTime + (this.endTime - time);
			local sparkPosition = (barValue - this.startTime) / (this.endTime - this.startTime);
			MetaHud_Flash_Bar:Hide();
			self:SetBarHeight("MetaHud_Casting_Bar", sparkPosition );
			MetaHud_Casting_Bar_Texture:SetVertexColor(self:Colorize("channelbar",(barValue - this.startTime) / (this.endTime - this.startTime)));
			self.casting_time_del = self:FormatTime(this.delay);
			self.casting_time     = self:FormatTime((time + this.delay) - this.startTime);
			self.casting_time_rev = self:FormatTime(this.duration -((time + this.delay) - this.startTime));
			self:triggerTextEvent("MetaHud_Casttime_Text");
			self:triggerTextEvent("MetaHud_Castdelay_Text");
			if(this.onTaxi == nil) then
				self:updateAlpha();
			end

			if (time == this.endTime) then
				this.channeling = nil;
				this.casting    = nil;
				this.fadeOut    = 1;
				this.flash      = nil;
				self.Casting    = nil;  
				self:SetBarHeight("MetaHud_Casting_Bar", 0 );
				self:updateAlpha();
				self.TimerSet = nil;
			end
		---  hold
		elseif this.holdTime and GetTime() < this.holdTime then
        ---  flash
		elseif this.flash then
			local alpha = MetaHud_Flash_Bar:GetAlpha() + CASTING_BAR_FLASH_STEP;
			if alpha < 1 and MetaHudOptions["reversecasting"] == 0 then
				MetaHud_Flash_Bar:SetAlpha(alpha);
			else
				this.flash = nil;
				MetaHud_Flash_Bar:SetAlpha(0);
				MetaHud_Flash_Bar:Hide();
			end
		---  fade
		elseif this.fadeOut then
			local alpha = MetaHud_Casting_Bar:GetAlpha() - CASTING_BAR_ALPHA_STEP;
			if alpha > 0 and MetaHudOptions["reversecasting"] == 0 then
				MetaHud_Casting_Bar:SetAlpha(alpha);
				MetaHud_Casttime_Text:SetAlpha(alpha);
				MetaHud_Castdelay_Text:SetAlpha(alpha);
			else
				this.fadeOut = nil;
				self.Casting = nil;
				self.casting_time     = nil;
				self.casting_time_rev = nil;
				self.casting_time_del = nil;
				self.spellname        = nil;
				self:triggerTextEvent("MetaHud_Casttime_Text");
				self:triggerTextEvent("MetaHud_Castdelay_Text");
				MetaHud_Casting_Bar:Hide();
				MetaHud_Casting_Bar:SetAlpha(0);
				self:updateAlpha();
			end
		end
	end
end

--- register Events
function MetaHud:registerEvents()
	local f = MetaHud_EventFrame;   
	for e, v in pairs(self.mainEvents) do
		f:RegisterEvent(self.mainEvents[e]); 
	end
end

--- unregister events (on zoning)
function MetaHud:unregisterEvents()
	local f = MetaHud_EventFrame;   
	for e, v in pairs(self.mainEvents) do
		f:UnregisterEvent(self.mainEvents[e]); 
	end
end

--- set layout
function MetaHud:setLayout()
	self.C_baseLayout = "MetaHud_Base_Layout";
	self.C_curLayout  = MetaHudOptions["layouttyp"] or 1;
	self:UpdateLayout(self.C_curLayout);
	self.C_textures   = MetaHud_Layouts[self.C_baseLayout]["MetaHud_textures"];
	self.C_frames     = MetaHud_Layouts[self.C_baseLayout]["MetaHud_frames"];
	self.C_tClips     = MetaHud_Layouts[self.C_baseLayout]["MetaHud_textures_clip"];
	self.C_names      = MetaHud_Layouts[self.C_baseLayout]["MetaHud_names"];
end

--- Setup MetaHud --
function MetaHud:setup() 
	self:printd("setup START");
	self.issetup = 1;
	---  Get Humanoid Creature Type
	self.humanoid = UnitCreatureType("player");
	---  set userid 
	self.userID = GetRealmName()..":"..UnitName("player");
	_, self.player_class = UnitClass("player");
	---  set default Values
	if( not MetaHudOptions ) then
		MetaHudOptions = { };
	end
	for k, v in pairs(self.Config_default) do
		self:SetDefaultConfig(k);
	end
	---  init Layout (ref settings to hud)
	self:SetLayoutElements();
	self:setLayout();
	---  create all Frames
	self:createFrames();
	MetaHud_Target_Text:RegisterForClicks('LeftButtonUp', 'RightButtonUp');
	MetaHud_Target_Text:SetScript("OnClick", function() 
		if(IsControlKeyDown()) then
			ToggleDropDownMenu(1, 1, MetaHud_QuickMenu_DropDown, "MetaHud_Target_Text", 25, 10);
		elseif(IsAltKeyDown()) then
			if(IsAddOnLoaded("MetaMap")) then
				MetaMapNotes_Quicknote("1 "..UnitName("target"));
			end
		elseif(arg1 == "LeftButton") then
			ToggleDropDownMenu(1, nil, MetaHud_Target_DropDown, "MetaHud_Target_Text", 25, 10);
		else
			if(self.inParty == 1) then
				ToggleDropDownMenu(1, nil, MetaHud_Player_DropDown, "MetaHud_Target_Text" , 25, 10); 
			end
		end
	end );
	MetaHud_ToTarget_Text:SetScript("OnClick", function() 
		local unit = UnitName("targettarget");
		if(SpellIsTargeting() and unit) then
			SpellTargetUnit(unit);
		elseif(unit) then
			TargetByName(unit);
		end
		self:TargetChanged();
	end );
	MetaHud_Range_Text:SetScript("OnClick", function()
		if(ChatFrameEditBox:IsVisible()) then
			local destination, started, ended = self:FlightTimer();
			if(ended ~= nil) then
				ChatFrameEditBox:Insert("I am in-flight to "..destination..". ETA: "..MetaHud:FormatTime(ended - GetTime()));
			end
		end
	end );
	MetaHud_ToT_Frame:SetPoint("TOP", "MetaHud_ToTarget_Text", "BOTTOM", 0, -5);
	MetaHud_ToT_Frame:EnableMouse(false);
	MetaHud_ToTargetHealth_Bar:EnableMouse(false);
	self:CreateMMB();
	self:myAddons();
	self:registerEvents();
	self:printd("setup END");
	self.issetup = 2;
end

--- prepare colors
function MetaHud:prepareColors()
	---  for k, v in self.BarColor do
	for k, v in pairs(MetaHudOptions["colors"]) do
		local color0 = {};
		local color1 = {};
		local color2 = {};
		local h0, h1, h2;  
		h0, h1, h2 = unpack(MetaHudOptions["colors"][k]);
		color0.r , color0.g , color0.b = unpack(MetaHud_hextodec(h0));
		color1.r , color1.g , color1.b = unpack(MetaHud_hextodec(h1));
		color2.r , color2.g , color2.b = unpack(MetaHud_hextodec(h2));
		self.BarColorTab[k] = { color0, color1, color2 };
	end
end

function MetaHud:SetFont()
	local font = MetaHud.FontFile[MetaHudOptions.fontfile];
	if(font == nil or font == "default") then
		self.defaultfont = "Fonts/FRIZQT__.TTF";
		self.defaultfont_num = METAHUD_LAYOUTPATH.."Number.TTF";
	else
		self.defaultfont = font;
		self.defaultfont_num = font;
	end
end

--- init HUD
function MetaHud:init()
	self:printd("init START");
	self.isinit = 1;
	self:prepareColors();
	self:SetFont();
	---  set Hud Scale
	MetaHud_Main:SetScale(MetaHudOptions["scale"] or 1);
	---  set ToT Scale
	MetaHud_ToT_Frame:SetScale(MetaHudOptions["ttscale"] or 1);
	---  set Bars
	if(this.onTaxi == nil) then
		self:UpdateValues("MetaHud_PlayerHealth_Text", 1 );
		self:UpdateValues("MetaHud_PlayerMana_Text", 1 );
		self:UpdateValues("MetaHud_TargetHealth_Text", 1);
		self:UpdateValues("MetaHud_TargetMana_Text", 1);
		self:UpdateValues("MetaHud_PetHealth_Text", 1);
		self:UpdateValues("MetaHud_PetMana_Text",  1);
	end
	self:UpdateCombos();
	self:Auras();
	self:ChangeBackgroundTexture();
	self:updateStatus();
	self:updateParty();
	self:updatePlayerPvP();
	self:updateTargetPvP();
	self:updatePetIcon();
	---  set font
	MetaHud_Castdelay_Text_Text:SetFont(self.defaultfont_num, MetaHudOptions["fontsizecastdelay"] / MetaHudOptions["scale"], self.Outline[ MetaHudOptions["castdelayoutline"] ]);
	MetaHud_Casttime_Text_Text:SetFont(self.defaultfont_num, MetaHudOptions["fontsizecasttime"] / MetaHudOptions["scale"], self.Outline[ MetaHudOptions["castdelayoutline"] ]);
	MetaHud_PlayerHealth_Text_Text:SetFont(self.defaultfont_num, MetaHudOptions["fontsizeplayer"] / MetaHudOptions["scale"], self.Outline[ MetaHudOptions["playerhpoutline"] ]);
	MetaHud_PlayerMana_Text_Text:SetFont(self.defaultfont_num, MetaHudOptions["fontsizeplayer"] / MetaHudOptions["scale"], self.Outline[ MetaHudOptions["playermanaoutline"] ]);
	MetaHud_TargetHealth_Text_Text:SetFont(self.defaultfont_num, MetaHudOptions["fontsizetarget"] / MetaHudOptions["scale"], self.Outline[ MetaHudOptions["targethpoutline"] ]);
	MetaHud_TargetMana_Text_Text:SetFont(self.defaultfont_num, MetaHudOptions["fontsizetarget"] / MetaHudOptions["scale"], self.Outline[ MetaHudOptions["targetmanaoutline"] ]);
	MetaHud_PetHealth_Text_Text:SetFont(self.defaultfont_num, MetaHudOptions["fontsizepet"] / MetaHudOptions["scale"], self.Outline[ MetaHudOptions["pethpoutline"] ]);
	MetaHud_PetMana_Text_Text:SetFont(self.defaultfont_num, MetaHudOptions["fontsizepet"] / MetaHudOptions["scale"], self.Outline[ MetaHudOptions["petmanaoutline"] ]);
	MetaHud_Target_Text_Text:SetFont(self.defaultfont, MetaHudOptions["fontsizetargetname"] / MetaHudOptions["scale"], self.Outline[ MetaHudOptions["targetoutline"] ]);
	MetaHud_ToTarget_Text_Text:SetFont(self.defaultfont, MetaHudOptions["fontsizetotarget"] / MetaHudOptions["scale"], self.Outline[ MetaHudOptions["totargetoutline"] ]);
	MetaHud_Range_Text_Text:SetFont(self.defaultfont, MetaHudOptions["fontsizerange"] / MetaHudOptions["scale"], self.Outline[ MetaHudOptions["rangeoutline"] ]);
	MetaHud_Guild_Text_Text:SetFont(self.defaultfont, MetaHudOptions["fontsizeguild"] / MetaHudOptions["scale"], self.Outline[ MetaHudOptions["guildoutline"] ]);
	---  Hide Blizz Target Frame
	if MetaHudOptions["btarget"] == 0 then
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
		if UnitExists("target") then TargetFrame:Show() end
			ComboFrame:RegisterEvent("PLAYER_TARGET_CHANGED")
			ComboFrame:RegisterEvent("PLAYER_COMBO_POINTS")
		end
	---  Hide Blizz Player Frame
	if MetaHudOptions["bplayer"] == 0 then
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
	---  hide blizz castbar
	if MetaHudOptions["bcastingbar"] == 0 then
		CastingBarFrame:UnregisterEvent("SPELLCAST_START");
		CastingBarFrame:UnregisterEvent("SPELLCAST_STOP");
		CastingBarFrame:UnregisterEvent("SPELLCAST_FAILED");
		CastingBarFrame:UnregisterEvent("SPELLCAST_INTERRUPTED");
		CastingBarFrame:UnregisterEvent("SPELLCAST_DELAYED");
		CastingBarFrame:UnregisterEvent("SPELLCAST_CHANNEL_START");
		CastingBarFrame:UnregisterEvent("SPELLCAST_CHANNEL_UPDATE");
		CastingBarFrame:UnregisterEvent("SPELLCAST_CHANNEL_STOP");
		CastingBarFrame:UnregisterEvent("UNIT_SPELLCAST_START");
		CastingBarFrame:UnregisterEvent("UNIT_SPELLCAST_STOP");
		CastingBarFrame:UnregisterEvent("UNIT_SPELLCAST_FAILED");
		CastingBarFrame:UnregisterEvent("UNIT_SPELLCAST_INTERRUPTED");
		CastingBarFrame:UnregisterEvent("UNIT_SPELLCAST_DELAYED");
		CastingBarFrame:UnregisterEvent("UNIT_SPELLCAST_CHANNEL_START");
		CastingBarFrame:UnregisterEvent("UNIT_SPELLCAST_CHANNEL_UPDATE");
		CastingBarFrame:UnregisterEvent("UNIT_SPELLCAST_CHANNEL_STOP");
		CastingBarFrame:Hide();
	else
		CastingBarFrame:RegisterEvent("SPELLCAST_START");
		CastingBarFrame:RegisterEvent("SPELLCAST_STOP");
		CastingBarFrame:RegisterEvent("SPELLCAST_FAILED");
		CastingBarFrame:RegisterEvent("SPELLCAST_INTERRUPTED");
		CastingBarFrame:RegisterEvent("SPELLCAST_DELAYED");
		CastingBarFrame:RegisterEvent("SPELLCAST_CHANNEL_START");
		CastingBarFrame:RegisterEvent("SPELLCAST_CHANNEL_UPDATE");
		CastingBarFrame:RegisterEvent("SPELLCAST_CHANNEL_STOP");
		CastingBarFrame:RegisterEvent("UNIT_SPELLCAST_START");
		CastingBarFrame:RegisterEvent("UNIT_SPELLCAST_STOP");
		CastingBarFrame:RegisterEvent("UNIT_SPELLCAST_FAILED");
		CastingBarFrame:RegisterEvent("UNIT_SPELLCAST_INTERRUPTED");
		CastingBarFrame:RegisterEvent("UNIT_SPELLCAST_DELAYED");
		CastingBarFrame:RegisterEvent("UNIT_SPELLCAST_CHANNEL_START");
		CastingBarFrame:RegisterEvent("UNIT_SPELLCAST_CHANNEL_UPDATE");
		CastingBarFrame:RegisterEvent("UNIT_SPELLCAST_CHANNEL_STOP");
	end;
	---  update Alpha
	self.inCombat = nil;
	if(this.onTaxi == nil) then
		self:updateAlpha();
		MetaHud_Flash_Bar:SetAlpha(0);
		MetaHud_Casting_Bar:SetAlpha(0);
		MetaHud_Casting_Bar:Hide();
		MetaHud_Flash_Bar:Hide();
		---  init castbar
		this.endTime = 0;
	end
	---  pos frames
	self:PositionFrame("MetaHud_Main");
	self:PositionFrame("MetaHud_LeftFrame");
	self:PositionFrame("MetaHud_RightFrame");
	self:PositionFrame("MetaHud_Target_Text");
	self:PositionFrame("MetaHud_ToTarget_Text");
	self:PositionFrame("MetaHud_Range_Text");
	self:PositionFrame("MetaHud_Guild_Text");
	self:PositionFrame("MetaHud_PlayerHealth_Text");
	self:PositionFrame("MetaHud_PlayerMana_Text");
	self:PositionFrame("MetaHud_TargetHealth_Text");
	self:PositionFrame("MetaHud_TargetMana_Text");
	self:PositionFrame("MetaHud_PetHealth_Text");
	self:PositionFrame("MetaHud_PetMana_Text");    
	self:PositionFrame("MetaHud_Casttime_Text");
	self:PositionFrame("MetaHud_Castdelay_Text");
	---  top frames
	MetaHud_TargetElite:SetFrameLevel(MetaHud_RightFrame:GetFrameLevel() + 1);
	MetaHud_Flash_Bar:SetFrameLevel(MetaHud_PlayerMana_Bar:GetFrameLevel() + 1);
	MetaHud_Casting_Bar:SetFrameLevel(MetaHud_Flash_Bar:GetFrameLevel() + 1);
	---  minimap button
	if MetaHudOptions["showmmb"] == 1 then
		MetaHudMinimapButton:Show();
		MetaHudMinimapButton:SetFrameStrata(Minimap:GetFrameStrata());
		MetaHudMinimapButton:SetFrameLevel(Minimap:GetFrameLevel() + 3);	
	else
		MetaHudMinimapButton:Hide();
	end
	---  alter pet manatext when class = DRUID
	if DruidBarKey and self.player_class == "DRUID" and MetaHudOptions["MetaHud_PetMana_Text"] == METAHUD_TEXT_MP2 then
		MetaHudOptions["MetaHud_PetMana_Text"] = METAHUD_TEXT_MP7;
	end
	---  trigger all texts
	self:triggerAllTextEvents();

	if(IsAddOnLoaded("FlightMap")) then
		if(FlightMapTimesFrame:GetLeft() ~= 0) then
			MetaHudOptions.flightmapx = FlightMapTimesFrame:GetLeft();
			MetaHudOptions.flightmapy = FlightMapTimesFrame:GetBottom();
		end
		if(MetaHudOptions["showflighttimer"] == 1) then
			FlightMapTimesFrame:ClearAllPoints();
			FlightMapTimesFrame:SetParent("UIParent");
			FlightMapTimesFrame:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOMLEFT", 0, -200);
		else
			FlightMapTimesFrame:ClearAllPoints();
			FlightMapTimesFrame:SetParent("UIParent");
			FlightMapTimesFrame:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOMLEFT", MetaHudOptions.flightmapx, MetaHudOptions.flightmapy);
		end
	end
	---  init end   
	self.isinit = 2;
	self:printd("init END");
end

--- Change Frame Pos
function MetaHud:PositionFrame(name,x2,y2)
	local xn , yn, mx, my = unpack ( self.moveFrame[name] );
	local x2 = tonumber(MetaHudOptions[xn] or 0);
	local y2 = tonumber(MetaHudOptions[yn] or 0);
	if mx == "-" then
		x2 = 0 - x2;
	end
	if my == "-" then
		y2 = 0 - y2;
	end
	local typ, point, frame, relative, x, y, width, height = unpack( self.C_frames[name] );
	local ref = getglobal(name);
	self:printd( name.." "..(x + x2).." "..(y + y2) );
	ref:SetPoint(point, frame , relative, x + x2, y + y2);
end

function MetaHud:TargetChanged()     
	if UnitExists("target") then
		self.Target = 1;
	else
		self.Target = nil;
	end
	if (MetaHudOptions["shownpc"] == 0 and self:TargetIsNPC()) or MetaHudOptions["showtarget"] == 0 then
		self:SetBarHeight("MetaHud_TargetHealth_Bar",0);
		self:SetBarHeight("MetaHud_TargetMana_Bar",0);
		self.Target = nil;
	else
		self:UpdateValues("MetaHud_TargetHealth_Text", 1);
		self:UpdateValues("MetaHud_TargetMana_Text", 1); 
	end
	self:UpdateCombos();  
	self:updateParty();
	self:updateTargetPvP();
	self:ChangeBackgroundTexture();     
	self:updateAlpha();
	self:Auras();
	if(UnitIsUnit("target", "player") and self.inParty == 1) or
			( UnitIsPlayer("target")  and not UnitIsEnemy("player", "target")) or UnitIsUnit("target", "pet") then
		MetaHud:Set_TargetMode(1);
	else
		MetaHud:Set_TargetMode(0);
	end
end

function MetaHud:SpellCast_Start(arg1, arg2)
	self.spellname  = arg1;
	this.startTime  = GetTime();
	this.maxValue   = this.startTime + (arg2 / 1000);
	this.holdTime   = 0;
	this.casting    = 1;
	this.delay      = 0;
	this.channeling = nil;
	this.fadeOut    = nil;
	this.flash      = nil;
	this.duration   = floor(arg2 / 100) / 10;
	self.Casting    = true;
	self:updateAlpha();
	MetaHud_Casttime_Text:SetAlpha(1);
	MetaHud_Castdelay_Text:SetAlpha(1);
	MetaHud_Casting_Bar:Show();
	MetaHud_Flash_Bar:Hide();
end

function MetaHud:SpellChannel_Start(arg1, arg2)
	self.spellname  = arg2;
	this.maxValue   = 1;
	this.startTime  = GetTime();
	this.endTime    = this.startTime + (arg1 / 1000);
	this.duration   = arg1 / 1000;
	this.holdTime   = 0;
	this.casting    = nil;
	this.channeling = 1;
	this.flash      = nil;
	this.fadeOut    = nil;
	this.delay      = 0;
	self.Casting    = true;
	self:SetBarHeight("MetaHud_Casting_Bar",1);
	MetaHud_Casting_Bar_Texture:SetVertexColor(self:Colorize("channelbar",0));
	MetaHud_Casttime_Text:SetAlpha(1);
	MetaHud_Castdelay_Text:SetAlpha(1);
	MetaHud_Casting_Bar:Show();
	MetaHud_Flash_Bar:Hide();
end

function MetaHud:Set_TargetMode(mode)
	if(MetaHudOptions["activename"] == 0) then
		getglobal("MetaHud_Target_Text"):EnableMouse(mode);
		return;
	end
	if(mode == 1) then
		MetaHud_Target_Text:SetScript("OnEnter", nil);
		MetaHud_Target_Text:SetScript("OnLeave", nil);
	else
		MetaHud_Target_Text:SetScript("OnEnter", function() self:Show_MobInfo(); end);
		MetaHud_Target_Text:SetScript("OnLeave", function() GameTooltip:Hide(); end);
	end
	getglobal("MetaHud_Target_Text"):EnableMouse(true);
end

--- Create all Frames --
function MetaHud:createFrames()
	for i = 1, getn(self.C_names) do
		self:createFrame(self.C_names[i]);
	end
end

--- Transform Frames
function MetaHud:transformFrames(layout)
	if layout == 1 or layout == 2 then
		self:SetConfig( "layouttyp", layout );
		self:setLayout();
		self.frame_level = 0;
		for i = 1, getn(self.C_names) do
			self:transform(self.C_names[i]);
		end
		self:init();
	end
end

--- Frame transformer
function MetaHud:transform(name)
    
    ---  does frame exist in list?
    if not self.C_frames[name] then
        return;
    end
    
    ---  get frame settings
    local typ, point, frame, relative, x, y, width, height = unpack( self.C_frames[name] );  
    self.frame_level = self.frame_level + 1;
    
    ---  debug
    self:printd("MetaHud: transformFrame "..name.." typ:"..typ .." level:"..self.frame_level);
    
    if typ == "Frame" then
        local ref = getglobal(name);
        ref:SetPoint(point, frame , relative, x, y);
        ref:SetHeight(height);
        ref:SetWidth(width); 
        
        ---  debug background
        if self.debug then
            --ref:SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 32, insets = { left = 0, right = 0, top = 0, bottom = 0 }});
            --ref:SetBackdropColor(0,0,0,0.2);
        end
        
        ref:SetFrameLevel(self.frame_level);
        ref:SetParent(frame);
        ref:EnableMouse(false);
        ref:Show();       
    elseif typ == "Texture" then    
        local texture,x0,x1,y0,y1 = unpack( self.C_textures[name] );
        local ref = getglobal(name);
        ref:ClearAllPoints();
        ref:SetPoint(point, frame , relative, x, y);
        ref:SetHeight(height);
        ref:SetWidth(width);
        
        ---  debug background
        if self.debug then
            --ref:SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 32, insets = { left = 0, right = 0, top = 0, bottom = 0 }});
            --ref:SetBackdropColor(0,1,0,0.3);
        end
        strata = "BACKGROUND";
        if name == "MetaHud_Casting_Bar" or name == "MetaHud_Flash_Bar" then
            strata = "LOW";
        end

        local bgt = getglobal(name.."_Texture");
        bgt:SetTexture(texture);
        bgt:ClearAllPoints();
        bgt:SetPoint("TOPLEFT", ref , "TOPLEFT", 0, 0);
        bgt:SetPoint("BOTTOMRIGHT", ref , "BOTTOMRIGHT", 0, 0);
        bgt:SetTexCoord(x0,x1,y0,y1);
        
        ref:SetFrameStrata(strata);
        ref:SetFrameLevel(self.frame_level);
        ref:SetParent(frame);
        ref:EnableMouse(false);
        ref:Show();

    elseif typ == "Bar" then    
        local texture,x0,x1,y0,y1 = unpack( self.C_textures[name] );
        local ref = getglobal(name);
        ref:ClearAllPoints();
        ref:SetPoint(point, frame , relative, x, y);
        ref:SetHeight(height);
        ref:SetWidth(width);
        
        ---  debug background
        if self.debug then
            --ref:SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 32, insets = { left = 0, right = 0, top = 0, bottom = 0 }});
            --ref:SetBackdropColor(0,1,0,0.1);
        end
        local bgt = getglobal(name.."_Texture");
        bgt:SetTexture(texture);
        bgt:SetPoint(point, ref, relative, 0, 0);
        bgt:SetHeight(height);
        bgt:SetWidth(width);
        bgt:SetTexCoord(x0,x1,y0,y1);
        
        ref:SetFrameStrata("BACKGROUND");
        ref:SetFrameLevel(self.frame_level);
        ref:SetParent(frame);
        ref:EnableMouse(false);
        ref:Show();    
        
    elseif typ == "Text" then
        local ref = getglobal(name);
        ref:ClearAllPoints();
        ref:SetPoint(point, frame , relative, x, y);
        
        ---  debug background
        if self.debug then
           ---  ref:SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 32, insets = { left = 0, right = 0, top = 0, bottom = 0 }});
            --ref:SetBackdropColor(0,0,1,0.5);
        end
        
        local font = getglobal(name.."_Text");
        font:SetFontObject(GameFontHighlightSmall);
        if self.debug then
            font:SetText(name);
        else
            font:SetText(" ");
        end
        font:SetJustifyH("CENTER");
        font:SetWidth(font:GetStringWidth());
        font:SetHeight(height);
        font:Show();
        font:ClearAllPoints();
        font:SetPoint(point, ref, relative,0, 0);
        
        ---  ref:SetFrameStrata("BACKGROUND");
        ref:SetFrameLevel(self.frame_level);
        ref:SetHeight(height);
        ref:SetWidth(font:GetStringWidth());
        ref:SetParent(frame);
        ref:EnableMouse(false);
        ref:Show();
        self:initTextfield(ref,name); 
        
    elseif typ == "Buff" then
    
        local ref = getglobal(name);
        ref:ClearAllPoints();
        ref:SetPoint(point, frame , relative, x, y);
        ref:SetHeight(height);
        ref:SetWidth(width);
        
        ---  debug background
        if self.debug then
            --ref:SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 32, insets = { left = 0, right = 0, top = 0, bottom = 0 }});
            --ref:SetBackdropColor(1,0,0,0.2);
        end

        local font = getglobal(name.."_Text");
        font:SetFontObject(GameFontHighlightSmall);
        font:SetText("");
        font:SetJustifyH("RIGHT");
        font:SetJustifyV("BOTTOM");
        font:SetWidth(width+1);
        font:SetHeight(height-5);
        font:SetFont( self.defaultfont, width / 2.2, "OUTLINE");
        font:Show();
        font:ClearAllPoints();
        font:SetPoint(point, frame, relative,x, y);
        
        local bgt = getglobal(name.."_Border");
        bgt:SetTexture("Interface\\Buttons\\UI-Debuff-Border");
        bgt:SetPoint("BOTTOM", ref, "BOTTOM", 0, 0);
        bgt:SetHeight(height);
        bgt:SetWidth(width);
        bgt:SetTexCoord(0,1,0,1);        
                
        ref:SetNormalTexture(METAHUD_ICON);
        ref:SetFrameLevel(self.frame_level);
        ref:SetParent(frame);
        
        ref:SetScript("OnEnter", function() 
                if (not this:IsVisible()) then return; end
                if MetaHudOptions["showauratips"] == 0 then return; end
                GameTooltip:SetOwner(this, "ANCHOR_BOTTOMRIGHT");
                if this.hasdebuff == 1 then
                    GameTooltip:SetUnitDebuff(this.unit, this.id);
                else
                    GameTooltip:SetUnitBuff(this.unit, this.id);
                end
            end );
 
         ref:SetScript("OnLeave", function() 
                GameTooltip:Hide();
            end );
                         
        ref:EnableMouse(true);
        ref:Show();
   
    end
end    
    
--- Frame Creator
function MetaHud:createFrame(name)
	---  does frame exist in list?
	if not self.C_frames[name] then
		return;
	end
	---  get frame settings
	local typ, point, frame, relative, x, y, width, height = unpack( self.C_frames[name] );
	---  set framelevel
	if not self.frame_level then 
		---  self.frame_level = getn(self.C_names) + 1; 
		self.frame_level = 0;
	end
	self.frame_level = self.frame_level + 1;
	---  debug
	self:printd("MetaHud: createFrame "..name.." parent:"..frame.." typ:"..typ .." level:"..self.frame_level);    
	---  set frame        
	if typ == "Frame" then
		ref = CreateFrame ("Frame", name, getglobal(frame) );
		ref:ClearAllPoints();
		ref:SetPoint(point, frame , relative, x, y);
		ref:SetHeight(height);
		ref:SetWidth(width);
		---  debug background
		if self.debug then
			--- ref:SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 32, insets = { left = 0, right = 0, top = 0, bottom = 0 }});
			--- ref:SetBackdropColor(0,0,0,0.2);
		end
		ref:SetFrameLevel(self.frame_level);
		ref:SetParent(frame);
		ref:EnableMouse(false);
		ref:Show();
    
    ---  set bar
    elseif typ == "Texture" then    
        local texture,x0,x1,y0,y1 = unpack( self.C_textures[name] );
        ref = CreateFrame ("Frame", name, getglobal(frame) );
        ref:ClearAllPoints();
        ref:SetPoint(point, frame , relative, x, y);
        ref:SetHeight(height);
        ref:SetWidth(width);
        
        ---  debug background
        if self.debug then
            --ref:SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 32, insets = { left = 0, right = 0, top = 0, bottom = 0 }});
            --ref:SetBackdropColor(0,1,0,0.3);
        end
        strata = "BACKGROUND";
        if name == "MetaHud_Casting_Bar" or name == "MetaHud_Flash_Bar" then
            strata = "LOW";
        end
        local bgt = ref:CreateTexture(name.."_Texture",strata);
        bgt:SetTexture(texture);
        bgt:ClearAllPoints();
        bgt:SetPoint("TOPLEFT", ref , "TOPLEFT", 0, 0);
        bgt:SetPoint("BOTTOMRIGHT", ref , "BOTTOMRIGHT", 0, 0);
        bgt:SetTexCoord(x0,x1,y0,y1);
        ref:SetFrameLevel(self.frame_level);
        ref:SetParent(frame);
        ref:EnableMouse(false);
        ref:Show();
    ---  set bar
    elseif typ == "Bar" then    
        local texture,x0,x1,y0,y1 = unpack( self.C_textures[name] );
        ref = CreateFrame ("Frame", name, getglobal(frame));
        ref:ClearAllPoints();
        ref:SetPoint(point, frame , relative, x, y);
        ref:SetHeight(height);
        ref:SetWidth(width);
        
        ---  debug background
        if self.debug then
            --ref:SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 32, insets = { left = 0, right = 0, top = 0, bottom = 0 }});
            --ref:SetBackdropColor(0,1,0,0.1);
        end
        
        local bgt = ref:CreateTexture(name.."_Texture","BACKGROUND");
        bgt:SetTexture(texture);
        bgt:SetPoint(point, ref, relative, 0, 0);
        bgt:SetHeight(height);
        bgt:SetWidth(width);
        bgt:SetTexCoord(x0,x1,y0,y1);
        ref:SetFrameLevel(self.frame_level);
        ref:SetParent(frame);
        ref:EnableMouse(false);
        ref:Show();            
    ---  set text
    elseif typ == "Text" then
        ref = CreateFrame ("Button", name, getglobal(frame));
        ref:ClearAllPoints();
        ref:SetPoint(point, frame , relative, x, y);
        
        ---  debug background
        if self.debug then
           ---  ref:SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 32, insets = { left = 0, right = 0, top = 0, bottom = 0 }});
           ---  ref:SetBackdropColor(0,0,1,0.5);
        end
        
        local font = ref:CreateFontString(name.."_Text", "ARTWORK");
        font:SetFontObject(GameFontHighlightSmall);
        if self.debug then
            font:SetText(name);
        else
            font:SetText(" ");
        end
        font:SetJustifyH("CENTER");
        font:SetWidth(font:GetStringWidth());
        font:SetHeight(height);
        font:Show();
        font:ClearAllPoints();
        font:SetPoint(point, ref, relative,0, 0);
        
        ref:SetFrameLevel(self.frame_level);
        ref:SetHeight(height);
        ref:SetWidth(font:GetStringWidth());
        ref:SetParent(frame);
        ref:EnableMouse(false);
        ref:Show();
        self:initTextfield(ref,name);        
        		
    ---  set buffs    
    elseif typ == "Buff" then
        ref = CreateFrame ("Button", name, getglobal(frame));
        ref:ClearAllPoints();
        ref:SetPoint(point, frame , relative, x, y);
        ref:SetHeight(height);
        ref:SetWidth(width);
        
        ---  debug background
        if self.debug then
           ---  ref:SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 32, insets = { left = 0, right = 0, top = 0, bottom = 0 }});
           ---  ref:SetBackdropColor(1,0,0,0.2);
        end

        local font = ref:CreateFontString(name.."_Text", "ARTWORK");
        font:SetFontObject(GameFontHighlightSmall);
        font:SetText("");
        font:SetJustifyH("RIGHT");
        font:SetJustifyV("BOTTOM");
        font:SetWidth(width+1);
        font:SetHeight(height-5);
        font:SetFont( self.defaultfont, width / 2.2, "OUTLINE");
        font:Show();
        font:ClearAllPoints();
        font:SetPoint(point, frame, relative,x, y);
        
        local bgt = ref:CreateTexture(name.."_Border","OVERLAY");
        bgt:SetTexture("Interface\\Buttons\\UI-Debuff-Border");
        bgt:SetPoint("BOTTOM", ref, "BOTTOM", 0, 0);
        bgt:SetHeight(height);
        bgt:SetWidth(width);
        bgt:SetTexCoord(0,1,0,1);        
                
        ref:SetNormalTexture(METAHUD_ICON);
        ref:SetFrameLevel(self.frame_level);
        ref:SetParent(frame);
        
        ref:SetScript("OnEnter", function() 
                if (not this:IsVisible()) then return; end
                if MetaHudOptions["showauratips"] == 0 then return; end
                GameTooltip:SetOwner(this, "ANCHOR_BOTTOMRIGHT");
                if this.hasdebuff == 1 then
                    GameTooltip:SetUnitDebuff(this.unit, this.id);
                else
                    GameTooltip:SetUnitBuff(this.unit, this.id);
                end
            end );
 
         ref:SetScript("OnLeave", function() 
                GameTooltip:Hide();
            end );
                         
        ref:EnableMouse(true);
        ref:Show();
    end
end

--- create minimap button (thanks to gello's great lib)
function MetaHud:CreateMMB()
	local info = {
		icon = METAHUD_ICON,
		position = 0, ---  default only. after first use, SavedVariables used
		drag = "CIRCLE", ---  default only. after first use, SavedVariables used
		left = function() TargetUnit("player"); end,
		right = function() self:OptionsFrame_Toggle(); end,
		tooltip = "Left click: Display HUD \nRight click: Options Menu",
		enabled = "ON" ---  default only. after first use, SavedVariables used
	}
	MyMinimapButton:Create("MetaHud", MetaHudOptions.mmb ,info)
end

--- colorize bar
function MetaHud:SetBarColor(bar,percent)
	local unit = self.name2unit[bar];
	local typ  = self.name2typ[bar];
	typunit = self:getTypUnit(unit,typ);
	local texture = getglobal(bar.."_Texture");
	texture:SetVertexColor(self:Colorize(typunit,percent));
end

--- gettypeunit
function MetaHud:getTypUnit(unit,typ)
	---  what power type?
	if typ == "mana" then
		if UnitPowerType(unit) then
			typ = self.powertypes[ UnitPowerType(unit)+1 ];
		end
	end
	---  create index
	local typunit = typ.."_"..unit;
	---  default 
	if not self.BarColorTab[typunit] then
		typunit = "mana_pet";
	end
	---  only tap target bars
	if unit == "target" then
		if (UnitIsTapped("target") and (not UnitIsTappedByPlayer("target"))) then
			typunit = "tapped";
		end
	end
	return typunit;
end

--- Colorize
function MetaHud:Colorize(typunit,percent)
	if not self.BarColorTab[typunit] then return 0,0,0; end
	local r, g, b, diff;
	local threshold1 = 0.6;    
	local threshold2 = 0.3;
	local color0 = self.BarColorTab[typunit][1];
	local color1 = self.BarColorTab[typunit][2];
	local color2 = self.BarColorTab[typunit][3];
            
	if ( percent <= threshold2 ) then
		r = color2.r;        
		g = color2.g;        
		b = color2.b;    
	elseif ( percent <= threshold1) then        
		diff = 1 - (percent - threshold2) / (threshold1 - threshold2);
		r = color1.r - (color1.r - color2.r) * diff;        
		g = color1.g - (color1.g - color2.g) * diff;        
		b = color1.b - (color1.b - color2.b) * diff;    
	elseif ( percent < 1) then        
		diff = 1 - (percent - threshold1) / (1 - threshold1);        
		r = color0.r - (color0.r - color1.r) * diff;        
		g = color0.g - (color0.g - color1.g) * diff;        
		b = color0.b - (color0.b - color1.b) * diff;    
	else       
		r = color0.r;
		g = color0.g;
		b = color0.b;    
	end 

	if (r < 0) then r = 0; end    
	if (r > 1) then r = 1; end    
	if (g < 0) then g = 0; end    
	if (g > 1) then g = 1; end    
	if (b < 0) then b = 0; end    
	if (b > 1) then b = 1; end     
	return r,g,b;
end

--- set bar height
function MetaHud:SetBarHeight(bar,p)
	local texture = getglobal(bar.."_Texture");
	---  Hide when Bar empty 
	if math.floor(p * 100) == 0 or UnitIsDeadOrGhost("player") then
		texture:Hide();
		return;
	end
	---  Texture Settings
	local typ, point, frame, relative, x, y, width, height = unpack( self.C_frames[bar] );
	local texname,x0,x1,y0,y1 = unpack(self.C_textures[bar]);        
	local tex_height, tex_gap_top, tex_gap_bottom = unpack(self.C_tClips[texname]);
	---  offsets
	local tex_gap_top_p    = tex_gap_top / tex_height;    
	local tex_gap_bottom_p = tex_gap_bottom / tex_height;
	local h = (tex_height - tex_gap_top - tex_gap_bottom) * p;
	local top    = 1-(p-(tex_gap_top_p));
	local bottom = 1-tex_gap_bottom_p;
	top = top  - ((tex_gap_top_p+tex_gap_bottom_p)*(1-p));
	texture:SetHeight(h);
	texture:SetTexCoord(x0, x1, top, bottom );
	texture:SetPoint(point, getglobal(frame), relative, x, tex_gap_bottom);
	texture:Show();
end;

--- show / hide combopoints
function MetaHud:UpdateCombos()
	if(MetaHudOptions.showcombopoints == nil) then 
		MetaHud_Combo1:Hide();
		MetaHud_Combo2:Hide();
		MetaHud_Combo3:Hide();
		MetaHud_Combo4:Hide();
		MetaHud_Combo5:Hide();
		return;
	end
	local points = GetComboPoints()
	if(points == 0) then 
		MetaHud_Combo1:Hide();
		MetaHud_Combo2:Hide();
		MetaHud_Combo3:Hide();
		MetaHud_Combo4:Hide();
		MetaHud_Combo5:Hide();
	elseif points == 1 then
		MetaHud_Combo1:Show();
		MetaHud_Combo2:Hide();
		MetaHud_Combo3:Hide();
		MetaHud_Combo4:Hide();
		MetaHud_Combo5:Hide();       
	elseif points == 2 then
		MetaHud_Combo1:Show();
		MetaHud_Combo2:Show();
		MetaHud_Combo3:Hide();
		MetaHud_Combo4:Hide();
		MetaHud_Combo5:Hide();        
	elseif points == 3 then
		MetaHud_Combo1:Show();
		MetaHud_Combo2:Show();
		MetaHud_Combo3:Show();
		MetaHud_Combo4:Hide();
		MetaHud_Combo5:Hide();        
	elseif points == 4 then
		MetaHud_Combo1:Show();
		MetaHud_Combo2:Show();
		MetaHud_Combo3:Show();
		MetaHud_Combo4:Show();
		MetaHud_Combo5:Hide();        
	elseif points == 5 then
		MetaHud_Combo1:Show();
		MetaHud_Combo2:Show();
		MetaHud_Combo3:Show();
		MetaHud_Combo4:Show();
		MetaHud_Combo5:Show();       
	end
end

--- update target Auras
function MetaHud:Auras()
	local i, icon, buff, debuff, debuffborder, debuffcount;
	local buffframe, debuffframe;
	if MetaHudOptions["swaptargetauras"] == 0 then
		buffframe   = "MetaHud_Buff";
		debuffframe = "MetaHud_DeBuff";
	else
		debuffframe = "MetaHud_Buff";
		buffframe   = "MetaHud_DeBuff";    
	end

    ---  Buffs / Debuffs
	for i = 1, 16 do
		---  Buffs
		_,_, buff = UnitBuff("target", i);
		if(buff == nil) then
			buff = UnitBuff("target", i);
		end
		button = getglobal(buffframe..i);
		button.hasdebuff = nil;
		button.unit = "target";
		button.id = i;
		if MetaHudOptions["shownpc"] == 0 and self:TargetIsNPC() then
			button:Hide();
		elseif buff and MetaHudOptions["showauras"] == 1 and MetaHudOptions["showtarget"] == 1 then
			icon = getglobal(button:GetName());
			icon:SetNormalTexture(buff);
			button:Show();
			debuffborder = getglobal(button:GetName().."_Border");
			debuffborder:Hide();
		else
			button:Hide();
		end
	end
        
    ---  DeBuffs
	for i = 1, 16 do
		_,_,debuff, debuffC = UnitDebuff("target", i);
		if(debuff == nil or debuffC == nil) then
			debuff, debuffC = UnitDebuff("target", i);
		end
		button = getglobal(debuffframe..i);
		button.hasdebuff = 1;
		button.unit = "target";
		button.id = i;
		if MetaHudOptions["shownpc"] == 0 and self:TargetIsNPC() then
			button:Hide();
		elseif debuff and MetaHudOptions["showauras"] == 1 and MetaHudOptions["showtarget"] == 1 then
			icon = getglobal(button:GetName());
			icon:SetNormalTexture(debuff);
			debuffborder = getglobal(button:GetName().."_Border");
			debuffcount  = getglobal(button:GetName().."_Text");
			debuffborder:Show();
			if (debuffC <= 0) then
				debuffcount:SetText("");
			elseif debuffC > 1 then
				debuffcount:SetText(debuffC);
			else
				debuffcount:SetText("");
			end
			button:Show();
		else
			button:Hide();
		end
	end
end

--- is unit npc?
function MetaHud:TargetIsNPC()
	if UnitExists("target") and not UnitIsPlayer("target") and not UnitCanAttack("player", "target") and not UnitPlayerControlled("target") then
		return true;
	else
		return false;
	end
end

--- is unit pet?
function MetaHud:TargetIsPet()
	if not UnitIsPlayer("target") and not UnitCanAttack("player", "target") and UnitPlayerControlled("target") then
		return true;
	else
		return false;
	end
end

--- Update Values
function MetaHud:UpdateValues(frame,set)
	local value;
	local bar  = self.text2bar[frame];
	local unit = self.name2unit[bar];
	local typ  = self.name2typ[bar];
	local ref  = getglobal(frame.. "_Text");    
	self.PetneedMana   = nil;
	self.PetneedHealth = nil;

	if typ == "health" then
		value = tonumber(UnitHealth(unit)/UnitHealthMax(unit));
	else
		value = tonumber(UnitMana(unit)/UnitManaMax(unit));
	end  
	if unit == "pet" and MetaHudOptions["showpet"] == 0 then
		value = 0;
	end
	if unit == "target" and MetaHudOptions["showtarget"] == 0 then
		value = 0;
	end
	if unit == "targettarget" and not UnitExists("targettarget") then
		value = 0;
	end
        
	---  Druidbar support
	if unit == "pet" and typ == "mana" and DruidBarKey and self.player_class == "DRUID" then
		if UnitPowerType("player") ~= 0 then
			value = tonumber( DruidBarKey.keepthemana / DruidBarKey.maxmana );
			if math.floor(value * 100) == 100 then
				self.PetneedMana = nil;
			else
				self.PetneedMana = 1;
			end
		else
			value = 0;
			set   = 1;
		end
	end
	self.bar_values[bar] = value;

	if typ == "health" and unit == "player" then
		if math.floor(value * 100) == 100 then
			self.needHealth = nil;
		else
			self.needHealth = true;
		end
	elseif typ == "mana" and unit == "player" then
		local type = self.powertypes[ UnitPowerType(unit)+1 ];
		if type == "rage" then
			if math.floor(value * 100) == 100 then
				self.needMana = true;
			else
				self.needMana = nil;
			end
		else
			if math.floor(value * 100) == 100 then
				self.needMana = nil;
			else
				self.needMana = true;
			end
		end
	elseif typ == "mana" and unit == "pet" and self.player_class ~= "DRUID" and MetaHudOptions["showpet"] == 1 and UnitExists(unit) then    
		if math.floor(value * 100) == 100 then
			self.PetneedMana = nil;
		else
			self.PetneedMana = true;
		end
	elseif typ == "health" and unit == "pet" and MetaHudOptions["showpet"] == 1 and UnitExists(unit) then
		if math.floor(value * 100) == 100 then
			self.PetneedHealth = nil;
		else
			self.PetneedHealth = true;
		end 
	end
    
	if MetaHudOptions["animatebars"] == 0 or set then
		self.bar_anim[bar] = value;
		self:SetBarHeight(bar,value); 
		self:SetBarColor(bar,value);
	end       
end

--- animate bars
function MetaHud:Animate(bar)
	local ph  = math.floor(self.bar_values[bar] * 100);
	local pha = math.floor(self.bar_anim[bar] * 100);
	if ph < pha then
		self.bar_change[bar] = 1;
		if pha - ph > 10 then
			self.bar_anim[bar] = self.bar_anim[bar] - self.stepfast;
		else
			self.bar_anim[bar] = self.bar_anim[bar] - self.step;
		end   
	elseif ph > pha then
		self.bar_change[bar] = 1;
		if ph - pha > 10 then
			self.bar_anim[bar] = self.bar_anim[bar] + self.stepfast;
		else
			self.bar_anim[bar] = self.bar_anim[bar] + self.step;
		end
	end
	---  Anim 
	if self.bar_change[bar] then
		self:SetBarHeight(bar, self.bar_anim[bar] );
		self:SetBarColor(bar, self.bar_anim[bar] );
		self.bar_change[bar] = nil;
	end
end

--- update Background Texture
function MetaHud:ChangeBackgroundTexture()
	if(MetaHudOptions["barborders"] == 1) then
		if(UnitExists("target") and MetaHudOptions["showtarget"] == 1) then 
			if(self:TargetIsNPC() and MetaHudOptions["shownpc"] == 0) then
				self.has_target_health = nil;
				self.has_target_mana   = nil;
			else
				if(UnitHealthMax("target")) then 
					self.has_target_health = 1;
				else
					self.has_target_health = nil;
				end
				if(UnitManaMax("target") > 0) then 
					self.has_target_mana = 1;
				else
					self.has_target_mana = nil;
				end       
			end
		else
			self.has_target_health = nil;
			self.has_target_mana   = nil;
		end
		---  check pet
		self.has_pet_health = nil;
		self.has_pet_mana   = nil;
		if(MetaHudOptions["showpet"] == 1) then
			if(UnitName("pet")) then 
				if(UnitHealthMax("pet")) then 
					self.has_pet_health = 1;
				end
				if(UnitManaMax("pet") > 0) then 
					self.has_pet_mana = 1;
				end              
			end
		end
		---  check druidbar
		if(DruidBarKey and self.player_class == "DRUID") then
			if(UnitPowerType("player") ~= 0) then
				self.has_pet_mana = 1;
			else
				self.has_pet_mana = nil;
			end
		end

		local what = "ph_pm";
		if(self.has_pet_health)    then what = what.."_eh"; end
		if(self.has_pet_mana)      then what = what.."_em"; end
		if(self.has_target_health) then what = what.."_th"; end
		if(self.has_target_mana)   then what = what.."_tm"; end

		local texture,x0,x1,y0,y1;
		if(type(self.C_textures["l_"..what]) == "table") then
			texture,x0,x1,y0,y1 = unpack( self.C_textures["l_"..what] );
			getglobal("MetaHud_LeftFrame_Texture"):SetTexture(texture);
			getglobal("MetaHud_LeftFrame_Texture"):SetTexCoord(x0,x1,y0,y1);
		end
		if(type(self.C_textures["l_"..what]) == "table") then
			texture,x0,x1,y0,y1 = unpack( self.C_textures["r_"..what] );
			getglobal("MetaHud_RightFrame_Texture"):SetTexture(texture);
			getglobal("MetaHud_RightFrame_Texture"):SetTexCoord(x0,x1,y0,y1);
		end        
	end

	if(UnitIsDeadOrGhost("player") and self.Target == nil and not UnitExists("target")) then
		getglobal("MetaHud_PlayerHealth_Text"):Hide();
		getglobal("MetaHud_PlayerMana_Text"):Hide();
		getglobal("MetaHud_PetHealth_Text"):Hide();
		getglobal("MetaHud_PetMana_Text"):Hide();
		getglobal("MetaHud_RightFrame_Texture"):Hide();
		getglobal("MetaHud_LeftFrame_Texture"):Hide();
	else
		getglobal("MetaHud_PlayerHealth_Text"):Show();
		getglobal("MetaHud_PlayerMana_Text"):Show();
		getglobal("MetaHud_PetHealth_Text"):Show();
		getglobal("MetaHud_PetMana_Text"):Show();
		if(MetaHudOptions["barborders"] == 1) then
			getglobal("MetaHud_RightFrame_Texture"):Show();
			getglobal("MetaHud_LeftFrame_Texture"):Show();
		else
			getglobal("MetaHud_RightFrame_Texture"):Hide();
			getglobal("MetaHud_LeftFrame_Texture"):Hide();        
		end
	end  
  ---  show elite icon?
	if self:CheckElite("target") and MetaHudOptions["shownpc"] == 1 and MetaHudOptions["showtarget"] == 1 and MetaHudOptions["showeliteicon"] == 1 then
		local elite = self:CheckElite("target");
		local tex;
		if(elite == "++" or elite == "+" or elite == "Elite" or elite == "Boss") then
			tex = "MetaHud_TargetElite";
		elseif(elite == "r" or elite == "r+" or elite == "Rare" or elite == "RareElite") then
			tex = "MetaHud_TargetRare";
		end
		local texture,x0,x1,y0,y1 = unpack( self.C_textures[tex] );
		getglobal("MetaHud_TargetElite_Texture"):SetTexture(texture);
		getglobal("MetaHud_TargetElite_Texture"):SetTexCoord(x0,x1,y0,y1);
		getglobal("MetaHud_TargetElite"):Show();
	else
		getglobal("MetaHud_TargetElite"):Hide();
	end
	self:updatePlayerPvP();
end

--- update Alpha
function MetaHud:updateAlpha()
	---  Combat Mode
	if self.inCombat then
		self:setAlpha("combatalpha");
	---  target selected    	    
	elseif self.Target then
		self:setAlpha("selectalpha");
	---  Player / Pet reg
	elseif self.needHealth or self.needMana or self.PetneedHealth or self.PetneedMana then
		self:setAlpha("regenalpha");
	---  Casting
	elseif self.Casting then
		self:setAlpha("regenalpha");	 
	---  standard mode     	    		       
	else
		self:setAlpha("oocalpha");
	end
end
                
--- set alpha (combatalpha oocalpha selectalpha regenalpha)
function MetaHud:setAlpha(mode)
	self:printd("Alphamode: "..mode);
	for k, v in pairs(self.alpha_textures) do
		local texture = getglobal(v);
		texture:SetAlpha(MetaHudOptions[mode]);
	end
	for k, v in pairs(self.alpha2_textures) do
		local texture = getglobal(v);
		if(MetaHudOptions.textalpha == 0) then
			texture:SetAlpha(MetaHudOptions[mode]);
		else
			texture:SetAlpha(1);
		end
	end
	if(IsAddOnLoaded("EnergyWatch_v2") and MetaHudOptions["ewcontrol"] == 1) then
		EnergyWatchFrameStatusBar:SetAlpha(MetaHudOptions[mode]);
		if(MetaHudOptions.textalpha == 0) then
			EnergyWatchText:SetAlpha(MetaHudOptions[mode]);
		else
			EnergyWatchText:SetAlpha(1);
		end
	end
	self.CastingAlpha = MetaHudOptions[mode];
	---  hide player text when alpha = 0 
	if MetaHudOptions[mode] == 0 then
		getglobal("MetaHud_PlayerHealth_Text"):Hide();
		getglobal("MetaHud_PlayerMana_Text"):Hide();
		getglobal("MetaHud_PetHealth_Text"):Hide();
		getglobal("MetaHud_PetMana_Text"):Hide();
	elseif not UnitIsDeadOrGhost("player") then
		getglobal("MetaHud_PlayerHealth_Text"):Show();
		getglobal("MetaHud_PlayerMana_Text"):Show();  
		getglobal("MetaHud_PetHealth_Text"):Show();
		getglobal("MetaHud_PetMana_Text"):Show(); 
	end 
end

--- resting status
function MetaHud:updateStatus()
	if(IsResting() and MetaHudOptions["showresticon"] == 1 and not UnitIsDeadOrGhost("player")) then
		getglobal("MetaHud_PlayerResting"):Show();
		getglobal("MetaHud_PlayerAttacking"):Hide();
	elseif(self.inCombat and MetaHudOptions["showresticon"] == 1 and not UnitIsDeadOrGhost("player")) then
		getglobal("MetaHud_PlayerAttacking"):Show();
		getglobal("MetaHud_PlayerResting"):Hide();
	else
		getglobal("MetaHud_PlayerResting"):Hide();
		getglobal("MetaHud_PlayerAttacking"):Hide();
	end
end

--- party/raid status
function MetaHud:updateParty()
	if(GetNumPartyMembers() > 0 or GetNumRaidMembers() > 0) then
		local lootMethod, lootMaster = GetLootMethod();
		if(IsPartyLeader() and self.inParty == 1) then
			MetaHud_PlayerLeader:Show();
		else
			MetaHud_PlayerLeader:Hide();
		end
		if(lootMaster == 0 and self.inParty == 1) then
			MetaHud_PlayerLooter:Show();
		else
			MetaHud_PlayerLooter:Hide();
		end
		self.inParty = 1;
	else
		MetaHud_PlayerLeader:Hide();
		MetaHud_PlayerLooter:Hide();
		MetaHud_TargetIcon:Hide();
		self.inParty = nil;
	end
	self:updateTargetIcon();
end

--- target icon
function MetaHud:updateTargetIcon()
	MetaHud_TargetIcon:Hide();
	if(self.inParty == 1 and MetaHudOptions["showtargeticon"] == 1) then
		local index = GetRaidTargetIndex("target");
		if(index ~= nil and UnitExists("target")) then
			SetRaidTargetIconTexture(MetaHud_TargetIcon_Texture, index);
			MetaHud_TargetIcon:Show();
		end
	end
end

--- pvp status
function MetaHud:updatePlayerPvP()    
	local tex = getglobal("MetaHud_PlayerPvP_Texture");
	local texture = nil;
	if MetaHudOptions["showplayerpvpicon"] == 1 and not UnitIsDeadOrGhost("player") then
		if UnitIsPVPFreeForAll("player")  then
			texture,x0,x1,y0,y1 = unpack( self.C_textures["MetaHud_FreePvP"] );
		elseif UnitIsPVP("player") then
			local faction = UnitFactionGroup("player");
			if faction == "Horde" then
				texture,x0,x1,y0,y1 = unpack( self.C_textures["MetaHud_TargetPvP"] );
			else
				texture,x0,x1,y0,y1 = unpack( self.C_textures["MetaHud_PlayerPvP"] );
			end
		end
		if texture then
			tex:SetTexture(texture);
			tex:SetTexCoord(x0,x1,y0,y1);
			getglobal("MetaHud_PlayerPvP"):Show();
		else
			getglobal("MetaHud_PlayerPvP"):Hide();
		end
	else
		getglobal("MetaHud_PlayerPvP"):Hide();
	end
end

--- pvp icon target
function MetaHud:updateTargetPvP()    
    local tex = getglobal("MetaHud_TargetPvP_Texture");
    local texture = nil;
    local x0,x1,y0,y1;
    if MetaHudOptions["showtargetpvpicon"] == 1 and not self:TargetIsNPC() and MetaHudOptions["showtarget"] == 1 then
        if UnitIsPVPFreeForAll("target")  then
            texture,x0,x1,y0,y1 = unpack( self.C_textures["MetaHud_FreePvP"] );
        elseif UnitIsPVP("target") then
            local faction = UnitFactionGroup("target");
            if faction == "Horde" then
                texture,x0,x1,y0,y1 = unpack( self.C_textures["MetaHud_TargetPvP"] );
            else
                texture,x0,x1,y0,y1 = unpack( self.C_textures["MetaHud_PlayerPvP"] );
            end
        end
        if texture then
            tex:SetTexture(texture);
            tex:SetTexCoord(x0,x1,y0,y1);
            getglobal("MetaHud_TargetPvP"):Show();
        else
            getglobal("MetaHud_TargetPvP"):Hide();
        end
    else
        getglobal("MetaHud_TargetPvP"):Hide();
    end
end

--- pet icon
function MetaHud:updatePetIcon()
    if self.has_pet_health ~= nil and MetaHudOptions["showpeticon"] == 1 then
        local texture = nil;
        local x0,x1,y0,y1;
        local happiness, _, _ = GetPetHappiness();
        
        if happiness == 1 then
            texture,x0,x1,y0,y1 = unpack( self.C_textures["MetaHud_PetUnhappy"] );
        elseif happiness == 2 then
            texture,x0,x1,y0,y1 = unpack( self.C_textures["MetaHud_PetNormal"] );
        elseif happiness == 3 then
            texture,x0,x1,y0,y1 = unpack( self.C_textures["MetaHud_PetHappy"] );
        end
        
        if texture then
            local tex = getglobal("MetaHud_PetHappy_Texture");
            tex:SetTexture(texture);
            tex:SetTexCoord(x0,x1,y0,y1);	
            getglobal("MetaHud_PetHappy"):Show();
        else
            getglobal("MetaHud_PetHappy"):Hide();
        end
    else
        getglobal("MetaHud_PetHappy"):Hide();
    end
end

--- Toggle Options
function MetaHud:OptionsFrame_Toggle()
	if(not IsAddOnLoaded("MetaHudOPT")) then
		LoadAddOn("MetaHudOPT");
	end
	if(IsAddOnLoaded("MetaHudOPT")) then
		if(MetaHudOptionsFrame:IsVisible()) then
			MetaHudOptionsFrame:Hide();
		else
			MetaHudOptionsFrame:Show();
		end
	else
	end
end

--- target dropdown
function MetaHud_Target_DropDown_Initialize()
	local menu = nil;
	if(SpellIsTargeting()) then
		SpellTargetUnit("target");
	elseif(CursorHasItem()) then
		DropItemOnUnit("target");
	elseif(UnitIsEnemy("target", "player")) then
		if(UnitInParty("player")) then
			menu = "RAID_TARGET_ICON";
		end
	elseif(UnitIsUnit("target", "player")) then
		menu = "SELF";
	elseif(UnitIsUnit("target", "pet")) then
		menu = "PET";
	elseif (UnitIsPlayer("target")) then
		if(UnitInParty("target")) then
			menu = "PARTY";
		else
			menu = "PLAYER";
		end
	end
	if menu then
		UnitPopup_ShowMenu( MetaHud_Target_DropDown, menu, "target" );
	end
end

--- player dropdown
function MetaHud_Player_DropDown_Initialize()
    UnitPopup_ShowMenu( MetaHud_Player_DropDown, "SELF", "player" );
end

function MetaHud_QuickMenu_DropDown_Initialize()
	for index, menuitem in pairs(MetaHud.QuickMenu) do
		local check = nil;
		if(MetaHudOptions[menuitem[2]] == 1) then
			check = 1;
		end
		local menu = {
			checked = check,
			text = menuitem[1],
			value = menuitem[2],
			func = MetaHud_QuickMenu_OnClick,
		};
		UIDropDownMenu_AddButton(menu);
	end
end

function MetaHud_QuickMenu_OnClick()
	if(this.value == "options") then
		MetaHud:OptionsFrame_Toggle();
	else
		MetaHud:ToggleConfig(this.value);
	end
end

--- print Debug --
function MetaHud:printd(msg)
	if DEFAULT_CHAT_FRAME and self.debug then
		DEFAULT_CHAT_FRAME:AddMessage("MetaHud Debug: "..(msg or "null"), 1,0.5,0.5);
	end
end

--- print Message --
function MetaHud:print(msg)
	if DEFAULT_CHAT_FRAME then
		DEFAULT_CHAT_FRAME:AddMessage("|cff88ff88<MetaHud>:|r "..(msg or "null"), 1,1,1);
	end
end

--- setdefault Config
function MetaHud:SetDefaultConfig(key)
	if (not MetaHudOptions[key]) then
		if type(self.Config_default[key]) ~= "table" then
			MetaHudOptions[key] = self.Config_default[key];
		else
			MetaHudOptions[key] = MetaHud_tablecopy(self.Config_default[key]);
		end
	end  
end

--- SlashCommand Handler
function MetaHud:SCommandHandler(msg)
	local b,e,command = string.find(msg, "^%s*([^%s]+)%s*(.*)$");
	if(command) then
		if(strlower(command) == "menu") then
			self:OptionsFrame_Toggle();
		elseif(strlower(command) == "hud") then
			TargetUnit("player");
		elseif(strlower(command) == "square" or strlower(command) == "circle") then
			MetaHudOptions.mmb.drag = strupper(command);
		end
	else
		self:print("Commands:\n '/MetaHud Menu' for options\n '/MetaHud Hud' to display HUD\n '/MetaHud square' to set MinimapButton for square outline\n '/MetaHud circle' to set MinimapButton for round outline");
	end
end

--- set config value
function MetaHud:SetConfig(key, value)
	if (MetaHudOptions[key] ~= value) then
		MetaHudOptions[key] = value;
	end
end

--- get config value
function MetaHud:GetConfig(key)
	return MetaHudOptions[key] or nil;
end

--- toggle config value
function MetaHud:ToggleConfig(key)
	local output   = "/MetaHud %s";
	local response = "|cff6666cc%s|r is now %s";
	if MetaHudOptions[key] == nil then
		MetaHudOptions[key] = 0;
	end
	if MetaHudOptions[key] == 1 then
		MetaHudOptions[key] = 0;
		self:print(string.format(
			response,
			key,
			"|cffff0000OFF|r"
		));                                                   
	else
		MetaHudOptions[key] = 1;
		self:print(string.format(
			response,
			key,
			"|cff00ff00ON|r"
		));  
	end
	self:init();
end

--- is target elite?
function MetaHud:CheckElite(unit, mode)
	local el = UnitClassification(unit);
	local ret;
	if(el == "worldboss") then
		if(mode == nil) then ret = "++"; else ret = " Boss"; end
	elseif(el == "rareelite") then
		if(mode == nil) then ret = "r+"; else ret = " RareElite"; end
	elseif(el == "elite") then
		if(mode == nil) then ret = "+"; else ret = " Elite"; end
	elseif(el == "rare") then
		if(mode == nil) then ret = "r"; else ret = " Rare"; end
	else
		ret = nil;
	end
	return ret;
end

--- unit reaction
function MetaHud:GetReactionColor(unit)
	local i;
	if (UnitIsPlayer(unit)) then
		if (UnitIsPVP(unit)) then
			if (UnitCanAttack("player", unit)) then
				i = 1;
			else
				i = 5;
			end
		else
			if (UnitCanAttack("player", unit) or UnitFactionGroup(unit) ~= UnitFactionGroup("player")) then
				i = 2;
			else
				i = 4;
			end
		end
	elseif (UnitIsTapped(unit) and (not UnitIsTappedByPlayer(unit))) then
		i = 6;
	else
		local reaction = UnitReaction(unit, "player");
		if (reaction) then
			if (reaction < 4) then
				i = 1;
			elseif (reaction == 4) then
				i = 2;
			else
				i = 3;
			end
		end
	end
	return self.ReacColors[i];
end

function MetaHud:FormatTime(time)
	if(time > 60 or self.TimerSet) then
		local minutes = math.floor((time / 60));
		local seconds = math.ceil(time - (60 * minutes));
		if (seconds == 60) then
			minutes = minutes + 1;
			seconds = 0;
		end
		if(strlen(seconds) < 2) then
			seconds =  "0"..seconds;
		end
		self.TimerSet = 1;
		return format("%s:%s", minutes, seconds);
	else
		return string.format( "%.1f", time);
	end
end

--- set color
function MetaHud:SetColor(key, value)
	local output   = "/MetaHud |cff6666cc%s|r 000000 - FFFFFF";
	local response = "|cff6666cc%s|r set to: |cff%s%s|r";
	if (MetaHudOptions[key] ~= value) then
		MetaHudOptions[key] = value;
			self:print( string.format(
			response, key, value , value
		) ); 
	end
end

MetaHud_HexTable = {
	["0"] = 0,
	["1"] = 1,
	["2"] = 2,
	["3"] = 3,
	["4"] = 4,
	["5"] = 5,
	["6"] = 6,
	["7"] = 7,
	["8"] = 8,
	["9"] = 9,
	["a"] = 10,
	["b"] = 11,
	["c"] = 12,
	["d"] = 13,
	["e"] = 14,
	["f"] = 15
}

--- hexcolor to rgb 
function MetaHud_hextodec(hex)
	local r1 = tonumber(MetaHud_HexTable[ string.lower(string.sub(hex,1,1)) ] * 16);
	local r2 = tonumber(MetaHud_HexTable[ string.lower(string.sub(hex,2,2)) ]);
	local r  = (r1 + r2) / 255;
	local g1 = tonumber(MetaHud_HexTable[ string.lower(string.sub(hex,3,3)) ] * 16);
	local g2 = tonumber(MetaHud_HexTable[ string.lower(string.sub(hex,4,4)) ]);
	local g  = (g1 + g2) / 255;
	local b1 = tonumber(MetaHud_HexTable[ string.lower(string.sub(hex,5,5)) ] * 16);
	local b2 = tonumber(MetaHud_HexTable[ string.lower(string.sub(hex,6,6)) ]);
	local b  = (b1 + b2) / 255;
	return {r,g,b}
end

--- decimal to hex
function MetaHud_DecToHex(red,green,blue)
	if ( not red or not green or not blue ) then
		return "ffffff"
	end
	red = floor(red * 255)
	green = floor(green * 255)
	blue = floor(blue * 255)
	local a,b,c,d,e,f
	a = MetaHud_GiveHex(floor(red / 16))
	b = MetaHud_GiveHex(mod(red,16))
	c = MetaHud_GiveHex(floor(green / 16))
	d = MetaHud_GiveHex(mod(green,16))
	e = MetaHud_GiveHex(floor(blue / 16))
	f = MetaHud_GiveHex(mod(blue,16))
	return a..b..c..d..e..f
end

--- safe gsub
function MetaHud:gsub(text, var, value)
	if (value) then
		text = string.gsub(text, var, value);
	else
		text = string.gsub(text, var, "");
	end
	return text;
end

function MetaHud_GiveHex(dec)
	for key, value in pairs(MetaHud_HexTable) do
		if ( dec == value ) then
			return key
		end
	end
	return ""..dec
end

--- table copy
function MetaHud_tablecopy(tbl)
	if type(tbl) ~= "table" then return tbl end
	local t = {}
	for i,v in pairs(tbl) do
		t[i] = MetaHud_tablecopy(v)
	end
	return setmetatable(t, MetaHud_tablecopy(getmetatable(tbl)))
end

--- MyAddonsSupport
function MetaHud:myAddons()
	if (myAddOnsFrame_Register) then
		local MetaHud_mya = {
			["name"]         = "MetaHud",
			["version"]      = self.Config_default["version"],
			["author"]       = "Drathal/Silberklinge (Markus Inger)",
			["category"]     = MYADDONS_CATEGORY_COMBAT,
			["email"]        = "MetaHud@markus-inger.de",
			["website"]      = "http://www.markus-inger.de",
			["optionsframe"] = "MetaHudOptionsFrame",
		};
		myAddOnsFrame_Register(MetaHud_mya);
	end
end

--- FuBar Support
function MetaHud:FuBar()
	if(TabletLib == nil) then
		self:FuBar2();
		return;
	end
	local tablet = TabletLib:GetInstance('1.0')
	
	MetaHudFu 		= FuBarPlugin:GetInstance("1.2"):new({
	name          = METAHUD_NAME,
	version       = METAHUD_VERSION,
	aceCompatible = 103,
	category      = "combat",
	hasIcon 			= METAHUD_ICON,
	})

	function MetaHudFu:OnClick()
		if(IsControlKeyDown()) then
			MetaHud:OptionsFrame_Toggle();
		else
			TargetUnit("player");
		end
	end

	function MetaHudFu:UpdateTooltip()
		cat = tablet:AddCategory(
			"text", " ",
			"columns", 2,
			"child_textR", 0,
			"child_textG", 1,
			"child_textB", 0,
			"child_text2R", r,
			"child_text2G", g,
			"child_text2B", b
		)
		cat:AddLine("text", "LeftClick:", "text2", "Display HUD")
		cat:AddLine("text", "CtrlClick:", "text2", "MetaHud Options")
		cat:AddLine("text", "RightClick:", "text2", "FuBar Options")
	end
	MetaHudFu:RegisterForLoad();
end

function MetaHud:FuBar2()
	local tablet = AceLibrary("Tablet-2.0")
	MetaHudFu = AceLibrary("AceAddon-2.0"):new("FuBarPlugin-2.0")
	MetaHudFu.hasIcon = METAHUD_ICON
	MetaHudFu.name = METAHUD_NAME
	MetaHudFu.version = METAHUD_VERSION
	MetaHudFu.category = "Interface Enhancements"
	MetaHudFu.hasNoText = true

	function MetaHudFu:OnClick()
		if(IsControlKeyDown()) then
			MetaHud:OptionsFrame_Toggle();
		else
			TargetUnit("player");
		end
	end

	function MetaHudFu:OnTooltipUpdate()
		cat = tablet:AddCategory(
			"text", " ",
			"columns", 2,
			"child_textR", 0,
			"child_textG", 1,
			"child_textB", 0,
			"child_text2R", r,
			"child_text2G", g,
			"child_text2B", b
		)
		cat:AddLine("text", "LeftClick:", "text2", "Display HUD")
		cat:AddLine("text", "CtrlClick:", "text2", "MetaHud Options")
		cat:AddLine("text", "RightClick:", "text2", "FuBar Options")
	end
end

--- MobInfo2 support
function MetaHud:Show_MobInfo()
	if(IsAddOnLoaded("MobInfo2")) then
		if(UnitName("target") == nil) then return; end
		GameTooltip:SetOwner(this, "ANCHOR_BOTTOMRIGHT");
		MI2_BuildMobInfoTooltip(UnitName("target"), UnitLevel("target"), true);
		GameTooltip:Show();
	end
end

--- telos mobhealth support
function MetaHud_MobHealth_PPP(index)
	if( index and MobHealthDB[index] ) then
		local s, e;
		local pts;
		local pct;
		s, e, pts, pct = string.find(MobHealthDB[index], "^(%d+)/(%d+)$");
		if( pts and pct ) then
			pts = pts + 0;
			pct = pct + 0;
			if( pct ~= 0 ) then
				return pts / pct;
			end
		end
	end
	return 0;
end

function MetaHud:SetLayoutElements()
	if not MetaHud_Layouts then MetaHud_Layouts = {} end;
	MetaHud_Layouts.MetaHud_Base_Layout = { 
		["MetaHud_textures_clip"] = {
			[METAHUD_LAYOUTPATH.."cb"]   = { 256, 11  , 11 }, 	
			[METAHUD_LAYOUTPATH.."cbh"]  = { 256, 11  , 11 },
		},
		["MetaHud_names"] = { 
			"MetaHud_Main", 
			"MetaHud_LeftFrame",
			"MetaHud_RightFrame",
			"MetaHud_PlayerHealth_Bar",
			"MetaHud_PlayerMana_Bar",
			"MetaHud_TargetHealth_Bar",
			"MetaHud_TargetMana_Bar",
			"MetaHud_PetHealth_Bar",
			"MetaHud_PetMana_Bar",
			"MetaHud_Combo1",
			"MetaHud_Combo2",
			"MetaHud_Combo3",
			"MetaHud_Combo4",
			"MetaHud_Combo5",
			"MetaHud_Target_Text",
			"MetaHud_ToTarget_Text",
			"MetaHud_Range_Text",
			"MetaHud_Guild_Text",
			"MetaHud_PlayerHealth_Text",
			"MetaHud_PlayerMana_Text",
			"MetaHud_TargetHealth_Text",
			"MetaHud_TargetMana_Text",
			"MetaHud_PetHealth_Text",
			"MetaHud_PetMana_Text",
			"MetaHud_Casttime_Text",
			"MetaHud_Castdelay_Text",
			"MetaHud_Buff1",
			"MetaHud_Buff2",
			"MetaHud_Buff3",
			"MetaHud_Buff4",
			"MetaHud_Buff5",
			"MetaHud_Buff6",
			"MetaHud_Buff7",
			"MetaHud_Buff8",
			"MetaHud_Buff9",
			"MetaHud_Buff10",
			"MetaHud_Buff11",
			"MetaHud_Buff12",
			"MetaHud_Buff13",
			"MetaHud_Buff14",
			"MetaHud_Buff15",
			"MetaHud_Buff16",
			"MetaHud_DeBuff1",
			"MetaHud_DeBuff2",
			"MetaHud_DeBuff3",
			"MetaHud_DeBuff4",
			"MetaHud_DeBuff5",
			"MetaHud_DeBuff6",
			"MetaHud_DeBuff7",
			"MetaHud_DeBuff8",
			"MetaHud_DeBuff9",
			"MetaHud_DeBuff10",
			"MetaHud_DeBuff11",
			"MetaHud_DeBuff12",
			"MetaHud_DeBuff13",
			"MetaHud_DeBuff14",
			"MetaHud_DeBuff15",
			"MetaHud_DeBuff16",  
			"MetaHud_Casting_Bar",
			"MetaHud_Flash_Bar",
			"MetaHud_PlayerResting",
			"MetaHud_PlayerAttacking",
			"MetaHud_PlayerLeader",
			"MetaHud_PlayerLooter",
			"MetaHud_PlayerPvP",
			"MetaHud_TargetIcon",
			"MetaHud_PetHappy",
			"MetaHud_TargetPvP",
			"MetaHud_TargetElite",
			"MetaHud_TargetRare",
		},
		["MetaHud_textures"] = {
			["MetaHud_LeftFrame"]        = { METAHUD_LAYOUTPATH.."bg_21p"  , 0 , 1 , 0 , 1 },
			["MetaHud_RightFrame"]       = { METAHUD_LAYOUTPATH.."bg_21p"  , 1 , 0 , 0 , 1 },
			["MetaHud_Combo1"]           = { METAHUD_LAYOUTPATH.."c1"      , 0 , 1 , 0 , 1 },
			["MetaHud_Combo2"]           = { METAHUD_LAYOUTPATH.."c2"      , 0 , 1 , 0 , 1 },
			["MetaHud_Combo3"]           = { METAHUD_LAYOUTPATH.."c3"      , 0 , 1 , 0 , 1 },
			["MetaHud_Combo4"]           = { METAHUD_LAYOUTPATH.."c4"      , 0 , 1 , 0 , 1 },
			["MetaHud_Combo5"]           = { METAHUD_LAYOUTPATH.."c5"      , 0 , 1 , 0 , 1 },
			["MetaHud_PlayerResting"]    = { "Interface\\CharacterFrame\\UI-StateIcon"         , 0.0625 , 0.4475 , 0.0625 , 0.4375  },
			["MetaHud_PlayerAttacking"]  = { "Interface\\CharacterFrame\\UI-StateIcon"         , 0.5625 , 0.9375 , 0.0625 , 0.4375  },
			["MetaHud_PlayerLeader"]     = { "Interface\\GroupFrame\\UI-Group-LeaderIcon"      , 0      , 1      , 0      , 1       },
			["MetaHud_PlayerLooter"]     = { "Interface\\GroupFrame\\UI-Group-MasterLooter"    , 0      , 1      , 0      , 1       },
			["MetaHud_PetHappy"]         = { "Interface\\PetPaperDollFrame\\UI-PetHappiness"   , 0      , 0.1875 , 0      , 0.359375},
			["MetaHud_PetNormal"]        = { "Interface\\PetPaperDollFrame\\UI-PetHappiness"   , 0.1875 , 0.375  , 0      , 0.359375},
			["MetaHud_PetUnhappy"]       = { "Interface\\PetPaperDollFrame\\UI-PetHappiness"   , 0.375  , 0.5625 , 0      , 0.359375},
			["MetaHud_TargetPvP"]        = { "Interface\\TargetingFrame\\UI-PVP-Horde"         , 0.6    , 0      , 0      , 0.6     },
			["MetaHud_PlayerPvP"]        = { "Interface\\TargetingFrame\\UI-PVP-Alliance"      , 0      , 0.6    , 0      , 0.6     }, 
			["MetaHud_FreePvP"]          = { "Interface\\TargetingFrame\\UI-PVP-FFA"           , 0      , 0.6    , 0      , 0.6     },    
			["MetaHud_TargetIcon"]       = { "Interface\\TargetingFrame\\UI-RaidTargetingIcons", 0      , 1      , 0      , 1       },    
		},
		["MetaHud_frames"] = {
			["MetaHud_Main"]              = { "Frame"   , "CENTER" , "UIParent"             , "CENTER"  , 0   , 0    , 512 , 256},
			["MetaHud_LeftFrame"]         = { "Texture" , "LEFT"   , "MetaHud_Main"         , "LEFT"    , 0   , 0    , 128 , 256},
			["MetaHud_RightFrame"]        = { "Texture" , "RIGHT"  , "MetaHud_Main"         , "RIGHT"   , 0   , 0    , 128 , 256},
			["MetaHud_PlayerHealth_Bar"]  = { "Bar"     , "BOTTOM" , "MetaHud_LeftFrame"    , "BOTTOM"  , 0   , 0    , 128 , 256},
			["MetaHud_TargetMana_Bar"]    = { "Bar"     , "BOTTOM" , "MetaHud_RightFrame"   , "BOTTOM"  , 0   , 0    , 128 , 256},
			["MetaHud_PetHealth_Bar"]     = { "Bar"     , "BOTTOM" , "MetaHud_LeftFrame"    , "BOTTOM"  , 0   , 0    , 128 , 256},
			["MetaHud_Target_Text"]       = { "Text"    , "BOTTOM" , "MetaHud_Main"         , "BOTTOM"  , 0   , -45  , 200 , 14 },
			["MetaHud_ToTarget_Text"]     = { "Text"    , "CENTER" , "MetaHud_Main"         , "CENTER"  , 0   , 0    , 100 , 16 },
			["MetaHud_Range_Text"]        = { "Text"    , "TOP"    , "MetaHud_Main"         , "TOP"     , 0   , 0    , 100 , 16 },
			["MetaHud_Guild_Text"]        = { "Text"    , "BOTTOM" , "MetaHud_Main"         , "BOTTOM"  , 0   , -70  , 100 , 16 },
			["MetaHud_TargetPvP"]         = { "Texture" , "BOTTOM" , "MetaHud_Target_Text"  , "TOP"     , -15 , 5    , 25  , 25 };
			["MetaHud_TargetIcon"]        = { "Texture" , "BOTTOM" , "MetaHud_Target_Text"  , "TOP"     , 15  , 5    , 22  , 22 };
			["MetaHud_Buff1"]             = { "Buff"    , "RIGHT"  , "MetaHud_Target_Text"  , "LEFT"    , -1  , 0    , 20  , 20 },
			["MetaHud_Buff2"]             = { "Buff"    , "RIGHT"  , "MetaHud_Buff1"        , "LEFT"    , -1  , 0    , 20  , 20 },
			["MetaHud_Buff3"]             = { "Buff"    , "RIGHT"  , "MetaHud_Buff2"        , "LEFT"    , -1  , 0    , 20  , 20 },
			["MetaHud_Buff4"]             = { "Buff"    , "RIGHT"  , "MetaHud_Buff3"        , "LEFT"    , -1  , 0    , 20  , 20 },
			["MetaHud_Buff5"]             = { "Buff"    , "RIGHT"  , "MetaHud_Buff4"        , "LEFT"    , -1  , 0    , 20  , 20 },
			["MetaHud_Buff6"]             = { "Buff"    , "RIGHT"  , "MetaHud_Buff5"        , "LEFT"    , -1  , 0    , 20  , 20 },
			["MetaHud_Buff7"]             = { "Buff"    , "RIGHT"  , "MetaHud_Buff6"        , "LEFT"    , -1  , 0    , 20  , 20 },
			["MetaHud_Buff8"]             = { "Buff"    , "RIGHT"  , "MetaHud_Buff7"        , "LEFT"    , -1  , 0    , 20  , 20 },
			["MetaHud_Buff9"]             = { "Buff"    , "RIGHT"  , "MetaHud_Buff1"        , "LEFT"    , 20  , -21  , 20  , 20 },
			["MetaHud_Buff10"]            = { "Buff"    , "RIGHT"  , "MetaHud_Buff9"        , "LEFT"    , -1  , 0    , 20  , 20 },
			["MetaHud_Buff11"]            = { "Buff"    , "RIGHT"  , "MetaHud_Buff10"       , "LEFT"    , -1  , 0    , 20  , 20 },
			["MetaHud_Buff12"]            = { "Buff"    , "RIGHT"  , "MetaHud_Buff11"       , "LEFT"    , -1  , 0    , 20  , 20 },
			["MetaHud_Buff13"]            = { "Buff"    , "RIGHT"  , "MetaHud_Buff12"       , "LEFT"    , -1  , 0    , 20  , 20 },
			["MetaHud_Buff14"]            = { "Buff"    , "RIGHT"  , "MetaHud_Buff13"       , "LEFT"    , -1  , 0    , 20  , 20 },
			["MetaHud_Buff15"]            = { "Buff"    , "RIGHT"  , "MetaHud_Buff14"       , "LEFT"    , -1  , 0    , 20  , 20 },
			["MetaHud_Buff16"]            = { "Buff"    , "RIGHT"  , "MetaHud_Buff15"       , "LEFT"    , -1  , 0    , 20  , 20 },
			["MetaHud_DeBuff1"]           = { "Buff"    , "LEFT"   , "MetaHud_Target_Text"  , "RIGHT"   , 1   , 0    , 20  , 20 },
			["MetaHud_DeBuff2"]           = { "Buff"    , "LEFT"   , "MetaHud_DeBuff1"      , "RIGHT"   , 1   , 0    , 20  , 20 },
			["MetaHud_DeBuff3"]           = { "Buff"    , "LEFT"   , "MetaHud_DeBuff2"      , "RIGHT"   , 1   , 0    , 20  , 20 },
			["MetaHud_DeBuff4"]           = { "Buff"    , "LEFT"   , "MetaHud_DeBuff3"      , "RIGHT"   , 1   , 0    , 20  , 20 },
			["MetaHud_DeBuff5"]           = { "Buff"    , "LEFT"   , "MetaHud_DeBuff4"      , "RIGHT"   , 1   , 0    , 20  , 20 },
			["MetaHud_DeBuff6"]           = { "Buff"    , "LEFT"   , "MetaHud_DeBuff5"      , "RIGHT"   , 1   , 0    , 20  , 20 },
			["MetaHud_DeBuff7"]           = { "Buff"    , "LEFT"   , "MetaHud_DeBuff6"      , "RIGHT"   , 1   , 0    , 20  , 20 },
			["MetaHud_DeBuff8"]           = { "Buff"    , "LEFT"   , "MetaHud_DeBuff7"      , "RIGHT"   , 1   , 0    , 20  , 20 },
			["MetaHud_DeBuff9"]           = { "Buff"    , "LEFT"   , "MetaHud_DeBuff1"      , "RIGHT"   , -20 , -21  , 20  , 20 },
			["MetaHud_DeBuff10"]          = { "Buff"    , "LEFT"   , "MetaHud_DeBuff9"      , "RIGHT"   , 1   , 0    , 20  , 20 },
			["MetaHud_DeBuff11"]          = { "Buff"    , "LEFT"   , "MetaHud_DeBuff10"     , "RIGHT"   , 1   , 0    , 20  , 20 },
			["MetaHud_DeBuff12"]          = { "Buff"    , "LEFT"   , "MetaHud_DeBuff11"     , "RIGHT"   , 1   , 0    , 20  , 20 },
			["MetaHud_DeBuff13"]          = { "Buff"    , "LEFT"   , "MetaHud_DeBuff12"     , "RIGHT"   , 1   , 0    , 20  , 20 },
			["MetaHud_DeBuff14"]          = { "Buff"    , "LEFT"   , "MetaHud_DeBuff13"     , "RIGHT"   , 1   , 0    , 20  , 20 },
			["MetaHud_DeBuff15"]          = { "Buff"    , "LEFT"   , "MetaHud_DeBuff14"     , "RIGHT"   , 1   , 0    , 20  , 20 },
			["MetaHud_DeBuff16"]          = { "Buff"    , "LEFT"   , "MetaHud_DeBuff15"     , "RIGHT"   , 1   , 0    , 20  , 20 },
		}
	}
end

function MetaHud:UpdateLayout(LayoutType)
	local tex = MetaHudOptions.texturefile;
	local cliplayout = MetaHud_Layouts.MetaHud_Base_Layout.MetaHud_textures_clip;
	local texlayout = MetaHud_Layouts.MetaHud_Base_Layout.MetaHud_textures;
	local framelayout = MetaHud_Layouts.MetaHud_Base_Layout.MetaHud_frames;

	cliplayout[METAHUD_LAYOUTPATH.."1"..tex]  = { 256, 11  , 11 };
	cliplayout[METAHUD_LAYOUTPATH.."2"..tex]  = { 256, 5   , 5  };
	cliplayout[METAHUD_LAYOUTPATH.."p1"..tex] = { 256, 128 , 20 };
	cliplayout[METAHUD_LAYOUTPATH.."p2"..tex] = { 256, 128 , 20 };

	if(LayoutType == 1) then
		---  Textures
		texlayout["MetaHud_Casting_Bar"]      = { METAHUD_LAYOUTPATH.."cb"      , 1 , 0 , 0 , 1 };
		texlayout["MetaHud_Flash_Bar"]        = { METAHUD_LAYOUTPATH.."cbh"     , 1 , 0 , 0 , 1 };
		texlayout["MetaHud_PlayerHealth_Bar"] = { METAHUD_LAYOUTPATH.."1"..tex  , 0 , 1 , 0 , 1 };
		texlayout["MetaHud_PlayerMana_Bar"]   = { METAHUD_LAYOUTPATH.."1"..tex  , 1 , 0 , 0 , 1 };
		texlayout["MetaHud_TargetHealth_Bar"] = { METAHUD_LAYOUTPATH.."2"..tex  , 0 , 1 , 0 , 1 };
		texlayout["MetaHud_TargetMana_Bar"]   = { METAHUD_LAYOUTPATH.."2"..tex  , 1 , 0 , 0 , 1 };
		texlayout["MetaHud_PetHealth_Bar"]    = { METAHUD_LAYOUTPATH.."p1"..tex , 0 , 1 , 0 , 1 };
		texlayout["MetaHud_PetMana_Bar"]      = { METAHUD_LAYOUTPATH.."p1"..tex , 1 , 0 , 0 , 1 };
		texlayout["l_ph_pm"]                  = { METAHUD_LAYOUTPATH.."bg_1"    , 0 , 1 , 0 , 1 };
		texlayout["r_ph_pm"]                  = { METAHUD_LAYOUTPATH.."bg_1"    , 1 , 0 , 0 , 1 };
		texlayout["l_ph_pm_em"]               = { METAHUD_LAYOUTPATH.."bg_1"    , 0 , 1 , 0 , 1 };
		texlayout["r_ph_pm_em"]               = { METAHUD_LAYOUTPATH.."bg_1p"   , 1 , 0 , 0 , 1 };
		texlayout["l_ph_pm_eh_em"]            = { METAHUD_LAYOUTPATH.."bg_1p"   , 0 , 1 , 0 , 1 };
		texlayout["r_ph_pm_eh_em"]            = { METAHUD_LAYOUTPATH.."bg_1p"   , 1 , 0 , 0 , 1 };
		texlayout["l_ph_pm_eh"]               = { METAHUD_LAYOUTPATH.."bg_1p"   , 0 , 1 , 0 , 1 };
		texlayout["r_ph_pm_eh"]               = { METAHUD_LAYOUTPATH.."bg_1"    , 1 , 0 , 0 , 1 };
		texlayout["l_ph_pm_th"]               = { METAHUD_LAYOUTPATH.."bg_21"   , 0 , 1 , 0 , 1 };
		texlayout["r_ph_pm_th"]               = { METAHUD_LAYOUTPATH.."bg_1"    , 1 , 0 , 0 , 1 };
		texlayout["l_ph_pm_em_th"]            = { METAHUD_LAYOUTPATH.."bg_21"   , 0 , 1 , 0 , 1 };
		texlayout["r_ph_pm_em_th"]            = { METAHUD_LAYOUTPATH.."bg_1p"   , 1 , 0 , 0 , 1 };
		texlayout["l_ph_pm_eh_th"]            = { METAHUD_LAYOUTPATH.."bg_21"   , 0 , 1 , 0 , 1 };
		texlayout["r_ph_pm_eh_th"]            = { METAHUD_LAYOUTPATH.."bg_1p"   , 1 , 0 , 0 , 1 };
		texlayout["l_ph_pm_th_tm"]            = { METAHUD_LAYOUTPATH.."bg_21"   , 0 , 1 , 0 , 1 };
		texlayout["r_ph_pm_th_tm"]            = { METAHUD_LAYOUTPATH.."bg_21"   , 1 , 0 , 0 , 1 };
		texlayout["l_ph_pm_eh_th"]            = { METAHUD_LAYOUTPATH.."bg_21p"  , 0 , 1 , 0 , 1 };
		texlayout["r_ph_pm_eh_th"]            = { METAHUD_LAYOUTPATH.."bg_1"    , 1 , 0 , 0 , 1 };
		texlayout["l_ph_pm_em_th_tm"]         = { METAHUD_LAYOUTPATH.."bg_21"   , 0 , 1 , 0 , 1 };
		texlayout["r_ph_pm_em_th_tm"]         = { METAHUD_LAYOUTPATH.."bg_21p"  , 1 , 0 , 0 , 1 };
		texlayout["l_ph_pm_eh_em_th"]         = { METAHUD_LAYOUTPATH.."bg_21p"  , 0 , 1 , 0 , 1 };
		texlayout["r_ph_pm_eh_em_th"]         = { METAHUD_LAYOUTPATH.."bg_1p"   , 1 , 0 , 0 , 1 };
		texlayout["l_ph_pm_eh_em_th_tm"]      = { METAHUD_LAYOUTPATH.."bg_21p"  , 0 , 1 , 0 , 1 };
		texlayout["r_ph_pm_eh_em_th_tm"]      = { METAHUD_LAYOUTPATH.."bg_21p"  , 1 , 0 , 0 , 1 };
		texlayout["MetaHud_TargetElite"]      = { METAHUD_LAYOUTPATH.."elite"   , 0 , 1 , 0 , 1 };
		texlayout["MetaHud_TargetRare"]       = { METAHUD_LAYOUTPATH.."rare"    , 0 , 1 , 0 , 1 };

		---  Frames
		framelayout["MetaHud_PlayerMana_Bar"]    = { "Bar"     , "BOTTOM" , "MetaHud_RightFrame"   , "BOTTOM"  , 0    , 0   , 128 , 256};
		framelayout["MetaHud_TargetHealth_Bar"]  = { "Bar"     , "BOTTOM" , "MetaHud_LeftFrame"    , "BOTTOM"  , 0    , 0   , 128 , 256};
		framelayout["MetaHud_PetMana_Bar"]       = { "Bar"     , "BOTTOM" , "MetaHud_RightFrame"   , "BOTTOM"  , 0    , 0   , 128 , 256};
		framelayout["MetaHud_Casting_Bar"]       = { "Bar"     , "BOTTOM" , "MetaHud_RightFrame"   , "BOTTOM"  , 0    , 0   , 128 , 256};
		framelayout["MetaHud_Flash_Bar"]         = { "Bar"     , "BOTTOM" , "MetaHud_RightFrame"   , "BOTTOM"  , 0    , 0   , 128 , 256};   
		framelayout["MetaHud_PlayerHealth_Text"] = { "Text"    , "BOTTOM" , "MetaHud_LeftFrame"    , "BOTTOM"  , 95   , 2   , 200 , 14 };
		framelayout["MetaHud_PlayerMana_Text"]   = { "Text"    , "BOTTOM" , "MetaHud_RightFrame"   , "BOTTOM"  , -95  , 2   , 200 , 14 };
		framelayout["MetaHud_TargetHealth_Text"] = { "Text"    , "BOTTOM" , "MetaHud_LeftFrame"    , "BOTTOM"  , 80   , -16 , 200 , 14 };
		framelayout["MetaHud_TargetMana_Text"]   = { "Text"    , "BOTTOM" , "MetaHud_RightFrame"   , "BOTTOM"  , -80  , -16 , 200 , 14 };
		framelayout["MetaHud_PetHealth_Text"]    = { "Text"    , "BOTTOM" , "MetaHud_LeftFrame"    , "BOTTOM"  , 110  , 19  , 200 , 14 };
		framelayout["MetaHud_PetMana_Text"]      = { "Text"    , "BOTTOM" , "MetaHud_RightFrame"   , "BOTTOM"  , -110 , 19  , 200 , 14 };
		framelayout["MetaHud_Casttime_Text"]     = { "Text"    , "TOPRIGHT","MetaHud_RightFrame"   , "TOPRIGHT" , -88 , 5   , 100 , 14 };
		framelayout["MetaHud_Castdelay_Text"]    = { "Text"    , "TOPRIGHT","MetaHud_RightFrame"   , "TOPRIGHT" , -88 , 19  , 100 , 14 };
		framelayout["MetaHud_Combo1"]            = { "Texture" , "BOTTOM" , "MetaHud_LeftFrame"    , "BOTTOM"  , 6    , 0   , 20  , 20 };
		framelayout["MetaHud_Combo2"]            = { "Texture" , "BOTTOM" , "MetaHud_LeftFrame"    , "BOTTOM"  , -1   , 20  , 20  , 20 };
		framelayout["MetaHud_Combo3"]            = { "Texture" , "BOTTOM" , "MetaHud_LeftFrame"    , "BOTTOM"  , -7   , 40  , 20  , 20 };
		framelayout["MetaHud_Combo4"]            = { "Texture" , "BOTTOM" , "MetaHud_LeftFrame"    , "BOTTOM"  , -11  , 60  , 20  , 20 };
		framelayout["MetaHud_Combo5"]            = { "Texture" , "BOTTOM" , "MetaHud_LeftFrame"    , "BOTTOM"  , -13  , 80  , 20  , 20 };
		framelayout["MetaHud_PlayerResting"]     = { "Texture" , "BOTTOM" , "MetaHud_RightFrame"   , "BOTTOM"  , 2    , 0   , 22  , 22 };
		framelayout["MetaHud_PlayerAttacking"]   = { "Texture" , "BOTTOM" , "MetaHud_RightFrame"   , "BOTTOM"  , 2    , 0   , 22  , 22 };
		framelayout["MetaHud_PlayerPvP"]         = { "Texture" , "BOTTOM" , "MetaHud_RightFrame"   , "BOTTOM"  , 7    , 25  , 22  , 22 };
		framelayout["MetaHud_PlayerLeader"]      = { "Texture" , "BOTTOM" , "MetaHud_RightFrame"   , "BOTTOM"  , 13   , 50  , 22  , 22 };
		framelayout["MetaHud_PlayerLooter"]      = { "Texture" , "BOTTOM" , "MetaHud_RightFrame"   , "BOTTOM"  , 15   , 75  , 22  , 22 };
		framelayout["MetaHud_PetHappy"]          = { "Texture" , "TOP"    , "MetaHud_LeftFrame"    , "TOP"     , 32   , -107, 20  , 20 };
		framelayout["MetaHud_TargetElite"]       = { "Texture" , "TOP"    , "MetaHud_LeftFrame"    , "TOP"     , 18   , 20  , 64  , 64 };
	else
		---  Textures
		texlayout["MetaHud_Casting_Bar"]      = { METAHUD_LAYOUTPATH.."cb"      , 0 , 1 , 0 , 1 };
		texlayout["MetaHud_Flash_Bar"]        = { METAHUD_LAYOUTPATH.."cbh"     , 0 , 1 , 0 , 1 };
		texlayout["MetaHud_PlayerHealth_Bar"] = { METAHUD_LAYOUTPATH.."2"..tex  , 0 , 1 , 0 , 1 };
		texlayout["MetaHud_PlayerMana_Bar"]   = { METAHUD_LAYOUTPATH.."1"..tex  , 0 , 1 , 0 , 1 };
		texlayout["MetaHud_TargetHealth_Bar"] = { METAHUD_LAYOUTPATH.."2"..tex  , 1 , 0 , 0 , 1 };
		texlayout["MetaHud_TargetMana_Bar"]   = { METAHUD_LAYOUTPATH.."1"..tex  , 1 , 0 , 0 , 1 };
		texlayout["MetaHud_PetHealth_Bar"]    = { METAHUD_LAYOUTPATH.."p2"..tex , 0 , 1 , 0 , 1 };
		texlayout["MetaHud_PetMana_Bar"]      = { METAHUD_LAYOUTPATH.."p1"..tex , 0 , 1 , 0 , 1 };
		texlayout["l_ph_pm"]                  = { METAHUD_LAYOUTPATH.."bg_21"   , 0 , 1 , 0 , 1 };
		texlayout["r_ph_pm"]                  = { METAHUD_LAYOUTPATH.."bg_0"    , 1 , 0 , 0 , 1 };
		texlayout["l_ph_pm_em"]               = { METAHUD_LAYOUTPATH.."bg_21p"  , 0 , 1 , 0 , 1 };
		texlayout["r_ph_pm_em"]               = { METAHUD_LAYOUTPATH.."bg_0"    , 1 , 0 , 0 , 1 };
		texlayout["l_ph_pm_eh_em"]            = { METAHUD_LAYOUTPATH.."bg_21pp" , 0 , 1 , 0 , 1 };
		texlayout["r_ph_pm_eh_em"]            = { METAHUD_LAYOUTPATH.."bg_0"    , 1 , 0 , 0 , 1 };
		texlayout["l_ph_pm_eh"]               = { METAHUD_LAYOUTPATH.."bg_21pp" , 0 , 1 , 0 , 1 };
		texlayout["r_ph_pm_eh"]               = { METAHUD_LAYOUTPATH.."bg_0"    , 1 , 0 , 0 , 1 };
		texlayout["l_ph_pm_th"]               = { METAHUD_LAYOUTPATH.."bg_21"   , 0 , 1 , 0 , 1 };
		texlayout["r_ph_pm_th"]               = { METAHUD_LAYOUTPATH.."bg_2"    , 1 , 0 , 0 , 1 };
		texlayout["l_ph_pm_em_th"]            = { METAHUD_LAYOUTPATH.."bg_21p"  , 0 , 1 , 0 , 1 };
		texlayout["r_ph_pm_em_th"]            = { METAHUD_LAYOUTPATH.."bg_2"    , 1 , 0 , 0 , 1 };
		texlayout["l_ph_pm_eh_th"]            = { METAHUD_LAYOUTPATH.."bg_21pp" , 0 , 1 , 0 , 1 };
		texlayout["r_ph_pm_eh_th"]            = { METAHUD_LAYOUTPATH.."bg_1"    , 1 , 0 , 0 , 1 };
		texlayout["l_ph_pm_th_tm"]            = { METAHUD_LAYOUTPATH.."bg_21"   , 0 , 1 , 0 , 1 };
		texlayout["r_ph_pm_th_tm"]            = { METAHUD_LAYOUTPATH.."bg_21"   , 1 , 0 , 0 , 1 };
		texlayout["l_ph_pm_eh_th"]            = { METAHUD_LAYOUTPATH.."bg_21"   , 0 , 1 , 0 , 1 };
		texlayout["r_ph_pm_eh_th"]            = { METAHUD_LAYOUTPATH.."bg_2"    , 1 , 0 , 0 , 1 };
		texlayout["l_ph_pm_em_th_tm"]         = { METAHUD_LAYOUTPATH.."bg_21p"  , 0 , 1 , 0 , 1 };
		texlayout["r_ph_pm_em_th_tm"]         = { METAHUD_LAYOUTPATH.."bg_21"   , 1 , 0 , 0 , 1 };
		texlayout["l_ph_pm_eh_em_th"]         = { METAHUD_LAYOUTPATH.."bg_21pp" , 0 , 1 , 0 , 1 };
		texlayout["r_ph_pm_eh_em_th"]         = { METAHUD_LAYOUTPATH.."bg_2"    , 1 , 0 , 0 , 1 };
		texlayout["l_ph_pm_eh_em_th_tm"]      = { METAHUD_LAYOUTPATH.."bg_21pp" , 0 , 1 , 0 , 1 };
		texlayout["r_ph_pm_eh_em_th_tm"]      = { METAHUD_LAYOUTPATH.."bg_21"   , 1 , 0 , 0 , 1 };
		texlayout["MetaHud_TargetElite"]      = { METAHUD_LAYOUTPATH.."elite"   , 1 , 0 , 0 , 1 };
		texlayout["MetaHud_TargetRare"]       = { METAHUD_LAYOUTPATH.."rare"    , 1 , 0 , 0 , 1 };

		---  Frames
		framelayout["MetaHud_PlayerMana_Bar"]    = { "Bar"     , "BOTTOM"    , "MetaHud_LeftFrame"  , "BOTTOM"    , 0   , 0    , 128 , 256};
		framelayout["MetaHud_TargetHealth_Bar"]  = { "Bar"     , "BOTTOM"    , "MetaHud_RightFrame" , "BOTTOM"    , 0   , 0    , 128 , 256};
		framelayout["MetaHud_PetMana_Bar"]       = { "Bar"     , "BOTTOM"    , "MetaHud_LeftFrame"  , "BOTTOM"    , 0   , 0    , 128 , 256};
		framelayout["MetaHud_Casting_Bar"]       = { "Bar"     , "BOTTOM"    , "MetaHud_LeftFrame"  , "BOTTOM"    , 0   , 0    , 128 , 256};
		framelayout["MetaHud_Flash_Bar"]         = { "Bar"     , "BOTTOM"    , "MetaHud_LeftFrame"  , "BOTTOM"    , 0   , 0    , 128 , 256};
		framelayout["MetaHud_PlayerHealth_Text"] = { "Text"    , "BOTTOM"    , "MetaHud_LeftFrame"  , "BOTTOM"    , 80  , -16  , 200 , 14 };
		framelayout["MetaHud_PlayerMana_Text"]   = { "Text"    , "BOTTOM"    , "MetaHud_LeftFrame"  , "BOTTOM"    , 95  , 2    , 200 , 14 };
		framelayout["MetaHud_TargetHealth_Text"] = { "Text"    , "BOTTOM"    , "MetaHud_RightFrame" , "BOTTOM"    , -80 , -16  , 200 , 14 };
		framelayout["MetaHud_TargetMana_Text"]   = { "Text"    , "BOTTOM"    , "MetaHud_RightFrame" , "BOTTOM"    , -95 , 2    , 200 , 14 };
		framelayout["MetaHud_PetHealth_Text"]    = { "Text"    , "BOTTOMLEFT", "MetaHud_LeftFrame"  , "BOTTOMLEFT", 130 , 36   , 200 , 14 };
		framelayout["MetaHud_PetMana_Text"]      = { "Text"    , "BOTTOMLEFT", "MetaHud_LeftFrame"  , "BOTTOMLEFT", 120 , 19   , 200 , 14 };
		framelayout["MetaHud_Casttime_Text"]     = { "Text"    , "TOPLEFT"   , "MetaHud_LeftFrame"  , "TOPLEFT"   , 100 , 5    , 100 , 14 };
		framelayout["MetaHud_Castdelay_Text"]    = { "Text"    , "TOPLEFT"   , "MetaHud_LeftFrame"  , "TOPLEFT"   , 100 , 19   , 100 , 14 };
		framelayout["MetaHud_Combo1"]            = { "Texture" , "BOTTOM"    , "MetaHud_RightFrame" , "BOTTOM"    , -4  , 0    , 20  , 20 };
		framelayout["MetaHud_Combo2"]            = { "Texture" , "BOTTOM"    , "MetaHud_RightFrame" , "BOTTOM"    , 3   , 20   , 20  , 20 };
		framelayout["MetaHud_Combo3"]            = { "Texture" , "BOTTOM"    , "MetaHud_RightFrame" , "BOTTOM"    , 8   , 40   , 20  , 20 };
		framelayout["MetaHud_Combo4"]            = { "Texture" , "BOTTOM"    , "MetaHud_RightFrame" , "BOTTOM"    , 11  , 60   , 20  , 20 };
		framelayout["MetaHud_Combo5"]            = { "Texture" , "BOTTOM"    , "MetaHud_RightFrame" , "BOTTOM"    , 13  , 80   , 20  , 20 };
		framelayout["MetaHud_PlayerResting"]     = { "Texture" , "BOTTOM"    , "MetaHud_LeftFrame"  , "BOTTOM"    , -2  , 0    , 22  , 22 };
		framelayout["MetaHud_PlayerAttacking"]   = { "Texture" , "BOTTOM"    , "MetaHud_LeftFrame"  , "BOTTOM"    , -2  , 0    , 22  , 22 };
		framelayout["MetaHud_PlayerPvP"]         = { "Texture" , "BOTTOM"    , "MetaHud_LeftFrame"  , "BOTTOM"    , -7  , 25   , 22  , 22 };
		framelayout["MetaHud_PlayerLeader"]      = { "Texture" , "BOTTOM"    , "MetaHud_LeftFrame"  , "BOTTOM"    , -13 , 50   , 22  , 22 };
		framelayout["MetaHud_PlayerLooter"]      = { "Texture" , "BOTTOM"    , "MetaHud_LeftFrame"  , "BOTTOM"    , -15 , 75   , 22  , 22 };
		framelayout["MetaHud_PetHappy"]          = { "Texture" , "TOP"       , "MetaHud_LeftFrame"  , "TOP"       , 32  , -107 , 20  , 20 };
		framelayout["MetaHud_TargetElite"]       = { "Texture" , "TOP"       , "MetaHud_RightFrame" , "TOP"       , -18 , 20   , 64  , 64 };
	end
end


mxCameraZoomIn = nil;
mxCameraZoomOut = nil;

MX_ARMOR_TYPES = {
	{name = "Frost/Ice Armor"},
	{name = "Mage Armor"}
}

MX_ARMOR_TYPE_FROST = 1;
MX_ARMOR_TYPE_MAGE  = 2;
MX_ARCANE_TYPE_INTELLECT = 1;
MX_ARCANE_TYPE_BRILLIANCE = 2;

MXSPELL_ARCANE_INTELLECT  = "Arcane Intellect";
MXSPELL_ARCANE_BRILLIANCE = "Arcane Brilliance";
MXSPELL_FROST_ARMOR 	  = "Frost Armor";
MXSPELL_ICE_ARMOR 		  = "Ice Armor";
MXSPELL_MAGE_ARMOR 		  = "Mage Armor";
MXSPELL_DAMPEN_MAGIC 	  = "Dampen Magic";
MXSPELL_COMBUSTION 		  = "Combustion";

MXPORTAL_IF = "Ironforge";
MXPORTAL_SW = "Stormwind";
MXPORTAL_DN = "Darnassus";
MXPORTAL_OG = "Orgrimmar";
MXPORTAL_UC = "Undercity";
MXPORTAL_TB = "Thunder Bluff";

MXREAGENT_LF = "LF";
MXREAGENT_ROT = "ROT";
MXREAGENT_ROP = "ROP";
MXREAGENT_AP = "AP";

MXSOUND_BUFF = "Buff";
MXSOUND_CRITICAL = "Critical";

DEFAULT_BUTTON_SIZE = 32;

local UPDATE_INTERVAL = 0.5;
local COLOR_INCREMENT = 2;

local Loaded = false;
local LoadedVariables = false;
local ClassError = false;
local VersionError = false;

local ElapsedTime = 0;
local LastTime = 0;

local PlayerCombat = false;

local LastSpell = nil;
local SpellCastName = nil;

local CastBuff = {false,false,false,false,false,false,false,false,false};

local DisplayReagentAlert = false;

local red = 1;
local multiplier = -1;

-- Reagent
local ReagentID  = {MXREAGENT_LF, MXREAGENT_ROT, MXREAGENT_ROP, MXREAGENT_AP}

local Reagent = {
	[MXREAGENT_LF]  = {display = false, count = 0, tag = "Light Feather"},
	[MXREAGENT_ROT] = {display = false, count = 0, tag = "Rune of Teleportation"},
	[MXREAGENT_ROP] = {display = false, count = 0, tag = "Rune of Portals"},
	[MXREAGENT_AP]  = {display = false, count = 0, tag = "Arcane Powder"}
}

MXReagent = {
		[MXREAGENT_LF] = {alwaysDisplay = false, enableAlert = true,  threshold = 2},
		[MXREAGENT_ROT]  = {alwaysDisplay = false, enableAlert = true,  threshold = 2},
		[MXREAGENT_ROP]  = {alwaysDisplay = false, enableAlert = false, threshold = 2},
		[MXREAGENT_AP] = {alwaysDisplay = false, enableAlert = true,  threshold = 2},
};

MX = {
	
	Version = 1.0,
	Author = "Xsor",
	AppName = "MageX",
	Title = "MageX v1.0 - Created by Xsor",
	
	SpellName  = { MXSPELL_ARCANE_INTELLECT,MXSPELL_ARCANE_BRILLIANCE,MXSPELL_FROST_ARMOR,MXSPELL_ICE_ARMOR,MXSPELL_MAGE_ARMOR,MXSPELL_DAMPEN_MAGIC,MXSPELL_COMBUSTION},
	PortalName = {MXPORTAL_IF, MXPORTAL_SW, MXPORTAL_DN, MXPORTAL_OG, MXPORTAL_UC, MXPORTAL_TB},

	PortalPrefix = "Portal: ",
	TeleportPrefix = "Teleport: ",

	Spell = { [MXSPELL_ARCANE_INTELLECT] 	= { Name = "", Rank = "", ID = 0, Mana = 0, Time = 0, Exists = false, Active = true, File = MXSOUND_BUFF},
		  	  [MXSPELL_ARCANE_BRILLIANCE] 	= { Name = "", Rank = "", ID = 0, Mana = 0, Time = 0, Exists = false, Active = true, File = MXSOUND_BUFF},
		  	  [MXSPELL_FROST_ARMOR]     	= { Name = "", Rank = "", ID = 0, Mana = 0, Time = 0, Exists = false, Active = true, File = MXSOUND_BUFF},
		  	  [MXSPELL_ICE_ARMOR]  			= { Name = "", Rank = "", ID = 0, Mana = 0, Time = 0, Exists = false, Active = true, File = MXSOUND_BUFF},
		  	  [MXSPELL_MAGE_ARMOR]  		= { Name = "", Rank = "", ID = 0, Mana = 0, Time = 0, Exists = false, Active = true, File = MXSOUND_BUFF},
		  	  [MXSPELL_DAMPEN_MAGIC]    	= { Name = "", Rank = "", ID = 0, Mana = 0, Time = 0, Exists = false, Active = true, File = MXSOUND_BUFF},
		  	  [MXSPELL_COMBUSTION]   		= { Name = "", Rank = "", ID = 0, Mana = 0, Time = 300, Exists = false, Active = true, File = MXSOUND_BUFF}
	},

  	Portal = {[MXPORTAL_IF] = {Name = "",ID = 0,Time = 0,Mana = 850, Exists = false},
  			  [MXPORTAL_SW] = {Name = "",ID = 0,Time = 0,Mana = 850, Exists = false},
			  [MXPORTAL_DN] = {Name = "",ID = 0,Time = 0,Mana = 850, Exists = false},
			  [MXPORTAL_OG] = {Name = "",ID = 0,Time = 0,Mana = 850, Exists = false},
			  [MXPORTAL_UC]	= {Name = "",ID = 0,Time = 0,Mana = 850, Exists = false},
			  [MXPORTAL_TB] = {Name = "",ID = 0,Time = 0,Mana = 850, Exists = false},
	},

  	Teleport = {[MXPORTAL_IF] = {Name = "",ID = 0,Time = 0,Mana = 850, Exists = false},
  			    [MXPORTAL_SW] = {Name = "",ID = 0,Time = 0,Mana = 850, Exists = false},
			    [MXPORTAL_DN] = {Name = "",ID = 0,Time = 0,Mana = 850, Exists = false},
			    [MXPORTAL_OG] = {Name = "",ID = 0,Time = 0,Mana = 850, Exists = false},
			    [MXPORTAL_UC] = {Name = "",ID = 0,Time = 0,Mana = 850, Exists = false},
			    [MXPORTAL_TB] = {Name = "",ID = 0,Time = 0,Mana = 850, Exists = false},
	},

	SpellCount		= 7;
	PortalCount     = 6;
	TeleportCount   = 6;
	Class			= "Mage",
	ScalingParse1  	= "for up to (.+) sec.",
	ScalingParse2  	= "for (.+) sec.",
	ParseSeconds   	= "sec",
	CombatParse1   	= "Your (.+) crits (.+) for (%d+).",
	CombatParse2   	= "You crit (.+) for (%d+)",
	MSG_ClassError 	= "deactivated, you are not a Mage.",
	MSG_VersionError= "loading failed : you are not using an english version of WoW.",
	MSG_Reset      	= "Configuration has been reset.",
	MSG_Loaded     	= "Configuration has been loaded.",
	MSG_SpellLoaded = "Spell list has been updated.",
	MSG_Help       	= "Type \"/mx help\" for more information.",
	MSG_Portal1 	= "<< I am opening a portal to ",
	MSG_Portal2 	= ", please right-click it in the next 30 seconds if you wish to be teleported. >>",
	MSG_SpellError1 = "You don't have the spell: ",
	MSG_AttackError = "You cannot attack that target.",
	Rank 		= "Rank",

	MSG_HelpCmd = {	"<lightOrange>/mx           <white>- Toggles the MageX option menu.",
			"<lightOrange>/mx options   <white>- Toggles the MageX option menu.",
			"<lightOrange>/mx show,hide <white>- Toggles the MageX button around minimap.",
			"<lightOrange>/mx status    <white>- Shows the current state of MageX."
	}

};

MXConfig = {
	Version = MX.Version;
	
	Spell = { [MXSPELL_ARCANE_INTELLECT] 	= { Enable = true, Sound = true},
		  	  [MXSPELL_ARCANE_BRILLIANCE] 	= { Enable = true, Sound = true},
		  	  [MXSPELL_FROST_ARMOR]     	= { Enable = true, Sound = true},
		  	  [MXSPELL_ICE_ARMOR]  			= { Enable = true, Sound = true},
		  	  [MXSPELL_MAGE_ARMOR]  		= { Enable = true, Sound = true},
		  	  [MXSPELL_DAMPEN_MAGIC]    	= { Enable = true, Sound = true},
		  	  [MXSPELL_COMBUSTION]   		= { Enable = true, Sound = false}
	},

	Button = { [MXPORTAL_IF] = { Enable = true },
		  	   [MXPORTAL_SW] = { Enable = true },
		  	   [MXPORTAL_DN] = { Enable = true },
		  	   [MXPORTAL_OG] = { Enable = true },
		  	   [MXPORTAL_UC] = { Enable = true },
		  	   [MXPORTAL_TB] = { Enable = true }
	},

	Sound = {
		[MXSOUND_BUFF] 		= {Enable = true, File = "Interface\\AddOns\\MageX\\Sounds\\buff.mp3"},
		[MXSOUND_CRITICAL] 	= {Enable = true, File = "Interface\\AddOns\\MageX\\Sounds\\critical.mp3"}
	},
	
	UsePortalMessage = true,
	ShowPortalButtons = true,

	DefaultArmor = MX_ARMOR_TYPE_FROST,
	DefaultArcane = MX_ARCANE_TYPE_INTELLECT,

	ButtonScale = 1,
	MainButtonRotation = 260,
};

---------------------------------------------------------------------------------------------------------------------------------------
-- MX FUNCTIONS
----------------------------------------------------------------------------------------------------------------------------------------
function MX_OnLoad()
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("UNIT_NAME_UPDATE");
	SlashCmdList["MXCommand"] = MX_SlashHandler;
	SLASH_MXCommand1 = "/mx";
end

function MX_OnUpdate()

	if(VersionError or ClassError) then
		return;

	elseif (not Loaded) then
		if(LoadedVariables) then
			MX_Initialize();
			LastTime = GetTime();
			return;
		else
			return;
		end
	end
	
	-- Process GUI update
	ElapsedTime = ElapsedTime + GetTime();
	if (ElapsedTime >= UPDATE_INTERVAL) then
		ElapsedTime = 0;
		if(Loaded) then MX_UpdateBuffs(); end
		MX_UpdateMainFrameUI();
	end
	
	if(DisplayReagentAlert) then
		MX_UpdateRegeantAlert(true, GetTime() - LastTime);
	end
	LastTime = GetTime();
end

function MX_OnEvent(event)

	if (event == "VARIABLES_LOADED") then
		LoadedVariables = true;

	elseif (event == "PLAYER_LOGOUT") then
		Loaded = false;
		LoadedVariables = false;
		ClassError = false;
		VersionError = false;
	
	elseif (event == "PLAYER_LOGIN") then
		if (LoadedVariables and (not Loaded)) then MX_Initialize(); end

	elseif (event == "BAG_UPDATE") then
		MX_UpdateReagentCount();

	elseif (event == "PLAYER_REGEN_DISABLED") then
		PlayerCombat = true;

	elseif (event == "PLAYER_REGEN_ENABLED") then
		PlayerCombat = false;

	elseif (event == "SPELLCAST_START") then
		SpellCastName = arg1;
		local i;
		for i = 1,MX.PortalCount do
			if ((SpellCastName == MX.Portal[MX.PortalName[i]].Name) and MXConfig.UsePortalMessage) then
				MX_Msg(MX.MSG_Portal1..MX.PortalName[i]..MX.MSG_Portal2, "WORLD");
			end
		end
		MX_UpdateReagentCount();

	elseif (event == "SPELLCAST_FAILED") then
		SpellCastName = nil;

	elseif (event == "SPELLCAST_INTERRUPTED") then
		SpellCastName = nil;

	elseif (event == "SPELLCAST_STOP") then
		SpellCastName = nil;

	elseif (event == "LEARNED_SPELL_IN_TAB") then
		MX_SpellSetup();
	
	elseif (event == "CHAT_MSG_COMBAT_SELF_HITS" or event == "CHAT_MSG_COMBAT_SELF_MISSES" or event == "CHAT_MSG_SPELL_SELF_DAMAGE" or event == "CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE" or event == "CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE") then
		if (MXConfig.Sound[MXSOUND_CRITICAL].Enable) then
			for spell, creatureName, damage in string.gfind(arg1, MX.CombatParse1) do
				PlaySoundFile(MXConfig.Sound[MXSOUND_CRITICAL].File);
				return;
			end
			for creatureName, damage in string.gfind(arg1, MX.CombatParse2) do
				PlaySoundFile(MXConfig.Sound[MXSOUND_CRITICAL].File);
				return;
			end
		end
	
	end
end

function MX_Initialize()
	
	if (Loaded) then
		return;

	elseif (GetLocale() ~= "enUS") then
		Loaded = true;
		VersionError = true;
		HideUIPanel(MageXFrame);
		HideUIPanel(MX_MainButton);
		MX_HideToolBars();
		
		MX_Msg(MX.MSG_VersionError, "USER");
		
	elseif (UnitClass("player") ~= MX.Class) then
		Loaded = true;
		ClassError = true;
		HideUIPanel(MageXFrame);
		HideUIPanel(MX_MainButton);
		MX_HideToolBars();
		
		MX_Msg(MX.MSG_ClassError, "USER");
		
	else
		mxCameraZoomIn = CameraZoomIn;
 		mxCameraZoomOut = CameraZoomOut;
 		CameraZoomIn  = MX_CamZoomIn;
 		CameraZoomOut = MX_CamZoomOut;
		
		-- Load saved Config here
    		--RegisterForSave("MXConfig");
    
		if (MXConfig.Version ~= MX.Version) then
			--MXConfig = MXDefault_Config;
			MX_Msg(MX.MSG_Reset, "USER");
		else
			MX_Msg(MX.MSG_Loaded, "USER");
		end

		this:RegisterEvent("BAG_UPDATE");
		this:RegisterEvent("CHAT_MSG_COMBAT_SELF_HITS");
		this:RegisterEvent("CHAT_MSG_COMBAT_SELF_MISSES");
		this:RegisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE");
		this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE");
		this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE");
		this:RegisterEvent("PLAYER_REGEN_DISABLED");
		this:RegisterEvent("PLAYER_REGEN_ENABLED");
		this:RegisterEvent("SPELLCAST_START");
		this:RegisterEvent("SPELLCAST_FAILED");
		this:RegisterEvent("SPELLCAST_INTERRUPTED");
		this:RegisterEvent("SPELLCAST_STOP");
		this:RegisterEvent("LEARNED_SPELL_IN_TAB");
		this:RegisterEvent("UNIT_COMBAT");
		this:RegisterEvent("UNIT_FOCUS");
		this:RegisterEvent("BAG_UPDATE");
		
		Loaded = true;
		
		-- Run setup functions
		MX_SpellSetup();

		MX_UpdateMainFrameUI();

		MX_UpdateReagentCount();

		-- Set the saved location of buttons
		MXPortalButtonFrame:SetUserPlaced(1);

		MX_Msg(MX.MSG_Help, "USER");
	end
end

function MX_ArmorType_OnLoad()

	UIDropDownMenu_SetSelectedID(MXDefaultArmorType, MXConfig.DefaultArmor, AMB_SHIELD_TYPES);	
	UIDropDownMenu_SetText(MX_ARMOR_TYPES[MXConfig.DefaultArmor].name, MXDefaultArmorType);

	local function MXDefaultArmorType_Initialize()
		local info;
		for i = 1, getn(MX_ARMOR_TYPES), 1 do
			info = { };
			info.text = MX_ARMOR_TYPES[i].name;
			info.func = MX_ArmorType_OnClick;
			UIDropDownMenu_AddButton(info);
		end
	end

	UIDropDownMenu_Initialize(MXDefaultArmorType, MXDefaultArmorType_Initialize);
	UIDropDownMenu_SetWidth(130);
	UIDropDownMenu_SetButtonWidth(24);
	UIDropDownMenu_JustifyText("LEFT", MXDefaultArmorType)
end

function MX_ArmorType_OnClick()
	UIDropDownMenu_SetSelectedID(MXDefaultArmorType, this:GetID());
	MXConfig.DefaultArmor = UIDropDownMenu_GetSelectedID(MXDefaultArmorType);
end

function MX_PlayerCanCastSpell(spellname)
	local i, buff;
	local mounted = false;
	local spellIsReady, playerIsAlive, manaOK;
	local mana;
	
	-- Get Player's current mana point<
	mana = UnitMana("player");
	manaOK = (mana > MX.Spell[spellname].Mana);
	
	-- Spell has no cooldown active, ready to cast
	spellIsReady = CheckCooldown(MX.Spell[spellname].ID); --TODO:check this
	
	-- Player must be alive
	playerIsAlive = (UnitHealth("player") > 0);
	
	-- Check for mount icon in buffs.
	for i=1,16 do
		buff = UnitBuff("player",i);
		if(buff and string.find(buff,"Mount_")) then mounted = true; end
	end

	if(not mounted and playerIsAlive and spellIsReady and manaOK and not PlayerCombat) then
		return true;
	else
		return false;
	end
end

function MX_UpdateBuffs()
	local i,j,buff;

	for i=1,MX.SpellCount do
		MX.Spell[MX.SpellName[i]].Active = false;
	end
	
	for i=1,16 do
		buff = UnitBuff("player",i);
		
		for j=1, MX.SpellCount do
			if(MX.Spell[MX.SpellName[j]].Exists) then
				if(buff == MX.Spell[MX.SpellName[j]].Texture) then
				   MX.Spell[MX.SpellName[j]].Active = true;
				end
			end				
		end
	end
end

-- MOVEMENT FUNCTION --
function MX_CamZoomIn(event)
	MX_Movement()
	mxCameraZoomIn(event)		
end

function MX_CamZoomOut(event)
	MX_Movement()
	mxCameraZoomOut(event)		
end

-- Spells are cast here in MX_Movement when the player moves

function MX_Movement()
	if(not Loaded or ClassError or VersionError) then return; end

	-- Cast Intellect if no Arcane Brilliance
	if(MX.Spell[MXSPELL_ARCANE_INTELLECT].Exists and MXConfig.Spell[MXSPELL_ARCANE_INTELLECT].Enable and not MX.Spell[MXSPELL_ARCANE_INTELLECT].Active) then
		if(MX.Spell[MXSPELL_ARCANE_BRILLIANCE].Active) then
			MX.Spell[MXSPELL_ARCANE_INTELLECT].Active = true;
		else
			if(MX_PlayerCanCastSpell(MXSPELL_ARCANE_INTELLECT)) then
				MX_SelfCastSpell(MXSPELL_ARCANE_INTELLECT);
				MX.Spell[MXSPELL_ARCANE_INTELLECT].Active = true;
				return; -- Its certain that we can cast only one spell by update here so break loop.
			end
		end
	end

	-- Check for Armor type and cast it if needed
	if((MXConfig.DefaultArmor == MX_ARMOR_TYPE_FROST)) then
		if(MX.Spell[MXSPELL_ICE_ARMOR].Exists and MXConfig.Spell[MXSPELL_ICE_ARMOR].Enable and not MX.Spell[MXSPELL_ICE_ARMOR].Active) then
			if(MX_PlayerCanCastSpell(MXSPELL_ICE_ARMOR)) then
				MX_SelfCastSpell(MXSPELL_ICE_ARMOR);
				MX.Spell[MXSPELL_ICE_ARMOR].Active = true;
				MX.Spell[MXSPELL_FROST_ARMOR].Active = true;
				return; -- Its certain that we can cast only one spell by update here so break loop.
			end

		elseif(MX.Spell[MXSPELL_FROST_ARMOR].Exists and MXConfig.Spell[MXSPELL_FROST_ARMOR].Enable and not MX.Spell[MXSPELL_FROST_ARMOR].Active) then
			if(MX_PlayerCanCastSpell(MXSPELL_FROST_ARMOR)) then
				MX_SelfCastSpell(MXSPELL_FROST_ARMOR);
				MX.Spell[MXSPELL_ICE_ARMOR].Active = true;
				MX.Spell[MXSPELL_FROST_ARMOR].Active = true;
				return; -- Its certain that we can cast only one spell by update here so break loop.
			end
		end
	else
		if(MX.Spell[MXSPELL_MAGE_ARMOR].Exists and MXConfig.Spell[MXSPELL_MAGE_ARMOR].Enable and not MX.Spell[MXSPELL_MAGE_ARMOR].Active) then
			MX_SelfCastSpell(MXSPELL_MAGE_ARMOR);
			MX.Spell[MXSPELL_MAGE_ARMOR].Active = true;
			return; -- Its certain that we can cast only one spell by update here so break loop.
		end
	end

	-- Dampen Magic --
	if(MX.Spell[MXSPELL_DAMPEN_MAGIC].Exists and MXConfig.Spell[MXSPELL_DAMPEN_MAGIC].Enable and not MX.Spell[MXSPELL_DAMPEN_MAGIC].Active and MX_PlayerCanCastSpell(MXSPELL_DAMPEN_MAGIC)) then
		MX_SelfCastSpell(MXSPELL_DAMPEN_MAGIC);
		MX.Spell[MXSPELL_DAMPEN_MAGIC].Active = true;
		return; -- Its certain that we can cast only one spell by update here so break loop.
	end

	-- Combustion --
	if(MX.Spell[MXSPELL_COMBUSTION].Exists and MXConfig.Spell[MXSPELL_COMBUSTION].Enable and not MX.Spell[MXSPELL_COMBUSTION].Active and MX_PlayerCanCastSpell(MXSPELL_COMBUSTION)) then
		MX_SelfCastSpell(MXSPELL_COMBUSTION);
		MX.Spell[MXSPELL_COMBUSTION].Active = true;
		return; -- Its certain that we can cast only one spell by update here so break loop.
	end
end

function MX_MsgAddColor(msg)
	msg = string.gsub(msg, "<white>", "|CFFFFFFFF");
	msg = string.gsub(msg, "<lightBlue>", "|CFF99CCFF");
	msg = string.gsub(msg, "<brightGreen>", "|CFF00FF00");
	msg = string.gsub(msg, "<lightGreen2>", "|CFF66FF66");
	msg = string.gsub(msg, "<lightGreen1>", "|CFF99FF66");
	msg = string.gsub(msg, "<yellowGreen>", "|CFFCCFF66");
	msg = string.gsub(msg, "<lightYellow>", "|CFFFFFF66");
	msg = string.gsub(msg, "<yellow>", "|CFFFFFF00");	
	msg = string.gsub(msg, "<darkYellow>", "|CFFFFCC00");
	msg = string.gsub(msg, "<lightOrange>", "|CFFFFCC66");
	msg = string.gsub(msg, "<dirtyOrange>", "|CFFFF9933");
	msg = string.gsub(msg, "<darkOrange>", "|CFFFF6600");
	msg = string.gsub(msg, "<redOrange>", "|CFFFF3300");
	msg = string.gsub(msg, "<red>", "|CFFFF0000");
	msg = string.gsub(msg, "<lightRed>", "|CFFFF5555");
	msg = string.gsub(msg, "<lightPurple1>", "|CFFFFC4FF");
	msg = string.gsub(msg, "<lightPurple2>", "|CFFFF99FF");
	msg = string.gsub(msg, "<purple>", "|CFFFF50FF");
	msg = string.gsub(msg, "<darkPurple1>", "|CFFFF00FF");
	msg = string.gsub(msg, "<darkPurple2>", "|CFFB700B7");
	msg = string.gsub(msg, "<pink>", "|CFFFF3399");
	msg = string.gsub(msg, "<close>", "|r");
	return msg;
end

function MX_Msg(msg, type)
	if (msg and type) then
		if (type == "USER") then
			msg = MX_MsgAddColor("<lightOrange>"..msg.."<close>");
			ChatFrame1:AddMessage("MageX: "..msg, 1, 1, 1);
		elseif (type == "WORLD") then
			if (GetNumRaidMembers() > 0) then
				SendChatMessage(msg, "RAID");
			elseif (GetNumPartyMembers() > 0) then
				SendChatMessage(msg, "PARTY");
			end
		elseif (type == "CHANNEL") then
			SendChatMessage(msg, "CHANNEL", this.language, 3);
		end
	end
end

function MX_SlashHandler(arg1)

	if(not ClassError or VersionError) then

		if (string.lower(arg1) == "help") then
			MX_Msg("===== Command List =====", "USER");
			MX_Msg(MX.MSG_HelpCmd[1], "USER");
			MX_Msg(MX.MSG_HelpCmd[2], "USER");
			MX_Msg(MX.MSG_HelpCmd[3], "USER");
			MX_Msg(MX.MSG_HelpCmd[4], "USER");
			MX_Msg("========================", "USER");

		elseif (string.lower(arg1) == "show") then
			MX_Toggle("on");
	
		elseif (string.lower(arg1) == "hide") then
			MX_Toggle("off");

		elseif ((string.lower(arg1) == "") or (string.lower(arg1) == "options")) then
			MX_ToggleOptions("on");
		end
	end

	if (string.lower(arg1) == "status") then
		MX_Msg("This function is disabled for now, it will be fixed in next version.", "USER");
--		if (VersionError) then
--			MX_Msg(MX.MSG_VersionError, "USER");
--
--		elseif (ClassError) then
--			MX_Msg(MX.MSG_ClassError, "USER");
--
--		elseif (Loaded == true) then
--			MX_Msg("has been loaded successfuly.", "USER");
--
--		else
--			MX_Msg("desactivated because of an unknown issue.", "USER");
--		end
	end
end

function MX_Toggle(state)
	if(state == "on") then
		ShowUIPanel(MageXFrame);
	else
		HideUIPanel(MageXFrame);
	end
end

function MX_ToggleOptions(state)
	if(state == "on") then
		MageXOptionsFrame:Show();
	else
		MageXOptionsFrame:Hide();
	end
end

function MX_ToggleReagentsOptions(state)
	if(state == "on") then
		MageXReagentsOptionsFrame:Show();
	else
		MageXReagentsOptionsFrame:Hide();
		MX_UpdateReagentCount();
	end
end

----------------------------------------------------------------------------------------------------------------------------------------
-- INTERFACE FUNCTIONS
----------------------------------------------------------------------------------------------------------------------------------------
function MX_ResetPosition()
	MXPortalButtonFrame:SetPoint("TOPLEFT", "UIParent", "TOPLEFT", 175, -125);
end

function MX_UpdateScale()
	if(MXPortalButtonFrame:GetScale() ~= MXConfig.ButtonScale) then
		MXPortalButtonFrame:SetScale(MXConfig.ButtonScale);
	end
end

function MX_UpdateMainFrameUI()

	if(ClassError or VersionError or not Loaded) then
		HideUIPanel(MageXFrame);
		HideUIPanel(MXPortalButtonFrame);
		MX_HideToolBars();
		return;
	end

	-- Portal Buttons --

	if(MXConfig.ShowPortalButtons) then
		local y = -5;
		local width = 10;
		local relative = "MXPortalButtonFrame";
		local POINT = "TOPLEFT";
		local offset = DEFAULT_BUTTON_SIZE;

		ShowUIPanel(MXPortalButtonFrame);
		
		if(MX.Teleport[MXPORTAL_IF].Exists) then
			ShowUIPanel(MX_PortalIF);
			MX_PortalIF:SetPoint(POINT, relative, POINT, width - 5, y);
			width = width + offset;
		else
			HideUIPanel(MX_PortalIF);
		end
		
		if(MX.Teleport[MXPORTAL_SW].Exists) then
			ShowUIPanel(MX_PortalSW);
			MX_PortalSW:SetPoint(POINT, relative, POINT, width - 5, y);
			width = width + offset;
		else
			HideUIPanel(MX_PortalSW);
		end
		
		if(MX.Teleport[MXPORTAL_DN].Exists) then
			ShowUIPanel(MX_PortalDN);
			MX_PortalDN:SetPoint(POINT, relative, POINT, width - 5, y);
			width = width + offset;
		else
			HideUIPanel(MX_PortalDN);
		end
		
		if(MX.Teleport[MXPORTAL_OG].Exists) then
			ShowUIPanel(MX_PortalOG);
			MX_PortalOG:SetPoint(POINT, relative, POINT, width - 5, y);
			width = width + offset;
		else
			HideUIPanel(MX_PortalOG);
		end
		
		if(MX.Teleport[MXPORTAL_UC].Exists) then
			ShowUIPanel(MX_PortalUC);
			MX_PortalUC:SetPoint(POINT, relative, POINT, width - 5, y);
			width = width + offset;
		else
			HideUIPanel(MX_PortalUC);
		end
		
		if(MX.Teleport[MXPORTAL_TB].Exists) then
			ShowUIPanel(MX_PortalTB);
			MX_PortalTB:SetPoint(POINT, relative, POINT, width - 5, y);
			width = width + offset;
		else
			HideUIPanel(MX_PortalTB);
		end
		
		MXPortalButtonFrame:SetWidth(width);
		MX_UpdateScale();
		if(width == 10) then HideUIPanel(MXPortalButtonFrame); end
		
	else
		MX_HideToolBars();
	end
	
	MX_UpdateMainButtonPosition();
end

function MX_UpdateMainButtonPosition()
	MageXFrame:SetPoint("TOPLEFT", "Minimap", "TOPLEFT", 54 - (78 * cos(MXConfig.MainButtonRotation)), (78 * sin(MXConfig.MainButtonRotation)) - 55 );
end

function MX_UpdateOptionFrameUI()
	-- Options frame control --
	
	MXOptSpellArcane:SetChecked( MXConfig.Spell[MXSPELL_ARCANE_INTELLECT].Enable );
	MXOptSpellArmor:SetChecked( MXConfig.Spell[MXSPELL_FROST_ARMOR].Enable or MXConfig.Spell[MXSPELL_ICE_ARMOR].Enable or MXConfig.Spell[MXSPELL_MAGE_ARMOR].Enable);
	MXOptSpellDampen:SetChecked(MXConfig.Spell[MXSPELL_DAMPEN_MAGIC].Enable );
	MXOptSpellCombustion:SetChecked( MXConfig.Spell[MXSPELL_COMBUSTION].Enable );

	MXOptShowPortalButtons:SetChecked( MXConfig.ShowPortalButtons );
	MXOptUsePortalMessage:SetChecked( MXConfig.UsePortalMessage );
	MXOptPlaySoundCritical:SetChecked( MXConfig.Sound[MXSOUND_CRITICAL].Enable );

	MXButtonScale:SetValue(MXConfig.ButtonScale);
	MXMainButtonRotation:SetValue(MXConfig.MainButtonRotation);
end

function MX_UpdateReagentsOptionFrameUI()
	-- Options frame control --
	
	MXOptReagentDisplayLF:SetChecked( MXReagent[MXREAGENT_LF].alwaysDisplay );
	MXOptReagentDisplayROT:SetChecked( MXReagent[MXREAGENT_ROT].alwaysDisplay );
	MXOptReagentDisplayROP:SetChecked( MXReagent[MXREAGENT_ROP].alwaysDisplay );
	MXOptReagentDisplayAP:SetChecked( MXReagent[MXREAGENT_AP].alwaysDisplay );

	MXOptReagentAlertLF:SetChecked( MXReagent[MXREAGENT_LF].enableAlert );
	MXOptReagentAlertROT:SetChecked( MXReagent[MXREAGENT_ROT].enableAlert );
	MXOptReagentAlertROP:SetChecked( MXReagent[MXREAGENT_ROP].enableAlert );
	MXOptReagentAlertAP:SetChecked( MXReagent[MXREAGENT_AP].enableAlert );

	MXOptReagentAlertTresholdLF:SetValue(MXReagent[MXREAGENT_LF].threshold);
	MXOptReagentAlertTresholdROT:SetValue(MXReagent[MXREAGENT_ROT].threshold);
	MXOptReagentAlertTresholdROP:SetValue(MXReagent[MXREAGENT_ROP].threshold);
	MXOptReagentAlertTresholdAP:SetValue(MXReagent[MXREAGENT_AP].threshold);
end

function MX_HideToolBars()
	HideUIPanel(MXPortalButtonFrame);
end

function MX_OnDragStart(button)
	GameTooltip:Hide();
	button:StartMoving();
end

function MX_OnDragStop(button)
	button:StopMovingOrSizing();
end

function MX_UpdateReagentCount()
	if(not Loaded or ClassError or VersionError) then return; end

	--Find Seeds
	local bag;
	local slot;
	local itemCount = 0;
	local i;

	Reagent[MXREAGENT_LF].count = 0;
	Reagent[MXREAGENT_ROT].count = 0;
	Reagent[MXREAGENT_ROP].count = 0;
	Reagent[MXREAGENT_AP].count = 0;

 	for bag=0,4 do
    		for slot=1,GetContainerNumSlots(bag) do
      			if (IsItemInContainer(bag,slot, Reagent["ROT"].tag)) then
					_, itemCount, _, _, _ = GetContainerItemInfo(bag, slot);
					Reagent["ROT"].count = Reagent["ROT"].count + itemCount;

				elseif (IsItemInContainer(bag,slot, Reagent["ROP"].tag)) then
					_, itemCount, _, _, _ = GetContainerItemInfo(bag, slot);
					Reagent["ROP"].count = Reagent["ROP"].count + itemCount;

				elseif (IsItemInContainer(bag,slot, Reagent["AP"].tag)) then
					_, itemCount, _, _, _ = GetContainerItemInfo(bag, slot);
					Reagent["AP"].count = Reagent["AP"].count + itemCount;

				elseif (IsItemInContainer(bag,slot, Reagent["LF"].tag)) then
					_, itemCount, _, _, _ = GetContainerItemInfo(bag, slot);
					Reagent["LF"].count = Reagent["LF"].count + itemCount;
				end
    		end
  	end
	
	DisplayReagentAlert = false;

	for i=1,4 do
		if( Reagent[ReagentID[i]].display and MXReagent[ReagentID[i]].enableAlert and (Reagent[ReagentID[i]].count <= MXReagent[ReagentID[i]].threshold) ) then
			DisplayReagentAlert = true;
			break;
		end
	end

	if(not DisplayReagentAlert) then
		MX_UpdateRegeantAlert(false, 0);
	end
end

function MX_UpdateRegeantAlert(active, time)

	local buttonTexture = getglobal("MainButtonNormalTex");
	
	if(active) then
		red = red + ((COLOR_INCREMENT * multiplier) * time);
		buttonTexture:SetVertexColor(red,0.2,0.2);
		
		if(red > 1) then
			red = 1 - (red - 1);
			multiplier = -1;
		elseif(red < 0) then
			red = -red;
			multiplier = 1;
		end
	else
		buttonTexture:SetVertexColor(1,1,1);
		red = 1;
		multiplier = -1;
	end
end

function MX_DisplayMainButtonToolTip()
	if(not Loaded) then return; end

	MX_UpdateReagentCount();
	
	local apoint,rpoint = "TOPRIGHT","TOPLEFT";
	local height = 39;
	local ypos = -15;

	-- Add Light Feathers to tooltip
	if(MXReagent[MXREAGENT_LF].alwaysDisplay or Reagent[MXREAGENT_LF].display) then
		
		MX_TotalLF:SetPoint(rpoint, "MX_Title", rpoint, 0, ypos);

		height = height + 15;
		ypos = ypos - 15;

		if(Reagent[MXREAGENT_LF].count > MXReagent[MXREAGENT_LF].threshold) then
			MX_TotalLF:SetText(Reagent[MXREAGENT_LF].tag..": |cffffffff"..Reagent[MXREAGENT_LF].count.."|r");
		else
			MX_TotalLF:SetText(Reagent[MXREAGENT_LF].tag..": |cffff0000"..Reagent[MXREAGENT_LF].count.."|r");
		end

		MX_TotalLF:Show();
	else
		MX_TotalLF:Hide();
	end

	-- Add Runes of teleportation to tooltip
	if(MXReagent[MXREAGENT_ROT].alwaysDisplay or Reagent[MXREAGENT_ROT].display) then

		MX_TotalROT:SetPoint(rpoint, "MX_Title", rpoint, 0, ypos);

		height = height + 15;
		ypos = ypos - 15;

		if(Reagent[MXREAGENT_ROT].count > MXReagent[MXREAGENT_ROT].threshold) then
			MX_TotalROT:SetText(Reagent[MXREAGENT_ROT].tag..": |cffffffff"..Reagent[MXREAGENT_ROT].count.."|r");
		else
			MX_TotalROT:SetText(Reagent[MXREAGENT_ROT].tag..": |cffff0000"..Reagent[MXREAGENT_ROT].count.."|r");
		end
		MX_TotalROT:Show();
	else
		MX_TotalROT:Hide();
	end

	-- Add Runes of Portals to tooltip
	if(MXReagent[MXREAGENT_ROP].alwaysDisplay or Reagent[MXREAGENT_ROP].display) then

		MX_TotalROP:SetPoint(rpoint, "MX_Title", rpoint, 0, ypos);

		height = height + 15;
		ypos = ypos - 15;

		if(Reagent[MXREAGENT_ROP].count > MXReagent[MXREAGENT_ROP].threshold) then
			MX_TotalROP:SetText(Reagent[MXREAGENT_ROP].tag..": |cffffffff"..Reagent[MXREAGENT_ROP].count.."|r");
		else
			MX_TotalROP:SetText(Reagent[MXREAGENT_ROP].tag..": |cffff0000"..Reagent[MXREAGENT_ROP].count.."|r");
		end

		MX_TotalROP:Show();
	else
		MX_TotalROP:Hide();
	end

	-- Add Arcane Powder to tooltip
	if(MXReagent[MXREAGENT_AP].alwaysDisplay or Reagent[MXREAGENT_AP].display) then

		MX_TotalAP:SetPoint(rpoint, "MX_Title", rpoint, 0, ypos);

		height = height + 15;
		ypos = ypos - 15;

		if(Reagent[MXREAGENT_AP].count > MXReagent[MXREAGENT_AP].threshold) then
			MX_TotalAP:SetText(Reagent[MXREAGENT_AP].tag..": |cffffffff"..Reagent[MXREAGENT_AP].count.."|r");
		else
			MX_TotalAP:SetText(Reagent[MXREAGENT_AP].tag..": |cffff0000"..Reagent[MXREAGENT_AP].count.."|r");
		end

		MX_TotalAP:Show();
	else
		MX_TotalAP:Hide();
	end

	if(ypos == -15) then
		MX_MainButtonTip:SetWidth(80);
	else
		MX_MainButtonTip:SetWidth(180);
	end

	MX_MainButtonTip:SetHeight(height);
	MX_MainButtonTip:ClearAllPoints();
	MX_MainButtonTip:SetPoint(apoint, "MageXFrame", rpoint);
	MX_MainButtonTip:Show();
end


function MX_DisplayPortalButtonToolTip(name, ref)
	if(not Loaded) then return; end
	
	local apoint,rpoint = "BOTTOMLEFT","TOPLEFT";
	
	MX_PortalName:SetText("|cffffffff Teleport to "..name.."|r");

	MX_PortalButtonTip:ClearAllPoints();
	MX_PortalButtonTip:SetPoint(apoint, ref, rpoint);
	MX_PortalButtonTip:Show();
end
----------------------------------------------------------------------------------------------------------------------------------------
-- ITEM FUNCTIONS
----------------------------------------------------------------------------------------------------------------------------------------

function IsItemInContainer(bag, slot, name)
	if (GetContainerItemLink(bag,slot)) then
        if (string.find(GetContainerItemLink(bag,slot), name)) then
			return true;
		else
			return false;
        end
	else
		return false;
    end
end

----------------------------------------------------------------------------------------------------------------------------------------
-- SPELL FUNCTIONS
----------------------------------------------------------------------------------------------------------------------------------------
function MX_SelfCastSpell(name)
	if(not Loaded) then return; end
	
	if(MX.Spell[name].ID > 0) then
		SelfCastSpell(MX.Spell[name].ID);
	end
end

function MX_CastSpell(name)
	if(not Loaded) then return; end

	if(MX.Spell[name].Exists) then
		CastSpellOnFriend(MX.Spell[name].ID);
		--CastSpell(MX.Spell[name].ID, BOOKTYPE_SPELL);
	end
end

function MX_CastPortal(name, type)
	if(not Loaded) then return; end
	
	if(type == MX.PortalPrefix) then
	    	if( MX.Portal[name].Exists and (Reagent["ROP"].count > 0) ) then
            		CastSpell(MX.Portal[name].ID, BOOKTYPE_SPELL);
	    	end

	elseif(type == MX.TeleportPrefix) then
	    	if( MX.Teleport[name].Exists and (Reagent["ROT"].count > 0) ) then
            		CastSpell(MX.Teleport[name].ID, BOOKTYPE_SPELL);
	    	end
	end
end

function MX_SpellSetup()

	local i;
	
	Reagent[MXREAGENT_LF].display = false;
	Reagent[MXREAGENT_ROT].display = false;
	Reagent[MXREAGENT_ROP].display = false;
	Reagent[MXREAGENT_AP].display = false;

	for i=1,MX.SpellCount do
		MX.Spell[MX.SpellName[i]].Name	 = MX.SpellName[i];
		MX.Spell[MX.SpellName[i]].ID 	 = GetHigherRankSpellID(MX.SpellName[i]);
		MX.Spell[MX.SpellName[i]].Active = true;
		
		if(MX.Spell[MX.SpellName[i]].ID > 0) then
			MX.Spell[MX.SpellName[i]].Rank   = GetHigherSpellRank(MX.SpellName[i]);
			MX.Spell[MX.SpellName[i]].Exists = true;
			MX.Spell[MX.SpellName[i]].Texture = GetSpellTexture(MX.Spell[MX.SpellName[i]].ID, BOOKTYPE_SPELL);
			--MX_Msg(MX.SpellName[i].." = Found", "USER");
		else
			MX.Spell[MX.SpellName[i]].Rank = "";
			MX.Spell[MX.SpellName[i]].Exists = false;
			MX.Spell[MX.SpellName[i]].Texture = nil;
			--MX_Msg(MX.SpellName[i].." = NOT Found", "USER");
		end
	end

	for i=1,MX.PortalCount do
		MX.Portal[MX.PortalName[i]].Name   = MX.PortalPrefix..MX.PortalName[i];
		MX.Portal[MX.PortalName[i]].ID 	   = GetHigherRankSpellID(MX.Portal[MX.PortalName[i]].Name);
		if(MX.Portal[MX.PortalName[i]].ID > 0) then
			MX.Portal[MX.PortalName[i]].Exists = true;
			Reagent[MXREAGENT_ROP].display = true;
		else
			MX.Portal[MX.PortalName[i]].Exists = false;
		end
	end

	for i=1,MX.TeleportCount do
		MX.Teleport[MX.PortalName[i]].Name   = MX.TeleportPrefix..MX.PortalName[i];
		MX.Teleport[MX.PortalName[i]].ID 	   = GetHigherRankSpellID(MX.Teleport[MX.PortalName[i]].Name);
		if(MX.Teleport[MX.PortalName[i]].ID > 0) then
			MX.Teleport[MX.PortalName[i]].Exists = true;
			Reagent[MXREAGENT_ROT].display = true;
		else
			MX.Teleport[MX.PortalName[i]].Exists = false;
		end
	end

	Reagent[MXREAGENT_AP].display = MX.Spell[MXSPELL_ARCANE_BRILLIANCE].Exists;
	Reagent[MXREAGENT_LF].display = PlayerHasSpell("Slow Fall");

	MX_Msg(MX.MSG_SpellLoaded, "USER");
end
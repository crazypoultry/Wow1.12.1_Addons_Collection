WARRIOR = {};

-- application settings
WARRIOR._version = "0.62";
WARRIOR._erase = false;
WARRIOR._debug = -1;


-- *****************************************************************************
-- Function: OnLoad
-- Purpose: initialization code
-- *****************************************************************************
function WARRIOR:OnLoad()
	-- used to perform initialization after the mod has loaded
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	
	-- used by WARRIOR.Spells
	this:RegisterEvent("SPELLS_CHANGED");
	this:RegisterEvent("LEARNED_SPELL_IN_TAB");
	this:RegisterEvent("ACTIONBAR_SLOT_CHANGED");
	
	-- used by WARRIOR.Player for combat detection
	this:RegisterEvent("PLAYER_REGEN_ENABLED");
	this:RegisterEvent("PLAYER_REGEN_DISABLED");
	
	-- used by WARRIOR.Immunities to detect permanent and temporary immunities
	this:RegisterEvent("CHAT_MSG_SPELL_FAILED_LOCALPLAYER");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_BUFFS");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS");
	this:RegisterEvent("CHAT_MSG_SPELL_AURA_GONE_OTHER");
	this:RegisterEvent("CHAT_MSG_SPELL_BREAK_AURA");

	-- used by WARRIOR.Player to detect dodges
	this:RegisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE");
	this:RegisterEvent("CHAT_MSG_COMBAT_SELF_MISSES");
	
	-- used by WARRIOR.Player to detect player dodges/parries/block
	this:RegisterEvent("CHAT_MSG_COMBAT_CREATURE_VS_SELF_MISSES");
	
	-- used by WARRIOR.Player to detect fleeing monsters
	this:RegisterEvent("CHAT_MSG_MONSTER_EMOTE");
	
	-- used by WARRIOR.Player to identify and interrupt target casting
	this:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE")
	this:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF")
	this:RegisterEvent("CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE")
	this:RegisterEvent("CHAT_MSG_SPELL_HOSTILEPLAYER_BUFF")

	-- used by WARRIOR.Player to reset fifo classes
	this:RegisterEvent("PLAYER_TARGET_CHANGED");

	-- used by WARRIOR.Player to detect duels and overt the friendly check when casting
	this:RegisterEvent("DUEL_INBOUNDS");
	this:RegisterEvent("DUEL_FINISHED");

	-- create slash command
	SLASH_WARRIORCMD1 = "/warrior";
	SlashCmdList["WARRIORCMD"] = function(e) WARRIOR.UI:Command(e); end
end

-- *****************************************************************************
-- Function: OnEvent
-- Purpose: event handler for message loop
-- *****************************************************************************
function WARRIOR:OnEvent()
	self.Immunities:OnEvent(event,arg1);
	self.Player:OnEvent(event,arg1);
	self.Spells:OnEvent(event);
	
	-- initialize the mod
	if (event == "PLAYER_ENTERING_WORLD") then
		self.Settings:Load();
		self.Spells:Load();
		self.Actions:Activate();
		self.Keybindings:Save();
	end
end

-- *****************************************************************************
-- Function: OnUpdate
-- Purpose: update message loop
-- *****************************************************************************
function WARRIOR:OnUpdate(arg1)
	self.Alerts:OnUpdate();
	self.Player:OnUpdate();
end


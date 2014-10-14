if 1 then
	CMON_ALL_OPPONENTS = "All Opponents";
	CMON_ENVIRONMENTAL = "Environmental";
	CMON_ENABLEBUTTON = "Enable CombatMonitor";
	CMON_ENVIRONMENTBUTTON = "Track Environmental Damage";
	CMON_DUMPCHANNEL = "Dump Channel:";
	CMON_NEWMOBS = "Track all new opponents";
	CMON_NONELITE = "Track non-elite mobs";
	CMON_WORLDBOSS= "Track World Bosses only";
	CMON_SHOWDPS = "Show incoming DPS"
	CMON_DPSBANNER = "Incoming DPS";
	CMON_SHOWPERCENT = "Show percentages"
	CMON_INSTANTANEOUS = "Inst:";
	CMON_AVERAGE = "Avg:";
	CMON_PEAK = "Peak:";
	CMON_VERSION = "CombatMonitor |cff00ff00";
	CMON_OPTIONS = "Options";
	CMON_DUMP = "Dump";
	CMON_COPY = "Copy";
	CMON_DEBUG_EVENT = "Event: source = ";
	CMON_ENABLED = "CombatMonitor Enabled";
	CMON_DISABLED = "CombatMonitor Disabled";
	CMON_RESET = "CombatMonitor Reset";
	CMON_NEWPLAYER = "CombatMonitor new player: ";
	CMON_PERCENT = "%2.2f%%";
	CMON_ENABLINGPERIODIC = "CombatMontitor requires that the Periodic Damage interface option be enabled for proper operation - enabling it now.";
	CMON_MELEEHEADER = "Melee Damage"
	CMON_SPELLHEADER = "Spell Damage"
	CMON_RESET_CURRENT = "Remove Selected";
	
	CMON_ON = "on"
	CMON_OFF = "off"
	CMON_RESET = "reset";
	CMON_VER = "version";
	CMON_CENTER = "center";
	CMON_USAGE = "Usage: /combatmonitor on | off | center | reset | version";
	
	CMON_CLEARALLERR = "CombatMonitor: Cannot clear the All Opponents category";
	CMON_VERSIONERROR1 = "CombatMonitor v";
	CMON_VERSIONERROR2 = " requires all old data to be cleared - sorry!";
	CMON_UPDATING = "CombatMonitor updating to version";
	
	CMON_ENVIRONMENTTOOLTIP = "Record environmental damage taken.  This damage is never tracked in the All Opponents category";
	
	CMON_TOTALATTACKSLABEL = "Total Attacks:";
	CMON_MISSESLABEL = "Misses:";
	CMON_WOULDHITLABEL = "Would Hit:";
	CMON_DODGESLABEL = "Dodges:";
	CMON_PARRIESLABEL = "Parries:";
	CMON_BLOCKSLABEL = "Partial Blocks:";
	CMON_FULLBLOCKSLABEL = "Full Blocks:";
	CMON_DAMAGEBLOCKEDLABEL = "Damage Blocked:";
	CMON_BLOCKMITIGATIONLABEL = "Block Mitigation:";
	CMON_HITSLABEL = "Hits:";
	CMON_CRITICALHITSLABEL = "Critical Hits:";
	CMON_CRUSHINGBLOWSLABEL = "Crushing Blows:";
	CMON_PHYSICALDAMAGELABEL = "Physical:";
	CMON_AVERAGEHITLABEL = "Average Hit:"; 
	CMON_DAMAGEAVOIDEDLABEL = "Damage Avoided:";
	CMON_DOUBLECRITICALSLABEL = "Double Critcals:";
	CMON_TRIPLECRITICALSLABEL = "Triple Critcals:";
	CMON_HOLYDAMAGELABEL = "Holy:";
	CMON_FIREDAMAGELABEL = "Fire:";
	CMON_NATUREDAMAGELABEL = "Nature:";
	CMON_FROSTDAMAGELABEL = "Frost:";
	CMON_SHADOWDAMAGELABEL = "Shadow:";
	CMON_ARCANEDAMAGELABEL = "Arcane:";
	CMON_SPELLRESISTSLABEL = "Complete Resists:";
	CMON_TOTALDAMAGELABEL = "Total Damage:";
	CMON_TAKENEKEY = "Taken";
	CMON_RESISTEDKEY = "Resisted";
	CMON_HITSKEY = "Hits";
	CMON_AVERAGEKEY = "Average";
	CMON_MELEE = "|cff00ff00Melee|r";
	CMON_SPELL = "|cff00ff00Spell|r";
	
	-- Search Strings
	SEARCH_CRUSHING = "(crushing)";
	SEARCH_CRITICAL = "crits you";
	SEARCH_HIT = "(.+) hits you for (%d+)";
	SEARCH_CRIT = "(.+) crits you for (%d+)";
	SEARCH_BLOCK = "((%d+) blocked)";
	SEARCH_RESISTED = "((%d+) resisted)";
	SEARCH_ABSORB = "((%d+) absorbed)";
	SEARCH_DEFLECT = "(.+) attacks. You deflect";
	SEARCH_DODGE = "(.+) attacks. You dodge";
	SEARCH_PARRY = "(.+) attacks. You parry";
	SEARCH_FULL_BLOCK = "(.+) attacks. You block";
	SEARCH_MISS = "(.+) misses you";
	
	SEARCH_SPELL = "(.+)'s (.+) hits you for (%d+)";
	SEARCH_SPELL_FULL_ABSORB = "You absorb (.+)'s (.+)";
	SEARCH_CRIT_SPELL = "(.+)'s (.+) crits you for (%d+)";
	SEARCH_SPELL_MISS = "(.+)'s (.+) misses you";
	SEARCH_SPELL_RESIST = "(.+)'s (.+) was resisted";
	SEARCH_SPELL_DODGE = "(.+)'s (.+) was dodged";
	SEARCH_SPELL_PARRY = "(.+)'s (.+) was parried";
	SEARCH_SPELL_FULL_BLOCK = "(.+)'s (.+) was blocked";
	SEARCH_SPELL_MISS = "(.+)'s (.+) misses you";
	SEARCH_SELF_TYPE_DAMAGE = "You suffer (%d+) (.+) damage from your (.+)";
	SEARCH_PERIODIC = "You suffer (%d+) (.+) damage from (.+)'s (.+)";
	
	SEARCH_TYPE_ARCANE = "Arcane damage";
	SEARCH_TYPE_FIRE = "Fire damage";
	SEARCH_TYPE_FROST = "Frost damage";
	SEARCH_TYPE_HOLY = "Holy damage";
	SEARCH_TYPE_NATURE = "Nature damage";
	SEARCH_TYPE_SHADOW = "Shadow damage";
	
	SEARCH_TYPE_SHORT_ARCANE = "arcane";
	SEARCH_TYPE_SHORT_FIRE = "fire";
	SEARCH_TYPE_SHORT_FROST = "frost";
	SEARCH_TYPE_SHORT_HOLY = "holy";
	SEARCH_TYPE_SHORT_NATURE = "nature";
	SEARCH_TYPE_SHORT_SHADOW = "shadow";

	ENVIRONMENTAL_DROWNING = "You are drowning and lose (%d+) health";
	ENVIRONMENTAL_FALLING = "You fall and lose (%d+) health";
	ENVIRONMENTAL_FATIGUE = "You are exhausted and lose (%d+) health";
	ENVIRONMENTAL_FIRE = "You suffer (%d+) points of fire damage";
	ENVIRONMENTAL_LAVA = "You lose (%d+) health for swimming in lava";
	ENVIRONMENTAL_SLIME  = "You lose (%d+) health for swimming in slime";

	-- Not used right now, but may be at some point.  Safely ignored for localisation
	SEARCH_SELF_SPELL = "Your (.+) hits you for (%d+)";
	SEARCH_SELF_CRIT_SPELL = "Your (.+) crits you for (%d+)";
	SEARCH_SELF_SPELL_ABSORB = "Your (.+) hits you for (%d+) ((%d+) absorbed)";
	SEARCH_IMMUNE = "(.+) attacks but you are immune";
	SEARCH_DAMAGESHIELD = "(.+) reflects (%d+) (.+) damage to you.";
	SEARCH_SPELL_AFFLICTED = "You are afflicted by (.+)";
	SEARCH_SPELL_PERFORM = "(.+) performs (.+) on you";
	SEARCH_TYPE_DAMAGE = "You suffer (%d+) (.+) damage from (.+)'s (.+)";
	SEARCH_PERIODIC_ABSORB = "You suffer (%d+) (.+) damage from (.+)'s (.+) ((%d+) absorbed)";
	SEARCH_SELF_PERIODIC_ABSORB = "You suffer (%d+) (.+) damage from your (.+) ((%d+) absorbed)";
	SEARCH_SPELL_DEFLECT = "(.+)'s (.+) was deflected";
	SEARCH_SPELL_REFLECT = "You reflect (.+)'s (.+)";
	SEARCH_FULL_ABSORB = "(.+) attacks. You absorb all the damage";
	SEARCH_SPELL_DRAIN = "(.+) drains (%d+) (.+) from you";
	SEARCH_SPELL_DRAIN_BUFF = "(.+) drains (%d+) (.+) from you and gains (.+)";

	SEARCH_STRIKE = "strike"
	SEARCH_CLEAVE = "cleave"

--	CMON_MELEE_SPELLS = {
--		"slam",
--		"strike",
--		"bash",
--		"cleave",
--		"whirlwind",
--		"overpower",
--	}
end
--[[

	File containing localized strings
	for Simplified Chinese and English versions, defaults to English

]]

function SC_Localization_enUS()
	-- English localized variables (default)
	-- general

	STATCOMPARE_CAT_ATT = "States";
	STATCOMPARE_CAT_RES = "Resistance";
	STATCOMPARE_CAT_SKILL = "Skills";
	STATCOMPARE_CAT_BON = "Melee & Ranged Attack";
	STATCOMPARE_CAT_SBON = "Spells";
	STATCOMPARE_CAT_OBON = "Health & Mana";

	STATCOMPARE_ATTACKNAME = "Attack";
		
	-- bonus names --- for display usage
	STATCOMPARE_STR = "Strength";
	STATCOMPARE_AGI = "Agility";
	STATCOMPARE_STA = "Stamina";
	STATCOMPARE_INT = "Intellect";
	STATCOMPARE_SPI = "Spirit";
	STATCOMPARE_ARMOR = "Armor";
	STATCOMPARE_ENARMOR = "Reinforced Armor";
	STATCOMPARE_DAMAGEREDUCE = "Damage Reduce";

	STATCOMPARE_ARCANERES	= "Arcane Resistance";	
	STATCOMPARE_FIRERES	= "Fire Resistance";
	STATCOMPARE_NATURERES	= "Nature Resistance";
	STATCOMPARE_FROSTRES	= "Frost Resistance";
	STATCOMPARE_SHADOWRES	= "Shadow Resistance";
	STATCOMPARE_DETARRES	= "Spell Penetration";
	STATCOMPARE_ALLRES	= "All resistance";

	STATCOMPARE_FISHING	= "Fishing";
	STATCOMPARE_MINING	= "Mining";
	STATCOMPARE_HERBALISM	= "Herbalism";
	STATCOMPARE_SKINNING	= "Skinning";
	STATCOMPARE_DEFENSE	= "Defense";
		
	STATCOMPARE_BLOCK	= "Block";
	STATCOMPARE_TOBLOCK	= "Chance to block";
	STATCOMPARE_DODGE	= "Dodge";
	STATCOMPARE_PARRY	= "Parry";
	STATCOMPARE_ATTACKPOWER = "Attack Power";
	STATCOMPARE_ATTACKPOWERUNDEAD = "AP against Undead";
	STATCOMPARE_CRIT	= "Crit. hits";
	STATCOMPARE_RANGEDATTACKPOWER = "Ranged AP";
	STATCOMPARE_RANGEDCRIT	= "Crit. Shots";
	STATCOMPARE_TOHIT	= "Chance to Hit";
	STATCOMPARE_DMG		= "Spell Damage";
	STATCOMPARE_DMGUNDEAD	= "Damage against Undead";
	STATCOMPARE_ARCANEDMG	= "Arcane Damage";
	STATCOMPARE_FIREDMG	= "Fire Damage";
	STATCOMPARE_FROSTDMG	= "Frost Damage";
	STATCOMPARE_HOLYDMG	= "Holy Damage";
	STATCOMPARE_NATUREDMG	= "Nature Damage";
	STATCOMPARE_SHADOWDMG	= "Shadow Damage";
	STATCOMPARE_SPELLCRIT	= "Crit. Spell";
	STATCOMPARE_SPELLTOHIT	= "Chance to Hit with spells";
	STATCOMPARE_HEAL	= "Healing";
	STATCOMPARE_HOLYCRIT	= "Crit. Holy Spell";
	STATCOMPARE_NATURECRIT	= "Crit. Nature Spell";
	STATCOMPARE_HEALTHREG	= "Life Regeneration";
	STATCOMPARE_MANAREG	= "Mana Regeneration";
	STATCOMPARE_MANAREGSPI	= "Mana Regen. with Spirit";
	STATCOMPARE_HEALTH	= "Life";
	STATCOMPARE_MANA	= "Mana";
	STATCOMPARE_DRUID_BEAR	= "Bear Form";
	STATCOMPARE_DRUID_CAT	= "Cat Form";

	STATCOMPARE_FLASHHOLYLIGHT_HEAL	=	"Flash of Holy Light";
	STATCOMPARE_LESSER_HEALING_WAVE_HEAL = "Lesser Healing Wave";
	STATCOMPARE_CHAIN_LIGHTNING_DAM	= "Chain Lightning";
	STATCOMPARE_EARTH_SHOCK_DAM = "Earth Shock";
	STATCOMPARE_FLAME_SHOCK_DAM = "Flame Shock";
	STATCOMPARE_FROST_SHOCK_DAM = "Frost Shock";
	STATCOMPARE_LIGHTNING_BOLT_DAM = "Lighting Bolt";

	-- equip and set bonus patterns:
	STATCOMPARE_EQUIP_PREFIX = "Equip: ";
	STATCOMPARE_SET_PREFIX = "Set: ";

	STATCOMPARE_EQUIP_PATTERNS = {
		{ pattern = "+(%d+) ranged Attack Power%.", effect = "RANGEDATTACKPOWER" },
		{ pattern = "+(%d+) Stamina%.", effect = "STA" },
		{ pattern = "+(%d+) Agility%.", effect = "AGI" },
		{ pattern = "+(%d+) Strength%.", effect = "STR" },
		{ pattern = "+(%d+) Intellect%.", effect = "INT" },
		{ pattern = "+(%d+) Arcane Resistance%.", effect = "ARCANERES" },
		{ pattern = "+(%d+) Fire Resistance%.", effect = "FIRERES" },
		{ pattern = "+(%d+) Shadow Resistance%.", effect = "SHADOWRES" },
		{ pattern = "+(%d+) Nature Resistance%.", effect = "NATURERES" },
		{ pattern = "+(%d+) Frost Resistance%.", effect = "FROSTRES" },
		{ pattern = "+(%d+) Armor%.", effect = "ENARMOR"},
		{ pattern = "+(%d+) Attack Power%.", effect = "ATTACKPOWER"},
		{ pattern = "+(%d+) All Stats%.", effect = {"ARCANERES", "FIRERES", "FROSTRES", "NATURERES", "SHADOWRES"} },
		{ pattern = "Increases your chance to block attacks with a shield by (%d+)%%%.", effect = "TOBLOCK" },
		{ pattern = "Increases the block value of your shield by (%d+)%.", effect = "BLOCK" },
		{ pattern = "Increases your chance to dodge an attack by (%d+)%%%.", effect = "DODGE" },
		{ pattern = "Increases your chance to parry an attack by (%d+)%%%.", effect = "PARRY" },
		{ pattern = "Improves your chance to get a critical strike with spells by (%d+)%%%.", effect = "SPELLCRIT" },
		{ pattern = "Improves your chance to get a critical strike by (%d+)%%%.", effect = "CRIT" },
		{ pattern = "Increases damage done by Arcane spells and effects by up to (%d+)%.", effect = "ARCANEDMG" },
		{ pattern = "Increases damage done by Fire spells and effects by up to (%d+)%.", effect = "FIREDMG" },
		{ pattern = "Increases damage done by Frost spells and effects by up to (%d+)%.", effect = "FROSTDMG" },
		{ pattern = "Increases damage done by Holy spells and effects by up to (%d+)%.", effect = "HOLYDMG" },
		{ pattern = "Increases damage done by Nature spells and effects by up to (%d+)%.", effect = "NATUREDMG" },
		{ pattern = "Increases damage done by Shadow spells and effects by up to (%d+)%.", effect = "SHADOWDMG" },
		{ pattern = "Increases healing done by spells and effects by up to (%d+)%.", effect = "HEAL" },
		{ pattern = "Increases damage and healing done by magical spells and effects by up to (%d+)%.", effect = {"HEAL", "DMG"} },
		{ pattern = "Increases damage done to Undead by magical spells and effects by up to (%d+)", effect = "DMGUNDEAD" },
		{ pattern = "+(%d+) Attack Power when fighting Undead.", effect = "ATTACKPOWERUNDEAD" },
		{ pattern = "Restores (%d+) health per 5 sec%.", effect = "HEALTHREG" },
		{ pattern = "Restores (%d+) health every 5 sec%.", effect = "HEALTHREG" },
		{ pattern = "Restores (%d+) mana per 5 sec%.", effect = "MANAREG" },
		{ pattern = "Restores (%d+) mana every 5 sec%.", effect = "MANAREG" },
		{ pattern = "Improves your chance to hit by (%d+)%%%.", effect = "TOHIT" },
		{ pattern = "Improves your chance to hit with spells by (%d+)%%%.", effect = "SPELLTOHIT" },
		{ pattern = "Increased Defense +(%d+)%.", effect = "DEFENSE" },
		{ pattern = "Increases the critical effect chance of your Holy spells by (%d+)%%%.", effect = "HOLYCRIT" },
		{ pattern = "Improves your chance to get a critical strike with Holy spells by (%d+)%%%.", effect = "HOLYCRIT" },
		{ pattern = "Skinning +(%d+)%.", effect = "SKINNING" },
		{ pattern = "Increased Fishing +(%d+)%.", effect = "FISHING"},
		{ pattern = "Decreases the magical resistances of your spell targets by (%d+)%.", effect = "DETARRES" },
		{ pattern = "Improves your chance to get a critical strike with Nature spells by (%d+)%%%.", effect = "NATURECRIT" },
		{ pattern = "Increases healing done by Lesser Healing Wave by up to (%d+)%.", effect = "LESSERHEALWAVE"},
		{ pattern = "Increases damage done by Chain Lightning and Lightning Bolt by up to (%d+)%.", effect = {"CHAINLIGHTNING","LIGHTNINGBOLT"}},
		{ pattern = "Increases damage done by Earth Shock, Flame Shock, and Frost Shock by up to (%d+)%.", effect = {"EARTHSHOCK","FLAMESHOCK","FROSTSHOCK"}}, 
	};


	STATCOMPARE_S1 = {
		{ pattern = "Arcane", 	effect = "ARCANE" },	
		{ pattern = "Fire", 	effect = "FIRE" },	
		{ pattern = "Frost", 	effect = "FROST" },	
		{ pattern = "Holy", 	effect = "HOLY" },	
		{ pattern = "Shadow",	effect = "SHADOW" },
		{ pattern = "Nature", 	effect = "NATURE" }
	}; 	

	STATCOMPARE_S2 = {
		{ pattern = "Resist", 	effect = "RES" },	
		{ pattern = "Damage", 	effect = "DMG" },
		{ pattern = "Effects", 	effect = "DMG" },
	}; 	
		
	STATCOMPARE_TOKEN_EFFECT = {
		["All Stats"] 			= {"STR", "AGI", "STA", "INT", "SPI"},
		["Strength"]			= "STR",
		["Agility"]			= "AGI",
		["Stamina"]			= "STA",
		["Intellect"]			= "INT",
		["Spirit"] 			= "SPI",
		["Spell Damage"] 			= "DMG",
		["Healing and Spell Damage"]		= {"DMG", "HEAL"},
		["Damage and Healing Spells"]		= {"DMG", "HEAL"},
		["Spell Damage and Healing"]		= {"DMG", "HEAL"},

		["All Resistances"] 			= {"ARCANERES", "FIRERES", "FROSTRES", "NATURERES", "SHADOWRES"},

		["Fishing"]			= "FISHING",
		["Fishing Lure"]			= "FISHING",
		["Increased Fishing"]		= "FISHING",
		["Mining"]			= "MINING",
		["Herbalism"]			= "HERBALISM",
		["Skinning"]			= "SKINNING",

		["Attack Power"] 			= "ATTACKPOWER",
		["Dodge"] 			= "DODGE",
		["Block"]			= "BLOCK",
		["Blocking"]			= "BLOCK",
		["Hit"] 			= "TOHIT",
		["Spell Hit"]			= "SPELLTOHIT",
		["Ranged Attack Power"]		= "RANGEDATTACKPOWER",
		["health every 5 sec"]		= "HEALTHREG",
		["Healing Spells"] 		= "HEAL",
		["Increases Healing"] 		= "HEAL",
		["mana every 5 sec"] 		= "MANAREG",
		["Mana Regen"]			= "MANAREG",
		["Damage"] 				= "DMG",
		["Critical"]			= "CRIT",
		["Critical Hit"] 		= "CRIT",
		["Health"]			= "HEALTH",
		["HP"]				= "HEALTH",
		["Mana"]			= "MANA",
		["Armor"]			= "ENARMOR",
		["Reinforced Armor"]			= "ENARMOR",
		["Defense"]			= "DEFENSE",
		["Increased Defense"]		= "DEFENSE",
	};

	STATCOMPARE_OTHER_PATTERNS = {
		{ pattern = "(%d+) Block", effect = "BLOCK"},
		{ pattern = "(%d+) Armor", effect = "ARMOR"},
		{ pattern = "Health Regen (%d+) per 5 sec%.", effect = "HEALTHREG" },
		{ pattern = "Health Regen (%d+) every 5 sec%.", effect = "HEALTHREG" },
		{ pattern = "Mana Regen (%d+) per 5 sec%.", effect = "MANAREG" },
		{ pattern = "Mana Regen (%d+) every 5 sec%.", effect = "MANAREG" },
		{ pattern = "Minor Wizard Oil", effect = "DMG", value = 8 },
		{ pattern = "Lesser Wizard Oil", effect = "DMG", value = 16 },
		{ pattern = "Wizard Oil", effect = "DMG", value = 24 },
		{ pattern = "Brilliant Wizard Oil", effect = {"DMG", "SPELLCRIT"}, value = {36, 1} },
		{ pattern = "Minor Mana Oil", effect = "MANAREG", value = 4 },
		{ pattern = "Lesser Mana Oil", effect = "MANAREG", value = 8 },
		{ pattern = "Brilliant Mana Oil", effect = { "MANAREG", "HEAL"}, value = {12, 25} },
		{ pattern = "Eternium Line", effect = "FISHING", value = 5 },
	};

	-- Spells Related
	STATCOMPARE_HEALSPELL_PREFIX	= "Healing Spells";
	STATCOMPARE_ATTACKSPELL_PREFIX	= "Damage Spells";
	STATCOMPARE_SPELLSKILL_INFO	= "Spells/Skills";
	STATCOMPARE_DOT_PREFIX		= " DOT";
	STATCOMPARE_HOT_PREFIX		= " HOT";
	STATCOMPARE_HEALIN_TOUCH	= "Healing Touch";
	STATCOMPARE_REGROWTH		= "Regrowth";
	STATCOMPARE_REJUVENATION	= "Rejuvenation";
	STATCOMPARE_TRANQUILITY		= "Tranquility";
	STATCOMPARE_WRATH		= "Wrath";
	STATCOMPARE_STARFIRE		= "StarFire";
	STATCOMPARE_MOONFIRE		= "MoonFire";
	STATCOMPARE_INSECTSWARM		= "Insect Swarm";
	STATCOMPARE_LESSER_HEAL		= "Lesser Heal";
	STATCOMPARE_HEAL		= "Heal";
	STATCOMPARE_SPELL_HOLYFIRE	= "Holy Fire";
	STATCOMPARE_SPELL_HOLYNOVA	= "Holy Nova";
	STATCOMPARE_SPELL_MANABURN	= "Mana Burn";
	STATCOMPARE_SPELL_SMITE		= "Smite";
	STATCOMPARE_SPELL_PAIN		= "Pain";
	STATCOMPARE_SPELL_MINDBLAST	= "Mind Blast";
	STATCOMPARE_SPELL_MINDFLAY	= "Mind Flay";
	STATCOMPARE_FLASH_HEAL		= "Flash Heal";
	STATCOMPARE_GREATER_HEAL	= "Greater Heal";
	STATCOMPARE_RENEW		= "Renew";
	STATCOMPARE_PRAYER_OF_HEALING	= "Prayer of Healing";
	STATCOMPARE_HEALING_WAVE	= "Healing Wave";
	STATCOMPARE_LESSER_HEALING_WAVE = "Lesser Healing Wave";
	STATCOMPARE_CHAIN_HEAL		= "Chain Heal";
	STATCOMPARE_CHAIN_LIGHTNING	= "Chain Lightning";
	STATCOMPARE_EARTH_SHOCK		= "Earth Shock";
	STATCOMPARE_FLAME_SHOCK		= "Flame Shock";
	STATCOMPARE_FROST_SHOCK		= "Frost Shock";
	STATCOMPARE_LIGHTNING_BOLT	= "Lightning Bolt";
	STATCOMPARE_HOLY_LIGHT		= "Holy Light";
	STATCOMPARE_HOLY_SHOCK		= "Holy Shock";
	STATCOMPARE_HOLY_WRATH		= "Holy Wrath";
	STATCOMPARE_FLASH_OF_LIGHT	= "Flash of Light";
	STATCOMPARE_CONSECRATION	= "Consecration";
	STATCOMPARE_EXORCISM		= "Exorcism";
	STATCOMPARE_HAMMER_OF_WRATH	= "Hammer of Wrath";
	STATCOMPARE_ARCANEEXPLOSION	= "Arcane Explosion";
	STATCOMPARE_ARCANEMISSILES	= "Arcane Missiles";
	STATCOMPARE_BLASTWAVE		= "Blast Wave";
	STATCOMPARE_BLIZZARD		= "Blizzard";
	STATCOMPARE_CONECOLD		= "Conecold";
	STATCOMPARE_FIREBALL		= "Fireball";
	STATCOMPARE_FIREBLAST		= "Fireblast";
	STATCOMPARE_FROSTBOLT		= "Frost Bolt";
	STATCOMPARE_PYROBLAST		= "Pyroblast";
	STATCOMPARE_SCORCH		= "Scorch";
	STATCOMPARE_SRCANE_SHOT		= "Srcane Shot";
	STATCOMPARE_EXPLOSIVE_TRAP	= "Explosive Trap";
	STATCOMPARE_IMMOLATION_TRAP	= "Immolation Trap";
	STATCOMPARE_SERPENT_STING	= "Serpent Sting";
	STATCOMPARE_VOLLEY		= "Volley";
	STATCOMPARE_WYVERN_STING	= "";
	STATCOMPARE_CONFLAGRATE		= "Conflagrate";
	STATCOMPARE_CORRUPTION		= "Corruption";
	STATCOMPARE_CURSE_OF_AGONY	= "Curse of Agony";
	STATCOMPARE_DRAIN_LIFE		= "Drain Life";
	STATCOMPARE_DRAIN_SOUL		= "Drain Soul";
	STATCOMPARE_DEATH_COIL		= "Death Coil";
	STATCOMPARE_HELLFIRE		= "Hellfire";
	STATCOMPARE_IMMOLATE		= "Immolate";
	STATCOMPARE_RAIN_OF_FIRE	= "Rain of Fire";
	STATCOMPARE_SEARING_PAIN	= "Searing Pain";
	STATCOMPARE_SIPHON_LIFE		= "Siphon Life";
	STATCOMPARE_SHADOW_BOLT		= "Shadow Bolt";
	STATCOMPARE_SHADOWBURN		= "Shadow Burn";
	STATCOMPARE_SOUL_FIRE		= "Soul Fire";
end
-- Version : English

BINDING_HEADER_SHARDTRACKERHEADER       = "ShardTracker";
BINDING_NAME_SHARDTRACKER               = "ShardTracker Toggle";

SHARDTRACKER_CONFIG_HEADER              = "ShardTracker";
SHARDTRACKER_CONFIG_HEADER_INFO         = "ShardTracker allows Warlocks to keep track of various aspects about their shards and stones via small buttons attached to the minimap.";
SHARDTRACKER_CONFIG_ENABLED             = "Enable ShardTracker";
SHARDTRACKER_CONFIG_ENABLED_INFO        = "Enable or disable the plugin.";
SHARDTRACKER_CONFIG_FLASH_HEALTH        = "Flash Healthstone Icon";
SHARDTRACKER_CONFIG_FLASH_HEALTH_INFO   = "Flash the Healthstone icon when there is no Healthstone in your inventory.";
SHARDTRACKER_CONFIG_SOUND               = "Enable alert sounds";
SHARDTRACKER_CONFIG_SOUND_INFO          = "Play sounds when a Soulstone cooldown expires and when party members need new Healthstones.";

-- Messages used to sync healthstone status
SHARDTRACKER_GOT_HEALTHSTONE_MSG            = "received a HealthStone!";
SHARDTRACKER_NEED_HEALTHSTONE_MSG           = "needs a new HealthStone!";
SHARDTRACKER_REQUEST_HEALTHSTONE_STATUS_MSG = "ShardTracker is requesting a sync update.";
SHARDTRACKER_SYNC_HEALTHSTONE_YES_MSG       = "has a Healthstone.";
SHARDTRACKER_SYNC_HEALTHSTONE_NO_MSG        = "does not have a Healthstone.";
SHARDTRACKER_CHAT_PREFIX                    = "<ST>";

SHARDTRACKER_SHARDBUTTON_TIP1           = "Shard Count";
SHARDTRACKER_HEALTHBUTTON_TIP1          = "Healthstones/Summoner";
SHARDTRACKER_SOULBUTTON_TIP1            = "Soulstone/Mount";
SHARDTRACKER_SPELLBUTTON_TIP1           = "Spellstone/Firestone";

BINDING_HEADER_SHARDTRACKER             = "Shard Tracker";
BINDING_NAME_DOSHARDTRACKERSORT         = "Sort Shards";
BINDING_NAME_DOSHARDTRACKERHEALTH       = "Use Healthstone";
BINDING_NAME_DOSHARDTRACKERSOUL         = "Use Soulstone";
BINDING_NAME_DOSHARDTRACKERMOUNT		= "Summon Mount";
BINDING_NAME_DOSHARDTRACKERSPELL        = "Use Spellstone";
BINDING_NAME_DOSHARDTRACKERFIRE			= "Use Firestone";
SHARDTRACKERSORT_SORTING                = "ShardTracker is Sorting";

SHARDTRACKER_SOULSTONEREZ				= "Soulstone Resurrection";
SHARDTRACKER_SOULSHARD					= "Soul Shard";
SHARDTRACKER_COOLDOWNREMAINING			= "Cooldown remaining";
SHARDTRACKER_COOLDOWNFINISHED			= "SOULSTONE cooldown is over";
SHARDTRACKER_WARLOCK					= "Warlock";

-- Healthstone creation
SHARDTRACKER_HEALTHSTONE				= "Healthstone";
SHARDTRACKER_CREATEHEALTHSTONEMINOR		= "Create Healthstone (Minor)";
SHARDTRACKER_CREATEHEALTHSTONELESSER	= "Create Healthstone (Lesser)";
SHARDTRACKER_CREATEHEALTHSTONE			= "Create Healthstone";
SHARDTRACKER_CREATEHEALTHSTONEGREATER	= "Create Healthstone (Greater)";
SHARDTRACKER_CREATEHEALTHSTONEMAJOR		= "Create Healthstone (Major)";

-- Soulstone creation
SHARDTRACKER_SOULSTONE					= "Soulstone";
SHARDTRACKER_CREATESOULSTONEMINOR		= "Create Soulstone (Minor)";
SHARDTRACKER_CREATESOULSTONELESSER		= "Create Soulstone (Lesser)";
SHARDTRACKER_CREATESOULSTONE			= "Create Soulstone";
SHARDTRACKER_CREATESOULSTONEGREATER		= "Create Soulstone (Greater)";
SHARDTRACKER_CREATESOULSTONEMAJOR		= "Create Soulstone (Major)";

-- Spellstone creation
SHARDTRACKER_SPELLSTONE					= "Spellstone";
SHARDTRACKER_CREATESPELLSTONE			= "Create Spellstone";
SHARDTRACKER_CREATESPELLSTONEGREATER	= "Create Spellstone (Greater)";
SHARDTRACKER_CREATESPELLSTONEMAJOR		= "Create Spellstone (Major)";

-- Firestone creation
SHARDTRACKER_FIRESTONE					= "Firestone";
SHARDTRACKER_CREATEFIRESTONELESSER		= "Create Firestone (Lesser)";
SHARDTRACKER_CREATEFIRESTONE			= "Create Firestone";
SHARDTRACKER_CREATEFIRESTONEGREATER		= "Create Firestone (Greater)";
SHARDTRACKER_CREATEFIRESTONEMAJOR		= "Create Firestone (Major)";

-- Steed summon
SHARDTRACKER_STEED						= "steed";
SHARDTRACKER_SUMMONFELSTEED				= "Summon Felsteed";
SHARDTRACKER_SUMMONDREADSTEED			= "Summon Dreadsteed";

-- Spells
SHARDTRACKER_SUMMONIMP					= "Summon Imp"
SHARDTRACKER_SUMMONVOIDWALKER			= "Summon Voidwalker"
SHARDTRACKER_SUMMONSUCCUBUS				= "Summon Succubus"
SHARDTRACKER_SUMMONFELHUNTER			= "Summon Felhunter"
SHARDTRACKER_INFERNO					= "Inferno"
SHARDTRACKER_CURSEOFDOOM				= "Curse of Doom"
SHARDTRACKER_RITUALOFDOOM				= "Ritual of Doom"
SHARDTRACKER_ENSLAVEDEMON				= "Enslave Demon"
SHARDTRACKER_CURSEOFSHADOW				= "Curse of Shadow"
SHARDTRACKER_FELDOMINATION				= "Fel Domination"
SHARDTRACKER_RITUALOFSUMMONING			= "Ritual of Summoning"
SHARDTRACKER_EYEOFKILROG				= "Eye of Kilrog"
SHARDTRACKER_BANISH						= "Banish"
SHARDTRACKER_SENSEDEMONS					= "Sense Demons"
SHARDTRACKER_DEMONICSACRIFICE					= "Demonic Sacrifice"
SHARDTRACKER_SOULLINK					= "Soul Link"

SpellList = {
	["Fear"] = {Name = "Fear",SName = "Fear",Time = 20},
	["Howl of Terror"] = {Name = "Howl of Terror",SName = "HoT",Time = 15},
	["Curse of Agony"] = {Name = "Curse of Agony",SName = "CoA",Time = 24},
	["Corruption"] = {Name = "Corruption",SName = "Corr.",Time = 18},
	["Immolate"] = {Name = "Immolate",SName = "Imm.",Time= 15},
	["Curse of Exhaustion"] = {Name = "Curse of Exhaustion",SName = "CoEx",Time = 12},
	["Curse of the Elements"] = {Name = "Curse of the Elements",SName = "CoE",Time = 300},
	["Curse of Recklessness"] = {Name = "Curse of Recklessness",SName = "CoR",Time = 120},
	["Curse of Shadow"] = {Name = "Curse of Shadow",SName = "CoS",Time = 300},
	["Curse of Tongues"] = {Name = "Curse of Tongues",SName = "CoT",Time = 30},
	["Curse of Weakness"] = {Name = "Curse of Weakness",SName = "CoW",Time = 120},
	["Banish"] = {Name = "Banish",SName = "Ban.",Time = 30},
	["Enslave Demon"] = {Name = "Enslave Demon",SName = "Slave",Time = 300},
	["Inferno"] = {Name = "Inferno",SName = "Inferno",Time = 0},
	["Curse of Doom"] = {Name = "Curse of Doom",SName = "CoD",Time = 60},
	["Sacrificial Shield"] = {Name = "Sacrificial Shield",SName = "Sacc.",Time = 30},
	["Siphon Life"] = {Name = "Siphon Life",SName = "S. Life",Time = 30}
}

SHARDTRACKER_TARGETSOULSTONED			= "has been Soulstoned."
SHARDTRACKER_TARGETSUMMONED				= "Summoning --> %T."
SHARDTRACKER_TARGETSUMMONED2				= "Summoning =>target<=."
SHARDTRACKER_NEEDHEALTHSTONE			= " needs another Healthstone"

SHARDTRACKER_DRAGERROR                  = "To reposition the ShardTracker buttons, you must first unlock them with the \"/st unlock\" command.";

SHARDTRACKER_DEMONBUFF					= "Demon"
SHARDTRACKER_DEMONBUFF1					= "Demon Skin Rank 1"
SHARDTRACKER_DEMONBUFF2					= "Demon Skin Rank 2"
SHARDTRACKER_DEMONBUFF3					= "Demon Armor Rank 1"
SHARDTRACKER_DEMONBUFF4					= "Demon Armor Rank 2"
SHARDTRACKER_DEMONBUFF5					= "Demon Armor Rank 3"
SHARDTRACKER_DEMONBUFF6					= "Demon Armor Rank 4"
SHARDTRACKER_DEMONBUFF7					= "Demon Armor Rank 5"
BINDING_NAME_DOSHARDTRACKERBUFF         = "Cast demonic buff";
BINDING_NAME_DOSHARDTRACKERSUMMONER		= "Open Summoner Menu";

-- New in 2.32
SHARDTRACKER_USEHEALTHSTONE				= "Don't forget your healthstone"
SHARDTRACKER_SHADOWTRANCE				= "Spell_Shadow_Twilight" -- "Shadow Trance"
SHARDTRACKER_ENTEREDSHADOWTRANCE		= "You have entered a shadow trance state"
SHARDTRACKER_FEIGNDEATH					= "Feign Death"

-- New in 2.33
SHARDTRACKER_CURSE 						= "Curse"

-- New in 2.34
SHARDTRACKER_LASTSOULSTONE				= " soulstoned last, type in /st soul to target them"

-- Check client language
if ( GetLocale() == "frFR" ) then

    BINDING_HEADER_SHARDTRACKERHEADER       = "ShardTracker";
    BINDING_NAME_SHARDTRACKER               = "ShardTracker Toggle";

    SHARDTRACKER_CONFIG_HEADER              = "ShardTracker";
    SHARDTRACKER_CONFIG_HEADER_INFO         = "ShardTracker Permet aux d\195\169monistes de garder un oeil sur leurs diff\195\169rentes pierres et leurs fragments d'\195\162me via de petits boutons attach\195\169s a la minimap.";
    SHARDTRACKER_CONFIG_ENABLED             = "Activer ShardTracker";
    SHARDTRACKER_CONFIG_ENABLED_INFO        = "Activer ou Desactiver le plugin.";
    SHARDTRACKER_CONFIG_FLASH_HEALTH        = "Fait clignoter l'icone de pierre de soin.";
    SHARDTRACKER_CONFIG_FLASH_HEALTH_INFO   = "Fait clignoter l'icone de pierre de soin quand vous n'en avez pas dans votre inventaire.";
    SHARDTRACKER_CONFIG_SOUND               = "Activer les sons d'alerte.";
    SHARDTRACKER_CONFIG_SOUND_INFO          = "Lance un son quand une pierre d'\195\162me a expir\195\169e et quand un membre du groupe a besoin d'une autre pierre de soin.";

    -- Messages used to sync healthstone status
    SHARDTRACKER_GOT_HEALTHSTONE_MSG            = "re\195\167ois une pierre de soin!";
    SHARDTRACKER_NEED_HEALTHSTONE_MSG           = "a besoin d'une pierre de soin!";
    SHARDTRACKER_REQUEST_HEALTHSTONE_STATUS_MSG = "ShardTracker n\195\169c\195\169ssite une re-synchronisation.";
    SHARDTRACKER_SYNC_HEALTHSTONE_YES_MSG       = "a une pierre de soin.";
    SHARDTRACKER_SYNC_HEALTHSTONE_NO_MSG        = "n'a pas de pierre de soin.";
    SHARDTRACKER_CHAT_PREFIX                    = "<ST>";

    -- tooltip text
    SHARDTRACKER_SHARDBUTTON_TIP1           = "Compteur des fragments d'\195\162me";
    SHARDTRACKER_HEALTHBUTTON_TIP1          = "Pierre de soin/Invocation";
    SHARDTRACKER_SOULBUTTON_TIP1            = "Pierre d'\195\162me/Monture";
    SHARDTRACKER_SPELLBUTTON_TIP1           = "Pierre de sort/Pierre de feu";

    BINDING_HEADER_SHARDTRACKER             = "Shard Tracker";
    BINDING_NAME_DOSHARDTRACKERSORT         = "Tri les fragments";
    BINDING_NAME_DOSHARDTRACKERHEALTH       = "Utilise la pierre de soin";
    BINDING_NAME_DOSHARDTRACKERSOUL         = "Utilise la pierre d'\195\162me";
    BINDING_NAME_DOSHARDTRACKERMOUNT        = "Invoque la monture";
    BINDING_NAME_DOSHARDTRACKERSPELL        = "Utilise la pierre de sort";
    BINDING_NAME_DOSHARDTRACKERFIRE         = "Utilise la pierre de feu";
    SHARDTRACKERSORT_SORTING                = "Tri en cours...";

    SHARDTRACKER_SOULSTONEREZ               = "R\195\169surrection de Pierre d'\195\162me";
    SHARDTRACKER_SOULSHARD                  = "Fragment d'\195\162me";
    SHARDTRACKER_COOLDOWNREMAINING          = "Temps de recharge";
    SHARDTRACKER_COOLDOWNFINISHED           = "Temps de recharge de la Pierre d'\195\162me termin\195\169";
    SHARDTRACKER_WARLOCK                    = "D\195\169moniste";

    -- Healthstone creation
    SHARDTRACKER_HEALTHSTONE                = "Pierre de soins";
    SHARDTRACKER_CREATEHEALTHSTONEMINOR     = "Cr\195\169ation de Pierre de soins (mineure)";
    SHARDTRACKER_CREATEHEALTHSTONELESSER    = "Cr\195\169ation de Pierre de soins (inf\195\169rieure)";
    SHARDTRACKER_CREATEHEALTHSTONE          = "Cr\195\169ation de Pierre de soins";
    SHARDTRACKER_CREATEHEALTHSTONEGREATER   = "Cr\195\169ation de Pierre de soins (sup\195\169rieure)";
    SHARDTRACKER_CREATEHEALTHSTONEMAJOR     = "Cr\195\169ation de Pierre de soins (majeure)";

    -- Soulstone creation
    SHARDTRACKER_SOULSTONE                  = "Pierre d'\195\162me";
    SHARDTRACKER_CREATESOULSTONEMINOR       = "Cr\195\169ation de Pierre d'\195\162me (mineure)";
    SHARDTRACKER_CREATESOULSTONELESSER      = "Cr\195\169ation de Pierre d'\195\162me (inf\195\169rieure)";
    SHARDTRACKER_CREATESOULSTONE            = "Cr\195\169ation de Pierre d'\195\162me";
    SHARDTRACKER_CREATESOULSTONEGREATER     = "Cr\195\169ation de Pierre d'\195\162me (sup\195\169rieure)";
    SHARDTRACKER_CREATESOULSTONEMAJOR       = "Cr\195\169ation de Pierre d'\195\162me (majeure)";

    -- Spellstone creation
    SHARDTRACKER_SPELLSTONE                 = "Pierre de sort";
    SHARDTRACKER_CREATESPELLSTONE           = "Cr\195\169ation de Pierre de sort";
    SHARDTRACKER_CREATESPELLSTONEGREATER    = "Cr\195\169ation de Pierre de sort (sup\195\169rieure)";
    SHARDTRACKER_CREATESPELLSTONEMAJOR      = "Cr\195\169ation de Pierre de sort(majeure)";

    -- Firestone creation
    SHARDTRACKER_FIRESTONE                  = "Pierre de feu";
    SHARDTRACKER_CREATEFIRESTONELESSER      = "Cr\195\169ation de Pierre de feu (inf\195\169rieure)";
    SHARDTRACKER_CREATEFIRESTONE            = "Cr\195\169ation de Pierre de feu";
    SHARDTRACKER_CREATEFIRESTONEGREATER     = "Cr\195\169ation de Pierre de feu (sup\195\169rieure)";
    SHARDTRACKER_CREATEFIRESTONEMAJOR       = "Cr\195\169ation de Pierre de feu (majeure)";

    -- Steed summon
    SHARDTRACKER_STEED                      = "Palefroi";
    SHARDTRACKER_SUMMONFELSTEED             = "Invoquer un Palefroi corrompu";
    SHARDTRACKER_SUMMONDREADSTEED           = "Invoquer un Destrier de l'Effroi";
    
    -- Spells
--    SHARDTRACKER_SUMMONIMP                  = "Invoquer un diablotin"
--    SHARDTRACKER_SUMMONVOIDWALKER           = "Invoquer un Marcheur \195\169th\195\169r\195\169"
--    SHARDTRACKER_SUMMONSUCCUBUS             = "Invoquer une Succube"
--    SHARDTRACKER_SUMMONFELHUNTER            = "Invoquer un Chasseur"
--    SHARDTRACKER_INFERNO                    = "Infernal"
--    SHARDTRACKER_CURSEOFDOOM                = "Mal\195\169diction funeste"
--    SHARDTRACKER_RITUALOFDOOM               = "Rituel de Mal\195\169diction"
--    SHARDTRACKER_ENSLAVEDEMON               = "Asservir d\195\169mon"
--    SHARDTRACKER_CURSEOFSHADOW              = "Mal\195\169diction des T\195\169n\195\168bres"
--    SHARDTRACKER_FELDOMINATION              = "Domination corrompue"
--    SHARDTRACKER_RITUALOFSUMMONING          = "Rituel d'invocation"
--    SHARDTRACKER_EYEOFKILROG                = "Oeil de Kilrogg"
--    SHARDTRACKER_BANISH                     = "Bannir"


SHARDTRACKER_SUMMONIMP = "Invocation d'un diablotin";
SHARDTRACKER_SUMMONVOIDWALKER = "Invocation d'un marcheur du Vide";
SHARDTRACKER_SUMMONSUCCUBUS = "Invocation d'une succube";
SHARDTRACKER_SUMMONFELHUNTER = "Invocation d'un chasseur corrompu";
SHARDTRACKER_INFERNO = "Inferno";
SHARDTRACKER_CURSEOFDOOM = "Mal\195\169diction funeste";
SHARDTRACKER_RITUALOFDOOM = "Rituel de Mal\195\169diction";
SHARDTRACKER_ENSLAVEDEMON = "Asservir d\195\169mon";
SHARDTRACKER_CURSEOFSHADOW = "Mal\195\169diction des T\195\169n\195\168bres";
SHARDTRACKER_FELDOMINATION = "Domination corrompue";
SHARDTRACKER_RITUALOFSUMMONING = "Rituel d'invocation";
SHARDTRACKER_EYEOFKILROG = "Oeil de Kilrogg";
SHARDTRACKER_BANISH = "Bannir";



    SpellList = {
        ["Peur"] = {Name = "Peur",SName = "",Time = 20},
        ["Hurlement de terreur"] = {Name = "Hurlement de terreur",SName = "",Time = 15},
        ["Mal\195\169diction d'agonie"] = {Name = "Mal\195\169diction d'agonie",SName = "",Time = 24},
        ["Corruption"] = {Name = "Corruption",SName = "",Time = 18},
        ["Immolation"] = {Name = "Immolation",SName = "",Time= 15},
        ["Mal\195\169diction de fatigue"] = {Name = "Mal\195\169diction de fatigue",SName = "",Time = 12},
        ["Mal\195\169diction des El\195\169ments"] = {Name = "Mal\195\169diction des El\195\169ments",SName = "",Time = 300},
        ["Mal\195\169diction de T\195\169m\195\169rit\195\169"] = {Name = "Mal\195\169diction de T\195\169m\195\169rit\195\169",SName = "",Time = 120},
        ["Mal\195\169diction de l'ombre"] = {Name = "Mal\195\169diction de l'ombre",SName = "",Time = 300},
        ["Mal\195\169diction des langages"] = {Name = "Mal\195\169diction des langages",SName = "",Time = 30},
        ["Mal\195\169diction de faiblesse"] = {Name = "Mal\195\169diction de faiblesse",SName = "",Time = 120},
        ["Bannir"] = {Name = "Bannir",SName = "",Time = 30},
        ["Asservir d\195\169mon"] = {Name = "Asservir d\195\169mon",SName = "",Time = 300},
        ["Infernal"] = {Name = "Infernal",SName = "",Time = 300},
        ["Mal\195\169diction funeste"] = {Name = "Mal\195\169diction funeste",SName = "",Time = 60},
        ["Sacrifice"] = {Name = "Sacrifice",SName = "",Time = 30},
	  ["Siphon Life"] = {Name = "Siphon Life",SName = "S. Life",Time = 30}
    }

    SHARDTRACKER_TARGETSOULSTONED           = "est prot\195\169g\195\169 par une Pierre d'\195\162me."
    SHARDTRACKER_TARGETSUMMONED             = "%T est invoqu\195\169, deux personnes doivent effectuer un clic-droit sur le portail et ne pas bouger jusqu'a sa disparition."
    SHARDTRACKER_NEEDHEALTHSTONE            = " a besoin d'une autre Pierre de soin."
    
    SHARDTRACKER_DRAGERROR                  = "Pour repositionner les boutons de ShardTracker, vous devez pr\195\169alablement les d\195\169bloquer avec la commande \"/st unlock\"";

    SHARDTRACKER_DEMONBUFF                  = "d\195\169mon"
    SHARDTRACKER_DEMONBUFF1                 = "Peau de d\195\169mon (Rang 1)"
    SHARDTRACKER_DEMONBUFF2                 = "Peau de d\195\169mon (Rang 2)"
    SHARDTRACKER_DEMONBUFF3                 = "Armure d\195\169moniaque (Rang 1)"
    SHARDTRACKER_DEMONBUFF4                 = "Armure d\195\169moniaque (Rang 2)"
    SHARDTRACKER_DEMONBUFF5                 = "Armure d\195\169moniaque (Rang 3)"
    SHARDTRACKER_DEMONBUFF6                 = "Armure d\195\169moniaque (Rang 4)"
    SHARDTRACKER_DEMONBUFF7                 = "Armure d\195\169moniaque (Rang 5)"
    BINDING_NAME_DOSHARDTRACKERBUFF         = "Lance une am\195\169lioration d\195\169moniaque";
    BINDING_NAME_DOSHARDTRACKERSUMMONER     = "Ouvre le menu d'invocation";

	-- New in 2.32
	SHARDTRACKER_USEHEALTHSTONE             = "N'oubliez pas votre Pierre de soin"
    SHARDTRACKER_SHADOWTRANCE               = "Spell_Shadow_Twilight" -- "Transe de l'ombre"
    SHARDTRACKER_ENTEREDSHADOWTRANCE        = "Vous obtenez la Transe de l'ombre"    


	-- New in 2.33
	SHARDTRACKER_CURSE 						= "Mal\195\169diction"

	-- New in 2.34
	SHARDTRACKER_LASTSOULSTONE				= " was who you last soulstoned, type in /st soul to target them"
end

if ( GetLocale() == "deDE" ) then

	BINDING_HEADER_SHARDTRACKERHEADER       = "ShardTracker";
	BINDING_NAME_SHARDTRACKER               = "ShardTracker Toggle";
	
	SHARDTRACKER_CONFIG_HEADER              = "ShardTracker";
	SHARDTRACKER_CONFIG_HEADER_INFO         = "ShardTracker allows Warlocks to keep track of various aspects about their shards and stones via small buttons attached to the minimap.";
	SHARDTRACKER_CONFIG_ENABLED             = "Enable ShardTracker";
	SHARDTRACKER_CONFIG_ENABLED_INFO        = "Enable or disable the plugin.";
	SHARDTRACKER_CONFIG_FLASH_HEALTH        = "Flash Healthstone Icon";
	SHARDTRACKER_CONFIG_FLASH_HEALTH_INFO   = "Flash the Healthstone icon when there is no Healthstone in your inventory.";
	SHARDTRACKER_CONFIG_SOUND               = "Enable alert sounds";
	SHARDTRACKER_CONFIG_SOUND_INFO          = "Play sounds when a Soulstone cooldown expires and when party members need new Healthstones.";
	
	-- Messages used to sync healthstone status
	SHARDTRACKER_GOT_HEALTHSTONE_MSG            = "received a HealthStone!";
	SHARDTRACKER_NEED_HEALTHSTONE_MSG           = "needs a new HealthStone!";
	SHARDTRACKER_REQUEST_HEALTHSTONE_STATUS_MSG = "ShardTracker is requesting a sync update.";
	SHARDTRACKER_SYNC_HEALTHSTONE_YES_MSG       = "has a Healthstone.";
	SHARDTRACKER_SYNC_HEALTHSTONE_NO_MSG        = "does not have a Healthstone.";
	SHARDTRACKER_CHAT_PREFIX                    = "<ST>";

	SHARDTRACKER_SHARDBUTTON_TIP1           = "Shard Count";
	SHARDTRACKER_HEALTHBUTTON_TIP1          = "Healthstones/Summoner";
	SHARDTRACKER_SOULBUTTON_TIP1            = "Soulstone/Mount";
	SHARDTRACKER_SPELLBUTTON_TIP1           = "Spellstone/Firestone";
	
	BINDING_HEADER_SHARDTRACKER             = "Shard Tracker";
	BINDING_NAME_DOSHARDTRACKERSORT         = "Sort Shards";
	BINDING_NAME_DOSHARDTRACKERHEALTH       = "Use Healthstone";
	BINDING_NAME_DOSHARDTRACKERSOUL         = "Use Soulstone";
	BINDING_NAME_DOSHARDTRACKERMOUNT		= "Summon Mount";
	BINDING_NAME_DOSHARDTRACKERSPELL        = "Use Spellstone";
	BINDING_NAME_DOSHARDTRACKERFIRE			= "Use Firestone";
	SHARDTRACKERSORT_SORTING                = "ShardTracker is Sorting";
	
	SHARDTRACKER_SOULSTONEREZ				= "Seelenstein-Auferstehung";
	SHARDTRACKER_SOULSHARD					= "Seelensplitter";
	SHARDTRACKER_COOLDOWNREMAINING			= "Verbleibende Abklingzeit";
	SHARDTRACKER_COOLDOWNFINISHED			= "SOULSTONE cooldown is over";
	SHARDTRACKER_WARLOCK					= "Hexenmeister";

	-- Healthstone creation
	SHARDTRACKER_HEALTHSTONE				= "Gesundheitsstein";
	SHARDTRACKER_CREATEHEALTHSTONEMINOR		= "Gesundheitsstein herstellen (schwach)";
	SHARDTRACKER_CREATEHEALTHSTONELESSER	= "Gesundheitsstein herstellen (gering)";
	SHARDTRACKER_CREATEHEALTHSTONE			= "Gesundheitsstein herstellen";
	SHARDTRACKER_CREATEHEALTHSTONEGREATER	= "Gesundheitsstein herstellen (groß)";
	SHARDTRACKER_CREATEHEALTHSTONEMAJOR		= "Gesundheitsstein herstellen (erheblich)";
	
	-- Soulstone creation
	SHARDTRACKER_SOULSTONE					= "Seelenstein";
	SHARDTRACKER_CREATESOULSTONEMINOR                  = "Seelenstein herstellen (schwach)";
	SHARDTRACKER_CREATESOULSTONELESSER                 = "Seelenstein herstellen (gering)";
	SHARDTRACKER_CREATESOULSTONE                       = "Seelenstein herstellen";
	SHARDTRACKER_CREATESOULSTONEGREATER                = "Seelenstein herstellen (groß)";
	SHARDTRACKER_CREATESOULSTONEMAJOR                  = "Seelenstein herstellen (erheblich)";

	
	-- Spellstone creation
	SHARDTRACKER_SPELLSTONE					= "Zauberstein";
	SHARDTRACKER_CREATESPELLSTONE                      = "Zauberstein herstellen";
	SHARDTRACKER_CREATESPELLSTONEGREATER               = "Zauberstein herstellen (groß)";
	SHARDTRACKER_CREATESPELLSTONEMAJOR                 = "Zauberstein herstellen (erheblich)";
	
	
	-- Firestone creation
	SHARDTRACKER_FIRESTONE					= "Feuerstein";
	SHARDTRACKER_CREATEFIRESTONELESSER                 = "Feuerstein herstellen (gering)";
	SHARDTRACKER_CREATEFIRESTONE                       = "Feuerstein herstellen";
	SHARDTRACKER_CREATEFIRESTONEGREATER                = "Feuerstein herstellen (groß)";
	SHARDTRACKER_CREATEFIRESTONEMAJOR                  = "Feuerstein herstellen (erheblich)";
	
	
	-- Steed summon
	SHARDTRACKER_STEED						= "ross";
	SHARDTRACKER_SUMMONFELSTEED				= "Teufelsross beschwören";
	SHARDTRACKER_SUMMONDREADSTEED			= "Schreckensross herbeirufen";

	-- Spells
	SHARDTRACKER_SUMMONIMP					= "Wichtel beschwören"
	SHARDTRACKER_SUMMONVOIDWALKER			= "Leerwandler beschwören"
	SHARDTRACKER_SUMMONSUCCUBUS				= "Sukkubus beschwören"
	SHARDTRACKER_SUMMONFELHUNTER			= "Teufelsjäger beschwören"
	SHARDTRACKER_INFERNO					= "Inferno"
	SHARDTRACKER_CURSEOFDOOM				= "Fluch der Verdammnis"
	SHARDTRACKER_RITUALOFDOOM				= "Ritual der Verdammnis"
	SHARDTRACKER_ENSLAVEDEMON				= "Dämonensklave"
	SHARDTRACKER_CURSEOFSHADOW				= "Fluch der Schatten"
	SHARDTRACKER_FELDOMINATION				= "Teufelsbeherrschung"
	SHARDTRACKER_RITUALOFSUMMONING			= "Ritual der Beschwörung"
	SHARDTRACKER_EYEOFKILROG				= "Auge von Kilrogg"
	SHARDTRACKER_BANISH						= "Verbannen"

	SpellList = {
		["Furcht"] = {Name = "Furcht",SName = "",Time = 20},
		["Schreckgeheul"] = {Name = "Schreckgeheul",SName = "",Time = 15},
		["Fluch der Pein"] = {Name = "Fluch der Pein",SName = "",Time = 24},
		["Verderbnis"] = {Name = "Verderbnis",SName = "",Time = 18},
		["Feuerbrand"] = {Name = "Feuerbrand",SName = "",Time= 15},
		["Fluch der Erschöpfung"] = {Name = "Fluch der Erschöpfung",SName = "",Time = 12},
		["Fluch der Elemente"] = {Name = "Fluch der Elemente",SName = "",Time = 300},
		["Fluch der Tollkühnheit"] = {Name = "Fluch der Tollkühnheit",SName = "",Time = 120},
		["Schattenfluch"] = {Name = "Schattenfluch",SName = "",Time = 300},
		["Fluch der Sprachen"] = {Name = "Fluch der Sprachen",SName = "",Time = 30},
		["Fluch der Schwäche"] = {Name = "Fluch der Schwäche",SName = "",Time = 120},
		["Verbannen"] = {Name = "Verbannen",SName = "",Time = 30},
		["Dämon versklaven"] = {Name = "Dämon versklaven",SName = "",Time = 300},
		["Inferno"] = {Name = "Inferno",SName = "",Time = 0},
		["Fluch der Verdammnis"] = {Name = "Fluch der Verdammnis",SName = "",Time = 60},
		["Opferung"] = {Name = "Opferung",SName = "",Time = 30},
		["Lebensentzug"] = {Name = "Lebensentzug",SName = "",Time = 30}
	}

	SHARDTRACKER_TARGETSOULSTONED			= "has been Soulstoned."
	SHARDTRACKER_TARGETSUMMONED				= "Summoning => %T <="
	SHARDTRACKER_NEEDHEALTHSTONE			= " needs another Healthstone"
	
	SHARDTRACKER_DRAGERROR                  = "To reposition the ShardTracker buttons, you must first unlock them with the \"/st unlock\" command.";
	
	SHARDTRACKER_DEMONBUFF					= "Dämon"
	SHARDTRACKER_DEMONBUFF1					= "Dämonenhaut Rang 1"
	SHARDTRACKER_DEMONBUFF2					= "Dämonenhaut Rang 2"
	SHARDTRACKER_DEMONBUFF3					= "Dämonenrüstung Rang 1"
	SHARDTRACKER_DEMONBUFF4					= "Dämonenrüstung Rang 2"
	SHARDTRACKER_DEMONBUFF5					= "Dämonenrüstung Rang 3"
	SHARDTRACKER_DEMONBUFF6					= "Dämonenrüstung Rang 4"
	SHARDTRACKER_DEMONBUFF7					= "Dämonenrüstung Rang 5"
	BINDING_NAME_DOSHARDTRACKERBUFF         = "Cast demonic buff";
	BINDING_NAME_DOSHARDTRACKERSUMMONER		= "Open Summoner Menu";

	-- New in 2.32
	SHARDTRACKER_USEHEALTHSTONE				= "Don't forget your healthstone"
	SHARDTRACKER_SHADOWTRANCE				= "Spell_Shadow_Twilight" -- "Schattentrance"
	SHARDTRACKER_ENTEREDSHADOWTRANCE		= "You have entered a shadow trance state"

	-- New in 2.33
	SHARDTRACKER_CURSE 						= "Fluch"

	-- New in 2.34
	SHARDTRACKER_LASTSOULSTONE				= " was who you last soulstoned, type in /st soul to target them"
end


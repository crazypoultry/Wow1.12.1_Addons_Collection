-------------------------------------------------------------------------------
-- Some basic class information
-------------------------------------------------------------------------------
FFY_CLASS_DRUID   = 'DRUID';
FFY_CLASS_HUNTER  = 'HUNTER';
FFY_CLASS_MAGE    = 'MAGE';
FFY_CLASS_PALADIN = 'PALADIN';
FFY_CLASS_PRIEST  = 'PRIEST';
FFY_CLASS_ROGUE   = 'ROGUE';
FFY_CLASS_SHAMAN  = 'SHAMAN';
FFY_CLASS_WARLOCK = 'WARLOCK';
FFY_CLASS_WARRIOR = 'WARRIOR';

-------------------------------------------------------------------------------
-- Spell List: All Buffs
-------------------------------------------------------------------------------
-- Reagent Group Buffs
FFY_SPELL_PRYR_FORTITUDE    = 'Prayer of Fortitude';
FFY_SPELL_PRYR_SHADOWPROT   = 'Prayer of Shadow Protection';
FFY_SPELL_PRYR_SPIRIT       = 'Prayer of Divine Spirit';
FFY_SPELL_ARCANEBRILLIANCE  = 'Arcane Brilliance';
FFY_SPELL_GIFTWILD          = 'Gift of the Wild';

-- Spells castable on anyone
FFY_SPELL_FORTITUDE         = 'Power Word: Fortitude';
FFY_SPELL_ARCANEINT         = 'Arcane Intellect';
FFY_SPELL_MARKWILD          = 'Mark of the Wild';
FFY_SPELL_DIVINESPIRIT      = 'Divine Spirit';
FFY_SPELL_SHADOWPROT        = 'Shadow Protection';
FFY_SPELL_THORNS            = 'Thorns';
FFY_SPELL_BREATH            = 'Unending Breath';

-- Spells castable on self only
FFY_SPELL_INNERFIRE         = 'Inner Fire';
FFY_SPELL_ELUNESGRACE       = 'Elune\'s Grace';
FFY_SPELL_SHADOWGUARD       = 'Shadowguard';
FFY_SPELL_FROSTARMOR        = 'Frost Armor';
FFY_SPELL_ICEARMOR          = 'Ice Armor';
FFY_SPELL_MAGEARMOR         = 'Mage Armor';
FFY_SPELL_FIREWARD          = 'Fire Ward';
FFY_SPELL_FROSTWARD         = 'Frost Ward';
FFY_SPELL_DEMONSKIN         = 'Demon Skin';
FFY_SPELL_DEMONARMOR        = 'Demon Armor';
FFY_SPELL_BATTLESHOUT       = 'Battle Shout';

-- Paladin Blessings
FFY_BLESSING_MIGHT          = 'Blessing of Might';
FFY_BLESSING_WISDOM         = 'Blessing of Wisdom';
FFY_BLESSING_SANCTUARY      = 'Blessing of Sanctuary';
FFY_BLESSING_SALVATION      = 'Blessing of Salvation';
FFY_BLESSING_KINGS          = 'Blessing of Kings';
FFY_BLESSING_LIGHT          = 'Blessing of Light';

-- Risky spells - buffs that aren't always wanted
FFY_SPELL_AMPLIFYMAGIC      = 'Amplify Magic';
FFY_SPELL_DAMPENMAGIC       = 'Dampen Magic';

-- Rogue poisons
FFY_POISON_INSTANT          = 'Instant Poison';
FFY_POISON_CRIPPLING        = 'Crippling Poison';
FFY_POISON_DEADLY           = 'Deadly Poison';
FFY_POISON_MIND             = 'Mind-numbing Poison';
FFY_POISON_WOUND            = 'Wound Poison';

-- Weapon buff items
FFY_ITEM_WIZARDOIL          = 'Wizard Oil';
FFY_ITEM_MANAOIL            = 'Mana Oil';
FFY_ITEM_SHARPENING         = 'Sharpening Stone';
FFY_ITEM_WEIGHTSTONE        = 'Weightstone';
FFY_ITEM_NONE               = '(None)';

--   Minor Wizard Oil/Lesser Wizard Oil/Wizard Oil/Brilliant Wizard Oil/Blessed Wizard Oil
--   Lesser Mana Oil/Minor Mana Oil/Brilliant Mana Oil
--   Consecrated Sharpening Stone/Elemental Sharpening Stone/Coarse Sharpening Stone/Dense Sharpening Stone/Heavy Sharpening Stone/Rough Sharpening Stone/Solid Sharpening Stone 
--   Coarse Weightstone/Dense Weightstone/Heavy Weightstone/Rough Weightstone/Solid Weightstone 

-- This is the text used for the word 'rank'
FFY_RANK                    = 'Rank';

-------------------------------------------------------------------------------
-- English localization (Default)
-------------------------------------------------------------------------------
-- $s is spell name
-- $t is target name
-- $m is person missed name
-- $r is the rank of the spell
FFY_STARTING_BUFFS  = "Casting buffs now...";
FFY_DONE_BUFFS      = "Done casting my buffs.";
FFY_NOTHING         = "Nothing to do.";
FFY_PEOPLE_MISSED   = "Out of range: $m";
FFY_BUFF_STRING     = "Casting $s on $t.";
FFY_SPELL_FOUND     = "$s spell found!";
FFY_NO_SPELLS       = "No beneficial spells found!";
FFY_NO_SPELLS_RDY   = "Cannot cast right now.";
FFY_OUT_OF_RANGE    = "$t is out of range and cannot be buffed.";
FFY_MACRO_ERROR     = "To use fortify, please make a macro for the command '/fortify' without any parameters, or use '/ffy panel' to show the UI button.  Type '/ffy help' for more options.";
FFY_TOGGLE_SYNTAX   = "Please type '/ffy toggle [spell name]' to turn a spell off or on.";
FFY_ONLY_SYNTAX     = "Please type '/ffy only [spell name]' to use only a single buff.";
FFY_TOGGLE_SPELLING = "The spell '$s' is not recognized.  Please check your spellbook for correct spelling.";
FFY_TOGGLE_YESCAST  = "'$s' will be cast on all members in the party.";
FFY_TOGGLE_NOCAST   = "'$s' will no longer be cast.";
FFY_TOGGLE_SINGLE   = "Only '$s' will be cast.";
FFY_TOGGLE_ALL      = "Restoring default configuration.  All buffs will be cast.";
FFY_SHOW_SETTINGS   = "--- ALL SETTINGS ---";
FFY_DEBUG_ON        = "Debug messages will now be shown to your console (ENGLISH ONLY).";
FFY_DEBUG_OFF       = "Debug messages turned off.";
FFY_RECEIVE_WHISPER = "Ok, I'll cast '$s' on you.  I will remember your preference until I log out.";
FFY_BAD_WHISPER     = "I don't have '$s'.  I have: $l";
FFY_SHOWLINE        = "* Casting: $l";
FFY_IGNORELINE      = "* Ingoring: $l";
FFY_MODE_QUIET      = "* Group / Raid notification is OFF.";
FFY_MODE_NOTIFY     = "* Group / Raid notification is ON.";
FFY_DEBUGON         = "* Debug messages are ON.";
FFY_DEBUGOFF        = "* Debug messages are OFF.";
FFY_MODE_AUTOREPLY  = "* Auto-Reply to whispers is ON.";
FFY_MODE_FAILREPLY  = "* Auto-Reply to whispers is FAILURE-ONLY.";
FFY_MODE_NOREPLY    = "* Auto-Reply to whispers is OFF.";
FFY_PETSMSG_ON      = "* Casting on pets is ON.";
FFY_PETSMSG_OFF     = "* Casting on pets is OFF.";
FFY_TELLBUFF_ON     = "* Notifying targets by tell is ON.";
FFY_TELLBUFF_OFF    = "* Notifying targets by tell is OFF.";
FFY_WHISPERREQUEST  = "* Blessing '$t' with '$s'."
FFY_REPLY_CHOICES   = "Please select a reply mode: auto, fail, or off.";
FFY_HELP_MSG        = "Choose from the following commands:";
FFY_UPGRADE_MSG     = "Upgrading from version $v1 to $v2.  Please reconfigure your spell settings.";
FFY_TELLBUFF_MSG    = "Casting $s on you.";
FFY_ANNOUNCE_MSG    = "I can cast the following blessings: $l.  To select one, whisper me with its name.";
FFY_BADANNOUNCE_MSG = "You're not a Paladin.  Only Paladins need to announce their blessing availability.";
FFY_BLESS_MSG       = "Selected '$s' for '$p'.";
FFY_BADBLESS_MSG    = "Please type '/ffy bless [character] [blessing]' to select a blessing for a player.";
FFY_AUTOSELECT_MSG  = "Auto-selected '$s' for '$p'.  To change, type '/ffy bless $p [blessing]'.";
FFY_RECAST_MSG      = "Ok.  Fortify will now allow you to recast all buffs on all members of your party/raid.";
FFY_CONSERVE_MSG    = "Mana conserve set to $m mana.";

-- These are the commands recognized by Fortify
FFY_CMD_QUIET       = "quiet";
FFY_CMD_MOVEABLE    = "move";
FFY_CMD_TOGGLESPELL = "toggle";
FFY_CMD_DEBUG       = "debug";
FFY_CMD_SINGLESPELL = "only";
FFY_CMD_ALLSPELLS   = "reset";
FFY_CMD_SHOW        = "show";
FFY_CMD_TOGGLEUI    = "panel";
FFY_CMD_HELP        = "help";
FFY_CMD_REPLY       = "reply";
FFY_CMD_PETS        = "pets";
FFY_CMD_TELLBUFF    = "tell";
FFY_CMD_DUTY        = "duty";
FFY_CMD_BLESS       = "bless";
FFY_CMD_ANNOUNCE    = "announce";
FFY_CMD_RECAST      = "recast";
FFY_CMD_CONSERVE    = "conserve";
FFY_REPLY_AUTO      = "auto";
FFY_REPLY_FAIL      = "fail";
FFY_REPLY_OFF       = "off";
FFY_DUTY_ALL        = "all";
FFY_DUTY_CIRCLE     = "circle";
FFY_DUTY_HALF       = "half";
FFY_DUTY_WHISPER    = "whisper";
FFY_ON              = "on";
FFY_OFF             = "off";

-- User interface strings
FFY_UI_OPTIONS       = "Options"
FFY_UI_CONSERVE      = "Mana Conserve"
FFY_UI_NOTIFYGROUP   = "Report buffs to party or raid channel";
FFY_UI_SHOWPANEL     = "Show the Fortify user interface panel";
FFY_UI_PANELMOVABLE  = "Lock user interface panel in place";
FFY_UI_CASTONPETS    = "Cast buffs on pets";
FFY_UI_TELLBUFFS     = "Report buffs via /whisper";
FFY_UI_REMINDERAUDIO = "Audible reminder to cast buffs";
FFY_UI_REMINDERTEXT  = "Text reminder to cast buffs";
FFY_UI_CONFIGBUTTON  = "Setup";
FFY_UI_REMINDER      = "Some buffs have expired.";
FFY_UI_ENABLED       = "Casting $s";
FFY_UI_DISABLED      = "$s (disabled)";
FFY_UI_NOITEM        = "Out of $s.";
FFY_UI_MAINHAND      = "Main Hand:";
FFY_UI_OFFHAND       = "Offhand:";

-------------------------------------------------------------------------------
-- the constants for the mod
-------------------------------------------------------------------------------
BINDING_HEADER_FORTIFY  = "Fortify";
PRAVETZ_FORT            = "Fortify v2.5";
FFY_MACRO_COMMAND       = "/fortify";
FFY_MACRO_COMMAND2      = "/ffy";
FFY_TAG                 = "FORTIFY: ";
FFY_VERSION_STRING      = PRAVETZ_FORT .. " - type '" .. FFY_MACRO_COMMAND2 .. " " .. FFY_CMD_HELP .. "' for help - Pravetz (Proudmoore)";

-------------------------------------------------------------------------------
-- TODO: German localization 
-------------------------------------------------------------------------------
if ( GetLocale() == "deDE" ) then

    -- Reagent Group Buffs
    FFY_SPELL_PRYR_FORTITUDE    = 'Gebet der Seelenst\195\164rke';
    FFY_SPELL_ARCANEBRILLIANCE  = 'Arkane Brillanz';
    FFY_SPELL_GIFTWILD          = 'Gabe der Wildnis';
    
    -- Spells castable on anyone
    FFY_SPELL_FORTITUDE         = 'Machtwort: Seelenst\195\164rke';
    FFY_SPELL_ARCANEINT         = 'Arkane Intelligenz';
    FFY_SPELL_MARKWILD          = 'Mal der Wildnis';
    FFY_SPELL_DIVINESPIRIT      = 'G\195\182ttlicher Willen';
    FFY_SPELL_SHADOWPROT        = 'Schattenschutz';
    FFY_SPELL_THORNS            = 'Dornen';
    
    -- Spells castable on self only
    FFY_SPELL_INNERFIRE         = 'Inneres Feuer';
    FFY_SPELL_ELUNESGRACE       = 'Elunes Anmut';
    FFY_SPELL_SHADOWGUARD       = 'Schattengarde';
    FFY_SPELL_FROSTARMOR        = '';
    FFY_SPELL_ICEARMOR          = '';
    FFY_SPELL_MAGEARMOR         = '';
    FFY_SPELL_FIREWARD          = '';
    FFY_SPELL_FROSTWARD         = '';
    
    -- Paladin Blessings
    FFY_BLESSING_MIGHT          = 'Segen der Macht';
    FFY_BLESSING_WISDOM         = 'Segen der Weisheit';
    FFY_BLESSING_SANCTUARY      = 'Segen der Refugiums';
    FFY_BLESSING_SALVATION      = 'Segen der Rettung';
    FFY_BLESSING_KINGS          = 'Segen der K\195\182nige';
    FFY_BLESSING_LIGHT          = 'Segen der Lichts';
    
    -- This is the text used for the word 'rank'
    FFY_RANK                    = 'Rang';

-------------------------------------------------------------------------------
-- French localization courtesy of Laurent Chevalier
-------------------------------------------------------------------------------
elseif ( GetLocale() == "frFR" ) then

    ---------------------------------------------------------------------------
    -- Traduction des sorts
    ---------------------------------------------------------------------------

    -- Informations sur les classes
    FFY_CLASS_DRUID   = 'DRUIDE';
    FFY_CLASS_HUNTER  = 'CHASSEUR';
    FFY_CLASS_MAGE    = 'MAGE';
    FFY_CLASS_PALADIN = 'PALADIN';
    FFY_CLASS_PRIEST  = 'PR\195\170TRE';
    FFY_CLASS_ROGUE   = 'VOLEUR';
    FFY_CLASS_SHAMAN  = 'SHAMAN';
    FFY_CLASS_WARLOCK = 'D\195\169MONISTE';
    FFY_CLASS_WARRIOR = 'GUERRIER';

    -- Buffs de groupes
    FFY_SPELL_PRYR_FORTITUDE = 'Pri\195\168re de Robustesse';
    FFY_SPELL_ARCANEBRILLIANCE = 'Illumination des Arcanes';
    FFY_SPELL_GIFTWILD = 'Don du fauve';
    
    -- Buffs valables sur tous les joueurs
    FFY_SPELL_FORTITUDE = 'Mot de pouvoir : Robustesse';
    FFY_SPELL_ARCANEINT = 'Intelligence des Arcanes';
    FFY_SPELL_MARKWILD = 'Marque du fauve';
    FFY_SPELL_DIVINESPIRIT = 'Esprit Divin';
    FFY_SPELL_SHADOWPROT = 'Protection contre l\'ombre';
    FFY_SPELL_THORNS = 'Epines';
    FFY_SPELL_BREATH = 'Respiration interminable';

    -- Buffs valables sur soi-meme uniquement
    FFY_SPELL_INNERFIRE = 'Feu int\195\169rieur';
    FFY_SPELL_ELUNESGRACE = 'Gr\195\162ce d\'Elune';
    FFY_SPELL_SHADOWGUARD = 'Gardien de l\'ombre';
    FFY_SPELL_FROSTARMOR = 'Armure de Givre';
    FFY_SPELL_ICEARMOR = 'Armure de Glace';
    FFY_SPELL_MAGEARMOR = 'Armure du Mage';
    FFY_SPELL_FIREWARD = 'Gardien de feu';
    FFY_SPELL_FROSTWARD = 'Gardien de givre';
    FFY_SPELL_DEMONSKIN  = 'peau de d\195\169mon';
    FFY_SPELL_DEMONARMOR = 'Armure d\195\169moniaque';

    -- B\195\169n\195\169dictions des paladins
    FFY_BLESSING_MIGHT          = 'B\195\169n\195\169diction de puissance';
    FFY_BLESSING_WISDOM         = 'B\195\169n\195\169diction de sagesse';
    FFY_BLESSING_SANCTUARY      = 'B\195\169n\195\169diction de sanctuaire';
    FFY_BLESSING_SALVATION      = 'B\195\169n\195\169diction de salut';
    FFY_BLESSING_KINGS          = 'B\195\169n\195\169diction des rois';
    FFY_BLESSING_LIGHT          = 'B\195\169n\195\169diction de lumi\195\168re';

    -- Buffs risqu\195\169s que peu de monde utilisent
    FFY_SPELL_AMPLIFYMAGIC      = 'Amplifier la magie';
    FFY_SPELL_DAMPENMAGIC       = 'att\195\169nuer la magie';

    -- poisons des voleurs
    FFY_POISON_INSTANT          = 'Poison instantan\195\169';
    FFY_POISON_CRIPPLING        = 'Poison affaiblissant';
    FFY_POISON_DEADLY           = 'Poison mortel';
    FFY_POISON_MIND             = 'Poison de distraction mentale';
    FFY_POISON_WOUND            = 'Poison douloureux';
    
    -- Traduction du mot "rang"
    FFY_RANK = 'Rang'; 


    -------------------------------------------------------------------------------
    -- Traduction de l'add-on et son interface
    -------------------------------------------------------------------------------
    -- $s d\195\169signe le nom du sort
    -- $t d\195\169signe la cible
    -- $m d\195\169signe la cible si echec
    -- $r d\195\169signe le niveau du sort
    FFY_STARTING_BUFFS  = "Lancement des buffs en cours...";
    FFY_DONE_BUFFS      = "Tous les buffs lanc\195\169s.";
    FFY_NOTHING         = "Rien \195\160 lancer.";
    FFY_PEOPLE_MISSED   = "Hors de port\195\169e: $m";
    FFY_BUFF_STRING     = "Lancement de $s sur $t.";
    FFY_SPELL_FOUND     = "$s trouv\195\169!";
    FFY_NO_SPELLS       = "Pas de sort exploitable trouv\195\169!";
    FFY_NO_SPELLS_RDY   = "Ne peut pas lancer de sort maintenant.";
    FFY_OUT_OF_RANGE    = "$t est hors de port\195\169e et ne peut \195\170tre buff\195\169.";
    FFY_MACRO_ERROR     = "Pour utiliser FORTIFY, faire une macro avec la commande '/fortify' (ou '/ffy') sans param\195\168tre ou utiliser '/ffy panel' pour afficher l'interface (bouton de lancement). Pour plus d'options , faire '/ffy help'.";
    FFY_TOGGLE_SYNTAX   = "Taper '/ffy toggle [nom du sort]' pour activer ou non le sort.";
    FFY_ONLY_SYNTAX     = "Taper '/ffy only [nom du sort]' pour activer uniquement ce sort.";
    FFY_TOGGLE_SPELLING = "Le sort '$s' n\'est pas reconnu. V\195\169rifiez sa pr\195\169sence ou son orthographe dans le journal des sorts.";
    FFY_TOGGLE_YESCAST  = "'$s' sera lanc\195\169 sur tous les membres du groupe.";
    FFY_TOGGLE_NOCAST   = "'$s' ne sera plus lanc\195\169 (ignor\195\169).";
    FFY_TOGGLE_SINGLE   = "Seulement '$s' sera lanc\195\169.";
    FFY_TOGGLE_ALL      = "Pour r\195\169initialiser tous les r\195\169glages. Ca r\195\169activera par d\195\169faut tous les sorts.";
    FFY_SHOW_SETTINGS   = "--- REGLAGES DE FORTIFY ---";
    FFY_DEBUG_ON        = "Les messages d'erreur seront affich\195\169s dans la console (en Anglais seulement).";
    FFY_DEBUG_OFF       = "Les messages d'erreur seront d\195\169sactiv\195\169s.";
    FFY_RECEIVE_WHISPER = "Ok, je lance '$s' sur toi. Je lancerais par d\195\169faut ce sort sur toi (jusqu\'a d\195\169connexion ou demande d'autre sort par chuchottement).";
    FFY_BAD_WHISPER     = "D\195\169sol\195\169, je n'ai pas $s. Mais j'ai : $l";
    FFY_SHOWLINE        = "* Lancement : $l";
    FFY_IGNORELINE      = "* Ignor\195\169 : $l";
    FFY_MODE_QUIET      = "* Avertissement du lancement du buff dans le canal groupe/raid d\195\169sactiv\195\169.";
    FFY_MODE_NOTIFY     = "* Avertissement du lancement du buff dans le canal groupe/raid activ\195\169.";
    FFY_DEBUGON         = "* Avertissement des erreurs activ\195\169.";
    FFY_DEBUGOFF        = "* Avertissement des erreurs d\195\169sactiv\195\169.";
    FFY_MODE_AUTOREPLY  = "* R\195\169ponse automatique \195\160 la cible activ\195\169.";
    FFY_MODE_FAILREPLY  = "* R\195\169ponse automatique \195\160 la cible d\195\169sactiv\195\169 (sauf si echec).";
    FFY_MODE_NOREPLY    = "* R\195\169ponse automatique \195\160 la cible d\195\169sactiv\195\169.";
    FFY_PETSMSG_ON      = "* Lancement des buffs sur familiers activ\195\169.";
    FFY_PETSMSG_OFF     = "* Lancement des buffs sur familiers d\195\169sactiv\195\169.";
    FFY_TELLBUFF_ON     = "* Avertissement du lancement du buff \195\160 la cible par chuchottement activ\195\169.";
    FFY_TELLBUFF_OFF    = "* Avertissement du lancement du buff \195\160 la cible par chuchottement d\195\169sactiv\195\169.";
    FFY_WHISPERREQUEST  = "* B\195\169nir '$t' avec '$s'."
    FFY_REPLY_CHOICES   = "S\195\169lectionner un mode de r\195\169ponse : auto, fail, ou off.";
    FFY_HELP_MSG        = "Choisir parmi les commandes suivantes :";
    FFY_UPGRADE_MSG     = "Mise a jour de la version $v1 \195\160 la version $v2. Attention, il faudra reconfigurer les r\195\169glages des sorts.";
    FFY_TELLBUFF_MSG    = "Lancement de $s sur toi.";
    FFY_ANNOUNCE_MSG    = "Je peux lancer les b\195\169n\195\169dictions suivantes : $l. Pour en choisir une merci de me chuchotter son nom (ex: sagesse, rois ..).";
    FFY_BADANNOUNCE_MSG = "Tu n'es pas un paladin. Seuls les paladins peuvent utiliser l'option d'annonce des b\195\169n\195\169dictions.";
    FFY_BLESS_MSG       = "S\195\169lection de '$s' pour '$p'.";
    FFY_BADBLESS_MSG    = "Taper '/ffy bless [nom du joueur] [nom de la b\195\169n\195\169diction]' pour attribuer la b\195\169n\195\169diction au joueur.";
    FFY_AUTOSELECT_MSG  = "S\195\169lection automatique de '$s' pour '$p'. Pour changer, taper '/ffy bless $p [nom de la b\195\169n\195\169diction]'.";
    FFY_RECAST_MSG      = "Ok. FORTIFY pourra te permettre de relancer tous les buffs sur tous les joueurs du groupe/raid.";
    FFY_CONSERVE_MSG    = "R\195\169glage de l'\195\169conomie de mana \195\160 $m .";
    
    -- Commandes utilis\195\169es par FORTIFY (traduction hasardeuse)
    FFY_CMD_QUIET       = "quiet";
    FFY_CMD_MOVEABLE    = "move";
    FFY_CMD_TOGGLESPELL = "toggle";
    FFY_CMD_DEBUG       = "debug";
    FFY_CMD_SINGLESPELL = "only";
    FFY_CMD_ALLSPELLS   = "reset";
    FFY_CMD_SHOW        = "show";
    FFY_CMD_TOGGLEUI    = "panel";
    FFY_CMD_HELP        = "help";
    FFY_CMD_REPLY       = "reply";
    FFY_CMD_PETS        = "pets";
    FFY_CMD_TELLBUFF    = "tell";
    FFY_CMD_DUTY        = "duty";
    FFY_CMD_BLESS       = "bless";
    FFY_CMD_ANNOUNCE    = "announce";
    FFY_CMD_RECAST      = "recast";
    FFY_CMD_CONSERVE    = "conserve";
    FFY_REPLY_AUTO      = "auto";
    FFY_REPLY_FAIL      = "fail";
    FFY_REPLY_OFF       = "off";
    FFY_DUTY_ALL        = "all";
    FFY_DUTY_CIRCLE     = "circle";
    FFY_DUTY_HALF       = "half";
    FFY_DUTY_WHISPER    = "whisper";
    FFY_ON              = "on";
    FFY_OFF             = "off";
    
    -- Traduction de l'interface de reglage
    FFY_UI_OPTIONS       = "Options"
    FFY_UI_CONSERVE      = "Economie mana"
    FFY_UI_NOTIFYGROUP   = "Rapporter les buffs au groupe/raid (canal)";
    FFY_UI_SHOWPANEL     = "Afficher l'interface de FORTIFY";
    FFY_UI_PANELMOVABLE  = "Bloquer la position de l'interface";
    FFY_UI_CASTONPETS    = "Lancer les buffs sur familiers";
    FFY_UI_TELLBUFFS     = "Rapporter le buff en chuchottement";
    FFY_UI_REMINDERAUDIO = "Alerte audio quand buffage demand\195\169";
    FFY_UI_REMINDERTEXT  = "Alerte \195\169crite quand buffage demand\195\169";
    FFY_UI_CONFIGBUTTON  = "R\195\169glages";
    FFY_UI_REMINDER      = "Plusieurs buffs ont expir\195\169s.";
    FFY_UI_ENABLED       = "Lancer $s";
    FFY_UI_DISABLED      = "$s (d\195\169sactiv\195\169)";
    FFY_UI_NOITEM        = "Plus de $s.";

end




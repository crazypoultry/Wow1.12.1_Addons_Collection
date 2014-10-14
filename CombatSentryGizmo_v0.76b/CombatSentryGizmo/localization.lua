--Language Localization-----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------

--HIGHLIGHT_FONT_COLOR_CODE = "|cffffffff";
--RED_FONT_COLOR_CODE = "|cffff2020";
--NORMAL_FONT_COLOR_CODE = "|cffffd200";


CSG_VERSION = 0.76;

-- Colors
CSG_NML_TXT = "|cffffd200"
CSG_WHT_TXT = "|cffffffff"
CSG_GRY_TXT = "|cffC0C0C0"
CSG_DGY_TXT = "|cff585858"
CSG_RED_TXT = "|cffff2020"
CSG_GRN_TXT = "|cff20ff20"
CSG_YLW_TXT = "|cffffff00"
CSG_BLE_TXT = "|cff3366ff"

CSG_TITLE = "|cffffffffC|cffffd200ombat |cffffffffS|cffffd200entry |cffffffffG|cffffd200izmo"..NORMAL_FONT_COLOR_CODE;
CSG_TITLE_NOSPACE = "|cffffffffC|cffffd200ombat|cffffffffS|cffffd200entry|cffffffffG|cffffd200izmo"..NORMAL_FONT_COLOR_CODE;
CSG_TITLE_TOOLTIP = "|cffffd200CSG"..NORMAL_FONT_COLOR_CODE;
CSG_TITLE_TOOLTIP_TITLE = "|cffffffffC|cffC0C0C0ombat|cffffffffS|cffC0C0C0entry|cffffffffG|cffC0C0C0izmo"..NORMAL_FONT_COLOR_CODE;
CSG_TITLE_CHAT = "|cffffff00CSG: |cffffffff";

--English--------------------------------------------------
-----------------------------------------------------------
	if (GetLocale() == "enUS") then
		CSG_OPTION_ON_TOOLTIP = "|cffffffff"..CSG_TITLE_TOOLTIP_TITLE.." |cffffffffToggle\n|cffffd200When disabled, "..CSG_TITLE_TOOLTIP.." is off and will not function.";
		CSG_OPTION_DETECT_TOOLTIP = "|cffffffffEnemy Detection\n|cffffd200Toggles enemy detection.\n\n|cffff2020WARNING: |cffffd200Having both Enemy Detection and Auto Targeting Info on can potentially mess with your targeting when your framerate or network connection is poor.  It is recommended that you turn this and Auto Targeting Info off in those situations.";
		CSG_OPTION_CREATURES_TOOLTIP = "|cffffffffCreatures Toggle\n|cffffd200Toggles whether creatures (non players) will show up in "..CSG_TITLE_TOOLTIP..".";
		CSG_OPTION_INFOTARGET_TOOLTIP = "|cffffffffAuto Targeting Info\n|cffffd200Toggles "..CSG_TITLE_TOOLTIP.."'s auto info gathering for attackers.\n\n|cffff2020WARNING: |cffffd200When on, "..CSG_TITLE_TOOLTIP.." will gather info from your attacker by targeting it 'under-the-hood'.  When off, "..CSG_TITLE_TOOLTIP.." will never try to gather info from your attacker.  However, if you manually select them or mouse-over them, their info will fill in. (while you are in combat, CSG will NEVER change your selected target, however)";
		CSG_OPTION_ANCHOR_TOOLTIP = "|cffffffffAnchor Toggle\n|cffffd200Toggles whether the "..CSG_TITLE_TOOLTIP.." Anchor stays on all the time, or only comes on when needed.  It is useful to turn it on when you are repositioning it.";
		
		CSG_OPTION_MENU_TOOLTIP = "|cffffffffOptions Menu\n|cffffd200Opens the "..CSG_TITLE_TOOLTIP.." Options Menu.";

		CSG_MENU_AB_OCCUPIED = "When Occupied";
		CSG_MENU_AB_OCCUPIED_TOOLTIP = "The anchor bar will only show when\nthere are enemies visible on your list";
		CSG_MENU_AB_ALWAYS = "Always";
		CSG_MENU_AB_ALWAYS_TOOLTIP = "The anchor bar will ALWAYS be shown\n(good for when you want to reposition it)";
		CSG_MENU_AB_NEVER = "Never";
		CSG_MENU_AB_NEVER_TOOLTIP = "The anchor bar will NEVER be shown";

		CSG_MENU_SCALE = "Scale";
		CSG_MENU_SCALE_TOOLTIP = "|cffffffff"..CSG_MENU_SCALE.."\n|cffffd200Change the scale of the "..CSG_TITLE_TOOLTIP.." enemy list.";
		CSG_MENU_MAX_F = "Max Total Frames";
		CSG_MENU_MAX_F_TOOLTIP = "|cffffffff"..CSG_MENU_MAX_F.."\n|cffffd200Choose how many enemies you want to show up on your enemy list.";
		CSG_MENU_MAX_NA = "Max Non-Attackers";
		CSG_MENU_MAX_NA_TOOLTIP = "|cffffffff"..CSG_MENU_MAX_NA.."\n|cffffd200Choose how many non-attackers you want to show up on your enemy list.";
		CSG_MENU_MAX_A = "Max Attackers";
		CSG_MENU_MAX_A_TOOLTIP = "|cffffffff"..CSG_MENU_MAX_A.."\n|cffffd200Choose how many attackers you want to show up on your enemy list.";
		CSG_MENU_TIMEOUT_NA = "Non-Attacker Timeout";
		CSG_MENU_TIMEOUT_NA_TOOLTIP = "|cffffffff"..CSG_MENU_TIMEOUT_NA.."\n|cffffd200Choose how long before non-attackers timeout and dissapear from your list.";
		CSG_MENU_TIMEOUT_A = "Attacker Timeout";
		CSG_MENU_TIMEOUT_A_TOOLTIP = "|cffffffff"..CSG_MENU_TIMEOUT_A.."\n|cffffd200Choose how long before attackers timeout and dissapear from your list.";
		CSG_MENU_TIMEOUT_H = "Healer/Buffer Timeout";
		CSG_MENU_TIMEOUT_H_TOOLTIP = "|cffffffff"..CSG_MENU_TIMEOUT_H.."\n|cffffd200Choose how long before healers/buffers timeout and dissapear from your list.";
		CSG_MENU_SOUNDS_ALL = "Enable All Sounds";
		CSG_MENU_SOUNDS_ALL_TOOLTIP = "|cffffffff"..CSG_MENU_SOUNDS_ALL.."\n|cffffd200Enables all "..CSG_TITLE_TOOLTIP.." sounds.  Uncheck this to keep "..CSG_TITLE_TOOLTIP.." from playing sounds.";
	
		CSG_TEXT_WELCOME = "|cff3366ffCombat Sentry Gizmo v"..CSG_VERSION.."b Loaded |cff20ff20(/csg for options)";
		CSG_TEXT_SLASHCOMMAND = "|cff20ff20/csg off|cff3366ff -Turn CSG off, |cff20ff20/csg on|cff3366ff -Turn CSG on, |cff20ff20/csg toggle|cff3366ff -Toggle CSG on/off, |cff20ff20/csg detect|cff3366ff -Toggle Enemy Detection, |cff20ff20/csg creatures|cff3366ff -Toggle Creature Showing, |cff20ff20/csg infotarget|cff3366ff -Toggle Auto Targeting Info";
		
		CSG_TEXT_ENEMYDETECTION_OFF = CSG_TITLE_CHAT.."Detecting Enemies is now: |cffff2020-OFF-";
		CSG_TEXT_ENEMYDETECTION_ON = CSG_TITLE_CHAT.."Detecting Enemies is now: |cff20ff20-ON-";
		CSG_TEXT_CREATURES_OFF = CSG_TITLE_CHAT.."Showing Creatures is now: |cffff2020-OFF-";
		CSG_TEXT_CREATURES_ON = CSG_TITLE_CHAT.."Showing Creatures is now: |cff20ff20-ON-";
		CSG_TEXT_CSG_OFF = CSG_TITLE_CHAT.."Is now: |cffff2020-OFF-";
		CSG_TEXT_CSG_ON = CSG_TITLE_CHAT.."Is now: |cff20ff20-ON-";

		CSG_L_YOU = "you";

		--CSG_DAM_HITBLOCK = "(.+) hits (.+) for (%d+). (.+) blocked";
		CSG_DAM_HIT = "(.+) hits (.+) for (%d+).+";
		CSG_DAM_CRIT = "(.+) crits (.+) for (%d+).+";

		CSG_SDAM_HIT = "(.+)'s (.+) hits (.+) for (%d+).+";
		CSG_SDAM_CRIT = "(.+)'s (.+) crits (.+) for (%d+).+";
		CSG_SDAM_BLOCK = "(.+)'s (.+) was blocked.";
		CSG_SDAM_BLOCKBY = "(.+)'s (.+) was blocked by (.+)%.+";
		CSG_SDAM_DEFLECT = "(.+)'s (.+) was deflected.";
		CSG_SDAM_DEFLECTBY = "(.+)'s (.+) was deflected by (.+)%.";
		CSG_SDAM_DODGE = "(.+)'s (.+) was dodged.";
		CSG_SDAM_DODGEBY = "(.+)'s (.+) was dodged by (.+)%.";
		CSG_SDAM_EVADE = "(.+)'s (.+) was evaded.";
		CSG_SDAM_EVADEBY = "(.+)'s (.+) was evaded by (.+)%.";
		CSG_SDAM_FAIL = "(.+)'s (.+) failed. You are immune.";
		CSG_SDAM_MISS = "(.+)'s (.+) misses you.";
		CSG_SDAM_PARRY = "You parry (.+)'s (.+)"; --??
		CSG_SDAM_RESIST = "(.+)'s (.+) was resisted.";
		CSG_SDAM_RESISTBY = "(.+)'s (.+) was resisted by (.+)%.";

		CSG_MISS_MISS = "(.+) misses (.+).";
		CSG_MISS_PARRY = "(.+) attacks. (.+) parr.+";
		CSG_MISS_EVADE = "(.+) attacks. (.+) evade.+";
		CSG_MISS_DODGE = "(.+) attacks. (.+) dodge.+";
		CSG_MISS_DEFLECT = "(.+) attacks. (.+) deflect.+";
		CSG_MISS_BLOCK = "(.+) attacks. (.+) block.+";
		CSG_MISS_ABSORB = "(.+) attacks. (.+) absorb";

		CSG_SPLL_HEALCRIT = "(.+)%'s (.+) critically heals (.+) for (%d+)%a.";
		CSG_SPLL_HEAL = "(.+)%'s (.+) heals (.+) for (%d+).";
		CSG_SPLL_CAST = "(.+) casts (.+) on (.+).";
		CSG_SPLL_CASTS = "(.+) casts (.+) on (.+)%'s ";
		CSG_SPLL_CASTS2 = "(.+) casts (.+).";
		CSG_SPLL_GAINS = "(.+) gains (.+).";
		CSG_SPLL_GAINS2 = "(.+) gains.+";
		CSG_SPLL_BPERFORM = "(.+) begins to perform (.+).";
		CSG_SPLL_BCAST = "(.+) begins to cast (.+).";

		CSG_DIES = "(.+) dies.";
		CSG_SLAINBY = "(.+) is slain by";

		CSG_MAGE = "Mage";
		CSG_WARLOCK = "Warlock";
		CSG_PRIEST = "Priest";
		CSG_DRUID = "Druid";
		CSG_SHAMAN = "Shaman";
		CSG_PALADIN = "Paladin";
		CSG_ROGUE = "Rogue";
		CSG_HUNTER = "Hunter";
		CSG_WARRIOR = "Warrior";
		CSG_UNKNOWN = "Unknown";
	end

--German---------------------------------------------------
-----------------------------------------------------------
	if (GetLocale() == "deDE") then
		CSG_OPTION_ON_TOOLTIP = "|cffffffff"..CSG_TITLE_TOOLTIP_TITLE.." |cffffffffToggle\n|cffffd200Wenn deaktiviert, ist "..CSG_TITLE_TOOLTIP.." aus und wird nicht funktionieren.";
		CSG_OPTION_DETECT_TOOLTIP = "|cffffffffFeinderkennung\n|cffffd200Schaltet Feinderkennung an/aus.\n\n|cffff2020WARNUNG: |cffffd200Wenn man beides, Feinderkennung und Automatische Informationssammlung an hat, kann es passieren, das man im Kampf gestort wird (vor allem bei niedrigem Ping/FPS). In diesem Fall sollte man die Feinderkennung und die Automatische Informationssammlung deaktivieren";
		CSG_OPTION_CREATURES_TOOLTIP = "|cffffffffNPC An/Aus\n|cffffd200Wahlt ob NPCs in "..CSG_TITLE_TOOLTIP.." angezeigt werden.";
		CSG_OPTION_INFOTARGET_TOOLTIP = "|cffffffffAutomatische Informationssammlung\n|cffffd200Schaltet "..CSG_TITLE_TOOLTIP.."s automatische Informationssammlung f\195\188r Angreifer an/aus.\n\n|cffff2020WARNUNG: |cffffd200Wenn an, wird "..CSG_TITLE_TOOLTIP.." die Informationen sammeln, indem es den Angreifer kurz anwahlt. Wenn aus, wird "..CSG_TITLE_TOOLTIP.." nicht probieren Informationen automatisch zu sammeln.  Wenn du den Angreifer anwahlst wird die Information eingetragen.";
		CSG_OPTION_ANCHOR_TOOLTIP = "|cffffffffAnker an/aus\n|cffffd200Wahlt ob der "..CSG_TITLE_TOOLTIP.." Anker immer sichtbar ist. Nutzlich zur neuen Positionierung.";

		--THESE NEED LOCALIZATION - 07/12/2005
		CSG_OPTION_MENU_TOOLTIP = "|cffffffffOptions Menu\n|cffffd200Opens the "..CSG_TITLE_TOOLTIP.." Options Menu.";

		CSG_MENU_AB_OCCUPIED = "When Occupied";
		CSG_MENU_AB_OCCUPIED_TOOLTIP = "The anchor bar will only show when\nthere are enemies visible on your list";
		CSG_MENU_AB_ALWAYS = "Always";
		CSG_MENU_AB_ALWAYS_TOOLTIP = "The anchor bar will ALWAYS be shown\n(good for when you want to reposition it)";
		CSG_MENU_AB_NEVER = "Never";
		CSG_MENU_AB_NEVER_TOOLTIP = "The anchor bar will NEVER be shown";

		CSG_MENU_SCALE = "Scale";
		CSG_MENU_SCALE_TOOLTIP = "|cffffffff"..CSG_MENU_SCALE.."\n|cffffd200Change the scale of the "..CSG_TITLE_TOOLTIP.." enemy list.";
		CSG_MENU_MAX_F = "Max Total Frames";
		CSG_MENU_MAX_F_TOOLTIP = "|cffffffff"..CSG_MENU_MAX_F.."\n|cffffd200Choose how many enemies you want to show up on your enemy list.";
		CSG_MENU_MAX_NA = "Max Non-Attackers";
		CSG_MENU_MAX_NA_TOOLTIP = "|cffffffff"..CSG_MENU_MAX_NA.."\n|cffffd200Choose how many non-attackers you want to show up on your enemy list.";
		CSG_MENU_MAX_A = "Max Attackers";
		CSG_MENU_MAX_A_TOOLTIP = "|cffffffff"..CSG_MENU_MAX_A.."\n|cffffd200Choose how many attackers you want to show up on your enemy list.";
		CSG_MENU_TIMEOUT_NA = "Non-Attacker Timeout";
		CSG_MENU_TIMEOUT_NA_TOOLTIP = "|cffffffff"..CSG_MENU_TIMEOUT_NA.."\n|cffffd200Choose how long before non-attackers timeout and dissapear from your list.";
		CSG_MENU_TIMEOUT_A = "Attacker Timeout";
		CSG_MENU_TIMEOUT_A_TOOLTIP = "|cffffffff"..CSG_MENU_TIMEOUT_A.."\n|cffffd200Choose how long before attackers timeout and dissapear from your list.";
		CSG_MENU_TIMEOUT_H = "Healer/Buffer Timeout";
		CSG_MENU_TIMEOUT_H_TOOLTIP = "|cffffffff"..CSG_MENU_TIMEOUT_H.."\n|cffffd200Choose how long before healers/buffers timeout and dissapear from your list.";
		CSG_MENU_SOUNDS_ALL = "Enable All Sounds";
		CSG_MENU_SOUNDS_ALL_TOOLTIP = "|cffffffff"..CSG_MENU_SOUNDS_ALL.."\n|cffffd200Enables all "..CSG_TITLE_TOOLTIP.." sounds.  Uncheck this to keep "..CSG_TITLE_TOOLTIP.." from playing sounds.";
		--------------------------
		
		CSG_TEXT_WELCOME = "|cff3366ffCombat Sentry Gizmo v"..CSG_VERSION.."b geladen |cff20ff20(/csg fur Optionen)";
		CSG_TEXT_SLASHCOMMAND = "|cff20ff20/csg off|cff3366ff -Schaltet CSG aus, |cff20ff20/csg on|cff3366ff -Schaltet CSG an, |cff20ff20/csg toggle|cff3366ff -Schaltet CSG an/aus, |cff20ff20/csg detect|cff3366ff -Feinderkennung an/aus, |cff20ff20/csg creatures|cff3366ff -NPC an/aus, |cff20ff20/csg infotarget|cff3366ff -Automatische Informationssammlung an/aus";
		
		CSG_TEXT_ENEMYDETECTION_OFF = CSG_TITLE_CHAT.."Feinderkennung ist jetzt: |cffff2020-AUS-";
		CSG_TEXT_ENEMYDETECTION_ON = CSG_TITLE_CHAT.."Feinderkennung ist jetzt: |cff20ff20-AN-";
		CSG_TEXT_CREATURES_OFF = CSG_TITLE_CHAT.."NPC-Anzeige ist jetzt: |cffff2020-AUS-";
		CSG_TEXT_CREATURES_ON = CSG_TITLE_CHAT.."NPC-Anzeige ist jetzt: |cff20ff20-AN-";
		CSG_TEXT_CSG_OFF = CSG_TITLE_CHAT.."Ist jetzt: |cffff2020-AUS-";
		CSG_TEXT_CSG_ON = CSG_TITLE_CHAT.."Ist jetzt: |cff20ff20-AN-";

		CSG_L_YOU = "Euch";

		CGS_DE_NAMES = "(%a[a-z\195\170\195\164\169\228]+)";

		--CSG_DAM_HITBLOCK = "(.+) hits (.+) for (%d+). (.+) blocked";
		CSG_DAM_HIT = CGS_DE_NAMES.." trifft "..CGS_DE_NAMES.." f\195\188r (%d+) Schaden.";
		CSG_DAM_CRIT = CGS_DE_NAMES.." trifft "..CGS_DE_NAMES.." kritisch f\195\188r (%d+) Schaden.";

		CSG_SDAM_HIT = CGS_DE_NAMES.." trifft "..CGS_DE_NAMES.." (mit "..CGS_DE_NAMES.."). Schaden: (%d+)";
		CSG_SDAM_CRIT = CGS_DE_NAMES.."s "..CGS_DE_NAMES.." trifft "..CGS_DE_NAMES.." kritisch f\195\188r (%d+) Schaden.";
		CSG_SDAM_BLOCK = CGS_DE_NAMES.."s "..CGS_DE_NAMES.." wurde geblockt.";
		CSG_SDAM_BLOCKBY = CGS_DE_NAMES.."s "..CGS_DE_NAMES.." wurde geblockt von "..CGS_DE_NAMES.."%.";
		CSG_SDAM_DEFLECT = CGS_DE_NAMES.." versuchte es mit "..CGS_DE_NAMES.."... abgewehrt.";
		CSG_SDAM_DEFLECTBY = CGS_DE_NAMES.." versuchte es mit "..CGS_DE_NAMES.."... "..CGS_DE_NAMES.." konnte abwehren.";
		CSG_SDAM_DODGE = CGS_DE_NAMES.."s "..CGS_DE_NAMES.." wurde ausgewichen.";
		CSG_SDAM_DODGEBY = CGS_DE_NAMES.." ist "..CGS_DE_NAMES.." ausgewichen.";
		CSG_SDAM_EVADE = CGS_DE_NAMES.." versuchte es mit "..CGS_DE_NAMES.."... entkommen.";
		CSG_SDAM_EVADEBY = CGS_DE_NAMES.." ist "..CGS_DE_NAMES.." entkommen.";
		CSG_SDAM_FAIL = CGS_DE_NAMES.." versucht es mit "..CGS_DE_NAMES.."... ein Fehlschlag. Ihr seid immun.";
		CSG_SDAM_MISS = CGS_DE_NAMES.." greift an (mit "..CGS_DE_NAMES..") und verfehlt Euch.";
		CSG_SDAM_PARRY = "You parry (.+)'s (.+)"; --??
		CSG_SDAM_RESIST = CGS_DE_NAMES.." versucht es mit "..CGS_DE_NAMES.."... widerstanden.";
		CSG_SDAM_RESISTBY = "Ihr habt es mit "..CGS_DE_NAMES.." versucht, aber "..CGS_DE_NAMES.." hat widerstanden.";

		CSG_MISS_MISS = CGS_DE_NAMES.." verfehlt "..CGS_DE_NAMES..".";
		CSG_MISS_PARRY = CGS_DE_NAMES.." greift an. "..CGS_DE_NAMES.." pariert.";
		CSG_MISS_EVADE = CGS_DE_NAMES.." greift an. "..CGS_DE_NAMES.." entkommt.";
		CSG_MISS_DODGE = CGS_DE_NAMES.." greift an. "..CGS_DE_NAMES.." weicht aus.";
		CSG_MISS_DEFLECT = CGS_DE_NAMES.." greift an. "..CGS_DE_NAMES.." wehrt ab.";
		CSG_MISS_BLOCK = CGS_DE_NAMES.." greift an. "..CGS_DE_NAMES.." blockt.";
		CSG_MISS_ABSORB = CGS_DE_NAMES.." greift an. "..CGS_DE_NAMES.." absorbiert ";

		CSG_SPLL_HEALCRIT = "Besondere Heilung: "..CGS_DE_NAMES.."s "..CGS_DE_NAMES.." heilt "..CGS_DE_NAMES.." um (%d+) Punkte.";
		CSG_SPLL_HEAL = CGS_DE_NAMES.."s "..CGS_DE_NAMES.." heilt "..CGS_DE_NAMES.." um (%d+) Punkte.";
		CSG_SPLL_CAST = CGS_DE_NAMES.." wirkt "..CGS_DE_NAMES.." auf "..CGS_DE_NAMES..".";
		CSG_SPLL_CASTS = CGS_DE_NAMES.." wirkt "..CGS_DE_NAMES.." auf "..CGS_DE_NAMES.." von "..CGS_DE_NAMES..".";
		CSG_SPLL_CASTS2 = CGS_DE_NAMES.." wirkt "..CGS_DE_NAMES..".";
		CSG_SPLL_GAINS = CGS_DE_NAMES.." erh\195\164lt "..CGS_DE_NAMES..".";
		CSG_SPLL_GAINS2 = CGS_DE_NAMES.." erh\195\164lt.+";
		CSG_SPLL_BPERFORM = CGS_DE_NAMES.." beginnt "..CGS_DE_NAMES.." auszuf\195\188hren.";
		CSG_SPLL_BCAST = CGS_DE_NAMES.." beginnt "..CGS_DE_NAMES.." zu wirken.";

		CSG_DIES = CGS_DE_NAMES.." stirbt.";
		CSG_SLAINBY = CGS_DE_NAMES.." wurde von "..CGS_DE_NAMES.." get\195\182tet!"

		CSG_MAGE = "Magier";
		CSG_WARLOCK = "Hexenmeister";
		CSG_PRIEST = "Priester";
		CSG_DRUID = "Druide";
		CSG_SHAMAN = "Schamane";
		CSG_PALADIN = "Paladin";
		CSG_ROGUE = "Schurke";
		CSG_HUNTER = "J\195\164ger";
		CSG_WARRIOR = "Krieger";
		CSG_UNKNOWN = "Unbekannt";
	end

--French---------------------------------------------------
-----------------------------------------------------------
	--Translated in french by Sasmira ( Cosmos Team ) & Gaysha
	--Update : 07/11/2005
	if (GetLocale() == "frFR") then
		CSG_OPTION_ON_TOOLTIP = "|cffffffff"..CSG_TITLE_TOOLTIP_TITLE.." |cffffffff[ON/OFF]\n|cffffd200D\195\169sactiv\195\169, "..CSG_TITLE_TOOLTIP.." est OFF et ne fonctionnera pas.";
		CSG_OPTION_DETECT_TOOLTIP = "|cffffffffD\195\169tection des Ennemis\n|cffffd200[ON/OFF] D\195\169tection des Ennemis.\n\n|cffff2020ATTENTION: |cffffd200Avoir la D\195\169tection des Ennemis et l\'Info Ciblage Auto ON peut faire rater votre ciblage si votre IPS ou votre connexion est faible. Il est recommand\195\169 de mettre les deux options OFF pour ces situations.";
		CSG_OPTION_CREATURES_TOOLTIP = "|cffffffffCr\195\169atures [ON/OFF]\n|cffffd200[ON/OFF] Les cr\195\169atures (non joueurs) s\'afficheront dans "..CSG_TITLE_TOOLTIP..".";
		CSG_OPTION_INFOTARGET_TOOLTIP = "|cffffffffInfo Ciblage Auto\n|cffffd200[ON/OFF] Recueille Automatique des Info de "..CSG_TITLE_TOOLTIP.." concernant les attaquants.\n\n|cffff2020ATTENTION: |cffffd200Sur ON, "..CSG_TITLE_TOOLTIP.." reccueillera les info en provenance de votre attaquant. Sur OFF, "..CSG_TITLE_TOOLTIP.." ne fera jamais le recueil d\'info en provenance de votre attaquant. Cependant, si vous les choisissez manuellement ou passer la souris dessus, leurs info se compl\195\168teront";
		CSG_OPTION_ANCHOR_TOOLTIP = "|cffffffffAncrage [ON/OFF]\n|cffffd200[ON/OFF] L\'Ancrage de "..CSG_TITLE_TOOLTIP.." reste ON tout le temps ou seulement si c\'est n\195\169cessaire. Il est utile de le mettre ON lorsque vous le replacez.";

		--THESE NEED LOCALIZATION - 07/12/2005
		CSG_OPTION_MENU_TOOLTIP = "|cffffffffOptions Menu\n|cffffd200Opens the "..CSG_TITLE_TOOLTIP.." Options Menu.";

		CSG_MENU_AB_OCCUPIED = "When Occupied";
		CSG_MENU_AB_OCCUPIED_TOOLTIP = "The anchor bar will only show when\nthere are enemies visible on your list";
		CSG_MENU_AB_ALWAYS = "Always";
		CSG_MENU_AB_ALWAYS_TOOLTIP = "The anchor bar will ALWAYS be shown\n(good for when you want to reposition it)";
		CSG_MENU_AB_NEVER = "Never";
		CSG_MENU_AB_NEVER_TOOLTIP = "The anchor bar will NEVER be shown";

		CSG_MENU_SCALE = "Scale";
		CSG_MENU_SCALE_TOOLTIP = "|cffffffff"..CSG_MENU_SCALE.."\n|cffffd200Change the scale of the "..CSG_TITLE_TOOLTIP.." enemy list.";
		CSG_MENU_MAX_F = "Max Total Frames";
		CSG_MENU_MAX_F_TOOLTIP = "|cffffffff"..CSG_MENU_MAX_F.."\n|cffffd200Choose how many enemies you want to show up on your enemy list.";
		CSG_MENU_MAX_NA = "Max Non-Attackers";
		CSG_MENU_MAX_NA_TOOLTIP = "|cffffffff"..CSG_MENU_MAX_NA.."\n|cffffd200Choose how many non-attackers you want to show up on your enemy list.";
		CSG_MENU_MAX_A = "Max Attackers";
		CSG_MENU_MAX_A_TOOLTIP = "|cffffffff"..CSG_MENU_MAX_A.."\n|cffffd200Choose how many attackers you want to show up on your enemy list.";
		CSG_MENU_TIMEOUT_NA = "Non-Attacker Timeout";
		CSG_MENU_TIMEOUT_NA_TOOLTIP = "|cffffffff"..CSG_MENU_TIMEOUT_NA.."\n|cffffd200Choose how long before non-attackers timeout and dissapear from your list.";
		CSG_MENU_TIMEOUT_A = "Attacker Timeout";
		CSG_MENU_TIMEOUT_A_TOOLTIP = "|cffffffff"..CSG_MENU_TIMEOUT_A.."\n|cffffd200Choose how long before attackers timeout and dissapear from your list.";
		CSG_MENU_TIMEOUT_H = "Healer/Buffer Timeout";
		CSG_MENU_TIMEOUT_H_TOOLTIP = "|cffffffff"..CSG_MENU_TIMEOUT_H.."\n|cffffd200Choose how long before healers/buffers timeout and dissapear from your list.";
		CSG_MENU_SOUNDS_ALL = "Enable All Sounds";
		CSG_MENU_SOUNDS_ALL_TOOLTIP = "|cffffffff"..CSG_MENU_SOUNDS_ALL.."\n|cffffd200Enables all "..CSG_TITLE_TOOLTIP.." sounds.  Uncheck this to keep "..CSG_TITLE_TOOLTIP.." from playing sounds.";
		--------------------------

		CSG_TEXT_WELCOME = "|cff3366ffCombat Sentry Gizmo v"..CSG_VERSION.."b est lanc\195\169 |cff20ff20(/csg pour les options)";
		CSG_TEXT_SLASHCOMMAND = "|cff20ff20/csg off|cff3366ff -Met CSG OFF, |cff20ff20/csg on|cff3366ff -Met CSG ON, |cff20ff20/csg toggle|cff3366ff -[ON/OFF] CSG, |cff20ff20/csg detect|cff3366ff -[ON/OFF] D\195\169tection des Ennemis, |cff20ff20/csg creatures|cff3366ff -[ON/OFF] Affichage des Cr\195\169atures, |cff20ff20/csg infotarget|cff3366ff -[ON/OFF] Information sur le ciblage Automatique";

		CSG_TEXT_ENEMYDETECTION_OFF = "D\195\169tection des Ennemis est maintenant : |cffff2020-OFF-";
		CSG_TEXT_ENEMYDETECTION_ON = "D\195\169tection des Ennemis est maintenant : |cff20ff20-ON-";
		CSG_TEXT_CREATURES_OFF = "Affichage des Cr\195\169atures est maintenant : |cffff2020-OFF-";
		CSG_TEXT_CREATURES_ON = "Affichage des Cr\195\169atures est maintenant : |cff20ff20-ON-";
		CSG_TEXT_CSG_OFF = "CSG est maintenant : |cffff2020-OFF-";
		CSG_TEXT_CSG_ON = "CSG est maintenant : |cff20ff20-ON-";

		CSG_L_YOU = "Vous";

		--CSG_DAM_HITBLOCK = "(.+) hits (.+) for (%d+). (.+) blocked";
		CSG_DAM_HITBLOCK = "(.+) hits (.+) for (%d+). (.+) blocked";
		CSG_DAM_HIT = "(.+) touche (.+) et inflige (%d+).+";
		CSG_DAM_CRIT = "(.+) touche (.+) avec un coup critique et inflige (%d+).+";

		CSG_SDAM_HIT = "(.+) de (.+) touche (.+) pour (%d+).+";
		CSG_SDAM_CRIT = "(.+) utilise (.+) et touche (.+) avec un coup critique, infligeant (%d+).+";
		CSG_SDAM_BLOCK = "(.+) utilise (.+), mais son adversaire bloque.";
		CSG_SDAM_BLOCKBY = "(.+) bloque (.+) de (.+)%.+";
		CSG_SDAM_DEFLECT = "(.+) de (.+) : d\195\169vi\195\169.";
		CSG_SDAM_DEFLECTBY = "(.+) d\195\169vie (.+) de (.+)%.";
		CSG_SDAM_DODGE = "(.+) utilise (.+), mais son adversaire esquive.";
		CSG_SDAM_DODGEBY = "(.+) esquive (.+) de .+)%.";
		CSG_SDAM_EVADE = "(.+) utilise (.+), mais son adversaire l\226\128\153\195\169vite.";
		CSG_SDAM_EVADEBY = "(.+) \195\169vite (.+) de (.+)%.";
		CSG_SDAM_FAIL = "(.+) de (.+) \195\169choue. Vous \195\170tes insensible.";
		CSG_SDAM_MISS = "(.+) de (.+) vous rate.";
		CSG_SDAM_PARRY = "You parry (.+)'s (.+)"; --??
		CSG_SDAM_RESIST = "(.+) utilise (.+), mais cela n\226\128\153a aucun effet.";
		CSG_SDAM_RESISTBY = "(.+) utilise (.+), mais (.+)%.";

		CSG_MISS_MISS = "(.+) manque (.+).";
		CSG_MISS_PARRY = "(.+) attaque, mais vous parez le coup.";
		CSG_MISS_EVADE = "(.+) attaque et vous l\226\128\153\195\169vitez.";
		CSG_MISS_DODGE = "(.+) attaque et vous esquivez.";
		CSG_MISS_DEFLECT = "(.+) attaque, mais vous d\195\169viez le coup.";
		CSG_MISS_BLOCK = "(.+) attaque, mais vous bloquez le coup.";
		CSG_MISS_ABSORB = "(.+) attaque. (.+) absorb";

		CSG_SPLL_HEALCRIT = "Le (.+) de (.+) soigne avec un effet critique (.+), pour (%d+) points de vie.";
		CSG_SPLL_HEAL = "(.+) de (.+) gu\195\169rit (.+) de (%d+).";
		CSG_SPLL_CAST = "(.+) lance (.+) sur (.+).";
		CSG_SPLL_CASTS = "(.+) utilise (.+) sur (.+) de (.+)%.+";
		CSG_SPLL_CASTS2 = "(.+) utilise (.+).";
		CSG_SPLL_GAINS = "(.+) gagne (.+).";
		CSG_SPLL_GAINS2 = "(.+) gagne.+";
		CSG_SPLL_BPERFORM = "(.+) commence \195\160 ex\195\169cuter (.+).";
		CSG_SPLL_BCAST = "(.+) commence \195\160 lancer (.+).";

		CSG_DIES = "(.+) meurt.";
		CSG_SLAINBY = "(.+) tue";


		CSG_MAGE = "Mage";
		CSG_WARLOCK = "D\195\169moniste";
		CSG_PRIEST = "Pr\195\170tre";
		CSG_DRUID = "Druide";
		CSG_SHAMAN = "Chaman";
		CSG_PALADIN = "Paladin";
		CSG_ROGUE = "Voleur";
		CSG_HUNTER = "Chasseur";
		CSG_WARRIOR = "Guerrier";
		CSG_UNKNOWN = "Inconnu";
	end


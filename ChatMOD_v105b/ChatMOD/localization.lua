SCCN_VER = "1.05b";
SCCN_LOCAL_CLASS = {};
SCCN_HELP = {};
SCCN_CMDSTATUS = {};
SCCN_STRIPCHAN = {};
SCCN_CUSTOM_INV = {};
SCCN_LOCAL_ZONE = {};
SCCN_TRANSLATE  = {};
SCCN_ILINK  = {};
-- key binding header
BINDING_HEADER_SCCNKEY			= "|cffaad372".."Chat".."|cfffff468".."MOD".."|cffffffff Key Bindings";
BINDING_NAME_SAYMESSAGE      	= "/say";
BINDING_NAME_YELLMESSAGE      	= "/yell";
BINDING_NAME_PARTYMESSAGE     	= "/party";
BINDING_NAME_GUILDMESSAGE     	= "/guild";
BINDING_NAME_RAIDMESSAGE      	= "/raid";
BINDING_NAME_OFFICERMESSAGE     = "/officer";
BINDING_NAME_CC1_MESSAGE		= "/1";
BINDING_NAME_CC2_MESSAGE		= "/2";
BINDING_NAME_CC3_MESSAGE		= "/3";
BINDING_NAME_CC4_MESSAGE		= "/4";
BINDING_NAME_CC5_MESSAGE		= "/5";
BINDING_NAME_CC6_MESSAGE		= "/6";
BINDING_NAME_CC7_MESSAGE		= "/7";
BINDING_NAME_CC8_MESSAGE		= "/8";
BINDING_NAME_CC9_MESSAGE		= "/9";
BINDING_NAME_CC10_MESSAGE		= "/10";
BINDING_NAME_WT_MESSAGE			= "/wt (whisper Target)";



-- General info, could be overwritten by translation:
SCCN_WELCOME = "|cff68ccefAddon:|cffCDCDCD ChatMOD by SkyHawk\n";
SCCN_WELCOME = SCCN_WELCOME.."|cff68ccefVersion:|cffCDCDCD "..SCCN_VER.."\n\n";	
SCCN_WELCOME = SCCN_WELCOME.."|cff68ccefAbout:|cffCDCDCD\nThank's for using ChatMOD. As far as you now nearly every WOW addon is coded in a privat persons sparetime so if you like it feel free to tell others about it, if you dislike something please poste me a short note on my webpage or on the curse Gaming ChatMOD Projekt page.\n\nYou can find the Curse projekt page by typing ChatMOD into the searchbox on www.curse-gaming.com or on my private webpage www.soalriz.de\n\nIf you find this Addon usefull please give me a vote @ curse !\n\nFor Information how to use this Addon, please type: |cffFF0000\n/chatmod\n\n\n";
SCCN_WELCOME = SCCN_WELCOME.."|cff68ccefAuthor:|cffCDCDCD Marco `sOLARiZ`Goetze\n";
SCCN_WELCOME = SCCN_WELCOME.."|cff68ccefAuthor's Webpage:|cffCDCDCD www.SOLARIZ.de\n";
SCCN_WELCOME = SCCN_WELCOME.."|cff68ccefAuthor's Realm:|cffCDCDCD EU-Aegwynn\n";
SCCN_WELCOME = SCCN_WELCOME.."|cff68ccefAuthor's Charname:|cffCDCDCD SkyHawk\n";
SCCN_WELCOME = SCCN_WELCOME.."|cff68ccefAuthor's Class:|cffCDCDCD Druid\n";
SCCN_WELCOME = SCCN_WELCOME.."|cff68ccefAuthor's Guild:|cffCDCDCD United, Alliance\n";
SCCN_LASTCHANGED = "|cff68ccefChanges for Version "..SCCN_VER.."\n\n|cffCDCDCD";
-- NEW
SCCN_LASTCHANGED = SCCN_LASTCHANGED.."|cff10ff10";
SCCN_LASTCHANGED = SCCN_LASTCHANGED.."Because there a several new features and many bugfixes I can't listup everything in here. So please have a look at to the |cffbababaREADME.html|cff10ff10 file which is in the Interface/Addons/ChatMOD/ Directory. This file contains a Changelog which every ChatMOD user should read !\n";
--SCCN_LASTCHANGED = SCCN_LASTCHANGED.."- new: InChatHighlight will highlight known names in chatmessages and make them clickable\n";
--SCCN_LASTCHANGED = SCCN_LASTCHANGED.."- new: AllSticky now toggle able\n";
--SCCN_LASTCHANGED = SCCN_LASTCHANGED.."- new: Added HTML Readme file.  README.html Please read !!!\n";
-- UPD
--SCCN_LASTCHANGED = SCCN_LASTCHANGED.."|cffbababa";
--SCCN_LASTCHANGED = SCCN_LASTCHANGED.."- fix: storing player names now in lower case\n";
--SCCN_LASTCHANGED = SCCN_LASTCHANGED.."- upd: Updated the colortable, class colors should be brighter now\n";
--SCCN_LASTCHANGED = SCCN_LASTCHANGED.."- upd: Fix for Bug #32 - Double lines in center of screen\n";
--SCCN_LASTCHANGED = SCCN_LASTCHANGED.."- upd: WHISPER is no Sticky Channel anymore\n";
--SCCN_LASTCHANGED = SCCN_LASTCHANGED.."- upd: Invites not clickable anymore if from person in raid or from self\n";
--SCCN_LASTCHANGED = SCCN_LASTCHANGED.."- upd: Request #31 included, Gossip skip more fluently\n";
--SCCN_LASTCHANGED = SCCN_LASTCHANGED.."- upd: Gossip skip now includes Vendors\nRemember: You can temporary disable Gossip skip by holding down <CTRL>\n";




--==============
--=   GERMAN   =
--==============
if ( GetLocale() == "deDE" ) then
	SCCN_INIT_CHANNEL_LOCAL			= "Allgemein";
	SCCN_GUI_HIGHLIGHT1				= "In diesem Dialog können Wörter angegeben werden welche SCCN hervorheben soll.";
	SCCN_LOCAL_CLASS["WARLOCK"] 	= "Hexenmeister";
	SCCN_LOCAL_CLASS["HUNTER"] 		= "J\195\164ger";
	SCCN_LOCAL_CLASS["PRIEST"] 		= "Priester";
	SCCN_LOCAL_CLASS["PALADIN"] 	= "Paladin";
	SCCN_LOCAL_CLASS["MAGE"] 		= "Magier";
	SCCN_LOCAL_CLASS["ROGUE"] 		= "Schurke";
	SCCN_LOCAL_CLASS["DRUID"] 		= "Druide";
	SCCN_LOCAL_CLASS["SHAMAN"] 		= "Schamane";
	SCCN_LOCAL_CLASS["WARRIOR"] 	= "Krieger";
	SCCN_LOCAL_ZONE["alterac"]	= "Alteractal";
	SCCN_LOCAL_ZONE["warsong"]	= "Warsongschlucht";
	SCCN_LOCAL_ZONE["arathi"]	= "Arathibecken";
	SCCN_CONFAB					= "|cffff0000Das 'confab' Addon wurde gefunden. SCCN Editbox Kontrolle wurde aus kompatibilitätsgründen deaktiviert!";
	SCCN_HELP[1]					= "Sol's Color chat Nicks - Command Hilfe:";
	SCCN_HELP[2]					= "|cff68ccef".."/chatmod hidechanname ".."|cffffffff".." Chat Kanalname wird ein/ausgeblendet";
	SCCN_HELP[3]					= "|cff68ccef".."/chatmod colornicks ".."|cffffffff".." Chat Nicknames nach Klasse färben  ein/ausschalten";
	SCCN_HELP[4]					= "|cff68ccef".."/chatmod purge".."|cffffffff".." Datenbank aufräumen. |cffa0a0a0(passiert auch automatisch wenn das Addon geladen wird)";
	SCCN_HELP[5]					= "|cff68ccef".."/chatmod killdb".."|cffffffff".." Datenbank komplett leeren. (kann nicht rückgängig gemacht werden)";
	SCCN_HELP[6]					= "|cff68ccef".."/chatmod mousescroll".."|cffffffff".." Im Chatfenster per Mausrad Scrollen ein/ausschalten. |cffa0a0a0(SHIFT-Mausrad = Schnelles scrollen, STRG-Mausrad = Anfang, Ende)";
	SCCN_HELP[7]					= "|cff68ccef".."/chatmod topeditbox".."|cffffffff".." Chat Eingabefeld oberhalb des chatfensters.";	
	SCCN_HELP[8]					= "|cff68ccef".."/chatmod timestamp".."|cffffffff".." Zeigt eine 24h Timestamp vor Chatnachrichten. SS:MM";
	SCCN_HELP[9]					= "|cff68ccef".."/chatmod colormap".."|cffffffff".." Raidmitglieder auf der Karte in Klassenfarbe darstellen.";	
	SCCN_HELP[10]					= "|cff68ccef".."/chatmod hyperlink".."|cffffffff".." Hyperlinks im Chat klickbar machen.";
	SCCN_HELP[11]					= "|cff68ccef".."/chatmod selfhighlight".."|cffffffff".." Eigenen namen in Chats hervorheben.";	
	SCCN_HELP[12]					= "|cff68ccef".."/chatmod clickinvite".."|cffffffff".." Macht das Wort [invite] im Chat klickbar. (Einladung bei Klick).";	
	SCCN_HELP[13]					= "|cff68ccef".."/chatmod editboxkeys".."|cffffffff".." Chat Editbox tasten ohne <ALT> nutzen & History buffer vergößern.";
	SCCN_HELP[14]					= "|cff68ccef".."/chatmod chatstring".."|cffffffff".." Angepasste Chat Zeichenketten.";	
	SCCN_HELP[15]					= "|cff68ccef".."/chatmod selfhighlightmsg".."|cffffffff".." OnScreen Ausgabe von Chatmeldungen mit eigenem Nickname.";	
	SCCN_HELP[16]					= "|cff68ccef".."/chatmod hidechatbuttons".."|cffffffff".." Chat Buttons ausblenden.";	
	SCCN_HELP[17]					= "|cff68ccef".."/chatmod highlight".."|cffffffff".." Angepasste Filter zur Hervorhebung von Worten im Chat.";
	SCCN_HELP[18]					= "|cff68ccef".."/chatmod AutoBGMap".."|cffffffff".." BGMinimap Autopupup.";
	SCCN_HELP[19]					= "|cff68ccef".."/chatmod shortchanname ".."|cffffffff".." Chat Kanalname wird verkürzt dargestellt";
	SCCN_HELP[20]					= "|cff68ccef".."/chatmod autogossipskip ".."|cffffffff".." Die info Fenster bei NPC's werden übersprungen. |cffa0a0a0(<STRG> drücken um kurzzeitig zu deaktivieren)";
	SCCN_HELP[21]					= "|cff68ccef".."/chatmod autodismount ".."|cffffffff".." Bei Flugpunkt NPC's wird automatisch vom Reittier abgestiegen.";
	SCCN_HELP[22]					= "|cff68ccef".."/chatmod inchathighlight ".."|cffffffff".."Highlight Known Nicknames";
	SCCN_HELP[23]					= "|cff68ccef".."/chatmod sticky ".."|cffffffff".."Sticky Chat behavior";	
	SCCN_HELP[24]					= "|cff68ccef".."/chatmod initchan <channelname>".."|cffffffff".."Setzt den standard Chatraum auf <channelname>";	
	SCCN_HELP[25]					= "|cff68ccef".."/chatmod nofade".."|cffffffff".."Der chattext wird nicht mehr nach gewisser Zeit ausgebeldet";
	SCCN_HELP[99]					= "|cff68ccef".."/chatmod status".."|cffffffff".." Aktuelle Einstellungen zeigen.";
	SCCN_TS_HELP					= "|cff68ccef".."/chatmod timestamp |cffFF0000FORMAT|cffffffff\n".."FORMAT:\n$h = Stunde (0-24) \n$t = Stunde (0-12) \n$m = Minute \n$s = Sekunde \n$p = Periode (am / pm)\n".."|cff909090Beispiel: /chatmod timestamp [$t:$m:$s $p]";
	SCCN_CMDSTATUS[1]				= "Kanalname ausblenden:";
	SCCN_CMDSTATUS[2]				= "Chat Nicknames in Klassenfarbe:";
	SCCN_CMDSTATUS[3]				= "Im Chat per Mausrad Scrollen:";
	SCCN_CMDSTATUS[4]				= "Chat Eingabefeld oben:";
	SCCN_CMDSTATUS[5]				= "Chat Timestamp:";
	SCCN_CMDSTATUS[6]				= "Spielerpins auf Karte in Klassenfarbe:";
	SCCN_CMDSTATUS[7]				= "Klickbare Hyperlinks:";
	SCCN_CMDSTATUS[8]				= "Eigenen Namen hervorheben:";
	SCCN_CMDSTATUS[9]				= "Click Invite:";
	SCCN_CMDSTATUS[10]				= "Chat Editbox Tasten ohne <alt> nutzen:";
	SCCN_CMDSTATUS[11]				= "Angepasste Chat Zeichenkette.";
	SCCN_CMDSTATUS[12]				= "Chatnachrichten OnScreen:";
	SCCN_CMDSTATUS[13]				= "Chat Buttons ausblenden:";
	SCCN_CMDSTATUS[14]				= "Automatischer Popup der Schlachtfeld MiniKarte:";
	SCCN_CMDSTATUS[15]				= "Angepasster Highlightfilter:";
	SCCN_CMDSTATUS[16]				= "Kanalname verkürzen:";
	SCCN_CMDSTATUS[17]				= "Auto Gossip Skip:";
	SCCN_CMDSTATUS[18]				= "Auto Dismount:";
	SCCN_CMDSTATUS[19]				= "Bekannte Namen hervorheben:";	
	SCCN_CMDSTATUS[20]				= "Letzten Chatraum merken (sticky):";	
	SCCN_CMDSTATUS[21]				= "Chattext nicht automatisch ausbleden:";	
	
	
	
	
	-- cursom invite word in the local language
	SCCN_CUSTOM_INV[0] 				= "einladen";	
	SCCN_CUSTOM_INV[1] 				= "inviten";
	-- Whispers customized
	SCCN_CUSTOM_CHT_FROM			= "von %s:";
	SCCN_CUSTOM_CHT_TO				= "zu %s:";		
	-- hide this channels aditional, feel free to add your own	
	SCCN_STRIPCHAN[1]				= "Gilde";
	SCCN_STRIPCHAN[2]				= "Schlachtzug";
	SCCN_STRIPCHAN[3]				= "Gruppe";
	SCCN_STRIPCHAN[4]				= "WeltVerteidigung";
	SCCN_STRIPCHAN[5]				= "Offizier";
	SCCN_STRIPCHAN[6]				= "SucheNachGruppe";
	SCCN_STRIPCHAN[7]				= "Allgemein";
	SCCN_STRIPCHAN[8]				= "Handel";
	SCCN_STRIPCHAN[9]				= "LokaleVerteidigung";
-- ItemLink Channels
    SCCN_ILINK[1]                   = "Allgemein -"
    SCCN_ILINK[2]                   = "Handel -"
    SCCN_ILINK[3]                   = "SucheNachGruppe -"
    SCCN_ILINK[4]                   = "LokaleVerteidigung -"
    SCCN_ILINK[5]                   = "WeltVerteidigung"
	
	SCCN_WELCOME = "|cff68ccefAddon:|cffCDCDCD Solariz Color Chat Nick's\n";
	SCCN_WELCOME = SCCN_WELCOME.."|cff68ccefVersion:|cffCDCDCD "..SCCN_VER.."\n\n";	
	SCCN_WELCOME = SCCN_WELCOME.."|cff68ccefÜber:|cffCDCDCD\nDanke das Du ChatMOD nutzt. Wie Du sicherlich weisst wurde nahezu jedes WOW Addon durch eine private Person in deren Freizeit unentgeldlich programmiert. Daher; Wenn dir dieses Addon gefällt erzähle bitte anderen davon, gibt es Funktionen die dir nicht gefallen so bitte ich Dich mir eine kurze Notiz darüber zu hinterlassen. Dies kannst du entweder auf meiner Webseite www.solariz.de oder auf der www.Curse-Gaming.com Projektseite. (Dort einfach nach ChatMOD suchen)\n\nFindest du dieses Addon nützlich vote bitte für mich auf Curse-Gaming !\n\nFür Info's zur Bedienung des Addons gibt bitte folgendes Kommando ein: |cffFF0000/chatmod\n\n\n";
	SCCN_WELCOME = SCCN_WELCOME.."|cff68ccefAutor:|cffCDCDCD Marco `sOLARiZ`Goetze\n";
	SCCN_WELCOME = SCCN_WELCOME.."|cff68ccefAutor's Webseite:|cffCDCDCD www.SOLARIZ.de\n";
	SCCN_WELCOME = SCCN_WELCOME.."|cff68ccefAutor's Realm:|cffCDCDCD EU-Aegwynn\n";
	SCCN_WELCOME = SCCN_WELCOME.."|cff68ccefAutor's Charname:|cffCDCDCD SkyHawk\n";
	SCCN_WELCOME = SCCN_WELCOME.."|cff68ccefAutor's Klass:|cffCDCDCD Druid\n";
	SCCN_WELCOME = SCCN_WELCOME.."|cff68ccefAutor's Gilde:|cffCDCDCD United, Alliance\n";
	SCCN_TRANSLATE[1]				= "Gilde";
	SCCN_TRANSLATE[2]				= "Offizier";
	SCCN_TRANSLATE[3]				= "Gruppe";
	SCCN_TRANSLATE[4]				= "Schlachtzug";
	SCCN_TRANSLATE[5]				= "Flüstern";
	SCCN_Highlighter				= "ChatMOD Hervorheben";
	SCCN_Config						= "ChatMOD Konfig";
	SCCN_Changelog					= "ChatMOD Aenderungen";
	

--==============
--= FRENCH =
--==============
-- French Translation by Sasmira
-- Sasmira's Profile: http://forums.curse-gaming.com/member.php?u=2633
-- Last Update 01/31/2006
-- Thank's alot !!!
elseif ( GetLocale() == "frFR" ) then
	SCCN_INIT_CHANNEL_LOCAL			= "General";
	SCCN_GUI_HIGHLIGHT1				= "In this Dialogue you can enter Words which ChatMOD should Highlight. Each Line is one Word.";
	SCCN_LOCAL_CLASS["WARLOCK"] = "D\195\169moniste";
	SCCN_LOCAL_CLASS["HUNTER"] = "Chasseur";
	SCCN_LOCAL_CLASS["PRIEST"] = "Pr\195\170tre";
	SCCN_LOCAL_CLASS["PALADIN"] = "Paladin";
	SCCN_LOCAL_CLASS["MAGE"] = "Mage";
	SCCN_LOCAL_CLASS["ROGUE"] = "Voleur";
	SCCN_LOCAL_CLASS["DRUID"] = "Druide";
	SCCN_LOCAL_CLASS["SHAMAN"] = "Chaman";
	SCCN_LOCAL_CLASS["WARRIOR"] = "Guerrier";
	-- Zones, partly Translation Needed
	SCCN_LOCAL_ZONE["alterac"]	= "Vall\195\169e d'Alterac";
	SCCN_LOCAL_ZONE["warsong"]	= "Goulet des Warsong";
	SCCN_LOCAL_ZONE["arathi"]	= "Arathi Basin";
	-- Translation completed
	SCCN_CONFAB = "|cffff0000L\'Addon Confab a \195\169t\195\169 trouv\195\169. Les fonctions SCCN Editbox ont \195\169t\195\169 d\195\169sactiv\195\169es par soucis de compatibilit\195\169";
	SCCN_HELP[1] = "Sol's Color chat Nicks - Aide, ligne de commandes:";
	SCCN_HELP[2] = "|cff68ccef".."/chatmod hidechanname ".."|cffffffff".." [ON/OFF] supression du nom du canal";
	SCCN_HELP[3] = "|cff68ccef".."/chatmod colornicks ".."|cffffffff".." [ON/OFF] Coloration par classe du nom du joueur dans le Chat";
	SCCN_HELP[4] = "|cff68ccef".."/chatmod purge".."|cffffffff".." Lancement d\'une purge standard de Base de Donn\195\169es. |cffa0a0a0(S\'ex\195\169cute automatiquement \195\160 chaque lancement de l\'addon)";
	SCCN_HELP[5] = "|cff68ccef".."/chatmod killdb".."|cffffffff".." Supprime compl\195\168tement la Base de Donn\195\169es. (D\195\169finitif)";
	SCCN_HELP[6] = "|cff68ccef".."/chatmod mousescroll".."|cffffffff".." [ON/OFF] chat scroll avec la molette de la souris. |cffa0a0a0(<SHIFT>-Molette = Scroll Rapide, <STRG>-Molette = Top, Bottom)";
	SCCN_HELP[7] = "|cff68ccef".."/chatmod topeditbox".."|cffffffff".." D\195\169placer le menu du Chat en haut de la fen\195\170tre de Chat.";
	SCCN_HELP[8] = "|cff68ccef".."/chatmod timestamp".."|cffffffff".." Afficher en 24h le Timestamp dans la fen\195\170tre de Chat. HH:MM";
	SCCN_HELP[9] = "|cff68ccef".."/chatmod colormap".."|cffffffff".." Coloration des membres du Raid par classe dans la Map.";
	SCCN_HELP[10] = "|cff68ccef".."/chatmod hyperlink".."|cffffffff".." Rendre les Hypertextes clicable dans le Chat.";
	SCCN_HELP[11] = "|cff68ccef".."/chatmod selfhighlight".."|cffffffff".." Highlight sur le nom de votre personnage dans les Chats.";
	SCCN_HELP[12] = "|cff68ccef".."/chatmod clickinvite".."|cffffffff".." Rendre le mot [invite] clicable dans les chats (invite sur clic).";
	SCCN_HELP[13] = "|cff68ccef".."/chatmod editboxkeys".."|cffffffff".." Utiliser les cl\195\169s du menu de Chat sans presser la touche <ALT> & augmenter le cache de l\'historique.";
	SCCN_HELP[14] = "|cff68ccef".."/chatmod chatstring".."|cffffffff".." Personnalisation des lignes de Chat.";
	SCCN_HELP[15] = "|cff68ccef".."/chatmod selfhighlightmsg".."|cffffffff".." Afficher \195\160 l\'\195\169cran les messages contenants votre nom \195\160 l\'\195\169cran.";
	SCCN_HELP[16] = "|cff68ccef".."/chatmod hidechatbuttons".."|cffffffff".." Hide Chat Buttons.";	
	SCCN_HELP[17] = "|cff68ccef".."/chatmod highlight".."|cffffffff".." Custom filter dialogue for highlighting Words in Chat.";	
	SCCN_HELP[18] = "|cff68ccef".."/chatmod AutoBGMap".."|cffffffff".." BGMinimap Autopupup.";		
	SCCN_HELP[19] = "|cff68ccef".."/chatmod shortchanname ".."|cffffffff".." Displays Short channelname.";	
	SCCN_HELP[20] = "|cff68ccef".."/chatmod autogossipskip ".."|cffffffff".." Skip the gossip Window automaticaly. |cffa0a0a0(Press <CTRL> to deactivate skip)";
	SCCN_HELP[21] = "|cff68ccef".."/chatmod autodismount ".."|cffffffff".." Auto Dismounts at taxi NPCs";
	SCCN_HELP[22]					= "|cff68ccef".."/chatmod inchathighlight ".."|cffffffff".."Highlight Known Nicknames";	
	SCCN_HELP[23]					= "|cff68ccef".."/chatmod sticky ".."|cffffffff".."Sticky Chat behavior";	
	SCCN_HELP[24]					= "|cff68ccef".."/chatmod initchan <channelname>".."|cffffffff".."Set the specified <channelname> to default chatfram on startup.";		
	SCCN_HELP[25]					= "|cff68ccef".."/chatmod nofade".."|cffffffff".."Disable fading of Chattext";
	SCCN_HELP[99] = "|cff68ccef".."/chatmod status".."|cffffffff".." Afficher la configuration courante.";
	SCCN_TS_HELP = "|cff68ccef".."/chatmod timestamp |cffFF0000FORMAT|cffffffff\n".."FORMAT:\n$h = heure (0-24) \n$t = heure (0-12) \n$m = minutes \n$s = secondes \n$p = periode (am / pm)\n".."|cff909090Exemple: /chatmod timestamp [$t:$m:$s $p]";
	SCCN_CMDSTATUS[1] = "Suppression du nom du canal:";
	SCCN_CMDSTATUS[2] = "Coloration par classe du nom dans le Chat:";
	SCCN_CMDSTATUS[3] = "Scroll Chat avec la molette de la souris:";
	SCCN_CMDSTATUS[4] = "Menu du canal en haut:";
	SCCN_CMDSTATUS[5] = "Chat Timestamp:";
	SCCN_CMDSTATUS[6] = "Coloration des membres du Raid par classe dans la Map:";
	SCCN_CMDSTATUS[7] = "Hypertextes Clicables:";
	SCCN_CMDSTATUS[8] = "Highlight sur soi-m\195\170me:";
	SCCN_CMDSTATUS[9] = "Invite sur clic:";
	SCCN_CMDSTATUS[10] = "Utilisation des cl\195\169s du menu de Chat sans presser la touche <ALT>:";
	SCCN_CMDSTATUS[11] = "Personnalisation des lignes de Chat:";
	SCCN_CMDSTATUS[12] = "Affichage \195\160 l\'\195\169cran les messages contenants votre nom:";
	SCCN_CMDSTATUS[13] = "Hide Chat Buttons:";
	SCCN_CMDSTATUS[14] = "BG Minimap Autopopup:";
	SCCN_CMDSTATUS[15] = "Custom Highlight:";
	SCCN_CMDSTATUS[16] = "Short du canal:";
	SCCN_CMDSTATUS[17]				= "Auto Gossip Skip:";
	SCCN_CMDSTATUS[18]				= "Auto Dismount:";	
	SCCN_CMDSTATUS[19]				= "In Chat Highlight:";	
	SCCN_CMDSTATUS[20]				= "Remeber last Chatroom (sticky):";
	SCCN_CMDSTATUS[21]				= "Don't Fade chattext automaticaly:";
	-- cursom invite word in the local language
	SCCN_CUSTOM_INV[0] = "invite";
	-- Whispers customized
	SCCN_CUSTOM_CHT_FROM = "de %s:";
	SCCN_CUSTOM_CHT_TO = "à %s:";
	-- hide this channels aditional, feel free to add your own
	SCCN_STRIPCHAN[1] = "Guilde";
	SCCN_STRIPCHAN[2] = "Raid";
	SCCN_STRIPCHAN[3] = "Groupe";
-- ItemLink Channels
    SCCN_ILINK[1]                   = "General -"
    SCCN_ILINK[2]                   = "Trade -"
    SCCN_ILINK[3]                   = "LookingForGroup -"
    SCCN_ILINK[4]                   = "LocalDefense -"
    SCCN_ILINK[5]                   = "WorldDefense"	
	
	-- some general channel name translation for the GUI
	SCCN_TRANSLATE[1]				= "Guilde";
	SCCN_TRANSLATE[2]				= "Officer";
	SCCN_TRANSLATE[3]				= "Groupe";
	SCCN_TRANSLATE[4]				= "Raid";
	SCCN_TRANSLATE[5]				= "Whisper";
	SCCN_Highlighter				= "Highlight";
	SCCN_Config						= "Config";
	SCCN_Changelog					= "Changelog";	


--==============
--= CHINA =
--==============
-- Chinese Simplified by q09q09
-- q09q09' Profile: http://forums.curse-gaming.com/member.php?u=43339
-- Last Update 07/09/2006
-- Thank's alot !!!
elseif ( GetLocale() == "zhCN" ) then
	SCCN_INIT_CHANNEL_LOCAL			= "General";
	SCCN_GUI_HIGHLIGHT1				= "在这对话输入你要 SCCN 显示的词。 各行输入一个词";
	SCCN_LOCAL_CLASS["WARLOCK"] 	= "术士";
	SCCN_LOCAL_CLASS["HUNTER"] 	= "猎人";
	SCCN_LOCAL_CLASS["PRIEST"] 	= "牧师";
	SCCN_LOCAL_CLASS["PALADIN"] 	= "圣骑士";
	SCCN_LOCAL_CLASS["MAGE"] 	= "法师";
	SCCN_LOCAL_CLASS["ROGUE"] 	= "盗贼";
	SCCN_LOCAL_CLASS["DRUID"] 	= "德鲁伊";
	SCCN_LOCAL_CLASS["SHAMAN"] 	= "萨满祭司";
	SCCN_LOCAL_CLASS["WARRIOR"] 	= "战士";
	SCCN_LOCAL_ZONE["alterac"]	= "奥特兰克山谷";
	SCCN_LOCAL_ZONE["warsong"]	= "战歌峡谷";
	SCCN_LOCAL_ZONE["arathi"]	= "阿拉希盆地";
	SCCN_CONFAB			= "|cffff0000你有安装Confab。为了兼容性，SCCN的输入框相关功能取消！";
	SCCN_HELP[1]			= "Sol's Color chat Nicks - 指令说明:";
	SCCN_HELP[2]			= "|cff68ccef".."/chatmod hidechanname".."|cffffffff".." 隐藏频道名称";
	SCCN_HELP[3]			= "|cff68ccef".."/chatmod colornicks".."|cffffffff".." 以职业颜色显示玩家名字";
	SCCN_HELP[4]			= "|cff68ccef".."/chatmod purge".."|cffffffff".." 整理SCCN数据库。 |cffa0a0a0(每次载入此ui时都会自动执行这个动作。)";
	SCCN_HELP[5]			= "|cff68ccef".."/chatmod killdb".."|cffffffff".." 完整地把SCCN数据库清除。 (无法复原)";
	SCCN_HELP[6]			= "|cff68ccef".."/chatmod mousescroll".."|cffffffff".." 使用鼠标滚轮滚动对话框。 |cffa0a0a0(按住<SHIFT>-鼠标滚轮=快翻，按住<CTRL>-鼠标滚轮=翻至尽头, <STRG>-Molette = Top, Bottom)";
	SCCN_HELP[7]			= "|cff68ccef".."/chatmod topeditbox".."|cffffffff".." 对话输入框显示在聊天窗口的上面。";	
	SCCN_HELP[8]			= "|cff68ccef".."/chatmod timestamp".."|cffffffff".." 显示时间戳在每条信息之前。输入|cffa0a0a0 /chatmod timestamp ?|cffffffff 显示更改格式说明。";
	SCCN_HELP[9]			= "|cff68ccef".."/chatmod colormap".."|cffffffff".." 小地图上的团队成员以职业颜色标记。";	
	SCCN_HELP[10]			= "|cff68ccef".."/chatmod hyperlink".."|cffffffff".." 让对话消息里的URL可被选择复制！";
	SCCN_HELP[11]			= "|cff68ccef".."/chatmod selfhighlight".."|cffffffff".." 在对话消息中把自己名字明显标示！";
	SCCN_HELP[12]			= "|cff68ccef".."/chatmod clickinvite".."|cffffffff".." 让对话消息中的[邀请]能直接被点选以加入队伍。";	
	SCCN_HELP[13] 			= "|cff68ccef".."/chatmod editboxkeys".."|cffffffff".." 在对话输入框里不需要按住<ALT>键就能用方向键做编辑 & 历史纪录缓冲区增加至256行！";
	SCCN_HELP[14] 			= "|cff68ccef".."/chatmod chatstring".."|cffffffff".." 简化密语字串。";
	SCCN_HELP[15] 			= "|cff68ccef".."/chatmod selfhighlightmsg".."|cffffffff".." 包含自己名字的对话消息会另外显示在屏幕上方，须开启 /chatmod selfhighlight";	
	SCCN_HELP[16]			= "|cff68ccef".."/chatmod hidechatbuttons".."|cffffffff".." 隐藏聊天按钮。";	
	SCCN_HELP[17]			= "|cff68ccef".."/chatmod highlight".."|cffffffff".." 在聊天中高亮显示自定义词.";	
	SCCN_HELP[18]			= "|cff68ccef".."/chatmod AutoBGMap".."|cffffffff".." BGMinimap Autopupup.";	
	SCCN_HELP[19]			= "|cff68ccef".."/chatmod shortchanname ".."|cffffffff".." 显示简略频道名.";	
	SCCN_HELP[20]			= "|cff68ccef".."/chatmod autogossipskip ".."|cffffffff".." 自动跳过闲谈窗口. |cffa0a0a0(按住 <CTRL> 则撤销跳过)";
	SCCN_HELP[21]			= "|cff68ccef".."/chatmod autodismount ".."|cffffffff".." 与飞行点管理员对话时自动下马";	
	SCCN_HELP[22]					= "|cff68ccef".."/chatmod inchathighlight ".."|cffffffff".."Highlight Known Nicknames";	
	SCCN_HELP[23]					= "|cff68ccef".."/chatmod sticky ".."|cffffffff".."Sticky Chat behavior";	
	SCCN_HELP[24]					= "|cff68ccef".."/chatmod initchan <channelname>".."|cffffffff".."Set the specified <channelname> to default chatfram on startup.";		
	SCCN_HELP[25]					= "|cff68ccef".."/chatmod nofade".."|cffffffff".."Disable fading of Chattext";
	SCCN_HELP[99]			= "|cff68ccef".."/chatmod status".."|cffffffff".." 显示目前设置。";
	SCCN_TS_HELP  			= "|cff68ccef".."/chatmod timestamp |cffFF0000FORMAT|cffffffff\n".."FORMAT:\n$h = 小时 (0-24) \n$t = 小时 (0-12) \n$m = 分钟 \n$s = 秒 \n$p = 上午/下午 (am / pm)\n".."|cff909090Example: /chatmod timestamp [$t:$m:$s $p]";
	SCCN_CMDSTATUS[1]		= "隐藏频道名称:";
	SCCN_CMDSTATUS[2]		= "以职业颜色显示玩家名字:";
	SCCN_CMDSTATUS[3]		= "使用鼠标滚轮滚动对话框:";
	SCCN_CMDSTATUS[4]		= "对话输入框顶置:";
	SCCN_CMDSTATUS[5]		= "加入消息时间:";
	SCCN_CMDSTATUS[6]		= "小地图上的队伍成员以职业颜色标记:";
	SCCN_CMDSTATUS[7]		= "URL可点选复制:";
	SCCN_CMDSTATUS[8]		= "明显标示自己的名字:";
	SCCN_CMDSTATUS[9]		= "对话框中的邀请信息可以被点选:";
	SCCN_CMDSTATUS[10]		= "对话编辑不需按住<ALT>:";
	SCCN_CMDSTATUS[11]		= "自定密语消息:";
	SCCN_CMDSTATUS[12]		= "额外显示包含自己名字的消息:";
	SCCN_CMDSTATUS[13]		= "隐藏聊天按钮:";
	SCCN_CMDSTATUS[14] 		= "战场自动打开小地图:";
	SCCN_CMDSTATUS[15] 		= "自定义高亮:";
	SCCN_CMDSTATUS[16] 		= "简略频道名:";
	SCCN_CMDSTATUS[17]		= "闲谈自动跳过:";
	SCCN_CMDSTATUS[18]		= "自动下马:";	
	SCCN_CMDSTATUS[19]				= "In Chat Highlight:";	
	SCCN_CMDSTATUS[20]				= "Remeber last Chatroom (sticky):";	
	SCCN_CMDSTATUS[21]				= "Don't Fade chattext automaticaly:";
	-- cursom invite word in the local language
	SCCN_CUSTOM_INV[0]		= "邀请";
	SCCN_CUSTOM_INV[1] 		= "邀请";
	-- Whispers customized
	SCCN_CUSTOM_CHT_FROM		= "%s说：";
	SCCN_CUSTOM_CHT_TO		= "密%s：";	
	-- hide this channels aditional, feel free to add your own
	SCCN_STRIPCHAN[1]		= "工会";
	SCCN_STRIPCHAN[2]		= "团队";
	SCCN_STRIPCHAN[3]		= "小队";		
	SCCN_STRIPCHAN[4]		= "世界防务";
	SCCN_STRIPCHAN[5]		= "官员";
-- ItemLink Channels
    SCCN_ILINK[1]                   = "General -"
    SCCN_ILINK[2]                   = "Trade -"
    SCCN_ILINK[3]                   = "LookingForGroup -"
    SCCN_ILINK[4]                   = "LocalDefense -"
    SCCN_ILINK[5]                   = "WorldDefense"	
	-- some general channel name translation for the GUI
	SCCN_TRANSLATE[1]				= "工会";
	SCCN_TRANSLATE[2]				= "官员";
	SCCN_TRANSLATE[3]				= "小队";
	SCCN_TRANSLATE[4]				= "团队";
	SCCN_TRANSLATE[5]				= "密语";	
	SCCN_Highlighter				= "ChatMOD 高亮";
	SCCN_Config						= "ChatMOD 设置";
	SCCN_Changelog					= "ChatMOD 更新日志";	

--==============
--= TAIWAN =
--==============
-- Chinese Translation by Chris
-- Chris' Profile: http://forums.curse-gaming.com/member.php?u=47448
-- Last Update 01/31/2006
-- Thank's alot !!!
elseif ( GetLocale() == "zhTW" ) then
	SCCN_INIT_CHANNEL_LOCAL			= "General";
	SCCN_GUI_HIGHLIGHT1				= "In this Dialogue you can enter Words which ChatMOD should Highlight. Each Line is one Word.";
	SCCN_LOCAL_CLASS["WARLOCK"] 	= "術士";
	SCCN_LOCAL_CLASS["HUNTER"] 	= "獵人";
	SCCN_LOCAL_CLASS["PRIEST"] 	= "牧師";
	SCCN_LOCAL_CLASS["PALADIN"] 	= "聖騎士";
	SCCN_LOCAL_CLASS["MAGE"] 	= "法師";
	SCCN_LOCAL_CLASS["ROGUE"] 	= "盜賊";
	SCCN_LOCAL_CLASS["DRUID"] 	= "德魯伊";
	SCCN_LOCAL_CLASS["SHAMAN"] 	= "薩滿";
	SCCN_LOCAL_CLASS["WARRIOR"] 	= "戰士";
	-- Zones, Translation Needed
	SCCN_LOCAL_ZONE["alterac"]	= "Alterac Valley";
	SCCN_LOCAL_ZONE["warsong"]	= "Warsong Gulch";
	SCCN_LOCAL_ZONE["arathi"]	= "Arathi Basin";
	SCCN_CONFAB			= "|cffff0000你有安裝Confab。為了相容性，SCCN的輸入框相關功能取消！";
	SCCN_HELP[1]			= "Sol's Color chat Nicks - 指令說明:";
	SCCN_HELP[2]			= "|cff68ccef".."/chatmod hidechanname".."|cffffffff".." 隱藏頻道名稱";
	SCCN_HELP[3]			= "|cff68ccef".."/chatmod colornicks".."|cffffffff".." 以職業顏色顯示玩家名字";
	SCCN_HELP[4]			= "|cff68ccef".."/chatmod purge".."|cffffffff".." 整理SCCN資料庫。 |cffa0a0a0(每次載入此ui時都會自動做這個動作。)";
	SCCN_HELP[5]			= "|cff68ccef".."/chatmod killdb".."|cffffffff".." 完整地把SCCN資料庫清除。 (無法復原)";
	SCCN_HELP[6]			= "|cff68ccef".."/chatmod mousescroll".."|cffffffff".." 用滑鼠滾輪捲動對話欄。 |cffa0a0a0(按著<SHIFT>-滑鼠滾輪=快捲，按著<CTRL>-滑鼠滾輪=捲至盡頭)";
	SCCN_HELP[7]			= "|cff68ccef".."/chatmod topeditbox".."|cffffffff".." 對話輸入框顯示在聊天視窗的最上頭。";	
	SCCN_HELP[8]			= "|cff68ccef".."/chatmod timestamp".."|cffffffff".." 顯示時間戳記在每列訊息之前。鍵入|cffa0a0a0 /chatmod timestamp ?|cffffffff 顯示更改格式說明。";
	SCCN_HELP[9]			= "|cff68ccef".."/chatmod colormap".."|cffffffff".." 小地圖上的團隊成員以職業顏色標記。";	
	SCCN_HELP[10]			= "|cff68ccef".."/chatmod hyperlink".."|cffffffff".." 讓對話訊息裡的網頁連結可被點選複製！";
	SCCN_HELP[11]			= "|cff68ccef".."/chatmod selfhighlight".."|cffffffff".." 在對話訊息中把自己名字明顯標示！";
	SCCN_HELP[12]			= "|cff68ccef".."/chatmod clickinvite".."|cffffffff".." 讓對話訊息中的[邀請]能直接被點選以加入隊伍。";	
	SCCN_HELP[13] 			= "|cff68ccef".."/chatmod editboxkeys".."|cffffffff".." 在對話輸入框裡不需按著<ALT>鍵就能用方向鍵做編輯 & 歷史記錄緩衝區增加至256行！";
	SCCN_HELP[14] 			= "|cff68ccef".."/chatmod chatstring".."|cffffffff".." 簡化密語字串。";
	SCCN_HELP[15] 			= "|cff68ccef".."/chatmod selfhighlightmsg".."|cffffffff".." 包含自己名字的對話訊息會另外顯示在螢幕上方，須開啟 /chatmod selfhighlight";	
	SCCN_HELP[16]			= "|cff68ccef".."/chatmod hidechatbuttons".."|cffffffff".." Hide Chat Buttons.";	
	SCCN_HELP[17]					= "|cff68ccef".."/chatmod highlight".."|cffffffff".." Custom filter dialogue for highlighting Words in Chat.";	
	SCCN_HELP[18]					= "|cff68ccef".."/chatmod AutoBGMap".."|cffffffff".." BGMinimap Autopupup.";	
	SCCN_HELP[19] = "|cff68ccef".."/chatmod shortchanname ".."|cffffffff".." Displays Short channelname.";	
	SCCN_HELP[20] = "|cff68ccef".."/chatmod autogossipskip ".."|cffffffff".." Skip the gossip Window automaticaly. |cffa0a0a0(Press <CTRL> to deactivate skip)";
	SCCN_HELP[21] = "|cff68ccef".."/chatmod autodismount ".."|cffffffff".." Auto Dismounts at taxi NPCs";	
	SCCN_HELP[22]					= "|cff68ccef".."/chatmod inchathighlight ".."|cffffffff".."Highlight Known Nicknames";
	SCCN_HELP[23]					= "|cff68ccef".."/chatmod sticky ".."|cffffffff".."Sticky Chat behavior";	
	SCCN_HELP[24]					= "|cff68ccef".."/chatmod initchan <channelname>".."|cffffffff".."Set the specified <channelname> to default chatfram on startup.";		
	SCCN_HELP[25]					= "|cff68ccef".."/chatmod nofade".."|cffffffff".."Disable fading of Chattext";
	SCCN_HELP[99]			= "|cff68ccef".."/chatmod status".."|cffffffff".." 顯示目前設置。";
	SCCN_TS_HELP  			= "|cff68ccef".."/chatmod timestamp |cffFF0000FORMAT|cffffffff\n".."FORMAT:\n$h = 小時 (0-24) \n$t = 小時 (0-12) \n$m = 分鐘 \n$s = 秒 \n$p = 午前/午後 (am / pm)\n".."|cff909090Example: /chatmod timestamp [$t:$m:$s $p]";
	SCCN_CMDSTATUS[1]		= "隱藏頻道名稱:";
	SCCN_CMDSTATUS[2]		= "以職業顏色顯示名字:";
	SCCN_CMDSTATUS[3]		= "使用滑鼠滾輪捲動聊天視窗:";
	SCCN_CMDSTATUS[4]		= "對話輸入欄置頂:";
	SCCN_CMDSTATUS[5]		= "加入訊息時間:";
	SCCN_CMDSTATUS[6]		= "小地圖上的隊伍成員以職業顏色標記:";
	SCCN_CMDSTATUS[7]		= "網頁連結可點選複製:";
	SCCN_CMDSTATUS[8]		= "明顯標示自己的名字:";
	SCCN_CMDSTATUS[9]		= "對話欄中的邀請訊息可被點選:";
	SCCN_CMDSTATUS[10]		= "對話編輯不需按住<ALT>:";
	SCCN_CMDSTATUS[11]		= "自定密語訊息:";
	SCCN_CMDSTATUS[12]		= "額外顯示包含自己名字的訊息:";
	SCCN_CMDSTATUS[13]		= "Hide Chat Buttons:";
	SCCN_CMDSTATUS[14] 		= "BG Minimap Autopopup:";
	SCCN_CMDSTATUS[15] 		= "Custom Highlight:";
	SCCN_CMDSTATUS[16] 		= "Short Channelname:";
	SCCN_CMDSTATUS[17]				= "Auto Gossip Skip:";
	SCCN_CMDSTATUS[18]				= "Auto Dismount:";	
	SCCN_CMDSTATUS[19]				= "In Chat Highlight:";	
	SCCN_CMDSTATUS[20]				= "Remeber last Chatroom (sticky):";	
	SCCN_CMDSTATUS[21]				= "Don't Fade chattext automaticaly:";
	-- cursom invite word in the local language
	SCCN_CUSTOM_INV[0]		= "++";
	-- Whispers customized
	SCCN_CUSTOM_CHT_FROM		= "%s說：";
	SCCN_CUSTOM_CHT_TO		= "密%s：";	
	-- hide this channels aditional, feel free to add your own
	SCCN_STRIPCHAN[1]		= "公會";
	SCCN_STRIPCHAN[2]		= "團隊";
	SCCN_STRIPCHAN[3]		= "小隊";	
-- ItemLink Channels
    SCCN_ILINK[1]                   = "General -"
    SCCN_ILINK[2]                   = "Trade -"
    SCCN_ILINK[3]                   = "LookingForGroup -"
    SCCN_ILINK[4]                   = "LocalDefense -"
    SCCN_ILINK[5]                   = "WorldDefense"	
	-- some general channel name translation for the GUI
	SCCN_TRANSLATE[1]				= "Guild";
	SCCN_TRANSLATE[2]				= "Officer";
	SCCN_TRANSLATE[3]				= "Group";
	SCCN_TRANSLATE[4]				= "Raid";
	SCCN_TRANSLATE[5]				= "Whisper";	
	SCCN_Highlighter				= "ChatMOD Highlight";
	SCCN_Config						= "ChatMOD Config";
	SCCN_Changelog					= "ChatMOD Changelog";		

	
--==============
--=   KOREAN   =
--==============
elseif ( GetLocale() == "koKR" ) then
	SCCN_GUI_HIGHLIGHT1				= "여기에 입력하는 단어를 강조할 수 있습니다. 한줄에 한단어씩만 가능합니다.";
	SCCN_LOCAL_CLASS["WARLOCK"] 			= "흑마법사";
	SCCN_LOCAL_CLASS["HUNTER"] 			= "사냥꾼";
	SCCN_LOCAL_CLASS["PRIEST"] 			= "사제";
	SCCN_LOCAL_CLASS["PALADIN"] 			= "성기사";
	SCCN_LOCAL_CLASS["MAGE"] 			= "마법사";
	SCCN_LOCAL_CLASS["ROGUE"] 			= "도적";
	SCCN_LOCAL_CLASS["DRUID"] 			= "드루이드";
	SCCN_LOCAL_CLASS["SHAMAN"] 			= "주술사";
	SCCN_LOCAL_CLASS["WARRIOR"] 			= "전사";
	-- Zones
	SCCN_LOCAL_ZONE["alterac"]			= "알터랙 계곡";
	SCCN_LOCAL_ZONE["warsong"]			= "전쟁노래 협곡";
	SCCN_LOCAL_ZONE["arathi"]			= "아라시 분지";
	SCCN_CONFAB					= "|cffff0000The Confab Addon was found. SCCN Editbox functions are disabled due to compatibility!";
	SCCN_HELP[1]					= "ChatMOD - 명령어 도움말:";
	SCCN_HELP[2]					= "|cff68ccef".."/chatmod hidechanname ".."|cffffffff".." 채널이름 숨기기";
	SCCN_HELP[3]					= "|cff68ccef".."/chatmod colornicks ".."|cffffffff".." 캐릭터의 직업에 따라 캐릭터 이름의 색상 표시";
	SCCN_HELP[4]					= "|cff68ccef".."/chatmod purge".."|cffffffff".."자료 초기화 실행 |cffa0a0a0(애드온을 재시작 할때마다 자동으로 실행)";
	SCCN_HELP[5]					= "|cff68ccef".."/chatmod killdb".."|cffffffff".." 저장된 자료 모두 삭제 (되돌리기 불가능)";
	SCCN_HELP[6]					= "|cff68ccef".."/chatmod mousescroll".."|cffffffff".." 마우스 휠을 이용하여 채팅창 스크롤.\n|cffa0a0a0(SHIFT+휠 = 빠른 스크롤, STRG+휠버튼 = 채팅창 맨위 또는 맨아래로 이동)";
	SCCN_HELP[7]					= "|cff68ccef".."/chatmod topeditbox".."|cffffffff".." 채팅 입력창을 채팅창 위로 이동";
	SCCN_HELP[8]					= "|cff68ccef".."/chatmod timestamp".."|cffffffff".." 채팅창에 시간 표시. (기본 형식은 [HH:MM])";
	SCCN_HELP[9]					= "|cff68ccef".."/chatmod colormap".."|cffffffff".." 월드맵에 공대원의 위치를 직업에 따라 색상으로 표시";
	SCCN_HELP[10]					= "|cff68ccef".."/chatmod hyperlink".."|cffffffff".." 웹페이지를 복사할 수 있는 창 띄우기";
	SCCN_HELP[11]					= "|cff68ccef".."/chatmod selfhighlight".."|cffffffff".." 자신의 캐릭터 이름을 강조.\n(형식은 >캐릭터이름<)";
	SCCN_HELP[12]					= "|cff68ccef".."/chatmod clickinvite".."|cffffffff".." 특정단어를 클릭하면 자동으로 파티에 초대.\n(초대 가능 단어: 초대, 손, ㅅㅅ, ㅅ)";
	SCCN_HELP[13] 					= "|cff68ccef".."/chatmod editboxkeys".."|cffffffff".." ALT키를 누르지 않고 채팅 입력창에 기록한 내용 수정하기";
	SCCN_HELP[14] 					= "|cff68ccef".."/chatmod chatstring".."|cffffffff".." 귓속말 짧게 표시 사용";
	SCCN_HELP[15] 					= "|cff68ccef".."/chatmod selfhighlightmsg".."|cffffffff".." 자신의 캐릭터 이름을 화면 가운데 표시";	
	SCCN_HELP[16]					= "|cff68ccef".."/chatmod hidechatbuttons".."|cffffffff".." 채팅 버튼 숨기기";	
	SCCN_HELP[17]					= "|cff68ccef".."/chatmod highlight".."|cffffffff".." 사용자 채팅 강조 구문 사용";	
	SCCN_HELP[18]					= "|cff68ccef".."/chatmod AutoBGMap".."|cffffffff".." 전장 진입시 자동으로 전장미니맵 표시";	
	SCCN_HELP[19]					= "|cff68ccef".."/chatmod shortchanname ".."|cffffffff".." 짧은 채널이름 사용";	
	SCCN_HELP[20]					= "|cff68ccef".."/chatmod autogossipskip ".."|cffffffff".." NPC와의 대화 자동으로 넘기기.\n|cffa0a0a0(CTRL키를 누르면 활성화 취소)";
	SCCN_HELP[21]					= "|cff68ccef".."/chatmod autodismount ".."|cffffffff".." 조련사 클릭하면 자동으로 탈 것에서 내리기";	
	SCCN_HELP[22]					= "|cff68ccef".."/chatmod inchathighlight ".."|cffffffff".."알려진 닉네임 강조하기";	
	SCCN_HELP[23]					= "|cff68ccef".."/chatmod sticky ".."|cffffffff".."채팅을 입력했던 채널 고정하기";	
	SCCN_HELP[99]					= "|cff68ccef".."/chatmod status".."|cffffffff".." 현재 설정상태 보기";	
	SCCN_TS_HELP  					= "|cff68ccef".."/chatmod timestamp |cffFF0000형식|cffffffff\n".."형식:\n$h = 24시간제 (0-24) \n$t = 12시간제 (0-12) \n$m = 분 \n$s = 초 \n$p = 오전/오후 \n".."|cff909090예제: /chatmod timestamp [$t:$m:$s $p]";
	SCCN_CMDSTATUS[1]				= "채널이름 숨기기 설정:";
	SCCN_CMDSTATUS[2]				= "캐릭터이름 색상 설정:";
	SCCN_CMDSTATUS[3]				= "마우스로 채팅창 스크롤 설정:";
	SCCN_CMDSTATUS[4]				= "채팅 입력창 위로 올리기 설정:";
	SCCN_CMDSTATUS[5]				= "채팅창 시간표시 설정:";
	SCCN_CMDSTATUS[6]				= "공대원 색상 표시 설정:";
	SCCN_CMDSTATUS[7]				= "웹페이지 복사하기 설정:";
	SCCN_CMDSTATUS[8]				= "캐릭터이름 강조 설정:";
	SCCN_CMDSTATUS[9]				= "클릭으로 초대 설정:";
	SCCN_CMDSTATUS[10]  				= "ALT키 사용 안함 설정:";
	SCCN_CMDSTATUS[11] 				= "귓속말 짧게 표시 설정:";
	SCCN_CMDSTATUS[12]				= "캐릭터이름 화면표시 설정:";
	SCCN_CMDSTATUS[13]				= "채팅창 버튼 숨기기 설정:";
	SCCN_CMDSTATUS[14] 				= "전장 미니맵 자동표시 설정:";
	SCCN_CMDSTATUS[15] 				= "사용자지정 강조 설정:";
	SCCN_CMDSTATUS[16] 				= "짧은 채널이름 설정:";
	SCCN_CMDSTATUS[17]				= "가쉽거리 숨김 설정:";
	SCCN_CMDSTATUS[18]				= "자동 탈것 내리기 설정:";
	SCCN_CMDSTATUS[19]				= "채팅창에 강조하기 설정:";	
	SCCN_CMDSTATUS[20]				= "채팅 채널 고정 설정:";		
	-- cursom invite word in the local language
	SCCN_CUSTOM_INV[0] 				= "ㅅㅅ"; --   :D
	SCCN_CUSTOM_INV[1] 				= "ㅅ"; --   :D
	-- Whispers customized
	SCCN_CUSTOM_CHT_FROM				= "%s님의 귓속말:";
	SCCN_CUSTOM_CHT_TO				= "%s님에게 귓속말:";
	-- hide this channels aditional, feel free to add your own
	SCCN_STRIPCHAN[1]				= "길드";
	SCCN_STRIPCHAN[2]				= "공격대";
	SCCN_STRIPCHAN[3]				= "파티";	
	SCCN_STRIPCHAN[4]				= "파티찾기";
    -- ItemLink Channels
    SCCN_ILINK[1]                   = "General -"
    SCCN_ILINK[2]                   = "Trade -"
    SCCN_ILINK[3]                   = "LookingForGroup -"
    SCCN_ILINK[4]                   = "LocalDefense -"
    SCCN_ILINK[5]                   = "WorldDefense"	
	-- some general channel name translation for the GUI
	SCCN_TRANSLATE[1]				= "길드";
	SCCN_TRANSLATE[2]				= "길드관리자";
	SCCN_TRANSLATE[3]				= "파티";
	SCCN_TRANSLATE[4]				= "공격대";
	SCCN_TRANSLATE[5]				= "귓속말";	
	SCCN_Highlighter				= "ChatMOD 강조";
	SCCN_Config					= "ChatMOD 설정";
	SCCN_Changelog					= "ChatMOD 변경내용";	

	
	
--==============
--=   ENGLISH  =
--==============
else
	SCCN_INIT_CHANNEL_LOCAL			= "General";
	SCCN_GUI_HIGHLIGHT1				= "In this Dialogue you can enter Words which ChatMOD should Highlight. Each Line is one Word.";
	SCCN_LOCAL_CLASS["WARLOCK"] 	= "Warlock";
	SCCN_LOCAL_CLASS["HUNTER"] 		= "Hunter";
	SCCN_LOCAL_CLASS["PRIEST"] 		= "Priest";
	SCCN_LOCAL_CLASS["PALADIN"] 	= "Paladin";
	SCCN_LOCAL_CLASS["MAGE"] 		= "Mage";
	SCCN_LOCAL_CLASS["ROGUE"] 		= "Rogue";
	SCCN_LOCAL_CLASS["DRUID"] 		= "Druid";
	SCCN_LOCAL_CLASS["SHAMAN"] 		= "Shaman";
	SCCN_LOCAL_CLASS["WARRIOR"] 	= "Warrior";
	-- Zones
	SCCN_LOCAL_ZONE["alterac"]	= "Alterac Valley";
	SCCN_LOCAL_ZONE["warsong"]	= "Warsong Gulch";
	SCCN_LOCAL_ZONE["arathi"]	= "Arathi Basin";
	SCCN_CONFAB						= "|cffff0000The Confab Addon was found. SCCN Editbox functions are disabled due to compatibility!";
	SCCN_HELP[1]					= "Sol's Color chat Nicks - Command Help:";
	SCCN_HELP[2]					= "|cff68ccef".."/chatmod hidechanname ".."|cffffffff".." Toggle chatname supression";
	SCCN_HELP[3]					= "|cff68ccef".."/chatmod colornicks ".."|cffffffff".." Toggle Chatname coloring in chatters class";
	SCCN_HELP[4]					= "|cff68ccef".."/chatmod purge".."|cffffffff".." Start a standard DB purge. |cffa0a0a0(done automaticaly each time the addon is loaded)";
	SCCN_HELP[5]					= "|cff68ccef".."/chatmod killdb".."|cffffffff".." Flushes the Database completly. (no undo)";
	SCCN_HELP[6]					= "|cff68ccef".."/chatmod mousescroll".."|cffffffff".." Toggle chat scrolling with mousewheel. |cffa0a0a0(<SHIFT>-MouseWheel  = Fast Scroll, <STRG>-MWheel = Top, Bottom)";
	SCCN_HELP[7]					= "|cff68ccef".."/chatmod topeditbox".."|cffffffff".." Move the chat editbox on top of the chatframe.";
	SCCN_HELP[8]					= "|cff68ccef".."/chatmod timestamp".."|cffffffff".." Show 24h Timestamp in Chatwindow.  HH:MM";
	SCCN_HELP[9]					= "|cff68ccef".."/chatmod colormap".."|cffffffff".." Color raidmembers on map in classcolor.";
	SCCN_HELP[10]					= "|cff68ccef".."/chatmod hyperlink".."|cffffffff".." Make Hyperlinks in Chat clickable.";
	SCCN_HELP[11]					= "|cff68ccef".."/chatmod selfhighlight".."|cffffffff".." Highlight own charname in chats.";
	SCCN_HELP[12]					= "|cff68ccef".."/chatmod clickinvite".."|cffffffff".." Make the word [invite] clickable in chats (invite on click).";
	SCCN_HELP[13] 					= "|cff68ccef".."/chatmod editboxkeys".."|cffffffff".." Use Chat Editbox keys without pressing <ALT> & increase History Buffer.";
	SCCN_HELP[14] 					= "|cff68ccef".."/chatmod chatstring".."|cffffffff".." Custom chat Strings.";
	SCCN_HELP[15] 					= "|cff68ccef".."/chatmod selfhighlightmsg".."|cffffffff".." Print OnScreen msg containing own nick on Screen.";	
	SCCN_HELP[16]					= "|cff68ccef".."/chatmod hidechatbuttons".."|cffffffff".." Hide Chat Buttons.";	
	SCCN_HELP[17]					= "|cff68ccef".."/chatmod highlight".."|cffffffff".." Custom filter dialogue for highlighting Words in Chat.";	
	SCCN_HELP[18]					= "|cff68ccef".."/chatmod AutoBGMap".."|cffffffff".." BGMinimap Autopupup.";	
	SCCN_HELP[19] = "|cff68ccef".."/chatmod shortchanname ".."|cffffffff".." Displays Short channelname.";	
	SCCN_HELP[20] = "|cff68ccef".."/chatmod autogossipskip ".."|cffffffff".." Skip the gossip Window automaticaly. |cffa0a0a0(Press <CTRL> to deactivate skip)";
	SCCN_HELP[21] = "|cff68ccef".."/chatmod autodismount ".."|cffffffff".." Auto Dismounts at taxi NPCs";	
	SCCN_HELP[22]					= "|cff68ccef".."/chatmod inchathighlight ".."|cffffffff".."Highlight Known Nicknames";	
	SCCN_HELP[22]					= "|cff68ccef".."/chatmod sticky ".."|cffffffff".."Sticky Chat behavior";	
	SCCN_HELP[23]					= "|cff68ccef".."/chatmod sticky ".."|cffffffff".."Sticky Chat behavior";	
	SCCN_HELP[24]					= "|cff68ccef".."/chatmod initchan <channelname>".."|cffffffff".."Set the specified <channelname> to default chatfram on startup.";	
	SCCN_HELP[25]					= "|cff68ccef".."/chatmod nofade".."|cffffffff".."Disable fading of Chattext";
	SCCN_HELP[99]					= "|cff68ccef".."/chatmod status".."|cffffffff".." Show current configuration.";	
	SCCN_TS_HELP  					= "|cff68ccef".."/chatmod timestamp |cffFF0000FORMAT|cffffffff\n".."FORMAT:\n$h = hour (0-24) \n$t = hour (0-12) \n$m = minute \n$s = second \n$p = periode (am / pm)\n".."|cff909090Example: /chatmod timestamp [$t:$m:$s $p]";
	SCCN_CMDSTATUS[1]				= "Supress Channelname:";
	SCCN_CMDSTATUS[2]				= "Chat nicknames in classcolor:";
	SCCN_CMDSTATUS[3]				= "Scroll Chat with Mousewheel:";
	SCCN_CMDSTATUS[4]				= "Chat Editbox onTop:";
	SCCN_CMDSTATUS[5]				= "Chat Timestamp:";
	SCCN_CMDSTATUS[6]				= "Class colored Map pins:";
	SCCN_CMDSTATUS[7]				= "Clickable Hyperlinks:";
	SCCN_CMDSTATUS[8]				= "Self Highlight:";
	SCCN_CMDSTATUS[9]				= "Click Invite:";
	SCCN_CMDSTATUS[10]  			= "Use Editbox Keys without <ALT>:";
	SCCN_CMDSTATUS[11] 				= "Custom chat strings:";
	SCCN_CMDSTATUS[12]				= "Self Highlight On Screen:";
	SCCN_CMDSTATUS[13]				= "Hide Chat Buttons:";
	SCCN_CMDSTATUS[14] 				= "BG Minimap Autopopup:";
	SCCN_CMDSTATUS[15] 				= "Custom Highlight:";
	SCCN_CMDSTATUS[16] 				= "Short Channelname:";
	SCCN_CMDSTATUS[17]				= "Auto Gossip Skip:";
	SCCN_CMDSTATUS[18]				= "Auto Dismount:";	
	SCCN_CMDSTATUS[19]				= "In Chat Highlight:";	
	SCCN_CMDSTATUS[20]				= "Remeber last Chatroom (sticky):";
	SCCN_CMDSTATUS[21]				= "Don't Fade chattext automaticaly:";	
	-- cursom invite word in the local language
	SCCN_CUSTOM_INV[0] 				= "1nv1t3"; --   :D
	SCCN_CUSTOM_INV[1] 				= "einladen"; --   :D
	-- Whispers customized
	SCCN_CUSTOM_CHT_FROM			= "From %s:";
	SCCN_CUSTOM_CHT_TO				= "To %s:";
	-- hide this channels aditional, feel free to add your own
	SCCN_STRIPCHAN[1]				= "Guild";
	SCCN_STRIPCHAN[2]				= "Raid";
	SCCN_STRIPCHAN[3]				= "Party";
	SCCN_STRIPCHAN[4]				= "LocalDefense";
	SCCN_STRIPCHAN[5]				= "WorldDefense";
	SCCN_STRIPCHAN[6]				= "LookingForGroup";	
	SCCN_STRIPCHAN[7]				= "Trade";
	SCCN_STRIPCHAN[8]				= "General";
	-- ItemLink Channels
    SCCN_ILINK[1]                   = "General -"
    SCCN_ILINK[2]                   = "Trade -"
    SCCN_ILINK[3]                   = "LookingForGroup -"
    SCCN_ILINK[4]                   = "LocalDefense -"
    SCCN_ILINK[5]                   = "WorldDefense"
	-- some general channel name translation for the GUI
	SCCN_TRANSLATE[1]				= "Guild";
	SCCN_TRANSLATE[2]				= "Officer";
	SCCN_TRANSLATE[3]				= "Group";
	SCCN_TRANSLATE[4]				= "Raid";
	SCCN_TRANSLATE[5]				= "Whisper";
	SCCN_Highlighter				= "ChatMOD Highlight";
	SCCN_Config						= "ChatMOD Config";
	SCCN_Changelog					= "ChatMOD Changelog";
	
end

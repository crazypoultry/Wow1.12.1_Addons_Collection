
-- Values in TitanModMenu_SystemMenuItems are overridden by values in TitanModMenu_UserSystemMenuItems, if defined
-- Items in TitanModMenu_MenuItems are overridden by items in TitanModMenu_UserMenuItems
-- TitanModMenu_BaseMenu is COMPLETLY overridden by TitanModMenu_UserBaseMenu, if defined

TitanModMenu_BaseMenu = {
	TITAN_MODMENU_CAT_BAR,
	TITAN_MODMENU_CAT_MAP,
	TITAN_MODMENU_CAT_INVENTORY,
	TITAN_MODMENU_CAT_AUCTION,
	TITAN_MODMENU_CAT_TRADESKILL,
	TITAN_MODMENU_CAT_QUEST,
	TITAN_MODMENU_CAT_COMBAT,
	TITAN_MODMENU_CAT_PVP,
	TITAN_MODMENU_CAT_CLASS,
	
	TITAN_MODMENU_SPACER,
	TITAN_MODMENU_CAT_CHAT,
	TITAN_MODMENU_CAT_FRIEND,
	TITAN_MODMENU_CAT_GUILD,
	TITAN_MODMENU_CAT_PARTY,
	TITAN_MODMENU_CAT_RAID,
	
	TITAN_MODMENU_SPACER,
	TITAN_MODMENU_CAT_TITAN,
	TITAN_MODMENU_CAT_TITAN2,
	TITAN_MODMENU_CAT_COMP,
	TITAN_MODMENU_CAT_LIBRARY,
	TITAN_MODMENU_CAT_OTHER,

	TITAN_MODMENU_SPACER,
	TITAN_MODMENU_CAT_UNKNOWN.. " 1",
	TITAN_MODMENU_CAT_UNKNOWN.. " 2",
	TITAN_MODMENU_CAT_UNKNOWN.. " 3",
	
	TITAN_MODMENU_SPACER,
	TITAN_MODMENU_CAT_TRADESKILLS,
	TITAN_MODMENU_CAT_HANDY,
	TITAN_MODMENU_CAT_EMOTES,
	TITAN_MODMENU_CAT_PORTALS,

	TITAN_MODMENU_SPACER,
	TITAN_MODMENU_CAT_GAMEMENU,
	TITAN_MODMENU_CAT_SYSTEM,
	
	TITAN_MODMENU_SPACER,
	TITAN_MODMENU_CAT_MODSETS,
	TITAN_MODMENU_CAT_MMSETTINGS,
};

TitanModMenu_SystemMenus = {
	TITAN_MODMENU_CAT_MODSETS,
	TITAN_MODMENU_CAT_TRADESKILLS,
	TITAN_MODMENU_CAT_EMOTES,
	TITAN_MODMENU_CAT_GAMEMENU,
	TITAN_MODMENU_CAT_SYSTEM,
	TITAN_MODMENU_CAT_HANDY,
	TITAN_MODMENU_CAT_MMSETTINGS,
};

-- Values in TitanModMenu_SystemMenuItems by values in TitanModMenu_UserSystemMenuItems, if defined
TitanModMenu_SystemMenuItems = {
	["USEmotemenu 0"] = {loc = TITAN_MODMENU_LOC_US, cat = TITAN_MODMENU_CAT_EMOTES, name = "Set 1", submenu = {{text = "/agree ", cmd = "/agree"}, {text = "/amaze ", cmd = "/amaze"}, {text = "/angry (V)", cmd = "/angry"}, {text = "/apologize ", cmd = "/apologize"}, {text = "/applaud (AV)", cmd = "/applaud"}, {text = "/attacktarget (AV)", cmd = "/attacktarget"}, {text = "/bark ", cmd = "/bark"}, {text = "/bashful (V)", cmd = "/bashful"}, {text = "/beckon ", cmd = "/beckon"}, {text = "/beg (V)", cmd = "/beg"}, {text = "/belch ", cmd = "/belch"}, {text = "/bite ", cmd = "/bite"}, {text = "/bleed ", cmd = "/bleed"}, {text = "/blink ", cmd = "/blink"}, {text = "/blood ", cmd = "/blood"}, {text = "/blow (AV)", cmd = "/blow"}, {text = "/blush (V)", cmd = "/blush"}, {text = "/boggle (V)", cmd = "/boggle"}, {text = "/bonk ", cmd = "/bonk"}, {text = "/bored (A)", cmd = "/bored"}, {text = "/bounce ", cmd = "/bounce"}}},
	["USEmotemenu 1"] = {loc = TITAN_MODMENU_LOC_US, cat = TITAN_MODMENU_CAT_EMOTES, name = "Set 2", submenu = {{text = "/bow (V)", cmd = "/bow"}, {text = "/bravo (AV)", cmd = "/bravo"}, {text = "/burp ", cmd = "/burp"}, {text = "/bye (AV)", cmd = "/bye"}, {text = "/cackle (AV)", cmd = "/cackle"}, {text = "/calm ", cmd = "/calm"}, {text = "/catty ", cmd = "/catty"}, {text = "/charge (AV)", cmd = "/charge"}, {text = "/cheer (AV)", cmd = "/cheer"}, {text = "/chew (V)", cmd = "/chew"}, {text = "/chicken (AV)", cmd = "/chicken"}, {text = "/chuckle (AV)", cmd = "/chuckle"}, {text = "/clap (AV)", cmd = "/clap"}, {text = "/cold ", cmd = "/cold"}, {text = "/comfort ", cmd = "/comfort"}, {text = "/commend (AV)", cmd = "/commend"}, {text = "/confused (V)", cmd = "/confused"}, {text = "/congratulate (AV)", cmd = "/congratulate"}, {text = "/cough ", cmd = "/cough"}}},
	["USEmotemenu 2"] = {loc = TITAN_MODMENU_LOC_US, cat = TITAN_MODMENU_CAT_EMOTES, name = "Set 3", submenu = {{text = "/cower ", cmd = "/cower"}, {text = "/crack ", cmd = "/crack"}, {text = "/cringe ", cmd = "/cringe"}, {text = "/cry (AV)", cmd = "/cry"}, {text = "/cuddle ", cmd = "/cuddle"}, {text = "/curious (V)", cmd = "/curious"}, {text = "/curtsey (V)", cmd = "/curtsey"}, {text = "/dance (V)", cmd = "/dance"}, {text = "/disappointed ", cmd = "/disappointed"}, {text = "/doh ", cmd = "/doh"}, {text = "/doom ", cmd = "/doom"}, {text = "/drink (V)", cmd = "/drink"}, {text = "/drool ", cmd = "/drool"}, {text = "/duck ", cmd = "/duck"}, {text = "/eat (V)", cmd = "/eat"}, {text = "/excited (V)", cmd = "/excited"}, {text = "/eye ", cmd = "/eye"}, {text = "/farewell (AV)", cmd = "/farewell"}, {text = "/fart ", cmd = "/fart"}, {text = "/fear ", cmd = "/fear"}, {text = "/feast (V)", cmd = "/feast"}}},
	["USEmotemenu 3"] = {loc = TITAN_MODMENU_LOC_US, cat = TITAN_MODMENU_CAT_EMOTES, name = "Set 4", submenu = {{text = "/fidget ", cmd = "/fidget"}, {text = "/flap (AV)", cmd = "/flap"}, {text = "/flee (AV)", cmd = "/flee"}, {text = "/flex (V)", cmd = "/flex"}, {text = "/flirt (AV)", cmd = "/flirt"}, {text = "/flop ", cmd = "/flop"}, {text = "/followme (AV)", cmd = "/followme"}, {text = "/food ", cmd = "/food"}, {text = "/frown ", cmd = "/frown"}, {text = "/gasp (V)", cmd = "/gasp"}, {text = "/gaze ", cmd = "/gaze"}, {text = "/giggle (AV)", cmd = "/giggle"}, {text = "/glad ", cmd = "/glad"}, {text = "/glare ", cmd = "/glare"}, {text = "/gloat (AV)", cmd = "/gloat"}, {text = "/golfclap (AV)", cmd = "/golfclap"}, {text = "/goodbye (AV)", cmd = "/goodbye"}, {text = "/greetings (V)", cmd = "/greetings"}, {text = "/grin ", cmd = "/grin"}, {text = "/groan ", cmd = "/groan"}, {text = "/grovel (V)", cmd = "/grovel"}}},
	["USEmotemenu 4"] = {loc = TITAN_MODMENU_LOC_US, cat = TITAN_MODMENU_CAT_EMOTES, name = "Set 5", submenu = {{text = "/growl (V)", cmd = "/growl"}, {text = "/guffaw (AV)", cmd = "/guffaw"}, {text = "/hail (V)", cmd = "/hail"}, {text = "/happy ", cmd = "/happy"}, {text = "/healme (AV)", cmd = "/healme"}, {text = "/hello (AV)", cmd = "/hello"}, {text = "/helpme (AV)", cmd = "/helpme"}, {text = "/hi (AV)", cmd = "/hi"}, {text = "/hug ", cmd = "/hug"}, {text = "/hungry ", cmd = "/hungry"}, {text = "/impatient ", cmd = "/impatient"}, {text = "/incoming (AV)", cmd = "/incoming"}, {text = "/insult (V)", cmd = "/insult"}, {text = "/introduce ", cmd = "/introduce"}, {text = "/jk ", cmd = "/jk"}, {text = "/kiss (AV)", cmd = "/kiss"}, {text = "/kneel (V)", cmd = "/kneel"}, {text = "/knuckles ", cmd = "/knuckles"}, {text = "/laugh (AV)", cmd = "/laugh"}, {text = "/lavish ", cmd = "/lavish"}, {text = "/laydown (V)", cmd = "/laydown"}}},
	["USEmotemenu 5"] = {loc = TITAN_MODMENU_LOC_US, cat = TITAN_MODMENU_CAT_EMOTES, name = "Set 6", submenu = {{text = "/lick ", cmd = "/lick"}, {text = "/lie (V)", cmd = "/lie"}, {text = "/liedown ", cmd = "/liedown"}, {text = "/listen ", cmd = "/listen"}, {text = "/lol (AV)", cmd = "/lol"}, {text = "/lost (V)", cmd = "/lost"}, {text = "/love ", cmd = "/love"}, {text = "/mad (V)", cmd = "/mad"}, {text = "/massage ", cmd = "/massage"}, {text = "/moan ", cmd = "/moan"}, {text = "/mock ", cmd = "/mock"}, {text = "/moo (A)", cmd = "/moo"}, {text = "/moon ", cmd = "/moon"}, {text = "/mourn (AV)", cmd = "/mourn"}, {text = "/no (AV)", cmd = "/no"}, {text = "/nod (AV)", cmd = "/nod"}, {text = "/nosepick ", cmd = "/nosepick"}, {text = "/oom (AV)", cmd = "/oom"}, {text = "/openfire (AV)", cmd = "/openfire"}, {text = "/panic ", cmd = "/panic"}, {text = "/party (V)", cmd = "/party"}, {text = "/pat ", cmd = "/pat"}}},
	["USEmotemenu 6"] = {loc = TITAN_MODMENU_LOC_US, cat = TITAN_MODMENU_CAT_EMOTES, name = "Set 7", submenu = {{text = "/peer ", cmd = "/peer"}, {text = "/peon (V)", cmd = "/peon"}, {text = "/pest ", cmd = "/pest"}, {text = "/pick ", cmd = "/pick"}, {text = "/pity ", cmd = "/pity"}, {text = "/pizza ", cmd = "/pizza"}, {text = "/plead (V)", cmd = "/plead"}, {text = "/point (V)", cmd = "/point"}, {text = "/poke ", cmd = "/poke"}, {text = "/ponder (V)", cmd = "/ponder"}, {text = "/pounce ", cmd = "/pounce"}, {text = "/praise ", cmd = "/praise"}, {text = "/pray (V)", cmd = "/pray"}, {text = "/purr ", cmd = "/purr"}, {text = "/puzzled (V)", cmd = "/puzzled"}, {text = "/question ", cmd = "/question"}, {text = "/raise ", cmd = "/raise"}, {text = "/rasp (AV)", cmd = "/rasp"}, {text = "/ready ", cmd = "/ready"}, {text = "/rear ", cmd = "/rear"}, {text = "/roar (V)", cmd = "/roar"}}},
	["USEmotemenu 7"] = {loc = TITAN_MODMENU_LOC_US, cat = TITAN_MODMENU_CAT_EMOTES, name = "Set 8", submenu = {{text = "/rofl (AV)", cmd = "/rofl"}, {text = "/rude (V)", cmd = "/rude"}, {text = "/salute (V)", cmd = "/salute"}, {text = "/scared ", cmd = "/scared"}, {text = "/scratch ", cmd = "/scratch"}, {text = "/sexy ", cmd = "/sexy"}, {text = "/shake ", cmd = "/shake"}, {text = "/shimmy ", cmd = "/shimmy"}, {text = "/shindig (V)", cmd = "/shindig"}, {text = "/shiver ", cmd = "/shiver"}, {text = "/shoo ", cmd = "/shoo"}, {text = "/shrug (V)", cmd = "/shrug"}, {text = "/shy (V)", cmd = "/shy"}, {text = "/sigh (A)", cmd = "/sigh"}, {text = "/silly (AV)", cmd = "/silly"}, {text = "/slap ", cmd = "/slap"}, {text = "/sleep (V)", cmd = "/sleep"}, {text = "/smell ", cmd = "/smell"}, {text = "/smile ", cmd = "/smile"}, {text = "/smirk ", cmd = "/smirk"}, {text = "/snarl ", cmd = "/snarl"}, {text = "/snicker ", cmd = "/snicker"}}},
	["USEmotemenu 8"] = {loc = TITAN_MODMENU_LOC_US, cat = TITAN_MODMENU_CAT_EMOTES, name = "Set 9", submenu = {{text = "/sniff ", cmd = "/sniff"}, {text = "/snub ", cmd = "/snub"}, {text = "/sob (AV)", cmd = "/sob"}, {text = "/soothe ", cmd = "/soothe"}, {text = "/sorry ", cmd = "/sorry"}, {text = "/spit ", cmd = "/spit"}, {text = "/spoon ", cmd = "/spoon"}, {text = "/stare ", cmd = "/stare"}, {text = "/stink ", cmd = "/stink"}, {text = "/strong (AV)", cmd = "/strong"}, {text = "/strut (AV)", cmd = "/strut"}, {text = "/surprised ", cmd = "/surprised"}, {text = "/surrender (V)", cmd = "/surrender"}, {text = "/tap ", cmd = "/tap"}, {text = "/taunt (AV)", cmd = "/taunt"}, {text = "/tease ", cmd = "/tease"}, {text = "/thanks (AV)", cmd = "/thanks"}, {text = "/thirsty ", cmd = "/thirsty"}, {text = "/threaten ", cmd = "/threaten"}, {text = "/tickle ", cmd = "/tickle"}}},
	["USEmotemenu 9"] = {loc = TITAN_MODMENU_LOC_US, cat = TITAN_MODMENU_CAT_EMOTES, name = "Set 10", submenu = {{text = "/tired ", cmd = "/tired"}, {text = "/train (AV)", cmd = "/train"}, {text = "/ty (AV)", cmd = "/ty"}, {text = "/veto ", cmd = "/veto"}, {text = "/victory (V)", cmd = "/victory"}, {text = "/violin (AV)", cmd = "/violin"}, {text = "/volunteer ", cmd = "/volunteer"}, {text = "/wait (AV)", cmd = "/wait"}, {text = "/wave ", cmd = "/wave"}, {text = "/weep (AV)", cmd = "/weep"}, {text = "/welcome (AV)", cmd = "/welcome"}, {text = "/whine ", cmd = "/whine"}, {text = "/whistle (A)", cmd = "/whistle"}, {text = "/wicked ", cmd = "/wicked"}, {text = "/wink ", cmd = "/wink"}, {text = "/work ", cmd = "/work"}, {text = "/wrath ", cmd = "/wrath"}, {text = "/yawn (A)", cmd = "/yawn"}, {text = "/yay ", cmd = "/yay"}, {text = "/yes (AV)", cmd = "/yes"}}},
	
	["DEEmotemenu 0"] = {loc = TITAN_MODMENU_LOC_DE, cat = TITAN_MODMENU_CAT_EMOTES, name = "Feindlich", submenu = {{text = "Anschnauzen ", cmd = "/anschnauzen"}, {text = "Auslachen ", cmd = "/auslachen"}, {text = "Beleidigen ", cmd = "/beleidigen"}, {text = "Drohen ", cmd = "/drohen"}, {text = "Grinsen ", cmd = "/grinsen"}, {text = "H\195\164misch ", cmd = "/h\195\164misch"}, {text = "Hintern ", cmd = "/hintern"}, {text = "Knurren ", cmd = "/knurren"}, {text = "Ohrfeigen ", cmd = "/ohrfeigen"}, {text = "Pupsen ", cmd = "/pupsen"}, {text = "Riechen ", cmd = "/riechen"}, {text = "Sauer ", cmd = "/sauer"}, {text = "Spucken ", cmd = "/spucken"}, {text = "Unh\195\182flich ", cmd = "/pups"}, {text = "Verh\195\182hnen ", cmd = "/verh\195\182hnen"}, {text = "Verscheuchen ", cmd = "/verscheuchen"}, {text = "Verspotten ", cmd = "/verspotten"}}},
	["DEEmotemenu 1"] = {loc = TITAN_MODMENU_LOC_DE, cat = TITAN_MODMENU_CAT_EMOTES, name = "Freuen", submenu = {{text = "Applaudieren ", cmd = "/applaudieren"}, {text = "Gratulation ", cmd = "/gratulation"}, {text = "Jubeln ", cmd = "/jubeln"}, {text = "Klatschen ", cmd = "/klatschen"}, {text = "Loben ", cmd = "/loben"}, {text = "Preisen ", cmd = "/preisen"}, {text = "Sieg ", cmd = "/sieg"}, {text = "Trinken ", cmd = "/trinken"}}},
	["DEEmotemenu 2"] = {loc = TITAN_MODMENU_LOC_DE, cat = TITAN_MODMENU_CAT_EMOTES, name = "Freundlich", submenu = {{text = "Err\195\182ten ", cmd = "/err\195\182ten"}, {text = "Flirten ", cmd = "/flirten"}, {text = "Gl\195\188ck", cmd = "/froh"}, {text = "Kichern ", cmd = "/gibbeln"}, {text = "Kitzeln ", cmd = "/kitzeln"}, {text = "Knuffen ", cmd = "/knuffen"}, {text = "Kuscheln ", cmd = "/kuscheln"}, {text = "K\195\188ssen ", cmd = "/k\195\188ssen"}, {text = "L\195\164cheln ", cmd = "/l\195\164cheln"}, {text = "Lachen ", cmd = "/lachen"}, {text = "Lecken ", cmd = "/lecken"}, {text = "Liebe ", cmd = "/liebe"}, {text = "Massieren ", cmd = "/massieren"}, {text = "Pfeifen ", cmd = "/pfeifen"}, {text = "Schmusen ", cmd = "/schmusen"}, {text = "Schnurren ", cmd = "/schnurren"}, {text = "Sch\195\188chtern ", cmd = "/sch\195\188chtern"}, {text = "Sexy ", cmd = "/sexy"}, {text = "Seufzen ", cmd = "/seufzen"}, {text = "St\195\182hnen", cmd = "/st\195\182hn"}, {text = "Tanzen ", cmd = "/tanzen"}, {text = "Umarmen ", cmd = "/umarmen"}, {text = "Verlegen ", cmd = "/verlegen"}, {text = "Zwinkern ", cmd = "/zwinkern"}}},
	["DEEmotemenu 3"] = {loc = TITAN_MODMENU_LOC_DE, cat = TITAN_MODMENU_CAT_EMOTES, name = "Gef\195\188hle", submenu = {{text = "\195\132ngstlich ", cmd = "/\195\132ngstlich"}, {text = "Aufgeregt", cmd = "/aufgeregt"}, {text = "Durstig ", cmd = "/durstig"}, {text = "Entt\195\164uscht ", cmd = "/entt\195\164uscht"}, {text = "Fr\195\182steln ", cmd = "/fr\195\182steln"}, {text = "F\195\188rchten ", cmd = "/f\195\188rchten"}, {text = "Gelangweilt ", cmd = "/gelangweilt"}, {text = "Hungrig ", cmd = "/hunger"}, {text = "Kalt ", cmd = "/kalt"}, {text = "Neugierig ", cmd = "/neugierig"}, {text = "Traurig ", cmd = "/weinen"}, {text = "\195\156berrascht ", cmd = "/\195\156berrascht"}, {text = "Ungeduldig ", cmd = "/ungeduldig"}, {text = "Verwirrt ", cmd = "/verwirrt"}}},
	["DEEmotemenu 4"] = {loc = TITAN_MODMENU_LOC_DE, cat = TITAN_MODMENU_CAT_EMOTES, name = "Gr\195\188\195\159en", submenu = {{text = "Begr\195\188\195\159en ", cmd = "/begr\195\188\195\159en"}, {text = "Hallo ", cmd = "/hallo"}, {text = "Knicks ", cmd = "/knicks"}, {text = "Knien ", cmd = "/knien"}, {text = "Salutieren ", cmd = "/salutieren"}, {text = "Vorstellen ", cmd = "/vorstellen"}, {text = "Verabschieden ", cmd = "/verabschieden"}, {text = "Verbeugen ", cmd = "/verbeugen"}}},
	["DEEmotemenu 5"] = {loc = TITAN_MODMENU_LOC_DE, cat = TITAN_MODMENU_CAT_EMOTES, name = "Humor", submenu = {{text = "Aufziehen ", cmd = "/aufziehen"}, {text = "Bei\195\159en ", cmd = "/bei\195\159en"}, {text = "Bellen ", cmd = "/bellen"}, {text = "Geige ", cmd = "/geige"}, {text = "Hauen ", cmd = "/hauen"}, {text = "Kratzen ", cmd = "/kratzen"}, {text = "Legen ", cmd = "/legen"}, {text = "Muuuuh ", cmd = "/muh"}, {text = "Nasepopeln", cmd = "/nasepopeln"}, {text = "R\195\188lpsen", cmd = "/r\195\188lpsen"}, {text = "Sabbern ", cmd = "/sabbern"}, {text = "Schn\195\188ffeln ", cmd = "/schn\195\188ffeln"}, {text = "Witz ", cmd = "/witz"}}},
	["DEEmotemenu 6"] = {loc = TITAN_MODMENU_LOC_DE, cat = TITAN_MODMENU_CAT_EMOTES, name = "Kampf", submenu = {{text = "Angeben ", cmd = "/angeben"}, {text = "Anspringen ", cmd = "/anspringen"}, {text = "Bereit ", cmd = "/bereit"}, {text = "Bluten ", cmd = "/blut"}, {text = "Br\195\188llen ", cmd = "/br\195\188llen"}, {text = "Ducken", cmd = "/ducken"}, {text = "Ergeben ", cmd = "/ergeben"}, {text = "Feinde ", cmd = "/feinde"}, {text = "Feuer ", cmd = "/feuer"}, {text = "Flehen", cmd = "/flehen"}, {text = "Fliehen", cmd = "/fliehen"}, {text = "Folgen", cmd = "/folgtmir"}, {text = "Huhn ", cmd = "/huhn"}, {text = "Kriechen ", cmd = "/kriechen"}, {text = "Panik ", cmd = "/panik"}, {text = "Schaudern ", cmd = "/schaudern"}, {text = "Stark ", cmd = "/stark"}, {text = "St\195\188rmen", cmd = "/st\195\188rmen"}, {text = "Trauern ", cmd = "/trauern"}, {text = "Warten ", cmd = "/warten"}, {text = "Winken ", cmd = "/winken"}, {text = "Zeigen ", cmd = "/zeigen"}, {text = "Ziel angreifen ", cmd = "/zielangreifen"}}},
	["DEEmotemenu 7"] = {loc = TITAN_MODMENU_LOC_DE, cat = TITAN_MODMENU_CAT_EMOTES, name = "Konversation", submenu = {{text = "Ablehnen ", cmd = "/ablehnen"}, {text = "Achselzucken ", cmd = "/achselzucken"}, {text = "Danke ", cmd = "/danke"}, {text = "Entschuldigen ", cmd = "/entschuldigen"}, {text = "Gern ", cmd = "/gern"}, {text = "Ja ", cmd = "/ja"}, {text = "Nein ", cmd = "/nein"}, {text = "Lachen ", cmd = "/lol"}, {text = "Nicken ", cmd = "/nicken"}, {text = "Stirn runzeln ", cmd = "/stirnrunzeln"}, {text = "Wundern ", cmd = "/wundern"}, {text = "Zuh\195\182ren ", cmd = "/zuh\195\182ren"}, {text = "Zustimmen ", cmd = "/agree"}}},
	
	["Sysmenu00"] = {cat = TITAN_MODMENU_CAT_SYSTEM, name = VIDEOOPTIONS_MENU, toggle = "OptionsFrame"},
	["Sysmenu01"] = {cat = TITAN_MODMENU_CAT_SYSTEM, name = SOUNDOPTIONS_MENU, toggle = "SoundOptionsFrame"},
	["Sysmenu02"] = {cat = TITAN_MODMENU_CAT_SYSTEM, name = UIOPTIONS_MENU, toggle = "UIOptionsFrame"},
	["Sysmenu03"] = {cat = TITAN_MODMENU_CAT_SYSTEM, name = KEY_BINDINGS, toggle = "KeyBindingFrame"},
	["Sysmenu04"] = {cat = TITAN_MODMENU_CAT_SYSTEM, name = MACROS, cmd = "/macro"},
	["Sysmenu05"] = {cat = TITAN_MODMENU_CAT_SYSTEM, name = HELP_BUTTON, func = "ToggleHelpFrame"},
	["Sysmenu08"] = {cat = TITAN_MODMENU_CAT_SYSTEM, name = TITAN_MODMENU_SPACER},
	["Sysmenu09"] = {cat = TITAN_MODMENU_CAT_SYSTEM, name = LOGOUT, cmd = "/logout"},
	["Sysmenu10"] = {cat = TITAN_MODMENU_CAT_SYSTEM, name = QUIT, cmd = TITAN_MODMENU_EXIT1},
	
	["Gamemenu1"] = {cat = TITAN_MODMENU_CAT_GAMEMENU, name = CHARACTER_BUTTON, func = "TPMM_TogCharFrame"},
	["Gamemenu2"] = {cat = TITAN_MODMENU_CAT_GAMEMENU, name = SPELLBOOK_BUTTON, func = "TPMM_TogSpellFrame"},
	["Gamemenu3"] = {cat = TITAN_MODMENU_CAT_GAMEMENU, name = TALENTS_BUTTON, func = "ToggleTalentFrame"},
	["Gamemenu4"] = {cat = TITAN_MODMENU_CAT_GAMEMENU, name = QUESTLOG_BUTTON, func = "ToggleQuestLog"},
	["Gamemenu5"] = {cat = TITAN_MODMENU_CAT_GAMEMENU, name = SOCIAL_BUTTON, func = "ToggleFriendsFrame"},
	["Gamemenu6"] = {cat = TITAN_MODMENU_CAT_GAMEMENU, name = WORLDMAP_BUTTON, func = "ToggleWorldMap"},

	["Handymenu1"] = {cat = TITAN_MODMENU_CAT_HANDY, name = "Random (100)", cmd = "/random 100"},
	["Handymenu2"] = {cat = TITAN_MODMENU_CAT_HANDY, name = PARTY_LEAVE, func = "LeaveParty"},
	
	["MMmenu1"] = {cat = TITAN_MODMENU_CAT_MMSETTINGS, name = TITAN_MODMENU_TOGGLEICON, func = "TitanPanelModMenu_ToggleIcon"},
	["MMmenu2"] = {cat = TITAN_MODMENU_CAT_MMSETTINGS, name = TITAN_MODMENU_TOGGLETEXT, func = "TitanPanelModMenu_ToggleText"},
};

TitanModMenu_MenuItems = {
	["Titan"] = {cat = TITAN_MODMENU_CAT_TITAN},
	["TitanAspect"] = {cat = TITAN_MODMENU_CAT_TITAN},
	["TitanAssist"] = {cat = TITAN_MODMENU_CAT_TITAN},
	["TitanClassTracker"] = {cat = TITAN_MODMENU_CAT_TITAN},
	["TitanCritLine"] = {cat = TITAN_MODMENU_CAT_TITAN},
	["TitanDurability"] = {cat = TITAN_MODMENU_CAT_TITAN},
	["TitanEmoteMenu"] = {cat = TITAN_MODMENU_CAT_TITAN},
	["TitanGuild"] = {cat = TITAN_MODMENU_CAT_TITAN},
	["TitanHearthStone"] = {cat = TITAN_MODMENU_CAT_TITAN},
	["TitanItemBonuses"] = {cat = TITAN_MODMENU_CAT_TITAN},
	["TitanItemDed"] = {cat = TITAN_MODMENU_CAT_TITAN},
	["TitanJB_Roll"] = {cat = TITAN_MODMENU_CAT_TITAN},
	["TitanMail"] = {cat = TITAN_MODMENU_CAT_TITAN},
	["TitanModMenu"] = {cat = TITAN_MODMENU_CAT_TITAN},
	["TitanNetWorth"] = {cat = TITAN_MODMENU_CAT_TITAN},
	["TitanPetXp"] = {cat = TITAN_MODMENU_CAT_TITAN},
	["TitanPortals"] = {cat = TITAN_MODMENU_CAT_TITAN},
	["TitanRoll"] = {cat = TITAN_MODMENU_CAT_TITAN},
	["TitanSH"] = {cat = TITAN_MODMENU_CAT_TITAN},
	["TitanXPBar"] = {cat = TITAN_MODMENU_CAT_TITAN},
	["TitanXPStatus"] = {cat = TITAN_MODMENU_CAT_TITAN},
	["TitanZone"] = {cat = TITAN_MODMENU_CAT_TITAN},
------------------------------------------------------------------------------------
	["Titan2"] = {cat = TITAN_MODMENU_CAT_TITAN2},
	["Titan2BodyCount"] = {cat = TITAN_MODMENU_CAT_TITAN2},
	["Titan2ChatHistory"] = {cat = TITAN_MODMENU_CAT_TITAN2},
	["Titan2ClassTracker"] = {cat = TITAN_MODMENU_CAT_TITAN2},
	["Titan2Mail"] = {cat = TITAN_MODMENU_CAT_TITAN2},
	["Titan2NetWorth"] = {cat = TITAN_MODMENU_CAT_TITAN2},
	["Titan2PetXp"] = {cat = TITAN_MODMENU_CAT_TITAN2},
	["Titan2Portals"] = {cat = TITAN_MODMENU_CAT_TITAN2},
	["Titan2Quests"] = {cat = TITAN_MODMENU_CAT_TITAN2},
	["Titan2Roll"] = {cat = TITAN_MODMENU_CAT_TITAN2},
	["Titan2Volume2"] = {cat = TITAN_MODMENU_CAT_TITAN2},	
------------------------------------------------------------------------------------
	["AbandonShip"] = {cmd = "/abandonship"},
	["AF_Tooltip"] = {func = "aftt_toggleFrames"},
	["AllInOneInventory"] = {cmd = "/aioi replacebags", cat = TITAN_MODMENU_CAT_INVENTORY},
	["AltSelfCast"] = {cat = TITAN_MODMENU_CAT_CLASS, cmd = "/asc"},
	["AmorCraft"] = {cat = TITAN_MODMENU_CAT_TRADESKILL, cmd = "/ac"},
	["AutoBag"] = {cat = TITAN_MODMENU_CAT_INVENTORY, cmd = "/ab"},
	["AutoBar"] = {cat = TITAN_MODMENU_CAT_BAR,cmd = "/autobar config"},
	["AutoPotion"] = {cat = TITAN_MODMENU_CAT_INVENTORY,toggle = "AutoPotion_ConfigDg"},
	["AutoRepair"] = {cat = TITAN_MODMENU_CAT_INVENTORY, cmd = "/ar enable"},
	["AutoShoutOut"] = {cat = TITAN_MODMENU_CAT_COMBAT, cmd = "/aso"},
	["AutoTravel"] = {cmd = "/at toggle hidden"},
	["AxuItemMenus"] = {cat = TITAN_MODMENU_CAT_INVENTORY,cmd = "/axuitemmenus"},
	["BagCount"] = {cat = TITAN_MODMENU_CAT_INVENTORY, cmd = "/bagcount"},
	["Bag_Status_Meters"] = {cmd = "/bsm", cat = TITAN_MODMENU_CAT_INVENTORY},
	["BankStatement"] = {toggle = "BankStatementFrame", cat = TITAN_MODMENU_CAT_INVENTORY},
	--["bc_AspectMenu"] = {cat = TITAN_MODMENU_CAT_CLASS},
	--["Bearchat"] = {cat = TITAN_MODMENU_CAT_CHAT},
	["BeneCast"] = {toggle = "BeneCastFrame", cat = TITAN_MODMENU_CAT_PARTY},
	["Buffbot"] = {cat = TITAN_MODMENU_CAT_PARTY, cmd = "/bb"},
	["Calculator"] = {text="Calculator-Taschenrechner", cmd = "/calculator"},
	["CastParty"] = {cat = TITAN_MODMENU_CAT_PARTY, func = "CastParty_OnSlashCmd"},
	["CastPartyOptions"] = {cat = TITAN_MODMENU_CAT_PARTY, cmd = "/cp"},
	["CensusPlus"] = {cat = TITAN_MODMENU_CAT_OTHER, cmd = "/censusplus"},
	--["ChatColors"] = {cat = TITAN_MODMENU_CAT_CHAT},
	--["CT_MailMod"] = {cat = TITAN_MODMENU_CAT_INVENTORY},
	["CD_StickyChat"] = {cmd = "/cdsc", cat = TITAN_MODMENU_CAT_CHAT},
	["CT_RaidAssist"] = {cmd = "/RaidAssist", cat = TITAN_MODMENU_CAT_RAID},
	["CT_FixGroups"] = {cmd = "/ctfixgroups", cat = TITAN_MODMENU_CAT_RAID},
	["DHUD"] = {cat = TITAN_MODMENU_CAT_OTHER, cmd = "/dhud"}, 
	--["DefenseTracker"] = {cat = TITAN_MODMENU_CAT_TITAN},
	["Discord Unit Frames"] = {cat = TITAN_MODMENU_CAT_PARTY, cmd = "/duf"}, 
	["DiscordActionBars"] = {cat = TITAN_MODMENU_CAT_BAR, cmd = "/dab"},
	["EquipManager"] = {cat = TITAN_MODMENU_CAT_INVENTORY, cmd = "/equip config"},
	["EnhancedTradeSkills"] = {cat = TITAN_MODMENU_CAT_TRADESKILL, cmd = "/etsconfig"},
	["ExamineTarget"] = {toggle = "ExamineTargetFrame", cat = TITAN_MODMENU_CAT_INVENTORY},
	--["FriendShore"] = {cat = TITAN_MODMENU_CAT_FRIEND},
	["FishInfo"] = {cmd = "/fishinfo", cat = TITAN_MODMENU_CAT_TRADESKILL},
	["Gatherer"] = {cat = TITAN_MODMENU_CAT_MAP, cmd= "/gather options"},
	["GIRD"] = {cat = TITAN_MODMENU_CAT_GUILD, cmd = "/gird"},
	--["GoodToGo"] = {cat = TITAN_MODMENU_CAT_PARTY},
	["GroupButtons"] = {cmd = "/gb", cat = TITAN_MODMENU_CAT_PARTY},
	--["GuildEventManager"] = {cat = TITAN_MODMENU_CAT_GUILD},
	["Gypsy"] = {cat = TITAN_MODMENU_CAT_OTHER, func = "Gypsy_OptionsFrameToggle"}, 
	["GypsyXP"] = {cat = TITAN_MODMENU_CAT_BAR, cmd = "/gypsyxp"},
	["Healix"] = {toggle = "HxSpellOptions"},
	["HitMode"] = {toggle = "HMOptions"},
	["HuntersAspect"] = {cat = TITAN_MODMENU_CAT_CLASS, cmd = "/huntaspect"},
	["ItemsMatrix"] = {cat = TITAN_MODMENU_CAT_INVENTORY, toggle = "ItemsMatrixFrame"},
	["LSChat"] = {cat = TITAN_MODMENU_CAT_CHAT, cmd = "/lschat"},
	["MiniGroup"] = {cat = TITAN_MODMENU_CAT_PARTY, toggle = "MGOptionsFrame"},
	["MonkeyQuest"] = {cat = TITAN_MODMENU_CAT_QUEST, func = "MonkeyQuestSlash_ToggleDisplay"},
	["MoveAnything"] = {func = "MoveAnything_ToggleOptionsMenu"},
	["MUSE"] = {cat = TITAN_MODMENU_CAT_CLASS, cmd = "/muse"},
	["MyAddOns"] = {toggle = "myAddOnsFrame"},
	["myBindings"] = {toggle = "myBindingsOptionsFrame"},
	["myDebug"] = {toggle = "myDebugFrame"},
	["NoteIt"] = {cmd = "/ni"},
	["PandaExpress"] = {cat = TITAN_MODMENU_CAT_PARTY, cmd = "/panda"},
	--["PALs"] = {cat = TITAN_MODMENU_CAT_CHAT},
	["PetFeeder"] = {cat = TITAN_MODMENU_CAT_CLASS, cmd = "/pf"},
	--["PickMail"] = {cat = TITAN_MODMENU_CAT_INVENTORY},
	["PlayerMerchant"] = {cat = TITAN_MODMENU_CAT_INVENTORY, toggle = "PlayerMerchantFrame"},
	["PlayerLinkMenu"] = {cat = TITAN_MODMENU_CAT_CHAT, cmd = "/plm"},
	["Possessions"] = {cat = TITAN_MODMENU_CAT_INVENTORY, cmd = "/poss"},
	["QTStamp"] = {cmd = "/qtstamp"},
	["QuestAssist"] = {func = "QuestAssistOptions_Toggle", cat = TITAN_MODMENU_CAT_QUEST},
	["QuickMountEquip"] = {cat = TITAN_MODMENU_CAT_INVENTORY, cmd = "/mountequip config"},
	["RangeRecolor"] = {cmd = "/rr", cat = TITAN_MODMENU_CAT_BAR},
	--["ReagentInfo"] = {toggle = "ReagentInfo_ConfigFrame", cat = TITAN_MODMENU_CAT_TRADESKILL},
	["RaidMap"] = {cat = TITAN_MODMENU_CAT_RAID, cmd = "/raidmap"},
	["BMRecLevel"] = {cat = TITAN_MODMENU_CAT_MAP, cmd = "/brlconfig"},
	["RedOut"] = {cat = TITAN_MODMENU_CAT_BAR, cmd = "/redout"},
	["sct"] = {cat = TITAN_MODMENU_CAT_COMBAT, cmd = "/sct menu"},
	["sctd"] = {cat = TITAN_MODMENU_CAT_COMBAT, cmd = "/sctd menu"},
	["SellValue"] = {toggle = "InvListFrame", cat = TITAN_MODMENU_CAT_INVENTORY},
	--["Sell-O-Matic"] = {cat = TITAN_MODMENU_CAT_INVENTORY},
	["Servitude"] = {cat = TITAN_MODMENU_CAT_CLASS, cmd = "/servitude"},
	["SheepDefender"] = {cat = TITAN_MODMENU_CAT_COMBAT, cmd = "/sheepdefender"},
	["SideBar Chat-Hilfe"] = {cmd = "/sidebar", cat = TITAN_MODMENU_CAT_BAR},
	["SM_PlayerMenu"] = {cmd = "/smpm", cat = TITAN_MODMENU_CAT_OTHER},
	["SpiritFactor"] = {cat = TITAN_MODMENU_CAT_COMBAT, cmd = "/sf"},
	["QuickLoot Plus"] = {cat = TITAN_MODMENU_CAT_INVENTORY, cmd = "/QLP"},
	--["SpitFilter"] = {cat = TITAN_MODMENU_CAT_CHAT},
	["SuperMacro"] = {toggle = "MacroFrame"},
	["TackleBox"] = {cmd = "/tb", cat = TITAN_MODMENU_CAT_TRADESKILL},
	["TimerBuff"] = {cat = TITAN_MODMENU_CAT_OTHER, cmd = "/tb"},
	["Timers"] = {cmd = "/ti show"},
	["TipBuddy"] = {cat = TITAN_MODMENU_CAT_OTHER, cmd = "/tipbuddy"},
	["TinyPad"] = {cat = TITAN_MODMENU_CAT_OTHER, cmd = "/TinyPad"},
	["TrainerSkills"] = {cmd = "/trainerSkills"},
	["UberActions"] = {cat = TITAN_MODMENU_CAT_BAR, func = "UberActions_ConfigEdit"},
	["WatchDog"] = {cat = TITAN_MODMENU_CAT_PARTY, cmd = "/wd"},
	["WoWKB"] = {cat = TITAN_MODMENU_CAT_MAP, cmd = "/WoWKB"},
	["LS3D_CraftInfo"] = {cat = TITAN_MODMENU_CAT_TRADESKILL, cmd = "/ls3d_ci"},
	["CTRA_Emergency"] = {cat = TITAN_MODMENU_CAT_COMBAT, cmd = "/ctrae"},
	["SetWrangler"] = {cat = TITAN_MODMENU_CAT_OTHER, cmd = "/SetWrangler"},
	["AQLoot"] = {cat = TITAN_MODMENU_CAT_RAID, cmd = "/AQLoot"},
	["ZGLoot"] = {cat = TITAN_MODMENU_CAT_RAID, cmd = "/ZGLoot"},
	["QuestItem"] = {cat =TITAN_MODMENU_CAT_QUEST, cmd = "/QuestItem"},
	["XLoot"] = {cat = TITAN_MODMENU_CAT_INVENTORY, cmd = "/XLoot options"},
	["PlayerLinkMenu"] = {cat =TITAN_MODMENU_CAT_OTHER, cmd = "/plm"},




	["MyBank"] = {cat = TITAN_MODMENU_CAT_INVENTORY,
		submenu = {
			{text = TITAN_MODMENU_TOGGLE, toggle = "MyBankFrame"},
			{text = TITAN_MODMENU_SETUP, toggle = "MyBankConfigFrame"}
		}
	},
	["Atlas"] = {cat = TITAN_MODMENU_CAT_MAP,
		submenu = {
			{text = TITAN_MODMENU_TOGGLE, toggle = "AtlasFrame"},
			{text = TITAN_MODMENU_SETUP, func = "AtlasOptions_Toggle"}
		}
	},
	["FlightMap"] = {cat = TITAN_MODMENU_CAT_MAP,
			submenu = {
			{text = "FlightMap Optionen", cmd = "/FlightMap"}, 
			{text = "Flugkarte \195\182ffnen", cmd = "/fmap \195\182ffnen"}, 
			--{text = "Flugpunkt Protokollierung sperren", cmd = "/fmap lock"}, 
			{text = "Flugzeit-Timer zur\195\188cksetzen", cmd = "/fmap Zur\195\188cksetzen"}, 
			{text = "Chat-Hilfe",  cmd = "/fmap Hilfe"},
			
		}
	},
	["GuildOrg"] = {cat = TITAN_MODMENU_CAT_GUILD,
		submenu = {
			{text = TITAN_MODMENU_TOGGLE, toggle = "GuildOrg"},
			TITAN_MODMENU_SPACER,
			{text = TITAN_MODMENU_MINIMAP.. " ".. TITAN_MODMENU_ON, cmd = "/go show"},
			{text = TITAN_MODMENU_MINIMAP.. " ".. TITAN_MODMENU_OFF, cmd = "/go hide"},
			TITAN_MODMENU_SPACER,
			{text = TITAN_MODMENU_HELP, cmd = "/go"},
		},
	},
	["LootLink"] = {cat = TITAN_MODMENU_CAT_INVENTORY,
		submenu = {
			{text = TITAN_MODMENU_TOGGLE, func = "ToggleLootLink"},
			{text = "Status", cmd = "/lootlink status"},
			{text = "Scan Auction House", cmd = "/lootlink scan"},
			{text = "Show extra info on tooltips", cmd = "/lootlink showinfo"},
			{text = "Hide extra info on tooltips", cmd = "/lootlink hideinfo"},
			{text = "Full Mode", cmd = "/lootlink full"},
			{text = "Light Mode", cmd = "/lootlink light"},
			{text = "Lootlink-Datenbank eindeutschen (Suchmasken Fix)", cmd = "/script LootLink_UpdateNames();"}
	
		}
	},
	["EquipCompare"] = {cat = TITAN_MODMENU_CAT_INVENTORY,
		submenu = {
			{text = TITAN_MODMENU_ENABLE, cmd = "/eqc on"},
			{text = TITAN_MODMENU_DISABLE, cmd = "/eqc off"},
			{text = TITAN_MODMENU_TOGGLE.. " Control Mode", cmd = "/eqc control"},
			{text = TITAN_MODMENU_HELP, cmd = "/eqc help"},
		},
	},
	["AuctionIt"] = {cat = TITAN_MODMENU_CAT_AUCTION,
		submenu = {
			{text = "Release BidSafe", cmd = "/bidsafe release"},
			TITAN_MODMENU_SPACER,
			{text = TITAN_MODMENU_SETUP, toggle = "AuctionItCfgFrame"},
			{text = TITAN_MODMENU_HELP, cmd = "/ait"},
		},
	},
	["RecipesObjectives"] = {cat = TITAN_MODMENU_CAT_TRADESKILL,
		submenu = {
			{text = TITAN_MODMENU_ENABLE, cmd = "/ro on"},
			{text = TITAN_MODMENU_DISABLE, cmd = "/ro off"},
			TITAN_MODMENU_SPACER,
			{text = TITAN_MODMENU_LOCK, cmd = "/ro lock"},
			{text = TITAN_MODMENU_UNLOCK, cmd = "/ro move"},
			TITAN_MODMENU_SPACER,
			{text = TITAN_MODMENU_TOGGLE, cmd = "/ro display"},
			{text = "Chat List", cmd = "/ro list"},
			TITAN_MODMENU_SPACER,
			{text = TITAN_MODMENU_TOGGLE.. " Stacks", cmd = "/ro displaystacks"},
			{text = TITAN_MODMENU_TOGGLE.. " Alerts", cmd = "/ro displayalerts"},
			{text = TITAN_MODMENU_TOGGLE.. " Bank", cmd = "/ro displaybank"},
			TITAN_MODMENU_SPACER,
			{text = TITAN_MODMENU_STATUS, cmd = "/ro status"},
			{text = TITAN_MODMENU_HELP, cmd = "/ro help"},
		},
	},
	["AutoGroup"] = {
		cat = TITAN_MODMENU_CAT_PARTY,
		submenu = {
			{text = TITAN_MODMENU_ENABLE, cmd = "/ag on"},
			{text = TITAN_MODMENU_DISABLE, cmd = "/ag off"},
			TITAN_MODMENU_SPACER,
			{text = "Accept"},
			{text = "Friend", cmd = "/ag accept friend"},
			{text = "Guild", cmd = "/ag accept guild"},
			{text = "Both", cmd = "/ag accept both"},
			{text = "All", cmd = "/ag accept all"},
			{text = "None", cmd = "/ag accept none"},
			TITAN_MODMENU_SPACER,
			{text = "Decline"},
			{text = "Non-Friend", cmd = "/ag decline nonfriend"},
			{text = "Non-Guild", cmd = "/ag decline nonguild"},
			{text = "Both", cmd = "/ag decline both"},
			{text = "All", cmd = "/ag decline all"},
			{text = "None", cmd = "/ag decline none"},
			TITAN_MODMENU_SPACER,
			{text = TITAN_MODMENU_STATUS, cmd = "/ag status"},
			{text = TITAN_MODMENU_HELP, cmd = "/ag help"},
		},
	},
	["FlexBar"] = {
		cat = TITAN_MODMENU_CAT_BAR,
		submenu = {
			{text = "Main Menu", func = "FB_GUI_Main_Menu"},
			TITAN_MODMENU_SPACER,
			{text = "Scripts Editor", cmd = "/flexbar scripts" },
			{text = "Event Editor", func = "FB_DisplayEventEditor" },
			{text = "Global Options", func = "FB_ShowGlobalOptions" },
			{text = "Auto Items", func = "FB_DisplayAutoItems"},
			{text = "Performance Options", func = "FB_Show_PerformanceOptions" },
		}
	},
	["Auctioneer"] = {

		cat = TITAN_MODMENU_CAT_AUCTION,
		submenu = {
			{text = "Auc laden", cmd = "/auc load"},
			{text = "Auc immer laden", cmd = "/auc load always" },
			{text = "Auc nur f\195\188r AH laden", cmd = "/auc load auctionhouse" },
			{text = "Auc nie laden", cmd = "/auc load never" },
			--{text = "Auc immer laden deaktivieren", cmd = "/auc disable" },
			{text = "Auc Chat-Hilfe", cmd = "/auc help" },
			{text = "Standartwerte laden", cmd = "/auc default all" },
			{text = "Gespeicherte Daten l\195\182schen", cmd = "/auc clear all" },
			{text = "Auc Anzeige Ein/Aus", cmd = "/auc toggle"},
			{text = "Eingebundene Tooltips", cmd = "/auc embed toggle"},
			{text = "Eingebundene Tooltips Trennlinie", cmd = "/auc show-embed-blankline toggle"},
			{text = "LinkID Anzeige", cmd = "/auc show-link toggle"},
			TITAN_MODMENU_SPACER,
			{text = "Scanne AH", cmd = "/auc scan"},
			{text = "AH-Scan-Lag Warnung anzeigen", cmd = "/auc show-warning toggle"},
			{text = "Sofortkauf Broker", cmd = "/auc broker" },
			{text = "Bieten Broker", cmd = "/auc bidbroker" },
			{text = "Prozent Broker", cmd = "/auc percentless" },
			{text = "AH-Vergleich zu eigenen Auktionen", cmd = "/auc compete" },
			--TITAN_MODMENU_SPACER,
			{text = "Detaillierte AH-Durchschnittswert Anzeige", cmd = "/auc show-verbose toggle"},
			{text = "Durchschnittspreise vom AH anzeigen", cmd = "/auc show-average toggle"},
			{text = "Median-Preise anzeigen", cmd = "/auc show-median toggle"},
			{text = "Empfohlene Preise anzeigen", cmd = "/auc show-suggest toggle"},
			{text = "Prozentanzeige Gebote/Sofortkauf anzeigen", cmd = "/auc show-stats toggle"},
			{text = "Automatisch Preise im AH einsetzen", cmd = "/auc autofill toggle"},
			--TITAN_MODMENU_SPACER,
			--{text = "Werte gegnerischer Fraktion anzeigen", cmd = "/auc also opposite"},
			--{text = "Werte gegnerischer Fraktion nicht anzeigen", cmd = "/auc also off"},
			--TITAN_MODMENU_SPACER,	
			--TITAN_MODMENU_SPACER,	
		} 
	},	
	["TradeSkillPaste"] = {
		cat = TITAN_MODMENU_CAT_TRADESKILL,
			submenu = {
			{text="Use shift+click to paste Trade Skill Detail and Reagents to Chat Edit Box."}
		} 
	},	

	["Informant"] = {
		text="Informant f\195\188r Auctioneer",
		cat = TITAN_MODMENU_CAT_AUCTION,
			submenu = {
			{text = "Informant Anzeige Ein/Aus", cmd = "/informant toggle"},
			{text = "Informant laden", cmd = "/informant load"},
			{text = "Informant immer laden", cmd = "/informant load always"},
			{text = "Informant nie laden", cmd = "/informant load never"},
			--{text = "Informant deaktivieren", cmd = "/informant disable"},
			TITAN_MODMENU_SPACER,
			{text = "Chat-Hilfe", cmd = "/informant help"},
			{text = "Eingebundene Tooltips", cmd = "/informant embed toggle"},
			TITAN_MODMENU_SPACER,
			{text = "H\195\164ndler-Preis Info", cmd = "/informant show-vendor toggle"},
			{text = "H\195\164ndler-Kaufpreis Info", cmd = "/informant show-vendor-buy toggle"},
			{text = "H\195\164ndler-Verkaufspreis Info", cmd = "/informant show-vendor-sell toggle"},
			TITAN_MODMENU_SPACER,
			{text = "Item Verwendungszweck anzeigen", cmd = "/informant show-usage toggle"},
			{text = "Item-Anbieter anzeigen", cmd = "/informant show-merchant toggle"},
			{text = "Item Inventarsymbol On/Off", cmd = "/informant show-icon toggle"},
			TITAN_MODMENU_SPACER,
			{text = "Stapelgr\195\182\195\159e Anzeige", cmd = "/informant show-stack toggle"},
			{text = "Item Verwendungsinfo", cmd = "/informant show-usage toggle"},
			{text = "Standartwerte laden", cmd = "/informant default all"},
		} 
	},	
	["BeanCounter"] = {
		text="BeanCounter f\195\188r Auctioneer",
		cat = TITAN_MODMENU_CAT_AUCTION,
			submenu = {
			{text = "BeanCounter laden", cmd = "/BeanCounter load"},
			{text = "BeanCounter immer laden", cmd = "/BeanCounter load always"},
			{text = "BeanCounter nie laden", cmd = "/BeanCounter load never"},
		} 
	},	
	["SmartPet"] = {
		cat = TITAN_MODMENU_CAT_CLASS,
		submenu = {
			{text = TITAN_MODMENU_STATUS, cmd = "/sp"},
			{text = TITAN_MODMENU_ENABLE, cmd = "/sp enable"},
			{text = TITAN_MODMENU_DISABLE, cmd = "/sp disable"},
			TITAN_MODMENU_SPACER,
			{text = "Taunt Manager", cmd = "/sp tauntman"},
			{text = "Smart Focus", cmd = "/sp smartfocus"},
			{text = "Auto Cower", cmd = "/sp autocower"},
			{text = "No Chase", cmd = "/sp nochase"},
			{text = "Health Warn", cmd = "/sp autowarn"},
			TITAN_MODMENU_SPACER,
			{text = "Warn Channel"},
			{text = "Say", cmd = "/sp channel say"},
			{text = "Party", cmd = "/sp channel party"},
			{text = "Guild", cmd = "/sp channel guild"},
			TITAN_MODMENU_SPACER,
			{text = TITAN_MODMENU_HELP, cmd = "/sp help"},
		},
	},
	["Stunwatch"] = {
		cat = TITAN_MODMENU_CAT_CLASS,
		submenu = {
			{text = TITAN_MODMENU_ENABLE, cmd = "/sw on"},
			{text = TITAN_MODMENU_DISABLE, cmd = "/sw off"},
		}
	},
	["BuyPoisons"] = {
		cat = TITAN_MODMENU_CAT_CLASS,
		submenu = {
			{text = "Crippling (R1)", cmd = "/bp cp1"},
			{text = "Crippling (R2)", cmd = "/bp cp2"},
			TITAN_MODMENU_SPACER,		
			{text = "Instant (R1)", cmd = "/bp ip1"},
			{text = "Instant (R2)", cmd = "/bp ip2"},
			{text = "Instant (R3)", cmd = "/bp ip3"},
			{text = "Instant (R4)", cmd = "/bp ip4"},
			{text = "Instant (R5)", cmd = "/bp ip5"},
			{text = "Instant (R6)", cmd = "/bp ip6"},
			TITAN_MODMENU_SPACER,		
			{text = "Deadly (R1)", cmd = "/bp dp1"},
			{text = "Deadly (R2)", cmd = "/bp dp2"},
			{text = "Deadly (R3)", cmd = "/bp dp3"},
			{text = "Deadly (R4)", cmd = "/bp dp4"},
			TITAN_MODMENU_SPACER,		
			{text = "Mind-Numbing (R1)", cmd = "/bp mp1"},
			{text = "Mind-Numbing (R2)", cmd = "/bp mp2"},
			{text = "Mind-Numbing (R3)", cmd = "/bp mp3"},
		}
	},	
	["BankItems"] = {
		cat = TITAN_MODMENU_CAT_INVENTORY,
		submenu = {		
			{text = TITAN_MODMENU_OPEN, cmd = "/bi all"},
			{text = "Chat List", cmd = "/bi list"},
			TITAN_MODMENU_SPACER,		
			{text = "All Realms", cmd = "/bi allrealms"},
			TITAN_MODMENU_SPACER,		
			{text = "Clear", cmd = "/bi clear"},
			{text = "Clear All", cmd = "/bi clearall"},
			{text = TITAN_MODMENU_RESET.. " Position", cmd = "/bi resetpos"},
			TITAN_MODMENU_SPACER,		
			{text = TITAN_MODMENU_HELP, cmd = "/bi help"},
		}
	},
	["CustomHideBar"] = {
		cat = TITAN_MODMENU_CAT_BAR,
		submenu = {
			{text = "Lock Bars", cmd = "/chb lock"},
			{text = "Unlock Bars", cmd = "/chb unlock"},
			TITAN_MODMENU_SPACER,
			{text = "Show Actionbar", cmd = "/chb actionbar show"},
			{text = "Hide Actionbar", cmd = "/chb actionbar hide"},
			TITAN_MODMENU_SPACER,
			{text = "Show Bagbar", cmd = "/chb bagbar show"},
			{text = "Hide Bagbar", cmd = "/chb bagbar hide"},
			TITAN_MODMENU_SPACER,
			{text = "Show Microbar", cmd = "/chb microbar show"},
			{text = "Hide Microbar", cmd = "/chb microbar hide"},
			TITAN_MODMENU_SPACER,
			{text = "Show Petbar", cmd = "/chb petbar show"},
			{text = "Hide Petbar", cmd = "/chb petbar hide"},
			TITAN_MODMENU_SPACER,
			{text = "Show Shapeshiftbar", cmd = "/chb shapeshiftbar show"},
			{text = "Hide Shapeshiftbar", cmd = "/chb shapeshiftbar hide"},
			TITAN_MODMENU_SPACER,
			{text = "CustomHideBar Help", cmd = "/chb help"},
		},
	},			
	["Recap"] = {
		cat = TITAN_MODMENU_CAT_COMBAT,
		submenu = {
			{text = TITAN_MODMENU_SHOW, func = "RecapFrame_Show"},
			{text = TITAN_MODMENU_SETUP, cmd = "/recap opt"},
		},
	},
	["PetDefend"] = {
		cat = TITAN_MODMENU_CAT_CLASS,
		submenu = {
			{text = TITAN_MODMENU_ENABLE, cmd = "/pd on"},
			{text = TITAN_MODMENU_DISABLE, cmd = "/pd off"},
			TITAN_MODMENU_SPACER,
			{text = "Defend only when Idle", cmd = "/pd idle"},
			{text = "Defend Always", cmd = "/pd always"},
			TITAN_MODMENU_SPACER,
			{text = TITAN_MODMENU_TOGGLE.." Chat Alert", cmd = "/pd alert"},
			{text = "Set Channel to SAY", cmd = "/pd chan say"},
			{text = "Set Channel to PARTY", cmd = "/pd chan party"},
			{text = "Set Channel to CHAT", cmd = "/pd chan chat"},
			TITAN_MODMENU_SPACER,
			{text = TITAN_MODMENU_RESET, cmd = "/pd reset"},
			{text = TITAN_MODMENU_STATUS, cmd = "/pd status"},
			{text = TITAN_MODMENU_HELP, cmd = "/pd help"},
		},
	},
	["PetXPBar"] = {
		cat = TITAN_MODMENU_CAT_CLASS,
		submenu = {
			{text = TITAN_MODMENU_TOGGLE, cmd = "/pxb bar"},
			TITAN_MODMENU_SPACER,
			{text = "Raw/Percentage Data", cmd = "/pxb raw"},
			{text = "Simple/Detailed Tooltips", cmd = "/pxb tooltip"},
			{text = "Above/Below Pet Picture", cmd = "/pxb swap"},
			{text = "In/Out of Fade Mode", cmd = "/pxb fade"},
			{text = "Level Display On/Off", cmd = "/pxb level"},
			TITAN_MODMENU_SPACER,
			{text = "Medium Size", cmd = "/pxb medium"},
			{text = "Large Size", cmd = "/pxb large"},
			TITAN_MODMENU_SPACER,
			{text = TITAN_MODMENU_RESET.." Color", cmd = "/pxb resetcolor"},
			{text = TITAN_MODMENU_HELP, cmd = "/pxb"},
		},
	},
	["MyInventory"] = {
		cat = TITAN_MODMENU_CAT_INVENTORY,
		submenu = {
			{text = TITAN_MODMENU_TOGGLE, cmd = "/mi show"},
			{text = TITAN_MODMENU_SETUP, cmd = "/mi config"},
			{text = "Replace Bags", cmd = "/mi replacebags"},
			TITAN_MODMENU_SPACER,
			{text = TITAN_MODMENU_HELP, cmd = "/mi"},
		},
	},
	["HunterPetSkills"] = {
		cat = TITAN_MODMENU_CAT_CLASS,
		submenu = {
			{text = "Bite 1", cmd = "/sk skill bite 1"},
			{text = "Bite 2", cmd = "/sk skill bite 2"},
			{text = "Bite 3", cmd = "/sk skill bite 3"},
			{text = "Bite 4", cmd = "/sk skill bite 4"},
			{text = "Bite 5", cmd = "/sk skill bite 5"},
			{text = "Bite 6", cmd = "/sk skill bite 6"},
			{text = "Bite 7", cmd = "/sk skill bite 7"},
			{text = "Bite 8", cmd = "/sk skill bite 8"},
			TITAN_MODMENU_SPACER,
			{text = "Claw 1", cmd = "/sk skill claw 1"},
			{text = "Claw 2", cmd = "/sk skill claw 2"},
			{text = "Claw 3", cmd = "/sk skill claw 3"},
			{text = "Claw 4", cmd = "/sk skill claw 4"},
			{text = "Claw 5", cmd = "/sk skill claw 5"},
			{text = "Claw 6", cmd = "/sk skill claw 6"},
			{text = "Claw 7", cmd = "/sk skill claw 7"},
			{text = "Claw 8", cmd = "/sk skill claw 8"},
			TITAN_MODMENU_SPACER,
			{text = "Cower 1", cmd = "/sk skill cower 1"},
			{text = "Cower 2", cmd = "/sk skill cower 2"},
			{text = "Cower 3", cmd = "/sk skill cower 3"},
			{text = "Cower 4", cmd = "/sk skill cower 4"},
			{text = "Cower 5", cmd = "/sk skill cower 5"},
			{text = "Cower 6", cmd = "/sk skill cower 6"},
			{text = "Cower 7", cmd = "/sk skill cower 7"},
			{text = "Cower 8", cmd = "/sk skill cower 8"},
		},
	},
	["ContextPetButtons"] = {
		cat = TITAN_MODMENU_CAT_CLASS,
		submenu = {
			{text = TITAN_MODMENU_LOCK, cmd = "/contextpetbuttons lock"},
			{text = TITAN_MODMENU_UNLOCK, cmd = "/contextpetbuttons unlock"},
			TITAN_MODMENU_SPACER,
			{text = "Small Button", cmd = "/contextpetbuttons small"},
			{text = "Large Button", cmd = "/contextpetbuttons large"},
			TITAN_MODMENU_SPACER,
			{text = TITAN_MODMENU_RESET, cmd = "/contextpetbuttons reset"},
		},
	},
	["FeedPetButton"] = {
		cat = TITAN_MODMENU_CAT_CLASS,
		submenu = {
			{text = TITAN_MODMENU_LOCK, cmd = "/feedpetbutton lock"},
			{text = TITAN_MODMENU_UNLOCK, cmd = "/feedpetbutton unlock"},
			TITAN_MODMENU_SPACER,
			{text = "Small Button", cmd = "/feedpetbutton small"},
			{text = "Large Button", cmd = "/feedpetbutton large"},
			TITAN_MODMENU_SPACER,
			{text = TITAN_MODMENU_RESET, cmd = "/feedpetbutton reset"},
			{text = TITAN_MODMENU_DISABLE, cmd = "/feedpetbutton disable"},
		},
	},
	["FilterKnown"] = {
		cat = TITAN_MODMENU_CAT_AUCTION,
		submenu = {
			{text = "Set to Red", cmd = "/fk red"},
			{text = "Set to Green", cmd = "/fk green"},
			{text = "Set to Blue", cmd = "/fk blue"},
		},
	},
	["CombatStats"] = {
		cat = TITAN_MODMENU_CAT_COMBAT,
		submenu = {
			{text = TITAN_MODMENU_ENABLE, cmd = "/combatstats enable on"},
			{text = TITAN_MODMENU_DISABLE.. " Addon", cmd = "/combatstats enable off"},
			{text = TITAN_MODMENU_ENABLE.. " Target", cmd = "/combatstats target on"},
			{text = TITAN_MODMENU_DISABLE.. " Target", cmd = "/combatstats target off"},
			{text = TITAN_MODMENU_ENABLE.. " Mouseover", cmd = "/combatstats mouseover on"},
			{text = TITAN_MODMENU_DISABLE.. " Mouseover", cmd = "/combatstats mouseover off"},
			{text = TITAN_MODMENU_ENABLE.. " End of Fight", cmd = "/combatstats endoffight on"},
			{text = TITAN_MODMENU_DISABLE.. " End of Fight", cmd = "/combatstats endoffight off"},
			{text = "Reset", cmd = "/combatstats reset yes"}
		}
	},
	["SelfCast"] = {
		cat = TITAN_MODMENU_CAT_CLASS,
		submenu = {
			{text = "Status", cmd = "/selfcast status"},
			{text = "Auto Selfcast ".. TITAN_MODMENU_TOGGLE, cmd = "/selfcast"},
			{text = TITAN_MODMENU_ENABLE.. " Alt-Cast", cmd = "/selfcast alton"},
			{text = TITAN_MODMENU_DISABLE.. " Alt-Cast", cmd = "/selfcast altoff"}
		}
	},
	["CooldownHud"] = {
		cat = TITAN_MODMENU_CAT_COMBAT,
		submenu = {
			{text = TITAN_MODMENU_RESET.." Button Positions", cmd = "/hud reset"},
			{text = "Digital Mode "..TITAN_MODMENU_TOGGLE, cmd = "/hud digital"},
			{text = "Mouseover Behavior "..TITAN_MODMENU_TOGGLE, cmd = "/hud hideformouse"},
			TITAN_MODMENU_SPACER,
			{text = "Only Show in Combat", cmd = "/hud show combat"},
			{text = "Show Always", cmd = "/hud show always"},
			TITAN_MODMENU_SPACER,
			{text = TITAN_MODMENU_SETUP, cmd = "/hud setup"},
			{text = TITAN_MODMENU_HELP, cmd = "/hud"},
		},
	},
	["TotalGold"] = {
		cat = TITAN_MODMENU_CAT_INVENTORY,
		submenu = {
			{text = TITAN_MODMENU_SHOW, cmd = "/tg"},
			TITAN_MODMENU_SPACER,
			{text = TITAN_MODMENU_RESET.." all data", cmd = "/tg clearall"},
			{text = TITAN_MODMENU_RESET.." session data", cmd = "/tg resetsession"},
			TITAN_MODMENU_SPACER,
			{text = TITAN_MODMENU_HELP, cmd = "/tg help"},
		},
	},
	["DefendYourself"] = {
		cat = TITAN_MODMENU_CAT_COMBAT,
		submenu = {
			{text = TITAN_MODMENU_SETUP, cmd = "/dy menu"},
			{text = "Bar Cycle", cmd = "/dy bar"},
			{text = "Button Cycle", cmd = "/dy button"},
			{text = "Button Off", cmd = "/dy button off"},
			{text = "Turn Toggle", cmd = "/dy turn"}
		}

	},
	["MezHelper"] = {
		cat = TITAN_MODMENU_CAT_CLASS,
		submenu = {
			{text = "Announce On", cmd = "/MezHelper announce on"},
			{text = "Announce Off", cmd = "/MezHelper announce off"},
			TITAN_MODMENU_SPACER,
			{text = "Assist On", cmd = "/MezHelper assist on"},
			{text = "Assist Off", cmd = "/MezHelper assist off"},
			TITAN_MODMENU_SPACER,
			{text = "Blame On", cmd = "/MezHelper blame on"},
			{text = "Blame Off", cmd = "/MezHelper blame off"},
			TITAN_MODMENU_SPACER,
			{text = "Config On", cmd = "/MezHelper config on"},
			{text = "Config Off", cmd = "/MezHelper config off"},
			TITAN_MODMENU_SPACER,
			{text = "Countdown On", cmd = "/MezHelper countdown on"},
			{text = "Countdown Off", cmd = "/MezHelper countdown off"},
			TITAN_MODMENU_SPACER,
			{text = "Strict Level I", cmd = "/MezHelper strict 1"},
			{text = "Strict Level II", cmd = "/MezHelper strict 2"},
			{text = "Strict Level III", cmd = "/MezHelper strict 3"},
		}
	},
	["AssistHelper"] = {
		cat = TITAN_MODMENU_CAT_COMBAT,
		submenu = {
			{text = "Output Channel"},
			{text = "None", cmd = "/assisthelper chan none"},
			{text = "Party", cmd = "/assisthelper chan party"},
			{text = "Raid", cmd = "/assisthelper chan raid"},
			{text = "Guild", cmd = "/assisthelper chan guild"},
			TITAN_MODMENU_SPACER,
			{text = "Set", cmd = "/assisthelper set"},
			{text = "Reset", cmd = "/assisthelper reset"},
			{text = "Show", cmd = "/assisthelper show"},
		}
	},
	["BestBuff"] = {
		cat = TITAN_MODMENU_CAT_COMBAT,
		submenu = {
			{text = TITAN_MODMENU_SETUP, cmd = "/bestbuff"},
			{text = "Reset", cmd = "/bestbuff reset"}
		}
	},
	["QuestIon"] = {
		cat = TITAN_MODMENU_CAT_QUEST,
		submenu = {
			{text = TITAN_MODMENU_TOGGLE, toggle = "QuestIon_Frame"},
			{text = "Reset position", cmd = "/qio resetpos"}
		}
	},
	["AutoTrinketBar"] = {
		cat = TITAN_MODMENU_CAT_BAR,
		submenu = {
			{text = "Default", cmd = "/atb default"},
			{text = "Lock", cmd = "/atb lock"},
			{text = "Unlock", cmd = "/atb unlock"},
			{text = "No drop", cmd = "/atb nodrop"},
			{text = "Tooltip left", cmd = "/atb ttleft"},
			{text = "Tooltip right", cmd = "/atb ttright"},
			{text = "Hide", cmd = "/atb hide"}
		}
	},
	["SortEnchant"] = {
		cat = TITAN_MODMENU_CAT_TRADESKILL,
		submenu = {
			{text = TITAN_MODMENU_TOGGLE, cmd = "/SortEnchant toggle"},
			{text = "Shorten Name when linking", cmd = "/SortEnchant Shorten"},
			TITAN_MODMENU_SPACER,
			{text = "Sort By"},
			{text = "Armor", cmd = "/SortEnchant Armor"},
			{text = "Type", cmd = "/SortEnchant Type"},
			{text = "Available", cmd = "/SortEnchant Available"},
		}
	},	
	["ZoneLevel"] = {
		cat = TITAN_MODMENU_CAT_MAP,
		submenu = {
			{text = TITAN_MODMENU_TOGGLE.." text", cmd = "/zl maptext"},
			{text = TITAN_MODMENU_TOGGLE.." icon", cmd = "/zl icon"},
			TITAN_MODMENU_SPACER,
			{text = TITAN_MODMENU_HELP, cmd = "/zl"},
		},
	},
	["Quest Announce"] = {
		cat = TITAN_MODMENU_CAT_QUEST,
		submenu = { 
			{text = TITAN_MODMENU_ENABLE, cmd = "/qa on"},
			{text = TITAN_MODMENU_DISABLE, cmd = "/qa off"},
			{text = "auf Standart setzen", cmd = "/qa std"},
			}
	}, 
	["Manaconserve"] = {
		cat = TITAN_MODMENU_CAT_COMBAT,
		submenu = {
			{text = "MC on", cmd = "/mc on"},
			{text = "MC off", cmd = "/mc off"},
			{text = "MC announce on/off", cmd = "/mc announce"}
		}
	},
	["Damagemeter"] = {
		cat = TITAN_MODMENU_CAT_COMBAT,
		submenu = {
			{text = "Toggles"},
			{text = "Show DM", cmd = "/dmshow"},
			{text = "Hide DM", cmd = "/dmhide"},
			{text = "Pause DM", cmd = "/dmpause"},
			{text = "Clear DM", cmd = "/dmclear"},
			{text = "Show in group only", cmd = "/dmggrouponly"},
			{text = "Pet dmg added to owner", cmd = "/dmaddpettoplayer"},
			{text = "Reset on combat", cmd = "/dmresetoncombat"},
			TITAN_MODMENU_SPACER,
			{text = "Storage"},
			{text = "Save", cmd = "/dmsave"},
			{text = "Restore", cmd = "/dmrestore"},
			{text = "Merge stored data with current", cmd = "/dmmerge"},
			{text = "Swap stored data with current", cmd = "/dmswap"},
			TITAN_MODMENU_SPACER,
			{text = "Display"},
			{text = "Reset Position", cmd = "/dmresetpos"},
			{text = "Lock Position", cmd = "/dmlockpos"},
			{text = "Populate List", cmd = "/dmpop"},
			{text = "Lock List", cmd = "/dmlock"},
			{text = "Disable text", cmd = "/dmtext 0"},
			{text = "Show Names", cmd = "/dmtext n"},
			{text = "Show Values", cmd = "/dmtext v"},
			{text = "Show Percent", cmd = "/dmtext p"},
			{text = "Set Color by Class", cmd = "/dmcolor 2"},
			{text = "Set Color by Relationship", cmd = "/dmcolor 1"},
			{text = "Display Damage done", cmd = "/dmquant 1"},
			{text = "Display Healing done", cmd = "/dmquant 2"},
			{text = "Display Damage taken", cmd = "/dmquant 3"},
			{text = "Display Healing taken", cmd = "/dmquant 4"},
			{text = "Display Idletime", cmd = "/dmquant 5"},
			{text = "Display DPS", cmd = "/dmquant 6"}
		},
	},
	["Damagemeter2"] = {
		cat = TITAN_MODMENU_CAT_COMBAT,
		submenu = {
			{text = "Report to Console"},
			{text = "Report Top3", cmd = "/dmreport c3"},
			{text = "Report Top5", cmd = "/dmreport c5"},
			{text = "Report Top10", cmd = "/dmreport c10"},
			{text = "Report Top15", cmd = "/dmreport c15"},
			{text = "Report Top40", cmd = "/dmreport c40"},
			TITAN_MODMENU_SPACER,
			{text = "Report to Say"},
			{text = "Report Top3", cmd = "/dmreport s3"},
			{text = "Report Top5", cmd = "/dmreport s5"},
			{text = "Report Top10", cmd = "/dmreport s10"},
			{text = "Report Top15", cmd = "/dmreport s15"},
			{text = "Report Top40", cmd = "/dmreport s40"},
			TITAN_MODMENU_SPACER,
			{text = "Report to Party"},
			{text = "Report Top3", cmd = "/dmreport p3"},
			{text = "Report Top5", cmd = "/dmreport p5"},
			TITAN_MODMENU_SPACER,
			{text = "Report to Raid"},
			{text = "Report Top3", cmd = "/dmreport r3"},
			{text = "Report Top5", cmd = "/dmreport r5"},
			{text = "Report Top10", cmd = "/dmreport r10"},
			{text = "Report Top15", cmd = "/dmreport r15"},
			{text = "Report Top40", cmd = "/dmreport r40"},
			TITAN_MODMENU_SPACER,
			{text = "Report to Guild"},
			{text = "Report Top3", cmd = "/dmreport g3"},
			{text = "Report Top5", cmd = "/dmreport g5"},
			{text = "Report Top10", cmd = "/dmreport g10"},
			{text = "Report Top15", cmd = "/dmreport g15"},
			{text = "Report Top40", cmd = "/dmreport g40"},
		},
	},
	["Damagemeter3"] = {
		cat = TITAN_MODMENU_CAT_COMBAT,
		submenu = {
			{text = "Report to Frame"},
			{text = "Report Top3", cmd = "/dmreport f3"},
			{text = "Report Top5", cmd = "/dmreport f5"},
			{text = "Report Top10", cmd = "/dmreport f10"},
			{text = "Report Top15", cmd = "/dmreport f15"},
			{text = "Report Top40", cmd = "/dmreport f40"},
		},
	},
	["CooldownCount"] = {
		cat = TITAN_MODMENU_CAT_BAR,
		submenu = {
			{text = "Chat-Hilfe", cmd = "/cc"},
			{text = "CC Ein/AUS", cmd = "/cc setzen"},
			{text = "Schrift klein", cmd = "/cc skalierung 1"},
			{text = "Schrift mittel", cmd = "/cc skalierung 2"},
			{text = "Schrift gross", cmd = "/cc skalierung 3"},
			{text = "Normale Farben", cmd = "/cc standardfarbe"}, 
		},
	},
	["DruidBar"] = {
		cat = TITAN_MODMENU_CAT_CLASS,
		submenu = {
			{text = "Help", cmd = "/dbar"}, 
			{text = "Toggle", cmd = "/dbar toggle"},
			{text = "ShowText", cmd = "/dbar showtext"},
			{text = "Update", cmd = "/dbar update"},
			{text = "Lock", cmd = "/dbar lock"},
			{text = "Hide", cmd = "/dbar hide"},
			{text = "Replace", cmd = "/dbar replace"},
			{text = "Percent", cmd = "/dbar percent"},
			{text = "EZShift", cmd = "/dbar EZShift"}, 
			{text = "Barcolor", cmd = "/dbar barcolor"},
			{text = "PlayerFrame", cmd = "/dbar PlayerFrame"},
			{text = "TextType", cmd = "/dbar Texttype"},
			{text = "kmg", cmd = "/dbar kmg"},
		},
	},
	["Stancesets"] = {
		cat = TITAN_MODMENU_CAT_COMBAT,
		submenu = {
			{text = "Setup", cmd = "/stancesets"},
			{text = "Toggle to Next", cmd = "/stancesets next"},
		},
	},
	["EnchantedDurability"] = {
		cat = TITAN_MODMENU_CAT_INVENTORY,
		submenu = {
			{text = "Help", cmd = "/ed help"}, 
			{text = "All", cmd = "/ed all"},
			{text = "None", cmd = "/ed none"},
			{text = "Durability", cmd = "/ed durability"},
			{text = "Cost", cmd = "/ed cost"},
			{text = "Total", cmd = "/ed total"},
			{text = "Normal", cmd = "/ed normal"},
		},
	},
	["RogueStunHelper"] = {
		cat = TITAN_MODMENU_CAT_CLASS,
		submenu = {
			{text = "Help", cmd = "/rsh help"},
			{text = "On", cmd = "/rsh on"},
			{text = "Off", cmd = "/rsh off"},
			{text = "Lock", cmd = "/rsh lock"},
			{text = "Unlock", cmd = "/rsh unlock"}, 
			{text = "Clear", cmd = "/rsh clear"},
			{text = "List", cmd = "/rsh list"},
		},
	},
	["ItemBuffBar"] = {
		cat = TITAN_MODMENU_CAT_BAR,
		submenu = {
			{text = "Help", cmd = "/ibb"},
			{text = "Show", cmd = "/ibb show"},
			{text = "Hide", cmd = "/ibb hide"},
			{text = "Reset", cmd = "/ibb reset"},
			{text = "Lock", cmd = "/ibb lock"}, 
			{text = "Unlock", cmd = "/ibb unlock"},
			{text = "Horizontal", cmd = "/ibb horz"},
			{text = "Vertical", cmd = "/ibb vert"},
			{text = "Statusbar", cmd = "/ibb statusbar"},
			{text = "1 Slot", cmd = "/ibb slots 1"},
			{text = "2 Slots", cmd = "/ibb slots 2"},
			{text = "3 Slots", cmd = "/ibb slots 3"},
			{text = "4 Slots", cmd = "/ibb slots 4"},
			{text = "5 Slots", cmd = "/ibb slots 5"},
			{text = "6 Slots", cmd = "/ibb slots 6"},
			{text = "7 Slots", cmd = "/ibb slots 7"},
			{text = "8 Slots", cmd = "/ibb slots 8"}, 
		},
	},
	["TrinketMenu"] = {
		cat = TITAN_MODMENU_CAT_BAR,
		submenu = {
			{text = "On", cmd = "/trinket on"},
			{text = "Off", cmd = "/trinket off"},
			{text = "Lock", cmd = "/trinket lock"},
			{text = "Reset", cmd = "/trinket reset"}, 
			{text = "Status", cmd = "/trinket status"},
		},
	},
	["CT_PetHealth"] = {
		submenu = { 
			{text = TITAN_MODMENU_ENABLE, cmd = "/ph on"},
			{text = TITAN_MODMENU_DISABLE, cmd = "/ph off"},
			{text = "PetHealth Button an", cmd = "/ph show"},
			{text = "PetHealth Button off", cmd = "/ph hide"},
		}
	},
	["EventWatcher"] = {
		submenu = {
			{text = TITAN_MODMENU_ENABLE, cmd = "/ew on"},
			{text = TITAN_MODMENU_DISABLE, cmd = "/ew off"},
			TITAN_MODMENU_SPACER,
			{text = "List", cmd = "/ew list"},
			{text = TITAN_MODMENU_HELP, cmd = "/ew"},
		},
	},
	["CtTimer"] = {
		submenu = {
			{text = TITAN_MODMENU_ENABLE, cmd = "/timer show"},
			{text = TITAN_MODMENU_DISABLE, cmd = "/timer hide"},
			TITAN_MODMENU_SPACER,		
			{text = "Seconds"},
			{text = TITAN_MODMENU_ENABLE, cmd = "/timer secs on"},
			{text = TITAN_MODMENU_DISABLE, cmd = "/timer secs hide"},
		},
	}, 
	["MonkeyBuddy"] = {
		submenu = {
			{text = TITAN_MODMENU_TOGGLE, toggle = "MonkeyBuddyFrame"},
			TITAN_MODMENU_SPACER,
			{text = TITAN_MODMENU_ENABLE, cmd = "/mbcall"},
			{text = TITAN_MODMENU_DISABLE, cmd = "/mbdismiss"},
		}		
	},
	["Bookworm"] = {
		submenu = {
			{text = "Browse All Books", cmd = "/bookworm browse"},
			{text = "Browse Unread Books", cmd = "/bookworm unread"},
			TITAN_MODMENU_SPACER,
			{text = "Auto Page Turning", cmd = "/bookworm auto"},
			{text = "Store Page Content", cmd = "/bookworm store all"},
			{text = "Plain Font", cmd = "/bookworm font plain"},
			{text = "Default Font", cmd = "/bookworm font normal"},
			{text = "List Categories", cmd = "/bookworm listcat"},
			{text = "Refresh Page Cache", cmd = "/bookworm refresh"},
			{text = TITAN_MODMENU_HELP, cmd = "/bookworm help"}
		}
	},
	["AlarmSystem1"] = {
		submenu = {
			{text = TITAN_MODMENU_TOGGLE, cmd = "/alarmsystem state toggle"},
			TITAN_MODMENU_SPACER,
			{text = "Sound ".. TITAN_MODMENU_TOGGLE, cmd = "/alarmsystem sound toggle"},
			{text = "Ping ".. TITAN_MODMENU_TOGGLE, cmd = "/alarmsystem ping toggle"},
			{text = "Fireworks ".. TITAN_MODMENU_TOGGLE, cmd = "/alarmsystem fireworks toggle"},
			{text = "Show guild ".. TITAN_MODMENU_TOGGLE, cmd = "/alarmsystem showguild toggle"},
			{text = "Untargeted ".. TITAN_MODMENU_TOGGLE, cmd = "/alarmsystem untargeted toggle"},
			TITAN_MODMENU_SPACER,
			{text = "Death ".. TITAN_MODMENU_TOGGLE, cmd = "/alarmsystem death toggle"},
			{text = "Send to local chat ".. TITAN_MODMENU_TOGGLE, cmd = "/alarmsystem sendlocal toggle"},
			{text = "Send to guild chat ".. TITAN_MODMENU_TOGGLE, cmd = "/alarmsystem sendguild toggle"},
			{text = "Send to party chat ".. TITAN_MODMENU_TOGGLE, cmd = "/alarmsystem sendparty toggle"},
			{text = "Send to raid chat ".. TITAN_MODMENU_TOGGLE, cmd = "/alarmsystem sendraid toggle"}
		}			
	},
	["AlarmSystem2"] = {
		submenu = {
			{text = "Cooldown"},
			{text = TITAN_MODMENU_DISABLE, cmd = "/alarmsystem cooldown 0"},
			{text = "30s", cmd = "/alarmsystem cooldown 30"},
			{text = "35s", cmd = "/alarmsystem cooldown 35"},
			{text = "40s", cmd = "/alarmsystem cooldown 40"},
			{text = "45s", cmd = "/alarmsystem cooldown 45"},
			{text = "50s", cmd = "/alarmsystem cooldown 50"},
			{text = "50s", cmd = "/alarmsystem cooldown 55"},
			{text = "1m", cmd = "/alarmsystem cooldown 60"},
			TITAN_MODMENU_SPACER,
			{text = "Level difference"},
			{text = TITAN_MODMENU_DISABLE, cmd = "/alarmsystem leveldiff 0"},
			{text = "3 levels", cmd = "/alarmsystem leveldiff 3"},
			{text = "5 levels", cmd = "/alarmsystem leveldiff 5"},
			{text = "7 levels", cmd = "/alarmsystem leveldiff 7"},
			{text = "10 levels", cmd = "/alarmsystem leveldiff 10"},
		}			
	},
	["Archaeologist1"] = {
		submenu = {
			{text = "Player HP Text "..TITAN_MODMENU_TOGGLE, cmd = "/archplayer text hp toggle"},
			{text = "Player mP Text "..TITAN_MODMENU_TOGGLE, cmd = "/archplayer text hp toggle"},
			{text = "Player HP Percent "..TITAN_MODMENU_TOGGLE, cmd = "/archplayer percent hp toggle"},
			{text = "Player mP Percent "..TITAN_MODMENU_TOGGLE, cmd = "/archplayer percent mp toggle"},
			{text = "Player HP Prefix "..TITAN_MODMENU_TOGGLE, cmd = "/archplayer prefix hp toggle"},
			{text = "Player mP Prefix "..TITAN_MODMENU_TOGGLE, cmd = "/archplayer prefix mp toggle"},
			TITAN_MODMENU_SPACER,
			{text = "Party HP Text "..TITAN_MODMENU_TOGGLE, cmd = "/archparty text hp toggle"},
			{text = "Party mP Text "..TITAN_MODMENU_TOGGLE, cmd = "/archparty text hp toggle"},
			{text = "Party HP Percent "..TITAN_MODMENU_TOGGLE, cmd = "/archparty percent hp toggle"},
			{text = "Party mP Percent "..TITAN_MODMENU_TOGGLE, cmd = "/archparty percent mp toggle"},
			{text = "Party HP Prefix "..TITAN_MODMENU_TOGGLE, cmd = "/archparty prefix hp toggle"},
			{text = "Party mP Prefix "..TITAN_MODMENU_TOGGLE, cmd = "/archparty prefix mp toggle"},
			{text = "Party Buffs "..TITAN_MODMENU_TOGGLE, cmd = "/archparty buffs toggle"},
			{text = "Party Debuffs "..TITAN_MODMENU_TOGGLE, cmd = "/archparty debuffs toggle"},
			TITAN_MODMENU_SPACER,
			{text = "Pet HP Text "..TITAN_MODMENU_TOGGLE, cmd = "/archpet text hp toggle"},
			{text = "Pet mP Text "..TITAN_MODMENU_TOGGLE, cmd = "/archpet text hp toggle"},
			{text = "Pet HP Percent "..TITAN_MODMENU_TOGGLE, cmd = "/archpet percent hp toggle"},
			{text = "Pet mP Percent "..TITAN_MODMENU_TOGGLE, cmd = "/archpet percent mp toggle"},
			{text = "Pet HP Prefix "..TITAN_MODMENU_TOGGLE, cmd = "/archpet prefix hp toggle"},
			{text = "Pet mP Prefix "..TITAN_MODMENU_TOGGLE, cmd = "/archpet prefix mp toggle"},
			{text = "Pet Buffs "..TITAN_MODMENU_TOGGLE, cmd = "/archpet buffs toggle"},
			{text = "Pet Debuffs "..TITAN_MODMENU_TOGGLE, cmd = "/archpet debuffs toggle"},
		},
	},
	["Archaeologist2"] = {
		submenu = {
			{text = "Target HP Text "..TITAN_MODMENU_TOGGLE, cmd = "/archtarget text hp toggle"},
			{text = "Target mP Text "..TITAN_MODMENU_TOGGLE, cmd = "/archtarget text hp toggle"},
			{text = "Target HP Percent "..TITAN_MODMENU_TOGGLE, cmd = "/archtarget percent hp toggle"},
			{text = "Target mP Percent "..TITAN_MODMENU_TOGGLE, cmd = "/archtarget percent mp toggle"},
			{text = "Target HP Prefix "..TITAN_MODMENU_TOGGLE, cmd = "/archtarget prefix hp toggle"},
			{text = "Target mP Prefix "..TITAN_MODMENU_TOGGLE, cmd = "/archtarget prefix mp toggle"},
			{text = "Target Buffs "..TITAN_MODMENU_TOGGLE, cmd = "/archtarget buffs toggle"},
			{text = "Target Debuffs "..TITAN_MODMENU_TOGGLE, cmd = "/archtarget debuffs toggle"},
			TITAN_MODMENU_SPACER,
			{text = "Colorize HP Bar "..TITAN_MODMENU_TOGGLE, cmd = "/arch hpcolor toggle"},
			{text = "Debuff Alt Loc "..TITAN_MODMENU_TOGGLE, cmd = "/arch debuffalt toggle"},
			{text = "Target Buff Alt Loc "..TITAN_MODMENU_TOGGLE, cmd = "/arch targetbuffalt toggle"},
			{text = "HP/mP Alt Loc "..TITAN_MODMENU_TOGGLE, cmd = "/arch hpmpalt toggle"},
			TITAN_MODMENU_SPACER,
			{text = TITAN_MODMENU_HELP, cmd = "/archhelp"},
		},
	},	
	["KillLog"] = {cmd = "/killlog", cat = TITAN_MODMENU_CAT_PVP},
	["Karma"] = {
		cat = TITAN_MODMENU_CAT_PARTY,
		submenu = {
			{cmd = "/karma window", text = TITAN_MODMENU_TOGGLE},
			{cmd = "/Karma", text = TITAN_MODMENU_HELP},
		},
	},
	["FlightPath"] = {
		cat = TITAN_MODMENU_CAT_MAP,
		submenu = {
			{text = TITAN_MODMENU_TOGGLE, cmd = "/fp"},
			{text = TITAN_MODMENU_SETUP, cmd = "/fp help"},
		},
	},
	["AlphaMap"] = {
		cat = TITAN_MODMENU_CAT_MAP,
		submenu = {
			{text = TITAN_MODMENU_TOGGLE, cmd = "/am tog"},
			{text = TITAN_MODMENU_LOCK.."/"..TITAN_MODMENU_UNLOCK, cmd = "/am lock"},
			{text = "Optionen", cmd = "/am"},
		},
	},
	["Gadget"] = {
		submenu = {
			{text = "Gadget \195\182ffnen", toggle = "GadgetFrame"},
			{text = "Chat-Hilfe", cmd = "/gadget"},
			{text = "Ziel hinzuf\195\188gen", cmd = "/gadget add"},
		},
	},
	["MapNotes"] = {
		cat = TITAN_MODMENU_CAT_MAP,
		submenu = {
			{text = "MapNotes eindeutschen WICHTIG: NUR EINMAL VERWENDEN!(ConvertOldNotes)", cmd = "/script MapNotes_ConvertOldNotes()"},
			{text = "MapNotes eindeutschen WICHTIG: NUR EINMAL VERWENDEN!(ConvertFromOldZoneShift)", cmd = "/script MapNotes_ConvertFromOldZoneShift()"},
			{text = "Beides nur f\195\188r WoW-Mods 1.0-3.6 auf > 3.7 verwenden (SavedVariables/MapNotes.lua vorher sichern)"}
		}
	},
	--["KC_EnhancedTrades"] = {
		--cat = TITAN_MODMENU_CAT_TRADESKILL,
		--submenu = {
			--{text = "EnhancedTrades Ein/Aus", cmd = "/kcet standby"},
			--{text = "Chat-Hilfe anzeigen", cmd = "/kcet"}
		--}
	--},
	["cMinimapCoordinates"] = {
		cat = TITAN_MODMENU_CAT_MAP,
		submenu = {
			{text = "cMinimapCoordinates MiniMap On/OFF", cmd = "/cmc minimap"},
			{text = "cMinimapCoordinates WorldMap On/OFF", cmd = "/cmc worldmap"}
		}
	},
	["EnhancedFlightMap"] = {
		frame = "EnhancedFlightMapPathFrame",
		cat = TITAN_MODMENU_CAT_MAP,
		text = "EnhancedFlightMap",

			submenu = { 		
			{text = "EnhancedFlightMap Config", cmd = "/efm Config"},
			{text = "Zeige Flugmeister-Karte", cmd = "/efm open"},
			{text = "Zeige Flugmeister-Karte von \195\150stlichen K\195\182nigreiche", cmd = "/efm open azeroth"},
			{text = "Zeige Flugmeister-Karte von Kalimdor", cmd = "/efm open kalimdor"},
			{text = "EnhancedFlightMap Daten zur\195\188cksetzen", cmd = "/efm l\195\182schen"},
			{text = "EnhancedFlightMap Chat-Hilfe", cmd = "/efm help"}
			
		}
	},
	["SideBar"] = {
		cat = TITAN_MODMENU_CAT_BAR,
		submenu = {
			{text = "Sidebar Status", cmd = "/sidebar status"},
			{text = "Sidebar fixieren", cmd = "/sidebar freeze"},
			{text = "Sidebar freigeben", cmd = "/sidebar unfreeze"},
			{text = "Sidebar Spalten getrennt einstellen", cmd = "/sidebar unlink"},
			{text = "Sidebar Spalten zusammen einstellen", cmd = "/sidebar link"},
			{text = "Sidebar zeige Rahmen", cmd = "/sidebar showgrid"},
			{text = "Sidebar verstecke Rahmen", cmd = "/sidebar hidegrid"},
			{text = "Buttons lock", cmd = "/sidebar lock"},
			{text = "Buttons unlock", cmd = "/sidebar unlock"},
			{text = "Sidebar Chat-Hilfe", cmd = "/sidebar"}
		}
	},
	["Looto"] = {
		cat = TITAN_MODMENU_CAT_COMBAT,
		submenu = {
			{text = "Looto aufrufen", cmd = "/Looto show"},
			{text = "Looto ausblenden", cmd = "/Looto hide"},
			{text = "Looto Zusammenfassung", cmd = "/looto summary"},
			{text = "Looto zur\195\188cksetzen", cmd = "/looto clear"},
			{text = "Looto Chat-Hilfe", cmd = "/Looto help link"}
		}
	},
	["MailTo"] = {
		cat = TITAN_MODMENU_CAT_OTHER,
		submenu = {
			{text = "MailTo zur\195\188cksetzen", cmd = "/mailto clear"},
			{text = "MailTo Namensliste", cmd = "/mailto"}
		}
	},
	["ImprovedIgnore"] = {
		cat = TITAN_MODMENU_CAT_FRIEND,
		submenu = {
			{text = "ImprovedIgnore Status", cmd = "/ii status"},
			{text = "Whispern zulassen", cmd = "/ii whisper on"},
			{text = "Whispern unterbinden", cmd = "/ii whisper off"}
		}
	},
	["Reputation"] = {
		submenu = {
			{text = "Reputation Ein", 					cmd = "/rep an"},
			{text = "Reputation Aus", 					cmd = "/rep aus"},
			{text = "Reputation Lade-Nachricht Ein/Aus", 			cmd = "/rep load"},
			TITAN_MODMENU_SPACER,
			{text = "Reputation Liste", 					cmd = "/rep Liste"},
			{text = "Reputation umschalten Absolut-/Prozentanzeige", 	cmd = "/rep absolute zahlen"},
			{text = "Reputation Meldungen Ein/Aus", 			cmd = "/rep meldungen"},
			{text = "Reputation Stufen Ein/Aus", 				cmd = "/rep stufen"},
			{text = "Reputation Wiederholungen Ein/Aus", 			cmd = "/rep wiederholungen"},
			{text = "Reputation Chat-invertieren Ein/Aus", 			cmd = "/rep invertieren"},
			TITAN_MODMENU_SPACER,	
			{text = "Reputation Status", 					cmd = "/rep status"},
			{text = "Chat-Hilfe", 						cmd = "/rep"},
		},
	},



	["JoChatTimestamp"] = {
		cat = TITAN_MODMENU_CAT_CHAT,
		submenu = {
			{text = "Status anzeigen", cmd = "/jostats"},
			{text = "Chat Scroll Ein", cmd = "/joscroll on"},
			{text = "Chat Scroll Aus", cmd = "/joscroll on"},
			{text = "Zeitanzeige Ein ", cmd = "/joframes all on"},
			{text = "Zeitanzeige Aus", cmd = "/joframes all off"},
			{text = "Chat-Hilfe", cmd = "/johelp"}
		},
		["deDE"] = {
			submenu = {
				{text = "Status anzeigen", cmd = "/jostats"},
				{text = "Chat Scroll Ein", cmd = "/joscroll on"},
				{text = "Chat Scroll Aus", cmd = "/joscroll on"},
				{text = "Zeitanzeige Ein ", cmd = "/joframes all on"},
				{text = "Zeitanzeige Aus", cmd = "/joframes all off"},
				{text = "Chat-Hilfe", cmd = "/johelp"}
			}
		}
	},

	["BGFlag"] = {
		cat = TITAN_MODMENU_CAT_COMBAT,
		submenu = {
			{text = "BGFlag aktivieren", cmd = "/bgflag enable"},
			{text = "BGFlag deaktivieren", cmd = "/bgflag disable"},
			{text = "Display zur\195\188cksetzen (Clear)", cmd = "/bgflag clear"},
			{text = "BGFlag-Frame fixieren", cmd = "/bgflag lock"},
			{text = "BGFlag-Frame freigeben", cmd = "/bgflag unlock"},
			{text = "Anzeigeposition zur\195\188cksetzen (Resete)", cmd = "/bgflag reset"}
		}
	},
	["SelfCastL"] = {
		cat = TITAN_MODMENU_CAT_COMBAT,
		submenu = {
			{text = "Chat-Hilfe", cmd = "/sc help"},
			{text = "Status", cmd = "/sc status"},
			{text = "Auto Selfcast Ein/Aus", cmd = "/sc self"},
			{text = "RightClick-Cast Ein/Aus", cmd = "/sc rightclick"}
		}
	},
	["ReagentInfo"] = {
		cat = TITAN_MODMENU_CAT_TRADESKILL,
		submenu = {
			{text = "Aktivieren", cmd = "/ri enable"},
			{text = "Deaktivieren", cmd = "/ri disable"},
			{text = "Jetzigen Char zur\195\188cksetzen", cmd = "/ri clear"},
			{text = "Alle Chars zur\195\188cksetzen", cmd = "/ri clearall"},
			{text = "Optionsmen\195\188 anzeigen", cmd = "/ri config"}
		}
	},
	["TargetOfTarget"] = {
		cat = TITAN_MODMENU_CAT_COMBAT,
		submenu = {
			{text = "Aktivieren", cmd = "/tot on"},
			{text = "Deaktivieren", cmd = "/tot off"},
			{text = "Optionen", cmd = "/tot params"},
			{text = "Chat-Hilfe", cmd = "/tot help"}
		}
	},
	["SeeAllTargetInfo"] = {
		cat = TITAN_MODMENU_CAT_COMBAT,
		submenu = {
			{text = "Enable", cmd = "/sati enable"},
			{text = "Disable", cmd = "/sati disable"},
			TITAN_MODMENU_SPACER,
			{text = "Enable Class", cmd = "/sati class on"},
			{text = "Disable Class", cmd = "/sati class off"},
			{text = "Lock Class", cmd = "/sati class lock"},
			{text = "Unlock Class", cmd = "/sati class unlock"},
			{text = "Reset Class", cmd = "/sati class reset"},
			TITAN_MODMENU_SPACER,
			{text = "Enable Debuff", cmd = "/sati debuff on"},
			{text = "Disable Debuff", cmd = "/sati debuff off"},
			TITAN_MODMENU_SPACER,
			{text = "Enable Buff", cmd = "/sati buff on"},
			{text = "Disable Buff", cmd = "/sati buff off"},
		},
	},
	["DamageToCasters"] = {cat = TITAN_MODMENU_CAT_COMBAT, 
		submenu = {
			{text = "Toggle", cmd = "/d2c toggle"},
			{text = "RaidToggle", cmd = "/d2c raidtoggle"},
			TITAN_MODMENU_SPACER,
			{text = "-Chat Toggles-"},
			{text = "Guild Chat", cmd = "/d2c guild"},
			{text = "Raid Chat", cmd = "/d2c raid"},
			{text = "Party Chat", cmd = "/d2c party"},
			{text = "Say Chat", cmd = "/d2c say"},
			{text = "Yell Chat", cmd = "/d2c yell"},
			TITAN_MODMENU_SPACER,
			{text = "Status", cmd = "/d2c status"},
		}
	},
	["FlagRSP"] = {
		submenu = {
			{text = "Help", cmd = "/rsp ?"},
			{text = "Edit", cmd = "/rsp edit"},
			{text = "Status", cmd = "/rsp status"},
			{text = "Your Tooltip", cmd = "/rsp owntooltip"},
			TITAN_MODMENU_SPACER,
			{text = "-Toggles-"},
			{text = "Rollplayer Flag", cmd = "/rsp"},
			{text = "Hide Unknown Names", cmd = "/rsp names"},
			{text = "Alt Lvl Display", cmd = "/rsp level"},
			{text = "Guild Names", cmd = "/rsp guilds"},
			TITAN_MODMENU_SPACER,
			{text = "-RP Type-"},
			{text = "Beginner", cmd = "/rsp beginner"},
			{text = "Casual", cmd = "/rsp casual"},
			{text = "Normal", cmd = "/rsp normal"},
			{text = "fulltime", cmd = "/rsp fulltime"},
			{text = "Off", cmd = "/rsp off"},
			TITAN_MODMENU_SPACER,
			{text = "-RP Status-"},
			{text = "OOC", cmd = "/rsp ooc"},
			{text = "IC", cmd = "/rsp ic"},
			{text = "FFA-IC", cmd = "/rsp ffa-ic"},
			{text = "Off", cmd = "/rsp stopcharstat"},
			TITAN_MODMENU_SPACER,
			{text = "Normal RP Settings", cmd = "/rspan"},
			{text = "Disable RP Settings", cmd = "/rspaus"},
		},
	},
	["FriendList"] = {
		submenu = {
			{text = "Help", cmd = "/fl help"},
			{text = "Show List", cmd = "/fl show"},
			{text = "Hide List", cmd = "/fl hide"},
			{text = "Show Minimap", cmd = "/fl mm an"},
			{text = "Hide Minimap", cmd = "/fl mm aus"},
			{text = "Import Friends", cmd = "/fl import"},
			{text = "Export Friends", cmd = "/fl export"},
			TITAN_MODMENU_SPACER,
			{text = "Reset", cmd = "/fl reset"},
		},
	},
	["SheepWatch"] = {cat = TITAN_MODMENU_CAT_CLASS,
		submenu = {
			{text = "Help", cmd = "/sheepwatch"},
			{text = "Counter", cmd = "/sheepwatch counter"},
			{text = "Verbose Mode", cmd = "/sheepwatch verbose"},
			TITAN_MODMENU_SPACER, 
			{text = "Announce Mode", cmd = "/sheepwatch announce"},
			{text = "in Say", cmd = "/sheepwatch target say"},
			{text = "in Party", cmd = "/sheepwatch target party"},
			{text = "in Guild", cmd = "/sheepwatch target guild"},
			{text = "in Raid", cmd = "/sheepwatch target raid"},
		},
	},

	["BookOfCrafts"] = {
		frame = "BC_MainFrame",
		cat = TITAN_MODMENU_CAT_TRADESKILL,
		text = "BookOfCrafts",
		submenu = {
			{text = "Optionen", cmd = "/boc"},
			}
	},
	["DepositBox"] = {
		frame = "DepositBoxUI_Frame",
		cat = TITAN_MODMENU_CAT_INVENTORY,
		text = "DepositBox (Sparbuch)",
		submenu = {
			{text = "Spund Ein/Aus", cmd = "/db sound"},
			{text = "Position zur\195\188cksetze", cmd = "/db reset"},
			{text = "\195\150ffnen/Verstecken", cmd = "/db display"},
			}


	},
	["FishingBuddy"] = {
		frame = "FishingBuddy",
		cat = TITAN_MODMENU_CAT_TRADESKILL,
		text = "FishingBuddy",
		submenu = {
			{text = "\195\150ffnen", cmd = "/fb"},
			{text = "Help", cmd = "/fb help"},
			{text = "Switch", cmd = "/fb switch"},
			}
	},
	["CallToArms"] = {
		frame = "CTA_MainFrame",
		cat = TITAN_MODMENU_CAT_PARTY,
		text = "CallToArms",
		submenu = {
			{text = "\195\150ffnen/Schliessen", cmd = "/cta toggle"},
			{text = "Befehlsliste (Chat)", cmd = "/cta"},
			{text = "Gruppe aufl\195\182sen", cmd = "/cta dissolve group"}
			}


	},
	["WarsongCommander"] = {
		frame = "WSC_Frame",
		cat = TITAN_MODMENU_CAT_COMBAT,
		text = "Warsong Commanders",
		submenu = {
			{text = "\195\150ffnen", cmd = "/wsc"},
			{text = "Optionen", cmd = "/wsc config"},
			{text = "Reset", cmd = "/wsc reset"}
			}


	},

	["PartyTarget"] = {
		cat = TITAN_MODMENU_CAT_COMBAT,
		submenu = {
			{text = "party targets on/off", cmd = "/pt partytargets"},
			{text = "target target on/off", cmd = "/pt targettarget"}
			},
	},
	["RangeColor"] = {
		cmd = "/rc",
		cat = TITAN_MODMENU_CAT_BAR,
	},
	["MobInfo2"] = {
		cat = TITAN_MODMENU_CAT_COMBAT,
			submenu = {
			{text = "MobInfo"},
			{text = "Browser", cmd ="/mi2b"},
			{text = "Optionen", cmd ="/mobinfo2"},
			{text = "Chat-Hilfe", cmd ="/mobinfo2 help"},
		},
	},
	["MobileFrames"] = {
		cat = TITAN_MODMENU_CAT_BAR,
		submenu = {
			{text = "MobileFrames"},
			{text = "Fenster-Anker anzeigen/freigeben",	 cmd ="/mobile anchors"},
			{text = "Fenster-Anker Sound Ein/Aus",		 cmd ="/mobile sound"},
			{text = "Bewegliche Fenster-Liste",		 cmd ="/mobile list"},
			{text = "Gruppen Loot-Fenster verschieben", 	 cmd ="/mobile rollstack"},
			{text = "Chat-Hilfe", 				 cmd ="/mobile"}
		},

	},
	["LootHog"] = {
		cmd = "/loothog",
		cat = TITAN_MODMENU_CAT_OTHER,
	},
	["BGBuddy"] = {
		cat = TITAN_MODMENU_CAT_COMBAT, 
		cmd = "/bgbuddy",
	},
	["ArmorCraft"] = {
		cat = TITAN_MODMENU_CAT_TRADESKILL,
		cmd = "/AC",
		submenu = {
			{text = "AC Ein/Aus", cmd = "/ac" },
			{text = "Atribut Settings anzeigen", cmd ="/acv" },
			{text = "Standart Einstellungen laden", cmd = "/acv default" },
			{text = "Eigene Armor Einstellungen auflisten", cmd ="/acv list" },
			{text = "Weitere Befehle: /ac <name>, /acv <attr>=<value>, /acv 0, /acv <value>"},			
		},
	},
	["RecipeBook"] = {
		cat = TITAN_MODMENU_CAT_TRADESKILL, 
		submenu = {
			{text = "Config", cmd = "/rb config" },
			{text = "RB Ein", cmd = "/rb on" },
			{text = "RB Aus", cmd ="/rb off" },
			{text = "RB Selbst Ein", cmd = "/rb self on" },
			{text = "RB Selbst Aus", cmd ="/rb self off" },
			{text = "RB Bankliste", cmd ="/rb banklist" },
			{text = "Bank anzeigen", cmd ="/rb banked on" },
			{text = "Bank nicht anzeigen", cmd ="/rb banked off" },
			{text = "Bankrezepte automatisch mitlogen Ein", cmd ="/rb autobank on" },
			{text = "Bankrezepte automatisch mitlogen Aus", cmd ="/rb autobank off" },
			{text = "Taschenrezepte automatisch mitlogen Ein", cmd ="/rb autobag on" },
			{text = "Taschenrezepte automatisch mitlogen Aus", cmd ="/rb autobag off" },
			{text = "Bekannte Rezepte zeigen", cmd ="/rb known on" },
			{text = "Bekannte Rezepte nicht zeigen", cmd ="/rb known off" },
			{text = "Lernbare Rezepte zeigen", cmd ="/rb learn on " },
			{text = "Lernbare Rezepte nicht zeigen", cmd ="/rb learn off" },
			{text = "Bald verwendbar zeigen", cmd ="/rb future on" },
			{text = "Bald verwendbar nicht zeigen", cmd ="/rb future off" },
			{text = "Freunde anzeigen", cmd ="/rb friend on" },
			{text = "Freunde nicht anzeigen", cmd ="/rb friend off" },
			{text = "Chat-Anzeige Ein", cmd ="/rb output chatframe on" },
			{text = "Chat-Anzeige Aus", cmd ="/rb output chatframe off" },
			{text = "Tooltip-Anzeige Ein", cmd ="/rb output tooltip on" },
			{text = "Tooltip-Anzeige Aus", cmd ="/rb output tooltip off" },
			{text = "Spezialisierungen scannen", cmd ="/rb specials" },
			{text = "Chat-Hilfe", cmd ="/rb help" },			
		},
	},

	["MailTip"] = {
		cat = TITAN_MODMENU_CAT_OTHER,
		cmd = "/AC",
		submenu = {
			{text = "MailTip Ein/Aus", cmd = "/mailtip standby" },
			{text = "MailTip ItemCount Overlay Ein/Aus", cmd ="/mailtip itemcount" },
			{text = "Tooltips Ein/Aus", cmd = "/mailtip tips" },
			{text = "Chat-Hilfe", cmd ="/mailtip" },			
		},
	},

	["Jotter-K"] = {
		cat = TITAN_MODMENU_CAT_OTHER,
		submenu = {
			{text = "Open", cmd = "/jotter" },
			{text = "Clear the current page", cmd = "/jt clear" },
			{text = "Clear all pages ", cmd ="/jt clearall" },
			{text = "Clear all bookmarks ", cmd ="/jt bookmark clearall" },
			{text = "Display a list of bookmark commands ", cmd = "/jt bookmark" },
			{text = "Help ", cmd ="/jt help" },	
			
		},
	},

	["KC_AutoRepair"] = {
		cat = TITAN_MODMENU_CAT_INVENTORY,
		submenu = {
			{text = "KC_AutoRepair Ein/Aus", 		cmd ="/kcar Standby" },
			{text = "Inventar Reperatur Ein/Aus", 		cmd ="/kcar Skipinv" },
			{text = "Optionsfenster \195\182ffnen", 	cmd ="/kcar config" },
			{text = "Chat-Hilfe", 				cmd ="/kcar" },	
			
		},
	},
	["ItemSync"] = {
		cat = TITAN_MODMENU_CAT_INVENTORY,
		submenu = {
			{text = "ItemSync \195\182ffnen", 		cmd ="/itemsync" },
			{text = "Chat-Hilfe", 				cmd ="/itemsync help" },	
			
		},
	},
		["BonusScanner"] = {
		cat = TITAN_MODMENU_CAT_OTHER,
		submenu = {
			{text = "Itembonis anzeigen (nur Bonis)", 			cmd ="/BonusScanner show" },
			{text = "Itembonis detailliert anzeigen (Bonis und Itemslot)", 	cmd ="/BonusScanner details" },
			{text = "Chat-Hilfe", 						cmd ="/BonusScanner" },	
			
		},
	},
		["SuperInspect"] = {
		cat = TITAN_MODMENU_CAT_OTHER,
		submenu = {
			{text = "Reset der Fensterposition", 					cmd ="/SuperInspect reset" },
			{text = "Default Ein/Aus (umschlaten zwischen Standard/Scale-Modus)", 	cmd ="/SuperInspect defaulttoggle" },
			{text = "Item-Darstellung umschalten", 				cmd ="/superinspect itembgtoggle" },
			{text = "Haltbarkeitsinfo umschalten", 					cmd ="/superinspect durabilitytoggle"},
			{text = "Fenster-Sound Ein/Aus", 					cmd ="/superinspect sound" },
			{text = "Chat-Hilfe", 						cmd ="/SuperInspect" },		
		},
	},		
		["CalcIt"] = {
		cat = TITAN_MODMENU_CAT_OTHER,
		submenu = {
			{text = "Bsp: /ci 5+5*2"},
			{text = "Chat-Hilfe", 						cmd ="/ci" },	
			
		},
	},
		["GathererShare"] = {
		cat = TITAN_MODMENU_CAT_MAP,
		submenu = {
			{text = "GathererShare all messages on", 				cmd ="/gshare messages on" },	
			{text = "GathererShare all messages off", 				cmd ="/gshare messages off" },
			{text = "GathererShare only shared messages", 				cmd ="/gshare messages shared" },	
			{text = "GathererShare only learned messages", 			cmd ="/gshare messages learned" },
			{text = "GathererShare sound on", 					cmd ="/gshare sound on" },	
			{text = "GathererShare sound off", 					cmd ="/gshare sound off" },
			{text = "GathererShare updatenote on", 				cmd ="/gshare updatenote on" },	
			{text = "GathererShare updatenote off", 				cmd ="/gshare updatenote off" },
			{text = "GathererShare color on", 					cmd ="/gshare color on" },	
			{text = "GathererShare color off", 					cmd ="/gshare color off" },
			--{text = "GathererShare dumb on", 					cmd ="/gshare GathererDump on" },
			--{text = "GathererShare dumb off", 					cmd ="/gshare GathererDump off" },
			--{text = "GathererShare dumb entire database", 			cmd ="/gatherdump" },	
			{text = "GathererShare show settings", 				cmd ="/gshare settings" },
			
		},
	},
		["KC_Items"] = {
		cat = TITAN_MODMENU_CAT_INVENTORY,
		submenu = {
			{text = "KC Items On/Off", 				cmd ="/kcitems standby" },	
			{text = "KC Items Report", 				cmd ="/kcitems report" },
			{text = "KC Items Chat-Hilfe", 				cmd ="/kcitems" },	
			{text = "KC Items DB l\195\182schen", 			cmd ="/kcitems core clear" },	
		},
	},
		["SpellMats"] = {
		cat = TITAN_MODMENU_CAT_BAR,
		submenu = {
			{text = "SpellMats Ein", 				cmd ="/smtoggle on" },	
			{text = "SpellMats Aus", 				cmd ="/smtoggle off" },
			{text = "SpellMats Grenzen auflisten", 			cmd ="/sml" },
			{text = "Chat-Hilfe", 					cmd ="/spellmats" },	
		},
	},
	["CT_RaidTracker"] = {
		cat = TITAN_MODMENU_CAT_RAID,
		submenu = {
			{text = "RaidTracker \195\182ffnen", 			cmd ="/rt" },
			{text = "RaidTracker optionen", 			cmd ="/rt options" },	
			{text = "Item-Optionen", 				cmd ="/rt io" },
			{text = "Altes Export-Format Ein", 			cmd ="/rt oldformat 1" },
			{text = "Altes Export-Format Aus", 			cmd ="/rt oldformat 0" },
			{text = "Chat-Hilfe", 				cmd ="/rt help" },
			{text = "Alle Raids l\195\182schen", 			cmd ="/rt deleteall" },

		},
	},

		["QuestHistory"] = {
		cat = TITAN_MODMENU_CAT_QUEST,
		submenu = {
			{text = "QuestHistory \195\182ffnen", 			cmd ="/QuestHistory" },	
			{text = "Quest-Level Anzeige bei NPC´s Ein/Aus", 	cmd ="/qh levels" },
		},
	},
		["KLHThreatMeter"] = {
		cat = TITAN_MODMENU_CAT_COMBAT,
		submenu = {
			--{text = "Main show", 			cmd ="/ktm main show" },
			--{text = "Main table", 			cmd ="/ktm main table" },
			--{text = "Main clear", 			cmd ="/ktm main clear" },
			--{text = "Main close", 			cmd ="/ktm main close" },			
			--{text = "Main pin", 			cmd ="/ktm main pin" },
			--{text = "Main reset", 			cmd ="/ktm main reset" },			
			--TITAN_MODMENU_SPACER,	
			--{text = "Raid show", 			cmd ="/ktm raid show" },
			--{text = "Raid table", 			cmd ="/ktm raid table" },
			--{text = "Raid clear", 			cmd ="/ktm raid clear" },
			--{text = "Raid close", 			cmd ="/ktm raid close" },			
			--{text = "Raid pin", 			cmd ="/ktm raid pin" },
			--{text = "Raid rows", 			cmd ="/ktm raid rows" },	
			--TITAN_MODMENU_SPACER,	
			--{text = "Mastertarget set", 			cmd ="/ktm mastertarget set" },
			--{text = "Mastertarget clear", 		cmd ="/ktm mastertarget clear" },
			{text = "KLH open", 			cmd ="/ktm gui show" },
			{text = "KLH reset position", 			cmd ="/ktm gui reset" },
			TITAN_MODMENU_SPACER,	
			{text = "KLH disable", 			cmd ="/ktm disable" },			
			{text = "KLH enable", 			cmd ="/ktm enable" },
			TITAN_MODMENU_SPACER,	
			{text = "Knockback start", 			cmd ="/ktm knockback start" },
			{text = "Knockback stop", 			cmd ="/ktm knockback stop" },
			--{text = "Knockback value", 			cmd ="/ktm knockback value" },
			TITAN_MODMENU_SPACER,
			{text = "Chat help", 			cmd ="/KLHThreatMeter" },
		},
	},
		["Magellan"] = {
		cat = TITAN_MODMENU_CAT_MAP,
		submenu = {
			{text = "Magellan Notizen l\195\182schen", 			cmd ="/magellan reset" },	
		},
	},
		["rSelfCast"] = {
		cat = TITAN_MODMENU_CAT_COMBAT,
		submenu = {
			{text = "RightClick SelfCast Ein", 			cmd ="/rsc enable" },
			{text = "RightClick SelfCast Aus", 			cmd ="/rsc disable" },	
			{text = "Chat-Hilfe", 				cmd ="/rsc" },	
		},
	},
		["Wardrobe"] = {
		cat = TITAN_MODMENU_CAT_COMBAT,
		submenu = {
			{text = "Wardrobe Icon unlocken", 			cmd ="/Wardrobe unlock" },
			{text = "Wardrobe Icon locken", 			cmd ="/Wardrobe lock" },	
			{text = "Mouseovermen\195\188 Ein", 			cmd ="/Wardrobe mouseover" },
			{text = "Klickmen\195\188 Ein", 			cmd ="/Wardrobe click" },
			{text = "Alle Outfits auflisten", 			cmd ="/Wardrobe list" },
			{text = "Alle Outfits l\195\182schen", 			cmd ="/Wardrobe reset" },		
			{text = "Chat-Hilfe", 				cmd ="/Wardrobe" },	
		},
	},

		["CEnemyCastBar"] = {
		cat = TITAN_MODMENU_CAT_COMBAT,
		submenu = {
			--{text = "Bewegl.Castbar", 				cmd ="/necb show" },	
			{text = "Castbar entfernen", 				cmd ="/necb clear" },	
			{text = "Chat-Hilfe", 				cmd ="/necb help" },	
			{text = "Optionen", 				cmd ="/necb" },	
		},
	},
		["CastTime"] = {
		cat = TITAN_MODMENU_CAT_COMBAT,
		submenu = {
			{text = "Status", 					cmd ="/castt status" },	
			{text = "Anzeige Ein", 				cmd ="/castt anzeige ein" },	
			{text = "Anzeige Aus", 				cmd ="/castt anzeige aus" },	
			{text = "Ausserhalb Ein", 				cmd ="/castt ausserhalb ein" },	
			{text = "Ausserhalb Aus", 				cmd ="/castt ausserhalb aus" },	
			{text = "Innerhalb Ein", 				cmd ="/castt innerhalb ein" },	
			{text = "Innerhalb Aus", 				cmd ="/castt innerhalb aus" },	
			{text = "Fenster Ein", 				cmd ="/castt fenster ein" },	
			{text = "Fenster Aus", 				cmd ="/castt fenster aus" },	
			{text = "Verzoegerung Ein", 				cmd ="/castt verzoegerung ein" },	
			{text = "Verzoegerung Aus", 				cmd ="/castt verzoegerung aus" },	
			{text = "Hun Ein", 					cmd ="/castt hun ein" },	
			{text = "Hun Aus", 					cmd ="/castt hun aus" },	
			{text = "Fixieren Ein", 				cmd ="/castt fixieren ein" },	
			{text = "Fixieren Aus", 				cmd ="/castt fixieren aus" },	
			{text = "Spiegel Ein", 				cmd ="/castt spiegel ein" },	
			{text = "Spiegel Aus", 				cmd ="/castt spiegel aus" },	
			{text = "Chat-Hilfe", 				cmd ="/castt" },	
		},
	},


		["Enchantrix"] = {
		cat = TITAN_MODMENU_CAT_TRADESKILL,
		submenu = {
			{text = "Laden", 							cmd ="/Enchantrix load" },
			{text = "Immer laden", 						cmd ="/Enchantrix load always" },	
			{text = "Niemals laden", 						cmd ="/Enchantrix load never" },
			--{text = "Autom. laden Aus", 						cmd ="/Enchantrix ausschalten" },
			{text = "Standardwerte laden", 					cmd ="/Enchantrix default all" },
			{text = "Datenbank l\195\182schen", 					cmd ="/Enchantrix clear all" },

			TITAN_MODMENU_SPACER,	

			{text = "Bestimme gesch\195\164tzten Verkaufspreis Ein/Aus", 		cmd ="/Enchantrix valuate toggle" },	
			{text = "Bestimme HVP (H\195\182chster bezahlter Preis) Ein/Aus", 	cmd ="/Enchantrix valuate-hsp toggle" },	
			{text = "Bestimme Median Preis Ein/Aus", 				cmd ="/Enchantrix valuate-median toggle" },
			{text = "Bestimme Marktpreis aus interner Preisliste Ein/Aus", 		cmd ="/Enchantrix valuate-baseline toggle" },		

			TITAN_MODMENU_SPACER,	
			{text = "Bieten Broker", cmd = "/Enchantrix bidbroker" },
			{text = "Prozent Broker", cmd = "/Enchantrix percentless" },
			TITAN_MODMENU_SPACER,	

			{text = "Barker Ein/Aus", 						cmd ="/Enchantrix barker toggle" },
			{text = "Entzauberdaten-Anzahl anzeigen Ein/Aus", 			cmd ="/Enchantrix counts toggle" },
			{text = "Kurzinfo modus (nur Wert)", 					cmd ="/Enchantrix terse toggle" },
			{text = "Eingebettete Tolltips Ein/Aus", 				cmd ="/Enchantrix embed toggle" },

			TITAN_MODMENU_SPACER,	

			{text = "Chat-Hilfe", 						cmd ="/Enchantrix" },	
		},
	},

		["EQDKPRaidBanker"] = {
		cat = TITAN_MODMENU_CAT_RAID,
		submenu = {
			{text = "Bank scannen", 				cmd ="/raidbanker scan" },	
			{text = "Log exportieren", 				cmd ="/raidbanker getlog" },	
		},
	},

		["TitanFriends"] = {
		cat = TITAN_MODMENU_CAT_FRIEND,
		submenu = {
			{text = "Offline anzeigen", 				cmd ="/titanfriends showoffline" },	
			{text = "Ignoreliste anzeigen", 			cmd ="/titanfriends showignored" },	
			{text = "Klassen anzeigen", 				cmd ="/titanfriends showclass" },	
			{text = "Chat-Hilfe", 				cmd ="/titanfriends help" },	
		},
	},
		["AutoInvite"] = {
		cat = TITAN_MODMENU_CAT_RAID,
		submenu = {
			{text = "Men\195\188 anzeigen", 				cmd ="/AutoInvite show" },	
			{text = "Ziel zur Liste hinzuf\195\188gen", 			cmd ="/titanfriends showignored" },	

		},
	},
		["PvPLog"] = {
		cat = TITAN_MODMENU_CAT_OTHER,
		submenu = {
			{text = "PvPLog Ein", 					cmd ="/pvplog enable" },	
			{text = "PvPLog Aus", 					cmd ="/pvplog disable" },	
			{text = "PvPLog Stats", 					cmd ="/pvplog stats" },	
			{text = "Alle Daten l\195\182schen", 				cmd ="/pvplog reset confirm" },
		
			TITAN_MODMENU_SPACER,	
				
			{text = "PvPLog keine Kills anzeigen lassen", 			cmd ="/pvplog notifykills none" },	
			{text = "PvPLog Gruppenkills anzeigen lassen", 			cmd ="/pvplog notifykills Party" },				
			{text = "PvPLog Gildenkills anzeigen lassen", 			cmd ="/pvplog notifykills Guild" },	
			{text = "PvPLog Raidkills anzeigen lassen", 			cmd ="/pvplog notifykills Raid" },

			TITAN_MODMENU_SPACER,	
	
			{text = "PvPLog keine Deaths anzeigen lassen", 		cmd ="/pvplog notifydeath none" },	
			{text = "PvPLog Gruppendeaths anzeigen lassen", 		cmd ="/pvplog notifydeath Party" },	
			{text = "PvPLog Gildendeaths anzeigen lassen", 		cmd ="/pvplog notifydeath Guild" },	
			{text = "PvPLog Raiddeaths anzeigen lassen", 			cmd ="/pvplog notifydeath Raid" },	

			TITAN_MODMENU_SPACER,	

			{text = "Chat-Hilfe", 					cmd ="/pvplog" },		
		},
	},
		["CharacterProfiler"] = {
		cat = TITAN_MODMENU_CAT_OTHER,
		submenu = {
			{text = "Profiler Ein", 					cmd ="/cp on" },	
			{text = "Profiler Aus", 					cmd ="/cp off" },	
			{text = "Profiler export", 					cmd ="/cp export" },	
			{text = "Profilerdaten anzeigen", 				cmd ="/cp show" },			
			{text = "Profiler Lite Ein - Kein Scannen in Raids oder Instanzen", 	cmd ="/cp lite on" },	
			{text = "Profiler Lite Aus - Scannen auch in Raids oder Instanzen", 	cmd ="/cp lite off" },

			TITAN_MODMENU_SPACER,	

			{text = "Alle Daten l\195\182schen", 				cmd ="/cp purge all" },	
			{text = "Spielerdaten l\195\182schen", 			cmd ="/cp purge char" },
			{text = "Serverdaten l\195\182schen", 				cmd ="/cp purge server" },

			TITAN_MODMENU_SPACER,	
	
			{text = "Chat-Hilfe", 					cmd ="/cp" },	
		},
	},
		["DKPInfo"] = {
		cat = TITAN_MODMENU_CAT_RAID,
		submenu = {
			{text = "Raid alle anzeigen", 					cmd ="/dkp display raid all" },	
			{text = "Raid Druiden anzeigen", 				cmd ="/dkp display raid druide" },	
			{text = "Raid Hexenmeister anzeigen", 			cmd ="/dkp display raid hexenmeister" },	
			{text = "Raid J\195\164ger anzeigen", 				cmd ="/dkp display raid j\195\164ger" },			
			{text = "Raid Krieger anzeigen", 				cmd ="/dkp display raid krieger" },	
			{text = "Raid Magier anzeigen", 				cmd ="/dkp display raid magier" },	
			{text = "Raid Paladine anzeigen", 				cmd ="/dkp display raid paladin" },	
			{text = "Raid Priester anzeigen", 				cmd ="/dkp display raid priester" },
			{text = "Raid Schurken anzeigen", 				cmd ="/dkp display raid schurke" },	
			{text = "DKP Raindinfo - Whipser", 				cmd ="/ra Um eure DKP Punkte zu bekommen, einfach mich anwhispern mit: dkp -EuerName-" },
			{text = "Whisper Ein", 					cmd ="/dkp whisper on" },	
			{text = "Whisper Aus", 					cmd ="/dkp whisper off" },	
			{text = "Chat-Hilfe", 					cmd ="/dkp help" },	
		},
	},
		["LockBarII"] = {
		cat = TITAN_MODMENU_CAT_BAR,
		submenu = {
			{text = "Show checkbox", 				cmd ="/lbii showcheck" },	
			{text = "Show minimap-button", 			cmd ="/lbii showbutton" },	

		},
	},
		["DKPTable"] = {
		cat = TITAN_MODMENU_CAT_RAID,
		submenu = {
			{text = "DKPTable \195\182ffnen", 	cmd ="/dkptable" },	
			{text = "DKP Raindinfo - Whipser", 	cmd ="/ra Um eure DKP Punkte zu bekommen, einfach mich anwhispern mit: ''!dkp list -EuerName-'' oder  ''!dkp me''" },
		},
	},


		["MetaMap"] = {
		cat = TITAN_MODMENU_CAT_MAP,
		submenu = {
			--{text = "Deutsche Zonen konvertieren !WICHTIG: NUR EINMAL VERWENDEN! (WTF sichern!)", 	cmd ="/script MetaMapZSU_Convert()" },	
			{text = "N\195\164chste Mapnote als Mininote und auf der Weltkarte anzeigen - Ein", 		cmd ="/nextmininote on" },	
			{text = "N\195\164chste Mapnote als Mininote und auf der Weltkarte anzeigen - Aus", 		cmd ="/nextmininote off" },	
			{text = "N\195\164chste Mapnote als Mininote - Ein", 			cmd ="/nextmininoteonly on" },	
			{text = "N\195\164chste Mapnote als Mininote - Aus", 			cmd ="/nextmininoteonly off" },	
			{text = "Mininotes - Aus", 						cmd ="/mininoteoff" },	
		},
	},
		["CharactersViewer"] = {
		text="CharactersViewer / BankItems",
		cat = TITAN_MODMENU_CAT_INVENTORY,
		submenu = {
			{text = "Char anzeigen", 								cmd ="/cv show" },	
			{text = "N\195\164chsten Char anzeigen", 						cmd ="/cv next" },	
			{text = "Vorherigen Char anzeigen", 							cmd ="/cv previous" },
			{text = "Verschiedene Charinformation auflisten", 					cmd ="/cv list" },
			{text = "Alle Chardaten l\195\182schen", 						cmd ="/cv clearall" },
			TITAN_MODMENU_SPACER,		
			{text = "Bank anzeigen", 								cmd ="/cv bank" },
		},
	},
		["aftt_extreme"] = {
		cat = TITAN_MODMENU_CAT_OTHER,
		submenu = {
			{text = "AF Optionen", 								cmd ="/aftte menu" },	
		},
	},
			["FriendData"] = {
		cat =TITAN_MODMENU_CAT_FRIEND,
		submenu = {
			{text = "Optionen", 								cmd ="/FriendData config" },	
			{text = "Chat-Hilfe", 								cmd ="/FriendData" },
		},
	},
			
	["Decursive"] = {
		cat = TITAN_MODMENU_CAT_COMBAT,
		submenu = {
			{text = "DC anzeigen", 								cmd ="/dcrshow" },
			{text = "Position zur\195\188cksetzen", 					cmd ="/dcrreset" },
			TITAN_MODMENU_SPACER,	
			{text = "Jemanden reinigen", 							cmd ="/decursive" },
			TITAN_MODMENU_SPACER,	
			{text = "Ziel zu Priorit\195\164tenliste", 				cmd ="/dcrpradd" },	
			{text = "Priorit\195\164tenliste l\195\182schen", 			cmd ="/dcrprclear" },
			{text = "Priorit\195\164tenliste-UI anzeigen", 				cmd ="/dcrprshow" },
			TITAN_MODMENU_SPACER,
			{text = "Ziel zu Skipliste", 							cmd ="/dcrskadd" },	
			{text = "Skipliste l\195\182schen", 					cmd ="/dcrskclear" },
			{text = "Skipliste-UI anzeigen", 						cmd ="/dcrskshow" },

		},
	},
	["SW_Stats"] = {
		cat = TITAN_MODMENU_CAT_COMBAT,
		submenu = {
			{text = "SW_Stats anzeigen", 							cmd ="/swstats balken" },
			TITAN_MODMENU_SPACER,	
			{text = "Fenster zuru\195\188cksetzen", 					cmd ="/swstats resetwin" },
			{text = "Konsole anzeigen", 							cmd ="/swstats kon" },
			{text = "Allgemeine Einstellungen", 							cmd ="/swstats ae" },
			TITAN_MODMENU_SPACER,	
			{text = "Daten l\195\182schen", 							cmd ="/swstats nuke" },
			{text = "Chat-Hilfe", 							cmd ="/swstats" },
			TITAN_MODMENU_SPACER,	
			{text = "Sync reset vote", 							cmd ="/swstats rv" },
		},
	},
	["Detox"] = {
		cat = TITAN_MODMENU_CAT_COMBAT,
		submenu = {
			{text = "MiniMap-Icon (Men\195\188) On/Off", 				cmd ="/detox hide" },
			{text = "Chat-Hilfe", 					cmd ="/detox" },

		},
	},



};



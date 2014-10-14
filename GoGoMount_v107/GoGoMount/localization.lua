if (GetLocale() == "frFR") then -- french localization
    BINDING_NAME_GOGONAME = "Monter/D\195\169monter"

	GoGo_SpellEnableString = "Sorts de monture inclus"
	GoGo_SpellDisableString = "Sorts de monture exclus"

	GoGo_MountString = "Augmente la vitesse de" -- the string in second line of tooltip
	GoGo_WolfString = "Loup fant\195\180me"
	GoGo_CheetahString = "Forme du voyage"

	GoGo_Mounts = {
		"%[Cor du loup brun rapide%]",
		"%[Cor du loup gris rapide%]",
		"%[Cor du loup des bois rapide%]",
		"%[Cor du loup de guerre noir%]",
		"%[Cor du loup arctique%]",
		"%[Cor du loup rouge%]",

		"%[Grand kodo brun%]",
		"%[Grand kodo gris%]",
		"%[Grand kodo blanc%]",
		"%[Kodo de guerre noir%]",
		"%[Kodo vert%]",
		"%[Kodo bleu%]",

		"%[Raptor bleu rapide%]",
		"%[Raptor vert olive rapide%]",
		"%[Raptor orange rapide%]",
		"%[Sifflet du raptor de guerre noir%]",
		"%[Sifflet de raptor rouge tachet\195\169%]",
		"%[Sifflet de raptor ivoire%]",

		"%[Cheval de guerre squelette vert%]",
		"%[Cheval de guerre squelette violet%]",
		"%[Cheval de guerre squelette rouge%]",

		"%[B\195\169lier gris rapide%]",
		"%[B\195\169lier brun rapide%]",
		"%[B\195\169lier blanc rapide%]",
		"%[B\195\169lier de guerre noir%]",
		"%[B\195\169lier noir%]",
		"%[B\195\169lier de givre%]",

		"%[M\195\169canotrotteur vert rapide%]",
		"%[M\195\169canotrotteur blanc rapide%]",
		"%[M\195\169canotrotteur jaune rapide%]",
		"%[Trotteur de bataille noir%]",
		"%[M\195\169canotrotteur bleu clair Mod A%]",
		"%[M\195\169canotrotteur blanc Mod A%]",

		"%[Palefroi bai rapide%]",
		"%[Palomino rapide%]",
		"%[Palefroi blanc rapide%]",
		"%[Bride de palefroi de guerre noir%]",
		"%[Bride de palomino%]",
		"%[Bride d'\195\169talon blanc%]",

		"%[R\195\170nes de sabre-de-givre rapide%]",
		"%[R\195\170nes de sabre-de-brume rapide%]",
		"%[R\195\170nes de sabre-temp\195\170te rapide%]",
		"%[R\195\170nes de tigre de guerre noir%]",
		"%[R\195\170nes de sabre-de-givre%]",
		"%[R\195\170nes de sabre-de-nuit%]",
		
		"%[R\195\170nes de destrier de la mort%]",
		"%[R\195\170nes de sabre-de-givre de Berceau-de-l'Hiver%]",
		"%[Cor du hurleur Frostwolf%]",
		"%[Destrier de bataille stormpike%]",
		"%[Raptor razzashi rapide%]",
		"%[Tigre zulien rapide%]",
		"%[Cristal de r\195\169sonance qiraji noir%]",

		["PALADIN"] = "Invocation de destrier",
		["WARLOCK"] = "Invocation d'un destrier de l'effroi",
	}

	GoGo_NubMounts = {
		"%[Cor du loup brun%]",
		"%[Cor du loup redoutable%]",
		"%[Cor du loup des bois%]",

		"%[Kodo brun%]",
		"%[Kodo gris%]",

		"%[Sifflet de raptor \195\169meraude%]",
		"%[Sifflet de raptor turquoise%]",
		"%[Sifflet de raptor violet%]",

		"%[Cheval squelette rouge%]",
		"%[Cheval squelette bleu%]",
		"%[Cheval squelette bai%]",

		"%[B\195\169lier brun%]",
		"%[B\195\169lier gris%]",
		"%[B\195\169lier blanc%]",

		"%[M\195\169canotrotteur bleu%]",
		"%[M\195\169canotrotteur vert%]",
		"%[M\195\169canotrotteur rouge%]",
		"%[M\195\169canotrotteur brut%]",

		"%[Bride de jument alezane%]",
		"%[Bride d'\195\169talon noir%]",
		"%[Bride de cheval bai%]",
		"%[Bride de pinto%]",

		"%[R\195\170nes de sabre-de-givre tachet\195\169%]",
		"%[R\195\170nes de sabre-de-givre ray\195\169%]",
		"%[R\195\170nes de sabre-de-nuit ray\195\169%]",

		["PALADIN"] = "Invocation d'un cheval de guerre",
		["WARLOCK"] = "Invocation d'un palefroi corrompu",
	}

	GoGo_WtfMounts = {
		["SHAMAN"] = "Loup fant\195\180me",
		["DRUID"] = "Forme du voyage",
	}

	GoGo_Bugs = {
		"%[Cristal de r\195\169sonance qiraji bleu%]",
		"%[Cristal de r\195\169sonance qiraji vert%]",
		"%[Cristal de r\195\169sonance qiraji rouge%]",
		"%[Cristal de r\195\169sonance qiraji jaune%]",
		"%[Cristal de r\195\169sonance qiraji noir%]",
	}

elseif (GetLocale() == "deDE") then -- german localization
    BINDING_NAME_GOGONAME = "Aufsitzen/Absitzen"

	GoGo_SpellEnableString = "Beschw\195\182erte Reittiere eingeschlossen"
	GoGo_SpellDisableString = "Beschw\195\182erte Reittiere ausgeschlossen"

	GoGo_MountString = "Erh\195\182ht Tempo um"
	GoGo_WolfString = "Geisterwolf"
	GoGo_CheetahString = "Reisegestalt"

	GoGo_Mounts = {
		"%[Horn des schnellen braunen Wolfs%]",
		"%[Horn des schnellen Grauwolfs%]",
		"%[Horn des schnellen Waldwolfs%]",
		"%[Horn des schwarzen Kriegswolfs%]",
		"%[Horn des arktischen Wolfs%]",
		"%[Horn des roten Wolfs%]",

		"%[Gro\195\159er brauner Kodo%]",
		"%[Gro\195\159er grauer Kodo%]",
		"%[Gro\195\159er wei\195\159er Kodo%]",
		"%[Schwarzer Kriegskodo%]",
		"%[Gr\195\188ner Kodo%]",
		"%[Graublauer Kodo%]",

		"%[Schneller blauer Raptor%]",
		"%[Schneller olivfarbener Raptor%]",
		"%[Schneller orangener Raptor%]",
		"%[Pfeife des schwarzen Kriegsraptors%]",
		"%[Pfeife des scheckigen roten Raptors%]",
		"%[Pfeife des elfenbeinfarbenen Raptors%]",

		"%[Gr\195\188nes Skelettschlachtross%]",
		"%[Purpurnes Skelettschlachtross%]",
		"%[Rotes Skelettschlachtross%]",

		"%[Schneller grauer Widder%]",
		"%[Schneller brauner Widder%]",
		"%[Schneller wei\195\159er Widder%]",
		"%[Schwarzer Kriegswidder%]",
		"%[Schwarzer Widder%]",
		"%[Frostwidder%]",

		"%[Schneller gr\195\188ner Roboschreiter%]",
		"%[Schneller wei\195\159er Roboschreiter%]",
		"%[Schneller gelber Roboschreiter%]",
		"%[Schwarzer Schlachtenschreiter%]",
		"%[Eisblauer Roboschreiter Mod%. A%]",
		"%[Wei\195\159er Roboschreiter Mod%. A%]",

		"%[Schneller Brauner%]",
		"%[Schnelles Palomino%]",
		"%[Schnelles wei\195\159es Ross%]",
		"%[Schwarzes Schlachtrosszaumzeug%]",
		"%[Palominozaumzeug%]",
		"%[Schimmelzaumzeug%]",

		"%[Z\195\188gel des schnellen Frosts\195\164blers%]",
		"%[Z\195\188gel des schnellen Schattens\195\164blers%]",
		"%[Z\195\188gel des schnellen Sturms\195\164blers%]",
		"%[Z\195\188gel des schwarzen Kriegstigers%]",
		"%[Z\195\188gel des Frosts\195\164blers%]",
		"%[Z\195\188gel des Nachts\195\164blers%]",

		"%[Z\195\188gel des Todesstreitrosses%]",
		"%[Z\195\188gel des Winterspringfrosts\195\164blers%]",
		"%[Horn des Frostwolfheulers%]",
		"%[Streitwidder der Stormpike%]",
		"%[Schneller Razzashiraptor%]",
		"%[Schneller zulianischer Tiger%]",
		"%[Schwarzer Qirajiresonanzkristall%]",

		["PALADIN"] = "Streitross beschw\195\182ren",
		["WARLOCK"] = "Schreckensross herbeirufen",
	}

	GoGo_NubMounts = {
		"%[Horn des braunen Wolfs%]",
		"%[Horn des Terrorwolfs%]",
		"%[Horn des Waldwolfs%]",

		"%[Brauner Kodo%]",
		"%[Grauer Kodo%]",

		"%[Pfeife des smaragdfarbenen Raptors%]",
		"%[Pfeife des t\195\188rkisfarbenen Raptors%]",
		"%[Pfeife des violetten Raptors%]",

		"%[Rotes Skelettpferd%]",
		"%[Blaues Skelettpferd%]",
		"%[Braunes Skelettpferd%]",

		"%[Brauner Widder%]",
		"%[Grauer Widder%]",
		"%[Wei\195\159er Widder%]",

		"%[Blauer Roboschreiter%]",
		"%[Gr\195\188ner Roboschreiter%]",
		"%[Roter Roboschreiter%]",
		"%[Unlackierter Roboschreiter%]",

		"%[Kastanienbraune Stute%]",
		"%[Rappenzaumzeug%]",
		"%[Braunes Pferd%]",
		"%[Schecke%]",

		"%[Z\195\188gel des gefleckten Frosts\195\164blers%]",
		"%[Z\195\188gel des gestreiften Frosts\195\164blers%]",
		"%[Z\195\188gel des gestreiften Nachts\195\164blers%]",

		["PALADIN"] = "Schlachtross beschw\195\182ren",
		["WARLOCK"] = "Teufelsross beschw\195\182ren",
	}

	GoGo_WtfMounts = {
		["SHAMAN"] = "Geisterwolf",
		["DRUID"] = "Reisegestalt",
	}

	GoGo_Bugs = {
		"%[Blauer Qirajiresonanzkristall%]",
		"%[Gr\195\188ner Qirajiresonanzkristall%]",
		"%[Roter Qirajiresonanzkristall%]",
		"%[Gelber Qirajiresonanzkristall%]",
		"%[Schwarzer Qirajiresonanzkristall%]",
	}

else -- english & default localization
    BINDING_NAME_GOGONAME = "Mount/Dismount"

	GoGo_SpellEnableString = "Spellmounts included"
	GoGo_SpellDisableString = "Spellmounts excluded"

	GoGo_MountString = "Increases speed by" -- the string in second line of tooltip
	GoGo_WolfString = "Ghost Wolf"
	GoGo_CheetahString = "Travel Form"

	GoGo_Mounts = {
		"%[Horn of the Swift Brown Wolf%]",
		"%[Horn of the Swift Gray Wolf%]",
		"%[Horn of the Swift Timber Wolf%]",
		"%[Horn of the Black War Wolf%]",
		"%[Horn of the Arctic Wolf%]",
		"%[Horn of the Red Wolf%]",

		"%[Great Brown Kodo%]",
		"%[Great Gray Kodo%]",
		"%[Great White Kodo%]",
		"%[Black War Kodo%]",
		"%[Green Kodo%]",
		"%[Teal Kodo%]",

		"%[Swift Blue Raptor%]",
		"%[Swift Olive Raptor%]",
		"%[Swift Orange Raptor%]",
		"%[Whistle of the Black War Raptor%]",
		"%[Whistle of the Mottled Red Raptor%]",
		"%[Whistle of the Ivory Raptor%]",

		"%[Green Skeletal Warhorse%]",
		"%[Purple Skeletal Warhorse%]",
		"%[Red Skeletal Warhorse%]",

		"%[Swift Gray Ram%]",
		"%[Swift Brown Ram%]",
		"%[Swift White Ram%]",
		"%[Black War Ram%]",
		"%[Black Ram%]",
		"%[Frost Ram%]",

		"%[Swift Green Mechanostrider%]",
		"%[Swift White Mechanostrider%]",
		"%[Swift Yellow Mechanostrider%]",
		"%[Black Battlestrider%]",
		"%[Icy Blue Mechanostrider Mod A%]",
		"%[White Mechanostrider Mod A%]",

		"%[Swift Brown Steed%]",
		"%[Swift Palomino%]",
		"%[Swift White Steed%]",
		"%[Black War Steed Bridle%]",
		"%[Palomino Bridle%]",
		"%[White Stallion Bridle%]",

		"%[Reins of the Swift Frostsaber%]",
		"%[Reins of the Swift Mistsaber%]",
		"%[Reins of the Swift Stormsaber%]",
		"%[Reins of the Black War Tiger%]",
		"%[Reins of the Frostsaber%]",
		"%[Reins of the Nightsaber%]",

		"%[Deathcharger's Reins%]",
		"%[Reins of the Winterspring Frostsaber%]",
		"%[Horn of the Frostwolf Howler%]",
		"%[Stormpike Battle Charger%]",
		"%[Swift Razzashi Raptor%]",
		"%[Swift Zulian Tiger%]",
		"%[Black Qiraji Resonating Crystal%]",

		["PALADIN"] = "Summon Charger",
		["WARLOCK"] = "Summon Dreadsteed",
	}

	GoGo_NubMounts = {
		"%[Horn of the Brown Wolf%]",
		"%[Horn of the Dire Wolf%]",
		"%[Horn of the Timber Wolf%]",

		"%[Brown Kodo%]",
		"%[Gray Kodo%]",

		"%[Whistle of the Emerald Raptor%]",
		"%[Whistle of the Turquoise Raptor%]",
		"%[Whistle of the Violet Raptor%]",

		"%[Red Skeletal Horse%]",
		"%[Blue Skeletal Horse%]",
		"%[Brown Skeletal Horse%]",

		"%[Brown Ram%]",
		"%[Gray Ram%]",
		"%[White Ram%]",

		"%[Blue Mechanostrider%]",
		"%[Green Mechanostrider%]",
		"%[Red Mechanostrider%]",
		"%[Unpainted Mechanostrider%]",

		"%[Chestnut Mare Bridle%]",
		"%[Black Stallion Bridle%]",
		"%[Brown Horse Bridle%]",
		"%[Pinto Bridle%]",

		"%[Reins of the Spotted Frostsaber%]",
		"%[Reins of the Striped Frostsaber%]",
		"%[Reins of the Striped Nightsaber%]",

		["PALADIN"] = "Summon Warhorse",
		["WARLOCK"] = "Summon Felsteed",
	}

	GoGo_WtfMounts = {
		["SHAMAN"] = "Ghost Wolf",
		["DRUID"] = "Travel Form",
	}

	GoGo_Bugs = {
		"%[Blue Qiraji Resonating Crystal%]",
		"%[Green Qiraji Resonating Crystal%]",
		"%[Red Qiraji Resonating Crystal%]",
		"%[Yellow Qiraji Resonating Crystal%]",
		"%[Black Qiraji Resonating Crystal%]",
	}
end --if
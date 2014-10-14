-- http://www.allegro-c.de/unicode/zcodes.htm
--
-- ä = \195\164
-- Ä = \195\132
-- ö = \195\182
-- Ö = \195\150
-- ü = \195\188
-- Ü = \195\156
-- ß = \195\159


if (GetLocale()=="deDE") then

	-- LVOnyxia
	LVBM_ONYXIA_INFO			= "Zeigt eine Warnung f\195\188r Phase 2 und 3 und Onyxia den Tiefen Atem macht.";
	LVBM_ONYXIA_BREATH_EMOTE	 	= "%s atmet tief ein...";
	LVBM_ONYXIA_BREATH_ANNOUNCE		= "*** Tiefer Atem - Deep Breath ***"
	LVBM_ONYXIA_PHASE2_YELL			= "Diese sinnlose Anstrengung langweilt mich. Ich werde Euch alle von oben verbrennen!";
	LVBM_ONYXIA_PHASE2_ANNOUNCE		= "*** Phase 2 ***"
	LVBM_ONYXIA_PHASE3_YELL			= "Mir scheint, dass Ihr noch eine Lektion braucht, sterbliche Wesen!";
	LVBM_ONYXIA_PHASE3_ANNOUNCE		= "*** Phase 3 ***"

	-- LVLordKazzak		(( NEED TRANSLATIONS ))
	LVBM_KAZZAK_INFO			= "Warnt vor dem Supreme Mode von Lord Kazzak und zeigt am Ende die Kampfzeit an.";
	LVBM_KAZZAK_START_YELL			= "For the Legion! For Kil'Jaeden!";
	LVBM_KAZZAK_NAME			= "Lord Kazzak";
	LVBM_KAZZAK_BAR_TEXT			= "Supreme Mode";
	LVBM_KAZZAK_DIES			= "Lord Kazzak stirbt.";
	LVBM_KAZZAK_ANNOUNCE_START		= "*** 3 min bis zum Supreme Modus ***";
	LVBM_KAZZAK_ANNOUNCE_TIMENEEDED 	= "*** Lord Kazzak wurde in %d Sekunden gekillt ***";
	LVBM_KAZZAK_ANNOUNCE_SEC		= "*** %d Sek bis zum Supreme Modus ***";

	-- LVAzuregos
	LVBM_AZUREGOS_INFO			= "Warnt bei Azuregos Teleport und Magie Reflexion F\195\164higkeiten.";
	LVBM_AZUREGOS_SHIELDUP_EXPR		= "bekommt 'Reflexion'";
	LVBM_AZUREGOS_SHIELDUP_ANNOUNCE		= "*** Magie Reflexion - keine Magie gegen ihn ***";
	LVBM_AZUREGOS_SHIELDDOWN_EXPR 		= "^Reflexion schwindet von Azuregos";
	LVBM_AZUREGOS_SHIELDDOWN_ANNOUNCE	= "*** Magie Reflexion ende ***";
	LVBM_AZUREGOS_PORT_EXPR 		= "wirkt Arkanes Vakuum";
	LVBM_AZUREGOS_PORT_ANNOUNCE		= "*** Teleport ***";

	-- BG Mod

		-- MIX
	--LVBM_BGMOD_LANG["INFO"]		= "";
	LVBM_BGMOD_LANG["THANKS"] 		= "Danke das du die La Vendetta Boss Mods verwendest. Viel Spass noch beim PvP.";
	LVBM_BGMOD_LANG["WINS"]			= "Die (%w+) siegt!"; 
	LVBM_BGMOD_LANG["BEGINS"]		= "Spiel startet in";
	LVBM_BGMOD_LANG["ALLIANCE"]		= "Allianz";
	LVBM_BGMOD_LANG["HORDE"]		= "Horde";
	LVBM_BGMOD_LANG["ALLI_TAKE_ANNOUNCE"] 	= "*** Die Allianz hat die %s erobert ***";
	LVBM_BGMOD_LANG["HORDE_TAKE_ANNOUNCE"]	= "*** Die Horde hat die %s erobert ***";


		-- AV
	LVBM_BGMOD_LANG["AV_ZONE"] 		= "Alteractal";
	LVBM_BGMOD_LANG["AV_START60SEC"]	= "Der Kampf um das Alteractal beginnt in 1 Minute.";
	LVBM_BGMOD_LANG["AV_START30SEC"]	= "Der Kampf um das Alteractal beginnt in 30 Sekunden.";
	LVBM_BGMOD_LANG["AV_TURNININFO"] 	= "Automatisches abgeben von Questgegenst\195\164nden";
	LVBM_BGMOD_LANG["AV_NPC"] 		= {
			["SMITHREGZAR"] 		= "Schmied Regzar",			-- armor
			["PRIMALISTTHURLOGA"] 		= "Primalist Thurloga",			-- icelord
			["WINGCOMMANDERJEZTOR"] 	= "Schwadronskommandant Jeztor",		
			["WINGCOMMANDERGUSE"] 		= "Schwadronskommandant Guse",
			["WINGCOMMANDERMULVERICK"] 	= "Schwadronskommandant Mulverick",
			["MURGOTDEEPFORGE"] 		= "Murgot Deepforge",			-- armor
			["ARCHDRUIDRENFERAL"]		= "Erzdruide Renferal",			-- forestlord
			["WINGCOMMANDERVIPORE"] 	= "Schwadronskommandant Vipore",
			["WINDCOMMANDERSLIDORE"] 	= "Schwadronskommandant Slidore",
			["WINGCOMMANDERICHMAN"] 	= "Schwadronskommandant Ichman",
			["STORMPIKERAMRIDERCOMMANDER"]	= "Kommandant der Stormpike - Widderreiter",	-- riders
			["FROSTWOLFWOLFRIDERCOMMANDER"]	= "Wolfsreiterkommandant der Frostwolf",
		};
	LVBM_BGMOD_LANG["AV_ITEM"] 		= {
			["ARMORSCRAPS"] 		= "R\195\188stungsfetzen",
			["SOLDIERSBLOOD"] 		= "Blut eines Stormpike-Soldaten",
			["LIEUTENANTSFLESH"] 		= "Fleisch eines Stormpike-Lieutenants",
			["SOLDIERSFLESH"] 		= "Fleisch eines Stormpike-Soldaten",
			["COMMANDERSFLESH"] 		= "Fleisch eines Stormpike-Kommandanten",
			["STORMCRYSTAL"] 		= "Sturmkristall",
			["LIEUTENANTSMEDAL"] 		= "Frostwolf Medaille des Lieutenants",
			["SOLDIERSMEDAL"] 		= "Frostwolf Medaille des Soldaten",
			["COMMANDERSMEDAL"] 		= "Frostwolf Medaille des Kommandanten",
			["FROSTWOLFHIDE"] 		= "Frostwolfbalg",
			["ALTERACRAMHIDE"]		= "Alteracwidderbalg",
		};
	LVBM_BGMOD_LANG["AV_TARGETS"] 		= {
			"Stormpike-Lazarett",
			"Nordbunker von Dun Baldar",
			"S\195\188dbunker von Dun Baldar",
			"Stormpike-Friedhof",
			"Icewing-Bunker",
			"Stonehearth-Friedhof",
			"Stonehearth-Bunker",
			"Snowfall-Friedhof",
			"Iceblood-Turm",
			"Iceblood-Friedhof",
			"Turmstellung",
			"Frostwolf-Friedhof",
			"westliche Frostwolfturm",
			"\195\182stliche Frostwolfturm",
			"H\195\188tte der Heiler"
		};
	LVBM_BGMOD_LANG["AV_UNDERATTACK"]	= "Der (.+) wird angegriffen! Wenn er unbewacht bleibt, wird die (%w+) ihn zerst\195\182ren!";
	LVBM_BGMOD_LANG["AV_WASTAKENBY"]	= "Die (%w+) hat (.+) eingenommen!";
	LVBM_BGMOD_LANG["AV_WASDESTROYED"]	= "Der (%w+) wurde von der (%w+) erobert!";	
	--LVBM_BGMOD_LANG["AV_IVUS"]		= "Wicked, Wicked, Mortals! The forest weeps";
	--LVBM_BGMOD_LANG["AV_ICEY"]		= "WHO DARES SUMMON LOKHOLAR";


		-- AB
	LVBM_BGMOD_LANG["AB_ZONE"] 		= "Arathibecken";
	LVBM_BGMOD_LANG["AB_START60SEC"]	= "Die Schlacht um das Arathibecken wird in 1 Minute beginnen.";
	LVBM_BGMOD_LANG["AB_START30SEC"]	= "Die Schlacht um das Arathibecken wird in 30 Sekunden beginnen.";
	LVBM_BGMOD_LANG["AB_CLAIMSTHE"]		= "besetzt";
	LVBM_BGMOD_LANG["AB_HASTAKENTHE"]	= "eingenommen";
	LVBM_BGMOD_LANG["AB_HASDEFENDEDTHE"]	= "verteidigt";
	LVBM_BGMOD_LANG["AB_HASASSAULTED"]	= "(%w+) hat (.+) angegriffen!";
	LVBM_BGMOD_LANG["AB_SCOREEXP"] 		= "Basen: (%d+)  Ressourcen: (%d+)/2000";		-- beware of the dual spaces
	LVBM_BGMOD_LANG["AB_WINALLY"] 		= "Allianz gewinnt in:";
	LVBM_BGMOD_LANG["AB_WINHORDE"] 		= "Horde gewinnt in:";
	LVBM_BGMOD_LANG["AB_TARGETS"] 		= {
			"Hof",
			"S\195\164gewerk",
			"Schmiede",
			"Mine",
			"St\195\164lle"
		};

		-- WSG
	LVBM_BGMOD_LANG["WSG_ZONE"] 		= "Warsongschlucht";
	LVBM_BGMOD_LANG["WSG_START60SEC"]	= "Der Kampf um die Warsongschlucht beginnt in 1 Minute.";
	LVBM_BGMOD_LANG["WSG_START30SEC"]	= "Der Kampf um die Warsongschlucht beginnt in 30 Sekunden. Haltet Euch bereit!";
	LVBM_BGMOD_LANG["WSG_INFOFRAME_INFO"]	= "Zeige Flaggen Info Fenster in der Warsong Schlucht";
	LVBM_BGMOD_LANG["WSG_FLAG_PICKUP"] 	= "(.*) hat die Flagge der (%w+) aufgenommen!";
	LVBM_BGMOD_LANG["WSG_FLAG_RETURN"]	= "Die Flagge der (%w+) wurde von (.+) zu ihrem St\195\188tzpunkt zur\195\188ckgebracht!";
	LVBM_BGMOD_LANG["WSG_ALLYFLAG"]		= "Allianz Flagge: ";
	LVBM_BGMOD_LANG["WSG_HORDEFLAG"]	= "Horde Flagge: ";
	LVBM_BGMOD_LANG["WSG_FLAG_BASE"]	= "Basis";
	LVBM_BGMOD_LANG["WSG_HASCAPTURED"]	= "(.+) hat die Flagge der (%w+) errungen!";



		-- BARS
	LVBM_SBT["Alliance: Stormpike Aid Station"] = "Allianz: Stormpike Lazarett";
	LVBM_SBT["Alliance: Dun Baldar North Bunker"] = "Allianz: Nordbunker von Dun Baldar";
	LVBM_SBT["Alliance: Dun Baldar South Bunker"] = "Allianz: S\195\188dbunker von Dun Baldar";
	LVBM_SBT["Alliance: Stormpike Graveyard"] = "Allianz: Stormpike Friedhof";
	LVBM_SBT["Alliance: Icewing Bunker"] = "Allianz: Icewing Bunker";
	LVBM_SBT["Alliance: Stonehearth Graveyard"] = "Allianz: Stonehearth Friedhof";
	LVBM_SBT["Alliance: Stonehearth Bunker"] = "Allianz: Stonehearth Bunker";
	LVBM_SBT["Alliance: Snowfall Graveyard"] = "Allianz: Snowfall Friedhof";
	LVBM_SBT["Alliance: Iceblood Tower"] = "Allianz: Iceblood Turm";
	LVBM_SBT["Alliance: Iceblood Graveyard"] = "Allianz: Iceblood Friedhof";
	LVBM_SBT["Alliance: Tower Point"] = "Allianz: Turmstellung";
	LVBM_SBT["Alliance: Frostwolf Graveyard"] = "Allianz: Frostwolf Friedhof";
	LVBM_SBT["Alliance: West Frostwolf Tower"] = "Allianz: Westlicher Frostwolfturm";
	LVBM_SBT["Alliance: East Frostwolf Tower"] = "Allianz: \195\150stlicher Frostwolfturm";
	LVBM_SBT["Alliance: Frostwolf Relief Hut"] = "Allianz: H\195\188tte der Heiler";
	LVBM_SBT["Alliance: Farm"] = "Allianz: Farm";
	LVBM_SBT["Alliance: Lumber mill"] = "Allianz: S\195\164gewerk";
	LVBM_SBT["Alliance: Blacksmith"] = "Allianz: Schmiede";
	LVBM_SBT["Alliance: Mine"] = "Allianz: Mine";
	LVBM_SBT["Alliance: Stables"] = "Allianz: St\195\164lle";

	LVBM_SBT["Horde: Stormpike Aid Station"] = "Horde: Stormpike Lazarett";
	LVBM_SBT["Horde: Dun Baldar North Bunker"] = "Horde: Nordbunker von Dun Baldar";
	LVBM_SBT["Horde: Dun Baldar South Bunker"] = "Horde: S\195\188dbunker von Dun Baldar";
	LVBM_SBT["Horde: Stormpike Graveyard"] = "Horde: Stormpike Friedhof";
	LVBM_SBT["Horde: Icewing Bunker"] = "Horde: Icewing Bunker";
	LVBM_SBT["Horde: Stonehearth Graveyard"] = "Horde: Stonehearth Friedhof";
	LVBM_SBT["Horde: Stonehearth Bunker"] = "Horde: Stonehearth Bunker";
	LVBM_SBT["Horde: Snowfall Graveyard"] = "Horde: Snowfall Friedhof";
	LVBM_SBT["Horde: Iceblood Tower"] = "Horde: Iceblood Turm";
	LVBM_SBT["Horde: Iceblood Graveyard"] = "Horde: Iceblood Friedhof";
	LVBM_SBT["Horde: Tower Point"] = "Horde: Turmstellung";
	LVBM_SBT["Horde: Frostwolf Graveyard"] = "Horde: Frostwolf Friedhof";
	LVBM_SBT["Horde: West Frostwolf Tower"] = "Horde: Westlicher Frostwolfturm";
	LVBM_SBT["Horde: East Frostwolf Tower"] = "Horde: \195\150stlicher Frostwolfturm";
	LVBM_SBT["Horde: Frostwolf Relief Hut"] = "Horde: H\195\188tte der Heiler";
	LVBM_SBT["Horde: Farm"] = "Horde: Farm";
	LVBM_SBT["Horde: Lumber mill"] = "Horde: S\195\164gewerk";
	LVBM_SBT["Horde: Blacksmith"] = "Horde: Schmiede";
	LVBM_SBT["Horde: Mine"] = "Horde: Mine";
	LVBM_SBT["Horde: Stables"] = "Horde: St\195\164lle";

	-- LVBM_SBT["Flag respawn"] = "Flaggen Respawn in";
	-- LVBM_SBT["Ivus spawn"] = "";
	-- LVBM_SBT["Ice spawn"] = "";
	LVBM_SBT["Begins"] = LVBM_BGMOD_LANG["BEGINS"];
	LVBM_SBT["AB_WINHORDE"] = LVBM_BGMOD_LANG.AB_WINHORDE;
	LVBM_SBT["AB_WINALLY"] = LVBM_BGMOD_LANG.AB_WINALLY;
end

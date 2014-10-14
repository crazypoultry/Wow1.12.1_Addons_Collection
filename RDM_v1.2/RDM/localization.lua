--[[-----------------------------------------------------------------------------------------------------------------------------
---------------------------------------- RDM : Fichier de localisation ----------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------]]


-- RDM => Francais
if( GetLocale() == "frFR" ) then
	RDMTitreAddon = "|cFF00FF00RDM Fr.|cFFFFFFFF";		-- Nom de l'addon
	RDMTitreAddonForTitre = "|cFFFFFFFFRDM Fr.";		-- Nom de l'addon
	RDMVersion = "1.2";									-- Version de l'addon
	
	RDM_VERSION = "Version";
	RDM_DETECTDOT = "Votre";
	RDM_LOADINGOK = "Charg\195\169";
	
	RDM_RAID = "Raid";
	RDM_PARTY = "Groupe";
	RDM_SOLO = "Solo";
	
	RDM_NEW_DPS_MAX = "Nouveau DPS Max";
	RDM_CALIBRAGE_ADDON = "Calibrage de "..RDMTitreAddon.." en cours...";
	
	RDM_FRAME_LOCK = "Fen\195\170tre verrouill\195\169e";
	RDM_FRAME_UNLOCK = "Fen\195\170tre d\195\169verrouill\195\169e";
	RDM_LOCKUNLOCK_SWITCH = "Verrouiller / D\195\169verrouiller";
	
	RDM_FRAME_MINI = "Fen\195\170tre minimis\195\169e";
	RDM_FRAME_MAXI = "Fen\195\170tre maximis\195\169e";
	RDM_MINIMAXI_SWITCH = "Maximiser / Minimiser";
	
	RDM_OPEN_OPTIONS = "Ouvrir Options";
	RDM_OPEN_CONSOLE = "Ouvrir Console";
	
	-- OPTIONS
	
	RDM_OPTIONS_TITLE = "Options";
	RDM_TEXT_SUBTITLE_1 = "Intervalle entre deux calculs du DPS";
	RDM_TEXT_SUBTITLE_2 = "Sources supplementaires de degats";
	RDM_TEXT_SUBTITLE_3 = "Reset des DPS Maximum";
	RDM_TEXT_SUBTITLE_4 = "Activation/Desactivation des sons";
	RDM_TICK_VALUE_TEXT = "Valeur du 'Tick' : ";

	RDM_TEXT_PETDAMAGEACTIVATION = "Activer les degats des pets.";
	RDM_TEXT_INFOTOTEMS = "Certains totems necessitent cette option !";
	RDM_TEXT_SOUND_ACTIVATION = "Activer le son (DPS Max).";
		
-- RDM => English
else
	RDMTitreAddon = "|cFF00FF00RDM En.|cFFFFFFFF";		-- Nom de l'addon
	RDMTitreAddonForTitre = "|cFFFFFFFFRDM En.";		-- Nom de l'addon
	RDMVersion = "1.2";									-- Version de l'addon
	
	RDM_VERSION = "Version";
	RDM_DETECTDOT = "Your";
	RDM_LOADINGOK = "Load";
	
	RDM_RAID = "Raid";
	RDM_PARTY = "Party";
	RDM_SOLO = "Solo";
	
	RDM_NEW_DPS_MAX = "New Max DPS";
	RDM_CALIBRAGE_ADDON = RDMTitreAddon.." is scaling...";
	
	RDM_FRAME_LOCK = "Frame locked";
	RDM_FRAME_UNLOCK = "Frame unlocked";
	RDM_LOCKUNLOCK_SWITCH = "Lock / Unlock";
	
	RDM_FRAME_MINI = "Minimized frame";
	RDM_FRAME_MAXI = "Maximized frame";
	RDM_MINIMAXI_SWITCH = "Maximize / Minimize";
	
	RDM_OPEN_OPTIONS = "Open Options";
	RDM_OPEN_CONSOLE = "Open Console";
	
	-- OPTIONS
	
	RDM_OPTIONS_TITLE = "Options";
	RDM_TEXT_SUBTITLE_1 = "Time between DPS count";
	RDM_TEXT_SUBTITLE_2 = "Additional sources of damage";
	RDM_TEXT_SUBTITLE_3 = "Reset Maximum DPS";
	RDM_TEXT_SUBTITLE_4 = "Sounds Activation / Desactivation";
	RDM_TICK_VALUE_TEXT = "'Tick' value : ";

	RDM_TEXT_PETDAMAGEACTIVATION = "Enable pets' damages.";
	RDM_TEXT_INFOTOTEMS = "Some totems require this option !";
	RDM_TEXT_SOUND_ACTIVATION = "Enable sound (DPS Max)";
end



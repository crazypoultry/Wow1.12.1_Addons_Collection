-- SCT localization information
-- French Locale
-- Initial translation by Juki <Unskilled>
-- Translation by Sasmira
-- Date 09/16/2005

if ( GetLocale() == "frFR" ) then
    
    -- Static Messages
    SCT_LowHP= "Vie Faible !";          	-- Message to be displayed when HP is low
    SCT_LowMana= "Mana Faible !";       	-- Message to be displayed when Mana is Low
    SCT_SelfFlag = "*";                 	-- Icon to show self hits
    SCT_Combat = "+ Combat";			-- Message to be displayed when entering combat
    SCT_NoCombat = "- Combat";			-- Message to be displayed when leaving combat
    SCT_ComboPoint = "Points de Combo ";    	-- Message to be displayed when gaining a combo point
    SCT_FiveCPMessage = " ... A Mooort !!!";    -- Message to be displayed when you have 5 combo points
    SCT_ExecuteMessage = "Execute Now!"; -- Message to be displayed when time to execute
		SCT_WrathMessage = "Hammer of Wrath Now!"; -- Message to be displayed when time Wrath
    
    --startup messages
    SCT_STARTUP = "Scrolling Combat Text "..SCT_Version.." charg\195\169. Tapez /sctmenu pour les options.";
    SCT_Option_Crit_Tip = "Make this event always appear as a CRITICAL.";
    SCT_Option_Msg_Tip = "Make this event always appear as a MESSAGE. Overrides Criticals.";
    
    --nouns
    SCT_TARGET = "La cible";
    SCT_PROFILE = "SCT Profil charg\195\169 : |cff00ff00";
    SCT_PROFILE_DELETE = "SCT Profile Deleted: |cff00ff00";
    SCT_PROFILE_NEW = "SCT New Profile Created: |cff00ff00";
    SCT_WARRIOR = "Guerrier";
		SCT_ROGUE = "Voleur";
		SCT_HUNTER = "Chasseur";
		SCT_MAGE = "Mage";
		SCT_WARLOCK = "D\195\169moniste";
		SCT_SHAMAN = "Chaman";
		SCT_PALADIN = "Paladin";
		SCT_DRUID = "Druide";
		SCT_PRIEST = "Pr\195\170tre";
    
    --Useage
    SCT_DISPLAY_USEAGE = "Utilisation : \n";
    SCT_DISPLAY_USEAGE = SCT_DISPLAY_USEAGE .. "/sctdisplay 'message' (pour du texte blanc)\n";
    SCT_DISPLAY_USEAGE = SCT_DISPLAY_USEAGE .. "/sctdisplay 'message' rouge(0-10) vert(0-10) bleu(0-10)\n";
    SCT_DISPLAY_USEAGE = SCT_DISPLAY_USEAGE .. "Exemple : /sctdisplay 'Soignez Moi' 10 0 0\nCela affichera 'Soignez Moi' en rouge vif\n";
    SCT_DISPLAY_USEAGE = SCT_DISPLAY_USEAGE .. "Quelques Couleurs : rouge = 10 0 0, vert = 0 10 0, bleu = 0 0 10,\njaune = 10 10 0, violet = 10 0 10, cyan = 0 10 10";
        
    --Event and Damage option values
		SCT_OPTION_EVENT1 = {name = "Montrer D\195\169g\195\162ts", tooltipText = "Activer/D\195\169sactiver les d\195\169g\195\162ts de m\195\169l\195\169e et divers (feu, chute, etc...)."};
		SCT_OPTION_EVENT2 = {name = "Montrer Rat\195\169s", tooltipText = "Activer/D\195\169sactiver les coups rat\195\169s"};
		SCT_OPTION_EVENT3 = {name = "Montrer D\195\169vi\195\169s", tooltipText = "Activer/D\195\169sactiver les coups d\195\169vi\195\169s"};
		SCT_OPTION_EVENT4 = {name = "Montrer Parades", tooltipText = "Activer/D\195\169sactiver les coups par\195\169s"};
		SCT_OPTION_EVENT5 = {name = "Montrer Bloqu\195\169s", tooltipText = "Activer/D\195\169sactiver les coups bloqu\195\169s"};
		SCT_OPTION_EVENT6 = {name = "Montrer D\195\169g\195\162ts Sorts", tooltipText = "Activer/D\195\169sactiver les d\195\169g\195\162ts de sorts"};
		SCT_OPTION_EVENT7 = {name = "Montrer Sorts Soins", tooltipText = "Activer/D\195\169sactiver les sorts de soins"};
		SCT_OPTION_EVENT8 = {name = "Montrer Sorts Resist\195\169s", tooltipText = "Activer/D\195\169sactiver les sorts r\195\169sist\195\169s"};
		SCT_OPTION_EVENT9 = {name = "Montrer Debuffs", tooltipText = "Activer/D\195\169sactiver l\'affichage lorsque vous \195\170tes debuffs"};
		SCT_OPTION_EVENT10 = {name = "Montrer Absorb\195\169s", tooltipText = "Activer/D\195\169sactiver les d\195\169g\195\162ts absorb\195\169s"};
		SCT_OPTION_EVENT11 = {name = "Montrer Vie Faible", tooltipText = "Activer/D\195\169sactiver l\'affichage lorsque votre vie est faible"};
		SCT_OPTION_EVENT12 = {name = "Montrer Mana Faible", tooltipText = "Activer/D\195\169sactiver l\'affichage lorsque votre mana est faible"};
		SCT_OPTION_EVENT13 = {name = "Montrer Gains d\'Energie", tooltipText = "Activer/D\195\169sactiver l\'affichage des gains de Mana, Rage, Energie\ndes potions, obejts, buffs, etc...(pas des r\195\169g\195\169ration naturelle)"};
		SCT_OPTION_EVENT14 = {name = "Montrer Mode Combat", tooltipText = "Activer/D\195\169sactiver l\'affichage lorsque vous rentrez ou sortez d\'un combat"};
		SCT_OPTION_EVENT15 = {name = "Montrer Points de Combo", tooltipText = "Activer/D\195\169sactiver l\'affichage lorsque vous gagnez des points de combo"};
		SCT_OPTION_EVENT16 = {name = "Montrer les Points d\'Honneur", tooltipText = "Activer/D\195\169sactiver l\'affichage lorsque vous gagnez des points d\'Honneur"};
		SCT_OPTION_EVENT17 = {name = "Montrer Buffs", tooltipText = "Activer/D\195\169sactiver l\'affichage lorsque vous \195\170tes buffs"};
    SCT_OPTION_EVENT18 = {name = "Dissipation des Buffs", tooltipText = "Activer/D\195\169sactiver l\'affichage lorsque les buffs se dissipent"};
    SCT_OPTION_EVENT19 = {name = "Show Execute/Wrath", tooltipText = "Enables or Disables alerting when to Execute or Hammer of Wrath (Warrior/Paladin Only)"};
		SCT_OPTION_EVENT20 = {name = "Show Reputation", tooltipText = "Enables or Disables showing when you gain or lose Reputation"};
		SCT_OPTION_EVENT21 = {name = "Your Heals", tooltipText = "Enables or Disables showing how much you heal others for"};
		SCT_OPTION_EVENT22 = {name = "Skills", tooltipText = "Enables or Disables showing when you gain Skill points"};
		
		--Check Button option values
		SCT_OPTION_CHECK1 = { name = "Scrolling Combat Text", tooltipText = "Activer/D\195\169sactiver Scrolling Combat Text"};
		SCT_OPTION_CHECK2 = { name = "Mode Combat", tooltipText = "Activer/D\195\169sactiver l\'affichage de * autour de tous les Scrolling Combat Text"};
		SCT_OPTION_CHECK3 = { name = "Show Healers", tooltipText = "Enables or Disables showing who or what heals you."};
		SCT_OPTION_CHECK4 = { name = "Affichage vers le Bas", tooltipText = "Activer/D\195\169sactiver le d\195\169roulement du texte vers le bas"};
		SCT_OPTION_CHECK5 = { name = "Critiques", tooltipText = "Activer/D\195\169sactiver les coups/soins critiques au dessus de votre t\195\170te"};
    SCT_OPTION_CHECK6 = { name = "Type de Sorts", tooltipText = "Activer/D\195\169sactiver l\'affichage du type de dommage caus\195\169 par les Sorts"};
    SCT_OPTION_CHECK7 = { name = "Apply Font to Damage", tooltipText = "Enables or Disables changing the in game damage font to match the font used for SCT Text.\n\nIMPORTANT: YOU MUST LOG OUT AND BACK IN FOR THIS TO TAKE EFFECT. RELOADING THE UI WON'T WORK"};
		
		--Slider options values
		SCT_OPTION_SLIDER1 = { name="Vitesse du Texte", minText="Rapide", maxText="Lent", tooltipText = "Contr\195\180le la vitesse d\'animation du texte d\195\169roulant"};
		SCT_OPTION_SLIDER2 = { name="Taille Texte", minText="Petit", maxText="Grand", tooltipText = "Contr\195\180le la taille du texte d\195\169roulant"};
		SCT_OPTION_SLIDER3 = { name="HP %", minText="10%", maxText="90%", tooltipText = "Contr\195\180le le % de vie n\195\169cessaire pour donner un avertissement"};
		SCT_OPTION_SLIDER4 = { name="Mana %",  minText="10%", maxText="90%", tooltipText = "Contr\195\180le le % de mana n\195\169cessaire pour donner un avertissement"};
		SCT_OPTION_SLIDER5 = { name="Transparence", minText="0%", maxText="100%", tooltipText = "Contr\195\180le la transparence du texte"};
		SCT_OPTION_SLIDER6 = { name="Text Movement Distance", minText="Petit", maxText="Grand", tooltipText = "Controls the movement distance of the text between each update"};
		SCT_OPTION_SLIDER7 = { name="Text Center X Position", minText="-300", maxText="300", tooltipText = "Controls the placement of the text center"};
		SCT_OPTION_SLIDER8 = { name="Text Center Y Position", minText="-300", maxText="300", tooltipText = "Controls the placement of the text center"};
		SCT_OPTION_SLIDER9 = { name="Message Center X Position", minText="-600", maxText="600", tooltipText = "Controls the placement of the message center"};
		SCT_OPTION_SLIDER10 = { name="Message Center Y Position", minText="-600", maxText="600", tooltipText = "Controls the placement of the message center"};
		SCT_OPTION_SLIDER11 = { name="Message Fade Speed", minText="Rapide", maxText="Lent", tooltipText = "Controls the speed that messages fade"};
		SCT_OPTION_SLIDER12 = { name="Message Size", minText="Petit", maxText="Grand", tooltipText = "Controls the size of the message text"};
		
		--Misc option values
		SCT_OPTION_MISC1 = {name="SCT Options "..SCT_Version};
		SCT_OPTION_MISC2 = {name="Event Options"};
		SCT_OPTION_MISC3 = {name="Text Options"};
		SCT_OPTION_MISC4 = {name="Misc. Options"};
		SCT_OPTION_MISC5 = {name="Warning Options"};
		SCT_OPTION_MISC6 = {name="Animation Options"};
		SCT_OPTION_MISC7 = {name="Select Profile"};
		SCT_OPTION_MISC8 = {name="Save & Close", tooltipText = "Saves all current settings and close the options"};
		SCT_OPTION_MISC9 = {name="Reset", tooltipText = "-Warning-\n\nAre you sure you want to reset SCT to defaults?"};
		SCT_OPTION_MISC10 = {name="Select", tooltipText = "Select another characters profile"};
		SCT_OPTION_MISC11 = {name="Load", tooltipText = "Load another characters profile for this character"};
		SCT_OPTION_MISC12 = {name="Delete", tooltipText = "Delete a characters profile"}; 
		SCT_OPTION_MISC13 = {name="Cancel", tooltipText = "Cancel Selection"};
		SCT_OPTION_MISC14 = {name="Text", tooltipText = ""};
		SCT_OPTION_MISC15 = {name="Messages", tooltipText = ""};
		SCT_OPTION_MISC16 = {name="Message Options"};
		
		--Fonts
		SCT_FONTS = { 
			[1] = { name="Default", path="Fonts\\FRIZQT__.TTF"},
			[2] = { name="TwCenMT", path="Interface\\Addons\\sct\\fonts\\Tw_Cen_MT_Bold.TTF"},
			[3] = { name="Adventure", path="Interface\\Addons\\sct\\fonts\\Adventure.ttf"},
			[4] = { name="Enigma", path="Interface\\Addons\\sct\\fonts\\Enigma__2.TTF"},
		}
		
		--Animation Types
		SCT_OPTION_SELECTION1 = { name="Animation Type", tooltipText = "Which animation type to use", table = {[1] = "Verticle (Normal)",[2] = "Rainbow",[3] = "Horizontal",[4] = "Angled Down"}};
		SCT_OPTION_SELECTION2 = { name="Side Style", tooltipText = "How side scrolling text should display", table = {[1] = "Alternating",[2] = "Damage Left",[3] = "Damage Right"}};
		SCT_OPTION_SELECTION3 = { name="Font", tooltipText = "What font to use", table = {[1] = SCT_FONTS[1].name,[2] = SCT_FONTS[2].name,[3] = SCT_FONTS[3].name,[4] = SCT_FONTS[4].name}};
		SCT_OPTION_SELECTION4 = { name="Font Outline", tooltipText = "What font outline to use", table = {[1] = "None",[2] = "Thin",[3] = "Thick"}};
		SCT_OPTION_SELECTION5 = { name="Message Font", tooltipText = "What font to use for messages", table = {[1] = SCT_FONTS[1].name,[2] = SCT_FONTS[2].name,[3] = SCT_FONTS[3].name,[4] = SCT_FONTS[4].name}};
		SCT_OPTION_SELECTION6 = { name="Message Font Outline", tooltipText = "What font outline to use for messages", table = {[1] = "None",[2] = "Thin",[3] = "Thick"}};

		-- Cosmos button
		SCT_CB_NAME		= "Scrolling Combat Text".." "..SCT_Version;
		SCT_CB_SHORT_DESC	= "Par Grayhoof";
		SCT_CB_LONG_DESC	= "Affiche les messages de combat au dessus du personnage";
		SCT_CB_ICON		= "Interface\\Icons\\Spell_Shadow_EvilEye"; -- "Interface\\Icons\\Spell_Shadow_FarSight"
	
end


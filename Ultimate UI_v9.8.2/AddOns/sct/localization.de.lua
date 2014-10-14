-- Version : German (by Endymion, StarDust, Sasmira)
-- Last Update : 09/16/2005

if ( GetLocale() == "deDE" ) then

	-- Static Messages
	SCT_LowHP = "Wenig Gesundheit!"; -- Message to be displayed when HP is low
	SCT_LowMana = "Wenig Mana!"; -- Message to be displayed when Mana is Low
	SCT_SelfFlag = "*"; -- Icon to show self hits
	SCT_Combat = "+Kampf"; -- Message to be displayed when entering combat
	SCT_NoCombat = "-Kampf"; -- Message to be displayed when leaving combat
	SCT_ComboPoint = "CP"; -- Message to be displayed when you become a combo point
	SCT_FiveCPMessage = "Alle Combo-Punkte!"; -- Message to be displayed when you have 5 combo points
	SCT_ExecuteMessage = "Execute Now!"; -- Message to be displayed when time to execute
	SCT_WrathMessage = "Hammer of Wrath Now!"; -- Message to be displayed when time Wrath
	
	--startup messages
	SCT_STARTUP = "Scrolling Combat Text "..SCT_Version.." AddOn geladen. Gib /sctmenu f\195\188r Optionen ein.";
	SCT_Option_Crit_Tip = "Make this event always appear as a CRITICAL.";
	SCT_Option_Msg_Tip = "Make this event always appear as a MESSAGE. Overrides Criticals.";
	
	--nouns
	SCT_TARGET = "Ziel ";
	SCT_PROFILE = "SCT Profil geladen: |cff00ff00";
	SCT_PROFILE_DELETE = "SCT Profile Deleted: |cff00ff00";
	SCT_PROFILE_NEW = "SCT New Profile Created: |cff00ff00";
	SCT_WARRIOR = "Krieger";
	SCT_ROGUE = "Schurke";
	SCT_HUNTER = "J\195\164ger";
	SCT_MAGE = "Magier";
	SCT_WARLOCK = "Hexenmeister";
	SCT_DRUID = "Druide";
	SCT_PRIEST = "Priester";
	SCT_SHAMAN = "Schamane";
	SCT_PALADIN = "Paladin";
	
	--Usage
	SCT_DISPLAY_USEAGE = "Benutzung: \n";
	SCT_DISPLAY_USEAGE = SCT_DISPLAY_USEAGE .. "/sctdisplay 'Nachricht' (f\195\188r wei\195\159en Text)\n";
	SCT_DISPLAY_USEAGE = SCT_DISPLAY_USEAGE .. "/sctdisplay 'Nachricht' red(0-10) green(0-10) blue(0-10)\n";
	SCT_DISPLAY_USEAGE = SCT_DISPLAY_USEAGE .. "Beispiel: /sctdisplay 'Heile Mich' 10 0 0\nDies stellt 'Heile Mich' in hellrot dar.\n";
	SCT_DISPLAY_USEAGE = SCT_DISPLAY_USEAGE .. "Einige Farben: Rot = 10 0 0, Gr\195\188n = 0 10 0, Blau = 0 0 10,\nGelb = 10 10 0, Magenta = 10 0 10, Zyan = 0 10 10";
		
	--Event and Damage option values
	SCT_OPTION_EVENT1 = {name = "Schaden anzeigen", tooltipText = "Aktiviert die Anzeige von Nahkampf- und\nsonstigem (Feuer, Fallen, etc...) Schaden."};
	SCT_OPTION_EVENT2 = {name = "Fehlschlag anzeigen", tooltipText = "Aktiviert die Anzeige wenn verfehlt."};
	SCT_OPTION_EVENT3 = {name = "Ausweichen anzeigen", tooltipText = "Aktiviert die Anzeige wenn ausgewichen."};
	SCT_OPTION_EVENT4 = {name = "Parieren anzeigen", tooltipText = "Aktiviert die Anzeige wenn pariert."};
	SCT_OPTION_EVENT5 = {name = "Blocken anzeigen", tooltipText = "Aktiviert die Anzeige wenn geblockt."};
	SCT_OPTION_EVENT6 = {name = "Zauberschaden anzeigen", tooltipText = "Aktiviert die Anzeige von Zauberschaden."};
	SCT_OPTION_EVENT7 = {name = "Heilspr\195\188che anzeigen", tooltipText = "Aktiviert die Anzeige von Heilsprucheffekten."};
	SCT_OPTION_EVENT8 = {name = "Widerstehen anzeigen", tooltipText = "Aktiviert die Anzeige wenn widerstanden."};
	SCT_OPTION_EVENT9 = {name = "Debuffs anzeigen", tooltipText = "Aktiviert die Anzeige von Debuffs."};
	SCT_OPTION_EVENT10 = {name = "Absorbieren anzeigen", tooltipText = "Aktiviert die Anzeige wenn Schaden absorbiert."};
	SCT_OPTION_EVENT11 = {name = "Wenig Gesundheit", tooltipText = "Aktiviert die Anzeige wenn wenig Gesundheit."};
	SCT_OPTION_EVENT12 = {name = "Wenig Mana", tooltipText = "Aktiviert die Anzeige wenn wenig Mana."};
	SCT_OPTION_EVENT13 = {name = "Kampfboni anzeigen", tooltipText = "Aktiviert die Anzeige wenn du Gesundheit\ndurch Tr\195\164nke, Gegenst\195\164nde, Buffs, etc...\n(keine nat\195\188rliche Regeneration) erh\195\164ltst."};
	SCT_OPTION_EVENT14 = {name = "Kampfein-/austritt anzeigen", tooltipText = "Aktiviert die Anzeige wenn du einem\nKampf beitrittst oder diesen verl\195\164sst."};
	SCT_OPTION_EVENT15 = {name = "Combopunkte anzeigen", tooltipText = "Aktiviert die Anzeige von Combopunkten."};
	SCT_OPTION_EVENT16 = {name = "Ehrenpunkte anzeigen", tooltipText = "Aktiviert die Anzeige von Ehrenpunkten."};
	SCT_OPTION_EVENT17 = {name = "Buffs anzeigen", tooltipText = "Aktiviert die Anzeige von Buffs."};
	SCT_OPTION_EVENT18 = {name = "Buff-Fades anzeigen", tooltipText = "Aktiviert die Anzeige von Buff-Fades."};
	SCT_OPTION_EVENT19 = {name = "Show Execute/Wrath", tooltipText = "Enables or Disables alerting when to Execute or Hammer of Wrath (Warrior/Paladin Only)"};
	SCT_OPTION_EVENT20 = {name = "Show Reputation", tooltipText = "Enables or Disables showing when you gain or lose Reputation"};
	SCT_OPTION_EVENT21 = {name = "Your Heals", tooltipText = "Enables or Disables showing how much you heal others for"};
	SCT_OPTION_EVENT22 = {name = "Skills", tooltipText = "Enables or Disables showing when you gain Skill points"};
	
	--Check Button option values
	SCT_OPTION_CHECK1 = { name = "Scrollender Kampftext", tooltipText = "Aktiviert den scrollenden Kampftext."};
	SCT_OPTION_CHECK2 = { name = "Kampftext markieren", tooltipText = "Legt fest ob scrollende Kampftexte in * gesetzt werden sollen."};
	SCT_OPTION_CHECK3 = { name = "Show Healers", tooltipText = "Enables or Disables showing who or what heals you."};
	SCT_OPTION_CHECK4 = { name = "Text nach unten scrollen", tooltipText = "Legt fest ob der Text nach unten scrollen soll oder nicht."};
	SCT_OPTION_CHECK5 = { name = "Crits anzeigen", tooltipText = "Legt fest ob kritische Treffer/Heilung angezeigt werden sollen."};
	SCT_OPTION_CHECK6 = { name = "Zauberschadenstyp anzeigen", tooltipText = "Aktiviert die Zauberschadenstyp-Anzeige."};
	SCT_OPTION_CHECK7 = { name = "Apply Font to Damage", tooltipText = "Enables or Disables changing the in game damage font to match the font used for SCT Text.\n\nIMPORTANT: YOU MUST LOG OUT AND BACK IN FOR THIS TO TAKE EFFECT. RELOADING THE UI WON'T WORK"};
	
	--Slider options values
	SCT_OPTION_SLIDER1 = { name="Scrollgeschwindigkeit", minText="Schneller", maxText="Langsamer", tooltipText = "Legt die Animationsgeschwindigkeit des dargestellten Textes fest."};
	SCT_OPTION_SLIDER2 = { name="Textgr\195\182\195\159e", minText="Kleiner", maxText="Gr\195\182\195\159er", tooltipText = "Legt die Gr\195\182\195\159e des dargestellten Textes fest."};
	SCT_OPTION_SLIDER3 = { name="HP %", minText="10%", maxText="90%", tooltipText = "Legt fest ab wieviel Prozent Gesundheit\neine Warnung angezeigt werden soll."};
	SCT_OPTION_SLIDER4 = { name="Mana %", minText="10%", maxText="90%", tooltipText = "Legt fest ab wieviel Prozent Mana\neine Warnung angezeigt werden soll."};
	SCT_OPTION_SLIDER5 = { name="Texttransparenz", minText="0%", maxText="100%", tooltipText = "Legt die Transparenz des Textes fest."};
	SCT_OPTION_SLIDER6 = { name="Abstand zwischen scrollendem Kampftext", minText="Kleiner", maxText="Gr\195\182\195\159er", tooltipText = "Legt den Abstand zwischen dem scrollenden Kampftext fest."}; 
	SCT_OPTION_SLIDER7 = { name="Text Center X Position", minText="-300", maxText="300", tooltipText = "Controls the placement of the text center"};
	SCT_OPTION_SLIDER8 = { name="Text Center Y Position", minText="-300", maxText="300", tooltipText = "Controls the placement of the text center"};
	SCT_OPTION_SLIDER9 = { name="Message Center X Position", minText="-600", maxText="600", tooltipText = "Controls the placement of the message center"};
	SCT_OPTION_SLIDER10 = { name="Message Center Y Position", minText="-600", maxText="600", tooltipText = "Controls the placement of the message center"};
	SCT_OPTION_SLIDER11 = { name="Message Fade Speed", minText="Schneller", maxText="Langsamer", tooltipText = "Controls the speed that messages fade"};
	SCT_OPTION_SLIDER12 = { name="Message Size", minText="Smaller", maxText="Larger", tooltipText = "Controls the size of the message text"};

	
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
	SCT_CB_NAME = "Scrollender Kampftext".." "..SCT_Version;
	SCT_CB_SHORT_DESC = "von Grayhoof";
	SCT_CB_LONG_DESC = "Zeigt Kampfnachrichten \195\188ber dem Charakter an - probier es aus!";
	SCT_CB_ICON = "Interface\\Icons\\Spell_Shadow_EvilEye";

end 


if ( GetLocale() == "deDE" ) then
	-- German Text (ä = \195\164, ö = \195\182 ,ü = \195\188, ß = \195\159). 
	-- Thanks to Shamane for the translation.
	RH_RANGESPELL = { "autom. schuss", "arkaner schuss", "ersch\195\188tternder schuss", "schlangenbiss", "gezielter schuss" };
	RH_MELEESPELL = { "zurechtstutzen", "r\195\188ckzug" };
	
	RHOPTION_TEXT1 = "Nahkampf Angriff";
	RHOPTION_TEXT2 = "Fernkampf Angriff";
	RHOPTION_TEXT3 = "Nahkampf Bar No.";
	RHOPTION_TEXT4 = "Fernkampf Bar No.";
	RHOPTION_TEXT5 = "Sperre ActionBar im Kampf";
	RHOPTION_TEXT6 = "Blende Fernk.-Info-Frame aus";
	RHOPTION_TEXT7 = "Aktiviere Addon: RangeHelp";
	RHOPTION_TEXT8 = "Setze bei AB-Wechsel: N+DZ -- F";
	RHOPTION_TEXT9 = "Aktiv. ActionBar Wechsel: N -- F";
	
	RHOPTION_XML_APPLY = "OK";
	RHOPTION_XML_CONFIRM = "Best\195\164tigen";
	RHOPTION_XML_CANCEL = "Verwerfen";
	RHOPTION_XML_CUSTOMISEUI = "UI anpassen";
	RHOPTION_XML_SPELLKEYBIND = "Spell Key Bind";
	RHOPTION_XML_ENABLECUSTSPELL = "Manuelle Eingabe der Angriffe.";
	RHOPTION_XML_DISABLECUSTSPELL = "Autom. Erkennung der Angriffe";
	
	RHOPTION_SPELLDISP_OK = "OK";
	RHOPTION_SPELLDISP_NOTFOUND = "Nicht gefunden";
	RHOPTION_LEVEL_NOT_MET = "This mod can only be used properly when your character is equipped with LEVEL 12 or above spells";
	
	RHOPTION_APPLY_ERR1 = "Bitte f\195\188llen Sie s\195\164mtliche Felder aus.";
	RHOPTION_APPLY_ERR2 = "Diesen Bar gibt es nicht. G\195\188ltige Barnummern liegen zwischen 1-"..NUM_ACTIONBAR_PAGES;
	
	RHUISETUP_TEXT1 = "Gr\195\182\195\159e ver\195\164ndern";
	RHUISETUP_TEXT2 = "Position ver\195\164ndern";
	RHUISETUP_TEXT3 = "Schriftgr\195\182\195\159e";
	RHUISETUP_TEXT4 = "Hintergrundfarbe festsetzen";
	RHUISETUP_TEXT5 = "Rahmenfarbe festsetzen";
	RHUISETUP_TEXT6 = "Schriftfarbe festsetzen";
	RHUISETUP_TEXT7 = "Hintergrund gleich Rahmenfarbe";
	RHUISETUP_TEXT8 = "Text";
	
	RHUISETUP_MELEE = "Nahkampf";
	RHUISETUP_DEADZONE = "Dead Zone";
	RHUISETUP_RANGE = "Fernkampf";
	RHUISETUP_OUTOFRANGE = "Au\195\159er Reichweite";
	RHUISETUP_ALLSTATE = "Alle Zonen";
	RHUISETUP_NOTARG = "No Target";
	
	RHUISETUP_XML_RANGESTATE = "Zone";
	RHUISETUP_XML_BACKCOLOUR = "Hintergrundfarbe";
	RHUISETUP_XML_BORDERCOLOUR = "Rahmenfarbe";
	RHUISETUP_XML_FONTCOLOUR = "Schriftfarbe";
	RHUISETUP_XML_DEFAULT = "Standard";
	RHUISETUP_XML_RESETFRAMELOC = "Range Info Lost & Found";
	
	RHKEYSPELL_SELTEXT = "Select the key bind to setup";
	RHKEYSPELL_DROPINSTR = "Select a bound key to setup. You'll have to bind a key to RangeHelp before you are able to setup it up here. You can bind a key under the WoW options menu.";
	RHKEYSPELL_DRAGINSTR = "Drag a spell from your spell book or a macro from your macro list into here. NOTE: MAKE sure that you 'drag AND drop' and NOT 'drag AND click'";
	RHKEYSPELL_CHECKINSTR = "Check this to enable buff check when casting spell";
	BINDING_HEADER_RANGEHELPBIND = "RangeHelp Spell Keys";
	BINDING_NAME_RHSPELLKEY1 = "RangeHelp Key 1";
	BINDING_NAME_RHSPELLKEY2 = "RangeHelp Key 2";
	BINDING_NAME_RHSPELLKEY3 = "RangeHelp Key 3";
	BINDING_NAME_RHSPELLKEY4 = "RangeHelp Key 4";
	-- End German Text
	
elseif ( GetLocale() == "frFR" ) then
	-- French Text. Thanks to Mips and Corwin Whitehorn for the translation.
	RH_RANGESPELL = { "tir automatique", "tir des arcanes", "trait de choc", "morsure de serpent", "vis\195\169e" };
	RH_MELEESPELL = { "coupure d'ailes", "d\195\169sengagement" };
	
	RHOPTION_TEXT1 = "Sort de M\195\169l\195\169e";
	RHOPTION_TEXT2 = "Sort \195\160 distance";
	RHOPTION_TEXT3 = "Barre de M\195\169l\195\169e";
	RHOPTION_TEXT4 = "Barre \195\160 Distance";
	RHOPTION_TEXT5 = "Bloquer la barre d'action en combat";
	RHOPTION_TEXT6 = "Cacher l'info de port\195\169e";
	RHOPTION_TEXT7 = "Activer RangeHelp";
	RHOPTION_TEXT8 = "Changer de barre d\195\168s la zone morte";
	RHOPTION_TEXT9 = "Activer le changement de barre";
	
	RHOPTION_XML_APPLY = "Appliquer";
	RHOPTION_XML_CONFIRM = "Confirmer";
	RHOPTION_XML_CANCEL = "Annuler";
	RHOPTION_XML_CUSTOMISEUI = "Modifier la zone d'info de port\195\169e";
	RHOPTION_XML_SPELLKEYBIND = "Touche de raccourci de sort";
	RHOPTION_XML_ENABLECUSTSPELL = "D\195\169tection de sort personnalis\195\169";
	RHOPTION_XML_DISABLECUSTSPELL = "D\195\169tection de sort automatique";
	
	RHOPTION_SPELLDISP_OK = "OK";
	RHOPTION_SPELLDISP_NOTFOUND = "Non trouv\195\169";
	RHOPTION_LEVEL_NOT_MET = "Ce mod ne fonctionnera correctement que si vous disposez des sorts de niveau 12 ou sup\195\169rieurs";
	
	RHOPTION_APPLY_ERR1 = "Veuillez compl\195\169ter tous les champs.";
	RHOPTION_APPLY_ERR2 = "Num\195\169ro de page invalide. Veuillez entrer une valeur entre 1-"..NUM_ACTIONBAR_PAGES;
	
	RHUISETUP_TEXT1 = "Redimensionnable";
	RHUISETUP_TEXT2 = "D\195\169pla\195\167able";
	RHUISETUP_TEXT3 = "Taille de la police";
	RHUISETUP_TEXT4 = "Verouiller la couleur de fond";
	RHUISETUP_TEXT5 = "Verouiller la couleur du contour";
	RHUISETUP_TEXT6 = "Verouiller la couleur de la police";
	RHUISETUP_TEXT7 = "Lier la couleur de fond et du contour";
	RHUISETUP_TEXT8 = "Texte";
	
	RHUISETUP_MELEE = "M\195\169l\195\169e";
	RHUISETUP_DEADZONE = "Zone morte";
	RHUISETUP_RANGE = "A port\195\169e";
	RHUISETUP_OUTOFRANGE = "Hors port\195\169e";
	RHUISETUP_ALLSTATE = "Tous \195\169tats";
	RHUISETUP_NOTARG = "Pas de cible";
	
	RHUISETUP_XML_RANGESTATE = "Etat de la port\195\169e";
	RHUISETUP_XML_BACKCOLOUR = "Couleur de fond";
	RHUISETUP_XML_BORDERCOLOUR = "Couleur du contour";
	RHUISETUP_XML_FONTCOLOUR = "Couleur de la police";
	RHUISETUP_XML_DEFAULT = "D\195\169faut";
	RHUISETUP_XML_RESETFRAMELOC = "Emplacement par d\195\169faut";
	
	RHKEYSPELL_SELTEXT = "S\195\169lectionner la touche \195\160 configurer";
	RHKEYSPELL_DROPINSTR = "S\195\169lectionner la touche de raccourci \195\160 configurer. Vous devez configurer les touches de raccourcis de RangeHelp avant de pouvoir les configurer ici. Vous pouvez configurer les raccourcis dans le menu option de WoW.";
	RHKEYSPELL_DRAGINSTR = "Glisser un sort de votre livre ou une macro de votre liste de macro ici. NOTE: Faites un 'Glisser d\195\169placer' en gardant le bouton de la souris enfonc\195\169.";
	RHKEYSPELL_CHECKINSTR = "Cocher pour v\195\169rifier la pr\195\169sence du sort avant qu'il ne soit lanc\195\169";

	BINDING_HEADER_RANGEHELPBIND = "RangeHelp Touches de sort";
	BINDING_NAME_RHSPELLKEY1 = "RangeHelp Touche 1";
	BINDING_NAME_RHSPELLKEY2 = "RangeHelp Touche 2";
	BINDING_NAME_RHSPELLKEY3 = "RangeHelp Touche 3";
	BINDING_NAME_RHSPELLKEY4 = "RangeHelp Touche 4";
	--End French Text
	
else -- English by default
	RH_RANGESPELL = { "auto shot", "arcane shot", "concussive shot", "serpent sting", "aimed shot" };
	RH_MELEESPELL = { "wing clip", "disengage" };
	
	RHOPTION_TEXT1 = "Melee Spell";
	RHOPTION_TEXT2 = "Range Spell";
	RHOPTION_TEXT3 = "Melee Bar No.";
	RHOPTION_TEXT4 = "Range Bar No.";
	RHOPTION_TEXT5 = "Lock ActionBar During Combat";
	RHOPTION_TEXT6 = "Hide Range Info Frame";
	RHOPTION_TEXT7 = "Enable RangeHelp";
	RHOPTION_TEXT8 = "Dead Zone Melee Page";
	RHOPTION_TEXT9 = "Enable Actionbar Switch";
	
	RHOPTION_XML_APPLY = "Apply";
	RHOPTION_XML_CONFIRM = "Confirm";
	RHOPTION_XML_CANCEL = "Cancel";
	RHOPTION_XML_CUSTOMISEUI = "Customise UI";
	RHOPTION_XML_SPELLKEYBIND = "Spell Key Bind";
	RHOPTION_XML_ENABLECUSTSPELL = "Enable Custom Range Check Spells";
	RHOPTION_XML_DISABLECUSTSPELL = "Disable Custom Range Check Spells";
	
	RHOPTION_SPELLDISP_OK = "OK";
	RHOPTION_SPELLDISP_NOTFOUND = "Not found";
	RHOPTION_LEVEL_NOT_MET = "This mod can only be used properly when your character is equipped with LEVEL 12 or above spells";
	
	RHOPTION_APPLY_ERR1 = "Please fill in all fields to proceed.";
	RHOPTION_APPLY_ERR2 = "Invalid page number. Please enter a value between 1-"..NUM_ACTIONBAR_PAGES;
	
	RHUISETUP_TEXT1 = "Resizable";
	RHUISETUP_TEXT2 = "Movable";
	RHUISETUP_TEXT3 = "Font Size";
	RHUISETUP_TEXT4 = "Background Colour Lock";
	RHUISETUP_TEXT5 = "Border Colour Lock";
	RHUISETUP_TEXT6 = "Font Colour Lock";
	RHUISETUP_TEXT7 = "Link Background and Border Colour";
	RHUISETUP_TEXT8 = "Text";
	
	RHUISETUP_MELEE = "Melee";
	RHUISETUP_DEADZONE = "Dead Zone";
	RHUISETUP_RANGE = "Range";
	RHUISETUP_OUTOFRANGE = "Out of Range";
	RHUISETUP_ALLSTATE = "All State";
	RHUISETUP_NOTARG = "No Target";
	
	RHUISETUP_XML_RANGESTATE = "Range State";
	RHUISETUP_XML_BACKCOLOUR = "Background Colour";
	RHUISETUP_XML_BORDERCOLOUR = "Border Colour";
	RHUISETUP_XML_FONTCOLOUR = "Font Colour";
	RHUISETUP_XML_DEFAULT = "Default";
	RHUISETUP_XML_RESETFRAMELOC = "Range Info Lost & Found";
	
	RHKEYSPELL_SELTEXT = "Select the key bind to setup";
	RHKEYSPELL_DROPINSTR = "Select a bound key to setup. You'll have to bind a key to RangeHelp before you are able to setup it up here. You can bind a key under the WoW options menu.";
	RHKEYSPELL_DRAGINSTR = "Drag a spell from your spell book or a macro from your macro list into here. NOTE: MAKE sure that you 'drag AND drop' and NOT 'drag AND click'";
	RHKEYSPELL_CHECKINSTR = "Check this to enable buff check when casting spell";
	BINDING_HEADER_RANGEHELPBIND = "RangeHelp Spell Keys";
	BINDING_NAME_RHSPELLKEY1 = "RangeHelp Key 1";
	BINDING_NAME_RHSPELLKEY2 = "RangeHelp Key 2";
	BINDING_NAME_RHSPELLKEY3 = "RangeHelp Key 3";
	BINDING_NAME_RHSPELLKEY4 = "RangeHelp Key 4";
end

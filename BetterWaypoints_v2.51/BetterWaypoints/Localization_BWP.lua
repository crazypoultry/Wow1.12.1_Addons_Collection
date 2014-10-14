
BETTERWAYPOINTS_NILLOCATION 				= "No Destinations Possible"
BETTERWAYPOINTS_SELECTMSG 					= "Select Destination"
BWPHide										= "Hide"
BWPClear 									= "Clear Destination"
BWPQuestNPCtext								= "QNPC: "
BWP_Unlock 									= "Unlock Frames"
BWP_Lock 									= "Lock Frames"
BWP_Arrived									= BWPGreenText("Arrived!")
BWP_TextToggle 								= "Toggle Text"
BWP_BUTTON_TOOLTIP 							= "BetterWaypoints\nRight-Click to Open Dropdown Menu\nShift + Left-Click to Clear Current Target"
BWPGROUPERROR 								= "You Must Be a Member of a Party Or Raid and in the Same Zone as the Target For Better Waypoints to Utilize this functionality"
BWPGROUPERROR1 								= "Requested Target Not in Your Current Raid."
BWPGROUPERROR2 								= "Requested Target Not in Your Current Group."
BINDING_HEADER_BWP_CLEAR				 	= "BETTER WAYPOINTS";
BINDING_NAME_BWP_CLEAR_BIND					= "Clear Destination";
BWPMENU_Text								="BetterWaypoints"
BWP_Dock 									= "Dock Menu on Minimap"
BWP_Undock									= "Undock from MiniMap"
Error_NoMapMods								="This Feature is only Available to Users of CT_MapMod or MapNotes. you can get them from your favorite Mod site"
BWP_QUEST_NPCSTRING							="QUEST NPC's"

BWP_HideButtonText 								="Hide Button"
BWP_ShowButtonText							= "Show Button"
BWP_Check_ShowMapPoints						= "Show map points"
BWP_Check_ShowTarget						= "Display Target Title"
BWP_Check_ShowDistance						= "Show Distance to Target"
BWP_DistanceText_Units						= "Show Distance in Units"
BWP_DistanceText_Yards						= "Show Distance in Yards"
BWP_DistanceText_Meters						= "Show Distance in Meters"
BWP_Option_Add								= "Add New"
BWP_Slider_Position							= "Position of Button"
BWP_CLEARDIST_TEXT							= "Distance From Destination for Arrived Message"
BWP_Check_ShowQNPC							= "Show Quest NPC's"

BWP_CT_CheckText 							= "Display Mining/Herb Resources"
BWP_Titan_UndockText 						= "Undock From Titan"
BWP_Corpse_Text								= "Corpse"
BWP_OptionsString							= BWPGreenText("-Options-")
BWP_HelpString								= "/bwp or /betterwaypoints to open the Options Menu\n/bwp add will open the window to add a new map point\nbwp follow <PlayerName> will create an arrow to someone in your party or raid\n/bwp clear will clear your current destination\n/bwp XX,YY to creat a temporary Quicknote\n/bwp help to display this message "

--[[
START LOCALIZATION
]]--
if(GetLocale() == "deDE")  then
--[[
GERMAN LOCALIZATION
]]--
BETTERWAYPOINTS_NILLOCATION = "Keine Ziele verf\195\188gbar"
BETTERWAYPOINTS_SELECTMSG = "Ziel ausw\195\164hlen"
BWPHide = "verstecken"
BWPClear = "Ziel zur\195\188cksetzen"
BWPQuestNPCtext = "QNPC: "
BWP_Unlock = "Rahmen entsperren"
BWP_Lock = "Rahmen einrasten"
BWP_Arrived = BWPGreenText("Ziel erreicht!")
BWP_TextToggle = "Text umschalten"
BWP_BUTTON_TOOLTIP = "BetterWaypoints\nanklicken um das Dropdown Men\195\188zu \195\182ffnen"
BWPGROUPERROR = "Du musst Mitglied einer Gruppe oder eines Schlachtzugs sein und dich in der selben Zone wie das Ziel befinden um diese Funktion mit BetterWaypoints benutzen zu k\195\182nnen."
BWPGROUPERROR1 = "Gew\195\188nschtes Ziel ist nicht in deinem Schlachtzug."
BWPGROUPERROR2 = "Gew\195\188nschtes Ziel ist nicht in deiner Gruppe."
BINDING_HEADER_BWP_CLEAR = "BETTER WAYPOINTS";
BINDING_NAME_BWP_CLEAR_BIND = "Ziel zur\195\188cksetzen";
BWPMENU_Text ="BetterWaypoints"
BWP_Dock = "Men\195\188 an Minimap docken"
BWP_Undock = "Men\195\188 von Minimap l\195\182sen"
Error_NoMapMods ="Dieses Feature ist nur f\195\188r Benutzer von CT_MapMod oder MapNotes verf\195\188gbar. Beide erh\195\164ltlich auf deiner Lieblings-Mod-Site"
BWP_QUEST_NPCSTRING ="QUEST NPC's"

BWP_Check_ShowMapPoints	 = "Kartennotizen anzeigen"
BWP_Check_ShowTarget = "Zielname anzeigen"
BWP_Check_ShowDistance = "Entfernung zum Ziel anzeigen"
BWP_Option_Add = "Neues Ziel"
BWP_Slider_Position = "Position des Minimap Buttons"
BWP_Check_ShowQNPC ="Quest NPCs anzeigen"

BWP_HelpString = "/bwp oder /betterwaypoints um das Optionsmen\195\188 zu \195\182ffnen \n/bwp add \195\182ffnet ein Fenster um neue Kartennotizen hinzuzuf\195\188gen \n/bwp follow <PlayerName> erzeugt einen Pfeil in Richtung eines Gruppen- oder Schlachtzug-Mitglieds \n/bwp XX,YY erzeugt ein tempor\195\164res Ziel an den Koordinaten XX,YY\n/bwp help um diesen Text anzuzeigen"

BWP_HideButtonText 	= "Button ausblenden"
BWP_ShowButtonText    = "Button einblenden"
BWP_Corpse_Text		= "Leiche"

BWP_CT_CheckText 							= "Bergbau/Kr\195\164uter Rohstoffe anzeigen"
BWP_Titan_UndockText 						= "Von Titan l\195\182sen"
--[[
END GERMAN LOCALIZATION
]]--
end

--[[
START LOCALIZATION
]]--
if(GetLocale() == "frFR") then
--[[
FRENCH LOCALIZATION BY Sasmira - Cosmos Team -
LAST UPDATE : 03/02/2006
]]--

BETTERWAYPOINTS_NILLOCATION = "Aucune Destinations Possibles"
BETTERWAYPOINTS_SELECTMSG = "S\195\169lectionner une Destination"
BWPHide = "Cacher"
BWPClear = "Suppr. Destination"
BWPQuestNPCtext = "QPNJ: "
BWP_Unlock = "D\195\169bloquer la Fen\195\170tre"
BWP_Lock = "Bloquer la Fen\195\170tre"
BWP_Arrived = BWPGreenText("Arriv\195\169e!")
BWP_TextToggle = "[ON/OFF] Texte"
BWP_BUTTON_TOOLTIP = "BetterWaypoints\nClic-Droit pour ouvrir le Menu\nSHIFT + Clic-Gauche pour supprimer la Cible Courante"
BWPGROUPERROR = "Vous pouvez \195\170tre un membre du Groupe ou du Raid et dans la m\195\170me Zone une Cible pour Better Waypoints to Utilize this functionality"
BWPGROUPERROR1 = "Pas de Demande de Cible dans votre Raid."
BWPGROUPERROR2 = "Pas de Demande de Cible dans votre Groupe."
BINDING_HEADER_BWP_CLEAR = "BETTER WAYPOINTS";
BINDING_NAME_BWP_CLEAR_BIND = "Suppr. Destination";
BWPMENU_Text ="BetterWaypoints"
BWP_Dock = "Accrocher \195\160 la Minimap"
BWP_Undock = "D\195\169crocher de la MiniMap"
Error_NoMapMods ="Celle option est utilisable seulement pour les utilisateurs de CT_MapMod ou MapNotes."
BWP_QUEST_NPCSTRING ="PNJ de QUETE"

BWP_HideButtonText ="Cacher le Bouton"
BWP_ShowButtonText = "Voir le Bouton"
BWP_Check_ShowMapPoints = "Voir les points sur la Map"
BWP_Check_ShowTarget = "Voir le titre de la Cible"
BWP_Check_ShowDistance = "Voir la Distance de la Cible"
BWP_DistanceText_Units = "Voir la Distance en Unit\195\169s"
BWP_DistanceText_Yards = "Voir la Distance en Yards"
BWP_Option_Add = "Nouveau Point"
BWP_Slider_Position = "Position du Bouton"
BWP_Check_ShowQNPC = "Afficher les PNJ de Qu\195\170te"

BWP_CT_CheckText = "Afficher Minage/Herbo Ressources"
BWP_Titan_UndockText = "D\195\169crocher de Titan"
BWP_Corpse_Text = "Cadavre"
BWP_OptionsString = BWPGreenText("-Options-")
BWP_HelpString = "/bwp or /betterwaypoints Pour ouvrir le Menu Options\n/bwp add ouvrira la fen\195\170tre d\'ajout d\'un nouveau point sur la carte\nbwp follow <PlayerName> cr\195\169era une fl\195\168che \195\160 quelqu\'un du Groupe ou du raid\n/bwp clear supprimera votre destination courante\n/bwp XX,YY pour cr\195\169er une note rapide temporaire\n/bwp help pour afficher ce message "

--[[
END FRENCH LOCALIZATION
]]--
end
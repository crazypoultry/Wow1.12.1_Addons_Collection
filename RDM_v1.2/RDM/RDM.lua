--[[-----------------------------------------------------------------------------------------------------------------------------
---------------------------------------- RDM : Real DPS Meter v.1.2 -------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------
-- Auteur : Reikan / CdO -- MAJ : 7 Novembre 2006
-------------------------------------------------------------------------------------------------------------------------------]]

--[[-------------------------------------------------
----------------------------------------------------- VARIABLES -----------------------------------------------------
---------------------------------------------------]]

-- Calcul du DPS, du DPS Moyen et du DPSMax
local dpstemp = 0;										-- Valeur temporaire du DPS
local dpstempMoyen = 0;									-- Valeur temporaire du DPS Moyen
local dpsactuel = 0;									-- DPS actuel
local maxdps = 1;										-- DPS Max
local dpsmoyen = 0;										-- DPS Moyen

-- Tableau de joueurs du Raid / Groupe qui envoi des données a traiter (futur amelioration)
local RDM_TableUserName = {};

-- Calcul du temps
local Valeur_time_Depart = 0;							-- Variable de calcul du temps (Depart)
local Valeur_time_Update = 0;							-- Variable de calcul du temps (Update)
local Valeur_time_Init = 0;								-- Variable de calcul du temps (Init)						
local Valeur_time_Depart_DPSMoyen = 0;					-- Variables de calcul du temps pour le DPS Moyen (Depart)
local Valeur_time_Update_DPSMoyen = 0;					-- Variables de calcul du temps pour le DPS Moyen (Update)
local Valeur_time_Init_DPSMoyen = 0;					-- Variables de calcul du temps pour le DPS Moyen (Init)
local seconde = 0;										-- Secondes écoulées pour le calcul du DPS
local seconde_DPSMoyen = 0;								-- Secondes écoulées pour le calcul du DPS Moyen		
local tempbool = false;									-- Boolean de verification de passage (moment du tick)

-- Statut du joueur
local RDM_IsInRaid = false;								-- Le joueur est en raid
local RDM_IsInParty = false;							-- Le joueur est en groupe
local RDM_IsSolo = false;								-- Le joueur est solo
local RDM_Statut = "";									-- Statut du joueur (mode texte)

-- Indicateur de mode combat
local RDM_isInCombat = false;							-- Boolean qui passe a vrai si le joueur rentre en combat, sinon il est a faux

-- Affichage de la console
local consoleIsVisible = false;							-- Si la console est visible
local optionsIsVisible = false;							-- Si les otpions sont visible
local isMinimise = false;								-- Si la fenetre est minimisé

-- Son
RDM_PATH_SOUND = "Sound\\interface\\AuctionWindowClose.wav";

-- Couleurs
RDM_Rouge = "|cFFFF0000";								-- Rouge
RDM_Vert = "|cFF00FF00";								-- Vert
RDM_Blanc = "|cFFFFFFFF";								-- Blanc
RDM_Raid_Color = "|cFFFF8000";							-- Orange (Raid)
RDM_Groupe_Color = "|cFF67819A";						-- Bleu (Groupe)
RDM_Solo_Color = "|cFF009933";							-- Vert (Solo)


-- parametres du core du programme
local RDM_isCurentlyOn = true;							-- Si ce parametre passe a faux, tous le systeme de calcul s'arrete

-- Variables de l'histogrammes (de la barre 1 a 20)
RDMHistoValue1 = 0.1;
RDMHistoValue2 = 0.1;
RDMHistoValue3 = 0.1;
RDMHistoValue4 = 0.1;
RDMHistoValue5 = 0.1;
RDMHistoValue6 = 0.1;
RDMHistoValue7 = 0.1;
RDMHistoValue8 = 0.1;
RDMHistoValue9 = 0.1;
RDMHistoValue10 = 0.1;
RDMHistoValue11 = 0.1;
RDMHistoValue12 = 0.1;
RDMHistoValue13 = 0.1;
RDMHistoValue14 = 0.1;
RDMHistoValue15 = 0.1;
RDMHistoValue16 = 0.1;
RDMHistoValue17 = 0.1;
RDMHistoValue18 = 0.1;
RDMHistoValue19 = 0.1;
RDMHistoValue20 = 0.1;

--[[---------------------------------------------
----------------------------------------------- CHARGEMENT DE L'ADDON -----------------------------------------------------
---------------------------------------------]]

-- Fonction de chargement de l'addon
function RDM_OnLoad()
	-- On enregistre les events que l'on va controler
	this:RegisterEvent("CHAT_MSG_COMBAT_SELF_HITS");
	this:RegisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE");		
	this:RegisterEvent("CHAT_MSG_COMBAT_PET_HITS");
	this:RegisterEvent("CHAT_MSG_SPELL_PET_DAMAGE");	
	this:RegisterEvent("VARIABLES_LOADED");	
	this:RegisterEvent("PLAYER_REGEN_DISABLED");
	this:RegisterEvent("PLAYER_REGEN_ENABLED");
	this:RegisterEvent("PLAYER_DEAD");
	this:RegisterEvent("CHAT_MSG_ADDON");
	this:RegisterEvent("CHAT_MSG_SPELL_DAMAGESHIELDS_ON_SELF");
end

-- Fonction de chargement des differents elements de l'addon
function RDM_Chargement()	
	-- recuperation du temps systeme pour l'analyse du temps
	Valeur_time_Init = GetTime();	
	
	RDM_MessageChat(RDMTitreAddon..RDM_VERSION.." : "..RDMVersion.." - "..RDM_LOADINGOK..".");
	
	-- Initialisation des elements graphiques
	RDM_Init_BarreTitre();
	RDM_MAJ();
	
	-- Les variables sont chargées => On le dit à la console
	RDM_ConsoleAddLine(RDM_Blanc.."<< "..RDM_Rouge..RDMTitreAddon..RDM_Blanc.." >>");
	RDM_ConsoleAddLine(RDM_Blanc.."<< Version "..RDMVersion..RDM_Blanc.." >>");
	RDM_ConsoleAddLine(RDM_Blanc.."Read Variables : ");
	
	-- Recuperation des savedvariables et analyses, attribution de valeurs par defaut si c'est le premier demarrage de l'addon
	-- Si la SavedVariables dpsmaxsolo est nulle ou inexistante
	if (dpsmaxsolo == nil) then
		RDM_ConsoleAddLine(RDM_Rouge.."MaxSolo Not Found");
		dpsmaxsolo = 1;		
	end
	
	-- Si la SavedVariables dpsmaxsgroupe est nulle ou inexistante
	if (dpsmaxgroupe  == nil) then
		RDM_ConsoleAddLine(RDM_Rouge.."MaxParty Not Found");
		dpsmaxgroupe = 1;
	end
	
	-- Si la SavedVariables dpsmaxraid est nulle ou inexistante
	if (dpsmaxraid == nil) then
		RDM_ConsoleAddLine(RDM_Rouge.."MaxRaid Not Found");
		dpsmaxraid = 1;
	end

	-- Si la SavedVariables dpsstick est nulle ou inexistante
	if (dpstick == nil) then
		RDM_ConsoleAddLine(RDM_Rouge.."Tick Not Found");
		dpstick = 3;
	end
	
	-- Si la SavedVariables RDMFrameisUnLock est nulle ou inexistante
	if (RDMFrameisUnLock == nil) then
		RDM_ConsoleAddLine(RDM_Rouge.."Lock Not Found");
		RDMFrameisUnLock = true;
	end
	
	-- Si la SavedVariables addpetdamagetoDPS est nulle ou inexistante
	if (addpetdamagetoDPS == nil) then
		RDM_ConsoleAddLine(RDM_Rouge.."AddPet Not Found");
		addpetdamagetoDPS = true;
	end

	-- Si la SavedVariables RDMsoundonoff est nulle ou inexistante	
	if (RDMsoundonoff == nil) then
		RDM_ConsoleAddLine(RDM_Rouge.."PlaySound Not Found");
		RDMsoundonoff = true;
	end
	
	-- On ecrit dans la console les infos telles qu'on les a récupérés ou réinitialisé	
	RDM_ConsoleAddLine(RDM_Blanc.."Tick Value : "..RDM_Vert..dpstick);
	
	if (addpetdamagetoDPS == true) then
		RDM_ConsoleAddLine(RDM_Blanc.."AddPetDamage : "..RDM_Vert.."ON");	
	else
		RDM_ConsoleAddLine(RDM_Blanc.."AddPetDamage : "..RDM_Rouge.."OFF");	
	end
	
	if (RDMsoundonoff == true) then
		RDM_ConsoleAddLine(RDM_Blanc.."Sound : "..RDM_Vert.."ON");	
	else
		RDM_ConsoleAddLine(RDM_Blanc.."Sound : "..RDM_Rouge.."OFF");	
	end

	RDM_ConsoleAddLine(RDM_Blanc.."Loading OK");
end

--[[-------------------------------------------
----------------------------------------------- TRAITEMENT DES EVENTS -----------------------------------------------------
---------------------------------------------]]

-- Fonction de traitement des events de l'addon
function RDM_OnEvent(event, arg1, arg2, arg3, arg4, arg5)
	-- Event : Chargement effectué : L'addon a créé les differents elements / variables, on le demarre
	if (event == "VARIABLES_LOADED") then
		RDM_Chargement();
		
	-- Event : Le personnage a porté un coup physique
	elseif (event == "CHAT_MSG_COMBAT_SELF_HITS") then
		-- On verifie les possibilités d'erreur d'interpretation de l'event
		if ( RDM_OtherDamage(arg1) == false) then
			RDM_InterpretationEvent(arg1);
		end
		
	-- Event : Le personnage a porté un coup magique
	elseif (event == "CHAT_MSG_SPELL_SELF_DAMAGE") then
		RDM_InterpretationEvent(arg1);
		
	-- Event : Le personnage a posé un dot sur la cible
	elseif (event == "CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE") then
		if not (string.find(arg1, RDM_DETECTDOT) == nil ) then
			RDM_InterpretationEvent(arg1);
		end
	-- Event : Le bouclier de degats du personnage porte un coup à l'ennemi (spell and item)
	elseif (event == "CHAT_MSG_SPELL_DAMAGESHIELDS_ON_SELF") then
		RDM_InterpretationEvent(arg1);
		
	-- Degats du pet et de certains totems
	elseif (event == "CHAT_MSG_COMBAT_PET_HITS" or event == "CHAT_MSG_SPELL_PET_DAMAGE") then
		-- Si on compte les degats du pet au DPS du joueur
		if (addpetdamagetoDPS == true) then
			RDM_InterpretationEvent(arg1);
		end
		
	-- Event : Le joueur meure ou sort du combat	
	elseif (event == "PLAYER_REGEN_ENABLED") or (event == "PLAYER_DEAD") then
		RDM_CombatStop();
		
	-- Event : Reception d'un message sur le cc raid/groupe AddOn
	elseif (event == "CHAT_MSG_ADDON") then
		RDM_OnChat_ReceiveTemoin(arg1, arg2, arg3, arg4);
	end
end

-- Fonction qui analysera l'argument pour en soutiré des informations exploitables
function RDM_InterpretationEvent(chat_message)
	local firsti, lasti, valeur = string.find(chat_message, "(%d+)");
	
	-- Si nousavons bien trouvé un chiffre representant les degats
	if (valeur) then
		-- On les ajoute
		RDM_ajoutDegat(valeur);
	end
end

-- Fonction de detection des possibilités d'erreur d'interpretation des event (chute, feu, fatigue...)
function RDM_OtherDamage(text)
	local firsti, lasti, value = string.find(text, "(%d+)");
	local retour = false;
	
	if (value) then
		if ( format(VSENVIRONMENTALDAMAGE_FALLING_SELF, value) == text ) then
			retour = true;
		end
		if ( format(VSENVIRONMENTALDAMAGE_DROWNING_SELF, value) == text ) then
			retour = true;
		end
		if ( format(VSENVIRONMENTALDAMAGE_FATIGUE_SELF, value) == text ) then
			retour = true;
		end
		if ( format(VSENVIRONMENTALDAMAGE_FIRE_SELF, value) == text ) then
			retour = true;
		end
		if ( format(VSENVIRONMENTALDAMAGE_LAVA_SELF, value) == text ) then
			retour = true;
		end
		if ( format(VSENVIRONMENTALDAMAGE_SLIME_SELF, value) == text ) then
			retour = true;
		end
	end
	return retour;
end

--[[-------------------------------------------
----------------------------------------------- ADAPTATION DU MOD AUX DIFFERENTS STATUTS DU JOUEURS -----------------------------------------------------
---------------------------------------------]]

-- Verification du mode du joueur
function RDM_VerifStatut()
	if (GetNumRaidMembers() > 0) then			-- Le joueur est en raid
			-- RAID
			RDM_PlayerInRaid();
	else
		if (GetNumPartyMembers() > 0) then		-- Le joueur est en groupe
			-- GROUPE
			RDM_PlayerInParty();
		else									-- Le joueur est solo
			-- SOLO
			RDM_PlayerSolo();
		end
	end
end

-- Get du statut du joueur
function RDM_getStatut()
	local retour = 0;
	
	if (RDM_IsInRaid == true) then
		retour = 2;
	elseif (RDM_IsInParty == true) then
		retour = 1;
	elseif (RDM_IsSolo == true) then
		retour = 0;
	end
	
	return retour;
end

-- Passage en mode Raid
function RDM_PlayerInRaid()
	if (RDM_IsInRaid == false) then
		RDM_IsInRaid = true;
		RDM_IsInParty = false;
		RDM_IsSolo = false;
		RDM_ConsoleAddLine(RDM_Raid_Color.."*Mode "..RDM_RAID.."*");
		RDM_Statut = RDM_Raid_Color..RDM_RAID..RDM_Blanc;
		
		-- On adapte le maxdps
		maxdps = dpsmaxraid;
		
		-- Et on reset l'historique
		RDM_ResetHisto();
		
		-- On adapte le design
		RDM_Frame_Titre_Background:SetVertexColor(1,0.5,0, 1);
		RDM_Main_Frame_Mini:SetBackdropColor(1,0.5,0, 1);
		RDM_Frame_BarreBas_Background:SetVertexColor(1,0.5,0, 0.1);
		
		-- On reset le tableau d'users
		RDM_TableUserName = {};
	end
end

-- Passage en mode Groupe
function RDM_PlayerInParty()
	if (RDM_IsInParty == false) then
		RDM_IsInParty = true;
		RDM_IsInRaid = false;
		RDM_IsSolo = false;
		RDM_ConsoleAddLine(RDM_Groupe_Color.."*Mode "..RDM_PARTY.."*");
		RDM_Statut = RDM_Groupe_Color..RDM_PARTY..RDM_Blanc;
		
		-- On adapte le maxdps
		maxdps = dpsmaxgroupe;
		
		-- Et on reset l'historique
		RDM_ResetHisto();		

		-- On adapte le design
		RDM_Frame_Titre_Background:SetVertexColor(0.4, 0.5, 0.6, 1);
		RDM_Main_Frame_Mini:SetBackdropColor(0.4, 0.5, 0.6, 1);
		RDM_Frame_BarreBas_Background:SetVertexColor(0.4, 0.5, 0.6, 0.1);
		
		-- On reset le tableau d'users
		RDM_TableUserName = {};
	end
end

-- Passage en mode Solo
function RDM_PlayerSolo()
	if (RDM_IsSolo == false) then
		RDM_IsSolo = true;
		RDM_IsInParty = false;
		RDM_IsInRaid = false;
		RDM_ConsoleAddLine(RDM_Solo_Color.."*Mode "..RDM_SOLO.."*");
		RDM_Statut = RDM_Solo_Color..RDM_SOLO..RDM_Blanc;
		
		-- On adapte le maxdps
		maxdps = dpsmaxsolo;
		
		-- Et on reset l'historique
		RDM_ResetHisto();

		-- On adapte le design
		RDM_Frame_Titre_Background:SetVertexColor(0,0.6,0.2);
		RDM_Main_Frame_Mini:SetBackdropColor(0,0.6,0.2);
		RDM_Frame_BarreBas_Background:SetVertexColor(0,0.6,0.2, 0.1);
		
		-- On reset le tableau d'users
		RDM_TableUserName = {};
	end
end

--[[-------------------------------------------
----------------------------------------------- FONCTIONS DE CALCUL DU TEMPS -----------------------------------------------------
---------------------------------------------]]

-- Fonction de démarrage du "core"
function RDM_START()
	RDM_isCurentlyOn = true;
end

-- Fonction d'arret du "core"
function RDM_STOP()
	RDM_isCurentlyOn = false;
end

-- Fonctions d'arret et de demarrage de l'addon en fonction du mode combat 
function RDM_CombatStart()
	RDM_isInCombat = true;
	
	-- Changement de la couleur du fond (rouge => Combat)
	RDM_DPSDPSMAX_Frame:SetBackdropColor(0.8, 0, 0, 0.6);
	
	RDM_ConsoleAddLine(RDM_Rouge.."COMBAT ON");
	
	-- On initialise le temps du combat
	Valeur_time_Init_DPSMoyen = GetTime();	
end

function RDM_CombatStop()
	-- Positionnement du boulean temoin de combat
	RDM_isInCombat = false;
	
	-- Changement de la couleur du fond (gris => Hors Combat)
	RDM_DPSDPSMAX_Frame:SetBackdropColor(1, 1, 1, 0.6);
	
	-- Calcul du temps ecoulé depuis le dernier tick jusqu'a l'arret du combat
	Valeur_time_Depart = GetTime();
	Valeur_time_Update = Valeur_time_Depart - Valeur_time_Init;	
	Valeur_time_Update_DPSMoyen = Valeur_time_Depart_DPSMoyen - Valeur_time_Init_DPSMoyen;
	
	seconde = floor(Valeur_time_Update);
	RDM_calculDPS();
	
	-- Mise a jour du graphique
	RDM_MAJ();
	RDM_MAJ_Histo();
	RDM_reset_variables_DPS();
	RDM_reset_variables_DPSMoyen();
	
	-- On force l'histogramme a faire un defilement 2 fois, afin de separer les données visuelles de chaque combat different
	RDM_UpdateHisto(0);
	RDM_UpdateHisto(0);
	RDM_MAJ();
	
	-- Affichage dans la console
	RDM_ConsoleAddLine(RDM_Rouge.."COMBAT OFF");
end

-- Fonction onupdate qui detectera si on a ateinds le nombre de secondes necessaires au calcul du DPS
function RDM_OnUpdate()
	-- Envoi de l'info "temoin" sur le ccAddon
	RDM_OnChat_SendTemoin();

	-- On verifie si le joueur est solo, en groupe, ou en raid, le changement sera effectif a la fin du combat
	if (RDM_isInCombat == false) then
		RDM_VerifStatut();
	end
	
	-- On raffraichie le dpsmax a chaque OnUpdate
	if (maxdps > 1) then
		RDM_DPSMax:SetText(RDM_Rouge..floor(maxdps));
	else
		RDM_DPSMax:SetText(" ");
	end
	
	if (RDM_isCurentlyOn == true) and (RDM_isInCombat == true) then
		if (tempbool == false) then
			tempbool = true;
			Valeur_time_Init = GetTime();
		end
		
		-- Calcul du temps ecoulé
		Valeur_time_Depart = GetTime();		
		Valeur_time_Update = Valeur_time_Depart - Valeur_time_Init;
		seconde = floor(Valeur_time_Update);	
		
		Valeur_time_Depart_DPSMoyen = GetTime();
		Valeur_time_Update_DPSMoyen = Valeur_time_Depart_DPSMoyen - Valeur_time_Init_DPSMoyen;
		seconde_DPSMoyen = floor(Valeur_time_Update_DPSMoyen);	

		-- On verifie que le temps ecoulé correspond au tick configuré pour le calcul du DPS		
		if (seconde == dpstick) then
			RDM_calculDPS();
			
			-- Mise a jour de l'affichage
			RDM_MAJ();
			RDM_MAJ_Histo();		
			
			-- On reset les données
			RDM_reset_variables_DPS();
		end
	else
		-- On reset a chaque OnUpdate hors combat
		RDM_reset_variables_DPS();
		RDM_reset_variables_DPSMoyen();
	end
end

-- Fonction de reset des données
function RDM_reset_variables_DPS()
	dpstemp = 0;
	dpsactuel = 0;
	tempbool = false;
	seconde = 0;
end

-- Fonction de reset des données du DPS Moyen
function RDM_reset_variables_DPSMoyen()
	dpstempMoyen = 0;
	seconde_DPSMoyen = 0;
end

--[[-------------------------------------------
----------------------------------------------- FONCTIONS DE CALCUL DU DPS -----------------------------------------------------
---------------------------------------------]]

-- Fonction d'ajout de degats
function RDM_ajoutDegat(valeur)
	-- On donne le premier coup, on passe en combat
	if (RDM_isInCombat == false) then
		RDM_CombatStart();
	end
	
	-- On affiche le coup dans la console
	RDM_ConsoleAddLine(RDM_Blanc.."HIT : "..valeur);
	
	-- On prend le coup en compte
	dpstemp = dpstemp + valeur;
	dpstempMoyen = dpstempMoyen + valeur;
end

-- Fonction de calcul du DPS au moment du tick
function RDM_calculDPS()
	if (seconde > 0 ) then
		dpsactuel = dpstemp / seconde;
	
		-- Si on detecte un nouveau DPSMax
		if (dpsactuel > maxdps) then
			--On joue le son si le son est activé
			if (RDMsoundonoff == true) then
				PlaySoundFile(RDM_PATH_SOUND);
			end
			
			--On le sauvegarde selon le statut du joueur
			maxdps = dpsactuel;
			
			-- Si le joueur est en raid
			if (RDM_IsInRaid == true) then
				dpsmaxraid = maxdps;
			-- Si le joueur est en groupe
			elseif (RDM_IsInParty == true) then
				dpsmaxgroupe = maxdps;
			-- Si le joueur est solo
			elseif (RDM_IsSolo == true) then
				dpsmaxsolo = maxdps;
			end
			
			-- On avertie l'utilisateur
			RDM_MessageChat(RDM_NEW_DPS_MAX..RDM_Statut.." ("..floor(maxdps)..") ! "..RDM_CALIBRAGE_ADDON);
			
			if (RDM_isInCombat == true) then
				-- On affiche le tick et le calcul du DPS dans la console
				RDM_ConsoleAddLine("TICK : MAX "..RDM_Statut.." : "..floor(maxdps));
			else
				RDM_ConsoleAddLine("END : MAX "..RDM_Statut.." : "..floor(maxdps));
			end
		else
			if (RDM_isInCombat == true) then
				RDM_ConsoleAddLine("TICK : DPS : "..floor(dpsactuel));
			else
				RDM_ConsoleAddLine("END : DPS : "..floor(dpsactuel));
			end
		end
	end
	
	-- Calcul du DPS Moyen	
	if (seconde_DPSMoyen > 0) then
		dpsmoyen = dpstempMoyen / seconde_DPSMoyen;
	end
end

--[[-------------------------------------------
----------------------------------------------- FONCTIONS GRAPHIQUES (Interface) -----------------------------------------------
---------------------------------------------]]

-- Fonction qui se chargera de mettre à jour les données visuelles
function RDM_MAJ()
	if (maxdps > 0) and (dpsactuel > 0) then
		RDM_DPSActuel:SetText(RDM_Blanc..floor(dpsactuel));
	else
		RDM_DPSActuel:SetText(RDM_Blanc.."0");
	end
	
	RDM_DPSMoyen:SetText(floor(dpsmoyen));
end

function RDM_MAJ_Histo()
	RDM_UpdateHisto(dpsactuel);
end

--[[-------------------------------------------
----------------------------------------------- FONCTIONS DE L HISTOGRAMME -----------------------------------------------------
---------------------------------------------]]

-- Mise a jour de l'histogramme
function RDM_UpdateHisto(derniereValeur)
	derniereValeur = floor(derniereValeur);
	if (derniereValeur == 0) then
		derniereValeur = 0.1;
	end
	
	RDMHistoValue1 = RDMHistoValue2;
	RDMHistoValue2 = RDMHistoValue3;
	RDMHistoValue3 = RDMHistoValue4;
	RDMHistoValue4 = RDMHistoValue5;
	RDMHistoValue5 = RDMHistoValue6;
	RDMHistoValue6 = RDMHistoValue7;
	RDMHistoValue7 = RDMHistoValue8;
	RDMHistoValue8 = RDMHistoValue9;
	RDMHistoValue9 = RDMHistoValue10;
	RDMHistoValue10 = RDMHistoValue11;
	RDMHistoValue11 = RDMHistoValue12;
	RDMHistoValue12 = RDMHistoValue13;
	RDMHistoValue13 = RDMHistoValue14;
	RDMHistoValue14 = RDMHistoValue15;
	RDMHistoValue15 = RDMHistoValue16;
	RDMHistoValue16 = RDMHistoValue17;
	RDMHistoValue17 = RDMHistoValue18;
	RDMHistoValue18 = RDMHistoValue19;
	RDMHistoValue19 = RDMHistoValue20;
	RDMHistoValue20 = derniereValeur;
	
	RDM_UpdateGraphHisto();
end

-- Update de l'affichage de l'histogramme
function RDM_UpdateGraphHisto()		
	-- Recuperation du nom de chaque barre, on boucle et on reactualise
	local i = 1;

	while (i <= 20)	do
		local RDM_GraphTemp = getglobal("RDM_Graph_Bar"..i);
		local RDM_ValeurGraphTemp = getglobal("RDMHistoValue"..i);
		
		RDM_GraphTemp:SetHeight((RDM_ValeurGraphTemp/maxdps) * (RDM_Frame_Graphique:GetHeight() - 13));
		
		i = i + 1.
	end
end

function RDM_ResetHisto()
	-- On adapte la couleur des barres selon le statut du joueur
	if (RDM_getStatut() == 0) then						-- SOLO
		-- Recuperation du nom de chaque barre, on boucle et on les reactualise toutes
		local i = 1;

		while (i <= 20)	do
			local RDM_GraphTemp = getglobal("RDM_Graph_Bar"..i);
			RDM_GraphTemp:SetStatusBarColor(0,0.6,0.2);
			
			i = i + 1.
		end
	elseif (RDM_getStatut() == 1) then					-- 
		-- Recuperation du nom de chaque barre, on boucle et on les reactualise toutes
		local i = 1;

		while (i <= 20)	do
			local RDM_GraphTemp = getglobal("RDM_Graph_Bar"..i);
			RDM_GraphTemp:SetStatusBarColor(0.4, 0.5, 0.6);
			
			i = i + 1.
		end			
	elseif (RDM_getStatut() == 2) then					-- RAID
		-- Recuperation du nom de chaque barre, on boucle et on les reactualise toutes
		local i = 1;

		while (i <= 20)	do
			local RDM_GraphTemp = getglobal("RDM_Graph_Bar"..i);
			RDM_GraphTemp:SetStatusBarColor(1,0.5,0);
			
			i = i + 1.
		end		
	end
	
	-- Reset du graphique
	-- Recuperation du nom de chaque barre, on boucle et on les reactualise toutes
	local i = 1;

	while (i <= 20)	do
		local RDM_GraphTemp = getglobal("RDM_Graph_Bar"..i);
		RDM_GraphTemp:SetHeight(0.1);
			
		i = i + 1.
	end
	
	-- Reset des variables
	RDMHistoValue1 = 0.1;
	RDMHistoValue2 = 0.1;
	RDMHistoValue3 = 0.1;
	RDMHistoValue4 = 0.1;
	RDMHistoValue5 = 0.1;
	RDMHistoValue6 = 0.1;
	RDMHistoValue7 = 0.1;
	RDMHistoValue8 = 0.1;
	RDMHistoValue9 = 0.1;
	RDMHistoValue10 = 0.1;
	RDMHistoValue11 = 0.1;
	RDMHistoValue12 = 0.1;
	RDMHistoValue13 = 0.1;
	RDMHistoValue14 = 0.1;
	RDMHistoValue15 = 0.1;
	RDMHistoValue16 = 0.1;
	RDMHistoValue17 = 0.1;
	RDMHistoValue18 = 0.1;
	RDMHistoValue19 = 0.1;
	RDMHistoValue20 = 0.1;
end

-- Affiche la fenetre qui s'affiche lorsque l'on survole une barre de l'histogramme et affiche la valeur DPS de celle ci
function RDM_ShowAtHisto(value)
	local retour = 0;
	if (value == 1) then
		retour = RDMHistoValue1;
	elseif (value == 2) then
		retour = RDMHistoValue2;
	elseif (value == 3) then
		retour = RDMHistoValue3;
	elseif (value == 4) then
		retour = RDMHistoValue4;
	elseif (value == 5) then
		retour = RDMHistoValue5;
	elseif (value == 6) then
		retour = RDMHistoValue6;
	elseif (value == 7) then
		retour = RDMHistoValue7;
	elseif (value == 8) then
		retour = RDMHistoValue8;
	elseif (value == 9) then
		retour = RDMHistoValue9;
	elseif (value == 10) then
		retour = RDMHistoValue10;
	elseif (value == 11) then
		retour = RDMHistoValue11;
	elseif (value == 12) then
		retour = RDMHistoValue12;
	elseif (value == 13) then
		retour = RDMHistoValue13;
	elseif (value == 14) then
		retour = RDMHistoValue14;
	elseif (value == 15) then
		retour = RDMHistoValue15;
	elseif (value == 16) then
		retour = RDMHistoValue16;
	elseif (value == 17) then
		retour = RDMHistoValue17;
	elseif (value == 18) then
		retour = RDMHistoValue18;
	elseif (value == 19) then
		retour = RDMHistoValue19;
	elseif (value == 20) then
		retour = RDMHistoValue20;
	end
	
	-- On affiche le DPS en question
	return 	RDM_Blanc.."DPS : "..retour;
end

--[[-------------------------------------------
----------------------------------------------- FONCTIONS DE LA BARRE DE TITRE ET DES BOUTONS -----------------------------------------------
---------------------------------------------]]

-- Fonction d'initialisatiopn de l'ap^parence de la barre de titre
function RDM_Init_BarreTitre()
	RDM_Frame_Titre_Text:SetText(RDMTitreAddonForTitre.." v."..RDMVersion);
	RDM_Frame_Titre_Text2:SetText(RDMTitreAddonForTitre.." v."..RDMVersion);
end

-- Verrouillage / deverrouilage de la fenetre principale
function RDM_Lock_Unlock()
	if (RDMFrameisUnLock == true) then
		RDM_MessageChat(RDMTitreAddon.." : "..RDM_FRAME_LOCK..".");
		RDM_ConsoleAddLine("-> Lock");
		RDMFrameisUnLock = false;
	else
		RDM_MessageChat(RDMTitreAddon.." : "..RDM_FRAME_UNLOCK..".");
		RDM_ConsoleAddLine("<- Unlock");
		RDMFrameisUnLock = true;
	end
end

-- Verrouillage / Deverrouillage (Get)
function RDM_returnValeurLock()
	return RDMFrameisUnLock;
end

-- Fonction qui montre/cache la fenetre d'options
function RDM_ShowHideOptions()
	if (optionsIsVisible == false) then
		RDM_OnOpenOptions();
		RDM_Option_Frame:Show();
		optionsIsVisible = true;
		RDM_STOP();		
		RDM_ConsoleAddLine("-> Options (RDM OFF)");
	else
		RDM_Option_Frame:Hide();
		optionsIsVisible = false;
		RDM_START();
		RDM_ConsoleAddLine("<- Options (RDM ON)");
	end
end

-- Fonction qui montre/cache la console
function RDM_ShowHideConsole()
	if (consoleIsVisible == false) then
		RDM_ConsoleFrame:Show();
		consoleIsVisible = true;
	else
		RDM_ConsoleFrame:Hide();
		consoleIsVisible = false;
	end
end

-- Fonction qui maximise / minimise la fenetre
function RDM_MiniMaxiMainFrame()
	if (isMinimise == false) then
		isMinimise = true;
		-- On fait apparaitre le petite fenetre et disparaitre la grande
		RDM_MessageChat(RDMTitreAddon.." : "..RDM_FRAME_MINI..".");		
		RDM_ConsoleAddLine("-> Mini");
		
		RDM_Main_Frame:Hide();
		RDM_DPSDPSMAX_Frame:Hide();
		RDM_Frame_Graphique:Hide();
		RDM_Main_Frame_Mini:Show();
	else
		isMinimise = false;
		-- On fait apparaitre le grande fenetre et disparaitre la petite
		RDM_MessageChat(RDMTitreAddon.." : "..RDM_FRAME_MAXI..".");
		RDM_ConsoleAddLine("<- Maxi");
				
		RDM_Main_Frame_Mini:Hide();
		RDM_Main_Frame:Show();
		RDM_DPSDPSMAX_Frame:Show();
		RDM_Frame_Graphique:Show();
	end
end

--[[-------------------------------------------
----------------------------------------------- FONCTIONS DE LA FENETRE D OPTIONS -----------------------------------------------
---------------------------------------------]]

-- Fonction de reglage du "Tick" (Get)
function RDM_GetTick()
	return dpstick;
end

-- Fonction de reglage du "Tick" (Set)
function RDM_SetTickPlusMoins(valeur)
	if (valeur == "moins") then
		if (dpstick >= 2) then
			dpstick = dpstick - 1;
		end
	else
		if (dpstick <= 9) then
			dpstick = dpstick + 1;
		end
	end
	
	-- On informe l'utilisateur de la nouvelle valeur du tick
	RDM_ActualiseTickValue();
	
	-- Et la console
	RDM_ConsoleAddLine("Tick Value : "..RDM_Vert..dpstick);
end

-- En fonction de l'option selectionée par l'utilisateur, on active/desactive la comtabilité des degats des pets
function RDM_VerifCheckedValue()
	if (RDMPetValueCheck:GetChecked() == 1) then
		addpetdamagetoDPS = true;
		RDM_ConsoleAddLine("Pet Hit "..RDM_Vert.."ON");
	else
		addpetdamagetoDPS = false;
		RDM_ConsoleAddLine("Pet Hit "..RDM_Rouge.."OFF");
	end
	
	if (RDMSoundValueCheck:GetChecked() == 1) then
		RDMsoundonoff = true;
		RDM_ConsoleAddLine("Sound "..RDM_Vert.."ON");
	else
		RDMsoundonoff = false;
		RDM_ConsoleAddLine("Sound "..RDM_Rouge.."OFF");
	end
end

-- A chaque modification/ouverture des options on verifie les données
function RDM_ActualiseTickValue()
	-- On informe l'utilisateur de la nouvelle valeur
	RDM_Option1:SetText(RDM_TICK_VALUE_TEXT..dpstick.." sec.");
	
	if (dpstick == 1) then
		RDMbtmTickMoins:Disable();
	elseif (dpstick > 1) and (dpstick < 10) then
		RDMbtmTickPlus:Enable();
		RDMbtmTickMoins:Enable();
	elseif (dpstick == 10) then
		RDMbtmTickPlus:Disable();
	end
end

--Fonction qui s'execute à l'ouverture de la fenetre d'option
function RDM_OnOpenOptions()
	--Si les degats du pet etaient activés, on coche la case
	if (addpetdamagetoDPS == true) then
		RDMPetValueCheck:SetChecked(true);
	else
		RDMPetValueCheck:SetChecked(false);
	end
	
	--Si le son est activé, on coche la case
	if (RDMsoundonoff == true) then
		RDMSoundValueCheck:SetChecked(true);
	else
		RDMSoundValueCheck:SetChecked(false);
	end
	
	--On met la valeur du tick comme il faut
	RDM_ActualiseTickValue();
end

--[[-------------------------------------------
----------------------------------------------- RESET DES MAX DPS SOLO, GROUPE ET RAID -----------------------------------------
---------------------------------------------]]

-- Fonction de reset du DPSMAX Solo
function RDM_ResetMAXSolo()
	dpsmaxsolo = 1;
	
	RDM_ConsoleAddLine("*MAXDPS Solo Reset*");
	
	if (RDM_getStatut() == 0) then
		maxdps = dpsmaxsolo;
		
		RDM_ResetHisto();
	end
end

-- Fonction de reset du DPSMAX Groupe
function RDM_ResetMAXParty()
	dpsmaxgroupe = 1;
	
	RDM_ConsoleAddLine("*MAXDPS Party Reset*");
	
	if (RDM_getStatut() == 1) then
		maxdps = dpsmaxgroupe;
		
		RDM_ResetHisto();
	end
end

-- Fonction de reset du DPSMAX Raid
function RDM_ResetMAXRaid()
	dpsmaxraid = 1;
	
	RDM_ConsoleAddLine("*MAXDPS Raid Reset*");
	
	if (RDM_getStatut() == 2) then
		maxdps = dpsmaxraid;
		
		RDM_ResetHisto();
	end
end

-- Fonction d'update des positions des boutons
function RDM_UpdateBoutonsReset()
	if (dpsmaxraid == 1) then
		RDM_Frame_Titre_Btn_ResetDPSRaid:Disable();
	else
		RDM_Frame_Titre_Btn_ResetDPSRaid:Enable();	
	end
	
	if (dpsmaxgroupe == 1) then
		RDM_Frame_Titre_Btn_ResetDPSGroupe:Disable();
	else
		RDM_Frame_Titre_Btn_ResetDPSGroupe:Enable();	
	end
	
	if (dpsmaxsolo == 1) then
		RDM_Frame_Titre_Btn_ResetDPSSolo:Disable();
	else
		RDM_Frame_Titre_Btn_ResetDPSSolo:Enable();	
	end
end

--[[-------------------------------------------------
----------------------------------------------------- FONCTIONS DE COMMUNICATION AVEC L UTILISATEUR -------------------------------
---------------------------------------------------]]

-- Fonction qui affiche un message dans le chat
function RDM_MessageChat(texte)
	DEFAULT_CHAT_FRAME:AddMessage(texte);
end

--[[-------------------------------------------------
----------------------------------------------------- FONCTIONS PARTY / RAID, PARTAGE D'INFOS -------------------------------
---------------------------------------------------]]

--Fonction Raid/Party : Envoi de données "temoins" sur le SendChatAddon.
function RDM_OnChat_SendTemoin()
	if (RDM_IsInParty == true) then
		SendAddonMessage("RDMT", "Temoin", "PARTY");
	end
	
	if (RDM_IsInRaid == true) then
		SendAddonMessage("RDMT", "Temoin", "RAID");
	end
end

--A chaque reception de message SendChatAddon, on verifie son expediteur, s'il n'est pas referencé, on le fait
function RDM_OnChat_ReceiveTemoin(prefixeaddon, message, channel, username)
	if (prefixeaddon == "RDMT") and (message == "Temoin") then
		RDM_AddOrNotRaidUserInTable(username);
	end
end

-- Fonction qui inscrira dans le tableau l'user detecté
function RDM_AddOrNotRaidUserInTable(auteur)
	local RDM_UserIsInTable = false;
	
	for index, value in ipairs(RDM_TableUserName) do
		-- On verifie que l'auteur ne soit pas dans le tableau, si c'est le cas on le rajoute
		
		if (value == auteur) then
			RDM_UserIsInTable = true;
		end
	end
	
	-- Si l'utilisateur n'etait pas dans le tableau, on le rajoute
	if (RDM_UserIsInTable == false) then
		RDM_ConsoleAddLine("AddUser (1.2) : "..auteur);
		table.insert(RDM_TableUserName, auteur);
	end
end

--[[-------------------------------------------------
----------------------------------------------------- CONSOLE -----------------------------------------------------
---------------------------------------------------]]

-- Fonction qui rajoutera une ligne dans la console
function RDM_ConsoleAddLine(texte)
	RDM_Console_ScrollingMessage:AddMessage(texte);
end

------------------------------------------------------------------------------------------------------
-- Serenity
--
-- Based on Necrosis LdC by Lomig and Nyx (http://necrosis.larmes-cenarius.net)
-- Original Necrosis Idea : Infernal (http://www.revolvus.com/games/interface/necrosis/)
-- Serenity Maintainer : Kaeldra of Aegwynn
--
-- Contact : darklyte@gmail.com
-- Send me in-game mail!  Yersinia on Aegwynn, Horde side.
-- Guild: <Working as Intended>
-- Version Date: 07.14.2006
------------------------------------------------------------------------------------------------------


------------------------------------------------------------------------------------------------------
-- FONCTIONS D'INSERTION
------------------------------------------------------------------------------------------------------

-- La table des timers est là pour ça !
function Serenity_InsertTimerParTable(IndexTable, Target, LevelTarget, SpellGroup, SpellTimer, TimerTable)

	-- Insertion de l'entrée dans le tableau
	table.insert(SpellTimer,
		{
			Name = SERENITY_SPELL_TABLE[IndexTable].Name,
			Time = SERENITY_SPELL_TABLE[IndexTable].Length,
			TimeMax = floor(GetTime() + SERENITY_SPELL_TABLE[IndexTable].Length),
			Type = SERENITY_SPELL_TABLE[IndexTable].Type,
			Target = Target,
			TargetLevel = LevelTarget,
			Group = 0,
			Gtimer = nil
		});

	-- Association d'un timer graphique au timer
	SpellTimer, TimerTable = Serenity_AddFrame(SpellTimer, TimerTable);

	-- Tri des entrées par type de sort
	Serenity_Tri(SpellTimer, "Type");
	
	-- Création des groupes (noms des mobs) des timers
	SpellGroup, SpellTimer = Serenity_Parsing(SpellGroup, SpellTimer);

	return SpellGroup, SpellTimer, TimerTable;
end

-- Et pour insérer le timer de pierres
function Serenity_InsertTimerStone(Stone, start, duration, SpellGroup, SpellTimer, TimerTable)

	-- Insertion de l'entrée dans le tableau
	if Stone == "Potion" then
		table.insert(SpellTimer,
			{
				Name = SERENITY_COOLDOWN.Potion,
				Time = 180,
				TimeMax = floor(GetTime() + 180),
				Type = 2,
				Target = "",
				TargetLevel = "",
				Group = 2,
				Gtimer = nil
			});

		-- Association d'un timer graphique au timer
		SpellTimer, TimerTable = Serenity_AddFrame(SpellTimer, TimerTable);
		
	elseif Stone == "Spellstone" then
		table.insert(SpellTimer,
			{
				Name = SERENITY_COOLDOWN.Spellstone,
				Time = 30,
				TimeMax = floor(GetTime() + 30),
				Type = 2,
				Target = "",
				TargetLevel = "",
				Group = 2,
				Gtimer = nil
			});

		-- Association d'un timer graphique au timer
		SpellTimer, TimerTable = Serenity_AddFrame(SpellTimer, TimerTable);
		
	elseif Stone == "Soulstone" then
		table.insert(SpellTimer,
			{
				Name = SERENITY_SPELL_TABLE[11].Name,
				Time = floor(duration - GetTime() + start),
				TimeMax = floor(start + duration),
				Type = SERENITY_SPELL_TABLE[11].Type,
				Target = "???",
				TargetLevel = "",
				Group = 1,
				Gtimer = nil,
			});

		-- Association d'un timer graphique au timer
		SpellTimer, TimerTable = Serenity_AddFrame(SpellTimer, TimerTable);
	end

	-- Tri des entrées par type de sort	
	Serenity_Tri(SpellTimer, "Type");

	-- Création des groupes (noms des mobs) des timers
	SpellGroup, SpellTimer = Serenity_Parsing(SpellGroup, SpellTimer);

	return SpellGroup, SpellTimer, TimerTable;
end

-- Pour la création de timers personnels
function SerenityTimerX(nom, duree, truc, Target, LevelTarget, SpellGroup, SpellTimer, TimerTable)
	
	table.insert(SpellTimer,
			{
				Name = nom,
				Time = duree,
				TimeMax = floor(GetTime() + duree),
				Type = truc,
				Target = Target,
				TargetLevel = LevelTarget,
				Group = 0,
				Gtimer = nil
			});

	-- Association d'un timer graphique au timer
	SpellTimer, TimerTable = Serenity_AddFrame(SpellTimer, TimerTable);

	-- Tri des entrées par type de sort
	Serenity_Tri(SpellTimer, "Type");
	
	-- Création des groupes (noms des mobs) des timers
	SpellGroup, SpellTimer = Serenity_Parsing(SpellGroup, SpellTimer);

	return SpellGroup, SpellTimer, TimerTable;	
end

------------------------------------------------------------------------------------------------------
-- FONCTIONS DE RETRAIT
------------------------------------------------------------------------------------------------------


-- Connaissant l'index du Timer dans la liste, on le supprime
function Serenity_RetraitTimerParIndex(index, SpellTimer, TimerTable)

		-- Suppression du timer graphique
		local Gtime = SpellTimer[index].Gtimer;
		TimerTable = Serenity_RemoveFrame(Gtime, TimerTable);
		
		-- On enlève le timer de la liste
		table.remove(SpellTimer, index);

	return SpellTimer, TimerTable;
end

-- Si on veut supprimer spécifiquement un Timer...
function Serenity_RetraitTimerParNom(name, SpellTimer, TimerTable)
	for index = 1, table.getn(SpellTimer), 1 do
		if SpellTimer[index].Name == name then
			SpellTimer = Serenity_RetraitTimerParIndex(index, SpellTimer, TimerTable);
			break;
		end
	end
	return SpellTimer, TimerTable;
end

-- Fonction pour enlever les timers de combat lors de la regen
function Serenity_RetraitTimerCombat(SpellGroup, SpellTimer, TimerTable)
	for index=1, table.getn(SpellTimer), 1 do
		if SpellTimer[index] ~= nil then
			-- Si les cooldowns sont nominatifs, on enlève le nom
			if SpellTimer[index].Type == 3 then
				SpellTimer[index].Target = "";
				SpellTimer[index].TargetLevel = "";
			end
			-- Enlevage des timers de combat
			if ((SpellTimer[index].Type == 4) or (SpellTimer[index].Type == 5)) then
				SpellTimer = Serenity_RetraitTimerParIndex(index, SpellTimer, TimerTable);
			end
		end
	end

	if table.getn(SpellGroup.Name) >= 4 then
		for index = 4, table.getn(SpellGroup.Name), 1 do
			table.remove(SpellGroup.Name);
			table.remove(SpellGroup.SubName);
			table.remove(SpellGroup.Visible);
		end
	end
	return SpellGroup, SpellTimer, TimerTable;
end

------------------------------------------------------------------------------------------------------
-- FONCTIONS BOOLEENNES
------------------------------------------------------------------------------------------------------

function Serenity_TimerExisteDeja(Nom, SpellTimer)
	for index = 1, table.getn(SpellTimer), 1 do
		if SpellTimer[index].Name == Nom then
			return true;
		end
	end
	return false;
end


------------------------------------------------------------------------------------------------------
-- FONCTIONS DE TRI
------------------------------------------------------------------------------------------------------

-- On définit les groupes de chaque Timer
function Serenity_Parsing(SpellGroup, SpellTimer)
	local GroupeOK = false;
	for index = 1, table.getn(SpellTimer), 1 do
		local GroupeOK = false;
		for i = 1, table.getn(SpellGroup.Name), 1 do
			if ((SpellTimer[index].Type == i) and (i <= 3)) or 
			   (SpellTimer[index].Target == SpellGroup.Name[i]
				and SpellTimer[index].TargetLevel == SpellGroup.SubName[i])
				then
				GroupeOK = true;
				SpellTimer[index].Group = i;
				break;
			end
		end
		-- Si le groupe n'existe pas, on en crée un nouveau
		if not GroupeOK then
			table.insert(SpellGroup.Name, SpellTimer[index].Target);
			table.insert(SpellGroup.SubName, SpellTimer[index].TargetLevel);
			table.insert(SpellGroup.Visible, false);
			SpellTimer[index].Group = table.getn(SpellGroup.Name);
		end
	end
	
	 Serenity_Tri(SpellTimer, "Group");
	return SpellGroup, SpellTimer;
end

-- On trie les timers selon leur groupe
function Serenity_Tri(SpellTimer, clef)
	return table.sort(SpellTimer,
		function (SubTab1, SubTab2)
			return SubTab1[clef] < SubTab2[clef]
		end);
end

------------------------------------------------------------------------------------------------------
-- FONCTIONS D'AFFICHAGE : CREATION DE LA CHAINE DE CARACTERE
------------------------------------------------------------------------------------------------------


function Serenity_DisplayTimer(display, index, SpellGroup, SpellTimer, GraphicalTimer, TimerTable)
	if SpellTimer[1] == nil then
		return display, SpellGroup;
	end
	
	local minutes = 0;
	local seconds = 0;
	local affichage;
	
	-- Changement de la couleur suivant le temps restant	
	local percent = (floor(SpellTimer[index].TimeMax - floor(GetTime())) / SpellTimer[index].Time)*100;
	local color = SerenityTimerColor(percent);
	
	if not SpellGroup.Visible[SpellTimer[index].Group]
		and SpellGroup.SubName[SpellTimer[index].Group] ~= nil
		and SpellGroup.Name[SpellTimer[index].Group] ~= nil then
		display = display.."<purple>-------------------------------\n"..SpellGroup.Name[SpellTimer[index].Group].." "..SpellGroup.SubName[SpellTimer[index].Group].."\n-------------------------------<close>\n";
		-- Crée le tableau qui servira aux timers graphiques
		table.insert(GraphicalTimer.texte, SpellGroup.Name[SpellTimer[index].Group].." "..SpellGroup.SubName[SpellTimer[index].Group]);
		table.insert(GraphicalTimer.TimeMax, 0);
		table.insert(GraphicalTimer.Time, 0);
		table.insert(GraphicalTimer.titre, true);
		table.insert(GraphicalTimer.temps, "");
		table.insert(GraphicalTimer.Gtimer, 0);
		SpellGroup.Visible[SpellTimer[index].Group] = true;
	end

	-- Mise en place d'un Chrono plutôt qu'un Compte à Rebours pour l'asservissement
--	if SpellTimer[index].Name == SERENITY_SPELL_TABLE[10].Name then
--		seconds = floor(GetTime()) - (SpellTimer[index].TimeMax - SpellTimer[index].Time);
--	else
		seconds = SpellTimer[index].TimeMax - floor(GetTime());
--	end
	minutes = floor(seconds/60);
	if (minutes > 0) then
		if (minutes > 9) then
			affichage = tostring(minutes)..":";
		else
			affichage = "0"..minutes..":"
		end
	else
		affichage = "0:";
	end
	seconds = mod(seconds, 60);
	if (seconds > 9) then
		affichage = affichage..seconds
	else
		affichage = affichage.."0"..seconds
	end
	display = display.."<white>"..affichage.." - <close>";

	-- Crée le tableau qui servira aux timers graphiques
	if (SpellTimer[index].Type == 1 or SpellTimer[index].Name == SERENITY_SPELL_TABLE[26].Name)
	and (SpellTimer[index].Target ~= "") then
		if SerenityConfig.SpellTimerPos == 1 then
			affichage = affichage.." - "..SpellTimer[index].Target;
		else
			affichage = SpellTimer[index].Target.." - "..affichage;
		end
	end
	table.insert(GraphicalTimer.texte, SpellTimer[index].Name);
	table.insert(GraphicalTimer.TimeMax, SpellTimer[index].TimeMax);
	table.insert(GraphicalTimer.Time, SpellTimer[index].Time);
	table.insert(GraphicalTimer.titre, false);
	table.insert(GraphicalTimer.temps, affichage);
	table.insert(GraphicalTimer.Gtimer, SpellTimer[index].Gtimer);
	
	display = display..color..SpellTimer[index].Name.."<close><white>";
	if (SpellTimer[index].Type == 1 or SpellTimer[index].Name == SERENITY_SPELL_TABLE[26].Name)
		and (SpellTimer[index].Target ~= "")
		then
		display = display.." -SPEE "..SpellTimer[index].Target.."<close>\n";
	else
		display = display.."<close>\n";
	end
	-- Affichage des timers graphiques (si sélectionnés)
	if SerenityConfig.Graphical then
		SerenityAfficheTimer(GraphicalTimer, TimerTable);
	end

	return display, SpellGroup, GraphicalTimer, TimerTable;
end

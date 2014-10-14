------------------------------------------------------------------------------------------------------
-- Serenity
--
-- Based on Necrosis LdC by Lomig and Nyx (http://necrosis.larmes-cenarius.net)
-- Original Necrosis Idea : Infernal (http://www.revolvus.com/games/interface/necrosis/)
-- Serenity Maintainer : Kaeldra of Aegwynn
--
-- Contact : darklyte@gmail.com
-- Send me in-game mail! Yersinia on Aegwynn, Horde side.
-- Guild:
-- Version Date: 29.08.2006
------------------------------------------------------------------------------------------------------

------------------------------------------------
-- FRENCH VERSION FUNCTIONS --
------------------------------------------------
--
if ( GetLocale() == "frFR" ) then
	
	SERENITY_UNIT_PRIEST = "Pr\195\170tre";
	
	-- Word to search for Fire Vulnerability and Winter's shadow first (.+) is the target, second is the spell
	SERENITY_DEBUFF_SRCH	= "(.+) est affect\195\169 par (.+)."
	SERENITY_FADE_SRCH		= "(.+) sur (.+) vient de se dissiper."
	SERENITY_GAIN_SRCH		= "(.+) gagne (.+)."
	SERENITY_CORPSE_SRCH	= "Corps de (.+)"
	
	function Serenity_SpellTableBuild()
		SERENITY_SPELL_TABLE = {
			[1] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
			Name = "Abolir maladie", Length = 0, Type = 0},
			[2] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
			Name = "R\195\169tablissement b\195\169ni", Length = 6, Type = 0},
			[3] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
			Name = "Gu\195\169rison des maladies", Length = 0, Type = 0},
			[4] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
			Name = "Pri\195\168re du d\195\169sespoir", Length = 600, Type = 3},
			[5] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
			Name = "Peste d\195\169vorante", Length = 24, Type = 5},
			[6] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
			Name = "Peste d\195\169vorante", Length = 180, Type = 3},
			[7] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
			Name = "Dissipation de la magie", Length = 0, Type = 0},
			[8] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
			Name = "Esprit divin", Length = 1800, Type = 0},
			[9] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
			Name = "Gr\195\162ce d'Elune", Length = 300, Type = 3},
			[10] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
			Name = "Oubli", Length = 30, Type = 3},
			[11] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
			Name = "Gardien de peur", Length = 30, Type = 3},
			[12] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
			Name = "R\195\169action", Length = 180, Type = 3},
			[13] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
			Name = "Soins rapides", Length = 0, Type = 0},
			[14] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
			Name = "Soins majeurs", Length = 0, Type = 0},
			[15] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
			Name = "Soins", Length = 0, Type = 0},
			[16] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
			Name = "Mal\195\169fice de faiblesse", Length = 120, Type = 5},
			[17] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
			Name = "Flammes sacr\195\169es", Length = 10, Type = 5},
			[18] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
			Name = "Nova sacr\195\169e", Length = 0, Type = 0},
			[19] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
			Name = "Focalisation am\195\169lior\195\169e", Length = 180, Type = 3},
			[20] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
			Name = "Feu int\195\169rieur", Length = 0, Type = 0},
			[21] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
			Name = "Inspiration", Length = 15, Type = 5},
			[22] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
			Name = "Soins mineurs", Length = 0, Type = 0},
			[23] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
			Name = "L\195\169vitation", Length = 120, Type = 0},
			[24] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
			Name = "Puits de lumi\195\168re", Length = 600, Type = 3},
			[25] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
			Name = "Puits de lumi\195\168re (1)", Length = 180, Type = 2},
			[26] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
			Name = "Puits de lumi\195\168re (2)", Length = 180, Type = 2},
			[27] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
			Name = "Puits de lumi\195\168re (3)", Length = 180, Type = 2},
			[28] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
			Name = "Puits de lumi\195\168re (4)", Length = 180, Type = 2},
			[29] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
			Name = "Puits de lumi\195\168re (5)", Length = 600, Type = 2},
			[30] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
			Name = "Br\195\187lure de mana", Length = 0, Type = 0},
			[31] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
			Name = "Martyre", Length = 6, Type = 0},
			[32] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
			Name = "Attaque mentale", Length = 8, Type = 3},
			[33] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
			Name = "Contr\195\180le mental", Length = 60, Type = 0},
			[34] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
			Name = "Fouet mental", Length = 3, Type = 0},
			[35] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
			Name = "Apaisement", Length = 15, Type = 5},
			[36] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
			Name = "Vision t\195\169l\195\169pathique", Length = 60, Type = 0},
			[37] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
			Name = "Infusion de puissance", Length = 180, Type = 3},
			[38] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
			Name = "Mot de pouvoir : Robustesse", Length = 1800, Type = 0},
			[39] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
			Name = "Mot de pouvoir : Bouclier", Length = 30, Type = 5},
			[40] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
			Name = "Mot de pouvoir : Bouclier Cooldown", Length = 4, Type = 3},
			[41] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
			Name = "Pri\195\168re de robustesse", Length = 3600, Type = 0},
			[42] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
			Name = "Pri\195\168re de soins", Length = 0, Type = 0},
			[43] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
			Name = "Pri\195\168re de protection contre l'Ombre", Length = 1200, Type = 0},
			[44] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
			Name = "Pri\195\168re d'Esprit", Length = 3600, Type = 0},
			[45] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
			Name = "Cri psychique", Length = 30, Type = 3},
			[46] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
			Name = "Cri psychique Effect", Length = 8, Type = 5},
			[47] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
			Name = "R\195\169novation", Length = 15, Type = 5},
			[48] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
			Name = "R\195\169surrection", Length = 0, Type = 0},
			[49] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
			Name = "Entraves des morts-vivants", Length = 50, Type = 2},
			[50] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
			Name = "Tissage de l'Ombre", Length = 0, Type = 0},
			[51] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
			Name = "Protection contre l'Ombre", Length = 600, Type = 0},
			[52] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
			Name = "Mot de l'ombreÂ : Douleur", Length = 18, Type = 4},
			[53] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
			Name = "Forme d'Ombre", Length = 0, Type = 0},
			[54] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
			Name = "Garde de l'Ombre", Length = 600, Type = 0},
			[55] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
			Name = "Silence", Length = 45, Type = 3},
			[56] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
			Name = "Ch\195\162timent", Length = 0, Type = 0},
			[57] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
			Name = "Esprit de r\195\169demption", Length = 10, Type = 0},
			[58] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
			Name = "Eclats stellaires", Length = 0, Type = 0},
			[59] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
			Name = "Toucher de faiblesse", Length = 120, Type = 5},
			[60] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
			Name = "Etreinte vampirique", Length = 60, Type = 5},
			[61] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
			Name = "Ame affaiblie", Length = 15, Type = 5},
			[62] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
			Name = "Vuln\195\169rabilit\195\169 \195\160 l'Ombre", Length = 15, Type = 5},
			[63] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
			Name = "Vuln\195\169rabilit\195\169 \195\160 l'Ombre (2)", Length = 15, Type = 5},
			[64] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
			Name = "Vuln\195\169rabilit\195\169 \195\160 l'Ombre (3)", Length = 15, Type = 5},
			[65] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
			Name = "Vuln\195\169rabilit\195\169 \195\160 l'Ombre (4)", Length = 15, Type = 5},
			[66] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
			Name = "Vuln\195\169rabilit\195\169 \195\160 l'Ombre (5)", Length = 15, Type = 5},
			[67] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
			Name = "Aveuglement", Length = 3, Type = 5},
			[68] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
			Name = "R\195\169novation d'un Puits de lumi\195\168re", Length = 10, Type = 5},
			[69] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
			Name = "Etreinte vampirique Cooldown", Length = 10, Type = 3},
		};
		end
		
		Serenity_SpellTableBuild()
		
		-- Type 0 = Pas de timer
		-- Type 1 = Timer principal permanent
		-- Type 2 = Timer permanent
		-- Type 3 = Timer de temps de recharge
		-- Type 4 = Timer des debuff
		-- Type 5 = Timer de combat
		-- Type 6 = Non-cast debuff. Not to be removed by normal means	-- need help :p
		
		SERENITY_ITEM = {
			["LightFeather"]	= "Plume l\195\169g\195\168re",
			["HolyCandle"]		= "Bougie sanctifi\195\169e",
			["SacredCandle"]	= "Bougie sacr\195\169e",
			["Potion"]			= "Potion",
			["Draught"]			= "Breuvage",
			["ManaPotion"]		= "Potion de mana",
			["HealingPotion"]	= "Potion de soins",
			["Healthstone"]		= "Pierre de soins",
			["Hearthstone"]		= "Pierre de foyer",
		};
		
		SERENITY_DRINK_SRCH = {
			"Eau",
			"Bi\195\168re",
			"Lait",
			"Jus",
			"Nectar",
			"Th\195\169",
			"Soupe",
			"Limonade",
		};
		SERENITY_DRINK = {
			[1] = { Name = "Boisson gazeuse de la foire", Energy = 151, Level = 1,
			Length = 18, Conjured = false, PvP = false },
			[2] = { Name = "Eau invoqu\195\169e", Energy = 151, Level = 1,
			Length = 18, Conjured = true, PvP = false },
			[3] = { Name = "Bi\195\168re m\195\169lang\195\169e", Energy = 436, Level = 5,
			Length = 21, Conjured = false, PvP = false },
			[4] = { Name = "Lait glac\195\169", Energy = 436, Level = 5,
			Length = 21, Conjured = false, PvP = false },
			[5] = { Name = "Eau fra\195\174che invoqu\195\169e", Energy = 436, Level = 5,
			Length = 21, Conjured = true, PvP = false },
			[6] = { Name = "Jus de melon", Energy = 835, Level = 15,
			Length = 24, Conjured = false, PvP = false },
			[7] = { Name = "Boisson gazeuse de la foire", Energy = 835, Level = 15,
			Length = 24, Conjured = false, PvP = false },
			[8] = { Name = "Eau bouillonnante", Energy = 835, Level = 15,
			Length = 24, Conjured = false, PvP = false },
			[9] = { Name = "Eau purifi\195\169e invoqu\195\169e", Energy = 835, Level = 15,
			Length = 24, Conjured = true, PvP = false },
			[10] = { Name = "Nectar sucr\195\169", Energy = 1344, Level = 25,
			Length = 27, Conjured = false, PvP = false },
			[11] = { Name = "Th\195\169 de dor\195\169pine", Energy = 1344, Level = 25,
			Length = 27, Conjured = false, PvP = false },
			[12] = { Name = "Eau enchant\195\169e", Energy = 1344, Level = 25,
			Length = 27, Conjured = false, PvP = false },
			[13] = { Name = "Th\195\169 du jardin vert", Energy = 1344, Level = 25,
			Length = 27, Conjured = false, PvP = false },
			[14] = { Name = "Eau de source invoqu\195\169e", Energy = 1344, Level = 25,
			Length = 27, Conjured = true, PvP = false },
			[15] = { Name = "Jus de baie lunaire", Energy = 1992, Level = 35,
			Length = 30, Conjured = false, PvP = false },
			[16] = { Name = "Bouteille d'eau de Berceau-de-l'Hiver", Energy = 1992, Level = 35,
			Length = 30, Conjured = false, PvP = false },
			[17] = { Name = "Eau min\195\169rale invoqu\195\169e", Energy = 1992, Level = 35,
			Length = 30, Conjured = true, PvP = false },
			[18] = { Name = "Soupe de ros\195\169e matinale", Energy = 2934, Level = 45,
			Length = 30, Conjured = false, PvP = false },
			[19] = { Name = "Limonade fra\195\174chement press\195\169e", Energy = 2934, Level = 45,
			Length = 30, Conjured = false, PvP = false },
			[20] = { Name = "Jus de Fruit solaire b\195\169ni", Energy = 4410, Level = 45,
			Length = 30, Conjured = false, PvP = false },
			[21] = { Name = "Eau p\195\169tillante invoqu\195\169e", Energy = 2934, Level = 45,
			Length = 30, Conjured = true, PvP = false },
			[22] = { Name = "Bouteille d'eau de source d'Alterac", Energy = 4410, Level = 55,
			Length = 30, Conjured = false, PvP = false },
			[23] = { Name = "Eau cristalline invoqu\195\169e", Energy = 4200, Level = 55,
			Length = 30, Conjured = true, PvP = false },
			
			-- Ajout des boisons non détecté.
			--[24] = { Name = "Eau de source", Energy = 151, Level = 1,
			--Length = 18, Conjured = false, PvP = false },
		};
		
		SERENITY_MANA_POTION = {
			[1] = { Name = "Potion de mana mineure", Level = 5,
			EnergyMin = 140, EnergyMax = 180, PvP = false},
			[2] = { Name = "Potion de mana inf\195\169rieure", Level = 14,
			EnergyMin = 280, EnergyMax = 360, PvP = false},
			[3] = { Name = "Potion de mana", Level = 14,
			EnergyMin = 445, EnergyMax = 585, PvP = false},
			[4] = { Name = "Potion de mana sup\195\169rieure", Level = 31,
			EnergyMin = 700, EnergyMax = 900, PvP = false},
			[5] = { Name = "Breuvage de mana excellent",Level = 35,
			EnergyMin = 700, EnergyMax = 900, PvP = true},
			[6] = { Name = "Potion de mana excellente", Level = 41,
			EnergyMin = 900, EnergyMax = 1500, PvP = false},
			[7] = { Name = "Potion de mana majeure", Level = 49,
			EnergyMin = 1350, EnergyMax = 2250, PvP = false},
			[8] = { Name = "Potion de mana de combat", Level = 41,
			EnergyMin = 900, EnergyMax = 1500, PvP = false},
			[9] = { Name = "Breuvage de mana majeur", Level = 45,
			EnergyMin = 980, EnergyMax = 1260, PvP = true},
		};
		
		SERENITY_HEALING_POTION = {
			[1] = { Name = "Potion de soins mineure", Level = 1,
			EnergyMin = 70, EnergyMax = 90, PvP = false},
			[2] = { Name = "Pierre de soins mineure", Level = 1,
			EnergyMin = 100, EnergyMax = 120, PvP = false},
			[3] = { Name = "Potion de soins inf\195\169rieure", Level = 3,
			EnergyMin = 140, EnergyMax = 180, PvP = false},
			[4] = { Name = "Potion de soins d\195\169color\195\169e",Level = 5,
			EnergyMin = 140, EnergyMax = 180, PvP = false},
			[5] = { Name = "Potion de soins", Level = 12,
			EnergyMin = 280, EnergyMax = 360, PvP = false},
			[6] = { Name = "Pierre de soins inf\195\169rieure", Level = 12,
			EnergyMin = 250, EnergyMax = 300, PvP = false},
			[7] = { Name = "Potion de soins sup\195\169rieure",Level = 21,
			EnergyMin = 455, EnergyMax = 585, PvP = false},
			[8] = { Name = "Pierre de soins", Level = 24,
			EnergyMin = 500, EnergyMax = 600, PvP = false},
			[9] = { Name = "Potion de soins excellente",Level = 35,
			EnergyMin = 700, EnergyMax = 900, PvP = false},
			[10] = { Name = "Potion de soins de combat", Level = 35,
			EnergyMin = 700, EnergyMax = 900, PvP = false},
			[11] = { Name = "Breuvage de soins excellent",Level = 35,
			EnergyMin = 560, EnergyMax = 720, PvP = true},
			[12] = { Name = "Pierre de soins sup\195\169rieure", Level = 36,
			EnergyMin = 800, EnergyMax = 960, PvP = false},
			[13] = { Name = "Tubercule de navetille", Level = 45,
			EnergyMin = 700, EnergyMax = 900, PvP = false},
			[14] = { Name = "Potion de soins majeure", Level = 45,
			EnergyMin = 1050, EnergyMax = 1750, PvP = false},
			[15] = { Name = "Breuvage de soins majeur", Level = 45,
			EnergyMin = 980, EnergyMax = 1260, PvP = true},
			[16] = { Name = "Pierre de soins majeure", Level = 48,
			EnergyMin = 1200, EnergyMax = 1440, PvP = false},
		};
		
		SERENITY_MOUNT_TABLE = {
			-- [1] Frostwolf Howler Icon
			{ "Cor du hurleur Frostwolf" },
			-- [2] Ram Icon
			{ "Destrier de bataille stormpike", "B\195\169lier noir", "B\195\169lier de guerre noir", "B\195\169lier brun", "B\195\169lier de givre", "B\195\169lier gris", "B\195\169lier blanc", "B\195\169lier blanc rapide", "B\195\169lier brun rapide", "B\195\169lier gris rapide" },
			-- [3] Raptor Icon
			{ "Raptor razzashi rapide", "Raptor bleu rapide", "Raptor vert olive rapide", "Raptor orange rapide", "Sifflet du raptor de guerre noir", "Sifflet de raptor \195\169meraude", "Sifflet de raptor ivoire", "Sifflet de raptor rouge tachet\195\169", "Sifflet de raptor turquoise", "Sifflet de raptor violet" },
			-- [4] Yellow Tiger Icon
			{ "Tigre zulien rapide" },
			-- [5] Undead Horse Icon
			{ "Cheval squelette bleu", "Cheval de guerre squelette bleu", "R\195\170nes de destrier de la mort", "Cheval squelette bai", "Cheval de guerre squelette vert", "Cheval de guerre squelette violet", "Cheval squelette rouge", "Cheval de guerre squelette rouge" },
			-- [6] Mechanostrider Icon
			{ "Trotteur de bataille noir", "M\195\169canotrotteur bleu", "M\195\169canotrotteur vert", "M\195\169canotrotteur bleu clair Mod A", "M\195\169canotrotteur rouge", "M\195\169canotrotteur vert rapide", "M\195\169canotrotteur blanc rapide", "M\195\169canotrotteur jaune rapide", "M\195\169canotrotteur brut", "M\195\169canotrotteur blanc Mod A" },
			-- [7] Brown Horse Icon
			{ "Bride d'\195\169talon noir", "Bride de cheval bai", "Bride de jument alezane", "Bride de palomino", "Bride de pinto", "Palefroi bai rapide", "Palomino rapide", "Palefroi blanc rapide", "Bride d'\195\169talon blanc" },
			-- [8] Brown Kodo Icon
			{ "Kodo de guerre noir", "Kodo brun", "Grand kodo brun" },
			-- [9] War Steed Icon
			{ "Bride de palefroi de guerre noir" },
			-- [10] Gray Kodo Icon
			{ "Kodo gris", "Grand kodo gris", "Grand kodo blanc" },
			-- [11] Green Kodo Icon
			{ "Kodo vert", "Kodo bleu" },
			-- [12] White Wolf Icon
			{ "Cor du loup arctique", "Cor du loup redoutable", "Cor du loup gris rapide", "Cor du loup des bois rapide" },
			-- [13] Black Wolf Icon
			{ "Cor du loup de guerre noir", "Cor du loup brun", "Cor du loup rouge", "Cor du loup brun rapide", "Cor du loup des bois" },
			-- [14] Black Tiger Icon
			{ "R\195\170nes de tigre de guerre noir", "R\195\170nes de sabre-de-nuit ray\195\169" },
			-- [15] White Tiger Icon
			{ "R\195\170nes de sabre-de-givre", "R\195\170nes de sabre-de-nuit", "R\195\170nes de sabre-de-givre tachet\195\169", "R\195\170nes de sabre-de-givre ray\195\169", "R\195\170nes de sabre-de-givre rapide", "R\195\170nes de sabre-de-brume rapide", "R\195\170nes de sabre-temp\195\170te rapide" },
			-- [16] Red Tiger Icon
			{ "R\195\170nes de sabre-de-givre de Berceau-de-l'Hiver" },
			-- [17] Black Qiraji Resonating Crystal
			{ "Cristal de r\195\169sonance qiraji noir" },
		};
		
		SERENITY_MOUNT_PREFIX = {
			"Bride de ",
			"Cor du ",
			"Sifflet de ",
			"R\195\170nes de ",
		};
		
		SERENITY_AQMOUNT_TABLE = {
			"Cristal de r\195\169sonance qiraji bleu",
			"Cristal de r\195\169sonance qiraji vert",
			"Cristal de r\195\169sonance qiraji rouge",
			"Cristal de r\195\169sonance qiraji jaune",
		};
		
		SERENITY_AQMOUNT_NAME = {
			"Invoquer un Tank Qiraji noir",
			"Invoquer un Tank Qiraji bleu",
			"Invoquer un Tank Qiraji vert",
			"Invoquer un Tank Qiraji rouge",
			"Invoquer un Tank Qiraji jaune",
		};
		
		SERENITY_TRANSLATION = {
			["Cooldown"]	= "Recharge",
			["Hearth"]		= "Pierre de foyer",
			["Rank"]		= "Rang",
			["Drink"]		= "Boisson",
			["Dwarf"]		= "Nain",
			["NightElf"]	= "Elfe de la nuit",
			["Human"]		= "Humain",
			["Gnome"]		= "Gnome",
			["Orc"]			= "Orc",
			["Troll"]		= "Troll",
			["Forsaken"]	= "Mort-vivant",
			["Tauren"]		= "Tauren",
		};
end
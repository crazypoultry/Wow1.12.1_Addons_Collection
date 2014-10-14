-- 
-- Localisation for MobInfo
-- 
-- created by Sasmira ( UltimateUI Team )
-- and Halrik
--
-- Last Update : 09/09/2005 by Sasmira
-- 

-- 
-- French localization
-- 

if ( GetLocale() == "frFR" ) then

miSkinLoot = { };
miSkinLoot["Lani\195\168res de cuir d\195\169chir\195\169es"]=1;
miSkinLoot["Cuir L\195\169ger"]=1;
miSkinLoot["Cuir moyen"]=1;
miSkinLoot["Cuir lourd"]=1;
miSkinLoot["Cuir \195\169pais"]=1;
miSkinLoot["Cuir grossier"]=1;

miSkinLoot["Peau l\195\169g\195\168re"]=1;
miSkinLoot["Peau moyenne"]=1;
miSkinLoot["Peau lourde"]=1;
miSkinLoot["Peau \195\169paisse"]=1;
miSkinLoot["Peau rugueuse"]=1;

miSkinLoot["Cuir de Chim\195\168re"]=1;
miSkinLoot["Cuir de Diablosaure"]=1;
miSkinLoot["Cuir de Dent de sabre blanc"]=1;
miSkinLoot["Cuir de grand Ours"]=1;

miClothLoot = { };
miClothLoot["Tissu en lin"]=1;
miClothLoot["Tissu en laine"]=1;
miClothLoot["Etoffe de soie"]=1;
miClothLoot["Tissu de mage"]=1;
miClothLoot["Etoffe corrompue"]=1;
miClothLoot["Etoffe runique"]=1;

MI_DESCRIPTION = "Ajoute une pr\195\169cision d\'information sur un monstre dans la bulle d\'aide";

MI_MOB_DIES_WITH_XP = "(.+) succombe, vous gagnez (%d+) points d\'exp\195\169rience";
MI_MOB_DIES_WITHOUT_XP = " meurt";
MI_PARSE_SPELL_DMG = "(.+) de (.+) vous inflige (%d+) points de d\195\169g\195\162ts";
MI_PARSE_COMBAT_DMG = "(.+) vous touche et inflige (%d+) points de d\195\169g\195\162ts";

MI_TXT_GOLD = " Or";
MI_TXT_SILVER = " Argent";
MI_TXT_COPPER = " Cuivre";

MI_TXT_CLASS = "Classe ";
MI_TXT_HEALTH = "Vie ";
MI_TXT_KILLS = "Nbre de fois tu\195\169 ";
MI_TXT_DAMAGE = "Dommages ";
MI_TXT_TIMES_LOOTED = "Nbre de fois loot\195\169 ";
MI_TXT_EMPTY_LOOTS = "Loots vides ";
MI_TXT_TO_LEVEL = "# pour level ";
MI_TXT_QUALITY = "Qualit\195\169 ";
MI_TXT_CLOTH_DROP = "Tissu ramass\195\169 ";
MI_TXT_COIN_DROP = "Argent Moyen ";
MI_TEXT_ITEM_VALUE = "Valeur Moyenne ";
MI_TXT_MOB_VALUE = "Valeur Totale ";
MI_TXT_COMBINED = "Combin\195\169:";

MI_TXT_CONFIG_TITLE = "MobInfo-2 Options";

MI2_FRAME_TEXTS = {};
MI2_FRAME_TEXTS["MI2_FrmTooltipOptions"] = "Tooltip Options";
MI2_FRAME_TEXTS["MI2_FrmGeneralOptions"] = "General Options";
MI2_FRAME_TEXTS["MI2_FrmHealthOptions"] = "Mob Health Options";

--
-- This section defines all buttons in the options dialog
-- text : the text displayed on the button
-- cmnd : the command which is executed when clicking the button
-- cmnd must not be given for the translated texts
-- help : the (short) one line help text for the button
-- info : additional multi line info text for button
-- info is displayed in the help tooltip below the "help" line
-- info is optional and can be omitted if not required
--

MI2_OPTIONS["MI2_OptShowClass"] =
{ text = "Voir: Classes"; cmnd = "showclass"; help = "Affiche la classe de la cible"; }

MI2_OPTIONS["MI2_OptShowHealth"] =
{ text = "Voir: Vie"; cmnd = "showhealth"; help = "Affiche la vie de la cible (en cours/max)"; }

MI2_OPTIONS["MI2_OptShowDamage"] =
{ text = "Voir: Zone d\'effet"; cmnd = "showdamage"; help = "Affiche la zone d\'effet des dommages (Min/Max)";
info = "La zone d\'effet est calcul\195\169e/stock\195\169e \ns\195\169par\195\169ment par personnage." }

MI2_OPTIONS["MI2_OptShowCombined"] = 
  { text = "Show Combined Info"; cmnd = "showcombined";  help = "Show combined mode message in tooltip";
    info = "Show a mesage in the tooltip indicating that combined mode\nis active and listing all mob levels that have been combined\ninto one tooltip." }
  
MI2_OPTIONS["MI2_OptShowKills"] =
{ text = "Voir: Nbre de fois tu\195\169"; cmnd = "showkills"; help = "Affiche le nombre de fois que le m\195\170me mob a \195\169t\195\169 tu\195\169";
info = "le nombre de mort est calcul\195\169/stock\195\169 \ns\195\169par\195\169ment par personnage." }

MI2_OPTIONS["MI2_OptShowLoots"] =
{ text = "Voir: Nbre de fois loot\195\169"; cmnd = "showloots"; help = "Affiche le nombre de fois que le mob a \195\169t\195\169 loott\195\169"; }

MI2_OPTIONS["MI2_OptShowEmpty"] =
{ text = "Voir: Loots vides"; cmnd = "showempty"; help = "Affiche le nombre de loots vides trouv\195\169s(nbre/%tage)";
info = "Le compteur augmente lorsque vous ouvrez \n un corp sans loot." }

MI2_OPTIONS["MI2_OptShowXp"] =
{ text = "Voir: Exp\195\169rience"; cmnd = "showxp"; help = "Affiche le nombre de point d\'exp\195\169rience qu\'un mob donne";
info = "C\'est actuellement la derni\195\168re valeur qui s\'affiche. \n(Ne s\'affiche pas lorsque les mobs sont gris pour vous)" }

MI2_OPTIONS["MI2_OptShowNo2lev"] =
{ text = "Voir: Nbre de mobs pour level"; cmnd = "showno2lev"; help = "Affiche le nombre de mobs restant \195\160 tuer pour changer de niveau";
info = "Ne s\'affiche pas lorsque les mobs sont gris pour vous" }

MI2_OPTIONS["MI2_OptShowQuality"] =
{ text = "Voir: Qualit\195\169 du Butin"; cmnd = "showquality"; help = "Affiche la qualit\195\169 du loot en nombre et pourcentage";
info = "Le compteur indique la quantit\195\169 en fonction des 5 cat\195\169gories de raret\195\169" }

MI2_OPTIONS["MI2_OptShowCloth"] =
{ text = "Voir: Tissu ramass\195\169"; cmnd = "showcloth"; help = "Affiche le nombre de tissu ramass\195\169"; }

MI2_OPTIONS["MI2_OptShowCoin"] =
{ text = "Voir: Moyenne Argent ramass\195\169"; cmnd = "showcoin"; help = "Affiche la moyenne d\'Argent ramass\195\169e par Mob";
info = "La valeur totale est cumul\195\169e et divis\195\169e \npar le nombre de loot.\n(Ne s\'affiche pas si le compte est de z\195\169ro)" }

MI2_OPTIONS["MI2_OptShowIV"] =
{ text = "Voir: Valeur Moyenne des objets"; cmnd = "showiv"; help = "Affiche valeur moyenne des objets par Mob";
info = "La valeur totale est cumul\195\169e et divis\195\169e \npar le nombre de loot.\n(Ne s\'affiche pas si le compte est de z\195\169ro)" }

MI2_OPTIONS["MI2_OptShowTotal"] =
{ text = "Voir: Valeur Totale des monstres"; cmnd = "showtotal"; help = "Affiche la moyenne de la valeur totale des monstres";
info = "C\'est la moyenne de la valeur totale \nde l\'Argent et des objets." }

MI2_OPTIONS["MI2_OptShowBlankLines"] =
{ text = "Voir: ligne blanche"; cmnd = "showblanklines"; help = "Affiche une ligne blanche dans la bulle d\'aide";
info = "" }

MI2_OPTIONS["MI2_OptSaveAllValues"] =
{ text = "Sauver toutes les valeurs"; cmnd = "saveallvalues"; help = "Toujours sauver la base de donn\195\169es de tous les monstres";
info = "" }

MI2_OPTIONS["MI2_OptCombinedMode"] =
{ text = "Regrouper les m\195\170mes monstres"; cmnd = "combinedmode"; help = "Regroupe les donn\195\169es des monstres de m\195\170me nom";
info = "Regroupe les donn\195\169es des monstres de m\195\170me nom \nmais de niveaux diff\195\169rents dans la bulle d\'aide" }

MI2_OPTIONS["MI2_OptKeypressMode"] =
{ text = "ALT pour voir MobInfo"; cmnd = "keypressmode"; help = "MobInfo s\'affiche uniquement dans la bulle d\'aide lorsque la touche ALT est press\195\169e"; }

MI2_OPTIONS["MI2_OptClearOnExit"] =
{ text = "Suppr. les Data \195\160 la D\195\169co"; cmnd = "clearonexit"; help = "Suppression des entr\195\169es dans la base de donn\195\169es lorsque l\'on quitte le jeu"; }

MI2_OPTIONS["MI2_OptDisableHealth"] =
{ text = "Arr\195\170t de MobHealth"; cmnd = "disablehealth"; help = "Arr\195\170te toutes les fonctions de Mob health";
info = "L\'int\195\169gration de MobHealth dans MobInfo peut \195\170tre \nenti\195\168rement arret\195\169e. Ceci est n\195\69cessaire \nlorsque l\'on utilise un MobHealth externe"; }

MI2_OPTIONS["MI2_OptStableMax"] =
{ text = "Affichage stable des PV max"; cmnd = "stablemax"; help = "Affichage stable des PV max dans votre Fen\195\170tre Cible";
info = "Actualise les PV Max du monstre moins souvent \n(seulement au premier combat avec le monstre et entre les batailles)."; }

MI2_OPTIONS["MI2_OptShowPercent"] = 
  { text = "Show percent for health and mana"; cmnd = "showpercent";  help = "Add percentage to health/mana in target frame"; }
  
MI2_OPTIONS["MI2_OptHealthPosX"] = 
  { text = "Horizontal Position"; cmnd = "healthposx";  help = "Adjust horizontal position of health/mana in target frame"; }

MI2_OPTIONS["MI2_OptHealthPosY"] = 
  { text = "Vertical Position"; cmnd = "healthposy";  help = "Adjust vertical position of health/mana in target frame"; }

MI2_OPTIONS["MI2_OptManaDistance"] = 
  { text = "Mana Distance"; cmnd = "manadistance";  help = "Adjust distance of health/mana in target frame"; }

MI2_OPTIONS["MI2_OptAllOn"] =
{ text = "Tous ON"; cmnd = "allon"; help = "Toutes les options de MobInfo sont activ\195\169es"; }

MI2_OPTIONS["MI2_OptAllOff"] =
{ text = "Tous OFF"; cmnd = "alloff"; help = "Toutes les options de MobInfo sont d\195\169sactiv\195\169es"; }

MI2_OPTIONS["MI2_OptMinimal"] =
{ text = "Minimum"; cmnd = "minimal"; help = "Affiche les options minimales"; }

MI2_OPTIONS["MI2_OptDefault"] =
{ text = "D\195\169faut"; cmnd = "default"; help = "Affiche les options par d\195\169faut de MobInfo"; }

MI2_OPTIONS["MI2_OptBtnDone"] =
{ text = "Appliquer"; cmnd = ""; help = "Ferme la fen\195\170tre des Options de MobInfo"; }

end

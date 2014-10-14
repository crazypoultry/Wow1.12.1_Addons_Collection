-- Version : French (by Verdhit of Eitrigg)
-- Last Update : 3/12/2006

if( GetLocale() == "frFR" ) then
-- Binding Configuration
BINDING_HEADER_ARMORCRAFT = "ArmorCraft";
BINDING_NAME_ARMORCRAFTFRAME = "Activer Fenetre ArmorCraft";

-- Armor types
AC_CLOTH = 'Tissu';
AC_LEATHER = 'Cuir';
AC_MAIL = 'Mailles';
AC_PLATE = 'Plaques';
AC_SHIELD = 'Bouclier';
AC_SHIELDS = 'Boucliers';

-- Player classes
AC_DRUID = 'Druide';
AC_HUNTER = 'Chasseur';
AC_MAGE = 'Mage';
AC_PALADIN = 'Paladin';
AC_PRIEST = 'Pr\195\170tre';
AC_ROGUE = 'Voleur';
AC_SHAMAN = 'Chaman';
AC_WARLOCK = 'D\195\169moniste';
AC_WARRIOR = 'Guerrier';

-- Mappings
AC_SMITHING = 'Forge';
AC_LEATHERWORKING= 'Travail du cuir'; -- Lederarbeiten?
AC_TAILORING = 'Couture';
AC_ENGINEERING = 'Ing\195\169nieur';
ArmorCraft_Types = {AC_CLOTH,AC_LEATHER,AC_SHIELD,AC_MAIL,AC_PLATE};
ArmorCraft_TS = {[AC_SMITHING]=AC_MAIL, [AC_LEATHERWORKING]=AC_LEATHER,
                [AC_TAILORING]=AC_CLOTH, [AC_ENGINEERING]=AC_CLOTH};
ArmorCraft_Class = {[AC_MAGE]=AC_CLOTH; [AC_PRIEST]=AC_CLOTH; [AC_WARLOCK]=AC_CLOTH;
                [AC_DRUID]=AC_LEATHER; [AC_ROGUE]=AC_LEATHER; [AC_HUNTER]=AC_LEATHER;
                [AC_SHAMAN]=AC_LEATHER; [AC_PALADIN]=AC_MAIL; [AC_WARRIOR]=AC_MAIL};
ArmorCraft_Class2 = {[AC_HUNTER]=AC_MAIL; [AC_SHAMAN]=AC_MAIL; [AC_PALADIN]=AC_PLATE; [AC_WARRIOR]=AC_PLATE};
ArmorCraft_Dual = {[AC_HUNTER]=20; [AC_ROGUE]=10; [AC_WARRIOR]=20}

-- Armor location names and IDs
AC_MAIN = 'Main droite';
AC_ONE = 'A une main';
AC_TWO = 'A deux mains';
AC_OFF = 'Main gauche';
AC_HELD = 'Tenu(e) en main gauche';
AC_RANGED = 'A distance';
AC_BACK = 'Dos';
AC_NECK = 'Cou';
AC_FINGER = 'Doigt';
AC_TRINKET= 'Bijou';
AC_HANDS = 'Mains';
AC_HEAD = 'T\195\170te';
AC_SHOULDER = 'Epaule';
AC_CHEST = 'Torse';
AC_WRIST = 'Poignets';
AC_WAIST = 'Taille';
AC_LEGS = 'Jambes';
AC_FEET = 'Pieds';
ArmorCraft_Loc = {[AC_HEAD]={slot='HeadSlot',ID=1}; [AC_SHOULDER]={slot='ShoulderSlot',ID=2}; [AC_BACK]={slot='BackSlot',ID=3};
        [AC_CHEST]={slot='ChestSlot',ID=4}; [AC_WRIST]={slot='WristSlot',ID=5}; [AC_HANDS]={slot='HandsSlot',ID=6};
        [AC_WAIST]={slot='WaistSlot',ID=7}; [AC_LEGS]={slot='LegsSlot',ID=8}; [AC_FEET]={slot='FeetSlot',ID=9};
        [AC_MAIN]={slot='MainHandSlot',ID=10}; [AC_OFF]={slot=AC_SHSLOT}; [AC_HELD]={slot=AC_SHSLOT};
        [AC_RANGED]={slot='RangedSlot',ID=11}; [AC_TRINKET]={slot='Trinket0Slot',slot1='Trinket1Slot'};
        [AC_NECK]={slot='NeckSlot'}; [AC_FINGER]={slot='Finger0Slot',slot1='Finger1Slot'}; }

-- Armor attribute values
AC_OTHER = 'Autres'; -- Anderes?
ArmorCraft_Attr = {[AC_MAGE]={ Agilit=3, Intelligence=3, Esprit=3, Endurance=3, Force=1, [AC_OTHER]=1 };
        [AC_PRIEST]={ Agilit=3, Intelligence=3, Esprit=3, Endurance=3, Force=1, [AC_OTHER]=1 };
        [AC_WARLOCK]={ Agilit=3, Intelligence=3, Esprit=2, Endurance=2, Force=1, [AC_OTHER]=1 };
        [AC_DRUID]={ Agilit=4, Intelligence=2, Esprit=3, Endurance=3, Force=2, [AC_OTHER]=1 };
        [AC_ROGUE]={ Agilit=7, Intelligence=1, Esprit=2, Endurance=3, Force=3, [AC_OTHER]=1 };
        [AC_HUNTER]={ Agilit=6, Intelligence=2, Esprit=2, Endurance=2, Force=2, [AC_OTHER]=1 };
        [AC_SHAMAN]={ Agilit=4, Intelligence=2, Esprit=3, Endurance=3, Force=3, [AC_OTHER]=1 };
        [AC_PALADIN]={ Agilit=5, Intelligence=2, Esprit=2, Endurance=3, Force=4, [AC_OTHER]=1 };
        [AC_WARRIOR]={ Agilit=5, Intelligence=1, Esprit=1, Endurance=3, Force=4, [AC_OTHER]=1 }}

-- Item use text
AC_ENG = 'Ing\195\169nieur';
AC_ARMOR = 'Armure';
AC_WEAPON = 'Armes';
AC_MELEE = 'M\195\169\l\195\169\e';
AC_GUN = 'A distance';
AC_GUNS = 'Munitions';
AC_MISC = 'Divers';
AC_FISH = 'Canne \195\160 p\195\170che';
AC_BOWS = 'Arc';
AC_CROSSBOWS = 'Arbalette';
AC_WANDS = 'Baguette';
AC_1H = {f='A une main',r='1-H'};
AC_2H = {f='Deux mains',r='2-H'};
AC_SHOOT = {[AC_HUNTER]=1; [AC_ROGUE]=1; [AC_WARRIOR]=1}
AC_MAGIC = {[AC_MAGE]=1; [AC_PRIEST]=1; [AC_WARLOCK]=1}
ArmorCraft_Ranged = {[AC_BOWS]=AC_SHOOT; [AC_CROSSBOWS]=AC_SHOOT; [AC_GUNS]=AC_SHOOT; [AC_WANDS]=AC_MAGIC}
ArmorCraft_Melee = {["Haches \195\165 une main"]={[AC_HUNTER]=1; [AC_PALADIN]=1; [AC_SHAMAN]=1; [AC_WARRIOR]=1};
    ["Haches \195\160 deux mains"]={[AC_HUNTER]=2; [AC_PALADIN]=2; [AC_WARRIOR]=2};
    ["Masses \195\160 une main"]={[AC_DRUID]=1; [AC_PALADIN]=1; [AC_PRIEST]=1; [AC_ROGUE]=1; [AC_SHAMAN]=1; [AC_WARRIOR]=1};
    ["Masses \195\160 deux mains"]={[AC_DRUID]=2; [AC_PALADIN]=2; [AC_WARRIOR]=2};
    ["Armes d\'hast"]={[AC_HUNTER]=2; [AC_PALADIN]=2; [AC_WARRIOR]=2};
    ["Ep\195\169es \195\160 une main"]={[AC_HUNTER]=1; [AC_MAGE]=1; [AC_PALADIN]=1; [AC_ROGUE]=1; [AC_WARLOCK]=1; [AC_WARRIOR]=1};
    ["Ep\195\169es \195\160 deux mains"]={[AC_HUNTER]=2; [AC_PALADIN]=2; [AC_WARRIOR]=2};
    ["Batons"]={[AC_DRUID]=2; [AC_HUNTER]=2; [AC_MAGE]=2; [AC_PRIEST]=2; [AC_SHAMAN]=2; [AC_WARLOCK]=2; [AC_WARRIOR]=2};
    ["Mains nues"]={[AC_DRUID]=1; [AC_HUNTER]=1; [AC_ROGUE]=1; [AC_SHAMAN]=1; [AC_WARRIOR]=1};
    ["Dagues"]={[AC_DRUID]=1; [AC_HUNTER]=1; [AC_MAGE]=1; [AC_PRIEST]=1;
                [AC_ROGUE]=1; [AC_SHAMAN]=1; [AC_WARLOCK]=1; [AC_WARRIOR]=1} }

-- Messages
ARMORCRAFT_NOWINDOW = "Aucune fenetre de craft ouverte.";
ARMORCRAFT_NOTARMOR = " Ne permet pas de fabriquer des armures.";
ARMORCRAFT_BADLEVEL = "Le niveau doit etre compris entre 1 et 60.";
ARMORCRAFT_NOSELECT = "Pas de selection pour ";
ARMORCRAFT_NOCLASS = "Pas de classe choisie";
ARMORCRAFT_NOITEM = "Aucun objet selectionne";
ARMORCRAFT_CLASS = "Valeur des attributs pour la classe %s.";
ARMORCRAFT_RESET = " Reset";
ARMORCRAFT_EMPTY = "Table des valeurs vide";
ARMORCRAFT_BADFORMAT= "Mauvais format de valeur: ";
ARMORCRAFT_UNDEFINED= "Nom inconnu: ";
ARMORCRAFT_WRONG = "Mauvais type d objet a comparer";
ARMORCRAFT_ACTIP = "Cliquer pour ouvrir la fenetre ArmorCraft";
ARMORCRAFT_USETIP = "Cliquer pour comparer les objets selectionnes";
ARMORCRAFT_PARTYTIP = "Cliquer pour changer de personnage";
AC_PARTY = "Groupe";
AC_LEVEL = "Niveau";
AC_CLASS = "Classe";
AC_SELECT = "Selection\195\169";

-- Tooltip Scan text
ARMORCRAFT_BOE = "Li\195\169 quand \195\169quip\195\169";
ARMORCRAFT_BOP = "Li\195\169 quand ramass\195\169";
ARMORCRAFT_SOULBOUND= "Li\195\169";
ARMORCRAFT_UNIQUE = "Unique";
ARMORCRAFT_ARMOR = "Armure : (%d+)";
ARMORCRAFT_REQUIRES = "Niveau (%d+) requis";
ARMORCRAFT_DPS = "%((%d+%.%d) d\195\169g\195\162ts par seconde%)"
end
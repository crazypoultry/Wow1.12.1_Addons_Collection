-- Version : German (by StarDust, Sheena-Tiger, Logripper and Twyll)
-- Last Update : 12/15/2005

if( GetLocale() == "deDE" ) then
    -- Binding Configuration
    BINDING_HEADER_ARMORCRAFT    = "ArmorCraft";
    BINDING_NAME_ARMORCRAFTFRAME = "Schaltet ArmorCraft Fenster";

    -- Armor types
    AC_CLOTH = 'Stoff';
    AC_LEATHER = 'Leder';
    AC_MAIL  = 'Schwere R\195\188stung';
    AC_PLATE = 'Platte';
    AC_SHIELD  = 'Schild';
    AC_SHIELDS = 'Schilde';

    -- Player classes
    AC_DRUID   = 'Druide';
    AC_HUNTER  = 'J\195\164ger';
    AC_MAGE    = 'Magier';
    AC_PALADIN = 'Paladin';
    AC_PRIEST  = 'Priester';
    AC_ROGUE   = 'Schurke';
    AC_SHAMAN  = 'Schamane';
    AC_WARLOCK = 'Hexenmeister';
    AC_WARRIOR = 'Krieger';

    -- Mappings
    AC_SMITHING = 'Schmiedekunst';
    AC_LEATHERWORKING= 'Lederverarbeitung';
    AC_TAILORING = 'Schneiderei';
    AC_ENGINEERING = 'Ingenieurskunst';
    ArmorCraft_Types = {AC_CLOTH,AC_LEATHER,AC_SHIELD,AC_MAIL,AC_PLATE};
    ArmorCraft_TS = {[AC_SMITHING]=AC_MAIL, [AC_LEATHERWORKING]=AC_LEATHER,
                     [AC_TAILORING]=AC_CLOTH, [AC_ENGINEERING]=AC_CLOTH};
    ArmorCraft_Class = {[AC_MAGE]=AC_CLOTH; [AC_PRIEST]=AC_CLOTH; [AC_WARLOCK]=AC_CLOTH;
                        [AC_DRUID]=AC_LEATHER; [AC_ROGUE]=AC_LEATHER; [AC_HUNTER]=AC_LEATHER;
                        [AC_SHAMAN]=AC_LEATHER; [AC_PALADIN]=AC_MAIL; [AC_WARRIOR]=AC_MAIL};
    ArmorCraft_Class2 = {[AC_HUNTER]=AC_MAIL; [AC_SHAMAN]=AC_MAIL; [AC_PALADIN]=AC_PLATE; [AC_WARRIOR]=AC_PLATE};
    ArmorCraft_Dual = {[AC_HUNTER]=20; [AC_ROGUE]=10; [AC_WARRIOR]=20}

    -- Armor location names and IDs
    AC_MAIN = 'Waffenhand';
    AC_ONE = 'Einh\195\164ndig';
    AC_TWO = 'Zweih\195\164ndig';
    AC_OFF = 'Schildhand';
    AC_HELD = 'In Schildhand gef\195\188hrt';
    AC_RANGED = 'Distanz';
    AC_BACK = 'R\195\188cken';
    AC_NECK = 'Hals';
    AC_FINGER = 'Finger';
    AC_TRINKET= 'Schmuck';
    AC_HANDS = 'H\195\164nde';
    AC_HEAD = 'Kopf';
    AC_SHOULDER = 'Schulter';
    AC_CHEST = 'Brust';
    AC_WRIST = 'Handgelenke';
    AC_WAIST = 'Taille';
    AC_LEGS = 'Beine';
    AC_FEET = 'F\195\188\195\159e';
    ArmorCraft_Loc = {[AC_HEAD]={slot='HeadSlot',ID=1}; [AC_SHOULDER]={slot='ShoulderSlot',ID=2}; [AC_BACK]={slot='BackSlot',ID=3};
    [AC_CHEST]={slot='ChestSlot',ID=4}; [AC_WRIST]={slot='WristSlot',ID=5}; [AC_HANDS]={slot='HandsSlot',ID=6};
    [AC_WAIST]={slot='WaistSlot',ID=7}; [AC_LEGS]={slot='LegsSlot',ID=8}; [AC_FEET]={slot='FeetSlot',ID=9};
    [AC_MAIN]={slot='MainHandSlot',ID=10}; [AC_OFF]={slot=AC_SHSLOT}; [AC_HELD]={slot=AC_SHSLOT};
    [AC_RANGED]={slot='RangedSlot',ID=11}; [AC_TRINKET]={slot='Trinket0Slot',slot1='Trinket1Slot'};
    [AC_NECK]={slot='NeckSlot'}; [AC_FINGER]={slot='Finger0Slot',slot1='Finger1Slot'}; };

    -- Armor attribute values
    AC_OTHER = 'Andere'; -- Anderes?
    ArmorCraft_Attr = {[AC_MAGE]={ Agility=3, Intellect=3, Spirit=3, Stamina=3, Strength=1, [AC_OTHER]=1 };
                     [AC_PRIEST]={ Agility=3, Intellect=3, Spirit=3, Stamina=3, Strength=1, [AC_OTHER]=1 };
                    [AC_WARLOCK]={ Agility=3, Intellect=3, Spirit=2, Stamina=2, Strength=1, [AC_OTHER]=1 };
                      [AC_DRUID]={ Agility=4, Intellect=2, Spirit=3, Stamina=3, Strength=2, [AC_OTHER]=1 };
                      [AC_ROGUE]={ Agility=7, Intellect=1, Spirit=2, Stamina=3, Strength=3, [AC_OTHER]=1 };
                     [AC_HUNTER]={ Agility=6, Intellect=2, Spirit=2, Stamina=2, Strength=2, [AC_OTHER]=1 };
                     [AC_SHAMAN]={ Agility=4, Intellect=2, Spirit=3, Stamina=3, Strength=3, [AC_OTHER]=1 };
                    [AC_PALADIN]={ Agility=5, Intellect=2, Spirit=2, Stamina=3, Strength=4, [AC_OTHER]=1 };
                    [AC_WARRIOR]={ Agility=5, Intellect=1, Spirit=1, Stamina=3, Strength=4, [AC_OTHER]=1 }}

    -- Item use text
    AC_ENG = 'Ingenieurskunst';
    AC_ARMOR = 'R\195\188stung';
    AC_WEAPON = 'Waffe';
    AC_MELEE = 'Nahkampf';
    AC_GUN = 'Schusswaffe';
    AC_GUNS = 'Schusswaffen';
    AC_MISC = 'Sonstiges';
    AC_FISH = 'Angelruten';
    AC_BOWS = 'B\195\182gen';
    AC_CROSSBOWS = 'Armbr\195\188ste';
    AC_WANDS = 'St\195\164be';
    AC_1H = {f='Einh\195\164ndig',r='1-H'};
    AC_2H = {f='Zweih\195\164ndig',r='2-H'};
    AC_SHOOT = {[AC_HUNTER]=1; [AC_ROGUE]=1; [AC_WARRIOR]=1}
    AC_MAGIC = {[AC_MAGE]=1; [AC_PRIEST]=1; [AC_WARLOCK]=1}
    ArmorCraft_Ranged = {[AC_BOWS]=AC_SHOOT; [AC_CROSSBOWS]=AC_SHOOT; [AC_GUNS]=AC_SHOOT; [AC_WANDS]=AC_MAGIC}
    ArmorCraft_Melee = {["Einhand\195\164xte"]={[AC_HUNTER]=1; [AC_PALADIN]=1; [AC_SHAMAN]=1; [AC_WARRIOR]=1};
        ["Zweihand\195\164xte"]={[AC_HUNTER]=2; [AC_PALADIN]=2; [AC_WARRIOR]=2};
        ["Einhandstreitkolben"]={[AC_DRUID]=1; [AC_PALADIN]=1; [AC_PRIEST]=1; [AC_ROGUE]=1; [AC_SHAMAN]=1; [AC_WARRIOR]=1};
        ["Zweihandstreitkolben"]={[AC_DRUID]=2; [AC_PALADIN]=2; [AC_WARRIOR]=2};
        ["Angelruten"]={[AC_HUNTER]=2; [AC_PALADIN]=2; [AC_WARLOCK]=2};
        ["Einhandschwerter"]={[AC_HUNTER]=1; [AC_MAGE]=1; [AC_PALADIN]=1; [AC_ROGUE]=1; [AC_WARLOCK]=1; [AC_WARRIOR]=1};
        ["Zweihandschwerter"]={[AC_HUNTER]=2; [AC_PALADIN]=2; [AC_WARRIOR]=2};
        ["St\195\164be"]={[AC_DRUID]=2; [AC_HUNTER]=2; [AC_MAGE]=2; [AC_PRIEST]=2; [AC_SHAMAN]=2; [AC_WARLOCK]=2; [AC_WARRIOR]=2};
        ["Erste Waffen"]={[AC_DRUID]=1; [AC_HUNTER]=1; [AC_ROGUE]=1; [AC_SHAMAN]=1; [AC_WARRIOR]=1};
        ["Dolche"]={[AC_DRUID]=1; [AC_HUNTER]=1; [AC_MAGE]=1; [AC_PRIEST]=1;
                    [AC_ROGUE]=1; [AC_SHAMAN]=1; [AC_WARLOCK]=1; [AC_WARRIOR]=1} }

    -- Messages
    ARMORCRAFT_NOWINDOW = "Kein Berufsfenster ge\195\182ffnet.";
    ARMORCRAFT_NOTARMOR = " stellt keine R\195\188stungen her.";
    ARMORCRAFT_BADLEVEL = "Level muss zwischen 1 and 60 liegen.";
    ARMORCRAFT_NOSELECT = "Keine Auswahl f\195\188r ";
    ARMORCRAFT_NOCLASS = "Keine Charakterklasse ausgew\195\164hlt.";
    ARMORCRAFT_NOITEM = "Nichts zum Herstellen ausgew\195\164hlt.";
    ARMORCRAFT_CLASS = "Attributwerte f\195\188r Klasse %s.";
    ARMORCRAFT_RESET = " Wert zur\195\188ckgesetzt.";
    ARMORCRAFT_EMPTY = "Die Werteliste der Gegenst\195\164nde ist leer.";
    ARMORCRAFT_BADFORMAT= "Falsches Wert-Format: ";
    ARMORCRAFT_UNDEFINED= "Unbekannter Name: ";
    ARMORCRAFT_WRONG = "Falscher Gegenstandstyp zum Vergleich.";
    ARMORCRAFT_ACTIP = "Klicken, um das ArmorCraft Fenster\nanzuzeigen/zu verbergen.";
    ARMORCRAFT_USETIP = "Klicken, um den ausgew\195\164hlten\nGegenstand zu vergleichen.";
    ARMORCRAFT_PARTYTIP = "Klicken, um Gruppenmitglieder\nanzuzeigen/zu verbergen.";
    AC_PARTY = "Gruppe";
    AC_LEVEL = "Level";
    AC_CLASS = "Klasse";
    AC_SELECT = "Ausw\195\164hlen";

    -- Tooltip Scan text
    ARMORCRAFT_BOE      = "Wird beim Anlegen gebunden";
    ARMORCRAFT_BOP      = "Wird beim Aufheben gebunden."
    ARMORCRAFT_SOULBOUND= "Seelengebunden"
    ARMORCRAFT_UNIQUE   = "Einzigartig"
    ARMORCRAFT_ARMOR    = "(%d+) R\195\188stung";
    ARMORCRAFT_REQUIRES = "Ben\195\182tigt Stufe (%d+)";
    ARMORCRAFT_DPS = "^%((%d+%.%d) Schaden pro Sekunde%)";
end

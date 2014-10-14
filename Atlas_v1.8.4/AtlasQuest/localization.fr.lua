if ( GetLocale() == "frFR" ) then -- DO NOT REMOVE THIS LINE!!!!

------------ TEXT VARIABLEN
--Color
local GREY = "|cff999999";
local RED = "|cffff0000";
local REDA = "|cffcc6666";
local WHITE = "|cffFFFFFF";
local GREEN = "|cff1eff00";
local PURPLE = "|cff9F3FFF";
local BLUE = "|cff0070dd";
local ORANGE = "|cffFF8400";
local YELLOW = "|cffffff00";

--*********************
-- Options translation
--*********************
AQHelpText = ""..WHITE.."tapez /aq ou atlasquest "..YELLOW.."[command]"..WHITE.."\ncommandes: help; option/config; show/hide; left/right; colour; autoshow"..RED.."(Atlas uniquement)"
--
AQOptionsCaptionTEXT = "AtlasQuest Option";
AQ_OK = "OK"
-- autoshow
AQOptionsAutoshowTEXT = ""..WHITE.."Afficher AtlasQuest avec "..RED.."Atlas"..WHITE..".";
AQAtlasAutoON = "AtlasQuest sera d\195\169sormais automatiquement affich\195\169 quand vous ouvrez atlas"..GREEN.."(default)"
AQAtlasAutoOFF = "AtlasQuest "..RED.."ne sera pas"..WHITE.." affich\195\169 quand vous ouvrez atlas"
-- right/left
AQOptionsLEFTTEXT = ""..WHITE.."Montrer AtlasQuest  "..RED.." \195\160 gauche"..WHITE..".";
AQOptionsRIGHTTEXT = ""..WHITE.."Montrer AtlasQuest  "..RED.."\195\160 droite"..WHITE..".";
AQShowRight = "AtlasQuest s\'affichera "..RED.."\195\160 droite";
AQShowLeft = "AtlasQuest s\'affichera"..RED.."\195\160 gauche"..GREEN.."(default)";
-- Colour Check
AQOptionsCCTEXT = ""..WHITE.."Colorer les qu\195\170tes en fonction du niveau de la qu\195\170te."
AQCCON = "AtlasQuest colorera d\195\169sormais la qu\195\170te en fonction du niveau de la qu\195\170te."
AQCCOFF = "AtlasQuest Ne colorera Plus d\195\169sormais la qu\195\170te en fonction du niveau de la qu\195\170te."


AQFinishedTEXT = "Qu\195\170tes finies: ";
AQSERVERASKInformation = " Clic droit jusqu\'\195\160 l\'apparition de l\'image de l\'objet."
AQSERVERASK = "Interroger le serveur pour: "
AQOptionB = "Options"
AQStoryB = "Histoire"
AQNoReward = "Pas de r\195\169compense"
AQERRORNOTSHOWN = "L\'objet n'est pas s\195\187r !"
AQERRORASKSERVER = "Clic Droit pour tenter d\'interroger le serveur. Cela peut vous d\195\169connecter."
AQDiscription_OR = "|cffff0000 ou "..WHITE..""
AQDiscription_AND = "|cff008000 et "..WHITE..""
AQDiscription_REWARD = "R\195\169compense: "
AQDiscription_ATTAIN = "Attain: "
AQDiscription_LEVEL = "Niveau: "
AQDiscription_START = "Commence \195\160: \n"
AQDiscription_AIM = "Objet: \n"
AQDiscription_NOTE = "Note: \n"
AQDiscription_PREQUEST= "Pr\195\169requis: "
AQDiscription_FOLGEQUEST = "M\195\168ne vers: "
ATLAS_VERSIONWARNINGTEXT = "Votre Atlas est hors d'\195\162ge! Faites une mise \195\160 jour :) (la derni\195\168re version est la 1.8.1)"

-- ITEM TRANSLATION
AQITEM_DAGGER = " Dague"
AQITEM_SWORD = " Ep\195\169e"
AQITEM_AXE = " Hache"
AQITEM_WAND = "Baguette"
AQITEM_STAFF = "B\195\162ton"
AQITEM_MACE = " Mace"
AQITEM_SHIELD = "Bouclier"
AQITEM_MACE = "Mace"
AQITEM_GUN = "Fusil"
AQITEM_BOW = "Arc"

AQITEM_WAIST = "Ceinture,"
AQITEM_SHOULDER = "Epaule,"
AQITEM_CHEST = "Torse,"
AQITEM_LEGS = "Jambes,"
AQITEM_HANDS = "Mains,"
AQITEM_FEET = "Pieds,"
AQITEM_WRIST = "Poignet,"
AQITEM_HEAD = "T\195\170te,"
AQITEM_BACK = "Cape"

AQITEM_CLOTH = " Tissus"
AQITEM_LEATHER = " Cuir"
AQITEM_MAIL = " Maille"
AQITEM_PLATE = " Plaque"

AQITEM_OFFHAND = "Main Gauche"
AQITEM_MAINHAND = "Main Droite,"
AQITEM_ONEHAND = "Une main,"
AQITEM_TWOHAND = "2 mains,"

AQITEM_TRINKET = "Bijou"
AQITEM_POTION = "Potion"
AQITEM_OFFHAND = "Tenu en main gauche"
AQITEM_NECK = "Collier"
AQITEM_PATTERN = "Patron"
AQITEM_BAG = "Sac"
AQITEM_RING = "Anneau"
AQITEM_KEY = "Clef"

--------------DEADMINES/Inst1 ( 5 Quests)------------
Inst1Story = "Les « mines mortes » \195\169taient autrefois le principal centre de production d\'or des royaumes humains, mais elles furent abandonn\195\169es lorsque la Horde rasa Stormwind au cours de la Premi\195\168re Guerre. De nos jours, la Confr\195\169rie d\195\169fias s\'est \195\169tablie dans ces tunnels obscurs et en a fait son sanctuaire. On murmure que ces voleurs auraient recrut\195\169 des gobelins pour les aider \195\160 construire quelque chose de terrible au fond des mines – mais nul ne sait quoi. \195\160 en croire les rumeurs, l\'acc\195\168s des Mortemines se trouverait non loin du petit village discret de Ruisselune."
Inst1Caption = "Mortemines"
Inst1QAA = "5 Quests" -- how much quest for alliance
Inst1QAH = "No Quests" -- for horde

testid = "19135"
--QUEST1 Allianz

Inst1Quest1 = "1. Red Silk Bandanas"
Inst1Quest1_Level = "17"
Inst1Quest1_Attain = "12"
Inst1Quest1_Aim = "Scout Riell at the Sentinel Hill Tower wants you to bring her 10 Red Silk Bandanas."
Inst1Quest1_Location = "Scout Riell (Westfall - Sentinal Hill; "..YELLOW.."56, 47"..WHITE..")"
Inst1Quest1_Note = "You can get this Bandanas from miners in Deadmines or pre-instances."
Inst1Quest1_Prequest = "No"
Inst1Quest1_Folgequest = "No"
--
Inst1Quest1name1 = "Solid Shortblade"
Inst1Quest1name2 = "Scrimshaw Dagger"
Inst1Quest1name3 = "Piercing Axe"

--Quest 2 allianz

Inst1Quest2 = "2. Collecting Memories"
Inst1Quest2_Level = "18"
Inst1Quest2_Attain = "?"
Inst1Quest2_Aim = "Retrieve 4 Miners' Union Cards and return them to Wilder Thistlenettle in Stormwind."
Inst1Quest2_Location = "Wilder Thistlenettle (Stormwind; "..YELLOW.."65, 21"..WHITE.." )"
Inst1Quest2_Note = "The Undeads (elite), short before you join the instances, drop the cards."
Inst1Quest2_Prequest = "No"
Inst1Quest2_Folgequest = "No"
--
Inst1Quest2name1 = "Tunneler's Boots"
Inst1Quest2name2 = "Dusty Mining Gloves"
--Quest 3 allianz

Inst1Quest3 = "3. Oh Brother. . ."
Inst1Quest3_Level = "20"
Inst1Quest3_Attain = "?"
Inst1Quest3_Aim = "Bring Foreman Thistlenettle's Explorers' League Badge to Wilder Thistlenettle in Stormwind."
Inst1Quest3_Location = "Wilder Thistlenettle (Stormwind; "..YELLOW.."65,21"..WHITE.." )"
Inst1Quest3_Note = "The Undeads (elite), short before you join the instances, drop the Badge."
Inst1Quest3_Prequest = "No"
Inst1Quest3_Folgequest = "No"
--
Inst1Quest3name1 = "Miner's Revenge"

--Quest 4 allianz

Inst1Quest4 = "4. Underground Assault"
Inst1Quest4_Level = "20"
Inst1Quest4_Attain = "15"
Inst1Quest4_Aim = "Retrieve the Gnoam Sprecklesprocket from the Deadmines and return it to Shoni the Shilent in Stormwind."
Inst1Quest4_Location = "Shoni die Shilent (Stormwind; "..YELLOW.."55,12"..WHITE.." )"
Inst1Quest4_Note = "You get the Prequest from Gnoarn (Ironforge; 69,50).\nSneed's Shredder drops the Sprecklesprocket "..YELLOW.."[3]"..WHITE.."."
Inst1Quest4_Prequest = "Yes, Speak with Shoni"
Inst1Quest4_Folgequest = "No"
Inst1Quest4PreQuest = "true"
--
Inst1Quest4name1 = "Polar Gauntlets"
Inst1Quest4name2 = "Sable Wand"

--Quest 5 allianz

Inst1Quest5 = "5. The Defias Brotherhood (Questline)"
Inst1Quest5_Level = "22"
Inst1Quest5_Attain = "14"
Inst1Quest5_Aim = "Kill Edwin VanCleef and bring his head to Gryan Stoutmantle."
Inst1Quest5_Location = "Gryan Stoutmantle (Westfall - Sentinal Hill "..YELLOW.."56,47 "..WHITE..")"
Inst1Quest5_Note = "You start this Questline at Gryan Stoutmantle (Westfall; 56,47).\nEdwin VanCleef is the last boss of The Deadmines. You can find him at the top of his ship "..YELLOW.."[6]"..WHITE.."."
Inst1Quest5_Prequest = "Yes, The Defias Brotherhood."
Inst1Quest5_Folgequest = "Yes, The Unsent Letter"
Inst1Quest5PreQuest = "true"
--
Inst1Quest5name1 = "Chausses of Westfall"
Inst1Quest5name2 = "Tunic of Westfall"
Inst1Quest5name3 = "Staff of Westfall"

--Quest 6 allianz

Inst1Quest6 = "6. The Test of Righteousness (Paladin)"
Inst1Quest6_Level = "22"
Inst1Quest6_Attain = "20"
Inst1Quest6_Aim = "Using Jordan's Weapon Notes, find some Whitestone Oak Lumber, Bailor's Refined Ore Shipment, Jordan's Smithing Hammer, and a Kor Gem, and return them to Jordan Stilwell in Ironforge."
Inst1Quest6_Location = "Jordan Stilwell(Dun Morogh - Ironforge Entrance "..YELLOW.."52,36 "..WHITE..")"
Inst1Quest6_Note = "To watch the note klick on "..YELLOW.."[The Test of Righteousness Information]"..WHITE.."."
Inst1Quest6_Prequest = "Yes, The Tome of Valor -> The Test of Righteousness"
Inst1Quest6_Folgequest = "Yes, The Test of Righteousness"
Inst1Quest6PreQuest = "true"
--
Inst1Quest6name1 = "Verigan's Fist"


--------------WaillingCaverns/HDW ( 7 quests)------------
Inst2Story = "R\195\169cemment, Naralex, un druide elfe de la nuit, a d\195\169couvert un r\195\169seau de cavernes souterraines au cœur des Tarides. Elles doivent leur nom aux \195\169vents volcaniques qui produisent de longs g\195\169missements lugubres lorsque de la vapeur s\'en \195\169chappe. Naralex s\'imaginait qu\'il pourrait se servir des sources souterraines des cavernes pour rendre leur fertilit\195\169 aux Tarides - mais pour cela, il aurait d\195\187 siphonner l\'\195\169nergie du l\195\169gendaire R\195\170ve d\'\195\169meraude. Mais lorsqu\'il se connecta au R\195\170ve, la vision du druide tourna au cauchemar. Les Cavernes des lamentations chang\195\168rent. Leurs eaux croupirent et les cr\195\169atures dociles qui y vivaient se m\195\169tamorphos\195\168rent en pr\195\169dateurs vicieux. On dit que Naralex en personne vit quelque part au cœur de ce labyrinthe, pi\195\169g\195\169 aux confins du R\195\170ve d\'\195\169meraude. M\195\170me ses anciens acolytes ont \195\169t\195\169 corrompus par le cauchemar \195\169veill\195\169 de leur ma\195\174tre. Ils sont devenus les cruels Druides d\195\169viants."
Inst2Caption = "Cavernes des Lamentations"
Inst2QAA = "5 Quests"
Inst2QAH = "7 Quests"

--QUEST 1 Alliance

Inst2Quest1 = "1. Deviate Hides"
Inst2Quest1_Level = "17"
Inst2Quest1_Attain = "?"
Inst2Quest1_Aim = "Nalpak in the Wailing Caverns wants 20 Deviate Hides."
Inst2Quest1_Location = "Nalpak (Barrens - Wailing Caverns; "..YELLOW.."47,36 "..WHITE..")"
Inst2Quest1_Note = "Every deviat mob in and in front of the instance drops the hides. Nalpak is in a cave above the entrance."
Inst2Quest1_Prequest = "No"
Inst2Quest1_Folgequest = "No"
--
Inst2Quest1name1 = "Slick Deviate Leggings"
Inst2Quest1name2 = "Deviate Hide Pack"


--QUEST 2 Allianz

Inst2Quest2 = "2. Trouble at the Docks"
Inst2Quest2_Level = "18"
Inst2Quest2_Attain = "14"
Inst2Quest2_Aim = "Crane Operator Bigglefuzz in Ratchet wants you to retrieve the bottle of 99-Year-Old Port from Mad Magglish who is hiding in the Wailing Caverns."
Inst2Quest2_Location = "Crane Operator Bigglefuzz (Barrens - Ratchet; "..YELLOW.."63,37 "..WHITE..")"
Inst2Quest2_Note = "You get the bottle right before you go into the instance by killing Mad Magglish. You often find him, when you go into the cave and turn to the right. Hurry, he is small and hidden (stealth)."
Inst2Quest2_Prequest = "No"
Inst2Quest2_Folgequest = "No"

--QUEST 3 Allianz

Inst2Quest3 = "3. Smart Drinks"
Inst2Quest3_Level = "18"
Inst2Quest3_Attain = "?"
Inst2Quest3_Aim = "Bring 6 portions of Wailing Essence to Mebok Mizzyrix in Ratchet."
Inst2Quest3_Location = "Mebok Mizzyrix (Barrens - Ratchet; "..YELLOW.."62,37 "..WHITE..")"
Inst2Quest3_Note = "You get the Prequest from Mebok Mizzyrix too.\nAll Ectoplasm enemies in and before the instance drop the Essence."
Inst2Quest3_Prequest = "Yes, Raptor Horns"
Inst2Quest3_Folgequest = "No"
Inst2Quest3PreQuest = "true"

--QUEST 4 horde

Inst2Quest4 = "4. Deviate Eradication"
Inst2Quest4_Level = "21"
Inst2Quest4_Attain = "?"
Inst2Quest4_Aim = "Ebru in the Wailing Caverns wants you to kill 7 Deviate Ravagers, 7 Deviate Vipers, 7 Deviate Shamblers and 7 Deviate Dreadfangs."
Inst2Quest4_Location = "Ebru (Barrens; "..YELLOW.."47,36 "..WHITE..")"
Inst2Quest4_Note = "Ebru is in a cave above the entrance."
Inst2Quest4_Prequest = "No"
Inst2Quest4_Folgequest = "No"
--
Inst2Quest4name1 = "Pattern: Deviate Scale Belt"
Inst2Quest4name2 = "Sizzle Stick"
Inst2Quest4name3 = "Dagmire Gauntlets"

--QUEST 5 Allianz

Inst2Quest5 = "5. The Glowing Shard"
Inst2Quest5_Level = "25"
Inst2Quest5_Attain = "21"
Inst2Quest5_Aim = "Travel to Ratchet to find the meaning behind the Nightmare Shard."
Inst2Quest5_Location = "The Glowing Shard(drop) (Wailing Caverns)"
Inst2Quest5_Note = "You get the glowing shard, when you kill the last boss Mutanus the Devourer. Mutanus the Devourer only appear, if you kill the four druids and escord the druid at the entrance "..YELLOW.."[9]"..WHITE..".\nWhen you have the Shard, you must bring it to Ratchet (bank), and then back to the top of the hill over Wailing Caverns to Falla Sagewind."
Inst2Quest5_Prequest = "No"
Inst2Quest5_Folgequest = "Yes, In Nightmares"
--
Inst2Quest5name1 = "Talbar Mantle"
Inst2Quest5name2 = "Quagmire Galoshes"


--QUEST 1 horde

Inst2Quest1_HORDE = "1. Deviate Hides"
Inst2Quest1_HORDE_Level = "17"
Inst2Quest1_HORDE_Attain = "?"
Inst2Quest1_HORDE_Aim = "Nalpak in the Wailing Caverns wants 20 Deviate Hides."
Inst2Quest1_HORDE_Location = "Nalpak (Barrens - Wailing Caverns; "..YELLOW.."47,36 "..WHITE..")"
Inst2Quest1_HORDE_Note = "Every deviat mob in and in front of the instance drops the hides. Nalpak is in a cave above the entrance."
Inst2Quest1_HORDE_Prequest = "No"
Inst2Quest1_HORDE_Folgequest = "No"
--
Inst2Quest1name1_HORDE = "Slick Deviate Leggings"
Inst2Quest1name2_HORDE = "Deviate Hide Pack"

--QUEST 2 horde

Inst2Quest2_HORDE = "2. Trouble at the Docks"
Inst2Quest2_HORDE_Level = "18"
Inst2Quest2_HORDE_Attain = "14"
Inst2Quest2_HORDE_Aim = "Crane Operator Bigglefuzz in Ratchet wants you to retrieve the bottle of 99-Year-Old Port from Mad Magglish who is hiding in the Wailing Caverns."
Inst2Quest2_HORDE_Location = "Crane Operator Bigglefuzz (Barrens - Ratchet; "..YELLOW.."63,37 "..WHITE..")"
Inst2Quest2_HORDE_Note = "You get the bottle right before you go into the instance by killing Mad Magglish. You often find him, when you go into the cave and turn to the right. Hurry, he is small and hidden (stealth)."
Inst2Quest2_HORDE_Prequest = "No"
Inst2Quest2_HORDE_Folgequest = "No"

--QUEST 3 horde

Inst2Quest3_HORDE = "3. Serpentbloom"
Inst2Quest3_HORDE_Level = "18"
Inst2Quest3_HORDE_Attain = "14"
Inst2Quest3_HORDE_Aim = "Apothecary Zamah in Thunder Bluff wants you to collect 10 Serpentbloom."
Inst2Quest3_HORDE_Location = "Apothecary Zamah (Thunder Bluff; "..YELLOW.."22,20 "..WHITE..")"
Inst2Quest3_HORDE_Note = "You get the prequest from Apothecary Helbrim (Brachland/Crossroad; 51,30).\nYou get the Serpentbloom inside the cave in front of the instance and inside the instance. Player with Herbalism can see the plants on her minimap."
Inst2Quest3_HORDE_Prequest = "Yes, Fungal Spores -> Apothecary Zamah"
Inst2Quest3_HORDE_Folgequest = "No"
Inst2Quest3PreQuest_HORDE = "true"
--
Inst2Quest3name1_HORDE = "Apothecary Gloves"

--QUEST 4 horde

Inst2Quest4_HORDE = "4. Smart Drinks"
Inst2Quest4_HORDE_Level = "18"
Inst2Quest4_HORDE_Attain = "?"
Inst2Quest4_HORDE_Aim = "Bring 6 portions of Wailing Essence to Mebok Mizzyrix in Ratchet."
Inst2Quest4_HORDE_Location = "Mebok Mizzyrix (Barrens - Ratchet; "..YELLOW.."62,37 "..WHITE..")"
Inst2Quest4_HORDE_Note = "You get the Prequest from Mebok Mizzyrix too.\nAll Ectoplasm enemies in and before the instance drop the Essence."
Inst2Quest4_HORDE_Prequest = "Yes, Raptor Horns"
Inst2Quest4_HORDE_Folgequest = "No"
Inst2Quest4PreQuest_HORDE = "true"

--QUEST 5 horde

Inst2Quest5_HORDE = "5. Deviate Eradication"
Inst2Quest5_HORDE_Level = "21"
Inst2Quest5_HORDE_Attain = "?"
Inst2Quest5_HORDE_Aim = "Ebru in the Wailing Caverns wants you to kill 7 Deviate Ravagers, 7 Deviate Vipers, 7 Deviate Shamblers and 7 Deviate Dreadfangs."
Inst2Quest5_HORDE_Location = "Ebru (Barrens; "..YELLOW.."47,36 "..WHITE..")"
Inst2Quest5_HORDE_Note = "Ebru is in a cave above the entrance."
Inst2Quest5_HORDE_Prequest = "No"
Inst2Quest5_HORDE_Folgequest = "No"
--
Inst2Quest5name1_HORDE = "Pattern: Deviate Scale Belt"
Inst2Quest5name2_HORDE = "Sizzle Stick"
Inst2Quest5name3_HORDE = "Dagmire Gauntlets"

--QUEST 6 horde

Inst2Quest6_HORDE = "6. Leaders of the Fang (Questline)"
Inst2Quest6_HORDE_Level = "22"
Inst2Quest6_HORDE_Attain = "18"
Inst2Quest6_HORDE_Aim = "Bring the Gems of Cobrahn, Anacondra, Pythas and Serpentis to Nara Wildmane in Thunder Bluff."
Inst2Quest6_HORDE_Location = "Nara Wildmane (Thunder Bluff; "..YELLOW.."75,31 "..WHITE..")"
Inst2Quest6_HORDE_Note = "The Questline starts at Hamuul Runetotem (Thunderbluff; 78,28)\nThe 4 druids drop the gems "..YELLOW.."[2]"..WHITE..","..YELLOW.."[3]"..WHITE..","..YELLOW.."[5]"..WHITE..","..YELLOW.."[7]"..WHITE..""
Inst2Quest6_HORDE_Prequest = "Yes, The Barrens Oases -> Nara Wildmane"
Inst2Quest6_HORDE_Folgequest = "No"
Inst2Quest6PreQuest_HORDE = "true"
--
Inst2Quest6name1_HORDE = "Crescent Staff"
Inst2Quest6name2_HORDE = "Wingblade"

--QUEST 7 horde

Inst2Quest7_HORDE = "7. The Glowing Shard"
Inst2Quest7_HORDE_Level = "25"
Inst2Quest7_HORDE_Attain = "21"
Inst2Quest7_HORDE_Aim = "Travel to Ratchet to find the meaning behind the Nightmare Shard."
Inst2Quest7_HORDE_Location = "The Glowing Shard(drop) (Wailing Caverns)"
Inst2Quest7_HORDE_Note = "You get the glowing shard, when you kill the last boss Mutanus the Devourer. Mutanus the Devourer only appear, if you kill the four druids and escord the druid at the entrance "..YELLOW.."[9]"..WHITE..".\nWhen you have the Shard, you must bring it to Ratchet (bank), and then back to the top of the hill over Wailing Caverns to Falla Sagewind."
Inst2Quest7_HORDE_Prequest = "No"
Inst2Quest7_HORDE_Folgequest = "Ja, In Nightmares"
--
Inst2Quest7name1_HORDE = "Talbar Mantle"
Inst2Quest7name2_HORDE = "Quagmire Galoshes"


--------------Uldaman/Inst4 ( 16 quests)------------
Inst4Story = "Uldaman est une antique cache des Titans, enfoui au plus profond de la terre depuis la cr\195\169ation du monde. Des fouilles naines ont r\195\169cemment ouvert cette cit\195\169 oubli\195\169e, lib\195\169rant la premi\195\168re cr\195\169ation manqu\195\169e des Titans, les troggs. La l\195\169gende pr\195\169tend que les Titans ont taill\195\169 les troggs dans la pierre. Lorsqu\'ils ont estim\195\169 que l\'exp\195\169rience \195\169tait un \195\169chec, les Titans ont enferm\195\169 les troggs et ont proc\195\169d\195\169 \195\160 un deuxi\195\168me essai, donnant naissance aux nains. Les secrets de la cr\195\169ation des nains sont conserv\195\169s sur les Disques de Norgannon, de massifs artefacts fabriqu\195\169s par les Titans, et qui se trouvent aux tr\195\169fonds de la ville. Depuis peu, les nains Sombrefer ont lanc\195\169 une s\195\169rie d\'incursions dans Uldaman, dans l\'espoir de d\195\169couvrir les disques pour leur ma\195\174tre incandescent, Ragnaros. Toutefois, la ville est prot\195\169g\195\169e par plusieurs gardiens, des g\195\169ants de pierre artificiels et anim\195\169s qui broient les intrus. Les Disques eux-m\195\170mes sont prot\195\169g\195\169s par Archadeas, un colossal Gardien des pierres \195\169veill\195\169 \195\160 la conscience. Certaines rumeurs laissent entendre que les anc\195\170tres des nains, les terrestres \195\160 la peau de pierre, pourraient encore vivre dans les cachettes les plus profondes de la cit\195\169."
Inst4Caption = "Uldaman"
Inst4QAA = "16 Quests"
Inst4QAH = "10 Quests"

--QUEST 1 Allianz

Inst4Quest1 = "1. A Sign of Hope"
Inst4Quest1_Level = "35"
Inst4Quest1_Attain = "35"
Inst4Quest1_Aim = "Find Hammertoe Grez in Uldaman."
Inst4Quest1_Location = "Prospector Ryedol (Badlands; "..YELLOW.."53,43 "..WHITE..")"
Inst4Quest1_Note = "The Prequest starts at the Crumpled Map (Badlands; 53,33).\nYou find Hammertoe Grez before you enter the instance (North, West)."
Inst4Quest1_Prequest = "Yes, A Sign of Hope"
Inst4Quest1_Folgequest = "Yes, Amulet of Secrets"
Inst4Quest1PreQuest = "true"

--QUEST 2 Allianz

Inst4Quest2 = "2. Amulet of Secrets"
Inst4Quest2_Level = "40"
Inst4Quest2_Attain = "?"
Inst4Quest2_Aim = "Find Hammertoe's Amulet and return it to him in Uldaman."
Inst4Quest2_Location = "Hammertoe Grez (Uldaman - pre-instance)"
Inst4Quest2_Note = "The Amulet is north of the instance entrance, at the east end of a tunnel, before the instance."
Inst4Quest2_Prequest = "Yes, A Sign of Hope"
Inst4Quest2_Folgequest = "Yes, Prospect of Faith"
Inst4Quest2FQuest = "true"


--QUEST 3 Allianz

Inst4Quest3 = "3. The Lost Tablets of Will"
Inst4Quest3_Level = "45"
Inst4Quest3_Attain = "38"
Inst4Quest3_Aim = "Find the Tablet of Will, and return them to Advisor Belgrum in Ironforge."
Inst4Quest3_Location = "Advisor Belgrum (Ironforge; "..YELLOW.."77,10 "..WHITE..")"
Inst4Quest3_Note = "The tablets are at "..YELLOW.."[8]"..WHITE.."."
Inst4Quest3_Prequest = "Yes, Amulet of Secrets -> An Ambassador of Evil"
Inst4Quest3_Folgequest = "No"
Inst4Quest3FQuest = "true"
--
Inst4Quest3name1 = "Medal of Courage"

--QUEST 4 Allianz

Inst4Quest4 = "4. Power Stones"
Inst4Quest4_Level = "36"
Inst4Quest4_Attain = "?"
Inst4Quest4_Aim = "Bring 8 Dentrium Power Stones and 8 An'Alleum Power Stones to Rigglefuzz in the Badlands."
Inst4Quest4_Location = "Rigglefuzz (Badlands; "..YELLOW.."42,52 "..WHITE..")"
Inst4Quest4_Note = "The stones can be found on any Shadoforge enemies before and in the instance."
Inst4Quest4_Prequest = "No"
Inst4Quest4_Folgequest = "No"
--
Inst4Quest4name1 = "Energized Stone Circle"
Inst4Quest4name2 = "Duracin Bracers"
Inst4Quest4name3 = "Everlast Boots"

--QUEST 5 Allianz

Inst4Quest5 = "5. Agmond's Fate"
Inst4Quest5_Level = "38"
Inst4Quest5_Attain = "38"
Inst4Quest5_Aim = "Bring 4 Carved Stone Urns to Prospector Ironband in Loch Modan."
Inst4Quest5_Location = "Prospector Ironband (Loch Modan; "..YELLOW.."65,65 "..WHITE..")"
Inst4Quest5_Note = "The Prequest starts at Prospector Stormpike (Ironforge; 74,12).\nThe Urns are scattered throughout the caves before the instance."
Inst4Quest5_Prequest = "Yes, Ironband Wants You! -> Murdaloc"
Inst4Quest5_Folgequest = "No"
Inst4Quest5PreQuest = "true"
--
Inst4Quest5name1 = "Prospector Gloves"

--QUEST 6 Allianz

Inst4Quest6 = "6. Solution to Doom"
Inst4Quest6_Level = "40"
Inst4Quest6_Attain = "31"
Inst4Quest6_Aim = "Bring the Tablet of Ryun'eh to Theldurin the Lost."
Inst4Quest6_Location = "Theldurin the Lost (Badlands; "..YELLOW.."51,76 "..WHITE..")"
Inst4Quest6_Note = "The tablet is north of the caves, at the east end of a tunnel, before the instance."
Inst4Quest6_Prequest = "No"
Inst4Quest6_Folgequest = "Yes, To Ironforge for Yagyin's Digest"
--
Inst4Quest6name1 = "Doomsayer's Robe"

--QUEST 7 Allianz

Inst4Quest7 = "7. The Lost Dwarves"
Inst4Quest7_Level = "40"
Inst4Quest7_Attain = "?"
Inst4Quest7_Aim = "Find Baelog in Uldaman."
Inst4Quest7_Location = "Prospector Stormpike (Badlands; "..YELLOW.."46,12 "..WHITE..")"
Inst4Quest7_Note = "Bealog is at "..YELLOW.."[1]"..WHITE.."."
Inst4Quest7_Prequest = "No"
Inst4Quest7_Folgequest = "Yes, The Hidden Chamber"

--QUEST 8 Allianz

Inst4Quest8 = "8. The Hidden Chamber"
Inst4Quest8_Level = "40"
Inst4Quest8_Attain = "?"
Inst4Quest8_Aim = "Read Baelog's Journal, explore the hidden chamber, then report to Prospector Stormpike."
Inst4Quest8_Location = "Baelog (Uldaman - "..YELLOW.."[1]"..WHITE..")"
Inst4Quest8_Note = "The Hidden Chamber is at "..YELLOW.."[4]"..WHITE.."."
Inst4Quest8_Prequest = "Yes, The Lost Dwarves"
Inst4Quest8_Folgequest = "No"
Inst4Quest8FQuest = "true"
--
Inst4Quest8name1 = "Dwarven Charge"
Inst4Quest8name2 = "Explorer's League Lodestar"

--QUEST 9 Allianz

Inst4Quest9 = "9. The Shattered Necklace"
Inst4Quest9_Level = "41"
Inst4Quest9_Attain = "37"
Inst4Quest9_Aim = "Search for the original creator of the shattered necklace to learn of its potential value."
Inst4Quest9_Location = "Shattered Necklace (random drop) (Uldaman)"
Inst4Quest9_Note = "Bring the necklace to Talvash del Kissel in Ironforge (36,3)"
Inst4Quest9_Prequest = "No"
Inst4Quest9_Folgequest = "Yes, Lore for a Price"

--QUEST 10 Allianz

Inst4Quest10 = "10. Back to Uldaman"
Inst4Quest10_Level = "41"
Inst4Quest10_Attain = "37"
Inst4Quest10_Aim = "Search for clues as to the current disposition of Talvash's necklace within Uldaman. The slain paladin he mentioned was the person who has it last."
Inst4Quest10_Location = "Talvash del Kissel (Ironforge; "..YELLOW.."36,3 "..WHITE..")"
Inst4Quest10_Note = "The Paladin is at "..YELLOW.."[2]"..WHITE.."."
Inst4Quest10_Prequest = "Yes, Lore for a Price"
Inst4Quest10_Folgequest = "Yes, Find the Gems"

--QUEST 11 Allianz

Inst4Quest11 = "11. Find the Gems"
Inst4Quest11_Level = "43"
Inst4Quest11_Attain = "37"
Inst4Quest11_Aim = "Find the ruby, sapphire, and topaz that are scattered throughout Uldaman. Once acquired, contact Talvash del Kissel remotely by using the Phial of Scrying he previously gave you."
Inst4Quest11_Location = "Remains of a Paladin (Uldaman)"
Inst4Quest11_Note = "The gems are at"..YELLOW.."[1]"..WHITE..", "..YELLOW.."[8]"..WHITE..", and "..YELLOW.."[9]"..WHITE.."."
Inst4Quest11_Prequest = "Yes, Back to Uldaman"
Inst4Quest11_Folgequest = "Yes, Restoring the Necklace"
Inst4Quest11FQuest = "true"

--QUEST 12 Allianz

Inst4Quest12 = "12. Restoring the Necklace"
Inst4Quest12_Level = "44"
Inst4Quest12_Attain = "38"
Inst4Quest12_Aim = "Obtain a power source from the most powerful construct you can find in Uldaman, and deliver it to Talvash del Kissel in Ironforge."
Inst4Quest12_Location = "Talvash's Scrying Bowl"
Inst4Quest12_Note = "The Shattered Necklace Power Source drops Archaedas "..YELLOW.."[10]"..WHITE.."."
Inst4Quest12_Prequest = "Yes, Find the Gems."
Inst4Quest12_Folgequest = "No"-- AUFPASSEN HIER IS EIN FOLGEQUEST ABER ES GIBT NUR BELOHNUNG!
--
Inst4Quest12name1 = "Talvash's Enhancing Necklace"
Inst4Quest12FQuest = "true"

--QUEST 13 Allianz

Inst4Quest13 = "13. Uldaman Reagent Run"
Inst4Quest13_Level = "42"
Inst4Quest13_Attain = "38"
Inst4Quest13_Aim = "Bring 12 Magenta Fungus Caps to Ghak Healtouch in Thelsamar."
Inst4Quest13_Location = "Ghak Healtouch (Loch Modan; "..YELLOW.."37,49 "..WHITE..")"
Inst4Quest13_Note = "The caps are scattered throughout the instance."
Inst4Quest13_Prequest = "No"
Inst4Quest13_Folgequest = "No"
--
Inst4Quest13name1 = "Restorative Potion"

--QUEST 14 Allianz

Inst4Quest14 = "14. Reclaimed Treasures"
Inst4Quest14_Level = "43"
Inst4Quest14_Attain = "?"
Inst4Quest14_Aim = "Get Krom Stoutarm's treasured possession from his chest in the North Common Hall of Uldaman, and bring it to him in Ironforge."
Inst4Quest14_Location = "Krom Stoutarm (Ironforge; "..YELLOW.."74,9 "..WHITE..")"
Inst4Quest14_Note = "You find the treasur before you enter the instance. It is in the north of the caves, at the southeast end of the first tunnel."
Inst4Quest14_Prequest = "No"
Inst4Quest14_Folgequest = "No"

--QUEST 15 Allianz

Inst4Quest15 = "15. The Platinum Discs"
Inst4Quest15_Level = "45"
Inst4Quest15_Attain = "40"
Inst4Quest15_Aim = "Speak with stone watcher and learn what ancient lore it keeps. Once you have learned what lore it has to offer, activate the Discs of Norgannon. -> Take the miniature version of the Discs of Norgannon to the Explorers' League in Ironforge."
Inst4Quest15_Location = "The Discs of Norgannon (Uldaman - "..YELLOW.."[11]"..WHITE..")"
Inst4Quest15_Note = "After you receive the quest, speak to the stone watcher to the left of the discs.  Then use the platinum discs again to recieve miniature discs, which you'll have to take to High Explorer Magellas in Ironforge (69,18)."
Inst4Quest15_Prequest = "No"
Inst4Quest15_Folgequest = "No"
--
Inst4Quest15name1 = "Taupelzsack"
Inst4Quest15name2 = "Superior Healing Potion"
Inst4Quest15name3 = "Greater Mana Potion"

--QUEST 16 Allianz

Inst4Quest16 = "16. Power in Uldaman (Mage)"
Inst4Quest16_Level = "40"
Inst4Quest16_Attain = "35"
Inst4Quest16_Aim = "Retrieve an Obsidian Power Source and bring it to Tabetha in Dustwallow Marsh."
Inst4Quest16_Location = "Tabetha (Dustwallow Marsh; "..YELLOW.."46,57 "..WHITE..")"
Inst4Quest16_Note = "This quest is only available to Mages!\nThe Obsidian Power Source drops from the Obsidian Sentinel at "..YELLOW.."[5]"..WHITE.."."
Inst4Quest16_Prequest = "Yes, The Exorcism"
Inst4Quest16_Folgequest = "Yes, Mana Surges"
Inst4Quest16PreQuest = "true"

--QUEST 1 Horde

Inst4Quest1_HORDE = "1. Power Stones"
Inst4Quest1_HORDE_Level = "36"
Inst4Quest1_HORDE_Attain = "?"
Inst4Quest1_HORDE_Aim = "Bring 8 Dentrium Power Stones and 8 An'Alleum Power Stones to Rigglefuzz in the Badlands."
Inst4Quest1_HORDE_Location = "Rigglefuzz (Badlands; "..YELLOW.."42:52 "..WHITE..")"
Inst4Quest1_HORDE_Note = "The stones can be found on any Shadowforge enemies before and in the instance."
Inst4Quest1_HORDE_Prequest = "No"
Inst4Quest1_HORDE_Folgequest = "No"
--
Inst4Quest1name1_HORDE = "Energized Stone Circle"
Inst4Quest1name2_HORDE = "Duracin Bracers"
Inst4Quest1name3_HORDE = "Everlast Boots"

--QUEST 2 Horde

Inst4Quest2_HORDE = "2. Solution to Doom"
Inst4Quest2_HORDE_Level = "40"
Inst4Quest2_HORDE_Attain = "31"
Inst4Quest2_HORDE_Aim = "Bring the Tablet of Ryun'eh to Theldurin the Lost."
Inst4Quest2_HORDE_Location = "Theldurin the Lost (Badlands; "..YELLOW.."51,76 "..WHITE..")"
Inst4Quest2_HORDE_Note = "The tablet is north of the caves, at the east end of a tunnel, before the instance."
Inst4Quest2_HORDE_Prequest = "No"
Inst4Quest2_HORDE_Folgequest = "Yes, To Ironforge for Yagyin's Digest"
--
Inst4Quest2name1_HORDE = "Doomsayer's Robe"

--QUEST 3 Horde

Inst4Quest3_HORDE = "3. Necklace Recovery"
Inst4Quest3_HORDE_Level = "41"
Inst4Quest3_HORDE_Attain = "37"
Inst4Quest3_HORDE_Aim = "Look for a valuable necklace within the Uldaman dig site and bring it back to Dran Droffers in Orgrimmar. The necklace may be damaged."
Inst4Quest3_HORDE_Location = "Dran Droffers (Orgrimmar; "..YELLOW.."59,36 "..WHITE..")"
Inst4Quest3_HORDE_Note = "The necklace is a random drop in the instance."
Inst4Quest3_HORDE_Prequest = "No"
Inst4Quest3_HORDE_Folgequest = "Yes, Necklace Recovery, Take 2."

--QUEST 4 Horde

Inst4Quest4_HORDE = "4. Necklace Recovery, Take 2"
Inst4Quest4_HORDE_Level = "41"
Inst4Quest4_HORDE_Attain = "38"
Inst4Quest4_HORDE_Aim = "Find a clue as to the gems' whereabouts in the depths of Uldaman."
Inst4Quest4_HORDE_Location = "Dran Droffers (Orgrimmar; "..YELLOW.."59,36 "..WHITE..")"
Inst4Quest4_HORDE_Note = "The Paladin is at "..YELLOW.."[2]"..WHITE.."."
Inst4Quest4_HORDE_Prequest = "Yes, Necklace Recovery"
Inst4Quest4_HORDE_Folgequest = "Yes, Translating the Journal"
Inst4Quest4FQuest_HORDE = "true"

--QUEST 5 Horde

Inst4Quest5_HORDE = "5. Translating the Journal"
Inst4Quest5_HORDE_Level = "42"
Inst4Quest5_HORDE_Attain = "40"
Inst4Quest5_HORDE_Aim = "Find someone who can translate the paladin's journal. The closest location that might have someone is Kargath, in the Badlands."
Inst4Quest5_HORDE_Location = "Remains of a Paladin (Uldaman - Punkt 2)"
Inst4Quest5_HORDE_Note = "The translator (Jarkal Mossmeld) is in Kargath (Badlands 2,46)."
Inst4Quest5_HORDE_Prequest = "Yes, Necklace Recovery, Take 2"
Inst4Quest5_HORDE_Folgequest = "Yes, Find the Gems and Power Source"
Inst4Quest5FQuest_HORDE = "true"

--QUEST 6 Horde

Inst4Quest6_HORDE = "6. Find the Gems and Power Source"
Inst4Quest6_HORDE_Level = "44"
Inst4Quest6_HORDE_Attain = "37"
Inst4Quest6_HORDE_Aim = "Recover all three gems and a power source for the necklace from Uldaman, and then bring them to Jarkal Mossmeld in Kargath. Jarkal believes a power source might be found on the strongest construct present in Uldaman."
Inst4Quest6_HORDE_Location = "Jarkal Mossmeld (Badlands; "..YELLOW.."2,46 "..WHITE..")"
Inst4Quest6_HORDE_Note = "The gems are in "..YELLOW.."[1]"..WHITE..", "..YELLOW.."[8]"..WHITE..", and "..YELLOW.."[9]"..WHITE..".  The Shattered Necklace Power Source drops from Archaedas "..YELLOW.."[10]"..WHITE.."."
Inst4Quest6_HORDE_Prequest = "Yes, Translating the Journal."
Inst4Quest6_HORDE_Folgequest = "Yes, Deliver the Gems"
Inst4Quest6FQuest_HORDE = "true"
--
Inst4Quest6name1_HORDE = "Jarkal's Enhancing Necklace"

--QUEST 7 Horde

Inst4Quest7_HORDE = "7. Uldaman Reagent Run"
Inst4Quest7_HORDE_Level = "42"
Inst4Quest7_HORDE_Attain = "38"
Inst4Quest7_HORDE_Aim = "Bring 12 Magenta Fungus Caps to Jarkal Mossmeld in Kargath."
Inst4Quest7_HORDE_Location = "Jarkal Mossmeld (Badlands; "..YELLOW.."2,69 "..WHITE..")"
Inst4Quest7_HORDE_Note = "You get the Prequest from Jarkal Mossmeld, too.\nThe caps are scattered throughout the instance."
Inst4Quest7_HORDE_Prequest = "Yes, Badlands Reagent Run"
Inst4Quest7_HORDE_Folgequest = "Yes, Badlands Reagent Run II"
Inst4Quest7PreQuest_HORDE = "true"
--
Inst4Quest7name1_HORDE = "Restorative Potion"

--QUEST 8 Horde

Inst4Quest8_HORDE = "8. Reclaimed Treasures"
Inst4Quest8_HORDE_Level = "43"
Inst4Quest8_HORDE_Attain = "?"
Inst4Quest8_HORDE_Aim = "Get Patrick Garrett's family treasure from their family chest in the South Common Hall of Uldaman, and bring it to him in the Undercity."
Inst4Quest8_HORDE_Location = "Patrick Garrett (Undercity; "..YELLOW.."72,48 "..WHITE..")"
Inst4Quest8_HORDE_Note = "You find the treasur before you enter the instance. It is at the end of the south tunnel."
Inst4Quest8_HORDE_Prequest = "No"
Inst4Quest8_HORDE_Folgequest = "No"


--QUEST 9 Horde

Inst4Quest9_HORDE = "9. The Platinum Discs"
Inst4Quest9_HORDE_Level = "45"
Inst4Quest9_HORDE_Attain = "40"
Inst4Quest9_HORDE_Aim = "Speak with stone watcher and learn what ancient lore it keeps. Once you have learned what lore it has to offer, activate the Discs of Norgannon. -> Take the miniature version of the Discs of Norgannon to the one of the sages in Thunder Bluff."
Inst4Quest9_HORDE_Location = "The Discs of Norgannon (Uldaman - "..YELLOW.."[11]"..WHITE..")"
Inst4Quest9_HORDE_Note = "After you receive the quest, speak to the stone watcher to the left of the discs.  Then use the platinum discs again to recieve miniature discs, which you'll have to take to Sage Truthseeker in Thunder Bluff (34,46)."
Inst4Quest9_HORDE_Prequest = "No"
Inst4Quest9_HORDE_Folgequest = "No"
--
Inst4Quest9name1_HORDE = "Taupelzsack"
Inst4Quest9name2_HORDE = "Superior Healing Potion"
Inst4Quest9name3_HORDE = "Greater Mana Potion"

--QUEST 10 Horde

Inst4Quest10_HORDE = "10. Power in Uldaman (Mage)"
Inst4Quest10_HORDE_Level = "40"
Inst4Quest10_HORDE_Attain = "35"
Inst4Quest10_HORDE_Aim = "Retrieve an Obsidian Power Source and bring it to Tabetha in Dustwallow Marsh."
Inst4Quest10_HORDE_Location = "Tabetha (Dustwallow Marsh; "..YELLOW.."46,57 "..WHITE..")"
Inst4Quest10_HORDE_Note = "This quest is only available to Mages!\nThe Obsidian Power Source drops from the Obsidian Sentinel in area 5."
Inst4Quest10_HORDE_Prequest = "Yes, The Exorcism"
Inst4Quest10_HORDE_Folgequest = "Yes, Mana Surges"
Inst4Quest10PreQuest_HORDE = "true"


--------------------------Ragfire ( 5 Quests)
Inst3Story = "Le gouffre de Ragefeu est un r\195\169seau de cavernes volcaniques qui se trouve sous Orgrimmar, la nouvelle capitale des orcs. Depuis peu, des rumeurs pr\195\169tendent qu\'un culte loyal au d\195\169moniaque Conseil des ombres s\'est install\195\169 dans ses profondeurs enflamm\195\169es. Ce culte, nomm\195\169 la Lame ardente, menace la souverainet\195\169 m\195\170me de Durotar. Beaucoup de gens croient que le Chef de guerre Thrall est inform\195\169 de l\'existence de la Lame et a choisi de ne pas la d\195\169truire dans l\'espoir que ses membres pourraient le mener au Conseil des ombres. Quoi qu\'il advienne, la puissance t\195\169n\195\169breuse qui \195\169mane du gouffre de Ragefeu pourrait an\195\169antir tout ce pour quoi les orcs ont lutt\195\169."
Inst3Caption = "Gouffre de Ragefeu"
Inst3QAA = "no Quests"
Inst3QAH = "5 Quests"

--QUEST 1 Horde

Inst3Quest1_HORDE = "1. Testing an Enemy's Strength"
Inst3Quest1_HORDE_Level = "15"
Inst3Quest1_HORDE_Attain = "?"
Inst3Quest1_HORDE_Aim = "Search Orgrimmar for Ragefire Chasm, then kill 8 Ragefire Troggs and 8 Ragefire Shaman before returning to Rahauro in Thunder Bluff."
Inst3Quest1_HORDE_Location = "Rahauro ( Thunder Bluff; "..YELLOW.."70,29 "..WHITE..")"
Inst3Quest1_HORDE_Note = "You find the troggs at the beginnig."
Inst3Quest1_HORDE_Prequest = "No"
Inst3Quest1_HORDE_Folgequest = "No"

--QUEST 2 Horde

Inst3Quest2_HORDE = "2. The Power to Destroy..."
Inst3Quest2_HORDE_Level = "16"
Inst3Quest2_HORDE_Attain = "?"
Inst3Quest2_HORDE_Aim = "Bring the books Spells of Shadow and Incantations from the Nether to Varimathras in Undercity."
Inst3Quest2_HORDE_Location = "Varimathras ( Undercity; "..YELLOW.."56,92 "..WHITE..")"
Inst3Quest2_HORDE_Note = "Searing Blade Cultists and Warlocks drop the books"
Inst3Quest2_HORDE_Prequest = "No"
Inst3Quest2_HORDE_Folgequest = "No"
--
Inst3Quest2name1_HORDE = "Ghastly Trousers"
Inst3Quest2name2_HORDE = "Dredgemire Leggings"
Inst3Quest2name3_HORDE = "Gargoyle Leggings"

--QUEST 3 Horde

Inst3Quest3_HORDE = "3. Searching for the Lost Satchel"
Inst3Quest3_HORDE_Level = "16"
Inst3Quest3_HORDE_Attain = "?"
Inst3Quest3_HORDE_Aim = "Search Ragefire Chasm for Maur Grimtotem's corpse and search it for any items of interest."
Inst3Quest3_HORDE_Location = "Rahauro ( Thunder Bluff; "..YELLOW.."70,29 "..WHITE..")"
Inst3Quest3_HORDE_Note = "You find Maur Grimmtotem at "..YELLOW.."[1]"..WHITE..". After getting the satchel you must bring it back to Rahauro in Thunder Bluff"
Inst3Quest3_HORDE_Prequest = "No"
Inst3Quest3_HORDE_Folgequest = "Yes, Returning the Lost Satchel"
--
Inst3Quest3name1_HORDE = "Featherbead Bracers"
Inst3Quest3name2_HORDE = "Savannah Bracers"

--QUEST 4 Horde

Inst3Quest4_HORDE = "4. Hidden Enemies"
Inst3Quest4_HORDE_Level = "16"
Inst3Quest4_HORDE_Attain = "?"
Inst3Quest4_HORDE_Aim = "Kill Bazzalan and Jergosh the Invoker before returning to Thrall in Orgrimmar."
Inst3Quest4_HORDE_Location = "Thrall ( Orgrimmar; "..YELLOW.."31,37 "..WHITE..")"
Inst3Quest4_HORDE_Note = "You findt Bazzalan at  "..YELLOW.."[4]"..WHITE.." and Jergosh at "..YELLOW.."[3]"..WHITE.."."
Inst3Quest4_HORDE_Prequest = "Yes, Hidden Enemies"
Inst3Quest4_HORDE_Folgequest = "Yes, Hidden Enemies"
Inst3Quest4PreQuest_HORDE = "true"
--
Inst3Quest4name1_HORDE = "Kris of Orgrimmar"
Inst3Quest4name2_HORDE = "Hammer of Orgrimmar"
Inst3Quest4name3_HORDE = "Axe of Orgrimmar"
Inst3Quest4name4_HORDE = "Staff of Orgrimmar"

--QUEST 5 Horde

Inst3Quest5_HORDE = "5. Slaying the Beast"
Inst3Quest5_HORDE_Level = "16"
Inst3Quest5_HORDE_Attain = "?"
Inst3Quest5_HORDE_Aim = "Enter Ragefire Chasm and slay Taragaman the Hungerer, then bring his heart back to Neeru Fireblade in Orgrimmar."
Inst3Quest5_HORDE_Location = "Neeru Fireblade ( Orgrimmar; "..YELLOW.."49,50 "..WHITE..")"
Inst3Quest5_HORDE_Note = "You find Taragaman at "..YELLOW.."[2]"..WHITE.."."
Inst3Quest5_HORDE_Prequest = "No"
Inst3Quest5_HORDE_Folgequest = "No"

--------------------------Inst27 Zul'Farrak / ZUL
Inst27Story = " Cette cit\195\169 \195\169cras\195\169e de soleil est le domaine des trolls Sandfury, connus pour leur cruaut\195\169 et leur mysticisme t\195\169n\195\169breux. Les l\195\169gendes trolls parlent d\'une \195\169p\195\169e puissante, Sul\'thraze la Flagellante, capable d\'instiller la peur et la faiblesse au plus redoutable des ennemis. Il y a bien longtemps, l\'\195\169p\195\169e fut bris\195\169e en deux, mais on dit que les deux moiti\195\169s se trouveraient quelque part dans les murs de Zul\'Farrak. D\'autres rumeurs laissent entendre qu\'une bande de mercenaires fuyant Gadgetzan se sont aventur\195\169s dans la cit\195\169 et y ont \195\169t\195\169 pi\195\169g\195\169s. Le sort reste myst\195\169rieux. Mais le plus perturbant restent les murmures qui mentionnent une cr\195\169ature ancienne qui dormirait sous un bassin sacr\195\169 au cœur de la cit\195\169 – un puissant demi-dieu qui d\195\169truira impitoyablement tout aventurier assez fou pour venir l\'\195\169veiller."
Inst27Caption = "Zul'Farrak"
Inst27QAA = "7 Quests"
Inst27QAH = "7 Quests"



--QUEST 1 Allianz

Inst27Quest1 = "1. Troll Temper"
Inst27Quest1_Level = "45"
Inst27Quest1_Attain = "?"
Inst27Quest1_Aim = "Bring 20 Vials of Troll Temper to Trenton Lighthammer in Gadgetzan."
Inst27Quest1_Location = "Trenton Lighthammer (Tanaris - Gadgetzan; "..YELLOW.."51,28 "..WHITE..")"
Inst27Quest1_Note = "Every Troll drops the Temper."
Inst27Quest1_Prequest = "No"
Inst27Quest1_Folgequest = "No"

--QUEST 2 Allianz

Inst27Quest2 = "2. Scarab Shells"
Inst27Quest2_Level = "45"
Inst27Quest2_Attain = "?"
Inst27Quest2_Aim = "Bring 5 Uncracked Scarab Shells to Tran'rek in Gadgetzan."
Inst27Quest2_Location = "Tran'rek (Tanaris - Gadgetzan; "..YELLOW.."51,26 "..WHITE..")"
Inst27Quest2_Note = "The prequest starts at Krazek (Stranglethorn Vale(Booty Bay); 25,77 ).\nEvery Scarab drops the Shells. A lot of Scarabs are at "..YELLOW.."[2]"..WHITE.."."
Inst27Quest2_Prequest = "Yes, Tran'rek"
Inst27Quest2_Folgequest = "No"
Inst27Quest2PreQuest = "true"

--QUEST 3 Allianz

Inst27Quest3 = "3. Tiara of the Deep"
Inst27Quest3_Level = "46"
Inst27Quest3_Attain = "40"
Inst27Quest3_Aim = "Bring the Tiara of the Deep to Tabetha in Dustwallow Marsh."
Inst27Quest3_Location = "Tabetha (Die Marschen von Dustwallow; "..YELLOW.."46,57 "..WHITE..")"
Inst27Quest3_Note = "You get the prequest from Bink (Ironforge; 25,8).\nHydromancer Velratha drops the Tiara of the Deep. You find him at "..YELLOW.."[6]"..WHITE.."."
Inst27Quest3_Prequest = "Yes, Tabetha's Task"
Inst27Quest3_Folgequest = "No"
Inst27Quest3PreQuest = "true"
--
Inst27Quest3name1 = "Spellshifter Rod"
Inst27Quest3name2 = "Gemshale Pauldrons"

--QUEST 4 Allianz

Inst27Quest4 = "4. Nekrum's Medallion (Questline)"
Inst27Quest4_Level = "47"
Inst27Quest4_Attain = "40"
Inst27Quest4_Aim = "Bring Nekrum's Medallion to Thadius Grimshade in the Blasted Lands."
Inst27Quest4_Location = "Thadius Grimshade (The Blasted Lands; "..YELLOW.."66,19 "..WHITE..")"
Inst27Quest4_Note = "The Questline starts at Gryphon Master Talonaxe (The Hinterlands; 9,44).\nYou can find Nekrum at "..YELLOW.."[4]"..WHITE.."."
Inst27Quest4_Prequest = "Yes, Witherbark Cages -> Thadius Grimshade"
Inst27Quest4_Folgequest = "Yes, The Divination"
Inst27Quest4PreQuest = "true"

--QUEST 5 Allianz

Inst27Quest5 = "5. The Prophecy of Mosh'aru (Questline)"
Inst27Quest5_Level = "47"
Inst27Quest5_Attain = "40"
Inst27Quest5_Aim = "Bring the First and Second Mosh'aru Tablets to Yeh'kinya in Tanaris."
Inst27Quest5_Location = "Yeh'kinya (Tanaris; "..YELLOW.."66,22 "..WHITE..")"
Inst27Quest5_Note = "You get the prequest from the same NPC.\nYou find the tables at "..YELLOW.."[2]"..WHITE.." and "..YELLOW.."[6]"..WHITE.."."
Inst27Quest5_Prequest = "Yes, Screecher Spirits"
Inst27Quest5_Folgequest = "Yes, The Ancient Egg"
Inst27Quest5PreQuest = "true"

--QUEST 6 Allianz

Inst27Quest6 = "6. Divino-matic Rod"
Inst27Quest6_Level = "46"
Inst27Quest6_Attain = "?"
Inst27Quest6_Aim = "Bring the Divino-matic Rod to Chief Engineer Bilgewhizzle in Gadgetzan."
Inst27Quest6_Location = "Bilgewhizzle (Tanaris - Gadgetzan; "..YELLOW.."52,28 "..WHITE..")"
Inst27Quest6_Note = "You get the Rod from Seargent Bly. You can find him at "..YELLOW.."[4]"..WHITE.." after the Temple event."
Inst27Quest6_Prequest = "No"
Inst27Quest6_Folgequest = "No"
--
Inst27Quest6name1 = "Masons Fraternity Ring"
Inst27Quest6name2 = "Engineer's Guild Headpiece"


--QUEST 7 Allianz

Inst27Quest7 = "7. Gahz'rilla"
Inst27Quest7_Level = "50"
Inst27Quest7_Attain = "40"
Inst27Quest7_Aim = "Bring Gahz'rilla's Electrified Scale to Wizzle Brassbolts in the Shimmering Flats."
Inst27Quest7_Location = "Wizzle Brassbolts (Thousands Needles; "..YELLOW.."78,77 "..WHITE..")"
Inst27Quest7_Note = "You get the prequest from Klockmort Spannerspan(Ironforge; 68,46).\nYou can evocate Gahz'rilla at "..YELLOW.."[6]"..WHITE.."."
Inst27Quest7_Prequest = "Yes, The Brassbolts Brothers"
Inst27Quest7_Folgequest = "No"
Inst27Quest7PreQuest = "true"
--
Inst27Quest7name1 = "Carrot on a Stick"

--QUEST 1 Horde

Inst27Quest1_HORDE = "1. The Spider God (Questline)"
Inst27Quest1_HORDE_Level = "45"
Inst27Quest1_HORDE_Attain = "42"
Inst27Quest1_HORDE_Aim = "Read from the Tablet of Theka to learn the name of the Witherbark spider god, then return to Master Gadrin."
Inst27Quest1_HORDE_Location = "Meister Gadrin ( Durotar; "..YELLOW.."55,74 "..WHITE..")"
Inst27Quest1_HORDE_Note = "The Questline starts at a Venom Bottle (The Hinterlands, troll village).\nYou find the Table at "..YELLOW.."[2]"..WHITE.."."
Inst27Quest1_HORDE_Prequest = "Yes, Venom Bottles -> Consult Master Gadrin"
Inst27Quest1_HORDE_Folgequest = "Yes, Summoning Shadra"
Inst27Quest1PreQuest_HORDE = "true"

--QUEST 2 Horde

Inst27Quest2_HORDE = "2. Troll Temper"
Inst27Quest2_HORDE_Level = "45"
Inst27Quest2_HORDE_Attain = "?"
Inst27Quest2_HORDE_Aim = "Bring 20 Vials of Troll Temper to Trenton Lighthammer in Gadgetzan."
Inst27Quest2_HORDE_Location = "Trenton Lighthammer (Tanaris - Gadgetzan; "..YELLOW.."52,28 "..WHITE..")"
Inst27Quest2_HORDE_Note = "Every Troll drops ther Temper."
Inst27Quest2_HORDE_Prequest = "No"
Inst27Quest2_HORDE_Folgequest = "No"

--QUEST 3 Horde

Inst27Quest3_HORDE = "3. Scarab Shells"
Inst27Quest3_HORDE_Level = "45"
Inst27Quest3_HORDE_Attain = "?"
Inst27Quest3_HORDE_Aim = "Bring 5 Uncracked Scarab Shells to Tran'rek in Gadgetzan."
Inst27Quest3_HORDE_Location = "Tran'rek (Tanaris - Gadgetzan; "..YELLOW.."51,36 "..WHITE..")"
Inst27Quest3_HORDE_Note = "The prequest starts at Krazek (Stranglethorn Vale(Booty Bay); 25,77 ).\nEvery Scarab drops the Shells. A lot of Scarabs are at "..YELLOW.."[2]"..WHITE.."."
Inst27Quest3_HORDE_Prequest = "Yes, Tran'rek"
Inst27Quest3_HORDE_Folgequest = "No"
Inst27Quest3PreQuest_HORDE = "true"

--QUEST 4 Horde

Inst27Quest4_HORDE = "4. Tiara of the Deep"
Inst27Quest4_HORDE_Level = "46"
Inst27Quest4_HORDE_Attain = "40"
Inst27Quest4_HORDE_Aim = "Bring the Tiara of the Deep to Tabetha in Dustwallow Marsh."
Inst27Quest4_HORDE_Location = "Tabetha (Die Marschen von Dustwallow; "..YELLOW.."46,57 "..WHITE..")"
Inst27Quest4_HORDE_Note = "You get the prequest from Deino (Orgrimmar; 38,85).\nVelratha drops the Tiara of the Deep. You can find her at "..YELLOW.."[6]"..WHITE.."."
Inst27Quest4_HORDE_Prequest = "Yes, Tabetha's Task"
Inst27Quest4_HORDE_Folgequest = "No"
Inst27Quest4PreQuest_HORDE = "true"
--
Inst27Quest4name1_HORDE = "Spellshifter Rod"
Inst27Quest4name2_HORDE = "Gemshale Pauldrons"

--QUEST 5 Horde

Inst27Quest5_HORDE = "5. The Prophecy of Mosh'aru (Questline)"
Inst27Quest5_HORDE_Level = "47"
Inst27Quest5_HORDE_Attain = "40"
Inst27Quest5_HORDE_Aim = "Bring the First and Second Mosh'aru Tablets to Yeh'kinya in Tanaris."
Inst27Quest5_HORDE_Location = "Yeh'kinya (Tanaris; "..YELLOW.."66,22 "..WHITE..")"
Inst27Quest5_HORDE_Note = "You get the prequest from the same NPC.\nYou find the tables at "..YELLOW.."[2]"..WHITE.." and "..YELLOW.."[6]"..WHITE.."."
Inst27Quest5_HORDE_Prequest = "Yes, Screecher Spirits"
Inst27Quest5_HORDE_Folgequest = "Yes, The Ancient Egg"
Inst27Quest5PreQuest_HORDE = "true"

--QUEST 6 Horde

Inst27Quest6_HORDE = "6. Divino-matic Rod"
Inst27Quest6_HORDE_Level = "46"
Inst27Quest6_HORDE_Attain = "?"
Inst27Quest6_HORDE_Aim = "Bring the Divino-matic Rod to Chief Engineer Bilgewhizzle in Gadgetzan."
Inst27Quest6_HORDE_Location = "Bilgewhizzle (Tanaris - Gadgetzan; "..YELLOW.."52,28 "..WHITE..")"
Inst27Quest6_HORDE_Note = "You get the Rod from Seargent Bly. You can find him at "..YELLOW.."[4]"..WHITE.." after the Temple event."
Inst27Quest6_HORDE_Prequest = "No"
Inst27Quest6_HORDE_Folgequest = "No"
--
Inst27Quest6name1_HORDE = "Masons Fraternity Ring"
Inst27Quest6name2_HORDE = "Engineer's Guild Headpiece"

--QUEST 7 Horde

Inst27Quest7_HORDE = "7. Gahz'rilla"
Inst27Quest7_HORDE_Level = "50"
Inst27Quest7_HORDE_Attain = "40"
Inst27Quest7_HORDE_Aim = "Bring Gahz'rilla's Electrified Scale to Wizzle Brassbolts in the Shimmering Flats."
Inst27Quest7_HORDE_Location = "Wizzle Brassbolts (Thousands Needles; "..YELLOW.."78,77 "..WHITE..")"
Inst27Quest7_HORDE_Note = "You can evocate Gahz'rilla at "..YELLOW.."[6]"..WHITE.."."
Inst27Quest7_HORDE_Prequest = "No"
Inst27Quest7_HORDE_Folgequest = "No"
--
Inst27Quest7name1_HORDE = "Carrot on a Stick"

--------------------------Stockade/verlies (6 quests)
Inst24Story = "La Prison est un complexe de haute s\195\169curit\195\169, cach\195\169 sous le quartier des canaux de Stormwind. Dirig\195\169e par le Gardien Thelwater, la Prison est le domaine des petits voyous, des protestataires, des assassins et de dizaines de criminels violents. R\195\169cemment, une r\195\169volte de prisonniers \195\160 d\195\169clench\195\169 le chaos dans la Prison – les gardes en ont \195\169t\195\169 chass\195\169s et les prisonniers ont pris le contr\195\180le des lieux. Le Gardien Thelwater est parvenu \195\160 s\'\195\169chapper et tente de recruter des t\195\170tes br\195\187l\195\169es pour s\'introduire dans la prison et liquider le chef des mutins, le rus\195\169 Bazil Thredd."
Inst24Caption = "La Prison"
Inst24QAA = "6 Quests"
Inst24QAH = "no Quests"



--QUEST 1 Allianz

Inst24Quest1 = "1. What Comes Around..."
Inst24Quest1_Level = "25"
Inst24Quest1_Attain = "22"
Inst24Quest1_Aim = "Bring the head of Targorr the Dread to Guard Berton in Lakeshire."
Inst24Quest1_Location = "Guard Berton (Redridgemountains; "..YELLOW.."26,46 "..WHITE..")"
Inst24Quest1_Note = "You find Targorr at "..YELLOW.."[1]"..WHITE.."."
Inst24Quest1_Prequest = "No"
Inst24Quest1_Folgequest = "No"
--
Inst24Quest1name1 = "Lucine Longsword"
Inst24Quest1name2 = "Hardened Root Staff"

--QUEST 2 Allianz

Inst24Quest2 = "2. Crime and Punishment"
Inst24Quest2_Level = "26"
Inst24Quest2_Attain = "22"
Inst24Quest2_Aim = "Councilman Millstipe of Darkshire wants you to bring him the hand of Dextren Ward."
Inst24Quest2_Location = "Millstipe (Duskwood - Darkshire; "..YELLOW.."72,47 "..WHITE..")"
Inst24Quest2_Note = "You find Dextren at "..YELLOW.."[5]"..WHITE.."."
Inst24Quest2_Prequest = "No"
Inst24Quest2_Folgequest = "No"
--
Inst24Quest2name1 = "Ambassador's Boots"
Inst24Quest2name2 = "Darkshire Mail Leggings"


--QUEST 3 Allianz

Inst24Quest3 = "3. Quell The Uprising"
Inst24Quest3_Level = "26"
Inst24Quest3_Attain = "22"
Inst24Quest3_Aim = "Warden Thelwater of Stormwind wants you to kill 10 Defias Prisoners, 8 Defias Convicts, and 8 Defias Insurgents in The Stockade."
Inst24Quest3_Location = "Warden Thelwater (Stormwind; "..YELLOW.."41,58 "..WHITE..")"
Inst24Quest3_Note = ""
Inst24Quest3_Prequest = "No"
Inst24Quest3_Folgequest = "No"

--QUEST 4 Allianz

Inst24Quest4 = "4. The Color of Blood"
Inst24Quest4_Level = "26"
Inst24Quest4_Attain = "?"
Inst24Quest4_Aim = "Nikova Raskol of Stormwind wants you to collect 10 Red Wool Bandanas."
Inst24Quest4_Location = "Nikova Raskol (Stormwind; "..YELLOW.."73,46 "..WHITE..")"
Inst24Quest4_Note = "Every Ennemy in the Instance drops the Bandanas."
Inst24Quest4_Prequest = "No"
Inst24Quest4_Folgequest = "No"

--QUEST 5 Allianz

Inst24Quest5 = "5. The Fury Runs Deep"
Inst24Quest5_Level = "27"
Inst24Quest5_Attain = "25"
Inst24Quest5_Aim = "Motley Garmason wants Kam Deepfury's head brought to him at Dun Modr."
Inst24Quest5_Location = "Motley Garmason (Wetlands; "..YELLOW.."49,18 "..WHITE..")"
Inst24Quest5_Note = "You get the prequest from Motley, too.\nYou find Kam Deepfury at "..YELLOW.."[2]"..WHITE.."."
Inst24Quest5_Prequest = "Yes, The Dark Iron War"
Inst24Quest5_Folgequest = "No"
Inst24Quest5PreQuest = "true"
--
Inst24Quest5name1 = "Belt of Vindication"
Inst24Quest5name2 = "Headbasher"


--QUEST 6 Allianz

Inst24Quest6 = "6. The Stockade Riots (Questline)"
Inst24Quest6_Level = "29"
Inst24Quest6_Attain = "16"
Inst24Quest6_Aim = "Kill Bazil Thredd and bring his head back to Warden Thelwater at the Stockade."
Inst24Quest6_Location = "Warden Thelwater (Stormwind; "..YELLOW.."41,58 "..WHITE..")"
Inst24Quest6_Note = "For more details about the prequest see "..YELLOW.."[Deadmines, The Defias Brotherhood]"..WHITE..".\n You find Bazil Thredd at "..YELLOW.."[4]"..WHITE.."."
Inst24Quest6_Prequest = "Yes, The Defias Brotherhood -> Bazil Thredd"
Inst24Quest6_Folgequest = "Yes, The Curious Visitor"
Inst24Quest6PreQuest = "true"



--------------Razorfen Downs/Inst17 ( 4 quests)------------
Inst17Story = "Taill\195\169es dans les m\195\170mes ronces g\195\169antes que le Kraal de Tranchebauge, les Souilles de Tranchebauge sont la capitale traditionnelle du peuple huran, le peuple des hommes-sangliers. Ce labyrinthe immense et h\195\169riss\195\169 d\'\195\169pines abrite une v\195\169ritable arm\195\169e de hurans loyaux et leurs grands pr\195\170tres – la tribu T\195\170te de Mort. Depuis peu, une ombre lugubre s\'\195\169tend sur ce domaine primitif. Des agents du Fl\195\169au mort-vivant, conduits par la liche Amnennar, dite le Porte-froid, ont pris le contr\195\180le du peuple huran et ont transform\195\169 le labyrinthe de ronces en un bastion de la puissance des morts-vivants. Les hurans livrent une bataille d\195\169sesp\195\169r\195\169e pour reconqu\195\169rir leur ville bien-aim\195\169e avant qu\'Amnennar n\'\195\169tende sa puissance sur les Tarides."
Inst17Caption = "Souilles de Tranchebauge"
Inst17QAA = "3 Quests"
Inst17QAH = "4 Quests"

--QUEST 1 Allianz

Inst17Quest1 = "1. A Host of Evil"
Inst17Quest1_Level = "35"
Inst17Quest1_Attain = "30"
Inst17Quest1_Aim = "Kill 8 Razorfen Battleguard, 8 Razorfen Thornweavers, and 8 Death's Head Cultists and return to Myriam Moonsinger near the entrance to Razorfen Downs."
Inst17Quest1_Location = "Myriam Moonsinger (The Barrens; "..YELLOW.."49,94 "..WHITE..")"
Inst17Quest1_Note = "You finde the mobs outside before you enter the instance."
Inst17Quest1_Prequest = "No"
Inst17Quest1_Folgequest = "No"

--QUEST 2 Allianz

Inst17Quest2 = "2. Extinguishing the Idol"
Inst17Quest2_Level = "37"
Inst17Quest2_Attain = "34"
Inst17Quest2_Aim = "Escort Belnistrasz to the Quilboar's idol in Razorfen Downs. Protect Belnistrasz while he performs the ritual to shut down the idol."
Inst17Quest2_Location = "Belnistrasz (Razorfen Downs; "..YELLOW..""..YELLOW.."[2]"..WHITE.." "..WHITE..")"
Inst17Quest2_Note = "You find Belnistrasz at "..YELLOW.."[2]"..WHITE.."."
Inst17Quest2_Prequest = "Yes, (At Belnistrasz)"
Inst17Quest2_Folgequest = "No"
Inst17Quest2PreQuest = "true"
--
Inst17Quest2name1 = "Dragonclaw Ring"

--QUEST 3 Allianz

Inst17Quest3 = "3. Bring the Light"
Inst17Quest3_Attain = "39"
Inst17Quest3_Level = "42"
Inst17Quest3_Aim = "Archbishop Bendictus wants you to slay Amnennar the Coldbringer in Razorfen Downs."
Inst17Quest3_Location = "Archbishop Bendictus (Stormwind; "..YELLOW.."39,27 "..WHITE..")"
Inst17Quest3_Note = "Amnennar the Coldbringer is the last Boss at Razorfen Downs. You can find him at "..YELLOW.."[6]"..WHITE.."."
Inst17Quest3_Prequest = "No"
Inst17Quest3_Folgequest = "No"
--
Inst17Quest3name1 = "Vanquisher's Sword"
Inst17Quest3name2 = "Amberglow Talisman"

--QUEST 1 Horde

Inst17Quest1_HORDE = "1. A Host of Evil"
Inst17Quest1_HORDE_Level = "35"
Inst17Quest1_HORDE_Attain = "30"
Inst17Quest1_HORDE_Aim = "Kill 8 Razorfen Battleguard, 8 Razorfen Thornweavers, and 8 Death's Head Cultists and return to Myriam Moonsinger near the entrance to Razorfen Downs."
Inst17Quest1_HORDE_Location = "Myriam Moonsinger (The Barrens; "..YELLOW.."49,94 "..WHITE..")"
Inst17Quest1_HORDE_Note = "You finde the mobs outside before you enter the instance."
Inst17Quest1_HORDE_Prequest = "No"
Inst17Quest1_HORDE_Folgequest = "No"

--Quest 2 Horde

Inst17Quest2_HORDE = "2. An Unholy Alliance"
Inst17Quest2_HORDE_Level = "36"
Inst17Quest2_HORDE_Attain = "?"
Inst17Quest2_HORDE_Aim = "Bring Ambassador Malcin's Head to Varimathras in the Undercity."
Inst17Quest2_HORDE_Location = "Varimathras  (Undercity; "..YELLOW.."56,92 "..WHITE..")"
Inst17Quest2_HORDE_Note = "You get the prequest from the last Boss in Razorfen Kraul.\n You find Malcin outside(The Barrens, 48,92)."
Inst17Quest2_HORDE_Prequest = "Yes, An Unholy Alliance"
Inst17Quest2_HORDE_Folgequest = "No"
Inst17Quest2PreQuest_HORDE = "true"
--
Inst17Quest2name1_HORDE = "Skullbreaker"
Inst17Quest2name2_HORDE = "Nail Spitter"
Inst17Quest2name3_HORDE = "Zealot's Robe"

-- Quest 3 Horde

Inst17Quest3_HORDE = "3. Extinguishing the Idol"
Inst17Quest3_HORDE_Level = "37"
Inst17Quest3_HORDE_Attain = "34"
Inst17Quest3_HORDE_Aim = "Escort Belnistrasz to the Quilboar's idol in Razorfen Downs. Protect Belnistrasz while he performs the ritual to shut down the idol."
Inst17Quest3_HORDE_Location = "Razorfen Downs; "..YELLOW..""..YELLOW.."[2]"..WHITE.." "..WHITE..")"
Inst17Quest3_HORDE_Note = "You find Belnistrasz at "..YELLOW.."[2]"..WHITE.."."
Inst17Quest3_HORDE_Prequest = "Yes, (At Belnistrasz)"
Inst17Quest3_HORDE_Folgequest = "No"
Inst17Quest3PreQuest_HORDE = "true"
--
Inst17Quest3name1_HORDE = "Dragonclaw Ring"

--QUEST 4 Horde

Inst17Quest4_HORDE = "4. Bring the End"
Inst17Quest4_HORDE_Attain = "37"
Inst17Quest4_HORDE_Level = "42"
Inst17Quest4_HORDE_Aim = "Andrew Brownell wants you to kill Amnennar the Coldbringer and return his skull."
Inst17Quest4_HORDE_Location = "Andrew Brownell (Untercity; "..YELLOW.."72,32 "..WHITE..")"
Inst17Quest4_HORDE_Note = "Amnennar the Coldbringer is the last Boss at Razorfen Downs. You can find him at "..YELLOW.."[6]"..WHITE.."."
Inst17Quest4_HORDE_Prequest = "No"
Inst17Quest4_HORDE_Folgequest = "No"
--
Inst17Quest4name1_HORDE = "Vanquisher's Sword"
Inst17Quest4name2_HORDE = "Amberglow Talisman"

--------------Kloster/SM ( 6 quests)------------
Inst19Story = "Le monast\195\168re \195\169tait autrefois un grand centre d\'\195\169ducation et d\'illumination, l\'orgueil de la pr\195\170trise de Lordaeron. Avec la venue du Fl\195\169au mort-vivant au cours de la Troisi\195\168me Guerre, ce paisible monast\195\168re devint la forteresse des fanatiques de la Croisade \195\169carlate. Les Crois\195\169s se montrent intol\195\169rants envers toutes les races non-humaines, quelles que soient leurs alliances ou leur affiliation. Soup\195\167onnant tous les \195\169trangers d\'\195\170tre porteurs de la Peste de la non-vie, ils les tuent sans h\195\169sitation. Les rapports indiquent que les aventuriers qui p\195\169n\195\168trent dans le monast\195\168re sont forc\195\169s d\'affronter le Commandant \195\169carlate Mograine, qui contr\195\180le une importante garnison de guerriers fanatiques. Toutefois, le vrai ma\195\174tre des lieux est la Grande inquisitrice Whithemane – une pr\195\170tresse qui poss\195\168de la capacit\195\169 de ressusciter les guerriers qui tombent en combattant pour elle."
Inst19Caption = "Le Monast\195\168re Ecarlate"
Inst19QAA = "3 Quests"
Inst19QAH = "6 Quests"

--QUEST 1 Allianz

Inst19Quest1 = "1. Mythology of the Titans"
Inst19Quest1_Level = "38"
Inst19Quest1_Attain = "?"
Inst19Quest1_Aim = "Retrieve Mythology of the Titans from the Monastery and bring it to Librarian Mae Paledust in Ironforge."
Inst19Quest1_Location = "Mae Paledust (Ironforge; "..YELLOW.."74,12 "..WHITE..")"
Inst19Quest1_Note = "You find the book in the Libary of Scarlet Monastery."
Inst19Quest1_Prequest = "No"
Inst19Quest1_Folgequest = "No"
--
Inst19Quest1name1 = "Explorers' League Commendation"

--QUEST 2 Allianz

Inst19Quest2 = "2. In the Name of the Light"
Inst19Quest2_Level = "40"
Inst19Quest2_Attain = "39"
Inst19Quest2_Aim = "Kill High Inquisitor Whitemane, Scarlet Commander Mograine, Herod, the Scarlet Champion and Houndmaster Loksey and then report back to Raleigh the Devout in Southshore."
Inst19Quest2_Location = "Raleigh the Devout (Hillsbrad Foothills, Southshore; "..YELLOW.."51,58 "..WHITE..")"
Inst19Quest2_Note = "The Questline starts at Brother Crowley (42,24 in Stormwind).\nYou find High Inquisitor Whitemane and Kommandant Mograinebei at "..YELLOW.."[5]"..WHITE..", the Herod at "..YELLOW.."[3]"..WHITE.." and Houndmaster Loksey at "..YELLOW.."[1]"..WHITE.."."
Inst19Quest2_Prequest = "Yes, Brother Anton -> Down the Scarlet Path"
Inst19Quest2_Folgequest = "No"
Inst19Quest2PreQuest = "true"
--
Inst19Quest2name1 = "Sword of Serenity"
Inst19Quest2name2 = "Bonebiter"
Inst19Quest2name3 = "Black Menace"
Inst19Quest2name4 = "Orb of Lorica"


--QUEST 3 Allianz MAGIER

Inst19Quest3 = "3. Rituals of Power (Mage)"
Inst19Quest3_Level = "40"
Inst19Quest3_Attain = "31"
Inst19Quest3_Aim = "Bring the book Rituals of Power to Tabetha in Dustwallow Marsh."
Inst19Quest3_Location = "Tabetha (Dustwallow Marsh; "..YELLOW.."43,57 "..WHITE..")"
Inst19Quest3_Note = "Only Mages can get this Quest!\nYou find the book in the Libary of Scarlet Monastery."
Inst19Quest3_Prequest = "Yes, Get the Scoop"
Inst19Quest3_Folgequest = "Yes, Mage's Wand"
Inst19Quest3PreQuest = "true"

--QUEST 1 Horde

Inst19Quest1_HORDE = "1. Vorrel's Revenge"
Inst19Quest1_HORDE_Level = "33"
Inst19Quest1_HORDE_Attain = "?"
Inst19Quest1_HORDE_Aim = "Return Vorrel Sengutz's wedding ring to Monika Sengutz in Tarren Mill."
Inst19Quest1_HORDE_Location = "Vorrel Sengutz (Scarlet Monastery, Graveyard)"
Inst19Quest1_HORDE_Note = "You find Vorrel Sengutz at the beginning of Scarlet Monastery Graveyard part. Nancy is in a hous in the Alterac Mountains(31,32). She has the Ring."
Inst19Quest1_HORDE_Prequest = "No"
Inst19Quest1_HORDE_Folgequest = "No"
--
Inst19Quest1name1_HORDE = "Vorrel's Boots"
Inst19Quest1name2_HORDE = "Mantle of Woe"
Inst19Quest1name3_HORDE = "Grimsteel Cape"

--Quest 2 Horde

Inst19Quest2_HORDE = "2. Hearts of Zeal"
Inst19Quest2_HORDE_Level = "33"
Inst19Quest2_HORDE_Attain = "?"
Inst19Quest2_HORDE_Aim = "Master Apothecary Faranell in the Undercity wants 20 Hearts of Zeal."
Inst19Quest2_HORDE_Location = "Master Apothecary Faranell  (Undercity; "..YELLOW.."48,69 "..WHITE..")"
Inst19Quest2_HORDE_Note = "For more details about the prequest see "..YELLOW.."[Razorfen Kraul]"..WHITE.."\nYou get the hearts from every mob in Scarlet Monastery."
Inst19Quest2_HORDE_Prequest = "Yes, Going, Going, Guano!"
Inst19Quest2_HORDE_Folgequest = "No"
Inst19Quest2PreQuest_HORDE = "true"


-- Quest 3 Horde

Inst19Quest3_HORDE = "3. Test of Lore (Questline)"
Inst19Quest3_HORDE_Level = "36"
Inst19Quest3_HORDE_Attain = "32"
Inst19Quest3_HORDE_Aim = "Find The Beginnings of the Undead Threat, and return it to Parqual Fintallas in Undercity."
Inst19Quest3_HORDE_Location = "Parqual Fintallas (Undercity; "..YELLOW.."57,65 "..WHITE..")"
Inst19Quest3_HORDE_Note = "Questline starts at Dorn Plainstalker (Thousand Needles (53,41).\n You find the book in the Libary of SM."
Inst19Quest3_HORDE_Prequest = "Yes, Test of Faith - > Test of Lore"
Inst19Quest3_HORDE_Folgequest = "Yes, Test of Lore"
Inst19Quest3PreQuest_HORDE = "true"

--QUEST 4 Horde

Inst19Quest4_HORDE = "4. Compendium of the Fallen"
Inst19Quest4_HORDE_Level = "38"
Inst19Quest4_HORDE_Attain = "?"
Inst19Quest4_HORDE_Aim = "Retrieve the Compendium of the Fallen from the Monastery in Tirisfal Glades and return to Sage Truthseeker in Thunder Bluff."
Inst19Quest4_HORDE_Location = "Sage Truthseeker (Thunderbluff; "..YELLOW.."34,47 "..WHITE..")"
Inst19Quest4_HORDE_Note = "You find the book in the Libary of Scarlet Monastery."
Inst19Quest4_HORDE_Prequest = "No"
Inst19Quest4_HORDE_Folgequest = "No"
--
Inst19Quest4name1_HORDE = "Vile Protector"
Inst19Quest4name2_HORDE = "Forcestone Buckler"
Inst19Quest4name3_HORDE = "Omega Orb"

--QUEST 5 Horde

Inst19Quest5_HORDE = "5. Into The Scarlet Monastery"
Inst19Quest5_HORDE_Level = "42"
Inst19Quest5_HORDE_Attain = "33"
Inst19Quest5_HORDE_Aim = "Kill High Inquisitor Whitemane, Scarlet Commander Mograine, Herod, the Scarlet Champion and Houndmaster Loksey and then report back to Varimathras in the Undercity."
Inst19Quest5_HORDE_Location = "Varimathras  (Undercity; "..YELLOW.."56,92 "..WHITE..")"
Inst19Quest5_HORDE_Note = "You find High Inquisitor Whitemane and Kommandant Mograinebei at "..YELLOW.."[5]"..WHITE..", the Herod at "..YELLOW.."[3]"..WHITE.." and Houndmaster Loksey at "..YELLOW.."[1]"..WHITE.."."
Inst19Quest5_HORDE_Prequest = "No"
Inst19Quest5_HORDE_Folgequest = "No"
--
Inst19Quest5name1_HORDE = "Sword of Omen"
Inst19Quest5name2_HORDE = "Prophetic Cane"
Inst19Quest5name3_HORDE = "Dragon's Blood Necklace"

--QUEST 6 Horde

Inst19Quest6_HORDE = "6. Rituals of Power (Mage)"
Inst19Quest6_HORDE_Level = "40"
Inst19Quest6_HORDE_Attain = "31"
Inst19Quest6_HORDE_Aim = "Bring the book Rituals of Power to Tabetha in Dustwallow Marsh."
Inst19Quest6_HORDE_Location = "Tabetha (Dustwallow Marsh; "..YELLOW.."46,57 "..WHITE..")"
Inst19Quest6_HORDE_Note = "Only Mages can get this Quest!\nYou find the book in the Libary of Scarlet Monastery."
Inst19Quest6_HORDE_Prequest = "Yes, Get the Scoop"
Inst19Quest6_HORDE_Folgequest = "Yes, Mage's Wand"
Inst19Quest6PreQuest_HORDE = "true"

--------------Kral ( 5 quests)------------
Inst18Story = "Il y a dix mille ans, au cours de la guerre des Anciens, le puissant demi-dieu Agamaggan partit affronter la L\195\169gion ardente. Le colossal sanglier tomba au combat, mais son sacrifice aida \195\160 pr\195\169server Azeroth de la d\195\169faite. Avec le temps, l\195\160 o\195\185 avait coul\195\169 son sang, d\'immenses plantes \195\169pineuses sortirent du sol. Les hurans, les hommes-sangliers, dont on suppose qu\'ils sont les descendants mortels du dieu, vinrent occuper ces r\195\169gions, sacr\195\169es pour eux. Le cœur de ces colonies de ronces g\195\169antes prit le nom de Tranchebauge. Une grande partie du Kraal a \195\169t\195\169 conquise par la vieille m\195\169g\195\168re Charlga Razorflank. Sous sa f\195\169rule, les hurans, pratiquant la foi chamanique, attaquent les tribus rivales et les villages de la Horde. À en croire les rumeurs, Charlga n\195\169gocierait avec des agents du Fl\195\169au, et serait en train de placer sa tribu, qui ne se doute de rien, parmi les rangs des morts-vivants pour une raison inconnue."
Inst18Caption = "Kraal de Tranchebauge"
Inst18QAA = "5 Quests"
Inst18QAH = "5 Quests"

--QUEST 1 Allianz

Inst18Quest1 = "1. Blueleaf Tubers"
Inst18Quest1_Level = "26"
Inst18Quest1_Attain = "20"
Inst18Quest1_Aim = "In Razorfen Kraul, use the Crate with Holes to summon a Snufflenose Gopher, and use the Command Stick on the gopher to make it search for Tubers. Bring 6 Blueleaf Tubers, the Snufflenose Command Stick and the Crate with Holes to Mebok Mizzyrix in Ratchet."
Inst18Quest1_Location = "Mebok Mizzyrix (The Barrens - Ratchet; "..YELLOW.."62,37"..WHITE..")"
Inst18Quest1_Note = "The Crate, the Stick and the Manual are near Mebok Mizzyrix."
Inst18Quest1_Prequest = "No"
Inst18Quest1_Folgequest = "No"
--
Inst18Quest1name1 = "A Small Container of Gems"

--QUEST 2 Allianz

Inst18Quest2 = "2. Mortality Wanes"
Inst18Quest2_Level = "30"
Inst18Quest2_Attain = "?"
Inst18Quest2_Aim = "Find and return Treshala's Pendant to Treshala Fallowbrook in Darnassus."
Inst18Quest2_Location = "Heraltha Fallowbrook (Razorfen Kraul; "..YELLOW.." "..YELLOW.."[8]"..WHITE..""..WHITE..")"
Inst18Quest2_Note = "The pendant is a random drop. You musst bring back the pendant to Treshala Fallowbrook in Darnassus (69,67)."
Inst18Quest2_Prequest = "No"
Inst18Quest2_Folgequest = "No"
--
Inst18Quest2name1 = "Mourning Shawl"
Inst18Quest2name2 = "Lancer Boots"

--QUEST 3 Allianz

Inst18Quest3 = "3. Willix the Importer"
Inst18Quest3_Level = "30"
Inst18Quest3_Attain = "?"
Inst18Quest3_Aim = "Escort Willix the Importer out of Razorfen Kraul."
Inst18Quest3_Location = "Willix the Importer (Razorfen Kraul; "..YELLOW.." "..YELLOW.."[8]"..WHITE..""..WHITE..")"
Inst18Quest3_Note = "Willix is at "..YELLOW.."[8]"..WHITE..". You musst bring him to the entrance."
Inst18Quest3_Prequest = "No"
Inst18Quest3_Folgequest = "No"
--
Inst18Quest3name1 = "Monkey Ring"
Inst18Quest3name2 = "Snake Hoop"
Inst18Quest3name3 = "Tiger Band"

--QUEST 4 Allianz

Inst18Quest4 = "4. The Crone of the Kraul"
Inst18Quest4_Level = "34"
Inst18Quest4_Attain = "30"
Inst18Quest4_Aim = "Bring Razorflank's Medallion to Falfindel Waywarder in Thalanaar."
Inst18Quest4_Location = "Falfindel Waywarder (Feralas; "..YELLOW.."89,46"..WHITE..")"
Inst18Quest4_Note = "Charlga Razorflank "..YELLOW.."[7]"..WHITE.." drop the Medallion ."
Inst18Quest4_Prequest = "Yes, Lonebrow's Journal"
Inst18Quest4_Folgequest = "Yes, The Crone of the Kraul"
Inst18Quest4PreQuest = "true"
--
Inst18Quest4name1 = "'Mage-Eye' Blunderbuss"
Inst18Quest4name2 = "Berylline Pads"
Inst18Quest4name3 = "Stonefist Girdle"
Inst18Quest4name4 = "Marbled Buckler"

--QUEST 5 Allianz KRIEGER

Inst18Quest5 = "5. Fire Hardened Mail (Warrior)"
Inst18Quest5_Level = "28"
Inst18Quest5_Attain = "20"
Inst18Quest5_Aim = "Gather the materials Furen Longbeard requires, and bring them to him in Stormwind."
Inst18Quest5_Location = "Furen Longbeard (Stormwind; "..YELLOW.."57,16"..WHITE..")"
Inst18Quest5_Note = "Only Warriors can get this Quest!\nYou get the Vial of Phlogiston at "..YELLOW.."[1]"..WHITE.."."
Inst18Quest5_Prequest = "Yes, The Shieldsmith"
Inst18Quest5_Folgequest = "Yes"
Inst18Quest5PreQuest = "true"


--QUEST 1 Horde

Inst18Quest1_HORDE = "1. Blueleaf Tubers"
Inst18Quest1_HORDE_Level = "26"
Inst18Quest1_HORDE_Attain = "20"
Inst18Quest1_HORDE_Aim = "In Razorfen Kraul, use the Crate with Holes to summon a Snufflenose Gopher, and use the Command Stick on the gopher to make it search for Tubers. Bring 6 Blueleaf Tubers, the Snufflenose Command Stick and the Crate with Holes to Mebok Mizzyrix in Ratchet."
Inst18Quest1_HORDE_Location = "Mebok Mizzyrix (The Barrens - Ratchet; "..YELLOW.."62,37"..WHITE..")"
Inst18Quest1_HORDE_Note = "The Crate, the Stick and the Manual are near Mebok Mizzyrix."
Inst18Quest1_HORDE_Prequest = "No"
Inst18Quest1_HORDE_Folgequest = "No"
--
Inst18Quest1name1_HORDE = "A Small Container of Gems"

--Quest 2 Horde

Inst18Quest2_HORDE = "2. Willix the Importer"
Inst18Quest2_HORDE_Level = "30"
Inst18Quest2_HORDE_Attain = "?"
Inst18Quest2_HORDE_Aim = "Escort Willix the Importer out of Razorfen Kraul."
Inst18Quest2_HORDE_Location = "Willix the Importer (Razorfen Kraul; "..YELLOW.." "..YELLOW.."[8]"..WHITE..""..WHITE..")"
Inst18Quest2_HORDE_Note = "Willix is at "..YELLOW.."[8]"..WHITE..". You musst bring him to the entrance."
Inst18Quest2_HORDE_Prequest = "No"
Inst18Quest2_HORDE_Folgequest = "No"
--
Inst18Quest2name1_HORDE = "Monkey Ring"
Inst18Quest2name2_HORDE = "Snake Hoop"
Inst18Quest2name3_HORDE = "Tiger Band"

-- Quest 3 Horde

Inst18Quest3_HORDE = "3. Going, Going, Guano!"
Inst18Quest3_HORDE_Level = "33"
Inst18Quest3_HORDE_Attain = "?"
Inst18Quest3_HORDE_Aim = "Bring 1 pile of Kraul Guano to Master Apothecary Faranell in the Undercity."
Inst18Quest3_HORDE_Location = "Faranell (Undercity; "..YELLOW.."48,69 "..WHITE..")"
Inst18Quest3_HORDE_Note = "Every Bat drop the Kraul Guano."
Inst18Quest3_HORDE_Prequest = "No"
Inst18Quest3_HORDE_Folgequest = "Yes, Hearts of Zeal (Look "..YELLOW.."[Razorfen Downs]"..WHITE..")"

--QUEST 4 Horde

Inst18Quest4_HORDE = "4. A Vengeful Fate"
Inst18Quest4_HORDE_Level = "34"
Inst18Quest4_HORDE_Attain = "29"
Inst18Quest4_HORDE_Aim = "Bring Razorflank's Heart to Auld Stonespire in Thunder Bluff."
Inst18Quest4_HORDE_Location = "Auld Stonespire (Thunderbluff; "..YELLOW.."36,59 "..WHITE..")"
Inst18Quest4_HORDE_Note = "You find Charlga Razorflank at "..YELLOW.."[7]"..WHITE..""
Inst18Quest4_HORDE_Prequest = "No"
Inst18Quest4_HORDE_Folgequest = "No"
--
Inst18Quest4name1_HORDE = "Berylline Pads"
Inst18Quest4name2_HORDE = "Stonefist Girdle"
Inst18Quest4name3_HORDE = "Marbled Buckler"

--QUEST 5 Horde

Inst18Quest5_HORDE = "5. Brutal Armor (Warrior)"
Inst18Quest5_HORDE_Level = "30"
Inst18Quest5_HORDE_Attain = "20"
Inst18Quest5_HORDE_Aim = "Bring to Thun'grim Firegaze 15 Smoky Iron Ingots, 10 Powdered Azurite, 10 Iron Bars and a Vial of Phlogiston."
Inst18Quest5_HORDE_Location = "Thun'grim Firegaze (The Barrens; "..YELLOW.."57,30 "..WHITE..")"
Inst18Quest5_HORDE_Note = "Only Warrior can get this Quest!\nYou get the Vial of Phlogiston at "..YELLOW.."[1]"..WHITE.."."
Inst18Quest5_HORDE_Prequest = "Yes, Speak with Thun'grim"
Inst18Quest5_HORDE_Folgequest = "Yes"
Inst18Quest5PreQuest_HORDE = "true"

--------------Scholo ( 9 quests)------------
Inst20Story = "  La Scholomance se trouve dans une s\195\169rie de cryptes, sous le donjon en ruine de Caer Darrow. C\'\195\169tait autrefois le domaine de la noble famille Barov, mais il tomba au cours de la Deuxi\195\168me Guerre. Lorsque le mage Kel\'thuzad recrutait des disciples pour former le Culte des Damn\195\169s, il promettait souvent l\'immortalit\195\169 en \195\169change de la promesse de servir le Roi-liche. La famille Barov succomba au charisme de Kel\'thuzad et donna son donjon et ses cryptes au Fl\195\169au. Les sectateurs tu\195\168rent les Barov et transform\195\168rent les cryptes en une \195\169cole de n\195\169cromancie, la Scholomance. Kel\'thuzad ne r\195\169side plus dans les cryptes, mais elles sont encore infest\195\169es de fanatiques et de leurs instructeurs. La liche Ras Frostwhisper r\195\168gne sur les lieux et les prot\195\169ge au nom du Fl\195\169au. Quant au n\195\169cromancien mortel, le Sombre Ma\195\174tre Gandling, il sert de directeur \195\160 l\'\195\169cole."
Inst20Caption = "Scholomance"
Inst20QAA = "9 Quests"
Inst20QAH = "9 Quests"

--QUEST 1 Allianz

Inst20Quest1 = "1. Plagued Hatchlings"
Inst20Quest1_Attain = "55"
Inst20Quest1_Level = "58"
Inst20Quest1_Aim = "Kill 20 Plagued Hatchlings, then return to Betina Bigglezink at the Light's Hope Chapel."
Inst20Quest1_Location = "Betina Bigglezink (Eastern Plaguelands - Light's Hope Chapel; "..YELLOW.."81,59"..WHITE..")"
Inst20Quest1_Note = ""
Inst20Quest1_Prequest = "No"
Inst20Quest1_Folgequest = "Yes, Healthy Dragon Scale"

--QUEST 2 Allianz

Inst20Quest2 = "2. Healthy Dragon Scale"
Inst20Quest2_Attain = ""
Inst20Quest2_Level = "58"
Inst20Quest2_Aim = "Bring the Healthy Dragon Scale to Betina Bigglezink at the Light's Hope Chapel in Eastern Plaguelands."
Inst20Quest2_Location = "Healthy Dragon Scale (Drop) (Scholomance)"
Inst20Quest2_Note = "Plagued Hatchlings drop the Healthy Dragon Scale (8% Dropchance). You find Betina Bigglezink at 81,59."
Inst20Quest2_Prequest = "Yes, Plagued Hatchlings "
Inst20Quest2_Folgequest = "No"
Inst20Quest2FQuest = "true"

--QUEST 3 Allianz

Inst20Quest3 = "3. Doctor Theolen Krastinov, the Butcher"
Inst20Quest3_Attain = "55"
Inst20Quest3_Level = "60"
Inst20Quest3_Aim = "Find Doctor Theolen Krastinov inside the Scholomance. Destroy him, then burn the Remains of Eva Sarkhoff and the Remains of Lucien Sarkhoff. Return to Eva Sarkhoff when the task is complete."
Inst20Quest3_Location = "Eva Sarkhoff (Western Plaguelands; "..YELLOW.."70,73"..WHITE..")"
Inst20Quest3_Note = "You find Doctor Theolen Krastinov at "..YELLOW.."[9]"..WHITE.."."
Inst20Quest3_Prequest = "No"
Inst20Quest3_Folgequest = "Yes, Krastinov's Bag of Horrors"

--QUEST 4 Allianz

Inst20Quest4 = "4. Krastinov's Bag of Horrors"
Inst20Quest4_Attain = "55"
Inst20Quest4_Level = "60"
Inst20Quest4_Aim = "Locate Yesndice Barov in the Scholomance and destroy her. From her corpse recover Krastinov's Bag of Horrors. Return the bag to Eva Sarkhoff."
Inst20Quest4_Location = "Eva Sarkhoff (Western Plaguelands; "..YELLOW.."70,73"..WHITE..")"
Inst20Quest4_Note = "You find Yesndice Barov at "..YELLOW.."[3]"..WHITE.."."
Inst20Quest4_Prequest = "Yes, Doctor Theolen Krastinov, the Butcher"
Inst20Quest4_Folgequest = "Yes, Kirtonos the Herald"
Inst20Quest4FQuest = "true"

--QUEST 5 Allianz

Inst20Quest5 = "5. Kirtonos the Herald"
Inst20Quest5_Attain = "56"
Inst20Quest5_Level = "60"
Inst20Quest5_Aim = "Return to the Scholomance with the Blood of Innocents. Find the porch and place the Blood of Innocents in the brazier. Kirtonos will come to feast upon your soul. Fight valiantly, do not give an inch! Destroy Kirtonos and return to Eva Sarkhoff."
Inst20Quest5_Location = "Eva Sarkhoff (Western Plaguelands; "..YELLOW.."70,73"..WHITE..")"
Inst20Quest5_Note = "The porch is at "..YELLOW.."[2]"..WHITE.."."
Inst20Quest5_Prequest = "Yes, Krastinov's Bag of Horrors"
Inst20Quest5_Folgequest = "Yes, The Human, Ras Frostwhisper"
Inst20Quest5FQuest = "true"
--
Inst20Quest5name1 = "Spectral Essence"
Inst20Quest5name2 = "Penelope's Rose"
Inst20Quest5name3 = "Mirah's Song"

--QUEST 6 Allianz

Inst20Quest6 = "6. The Lich, Ras Frostwhisper"
Inst20Quest6_Attain = "60"
Inst20Quest6_Level = "60"
Inst20Quest6_Aim = "Find Ras Frostwhisper in the Scholomance. When you have found him, use the Soulbound Keepsake on his undead visage. Should you succeed in reverting him to a mortal, strike him down and recover the Human Head of Ras Frostwhisper. Take the head back to Magistrate Marduke."
Inst20Quest6_Location = "Magistrate Marduke (Western Plaguelands; "..YELLOW.."70,73"..WHITE..")"
Inst20Quest6_Note = "You find Ras Frostwhisper at "..YELLOW.."[7]"..WHITE.."."
Inst20Quest6_Prequest = "Yes, The Human, Ras Frostwhisper - > Soulbound Keepsake"
Inst20Quest6_Folgequest = "No"
Inst20Quest6PreQuest = "true"
--
Inst20Quest6name1 = "Darrowshire Strongguard"
Inst20Quest6name2 = "Warblade of Caer Darrow"
Inst20Quest6name3 = "Crown of Caer Darrow"
Inst20Quest6name4 = "Darrowspike"

--QUEST 7 Allianz

Inst20Quest7 = "7. Barov Family Fortune"
Inst20Quest7_Attain = "60"
Inst20Quest7_Level = "60"
Inst20Quest7_Aim = "Venture to the Scholomance and recover the Barov family fortune. Four deeds make up this fortune: The Deed to Caer Darrow; The Deed to Brill; The Deed to Tarren Mill; and The Deed to Southshore. Return to Weldon Barov when you have completed this task."
Inst20Quest7_Location = "Weldon Barov (Western Plaguelands; "..YELLOW.."43,83"..WHITE..")"
Inst20Quest7_Note = "You find The Deed to Caer Darrow at "..YELLOW.."[12]"..WHITE..", The Deed to Brill at "..YELLOW.."[7]"..WHITE..", The Deed to Tarren Mill at "..YELLOW.."[4]"..WHITE.." and The Deed to Southshore at "..YELLOW.."[1]"..WHITE.."."
Inst20Quest7_Prequest = "No"
Inst20Quest7_Folgequest = "Yes, The Last Barov"

--QUEST 8 Allianz

Inst20Quest8 = "8. Dawn's Gambit"
Inst20Quest8_Attain = "59"
Inst20Quest8_Level = "60"
Inst20Quest8_Aim = "Place Dawn's Gambit in the Viewing Room of the Scholomance. Defeat Vectus, then return to Betina Bigglezink."
Inst20Quest8_Location = "Betina Bigglezink (Eastern Plaguelands - Light's Hope Chapel; "..YELLOW.."81,59"..WHITE..")"
Inst20Quest8_Note = "Broodling Essence begins at Tinkee Steamboil (Burning Steppes, 65,23). The Viewing Room is at "..YELLOW.."[6]"..WHITE.."."
Inst20Quest8_Prequest = "Yes, Broodling Essence - > Betina Bigglezink"
Inst20Quest8_Folgequest = "No"
Inst20Quest8PreQuest = "true"
--
Inst20Quest8name1 = "Windreaper"
Inst20Quest8name2 = "Dancing Sliver"

--QUEST 9 Allaince

Inst20Quest9 = "9. Imp Delivery (Warlock)"
Inst20Quest9_Attain = "60"
Inst20Quest9_Level = "60"
Inst20Quest9_Aim = "Bring the Imp in a Yesr to the alchemy lab in the Scholomance. After the parchment is created, return the jar to Gorzeeki Wildeyes."
Inst20Quest9_Location = "Gorzeeki Wildeyes (Burning Steppes; "..YELLOW.."12,31"..WHITE..")"
Inst20Quest9_Note = "Only Warlocks can get this Quest! You find the alchemy lab at "..YELLOW.."[3']"..WHITE.."."
Inst20Quest9_Prequest = "Yes, Mor'zul Bloodbringer - > Xorothian Stardust"
Inst20Quest9_Folgequest = "Yes, Dreadsteed of Xoroth"
Inst20Quest9PreQuest = "true"



--QUEST 1 Horde

Inst20Quest1_HORDE = "1. Plagued Hatchlings"
Inst20Quest1_HORDE_Attain = "55"
Inst20Quest1_HORDE_Level = "58"
Inst20Quest1_HORDE_Aim = "Kill 20 Plagued Hatchlings, then return to Betina Bigglezink at the Light's Hope Chapel."
Inst20Quest1_HORDE_Location = "Betina Bigglezink (Eastern Plaguelands - Light's Hope Chapel; "..YELLOW.."81,59"..WHITE..")"
Inst20Quest1_HORDE_Note = ""
Inst20Quest1_HORDE_Prequest = "No"
Inst20Quest1_HORDE_Folgequest = "No"


--QUEST 2 Horde

Inst20Quest2_HORDE = "2. Healthy Dragon Scale"
Inst20Quest2_HORDE_Attain = ""
Inst20Quest2_HORDE_Level = "58"
Inst20Quest2_HORDE_Aim = "Bring the Healthy Dragon Scale to Betina Bigglezink at the Light's Hope Chapel in Eastern Plaguelands."
Inst20Quest2_HORDE_Location = "Healthy Dragon Scale (Drop) (Scholomance)"
Inst20Quest2_HORDE_Note = "Plagued Hatchlings drop the Healthy Dragon Scale (8% Dropchance). You find Betina Bigglezink at 81,59."
Inst20Quest2_HORDE_Prequest = "Yes, Plagued Hatchlings "
Inst20Quest2_HORDE_Folgequest = "No"
Inst20Quest2FQuest_HORDE = "true"


--QUEST 3 Horde

Inst20Quest3_HORDE = "3. Doctor Theolen Krastinov, the Butcher"
Inst20Quest3_HORDE_Attain = "55"
Inst20Quest3_HORDE_Level = "60"
Inst20Quest3_HORDE_Aim = "Find Doctor Theolen Krastinov inside the Scholomance. Destroy him, then burn the Remains of Eva Sarkhoff and the Remains of Lucien Sarkhoff. Return to Eva Sarkhoff when the task is complete."
Inst20Quest3_HORDE_Location = "Eva Sarkhoff (Western Plaguelands; "..YELLOW.."70,73"..WHITE..")"
Inst20Quest3_HORDE_Note = "You find Doctor Theolen Krastinov at "..YELLOW.."[9]"..WHITE.."."
Inst20Quest3_HORDE_Prequest = "No"
Inst20Quest3_HORDE_Folgequest = "Yes, Krastinov's Bag of Horrors"

--QUEST 4 Horde

Inst20Quest4_HORDE = "4. Krastinov's Bag of Horrors"
Inst20Quest4_HORDE_Attain = "55"
Inst20Quest4_HORDE_Level = "60"
Inst20Quest4_HORDE_Aim = "Locate Yesndice Barov in the Scholomance and destroy her. From her corpse recover Krastinov's Bag of Horrors. Return the bag to Eva Sarkhoff."
Inst20Quest4_HORDE_Location = "Eva Sarkhoff (Western Plaguelands; "..YELLOW.."70,73"..WHITE..")"
Inst20Quest4_HORDE_Note = "You find Yesndice Barov at "..YELLOW.."[3]"..WHITE.."."
Inst20Quest4_HORDE_Prequest = "Yes, Doctor Theolen Krastinov, the Butcher"
Inst20Quest4_HORDE_Folgequest = "Yes, Kirtonos the Herald"
Inst20Quest4FQuest_HORDE = "true"


--QUEST 5 Horde

Inst20Quest5_HORDE = "5. Kirtonos the Herald"
Inst20Quest5_HORDE_Attain = "56"
Inst20Quest5_HORDE_Level = "60"
Inst20Quest5_HORDE_Aim = "Return to the Scholomance with the Blood of Innocents. Find the porch and place the Blood of Innocents in the brazier. Kirtonos will come to feast upon your soul. Fight valiantly, do not give an inch! Destroy Kirtonos and return to Eva Sarkhoff."
Inst20Quest5_HORDE_Location = "Eva Sarkhoff (Western Plaguelands; "..YELLOW.."70,73"..WHITE..")"
Inst20Quest5_HORDE_Note = "The porch is at "..YELLOW.."[2]"..WHITE.."."
Inst20Quest5_HORDE_Prequest = "Yes, Krastinov's Bag of Horrors"
Inst20Quest5_HORDE_Folgequest = "Yes, The Human, Ras Frostwhisper"
Inst20Quest5FQuest_HORDE = "true"
--
Inst20Quest5name1_HORDE = "Spectral Essence"
Inst20Quest5name2_HORDE = "Penelope's Rose"
Inst20Quest5name3_HORDE = "Mirah's Song"

--QUEST 6 Horde

Inst20Quest6_HORDE = "6. The Lich, Ras Frostwhisper"
Inst20Quest6_HORDE_Attain = "60"
Inst20Quest6_HORDE_Level = "60"
Inst20Quest6_HORDE_Aim = "Find Ras Frostwhisper in the Scholomance. When you have found him, use the Soulbound Keepsake on his undead visage. Should you succeed in reverting him to a mortal, strike him down and recover the Human Head of Ras Frostwhisper. Take the head back to Magistrate Marduke."
Inst20Quest6_HORDE_Location = "Magistrate Marduke (Western Plaguelands; "..YELLOW.."70,73"..WHITE..")"
Inst20Quest6_HORDE_Note = "You find Ras Frostwhisper at "..YELLOW.."[7]"..WHITE.."."
Inst20Quest6_HORDE_Prequest = "Yes, The Human, Ras Frostwhisper - > Soulbound Keepsake"
Inst20Quest6_HORDE_Folgequest = "No"
Inst20Quest6PreQuest_HORDE = "true"
--
Inst20Quest6name1_HORDE = "Darrowshire Strongguard"
Inst20Quest6name2_HORDE = "Warblade of Caer Darrow"
Inst20Quest6name3_HORDE = "Crown of Caer Darrow"
Inst20Quest6name4_HORDE = "Darrowspike"

--QUEST 7 Horde

Inst20Quest7_HORDE = "7. Barov Family Fortune"
Inst20Quest7_HORDE_Attain = "60"
Inst20Quest7_HORDE_Level = "60"
Inst20Quest7_HORDE_Aim = "Venture to the Scholomance and recover the Barov family fortune. Four deeds make up this fortune: The Deed to Caer Darrow; The Deed to Brill; The Deed to Tarren Mill; and The Deed to Southshore. Return to Alexi Barov when you have completed this task."
Inst20Quest7_HORDE_Location = "Alexi Barov (Western Plaguelands; "..YELLOW.."28,57"..WHITE..")"
Inst20Quest7_HORDE_Note = "You find The Deed to Caer Darrow at "..YELLOW.."[12]"..WHITE..", The Deed to Brill at "..YELLOW.."[7]"..WHITE..", The Deed to Tarren Mill at "..YELLOW.."[4]"..WHITE.." and The Deed to Southshore at "..YELLOW.."[1]"..WHITE.."."
Inst20Quest7_HORDE_Prequest = "No"
Inst20Quest7_HORDE_Folgequest = "Yes, The Last Barov"


--QUEST 8 Horde

Inst20Quest8_HORDE = "8. Dawn's Gambit"
Inst20Quest8_HORDE_Attain = "59"
Inst20Quest8_HORDE_Level = "60"
Inst20Quest8_HORDE_Aim = "Place Dawn's Gambit in the Viewing Room of the Scholomance. Defeat Vectus, then return to Betina Bigglezink."
Inst20Quest8_HORDE_Location = "Betina Bigglezink (Eastern Plaguelands - Light's Hope Chapel; "..YELLOW.."81,59"..WHITE..")"
Inst20Quest8_HORDE_Note = "Broodling Essence begins at Tinkee Steamboil (Burning Steppes, 65,23). The Viewing Room is at "..YELLOW.."[6]"..WHITE.."."
Inst20Quest8_HORDE_Prequest = "Yes, Broodling Essence - > Betina Bigglezink"
Inst20Quest8_HORDE_Folgequest = "No"
Inst20Quest8PreQuest_HORDE = "true"
--
Inst20Quest8name1_HORDE = "Windreaper"
Inst20Quest8name2_HORDE = "Dancing Sliver"

--QUEST 9 Horde

Inst20Quest9_HORDE = "9. Imp Delivery (Warlock)"
Inst20Quest9_HORDE_Attain = "60"
Inst20Quest9_HORDE_Level = "60"
Inst20Quest9_HORDE_Aim = "Bring the Imp in a Yesr to the alchemy lab in the Scholomance. After the parchment is created, return the jar to Gorzeeki Wildeyes."
Inst20Quest9_HORDE_Location = "Gorzeeki Wildeyes (Burning Steppes; "..YELLOW.."12,31"..WHITE..")"
Inst20Quest9_HORDE_Note = "Only Warlocks can get this Quest! You find the alchemy lab at "..YELLOW.."[3']"..WHITE.."."
Inst20Quest9_HORDE_Prequest = "Yes, Mor'zul Bloodbringer - > Xorothian Stardust"
Inst20Quest9_HORDE_Folgequest = "Yes, Dreadsteed of Xoroth"
Inst20Quest9PreQuest_HORDE = "true"

--------------Inst7/BFD(6  quests)------------
Inst7Story = "Situ\195\169 le long de la gr\195\168ve de Zoram, en Ashenvale, les profondeurs de Brassenoire \195\169taient autrefois un merveilleux temple, d\195\169di\195\169 \195\160 \195\137lune, la d\195\169esse-lune des elfes de la nuit. La Grande Fracture a englouti le temple sous les vagues de la Mer voil\195\169e. Il y est rest\195\169, intouch\195\169, jusqu\'\195\160 ce que les nagas et les satyres, attir\195\169s par son pouvoir ancien, \195\169mergent pour fouiller ses secrets. À en croire la l\195\169gende, la b\195\170te ancienne nomm\195\169e Aku\'mai s\'y est install\195\169e. Aku\'mai, qui \195\169tait le familier favori des Anciens dieux primordiaux, s\195\169vit dans la r\195\169gion depuis fort longtemps. Attir\195\169 par la pr\195\169sence d\'Aku\'mai, le culte connu sous le nom de Marteau du cr\195\169puscule est venu savourer la pr\195\169sence mal\195\169fique des Anciens dieux."
Inst7Caption = "Profondeurs de Brassenoire"
Inst7QAA = "6 Quests"
Inst7QAH = "5 Quests"

--QUEST 1 Allianz

Inst7Quest1 = "1. Knowledge in the Deeps"
Inst7Quest1_Attain = "18"
Inst7Quest1_Level = "23"
Inst7Quest1_Aim = "Bring the Lorgalis Manuscript to Gerrig Bonegrip in the Forlorn Cavern in Ironforge."
Inst7Quest1_Location = "Gerrig Bonegrip (Ironforge; "..YELLOW.."50,5"..WHITE..")"
Inst7Quest1_Note = "You find the Manuscript near "..YELLOW.."[2]"..WHITE.." in the water."
Inst7Quest1_Prequest = "No"
Inst7Quest1_Folgequest = "No"
--
Inst7Quest1name1 = "Sustaining Ring"

--QUEST 2 Allianz

Inst7Quest2 = "2. Researching the Corruption "
Inst7Quest2_Attain = "19"
Inst7Quest2_Level = "24"
Inst7Quest2_Aim = "Gershala Nightwhisper in Auberdine wants 8 Corrupt Brain stems."
Inst7Quest2_Location = "Gershala Nightwhisper (Darkshore - Auberdine; "..YELLOW.."38,43"..WHITE..")"
Inst7Quest2_Note = "You get the Prequest from Argos Nightwhisper (Stormwind; 21,55). Alle Nagas before and in Blackfathomdeeps drop the brains."
Inst7Quest2_Prequest = "Yes, The Corruption Abroad"
Inst7Quest2_Folgequest = "No"
Inst7Quest2PreQuest = "true"
--
Inst7Quest2name1 = "Beetle Clasps"
Inst7Quest2name2 = "Prelacy Cape"

--QUEST 3 Allianz

Inst7Quest3 = "3. In Search of Thaelrid"
Inst7Quest3_Attain = "19"
Inst7Quest3_Level = "24"
Inst7Quest3_Aim = "Seek out Argent Guard Thaelrid in Blackfathom Deeps."
Inst7Quest3_Location = "Argent Guard Shaedlass (Darnassus; "..YELLOW.."55,24"..WHITE..")"
Inst7Quest3_Note = "You find Argent Guard Thaelrid at "..YELLOW.."[4]"..WHITE.."."
Inst7Quest3_Prequest = "No"
Inst7Quest3_Folgequest = "Yes, Blackfathom Villainy"

--QUEST 4 Alliance

Inst7Quest4 = "4. Blackfathom Villainy"
Inst7Quest4_Attain = "-"
Inst7Quest4_Level = "27"
Inst7Quest4_Aim = "Bring the head of Twilight Lord Kelris to Dawnwatcher Selgorm in Darnassus."
Inst7Quest4_Location = "Argent Guard Thaelrid (Blackfathomtiefen; "..YELLOW..""..YELLOW.."[4]"..WHITE..""..WHITE..")"
Inst7Quest4_Note = "You get this Quest from Thaelrid at "..YELLOW.."[4]"..WHITE..". Kelris is at "..YELLOW.."[8]"..WHITE..". ATTENTION! If you turn on the flames beside Lord Kelris Ennemys appear and attack you. You find Dawnwatcher Selgorm in Darnassus (55,24)"
Inst7Quest4_Prequest = "Yes, In Search of Thaelrid"
Inst7Quest4_Folgequest = "No"
Inst7Quest4FQuest = "true"
--
Inst7Quest4name1 = "Gravestone Scepter"
Inst7Quest4name2 = "Arctic Buckler"

--QUEST 5 Alliance

Inst7Quest5 = "5. Twilight Falls"
Inst7Quest5_Attain = "20"
Inst7Quest5_Level = "25"
Inst7Quest5_Aim = "Bring 10 Twilight Pendants to Argent Guard Manados in Darnassus."
Inst7Quest5_Location = "Argent Guard Manados (Darnassus; "..YELLOW.."55,23"..WHITE..")"
Inst7Quest5_Note = "Every Twilight-Enemy drop the Pendant."
Inst7Quest5_Prequest = "No"
Inst7Quest5_Folgequest = "No"
--
Inst7Quest5name1 = "Nimbus Boots"
Inst7Quest5name2 = "Heartwood Girdle"

--QUEST 6 Alliance (hexenmeister)

Inst7Quest6 = "6. The Orb of Soran'ruk (Warlock)"
Inst7Quest6_Attain = "21"
Inst7Quest6_Level = "26"
Inst7Quest6_Aim = "Find 3 Soran'ruk Fragments and 1 Large Soran'ruk Fragment and return them to Doan Karhan in the Barrens."
Inst7Quest6_Location = "Doan Karhan (Barrens; "..YELLOW.."49,67"..WHITE..")"
Inst7Quest6_Note = "Only Warlocks can get this Quest! You get the 3 Soran'ruk Fragmentes from Twilight-Akolyts in "..YELLOW.."[Blackfathomdeeps]"..WHITE..". You get the Large Soran'ruk Fragment in "..YELLOW.."[Shadowfang Keep]"..WHITE.." from Shadowfang Darksouls."
Inst7Quest6_Prequest = "No"
Inst7Quest6_Folgequest = "No"
--
Inst7Quest6name1 = "Orb of Soran'ruk"
Inst7Quest6name2 = "Staff of Soran'ruk"


--QUEST 1 Horde

Inst7Quest1_HORDE = "1. The Essence of Aku'Mai "
Inst7Quest1_HORDE_Attain = "17"
Inst7Quest1_HORDE_Level = "22"
Inst7Quest1_HORDE_Aim = "Bring 20 Sapphires of Aku'Mai to Je'neu Sancrea in Ashenvale."
Inst7Quest1_HORDE_Location = "Je'neu Sancrea (Ashenvale - Zorambeach; "..YELLOW.."11,33"..WHITE..")"
Inst7Quest1_HORDE_Note = "You get the prequest Trouble in the Deeps from Tsunaman (Stonetalon Mountains, 47,64). Die Sapphire findet man vor der Instanz in den G\195\164ngen."
Inst7Quest1_HORDE_Prequest = "Yes, \195\132rger in der Tiefe"
Inst7Quest1_HORDE_Folgequest = "No"
Inst7Quest1PreQuest_HORDE = "true"

--QUEST 2 Horde

Inst7Quest2_HORDE = "2. Allegiance to the Old Gods"
Inst7Quest2_HORDE_Attain = "-"
Inst7Quest2_HORDE_Level = "26"
Inst7Quest2_HORDE_Aim = "Bring the Damp Note to Je'neu Sancrea in Ashenvale -> Kill Lorgus Jett in Blackfathom Deeps and then return to Je'neu Sancrea in Ashenvale."
Inst7Quest2_HORDE_Location = "Damp Note (drop) (Blackfathomdeeps; "..YELLOW..""..WHITE..")"
Inst7Quest2_HORDE_Note = "You get the dump Note from Blackfathom Tide Priestess (5% dropchance). Lorgus Jett is at "..YELLOW.."[6]"..WHITE.."."
Inst7Quest2_HORDE_Prequest = "No"
Inst7Quest2_HORDE_Folgequest = "No"
--
Inst7Quest2name1_HORDE = "Band of the Fist"
Inst7Quest2name2_HORDE = "Chestnut Mantle"

--QUEST 3 Horde

Inst7Quest3_HORDE = "3. Amongst the Ruins"
Inst7Quest3_HORDE_Attain = "-"
Inst7Quest3_HORDE_Level = "27"
Inst7Quest3_HORDE_Aim = "Bring the Fathom Core to Je'neu Sancrea at Zoram'gar Outpost, Ashenvale."
Inst7Quest3_HORDE_Location = "Je'neu Sancrea (Ashenvale - Zorambeach; "..YELLOW.."11,33"..WHITE..")"
Inst7Quest3_HORDE_Note = "You find the Fathom Core at "..YELLOW.."[7]"..WHITE.." in the water. When you get the Core Lord Aquanis appear and attack you. He drops a questitem which you have to bring to Je'neu Sancrea (Ashenvale - Zorambeach; 11,33)"
Inst7Quest3_HORDE_Prequest = "No"
Inst7Quest3_HORDE_Folgequest = "No"

--QUEST 4 Horde

Inst7Quest4_HORDE = "4. Blackfathom Villainy"
Inst7Quest4_HORDE_Attain = "-"
Inst7Quest4_HORDE_Level = "27"
Inst7Quest4_HORDE_Aim = "Bring the head of Twilight Lord Kelris to Bashana Runetotem in Thunder Bluff."
Inst7Quest4_HORDE_Location = "Argent guard Thaelrid (Blackfathomdeeps; "..YELLOW..""..YELLOW.."[4]"..WHITE..""..WHITE..")"
Inst7Quest4_HORDE_Note = "You get this Quest from Thaelrid at "..YELLOW.."[4]"..WHITE..". Kelris is at "..YELLOW.."[8]"..WHITE..". ATTENTION! If you turn on the flames beside Lord Kelris Ennemys appear and attack you. You find Bashana Runetotem in Thunderbluff (70, 33)."
Inst7Quest4_HORDE_Prequest = "No"
Inst7Quest4_HORDE_Folgequest = "No"
--
Inst7Quest4name1_HORDE = "Gravestone Scepter"
Inst7Quest4name2_HORDE = "Arctic Buckler"

--QUEST 5 Horde (Warlock)

Inst7Quest5_HORDE = "5. The Orb of Soran'ruk (Warlock)"
Inst7Quest5_HORDE_Attain = "20"
Inst7Quest5_HORDE_Level = "25"
Inst7Quest5_HORDE_Aim = "Find 3 Soran'ruk Fragments and 1 Large Soran'ruk Fragment and return them to Doan Karhan in the Barrens."
Inst7Quest5_HORDE_Location = "Doan Karhan (Barrens; "..YELLOW.."49,57"..WHITE..")"
Inst7Quest5_HORDE_Note = "Only Warlocks can get this Quest! You get the 3 Soran'ruk Fragmentes from Twilight-Akolyts in "..YELLOW.."[Blackfathomdeeps]"..WHITE..". You get the Large Soran'ruk Fragment in "..YELLOW.."[Shadowfang Keep]"..WHITE.." from Shadowfang Darksouls."
Inst7Quest5_HORDE_Prequest = "No"
Inst7Quest5_HORDE_Folgequest = "No"
--
Inst7Quest5name1_HORDE = "Orb of Soran'ruk"
Inst7Quest5name2_HORDE = "Staff of Soran'ruk"

--------------Inst25 ( 8 quests)------------
Inst25Story = "Il y a plus de mille ans, le puissant empire Gurubashi a \195\169t\195\169 ravag\195\169 par une guerre civile de grande ampleur. Un groupe de pr\195\170tres trolls influents, les Atal\'ai, ont tent\195\169 de ramener un ancien dieu du sang nomm\195\169 Hakkar l\'Ecorcheur d\'esprit. Bien que les pr\195\170tres aient \195\169t\195\169 vaincus et exil\195\169s, le grand empire troll s\'effondra malgr\195\169 tout. Les pr\195\170tres exil\195\169s s\'enfuirent vers le nord, dans le Marais des Chagrins. Ils y b\195\162tirent un grand temple d\195\169di\195\169 \195\160 Hakkar, d\'o\195\185 ils pr\195\169par\195\168rent son arriv\195\169e dans le monde physique. Le grand Aspect dragon, Ysera, d\195\169couvrit les plans des Atal\'ai et d\195\169truisit le temple. Aujourd\'hui encore, ses ruines englouties sont gard\195\169es par des dragons verts qui tentent d\'emp\195\170cher toute entr\195\169e ou sortie. On suppose que certains Atal\'ai auraient surv\195\169cu \195\160 la col\195\168re d\'Ysera, et se seraient consacr\195\169s \195\160 nouveau au noir service d\'Hakkar."
Inst25Caption = "Le Temple Englouti"
--classq
Inst25QAA = "8 Quests"
Inst25QAH = "8 Quests"

--QUEST 1 Allianz

Inst25Quest1 = "1. Into The Temple of Atal'Hakkar"
Inst25Quest1_Attain = "46"
Inst25Quest1_Level = "50"
Inst25Quest1_Aim = "Gather 10 Atal'ai Tablets for Brohann Caskbelly in Stormwind."
Inst25Quest1_Location = "Brohann Caskbelly (Stormwind; "..YELLOW.."64,20"..WHITE..")"
Inst25Quest1_Note = "You can find the Tables everywhere in the Temple."
Inst25Quest1_Prequest = "Yes, In Search of The Temple(same NPC) -> Rhapsody's Tale"
Inst25Quest1_Folgequest = "No"
Inst25Quest1PreQuest = "true"
--
Inst25Quest1name1 = "Guardian Talisman"

--QUEST 2 Allianz

Inst25Quest2 = "2. The Sunken Temple"
Inst25Quest2_Attain = "-"
Inst25Quest2_Level = "51"
Inst25Quest2_Aim = "Find Marvon Rivetseeker in Tanaris."
Inst25Quest2_Location = "Angelas Moonbreeze (Feralas; "..YELLOW.."31,45"..WHITE..")"
Inst25Quest2_Note = "You find Marvon Rivetseeker at 52,45"
Inst25Quest2_Prequest = "No"
Inst25Quest2_Folgequest = "Yes, The Stone Circle"

--QUEST 3 Allianz

Inst25Quest3 = "3. Into the Depths"
Inst25Quest3_Attain = "-"
Inst25Quest3_Level = "51"
Inst25Quest3_Aim = "Find the Altar of Hakkar in the Sunken Temple in Swamp of Sorrows."
Inst25Quest3_Location = "Marvon Rivetseeker (Tanaris; "..YELLOW.."52,45"..WHITE..")"
Inst25Quest3_Note = "The Altar is at "..YELLOW.."[1]"..WHITE.."."
Inst25Quest3_Prequest = "Yes, The Stone Circle"
Inst25Quest3_Folgequest = "Yes, Secret of the Circle"
Inst25Quest3FQuest = "true"


--QUEST 4 Alliance

Inst25Quest4 = "4. Secret of the Circle"
Inst25Quest4_Attain = "-"
Inst25Quest4_Level = "51"
Inst25Quest4_Aim = "Travel into the Sunken Temple and discover the secret hidden in the circle of statues."
Inst25Quest4_Location = "Marvon Rivetseeker (Tanaris; "..YELLOW.."52,45"..WHITE..")"
Inst25Quest4_Note = "You find the statues at "..YELLOW.."[1]"..WHITE.." open them in this order:1-6"
Inst25Quest4_Prequest = "Yes, Into the Deeps"
Inst25Quest4_Folgequest = "No"
Inst25Quest4FQuest = "true"
--
Inst25Quest4name1 = "Hakkari Urn"

--QUEST 5 Alliance

Inst25Quest5 = "5. Haze of Evil"
Inst25Quest5_Attain = "50"
Inst25Quest5_Level = "52"
Inst25Quest5_Aim = "Collect 5 samples of Atal'ai Haze, then return to Muigin in Un'Goro Crater."
Inst25Quest5_Location = "Gregan Brewspewer (Feralas; "..YELLOW.."45,25"..WHITE..")"
Inst25Quest5_Note = "The Prequest 'Muigin and Larion' starts at Muigin (Un'Goro Crater 42,9). You get the Haze from deep lurkers, murk worms, or oozes in the Temple."
Inst25Quest5_Prequest = "Yes, Muigin and Larion -> A Visit to Gregan "
Inst25Quest5_Folgequest = "No"
Inst25Quest5PreQuest = "true"



--QUEST 6 Alliance

Inst25Quest6 = "6. The God Hakkar (Questline)"
Inst25Quest6_Attain = "43"
Inst25Quest6_Level = "53"
Inst25Quest6_Aim = "Bring the Filled Egg of Hakkar to Yeh'kinya in Tanaris."
Inst25Quest6_Location = "Yeh'kinya (Tanaris; "..YELLOW.."66,22"..WHITE..")"
Inst25Quest6_Note = "The Questline starts with 'Screecher Spirits' at the same NPC(See "..YELLOW.."[Zul'Farrak]"..WHITE..").\nYou have to use the Egg at "..YELLOW.."[3]"..WHITE.." to start the Event. Once it start Enemys spawns and attack you. Some of them drop the blood of Hakkar. With this blood you can put out the torch around the circle. After this the Avatar of Hakkar spawn."
Inst25Quest6_Prequest = "Yes, Screecher Spirits -> The Ancient Egg"
Inst25Quest6_Folgequest = "No"
Inst25Quest6PreQuest = "true"
--
Inst25Quest6name1 = "Avenguard Helm"
Inst25Quest6name2 = "Lifeforce Dirk"
Inst25Quest6name3 = "Gemburst Circlet"

--QUEST 7 Alliance

Inst25Quest7 = "7. Jammal'an the Prophet"
Inst25Quest7_Attain = "43"
Inst25Quest7_Level = "53"
Inst25Quest7_Aim = "The Atal'ai Exile in The Hinterlands wants the Head of Jammal'an."
Inst25Quest7_Location = "The Atal'ai Exile (The Hinterlands; "..YELLOW.."33,75"..WHITE..")"
Inst25Quest7_Note = "You find Jammal'an at "..YELLOW.."[4]"..WHITE.."."
Inst25Quest7_Prequest = "No"
Inst25Quest7_Folgequest = "No"
--
Inst25Quest7name1 = "Rainstrider Leggings"
Inst25Quest7name2 = "Helm of Exile"

--QUEST 8 Alliance
Inst25Quest8 = "8. The Essence of Eranikus"
Inst25Quest8_Attain = "-"
Inst25Quest8_Level = "55"
Inst25Quest8_Aim = "Place the Essence of Eranikus in the Essence Font located in this lair in the Sunken Temple."
Inst25Quest8_Location = "The Essence of Eranikus (drop) (The Sunken Temple)"
Inst25Quest8_Note = "Eranikus drop his Essence. You find the Essence Font next to him at "..YELLOW.."[6]"..WHITE.."."
Inst25Quest8_Prequest = "No"
Inst25Quest8_Folgequest = "No"
--
Inst25Quest8name1 = "Chained Essence of Eranikus"


--QUEST 1 Horde

Inst25Quest1_HORDE = "1. The Temple of Atal'Hakkar"
Inst25Quest1_HORDE_Attain = "38"
Inst25Quest1_HORDE_Level = "50"
Inst25Quest1_HORDE_Aim = "Collect 20 Fetishes of Hakkar and bring them to Fel'Zerul in Stonard."
Inst25Quest1_HORDE_Location = "Fel'Zerul (Swamp of Sorrows - Stonard; "..YELLOW.."47,54"..WHITE..")"
Inst25Quest1_HORDE_Note = "All Enemys in the Temple drop Fetishes"
Inst25Quest1_HORDE_Prequest = "Yes, Pool of Tears(same NPC) -> Return to Fel'Zerul"
Inst25Quest1_HORDE_Folgequest = "No"
Inst25Quest1PreQuest_HORDE = "true"
--
Inst25Quest1name1_HORDE = "Guardian Talisman"

--QUEST 2 Horde

Inst25Quest2_HORDE = "2. The Sunken Temple"
Inst25Quest2_HORDE_Attain = ""
Inst25Quest2_HORDE_Level = "51"
Inst25Quest2_HORDE_Aim = "Find Marvon Rivetseeker in Tanaris."
Inst25Quest2_HORDE_Location = "Witch Doctor Uzer'i (Feralas; "..YELLOW.."74,43"..WHITE..")"
Inst25Quest2_HORDE_Note = "You find Marvon Rivetseeker at 52,45"
Inst25Quest2_HORDE_Prequest = "No"
Inst25Quest2_HORDE_Folgequest = "Yes, The Stone Circle"

--QUEST 3 Horde

Inst25Quest3_HORDE = "3. Into the Depths"
Inst25Quest3_HORDE_Attain = "-"
Inst25Quest3_HORDE_Level = "51"
Inst25Quest3_HORDE_Aim = "Find the Altar of Hakkar in the Sunken Temple in Swamp of Sorrows."
Inst25Quest3_HORDE_Location = "Marvon Rivetseeker (Tanaris; "..YELLOW.."52,45"..WHITE..")"
Inst25Quest3_HORDE_Note = "The Altar is at "..YELLOW.."[1]"..WHITE.."."
Inst25Quest3_HORDE_Prequest = "Yes, The Stone Circle"
Inst25Quest3_HORDE_Folgequest = "Yes, Secret of the Circle"
Inst25Quest3FQuest_HORDE = "true"

--QUEST 4 Horde

Inst25Quest4_HORDE = "4. Secret of the Circle"
Inst25Quest4_HORDE_Attain = "-"
Inst25Quest4_HORDE_Level = "51"
Inst25Quest4_HORDE_Aim = "Travel into the Sunken Temple and discover the secret hidden in the circle of statues."
Inst25Quest4_HORDE_Location = "Marvon Rivetseeker (Tanaris; "..YELLOW.."52,45"..WHITE..")"
Inst25Quest4_HORDE_Note = "You find the statues at "..YELLOW.."[1]"..WHITE.." open them in this order:1-6"
Inst25Quest4_HORDE_Prequest = "Yes, Into the Deeps"
Inst25Quest4_HORDE_Folgequest = "No"
Inst25Quest4FQuest_HORDE = "true"
--
Inst25Quest4name1_HORDE = "Hakkari Urn"

--QUEST 5 Horde

Inst25Quest5_HORDE = "5. Zapper Fuel"
Inst25Quest5_HORDE_Attain = "50"
Inst25Quest5_HORDE_Level = "52"
Inst25Quest5_HORDE_Aim = "Deliver the Unloaded Zapper and 5 samples of Atal'ai Haze to Larion in Marshal's Refuge."
Inst25Quest5_HORDE_Location = "Liv Rizzlefix (Barrens; "..YELLOW.."62,38"..WHITE..")"
Inst25Quest5_HORDE_Note = "The Prequest 'Larion and Muigin' starts at Larion (Un'Goro Crater 45,8). You get the Haze from deep lurkers, murk worms, or oozes in the Temple."
Inst25Quest5_HORDE_Prequest = "Yes, Larion and Muigin -> Marvon's Workshop"
Inst25Quest5_HORDE_Folgequest = "No"
Inst25Quest5PreQuest_HORDE = "true"

--QUEST 6 Horde

Inst25Quest6_HORDE = "6. The God Hakkar (Questline)"
Inst25Quest6_HORDE_Attain = "43"
Inst25Quest6_HORDE_Level = "53"
Inst25Quest6_HORDE_Aim = "Bring the Filled Egg of Hakkar to Yeh'kinya in Tanaris."
Inst25Quest6_HORDE_Location = "Yeh'kinya (Tanaris; "..YELLOW.."66,22"..WHITE..")"
Inst25Quest6_HORDE_Note = "The Questline starts with 'Screecher Spirits' at the same NPC(See "..YELLOW.."[Zul'Farrak]"..WHITE..").\nYou have to use the Egg at "..YELLOW.."[3]"..WHITE.." to start the Event. Once it start Enemys spawns and attack you. Some of them drop the blood of Hakkar. With this blood you can put out the torch around the circle. After this the Avatar of Hakkar spawn."
Inst25Quest6_HORDE_Prequest = "Yes, Screecher Spirits -> The Ancient Egg"
Inst25Quest6_HORDE_Folgequest = "No"
Inst25Quest6PreQuest_HORDE = "true"
--
Inst25Quest6name1_HORDE = "Avenguard Helm"
Inst25Quest6name2_HORDE = "Lifeforce Dirk"
Inst25Quest6name3_HORDE = "Gemburst Circlet"

--QUEST 7 Horde

Inst25Quest7_HORDE = "7. Jammal'an the Prophet"
Inst25Quest7_HORDE_Attain = "43"
Inst25Quest7_HORDE_Level = "53"
Inst25Quest7_HORDE_Aim = "The Atal'ai Exile in The Hinterlands wants the Head of Jammal'an."
Inst25Quest7_HORDE_Location = "The Atal'ai Exile (The Hinterlands; "..YELLOW.."33,75"..WHITE..")"
Inst25Quest7_HORDE_Note = "You find Jammal'an at "..YELLOW.."[4]"..WHITE.."."
Inst25Quest7_HORDE_Prequest = "No"
Inst25Quest7_HORDE_Folgequest = "No"
--
Inst25Quest7name1_HORDE = "Rainstrider Leggings"
Inst25Quest7name2_HORDE = "Helm of Exile"

--QUEST 8 Horde

Inst25Quest8_HORDE = "8. The Essence of Eranikus"
Inst25Quest8_HORDE_Attain = "-"
Inst25Quest8_HORDE_Level = "55"
Inst25Quest8_HORDE_Aim = "Place the Essence of Eranikus in the Essence Font located in this lair in the Sunken Temple."
Inst25Quest8_HORDE_Location = "The Essence of Eranikus (drop) (The Sunken Temple)"
Inst25Quest8_HORDE_Note = "Eranikus drop his Essence. You find the Essence Font next to him at "..YELLOW.."[6]"..WHITE.."."
Inst25Quest8_HORDE_Prequest = "No"
Inst25Quest8_HORDE_Folgequest = "No"
--
Inst25Quest8name1_HORDE = "Chained Essence of Eranikus"

--------------Burg Shadowfang/Inst21/BSF ------------
Inst21Story = "Au cours de la Troisi\195\168me Guerre, les mages du Kirin Tor combattirent les arm\195\169es mortes-vivantes du Fl\195\169au. Mais \195\160 chaque mage de Dalaran qui tombait au combat, se relevait peu apr\195\168s un mort-vivant ; et leur puissance s\'ajoutait \195\160 celle du Fl\195\169au. Frustr\195\169 par l\'absence de r\195\169sultats (et contre l\'avis de ses pairs), l\'archimage Arugal d\195\169cida d\'invoquer des entit\195\169s extradimensionnelles pour renforcer les rangs d\195\169clinants de Dalaran. L\'invocation d\'Arugal ouvrit les portes d\'Azeroth aux voraces worgens. Ces hommes-loups sauvages massacr\195\168rent les troupes du Fl\195\169au avant de se retourner contre les mages eux-m\195\170mes. Ensuite, ils assi\195\169g\195\168rent le ch\195\162teau du noble baron Silverlaine. Situ\195\169 au-dessus du hameau de Bois-du-B\195\187cher, le donjon ne tarda pas \195\160 se transformer en une sombre ruine. Rendu fou par la culpabilit\195\169, Arugal adopta les worgens comme ses enfants et se retira dans le tout fra\195\174chement rebaptis\195\169 « donjon d\'Ombrecroc ». On dit qu\'il y vit toujours, prot\195\169g\195\169 par son colossal familier Fenrus, et hant\195\169 par le fant\195\180me vengeur du baron Silverlaine."
Inst21Caption = "Donjon D'Ombrecroc"
Inst21QAA = "2 Quests"
Inst21QAH = "4 Quests"

--Quest 1 allianz

Inst21Quest1 = "1. The Test of Righteousness (Paladin)"
Inst21Quest1_Level = "22"
Inst21Quest1_Attain = "20"
Inst21Quest1_Aim = "Using Jordan's Weapon Notes, find some Whitestone Oak Lumber, Bailor's Refined Ore Shipment, Jordan's Smithing Hammer, and a Kor Gem, and return them to Jordan Stilwell in Ironforge."
Inst21Quest1_Location = "Jordan Stilwell (Dun Morogh - Ironforge Entrance "..YELLOW.."52,36 "..WHITE..")"
Inst21Quest1_Note = "To see the note pls klick on  "..YELLOW.."[The Test of Righteousness Information]"..WHITE.."."
Inst21Quest1_Prequest = "Yes, The Tome of Valor -> The Test of Righteousness"
Inst21Quest1_Folgequest = "Yes, The Test of Righteousness"
Inst21Quest1PreQuest = "true"
--
Inst21Quest1name1 = "Verigan's Fist"

--QUEST 1 Horde

Inst21Quest1_HORDE = "1. Deathstalkers in Shadowfang"
Inst21Quest1_HORDE_Attain = "-"
Inst21Quest1_HORDE_Level = "25"
Inst21Quest1_HORDE_Aim = "Find the Deathstalker Adamant and Deathstalker Vincent."
Inst21Quest1_HORDE_Location = "High Executor Hadrec (Silverpine Forest; "..YELLOW.."43,40"..WHITE..")"
Inst21Quest1_HORDE_Note = "You find Adamant at "..YELLOW.."[1]"..WHITE..". Vincet is on the right side when you go into the courtyard."
Inst21Quest1_HORDE_Prequest = "No"
Inst21Quest1_HORDE_Folgequest = "No"
--
Inst21Quest1name1_HORDE = "Ghostly Mantle"

--QUEST 2 Horde

Inst21Quest2_HORDE = "2. The Book of Ur"
Inst21Quest2_HORDE_Attain = "16"
Inst21Quest2_HORDE_Level = "26"
Inst21Quest2_HORDE_Aim = "Bring the Book of Ur to Keeper Bel'dugur at the Apothecarium in the Undercity."
Inst21Quest2_HORDE_Location = "Keeper Bel'dugur (Undercity; "..YELLOW.."53,54"..WHITE..")"
Inst21Quest2_HORDE_Note = "You find the book at "..YELLOW.."[6]"..WHITE.."(on the left side when you enter the room)."
Inst21Quest2_HORDE_Prequest = "No"
Inst21Quest2_HORDE_Folgequest = "No"
--
Inst21Quest2name1_HORDE = "Grizzled Boots"
Inst21Quest2name2_HORDE = "Steel-clasped Bracers"

--QUEST 3 Horde

Inst21Quest3_HORDE = "3. Arugal Must Die"
Inst21Quest3_HORDE_Attain = "?"
Inst21Quest3_HORDE_Level = "27"
Inst21Quest3_HORDE_Aim = "Kill Arugal and bring his head to Dalar Dawnweaver at the Sepulcher."
Inst21Quest3_HORDE_Location = "Dalar Dawnweaver (Silverpine Forest; "..YELLOW.."44,39"..WHITE..")"
Inst21Quest3_HORDE_Note = "You find Argual at "..YELLOW.."[8]"..WHITE.."."
Inst21Quest3_HORDE_Prequest = "No"
Inst21Quest3_HORDE_Folgequest = "No"
--
Inst21Quest3name1_HORDE = "Seal of Sylvanas"

--QUEST 4 Horde (hexenmeister)

Inst21Quest4_HORDE = "4. The Orb of Soran'ruk (Warlock)"
Inst21Quest4_HORDE_Attain = "21"
Inst21Quest4_HORDE_Level = "26"
Inst21Quest4_HORDE_Aim = "Find 3 Soran'ruk Fragments and 1 Large Soran'ruk Fragment and return them to Doan Karhan in the Barrens."
Inst21Quest4_HORDE_Location = "Doan Karhan (Barrens; "..YELLOW.."49,67"..WHITE..")"
Inst21Quest4_HORDE_Note = "Only Warlocks can get this Quest! You get the 3 Soran'ruk Fragmentes from Twilight-Akolyts in "..YELLOW.."[Blackfathomdeeps]"..WHITE..". You get the Large Soran'ruk Fragment in "..YELLOW.."[Shadowfang Keep]"..WHITE.." from Shadowfang Darksouls."
Inst21Quest4_HORDE_Prequest = "No"
Inst21Quest4_HORDE_Folgequest = "No"
--
Inst21Quest4name1_HORDE = "Orb of Soran'ruk"
Inst21Quest4name2_HORDE = "Staff of Soran'ruk"

--------------Inst5/Blackrocktiefen/BRD ------------
Inst5Story = "Ce labyrinthe volcanique \195\169tait autrefois la capitale des nains Sombrefer. C\'est aujourd\'hui le domaine de Ragnaros, le seigneur du feu. Ragnaros a d\195\169couvert le moyen de cr\195\169er la vie \195\160 partir de la pierre, et il compte b\195\162tir une arm\195\169e de golems pour l\'aider \195\160 conqu\195\169rir la totalit\195\169 du mont Blackrock. Obs\195\169d\195\169 par l\'id\195\169e de vaincre Nefarian et ses sbires draconiques, Ragnaros est pr\195\170t \195\160 n\'importe quelle extr\195\169mit\195\169 pour triompher."
Inst5Caption = "Profondeurs de Blackrock "
Inst5QAA = "14 Quests"
Inst5QAH = "14 Quests"

--QUEST1 Allianz

Inst5Quest1 = "1. Dark Iron Legacy"
Inst5Quest1_Attain = "48"
Inst5Quest1_Level = "52"
Inst5Quest1_Aim = "Slay Fineous Darkvire and recover the great hammer, Ironfel. Take Ironfel to the Shrine of Thaurissan and place it on the statue of Franclorn Forgewright."
Inst5Quest1_Location = "Franclorn Forgewright (Blackrock)"
Inst5Quest1_Note = "Franclorn is in the middle of the blackrock, above his grave. You have to be dead to see him! Talk 2 times with him to start the quest.\nFineous Darkvire is at "..YELLOW.."[9]"..WHITE..". You find the Shrine next to the arena "..YELLOW.."[7]"..WHITE.."."
Inst5Quest1_Prequest = "No"
Inst5Quest1_Folgequest = "No"
--
Inst5Quest1name1 = "Shadowforge Key"

--QUEST2 Allianz

Inst5Quest2 = "2. Ribbly Screwspigot"
Inst5Quest2_Attain = "50"
Inst5Quest2_Level = "53"
Inst5Quest2_Aim = "Bring Ribbly's Head to Yuka Screwspigot in the Burning Steppes."
Inst5Quest2_Location = "Yuka Screwspigot (Burning Steppes "..YELLOW.."65,22"..WHITE..")"
Inst5Quest2_Note = "You get the prequest from Yorba Screwspigot (Tanaris; 67,23).\nRibbly is at "..YELLOW.."[15]"..WHITE.."."
Inst5Quest2_Prequest = "Yes, Yuka Screwspigot"
Inst5Quest2_Folgequest = "No"
Inst5Quest2PreQuest = "true"
--
Inst5Quest2name1 = "Rancor Boots"
Inst5Quest2name2 = "Penance Spaulders"
Inst5Quest2name3 = "Splintsteel Armor"

--QUEST3 Allianz

Inst5Quest3 = "3. The Love Potion"
Inst5Quest3_Attain = "50"
Inst5Quest3_Level = "54"
Inst5Quest3_Aim = "Bring 4 Gromsblood, 10 Giant Silver Veins and Nagmara's Filled Vial to Mistress Nagmara in Blackrock Depths."
Inst5Quest3_Location = "Nagmara (Blackrock Depths, Tavern)"
Inst5Quest3_Note = "You get the Giant Silver Veins from Giants in Azshara, Gromsblood can find a Player with  	Herbalism and you can fill the Vial at the Go-Lakka crater (Un'Goro Crater; 31,50) füllen.\nAfter compliting the quest you can use the backdoor instaed of killing Phalanx."
Inst5Quest3_Prequest = "No"
Inst5Quest3_Folgequest = "No"
--
Inst5Quest3name1 = "Manacle Cuffs"
Inst5Quest3name2 = "Nagmara's Whipping Belt"

--QUEST4 Allianz

Inst5Quest4 = "4. Hurley Blackbreath"
Inst5Quest4_Attain = "?"
Inst5Quest4_Level = "55"
Inst5Quest4_Aim = "Bring the Lost Thunderbrew Recipe to Ragnar Thunderbrew in Kharanos."
Inst5Quest4_Location = "Ragnar Thunderbrew  (Dun Morogh "..YELLOW.."46,52"..WHITE..")"
Inst5Quest4_Note = "You get the prequest from Enohar Thunderbrew (Blasted lands; 61,18).\nYou get the recipe from one of the guards who appear if you destroy the ale "..YELLOW.."[15]"..WHITE.."."
Inst5Quest4_Prequest = "Yes, Ragnar Thunderbrew"
Inst5Quest4_Folgequest = "No"
Inst5Quest4PreQuest = "true"
--
Inst5Quest4name1 = "Dark Dwarven Lager"
Inst5Quest4name2 = "Swiftstrike Cudgel"
Inst5Quest4name3 = "Limb Cleaver"


--QUEST5 Allianz

Inst5Quest5 = "5. Incendius!"
Inst5Quest5_Attain = "?"
Inst5Quest5_Level = "56"
Inst5Quest5_Aim = "Find Lord Incendius in Blackrock Depths and destroy him!"
Inst5Quest5_Location = "Jalinda Sprig (Burning Steppes "..YELLOW.."85,69"..WHITE..")"
Inst5Quest5_Note = "You get the prequest from Jalinda Sprig, too. Pyron is just before the instance portal.\nYou find Lord Incendius at "..YELLOW.."[10]"..WHITE.."."
Inst5Quest5_Prequest = "Yes, Overmaster Pyron"
Inst5Quest5_Folgequest = "No"
Inst5Quest5PreQuest = "true"
--
Inst5Quest5name1 = "Sunborne Cape"
Inst5Quest5name2 = "Nightfall Gloves"
Inst5Quest5name3 = "Crypt Demon Bracers"
Inst5Quest5name4 = "Stalwart Clutch"

--QUEST6 Horde

Inst5Quest6 = "6. The Heart of the Mountain"
Inst5Quest6_Attain = "50"
Inst5Quest6_Level = "55"
Inst5Quest6_Aim = "Bring the Heart of the Mountain to Maxwort Uberglint in the Burning Steppes."
Inst5Quest6_Location = "Maxwort Uberglint (Burning Steppes "..YELLOW.."65,23"..WHITE..")"
Inst5Quest6_Note = "You find the Heart at "..YELLOW.."[10]"..WHITE.." in a safe."
Inst5Quest6_Prequest = "No"
Inst5Quest6_Folgequest = "No"

--QUEST6 Allianz

Inst5Quest7 = "7. The Good Stuff"
Inst5Quest7_Attain = "?"
Inst5Quest7_Level = "56"
Inst5Quest7_Aim = "Travel to Blackrock Depths and recover 20 Dark Iron Fanny Packs. Return to Oralius when you have completed this task. You assume that the Dark Iron dwarves inside Blackrock Depths carry these 'fanny pack' contraptions."
Inst5Quest7_Location = "Oralius (Burning Steppes "..YELLOW.."84,68"..WHITE..")"
Inst5Quest7_Note = "All dwarves can drop the packs."
Inst5Quest7_Prequest = "No"
Inst5Quest7_Folgequest = "No"
--
Inst5Quest7name1 = "A Dingy Fanny Pack"

--QUEST7 Allianz

Inst5Quest8 = "8. Marshal Windsor (Onyxia-Questline)"
Inst5Quest8_Attain = "48"
Inst5Quest8_Level = "54"
Inst5Quest8_Aim = "Travel to Blackrock Mountain in the northwest and enter Blackrock Depths. Find out what became of Marshal Windsor.\nYou recall Ragged John talking about Windsor being dragged off to a prison."
Inst5Quest8_Location = "Marshal Maxwell (Burning Steppes "..YELLOW.."84,68"..WHITE..")"
Inst5Quest8_Note = "The questline starts at Helendis Riverhorn (Burning Steppes "..YELLOW.."85,68"..WHITE..").\nMarshal Windsor is at "..YELLOW.."[4]"..WHITE..". You have to come back to Maxwell after completing this quest."
Inst5Quest8_Prequest = "Yes, Dragonkin Menace -> The True Masters"
Inst5Quest8_Folgequest = "Yes, Abandoned Hope -> A Crumpled Up Note"
Inst5Quest8PreQuest = "true"
--
Inst5Quest8name1 = "Conservator Helm"
Inst5Quest8name2 = "Shieldplate Sabatons"
Inst5Quest8name3 = "Windshear Leggings"

--QUEST8 Allianz

Inst5Quest9 = "9. A Crumpled Up Note (Onyxia-Questline)"
Inst5Quest9_Attain = "51"
Inst5Quest9_Level = "54"
Inst5Quest9_Aim = "You may have just stumbled on to something that Marshal Windsor would be interested in seeing. There may be hope, after all."
Inst5Quest9_Location = "A Crumpled Up Note(drop) (Blackrock Depths)"
Inst5Quest9_Note = "Marshal Windsor is at "..YELLOW.."[4]"..WHITE.."."
Inst5Quest9_Prequest = "Yes, Marshal Windsor"
Inst5Quest9_Folgequest = "Yes, A Shred of Hope"
Inst5Quest9FQuest = "true"

--QUEST9 Allianz

Inst5Quest10 = "10. A Shred of Hope (Onyxia-Questline)"
Inst5Quest10_Attain = "51"
Inst5Quest10_Level = "58"
Inst5Quest10_Aim = "Return Marshal Windsor's Lost Information.\nMarshal Windsor believes that the information is being held by Golem Lord Argelmach and General Angerforge."
Inst5Quest10_Location = "Marshal Windsors (Blackrock Depths "..YELLOW..""..YELLOW.."[4]"..WHITE..""..WHITE..")"
Inst5Quest10_Note = "Marshal Windsor is at "..YELLOW.."[4]"..WHITE..".\nYou find Golem Lord Argelmach at "..YELLOW.."[14]"..WHITE..", General Angerforge at "..YELLOW.."[13]"..WHITE.."."
Inst5Quest10_Prequest = "Yes, A Crumpled Up Note"
Inst5Quest10_Folgequest = "Yes, Jail Break!"
Inst5Quest10FQuest = "true"

--QUEST10 Allianz

Inst5Quest11 = "11. Jail Break! (Onyxia-Questline)"
Inst5Quest11_Attain = "54"
Inst5Quest11_Level = "58"
Inst5Quest11_Aim = "Help Marshal Windsor get his gear back and free his friends. Return to Marshal Maxwell if you succeed."
Inst5Quest11_Location = "Marshal Windsors (Blackrock Depths "..YELLOW..""..YELLOW.."[4]"..WHITE..""..WHITE..")"
Inst5Quest11_Note = "Marshal Windsor is at "..YELLOW.."[4]"..WHITE..".\nThe quest is easier if you clean the ring of law and the path to the entrance before you start the event. You find Marshal Maxwell at Burning Steppes ("..YELLOW.."84,68"..WHITE..")"
Inst5Quest11_Prequest = "Yes, A Shred of Hope"
Inst5Quest11_Folgequest = "Yes, Stormwind Rendezvous"
Inst5Quest11FQuest = "true"
--
Inst5Quest11name1 = "Ward of the Elements"
Inst5Quest11name2 = "Blade of Reckoning"
Inst5Quest11name3 = "Skilled Fighting Blade"

--QUEST12 Allianz

Inst5Quest12 = "12. A Taste of Flame (Questline)"
Inst5Quest12_Attain = "52"
Inst5Quest12_Level = "58"
Inst5Quest12_Aim = "Travel to Blackrock Depths and slay Bael'Gar. "..YELLOW.."[...]"..WHITE.." Return the Encased Fiery Essence to Cyrus Therepentous."
Inst5Quest12_Location = "Cyrus Therepentous (Burning Steppes "..YELLOW.."94,31"..WHITE..")"
Inst5Quest12_Note = "The questline starts at Kalaran Windblade (Sengende Schlucht; 39,38).\nBael'Gar is at "..YELLOW.."[11]"..WHITE.."."
Inst5Quest12_Prequest = "Yes, The Flawless Flame -> A Taste of Flame"
Inst5Quest12_Folgequest = "No"
Inst5Quest12PreQuest = "true"
--
Inst5Quest12name1 = "Shaleskin Cape"
Inst5Quest12name2 = "Wyrmhide Spaulders"
Inst5Quest12name3 = "Valconian Sash"

--QUEST13 Allianz

Inst5Quest13 = "13. Kharan Mighthammer"
Inst5Quest13_Attain = "?"
Inst5Quest13_Level = "59"
Inst5Quest13_Aim = " Travel to Blackrock Depths and find Kharan Mighthammer.\nThe King mentioned that Kharan was being held prisoner there - perhaps you should try looking for a prison."
Inst5Quest13_Location = "King Magni Bronzebeard (Ironforge "..YELLOW.."39,55"..WHITE..")"
Inst5Quest13_Note = "The prequest starts at Royal Historian Archesonus (Ironforge; 38,55).Kharan Mighthammer is at "..YELLOW.."[2]"..WHITE.."."
Inst5Quest13_Prequest = "Yes, The Smoldering Ruins of Thaurissan"
Inst5Quest13_Folgequest = "Yes, The Bearer of Bad News"
Inst5Quest13PreQuest = "true"

--QUEST14 Allianz

Inst5Quest14 = "14. The Fate of the Kingdom"
Inst5Quest14_Attain = "?"
Inst5Quest14_Level = "59"
Inst5Quest14_Aim = "Return to Blackrock Depths and rescue Princess Moira Bronzebeard from the evil clutches of Emperor Dagran Thaurissan."
Inst5Quest14_Location = "King Magni Bronzebeard (Ironforge "..YELLOW.."39,55"..WHITE..")"
Inst5Quest14_Note = "Princess Moira Bronzebeard is at "..YELLOW.."[21]"..WHITE..". During the fight she might heal Dagran. Try to interruppt her as often as possible. But be hurry she mustn't die or you can't complete the quest! After talking to her you have to come back to Magni Bronzebeard."
Inst5Quest14_Prequest = "Yes, The Bearer of Bad News"
Inst5Quest14_Folgequest = "Yes, The Princess's Surprise"
Inst5Quest14FQuest = "true"
--
Inst5Quest14name1 = "Magni's Will"
Inst5Quest14name2 = "Songstone of Ironforge"

--QUEST1 Horde

Inst5Quest1_HORDE = "1. Dark Iron Legacy"
Inst5Quest1_HORDE_Attain = "48"
Inst5Quest1_HORDE_Level = "52"
Inst5Quest1_HORDE_Aim = "Slay Fineous Darkvire and recover the great hammer, Ironfel. Take Ironfel to the Shrine of Thaurissan and place it on the statue of Franclorn Forgewright."
Inst5Quest1_HORDE_Location = "Franclorn Forgewright (Blackrock)"
Inst5Quest1_HORDE_Note = "Franclorn is in the middle of the blackrock, above his grave. You have to be dead to see him! Talk 2 times with him to start the quest.\nFineous Darkvire is at "..YELLOW.."[9]"..WHITE..". You find the Shrine next to the arena "..YELLOW.."[7]"..WHITE.."."
Inst5Quest1_HORDE_Prequest = "No"
Inst5Quest1_HORDE_Folgequest = "No"
--
Inst5Quest1name1_HORDE = "Shadowforge Key"

--QUEST2 Horde

Inst5Quest2_HORDE = "2. Ribbly Screwspigot"
Inst5Quest2_HORDE_Attain = "50"
Inst5Quest2_HORDE_Level = "53"
Inst5Quest2_HORDE_Aim = "Bring Ribbly's Head to Yuka Screwspigot in the Burning Steppes."
Inst5Quest2_HORDE_Location = "Yuka Screwspigot (Burning Steppes "..YELLOW.."65,22"..WHITE..")"
Inst5Quest2_HORDE_Note = "You get the prequest from Yorba Screwspigot (Tanaris; 67,23).\nRibbly is at "..YELLOW.."[15]"..WHITE.."."
Inst5Quest2_HORDE_Prequest = "Yes, Yuka Screwspigot"
Inst5Quest2_HORDE_Folgequest = "No"
Inst5Quest2PreQuest_HORDE = "true"
--
Inst5Quest11name1_HORDE = "Rancor Boots"
Inst5Quest11name2_HORDE = "Penance Spaulders"
Inst5Quest11name3_HORDE = "Splintsteel Armor"

--QUEST3 Horde

Inst5Quest3_HORDE = "3. The Love Potion"
Inst5Quest3_HORDE_Attain = "50"
Inst5Quest3_HORDE_Level = "54"
Inst5Quest3_HORDE_Aim = "Bring 4 Gromsblood, 10 Giant Silver Veins and Nagmara's Filled Vial to Mistress Nagmara in Blackrock Depths."
Inst5Quest3_HORDE_Location = "Nagmara (Blackrock Depths, Tavern)"
Inst5Quest3_HORDE_Note = "You get the Giant Silver Veins from Giants in Azshara, Gromsblood can find a Player with  	Herbalism and you can fill the Vial at the Go-Lakka crater (Un'Goro Crater; 31,50) füllen.\nAfter compliting the quest you can use the backdoor instaed of killing Phalanx."
Inst5Quest3_HORDE_Prequest = "No"
Inst5Quest3_HORDE_Folgequest = "No"
--
Inst5Quest3name1_HORDE = "Manacle Cuffs"
Inst5Quest3name2_HORDE = "Nagmara's Whipping Belt"

--QUEST 4 Horde

Inst5Quest4_HORDE = "4. Lost Thunderbrew Recipe "
Inst5Quest4_HORDE_Attain = "50"
Inst5Quest4_HORDE_Level = "55"
Inst5Quest4_HORDE_Aim = "Bring the Lost Thunderbrew Recipe to Vivian Lagrave in Kargath."
Inst5Quest4_HORDE_Location = "Shadowmage Vivian Lagrave (Badlands - Kargath; "..YELLOW.."2,47"..WHITE..")"
Inst5Quest4_HORDE_Note = "You get the prequest from apothecary Zinge in Undercity(50,68).\nYou get the recipe from one of the guards who appear if you destroy the ale "..YELLOW.."[15]"..WHITE.."."
Inst5Quest4_HORDE_Prequest = "Yes, Vivian Lagrave"
Inst5Quest4_HORDE_Folgequest = "No"
Inst5Quest4PreQuest_HORDE = "true"
--
Inst5Quest4name1_HORDE = "Superior Healing Potion"
Inst5Quest4name2_HORDE = "Greater Mana Potion"
Inst5Quest4name3_HORDE = "Swiftstrike Cudgel"
Inst5Quest4name4_HORDE = "Limb Cleaver"

--QUEST5 Horde

Inst5Quest5_HORDE = "5. The Heart of the Mountain"
Inst5Quest5_HORDE_Attain = "50"
Inst5Quest5_HORDE_Level = "55"
Inst5Quest5_HORDE_Aim = "Bring the Heart of the Mountain to Maxwort Uberglint in the Burning Steppes."
Inst5Quest5_HORDE_Location = "Maxwort Uberglint (Burning Steppes "..YELLOW.."65,23"..WHITE..")"
Inst5Quest5_HORDE_Note = "You find the Heart at "..YELLOW.."[10]"..WHITE.." in a safe."
Inst5Quest5_HORDE_Prequest = "No"
Inst5Quest5_HORDE_Folgequest = "No"

--QUEST 6 Horde

Inst5Quest6_HORDE = "6. KILL ON SIGHT: Dark Iron Dwarves"
Inst5Quest6_HORDE_Attain = "48"
Inst5Quest6_HORDE_Level = "52"
Inst5Quest6_HORDE_Aim = "Venture to Blackrock Depths and destroy the vile aggressors! Warlord Goretooth wants you to kill 15 Anvilrage Guardsmen, 10 Anvilrage Wardens and 5 Anvilrage Footmen. Return to him once your task is complete."
Inst5Quest6_HORDE_Location = "Sign post (Badlands - Kargath; "..YELLOW.."3,47"..WHITE..")"
Inst5Quest6_HORDE_Note = "You find the dwarves in the first part of Blackrock Depths.\nYou find Warlord Goretooth in Kargath at the top of the tower(Badlands, 5,47)."
Inst5Quest6_HORDE_Prequest = "No"
Inst5Quest6_HORDE_Folgequest = "Yes, KILL ON SIGHT: High Ranking Dark Iron Officials"

--QUEST 7 Horde

Inst5Quest7_HORDE = "7. KILL ON SIGHT: High Ranking Dark Iron Officials"
Inst5Quest7_HORDE_Attain = "50"
Inst5Quest7_HORDE_Level = "54"
Inst5Quest7_HORDE_Aim = "Venture to Blackrock Depths and destroy the vile aggressors! Warlord Goretooth wants you to kill 10 Anvilrage Medics, 10 Anvilrage Soldiers and 10 Anvilrage Officers. Return to him once your task is complete."
Inst5Quest7_HORDE_Location = "Sign post (Badlands - Kargath; "..YELLOW.."3,47"..WHITE..")"
Inst5Quest7_HORDE_Note = "You find the dwarves near Bael´Gar "..YELLOW.."[11]"..WHITE..". You find Warlord Goretooth in Kargath at the top of the tower(Badlands, 5,47).\n The attain quest starts at Lexlort(Kargath; 5,47). You find Gark Lorkrub in the Burning Stepps(38,35). You have the reduce his live below 50% to bind him and start a Escortquest(Elite!)."
Inst5Quest7_HORDE_Prequest = "Yes, KILL ON SIGHT: Dark Iron Dwarves"
Inst5Quest7_HORDE_Folgequest = "Yes, Grark Lorkrub -> Precarious Predicament(Escortquest)"
Inst5Quest7FQuest_HORDE = "true"

--QUEST 8 Horde

Inst5Quest8_HORDE = "8. Operation: Death to Angerforge"
Inst5Quest8_HORDE_Attain = "55"
Inst5Quest8_HORDE_Level = "58"
Inst5Quest8_HORDE_Aim = "Travel to Blackrock Depths and slay General Angerforge! Return to Warlord Goretooth when the task is complete."
Inst5Quest8_HORDE_Location = "Warlord Goretooth (Badlands - Kargath; "..YELLOW.."5,47"..WHITE..")"
Inst5Quest8_HORDE_Note = "You find General Angerforge at "..YELLOW.."[13]"..WHITE..". He calls help below 30%!"
Inst5Quest8_HORDE_Prequest = "Yes, Precarious Predicament"
Inst5Quest8_HORDE_Folgequest = "No"
Inst5Quest8FQuest_HORDE = "true"
--
Inst5Quest8name1_HORDE = "Conqueror's Medallion"

--QUEST 5 Horde

Inst5Quest9_HORDE = "9. The Rise of the Machines"
Inst5Quest9_HORDE_Attain = "?"
Inst5Quest9_HORDE_Level = "58"
Inst5Quest9_HORDE_Aim = "Find and slay Golem Lord Argelmach. Return his head to Lotwil. You will also need to collect 10 Intact Elemental Cores from the Ragereaver Golems and Warbringer Constructs protecting Argelmach. You know this because you are psychic."
Inst5Quest9_HORDE_Location = "Lotwil Veriatus (Badlands; "..YELLOW.."25,44"..WHITE..")"
Inst5Quest9_HORDE_Note = "You get the prequest from Hierophant Theodora Mulvadania(Kargath - Badlands; 3,47).\nYou find Argelmach at "..YELLOW.."[14]"..WHITE.."."
Inst5Quest9_HORDE_Prequest = "Yes, The Rise of the Machines"
Inst5Quest9_HORDE_Folgequest = "No"
Inst5Quest9PreQuest_HORDE = "true"
--
Inst5Quest9name1_HORDE = "Azure Moon Amice"
Inst5Quest9name2_HORDE = "Raincaster Drape"
Inst5Quest9name3_HORDE = "Basaltscale Armor"
Inst5Quest9name4_HORDE = "Lavaplate Gauntlets"


--QUEST13 Horde

Inst5Quest10_HORDE = "10. A Taste of Flame (Questline)"
Inst5Quest10_HORDE_Attain = "52"
Inst5Quest10_HORDE_Level = "58"
Inst5Quest10_HORDE_Aim = "Travel to Blackrock Depths and slay Bael'Gar. "..YELLOW.."[...]"..WHITE.." Return the Encased Fiery Essence to Cyrus Therepentous."
Inst5Quest10_HORDE_Location = "Cyrus Therepentous (Burning Steppes "..YELLOW.."94,31"..WHITE..")"
Inst5Quest10_HORDE_Note = "The questline starts at Kalaran Windblade (Sengende Schlucht; 39,38).\nBael'Gar is at "..YELLOW.."[11]"..WHITE.."."
Inst5Quest10_HORDE_Prequest = "Yes, The Flawless Flame -> A Taste of Flame"
Inst5Quest10_HORDE_Folgequest = "No"
Inst5Quest10PreQuest_HORDE = "true"
--
Inst5Quest10name1_HORDE = "Shaleskin Cape"
Inst5Quest10name2_HORDE = "Wyrmhide Spaulders"
Inst5Quest10name3_HORDE = "Valconian Sash"

--QUEST 11 Horde

Inst5Quest11_HORDE = "11. Disharmony of Fire"
Inst5Quest11_HORDE_Attain = "?"
Inst5Quest11_HORDE_Level = "56"
Inst5Quest11_HORDE_Aim = "Enter Blackrock Depths and track down Lord Incendius. Slay him and return any source of information you may find to Thunderheart."
Inst5Quest11_HORDE_Location = "Thunderheart (Badlands - Kargath; "..YELLOW.."3,48"..WHITE..")"
Inst5Quest11_HORDE_Note = "You get the prequest from Thunderheart, too. Pyron is just before the instance portal.\nYou find Lord Incendius at "..YELLOW.."[10]"..WHITE.."."
Inst5Quest11_HORDE_Prequest = "Yes, Disharmony of Flame"
Inst5Quest11_HORDE_Folgequest = "No"
Inst5Quest11PreQuest_HORDE = "true"
--
Inst5Quest11name1_HORDE = "Sunborne Cape"
Inst5Quest11name2_HORDE = "Nightfall Gloves"
Inst5Quest11name3_HORDE = "Crypt Demon Bracers"
Inst5Quest11name4_HORDE = "Stalwart Clutch"

--QUEST 12 Horde

Inst5Quest12_HORDE = "12. The Last Element"
Inst5Quest12_HORDE_Attain = "?"
Inst5Quest12_HORDE_Level = "54"
Inst5Quest12_HORDE_Aim = "Travel to Blackrock Depths and recover 10 Essence of the Elements. Your first inclination is to search the golems and golem makers. You remember Vivian Lagrave also muttering something about elementals."
Inst5Quest12_HORDE_Location = "Shadowmage Vivian Lagrave (Badlands - Kargath; "..YELLOW.."2,47"..WHITE..")"
Inst5Quest12_HORDE_Note = "You get the prequest from Thunderheart (Badlands - Kargath; "..YELLOW.."3,48"..WHITE.."). Pyron is just before the instance portal.\n Every elemental drop the Essence"
Inst5Quest12_HORDE_Prequest = "Yes, Disharmony of Flame"
Inst5Quest12_HORDE_Folgequest = "No"
Inst5Quest12PreQuest_HORDE = "true"
--
Inst5Quest12name1_HORDE = "Lagrave's Seal"

--QUEST 8 Horde

Inst5Quest13_HORDE = "13. Commander Gor'shak"
Inst5Quest13_HORDE_Attain = "?"
Inst5Quest13_HORDE_Level = "52"
Inst5Quest13_HORDE_Aim = "Find Commander Gor'shak in Blackrock Depths.\nYou recall that the crudely drawn picture of the orc included bars drawn over the portrait. Perhaps you should search for a prison of some sort."
Inst5Quest13_HORDE_Location = "Galamav the Marksman (Badlands - Kargath; "..YELLOW.."5,47"..WHITE..")"
Inst5Quest13_HORDE_Note = "You get the prequest from Thunderheart (Badlands - Kargath; "..YELLOW.."3,48"..WHITE.."). Pyron is just before the instance portal.\nYou find Commander Gor'shak at "..YELLOW.."[3]"..WHITE..". The key to open the prison dropps Gerstahn"..YELLOW.."[5]"..WHITE..". If you talk to him and start the next Quest enemys appears."
Inst5Quest13_HORDE_Prequest = "Yes, Disharmony of Flame"
Inst5Quest13_HORDE_Folgequest = "Yes, What Is Going On?(Event)"
Inst5Quest13PreQuest_HORDE = "true"


--QUEST14 Horde

Inst5Quest14_HORDE = "14. The Royal Rescue"
Inst5Quest14_HORDE_Attain = "51"
Inst5Quest14_HORDE_Level = "59"
Inst5Quest14_HORDE_Aim = "Slay Emperor Dagran Thaurissan and free Princess Moira Bronzebeard from his evil spell."
Inst5Quest14_HORDE_Location = "Thrall (Orgrimmar; "..YELLOW.."31,37"..WHITE..")"
Inst5Quest14_HORDE_Note = "After talking a with Kharan Mighthammer and Thrall you get this quest.\nYou find Emperor Dagran Thaurissan at "..YELLOW.."[21]"..WHITE..". The princess heals Dagran but you musstn't kill her to complete the quest! Try to interrupt her healing spells. (Rewards are for The Princess Saved?)"
Inst5Quest14_HORDE_Prequest = "Yes, Commander Gor'shak"
Inst5Quest14_HORDE_Folgequest = "Yes, The Princess Saved?"
Inst5Quest14FQuest_HORDE = "true"
--
Inst5Quest14name1_HORDE = "Thrall's Resolve"
Inst5Quest14name2_HORDE = "Eye of Orgrimmar"



--------------Inst8 / lower blackrock spier ------------
Inst8Story = "La puissante forteresse taill\195\169e dans les entrailles enflamm\195\169es du mont Blackrock fut con\195\167ue par le ma\195\174tre-ma\195\167on nain Franclorn Forgewright. Elle devait \195\170tre le symbole de la puissance des Sombrefer, et ceux-ci la conserv\195\168rent pendant des si\195\168cles. Mais Nefarian, le rus\195\169 fils du dragon Aile de mort avait d\'autres plans pour cet immense donjon. Aid\195\169 par ses sbires draconiques, il prit le contr\195\180le du haut du pic et partit en guerre contre les domaines des nains, dans les profondeurs volcaniques de la montagne. R\195\169alisant que les nains \195\169taient dirig\195\169s par le grand \195\169l\195\169mentaire de feu, Ragnaros, Nefarian fit le voeu d\'\195\169craser ses adversaires et de s\'emparer de la totalit\195\169 de la montagne."
Inst8Caption = "Pic de Blackrock"

--------------Inst9 / lower blackrock spier ------------
Inst9Story = "La puissante forteresse taill\195\169e dans les entrailles enflamm\195\169es du mont Blackrock fut con\195\167ue par le ma\195\174tre-ma\195\167on nain Franclorn Forgewright. Elle devait \195\170tre le symbole de la puissance des Sombrefer, et ceux-ci la conserv\195\168rent pendant des si\195\168cles. Mais Nefarian, le rus\195\169 fils du dragon Aile de mort avait d\'autres plans pour cet immense donjon. Aid\195\169 par ses sbires draconiques, il prit le contr\195\180le du haut du pic et partit en guerre contre les domaines des nains, dans les profondeurs volcaniques de la montagne. R\195\169alisant que les nains \195\169taient dirig\195\169s par le grand \195\169l\195\169mentaire de feu, Ragnaros, Nefarian fit le voeu d\'\195\169craser ses adversaires et de s\'emparer de la totalit\195\169 de la montagne."
Inst9Caption = "Pic de Blackrock"

--------------Dire Maul East/ Inst10------------
Inst10Story = "B\195\162tie il y a douze mille ans par une secte secr\195\168te de sorciers elfes de la nuit, l\'antique cite d\'Eldre\'Thalas servait \195\160 prot\195\169ger les secrets magiques les plus pr\195\169cieux de la reine Azshara. Elle fut ravag\195\169e par la Grande Fracture du monde, mais une bonne partie de la ville se dresse encore, rebaptis\195\169e Hache-tripes. Les trois quartiers de la ville ont \195\169t\195\169 envahis de toutes sortes de cr\195\169atures, Bien-n\195\169s spectraux, vils satyres et ogres brutaux. Seuls les groupes d\'aventuriers les plus audacieux peuvent p\195\169n\195\169trer dans cette ville d\195\169truite et affronter les maux anciens qui y sont enferm\195\169s dans ses salles antiques."
Inst10Caption = "Hache-Tripes"

--------------Dire Maul North/ Inst11------------
Inst11Story = "B\195\162tie il y a douze mille ans par une secte secr\195\168te de sorciers elfes de la nuit, l\'antique cite d\'Eldre\'Thalas servait \195\160 prot\195\169ger les secrets magiques les plus pr\195\169cieux de la reine Azshara. Elle fut ravag\195\169e par la Grande Fracture du monde, mais une bonne partie de la ville se dresse encore, rebaptis\195\169e Hache-tripes. Les trois quartiers de la ville ont \195\169t\195\169 envahis de toutes sortes de cr\195\169atures, Bien-n\195\169s spectraux, vils satyres et ogres brutaux. Seuls les groupes d\'aventuriers les plus audacieux peuvent p\195\169n\195\169trer dans cette ville d\195\169truite et affronter les maux anciens qui y sont enferm\195\169s dans ses salles antiques."
Inst11Caption = "Hache-Tripes"

--------------Dire Maul West/ Inst12------------
Inst12Story = "B\195\162tie il y a douze mille ans par une secte secr\195\168te de sorciers elfes de la nuit, l\'antique cite d\'Eldre\'Thalas servait \195\160 prot\195\169ger les secrets magiques les plus pr\195\169cieux de la reine Azshara. Elle fut ravag\195\169e par la Grande Fracture du monde, mais une bonne partie de la ville se dresse encore, rebaptis\195\169e Hache-tripes. Les trois quartiers de la ville ont \195\169t\195\169 envahis de toutes sortes de cr\195\169atures, Bien-n\195\169s spectraux, vils satyres et ogres brutaux. Seuls les groupes d\'aventuriers les plus audacieux peuvent p\195\169n\195\169trer dans cette ville d\195\169truite et affronter les maux anciens qui y sont enferm\195\169s dans ses salles antiques."
Inst12Caption = "Hache-Tripes"

--------------Inst13/Maraudon------------
Inst13Story = "Prot\195\169g\195\169 par les terribles centaures Maraudine, Maraudon est l\'un des lieux les plus sacr\195\169s de D\195\169solace. Ce grand temple/caverne est la tombe de Zaetar, l\'un des deux fils immortels n\195\169s du demi-dieu C\195\169narius. A en croire la l\195\169gende, Zaetar et Theradras, la princesse des \195\169l\195\169mentaires de terre, engendr\195\168rent le peuple des centaures. On dit \195\169galement que peu apr\195\168s, les centaures barbares se retourn\195\168rent contre leur p\195\168re et le tu\195\168rent. Certains croient que Theradras, dans son chagrin, emprisonna l\'esprit de Zaetar dans la caverne sinueuse, et qu\'elle se servit de cette \195\169nergie dans des buts mal\195\169fiques. Les tunnels souterrains sont peupl\195\169s des esprits cruels des Khans centaures morts depuis longtemps, sans oublier les sbires \195\169l\195\169mentaires d\195\169cha\195\174n\195\169s de Theradras."
Inst13Caption = "Maraudon"
Inst13QAA = "8 Quests"
Inst13QAH = "8 Quests"

--Quest1 Allianz

Inst13Quest1 = "1. Shadowshard Fragments"
Inst13Quest1_Attain = "?"
Inst13Quest1_Level = "42"
Inst13Quest1_Aim = "Collect 10 Shadowshard Fragments from Maraudon and return them to Archmage Tervosh in Theramore on the coast of Dustwallow Marsh."
Inst13Quest1_Location = "Archmage Tervosh (Dustwallow Marsh; "..YELLOW.."66,49"..WHITE..")"
Inst13Quest1_Note = "You get the Shadowshard Fragments from 'Shadowshard Rumbler' or 'Shadowshard Smasher'."
Inst13Quest1_Prequest = "No"
Inst13Quest1_Folgequest = "No"
--
Inst13Quest1name1 = "Zealous Shadowshard Pendant"
Inst13Quest1name2 = "Prodigious Shadowshard Pendant"

--Quest2 Allianz

Inst13Quest2 = "2. Vyletongue Corruption"
Inst13Quest2_Attain = "41"
Inst13Quest2_Level = "47"
Inst13Quest2_Aim = "Fill the Coated Cerulean Vial at the orange crystal pool in Maraudon.\nUse the Filled Cerulean Vial on the Vylestem Vines to force the corrupted Noxxious Scion to emerge.\nHeal 8 plants by killing these Noxxious Scion, then return to Talendria in Nijel's Point."
Inst13Quest2_Location = "Talendria (Desolace - Nijel's Point; "..YELLOW.."68,8"..WHITE..")"
Inst13Quest2_Note = "You can fill the Vial at all pools in the orange area of Maraudon. The plants are in the orange and purple area."
Inst13Quest2_Prequest = "No"
Inst13Quest2_Folgequest = "No"
--
Inst13Quest2name1 = "Woodseed Hoop"
Inst13Quest2name2 = "Sagebrush Girdle"
Inst13Quest2name3 = "Branchclaw Gauntlets"

--Quest3 Allianz

Inst13Quest3 = "3. Twisted Evils"
Inst13Quest3_Attain = "41"
Inst13Quest3_Level = "47"
Inst13Quest3_Aim = "Collect 25 Theradric Crystal Carvings for Willow in Desolace."
Inst13Quest3_Location = "Willow (Desolace; "..YELLOW.."62,39"..WHITE..")"
Inst13Quest3_Note = "The most enemys in Maraudon drops the Carvings.(high droprate)"
Inst13Quest3_Prequest = "No"
Inst13Quest3_Folgequest = "No"
--
Inst13Quest3name1 = "Acumen Robes"
Inst13Quest3name2 = "Sprightring Helm"
Inst13Quest3name3 = "Relentless Chain"
Inst13Quest3name4 = "Hulkstone Pauldrons"

--Quest4 Horde

Inst13Quest4 = "4. The Pariah's Instructions"
Inst13Quest4_Attain = "?"
Inst13Quest4_Level = "48"
Inst13Quest4_Aim = "Read the Pariah's Instructions. Afterwards, obtain the Amulet of Union from Maraudon and return it to the Centaur Pariah in southern Desolace."
Inst13Quest4_Location = "Centaur Pariah (Desolace; "..YELLOW.."45,86"..WHITE..")"
Inst13Quest4_Note = "The 5 Kahns (Description for The Pariah's Instructions)"
Inst13Quest4_Prequest = "No"
Inst13Quest4_Folgequest = "No"
--
Inst13Quest4name1 = "Mark of the Chosen"


--Quest1 Horde

Inst13Quest1_HORDE = "1. Shadowshard Fragments"
Inst13Quest1_HORDE_Attain = "?"
Inst13Quest1_HORDE_Level = "42"
Inst13Quest1_HORDE_Aim = "Collect 10 Shadowshard Fragments from Maraudon and return them to Uthel'nay in Orgrimmar"
Inst13Quest1_HORDE_Location = "Uthel'nay (Orgrimmar; "..YELLOW.."38,68"..WHITE..")"
Inst13Quest1_HORDE_Note = "You get the Shadowshard Fragments from 'Shadowshard Rumbler' or 'Shadowshard Smasher'."
Inst13Quest1_HORDE_Prequest = "No"
Inst13Quest1_HORDE_Folgequest = "No"
--
Inst13Quest1name1_HORDE = "Zealous Shadowshard Pendant"
Inst13Quest1name2_HORDE = "Prodigious Shadowshard Pendant"

--Quest2 Horde

Inst13Quest2_HORDE = "2. Vyletongue Corruption"
Inst13Quest2_HORDE_Attain = "41"
Inst13Quest2_HORDE_Level = "47"
Inst13Quest2_HORDE_Aim = "Fill the Coated Cerulean Vial at the orange crystal pool in Maraudon.\nUse the Filled Cerulean Vial on the Vylestem Vines to force the corrupted Noxxious Scion to emerge.\nHeal 8 plants by killing these Noxxious Scion, then return to Vark Battlescar in Shadowprey Village."
Inst13Quest2_HORDE_Location = "Vark Battlescar (Desolace - Shadowprey; "..YELLOW.."23,70"..WHITE..")"
Inst13Quest2_HORDE_Note = "You can fill the Vial at all pools in the orange area of Maraudon. The plants are in the orange and purple area."
Inst13Quest2_HORDE_Prequest = "No"
Inst13Quest2_HORDE_Folgequest = "No"
--
Inst13Quest2name1_HORDE = "Woodseed Hoop"
Inst13Quest2name2_HORDE = "Sagebrush Girdle"
Inst13Quest2name3_HORDE = "Branchclaw Gauntlets"

--Quest3 Horde

Inst13Quest3_HORDE = "3. Twisted Evils"
Inst13Quest3_HORDE_Attain = "41"
Inst13Quest3_HORDE_Level = "47"
Inst13Quest3_HORDE_Aim = "Collect 25 Theradric Crystal Carvings for Willow in Desolace."
Inst13Quest3_HORDE_Location = "Willow (Desolace; "..YELLOW.."62,39"..WHITE..")"
Inst13Quest3_HORDE_Note = "The most enemys in Maraudon drops the Carvings.(high droprate)"
Inst13Quest3_HORDE_Prequest = "No"
Inst13Quest3_HORDE_Folgequest = "No"
--
Inst13Quest3name1_HORDE = "Acumen Robes"
Inst13Quest3name2_HORDE = "Sprightring Helm"
Inst13Quest3name3_HORDE = "Relentless Chain"
Inst13Quest3name4_HORDE = "Hulkstone Pauldrons"

--Quest4 Horde

Inst13Quest4_HORDE = "4. The Pariah's Instructions"
Inst13Quest4_HORDE_Attain = "?"
Inst13Quest4_HORDE_Level = "48"
Inst13Quest4_HORDE_Aim = "Read the Pariah's Instructions. Afterwards, obtain the Amulet of Union from Maraudon and return it to the Centaur Pariah in southern Desolace."
Inst13Quest4_HORDE_Location = "Centaur Pariah (Desolace; "..YELLOW.."45,86"..WHITE..")"
Inst13Quest4_HORDE_Note = "The 5 Kahns (Description for The Pariah's Instructions)"
Inst13Quest4_HORDE_Prequest = "No"
Inst13Quest4_HORDE_Folgequest = "No"
--
Inst13Quest4name1_HORDE = "Mark of the Chosen"


--------------Inst22/Stratholme------------
Inst22Story = "La ville de Stratholme \195\169tait le joyau de Lordaeron. C\'est l\195\160 que le prince Arthas se retourna contre son mentor, Uther Lightbringer, et qu\'il mit \195\160 mort des centaines de ses propres sujets, qu\'il croyait atteint par la terrible Peste de la non-vie. Peu apr\195\168s, Arthas bascula et se livra au Roi-liche. La cit\195\169 en ruine est \195\160 pr\195\169sent le domaine du Fl\195\169au mort-vivant, dirig\195\169 par la puissante liche Kel\'thuzad. Un contingent de Crois\195\169s \195\169carlates, dirig\195\169s par le Grand crois\195\169 Dathrohan tient \195\169galement une partie de la ville. Les deux camps ne cessent de se combattre. Les aventuriers assez braves (ou assez fous) pour p\195\169n\195\169trer dans Stratholme ne tarderont pas \195\160 se mettre les deux factions \195\160 dos. On dit que la ville est gard\195\169e par trois tours de garde g\195\169antes, sans oublier de puissants n\195\169cromanciens, des banshees et des abominations. Certains rapports mentionnent \195\169galement un Chevalier de la mort mont\195\169 sur un effrayant destrier. Sa col\195\168re s\'abattrait sur tous ceux qui osent p\195\169n\195\169trer dans le royaume du Fl\195\169au."
Inst22Caption = "Stratholme"

--------------Inst29/Gnomeregan------------
Inst29Story = "Capitale des gnomes depuis des g\195\169n\195\169rations, Gnomeregan \195\169tait la merveille technologique de Dun Morogh. Mais il y a peu, une race de troggs mutants hostiles a attaqu\195\169 plusieurs r\195\169gions de Dun Morogh, y compris la grand cit\195\169 gnome. Dans une tentative d\195\169sesp\195\169r\195\169e pour repousser les envahisseurs, le Grand Artisan Mekkatorque ordonna que les r\195\169servoirs de d\195\169chets radioactifs soient purg\195\169s. Les gnomes se pr\195\169cipit\195\168rent aux abris, attendant que les substances toxiques qui saturaient l\'air tuent les troggs ou les poussent \195\160 la fuite. Malheureusement, bien que les troggs aient \195\169t\195\169 irradi\195\169s, ils poursuivirent le si\195\168ge. Les gnomes qui ne furent pas tu\195\169s par les vapeurs durent fuir et se r\195\169fugier dans la cit\195\169 naine toute proche, Ironforge. Le Grand Artisan Mekkatorque cherche \195\160 y recruter des \195\162mes vaillantes pour aider son peuple \195\160 reprendre sa ville bien-aim\195\169e. On murmure que l\'ancien conseiller de Mekkatorque, le Mekgineer Thermaplug a trahi son peuple en permettant \195\160 l\'invasion de se produire. Devenu fou, Thermaplug est toujours \195\160 Gnomeregan, ourdissant de sinistres complots et servant de nouveau technoma\195\174tre \195\160 la ville."
Inst29Caption = "Gnomeregan"
Inst29QAA = "8 Quests"
Inst29QAH = "3 Quests"

--QUEST1 Allianz

Inst29Quest1 = "1. Save Techbot's Brain!"
Inst29Quest1_Attain = "?"
Inst29Quest1_Level = "26"
Inst29Quest1_Aim = "Bring Techbot's Memory Core to Tinkmaster Overspark in Ironforge."
Inst29Quest1_Location = "Tinkmaster Overspark (Ironforge; "..YELLOW.."69,50 "..WHITE..")"
Inst29Quest1_Note = "You get the prequest from Brother Sarno "..YELLOW.."(Stormwind; 40,30)"..WHITE..".\nYou find Techbot before you enter the instance near the backdoor."
Inst29Quest1_Prequest = "Yes, Tinkmaster Overspark"
Inst29Quest1_Folgequest = "No"
Inst29Quest1PreQuest = "true"

--Quest2 Allianz

Inst29Quest2 = "2. Gnogaine"
Inst29Quest2_Attain = "?"
Inst29Quest2_Level = "27"
Inst29Quest2_Aim = "Use the Empty Leaden Collection Phial on Irradiated Invaders or Irradiated Pillagers to collect radioactive fallout. Once it is full, take it back to Ozzie Togglevolt in Kharanos."
Inst29Quest2_Location = "Ozzie Togglevolt (Dun Morogh; "..YELLOW.."45,49 "..WHITE..")"
Inst29Quest2_Note = "You get the prequest from Gnoarn "..YELLOW.."(Ironforge; 69,50)"..WHITE..".\nTo get fallout you musst use the Phial on "..RED.."alive"..WHITE.." Irradiated Invaders or Irradiated Pillagers."
Inst29Quest2_Prequest = "Yes, The Day After"
Inst29Quest2_Folgequest = "Yes, The Only Cure is More Green Glow"
Inst29Quest2PreQuest = "true"

--Quest3 Allianz

Inst29Quest3 = "3. The Only Cure is More Green Glow"
Inst29Quest3_Attain = "27"
Inst29Quest3_Level = "30"
Inst29Quest3_Aim = "Travel to Gnomeregan and bring back High Potency Radioactive Fallout. Be warned, the fallout is unstable and will collapse rather quickly.\nOzzie will also require your Heavy Leaden Collection Phial when the task is complete."
Inst29Quest3_Location = "Ozzie Togglevolt (Dun Morogh; "..YELLOW.."45,49 "..WHITE..")"
Inst29Quest3_Note = "To get fallout you musst use the Phial on "..RED.."alive"..WHITE.." irradiated slimes, lurkers and horrors."
Inst29Quest3_Prequest = "Yes, Gnogaine"
Inst29Quest3_Folgequest = "No"
Inst29Quest3FQuest = "true"

--Quest4 Allianz

Inst29Quest4 = "4. Gyrodrillmatic Excavationators"
Inst29Quest4_Attain = "?"
Inst29Quest4_Level = "30"
Inst29Quest4_Aim = "Bring twenty-four Robo-mechanical Guts to Shoni in Stormwind."
Inst29Quest4_Location = "Shoni the Shilent (Stormwind; "..YELLOW.."55,12 "..WHITE..")"
Inst29Quest4_Note = "Every Robots drop the Guts."
Inst29Quest4_Prequest = "No"
Inst29Quest4_Folgequest = "No"
--
Inst29Quest4name1 = "Shoni's Disarming Tool"
Inst29Quest4name2 = "Shilly Mitts"

--Quest5 Allianz

Inst29Quest5 = "5. Essential Artificials"
Inst29Quest5_Attain = "?"
Inst29Quest5_Level = "30"
Inst29Quest5_Aim = "Bring 12 Essential Artificials to Klockmort Spannerspan in Ironforge."
Inst29Quest5_Location = "Klockmort Spannerspan (Ironforge; "..YELLOW.."68,46 "..WHITE..")"
Inst29Quest5_Note = "You get the prequest from Mathiel "..YELLOW.."(Darnassus; 59,45)"..WHITE..".\nEvery Enemy in Gnomeregan drops the Artificials."
Inst29Quest5_Prequest = "Yes, Klockmort's Essentials"
Inst29Quest5_Folgequest = "No"
Inst29Quest5PreQuest = "true"

--Quest6 Allianz

Inst29Quest6 = "6. Data Rescue"
Inst29Quest6_Attain = "25"
Inst29Quest6_Level = "30"
Inst29Quest6_Aim = "Bring a Prismatic Punch Card to Master Mechanic Castpipe in Ironforge."
Inst29Quest6_Location = "Master Mechanic Castpipe (Ironforge; "..YELLOW.."69,48 "..WHITE..")"
Inst29Quest6_Note = "You get the prequest from Gaxim Rustfizzle "..YELLOW.."(Stonetalon Mountains; 59,67)"..WHITE..".\nThe white card is a random drop. You find the first terminal next to the back entrance before you enter the instance. The 2. is at "..YELLOW.."[3]"..WHITE..", the 3. at "..YELLOW.."[5]"..WHITE.." and the 4. is at "..YELLOW.."[8]"..WHITE.."."
Inst29Quest6_Prequest = "Yes, Castpipe's Task"
Inst29Quest6_Folgequest = "No"
--
Inst29Quest6name1 = "Repairman's Cape"
Inst29Quest6name2 = "Mechanic's Pipehammer"
Inst29Quest6PreQuest = "true"

--Quest7 Allianz

Inst29Quest7 = "7. A Fine Mess"
Inst29Quest7_Attain = "22"
Inst29Quest7_Level = "30"
Inst29Quest7_Aim = "Escort Kernobee to the Clockwerk Run exit and then report to Scooty in Booty Bay."
Inst29Quest7_Location = "Kernobee (Gnomeregan "..YELLOW..""..YELLOW.."[]"..WHITE..""..WHITE..")"
Inst29Quest7_Note = "Escort quest! You find Scooty in "..YELLOW.."Stranglethorn Vale (Booty Bay; 27,77)."..WHITE..""
Inst29Quest7_Prequest = "No"
Inst29Quest7_Folgequest = "No"
--
Inst29Quest7name1 = "Fire-welded Bracers"
Inst29Quest7name2 = "Fairywing Mantle"

--Quest8 Allianz

Inst29Quest8 = "8. The Grand Betrayal"
Inst29Quest8_Attain = "?"
Inst29Quest8_Level = "35"
Inst29Quest8_Aim = "Venture to Gnomeregan and kill Mekgineer Thermaplugg. Return to High Tinker Mekkatorque when the task is complete."
Inst29Quest8_Location = "High Tinker Mekkatorque (Ironforge "..YELLOW.."68,48"..WHITE..")"
Inst29Quest8_Note = "You find Thermaplugg at "..YELLOW.."[6]"..WHITE..". He is the last boss in Gnomeregan.\nDuring the fight you have to disable the columns through pushing the button on the side."
Inst29Quest8_Prequest = "No"
Inst29Quest8_Folgequest = "No"
--
Inst29Quest8name1 = "Civinad Robes"
Inst29Quest8name2 = "Triprunner Dungarees"
Inst29Quest8name3 = "Dual Reinforced Leggings"

--QUEST1 Horde

Inst29Quest1_HORDE = "1. Gnomer-gooooone!"
Inst29Quest1_HORDE_Attain = "23"
Inst29Quest1_HORDE_Level = "35"
Inst29Quest1_HORDE_Aim = "Wait for Scooty to calibrate the Goblin Transponder."
Inst29Quest1_HORDE_Location = "Scooty (Stranglethorn Vale - Booty Bay; "..YELLOW.."27,77 "..WHITE..")"
Inst29Quest1_HORDE_Note = "You get the prequest from Sovik "..YELLOW.."(Orgrimmar; 75,25)"..WHITE..".\nWhen you complete this quest you can use the transponder in Booty Bay."
Inst29Quest1_HORDE_Prequest = "Yes, Chief Engineer Scooty"
Inst29Quest1_HORDE_Folgequest = "No"
Inst29Quest1PreQuest_HORDE = "true"

--Quest2 Horde

Inst29Quest2_HORDE = "2. A Fine Mess"
Inst29Quest2_HORDE_Attain = "22"
Inst29Quest2_HORDE_Level = "30"
Inst29Quest2_HORDE_Aim = "Escort Kernobee to the Clockwerk Run exit and then report to Scooty in Booty Bay."
Inst29Quest2_HORDE_Location = "Kernobee (Gnomeregan "..YELLOW.."near the clean zone"..WHITE..")"
Inst29Quest2_HORDE_Note = "Escort quest! You find Scooty in "..YELLOW.."Stranglethorn Vale (Booty Bay; 27,77)."..WHITE..""
Inst29Quest2_HORDE_Prequest = "No"
Inst29Quest2_HORDE_Folgequest = "No"
--
Inst29Quest2name1_HORDE = "Fire-welded Bracers"
Inst29Quest2name2_HORDE = "Fairywing Mantle"

--Quest3 Horde

Inst29Quest3_HORDE = "3. Rig Wars"
Inst29Quest3_HORDE_Attain = "?"
Inst29Quest3_HORDE_Level = "35"
Inst29Quest3_HORDE_Aim = "Retrieve the Rig Blueprints and Thermaplugg's Safe Combination from Gnomeregan and bring them to Nogg in Orgrimmar."
Inst29Quest3_HORDE_Location = "Nogg (Orgrimmar; "..YELLOW.."75,25 "..WHITE..")"
Inst29Quest3_HORDE_Note = "You find Thermaplugg at "..YELLOW.."[6]"..WHITE..". He is the last boss in Gnomeregan.\nDuring the fight you have to disable the columns through pushing the button on the side."
Inst29Quest3_HORDE_Prequest = "No"
Inst29Quest3_HORDE_Folgequest = "No"
--
Inst29Quest3name1_HORDE = "Civinad Robes"
Inst29Quest3name2_HORDE = "Triprunner Dungarees"
Inst29Quest3name3_HORDE = "Dual Reinforced Leggings"

------------------------------------------------------------------------------------------------------
------------------------------------------------- RAID -----------------------------------------------
------------------------------------------------------------------------------------------------------

--------------Inst30/Alptraumdrachen------------
Inst30Story = {
  ["Page1"] = "Une \195\169trange perturbation est survenue aux alentours des Grands arbres. Un nouveau p\195\169ril menace ces endroits recul\195\169s d\'Ashenvale, du Bois de la p\195\169nombre, de Feralas et des Hinterlands. Quatre prestigieux gardiens du Vol vert sont sortis du R\195\170ve. Mais ces quatre protecteurs, autrefois bienveillants, ne recherchent plus que la mort et la destruction. Rassemblez vos compagnons, d\195\169couvrez ces bosquets cach\195\169s. Vous seuls pouvez encore d\195\169fendre Azeroth contre la corruption qu\'ils y apportent.",
  ["Page2"] = "Ysera est la grande R\195\170veuse, l\'Aspect dragon qui r\195\168gne sur l\'\195\169nigmatique Vol vert. Son domaine est le fantastique et mystique royaume du R\195\170ve d\'\195\169meraude et l\'on raconte qu\'elle dirige depuis ce lieu l\'\195\169volution du monde lui-m\195\170me. Elle est la protectrice de la nature et de l\'imagination, et c\'est le devoir de son Vol que de garder les Grands arbres du monde, ces portails par lesquels seuls les druides peuvent entrer dans le R\195\170ve d\'\195\169meraude.\n\nIl y a peu, les plus fid\195\168les lieutenants d\'Ysera ont \195\169t\195\169 corrompus et transform\195\169s par une t\195\169n\195\169breuse et nouvelle puissance au sein du R\195\170ve d\'\195\169meraude. Ces sentinelles, telles des entit\195\169s de cauchemar s\'incarnant dans le monde mortel, ont maintenant franchi les Grands arbres pour se rendre en Azeroth, avec l\'intention de r\195\169pandre la folie et la terreur \195\160 travers tous les royaumes. M\195\170me le plus vaillant des aventuriers devrait se tenir \195\160 grande distance de ces dragons pour ne pas souffrir des cons\195\169quences de leur col\195\168re d\195\169voy\195\169e.",
  ["Page3"] = "L\'exposition de L\195\169thon \195\160 l\'aberration apparue au sein du R\195\170ve d\'\195\169meraude a non seulement assombri la couleur de ses majestueuses \195\169cailles, mais lui a \195\169galement donn\195\169 le pouvoir d\'extraire des ombres malfaisantes de ses ennemis. Une fois que ces ombres ont fusionn\195\169 avec leur nouveau ma\195\174tre, elles lui permettent d\'acc\195\169der \195\160 des \195\169nergies revitalisantes. Il n\'est alors pas surprenant que L\195\169thon soit consid\195\169r\195\169 comme l\'un des plus forts des lieutenants d\195\169voy\195\169s d\'Ysera.",
  ["Page4"] = "Une myst\195\169rieuse puissance t\195\169n\195\169breuse, apparue au sein de R\195\170ve d\'\195\169meraude, a transform\195\169 l\'ancien et majestueux Emeriss en une monstruosit\195\169 malade et pourrissante. Les r\195\169cits des quelques survivants qui l\'ont rencontr\195\169 d\195\169crivent l\'\195\169ruption d\'ignobles champignons putrides sur les cadavres de leurs compagnons. Emeriss est le plus horrible et \195\169pouvantable des dragons verts ayant quitt\195\169 Ysera.",
  ["Page5"] = "Taerar est sans doute \195\169t\195\169 celui des lieutenants d\195\169voy\195\169s d\'Ysera qui a \195\169t\195\169 le plus affect\195\169. Sa rencontre avec la force t\195\169n\195\169breuse au sein du R\195\170ve d\'\195\169meraude a fragment\195\169 non seulement sa sant\195\169 mentale mais \195\169galement sa forme corporelle. Le dragon se manifeste maintenant tel un spectre capable de se s\195\169parer en multiples entit\195\169s, chacune d\'entre elles poss\195\169dant des pouvoirs de magie et de destruction. Taerar est un ennemi rus\195\169 et implacable qui d\195\169sire imposer la folie de son existence \195\160 la r\195\169alit\195\169 des habitants d\'Azeroth.",
  ["Page6"] = "Ysondre \195\169tait l\'un des lieutenants les plus fid\195\168les d\'Ysera. Elle est maintenant compl\195\168tement d\195\169voy\195\169e, semant chaos et terreur \195\160 travers les terres d\'Azeroth. Ses pouvoirs bienveillants de gu\195\169rison ont \195\169t\195\169 alt\195\169r\195\169s par une magie t\195\169n\195\169breuse qui lui permet \195\160 pr\195\169sent de lancer des vagues d\'\195\169clairs fumants et d\'invoquer l\'aide de druides corrompus. Ysondre et les siens poss\195\168dent \195\169galement la capacit\195\169 d\'imposer un sommeil magique, qui envoie ses ennemis mortels arpenter leurs cauchemars les plus terrifiants.",
  ["MaxPages"] = "6",
};
Inst30Caption = "Dragons of Nightmare"
Inst30Caption2 = "Ysera et le Vol vert"
Inst30Caption3 = "Lethon"
Inst30Caption4 = "Emeriss"
Inst30Caption5 = "Taerar"
Inst30Caption6 = "Ysondre"

--------------Azuregos------------
Inst31Story = "Avant la grande Fracture, la cit\195\169 elfe d\'Eldarath prosp\195\169rait dans la r\195\169gion aujourd\'hui connue sous le nom d\'Azshara. Certains pensent que nombres d\'anciens et puissants artefacts des bien-n\195\169s peuvent encore \195\170tre d\195\169couverts dans les ruines de cette autrefois puissante place-forte. Des g\195\169n\195\169rations durant, le Vol bleu a su prot\195\169ger ces puissants artefacts et savoirs magiques, s\'assurant qu\'ils ne tomberaient pas entre les mains des mortels. La pr\195\169sence d\'Azuregos, le dragon bleu, semble sugg\195\168rer que des objets de grande importance, peut-\195\170tre m\195\170me les fabuleuses fioles d\'\195\169ternit\195\169, peuvent \195\170tre trouv\195\169s en Azshara. Quoique recherche Azuregos, une chose est certaine : il combattra jusqu\'\195\160 la mort pour d\195\169fendre les tr\195\169sors magiques d\'Azshara."
Inst31Caption = "Azuregos"

--------------Kazzak------------
Inst32Story = "Apr\195\168s la d\195\169faite de la L\195\169gion ardente \195\160 la fin de la Troisi\195\168me guerre, les forces survivantes de l\'ennemi, dirig\195\169es par le seigneur Kazzak, un d\195\169mon colossal, retrait\195\168rent jusque dans les Terres foudroy\195\169es. Elles y demeurent encore jusqu\'\195\160 ce jour, dans une zone appel\195\169e la Balafre impure, attendant la r\195\169ouverture de la Porte des t\195\169n\195\168bres. Selon les rumeurs, si la Porte des t\195\169n\195\168bres venait \195\160 s\'ouvrir de nouveau, Kazzak voyagerait avec son arm\195\169e jusqu\'en Outreterre. Autrefois terre natale des orcs appel\195\169e Draenor, l\'Outreterre a \195\169t\195\169 d\195\169chiquet\195\169e par les activations simultan\195\169es de nombreuses portes cr\195\169es par le chaman orc Ner\'zhul. Elle n\'est maintenant plus qu\'un monde bris\195\169 occup\195\169 par des hordes d\'agents d\195\169moniaques sous le contr\195\180le du traitre Illidan, un ancien elfe de la nuit."
Inst32Caption = "Seigneur Kazzak"

--------------Inst14/geschmolzener Kern------------
Inst14Story = "Le Coeur du Magma repose au fin fond des profondeurs de Blackrock. Il est le cœur de la montagne Blackrock et le lieu o\195\185, il y a bien longtemps, tentant d\195\169sesp\195\169r\195\169ment de changer le cours de la guerre civile naine, l\'empereur Thaurissan invoqua Ragnaros, le seigneur du Feu, en Azeroth. Bien que le seigneur du Feu soit incapable de s\'\195\169loigner du noyau ardent, certains pensent que ses serviteurs commandent aux nains Sombrefer, travaillant activement \195\160 la cr\195\169ation d\'une arm\195\169e \195\160 partir de pierre vivante. Le lac enflamm\195\169 o\195\185 Ragnaros repose endormi sert de portail vers le plan du feu, que des \195\169l\195\169mentaires malveillants n\'h\195\169sitent pas \195\160 traverser. C\'est au majordome Executus que revient le soin de diriger les agents de Ragnaros. Cet \195\169l\195\169mentaire particuli\195\168rement rus\195\169 est le seul capable de r\195\169veiller le seigneur du Feu."
Inst14Caption = "Coeur du Magma"

--------------Inst16/Onyxia------------
Inst16Story = "Onyxia est la fille du puissant dragon Aile de mort, et la sœur de l\'intrigant Nefarian, seigneur du Pic Blackrock. Il est dit qu\'Onyxia aime \195\160 corrompre les peuples mortels en se m\195\170lant de leurs affaires politiques. \195\160 cette fin, elle rev\195\170tirait diverses formes humano\195\175des et userait de ses charmes et de ses pouvoirs pour influencer \195\160 sa convenance la diplomatie, \195\180 combien d\195\169licate, entre les diff\195\169rents peuples d\'Azeroth. Certains croient m\195\170me qu\'Onyxia a assum\195\169 une identit\195\169 autrefois prise par son p\195\168re, \195\160 savoir le titre de la maison royale Prestor. Lorsqu\'elle ne se m\195\170le pas des affaires des mortels, Onyxia demeure dans les caves embras\195\169es sous le Cloaque aux dragons, un lugubre marais du Mar\195\169cage d\'\195\162prefange. Dans son repaire, elle est prot\195\169g\195\169e par ses pairs, membres survivants du Vol des dragon noirs."
Inst16Caption = "Repaire d\'Onyxia "

--------------Inst6------------
Inst6Story = {
  ["Page1"] = "Le repaire de l\'Aile noire se trouve au sommet du Pic Blackrock. C\'est dans les recoins les plus sombres, au sommet de cette montagne que Nefarian a \195\169labor\195\169 les derni\195\168res phases de son plan pour d\195\169truire Ragnaros une fois pour toute et lancer son arm\195\169e \195\160 l\'assaut d\'Azeroth.",
  ["Page2"] = "La puissante forteresse taill\195\169e dans les entrailles enflamm\195\169es du mont Blackrock fut con\195\167ue par le ma\195\174tre ma\195\167on nain Franclorn Forgewright. Elle devait \195\170tre le symbole de la puissance des Sombrefer, et ceux-ci la conserv\195\168rent pendant des si\195\168cles. Mais Nefarian, le rus\195\169 fils du dragon Aile de mort, avait d\'autres plans pour cet immense donjon. Aid\195\169 par ses sbires draconiques, il prit le contr\195\180le du sommet du pic et partit en guerre contre les domaines des nains, dans les profondeurs volcaniques de la montagne, le si\195\168ge du pouvoir du Seigneur du Feu Ragnaros. Ce dernier a d\195\169couvert le secret permettant de cr\195\169er la vie \195\160 partir de la pierre et projette de construire une arm\195\169e de golems invincibles pour l\'aider \195\160 conqu\195\169rir le mont Blackrock tout entier.",
  ["Page3"] = "Nefarian a jur\195\169 la perte de Ragnaros. Dans ce but, il cherche depuis peu \195\160 renforcer ses troupes, comme son p\195\168re Aile de mort avait tent\195\169 de le faire autrefois. Cependant, l\195\160 o\195\185 Aile de mort a \195\169chou\195\169, on dirait que Nefarian le comploteur pourrait r\195\169ussir. La folle qu\195\170te de pouvoir de Nefarian a m\195\170me d\195\169clench\195\169 la col\195\168re du Vol rouge, qui a toujours \195\169t\195\169 le pire ennemi du Vol noir. Bien que les intentions de Nefarian soient connues, ses m\195\169thodes demeurent myst\195\169rieuses. On pense cependant que Nefarian s\'est livr\195\169 \195\160 des exp\195\169riences avec le sang de tous les vols de dragon pour obtenir des guerriers invincibles.\n \nLa tani\195\168re de Nefarian, le repaire de l\'Aile noire, se trouve tout au sommet du Pic Blackrock. C\'est l\195\160, dans les sombres recoins de cette cime, que Nefarian a commenc\195\169 \195\160 mettre en œuvre les \195\169tapes finales de son plan. Il compte an\195\169antir Ragnaros une fois pour toutes, puis conduire son arm\195\169e \195\160 la supr\195\169matie incontest\195\169e sur toutes les races d\'Azeroth.",
  ["MaxPages"] = "3",
};

Inst6Caption = "Repaire de l\'Aile Noire"
Inst6Caption2 = "Histoire Partie 1:Repaire de l\'Aile Noire "
Inst6Caption3 = "Histoire Partie 2:Repaire de l\'Aile Noire "

--------------Inst23------------
Inst23Story = "Au cours des instants finaux de la guerre des Sables changeants, les forces combin\195\169es des elfes de la nuit et des quatre vols de dragon pouss\195\168rent la bataille jusqu\'au cœur m\195\170me de l\'empire qiraji, dans la cit\195\169 forteresse d\'Ahn\'Qiraj. Toutefois, alors qu\'elles \195\169taient aux portes de la cit\195\169, les arm\195\169es de Kalimdor rencontr\195\168rent une concentration de silithides guerriers plus importante que tout ce qu\'elles avaient affront\195\169 auparavant. Finalement, les silithides et leurs ma\195\174tres qiraji ne furent point d\195\169faits, mais seulement emprisonn\195\169s derri\195\168re une barri\195\168re magique ; et la guerre laissa en ruines la cit\195\169 maudite. Un millier d\'ann\195\169es a pass\195\169 depuis ce jour mais les forces qiraji ne sont pas rest\195\169es inactives. Une nouvelle et terrible arm\195\169e est n\195\169e des ruches, et les ruines d\'Ahn\'Qiraj grouillent \195\160 nouveau de nu\195\169es de silithides et de qiraji. Cette menace doit \195\170tre \195\169limin\195\169e ou tout Azeroth pourrait tomber devant la puissance terrifiante de la nouvelle arm\195\169e qiraji."
Inst23Caption = "Ruines d'Ahn'Qiraj"

--------------Inst26------------
Inst26Story = "C\'est au coeur d\'Ahn\'Qiraj que repose ce tr\195\168s ancien temple. Construit en des temps o\195\185 l\'histoire n\'\195\169tait pas encore \195\169crite, c\'est \195\160 la fois un monument \195\160 d\'indicibles dieux et une ruche massive o\195\185 nait l\'arm\195\169e qiraji. Depuis que la guerre des Sables changeants s\'est achev\195\169e il y a un millier d\'ann\195\169es, les empereurs jumeaux de l\'empire qiraji ont \195\169t\195\169 enferm\195\169s dans leur temple, \195\160 peine contenus par la barri\195\168re magique \195\169rig\195\169e par le dragon de bronze Anachronos et les elfes de la nuit. Maintenant que le sceptre des Sables changeant a \195\169t\195\169 r\195\169assembl\195\169 et que le sceau a \195\169t\195\169 bris\195\169, le chemin vers le sanctuaire d\'Ahn\'Qiraj a \195\169t\195\169 ouvert. Par del\195\160 la folie grouillante des ruches, sous le temple d\'Ahn\'Qiraj, des l\195\169gions de qiraji se pr\195\169parent \195\160 l\'invasion. Ils doivent \195\170tre arr\195\170t\195\169s \195\160 tout prix, avant qu\'ils ne l\195\162chent \195\160 nouveau sur Kalimdor leurs arm\195\169es insecto\195\175des et voraces, et qu\'une seconde guerre des Sables changeants ne se d\195\169clenche."
Inst26Caption = "Temple d'Ahn'Qiraj"

--------------Inst28------------
Inst28Story = {
  ["Page1"] = "Plus de mille ans auparavant, le puissant empire Gurubashi a \195\169t\195\169 d\195\169chir\195\169 par une gigantesque guerre civile. Un groupe de pr\195\170tres trolls influents, les Atal\'ai, tenta de faire revenir l\'avatar d\'un dieu ancien et terrible, Hakkar l\'\195\137corcheur d\'\195\162mes, le Dieu sanglant. Les pr\195\170tres furent vaincus, puis exil\195\169s, mais le grand empire troll s\'effondra. Les pr\195\170tres bannis s\'enfuirent vers le nord, dans le marais des Chagrins, o\195\185 ils b\195\162tirent un grand temple \195\160 Hakkar pour pr\195\169parer son retour dans le monde physique.",
  ["Page2"] = "Il y a plus de mille ans, le puissant empire Gurubashi a \195\169t\195\169 d\195\169chir\195\169 par une gigantesque guerre civile. Un groupe de pr\195\170tres trolls influents, les Atal\'ai, tenta de faire revenir l\'avatar d\'un dieu ancien et terrible, Hakkar l\'\195\137corcheur d\'\195\162mes, le Dieu sanglant. Les pr\195\170tres furent vaincus, puis exil\195\169s, mais le grand empire troll s\'effondra. Les pr\195\170tres bannis s\'enfuirent vers le nord, dans le marais des Chagrins, o\195\185 ils b\195\162tirent un grand temple \195\160 Hakkar pour pr\195\169parer son retour dans le monde physique.\n\nAvec le temps, les pr\195\170tres Atal\'ai d\195\169couvrirent que la forme mat\195\169rielle d\'Hakkar ne pouvait \195\170tre invoqu\195\169e que dans l\'ancienne capitale de l\'empire Gurubashi, Zul\'Gurub. R\195\169cemment, les pr\195\170tres sont parvenus \195\160 appeler Hakkar – des rapports confirment la pr\195\169sence du redoutable \195\137corcheur d\'\195\162mes au cœur des ruines des Gurubashi.\n\nPour vaincre le Dieu sanglant, les trolls de la r\195\169gion se sont unis et ont envoy\195\169 un groupe de grands-pr\195\170tres dans la cit\195\169 antique. Tous \195\169taient de puissants champions des Dieux primordiaux – Chauve-souris, Panth\195\168re, Tigre, Araign\195\169e et Serpent. En d\195\169pit de leurs efforts, ces pr\195\170tres sont tomb\195\169s sous l\'influence d\'Hakkar.",
  ["Page3"] = "A pr\195\169sent, ces champions et leurs aspects des Dieux primordiaux nourrissent l\'effroyable pouvoir de l\'\195\137corcheur d\'\195\162mes. Tous les aventuriers assez braves pour p\195\169n\195\169trer dans ces ruines sinistres devront triompher des grands-pr\195\170tres s\'ils veulent avoir une chance d\'affronter le terrible Dieu sanglant.\n",
  ["MaxPages"] = "3",
};

Inst28Caption = "Zul'Gurub"

--------------Inst15 /Naxxramas------------
Inst15Story = {
  ["Page1"] = "Flottant au-dessus des Maleterres, la n\195\169cropole de Naxxramas sert de r\195\169sidence \195\160 l\'un des plus puissants serviteurs du roi-liche, la terrible liche Kel\'Thuzad. Des horreurs venues du pass\195\169 s\'y rassemblent, rejoignant de nouvelles terreurs encore inconnues du reste du monde. Les serviteurs du roi-liche se pr\195\169parent \195\160 l\'assaut. Le Fl\195\169au est en marche... ",
  ["Page2"] = "Ce harc\195\168lement incessant commence \195\160 me fatiguer. J\'ai d\'importantes recherches en cours, des effets magiques subtils qui n\195\169cessitent des semaines de pr\195\169paration et de rituels. » Kel\'Thuzad fulminait. On l\'avait forc\195\169 \195\160 attendre plusieurs heures avant m\195\170me de lui permettre de rencontrer ses accusateurs. Drenden et Modera, apparemment les porte-parole du groupe, \195\169taient deux de ses critiques les plus manifestes. Ils n\'auraient cependant pas os\195\169 mettre en branle cette derni\195\168re inquisition sans avoir le soutien d\'Antonidas, qui ne s\'\195\169tait pas encore manifest\195\169. Que manigan\195\167ait donc le vieil homme \196\177\n\nDrenden pouffa. « C\'est la premi\195\168re fois que j\'entends qualifier votre style de magie de “subtil”.\n\n— Une opinion qui ne traduit que l\'incomp\195\169tence de celui qui la manifeste, » r\195\169pondit froidement Kel\'Thuzad.\n\nUne voix lointaine lui parvint alors, la voix d\'un ami. Avec le temps, elle lui \195\169tait devenue si famili\195\168re qu\'il lui semblait entendre ses propres pens\195\169es. Ils te craignent et ils te jalousent. Apr\195\168s tout, gr\195\162ce \195\160 ton nouvel axe de recherche, tu continues \195\160 progresser en savoir et en puissance.",
  ["Page3"] = "Il y eut un \195\169clair de lumi\195\168re, et un archimage aux cheveux gris et \195\160 la mine renfrogn\195\169e fit son apparition dans la salle, un petit coffret de bois coinc\195\169 sous le bras. « Je ne l\'aurais pas cru si je ne l\'avais pas vu de mes propres yeux. Tu as abus\195\169 de notre patience pour la derni\195\168re fois, Kel\'Thuzad.",
  ["MaxPages"] = "3",
};

Inst15Caption = "Naxxramas"
Inst15Caption2 = "La voie de la Damnation 1"
Inst15Caption3 = "La voie de la Damnation 2"

--------------Inst33 / Alterac Vally------------
Inst33Story = " Il y a bien longtemps, avant la Premi\195\168re Guerre, le d\195\169moniste Gul\'dan exila un clan orc, les Frostwolf, dans une vall\195\169e cach\195\169e au cœur des montagnes d\'Alterac. Ils ont surv\195\169cu tant bien que mal dans sa partie sud jusqu\'\195\160 la venue de Thrall.\n\nLorsque Thrall r\195\169unifia les clans, les Frostwolf, dirig\195\169s par le chaman orc Drek\'Thar, d\195\169cid\195\168rent de rester dans la vall\195\169e qui leur avait servi de foyer pendant si longtemps. Mais la paix ne tarda pas \195\160 \195\170tre troubl\195\169e par la venue de l\'exp\195\169dition naine des Stormpike.\n\nLes Stormpike se sont install\195\169s dans la vall\195\169e \195\160 la recherche de ressources naturelles et de reliques anciennes. Leurs intentions n\'\195\169taient pas hostiles, mais la pr\195\169sence des nains a d\195\169clench\195\169 un conflit brutal avec les orcs Frostwolf au sud. Ceux-ci ont jur\195\169 de chasser les intrus de leurs terres.  "
Inst33Caption = "Vall\195\169e d'Alterac"

--------------Inst34 / Arathi Basin------------
Inst34Story = "Le bassin d\'Arathi est un champ de bataille fluide et rapide, situ\195\169 dans les Hautes-terres d\'Arathi. Le bassin en lui-m\195\170me est riche en ressources, convoit\195\169es \195\160 la fois par la Horde et par l\'Alliance. La Ligue d\'Arathor affronte les Profanateurs, une unit\195\169 d\'\195\169lite des R\195\169prouv\195\169s, pour prendre et conserver le contr\195\180le des pr\195\169cieuses ressources qui s\'y trouvent."
Inst34Caption = "Bassin d'Arathi"

--------------Inst35 / Warsong Gulch------------
Inst35Story = "Nestled in the southern region of Ashenvale forest, Warsong Gulch is near the area where Grom Hellscream and his Orcs chopped away huge swaths of forest during the events of the Third War. Some orcs have remained in the vicinity, continuing their deforestation to fuel the Horde's expansion. They call themselves the Warsong Outriders.\nThe Night Elves, who have begun a massive push to retake the forests of Ashenvale, are now focusing their attention on ridding their land of the Outriders once and for all. And so, the Silverwing Sentinels have answered the call and sworn that they will not rest until every last Orc is defeated and cast out of Warsong Gulch. "
Inst35Caption = "Goulet des Warsong"


end

--    AQINSTANZ :
-- 1  = VC     21 = BSF
-- 2  = WC     22 = STRAT
-- 3  = RFA    23 = AQ20
-- 4  = ULD    24 = STOCKADE
-- 5  = BRD    25 = TEMPLE
-- 6  = BWl    26 = AQ40
-- 7  = BFD    27 = ZUL
-- 8  = LBRS   28 = ZG
-- 9  = UBRS   29 = GNOMERE
-- 10 = DME    30 = DRAGONS
-- 11 = DMN    31 = AZUREGOS
-- 12 = DMW    32 = KAZZAK
-- 13 = MARA   33 = AV
-- 14 = MC     34 = AB
-- 15 = NAXX   35 = WS
-- 16 = ONY    36 = REST
-- 17 = HUEGEL 37 = HCBloodFurnaces
-- 18 = KRAL   38 = HCShatteredHalls
-- 19 = KLOSTER
-- 20 = SCHOLO
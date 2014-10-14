
function AQInfo_OnLoad()
	this:RegisterEvent("VARIABLES_LOADED");
end 


function AQInfo_OnEvent(event)
	if ( event == "VARIABLES_LOADED" ) then
		SLASH_AQInfo1 = "/AQInfo";
		SLASH_AQInfo2 = "/aq";
		SlashCmdList["AQInfo"] = AQInfo_HandleSlashes;
		return;
	end
end

-- sprechen Sie Deutsches?
if ( GetLocale() == "deDE" ) then
function AQInfo_HandleSlashes(msg)
msg = string.lower(msg);

local ts0 = msg;
local ts1 = 'Keine Verzauberung gefunden';
local ts2 = 'Keine Questverwendung gefunden';
local ts3 = '';
local found = 0;
local raid=0;
local show3 = 0;
local show4 = 0;

if (string.find(msg," ") ) then
local flag = string.sub(msg,1, string.find(msg," ")-1);
local value = string.sub(msg, string.find(msg," ")+1);
if ( value == "raid" ) or ( value == "r" ) then
raid=1;
end;
msg=flag;
end;

if ( msg == "hilfe" ) then
ts0 = "AQInfo v 1.22: Branalia (Spinebreaker US)";
ts1 = "Based on ZGInfo By Amid (Hyjal/Dark Iron)";
ts2 = "/aq (gegenstand) -- zum Beispiel /aq dominanz";
ts3 = "/aq (gegenstand) raid or /aq (gegenstand) r um an den Raid zu schreiben -- zum Beispiel /aq dominanz raid";
ts4 = "(gegenstand) k\195\182nnen Skarab\195\164en, G\195\182tzen oder epische Gegenst\195\164nde sein";
show3=1;
show4=1;
end;

if ( msg == "todes" ) then
ts0 = "AQInfo: G\195\182tze des Todes wird ben\195\182tigt f\195\188r...";
ts1 = "MAGIER: Schultern || PRIESTER: F\195\188\195\159e und Brust";
ts2 = "HEXENMEISTER: Helm || KRIEGER: Beine";
found = 1;
end;
if ( msg == "lebens" ) then
ts0 = "G\195\182tze des Lebens wird ben\195\182tigt f\195\188r...";
ts1 = "DRUIDE: Helm || J\195\132GER: F\195\188\195\159e und Brust";
ts2 = "PALADIN/SCHAMANE: Schultern || PRIESTER: Beine";
found = 1;
end;
if ( msg == "nacht" ) then
ts0 = "AQInfo: G\195\182tze der Nacht wird ben\195\182tigt f\195\188r...";
ts1 = "MAGIER: Helm || SCHURKE: Beine";
ts2 = "HEXENMEISTER: F\195\188\195\159e und Brust || KRIEGER: Schultern";
found = 1;
end;
if ( msg == "wiedergeburt" ) then
ts0 = "AQInfo: G\195\182tze der Wiedergeburt wird ben\195\182tigt f\195\188r...";
ts1 = "DRUIDE: F\195\188\195\159e und Brust || PALADIN/SCHAMANE: Helm";
ts2 = "PRIESTER: Schultern || HEXENMEISTER: Beine";
found = 1;
end;
if ( msg == "kampfes" ) then
ts0 = "AQInfo: G\195\182tze des Kampfes wird ben\195\182tigt f\195\188r...";
ts1 = "DRUIDE: Schultern || J\195\132GER: Helm";
ts2 = "PALADIN/SCHAMANE: Beine || SCHURKE: F\195\188\195\159e und Brust";
found = 1;
end;
if ( msg == "weisen" ) then
ts0 = "AQInfo: G\195\182tze der Weisen wird ben\195\182tigt f\195\188r...";
ts1 = "MAGIER: Beine || PALADIN/SCHAMANE: F\195\188\195\159e und Brust";
ts2 = "PRIESTER: Helm || HEXENMEISTER: F\195\188\195\159e";
found = 1;
end;
if ( msg == "sonne" ) then
ts0 = "AQInfo: G\195\182tze der Sonne wird ben\195\182tigt f\195\188r...";
ts1 = "J\195\132GER: Beine || MAGIER: F\195\188\195\159e und Brust";
ts2 = "SCHURKE: Schultern || KRIEGER: Helm";
found = 1;
end;
if ( msg == "krieges" ) then
ts0 = "AQInfo: G\195\182tze des Krieges wird ben\195\182tigt f\195\188r...";
ts1 = "DRUIDE: Beine || J\195\132GER: Schultern";
ts2 = "SCHURKE: Helm || KRIEGER: F\195\188\195\159e und Brust";
found = 1;
end;

if ( msg == "knochen" ) then
ts0 = "AQInfo: Knochenskarab\195\164us wird ben\195\182tigt f\195\188r...";
ts1 = "DRUIDE: Schultern, J\195\132GER: F\195\188\195\159e und Beine";
ts2 = "MAGIER: Beine || PALADIN/SCHAMANE: Brust";
ts3 = "PRIESTER: Helm || SCHURKE: F\195\188\195\159e";
ts4 = "HEXENMEISTER: Schultern und Helm || KRIEGER: Brust";
show3=1;
show4=1;
found = 1;
end;
if ( msg == "bronze" ) then
ts0 = "AQInfo: Bronzeskarab\195\164us wird ben\195\182tigt f\195\188r...";
ts1 = "DRUIDE: Brust || J\195\132GER: Helm";
ts2 = "MAGIER: Schultern und Helm || PALADIN/SCHAMANE: F\195\188\195\159e und Beine";
ts3 = "PRIESTER: F\195\188\195\159e || SCHURKE: Brust";
ts4 = "HEXENMEISTER: Schultern || KRIEGER: Beine";
show3=1;
show4=1;
found = 1;
end;
if ( msg == "ton" ) then
ts0 = "AQInfo: Tonskarab\195\164us wird ben\195\182tigt f\195\188r...";
ts1 = "DRUIDE: Helm || J\195\132GER: Brust";
ts2 = "MAGIER: Brust || PALADIN/SCHAMANE: F\195\188\195\159e";
ts3 = "PRIESTER: Beine || SCHURKE: Schultern und Helm";
ts4 = "HEXENMEISTER: F\195\188\195\159e und Beine || KRIEGER: Schultern";
show3=1;
show4=1;
found = 1;
end;
if ( msg == "kristall" ) then
ts0 = "AQInfo: Kristallskarab\195\164us wird ben\195\182tigt f\195\188r...";
ts1 = "DRUIDE: Beine || J\195\132GER: Schultern";
ts2 = "MAGIER: F\195\188\195\159e || PALADIN/SCHAMANE: Schultern und Helm";
ts3 = "PRIESTER: Brust || SCHURKE: F\195\188\195\159e und Beine";
ts4 = "HEXENMEISTER: Brust || KRIEGER: Helm";
show3=1;
show4=1;
found = 1;
end;
if ( msg == "gold" ) then
ts0 = "AQInfo: Goldskarab\195\164us wird ben\195\182tigt f\195\188r...";
ts1 = "DRUIDE: Schultern und Helm || J\195\132GER: Brust";
ts2 = "MAGIER: Brust || PALADIN/SCHAMANE: Schultern";
ts3 = "PRIESTER: F\195\188\195\159e und Beine || SCHURKE: Helm";
ts4 = "HEXENMEISTER: Beine || KRIEGER: F\195\188\195\159e";
show3=1;
show4=1;
found = 1;
end;
if ( msg == "elfenbein" ) then
ts0 = "AQInfo: Elfenbeinskarab\195\164us wird ben\195\182tigt f\195\188r...";
ts1 = "DRUIDE: Brust || J\195\132GER: Schultern und Helm";
ts2 = "MAGIER: Helm || PALADIN/SCHAMANE: Beine";
ts3 = "PRIESTER: Schultern || SCHURKE: Brust";
ts4 = "HEXENMEISTER: F\195\188\195\159e || KRIEGER: F\195\188\195\159e und Beine";
show3=1;
show4=1;
found = 1;
end;
if ( msg == "silber" ) then
ts0 = "AQInfo: Silberskarab\195\164us wird ben\195\182tigt f\195\188r...";
ts1 = "DRUIDE: F\195\188\195\159e || J\195\132GER: Beine";
ts2 = "MAGIER: F\195\188\195\159e und Beine || PALADIN/SCHAMANE: Brust";
ts3 = "PRIESTER: Schultern und Helm || SCHURKE: Schultern";
ts4 = "HEXENMEISTER: Helm || KRIEGER: Brust";
show3=1;
show4=1;
found = 1;
end;
if ( msg == "stein" ) then
ts0 = "AQInfo: Steinskarab\195\164us wird ben\195\182tigt f\195\188r...";
ts1 = "DRUIDE: F\195\188\195\159e und Beine || J\195\132GER: F\195\188\195\159e";
ts2 = "MAGIER: Schultern || PALADIN/SCHAMANE: Helm";
ts3 = "PRIESTER: Brust || SCHURKE: Beine";
ts4 = "HEXENMEISTER: Brust || KRIEGER: Schultern und Helm";
show3=1;
show4=1;
found = 1;
end;




if ( msg == "dominanzbindung" ) then
ts0 = 'AQInfo: Dominanzbindungen der Qiraji wird ben\195\182tigt f\195\188r...';
ts1 = 'Schultern- und F\195\188\195\159e-Quest der folgenden Klassen...';
ts2 = 'DRUIDEN, MAGIER, PALADINE/SCHAMANEN, HEXENMEISTER';
found = 1;
end;
if (msg == "befehlsbindung" ) then
ts0 = 'AQInfo: Befehlsbindungen der Qiraji wird ben\195\182tigt f\195\188r...';
ts1 = 'Schultern- und F\195\188\195\159e-Quest der folgenden Klassen...';
ts2 = 'J\195\132GER, PRIESTER, SCHURKEN, KRIEGER';
found = 1;
end;
if (msg == "hülle" ) then
ts0 = 'AQInfo: H\195\188lle des alten Gottes wird ben\195\182tigt f\195\188r...';
ts1 = 'Brust-Quest der folgenden Klassen...';
ts2 = 'DRUIDEN, MAGIER, PRIESTER, HEXENMEISTER';
found = 1;
end;
if (msg == "knochenpanzer" ) then
ts0 = 'AQInfo: Knochenpanzer des alten Gottes wird ben\195\182tigt f\195\188r...';
ts1 = 'Brust-Quest der folgenden Klassen...';
ts2 = 'J\195\132GER, PALADINE/SCHAMANEN, SCHURKEN, KRIEGER';
found = 1;
end;
if (msg == "diadem" ) then
ts0 = 'AQInfo: Vek\'lors Diadem wird ben\195\182tigt f\195\188r...';
ts1 = 'Helm-Quest der folgenden Klassen...';
ts2 = 'DRUIDEN, J\195\132GER, PALADINE/SCHAMANEN, SCHURKEN';
found = 1;
end;
if (msg == "reif" ) then
ts0 = 'AQInfo: Vek\'nilashs Reif wird ben\195\182tigt f\195\188r...';
ts1 = 'Helm-Quest der folgenden Klassen...';
ts2 = 'MAGIER, PRIESTER, HEXENMEISTER, KRIEGER';
found = 1;
end;
if (msg == "sandwurm" ) then
ts0 = 'AQInfo: Haut des großen Sandwurms wird ben\195\182tigt f\195\188r...';
ts1 = 'Beine-Quest der folgenden Klassen...';
ts2 = 'DRUIDEN, J\195\132GER, PALADINE/SCHAMANEN, HEXENMEISTER';
found = 1;
end;
if (msg == "ouro" ) then
ts0 = 'AQInfo: Ouros intakte Haut wird ben\195\182tigt f\195\188r...';
ts1 = 'Beine-Quest der folgenden Klassen...';
ts2 = 'MAGIER, PRIESTER, SCHURKEN, KRIEGER';
found = 1;
end;
if (msg == "qirajiwaffe" ) then
ts0 = 'AQInfo: Imperiale Qirajiwaffe mit 3 Elementiumerz wird ben\195\182tigt f\195\188r...';
ts1 = '1H-Axt: 60.6 dps, 205 top, 2.6 speed, +9 Sta, +10 Int, +1% crit, +14 atk pwr';
ts2 = 'Schusswaffe: 47.3 dps, 160 top, 2.6 speed, +10 Sta, +31 rng atk pwr';
ts3 = 'Dolch: 60.6 dps, 134 top, 1.7 speed, +7 Sta, +1% crit, +1% hit, +18 atk pwr';
ts4 = 'Schild: 2965 Armor, 55 Block, +20 Sta, +3% block, +15 block val, +8 Defense';
show3=1;
show4=1;
found = 1;
end;
if (msg == "qirajiinsignie" ) then
ts0 = 'AQInfo: Imperiale Qirajiinsignie mit 3 Elementiumerz wird ben\195\182tigt f\195\188r...';
ts1 = 'Stab: 59.8 dps, 227 top, 3.0 speed, +32 Sta, +33 Int, +76 dmg/heal, +2% spell hit, +1% spell crit';
ts2 = 'Stab: 59.8 dps, 227 top, 3.0 speed, +23 Sta, +24 Int, +143 heal, +15 mana/5 sec';
ts3 = '1H-Streitkolben: 60.7 dps, 166 top, 2.1 speed, 70 armor, +10 Str, +13 Sta, +280 atk pwr in bear/cat, +8 defense';
show3=1;
found = 1;
end;

if ( raid == 0 ) or ( found == 0) then
DEFAULT_CHAT_FRAME:AddMessage( ts0 );
DEFAULT_CHAT_FRAME:AddMessage( ts1 );
DEFAULT_CHAT_FRAME:AddMessage( ts2 );
if ( show3 == 1 ) then
DEFAULT_CHAT_FRAME:AddMessage( ts3 );
end;
if ( show4 == 1 ) then
DEFAULT_CHAT_FRAME:AddMessage( ts4 );
end;

else 
if ( raid == 1 ) then
SendChatMessage( ts0 , "raid" ); 
SendChatMessage( ts1 , "raid" ); 
SendChatMessage( ts2 , "raid" ); 
if ( show3 == 1 ) then
SendChatMessage( ts3 , "raid" ); 
end;
if ( show4 == 1 ) then
SendChatMessage( ts4 , "raid" ); 
end;
end;
end;

end

else

function AQInfo_HandleSlashes(msg)
	msg = string.lower(msg);
	   
	local ts0 = msg;
	local ts1 = 'No enchant found';
	local ts2 = 'No quest use found';
	local ts3 = '';
	local found = 0;
	local raid=0;
	local show3 = 0;
	local show4 = 0;

        if (string.find(msg," ") ) then
	   local flag = string.sub(msg,1, string.find(msg," ")-1);
	   local value = string.sub(msg, string.find(msg," ")+1);
	   if ( value == "raid" ) or ( value == "r" ) then
	      raid=1;
	   end;
	   msg=flag;
        end;

        if ( msg == "help" ) then
           ts0 = "AQInfo v 1.22: Branalia (Spinebreaker)";
           ts1 = "Based on ZGInfo By Amid (Hyjal/Dark Iron)";
           ts2 = "/aq (item) -- ie /aq dominance   /zg death";
           ts3 = "/aq (item) raid or /aq (item) r to broadcast to raid -- ie /aq dominance raid";
           ts4 = "(item) can be scarabs, idols, or epic items";
           show3=1;
           show4=1;
        end;

        if ( msg == "death" ) then
           ts0 = "AQInfo: Idol of Death is used for the following...";
           ts1 = "Mage Shoulders, Priest Boots AND Chest";
           ts2 = "Warlock Helm, Warrior Legs";
	   found = 1;
        end;
        if ( msg == "life" ) then
           ts0 = "AQInfo: Idol of Life is used for the following...";
           ts1 = "Druid Helm, Hunter Boots AND Chest";
           ts2 = "Paladin/Shaman Shoulders, Priest Legs";
	   found = 1;
        end;
        if ( msg == "night" ) then
           ts0 = "AQInfo: Idol of Night is used for the following...";
           ts1 = "Mage Helm, Rogue Legs";
           ts2 = "Warlock Boots AND Chest, Warrior Shoulders";
	   found = 1;
        end;
        if ( msg == "rebirth" ) then
           ts0 = "AQInfo: Idol of Rebirth is used for the following...";
           ts1 = "Druid Boots AND Chest, Paladin/Shaman Helm";
           ts2 = "Priest Shoulders, Warlock Legs";
	   found = 1;
        end;
        if ( msg == "strife" ) then
           ts0 = "AQInfo: Idol of Strife is used for the following...";
           ts1 = "Druid Shoulders, Hunter Helm";
           ts2 = "Paladin/Shaman Legs, Rogue Boots AND Chest";
	   found = 1;
        end;
        if ( msg == "sage" ) then
           ts0 = "AQInfo: Idol of the Sage is used for the following...";
           ts1 = "Mage Legs, Paladin/Shaman Boots AND Chest";
           ts2 = "Priest Helm, Warlock Boots";
	   found = 1;
        end;
        if ( msg == "sun" ) then
           ts0 = "AQInfo: Idol of the Sun is used for the following...";
           ts1 = "Hunter Legs, Mage Boots AND Chest";
           ts2 = "Rogue Shoulders, Warrior Helm";
	   found = 1;
        end;
        if ( msg == "war" ) then
           ts0 = "AQInfo: Idol of War is used for the following...";
           ts1 = "Druid Legs, Hunter Shoulders";
           ts2 = "Rogue Helm, Warrior Boots AND Chest";
	   found = 1;
        end;

        if ( msg == "bone" ) then
           ts0 = "AQInfo: Bone Scarab is used for the following...";
           ts1 = "Druid Shoulders, Hunter Boots AND Legs";
           ts2 = "Mage Legs, Paladin/Shaman Chest";
           ts3 = "Priest Helm, Rogue Boots";
           ts4 = "Warlock Shoulders AND Helm, Warrior Chest";
           show3=1;
           show4=1;
	   found = 1;
        end;
        if ( msg == "bronze" ) then
           ts0 = "AQInfo: Bronze Scarab is used for the following...";
           ts1 = "Druid Chest, Hunter Helm";
           ts2 = "Mage Shoulders AND Helm, Paladin/Shaman Boots AND Legs";
           ts3 = "Priest Boots, Rogue Chest";
           ts4 = "Warlock Shoulders, Warrior Legs";
           show3=1;
           show4=1;
	   found = 1;
        end;
        if ( msg == "clay" ) then
           ts0 = "AQInfo: Clay Scarab is used for the following...";
           ts1 = "Druid Helm, Hunter Chest";
           ts2 = "Mage Chest, Paladin/Shaman Boots";
           ts3 = "Priest Legs, Rogue Shoulders AND Helm";
           ts4 = "Warlock Boots AND Legs, Warrior Shoulders";
           show3=1;
           show4=1;
	   found = 1;
        end;
        if ( msg == "crystal" ) then
           ts0 = "AQInfo: Crystal Scarab is used for the following...";
           ts1 = "Druid Legs, Hunter Shoulders";
           ts2 = "Mage Boots, Paladin/Shaman Shoulders AND Helm";
           ts3 = "Priest Chest, Rogue Boots AND Legs";
           ts4 = "Warlock Chest, Warrior Helm";
           show3=1;
           show4=1;
	   found = 1;
        end;
        if ( msg == "gold" ) then
           ts0 = "AQInfo: Gold Scarab is used for the following...";
           ts1 = "Druid Shoulders AND Helm, Hunter Chest";
           ts2 = "Mage Chest, Paladin/Shaman Shoulders";
           ts3 = "Priest Boots AND Legs, Rogue Helm";
           ts4 = "Warlock Legs, Warrior Boots";
           show3=1;
           show4=1;
	   found = 1;
        end;
        if ( msg == "ivory" ) then
           ts0 = "AQInfo: Ivory Scarab is used for the following...";
           ts1 = "Druid Chest, Hunter Shoulders AND Helm";
           ts2 = "Mage Helm, Paladin/Shaman Legs";
           ts3 = "Priest Shoulders, Rogue Chest";
           ts4 = "Warlock Boots, Warrior Boots AND Legs";
           show3=1;
           show4=1;
	   found = 1;
        end;
        if ( msg == "silver" ) then
           ts0 = "AQInfo: Silver Scarab is used for the following...";
           ts1 = "Druid Boots, Hunter Legs";
           ts2 = "Mage Boots AND Legs, Paladin/Shaman Chest";
           ts3 = "Priest Shoulders AND Helm, Rogue Shoulders";
           ts4 = "Warlock Helm, Warrior Chest";
           show3=1;
           show4=1;
	   found = 1;
        end;
        if ( msg == "stone" ) then
           ts0 = "AQInfo: Stone Scarab is used for the following...";
           ts1 = "Druid Boots AND Legs, Hunter Boots";
           ts2 = "Mage Shoulders, Paladin/Shaman Helm";
           ts3 = "Priest Chest, Rogue Legs";
           ts4 = "Warlock Chest, Warrior Shoulders AND Helm";
           show3=1;
           show4=1;
	   found = 1;
        end;
        



	if ( msg == "dominance" ) then
	   ts0 = 'AQInfo: Qiraji Bindings of Dominance are used for the following...';
	   ts1 = 'Shoulders and Boots for the following classes...';
	   ts2 = 'Druid, Mage, Paladin/Shaman, and Warlock';
	   found = 1;
	end;
	if (msg == "command" ) then
	   ts0 = 'AQInfo: Qiraji Bindings of Command are used for the following...';
	   ts1 = 'Shoulders and Boots for the following classes...';
	   ts2 = 'Hunter, Priest, Rogue, and Warrior';
	   found = 1;
	end;
	if (msg == "husk" ) then
	   ts0 = 'AQInfo: Husk of the Old God is used for the following...';
	   ts1 = 'Chestpiece for the following classes...';
	   ts2 = 'Druid, Mage, Priest, and Warlock';
	   found = 1;
	end;
	if (msg == "carapace" ) then
	   ts0 = 'AQInfo: Carapace of the Old God is used for the following...';
	   ts1 = 'Chestpiece for the following classes...';
	   ts2 = 'Hunter, Paladin/Shaman, Rogue, and Warrior';
	   found = 1;
	end;
	if (msg == "diadem" ) then
	   ts0 = 'AQInfo: Vek\'lor\'s Diadem is used for the following...';
	   ts1 = 'Helm for the following classes...';
	   ts2 = 'Druid, Hunter, Paladin/Shaman, and Rogue';
	   found = 1;
	end;
	if (msg == "circlet" ) then
	   ts0 = 'AQInfo: Vek\'nilash\'s Circlet is used for the following...';
	   ts1 = 'Helm for the following classes...';
	   ts2 = 'Mage, Priest, Warlock, and Warrior';
	   found = 1;
	end;
	if (msg == "skin" ) then
	   ts0 = 'AQInfo: Skin of the Great Sandworm is used for the following...';
	   ts1 = 'Legs for the following classes...';
	   ts2 = 'Druid, Hunter, Paladin, and Warlock';
	   found = 1;
	end;
	if (msg == "hide" ) then
	   ts0 = 'AQInfo: Ouro\'s Intact Hide is used for the following...';
	   ts1 = 'Legs for the following classes...';
	   ts2 = 'Mage, Priest, Rogue, and Warrior';
	   found = 1;
	end;
	if (msg == "armaments" ) then
	   ts0 = 'AQInfo: Imperial Qiraji Armaments with 3 Elementium Ore are used for...';
	   ts1 = '1H Axe: 60.6 dps, 205 top, 2.6 speed, +9 Sta, +10 Int, +1% crit, +14 atk pwr';
	   ts2 = 'Gun: 47.3 dps, 160 top, 2.6 speed, +10 Sta, +31 rng atk pwr';
           ts3 = 'Dagger: 60.6 dps, 134 top, 1.7 speed, +7 Sta, +1% crit, +1% hit, +18 atk pwr';
           ts4 = 'Shield: 2965 Armor, 55 Block, +20 Sta, +3% block, +15 block val, +8 Defense';
           show3=1;
           show4=1;
	   found = 1;
	end;
	if (msg == "regalia" ) then
	   ts0 = 'AQInfo: Imperial Qiraji Regalia with 3 Elementium Ore are used for...';
	   ts1 = 'Staff: 59.8 dps, 227 top, 3.0 speed, +32 Sta, +33 Int, +76 dmg/heal, +2% spell hit, +1% spell crit';
	   ts2 = 'Staff: 59.8 dps, 227 top, 3.0 speed, +23 Sta, +24 Int, +143 heal, +15 mana/5 sec';
           ts3 = '1H Mace: 60.7 dps, 166 top, 2.1 speed, 70 armor, +10 Str, +13 Sta, +280 atk pwr in bear/cat, +8 defense';
           show3=1;
	   found = 1;
	end;
	
	if ( raid == 0 ) or ( found == 0) then
	   DEFAULT_CHAT_FRAME:AddMessage( ts0 );
	   DEFAULT_CHAT_FRAME:AddMessage( ts1 );
	   DEFAULT_CHAT_FRAME:AddMessage( ts2 );
	   if ( show3 == 1 ) then
	      DEFAULT_CHAT_FRAME:AddMessage( ts3 );
	   end;
	   if ( show4 == 1 ) then
	      DEFAULT_CHAT_FRAME:AddMessage( ts4 );
	   end;
	   
	else 
	   if ( raid == 1 ) then
              SendChatMessage(  ts0 , "raid" );	
              SendChatMessage(  ts1 , "raid" );	
              SendChatMessage(  ts2 , "raid" );	
	      if ( show3 == 1 ) then
                 SendChatMessage(  ts3 , "raid" );	
	      end;
	      if ( show4 == 1 ) then
                 SendChatMessage(  ts4 , "raid" );	
	      end;
           end;
	end;

end

end

CharStats_fullvals = {};

CharStats_base = {
	{ race = "NightElf", class = "DRUID", level = 60,
	  str = 62, agi = 65, sta = 69, int = 100, spi = 110,
	  ar = 0, fr = 0, nr = 10, ir = 0, sr=0,
	  health = 1993, mana = 2464 },
	{ race = "Tauren", class = "DRUID", level = 60,
	  str = 70, agi = 55, sta = 72, int = 95, spi = 112,
	  ar = 0, fr = 0, nr = 10, ir = 0, sr=0,
	  health = 2124, mana = 2389 },
	{ race = "Dwarf", class = "HUNTER", level = 60, 
	  str = 57, agi = 121, sta = 93, int = 64, spi = 69,
	  ar = 0, fr = 0, nr = 0, ir = 10, sr=0,
	  health = 2217, mana = 2400 },
	{ race = "Dwarf", class = "PALADIN", level = 60,
	  str = 107, agi = 61, sta = 103, int = 69, spi = 74,
	  ar = 0, fr = 0, nr = 0, ir = 10, sr=0,
	  health = 2231, mana = 2267 },
	{ race = "Dwarf", class = "PRIEST", level = 60,
	  str = 37, agi = 36, sta = 53, int = 119, spi = 124,
	  ar = 0, fr = 0, nr = 0, ir = 10, sr=0,
	  health = 1747, mana = 2881 },
	{ race = "Dwarf", class = "ROGUE", level = 60,
	  str = 82, agi = 126, sta = 78, int = 34, spi = 49,
	  ar = 0, fr = 0, nr = 0, ir = 10, sr=0,
	  health = 2123, mana = 0 },
	{ race = "Dwarf", class = "WARRIOR", level = 60,
	  str = 122, agi = 76, sta = 113, int = 29, spi = 44,
	  ar = 0, fr = 0, nr = 0, ir = 10, sr=0,
	  health = 2639, mana = 0 },
	{ race = "Gnome", class = "MAGE", level = 60,
	  str = 25, agi = 38, sta = 44, int = 134, spi = 120,
	  ar = 10, fr = 0, nr = 0, ir = 0, sr=0,
	  health = 1630, mana = 2943 },
	{ race = "Gnome", class = "ROGUE", level = 60,
	  str = 75, agi = 133, sta = 74, int = 40, spi = 50,
	  ar = 10, fr = 0, nr = 0, ir = 0, sr=0,
	  health = 2083, mana = 0 },
	{ race = "Gnome", class = "WARLOCK", level = 60,
	  str = 40, agi = 53, sta = 64, int = 119, spi = 115,
	  ar = 10, fr = 0, nr = 0, ir = 0, sr=0,
	  health = 1874, mana = 2878 },
	{ race = "Gnome", class = "WARRIOR", level = 60,
	  str = 115, agi = 83, sta = 109, int = 35, spi = 45,
	  ar = 10, fr = 0, nr = 0, ir = 0, sr=0,
	  health = 2599, mana = 0 },
	{ race = "Human", class = "MAGE", level = 60,
	  str = 30, agi = 35, sta = 45, int = 125, spi = 126,
	  ar = 0, fr = 0, nr = 0, ir = 0, sr=0,
	  health = 1640, mana = 2808 },
  	{ race = "Human", class = "PALADIN", level = 60,
	  str = 105, agi = 65, sta = 100, int = 70, spi = 79,
	  ar = 0, fr = 0, nr = 0, ir = 0, sr=0,
	  health = 2201, mana = 2282 },
	{ race = "Human", class = "PRIEST", level = 60,
	  str = 35, agi = 40, sta = 50, int = 120, spi = 131,
	  ar = 0, fr = 0, nr = 0, ir = 0, sr=0,
	  health = 1717, mana = 2896 },
	{ race = "Human", class = "ROGUE", level = 60,
	  str = 80, agi = 130, sta = 75, int = 35, spi = 52,
	  ar = 0, fr = 0, nr = 0, ir = 0, sr=0,
	  health = 2093, mana = 0 },
	{ race = "Human", class = "WARLOCK", level = 60,
	  str = 45, agi = 50, sta = 65, int = 110, spi = 121,
	  ar = 0, fr = 0, nr = 0, ir = 0, sr=0,
	  health = 1884, mana = 2743 },
	{ race = "Human", class = "WARRIOR", level = 60,
	  str = 120, agi = 80, sta = 110, int = 30, spi = 47,
	  ar = 0, fr = 0, nr = 0, ir = 0, sr=0,
	  health = 2609, mana = 0 },
	{ race = "NightElf", class = "HUNTER", level = 60,
	  str = 52, agi = 130, sta = 89, int = 65, spi = 70,
	  ar = 0, fr = 0, nr = 10, ir = 0, sr=0,
	  health = 2177, mana = 2415 },
	{ race = "NightElf", class = "PRIEST", level = 60,
	  str = 32, agi = 45, sta = 49, int = 120, spi = 125,
	  ar = 0, fr = 0, nr = 10, ir = 0, sr=0,
	  health = 1707, mana = 2896 },
	{ race = "NightElf", class = "ROGUE", level = 60,
	  str = 77, agi = 135, sta = 74, int = 35, spi = 50,
	  ar = 0, fr = 0, nr = 10, ir = 0, sr=0,
	  health = 2083, mana = 0 },
	{ race = "NightElf", class = "WARRIOR", level = 60,
	  str = 117, agi = 85, sta = 109, int = 30, spi = 45,
	  ar = 0, fr = 0, nr = 10, ir = 0, sr=0,
	  health = 2599, mana = 0 },
	{ race = "Orc", class = "HUNTER", level = 60,
	  str = 58, agi = 122, sta = 92, int = 62, spi = 73,
	  ar = 0, fr = 0, nr = 0, ir = 0, sr=0,
	  health = 2207, mana = 2370 },
	{ race = "Orc", class = "ROGUE", level = 60,
	  str = 83, agi = 127, sta = 77, int = 32, spi = 53,
	  ar = 0, fr = 0, nr = 0, ir = 0, sr=0,
	  health = 2113, mana = 0 },
	{ race = "Orc", class = "SHAMAN", level = 60,
	  str = 88, agi = 52, sta = 97, int = 87, spi = 103,
	  ar = 0, fr = 0, nr = 0, ir = 0, sr=0,
	  health = 2070, mana = 2545 },
	{ race = "Orc", class = "WARLOCK", level = 60,
	  str = 48, agi = 47, sta = 67, int = 107, spi = 118,
	  ar = 0, fr = 0, nr = 0, ir = 0, sr=0,
	  health = 1904, mana = 2698 },
	{ race = "Orc", class = "WARRIOR", level = 60,
	  str = 123, agi = 77, sta = 112, int = 27, spi = 48,
	  ar = 0, fr = 0, nr = 0, ir = 0, sr=0,
	  health = 2629, mana = 0 },
	{ race = "Tauren", class = "HUNTER", level = 60,
	  str = 60, agi = 120, sta = 92, int = 60, spi = 72,
	  ar = 0, fr = 0, nr = 10, ir = 0, sr=0,
	  health = 2317, mana = 2340 },
	{ race = "Tauren", class = "SHAMAN", level = 60,
	  str = 90, agi = 50, sta = 97, int = 85, spi = 102,
	  ar = 0, fr = 0, nr = 10, ir = 0, sr=0,
	  health = 2173, mana = 2515 },
	{ race = "Tauren", class = "WARRIOR", level = 60,
	  str = 125, agi = 75, sta = 112, int = 25, spi = 47,
	  ar = 0, fr = 0, nr = 10, ir = 0, sr=0,
	  health = 2760, mana = 0 },
	{ race = "Troll", class = "HUNTER", level = 60,
	  str = 56, agi = 127, sta = 91, int = 61, spi = 71,
	  ar = 0, fr = 0, nr = 0, ir = 0, sr=0,
	  health = 2197, mana = 2355 },
	{ race = "Troll", class = "MAGE", level = 60,
	  str = 31, agi = 37, sta = 46, int = 121, spi = 121,
	  ar = 0, fr = 0, nr = 0, ir = 0, sr=0,
	  health = 1650, mana = 2748 },
	{ race = "Troll", class = "PRIEST", level = 60,
	  str = 36, agi = 42, sta = 51, int = 116, spi = 126,
	  ar = 0, fr = 0, nr = 0, ir = 0, sr=0,
	  health = 1727, mana = 2836 },
	{ race = "Troll", class = "ROGUE", level = 60,
	  str = 81, agi = 132, sta = 76, int = 31, spi = 51,
	  ar = 0, fr = 0, nr = 0, ir = 0, sr=0,
	  health = 2103, mana = 0 },
	{ race = "Troll", class = "SHAMAN", level = 60,
	  str = 86, agi = 57, sta = 96, int = 86, spi = 101,
	  ar = 0, fr = 0, nr = 0, ir = 0, sr=0,
	  health = 2060, mana = 2530 },
	{ race = "Troll", class = "WARRIOR", level = 60,
	  str = 121, agi = 82, sta = 111, int = 26, spi = 46,
	  ar = 0, fr = 0, nr = 0, ir = 0, sr=0,
	  health = 2619, mana = 0 },
	{ race = "Scourge", class = "MAGE", level = 60,
	  str = 29, agi = 33, sta = 46, int = 123, spi = 125,
	  ar = 0, fr = 0, nr = 0, ir = 0, sr=10,
	  health = 1650, mana = 2778 },
	{ race = "Scourge", class = "PRIEST", level = 60,
	  str = 34, agi = 38, sta = 51, int = 118, spi = 130,
	  ar = 0, fr = 0, nr = 0, ir = 0, sr=10,
	  health = 1727, mana = 2866 },
	{ race = "Scourge", class = "ROGUE", level = 60,
	  str = 79, agi = 128, sta = 76, int = 33, spi = 55,
	  ar = 0, fr = 0, nr = 0, ir = 0, sr=10,
	  health = 2103, mana = 0 },
	{ race = "Scourge", class = "WARLOCK", level = 60,
	  str = 44, agi = 48, sta = 66, int = 108, spi = 120,
	  ar = 0, fr = 0, nr = 0, ir = 0, sr=10,
	  health = 1894, mana = 2713 },
	{ race = "Scourge", class = "WARRIOR", level = 60,
	  str = 119, agi = 78, sta = 111, int = 28, spi = 50,
	  ar = 0, fr = 0, nr = 0, ir = 0, sr=10,
	  health = 2619, mana = 0 },
};

CHARSTAT_EFFECTS = {
	{ effect = "STR",		name = STATCOMPARE_STR},
	{ effect = "AGI",		name = STATCOMPARE_AGI},
	{ effect = "STA",		name = STATCOMPARE_STA},
	{ effect = "INT",		name = STATCOMPARE_INT},
	{ effect = "SPI",		name = STATCOMPARE_SPI},
	{ effect = "ARMOR",		name = STATCOMPARE_ARMOR},
	{ effect = "ENARMOR",		name = STATCOMPARE_ENARMOR},
	{ effect = "DAMAGEREDUCE",	name = STATCOMPARE_DAMAGEREDUCE},

	{ effect = "ARCANERES",		name = STATCOMPARE_ARCANERES},
	{ effect = "FIRERES",		name = STATCOMPARE_FIRERES},
	{ effect = "NATURERES", 	name = STATCOMPARE_NATURERES},
	{ effect = "FROSTRES",		name = STATCOMPARE_FROSTRES},
	{ effect = "SHADOWRES",		name = STATCOMPARE_SHADOWRES},
	{ effect = "DETARRES",		name = STATCOMPARE_DETARRES},

	{ effect = "DEFENSE",		name = STATCOMPARE_DEFENSE},

	{ effect = "ATTACKPOWER",	name = STATCOMPARE_ATTACKPOWER},
	{ effect = "ATTACKPOWERUNDEAD",	name = STATCOMPARE_ATTACKPOWERUNDEAD},
	{ effect = "BEARAP",		name = STATCOMPARE_ATTACKPOWER},
	{ effect = "CATAP",		name = STATCOMPARE_ATTACKPOWER},
	{ effect = "CRIT",		name = STATCOMPARE_CRIT},
	{ effect = "BLOCK",		name = STATCOMPARE_BLOCK},
	{ effect = "TOBLOCK",		name = STATCOMPARE_TOBLOCK},
	{ effect = "DODGE",		name = STATCOMPARE_DODGE},
	{ effect = "PARRY", 		name = STATCOMPARE_PARRY},
	--{ effect = "TOHIT", 		name = STATCOMPARE_TOHIT},
	{ effect = "RANGEDATTACKPOWER", name = STATCOMPARE_RANGEDATTACKPOWER},
	--{ effect = "RANGEDCRIT",	name = STATCOMPARE_RANGEDCRIT},

	{ effect = "DMG",		name = STATCOMPARE_DMG},
	{ effect = "DMGUNDEAD",		name = STATCOMPARE_DMGUNDEAD},
	{ effect = "HEAL",		name = STATCOMPARE_HEAL},
	{ effect ="FLASHHOLYLIGHTHEAL", name = STATCOMPARE_FLASHHOLYLIGHT_HEAL},
	--{ effect = "HOLYCRIT", 		name = STATCOMPARE_HOLYCRIT},
	--{ effect = "SPELLCRIT", 	name = STATCOMPARE_SPELLCRIT},
	--{ effect = "SPELLTOHIT", 	name = STATCOMPARE_SPELLTOHIT},
	--{ effect = "ARCANEDMG", 	name = STATCOMPARE_ARCANEDMG},
	--{ effect = "FIREDMG", 		name = STATCOMPARE_FIREDMG},
	--{ effect = "FROSTDMG",		name = STATCOMPARE_FROSTDMG},
	--{ effect = "HOLYDMG",		name = STATCOMPARE_HOLYDMG},
	--{ effect = "NATUREDMG",		name = STATCOMPARE_NATUREDMG},
	--{ effect = "SHADOWDMG",		name = STATCOMPARE_SHADOWDMG},

	{ effect = "HEALTH",		name = STATCOMPARE_HEALTH},
	{ effect = "MANA",		name = STATCOMPARE_MANA},

};

function StatCompare_CharStats_Scan(bonuses, unit)
	local sunit;
	local found = false;
	local CharStats_basevals = {};
	CharStats_fullvals = {};

	if(unit) then
		sunit = unit;
	else
		sunit = "target";
	end

	if ( not UnitIsPlayer(sunit)) then
		return;
	end

	if (UnitLevel(sunit) ~= 60) then
		return;
	end

	local _, race = UnitRace(sunit);
	local _, class = UnitClass(sunit);
	for i=1, getn(CharStats_base) do
		if(CharStats_base[i].race == race and CharStats_base[i].class == class) then
			CharStats_basevals["STR"] = CharStats_base[i].str;
			CharStats_basevals["AGI"] = CharStats_base[i].agi;
			CharStats_basevals["STA"] = CharStats_base[i].sta;
			CharStats_basevals["SPI"] = CharStats_base[i].spi;
			CharStats_basevals["INT"] = CharStats_base[i].int;
			CharStats_basevals["ARCANERES"] = CharStats_base[i].ar;
			CharStats_basevals["FIRERES"]   = CharStats_base[i].fr;
			CharStats_basevals["NATURERES"] = CharStats_base[i].nr;
			CharStats_basevals["FROSTRES"] = CharStats_base[i].ir;
			CharStats_basevals["SHADOWRES"] = CharStats_base[i].sr;
			CharStats_basevals["HEALTH"] = CharStats_base[i].health;
			CharStats_basevals["MANA"] = CharStats_base[i].mana;
			found = true;
			break;
		end
	end

	if(not found) then
		return;
	end

	-- Defence = 300
	CharStats_basevals["DEFENSE"] = 300;
	
	for i,e in CHARSTAT_EFFECTS do
		if(bonuses[e.effect]) then
			CharStats_fullvals[e.effect] = bonuses[e.effect];
		end
		if(CharStats_basevals[e.effect]) then
			if(CharStats_fullvals[e.effect]) then
				CharStats_fullvals[e.effect] = CharStats_fullvals[e.effect] + CharStats_basevals[e.effect];
			else
				CharStats_fullvals[e.effect] = CharStats_basevals[e.effect];
			end
		end
	end

	-- for paladin's bless of king 
	if(SC_Buffer_King and SC_Buffer_King == 1) then
		SC_Buffer_King = 0;
		CharStats_fullvals["STA"] = math.ceil(CharStats_fullvals["STA"] * 1.10);
		CharStats_fullvals["INT"] = math.ceil(CharStats_fullvals["INT"] * 1.10);
		CharStats_fullvals["STR"] = math.ceil(CharStats_fullvals["STR"] * 1.10);
		CharStats_fullvals["AGI"] = math.ceil(CharStats_fullvals["AGI"] * 1.10);
		CharStats_fullvals["SPI"] = math.ceil(CharStats_fullvals["SPI"] * 1.10);
	end
	
	-- Health = 10 * Sta
	if(CharStats_fullvals["HEALTH"]) then
		CharStats_fullvals["HEALTH"] = CharStats_fullvals["HEALTH"] + 10 * (CharStats_fullvals["STA"] - CharStats_basevals["STA"]);
	else
		CharStats_fullvals["HEALTH"] = CharStats_basevals["HEALTH"] + 10 * (CharStats_fullvals["STA"] - CharStats_basevals["STA"]);
	end

	-- Mana = 15 * Int
	if(CharStats_basevals["MANA"] and CharStats_fullvals["MANA"]) then
		CharStats_fullvals["MANA"] = CharStats_fullvals["MANA"] + 15 * (CharStats_fullvals["INT"] - CharStats_basevals["INT"]);
	elseif(CharStats_basevals["MANA"]) then
		CharStats_fullvals["MANA"] = CharStats_basevals["MANA"] + 15 * (CharStats_fullvals["INT"] - CharStats_basevals["INT"]);
	end

	if (class == "ROGUE" or class == "WARRIOR" ) then
		CharStats_fullvals["MANA"] = 0;
	end

	-- Armor = 2 * Agi + EnArmor + equip_armor
	if(CharStats_fullvals["AGI"]) then
		if(CharStats_fullvals["ARMOR"]) then
			CharStats_fullvals["ARMOR"] = 2 * CharStats_fullvals["AGI"] + CharStats_fullvals["ARMOR"];
		else
			CharStats_fullvals["ARMOR"] = 2 * CharStats_fullvals["AGI"];
		end
		if(CharStats_fullvals["ENARMOR"]) then
			CharStats_fullvals["ARMOR"] = CharStats_fullvals["ENARMOR"] + CharStats_fullvals["ARMOR"];
		end
	end

	local value = 0;

	-- DR = 100 * Armour / ( Armour + 85*level + 400 )
	value = 100 * CharStats_fullvals["ARMOR"] / (CharStats_fullvals["ARMOR"] + 85 * 60 + 400);
	CharStats_fullvals["DAMAGEREDUCE"] = format("%.2f",value);

	-- AP(Attack Power)
	value = 0;
    	if(class == "DRUID") then
		value = 2 * CharStats_fullvals["STR"] - 20;
	elseif (class == "MAGE" or class == "PRIEST" or class == "WARLOCK") then
		value = CharStats_fullvals["STR"] - 10;
	elseif (class == "HUNTER" or class == "ROGUE") then
		value = 60 * 2 + CharStats_fullvals["STR"] + CharStats_fullvals["AGI"] - 20;
	elseif (class == "WARRIOR" or class == "PALADIN") then
		value = 60 * 3 + CharStats_fullvals["STR"] * 2 - 20;
	elseif (class == "SHAMAN") then
		value = 60 * 2 + CharStats_fullvals["STR"] * 2 - 20;
	end

	if(CharStats_fullvals["ATTACKPOWER"]) then
		CharStats_fullvals["ATTACKPOWER"] = value + CharStats_fullvals["ATTACKPOWER"];
	else
		CharStats_fullvals["ATTACKPOWER"] = value;
	end

	if(class == "DRUID") then
		CharStats_fullvals["BEARAP"] = CharStats_fullvals["ATTACKPOWER"] + (60 * 3);
		CharStats_fullvals["CATAP"] = CharStats_fullvals["ATTACKPOWER"] + (60 * 2) + CharStats_fullvals["AGI"];
	end

	if(CharStats_fullvals["ATTACKPOWERUNDEAD"]) then
		CharStats_fullvals["ATTACKPOWERUNDEAD"] = CharStats_fullvals["ATTACKPOWER"] + CharStats_fullvals["ATTACKPOWERUNDEAD"];
	end

	-- RAP(Ranged Attack Power)
	value = 0;
	if (class == "HUNTER") then
		value = 60 * 2 + 2 * CharStats_fullvals["AGI"] - 20;
	elseif (class == "WARRIOR" or class == "ROGUE") then
		value = 60 + CharStats_fullvals["AGI"] * 2 - 20;
	else 
		value = 0;
	end

	if (bonuses["ATTACKPOWER"]) then
		value = value + bonuses["ATTACKPOWER"];
	end
	
	if(CharStats_fullvals["RANGEDATTACKPOWER"]) then
		CharStats_fullvals["RANGEDATTACKPOWER"] = value + CharStats_fullvals["RANGEDATTACKPOWER"];
	else
		CharStats_fullvals["RANGEDATTACKPOWER"] = value;
	end

	if (class == "HUNTER" or class == "WARRIOR" or class == "ROGUE") then
	else
		-- ignore the other classes' ranged attack power.
		CharStats_fullvals["RANGEDATTACKPOWER"] = 0;
	end

	-- Parry
	value = 0;
	if (class == "DRUID" or class == "MAGE" or class == "PRIEST" or class == "WARLOCK" or class == "SHAMAN") then
		value = 0;
	else
		-- because the Talent, this value is not accu. :(
		value = 5 + 0.04 * (CharStats_fullvals["DEFENSE"] - CharStats_basevals["DEFENSE"]);
		if(bonuses["PARRY"]) then
			value = value + bonuses["PARRY"];
		end
	end
	CharStats_fullvals["PARRY"] = value;

	-- Block
	value = 0;
	if (CharStats_fullvals["BLOCK"]) then
		value = CharStats_fullvals["BLOCK"] + (CharStats_fullvals["STR"] / 20 - 1);
	end
	CharStats_fullvals["BLOCK"] = value;

	-- To Block
	value = 0;
	if (CharStats_fullvals["TOBLOCK"]) then
		value = CharStats_fullvals["TOBLOCK"] + (CharStats_fullvals["DEFENSE"] - CharStats_basevals["DEFENSE"]) * 0.04;
	end
	CharStats_fullvals["TOBLOCK"] = value;
	
	-- Dodge
	value = 0;
	if(class == "DRUID") then
    		value = 0.9 + CharStats_fullvals["AGI"]/20 + (CharStats_fullvals["DEFENSE"] - CharStats_basevals["DEFENSE"]) * 0.04;
	elseif(class == "HUNTER") then
		value = CharStats_fullvals["AGI"]/26.68 + (CharStats_fullvals["DEFENSE"] - CharStats_basevals["DEFENSE"]) * 0.04;
	elseif(class == "PALADIN") then
		-- because the Talent, this value is not accu. :(
		value = 0.74 + CharStats_fullvals["AGI"]/20 + (CharStats_fullvals["DEFENSE"] - CharStats_basevals["DEFENSE"]) * 0.04;
	elseif(class == "WARLOCK") then
		value = 5 + (CharStats_fullvals["AGI"] - CharStats_basevals["AGI"])/40 + (CharStats_fullvals["DEFENSE"] - CharStats_basevals["DEFENSE"]) * 0.04;
	elseif(class == "PRIEST") then
		value = 3 + CharStats_fullvals["AGI"]/20 + (CharStats_fullvals["DEFENSE"] - CharStats_basevals["DEFENSE"]) * 0.04;
	elseif(class == "MAGE") then
		value = 5 + 9 * (CharStats_fullvals["AGI"] - CharStats_basevals["AGI"])/200 + (CharStats_fullvals["DEFENSE"] - CharStats_basevals["DEFENSE"]) * 0.04;
	elseif(class == "ROGUE") then
		-- because the Talent, this value is not accu. :(
		value = CharStats_fullvals["AGI"] / 14.5 + (CharStats_fullvals["DEFENSE"] - CharStats_basevals["DEFENSE"]) * 0.04;
	elseif(class == "SHAMAN") then
		-- because the Talent, this value is not accu. :(
		value = 1.7 +  CharStats_fullvals["AGI"] /20 + (CharStats_fullvals["DEFENSE"] - CharStats_basevals["DEFENSE"]) * 0.04;
	elseif(class == "WARRIOR") then
		-- because the Talent, this value is not accu. :(
    		value = CharStats_fullvals["AGI"] / 20 + (CharStats_fullvals["DEFENSE"] - CharStats_basevals["DEFENSE"]) * 0.04;
	end

	if(bonuses["DODGE"]) then
		value = value + bonuses["DODGE"];
	end

	if (race == "NightElf") then
		value = value + 1;
	end
	if(val ~= 0) then
		CharStats_fullvals["DODGE"] = value;
	else
		CharStats_fullvals["DODGE"] = 0;
	end

	-- Melee Critical Chance
	value = 0;
	if(class == "DRUID") then
		value = 0.9 + CharStats_fullvals["AGI"]/20 + (CharStats_fullvals["DEFENSE"] - CharStats_basevals["DEFENSE"]) * 0.04;
	elseif(class == "HUNTER") then
		-- because the Talent, this value is not accu. :(
		value = CharStats_fullvals["AGI"] / 52.91 ;
	elseif(class == "PALADIN") then
		-- because the Talent, this value is not accu. :(
		value = 0.7 + CharStats_fullvals["AGI"]/20 + (CharStats_fullvals["DEFENSE"] - CharStats_basevals["DEFENSE"]) * 0.04;
	elseif(class == "WARLOCK") then
		value = 2 + CharStats_fullvals["AGI"]/20 + (CharStats_fullvals["DEFENSE"] - CharStats_basevals["DEFENSE"]) * 0.04;
	elseif(class == "PRIEST") then
		value = 3 + CharStats_fullvals["AGI"]/20 + (CharStats_fullvals["DEFENSE"] - CharStats_basevals["DEFENSE"]) * 0.04;
	elseif(class == "MAGE") then
		value = 3 + CharStats_fullvals["AGI"]/20 + (CharStats_fullvals["DEFENSE"] - CharStats_basevals["DEFENSE"]) * 0.04;
	elseif(class == "ROGUE") then
		-- because the Talent, this value is not accu. :(
		-- value = 0.3 + CharStats_fullvals["AGI"] / 30;
		value = CharStats_fullvals["AGI"] / 29;
	elseif(class == "SHAMAN") then
		-- because the Talent, this value is not accu. :(
		value = 1.7 +  CharStats_fullvals["AGI"] /20 + (CharStats_fullvals["DEFENSE"] - CharStats_basevals["DEFENSE"]) * 0.04;
	elseif(class == "WARRIOR") then
		-- because the Talent, this value is not accu. :(
		-- Also w/o weapon skills, it is not accu.
    		value = CharStats_fullvals["AGI"] / 20 + (CharStats_fullvals["DEFENSE"] - CharStats_basevals["DEFENSE"]) * 0.04;
	end

	if(bonuses["CRIT"]) then
		value = value + bonuses["CRIT"];
	end

	if(val ~= 0) then
		CharStats_fullvals["CRIT"] = value;
	else
		CharStats_fullvals["CRIT"] = 0;
	end

	-- Spell Critical Chance
	value = 0;
	if(class == "DRUID") then
		-- because the Talent, this value is not accu. :(
		value = CharStats_fullvals["INT"]/60 + 1.8;
	elseif(class == "HUNTER") then
		-- because the Talent, this value is not accu. :(
		value = CharStats_fullvals["INT"] / 29.5;
	elseif(class == "PALADIN") then
		-- because the Talent, this value is not accu. :(
		value = CharStats_fullvals["INT"] / 29.5;
	elseif(class == "WARLOCK") then
		value = CharStats_fullvals["INT"] / 60.6 + 1.7;
	elseif(class == "PRIEST") then
		value = CharStats_fullvals["INT"] / 59.5 + 0.8;
	elseif(class == "MAGE") then
		value = CharStats_fullvals["INT"] / 59.5 + 0.2;
	elseif(class == "ROGUE") then
		value = 0;
	elseif(class == "SHAMAN") then
		-- because the Talent, this value is not accu. :(
		value = CharStats_fullvals["INT"] / 59.2 + 2.3;
	elseif(class == "WARRIOR") then
		value = 0;
	end

	if(bonuses["SPELLCRIT"]) then
		value = value + bonuses["SPELLCRIT"];
	end
	if(value ~= 0) then
		CharStats_fullvals["SPELLCRIT"] = value;
	else
		CharStats_fullvals["SPELLCRIT"] = 0;
	end
	
	-- Mana regen from spirit
	if(class == "DRUID") then
		CharStats_fullvals["MANAREGSPI"] = CharStats_fullvals["SPI"] / 5 + 15;
	elseif(class == "PRIEST") then
		CharStats_fullvals["MANAREGSPI"] = CharStats_fullvals["SPI"] / 4 + 12.5;
	elseif(class == "HUNTER") then
		CharStats_fullvals["MANAREGSPI"] = CharStats_fullvals["SPI"] / 5 + 15;
	elseif(class == "MAGE") then
		CharStats_fullvals["MANAREGSPI"] = CharStats_fullvals["SPI"] / 4 + 12.5;
	elseif(class == "PALADIN") then
		CharStats_fullvals["MANAREGSPI"] = CharStats_fullvals["SPI"] / 4 + 8;
	elseif(class == "SHAMAN") then
		CharStats_fullvals["MANAREGSPI"] = CharStats_fullvals["SPI"] / 5 + 17;
	elseif(class == "WARLOCK") then
		CharStats_fullvals["MANAREGSPI"] = CharStats_fullvals["SPI"] / 5 + 15;
	end

	-- Do not display defense if it is 300(60*5)
	if( CharStats_fullvals["DEFENSE"] == 300) then
		CharStats_fullvals["DEFENSE"] = 0;
	end

	if( CharStats_fullvals["DMGUNDEAD"] ) then
		if( CharStats_fullvals["DMG"] ) then
			CharStats_fullvals["DMGUNDEAD"] = CharStats_fullvals["DMGUNDEAD"] + CharStats_fullvals["DMG"];
		end
	end
	-- Do not want to show the Heal/Damage value
	CharStats_fullvals["HEAL"] = 0;
	CharStats_fullvals["DMG"] = 0;
end
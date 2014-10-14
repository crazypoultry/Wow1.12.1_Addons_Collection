local StatCompare_StatMods = {
	["STR"] = 1.0,
	["AGI"] = 1.0,
	["STA"] = 1.0,
	["INT"] = 1.0,
	["SPI"] = 1.0,
	["ARMOR"] = 0.10,
	["ENARMOR"] = 0.10,

	["ARCANERES"] = 1.0,
	["FIRERES"] = 1.0,
	["NATURERES"] = 1.0,
	["FROSTRES"] = 1.0,
	["SHADOWRES"] = 1.0,
	["DETARRES"] = 1.0,
	["ALLRES"] = 2.5,

	["DEFENSE"] = 1.5,

	["ATTACKPOWER"] = 0.50,
	["ATTACKPOWERUNDEAD"] = 0.30,
	["CRIT"] =14,
	["BLOCK"] = 0.47,
	["TOBLOCK"] = 5.0,
	["DODGE"] = 12,
	["PARRY"] = 20,
	["TOHIT"] = 9.5,
	["RANGEDATTACKPOWER"] = 0.40,

	["DMG"] = 0.85,
	["DMGUNDEAD"] = 0.55,
	["HEAL"] = 0.45,
	["DETARRES"] = 0.90,
	["SPELLCRIT"] = 14,
	["SPELLTOHIT"] = 10,
	["ARCANEDMG"] = 0.70,
	["FIREDMG"] = 0.70,
	["FROSTDMG"] = 0.70,
	["HOLYDMG"] = 0.92,
	["NATUREDMG"] = 0.70,
	["SHADOWDMG"] = 0.70,

	["MANAREG"] = 2.4,
	["HEALTHREG"] = 2.4,
};

function StatCompare_ItemValue(item, bonus)
	local quality = item.quality;
	local ItemValue = 0;

	for i,e in STATCOMPARE_EFFECTS do
		if(bonus[e.effect] and StatCompare_StatMods[e.effect]) then
			ItemValue = ItemValue + tonumber(bonus[e.effect]) * tonumber(StatCompare_StatMods[e.effect]);
		end
	end

	if(ItemValue == 0) then
		return nil;
	end
	if(quality == 2) then
		ItemValue = ItemValue / 0.50 + 4.00;
	elseif(quality == 3) then
		ItemValue = ItemValue / 0.62 + 1.84;
	elseif(quality == 4) then
		ItemValue = ItemValue / 0.78 + 1.30;
	else
		return nil;
	end

	return ItemValue;
end
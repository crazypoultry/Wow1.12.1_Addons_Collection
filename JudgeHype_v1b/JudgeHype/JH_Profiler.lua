-- Pour le bon fonctionnement de l'addon, merci de ne pas modifier le code
-- Sharas, le 30 mai 2006 - http://worldofwarcraft.judgehype.com

JHP_Version = 2;

function JHP_Init()
	if (JH_Main.Profiler == 1) then
		JHP_MainFrame:Show();
	else
		JHP_MainFrame:Hide();
	end
	JH_ProfilerTooltip:SetOwner(UIParent, "ANCHOR_NONE");
end

function JHP_ButtonClick(num)
	JHprofiler_doprofil(num);
end

JHP_Stuff = {
  "HeadSlot",
  "NeckSlot",
  "ShoulderSlot",
  "ShirtSlot",
  "ChestSlot",
  "WaistSlot",
  "LegsSlot",
  "FeetSlot",
  "WristSlot",
  "HandsSlot",
  "Finger0Slot",
  "Finger1Slot",
  "Trinket0Slot",
  "Trinket1Slot",
  "BackSlot",
  "MainHandSlot",
  "SecondaryHandSlot",
  "RangedSlot",
  "TabardSlot",
};

------------------------------------------------------------------------------------------------------
-- Demarrage de capture des informations du personnage
------------------------------------------------------------------------------------------------------

function JHprofiler_doprofil(num)

	if not (GetLocale()=="frFR" or GetLocale()=="enGB" or GetLocale()=="enUS") then
		DEFAULT_CHAT_FRAME:AddMessage("|cffffff00Addon JudgeHype|r : Le Profiler ne supporte que les versions FR-EN-US.");
		return;
	end
	
	local doprofil = 0;
	local numprofil = num;
	if (numprofil == "") then numprofil = "1"; end
	
	if (numprofil == "1") then doprofil = 1; end
	if (numprofil == "2") then doprofil = 1; end
	if (numprofil == "3") then doprofil = 1; end
	if (numprofil == "4") then doprofil = 1; end
	if (numprofil == "5") then doprofil = 1; end
	
	if (doprofil == 0) then
		DEFAULT_CHAT_FRAME:AddMessage("|cffffff00Addon JudgeHype|r : La commande est /jhprofil ou /jhprofil 1 a 5.");
		return;
	end
	
	local JHname = JHP_CleanIt(UnitName("player"));
	if (JHname == nil or JHname == "" or JHname == "Entit\195\169 Inconnue" or not GetCVar("realmName")) then
		DEFAULT_CHAT_FRAME:AddMessage("|cffffff00Addon JudgeHype|r : Sauvegarde impossible, probl\195\168me de syncronisation serveur.");
		return;
	end
	
	if (UnitIsGhost("player")) then
		DEFAULT_CHAT_FRAME:AddMessage("|cffffff00Addon JudgeHype|r : Sauvegarde impossible, vous \195\170tes mort.");
		return;
	end
	
	if (UnitBuff("player", 1) or UnitDebuff("player",1)) then
		DEFAULT_CHAT_FRAME:AddMessage("|cffffff00Addon JudgeHype|r : Veuillez enlever tous les buffs ou debuffs de votre personnage.");
		return;
	end
	
	if (UnitClass("player") == "Warrior" or UnitClass("player") == "Guerrier" ) then
		local _, _, Stanceactive = GetShapeshiftFormInfo(1);
		if (Stanceactive ~= 1) then
			DEFAULT_CHAT_FRAME:AddMessage("|cffffff00Addon JudgeHype|r : Veuillez utiliser la posture de combat.");
			return;
		end
	end

	local JHname = JHP_CleanIt(JHname);
	local JHrealm = JHP_CleanIt(GetCVar("realmName"));
	local Arbo = "newprofil";
	local Pos = 0;
	local NumEntry = getn(JH_Profiler);

	for i=1, NumEntry, 1 do
		local CompareNom = JH_Profiler[i][Arbo]["common"]["nom"];
		local CompareRoyaume = JH_Profiler[i][Arbo]["common"]["royaume"];
		local CompareProfil = JH_Profiler[i][Arbo]["common"]["numprofil"];
		if (JHname == CompareNom and JHrealm == CompareRoyaume and numprofil == CompareProfil) then
			Pos = i;
		end
	end
	if (Pos == 0) then
		Pos = NumEntry+1;
		table.insert(JH_Profiler, Pos);
	end
	
	-- On cree l'arborescence
	JH_Profiler[Pos] = {};
	JH_Profiler[Pos][Arbo] = {};
	
	-- Gestion des informations de base
	JH_Profiler[Pos][Arbo]["common"] = {};
	
	local sexe = "";
	if (UnitSex("player") == 0) then
		sexe = "Homme";
	else
		sexe = "Femme";
	end
	
	local guildName, _, _ = GetGuildInfo("player");
	if (not guildName) then guildName = ""; end
	local CurrentDate = date("%d/%m/%y %H:%M:%S");
	
	JH_Profiler[Pos][Arbo]["common"]["showing"] = "|cffffffff"..JHname.."|r - "..JHrealm.." : Profil |cffffffff"..numprofil.."|r sauvegard\195\169 le "..CurrentDate;
	JH_Profiler[Pos][Arbo]["common"]["lastsave"] = CurrentDate;
	JH_Profiler[Pos][Arbo]["common"]["jhprofilerversion"] = JHP_Version;
	JH_Profiler[Pos][Arbo]["common"]["numprofil"] = numprofil;
	JH_Profiler[Pos][Arbo]["common"]["nom"] = JHname;
	JH_Profiler[Pos][Arbo]["common"]["royaume"] = JHrealm;
	JH_Profiler[Pos][Arbo]["common"]["langue"] = GetLocale();
	JH_Profiler[Pos][Arbo]["common"]["race"] = JHP_CleanIt(UnitRace("player"));
	JH_Profiler[Pos][Arbo]["common"]["laclasse"] = JHP_CleanIt(UnitClass("player"));
	JH_Profiler[Pos][Arbo]["common"]["level"] = UnitLevel("player");
	JH_Profiler[Pos][Arbo]["common"]["sexe"] = sexe;
	JH_Profiler[Pos][Arbo]["common"]["guilde"] = JHP_CleanIt(guildName);

	-- Gestion des stats
	JH_Profiler[Pos][Arbo]["stats"] = {};
	
	JH_Profiler[Pos][Arbo]["stats"]["vie"] = UnitHealthMax("player");
	JH_Profiler[Pos][Arbo]["stats"]["mana"] = UnitManaMax("player");
	JH_Profiler[Pos][Arbo]["stats"]["defense"] = UnitDefense("player");
	
	JH_Profiler[Pos][Arbo]["stats"]["dodge"] = GetDodgeChance("player");
	JH_Profiler[Pos][Arbo]["stats"]["parry"] = GetParryChance("player");
	JH_Profiler[Pos][Arbo]["stats"]["block"] = GetBlockChance("player");
	
	local base, effectiveArmor, armor, posBuff, negBuff = UnitArmor("player");
	JH_Profiler[Pos][Arbo]["stats"]["armure"] = effectiveArmor..":"..base..":"..posBuff;
	
	local base, resistance, positive, negative = UnitResistance("player", 2);
	JH_Profiler[Pos][Arbo]["stats"]["resistfire"] = resistance;
	local _,resistance,_,_ = UnitResistance("player", 3);
	JH_Profiler[Pos][Arbo]["stats"]["resistnature"] = resistance;
	local _,resistance,_,_ = UnitResistance("player", 4);
	JH_Profiler[Pos][Arbo]["stats"]["resistfrost"] = resistance;
	local _,resistance,_,_ = UnitResistance("player", 5);
	JH_Profiler[Pos][Arbo]["stats"]["resistshadow"] = resistance;
	local _,resistance,_,_ = UnitResistance("player", 6);
	JH_Profiler[Pos][Arbo]["stats"]["resistarcane"] = resistance;
	
	local base, stat, posBuff, negBuff = UnitStat("player", 1);
	JH_Profiler[Pos][Arbo]["stats"]["force"] = base..":"..(base-posBuff-negBuff)..":"..posBuff..":"..negBuff;
	local base, stat, posBuff, negBuff = UnitStat("player", 2);
	JH_Profiler[Pos][Arbo]["stats"]["agilite"] = base..":"..(base-posBuff-negBuff)..":"..posBuff..":"..negBuff;
	local base, stat, posBuff, negBuff = UnitStat("player", 3);
	JH_Profiler[Pos][Arbo]["stats"]["stamina"] = base..":"..(base-posBuff-negBuff)..":"..posBuff..":"..negBuff;
	local base, stat, posBuff, negBuff = UnitStat("player", 4);
	JH_Profiler[Pos][Arbo]["stats"]["intelligence"] = base..":"..(base-posBuff-negBuff)..":"..posBuff..":"..negBuff;
	local base, stat, posBuff, negBuff = UnitStat("player", 5);
	JH_Profiler[Pos][Arbo]["stats"]["spirit"] = base..":"..(base-posBuff-negBuff)..":"..posBuff..":"..negBuff;

	-- Thanks to CharacterProfiler for Crit Percent
	local spellIndex = 1;
	local spellName, subSpellName = GetSpellName(spellIndex,BOOKTYPE_SPELL);
	local tmpStr = nil;
	while spellName do
		if (spellName == "Attack" or spellName == "Attaque") then
			JH_ProfilerTooltip:SetOwner(UIParent, "ANCHOR_NONE");
			JH_ProfilerTooltip:SetSpell(spellIndex, BOOKTYPE_SPELL);
			local ttText=JH_ProfilerTooltipTextLeft2:GetText();
			JH_Profiler[Pos][Arbo]["stats"]["critical"] = JHP_CleanIt(ttText);
			for idx=1,JH_ProfilerTooltip:NumLines() do
				getglobal("JH_ProfilerTooltipTextLeft"..idx):SetText("");
				getglobal("JH_ProfilerTooltipTextRight"..idx):SetText("");
			end
		end
		spellIndex = spellIndex + 1;
		spellName,subSpellName = nil;
		spellName,subSpellName = GetSpellName(spellIndex,BOOKTYPE_SPELL);
	end

	-- Gestion attaque
	JH_Profiler[Pos][Arbo]["attaque"] = {};
	
	local meleeattack = UnitAttackBothHands("player");
	local APbase, APposBuff, APnegBuff = UnitAttackPower("player");
	local meleeattackpower = APbase+APposBuff+APnegBuff;
	local meleeminDamage, meleemaxDamage, offlowDmg, offhiDmg = UnitDamage("player");
	local mainSpeed, offSpeed = UnitAttackSpeed("player");

	if (offlowDmg == nil) then
		offSpeed=0;
	end
	if (offhiDmg == nil) then
		offSpeed=0;
	end
	if (mainSpeed == nil) then
		mainSpeed=0;
	end
	if (offSpeed == nil) then
		offSpeed=0;
	end
	
	if (meleeattack == 0) then
		meleeattack = 0;
		meleeattackpower = 0;
		meleeminDamage = 0;
		meleemaxDamage = 0;
	end
	
	JH_Profiler[Pos][Arbo]["attaque"]["meleeattack"] = meleeattack;
	JH_Profiler[Pos][Arbo]["attaque"]["meleeattackpower"] = meleeattackpower;
	JH_Profiler[Pos][Arbo]["attaque"]["meleemindamage"] = floor(meleeminDamage);
	JH_Profiler[Pos][Arbo]["attaque"]["meleemaxdamage"] = ceil(meleemaxDamage);
	JH_Profiler[Pos][Arbo]["attaque"]["meleeoffmindamage"] = floor(offlowDmg);
	JH_Profiler[Pos][Arbo]["attaque"]["meleeoffmaxdamage"] = ceil(offhiDmg);
	JH_Profiler[Pos][Arbo]["attaque"]["meleespeedmain"] = mainSpeed;
	JH_Profiler[Pos][Arbo]["attaque"]["meleespeedoff"] = offSpeed;
	
	local rangeattack = UnitRangedAttack("player");
	local APRbase, APRposBuff, APRnegBuff = UnitRangedAttackPower("player");
	local rangeattackpower = APRbase+APRposBuff+APRnegBuff;
	local speed, lowDmg, hiDmg = UnitRangedDamage("player");
	
	if (rangeattack == 0) then
		rangeattack = 0;
		rangeattackpower = 0;
		rangespeed = 0;
		rangelowdmg = 0;
		rangehidmg = 0;
	end
	
	JH_Profiler[Pos][Arbo]["attaque"]["rangeattack"] = rangeattack;
	JH_Profiler[Pos][Arbo]["attaque"]["rangeattackpower"] = rangeattackpower;
	JH_Profiler[Pos][Arbo]["attaque"]["rangespeed"] = speed;
	JH_Profiler[Pos][Arbo]["attaque"]["rangelowdmg"] = floor(lowDmg);
	JH_Profiler[Pos][Arbo]["attaque"]["rangehidmg"] = ceil(hiDmg);
	

	-- Gestion equipement
	JH_Profiler[Pos][Arbo]["stuff"] = {};
	
	for index,stuff in JHP_Stuff do
		local lien = GetInventoryItemLink("player", index);
		local texture = GetInventoryItemTexture("player", index);
		if(lien) then
			for color, item, id, subid, name in string.gfind(lien, "|c(%x+)|Hitem:((%d+):%d+:(%d+):%d+)|h%[(.-)%]|h|r") do
				if( color ~= nil and item ~= nil and name ~= nil ) then
					JH_Profiler[Pos][Arbo]["stuff"][stuff] = { };
					JH_Profiler[Pos][Arbo]["stuff"][stuff]["id"] = id..":"..subid;
					JH_Profiler[Pos][Arbo]["stuff"][stuff]["couleur"] = color;
					texture = string.sub(texture, 17);
					JH_Profiler[Pos][Arbo]["stuff"][stuff]["texture"] = texture;
					JH_ProfilerTooltip:SetOwner(UIParent, "ANCHOR_NONE");
					JH_ProfilerTooltip:SetHyperlink("item:"..item);
					JH_Profiler[Pos][Arbo]["stuff"][stuff]["description"] = JHP_StrTooltip();
				end
			end
		end		  
	end

	-- Gestion des skills
	JH_Profiler[Pos][Arbo]["skills"] = {};
	
	local currentheader = "";
	local ligne = 1;
	for i=1, GetNumSkillLines(), 1 do
		local _, isHeader, _, _, _, _, _, _, _, _, _, _ = GetSkillLineInfo(i);
		if (isHeader == 1) then ExpandSkillHeader(0); end
	end
	local currentheader = "";
	for i=1, GetNumSkillLines(), 1 do
		local skillName, header, _, skillRank, _, skillModifier, skillMaxRank, _, _, _, _, _ = GetSkillLineInfo(i);
		if (header == 1) then
			currentheader = JHP_CleanIt(skillName);
		else
			JH_Profiler[Pos][Arbo]["skills"][ligne] = currentheader.."::"..JH_CleanIt(skillName).."::"..skillRank.."::"..skillMaxRank.."::"..skillModifier;
			ligne = ligne+1;
		end
	end

	-- Gestion des factions
	JH_Profiler[Pos][Arbo]["factions"] = {};
	
	local currentheader = "";
	local ligne = 1;
	for i=1, GetNumFactions(), 1 do
		local _, _, _, _, _, _, _, _, isHeader, _, _ = GetFactionInfo(i);
		if (isHeader == 1) then ExpandFactionHeader(0); end
	end
	local currentheader = "";
	for i=1, GetNumFactions(), 1 do
		local name, _, _, bottomValue, topValue, earnedValue, _, _, isHeader, _, _ = GetFactionInfo(i);

		if (isHeader == 1) then
			currentheader = JHP_CleanIt(name);
		else
			JH_Profiler[Pos][Arbo]["factions"][ligne] = currentheader.."::"..JHP_CleanIt(name).."::"..bottomValue.."::"..topValue.."::"..earnedValue;
			ligne = ligne+1;
		end
	end

	-- Gestion des talents
	JH_Profiler[Pos][Arbo]["talents"] = {};
	
	local numTalents;
	local numTabs = GetNumTalentTabs();
	for t=1, numTabs do
		numTalents = GetNumTalents(t);
		local tabname, texture, points, fileName = GetTalentTabInfo(t);
		local talentstring = "";
		for i=1, numTalents do
			local nameTalent, icon, iconx, icony, currRank, maxRank= GetTalentInfo(t,i);
			if ( talentstring == "" ) then
				talentstring = JHP_CleanIt(tabname).."||"..currRank..":"..maxRank;
			else
				talentstring = talentstring.."|"..currRank..":"..maxRank;
			end
		end
		JH_Profiler[Pos][Arbo]["talents"][t] = talentstring;
	end

	-- Gestion PvP
	JH_Profiler[Pos][Arbo]["pvp"] = {};
	
	local hklife, dklife, highestRank = GetPVPLifetimeStats("player");
	local hk, dk, contribution, rank = GetPVPLastWeekStats("player");
	local rankNumber = UnitPVPRank("player");
	local RankName, RankNumber = GetPVPRankInfo(rankNumber);
	local highestRankName, highestRankNumber = GetPVPRankInfo(highestRank);
	JH_Profiler[Pos][Arbo]["pvp"]["titreniveau"] = RankNumber;
	JH_Profiler[Pos][Arbo]["pvp"]["titreniveauvie"] = highestRankNumber;
	JH_Profiler[Pos][Arbo]["pvp"]["hklife"] = hklife;
	JH_Profiler[Pos][Arbo]["pvp"]["dklife"] = dklife;
	JH_Profiler[Pos][Arbo]["pvp"]["hk"] = hk;
	JH_Profiler[Pos][Arbo]["pvp"]["dk"] = dk;
	JH_Profiler[Pos][Arbo]["pvp"]["contribution"] = contribution;
	JH_Profiler[Pos][Arbo]["pvp"]["position"] = rank;
	
	DEFAULT_CHAT_FRAME:AddMessage("|cffffff00Addon JudgeHype|r : Sauvegarde du profil "..numprofil.." de "..UnitName("player").." effectu\195\169e.");
	
	table.sort(JH_Profiler, function(x, y)
		return x.newprofil.common.showing < y.newprofil.common.showing
	end)
	JHO_ProfilerList();
end

------------------------------------------------------------------------------------------------------
-- Fonctions globales >
------------------------------------------------------------------------------------------------------

function JHP_CleanIt(toclean)
	if ( toclean == nil ) then
		toclean = "";
		return toclean;
	else
		return string.gsub(string.gsub(string.gsub(toclean, "\n", ""), "\r", ""),"\"","dbquote");
	end
end

function JHP_CleanItem(toclean)
	if ( toclean == nil ) then
		toclean = "";
		return toclean;
	else
		return string.gsub(string.gsub(string.gsub(toclean, "\n", ""), "\r", ""),"\"","dbquote");
	end
end

function JHP_StrTooltip()
	local JHttdone = {};
	for idx=1,JH_ProfilerTooltip:NumLines() do
		local JHtextLeft = nil;
		local JHtextRight = nil;
		local JHtoadd = nil;
		JHtextLeft = getglobal("JH_ProfilerTooltipTextLeft"..idx);
		JHtextRight = getglobal("JH_ProfilerTooltipTextRight"..idx);
		if (JHtextLeft:GetText()) then
			local JHtextL = JHtextLeft:GetText();
			JHtextL = JHP_CleanItem(JHtextL);
			JHtoadd = JHtextL;
		end
		if (JHtextRight:GetText()) then
			local JHtextR = JHtextRight:GetText();
			JHtextR = JHP_CleanItem(JHtextR);
			JHtoadd = JHtoadd.."---"..JHtextR;
		end
		if ( JHtoadd ) then
			table.insert(JHttdone,JHtoadd);
		end
	end
	for idx=1,JH_ProfilerTooltip:NumLines() do
		getglobal("JH_ProfilerTooltipTextLeft"..idx):SetText("");
		getglobal("JH_ProfilerTooltipTextRight"..idx):SetText("");
	end
	-- JH_ProfilerTooltip:ClearLines();
	return table.concat(JHttdone,"|n|");
end

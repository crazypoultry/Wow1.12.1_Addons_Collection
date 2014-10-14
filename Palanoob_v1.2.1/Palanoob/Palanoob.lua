if not Palanoob_Params then
	Palanoob_Params = {};
end

if not Palanoob_Horiz then
	Palanoob_Horiz = 0;
end

PALANOOB_CLASSES = {};
PALANOOB_CLASSES[1] = PALANOOB_CLASS_HUNTER;
PALANOOB_CLASSES[2] = PALANOOB_CLASS_WARLOCK;
PALANOOB_CLASSES[3] = PALANOOB_CLASS_DRUID;
PALANOOB_CLASSES[4] = PALANOOB_CLASS_WARRIOR;
PALANOOB_CLASSES[5] = PALANOOB_CLASS_MAGE;
PALANOOB_CLASSES[6] = PALANOOB_CLASS_PALADIN;
PALANOOB_CLASSES[7] = PALANOOB_CLASS_PRIEST;
PALANOOB_CLASSES[8] = PALANOOB_CLASS_ROGUE;

ENGLISH_CLASSES = {};
ENGLISH_CLASSES[1] = "HUNTER";
ENGLISH_CLASSES[2] = "WARLOCK";
ENGLISH_CLASSES[3] = "DRUID";
ENGLISH_CLASSES[4] = "WARRIOR";
ENGLISH_CLASSES[5] = "MAGE";
ENGLISH_CLASSES[6] = "PALADIN";
ENGLISH_CLASSES[7] = "PRIEST";
ENGLISH_CLASSES[8] = "ROGUE";

PALANOOB_CLASS_ICONS = {};
PALANOOB_CLASS_ICONS[1] = "Interface\\AddOns\\Palanoob\\Icons\\Hunter";
PALANOOB_CLASS_ICONS[2] = "Interface\\AddOns\\Palanoob\\Icons\\Warlock";
PALANOOB_CLASS_ICONS[3] = "Interface\\AddOns\\Palanoob\\Icons\\Druid";
PALANOOB_CLASS_ICONS[4] = "Interface\\AddOns\\Palanoob\\Icons\\Warrior";
PALANOOB_CLASS_ICONS[5] = "Interface\\AddOns\\Palanoob\\Icons\\Mage";
PALANOOB_CLASS_ICONS[6] = "Interface\\AddOns\\Palanoob\\Icons\\Paladin";
PALANOOB_CLASS_ICONS[7] = "Interface\\AddOns\\Palanoob\\Icons\\Priest";
PALANOOB_CLASS_ICONS[8] = "Interface\\AddOns\\Palanoob\\Icons\\Rogue";

PALANOOB_CLASS_TIMERS = {};
PALANOOB_CLASS_TIMERS[1] = 0;
PALANOOB_CLASS_TIMERS[2] = 0;
PALANOOB_CLASS_TIMERS[3] = 0;
PALANOOB_CLASS_TIMERS[4] = 0;
PALANOOB_CLASS_TIMERS[5] = 0;
PALANOOB_CLASS_TIMERS[6] = 0;
PALANOOB_CLASS_TIMERS[7] = 0;
PALANOOB_CLASS_TIMERS[8] = 0;

PALANOOB_CLASS_TIME_ELAPSED = {};
PALANOOB_CLASS_TIME_ELAPSED[1] = 0;
PALANOOB_CLASS_TIME_ELAPSED[2] = 0;
PALANOOB_CLASS_TIME_ELAPSED[3] = 0;
PALANOOB_CLASS_TIME_ELAPSED[4] = 0;
PALANOOB_CLASS_TIME_ELAPSED[5] = 0;
PALANOOB_CLASS_TIME_ELAPSED[6] = 0;
PALANOOB_CLASS_TIME_ELAPSED[7] = 0;
PALANOOB_CLASS_TIME_ELAPSED[8] = 0;

PALANOOB_SPELLS = {};
PALANOOB_SPELLS[1] = PALANOOB_SPELL_SALVATION;
PALANOOB_SPELLS[2] = PALANOOB_SPELL_WISDOM;
PALANOOB_SPELLS[3] = PALANOOB_SPELL_LIGHT;
PALANOOB_SPELLS[4] = PALANOOB_SPELL_MIGHT;
PALANOOB_SPELLS[5] = PALANOOB_SPELL_KINGS;
PALANOOB_SPELLS[6] = PALANOOB_SPELL_SANCTUARY;

PALANOOB_SPELL_ICONS = {};
PALANOOB_SPELL_ICONS[1] = "Interface\\Icons\\Spell_Holy_GreaterBlessingofSalvation";
PALANOOB_SPELL_ICONS[2] = "Interface\\Icons\\Spell_Holy_GreaterBlessingofWisdom";
PALANOOB_SPELL_ICONS[3] = "Interface\\Icons\\Spell_Holy_GreaterBlessingofLight";
PALANOOB_SPELL_ICONS[4] = "Interface\\Icons\\Spell_Holy_GreaterBlessingofKings";
PALANOOB_SPELL_ICONS[5] = "Interface\\Icons\\Spell_Magic_GreaterBlessingofKings";
PALANOOB_SPELL_ICONS[6] = "Interface\\Icons\\Spell_Holy_GreaterBlessingofSanctuary";

PALANOOB_CHANGED_SPELL = 1;

function Palanoob_OnLoad()
	if ( DEFAULT_CHAT_FRAME ) then 
		DEFAULT_CHAT_FRAME:AddMessage("Palanoob v1.2 " .. PALANOOB_MISC_LAUNCHED .. ".", 1.0, 0.5, 0.5);
	end

	if not SlashCmdList["PALANOOB"] then
		SlashCmdList["PALANOOB"] = Palanoob_OnOff;
		SLASH_PALANOOB1 = "/palanoob";
	end
	
	if not SlashCmdList["PALANOOBRESET"] then
		SlashCmdList["PALANOOBRESET"] = Palanoob_Reset;
		SLASH_PALANOOBRESET1 = "/palanoobreset";
	end

	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("BAG_UPDATE");
	this:RegisterEvent("UNIT_INVENTORY_CHANGED");
	PalanoobMoveButton:RegisterForDrag("RightButton");
	PalanoobSpell1:RegisterForClicks("LeftButtonDown", "RightButtonDown");
	PalanoobSpell2:RegisterForClicks("LeftButtonDown", "RightButtonDown");
	PalanoobSpell3:RegisterForClicks("LeftButtonDown", "RightButtonDown");
	PalanoobSpell4:RegisterForClicks("LeftButtonDown", "RightButtonDown");
	PalanoobSpell5:RegisterForClicks("LeftButtonDown", "RightButtonDown");
	PalanoobSpell6:RegisterForClicks("LeftButtonDown", "RightButtonDown");
	PalanoobSpell7:RegisterForClicks("LeftButtonDown", "RightButtonDown");
	PalanoobSpell8:RegisterForClicks("LeftButtonDown", "RightButtonDown");
end

function Palanoob_ClassClick()
	if (PalanoobChangeFrame:IsVisible()) then
		PalanoobChangeFrame:Hide();
	end
	Palanoob_ClassID = this:GetID();
	isOK = 0;
	if (UnitExists("raid1")) then
		for i=0,MAX_RAID_MEMBERS do
			if (i == 0) then
				tmpU = "player";
			else
				tmpU = "raid" .. i;
			end
			if (UnitExists(tmpU)) then
				_, tmpCls = UnitClass(tmpU);
				if (tmpCls == ENGLISH_CLASSES[Palanoob_ClassID]) then
					if (Palanoob_CastBuff(Palanoob_ClassID, tmpU)) then
						isOK = 1;
						break;
					end
				end
			end
		end
	elseif (UnitExists("party1")) then
		for i=0,4 do
			if (i == 0) then
				tmpU = "player";
			else
				tmpU = "party" .. i;
			end
			if (UnitExists(tmpU)) then
				_, tmpCls = UnitClass(tmpU);
				if (tmpCls == ENGLISH_CLASSES[Palanoob_ClassID]) then
					if (Palanoob_CastBuff(Palanoob_ClassID, tmpU)) then
						isOK = 1;
						break;
					end
				end
			end
		end
	end
	if (isOK == 0) then
		UIErrorsFrame:AddMessage(PALANOOB_MISC_NOTARGET .. " " .. PALANOOB_SPELLS[Palanoob_Params[Palanoob_ClassID]] .. ".", 1.0, 0.0, 0.0, 1.0, UIERRORS_HOLD_TIME);
	end
end

function Palanoob_CastBuff(arg1, arg2)
	local oldTarget = UnitExists("target");
	local isOK = 0;
	ClearTarget();
	CastSpellByName(PALANOOB_SPELLS[Palanoob_Params[arg1]]);
	if (SpellCanTargetUnit(arg2)) then
		SpellTargetUnit(arg2);
		Palanoob_StartTimer(arg1);
		isOK = 1;
		Palanoob_Items();
	else
		SpellStopTargeting();
	end
	if (oldTarget) then
		TargetLastTarget();
	else
		ClearTarget();
	end
	if (isOK) then
		return true;
	end
	return false;
end

function Palanoob_StartTimer(whatClass)
	PALANOOB_CLASS_TIMERS[whatClass] = 15 * 60;
	getglobal("PalanoobClass" .. whatClass .. "Counter"):SetTextColor(0.1, 1.0, 0.1);
	getglobal("PalanoobClass" .. whatClass .. "Counter"):Show();
end

function Palanoob_ClassUpdate(arg1)
	whatClass = this:GetID();
	if (PALANOOB_CLASS_TIMERS[whatClass] > 0) then
		PALANOOB_CLASS_TIME_ELAPSED[whatClass] = PALANOOB_CLASS_TIME_ELAPSED[whatClass] + arg1;
		if (PALANOOB_CLASS_TIME_ELAPSED[whatClass] > 1.0) then
			PALANOOB_CLASS_TIMERS[whatClass] = PALANOOB_CLASS_TIMERS[whatClass] - PALANOOB_CLASS_TIME_ELAPSED[whatClass];
			
			tmpMin = floor(PALANOOB_CLASS_TIMERS[whatClass] / 60);
			if (strlen(tmpMin) < 2) then
				tmpMin = "0" .. tmpMin;
			end
			tmpSec = mod(floor(PALANOOB_CLASS_TIMERS[whatClass]), 60);
			if (strlen(tmpSec) < 2) then
				tmpSec = "0" .. tmpSec;
			end
			
			if (PALANOOB_CLASS_TIMERS[whatClass] < 60) then
				getglobal("PalanoobClass" .. whatClass .. "Counter"):SetTextColor(1.0, 0.1, 0.1);
			end
			getglobal("PalanoobClass" .. whatClass .. "Counter"):SetText(tmpMin .. ":" .. tmpSec);
			PALANOOB_CLASS_TIME_ELAPSED[whatClass] = 0;
		end
	else
		getglobal("PalanoobClass" .. whatClass .. "Counter"):Hide();
	end
end

function Palanoob_ClassTooltip()
	GameTooltip_SetDefaultAnchor(GameTooltip, UIParent);
	Palanoob_ClassID = this:GetID();
	GameTooltip:SetText(PALANOOB_CLASSES[Palanoob_ClassID] .. "|n" .. PALANOOB_MISC_CLICKTOBUFF);
end

function Palanoob_SpellClick()
	if (PalanoobChangeFrame:IsVisible()) then
		PalanoobChangeFrame:Hide();
	end
	Palanoob_SpellID = this:GetID();
	if (arg1 == "LeftButton") then
		if (Palanoob_Params[Palanoob_SpellID]) then
			tmpN = Palanoob_Params[Palanoob_SpellID];
			newN = mod(tmpN, getn(PALANOOB_SPELLS)) + 1;
		else
			newN = 1;
		end
		Palanoob_Params[Palanoob_SpellID] = newN;
		tempTex = getglobal("PalanoobSpell" .. Palanoob_SpellID .. "Texture");
		tempTex:SetTexture(PALANOOB_SPELL_ICONS[newN]);
		Palanoob_SpellTooltip();
	elseif (arg1 == "RightButton") then
		PALANOOB_CHANGED_SPELL = Palanoob_SpellID;
		tmpRelatSpell = getglobal("PalanoobSpell" .. Palanoob_SpellID);
		PalanoobChangeFrame:ClearAllPoints();
		PalanoobChangeFrame:SetPoint("TOPLEFT", tmpRelatSpell, "TOPLEFT", 0, 0);
		PalanoobChangeFrame:Show();
	end
end

function Palanoob_SpellTooltip()
	GameTooltip_SetDefaultAnchor(GameTooltip, UIParent);
	Palanoob_SpellID = this:GetID();
	tmpTooltiptext = PALANOOB_SPELLS[Palanoob_Params[Palanoob_SpellID]] .. "|n";
	
	classPlayersTotal = 0;
	classPlayersActive = 0;
	classPlayersBuffed = 0;
	tmpInGroupRaid = 0;
	
	if (UnitExists("raid1")) then
		tmpInGroupRaid = 1;
		for i=1,MAX_RAID_MEMBERS do
			tmpU = "raid" .. i;
			if (UnitExists(tmpU)) then
				_, tmpClass = UnitClass(tmpU);
				if (tmpClass == ENGLISH_CLASSES[Palanoob_SpellID]) then
					classPlayersTotal = classPlayersTotal + 1;
					if (not UnitIsDeadOrGhost(tmpU)) then
						if (UnitIsConnected(tmpU)) then
							classPlayersActive = classPlayersActive + 1;
							for j=1,16 do
								tmpBuff = UnitBuff(tmpU, j);
								if (tmpBuff == PALANOOB_SPELL_ICONS[Palanoob_Params[Palanoob_SpellID]]) then
									classPlayersBuffed = classPlayersBuffed + 1;
									break;
								end
							end
						end
					end
				end
			end
		end
	elseif (UnitExists("party1")) then
		tmpInGroupRaid = 1;
		for i=0,4 do
			if (i == 0) then
				tmpU = "player";
			else
				tmpU = "party" .. i;
			end
			if (UnitExists(tmpU)) then
				_, tmpClass = UnitClass(tmpU);
				if (tmpClass == ENGLISH_CLASSES[Palanoob_SpellID]) then
					classPlayersTotal = classPlayersTotal + 1;
					if (not UnitIsDeadOrGhost(tmpU)) then
						if (UnitIsConnected(tmpU)) then
							classPlayersActive = classPlayersActive + 1;
							for j=1,16 do
								tmpBuff = UnitBuff(tmpU, j);
								if (tmpBuff == PALANOOB_SPELL_ICONS[Palanoob_Params[Palanoob_SpellID]]) then
									classPlayersBuffed = classPlayersBuffed + 1;
									break;
								end
							end
						end
					end
				end
			end
		end
	end
	if (tmpInGroupRaid == 1) then
		tmpTooltiptext = tmpTooltiptext .. PALANOOB_MISC_PLAYERSBUFFED .. " : " .. classPlayersBuffed .. " / " .. classPlayersTotal .. " (" .. classPlayersActive .. " " .. PALANOOB_MISC_ACTIVE .. ")";
	else
		tmpTooltiptext = tmpTooltiptext .. PALANOOB_MISC_NOTINGROUPRAID;
	end
	GameTooltip:SetText(tmpTooltiptext);
end

function Palanoob_OnOff()
	if (PalanoobFrame:IsVisible()) then
		PalanoobFrame:Hide();
	else
		PalanoobFrame:Show();
		Palanoob_Items();
	end
end

function Palanoob_MainTooltip()
	GameTooltip_SetDefaultAnchor(GameTooltip, UIParent);
	GameTooltip:SetText(PALANOOB_MISC_MAINTOOLTIP);
end

function Palanoob_Items()
	tmpIN = 0
	for bag = 0,  4 do
		local bagslots = GetContainerNumSlots(bag);
		if (bagslots) then
			for slot = 1, bagslots do
				local link = GetContainerItemLink(bag, slot);
				if (link and string.find(link, PALANOOB_ITEM)) then
					local _, count, locked = GetContainerItemInfo(bag, slot);
					tmpIN = tmpIN + count;
				end
			end
		end
	end
	PalanoobItems:SetText(tmpIN)
end

function Palanoob_Switch()
	if (Palanoob_Horiz == 0) then
		Palanoob_Horiz = 1;
	else
		Palanoob_Horiz = 0;
	end
	Palanoob_Arrange();
end

function Palanoob_Arrange()
	PalanoobFrame:ClearAllPoints();
	PalanoobItems:ClearAllPoints();
	PalanoobMoveButton:ClearAllPoints();

	if (Palanoob_Horiz == 0) then
		PalanoobFrame:SetPoint("RIGHT", UIParent, "RIGHT", -5, 0);
		PalanoobFrame:SetWidth(64);
		PalanoobFrame:SetHeight(256);
		
		PalanoobItems:SetPoint("TOP", PalanoobFrame, "BOTTOM", 0, 0);
		PalanoobMoveButton:SetPoint("BOTTOM", PalanoobFrame, "TOP", 0, -4);
	else
		PalanoobFrame:SetPoint("TOP", UIParent, "TOP", 0, -5);
		PalanoobFrame:SetWidth(256);
		PalanoobFrame:SetHeight(64);
		
		PalanoobMoveButton:SetPoint("RIGHT", PalanoobFrame, "LEFT", 4, 0);
		PalanoobItems:SetPoint("LEFT", PalanoobFrame, "RIGHT", 2, 0);
	end
	
	tmpRelatClass = getglobal("PalanoobFrame");
	tmpRelatSpell = getglobal("PalanoobFrame");
	for i=1,8 do
		tmpClass = getglobal("PalanoobClass" .. i);
		tmpSpell = getglobal("PalanoobSpell" .. i);
		tmpClass:ClearAllPoints();
		tmpSpell:ClearAllPoints();
		if (Palanoob_Horiz == 0) then
			tmpClass:SetPoint("TOPLEFT", tmpRelatClass, "TOPLEFT", 0, 0 - ((i - 1) * 32));
			tmpSpell:SetPoint("TOPLEFT", tmpRelatSpell, "TOPLEFT", 32, 0 - ((i - 1) * 32));
		else
			tmpClass:SetPoint("TOPLEFT", tmpRelatClass, "TOPLEFT", (i - 1) * 32, -32);
			tmpSpell:SetPoint("TOPLEFT", tmpRelatSpell, "TOPLEFT", (i - 1) * 32, 0);
		end
	end
end

function Palanoob_Reset()
	Palanoob_Arrange();
end

function Palanoob_ChangeClassClick()
	Palanoob_SpellID = this:GetID();
	Palanoob_Params[PALANOOB_CHANGED_SPELL] = Palanoob_SpellID;
	tempTex = getglobal("PalanoobSpell" .. PALANOOB_CHANGED_SPELL .. "Texture");
	tempTex:SetTexture(PALANOOB_SPELL_ICONS[Palanoob_SpellID]);
	PalanoobChangeFrame:Hide();
end

function Palanoob_ChangeClassTooltip()
	Palanoob_SpellID = this:GetID();
	GameTooltip_SetDefaultAnchor(GameTooltip, UIParent);
	GameTooltip:SetText(PALANOOB_SPELLS[Palanoob_SpellID]);
end

function Palanoob_OnEvent(event)
	if (event == "VARIABLES_LOADED") then
		Palanoob_Arrange();
		for i = 1,8 do
			tempTex = getglobal("PalanoobClass" .. i .. "Texture");
			tempTex:SetTexture(PALANOOB_CLASS_ICONS[i]);
			
			tempTex = getglobal("PalanoobSpell" .. i .. "Texture");
			tempTex:SetTexture(PALANOOB_SPELL_ICONS[Palanoob_Params[i]]);
			
			if (i <= 6) then
				tempTex = getglobal("PalanoobChangeSpell" .. i .. "Texture");
				tempTex:SetTexture(PALANOOB_SPELL_ICONS[i]);
			end
		end
		Palanoob_Items();
	elseif (event == "BAG_UPDATE" or event == "UNIT_INVENTORY_CHANGED") then
		Palanoob_Items();
	end
end
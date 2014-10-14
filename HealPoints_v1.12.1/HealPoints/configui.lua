
HealPointsConfigUI = { }; -- package
local valueUpdating = 0;

local SPELLLIST = { };
local Spell_Names = { };

local function updateSpellLists()
	local function updateSpellList(objref, funct)
		for i = 1, table.getn(SPELLLIST), 1 do
			local info = {};
			info.text = SPELLLIST[i];
			info.func = funct;
			if (objref and type(objref) == "table") then
				info.owner = objref;
			end
			UIDropDownMenu_AddButton(info)
		end
	end

	SPELLLIST = { };
  for i = 1, table.getn(Spell_Names), 1 do 
    if (HealPointsSpells:getHighestSpellRank(Spell_Names[i]) > 0) then
      table.insert(SPELLLIST, Spell_Names[i]);
    end
  end

	if (HealPoints.db.char.power['spell'] == '') then
		HealPoints.db.char.power['spell'] = SPELLLIST[1];
	end
	if (HealPoints.db.char.endurance['spell'] == '') then
		HealPoints.db.char.endurance['spell'] = SPELLLIST[1];
	end
	
	UIDropDownMenu_Initialize(HealPointsPowerConfigManualSelectSpell,function() 
    updateSpellList(HealPointsPowerConfigManualSelectSpell, HealPointsConfigUI.powerSpellSelected); 
    end);
	UIDropDownMenu_Initialize(HealPointsEnduranceConfigManualSelectSpell,function() 
    updateSpellList(HealPointsEnduranceConfigManualSelectSpell, HealPointsConfigUI.enduranceSpellSelected); 
    end);
end

local function updateRankLists()
	local function updateRankList(objref, maxRank)
		for i = 1, maxRank, 1 do
			local info = {};
			info.text = "Rank "..i;
			info.func = HealPointsConfigUI.spellRankSelected;
			if (objref and type(objref) == "table") then
				info.owner = objref;
			end
			UIDropDownMenu_AddButton(info)
		end
	end

	local powerMax = HealPointsSpells:getHighestSpellRank(HealPoints.db.char.power['spell']);
	UIDropDownMenu_Initialize(HealPointsPowerConfigManualSelectRank,function() updateRankList(HealPointsPowerConfigManualSelectRank, powerMax); end);

	local enduranceMax = HealPointsSpells:getHighestSpellRank(HealPoints.db.char.endurance['spell']);
	UIDropDownMenu_Initialize(HealPointsEnduranceConfigManualSelectRank,function() updateRankList(HealPointsEnduranceConfigManualSelectRank, enduranceMax); end);
end

local function updateGUI() -- Updates GUI to match HEALPOINTS_CONFIG
	valueUpdating = 1;
	-- PowerPoints
	getglobal("HealPointsPowerConfigDuration"):SetValue(HealPoints.db.char.power['duration']);
	getglobal("HealPointsPowerConfigDurationText"):SetText(HealPoints.db.char.power['duration'].." mins");
	if (HealPoints.db.char.power['auto'] == true) then
		getglobal("HealPointsPowerConfigAutoSelect"):SetChecked(1);
		getglobal("HealPointsPowerConfigManualSelect"):SetChecked(0);
	else
		getglobal("HealPointsPowerConfigAutoSelect"):SetChecked(0);
		getglobal("HealPointsPowerConfigManualSelect"):SetChecked(1);
	end
  getglobal("HealPointsPowerConfigMana"):SetValue(HealPoints.db.char.power['mana']);
  getglobal("HealPointsPowerConfigManaText"):SetText(HealPoints.db.char.power['mana'].."%");
	
	-- EndurancePoints
	getglobal("HealPointsEnduranceConfigDuration"):SetValue(HealPoints.db.char.endurance['duration']);
	getglobal("HealPointsEnduranceConfigDurationText"):SetText(HealPoints.db.char.endurance['duration'].." mins");
	if (HealPoints.db.char.endurance['auto'] == true) then
		getglobal("HealPointsEnduranceConfigAutoSelect"):SetChecked(1);
		getglobal("HealPointsEnduranceConfigManualSelect"):SetChecked(0);
	else
		getglobal("HealPointsEnduranceConfigAutoSelect"):SetChecked(0);
		getglobal("HealPointsEnduranceConfigManualSelect"):SetChecked(1);
	end
  getglobal("HealPointsEnduranceConfigMana"):SetValue(HealPoints.db.char.endurance['mana']);
  getglobal("HealPointsEnduranceConfigManaText"):SetText(HealPoints.db.char.endurance['mana'].."%");

	-- SpellLists
	if (UIDropDownMenu_GetSelectedID(HealPointsPowerConfigManualSelectSpell) ~= HealPointsUtil:getTableIndex(SPELLLIST, HealPoints.db.char.power['spell'])) then
		UIDropDownMenu_SetSelectedID(HealPointsPowerConfigManualSelectSpell, HealPointsUtil:getTableIndex(SPELLLIST, HealPoints.db.char.power['spell']));
	end
	if (UIDropDownMenu_GetSelectedID(HealPointsEnduranceConfigManualSelectSpell) ~= HealPointsUtil:getTableIndex(SPELLLIST, HealPoints.db.char.endurance['spell'])) then
		UIDropDownMenu_SetSelectedID(HealPointsEnduranceConfigManualSelectSpell, HealPointsUtil:getTableIndex(SPELLLIST, HealPoints.db.char.endurance['spell']));
	end
	updateRankLists();
	UIDropDownMenu_SetSelectedID(HealPointsPowerConfigManualSelectRank, HealPoints.db.char.power['rank']);
	UIDropDownMenu_SetSelectedID(HealPointsEnduranceConfigManualSelectRank, HealPoints.db.char.endurance['rank']);
	
	-- Heal-over-time
	getglobal("HealPointsHotConfigNumTargets"):SetValue(HealPoints.db.char.hot['numtargets']);
	local _, className = UnitClass("player");
	if (className == "PRIEST" or className == "DRUID") then
		getglobal("HealPointsHotConfigNumTargetsText"):SetText(HealPoints.db.char.hot['numtargets']);
	end
	
	valueUpdating = 0;
end

function HealPointsConfigUI:powerSpellSelected()
	if (this.owner) then
		UIDropDownMenu_SetSelectedID(this.owner, this:GetID());
		HealPoints.db.char.power['spell'] = SPELLLIST[UIDropDownMenu_GetSelectedID(HealPointsPowerConfigManualSelectSpell)];
		updateRankLists();
		HealPoints.db.char.power['rank'] = 1;
		UIDropDownMenu_SetSelectedID(HealPointsPowerConfigManualSelectRank, 1);
    HealPointsCalculator:updateHealPoints();
	end
end

function HealPointsConfigUI:enduranceSpellSelected()
	if (this.owner) then
		UIDropDownMenu_SetSelectedID(this.owner, this:GetID());
		HealPoints.db.char.endurance['spell'] = SPELLLIST[UIDropDownMenu_GetSelectedID(HealPointsEnduranceConfigManualSelectSpell)];
		updateRankLists();
		HealPoints.db.char.endurance['rank'] = 1;
		UIDropDownMenu_SetSelectedID(HealPointsEnduranceConfigManualSelectRank, 1);		
    HealPointsCalculator:updateHealPoints();
	end
end

function HealPointsConfigUI:spellRankSelected()
	if (this.owner) then
		UIDropDownMenu_SetSelectedID(this.owner, this:GetID());
		HealPoints.db.char.power['rank'] = UIDropDownMenu_GetSelectedID(HealPointsPowerConfigManualSelectRank);
		HealPoints.db.char.endurance['rank'] = UIDropDownMenu_GetSelectedID(HealPointsEnduranceConfigManualSelectRank);
    HealPointsCalculator:updateHealPoints();
	end
end

function HealPointsConfigUI:init()
	local _, className = UnitClass("player");
  if (className == "PALADIN") then
    Spell_Names = { HPC_SPELL_FOL, HPC_SPELL_HL };
  elseif (className == "PRIEST") then
    Spell_Names = { HPC_SPELL_FH, HPC_SPELL_LH, HPC_SPELL_HEAL, HPC_SPELL_GH, HPC_SPELL_RENEW };
  elseif (className == "DRUID") then
    Spell_Names = { HPC_SPELL_HT, HPC_SPELL_REJUV, HPC_SPELL_REGR };
  elseif (className == "SHAMAN") then
    Spell_Names = { HPC_SPELL_LHW, HPC_SPELL_HW, HPC_SPELL_CHAIN };
  end  
  HealPointsConfigUI:spellsChanged();
end

function HealPointsConfigUI:update()
	if (valueUpdating == 0) then
		-- PowerPoints
		HealPoints.db.char.power['duration'] = getglobal("HealPointsPowerConfigDuration"):GetValue();
		getglobal("HealPointsPowerConfigDurationText"):SetText(HealPoints.db.char.power['duration'].." mins");
		if (getglobal("HealPointsPowerConfigAutoSelect"):GetChecked() == 1) then
		  HealPoints.db.char.power['auto'] = true;
		else
		  HealPoints.db.char.power['auto'] = false;
		end
    HealPoints.db.char.power['mana'] = getglobal("HealPointsPowerConfigMana"):GetValue();
    getglobal("HealPointsPowerConfigManaText"):SetText(HealPoints.db.char.power['mana'].."%");

		-- EndurancePoints
		HealPoints.db.char.endurance['duration'] = getglobal("HealPointsEnduranceConfigDuration"):GetValue();
		getglobal("HealPointsEnduranceConfigDurationText"):SetText(HealPoints.db.char.endurance['duration'].." mins");
		if (getglobal("HealPointsEnduranceConfigAutoSelect"):GetChecked()) then
		  HealPoints.db.char.endurance['auto'] = true;
		else
		  HealPoints.db.char.endurance['auto'] = false;
		end
    HealPoints.db.char.endurance['mana'] = getglobal("HealPointsEnduranceConfigMana"):GetValue();
    getglobal("HealPointsEnduranceConfigManaText"):SetText(HealPoints.db.char.endurance['mana'].."%");
	
		-- Heal-over-time
		HealPoints.db.char.hot['numtargets'] = getglobal("HealPointsHotConfigNumTargets"):GetValue();	
		local _, className = UnitClass("player");
		if (className == "PRIEST" or className == "DRUID") then
			getglobal("HealPointsHotConfigNumTargetsText"):SetText(HealPoints.db.char.hot['numtargets']);
		end
		
    HealPointsCalculator:updateHealPoints();
	end
end

function HealPointsConfigUI:reset()
  HealPoints:ResetDB('char');
  HealPoints.db.char.power['spell'] = SPELLLIST[1];
	HealPoints.db.char.endurance['spell'] = SPELLLIST[1];
	updateGUI();
	
  HealPointsCalculator:updateHealPoints();
end

function HealPointsConfigUI:spellsChanged()
  updateSpellLists()
  updateGUI();
end

function HealPointsConfigUI:setTooltip()
	GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
	if (this:GetID() == 1) then	-- HoT config
		GameTooltip:SetText("HoT - Number of targets", HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
		GameTooltip:AddLine("Number of targets you try to keep the HoT constantly running on (mana premitting).");
	elseif (this:GetID() == 2) then -- Start mana
		GameTooltip:SetText("Starting mana", HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
		GameTooltip:AddLine("Percentage of mana available at the start of the computation.");
	end
	GameTooltip:Show();
end



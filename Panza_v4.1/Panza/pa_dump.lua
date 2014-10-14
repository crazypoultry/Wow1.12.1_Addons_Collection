--[[

pa_dump.lua
Panza debug dump function
Revision 4.0

10-01-06 "for in pairs()" completed for BC
--]]

----------------------------------------------
-- Dump eveything we can think of into PAState
----------------------------------------------
function PA:Dump()
	-- Temporarily turn off target update code, for speed
	local PA_TargetFrame_Update = TargetFrame_Update;
	TargetFrame_Update = PA_DummyTargetFrame_Update;

	local Status, Err = pcall(PA_Dump_Safe);

	-- Restore target update code
	TargetFrame_Update = PA_TargetFrame_Update;
	PA_TargetFrame_Update = nil;

	if (not Status) then
		PA:DisplayText(PA_RED.."Error in dump protected call: ", Err);
	end
end

function PA_Dump_Safe()
	PAState = {};
	-- Build
	if (GetBuildInfo~=nil) then
		local version, buildnum, builddate = GetBuildInfo();
		PAState["BuildInfo"] = {Version=version, BuildNum=buildnum, BuildDate=builddate};
	end
	-- Time
	PAState["Time"] = GetTime();
	-- Locale
	PAState["Locale"] = GetLocale();
	-- Zone
	PAState["Zone"] = GetRealZoneText();
	-- Realm
	PAState["Realm"] = GetRealmName();
	-- CurrentMapZone
	PAState["CurrentMapZone"] = GetCurrentMapZone();
	-- CurrentMapContinent
	PAState["CurrentMapContinent"] = GetCurrentMapContinent();
	-- IsInInstance
	PAState["IsInInstance"] = IsInInstance();
	-- Player
	PAState["player"] = PA:GetUnitInfo("player");
	-- PlayerPet
	PAState["playerpet"] = PA:GetUnitInfo("playerpet");
	-- Target
	PAState["target"] = PA:GetUnitInfo("target");
	-- TargetPet
	PAState["targetpet"] = PA:GetUnitInfo("targetpet");
	-- TargetTarget
	PAState["targettarget"] = PA:GetUnitInfo("targettarget");
	-- Weapon Enchant
	local hasMainHandEnchant, mainHandExpiration, mainHandCharges, hasOffHandEnchant, offHandExpiration, offHandCharges = GetWeaponEnchantInfo();
	PAState.WeaponEnchant = {hasMainHandEnchant=hasMainHandEnchant, mainHandExpiration=mainHandExpiration, mainHandCharges=mainHandCharges, hasOffHandEnchant=hasOffHandEnchant, offHandExpiration=offHandExpiration, offHandCharges=offHandCharges};
	-- PA
	PAState.PA = PA:CopyTable(PA);
	PAState.PAAll = true;
	-- PACurrentSpells
	PAState.CurrentSpells = PA:CopyTable(PACurrentSpells);

	-- CTRA MainTanks
	if (CT_RA_MainTanks~=nil) then
		PAState.CT_RA_MainTanks = {};
		for Index, MTName in pairs(CT_RA_MainTanks) do
			PAState.CT_RA_MainTanks[Index] = MTName;
		end
	end
	-- RDX MainTanks
	if (RDX~=nil and RDXM.Assists~=nil and RDXM.Assists.cfg~=nil and RDXM.Assists.cfg.mtarray~=nil) then
		PAState.RDX_MainTanks = {};
		for Index, MTName in pairs(RDXM.Assists.cfg.mtarray) do
			PAState.RDX_MainTanks[Index] = MTName;
		end
	end
	-- oRA MainTanks
	if (oRA_MainTank~=nil and oRA_MainTank.MainTankTable~=nil) then
		PAState.oRA_MainTanks = {};
		for Index, MTName in pairs(oRA_MainTank.MainTankTable) do
			PAState.oRA_MainTanks[Index] = MTName;
		end
	end	
	PA:GetMainTankTargetTargets();
	PAState.PA["MT"] = PA:CopyTable(PA.MT);
	PAState.PA["MTTT"] = PA:CopyTable(PA.MTTT);
	for MTName, TInfo in pairs(PA.MT) do
		PAState[string.lower(TInfo.TUnit)] = PA:GetUnitInfo(TInfo.TUnit);
	end
	for MTName, TInfo in pairs(PA.MTTT) do
		PAState[string.lower(TInfo.Unit)] = PA:GetUnitInfo(TInfo.Unit);
	end

	-- Slots
	PAState["Inventory"] = {};
	PAState.Inventory["Slot"] = {};
	PAState.Inventory["ItemLink"] = {};
	PAState.Inventory["ItemCooldown"] = {};
	PA:GetSlotInfo("HeadSlot");
	PA:GetSlotInfo("NeckSlot");
	PA:GetSlotInfo("ShoulderSlot");
	PA:GetSlotInfo("BackSlot");
	PA:GetSlotInfo("ChestSlot");
	PA:GetSlotInfo("ShirtSlot");
	PA:GetSlotInfo("TabardSlot");
	PA:GetSlotInfo("WristSlot");
	PA:GetSlotInfo("HandsSlot");
	PA:GetSlotInfo("WaistSlot");
	PA:GetSlotInfo("LegsSlot");
	PA:GetSlotInfo("FeetSlot");
	PA:GetSlotInfo("Finger0Slot");
	PA:GetSlotInfo("Finger1Slot");
	PA:GetSlotInfo("Trinket0Slot");
	PA:GetSlotInfo("Trinket1Slot");
	PA:GetSlotInfo("MainHandSlot");
	PA:GetSlotInfo("SecondaryHandSlot");
	PA:GetSlotInfo("RangedSlot");
	PA:GetSlotInfo("AmmoSlot");
	PA:GetSlotInfo("Bag0Slot");
	PA:GetSlotInfo("Bag1Slot");
	PA:GetSlotInfo("Bag2Slot");
	PA:GetSlotInfo("Bag3Slot");

	-- SpellTabs
	PAState.SpellTabs = {};
	for i = 1, MAX_SKILLLINE_TABS do
		local Name, Texture, Offset, Count = GetSpellTabInfo(i);
		PAState.SpellTabs[i] = {Name=Name, Texture=Texture, Offset=Offset, Count=Count};
	end
	-- Spells
	PAState.SpellBook = {};
	local i = 1;
	while (true) do
		local spellName, spellRank = GetSpellName(i, BOOKTYPE_SPELL);
		local Texture = GetSpellTexture(i, BOOKTYPE_SPELL);
		if (spellName==nil or Texture==nil) then
			do break end
		end
		PAState.SpellBook[i] = {Name=spellName, Rank=spellRank, Texture=Texture};
		local StartTime, Duration, Enabled = GetSpellCooldown(i, BOOKTYPE_SPELL);
		PAState.SpellBook[i]["Cooldown"] = {StartTime=StartTime, Duration=Duration, Enabled=Enabled};
		PA:ResetTooltip();
		PanzaTooltip:SetSpell(i, BOOKTYPE_SPELL);
		PA:CaptureTooltip(PAState.SpellBook[i]);
		i = i + 1;
	end
	-- BonusScan
	if (BonusScanner~=nil and
		BonusScanner.active==1 and
		BonusScanner.bonuses~=nil and
		BonusScanner.bonuses.HEAL~=nil) then
		PAState.BonusScanner = {Active=BonusScanner.active, Heal=BonusScanner.bonuses.HEAL};
	end
	-- ActionSlots
	PAState.ActionSlots = {};
	for Id = 1, 120 do
		local Text = GetActionText(Id);
		PAState.ActionSlots[Id] = {HasAction=HasAction(Id),
									ActionText=Text,
									InRange=IsActionInRange(Id),
									HasRange=ActionHasRange(Id),
									CurrentAction=IsCurrentAction(Id),
									AutoRepeatAction=IsAutoRepeatAction(Id),
									UsableAction=IsUsableAction(Id),
									AttackAction=IsAttackAction(Id),
									Texture=GetActionTexture(Id),
									Count=GetActionCount(Id),
									};
		if (Text==nil and HasAction(Id)) then
			PA:ResetTooltip();
			PanzaTooltip:SetAction(Id);
			PA:CaptureTooltip(PAState.ActionSlots[Id]);
		end
	end
	--Bags
	PAState.Bags = {};
	for bag = 0, NUM_BAG_FRAMES do
		PAState.Bags[bag] = {Slots=GetContainerNumSlots(bag)};
		for slot = 1, GetContainerNumSlots(bag) do
			local itemName = GetContainerItemLink(bag, slot);
			if itemName then
				local texture, count = GetContainerItemInfo(bag, slot);
				PAState.Bags[bag][slot] = {Name=itemName, Texture=texture, Count=count};
			end
		end
	end
	--Macros
	PAState.Macros = {};
	for Id = 1, 36 do
		local Name, IconTexture, Body = GetMacroInfo(Id);
		PAState.Macros[Id] = {Name=Name, Texture=IconTexture, Body=PA:Escape(Body)};
	end
	--Groups
	PAState["RaidLeader"] = IsRaidLeader();
	PAState["PartyLeader"] = IsPartyLeader();
	PAState["PartyLeaderIndex"] = GetPartyLeaderIndex();
	--Raid
	if (PA:IsInRaid()) then
		PAState.Raid = {};
		PAState.Raid.Roster = {};
		for Id = 1, PANZA_MAX_RAID do
			local Unit = "raid"..Id;
			if (UnitExists(Unit)) then
				local _, Class = UnitClass(Unit);
				PAState.Raid[Unit] = PA:GetUnitInfo(Unit);
				if (PA:CanHavePet(Class)) then
					Unit = "raidpet"..Id;
					if (UnitExists(Unit)) then
						PAState.Raid[Unit] = PA:GetUnitInfo(Unit);
					end
				end
			end
			local name, rank, subgroup, level, classloc, class, zone, online, isDead = GetRaidRosterInfo(Id);
			PAState.Raid.Roster[Id] = {Name=name, Rank=rank, Subgroup=subgroup, Level=level, ClassLoc=classloc, Class=class, Zone=zone, Online=online, IsDead=isDead};
		end
	end
	--Party
	if (PA:IsInParty()) then
		PAState.Party = {};
		for Id = 1, PANZA_MAX_PARTY do
			local Unit = "party"..Id;
			if (UnitExists(Unit)) then
				local _, Class = UnitClass(Unit);
				PAState.Party[Unit] = PA:GetUnitInfo(Unit);
				if (PA:CanHavePet(Class)) then
					Unit = "partypet"..Id;
					if (UnitExists(Unit)) then
						PAState.Party[Unit] = PA:GetUnitInfo(Unit);
					end
				end
			end
		end
	end
	
	PAState.SpellCanTarget = {};
	--Spell Can Cast
	local Retarget = false;
	if (PA:UnitIsMyFriend("target")) then
		Retarget = true;
		ClearTarget();
	end
	if (SpellIsTargeting()) then
		SpellStopTargeting();
	end
	for ShortSpell, _ in pairs(PA.SpellBook.SpellCanTarget) do
		PAState.SpellCanTarget[ShortSpell] = {};
		local SpellToCast = PA:CombineSpell(PA.SpellBook[ShortSpell].Name, PA.SpellBook[ShortSpell].MinRank);
		--PA:ShowText("  SpellToCast=", SpellToCast);
		CastSpellByName(SpellToCast);
		SpellTargeting = SpellIsTargeting();
		-- Spell cast for targeting, now check if it will cast
		if (SpellTargeting) then
			PAState.SpellCanTarget[ShortSpell].player = SpellCanTargetUnit("player");
			if (PA:IsInRaid()) then
				for Id = 1, PANZA_MAX_RAID do
					local Unit = "raid"..Id;
					if (UnitExists(Unit)) then
						PAState.SpellCanTarget[ShortSpell][Unit] = SpellCanTargetUnit(Unit);
					end
					Unit = "raidpet"..Id;
					if (UnitExists(Unit)) then
						PAState.SpellCanTarget[ShortSpell][Unit] = SpellCanTargetUnit(Unit);
					end
				end
			end
			if (PA:IsInParty()) then
				for Id = 1, PANZA_MAX_PARTY do
					local Unit = "party"..Id;
					if (UnitExists(Unit)) then
						PAState.SpellCanTarget[ShortSpell][Unit] = SpellCanTargetUnit(Unit);
					end
					Unit = "partypet"..Id;
					if (UnitExists(Unit)) then
						PAState.SpellCanTarget[ShortSpell][Unit] = SpellCanTargetUnit(Unit);
					end
				end
			end
		end
	end
	-- Clear test spell
	if (SpellIsTargeting()) then
		SpellStopTargeting();
	end
	-- Retarget original target
	if (Retarget) then
		TargetLastTarget();
		PA.ForceCombat = (InCombat and UnitCanAttack("player", "target"));
	end
	
	--Battlefields
	PAState.Battlefields = {};
	for Id=1, MAX_BATTLEFIELD_QUEUES do
		local bgstatus, BGName, instanceID = GetBattlefieldStatus(Id);
		PAState.Battlefields[Id] = {Status=bgstatus, Name=BGName, Id=instanceID};
	end
end

-- Extract details for specified unit
function PA:GetUnitInfo(unit)
	if (not UnitExists(unit)) then
		return nil;
	end

	local InCombat = PA.InCombat;
	local OldTarget = PA:UnitName("target");
	TargetUnit(unit);

	local UnitInfo = {Unit=unit}
	local Name, Realm = UnitName(unit)
	UnitInfo["Name"] = Name;
	UnitInfo["Realm"] = Realm;
	UnitInfo["Level"] = UnitLevel(unit);
	local LocClass, Class= UnitClass(unit);
	UnitInfo["LocClass"] = LocClass;
	UnitInfo["Class"] = Class;
	UnitInfo["Sex"] = UnitSex(unit);
	UnitInfo["Connected"] = UnitIsConnected(unit);
	UnitInfo["Dead"] = UnitIsDead(unit);
	UnitInfo["Ghost"] = UnitIsGhost(unit);
	UnitInfo["Corpse"] = UnitIsCorpse(unit);
	UnitInfo["Player"] = UnitIsUnit(unit, "player");
	UnitInfo["Visible"] = UnitIsVisible(unit);
	UnitInfo["Enemy"] = UnitIsEnemy(unit, "player");
	UnitInfo["Friend"] = UnitIsFriend(unit, "player");
	UnitInfo["PVP"] = UnitIsPVP(unit);
	UnitInfo["CanAttack"] = UnitCanAttack(unit, "player");
	UnitInfo["CanBeAttacked"] = UnitCanAttack("player", unit);
	UnitInfo["CanCooperate"] = UnitCanCooperate("player", unit);
	local X, Y = GetPlayerMapPosition(unit);
	UnitInfo["Pos"]= {X=X, Y=Y};
	UnitInfo["InteractDistance"] = {[1]=CheckInteractDistance(unit, 1);
									[2]=CheckInteractDistance(unit, 2),
									[3]=CheckInteractDistance(unit, 3),
									[4]=CheckInteractDistance(unit, 4)};
	UnitInfo["InParty"] = UnitInParty(unit);
	UnitInfo["UnitInRaid"] = UnitInRaid(unit);
	UnitInfo["PlayerOrPetInParty"] = UnitPlayerOrPetInParty(unit);
	UnitInfo["PlayerOrPetInRaid"] = UnitPlayerOrPetInRaid(unit);
	UnitInfo["PlayerOrPetFlag"] = true;
	UnitInfo["Range"] = PA:RangeToUnit(unit);
	UnitInfo["InternalRange"] = PA:RangeToUnitInternal(unit);

	UnitInfo["ActionRange"] = {};
	for Range, Id in pairs(PA.ActionId) do
		UnitInfo.ActionRange[Id] = {InRange=IsActionInRange(Id), Check=Range};
	end
	for Range, Id in pairs(PA.OffenseActionId) do
		UnitInfo.ActionRange[Id] = {InRange=IsActionInRange(Id), Check=Range};
	end
	for Short, Id in pairs(PA.SpecialActionId) do
		UnitInfo.ActionRange[Id] = {InRange=IsActionInRange(Id), Check=Short};
	end

	PA:ResetTooltip();
	PanzaTooltip:SetUnit(unit);
	PA:CaptureTooltip(UnitInfo)

	UnitInfo["Owner"] = PA:GetUnitsOwner(unit);

	UnitInfo["impPS"] = PA:UnitHasBlessing(unit, "impPS");
	UnitInfo["Prowl"] = PA:UnitHasBlessing(unit, "Prowl");
	UnitInfo["MindControl"] = PA:UnitHasDebuff(unit, "MindControl");
	UnitInfo["MindVision"] = PA:UnitHasDebuff(unit, "MindVision");

	UnitInfo["InCombat"] = UnitAffectingCombat(unit);
	UnitInfo["TargetInCombat"] = UnitAffectingCombat(unit, "target");

	UnitInfo["Buffs"] = {};
	local Index = 1;
	local Applications;
	local Name, Applications, Type = UnitBuff(unit, Index);
	while (Name~=nil) do
		UnitInfo["Buffs"][Index] = {Name=Name, Applications=Applications, Type=Type};
		PA:ResetTooltip();
		PanzaTooltip:SetUnitBuff(unit, Index);
		PA:CaptureTooltip(UnitInfo["Buffs"][Index])
		Index = Index + 1;
		Name, Applications, Type = UnitBuff(unit, Index);
	end

	UnitInfo["Debuffs"] = {};
	Index = 1;
	Name, Applications, Type = UnitDebuff(unit, Index);
	while (Name~=nil) do
		UnitInfo["Debuffs"][Index] = {Name=Name, Applications=Applications, Type=Type};
		PA:ResetTooltip();
		PanzaTooltip:SetUnitDebuff(unit, Index);
		PA:CaptureTooltip(UnitInfo["Debuffs"][Index]);
		Index = Index + 1;
		Name, Applications, Type = UnitDebuff(unit, Index);
	end

	UnitInfo["Stats"] = {};
    for Index = 1, 5 do
		local base, stat, posBuff, negBuff = UnitStat(unit, Index);
		UnitInfo["Stats"][Index] = {Base=base, Stat=stat, PosBuff=posBuff, NegBuff=negBuff};
	end

	local ResIndex = {[0]="Physical", [1]="Holy", [2]="Fire", [3]="Nature", [4]="Frost", [5]="Shadow", [6]="Arcane"};
	UnitInfo["Resistances"] = {};
    for Index = 0, 6 do
		local base, total, bonus, malus = UnitResistance(unit, Index)
		UnitInfo["Resistances"][Index] = {Type=ResIndex[Index], Base=base, Total=total, Bonus=bonus, Malus=malus};
	end

    UnitInfo["Armor"] = UnitArmor(unit);
    UnitInfo["AttackBothHands"] = UnitAttackBothHands(unit);
    UnitInfo["AttackPower"] = UnitAttackPower(unit);
    UnitInfo["AttackSpeed"] = UnitAttackSpeed(unit);
    UnitInfo["Classification"] = UnitClassification(unit);
    UnitInfo["CreatureFamily"] = UnitCreatureFamily(unit);
    UnitInfo["CreatureType"] = UnitCreatureType(unit) ;
    UnitInfo["Damage"] = UnitDamage(unit);
    UnitInfo["Defense"] = UnitDefense(unit);
    UnitInfo["FactionGroup"] = UnitFactionGroup(unit);
    UnitInfo["Health"] = UnitHealth(unit);
    UnitInfo["HealthMax"] = UnitHealthMax(unit) ;
    UnitInfo["IsCharmed"] = UnitIsCharmed(unit);
    UnitInfo["IsCivilian"] = UnitIsCivilian(unit);
    UnitInfo["IsPartyLeader"] = UnitIsPartyLeader(unit);
    UnitInfo["IsPlayer"] = UnitIsPlayer(unit);
    UnitInfo["IsPlusMob"] = UnitIsPlusMob(unit);
    UnitInfo["IsTapped"] = UnitIsTapped(unit);
    UnitInfo["IsTappedByPlayer"] = UnitIsTappedByPlayer(unit);
    UnitInfo["IsTrivial"] = UnitIsTrivial(unit);
    UnitInfo["Mana"] = UnitMana(unit);
    UnitInfo["ManaMax"] = UnitManaMax(unit);
    UnitInfo["OnTaxi"] = UnitOnTaxi(unit);
    UnitInfo["PVPName"] = UnitPVPName(unit) ;
    UnitInfo["PVPRank"] = UnitPVPRank(unit);
    UnitInfo["PowerType"] = UnitPowerType(unit);
    UnitInfo["Race"] = UnitRace(unit);
    UnitInfo["RangedAttack"] = UnitRangedAttack(unit);
    UnitInfo["RangedAttackPower"] = UnitRangedAttackPower(unit);
    UnitInfo["RangedDamage"] = UnitRangedDamage(unit);
	Name, Realm = UnitName(unit.."Target")
    UnitInfo["Target"] = Name;
    UnitInfo["TargetRealm"] = Realm;
	Name, Realm = UnitName(unit.."TargetTarget")
    UnitInfo["TargetTarget"] = Name;
    UnitInfo["TargetTargetRealm"] = Realm;
    UnitInfo["XP"] = UnitXP(unit);
    UnitInfo["XPMax"] = UnitXPMax(unit);

	if (OldTarget==nil) then
		ClearTarget();
	elseif (OldTarget~="target" and OldTarget~=PA:UnitName("target")) then
		TargetLastTarget();
		PA.ForceCombat = (InCombat and UnitCanAttack("player", "target"));
	end

	return UnitInfo;
end

-- Extract details for specified slot
function PA:GetSlotInfo(slot)
	local Id, Texture = GetInventorySlotInfo(slot);
	if (Id~=nil) then
		PAState.Inventory.Slot[slot] =  {Id=Id, Texture=Texture};
		PAState.Inventory.ItemLink[Id] = GetInventoryItemLink("player", Id);
		PAState.Inventory.ItemCooldown[Id] = GetInventoryItemCooldown("player", Id);
	end
end
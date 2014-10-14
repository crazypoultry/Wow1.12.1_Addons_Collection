BINDING_HEADER_TARGETHELPER		= "Target Helper";
BINDING_NAME_TARGETHELPER_TARGET	= "Target Helper Key";

function TargetHelper_Target()
	if (UnitIsPVP("player")) then
		TargetHelper_PvP();
		return;
	end

	local ePlayerClass;
	_, ePlayerClass = UnitClass("player");
	if (GetLocale()=="deDE") then
		if (ePlayerClass == "MAGE")then
			TargetHelper_FindFreeTarget("","Wildtier","Humanoid");
		elseif (ePlayerClass == "DRUID")then
			TargetHelper_FindFreeTarget("","Wildtier","Drachkin");
		elseif (ePlayerClass == "PRIEST")then
			TargetHelper_FindFreeTarget("","Untot","Humanoid");
		elseif (ePlayerClass == "WARLOCK")then
			TargetHelper_FindFreeTarget("","Elementargeist","D\195\164mon");
		else
			TargetHelper_FindFreeTarget("WARRIOR","","-");
		end
	else
		if (ePlayerClass == "MAGE")then
			TargetHelper_FindFreeTarget("","Beast","Humanoid");
		elseif (ePlayerClass == "DRUID")then
			TargetHelper_FindFreeTarget("","Beast","Dragonkin");
		elseif (ePlayerClass == "PRIEST")then
			TargetHelper_FindFreeTarget("","Undead","Humanoid");
		elseif (ePlayerClass == "WARLOCK")then
			TargetHelper_FindFreeTarget("","Elemental","Demon");
		else
			TargetHelper_FindFreeTarget("WARRIOR","","-");
		end
	end
end

-- Searches for free target which is not targeted by any <PClass> in your party/raid and is of type MClass1 or MClass2
-- Where "" matches all and "-" matches none.

function TargetHelper_FindFreeTarget(PClass,MClass1,MClass2)
	local i,j;
	local self,first,skip,player;
	local index, value;

	if (not UnitExists("target")) then
		TargetNearestEnemy();
	else
		skip = true;
	end

	if (not UnitExists("target")) then
		PlaySoundFile("Sound\\Interface\\uEscapeScreenOpen.wav");
		return;
	end

	local tanks=0;
	local TankList={};
	local eUnitClass;

	if (GetNumRaidMembers()>0) then
		for i = 1, GetNumRaidMembers(), 1 do
			if ( UnitIsUnit("player", "raid"..i)) then
				self=i;
			end
			_, eUnitClass = UnitClass("raid"..i);
			if (string.find(eUnitClass,PClass) and i~=self) then
				tanks=tanks+1;
				TankList[tanks]="raid"..i;
			end
		end
	elseif (GetNumPartyMembers()>0) then
		for i = 1, GetNumPartyMembers(), 1 do
			_, eUnitClass = UnitClass("party"..i);
			if (string.find(eUnitClass,PClass) and i~=self) then
				tanks=tanks+1;
				TankList[tanks]="party"..i;
			end
		end
	else
		tanks=tanks+1;
		TankList[tanks]="pet";
	end
	first=nil;
	for j = 1, 11, 1 do
		if (first and UnitIsUnit("target", first.."target") ) then
			PlaySoundFile("Sound\\Interface\\uEscapeScreenOpen.wav");
			return;
		end
		player=nil;
		for index, value in TankList do
			if ( UnitExists("target") and UnitIsUnit("target", value.."target")) then
				player=value;
			end
		end
		if (player and not first) then
			first=player;
		end
		if (not skip and not player and (string.find(UnitCreatureType("target"),MClass1) or string.find(UnitCreatureType("target"),MClass2))) then
			if (UnitAffectingCombat("player")) then
				if (UnitAffectingCombat("target")) then
					return;
				end
			else
				return;
			end
		end
		if (skip) then
			skip=nil;
		end
		TargetNearestEnemy();
	end
	PlaySoundFile("Sound\\Interface\\uEscapeScreenOpen.wav");
end

local HealthMultiplyer={["WARRIOR"]="1.3",["PALADIN"]="2.0",["HUNTER"]="0.8",["ROGUE"]="1.0",["DRUID"]="1.2",["Shaman"]="1.1",["PRIEST"]="0.9",["WARLOCK"]="0.7",["MAGE"]="0.5",}

function TargetHelper_PvP()
	local ePlayerClass;
	local first="";
	local health=1.0;
	local newtarget="";

	ClearTarget();
	for j = 1, 15, 1 do
		if (UnitIsPlayer("target") and not UnitIsDeadOrGhost("target") and UnitCanAttack("player","target")) then
			if (first=="") then
				first=UnitName("target");
			end
			_, ePlayerClass = UnitClass("target");
			newhealth=UnitHealth("target")/UnitHealthMax("target")*HealthMultiplyer[ePlayerClass];
			if (newhealth < health) then
				health=newhealth;
				newtarget=UnitName("target");
			end
		end
		TargetNearestEnemy();
		if (not UnitExists("target") or UnitName("target")==first) then
			j=15;
		end
	end
	if (newtarget~="") then
		TargetByName(newtarget);
	else
		if(first=="") then
			ClearTarget();
		else
			TargetByName(first);
		end
	end
end

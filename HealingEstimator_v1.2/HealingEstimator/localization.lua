HEALINGESTIMATOR_VERSION = "v1.1";
BINDING_HEADER_HEALINGESTIMATOR_HEADER = "Healing Estimator";
BINDING_NAME_HEALINGESTIMATOR_CANCEL = "Cancel overhealing";

-- Localization strings
HealingEstimatorLoc = 
	{
	Welcome		= "Healing Estimator "..HEALINGESTIMATOR_VERSION.." loaded";
	
	-- This infomation is readed from tooltip
	HealValue	= "(%d+) to (%d+)";
	RankTxt		= "%((Rank %d+)%)";
	RankTooltip	= "Rank (%d+)";
	TargetName	= "<Target name>";
	
	-- Healing texts in combat log
	CritHeal	= "Your (.+) critically heals (.+) for (%d+)%.";
	NormHeal	= "Your (.+) heals (.+) for (%d+)%.";
	HotSelf		= "You gain (%d+) health from (.+)%.";
	HotOther	= "(.+) gains (%d+) health from your (.+)%.";
	YouText 	= "you";
	
	-- Healing classes
	HealingClasses={"Priest", "Druid", "Paladin", "Shaman"};
	HealingSpells=
		{
		"Flash Heal", "Greater Heal", "Lesser Heal", "Heal",
		"Healing Touch", "Regrowth",
		"Holy Light", "Flash of Light",
		"Healing Wave", "Lesser Healing Wave"
		};
	
	-- Menu text
	Scale			= "Healing bar scale ";
	Limit			= "Overheal warning at ";
	IconPos			= "Position";
	OverhealTitle	= "Healing meter config";
	BarTitle		= "Healing bar";
	MinimapTitle	= "Minimap button";
	ShowText		= "Show";
	HideText		= "Hide";
	ResetPosTooltip	= "Resets the healing bar position";
	HideTooltip		= "Hides/shows the minimap button";
	ClearTooltip	= "Clears current healing/overhealing data";
	
	
	HideMeter		= "Overhealing meter hidden, use /heal or /healingestimator command to show menu.";
	ShowMeter		= "Overhealing meter visible.";
	};

--------------------------------------------------------------------
-- Localized functions
--------------------------------------------------------------------

--------------------------------------------------------------------
-- IsHealingSpell
-- Checks if given spell is a single target healing spell with cast time
--
function HealingEstimator_IsHealingSpell(Name)
	local c;
	local Size=table.getn(HealingEstimatorLoc.HealingSpells);
	for c=1,Size do
		if (HealingEstimatorLoc.HealingSpells[c]==Name) then
			-- Spell is healing spell, return true
			return true;
		end
	end
	-- Return false
	return false;	
end

--------------------------------------------------------------------
-- IsHealingClass
-- Checks if given class is capable of healing
--
function HealingEstimator_IsHealingClass(Class)
	local c;
	local Size=table.getn(HealingEstimatorLoc.HealingClasses);
	for c=1,Size do
		if (HealingEstimatorLoc.HealingClasses[c]==Class) then
			-- Spell is healing spell, return true
			return true;
		end
	end
	-- Return false
	return false;	
end

--------------------------------------------------------------------
-- ParseSelfBuff
-- Reads the heal info from combat log message
-- Returns Spell, Spell target, Heal amount, info about crit
--
function HealingEstimator_ParseSelfBuff(Msg)
	local s,t,h;
	local Spell,Target,Heal,Crit=nil,nil,nil,false;
	for s,t,h in string.gfind(Msg, HealingEstimatorLoc.CritHeal) do
		Spell=s;Target=t;Heal=h;
		Crit=true;
	end
	if (not (Spell and Heal)) then
		for s,t,h in string.gfind(Msg, HealingEstimatorLoc.NormHeal) do
			Spell=s;Target=t;Heal=h;
		end
	end
	
	-- Convert "you" to player name
	-- Seen in lines "Your Healing touch heals you for 42"
	if (Target and string.lower(Target)==HealingEstimatorLoc.YouText) then
		Target=UnitName("player");
	end

	return Spell,Target,Heal,Crit;
end

--------------------------------------------------------------------
-- ParsePeriodicSelfBuff
-- Reads the heal over time info from combat log message
-- Returns Spell, Spell target, Heal amount, info about crit
--
function HealingEstimator_ParsePeriodicSelfBuff(Msg)
	local Spell,Target,Heal;
	for Heal, Spell in string.gfind(Msg, HealingEstimatorLoc.HotSelf) do 
		-- Self Hot
		return Spell,UnitName("player"),Heal,false; 
	end
	
	for Target, Heal, Spell in string.gfind(Msg, HealingEstimatorLoc.HotOther) do 
		-- Self Hot on Others
		return Spell,Target,Heal,false; 
	end
	return nil,nil,nil,false;
end
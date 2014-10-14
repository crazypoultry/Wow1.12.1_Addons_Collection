--
-- Healing estimator france localization
-- incomplete file
--

if(GetLocale()=="frFR") then

	-- Localize key-binding texts
	BINDING_HEADER_HEALINGESTIMATOR_HEADER = "Healing Estimator";
	BINDING_NAME_HEALINGESTIMATOR_CANCEL = "Cancel overhealing";

	-- Localize other texts
	HealingEstimatorLoc = 
		{
		Welcome		= "Healing Estimator "..HEALINGESTIMATOR_VERSION.." loaded";
		
		-- This infomation is readed from tooltip
		HealValue	= "(%d+) \195\160 (%d+)";
		RankTxt		= "%((Rang %d+)%)";
		RankTooltip	= "Rang (%d+)";
		TargetName	= "<Target name>";
		
		-- Healing texts in combat log
		-- French locale has own functions to parse these
		CritHeal 	= "";
		NormHeal	= "";
		HotSelf		= "";
		HotOther	= "";
		YouText 	= "Vous";
		
		-- Healing classes
		HealingClasses={"Pr\195\170tre", "Druide", "Chaman", "Paladin"};
		HealingSpells=
			{
			"Soins rapides", "Soins sup\195\169rieurs", "Soins inf\195\169rieurs", "Soins",
			"Toucher gu\195\169risseur", "R\195\169tablissement",
			"Feu sacr\195\169e", "Eclair lumineux",
			"Vague de Soins", "Vague de soins mineurs"
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
end

--------------------------------------------------------------------
-- Localized functions
--------------------------------------------------------------------

--------------------------------------------------------------------
-- ParseSelfBuff
-- Reads the heal info from combat log message
-- Returns Spell, Spell target, Heal amount, info about crit
--
function HealingEstimator_ParseSelfBuff_FR(Msg)
	local Spell,Target,Heal;
	for Spell, Target, Heal in string.gfind(arg1, "Votre (.+) soigne (.+) avec un effet critique et lui rend (%d+) points de vie.") do
		-- Self Crit Heal;
		return Spell,Target,Heal,true;
	end

	for Spell, Heal in string.gfind(arg1, "Votre (.+) vous soigne pour (%d+) points de vie.") do
		-- Self Heal
		Target=UnitName("Player");
		return Spell,Target,Heal,false;
	end

	for Spell, Target, Heal in string.gfind(arg1, "Votre (.+) soigne (.+) pour (%d+) points de vie.") do
		-- Friendly Heal
		if (string.lower(Target) == HealingEstimatorLoc.YouText) then 
			Target = UnitName("Player"); 
		end
		return Spell,Target,Heal,false;
	end

	return nil,nil,nil,false;
end

--------------------------------------------------------------------
-- ParsePeriodicSelfBuff
-- Reads the heal over time info from combat log message
-- Returns Spell, Spell target, Heal amount, info about crit
--
function HealingEstimator_ParsePeriodicSelfBuff_FR(Msg)
	local Spell,Target,Heal;
	for Spell, Heal in string.gfind(arg1, "(.+) vous rend (%d+) points de vie.") do
		-- Self Hot
		Target=UnitName("Player");
		return Spell,Target,Heal,false;
	end
	for Spell, Heal, Target in string.gfind(arg1, "Votre (.+) rend (%d+) points de vie \195\160 (.+).") do		
		-- Self Hot on Others
		return Spell,Target,Heal,false;
	end
	return nil,nil,nil,false;
end
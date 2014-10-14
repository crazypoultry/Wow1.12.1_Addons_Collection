-- Version: English (by Whitetooth)
-- Last Update: 2005/09/03

-------------------------------------
-- TankPoints calculation function --
-------------------------------------
-- This part needs to be set correctly for TankPoints to work
-- EXACT spell names as seen in spell book
TANKPOINTS_DODGE_SPELL_NAME = "Dodge";
-- EXACT warrior stance names as seen in spell book
TANKPOINTS_WARRIOR_DEFENSIVE_STANCE = "Defensive Stance";
TANKPOINTS_WARRIOR_BERSERKER_STANCE = "Berserker Stance";

------------------------
-- TankPoints tooltip --
------------------------
TANKPOINTS_TOOLTIP_IN = "In "; -- "In "StanceName
TANKPOINTS_TOOLTIP_DEFENSE = "Defense";
TANKPOINTS_TOOLTIP_CRIT_REDUCTION = "Crit Reduction";
TANKPOINTS_TOOLTIP_TOTAL_REDUCTION = "Total Reduction";
TANKPOINTS_TOOLTIP_HINT_CLICK_TO_SHOW_TANKPOINTS_CALCULATOR = "Hint: Click to show TankPoints Calculaor";

---------------------------
-- TankPoints Calculator --
---------------------------
TANKPOINTS_CALCULATOR_MAX_HP = "Max HP";
TANKPOINTS_CALCULATOR_TAUREN = "Tauren";

---------------------------------------------------------------------
if ( GetLocale() == "zhTW" ) then
-- Translations by: 
-- put zhTW localizations here
TANKPOINTS_DODGE_SPELL_NAME = DODGE;
TANKPOINTS_WARRIOR_DEFENSIVE_STANCE = "防禦姿態";
TANKPOINTS_WARRIOR_BERSERKER_STANCE = "狂暴姿態";

TANKPOINTS_TOOLTIP_IN = "在";
TANKPOINTS_TOOLTIP_DEFENSE = "防禦";
TANKPOINTS_TOOLTIP_CRIT_REDUCTION = "被致命率減免";
TANKPOINTS_TOOLTIP_TOTAL_REDUCTION = "總傷害減免";
TANKPOINTS_TOOLTIP_HINT_CLICK_TO_SHOW_TANKPOINTS_CALCULATOR = "提示：按下顯示 TankPoints 計算機";

TANKPOINTS_CALCULATOR_MAX_HP = "最大血量";
TANKPOINTS_CALCULATOR_TAUREN = "牛頭人";


---------------------------------------------------------------------
elseif ( GetLocale() == "deDE" ) then
-- Translations by: Ramides
TANKPOINTS_DODGE_SPELL_NAME = DODGE;
TANKPOINTS_WARRIOR_DEFENSIVE_STANCE = "Verteidigungshaltung";
TANKPOINTS_WARRIOR_BERSERKER_STANCE = "Berserkerhaltung";

TANKPOINTS_TOOLTIP_IN = "In ";
TANKPOINTS_TOOLTIP_DEFENSE = "Verteidigung";
TANKPOINTS_TOOLTIP_CRIT_REDUCTION = "Krit-Reduzierung";
TANKPOINTS_TOOLTIP_TOTAL_REDUCTION = "Ges. Schadensred.";
TANKPOINTS_TOOLTIP_HINT_CLICK_TO_SHOW_TANKPOINTS_CALCULATOR = "Hint: Klicke hier um den TankPoints Calculator anzuzeigen";

TANKPOINTS_CALCULATOR_MAX_HP = "Max HP";
TANKPOINTS_CALCULATOR_TAUREN = "Tauren";

---------------------------------------------------------------------
elseif ( GetLocale() == "frFR" ) then
-- Translations by: Olivier.Mayeres
-- put frFR localizations here
TANKPOINTS_DODGE_SPELL_NAME = "Esquiver";
TANKPOINTS_WARRIOR_DEFENSIVE_STANCE = "Posture d\195\169fensive";
TANKPOINTS_WARRIOR_BERSERKER_STANCE = "Posture berserker";

TANKPOINTS_TOOLTIP_IN = "En ";
TANKPOINTS_TOOLTIP_DEFENSE = "D\195\169fense";
TANKPOINTS_TOOLTIP_CRIT_REDUCTION = "R\195\169duction des Critic";
TANKPOINTS_TOOLTIP_TOTAL_REDUCTION = "R\195\169duction Totale";
TANKPOINTS_TOOLTIP_HINT_CLICK_TO_SHOW_TANKPOINTS_CALCULATOR = "Cliquer pour afficher TankPoints Calculator";

TANKPOINTS_CALCULATOR_MAX_HP = "PV Max";
TANKPOINTS_CALCULATOR_TAUREN = "Tauren";

---------------------------------------------------------------------
elseif ( GetLocale() == "koKR" ) then
-- Translations by: 
-- put koKR localizations here
TANKPOINTS_DODGE_SPELL_NAME = DODGE;
TANKPOINTS_WARRIOR_DEFENSIVE_STANCE = "Defensive Stance";
TANKPOINTS_WARRIOR_BERSERKER_STANCE = "Berserker Stance";

TANKPOINTS_TOOLTIP_IN = "In ";
TANKPOINTS_TOOLTIP_DEFENSE = "Defense";
TANKPOINTS_TOOLTIP_CRIT_REDUCTION = "Crit Reduction";
TANKPOINTS_TOOLTIP_TOTAL_REDUCTION = "Total Reduction";
TANKPOINTS_TOOLTIP_HINT_CLICK_TO_SHOW_TANKPOINTS_CALCULATOR = "Hint: Click to show TankPoints Calculaor";

TANKPOINTS_CALCULATOR_MAX_HP = "Max HP";
TANKPOINTS_CALCULATOR_TAUREN = "Tauren";
end

CritRecord.LOCAL = {};

-- General Text
CritRecord.LOCAL.VersionInfo = "v%s by %s";

-- Configuration Dialog
CritRecord.LOCAL.ConfigGeneral = "General";
CritRecord.LOCAL.ConfigEnableAddon = "Enable Crit Record";
CritRecord.LOCAL.ConfigEnableTooltips = "Enable Tooltips";
CritRecord.LOCAL.ConfigReportNewCrits = "Report New Crits";
CritRecord.LOCAL.ConfigReportInChat = "in Chat Frame";
CritRecord.LOCAL.ConfigReportOnScreen = "in Center of Screen";
CritRecord.LOCAL.ConfigEnableBGCrits = "Record crits in PvP Battlegrounds";
CritRecord.LOCAL.ConfigTakeScreenshots = "Take Screenshots of New Crits";
CritRecord.LOCAL.ConfigDamage = "Damage";
CritRecord.LOCAL.ConfigDamageRecordCrits = "Record Damage Crits";
CritRecord.LOCAL.ConfigHealing = "Healing";
CritRecord.LOCAL.ConfigHealingRecordCrits = "Record Crit Heals";
CritRecord.LOCAL.ConfigCountTrivial = "Count Trivial (Grey) Level Targets";
CritRecord.LOCAL.ConfigTooltipTargetInfo = "Show Target Info in Tooltips";
CritRecord.LOCAL.ConfigTooltipLevelRaceClass = "Show Level, Race and Class";
CritRecord.LOCAL.ConfigTooltipLocation = "Show Location";
CritRecord.LOCAL.ConfigTooltipDateTime = "Show Date and Time";

-- Specialized Localization
-- The text displayed when a new crit is recorded can be customised using the following replacement keywords
-- #A - This is replaced by the attack that caused the new crit record
-- #D - This is the damage done by #A that caused the new crit record
-- #T - The name of the target that #A crit
CritRecord.LOCAL.NewRecordChat1 = "New Crit with #A for #D against #T";
CritRecord.LOCAL.NewRecordChat2 = "New Crit Heal with #A for #D against #T";
CritRecord.LOCAL.NewRecordScreen = "New Record with %s for %d";


function SetOptionsCheckButtons()

	if (MyRolePlay.Settings.Relative == 0) then
		mrpRelativeLevelOptionButton:SetChecked(nil);
	else
		mrpRelativeLevelOptionButton:SetChecked(1);		
	end
	if (MyRolePlay.Settings.PopupDescriptions == 0) then
		mrpPopupDescriptionOptionButton:SetChecked(nil);
	else
		mrpPopupDescriptionOptionButton:SetChecked(1);		
	end
	if (MyRolePlay.Settings.Colours.Enabled == 0) then
		mrpColourTooltipOptionButton:SetChecked(nil);
	else
		mrpColourTooltipOptionButton:SetChecked(1);		
	end
	if (MyRolePlay.Settings.Tooltip.Enabled == 0) then
		mrpMRPTooltipOptionButton:SetChecked(nil);
	else
		mrpMRPTooltipOptionButton:SetChecked(1);		
	end
	if (MyRolePlay.Settings.ColourClassSpecific == 0) then
		mrpMRPColourClassOptionButton:SetChecked(nil);
	else
		mrpMRPColourClassOptionButton:SetChecked(1);		
	end
	if (MyRolePlay.Settings.FlagRSPCompatability == 0) then
		mrpFlagRSPOptionButton:SetChecked(nil);
	else
		mrpFlagRSPOptionButton:SetChecked(1);		
	end
--[[	if (MyRolePlay.Settings.Share.Enabled == false) then
		mrpShareToggleOptionButton:SetChecked(nil);
	else
		mrpShareToggleOptionButton:SetChecked(1);		
	end
	if (MyRolePlay.Settings.Share.Enabled == false) then
		mrpOptionSharePrefixAlways:Disable();
		mrpOptionSharePrefixPrompt:Disable();
		mrpOptionSharePrefixNever:Disable();
		mrpOptionShareFirstNameAlways:Disable();
		mrpOptionShareFirstNamePrompt:Disable();
		mrpOptionShareFirstNameNever:Disable();
		mrpOptionShareMiddleNameAlways:Disable();
		mrpOptionShareMiddleNamePrompt:Disable();
		mrpOptionShareMiddleNameNever:Disable();
		mrpOptionShareSurnameAlways:Disable();
		mrpOptionShareSurnamePrompt:Disable();
		mrpOptionShareSurnameNever:Disable();
		mrpOptionShareTitleAlways:Disable();
		mrpOptionShareTitlePrompt:Disable();
		mrpOptionShareTitleNever:Disable();
		mrpOptionShareNicknameAlways:Disable();
		mrpOptionShareNicknamePrompt:Disable();
		mrpOptionShareNicknameNever:Disable();
		mrpOptionShareHouseNameAlways:Disable();
		mrpOptionShareHouseNamePrompt:Disable();
		mrpOptionShareHouseNameNever:Disable();
		mrpOptionShareGuildAlways:Disable();
		mrpOptionShareGuildPrompt:Disable();
		mrpOptionShareGuildNever:Disable();
		mrpOptionShareEyeColourAlways:Disable();
		mrpOptionShareEyeColourPrompt:Disable();
		mrpOptionShareEyeColourNever:Disable();
		mrpOptionShareEmotionAlways:Disable();
		mrpOptionShareEmotionPrompt:Disable();
		mrpOptionShareEmotionNever:Disable();
		mrpOptionShareHeightAlways:Disable();
		mrpOptionShareHeightPrompt:Disable();
		mrpOptionShareHeightNever:Disable();
		mrpOptionShareWeightAlways:Disable();
		mrpOptionShareWeightPrompt:Disable();
		mrpOptionShareWeightNever:Disable();
		mrpOptionShareHomeCityAlways:Disable();
		mrpOptionShareHomeCityPrompt:Disable();
		mrpOptionShareHomeCityNever:Disable();
		mrpOptionShareBirthCityAlways:Disable();
		mrpOptionShareBirthCityPrompt:Disable();
		mrpOptionShareBirthCityNever:Disable();
		mrpOptionShareMottoAlways:Disable();
		mrpOptionShareMottoPrompt:Disable();
		mrpOptionShareMottoNever:Disable();
		mrpOptionShareHistoryAlways:Disable();
		mrpOptionShareHistoryPrompt:Disable();
		mrpOptionShareHistoryNever:Disable();
	end

	if (MyRolePlay.Settings.Share.PrefixEnabled == MRP_ALWAYS_ALLOW) then
		mrpOptionSharePrefixAlways:SetChecked(1);
		mrpOptionSharePrefixPrompt:SetChecked(nil);
		mrpOptionSharePrefixNever:SetChecked(nil);
	end
	if (MyRolePlay.Settings.Share.PrefixEnabled == MRP_PROMPT) then
		mrpOptionSharePrefixAlways:SetChecked(nil);
		mrpOptionSharePrefixPrompt:SetChecked(1);
		mrpOptionSharePrefixNever:SetChecked(nil);
	end
	if (MyRolePlay.Settings.Share.PrefixEnabled == MRP_ALWAYS_DECLINE) then
		mrpOptionSharePrefixAlways:SetChecked(nil);
		mrpOptionSharePrefixPrompt:SetChecked(nil);
		mrpOptionSharePrefixNever:SetChecked(1);
	end
	if (MyRolePlay.Settings.Share.FirstnameEnabled == MRP_ALWAYS_ALLOW) then
		mrpOptionShareFirstNameAlways:SetChecked(1);
		mrpOptionShareFirstNamePrompt:SetChecked(nil);
		mrpOptionShareFirstNameNever:SetChecked(nil);
	end
	if (MyRolePlay.Settings.Share.MiddlenameEnabled == MRP_ALWAYS_ALLOW) then
		mrpOptionShareMiddleNameAlways:SetChecked(1);
		mrpOptionShareMiddleNamePrompt:SetChecked(nil);
		mrpOptionShareMiddleNameNever:SetChecked(nil);
	end
	if (MyRolePlay.Settings.Share.MiddlenameEnabled == MRP_PROMPT) then
		mrpOptionShareMiddleNameAlways:SetChecked(nil);
		mrpOptionShareMiddleNamePrompt:SetChecked(1);
		mrpOptionShareMiddleNameNever:SetChecked(nil);
	end
	if (MyRolePlay.Settings.Share.MiddlenameEnabled == MRP_ALWAYS_DECLINE) then
		mrpOptionShareMiddleNameAlways:SetChecked(nil);
		mrpOptionShareMiddleNamePrompt:SetChecked(nil);
		mrpOptionShareMiddleNameNever:SetChecked(1);
	end
	if (MyRolePlay.Settings.Share.SurnameEnabled == MRP_ALWAYS_ALLOW) then
		mrpOptionShareSurnameAlways:SetChecked(1);
		mrpOptionShareSurnamePrompt:SetChecked(nil);
		mrpOptionShareSurnameNever:SetChecked(nil);
	end
	if (MyRolePlay.Settings.Share.SurnameEnabled == MRP_PROMPT) then
		mrpOptionShareSurnameAlways:SetChecked(nil);
		mrpOptionShareSurnamePrompt:SetChecked(1);
		mrpOptionShareSurnameNever:SetChecked(nil);
	end
	if (MyRolePlay.Settings.Share.SurnameEnabled == MRP_ALWAYS_DECLINE) then
		mrpOptionShareSurnameAlways:SetChecked(nil);
		mrpOptionShareSurnamePrompt:SetChecked(nil);
		mrpOptionShareSurnameNever:SetChecked(1);
	end
	if (MyRolePlay.Settings.Share.TitleEnabled == MRP_ALWAYS_ALLOW) then
		mrpOptionShareTitleAlways:SetChecked(1);
		mrpOptionShareTitlePrompt:SetChecked(nil);
		mrpOptionShareTitleNever:SetChecked(nil);
	end
	if (MyRolePlay.Settings.Share.TitleEnabled == MRP_PROMPT) then
		mrpOptionShareTitleAlways:SetChecked(nil);
		mrpOptionShareTitlePrompt:SetChecked(1);
		mrpOptionShareTitleNever:SetChecked(nil);
	end
	if (MyRolePlay.Settings.Share.TitleEnabled == MRP_ALWAYS_DECLINE) then
		mrpOptionShareTitleAlways:SetChecked(nil);
		mrpOptionShareTitlePrompt:SetChecked(nil);
		mrpOptionShareTitleNever:SetChecked(1);
	end
	if (MyRolePlay.Settings.Share.NicknameEnabled == MRP_ALWAYS_ALLOW) then
		mrpOptionShareNicknameAlways:SetChecked(1);
		mrpOptionShareNicknamePrompt:SetChecked(nil);
		mrpOptionShareNicknameNever:SetChecked(nil);
	end
	if (MyRolePlay.Settings.Share.NicknameEnabled == MRP_PROMPT) then
		mrpOptionShareNicknameAlways:SetChecked(nil);
		mrpOptionShareNicknamePrompt:SetChecked(1);
		mrpOptionShareNicknameNever:SetChecked(nil);
	end
	if (MyRolePlay.Settings.Share.NicknameEnabled == MRP_ALWAYS_DECLINE) then
		mrpOptionShareNicknameAlways:SetChecked(nil);
		mrpOptionShareNicknamePrompt:SetChecked(nil);
		mrpOptionShareNicknameNever:SetChecked(1);
	end
	if (MyRolePlay.Settings.Share.HousenameEnabled == MRP_ALWAYS_ALLOW) then
		mrpOptionShareHouseNameAlways:SetChecked(1);
		mrpOptionShareHouseNamePrompt:SetChecked(nil);
		mrpOptionShareHouseNameNever:SetChecked(nil);
	end
	if (MyRolePlay.Settings.Share.HousenameEnabled == MRP_PROMPT) then
		mrpOptionShareHouseNameAlways:SetChecked(nil);
		mrpOptionShareHouseNamePrompt:SetChecked(1);
		mrpOptionShareHouseNameNever:SetChecked(nil);
	end
	if (MyRolePlay.Settings.Share.HousenameEnabled == MRP_ALWAYS_DECLINE) then
		mrpOptionShareHouseNameAlways:SetChecked(nil);
		mrpOptionShareHouseNamePrompt:SetChecked(nil);
		mrpOptionShareHouseNameNever:SetChecked(1);
	end
		
	if (MyRolePlay.Settings.Share.GuildEnabled == MRP_ALWAYS_ALLOW) then
		mrpOptionShareGuildAlways:SetChecked(1);
		mrpOptionShareGuildPrompt:SetChecked(nil);
		mrpOptionShareGuildNever:SetChecked(nil);
	end
	if (MyRolePlay.Settings.Share.GuildEnabled == MRP_PROMPT) then
		mrpOptionShareGuildAlways:SetChecked(nil);
		mrpOptionShareGuildPrompt:SetChecked(1);
		mrpOptionShareGuildNever:SetChecked(nil);
	end
	if (MyRolePlay.Settings.Share.GuildEnabled == MRP_ALWAYS_DECLINE) then
		mrpOptionShareGuildAlways:SetChecked(nil);
		mrpOptionShareGuildPrompt:SetChecked(nil);
		mrpOptionShareGuildNever:SetChecked(1);
	end

	if (MyRolePlay.Settings.Share.EyeColourEnabled == MRP_ALWAYS_ALLOW) then
		mrpOptionShareEyeColourAlways:SetChecked(1);
		mrpOptionShareEyeColourPrompt:SetChecked(nil);
		mrpOptionShareEyeColourNever:SetChecked(nil);
	end
	if (MyRolePlay.Settings.Share.EyeColourEnabled == MRP_PROMPT) then
		mrpOptionShareEyeColourAlways:SetChecked(nil);
		mrpOptionShareEyeColourPrompt:SetChecked(1);
		mrpOptionShareEyeColourNever:SetChecked(nil);
	end
	if (MyRolePlay.Settings.Share.EyeColourEnabled == MRP_ALWAYS_DECLINE) then
		mrpOptionShareEyeColourAlways:SetChecked(nil);
		mrpOptionShareEyeColourPrompt:SetChecked(nil);
		mrpOptionShareEyeColourNever:SetChecked(1);
	end

	if (MyRolePlay.Settings.Share.HeightEnabled == MRP_ALWAYS_ALLOW) then
		mrpOptionShareHeightAlways:SetChecked(1);
		mrpOptionShareHeightPrompt:SetChecked(nil);
		mrpOptionShareHeightNever:SetChecked(nil);
	end
	if (MyRolePlay.Settings.Share.HeightEnabled == MRP_PROMPT) then
		mrpOptionShareHeightAlways:SetChecked(nil);
		mrpOptionShareHeightPrompt:SetChecked(1);
		mrpOptionShareHeightNever:SetChecked(nil);
	end
	if (MyRolePlay.Settings.Share.HeightEnabled == MRP_ALWAYS_DECLINE) then
		mrpOptionShareHeightAlways:SetChecked(nil);
		mrpOptionShareHeightPrompt:SetChecked(nil);
		mrpOptionShareHeightNever:SetChecked(1);
	end
	if (MyRolePlay.Settings.Share.WeightEnabled == MRP_ALWAYS_ALLOW) then
		mrpOptionShareWeightAlways:SetChecked(1);
		mrpOptionShareWeightPrompt:SetChecked(nil);
		mrpOptionShareWeightNever:SetChecked(nil);
	end
	if (MyRolePlay.Settings.Share.WeightEnabled == MRP_PROMPT) then
		mrpOptionShareWeightAlways:SetChecked(nil);
		mrpOptionShareWeightPrompt:SetChecked(1);
		mrpOptionShareWeightNever:SetChecked(nil);
	end
	if (MyRolePlay.Settings.Share.WeightEnabled == MRP_ALWAYS_DECLINE) then
		mrpOptionShareWeightAlways:SetChecked(nil);
		mrpOptionShareWeightPrompt:SetChecked(nil);
		mrpOptionShareWeightNever:SetChecked(1);
	end
	if (MyRolePlay.Settings.Share.CurrentEmotionEnabled == MRP_ALWAYS_ALLOW) then
		mrpOptionShareEmotionAlways:SetChecked(1);
		mrpOptionShareEmotionPrompt:SetChecked(nil);
		mrpOptionShareEmotionNever:SetChecked(nil);
	end
	if (MyRolePlay.Settings.Share.CurrentEmotionEnabled == MRP_PROMPT) then
		mrpOptionShareEmotionAlways:SetChecked(nil);
		mrpOptionShareEmotionPrompt:SetChecked(1);
		mrpOptionShareEmotionNever:SetChecked(nil);
	end
	if (MyRolePlay.Settings.Share.CurrentEmotionEnabled == MRP_ALWAYS_DECLINE) then
		mrpOptionShareEmotionAlways:SetChecked(nil);
		mrpOptionShareEmotionPrompt:SetChecked(nil);
		mrpOptionShareEmotionNever:SetChecked(1);
	end

	if (MyRolePlay.Settings.Share.HomeCityEnabled == MRP_ALWAYS_ALLOW) then
		mrpOptionShareHomeCityAlways:SetChecked(1);
		mrpOptionShareHomeCityPrompt:SetChecked(nil);
		mrpOptionShareHomeCityNever:SetChecked(nil);
	end
	if (MyRolePlay.Settings.Share.HomeCityEnabled == MRP_PROMPT) then
		mrpOptionShareHomeCityAlways:SetChecked(nil);
		mrpOptionShareHomeCityPrompt:SetChecked(1);
		mrpOptionShareHomeCityNever:SetChecked(nil);
	end
	if (MyRolePlay.Settings.Share.HomeCityEnabled == MRP_ALWAYS_DECLINE) then
		mrpOptionShareHomeCityAlways:SetChecked(nil);
		mrpOptionShareHomeCityPrompt:SetChecked(nil);
		mrpOptionShareHomeCityNever:SetChecked(1);
	end
	if (MyRolePlay.Settings.Share.BirthCityEnabled == MRP_ALWAYS_ALLOW) then
		mrpOptionShareBirthCityAlways:SetChecked(1);
		mrpOptionShareBirthCityPrompt:SetChecked(nil);
		mrpOptionShareBirthCityNever:SetChecked(nil);
	end
	if (MyRolePlay.Settings.Share.BirthCityEnabled == MRP_PROMPT) then
		mrpOptionShareBirthCityAlways:SetChecked(nil);
		mrpOptionShareBirthCityPrompt:SetChecked(1);
		mrpOptionShareBirthCityNever:SetChecked(nil);
	end
	if (MyRolePlay.Settings.Share.BirthCityEnabled == MRP_ALWAYS_DECLINE) then
		mrpOptionShareBirthCityAlways:SetChecked(nil);
		mrpOptionShareBirthCityPrompt:SetChecked(nil);
		mrpOptionShareBirthCityNever:SetChecked(1);
	end

	if (MyRolePlay.Settings.Share.MottoEnabled == MRP_ALWAYS_ALLOW) then
		mrpOptionShareMottoAlways:SetChecked(1);
		mrpOptionShareMottoPrompt:SetChecked(nil);
		mrpOptionShareMottoNever:SetChecked(nil);
	end
	if (MyRolePlay.Settings.Share.MottoEnabled == MRP_PROMPT) then
		mrpOptionShareMottoAlways:SetChecked(nil);
		mrpOptionShareMottoPrompt:SetChecked(1);
		mrpOptionShareMottoNever:SetChecked(nil);
	end
	if (MyRolePlay.Settings.Share.MottoEnabled == MRP_ALWAYS_DECLINE) then
		mrpOptionShareMottoAlways:SetChecked(nil);
		mrpOptionShareMottoPrompt:SetChecked(nil);
		mrpOptionShareMottoNever:SetChecked(1);
	end
	if (MyRolePlay.Settings.Share.CharacterHistory == MRP_ALWAYS_ALLOW) then
		mrpOptionShareHistoryAlways:SetChecked(1);
		mrpOptionShareHistoryPrompt:SetChecked(nil);
		mrpOptionShareHistoryNever:SetChecked(nil);
	end
	if (MyRolePlay.Settings.Share.CharacterHistory == MRP_PROMPT) then
		mrpOptionShareHistoryAlways:SetChecked(nil);
		mrpOptionShareHistoryPrompt:SetChecked(1);
		mrpOptionShareHistoryNever:SetChecked(nil);
	end
	if (MyRolePlay.Settings.Share.CharacterHistory == MRP_ALWAYS_DECLINE) then
		mrpOptionShareHistoryAlways:SetChecked(nil);
		mrpOptionShareHistoryPrompt:SetChecked(nil);
		mrpOptionShareHistoryNever:SetChecked(1);
	end
]]--
end
function mrpOptionClassColours()
	if (MyRolePlay.Settings.ColourClassSpecific == 0) then
		MyRolePlay.Settings.ColourClassSpecific = 1;
		mrpDisplayMessage(MRP_LOCALE_Options_ClassColours_Enabled);
	else
		MyRolePlay.Settings.ColourClassSpecific = 0;
		mrpDisplayMessage(MRP_LOCALE_Options_ClassColours_Disabled);
	end
end

function mrpOptionRelativeClick()
	if (MyRolePlay.Settings.Relative == 0) then
		MyRolePlay.Settings.Relative = 1;
		mrpDisplayMessage(MRP_LOCALE_Relative_Enabled);
	else
		MyRolePlay.Settings.Relative = 0;
		mrpDisplayMessage(MRP_LOCALE_Relative_Disabled);
	end
end
function mrpOptionColouredTooltips()
	if (MyRolePlay.Settings.Colours.Enabled == 0) then
		MyRolePlay.Settings.Colours.Enabled = 1;

		MyRolePlay.Settings.Colours.PrefixNonPvp.red = MyRolePlay.Settings.Colours.Saved.PrefixNonPvp.red;
		MyRolePlay.Settings.Colours.PrefixPvp.red = MyRolePlay.Settings.Colours.Saved.PrefixPvp.red;
		MyRolePlay.Settings.Colours.FirstnameNonPvp.red = MyRolePlay.Settings.Colours.Saved.FirstnameNonPvp.red;
		MyRolePlay.Settings.Colours.FirstnamePvp.red = MyRolePlay.Settings.Colours.Saved.FirstnamePvp.red;
		MyRolePlay.Settings.Colours.MiddlenameNonPvp.red = MyRolePlay.Settings.Colours.Saved.MiddlenameNonPvp.red;
		MyRolePlay.Settings.Colours.MiddlenamePvp.red = MyRolePlay.Settings.Colours.Saved.MiddlenamePvp.red;
		MyRolePlay.Settings.Colours.SurnameNonPvp.red = MyRolePlay.Settings.Colours.Saved.SurnameNonPvp.red;
		MyRolePlay.Settings.Colours.SurnamePvp.red = MyRolePlay.Settings.Colours.Saved.SurnamePvp.red;
		MyRolePlay.Settings.Colours.EnemyNonPvp.red = MyRolePlay.Settings.Colours.Saved.EnemyNonPvp.red;
		MyRolePlay.Settings.Colours.EnemyPvpHostile.red = MyRolePlay.Settings.Colours.Saved.EnemyPvpHostile.red;
		MyRolePlay.Settings.Colours.EnemyPvpNotHostile.red = MyRolePlay.Settings.Colours.Saved.EnemyPvpNotHostile.red;
		MyRolePlay.Settings.Colours.FactionHorde.red = MyRolePlay.Settings.Colours.Saved.FactionHorde.red;
		MyRolePlay.Settings.Colours.FactionAlliance.red = MyRolePlay.Settings.Colours.Saved.FactionAlliance.red;
		MyRolePlay.Settings.Colours.Title.red = MyRolePlay.Settings.Colours.Saved.Title.red;
		MyRolePlay.Settings.Colours.Guild.red = MyRolePlay.Settings.Colours.Saved.Guild.red;
		MyRolePlay.Settings.Colours.Level.red = MyRolePlay.Settings.Colours.Saved.Level.red;
		MyRolePlay.Settings.Colours.Class.red = MyRolePlay.Settings.Colours.Saved.Class.red;
		MyRolePlay.Settings.Colours.Race.red = MyRolePlay.Settings.Colours.Saved.Race.red;
		MyRolePlay.Settings.Colours.HouseName.red = MyRolePlay.Settings.Colours.Saved.HouseName.red;
		MyRolePlay.Settings.Colours.Roleplay.red = MyRolePlay.Settings.Colours.Saved.Roleplay.red;
		MyRolePlay.Settings.Colours.CharacterText.red = MyRolePlay.Settings.Colours.Saved.CharacterText.red;
		MyRolePlay.Settings.Colours.CharacterStat.red = MyRolePlay.Settings.Colours.Saved.CharacterStat.red;
		MyRolePlay.Settings.Colours.Nickname.red = MyRolePlay.Settings.Colours.Saved.Nickname.red;
		MyRolePlay.Settings.Colours.FriendlyPvp.red = MyRolePlay.Settings.Colours.Saved.FriendlyPvp.red;
		MyRolePlay.Settings.Colours.EnemyPvp.red = MyRolePlay.Settings.Colours.Saved.EnemyPvp.red;

		MyRolePlay.Settings.Colours.PrefixNonPvp.green = MyRolePlay.Settings.Colours.Saved.PrefixNonPvp.green;
		MyRolePlay.Settings.Colours.PrefixPvp.green = MyRolePlay.Settings.Colours.Saved.PrefixPvp.green;
		MyRolePlay.Settings.Colours.FirstnameNonPvp.green = MyRolePlay.Settings.Colours.Saved.FirstnameNonPvp.green;
		MyRolePlay.Settings.Colours.FirstnamePvp.green = MyRolePlay.Settings.Colours.Saved.FirstnamePvp.green;
		MyRolePlay.Settings.Colours.MiddlenameNonPvp.green = MyRolePlay.Settings.Colours.Saved.MiddlenameNonPvp.green;
		MyRolePlay.Settings.Colours.MiddlenamePvp.green = MyRolePlay.Settings.Colours.Saved.MiddlenamePvp.green;
		MyRolePlay.Settings.Colours.SurnameNonPvp.green = MyRolePlay.Settings.Colours.Saved.SurnameNonPvp.green;
		MyRolePlay.Settings.Colours.SurnamePvp.green = MyRolePlay.Settings.Colours.Saved.SurnamePvp.green;
		MyRolePlay.Settings.Colours.EnemyNonPvp.green = MyRolePlay.Settings.Colours.Saved.EnemyNonPvp.green;
		MyRolePlay.Settings.Colours.EnemyPvpHostile.green = MyRolePlay.Settings.Colours.Saved.EnemyPvpHostile.green;
		MyRolePlay.Settings.Colours.EnemyPvpNotHostile.green = MyRolePlay.Settings.Colours.Saved.EnemyPvpNotHostile.green;
		MyRolePlay.Settings.Colours.FactionHorde.green = MyRolePlay.Settings.Colours.Saved.FactionHorde.green;
		MyRolePlay.Settings.Colours.FactionAlliance.green = MyRolePlay.Settings.Colours.Saved.FactionAlliance.green;
		MyRolePlay.Settings.Colours.Title.green = MyRolePlay.Settings.Colours.Saved.Title.green;
		MyRolePlay.Settings.Colours.Guild.green = MyRolePlay.Settings.Colours.Saved.Guild.green;
		MyRolePlay.Settings.Colours.Level.green = MyRolePlay.Settings.Colours.Saved.Level.green;
		MyRolePlay.Settings.Colours.Class.green = MyRolePlay.Settings.Colours.Saved.Class.green;
		MyRolePlay.Settings.Colours.Race.green = MyRolePlay.Settings.Colours.Saved.Race.green;
		MyRolePlay.Settings.Colours.HouseName.green = MyRolePlay.Settings.Colours.Saved.HouseName.green;
		MyRolePlay.Settings.Colours.Roleplay.green = MyRolePlay.Settings.Colours.Saved.Roleplay.green;
		MyRolePlay.Settings.Colours.CharacterText.green = MyRolePlay.Settings.Colours.Saved.CharacterText.green;
		MyRolePlay.Settings.Colours.CharacterStat.green = MyRolePlay.Settings.Colours.Saved.CharacterStat.green;
		MyRolePlay.Settings.Colours.Nickname.green = MyRolePlay.Settings.Colours.Saved.Nickname.green;
		MyRolePlay.Settings.Colours.FriendlyPvp.green = MyRolePlay.Settings.Colours.Saved.FriendlyPvp.green;
		MyRolePlay.Settings.Colours.EnemyPvp.green = MyRolePlay.Settings.Colours.Saved.EnemyPvp.green;

		MyRolePlay.Settings.Colours.PrefixNonPvp.blue = MyRolePlay.Settings.Colours.Saved.PrefixNonPvp.blue;
		MyRolePlay.Settings.Colours.PrefixPvp.blue = MyRolePlay.Settings.Colours.Saved.PrefixPvp.blue;
		MyRolePlay.Settings.Colours.FirstnameNonPvp.blue = MyRolePlay.Settings.Colours.Saved.FirstnameNonPvp.blue;
		MyRolePlay.Settings.Colours.FirstnamePvp.blue = MyRolePlay.Settings.Colours.Saved.FirstnamePvp.blue;
		MyRolePlay.Settings.Colours.MiddlenameNonPvp.blue = MyRolePlay.Settings.Colours.Saved.MiddlenameNonPvp.blue;
		MyRolePlay.Settings.Colours.MiddlenamePvp.blue = MyRolePlay.Settings.Colours.Saved.MiddlenamePvp.blue;
		MyRolePlay.Settings.Colours.SurnameNonPvp.blue = MyRolePlay.Settings.Colours.Saved.SurnameNonPvp.blue;
		MyRolePlay.Settings.Colours.SurnamePvp.blue = MyRolePlay.Settings.Colours.Saved.SurnamePvp.blue;
		MyRolePlay.Settings.Colours.EnemyNonPvp.blue = MyRolePlay.Settings.Colours.Saved.EnemyNonPvp.blue;
		MyRolePlay.Settings.Colours.EnemyPvpHostile.blue = MyRolePlay.Settings.Colours.Saved.EnemyPvpHostile.blue;
		MyRolePlay.Settings.Colours.EnemyPvpNotHostile.blue = MyRolePlay.Settings.Colours.Saved.EnemyPvpNotHostile.blue;
		MyRolePlay.Settings.Colours.FactionHorde.blue = MyRolePlay.Settings.Colours.Saved.FactionHorde.blue;
		MyRolePlay.Settings.Colours.FactionAlliance.blue = MyRolePlay.Settings.Colours.Saved.FactionAlliance.blue;
		MyRolePlay.Settings.Colours.Title.blue = MyRolePlay.Settings.Colours.Saved.Title.blue;
		MyRolePlay.Settings.Colours.Guild.blue = MyRolePlay.Settings.Colours.Saved.Guild.blue;
		MyRolePlay.Settings.Colours.Level.blue = MyRolePlay.Settings.Colours.Saved.Level.blue;
		MyRolePlay.Settings.Colours.Class.blue = MyRolePlay.Settings.Colours.Saved.Class.blue;
		MyRolePlay.Settings.Colours.Race.blue = MyRolePlay.Settings.Colours.Saved.Race.blue;
		MyRolePlay.Settings.Colours.HouseName.blue = MyRolePlay.Settings.Colours.Saved.HouseName.blue;
		MyRolePlay.Settings.Colours.Roleplay.blue = MyRolePlay.Settings.Colours.Saved.Roleplay.blue;
		MyRolePlay.Settings.Colours.CharacterText.blue = MyRolePlay.Settings.Colours.Saved.CharacterText.blue;
		MyRolePlay.Settings.Colours.CharacterStat.blue = MyRolePlay.Settings.Colours.Saved.CharacterStat.blue;
		MyRolePlay.Settings.Colours.Nickname.blue = MyRolePlay.Settings.Colours.Saved.Nickname.blue;
		MyRolePlay.Settings.Colours.FriendlyPvp.blue = MyRolePlay.Settings.Colours.Saved.FriendlyPvp.blue;
		MyRolePlay.Settings.Colours.EnemyPvp.blue = MyRolePlay.Settings.Colours.Saved.EnemyPvp.blue;

		mrpDisplayMessage(MRP_LOCALE_Colours_Enabled);
	else
		MyRolePlay.Settings.Colours.Enabled = 0;

		MyRolePlay.Settings.Colours.Saved.PrefixNonPvp.red = MyRolePlay.Settings.Colours.PrefixNonPvp.red;
		MyRolePlay.Settings.Colours.Saved.PrefixPvp.red = MyRolePlay.Settings.Colours.PrefixPvp.red;
		MyRolePlay.Settings.Colours.Saved.FirstnameNonPvp.red = MyRolePlay.Settings.Colours.FirstnameNonPvp.red;
		MyRolePlay.Settings.Colours.Saved.FirstnamePvp.red = MyRolePlay.Settings.Colours.FirstnamePvp.red;
		MyRolePlay.Settings.Colours.Saved.MiddlenameNonPvp.red = MyRolePlay.Settings.Colours.MiddlenameNonPvp.red;
		MyRolePlay.Settings.Colours.Saved.MiddlenamePvp.red = MyRolePlay.Settings.Colours.MiddlenamePvp.red;
		MyRolePlay.Settings.Colours.Saved.SurnameNonPvp.red = MyRolePlay.Settings.Colours.SurnameNonPvp.red;
		MyRolePlay.Settings.Colours.Saved.SurnamePvp.red = MyRolePlay.Settings.Colours.SurnamePvp.red;
		MyRolePlay.Settings.Colours.Saved.EnemyNonPvp.red = MyRolePlay.Settings.Colours.EnemyNonPvp.red;
		MyRolePlay.Settings.Colours.Saved.EnemyPvpHostile.red = MyRolePlay.Settings.Colours.EnemyPvpHostile.red;
		MyRolePlay.Settings.Colours.Saved.EnemyPvpNotHostile.red = MyRolePlay.Settings.Colours.EnemyPvpNotHostile.red;
		MyRolePlay.Settings.Colours.Saved.FactionHorde.red = MyRolePlay.Settings.Colours.FactionHorde.red;
		MyRolePlay.Settings.Colours.Saved.FactionAlliance.red = MyRolePlay.Settings.Colours.FactionAlliance.red;
		MyRolePlay.Settings.Colours.Saved.Title.red = MyRolePlay.Settings.Colours.Title.red;
		MyRolePlay.Settings.Colours.Saved.Guild.red = MyRolePlay.Settings.Colours.Guild.red;
		MyRolePlay.Settings.Colours.Saved.Level.red = MyRolePlay.Settings.Colours.Level.red;
		MyRolePlay.Settings.Colours.Saved.Class.red = MyRolePlay.Settings.Colours.Class.red;
		MyRolePlay.Settings.Colours.Saved.Race.red = MyRolePlay.Settings.Colours.Race.red;
		MyRolePlay.Settings.Colours.Saved.HouseName.red = MyRolePlay.Settings.Colours.HouseName.red;
		MyRolePlay.Settings.Colours.Saved.Roleplay.red = MyRolePlay.Settings.Colours.Roleplay.red;
		MyRolePlay.Settings.Colours.Saved.CharacterText.red = MyRolePlay.Settings.Colours.CharacterText.red;
		MyRolePlay.Settings.Colours.Saved.CharacterStat.red = MyRolePlay.Settings.Colours.CharacterStat.red;
		MyRolePlay.Settings.Colours.Saved.Nickname.red = MyRolePlay.Settings.Colours.Nickname.red;
		MyRolePlay.Settings.Colours.Saved.FriendlyPvp.red = MyRolePlay.Settings.Colours.FriendlyPvp.red;
		MyRolePlay.Settings.Colours.Saved.EnemyPvp.red = MyRolePlay.Settings.Colours.EnemyPvp.red;

		MyRolePlay.Settings.Colours.Saved.PrefixNonPvp.green = MyRolePlay.Settings.Colours.PrefixNonPvp.green;
		MyRolePlay.Settings.Colours.Saved.PrefixPvp.green = MyRolePlay.Settings.Colours.PrefixPvp.green;
		MyRolePlay.Settings.Colours.Saved.FirstnameNonPvp.green = MyRolePlay.Settings.Colours.FirstnameNonPvp.green;
		MyRolePlay.Settings.Colours.Saved.FirstnamePvp.green = MyRolePlay.Settings.Colours.FirstnamePvp.green;
		MyRolePlay.Settings.Colours.Saved.MiddlenameNonPvp.green = MyRolePlay.Settings.Colours.MiddlenameNonPvp.green;
		MyRolePlay.Settings.Colours.Saved.MiddlenamePvp.green = MyRolePlay.Settings.Colours.MiddlenamePvp.green;
		MyRolePlay.Settings.Colours.Saved.SurnameNonPvp.green = MyRolePlay.Settings.Colours.SurnameNonPvp.green;
		MyRolePlay.Settings.Colours.Saved.SurnamePvp.green = MyRolePlay.Settings.Colours.SurnamePvp.green;
		MyRolePlay.Settings.Colours.Saved.EnemyNonPvp.green = MyRolePlay.Settings.Colours.EnemyNonPvp.green;
		MyRolePlay.Settings.Colours.Saved.EnemyPvpHostile.green = MyRolePlay.Settings.Colours.EnemyPvpHostile.green;
		MyRolePlay.Settings.Colours.Saved.EnemyPvpNotHostile.green = MyRolePlay.Settings.Colours.EnemyPvpNotHostile.green;
		MyRolePlay.Settings.Colours.Saved.FactionHorde.green = MyRolePlay.Settings.Colours.FactionHorde.green;
		MyRolePlay.Settings.Colours.Saved.FactionAlliance.green = MyRolePlay.Settings.Colours.FactionAlliance.green;
		MyRolePlay.Settings.Colours.Saved.Title.green = MyRolePlay.Settings.Colours.Title.green;
		MyRolePlay.Settings.Colours.Saved.Guild.green = MyRolePlay.Settings.Colours.Guild.green;
		MyRolePlay.Settings.Colours.Saved.Level.green = MyRolePlay.Settings.Colours.Level.green;
		MyRolePlay.Settings.Colours.Saved.Class.green = MyRolePlay.Settings.Colours.Class.green;
		MyRolePlay.Settings.Colours.Saved.Race.green = MyRolePlay.Settings.Colours.Race.green;
		MyRolePlay.Settings.Colours.Saved.HouseName.green = MyRolePlay.Settings.Colours.HouseName.green;
		MyRolePlay.Settings.Colours.Saved.Roleplay.green = MyRolePlay.Settings.Colours.Roleplay.green;
		MyRolePlay.Settings.Colours.Saved.CharacterText.green = MyRolePlay.Settings.Colours.CharacterText.green;
		MyRolePlay.Settings.Colours.Saved.CharacterStat.green = MyRolePlay.Settings.Colours.CharacterStat.green;
		MyRolePlay.Settings.Colours.Saved.Nickname.green = MyRolePlay.Settings.Colours.Nickname.green;
		MyRolePlay.Settings.Colours.Saved.FriendlyPvp.green = MyRolePlay.Settings.Colours.FriendlyPvp.green;
		MyRolePlay.Settings.Colours.Saved.EnemyPvp.green = MyRolePlay.Settings.Colours.EnemyPvp.green;

		MyRolePlay.Settings.Colours.Saved.PrefixNonPvp.blue = MyRolePlay.Settings.Colours.PrefixNonPvp.blue;
		MyRolePlay.Settings.Colours.Saved.PrefixPvp.blue= MyRolePlay.Settings.Colours.PrefixPvp.blue;
		MyRolePlay.Settings.Colours.Saved.FirstnameNonPvp.blue = MyRolePlay.Settings.Colours.FirstnameNonPvp.blue;
		MyRolePlay.Settings.Colours.Saved.FirstnamePvp.blue = MyRolePlay.Settings.Colours.FirstnamePvp.blue;
		MyRolePlay.Settings.Colours.Saved.MiddlenameNonPvp.blue = MyRolePlay.Settings.Colours.MiddlenameNonPvp.blue;
		MyRolePlay.Settings.Colours.Saved.MiddlenamePvp.blue = MyRolePlay.Settings.Colours.MiddlenamePvp.blue;
		MyRolePlay.Settings.Colours.Saved.SurnameNonPvp.blue = MyRolePlay.Settings.Colours.SurnameNonPvp.blue;
		MyRolePlay.Settings.Colours.Saved.SurnamePvp.blue = MyRolePlay.Settings.Colours.SurnamePvp.blue;
		MyRolePlay.Settings.Colours.Saved.EnemyNonPvp.blue = MyRolePlay.Settings.Colours.EnemyNonPvp.blue;
		MyRolePlay.Settings.Colours.Saved.EnemyPvpHostile.blue = MyRolePlay.Settings.Colours.EnemyPvpHostile.blue;
		MyRolePlay.Settings.Colours.Saved.EnemyPvpNotHostile.blue = MyRolePlay.Settings.Colours.EnemyPvpNotHostile.blue;
		MyRolePlay.Settings.Colours.Saved.FactionHorde.blue = MyRolePlay.Settings.Colours.FactionHorde.blue;
		MyRolePlay.Settings.Colours.Saved.FactionAlliance.blue = MyRolePlay.Settings.Colours.FactionAlliance.blue;
		MyRolePlay.Settings.Colours.Saved.Title.blue = MyRolePlay.Settings.Colours.Title.blue;
		MyRolePlay.Settings.Colours.Saved.Guild.blue = MyRolePlay.Settings.Colours.Guild.blue;
		MyRolePlay.Settings.Colours.Saved.Level.blue = MyRolePlay.Settings.Colours.Level.blue;
		MyRolePlay.Settings.Colours.Saved.Class.blue = MyRolePlay.Settings.Colours.Class.blue;
		MyRolePlay.Settings.Colours.Saved.Race.blue = MyRolePlay.Settings.Colours.Race.blue;
		MyRolePlay.Settings.Colours.Saved.HouseName.blue = MyRolePlay.Settings.Colours.HouseName.blue;
		MyRolePlay.Settings.Colours.Saved.Roleplay.blue = MyRolePlay.Settings.Colours.Roleplay.blue;
		MyRolePlay.Settings.Colours.Saved.CharacterText.blue = MyRolePlay.Settings.Colours.CharacterText.blue;
		MyRolePlay.Settings.Colours.Saved.CharacterStat.blue = MyRolePlay.Settings.Colours.CharacterStat.blue;
		MyRolePlay.Settings.Colours.Saved.Nickname.blue = MyRolePlay.Settings.Colours.Nickname.blue;
		MyRolePlay.Settings.Colours.Saved.FriendlyPvp.blue = MyRolePlay.Settings.Colours.FriendlyPvp.blue;
		MyRolePlay.Settings.Colours.Saved.EnemyPvp.blue = MyRolePlay.Settings.Colours.EnemyPvp.blue;

		MyRolePlay.Settings.Colours.PrefixNonPvp.red = mrpColours.PrefixNonPvp.red;
		MyRolePlay.Settings.Colours.PrefixPvp.red = mrpColours.PrefixPvp.red;
		MyRolePlay.Settings.Colours.FirstnameNonPvp.red = mrpColours.FirstnameNonPvp.red;
		MyRolePlay.Settings.Colours.FirstnamePvp.red = mrpColours.FirstnamePvp.red;
		MyRolePlay.Settings.Colours.MiddlenameNonPvp.red = mrpColours.MiddlenameNonPvp.red;
		MyRolePlay.Settings.Colours.MiddlenamePvp.red = mrpColours.MiddlenamePvp.red;
		MyRolePlay.Settings.Colours.SurnameNonPvp.red = mrpColours.SurnameNonPvp.red;
		MyRolePlay.Settings.Colours.SurnamePvp.red = mrpColours.SurnamePvp.red;
		MyRolePlay.Settings.Colours.EnemyNonPvp.red = mrpColours.EnemyNonPvp.red;
		MyRolePlay.Settings.Colours.EnemyPvpHostile.red = mrpColours.EnemyPvpHostile.red;
		MyRolePlay.Settings.Colours.EnemyPvpNotHostile.red = mrpColours.EnemyPvpNotHostile.red;
		MyRolePlay.Settings.Colours.FactionHorde.red = mrpColours.FactionHorde.red;
		MyRolePlay.Settings.Colours.FactionAlliance.red = mrpColours.FactionAlliance.red;
		MyRolePlay.Settings.Colours.Title.red = mrpColours.Title.red;
		MyRolePlay.Settings.Colours.Guild.red = mrpColours.Guild.red;
		MyRolePlay.Settings.Colours.Level.red = mrpColours.Level.red;
		MyRolePlay.Settings.Colours.Class.red = mrpColours.Class.red;
		MyRolePlay.Settings.Colours.Race.red = mrpColours.Race.red;
		MyRolePlay.Settings.Colours.HouseName.red = mrpColours.HouseName.red;
		MyRolePlay.Settings.Colours.Roleplay.red = mrpColours.Roleplay.red;
		MyRolePlay.Settings.Colours.CharacterText.red = mrpColours.CharacterText.red;
		MyRolePlay.Settings.Colours.CharacterStat.red = mrpColours.CharacterStat.red;
		MyRolePlay.Settings.Colours.Nickname.red = mrpColours.Nickname.red;
		MyRolePlay.Settings.Colours.FriendlyPvp.red = mrpColours.FriendlyPvp.red;
		MyRolePlay.Settings.Colours.EnemyPvp.red = mrpColours.EnemyPvp.red;

		MyRolePlay.Settings.Colours.PrefixNonPvp.green = mrpColours.PrefixNonPvp.green;
		MyRolePlay.Settings.Colours.PrefixPvp.green = mrpColours.PrefixPvp.green;
		MyRolePlay.Settings.Colours.FirstnameNonPvp.green = mrpColours.FirstnameNonPvp.green;
		MyRolePlay.Settings.Colours.FirstnamePvp.green = mrpColours.FirstnamePvp.green;
		MyRolePlay.Settings.Colours.MiddlenameNonPvp.green = mrpColours.MiddlenameNonPvp.green;
		MyRolePlay.Settings.Colours.MiddlenamePvp.green = mrpColours.MiddlenamePvp.green;
		MyRolePlay.Settings.Colours.SurnameNonPvp.green = mrpColours.SurnameNonPvp.green;
		MyRolePlay.Settings.Colours.SurnamePvp.green = mrpColours.SurnamePvp.green;
		MyRolePlay.Settings.Colours.EnemyNonPvp.green = mrpColours.EnemyNonPvp.green;
		MyRolePlay.Settings.Colours.EnemyPvpHostile.green = mrpColours.EnemyPvpHostile.green;
		MyRolePlay.Settings.Colours.EnemyPvpNotHostile.green = mrpColours.EnemyPvpNotHostile.green;
		MyRolePlay.Settings.Colours.FactionHorde.green = mrpColours.FactionHorde.green;
		MyRolePlay.Settings.Colours.FactionAlliance.green = mrpColours.FactionAlliance.green;
		MyRolePlay.Settings.Colours.Title.green = mrpColours.Title.green;
		MyRolePlay.Settings.Colours.Guild.green = mrpColours.Guild.green;
		MyRolePlay.Settings.Colours.Level.green = mrpColours.Level.green;
		MyRolePlay.Settings.Colours.Class.green = mrpColours.Class.green;
		MyRolePlay.Settings.Colours.Race.green = mrpColours.Race.green;
		MyRolePlay.Settings.Colours.HouseName.green = mrpColours.HouseName.green;
		MyRolePlay.Settings.Colours.Roleplay.green = mrpColours.Roleplay.green;
		MyRolePlay.Settings.Colours.CharacterText.green = mrpColours.CharacterText.green;
		MyRolePlay.Settings.Colours.CharacterStat.green = mrpColours.CharacterStat.green;
		MyRolePlay.Settings.Colours.Nickname.green = mrpColours.Nickname.green;
		MyRolePlay.Settings.Colours.FriendlyPvp.green = mrpColours.FriendlyPvp.green;
		MyRolePlay.Settings.Colours.EnemyPvp.green = mrpColours.EnemyPvp.green;

		MyRolePlay.Settings.Colours.PrefixNonPvp.blue = mrpColours.PrefixNonPvp.blue;
		MyRolePlay.Settings.Colours.PrefixPvp.blue = mrpColours.PrefixPvp.blue;
		MyRolePlay.Settings.Colours.FirstnameNonPvp.blue = mrpColours.FirstnameNonPvp.blue;
		MyRolePlay.Settings.Colours.FirstnamePvp.blue = mrpColours.FirstnamePvp.blue;
		MyRolePlay.Settings.Colours.MiddlenameNonPvp.blue = mrpColours.MiddlenameNonPvp.blue;
		MyRolePlay.Settings.Colours.MiddlenamePvp.blue = mrpColours.MiddlenamePvp.blue;
		MyRolePlay.Settings.Colours.SurnameNonPvp.blue = mrpColours.SurnameNonPvp.blue;
		MyRolePlay.Settings.Colours.SurnamePvp.blue = mrpColours.SurnamePvp.blue;
		MyRolePlay.Settings.Colours.EnemyNonPvp.blue = mrpColours.EnemyNonPvp.blue;
		MyRolePlay.Settings.Colours.EnemyPvpHostile.blue = mrpColours.EnemyPvpHostile.blue;
		MyRolePlay.Settings.Colours.EnemyPvpNotHostile.blue = mrpColours.EnemyPvpNotHostile.blue;
		MyRolePlay.Settings.Colours.FactionHorde.blue = mrpColours.FactionHorde.blue;
		MyRolePlay.Settings.Colours.FactionAlliance.blue = mrpColours.FactionAlliance.blue;
		MyRolePlay.Settings.Colours.Title.blue = mrpColours.Title.blue;
		MyRolePlay.Settings.Colours.Guild.blue = mrpColours.Guild.blue;
		MyRolePlay.Settings.Colours.Level.blue = mrpColours.Level.blue;
		MyRolePlay.Settings.Colours.Class.blue = mrpColours.Class.blue;
		MyRolePlay.Settings.Colours.Race.blue = mrpColours.Race.blue;
		MyRolePlay.Settings.Colours.HouseName.blue = mrpColours.HouseName.blue;
		MyRolePlay.Settings.Colours.Roleplay.blue = mrpColours.Roleplay.blue;
		MyRolePlay.Settings.Colours.CharacterText.blue = mrpColours.CharacterText.blue;
		MyRolePlay.Settings.Colours.CharacterStat.blue = mrpColours.CharacterStat.blue;
		MyRolePlay.Settings.Colours.Nickname.blue = mrpColours.Nickname.blue;
		MyRolePlay.Settings.Colours.FriendlyPvp.blue = mrpColours.FriendlyPvp.blue;
		MyRolePlay.Settings.Colours.EnemyPvp.blue = mrpColours.EnemyPvp.blue;

		mrpDisplayMessage(MRP_LOCALE_Colours_Disabled);
	end
end
function mrpOptionMRPTooltips()
	if (MyRolePlay.Settings.Tooltip.Enabled == 0) then
		MyRolePlay.Settings.Tooltip.Enabled = 1;
		mrpDisplayMessage(MRP_LOCALE_Tooltips_MRPStyle_Enabled);
	else
		MyRolePlay.Settings.Tooltip.Enabled = 0;
		mrpDisplayMessage(MRP_LOCALE_Tooltips_MRPStyle_Disabled);
	end
end

function mrpOptionFlagRSP()
	if (MyRolePlay.Settings.FlagRSPCompatability == 0) then
		MyRolePlay.Settings.FlagRSPCompatability = 1;
		mrpDisplayMessage(MRP_LOCALE_Options_FlagRSP_Enabled);
	else
		MyRolePlay.Settings.FlagRSPCompatability = 0;
		mrpDisplayMessage(MRP_LOCALE_Options_FlagRSP_Disabled);
	end
end

function mrpOptionPopupDescriptions()
	if (MyRolePlay.Settings.PopupDescriptions == 0) then
		MyRolePlay.Settings.PopupDescriptions = 1;
		mrpDisplayMessage(MRP_LOCALE_Options_PopupDescriptions_Enabled);
	else
		MyRolePlay.Settings.PopupDescriptions = 0;
		mrpDisplayMessage(MRP_LOCALE_Options_PopupDescriptions_Disabled);
	end
end

--[[function mrpOptionShareToggle()
	if (MyRolePlay.Settings.Share.Enabled == true) then
		MyRolePlay.Settings.Share.Enabled = false;
		mrpDisplayMessage(MRP_LOCALE_Sharing_Disabled);
	else
		MyRolePlay.Settings.Share.Enabled = true;
		mrpDisplayMessage(MRP_LOCALE_Sharing_Enabled);
		mrpOptionSharePrefixAlways:Enable();
		mrpOptionSharePrefixPrompt:Enable();
		mrpOptionSharePrefixNever:Enable();
		mrpOptionShareFirstNameAlways:Enable();
		mrpOptionShareFirstNamePrompt:Enable();
		mrpOptionShareFirstNameNever:Enable();
		mrpOptionShareMiddleNameAlways:Enable();
		mrpOptionShareMiddleNamePrompt:Enable();
		mrpOptionShareMiddleNameNever:Enable();
		mrpOptionShareSurnameAlways:Enable();
		mrpOptionShareSurnamePrompt:Enable();
		mrpOptionShareSurnameNever:Enable();
		mrpOptionShareTitleAlways:Enable();
		mrpOptionShareTitlePrompt:Enable();
		mrpOptionShareTitleNever:Enable();
		mrpOptionShareNicknameAlways:Enable();
		mrpOptionShareNicknamePrompt:Enable();
		mrpOptionShareNicknameNever:Enable();
		mrpOptionShareHouseNameAlways:Enable();
		mrpOptionShareHouseNamePrompt:Enable();
		mrpOptionShareHouseNameNever:Enable();
		mrpOptionShareGuildAlways:Enable();
		mrpOptionShareGuildPrompt:Enable();
		mrpOptionShareGuildNever:Enable();
		mrpOptionShareEyeColourAlways:Enable();
		mrpOptionShareEyeColourPrompt:Enable();
		mrpOptionShareEyeColourNever:Enable();
		mrpOptionShareHeightAlways:Enable();
		mrpOptionShareHeightPrompt:Enable();
		mrpOptionShareHeightNever:Enable();
		mrpOptionShareWeightAlways:Enable();
		mrpOptionShareWeightPrompt:Enable();
		mrpOptionShareWeightNever:Enable();
		mrpOptionShareHomeCityAlways:Enable();
		mrpOptionShareHomeCityPrompt:Enable();
		mrpOptionShareHomeCityNever:Enable();
		mrpOptionShareBirthCityAlways:Enable();
		mrpOptionShareBirthCityPrompt:Enable();
		mrpOptionShareBirthCityNever:Enable();
		mrpOptionShareMottoAlways:Enable();
		mrpOptionShareMottoPrompt:Enable();
		mrpOptionShareMottoNever:Enable();
		mrpOptionShareHistoryAlways:Enable();
		mrpOptionShareHistoryPrompt:Enable();
		mrpOptionShareHistoryNever:Enable();
		mrpOptionShareEmotionAlways:Enable();
		mrpOptionShareEmotionPrompt:Enable();
		mrpOptionShareEmotionNever:Enable();
	end
end

function mrpToggleShareAlwaysPrefix()
	if (MyRolePlay.Settings.Share.PrefixEnabled == MRP_ALWAYS_ALLOW) then
		mrpOptionSharePrefixAlways:SetChecked(1);
		mrpOptionSharePrefixPrompt:SetChecked(nil);
		mrpOptionSharePrefixNever:SetChecked(nil);
	else
		MyRolePlay.Settings.Share.PrefixEnabled = MRP_ALWAYS_ALLOW;
		mrpOptionSharePrefixAlways:SetChecked(1);
		mrpOptionSharePrefixPrompt:SetChecked(nil);
		mrpOptionSharePrefixNever:SetChecked(nil);
	end
	
end
function mrpToggleShareNeverPrefix()
	if (MyRolePlay.Settings.Share.PrefixEnabled == MRP_ALWAYS_DECLINE) then
		mrpOptionSharePrefixAlways:SetChecked(nil);
		mrpOptionSharePrefixPrompt:SetChecked(nil);
		mrpOptionSharePrefixNever:SetChecked(1);
	else
	MyRolePlay.Settings.Share.PrefixEnabled = MRP_ALWAYS_DECLINE;
		mrpOptionSharePrefixAlways:SetChecked(nil);
		mrpOptionSharePrefixPrompt:SetChecked(nil);
		mrpOptionSharePrefixNever:SetChecked(1);
	end
	
end
function mrpToggleSharePromptPrefix()
	if (MyRolePlay.Settings.Share.PrefixEnabled == MRP_PROMPT) then
		mrpOptionSharePrefixAlways:SetChecked(nil);
		mrpOptionSharePrefixPrompt:SetChecked(1);
		mrpOptionSharePrefixNever:SetChecked(nil);
	else
		MyRolePlay.Settings.Share.PrefixEnabled = MRP_PROMPT;
		mrpOptionSharePrefixAlways:SetChecked(nil);
		mrpOptionSharePrefixPrompt:SetChecked(1);
		mrpOptionSharePrefixNever:SetChecked(nil);
	end
	
end

function mrpToggleShareAlwaysFirstName()
	if (MyRolePlay.Settings.Share.FirstnameEnabled == MRP_ALWAYS_ALLOW) then
		mrpOptionShareFirstNameAlways:SetChecked(1);
		mrpOptionShareFirstNamePrompt:SetChecked(nil);
		mrpOptionShareFirstNameNever:SetChecked(nil);
	else
		MyRolePlay.Settings.Share.FirstnameEnabled = MRP_ALWAYS_ALLOW;
		mrpOptionShareFirstNameAlways:SetChecked(1);
		mrpOptionShareFirstNamePrompt:SetChecked(nil);
		mrpOptionShareFirstNameNever:SetChecked(nil);
	end
	
end
function mrpToggleShareNeverFirstName()
	if (MyRolePlay.Settings.Share.FirstnameEnabled == MRP_ALWAYS_DECLINE) then
		mrpOptionShareFirstNameAlways:SetChecked(nil);
		mrpOptionShareFirstNamePrompt:SetChecked(nil);
		mrpOptionShareFirstNameNever:SetChecked(1);
	else
		MyRolePlay.Settings.Share.FirstnameEnabled = MRP_ALWAYS_DECLINE;
		mrpOptionShareFirstNameAlways:SetChecked(nil);
		mrpOptionShareFirstNamePrompt:SetChecked(nil);
		mrpOptionShareFirstNameNever:SetChecked(1);
	end
	
end
function mrpToggleSharePromptFirstName()
	if (MyRolePlay.Settings.Share.FirstnameEnabled == MRP_PROMPT) then
		mrpOptionShareFirstNameAlways:SetChecked(nil);
		mrpOptionShareFirstNamePrompt:SetChecked(1);
		mrpOptionShareFirstNameNever:SetChecked(nil);
	else
		MyRolePlay.Settings.Share.FirstnameEnabled = MRP_PROMPT;
		mrpOptionShareFirstNameAlways:SetChecked(nil);
		mrpOptionShareFirstNamePrompt:SetChecked(1);
		mrpOptionShareFirstNameNever:SetChecked(nil);
	end
	
end

function mrpToggleShareAlwaysMiddleName()
	if (MyRolePlay.Settings.Share.MiddlenameEnabled == MRP_ALWAYS_ALLOW) then
		mrpOptionShareMiddleNameAlways:SetChecked(1);
		mrpOptionShareMiddleNamePrompt:SetChecked(nil);
		mrpOptionShareMiddleNameNever:SetChecked(nil);
	else
		MyRolePlay.Settings.Share.MiddlenameEnabled = MRP_ALWAYS_ALLOW;
		mrpOptionShareMiddleNameAlways:SetChecked(1);
		mrpOptionShareMiddleNamePrompt:SetChecked(nil);
		mrpOptionShareMiddleNameNever:SetChecked(nil);
	end
	
end
function mrpToggleShareNeverMiddleName()
	if (MyRolePlay.Settings.Share.MiddlenameEnabled == MRP_ALWAYS_DECLINE) then
		mrpOptionShareMiddleNameAlways:SetChecked(nil);
		mrpOptionShareMiddleNamePrompt:SetChecked(nil);
		mrpOptionShareMiddleNameNever:SetChecked(1);
	else
		MyRolePlay.Settings.Share.MiddlenameEnabled = MRP_ALWAYS_DECLINE;
		mrpOptionShareMiddleNameAlways:SetChecked(nil);
		mrpOptionShareMiddleNamePrompt:SetChecked(nil);
		mrpOptionShareMiddleNameNever:SetChecked(1);
	end
	
end
function mrpToggleSharePromptMiddleName()
	if (MyRolePlay.Settings.Share.MiddlenameEnabled == MRP_PROMPT) then
		mrpOptionShareMiddleNameAlways:SetChecked(nil);
		mrpOptionShareMiddleNamePrompt:SetChecked(1);
		mrpOptionShareMiddleNameNever:SetChecked(nil);
	else
		MyRolePlay.Settings.Share.MiddlenameEnabled = MRP_PROMPT;
		mrpOptionShareMiddleNameAlways:SetChecked(nil);
		mrpOptionShareMiddleNamePrompt:SetChecked(1);
		mrpOptionShareMiddleNameNever:SetChecked(nil);
	end
	
end

function mrpToggleShareAlwaysSurname()
	if (MyRolePlay.Settings.Share.SurnameEnabled == MRP_ALWAYS_ALLOW) then
		mrpOptionShareSurnameAlways:SetChecked(1);
		mrpOptionShareSurnamePrompt:SetChecked(nil);
		mrpOptionShareSurnameNever:SetChecked(nil);
	else
		MyRolePlay.Settings.Share.SurnameEnabled = MRP_ALWAYS_ALLOW;
		mrpOptionShareSurnameAlways:SetChecked(1);
		mrpOptionShareSurnamePrompt:SetChecked(nil);
		mrpOptionShareSurnameNever:SetChecked(nil);
	end
	
end
function mrpToggleShareNeverSurname()
	if (MyRolePlay.Settings.Share.SurnameEnabled == MRP_ALWAYS_DECLINE) then
		mrpOptionShareSurnameAlways:SetChecked(nil);
		mrpOptionShareSurnamePrompt:SetChecked(nil);
		mrpOptionShareSurnameNever:SetChecked(1);
	else
		MyRolePlay.Settings.Share.SurnameEnabled = MRP_ALWAYS_DECLINE;
		mrpOptionShareSurnameAlways:SetChecked(nil);
		mrpOptionShareSurnamePrompt:SetChecked(nil);
		mrpOptionShareSurnameNever:SetChecked(1);
	end
	
end
function mrpToggleSharePromptSurname()
	if (MyRolePlay.Settings.Share.SurnameEnabled == MRP_PROMPT) then
		mrpOptionShareSurnameAlways:SetChecked(nil);
		mrpOptionShareSurnamePrompt:SetChecked(1);
		mrpOptionShareSurnameNever:SetChecked(nil);
	else
		MyRolePlay.Settings.Share.SurnameEnabled = MRP_PROMPT;
		mrpOptionShareSurnameAlways:SetChecked(nil);
		mrpOptionShareSurnamePrompt:SetChecked(1);
		mrpOptionShareSurnameNever:SetChecked(nil);
	end
	
end

function mrpToggleShareAlwaysTitle()
	if (MyRolePlay.Settings.Share.TitleEnabled == MRP_ALWAYS_ALLOW) then
		mrpOptionShareTitleAlways:SetChecked(1);
		mrpOptionShareTitlePrompt:SetChecked(nil);
		mrpOptionShareTitleNever:SetChecked(nil);
	else
		MyRolePlay.Settings.Share.TitleEnabled = MRP_ALWAYS_ALLOW;
		mrpOptionShareTitleAlways:SetChecked(1);
		mrpOptionShareTitlePrompt:SetChecked(nil);
		mrpOptionShareTitleNever:SetChecked(nil);
	end
	
end
function mrpToggleShareNeverTitle()
	if (MyRolePlay.Settings.Share.TitleEnabled == MRP_ALWAYS_DECLINE) then
		mrpOptionShareTitleAlways:SetChecked(nil);
		mrpOptionShareTitlePrompt:SetChecked(nil);
		mrpOptionShareTitleNever:SetChecked(1);
	else
		MyRolePlay.Settings.Share.TitleEnabled = MRP_ALWAYS_DECLINE;
		mrpOptionShareTitleAlways:SetChecked(nil);
		mrpOptionShareTitlePrompt:SetChecked(nil);
		mrpOptionShareTitleNever:SetChecked(1);
	end
	
end
function mrpToggleSharePromptTitle()
	if (MyRolePlay.Settings.Share.TitleEnabled == MRP_PROMPT) then
		mrpOptionShareTitleAlways:SetChecked(nil);
		mrpOptionShareTitlePrompt:SetChecked(1);
		mrpOptionShareTitleNever:SetChecked(nil);
	else
		MyRolePlay.Settings.Share.TitleEnabled = MRP_PROMPT;
		mrpOptionShareTitleAlways:SetChecked(nil);
		mrpOptionShareTitlePrompt:SetChecked(1);
		mrpOptionShareTitleNever:SetChecked(nil);
	end
	
end

function mrpToggleShareAlwaysNickname()
	if (MyRolePlay.Settings.Share.NicknameEnabled == MRP_ALWAYS_ALLOW) then
		mrpOptionShareNicknameAlways:SetChecked(1);
		mrpOptionShareNicknamePrompt:SetChecked(nil);
		mrpOptionShareNicknameNever:SetChecked(nil);
	else
		MyRolePlay.Settings.Share.NicknameEnabled = MRP_ALWAYS_ALLOW;
		mrpOptionShareNicknameAlways:SetChecked(1);
		mrpOptionShareNicknamePrompt:SetChecked(nil);
		mrpOptionShareNicknameNever:SetChecked(nil);
	end
	
end
function mrpToggleShareNeverNickname()
	if (MyRolePlay.Settings.Share.NicknameEnabled == MRP_ALWAYS_DECLINE) then
		mrpOptionShareNicknameAlways:SetChecked(nil);
		mrpOptionShareNicknamePrompt:SetChecked(nil);
		mrpOptionShareNicknameNever:SetChecked(1);
	else
		MyRolePlay.Settings.Share.NicknameEnabled = MRP_ALWAYS_DECLINE;
		mrpOptionShareNicknameAlways:SetChecked(nil);
		mrpOptionShareNicknamePrompt:SetChecked(nil);
		mrpOptionShareNicknameNever:SetChecked(1);
	end
	
end
function mrpToggleSharePromptNickname()
	if (MyRolePlay.Settings.Share.NicknameEnabled == MRP_PROMPT) then
		mrpOptionShareNicknameAlways:SetChecked(nil);
		mrpOptionShareNicknamePrompt:SetChecked(1);
		mrpOptionShareNicknameNever:SetChecked(nil);
	else
		MyRolePlay.Settings.Share.NicknameEnabled = MRP_PROMPT;
		mrpOptionShareNicknameAlways:SetChecked(nil);
		mrpOptionShareNicknamePrompt:SetChecked(1);
		mrpOptionShareNicknameNever:SetChecked(nil);
	end
	
end

function mrpToggleShareAlwaysHouseName()
	if (MyRolePlay.Settings.Share.HousenameEnabled == MRP_ALWAYS_ALLOW) then
		mrpOptionShareHouseNameAlways:SetChecked(1);
		mrpOptionShareHouseNamePrompt:SetChecked(nil);
		mrpOptionShareHouseNameNever:SetChecked(nil);
	else
		MyRolePlay.Settings.Share.HousenameEnabled = MRP_ALWAYS_ALLOW;
		mrpOptionShareHouseNameAlways:SetChecked(1);
		mrpOptionShareHouseNamePrompt:SetChecked(nil);
		mrpOptionShareHouseNameNever:SetChecked(nil);
	end
	
end
function mrpToggleShareNeverHouseName()
	if (MyRolePlay.Settings.Share.HousenameEnabled == MRP_ALWAYS_DECLINE) then
		mrpOptionShareHouseNameAlways:SetChecked(nil);
		mrpOptionShareHouseNamePrompt:SetChecked(nil);
		mrpOptionShareHouseNameNever:SetChecked(1);
	else
		MyRolePlay.Settings.Share.HousenameEnabled = MRP_ALWAYS_DECLINE;
		mrpOptionShareHouseNameAlways:SetChecked(nil);
		mrpOptionShareHouseNamePrompt:SetChecked(nil);
		mrpOptionShareHouseNameNever:SetChecked(1);
	end
	
end
function mrpToggleSharePromptHouseName()
	if (MyRolePlay.Settings.Share.HousenameEnabled == MRP_PROMPT) then
		mrpOptionShareHouseNameAlways:SetChecked(nil);
		mrpOptionShareHouseNamePrompt:SetChecked(1);
		mrpOptionShareHouseNameNever:SetChecked(nil);
	else
		MyRolePlay.Settings.Share.HousenameEnabled = MRP_PROMPT;
		mrpOptionShareHouseNameAlways:SetChecked(nil);
		mrpOptionShareHouseNamePrompt:SetChecked(1);
		mrpOptionShareHouseNameNever:SetChecked(nil);
	end
	
end

function mrpToggleShareAlwaysGuild()
	if (MyRolePlay.Settings.Share.GuildEnabled == MRP_ALWAYS_ALLOW) then
		mrpOptionShareGuildAlways:SetChecked(1);
		mrpOptionShareGuildPrompt:SetChecked(nil);
		mrpOptionShareGuildNever:SetChecked(nil);
	else
		MyRolePlay.Settings.Share.GuildEnabled = MRP_ALWAYS_ALLOW;
		mrpOptionShareGuildAlways:SetChecked(1);
		mrpOptionShareGuildPrompt:SetChecked(nil);
		mrpOptionShareGuildNever:SetChecked(nil);
	end
	
end
function mrpToggleShareNeverGuild()
	if (MyRolePlay.Settings.Share.GuildEnabled == MRP_ALWAYS_DECLINE) then
		mrpOptionShareGuildAlways:SetChecked(nil);
		mrpOptionShareGuildPrompt:SetChecked(nil);
		mrpOptionShareGuildNever:SetChecked(1);
	else
		MyRolePlay.Settings.Share.GuildEnabled = MRP_ALWAYS_DECLINE;
		mrpOptionShareGuildAlways:SetChecked(nil);
		mrpOptionShareGuildPrompt:SetChecked(nil);
		mrpOptionShareGuildNever:SetChecked(1);
	end
	
end
function mrpToggleSharePromptGuild()
	if (MyRolePlay.Settings.Share.GuildEnabled == MRP_PROMPT) then
		mrpOptionShareGuildAlways:SetChecked(nil);
		mrpOptionShareGuildPrompt:SetChecked(1);
		mrpOptionShareGuildNever:SetChecked(nil);
	else
		MyRolePlay.Settings.Share.GuildEnabled = MRP_PROMPT;
		mrpOptionShareGuildAlways:SetChecked(nil);
		mrpOptionShareGuildPrompt:SetChecked(1);
		mrpOptionShareGuildNever:SetChecked(nil);
	end
	
end

function mrpToggleShareAlwaysEyeColour()
	if (MyRolePlay.Settings.Share.EyeColourEnabled == MRP_ALWAYS_ALLOW) then
		mrpOptionShareEyeColourAlways:SetChecked(1);
		mrpOptionShareEyeColourPrompt:SetChecked(nil);
		mrpOptionShareEyeColourNever:SetChecked(nil);
	else
		MyRolePlay.Settings.Share.EyeColourEnabled = MRP_ALWAYS_ALLOW;
		mrpOptionShareEyeColourAlways:SetChecked(1);
		mrpOptionShareEyeColourPrompt:SetChecked(nil);
		mrpOptionShareEyeColourNever:SetChecked(nil);
	end
	
end
function mrpToggleShareNeverEyeColour()
	if (MyRolePlay.Settings.Share.EyeColourEnabled == MRP_ALWAYS_DECLINE) then
		mrpOptionShareEyeColourAlways:SetChecked(nil);
		mrpOptionShareEyeColourPrompt:SetChecked(nil);
		mrpOptionShareEyeColourNever:SetChecked(1);
	else
		MyRolePlay.Settings.Share.EyeColourEnabled = MRP_ALWAYS_DECLINE;
		mrpOptionShareEyeColourAlways:SetChecked(nil);
		mrpOptionShareEyeColourPrompt:SetChecked(nil);
		mrpOptionShareEyeColourNever:SetChecked(1);
	end
	
end
function mrpToggleSharePromptEyeColour()
	if (MyRolePlay.Settings.Share.EyeColourEnabled == MRP_PROMPT) then
		mrpOptionShareEyeColourAlways:SetChecked(nil);
		mrpOptionShareEyeColourPrompt:SetChecked(1);
		mrpOptionShareEyeColourNever:SetChecked(nil);
	else
		MyRolePlay.Settings.Share.EyeColourEnabled = MRP_PROMPT;
		mrpOptionShareEyeColourAlways:SetChecked(nil);
		mrpOptionShareEyeColourPrompt:SetChecked(1);
		mrpOptionShareEyeColourNever:SetChecked(nil);
	end
	
end

function mrpToggleShareAlwaysWeight()
	if (MyRolePlay.Settings.Share.WeightEnabled == MRP_ALWAYS_ALLOW) then
		mrpOptionShareWeightAlways:SetChecked(1);
		mrpOptionShareWeightPrompt:SetChecked(nil);
		mrpOptionShareWeightNever:SetChecked(nil);
	else
		MyRolePlay.Settings.Share.WeightEnabled = MRP_ALWAYS_ALLOW;
		mrpOptionShareWeightAlways:SetChecked(1);
		mrpOptionShareWeightPrompt:SetChecked(nil);
		mrpOptionShareWeightNever:SetChecked(nil);
	end
	
end
function mrpToggleShareNeverWeight()
	if (MyRolePlay.Settings.Share.WeightEnabled == MRP_ALWAYS_DECLINE) then
		mrpOptionShareWeightAlways:SetChecked(nil);
		mrpOptionShareWeightPrompt:SetChecked(nil);
		mrpOptionShareWeightNever:SetChecked(1);
	else
		MyRolePlay.Settings.Share.WeightEnabled = MRP_ALWAYS_DECLINE;
		mrpOptionShareWeightAlways:SetChecked(nil);
		mrpOptionShareWeightPrompt:SetChecked(nil);
		mrpOptionShareWeightNever:SetChecked(1);
	end
	
end
function mrpToggleSharePromptWeight()
	if (MyRolePlay.Settings.Share.WeightEnabled == MRP_PROMPT) then
		mrpOptionShareWeightAlways:SetChecked(nil);
		mrpOptionShareWeightPrompt:SetChecked(1);
		mrpOptionShareWeightNever:SetChecked(nil);
	else
		MyRolePlay.Settings.Share.WeightEnabled = MRP_PROMPT;
		mrpOptionShareWeightAlways:SetChecked(nil);
		mrpOptionShareWeightPrompt:SetChecked(1);
		mrpOptionShareWeightNever:SetChecked(nil);
	end
	
end

function mrpToggleShareAlwaysHeight()
	if (MyRolePlay.Settings.Share.HeightEnabled == MRP_ALWAYS_ALLOW) then
		mrpOptionShareHeightAlways:SetChecked(1);
		mrpOptionShareHeightPrompt:SetChecked(nil);
		mrpOptionShareHeightNever:SetChecked(nil);
	else
		MyRolePlay.Settings.Share.HeightEnabled = MRP_ALWAYS_ALLOW;
		mrpOptionShareHeightAlways:SetChecked(1);
		mrpOptionShareHeightPrompt:SetChecked(nil);
		mrpOptionShareHeightNever:SetChecked(nil);
	end
	
end
function mrpToggleShareNeverHeight()
	if (MyRolePlay.Settings.Share.HeightEnabled == MRP_ALWAYS_DECLINE) then
		mrpOptionShareHeightAlways:SetChecked(nil);
		mrpOptionShareHeightPrompt:SetChecked(nil);
		mrpOptionShareHeightNever:SetChecked(1);
	else
		MyRolePlay.Settings.Share.HeightEnabled = MRP_ALWAYS_DECLINE;
		mrpOptionShareHeightAlways:SetChecked(nil);
		mrpOptionShareHeightPrompt:SetChecked(nil);
		mrpOptionShareHeightNever:SetChecked(1);
	end
	
end
function mrpToggleSharePromptHeight()
	if (MyRolePlay.Settings.Share.HeightEnabled == MRP_PROMPT) then
		mrpOptionShareHeightAlways:SetChecked(nil);
		mrpOptionShareHeightPrompt:SetChecked(1);
		mrpOptionShareHeightNever:SetChecked(nil);
	else
		MyRolePlay.Settings.Share.HeightEnabled = MRP_PROMPT;
		mrpOptionShareHeightAlways:SetChecked(nil);
		mrpOptionShareHeightPrompt:SetChecked(1);
		mrpOptionShareHeightNever:SetChecked(nil);
	end
	
end

function mrpToggleShareAlwaysEmotion()
	if (MyRolePlay.Settings.Share.CurrentEmotionEnabled == MRP_ALWAYS_ALLOW) then
		mrpOptionShareEmotionAlways:SetChecked(1);
		mrpOptionShareEmotionPrompt:SetChecked(nil);
		mrpOptionShareEmotionNever:SetChecked(nil);
	else
		MyRolePlay.Settings.Share.CurrentEmotionEnabled = MRP_ALWAYS_ALLOW;
		mrpOptionShareEmotionAlways:SetChecked(1);
		mrpOptionShareEmotionPrompt:SetChecked(nil);
		mrpOptionShareEmotionNever:SetChecked(nil);
	end
	
end
function mrpToggleShareNeverEmotion()
	if (MyRolePlay.Settings.Share.CurrentEmotionEnabled == MRP_ALWAYS_DECLINE) then
		mrpOptionShareEmotionAlways:SetChecked(nil);
		mrpOptionShareEmotionPrompt:SetChecked(nil);
		mrpOptionShareEmotionNever:SetChecked(1);
	else
		MyRolePlay.Settings.Share.CurrentEmotionEnabled = MRP_ALWAYS_DECLINE;
		mrpOptionShareEmotionAlways:SetChecked(nil);
		mrpOptionShareEmotionPrompt:SetChecked(nil);
		mrpOptionShareEmotionNever:SetChecked(1);
	end
	
end
function mrpToggleSharePromptEmotion()
	if (MyRolePlay.Settings.Share.CurrentEmotionEnabled == MRP_PROMPT) then
		mrpOptionShareEmotionAlways:SetChecked(nil);
		mrpOptionShareEmotionPrompt:SetChecked(1);
		mrpOptionShareEmotionNever:SetChecked(nil);
	else
		MyRolePlay.Settings.Share.CurrentEmotionEnabled = MRP_PROMPT;
		mrpOptionShareEmotionAlways:SetChecked(nil);
		mrpOptionShareEmotionPrompt:SetChecked(1);
		mrpOptionShareEmotionNever:SetChecked(nil);
	end
	
end

function mrpToggleShareAlwaysHomeCity()
	if (MyRolePlay.Settings.Share.HomeCityEnabled == MRP_ALWAYS_ALLOW) then
		mrpOptionShareHomeCityAlways:SetChecked(1);
		mrpOptionShareHomeCityPrompt:SetChecked(nil);
		mrpOptionShareHomeCityNever:SetChecked(nil);
	else
		MyRolePlay.Settings.Share.HomeCityEnabled = MRP_ALWAYS_ALLOW;
		mrpOptionShareHomeCityAlways:SetChecked(1);
		mrpOptionShareHomeCityPrompt:SetChecked(nil);
		mrpOptionShareHomeCityNever:SetChecked(nil);
	end
	
end
function mrpToggleShareNeverHomeCity()
	if (MyRolePlay.Settings.Share.HomeCityEnabled == MRP_ALWAYS_DECLINE) then
		mrpOptionShareHomeCityAlways:SetChecked(nil);
		mrpOptionShareHomeCityPrompt:SetChecked(nil);
		mrpOptionShareHomeCityNever:SetChecked(1);
	else
		MyRolePlay.Settings.Share.HomeCityEnabled = MRP_ALWAYS_DECLINE;
		mrpOptionShareHomeCityAlways:SetChecked(nil);
		mrpOptionShareHomeCityPrompt:SetChecked(nil);
		mrpOptionShareHomeCityNever:SetChecked(1);
	end
	
end
function mrpToggleSharePromptHomeCity()
	if (MyRolePlay.Settings.Share.HomeCityEnabled == MRP_PROMPT) then
		mrpOptionShareHomeCityAlways:SetChecked(nil);
		mrpOptionShareHomeCityPrompt:SetChecked(1);
		mrpOptionShareHomeCityNever:SetChecked(nil);
	else
		MyRolePlay.Settings.Share.HomeCityEnabled = MRP_PROMPT;
		mrpOptionShareHomeCityAlways:SetChecked(nil);
		mrpOptionShareHomeCityPrompt:SetChecked(1);
		mrpOptionShareHomeCityNever:SetChecked(nil);
	end
	
end

function mrpToggleShareAlwaysBirthCity()
	if (MyRolePlay.Settings.Share.BirthCityEnabled == MRP_ALWAYS_ALLOW) then
		mrpOptionShareBirthCityAlways:SetChecked(1);
		mrpOptionShareBirthCityPrompt:SetChecked(nil);
		mrpOptionShareBirthCityNever:SetChecked(nil);
	else
		MyRolePlay.Settings.Share.BirthCityEnabled = MRP_ALWAYS_ALLOW;
		mrpOptionShareBirthCityAlways:SetChecked(1);
		mrpOptionShareBirthCityPrompt:SetChecked(nil);
		mrpOptionShareBirthCityNever:SetChecked(nil);
	end
	
end
function mrpToggleShareNeverBirthCity()
	if (MyRolePlay.Settings.Share.BirthCityEnabled == MRP_ALWAYS_DECLINE) then
		mrpOptionShareBirthCityAlways:SetChecked(nil);
		mrpOptionShareBirthCityPrompt:SetChecked(nil);
		mrpOptionShareBirthCityNever:SetChecked(1);
	else
		MyRolePlay.Settings.Share.BirthCityEnabled = MRP_ALWAYS_DECLINE;
		mrpOptionShareBirthCityAlways:SetChecked(nil);
		mrpOptionShareBirthCityPrompt:SetChecked(nil);
		mrpOptionShareBirthCityNever:SetChecked(1);
	end
	
end
function mrpToggleSharePromptBirthCity()
	if (MyRolePlay.Settings.Share.BirthCityEnabled == MRP_PROMPT) then
		mrpOptionShareBirthCityAlways:SetChecked(nil);
		mrpOptionShareBirthCityPrompt:SetChecked(1);
		mrpOptionShareBirthCityNever:SetChecked(nil);
	else
		MyRolePlay.Settings.Share.BirthCityEnabled = MRP_PROMPT;
		mrpOptionShareBirthCityAlways:SetChecked(nil);
		mrpOptionShareBirthCityPrompt:SetChecked(1);
		mrpOptionShareBirthCityNever:SetChecked(nil);
	end
	
end

function mrpToggleShareAlwaysMotto()
	if (MyRolePlay.Settings.Share.MottoEnabled == MRP_ALWAYS_ALLOW) then
		mrpOptionShareMottoAlways:SetChecked(1);
		mrpOptionShareMottoPrompt:SetChecked(nil);
		mrpOptionShareMottoNever:SetChecked(nil);
	else
		MyRolePlay.Settings.Share.MottoEnabled = MRP_ALWAYS_ALLOW;
		mrpOptionShareMottoAlways:SetChecked(1);
		mrpOptionShareMottoPrompt:SetChecked(nil);
		mrpOptionShareMottoNever:SetChecked(nil);
	end
	
end
function mrpToggleShareNeverMotto()
	if (MyRolePlay.Settings.Share.MottoEnabled == MRP_ALWAYS_DECLINE) then
		mrpOptionShareMottoAlways:SetChecked(nil);
		mrpOptionShareMottoPrompt:SetChecked(nil);
		mrpOptionShareMottoNever:SetChecked(1);
	else
		MyRolePlay.Settings.Share.MottoEnabled = MRP_ALWAYS_DECLINE;
		mrpOptionShareMottoAlways:SetChecked(nil);
		mrpOptionShareMottoPrompt:SetChecked(nil);
		mrpOptionShareMottoNever:SetChecked(1);
	end
	
end
function mrpToggleSharePromptMotto()
	if (MyRolePlay.Settings.Share.MottoEnabled == MRP_PROMPT) then
		mrpOptionShareMottoAlways:SetChecked(nil);
		mrpOptionShareMottoPrompt:SetChecked(1);
		mrpOptionShareMottoNever:SetChecked(nil);
	else
		MyRolePlay.Settings.Share.MottoEnabled = MRP_PROMPT;
		mrpOptionShareMottoAlways:SetChecked(nil);
		mrpOptionShareMottoPrompt:SetChecked(1);
		mrpOptionShareMottoNever:SetChecked(nil);
	end
	
end

function mrpToggleShareAlwaysHistory()
	if (MyRolePlay.Settings.Share.CharacterHistory == MRP_ALWAYS_ALLOW) then
		mrpOptionShareHistoryAlways:SetChecked(1);
		mrpOptionShareHistoryPrompt:SetChecked(nil);
		mrpOptionShareHistoryNever:SetChecked(nil);
	else
		MyRolePlay.Settings.Share.CharacterHistory = MRP_ALWAYS_ALLOW;
		mrpOptionShareHistoryAlways:SetChecked(1);
		mrpOptionShareHistoryPrompt:SetChecked(nil);
		mrpOptionShareHistoryNever:SetChecked(nil);
	end
	
end
function mrpToggleShareNeverHistory()
	if (MyRolePlay.Settings.Share.CharacterHistory == MRP_ALWAYS_DECLINE) then
		mrpOptionShareHistoryAlways:SetChecked(nil);
		mrpOptionShareHistoryPrompt:SetChecked(nil);
		mrpOptionShareHistoryNever:SetChecked(1);
	else
		MyRolePlay.Settings.Share.CharacterHistory = MRP_ALWAYS_DECLINE;
		mrpOptionShareHistoryAlways:SetChecked(nil);
		mrpOptionShareHistoryPrompt:SetChecked(nil);
		mrpOptionShareHistoryNever:SetChecked(1);
	end
	
end
function mrpToggleSharePromptHistory()
	if (MyRolePlay.Settings.Share.CharacterHistory == MRP_PROMPT) then
		mrpOptionShareHistoryAlways:SetChecked(nil);
		mrpOptionShareHistoryPrompt:SetChecked(1);
		mrpOptionShareHistoryNever:SetChecked(nil);
	else
		MyRolePlay.Settings.Share.CharacterHistory = MRP_PROMPT;
		mrpOptionShareHistoryAlways:SetChecked(nil);
		mrpOptionShareHistoryPrompt:SetChecked(1);
		mrpOptionShareHistoryNever:SetChecked(nil);
	end
	
end
]]--
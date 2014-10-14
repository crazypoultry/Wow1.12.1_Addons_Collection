mrpColourEdit = 0

mrpHexStart = "|CFF";
mrpHexEnd = "|r"

mrpColours = {};

mrpColours.PrefixNonPvp = { red = 0.5, green = 0.5, blue = 1.0 };
mrpColours.PrefixPvp = { red = 0, green = 0.6, blue = 0 };
mrpColours.FirstnameNonPvp = { red = 0.5, green = 0.5, blue = 1.0 };
mrpColours.FirstnamePvp = { red = 0, green = 0.6, blue = 0 };
mrpColours.MiddlenameNonPvp = { red = 0.5, green = 0.5, blue = 1.0 };
mrpColours.MiddlenamePvp = { red = 0, green = 0.6, blue = 0 };
mrpColours.SurnameNonPvp = { red = 0.5, green = 0.5, blue = 1.0 };
mrpColours.SurnamePvp = { red = 0, green = 0.6, blue = 0 };
mrpColours.EnemyNonPvp = { red = 0.5, green = 0.5, blue = 1.0 };
mrpColours.EnemyPvpHostile = { red = 1.0, green = 0, blue = 0 };
mrpColours.EnemyPvpNotHostile = { red = 1.0, green = 1.0, blue = 0.0 };
mrpColours.FactionHorde = { red = 1.0, green = 0.0, blue = 0.0 };
mrpColours.FactionAlliance = { red = 0.3, green = 0.3, blue = 1.0 };
mrpColours.Title = { red = 1.0, green = 1.0, blue = 1.0 };
mrpColours.Guild = { red = 1.0, green = 1.0, blue = 1.0 };
mrpColours.Level = { red = 1.0, green = 1.0, blue = 0 };
mrpColours.Class = { red = 1.0, green = 1.0, blue = 0 };
mrpColours.Race = { red = 1.0, green = 1.0, blue = 0 };
mrpColours.HouseName = { red = 1.0, green = 1.0, blue = 1.0 };
mrpColours.Roleplay = { red = 1.0, green = 1.0, blue = 0.6 };
mrpColours.CharacterText = { red = 1.0, green = 1.0, blue = 1.0 };
mrpColours.CharacterStat = { red = 1.0, green = 1.0, blue = 0.6 };
mrpColours.Nickname = { red = 1.0, green = 1.0, blue = 1.0 };
mrpColours.FriendlyPvp = { red = 0, green = 0.6, blue = 0 };
mrpColours.EnemyPvp = { red = 1.0, green = 0, blue = 0 };

function mrpColourToHex(r, g, b)
	local red = string.format("%.2X", (r * 255));
	local green = string.format("%.2X", (g * 255));
	local blue = string.format("%.2X", (b * 255));

	local colour = red .. green .. blue;

	return (colour);
end


function mrpToggleColourButton_OnClick()
	if (mrpColourFrame:IsShown()) then
		mrpColourFrame:Hide();
		mrpOptionFrameOpen = 0;
	else
		mrpColourFrame:Show();
		mrpOptionFrameOpen = 1;
	end
end

function mrpColourTextSetAll()
		CharacterClassLine:SetTextColor(MyRolePlay.Settings.Colours.Class.red, MyRolePlay.Settings.Colours.Class.green, MyRolePlay.Settings.Colours.Class.blue)
		HouseLine:SetTextColor(MyRolePlay.Settings.Colours.HouseName.red, MyRolePlay.Settings.Colours.HouseName.green, MyRolePlay.Settings.Colours.HouseName.blue)
		TitleLine:SetTextColor(MyRolePlay.Settings.Colours.Title.red, MyRolePlay.Settings.Colours.Title.green, MyRolePlay.Settings.Colours.Title.blue)
		NicknameLine:SetTextColor(MyRolePlay.Settings.Colours.Nickname.red, MyRolePlay.Settings.Colours.Nickname.green, MyRolePlay.Settings.Colours.Nickname.blue)
		GuildLine:SetTextColor(MyRolePlay.Settings.Colours.Guild.red, MyRolePlay.Settings.Colours.Guild.green, MyRolePlay.Settings.Colours.Guild.blue)
		RPStatLine:SetTextColor(MyRolePlay.Settings.Colours.Roleplay.red, MyRolePlay.Settings.Colours.Roleplay.green, MyRolePlay.Settings.Colours.Roleplay.blue)
		CharTextLine:SetTextColor(MyRolePlay.Settings.Colours.CharacterText.red, MyRolePlay.Settings.Colours.CharacterText.green, MyRolePlay.Settings.Colours.CharacterText.blue)
		CharStatLine:SetTextColor(MyRolePlay.Settings.Colours.CharacterStat.red, MyRolePlay.Settings.Colours.CharacterStat.green, MyRolePlay.Settings.Colours.CharacterStat.blue)
		CharacterLevelLine:SetTextColor(MyRolePlay.Settings.Colours.Level.red, MyRolePlay.Settings.Colours.Level.green, MyRolePlay.Settings.Colours.Level.blue)
		CharacterRaceLine:SetTextColor(MyRolePlay.Settings.Colours.Race.red, MyRolePlay.Settings.Colours.Race.green, MyRolePlay.Settings.Colours.Race.blue)
		mrpColourSpecificRogueText:SetTextColor(MyRolePlay.Settings.Colours.ClassSpecific.Rogue.red, MyRolePlay.Settings.Colours.ClassSpecific.Rogue.green, MyRolePlay.Settings.Colours.ClassSpecific.Rogue.blue);
		mrpColourSpecificWarriorText:SetTextColor(MyRolePlay.Settings.Colours.ClassSpecific.Warrior.red, MyRolePlay.Settings.Colours.ClassSpecific.Warrior.green, MyRolePlay.Settings.Colours.ClassSpecific.Warrior.blue);
		mrpColourSpecificPriestText:SetTextColor(MyRolePlay.Settings.Colours.ClassSpecific.Priest.red, MyRolePlay.Settings.Colours.ClassSpecific.Priest.green, MyRolePlay.Settings.Colours.ClassSpecific.Priest.blue);
		mrpColourSpecificMageText:SetTextColor(MyRolePlay.Settings.Colours.ClassSpecific.Mage.red, MyRolePlay.Settings.Colours.ClassSpecific.Mage.green, MyRolePlay.Settings.Colours.ClassSpecific.Mage.blue);
		mrpColourSpecificShamanText:SetTextColor(MyRolePlay.Settings.Colours.ClassSpecific.Shaman.red, MyRolePlay.Settings.Colours.ClassSpecific.Shaman.green, MyRolePlay.Settings.Colours.ClassSpecific.Shaman.blue);
		mrpColourSpecificPaladinText:SetTextColor(MyRolePlay.Settings.Colours.ClassSpecific.Paladin.red, MyRolePlay.Settings.Colours.ClassSpecific.Paladin.green, MyRolePlay.Settings.Colours.ClassSpecific.Paladin.blue);
		mrpColourSpecificDruidText:SetTextColor(MyRolePlay.Settings.Colours.ClassSpecific.Druid.red, MyRolePlay.Settings.Colours.ClassSpecific.Druid.green, MyRolePlay.Settings.Colours.ClassSpecific.Druid.blue);
		mrpColourSpecificWarlockText:SetTextColor(MyRolePlay.Settings.Colours.ClassSpecific.Warlock.red, MyRolePlay.Settings.Colours.ClassSpecific.Warlock.green, MyRolePlay.Settings.Colours.ClassSpecific.Warlock.blue);
		mrpColourSpecificHunterText:SetTextColor(MyRolePlay.Settings.Colours.ClassSpecific.Hunter.red, MyRolePlay.Settings.Colours.ClassSpecific.Hunter.green, MyRolePlay.Settings.Colours.ClassSpecific.Hunter.blue);

end



function mrpColourClass()
  MyRolePlay.Settings.Colours.Class.red, MyRolePlay.Settings.Colours.Class.green, MyRolePlay.Settings.Colours.Class.blue = ColorPickerFrame:GetColorRGB();
  CharacterClassLine:SetTextColor(MyRolePlay.Settings.Colours.Class.red, MyRolePlay.Settings.Colours.Class.green, MyRolePlay.Settings.Colours.Class.blue);
  mrpColourEdit = 0;
end

function mrpColourSelectClass()
	mrpTempRed = MyRolePlay.Settings.Colours.Class.red;
	mrpTempGreen = MyRolePlay.Settings.Colours.Class.green;
	mrpTempBlue = MyRolePlay.Settings.Colours.Class.blue;
	ColorPickerFrame:Show();
	ColorPickerFrame:SetColorRGB(MyRolePlay.Settings.Colours.Class.red, MyRolePlay.Settings.Colours.Class.green, MyRolePlay.Settings.Colours.Class.blue);
end


function mrpColourClassCancel()
  MyRolePlay.Settings.Colours.Class.red = mrpTempRed;
  MyRolePlay.Settings.Colours.Class.green = mrpTempGreen;
  MyRolePlay.Settings.Colours.Class.blue = mrpTempBlue;
  CharacterClassLine:SetTextColor(MyRolePlay.Settings.Colours.Class.red, MyRolePlay.Settings.Colours.Class.green, MyRolePlay.Settings.Colours.Class.blue);
  mrpColourEdit = 0;
end

----------------------------------------------------------

function mrpColourHouse()
  MyRolePlay.Settings.Colours.HouseName.red, MyRolePlay.Settings.Colours.HouseName.green, MyRolePlay.Settings.Colours.HouseName.blue = ColorPickerFrame:GetColorRGB();
  HouseLine:SetTextColor(MyRolePlay.Settings.Colours.HouseName.red, MyRolePlay.Settings.Colours.HouseName.green, MyRolePlay.Settings.Colours.HouseName.blue);
  mrpColourEdit = 0;
end
function mrpColourHouseCancel()
  MyRolePlay.Settings.Colours.HouseName.red = mrpTempRed;
  MyRolePlay.Settings.Colours.HouseName.green = mrpTempGreen;
  MyRolePlay.Settings.Colours.HouseName.blue = mrpTempBlue;
  HouseLine:SetTextColor(MyRolePlay.Settings.Colours.HouseName.red, MyRolePlay.Settings.Colours.HouseName.green, MyRolePlay.Settings.Colours.HouseName.blue);
  mrpColourEdit = 0;
end

function mrpColourSelectHouse()
  mrpTempRed = MyRolePlay.Settings.Colours.HouseName.red;
  mrpTempGreen = MyRolePlay.Settings.Colours.HouseName.green;
  mrpTempBlue = MyRolePlay.Settings.Colours.HouseName.blue;
  ColorPickerFrame:Show();
  ColorPickerFrame:SetColorRGB(MyRolePlay.Settings.Colours.HouseName.red, MyRolePlay.Settings.Colours.HouseName.green, MyRolePlay.Settings.Colours.HouseName.blue);
end

----------------------------------------------------------

function mrpColourTitle()
  MyRolePlay.Settings.Colours.Title.red, MyRolePlay.Settings.Colours.Title.green, MyRolePlay.Settings.Colours.Title.blue = ColorPickerFrame:GetColorRGB();
  TitleLine:SetTextColor(MyRolePlay.Settings.Colours.Title.red, MyRolePlay.Settings.Colours.Title.green, MyRolePlay.Settings.Colours.Title.blue);
  mrpColourEdit = 0;
end
function mrpColourTitleCancel()
  MyRolePlay.Settings.Colours.Title.red = mrpTempRed;
  MyRolePlay.Settings.Colours.Title.green = mrpTempGreen;
  MyRolePlay.Settings.Colours.Title.blue = mrpTempBlue;
  TitleLine:SetTextColor(MyRolePlay.Settings.Colours.Title.red, MyRolePlay.Settings.Colours.Title.green, MyRolePlay.Settings.Colours.Title.blue);
  mrpColourEdit = 0;
end

function mrpColourSelectTitle()
  mrpTempRed = MyRolePlay.Settings.Colours.Title.red;
  mrpTempGreen = MyRolePlay.Settings.Colours.Title.green;
  mrpTempBlue = MyRolePlay.Settings.Colours.Title.blue;
  ColorPickerFrame:Show();
  ColorPickerFrame:SetColorRGB(MyRolePlay.Settings.Colours.Title.red, MyRolePlay.Settings.Colours.Title.green, MyRolePlay.Settings.Colours.Title.blue);
end

----------------------------------------------------------

function mrpColourNickname()
  MyRolePlay.Settings.Colours.Nickname.red, MyRolePlay.Settings.Colours.Nickname.green, MyRolePlay.Settings.Colours.Nickname.blue = ColorPickerFrame:GetColorRGB();
  NicknameLine:SetTextColor(MyRolePlay.Settings.Colours.Nickname.red, MyRolePlay.Settings.Colours.Nickname.green, MyRolePlay.Settings.Colours.Nickname.blue);
  mrpColourEdit = 0;
end
function mrpColourNicknameCancel()
  MyRolePlay.Settings.Colours.Nickname.red = mrpTempRed;
  MyRolePlay.Settings.Colours.Nickname.green = mrpTempGreen;
  MyRolePlay.Settings.Colours.Nickname.blue = mrpTempBlue;
  NicknameLine:SetTextColor(MyRolePlay.Settings.Colours.Nickname.red, MyRolePlay.Settings.Colours.Nickname.green, MyRolePlay.Settings.Colours.Nickname.blue);
  mrpColourEdit = 0;
end

function mrpColourSelectNickname()
  mrpTempRed = MyRolePlay.Settings.Colours.Nickname.red;
  mrpTempGreen = MyRolePlay.Settings.Colours.Nickname.green;
  mrpTempBlue = MyRolePlay.Settings.Colours.Nickname.blue;
  ColorPickerFrame:Show();
  ColorPickerFrame:SetColorRGB(MyRolePlay.Settings.Colours.Nickname.red, MyRolePlay.Settings.Colours.Nickname.green, MyRolePlay.Settings.Colours.Nickname.blue);
end

----------------------------------------------------------
function mrpColourGuild()
  MyRolePlay.Settings.Colours.Guild.red, MyRolePlay.Settings.Colours.Guild.green, MyRolePlay.Settings.Colours.Guild.blue = ColorPickerFrame:GetColorRGB();
  GuildLine:SetTextColor(MyRolePlay.Settings.Colours.Guild.red, MyRolePlay.Settings.Colours.Guild.green, MyRolePlay.Settings.Colours.Guild.blue);
  mrpColourEdit = 0;
end

function mrpColourGuildCancel()
  MyRolePlay.Settings.Colours.Guild.red = mrpTempRed;
  MyRolePlay.Settings.Colours.Guild.green = mrpTempGreen;
  MyRolePlay.Settings.Colours.Guild.blue = mrpTempBlue;
  GuildLine:SetTextColor(MyRolePlay.Settings.Colours.Guild.red, MyRolePlay.Settings.Colours.Guild.green, MyRolePlay.Settings.Colours.Guild.blue);
  mrpColourEdit = 0;
end

function mrpColourSelectGuild()
  mrpTempRed = MyRolePlay.Settings.Colours.Guild.red;
  mrpTempGreen = MyRolePlay.Settings.Colours.Guild.green;
  mrpTempBlue = MyRolePlay.Settings.Colours.Guild.blue;
  ColorPickerFrame:Show();
  ColorPickerFrame:SetColorRGB(MyRolePlay.Settings.Colours.Guild.red, MyRolePlay.Settings.Colours.Guild.green, MyRolePlay.Settings.Colours.Guild.blue);
end

----------------------------------------------------------

function mrpColourRPStat()
  MyRolePlay.Settings.Colours.Roleplay.red, MyRolePlay.Settings.Colours.Roleplay.green, MyRolePlay.Settings.Colours.Roleplay.blue = ColorPickerFrame:GetColorRGB();
  RPStatLine:SetTextColor(MyRolePlay.Settings.Colours.Roleplay.red, MyRolePlay.Settings.Colours.Roleplay.green, MyRolePlay.Settings.Colours.Roleplay.blue);
  mrpColourEdit = 0;
end
function mrpColourRPStatCancel()
  MyRolePlay.Settings.Colours.Roleplay.red = mrpTempRed;
  MyRolePlay.Settings.Colours.Roleplay.green = mrpTempGreen;
  MyRolePlay.Settings.Colours.Roleplay.blue = mrpTempBlue;
  RPStatLine:SetTextColor(MyRolePlay.Settings.Colours.Roleplay.red, MyRolePlay.Settings.Colours.Roleplay.green, MyRolePlay.Settings.Colours.Roleplay.blue);
  mrpColourEdit = 0;
end

function mrpColourSelectRPStat()
  mrpTempRed = MyRolePlay.Settings.Colours.Roleplay.red;
  mrpTempGreen = MyRolePlay.Settings.Colours.Roleplay.green;
  mrpTempBlue = MyRolePlay.Settings.Colours.Roleplay.blue;
  ColorPickerFrame:Show();
  ColorPickerFrame:SetColorRGB(MyRolePlay.Settings.Colours.Roleplay.red, MyRolePlay.Settings.Colours.Roleplay.green, MyRolePlay.Settings.Colours.Roleplay.blue);
end

----------------------------------------------------------

function mrpColourCharStatText()
  MyRolePlay.Settings.Colours.CharacterText.red, MyRolePlay.Settings.Colours.CharacterText.green, MyRolePlay.Settings.Colours.CharacterText.blue = ColorPickerFrame:GetColorRGB();
  CharTextLine:SetTextColor(MyRolePlay.Settings.Colours.CharacterText.red, MyRolePlay.Settings.Colours.CharacterText.green, MyRolePlay.Settings.Colours.CharacterText.blue);
  mrpColourEdit = 0;
end
function mrpColourCharStatTextCancel()
  MyRolePlay.Settings.Colours.CharacterText.red = mrpTempRed;
  MyRolePlay.Settings.Colours.CharacterText.green = mrpTempGreen;
  MyRolePlay.Settings.Colours.CharacterText.blue = mrpTempBlue;
  CharTextLine:SetTextColor(MyRolePlay.Settings.Colours.CharacterText.red, MyRolePlay.Settings.Colours.CharacterText.green, MyRolePlay.Settings.Colours.CharacterText.blue);
  mrpColourEdit = 0;
end

function mrpColourSelectCharStatText()
  mrpTempRed = MyRolePlay.Settings.Colours.CharacterText.red;
  mrpTempGreen = MyRolePlay.Settings.Colours.CharacterText.green;
  mrpTempBlue = MyRolePlay.Settings.Colours.CharacterText.blue;
  ColorPickerFrame:Show();
  ColorPickerFrame:SetColorRGB(MyRolePlay.Settings.Colours.CharacterText.red, MyRolePlay.Settings.Colours.CharacterText.green, MyRolePlay.Settings.Colours.CharacterText.blue);
end

----------------------------------------------------------

function mrpColourCharStat()
  MyRolePlay.Settings.Colours.CharacterStat.red, MyRolePlay.Settings.Colours.CharacterStat.green, MyRolePlay.Settings.Colours.CharacterStat.blue = ColorPickerFrame:GetColorRGB();
  CharStatLine:SetTextColor(MyRolePlay.Settings.Colours.CharacterStat.red, MyRolePlay.Settings.Colours.CharacterStat.green, MyRolePlay.Settings.Colours.CharacterStat.blue);
  mrpColourEdit = 0;
end
function mrpColourCharStatCancel()
  MyRolePlay.Settings.Colours.CharacterStat.red = mrpTempRed;
  MyRolePlay.Settings.Colours.CharacterStat.green = mrpTempGreen;
  MyRolePlay.Settings.Colours.CharacterStat.blue = mrpTempBlue;
  CharStatLine:SetTextColor(MyRolePlay.Settings.Colours.CharacterStat.red, MyRolePlay.Settings.Colours.CharacterStat.green, MyRolePlay.Settings.Colours.CharacterStat.blue);
  mrpColourEdit = 0;
end

function mrpColourSelectCharStat()
  mrpTempRed = MyRolePlay.Settings.Colours.CharacterStat.red;
  mrpTempGreen = MyRolePlay.Settings.Colours.CharacterStat.green;
  mrpTempBlue = MyRolePlay.Settings.Colours.CharacterStat.blue;
  ColorPickerFrame:Show();
  ColorPickerFrame:SetColorRGB(MyRolePlay.Settings.Colours.CharacterStat.red, MyRolePlay.Settings.Colours.CharacterStat.green, MyRolePlay.Settings.Colours.CharacterStat.blue);
end

----------------------------------------------------------

function mrpColourLevel()
  MyRolePlay.Settings.Colours.Level.red, MyRolePlay.Settings.Colours.Level.green, MyRolePlay.Settings.Colours.Level.blue = ColorPickerFrame:GetColorRGB();
  CharacterLevelLine:SetTextColor(MyRolePlay.Settings.Colours.Level.red, MyRolePlay.Settings.Colours.Level.green, MyRolePlay.Settings.Colours.Level.blue);
  mrpColourEdit = 0;
end
function mrpColourLevelCancel()
  MyRolePlay.Settings.Colours.Level.red = mrpTempRed;
  MyRolePlay.Settings.Colours.Level.green = mrpTempGreen;
  MyRolePlay.Settings.Colours.Level.blue = mrpTempBlue;
  CharacterLevelLine:SetTextColor(MyRolePlay.Settings.Colours.Level.red, MyRolePlay.Settings.Colours.Level.green, MyRolePlay.Settings.Colours.Level.blue);
  mrpColourEdit = 0;
end

function mrpColourSelectLevel()
  mrpTempRed = MyRolePlay.Settings.Colours.Level.red;
  mrpTempGreen = MyRolePlay.Settings.Colours.Level.green;
  mrpTempBlue = MyRolePlay.Settings.Colours.Level.blue;
  ColorPickerFrame:Show();
  ColorPickerFrame:SetColorRGB(MyRolePlay.Settings.Colours.Level.red, MyRolePlay.Settings.Colours.Level.green, MyRolePlay.Settings.Colours.Level.blue);
end

----------------------------------------------------------

function mrpColourRace()
  MyRolePlay.Settings.Colours.Race.red, MyRolePlay.Settings.Colours.Race.green, MyRolePlay.Settings.Colours.Race.blue = ColorPickerFrame:GetColorRGB();
  CharacterRaceLine:SetTextColor(MyRolePlay.Settings.Colours.Race.red, MyRolePlay.Settings.Colours.Race.green, MyRolePlay.Settings.Colours.Race.blue);
  mrpColourEdit = 0;
end
function mrpColourRaceCancel()
  MyRolePlay.Settings.Colours.Race.red = mrpTempRed;
  MyRolePlay.Settings.Colours.Race.green = mrpTempGreen;
  MyRolePlay.Settings.Colours.Race.blue = mrpTempBlue;
  CharacterRaceLine:SetTextColor(MyRolePlay.Settings.Colours.Race.red, MyRolePlay.Settings.Colours.Race.green, MyRolePlay.Settings.Colours.Race.blue);
  mrpColourEdit = 0;
end

function mrpColourSelectRace()
  mrpTempRed = MyRolePlay.Settings.Colours.Race.red;
  mrpTempGreen = MyRolePlay.Settings.Colours.Race.green;
  mrpTempBlue = MyRolePlay.Settings.Colours.Race.blue;
  ColorPickerFrame:Show();
  ColorPickerFrame:SetColorRGB(MyRolePlay.Settings.Colours.Race.red, MyRolePlay.Settings.Colours.Race.green, MyRolePlay.Settings.Colours.Race.blue);
end

----------------------------------------------------------


function mrpColourRogue()
  MyRolePlay.Settings.Colours.ClassSpecific.Rogue.red, MyRolePlay.Settings.Colours.ClassSpecific.Rogue.green, MyRolePlay.Settings.Colours.ClassSpecific.Rogue.blue = ColorPickerFrame:GetColorRGB();
  mrpColourSpecificRogueText:SetTextColor(MyRolePlay.Settings.Colours.ClassSpecific.Rogue.red, MyRolePlay.Settings.Colours.ClassSpecific.Rogue.green, MyRolePlay.Settings.Colours.ClassSpecific.Rogue.blue);
  mrpColourEdit = 0;
end

function mrpColourSelectRogue()
	mrpTempRed = MyRolePlay.Settings.Colours.ClassSpecific.Rogue.red;
	mrpTempGreen = MyRolePlay.Settings.Colours.ClassSpecific.Rogue.green;
	mrpTempBlue = MyRolePlay.Settings.Colours.ClassSpecific.Rogue.blue;
	ColorPickerFrame:Show();
	ColorPickerFrame:SetColorRGB(MyRolePlay.Settings.Colours.ClassSpecific.Rogue.red, MyRolePlay.Settings.Colours.ClassSpecific.Rogue.green, MyRolePlay.Settings.Colours.ClassSpecific.Rogue.blue);
end


function mrpColourRogueCancel()
  MyRolePlay.Settings.Colours.ClassSpecific.Rogue.red = mrpTempRed;
  MyRolePlay.Settings.Colours.ClassSpecific.Rogue.green = mrpTempGreen;
  MyRolePlay.Settings.Colours.ClassSpecific.Rogue.blue = mrpTempBlue;
  mrpColourSpecificRogueText:SetTextColor(MyRolePlay.Settings.Colours.ClassSpecific.Rogue.red, MyRolePlay.Settings.Colours.ClassSpecific.Rogue.green, MyRolePlay.Settings.Colours.ClassSpecific.Rogue.blue);
  mrpColourEdit = 0;
end

----------------------------------------------------------


function mrpColourWarrior()
  MyRolePlay.Settings.Colours.ClassSpecific.Warrior.red, MyRolePlay.Settings.Colours.ClassSpecific.Warrior.green, MyRolePlay.Settings.Colours.ClassSpecific.Warrior.blue = ColorPickerFrame:GetColorRGB();
  mrpColourSpecificWarriorText:SetTextColor(MyRolePlay.Settings.Colours.ClassSpecific.Warrior.red, MyRolePlay.Settings.Colours.ClassSpecific.Warrior.green, MyRolePlay.Settings.Colours.ClassSpecific.Warrior.blue);
  mrpColourEdit = 0;
end

function mrpColourSelectWarrior()
	mrpTempRed = MyRolePlay.Settings.Colours.ClassSpecific.Warrior.red;
	mrpTempGreen = MyRolePlay.Settings.Colours.ClassSpecific.Warrior.green;
	mrpTempBlue = MyRolePlay.Settings.Colours.ClassSpecific.Warrior.blue;
	ColorPickerFrame:Show();
	ColorPickerFrame:SetColorRGB(MyRolePlay.Settings.Colours.ClassSpecific.Warrior.red, MyRolePlay.Settings.Colours.ClassSpecific.Warriorgreen, MyRolePlay.Settings.Colours.ClassSpecific.Warrior.blue);
end


function mrpColourWarriorCancel()
  MyRolePlay.Settings.Colours.ClassSpecific.Warrior.red = mrpTempRed;
  MyRolePlay.Settings.Colours.ClassSpecific.Warrior.green = mrpTempGreen;
  MyRolePlay.Settings.Colours.ClassSpecific.Warrior.blue = mrpTempBlue;
  mrpColourSpecificWarriorText:SetTextColor(MyRolePlay.Settings.Colours.ClassSpecific.Warrior.red, MyRolePlay.Settings.Colours.ClassSpecific.Warrior.green, MyRolePlay.Settings.Colours.ClassSpecific.Warrior.blue);
  mrpColourEdit = 0;
end

----------------------------------------------------------


function mrpColourPriest()
  MyRolePlay.Settings.Colours.ClassSpecific.Priest.red, MyRolePlay.Settings.Colours.ClassSpecific.Priest.green, MyRolePlay.Settings.Colours.ClassSpecific.Priest.blue = ColorPickerFrame:GetColorRGB();
  mrpColourSpecificPriestText:SetTextColor(MyRolePlay.Settings.Colours.ClassSpecific.Priest.red, MyRolePlay.Settings.Colours.ClassSpecific.Priest.green, MyRolePlay.Settings.Colours.ClassSpecific.Priest.blue);
  mrpColourEdit = 0;
end

function mrpColourSelectPriest()
	mrpTempRed = MyRolePlay.Settings.Colours.ClassSpecific.Priest.red;
	mrpTempGreen = MyRolePlay.Settings.Colours.ClassSpecific.Priest.green;
	mrpTempBlue = MyRolePlay.Settings.Colours.ClassSpecific.Priest.blue;
	ColorPickerFrame:Show();
	ColorPickerFrame:SetColorRGB(MyRolePlay.Settings.Colours.ClassSpecific.Priest.red, MyRolePlay.Settings.Colours.ClassSpecific.Priestgreen, MyRolePlay.Settings.Colours.ClassSpecific.Priest.blue);
end


function mrpColourPriestCancel()
  MyRolePlay.Settings.Colours.ClassSpecific.Priest.red = mrpTempRed;
  MyRolePlay.Settings.Colours.ClassSpecific.Priest.green = mrpTempGreen;
  MyRolePlay.Settings.Colours.ClassSpecific.Priest.blue = mrpTempBlue;
  mrpColourSpecificPriestText:SetTextColor(MyRolePlay.Settings.Colours.ClassSpecific.Priest.red, MyRolePlay.Settings.Colours.ClassSpecific.Priest.green, MyRolePlay.Settings.Colours.ClassSpecific.Priest.blue);
  mrpColourEdit = 0;
end

----------------------------------------------------------


function mrpColourMage()
  MyRolePlay.Settings.Colours.ClassSpecific.Mage.red, MyRolePlay.Settings.Colours.ClassSpecific.Mage.green, MyRolePlay.Settings.Colours.ClassSpecific.Mage.blue = ColorPickerFrame:GetColorRGB();
  mrpColourSpecificMageText:SetTextColor(MyRolePlay.Settings.Colours.ClassSpecific.Mage.red, MyRolePlay.Settings.Colours.ClassSpecific.Mage.green, MyRolePlay.Settings.Colours.ClassSpecific.Mage.blue);
  mrpColourEdit = 0;
end

function mrpColourSelectMage()
	mrpTempRed = MyRolePlay.Settings.Colours.ClassSpecific.Mage.red;
	mrpTempGreen = MyRolePlay.Settings.Colours.ClassSpecific.Mage.green;
	mrpTempBlue = MyRolePlay.Settings.Colours.ClassSpecific.Mage.blue;
	ColorPickerFrame:Show();
	ColorPickerFrame:SetColorRGB(MyRolePlay.Settings.Colours.ClassSpecific.Mage.red, MyRolePlay.Settings.Colours.ClassSpecific.Mage.green, MyRolePlay.Settings.Colours.ClassSpecific.Mage.blue);
end


function mrpColourMageCancel()
  MyRolePlay.Settings.Colours.ClassSpecific.Mage.red = mrpTempRed;
  MyRolePlay.Settings.Colours.ClassSpecific.Mage.green = mrpTempGreen;
  MyRolePlay.Settings.Colours.ClassSpecific.Mage.blue = mrpTempBlue;
  mrpColourSpecificMageText:SetTextColor(MyRolePlay.Settings.Colours.ClassSpecific.Mage.red, MyRolePlay.Settings.Colours.ClassSpecific.Mage.green, MyRolePlay.Settings.Colours.ClassSpecific.Mage.blue);
  mrpColourEdit = 0;
end

----------------------------------------------------------


function mrpColourShaman()
  MyRolePlay.Settings.Colours.ClassSpecific.Shaman.red, MyRolePlay.Settings.Colours.ClassSpecific.Shaman.green, MyRolePlay.Settings.Colours.ClassSpecific.Shaman.blue = ColorPickerFrame:GetColorRGB();
  mrpColourSpecificShamanText:SetTextColor(MyRolePlay.Settings.Colours.ClassSpecific.Shaman.red, MyRolePlay.Settings.Colours.ClassSpecific.Shaman.green, MyRolePlay.Settings.Colours.ClassSpecific.Shaman.blue);
  mrpColourEdit = 0;
end

function mrpColourSelectShaman()
	mrpTempRed = MyRolePlay.Settings.Colours.ClassSpecific.Shaman.red;
	mrpTempGreen = MyRolePlay.Settings.Colours.ClassSpecific.Shaman.green;
	mrpTempBlue = MyRolePlay.Settings.Colours.ClassSpecific.Shaman.blue;
	ColorPickerFrame:Show();
	ColorPickerFrame:SetColorRGB(MyRolePlay.Settings.Colours.ClassSpecific.Shaman.red, MyRolePlay.Settings.Colours.ClassSpecific.Shaman.green, MyRolePlay.Settings.Colours.ClassSpecific.Shaman.blue);
end


function mrpColourShamanCancel()
  MyRolePlay.Settings.Colours.ClassSpecific.Shaman.red = mrpTempRed;
  MyRolePlay.Settings.Colours.ClassSpecific.Shaman.green = mrpTempGreen;
  MyRolePlay.Settings.Colours.ClassSpecific.Shaman.blue = mrpTempBlue;
  mrpColourSpecificShamanText:SetTextColor(MyRolePlay.Settings.Colours.ClassSpecific.Shaman.red, MyRolePlay.Settings.Colours.ClassSpecific.Shaman.green, MyRolePlay.Settings.Colours.ClassSpecific.Shaman.blue);
  mrpColourEdit = 0;
end

----------------------------------------------------------


function mrpColourPaladin()
  MyRolePlay.Settings.Colours.ClassSpecific.Paladin.red, MyRolePlay.Settings.Colours.ClassSpecific.Paladin.green, MyRolePlay.Settings.Colours.ClassSpecific.Paladin.blue = ColorPickerFrame:GetColorRGB();
  mrpColourSpecificPaladinText:SetTextColor(MyRolePlay.Settings.Colours.ClassSpecific.Paladin.red, MyRolePlay.Settings.Colours.ClassSpecific.Paladin.green, MyRolePlay.Settings.Colours.ClassSpecific.Paladin.blue);
  mrpColourEdit = 0;
end

function mrpColourSelectPaladin()
	mrpTempRed = MyRolePlay.Settings.Colours.ClassSpecific.Paladin.red;
	mrpTempGreen = MyRolePlay.Settings.Colours.ClassSpecific.Paladin.green;
	mrpTempBlue = MyRolePlay.Settings.Colours.ClassSpecific.Paladin.blue;
	ColorPickerFrame:Show();
	ColorPickerFrame:SetColorRGB(MyRolePlay.Settings.Colours.ClassSpecific.Paladin.red, MyRolePlay.Settings.Colours.ClassSpecific.Paladin.green, MyRolePlay.Settings.Colours.ClassSpecific.Paladin.blue);
end


function mrpColourPaladinCancel()
  MyRolePlay.Settings.Colours.ClassSpecific.Paladin.red = mrpTempRed;
  MyRolePlay.Settings.Colours.ClassSpecific.Paladin.green = mrpTempGreen;
  MyRolePlay.Settings.Colours.ClassSpecific.Paladin.blue = mrpTempBlue;
  mrpColourSpecificPaladinText:SetTextColor(MyRolePlay.Settings.Colours.ClassSpecific.Paladin.red, MyRolePlay.Settings.Colours.ClassSpecific.Paladin.green, MyRolePlay.Settings.Colours.ClassSpecific.Paladin.blue);
  mrpColourEdit = 0;
end

----------------------------------------------------------


function mrpColourWarlock()
  MyRolePlay.Settings.Colours.ClassSpecific.Warlock.red, MyRolePlay.Settings.Colours.ClassSpecific.Warlock.green, MyRolePlay.Settings.Colours.ClassSpecific.Warlock.blue = ColorPickerFrame:GetColorRGB();
  mrpColourSpecificWarlockText:SetTextColor(MyRolePlay.Settings.Colours.ClassSpecific.Warlock.red, MyRolePlay.Settings.Colours.ClassSpecific.Warlock.green, MyRolePlay.Settings.Colours.ClassSpecific.Warlock.blue);
  mrpColourEdit = 0;
end

function mrpColourSelectWarlock()
	mrpTempRed = MyRolePlay.Settings.Colours.ClassSpecific.Warlock.red;
	mrpTempGreen = MyRolePlay.Settings.Colours.ClassSpecific.Warlock.green;
	mrpTempBlue = MyRolePlay.Settings.Colours.ClassSpecific.Warlock.blue;
	ColorPickerFrame:Show();
	ColorPickerFrame:SetColorRGB(MyRolePlay.Settings.Colours.ClassSpecific.Warlock.red, MyRolePlay.Settings.Colours.ClassSpecific.Warlock.green, MyRolePlay.Settings.Colours.ClassSpecific.Warlock.blue);
end


function mrpColourWarlockCancel()
  MyRolePlay.Settings.Colours.ClassSpecific.Warlock.red = mrpTempRed;
  MyRolePlay.Settings.Colours.ClassSpecific.Warlock.green = mrpTempGreen;
  MyRolePlay.Settings.Colours.ClassSpecific.Warlock.blue = mrpTempBlue;
  mrpColourSpecificWarlockText:SetTextColor(MyRolePlay.Settings.Colours.ClassSpecific.Warlock.red, MyRolePlay.Settings.Colours.ClassSpecific.Warlock.green, MyRolePlay.Settings.Colours.ClassSpecific.Warlock.blue);
  mrpColourEdit = 0;
end

----------------------------------------------------------


function mrpColourDruid()
  MyRolePlay.Settings.Colours.ClassSpecific.Druid.red, MyRolePlay.Settings.Colours.ClassSpecific.Druid.green, MyRolePlay.Settings.Colours.ClassSpecific.Druid.blue = ColorPickerFrame:GetColorRGB();
  mrpColourSpecificDruidText:SetTextColor(MyRolePlay.Settings.Colours.ClassSpecific.Druid.red, MyRolePlay.Settings.Colours.ClassSpecific.Druid.green, MyRolePlay.Settings.Colours.ClassSpecific.Druid.blue);
  mrpColourEdit = 0;
end

function mrpColourSelectDruid()
	mrpTempRed = MyRolePlay.Settings.Colours.ClassSpecific.Druid.red;
	mrpTempGreen = MyRolePlay.Settings.Colours.ClassSpecific.Druid.green;
	mrpTempBlue = MyRolePlay.Settings.Colours.ClassSpecific.Druid.blue;
	ColorPickerFrame:Show();
	ColorPickerFrame:SetColorRGB(MyRolePlay.Settings.Colours.ClassSpecific.Druid.red, MyRolePlay.Settings.Colours.ClassSpecific.Druid.green, MyRolePlay.Settings.Colours.ClassSpecific.Druid.blue);
end


function mrpColourDruidCancel()
  MyRolePlay.Settings.Colours.ClassSpecific.Druid.red = mrpTempRed;
  MyRolePlay.Settings.Colours.ClassSpecific.Druid.green = mrpTempGreen;
  MyRolePlay.Settings.Colours.ClassSpecific.Druid.blue = mrpTempBlue;
  mrpColourSpecificDruidText:SetTextColor(MyRolePlay.Settings.Colours.ClassSpecific.Druid.red, MyRolePlay.Settings.Colours.ClassSpecific.Druid.green, MyRolePlay.Settings.Colours.ClassSpecific.Druid.blue);
  mrpColourEdit = 0;
end

----------------------------------------------------------


function mrpColourHunter()
  MyRolePlay.Settings.Colours.ClassSpecific.Hunter.red, MyRolePlay.Settings.Colours.ClassSpecific.Hunter.green, MyRolePlay.Settings.Colours.ClassSpecific.Hunter.blue = ColorPickerFrame:GetColorRGB();
  mrpColourSpecificHunterText:SetTextColor(MyRolePlay.Settings.Colours.ClassSpecific.Hunter.red, MyRolePlay.Settings.Colours.ClassSpecific.Hunter.green, MyRolePlay.Settings.Colours.ClassSpecific.Hunter.blue);
  mrpColourEdit = 0;
end

function mrpColourSelectHunter()
	mrpTempRed = MyRolePlay.Settings.Colours.ClassSpecific.Hunter.red;
	mrpTempGreen = MyRolePlay.Settings.Colours.ClassSpecific.Hunter.green;
	mrpTempBlue = MyRolePlay.Settings.Colours.ClassSpecific.Hunter.blue;
	ColorPickerFrame:Show();
	ColorPickerFrame:SetColorRGB(MyRolePlay.Settings.Colours.ClassSpecific.Hunter.red, MyRolePlay.Settings.Colours.ClassSpecific.Hunter.green, MyRolePlay.Settings.Colours.ClassSpecific.Hunter.blue);
end


function mrpColourHunterCancel()
  MyRolePlay.Settings.Colours.ClassSpecific.Hunter.red = mrpTempRed;
  MyRolePlay.Settings.Colours.ClassSpecific.Hunter.green = mrpTempGreen;
  MyRolePlay.Settings.Colours.ClassSpecific.Hunter.blue = mrpTempBlue;
  mrpColourSpecificHunterText:SetTextColor(MyRolePlay.Settings.Colours.ClassSpecific.Hunter.red, MyRolePlay.Settings.Colours.ClassSpecific.Hunter.green, MyRolePlay.Settings.Colours.ClassSpecific.Hunter.blue);
  mrpColourEdit = 0;
end



function mrpColourSetDefaultVars()
	MyRolePlay.Settings.Colours.Title = { red = 1.0, green = 1.0, blue = 1.0 };
	MyRolePlay.Settings.Colours.Guild = { red = 1.0, green =1.0, blue = 1.0 };
	MyRolePlay.Settings.Colours.Level = { red = 1.0, green = 1.0, blue = 0 };
	MyRolePlay.Settings.Colours.Class = { red = 1.0, green = 1.0, blue = 0 };
	MyRolePlay.Settings.Colours.Race = { red = 1.0, green = 1.0, blue = 0 };
	MyRolePlay.Settings.Colours.HouseName = { red = 1.0, green =1.0, blue = 1.0 };
	MyRolePlay.Settings.Colours.Roleplay = { red = 1.0, green =1.0, blue = 0.6 };
	MyRolePlay.Settings.Colours.CharacterText = { red = 1.0, green =1.0, blue = 1.0 };
	MyRolePlay.Settings.Colours.CharacterStat = { red = 1.0, green =1.0, blue = 0.6 };
	MyRolePlay.Settings.Colours.Nickname = { red = 1.0, green =1.0, blue = 1.0 };	
	
	mrpColourTextSetAll();

end

function mrpColourSpecificDefaultVars()
		MyRolePlay.Settings.Colours.ClassSpecific.Rogue = { red = 1.0, green = 1.0, blue = 0 };
		MyRolePlay.Settings.Colours.ClassSpecific.Warrior = { red = 1.0, green = 1.0, blue = 0 };
		MyRolePlay.Settings.Colours.ClassSpecific.Priest = { red = 1.0, green = 1.0, blue = 0 };
		MyRolePlay.Settings.Colours.ClassSpecific.Mage = { red = 1.0, green = 1.0, blue = 0 };
		MyRolePlay.Settings.Colours.ClassSpecific.Shaman = { red = 1.0, green = 1.0, blue = 0 };
		MyRolePlay.Settings.Colours.ClassSpecific.Paladin = { red = 1.0, green = 1.0, blue = 0 };
		MyRolePlay.Settings.Colours.ClassSpecific.Druid = { red = 1.0, green = 1.0, blue = 0 };
		MyRolePlay.Settings.Colours.ClassSpecific.Warlock = { red = 1.0, green = 1.0, blue = 0 };
		MyRolePlay.Settings.Colours.ClassSpecific.Hunter = { red = 1.0, green = 1.0, blue = 0 };

		mrpColourTextSetAll();

end
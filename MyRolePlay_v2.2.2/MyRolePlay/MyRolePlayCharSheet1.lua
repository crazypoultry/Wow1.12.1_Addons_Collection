function mrpCharSheet1NextPageButton_OnClick()
	if (mrpCharacterSheet1SecondPage:IsShown()) then
		mrpCharacterSheet1SecondPage:Hide();
		mrpCharacterSheet1ThirdPage:Show();
		mrpCharacterSheet1NextPageButton:Disable();
	end
	if (mrpCharacterSheet1FrontPage:IsShown()) then
		mrpCharacterSheet1FrontPage:Hide();
		mrpCharacterSheet1SecondPage:Show();
		mrpCharacterSheet1PrevPageButton:Enable();
	end
end

function mrpCharSheet1PrevPageButton_OnClick()
	if (mrpCharacterSheet1SecondPage:IsShown()) then
		mrpCharacterSheet1SecondPage:Hide();
		mrpCharacterSheet1FrontPage:Show();
		mrpCharacterSheet1PrevPageButton:Disable();
	end
	if (mrpCharacterSheet1ThirdPage:IsShown()) then
		mrpCharacterSheet1ThirdPage:Hide();
		mrpCharacterSheet1SecondPage:Show();
		mrpCharacterSheet1NextPageButton:Enable();
	end
end

function mrpCharSheet1UpdatePageButton()
	if (mrpCharacterSheet1ThirdPage:IsShown()) then
		mrpCharacterSheet1NextPageButton:Disable();
	end
	if (mrpCharacterSheet1FrontPage:IsShown()) then
		mrpCharacterSheet1PrevPageButton:Disable();	
	end
end

function mrpCharacterSheet1UpdateInformation()
	local firstnametext	= "";
	local prefixtext	= "";
	local middlenametext	= "";
	local surnametext	= "";
	local leveltext		= "";
	local titletext		= "";
	local housetext		= "";
	local nicknametext	= "";
	local housetext		= "";
	local rpstattext	= MRP_LOCALE_No_Status;
	local charstattext	= MRP_LOCALE_No_Status;
	local desctext		= "";
	local eyecolourtext	= "";
	local emotiontext	= "";
	local heighttext	= "";
	local weighttext	= "";
	local homecitytext	= "";
	local birthcitytext	= "";
	local mottotext		= "";
	local historytext	= "";
	
	
	
	if (UnitName("target") == UnitName("player")) then
		desctext = (MyRolePlay.Appearance.Description1 .. MyRolePlay.Appearance.Description2 .. MyRolePlay.Appearance.Description3 .. MyRolePlay.Appearance.Description4 .. MyRolePlay.Appearance.Description5 .. MyRolePlay.Appearance.Description6)
		historytext = (MyRolePlay.Lore.History1 .. MyRolePlay.Lore.History2 .. MyRolePlay.Lore.History3 .. MyRolePlay.Lore.History4 .. MyRolePlay.Lore.History5 .. MyRolePlay.Lore.History6)
		if (MyRolePlay.Identification.Prefix ~= "") then
			prefixtext = (MyRolePlay.Identification.Prefix .. " ");
		end
		if (MyRolePlay.Identification.Nickname ~= "") then
			nicknametext = (MyRolePlay.Identification.Nickname);
		end
		if (MyRolePlay.Identification.Housename ~= "") then
			housetext = (MyRolePlay.Identification.Housename);
		end
		if (MyRolePlay.Identification.Title ~= "") then
			titletext = (MyRolePlay.Identification.Title);
		end
		if (MyRolePlay.Identification.Firstname ~= "") then
			firstnametext = (MyRolePlay.Identification.Firstname .. " ");
		end
		if (MyRolePlay.Identification.Middlename ~= "") then
			middlenametext = (MyRolePlay.Identification.Middlename .. " ");
		end
		if (MyRolePlay.Identification.Surname ~= "") then
			surnametext = (MyRolePlay.Identification.Surname);
		end
		if (MyRolePlay.Status.Roleplay ~= "") then
			rpstattext = (mrpDecodeStatus(MyRolePlay.Status.Roleplay));
		end
		if (MyRolePlay.Status.Character ~= "") then
			charstattext = (mrpDecodeStatus(MyRolePlay.Status.Character));
		end
		if (MyRolePlay.Appearance.EyeColour ~= "") then
			eyecolourtext = (MyRolePlay.Appearance.EyeColour);
		end
		if (MyRolePlay.Appearance.CurrentEmotion ~= "") then
			emotiontext = (MyRolePlay.Appearance.CurrentEmotion);
		end
		if (MyRolePlay.Appearance.Height ~= "") then
			heighttext = (MyRolePlay.Appearance.Height);
		end
		if (MyRolePlay.Appearance.Weight ~= "") then
			weighttext = (MyRolePlay.Appearance.Weight);
		end
		if (MyRolePlay.Lore.Homecity ~= "") then
			homecitytext = (MyRolePlay.Lore.Homecity);
		end
		if (MyRolePlay.Lore.Birthcity ~= "") then
			birthcitytext = (MyRolePlay.Lore.Birthcity);
		end
		if (MyRolePlay.Lore.Motto ~= "") then
			mottotext = (MyRolePlay.Lore.Motto);
		end
		if (MyRolePlay.Settings.Relative == 1) then
			leveltext = (mrpRelativeLevelCheck(UnitLevel("target")));
		else
			leveltext = (MRP_LOCALE_CHARACTER_SHEET_LEVEL .. " " .. UnitLevel("target"));
		end
	else
		mrpPlayerIndex = nil;
		mrpFlagRSPPlayerIndex = nil;

		-- Checks to see if target has MyRolePlay
		for i = 1, table.getn(mrpPlayerList) do
			if (mrpPlayerList[i].CharacterName == UnitName("target")) then
				mrpPlayerIndex = i;
				break;
			end
		end

		-- Checks to see if target has FlagRSP
		for i = 1, table.getn(mrpFlagRSPPlayerList) do
			if (mrpFlagRSPPlayerList[i].CharacterName == UnitName("target")) then
				mrpFlagRSPPlayerIndex = i;
				break;
			end
		end

		--desctext = (mrpTarget.Appearance.Description1 .. mrpTarget.Appearance.Description2 .. mrpTarget.Appearance.Description3 .. mrpTarget.Appearance.Description4 .. mrpTarget.Appearance.Description5 .. mrpTarget.Appearance.Description6)
		--historytext = (mrpTarget.Lore.History1 .. mrpTarget.Lore.History2 .. mrpTarget.Lore.History3 .. mrpTarget.Lore.History4 .. mrpTarget.Lore.History5 .. mrpTarget.Lore.History6)
		if (mrpPlayerIndex ~= nil and mrpPlayerList[mrpPlayerIndex].Prefix ~= "") then
			prefixtext = (mrpPlayerList[mrpPlayerIndex].Prefix .. " ");
		end
		if (mrpPlayerIndex ~= nil and mrpPlayerList[mrpPlayerIndex].Nickname ~= "") then
			nicknametext = (mrpPlayerList[mrpPlayerIndex].Nickname);
		end
		if (mrpPlayerIndex ~= nil and mrpPlayerList[mrpPlayerIndex].Housename ~= "") then
			housetext = (mrpPlayerList[mrpPlayerIndex].Housename);
		end
		if (mrpPlayerIndex ~= nil and mrpPlayerList[mrpPlayerIndex].Title ~= "") then
			titletext = (mrpPlayerList[mrpPlayerIndex].Title);
		elseif (mrpFlagRSPPlayerIndex ~= nil and mrpFlagRSPPlayerList[mrpFlagRSPPlayerIndex].Title ~= "") then
			titletext = (mrpFlagRSPPlayerList[mrpFlagRSPPlayerIndex].Title .. " ");
		end
		if (mrpPlayerIndex ~= nil and mrpPlayerList[mrpPlayerIndex].Firstname ~= "") then
			firstnametext = (mrpPlayerList[mrpPlayerIndex].Firstname .. " ");
		else
			firstnametext = UnitName("target") .. " ";
		end
		if (mrpPlayerIndex ~= nil and mrpPlayerList[mrpPlayerIndex].Middlename ~= "") then
			middlenametext = (mrpTarget.Identification.Middlename .. " ");
		end
		if (mrpPlayerIndex ~= nil and mrpPlayerList[mrpPlayerIndex].Surname ~= "") then
			surnametext = (mrpPlayerList[mrpPlayerIndex].Surname);
		elseif (mrpFlagRSPPlayerIndex ~= nil and mrpFlagRSPPlayerList[mrpFlagRSPPlayerIndex].Surname ~= "") then
			surnametext = (mrpFlagRSPPlayerList[mrpFlagRSPPlayerIndex].Surname .. " ");
		end
		if (mrpPlayerIndex ~= nil and mrpPlayerList[mrpPlayerIndex].EyeColour ~= "") then
			eyecolourtext = (mrpPlayerList[mrpPlayerIndex].EyeColour);
		end
		if (mrpPlayerIndex ~= nil and mrpPlayerList[mrpPlayerIndex].CurrentEmotion ~= "") then
			emotiontext = (mrpPlayerList[mrpPlayerIndex].CurrentEmotion);
		end
		if (mrpPlayerIndex ~= nil and mrpPlayerList[mrpPlayerIndex].Height ~= "") then
			heighttext = (mrpPlayerList[mrpPlayerIndex].Height);
		end
		if (mrpPlayerIndex ~= nil and mrpPlayerList[mrpPlayerIndex].Weight ~= "") then
			weighttext = (mrpPlayerList[mrpPlayerIndex].Weight);
		end
		if (mrpPlayerIndex ~= nil and mrpPlayerList[mrpPlayerIndex].Roleplay ~= "") then
			rpstattext = (mrpDecodeStatus(mrpPlayerList[mrpPlayerIndex].Roleplay));
		elseif (mrpFlagRSPPlayerIndex ~= nil and mrpFlagRSPPlayerList[mrpFlagRSPPlayerIndex].Roleplay ~= "") then
			rpstattext = (mrpDecodeStatus(mrpFlagRSPPlayerList[mrpFlagRSPPlayerIndex].Roleplay) .. " ");
		end
		if (mrpPlayerIndex ~= nil and mrpPlayerList[mrpPlayerIndex].Character ~= "") then
			charstattext = (mrpDecodeStatus(mrpPlayerList[mrpPlayerIndex].Character));
		elseif (mrpFlagRSPPlayerIndex ~= nil and mrpFlagRSPPlayerList[mrpFlagRSPPlayerIndex].Character ~= "") then
			charstattext = (mrpDecodeStatus(mrpFlagRSPPlayerList[mrpFlagRSPPlayerIndex].Character) .. " ");
		end
		if (mrpPlayerIndex ~= nil and mrpPlayerList[mrpPlayerIndex].Homecity ~= "") then
			homecitytext = (mrpPlayerList[mrpPlayerIndex].Homecity);
		end
		if (mrpPlayerIndex ~= nil and mrpPlayerList[mrpPlayerIndex].Birthcity ~= "") then
			birthcitytext = (mrpPlayerList[mrpPlayerIndex].Birthcity);
		end
		if (mrpPlayerIndex ~= nil and mrpPlayerList[mrpPlayerIndex].Motto ~= "") then
			mottotext = (mrpPlayerList[mrpPlayerIndex].Motto);
		end
		if (MyRolePlay.Settings.Relative == 1) then
			leveltext = (mrpRelativeLevelCheck(UnitLevel("target")));
		else
			leveltext = (MRP_LOCALE_CHARACTER_SHEET_LEVEL.. " " .. UnitLevel("target"));
		end
	end

--	mrpCharSheet1NameText:SetText(MyRolePlay.Identification.Prefix .. " " .. MyRolePlay.Identification.Firstname .. " " .. MyRolePlay.Identification.Middlename .. " " .. MyRolePlay.Identification.Surname .. "");
	mrpCharSheet1NameText:SetText(prefixtext .. firstnametext .. middlenametext .. surnametext);
	
	
	mrpCharSheet1LevelRaceClassText:SetText(leveltext .. " " .. UnitRace("target") .. " " .. UnitClass("target") .. "");
	mrpCharSheet1TitleText:SetText(titletext);
	mrpCharSheet1HouseText:SetText(housetext);
	mrpCharSheet1NicknameText:SetText(nicknametext);
	mrpCharSheet1RPStatText:SetText(rpstattext);
	mrpCharSheet1CharStatText:SetText(charstattext);
	mrpCharSheet1DescBox:SetText("");
	mrpCharSheet1HistBox:SetText("");
	mrpCharSheet1EyeColourText:SetText(eyecolourtext);
	mrpCharSheet1EmotionText:SetText(emotiontext);
	mrpCharSheet1HeightText:SetText(heighttext);
	mrpCharSheet1WeightText:SetText(weighttext);
	mrpCharSheet1MottoText:SetText(mottotext);
	mrpCharSheet1HomeCityText:SetText(homecitytext);
	mrpCharSheet1BirthCityText:SetText(birthcitytext);
	mrpCharacterSheet1HeaderText:SetText(firstnametext);

end

TargetFrame_CheckLevel = NewTargetFrame_CheckLevel;

function TargetFrame_CheckLevel()
	local targetLevel = UnitLevel("target");
	
	if ( UnitIsCorpse("target") ) then
		TargetLevelText:Hide();
		TargetHighLevelTexture:Show();
	elseif ( targetLevel > 0 ) then
		if (MyRolePlay.Settings.Relative == 1) then
			if ((UnitLevel("target")) == -1) then
				TargetLevelText:SetText(MRP_LOCALE_mrpRelative10hshort);
			elseif ((UnitLevel("target")) <= (UnitLevel("player") - 7)) then
				TargetLevelText:SetText(MRP_LOCALE_mrpRelative7lshort);
			elseif ( ((UnitLevel("target")) >= (UnitLevel("player")) - 6) and ((UnitLevel("target")) <= (UnitLevel("player") - 5  ))) then
				TargetLevelText:SetText(MRP_LOCALE_mrpRelative5to6lshort);
			elseif ( ((UnitLevel("target")) >= (UnitLevel("player")) - 4) and ((UnitLevel("target")) <= (UnitLevel("player") - 2  ))) then
				TargetLevelText:SetText(MRP_LOCALE_mrpRelative2to4lshort);
			elseif ( ((UnitLevel("target")) >= (UnitLevel("player")) - 1) and ((UnitLevel("target")) <= (UnitLevel("player") + 2  ))) then
				TargetLevelText:SetText(MRP_LOCALE_mrpRelative1to1hshort);
			elseif ( ((UnitLevel("target")) >= (UnitLevel("player")) + 2) and ((UnitLevel("target")) <= (UnitLevel("player") + 3  ))) then
				TargetLevelText:SetText(MRP_LOCALE_mrpRelative2to3hshort);
			elseif ( ((UnitLevel("target")) >= (UnitLevel("player")) + 4) and ((UnitLevel("target")) <= (UnitLevel("player") + 6  ))) then
				TargetLevelText:SetText(MRP_LOCALE_mrpRelative4to6hshort);
			elseif ( ((UnitLevel("target")) >= (UnitLevel("player")) + 7) and ((UnitLevel("target")) <= (UnitLevel("player") + 9  ))) then
				TargetLevelText:SetText(MRP_LOCALE_mrpRelative7to9hshort);
			else
				TargetLevelText:SetText(MRP_LOCALE_mrpRelative10hshort);
			end

		else	-- Normal level target
		TargetLevelText:SetText(targetLevel);
		-- Color level number
		end
		if ( UnitCanAttack("player", "target") ) then
			local color = GetDifficultyColor(targetLevel);
			TargetLevelText:SetVertexColor(color.r, color.g, color.b);
		else
			TargetLevelText:SetVertexColor(1.0, 0.82, 0.0);
		end
		TargetLevelText:Show();
		TargetHighLevelTexture:Hide();
	else
		-- Target is too high level to tell
		TargetLevelText:Hide();
		TargetHighLevelTexture:Show();
	end
	
		mrpPlayerIndex = nil;

		-- Checks to see if target has MyRolePlay
		for i = 1, table.getn(mrpPlayerList) do
			if (mrpPlayerList[i].CharacterName == UnitName("target")) then
				mrpPlayerIndex = i;
				break;
			end
		end

	if (UnitName("target") == UnitName("player")) then
		TargetName:SetText(MyRolePlay.Identification.Firstname);
	elseif (mrpPlayerIndex ~= nil and mrpPlayerList[mrpPlayerIndex].Firstname ~= "") then
		TargetName:SetText(mrpPlayerList[mrpPlayerIndex].Firstname);
	else
		TargetName:SetText(UnitName("target"));
	end
end


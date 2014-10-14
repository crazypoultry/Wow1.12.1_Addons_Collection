CharactersViewer.CharacterFrame = {};
CharactersViewer.constant.CHARACTERFRAME_SUBFRAMES = { "CVPaperDollFrame", "CVPetPaperDollFrame", "CVSkillFrame", "CVReputationFrame", "CVHonorFrame", "CVReportFrame", "CVOptionFrame" };

function CharactersViewer.CharacterFrame.ToggleCharacter(tab)
	--[[
	if ( tab == "PetPaperDollFrame" and not HasPetUI() and not PetPaperDollFrame:IsVisible() ) then
		return;
	end
	]]--
	
	local subFrame = getglobal(tab);
	if ( subFrame ) then
		PanelTemplates_SetTab(CVCharacterFrame, subFrame:GetID());
		if ( CVCharacterFrame:IsVisible() ) then
			if ( subFrame:IsVisible() ) then
				HideUIPanel(CVCharacterFrame);	
			else
				PlaySound("igCharacterInfoTab");
				CharactersViewer.CharacterFrame.CharacterFrame_ShowSubFrame(tab);
			end
		else
			ShowUIPanel(CVCharacterFrame);
			CharactersViewer.CharacterFrame.CharacterFrame_ShowSubFrame(tab);
		end
	end	

end

function CharactersViewer.CharacterFrame.CharacterFrame_ShowSubFrame(frameName)
	for index, value in CharactersViewer.constant.CHARACTERFRAME_SUBFRAMES do
		if ( value == frameName ) then
			getglobal(value):Show();
		else
			getglobal(value):Hide();
		end	
	end 
end

function CharactersViewer.CharacterFrame.CharacterFrameTab_OnClick()
	if ( this:GetName() == "CVCharacterFrameTab1" ) then
		CharactersViewer.CharacterFrame.ToggleCharacter("CVPaperDollFrame");
	elseif ( this:GetName() == "CVCharacterFrameTab2" ) then
		CharactersViewer.CharacterFrame.ToggleCharacter("CVPetPaperDollFrame");
	elseif ( this:GetName() == "CVCharacterFrameTab3" ) then
		CharactersViewer.CharacterFrame.ToggleCharacter("CVReputationFrame");	
	elseif ( this:GetName() == "CVCharacterFrameTab4" ) then
		CharactersViewer.CharacterFrame.ToggleCharacter("CVSkillFrame");	
	elseif ( this:GetName() == "CVCharacterFrameTab5" ) then
		CharactersViewer.CharacterFrame.ToggleCharacter("CVHonorFrame");
	elseif ( this:GetName() == "CVCharacterFrameTab6" ) then
		CharactersViewer.CharacterFrame.ToggleCharacter("CVReportFrame");		
	elseif ( this:GetName() == "CVCharacterFrameTab7" ) then
		CharactersViewer.CharacterFrame.ToggleCharacter("CVOptionFrame");	
	end
	PlaySound("igCharacterInfoTab");
end

function CharactersViewer.CharacterFrame.CharacterFrame_OnLoad()
	--this:RegisterEvent("UNIT_NAME_UPDATE");
	--this:RegisterEvent("UNIT_PORTRAIT_UPDATE");
	--this:RegisterEvent("PLAYER_PVP_RANK_CHANGED");

	--SetTextStatusBarTextPrefix(PlayerFrameHealthBar, TEXT(HEALTH));
	--SetTextStatusBarTextPrefix(PlayerFrameManaBar, TEXT(MANA));
	--SetTextStatusBarTextPrefix(MainMenuExpBar, TEXT(XP));
	-- Tab Handling code
	PanelTemplates_SetNumTabs(this, 7);
	PanelTemplates_SetTab(this, 1);
	UIPanelWindows["CVCharacterFrame"] = { area = "left", pushable = 6, whileDead = 1};
	tinsert(UISpecialFrames,"CVCharacterFrame");
	
	-- Hide the pet Tab
	if ( 1 == 1 ) then
		CVCharacterFrameTab2:Hide();
		CVCharacterFrameTab3:SetPoint("LEFT", "CVCharacterFrameTab2", "LEFT", 0, 0);
	else
		CVCharacterFrameTab2:Show();
		CVCharacterFrameTab3:SetPoint("LEFT", "CVCharacterFrameTab2", "RIGHT", -18, 0);
	end

	-- Hide the Reputation Tab
	if ( 1 == 1 ) then
		CVCharacterFrameTab3:Hide();
		CVCharacterFrameTab4:SetPoint("LEFT", "CVCharacterFrameTab3", "LEFT", 0, 0);
	else
		CVCharacterFrameTab3:Show();
		CVCharacterFrameTab4:SetPoint("LEFT", "CVCharacterFrameTab3", "RIGHT", 18, 0);
	end
	-- Hide the skill Tab
	if ( 1 == 1 ) then
		CVCharacterFrameTab4:Hide();
		CVCharacterFrameTab5:SetPoint("LEFT", "CVCharacterFrameTab4", "LEFT", 0, 0);
	else
		CVCharacterFrameTab4:Show();
		CVCharacterFrameTab5:SetPoint("LEFT", "CVCharacterFrameTab4", "RIGHT", 18, 0);
	end	
	
	-- Hide the Honor  Tab	
	if ( 1 == 1 ) then
		CVCharacterFrameTab5:Hide();
		CVCharacterFrameTab6:SetPoint("LEFT", "CVCharacterFrameTab5", "LEFT", 0, 0);
	else
		CVCharacterFrameTab5:Show();
		CVCharacterFrameTab6:SetPoint("LEFT", "CVCharacterFrameTab5", "RIGHT", 18, 0);
	end
	
	-- Hide the OptionFrame if Khaos is present
	if ( Khaos ) then
		CVCharacterFrameTab7:Hide();
	else
		CVCharacterFrameTab7:Show();
	end

	
	CharactersViewer.Onload();

end

--[[
function CharactersViewer.CharacterFrame.CharacterFrame_OnEvent(event)
	if ( not this:IsVisible() ) then
		return;
	end
	if ( event == "UNIT_PORTRAIT_UPDATE" ) then
		if ( arg1 == "player" ) then
			SetPortraitTexture(CharacterFramePortrait, arg1);
		end
		return;
	elseif ( event == "UNIT_NAME_UPDATE" ) then
		if ( arg1 == "player" ) then
			CharacterNameText:SetText(UnitPVPName(arg1));
		end
		return;
	elseif ( event == "PLAYER_PVP_RANK_CHANGED" ) then
		CharacterNameText:SetText(UnitPVPName("player"));
	end
end
]]--

function CharactersViewer.CharacterFrame.CharacterFrame_OnShow()
	if ( CharactersViewer.index == nil ) then
		CharactersViewer.Api.Switch();
	end
	PlaySound("igCharacterInfoOpen");
	CharactersViewer.CharacterFrame.SetPortrait();
	CVCharacterNameText:SetText(BINDING_HEADER_CHARACTERSVIEWER .. " " .. CharactersViewer.version.text .. " by Flisher");
	--[[UpdateMicroButtons();
	ShowTextStatusBarText(PlayerFrameHealthBar);
	ShowTextStatusBarText(PlayerFrameManaBar);
	ShowTextStatusBarText(MainMenuExpBar);
	ShowTextStatusBarText(PetFrameHealthBar);
	ShowTextStatusBarText(PetFrameManaBar);
	ShowWatchedReputationBarText();
	]]--
	-- modifier pour afficher si visible;
	CharactersViewer.ContainerFrame.ToggleBag(CharactersViewerConfig.ShowBag);
	if (CVBankFrame:IsVisible() == 1 ) then
		CharactersViewerConfig.SelfBank = true;
	else
		--
	end
end

function CharactersViewer.CharacterFrame.CharacterFrame_OnHide()
	PlaySound("igCharacterInfoClose");
	--[[
	UpdateMicroButtons();
	HideTextStatusBarText(PlayerFrameHealthBar);
	HideTextStatusBarText(PlayerFrameManaBar);
	HideTextStatusBarText(MainMenuExpBar);
	HideTextStatusBarText(PetFrameHealthBar);
	HideTextStatusBarText(PetFrameManaBar);
	HideWatchedReputationBarText();
	]]--
	if ( CharactersViewerConfig.SelfBank == nil or CharactersViewerConfig.SelfBank == false ) then
		CharactersViewer.BankFrame.Hide();
	end
end

function CharactersViewer.CharacterFrame.SetPortrait()
	local race = CharactersViewer.Api.GetParam("raceen");
	local sex = CharactersViewer.Api.GetParam("sexid");
	if (race ~= nil  and sex ~= nil ) then
		if (race == "Night Elf") then
			race = "NightElf";
		end
		if ( sex == 0) then
			sex = "Male";
		else
			sex = "Female";
		end
		temp = "Interface\\CharacterFrame\\TemporaryPortrait-" .. sex .. "-" .. race;
   else
		temp = "Interface\\CharacterFrame\\TempPortrait";
   end
	CVCharacterFramePortrait:SetTexture(temp);
end;

function CharactersViewer.CharacterFrame.Relocate()
  UIPanelWindows["CVCharacterFrame"] = { area = "up", pushable = 6 };
  HideUIPanel(CVCharacterFrame);
  ShowUIPanel(CVCharacterFrame);
  UIPanelWindows["CVCharacterFrame"] = nil;
  HideUIPanel(CVCharacterFrame);
  ShowUIPanel(CVCharacterFrame);
  CVCharacterFrame:SetUserPlaced();
end

function CharactersViewer_CharacterFrame_isMovable()
	if ( CharactersViewer.Api.GetConfig("MovableMainFrame") == true ) then
		UIPanelWindows["CVCharacterFrame"] = nil;
		CVCharacterFrame.isLocked = false;
		CVCharacterFrame:SetUserPlaced();
	else
		CVCharacterFrame.isLocked = true;
		CVCharacterFrame:SetUserPlaced(0);
		--tinsert(UISpecialFrames,"CVCharacterFrame");
		UIPanelWindows["CVCharacterFrame"] = { area = "left", pushable = 6, whileDead = 1};
	end
end

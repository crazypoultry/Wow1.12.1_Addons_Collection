-- Copyright (c) 2005 William J. Rogers <wjrogers@gmail.com>
-- This file is released under the terms of the GNU General Public License v2

function GMicroButtons_OnLoad()
	-- replace the default button vars with ours
	CharacterMicroButton = GCharacterMicroButton
	SpellbookMicroButton = GSpellbookMicroButton
	TalentMicroButton = GTalentMicroButton
	QuestLogMicroButton = GQuestLogMicroButton
	MainMenuMicroButton = GMainMenuMicroButton	
	SocialsMicroButton = GSocialsMicroButton
	WorldMapMicroButton = GWorldMapMicroButton
	HelpMicroButton = GHelpMicroButton

	-- and this one for character button
	MicroButtonPortrait = GMicroButtonPortrait
	
	-- and this update function
	UpdateTalentButton = GUpdateTalentButton
end

function GUpdateTalentButton()
	if ( UnitLevel("player") < 10 ) then
		GTalentMicroButton:Hide()
		GQuestLogMicroButton:SetPoint("BOTTOMLEFT", "GTalentMicroButton", "BOTTOMLEFT", 0, 0)
	else	
		GTalentMicroButton:Show()
		GQuestLogMicroButton:SetPoint("BOTTOMLEFT", "GTalentMicroButton", "BOTTOMRIGHT", -2, 0)
	end
end

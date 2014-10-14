
function EDB_Frame_OnLoad()

	-- Set up the frame
	EDB_Frame:SetFrameLevel(1);
	PanelTemplates_SetNumTabs(EDB_Frame, 3);
	PanelTemplates_SetTab(EDB_Frame, 1);

	-- Set up the skill bar
	EDB_Frame_SkillRankFrameSkillName:SetText("Enchanting");
	EDB_Frame_SkillRankFrame:SetStatusBarColor(0.0, 0.0, 1.0, 0.5);
	EDB_Frame_SkillRankFrameBackground:SetVertexColor(0.0, 0.0, 0.75, 0.5);

	-- Make frame closable with escape key
	tinsert(UISpecialFrames, "EDB_Frame");

end

function EDB_Frame_OnShow()

	PlaySound("igCharacterInfoOpen");
	
	if EDB_VERSION then
		EDB_Frame_TitleText:SetText("EnchantingDB "..EDB_VERSION);
	end

end

function EDB_Frame_OnHide()

	PlaySound("igCharacterInfoClose");

	if ( this.isMoving ) then
		this:StopMovingOrSizing();
		this.isMoving = false;
	end

end

function EDB_Frame_Tab_OnClick(frameName)

	PanelTemplates_Tab_OnClick(EDB_Frame);
	EDB_Frame_ShowSubFrame(frameName);
	PlaySound("igCharacterInfoTab");

end

function EDB_Frame_ShowSubFrame(frameName)

	local tabs = { "EDB_Frame_Enchant", "EDB_Frame_Reagent", "EDB_Frame_Options" };

	for _, value in tabs do
		if ( value == frameName ) then
			getglobal(value):Show();
		else
			getglobal(value):Hide();
		end
	end

	if ( frameName == tabs[1] ) then
		EDB_Frame_Enchant_EnchantList_Update();
	end

end

--------------[[ SkillRankFrame Functions ]]--------------

function EDB_Frame_SkillRankFrame_Update()

	local numSkills = GetNumSkillLines();
	local skillLineProfessions, skillLineEnchanting;
	local skill, skillName, skillRank, skillMaxRank;

	-- Find the professions header
	for skill = 1, numSkills do
		local skillName, isHeader, isExpanded = GetSkillLineInfo(skill);
		if (skillName == "Professions") and (isHeader == 1) then
			skillLineProfessions = skill;
			if ( isExpanded == 0 ) then
				ExpandSkillHeader(skill);
			end
			break;
		end
	end

	-- If we found a valid professions header
	if ( skillLineProfessions ) then

		-- Check Proffesions
		skillName, _, _, skillRank, _, _, skillMaxRank = GetSkillLineInfo(skillLineProfessions + 1);

		if ( skillName ~= "Enchanting" ) then

			skillName, _, _, skillRank, _, _, skillMaxRank = GetSkillLineInfo(skillLineProfessions + 2);

			if ( skillName ~= "Enchanting" ) then
				skillRank = 0;
				skillMaxRank = 0;
			end
		end

	else

		skillRank = 0;
		skillMaxRank = 0;

	end

	-- Update the values of the skill bar
	if ( skillMaxRank > 0 ) then
		EDB_Frame_SkillRankFrame:SetMinMaxValues(0, skillMaxRank);
		EDB_Frame_SkillRankFrame:SetValue(skillRank);
		EDB_Frame_SkillRankFrameSkillRank:SetText(skillRank.."/"..skillMaxRank);
	else
		EDB_Frame_SkillRankFrame:SetValue(0);
		EDB_Frame_SkillRankFrameSkillRank:SetText("");
	end

end

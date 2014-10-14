-- Display Main Tanks targets

function ER_TargetsOnLoad()
	ER_targetsUpdate = 0;
	ER_aggroUpdate = 0;
	ER_pulsingButtonsUpdate = 0;
	ER_iconsUpdate = 0;	
	ER_raidTargetIcons = { };

	ER_InitPulsingButtons();
	ER_TargetsFrame_UpdateScale();
	ER_TargetsFrame_LoadLocation();
end

function ER_TargetsOnUpdate(elapsed)
	ER_targetsUpdate = ER_targetsUpdate + elapsed;
	if ( ER_targetsUpdate >= 0.5 ) then
		ER_UpdateTargets();
		ER_targetsUpdate = 0;
	end

	ER_aggroUpdate = ER_aggroUpdate + elapsed;
	if ( ER_aggroUpdate >= 0.5 ) then
		ER_UpdateAggro();
		ER_aggroUpdate = 0;
	end

	ER_pulsingButtonsUpdate = ER_pulsingButtonsUpdate + elapsed;
	if ( ER_pulsingButtonsUpdate >= 0.3 ) then
		ER_UpdatePulsingButtons();
		ER_pulsingButtonsUpdate = 0;
	end

	ER_iconsUpdate = ER_iconsUpdate + elapsed;
	if ( ER_iconsUpdate >= 0.5 ) then
		ER_UpdateIcons();
		ER_iconsUpdate = 0;
	end
end

function ER_TargetsFrame_InitLocation()
	ER_TargetsFrame:ClearAllPoints();
	ER_TargetsFrame:SetPoint("TOPRIGHT", "UIParent", "TOPLEFT", UIParent:GetWidth()/UIParent:GetEffectiveScale() - 100, -250);
	ER_TargetsFrame_SaveLocation();
end

function ER_TargetsFrame_LoadLocation()
	if ( ER_Config.targetsFrameLocation ) then
		local alignment = ER_Config.targetsEffectiveAlignment;
		
		local offsetX = 0;
		if ( ER_Config.mainTanksAreAttached and ER_Config.mainTanksAttachment == "TARGETS"
				and (alignment == "TOPLEFT" or alignment == "BOTTOMLEFT") ) then
			offsetX = ER_MainTanksBuffsWidth;
		end
		
		ER_TargetsFrame:ClearAllPoints();
		ER_TargetsFrame:SetPoint(alignment, "UIParent", "TOPLEFT", ER_Config.targetsFrameLocation.x + offsetX, ER_Config.targetsFrameLocation.y);
	end
end

function ER_TargetsFrame_SaveLocation()
	ER_Config.targetsFrameLocation = { };
	local alignment = ER_GetSmartAlignment(ER_TargetsFrame, ER_Config.targetsAlignment);
	_, _, _, anchorX, anchorY = ER_TargetsFrame:GetPoint(1);
	ER_Config.targetsFrameLocation.x = anchorX;
	ER_Config.targetsFrameLocation.y = anchorY;
	ER_Config.targetsEffectiveAlignment = alignment;
	if ( ER_TargetsFrame:IsUserPlaced() ) then
		ER_TargetsFrame:SetUserPlaced(false);
	end
	ER_TargetsFrame_LoadLocation();
end

function ER_TargetsFrame_UpdateScale()
	ER_TargetsFrame:SetScale(ER_Config.targetsScale/100);
end

-----------------------------------------------------------------------

function ER_TargetsFrame_OnDragStart()
	ER_TargetsFrameIsMovingOrSizing = true;
	ER_TargetsFrame:StartMoving();
end

function ER_TargetsFrame_OnDragStop()
	ER_TargetsFrame:StopMovingOrSizing();
	ER_TargetsFrameIsMovingOrSizing = false;
	ER_SetAnchorPoint(ER_TargetsFrame, ER_Config.targetsAlignment);
	ER_TargetsFrame_SaveLocation();
end

-----------------------------------------------------------------------

function ER_PlayerTargetChanged()
	if ( not ER_isLoaded or not ER_RaidAssistIsAvailable() ) then
		return;
	end

	local i;
	for i=1, NUM_RAID_PULLOUT_FRAMES do
		local frame = getglobal("RaidPullout"..i);
		if ( frame:IsShown() ) then
			local j;
			for j=1, frame.numPulloutButtons do
				local button = getglobal("RaidPullout"..i.."Button"..j);
				if ( button:IsShown() ) then
					ER_UpdateButtonHighlight(button);
				end
			end
		end
	end
end

-----------------------------------------------------------------------

function ER_UpdateButtonHighlight(button)
	if ( UnitIsUnit("target", button.unit) ) then
		if ( not button.isHighlighted ) then
			button:SetBackdrop({bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
					insets = { left = -4, right = -2, top = -4, bottom = -4 }});
			button:SetBackdropColor(1.0, 1.0, 1.0, 0.2);
			button.isHighlighted = true;
		end
	else
		if ( button.isHighlighted ) then
			button:SetBackdrop(nil);
			button.isHighlighted = false;
		end
	end
end

-----------------------------------------------------------------------

function ER_UpdateTargets()
	local i, mt, unit;

	local uniqueTargets = { };
	local numUniqueTargets = 0;
	local targets = { };
	local numTargets = 0;
	local numRealTargets = 0;

	local mainTanksAttached = ER_Config.mainTanksAreAttached and ER_Config.mainTanksAttachment == "TARGETS";
	local showDuplicated = mainTanksAttached or not ER_Config.duplicatedTargetsAreHidden; 

	for i=1, ER_MAX_TARGETS do
		mt = ER_mainTanks[i];
		if ( mt ) then
			local unitTarget = mt.unit.."target";
			if ( UnitExists(unitTarget) and (UnitIsEnemy(mt.unit, unitTarget) or not ER_Config.showHostileTargetsOnly) ) then
				local uniqueTargetIndex;
				local isUnique = true;
				
				local j, uniqueTarget;
				for j, uniqueTarget in uniqueTargets do
					if ( UnitIsUnit(unitTarget, uniqueTarget.unit) ) then
						uniqueTargetIndex = j;
						isUnique = false;
						break;
					end
				end
				if ( isUnique ) then
					numUniqueTargets = numUniqueTargets + 1;
					uniqueTargets[numUniqueTargets] = { ["unit"] = unitTarget, ["name"] = UnitName(unitTarget) };
					uniqueTargetIndex = numUniqueTargets;
				end
			
				if ( isUnique or showDuplicated ) then
					numTargets = numTargets + 1;
					numRealTargets = numRealTargets + 1;
					targets[numTargets] = { ["uniqueTargetIndex"] = uniqueTargetIndex, ["mtNumber"] = i };
				end
			elseif ( showDuplicated ) then
				numTargets = numTargets + 1;
				targets[numTargets] = { };
			end
		end
	end

	for i=1, numUniqueTargets do
		if ( uniqueTargets[i].name and not uniqueTargets[i].suffix ) then
			local suffix = nil;
			local j;
			for j=i+1, numUniqueTargets do
				if ( uniqueTargets[j].name ) then
					if ( uniqueTargets[j].name == uniqueTargets[i].name ) then
						if ( not suffix ) then
							suffix = "A";
							uniqueTargets[i].suffix = suffix;
						end
						suffix = string.char(string.byte(suffix) + 1);
						uniqueTargets[j].suffix = suffix;
					end
				end
			end
		end
	end

	if ( not mainTanksAttached ) then
		for i=numTargets, 1, -1 do
			if ( not targets[i].uniqueTargetIndex ) then
				targets[i] = nil;
				numTargets = numTargets - 1;
			else
				break;
			end
		end
	end

	local spaces, numSpaces;
	if ( showDuplicated ) then
		spaces, numSpaces = ER_GetMainTanksSpaces(numTargets);
	else
		spaces, numSpaces = {}, 0;
	end

	if ( ER_Config.targetsAreShown ) then
		for i=1, ER_MAX_TARGETS do
			local button = getglobal("ER_TargetsFrameButton"..i);
			if ( i <= numTargets ) then
				local target = nil;
				local uniqueTargetIndex = targets[i].uniqueTargetIndex;
				if ( uniqueTargetIndex ) then
					target = uniqueTargets[uniqueTargetIndex];
				end
				local mtNumber = targets[i].mtNumber;

				if ( i > 1 ) then
					local texture = getglobal("ER_TargetsFrameButton"..i.."TopBar");
					if ( spaces[i] ) then
						button:SetPoint("TOP", "ER_TargetsFrameButton"..(i - 1), "BOTTOM", 0, -13);
						if ( not texture ) then
							texture = ER_TargetsFrame:CreateTexture("ER_TargetsFrameButton"..i.."TopBar", "BACKGROUND");
							texture:SetTexture("Interface\\Tooltips\\UI-Tooltip-Border");
							texture:SetWidth(74);
							texture:SetHeight(9);
							texture:SetTexCoord(0.6, 0.65, 0, 0.5);
							texture:SetVertexColor(1, 1, 1, 0.7);
							texture:SetPoint("TOP", button, "TOP", -1, 11.5);
						elseif ( not texture:IsShown() ) then
							texture:Show();
						end
					else
						button:SetPoint("TOP", "ER_TargetsFrameButton"..(i - 1), "BOTTOM", 0, -8);
						if ( texture and texture:IsShown() ) then
							texture:Hide();
						end
					end
				end
				
				if ( target ) then
					button.unit = target.unit;
					
					local buttonName = getglobal("ER_TargetsFrameButton"..i.."Name");
					local name = target.name;
					if ( showDuplicated and not mainTanksAttached ) then
						name = "|c00ffff00"..mtNumber..".|r "..name;
					end
					buttonName:SetText(name);
					
					local buttonSuffix = getglobal("ER_TargetsFrameButton"..i.."Suffix");
					if ( target.suffix ) then
						buttonName:SetWidth(58);
						buttonSuffix:SetText("("..target.suffix..")");
					else
						buttonName:SetWidth(76);
						buttonSuffix:SetText("");
					end
		
					local healthBar = getglobal("ER_TargetsFrameButton"..i.."HealthBar");
					local currValue = UnitHealth(target.unit);
					local maxValue = UnitHealthMax(target.unit);
					healthBar:SetMinMaxValues(0, maxValue);
					healthBar:SetValue(currValue);
					local ratioValue = currValue/maxValue;
					local r, g;
					if ( ratioValue > 0.5 ) then
						r = (1.0 - ratioValue) * 2;
						g = 1.0;
					else
						r = 1.0;
						g = ratioValue * 2;
					end
					healthBar:SetStatusBarColor(r, g, 0);
		
					local healthBarText = getglobal("ER_TargetsFrameButton"..i.."HealthBarText");
					healthBarText:SetText(floor(currValue/maxValue*100).."%");
		
					local manaBar = getglobal("ER_TargetsFrameButton"..i.."ManaBar");
					local info = ManaBarColor[UnitPowerType(target.unit)];
					manaBar:SetStatusBarColor(info.r, info.g, info.b);
					local currValue = UnitMana(target.unit);
					local maxValue = UnitManaMax(target.unit);
					manaBar:SetMinMaxValues(0, maxValue);
					manaBar:SetValue(currValue);
					
					local index = GetRaidTargetIndex(target.unit);
					if ( button.raidTargetIndex ~= index ) then
						local raidTargetIcon = getglobal("ER_TargetsFrameButton"..i.."RaidTargetIcon");
						if ( index ) then
							SetRaidTargetIconTexture(raidTargetIcon, index);
							raidTargetIcon:Show();
						else
							if ( raidTargetIcon:IsShown() ) then
								raidTargetIcon:Hide();
							end
						end
						button.raidTargetIndex = index;
					end
		
					ER_UpdateButtonHighlight(button);
		
					if ( not button:IsShown() ) then
						button:Show();
					end
				else
					if ( button:IsShown() ) then
						button:Hide();
					end
				end
			else
				if ( button:IsShown() ) then
					button:Hide();
				end
			end
		end
	end

	for i=numTargets+1, ER_MAX_TARGETS do
		local texture = getglobal("ER_TargetsFrameButton"..i.."TopBar");
		if ( texture and texture:IsShown() ) then
			texture:Hide();
		end
	end

	ER_TargetsFrame:SetHeight(numTargets * ER_TARGET_BUTTON_HEIGHT + numSpaces * 5 + 12);
		
	if ( ER_Config.targetsAreShown and numTargets > 0 and numRealTargets > 0 ) then
		if ( not ER_TargetsFrame:IsShown() ) then
			ER_TargetsFrame:Show();
			if ( ER_Config.mainTanksAreAttached and ER_Config.mainTanksAttachment == "TARGETS" ) then
				ER_RaidPulloutFrame_Update();
			end
		end
	else
		if ( ER_TargetsFrame:IsShown() ) then
			ER_TargetsFrame:Hide();
			if ( ER_Config.mainTanksAreAttached and ER_Config.mainTanksAttachment == "TARGETS" ) then
				ER_RaidPulloutFrame_Update();
			end
		end
	end
end

function ER_TargetButton_OnClick()
	ER_RaidPulloutButton_OnClick();
end

function ER_TargetButtonOnClick()
	-- Deprecated but JustClick 1.1.0 tries to hook this function
end

function ER_TargetButton_OnDoubleClick()
	ER_RaidPulloutButton_OnDoubleClick();
end

function ER_TargetButton_OnEnter(button)
	if ( SpellIsTargeting() ) then
		if ( SpellCanTargetUnit(button.unit) ) then
			SetCursor("CAST_CURSOR");
		else
			SetCursor("CAST_ERROR_CURSOR");
		end
	end

	GameTooltip_SetDefaultAnchor(GameTooltip, button);
	
	if ( GameTooltip:SetUnit(button.unit) ) then
		button.updateTooltip = TOOLTIP_UPDATE_TIME;
	else
		button.updateTooltip = nil;
	end

	button.r, button.g, button.b = GameTooltip_UnitColor(button.unit);
	GameTooltipTextLeft1:SetTextColor(button.r, button.g, button.b);	
end

-----------------------------------------------------------------------

function ER_UpdateAggro()
	local targets = { };
	local numTargets = 0;
	local unit, unitTarget, target, targetTarget;
	local frame, button;
	local i, j;

	for i = 1, GetNumRaidMembers() do
		unit = "raid"..i;
		unitTarget = unit.."target";
		if ( UnitExists(unitTarget) and UnitIsEnemy(unit, unitTarget) ) then
			local isUnique = true;
			for _, target in targets do
				if ( UnitIsUnit(target, unitTarget) ) then
					isUnique = false;
					break;
				end
			end
			if ( isUnique ) then
				numTargets = numTargets + 1;
				targets[numTargets] = unitTarget;
			end
		end
	end
	
	ER_ResetPulsingButtons();
	
	for _, target in targets do
		targetTarget = target.."target";
		
		if ( ER_Config.highlightAttackedPlayers ) then
			for i=1, NUM_RAID_PULLOUT_FRAMES do
				frame = getglobal("RaidPullout"..i);
				if ( frame:IsShown() ) then
					for j=1, frame.numPulloutButtons do
						button = getglobal("RaidPullout"..i.."Button"..j);
						if ( button:IsShown() and UnitIsUnit(button.unit, targetTarget) ) then
							ER_AddPulsingButton(button);
						end
					end
				end
			end
		end

		if ( ER_Config.soundsOnAggro and UnitIsUnit(targetTarget, "player") ) then
			if ( ER_playerHasAggro == nil ) then
				ER_AggroAlert();
			end
			ER_playerHasAggro = true;
		end
	end
	
	if ( ER_playerHasAggro ~= nil ) then
		if ( not ER_playerHasAggro ) then
			ER_playerHasAggro = nil;
		else
			ER_playerHasAggro = false;
		end
	end	
end

function ER_InitPulsingButtons()
	ER_pulsingButtons = { };
end

function ER_AddPulsingButton(button)
	ER_pulsingButtons[button] = true;
end

function ER_ResetPulsingButtons()
	local button;
	for button in ER_pulsingButtons do
		ER_pulsingButtons[button] = false;
	end
end

function ER_UpdatePulsingButtons()
	local button, buttonFrame;

	ER_pulseState = not ER_pulseState;

	for button in ER_pulsingButtons do
		buttonFrame = getglobal(button:GetName().."Frame");
		if ( ER_pulsingButtons[button] == true ) then
			if ( ER_pulseState ) then
				buttonFrame:SetVertexColor(1, 0, 0, 1);
				buttonFrame:SetBlendMode("ADD");
			else
				buttonFrame:SetVertexColor(1, 1, 1, 0.2);
				buttonFrame:SetBlendMode("BLEND");
			end
		else
			buttonFrame:SetVertexColor(1, 1, 1, 1);
			buttonFrame:SetBlendMode("BLEND");
			ER_pulsingButtons[button]  = nil;
		end
	end
end

function ER_AggroAlert()
	if ( ER_RaidAssistHasMTSupport() and ER_Config.soundsOnAggro ) then
		local time = GetTime();
		if ( not ER_lastAggroAlertTime or time - ER_lastAggroAlertTime >= 1 ) then
			PlaySoundFile("Interface\\AddOns\\EasyRaid\\Sounds\\AggroAlert.wav");
			ER_lastAggroAlertTime = time;
		end
	end
end

-----------------------------------------------------------------------

function ER_UpdateIcons()
	if ( not (ER_Config.automaticallySetTargetsIcons and (IsRaidLeader() or IsRaidOfficer())) ) then
		return;
	end

	if ( GetRaidTargetIndex("player") ) then
		SetRaidTarget("player", 0);
	end

	local i = 0;
	local index = 1;
	local mt, target, mtHasUniqueTarget, currentIndex;
	local numMTs = 0;
	
	for _, _ in ER_mainTanks do
		numMTs = numMTs + 1;
	end
	
	for _, mt in ER_mainTanks do
		if ( numMTs - i <= 8 ) then -- Skip first MTs if they are more than 8
			-- if ( GetRaidTargetIndex(mt.unit) ) then
			--	SetRaidTarget(mt.unit, 0); -- Remove icons on MTs
			-- end
			
			target = mt.unit.."target";
			mtHasUniqueTarget = false;
			if ( UnitExists(target) and (not UnitInRaid(target)) ) then
				currentIndex = GetRaidTargetIndex(target) or 0;
				if ( currentIndex == 0 or currentIndex == index or (currentIndex > index and not UnitAffectingCombat(mt.unit)) ) then
					if ( currentIndex ~= index ) then
						SetRaidTarget(target, index);
						ER_raidTargetIcons[index] = true;
						if ( currentIndex ~= 0 ) then
							ER_raidTargetIcons[currentIndex] = nil;
						end
					end
					mtHasUniqueTarget = true;
				end
			end
			
			if ( not mtHasUniqueTarget ) then
				if ( ER_raidTargetIcons[index] ) then
					-- SetRaidTarget(mt.unit, index); -- Temporary put the icon on the MT and clear it later
					SetRaidTarget("player", index);
					ER_raidTargetIcons[index] = nil;
				end
			end
			
			index = index + 1;
		end		
		i = i + 1;
	end
end

-----------------------------------------------------------------------

function ER_GetRaidUnitByName(name)
	local i;
	for i = 1, GetNumRaidMembers() do
		local unit = "raid"..i;
		if (UnitName(unit) == name) then
			return unit, i;
		end
	end
end
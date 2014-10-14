-- EasyRaid 2.3.2
-- Automatically display raid subgroups and classes
-- Created by Soin (EU-Vol'jin) on January 13, 2006

ER_isLoaded = false;

ER_UPDATE_INTERVAL = 3;
ER_timeSinceLastUpdate = 0;

ER_RANGE_CHECK_INTERVAL = 0.3;
ER_timeSinceLastRangeCheck = 0;
ER_isRangeChecking = false;

ER_ContainerFrameIsMovingOrSizing = false;

ER_raidIsShown = true;

function ER_OnLoad()
	DEFAULT_CHAT_FRAME:AddMessage(ER_VERSION_STRING.." loaded.", 1, 1, 1);

	if ( not ER_Config ) then
		ER_InitConfig();
	end
	
	ER_UpdateConfig();
	
	ER_Config["buffsAreShown"] = false; -- Saved but should be always false

	-- Register the addon in myAddOns
	if ( myAddOnsFrame_Register ) then
		myAddOnsFrame_Register(ER_MYADDONS_DETAILS);
	end
	
	ER_ContainerFrame_LoadLocation();

	if ( not FriendsFrame:IsUserPlaced() ) then
		FriendsFrame:SetPoint("TOPLEFT", "UIParent", "CENTER", -FriendsFrame:GetWidth()/2, FriendsFrame:GetHeight()/2);
	end
	UIPanelWindows["FriendsFrame"] = nil;
	tinsert(UISpecialFrames,"FriendsFrame");
	
	RaidFrame:SetScript("OnShow", ER_RaidFrame_OnShow);
	RaidFrame:SetScript("OnHide", ER_RaidFrame_OnHide);
	
	if ( NUM_RAID_PULLOUT_FRAMES ) then
		ER_Load();
	end
	
	if ( ER_RaidAssistHasMTSupport() ) then
		ER_MainTanksOnLoad();
		ER_TargetsOnLoad();
	end
end

function ER_Load()
	if ( IsAddOnLoaded("MiniBlizzRaid") ) then
		message("EasyRaid can't work with MiniBlizzRaid (this add-on removes the Blizzard Raid UI).");
		return;
	end

	ER_isLoaded = true;

	-- Hook RaidPullout_Update
	ER_SavedRaidPullout_Update = RaidPullout_Update;
	RaidPullout_Update = ER_RaidPullout_Update;

	-- Hook RefreshBuffs
	ER_SavedRefreshBuffs = RefreshBuffs;
	RefreshBuffs = ER_RefreshBuffs;

	-- Hook RaidGroupFrame_OnUpdate
	ER_SavedRaidGroupFrame_OnUpdate = RaidGroupFrame_OnUpdate;
	RaidGroupFrame_OnUpdate = ER_RaidGroupFrame_OnUpdate;
	RaidFrame:SetScript("OnUpdate", RaidGroupFrame_OnUpdate);

	-- Hook RaidGroupButton_OnDragStart
	ER_SavedRaidGroupButton_OnDragStart = RaidGroupButton_OnDragStart;
	RaidGroupButton_OnDragStart = ER_RaidGroupButton_OnDragStart;

	-- Hook RaidGroupButton_OnDragStop
	ER_SavedRaidGroupButton_OnDragStop = RaidGroupButton_OnDragStop;
	RaidGroupButton_OnDragStop = ER_RaidGroupButton_OnDragStop;

	-- Blizzard_RaidUI.lua changes OnHide script 
	RaidFrame:SetScript("OnHide", ER_RaidFrame_OnHide);

	-- Hook UseAction to handle selfcast
	ER_SavedUseAction = UseAction;
	UseAction = ER_UseAction;

	ER_previousShowCastableBuffs = SHOW_CASTABLE_BUFFS;
	ER_previousShowDispellableDebuffs = SHOW_DISPELLABLE_DEBUFFS;

	ER_RaidPulloutFrame_UpdateTitle();
	ER_RaidPulloutFrame_UpdateBackground();
	ER_RaidPulloutFrame_Update();
end

function ER_OnPlayerEnteringWorld()
	ER_SetPaladinOrShaman();
end

function ER_OnUpdateWorldStates()
	if ( time()-(ER_lastUpdateWorldStatesTime or 0) >= 1 ) then
		ER_RaidPulloutFrame_UpdateContent();
		ER_lastUpdateWorldStatesTime = time();
	end
end

function ER_OnRaidRosterUpdate()
	ER_RaidPulloutFrame_Update();
	ER_UpdateMainTanks();
	ER_PlayerTargetChanged();
end

function ER_OnChatMsgAddon(prefix, message, destination, sender)
	-- ER_Debug(prefix.." | "..message.." | "..destination.." | "..sender);
end

function ER_OnUpdate(elapsed)
	if ( ER_isLoaded ) then
		ER_timeSinceLastUpdate = ER_timeSinceLastUpdate + elapsed;
		if ( ER_timeSinceLastUpdate > ER_UPDATE_INTERVAL ) then
			ER_RaidPulloutFrame_Update();

			-- AceHeal bug fix: AceHeal try to hook RaidPulloutButton_OnClick before Blizzard_RaidUI loading
			if ( AceHealBliz and AceHealBliz.Msg ) then
				if ( not AceHealBliz.Hooks or not AceHealBliz.Hooks['RaidPulloutButton_OnClick'] ) then
					AceHealBliz:Hook("RaidPulloutButton_OnClick","BlizRaidPulloutClick");
					AceHealBliz:Hook("RaidGroupButton_OnClick", "BlizRaidGroupClick");
					AceHealBliz.Msg("Found Blizard Raid frames hooking %s","RaidGroupButton_OnClick");
				end
			end

			ER_timeSinceLastUpdate = 0;
		end

		if ( ER_previousShowCastableBuffs ~= SHOW_CASTABLE_BUFFS or ER_previousShowDispellableDebuffs ~= SHOW_DISPELLABLE_DEBUFFS ) then
			ER_RaidPulloutFrame_UpdateBuffs();
			ER_previousShowCastableBuffs = SHOW_CASTABLE_BUFFS;
			ER_previousShowDispellableDebuffs = SHOW_DISPELLABLE_DEBUFFS;
		end

		if ( ER_isRangeChecking ) then
			ER_timeSinceLastRangeCheck = ER_timeSinceLastRangeCheck + elapsed;
			if ( ER_timeSinceLastRangeCheck > ER_RANGE_CHECK_INTERVAL ) then
				if ( SpellIsTargeting() ) then
					ER_RaidPulloutFrame_UpdateRangeCheck();
					ER_timeSinceLastRangeCheck = 0;				
				else
					ER_isRangeChecking = false;
					ER_RaidPulloutFrame_Update();
				end
			end
		end

		if ( ER_RaidAssistHasMTSupport() ) then
			ER_MainTanksOnUpdate(elapsed);
			ER_TargetsOnUpdate(elapsed);
		end
	end
end

function EB_PlayerEnterInCombat()
	if ( ER_Config.buffsAreShown and ER_Config.debuffsAreShownInCombat ) then
		ER_Config.buffsAreShown = false;
		if ( ER_Config.allGroupsAreShownWhenBuffsAreShown ) then
			ER_RaidPulloutFrame_Refresh();
		else
			ER_RaidPulloutFrame_UpdateBuffs();
		end
		ER_OptionsSideFrame_Update();	
	end
end

function ER_RaidPulloutFrame_Update()
	if ( not ER_isLoaded ) then
		return;
	end

	if ( not UIParent:IsShown() ) then
		return;
	end

	local numRaidMembers = GetNumRaidMembers();
	if ( numRaidMembers == 0 ) then
		return;
	end

	local i;
	local playerGroupNumber;

	-- Find player group number
	for i=1, numRaidMembers do
		local name, _, subgroup = GetRaidRosterInfo(i);
		if ( name == UnitName("player") ) then
			playerGroupNumber = subgroup;
			break;
		end
	end
	
	if ( not playerGroupNumber ) then
		return;
	end
	
	if ( not RAID_SUBGROUP_LISTS[playerGroupNumber] or getn(RAID_SUBGROUP_LISTS[playerGroupNumber]) < 1 ) then
		return; -- Avoid an error when RAID_SUBGROUP_LISTS is not intialized
	end

	if ( ER_ContainerFrameIsMovingOrSizing ) then
		ER_UPDATE_INTERVAL = 0.25;
	else
		ER_UPDATE_INTERVAL = 5;
	end

	if ( ER_TargetsFrameIsMovingOrSizing ) then
		return;
	end
	
	-- Hide party frames
	RaidOptionsFrame_UpdatePartyFrames();

	-- Clear hidden frames
	for i=1, NUM_RAID_PULLOUT_FRAMES do
		local frame = getglobal("RaidPullout"..i);
		if ( frame.filterID and not frame:IsShown() ) then
			frame.filterID = nil;
		end
	end

	ER_PreviousRaidPulloutFrameNameX = nil;
	ER_PreviousRaidPulloutFrameNameY = nil;
	ER_RaidPulloutFrameBuffsWidth = 0;
	ER_FirstRaidPulloutFrame = nil;
	ER_RaidPulloutFrameMaxX = nil;
	ER_RaidPulloutFrameMinY = nil;
	
	local buffsMode = ER_Config.buffsAreShown and ER_Config.allGroupsAreShownWhenBuffsAreShown;
	
	-- Show player group
	if ( ER_Config.playerGroupIsShown and (not buffsMode or not ER_raidIsShown) ) then
		ER_RaidPullout_GenerateFrame(playerGroupNumber);
	end

	-- Show main tanks
	if ( ER_Config.mainTanksAreShown and ER_mainTanks and ((not buffsMode or not ER_raidIsShown)
			or not(ER_Config.mainTanksAreAttached and ER_Config.mainTanksAttachment == "RAID")) ) then
		ER_RaidPullout_GenerateFrame("MAINTANKS");
	end
	
	-- Show groups
	local group;
	for _, group in ER_Config.groups do
		if ( (group.isShown or buffsMode) and ER_raidIsShown ) then
			if ( not (ER_Config.playerGroupIsShown and group.number == playerGroupNumber) or buffsMode ) then
				ER_RaidPullout_GenerateFrame(group.number);
			end
		end
	end
	
	-- Show classes
	local class;
	for _, class in ER_Config.classes do
		if ( class.isShown and not buffsMode and ER_raidIsShown ) then
			ER_RaidPullout_GenerateFrame(class.name);
		end
	end

	-- Show targets
	--if ( ER_Config.targetsAreShown ) then
	--	ER_RaidPullout_GenerateFrame("TARGETS");
	--end
	
	if ( ER_FirstRaidPulloutFrame ) then
		local alignment = ER_GetSmartAlignment(ER_ContainerFrame, ER_Config["alignment"]);		
		if ( alignment == "TOPRIGHT" ) then
			ER_FirstRaidPulloutFrame:SetPoint("TOPLEFT", "ER_ContainerFrame", "TOPLEFT", 4 + (ER_ContainerFrame:GetRight()/(ER_Config.scale/100) - ER_RaidPulloutFrameMaxX) - 4, -4+ER_RaidPulloutFrameOffsetY);
		elseif ( alignment == "BOTTOMLEFT" ) then
			ER_FirstRaidPulloutFrame:SetPoint("TOPLEFT", "ER_ContainerFrame", "TOPLEFT", 4, -4 + ER_RaidPulloutFrameOffsetY + (ER_ContainerFrame:GetBottom()/(ER_Config.scale/100) - ER_RaidPulloutFrameMinY) + 4);
		elseif ( alignment == "BOTTOMRIGHT" ) then
			ER_FirstRaidPulloutFrame:SetPoint("TOPLEFT", "ER_ContainerFrame", "TOPLEFT", 4 + (ER_ContainerFrame:GetRight()/(ER_Config.scale/100) - ER_RaidPulloutFrameMaxX) - 4, -4 + ER_RaidPulloutFrameOffsetY + (ER_ContainerFrame:GetBottom()/(ER_Config.scale/100) - ER_RaidPulloutFrameMinY) + 4);
		end
	end
end

function ER_RaidPullout_GenerateFrame(id)
	local i;
	local frame;
	
	-- Find a frame with filterID is id
	for i=1, NUM_RAID_PULLOUT_FRAMES do
		local searchFrame = getglobal("RaidPullout"..i);
		
		if ( searchFrame.filterID == id ) then
			frame = searchFrame;
			break;
		end
	end

	-- Generate the frame if it doesn't exist
	if ( not frame ) then
		if ( type(id) == "number" ) then
			frame = RaidPullout_GenerateGroupFrame(id);
		elseif ( id == "MAINTANKS" ) then
			frame = RaidPullout_GenerateClassFrame("MTs", id);
		elseif ( id == "TARGETS" ) then
			frame = RaidPullout_GenerateClassFrame(ER_TARGETS, id);
		else
			frame = RaidPullout_GenerateClassFrame(ER_CLASSES_NAME[id], id);
		end
	end
	
	if ( frame ) then
		if ( not frame.initialized ) then
			frame:SetWidth(84);
			frame:RegisterForClicks();
			frame:SetScript("OnDragStart", ER_RaidPullout_OnDragStart);
			frame:SetScript("OnDragStop", ER_RaidPullout_OnDragStop);
			getglobal(frame:GetName().."DropDown"):Hide();
			frame.initialized = true;
			if ( not ER_Config.titleOfTheFramesIsShown ) then
				getglobal(frame:GetName().."Name"):Hide();
			else
				getglobal(frame:GetName().."Name"):Show();
			end
		end

		-- Calculate buffs width
		local buffsWidth = 0;
		for i=1, frame.numMembers do
			local width = ceil(getglobal(frame:GetName().."Button"..i).numBuffs/2) * 13;
			if ( width > buffsWidth ) then
				buffsWidth = width;
			end
		end
		
		if ( id ~= "MAINTANKS" or (ER_Config.mainTanksAreAttached and ER_Config.mainTanksAttachment == "RAID") ) then
			-- Set frame location
			frame:ClearAllPoints();
			if ( ER_PreviousRaidPulloutFrameNameY ) then				
				if ( getglobal(ER_PreviousRaidPulloutFrameNameY):GetBottom()-frame:GetHeight()+ER_RaidPulloutFrameOffsetY > ER_ContainerFrame:GetBottom()/(ER_Config.scale/100) ) then
					frame:SetPoint("TOPLEFT", ER_PreviousRaidPulloutFrameNameY, "BOTTOMLEFT", 0, ER_RaidPulloutFrameOffsetY);
				else
					frame:SetPoint("TOPLEFT", ER_PreviousRaidPulloutFrameNameX, "TOPRIGHT", ER_RaidPulloutFrameBuffsWidth + ER_RAID_PULLOUT_FRAME_OFFSET_X, 0);
					
					ER_PreviousRaidPulloutFrameNameX = frame:GetName();
					ER_RaidPulloutFrameBuffsWidth = buffsWidth;
				end
			else
				frame:SetPoint("TOPLEFT", "ER_ContainerFrame", "TOPLEFT", 4, -4+ER_RaidPulloutFrameOffsetY);
				ER_PreviousRaidPulloutFrameNameX = frame:GetName();
				ER_FirstRaidPulloutFrame = frame;
			end
						
			ER_PreviousRaidPulloutFrameNameY = frame:GetName();			
			if ( buffsWidth > ER_RaidPulloutFrameBuffsWidth ) then
				ER_RaidPulloutFrameBuffsWidth = buffsWidth;
			end
			
			local x = frame:GetRight() + ER_RaidPulloutFrameBuffsWidth;
			if ( not ER_RaidPulloutFrameMaxX or x > ER_RaidPulloutFrameMaxX ) then
				ER_RaidPulloutFrameMaxX = x;
			end
			local y = frame:GetBottom();
			if ( not ER_RaidPulloutFrameMinY or y < ER_RaidPulloutFrameMinY ) then
				ER_RaidPulloutFrameMinY = y;
			end
			
			frame:SetScale(ER_Config.scale/100);
		else -- MTs are not attached to the raid
			if ( ER_Config.mainTanksAreAttached and ER_Config.mainTanksAttachment == "TARGETS" ) then
				ER_MainTanksBuffsWidth = buffsWidth;

				local alignment = ER_Config.targetsEffectiveAlignment;

				frame:ClearAllPoints();
				if ( ER_TargetsFrame:IsShown() or (alignment == "TOPLEFT" or alignment == "BOTTOMLEFT") ) then
					frame:SetPoint("TOPRIGHT", ER_TargetsFrame, "TOPLEFT", 0 - ER_MainTanksBuffsWidth - ER_RAID_PULLOUT_FRAME_OFFSET_X, 0);
				else
					frame:SetPoint("TOPRIGHT", ER_TargetsFrame, "TOPRIGHT", 0, 0);
				end
				
				frame:SetScale(ER_TargetsFrame:GetScale());

				if ( alignment == "TOPLEFT" or alignment == "BOTTOMLEFT" ) then
					ER_TargetsFrame_LoadLocation();
				end
			else
				ER_MainTanksPlaceHolder:SetHeight(frame:GetHeight());
				frame:ClearAllPoints();
				local alignment = ER_MainTanksPlaceHolder:GetPoint();
				frame:SetScale(ER_MainTanksPlaceHolder:GetScale());
				frame:SetPoint(alignment, ER_MainTanksPlaceHolder, alignment);
			end
		end		
	end
	
	return frame;
end

function ER_GetSmartAlignment(frame, alignment)
	if ( alignment == "SMART" ) then
		local screenX, screenY = UIParent:GetCenter();
		screenX = screenX * UIParent:GetEffectiveScale();
		screenY = screenY - 50;
		screenY = screenY * UIParent:GetEffectiveScale();		
		local frameX, frameY = frame:GetCenter();
		frameX = frameX * frame:GetEffectiveScale();
		frameY = frameY * frame:GetEffectiveScale();
		
		local alignmentX, alignmentY;
		
		if ( frameX < screenX ) then
			alignmentX = "LEFT";
		else
			alignmentX = "RIGHT";
		end
		
		if ( frameY > screenY ) then
			alignmentY = "TOP";
		else
			alignmentY = "BOTTOM";
		end
		
		alignment = alignmentY..alignmentX;
	end
	
	return alignment;
end

function ER_SetAnchorPoint(frame, alignment)
	alignment = ER_GetSmartAlignment(frame, alignment)

	local point, relativeObject, relativePoint, x, y = frame:GetPoint(1);
	if ( point and point ~= alignment ) then
		local width, height = frame:GetWidth(), frame:GetHeight();
		local left, top, right, bottom;
		if ( point == "TOPLEFT" ) then
			left = x;
			top = y;
			right = x + width;
			bottom = y - height;
		elseif ( point == "TOPRIGHT" ) then
			left = x - width;
			top = y;
			right = x;
			bottom = y - height;
		elseif ( point == "BOTTOMLEFT" ) then
			left = x;
			top = y + height;
			right = x + width;
			bottom = y;
		elseif ( point == "BOTTOMRIGHT" ) then
			left = x - width;
			top = y + height;
			right = x;
			bottom = y;
		end

		local newX, newY;
		if ( alignment == "TOPLEFT" ) then
			newX, newY = left, top;
		elseif ( alignment == "TOPRIGHT" ) then
			newX, newY = right, top;
		elseif ( alignment == "BOTTOMLEFT" ) then
			newX, newY = left, bottom;
		elseif ( alignment == "BOTTOMRIGHT" ) then
			newX, newY = right, bottom;
		end
		
		frame:ClearAllPoints();
		frame:SetPoint(alignment, UIParent, "TOPLEFT", newX, newY);
	end
end

function ER_RaidPulloutFrame_UpdateTitle()
	if ( ER_isLoaded ) then
		local i;
	
		for i=1, NUM_RAID_PULLOUT_FRAMES do
			local frame = getglobal("RaidPullout"..i);
			
			if ( not ER_Config.titleOfTheFramesIsShown ) then
				getglobal(frame:GetName().."Name"):Hide();
			else
				getglobal(frame:GetName().."Name"):Show();
			end
		end
	
		if ( not ER_Config.titleOfTheFramesIsShown ) then
			ER_RaidPulloutFrameOffsetY = 0;
		else
			ER_RaidPulloutFrameOffsetY = -12;
		end
	end
end

function ER_RaidPulloutFrame_UpdateBuffs()
	if ( ER_isLoaded ) then
		local i, j;	
		for i=1, NUM_RAID_PULLOUT_FRAMES do
			local frame = getglobal("RaidPullout"..i);
			if ( frame:IsShown() ) then
				for j=1, frame.numPulloutButtons do
					local button = getglobal("RaidPullout"..i.."Button"..j);
					if ( button:IsShown() ) then
						RefreshBuffs(button, "?", button.unit);
					end
				end
			end
		end
	end
end

function ER_RaidPulloutFrame_UpdateBackground()
	if ( ER_isLoaded ) then
		local i;
	
		for i=1, NUM_RAID_PULLOUT_FRAMES do
			local background = getglobal("RaidPullout"..i.."MenuBackdrop");
			if ( ER_Config.backgroundIsShown ) then
				background:Show();
			else
				background:Hide();
			end
		end
	end
end

function ER_RaidPulloutFrame_UpdateContent()
	if ( ER_isLoaded ) then
		local i;
	
		for i=1, NUM_RAID_PULLOUT_FRAMES do
			local frame = getglobal("RaidPullout"..i);
			
			if ( frame:IsShown() ) then
				RaidPullout_Update(frame);
			end
		end
	end
end

function ER_RaidPulloutFrame_UpdateRangeCheck()
	if ( ER_isLoaded ) then
		local i, j;	
		for i=1, NUM_RAID_PULLOUT_FRAMES do
			local frame = getglobal("RaidPullout"..i);
			if ( frame:IsShown() ) then
				for j=1, frame.numPulloutButtons do
					local button = getglobal("RaidPullout"..i.."Button"..j);
					if ( button:IsShown() ) then
						if ( UnitIsVisible(button.unit) and SpellCanTargetUnit(button.unit) ) then
							button:SetAlpha(1);
							getglobal(button:GetName().."HealthBar"):SetAlpha(1);
							getglobal(button:GetName().."ManaBar"):SetAlpha(1);
						else
							button:SetAlpha(0.8);
							getglobal(button:GetName().."HealthBar"):SetAlpha(0.4);
							getglobal(button:GetName().."ManaBar"):SetAlpha(0.4);
						end
					end
				end
			end
		end
	end
end

function ER_RaidPulloutFrame_Refresh()
	if ( ER_isLoaded ) then
		local i;
	
		for i=1, NUM_RAID_PULLOUT_FRAMES do
			local frame = getglobal("RaidPullout"..i);
			
			if ( frame:IsShown() ) then
				frame:Hide();
			end
		end
		
		ER_RaidPulloutFrame_Update();
		ER_PlayerTargetChanged();
	end
end

-- Hook RaidFrame_LoadUI
function ER_RaidFrame_LoadUI()
	ER_SavedRaidFrame_LoadUI();
	
	if ( not ER_isLoaded ) then
		ER_Load();
	end
end

ER_SavedRaidFrame_LoadUI = RaidFrame_LoadUI;
RaidFrame_LoadUI = ER_RaidFrame_LoadUI;

-- Hook RaidPullout_Update
function ER_RaidPullout_Update(pullOutFrame)
	if ( not pullOutFrame ) then
		pullOutFrame = this;
	end

	local id = pullOutFrame.filterID;

	if ( not id ) then
		return;
	end

	if ( id == "MAINTANKS" ) then
		RAID_SUBGROUP_LISTS[id] = { };
		local mt;
		for _, mt in ER_mainTanks do
			table.insert(RAID_SUBGROUP_LISTS[id], mt.index);
		end
	elseif ( id == "TARGETS" ) then
		RAID_SUBGROUP_LISTS[id] = { };
	end

	local pulloutList = RAID_SUBGROUP_LISTS[id];
	local cleanedPulloutList = { };
	local listIsCleaned = false;
	local playerGroupNumber;
	local playerIndex;
	local i, j;

	if ( getn(RAID_SUBGROUP_LISTS[id]) > 0 ) then
		local numRaidMembers = GetNumRaidMembers();
		
		-- Find group number
		for i=1, numRaidMembers do
			local name, _, subgroup = GetRaidRosterInfo(i);
			if ( name == UnitName("player") ) then
				playerGroupNumber = subgroup;
				playerIndex = i;
				break;
			end
		end
		
		if ( not playerGroupNumber or not RAID_SUBGROUP_LISTS[playerGroupNumber]) then
			message("Unable to find your subgroup");
			return;
		end

		local displayedGroups = { };

		local buffsMode = ER_Config.buffsAreShown and ER_Config.allGroupsAreShownWhenBuffsAreShown;

		if ( ER_Config.playerGroupIsShown and not buffsMode ) then
			displayedGroups[playerGroupNumber] = true;
		end
		
		local group;
		for _, group in ER_Config.groups do
			if ( group.isShown or buffsMode ) then
				displayedGroups[group.number] = true;
			end
		end

		local unitIndex;

		if ( type(id) == "number" ) then
			-- Group
			if ( not displayedGroups[id] ) then
				listIsCleaned = true;
			elseif ( ER_Config.playerIsHidden and not buffsMode ) then
				-- Hide player
				for _, unitIndex in pulloutList do
					if ( unitIndex ~= playerIndex ) then
						table.insert(cleanedPulloutList, unitIndex);
					else
						listIsCleaned = true;
					end
				end
			end
		else
			-- Class
			local alreayDisplayedPlayers = { };
			
			if ( ER_Config.alreadyDisplayedPlayersAreHidden and id ~= "MAINTANKS" ) then				
				local groupNumber;
				for groupNumber in displayedGroups do
					for _, unitIndex in RAID_SUBGROUP_LISTS[groupNumber] do
						alreayDisplayedPlayers[unitIndex] = true;
					end
				end
				
				if ( ER_Config.mainTanksAreShown and ER_mainTanks ) then
					local mt;
					for _, mt in ER_mainTanks do
						alreayDisplayedPlayers[mt.index] = true;
					end
				end
			end
			
			for _, unitIndex in pulloutList do
				if ( id == "MAINTANKS" or (not alreayDisplayedPlayers[unitIndex] and not (ER_Config.playerIsHidden and unitIndex == playerIndex)) ) then
					table.insert(cleanedPulloutList, unitIndex);
				else
					listIsCleaned = true;
				end
			end
		end
	end

	if ( listIsCleaned ) then
		RAID_SUBGROUP_LISTS[id] = cleanedPulloutList;
	end

	local result = ER_SavedRaidPullout_Update(pullOutFrame);

	if ( result ) then
		for i=pullOutFrame.numPulloutButtons, 1, -1 do
			local button = getglobal(pullOutFrame:GetName().."Button"..i);
			if ( not button.initialized ) then
				button:SetWidth(69);
				getglobal(button:GetName().."Frame"):SetWidth(78);
				getglobal(button:GetName().."Name"):SetWidth(72);
				getglobal(button:GetName().."Name"):SetPoint("TOPLEFT", -2, 3);
				getglobal(button:GetName().."HealthBar"):SetWidth(62);
				getglobal(button:GetName().."ManaBar"):SetWidth(62);
				getglobal(button:GetName().."ClearButton"):RegisterForClicks("LeftButtonUp", "RightButtonUp", "MiddleButtonUp", "Button4Up", "Button5Up");
				getglobal(button:GetName().."ClearButton"):SetScript("OnClick", ER_RaidPulloutButton_OnClick);
				getglobal(button:GetName().."ClearButton"):SetScript("OnDoubleClick", ER_RaidPulloutButton_OnDoubleClick);
				
				getglobal(button:GetName().."Debuff2"):SetPoint("TOPLEFT", getglobal(button:GetName().."Debuff1"), "BOTTOMLEFT", 0, -1);
				getglobal(button:GetName().."Debuff3"):SetPoint("TOPLEFT", getglobal(button:GetName().."Debuff1"), "TOPRIGHT", 1, 0);
				getglobal(button:GetName().."Debuff4"):SetPoint("TOPLEFT", getglobal(button:GetName().."Debuff2"), "TOPRIGHT", 1, 0);
					
				for j=1, 4 do
					local buffButton = getglobal(button:GetName().."Debuff"..j);
					buffButton:SetScript("OnEnter", ER_RaidPulloutButton_OnEnter);
				end
				
				for j=5, ER_MAX_BUFFS do
					local buffButton = getglobal("ER_"..button:GetName().."Debuff"..j);
					buffButton:SetParent(button:GetName());
					setglobal(button:GetName().."Debuff"..j, buffButton);
					setglobal(button:GetName().."Debuff"..j.."Icon", getglobal("ER_"..button:GetName().."Debuff"..j.."Icon"));
					setglobal(button:GetName().."Debuff"..j.."Border", getglobal("ER_"..button:GetName().."Debuff"..j.."Border"));
				end
				
				getglobal(button:GetName().."Debuff5"):SetPoint("TOPLEFT", getglobal(button:GetName().."Debuff3"), "TOPRIGHT", 1, 0);
				getglobal(button:GetName().."Debuff6"):SetPoint("TOPLEFT", getglobal(button:GetName().."Debuff5"), "BOTTOMLEFT", 0, -1);
				getglobal(button:GetName().."Debuff7"):SetPoint("TOPLEFT", getglobal(button:GetName().."Debuff5"), "TOPRIGHT", 1, 0);
				getglobal(button:GetName().."Debuff8"):SetPoint("TOPLEFT", getglobal(button:GetName().."Debuff6"), "TOPRIGHT", 1, 0);
				
				button.numBuffs = 0;
				
				button.initialized = true;
			else
				break;
			end
		end
	
		pullOutFrame.numMembers = getn(RAID_SUBGROUP_LISTS[id]);
		
		if ( ER_mainTanks and not ( ER_Config.mainTanksAreShown and id ~= "MAINTANKS" ) ) then
			for i=1, pullOutFrame.numMembers do
				local unit = "raid"..RAID_SUBGROUP_LISTS[id][i];
				local mt, mtNumber;
				for mtNumber, mt in ER_mainTanks do
					if ( mt.unit == unit ) then
						local mtNumberString;
						if ( UnitIsConnected(unit) ) then
							mtNumberString = "|c00ffff00"..mtNumber..".|r";
						else
							mtNumberString = mtNumber;
						end
						getglobal(pullOutFrame:GetName().."Button"..i.."Name"):SetText(mtNumberString.." "..UnitName(unit));
						break;
					end
				end
			end
		end
		
		local spaces, numSpaces;
		if ( id == "MAINTANKS" ) then
			spaces, numSpaces = ER_GetMainTanksSpaces();
		else
			spaces, numSpaces = {}, 0;
		end

		for i=2, pullOutFrame.numMembers do
			local texture = getglobal(pullOutFrame:GetName().."Button"..i.."TopBar");
			if ( spaces[i] ) then
				getglobal(pullOutFrame:GetName().."Button"..i):SetPoint("TOP", pullOutFrame:GetName().."Button"..(i - 1), "BOTTOM", 0, -13);
				if ( not texture ) then
					texture = getglobal(pullOutFrame:GetName().."Button"..i):CreateTexture(pullOutFrame:GetName().."Button"..i.."TopBar", "BACKGROUND");
					texture:SetTexture("Interface\\Tooltips\\UI-Tooltip-Border");
					texture:SetWidth(74);
					texture:SetHeight(9);
					texture:SetTexCoord(0.6, 0.65, 0, 0.5);
					texture:SetVertexColor(0.5, 0.5, 0.5, 0.7);
					texture:SetPoint("TOP", -1, 11.5);
				elseif ( not texture:IsShown() ) then
					texture:Show();
				end
			else
				getglobal(pullOutFrame:GetName().."Button"..i):SetPoint("TOP", pullOutFrame:GetName().."Button"..(i - 1), "BOTTOM", 0, -8);
				if ( texture and texture:IsShown() ) then
					texture:Hide();
				end
			end
		end

		pullOutFrame:SetHeight(pullOutFrame.numMembers * ER_TARGET_BUTTON_HEIGHT + numSpaces * 5 + 12);

		local inInstance, instanceType = IsInInstance();

		for i=1, pullOutFrame.numMembers do
			local unit = "raid"..RAID_SUBGROUP_LISTS[id][i];
			local button = getglobal(pullOutFrame:GetName().."Button"..i);
			
			local healthBarText = getglobal(button:GetName().."HealthBarText");
			if ( ER_RaidAssistUnitIsAFK(unit) ) then
				if ( not healthBarText ) then
					healthBarText = getglobal(button:GetName().."HealthBar"):CreateFontString(
						button:GetName().."HealthBarText", "ARTWORK");
					healthBarText:SetFontObject(GameFontHighlightSmall);
					healthBarText:SetAllPoints(button:GetName().."HealthBar");
					healthBarText:SetText(CHAT_MSG_AFK);
				elseif ( not healthBarText:IsShown() ) then
					healthBarText:Show();
				end
			else
				if ( healthBarText and healthBarText:IsShown() ) then
					healthBarText:Hide();
				end
			end
			
			local raidTargetIndex;

			if ( UnitExists(unit.."target") and (not UnitInRaid(unit.."target")) ) then
				raidTargetIndex = GetRaidTargetIndex(unit.."target");
			end

			if ( not raidTargetIndex ) then
				raidTargetIndex = GetRaidTargetIndex(unit);
			else
				raidTargetIndex = -raidTargetIndex;
			end

			local haveFlag;

			if ( instanceType == "pvp" ) then
				local buff;
				j = 1;
				repeat
					buff = UnitBuff(unit, j);
					local _, _, flag = string.find(buff or "", "INV_BannerPVP_0(%d)");
					if ( flag ) then
						haveFlag = tonumber(flag);
					end
					j = j + 1;
				until haveFlag or not buff;
			end

			if ( haveFlag ) then
				raidTargetIndex = nil;
			end

			if ( button.haveFlag ~= haveFlag ) then
				local flagIcon = getglobal(button:GetName().."FlagIcon");
				local flagFlash = getglobal(button:GetName().."FlagFlash");
				local flagFlashTexture = getglobal(button:GetName().."FlagFlashTexture");
				if ( haveFlag ) then
					if ( not flagIcon ) then
						flagIcon = button:CreateTexture(button:GetName().."FlagIcon", "ARTWORK");
						flagIcon:SetWidth(16);
						flagIcon:SetHeight(16);
						flagIcon:SetPoint("TOPLEFT", -14, -9);
						flagFlash = CreateFrame("Frame", button:GetName().."FlagFlash", button);
						flagFlash:SetWidth(16);
						flagFlash:SetHeight(16);
						flagFlash:SetPoint("TOPLEFT", -14, -9);
						flagFlashTexture = flagFlash:CreateTexture(button:GetName().."FlagFlashTexture", "ARTWORK");
						flagFlashTexture:SetWidth(16);
						flagFlashTexture:SetHeight(16);
						flagFlashTexture:SetPoint("CENTER", 0, 0);
						flagFlashTexture:SetBlendMode("ADD");
					end
					
					if ( haveFlag == 1 ) then
						flagIcon:SetTexture("Interface\\WorldStateFrame\\HordeFlag");
						flagFlashTexture:SetTexture("Interface\\WorldStateFrame\\HordeFlagFlash");
					else
						flagIcon:SetTexture("Interface\\WorldStateFrame\\AllianceFlag");
						flagFlashTexture:SetTexture("Interface\\WorldStateFrame\\AllianceFlagFlash");
					end
					
					flagIcon:Show();
					flagFlash:Show();
					UIFrameFlash(flagFlash, 0.5, 0.5, -1);
				else
					if ( flagIcon and flagIcon:IsShown() ) then
						flagIcon:Hide();
						UIFrameFlashStop(flagFlash);
						flagFlash:Hide();
					end
				end
				
				button.haveFlag = haveFlag;
			end

			if ( button.raidTargetIndex ~= raidTargetIndex ) then
				local raidTargetIcon = getglobal(button:GetName().."RaidTargetIcon");
				if ( raidTargetIndex ) then				
					if ( not raidTargetIcon ) then
						raidTargetIcon = button:CreateTexture(button:GetName().."RaidTargetIcon", "ARTWORK");
						raidTargetIcon:SetWidth(12);
						raidTargetIcon:SetHeight(12);
						raidTargetIcon:SetPoint("TOPLEFT", -13, -10);
						raidTargetIcon:SetTexture("Interface\\TargetingFrame\\UI-RaidTargetingIcons");
					end
					
					SetRaidTargetIconTexture(raidTargetIcon, abs(raidTargetIndex));

					if ( raidTargetIndex > 0 ) then
						raidTargetIcon:SetVertexColor(1, 1, 1, 1);
					else
						raidTargetIcon:SetVertexColor(0.6, 0.6, 0.6, 1);
					end
					
					raidTargetIcon:Show();
				else
					if ( raidTargetIcon and raidTargetIcon:IsShown() ) then
						raidTargetIcon:Hide();
					end
				end
				
				button.raidTargetIndex = raidTargetIndex;
			end

			if ( not ER_isRangeChecking ) then
				if ( UnitIsVisible(unit) ) then
					button:SetAlpha(1);
					getglobal(button:GetName().."HealthBar"):SetAlpha(1);
					getglobal(button:GetName().."ManaBar"):SetAlpha(1);
				else
					button:SetAlpha(0.8);
					getglobal(button:GetName().."HealthBar"):SetAlpha(0.4);
					getglobal(button:GetName().."ManaBar"):SetAlpha(0.4);
				end
			end

			-- Bug fix in Blizzard_RaidUI.lua, HealthBar.unit can be wrong when player is offline
			getglobal(pullOutFrame:GetName().."Button"..i.."HealthBar").unit = unit;
		end
		
		if ( id == playerGroupNumber ) then
			getglobal(pullOutFrame:GetName().."MenuBackdrop"):SetBackdropBorderColor(1, 1, 1);
		else
			getglobal(pullOutFrame:GetName().."MenuBackdrop"):SetBackdropBorderColor(0.5, 0.5, 0.5);
		end
	else
		pullOutFrame.numMembers = 0;
		pullOutFrame.filterID = nil;
	end
	
	if ( listIsCleaned ) then
		RAID_SUBGROUP_LISTS[id] = pulloutList;
	end
	
	return result;
end

-- Hook RefreshBuffs
function ER_RefreshBuffs(button, showBuffs, unit)
	if ( not string.find(button:GetName(), "^RaidPullout") ) then
		ER_SavedRefreshBuffs(button, showBuffs, unit);
		return;
	end

	if ( not button.initialized ) then
		return;
	end

	local castableOrDispellableBuffs = { };
	local otherBuffs = { };
	local maxBuffs;
	local i;
	local buff;

	i = 1;
	repeat
		if ( ER_Config.buffsAreShown ) then
			buff = UnitBuff(unit, i, 1);
		else
			buff = UnitDebuff(unit, i, 1);
		end
		if ( buff ) then
			buff = string.sub(buff, string.len(ER_INTERFACE_ICON_PATH) + 1);
			castableOrDispellableBuffs[buff] = 9999;
			i = i + 1;
		end
	until not buff;
	
	i = 1;
	repeat
		if ( ER_Config.buffsAreShown ) then
			buff = UnitBuff(unit, i);
		else
			buff = UnitDebuff(unit, i);
		end
		if ( buff ) then
			buff = string.sub(buff, string.len(ER_INTERFACE_ICON_PATH) + 1);
			if ( castableOrDispellableBuffs[buff] ) then
				castableOrDispellableBuffs[buff] = i;
			elseif ( ER_Config.buffsAreShown and SHOW_CASTABLE_BUFFS == "0" ) then
				otherBuffs[buff] = i;
			elseif ( (not ER_Config.buffsAreShown) and SHOW_DISPELLABLE_DEBUFFS == "0" ) then
				otherBuffs[buff] = i;
			end
			i = i + 1;
		end
	until not buff;

	if ( ER_Config.buffsAreShown ) then
		maxBuffs = ER_Config.maxBuffs;
	else
		maxBuffs = ER_Config.maxDebuffs;
	end

	local index;
	i = 1;

	for buff, index in pairs(castableOrDispellableBuffs) do
		if ( i > maxBuffs ) then
			break;
		end
		getglobal(button:GetName().."Debuff"..i.."Border"):Show();
		getglobal(button:GetName().."Debuff"..i.."Icon"):SetTexture(ER_INTERFACE_ICON_PATH..buff);
		getglobal(button:GetName().."Debuff"..i):Show();
		getglobal(button:GetName().."Debuff"..i).index = index;
		i = i + 1;
	end
	
	for buff, index in pairs(otherBuffs) do
		if ( i > maxBuffs ) then
			break;
		end
		getglobal(button:GetName().."Debuff"..i.."Border"):Show();
		getglobal(button:GetName().."Debuff"..i.."Icon"):SetTexture(ER_INTERFACE_ICON_PATH..buff);
		getglobal(button:GetName().."Debuff"..i):Show();
		getglobal(button:GetName().."Debuff"..i).index = index;
		i = i + 1;
	end
	
	button.numBuffs = i - 1;
	
	for i = button.numBuffs + 1, ER_MAX_BUFFS do
		getglobal(button:GetName().."Debuff"..i):Hide();
	end
	
	ER_UPDATE_INTERVAL = 1;
end

function ER_RaidPullout_OnDragStart()
	if ( this.filterID ~= "MAINTANKS" or (ER_Config.mainTanksAreAttached and ER_Config.mainTanksAttachment == "RAID") ) then
		if ( not ER_ContainerFrame:IsShown() ) then
			UIFrameFadeIn(ER_ContainerFrame, 1, 0, ER_CONTAINER_FRAME_ALPHA);
		end
		ER_ContainerFrame_StartMoving();
	else
		if ( ER_Config.mainTanksAreAttached and ER_Config.mainTanksAttachment == "TARGETS" ) then
			ER_TargetsFrame_OnDragStart();
		else
			ER_MainTanksPlaceHolder:StartMoving();
		end
	end
end

function ER_RaidPullout_OnDragStop()
	if ( this.filterID ~= "MAINTANKS" or (ER_Config.mainTanksAreAttached and ER_Config.mainTanksAttachment == "RAID") ) then
		ER_ContainerFrame_StopMoving();
	else
		if ( ER_Config.mainTanksAreAttached and ER_Config.mainTanksAttachment == "TARGETS" ) then
			ER_TargetsFrame_OnDragStop();
		else
			ER_MainTanksPlaceHolder:StopMovingOrSizing();
			ER_SetAnchorPoint(ER_MainTanksPlaceHolder, ER_Config.mainTanksAlignment);
			ER_MainTanksPlaceHolder_SaveLocation();
			ER_RaidPulloutFrame_Update();
		end
	end
end

function ER_RaidPulloutButton_OnClick()
	local mouseButton = arg1;
	local unit = this.unit or this:GetParent().unit;
	
	local keyBindingCatched;

	-- JustClick support
	if ( JC_CatchKeyBinding ) then
		keyBindingCatched = JC_CatchKeyBinding(mouseButton, unit);
	end

	-- CastParty support
	if ( not keyBindingCatched ) then
		if ( CastParty_OnClickByUnit ) then
			CastParty_OnClickByUnit(mouseButton, unit);
			keyBindingCatched = true;
		end
	end

	-- ClickHeal support
	if ( not keyBindingCatched ) then
		if ( CH_UnitClicked ) then
			CH_UnitClicked(unit, mouseButton);
			keyBindingCatched = true;
		end
	end
			
	if ( not keyBindingCatched ) then
		if ( mouseButton == "RightButton" and not (IsShiftKeyDown() or IsControlKeyDown() or IsAltKeyDown()) ) then
			ER_UnitFrameDropDown.unit = unit;
			ToggleDropDownMenu(1, nil, ER_UnitFrameDropDown, this, this:GetWidth() + 4, this:GetHeight() + 4);
			if ( DropDownList1:IsShown() ) then
				local screenX, _ = UIParent:GetRight();
				screenX = screenX * UIParent:GetEffectiveScale();
				local frameX, _ = DropDownList1:GetRight();
				frameX = frameX * DropDownList1:GetEffectiveScale();
				if ( frameX >= screenX ) then
					DropDownList1:ClearAllPoints();
					DropDownList1:SetPoint("TOPRIGHT", this, "TOPLEFT", -8, 4);
				end
			end
		else
			RaidPulloutButton_OnClick();
		end
	end
end

function ER_RaidPulloutButton_OnDoubleClick()
	if ( ER_RaidAssistIsAvailable() and ER_Config.useAssist ) then
		local unit = this.unit or this:GetParent().unit;
		AssistUnit(unit);
	end
end

function ER_RaidPulloutButton_OnEnter()
	if ( this:GetCenter() > GetScreenWidth()/2 ) then
		GameTooltip:SetOwner(this, "ANCHOR_LEFT");
	else
		GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
	end

	if ( ER_Config.buffsAreShown ) then
		GameTooltip:SetUnitBuff(this:GetParent().unit, this.index);
		local timeLeft = ER_RaidAssistGetUnitBuffTimeLeft(this:GetParent().unit, GameTooltipTextLeft1:GetText());
		if ( timeLeft ) then
			GameTooltip:AppendText(" ("..ER_FormatTime(timeLeft)..")");
		end
	else
		GameTooltip:SetUnitDebuff(this:GetParent().unit, this.index);
	end	
end

function ER_UnitFrameDropDown_OnLoad()
	UIDropDownMenu_Initialize(this, ER_UnitFrameDropDown_Initialize, "MENU");
end

function ER_UnitFrameDropDown_Initialize()
	local unit = ER_UnitFrameDropDown.unit;
	if ( unit ) then
		local menu;
		local name;
		if ( UnitExists(unit) and (UnitIsEnemy(unit, "player") or (UnitReaction("player", unit) and (UnitReaction("player", unit) >= 4) and not UnitIsPlayer(unit))) ) then
			menu = "RAID_TARGET_ICON";
			name = RAID_TARGET_ICON;
		elseif ( UnitIsUnit(unit, "player") ) then
			menu = "SELF";
		elseif ( UnitIsUnit(unit, "pet") ) then
			menu = "PET";
		elseif ( UnitIsPlayer(unit) ) then
			if ( UnitInParty(unit) ) then
				menu = "PARTY";
			else
				menu = "PLAYER";
			end
		end
		if ( menu ) then
			UnitPopup_ShowMenu(ER_UnitFrameDropDown, menu, unit, name);
		end
	end
end

function ER_UseAction(slot, checkCursor, onSelf)
	ER_SavedUseAction(slot, checkCursor, onSelf);
	
	if ( SpellIsTargeting() ) then
		ER_isRangeChecking = true;
	end
end

function ER_FormatTime(seconds)
	return format("%02d:%02d", seconds/60, mod(seconds, 60));
end

function ER_Debug(message)
	DEFAULT_CHAT_FRAME:AddMessage(message, 0, 1, 0);
end

function ER_Dump(expression)
	SlashCmdList["DEVTOOLSDUMP"](expression);
end
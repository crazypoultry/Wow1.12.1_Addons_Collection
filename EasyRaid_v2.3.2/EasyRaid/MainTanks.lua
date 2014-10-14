function ER_MainTanksOnLoad()
	ER_mainTanksUpdate = 0;

	ER_MainTanksBuffsWidth = 0;

	ER_MainTanksPlaceHolder_UpdateScale();
	ER_MainTanksPlaceHolder_LoadLocation();

	ER_UpdateMainTanks();
end

function ER_MainTanksOnUpdate(elapsed)
	ER_mainTanksUpdate = ER_mainTanksUpdate + elapsed;
	if ( ER_mainTanksUpdate >= 3 ) then
		ER_UpdateMainTanks();
		ER_mainTanksUpdate = 0;
	end
end

function ER_MainTanksPlaceHolder_InitLocation()
	ER_MainTanksPlaceHolder:ClearAllPoints();
	ER_MainTanksPlaceHolder:SetPoint("TOPRIGHT", "UIParent", "TOPLEFT", UIParent:GetWidth()/UIParent:GetEffectiveScale() - 100 - 88 - 4, -250);
	ER_MainTanksPlaceHolder_SaveLocation();
end

function ER_MainTanksPlaceHolder_LoadLocation()
	if ( ER_Config.mainTanksFrameLocation ) then
		ER_MainTanksPlaceHolder:ClearAllPoints();
		ER_MainTanksPlaceHolder:SetPoint(ER_Config.mainTanksEffectiveAlignment, "UIParent", "TOPLEFT",
									ER_Config.mainTanksFrameLocation.x, ER_Config.mainTanksFrameLocation.y);
	end
end

function ER_MainTanksPlaceHolder_SaveLocation()
	ER_Config.mainTanksFrameLocation = { };
	local alignment = ER_GetSmartAlignment(ER_MainTanksPlaceHolder, ER_Config.mainTanksAlignment);
	_, _, _, anchorX, anchorY = ER_MainTanksPlaceHolder:GetPoint(1);
	ER_Config.mainTanksFrameLocation.x = anchorX;
	ER_Config.mainTanksFrameLocation.y = anchorY;
	ER_Config.mainTanksEffectiveAlignment = alignment;
	if ( ER_MainTanksPlaceHolder:IsUserPlaced() ) then
		ER_MainTanksPlaceHolder:SetUserPlaced(false);
	end
	ER_MainTanksPlaceHolder_LoadLocation();
end

function ER_MainTanksPlaceHolder_UpdateScale()
	ER_MainTanksPlaceHolder:SetScale(ER_Config.mainTanksScale/100);
end

-----------------------------------------------------------------------

function ER_UpdateMainTanks()
	ER_mainTanks = { };

	local mts = ER_RaidAssistGetMainTanks();
	local i, name;
	for i, name in mts do
		ER_SetMainTank(i, name);
	end

	ER_RaidPulloutFrame_UpdateContent();
	ER_MainTanksFrame_Update();
end

function ER_SetMainTank(number, name)
	ER_RemoveMainTank(name);

	local unit, index = ER_GetRaidUnitByName(name);
	if ( unit ) then
		ER_mainTanks[number] = { ["index"] = index, ["unit"] = unit, ["name"] = name };
	end
end

function ER_RemoveMainTank(name)
	local i, mt;		
	for i, mt in ER_mainTanks do
		if ( mt.name == name ) then
			ER_mainTanks[i] = nil;
			break;
		end
	end
end

function ER_GetMainTanksSpaces(limit)
	local spaces = { };
	local numSpaces = 0;
	
	if ( ER_mainTanks ) then
		local number, previousNumber;
		local mainTanksCount = 1;
		for number in ER_mainTanks do
			if ( previousNumber and number > previousNumber + 1 ) then
				spaces[mainTanksCount] = true;
				numSpaces = numSpaces + 1;
			end
			previousNumber = number;
			mainTanksCount = mainTanksCount + 1;
			if ( limit and mainTanksCount > limit ) then
				break;
			end
		end
	end
	
	return spaces, numSpaces;
end


-----------------------------------------------------------------------
-- Main Tanks config methods

function ER_MainTanksFrame_OnUpdate(elapsed)
	if ( MOVING_RAID_MEMBER or ER_MOVING_MAIN_TANK ) then
		local i;
		ER_TARGET_MAIN_TANK_SLOT = nil;

		for i=1, ER_MAX_MAIN_TANKS do
			local slot = getglobal("ER_MainTanksFrameSlot"..i);
			if ( MouseIsOver(slot) ) then
				slot:LockHighlight();
				ER_TARGET_MAIN_TANK_SLOT = slot;
			else
				slot:UnlockHighlight();
			end
		end
	end
end

function ER_MainTanksFrame_Update()
	if ( not ER_MainTanksFrame:IsVisible() ) then
		return;
	end

	local i;

	for i=1, ER_MAX_MAIN_TANKS do
		local button = getglobal("ER_MainTankButton"..i);
		if ( ER_mainTanks and ER_mainTanks[i] ) then
			local mt = ER_mainTanks[i];
			local name, _, _, level, class, fileName, _, online, isDead = GetRaidRosterInfo(mt.index);

			buttonName = getglobal("ER_MainTankButton"..i.."Name");
			buttonClass = getglobal("ER_MainTankButton"..i.."Class");
			buttonLevel = getglobal("ER_MainTankButton"..i.."Level");
			
			button.name = name;
			button.unit = mt.unit;
			button.class = fileName;
			
			if ( level == 0 ) then
				level = "";
			end
			
			if ( not name ) then
				name = UNKNOWN;
			end
			
			buttonName:SetText(name);

			if ( class ) then
				buttonClass:SetText(class);
			else
				buttonClass:SetText("");
			end
			
			if ( level ) then
				buttonLevel:SetText(level);
			else
				buttonLevel:SetText("");
			end
			
			if ( online ) then
				if ( isDead ) then
					buttonName:SetVertexColor(RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b);
					buttonClass:SetVertexColor(RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b);
					buttonLevel:SetVertexColor(RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b);
				else
					color = RAID_CLASS_COLORS[fileName];
					if ( color ) then
						buttonName:SetVertexColor(color.r, color.g, color.b);
						buttonClass:SetVertexColor(color.r, color.g, color.b);
						buttonLevel:SetVertexColor(color.r, color.g, color.b);
					end
				end
			else
				buttonName:SetVertexColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
				buttonClass:SetVertexColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
				buttonLevel:SetVertexColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
			end
		
			-- Anchor button to slot
			if ( ER_MOVING_MAIN_TANK ~= button  ) then
				button:SetPoint("TOPLEFT", getglobal("ER_MainTanksFrameSlot"..i), "TOPLEFT", 0, 0);
				button:SetFrameLevel(ER_MainTanksFrame:GetFrameLevel()+2);
			end
			
			button:Show();
		else
			button:Hide();
		end
	end
end

function ER_MainTankButton_OnClick(button)
	if ( button == "LeftButton" ) then
		if ( SpellIsTargeting() ) then
			SpellTargetUnit(this.unit);
		elseif ( CursorHasItem() ) then
			DropItemOnUnit(this.unit);
		else
			TargetUnit(this.unit);
		end
	end
end

function ER_MainTankButton_OnDragStart()
	if ( not (IsRaidLeader() or IsRaidOfficer()) ) then
		return;
	end
	local cursorX, cursorY = GetCursorPosition();
	this:ClearAllPoints();
	this:SetPoint("CENTER", "UIParent", "BOTTOMLEFT", cursorX/UIParent:GetScale(), cursorY/UIParent:GetScale());
	this:SetFrameLevel(ER_MainTanksFrame:GetFrameLevel()+3);
	this:StartMoving();
	ER_MOVING_MAIN_TANK = this;
end

function ER_MainTankButton_OnDragStop(mainTankButton)
	ER_MOVING_MAIN_TANK = nil;

	if ( not (IsRaidLeader() or IsRaidOfficer()) ) then
		return;
	end

	if ( not mainTankButton ) then
		mainTankButton = this;
	end
	
	mainTankButton:StopMovingOrSizing();

	mainTankButton:SetPoint("TOPLEFT", getglobal("ER_MainTanksFrameSlot"..mainTankButton:GetID()), "TOPLEFT", 0, 0);

	if ( ER_TARGET_MAIN_TANK_SLOT ) then
		ER_TARGET_MAIN_TANK_SLOT:UnlockHighlight();
		
		local number = ER_TARGET_MAIN_TANK_SLOT:GetID();
		local name = mainTankButton.name;
		
		if ( not ER_mainTanks[number] ) then
			ER_RaidAssistSetMainTank(number, name);
			ER_SetMainTank(number, name);
		else
			ER_RaidAssistSetMainTank(mainTankButton:GetID(), ER_mainTanks[number].name);
			ER_SetMainTank(mainTankButton:GetID(), ER_mainTanks[number].name);
			ER_RaidAssistSetMainTank(number, name);
			ER_SetMainTank(number, name);
		end
	else
		local name = mainTankButton.name;
		ER_RaidAssistRemoveMainTank(name);
		ER_RemoveMainTank(name);
	end

	ER_RaidPulloutFrame_UpdateContent();		
	ER_MainTanksFrame_Update();
	ER_mainTanksUpdate = 0;
end

function ER_RaidGroupFrame_OnUpdate(elapsed)
	if ( IsRaidLeader() ) then
		ER_SavedRaidGroupFrame_OnUpdate(elapsed);
	end
end

function ER_RaidGroupButton_OnDragStart()
	if ( not (IsRaidLeader() or IsRaidOfficer()) ) then
		return;
	end
	
	local cursorX, cursorY = GetCursorPosition();
	this:ClearAllPoints();
	this:SetPoint("CENTER", "UIParent", "BOTTOMLEFT", cursorX/UIParent:GetScale(), cursorY/UIParent:GetScale());
	this:StartMoving();
	MOVING_RAID_MEMBER = this;
	SetRaidRosterSelection(this.id);
end

function ER_RaidGroupButton_OnDragStop(raidButton)
	if ( not ER_TARGET_MAIN_TANK_SLOT ) then
		ER_SavedRaidGroupButton_OnDragStop(raidButton);
		if ( not IsRaidLeader() ) then
			MOVING_RAID_MEMBER = nil;

			if ( not raidButton ) then
				raidButton = this;
			end
			
			raidButton:StopMovingOrSizing();
	
			if ( TARGET_RAID_SLOT ) then
				TARGET_RAID_SLOT:UnlockHighlight();
			end
	
			raidButton:SetPoint("TOPLEFT", raidButton.slot, "TOPLEFT", 0, 0);
		end
	else
		MOVING_RAID_MEMBER = nil;

		if ( not (IsRaidLeader() or IsRaidOfficer()) ) then
			return;
		end

		if ( not raidButton ) then
			raidButton = this;
		end
		
		raidButton:StopMovingOrSizing();

		ER_TARGET_MAIN_TANK_SLOT:UnlockHighlight();

		raidButton:SetPoint("TOPLEFT", raidButton.slot, "TOPLEFT", 0, 0);
		
		local number = ER_TARGET_MAIN_TANK_SLOT:GetID();
		local name = raidButton.name;
		ER_RaidAssistSetMainTank(number, name);
		ER_SetMainTank(number, name);		

		ER_RaidPulloutFrame_UpdateContent();		
		ER_MainTanksFrame_Update();
		ER_mainTanksUpdate = 0;
	end
end

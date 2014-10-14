--Number of Bib Action Bars
BIB_ACTION_BAR_COUNT = 10;

--Keeps track of our current action button page
CURRENT_BIB_ACTIONBAR_PAGE = 1;

--Keeps track of whether we have a pet with an action bar
PET_WITH_ACTION_BAR = nil;

BIB_BUTTON_GRID_SHOW = nil;
BIB_BUTTON_GRID_HIDE_AND_CASCADE = 1;
BIB_BUTTON_GRID_HIDE_NO_CASCADE = 2;


BibActionBarCount = 0;
BibActionBarsInitialized = 0;
AllBibActionBarsLoaded = false;

--Triggers the BibActionBarManagement to redraw the given action bar
function RedrawBibActionBar(actionBarName)
	BibActionBarManagement.RedrawActionBars[actionBarName] = true;
	BibActionBarManagement.ActionBarRedrawTriggered = true;
end


function RedrawAllBibActionBars()
	for key, value in BibActionBarManagement.RedrawActionBars do
		BibActionBarManagement.RedrawActionBars[key] = true;
	end
	BibActionBarManagement.ActionBarRedrawTriggered = true;
end


function showEmptyButton(button)
	getglobal(button:GetName().."Icon"):Hide();
	getglobal(button:GetName().."Count"):Hide();
	getglobal(button:GetName().."Name"):Hide();
	button:SetNormalTexture("Interface\\Buttons\\UI-Quickslot");
	if(button.showgrid < 1) then
		button:Hide();
	end
end


function showOccupiedButton(button)
	getglobal(button:GetName().."Icon"):Show();
	getglobal(button:GetName().."Count"):Show();
	getglobal(button:GetName().."Name"):Show();	
	button:Hide();
	button:Show();
end


function BibRotateActionBar(bar_name)
	SetHashedSaveValue("ActionBarOrientations", bar_name, 
		math.mod(GetHashedSaveValue("ActionBarOrientations", bar_name) + 1, 13));
	LayoutBibActionBar(bar_name);
end


function RemoveMainActionBar()
	MainMenuBarTexture0:Hide();
	MainMenuBarTexture1:Hide();
	MainMenuBarTexture2:Hide();
	MainMenuBarTexture3:Hide();
	MainMenuBarLeftEndCap:Hide();
	MainMenuBarRightEndCap:Hide();
	MainMenuBarOverlayFrame:Hide();
	MainMenuBar:SetPoint("BOTTOM", "UIParent", "BOTTOM", 0, -100);
	ActionBarUpButton:Hide();
	ActionBarDownButton:Hide();
	ExhaustionTick:Hide();
	BonusActionBarTexture0:ClearAllPoints();
	BonusActionBarTexture0:SetPoint("BOTTOM", "UIParent", "BOTTOM", 0, -100);
	BonusActionBarFrame:ClearAllPoints();
	BonusActionBarFrame:SetPoint("BOTTOM", "UIParent", "BOTTOM", 0, -100);
	SlidingActionBarTexture0:ClearAllPoints();
	SlidingActionBarTexture0:SetPoint("BOTTOM", "UIParent", "BOTTOM", 0, -100);
	MainMenuExpBar:ClearAllPoints();
	MainMenuExpBar:SetPoint("BOTTOM", "UIParent", "BOTTOM", 0, -100);
	local actionbutton;
	for i = 1, 12 do
		actionbutton = getglobal("ActionButton"..i);
		actionbutton:ClearAllPoints();
		actionbutton:SetPoint("BOTTOM", "UIParent", "BOTTOM", 0, -100)
	end
end


function LayoutBibActionBar(ActionBarName)
	local action_button;
	local ActionBar = getglobal(ActionBarName);
	local ActionBarID = ActionBar:GetID();
	local orientation = GetHashedSaveValue("ActionBarOrientations", ActionBarName);
	local n = 0;
	local x_offset = 0;
	local y_offset = 0;
	local max_x_offset = 0;
	local max_y_offset = 0;
	local visible_buttons_exist = false;
	
	-- Things get screwed up if action bars are redrawn while the
	-- WorldMapFrame is visible, so just return in that case
	if(WorldMapFrame:IsVisible()) then
		return;
	end
		
	i = 1;	
	for j=1, 12 do
		action_button = getglobal(GetBibActionButtonName(j + (ActionBarID-1)*12));
		action_button:ClearAllPoints();
		if(orientation == 0) then
			action_button:SetPoint("BOTTOM", "UIParent", "BOTTOM", 0, -100);
		else
			action_button:SetPoint("TOPLEFT", ActionBarName, "TOPLEFT", x_offset , -y_offset);
			if(action_button:IsVisible()) then
				if(x_offset > max_x_offset) then
					max_x_offset = x_offset;
				end
				if(y_offset > max_y_offset) then
					max_y_offset = y_offset;
				end
				if(not visible_buttons_exist) then
					visible_buttons_exist = true;
				end
			end
		end
		
		if(action_button:IsVisible() or BibButtonsGridMode == BIB_BUTTON_GRID_HIDE_NO_CASCADE) then
			i = i + 1;		
			x_offset = (math.mod(i - 1, orientation)) * 39;
			y_offset = floor((i-1) / (orientation)) * 39;
		end
	end
	
	if (not visible_buttons_exist) then
		ActionBar:SetWidth(12);
		ActionBar:SetHeight(20);
	else
		ActionBar:SetWidth(max_x_offset + 36);
		ActionBar:SetHeight(max_y_offset + 36);
	end
end


function ConstructBibMicroBar()
	CharacterMicroButton:ClearAllPoints();
	CharacterMicroButton:SetPoint("TOPLEFT", "MainMenuBarArtFrame", "TOPLEFT", -2, 22);
end


function ConstructBibBagBar()
	KeyRingButton:ClearAllPoints();
	KeyRingButton:SetPoint("BOTTOMLEFT", this:GetName());
	CharacterBag3Slot:ClearAllPoints();
	CharacterBag3Slot:SetPoint("LEFT", "KeyRingButton", "RIGHT", 2, 0);
	CharacterBag2Slot:ClearAllPoints();
	CharacterBag2Slot:SetPoint("LEFT", "CharacterBag3Slot", "RIGHT", 2, 0);
	CharacterBag1Slot:ClearAllPoints();
	CharacterBag1Slot:SetPoint("LEFT", "CharacterBag2Slot", "RIGHT", 2, 0);
	CharacterBag0Slot:ClearAllPoints();
	CharacterBag0Slot:SetPoint("LEFT", "CharacterBag1Slot", "RIGHT", 2, 0);
	MainMenuBarBackpackButton:ClearAllPoints();
	MainMenuBarBackpackButton:SetPoint("LEFT", "CharacterBag0Slot", "RIGHT", 2, 0);
end


function BibConstructPetBar()
	for i=1, 10 do
		pet_button = getglobal("PetActionButton"..i);
		if (pet_button ~= nil) then
			pet_button:SetFrameStrata(BibPetActionBarDragButton:GetFrameStrata());
			pet_button:ClearAllPoints();
			pet_button:SetPoint("TOPLEFT", "PetActionBarFrame", "TOPLEFT", 2 + ((i - 1) * 33), -1);
		end
	end
end

function ConstructBibShapeshiftBar()
	for i=1, 10 do
		shapeshift_button = getglobal("ShapeshiftButton"..i);
		shapeshift_button:ClearAllPoints();
		shapeshift_button:SetPoint("TOPLEFT", "ShapeshiftBarFrame", "TOPLEFT", 4 + ((i - 1) * 39), -4);
	end
end


function PetActionBarFrame_OnUpdate(elapsed)
	local yPos;
	if ( this.slideTimer and (this.slideTimer < this.timeToSlide) ) then
		this.completed = nil;
		if ( this.mode == "show" ) then
			yPos = (this.slideTimer/this.timeToSlide) * this.yTarget;
			this.state = "showing";
			this:Show();
		elseif ( this.mode == "hide" ) then
			yPos = (1 - (this.slideTimer/this.timeToSlide)) * this.yTarget;
			this.state = "hiding";
		end
		this.slideTimer = this.slideTimer + elapsed;
	else
		this.completed = 1;
		if ( this.mode == "show" ) then
			this.state = "top";
		elseif ( this.mode == "hide" ) then
			this.state = "bottom";
			this:Hide();
		end
		this.mode = "none";
	end
end


function ShapeshiftBar_Update()
	local numForms = GetNumShapeshiftForms();
	local fileName, name, isActive, isCastable;
	local button, icon, cooldown;
	local start, duration, enable;

	if ( numForms > 0 ) then
		ShapeshiftBarFrame:Show();
	else
		ShapeshiftBarFrame:Hide();
	end
	
	for i=1, NUM_SHAPESHIFT_SLOTS do
		button = getglobal("ShapeshiftButton"..i);
		icon = getglobal("ShapeshiftButton"..i.."Icon");
		if ( i <= numForms ) then
			texture, name, isActive, isCastable = GetShapeshiftFormInfo(i);
			icon:SetTexture(texture);
			
			--Cooldown stuffs
			cooldown = getglobal("ShapeshiftButton"..i.."Cooldown");
			if ( texture ) then
				cooldown:Show();
			else
				cooldown:Hide();
			end
			start, duration, enable = GetShapeshiftFormCooldown(i);
			CooldownFrame_SetTimer(cooldown, start, duration, enable);
			
			if ( isActive ) then
				ShapeshiftBarFrame.lastSelected = button:GetID();
				button:SetChecked(1);
			else
				button:SetChecked(0);
			end

			if ( isCastable ) then
				icon:SetVertexColor(1.0, 1.0, 1.0);
			else
				icon:SetVertexColor(0.4, 0.4, 0.4);
			end

			button:Show();
		else
			button:Hide();
		end
	end
end

function ShowPetActionBar()
	if ( PetHasActionBar() and PetActionBarFrame.showgrid == 0 and (PetActionBarFrame.mode ~= "show") and not PetActionBarFrame.locked and not PetActionBarFrame.ctrlPressed ) then
		PetActionBarFrame:Show();
		if ( PetActionBarFrame.completed ) then
			PetActionBarFrame.slideTimer = 0;
		end
		PetActionBarFrame.timeToSlide = PETACTIONBAR_SLIDETIME;
		PetActionBarFrame.yTarget = PETACTIONBAR_YPOS;
		PetActionBarFrame.mode = "show";
	end
end

function HidePetActionBar()
	if ( PetActionBarFrame.showgrid == 0 and PetActionBarFrame:IsVisible() and not PetActionBarFrame.locked and not PetActionBarFrame.ctrlPressed ) then
		if ( PetActionBarFrame.completed ) then
			PetActionBarFrame.slideTimer = 0;
		end
		PetActionBarFrame.timeToSlide = PETACTIONBAR_SLIDETIME;
		PetActionBarFrame.yTarget = PETACTIONBAR_YPOS;
		PetActionBarFrame.mode = "hide";
	end
end

-- The normal version of this function is really complicated, and I'm not sure what it's supposed to 
-- do exactly, but it involves resetting the positions of a lot of frames, which hoses BibMod up something 
-- proper, so I'm overriding it
function UIParent_ManageFramePositions()
end
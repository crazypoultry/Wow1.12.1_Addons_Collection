-- Copyright (c) 2005 William J. Rogers <wjrogers@gmail.com>
-- This file is released under the terms of the GNU General Public License v2

function GPetActionBar_OnLoad()
	-- unregister and kill the old pet action bar
	PetActionBarFrame:UnregisterEvent("UNIT_FLAGS")
	PetActionBarFrame:UnregisterEvent("UNIT_AURA")
	PetActionBarFrame:UnregisterEvent("PET_BAR_UPDATE")
	PetActionBarFrame:UnregisterEvent("PET_BAR_UPDATE_COOLDOWN")
	PetActionBarFrame:UnregisterEvent("PET_BAR_SHOWGRID")
	PetActionBarFrame:UnregisterEvent("PET_BAR_HIDEGRID")
	PetActionButtonDown = GPetActionButtonDown
	PetActionButtonUp = GPetActionButtonUp
	-- PetActionBar_ShowGrid = GPetActionBar_ShowGrid
	-- PetActionBar_HideGrid = GPetActionBar_HideGrid
	PetActionBarFrame_OnUpdate = function() end

	-- set up our tricky dock code, compensate for scaling (bug?)
	this.basename = "GPetActionButton"
	this.first, this.last = 1, 10
	this.Dock = function(this)
		-- this:SetScale(1)
		factor = UIParent:GetScale() / this:GetScale()
		this:ClearAllPoints()
		this:SetPoint("BOTTOMLEFT", "$parent", "BOTTOMLEFT", 490 * factor, 8 * factor)
		GBars_LayoutHorizontal(this)
	end

	-- register events
	this:RegisterEvent("UNIT_FLAGS")
	this:RegisterEvent("UNIT_AURA")
	this:RegisterEvent("PET_BAR_UPDATE")
	this:RegisterEvent("PET_BAR_UPDATE_COOLDOWN")
	this:RegisterEvent("PET_BAR_SHOWGRID")
	this:RegisterEvent("PET_BAR_HIDEGRID")

	-- update first time
	this.showgrid = 0
	GPetActionBar_HideGrid()
	GPetActionBar_Update()
end

function GPetActionBar_OnEvent()
	if ( (event == "UNIT_FLAGS" or event == "UNIT_AURA") and arg1 == "pet") then
		GPetActionBar_Update()
	elseif ( event == "PET_BAR_UPDATE" ) then
		if (PetHasActionBar()) then
			GPetActionBar_Update()
			if (not GPetActionBar.hidden) then
				GPetActionBar:Show()
			end
		else
			GPetActionBar:Hide()
		end
	elseif ( event =="PET_BAR_UPDATE_COOLDOWN" ) then
		GPetActionBar_UpdateCooldowns()
	elseif ( event =="PET_BAR_SHOWGRID" ) then
		GPetActionBar_ShowGrid()
	elseif ( event =="PET_BAR_HIDEGRID" ) then
		GPetActionBar_HideGrid()
	end
end

function GPetActionBar_Update()
	local petActionButton, petActionIcon;
	local petActionsUsable = GetPetActionsUsable();

	-- for some reason this won't stick
	-- GPetActionBar:SetScale(1)

	-- loop through and update each button
	for i=1, NUM_PET_ACTION_SLOTS do
		petActionButton = getglobal("GPetActionButton"..i);
		petActionIcon = getglobal("GPetActionButton"..i.."Icon");
		petAutoCastableTexture = getglobal("GPetActionButton"..i.."AutoCastable");
		petAutoCastModel = getglobal("GPetActionButton"..i.."AutoCast");
		local name, subtext, texture, isToken, isActive, autoCastAllowed, autoCastEnabled = GetPetActionInfo(i);
		if ( not isToken ) then
			petActionIcon:SetTexture(texture);
			petActionButton.tooltipName = name;
		else
			petActionIcon:SetTexture(getglobal(texture));
			petActionButton.tooltipName = TEXT(getglobal(name));
		end
		petActionButton.isToken = isToken;
		petActionButton.tooltipSubtext = subtext;
		if ( isActive ) then
			petActionButton:SetChecked(1);
		else
			petActionButton:SetChecked(0);
		end
		if ( autoCastAllowed ) then
			petAutoCastableTexture:Show();
		else
			petAutoCastableTexture:Hide();
		end
		if ( autoCastEnabled ) then
			petAutoCastModel:Show();
		else
			petAutoCastModel:Hide();
		end
		if ( name ) then
			petActionButton:Show();
		elseif (GPetActionBar.showgrid == 0) then
			petActionButton:Hide();
		end
		if ( texture ) then
			if ( petActionsUsable ) then
				SetDesaturation(petActionIcon, nil);
			else
				SetDesaturation(petActionIcon, 1);
			end
			petActionIcon:Show();
			petActionButton:SetNormalTexture("Interface\\Buttons\\UI-Quickslot2");
		else
			petActionIcon:Hide();
			petActionButton:SetNormalTexture("Interface\\Buttons\\UI-Quickslot");
		end
	end

	GPetActionBar_UpdateCooldowns()
end

function GPetActionBar_UpdateCooldowns()
	local cooldown
	for i = 1, NUM_PET_ACTION_SLOTS do
		cooldown = getglobal("GPetActionButton"..i.."Cooldown")
		local start, duration, enable = GetPetActionCooldown(i)
		CooldownFrame_SetTimer(cooldown, start, duration, enable)
	end
end

function GPetActionButton_OnClick()
	this:SetChecked(0)
	if (IsShiftKeyDown()) then
		PickupPetAction(this:GetID())
	else
		if (arg1 == "LeftButton") then
			CastPetAction(this:GetID())
		else
			TogglePetAutocast(this:GetID())
		end
	end
end

function GPetActionButtonDown(id)
	local button = getglobal("GPetActionButton"..id)
	if (button:GetButtonState() == "NORMAL") then
		button:SetButtonState("PUSHED")
	end
end

function GPetActionButtonUp(id)
	local button = getglobal("GPetActionButton"..id)
	if (button:GetButtonState() == "PUSHED") then
		button:SetButtonState("NORMAL")
		CastPetAction(id)
	end
end

function GPetActionButton_OnEvent()
	if (event == "UPDATE_BINDINGS") then
		GActionButton_UpdateBindings("BONUSACTIONBUTTON"..this:GetID())
	end
end

function GPetActionButton_Tooltip()
	if ( not this.tooltipName ) then
		return;
	end
	local uber = GetCVar("UberTooltips");
	if ( this.isToken or (uber == "0") ) then
		if ( uber == "0" ) then
			GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
		else
			GameTooltip_SetDefaultAnchor(GameTooltip, this);
		end
		GameTooltip:SetText(this.tooltipName..NORMAL_FONT_COLOR_CODE.." ("..GetBindingText(GetBindingKey("BONUSACTIONBUTTON"..this:GetID()), "KEY_")..")"..FONT_COLOR_CODE_CLOSE, 1.0, 1.0, 1.0);
		if ( this.tooltipSubtext ) then
			GameTooltip:AddLine(this.tooltipSubtext, "", 0.5, 0.5, 0.5);
		end
		GameTooltip:Show();
	else
		GameTooltip_SetDefaultAnchor(GameTooltip, this);
		GameTooltip:SetPetAction(this:GetID());
	end
end


function GPetActionBar_ShowGrid()
	GPetActionBar.showgrid = GPetActionBar.showgrid + 1
	for i = 1, NUM_PET_ACTION_SLOTS do
		getglobal("GPetActionButton"..i):Show()
	end
end

function GPetActionBar_HideGrid()
	if (GPetActionBar.showgrid > 0) then
		GPetActionBar.showgrid = GPetActionBar.showgrid - 1
	end

	if (GPetActionBar.showgrid == 0) then
		local name
		for i = 1, NUM_PET_ACTION_SLOTS do
			name = GetPetActionInfo(i)
			if (not name) then
				getglobal("GPetActionButton"..i):Hide()
			end
		end
	end
end

-- Settings template Buttons on click

function AutoHideBar_Button_Click()
local ButtonID = this:GetID();
	if (ButtonID == 1) then
		if (AutoHideBarCheckButton:GetChecked()) then 
			AHB_Save.locked = true; 
			ChatFrame1:AddMessage( AutoHideBar_Locked1, 1.0, 1.0, 0.0, 1.0);	
		else
			AHB_Save.locked = false; 
			ChatFrame1:AddMessage(AutoHideBar_Locked2, 1.0, 1.0, 0.0, 1.0);
		end
	elseif (ButtonID == 2) then
		if (CombatCheckButton:GetChecked()) then
			AHB_Save.showincombat = true;
			ChatFrame1:AddMessage(AutoHideBar_Combat2, 1.0, 1.0, 0.0, 1.0);	
		else
			AHB_Save.showincombat = false;
			ChatFrame1:AddMessage(AutoHideBar_Combat1, 1.0, 1.0, 0.0, 1.0);				
		end
	elseif (ButtonID == 3) then
		AHB_Save.key = AutoHideBar_OwnKey;
		key_is_set_to();
	elseif (ButtonID == 4) then
		AHB_Save.key = AutoHideBar_Mouse;
		key_is_set_to();
	elseif (ButtonID == 5) then
		AHB_Save.key = AutoHideBar_Shift;
		key_is_set_to();
	elseif (ButtonID == 6) then
		ReloadUI();
	elseif (ButtonID == 7) then
		AutoHideBar_Reset(); 
	elseif (ButtonID == 8) then
		AutoHideBar_Button_Template:Hide();
		AutoHideBar_Settings_Template:Hide();
	elseif (ButtonID == 9) then
		if (AHB:GetChecked()) then 
			AutoHideBar_Button_Template:SetFrameStrata("HIGH");
			ChatFrame1:AddMessage(AutoHideBar_Bag1, 1.0, 1.0, 0.0, 1.0);	
			AHB_Save.bag = "HIGH";
		else
			AutoHideBar_Button_Template:SetFrameStrata("MEDIUM");
			ChatFrame1:AddMessage(AutoHideBar_Bag2, 1.0, 1.0, 0.0, 1.0);
			AHB_Save.bag = "MEDIUM";
		end
	end
end

function key_is_set_to()
	ChatFrame1:AddMessage(AutoHideBar_ShowKey .. AHB_Save.key, 1.0, 1.0, 0.0, 1.0);	
end

-- New scale settings

function AutoHideBar_Scale_Update(scale)
	if (AutoHideBar_Button_Template) then	
		AHB_Save.scale = scale;
	 	local oldscale = AutoHideBar_Button_Template:GetScale() or 1;
 		
 		local frame_centerx, frame_centery = AutoHideBar_Button_Template:GetCenter();
 		
 		frame_centerx = frame_centerx * oldscale or 0;
 		frame_centery = frame_centery * oldscale or 0;
 	
		AutoHideBar_Button_Template:ClearAllPoints();
 		AutoHideBar_Button_Template:SetScale(AHB_Save.scale);
		AutoHideBar_Button_Template:SetPoint("CENTER","UIParent","BOTTOMLEFT",frame_centerx/AHB_Save.scale, frame_centery/AHB_Save.scale);	
	end
end

-- Set buttonID and show icon 

function AutoHideBar_Check()
	if (GameMenuFrame:IsVisible()) then
		AutoHideBar_SetBindingText();
	end
	
	if (AutoHideBar_Button_Template:IsVisible()) then
		local button = getglobal("AutoHideBarButton"..1);
		local texture = GetActionTexture(button:GetID());
		local icon = getglobal(button:GetName().."Icon");
		AutoHideBar_Settexture(button);
	end
end

function AHB_Settbutton()
	for a=1, 20, 1 do
		AutoHideBar_SetButtonIds(a);
	end
end

function AutoHideBar_SetButtonIds(num)
	local id = AHB_Save.buttonid[num];
	local button = getglobal("AutoHideBarButton"..num);

	button:SetID(id);
	AutoHideBar_Settexture(button);
end

function AutoHideBar_Settexture(button)
	local texture = GetActionTexture(button:GetID());
	local icon = getglobal(button:GetName().."Icon");

	if (texture) then
		icon:SetTexture(texture);
		icon:Show();
		button:SetNormalTexture("Interface\\Buttons\\UI-Quickslot2");
	else
		local button = getglobal("AutoHideBarButton"..AHB_Save.button);
		local icon = getglobal(button:GetName().."Icon");
		icon:Hide();
		button:SetNormalTexture("Interface\\Buttons\\UI-Quickslot");
	end
end

-- Get new id from checkboxes

function AutoHideBar_ChangeID()
	local old = AHB_Save.button;
	local temp = AHB_button:GetNumber();
	
	if (temp >= 0 and temp < 21) then
		if (temp > 0) then 
			AHB_Save.button = AHB_button:GetNumber();
			AHB_buttonid:SetText(AHB_Save.buttonid[AHB_Save.button]);
		end
	else
		AHB_button:SetText(old);
	end
end

function AutoHideBar_ChangeButton()
	local old = AHB_Save.buttonid[AHB_Save.button];
	local temp = AHB_buttonid:GetNumber();
	
	if (temp >= 0 and temp < 201) then
		AutoHideBar_Settexture(button);
		if (temp > 0) then 
			AHB_Save.buttonid[AHB_Save.button] = AHB_buttonid:GetNumber();
			AutoHideBar_SetButtonIds(AHB_Save.button);
		end
	else
		AHB_buttonid:SetText(old);
	end
end

-- Handeling button functions

function DragStart()
	if (not AHB_Save.locked) then
		PickupAction(this:GetID());
	end
	AutoHideBar_Button_UpdateState();
end

function AutoHideBarButtonDown(id)
	local button = getglobal("AutoHideBarButton"..id);
	if (button:GetButtonState() == "NORMAL" ) then
		button:SetButtonState("PUSHED");
	end
end

function AutoHideBarButtonUp(id, onSelf)
	local button = getglobal("AutoHideBarButton"..id);
	if ( button:GetButtonState() == "PUSHED" ) then
		button:SetButtonState("NORMAL");
	
		UseAction(button:GetID(), 0, onSelf);
		if ( IsCurrentAction(button:GetID()) ) then
			button:SetChecked(1);
		else
			button:SetChecked(0);
		end
	end
end

function AutoHideBar_Button_OnLoad()
	this.showgrid = 1;
	this.flashing = 0;
	this.flashtime = 0;
	AutoHideBar_Button_Update();
	this:RegisterForDrag("LeftButton", "RightButton");
	this:RegisterForClicks("LeftButtonUp", "RightButtonUp");
	this:RegisterEvent("ACTIONBAR_SHOWGRID");
	this:RegisterEvent("ACTIONBAR_HIDEGRID");
	this:RegisterEvent("ACTIONBAR_PAGE_CHANGED");
	this:RegisterEvent("ACTIONBAR_SLOT_CHANGED");
	this:RegisterEvent("ACTIONBAR_UPDATE_STATE");
	this:RegisterEvent("ACTIONBAR_UPDATE_USABLE");
	this:RegisterEvent("ACTIONBAR_UPDATE_COOLDOWN");
	this:RegisterEvent("PLAYER_AURAS_CHANGED");
	this:RegisterEvent("PLAYER_TARGET_CHANGED");
	this:RegisterEvent("UNIT_AURASTATE");
	this:RegisterEvent("UNIT_INVENTORY_CHANGED");
	this:RegisterEvent("CRAFT_SHOW");
	this:RegisterEvent("CRAFT_CLOSE");
	this:RegisterEvent("TRADE_SKILL_SHOW");
	this:RegisterEvent("TRADE_SKILL_CLOSE");
	this:RegisterEvent("UNIT_HEALTH");
	this:RegisterEvent("UNIT_MANA");
	this:RegisterEvent("UNIT_RAGE");
	this:RegisterEvent("UNIT_FOCUS");
	this:RegisterEvent("UNIT_ENERGY");
	this:RegisterEvent("UPDATE_BONUS_ACTIONBAR");
	this:RegisterEvent("PLAYER_ENTER_COMBAT");
	this:RegisterEvent("PLAYER_LEAVE_COMBAT");
	this:RegisterEvent("PLAYER_COMBO_POINTS");
	this:RegisterEvent("UPDATE_BINDINGS");
	this:RegisterEvent("START_AUTOREPEAT_SPELL");
	this:RegisterEvent("STOP_AUTOREPEAT_SPELL");
	AutoHideBar_Button_UpdateHotkeys();
end

function AutoHideBar_Button_UpdateHotkeys(actionButtonType)
	if ( not actionButtonType ) then
		actionButtonType = "ACTIONBUTTON";
	end
	local hotkey = getglobal(this:GetName().."HotKey");
	local action = actionButtonType..this:GetID();
end

function AutoHideBar_Button_Update() 
	
local pagedID = this:GetID();
	if ( IsAttackAction(pagedID) and IsCurrentAction(pagedID) ) then
		IN_ATTACK_MODE = 1;
	else
		IN_ATTACK_MODE = nil;
	end
	IN_AUTOREPEAT_MODE = IsAutoRepeatAction(pagedID);
	
	if ( this.isBonus and this.inTransition ) then
		ActionButton_UpdateUsable();
		ActionButton_UpdateCooldown();
		return;
	end
	
	local icon = getglobal(this:GetName().."Icon");
	local buttonCooldown = getglobal(this:GetName().."Cooldown");
	local texture = GetActionTexture(this:GetID());
	if ( texture ) then
		icon:SetTexture(texture);
		icon:Show();
		this.rangeTimer = TOOLTIP_UPDATE_TIME;
		this:SetNormalTexture("Interface\\Buttons\\UI-Quickslot2");
	else
		icon:Hide();
		buttonCooldown:Hide();
		this.rangeTimer = nil;
		this:SetNormalTexture("Interface\\Buttons\\UI-Quickslot");
	end
	
	AutoHideBar_Button_UpdateCount();
	if ( HasAction(this:GetID()) ) then
		this:Show();
		AutoHideBar_Button_UpdateUsable();
		AutoHideBar_Button_UpdateCooldown();
	elseif ( this.showgrid == 0 ) then
		this:Hide();
	else
		getglobal(this:GetName().."Cooldown"):Hide();
	end

	if ( IsAttackAction(this:GetID()) and IN_ATTACK_MODE==1 ) then
		AutoHideBar_Button_StartFlash();
	else
		AutoHideBar_Button_StopFlash();
	end
	
	if ( GameTooltip:IsOwned(this) ) then
		AutoHideBar_Button_SetTooltip();
	else
		this.updateTooltip = nil;
	end

end

function AutoHideBar_Button_ShowGrid()
	this.showgrid = this.showgrid+1;
	getglobal(this:GetName().."NormalTexture"):SetVertexColor(1.0, 1.0, 1.0);
	this:Show();
end

function AutoHideBar_Button_HideGrid()	
	this.showgrid = this.showgrid-1;
	if ( this.showgrid == 0 and not HasAction(this:GetID()) ) then
		this:Hide();
	end
end

function AutoHideBar_Button_UpdateState()
	if ( IsCurrentAction(this:GetID()) ) then
		this:SetChecked(1);
	else
		this:SetChecked(0);
	end
end

function AutoHideBar_Button_UpdateUsable()
	local icon = getglobal(this:GetName().."Icon");
	local normalTexture = getglobal(this:GetName().."NormalTexture");
	local isUsable, notEnoughMana = IsUsableAction(this:GetID());
	if ( isUsable ) then
		local inRange = true;
		if ( this.rangeTimer and (IsActionInRange(this:GetID()) == 0)) then
			inRange = false;
		end
		if ( inRange ) then
			icon:SetVertexColor(1.0, 1.0, 1.0);
			normalTexture:SetVertexColor(1.0, 1.0, 1.0);
		else
			icon:SetVertexColor(1.0, 0.5, 0.5);
			normalTexture:SetVertexColor(1.0, 0.5, 0.5);
		end
	elseif ( notEnoughMana ) then
		icon:SetVertexColor(0.5, 0.5, 1.0);
		normalTexture:SetVertexColor(0.5, 0.5, 1.0);
	else
		icon:SetVertexColor(0.4, 0.4, 0.4);
		normalTexture:SetVertexColor(1.0, 1.0, 1.0);
	end
end

function AutoHideBar_Button_UpdateCount()
	local text = getglobal(this:GetName().."Count");
	local count = GetActionCount(this:GetID());
	if ( count > 1 ) then
		text:SetText(count);
	else
		text:SetText("");
	end
end

function AutoHideBar_Button_UpdateCooldown()
	local cooldown = getglobal(this:GetName().."Cooldown");
	local start, duration, enable = GetActionCooldown(this:GetID());
	CooldownFrame_SetTimer(cooldown, start, duration, enable);
end

function AutoHideBar_Button_OnEvent(event)
	if ( event == "ACTIONBAR_SLOT_CHANGED" ) then
		if ( arg1 == -1 or arg1 == this:GetID() ) then
			AutoHideBar_Button_Update();
		end
		return;
	end
	if ( event == "PLAYER_AURAS_CHANGED") then
		AutoHideBar_Button_Update();
		AutoHideBar_Button_UpdateState();
		return;
	end
	if ( event == "ACTIONBAR_SHOWGRID" ) then
		AutoHideBar_Button_ShowGrid();
		return;
	end
	if ( event == "ACTIONBAR_HIDEGRID" ) then
		AutoHideBar_Button_HideGrid();
		return;
	end
	if ( event == "UPDATE_BINDINGS" ) then
		AutoHideBar_Button_UpdateHotkeys();
	end

	-- All event handlers below this line MUST only be valid when the button is visible
	if ( not this:IsVisible() ) then
		return;
	end

	if ( event == "PLAYER_TARGET_CHANGED" ) then
		AutoHideBar_Button_UpdateUsable();
		return;
	end
	if ( event == "UNIT_AURASTATE" ) then
		if ( arg1 == "player" or arg1 == "target" ) then
			AutoHideBar_Button_UpdateUsable();
		end
		return;
	end
	if ( event == "UNIT_INVENTORY_CHANGED" ) then
		if ( arg1 == "player" ) then
			AutoHideBar_Button_Update();
		end
		return;
	end
	if ( event == "ACTIONBAR_UPDATE_STATE" ) then
		AutoHideBar_Button_UpdateState();
		return;
	end
	if ( event == "ACTIONBAR_UPDATE_USABLE" ) then
		AutoHideBar_Button_UpdateUsable();
		return;
	end
	if ( event == "ACTIONBAR_UPDATE_COOLDOWN" ) then
		AutoHideBar_Button_UpdateCooldown();
		return;
	end
	if ( event == "CRAFT_SHOW" or event == "CRAFT_CLOSE" or event == "TRADE_SKILL_SHOW" or event == "TRADE_SKILL_CLOSE" ) then
		AutoHideBar_Button_UpdateState();
		return;
	end
	if ( arg1 == "player" and (event == "UNIT_HEALTH" or event == "UNIT_MANA" or event == "UNIT_RAGE" or event == "UNIT_FOCUS" or event == "UNIT_ENERGY") ) then
		AutoHideBar_Button_UpdateUsable();
		return;
	end
	if ( event == "PLAYER_ENTER_COMBAT" ) then
		IN_ATTACK_MODE = 1;
		if ( IsAttackAction(this:GetID()) ) then
			AutoHideBar_Button_StartFlash();
		end
		return;
	end
	if ( event == "PLAYER_LEAVE_COMBAT" ) then
		IN_ATTACK_MODE = 0;
		if ( IsAttackAction(this:GetID()) ) then
			AutoHideBar_Button_StopFlash();
		end
		return;
	end
	if ( (event == "UNIT_COMBO_POINTS") and (arg1 == "player") ) then
		AutoHideBar_Button_UpdateUsable();
		return;
	end
	if ( event == "START_AUTOREPEAT_SPELL" ) then
		IN_AUTOREPEAT_MODE = 1;
		if ( IsAutoRepeatAction(this:GetID()) ) then
			AutoHideBar_Button_StartFlash();
		end
		return;
	end
	if ( event == "STOP_AUTOREPEAT_SPELL" ) then
		IN_AUTOREPEAT_MODE = nil;
		if (not IsAttackAction(this:GetID()) ) then --Nil bugg fixed
			AutoHideBar_Button_StopFlash();
		end
		return;
	end
end

function AutoHideBar_Button_SetTooltip()
	if ( GetCVar("UberTooltips") == "1" ) then
		GameTooltip_SetDefaultAnchor(GameTooltip, this);
	else
		GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
	end
	
	if ( GameTooltip:SetAction(this:GetID()) ) then
		this.updateTooltip = TOOLTIP_UPDATE_TIME;
	else
		this.updateTooltip = nil;
	end
end

function AutoHideBar_Button_OnUpdate(elapsed)
	if ( this.flashing ~= 0 and this.flashing ) then
		this.flashtime = this.flashtime - elapsed;
		if ( this.flashtime <= 0 ) then
			local overtime = -this.flashtime;
			if ( overtime >= ATTACK_BUTTON_FLASH_TIME ) then
				overtime = 0;
			end
			this.flashtime = ATTACK_BUTTON_FLASH_TIME - overtime;

			local flashTexture = getglobal(this:GetName().."Flash");
			if ( flashTexture:IsVisible() ) then
				flashTexture:Hide();
			else
				flashTexture:Show();
			end
		end
	end
	
	-- Handle range indicator
	if ( this.rangeTimer ) then
		if ( this.rangeTimer < 0 ) then
			local count = getglobal(this:GetName().."HotKey");
			if ( IsActionInRange( this:GetID()) == 0 ) then
				if(count) then
					count:SetVertexColor(1.0, 0.1, 0.1);
				end
			else
				if(count) then
					count:SetVertexColor(0.6, 0.6, 0.6);
				end
			end
			this.rangeTimer = TOOLTIP_UPDATE_TIME;
		else
			this.rangeTimer = this.rangeTimer - elapsed;
		end
	else
		local count = getglobal(this:GetName().."HotKey");
		count:SetVertexColor(0.6, 0.6, 0.6);
	end
	
	if ( not this.updateTooltip ) then
		return;
	end

	this.updateTooltip = this.updateTooltip - elapsed;
	if ( this.updateTooltip > 0 ) then
		return;
	end

	if ( GameTooltip:IsOwned(this) ) then
		AutoHideBar_Button_SetTooltip();
	else
		this.updateTooltip = nil;
	end
end

function AutoHideBar_Button_StartFlash()
	this.flashing = 1;
	this.flashtime = 0;
	AutoHideBar_Button_UpdateState();
end

function AutoHideBar_Button_StopFlash()
	this.flashing = 0;
	getglobal(this:GetName().."Flash"):Hide();
	AutoHideBar_Button_UpdateState();
end
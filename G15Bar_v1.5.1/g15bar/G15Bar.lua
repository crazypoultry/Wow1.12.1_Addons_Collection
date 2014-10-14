-- A few globals
BINDING_HEADER_M1 = "M1 Bar"
BINDING_NAME_M1ACTIONBUTTON1  = "G1";
BINDING_NAME_M1ACTIONBUTTON2  = "G2";
BINDING_NAME_M1ACTIONBUTTON3  = "G3";
BINDING_NAME_M1ACTIONBUTTON4  = "G4";
BINDING_NAME_M1ACTIONBUTTON5  = "G5";
BINDING_NAME_M1ACTIONBUTTON6  = "G6";
BINDING_NAME_M1ACTIONBUTTON7  = "G7";
BINDING_NAME_M1ACTIONBUTTON8  = "G8";
BINDING_NAME_M1ACTIONBUTTON9  = "G9";
BINDING_NAME_M1ACTIONBUTTON10  = "G10";
BINDING_NAME_M1ACTIONBUTTON11  = "G11";
BINDING_NAME_M1ACTIONBUTTON12  = "G12";
BINDING_NAME_M1ACTIONBUTTON13  = "G13";
BINDING_NAME_M1ACTIONBUTTON14  = "G14";
BINDING_NAME_M1ACTIONBUTTON15  = "G15";
BINDING_NAME_M1ACTIONBUTTON16  = "G16";
BINDING_NAME_M1ACTIONBUTTON17  = "G17";
BINDING_NAME_M1ACTIONBUTTON18  = "G18";

BINDING_HEADER_M2 = "M2 Bar"
BINDING_NAME_M2ACTIONBUTTON1  = "G1";
BINDING_NAME_M2ACTIONBUTTON2  = "G2";
BINDING_NAME_M2ACTIONBUTTON3  = "G3";
BINDING_NAME_M2ACTIONBUTTON4  = "G4";
BINDING_NAME_M2ACTIONBUTTON5  = "G5";
BINDING_NAME_M2ACTIONBUTTON6  = "G6";
BINDING_NAME_M2ACTIONBUTTON7  = "G7";
BINDING_NAME_M2ACTIONBUTTON8  = "G8";
BINDING_NAME_M2ACTIONBUTTON9  = "G9";
BINDING_NAME_M2ACTIONBUTTON10  = "G10";
BINDING_NAME_M2ACTIONBUTTON11  = "G11";
BINDING_NAME_M2ACTIONBUTTON12  = "G12";
BINDING_NAME_M2ACTIONBUTTON13  = "G13";
BINDING_NAME_M2ACTIONBUTTON14  = "G14";
BINDING_NAME_M2ACTIONBUTTON15  = "G15";
BINDING_NAME_M2ACTIONBUTTON16  = "G16";
BINDING_NAME_M2ACTIONBUTTON17  = "G17";
BINDING_NAME_M2ACTIONBUTTON18  = "G18";

BINDING_HEADER_M3 = "M3 Bar"
BINDING_NAME_M3ACTIONBUTTON1  = "G1";
BINDING_NAME_M3ACTIONBUTTON2  = "G2";
BINDING_NAME_M3ACTIONBUTTON3  = "G3";
BINDING_NAME_M3ACTIONBUTTON4  = "G4";
BINDING_NAME_M3ACTIONBUTTON5  = "G5";
BINDING_NAME_M3ACTIONBUTTON6  = "G6";
BINDING_NAME_M3ACTIONBUTTON7  = "G7";
BINDING_NAME_M3ACTIONBUTTON8  = "G8";
BINDING_NAME_M3ACTIONBUTTON9  = "G9";
BINDING_NAME_M3ACTIONBUTTON10  = "G10";
BINDING_NAME_M3ACTIONBUTTON11  = "G11";
BINDING_NAME_M3ACTIONBUTTON12  = "G12";
BINDING_NAME_M3ACTIONBUTTON13  = "G13";
BINDING_NAME_M3ACTIONBUTTON14  = "G14";
BINDING_NAME_M3ACTIONBUTTON15  = "G15";
BINDING_NAME_M3ACTIONBUTTON16  = "G16";
BINDING_NAME_M3ACTIONBUTTON17  = "G17";
BINDING_NAME_M3ACTIONBUTTON18  = "G18";

G15BarRealm = GetCVar("realmName");
G15BarChar = UnitName("player");
G15BarVariablesLoaded = false;
local button_scale=0.5;

function G15BarButtonDown(section, id)
	local button = getglobal(section.."BarButton"..id);
	if ( button:GetButtonState() == "NORMAL" ) then
		button:SetButtonState("PUSHED");
	end
end

function G15BarButtonUp(section, id)
	local button = getglobal(section.."BarButton"..id);
	if ( button:GetButtonState() == "PUSHED" ) then
		button:SetButtonState("NORMAL");
		UseAction(G15BarButton_GetID(button), 0);
		if ( IsCurrentAction(G15BarButton_GetID(button)) ) then
			button:SetChecked(1);
		else
			button:SetChecked(0);
		end
	end
end

function G15BarButton_OnLoad()

	this.showgrid = 1;
	this.flashing = 0;
	this.flashtime = 0;
	G15BarButton_Update();
	this:RegisterForDrag("LeftButton", "RightButton");
	this:RegisterForClicks("LeftButtonUp", "RightButtonUp");
	this:RegisterEvent("VARIABLES_LOADED");
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
	this:RegisterEvent("PLAYER_ENTER_COMBAT");
	this:RegisterEvent("PLAYER_LEAVE_COMBAT");
	this:RegisterEvent("UNIT_COMBO_POINTS");
	this:RegisterEvent("START_AUTOREPEAT_SPELL");
	this:RegisterEvent("STOP_AUTOREPEAT_SPELL");
	
	SlashCmdList["G15CMD"] = G15BarButton_Cmd;
    	SLASH_G15CMD1 = "/g15bar";

end

function G15Bar_Reset()
    M1GrabBar:ClearAllPoints();
	M1GrabBar:SetPoint("CENTER","UIParent","CENTER",0,0);
	if ( G15BarConfig[G15BarRealm][G15BarChar].bound == false) then
		M2GrabBar:ClearAllPoints();
		M2GrabBar:SetPoint("CENTER","UIParent","CENTER",0,0);
	    M3GrabBar:ClearAllPoints();
		M3GrabBar:SetPoint("CENTER","UIParent","CENTER",0,0);
	end
	G15Bar_Bind(G15BarConfig[G15BarRealm][G15BarChar].bound);
end

function G15Bar_Bind(input)
	input = G15Bar_ValidateCheckButtonInput(input);
	if (input == true) then
		M2BarButton1:ClearAllPoints();
		M3BarButton1:ClearAllPoints();
		M2BarButton2:ClearAllPoints();
		M3BarButton2:ClearAllPoints();
	    M3GrabBar:ClearAllPoints();
	    M2GrabBar:ClearAllPoints();
		M2BarButton2:SetPoint("LEFT", M2BarButton1, "RIGHT", 3, 0);
		M3BarButton2:SetPoint("LEFT", M3BarButton1, "RIGHT", 3, 0);
	    M2BarButton1:SetPoint("LEFT", M1BarButton3, "RIGHT", 12, 0);
	    M3BarButton1:SetPoint("LEFT", M2BarButton3, "RIGHT", 12, 0);
	    M2GrabBar:SetPoint("BOTTOM", M2BarButton2, "TOP", 0, 9);
		M3GrabBar:SetPoint("BOTTOM", M3BarButton2, "TOP", 0, 9);
    elseif (input == false) then
		M2BarButton1:ClearAllPoints();
		M3BarButton1:ClearAllPoints();
		M2BarButton2:ClearAllPoints();
		M3BarButton2:ClearAllPoints();
        M3GrabBar:ClearAllPoints();
        M2GrabBar:ClearAllPoints();
		M2BarButton2:SetPoint("TOP", M2GrabBar, "BOTTOM", 0, -9);
		M3BarButton2:SetPoint("TOP", M3GrabBar, "BOTTOM", 0, -9);
        M2BarButton1:SetPoint("RIGHT", M2BarButton2, "LEFT", -3, 0);
        M3BarButton1:SetPoint("RIGHT", M3BarButton2, "LEFT", -3, 0);
	end
	G15BarConfig[G15BarRealm][G15BarChar].bound = input;
end

function G15Bar_ShowGrid(input)
	input = G15Bar_ValidateCheckButtonInput(input);
	if (input == false) then
		for i=1,3 do
			for j=1,18 do
			  	local button = getglobal("M"..i.."BarButton"..j);
				button.showgrid = 0;
				if ( button.showgrid == 0 and not HasAction(G15BarButton_GetID(button)) ) then
					button:Hide();
				end
			end
		end
	elseif (input == true) then
		for i=1,3 do
			for j=1,18 do
			  	local button = getglobal("M"..i.."BarButton"..j);
				button.showgrid = 1;
				getglobal(button:GetName().."NormalTexture"):SetVertexColor(1.0, 1.0, 1.0);
				button:Show();
			end
		end
	end
	G15BarConfig[G15BarRealm][G15BarChar].grid = input;
end

function G15Bar_Lock(input)
	input = G15Bar_ValidateCheckButtonInput(input);
	if (input == true and G15BarConfig[G15BarRealm][G15BarChar].labels == false) then
	  M1GrabBar:Hide();
      M2GrabBar:Hide();
  	  M3GrabBar:Hide();
	elseif (input == false) then
      M1GrabBar:Show();
      M2GrabBar:Show();
      M3GrabBar:Show();
	end
	G15BarConfig[G15BarRealm][G15BarChar].lock = input;
	G15Bar_Bind(G15BarConfig[G15BarRealm][G15BarChar].bound);
end

function G15Bar_NumBars(num)
	if(num == 0) then
		M1Bar:Hide();
		M2Bar:Hide();
		M3Bar:Hide();
	elseif(num == 1) then
		M1Bar:Show();
		M2Bar:Hide();
		M3Bar:Hide();
	elseif(num == 2) then
		M1Bar:Show();
		M2Bar:Show();
		M3Bar:Hide();
	elseif(num == 3) then
		M1Bar:Show();
		M2Bar:Show();
		M3Bar:Show();
	end
	G15BarConfig[G15BarRealm][G15BarChar].numbars = num;
end

function G15Bar_ShowLabels(input)
	input = G15Bar_ValidateCheckButtonInput(input);
	if (input == true) then
      M1GrabBar:Show();
      M2GrabBar:Show();
      M3GrabBar:Show();	
 	elseif (input == false and G15BarConfig[G15BarRealm][G15BarChar].lock == true) then
	  M1GrabBar:Hide();
      M2GrabBar:Hide();
  	  M3GrabBar:Hide();	
 	end
 	G15BarConfig[G15BarRealm][G15BarChar].labels = input;
end

function G15Bar_Scale(input)
	button_scale = input;
	G15BarButton_Scale(input);
	G15BarConfig[G15BarRealm][G15BarChar].scale = input;
	G15Bar_Reset();
end

function G15Bar_ValidateCheckButtonInput(input)
	if (input == 1) then return true;
	elseif (input == nil) then return false;
	else return input;
	end
end

function G15Bar_SetIds()
	for i=1,3 do
		for j=1,18 do
		  	local button = getglobal("M"..i.."BarButton"..j);
			button:SetID(G15BarConfig[G15BarRealm][G15BarChar]["IDs"][i][j]);
		end
	end
end

function G15BarButton_Cmd(msg)
	if (msg == "id") then
		ShowUIPanel(G15BarIdFrame);
	else
		ShowUIPanel(G15BarConfigFrame); 
	end
end                             

function G15BarButton_Init()
    G15BarVariablesLoaded = true;
    
    if ( not G15BarConfig ) then 
	 	G15BarConfig = {};
    end
                 
    if ( not G15BarConfig[G15BarRealm] ) then 
	 	G15BarConfig[G15BarRealm] = {}; 
	end
	
	if ( not G15BarConfig[G15BarRealm][G15BarChar] ) then 
	 	G15BarConfig[G15BarRealm][G15BarChar] = {};
	end
    
    if (not G15BarConfig[G15BarRealm][G15BarChar].scale) then
        G15BarConfig[G15BarRealm][G15BarChar].scale = 0.5;
	end
	
    if( G15BarConfig[G15BarRealm][G15BarChar].bound == nil) then
	    G15BarConfig[G15BarRealm][G15BarChar].bound = true;
	end
	
	if (G15BarConfig[G15BarRealm][G15BarChar].labels == nil)  then
        G15BarConfig[G15BarRealm][G15BarChar].labels = true;
	end
	
	if (G15BarConfig[G15BarRealm][G15BarChar].grid == nil)  then
        G15BarConfig[G15BarRealm][G15BarChar].grid = true;
	end

    if (not G15BarConfig[G15BarRealm][G15BarChar].numbars) then
        G15BarConfig[G15BarRealm][G15BarChar].numbars = 3.0;
	end
	
	if (G15BarConfig[G15BarRealm][G15BarChar].lock == nil)  then
		G15BarConfig[G15BarRealm][G15BarChar].lock = false;
	end

	if (not G15BarConfig[G15BarRealm][G15BarChar]["IDs"]) then
	    G15BarConfig[G15BarRealm][G15BarChar]["IDs"] = {};
		for i=1,3 do
			for j=1,18 do
			  	local button = getglobal("M"..i.."BarButton"..j);
      			if(not G15BarConfig[G15BarRealm][G15BarChar]["IDs"][i]) then
      			    G15BarConfig[G15BarRealm][G15BarChar]["IDs"][i] = {};
				end
    			G15BarConfig[G15BarRealm][G15BarChar]["IDs"][i][j] = button:GetID();
			end
		end
	end
	
	G15Bar_SetIds();
    
	G15Bar_Scale(G15BarConfig[G15BarRealm][G15BarChar].scale);
	
	G15Bar_Bind(G15BarConfig[G15BarRealm][G15BarChar].bound);
	
    	G15Bar_ShowLabels(G15BarConfig[G15BarRealm][G15BarChar].labels);
	
    	G15Bar_ShowGrid(G15BarConfig[G15BarRealm][G15BarChar].grid);
		
	G15Bar_NumBars(G15BarConfig[G15BarRealm][G15BarChar].numbars);
	
	G15Bar_Lock(G15BarConfig[G15BarRealm][G15BarChar].lock);
end


function G15BarButton_Update()
	-- Determine whether or not the button should be flashing or not since the button may have missed the enter combat event
	local buttonID = G15BarButton_GetID(this);
	if ( IsAttackAction(buttonID) and IsCurrentAction(buttonID) ) then
		IN_ATTACK_MODE = 1;
	else
		IN_ATTACK_MODE = nil;
	end
	IN_AUTOREPEAT_MODE = IsAutoRepeatAction(buttonID);
	
	local icon = getglobal(this:GetName().."Icon");
	local buttonCooldown = getglobal(this:GetName().."Cooldown");
	local texture = GetActionTexture(G15BarButton_GetID(this));
	if ( texture ) then
		icon:SetTexture(texture);
		icon:Show();
		this:SetNormalTexture("Interface\\Buttons\\UI-Quickslot2");
		this.rangeTimer = -1;
	else
		icon:Hide();
		this.rangeTimer = nil;
		buttonCooldown:Hide();
		this:SetNormalTexture("Interface\\Buttons\\UI-Quickslot");
	end
	G15BarButton_UpdateCount();
	if ( HasAction(G15BarButton_GetID(this)) ) then
		this:Show();
		G15BarButton_UpdateUsable();
		G15BarButton_UpdateCooldown();
	elseif ( this.showgrid == 0 ) then
		this:Hide();
	else
		getglobal(this:GetName().."Cooldown"):Hide();
	end
	if ( IN_ATTACK_MODE or IN_AUTOREPEAT_MODE ) then
		G15BarButton_StartFlash();
	else
		G15BarButton_StopFlash();
	end
	if ( GameTooltip:IsOwned(this) ) then
		G15BarButton_SetTooltip();
	else
		this.updateTooltip = nil;
	end

	-- Update Macro Text
	local macroName = getglobal(this:GetName().."Name");
	macroName:SetText(GetActionText(G15BarButton_GetID(this)));


	G15BarButton_Scale(button_scale) ;

end

function G15BarButton_Scale(factor)
	if(G15Bar:GetScale() ~= factor) then
		this.needsUpdate = 1;
	end
	if(this.needsUpdate) then
		G15Bar:SetScale(factor);
		this.needsUpdate = nil;
	end
end

function G15BarButton_ShowGrid()
	this.showgrid = 1;
	getglobal(this:GetName().."NormalTexture"):SetVertexColor(1.0, 1.0, 1.0);
	this:Show();
end

function G15BarButton_HideGrid()
	this.showgrid = 0;
	if ( this.showgrid == 0 and not HasAction(G15BarButton_GetID(this)) ) then
		this:Hide();
	end
end

function G15BarButton_UpdateState()
	if ( IsCurrentAction(G15BarButton_GetID(this)) or IsAutoRepeatAction(G15BarButton_GetID(this)) ) then
		this:SetChecked(1);
	else
		this:SetChecked(0);
	end
end

function G15BarButton_UpdateUsable()
	local icon = getglobal(this:GetName().."Icon");
	local normalTexture = getglobal(this:GetName().."NormalTexture");
	local isUsable, notEnoughMana = IsUsableAction(G15BarButton_GetID(this));
	if ( IsAddOnLoaded("RangeColor")) then
		if ( (RangeColor_Get("Mode")==3) or RangeColor_Get("Mode")==2) then
			if ( this.rangeTimer ) then
				if ( this.rangeTimer < 0 ) then
					if ( IsActionInRange(G15BarButton_GetID(this)) == 0 ) then
						icon:SetVertexColor(RangeColor_Save2["Colors"][1].r, RangeColor_Save2["Colors"][1].g, RangeColor_Save2["Colors"][1].b);
						normalTexture:SetVertexColor(RangeColor_Save2["Colors"][2].r, RangeColor_Save2["Colors"][2].g, RangeColor_Save2["Colors"][2].b);
					else
						if ( isUsable ) then
							icon:SetVertexColor(RangeColor_Save2["Colors"][10].r, RangeColor_Save2["Colors"][10].g, RangeColor_Save2["Colors"][10].b);
							normalTexture:SetVertexColor(RangeColor_Save2["Colors"][11].r, RangeColor_Save2["Colors"][11].g, RangeColor_Save2["Colors"][11].b);
						elseif ( notEnoughMana ) then
							icon:SetVertexColor(RangeColor_Save2["Colors"][4].r, RangeColor_Save2["Colors"][4].g, RangeColor_Save2["Colors"][4].b);
							normalTexture:SetVertexColor(RangeColor_Save2["Colors"][5].r, RangeColor_Save2["Colors"][5].g, RangeColor_Save2["Colors"][5].b);
						else
							icon:SetVertexColor(RangeColor_Save2["Colors"][7].r, RangeColor_Save2["Colors"][7].g, RangeColor_Save2["Colors"][7].b);
							normalTexture:SetVertexColor(RangeColor_Save2["Colors"][8].r, RangeColor_Save2["Colors"][8].g, RangeColor_Save2["Colors"][8].b);
						end
					end
				end
			end
		end
	else
		if ( isUsable ) then
			icon:SetVertexColor(1.0, 1.0, 1.0);
			normalTexture:SetVertexColor(1.0, 1.0, 1.0);
		elseif ( notEnoughMana ) then
			icon:SetVertexColor(0.5, 0.5, 1.0);
			normalTexture:SetVertexColor(0.5, 0.5, 1.0);
		else
			icon:SetVertexColor(0.4, 0.4, 0.4);
			normalTexture:SetVertexColor(1.0, 1.0, 1.0);
		end
	end
end

function G15BarButton_UpdateCount()
	local text = getglobal(this:GetName().."Count");
	local count = GetActionCount(G15BarButton_GetID(this));
	if ( count > 1 ) then
		text:SetText(count);
	else
		text:SetText("");
	end
end

function G15BarButton_UpdateCooldown()
	local cooldown = getglobal(this:GetName().."Cooldown");
	local start, duration, enable = GetActionCooldown(G15BarButton_GetID(this));
	CooldownFrame_SetTimer(cooldown, start, duration, enable);
end

function G15BarButton_OnEvent(event)
	if ( event == "VARIABLES_LOADED" ) then
		G15BarButton_Init();
	end
	if ( event == "ACTIONBAR_SLOT_CHANGED" ) then
		if ( arg1 == -1 or arg1 == G15BarButton_GetID(this) ) then
			G15BarButton_Update();
		end
		return;
	end
	if ( event == "PLAYER_AURAS_CHANGED") then
		G15BarButton_Update();
		G15BarButton_UpdateState();
		return;
	end
	if ( event == "ACTIONBAR_SHOWGRID" ) then
		G15BarButton_ShowGrid();
		return;
	end
	if ( event == "ACTIONBAR_HIDEGRID" and G15BarConfig[G15BarRealm][G15BarChar].grid == false) then
		G15BarButton_HideGrid();
		return;
	end

	-- All event handlers below this line MUST only be valid when the button is visible
	if ( not this:IsVisible() ) then
		return;
	end

	if ( event == "PLAYER_TARGET_CHANGED" ) then
		G15BarButton_UpdateUsable();
		return;
	end
	if ( event == "UNIT_AURASTATE" ) then
		if ( arg1 == "player" or arg1 == "target" ) then
			G15BarButton_UpdateUsable();
		end
		return;
	end
	if ( event == "UNIT_INVENTORY_CHANGED" ) then
		if ( arg1 == "player" ) then
			G15BarButton_Update();
		end
		return;
	end
	if ( event == "ACTIONBAR_UPDATE_STATE" ) then
		G15BarButton_UpdateState();
		return;
	end
	if ( event == "ACTIONBAR_UPDATE_USABLE" ) then
		G15BarButton_UpdateUsable();
		return;
	end
	if ( event == "ACTIONBAR_UPDATE_COOLDOWN" ) then
		G15BarButton_UpdateCooldown();
		return;
	end
	if ( event == "CRAFT_SHOW" or event == "CRAFT_CLOSE" or event == "TRADE_SKILL_SHOW" or event == "TRADE_SKILL_CLOSE" ) then
		G15BarButton_UpdateState();
		return;
	end
	if ( arg1 == "player" and (event == "UNIT_HEALTH" or event == "UNIT_MANA" or event == "UNIT_RAGE" or event == "UNIT_FOCUS" or event == "UNIT_ENERGY") ) then
		G15BarButton_UpdateUsable();
		return;
	end
	if ( event == "PLAYER_ENTER_COMBAT" ) then
		IN_ATTACK_MODE = 1;
		if ( IsAttackAction(G15BarButton_GetID(this)) ) then
			G15BarButton_StartFlash();
		end
		return;
	end
	if ( event == "PLAYER_LEAVE_COMBAT" ) then
		IN_ATTACK_MODE = 0;
		if ( IsAttackAction(G15BarButton_GetID(this)) ) then
			G15BarButton_StopFlash();
		end
		return;
	end
	if ( (event == "UNIT_COMBO_POINTS") and (arg1 == "player") ) then
		G15BarButton_UpdateUsable();
		return;
	end
	if ( event == "START_AUTOREPEAT_SPELL" ) then
		IN_AUTOREPEAT_MODE = 1;
		if ( IsAutoRepeatAction(G15BarButton_GetID(this)) ) then
			G15BarButton_StartFlash();
		end
		return;
	end
	if ( event == "STOP_AUTOREPEAT_SPELL" ) then
		IN_AUTOREPEAT_MODE = nil;
		if ( G15BarButton_IsFlashing() and not IsAttackAction(G15BarButton_GetID(this)) ) then
			G15BarButton_StopFlash();
		end
		return;
	end
end

function G15BarButton_SetTooltip()
	GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
	if ( GameTooltip:SetAction(G15BarButton_GetID(this)) ) then
		this.updateTooltip = TOOLTIP_UPDATE_TIME;
	else
		this.updateTooltip = nil;
	end
end

function G15BarButton_OnUpdate(elapsed)
	if ( G15BarButton_IsFlashing() ) then
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

	if ( this.rangeTimer ) then
		this.rangeTimer = this.rangeTimer - elapsed;
	end

	G15BarButton_UpdateUsable();

	if ( not this.updateTooltip ) then
		return;
	end

	this.updateTooltip = this.updateTooltip - elapsed;
	if ( this.updateTooltip > 0 ) then
		return;
	end

	if ( GameTooltip:IsOwned(this) ) then
		G15BarButton_SetTooltip();
	else
		this.updateTooltip = nil;
	end
end

function G15BarButton_GetID(button)
	if ( button == nil ) then
		message("nil button passed into G15BarButton_GetID(), contact Fastjack");
		return 0;
	end
	return (button:GetID())
end

function G15BarButton_StartFlash()
	this.flashing = 1;
	this.flashtime = 0;
	G15BarButton_UpdateState();
end

function G15BarButton_StopFlash()
	this.flashing = 0;
	getglobal(this:GetName().."Flash"):Hide();
	G15BarButton_UpdateState();
end

function G15BarButton_IsFlashing()
	if ( this.flashing == 1 ) then
		return 1;
	else
		return nil;
	end
end

function G15Bar_AutoBind(key, command)
	if (GetBindingAction(key) == "" or GetBindingAction(key) == command or IsShiftKeyDown() == 1) then
		SetBinding(key, command);
		return true;
	else
		return GetBindingAction(key);
	end
end

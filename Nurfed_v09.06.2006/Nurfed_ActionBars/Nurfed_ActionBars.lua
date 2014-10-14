
NURFED_ACTIONBARS_DEFAULT = {
	bagbar = 1,
	bagbarvert = 0,
	bagbarscale = 1,
	petbar = 1,
	petbarvert = 0,
	petbarscale = 1,
	stancebar = 1,
	stancebarvert = 0,
	stancebarscale = 1,
	cooldownscale = 1,
	showhotkey = 1,
	showunused = 0,
	showborder = 1,
	showmicro = 0,
	microscale = 1,
	bordercolor = { 1, 1, 1 },
	buttons = {},
	bars = {
		[1] = { 2, 12, 3, 1, 2, 2, 1, 0 },
	},
};

local lib = Nurfed_ActionBars:New();
local utility = Nurfed_Utility:New();
local framelib = Nurfed_Frames:New();

-- ActionBar Replacement functions
function Nurfed_ActionButtonDown(id)
	local button = getglobal("Nurfed_ActionButton"..id);
	if (button:GetButtonState() == "NORMAL") then
		button:SetButtonState("PUSHED");
	end
end

function Nurfed_ActionButtonUp(id, onSelf)
	local button = getglobal("Nurfed_ActionButton"..id);
	if (button:GetButtonState() == "PUSHED") then
		button:SetButtonState("NORMAL");
		if (MacroFrame_SaveMacro) then
			MacroFrame_SaveMacro();
		end
		UseAction(button:GetID(), 0, onSelf);
		if (IsCurrentAction(button:GetID())) then
			button:SetChecked(1);
		else
			button:SetChecked(0);
		end
	end
end

-- Bag Replacement functions
function Nurfed_ContainerFrame_OnHide()
	if ( this:GetID() == 0 ) then
		Nurfed_bagbar1:SetChecked(0);
	else
		local bagButton = getglobal("NurfedBagBag"..(this:GetID() - 1).."Slot");
		if ( bagButton ) then
			bagButton:SetChecked(0);
		else
			-- If its a bank bag then update its highlight
			UpdateBagButtonHighlight(this:GetID()); 
		end
	end
	ContainerFrame1.bagsShown = ContainerFrame1.bagsShown - 1;
	-- Remove the closed bag from the list and collapse the rest of the entries
	local index = 1;
	while ContainerFrame1.bags[index] do
		if ( ContainerFrame1.bags[index] == this:GetName() ) then
			local tempIndex = index;
			while ContainerFrame1.bags[tempIndex] do
				if ( ContainerFrame1.bags[tempIndex + 1] ) then
					ContainerFrame1.bags[tempIndex] = ContainerFrame1.bags[tempIndex + 1];
				else
					ContainerFrame1.bags[tempIndex] = nil;
				end
				tempIndex = tempIndex + 1;
			end
		end
		index = index + 1;
	end
	updateContainerFrameAnchors();

	if ( this:GetID() == KEYRING_CONTAINER ) then
		UpdateMicroButtons();
		PlaySound("KeyRingClose");
	else
		PlaySound("igBackPackClose");
	end
	if (ContainerFrame1.bagsShown == 0) then
		local show = utility:GetOption("actionbars", "bagbar");
		if (show ~= 1) then
			Nurfed_bagbar:Hide();
		end
	end
end

function Nurfed_ContainerFrame_OnShow()
	if ( this:GetID() == 0 ) then
		Nurfed_bagbar1:SetChecked(1);
	elseif ( this:GetID() <= NUM_BAG_SLOTS ) then 
		local button = getglobal("NurfedBagBag"..(this:GetID() - 1).."Slot");
		if ( button ) then
			button:SetChecked(1);
		end
	else
		UpdateBagButtonHighlight(this:GetID());
	end
	ContainerFrame1.bagsShown = ContainerFrame1.bagsShown + 1;
	if ( this:GetID() == KEYRING_CONTAINER ) then
		UpdateMicroButtons();
		PlaySound("KeyRingOpen");
	else
		PlaySound("igBackPackOpen");
	end
	Nurfed_bagbar:Show();
end

-- PetBar Replacement functions
function Nurfed_PetActionButton_OnDragStart()
	if (NRF_LOCKED == 1) then
		return;
	end

	if (IsControlKeyDown()) then
		this:GetParent():StartMoving();
	else
		this:SetChecked(0);
		PickupPetAction(this:GetID());
		PetActionBar_Update();
	end
end

function Nurfed_PetActionButton_OnReceiveDrag()
	if ( LOCK_ACTIONBAR ~= "1" ) then
		this:SetChecked(0);
		PickupPetAction(this:GetID());
		PetActionBar_Update();
	end
end

function Nurfed_PetActionBar_Update()
	if (not string.find(this:GetName(), "^Nurfed")) then
		return;
	end
		local button, icon, actexture, acmodel;
		local petActionsUsable = GetPetActionsUsable();
		for i = 1, NUM_PET_ACTION_SLOTS do
			button = getglobal("Nurfed_petbar"..i);
			icon = getglobal("Nurfed_petbar"..i.."Icon");
			local name, subtext, texture, isToken, isActive, autoCastAllowed, autoCastEnabled = GetPetActionInfo(i);

			if (not isToken) then
				icon:SetTexture(texture);
				button.tooltipName = name;
			else
				icon:SetTexture(getglobal(texture));
				button.tooltipName = TEXT(getglobal(name));
			end

			if (isActive) then
				button:SetChecked(1);
			else
				button:SetChecked(0);
			end

			if (name) then
				button:Show();
			else
				button:Hide();
			end

			if (texture) then
				if (petActionsUsable) then
					SetDesaturation(icon, nil);
				else
					SetDesaturation(icon, 1);
				end
				icon:Show();
				button:SetNormalTexture("Interface\\Buttons\\UI-Quickslot2");
			else
				icon:Hide();
				button:SetNormalTexture("Interface\\Buttons\\UI-Quickslot");
			end

			actexture = getglobal("Nurfed_petbar"..i.."AutoCastable");
			acmodel = getglobal("Nurfed_petbar"..i.."AutoCast");
			if (autoCastAllowed) then
				actexture:Show();
			else
				actexture:Hide();
			end
			if (autoCastEnabled) then
				acmodel:Show();
			else
				acmodel:Hide();
			end
		end
	PetActionBar_UpdateCooldowns();
end

function Nurfed_PetActionBar_ShowGrid()
	for i=1, NUM_PET_ACTION_SLOTS, 1 do
		getglobal("Nurfed_petbar"..i):Show();
	end
end

function Nurfed_PetActionBar_HideGrid()
	local name;
	for i=1, NUM_PET_ACTION_SLOTS, 1 do
		name = GetPetActionInfo(i);
		if ( not name ) then
			getglobal("Nurfed_petbar"..i):Hide();
		end
		
	end
	
end

function Nurfed_PetActionBar_UpdateCooldowns()
	local cooldown, button;
	for i=1, NUM_PET_ACTION_SLOTS do
		button = getglobal("Nurfed_petbar"..i);
		cooldown = getglobal("Nurfed_petbar"..i.."Cooldown");
		local start, duration, enable = GetPetActionCooldown(i);
		CooldownFrame_SetTimer(cooldown, start, duration, enable);

		if (start > 0 and duration > 2 and enable > 0) then
			button.cooling = true;
			button.coolingstart = start;
			button.coolingduration = duration;
		else
			button.cooling = nil;
		end
	end
end

function Nurfed_PetActionButton_SetHotkeys()
	local text = utility:FormatBinding(GetBindingText(GetBindingKey("BONUSACTIONBUTTON"..this:GetID())));
	local hotkey = getglobal(this:GetName().."HotKey");
	hotkey:SetText(text);
end

function Nurfed_ShowPetActionBar()
	if (not string.find(this:GetName(), "^Nurfed")) then
		return;
	end
	local show = utility:GetOption("actionbars", "petbar");
	if (PetHasActionBar() and show == 1) then
		Nurfed_petbar:Show();
	else
		Nurfed_petbar:Hide();
	end
end

function Nurfed_HidePetActionBar()
	Nurfed_petbar:Hide();
end

utility:Hook("replace", "ActionButtonDown", Nurfed_ActionButtonDown);
utility:Hook("replace", "ActionButtonUp", Nurfed_ActionButtonUp);
utility:Hook("replace", "ContainerFrame_OnHide", Nurfed_ContainerFrame_OnHide);
utility:Hook("replace", "ContainerFrame_OnShow", Nurfed_ContainerFrame_OnShow);
utility:Hook("replace", "PetActionButton_OnDragStart", Nurfed_PetActionButton_OnDragStart);
utility:Hook("replace", "PetActionBar_Update", Nurfed_PetActionBar_Update);
utility:Hook("replace", "PetActionBar_ShowGrid", Nurfed_PetActionBar_ShowGrid);
utility:Hook("replace", "PetActionBar_HideGrid", Nurfed_PetActionBar_HideGrid);
utility:Hook("replace", "PetActionBar_UpdateCooldowns", Nurfed_PetActionBar_UpdateCooldowns);
utility:Hook("replace", "PetActionButton_SetHotkeys", Nurfed_PetActionButton_SetHotkeys);
utility:Hook("replace", "ShowPetActionBar", Nurfed_ShowPetActionBar);
utility:Hook("replace", "HidePetActionBar", Nurfed_HidePetActionBar);

local function ab_OnClick()
	if (this.isStance) then
		local id = this:GetID();
		CastShapeshiftForm(id);
	elseif (this.isPet) then
		this:SetChecked(0);
		if (arg1 == "LeftButton") then
			if (IsPetAttackActive(this:GetID())) then
				PetStopAttack();
			else
				CastPetAction(this:GetID());
			end
		else
			TogglePetAutocast(this:GetID());
		end
	else
		if (MacroFrame_SaveMacro) then
			MacroFrame_SaveMacro();
		end
		UseAction(this:GetID(), 1);
		lib:UpdateState();
	end
end

function ab_OnDragStart()
	if (NRF_LOCKED == 1) then
		return;
	end

	if (IsControlKeyDown()) then
		this:GetParent():StartMoving();
	else
		if (not this.isStance and not this.isPet and not string.find(this:GetName(), "Micro", 1, true)) then
			PickupAction(this:GetID());
			lib:UpdateState();
		end
	end
end

function ab_OnDragStop()
	local bar = this:GetParent();
	bar:StopMovingOrSizing();
	utility:SetPos(bar);
end

local function ab_OnReceiveDrag()
	PlaceAction(this:GetID());
	lib:UpdateState();
end

local function ab_OnEnter()
	if (this.isPet) then
		PetActionButton_OnEnter();
	elseif (this.isStance) then
		if ( GetCVar("UberTooltips") == "1" ) then
			GameTooltip_SetDefaultAnchor(GameTooltip, this);
		else
			GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
		end
		GameTooltip:SetShapeshift(this:GetID());
	else
		if ( GetCVar("UberTooltips") == "1" ) then
			GameTooltip_SetDefaultAnchor(GameTooltip, this);
		else
			GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
		end
		
		if (GameTooltip:SetAction(this:GetID())) then
			this.updateTooltip = TOOLTIP_UPDATE_TIME;
		else
			this.updateTooltip = nil;
		end
	end
end

local function ab_OnLeave()
	this.updateTooltip = nil;
	GameTooltip:Hide();
end

local function bag_OnClick()
	if (IsControlKeyDown()) then
		return;
	end
	if (IsShiftKeyDown()) then
		BagSlotButton_OnShiftClick()
	else
		BagSlotButton_OnClick()
	end
end

local function bag_OnDragStart()
	if (NRF_LOCKED ==1) then
		return;
	end
	if (IsControlKeyDown()) then
		this:GetParent():StartMoving();
	elseif (this:GetID() > 0) then
		PickupBagFromSlot(this:GetID());
		PlaySound("BAGMENUBUTTONPRESS");
		this:SetChecked(1);
	end
end

function Nurfed_ActionBarsUpdateBars()
	lib:UpdateButtons();
	lib:SaveAllButtons();
end

function Nurfed_ActionBarsClearBars()
	lib.updating = true;
	for i = 1, 120 do
		PickupAction(i);
		PutItemInBackpack();
	end
	lib.updating = nil;
end

function Nurfed_ActionBars_Init()

	local tbl = {
		Nurfed_CooldownFont = {
			type = "Font",
			Font = { "Fonts\\FRIZQT__.TTF", 22, "OUTLINE" },
			TextColor = { 1, 1, 1 },
		},
		Nurfed_Action_Cooldown = {
			type = "FontString",
			FontObject = "Nurfed_CooldownFont",
			layer = "OVERLAY",
			Anchor = { "CENTER", "$parent", "CENTER", 0, 0 },
			Hide = true;
		},
		Nurfed_ActionBar_Template = {
			type = "Frame",
			size = { 36, 36 },
			Movable = true,
			ClampedToScreen = true,
		},
		Nurfed_ActionButton_Template = {
			type = "CheckButton",
			uitemp = "ActionButtonTemplate",
			children = {
				num = {
					type = "FontString",
					layer = "OVERLAY",
					Font = { "Fonts\\ARIALN.TTF", 14, "OUTLINE" },
					JustifyH = "LEFT",
					Anchor = {"LEFT", "$parent", "LEFT", 2, 0 },
					TextColor = { 1, 0, 1 },
				},
				cooldowncount = "Nurfed_Action_Cooldown",
			},
			OnEvent = function() Nurfed_ActionButton_OnEvent() end,
			OnUpdate = function() Nurfed_ActionButton_OnUpdate(arg1) end,
			OnClick = function() ab_OnClick() end,
			OnDragStart = function() ab_OnDragStart() end,
			OnDragStop = function() ab_OnDragStop() end,
			OnReceiveDrag = function() ab_OnReceiveDrag() end,
			OnEnter = function() ab_OnEnter() end,
			OnLeave = function() ab_OnLeave() end,
			vars = {
				flashing = 0,
				flashtime = 0,
				showgrid = 0,
			},
		},
		Nurfed_ShapeShift_Template = {
			type = "CheckButton",
			size = { 36, 36 },
			uitemp = "ShapeshiftButtonTemplate",
			children = {
				cooldowncount = "Nurfed_Action_Cooldown",
			},
			OnUpdate = function() Nurfed_UpdateCooldown(arg1) end,
			OnDragStart = function() ab_OnDragStart() end,
			OnDragStop = function() ab_OnDragStop() end,
		},
		Nurfed_BackPack_Template = {
			type = "CheckButton",
			uitemp = "ItemButtonTemplate",
			children = {
				ItemAnim = {
					type = "Model",
					uitemp = "ItemAnimTemplate",
					Anchor = { "BOTTOMRIGHT", "$parent", "BOTTOMRIGHT", -10, 0 },
				},
				CheckedTexture = {
					type = "Texture",
					layer = "BACKGROUND",
					Anchor = "all",
					BlendMode="ADD",
					Texture = "Interface\\Buttons\\CheckButtonHilight"
				},
			},
			OnClick = function()
					if (IsShiftKeyDown()) then
						OpenAllBags();
					else
						BackpackButton_OnClick();
					end
				end,
			OnReceiveDrag = function() BackpackButton_OnClick() end,
			OnDragStart = function() bag_OnDragStart() end,
			OnDragStop = function() ab_OnDragStop() end,
			OnLeave = function() GameTooltip:Hide() end,
		},
		Nurfed_BagButton_Template = {
			type = "CheckButton",
			uitemp = "BagSlotButtonTemplate",
			OnDragStart = function() bag_OnDragStart() end,
			OnDragStop = function() ab_OnDragStop() end,
		},
		Nurfed_PetButton_Template = {
			type = "CheckButton",
			uitemp = "PetActionButtonTemplate",
			children = {
				cooldowncount = "Nurfed_Action_Cooldown",
			},
			OnShow = function() PetActionButton_SetHotkeys() end,
			OnUpdate = function() Nurfed_UpdateCooldown(arg1) end,
			OnDragStop = function() ab_OnDragStop() end,
		},
	};

	for temp, spec in pairs(tbl) do
		framelib:CreateTemplate(temp, spec);
	end
	tbl = nil;

	lib:InitBars();
	lib:CreateBags();
	lib:CreatePetBar();
	lib:CreateMicroMenu();
	lib:CreateShapeShift();
	MainMenuBar:Hide();
	MainMenuBar:UnregisterAllEvents();
	for i = 1, 12 do
		local button = getglobal("ActionButton"..i);
		button:SetScript("OnEvent", nil);
		button:SetScript("OnUpdate", nil);
		button:UnregisterAllEvents();
		button:Hide();
	end

	BINDING_HEADER_NURFEDABHEADER = "Nurfed Action Bars";
	for i = 13, 120 do
		setglobal("BINDING_NAME_NURFED_ACTIONBUTTON"..i, "Nurfed Action Button "..i);
	end

	local tooltip = {
		type = "GameTooltip",
		uitemp = "GameTooltipTemplate",
		FrameStrata = "TOOLTIP",
		Hide = true,
	};
	--[[
	local tbl = {
		type = "Frame",
		events = {
			"PLAYER_LOGIN",
		},
		OnEvent = function() Nurfed_ActionBarsUpdateBars() end,
	};
	framelib:ObjectInit("Nurfed_ActionBarSave", tbl);
	]]
	framelib:ObjectInit("Nurfed_ActionTooltip", tooltip);
	Nurfed_ActionTooltip:SetOwner(WorldFrame, "ANCHOR_NONE");
	tooltip = nil;
	--tbl = nil;
end

function Nurfed_ActionButton_OnEvent()
	if (event == "PLAYER_ENTERING_WORLD") then
		lib:UpdateBindings();
		lib:UpdateButton();
	elseif (event == "UPDATE_BINDINGS") then
		lib:UpdateBindings();
	elseif (event == "ACTIONBAR_SLOT_CHANGED") then
		lib:UpdateButton();
		lib:SaveButton(this:GetID());
	elseif (event == "ACTIONBAR_PAGE_CHANGED") then
		lib:UpdatePage();
		lib:UpdateButton();
	elseif (event == "UPDATE_BONUS_ACTIONBAR") then
		lib:UpdateStance();
		lib:UpdateButton();
	elseif (event == "ACTIONBAR_SHOWGRID") then
		lib:ShowGrid();
	elseif (event == "ACTIONBAR_HIDEGRID") then
		lib:HideGrid();
	elseif (event == "PET_BAR_UPDATE" or (event == "UNIT_PET" and arg1 == "player")) then
		local show = utility:GetOption("actionbars", "petbar");
		if (PetHasActionBar() and show == 1) then
			Nurfed_petbar:Show();
		else
			Nurfed_petbar:Hide();
		end
		PetActionBar_Update();
	elseif (event == "PLAYER_CONTROL_LOST" or event == "PLAYER_CONTROL_GAINED" or event == "PLAYER_FARSIGHT_FOCUS_CHANGED") then
		PetActionBar_Update();
	elseif ((event == "UNIT_FLAGS") or (event == "UNIT_AURA")) then
		if (arg1 == "pet") then
			PetActionBar_Update();
		end
	elseif (event == "PET_BAR_UPDATE_COOLDOWN") then
		PetActionBar_UpdateCooldowns();


	elseif (event == "UNIT_INVENTORY_CHANGED") then
		if (arg1 == "player") then
			lib:UpdateButton();
		end
	elseif (event == "ACTIONBAR_UPDATE_STATE") then
		lib:UpdateState();
	elseif (event == "ACTIONBAR_UPDATE_USABLE" or event == "UPDATE_INVENTORY_ALERTS" or event == "ACTIONBAR_UPDATE_COOLDOWN") then
		lib:UpdateCooldown();
	elseif (event == "CRAFT_SHOW" or event == "CRAFT_CLOSE" or event == "TRADE_SKILL_SHOW" or event == "TRADE_SKILL_CLOSE") then
		lib:UpdateState();
	elseif (event == "PLAYER_ENTER_COMBAT") then
		if (IsAttackAction(this:GetID())) then
			lib:StartFlash();
		end
	elseif (event == "PLAYER_LEAVE_COMBAT") then
		if (IsAttackAction(this:GetID())) then
			lib:StopFlash();
		end
	elseif (event == "START_AUTOREPEAT_SPELL") then
		if (IsAutoRepeatAction(this:GetID())) then
			lib:StartFlash();
		end
	elseif (event == "STOP_AUTOREPEAT_SPELL") then
		if (this.flashing == 1 and not IsAttackAction(this:GetID())) then
			lib:StopFlash();
		end
	end
end

function Nurfed_UpdateCooldown(e)
	if (not this.update) then
		this.update = 0;
	end
	this.update = this.update + e;
	if (this.update > 0.25) then
		local cooldowncount = getglobal(this:GetName().."cooldowncount");
		local scale = utility:GetOption("actionbars", "cooldownscale");
		if (this.cooling and scale > 0) then
			local remtime = ceil(( this.coolingstart + this.coolingduration ) - GetTime());
			local r, g, b = 1, 0, 0;
			local height = 22;
			if (remtime > 0) then
				if (remtime >= 3600) then
					remtime = math.floor((remtime / 3600)+0.5).."h";
					r, g, b = 0.6, 0.6, 0.6;
					height = 15;
				elseif (remtime >= 60) then
					remtime = math.floor((remtime / 60)+0.5).."m";
					r, g, b = 1, 1, 0;
					height = 15;
				end
				height = height * scale;
				cooldowncount:SetText(remtime);
				cooldowncount:SetTextColor(r, g, b);
				local _, fontHeight = cooldowncount:GetFont();
				if (fontHeight ~= height) then
					cooldowncount:SetFont("Fonts\\FRIZQT__.TTF", height, "OUTLINE");
				end
				cooldowncount:Show();
			else
				this.cooling = nil;
			end
		else
			cooldowncount:Hide();
		end
		this.update = 0;
	end
end

function Nurfed_ActionButton_OnUpdate(e)
	if (not this:GetName()) then
		return;
	end
	if (this.flashing == 1) then
		this.flashtime = this.flashtime - e;
		if ( this.flashtime <= 0 ) then
			if (not IsAttackAction(this:GetID()) and not IsAutoRepeatAction(this:GetID())) then
				lib:StopFlash();
			else
				local overtime = -this.flashtime;
				if (overtime >= ATTACK_BUTTON_FLASH_TIME) then
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
	end

	-- Handle range indicator
	if (this.rangeTimer) then
		this.rangeTimer = this.rangeTimer - e;

		if (this.rangeTimer <= 0) then
			local icon = getglobal(this:GetName().."Icon");
			local hotkey = getglobal(this:GetName().."HotKey");
			local isUsable, notEnoughMana = IsUsableAction(this:GetID());
			local inRange = IsActionInRange(this:GetID());
			if (isUsable and inRange == 0) then
				icon:SetVertexColor(1, 0.1, 0.1);
				hotkey:SetTextColor(1, 0.5, 0.5);
			elseif (not isUsable) then
				icon:SetVertexColor(0.4, 0.4, 0.4);
				hotkey:SetTextColor(0.6, 0.6, 0.6);
			elseif (notEnoughMana) then
				icon:SetVertexColor(0.5, 0.5, 1.0);
				hotkey:SetTextColor(0.6, 0.6, 0.6);
			else
				icon:SetVertexColor(1, 1, 1);
				hotkey:SetTextColor(1, 1, 1);
			end
			this.rangeTimer = TOOLTIP_UPDATE_TIME;
		end
	end

	Nurfed_UpdateCooldown(e);

	if (this.isStance or this.isPet) then
		return;
	end

	local num = getglobal(this:GetName().."num");
	if (NRF_LOCKED ~= 1) then
		local text = string.gsub(this:GetName(), "Nurfed_ActionButton", "");
		num:SetText(text);
		num:Show();
	else
		num:Hide();
	end

	if (not this.updateTooltip) then
		return;
	end

	this.updateTooltip = this.updateTooltip - e;
	if (this.updateTooltip > 0) then
		return;
	end

	if (GameTooltip:IsOwned(this)) then
		ab_OnEnter();
	else
		this.updateTooltip = nil;
	end
end

function Nurfed_ActionBars_UpdateMicro()
	local show = utility:GetOption("actionbars", "showmicro");
	local scale = utility:GetOption("actionbars", "microscale");
	Nurfed_micro:SetScale(scale);
	if (show == 1) then
		Nurfed_micro:Show();
	else
		Nurfed_micro:Hide();
	end
	
end

function Nurfed_ActionBars_UpdateButtons()
	local showunused = utility:GetOption("actionbars", "showunused");
	local showborder = utility:GetOption("actionbars", "showborder");
	local showhotkey = utility:GetOption("actionbars", "showhotkey");
	local bordercolor = utility:GetOption("actionbars", "bordercolor");
	local total = table.getn(lib.buttons);
	local button, border, hotkey;
	for i = 1, total do
		button = getglobal("Nurfed_ActionButton"..i);
		border = getglobal("Nurfed_ActionButton"..i.."NormalTexture");
		hotkey = getglobal("Nurfed_ActionButton"..i.."HotKey");
		if (lib.buttons[i].u) then
			if (showunused ~= 1) then
				button.showgrid = 0;
				if (not HasAction(button:GetID())) then
					button:Hide();
				end
			else
				button.showgrid = 1;
				button:Show();
			end
		end
		border:SetVertexColor(bordercolor[1], bordercolor[2], bordercolor[3]);
		if (showborder == 1) then
			border:Show();
		else
			border:Hide();
		end
		if (showhotkey == 1) then
			hotkey:Show();
		else
			hotkey:Hide();
		end
	end
end

function Nurfed_ActionBars_UpdateBars(bar, num)
	local frame = getglobal("Nurfed_"..bar);
	if (not frame) then
		return;
	end
	local button, last, p, rp, xy;
	local show = utility:GetOption("actionbars", bar);
	local vert = utility:GetOption("actionbars", bar.."vert");
	local scale = utility:GetOption("actionbars", bar.."scale");
	if (vert == 1) then
		p = "TOP";
		rp = "BOTTOM";
		xy = -2;
	else
		if (bar == "bagbar") then
			p = "RIGHT";
			rp = "LEFT";
			xy = -2;
		else
			p = "LEFT";
			rp = "RIGHT";
			xy = 2;
		end
	end
	for i = 1, num do
		if (bar == "bagbar" and i > 1) then
			button = getglobal("NurfedBagBag"..(i - 2).."Slot");
		else
			button = getglobal("Nurfed_"..bar..i);
		end
		if (button) then
			button:SetScale(scale);
			if (i > 1) then
				button:ClearAllPoints();
				if (vert == 1) then
					button:SetPoint(p, last, rp, 0, xy);
				else
					button:SetPoint(p, last, rp, xy, 0);
				end
			end
			last = button;
		end
	end
	if (show == 1) then
		frame:Show();
	else
		frame:Hide();
	end
end
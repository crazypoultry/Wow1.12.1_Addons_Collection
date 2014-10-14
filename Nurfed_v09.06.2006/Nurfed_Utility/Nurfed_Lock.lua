
NURFED_UTILITY_DEFAULT = {
	pos = { -12, -80 },
	Nurfed_bar1 = { (GetScreenWidth() / 3), 25 },
	Nurfed_bags = { GetScreenWidth() -100, 25 },
	Nurfed_petbar = { GetScreenWidth() / 2, GetScreenHeight() / 2 },
	Nurfed_stancebar = { GetScreenWidth() / 2, GetScreenHeight() / 2 },
};

local utility = Nurfed_Utility:New();
local frames = Nurfed_Frames:New();

SLASH_NURFEDMENU1 = "/nurfed";
SLASH_NURFEDMENU2 = "/nrf";
SlashCmdList["NURFEDMENU"] = function()
	Nurfed_ToggleMenu();
end

local function Update_Lock_POS()
	local pos = utility:GetOption("utility", "pos");
	Nurfed_LockButton:ClearAllPoints();
	Nurfed_LockButton:SetPoint("CENTER", "Minimap", "CENTER", pos[1], pos[2]);
end

local function InitAddOns()
	local count = GetNumAddOns();
	for i = 1, count do
		local name, title, notes, enabled, loadable, reason, security = GetAddOnInfo(i);
		local loaded = IsAddOnLoaded(i);
		if (string.find(name, "^Nurfed") and loaded) then
			local tbl = string.upper(name).."_SAVED";
			local player = UnitName("player").." - "..GetCVar("realmName");
			if (not getglobal(tbl) or getglobal(tbl)[player]) then
				local opt = getglobal(string.upper(name).."_DEFAULT");
				if (opt) then
					setglobal(tbl, opt);
				end
			end
			local func = getglobal(name.."_Init");
			pcall(func);
		end
	end
end

local function Nurfed_LockButton_OnClick(button)
	if (button == "LeftButton") then
		NRF_LOCKED = this:GetChecked();
		local icon = getglobal(this:GetName().."icon");
		if (NRF_LOCKED) then
			icon:SetTexture(NRF_IMG.."nurfedlocked");
		else
			icon:SetTexture(NRF_IMG.."nurfedunlocked");
		end
		PlaySound("igMainMenuOption");
		Nurfed_LockButton_OnEnter();
	elseif (button == "RightButton") then
		this:SetChecked(NRF_LOCKED);
		Nurfed_ToggleMenu();
	end
end

local function Nurfed_LockButton_OnUpdate()
	if (this.isMoving) then
		-- Credit to Alex Brazie for this calculation
		cursorX, cursorY = GetCursorPosition();
		centerX, centerY = Minimap:GetCenter();
		scale = Minimap:GetEffectiveScale();
		cursorX = cursorX / scale;
		cursorY = cursorY / scale;
		local radius = (Minimap:GetWidth()/2) + (this:GetWidth()/3);
		local x = math.abs(cursorX - centerX);
		local y = math.abs(cursorY - centerY);
		local xSign = 1;
		local ySign = 1;
		if (not (cursorX >= centerX)) then
			xSign = -1;
		end
		if (not (cursorY >= centerY)) then
			ySign = -1;
		end

		local angle = math.atan(x/y);
		x = math.sin(angle)*radius;
		y = math.cos(angle)*radius;
		local pos = utility:SetOption("utility", "pos", { xSign * x, ySign * y });
		Update_Lock_POS();
	end
end

function Nurfed_ToggleMenu()
	local loaded = LoadAddOn("Nurfed_Options");
	if (loaded) then
		if (Nurfed_OptionsFrame:IsShown()) then
			PlaySound("igAbilityClose");
			HideUIPanel(Nurfed_OptionsFrame);
		else
			PlaySound("igAbilityOpen");
			ShowUIPanel(Nurfed_OptionsFrame);
			UIFrameFadeIn(Nurfed_OptionsFrame, 0.25);
		end
	end
end

function Nurfed_LockButton_OnEnter()
	GameTooltip:SetOwner(this, "ANCHOR_LEFT");
	GameTooltip:AddLine("Nurfed UI", 0, 0.75, 1);
	GameTooltip:AddLine("Right Click - Toggle Menu", 0.75, 0.75, 0.75);
	if (NRF_LOCKED == 1) then
		GameTooltip:AddLine("Left Click - |cffff0000Unlock|r UI", 0.75, 0.75, 0.75);
	else
		GameTooltip:AddLine("Left Click - |cff00ff00Lock|r UI", 0.75, 0.75, 0.75);
	end
	GameTooltip:AddLine("Ctrl + Drag moves your Action Bars.", 0, 1, 0);
	GameTooltip:AddLine("Ctrl + Right Click moves the Autobar.", 0, 1, 0);
	GameTooltip:Show();
end

local function Nurfed_Lock_OnEvent()
	if (event == "ADDON_LOADED" and arg1 == "Nurfed_Options") then
		Nurfed_OptionsInit();
	elseif (event == "PLAYER_LOGIN") then
		InitAddOns();
		Update_Lock_POS();
	end
end

if (not Nurfed_LockButton) then
	local tbl = {
		type = "CheckButton",
		size = { 33, 33 },
		FrameStrata = "LOW",
		Checked = NRF_LOCKED,
		events = {
			"PLAYER_LOGIN",
			"ADDON_LOADED",
		},
		children = {
			DropDown = { type = "Frame" },
			Border = {
				type = "Texture",
				size = { 52, 52 },
				layer = "ARTWORK",
				Texture = "Interface\\Minimap\\MiniMap-TrackingBorder",
				Anchor = { "TOPLEFT", "$parent", "TOPLEFT", 0, 0 },
			},
			HighlightTexture = {
				type = "Texture",
				size = { 33, 33 },
				alphaMode = "ADD",
				Texture = "Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight",
				Anchor = { "TOPLEFT", "$parent", "TOPLEFT", 0, 0 },
			},
			icon = {
				type = "Texture",
				size = { 23, 23 },
				layer = "BACKGROUND",
				Texture = NRF_IMG.."nurfedlocked",
				Anchor = { "CENTER", "$parent", "CENTER", -1, 1 },
			},
		},
		OnEvent = function() Nurfed_Lock_OnEvent() end,
		OnClick = function() Nurfed_LockButton_OnClick(arg1) end,
		OnDragStart = function() this.isMoving = true end,
		OnDragStop = function() this.isMoving = nil end,
		OnUpdate = function() Nurfed_LockButton_OnUpdate() end,
		OnEnter = function() Nurfed_LockButton_OnEnter() end,
		OnLeave = function() GameTooltip:Hide() end,
	};
	local lock = frames:ObjectInit("Nurfed_LockButton", tbl, Minimap);
	lock:RegisterForClicks("LeftButtonUp", "RightButtonUp");
	lock:RegisterForDrag("LeftButton");
	tbl = nil;
end
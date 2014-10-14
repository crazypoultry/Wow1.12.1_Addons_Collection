--
--  AutoBar
--
--  Config functions
--
--  Maintained by Azethoth / Toadkiller of Proudmoore.  Original author Saien of Hyjal
--  http://www.curse-gaming.com/en/wow/addons-4430-1-autobar-toadkiller.html
--

AutoBarConfig = {};

local L = AceLibrary("AceLocale-2.1"):GetInstance("AutoBar", true);
local Compost = AceLibrary("Compost-2.0");
local dewdrop = AceLibrary("Dewdrop-2.0")
AutoBarConfig.editPlayer = "_SHARED1";
AutoBarConfig.title = GetAddOnMetadata("AutoBar", "Title") .. " ("..GetAddOnMetadata("AutoBar", "Version")..")";

local tabFrameNames = { "Slots", "Bar", "Buttons", "Popup", "Profile" };


function AutoBarConfig_Toggle(msg)
	if (AutoBarConfigFrame:IsVisible()) then
		AutoBarConfigFrame:Hide();
	else
		AutoBarConfigFrame:Show();
	end
end


function AutoBarConfig.OnShow()
	AutoBarConfig.editPlayer = AutoBarProfile:GetEditPlayer();
	AutoBarProfile:InitializeLayoutProfile();
	AutoBarConfig:SlotsInitialize();
	AutoBarConfig:SetSharedInitialize();
	AutoBarConfigSliderValueChanged();
	AutoBarConfig:SlotsViewInitialize();
	AutoBarConfig:CheckBoxInitialize();
	AutoBarConfig:DockToInitialize();
	AutoBarConfig:RevertInitialize();
	AutoBarConfig:SkinInitialize();
end


-- Skin it if asked for.  oSkin for now
function AutoBarConfig:SkinInitialize()
	local hideFrames = {
		AutoBarConfigFrameTopLeft, AutoBarConfigFrameTop, AutoBarConfigFrameTopRight,
		AutoBarConfigFrameLeft, AutoBarConfigFrameMiddle, AutoBarConfigFrameRight,
		AutoBarConfigFrameBottomLeft, AutoBarConfigFrameBottom, AutoBarConfigFrameBottomRight,
		AutoBarConfigSlotFrameTitle,
		AutoBarChooseCategoryFrame_ScrollTexture1, AutoBarChooseCategoryFrame_ScrollTexture2,
	}
	if (oSkin and AutoBar_Config[AutoBarConfig.editPlayer].display.oSkin) then
		for i, frame in pairs(hideFrames) do
			frame:Hide();
		end
		for index, tabFrameName in pairs(tabFrameNames) do
			getglobal("AutoBarConfigFrameTab" .. index .. "LeftDisabled"):SetAlpha(0);
			getglobal("AutoBarConfigFrameTab" .. index .. "MiddleDisabled"):SetAlpha(0);
			getglobal("AutoBarConfigFrameTab" .. index .. "RightDisabled"):SetAlpha(0);
			getglobal("AutoBarConfigFrameTab" .. index .. "Left"):SetAlpha(0);
			getglobal("AutoBarConfigFrameTab" .. index .. "Middle"):SetAlpha(0);
			getglobal("AutoBarConfigFrameTab" .. index .. "Right"):SetAlpha(0);
		end
		oSkin:applySkin(AutoBarConfigFrame);
		oSkin:applySkin(AutoBarFrame);
		oSkin:applySkin(AutoBarConfigFrameTab1);
		oSkin:applySkin(AutoBarConfigFrameTab2);
		oSkin:applySkin(AutoBarConfigFrameTab3);
		oSkin:applySkin(AutoBarConfigFrameTab4);
		oSkin:applySkin(AutoBarConfigFrameTab5);
		oSkin:applySkin(AutoBarConfigSlotFrame, true);
		oSkin:applySkin(AutoBarChooseCategoryFrame);
		oSkin:skinScrollBar(AutoBarChooseCategoryFrame_Scroll);
	else
		for i, frame in pairs(hideFrames) do
			frame:Show();
		end
		for index, tabFrameName in pairs(tabFrameNames) do
			getglobal("AutoBarConfigFrameTab" .. index .. "LeftDisabled"):SetAlpha(1);
			getglobal("AutoBarConfigFrameTab" .. index .. "MiddleDisabled"):SetAlpha(1);
			getglobal("AutoBarConfigFrameTab" .. index .. "RightDisabled"):SetAlpha(1);
			getglobal("AutoBarConfigFrameTab" .. index .. "Left"):SetAlpha(1);
			getglobal("AutoBarConfigFrameTab" .. index .. "Middle"):SetAlpha(1);
			getglobal("AutoBarConfigFrameTab" .. index .. "Right"):SetAlpha(1);
		end
	end
end


-- Clone current state in AutoBarConfig.revert
function AutoBarConfig:RevertInitialize()
	if (not AutoBarConfig.revert) then
		AutoBarConfig.revert = {};
		AutoBarConfig.revert.profiles = {};
		AutoBarConfig.revert.profiles = AutoBarProfile.CloneProfiles();
		AutoBarConfig.revert.profile = AutoBarProfile.CloneUserProfile();
	end
end


-- Revert to the previous state stashed in AutoBarConfig.revert
function AutoBarConfig:Revert()
	if (AutoBarConfig.revert.profiles) then
		AutoBarProfile.RevertProfiles(AutoBarConfig.revert.profiles);
	end
	AutoBar_Config[AutoBar.currentPlayer].profile = AutoBarConfig.revert.profile;
	AutoBarProfile:ProfileChanged();
	AutoBarProfile:ProfileEditingChanged();
	AutoBar_SetupVisual();
	AutoBarConfig.revert = nil;
	AutoBarConfig.OnShow();
end


-- Delete previous state stashed in AutoBarConfig.revert
function AutoBarConfig:Done()
	AutoBarConfig.revert = nil;
	AutoBarConfigFrame:Hide();
end


function AutoBarConfig:SlotsViewInitialize()
	AutoBarConfig:SlotsUpdate("AutoBarConfigFrameSlotsView_Button", AutoBar.buttons);
end


function AutoBarConfig:SlotsInitialize()
	local profile = AutoBarProfile:GetProfile();
	local layerName = AUTOBAR_CONFIG_CHARACTER;
	if (profile.edit == 2) then
		layerName = AUTOBAR_CONFIG_SHARED;
	elseif (profile.edit == 3) then
		layerName = AUTOBAR_CONFIG_CLASS;
	elseif (profile.edit == 4) then
		layerName = AUTOBAR_CONFIG_BASIC;
	end
	AutoBarConfigFrameSlotsTitleText:SetText(layerName..AUTOBAR_CONFIG_SLOTEDITTEXT);
	AutoBarConfig:SlotsUpdate("AutoBarConfigFrameSlots_Button", AutoBar_Config[AutoBarConfig.editPlayer].buttons);
end


function AutoBarConfig:SlotsUpdate(buttonBaseName, buttons)
	local index, button, hotkey;

	for index = 1, AUTOBAR_MAXBUTTONS, 1 do
		button = getglobal(buttonBaseName..index);
		hotkey = getglobal(buttonBaseName..index.."HotKey");
		count  = getglobal(buttonBaseName..index.."Count");
		icon   = getglobal(buttonBaseName..index.."Icon");
		hotkey:SetText("#"..index);
		if (buttons[index][1]) then
			icon:SetTexture(AutoBar_GetTexture(buttons[index]));
			count:SetText("");
		else
			count:SetText(L["EMPTY"]);
			icon:SetTexture("");
		end
	end
end


function AutoBarConfig:ConfigSetTooltip(message)
	if (message and not AutoBarProfile:GetProfile().hideConfigTooltips) then
		GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
		GameTooltip:SetText(message);
	end
end


function AutoBarConfig:ButtonSetTooltip()
	local buttonInfo;
	local preamble, extended, editable;
	if (this.itemid) then
		local name,itemid = GetItemInfo(this.itemid);
		if (name and itemid) then
			GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
			GameTooltip:SetHyperlink(itemid);
		else
			local tmp = "item:"..this.itemid..":0:0:0";
			GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
			GameTooltip:SetHyperlink("item:"..this.itemid..":0:0:0");
		end
		return;
	end
	if (this.category) then
		buttonInfo = this.category;
		extended=true;
	elseif (string.find(this:GetName(), "^AutoBarConfigFrameSlots_Button")) then
		buttonInfo = AutoBar_Config[AutoBarConfig.editPlayer].buttons[this:GetID()];
		extended = true;
		preamble = true;
		editable = true;
	elseif (string.find(this:GetName(), "^AutoBarConfigFrameSlotsView_Button")) then
		buttonInfo = AutoBar.buttons[this:GetID()];
		extended = true;
		preamble = true;
		editable = false;
	elseif (string.find(this:GetName(), "^AutoBarConfigSlotFrame_Button")) then
		extended=true;
		editable = AutoBarConfigSlot.editable;
		buttonInfo = AutoBarConfigSlot.slots[AutoBarConfigSlot.slotsIndex][this:GetID()]
	end
	local message = "";
	if (not buttonInfo or type(buttonInfo) == "table" and not buttonInfo[1]) then
	elseif (type(buttonInfo) == "table") then
		if (preamble) then message = AUTOBAR_TOOLTIP9; end
		local index,cat;
		for index, cat in pairs(buttonInfo) do
			if (type(cat) == "string" and AutoBar_Category_Info[cat]) then
				message = message.."\n"..AutoBar_Category_Info[cat].description;
			elseif (type(cat) == "number") then
				local name = GetItemInfo(cat);
				if (name) then
					message = message.."\n"..name..AUTOBAR_TOOLTIP10;
				else
					message = message..AUTOBAR_TOOLTIP11;
				end
--			else
--				message = message.."\n"..cat..AUTOBAR_TOOLTIP12;
			end
		end
	elseif (type(buttonInfo) == "string" and AutoBar_Category_Info[buttonInfo]) then
		if (preamble) then message = AUTOBAR_TOOLTIP13; end
		message = message..AutoBar_Category_Info[buttonInfo].description;
		if (extended) then
			message = message.."\n";
			if (AutoBar_Category_Info[buttonInfo].notusable) then
				message = message..AUTOBAR_TOOLTIP14;
			end
			if (AutoBar_Category_Info[buttonInfo].targetted) then
				if (AutoBar_Category_Info[buttonInfo].targetted == "WEAPON") then
					message = message..AUTOBAR_TOOLTIP15;
				else
					message = message..AUTOBAR_TOOLTIP16;
				end
			end
			if (AutoBar_Category_Info[buttonInfo].noncombat) then
				message = message..AUTOBAR_TOOLTIP17;
			end
			if (AutoBar_Category_Info[buttonInfo].combatonly) then
				message = message..AUTOBAR_TOOLTIP18;
			end
			if (AutoBar_Category_Info[buttonInfo].location) then
				message = message..AUTOBAR_TOOLTIP19..AutoBar_Category_Info[buttonInfo].location..".";
			end
			if (AutoBar_Category_Info[buttonInfo].limit) then
				message = message..AUTOBAR_TOOLTIP20;
				if (AutoBar_Category_Info[buttonInfo].limit.downhp) then
					message = message..AUTOBAR_TOOLTIP21;
					if (AutoBar_Category_Info[buttonInfo].limit.downmana) then
						message = message..", ";
					end
				end
				if (AutoBar_Category_Info[buttonInfo].limit.downmana) then
					message = message..AUTOBAR_TOOLTIP22;
				end
			end

		end
	elseif (type(buttonInfo) == "string" and not AutoBar_Category_Info[buttonInfo]) then
		if (preamble) then message = AUTOBAR_TOOLTIP23; end
		message = message..buttonInfo..AUTOBAR_TOOLTIP12;
	elseif (type(buttonInfo) == "number") then
		if (preamble) then message = AUTOBAR_TOOLTIP23; end
		local name = GetItemInfo(buttonInfo);
		if (name) then
			message = message..name..AUTOBAR_TOOLTIP10;
		else
			message = message..AUTOBAR_TOOLTIP11;
		end
	end

	GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
	GameTooltip:SetText(message);
end


-- Hook PickupContainerItem so we know what bag & slot is being dragged from
AutoBarConfig.PickupContainerItem = PickupContainerItem;
local dragBag = nil;
local dragSlot = nil;

function PickupContainerItem(bag, slot, ...)
	local returnTab = { AutoBarConfig.PickupContainerItem(bag, slot, unpack(arg)) };

	if (CursorHasItem()) then
		dragBag = bag;
		dragSlot = slot;
	end

	return unpack(returnTab);
end


function AutoBarConfig:GetDragBagSlot()
	return dragBag, dragSlot;
end


function AutoBarConfig:ViewButtonOnClick(mousebutton)
	ResetCursor();
	AutoBar.dragging = nil;
	return AutoBarConfigSlot:View(this:GetID(), AutoBar);
end


function AutoBarConfig:ButtonOnClick(mousebutton)
	ResetCursor();
	AutoBar.dragging = nil;
	return AutoBarConfigSlot:Edit(this:GetID(), AutoBar_Config[AutoBarConfig.editPlayer]);
end


function AutoBarConfig.ViewButtonOnDragStart()
	local fromIndex = this:GetID();
	AutoBar.SetDraggingIndex("AutoBarConfigFrameView", fromIndex);
	SetCursor("BUY_CURSOR");
end


function AutoBarConfig.ButtonOnDragStart()
	local fromIndex = this:GetID();
	AutoBar.SetDraggingIndex("AutoBarConfigFrame", fromIndex);
	SetCursor("BUY_CURSOR");
end


function AutoBarConfig.ButtonOnReceiveDrag()
	local toIndex = this:GetID();
	local fromIndex = AutoBar.GetDraggingIndex("AutoBarConfigFrame");
	local fromViewIndex = AutoBar.GetDraggingIndex("AutoBarConfigFrameView");
	if (fromIndex and fromIndex ~= toIndex) then
		local fromButton = AutoBar_Config[AutoBarConfig.editPlayer].buttons[fromIndex];
		AutoBar_Config[AutoBarConfig.editPlayer].buttons[fromIndex] = AutoBar_Config[AutoBarConfig.editPlayer].buttons[toIndex];
		AutoBar_Config[AutoBarConfig.editPlayer].buttons[toIndex] = fromButton;
	elseif (fromViewIndex) then
		AutoBar_Config[AutoBarConfig.editPlayer].buttons[toIndex] = AutoBar.buttons[fromViewIndex];
	end
	AutoBarProfile:ButtonsChanged();
	AutoBar.dragging = nil;
	ResetCursor();
end

function AutoBarConfig.OnEnter()
	if (AutoBar.dragging) then
		SetCursor("BUY_CURSOR");
	end
end


--
-- Slider handling
--

AutoBarConfigSliders =
{
	rows =
	{
		["name"] = "AutoBarConfigFrameBarRows",
		["text"] = L["AUTOBAR_CONFIG_ROW"].." - ",
		["default"] = 1,
	},
	columns =
	{
		["name"] = "AutoBarConfigFrameBarColumns",
		["text"] = L["AUTOBAR_CONFIG_COLUMN"].." - ",
		["default"] = AUTOBAR_MAXBUTTONS,
	},
	gapping =
	{
		["name"] = "AutoBarConfigFrameBarGapping",
		["text"] = L["AUTOBAR_CONFIG_GAPPING"].." - ",
		["default"] = 3,
	},
	alpha =
	{
		["name"] = "AutoBarConfigFrameButtonsAlpha",
		["text"] = L["AUTOBAR_CONFIG_ALPHA"].." - ",
		["default"] = 10,
	},
	buttonWidth =
	{
		["name"] = "AutoBarConfigFrameBarButtonWidth",
		["text"] = L["AUTOBAR_CONFIG_BUTTONWIDTH"].." - ",
		["default"] = 36,
	},
	buttonHeight =
	{
		["name"] = "AutoBarConfigFrameBarButtonHeight",
		["text"] = L["AUTOBAR_CONFIG_BUTTONHEIGHT"].." - ",
		["default"] = 36,
	},
	dockShiftX =
	{
		["name"] = "AutoBarConfigFrameBarDockShiftX",
		["text"] = L["AUTOBAR_CONFIG_DOCKSHIFTX"].." - ",
		["default"] = 0,
	},
	dockShiftY =
	{
		["name"] = "AutoBarConfigFrameBarDockShiftY",
		["text"] = L["AUTOBAR_CONFIG_DOCKSHIFTY"].." - ",
		["default"] = 0,
	},
}


function AutoBarConfig:SliderGetValue(sliderName, calledFromSlider)
	local value = nil;
	local profile = AutoBarProfile:GetProfile();
	if (calledFromSlider) then
		value = getglobal(AutoBarConfigSliders[sliderName]["name"]):GetValue();
	end
	if ((not value or value == 0) and (AutoBar_Config[profile.layoutProfile] and AutoBar_Config[profile.layoutProfile].display and AutoBar_Config[profile.layoutProfile].display[sliderName])) then
		value = AutoBar_Config[profile.layoutProfile].display[sliderName];
	elseif (not value or value == 0) then
		value = AutoBarConfigSliders[sliderName]["default"];
	end
	return value;
end


function AutoBarConfig:SliderSetValue(sliderName, value, textValue)
	if (not textValue) then
		textValue = tostring(value);
	end
--DEFAULT_CHAT_FRAME:AddMessage("AutoBarConfig:SliderSetValue " ..sliderName);
	getglobal(AutoBarConfigSliders[sliderName]["name"] .. "Text"):SetText(AutoBarConfigSliders[sliderName]["text"]..textValue);
	getglobal(AutoBarConfigSliders[sliderName]["name"]):SetValue(value);
end


function AutoBarConfigSliderValueChanged(calledFromSlider)
	local profile = AutoBarProfile:GetProfile();
	if (not AutoBar_Config[profile.layoutProfile].display) then
		AutoBar_Config[profile.layoutProfile].display = {};
	end

	local rows = AutoBarConfig:SliderGetValue("rows", calledFromSlider);
	local columns = AutoBarConfig:SliderGetValue("columns", calledFromSlider);
	local gapping = AutoBarConfig:SliderGetValue("gapping", calledFromSlider);
	local alpha = AutoBarConfig:SliderGetValue("alpha", calledFromSlider);
	local buttonWidth = AutoBarConfig:SliderGetValue("buttonWidth", calledFromSlider);
	local buttonHeight = AutoBarConfig:SliderGetValue("buttonHeight", calledFromSlider);
	local dockShiftX = AutoBarConfig:SliderGetValue("dockShiftX", calledFromSlider);
	local dockShiftY = AutoBarConfig:SliderGetValue("dockShiftY", calledFromSlider);

	if (calledFromSlider) then
		if (rows * columns > AUTOBAR_MAXBUTTONS) then
			if (this:GetName() == AutoBarConfigSliders["rows"]["name"]) then
				rows = getglobal(AutoBarConfigSliders["rows"]["name"]):GetValue();
				columns = math.floor(AUTOBAR_MAXBUTTONS / rows);
			else
				columns = getglobal(AutoBarConfigSliders["columns"]["name"]):GetValue();
				rows = math.floor(AUTOBAR_MAXBUTTONS / columns);
			end
		end
		if (buttonHeight ~= buttonWidth and not AutoBar_Config[profile.layoutProfile].display.widthHeightUnlocked) then
			if (this:GetName() == AutoBarConfigSliders["buttonWidth"]["name"]) then
				buttonHeight = buttonWidth;
			elseif (this:GetName() == AutoBarConfigSliders["buttonHeight"]["name"]) then
				buttonWidth = buttonHeight;
			end
		end

		AutoBar_Config[profile.layoutProfile].display.rows = rows;
		AutoBar_Config[profile.layoutProfile].display.columns = columns;
		AutoBar_Config[profile.layoutProfile].display.gapping = gapping;
		AutoBar_Config[profile.layoutProfile].display.alpha = alpha;
		AutoBar_Config[profile.layoutProfile].display.buttonWidth = buttonWidth;
		AutoBar_Config[profile.layoutProfile].display.buttonHeight = buttonHeight;
		AutoBar_Config[profile.layoutProfile].display.dockShiftX = dockShiftX;
		AutoBar_Config[profile.layoutProfile].display.dockShiftY = dockShiftY;
	end

	AutoBarConfig:SliderSetValue("rows", rows);
	AutoBarConfig:SliderSetValue("columns", columns);
	AutoBarConfig:SliderSetValue("gapping", gapping);
	AutoBarConfig:SliderSetValue("alpha", alpha, math.floor(alpha) / 10);
	AutoBarConfig:SliderSetValue("buttonWidth", buttonWidth);
	AutoBarConfig:SliderSetValue("buttonHeight", buttonHeight);
	AutoBarConfig:SliderSetValue("dockShiftX", dockShiftX);
	AutoBarConfig:SliderSetValue("dockShiftY", dockShiftY);

	AutoBar_SetupVisual();
end


--
-- Checkbox handling
--

-- Disabling a layer disables editing of it as well
function AutoBarConfig:UseCheckBoxOnClick()
	local profile = AutoBarProfile:GetProfile();

	-- Only edit used layers
	if (not profile.useBasic and profile.edit == 4) then
		profile.edit = 0;
	end
	if (not profile.useClass and profile.edit == 3) then
		profile.edit = 0;
	end
	if (not profile.useShared and profile.edit == 2) then
		profile.edit = 0;
	end
	if (not profile.useCharacter and profile.edit == 1) then
		profile.edit = 0;
	end

	-- Assign editing to a used layer
	if (profile.edit == 0) then
		if (profile.useCharacter) then
			profile.edit = 1;
		elseif (profile.useShared) then
			profile.edit = 2;
		elseif (profile.useClass) then
			profile.edit = 3;
		elseif (profile.useBasic) then
			profile.edit = 4;
		end

		-- Enforce at least one used layer
		if (profile.edit == 0) then
			profile.useCharacter = true;
			profile.edit = 1;
		end
		AutoBarProfile:ProfileEditingChanged();
	end

	AutoBarProfile:ProfileChanged();
end


AutoBarConfig.checkboxes =
{
	["edit"] =
	{
		["variable"] = "profile",
		["name"] = "AutoBarConfigFrameSlotsEdit",
		["text1"] = AUTOBAR_CONFIG_EDITCHARACTER,
		["text2"] = AUTOBAR_CONFIG_EDITSHARED,
		["text3"] = AUTOBAR_CONFIG_EDITCLASS,
		["text4"] = AUTOBAR_CONFIG_EDITBASIC,
		["radio"] = 4,
		["default"] = 2,
		["callback"] = AutoBarProfile.ProfileEditingChanged,
	},
	["alignButtons"] =
	{
		["variable"] = "display",
		["name"] = "AutoBarConfigFrameBarAlign",
		["text6"] = L["AUTOBAR_CONFIG_ALIGN"],
		["radio"] = 9,
		["default"] = 1,
	},
	["hideDragHandle"] =
	{
		["variable"] = "display",
		["name"] = "AutoBarConfigFrameBarHideDragHandle",
		["text"] = L["AUTOBAR_CONFIG_HIDEDRAGHANDLE"],
	},
	["widthHeightUnlocked"] =
	{
		["variable"] = "display",
		["name"] = "AutoBarConfigFrameBarWidthHeightUnlocked",
		["text"] = L["AUTOBAR_CONFIG_WIDTHHEIGHTUNLOCKED"],
	},
	["hideKeyText"] =
	{
		["variable"] = "display",
		["name"] = "AutoBarConfigFrameButtonsHideKeyText",
		["text"] = L["AUTOBAR_CONFIG_HIDEKEYBINDING"],
	},
	["hideCount"] =
	{
		["variable"] = "display",
		["name"] = "AutoBarConfigFrameButtonsHideCount",
		["text"] = L["AUTOBAR_CONFIG_HIDECOUNT"],
	},
	["plainButtons"] =
	{
		["variable"] = "display",
		["name"] = "AutoBarConfigFrameButtonsPlainButtons",
		["text"] = L["AUTOBAR_CONFIG_PLAINBUTTONS"],
	},
	["autoSmartSelfCast"] =
	{
		["variable"] = "display",
		["name"] = "AutoBarConfigFrameButtonsSmartSelfCast",
		["text"] = L["AUTOBAR_CONFIG_SMARTSELFCAST"],
	},
	["showEmptyButtons"] =
	{
		["variable"] = "display",
		["name"] = "AutoBarConfigFrameButtonsShowEmptyButtons",
		["text"] = L["AUTOBAR_CONFIG_SHOWEMPTY"],
	},
	["showCategoryIcon"] =
	{
		["variable"] = "display",
		["name"] = "AutoBarConfigFrameButtonsShowCategoryIcon",
		["text"] = L["AUTOBAR_CONFIG_SHOWCATEGORYICON"],
	},
	["hideTooltips"] =
	{
		["variable"] = "display",
		["name"] = "AutoBarConfigFrameButtonsHideTooltips",
		["text"] = L["AUTOBAR_CONFIG_HIDETOOLTIP"],
	},
	["popupToTop"] =
	{
		["variable"] = "display",
		["name"] = "AutoBarConfigFramePopupPopupToTop",
		["text"] = nil,
		["group"] = "PopupTo",
	},
	["popupToLeft"] =
	{
		["variable"] = "display",
		["name"] = "AutoBarConfigFramePopupPopupToLeft",
		["text"] = nil,
		["group"] = "PopupTo",
	},
	["popupToRight"] =
	{
		["variable"] = "display",
		["name"] = "AutoBarConfigFramePopupPopupToRight",
		["text"] = L["AUTOBAR_CONFIG_POPUPDIRECTION"],
		["group"] = "PopupTo",
	},
	["popupToBottom"] =
	{
		["variable"] = "display",
		["name"] = "AutoBarConfigFramePopupPopupToBottom",
		["text"] = nil,
		["group"] = "PopupTo",
	},
	["popupDisable"] =
	{
		["variable"] = "display",
		["name"] = "AutoBarConfigFramePopupPopupDisable",
		["text"] = L["AUTOBAR_CONFIG_POPUPDISABLE"],
	},
	["popupOnShift"] =
	{
		["variable"] = "display",
		["name"] = "AutoBarConfigFramePopupPopupOnShift",
		["text"] = L["AUTOBAR_CONFIG_POPUPONSHIFT"],
	},
	["useCharacter"] =
	{
		["variable"] = "profile",
		["name"] = "AutoBarConfigFrameSlotsViewUseCharacter",
		["text"] = AUTOBAR_CONFIG_USECHARACTER,
		["callback"] = AutoBarConfig.UseCheckBoxOnClick,
	},
	["useShared"] =
	{
		["variable"] = "profile",
		["name"] = "AutoBarConfigFrameSlotsViewUseShared",
		["text"] = AUTOBAR_CONFIG_USESHARED,
		["callback"] = AutoBarConfig.UseCheckBoxOnClick,
	},
	["useClass"] =
	{
		["variable"] = "profile",
		["name"] = "AutoBarConfigFrameSlotsViewUseClass",
		["text"] = AUTOBAR_CONFIG_USECLASS,
		["callback"] = AutoBarConfig.UseCheckBoxOnClick,
	},
	["useBasic"] =
	{
		["variable"] = "profile",
		["name"] = "AutoBarConfigFrameSlotsViewUseBasic",
		["text"] = AUTOBAR_CONFIG_USEBASIC,
		["callback"] = AutoBarConfig.UseCheckBoxOnClick,
	},
	["layout"] =
	{
		["variable"] = "profile",
		["name"] = "AutoBarConfigFrameLayout",
		["text1"] = AUTOBAR_CONFIG_CHARACTERLAYOUT,
		["text2"] = AUTOBAR_CONFIG_SHAREDLAYOUT,
		["radio"] = 2,
		["default"] = 2,
		["callback"] = AutoBarProfile.LayoutChanged,
	},
	["hideConfigTooltips"] =
	{
		["variable"] = "profile",
		["name"] = "AutoBarConfigFrameProfileHideConfigTooltips",
		["text"] = AUTOBAR_CONFIG_HIDECONFIGTOOLTIPS,
	},
	["oSkin"] =
	{
		["variable"] = "display",
		["name"] = "AutoBarConfigFrameProfileoSkin",
		["text"] = AUTOBAR_CONFIG_OSKIN,
		["callback"] = AutoBarConfig.SkinInitialize,
	},
}


function AutoBarConfig:CheckBoxInitialize()
	local checkbox, checkboxText, text;
	local profile = AutoBarProfile:GetProfile();
	for key, checkboxData in pairs(AutoBarConfig.checkboxes) do
		if (checkboxData["radio"]) then
			local x;
			if (checkboxData.variable == "profile") then
				x = profile[key];
			else
				x = AutoBar_Config[profile.layoutProfile][checkboxData.variable][key];
			end
			if (not x) then
				x = checkboxData["default"] or 1;
			end

			for index = 1, checkboxData["radio"], 1 do
				checkbox = getglobal(checkboxData.name..index);
				checkboxText = getglobal(checkboxData.name .. index .. "Text");

				if (index ~= x) then
					checkbox:SetChecked(false);
				else
					checkbox:SetChecked(true);
				end

				text = checkboxData["text" .. index];
				if (text) then
					checkboxText:SetText(text);
				else
					checkboxText:Hide();
				end
			end
		else
			checkbox = getglobal(checkboxData.name);
			checkboxText = getglobal(checkboxData.name .. "Text");

			if (checkboxData.variable == "profile") then
				checkbox:SetChecked(profile[key]);
			else
				checkbox:SetChecked(AutoBar_Config[profile.layoutProfile][checkboxData.variable][key]);
			end

			text = checkboxData["text"];
			if (text) then
				checkboxText:SetText(checkboxData["text"]);
			else
				checkboxText:Hide();
			end
		end
	end

	if (profile.useBasic) then
		AutoBarConfigFrameSlotsEdit4:Show();
	else
		AutoBarConfigFrameSlotsEdit4:Hide();
	end
	if (profile.useClass) then
		AutoBarConfigFrameSlotsEdit3:Show();
	else
		AutoBarConfigFrameSlotsEdit3:Hide();
	end
	if (profile.useShared) then
		AutoBarConfigFrameSlotsEdit2:Show();
	else
		AutoBarConfigFrameSlotsEdit2:Hide();
	end
	if (profile.useCharacter) then
		AutoBarConfigFrameSlotsEdit1:Show();
	else
		AutoBarConfigFrameSlotsEdit1:Hide();
	end
end


function AutoBarConfig:CheckBoxOnClick()
	local buttonName = this:GetName();
	local group = nil;
	local theCheckboxData;
	local profile = AutoBarProfile:GetProfile();
	for key, checkboxData in pairs(AutoBarConfig.checkboxes) do
		if (buttonName == checkboxData["name"]) then
			if (checkboxData.variable == "profile") then
				profile[key] = this:GetChecked();
			else
				AutoBar_Config[profile.layoutProfile][checkboxData.variable][key] = this:GetChecked();
			end

			-- Radio button behavior
			group = checkboxData["group"];
			if (group) then
				-- Set clicked one to true
				AutoBar_Config[profile.layoutProfile][checkboxData.variable][key] = true;
				this:SetChecked(true);

				-- Set other group members to false
				for keyGroup, checkboxDataGroup in pairs(AutoBarConfig.checkboxes) do
					if (buttonName ~= checkboxDataGroup.name and group == checkboxDataGroup.group) then
						AutoBar_Config[profile.layoutProfile][checkboxData.variable][keyGroup] = false;
						getglobal(checkboxDataGroup.name):SetChecked(false);
					end
				end
			end
			theCheckboxData = checkboxData;
			break;
		-- This needs to be extended if there is a 10+ item radio group
		elseif (checkboxData["radio"] and string.sub(buttonName, 1, string.len(buttonName) - 1) == checkboxData["name"]) then
			this:SetChecked(true);
			local x = tonumber(string.sub(buttonName, string.len(buttonName)));
			if (checkboxData.variable == "profile") then
				profile[key] = x;
			else
				AutoBar_Config[profile.layoutProfile][checkboxData.variable][key] = x;
			end
			for index = 1, checkboxData["radio"], 1 do
				if (index ~= x) then
					getglobal(checkboxData.name..x):SetChecked(false);
				end
			end
			theCheckboxData = checkboxData;
			break;
		end
	end

	if (theCheckboxData.callback) then
		theCheckboxData.callback();
	end

	AutoBarConfig:CheckBoxInitialize();
	AutoBar_SetupVisual();
end


--
-- Dropdown menu to choose the profile we are editing
--

-- Using _SHARED so it can be treated like AutoBar.currentPlayer with no chance of colliding with a real player name.
AutoBarConfig.sharedProfiles = {
		["_SHARED1"] = AUTOBAR_CONFIG_SHARED1,
		["_SHARED2"] = AUTOBAR_CONFIG_SHARED2,
		["_SHARED3"] = AUTOBAR_CONFIG_SHARED3,
		["_SHARED4"] = AUTOBAR_CONFIG_SHARED4,
	};

function AutoBarConfig:SetSharedInitialize()
	if (not AutoBarConfigFrameProfileSetShared.dewdrop) then
		AutoBarConfigFrameProfileSetSharedButton.dewdrop = dewdrop;
		dewdrop:Register(AutoBarConfigFrameProfileSetShared, 'children', AutoBarConfig.SetSharedSetup,
			'point', function(parent) return "TOPLEFT", "TOPRIGHT" end
		);
	end
	local setSharedTarget = AutoBarConfig:GetSetSharedTarget();
	AutoBarConfigFrameProfileSetSharedText:SetText(AutoBarConfig.sharedProfiles[setSharedTarget]);
end


function AutoBarConfig:GetSetSharedTarget()
	local setSharedTarget = "_SHARED1";
	local profile = AutoBarProfile:GetProfile();
	if (AutoBar_Config and AutoBar_Config[AutoBar.currentPlayer] and profile and profile.shared) then
		setSharedTarget = profile.shared;
	end

	-- Get rid of obsolete shared names
	if (not AutoBarConfig.sharedProfiles[setSharedTarget]) then
		setSharedTarget = "_SHARED1";
	end

	return setSharedTarget;
end


function AutoBarConfig.SetSharedSetup()
	local checked;
	local setSharedTarget = AutoBarConfig:GetSetSharedTarget();
	for targetName, targetText in pairs(AutoBarConfig.sharedProfiles) do
		if (targetName == setSharedTarget) then
			checked = true;
		    AutoBarConfigFrameProfileSetSharedText:SetText(targetText);
		else
			checked = false;
		end
		dewdrop:AddLine(
			'text', targetText,
			'checked', checked,
			'func', AutoBarConfig.SetSharedOnClick,
			'arg1', targetName,
			'arg2', targetText,
			'closeWhenClicked', true
		);
	end
end


-- SetShared Dropdown Menu callback
function AutoBarConfig.SetSharedOnClick(targetName, targetText)
	AutoBarProfile:GetProfile().shared = targetName;

	AutoBarProfile:ProfileChanged();
	AutoBarConfig.OnShow();
    AutoBarConfigFrameProfileSetSharedText:SetText(targetText);
	AutoBar_SetupVisual();
end


--
-- Dropdown menu for docking to various frames
--

AutoBarConfig.dockingFrames = {
		["NONE"] = {
			text = L["AUTOBAR_CONFIG_DOCKTONONE"],
			offset = { x = 0, y = 0, point = "CENTER", relative = "TOPLEFT" },
		},
		["GSecondBar"] = {
			text = L["AUTOBAR_CONFIG_DOCKTOGBARS"],
			offset = { x = 0, y = 0, point = "CENTER", relative = "TOPLEFT" },
		},
		["MainMenuBarArtFrame"] = {
			text = L["AUTOBAR_CONFIG_DOCKTOMAIN"],
			offset = { x = 0, y = 0, point = "CENTER", relative = "TOPRIGHT" },
		},
		["ChatFrame1"] = {
			text = L["AUTOBAR_CONFIG_DOCKTOCHATFRAME"],
			offset = { x = 0, y = 25, point = "CENTER", relative = "TOPLEFT" },
		},
		["ChatFrameMenuButton"] = {
			text = L["AUTOBAR_CONFIG_DOCKTOCHATFRAMEMENU"],
			offset = { x = 0, y = 25, point = "CENTER", relative = "TOPLEFT" },
		},
		["MainMenuBar"] = {
			text = L["AUTOBAR_CONFIG_DOCKTOACTIONBAR"],
			offset = { x = 7, y = 40, point = "CENTER", relative = "TOPLEFT" },
		},
		["CharacterMicroButton"] = {
			text = L["AUTOBAR_CONFIG_DOCKTOMENUBUTTONS"],
			offset = { x = 0, y = 0, point = "CENTER", relative = "BOTTOMLEFT" },
		},
	};

function AutoBarConfig:DockToInitialize()
	if (not AutoBarConfigFrameBarDockTo.dewdrop) then
		AutoBarConfigFrameBarDockToButton.dewdrop = dewdrop;
		dewdrop:Register(AutoBarConfigFrameBarDockTo, 'children', AutoBarConfig.DockToSetup,
			'point', function(parent) return "TOPLEFT", "TOPRIGHT" end
		);
	end
	local dockToFrame = AutoBarConfig:GetDockToFrame();
	AutoBarConfigFrameBarDockToText:SetText(AutoBarConfig.dockingFrames[dockToFrame].text);
end


function AutoBarConfig:GetDockToFrame()
	local dockToFrame = "NONE";
	local profile = AutoBarProfile:GetProfile();
	if (AutoBar_Config and AutoBar_Config[profile.layoutProfile] and AutoBar_Config[profile.layoutProfile].display and AutoBar_Config[profile.layoutProfile].display.docking) then
		dockToFrame = AutoBar_Config[profile.layoutProfile].display.docking;
	end
	return dockToFrame;
end


function AutoBarConfig.DockToSetup()
	local checked, frameText;
	local dockToFrame = AutoBarConfig:GetDockToFrame();
	for frameName, frameInfo in pairs(AutoBarConfig.dockingFrames) do
--DEFAULT_CHAT_FRAME:AddMessage("AutoBarConfig.DockToSetup " ..frameName.. " " ..dockToFrame);
		frameText = frameInfo.text;
		if (frameName == dockToFrame) then
			checked = true;
		    AutoBarConfigFrameBarDockToText:SetText(frameText);
		else
			checked = false;
		end
		dewdrop:AddLine(
			'text', frameText,
			'checked', checked,
			'func', AutoBarConfig.DockToOnClick,
			'arg1', frameName,
			'arg2', frameText,
			'closeWhenClicked', true
		);
	end
end


-- DockTo Dropdown Menu callback
function AutoBarConfig.DockToOnClick(frameName, frameText)
	local profile = AutoBarProfile:GetProfile();
	if (frameName ~= "NONE") then
		AutoBar_Config[profile.layoutProfile].display.docking = frameName;
	else
		AutoBar_Config[profile.layoutProfile].display.docking = nil;
	end
    AutoBarConfigFrameBarDockToText:SetText(frameText);
	AutoBar_SetupVisual();
end


--
-- Profile Quick Setup Buttons
--

function AutoBarConfig:SetupSingle()
	AutoBarProfile:SetDefaultsSingle();
	AutoBarProfile:ProfileEditingChanged();
end


function AutoBarConfig:SetupShared()
	AutoBarProfile:SetDefaultsShared();
	AutoBarProfile:ProfileEditingChanged();
end


function AutoBarConfig:SetupStandard()
	AutoBarProfile:SetDefaultsStandard();
	AutoBarProfile:ProfileEditingChanged();
end


function AutoBarConfig:SetupBlankSlate()
	AutoBarProfile:SetDefaultsBlankSlate();
	AutoBarProfile:ProfileEditingChanged();
end


function AutoBarConfig:ResetSingle()
	AutoBarProfile:SetDefaultsSingle();
	AutoBarProfile:ButtonsCopySingle();
	AutoBarProfile:ProfileEditingChanged();
end


function AutoBarConfig:ResetShared()
	AutoBarProfile:SetDefaultsShared();
	AutoBarProfile:ButtonsCopyShared();
	AutoBarProfile:ProfileEditingChanged();
end


function AutoBarConfig:ResetStandard()
	AutoBarProfile:SetDefaultsStandard();
	AutoBarProfile:ButtonsCopyStandard();
	AutoBarProfile:ProfileEditingChanged();
end


--
-- Tab panels
--

function AutoBarConfig:TabButtonOnClick(tabId)
	PanelTemplates_SetTab(AutoBarConfigFrame, tabId);
	PanelTemplates_UpdateTabs(AutoBarConfigFrame);
	AutoBar_Config[AutoBar.currentPlayer].display.selectedTab = tabId;
	for index, tabFrameName in pairs(tabFrameNames) do
		if (tabFrameName == tabFrameNames[tabId]) then
			getglobal("AutoBarConfigFrame" .. tabFrameName):Show();
		else
			getglobal("AutoBarConfigFrame" .. tabFrameName):Hide();
		end
	end

	if (tabFrameNames[tabId] == "Slots" or tabFrameNames[tabId] == "Profile") then
		AutoBarConfigFrameSlotsView:Show();
	else
		AutoBarConfigFrameSlotsView:Hide();
	end

	if (tabFrameNames[tabId] == "Slots") then
		AutoBarConfigFrameLayout1:Hide();
		AutoBarConfigFrameLayout2:Hide();
	else
		AutoBarConfigFrameLayout1:Show();
		AutoBarConfigFrameLayout2:Show();
	end
end


-- Initialize the config tabs
function AutoBarConfig:TabButtonInitialize()
	PanelTemplates_SetNumTabs(AutoBarConfigFrame, table.getn(tabFrameNames));
	if (not AutoBar_Config[AutoBar.currentPlayer].display.selectedTab) then
		AutoBar_Config[AutoBar.currentPlayer].display.selectedTab = 1;
	end

	AutoBarConfig:TabButtonOnClick(AutoBar_Config[AutoBar.currentPlayer].display.selectedTab)
	PanelTemplates_UpdateTabs(AutoBarConfigFrame);
end


-- Reset the the current tab to default
function AutoBarConfig:TabReset()
	local tabFrameName = tabFrameNames[AutoBar_Config[AutoBar.currentPlayer].display.selectedTab];
	if (tabFrameName == "Slots") then
		AutoBarConfig.SlotsReset();
	elseif (tabFrameName == "Profile") then
		AutoBarConfig.ProfileReset();
	else
		AutoBarConfig.DisplayReset();
	end
end


-- Reset the buttons to default
function AutoBarConfig.SlotsReset()
	local slots = AutoBar_Config[AutoBarConfig.editPlayer].buttons;
	for buttonIndex = 1, AUTOBAR_MAXBUTTONS, 1 do
		Compost:Erase(slots[buttonIndex]);
	end
	AutoBarProfile.Initialize();
	AutoBarProfile:ButtonsChanged()
	AutoBarConfig.OnShow();
end


-- Reset the display to default
function AutoBarConfig.DisplayReset()
	local profile = AutoBarProfile:GetProfile();
	AutoBar_Config[profile.layoutProfile].display = {};
	AutoBarProfile.Initialize();
	AutoBarProfile:DisplayChanged();
	AutoBarConfig.OnShow();
end


-- Reset the profile to default
function AutoBarConfig.ProfileReset()
	AutoBarProfile:SetDefaults();
	AutoBarProfile.Initialize();
	AutoBarProfile:ProfileChanged();
	AutoBarConfig.OnShow();
end

--DEFAULT_CHAT_FRAME:AddMessage("AutoBar.smartSelfcast category " .. category);
-- /script AutoBarConfigFrameTab1LeftDisabled:Hide()

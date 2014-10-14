BWP_TLocFu = AceLibrary("AceAddon-2.0"):new("AceConsole-2.0", "AceDB-2.0", "FuBarPlugin-2.0");
local L = AceLibrary("AceLocale-2.0"):new("BWP_TLocFu");
local Tablet = AceLibrary("Tablet-2.0");

L:RegisterTranslations("enUS", function() return {
	["tabletHint"] = "Type in Thottbot or Allakhazam Map Co-ordinates.....Shift+LeftClick To Clear Search",
	["labelName"] = "BWP:TLoc Search",
} end);

BWP_TLocFu:RegisterDB("BWPTLocFuDB");
BWP_TLocFu.hasIcon = true;
BWP_TLocFu.defaultPosition = "RIGHT";

local optionsTable = {
	handler = BWP_TLocFu,
	type = "group",
	args = {};
};

BWP_TLocFu:RegisterChatCommand({ "/bwptloc" }, optionsTable);
BWP_TLocFu.OnMenuRequest = optionsTable;

function BWP_TLocFu:OnTextUpdate()
	if (self:IsTextShown()) then
		self:ShowText();
		self:SetText("|cffffffff"..L"labelName".."|r");
	else
		self:HideText();
	end
end

function BWP_TLocFu:OnTooltipUpdate()
	Tablet:SetHint(L"tabletHint");
end

function BWP_TLocFu:OnClick()
 if IsShiftKeyDown() then
  BWP_ClearDest();
 else
	BWP_TLocFu_Toggle();
 end		
end

function BWP_TLocFu1_Submit()
	msg = BWP_TLocFu1FrameEdit:GetText();
	BWP_LocCommand(msg)
	if (BWP_TLocFu1Frame:IsVisible() ) then
		HideUIPanel(BWP_TLocFu1Frame);
		BWP_TLocFu1FrameEdit:SetText("");
	end
end

function BWP_TLocFu1_Clear()
  BWP_ClearDest();
  if (BWP_TLocFu1Frame:IsVisible() ) then
		HideUIPanel(BWP_TLocFu1Frame);
		BWP_TLocFu1FrameEdit:SetText("");
	end
end


function BWP_TLocFu_Toggle()
  if(BWP_TLocFu1Frame:IsVisible()) then
		HideUIPanel(BWP_TLocFu1Frame);
	else
		ShowUIPanel(BWP_TLocFu1Frame);
	end
end
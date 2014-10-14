-- 
-- MCP - Master Control Program
--
-- Allows you to control AddOn loading after logging in.
-- 
--  Marc aka Saien on Hyjal
--  WOWSaien@gmail.com
--  http://64.168.251.69/wow
--
-- Changes
--   2006.10.01
--	Update by Fin of Stormrage-EU // fin@instinct.org // http://fin.instinct.org/
--	Made the addon list "pushable"
--	Added colours to tooltip
--	Wrapped tooltip text
--	Added key binding to show MCP
--	Fixed typo in localization.lua preventing deletion of profiles
--   2006.09.09
--     2.2-BD release
--     Made sure MCP doesn't turn itself off when checking disable all addons
--   2006.09.06
--     2.1-BD release
--     Added localization 
--     Added enable/disable all buttons
--     Added tooltip when you mouse over an addon to show the notes
--   2006.09.02
--     2.0-BD release
--     modifications by Bluedragon, alliance Frostwolf server
--     Added slash command /mcp to open the window
--     Added profiles for quickly changing which addons are enabled/disabled
--   2006.01.02
--     1.9 release
--     In game changes to the addon list are limited to changing the currently 
--       logged in character only. You cannot change Addons for other characters. 
--       This is a Blizzard restriction.
--   2005.10.10
--     1.8 release

MCP_SelectedProfile = "NONE";

-- Binding Variables
BINDING_HEADER_MCP = "Master Control Panel (MCP)";
BINDING_NAME_SHOWMCP = "MCP list";
BINDING_NAME_DOOTHERSTUFF = "another name";
BINDING_NAME_DOMORESTUFF = "yet another name";

UIPanelWindows["MCP_AddonList"] = { area = "center", pushable = 1, whileDead = 1 };
StaticPopupDialogs["MCP_RELOADUI"] = {
	text = MCP_RELOAD,
	button1 = TEXT(ACCEPT),
	button2 = TEXT(CANCEL),
	OnAccept = function()
		ReloadUI();
	end,
	timeout = 0,
	hideOnEscape = 1
};

function MCP_DeleteDialog()
  StaticPopupDialogs["MCP_DELETEPROFILE"] = {
	text = MCP_DELETE_PROFILE_DIALOG..MCP_SelectedProfile,
	button1 = TEXT(ACCEPT),
	button2 = TEXT(CANCEL),
	OnAccept = function()
		MCP_DeleteProfile(MCP_SelectedProfile);
                MCP_SelectedProfile = "NONE";
                UIDropDownMenu_SetText(MCP_SelectedProfile, MCP_AddonList_ProfileSelection);
        end,
	timeout = 0,
	hideOnEscape = 1
  };
  StaticPopup_Show("MCP_DELETEPROFILE");
end

function MCP_SaveDialog()
  StaticPopupDialogs["MCP_SAVEPROFILE"] = {
        text = MCP_PROFILE_NAME_SAVE;
        button1 = TEXT(ACCEPT),
        button2 = TEXT(CANCEL),
        hasEditBox = 1,
        maxLetters = 32,
        hideOnEscape = 1,
        OnLoad = function()
                getglobal(this:GetParent():GetName().."EditBox"):SetText(MCP_SelectedProfile);
        end,
        OnAccept = function()
                MCP_SaveProfile(getglobal(this:GetParent():GetName().."EditBox"):GetText());
        end,
        timeout = 0,
        EditBoxOnEnterPressed = function()
                MCP_SaveProfile(getglobal(this:GetParent():GetName().."EditBox"):GetText());
                this:GetParent():Hide();
        end
  };
  StaticPopup_Show("MCP_SAVEPROFILE");
end


MCP_VERSION = "2006.10.01-fin";
MCP_LINEHEIGHT = 16;
local MCP_MAXADDONS = 20;
local MCP_BLIZZARD_ADDONS = { 
	"Blizzard_AuctionUI",
	"Blizzard_BattlefieldMinimap",
	"Blizzard_BindingUI",
	"Blizzard_CraftUI",
	"Blizzard_InspectUI",
	"Blizzard_MacroUI",
	"Blizzard_RaidUI",
	"Blizzard_TalentUI",
	"Blizzard_TradeSkillUI",
	"Blizzard_TrainerUI",
};
local MCP_BLIZZARD_ADDONS_TITLES = { 
	"Blizzard: Auction",
	"Blizzard: Battlefield Minimap",
	"Blizzard: Binding",
	"Blizzard: Craft",
	"Blizzard: Inspect",
	"Blizzard: Macro",
	"Blizzard: Raid",
	"Blizzard: Talent",
	"Blizzard: Trade Skill",
	"Blizzard: Trainer",
};
local MCP_old_LoadAddOn = nil;


local function MCP_new_LoadAddOn(name)
	if (not IsAddOnLoaded(name) and MCP_Config and MCP_Config.refusetoload and MCP_Config.refusetoload[name]) then
		return nil, "REFUSE_TO_LOAD";
	else
		return MCP_old_LoadAddOn(name);
	end
end

function MCP_OnLoad()
	MCP_old_LoadAddOn = LoadAddOn;
	LoadAddOn = MCP_new_LoadAddOn;

        -- setup /mcp slash command
        SlashCmdList["MCPSLASHCMD"] = MCP_SlashHandler;
        SLASH_MCPSLASHCMD1 = "/mcp";
end
-- /mcp slash command, only shows the UI
function MCP_SlashHandler(msg)
        ShowUIPanel(MCP_AddonList);
end

function MCP_AddonList_Enable(index,enabled)
	if (type(index) == "number") then
		if (enabled) then
			EnableAddOn(index)
		else
			DisableAddOn(index)
		end
	else
		if (enabled) then
			if (MCP_Config and MCP_Config.refusetoload) then
				MCP_Config.refusetoload[index] = nil;
			end
		else
			if (not MCP_Config) then MCP_Config = {}; end
			if (not MCP_Config.refusetoload) then MCP_Config.refusetoload = {}; end
			MCP_Config.refusetoload[index] = true;
		end
	end
	MCP_AddonList_OnShow();
end

function MCP_AddonList_LoadNow(index)
	UIParentLoadAddOn(index);
	MCP_AddonList_OnShow();
end

function MCP_AddonList_OnShow()
	local function setSecurity (obj, idx)
		local width,height,iconWidth = 64,16,16;
		local increment = iconWidth/width;
		local left = (idx-1)*increment;
		local right = idx*increment;
		obj:SetTexCoord(left, right, 0, 1);
	end

	local numAddons = GetNumAddOns();
	local origNumAddons = numAddons;
	numAddons = numAddons + table.getn(MCP_BLIZZARD_ADDONS);
	FauxScrollFrame_Update(MCP_AddonList_ScrollFrame, numAddons, MCP_MAXADDONS, MCP_LINEHEIGHT, nil, nil, nil);
	local i;
	local offset = FauxScrollFrame_GetOffset(MCP_AddonList_ScrollFrame);
	for i = 1, MCP_MAXADDONS, 1 do
		obj = getglobal("MCP_AddonListEntry"..i);
		local addonIdx = offset+i;
		if (addonIdx > numAddons) then
			obj:Hide();
			obj.addon = nil;
		else
			obj:Show();
			local titleText = getglobal("MCP_AddonListEntry"..i.."Title");
			local status = getglobal("MCP_AddonListEntry"..i.."Status");
			local checkbox = getglobal("MCP_AddonListEntry"..i.."Enabled");
			local securityIcon = getglobal("MCP_AddonListEntry"..i.."SecurityIcon");
			local loadnow = getglobal("MCP_AddonListEntry"..i.."LoadNow");

			local name, title, notes, enabled, loadable, reason, security;
			if (addonIdx > origNumAddons) then
				name = MCP_BLIZZARD_ADDONS[(addonIdx-origNumAddons)];
				obj.addon = name;
				title = MCP_BLIZZARD_ADDONS_TITLES[(addonIdx-origNumAddons)];
				notes = "";
				if (MCP_Config and MCP_Config.refusetoload and MCP_Config.refusetoload[name]) then
					enabled = nil;
					loadable = nil;
					reason = "WILL_NOT_LOAD";
				else
					enabled = 1;
					loadable = 1;
				end
				if (IsAddOnLoaded(name)) then
					reason = "LOADED";
					loadable = 1;
				end
				security = "SECURE";
			else
				name, title, notes, enabled, loadable, reason, security = GetAddOnInfo(addonIdx);
				obj.addon = addonIdx;
			end
			local loaded = IsAddOnLoaded(name);
			local ondemand = IsAddOnLoadOnDemand(name);
			if (loadable) then
				titleText:SetTextColor(1,0.78,0);
			elseif (enabled and reason ~= "DEP_DISABLED") then
				titleText:SetTextColor(1,0.1,0.1);
			else
				titleText:SetTextColor(0.5,0.5,0.5);
			end
			if (title) then
				titleText:SetText(title);
			else
				titleText:SetText(name);
			end
			if (title == "Master Control Program") then
				checkbox:Hide();
			else
				checkbox:Show();
				checkbox:SetChecked(enabled);
			end
			if (security == "SECURE") then
				setSecurity(securityIcon,1);
			elseif (security == "INSECURE") then
				setSecurity(securityIcon,2);
			elseif (security == "BANNED") then
				setSecurity(securityIcon,3);
			end
			if (reason) then
				status:SetText(TEXT(getglobal("MCP_ADDON_"..reason)));
			elseif (loaded) then
				status:SetText(TEXT(MCP_ADDON_LOADED));
			elseif (ondemand) then
				status:SetText(MCP_LOADED_ON_DEMAND);
			else
				status:SetText("");
			end
			if (not loaded and enabled and ondemand) then
				loadnow:Show();
			else
				loadnow:Hide();
			end
		end

	end
end



function MCP_SaveProfile(profile)
  if profile == "NONE" then return end

  local numAddons = GetNumAddOns();
  local i;

  -- make sure we have a config for profile setup
  if not MCP_Config then MCP_Config = {} end
  if not MCP_Config.profiles then MCP_Config.profiles = {} end

  -- setup this profile, and clear any previous data in case it exists
  MCP_Config.profiles[profile] = {};

  -- set each addon to be loaded or not loaded
  for i = 1, numAddons do
    local name, title, notes, enabled, loadable, reason, security = GetAddOnInfo(i);
    if enabled then
      MCP_Config.profiles[profile][name] = 1;
    else
      MCP_Config.profiles[profile][name] = 0;
    end
  end


  StaticPopupDialogs["MCP_PROFILESAVED"] = {
    text=MCP_PROFILE_SAVED..profile,
    button1 = TEXT(OK),
    OnAccept = function()
    end,
    timeout = 2,
    hideOnEscape = 1
  };

  StaticPopup_Show("MCP_PROFILESAVED");
end

function MCP_LoadProfile()
  local i;
  local addons;

  MCP_SelectedProfile = this.value;
  if not MCP_SelectedProfile or MCP_SelectedProfile == "" then
    MCP_SelectedProfile = "NONE";
    return;
  end


  for addons in MCP_Config.profiles[MCP_SelectedProfile] do
    if MCP_Config.profiles[MCP_SelectedProfile][addons] == 1 then
      EnableAddOn(addons);
    else
      DisableAddOn(addons);
    end
  end


  if not MCP_Config then MCP_Config = {}; end
  MCP_Config.SelectedProfile = MCP_SelectedProfile;
  UIDropDownMenu_SetText(MCP_SelectedProfile, MCP_AddonList_ProfileSelection);

  MCP_AddonList_OnShow()
end


function MCP_DeleteProfile(profile)
  if not MCP_Config then MCP_Config = {}; end
  if not MCP_Config.profiles then MCP_Config.profiles = {}; end
  local buttontext = MCP_PROFILE_DELETED..profile;

  if profile == "NONE" then
    buttontext = MCP_NO_PROFILE_DELETED;
  else
    MCP_Config.profiles[profile] = nil;
  end

  MCP_DeleteDialog();
end


function MCP_ResetProfiles(param)
  UIDropDownMenu_Initialize(this,  MCP_InitializeProfiles);
  UIDropDownMenu_SetWidth(220, this);

  if MCP_Config and MCP_Config.SelectedProfile then
    MCP_SelectedProfile = MCP_Config.SelectedProfile;
    UIDropDownMenu_SetText(MCP_SelectedProfile, MCP_AddonList_ProfileSelection);
  end
end

function MCP_InitializeProfiles()
  if MCP_Config and MCP_Config.profiles then
    local info = {};
    local profile;

    for profile in MCP_Config.profiles do
      info = {
        ["text"] = profile,
        ["value"] = profile,
        ["func"] = MCP_LoadProfile,
      };
      UIDropDownMenu_AddButton(info);
    end
  end
end


function MCP_EnableAll()
  local numAddons = GetNumAddOns();
  local i;

  -- set each addon to be enabled
  for i = 1, numAddons do
    local name, title, notes, enabled, loadable, reason, security = GetAddOnInfo(i);
    if not enabled then
      EnableAddOn(name);
    end
  end
  MCP_AddonList_OnShow()
end

function MCP_DisableAll()
  local numAddons = GetNumAddOns();
  local i;

  -- set each addon to be enabled
  for i = 1, numAddons do
    local name, title, notes, enabled, loadable, reason, security = GetAddOnInfo(i);
    if enabled and title ~= "Master Control Program" then
      DisableAddOn(name);
    end
  end
  MCP_AddonList_OnShow()
end


function MCP_TooltipShow(index)
  local name, title, notes, enabled, loadable, reason, security = GetAddOnInfo(index);

  color = { r = NORMAL_FONT_COLOR_r, g = NORMAL_FONT_COLOR_g, b = NORMAL_FONT_COLOR_b };
  
  GameTooltip:SetOwner(this, "ANCHOR_BOTTOMLEFT");
  if title then
    GameTooltip:AddLine(title, 1, 1, 1, 1);
  else
    GameTooltip:AddLine(name, 0.85, 0.85, 0.85, 1);
  end

  if notes then
    GameTooltip:AddLine(notes, color.r, color.g, color.b, 1);
  else
    GameTooltip:AddLine(MCP_NO_NOTES, color.r, color.g, color.b, 1);
  end

  GameTooltip:Show();
end

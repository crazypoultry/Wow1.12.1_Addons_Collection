---------------
-- Variables --
---------------
Perl_Config_Config = {};
Perl_Config_Profiles = {};
local Perl_Config_Events = {};	-- event manager

Perl_Config_Global_ArcaneBar_Config = {};
Perl_Config_Global_CombatDisplay_Config = {};
Perl_Config_Global_Config_Config = {};
Perl_Config_Global_Party_Config = {};
Perl_Config_Global_Party_Pet_Config = {};
Perl_Config_Global_Party_Target_Config = {};
Perl_Config_Global_Player_Config = {};
Perl_Config_Global_Player_Buff_Config = {};
Perl_Config_Global_Player_Pet_Config = {};
Perl_Config_Global_Raid_Config = {};
Perl_Config_Global_Target_Config = {};
Perl_Config_Global_Target_Target_Config = {};

-- Default Saved Variables (also set in Perl_Config_GetVars)
local texture = 0;			-- no texture is set by default
local showminimapbutton = 1;		-- minimap button is on by default
local minimapbuttonpos = 270;		-- default minimap button position
local transparentbackground = 0;	-- use solid black background as default
local texturedbarbackground = 0;	-- bar backgrounds are plain by default
PCUF_CASTPARTYSUPPORT = 0;		-- CastParty support is disabled by default
PCUF_COLORHEALTH = 0;			-- progressively colored health bars are off by default
PCUF_FADEBARS = 0;			-- fading status bars is off by default
PCUF_NAMEFRAMECLICKCAST = 0;		-- name frames will be the one safe spot for menus by default
PCUF_INVERTBARVALUES = 0;		-- bars deplete when low

-- Default Local Variables
local Initialized = nil;		-- waiting to be initialized
local currentprofilenumber = 0;		-- easy way to make our profile system work


----------------------
-- Loading Function --
----------------------
function Perl_Config_OnLoad()
	-- Events
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("VARIABLES_LOADED");

	-- Scripts
	this:SetScript("OnEvent", Perl_Config_OnEvent);

	-- Slash Commands
	SlashCmdList["PERL_CONFIG"] = Perl_Config_SlashHandler;
	SLASH_PERL_CONFIG1 = "/perl";
end


-------------------
-- Event Handler --
-------------------
function Perl_Config_OnEvent()
	local func = Perl_Config_Events[event];
	if (func) then
		func();
--	else
--		DEFAULT_CHAT_FRAME:AddMessage("Perl Classic - Config: Report the following event error to the author: "..event);
	end
end

function Perl_Config_Events:VARIABLES_LOADED()
	Perl_Config_Initialize();
end
Perl_Config_Events.PLAYER_ENTERING_WORLD = Perl_Config_Events.VARIABLES_LOADED;


-------------------
-- Slash Handler --
-------------------
function Perl_Config_SlashHandler(msg)
	Perl_Config_Toggle();
end


-------------------------------
-- Loading Settings Function --
-------------------------------
function Perl_Config_Initialize()
	-- Code to be run after zoning or logging in goes here
	if (Initialized) then
		Perl_Config_Set_Texture();
		Perl_Config_Button_UpdatePosition();
		Perl_Config_ShowHide_MiniMap_Button();
		Perl_Config_Set_Background();
		return;
	end

	-- Check if a previous exists, if not, enable by default.
	if (type(Perl_Config_Config[UnitName("player")]) == "table") then
		Perl_Config_GetVars();
	else
		Perl_Config_UpdateVars();
	end

	-- Profile Support
	Perl_Config_Profile_Work();

	-- MyAddOns Support
	Perl_Config_myAddOns_Support();

	-- Set the initialization flag
	Initialized = 1;

	DEFAULT_CHAT_FRAME:AddMessage("|cffffff00"..PERL_LOCALIZED_NAME..": "..PERL_LOCALIZED_VERSION.." loaded.");
end


-----------------------
-- Profile Functions --
-----------------------
function Perl_Config_Profile_Work()
	local name = UnitName("player");
	local found = 0;

	for i=1,table.getn(Perl_Config_Profiles),1 do
		if (Perl_Config_Profiles[i] == name) then
			found = 1;
			break;
		end
	end

	if (found == 0) then
		table.insert(Perl_Config_Profiles, name);
	end
end

function Perl_Config_Profile_OnShow()
	UIDropDownMenu_Initialize(Perl_Config_All_Frame_DropDown1, Perl_Config_Profile_Initialize);
	UIDropDownMenu_SetSelectedID(Perl_Config_All_Frame_DropDown1, 0);
	UIDropDownMenu_SetWidth(100, Perl_Config_All_Frame_DropDown1);
end

function Perl_Config_Profile_Initialize()
	local info;
	for i = 1, getn(Perl_Config_Profiles), 1 do
		info = {
			text = Perl_Config_Profiles[i];
			func = Perl_Config_Profile_OnClick;
		};
		UIDropDownMenu_AddButton(info);
	end
end

function Perl_Config_Profile_OnClick()
	currentprofilenumber = this:GetID();
	UIDropDownMenu_SetSelectedID(Perl_Config_All_Frame_DropDown1, this:GetID());
end

function Perl_Config_Profile_Load()
	local name = Perl_Config_Profiles[currentprofilenumber];
	if (name ~= nil) then
		Perl_Config_GetVars(name, 1);

		if (Perl_ArcaneBar_Frame_Loaded_Frame) then
			Perl_ArcaneBar_GetVars(name, 1);
		end

		if (Perl_CombatDisplay_Frame) then
			Perl_CombatDisplay_GetVars(name, 1);
		end

		if (Perl_Party_Frame) then
			Perl_Party_GetVars(name, 1);
		end

		if (Perl_Party_Pet_Script_Frame) then
			Perl_Party_Pet_GetVars(name, 1);
		end

		if (Perl_Party_Target_Script_Frame) then
			Perl_Party_Target_GetVars(name, 1);
		end

		if (Perl_Player_Frame) then
			Perl_Player_GetVars(name, 1);
		end

		if (Perl_Player_Pet_Frame) then
			Perl_Player_Pet_GetVars(name, 1);
		end

		if (Perl_Raid_Frame) then
			Perl_Raid_GetVars(name, 1);
		end

		if (Perl_Target_Frame) then
			Perl_Target_GetVars(name, 1);
		end

		if (Perl_Target_Target_Script_Frame) then
			Perl_Target_Target_GetVars(name, 1);
		end

		DEFAULT_CHAT_FRAME:AddMessage(PERL_LOCALIZED_CONFIG_ALL_LOAD_PROFILE_OUTPUT..name);
	else
		DEFAULT_CHAT_FRAME:AddMessage(PERL_LOCALIZED_CONFIG_ALL_NO_PROFILE_SELECTED_OUTPUT);
	end
end

function Perl_Config_Profile_Delete()
	local name = Perl_Config_Profiles[currentprofilenumber];
	local indexfound = nil;
	for i = 1, getn(Perl_Config_Profiles), 1 do
		if (name == Perl_Config_Profiles[i]) then
			indexfound = i;
			break;
		end
	end

	if (indexfound ~= nil) then
		DEFAULT_CHAT_FRAME:AddMessage(PERL_LOCALIZED_CONFIG_ALL_DELETE_PROFILE_OUTPUT..Perl_Config_Profiles[indexfound]);
		Perl_Config_Profiles[indexfound] = table.remove(Perl_Config_Profiles);
	end
end


--------------------------
-- Update/GUI Functions --
--------------------------
function Perl_Config_Set_Texture(newvalue)
	if (newvalue ~= nil) then
		texture = newvalue;
		Perl_Config_UpdateVars();
	end

	local texturename;
	if (texture == 0) then
		texturename = "Interface\\TargetingFrame\\UI-StatusBar";
	else
		texturename = "Interface\\AddOns\\Perl_Config\\Perl_StatusBar"..texture..".tga";
	end

	if (Perl_ArcaneBar_Frame_Loaded_Frame) then
		Perl_ArcaneBarTex:SetTexture(texturename);
	end

	if (Perl_CombatDisplay_Frame) then
		Perl_CombatDisplay_HealthBarTex:SetTexture(texturename);
		Perl_CombatDisplay_HealthBarFadeBarTex:SetTexture(texturename);
		Perl_CombatDisplay_ManaBarTex:SetTexture(texturename);
		Perl_CombatDisplay_ManaBarFadeBarTex:SetTexture(texturename);
		Perl_CombatDisplay_DruidBarTex:SetTexture(texturename);
		--Perl_CombatDisplay_DruidBarFadeBarTex:SetTexture(texturename);
		Perl_CombatDisplay_CPBarTex:SetTexture(texturename);
		Perl_CombatDisplay_CPBarFadeBarTex:SetTexture(texturename);
		Perl_CombatDisplay_PetHealthBarTex:SetTexture(texturename);
		Perl_CombatDisplay_PetHealthBarFadeBarTex:SetTexture(texturename);
		Perl_CombatDisplay_PetManaBarTex:SetTexture(texturename);
		Perl_CombatDisplay_PetManaBarFadeBarTex:SetTexture(texturename);
		Perl_CombatDisplay_Target_HealthBarTex:SetTexture(texturename);
		Perl_CombatDisplay_Target_HealthBarFadeBarTex:SetTexture(texturename);
		Perl_CombatDisplay_Target_ManaBarTex:SetTexture(texturename);
		Perl_CombatDisplay_Target_ManaBarFadeBarTex:SetTexture(texturename);
		if (texturedbarbackground == 1) then
			Perl_CombatDisplay_HealthBarBGTex:SetTexture(texturename);
			Perl_CombatDisplay_ManaBarBGTex:SetTexture(texturename);
			Perl_CombatDisplay_DruidBarBGTex:SetTexture(texturename);
			Perl_CombatDisplay_CPBarBGTex:SetTexture(texturename);
			Perl_CombatDisplay_PetHealthBarBGTex:SetTexture(texturename);
			Perl_CombatDisplay_PetManaBarBGTex:SetTexture(texturename);
			Perl_CombatDisplay_Target_HealthBarBGTex:SetTexture(texturename);
			Perl_CombatDisplay_Target_ManaBarBGTex:SetTexture(texturename);
		else
			Perl_CombatDisplay_HealthBarBGTex:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-BarFill");
			Perl_CombatDisplay_ManaBarBGTex:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-BarFill");
			Perl_CombatDisplay_DruidBarBGTex:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-BarFill");
			Perl_CombatDisplay_CPBarBGTex:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-BarFill");
			Perl_CombatDisplay_PetHealthBarBGTex:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-BarFill");
			Perl_CombatDisplay_PetManaBarBGTex:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-BarFill");
			Perl_CombatDisplay_Target_HealthBarBGTex:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-BarFill");
			Perl_CombatDisplay_Target_ManaBarBGTex:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-BarFill");
		end
	end

	if (Perl_Party_Frame) then
		for num=1,4 do
			getglobal("Perl_Party_MemberFrame"..num.."_StatsFrame_HealthBar_HealthBarTex"):SetTexture(texturename);
			getglobal("Perl_Party_MemberFrame"..num.."_StatsFrame_HealthBarFadeBar_HealthBarFadeBarTex"):SetTexture(texturename);
			getglobal("Perl_Party_MemberFrame"..num.."_StatsFrame_ManaBar_ManaBarTex"):SetTexture(texturename);
			getglobal("Perl_Party_MemberFrame"..num.."_StatsFrame_ManaBarFadeBar_ManaBarFadeBarTex"):SetTexture(texturename);
			getglobal("Perl_Party_MemberFrame"..num.."_StatsFrame_PetHealthBar_PetHealthBarTex"):SetTexture(texturename);
			getglobal("Perl_Party_MemberFrame"..num.."_StatsFrame_PetHealthBarFadeBar_PetHealthBarFadeBarTex"):SetTexture(texturename);
			if (texturedbarbackground == 1) then
				getglobal("Perl_Party_MemberFrame"..num.."_StatsFrame_HealthBarBG_HealthBarBGTex"):SetTexture(texturename);
				getglobal("Perl_Party_MemberFrame"..num.."_StatsFrame_ManaBarBG_ManaBarBGTex"):SetTexture(texturename);
				getglobal("Perl_Party_MemberFrame"..num.."_StatsFrame_PetHealthBarBG_PetHealthBarBGTex"):SetTexture(texturename);
			else
				getglobal("Perl_Party_MemberFrame"..num.."_StatsFrame_HealthBarBG_HealthBarBGTex"):SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-BarFill");
				getglobal("Perl_Party_MemberFrame"..num.."_StatsFrame_ManaBarBG_ManaBarBGTex"):SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-BarFill");
				getglobal("Perl_Party_MemberFrame"..num.."_StatsFrame_PetHealthBarBG_PetHealthBarBGTex"):SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-BarFill");
			end
		end
	end

	if (Perl_Party_Pet_Script_Frame) then
		for num=1,4 do
			getglobal("Perl_Party_Pet"..num.."_StatsFrame_HealthBar_HealthBarTex"):SetTexture(texturename);
			getglobal("Perl_Party_Pet"..num.."_StatsFrame_HealthBarFadeBar_HealthBarFadeBarTex"):SetTexture(texturename);
			getglobal("Perl_Party_Pet"..num.."_StatsFrame_ManaBar_ManaBarTex"):SetTexture(texturename);
			getglobal("Perl_Party_Pet"..num.."_StatsFrame_ManaBarFadeBar_ManaBarFadeBarTex"):SetTexture(texturename);
			if (texturedbarbackground == 1) then
				getglobal("Perl_Party_Pet"..num.."_StatsFrame_HealthBarBG_HealthBarBGTex"):SetTexture(texturename);
				getglobal("Perl_Party_Pet"..num.."_StatsFrame_ManaBarBG_ManaBarBGTex"):SetTexture(texturename);
			else
				getglobal("Perl_Party_Pet"..num.."_StatsFrame_HealthBarBG_HealthBarBGTex"):SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-BarFill");
				getglobal("Perl_Party_Pet"..num.."_StatsFrame_ManaBarBG_ManaBarBGTex"):SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-BarFill");
			end
		end
	end

	if (Perl_Party_Target_Script_Frame) then
		for num=1,4 do
			getglobal("Perl_Party_Target"..num.."_StatsFrame_HealthBar_HealthBarTex"):SetTexture(texturename);
			getglobal("Perl_Party_Target"..num.."_StatsFrame_HealthBarFadeBar_HealthBarFadeBarTex"):SetTexture(texturename);
			getglobal("Perl_Party_Target"..num.."_StatsFrame_ManaBar_ManaBarTex"):SetTexture(texturename);
			getglobal("Perl_Party_Target"..num.."_StatsFrame_ManaBarFadeBar_ManaBarFadeBarTex"):SetTexture(texturename);
			if (texturedbarbackground == 1) then
				getglobal("Perl_Party_Target"..num.."_StatsFrame_HealthBarBG_HealthBarBGTex"):SetTexture(texturename);
				getglobal("Perl_Party_Target"..num.."_StatsFrame_ManaBarBG_ManaBarBGTex"):SetTexture(texturename);
			else
				getglobal("Perl_Party_Target"..num.."_StatsFrame_HealthBarBG_HealthBarBGTex"):SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-BarFill");
				getglobal("Perl_Party_Target"..num.."_StatsFrame_ManaBarBG_ManaBarBGTex"):SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-BarFill");
			end
		end
	end

	if (Perl_Player_Frame) then
		Perl_Player_HealthBarTex:SetTexture(texturename);
		Perl_Player_HealthBarFadeBarTex:SetTexture(texturename);
		Perl_Player_ManaBarTex:SetTexture(texturename);
		Perl_Player_ManaBarFadeBarTex:SetTexture(texturename);
		Perl_Player_DruidBarTex:SetTexture(texturename);
		--Perl_Player_DruidBarFadeBarTex:SetTexture(texturename);
		Perl_Player_XPBarTex:SetTexture(texturename);
		if (texturedbarbackground == 1) then
			Perl_Player_HealthBarBGTex:SetTexture(texturename);
			Perl_Player_ManaBarBGTex:SetTexture(texturename);
			Perl_Player_DruidBarBGTex:SetTexture(texturename);
			Perl_Player_XPBarBGTex:SetTexture(texturename);
		else
			Perl_Player_HealthBarBGTex:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-BarFill");
			Perl_Player_ManaBarBGTex:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-BarFill");
			Perl_Player_DruidBarBGTex:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-BarFill");
			Perl_Player_XPBarBGTex:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-BarFill");
		end
	end

	if (Perl_Player_Pet_Frame) then
		Perl_Player_Pet_HealthBarTex:SetTexture(texturename);
		Perl_Player_Pet_HealthBarFadeBarTex:SetTexture(texturename);
		Perl_Player_Pet_ManaBarTex:SetTexture(texturename);
		Perl_Player_Pet_ManaBarFadeBarTex:SetTexture(texturename);
		Perl_Player_Pet_XPBarTex:SetTexture(texturename);
		if (texturedbarbackground == 1) then
			Perl_Player_Pet_HealthBarBGTex:SetTexture(texturename);
			Perl_Player_Pet_ManaBarBGTex:SetTexture(texturename);
			Perl_Player_Pet_XPBarBGTex:SetTexture(texturename);
		else
			Perl_Player_Pet_HealthBarBGTex:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-BarFill");
			Perl_Player_Pet_ManaBarBGTex:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-BarFill");
			Perl_Player_Pet_XPBarBGTex:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-BarFill");
		end
	end

	if (Perl_Raid_Frame) then
		for num=1,40 do
			getglobal("Perl_Raid"..num.."_StatsFrame_HealthBar_HealthBarTex"):SetTexture(texturename);
			getglobal("Perl_Raid"..num.."_StatsFrame_ManaBar_ManaBarTex"):SetTexture(texturename);
			if (texturedbarbackground == 1) then
				getglobal("Perl_Raid"..num.."_StatsFrame_HealthBarBG_HealthBarBGTex"):SetTexture(texturename);
				getglobal("Perl_Raid"..num.."_StatsFrame_ManaBarBG_ManaBarBGTex"):SetTexture(texturename);
			else
				getglobal("Perl_Raid"..num.."_StatsFrame_HealthBarBG_HealthBarBGTex"):SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-BarFill");
				getglobal("Perl_Raid"..num.."_StatsFrame_ManaBarBG_ManaBarBGTex"):SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-BarFill");
			end
		end
	end

	if (Perl_Target_Frame) then
		Perl_Target_HealthBarTex:SetTexture(texturename);
		Perl_Target_HealthBarFadeBarTex:SetTexture(texturename);
		Perl_Target_ManaBarTex:SetTexture(texturename);
		Perl_Target_ManaBarFadeBarTex:SetTexture(texturename);
		Perl_Target_NameFrame_CPMeterTex:SetTexture(texturename);
		if (texturedbarbackground == 1) then
			Perl_Target_HealthBarBGTex:SetTexture(texturename);
			Perl_Target_ManaBarBGTex:SetTexture(texturename);
		else
			Perl_Target_HealthBarBGTex:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-BarFill");
			Perl_Target_ManaBarBGTex:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-BarFill");
		end
	end

	if (Perl_Target_Target_Script_Frame) then
		Perl_Target_Target_HealthBarTex:SetTexture(texturename);
		Perl_Target_Target_HealthBarFadeBarTex:SetTexture(texturename);
		Perl_Target_Target_ManaBarTex:SetTexture(texturename);
		Perl_Target_Target_ManaBarFadeBarTex:SetTexture(texturename);
		Perl_Target_Target_Target_HealthBarTex:SetTexture(texturename);
		Perl_Target_Target_Target_HealthBarFadeBarTex:SetTexture(texturename);
		Perl_Target_Target_Target_ManaBarTex:SetTexture(texturename);
		Perl_Target_Target_Target_ManaBarFadeBarTex:SetTexture(texturename);
		if (texturedbarbackground == 1) then
			Perl_Target_Target_HealthBarBGTex:SetTexture(texturename);
			Perl_Target_Target_ManaBarBGTex:SetTexture(texturename);
			Perl_Target_Target_Target_HealthBarBGTex:SetTexture(texturename);
			Perl_Target_Target_Target_ManaBarBGTex:SetTexture(texturename);
		else
			Perl_Target_Target_HealthBarBGTex:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-BarFill");
			Perl_Target_Target_ManaBarBGTex:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-BarFill");
			Perl_Target_Target_Target_HealthBarBGTex:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-BarFill");
			Perl_Target_Target_Target_ManaBarBGTex:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-BarFill");
		end
	end
end

function Perl_Config_Set_Background(newvalue)
	if (newvalue ~= nil) then
		transparentbackground = newvalue;
		Perl_Config_UpdateVars();
	end

	if (transparentbackground == 1) then
		if (Perl_CombatDisplay_Frame) then
			Perl_CombatDisplay_ManaFrame:SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, insets = { left = 5, right = 5, top = 5, bottom = 5 }});
			Perl_CombatDisplay_Target_ManaFrame:SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, insets = { left = 5, right = 5, top = 5, bottom = 5 }});
			Perl_CombatDisplay_Initialize_Frame_Color();
		end

		if (Perl_Party_Frame) then
			for partynum=1,4 do
				getglobal("Perl_Party_MemberFrame"..partynum.."_NameFrame"):SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, insets = { left = 5, right = 5, top = 5, bottom = 5 }});
				getglobal("Perl_Party_MemberFrame"..partynum.."_LevelFrame"):SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, insets = { left = 5, right = 5, top = 5, bottom = 5 }});
				getglobal("Perl_Party_MemberFrame"..partynum.."_PortraitFrame"):SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, insets = { left = 5, right = 5, top = 5, bottom = 5 }});
				getglobal("Perl_Party_MemberFrame"..partynum.."_StatsFrame"):SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, insets = { left = 5, right = 5, top = 5, bottom = 5 }});
			end
			Perl_Party_Initialize_Frame_Color(1);
		end

		if (Perl_Party_Pet_Script_Frame) then
			for partynum=1,4 do
				getglobal("Perl_Party_Pet"..partynum.."_NameFrame"):SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, insets = { left = 5, right = 5, top = 5, bottom = 5 }});
				getglobal("Perl_Party_Pet"..partynum.."_PortraitFrame"):SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, insets = { left = 5, right = 5, top = 5, bottom = 5 }});
				getglobal("Perl_Party_Pet"..partynum.."_StatsFrame"):SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, insets = { left = 5, right = 5, top = 5, bottom = 5 }});
			end
			Perl_Party_Pet_Initialize_Frame_Color();
		end

		if (Perl_Party_Target_Script_Frame) then
			for partynum=1,4 do
				getglobal("Perl_Party_Target"..partynum.."_NameFrame"):SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, insets = { left = 5, right = 5, top = 5, bottom = 5 }});
				getglobal("Perl_Party_Target"..partynum.."_StatsFrame"):SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, insets = { left = 5, right = 5, top = 5, bottom = 5 }});
			end
			Perl_Party_Target_Initialize_Frame_Color();
		end

		if (Perl_Player_Frame) then
			Perl_Player_NameFrame:SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, insets = { left = 5, right = 5, top = 5, bottom = 5 }});
			Perl_Player_LevelFrame:SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, insets = { left = 5, right = 5, top = 5, bottom = 5 }});
			Perl_Player_PortraitFrame:SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, insets = { left = 5, right = 5, top = 5, bottom = 5 }});
			Perl_Player_RaidGroupNumberFrame:SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, insets = { left = 5, right = 5, top = 5, bottom = 5 }});
			Perl_Player_StatsFrame:SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, insets = { left = 5, right = 5, top = 5, bottom = 5 }});
			Perl_Player_Initialize_Frame_Color();
		end

		if (Perl_Player_Pet_Frame) then
			Perl_Player_Pet_LevelFrame:SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, insets = { left = 5, right = 5, top = 5, bottom = 5 }});
			Perl_Player_Pet_NameFrame:SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, insets = { left = 5, right = 5, top = 5, bottom = 5 }});
			Perl_Player_Pet_PortraitFrame:SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, insets = { left = 5, right = 5, top = 5, bottom = 5 }});
			Perl_Player_Pet_StatsFrame:SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, insets = { left = 5, right = 5, top = 5, bottom = 5 }});
			Perl_Player_Pet_Initialize_Frame_Color();
		end

		if (Perl_Raid_Frame) then
			for num=1,40 do
				getglobal("Perl_Raid"..num.."_NameFrame"):SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, insets = { left = 5, right = 5, top = 5, bottom = 5 }});
				getglobal("Perl_Raid"..num.."_StatsFrame"):SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, insets = { left = 5, right = 5, top = 5, bottom = 5 }});
			end
			Perl_Raid_Initialize_Frame_Color();
		end

		if (Perl_Target_Frame) then
			Perl_Target_CivilianFrame:SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, insets = { left = 5, right = 5, top = 5, bottom = 5 }});
			Perl_Target_ClassNameFrame:SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, insets = { left = 5, right = 5, top = 5, bottom = 5 }});
			Perl_Target_CPFrame:SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, insets = { left = 5, right = 5, top = 5, bottom = 5 }});
			Perl_Target_LevelFrame:SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, insets = { left = 5, right = 5, top = 5, bottom = 5 }});
			Perl_Target_NameFrame:SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, insets = { left = 5, right = 5, top = 5, bottom = 5 }});
			Perl_Target_PortraitFrame:SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, insets = { left = 5, right = 5, top = 5, bottom = 5 }});
			Perl_Target_RareEliteFrame:SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, insets = { left = 5, right = 5, top = 5, bottom = 5 }});
			Perl_Target_StatsFrame:SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, insets = { left = 5, right = 5, top = 5, bottom = 5 }});
			Perl_Target_Initialize_Frame_Color();
		end

		if (Perl_Target_Target_Script_Frame) then
			Perl_Target_Target_NameFrame:SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, insets = { left = 5, right = 5, top = 5, bottom = 5 }});
			Perl_Target_Target_StatsFrame:SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, insets = { left = 5, right = 5, top = 5, bottom = 5 }});
			Perl_Target_Target_Target_NameFrame:SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, insets = { left = 5, right = 5, top = 5, bottom = 5 }});
			Perl_Target_Target_Target_StatsFrame:SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, insets = { left = 5, right = 5, top = 5, bottom = 5 }});
			Perl_Target_Target_Initialize_Frame_Color();
		end
	else
		if (Perl_CombatDisplay_Frame) then
			Perl_CombatDisplay_ManaFrame:SetBackdrop({bgFile = "Interface\\AddOns\\Perl_Config\\Perl_Black", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, insets = { left = 5, right = 5, top = 5, bottom = 5 }});
			Perl_CombatDisplay_Target_ManaFrame:SetBackdrop({bgFile = "Interface\\AddOns\\Perl_Config\\Perl_Black", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, insets = { left = 5, right = 5, top = 5, bottom = 5 }});
			Perl_CombatDisplay_Initialize_Frame_Color();
		end

		if (Perl_Party_Frame) then
			for partynum=1,4 do
				getglobal("Perl_Party_MemberFrame"..partynum.."_NameFrame"):SetBackdrop({bgFile = "Interface\\AddOns\\Perl_Config\\Perl_Black", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, insets = { left = 5, right = 5, top = 5, bottom = 5 }});
				getglobal("Perl_Party_MemberFrame"..partynum.."_LevelFrame"):SetBackdrop({bgFile = "Interface\\AddOns\\Perl_Config\\Perl_Black", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, insets = { left = 5, right = 5, top = 5, bottom = 5 }});
				getglobal("Perl_Party_MemberFrame"..partynum.."_PortraitFrame"):SetBackdrop({bgFile = "Interface\\AddOns\\Perl_Config\\Perl_Black", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, insets = { left = 5, right = 5, top = 5, bottom = 5 }});
				getglobal("Perl_Party_MemberFrame"..partynum.."_StatsFrame"):SetBackdrop({bgFile = "Interface\\AddOns\\Perl_Config\\Perl_Black", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, insets = { left = 5, right = 5, top = 5, bottom = 5 }});
			end
			Perl_Party_Initialize_Frame_Color(1);
		end

		if (Perl_Party_Pet_Script_Frame) then
			for partynum=1,4 do
				getglobal("Perl_Party_Pet"..partynum.."_NameFrame"):SetBackdrop({bgFile = "Interface\\AddOns\\Perl_Config\\Perl_Black", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, insets = { left = 5, right = 5, top = 5, bottom = 5 }});
				getglobal("Perl_Party_Pet"..partynum.."_PortraitFrame"):SetBackdrop({bgFile = "Interface\\AddOns\\Perl_Config\\Perl_Black", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, insets = { left = 5, right = 5, top = 5, bottom = 5 }});
				getglobal("Perl_Party_Pet"..partynum.."_StatsFrame"):SetBackdrop({bgFile = "Interface\\AddOns\\Perl_Config\\Perl_Black", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, insets = { left = 5, right = 5, top = 5, bottom = 5 }});
			end
			Perl_Party_Pet_Initialize_Frame_Color();
		end

		if (Perl_Party_Target_Script_Frame) then
			for partynum=1,4 do
				getglobal("Perl_Party_Target"..partynum.."_NameFrame"):SetBackdrop({bgFile = "Interface\\AddOns\\Perl_Config\\Perl_Black", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, insets = { left = 5, right = 5, top = 5, bottom = 5 }});
				getglobal("Perl_Party_Target"..partynum.."_StatsFrame"):SetBackdrop({bgFile = "Interface\\AddOns\\Perl_Config\\Perl_Black", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, insets = { left = 5, right = 5, top = 5, bottom = 5 }});
			end
			Perl_Party_Target_Initialize_Frame_Color();
		end

		if (Perl_Player_Frame) then
			Perl_Player_NameFrame:SetBackdrop({bgFile = "Interface\\AddOns\\Perl_Config\\Perl_Black", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, insets = { left = 5, right = 5, top = 5, bottom = 5 }});
			Perl_Player_LevelFrame:SetBackdrop({bgFile = "Interface\\AddOns\\Perl_Config\\Perl_Black", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, insets = { left = 5, right = 5, top = 5, bottom = 5 }});
			Perl_Player_PortraitFrame:SetBackdrop({bgFile = "Interface\\AddOns\\Perl_Config\\Perl_Black", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, insets = { left = 5, right = 5, top = 5, bottom = 5 }});
			Perl_Player_RaidGroupNumberFrame:SetBackdrop({bgFile = "Interface\\AddOns\\Perl_Config\\Perl_Black", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, insets = { left = 5, right = 5, top = 5, bottom = 5 }});
			Perl_Player_StatsFrame:SetBackdrop({bgFile = "Interface\\AddOns\\Perl_Config\\Perl_Black", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, insets = { left = 5, right = 5, top = 5, bottom = 5 }});
			Perl_Player_Initialize_Frame_Color();
		end

		if (Perl_Player_Pet_Frame) then
			Perl_Player_Pet_LevelFrame:SetBackdrop({bgFile = "Interface\\AddOns\\Perl_Config\\Perl_Black", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, insets = { left = 5, right = 5, top = 5, bottom = 5 }});
			Perl_Player_Pet_NameFrame:SetBackdrop({bgFile = "Interface\\AddOns\\Perl_Config\\Perl_Black", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, insets = { left = 5, right = 5, top = 5, bottom = 5 }});
			Perl_Player_Pet_PortraitFrame:SetBackdrop({bgFile = "Interface\\AddOns\\Perl_Config\\Perl_Black", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, insets = { left = 5, right = 5, top = 5, bottom = 5 }});
			Perl_Player_Pet_StatsFrame:SetBackdrop({bgFile = "Interface\\AddOns\\Perl_Config\\Perl_Black", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, insets = { left = 5, right = 5, top = 5, bottom = 5 }});
			Perl_Player_Pet_Initialize_Frame_Color();
		end

		if (Perl_Raid_Frame) then
			for num=1,40 do
				getglobal("Perl_Raid"..num.."_NameFrame"):SetBackdrop({bgFile = "Interface\\AddOns\\Perl_Config\\Perl_Black", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, insets = { left = 5, right = 5, top = 5, bottom = 5 }});
				getglobal("Perl_Raid"..num.."_StatsFrame"):SetBackdrop({bgFile = "Interface\\AddOns\\Perl_Config\\Perl_Black", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, insets = { left = 5, right = 5, top = 5, bottom = 5 }});
			end
			Perl_Raid_Initialize_Frame_Color();
		end

		if (Perl_Target_Frame) then
			Perl_Target_CivilianFrame:SetBackdrop({bgFile = "Interface\\AddOns\\Perl_Config\\Perl_White", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, insets = { left = 5, right = 5, top = 5, bottom = 5 }});
			Perl_Target_ClassNameFrame:SetBackdrop({bgFile = "Interface\\AddOns\\Perl_Config\\Perl_Black", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, insets = { left = 5, right = 5, top = 5, bottom = 5 }});
			Perl_Target_CPFrame:SetBackdrop({bgFile = "Interface\\AddOns\\Perl_Config\\Perl_Black", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, insets = { left = 5, right = 5, top = 5, bottom = 5 }});
			Perl_Target_LevelFrame:SetBackdrop({bgFile = "Interface\\AddOns\\Perl_Config\\Perl_Black", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, insets = { left = 5, right = 5, top = 5, bottom = 5 }});
			Perl_Target_NameFrame:SetBackdrop({bgFile = "Interface\\AddOns\\Perl_Config\\Perl_Black", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, insets = { left = 5, right = 5, top = 5, bottom = 5 }});
			Perl_Target_PortraitFrame:SetBackdrop({bgFile = "Interface\\AddOns\\Perl_Config\\Perl_Black", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, insets = { left = 5, right = 5, top = 5, bottom = 5 }});
			Perl_Target_RareEliteFrame:SetBackdrop({bgFile = "Interface\\AddOns\\Perl_Config\\Perl_Black", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, insets = { left = 5, right = 5, top = 5, bottom = 5 }});
			Perl_Target_StatsFrame:SetBackdrop({bgFile = "Interface\\AddOns\\Perl_Config\\Perl_Black", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, insets = { left = 5, right = 5, top = 5, bottom = 5 }});
			Perl_Target_Initialize_Frame_Color();
		end

		if (Perl_Target_Target_Script_Frame) then
			Perl_Target_Target_NameFrame:SetBackdrop({bgFile = "Interface\\AddOns\\Perl_Config\\Perl_Black", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, insets = { left = 5, right = 5, top = 5, bottom = 5 }});
			Perl_Target_Target_StatsFrame:SetBackdrop({bgFile = "Interface\\AddOns\\Perl_Config\\Perl_Black", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, insets = { left = 5, right = 5, top = 5, bottom = 5 }});
			Perl_Target_Target_Target_NameFrame:SetBackdrop({bgFile = "Interface\\AddOns\\Perl_Config\\Perl_Black", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, insets = { left = 5, right = 5, top = 5, bottom = 5 }});
			Perl_Target_Target_Target_StatsFrame:SetBackdrop({bgFile = "Interface\\AddOns\\Perl_Config\\Perl_Black", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, insets = { left = 5, right = 5, top = 5, bottom = 5 }});
			Perl_Target_Target_Initialize_Frame_Color();
		end
	end
end

function Perl_Config_Set_Transparency(newvalue)
	if (Perl_ArcaneBar_Frame_Loaded_Frame) then
		Perl_ArcaneBar_Set_Transparency(newvalue);
	end

	if (Perl_CombatDisplay_Frame) then
		Perl_CombatDisplay_Set_Transparency(newvalue);
	end

	if (Perl_Party_Frame) then
		Perl_Party_Set_Transparency(newvalue);
	end

	if (Perl_Party_Pet_Script_Frame) then
		Perl_Party_Pet_Set_Transparency(newvalue);
	end

	if (Perl_Party_Target_Script_Frame) then
		Perl_Party_Target_Set_Transparency(newvalue);
	end

	if (Perl_Player_Frame) then
		Perl_Player_Set_Transparency(newvalue);
	end

	if (Perl_Player_Pet_Frame) then
		Perl_Player_Pet_Set_Transparency(newvalue);
	end

	if (Perl_Raid_Frame) then
		Perl_Raid_Set_Transparency(newvalue);
	end

	if (Perl_Target_Frame) then
		Perl_Target_Set_Transparency(newvalue);
	end

	if (Perl_Target_Target_Script_Frame) then
		Perl_Target_Target_Set_Transparency(newvalue);
	end
end

function Perl_Config_Set_MiniMap_Button(newvalue)
	showminimapbutton = newvalue;
	Perl_Config_UpdateVars();
	Perl_Config_ShowHide_MiniMap_Button();
end

function Perl_Config_Set_MiniMap_Position(newvalue)
	minimapbuttonpos = newvalue;
	Perl_Config_UpdateVars();
	Perl_Config_Button_UpdatePosition();
end

function Perl_Config_Set_CastParty_Support(newvalue)
	PCUF_CASTPARTYSUPPORT = newvalue;
	Perl_Config_UpdateVars();
end

function Perl_Config_Set_Color_Health(newvalue)
	PCUF_COLORHEALTH = newvalue;
	Perl_Config_UpdateVars();
end

function Perl_Config_Set_Textured_Bar_Background(newvalue)
	texturedbarbackground = newvalue;
	Perl_Config_UpdateVars();
	Perl_Config_Set_Texture();
end

function Perl_Config_Set_Fade_Bars(newvalue)
	PCUF_FADEBARS = newvalue;
	Perl_Config_UpdateVars();
end

function Perl_Config_Set_Name_Frame_Click_Cast(newvalue)
	PCUF_NAMEFRAMECLICKCAST = newvalue;
	Perl_Config_UpdateVars();
end

function Perl_Config_Set_Invert_Bar_Values(newvalue)
	PCUF_INVERTBARVALUES = newvalue;
	Perl_Config_UpdateVars();

	if (Perl_CombatDisplay_Frame) then
		Perl_CombatDisplay_Update_Health();
		Perl_CombatDisplay_Update_Mana();
		Perl_CombatDisplay_Update_Combo_Points();
		if (UnitExists("pet")) then
			Perl_CombatDisplay_Update_PetHealth();
			Perl_CombatDisplay_Update_PetMana();
		end
		if (UnitExists("target")) then
			Perl_CombatDisplay_Target_Update_Health();
			Perl_CombatDisplay_Target_Update_Mana();
		end
	end

	if (Perl_Party_Frame) then
		Perl_Party_Update_Health_Mana();
	end

	if (Perl_Party_Pet_Script_Frame) then
		Perl_Party_Pet_Update();
	end

	if (Perl_Player_Frame) then
		Perl_Player_Update_Health();
		Perl_Player_Update_Mana();
	end

	if (Perl_Player_Pet_Frame) then
		if (UnitExists("pet")) then
			Perl_Player_Pet_Update_Health();
			Perl_Player_Pet_Update_Mana();
		end
	end

	if (Perl_Target_Frame) then
		Perl_Target_Update_Once();
	end
end

function Perl_Config_Lock_Unlock(value)
	if (Perl_CombatDisplay_Frame) then
		Perl_CombatDisplay_Set_Lock(value);
	end

	if (Perl_Party_Frame) then
		Perl_Party_Set_Lock(value);
	end

	if (Perl_Party_Pet_Script_Frame) then
		Perl_Party_Pet_Set_Lock(value);
	end

	if (Perl_Party_Target_Script_Frame) then
		Perl_Party_Target_Set_Lock(value);
	end

	if (Perl_Player_Frame) then
		Perl_Player_Set_Lock(value);
	end

	if (Perl_Player_Pet_Frame) then
		Perl_Player_Pet_Set_Lock(value);
	end

	if (Perl_Raid_Frame) then
		Perl_Raid_Set_Lock(value);
	end

	if (Perl_Target_Frame) then
		Perl_Target_Set_Lock(value);
	end

	if (Perl_Target_Target_Script_Frame) then
		Perl_Target_Target_Set_Lock(value);
	end
end


-----------------------------------
-- Reset Frame Position Function --
-----------------------------------
function Perl_Config_Frame_Reset_Positions()
	if (Perl_CombatDisplay_Frame) then
		Perl_CombatDisplay_Frame:SetUserPlaced(1);		-- All the SetUserPlaced allows us to save the new location set by these functions even if the user has not moved the frames on their own yet.
		Perl_CombatDisplay_Target_Frame:SetUserPlaced(1);
		Perl_CombatDisplay_Frame:ClearAllPoints();
		Perl_CombatDisplay_Target_Frame:ClearAllPoints();
		Perl_CombatDisplay_Frame:SetPoint("BOTTOM", 0, 300);
		Perl_CombatDisplay_Target_Frame:SetPoint("BOTTOMLEFT", Perl_CombatDisplay_Frame, "TOPLEFT", 0, 5);
	end

	if (Perl_Party_Frame) then
		Perl_Party_Frame:SetUserPlaced(1);
		Perl_Party_Frame:SetPoint("TOPLEFT", UIParent, "TOPLEFT", -8, -187);
	end

	if (Perl_Party_Pet_Script_Frame) then
		Perl_Party_Pet_Allign();
	end

	if (Perl_Party_Target_Script_Frame) then
		Perl_Party_Target_Allign();
	end

	if (Perl_Player_Frame) then
		Perl_Player_Frame:SetUserPlaced(1);
		Perl_Player_Frame:SetPoint("TOPLEFT", UIParent, "TOPLEFT", -3, -43);
	end

	if (Perl_Player_Pet_Frame) then
		Perl_Player_Pet_Frame:SetUserPlaced(1);
		Perl_Player_Pet_Frame:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 27, -112);
	end

	if (Perl_Raid_Frame) then
		for num=1,9 do
			getglobal("Perl_Raid_Grp"..num):SetUserPlaced(1);
		end
		getglobal("Perl_Raid_Grp1"):SetPoint("TOPLEFT", UIParent, "TOPLEFT", 300, -150);
		getglobal("Perl_Raid_Grp2"):SetPoint("TOPLEFT", UIParent, "TOPLEFT", 400, -150);
		getglobal("Perl_Raid_Grp3"):SetPoint("TOPLEFT", UIParent, "TOPLEFT", 500, -150);
		getglobal("Perl_Raid_Grp4"):SetPoint("TOPLEFT", UIParent, "TOPLEFT", 600, -150);
		getglobal("Perl_Raid_Grp5"):SetPoint("TOPLEFT", UIParent, "TOPLEFT", 300, -250);
		getglobal("Perl_Raid_Grp6"):SetPoint("TOPLEFT", UIParent, "TOPLEFT", 400, -250);
		getglobal("Perl_Raid_Grp7"):SetPoint("TOPLEFT", UIParent, "TOPLEFT", 500, -250);
		getglobal("Perl_Raid_Grp8"):SetPoint("TOPLEFT", UIParent, "TOPLEFT", 600, -250);
		getglobal("Perl_Raid_Grp9"):SetPoint("TOPLEFT", UIParent, "TOPLEFT", 300, -350);
	end

	if (Perl_Target_Frame) then
		Perl_Target_Frame:SetUserPlaced(1);
		Perl_Target_Frame:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 263, -43);
	end

	if (Perl_Target_Target_Script_Frame) then
		Perl_Target_Target_Frame:SetUserPlaced(1);
		Perl_Target_Target_Target_Frame:SetUserPlaced(1);
		Perl_Target_Target_Frame:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 501, -43);
		Perl_Target_Target_Target_Frame:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 607, -43);
	end
end


-------------------------------------
-- Global Saved Variable Functions --
-------------------------------------
function Perl_Config_Global_Save_Settings()
	if (Perl_ArcaneBar_Frame_Loaded_Frame) then
		local vartable = Perl_ArcaneBar_GetVars();
		Perl_Config_Global_ArcaneBar_Config["Global Settings"] = {
			["Enabled"] = vartable["enabled"],
			["HideOriginal"] = vartable["hideoriginal"],
			["ShowTimer"] = vartable["showtimer"],
			["Transparency"] = vartable["transparency"],
			["NameReplace"] = vartable["namereplace"],
			["LeftTimer"] = vartable["lefttimer"],
		};
	end

	if (Perl_CombatDisplay_Frame) then
		local vartable = Perl_CombatDisplay_GetVars();
		Perl_Config_Global_CombatDisplay_Config["Global Settings"] = {
			["State"] = vartable["state"],
			["Locked"] = vartable["locked"],
			["HealthPersist"] = vartable["healthpersist"],
			["ManaPersist"] = vartable["manapersist"],
			["Scale"] = vartable["scale"],
			["Transparency"] = vartable["transparency"],
			["ShowTarget"] = vartable["showtarget"],
			["MobHealthSupport"] = vartable["mobhealthsupport"],
			["XPositionCD"] = floor(Perl_CombatDisplay_Frame:GetLeft() + 0.5),
			["YPositionCD"] = floor(Perl_CombatDisplay_Frame:GetTop() - (UIParent:GetTop() / Perl_CombatDisplay_Frame:GetScale()) + 0.5),
			["XPositionCDT"] = floor(Perl_CombatDisplay_Target_Frame:GetLeft() + 0.5),
			["YPositionCDT"] = floor(Perl_CombatDisplay_Target_Frame:GetTop() - (UIParent:GetTop() / Perl_CombatDisplay_Target_Frame:GetScale()) + 0.5),
			["ShowDruidBar"] = vartable["showdruidbar"],
			["ShowPetBars"] = vartable["showpetbars"],
			["RightClickMenu"] = vartable["rightclickmenu"],
			["FiveSecSupport"] = vartable["fivesecsupport"],
			["DisplayPercents"] = vartable["displaypercents"],
		};
	end

	if (Perl_Config_Script_Frame) then
		local vartable = Perl_Config_GetVars();
		Perl_Config_Global_Config_Config["Global Settings"] = {
			["Texture"] = vartable["texture"],
			["ShowMiniMapButton"] = vartable["showminimapbutton"],
			["MiniMapButtonPos"] = vartable["minimapbuttonpos"],
			["TransparentBackground"] = vartable["transparentbackground"],
			["PCUF_CastPartySupport"] = vartable["PCUF_CastPartySupport"],
			["PCUF_ColorHealth"] = vartable["PCUF_ColorHealth"],
			["TexturedBarBackround"] = vartable["texturedbarbackground"],
			["PCUF_FadeBars"] = vartable["PCUF_FadeBars"],
			["PCUF_InvertBarValues"] = vartable["PCUF_InvertBarValues"],
		};
	end

	if (Perl_Party_Frame) then
		local vartable = Perl_Party_GetVars();
		Perl_Config_Global_Party_Config["Global Settings"] = {
			["Locked"] = vartable["locked"],
			["CompactMode"] = vartable["compactmode"],
			["PartyHidden"] = vartable["partyhidden"],
			["PartySpacing"] = vartable["partyspacing"],
			["Scale"] = vartable["scale"],
			["ShowPets"] = vartable["showpets"],
			["HealerMode"] = vartable["healermode"],
			["Transparency"] = vartable["transparency"],
			["BuffLocation"] = vartable["bufflocation"],
			["DebuffLocation"] = vartable["debufflocation"],
			["VerticalAlign"] = vartable["verticalalign"],
			["XPosition"] = floor(Perl_Party_Frame:GetLeft() + 0.5),
			["YPosition"] = floor(Perl_Party_Frame:GetTop() - (UIParent:GetTop() / Perl_Party_Frame:GetScale()) + 0.5),
			["CompactPercent"] = vartable["compactpercent"],
			["ShowPortrait"] = vartable["showportrait"],
			["ShowFKeys"] = vartable["showfkeys"],
			["DisplayCastableBuffs"] = vartable["displaycastablebuffs"],
			["ThreeDPortrait"] = vartable["threedportrait"],
			["BuffSize"] = vartable["buffsize"],
			["DebuffSize"] = vartable["debuffsize"],
			["Buffs"] = vartable["numbuffsshown"],
			["Debuffs"] = vartable["numdebuffsshown"],
			["ClassColoredNames"] = vartable["classcolorednames"],
			["ShortBars"] = vartable["shortbars"],
			["HideClassLevelFrame"] = vartable["hideclasslevelframe"],
			["ShowManaDeficit"] = vartable["showmanadeficit"],
			["ShowPvPIcon"] = vartable["showpvpicon"],
			["ShowBarValues"] = vartable["showbarvalues"],
		};
	end

	if (Perl_Party_Pet_Script_Frame) then
		local vartable = Perl_Party_Pet_GetVars();
		Perl_Config_Global_Party_Pet_Config["Global Settings"] = {
			["Locked"] = vartable["locked"],
			["ShowPortrait"] = vartable["showportrait"],
			["ThreeDPortrait"] = vartable["threedportrait"],
			["Scale"] = vartable["scale"],
			["Transparency"] = vartable["transparency"],
			["Buffs"] = vartable["numpetbuffsshown"],
			["Debuffs"] = vartable["numpetdebuffsshown"],
			["BuffSize"] = vartable["buffsize"],
			["DebuffSize"] = vartable["debuffsize"],
			["BuffLocation"] = vartable["bufflocation"],
			["DebuffLocation"] = vartable["debufflocation"],
			["HiddenInRaids"] = vartable["hiddeninraids"],
			["XPosition1"] = floor(Perl_Party_Pet1:GetLeft() + 0.5),
			["YPosition1"] = floor(Perl_Party_Pet1:GetTop() - (UIParent:GetTop() / Perl_Party_Pet1:GetScale()) + 0.5),
			["XPosition2"] = floor(Perl_Party_Pet2:GetLeft() + 0.5),
			["YPosition2"] = floor(Perl_Party_Pet2:GetTop() - (UIParent:GetTop() / Perl_Party_Pet2:GetScale()) + 0.5),
			["XPosition3"] = floor(Perl_Party_Pet3:GetLeft() + 0.5),
			["YPosition3"] = floor(Perl_Party_Pet3:GetTop() - (UIParent:GetTop() / Perl_Party_Pet3:GetScale()) + 0.5),
			["XPosition4"] = floor(Perl_Party_Pet4:GetLeft() + 0.5),
			["YPosition4"] = floor(Perl_Party_Pet4:GetTop() - (UIParent:GetTop() / Perl_Party_Pet4:GetScale()) + 0.5),
			["Enabled"] = vartable["enabled"],
		};
	end

	if (Perl_Party_Target_Script_Frame) then
		local vartable = Perl_Party_Target_GetVars();
		Perl_Config_Global_Party_Target_Config["Global Settings"] = {
			["Locked"] = vartable["locked"],
			["Scale"] = vartable["scale"],
			["Transparency"] = vartable["transparency"],
			["MobHealthSupport"] = vartable["mobhealthsupport"],
			["HidePowerBars"] = vartable["hidepowerbars"],
			["ClassColoredNames"] = vartable["classcolorednames"],
			["XPosition1"] = floor(Perl_Party_Target1:GetLeft() + 0.5),
			["YPosition1"] = floor(Perl_Party_Target1:GetTop() - (UIParent:GetTop() / Perl_Party_Target1:GetScale()) + 0.5),
			["XPosition2"] = floor(Perl_Party_Target2:GetLeft() + 0.5),
			["YPosition2"] = floor(Perl_Party_Target2:GetTop() - (UIParent:GetTop() / Perl_Party_Target2:GetScale()) + 0.5),
			["XPosition3"] = floor(Perl_Party_Target3:GetLeft() + 0.5),
			["YPosition3"] = floor(Perl_Party_Target3:GetTop() - (UIParent:GetTop() / Perl_Party_Target3:GetScale()) + 0.5),
			["XPosition4"] = floor(Perl_Party_Target4:GetLeft() + 0.5),
			["YPosition4"] = floor(Perl_Party_Target4:GetTop() - (UIParent:GetTop() / Perl_Party_Target4:GetScale()) + 0.5),
			["Enabled"] = vartable["enabled"],
			["HiddenInRaid"] = vartable["hiddeninraid"],
		};
	end

	if (Perl_Player_Frame) then
		local vartable = Perl_Player_GetVars();
		Perl_Config_Global_Player_Config["Global Settings"] = {
			["Locked"] = vartable["locked"],
			["XPBarState"] = vartable["xpbarstate"],
			["CompactMode"] = vartable["compactmode"],
			["ShowRaidGroup"] = vartable["showraidgroup"],
			["Scale"] = vartable["scale"],
			["HealerMode"] = vartable["healermode"],
			["Transparency"] = vartable["transparency"],
			["XPosition"] = floor(Perl_Player_Frame:GetLeft() + 0.5),
			["YPosition"] = floor(Perl_Player_Frame:GetTop() - (UIParent:GetTop() / Perl_Player_Frame:GetScale()) + 0.5),
			["ShowPortrait"] = vartable["showportrait"],
			["CompactPercent"] = vartable["compactpercent"],
			["ThreeDPortrait"] = vartable["threedportrait"],
			["PortraitCombatText"] = vartable["portraitcombattext"],
			["ShowDruidBar"] = vartable["showdruidbar"],
			["FiveSecSupport"] = vartable["fivesecsupport"],
			["ShortBars"] = vartable["shortbars"],
			["ClassColoredNames"] = vartable["classcolorednames"],
			["HideClassLevelFrame"] = vartable["hideclasslevelframe"],
			["ShowPvPRank"] = vartable["showpvprank"],
			["ShowManaDeficit"] = vartable["showmanadeficit"],
			["HiddenInRaid"] = vartable["hiddeninraid"],
			["ShowPvPIcon"] = vartable["showpvpicon"],
			["ShowBarValues"] = vartable["showbarvalues"],
		};
	end

	if (Perl_Player_Buff_Script_Frame) then
		local vartable = Perl_Player_Buff_GetVars();
		Perl_Config_Global_Player_Buff_Config["Global Settings"] = {
			["BuffAlerts"] = vartable["buffalerts"],
			["ShowBuffs"] = vartable["showbuffs"],
			["Scale"] = vartable["scale"],
			["HideSeconds"] = vartable["hideseconds"],
			["HorizontalSpacing"] = vartable["horizontalspacing"],
		};
	end

	if (Perl_Player_Pet_Frame) then
		local vartable = Perl_Player_Pet_GetVars();
		Perl_Config_Global_Player_Pet_Config["Global Settings"] = {
			["Locked"] = vartable["locked"],
			["ShowXP"] = vartable["showxp"],
			["Scale"] = vartable["scale"],
			["Buffs"] = vartable["numpetbuffsshown"],
			["Debuffs"] = vartable["numpetdebuffsshown"],
			["Transparency"] = vartable["transparency"],
			["BuffLocation"] = vartable["bufflocation"],
			["DebuffLocation"] = vartable["debufflocation"],
			["XPosition"] = floor(Perl_Player_Pet_Frame:GetLeft() + 0.5),
			["YPosition"] = floor(Perl_Player_Pet_Frame:GetTop() - (UIParent:GetTop() / Perl_Player_Pet_Frame:GetScale()) + 0.5),
			["BuffSize"] = vartable["buffsize"],
			["DebuffSize"] = vartable["debuffsize"],
			["ShowPortrait"] = vartable["showportrait"],
			["ThreeDPortrait"] = vartable["threedportrait"],
			["PortraitCombatText"] = vartable["portraitcombattext"],
			["CompactMode"] = vartable["compactmode"],
			["HideName"] = vartable["hidename"],
		};
	end

	if (Perl_Raid_Frame) then
		local vartable = Perl_Raid_GetVars();
		Perl_Config_Global_Raid_Config["Global Settings"] = {
			["Locked"] = locked,
			["ShowGroup1"] = vartable["showgroup1"],
			["ShowGroup2"] = vartable["showgroup2"],
			["ShowGroup3"] = vartable["showgroup3"],
			["ShowGroup4"] = vartable["showgroup4"],
			["ShowGroup5"] = vartable["showgroup5"],
			["ShowGroup6"] = vartable["showgroup6"],
			["ShowGroup7"] = vartable["showgroup7"],
			["ShowGroup8"] = vartable["showgroup8"],
			["ShowGroup9"] = vartable["showgroup9"],
			["SortRaidByClass"] = vartable["sortraidbyclass"],
			["Transparency"] = vartable["transparency"],
			["Scale"] = vartable["scale"],
			["XPosition1"] = floor(Perl_Raid_Grp1:GetLeft() + 0.5),
			["YPosition1"] = floor(Perl_Raid_Grp1:GetTop() - (UIParent:GetTop() / Perl_Raid_Grp1:GetScale()) + 0.5),
			["XPosition2"] = floor(Perl_Raid_Grp2:GetLeft() + 0.5),
			["YPosition2"] = floor(Perl_Raid_Grp2:GetTop() - (UIParent:GetTop() / Perl_Raid_Grp2:GetScale()) + 0.5),
			["XPosition3"] = floor(Perl_Raid_Grp3:GetLeft() + 0.5),
			["YPosition3"] = floor(Perl_Raid_Grp3:GetTop() - (UIParent:GetTop() / Perl_Raid_Grp3:GetScale()) + 0.5),
			["XPosition4"] = floor(Perl_Raid_Grp4:GetLeft() + 0.5),
			["YPosition4"] = floor(Perl_Raid_Grp4:GetTop() - (UIParent:GetTop() / Perl_Raid_Grp4:GetScale()) + 0.5),
			["XPosition5"] = floor(Perl_Raid_Grp5:GetLeft() + 0.5),
			["YPosition5"] = floor(Perl_Raid_Grp5:GetTop() - (UIParent:GetTop() / Perl_Raid_Grp5:GetScale()) + 0.5),
			["XPosition6"] = floor(Perl_Raid_Grp6:GetLeft() + 0.5),
			["YPosition6"] = floor(Perl_Raid_Grp6:GetTop() - (UIParent:GetTop() / Perl_Raid_Grp6:GetScale()) + 0.5),
			["XPosition7"] = floor(Perl_Raid_Grp7:GetLeft() + 0.5),
			["YPosition7"] = floor(Perl_Raid_Grp7:GetTop() - (UIParent:GetTop() / Perl_Raid_Grp7:GetScale()) + 0.5),
			["XPosition8"] = floor(Perl_Raid_Grp8:GetLeft() + 0.5),
			["YPosition8"] = floor(Perl_Raid_Grp8:GetTop() - (UIParent:GetTop() / Perl_Raid_Grp8:GetScale()) + 0.5),
			["ShowHeaders"] = vartable["showheaders"],
			["ShowMissingHealth"] = vartable["showmissinghealth"],
			["VerticalAlign"] = vartable["verticalalign"],
			["InvertedGroups"] = vartable["invertedgroups"],
			["ShowDebuffs"] = vartable["showraiddebuffs"],
			["DisplayCastableBuffs"] = vartable["displaycastablebuffs"],
			["ShowBuffs"] = vartable["showraidbuffs"],
			["ColorDebuffNames"] = vartable["colordebuffnames"],
			["FrameStyle"] = vartable["framestyle"],
			["ShowBorder"] = vartable["showborder"],
			["RemoveSpace"] = vartable["removespace"],
			["HidePowerBars"] = vartable["hidepowerbars"],
			["CTRAStyleTip"] = vartable["ctrastyletip"],
			["ShowHealthPercents"] = vartable["showhealthpercents"],
			["ShowManaPercents"] = vartable["showmanapercents"],
			["HideEmptyHeaders"] = vartable["hideemptyheaders"],
		};
	end

	if (Perl_Target_Frame) then
		local vartable = Perl_Target_GetVars();
		Perl_Config_Global_Target_Config["Global Settings"] = {
			["Locked"] = vartable["locked"],
			["ComboPoints"] = vartable["showcp"],
			["ClassIcon"] = vartable["showclassicon"],
			["ClassFrame"] = vartable["showclassframe"],
			["PvPIcon"] = vartable["showpvpicon"],
			["Buffs"] = vartable["numbuffsshown"],
			["Debuffs"] = vartable["numdebuffsshown"],
			["MobHealthSupport"] = vartable["mobhealthsupport"],
			["Scale"] = vartable["scale"],
			["ShowPvPRank"] = vartable["showpvprank"],
			["Transparency"] = vartable["transparency"],
			["BuffDebuffScale"] = vartable["buffdebuffscale"],
			["XPosition"] = floor(Perl_Target_Frame:GetLeft() + 0.5),
			["YPosition"] = floor(Perl_Target_Frame:GetTop() - (UIParent:GetTop() / Perl_Target_Frame:GetScale()) + 0.5),
			["ShowPortrait"] = vartable["showportrait"],
			["ThreeDPortrait"] = vartable["threedportrait"],
			["PortraitCombatText"] = vartable["portraitcombattext"],
			["ShowRareEliteFrame"] = vartable["showrareeliteframe"],
			["NameFrameComboPoints"] = vartable["nameframecombopoints"],
			["ComboFrameDebuffs"] = vartable["comboframedebuffs"],
			["FrameStyle"] = vartable["framestyle"],
			["CompactMode"] = vartable["compactmode"],
			["CompactPercent"] = vartable["compactpercent"],
			["HideBuffBackground"] = vartable["hidebuffbackground"],
			["ShortBars"] = vartable["shortbars"],
			["HealerMode"] = vartable["healermode"],
			["SoundTargetChange"] = vartable["soundtargetchange"],
			["DisplayCastableBuffs"] = vartable["displaycastablebuffs"],
			["ClassColoredNames"] = vartable["classcolorednames"],
			["ShowManaDeficit"] = vartable["showmanadeficit"],
			["InvertBuffs"] = vartable["invertbuffs"],
		};
	end

	if (Perl_Target_Target_Script_Frame) then
		local vartable = Perl_Target_Target_GetVars();
		Perl_Config_Global_Target_Target_Config["Global Settings"] = {
			["Locked"] = vartable["locked"],
			["MobHealthSupport"] = vartable["mobhealthsupport"],
			["Scale"] = vartable["scale"],
			["ToTSupport"] = vartable["totsupport"],
			["ToToTSupport"] = vartable["tototsupport"],
			["Transparency"] = vartable["transparency"],
			["XPositionToT"] = floor(Perl_Target_Target_Frame:GetLeft() + 0.5),
			["YPositionToT"] = floor(Perl_Target_Target_Frame:GetTop() - (UIParent:GetTop() / Perl_Target_Target_Frame:GetScale()) + 0.5),
			["XPositionToToT"] = floor(Perl_Target_Target_Target_Frame:GetLeft() + 0.5),
			["YPositionToToT"] = floor(Perl_Target_Target_Target_Frame:GetTop() - (UIParent:GetTop() / Perl_Target_Target_Target_Frame:GetScale()) + 0.5),
			["AlertSound"] = vartable["alertsound"],
			["AlertMode"] = vartable["alertmode"],
			["AlertSize"] = vartable["alertsize"],
			["ShowToTBuffs"] = vartable["showtotbuffs"],
			["ShowToToTBuffs"] = vartable["showtototbuffs"],
			["HidePowerBars"] = vartable["hidepowerbars"],
			["ShowToTDebuffs"] = vartable["showtotdebuffs"],
			["ShowToToTDebuffs"] = vartable["showtototdebuffs"],
			["DisplayCastableBuffs"] = vartable["displaycastablebuffs"],
			["ClassColoredNames"] = vartable["classcolorednames"],
			["ShowFriendlyHealth"] = vartable["showfriendlyhealth"],
		};
	end
end

function Perl_Config_Global_Load_Settings()
	-- Load all global settings from last save and then do window positions in this mod since we aren't saving the positions in each individual mod (and to keep all position changes in one file instead of six).
	if (Perl_ArcaneBar_Frame_Loaded_Frame) then
		Perl_ArcaneBar_UpdateVars(Perl_Config_Global_ArcaneBar_Config);
	end

	if (Perl_CombatDisplay_Frame) then
		Perl_CombatDisplay_UpdateVars(Perl_Config_Global_CombatDisplay_Config);

		if (Perl_Config_Global_CombatDisplay_Config["Global Settings"] ~= nil) then
			if ((Perl_Config_Global_CombatDisplay_Config["Global Settings"]["XPositionCD"] ~= nil) and (Perl_Config_Global_CombatDisplay_Config["Global Settings"]["YPositionCD"] ~= nil) and (Perl_Config_Global_CombatDisplay_Config["Global Settings"]["XPositionCDT"] ~= nil) and (Perl_Config_Global_CombatDisplay_Config["Global Settings"]["YPositionCDT"] ~= nil)) then
				Perl_CombatDisplay_Frame:SetUserPlaced(1);
				Perl_CombatDisplay_Target_Frame:SetUserPlaced(1);
				Perl_CombatDisplay_Frame:ClearAllPoints();
				Perl_CombatDisplay_Target_Frame:ClearAllPoints();
				Perl_CombatDisplay_Frame:SetPoint("TOPLEFT", UIParent, "TOPLEFT", Perl_Config_Global_CombatDisplay_Config["Global Settings"]["XPositionCD"], Perl_Config_Global_CombatDisplay_Config["Global Settings"]["YPositionCD"]);
				Perl_CombatDisplay_Target_Frame:SetPoint("TOPLEFT", UIParent, "TOPLEFT", Perl_Config_Global_CombatDisplay_Config["Global Settings"]["XPositionCDT"], Perl_Config_Global_CombatDisplay_Config["Global Settings"]["YPositionCDT"]);
			end
		end
	end

	if (Perl_Config_Script_Frame) then
		Perl_Config_UpdateVars(Perl_Config_Global_Config_Config);
	end

	if (Perl_Party_Frame) then
		Perl_Party_UpdateVars(Perl_Config_Global_Party_Config);

		if (Perl_Config_Global_Party_Config["Global Settings"] ~= nil) then
			if ((Perl_Config_Global_Party_Config["Global Settings"]["XPosition"] ~= nil) and (Perl_Config_Global_Party_Config["Global Settings"]["YPosition"] ~= nil)) then
				Perl_Party_Frame:SetUserPlaced(1);
				Perl_Party_Frame:SetPoint("TOPLEFT", UIParent, "TOPLEFT", Perl_Config_Global_Party_Config["Global Settings"]["XPosition"], Perl_Config_Global_Party_Config["Global Settings"]["YPosition"]);
			end
		end
	end

	if (Perl_Party_Pet_Script_Frame) then
		Perl_Party_Pet_UpdateVars(Perl_Config_Global_Party_Pet_Config);

		if (Perl_Config_Global_Party_Pet_Config["Global Settings"] ~= nil) then
			if ((Perl_Config_Global_Party_Pet_Config["Global Settings"]["XPosition1"] ~= nil) and (Perl_Config_Global_Party_Pet_Config["Global Settings"]["YPosition1"] ~= nil)) then
				Perl_Party_Pet1:SetUserPlaced(1);
				Perl_Party_Pet2:SetUserPlaced(1);
				Perl_Party_Pet3:SetUserPlaced(1);
				Perl_Party_Pet4:SetUserPlaced(1);
				Perl_Party_Pet1:SetPoint("TOPLEFT", UIParent, "TOPLEFT", Perl_Config_Global_Party_Pet_Config["Global Settings"]["XPosition1"], Perl_Config_Global_Party_Pet_Config["Global Settings"]["YPosition1"]);
				Perl_Party_Pet2:SetPoint("TOPLEFT", UIParent, "TOPLEFT", Perl_Config_Global_Party_Pet_Config["Global Settings"]["XPosition2"], Perl_Config_Global_Party_Pet_Config["Global Settings"]["YPosition2"]);
				Perl_Party_Pet3:SetPoint("TOPLEFT", UIParent, "TOPLEFT", Perl_Config_Global_Party_Pet_Config["Global Settings"]["XPosition3"], Perl_Config_Global_Party_Pet_Config["Global Settings"]["YPosition3"]);
				Perl_Party_Pet4:SetPoint("TOPLEFT", UIParent, "TOPLEFT", Perl_Config_Global_Party_Pet_Config["Global Settings"]["XPosition4"], Perl_Config_Global_Party_Pet_Config["Global Settings"]["YPosition4"]);
			end
		end
	end

	if (Perl_Party_Target_Script_Frame) then
		Perl_Party_Target_UpdateVars(Perl_Config_Global_Party_Target_Config);

		if (Perl_Config_Global_Party_Target_Config["Global Settings"] ~= nil) then
			if ((Perl_Config_Global_Party_Target_Config["Global Settings"]["XPosition1"] ~= nil) and (Perl_Config_Global_Party_Target_Config["Global Settings"]["YPosition1"] ~= nil)) then
				Perl_Party_Target1:SetUserPlaced(1);
				Perl_Party_Target2:SetUserPlaced(1);
				Perl_Party_Target3:SetUserPlaced(1);
				Perl_Party_Target4:SetUserPlaced(1);
				Perl_Party_Target1:SetPoint("TOPLEFT", UIParent, "TOPLEFT", Perl_Config_Global_Party_Target_Config["Global Settings"]["XPosition1"], Perl_Config_Global_Party_Target_Config["Global Settings"]["YPosition1"]);
				Perl_Party_Target2:SetPoint("TOPLEFT", UIParent, "TOPLEFT", Perl_Config_Global_Party_Target_Config["Global Settings"]["XPosition2"], Perl_Config_Global_Party_Target_Config["Global Settings"]["YPosition2"]);
				Perl_Party_Target3:SetPoint("TOPLEFT", UIParent, "TOPLEFT", Perl_Config_Global_Party_Target_Config["Global Settings"]["XPosition3"], Perl_Config_Global_Party_Target_Config["Global Settings"]["YPosition3"]);
				Perl_Party_Target4:SetPoint("TOPLEFT", UIParent, "TOPLEFT", Perl_Config_Global_Party_Target_Config["Global Settings"]["XPosition4"], Perl_Config_Global_Party_Target_Config["Global Settings"]["YPosition4"]);
			end
		end
	end

	if (Perl_Player_Frame) then
		Perl_Player_UpdateVars(Perl_Config_Global_Player_Config);

		if (Perl_Config_Global_Player_Config["Global Settings"] ~= nil) then
			if ((Perl_Config_Global_Player_Config["Global Settings"]["XPosition"] ~= nil) and (Perl_Config_Global_Player_Config["Global Settings"]["YPosition"] ~= nil)) then
				Perl_Player_Frame:SetUserPlaced(1);
				Perl_Player_Frame:SetPoint("TOPLEFT", UIParent, "TOPLEFT", Perl_Config_Global_Player_Config["Global Settings"]["XPosition"], Perl_Config_Global_Player_Config["Global Settings"]["YPosition"]);
			end
		end
	end

	if (Perl_Player_Buff_Script_Frame) then
		Perl_Player_Buff_UpdateVars(Perl_Config_Global_Player_Buff_Config);
	end

	if (Perl_Player_Pet_Frame) then
		Perl_Player_Pet_UpdateVars(Perl_Config_Global_Player_Pet_Config);

		if (Perl_Config_Global_Player_Pet_Config["Global Settings"] ~= nil) then
			if ((Perl_Config_Global_Player_Pet_Config["Global Settings"]["XPosition"] ~= nil) and (Perl_Config_Global_Player_Pet_Config["Global Settings"]["YPosition"] ~= nil)) then
				Perl_Player_Pet_Frame:SetUserPlaced(1);
				Perl_Player_Pet_Frame:SetPoint("TOPLEFT", UIParent, "TOPLEFT", Perl_Config_Global_Player_Pet_Config["Global Settings"]["XPosition"], Perl_Config_Global_Player_Pet_Config["Global Settings"]["YPosition"]);
			end
		end
	end

	if (Perl_Raid_Frame) then
		Perl_Raid_Set_Scale();
		Perl_Raid_Set_Transparency();
		Perl_Raid_UpdateVars(Perl_Config_Global_Raid_Config);

		if (Perl_Config_Global_Raid_Config["Global Settings"] ~= nil) then
			if ((Perl_Config_Global_Raid_Config["Global Settings"]["XPosition1"] ~= nil) and (Perl_Config_Global_Raid_Config["Global Settings"]["YPosition1"] ~= nil)) then
				Perl_Raid_Grp1:SetUserPlaced(1);
				Perl_Raid_Grp2:SetUserPlaced(1);
				Perl_Raid_Grp3:SetUserPlaced(1);
				Perl_Raid_Grp4:SetUserPlaced(1);
				Perl_Raid_Grp5:SetUserPlaced(1);
				Perl_Raid_Grp6:SetUserPlaced(1);
				Perl_Raid_Grp7:SetUserPlaced(1);
				Perl_Raid_Grp8:SetUserPlaced(1);
				Perl_Raid_Grp1:SetPoint("TOPLEFT", UIParent, "TOPLEFT", Perl_Config_Global_Raid_Config["Global Settings"]["XPosition1"], Perl_Config_Global_Raid_Config["Global Settings"]["YPosition1"]);
				Perl_Raid_Grp2:SetPoint("TOPLEFT", UIParent, "TOPLEFT", Perl_Config_Global_Raid_Config["Global Settings"]["XPosition2"], Perl_Config_Global_Raid_Config["Global Settings"]["YPosition2"]);
				Perl_Raid_Grp3:SetPoint("TOPLEFT", UIParent, "TOPLEFT", Perl_Config_Global_Raid_Config["Global Settings"]["XPosition3"], Perl_Config_Global_Raid_Config["Global Settings"]["YPosition3"]);
				Perl_Raid_Grp4:SetPoint("TOPLEFT", UIParent, "TOPLEFT", Perl_Config_Global_Raid_Config["Global Settings"]["XPosition4"], Perl_Config_Global_Raid_Config["Global Settings"]["YPosition4"]);
				Perl_Raid_Grp5:SetPoint("TOPLEFT", UIParent, "TOPLEFT", Perl_Config_Global_Raid_Config["Global Settings"]["XPosition5"], Perl_Config_Global_Raid_Config["Global Settings"]["YPosition5"]);
				Perl_Raid_Grp6:SetPoint("TOPLEFT", UIParent, "TOPLEFT", Perl_Config_Global_Raid_Config["Global Settings"]["XPosition6"], Perl_Config_Global_Raid_Config["Global Settings"]["YPosition6"]);
				Perl_Raid_Grp7:SetPoint("TOPLEFT", UIParent, "TOPLEFT", Perl_Config_Global_Raid_Config["Global Settings"]["XPosition7"], Perl_Config_Global_Raid_Config["Global Settings"]["YPosition7"]);
				Perl_Raid_Grp8:SetPoint("TOPLEFT", UIParent, "TOPLEFT", Perl_Config_Global_Raid_Config["Global Settings"]["XPosition8"], Perl_Config_Global_Raid_Config["Global Settings"]["YPosition8"]);
			end
		end
	end

	if (Perl_Target_Frame) then
		Perl_Target_UpdateVars(Perl_Config_Global_Target_Config);

		if (Perl_Config_Global_Target_Config["Global Settings"] ~= nil) then
			if ((Perl_Config_Global_Target_Config["Global Settings"]["XPosition"] ~= nil) and (Perl_Config_Global_Target_Config["Global Settings"]["YPosition"] ~= nil)) then
				Perl_Target_Frame:SetUserPlaced(1);
				Perl_Target_Frame:SetPoint("TOPLEFT", UIParent, "TOPLEFT", Perl_Config_Global_Target_Config["Global Settings"]["XPosition"], Perl_Config_Global_Target_Config["Global Settings"]["YPosition"]);
			end
		end
	end

	if (Perl_Target_Target_Script_Frame) then
		Perl_Target_Target_UpdateVars(Perl_Config_Global_Target_Target_Config);

		if (Perl_Config_Global_Target_Target_Config["Global Settings"] ~= nil) then
			if ((Perl_Config_Global_Target_Target_Config["Global Settings"]["XPositionToT"] ~= nil) and (Perl_Config_Global_Target_Target_Config["Global Settings"]["YPositionToT"] ~= nil) and (Perl_Config_Global_Target_Target_Config["Global Settings"]["XPositionToToT"] ~= nil) and (Perl_Config_Global_Target_Target_Config["Global Settings"]["YPositionToToT"] ~= nil)) then
				Perl_Target_Target_Frame:SetUserPlaced(1);
				Perl_Target_Target_Target_Frame:SetUserPlaced(1);
				Perl_Target_Target_Frame:SetPoint("TOPLEFT", UIParent, "TOPLEFT", Perl_Config_Global_Target_Target_Config["Global Settings"]["XPositionToT"], Perl_Config_Global_Target_Target_Config["Global Settings"]["YPositionToT"]);
				Perl_Target_Target_Target_Frame:SetPoint("TOPLEFT", UIParent, "TOPLEFT", Perl_Config_Global_Target_Target_Config["Global Settings"]["XPositionToToT"], Perl_Config_Global_Target_Target_Config["Global Settings"]["YPositionToToT"]);
			end
		end
	end
end

------------------------------
-- Saved Variable Functions --
------------------------------
function Perl_Config_GetVars(name, updateflag)
	if (name == nil) then
		name = UnitName("player");
	end

	texture = Perl_Config_Config[name]["Texture"];
	showminimapbutton = Perl_Config_Config[name]["ShowMiniMapButton"];
	minimapbuttonpos = Perl_Config_Config[name]["MiniMapButtonPos"];
	transparentbackground = Perl_Config_Config[name]["TransparentBackground"];
	PCUF_CASTPARTYSUPPORT = Perl_Config_Config[name]["PCUF_CastPartySupport"];
	PCUF_COLORHEALTH = Perl_Config_Config[name]["PCUF_ColorHealth"];
	texturedbarbackground = Perl_Config_Config[name]["TexturedBarBackround"];
	PCUF_FADEBARS = Perl_Config_Config[name]["PCUF_FadeBars"];
	PCUF_NAMEFRAMECLICKCAST = Perl_Config_Config[name]["PCUF_NameFrameClickCast"];
	PCUF_INVERTBARVALUES = Perl_Config_Config[name]["PCUF_InvertBarValues"];

	if (texture == nil) then
		texture = 0;
	end
	if (showminimapbutton == nil) then
		showminimapbutton = 1;
	end
	if (minimapbuttonpos == nil) then
		minimapbuttonpos = 270;
	end
	if (transparentbackground == nil) then
		transparentbackground = 0;
	end
	if (PCUF_CASTPARTYSUPPORT == nil) then
		PCUF_CASTPARTYSUPPORT = 0;
	end
	if (PCUF_COLORHEALTH == nil) then
		PCUF_COLORHEALTH = 0;
	end
	if (texturedbarbackground == nil) then
		texturedbarbackground = 0;
	end
	if (PCUF_FADEBARS == nil) then
		PCUF_FADEBARS = 0;
	end
	if (PCUF_NAMEFRAMECLICKCAST == nil) then
		PCUF_NAMEFRAMECLICKCAST = 0;
	end
	if (PCUF_INVERTBARVALUES == nil) then
		PCUF_INVERTBARVALUES = 0;
	end

	if (updateflag == 1) then
		-- Save the new values
		Perl_Config_UpdateVars();

		-- Call any code we need to activate them
		Perl_Config_Set_Texture(texture);
		Perl_Config_Set_MiniMap_Button(showminimapbutton);
		Perl_Config_Set_MiniMap_Position(minimapbuttonpos);
		Perl_Config_Set_Background();
		return;
	end

	local vars = {
		["texture"] = texture,
		["showminimapbutton"] = showminimapbutton,
		["minimapbuttonpos"] = minimapbuttonpos,
		["transparentbackground"] = transparentbackground,
		["PCUF_CastPartySupport"] = PCUF_CASTPARTYSUPPORT,
		["PCUF_ColorHealth"] = PCUF_COLORHEALTH,
		["texturedbarbackground"] = texturedbarbackground,
		["PCUF_FadeBars"] = PCUF_FADEBARS,
		["PCUF_NameFrameClickCast"] = PCUF_NAMEFRAMECLICKCAST,
		["PCUF_InvertBarValues"] = PCUF_INVERTBARVALUES,
	}
	return vars;
end

function Perl_Config_UpdateVars(vartable)
	if (vartable ~= nil) then
		-- Sanity checks in case you use a load from an old version
		if (vartable["Global Settings"] ~= nil) then
			if (vartable["Global Settings"]["Texture"] ~= nil) then
				texture = vartable["Global Settings"]["Texture"];
			else
				texture = nil;
			end
			if (vartable["Global Settings"]["ShowMiniMapButton"] ~= nil) then
				showminimapbutton = vartable["Global Settings"]["ShowMiniMapButton"];
			else
				showminimapbutton = nil;
			end
			if (vartable["Global Settings"]["MiniMapButtonPos"] ~= nil) then
				minimapbuttonpos = vartable["Global Settings"]["MiniMapButtonPos"];
			else
				minimapbuttonpos = nil;
			end
			if (vartable["Global Settings"]["TransparentBackground"] ~= nil) then
				transparentbackground = vartable["Global Settings"]["TransparentBackground"];
			else
				transparentbackground = nil;
			end
			if (vartable["Global Settings"]["PCUF_CastPartySupport"] ~= nil) then
				PCUF_CASTPARTYSUPPORT = vartable["Global Settings"]["PCUF_CastPartySupport"];
			else
				PCUF_CASTPARTYSUPPORT = nil;
			end
			if (vartable["Global Settings"]["PCUF_ColorHealth"] ~= nil) then
				PCUF_COLORHEALTH = vartable["Global Settings"]["PCUF_ColorHealth"];
			else
				PCUF_COLORHEALTH = nil;
			end
			if (vartable["Global Settings"]["TexturedBarBackround"] ~= nil) then
				texturedbarbackground = vartable["Global Settings"]["TexturedBarBackround"];
			else
				texturedbarbackground = nil;
			end
			if (vartable["Global Settings"]["PCUF_FadeBars"] ~= nil) then
				PCUF_FADEBARS = vartable["Global Settings"]["PCUF_FadeBars"];
			else
				PCUF_FADEBARS = nil;
			end
			if (vartable["Global Settings"]["PCUF_NameFrameClickCast"] ~= nil) then
				PCUF_NAMEFRAMECLICKCAST = vartable["Global Settings"]["PCUF_NameFrameClickCast"];
			else
				PCUF_NAMEFRAMECLICKCAST = nil;
			end
			if (vartable["Global Settings"]["PCUF_InvertBarValues"] ~= nil) then
				PCUF_INVERTBARVALUES = vartable["Global Settings"]["PCUF_InvertBarValues"];
			else
				PCUF_INVERTBARVALUES = nil;
			end
		end

		-- Set the new values if any new values were found, same defaults as above
		if (texture == nil) then
			texture = 0;
		end
		if (showminimapbutton == nil) then
			showminimapbutton = 1;
		end
		if (minimapbuttonpos == nil) then
			minimapbuttonpos = 270;
		end
		if (transparentbackground == nil) then
			transparentbackground = 0;
		end
		if (PCUF_CASTPARTYSUPPORT == nil) then
			PCUF_CASTPARTYSUPPORT = 0;
		end
		if (PCUF_COLORHEALTH == nil) then
			PCUF_COLORHEALTH = 0;
		end
		if (texturedbarbackground == nil) then
			texturedbarbackground = 0;
		end
		if (PCUF_FADEBARS == nil) then
			PCUF_FADEBARS = 0;
		end
		if (PCUF_NAMEFRAMECLICKCAST == nil) then
			PCUF_NAMEFRAMECLICKCAST = 0;
		end
		if (PCUF_INVERTBARVALUES == nil) then
			PCUF_INVERTBARVALUES = 0;
		end

		-- Call any code we need to activate them
		Perl_Config_Set_Texture(texture);
		Perl_Config_Set_MiniMap_Button(showminimapbutton);
		Perl_Config_Set_MiniMap_Position(minimapbuttonpos);
		Perl_Config_Set_Background();
	end

	Perl_Config_Config[UnitName("player")] = {
		["Texture"] = texture,
		["ShowMiniMapButton"] = showminimapbutton,
		["MiniMapButtonPos"] = minimapbuttonpos,
		["TransparentBackground"] = transparentbackground,
		["PCUF_CastPartySupport"] = PCUF_CASTPARTYSUPPORT,
		["PCUF_ColorHealth"] = PCUF_COLORHEALTH,
		["TexturedBarBackround"] = texturedbarbackground,
		["PCUF_FadeBars"] = PCUF_FADEBARS,
		["PCUF_NameFrameClickCast"] = PCUF_NAMEFRAMECLICKCAST,
		["PCUF_InvertBarValues"] = PCUF_INVERTBARVALUES,
	};
end


-------------------------
-- The Toggle Function --
-------------------------
function Perl_Config_Toggle()
	local loaded, reason = LoadAddOn("Perl_Config_Options");

	if (loaded) then
		if (Perl_Config_Frame:IsVisible()) then
			Perl_Config_Frame:Hide();
			Perl_Config_Hide_All();
		else
			Perl_Config_Frame:ClearAllPoints();
			Perl_Config_Frame:SetPoint("CENTER", 0, 0);
			Perl_Config_Frame:Show();
			Perl_Config_Hide_All();
		end
	else
		DEFAULT_CHAT_FRAME:AddMessage("Perl Classic - Config: The options menu failed to load because: "..reason);
	end
end

function Perl_Config_Hide_All()
	Perl_Config_All_Frame:Hide();
	Perl_Config_ArcaneBar_Frame:Hide();
	Perl_Config_CombatDisplay_Frame:Hide();
	Perl_Config_NotInstalled_Frame:Hide();
	Perl_Config_Party_Frame:Hide();
	Perl_Config_Party_Pet_Frame:Hide();
	Perl_Config_Party_Target_Frame:Hide();
	Perl_Config_Player_Frame:Hide();
	Perl_Config_Player_Buff_Frame:Hide();
	Perl_Config_Player_Pet_Frame:Hide();
	Perl_Config_Raid_Frame:Hide();
	Perl_Config_Target_Frame:Hide();
	Perl_Config_Target_Target_Frame:Hide();
	Perl_Config_ThirdParty_Frame:Hide();

	-- All third party frames can be checked for here
	if (Perl_Config_ColorChange_Frame) then
		Perl_Config_ColorChange_Frame:Hide();
	end
end

function Perl_Config_ShowHide_MiniMap_Button()
	if (showminimapbutton == 0) then
		Perl_Config_ButtonFrame:Hide();
	else
		Perl_Config_ButtonFrame:Show();
	end
end


---------------------------
-- The Minimap Functions --
---------------------------
function Perl_Config_Button_OnClick(button)
	if (button == "LeftButton") then
		Perl_Config_Toggle();
	elseif (button == "RightButton") then
		local unlockedflag = 0;

		if (Perl_CombatDisplay_Frame) then
			if (Perl_CombatDisplay_Config[UnitName("player")]["Locked"] == 0) then
				unlockedflag = 1;
			end
		end

		if (Perl_Party_Frame) then
			if (Perl_Party_Config[UnitName("player")]["Locked"] == 0) then
				unlockedflag = 1;
			end
		end

		if (Perl_Party_Pet_Script_Frame) then
			if (Perl_Party_Pet_Config[UnitName("player")]["Locked"] == 0) then
				unlockedflag = 1;
			end
		end

		if (Perl_Party_Target_Script_Frame) then
			if (Perl_Party_Target_Config[UnitName("player")]["Locked"] == 0) then
				unlockedflag = 1;
			end
		end

		if (Perl_Player_Frame) then
			if (Perl_Player_Config[UnitName("player")]["Locked"] == 0) then
				unlockedflag = 1;
			end
		end

		if (Perl_Player_Pet_Frame) then
			if (Perl_Player_Pet_Config[UnitName("player")]["Locked"] == 0) then
				unlockedflag = 1;
			end
		end

		if (Perl_Raid_Frame) then
			if (Perl_Raid_Config[UnitName("player")]["Locked"] == 0) then
				unlockedflag = 1;
			end
		end

		if (Perl_Target_Frame) then
			if (Perl_Target_Config[UnitName("player")]["Locked"] == 0) then
				unlockedflag = 1;
			end
		end

		if (Perl_Target_Target_Script_Frame) then
			if (Perl_Target_Target_Config[UnitName("player")]["Locked"] == 0) then
				unlockedflag = 1;
			end
		end

		if (unlockedflag == 1) then
			Perl_Config_Lock_Unlock(1);
		else
			Perl_Config_Lock_Unlock(0);
		end

		GameTooltip:Hide();
		Perl_Config_Button_Tooltip();
	end
end

function Perl_Config_Button_Tooltip()
	local unlockedflag = 0;

	GameTooltip_SetDefaultAnchor(GameTooltip, this);
	GameTooltip:SetText("Perl Classic Options");

	if (Perl_CombatDisplay_Frame) then
		if (type(Perl_CombatDisplay_Config[UnitName("player")]) == "table") then
			if (Perl_CombatDisplay_Config[UnitName("player")]["Locked"] == 0) then
				GameTooltip:AddLine("Perl_CombatDisplay is unlocked");
				unlockedflag = 1;
			else
				GameTooltip:AddLine("Perl_CombatDisplay is locked");
			end
		else
			Perl_CombatDisplay_UpdateVars();
			GameTooltip:AddLine("Perl_CombatDisplay could not verify its status.");
		end
	end

	if (Perl_Party_Frame) then
		if (type(Perl_Party_Config[UnitName("player")]) == "table") then
			if (Perl_Party_Config[UnitName("player")]["Locked"] == 0) then
				GameTooltip:AddLine("Perl_Party is unlocked");
				unlockedflag = 1;
			else
				GameTooltip:AddLine("Perl_Party is locked");
			end
		else
			Perl_Party_UpdateVars();
			GameTooltip:AddLine("Perl_Party could not verify its status.");
		end
	end

	if (Perl_Party_Pet_Script_Frame) then
		if (type(Perl_Party_Pet_Config[UnitName("player")]) == "table") then
			if (Perl_Party_Pet_Config[UnitName("player")]["Locked"] == 0) then
				GameTooltip:AddLine("Perl_Party_Pet is unlocked");
				unlockedflag = 1;
			else
				GameTooltip:AddLine("Perl_Party_Pet is locked");
			end
		else
			Perl_Party_Pet_UpdateVars();
			GameTooltip:AddLine("Perl_Party_Pet could not verify its status.");
		end
	end

	if (Perl_Party_Target_Script_Frame) then
		if (type(Perl_Party_Target_Config[UnitName("player")]) == "table") then
			if (Perl_Party_Target_Config[UnitName("player")]["Locked"] == 0) then
				GameTooltip:AddLine("Perl_Party_Target is unlocked");
				unlockedflag = 1;
			else
				GameTooltip:AddLine("Perl_Party_Target is locked");
			end
		else
			Perl_Party_Target_UpdateVars();
			GameTooltip:AddLine("Perl_Party_Target could not verify its status.");
		end
	end

	if (Perl_Player_Frame) then
		if (type(Perl_Player_Config[UnitName("player")]) == "table") then
			if (Perl_Player_Config[UnitName("player")]["Locked"] == 0) then
				GameTooltip:AddLine("Perl_Player is unlocked");
				unlockedflag = 1;
			else
				GameTooltip:AddLine("Perl_Player is locked");
			end
		else
			Perl_Player_UpdateVars();
			GameTooltip:AddLine("Perl_Player could not verify its status.");
		end
	end

	if (Perl_Player_Pet_Frame) then
		if (type(Perl_Player_Pet_Config[UnitName("player")]) == "table") then
			if (Perl_Player_Pet_Config[UnitName("player")]["Locked"] == 0) then
				GameTooltip:AddLine("Perl_Player_Pet is unlocked");
				unlockedflag = 1;
			else
				GameTooltip:AddLine("Perl_Player_Pet is locked");
			end
		else
			Perl_Player_Pet_UpdateVars();
			GameTooltip:AddLine("Perl_Player_Pet could not verify its status.");
		end
	end

	if (Perl_Raid_Frame) then
		if (type(Perl_Raid_Config[UnitName("player")]) == "table") then
			if (Perl_Raid_Config[UnitName("player")]["Locked"] == 0) then
				GameTooltip:AddLine("Perl_Raid is unlocked");
				unlockedflag = 1;
			else
				GameTooltip:AddLine("Perl_Raid is locked");
			end
		else
			Perl_Raid_UpdateVars();
			GameTooltip:AddLine("Perl_Raid could not verify its status.");
		end
	end

	if (Perl_Target_Frame) then
		if (type(Perl_Target_Config[UnitName("player")]) == "table") then
			if (Perl_Target_Config[UnitName("player")]["Locked"] == 0) then
				GameTooltip:AddLine("Perl_Target is unlocked");
				unlockedflag = 1;
			else
				GameTooltip:AddLine("Perl_Target is locked");
			end
		else
			Perl_Target_UpdateVars();
			GameTooltip:AddLine("Perl_Target could not verify its status.");
		end
	end

	if (Perl_Target_Target_Script_Frame) then
		if (type(Perl_Target_Target_Config[UnitName("player")]) == "table") then
			if (Perl_Target_Target_Config[UnitName("player")]["Locked"] == 0) then
				GameTooltip:AddLine("Perl_Target_Target is unlocked");
				unlockedflag = 1;
			else
				GameTooltip:AddLine("Perl_Target_Target is locked");
			end
		else
			Perl_Target_Target_UpdateVars();
			GameTooltip:AddLine("Perl_Target_Target could not verify its status.");
		end
	end

	GameTooltip:AddLine(" ");

	if (unlockedflag == 1) then
		GameTooltip:AddLine(PERL_LOCALIZED_CONFIG_MINIMAP_LOCK);
	else
		GameTooltip:AddLine(PERL_LOCALIZED_CONFIG_MINIMAP_UNLOCK);
	end

	GameTooltip:Show();
end

function Perl_Config_Button_UpdatePosition()
	Perl_Config_ButtonFrame:SetPoint(
		"TOPLEFT",
		"Minimap",
		"TOPLEFT",
		52 - (80 * cos(minimapbuttonpos)),
		(80 * sin(minimapbuttonpos)) - 52
	);
end


--------------------------------------
-- Disable Blizzard Frame Functions --
--------------------------------------
function Perl_clearBlizzardOnEventHandler()	-- Changed function names as to not intrude on those using the mod for other purposes
end

function Perl_clearBlizzardOnShowHandler()
	this:Hide();
end

function Perl_clearBlizzardFrameDisable(frameObject)
	frameObject:SetScript("OnEvent", Perl_clearBlizzardOnEventHandler);
	frameObject:SetScript("OnShow", Perl_clearBlizzardOnShowHandler);
	frameObject:Hide();
end


----------------------
-- myAddOns Support --
----------------------
function Perl_Config_myAddOns_Support()
	-- Register the addon in myAddOns
	if (myAddOnsFrame_Register) then
		local Perl_Config_myAddOns_Details = {
			name = "Perl_Config",
			version = PERL_LOCALIZED_VERSION,
			releaseDate = PERL_LOCALIZED_DATE,
			author = "Global",
			email = "global@g-ball.com",
			website = "http://www.curse-gaming.com/mod.php?addid=2257",
			category = MYADDONS_CATEGORY_OTHERS,
			optionsframe = "Perl_Config_Frame",
		};
		Perl_Config_myAddOns_Help = {};
		Perl_Config_myAddOns_Help[1] = "/perl";
		myAddOnsFrame_Register(Perl_Config_myAddOns_Details, Perl_Config_myAddOns_Help);
	end
end
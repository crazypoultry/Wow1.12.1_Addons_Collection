---------------
-- Variables --
---------------
Perl_Player_Pet_Config = {};
local Perl_Player_Pet_Events = {};	-- event manager

-- Default Saved Variables (also set in Perl_Player_Pet_GetVars)
local locked = 0;			-- unlocked by default
local showxp = 0;			-- xp bar is hidden by default
local scale = 1;			-- default scale
local numpetbuffsshown = 16;		-- buff row is 16 long
local numpetdebuffsshown = 16;		-- debuff row is 16 long
local transparency = 1;			-- transparency for frames
local bufflocation = 4;			-- default buff location
local debufflocation = 5;		-- default debuff location
local buffsize = 12;			-- default buff size is 12
local debuffsize = 12;			-- default debuff size is 12
local showportrait = 0;			-- portrait is hidden by default
local threedportrait = 0;		-- 3d portraits are off by default
local portraitcombattext = 0;		-- Combat text is disabled by default on the portrait frame
local compactmode = 0;			-- compact mode is disabled by default
local hidename = 1;			-- name and level frame is enabled by default

-- Default Local Variables
local Initialized = nil;		-- waiting to be initialized

-- Fade Bar Variables
local Perl_Player_Pet_HealthBar_Fade_Color = 1;		-- the color fading interval
local Perl_Player_Pet_HealthBar_Fade_Time_Elapsed = 0;	-- set the update timer to 0
local Perl_Player_Pet_ManaBar_Fade_Color = 1;		-- the color fading interval
local Perl_Player_Pet_ManaBar_Fade_Time_Elapsed = 0;	-- set the update timer to 0

-- Local variables to save memory
local pethealth, pethealthmax, petmana, petmanamax, happiness, playerpetxp, playerpetxpmax, xptext;


----------------------
-- Loading Function --
----------------------
function Perl_Player_Pet_OnLoad()
	-- Combat Text
	CombatFeedback_Initialize(Perl_Player_Pet_HitIndicator, 30);

	-- Events
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("PLAYER_PET_CHANGED");
	this:RegisterEvent("UNIT_AURA");
	this:RegisterEvent("UNIT_COMBAT");
	this:RegisterEvent("UNIT_DISPLAYPOWER");
	this:RegisterEvent("UNIT_FOCUS");
	this:RegisterEvent("UNIT_HAPPINESS");
	this:RegisterEvent("UNIT_HEALTH");
	this:RegisterEvent("UNIT_LEVEL");
	this:RegisterEvent("UNIT_MANA");
	this:RegisterEvent("UNIT_MAXFOCUS");
	this:RegisterEvent("UNIT_MAXHEALTH");
	this:RegisterEvent("UNIT_MAXMANA");
	this:RegisterEvent("UNIT_MODEL_CHANGED");
	this:RegisterEvent("UNIT_NAME_UPDATE");
	this:RegisterEvent("UNIT_PET");
	this:RegisterEvent("UNIT_PET_EXPERIENCE");
	this:RegisterEvent("UNIT_PORTRAIT_UPDATE");
	this:RegisterEvent("UNIT_SPELLMISS");
	this:RegisterEvent("VARIABLES_LOADED");

	-- Scripts
	this:SetScript("OnEvent", Perl_Player_Pet_OnEvent);
	this:SetScript("OnUpdate", CombatFeedback_OnUpdate);

	-- Button Click Overlays (in order of occurrence in XML)
	Perl_Player_Pet_NameFrame_CastClickOverlay:SetFrameLevel(Perl_Player_Pet_NameFrame:GetFrameLevel() + 1);
	Perl_Player_Pet_LevelFrame_CastClickOverlay:SetFrameLevel(Perl_Player_Pet_LevelFrame:GetFrameLevel() + 2);
	Perl_Player_Pet_StatsFrame_CastClickOverlay:SetFrameLevel(Perl_Player_Pet_StatsFrame:GetFrameLevel() + 2);
	Perl_Player_Pet_PortraitFrame_CastClickOverlay:SetFrameLevel(Perl_Player_Pet_PortraitFrame:GetFrameLevel() + 2);
	Perl_Player_Pet_PortraitTextFrame:SetFrameLevel(Perl_Player_Pet_PortraitFrame:GetFrameLevel() + 1);
	Perl_Player_Pet_HealthBarFadeBar:SetFrameLevel(Perl_Player_Pet_HealthBar:GetFrameLevel() - 1);
	Perl_Player_Pet_ManaBarFadeBar:SetFrameLevel(Perl_Player_Pet_ManaBar:GetFrameLevel() - 1);
end


-------------------
-- Event Handler --
-------------------
function Perl_Player_Pet_OnEvent()
	local func = Perl_Player_Pet_Events[event];
	if (func) then
		func();
--	else
--		DEFAULT_CHAT_FRAME:AddMessage("Perl Classic - Player Pet: Report the following event error to the author: "..event);
	end
end

function Perl_Player_Pet_Events:UNIT_HEALTH()
	if (arg1 == "pet") then
		Perl_Player_Pet_Update_Health();	-- Update health values
	end
end
Perl_Player_Pet_Events.UNIT_MAXHEALTH = Perl_Player_Pet_Events.UNIT_HEALTH;

function Perl_Player_Pet_Events:UNIT_FOCUS()
	if (arg1 == "pet") then
		Perl_Player_Pet_Update_Mana();		-- Update energy/mana/rage values
	end
end
Perl_Player_Pet_Events.UNIT_MAXFOCUS = Perl_Player_Pet_Events.UNIT_FOCUS;
Perl_Player_Pet_Events.UNIT_MANA = Perl_Player_Pet_Events.UNIT_FOCUS;
Perl_Player_Pet_Events.UNIT_MAXMANA = Perl_Player_Pet_Events.UNIT_FOCUS;

function Perl_Player_Pet_Events:UNIT_HAPPINESS()
	Perl_Player_PetFrame_SetHappiness();
end

function Perl_Player_Pet_Events:UNIT_COMBAT()
	if (arg1 == "pet") then
		CombatFeedback_OnCombatEvent(arg2, arg3, arg4, arg5);
	end
end

function Perl_Player_Pet_Events:UNIT_SPELLMISS()
	if (arg1 == "pet") then
		CombatFeedback_OnSpellMissEvent(arg2);
	end
end

function Perl_Player_Pet_Events:UNIT_NAME_UPDATE()
	if (arg1 == "pet") then
		Perl_Player_Pet_NameBarText:SetText(UnitName("pet"));	-- Set name
	end
end

function Perl_Player_Pet_Events:UNIT_AURA()
	if (arg1 == "pet") then
		Perl_Player_Pet_Buff_UpdateAll();	-- Update the buff/debuff list
	end
end

function Perl_Player_Pet_Events:UNIT_PET_EXPERIENCE()
	if (showxp == 1) then
		Perl_Player_Pet_Update_Experience();	-- Set the experience bar info
	end
end

function Perl_Player_Pet_Events:UNIT_LEVEL()
	if (arg1 == "pet") then
		Perl_Player_Pet_LevelBarText:SetText(UnitLevel("pet"));		-- Set Level
	elseif (arg1 == "player") then
		Perl_Player_Pet_ShowXP();
	end
end

function Perl_Player_Pet_Events:UNIT_DISPLAYPOWER()
	if (arg1 == "pet") then
		Perl_Player_Pet_Update_Mana_Bar();	-- What type of energy are we using now?
		Perl_Player_Pet_Update_Mana();		-- Update the energy info immediately
	end
end

function Perl_Player_Pet_Events:PLAYER_PET_CHANGED()
	Perl_Player_Pet_Update_Once();
end

function Perl_Player_Pet_Events:UNIT_PET()
	if (arg1 == "player") then
		Perl_Player_Pet_Update_Once();
	end
end

function Perl_Player_Pet_Events:UNIT_PORTRAIT_UPDATE()
	if (arg1 == "pet") then
		--Perl_Player_Pet_Update_Portrait();	-- Uncomment this line if the line below is ever removed
		Perl_Player_Pet_Update_Once();		-- As of 1.10 the stable is partially broken, this event however is always called after a pet is swapped, so we will just update the whole mod here too to ensure a clean switch.
	end
end
Perl_Player_Pet_Events.UNIT_MODEL_CHANGED = Perl_Player_Pet_Events.UNIT_PORTRAIT_UPDATE;

function Perl_Player_Pet_Events:VARIABLES_LOADED()
	Perl_Player_Pet_Initialize();
end
Perl_Player_Pet_Events.PLAYER_ENTERING_WORLD = Perl_Player_Pet_Events.VARIABLES_LOADED;


-------------------------------
-- Loading Settings Function --
-------------------------------
function Perl_Player_Pet_Initialize()
	-- Check if we loaded the mod already.
	if (Initialized) then
		Perl_Player_Pet_Update_Once();
		Perl_Player_Pet_Set_Scale();		-- Set the scale
		Perl_Player_Pet_Set_Transparency();	-- Set transparency
		return;
	end

	-- Check if a previous exists, if not, enable by default.
	if (type(Perl_Player_Pet_Config[UnitName("player")]) == "table") then
		Perl_Player_Pet_GetVars();
	else
		Perl_Player_Pet_UpdateVars();
	end

	-- Major config options.
	Perl_Player_Pet_Initialize_Frame_Color();
	Perl_Player_Pet_Reset_Buffs();			-- Set correct buff sizes
	Perl_Player_Pet_Set_Window_Layout();		-- Warlocks don't need the happiness frame
	Perl_Player_Pet_Frame:Hide();

	-- Unregister and Hide the Blizzard frames
	Perl_clearBlizzardFrameDisable(PetFrame);

	-- MyAddOns Support
	Perl_Player_Pet_myAddOns_Support();

	-- IFrameManager Support
	if (IFrameManager) then
		Perl_Player_Pet_IFrameManager();
	end

	Initialized = 1;
end

function Perl_Player_Pet_IFrameManager()
	local iface = IFrameManager:Interface();
	function iface:getName(frame)
		return "Perl Player Pet";
	end
	function iface:getBorder(frame)
		local bottom, left, right;
		if (showxp == 0) then
			bottom = 30;
		else
			bottom = 43;
		end
		if (showportrait == 0) then
			left = 0;
		else
			left = 48;
		end
		if (compactmode == 0) then
			right = 0;
		else
			right = -35;
		end
		--return top, right, bottom, left;
		return 0, right, bottom, left;
	end
	IFrameManager:Register(this, iface);
end

function Perl_Player_Pet_Initialize_Frame_Color()
	Perl_Player_Pet_StatsFrame:SetBackdropColor(0, 0, 0, 1);
	Perl_Player_Pet_StatsFrame:SetBackdropBorderColor(0.5, 0.5, 0.5, 1);
	Perl_Player_Pet_LevelFrame:SetBackdropColor(0, 0, 0, 1);
	Perl_Player_Pet_LevelFrame:SetBackdropBorderColor(0.5, 0.5, 0.5, 1);
	Perl_Player_Pet_NameFrame:SetBackdropColor(0, 0, 0, 1);
	Perl_Player_Pet_NameFrame:SetBackdropBorderColor(0.5, 0.5, 0.5, 1);
	Perl_Player_Pet_BuffFrame:SetBackdropColor(0, 0, 0, 1);
	Perl_Player_Pet_BuffFrame:SetBackdropBorderColor(0.5, 0.5, 0.5, 1);
	Perl_Player_Pet_DebuffFrame:SetBackdropColor(0, 0, 0, 1);
	Perl_Player_Pet_DebuffFrame:SetBackdropBorderColor(0.5, 0.5, 0.5, 1);
	Perl_Player_Pet_PortraitFrame:SetBackdropColor(0, 0, 0, 1);
	Perl_Player_Pet_PortraitFrame:SetBackdropBorderColor(0.5, 0.5, 0.5, 1);

	Perl_Player_Pet_HealthBarText:SetTextColor(1, 1, 1, 1);
	Perl_Player_Pet_ManaBarText:SetTextColor(1, 1, 1, 1);
end


-------------------------
-- The Update Function --
-------------------------
function Perl_Player_Pet_Update_Once()
	if (UnitExists("pet")) then
		Perl_Player_Pet_NameBarText:SetText(UnitName("pet"));		-- Set name
		Perl_Player_Pet_LevelBarText:SetText(UnitLevel("pet"));		-- Set Level
		Perl_Player_Pet_Update_Portrait();				-- Set the pet's portrait
		Perl_Player_Pet_Update_Health();				-- Set health
		Perl_Player_Pet_Update_Mana();					-- Set mana values
		Perl_Player_Pet_Update_Mana_Bar();				-- Set the type of mana
		Perl_Player_PetFrame_SetHappiness();				-- Set Happiness
		Perl_Player_Pet_Buff_Position_Update();				-- Set the buff positions
		Perl_Player_Pet_Buff_UpdateAll();				-- Set buff frame
		Perl_Player_Pet_Portrait_Combat_Text();				-- Set the combat text frame
		Perl_Player_Pet_ShowXP();					-- Are we showing the xp bar?
		Perl_Player_Pet_Frame:Show();					-- Display the pet frame
	else
		Perl_Player_Pet_Frame:Hide();
	end
end

function Perl_Player_Pet_Update_Health()
	pethealth = UnitHealth("pet");
	pethealthmax = UnitHealthMax("pet");

	if (UnitIsDead("pet") or UnitIsGhost("pet")) then				-- This prevents negative health
		pethealth = 0;
	end

	if (PCUF_FADEBARS == 1) then
		if (pethealth < Perl_Player_Pet_HealthBar:GetValue()) then
			Perl_Player_Pet_HealthBarFadeBar:SetMinMaxValues(0, pethealthmax);
			Perl_Player_Pet_HealthBarFadeBar:SetValue(Perl_Player_Pet_HealthBar:GetValue());
			Perl_Player_Pet_HealthBarFadeBar:Show();
			Perl_Player_Pet_HealthBar_Fade_Color = 1;
			Perl_Player_Pet_HealthBar_Fade_Time_Elapsed = 0;
			Perl_Player_Pet_HealthBar_Fade_OnUpdate_Frame:Show();
		end
	end

	Perl_Player_Pet_HealthBar:SetMinMaxValues(0, pethealthmax);
	if (PCUF_INVERTBARVALUES == 1) then
		Perl_Player_Pet_HealthBar:SetValue(pethealthmax - pethealth);
	else
		Perl_Player_Pet_HealthBar:SetValue(pethealth);
	end

	if (PCUF_COLORHEALTH == 1) then
--		local playerpethealthpercent = floor(pethealth/pethealthmax*100+0.5);
--		if ((playerpethealthpercent <= 100) and (playerpethealthpercent > 75)) then
--			Perl_Player_Pet_HealthBar:SetStatusBarColor(0, 0.8, 0);
--			Perl_Player_Pet_HealthBarBG:SetStatusBarColor(0, 0.8, 0, 0.25);
--		elseif ((playerpethealthpercent <= 75) and (playerpethealthpercent > 50)) then
--			Perl_Player_Pet_HealthBar:SetStatusBarColor(1, 1, 0);
--			Perl_Player_Pet_HealthBarBG:SetStatusBarColor(1, 1, 0, 0.25);
--		elseif ((playerpethealthpercent <= 50) and (playerpethealthpercent > 25)) then
--			Perl_Player_Pet_HealthBar:SetStatusBarColor(1, 0.5, 0);
--			Perl_Player_Pet_HealthBarBG:SetStatusBarColor(1, 0.5, 0, 0.25);
--		else
--			Perl_Player_Pet_HealthBar:SetStatusBarColor(1, 0, 0);
--			Perl_Player_Pet_HealthBarBG:SetStatusBarColor(1, 0, 0, 0.25);
--		end

		local rawpercent = pethealth / pethealthmax;
		local red, green;

		if(rawpercent > 0.5) then
			red = (1.0 - rawpercent) * 2;
			green = 1.0;
		else
			red = 1.0;
			green = rawpercent * 2;
		end

		Perl_Player_Pet_HealthBar:SetStatusBarColor(red, green, 0, 1);
		Perl_Player_Pet_HealthBarBG:SetStatusBarColor(red, green, 0, 0.25);
	else
		Perl_Player_Pet_HealthBar:SetStatusBarColor(0, 0.8, 0);
		Perl_Player_Pet_HealthBarBG:SetStatusBarColor(0, 0.8, 0, 0.25);
	end

	if (pethealthmax == 100) then
		Perl_Player_Pet_HealthBarText:SetText(pethealth.."%");
	else
		Perl_Player_Pet_HealthBarText:SetText(pethealth.."/"..pethealthmax);
	end
end

function Perl_Player_Pet_Update_Mana()
	petmana = UnitMana("pet");
	petmanamax = UnitManaMax("pet");

	if (UnitIsDead("pet") or UnitIsGhost("pet")) then				-- This prevents negative mana
		petmana = 0;
	end

	if (PCUF_FADEBARS == 1) then
		if (petmana < Perl_Player_Pet_ManaBar:GetValue()) then
			Perl_Player_Pet_ManaBarFadeBar:SetMinMaxValues(0, petmanamax);
			Perl_Player_Pet_ManaBarFadeBar:SetValue(Perl_Player_Pet_ManaBar:GetValue());
			Perl_Player_Pet_ManaBarFadeBar:Show();
			Perl_Player_Pet_ManaBar_Fade_Color = 1;
			Perl_Player_Pet_ManaBar_Fade_Time_Elapsed = 0;
			Perl_Player_Pet_ManaBar_Fade_OnUpdate_Frame:Show();
		end
	end

	Perl_Player_Pet_ManaBar:SetMinMaxValues(0, petmanamax);
	if (PCUF_INVERTBARVALUES == 1) then
		Perl_Player_Pet_ManaBar:SetValue(petmanamax - petmana);
	else
		Perl_Player_Pet_ManaBar:SetValue(petmana);
	end

	if (UnitClass("player") == PERL_LOCALIZED_WARLOCK) then
		Perl_Player_Pet_ManaBarText:SetText(petmana.."/"..petmanamax);
	else
		Perl_Player_Pet_ManaBarText:SetText(petmana);
	end
end

function Perl_Player_Pet_Update_Mana_Bar()
	-- Set mana bar color
	if (UnitPowerType("pet") == 0) then
		Perl_Player_Pet_ManaBar:SetStatusBarColor(0, 0, 1, 1);
		Perl_Player_Pet_ManaBarBG:SetStatusBarColor(0, 0, 1, 0.25);
	elseif (UnitPowerType("pet") == 2) then
		Perl_Player_Pet_ManaBar:SetStatusBarColor(1, 0.5, 0, 1);
		Perl_Player_Pet_ManaBarBG:SetStatusBarColor(1, 0.5, 0, 0.25);
	end
end

function Perl_Player_PetFrame_SetHappiness()
	happiness = GetPetHappiness();

	if (happiness == 1) then
		Perl_Player_PetHappinessTexture:SetTexCoord(0.375, 0.5625, 0, 0.359375);
	elseif (happiness == 2) then
		Perl_Player_PetHappinessTexture:SetTexCoord(0.1875, 0.375, 0, 0.359375);
	elseif (happiness == 3) then
		Perl_Player_PetHappinessTexture:SetTexCoord(0, 0.1875, 0, 0.359375);
	end
end

function Perl_Player_Pet_ShowXP()
	if (showxp == 0) then
		Perl_Player_Pet_XPBar:Hide();
		Perl_Player_Pet_XPBarBG:Hide();
		Perl_Player_Pet_XPBarText:SetText();
		Perl_Player_Pet_StatsFrame:SetHeight(34);
		Perl_Player_Pet_StatsFrame_CastClickOverlay:SetHeight(34);
	else
		if (UnitLevel("pet") == UnitLevel("player")) then
			Perl_Player_Pet_XPBar:Hide();
			Perl_Player_Pet_XPBarBG:Hide();
			Perl_Player_Pet_XPBarText:SetText();
			Perl_Player_Pet_StatsFrame:SetHeight(34);
			Perl_Player_Pet_StatsFrame_CastClickOverlay:SetHeight(34);
		else
			Perl_Player_Pet_XPBar:Show();
			Perl_Player_Pet_XPBarBG:Show();
			Perl_Player_Pet_StatsFrame:SetHeight(47);
			Perl_Player_Pet_StatsFrame_CastClickOverlay:SetHeight(47);
			Perl_Player_Pet_Update_Experience();
		end
	end
end

function Perl_Player_Pet_Update_Experience()
	-- XP Bar stuff
	playerpetxp, playerpetxpmax = GetPetExperience();

	Perl_Player_Pet_XPBar:SetMinMaxValues(0, playerpetxpmax);
	Perl_Player_Pet_XPBar:SetValue(playerpetxp);

	-- Set xp text
	xptext = playerpetxp.."/"..playerpetxpmax;

	Perl_Player_Pet_XPBar:SetStatusBarColor(0, 0.6, 0.6, 1);
	Perl_Player_Pet_XPBarBG:SetStatusBarColor(0, 0.6, 0.6, 0.25);
	Perl_Player_Pet_XPBarText:SetText(xptext);
end

function Perl_Player_Pet_Update_Portrait()
	if (showportrait == 1) then
		Perl_Player_Pet_PortraitFrame:Show();							-- Show the main portrait frame

		if (threedportrait == 0) then
			SetPortraitTexture(Perl_Player_Pet_Portrait, "pet");				-- Load the correct 2d graphic
			Perl_Player_Pet_PortraitFrame_PetModel:Hide();					-- Hide the 3d graphic
			Perl_Player_Pet_Portrait:Show();						-- Show the 2d graphic
		else
			if UnitIsVisible("pet") then
				Perl_Player_Pet_PortraitFrame_PetModel:SetUnit("pet");			-- Load the correct 3d graphic
				Perl_Player_Pet_Portrait:Hide();					-- Hide the 2d graphic
				Perl_Player_Pet_PortraitFrame_PetModel:Show();				-- Show the 3d graphic
				Perl_Player_Pet_PortraitFrame_PetModel:SetCamera(0);
			else
				SetPortraitTexture(Perl_Player_Pet_Portrait, "pet");			-- Load the correct 2d graphic
				Perl_Player_Pet_PortraitFrame_PetModel:Hide();				-- Hide the 3d graphic
				Perl_Player_Pet_Portrait:Show();					-- Show the 2d graphic
			end
		end

	else
		Perl_Player_Pet_PortraitFrame:Hide();							-- Hide the frame and 2d/3d portion
	end
end

function Perl_Player_Pet_Portrait_Combat_Text()
	if (portraitcombattext == 1) then
		Perl_Player_Pet_PortraitTextFrame:Show();
	else
		Perl_Player_Pet_PortraitTextFrame:Hide();
	end
end

function Perl_Player_Pet_Set_Window_Layout()
	if (UnitClass("player") == PERL_LOCALIZED_WARLOCK) then
		if (compactmode == 0) then
			Perl_Player_Pet_LevelFrame:Hide();
			Perl_Player_Pet_StatsFrame:SetPoint("TOPLEFT", "Perl_Player_Pet_NameFrame", "BOTTOMLEFT", 0, 5);
			Perl_Player_Pet_NameFrame:SetWidth(170);
			Perl_Player_Pet_NameFrame_CastClickOverlay:SetWidth(170);
			Perl_Player_Pet_StatsFrame:SetWidth(170);
			Perl_Player_Pet_StatsFrame_CastClickOverlay:SetWidth(170);
			Perl_Player_Pet_HealthBar:SetWidth(158);
			Perl_Player_Pet_HealthBarFadeBar:SetWidth(158);
			Perl_Player_Pet_HealthBarBG:SetWidth(158);
			Perl_Player_Pet_ManaBar:SetWidth(158);
			Perl_Player_Pet_ManaBarFadeBar:SetWidth(158);
			Perl_Player_Pet_ManaBarBG:SetWidth(158);
			Perl_Player_Pet_XPBar:SetWidth(158);
			Perl_Player_Pet_XPBarBG:SetWidth(158);
		else
			Perl_Player_Pet_LevelFrame:Hide();
			Perl_Player_Pet_StatsFrame:SetPoint("TOPLEFT", "Perl_Player_Pet_NameFrame", "BOTTOMLEFT", 0, 5);
			Perl_Player_Pet_NameFrame:SetWidth(135);
			Perl_Player_Pet_NameFrame_CastClickOverlay:SetWidth(135);
			Perl_Player_Pet_StatsFrame:SetWidth(135);
			Perl_Player_Pet_StatsFrame_CastClickOverlay:SetWidth(135);
			Perl_Player_Pet_HealthBar:SetWidth(123);
			Perl_Player_Pet_HealthBarFadeBar:SetWidth(123);
			Perl_Player_Pet_HealthBarBG:SetWidth(123);
			Perl_Player_Pet_ManaBar:SetWidth(123);
			Perl_Player_Pet_ManaBarFadeBar:SetWidth(123);
			Perl_Player_Pet_ManaBarBG:SetWidth(123);
			Perl_Player_Pet_XPBar:SetWidth(123);
			Perl_Player_Pet_XPBarBG:SetWidth(123);
		end
	else	-- Hunter
		if (compactmode == 0) then
			Perl_Player_Pet_LevelFrame:Show();
			Perl_Player_Pet_StatsFrame:SetPoint("TOPLEFT", "Perl_Player_Pet_NameFrame", "BOTTOMLEFT", 25, 5);
			Perl_Player_Pet_NameFrame:SetWidth(170);
			Perl_Player_Pet_NameFrame_CastClickOverlay:SetWidth(170);
			Perl_Player_Pet_StatsFrame:SetWidth(145);
			Perl_Player_Pet_StatsFrame_CastClickOverlay:SetWidth(145);
			Perl_Player_Pet_HealthBar:SetWidth(133);
			Perl_Player_Pet_HealthBarFadeBar:SetWidth(133);
			Perl_Player_Pet_HealthBarBG:SetWidth(133);
			Perl_Player_Pet_ManaBar:SetWidth(133);
			Perl_Player_Pet_ManaBarFadeBar:SetWidth(133);
			Perl_Player_Pet_ManaBarBG:SetWidth(133);
			Perl_Player_Pet_XPBar:SetWidth(133);
			Perl_Player_Pet_XPBarBG:SetWidth(133);
		else
			Perl_Player_Pet_LevelFrame:Show();
			Perl_Player_Pet_StatsFrame:SetPoint("TOPLEFT", "Perl_Player_Pet_NameFrame", "BOTTOMLEFT", 25, 5);
			Perl_Player_Pet_NameFrame:SetWidth(135);
			Perl_Player_Pet_NameFrame_CastClickOverlay:SetWidth(135);
			Perl_Player_Pet_StatsFrame:SetWidth(110);
			Perl_Player_Pet_StatsFrame_CastClickOverlay:SetWidth(110);
			Perl_Player_Pet_HealthBar:SetWidth(98);
			Perl_Player_Pet_HealthBarFadeBar:SetWidth(98);
			Perl_Player_Pet_HealthBarBG:SetWidth(98);
			Perl_Player_Pet_ManaBar:SetWidth(98);
			Perl_Player_Pet_ManaBarFadeBar:SetWidth(98);
			Perl_Player_Pet_ManaBarBG:SetWidth(98);
			Perl_Player_Pet_XPBar:SetWidth(98);
			Perl_Player_Pet_XPBarBG:SetWidth(98);
		end
	end

	if (hidename == 1) then
		Perl_Player_Pet_NameFrame:Hide();
	else
		Perl_Player_Pet_NameFrame:Show();
	end
end


------------------------
-- Fade Bar Functions --
------------------------
function Perl_Player_Pet_HealthBar_Fade(arg1)
	Perl_Player_Pet_HealthBar_Fade_Color = Perl_Player_Pet_HealthBar_Fade_Color - arg1;
	Perl_Player_Pet_HealthBar_Fade_Time_Elapsed = Perl_Player_Pet_HealthBar_Fade_Time_Elapsed + arg1;

	Perl_Player_Pet_HealthBarFadeBar:SetStatusBarColor(0, Perl_Player_Pet_HealthBar_Fade_Color, 0, Perl_Player_Pet_HealthBar_Fade_Color);

	if (Perl_Player_Pet_HealthBar_Fade_Time_Elapsed > 1) then
		Perl_Player_Pet_HealthBar_Fade_Color = 1;
		Perl_Player_Pet_HealthBar_Fade_Time_Elapsed = 0;
		Perl_Player_Pet_HealthBarFadeBar:Hide();
		Perl_Player_Pet_HealthBar_Fade_OnUpdate_Frame:Hide();
	end
end

function Perl_Player_Pet_ManaBar_Fade(arg1)
	Perl_Player_Pet_ManaBar_Fade_Color = Perl_Player_Pet_ManaBar_Fade_Color - arg1;
	Perl_Player_Pet_ManaBar_Fade_Time_Elapsed = Perl_Player_Pet_ManaBar_Fade_Time_Elapsed + arg1;

	if (UnitPowerType("pet") == 0) then
		Perl_Player_Pet_ManaBarFadeBar:SetStatusBarColor(0, 0, Perl_Player_Pet_ManaBar_Fade_Color, Perl_Player_Pet_ManaBar_Fade_Color);
	elseif (UnitPowerType("pet") == 2) then
		Perl_Player_Pet_ManaBarFadeBar:SetStatusBarColor(Perl_Player_Pet_ManaBar_Fade_Color, (Perl_Player_Pet_ManaBar_Fade_Color-0.5), 0, Perl_Player_Pet_ManaBar_Fade_Color);
	end

	if (Perl_Player_Pet_ManaBar_Fade_Time_Elapsed > 1) then
		Perl_Player_Pet_ManaBar_Fade_Color = 1;
		Perl_Player_Pet_ManaBar_Fade_Time_Elapsed = 0;
		Perl_Player_Pet_ManaBarFadeBar:Hide();
		Perl_Player_Pet_ManaBar_Fade_OnUpdate_Frame:Hide();
	end
end


--------------------------
-- GUI Config Functions --
--------------------------
function Perl_Player_Pet_Set_Buffs(newbuffnumber)
	if (newbuffnumber == nil) then
		newbuffnumber = 16;
	end
	numpetbuffsshown = newbuffnumber;
	Perl_Player_Pet_UpdateVars();
	Perl_Player_Pet_Reset_Buffs();		-- Reset the buff icons and set the size
	Perl_Player_Pet_Buff_UpdateAll();	-- Repopulate the buff icons
end

function Perl_Player_Pet_Set_Debuffs(newdebuffnumber)
	if (newdebuffnumber == nil) then
		newdebuffnumber = 16;
	end
	numpetdebuffsshown = newdebuffnumber;
	Perl_Player_Pet_UpdateVars();
	Perl_Player_Pet_Reset_Buffs();		-- Reset the buff icons and set the size
	Perl_Player_Pet_Buff_UpdateAll();	-- Repopulate the buff icons
end

function Perl_Player_Pet_Set_Buff_Location(newvalue)
	if (newvalue ~= nil) then
		bufflocation = newvalue;
	end
	Perl_Player_Pet_UpdateVars();
	Perl_Player_Pet_Buff_Position_Update();	-- Set the buff positions
	Perl_Player_Pet_Reset_Buffs();		-- Reset the buff icons and set the size
	Perl_Player_Pet_Buff_UpdateAll();	-- Repopulate the buff icons
end

function Perl_Player_Pet_Set_Debuff_Location(newvalue)
	if (newvalue ~= nil) then
		debufflocation = newvalue;
	end
	Perl_Player_Pet_UpdateVars();
	Perl_Player_Pet_Buff_Position_Update();	-- Set the buff positions
	Perl_Player_Pet_Reset_Buffs();		-- Reset the buff icons and set the size
	Perl_Player_Pet_Buff_UpdateAll();	-- Repopulate the buff icons
end

function Perl_Player_Pet_Set_Buff_Size(newvalue)
	if (newvalue ~= nil) then
		buffsize = newvalue;
	end
	Perl_Player_Pet_UpdateVars();
	Perl_Player_Pet_Buff_Position_Update();	-- Set the buff positions
	Perl_Player_Pet_Reset_Buffs();		-- Reset the buff icons and set the size
	Perl_Player_Pet_Buff_UpdateAll();	-- Repopulate the buff icons
end

function Perl_Player_Pet_Set_Debuff_Size(newvalue)
	if (newvalue ~= nil) then
		debuffsize = newvalue;
	end
	Perl_Player_Pet_UpdateVars();
	Perl_Player_Pet_Buff_Position_Update();	-- Set the buff positions
	Perl_Player_Pet_Reset_Buffs();		-- Reset the buff icons and set the size
	Perl_Player_Pet_Buff_UpdateAll();	-- Repopulate the buff icons
end

function Perl_Player_Pet_Set_Compact_Mode(newvalue)
	compactmode = newvalue;
	Perl_Player_Pet_UpdateVars();
	Perl_Player_Pet_Buff_Position_Update();	-- Set the buff positions
	Perl_Player_Pet_Reset_Buffs();		-- Reset the buff icons and set the size
	Perl_Player_Pet_Buff_UpdateAll();	-- Repopulate the buff icons
	Perl_Player_Pet_Set_Window_Layout();
end

function Perl_Player_Pet_Set_Hide_Name(newvalue)
	hidename = newvalue;
	Perl_Player_Pet_UpdateVars();
	Perl_Player_Pet_Buff_Position_Update();	-- Set the buff positions
	Perl_Player_Pet_Reset_Buffs();		-- Reset the buff icons and set the size
	Perl_Player_Pet_Buff_UpdateAll();	-- Repopulate the buff icons
	Perl_Player_Pet_Set_Window_Layout();
end

function Perl_Player_Pet_Set_ShowXP(newvalue)
	showxp = newvalue;
	Perl_Player_Pet_UpdateVars();
	Perl_Player_Pet_ShowXP();
end

function Perl_Player_Pet_Set_Lock(newvalue)
	locked = newvalue;
	Perl_Player_Pet_UpdateVars();
end

function Perl_Player_Pet_Set_Portrait(newvalue)
	showportrait = newvalue;
	Perl_Player_Pet_UpdateVars();
	Perl_Player_Pet_Update_Portrait();
end

function Perl_Player_Pet_Set_3D_Portrait(newvalue)
	threedportrait = newvalue;
	Perl_Player_Pet_UpdateVars();
	Perl_Player_Pet_Update_Portrait();
end

function Perl_Player_Pet_Set_Portrait_Combat_Text(newvalue)
	portraitcombattext = newvalue;
	Perl_Player_Pet_UpdateVars();
	Perl_Player_Pet_Portrait_Combat_Text();
end

function Perl_Player_Pet_Set_Scale(number)
	local unsavedscale;
	if (number ~= nil) then
		scale = (number / 100);					-- convert the user input to a wow acceptable value
	end
	unsavedscale = 1 - UIParent:GetEffectiveScale() + scale;	-- run it through the scaling formula introduced in 1.9
	Perl_Player_Pet_Frame:SetScale(unsavedscale);
	Perl_Player_Pet_UpdateVars();
end

function Perl_Player_Pet_Set_Transparency(number)
	if (number ~= nil) then
		transparency = (number / 100);				-- convert the user input to a wow acceptable value
	end
	Perl_Player_Pet_Frame:SetAlpha(transparency);
	Perl_Player_Pet_UpdateVars();
end


------------------------------
-- Saved Variable Functions --
------------------------------
function Perl_Player_Pet_GetVars(name, updateflag)
	if (name == nil) then
		name = UnitName("player");
	end

	locked = Perl_Player_Pet_Config[name]["Locked"];
	showxp = Perl_Player_Pet_Config[name]["ShowXP"];
	scale = Perl_Player_Pet_Config[name]["Scale"];
	numpetbuffsshown = Perl_Player_Pet_Config[name]["Buffs"];
	numpetdebuffsshown = Perl_Player_Pet_Config[name]["Debuffs"];
	transparency = Perl_Player_Pet_Config[name]["Transparency"];
	bufflocation = Perl_Player_Pet_Config[name]["BuffLocation"];
	debufflocation = Perl_Player_Pet_Config[name]["DebuffLocation"];
	buffsize = Perl_Player_Pet_Config[name]["BuffSize"];
	debuffsize = Perl_Player_Pet_Config[name]["DebuffSize"];
	showportrait = Perl_Player_Pet_Config[name]["ShowPortrait"];
	threedportrait = Perl_Player_Pet_Config[name]["ThreeDPortrait"];
	portraitcombattext = Perl_Player_Pet_Config[name]["PortraitCombatText"];
	compactmode = Perl_Player_Pet_Config[name]["CompactMode"];
	hidename = Perl_Player_Pet_Config[name]["HideName"];

	if (locked == nil) then
		locked = 0;
	end
	if (showxp == nil) then
		showxp = 0;
	end
	if (scale == nil) then
		scale = 1;
	end
	if (numpetbuffsshown == nil) then
		numpetbuffsshown = 16;
	end
	if (numpetdebuffsshown == nil) then
		numpetdebuffsshown = 16;
	end
	if (transparency == nil) then
		transparency = 1;
	end
	if (bufflocation == nil) then
		bufflocation = 4;
	end
	if (debufflocation == nil) then
		debufflocation = 5;
	end
	if (buffsize == nil) then
		buffsize = 12;
	end
	if (debuffsize == nil) then
		debuffsize = 12;
	end
	if (showportrait == nil) then
		showportrait = 0;
	end
	if (threedportrait == nil) then
		threedportrait = 0;
	end
	if (portraitcombattext == nil) then
		portraitcombattext = 0;
	end
	if (compactmode == nil) then
		compactmode = 0;
	end
	if (hidename == nil) then
		hidename = 0;
	end

	if (updateflag == 1) then
		-- Save the new values
		Perl_Player_Pet_UpdateVars();

		-- Call any code we need to activate them
		Perl_Player_Pet_Reset_Buffs();		-- Reset the buff icons
		Perl_Player_Pet_Buff_UpdateAll();	-- Repopulate the buff icons
		Perl_Player_Pet_Update_Health();	-- Update the health in case progrssive health color was set
		Perl_Player_Pet_Update_Portrait();
		Perl_Player_Pet_Portrait_Combat_Text();
		Perl_Player_Pet_Set_Window_Layout();
		Perl_Player_Pet_Set_Scale();		-- Set the scale
		Perl_Player_Pet_Set_Transparency();	-- Set the transparency
		return;
	end

	local vars = {
		["locked"] = locked,
		["showxp"] = showxp,
		["scale"] = scale,
		["numpetbuffsshown"] = numpetbuffsshown,
		["numpetdebuffsshown"] = numpetdebuffsshown,
		["transparency"] = transparency,
		["bufflocation"] = bufflocation,
		["debufflocation"] = debufflocation,
		["buffsize"] = buffsize,
		["debuffsize"] = debuffsize,
		["showportrait"] = showportrait,
		["threedportrait"] = threedportrait,
		["portraitcombattext"] = portraitcombattext,
		["compactmode"] = compactmode,
		["hidename"] = hidename,
	}
	return vars;
end

function Perl_Player_Pet_UpdateVars(vartable)
	if (vartable ~= nil) then
		-- Sanity checks in case you use a load from an old version
		if (vartable["Global Settings"] ~= nil) then
			if (vartable["Global Settings"]["Locked"] ~= nil) then
				locked = vartable["Global Settings"]["Locked"];
			else
				locked = nil;
			end
			if (vartable["Global Settings"]["ShowXP"] ~= nil) then
				showxp = vartable["Global Settings"]["ShowXP"];
			else
				showxp = nil;
			end
			if (vartable["Global Settings"]["Scale"] ~= nil) then
				scale = vartable["Global Settings"]["Scale"];
			else
				scale = nil;
			end
			if (vartable["Global Settings"]["Buffs"] ~= nil) then
				numpetbuffsshown = vartable["Global Settings"]["Buffs"];
			else
				numpetbuffsshown = nil;
			end
			if (vartable["Global Settings"]["Debuffs"] ~= nil) then
				numpetdebuffsshown = vartable["Global Settings"]["Debuffs"];
			else
				numpetdebuffsshown = nil;
			end
			if (vartable["Global Settings"]["Transparency"] ~= nil) then
				transparency = vartable["Global Settings"]["Transparency"];
			else
				transparency = nil;
			end
			if (vartable["Global Settings"]["BuffLocation"] ~= nil) then
				bufflocation = vartable["Global Settings"]["BuffLocation"];
			else
				bufflocation = nil;
			end
			if (vartable["Global Settings"]["DebuffLocation"] ~= nil) then
				debufflocation = vartable["Global Settings"]["DebuffLocation"];
			else
				debufflocation = nil;
			end
			if (vartable["Global Settings"]["BuffSize"] ~= nil) then
				buffsize = vartable["Global Settings"]["BuffSize"];
			else
				buffsize = nil;
			end
			if (vartable["Global Settings"]["DebuffSize"] ~= nil) then
				debuffsize = vartable["Global Settings"]["DebuffSize"];
			else
				debuffsize = nil;
			end
			if (vartable["Global Settings"]["ShowPortrait"] ~= nil) then
				showportrait = vartable["Global Settings"]["ShowPortrait"];
			else
				showportrait = nil;
			end
			if (vartable["Global Settings"]["ThreeDPortrait"] ~= nil) then
				threedportrait = vartable["Global Settings"]["ThreeDPortrait"];
			else
				threedportrait = nil;
			end
			if (vartable["Global Settings"]["PortraitCombatText"] ~= nil) then
				portraitcombattext = vartable["Global Settings"]["PortraitCombatText"];
			else
				portraitcombattext = nil;
			end
			if (vartable["Global Settings"]["CompactMode"] ~= nil) then
				compactmode = vartable["Global Settings"]["CompactMode"];
			else
				compactmode = nil;
			end
			if (vartable["Global Settings"]["HideName"] ~= nil) then
				hidename = vartable["Global Settings"]["HideName"];
			else
				hidename = nil;
			end
		end

		-- Set the new values if any new values were found, same defaults as above
		if (locked == nil) then
			locked = 0;
		end
		if (showxp == nil) then
			showxp = 0;
		end
		if (scale == nil) then
			scale = 1;
		end
		if (numpetbuffsshown == nil) then
			numpetbuffsshown = 16;
		end
		if (numpetdebuffsshown == nil) then
			numpetdebuffsshown = 16;
		end
		if (transparency == nil) then
			transparency = 1;
		end
		if (bufflocation == nil) then
			bufflocation = 4;
		end
		if (debufflocation == nil) then
			debufflocation = 5;
		end
		if (buffsize == nil) then
			buffsize = 12;
		end
		if (debuffsize == nil) then
			debuffsize = 12;
		end
		if (showportrait == nil) then
			showportrait = 0;
		end
		if (threedportrait == nil) then
			threedportrait = 0;
		end
		if (portraitcombattext == nil) then
			portraitcombattext = 0;
		end
		if (compactmode == nil) then
			compactmode = 0;
		end
		if (hidename == nil) then
			hidename = 0;
		end

		-- Call any code we need to activate them
		Perl_Player_Pet_Reset_Buffs();		-- Reset the buff icons
		Perl_Player_Pet_Buff_UpdateAll();	-- Repopulate the buff icons
		Perl_Player_Pet_Update_Health();	-- Update the health in case progrssive health color was set
		Perl_Player_Pet_Update_Portrait();
		Perl_Player_Pet_Portrait_Combat_Text();
		Perl_Player_Pet_Set_Window_Layout();
		Perl_Player_Pet_Set_Scale();		-- Set the scale
		Perl_Player_Pet_Set_Transparency();	-- Set the transparency
	end

	-- IFrameManager Support
	if (IFrameManager) then
		IFrameManager:Refresh();
	end

	Perl_Player_Pet_Config[UnitName("player")] = {
		["Locked"] = locked,
		["ShowXP"] = showxp,
		["Scale"] = scale,
		["Buffs"] = numpetbuffsshown,
		["Debuffs"] = numpetdebuffsshown,
		["Transparency"] = transparency,
		["BuffLocation"] = bufflocation,
		["DebuffLocation"] = debufflocation,
		["BuffSize"] = buffsize,
		["DebuffSize"] = debuffsize,
		["ShowPortrait"] = showportrait,
		["ThreeDPortrait"] = threedportrait,
		["PortraitCombatText"] = portraitcombattext,
		["CompactMode"] = compactmode,
		["HideName"] = hidename,
	};
end


--------------------
-- Buff Functions --
--------------------
function Perl_Player_Pet_Buff_UpdateAll()
	if (UnitName("pet")) then
		local button, buffCount, buffTexture, buffApplications, color, debuffType;				-- Variables for both buffs and debuffs (yes, I'm using buff names for debuffs, wanna fight about it?)

		for buffnum=1,numpetbuffsshown do									-- Start main buff loop
			buffTexture, buffApplications = UnitBuff("pet", buffnum);					-- Get the texture and buff stacking information if any
			button = getglobal("Perl_Player_Pet_Buff"..buffnum);						-- Create the main icon for the buff
			if (buffTexture) then										-- If there is a valid texture, proceed with buff icon creation
				getglobal(button:GetName().."Icon"):SetTexture(buffTexture);				-- Set the texture
				getglobal(button:GetName().."DebuffBorder"):Hide();					-- Hide the debuff border
				buffCount = getglobal(button:GetName().."Count");					-- Declare the buff counting text variable
				if (buffApplications > 1) then
					buffCount:SetText(buffApplications);						-- Set the text to the number of applications if greater than 0
					buffCount:Show();								-- Show the text
				else
					buffCount:Hide();								-- Hide the text if equal to 0
				end
				button:Show();										-- Show the final buff icon
			else
				button:Hide();										-- Hide the icon since there isn't a buff in this position
			end
		end													-- End main buff loop

		for debuffnum=1,numpetdebuffsshown do
			buffTexture, buffApplications, debuffType = UnitDebuff("pet", debuffnum);			-- Get the texture and debuff stacking information if any
			button = getglobal("Perl_Player_Pet_Debuff"..debuffnum);					-- Create the main icon for the debuff
			if (buffTexture) then										-- If there is a valid texture, proceed with debuff icon creation
				getglobal(button:GetName().."Icon"):SetTexture(buffTexture);				-- Set the texture
				if (debuffType) then
					color = DebuffTypeColor[debuffType];
				else
					color = DebuffTypeColor[PERL_LOCALIZED_BUFF_NONE];
				end
				getglobal(button:GetName().."DebuffBorder"):SetVertexColor(color.r, color.g, color.b);	-- Set the debuff border color
				getglobal(button:GetName().."DebuffBorder"):Show();					-- Show the debuff border
				buffCount = getglobal(button:GetName().."Count");					-- Declare the debuff counting text variable
				if (buffApplications > 1) then
					buffCount:SetText(buffApplications);						-- Set the text to the number of applications if greater than 0
					buffCount:Show();								-- Show the text
				else
					buffCount:Hide();								-- Hide the text if equal to 0
				end
				button:Show();										-- Show the final debuff icon
			else
				button:Hide();										-- Hide the icon since there isn't a debuff in this position
			end
		end													-- End main debuff loop
	end
end

function Perl_Player_Pet_Buff_Position_Update()
	Perl_Player_Pet_Buff1:ClearAllPoints();
	if (bufflocation == 1) then
		if (hidename == 0) then
			Perl_Player_Pet_Buff1:SetPoint("BOTTOMLEFT", "Perl_Player_Pet_NameFrame", "TOPLEFT", 5, 15);
		else
			if (UnitClass("player") == PERL_LOCALIZED_HUNTER) then
				Perl_Player_Pet_Buff1:SetPoint("BOTTOMLEFT", "Perl_Player_Pet_LevelFrame", "TOPLEFT", 5, 15);
			else
				Perl_Player_Pet_Buff1:SetPoint("BOTTOMLEFT", "Perl_Player_Pet_StatsFrame", "TOPLEFT", 5, 15);
			end
		end
	elseif (bufflocation == 2) then
		if (hidename == 0) then
			Perl_Player_Pet_Buff1:SetPoint("BOTTOMLEFT", "Perl_Player_Pet_NameFrame", "TOPLEFT", 5, 0);
		else
			if (UnitClass("player") == PERL_LOCALIZED_HUNTER) then
				Perl_Player_Pet_Buff1:SetPoint("BOTTOMLEFT", "Perl_Player_Pet_LevelFrame", "TOPLEFT", 5, 0);
			else
				Perl_Player_Pet_Buff1:SetPoint("BOTTOMLEFT", "Perl_Player_Pet_StatsFrame", "TOPLEFT", 5, 0);
			end
		end
	elseif (bufflocation == 3) then
		Perl_Player_Pet_Buff1:SetPoint("TOPLEFT", "Perl_Player_Pet_NameFrame", "TOPRIGHT", 0, -3);
	elseif (bufflocation == 4) then
		Perl_Player_Pet_Buff1:SetPoint("TOPLEFT", "Perl_Player_Pet_StatsFrame", "TOPRIGHT", 0, -5);
	elseif (bufflocation == 5) then
		Perl_Player_Pet_Buff1:SetPoint("TOPLEFT", "Perl_Player_Pet_StatsFrame", "TOPRIGHT", 0, -20);
	elseif (bufflocation == 6) then
		if (UnitClass("player") == PERL_LOCALIZED_HUNTER) then
			Perl_Player_Pet_Buff1:SetPoint("TOPLEFT", "Perl_Player_Pet_StatsFrame", "BOTTOMLEFT", -20, 0);
		else
			Perl_Player_Pet_Buff1:SetPoint("TOPLEFT", "Perl_Player_Pet_LevelFrame", "BOTTOMLEFT", 5, 0);
		end
	elseif (bufflocation == 7) then
		if (UnitClass("player") == PERL_LOCALIZED_HUNTER) then
			Perl_Player_Pet_Buff1:SetPoint("TOPLEFT", "Perl_Player_Pet_StatsFrame", "BOTTOMLEFT", -20, -15);
		else
			Perl_Player_Pet_Buff1:SetPoint("TOPLEFT", "Perl_Player_Pet_LevelFrame", "BOTTOMLEFT", 5, -15);
		end
	end

	Perl_Player_Pet_Debuff1:ClearAllPoints();
	if (debufflocation == 3) then
		Perl_Player_Pet_Debuff1:SetPoint("TOPLEFT", "Perl_Player_Pet_NameFrame", "TOPRIGHT", 0, -3);
	elseif (debufflocation == 4) then
		Perl_Player_Pet_Debuff1:SetPoint("TOPLEFT", "Perl_Player_Pet_StatsFrame", "TOPRIGHT", 0, -5);
	elseif (debufflocation == 5) then
		Perl_Player_Pet_Debuff1:SetPoint("TOPLEFT", "Perl_Player_Pet_StatsFrame", "TOPRIGHT", 0, -20);
	elseif (debufflocation == 6) then
		if (UnitClass("player") == PERL_LOCALIZED_HUNTER) then
			Perl_Player_Pet_Debuff1:SetPoint("TOPLEFT", "Perl_Player_Pet_StatsFrame", "BOTTOMLEFT", -20, 0);
		else
			Perl_Player_Pet_Debuff1:SetPoint("TOPLEFT", "Perl_Player_Pet_LevelFrame", "BOTTOMLEFT", 5, 0);
		end
	elseif (debufflocation == 7) then
		if (UnitClass("player") == PERL_LOCALIZED_HUNTER) then
			Perl_Player_Pet_Debuff1:SetPoint("TOPLEFT", "Perl_Player_Pet_StatsFrame", "BOTTOMLEFT", -20, -15);
		else
			Perl_Player_Pet_Debuff1:SetPoint("TOPLEFT", "Perl_Player_Pet_LevelFrame", "BOTTOMLEFT", 5, -15);
		end
	end
end

function Perl_Player_Pet_Reset_Buffs()
	local button, debuff, icon;

	for buffnum=1,16 do
		button = getglobal("Perl_Player_Pet_Buff"..buffnum);
		icon = getglobal(button:GetName().."Icon");
		debuff = getglobal(button:GetName().."DebuffBorder");
		button:SetHeight(buffsize);
		button:SetWidth(buffsize);
		icon:SetHeight(buffsize);
		icon:SetWidth(buffsize);
		debuff:SetHeight(buffsize);
		debuff:SetWidth(buffsize);
		button:Hide();

		button = getglobal("Perl_Player_Pet_Debuff"..buffnum);
		icon = getglobal(button:GetName().."Icon");
		debuff = getglobal(button:GetName().."DebuffBorder");
		button:SetHeight(debuffsize);
		button:SetWidth(debuffsize);
		icon:SetHeight(debuffsize);
		icon:SetWidth(debuffsize);
		debuff:SetHeight(debuffsize);
		debuff:SetWidth(debuffsize);
		button:Hide();
	end
end

function Perl_Player_Pet_SetBuffTooltip()
	GameTooltip:SetOwner(this, "ANCHOR_BOTTOMRIGHT");
	if (this:GetID() > 16) then
		GameTooltip:SetUnitDebuff("pet", this:GetID()-16);
	else
		GameTooltip:SetUnitBuff("pet", this:GetID());
	end
end


--------------------
-- Click Handlers --
--------------------
function Perl_Player_Pet_DropDown_OnLoad()
	UIDropDownMenu_Initialize(this, Perl_Player_Pet_DropDown_Initialize, "MENU");
end

function Perl_Player_Pet_DropDown_Initialize()
	UnitPopup_ShowMenu(Perl_Player_Pet_DropDown, "PET", "pet");
end

function Perl_Player_Pet_MouseClick(button)
	if (Perl_Custom_ClickFunction) then				-- Check to see if someone defined a custom click function
		if (Perl_Custom_ClickFunction(button, "pet")) then	-- If the function returns true, then we return
			return;
		end
	end								-- Otherwise, it did nothing, so take default action

	if (PCUF_CASTPARTYSUPPORT == 1) then
		if (not string.find(GetMouseFocus():GetName(), "Name") or PCUF_NAMEFRAMECLICKCAST == 1) then
			if (CastPartyConfig) then
				CastParty.Event.OnClickByUnit(button, "pet");
				return;
			elseif (Genesis_MouseHeal and Genesis_MouseHeal("pet", button)) then
				return;
			elseif (CH_Config) then
				if (CH_Config.PCUFEnabled) then
					CH_UnitClicked("pet", button);
					return;
				end
			elseif (SmartHeal) then
				if (SmartHeal.Loaded and SmartHeal:getConfig("enable", "clickmode")) then
					local KeyDownType = SmartHeal:GetClickHealButton();
					if(KeyDownType and KeyDownType ~= "undetermined") then
						SmartHeal:ClickHeal(KeyDownType..button, "pet");
					else
						SmartHeal:DefaultClick(button, "pet");
					end
					return;
				end
			end
		end
	end

	if (button == "LeftButton") then
		if (SpellIsTargeting()) then
			SpellTargetUnit("pet");
		elseif (CursorHasItem()) then
			DropItemOnUnit("pet");
		else
			TargetUnit("pet");
		end
		return;
	end

	if (button == "RightButton") then
		if (SpellIsTargeting()) then
			SpellStopTargeting();
			return;
		end
	end

	if (not (IsAltKeyDown() or IsControlKeyDown() or IsShiftKeyDown())) then
		ToggleDropDownMenu(1, nil, Perl_Player_Pet_DropDown, "Perl_Player_Pet_NameFrame", 40, 0);
	end
end

function Perl_Player_Pet_DragStart(button)
	if (button == "LeftButton" and locked == 0) then
		Perl_Player_Pet_Frame:StartMoving();
	end
end

function Perl_Player_Pet_DragStop(button)
	Perl_Player_Pet_Frame:StopMovingOrSizing();
end


----------------------
-- myAddOns Support --
----------------------
function Perl_Player_Pet_myAddOns_Support()
	-- Register the addon in myAddOns
	if(myAddOnsFrame_Register) then
		local Perl_Player_Pet_myAddOns_Details = {
			name = "Perl_Player_Pet",
			version = PERL_LOCALIZED_VERSION,
			releaseDate = PERL_LOCALIZED_DATE,
			author = "Perl; Maintained by Global",
			email = "global@g-ball.com",
			website = "http://www.curse-gaming.com/mod.php?addid=2257",
			category = MYADDONS_CATEGORY_OTHERS
		};
		Perl_Player_Pet_myAddOns_Help = {};
		Perl_Player_Pet_myAddOns_Help[1] = "/perl";
		myAddOnsFrame_Register(Perl_Player_Pet_myAddOns_Details, Perl_Player_Pet_myAddOns_Help);
	end
end
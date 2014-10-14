---------------
-- Variables --
---------------
Perl_Party_Pet_Config = {};
local Perl_Party_Pet_Events = {};	-- event manager

-- Default Saved Variables (also set in Perl_Party_Pet_GetVars)
local locked = 0;			-- unlocked by default
local showportrait = 0;			-- portrait is hidden by default
local threedportrait = 0;		-- 3d portraits are off by default
local scale = 1;			-- default scale
local transparency = 1;			-- transparency for frames
local numpetbuffsshown = 16;		-- buff row is 16 long
local numpetdebuffsshown = 16;		-- debuff row is 16 long
local buffsize = 12;			-- default buff size is 12
local debuffsize = 12;			-- default debuff size is 12
local bufflocation = 4;			-- default buff location
local debufflocation = 5;		-- default debuff location
local hiddeninraids = 0;		-- default is shown always
local compactmode = 0;			-- compact mode is disabled by default
local enabled = 1;			-- mod is shown by default

-- Default Local Variables
local Initialized = nil;		-- waiting to be initialized

-- Fade Bar Variables
local Perl_Party_Pet_One_HealthBar_Fade_Color = 1;		-- the color fading interval
local Perl_Party_Pet_One_HealthBar_Fade_Time_Elapsed = 0;	-- set the update timer to 0
local Perl_Party_Pet_Two_HealthBar_Fade_Color = 1;		-- the color fading interval
local Perl_Party_Pet_Two_HealthBar_Fade_Time_Elapsed = 0;	-- set the update timer to 0
local Perl_Party_Pet_Three_HealthBar_Fade_Color = 1;		-- the color fading interval
local Perl_Party_Pet_Three_HealthBar_Fade_Time_Elapsed = 0;	-- set the update timer to 0
local Perl_Party_Pet_Four_HealthBar_Fade_Color = 1;		-- the color fading interval
local Perl_Party_Pet_Four_HealthBar_Fade_Time_Elapsed = 0;	-- set the update timer to 0
local Perl_Party_Pet_One_ManaBar_Fade_Color = 1;		-- the color fading interval
local Perl_Party_Pet_One_ManaBar_Fade_Time_Elapsed = 0;		-- set the update timer to 0
local Perl_Party_Pet_Two_ManaBar_Fade_Color = 1;		-- the color fading interval
local Perl_Party_Pet_Two_ManaBar_Fade_Time_Elapsed = 0;		-- set the update timer to 0
local Perl_Party_Pet_Three_ManaBar_Fade_Color = 1;		-- the color fading interval
local Perl_Party_Pet_Three_ManaBar_Fade_Time_Elapsed = 0;	-- set the update timer to 0
local Perl_Party_Pet_Four_ManaBar_Fade_Color = 1;		-- the color fading interval
local Perl_Party_Pet_Four_ManaBar_Fade_Time_Elapsed = 0;	-- set the update timer to 0

-- Local variables to save memory
local partypethealth, partypethealthmax, partypetmana, partypetmanamax, partypetpower;


----------------------
-- Loading Function --
----------------------
function Perl_Party_Pet_Script_OnLoad()
	-- Events
	this:RegisterEvent("PARTY_MEMBERS_CHANGED");
	this:RegisterEvent("PLAYER_ALIVE");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("RAID_ROSTER_UPDATE");
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("UNIT_PET");

	-- Scripts
	this:SetScript("OnEvent", Perl_Party_Pet_Script_OnEvent);
end


-------------------
-- Event Handler --
-------------------
function Perl_Party_Pet_Script_OnEvent()
	local func = Perl_Party_Pet_Events[event];
	if (func) then
		func();
--	else
--		DEFAULT_CHAT_FRAME:AddMessage("Perl Classic - Party Pet: Report the following event error to the author: "..event);
	end
end

function Perl_Party_Pet_Events:UNIT_HEALTH()
	if ((arg1 == "partypet1") or (arg1 == "partypet2") or (arg1 == "partypet3") or (arg1 == "partypet4")) then
		Perl_Party_Pet_Update_Health(arg1);
	end
end
Perl_Party_Pet_Events.UNIT_MAXHEALTH = Perl_Party_Pet_Events.UNIT_HEALTH;

function Perl_Party_Pet_Events:UNIT_FOCUS()
	if ((arg1 == "partypet1") or (arg1 == "partypet2") or (arg1 == "partypet3") or (arg1 == "partypet4")) then
		Perl_Party_Pet_Update_Mana(arg1);
	end
end
Perl_Party_Pet_Events.UNIT_MAXFOCUS = Perl_Party_Pet_Events.UNIT_FOCUS;
Perl_Party_Pet_Events.UNIT_MANA = Perl_Party_Pet_Events.UNIT_FOCUS;
Perl_Party_Pet_Events.UNIT_MAXMANA = Perl_Party_Pet_Events.UNIT_FOCUS;

function Perl_Party_Pet_Events:UNIT_AURA()
	if ((arg1 == "partypet1") or (arg1 == "partypet2") or (arg1 == "partypet3") or (arg1 == "partypet4")) then
		Perl_Party_Pet_Buff_UpdateAll(arg1);
	end
end

function Perl_Party_Pet_Events:UNIT_DISPLAYPOWER()
	if ((arg1 == "partypet1") or (arg1 == "partypet2") or (arg1 == "partypet3") or (arg1 == "partypet4")) then
		Perl_Party_Pet_Update_Mana_Bar(arg1);		-- What type of energy are we using now?
		Perl_Party_Pet_Update_Mana(arg1);		-- Update the power info immediately
	end
end

function Perl_Party_Pet_Events:UNIT_LEVEL()
	if ((arg1 == "partypet1") or (arg1 == "partypet2") or (arg1 == "partypet3") or (arg1 == "partypet4")) then
		Perl_Party_Pet_Update_Health(arg1);
		Perl_Party_Pet_Update_Mana(arg1);
	end
end

function Perl_Party_Pet_Events:UNIT_MODEL_CHANGED()
	if ((arg1 == "partypet1") or (arg1 == "partypet2") or (arg1 == "partypet3") or (arg1 == "partypet4")) then
		Perl_Party_Pet_Update_Portrait(arg1);
	end
end
Perl_Party_Pet_Events.UNIT_PORTRAIT_UPDATE = Perl_Party_Pet_Events.UNIT_MODEL_CHANGED;

function Perl_Party_Pet_Events:RAID_ROSTER_UPDATE()
	Perl_Party_Pet_Update();
end

function Perl_Party_Pet_Events:PLAYER_ALIVE()
	Perl_Party_Pet_Update();
end

function Perl_Party_Pet_Events:PARTY_MEMBERS_CHANGED()
	Perl_Party_Pet_Update();
end

function Perl_Party_Pet_Events:UNIT_PET()
	if ((arg1 == "party1") or (arg1 == "party2") or (arg1 == "party3") or (arg1 == "party4")) then
		Perl_Party_Pet_Update();
	end
end

function Perl_Party_Pet_Events:UNIT_NAME_UPDATE()
	if ((arg1 == "partypet1") or (arg1 == "partypet2") or (arg1 == "partypet3") or (arg1 == "partypet4")) then
		Perl_Party_Pet_Update_Name(arg1);
	end
end

function Perl_Party_Pet_Events:VARIABLES_LOADED()
	Perl_Party_Pet_Initialize();
end
Perl_Party_Pet_Events.PLAYER_ENTERING_WORLD = Perl_Party_Pet_Events.VARIABLES_LOADED;


-------------------------------
-- Loading Settings Function --
-------------------------------
function Perl_Party_Pet_Initialize()
	-- Code to be run after zoning or logging in goes here
	if (Initialized) then
		Perl_Party_Pet_Set_Scale();		-- Set the frame scale
		Perl_Party_Pet_Set_Transparency();	-- Set the frame transparency
		Perl_Party_Pet_Update();		-- Refresh the info
		return;
	end

	-- Check if a previous exists, if not, enable by default.
	if (type(Perl_Party_Pet_Config[UnitName("player")]) == "table") then
		Perl_Party_Pet_GetVars();
	else
		Perl_Party_Pet_UpdateVars();
	end

	-- Major config options.
	Perl_Party_Pet_Initialize_Frame_Color();	-- Color the frame borders
	Perl_Party_Pet_Reset_Buffs();			-- Set the buff sizing

	-- Set the ID of the frame
	for num=1,4 do
		getglobal("Perl_Party_Pet"..num.."_NameFrame_CastClickOverlay"):SetID(num);
		getglobal("Perl_Party_Pet"..num.."_PortraitFrame_CastClickOverlay"):SetID(num);
		getglobal("Perl_Party_Pet"..num.."_StatsFrame_CastClickOverlay"):SetID(num);
		getglobal("Perl_Party_Pet"..num):Hide();	-- Hide the frame
	end

	-- Button Click Overlays (in order of occurrence in XML)
	for num = 1, 4 do
		getglobal("Perl_Party_Pet"..num.."_StatsFrame_HealthBarFadeBar"):SetFrameLevel(getglobal("Perl_Party_Pet"..num.."_StatsFrame_HealthBar"):GetFrameLevel() - 1);
		getglobal("Perl_Party_Pet"..num.."_StatsFrame_ManaBarFadeBar"):SetFrameLevel(getglobal("Perl_Party_Pet"..num.."_StatsFrame_ManaBar"):GetFrameLevel() - 1);
	end

	-- MyAddOns Support
	Perl_Party_Pet_myAddOns_Support();

	-- IFrameManager Support
	if (IFrameManager) then
		Perl_Party_Pet_IFrameManager();
	end

	Initialized = 1;
end

function Perl_Party_Pet_IFrameManager()
	local iface = IFrameManager:Interface();
	function iface:getName(frame)
		if (frame == Perl_Party_Pet1) then
			return "Perl Party Pet 1";
		elseif (frame == Perl_Party_Pet2) then
			return "Perl Party Pet 2";
		elseif (frame == Perl_Party_Pet3) then
			return "Perl Party Pet 3";
		elseif (frame == Perl_Party_Pet4) then
			return "Perl Party Pet 4";
		end
	end
	function iface:getBorder(frame)
		local bottom, left;
		if (showportrait == 1) then
			left = 48;
		else
			left = 0;
		end
		-- Offsets
		bottom = 30;
		return 0, 0, bottom, left;
	end
	IFrameManager:Register(Perl_Party_Pet1, iface);
	IFrameManager:Register(Perl_Party_Pet2, iface);
	IFrameManager:Register(Perl_Party_Pet3, iface);
	IFrameManager:Register(Perl_Party_Pet4, iface);
end

function Perl_Party_Pet_Initialize_Frame_Color()
	for partynum=1,4 do
		getglobal("Perl_Party_Pet"..partynum.."_NameFrame"):SetBackdropColor(0, 0, 0, 1);
		getglobal("Perl_Party_Pet"..partynum.."_NameFrame"):SetBackdropBorderColor(0.5, 0.5, 0.5, 1);
		getglobal("Perl_Party_Pet"..partynum.."_StatsFrame"):SetBackdropColor(0, 0, 0, 1);
		getglobal("Perl_Party_Pet"..partynum.."_StatsFrame"):SetBackdropBorderColor(0.5, 0.5, 0.5, 1);
		getglobal("Perl_Party_Pet"..partynum.."_PortraitFrame"):SetBackdropColor(0, 0, 0, 1);
		getglobal("Perl_Party_Pet"..partynum.."_PortraitFrame"):SetBackdropBorderColor(0.5, 0.5, 0.5, 1);
		getglobal("Perl_Party_Pet"..partynum.."_StatsFrame_HealthBar_HealthBarText"):SetTextColor(1, 1, 1, 1);
		getglobal("Perl_Party_Pet"..partynum.."_StatsFrame_ManaBar_ManaBarText"):SetTextColor(1, 1, 1, 1);
	end
end


-------------------------
-- The Update Function --
-------------------------
function Perl_Party_Pet_Update()
	if (enabled == 1) then
		if (hiddeninraids == 1) then
			if (UnitInRaid("player")) then
				Perl_Party_Pet_Script_Frame:UnregisterEvent("UNIT_AURA");
				Perl_Party_Pet_Script_Frame:UnregisterEvent("UNIT_DISPLAYPOWER");
				Perl_Party_Pet_Script_Frame:UnregisterEvent("UNIT_FOCUS");
				Perl_Party_Pet_Script_Frame:UnregisterEvent("UNIT_HEALTH");
				Perl_Party_Pet_Script_Frame:UnregisterEvent("UNIT_LEVEL");
				Perl_Party_Pet_Script_Frame:UnregisterEvent("UNIT_MANA");
				Perl_Party_Pet_Script_Frame:UnregisterEvent("UNIT_MAXFOCUS");
				Perl_Party_Pet_Script_Frame:UnregisterEvent("UNIT_MAXHEALTH");
				Perl_Party_Pet_Script_Frame:UnregisterEvent("UNIT_MAXMANA");
				Perl_Party_Pet_Script_Frame:UnregisterEvent("UNIT_MODEL_CHANGED");
				Perl_Party_Pet_Script_Frame:UnregisterEvent("UNIT_NAME_UPDATE");
				Perl_Party_Pet_Script_Frame:UnregisterEvent("UNIT_PORTRAIT_UPDATE");
			else
				Perl_Party_Pet_Script_Frame:RegisterEvent("UNIT_AURA");
				Perl_Party_Pet_Script_Frame:RegisterEvent("UNIT_DISPLAYPOWER");
				Perl_Party_Pet_Script_Frame:RegisterEvent("UNIT_FOCUS");
				Perl_Party_Pet_Script_Frame:RegisterEvent("UNIT_HEALTH");
				Perl_Party_Pet_Script_Frame:RegisterEvent("UNIT_LEVEL");
				Perl_Party_Pet_Script_Frame:RegisterEvent("UNIT_MANA");
				Perl_Party_Pet_Script_Frame:RegisterEvent("UNIT_MAXFOCUS");
				Perl_Party_Pet_Script_Frame:RegisterEvent("UNIT_MAXHEALTH");
				Perl_Party_Pet_Script_Frame:RegisterEvent("UNIT_MAXMANA");
				Perl_Party_Pet_Script_Frame:RegisterEvent("UNIT_MODEL_CHANGED");
				Perl_Party_Pet_Script_Frame:RegisterEvent("UNIT_NAME_UPDATE");
				Perl_Party_Pet_Script_Frame:RegisterEvent("UNIT_PORTRAIT_UPDATE");
			end
		else
			Perl_Party_Pet_Script_Frame:RegisterEvent("UNIT_AURA");
			Perl_Party_Pet_Script_Frame:RegisterEvent("UNIT_DISPLAYPOWER");
			Perl_Party_Pet_Script_Frame:RegisterEvent("UNIT_FOCUS");
			Perl_Party_Pet_Script_Frame:RegisterEvent("UNIT_HEALTH");
			Perl_Party_Pet_Script_Frame:RegisterEvent("UNIT_LEVEL");
			Perl_Party_Pet_Script_Frame:RegisterEvent("UNIT_MANA");
			Perl_Party_Pet_Script_Frame:RegisterEvent("UNIT_MAXFOCUS");
			Perl_Party_Pet_Script_Frame:RegisterEvent("UNIT_MAXHEALTH");
			Perl_Party_Pet_Script_Frame:RegisterEvent("UNIT_MAXMANA");
			Perl_Party_Pet_Script_Frame:RegisterEvent("UNIT_MODEL_CHANGED");
			Perl_Party_Pet_Script_Frame:RegisterEvent("UNIT_NAME_UPDATE");
			Perl_Party_Pet_Script_Frame:RegisterEvent("UNIT_PORTRAIT_UPDATE");
		end

		local partyid, frame, doworkflag;
		for id=1,4 do
			partyid = "party"..id;
			frame = getglobal("Perl_Party_Pet"..id);
			if (UnitIsConnected("party"..id) and UnitExists("partypet"..id)) then
				if (hiddeninraids == 1) then
					if (UnitInRaid("player")) then
						frame:Hide();
						doworkflag = 0;
					else
						frame:Show();
						doworkflag = 1;
					end
				else
					frame:Show();
					doworkflag = 1;
				end
			else
				frame:Hide();
				doworkflag = 0;
			end

			if (doworkflag == 1) then
				if (UnitIsConnected("party"..id) and UnitExists("partypet"..id)) then
					Perl_Party_Pet_Update_Health("partypet"..id);
					Perl_Party_Pet_Update_Mana("partypet"..id);
					Perl_Party_Pet_Update_Mana_Bar("partypet"..id);
					Perl_Party_Pet_Update_Name("partypet"..id);
					Perl_Party_Pet_Reset_Buffs();
					Perl_Party_Pet_Buff_Position_Update();
					Perl_Party_Pet_Buff_UpdateAll("partypet"..id);
					Perl_Party_Pet_Update_Portrait("partypet"..id);
				end
			end
		end
	else
		Perl_Party_Pet_Script_Frame:UnregisterEvent("UNIT_AURA");
		Perl_Party_Pet_Script_Frame:UnregisterEvent("UNIT_DISPLAYPOWER");
		Perl_Party_Pet_Script_Frame:UnregisterEvent("UNIT_FOCUS");
		Perl_Party_Pet_Script_Frame:UnregisterEvent("UNIT_HEALTH");
		Perl_Party_Pet_Script_Frame:UnregisterEvent("UNIT_LEVEL");
		Perl_Party_Pet_Script_Frame:UnregisterEvent("UNIT_MANA");
		Perl_Party_Pet_Script_Frame:UnregisterEvent("UNIT_MAXFOCUS");
		Perl_Party_Pet_Script_Frame:UnregisterEvent("UNIT_MAXHEALTH");
		Perl_Party_Pet_Script_Frame:UnregisterEvent("UNIT_MAXMANA");
		Perl_Party_Pet_Script_Frame:UnregisterEvent("UNIT_MODEL_CHANGED");
		Perl_Party_Pet_Script_Frame:UnregisterEvent("UNIT_NAME_UPDATE");
		Perl_Party_Pet_Script_Frame:UnregisterEvent("UNIT_PORTRAIT_UPDATE");

		Perl_Party_Pet1:Hide();
		Perl_Party_Pet2:Hide();
		Perl_Party_Pet3:Hide();
		Perl_Party_Pet4:Hide();
	end
end

function Perl_Party_Pet_Update_Health(unit)
	local id = string.sub(unit, 9, 9);
	partypethealth = UnitHealth(unit);
	partypethealthmax = UnitHealthMax(unit);

	if (UnitIsDead(unit) or UnitIsGhost(unit)) then				-- This prevents negative health
		partypethealth = 0;
	end

	if (PCUF_FADEBARS == 1) then
		if (partypethealth < getglobal("Perl_Party_Pet"..id.."_StatsFrame_HealthBar"):GetValue()) then
			getglobal("Perl_Party_Pet"..id.."_StatsFrame_HealthBarFadeBar"):SetMinMaxValues(0, partypethealthmax);
			getglobal("Perl_Party_Pet"..id.."_StatsFrame_HealthBarFadeBar"):SetValue(getglobal("Perl_Party_Pet"..id.."_StatsFrame_HealthBar"):GetValue());
			getglobal("Perl_Party_Pet"..id.."_StatsFrame_HealthBarFadeBar"):Show();
			-- We don't reset the values since this breaks fading due to not using individual variables for all 4 frames (not a big deal, still looks fine)
--			if (id == 1) then						-- This makes the bars fade much smoother when lots of change is happening to a given bar
--				Perl_Party_Pet_One_HealthBar_Fade_Color = 1;
--				Perl_Party_Pet_One_HealthBar_Fade_Time_Elapsed = 0;
--			elseif (id == 2) then
--				Perl_Party_Pet_Two_HealthBar_Fade_Color = 1;
--				Perl_Party_Pet_Two_HealthBar_Fade_Time_Elapsed = 0;
--			elseif (id == 3) then
--				Perl_Party_Pet_Three_HealthBar_Fade_Color = 1;
--				Perl_Party_Pet_Three_HealthBar_Fade_Time_Elapsed = 0;
--			elseif (id == 4) then
--				Perl_Party_Pet_Four_HealthBar_Fade_Color = 1;
--				Perl_Party_Pet_Four_HealthBar_Fade_Time_Elapsed = 0;
--			end
			getglobal("Perl_Party_Pet"..id.."_HealthBar_Fade_OnUpdate_Frame"):Show();
		end
	end

	getglobal("Perl_Party_Pet"..id.."_StatsFrame_HealthBar"):SetMinMaxValues(0, partypethealthmax);
	if (PCUF_INVERTBARVALUES == 1) then
		getglobal("Perl_Party_Pet"..id.."_StatsFrame_HealthBar"):SetValue(partypethealthmax - partypethealth);
	else
		getglobal("Perl_Party_Pet"..id.."_StatsFrame_HealthBar"):SetValue(partypethealth);
	end

	if (PCUF_COLORHEALTH == 1) then
--		local partypethealthpercent = floor(partypethealth/partypethealthmax*100+0.5);
--		if ((partypethealthpercent <= 100) and (partypethealthpercent > 75)) then
--			getglobal("Perl_Party_Pet"..id.."_StatsFrame_HealthBar"):SetStatusBarColor(0, 0.8, 0);
--			getglobal("Perl_Party_Pet"..id.."_StatsFrame_HealthBarBG"):SetStatusBarColor(0, 0.8, 0, 0.25);
--		elseif ((partypethealthpercent <= 75) and (partypethealthpercent > 50)) then
--			getglobal("Perl_Party_Pet"..id.."_StatsFrame_HealthBar"):SetStatusBarColor(1, 1, 0);
--			getglobal("Perl_Party_Pet"..id.."_StatsFrame_HealthBarBG"):SetStatusBarColor(1, 1, 0, 0.25);
--		elseif ((partypethealthpercent <= 50) and (partypethealthpercent > 25)) then
--			getglobal("Perl_Party_Pet"..id.."_StatsFrame_HealthBar"):SetStatusBarColor(1, 0.5, 0);
--			getglobal("Perl_Party_Pet"..id.."_StatsFrame_HealthBarBG"):SetStatusBarColor(1, 0.5, 0, 0.25);
--		else
--			getglobal("Perl_Party_Pet"..id.."_StatsFrame_HealthBar"):SetStatusBarColor(1, 0, 0);
--			getglobal("Perl_Party_Pet"..id.."_StatsFrame_HealthBarBG"):SetStatusBarColor(1, 0, 0, 0.25);
--		end

		local rawpercent = partypethealth / partypethealthmax;
		local red, green;

		if(rawpercent > 0.5) then
			red = (1.0 - rawpercent) * 2;
			green = 1.0;
		else
			red = 1.0;
			green = rawpercent * 2;
		end

		getglobal("Perl_Party_Pet"..id.."_StatsFrame_HealthBar"):SetStatusBarColor(red, green, 0, 1);
		getglobal("Perl_Party_Pet"..id.."_StatsFrame_HealthBarBG"):SetStatusBarColor(red, green, 0, 0.25);
	else
		getglobal("Perl_Party_Pet"..id.."_StatsFrame_HealthBar"):SetStatusBarColor(0, 0.8, 0);
		getglobal("Perl_Party_Pet"..id.."_StatsFrame_HealthBarBG"):SetStatusBarColor(0, 0.8, 0, 0.25);
	end

	getglobal("Perl_Party_Pet"..id.."_StatsFrame_HealthBar_HealthBarText"):SetText(partypethealth.."/"..partypethealthmax);
end

function Perl_Party_Pet_Update_Mana(unit)
	local id = string.sub(unit, 9, 9);
	partypetmana = UnitMana(unit);
	partypetmanamax = UnitManaMax(unit);

	if (UnitIsDead(unit) or UnitIsGhost(unit)) then		-- This prevents negative mana
		partypetmana = 0;
	end

	if (PCUF_FADEBARS == 1) then
		if (partypetmana < getglobal("Perl_Party_Pet"..id.."_StatsFrame_ManaBar"):GetValue()) then
			getglobal("Perl_Party_Pet"..id.."_StatsFrame_ManaBarFadeBar"):SetMinMaxValues(0, partypetmanamax);
			getglobal("Perl_Party_Pet"..id.."_StatsFrame_ManaBarFadeBar"):SetValue(getglobal("Perl_Party_Pet"..id.."_StatsFrame_ManaBar"):GetValue());
			getglobal("Perl_Party_Pet"..id.."_StatsFrame_ManaBarFadeBar"):Show();
			-- We don't reset the values since this breaks fading due to not using individual variables for all 4 frames (not a big deal, still looks fine)
--			if (id == 1) then						-- This makes the bars fade much smoother when lots of change is happening to a given bar
--				Perl_Party_Pet_One_ManaBar_Fade_Color = 1;
--				Perl_Party_Pet_One_ManaBar_Fade_Time_Elapsed = 0;
--			elseif (id == 2) then
--				Perl_Party_Pet_Two_ManaBar_Fade_Color = 1;
--				Perl_Party_Pet_Two_ManaBar_Fade_Time_Elapsed = 0;
--			elseif (id == 3) then
--				Perl_Party_Pet_Three_ManaBar_Fade_Color = 1;
--				Perl_Party_Pet_Three_ManaBar_Fade_Time_Elapsed = 0;
--			elseif (id == 4) then
--				Perl_Party_Pet_Four_ManaBar_Fade_Color = 1;
--				Perl_Party_Pet_Four_ManaBar_Fade_Time_Elapsed = 0;
--			end
			getglobal("Perl_Party_Pet"..id.."_ManaBar_Fade_OnUpdate_Frame"):Show();
		end
	end

	getglobal("Perl_Party_Pet"..id.."_StatsFrame_ManaBar"):SetMinMaxValues(0, partypetmanamax);
	if (PCUF_INVERTBARVALUES == 1) then
		getglobal("Perl_Party_Pet"..id.."_StatsFrame_ManaBar"):SetValue(partypetmanamax - partypetmana);
	else
		getglobal("Perl_Party_Pet"..id.."_StatsFrame_ManaBar"):SetValue(partypetmana);
	end

	if (UnitClass("party"..id) == PERL_LOCALIZED_WARLOCK) then
		getglobal("Perl_Party_Pet"..id.."_StatsFrame_ManaBar_ManaBarText"):SetText(partypetmana.."/"..partypetmanamax);
	else
		getglobal("Perl_Party_Pet"..id.."_StatsFrame_ManaBar_ManaBarText"):SetText(partypetmana);
	end
end

function Perl_Party_Pet_Update_Mana_Bar(unit)
	local id = string.sub(unit, 9, 9);
	partypetpower = UnitPowerType(unit);

	if (partypetpower == 1) then
		getglobal("Perl_Party_Pet"..id.."_StatsFrame_ManaBar"):SetStatusBarColor(1, 0, 0, 1);
		getglobal("Perl_Party_Pet"..id.."_StatsFrame_ManaBarBG"):SetStatusBarColor(1, 0, 0, 0.25);
	elseif (partypetpower == 2) then
		getglobal("Perl_Party_Pet"..id.."_StatsFrame_ManaBar"):SetStatusBarColor(1, 0.5, 0, 1);
		getglobal("Perl_Party_Pet"..id.."_StatsFrame_ManaBarBG"):SetStatusBarColor(1, 0.5, 0, 0.25);
	elseif (partypetpower == 3) then
		getglobal("Perl_Party_Pet"..id.."_StatsFrame_ManaBar"):SetStatusBarColor(1, 1, 0, 1);
		getglobal("Perl_Party_Pet"..id.."_StatsFrame_ManaBarBG"):SetStatusBarColor(1, 1, 0, 0.25);
	else
		getglobal("Perl_Party_Pet"..id.."_StatsFrame_ManaBar"):SetStatusBarColor(0, 0, 1, 1);
		getglobal("Perl_Party_Pet"..id.."_StatsFrame_ManaBarBG"):SetStatusBarColor(0, 0, 1, 0.25);
	end
end

function Perl_Party_Pet_Update_Name(unit)
	getglobal("Perl_Party_Pet"..string.sub(unit, 9, 9).."_NameFrame_NameBarText"):SetText(UnitName(unit));
end

function Perl_Party_Pet_Update_Portrait(unit)
	local id = string.sub(unit, 9, 9);

	if (showportrait == 1) then
		getglobal("Perl_Party_Pet"..id.."_PortraitFrame"):Show();						-- Show the main portrait frame

		if (threedportrait == 0) then
			SetPortraitTexture(getglobal("Perl_Party_Pet"..id.."_PortraitFrame_Portrait"), unit);		-- Load the correct 2d graphic
			getglobal("Perl_Party_Pet"..id.."_PortraitFrame_PartyModel"):Hide();				-- Hide the 3d graphic
			getglobal("Perl_Party_Pet"..id.."_PortraitFrame_Portrait"):Show();				-- Show the 2d graphic
		else
			if UnitIsVisible(unit) then
				getglobal("Perl_Party_Pet"..id.."_PortraitFrame_PartyModel"):SetUnit(unit);		-- Load the correct 3d graphic
				getglobal("Perl_Party_Pet"..id.."_PortraitFrame_Portrait"):Hide();			-- Hide the 2d graphic
				getglobal("Perl_Party_Pet"..id.."_PortraitFrame_PartyModel"):Show();			-- Show the 3d graphic
				getglobal("Perl_Party_Pet"..id.."_PortraitFrame_PartyModel"):SetCamera(0);
			else
				SetPortraitTexture(getglobal("Perl_Party_Pet"..id.."_PortraitFrame_Portrait"), unit);	-- Load the correct 2d graphic
				getglobal("Perl_Party_Pet"..id.."_PortraitFrame_PartyModel"):Hide();			-- Hide the 3d graphic
				getglobal("Perl_Party_Pet"..id.."_PortraitFrame_Portrait"):Show();			-- Show the 2d graphic
			end
		end
	else
		getglobal("Perl_Party_Pet"..id.."_PortraitFrame"):Hide();						-- Hide the frame and 2d/3d portion
	end
end


------------------------
-- Fade Bar Functions --
------------------------
function Perl_Party_Pet_One_HealthBar_Fade(arg1)
	Perl_Party_Pet_One_HealthBar_Fade_Color = Perl_Party_Pet_One_HealthBar_Fade_Color - arg1;
	Perl_Party_Pet_One_HealthBar_Fade_Time_Elapsed = Perl_Party_Pet_One_HealthBar_Fade_Time_Elapsed + arg1;

	Perl_Party_Pet1_StatsFrame_HealthBarFadeBar:SetStatusBarColor(0, Perl_Party_Pet_One_HealthBar_Fade_Color, 0, Perl_Party_Pet_One_HealthBar_Fade_Color);

	if (Perl_Party_Pet_One_HealthBar_Fade_Time_Elapsed > 1) then
		Perl_Party_Pet_One_HealthBar_Fade_Color = 1;
		Perl_Party_Pet_One_HealthBar_Fade_Time_Elapsed = 0;
		Perl_Party_Pet1_StatsFrame_HealthBarFadeBar:Hide();
		Perl_Party_Pet1_HealthBar_Fade_OnUpdate_Frame:Hide();
	end
end

function Perl_Party_Pet_Two_HealthBar_Fade(arg1)
	Perl_Party_Pet_Two_HealthBar_Fade_Color = Perl_Party_Pet_Two_HealthBar_Fade_Color - arg1;
	Perl_Party_Pet_Two_HealthBar_Fade_Time_Elapsed = Perl_Party_Pet_Two_HealthBar_Fade_Time_Elapsed + arg1;

	Perl_Party_Pet2_StatsFrame_HealthBarFadeBar:SetStatusBarColor(0, Perl_Party_Pet_Two_HealthBar_Fade_Color, 0, Perl_Party_Pet_Two_HealthBar_Fade_Color);

	if (Perl_Party_Pet_Two_HealthBar_Fade_Time_Elapsed > 1) then
		Perl_Party_Pet_Two_HealthBar_Fade_Color = 1;
		Perl_Party_Pet_Two_HealthBar_Fade_Time_Elapsed = 0;
		Perl_Party_Pet2_StatsFrame_HealthBarFadeBar:Hide();
		Perl_Party_Pet2_HealthBar_Fade_OnUpdate_Frame:Hide();
	end
end

function Perl_Party_Pet_Three_HealthBar_Fade(arg1)
	Perl_Party_Pet_Three_HealthBar_Fade_Color = Perl_Party_Pet_Three_HealthBar_Fade_Color - arg1;
	Perl_Party_Pet_Three_HealthBar_Fade_Time_Elapsed = Perl_Party_Pet_Three_HealthBar_Fade_Time_Elapsed + arg1;

	Perl_Party_Pet3_StatsFrame_HealthBarFadeBar:SetStatusBarColor(0, Perl_Party_Pet_Three_HealthBar_Fade_Color, 0, Perl_Party_Pet_Three_HealthBar_Fade_Color);

	if (Perl_Party_Pet_Three_HealthBar_Fade_Time_Elapsed > 1) then
		Perl_Party_Pet_Three_HealthBar_Fade_Color = 1;
		Perl_Party_Pet_Three_HealthBar_Fade_Time_Elapsed = 0;
		Perl_Party_Pet3_StatsFrame_HealthBarFadeBar:Hide();
		Perl_Party_Pet3_HealthBar_Fade_OnUpdate_Frame:Hide();
	end
end

function Perl_Party_Pet_Four_HealthBar_Fade(arg1)
	Perl_Party_Pet_Four_HealthBar_Fade_Color = Perl_Party_Pet_Four_HealthBar_Fade_Color - arg1;
	Perl_Party_Pet_Four_HealthBar_Fade_Time_Elapsed = Perl_Party_Pet_Four_HealthBar_Fade_Time_Elapsed + arg1;

	Perl_Party_Pet4_StatsFrame_HealthBarFadeBar:SetStatusBarColor(0, Perl_Party_Pet_Four_HealthBar_Fade_Color, 0, Perl_Party_Pet_Four_HealthBar_Fade_Color);

	if (Perl_Party_Pet_Four_HealthBar_Fade_Time_Elapsed > 1) then
		Perl_Party_Pet_Four_HealthBar_Fade_Color = 1;
		Perl_Party_Pet_Four_HealthBar_Fade_Time_Elapsed = 0;
		Perl_Party_Pet4_StatsFrame_HealthBarFadeBar:Hide();
		Perl_Party_Pet4_HealthBar_Fade_OnUpdate_Frame:Hide();
	end
end

function Perl_Party_Pet_One_ManaBar_Fade(arg1)
	Perl_Party_Pet_One_ManaBar_Fade_Color = Perl_Party_Pet_One_ManaBar_Fade_Color - arg1;
	Perl_Party_Pet_One_ManaBar_Fade_Time_Elapsed = Perl_Party_Pet_One_ManaBar_Fade_Time_Elapsed + arg1;

	if (UnitPowerType("partypet1") == 0) then
		Perl_Party_Pet1_StatsFrame_ManaBarFadeBar:SetStatusBarColor(0, 0, Perl_Party_Pet_One_ManaBar_Fade_Color, Perl_Party_Pet_One_ManaBar_Fade_Color);
	elseif (UnitPowerType("partypet1") == 2) then
		Perl_Party_Pet1_StatsFrame_ManaBarFadeBar:SetStatusBarColor(Perl_Party_Pet_One_ManaBar_Fade_Color, (Perl_Party_Pet_One_ManaBar_Fade_Color-0.5), 0, Perl_Party_Pet_One_ManaBar_Fade_Color);
	end

	if (Perl_Party_Pet_One_ManaBar_Fade_Time_Elapsed > 1) then
		Perl_Party_Pet_One_ManaBar_Fade_Color = 1;
		Perl_Party_Pet_One_ManaBar_Fade_Time_Elapsed = 0;
		Perl_Party_Pet1_StatsFrame_ManaBarFadeBar:Hide();
		Perl_Party_Pet1_ManaBar_Fade_OnUpdate_Frame:Hide();
	end
end

function Perl_Party_Pet_Two_ManaBar_Fade(arg1)
	Perl_Party_Pet_Two_ManaBar_Fade_Color = Perl_Party_Pet_Two_ManaBar_Fade_Color - arg1;
	Perl_Party_Pet_Two_ManaBar_Fade_Time_Elapsed = Perl_Party_Pet_Two_ManaBar_Fade_Time_Elapsed + arg1;

	if (UnitPowerType("partypet2") == 0) then
		Perl_Party_Pet2_StatsFrame_ManaBarFadeBar:SetStatusBarColor(0, 0, Perl_Party_Pet_Two_ManaBar_Fade_Color, Perl_Party_Pet_Two_ManaBar_Fade_Color);
	elseif (UnitPowerType("partypet2") == 2) then
		Perl_Party_Pet2_StatsFrame_ManaBarFadeBar:SetStatusBarColor(Perl_Party_Pet_Two_ManaBar_Fade_Color, (Perl_Party_Pet_Two_ManaBar_Fade_Color-0.5), 0, Perl_Party_Pet_Two_ManaBar_Fade_Color);
	end

	if (Perl_Party_Pet_Two_ManaBar_Fade_Time_Elapsed > 1) then
		Perl_Party_Pet_Two_ManaBar_Fade_Color = 1;
		Perl_Party_Pet_Two_ManaBar_Fade_Time_Elapsed = 0;
		Perl_Party_Pet2_StatsFrame_ManaBarFadeBar:Hide();
		Perl_Party_Pet2_ManaBar_Fade_OnUpdate_Frame:Hide();
	end
end

function Perl_Party_Pet_Three_ManaBar_Fade(arg1)
	Perl_Party_Pet_Three_ManaBar_Fade_Color = Perl_Party_Pet_Three_ManaBar_Fade_Color - arg1;
	Perl_Party_Pet_Three_ManaBar_Fade_Time_Elapsed = Perl_Party_Pet_Three_ManaBar_Fade_Time_Elapsed + arg1;

	if (UnitPowerType("partypet3") == 0) then
		Perl_Party_Pet3_StatsFrame_ManaBarFadeBar:SetStatusBarColor(0, 0, Perl_Party_Pet_Three_ManaBar_Fade_Color, Perl_Party_Pet_Three_ManaBar_Fade_Color);
	elseif (UnitPowerType("partypet3") == 2) then
		Perl_Party_Pet3_StatsFrame_ManaBarFadeBar:SetStatusBarColor(Perl_Party_Pet_Three_ManaBar_Fade_Color, (Perl_Party_Pet_Three_ManaBar_Fade_Color-0.5), 0, Perl_Party_Pet_Three_ManaBar_Fade_Color);
	end

	if (Perl_Party_Pet_Three_ManaBar_Fade_Time_Elapsed > 1) then
		Perl_Party_Pet_Three_ManaBar_Fade_Color = 1;
		Perl_Party_Pet_Three_ManaBar_Fade_Time_Elapsed = 0;
		Perl_Party_Pet3_StatsFrame_ManaBarFadeBar:Hide();
		Perl_Party_Pet3_ManaBar_Fade_OnUpdate_Frame:Hide();
	end
end

function Perl_Party_Pet_Four_ManaBar_Fade(arg1)
	Perl_Party_Pet_Four_ManaBar_Fade_Color = Perl_Party_Pet_Four_ManaBar_Fade_Color - arg1;
	Perl_Party_Pet_Four_ManaBar_Fade_Time_Elapsed = Perl_Party_Pet_Four_ManaBar_Fade_Time_Elapsed + arg1;

	if (UnitPowerType("partypet4") == 0) then
		Perl_Party_Pet4_StatsFrame_ManaBarFadeBar:SetStatusBarColor(0, 0, Perl_Party_Pet_Four_ManaBar_Fade_Color, Perl_Party_Pet_Four_ManaBar_Fade_Color);
	elseif (UnitPowerType("partypet4") == 2) then
		Perl_Party_Pet4_StatsFrame_ManaBarFadeBar:SetStatusBarColor(Perl_Party_Pet_Four_ManaBar_Fade_Color, (Perl_Party_Pet_Four_ManaBar_Fade_Color-0.5), 0, Perl_Party_Pet_Four_ManaBar_Fade_Color);
	end

	if (Perl_Party_Pet_Four_ManaBar_Fade_Time_Elapsed > 1) then
		Perl_Party_Pet_Four_ManaBar_Fade_Color = 1;
		Perl_Party_Pet_Four_ManaBar_Fade_Time_Elapsed = 0;
		Perl_Party_Pet4_StatsFrame_ManaBarFadeBar:Hide();
		Perl_Party_Pet4_ManaBar_Fade_OnUpdate_Frame:Hide();
	end
end


--------------------------
-- GUI Config Functions --
--------------------------
function Perl_Party_Pet_Set_Hidden(newvalue)
	hiddeninraids = newvalue;
	Perl_Party_Pet_UpdateVars();
	Perl_Party_Pet_Update();
end

function Perl_Party_Set_Enabled(newvalue)
	enabled = newvalue;
	Perl_Party_Pet_UpdateVars();
	Perl_Party_Pet_Update();
end

function Perl_Party_Pet_Allign()
	local vartable = Perl_Party_Pet_GetVars();	-- Get the party pet frame settings

	Perl_Party_Pet1:SetUserPlaced(1);		-- This makes wow remember the changes if the frames have never been moved before
	Perl_Party_Pet2:SetUserPlaced(1);
	Perl_Party_Pet3:SetUserPlaced(1);
	Perl_Party_Pet4:SetUserPlaced(1);

	if (vartable["showportrait"] == 1) then
		Perl_Party_Pet1:SetPoint("TOPLEFT", Perl_Party_MemberFrame1_StatsFrame, "TOPRIGHT", 44, 0);
		Perl_Party_Pet2:SetPoint("TOPLEFT", Perl_Party_MemberFrame2_StatsFrame, "TOPRIGHT", 44, 0);
		Perl_Party_Pet3:SetPoint("TOPLEFT", Perl_Party_MemberFrame3_StatsFrame, "TOPRIGHT", 44, 0);
		Perl_Party_Pet4:SetPoint("TOPLEFT", Perl_Party_MemberFrame4_StatsFrame, "TOPRIGHT", 44, 0);
	else
		Perl_Party_Pet1:SetPoint("TOPLEFT", Perl_Party_MemberFrame1_StatsFrame, "TOPRIGHT", -4, 0);
		Perl_Party_Pet2:SetPoint("TOPLEFT", Perl_Party_MemberFrame2_StatsFrame, "TOPRIGHT", -4, 0);
		Perl_Party_Pet3:SetPoint("TOPLEFT", Perl_Party_MemberFrame3_StatsFrame, "TOPRIGHT", -4, 0);
		Perl_Party_Pet4:SetPoint("TOPLEFT", Perl_Party_MemberFrame4_StatsFrame, "TOPRIGHT", -4, 0);
	end

	Perl_Party_Pet_UpdateVars();			-- Calling this to update the positions for IFrameManger
end

function Perl_Party_Pet_Set_Portrait(newvalue)
	showportrait = newvalue;
	Perl_Party_Pet_UpdateVars();
	Perl_Party_Pet_Update_Portrait("partypet1");
	Perl_Party_Pet_Update_Portrait("partypet2");
	Perl_Party_Pet_Update_Portrait("partypet3");
	Perl_Party_Pet_Update_Portrait("partypet4");
end

function Perl_Party_Pet_Set_3D_Portrait(newvalue)
	threedportrait = newvalue;
	Perl_Party_Pet_UpdateVars();
	Perl_Party_Pet_Update_Portrait("partypet1");
	Perl_Party_Pet_Update_Portrait("partypet2");
	Perl_Party_Pet_Update_Portrait("partypet3");
	Perl_Party_Pet_Update_Portrait("partypet4");
end

function Perl_Party_Pet_Set_Lock(newvalue)
	locked = newvalue;
	Perl_Party_Pet_UpdateVars();
end

function Perl_Party_Pet_Set_Buffs(newbuffnumber)
	if (newbuffnumber == nil) then
		newbuffnumber = 16;
	end
	numpetbuffsshown = newbuffnumber;
	Perl_Party_Pet_UpdateVars();
	Perl_Party_Pet_Reset_Buffs();			-- Reset the buff icons and set the size
	Perl_Party_Pet_Buff_UpdateAll("partypet1");	-- Repopulate the buff icons
	Perl_Party_Pet_Buff_UpdateAll("partypet2");
	Perl_Party_Pet_Buff_UpdateAll("partypet3");
	Perl_Party_Pet_Buff_UpdateAll("partypet4");
end

function Perl_Party_Pet_Set_Debuffs(newdebuffnumber)
	if (newdebuffnumber == nil) then
		newdebuffnumber = 16;
	end
	numpetdebuffsshown = newdebuffnumber;
	Perl_Party_Pet_UpdateVars();
	Perl_Party_Pet_Reset_Buffs();			-- Reset the buff icons and set the size
	Perl_Party_Pet_Buff_UpdateAll("partypet1");	-- Repopulate the buff icons
	Perl_Party_Pet_Buff_UpdateAll("partypet2");
	Perl_Party_Pet_Buff_UpdateAll("partypet3");
	Perl_Party_Pet_Buff_UpdateAll("partypet4");
end

function Perl_Party_Pet_Set_Buff_Size(newvalue)
	if (newvalue ~= nil) then
		buffsize = newvalue;
	end
	Perl_Party_Pet_UpdateVars();
	Perl_Party_Pet_Reset_Buffs();			-- Reset the buff icons and set the size
	Perl_Party_Pet_Buff_UpdateAll("partypet1");	-- Repopulate the buff icons
	Perl_Party_Pet_Buff_UpdateAll("partypet2");
	Perl_Party_Pet_Buff_UpdateAll("partypet3");
	Perl_Party_Pet_Buff_UpdateAll("partypet4");
end

function Perl_Party_Pet_Set_Debuff_Size(newvalue)
	if (newvalue ~= nil) then
		debuffsize = newvalue;
	end
	Perl_Party_Pet_UpdateVars();
	Perl_Party_Pet_Reset_Buffs();			-- Reset the buff icons and set the size
	Perl_Party_Pet_Buff_UpdateAll("partypet1");	-- Repopulate the buff icons
	Perl_Party_Pet_Buff_UpdateAll("partypet2");
	Perl_Party_Pet_Buff_UpdateAll("partypet3");
	Perl_Party_Pet_Buff_UpdateAll("partypet4");
end

function Perl_Party_Pet_Set_Buff_Location(newvalue)
	if (newvalue ~= nil) then
		bufflocation = newvalue;
	end
	Perl_Party_Pet_UpdateVars();
	Perl_Party_Pet_Reset_Buffs();			-- Reset the buff icons and set the size
	Perl_Party_Pet_Buff_Position_Update();
	Perl_Party_Pet_Buff_UpdateAll("partypet1");	-- Repopulate the buff icons
	Perl_Party_Pet_Buff_UpdateAll("partypet2");
	Perl_Party_Pet_Buff_UpdateAll("partypet3");
	Perl_Party_Pet_Buff_UpdateAll("partypet4");
end

function Perl_Party_Pet_Set_Debuff_Location(newvalue)
	if (newvalue ~= nil) then
		debufflocation = newvalue;
	end
	Perl_Party_Pet_UpdateVars();
	Perl_Party_Pet_Reset_Buffs();			-- Reset the buff icons and set the size
	Perl_Party_Pet_Buff_Position_Update();
	Perl_Party_Pet_Buff_UpdateAll("partypet1");	-- Repopulate the buff icons
	Perl_Party_Pet_Buff_UpdateAll("partypet2");
	Perl_Party_Pet_Buff_UpdateAll("partypet3");
	Perl_Party_Pet_Buff_UpdateAll("partypet4");
end

function Perl_Party_Pet_Set_Scale(number)
	local unsavedscale;
	if (number ~= nil) then
		scale = (number / 100);
	end
	unsavedscale = 1 - UIParent:GetEffectiveScale() + scale;	-- run it through the scaling formula introduced in 1.9
	Perl_Party_Pet1:SetScale(unsavedscale);
	Perl_Party_Pet2:SetScale(unsavedscale);
	Perl_Party_Pet3:SetScale(unsavedscale);
	Perl_Party_Pet4:SetScale(unsavedscale);
	Perl_Party_Pet_UpdateVars();
end

function Perl_Party_Pet_Set_Transparency(number)
	if (number ~= nil) then
		transparency = (number / 100);
	end
	Perl_Party_Pet1:SetAlpha(transparency);
	Perl_Party_Pet2:SetAlpha(transparency);
	Perl_Party_Pet3:SetAlpha(transparency);
	Perl_Party_Pet4:SetAlpha(transparency);
	Perl_Party_Pet_UpdateVars();
end


------------------------------
-- Saved Variable Functions --
------------------------------
function Perl_Party_Pet_GetVars(name, updateflag)
	if (name == nil) then
		name = UnitName("player");
	end

	locked = Perl_Party_Pet_Config[name]["Locked"];
	showportrait = Perl_Party_Pet_Config[name]["ShowPortrait"];
	threedportrait = Perl_Party_Pet_Config[name]["ThreeDPortrait"];
	scale = Perl_Party_Pet_Config[name]["Scale"];
	transparency = Perl_Party_Pet_Config[name]["Transparency"];
	numpetbuffsshown = Perl_Party_Pet_Config[name]["Buffs"];
	numpetdebuffsshown = Perl_Party_Pet_Config[name]["Debuffs"];
	buffsize = Perl_Party_Pet_Config[name]["BuffSize"];
	debuffsize = Perl_Party_Pet_Config[name]["DebuffSize"];
	bufflocation = Perl_Party_Pet_Config[name]["BuffLocation"];
	debufflocation = Perl_Party_Pet_Config[name]["DebuffLocation"];
	hiddeninraids = Perl_Party_Pet_Config[name]["HiddenInRaids"];
	enabled = Perl_Party_Pet_Config[name]["Enabled"];

	if (locked == nil) then
		locked = 0;
	end
	if (showportrait == nil) then
		showportrait = 0;
	end
	if (threedportrait == nil) then
		threedportrait = 0;
	end
	if (scale == nil) then
		scale = 1;
	end
	if (transparency == nil) then
		transparency = 1;
	end
	if (numpetbuffsshown == nil) then
		numpetbuffsshown = 16;
	end
	if (numpetdebuffsshown == nil) then
		numpetdebuffsshown = 16;
	end
	if (buffsize == nil) then
		buffsize = 12;
	end
	if (debuffsize == nil) then
		debuffsize = 12;
	end
	if (bufflocation == nil) then
		bufflocation = 4;
	end
	if (debufflocation == nil) then
		debufflocation = 5;
	end
	if (hiddeninraids == nil) then
		hiddeninraids = 0;
	end
	if (enabled == nil) then
		enabled = 1;
	end

	if (updateflag == 1) then
		-- Save the new values
		Perl_Party_Pet_UpdateVars();

		-- Call any code we need to activate them
		Perl_Party_Set_Scale();
		Perl_Party_Set_Transparency();
		Perl_Party_Pet_Update();
		return;
	end

	local vars = {
		["locked"] = locked,
		["showportrait"] = showportrait,
		["threedportrait"] = threedportrait,
		["scale"] = scale,
		["transparency"] = transparency,
		["numpetbuffsshown"] = numpetbuffsshown,
		["numpetdebuffsshown"] = numpetdebuffsshown,
		["buffsize"] = buffsize,
		["debuffsize"] = debuffsize,
		["bufflocation"] = bufflocation,
		["debufflocation"] = debufflocation,
		["hiddeninraids"] = hiddeninraids,
		["enabled"] = enabled,
	}
	return vars;
end

function Perl_Party_Pet_UpdateVars(vartable)
	if (vartable ~= nil) then
		-- Sanity checks in case you use a load from an old version
		if (vartable["Global Settings"] ~= nil) then
			if (vartable["Global Settings"]["Locked"] ~= nil) then
				locked = vartable["Global Settings"]["Locked"];
			else
				locked = nil;
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
			if (vartable["Global Settings"]["Scale"] ~= nil) then
				scale = vartable["Global Settings"]["Scale"];
			else
				scale = nil;
			end
			if (vartable["Global Settings"]["Transparency"] ~= nil) then
				transparency = vartable["Global Settings"]["Transparency"];
			else
				transparency = nil;
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
			if (vartable["Global Settings"]["HiddenInRaids"] ~= nil) then
				hiddeninraids = vartable["Global Settings"]["HiddenInRaids"];
			else
				hiddeninraids = nil;
			end
			if (vartable["Global Settings"]["Enabled"] ~= nil) then
				enabled = vartable["Global Settings"]["Enabled"];
			else
				enabled = nil;
			end
		end

		-- Set the new values if any new values were found, same defaults as above
		if (locked == nil) then
			locked = 0;
		end
		if (showportrait == nil) then
			showportrait = 0;
		end
		if (threedportrait == nil) then
			threedportrait = 0;
		end
		if (scale == nil) then
			scale = 1;
		end
		if (transparency == nil) then
			transparency = 1;
		end
		if (numpetbuffsshown == nil) then
			numpetbuffsshown = 16;
		end
		if (numpetdebuffsshown == nil) then
			numpetdebuffsshown = 16;
		end
		if (buffsize == nil) then
			buffsize = 12;
		end
		if (debuffsize == nil) then
			debuffsize = 12;
		end
		if (bufflocation == nil) then
			bufflocation = 4;
		end
		if (debufflocation == nil) then
			debufflocation = 5;
		end
		if (hiddeninraids == nil) then
			hiddeninraids = 0;
		end
		if (enabled == nil) then
			enabled = 1;
		end

		-- Call any code we need to activate them
		Perl_Party_Set_Scale();
		Perl_Party_Set_Transparency();
		Perl_Party_Pet_Update();
	end

	-- IFrameManager Support
	if (IFrameManager) then
		IFrameManager:Refresh();
	end

	Perl_Party_Pet_Config[UnitName("player")] = {
		["Locked"] = locked,
		["ShowPortrait"] = showportrait,
		["ThreeDPortrait"] = threedportrait,
		["Scale"] = scale,
		["Transparency"] = transparency,
		["Buffs"] = numpetbuffsshown,
		["Debuffs"] = numpetdebuffsshown,
		["BuffSize"] = buffsize,
		["DebuffSize"] = debuffsize,
		["BuffLocation"] = bufflocation,
		["DebuffLocation"] = debufflocation,
		["HiddenInRaids"] = hiddeninraids,
		["Enabled"] = enabled,
	};
end


--------------------
-- Buff Functions --
--------------------
function Perl_Party_Pet_Buff_UpdateAll(unit)
	if (UnitName(unit)) then
		local id = string.sub(unit, 9, 9);
		local button, buffCount, buffTexture, buffApplications, color, debuffType;				-- Variables for both buffs and debuffs (yes, I'm using buff names for debuffs, wanna fight about it?)

		for buffnum=1,numpetbuffsshown do									-- Start main buff loop
			buffTexture, buffApplications = UnitBuff(unit, buffnum);					-- Get the texture and buff stacking information if any
			button = getglobal("Perl_Party_Pet"..id.."_BuffFrame_Buff"..buffnum);				-- Create the main icon for the buff
			if (buffTexture) then										-- If there is a valid texture, proceed with buff icon creation
				getglobal(button:GetName().."Icon"):SetTexture(buffTexture);				-- Set the texture
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

		for debuffnum=1,numpetdebuffsshown do									-- Start main debuff loop
			buffTexture, buffApplications, debuffType = UnitDebuff(unit, debuffnum);			-- Get the texture and debuff stacking information if any
			button = getglobal("Perl_Party_Pet"..id.."_BuffFrame_DeBuff"..debuffnum);			-- Create the main icon for the debuff
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

function Perl_Party_Pet_Buff_Position_Update()
	Perl_Party_Pet1_BuffFrame_Buff1:ClearAllPoints();
	Perl_Party_Pet2_BuffFrame_Buff1:ClearAllPoints();
	Perl_Party_Pet3_BuffFrame_Buff1:ClearAllPoints();
	Perl_Party_Pet4_BuffFrame_Buff1:ClearAllPoints();
	if (bufflocation == 1) then
		getglobal("Perl_Party_Pet1_BuffFrame_Buff1"):SetPoint("BOTTOMLEFT", "Perl_Party_Pet1_NameFrame", "TOPLEFT", 5, 15);
		getglobal("Perl_Party_Pet2_BuffFrame_Buff1"):SetPoint("BOTTOMLEFT", "Perl_Party_Pet2_NameFrame", "TOPLEFT", 5, 15);
		getglobal("Perl_Party_Pet3_BuffFrame_Buff1"):SetPoint("BOTTOMLEFT", "Perl_Party_Pet3_NameFrame", "TOPLEFT", 5, 15);
		getglobal("Perl_Party_Pet4_BuffFrame_Buff1"):SetPoint("BOTTOMLEFT", "Perl_Party_Pet4_NameFrame", "TOPLEFT", 5, 15);
	elseif (bufflocation == 2) then
		getglobal("Perl_Party_Pet1_BuffFrame_Buff1"):SetPoint("BOTTOMLEFT", "Perl_Party_Pet1_NameFrame", "TOPLEFT", 5, 0);
		getglobal("Perl_Party_Pet2_BuffFrame_Buff1"):SetPoint("BOTTOMLEFT", "Perl_Party_Pet2_NameFrame", "TOPLEFT", 5, 0);
		getglobal("Perl_Party_Pet3_BuffFrame_Buff1"):SetPoint("BOTTOMLEFT", "Perl_Party_Pet3_NameFrame", "TOPLEFT", 5, 0);
		getglobal("Perl_Party_Pet4_BuffFrame_Buff1"):SetPoint("BOTTOMLEFT", "Perl_Party_Pet4_NameFrame", "TOPLEFT", 5, 0);
	elseif (bufflocation == 3) then
		getglobal("Perl_Party_Pet1_BuffFrame_Buff1"):SetPoint("TOPLEFT", "Perl_Party_Pet1_NameFrame", "TOPRIGHT", 0, -3);
		getglobal("Perl_Party_Pet2_BuffFrame_Buff1"):SetPoint("TOPLEFT", "Perl_Party_Pet2_NameFrame", "TOPRIGHT", 0, -3);
		getglobal("Perl_Party_Pet3_BuffFrame_Buff1"):SetPoint("TOPLEFT", "Perl_Party_Pet3_NameFrame", "TOPRIGHT", 0, -3);
		getglobal("Perl_Party_Pet4_BuffFrame_Buff1"):SetPoint("TOPLEFT", "Perl_Party_Pet4_NameFrame", "TOPRIGHT", 0, -3);
	elseif (bufflocation == 4) then
		getglobal("Perl_Party_Pet1_BuffFrame_Buff1"):SetPoint("TOPLEFT", "Perl_Party_Pet1_StatsFrame", "TOPRIGHT", 0, -5);
		getglobal("Perl_Party_Pet2_BuffFrame_Buff1"):SetPoint("TOPLEFT", "Perl_Party_Pet2_StatsFrame", "TOPRIGHT", 0, -5);
		getglobal("Perl_Party_Pet3_BuffFrame_Buff1"):SetPoint("TOPLEFT", "Perl_Party_Pet3_StatsFrame", "TOPRIGHT", 0, -5);
		getglobal("Perl_Party_Pet4_BuffFrame_Buff1"):SetPoint("TOPLEFT", "Perl_Party_Pet4_StatsFrame", "TOPRIGHT", 0, -5);
	elseif (bufflocation == 5) then
		getglobal("Perl_Party_Pet1_BuffFrame_Buff1"):SetPoint("TOPLEFT", "Perl_Party_Pet1_StatsFrame", "TOPRIGHT", 0, -20);
		getglobal("Perl_Party_Pet2_BuffFrame_Buff1"):SetPoint("TOPLEFT", "Perl_Party_Pet2_StatsFrame", "TOPRIGHT", 0, -20);
		getglobal("Perl_Party_Pet3_BuffFrame_Buff1"):SetPoint("TOPLEFT", "Perl_Party_Pet3_StatsFrame", "TOPRIGHT", 0, -20);
		getglobal("Perl_Party_Pet4_BuffFrame_Buff1"):SetPoint("TOPLEFT", "Perl_Party_Pet4_StatsFrame", "TOPRIGHT", 0, -20);
	elseif (bufflocation == 6) then
		getglobal("Perl_Party_Pet1_BuffFrame_Buff1"):SetPoint("TOPLEFT", "Perl_Party_Pet1_StatsFrame", "BOTTOMLEFT", 5, 0);
		getglobal("Perl_Party_Pet2_BuffFrame_Buff1"):SetPoint("TOPLEFT", "Perl_Party_Pet2_StatsFrame", "BOTTOMLEFT", 5, 0);
		getglobal("Perl_Party_Pet3_BuffFrame_Buff1"):SetPoint("TOPLEFT", "Perl_Party_Pet3_StatsFrame", "BOTTOMLEFT", 5, 0);
		getglobal("Perl_Party_Pet4_BuffFrame_Buff1"):SetPoint("TOPLEFT", "Perl_Party_Pet4_StatsFrame", "BOTTOMLEFT", 5, 0);
	elseif (bufflocation == 7) then
		getglobal("Perl_Party_Pet1_BuffFrame_Buff1"):SetPoint("TOPLEFT", "Perl_Party_Pet1_StatsFrame", "BOTTOMLEFT", 5, -15);
		getglobal("Perl_Party_Pet2_BuffFrame_Buff1"):SetPoint("TOPLEFT", "Perl_Party_Pet2_StatsFrame", "BOTTOMLEFT", 5, -15);
		getglobal("Perl_Party_Pet3_BuffFrame_Buff1"):SetPoint("TOPLEFT", "Perl_Party_Pet3_StatsFrame", "BOTTOMLEFT", 5, -15);
		getglobal("Perl_Party_Pet4_BuffFrame_Buff1"):SetPoint("TOPLEFT", "Perl_Party_Pet4_StatsFrame", "BOTTOMLEFT", 5, -15);
	end

	Perl_Party_Pet1_BuffFrame_DeBuff1:ClearAllPoints();
	Perl_Party_Pet2_BuffFrame_DeBuff1:ClearAllPoints();
	Perl_Party_Pet3_BuffFrame_DeBuff1:ClearAllPoints();
	Perl_Party_Pet4_BuffFrame_DeBuff1:ClearAllPoints();
	if (debufflocation == 1) then
		getglobal("Perl_Party_Pet1_BuffFrame_DeBuff1"):SetPoint("BOTTOMLEFT", "Perl_Party_Pet1_NameFrame", "TOPLEFT", 5, 15);
		getglobal("Perl_Party_Pet2_BuffFrame_DeBuff1"):SetPoint("BOTTOMLEFT", "Perl_Party_Pet2_NameFrame", "TOPLEFT", 5, 15);
		getglobal("Perl_Party_Pet3_BuffFrame_DeBuff1"):SetPoint("BOTTOMLEFT", "Perl_Party_Pet3_NameFrame", "TOPLEFT", 5, 15);
		getglobal("Perl_Party_Pet4_BuffFrame_DeBuff1"):SetPoint("BOTTOMLEFT", "Perl_Party_Pet4_NameFrame", "TOPLEFT", 5, 15);
	elseif (debufflocation == 2) then
		getglobal("Perl_Party_Pet1_BuffFrame_DeBuff1"):SetPoint("BOTTOMLEFT", "Perl_Party_Pet1_NameFrame", "TOPLEFT", 5, 0);
		getglobal("Perl_Party_Pet2_BuffFrame_DeBuff1"):SetPoint("BOTTOMLEFT", "Perl_Party_Pet2_NameFrame", "TOPLEFT", 5, 0);
		getglobal("Perl_Party_Pet3_BuffFrame_DeBuff1"):SetPoint("BOTTOMLEFT", "Perl_Party_Pet3_NameFrame", "TOPLEFT", 5, 0);
		getglobal("Perl_Party_Pet4_BuffFrame_DeBuff1"):SetPoint("BOTTOMLEFT", "Perl_Party_Pet4_NameFrame", "TOPLEFT", 5, 0);
	elseif (debufflocation == 3) then
		getglobal("Perl_Party_Pet1_BuffFrame_DeBuff1"):SetPoint("TOPLEFT", "Perl_Party_Pet1_NameFrame", "TOPRIGHT", 0, -3);
		getglobal("Perl_Party_Pet2_BuffFrame_DeBuff1"):SetPoint("TOPLEFT", "Perl_Party_Pet2_NameFrame", "TOPRIGHT", 0, -3);
		getglobal("Perl_Party_Pet3_BuffFrame_DeBuff1"):SetPoint("TOPLEFT", "Perl_Party_Pet3_NameFrame", "TOPRIGHT", 0, -3);
		getglobal("Perl_Party_Pet4_BuffFrame_DeBuff1"):SetPoint("TOPLEFT", "Perl_Party_Pet4_NameFrame", "TOPRIGHT", 0, -3);
	elseif (debufflocation == 4) then
		getglobal("Perl_Party_Pet1_BuffFrame_DeBuff1"):SetPoint("TOPLEFT", "Perl_Party_Pet1_StatsFrame", "TOPRIGHT", 0, -5);
		getglobal("Perl_Party_Pet2_BuffFrame_DeBuff1"):SetPoint("TOPLEFT", "Perl_Party_Pet2_StatsFrame", "TOPRIGHT", 0, -5);
		getglobal("Perl_Party_Pet3_BuffFrame_DeBuff1"):SetPoint("TOPLEFT", "Perl_Party_Pet3_StatsFrame", "TOPRIGHT", 0, -5);
		getglobal("Perl_Party_Pet4_BuffFrame_DeBuff1"):SetPoint("TOPLEFT", "Perl_Party_Pet4_StatsFrame", "TOPRIGHT", 0, -5);
	elseif (debufflocation == 5) then
		getglobal("Perl_Party_Pet1_BuffFrame_DeBuff1"):SetPoint("TOPLEFT", "Perl_Party_Pet1_StatsFrame", "TOPRIGHT", 0, -20);
		getglobal("Perl_Party_Pet2_BuffFrame_DeBuff1"):SetPoint("TOPLEFT", "Perl_Party_Pet2_StatsFrame", "TOPRIGHT", 0, -20);
		getglobal("Perl_Party_Pet3_BuffFrame_DeBuff1"):SetPoint("TOPLEFT", "Perl_Party_Pet3_StatsFrame", "TOPRIGHT", 0, -20);
		getglobal("Perl_Party_Pet4_BuffFrame_DeBuff1"):SetPoint("TOPLEFT", "Perl_Party_Pet4_StatsFrame", "TOPRIGHT", 0, -20);
	elseif (debufflocation == 6) then
		getglobal("Perl_Party_Pet1_BuffFrame_DeBuff1"):SetPoint("TOPLEFT", "Perl_Party_Pet1_StatsFrame", "BOTTOMLEFT", 5, 0);
		getglobal("Perl_Party_Pet2_BuffFrame_DeBuff1"):SetPoint("TOPLEFT", "Perl_Party_Pet2_StatsFrame", "BOTTOMLEFT", 5, 0);
		getglobal("Perl_Party_Pet3_BuffFrame_DeBuff1"):SetPoint("TOPLEFT", "Perl_Party_Pet3_StatsFrame", "BOTTOMLEFT", 5, 0);
		getglobal("Perl_Party_Pet4_BuffFrame_DeBuff1"):SetPoint("TOPLEFT", "Perl_Party_Pet4_StatsFrame", "BOTTOMLEFT", 5, 0);
	elseif (debufflocation == 7) then
		getglobal("Perl_Party_Pet1_BuffFrame_DeBuff1"):SetPoint("TOPLEFT", "Perl_Party_Pet1_StatsFrame", "BOTTOMLEFT", 5, -15);
		getglobal("Perl_Party_Pet2_BuffFrame_DeBuff1"):SetPoint("TOPLEFT", "Perl_Party_Pet2_StatsFrame", "BOTTOMLEFT", 5, -15);
		getglobal("Perl_Party_Pet3_BuffFrame_DeBuff1"):SetPoint("TOPLEFT", "Perl_Party_Pet3_StatsFrame", "BOTTOMLEFT", 5, -15);
		getglobal("Perl_Party_Pet4_BuffFrame_DeBuff1"):SetPoint("TOPLEFT", "Perl_Party_Pet4_StatsFrame", "BOTTOMLEFT", 5, -15);
	end
end

function Perl_Party_Pet_Reset_Buffs()
	local button, debuff, icon;
	for id=1,4 do
		for buffnum=1,16 do
			button = getglobal("Perl_Party_Pet"..id.."_BuffFrame_Buff"..buffnum);
			icon = getglobal(button:GetName().."Icon");
			button:SetHeight(buffsize);
			button:SetWidth(buffsize);
			icon:SetHeight(buffsize);
			icon:SetWidth(buffsize);
			button:Hide();
		end
		for buffnum=1,16 do
			button = getglobal("Perl_Party_Pet"..id.."_BuffFrame_DeBuff"..buffnum);
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
end

function Perl_Party_Pet_SetBuffTooltip()
	GameTooltip:SetOwner(this, "ANCHOR_BOTTOMRIGHT", 30, 0);
	GameTooltip:SetUnitBuff("partypet"..this:GetParent():GetParent():GetID(), this:GetID());
end

function Perl_Party_Pet_SetDeBuffTooltip()
	GameTooltip:SetOwner(this, "ANCHOR_BOTTOMRIGHT", 30, 0);
	GameTooltip:SetUnitDebuff("partypet"..this:GetParent():GetParent():GetID(), this:GetID());
end


--------------------
-- Click Handlers --
--------------------
function Perl_Party_Pet_MouseClick(button)
	local id = this:GetID();

	if (Perl_Custom_ClickFunction) then					-- Check to see if someone defined a custom click function
		if (Perl_Custom_ClickFunction(button, "partypet"..id)) then	-- If the function returns true, then we return
			return;
		end
	end									-- Otherwise, it did nothing, so take default action

	if (PCUF_CASTPARTYSUPPORT == 1) then
		if (CastPartyConfig) then
			CastParty.Event.OnClickByUnit(button, "partypet"..id);
			return;
		elseif (Genesis_MouseHeal and Genesis_MouseHeal("partypet"..id, button)) then
			return;
		elseif (CH_Config) then
			if (CH_Config.PCUFEnabled) then
				CH_UnitClicked("partypet"..id, button);
				return;
			end
		elseif (SmartHeal) then
			if (SmartHeal.Loaded and SmartHeal:getConfig("enable", "clickmode")) then
				local KeyDownType = SmartHeal:GetClickHealButton();
				if(KeyDownType and KeyDownType ~= "undetermined") then
					SmartHeal:ClickHeal(KeyDownType..button, "partypet"..id);
				else
					SmartHeal:DefaultClick(button, "partypet"..id);
				end
				return;
			end
		end
	end

	if (button == "LeftButton") then
		if (SpellIsTargeting()) then
			SpellTargetUnit("partypet"..id);
		elseif (CursorHasItem()) then
			DropItemOnUnit("partypet"..id);
		else
			TargetUnit("partypet"..id);
		end
		return;
	end

	if (button == "LeftButton") then
		if (SpellIsTargeting()) then
			SpellStopTargeting();
			return;
		end
	end
end

function Perl_Party_Pet_DragStart(button)
	if (button == "LeftButton" and locked == 0) then
		getglobal("Perl_Party_Pet"..this:GetID()):StartMoving();
	end
end

function Perl_Party_Pet_DragStop(button)
	getglobal("Perl_Party_Pet"..this:GetID()):SetUserPlaced(1);
	getglobal("Perl_Party_Pet"..this:GetID()):StopMovingOrSizing();
end


-------------
-- Tooltip --
-------------
function Perl_Party_Pet_Tip()
	UnitFrame_Initialize("partypet"..this:GetID())
end

function UnitFrame_Initialize(unit)	-- Hopefully this doesn't break any mods
	this.unit = unit;
end


----------------------
-- myAddOns Support --
----------------------
function Perl_Party_Pet_myAddOns_Support()
	-- Register the addon in myAddOns
	if(myAddOnsFrame_Register) then
		local Perl_Party_Pet_myAddOns_Details = {
			name = "Perl_Party_Pet",
			version = "Version 11200.4",
			releaseDate = "November 3, 2006",
			author = "Nymbia; Maintained by Global",
			email = "global@g-ball.com",
			website = "http://www.curse-gaming.com/mod.php?addid=2257",
			category = MYADDONS_CATEGORY_OTHERS
		};
		Perl_Party_Pet_myAddOns_Help = {};
		Perl_Party_Pet_myAddOns_Help[1] = "/perl";
		myAddOnsFrame_Register(Perl_Party_Pet_myAddOns_Details, Perl_Party_Pet_myAddOns_Help);
	end
end
-- Variables --
---------------
Perl_Raid_Config = {};
local Perl_Raid_Events = {};	-- event manager

-- Default Saved Variables (also set in Perl_Raid_GetVars)
local locked = 0;		-- unlocked by default
local showgroup1 = 1;		-- warrior
local showgroup2 = 1;		-- mage
local showgroup3 = 1;		-- priest
local showgroup4 = 1;		-- warlock
local showgroup5 = 1;		-- druid
local showgroup6 = 1;		-- rogue
local showgroup7 = 1;		-- hunter
local showgroup8 = 1;		-- paladin
local showgroup9 = 1;		-- shaman
local sortraidbyclass = 1;	-- sort by group by default
local transparency = 1;		-- transparency for frames
local scale = 1;		-- default scale
local showheaders = 1;		-- headers are shown by default
local showmissinghealth = 0;	-- missing health display is off by default
local verticalalign = 1;	-- frames will display vertically by default
local invertedgroups = 0;	-- frames will go down by default
local showraiddebuffs = 0;	-- debuffs are off by default
local displaycastablebuffs = 0;	-- display all buffs by default
local showraidbuffs = 0;	-- buffs are off by default
local colordebuffnames = 0;	-- red debuff names are off by default
local framestyle = 1;		-- nymbia style (1) is default
local showborder = 1;		-- borders are shown by default
local removespace = 0;		-- there is a small gap by default
local hidepowerbars = 0;	-- power bars are shown by default
local ctrastyletip = 1;		-- ctra styled tooltip is enabled by default
local showhealthpercents = 0;	-- health percents are hidden by default
local showmanapercents = 0;	-- mana percents are hidden by default
local hideemptyheaders = 0;	-- empty group headers are shown by default

-- Default Local Variables
local Initialized = nil;	-- waiting to be initialized

-- Local variables to save memory
local raidhealth, raidhealthmax, raidmana, raidmanamax, name;


----------------------
-- Loading Function --
----------------------
function Perl_Raid_OnLoad()
	--Events
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("RAID_ROSTER_UPDATE");
	this:RegisterEvent("VARIABLES_LOADED");

	-- Scripts
	this:SetScript("OnEvent", Perl_Raid_OnEvent);
end


-------------------
-- Event Handler --
-------------------
function Perl_Raid_OnEvent()
	local func = Perl_Raid_Events[event];
	if (func) then
		func();
--	else
--		DEFAULT_CHAT_FRAME:AddMessage("Perl Classic - Raid: Report the following event error to the author: "..event);
	end
end

function Perl_Raid_Events:UNIT_HEALTH()
	local _, _, id = string.find(arg1, "^raid(%d+)$");
	if (id) then
		Perl_Raid_Update_Health(id);
	end
end
Perl_Raid_Events.UNIT_MAXHEALTH = Perl_Raid_Events.UNIT_HEALTH;

function Perl_Raid_Events:UNIT_ENERGY()
	local _, _, id = string.find(arg1, "^raid(%d+)$");
	if (id) then
		Perl_Raid_Update_Mana(id);
	end
end
Perl_Raid_Events.UNIT_MAXENERGY = Perl_Raid_Events.UNIT_ENERGY;
Perl_Raid_Events.UNIT_MANA = Perl_Raid_Events.UNIT_ENERGY;
Perl_Raid_Events.UNIT_MAXMANA = Perl_Raid_Events.UNIT_ENERGY;
Perl_Raid_Events.UNIT_RAGE = Perl_Raid_Events.UNIT_ENERGY;
Perl_Raid_Events.UNIT_MAXRAGE = Perl_Raid_Events.UNIT_ENERGY;

function Perl_Raid_Events:UNIT_AURA()
	local _, _, id = string.find(arg1, "^raid(%d+)$");
	if (id) then
		Perl_Raid_Buff_UpdateAll(id);
	end
end

function Perl_Raid_Events:UNIT_DISPLAYPOWER()
	local _, _, id = string.find(arg1, "^raid(%d+)$");
	if (id) then
		Perl_Raid_Update_Mana_Bar(id);
		Perl_Raid_Update_Mana(id);
	end
end

function Perl_Raid_Events:RAID_ROSTER_UPDATE()
	Perl_Raid_Event_Register();
	Perl_Raid_Update();
end

function Perl_Raid_Events:UNIT_NAME_UPDATE()
	local _, _, id = string.find(arg1, "^raid(%d+)$");
	if (id) then
		Perl_Raid_Update_Name(id);
	end
end

function Perl_Raid_Events:VARIABLES_LOADED()
	Perl_Raid_Initialize();			-- We also force update info here in case of a /console reloadui (this needs work)
end
Perl_Raid_Events.PLAYER_ENTERING_WORLD = Perl_Raid_Events.VARIABLES_LOADED;

function Perl_Raid_Event_Register()
	if (UnitInRaid("player")) then
		Perl_Raid_Frame:RegisterEvent("UNIT_AURA");
		Perl_Raid_Frame:RegisterEvent("UNIT_DISPLAYPOWER");
		Perl_Raid_Frame:RegisterEvent("UNIT_ENERGY");
		Perl_Raid_Frame:RegisterEvent("UNIT_HEALTH");
		Perl_Raid_Frame:RegisterEvent("UNIT_MANA");
		Perl_Raid_Frame:RegisterEvent("UNIT_RAGE");
		Perl_Raid_Frame:RegisterEvent("UNIT_MAXENERGY");
		Perl_Raid_Frame:RegisterEvent("UNIT_MAXHEALTH");
		Perl_Raid_Frame:RegisterEvent("UNIT_MAXMANA");
		Perl_Raid_Frame:RegisterEvent("UNIT_MAXRAGE");
		Perl_Raid_Frame:RegisterEvent("UNIT_NAME_UPDATE");
	else
		Perl_Raid_Frame:UnregisterEvent("UNIT_AURA");
		Perl_Raid_Frame:UnregisterEvent("UNIT_DISPLAYPOWER");
		Perl_Raid_Frame:UnregisterEvent("UNIT_ENERGY");
		Perl_Raid_Frame:UnregisterEvent("UNIT_HEALTH");
		Perl_Raid_Frame:UnregisterEvent("UNIT_MANA");
		Perl_Raid_Frame:UnregisterEvent("UNIT_RAGE");
		Perl_Raid_Frame:UnregisterEvent("UNIT_MAXENERGY");
		Perl_Raid_Frame:UnregisterEvent("UNIT_MAXHEALTH");
		Perl_Raid_Frame:UnregisterEvent("UNIT_MAXMANA");
		Perl_Raid_Frame:UnregisterEvent("UNIT_MAXRAGE");
		Perl_Raid_Frame:UnregisterEvent("UNIT_NAME_UPDATE");

		Perl_Raid_Grp1:Hide();
		Perl_Raid_Grp2:Hide();
		Perl_Raid_Grp3:Hide();
		Perl_Raid_Grp4:Hide();
		Perl_Raid_Grp5:Hide();
		Perl_Raid_Grp6:Hide();
		Perl_Raid_Grp7:Hide();
		Perl_Raid_Grp8:Hide();
		Perl_Raid_Grp9:Hide();
	end
end


-------------------------------
-- Loading Settings Function --
-------------------------------
function Perl_Raid_Initialize()
	-- Check if we loaded the mod already.
	if (Initialized) then
		Perl_Raid_Set_Scale();
		Perl_Raid_Set_Transparency();

		Perl_Raid_Set_Layout();
		Perl_Raid_Initialize_Frame_Color();

		Perl_Raid_Event_Register();
		Perl_Raid_Update();
		Perl_Raid_Set_Buffs();
		Perl_Raid_Set_Debuffs();
		return;
	end

	-- Check if a previous exists, if not, enable by default.
	if (type(Perl_Raid_Config[UnitName("player")]) == "table") then
		Perl_Raid_GetVars();
	else
		Perl_Raid_UpdateVars();
	end

	-- Major config options.
	Perl_Raid_Set_Layout();
	Perl_Raid_Initialize_Frame_Color();

	-- Hide the group frame
	for num=1,9 do
		getglobal("Perl_Raid_Grp"..num):Hide();
	end

	-- Set the ID of the frame
	for num=1,40 do
		getglobal("Perl_Raid"..num.."_NameFrame_CastClickOverlay"):SetID(num);
		getglobal("Perl_Raid"..num.."_StatsFrame_CastClickOverlay"):SetID(num);
		getglobal("Perl_Raid"..num):Hide();	-- Hide the frame
	end

	-- Put the click area above any text
	for num=1,40 do
		getglobal("Perl_Raid"..num.."_NameFrame_CastClickOverlay"):SetFrameLevel(getglobal("Perl_Raid"..num.."_NameFrame"):GetFrameLevel() + 2);
		getglobal("Perl_Raid"..num.."_StatsFrame_CastClickOverlay"):SetFrameLevel(getglobal("Perl_Raid"..num.."_StatsFrame"):GetFrameLevel() + 2);
		getglobal("Perl_Raid"..num.."_Name"):SetFrameLevel(getglobal("Perl_Raid"..num.."_StatsFrame_CastClickOverlay"):GetFrameLevel() - 1);
	end

	-- Force the frames already positioned so no mod accidently doesn't save their position
	Perl_Raid_Grp1:SetUserPlaced(1);
	Perl_Raid_Grp2:SetUserPlaced(1);
	Perl_Raid_Grp3:SetUserPlaced(1);
	Perl_Raid_Grp4:SetUserPlaced(1);
	Perl_Raid_Grp5:SetUserPlaced(1);
	Perl_Raid_Grp6:SetUserPlaced(1);
	Perl_Raid_Grp7:SetUserPlaced(1);
	Perl_Raid_Grp8:SetUserPlaced(1);
	Perl_Raid_Grp9:SetUserPlaced(1);

	-- MyAddOns Support
	Perl_Raid_myAddOns_Support();

	-- IFrameManager Support
	if (IFrameManager) then
		Perl_Raid_IFrameManager();
	end

	Initialized = 1;
end

function Perl_Raid_IFrameManager()
	local iface = IFrameManager:Interface();
	function iface:getName(frame)
		if (frame == Perl_Raid_Grp1) then
			return "Perl Raid Group 1 ("..PERL_LOCALIZED_WARRIOR..")";
		elseif (frame == Perl_Raid_Grp2) then
			return "Perl Raid Group 2 ("..PERL_LOCALIZED_MAGE..")";
		elseif (frame == Perl_Raid_Grp3) then
			return "Perl Raid Group 3 ("..PERL_LOCALIZED_PRIEST..")";
		elseif (frame == Perl_Raid_Grp4) then
			return "Perl Raid Group 4 ("..PERL_LOCALIZED_WARLOCK..")";
		elseif (frame == Perl_Raid_Grp5) then
			return "Perl Raid Group 5 ("..PERL_LOCALIZED_DRUID..")";
		elseif (frame == Perl_Raid_Grp6) then
			return "Perl Raid Group 6 ("..PERL_LOCALIZED_ROGUE..")";
		elseif (frame == Perl_Raid_Grp7) then
			return "Perl Raid Group 7 ("..PERL_LOCALIZED_HUNTER..")";
		elseif (frame == Perl_Raid_Grp8) then
			return "Perl Raid Group 8 ("..PERL_LOCALIZED_PALADIN..")";
		elseif (frame == Perl_Raid_Grp9) then
			return "Perl Raid Group 9 ("..PERL_LOCALIZED_SHAMAN..")";
		end
	end
	function iface:getBorder(frame)
		local bottom = 0;
		local left = 0;
		local right = 0;
		local top = 0;
		if (verticalalign == 1) then
			if (invertedgroups == 1) then
				top = 5 * 44 - 5;
			else
				bottom = 5 * 44;
			end
			if (showheaders == 0) then
				if (invertedgroups == 1) then
					bottom = -16;
				else
					top = -22;
				end
			end
			if (framestyle == 2) then
				bottom = bottom - 93;
				if (showborder == 0) then
					bottom = bottom + 30;
					left = 1;
					right = 1;
					if (removespace == 1) then
						bottom = bottom - 11;
					end
				end
			end
		else
			if (invertedgroups == 1) then
				bottom = 44;
				left = 4 * 79;
			else
				bottom = 44;
				right = 4 * 79;
			end
			if (showheaders == 0) then
				top = -22;
			end
			if (framestyle == 2) then
				bottom = bottom - 20;
				right = right - 13;
				if (showborder == 0) then
					bottom = bottom + 2;
					left = left + 1;
					right = right + 31;
					if (removespace == 1) then
						right = right - 12;
					end
				end
			end
		end
		return top, right, bottom, left;
	end
	IFrameManager:Register(Perl_Raid_Grp1, iface);
	IFrameManager:Register(Perl_Raid_Grp2, iface);
	IFrameManager:Register(Perl_Raid_Grp3, iface);
	IFrameManager:Register(Perl_Raid_Grp4, iface);
	IFrameManager:Register(Perl_Raid_Grp5, iface);
	IFrameManager:Register(Perl_Raid_Grp6, iface);
	IFrameManager:Register(Perl_Raid_Grp7, iface);
	IFrameManager:Register(Perl_Raid_Grp8, iface);
	IFrameManager:Register(Perl_Raid_Grp9, iface);
end

function Perl_Raid_Initialize_Frame_Color()
	Perl_Raid_Set_Layout();
	for id=1,40 do
		getglobal("Perl_Raid"..id.."_NameFrame"):SetBackdropColor(0, 0, 0, 1);
		getglobal("Perl_Raid"..id.."_NameFrame"):SetBackdropBorderColor(0.5, 0.5, 0.5, 1);
		getglobal("Perl_Raid"..id.."_StatsFrame"):SetBackdropColor(0, 0, 0, 1);
		getglobal("Perl_Raid"..id.."_StatsFrame"):SetBackdropBorderColor(0.5, 0.5, 0.5, 1);

		getglobal("Perl_Raid"..id.."_StatsFrame_HealthBar_HealthBarText"):SetTextColor(1, 1, 1, 1);
		getglobal("Perl_Raid"..id.."_StatsFrame_ManaBar_ManaBarText"):SetTextColor(1, 1, 1, 1);
	end
end


----------------------
-- Update Functions --
----------------------
function Perl_Raid_Update()
	for id=1,40 do
		if (UnitName("raid"..id) ~= nil) then
			getglobal("Perl_Raid"..id):Show();	-- Show the frame
			Perl_Raid_Update_Health(id);		-- Update health values
			Perl_Raid_Update_Mana_Bar(id);		-- Update mana bar color
			Perl_Raid_Update_Mana(id);		-- Update mana values
			Perl_Raid_Update_Name(id);		-- Update name and color it
			Perl_Raid_Buff_UpdateAll(id);		-- Update the buffs
		else
			getglobal("Perl_Raid"..id):Hide();	-- Hide the frame
		end
	end

	Perl_Raid_Show_Hide_Group_Header();			-- Hide or show the group headers

	if (sortraidbyclass == 1) then				-- Sort by class or group (and the hide empty group header check is here too)
		Perl_Raid_Sort_By_Class();
	else
		Perl_Raid_Sort_By_Group();
	end
end

function Perl_Raid_Update_Health(id)
	raidhealth = nil;			-- Clear any previous value
	raidhealthmax = nil;
	raidhealth = UnitHealth("raid"..id);	-- Set the new value
	raidhealthmax = UnitHealthMax("raid"..id);

	if (PCUF_COLORHEALTH == 1) then
--		local raidhealthpercent = floor(raidhealth/raidhealthmax*100+0.5);
--		if ((raidhealthpercent <= 100) and (raidhealthpercent > 75)) then
--			getglobal("Perl_Raid"..id.."_StatsFrame_HealthBar"):SetStatusBarColor(0, 0.8, 0);
--			getglobal("Perl_Raid"..id.."_StatsFrame_HealthBarBG"):SetStatusBarColor(0, 0.8, 0, 0.25);
--		elseif ((raidhealthpercent <= 75) and (raidhealthpercent > 50)) then
--			getglobal("Perl_Raid"..id.."_StatsFrame_HealthBar"):SetStatusBarColor(1, 1, 0);
--			getglobal("Perl_Raid"..id.."_StatsFrame_HealthBarBG"):SetStatusBarColor(1, 1, 0, 0.25);
--		elseif ((raidhealthpercent <= 50) and (raidhealthpercent > 25)) then
--			getglobal("Perl_Raid"..id.."_StatsFrame_HealthBar"):SetStatusBarColor(1, 0.5, 0);
--			getglobal("Perl_Raid"..id.."_StatsFrame_HealthBarBG"):SetStatusBarColor(1, 0.5, 0, 0.25);
--		else
--			getglobal("Perl_Raid"..id.."_StatsFrame_HealthBar"):SetStatusBarColor(1, 0, 0);
--			getglobal("Perl_Raid"..id.."_StatsFrame_HealthBarBG"):SetStatusBarColor(1, 0, 0, 0.25);
--		end

		local rawpercent = raidhealth / raidhealthmax;
		local red, green;

		if(rawpercent > 0.5) then
			red = (1.0 - rawpercent) * 2;
			green = 1.0;
		else
			red = 1.0;
			green = rawpercent * 2;
		end

		getglobal("Perl_Raid"..id.."_StatsFrame_HealthBar"):SetStatusBarColor(red, green, 0, 1);
		getglobal("Perl_Raid"..id.."_StatsFrame_HealthBarBG"):SetStatusBarColor(red, green, 0, 0.25);
	else
		getglobal("Perl_Raid"..id.."_StatsFrame_HealthBar"):SetStatusBarColor(0, 0.8, 0);
		getglobal("Perl_Raid"..id.."_StatsFrame_HealthBarBG"):SetStatusBarColor(0, 0.8, 0, 0.25);
	end

	if (UnitIsConnected("raid"..id)) then
		if (UnitIsDead("raid"..id) or UnitIsGhost("raid"..id)) then		-- This prevents negative health
			raidhealth = 0;
			if (UnitClass("raid"..id) == PERL_LOCALIZED_HUNTER) then	-- If the dead is a hunter, check for Feign Death
				local buffnum = 1;
				local currentlyfd = 0;
				local buffTexture = UnitBuff("raid"..id, buffnum);
				while (buffTexture) do
					if (buffTexture == "Interface\\Icons\\Ability_Rogue_FeignDeath") then
						getglobal("Perl_Raid"..id.."_StatsFrame_HealthBar_HealthBarText"):SetText(PERL_LOCALIZED_STATUS_FEIGNDEATH);
						getglobal("Perl_Raid"..id.."_StatsFrame_HealthBar_HealthBarText"):Show();
						currentlyfd = 1;
						break;
					end
					buffnum = buffnum + 1;
					buffTexture = UnitBuff("raid"..id, buffnum);
				end
				if (currentlyfd == 0) then				-- If the hunter is not Feign Death, then lol
					getglobal("Perl_Raid"..id.."_StatsFrame_HealthBar_HealthBarText"):SetText(PERL_LOCALIZED_STATUS_DEAD);
					getglobal("Perl_Raid"..id.."_StatsFrame_HealthBar_HealthBarText"):Show();
				end
			else								-- If the dead is not a hunter, well...
				getglobal("Perl_Raid"..id.."_StatsFrame_HealthBar_HealthBarText"):SetText(PERL_LOCALIZED_STATUS_DEAD);
				getglobal("Perl_Raid"..id.."_StatsFrame_HealthBar_HealthBarText"):Show();
			end
		else
			if (showhealthpercents == 1) then
				if (showmissinghealth == 1) then
					if (raidhealth == raidhealthmax) then
						getglobal("Perl_Raid"..id.."_StatsFrame_HealthBar_HealthBarText"):SetText();
					else
						getglobal("Perl_Raid"..id.."_StatsFrame_HealthBar_HealthBarText"):SetText("-"..(raidhealthmax - raidhealth));
					end
				else
					getglobal("Perl_Raid"..id.."_StatsFrame_HealthBar_HealthBarText"):SetText(floor(raidhealth/raidhealthmax*100+0.5).."%");
				end
				getglobal("Perl_Raid"..id.."_StatsFrame_HealthBar_HealthBarText"):Show();
			else
				if (showmissinghealth == 1) then
					if (raidhealth == raidhealthmax) then
						getglobal("Perl_Raid"..id.."_StatsFrame_HealthBar_HealthBarText"):SetText();
					else
						getglobal("Perl_Raid"..id.."_StatsFrame_HealthBar_HealthBarText"):SetText("-"..(raidhealthmax - raidhealth));
					end
					getglobal("Perl_Raid"..id.."_StatsFrame_HealthBar_HealthBarText"):Show();
				else
					getglobal("Perl_Raid"..id.."_StatsFrame_HealthBar_HealthBarText"):Hide();
				end
			end
		end

		getglobal("Perl_Raid"..id.."_StatsFrame_HealthBar"):SetMinMaxValues(0, raidhealthmax);
		getglobal("Perl_Raid"..id.."_StatsFrame_HealthBar"):SetValue(raidhealth);
		getglobal("Perl_Raid"..id.."_StatsFrame_HealthBarBG"):Show();
		
		if (hidepowerbars == 0) then
			getglobal("Perl_Raid"..id.."_StatsFrame_ManaBar"):Show();
			getglobal("Perl_Raid"..id.."_StatsFrame_ManaBarBG"):Show();
		else
			getglobal("Perl_Raid"..id.."_StatsFrame_ManaBar"):Hide();
			getglobal("Perl_Raid"..id.."_StatsFrame_ManaBarBG"):Hide();
		end
	else
		getglobal("Perl_Raid"..id.."_StatsFrame_HealthBar_HealthBarText"):SetText(PERL_LOCALIZED_STATUS_OFFLINE);
		getglobal("Perl_Raid"..id.."_StatsFrame_HealthBar_HealthBarText"):Show();

		getglobal("Perl_Raid"..id.."_StatsFrame_HealthBar"):SetMinMaxValues(0, raidhealthmax);
		getglobal("Perl_Raid"..id.."_StatsFrame_HealthBar"):SetValue(0);
		getglobal("Perl_Raid"..id.."_StatsFrame_HealthBarBG"):Hide();

		getglobal("Perl_Raid"..id.."_StatsFrame_ManaBar"):Hide();
		getglobal("Perl_Raid"..id.."_StatsFrame_ManaBarBG"):Hide();
	end
end

function Perl_Raid_Update_Mana(id)
	if (hidepowerbars == 0) then
		raidmana = nil;
		raidmanamax = nil;
		raidmana = UnitMana("raid"..id);
		raidmanamax = UnitManaMax("raid"..id);

		if (showmanapercents == 1) then
			getglobal("Perl_Raid"..id.."_StatsFrame_ManaBar_ManaBarText"):SetText(floor(raidmana/raidmanamax*100+0.5).."%");
			getglobal("Perl_Raid"..id.."_StatsFrame_ManaBar_ManaBarText"):Show();
		else
			getglobal("Perl_Raid"..id.."_StatsFrame_ManaBar_ManaBarText"):Hide();
		end

		getglobal("Perl_Raid"..id.."_StatsFrame_ManaBar"):SetMinMaxValues(0, raidmanamax);
		getglobal("Perl_Raid"..id.."_StatsFrame_ManaBar"):SetValue(raidmana);
	end
end

function Perl_Raid_Update_Mana_Bar(id)
	local raidpower = UnitPowerType("raid"..id);
	if (raidpower == 1) then
		getglobal("Perl_Raid"..id.."_StatsFrame_ManaBar"):SetStatusBarColor(1, 0, 0, 1);
		getglobal("Perl_Raid"..id.."_StatsFrame_ManaBarBG"):SetStatusBarColor(1, 0, 0, 0.25);
	elseif (raidpower == 2) then
		getglobal("Perl_Raid"..id.."_StatsFrame_ManaBar"):SetStatusBarColor(1, 0.5, 0, 1);
		getglobal("Perl_Raid"..id.."_StatsFrame_ManaBarBG"):SetStatusBarColor(1, 0.5, 0, 0.25);
	elseif (raidpower == 3) then
		getglobal("Perl_Raid"..id.."_StatsFrame_ManaBar"):SetStatusBarColor(1, 1, 0, 1);
		getglobal("Perl_Raid"..id.."_StatsFrame_ManaBarBG"):SetStatusBarColor(1, 1, 0, 0.25);
	else
		getglobal("Perl_Raid"..id.."_StatsFrame_ManaBar"):SetStatusBarColor(0, 0, 1, 1);
		getglobal("Perl_Raid"..id.."_StatsFrame_ManaBarBG"):SetStatusBarColor(0, 0, 1, 0.25);
	end
end

function Perl_Raid_Update_Name(id)
	name = UnitName("raid"..id);

	if (GetLocale() == "koKR") then
		if (strlen(name) > 20) then
			name = strsub(name, 1, 19).."...";
		end
	elseif (GetLocale() == "zhCN") then
		if (strlen(name) > 20) then
			name = strsub(name, 1, 19).."...";
		end
	else
		if (strlen(name) > 10) then
			name = strsub(name, 1, 9).."...";
		end
	end
	getglobal("Perl_Raid"..id.."_Name_NameBarText"):SetText(name);

	if (UnitClass("raid"..id) == PERL_LOCALIZED_WARRIOR) then
		getglobal("Perl_Raid"..id.."_Name_NameBarText"):SetTextColor(0.78, 0.61, 0.43);
	elseif (UnitClass("raid"..id) == PERL_LOCALIZED_MAGE) then
		getglobal("Perl_Raid"..id.."_Name_NameBarText"):SetTextColor(0.41, 0.8, 0.94);
	elseif (UnitClass("raid"..id) == PERL_LOCALIZED_ROGUE) then
		getglobal("Perl_Raid"..id.."_Name_NameBarText"):SetTextColor(1, 0.96, 0.41);
	elseif (UnitClass("raid"..id) == PERL_LOCALIZED_DRUID) then
		getglobal("Perl_Raid"..id.."_Name_NameBarText"):SetTextColor(1, 0.49, 0.04);
	elseif (UnitClass("raid"..id) == PERL_LOCALIZED_HUNTER) then
		getglobal("Perl_Raid"..id.."_Name_NameBarText"):SetTextColor(0.67, 0.83, 0.45);
	elseif (UnitClass("raid"..id) == PERL_LOCALIZED_SHAMAN) then
		getglobal("Perl_Raid"..id.."_Name_NameBarText"):SetTextColor(0.96, 0.55, 0.73);
	elseif (UnitClass("raid"..id) == PERL_LOCALIZED_PRIEST) then
		getglobal("Perl_Raid"..id.."_Name_NameBarText"):SetTextColor(1, 1, 1);
	elseif (UnitClass("raid"..id) == PERL_LOCALIZED_WARLOCK) then
		getglobal("Perl_Raid"..id.."_Name_NameBarText"):SetTextColor(0.58, 0.51, 0.79);
	elseif (UnitClass("raid"..id) == PERL_LOCALIZED_PALADIN) then
		getglobal("Perl_Raid"..id.."_Name_NameBarText"):SetTextColor(0.96, 0.55, 0.73);
	end
end


--------------------
-- Raid Functions --
--------------------
function Perl_Raid_Set_Layout()
	if (framestyle == 1) then
		for id=1,40 do
			getglobal("Perl_Raid"..id.."_NameFrame"):Show();
			getglobal("Perl_Raid"..id.."_Name"):SetPoint("TOPLEFT", getglobal("Perl_Raid"..id.."_NameFrame"), "TOPLEFT", 0, 0);
			getglobal("Perl_Raid"..id.."_Name_NameBarText"):ClearAllPoints();
			getglobal("Perl_Raid"..id.."_Name_NameBarText"):SetPoint("BOTTOM", getglobal("Perl_Raid"..id.."_Name"), "BOTTOM", 0, 6);

			getglobal("Perl_Raid"..id.."_StatsFrame"):SetPoint("TOPLEFT", getglobal("Perl_Raid"..id.."_NameFrame"), "BOTTOMLEFT", 0, 4);
			getglobal("Perl_Raid"..id.."_StatsFrame_HealthBar"):SetPoint("TOP", getglobal("Perl_Raid"..id.."_StatsFrame"), "TOP", 0, -5);
			getglobal("Perl_Raid"..id.."_StatsFrame_HealthBar"):SetHeight(15);
			getglobal("Perl_Raid"..id.."_StatsFrame_HealthBarBG"):SetHeight(15);
			getglobal("Perl_Raid"..id.."_StatsFrame"):SetBackdrop({bgFile = "Interface\\AddOns\\Perl_Config\\Perl_Black", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, insets = { left = 5, right = 5, top = 5, bottom = 5 }});
		end
	else
		for id=1,40 do
			getglobal("Perl_Raid"..id.."_NameFrame"):Hide();
			getglobal("Perl_Raid"..id.."_Name"):SetPoint("TOPLEFT", getglobal("Perl_Raid"..id.."_StatsFrame"), "TOPLEFT", 0, 0);
			getglobal("Perl_Raid"..id.."_Name_NameBarText"):ClearAllPoints();
			getglobal("Perl_Raid"..id.."_Name_NameBarText"):SetPoint("TOPLEFT", getglobal("Perl_Raid"..id.."_Name"), "TOPLEFT", 5, -4);
			getglobal("Perl_Raid"..id.."_StatsFrame_HealthBar"):SetHeight(5);
			getglobal("Perl_Raid"..id.."_StatsFrame_HealthBarBG"):SetHeight(5);

			if (hidepowerbars == 0) then
				getglobal("Perl_Raid"..id.."_StatsFrame_HealthBar"):SetPoint("TOP", getglobal("Perl_Raid"..id.."_StatsFrame"), "TOP", 0, -15);
				getglobal("Perl_Raid"..id.."_StatsFrame_ManaBar"):Show();
				getglobal("Perl_Raid"..id.."_StatsFrame_ManaBarBG"):Show();
			else
				getglobal("Perl_Raid"..id.."_StatsFrame_HealthBar"):SetPoint("TOP", getglobal("Perl_Raid"..id.."_StatsFrame"), "TOP", 0, -17);
				getglobal("Perl_Raid"..id.."_StatsFrame_ManaBar"):Hide();
				getglobal("Perl_Raid"..id.."_StatsFrame_ManaBarBG"):Hide();
			end
			--DEFAULT_CHAT_FRAME:AddMessage("showborder = "..showborder);
			if (showborder == 1) then
				getglobal("Perl_Raid"..id.."_StatsFrame"):SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, insets = { left = 5, right = 5, top = 5, bottom = 5 }});
			else
				getglobal("Perl_Raid"..id.."_StatsFrame"):SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", edgeFile = nil, tile = nil, tileSize = nil, edgeSize = nil, insets = { left = nil, right = nil, top = nil, bottom = nil }});
			end
		end
	end
end

function Perl_Raid_Show_Hide_Group_Header()
	if (UnitInRaid("player")) then		-- Player is in a raid, continue option checks
		if (showheaders == 1) then	-- Show headers is enabled
			if (showgroup1 == 1) then
				Perl_Raid_Grp1:Show();
			else
				Perl_Raid_Grp1:Hide();
			end

			if (showgroup2 == 1) then
				Perl_Raid_Grp2:Show();
			else
				Perl_Raid_Grp2:Hide();
			end

			if (showgroup3 == 1) then
				Perl_Raid_Grp3:Show();
			else
				Perl_Raid_Grp3:Hide();
			end

			if (showgroup4 == 1) then
				Perl_Raid_Grp4:Show();
			else
				Perl_Raid_Grp4:Hide();
			end

			if (showgroup5 == 1) then
				Perl_Raid_Grp5:Show();
			else
				Perl_Raid_Grp5:Hide();
			end

			if (showgroup6 == 1) then
				Perl_Raid_Grp6:Show();
			else
				Perl_Raid_Grp6:Hide();
			end

			if (showgroup7 == 1) then
				Perl_Raid_Grp7:Show();
			else
				Perl_Raid_Grp7:Hide();
			end

			if (showgroup8 == 1) then
				Perl_Raid_Grp8:Show();
			else
				Perl_Raid_Grp8:Hide();
			end

			if (showgroup9 == 1) then
				if (sortraidbyclass == 1) then
					Perl_Raid_Grp9:Show();
				else
					Perl_Raid_Grp9:Hide();
				end
			else
				Perl_Raid_Grp9:Hide();
			end
		else	-- Show headers is disabled
			Perl_Raid_Grp1:Hide();
			Perl_Raid_Grp2:Hide();
			Perl_Raid_Grp3:Hide();
			Perl_Raid_Grp4:Hide();
			Perl_Raid_Grp5:Hide();
			Perl_Raid_Grp6:Hide();
			Perl_Raid_Grp7:Hide();
			Perl_Raid_Grp8:Hide();
			Perl_Raid_Grp9:Hide();
		end
	else		-- Player not in raid, hide all headers
		Perl_Raid_Grp1:Hide();
		Perl_Raid_Grp2:Hide();
		Perl_Raid_Grp3:Hide();
		Perl_Raid_Grp4:Hide();
		Perl_Raid_Grp5:Hide();
		Perl_Raid_Grp6:Hide();
		Perl_Raid_Grp7:Hide();
		Perl_Raid_Grp8:Hide();
		Perl_Raid_Grp9:Hide();
	end

	Perl_Raid_UpdateVars();		-- Called for improved IFrameManager support
end

function Perl_Raid_Sort_By_Class()
	local wa = 0;
	local m = 0;
	local p = 0;
	local wr = 0;
	local d = 0;
	local r = 0;
	local h = 0;
	local pa = 0;
	local s = 0;

	local spacing, titlespacing;
	if (framestyle == 1) then
		if (verticalalign == 1) then
			spacing = 43;
			if (invertedgroups == 0) then
				titlespacing = 0;
			else
				titlespacing = 40;
			end
		else
			spacing = 78;
			titlespacing = 0;
		end
	elseif (framestyle == 2) then
		if (verticalalign == 1) then
			if (showborder == 1) then
				spacing = 26;
			else
				if (removespace == 1) then
					spacing = 30;
				else
					spacing = 33;
				end
			end
			if (invertedgroups == 0) then
				titlespacing = 20;
			else
				titlespacing = 40;
			end
		else
			if (showborder == 1) then
				spacing = 76;
			else
				if (removespace == 1) then
					spacing = 80;
				else
					spacing = 83;
				end
			end
			titlespacing = 20;
		end
	end

	Perl_Raid_Grp1_NameFrame_NameBarText:SetText(PERL_LOCALIZED_WARRIOR);
	Perl_Raid_Grp2_NameFrame_NameBarText:SetText(PERL_LOCALIZED_MAGE);
	Perl_Raid_Grp3_NameFrame_NameBarText:SetText(PERL_LOCALIZED_PRIEST);
	Perl_Raid_Grp4_NameFrame_NameBarText:SetText(PERL_LOCALIZED_WARLOCK);
	Perl_Raid_Grp5_NameFrame_NameBarText:SetText(PERL_LOCALIZED_DRUID);
	Perl_Raid_Grp6_NameFrame_NameBarText:SetText(PERL_LOCALIZED_ROGUE);
	Perl_Raid_Grp7_NameFrame_NameBarText:SetText(PERL_LOCALIZED_HUNTER);
	Perl_Raid_Grp8_NameFrame_NameBarText:SetText(PERL_LOCALIZED_PALADIN);
	Perl_Raid_Grp9_NameFrame_NameBarText:SetText(PERL_LOCALIZED_SHAMAN);

	for num=1,40 do
		if (UnitName("raid"..num) ~= nil) then
			if (UnitClass("raid"..num) == PERL_LOCALIZED_WARRIOR) then
				if (verticalalign == 1) then
					if (invertedgroups == 0) then
						getglobal("Perl_Raid"..num):SetPoint("TOPLEFT", "Perl_Raid_Grp1", "BOTTOMLEFT", 0, (2-(wa*spacing)+titlespacing));
					else
						getglobal("Perl_Raid"..num):SetPoint("TOPLEFT", "Perl_Raid_Grp1", "TOPLEFT", 0, -(2-(wa*spacing)-titlespacing));
					end
				else
					if (invertedgroups == 0) then
						getglobal("Perl_Raid"..num):SetPoint("TOPLEFT", "Perl_Raid_Grp1", "BOTTOMLEFT", (wa*spacing), 2+titlespacing);
					else
						getglobal("Perl_Raid"..num):SetPoint("TOPLEFT", "Perl_Raid_Grp1", "BOTTOMLEFT", -(wa*spacing), 2+titlespacing);
					end
				end
				wa = wa + 1;
				if (showgroup1 == 0) then
					getglobal("Perl_Raid"..num):Hide();
				else
					getglobal("Perl_Raid"..num):Show();
				end
			elseif (UnitClass("raid"..num) == PERL_LOCALIZED_MAGE) then
				if (verticalalign == 1) then
					if (invertedgroups == 0) then
						getglobal("Perl_Raid"..num):SetPoint("TOPLEFT", "Perl_Raid_Grp2", "BOTTOMLEFT", 0, (2-(m*spacing)+titlespacing));
					else
						getglobal("Perl_Raid"..num):SetPoint("TOPLEFT", "Perl_Raid_Grp2", "TOPLEFT", 0, -(2-(m*spacing)-titlespacing));
					end
				else
					if (invertedgroups == 0) then
						getglobal("Perl_Raid"..num):SetPoint("TOPLEFT", "Perl_Raid_Grp2", "BOTTOMLEFT", (m*spacing), 2+titlespacing);
					else
						getglobal("Perl_Raid"..num):SetPoint("TOPLEFT", "Perl_Raid_Grp2", "BOTTOMLEFT", -(m*spacing), 2+titlespacing);
					end
				end
				m = m + 1;
				if (showgroup2 == 0) then
					getglobal("Perl_Raid"..num):Hide();
				else
					getglobal("Perl_Raid"..num):Show();
				end
			elseif (UnitClass("raid"..num) == PERL_LOCALIZED_PRIEST) then
				if (verticalalign == 1) then
					if (invertedgroups == 0) then
						getglobal("Perl_Raid"..num):SetPoint("TOPLEFT", "Perl_Raid_Grp3", "BOTTOMLEFT", 0, (2-(p*spacing)+titlespacing));
					else
						getglobal("Perl_Raid"..num):SetPoint("TOPLEFT", "Perl_Raid_Grp3", "TOPLEFT", 0, -(2-(p*spacing)-titlespacing));
					end
				else
					if (invertedgroups == 0) then
						getglobal("Perl_Raid"..num):SetPoint("TOPLEFT", "Perl_Raid_Grp3", "BOTTOMLEFT", (p*spacing), 2+titlespacing);
					else
						getglobal("Perl_Raid"..num):SetPoint("TOPLEFT", "Perl_Raid_Grp3", "BOTTOMLEFT", -(p*spacing), 2+titlespacing);
					end
				end
				p = p + 1;
				if (showgroup3 == 0) then
					getglobal("Perl_Raid"..num):Hide();
				else
					getglobal("Perl_Raid"..num):Show();
				end
			elseif (UnitClass("raid"..num) == PERL_LOCALIZED_WARLOCK) then
				if (verticalalign == 1) then
					if (invertedgroups == 0) then
						getglobal("Perl_Raid"..num):SetPoint("TOPLEFT", "Perl_Raid_Grp4", "BOTTOMLEFT", 0, (2-(wr*spacing)+titlespacing));
					else
						getglobal("Perl_Raid"..num):SetPoint("TOPLEFT", "Perl_Raid_Grp4", "TOPLEFT", 0, -(2-(wr*spacing)-titlespacing));
					end
				else
					if (invertedgroups == 0) then
						getglobal("Perl_Raid"..num):SetPoint("TOPLEFT", "Perl_Raid_Grp4", "BOTTOMLEFT", (wr*spacing), 2+titlespacing);
					else
						getglobal("Perl_Raid"..num):SetPoint("TOPLEFT", "Perl_Raid_Grp4", "BOTTOMLEFT", -(wr*spacing), 2+titlespacing);
					end
				end
				wr = wr + 1;
				if (showgroup4 == 0) then
					getglobal("Perl_Raid"..num):Hide();
				else
					getglobal("Perl_Raid"..num):Show();
				end
			elseif (UnitClass("raid"..num) == PERL_LOCALIZED_DRUID) then
				if (verticalalign == 1) then
					if (invertedgroups == 0) then
						getglobal("Perl_Raid"..num):SetPoint("TOPLEFT", "Perl_Raid_Grp5", "BOTTOMLEFT", 0, (2-(d*spacing)+titlespacing));
					else
						getglobal("Perl_Raid"..num):SetPoint("TOPLEFT", "Perl_Raid_Grp5", "TOPLEFT", 0, -(2-(d*spacing)-titlespacing));
					end
				else
					if (invertedgroups == 0) then
						getglobal("Perl_Raid"..num):SetPoint("TOPLEFT", "Perl_Raid_Grp5", "BOTTOMLEFT", (d*spacing), 2+titlespacing);
					else
						getglobal("Perl_Raid"..num):SetPoint("TOPLEFT", "Perl_Raid_Grp5", "BOTTOMLEFT", -(d*spacing), 2+titlespacing);
					end
				end
				d = d + 1;
				if (showgroup5 == 0) then
					getglobal("Perl_Raid"..num):Hide();
				else
					getglobal("Perl_Raid"..num):Show();
				end
			elseif (UnitClass("raid"..num) == PERL_LOCALIZED_ROGUE) then
				if (verticalalign == 1) then
					if (invertedgroups == 0) then
						getglobal("Perl_Raid"..num):SetPoint("TOPLEFT", "Perl_Raid_Grp6", "BOTTOMLEFT", 0, (2-(r*spacing)+titlespacing));
					else
						getglobal("Perl_Raid"..num):SetPoint("TOPLEFT", "Perl_Raid_Grp6", "TOPLEFT", 0, -(2-(r*spacing)-titlespacing));
					end
				else
					if (invertedgroups == 0) then
						getglobal("Perl_Raid"..num):SetPoint("TOPLEFT", "Perl_Raid_Grp6", "BOTTOMLEFT", (r*spacing), 2+titlespacing);
					else
						getglobal("Perl_Raid"..num):SetPoint("TOPLEFT", "Perl_Raid_Grp6", "BOTTOMLEFT", -(r*spacing), 2+titlespacing);
					end
				end
				r = r + 1;
				if (showgroup6 == 0) then
					getglobal("Perl_Raid"..num):Hide();
				else
					getglobal("Perl_Raid"..num):Show();
				end
			elseif (UnitClass("raid"..num) == PERL_LOCALIZED_HUNTER) then
				if (verticalalign == 1) then
					if (invertedgroups == 0) then
						getglobal("Perl_Raid"..num):SetPoint("TOPLEFT", "Perl_Raid_Grp7", "BOTTOMLEFT", 0, (2-(h*spacing)+titlespacing));
					else
						getglobal("Perl_Raid"..num):SetPoint("TOPLEFT", "Perl_Raid_Grp7", "TOPLEFT", 0, -(2-(h*spacing)-titlespacing));
					end
				else
					if (invertedgroups == 0) then
						getglobal("Perl_Raid"..num):SetPoint("TOPLEFT", "Perl_Raid_Grp7", "BOTTOMLEFT", (h*spacing), 2+titlespacing);
					else
						getglobal("Perl_Raid"..num):SetPoint("TOPLEFT", "Perl_Raid_Grp7", "BOTTOMLEFT", -(h*spacing), 2+titlespacing);
					end
				end
				h = h + 1;
				if (showgroup7 == 0) then
					getglobal("Perl_Raid"..num):Hide();
				else
					getglobal("Perl_Raid"..num):Show();
				end
			elseif (UnitClass("raid"..num) == PERL_LOCALIZED_PALADIN) then
				if (verticalalign == 1) then
					if (invertedgroups == 0) then
						getglobal("Perl_Raid"..num):SetPoint("TOPLEFT", "Perl_Raid_Grp8", "BOTTOMLEFT", 0, (2-(pa*spacing)+titlespacing));
					else
						getglobal("Perl_Raid"..num):SetPoint("TOPLEFT", "Perl_Raid_Grp8", "TOPLEFT", 0, -(2-(pa*spacing)-titlespacing));
					end
				else
					if (invertedgroups == 0) then
						getglobal("Perl_Raid"..num):SetPoint("TOPLEFT", "Perl_Raid_Grp8", "BOTTOMLEFT", (pa*spacing), 2+titlespacing);
					else
						getglobal("Perl_Raid"..num):SetPoint("TOPLEFT", "Perl_Raid_Grp8", "BOTTOMLEFT", -(pa*spacing), 2+titlespacing);
					end
				end
				pa = pa + 1;
				if (showgroup8 == 0) then
					getglobal("Perl_Raid"..num):Hide();
				else
					getglobal("Perl_Raid"..num):Show();
				end
			elseif (UnitClass("raid"..num) == PERL_LOCALIZED_SHAMAN) then
				if (verticalalign == 1) then
					if (invertedgroups == 0) then
						getglobal("Perl_Raid"..num):SetPoint("TOPLEFT", "Perl_Raid_Grp9", "BOTTOMLEFT", 0, (2-(s*spacing)+titlespacing));
					else
						getglobal("Perl_Raid"..num):SetPoint("TOPLEFT", "Perl_Raid_Grp9", "TOPLEFT", 0, -(2-(s*spacing)-titlespacing));
					end
				else
					if (invertedgroups == 0) then
						getglobal("Perl_Raid"..num):SetPoint("TOPLEFT", "Perl_Raid_Grp9", "BOTTOMLEFT", (s*spacing), 2+titlespacing);
					else
						getglobal("Perl_Raid"..num):SetPoint("TOPLEFT", "Perl_Raid_Grp9", "BOTTOMLEFT", -(s*spacing), 2+titlespacing);
					end
				end
				s = s + 1;
				if (showgroup9 == 0) then
					getglobal("Perl_Raid"..num):Hide();
				else
					getglobal("Perl_Raid"..num):Show();
				end
			else
				getglobal("Perl_Raid"..num):Hide();
			end
		else
			getglobal("Perl_Raid"..num):Hide();
		end
	end

	if (hideemptyheaders == 1) then
		if (wa == 0) then
			Perl_Raid_Grp1:Hide();
		end
		if (m == 0) then
			Perl_Raid_Grp2:Hide();
		end
		if (p == 0) then
			Perl_Raid_Grp3:Hide();
		end
		if (wr == 0) then
			Perl_Raid_Grp4:Hide();
		end
		if (d == 0) then
			Perl_Raid_Grp5:Hide();
		end
		if (r == 0) then
			Perl_Raid_Grp6:Hide();
		end
		if (h == 0) then
			Perl_Raid_Grp7:Hide();
		end
		if (pa == 0) then
			Perl_Raid_Grp8:Hide();
		end
		if (s == 0) then
			Perl_Raid_Grp9:Hide();
		end
	end
end

function Perl_Raid_Sort_By_Group()
	local ga = 0;
	local gb = 0;
	local gc = 0;
	local gd = 0;
	local ge = 0;
	local gf = 0;
	local gg = 0;
	local gh = 0;

	local spacing, titlespacing;
	if (framestyle == 1) then
		if (verticalalign == 1) then
			spacing = 43;
			if (invertedgroups == 0) then
				titlespacing = 0;
			else
				titlespacing = 40;
			end
		else
			spacing = 78;
			titlespacing = 0;
		end
	elseif (framestyle == 2) then
		if (verticalalign == 1) then
			if (showborder == 1) then
				spacing = 26;
			else
				if (removespace == 1) then
					spacing = 30;
				else
					spacing = 33;
				end
			end
			if (invertedgroups == 0) then
				titlespacing = 20;
			else
				titlespacing = 40;
			end
		else
			if (showborder == 1) then
				spacing = 76;
			else
				if (removespace == 1) then
					spacing = 80;
				else
					spacing = 83;
				end
			end
			titlespacing = 20;
		end
	end

	Perl_Raid_Grp1_NameFrame_NameBarText:SetText("Group 1");
	Perl_Raid_Grp2_NameFrame_NameBarText:SetText("Group 2");
	Perl_Raid_Grp3_NameFrame_NameBarText:SetText("Group 3");
	Perl_Raid_Grp4_NameFrame_NameBarText:SetText("Group 4");
	Perl_Raid_Grp5_NameFrame_NameBarText:SetText("Group 5");
	Perl_Raid_Grp6_NameFrame_NameBarText:SetText("Group 6");
	Perl_Raid_Grp7_NameFrame_NameBarText:SetText("Group 7");
	Perl_Raid_Grp8_NameFrame_NameBarText:SetText("Group 8");

	for num=1,40 do
		if (UnitName("raid"..num) ~= nil) then
			local _, _, subgroup = GetRaidRosterInfo(num);
			if (subgroup == 1) then
				if (verticalalign == 1) then
					if (invertedgroups == 0) then
						getglobal("Perl_Raid"..num):SetPoint("TOPLEFT", "Perl_Raid_Grp1", "BOTTOMLEFT", 0, (2-(ga*spacing)+titlespacing));
					else
						getglobal("Perl_Raid"..num):SetPoint("TOPLEFT", "Perl_Raid_Grp1", "TOPLEFT", 0, -(2-(ga*spacing)-titlespacing));
					end
				else
					if (invertedgroups == 0) then
						getglobal("Perl_Raid"..num):SetPoint("TOPLEFT", "Perl_Raid_Grp1", "BOTTOMLEFT", (ga*spacing), 2+titlespacing);
					else
						getglobal("Perl_Raid"..num):SetPoint("TOPLEFT", "Perl_Raid_Grp1", "BOTTOMLEFT", -(ga*spacing), 2+titlespacing);
					end
				end
				ga = ga + 1;
				if (showgroup1 == 0) then
					getglobal("Perl_Raid"..num):Hide();
				else
					getglobal("Perl_Raid"..num):Show();
				end
			elseif (subgroup == 2) then
				if (verticalalign == 1) then
					if (invertedgroups == 0) then
						getglobal("Perl_Raid"..num):SetPoint("TOPLEFT", "Perl_Raid_Grp2", "BOTTOMLEFT", 0, (2-(gb*spacing)+titlespacing));
					else
						getglobal("Perl_Raid"..num):SetPoint("TOPLEFT", "Perl_Raid_Grp2", "TOPLEFT", 0, -(2-(gb*spacing)-titlespacing));
					end
				else
					if (invertedgroups == 0) then
						getglobal("Perl_Raid"..num):SetPoint("TOPLEFT", "Perl_Raid_Grp2", "BOTTOMLEFT", (gb*spacing), 2+titlespacing);
					else
						getglobal("Perl_Raid"..num):SetPoint("TOPLEFT", "Perl_Raid_Grp2", "BOTTOMLEFT", -(gb*spacing), 2+titlespacing);
					end
				end
				gb = gb + 1;
				if (showgroup2 == 0) then
					getglobal("Perl_Raid"..num):Hide();
				else
					getglobal("Perl_Raid"..num):Show();
				end
			elseif (subgroup == 3) then
				if (verticalalign == 1) then
					if (invertedgroups == 0) then
						getglobal("Perl_Raid"..num):SetPoint("TOPLEFT", "Perl_Raid_Grp3", "BOTTOMLEFT", 0, (2-(gc*spacing)+titlespacing));
					else
						getglobal("Perl_Raid"..num):SetPoint("TOPLEFT", "Perl_Raid_Grp3", "TOPLEFT", 0, -(2-(gc*spacing)-titlespacing));
					end
				else
					if (invertedgroups == 0) then
						getglobal("Perl_Raid"..num):SetPoint("TOPLEFT", "Perl_Raid_Grp3", "BOTTOMLEFT", (gc*spacing), 2+titlespacing);
					else
						getglobal("Perl_Raid"..num):SetPoint("TOPLEFT", "Perl_Raid_Grp3", "BOTTOMLEFT", -(gc*spacing), 2+titlespacing);
					end
				end
				gc = gc + 1;
				if (showgroup3 == 0) then
					getglobal("Perl_Raid"..num):Hide();
				else
					getglobal("Perl_Raid"..num):Show();
				end
			elseif (subgroup == 4) then
				if (verticalalign == 1) then
					if (invertedgroups == 0) then
						getglobal("Perl_Raid"..num):SetPoint("TOPLEFT", "Perl_Raid_Grp4", "BOTTOMLEFT", 0, (2-(gd*spacing)+titlespacing));
					else
						getglobal("Perl_Raid"..num):SetPoint("TOPLEFT", "Perl_Raid_Grp4", "TOPLEFT", 0, -(2-(gd*spacing)-titlespacing));
					end
				else
					if (invertedgroups == 0) then
						getglobal("Perl_Raid"..num):SetPoint("TOPLEFT", "Perl_Raid_Grp4", "BOTTOMLEFT", (gd*spacing), 2+titlespacing);
					else
						getglobal("Perl_Raid"..num):SetPoint("TOPLEFT", "Perl_Raid_Grp4", "BOTTOMLEFT", -(gd*spacing), 2+titlespacing);
					end
				end
				gd = gd + 1;
				if (showgroup4 == 0) then
					getglobal("Perl_Raid"..num):Hide();
				else
					getglobal("Perl_Raid"..num):Show();
				end
			elseif (subgroup == 5) then
				if (verticalalign == 1) then
					if (invertedgroups == 0) then
						getglobal("Perl_Raid"..num):SetPoint("TOPLEFT", "Perl_Raid_Grp5", "BOTTOMLEFT", 0, (2-(ge*spacing)+titlespacing));
					else
						getglobal("Perl_Raid"..num):SetPoint("TOPLEFT", "Perl_Raid_Grp5", "TOPLEFT", 0, -(2-(ge*spacing)-titlespacing));
					end
				else
					if (invertedgroups == 0) then
						getglobal("Perl_Raid"..num):SetPoint("TOPLEFT", "Perl_Raid_Grp5", "BOTTOMLEFT", (ge*spacing), 2+titlespacing);
					else
						getglobal("Perl_Raid"..num):SetPoint("TOPLEFT", "Perl_Raid_Grp5", "BOTTOMLEFT", -(ge*spacing), 2+titlespacing);
					end
				end
				ge = ge + 1;
				if (showgroup5 == 0) then
					getglobal("Perl_Raid"..num):Hide();
				else
					getglobal("Perl_Raid"..num):Show();
				end
			elseif (subgroup == 6) then
				if (verticalalign == 1) then
					if (invertedgroups == 0) then
						getglobal("Perl_Raid"..num):SetPoint("TOPLEFT", "Perl_Raid_Grp6", "BOTTOMLEFT", 0, (2-(gf*spacing)+titlespacing));
					else
						getglobal("Perl_Raid"..num):SetPoint("TOPLEFT", "Perl_Raid_Grp6", "TOPLEFT", 0, -(2-(gf*spacing)-titlespacing));
					end
				else
					if (invertedgroups == 0) then
						getglobal("Perl_Raid"..num):SetPoint("TOPLEFT", "Perl_Raid_Grp6", "BOTTOMLEFT", (gf*spacing), 2+titlespacing);
					else
						getglobal("Perl_Raid"..num):SetPoint("TOPLEFT", "Perl_Raid_Grp6", "BOTTOMLEFT", -(gf*spacing), 2+titlespacing);
					end
				end
				gf = gf + 1;
				if (showgroup6 == 0) then
					getglobal("Perl_Raid"..num):Hide();
				else
					getglobal("Perl_Raid"..num):Show();
				end
			elseif (subgroup == 7) then
				if (verticalalign == 1) then
					if (invertedgroups == 0) then
						getglobal("Perl_Raid"..num):SetPoint("TOPLEFT", "Perl_Raid_Grp7", "BOTTOMLEFT", 0, (2-(gg*spacing)+titlespacing));
					else
						getglobal("Perl_Raid"..num):SetPoint("TOPLEFT", "Perl_Raid_Grp7", "TOPLEFT", 0, -(2-(gg*spacing)-titlespacing));
					end
				else
					if (invertedgroups == 0) then
						getglobal("Perl_Raid"..num):SetPoint("TOPLEFT", "Perl_Raid_Grp7", "BOTTOMLEFT", (gg*spacing), 2+titlespacing);
					else
						getglobal("Perl_Raid"..num):SetPoint("TOPLEFT", "Perl_Raid_Grp7", "BOTTOMLEFT", -(gg*spacing), 2+titlespacing);
					end
				end
				gg = gg + 1;
				if (showgroup7 == 0) then
					getglobal("Perl_Raid"..num):Hide();
				else
					getglobal("Perl_Raid"..num):Show();
				end
			elseif (subgroup == 8) then
				if (verticalalign == 1) then
					if (invertedgroups == 0) then
						getglobal("Perl_Raid"..num):SetPoint("TOPLEFT", "Perl_Raid_Grp8", "BOTTOMLEFT", 0, (2-(gh*spacing)+titlespacing));
					else
						getglobal("Perl_Raid"..num):SetPoint("TOPLEFT", "Perl_Raid_Grp8", "TOPLEFT", 0, -(2-(gh*spacing)-titlespacing));
					end
				else
					if (invertedgroups == 0) then
						getglobal("Perl_Raid"..num):SetPoint("TOPLEFT", "Perl_Raid_Grp8", "BOTTOMLEFT", (gh*spacing), 2+titlespacing);
					else
						getglobal("Perl_Raid"..num):SetPoint("TOPLEFT", "Perl_Raid_Grp8", "BOTTOMLEFT", -(gh*spacing), 2+titlespacing);
					end
				end
				gh = gh + 1;
				if (showgroup8 == 0) then
					getglobal("Perl_Raid"..num):Hide();
				else
					getglobal("Perl_Raid"..num):Show();
				end
			else
				getglobal("Perl_Raid"..num):Hide();
			end
		else
			getglobal("Perl_Raid"..num):Hide();
		end
	end

	if (hideemptyheaders == 1) then
		if (ga == 0) then
			Perl_Raid_Grp1:Hide();
		end
		if (gb == 0) then
			Perl_Raid_Grp2:Hide();
		end
		if (gc == 0) then
			Perl_Raid_Grp3:Hide();
		end
		if (gd == 0) then
			Perl_Raid_Grp4:Hide();
		end
		if (ge == 0) then
			Perl_Raid_Grp5:Hide();
		end
		if (gf == 0) then
			Perl_Raid_Grp6:Hide();
		end
		if (gg == 0) then
			Perl_Raid_Grp7:Hide();
		end
		if (gh == 0) then
			Perl_Raid_Grp8:Hide();
		end
		Perl_Raid_Grp9:Hide();	-- There is no group 9, always hide in this mode
	end
end

function Perl_Raid_Reset_Name_Colors()
	for id=1,40 do
		if (UnitName("raid"..id) ~= nil) then
			Perl_Raid_Update_Name(id);		-- Update name and color it
		end
	end
end

function Perl_Raid_Connect_Frames()
	if (verticalalign == 1) then
		Perl_Raid_Grp2:SetPoint("TOPLEFT", Perl_Raid_Grp1, "TOPRIGHT", 0, 0);
		Perl_Raid_Grp3:SetPoint("TOPLEFT", Perl_Raid_Grp2, "TOPRIGHT", 0, 0);
		Perl_Raid_Grp4:SetPoint("TOPLEFT", Perl_Raid_Grp3, "TOPRIGHT", 0, 0);
		Perl_Raid_Grp5:SetPoint("TOPLEFT", Perl_Raid_Grp4, "TOPRIGHT", 0, 0);
		Perl_Raid_Grp6:SetPoint("TOPLEFT", Perl_Raid_Grp5, "TOPRIGHT", 0, 0);
		Perl_Raid_Grp7:SetPoint("TOPLEFT", Perl_Raid_Grp6, "TOPRIGHT", 0, 0);
		Perl_Raid_Grp8:SetPoint("TOPLEFT", Perl_Raid_Grp7, "TOPRIGHT", 0, 0);
		Perl_Raid_Grp9:SetPoint("TOPLEFT", Perl_Raid_Grp8, "TOPRIGHT", 0, 0);
	else
		Perl_Raid_Grp2:SetPoint("TOPLEFT", Perl_Raid_Grp1, "TOPLEFT", 0, -80);
		Perl_Raid_Grp3:SetPoint("TOPLEFT", Perl_Raid_Grp2, "TOPLEFT", 0, -80);
		Perl_Raid_Grp4:SetPoint("TOPLEFT", Perl_Raid_Grp3, "TOPLEFT", 0, -80);
		Perl_Raid_Grp5:SetPoint("TOPLEFT", Perl_Raid_Grp4, "TOPLEFT", 0, -80);
		Perl_Raid_Grp6:SetPoint("TOPLEFT", Perl_Raid_Grp5, "TOPLEFT", 0, -80);
		Perl_Raid_Grp7:SetPoint("TOPLEFT", Perl_Raid_Grp6, "TOPLEFT", 0, -80);
		Perl_Raid_Grp8:SetPoint("TOPLEFT", Perl_Raid_Grp7, "TOPLEFT", 0, -80);
		Perl_Raid_Grp9:SetPoint("TOPLEFT", Perl_Raid_Grp8, "TOPLEFT", 0, -80);
	end
end


--------------------------
-- Key Binding Functions --
--------------------------
function Perl_Raid_Toggle_Show_Hide()
	if (showgroup1 == 0 or showgroup2 == 0 or showgroup3 == 0 or showgroup4 == 0 or showgroup5 == 0 or showgroup6 == 0 or showgroup7 == 0 or showgroup8 == 0) then
		Perl_Raid_Show_Hide_All_Groups(1);
	else
		Perl_Raid_Show_Hide_All_Groups(0);
	end
end

function Perl_Raid_Toggle_Class_Group()
	if (sortraidbyclass == 1) then
		Perl_Raid_Set_Sort_By_Class(0);
	else
		Perl_Raid_Set_Sort_By_Class(1);
	end
end


--------------------------
-- GUI Config Functions --
--------------------------
function Perl_Raid_Set_Show_Group_One(newvalue)
	showgroup1 = newvalue;
	Perl_Raid_UpdateVars();
	Perl_Raid_Update();
end

function Perl_Raid_Set_Show_Group_Two(newvalue)
	showgroup2 = newvalue;
	Perl_Raid_UpdateVars();
	Perl_Raid_Update();
end

function Perl_Raid_Set_Show_Group_Three(newvalue)
	showgroup3 = newvalue;
	Perl_Raid_UpdateVars();
	Perl_Raid_Update();
end

function Perl_Raid_Set_Show_Group_Four(newvalue)
	showgroup4 = newvalue;
	Perl_Raid_UpdateVars();
	Perl_Raid_Update();
end

function Perl_Raid_Set_Show_Group_Five(newvalue)
	showgroup5 = newvalue;
	Perl_Raid_UpdateVars();
	Perl_Raid_Update();
end

function Perl_Raid_Set_Show_Group_Six(newvalue)
	showgroup6 = newvalue;
	Perl_Raid_UpdateVars();
	Perl_Raid_Update();
end

function Perl_Raid_Set_Show_Group_Seven(newvalue)
	showgroup7 = newvalue;
	Perl_Raid_UpdateVars();
	Perl_Raid_Update();
end

function Perl_Raid_Set_Show_Group_Eight(newvalue)
	showgroup8 = newvalue;
	Perl_Raid_UpdateVars();
	Perl_Raid_Update();
end

function Perl_Raid_Set_Show_Group_Nine(newvalue)
	showgroup9 = newvalue;
	Perl_Raid_UpdateVars();
	Perl_Raid_Update();
end

function Perl_Raid_Show_Hide_All_Groups(newvalue)
	showgroup1 = newvalue;
	showgroup2 = newvalue;
	showgroup3 = newvalue;
	showgroup4 = newvalue;
	showgroup5 = newvalue;
	showgroup6 = newvalue;
	showgroup7 = newvalue;
	showgroup8 = newvalue;
	showgroup9 = newvalue;
	Perl_Raid_UpdateVars();
	Perl_Raid_Update();
end

function Perl_Raid_Set_Sort_By_Class(newvalue)
	sortraidbyclass = newvalue;
	Perl_Raid_UpdateVars();
	Perl_Raid_Update();
end

function Perl_Raid_Set_Show_Health_Percents(newvalue)
	showhealthpercents = newvalue;
	Perl_Raid_UpdateVars();
	Perl_Raid_Update();
end

function Perl_Raid_Set_Show_Mana_Percents(newvalue)
	showmanapercents = newvalue;
	Perl_Raid_UpdateVars();
	Perl_Raid_Update();
end

function Perl_Raid_Set_Lock(newvalue)
	locked = newvalue;
	Perl_Raid_UpdateVars();
end

function Perl_Raid_Set_Group_Headers(newvalue)
	showheaders = newvalue;
	Perl_Raid_UpdateVars();
	Perl_Raid_Show_Hide_Group_Header();
end

function Perl_Raid_Set_Missing_Health(newvalue)
	showmissinghealth = newvalue;
	Perl_Raid_UpdateVars();
	Perl_Raid_Update();
end

function Perl_Raid_Set_Vertical(newvalue)
	verticalalign = newvalue;
	Perl_Raid_UpdateVars();
	Perl_Raid_Update();
end

function Perl_Raid_Set_Inverted(newvalue)
	invertedgroups = newvalue;
	Perl_Raid_UpdateVars();
	Perl_Raid_Update();
end

function Perl_Raid_Set_Buffs(newvalue)
	if (newvalue ~= nil) then
		showraidbuffs = newvalue;
	end
	if (showraidbuffs == 0) then
		for id=1,40 do
			for buffnum=1,8 do
				getglobal("Perl_Raid"..id.."_BuffFrame_Buff"..buffnum):Hide();
			end
		end
	end
	Perl_Raid_UpdateVars();
	Perl_Raid_Update();
end

function Perl_Raid_Set_Debuffs(newvalue)
	if (newvalue ~= nil) then
		showraiddebuffs = newvalue;
	end
	if (showraiddebuffs == 0) then
		for id=1,40 do
			for buffnum=1,8 do
				getglobal("Perl_Raid"..id.."_BuffFrame_Debuff"..buffnum):Hide();
			end
		end
	end
	Perl_Raid_UpdateVars();
	Perl_Raid_Update();
end

function Perl_Raid_Set_Color_Debuff_Names(newvalue)
	colordebuffnames = newvalue;
	Perl_Raid_UpdateVars();
	Perl_Raid_Reset_Name_Colors();
end

function Perl_Raid_Set_Class_Buffs(newvalue)
	displaycastablebuffs = newvalue;
	Perl_Raid_UpdateVars();
	Perl_Raid_Update();
end

function Perl_Raid_Set_Alternate_Frame_Style(newvalue)
	framestyle = newvalue;
	Perl_Raid_UpdateVars();
	Perl_Raid_Set_Layout();
	Perl_Raid_Initialize_Frame_Color();
	Perl_Raid_Update();
end

function Perl_Raid_Set_Show_Border(newvalue)
	showborder = newvalue;
	Perl_Raid_UpdateVars();
	Perl_Raid_Set_Layout();
	Perl_Raid_Initialize_Frame_Color();
	Perl_Raid_Update();
end

function Perl_Raid_Set_Remove_Space(newvalue)
	removespace = newvalue;
	Perl_Raid_UpdateVars();
	Perl_Raid_Set_Layout();
	Perl_Raid_Initialize_Frame_Color();
	Perl_Raid_Update();
end

function Perl_Raid_Set_Hide_Power_Bars(newvalue)
	hidepowerbars = newvalue;
	Perl_Raid_UpdateVars();
	Perl_Raid_Set_Layout();
	Perl_Raid_Initialize_Frame_Color();
	Perl_Raid_Update();
end

function Perl_Raid_Set_CTRA_Style_Tip(newvalue)
	ctrastyletip = newvalue;
	Perl_Raid_UpdateVars();
end

function Perl_Raid_Set_Hide_Empty_Headers(newvalue)
	hideemptyheaders = newvalue;
	Perl_Raid_UpdateVars();
	Perl_Raid_Update();
end

function Perl_Raid_Set_Scale(number)
	local unsavedscale;
	if (number ~= nil) then
		scale = (number / 100);					-- convert the user input to a wow acceptable value
	end
	unsavedscale = 1 - UIParent:GetEffectiveScale() + scale;	-- run it through the scaling formula introduced in 1.9
	for num=1,9 do
		getglobal("Perl_Raid_Grp"..num):SetScale(unsavedscale);
	end
	for num=1,40 do
		getglobal("Perl_Raid"..num):SetScale(unsavedscale);
	end
	Perl_Raid_UpdateVars();
end

function Perl_Raid_Set_Transparency(number)
	if (number ~= nil) then
		transparency = (number / 100);		-- convert the user input to a wow acceptable value
	end
	for num=1,40 do
		getglobal("Perl_Raid"..num):SetAlpha(transparency);
	end
	Perl_Raid_UpdateVars();
end


------------------------------
-- Saved Variable Functions --
------------------------------
function Perl_Raid_GetVars(name, updateflag)
	if (name == nil) then
		name = UnitName("player");
	end

	locked = Perl_Raid_Config[name]["Locked"];
	showgroup1 = Perl_Raid_Config[name]["ShowGroup1"];
	showgroup2 = Perl_Raid_Config[name]["ShowGroup2"];
	showgroup3 = Perl_Raid_Config[name]["ShowGroup3"];
	showgroup4 = Perl_Raid_Config[name]["ShowGroup4"];
	showgroup5 = Perl_Raid_Config[name]["ShowGroup5"];
	showgroup6 = Perl_Raid_Config[name]["ShowGroup6"];
	showgroup7 = Perl_Raid_Config[name]["ShowGroup7"];
	showgroup8 = Perl_Raid_Config[name]["ShowGroup8"];
	showgroup9 = Perl_Raid_Config[name]["ShowGroup9"];
	sortraidbyclass = Perl_Raid_Config[name]["SortRaidByClass"];
	transparency = Perl_Raid_Config[name]["Transparency"];
	scale = Perl_Raid_Config[name]["Scale"];
	showheaders = Perl_Raid_Config[name]["ShowHeaders"];
	showmissinghealth = Perl_Raid_Config[name]["ShowMissingHealth"];
	verticalalign = Perl_Raid_Config[name]["VerticalAlign"];
	invertedgroups = Perl_Raid_Config[name]["InvertedGroups"];
	showraiddebuffs = Perl_Raid_Config[name]["ShowDebuffs"];
	displaycastablebuffs = Perl_Raid_Config[name]["DisplayCastableBuffs"];
	showraidbuffs = Perl_Raid_Config[name]["ShowBuffs"];
	colordebuffnames = Perl_Raid_Config[name]["ColorDebuffNames"];
	framestyle = Perl_Raid_Config[name]["FrameStyle"];
	showborder = Perl_Raid_Config[name]["ShowBorder"];
	removespace = Perl_Raid_Config[name]["RemoveSpace"];
	hidepowerbars = Perl_Raid_Config[name]["HidePowerBars"];
	ctrastyletip = Perl_Raid_Config[name]["CTRAStyleTip"];
	showhealthpercents = Perl_Raid_Config[name]["ShowHealthPercents"];
	showmanapercents = Perl_Raid_Config[name]["ShowManaPercents"];
	hideemptyheaders = Perl_Raid_Config[name]["HideEmptyHeaders"];

	if (locked == nil) then
		locked = 0;
	end
	if (showgroup1 == nil) then
		showgroup1 = 1;
	end
	if (showgroup2 == nil) then
		showgroup2 = 1;
	end
	if (showgroup3 == nil) then
		showgroup3 = 1;
	end
	if (showgroup4 == nil) then
		showgroup4 = 1;
	end
	if (showgroup5 == nil) then
		showgroup5 = 1;
	end
	if (showgroup6 == nil) then
		showgroup6 = 1;
	end
	if (showgroup7 == nil) then
		showgroup7 = 1;
	end
	if (showgroup8 == nil) then
		showgroup8 = 1;
	end
	if (showgroup9 == nil) then
		showgroup9 = 1;
	end
	if (sortraidbyclass == nil) then
		sortraidbyclass = 1;
	end
	if (transparency == nil) then
		transparency = 1;
	end
	if (scale == nil) then
		scale = 1;
	end
	if (showheaders == nil) then
		showheaders = 1;
	end
	if (showmissinghealth == nil) then
		showmissinghealth = 0;
	end
	if (verticalalign == nil) then
		verticalalign = 1;
	end
	if (invertedgroups == nil) then
		invertedgroups = 0;
	end
	if (showraiddebuffs == nil) then
		showraiddebuffs = 0;
	end
	if (displaycastablebuffs == nil) then
		displaycastablebuffs = 0;
	end
	if (showraidbuffs == nil) then
		showraidbuffs = 0;
	end
	if (colordebuffnames == nil) then
		colordebuffnames = 0;
	end
	if (framestyle == nil) then
		framestyle = 1;
	end
	if (showborder == nil) then
		showborder = 1;
	end
	if (removespace == nil) then
		removespace = 0;
	end
	if (hidepowerbars == nil) then
		hidepowerbars = 0;
	end
	if (ctrastyletip == nil) then
		ctrastyletip = 1;
	end
	if (showhealthpercents == nil) then
		showhealthpercents = 0;
	end
	if (showmanapercents == nil) then
		showmanapercents = 0;
	end
	if (hideemptyheaders == nil) then
		hideemptyheaders = 0;
	end

	if (updateflag == 1) then
		-- Save the new values
		Perl_Raid_UpdateVars();

		-- Call any code we need to activate them
		Perl_Raid_Set_Scale();
		Perl_Raid_Set_Transparency();
		Perl_Raid_Update();
		return;
	end

	local vars = {
		["locked"] = locked,
		["showgroup1"] = showgroup1,
		["showgroup2"] = showgroup2,
		["showgroup3"] = showgroup3,
		["showgroup4"] = showgroup4,
		["showgroup5"] = showgroup5,
		["showgroup6"] = showgroup6,
		["showgroup7"] = showgroup7,
		["showgroup8"] = showgroup8,
		["showgroup9"] = showgroup9,
		["sortraidbyclass"] = sortraidbyclass,
		["transparency"] = transparency,
		["scale"] = scale,
		["showheaders"] = showheaders,
		["showmissinghealth"] = showmissinghealth,
		["verticalalign"] = verticalalign,
		["invertedgroups"] = invertedgroups,
		["showraiddebuffs"] = showraiddebuffs,
		["displaycastablebuffs"] = displaycastablebuffs,
		["showraidbuffs"] = showraidbuffs,
		["colordebuffnames"] = colordebuffnames,
		["framestyle"] = framestyle,
		["showborder"] = showborder,
		["removespace"] = removespace,
		["hidepowerbars"] = hidepowerbars,
		["ctrastyletip"] = ctrastyletip,
		["showhealthpercents"] = showhealthpercents,
		["showmanapercents"] = showmanapercents,
		["hideemptyheaders"] = hideemptyheaders,
	}
	return vars;
end

function Perl_Raid_UpdateVars(vartable)
	if (vartable ~= nil) then
		-- Sanity checks in case you use a load from an old version
		if (vartable["Global Settings"] ~= nil) then
			if (vartable["Global Settings"]["Locked"] ~= nil) then
				locked = vartable["Global Settings"]["Locked"];
			else
				locked = nil;
			end
			if (vartable["Global Settings"]["ShowGroup1"] ~= nil) then
				showgroup1 = vartable["Global Settings"]["ShowGroup1"];
			else
				showgroup1 = nil;
			end
			if (vartable["Global Settings"]["ShowGroup2"] ~= nil) then
				showgroup2 = vartable["Global Settings"]["ShowGroup2"];
			else
				showgroup2 = nil;
			end
			if (vartable["Global Settings"]["ShowGroup3"] ~= nil) then
				showgroup3 = vartable["Global Settings"]["ShowGroup3"];
			else
				showgroup3 = nil;
			end
			if (vartable["Global Settings"]["ShowGroup4"] ~= nil) then
				showgroup4 = vartable["Global Settings"]["ShowGroup4"];
			else
				showgroup4 = nil;
			end
			if (vartable["Global Settings"]["ShowGroup5"] ~= nil) then
				showgroup5 = vartable["Global Settings"]["ShowGroup5"];
			else
				showgroup5 = nil;
			end
			if (vartable["Global Settings"]["ShowGroup6"] ~= nil) then
				showgroup6 = vartable["Global Settings"]["ShowGroup6"];
			else
				showgroup6 = nil;
			end
			if (vartable["Global Settings"]["ShowGroup7"] ~= nil) then
				showgroup7 = vartable["Global Settings"]["ShowGroup7"];
			else
				showgroup7 = nil;
			end
			if (vartable["Global Settings"]["ShowGroup8"] ~= nil) then
				showgroup8 = vartable["Global Settings"]["ShowGroup8"];
			else
				showgroup8 = nil;
			end
			if (vartable["Global Settings"]["ShowGroup9"] ~= nil) then
				showgroup9 = vartable["Global Settings"]["ShowGroup9"];
			else
				showgroup9 = nil;
			end
			if (vartable["Global Settings"]["SortRaidByClass"] ~= nil) then
				sortraidbyclass = vartable["Global Settings"]["SortRaidByClass"];
			else
				sortraidbyclass = nil;
			end
			if (vartable["Global Settings"]["Transparency"] ~= nil) then
				transparency = vartable["Global Settings"]["Transparency"];
			else
				transparency = nil;
			end
			if (vartable["Global Settings"]["Scale"] ~= nil) then
				scale = vartable["Global Settings"]["Scale"];
			else
				scale = nil;
			end
			if (vartable["Global Settings"]["ShowHeaders"] ~= nil) then
				showheaders = vartable["Global Settings"]["ShowHeaders"];
			else
				showheaders = nil;
			end
			if (vartable["Global Settings"]["ShowMissingHealth"] ~= nil) then
				showmissinghealth = vartable["Global Settings"]["ShowMissingHealth"];
			else
				showmissinghealth = nil;
			end
			if (vartable["Global Settings"]["VerticalAlign"] ~= nil) then
				verticalalign = vartable["Global Settings"]["VerticalAlign"];
			else
				verticalalign = nil;
			end
			if (vartable["Global Settings"]["InvertedGroups"] ~= nil) then
				invertedgroups = vartable["Global Settings"]["InvertedGroups"];
			else
				invertedgroups = nil;
			end
			if (vartable["Global Settings"]["ShowDebuffs"] ~= nil) then
				showraiddebuffs = vartable["Global Settings"]["ShowDebuffs"];
			else
				showraiddebuffs = nil;
			end
			if (vartable["Global Settings"]["DisplayCastableBuffs"] ~= nil) then
				displaycastablebuffs = vartable["Global Settings"]["DisplayCastableBuffs"];
			else
				displaycastablebuffs = nil;
			end
			if (vartable["Global Settings"]["ShowBuffs"] ~= nil) then
				showraidbuffs = vartable["Global Settings"]["ShowBuffs"];
			else
				showraidbuffs = nil;
			end
			if (vartable["Global Settings"]["ColorDebuffNames"] ~= nil) then
				colordebuffnames = vartable["Global Settings"]["ColorDebuffNames"];
			else
				colordebuffnames = nil;
			end
			if (vartable["Global Settings"]["FrameStyle"] ~= nil) then
				framestyle = vartable["Global Settings"]["FrameStyle"];
			else
				framestyle = nil;
			end
			if (vartable["Global Settings"]["ShowBorder"] ~= nil) then
				showborder = vartable["Global Settings"]["ShowBorder"];
			else
				showborder = nil;
			end
			if (vartable["Global Settings"]["RemoveSpace"] ~= nil) then
				removespace = vartable["Global Settings"]["RemoveSpace"];
			else
				removespace = nil;
			end
			if (vartable["Global Settings"]["HidePowerBars"] ~= nil) then
				hidepowerbars = vartable["Global Settings"]["HidePowerBars"];
			else
				hidepowerbars = nil;
			end
			if (vartable["Global Settings"]["CTRAStyleTip"] ~= nil) then
				ctrastyletip = vartable["Global Settings"]["CTRAStyleTip"];
			else
				ctrastyletip = nil;
			end
			if (vartable["Global Settings"]["ShowHealthPercents"] ~= nil) then
				showhealthpercents = vartable["Global Settings"]["ShowHealthPercents"];
			else
				showhealthpercents = nil;
			end
			if (vartable["Global Settings"]["ShowManaPercents"] ~= nil) then
				showmanapercents = vartable["Global Settings"]["ShowManaPercents"];
			else
				showmanapercents = nil;
			end
			if (vartable["Global Settings"]["HideEmptyHeaders"] ~= nil) then
				hideemptyheaders = vartable["Global Settings"]["HideEmptyHeaders"];
			else
				hideemptyheaders = nil;
			end
		end

		-- Set the new values if any new values were found, same defaults as above
		if (locked == nil) then
			locked = 0;
		end
		if (showgroup1 == nil) then
			showgroup1 = 1;
		end
		if (showgroup2 == nil) then
			showgroup2 = 1;
		end
		if (showgroup3 == nil) then
			showgroup3 = 1;
		end
		if (showgroup4 == nil) then
			showgroup4 = 1;
		end
		if (showgroup5 == nil) then
			showgroup5 = 1;
		end
		if (showgroup6 == nil) then
			showgroup6 = 1;
		end
		if (showgroup7 == nil) then
			showgroup7 = 1;
		end
		if (showgroup8 == nil) then
			showgroup8 = 1;
		end
		if (showgroup9 == nil) then
			showgroup9 = 1;
		end
		if (sortraidbyclass == nil) then
			sortraidbyclass = 1;
		end
		if (transparency == nil) then
			transparency = 1;
		end
		if (scale == nil) then
			scale = 1;
		end
		if (showheaders == nil) then
			showheaders = 1;
		end
		if (showmissinghealth == nil) then
			showmissinghealth = 0;
		end
		if (verticalalign == nil) then
			verticalalign = 1;
		end
		if (invertedgroups == nil) then
			invertedgroups = 0;
		end
		if (showraiddebuffs == nil) then
			showraiddebuffs = 0;
		end
		if (displaycastablebuffs == nil) then
			displaycastablebuffs = 0;
		end
		if (showraidbuffs == nil) then
			showraidbuffs = 0;
		end
		if (colordebuffnames == nil) then
			colordebuffnames = 0;
		end
		if (framestyle == nil) then
			framestyle = 1;
		end
		if (showborder == nil) then
			showborder = 1;
		end
		if (removespace == nil) then
			removespace = 0;
		end
		if (hidepowerbars == nil) then
			hidepowerbars = 0;
		end
		if (ctrastyletip == nil) then
			ctrastyletip = 1;
		end
		if (showhealthpercents == nil) then
			showhealthpercents = 0;
		end
		if (showmanapercents == nil) then
			showmanapercents = 0;
		end
		if (hideemptyheaders == nil) then
			hideemptyheaders = 0;
		end

		-- Call any code we need to activate them
		Perl_Raid_Set_Scale();
		Perl_Raid_Set_Transparency();
		Perl_Raid_Update();
	end

	-- IFrameManager Support
	if (IFrameManager) then
		IFrameManager:Refresh();
	end

	Perl_Raid_Config[UnitName("player")] = {
		["Locked"] = locked,
		["ShowGroup1"] = showgroup1,
		["ShowGroup2"] = showgroup2,
		["ShowGroup3"] = showgroup3,
		["ShowGroup4"] = showgroup4,
		["ShowGroup5"] = showgroup5,
		["ShowGroup6"] = showgroup6,
		["ShowGroup7"] = showgroup7,
		["ShowGroup8"] = showgroup8,
		["ShowGroup9"] = showgroup9,
		["SortRaidByClass"] = sortraidbyclass,
		["Transparency"] = transparency,
		["Scale"] = scale,
		["ShowHeaders"] = showheaders,
		["ShowMissingHealth"] = showmissinghealth,
		["VerticalAlign"] = verticalalign,
		["InvertedGroups"] = invertedgroups,
		["ShowDebuffs"] = showraiddebuffs,
		["DisplayCastableBuffs"] = displaycastablebuffs,
		["ShowBuffs"] = showraidbuffs,
		["ColorDebuffNames"] = colordebuffnames,
		["FrameStyle"] = framestyle,
		["ShowBorder"] = showborder,
		["RemoveSpace"] = removespace,
		["HidePowerBars"] = hidepowerbars,
		["CTRAStyleTip"] = ctrastyletip,
		["ShowHealthPercents"] = showhealthpercents,
		["ShowManaPercents"] = showmanapercents,
		["HideEmptyHeaders"] = hideemptyheaders,
	};
end


--------------------
-- Buff Functions --
--------------------
function Perl_Raid_Buff_UpdateAll(id)
	local raidid = "raid"..id;
	local button, buffCount, buffTexture, buffApplications, color, debuffType;							-- Variables for both buffs and debuffs (yes, I'm using buff names for debuffs, wanna fight about it?)

	if (colordebuffnames == 1) then
		Perl_Raid_UpdateDebuffColors(id);											-- Update names for curable debuffs
	end

	if (UnitName(raidid)) then
		if (showraidbuffs == 1) then
			for buffnum=1,8 do												-- Start main buff loop
				buffTexture, buffApplications = UnitBuff(raidid, buffnum, displaycastablebuffs);			-- Get the texture, buff stacking, and class specific information if any
				button = getglobal("Perl_Raid"..id.."_BuffFrame_Buff"..buffnum);					-- Create the main icon for the buff
				if (buffTexture) then											-- If there is a valid texture, proceed with buff icon creation
					getglobal(button:GetName().."Icon"):SetTexture(buffTexture);					-- Set the texture
					getglobal(button:GetName().."DebuffBorder"):Hide();						-- Hide the debuff border
					buffCount = getglobal(button:GetName().."Count");						-- Declare the buff counting text variable
					if (buffApplications > 1) then
						buffCount:SetText(buffApplications);							-- Set the text to the number of applications if greater than 0
						buffCount:Show();									-- Show the text
					else
						buffCount:Hide();									-- Hide the text if equal to 0
					end
					button:Show();											-- Show the final buff icon
				else
					button:Hide();											-- Hide the icon since there isn't a buff in this position
				end
			end														-- End main buff loop
		end

		if (showraiddebuffs == 1) then
			for debuffnum=1,8 do												-- Start main debuff loop
				buffTexture, buffApplications, debuffType = UnitDebuff(raidid, debuffnum, displaycastablebuffs);	-- Get the texture, debuff stacking, and class specific information if any
				button = getglobal("Perl_Raid"..id.."_BuffFrame_Debuff"..debuffnum);					-- Create the main icon for the debuff
				if (buffTexture) then											-- If there is a valid texture, proceed with debuff icon creation
					getglobal(button:GetName().."Icon"):SetTexture(buffTexture);					-- Set the texture
					if (debuffType) then
						color = DebuffTypeColor[debuffType];
					else
						color = DebuffTypeColor[PERL_LOCALIZED_BUFF_NONE];
					end
					getglobal(button:GetName().."DebuffBorder"):SetVertexColor(color.r, color.g, color.b);		-- Set the debuff border color
					getglobal(button:GetName().."DebuffBorder"):Show();						-- Show the debuff border
					buffCount = getglobal(button:GetName().."Count");						-- Declare the debuff counting text variable
					if (buffApplications > 1) then
						buffCount:SetText(buffApplications);							-- Set the text to the number of applications if greater than 0
						buffCount:Show();									-- Show the text
					else
						buffCount:Hide();									-- Hide the text if equal to 0
					end
					button:Show();											-- Show the final debuff icon
				else
					button:Hide();											-- Hide the icon since there isn't a debuff in this position
				end
			end														-- End main debuff loop
		end

		if (verticalalign == 1) then
			getglobal("Perl_Raid"..id.."_BuffFrame"):SetPoint("TOPLEFT", "Perl_Raid"..id.."_StatsFrame", "TOPRIGHT", -3, -5);
		else
			getglobal("Perl_Raid"..id.."_BuffFrame"):SetPoint("TOPLEFT", "Perl_Raid"..id.."_StatsFrame", "BOTTOMLEFT", 0, -2);
		end
	end
end

function Perl_Raid_UpdateDebuffColors(id)
	local class = UnitClass("player");
	local raidid = "raid"..id;

	if (class == PERL_LOCALIZED_DRUID) then
		if (Perl_Raid_UnitDebuffType(raidid, PERL_LOCALIZED_BUFF_CURSE)) then
			if (framestyle == 1) then
				getglobal("Perl_Raid"..id.."_Name_NameBarText"):SetTextColor(1, 0, 0);
			elseif (framestyle == 2) then
				getglobal("Perl_Raid"..id.."_StatsFrame"):SetBackdropColor(1, 0, 0.75, 1);
			end
			return;
		end
		if (Perl_Raid_UnitDebuffType(raidid, PERL_LOCALIZED_BUFF_POISON)) then
			if (framestyle == 1) then
				getglobal("Perl_Raid"..id.."_Name_NameBarText"):SetTextColor(1, 0, 0);
			elseif (framestyle == 2) then
				getglobal("Perl_Raid"..id.."_StatsFrame"):SetBackdropColor(0, 0.5, 0, 1);
			end
			return;
		end
	elseif (class == PERL_LOCALIZED_MAGE) then
		if (Perl_Raid_UnitDebuffType(raidid, PERL_LOCALIZED_BUFF_CURSE)) then
			if (framestyle == 1) then
				getglobal("Perl_Raid"..id.."_Name_NameBarText"):SetTextColor(1, 0, 0);
			elseif (framestyle == 2) then
				getglobal("Perl_Raid"..id.."_StatsFrame"):SetBackdropColor(1, 0, 0.75, 1);
			end
			return;
		end
	elseif (class == PERL_LOCALIZED_PALADIN) then
		if (Perl_Raid_UnitDebuffType(raidid, PERL_LOCALIZED_BUFF_DISEASE)) then
			if (framestyle == 1) then
				getglobal("Perl_Raid"..id.."_Name_NameBarText"):SetTextColor(1, 0, 0);
			elseif (framestyle == 2) then
				getglobal("Perl_Raid"..id.."_StatsFrame"):SetBackdropColor(1, 1, 0, 1);
			end
			return;
		end
		if (Perl_Raid_UnitDebuffType(raidid, PERL_LOCALIZED_BUFF_MAGIC)) then
			if (framestyle == 1) then
				getglobal("Perl_Raid"..id.."_Name_NameBarText"):SetTextColor(1, 0, 0);
			elseif (framestyle == 2) then
				getglobal("Perl_Raid"..id.."_StatsFrame"):SetBackdropColor(1, 0, 0, 1);
			end
			return;
		end
		if (Perl_Raid_UnitDebuffType(raidid, PERL_LOCALIZED_BUFF_POISON)) then
			if (framestyle == 1) then
				getglobal("Perl_Raid"..id.."_Name_NameBarText"):SetTextColor(1, 0, 0);
			elseif (framestyle == 2) then
				getglobal("Perl_Raid"..id.."_StatsFrame"):SetBackdropColor(0, 0.5, 0, 1);
			end
			return;
		end
	elseif (class == PERL_LOCALIZED_PRIEST) then
		if (Perl_Raid_UnitDebuffType(raidid, PERL_LOCALIZED_BUFF_DISEASE)) then
			if (framestyle == 1) then
				getglobal("Perl_Raid"..id.."_Name_NameBarText"):SetTextColor(1, 0, 0);
			elseif (framestyle == 2) then
				getglobal("Perl_Raid"..id.."_StatsFrame"):SetBackdropColor(1, 1, 0, 1);
			end
			return;
		end
		if (Perl_Raid_UnitDebuffType(raidid, PERL_LOCALIZED_BUFF_MAGIC)) then
			if (framestyle == 1) then
				getglobal("Perl_Raid"..id.."_Name_NameBarText"):SetTextColor(1, 0, 0);
			elseif (framestyle == 2) then
				getglobal("Perl_Raid"..id.."_StatsFrame"):SetBackdropColor(1, 0, 0, 1);
			end
			return;
		end
	elseif (class == PERL_LOCALIZED_SHAMAN) then
		if (Perl_Raid_UnitDebuffType(raidid, PERL_LOCALIZED_BUFF_DISEASE)) then
			if (framestyle == 1) then
				getglobal("Perl_Raid"..id.."_Name_NameBarText"):SetTextColor(1, 0, 0);
			elseif (framestyle == 2) then
				getglobal("Perl_Raid"..id.."_StatsFrame"):SetBackdropColor(1, 1, 0, 1);
			end
			return;
		end
		if (Perl_Raid_UnitDebuffType(raidid, PERL_LOCALIZED_BUFF_POISON)) then
			if (framestyle == 1) then
				getglobal("Perl_Raid"..id.."_Name_NameBarText"):SetTextColor(1, 0, 0);
			elseif (framestyle == 2) then
				getglobal("Perl_Raid"..id.."_StatsFrame"):SetBackdropColor(0, 0.5, 0, 1);
			end
			return;
		end
	end

	if (framestyle == 1) then
		local raidclass = UnitClass(raidid);
		if (raidclass == PERL_LOCALIZED_WARRIOR) then
			getglobal("Perl_Raid"..id.."_Name_NameBarText"):SetTextColor(0.78, 0.61, 0.43);
		elseif (raidclass == PERL_LOCALIZED_MAGE) then
			getglobal("Perl_Raid"..id.."_Name_NameBarText"):SetTextColor(0.41, 0.8, 0.94);
		elseif (raidclass == PERL_LOCALIZED_ROGUE) then
			getglobal("Perl_Raid"..id.."_Name_NameBarText"):SetTextColor(1, 0.96, 0.41);
		elseif (raidclass == PERL_LOCALIZED_DRUID) then
			getglobal("Perl_Raid"..id.."_Name_NameBarText"):SetTextColor(1, 0.49, 0.04);
		elseif (raidclass == PERL_LOCALIZED_HUNTER) then
			getglobal("Perl_Raid"..id.."_Name_NameBarText"):SetTextColor(0.67, 0.83, 0.45);
		elseif (raidclass == PERL_LOCALIZED_SHAMAN) then
			getglobal("Perl_Raid"..id.."_Name_NameBarText"):SetTextColor(0.96, 0.55, 0.73);
		elseif (raidclass == PERL_LOCALIZED_PRIEST) then
			getglobal("Perl_Raid"..id.."_Name_NameBarText"):SetTextColor(1, 1, 1);
		elseif (raidclass == PERL_LOCALIZED_WARLOCK) then
			getglobal("Perl_Raid"..id.."_Name_NameBarText"):SetTextColor(0.58, 0.51, 0.79);
		elseif (raidclass == PERL_LOCALIZED_PALADIN) then
			getglobal("Perl_Raid"..id.."_Name_NameBarText"):SetTextColor(0.96, 0.55, 0.73);
		end
	elseif (framestyle == 2) then
		getglobal("Perl_Raid"..id.."_StatsFrame"):SetBackdropColor(0, 0, 0, 1);
	end
end

function Perl_Raid_UnitDebuffType(unit, debuffType)
	local i = 1;

	while (UnitDebuff(unit, i, displaycastablebuffs)) do
		Perl_Raid_Tooltip:SetOwner(this, "ANCHOR_BOTTOMRIGHT");
		Perl_Raid_Tooltip:SetUnitDebuff(unit, i);
		if (Perl_Raid_TooltipTextRight1:GetText() == debuffType and Perl_Raid_TooltipTextRight1:GetText() ~= "") then
			Perl_Raid_Tooltip:Hide();
			return 1;
		end
		i = i + 1;
	end

	Perl_Raid_Tooltip:Hide();
	return nil;
end

function Perl_Raid_SetBuffTooltip()
	GameTooltip:SetOwner(this, "ANCHOR_BOTTOMRIGHT");
	if (this:GetID() > 8) then
		GameTooltip:SetUnitDebuff("raid"..this:GetParent():GetParent():GetID(), this:GetID()-8, displaycastablebuffs);	-- 8 being the number of buffs before debuffs in the xml
	else
		GameTooltip:SetUnitBuff("raid"..this:GetParent():GetParent():GetID(), this:GetID(), displaycastablebuffs);
	end
end


--------------------
-- Click Handlers --
--------------------
function Perl_Raid_MouseClick(button)
	local id = this:GetID();

	if (Perl_Custom_ClickFunction) then				-- Check to see if someone defined a custom click function
		if (Perl_Custom_ClickFunction(button, "raid"..id)) then	-- If the function returns true, then we return
			return;
		end
	end								-- Otherwise, it did nothing, so take default action

	if (PCUF_CASTPARTYSUPPORT == 1) then
		if (CastPartyConfig) then
			CastParty.Event.OnClickByUnit(button, "raid"..id);
			return;
		elseif (Genesis_MouseHeal and Genesis_MouseHeal("raid"..id, button)) then
			return;
		elseif (CH_Config and CH_Config.PCUFEnabled) then
			if (CH_Config.PCUFEnabled) then
				CH_UnitClicked("raid"..id, button);
				return;
			end
		elseif (SmartHeal) then
			if (SmartHeal.Loaded and SmartHeal:getConfig("enable", "clickmode")) then
				local KeyDownType = SmartHeal:GetClickHealButton();
				if(KeyDownType and KeyDownType ~= "undetermined") then
					SmartHeal:ClickHeal(KeyDownType..button, "raid"..id);
				else
					SmartHeal:DefaultClick(button, "raid"..id);
				end
				return;
			end
		end
	end

	if (button == "LeftButton") then
		TargetUnit("raid"..id);
		return;
	end
end

function Perl_Raid_DragStart(button)
	if (button == "LeftButton" and locked == 0) then
		this:StartMoving();
	end
end

function Perl_Raid_DragStop(button)
	this:StopMovingOrSizing();
end


-------------
-- Tooltip --
-------------
function Perl_Raid_Tip()
	if (ctrastyletip == 1) then
		local id = this:GetID();
		local raidid = "raid"..id;
		local name, rank, subgroup, level, class, fileName, zone, online, isDead;
		local race;

		name, rank, subgroup, level, class, fileName, zone, online, isDead = GetRaidRosterInfo(id);
		race = UnitRace(raidid);
		class = UnitClass(raidid);

		local xp = "LEFT";
		local yp = "BOTTOM";
		local xthis, ythis = this:GetCenter();
		local xui, yui = UIParent:GetCenter();
		if ( xthis < xui ) then
			xp = "RIGHT";
		end
		if ( ythis < yui ) then
			yp = "TOP";
		end
		GameTooltip:SetOwner(this, "ANCHOR_" .. yp .. xp);

		local color = RAID_CLASS_COLORS[fileName];
		if ( not color ) then
			color = { ["r"] = 1, ["g"] = 1, ["b"] = 1 };
		end
		GameTooltip:AddDoubleLine(name, level, color.r, color.g, color.b, 1, 1, 1);

		if ( race and class ) then
			GameTooltip:AddLine(race .. " " .. class, 1, 1, 1);
		end

		GameTooltip:AddLine(zone, 1, 1, 1);

		if (IsAddOnLoaded("CT_RaidAssist")) then
			local stats = CT_RA_Stats[name];
			local isVirtual;
			if ( not name and tempOptions["SORTTYPE"] == "virtual" ) then
				isVirtual = 1;
				name, level = "Virtual " .. id, 60;
			end
			local version = stats;
			if ( version ) then
				version = version["Version"];
			end

			if ( not version and not isVirtual ) then
				if (GetLocale() == "koKR") then
					if ( not stats or not stats["Reporting"] ) then
						GameTooltip:AddLine("공격대 도우미 없음", 0.7, 0.7, 0.7);
					else
						GameTooltip:AddLine("공격대 도우미 <1.077", 1, 1, 1);
					end
				elseif (GetLocale() == "zhCN") then
					if ( not stats or not stats["Reporting"] ) then
						GameTooltip:AddLine("没有找到团队助手", 0.7, 0.7, 0.7);
					else
						GameTooltip:AddLine("团队助手<1.077", 1, 1, 1);
					end
				else
					if ( not stats or not stats["Reporting"] ) then
						GameTooltip:AddLine("No CTRA Found", 0.7, 0.7, 0.7);
					else
						GameTooltip:AddLine("CTRA <1.077", 1, 1, 1);
					end
				end
			elseif ( not isVirtual ) then
				if (GetLocale() == "koKR") then
					GameTooltip:AddLine("공격대 도우미 " .. version, 1, 1, 1);
				elseif (GetLocale() == "zhCN") then
					GameTooltip:AddLine("团队助手" .. version, 1, 1, 1);
				else
					GameTooltip:AddLine("CTRA " .. version, 1, 1, 1);
				end
			end
			if ( stats and stats["AFK"] ) then
				if ( type(stats["AFK"][1]) == "string" ) then
					if (GetLocale() == "koKR") then
						GameTooltip:AddLine("자리비움: " .. stats["AFK"][1]);
					elseif (GetLocale() == "zhCN") then
						GameTooltip:AddLine("暂离: " .. stats["AFK"][1]);
					else
						GameTooltip:AddLine("AFK: " .. stats["AFK"][1]);
					end
				end
				if (GetLocale() == "koKR") then
					GameTooltip:AddLine(CT_RA_FormatTime(stats["AFK"][2]) .. " 째 자리비움 상태");
				elseif (GetLocale() == "znCN") then
					GameTooltip:AddLine(CT_RA_FormatTime(stats["AFK"][2]) .. "暂离");
				else
					GameTooltip:AddLine("AFK for " .. CT_RA_FormatTime(stats["AFK"][2]));
				end
			elseif ( CT_RA_Stats[name] and stats["DND"] ) then
				if ( type(stats["DND"][1]) == "string" ) then
					if (GetLocale() == "koKR") then
						GameTooltip:AddLine("다른용무중: " .. stats["DND"][1]);
					elseif (GetLocale() == "zhCN") then
						GameTooltip:AddLine("请勿打扰: " .. stats["DND"][1]);
					else
						GameTooltip:AddLine("DND: " .. stats["DND"][1]);
					end
				end
				if (GetLocale() == "koKR") then
					GameTooltip:AddLine(CT_RA_FormatTime(stats["DND"][2]) .. " 째 다른 용무중 상태");
				elseif (GetLocale() == "zhCN") then
					GameTooltip:AddLine(CT_RA_FormatTime(stats["DND"][2]) .. "请勿打扰");
				else
					GameTooltip:AddLine("DND for " .. CT_RA_FormatTime(stats["DND"][2]));
				end
			end
			if ( stats and stats["Offline"] ) then
				if (GetLocale() == "koKR") then
					GameTooltip:AddLine(CT_RA_FormatTime(stats["Offline"]) .. " 째 오프라인 상태");
				elseif (GetLocale() == "zhCN") then
					GameTooltip:AddLine(CT_RA_FormatTime(stats["Offline"]) .. "离线");
				else
					GameTooltip:AddLine("Offline for " .. CT_RA_FormatTime(stats["Offline"]));
				end
			elseif ( stats and stats["FD"] ) then
				if ( stats["FD"] < 360 ) then
					if (GetLocale() == "koKR") then
						GameTooltip:AddLine(CT_RA_FormatTime(360-stats["FD"]) .. " 째 죽은척 중");
					elseif (GetLocale() == "zhCN") then
						GameTooltip:AddLine(CT_RA_FormatTime(360-stats["FD"]) .. "死亡");
					else
						GameTooltip:AddLine("Dying in " .. CT_RA_FormatTime(360-stats["FD"]));
					end
				end
			elseif ( stats and stats["Ressed"] ) then
				if ( stats["Ressed"] == 1 ) then
					GameTooltip:AddLine(PERL_LOCALIZED_STATUS_RESURRECTED);
				elseif ( stats["Ressed"] == 2 ) then
					GameTooltip:AddLine(PERL_LOCALIZED_STATUS_SS_AVAILABLE);
				end
			elseif ( stats and stats["Dead"] ) then
				if (GetLocale() == "koKR") then
					if ( stats["Dead"] < 360 and not UnitIsGhost(raidid) ) then
						GameTooltip:AddLine("무덤이동까지 " .. CT_RA_FormatTime(360-stats["Dead"]) .. " 남음");
					else
						GameTooltip:AddLine(CT_RA_FormatTime(stats["Dead"]) .. " 째 유령 상태");
					end
				elseif (GetLocale() == "zhCN") then
					if ( stats["Dead"] < 360 and not UnitIsGhost(raidid) ) then
						GameTooltip:AddLine("在死亡中" .. CT_RA_FormatTime(360-stats["Dead"]) .. "释放");
					else
						GameTooltip:AddLine(CT_RA_FormatTime(stats["Dead"]) .. "死亡");
					end
				else
					if ( stats["Dead"] < 360 and not UnitIsGhost(raidid) ) then
						GameTooltip:AddLine("Releasing in " .. CT_RA_FormatTime(360-stats["Dead"]));
					else
						GameTooltip:AddLine("Dead for " .. CT_RA_FormatTime(stats["Dead"]));
					end
				end
			end
			if (GetLocale() == "koKR") then
				if ( stats and stats["Rebirth"] and stats["Rebirth"] > 0 ) then
					GameTooltip:AddLine("환생 남은시간: " .. CT_RA_FormatTime(stats["Rebirth"]));
				elseif ( stats and stats["Reincarnation"] and stats["Reincarnation"] > 0 ) then
					GameTooltip:AddLine("윤회 남은시간: " .. CT_RA_FormatTime(stats["Reincarnation"]));
				elseif ( stats and stats["Soulstone"] and stats["Soulstone"] > 0 ) then
					GameTooltip:AddLine("영혼석 부활 남은시간: " .. CT_RA_FormatTime(stats["Soulstone"]));
				end
			elseif (GetLocale() == "zhCN") then
				if ( stats and stats["Rebirth"] and stats["Rebirth"] > 0 ) then
					GameTooltip:AddLine("复活: " .. CT_RA_FormatTime(stats["Rebirth"]));
				elseif ( stats and stats["Reincarnation"] and stats["Reincarnation"] > 0 ) then
					GameTooltip:AddLine("物品复活: " .. CT_RA_FormatTime(stats["Reincarnation"]));
				elseif ( stats and stats["Soulstone"] and stats["Soulstone"] > 0 ) then
					GameTooltip:AddLine("灵魂石复活: " .. CT_RA_FormatTime(stats["Soulstone"]));
				end
			else
				if ( stats and stats["Rebirth"] and stats["Rebirth"] > 0 ) then
					GameTooltip:AddLine("Rebirth up in: " .. CT_RA_FormatTime(stats["Rebirth"]));
				elseif ( stats and stats["Reincarnation"] and stats["Reincarnation"] > 0 ) then
					GameTooltip:AddLine("Ankh up in: " .. CT_RA_FormatTime(stats["Reincarnation"]));
				elseif ( stats and stats["Soulstone"] and stats["Soulstone"] > 0 ) then
					GameTooltip:AddLine("Soulstone up in: " .. CT_RA_FormatTime(stats["Soulstone"]));
				end
			end
		--elseif (IsAddOnLoaded("oRA")) then
			-- Not supported yet
		end

		GameTooltip:Show();
	else
		UnitFrame_Initialize("raid"..this:GetID());
		UnitFrame_OnEnter();
	end
end

function UnitFrame_Initialize(unit)	-- Hopefully this doesn't break any mods
	this.unit = unit;
end


----------------------
-- myAddOns Support --
----------------------
function Perl_Raid_myAddOns_Support()
	-- Register the addon in myAddOns
	if (myAddOnsFrame_Register) then
		local Perl_Raid_myAddOns_Details = {
			name = "Perl_Raid",
			version = "Version 11200.6",
			releaseDate = "November 3, 2006",
			author = "Nymbia; Maintained by Global",
			email = "global@g-ball.com",
			website = "http://www.curse-gaming.com/mod.php?addid=2257",
			category = MYADDONS_CATEGORY_OTHERS
		};
		Perl_Raid_myAddOns_Help = {};
		Perl_Raid_myAddOns_Help[1] = "/perl";
		myAddOnsFrame_Register(Perl_Raid_myAddOns_Details, Perl_Raid_myAddOns_Help);
	end
end
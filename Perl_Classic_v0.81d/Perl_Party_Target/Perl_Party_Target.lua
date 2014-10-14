---------------
-- Variables --
---------------
Perl_Party_Target_Config = {};
local Perl_Party_Target_Events = {};	-- event manager

-- Default Saved Variables (also set in Perl_Party_Target_GetVars)
local locked = 0;		-- unlocked by default
local scale = 1;		-- default scale
local transparency = 1;		-- transparency for frames
local mobhealthsupport = 1;	-- mobhealth support is on by default
local hidepowerbars = 0;	-- Power bars are shown by default
local classcolorednames = 0;	-- names are colored based on pvp status by default
local enabled = 1;		-- mod is shown by default
local hiddeninraid = 0;		-- mod is not hidden in raids by default

-- Default Local Variables
local Initialized = nil;			-- waiting to be initialized
local Perl_Party_Target_Time_Elapsed = 0;	-- set the update timer to 0
local Perl_Party_Target_Time_Update_Rate = 0.2;	-- the update interval
local mouseoverhealthflag = 0;			-- is the mouse over the health bar?
local mouseovermanaflag = 0;			-- is the mouse over the mana bar?

local Perl_Party_Target_One_HealthBar_Fade_Color = 1;		-- the color fading interval
local Perl_Party_Target_One_HealthBar_Fade_Time_Elapsed = 0;	-- set the update timer to 0
local Perl_Party_Target_Two_HealthBar_Fade_Color = 1;		-- the color fading interval
local Perl_Party_Target_Two_HealthBar_Fade_Time_Elapsed = 0;	-- set the update timer to 0
local Perl_Party_Target_Three_HealthBar_Fade_Color = 1;		-- the color fading interval
local Perl_Party_Target_Three_HealthBar_Fade_Time_Elapsed = 0;	-- set the update timer to 0
local Perl_Party_Target_Four_HealthBar_Fade_Color = 1;		-- the color fading interval
local Perl_Party_Target_Four_HealthBar_Fade_Time_Elapsed = 0;	-- set the update timer to 0

local Perl_Party_Target_One_ManaBar_Fade_Color = 1;		-- the color fading interval
local Perl_Party_Target_One_ManaBar_Fade_Time_Elapsed = 0;	-- set the update timer to 0
local Perl_Party_Target_Two_ManaBar_Fade_Color = 1;		-- the color fading interval
local Perl_Party_Target_Two_ManaBar_Fade_Time_Elapsed = 0;	-- set the update timer to 0
local Perl_Party_Target_Three_ManaBar_Fade_Color = 1;		-- the color fading interval
local Perl_Party_Target_Three_ManaBar_Fade_Time_Elapsed = 0;	-- set the update timer to 0
local Perl_Party_Target_Four_ManaBar_Fade_Color = 1;		-- the color fading interval
local Perl_Party_Target_Four_ManaBar_Fade_Time_Elapsed = 0;	-- set the update timer to 0

-- Local variables to save memory
local r, g, b, currentunit, partytargetname, partytargethealth, partytargethealthmax, partytargethealthpercent, partytargetmana, partytargetmanamax, partytargetpower;


----------------------
-- Loading Function --
----------------------
function Perl_Party_Target_Script_OnLoad()
	-- Events
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("RAID_ROSTER_UPDATE");
	this:RegisterEvent("VARIABLES_LOADED");

	-- Scripts
	this:SetScript("OnEvent", Perl_Party_Target_Script_OnEvent);
	this:SetScript("OnUpdate", Perl_Party_Target_OnUpdate);
end


-------------------
-- Event Handler --
-------------------
function Perl_Party_Target_Script_OnEvent()
	local func = Perl_Party_Target_Events[event];
	if (func) then
		func();
--	else
--		DEFAULT_CHAT_FRAME:AddMessage("Perl Classic - Party Target: Report the following event error to the author: "..event);
	end
end

function Perl_Party_Target_Events:RAID_ROSTER_UPDATE()
	Perl_Party_Target_Show_Hide_Frame();
end

function Perl_Party_Target_Events:VARIABLES_LOADED()
	Perl_Party_Target_Initialize();
end
Perl_Party_Target_Events.PLAYER_ENTERING_WORLD = Perl_Party_Target_Events.VARIABLES_LOADED;


-------------------------------
-- Loading Settings Function --
-------------------------------
function Perl_Party_Target_Initialize()
	-- Code to be run after zoning or logging in goes here
	if (Initialized) then
		Perl_Party_Target_Set_Scale();			-- Set the frame scale
		Perl_Party_Target_Set_Transparency();		-- Set the frame transparency
		Perl_Party_Target_Show_Hide_Frame();
		return;
	end

	-- Check if a previous exists, if not, enable by default.
	if (type(Perl_Party_Target_Config[UnitName("player")]) == "table") then
		Perl_Party_Target_GetVars();
	else
		Perl_Party_Target_UpdateVars();
	end

	-- Major config options.
	Perl_Party_Target_Initialize_Frame_Color();		-- Color the frame borders

	-- Set the ID of the frame
	for num=1,4 do
		getglobal("Perl_Party_Target"..num.."_NameFrame_CastClickOverlay"):SetID(num);
		getglobal("Perl_Party_Target"..num.."_StatsFrame_CastClickOverlay"):SetID(num);
		getglobal("Perl_Party_Target"..num.."_StatsFrame_HealthBar_CastClickOverlay"):SetID(num);
		getglobal("Perl_Party_Target"..num.."_StatsFrame_ManaBar_CastClickOverlay"):SetID(num);
		getglobal("Perl_Party_Target"..num):Hide();	-- Hide the frame
	end

	-- Button Click Overlays (in order of occurrence in XML)
	for num = 1, 4 do
		getglobal("Perl_Party_Target"..num.."_NameFrame_CastClickOverlay"):SetFrameLevel(getglobal("Perl_Party_Target"..num.."_NameFrame"):GetFrameLevel() + 1);
		getglobal("Perl_Party_Target"..num.."_StatsFrame_CastClickOverlay"):SetFrameLevel(getglobal("Perl_Party_Target"..num.."_StatsFrame"):GetFrameLevel() + 1);
		getglobal("Perl_Party_Target"..num.."_StatsFrame_HealthBar_CastClickOverlay"):SetFrameLevel(getglobal("Perl_Party_Target"..num.."_StatsFrame"):GetFrameLevel() + 2);
		getglobal("Perl_Party_Target"..num.."_StatsFrame_ManaBar_CastClickOverlay"):SetFrameLevel(getglobal("Perl_Party_Target"..num.."_StatsFrame"):GetFrameLevel() + 2);
		getglobal("Perl_Party_Target"..num.."_StatsFrame_HealthBarFadeBar"):SetFrameLevel(getglobal("Perl_Party_Target"..num.."_StatsFrame_HealthBar"):GetFrameLevel() - 1);
		getglobal("Perl_Party_Target"..num.."_StatsFrame_ManaBarFadeBar"):SetFrameLevel(getglobal("Perl_Party_Target"..num.."_StatsFrame_ManaBar"):GetFrameLevel() - 1);
	end

	-- MyAddOns Support
	Perl_Party_Target_myAddOns_Support();

	-- IFrameManager Support
	if (IFrameManager) then
		Perl_Party_Target_IFrameManager();
	end

	Initialized = 1;
end

function Perl_Party_Target_IFrameManager()
	local iface = IFrameManager:Interface();
	function iface:getName(frame)
		if (frame == Perl_Party_Target1) then
			return "Perl Party Target 1";
		elseif (frame == Perl_Party_Target2) then
			return "Perl Party Target 2";
		elseif (frame == Perl_Party_Target3) then
			return "Perl Party Target 3";
		elseif (frame == Perl_Party_Target4) then
			return "Perl Party Target 4";
		end
	end
	function iface:getBorder(frame)
		local bottom = 38;
		local left = 0;
		local right = 0;
		local top = 0;
		if (hidepowerbars == 1) then
			bottom = bottom - 12;
		end
		return top, right, bottom, left;
	end
	IFrameManager:Register(Perl_Party_Target1, iface);
	IFrameManager:Register(Perl_Party_Target2, iface);
	IFrameManager:Register(Perl_Party_Target3, iface);
	IFrameManager:Register(Perl_Party_Target4, iface);
end

function Perl_Party_Target_Initialize_Frame_Color()
	for partynum=1,4 do
		getglobal("Perl_Party_Target"..partynum.."_NameFrame"):SetBackdropColor(0, 0, 0, 1);
		getglobal("Perl_Party_Target"..partynum.."_NameFrame"):SetBackdropBorderColor(0.5, 0.5, 0.5, 1);
		getglobal("Perl_Party_Target"..partynum.."_StatsFrame"):SetBackdropColor(0, 0, 0, 1);
		getglobal("Perl_Party_Target"..partynum.."_StatsFrame"):SetBackdropBorderColor(0.5, 0.5, 0.5, 1);
		getglobal("Perl_Party_Target"..partynum.."_StatsFrame_HealthBar_HealthBarText"):SetTextColor(1, 1, 1, 1);
		getglobal("Perl_Party_Target"..partynum.."_StatsFrame_ManaBar_ManaBarText"):SetTextColor(1, 1, 1, 1);
	end
end


-------------------------
-- The Update Function --
-------------------------
function Perl_Party_Target_OnUpdate()
	Perl_Party_Target_Time_Elapsed = Perl_Party_Target_Time_Elapsed + arg1;
	if (Perl_Party_Target_Time_Elapsed > Perl_Party_Target_Time_Update_Rate) then
		Perl_Party_Target_Time_Elapsed = 0;

		if (enabled == 1) then
			if (hiddeninraid == 1) then
				if (UnitInRaid("player")) then
					Perl_Party_Target1:Hide();
					Perl_Party_Target2:Hide();
					Perl_Party_Target3:Hide();
					Perl_Party_Target4:Hide();
					return;
				end
			end

			for partynum=1,4 do
				currentunit = "party"..partynum.."target";
				if (UnitExists(currentunit)) then
					getglobal("Perl_Party_Target"..partynum):Show();				-- Show the frame

					-- Begin: Set the name
					partytargetname = UnitName(currentunit);
					if (GetLocale() == "koKR") then
						if (strlen(partytargetname) > 25) then
							partytargetname = strsub(partytargetname, 1, 24).."...";
						end
					elseif (GetLocale() == "zhCN") then
						if (strlen(partytargetname) > 21) then
							partytargetname = strsub(partytargetname, 1, 20).."...";
						end
					else
						if (strlen(partytargetname) > 11) then
							partytargetname = strsub(partytargetname, 1, 10).."...";
						end
					end
					getglobal("Perl_Party_Target"..partynum.."_NameFrame_NameBarText"):SetText(partytargetname);
					-- End: Set the name

					-- Begin: Set the name text color
					if (UnitPlayerControlled(currentunit)) then						-- is it a player
						if (UnitCanAttack(currentunit, "player")) then					-- are we in an enemy controlled zone
							-- Hostile players are red
							if (not UnitCanAttack("player", currentunit)) then			-- enemy is not pvp enabled
								r = 0.5;
								g = 0.5;
								b = 1.0;
							else									-- enemy is pvp enabled
								r = 1.0;
								g = 0.0;
								b = 0.0;
							end
						elseif (UnitCanAttack("player", currentunit)) then				-- enemy in a zone controlled by friendlies or when we're a ghost
							-- Players we can attack but which are not hostile are yellow
							r = 1.0;
							g = 1.0;
							b = 0.0;
						elseif (UnitIsPVP(currentunit)) then						-- friendly pvp enabled character
							-- Players we can assist but are PvP flagged are green
							r = 0.0;
							g = 1.0;
							b = 0.0;
						else										-- friendly non pvp enabled character
							-- All other players are blue (the usual state on the "blue" server)
							r = 0.5;
							g = 0.5;
							b = 1.0;
						end
						getglobal("Perl_Party_Target"..partynum.."_NameFrame_NameBarText"):SetTextColor(r, g, b);
					elseif (UnitIsTapped(currentunit) and not UnitIsTappedByPlayer(currentunit)) then
						getglobal("Perl_Party_Target"..partynum.."_NameFrame_NameBarText"):SetTextColor(0.5,0.5,0.5);			-- not our tap
					else
						if (UnitIsVisible(currentunit)) then
							reaction = UnitReaction(currentunit, "player");
							if (reaction) then
								r = UnitReactionColor[reaction].r;
								g = UnitReactionColor[reaction].g;
								b = UnitReactionColor[reaction].b;
								getglobal("Perl_Party_Target"..partynum.."_NameFrame_NameBarText"):SetTextColor(r, g, b);
							else
								getglobal("Perl_Party_Target"..partynum.."_NameFrame_NameBarText"):SetTextColor(0.5, 0.5, 1.0);
							end
						else
							if (UnitCanAttack(currentunit, "player")) then					-- are we in an enemy controlled zone
								-- Hostile players are red
								if (not UnitCanAttack("player", currentunit)) then			-- enemy is not pvp enabled
									r = 0.5;
									g = 0.5;
									b = 1.0;
								else									-- enemy is pvp enabled
									r = 1.0;
									g = 0.0;
									b = 0.0;
								end
							elseif (UnitCanAttack("player", currentunit)) then				-- enemy in a zone controlled by friendlies or when we're a ghost
								-- Players we can attack but which are not hostile are yellow
								r = 1.0;
								g = 1.0;
								b = 0.0;
							elseif (UnitIsPVP(currentunit)) then						-- friendly pvp enabled character
								-- Players we can assist but are PvP flagged are green
								r = 0.0;
								g = 1.0;
								b = 0.0;
							else										-- friendly non pvp enabled character
								-- All other players are blue (the usual state on the "blue" server)
								r = 0.5;
								g = 0.5;
								b = 1.0;
							end
							getglobal("Perl_Party_Target"..partynum.."_NameFrame_NameBarText"):SetTextColor(r, g, b);
						end
					end

					if (classcolorednames == 1) then
						if (UnitIsPlayer(currentunit)) then
							if (UnitClass(currentunit) == PERL_LOCALIZED_WARRIOR) then
								getglobal("Perl_Party_Target"..partynum.."_NameFrame_NameBarText"):SetTextColor(0.78, 0.61, 0.43);
							elseif (UnitClass(currentunit) == PERL_LOCALIZED_MAGE) then
								getglobal("Perl_Party_Target"..partynum.."_NameFrame_NameBarText"):SetTextColor(0.41, 0.8, 0.94);
							elseif (UnitClass(currentunit) == PERL_LOCALIZED_ROGUE) then
								getglobal("Perl_Party_Target"..partynum.."_NameFrame_NameBarText"):SetTextColor(1, 0.96, 0.41);
							elseif (UnitClass(currentunit) == PERL_LOCALIZED_DRUID) then
								getglobal("Perl_Party_Target"..partynum.."_NameFrame_NameBarText"):SetTextColor(1, 0.49, 0.04);
							elseif (UnitClass(currentunit) == PERL_LOCALIZED_HUNTER) then
								getglobal("Perl_Party_Target"..partynum.."_NameFrame_NameBarText"):SetTextColor(0.67, 0.83, 0.45);
							elseif (UnitClass(currentunit) == PERL_LOCALIZED_SHAMAN) then
								getglobal("Perl_Party_Target"..partynum.."_NameFrame_NameBarText"):SetTextColor(0.96, 0.55, 0.73);
							elseif (UnitClass(currentunit) == PERL_LOCALIZED_PRIEST) then
								getglobal("Perl_Party_Target"..partynum.."_NameFrame_NameBarText"):SetTextColor(1, 1, 1);
							elseif (UnitClass(currentunit) == PERL_LOCALIZED_WARLOCK) then
								getglobal("Perl_Party_Target"..partynum.."_NameFrame_NameBarText"):SetTextColor(0.58, 0.51, 0.79);
							elseif (UnitClass(currentunit) == PERL_LOCALIZED_PALADIN) then
								getglobal("Perl_Party_Target"..partynum.."_NameFrame_NameBarText"):SetTextColor(0.96, 0.55, 0.73);
							end
						end
					end
					-- End: Set the name text color

					-- Begin: Update the health bar
					partytargethealth = UnitHealth(currentunit);
					partytargethealthmax = UnitHealthMax(currentunit);
					partytargethealthpercent = floor(partytargethealth/partytargethealthmax*100+0.5);

					if (UnitIsDead(currentunit) or UnitIsGhost(currentunit)) then				-- This prevents negative health
						partytargethealth = 0;
						partytargethealthpercent = 0;
					end

					--Perl_Party_Target_HealthBar_Fade_Check(partynum, partytargethealth, partytargethealthmax, getglobal("Perl_Party_Target"..partynum.."_StatsFrame_HealthBar"):GetValue());
					Perl_Party_Target_HealthBar_Fade_Check(partynum);

					getglobal("Perl_Party_Target"..partynum.."_StatsFrame_HealthBar"):SetMinMaxValues(0, partytargethealthmax);
					if (PCUF_INVERTBARVALUES == 1) then
						getglobal("Perl_Party_Target"..partynum.."_StatsFrame_HealthBar"):SetValue(partytargethealthmax - partytargethealth);
					else
						getglobal("Perl_Party_Target"..partynum.."_StatsFrame_HealthBar"):SetValue(partytargethealth);
					end
					--getglobal("Perl_Party_Target"..partynum.."_StatsFrame_HealthBar"):SetValue(partytargethealth);

					if (PCUF_COLORHEALTH == 1) then
		--				if ((partytargethealthpercent <= 100) and (partytargethealthpercent > 75)) then
		--					getglobal("Perl_Party_Target"..partynum.."_StatsFrame_HealthBar"):SetStatusBarColor(0, 0.8, 0);
		--					getglobal("Perl_Party_Target"..partynum.."_StatsFrame_HealthBarBG"):SetStatusBarColor(0, 0.8, 0, 0.25);
		--				elseif ((partytargethealthpercent <= 75) and (partytargethealthpercent > 50)) then
		--					getglobal("Perl_Party_Target"..partynum.."_StatsFrame_HealthBar"):SetStatusBarColor(1, 1, 0);
		--					getglobal("Perl_Party_Target"..partynum.."_StatsFrame_HealthBarBG"):SetStatusBarColor(1, 1, 0, 0.25);
		--				elseif ((partytargethealthpercent <= 50) and (partytargethealthpercent > 25)) then
		--					getglobal("Perl_Party_Target"..partynum.."_StatsFrame_HealthBar"):SetStatusBarColor(1, 0.5, 0);
		--					getglobal("Perl_Party_Target"..partynum.."_StatsFrame_HealthBarBG"):SetStatusBarColor(1, 0.5, 0, 0.25);
		--				else
		--					getglobal("Perl_Party_Target"..partynum.."_StatsFrame_HealthBar"):SetStatusBarColor(1, 0, 0);
		--					getglobal("Perl_Party_Target"..partynum.."_StatsFrame_HealthBarBG"):SetStatusBarColor(1, 0, 0, 0.25);
		--				end

						local rawpercent = partytargethealth / partytargethealthmax;
						local red, green;

						if(rawpercent > 0.5) then
							red = (1.0 - rawpercent) * 2;
							green = 1.0;
						else
							red = 1.0;
							green = rawpercent * 2;
						end

						getglobal("Perl_Party_Target"..partynum.."_StatsFrame_HealthBar"):SetStatusBarColor(red, green, 0, 1);
						getglobal("Perl_Party_Target"..partynum.."_StatsFrame_HealthBarBG"):SetStatusBarColor(red, green, 0, 0.25);
					else
						getglobal("Perl_Party_Target"..partynum.."_StatsFrame_HealthBar"):SetStatusBarColor(0, 0.8, 0);
						getglobal("Perl_Party_Target"..partynum.."_StatsFrame_HealthBarBG"):SetStatusBarColor(0, 0.8, 0, 0.25);
					end

					if (tonumber(mouseoverhealthflag) == partynum) then
						Perl_Party_Target_HealthShow(partynum);
					else
						getglobal("Perl_Party_Target"..partynum.."_StatsFrame_HealthBar_HealthBarText"):SetText(partytargethealthpercent.."%");
					end
					-- End: Update the health bar

					if (hidepowerbars == 0) then
						-- Begin: Update the mana bar color
						partytargetpower = UnitPowerType(currentunit);

						-- Set mana bar color
						if (UnitManaMax(currentunit) == 0) then
							getglobal("Perl_Party_Target"..partynum.."_StatsFrame_ManaBar"):Hide();
							getglobal("Perl_Party_Target"..partynum.."_StatsFrame_ManaBarBG"):Hide();
							getglobal("Perl_Party_Target"..partynum.."_StatsFrame_ManaBar_CastClickOverlay"):Hide();
							getglobal("Perl_Party_Target"..partynum.."_StatsFrame"):SetHeight(30);
							getglobal("Perl_Party_Target"..partynum.."_StatsFrame_CastClickOverlay"):SetHeight(30);
						elseif (partytargetpower == 1) then
							getglobal("Perl_Party_Target"..partynum.."_StatsFrame_ManaBar"):SetStatusBarColor(1, 0, 0, 1);
							getglobal("Perl_Party_Target"..partynum.."_StatsFrame_ManaBarBG"):SetStatusBarColor(1, 0, 0, 0.25);
							getglobal("Perl_Party_Target"..partynum.."_StatsFrame_ManaBar"):Show();
							getglobal("Perl_Party_Target"..partynum.."_StatsFrame_ManaBarBG"):Show();
							getglobal("Perl_Party_Target"..partynum.."_StatsFrame_ManaBar_CastClickOverlay"):Show();
							getglobal("Perl_Party_Target"..partynum.."_StatsFrame"):SetHeight(42);
							getglobal("Perl_Party_Target"..partynum.."_StatsFrame_CastClickOverlay"):SetHeight(42);
						elseif (partytargetpower == 2) then
							getglobal("Perl_Party_Target"..partynum.."_StatsFrame_ManaBar"):SetStatusBarColor(1, 0.5, 0, 1);
							getglobal("Perl_Party_Target"..partynum.."_StatsFrame_ManaBarBG"):SetStatusBarColor(1, 0.5, 0, 0.25);
							getglobal("Perl_Party_Target"..partynum.."_StatsFrame_ManaBar"):Show();
							getglobal("Perl_Party_Target"..partynum.."_StatsFrame_ManaBarBG"):Show();
							getglobal("Perl_Party_Target"..partynum.."_StatsFrame_ManaBar_CastClickOverlay"):Show();
							getglobal("Perl_Party_Target"..partynum.."_StatsFrame"):SetHeight(42);
							getglobal("Perl_Party_Target"..partynum.."_StatsFrame_CastClickOverlay"):SetHeight(42);
						elseif (partytargetpower == 3) then
							getglobal("Perl_Party_Target"..partynum.."_StatsFrame_ManaBar"):SetStatusBarColor(1, 1, 0, 1);
							getglobal("Perl_Party_Target"..partynum.."_StatsFrame_ManaBarBG"):SetStatusBarColor(1, 1, 0, 0.25);
							getglobal("Perl_Party_Target"..partynum.."_StatsFrame_ManaBar"):Show();
							getglobal("Perl_Party_Target"..partynum.."_StatsFrame_ManaBarBG"):Show();
							getglobal("Perl_Party_Target"..partynum.."_StatsFrame_ManaBar_CastClickOverlay"):Show();
							getglobal("Perl_Party_Target"..partynum.."_StatsFrame"):SetHeight(42);
							getglobal("Perl_Party_Target"..partynum.."_StatsFrame_CastClickOverlay"):SetHeight(42);
						else
							getglobal("Perl_Party_Target"..partynum.."_StatsFrame_ManaBar"):SetStatusBarColor(0, 0, 1, 1);
							getglobal("Perl_Party_Target"..partynum.."_StatsFrame_ManaBarBG"):SetStatusBarColor(0, 0, 1, 0.25);
							getglobal("Perl_Party_Target"..partynum.."_StatsFrame_ManaBar"):Show();
							getglobal("Perl_Party_Target"..partynum.."_StatsFrame_ManaBarBG"):Show();
							getglobal("Perl_Party_Target"..partynum.."_StatsFrame_ManaBar_CastClickOverlay"):Show();
							getglobal("Perl_Party_Target"..partynum.."_StatsFrame"):SetHeight(42);
							getglobal("Perl_Party_Target"..partynum.."_StatsFrame_CastClickOverlay"):SetHeight(42);
						end
						-- End: Update the mana bar color

						-- Begin: Update the mana bar
						partytargetmana = UnitMana(currentunit);
						partytargetmanamax = UnitManaMax(currentunit);

						if (UnitIsDead(currentunit) or UnitIsGhost(currentunit)) then				-- This prevents negative mana
							partytargetmana = 0;
						end

						Perl_Party_Target_ManaBar_Fade_Check(partynum);

						getglobal("Perl_Party_Target"..partynum.."_StatsFrame_ManaBar"):SetMinMaxValues(0, partytargetmanamax);
						if (PCUF_INVERTBARVALUES == 1) then
							getglobal("Perl_Party_Target"..partynum.."_StatsFrame_ManaBar"):SetValue(partytargetmanamax - partytargetmana);
						else
							getglobal("Perl_Party_Target"..partynum.."_StatsFrame_ManaBar"):SetValue(partytargetmana);
						end
						--getglobal("Perl_Party_Target"..partynum.."_StatsFrame_ManaBar"):SetValue(partytargetmana);

						if (tonumber(mouseovermanaflag) == partynum) then
							if (UnitPowerType(currentunit) == 1 or UnitPowerType(currentunit) == 2) then
								getglobal("Perl_Party_Target"..partynum.."_StatsFrame_ManaBar_ManaBarText"):SetText(partytargetmana);
							else
								getglobal("Perl_Party_Target"..partynum.."_StatsFrame_ManaBar_ManaBarText"):SetText(partytargetmana.."/"..partytargetmanamax);
							end
						else
							getglobal("Perl_Party_Target"..partynum.."_StatsFrame_ManaBar_ManaBarText"):SetText();
						end
						-- End: Update the mana bar
					else
						getglobal("Perl_Party_Target"..partynum.."_StatsFrame_ManaBar"):Hide();
						getglobal("Perl_Party_Target"..partynum.."_StatsFrame_ManaBarBG"):Hide();
						getglobal("Perl_Party_Target"..partynum.."_StatsFrame_ManaBar_CastClickOverlay"):Hide();
						getglobal("Perl_Party_Target"..partynum.."_StatsFrame"):SetHeight(30);
						getglobal("Perl_Party_Target"..partynum.."_StatsFrame_CastClickOverlay"):SetHeight(30);
					end
				else
					getglobal("Perl_Party_Target"..partynum):Hide();				-- Hide the frame
				end
			end
		else
			Perl_Party_Target1:Hide();
			Perl_Party_Target2:Hide();
			Perl_Party_Target3:Hide();
			Perl_Party_Target4:Hide();
		end

	end
end

function Perl_Party_Target_HealthShow(incomingid)
	local id;
	if (incomingid == nil) then
		id = this:GetID();
	else
		id = incomingid;
	end
	currentunit = "party"..id.."target";
	partytargethealth = UnitHealth(currentunit);
	partytargethealthmax = UnitHealthMax(currentunit);

	if (UnitIsDead(currentunit) or UnitIsGhost(currentunit)) then				-- This prevents negative health
		partytargethealth = 0;
		partytargethealthpercent = 0;
	end

	if (partytargethealthmax == 100) then
		-- Begin Mobhealth support
		if (mobhealthsupport == 1) then
			if (MobHealthFrame) then

				local index;
				if UnitIsPlayer(currentunit) then
					index = UnitName(currentunit);
				else
					index = UnitName(currentunit)..":"..UnitLevel(currentunit);
				end

				if ((MobHealthDB and MobHealthDB[index]) or (MobHealthPlayerDB and MobHealthPlayerDB[index])) then
					local s, e;
					local pts;
					local pct;

					if MobHealthDB[index] then
						if (type(MobHealthDB[index]) ~= "string") then
							getglobal("Perl_Party_Target"..id.."_StatsFrame_HealthBar_HealthBarText"):SetText(partytargethealth.."%");
						end
						s, e, pts, pct = string.find(MobHealthDB[index], "^(%d+)/(%d+)$");
					else
						if (type(MobHealthPlayerDB[index]) ~= "string") then
							getglobal("Perl_Party_Target"..id.."_StatsFrame_HealthBar_HealthBarText"):SetText(partytargethealth.."%");
						end
						s, e, pts, pct = string.find(MobHealthPlayerDB[index], "^(%d+)/(%d+)$");
					end

					if (pts and pct) then
						pts = pts + 0;
						pct = pct + 0;
						if (pct ~= 0) then
							pointsPerPct = pts / pct;
						else
							pointsPerPct = 0;
						end
					end

					local currentPct = UnitHealth(currentunit);
					if (pointsPerPct > 0) then
						getglobal("Perl_Party_Target"..id.."_StatsFrame_HealthBar_HealthBarText"):SetText(string.format("%d", (currentPct * pointsPerPct) + 0.5).."/"..string.format("%d", (100 * pointsPerPct) + 0.5));	-- Stored unit info from the DB
					end
				else
					getglobal("Perl_Party_Target"..id.."_StatsFrame_HealthBar_HealthBarText"):SetText(partytargethealth.."%");	-- Unit not in MobHealth DB
				end
			-- End MobHealth Support
			else
				getglobal("Perl_Party_Target"..id.."_StatsFrame_HealthBar_HealthBarText"):SetText(partytargethealth.."%");	-- MobHealth isn't installed
			end
		else	-- mobhealthsupport == 0
			getglobal("Perl_Party_Target"..id.."_StatsFrame_HealthBar_HealthBarText"):SetText(partytargethealth.."%");	-- MobHealth support is disabled
		end
	else
		getglobal("Perl_Party_Target"..id.."_StatsFrame_HealthBar_HealthBarText"):SetText(partytargethealth.."/"..partytargethealthmax);	-- Self/Party/Raid member
	end

	getglobal("Perl_Party_Target"..id.."_StatsFrame_HealthBar_HealthBarText"):SetText(partytargethealth.."/"..partytargethealthmax);
	mouseoverhealthflag = id;
end

function Perl_Party_Target_HealthHide()
	getglobal("Perl_Party_Target"..this:GetID().."_StatsFrame_HealthBar_HealthBarText"):SetText();
	mouseoverhealthflag = 0;
end

function Perl_Party_Target_ManaShow()
	local id = this:GetID();
	currentunit = "party"..id.."target";
	partytargetmana = UnitMana(currentunit);
	partytargetmanamax = UnitManaMax(currentunit);

	if (UnitIsDead(currentunit) or UnitIsGhost(currentunit)) then						-- This prevents negative mana
		partytargetmana = 0;
	end

	if (UnitPowerType(currentunit) == 1) then
		getglobal("Perl_Party_Target"..id.."_StatsFrame_ManaBar_ManaBarText"):SetText(partytargetmana);
	else
		getglobal("Perl_Party_Target"..id.."_StatsFrame_ManaBar_ManaBarText"):SetText(partytargetmana.."/"..partytargetmanamax);
	end
	mouseovermanaflag = id;
end

function Perl_Party_Target_ManaHide()
	getglobal("Perl_Party_Target"..this:GetID().."_StatsFrame_ManaBar_ManaBarText"):SetText();
	mouseovermanaflag = 0;
end

function Perl_Party_Target_Show_Hide_Frame()
	if (enabled == 1) then
		if (hiddeninraid == 0) then
			Perl_Party_Target_Script_Frame:Show();
		else
			if (UnitInRaid("player")) then
				Perl_Party_Target_Script_Frame:Hide();
				Perl_Party_Target1:Hide();
				Perl_Party_Target2:Hide();
				Perl_Party_Target3:Hide();
				Perl_Party_Target4:Hide();
			else
				Perl_Party_Target_Script_Frame:Show();
			end
		end
	else
		Perl_Party_Target_Script_Frame:Hide();
		Perl_Party_Target1:Hide();
		Perl_Party_Target2:Hide();
		Perl_Party_Target3:Hide();
		Perl_Party_Target4:Hide();
	end
end


------------------------
-- Fade Bar Functions --
------------------------
--function Perl_Party_Target_HealthBar_Fade_Check(partynum, health, healthmax, oldhealth)
--function Perl_Party_Target_HealthBar_Fade_Check(partynum)
--	if (PCUF_FADEBARS == 1) then
--		if (health < oldhealth) then
--			getglobal("Perl_Party_Target"..partynum.."_StatsFrame_HealthBarFadeBar"):SetMinMaxValues(0, healthmax);
--			getglobal("Perl_Party_Target"..partynum.."_StatsFrame_HealthBarFadeBar"):SetValue(oldhealth);
--			getglobal("Perl_Party_Target"..partynum.."_StatsFrame_HealthBarFadeBar"):Show();
--			if (partynum == 1) then							-- This makes the bars fade much smoother when lots of change is happening to a given bar
--				DEFAULT_CHAT_FRAME:AddMessage("new health value = "..health.."       new fade value = "..oldhealth);
--				Perl_Party_Target_One_HealthBar_Fade_Color = 1;
--				Perl_Party_Target_One_HealthBar_Fade_Time_Elapsed = 0;
--				--getglobal("Perl_Party_Target"..partynum.."_StatsFrame_HealthBarFadeBar"):SetStatusBarColor(0, Perl_Party_Target_One_HealthBar_Fade_Color, 0, Perl_Party_Target_One_HealthBar_Fade_Color);
--			elseif (partynum == 2) then
--				Perl_Party_Target_Two_HealthBar_Fade_Color = 1;
--				Perl_Party_Target_Two_HealthBar_Fade_Time_Elapsed = 0;
--				--getglobal("Perl_Party_Target"..partynum.."_StatsFrame_HealthBarFadeBar"):SetStatusBarColor(0, Perl_Party_Target_Two_HealthBar_Fade_Color, 0, Perl_Party_Target_Two_HealthBar_Fade_Color);
--			elseif (partynum == 3) then
--				Perl_Party_Target_Three_HealthBar_Fade_Color = 1;
--				Perl_Party_Target_Three_HealthBar_Fade_Time_Elapsed = 0;
--				--getglobal("Perl_Party_Target"..partynum.."_StatsFrame_HealthBarFadeBar"):SetStatusBarColor(0, Perl_Party_Target_Three_HealthBar_Fade_Color, 0, Perl_Party_Target_Three_HealthBar_Fade_Color);
--			elseif (partynum == 4) then
--				Perl_Party_Target_Four_HealthBar_Fade_Color = 1;
--				Perl_Party_Target_Four_HealthBar_Fade_Time_Elapsed = 0;
--				--getglobal("Perl_Party_Target"..partynum.."_StatsFrame_HealthBarFadeBar"):SetStatusBarColor(0, Perl_Party_Target_Four_HealthBar_Fade_Color, 0, Perl_Party_Target_Four_HealthBar_Fade_Color);
--			end
--			getglobal("Perl_Party_Target"..partynum.."_StatsFrame_HealthBarFadeBar"):SetStatusBarColor(0, 1, 0, 1);
--			getglobal("Perl_Party_Target"..partynum.."_HealthBar_Fade_OnUpdate_Frame"):Show();
--		end
--	end
--end

function Perl_Party_Target_HealthBar_Fade_Check(partynum)
	if (PCUF_FADEBARS == 1) then
		if (partytargethealth < getglobal("Perl_Party_Target"..partynum.."_StatsFrame_HealthBar"):GetValue()) then
			getglobal("Perl_Party_Target"..partynum.."_StatsFrame_HealthBarFadeBar"):SetMinMaxValues(0, partytargethealthmax);
			getglobal("Perl_Party_Target"..partynum.."_StatsFrame_HealthBarFadeBar"):SetValue(getglobal("Perl_Party_Target"..partynum.."_StatsFrame_HealthBar"):GetValue());
			getglobal("Perl_Party_Target"..partynum.."_StatsFrame_HealthBarFadeBar"):Show();
			-- We don't reset the values since this breaks fading due to not using individual variables for all 4 frames (not a big deal, still looks fine)
--			if (partynum == 1) then							-- This makes the bars fade much smoother when lots of change is happening to a given bar
--				Perl_Party_Target_One_HealthBar_Fade_Color = 1;
--				Perl_Party_Target_One_HealthBar_Fade_Time_Elapsed = 0;
--			elseif (partynum == 2) then
--				Perl_Party_Target_Two_HealthBar_Fade_Color = 1;
--				Perl_Party_Target_Two_HealthBar_Fade_Time_Elapsed = 0;
--			elseif (partynum == 3) then
--				Perl_Party_Target_Three_HealthBar_Fade_Color = 1;
--				Perl_Party_Target_Three_HealthBar_Fade_Time_Elapsed = 0;
--			elseif (partynum == 4) then
--				Perl_Party_Target_Four_HealthBar_Fade_Color = 1;
--				Perl_Party_Target_Four_HealthBar_Fade_Time_Elapsed = 0;
--			end
--			getglobal("Perl_Party_Target"..partynum.."_StatsFrame_HealthBarFadeBar"):SetStatusBarColor(0, 1, 0, 1);
			getglobal("Perl_Party_Target"..partynum.."_HealthBar_Fade_OnUpdate_Frame"):Show();
		end
	end
end

function Perl_Party_Target_ManaBar_Fade_Check(partynum)
	if (PCUF_FADEBARS == 1) then
		if (partytargetmana < getglobal("Perl_Party_Target"..partynum.."_StatsFrame_ManaBar"):GetValue()) then
			getglobal("Perl_Party_Target"..partynum.."_StatsFrame_ManaBarFadeBar"):SetMinMaxValues(0, partytargetmanamax);
			getglobal("Perl_Party_Target"..partynum.."_StatsFrame_ManaBarFadeBar"):SetValue(getglobal("Perl_Party_Target"..partynum.."_StatsFrame_ManaBar"):GetValue());
			getglobal("Perl_Party_Target"..partynum.."_StatsFrame_ManaBarFadeBar"):Show();
			-- We don't reset the values since this breaks fading due to not using individual variables for all 4 frames (not a big deal, still looks fine)
--			if (partynum == 1) then							-- This makes the bars fade much smoother when lots of change is happening to a given bar
--				Perl_Party_Target_One_ManaBar_Fade_Color = 1;
--				Perl_Party_Target_One_ManaBar_Fade_Time_Elapsed = 0;
--			elseif (partynum == 2) then
--				Perl_Party_Target_Two_ManaBar_Fade_Color = 1;
--				Perl_Party_Target_Two_ManaBar_Fade_Time_Elapsed = 0;
--			elseif (partynum == 3) then
--				Perl_Party_Target_Three_ManaBar_Fade_Color = 1;
--				Perl_Party_Target_Three_ManaBar_Fade_Time_Elapsed = 0;
--			elseif (partynum == 4) then
--				Perl_Party_Target_Four_ManaBar_Fade_Color = 1;
--				Perl_Party_Target_Four_ManaBar_Fade_Time_Elapsed = 0;
--			end
--			if (UnitPowerType("party"..partynum.."target") == 0) then
--				getglobal("Perl_Party_Target"..partynum.."_StatsFrame_ManaBarFadeBar"):SetStatusBarColor(0, 0, 1, 1);
--			elseif (UnitPowerType("party"..partynum.."target") == 1) then
--				getglobal("Perl_Party_Target"..partynum.."_StatsFrame_ManaBarFadeBar"):SetStatusBarColor(1, 0, 0, 1);
--			elseif (UnitPowerType("party"..partynum.."target") == 2) then
--				getglobal("Perl_Party_Target"..partynum.."_StatsFrame_ManaBarFadeBar"):SetStatusBarColor(1, 0.5, 0, 1);
--			elseif (UnitPowerType("party"..partynum.."target") == 3) then
--				getglobal("Perl_Party_Target"..partynum.."_StatsFrame_ManaBarFadeBar"):SetStatusBarColor(1, 1, 0, 1);
--			end
			getglobal("Perl_Party_Target"..partynum.."_ManaBar_Fade_OnUpdate_Frame"):Show();
		end
	end
end

function Perl_Party_Target_One_HealthBar_Fade(arg1)
	Perl_Party_Target_One_HealthBar_Fade_Color = Perl_Party_Target_One_HealthBar_Fade_Color - arg1;
	Perl_Party_Target_One_HealthBar_Fade_Time_Elapsed = Perl_Party_Target_One_HealthBar_Fade_Time_Elapsed + arg1;

	Perl_Party_Target1_StatsFrame_HealthBarFadeBar:SetStatusBarColor(0, Perl_Party_Target_One_HealthBar_Fade_Color, 0, Perl_Party_Target_One_HealthBar_Fade_Color);

	if (Perl_Party_Target_One_HealthBar_Fade_Time_Elapsed > 1) then
		Perl_Party_Target_One_HealthBar_Fade_Color = 1;
		Perl_Party_Target_One_HealthBar_Fade_Time_Elapsed = 0;
		Perl_Party_Target1_StatsFrame_HealthBarFadeBar:Hide();
		Perl_Party_Target1_HealthBar_Fade_OnUpdate_Frame:Hide();
	end
end

function Perl_Party_Target_Two_HealthBar_Fade(arg1)
	Perl_Party_Target_Two_HealthBar_Fade_Color = Perl_Party_Target_Two_HealthBar_Fade_Color - arg1;
	Perl_Party_Target_Two_HealthBar_Fade_Time_Elapsed = Perl_Party_Target_Two_HealthBar_Fade_Time_Elapsed + arg1;

	Perl_Party_Target2_StatsFrame_HealthBarFadeBar:SetStatusBarColor(0, Perl_Party_Target_Two_HealthBar_Fade_Color, 0, Perl_Party_Target_Two_HealthBar_Fade_Color);

	if (Perl_Party_Target_Two_HealthBar_Fade_Time_Elapsed > 1) then
		Perl_Party_Target_Two_HealthBar_Fade_Color = 1;
		Perl_Party_Target_Two_HealthBar_Fade_Time_Elapsed = 0;
		Perl_Party_Target2_StatsFrame_HealthBarFadeBar:Hide();
		Perl_Party_Target2_HealthBar_Fade_OnUpdate_Frame:Hide();
	end
end

function Perl_Party_Target_Three_HealthBar_Fade(arg1)
	Perl_Party_Target_Three_HealthBar_Fade_Color = Perl_Party_Target_Three_HealthBar_Fade_Color - arg1;
	Perl_Party_Target_Three_HealthBar_Fade_Time_Elapsed = Perl_Party_Target_Three_HealthBar_Fade_Time_Elapsed + arg1;

	Perl_Party_Target3_StatsFrame_HealthBarFadeBar:SetStatusBarColor(0, Perl_Party_Target_Three_HealthBar_Fade_Color, 0, Perl_Party_Target_Three_HealthBar_Fade_Color);

	if (Perl_Party_Target_Three_HealthBar_Fade_Time_Elapsed > 1) then
		Perl_Party_Target_Three_HealthBar_Fade_Color = 1;
		Perl_Party_Target_Three_HealthBar_Fade_Time_Elapsed = 0;
		Perl_Party_Target3_StatsFrame_HealthBarFadeBar:Hide();
		Perl_Party_Target3_HealthBar_Fade_OnUpdate_Frame:Hide();
	end
end

function Perl_Party_Target_Four_HealthBar_Fade(arg1)
	Perl_Party_Target_Four_HealthBar_Fade_Color = Perl_Party_Target_Four_HealthBar_Fade_Color - arg1;
	Perl_Party_Target_Four_HealthBar_Fade_Time_Elapsed = Perl_Party_Target_Four_HealthBar_Fade_Time_Elapsed + arg1;

	Perl_Party_Target4_StatsFrame_HealthBarFadeBar:SetStatusBarColor(0, Perl_Party_Target_Four_HealthBar_Fade_Color, 0, Perl_Party_Target_Four_HealthBar_Fade_Color);

	if (Perl_Party_Target_Four_HealthBar_Fade_Time_Elapsed > 1) then
		Perl_Party_Target_Four_HealthBar_Fade_Color = 1;
		Perl_Party_Target_Four_HealthBar_Fade_Time_Elapsed = 0;
		Perl_Party_Target4_StatsFrame_HealthBarFadeBar:Hide();
		Perl_Party_Target4_HealthBar_Fade_OnUpdate_Frame:Hide();
	end
end

function Perl_Party_Target_One_ManaBar_Fade(arg1)
	Perl_Party_Target_One_ManaBar_Fade_Color = Perl_Party_Target_One_ManaBar_Fade_Color - arg1;
	Perl_Party_Target_One_ManaBar_Fade_Time_Elapsed = Perl_Party_Target_One_ManaBar_Fade_Time_Elapsed + arg1;

	if (UnitPowerType("party1target") == 0) then
		Perl_Party_Target1_StatsFrame_ManaBarFadeBar:SetStatusBarColor(0, 0, Perl_Party_Target_One_ManaBar_Fade_Color, Perl_Party_Target_One_ManaBar_Fade_Color);
	elseif (UnitPowerType("party1target") == 1) then
		Perl_Party_Target1_StatsFrame_ManaBarFadeBar:SetStatusBarColor(Perl_Party_Target_One_ManaBar_Fade_Color, 0, 0, Perl_Party_Target_One_ManaBar_Fade_Color);
	elseif (UnitPowerType("party1target") == 2) then
		Perl_Party_Target1_StatsFrame_ManaBarFadeBar:SetStatusBarColor(Perl_Party_Target_One_ManaBar_Fade_Color, (Perl_Party_Target_One_ManaBar_Fade_Color-0.5), 0, Perl_Party_Target_One_ManaBar_Fade_Color);
	elseif (UnitPowerType("party1target") == 3) then
		Perl_Party_Target1_StatsFrame_ManaBarFadeBar:SetStatusBarColor(Perl_Party_Target_One_ManaBar_Fade_Color, Perl_Party_Target_One_ManaBar_Fade_Color, 0, Perl_Party_Target_One_ManaBar_Fade_Color);
	end

	if (Perl_Party_Target_One_ManaBar_Fade_Time_Elapsed > 1) then
		Perl_Party_Target_One_ManaBar_Fade_Color = 1;
		Perl_Party_Target_One_ManaBar_Fade_Time_Elapsed = 0;
		Perl_Party_Target1_StatsFrame_ManaBarFadeBar:Hide();
		Perl_Party_Target1_ManaBar_Fade_OnUpdate_Frame:Hide();
	end
end

function Perl_Party_Target_Two_ManaBar_Fade(arg1)
	Perl_Party_Target_Two_ManaBar_Fade_Color = Perl_Party_Target_Two_ManaBar_Fade_Color - arg1;
	Perl_Party_Target_Two_ManaBar_Fade_Time_Elapsed = Perl_Party_Target_Two_ManaBar_Fade_Time_Elapsed + arg1;

	if (UnitPowerType("party2target") == 0) then
		Perl_Party_Target2_StatsFrame_ManaBarFadeBar:SetStatusBarColor(0, 0, Perl_Party_Target_Two_ManaBar_Fade_Color, Perl_Party_Target_Two_ManaBar_Fade_Color);
	elseif (UnitPowerType("party2target") == 1) then
		Perl_Party_Target2_StatsFrame_ManaBarFadeBar:SetStatusBarColor(Perl_Party_Target_Two_ManaBar_Fade_Color, 0, 0, Perl_Party_Target_Two_ManaBar_Fade_Color);
	elseif (UnitPowerType("party2target") == 2) then
		Perl_Party_Target2_StatsFrame_ManaBarFadeBar:SetStatusBarColor(Perl_Party_Target_Two_ManaBar_Fade_Color, (Perl_Party_Target_Two_ManaBar_Fade_Color-0.5), 0, Perl_Party_Target_Two_ManaBar_Fade_Color);
	elseif (UnitPowerType("party2target") == 3) then
		Perl_Party_Target2_StatsFrame_ManaBarFadeBar:SetStatusBarColor(Perl_Party_Target_Two_ManaBar_Fade_Color, Perl_Party_Target_Two_ManaBar_Fade_Color, 0, Perl_Party_Target_Two_ManaBar_Fade_Color);
	end

	if (Perl_Party_Target_Two_ManaBar_Fade_Time_Elapsed > 1) then
		Perl_Party_Target_Two_ManaBar_Fade_Color = 1;
		Perl_Party_Target_Two_ManaBar_Fade_Time_Elapsed = 0;
		Perl_Party_Target2_StatsFrame_ManaBarFadeBar:Hide();
		Perl_Party_Target2_ManaBar_Fade_OnUpdate_Frame:Hide();
	end
end

function Perl_Party_Target_Three_ManaBar_Fade(arg1)
	Perl_Party_Target_Three_ManaBar_Fade_Color = Perl_Party_Target_Three_ManaBar_Fade_Color - arg1;
	Perl_Party_Target_Three_ManaBar_Fade_Time_Elapsed = Perl_Party_Target_Three_ManaBar_Fade_Time_Elapsed + arg1;

	if (UnitPowerType("party3target") == 0) then
		Perl_Party_Target3_StatsFrame_ManaBarFadeBar:SetStatusBarColor(0, 0, Perl_Party_Target_Three_ManaBar_Fade_Color, Perl_Party_Target_Three_ManaBar_Fade_Color);
	elseif (UnitPowerType("party3target") == 1) then
		Perl_Party_Target3_StatsFrame_ManaBarFadeBar:SetStatusBarColor(Perl_Party_Target_Three_ManaBar_Fade_Color, 0, 0, Perl_Party_Target_Three_ManaBar_Fade_Color);
	elseif (UnitPowerType("party3target") == 2) then
		Perl_Party_Target3_StatsFrame_ManaBarFadeBar:SetStatusBarColor(Perl_Party_Target_Three_ManaBar_Fade_Color, (Perl_Party_Target_Three_ManaBar_Fade_Color-0.5), 0, Perl_Party_Target_Three_ManaBar_Fade_Color);
	elseif (UnitPowerType("party3target") == 3) then
		Perl_Party_Target3_StatsFrame_ManaBarFadeBar:SetStatusBarColor(Perl_Party_Target_Three_ManaBar_Fade_Color, Perl_Party_Target_Three_ManaBar_Fade_Color, 0, Perl_Party_Target_Three_ManaBar_Fade_Color);
	end

	if (Perl_Party_Target_Three_ManaBar_Fade_Time_Elapsed > 1) then
		Perl_Party_Target_Three_ManaBar_Fade_Color = 1;
		Perl_Party_Target_Three_ManaBar_Fade_Time_Elapsed = 0;
		Perl_Party_Target3_StatsFrame_ManaBarFadeBar:Hide();
		Perl_Party_Target3_ManaBar_Fade_OnUpdate_Frame:Hide();
	end
end

function Perl_Party_Target_Four_ManaBar_Fade(arg1)
	Perl_Party_Target_Four_ManaBar_Fade_Color = Perl_Party_Target_Four_ManaBar_Fade_Color - arg1;
	Perl_Party_Target_Four_ManaBar_Fade_Time_Elapsed = Perl_Party_Target_Four_ManaBar_Fade_Time_Elapsed + arg1;

	if (UnitPowerType("party4target") == 0) then
		Perl_Party_Target4_StatsFrame_ManaBarFadeBar:SetStatusBarColor(0, 0, Perl_Party_Target_Four_ManaBar_Fade_Color, Perl_Party_Target_Four_ManaBar_Fade_Color);
	elseif (UnitPowerType("party4target") == 1) then
		Perl_Party_Target4_StatsFrame_ManaBarFadeBar:SetStatusBarColor(Perl_Party_Target_Four_ManaBar_Fade_Color, 0, 0, Perl_Party_Target_Four_ManaBar_Fade_Color);
	elseif (UnitPowerType("party4target") == 2) then
		Perl_Party_Target4_StatsFrame_ManaBarFadeBar:SetStatusBarColor(Perl_Party_Target_Four_ManaBar_Fade_Color, (Perl_Party_Target_Four_ManaBar_Fade_Color-0.5), 0, Perl_Party_Target_Four_ManaBar_Fade_Color);
	elseif (UnitPowerType("party4target") == 3) then
		Perl_Party_Target4_StatsFrame_ManaBarFadeBar:SetStatusBarColor(Perl_Party_Target_Four_ManaBar_Fade_Color, Perl_Party_Target_Four_ManaBar_Fade_Color, 0, Perl_Party_Target_Four_ManaBar_Fade_Color);
	end

	if (Perl_Party_Target_Four_ManaBar_Fade_Time_Elapsed > 1) then
		Perl_Party_Target_Four_ManaBar_Fade_Color = 1;
		Perl_Party_Target_Four_ManaBar_Fade_Time_Elapsed = 0;
		Perl_Party_Target4_StatsFrame_ManaBarFadeBar:Hide();
		Perl_Party_Target4_ManaBar_Fade_OnUpdate_Frame:Hide();
	end
end


--------------------------
-- GUI Config Functions --
--------------------------
function Perl_Party_Target_Allign()
	Perl_Party_Target1:SetUserPlaced(1);		-- This makes WoW remember the changes if the frames have never been moved before
	Perl_Party_Target2:SetUserPlaced(1);
	Perl_Party_Target3:SetUserPlaced(1);
	Perl_Party_Target4:SetUserPlaced(1);

	Perl_Party_Target1:SetPoint("TOPLEFT", Perl_Party_MemberFrame1_StatsFrame, "TOPRIGHT", -4, 20);
	Perl_Party_Target2:SetPoint("TOPLEFT", Perl_Party_MemberFrame2_StatsFrame, "TOPRIGHT", -4, 20);
	Perl_Party_Target3:SetPoint("TOPLEFT", Perl_Party_MemberFrame3_StatsFrame, "TOPRIGHT", -4, 20);
	Perl_Party_Target4:SetPoint("TOPLEFT", Perl_Party_MemberFrame4_StatsFrame, "TOPRIGHT", -4, 20);

	Perl_Party_Target_UpdateVars();			-- Calling this to update the positions for IFrameManger
end

function Perl_Party_Target_Set_Enabled(newvalue)
	enabled = newvalue;
	Perl_Party_Target_UpdateVars();
	Perl_Party_Target_Show_Hide_Frame();
end

function Perl_Party_Target_Set_Hidden_In_Raid(newvalue)
	hiddeninraid = newvalue;
	Perl_Party_Target_UpdateVars();
	Perl_Party_Target_Show_Hide_Frame();
end

function Perl_Party_Target_Set_Class_Colored_Names(newvalue)
	classcolorednames = newvalue;
	Perl_Party_Target_UpdateVars();
end

function Perl_Party_Target_Set_Hide_Power_Bars(newvalue)
	hidepowerbars = newvalue;
	Perl_Party_Target_UpdateVars();
end

function Perl_Party_Target_Set_MobHealth(newvalue)
	mobhealthsupport = newvalue;
	Perl_Party_Target_UpdateVars();
end

function Perl_Party_Target_Set_Lock(newvalue)
	locked = newvalue;
	Perl_Party_Target_UpdateVars();
end

function Perl_Party_Target_Set_Scale(number)
	local unsavedscale;
	if (number ~= nil) then
		scale = (number / 100);
	end
	unsavedscale = 1 - UIParent:GetEffectiveScale() + scale;	-- run it through the scaling formula introduced in 1.9
	Perl_Party_Target1:SetScale(unsavedscale);
	Perl_Party_Target2:SetScale(unsavedscale);
	Perl_Party_Target3:SetScale(unsavedscale);
	Perl_Party_Target4:SetScale(unsavedscale);
	Perl_Party_Target_UpdateVars();
end

function Perl_Party_Target_Set_Transparency(number)
	if (number ~= nil) then
		transparency = (number / 100);
	end
	Perl_Party_Target1:SetAlpha(transparency);
	Perl_Party_Target2:SetAlpha(transparency);
	Perl_Party_Target3:SetAlpha(transparency);
	Perl_Party_Target4:SetAlpha(transparency);
	Perl_Party_Target_UpdateVars();
end


------------------------------
-- Saved Variable Functions --
------------------------------
function Perl_Party_Target_GetVars(name, updateflag)
	if (name == nil) then
		name = UnitName("player");
	end

	locked = Perl_Party_Target_Config[name]["Locked"];
	scale = Perl_Party_Target_Config[name]["Scale"];
	transparency = Perl_Party_Target_Config[name]["Transparency"];
	mobhealthsupport = Perl_Party_Target_Config[name]["MobHealthSupport"];
	hidepowerbars = Perl_Party_Target_Config[name]["HidePowerBars"];
	classcolorednames = Perl_Party_Target_Config[name]["ClassColoredNames"];
	enabled = Perl_Party_Target_Config[name]["Enabled"];
	hiddeninraid = Perl_Party_Target_Config[name]["HiddenInRaid"];

	if (locked == nil) then
		locked = 0;
	end
	if (scale == nil) then
		scale = 1;
	end
	if (transparency == nil) then
		transparency = 1;
	end
	if (mobhealthsupport == nil) then
		mobhealthsupport = 1;
	end
	if (hidepowerbars == nil) then
		hidepowerbars = 0;
	end
	if (classcolorednames == nil) then
		classcolorednames = 0;
	end
	if (enabled == nil) then
		enabled = 1;
	end
	if (hiddeninraid == nil) then
		hiddeninraid = 0;
	end

	if (updateflag == 1) then
		-- Save the new values
		Perl_Party_Target_UpdateVars();

		-- Call any code we need to activate them
		Perl_Party_Target_Set_Scale();
		Perl_Party_Target_Set_Transparency();
		return;
	end

	local vars = {
		["locked"] = locked,
		["scale"] = scale,
		["transparency"] = transparency,
		["mobhealthsupport"] = mobhealthsupport,
		["hidepowerbars"] = hidepowerbars,
		["classcolorednames"] = classcolorednames,
		["enabled"] = enabled,
		["hiddeninraid"] = hiddeninraid,
	}
	return vars;
end

function Perl_Party_Target_UpdateVars(vartable)
	if (vartable ~= nil) then
		-- Sanity checks in case you use a load from an old version
		if (vartable["Global Settings"] ~= nil) then
			if (vartable["Global Settings"]["Locked"] ~= nil) then
				locked = vartable["Global Settings"]["Locked"];
			else
				locked = nil;
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
			if (vartable["Global Settings"]["MobHealthSupport"] ~= nil) then
				mobhealthsupport = vartable["Global Settings"]["MobHealthSupport"];
			else
				mobhealthsupport = nil;
			end
			if (vartable["Global Settings"]["HidePowerBars"] ~= nil) then
				hidepowerbars = vartable["Global Settings"]["HidePowerBars"];
			else
				hidepowerbars = nil;
			end
			if (vartable["Global Settings"]["ClassColoredNames"] ~= nil) then
				classcolorednames = vartable["Global Settings"]["ClassColoredNames"];
			else
				classcolorednames = nil;
			end
			if (vartable["Global Settings"]["Enabled"] ~= nil) then
				enabled = vartable["Global Settings"]["Enabled"];
			else
				enabled = nil;
			end
			if (vartable["Global Settings"]["HiddenInRaid"] ~= nil) then
				hiddeninraid = vartable["Global Settings"]["HiddenInRaid"];
			else
				hiddeninraid = nil;
			end
		end

		-- Set the new values if any new values were found, same defaults as above
		if (locked == nil) then
			locked = 0;
		end
		if (scale == nil) then
			scale = 1;
		end
		if (transparency == nil) then
			transparency = 1;
		end
		if (mobhealthsupport == nil) then
			mobhealthsupport = 1;
		end
		if (hidepowerbars == nil) then
			hidepowerbars = 0;
		end
		if (classcolorednames == nil) then
			classcolorednames = 0;
		end
		if (enabled == nil) then
			enabled = 1;
		end
		if (hiddeninraid == nil) then
			hiddeninraid = 0;
		end

		-- Call any code we need to activate them
		Perl_Party_Target_Set_Scale();
		Perl_Party_Target_Set_Transparency();
	end

	-- IFrameManager Support
	if (IFrameManager) then
		IFrameManager:Refresh();
	end

	Perl_Party_Target_Config[UnitName("player")] = {
		["Locked"] = locked,
		["Scale"] = scale,
		["Transparency"] = transparency,
		["MobHealthSupport"] = mobhealthsupport,
		["HidePowerBars"] = hidepowerbars,
		["ClassColoredNames"] = classcolorednames,
		["Enabled"] = enabled,
		["HiddenInRaid"] = hiddeninraid,
	};
end


--------------------
-- Click Handlers --
--------------------
-- If there is a better way to do this please let me know
function Perl_Party_Target1DropDown_OnLoad()
	UIDropDownMenu_Initialize(this, Perl_Party_Target1DropDown_Initialize, "MENU");
end

function Perl_Party_Target2DropDown_OnLoad()
	UIDropDownMenu_Initialize(this, Perl_Party_Target2DropDown_Initialize, "MENU");
end

function Perl_Party_Target3DropDown_OnLoad()
	UIDropDownMenu_Initialize(this, Perl_Party_Target3DropDown_Initialize, "MENU");
end

function Perl_Party_Target4DropDown_OnLoad()
	UIDropDownMenu_Initialize(this, Perl_Party_Target4DropDown_Initialize, "MENU");
end

function Perl_Party_Target1DropDown_Initialize()
	local menu, name;
	currentunit = "party1target";

	if (UnitIsUnit(currentunit, "player")) then
		menu = "SELF";
	elseif (UnitIsUnit(currentunit, "pet")) then
		menu = "PET";
	elseif (UnitIsPlayer(currentunit)) then
		if (UnitInParty(currentunit)) then
			menu = "PARTY";
		else
			menu = "PLAYER";
		end
	else
		menu = "RAID_TARGET_ICON";
		name = RAID_TARGET_ICON;
	end
	if (menu) then
		UnitPopup_ShowMenu(Perl_Party_Target1_DropDown, menu, currentunit, name);
	end
end

function Perl_Party_Target2DropDown_Initialize()
	local menu, name;
	currentunit = "party2target";

	if (UnitIsUnit(currentunit, "player")) then
		menu = "SELF";
	elseif (UnitIsUnit(currentunit, "pet")) then
		menu = "PET";
	elseif (UnitIsPlayer(currentunit)) then
		if (UnitInParty(currentunit)) then
			menu = "PARTY";
		else
			menu = "PLAYER";
		end
	else
		menu = "RAID_TARGET_ICON";
		name = RAID_TARGET_ICON;
	end

	if (menu) then
		UnitPopup_ShowMenu(Perl_Party_Target2_DropDown, menu, currentunit, name);
	end
end

function Perl_Party_Target3DropDown_Initialize()
	local menu, name;
	currentunit = "party3target";

	if (UnitIsUnit(currentunit, "player")) then
		menu = "SELF";
	elseif (UnitIsUnit(currentunit, "pet")) then
		menu = "PET";
	elseif (UnitIsPlayer(currentunit)) then
		if (UnitInParty(currentunit)) then
			menu = "PARTY";
		else
			menu = "PLAYER";
		end
	else
		menu = "RAID_TARGET_ICON";
		name = RAID_TARGET_ICON;
	end

	if (menu) then
		UnitPopup_ShowMenu(Perl_Party_Target3_DropDown, menu, currentunit, name);
	end
end

function Perl_Party_Target4DropDown_Initialize()
	local menu, name;
	currentunit = "party4target";

	if (UnitIsUnit(currentunit, "player")) then
		menu = "SELF";
	elseif (UnitIsUnit(currentunit, "pet")) then
		menu = "PET";
	elseif (UnitIsPlayer(currentunit)) then
		if (UnitInParty(currentunit)) then
			menu = "PARTY";
		else
			menu = "PLAYER";
		end
	else
		menu = "RAID_TARGET_ICON";
		name = RAID_TARGET_ICON;
	end

	if (menu) then
		UnitPopup_ShowMenu(Perl_Party_Target4_DropDown, menu, currentunit, name);
	end
end

function Perl_Party_Target_MouseClick(button)
	local id = this:GetID();
	currentunit = "party"..id.."target";

	if (Perl_Custom_ClickFunction) then					-- Check to see if someone defined a custom click function
		if (Perl_Custom_ClickFunction(button, currentunit)) then	-- If the function returns true, then we return
			return;
		end
	end									-- Otherwise, it did nothing, so take default action

	if (PCUF_CASTPARTYSUPPORT == 1) then
		if (CastPartyConfig) then
			CastParty.Event.OnClickByUnit(button, currentunit);
			return;
		elseif (Genesis_MouseHeal and Genesis_MouseHeal(currentunit, button)) then
			return;
		elseif (CH_Config) then
			if (CH_Config.PCUFEnabled) then
				CH_UnitClicked(currentunit, button);
				return;
			end
		elseif (SmartHeal) then
			if (SmartHeal.Loaded and SmartHeal:getConfig("enable", "clickmode")) then
				local KeyDownType = SmartHeal:GetClickHealButton();
				if(KeyDownType and KeyDownType ~= "undetermined") then
					SmartHeal:ClickHeal(KeyDownType..button, currentunit);
				else
					SmartHeal:DefaultClick(button, currentunit);
				end
				return;
			end
		end
	end

	if (button == "LeftButton") then
		if (SpellIsTargeting()) then
			SpellTargetUnit(currentunit);
		elseif (CursorHasItem()) then
			DropItemOnUnit(currentunit);
		else
			TargetUnit(currentunit);
		end
		return;
	end

	if (button == "LeftButton") then
		if (SpellIsTargeting()) then
			SpellStopTargeting();
			return;
		end
	end

	if (not (IsAltKeyDown() or IsControlKeyDown() or IsShiftKeyDown())) then
		if (id == 1) then
			ToggleDropDownMenu(1, nil, Perl_Party_Target1_DropDown, "Perl_Party_Target1_NameFrame", 40, 0);
		elseif (id == 2) then
			ToggleDropDownMenu(1, nil, Perl_Party_Target2_DropDown, "Perl_Party_Target2_NameFrame", 40, 0);
		elseif (id == 3) then
			ToggleDropDownMenu(1, nil, Perl_Party_Target3_DropDown, "Perl_Party_Target3_NameFrame", 40, 0);
		elseif (id == 4) then
			ToggleDropDownMenu(1, nil, Perl_Party_Target4_DropDown, "Perl_Party_Target4_NameFrame", 40, 0);
		end
	end
end

function Perl_Party_Target_DragStart(button)
	if (button == "LeftButton" and locked == 0) then
		getglobal("Perl_Party_Target"..this:GetID()):StartMoving();
	end
end

function Perl_Party_Target_DragStop(button)
	getglobal("Perl_Party_Target"..this:GetID()):SetUserPlaced(1);
	getglobal("Perl_Party_Target"..this:GetID()):StopMovingOrSizing();
end


-------------
-- Tooltip --
-------------
function Perl_Party_Target_Tip()
	UnitFrame_Initialize("party"..this:GetID().."target")
end

function UnitFrame_Initialize(unit)	-- Hopefully this doesn't break any mods
	this.unit = unit;
end


----------------------
-- myAddOns Support --
----------------------
function Perl_Party_Target_myAddOns_Support()
	-- Register the addon in myAddOns
	if(myAddOnsFrame_Register) then
		local Perl_Party_Target_myAddOns_Details = {
			name = "Perl_Party_Target",
			version = "Version 11200.4",
			releaseDate = "November 3, 2006",
			author = "Global",
			email = "global@g-ball.com",
			website = "http://www.curse-gaming.com/mod.php?addid=2257",
			category = MYADDONS_CATEGORY_OTHERS
		};
		Perl_Party_Target_myAddOns_Help = {};
		Perl_Party_Target_myAddOns_Help[1] = "/perl";
		myAddOnsFrame_Register(Perl_Party_Target_myAddOns_Details, Perl_Party_Target_myAddOns_Help);
	end
end
---------------
-- Variables --
---------------
Perl_Target_Target_Config = {};

-- Default Saved Variables (also set in Perl_Target_Target_GetVars)
local locked = 0;		-- unlocked by default
local mobhealthsupport = 1;	-- mobhealth support is on by default
local scale = 1;		-- default scale
local totsupport = 1;		-- target of target support enabled by default
local tototsupport = 1;		-- target of target of target support enabled by default
local transparency = 1;		-- transparency for frames
local alertsound = 0;		-- audible alert disabled by default
local alertmode = 0;		-- DPS, Tank, Healer modes
local alertsize = 0;		-- Variable which controls the size of the text
local showtotbuffs = 0;		-- ToT buffs are off by default
local showtototbuffs = 0;	-- ToToT buffs are off by default
local hidepowerbars = 0;	-- Power bars are shown by default
local showtotdebuffs = 0;	-- ToT debuffs are off by default
local showtototdebuffs = 0;	-- ToToT debuffs are off by default
local displaycastablebuffs = 0;	-- display all buffs by default
local classcolorednames = 0;	-- names are colored based on pvp status by default
local showfriendlyhealth = 0;	-- show numerical friendly health is disbaled by default

-- Default Local Variables
local Initialized = nil;				-- waiting to be initialized
local Perl_Target_Target_Time_Elapsed = 0;		-- set the update timer to 0
local Perl_Target_Target_Time_Update_Rate = 0.2;	-- the update interval
local aggroWarningCount = 0;				-- the check to see if we have alerted the player of a ToT event
local aggroToToTWarningCount = 0;			-- the check to see if we have alerted the player of a ToToT event
local startTime = 0;					-- used to keep track of fading the big alert text
local mouseovertargettargethealthflag = 0;		-- is the mouse over the health bar for healer mode?
local mouseovertargettargetmanaflag = 0;		-- is the mouse over the mana bar for healer mode?
local mouseovertargettargettargethealthflag = 0;	-- is the mouse over the health bar for healer mode?
local mouseovertargettargettargetmanaflag = 0;		-- is the mouse over the mana bar for healer mode?

-- Fade Bar Variables
local Perl_Target_Target_HealthBar_Fade_Color = 1;		-- the color fading interval
local Perl_Target_Target_HealthBar_Fade_Time_Elapsed = 0;	-- set the update timer to 0
local Perl_Target_Target_ManaBar_Fade_Color = 1;		-- the color fading interval
local Perl_Target_Target_ManaBar_Fade_Time_Elapsed = 0;		-- set the update timer to 0
local Perl_Target_Target_Target_HealthBar_Fade_Color = 1;		-- the color fading interval
local Perl_Target_Target_Target_HealthBar_Fade_Time_Elapsed = 0;	-- set the update timer to 0
local Perl_Target_Target_Target_ManaBar_Fade_Color = 1;			-- the color fading interval
local Perl_Target_Target_Target_ManaBar_Fade_Time_Elapsed = 0;		-- set the update timer to 0

-- Local variables to save memory
-- ToT variables
local targettargetname, targettargethealth, targettargethealthmax, targettargethealthpercent, targettargetmana, targettargetmanamax, targettargetpower;

-- ToToT variables
local targettargettargetname, targettargettargethealth, targettargettargethealthmax, targettargettargethealthpercent, targettargettargetmana, targettargettargetmanamax, targettargettargetpower;

-- Shared
local r, g, b, reaction, mobhealththreenumerics;

----------------------
-- Loading Function --
----------------------
function Perl_Target_Target_OnLoad()
	-- Events
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("PLAYER_REGEN_ENABLED");
	this:RegisterEvent("PLAYER_TARGET_CHANGED");
	this:RegisterEvent("VARIABLES_LOADED");

	-- Button Click Overlays (in order of occurrence in XML)
	Perl_Target_Target_NameFrame_CastClickOverlay:SetFrameLevel(Perl_Target_Target_NameFrame:GetFrameLevel() + 1);
	Perl_Target_Target_StatsFrame_CastClickOverlay:SetFrameLevel(Perl_Target_Target_StatsFrame:GetFrameLevel() + 1);
	Perl_Target_Target_HealthBar_CastClickOverlay:SetFrameLevel(Perl_Target_Target_StatsFrame:GetFrameLevel() + 2);
	Perl_Target_Target_ManaBar_CastClickOverlay:SetFrameLevel(Perl_Target_Target_StatsFrame:GetFrameLevel() + 2);
	Perl_Target_Target_Target_NameFrame_CastClickOverlay:SetFrameLevel(Perl_Target_Target_Target_NameFrame:GetFrameLevel() + 1);
	Perl_Target_Target_Target_StatsFrame_CastClickOverlay:SetFrameLevel(Perl_Target_Target_Target_StatsFrame:GetFrameLevel() + 1);
	Perl_Target_Target_Target_HealthBar_CastClickOverlay:SetFrameLevel(Perl_Target_Target_Target_StatsFrame:GetFrameLevel() + 2);
	Perl_Target_Target_Target_ManaBar_CastClickOverlay:SetFrameLevel(Perl_Target_Target_Target_StatsFrame:GetFrameLevel() + 2);
	Perl_Target_Target_HealthBarFadeBar:SetFrameLevel(Perl_Target_Target_HealthBar:GetFrameLevel() - 1);
	Perl_Target_Target_ManaBarFadeBar:SetFrameLevel(Perl_Target_Target_ManaBar:GetFrameLevel() - 1);
	Perl_Target_Target_Target_HealthBarFadeBar:SetFrameLevel(Perl_Target_Target_Target_HealthBar:GetFrameLevel() - 1);
	Perl_Target_Target_Target_ManaBarFadeBar:SetFrameLevel(Perl_Target_Target_Target_ManaBar:GetFrameLevel() - 1);
	
	--Changed by MrWolf
	Perl_Target_Target_PortraitFrame_CastClickOverlay:SetFrameLevel(Perl_Target_Target_PortraitFrame:GetFrameLevel() + 2);
	Perl_Target_Target_RaidIconFrame:SetFrameLevel(Perl_Target_Target_PortraitFrame_CastClickOverlay:GetFrameLevel() - 1);
	
	Perl_Target_Target_Target_PortraitFrame_CastClickOverlay:SetFrameLevel(Perl_Target_Target_Target_PortraitFrame:GetFrameLevel() + 2);
	Perl_Target_Target_Target_RaidIconFrame:SetFrameLevel(Perl_Target_Target_Target_PortraitFrame_CastClickOverlay:GetFrameLevel() - 1);
	--END

	if (DEFAULT_CHAT_FRAME) then
		DEFAULT_CHAT_FRAME:AddMessage("|cffffff00Perl Classic: Target_Target loaded successfully.");
	end
end


-------------------
-- Event Handler --
-------------------
function Perl_Target_Target_OnEvent(event)
	if (event == "PLAYER_TARGET_CHANGED" or event == "PLAYER_REGEN_ENABLED") then
		aggroWarningCount = 0;
	elseif (event=="PLAYER_ENTERING_WORLD" or event == "VARIABLES_LOADED") then
		Perl_Target_Target_Initialize();
		return;
	else
		return;
	end
end


-------------------------------
-- Loading Settings Function --
-------------------------------
function Perl_Target_Target_Initialize()
	if (Initialized) then
		Perl_Target_Target_Set_Scale();		-- Set the scale
		Perl_Target_Target_Set_Transparency();	-- Set the transparency
		return;
	end

	-- Check if a previous exists, if not, enable by default.
	if (type(Perl_Target_Target_Config[UnitName("player")]) == "table") then
		Perl_Target_Target_GetVars();
	else
		Perl_Target_Target_UpdateVars();
	end

	-- Major config options.
	Perl_Target_Target_Initialize_Frame_Color();
	Perl_Target_Target_Frame:Hide();
	Perl_Target_Target_Target_Frame:Hide();

	-- MyAddOns Support
	Perl_Target_Target_myAddOns_Support();

	-- IFrameManager Support
	if (IFrameManager) then
		Perl_Target_Target_IFrameManager();
	end

	Initialized = 1;
end

function Perl_Target_Target_IFrameManager()
	local iface = IFrameManager:Interface();
	function iface:getName(frame)
		if (frame == Perl_Target_Target_Frame) then
			return "Perl Target Target";
		else
			return "Perl Target Target Target";
		end
	end
	function iface:getBorder(frame)
		local bottom = 0;
		local left = 0;
		local right = 0;
		local top = 0;
		if (frame == Perl_Target_Target_Frame) then
			if (showtotbuffs == 1 and showtotdebuffs == 1) then
				bottom = 88;
			elseif ((showtotbuffs == 0 and showtotdebuffs == 1) or (showtotbuffs == 1 and showtotdebuffs == 0)) then
				bottom = 58;
			else
				bottom = 38;
			end
			if (hidepowerbars == 1) then
				bottom = bottom - 12;
			end
			return top, right, bottom, left;
		else
			if (showtototbuffs == 1 and showtototdebuffs == 1) then
				bottom = 88;
			elseif ((showtototbuffs == 0 and showtototdebuffs == 1) or (showtototbuffs == 1 and showtototdebuffs == 0)) then
				bottom = 58;
			else
				bottom = 38;
			end
			if (hidepowerbars == 1) then
				bottom = bottom - 12;
			end
			return top, right, bottom, left;
		end
	end
	IFrameManager:Register(Perl_Target_Target_Frame, iface);
	IFrameManager:Register(Perl_Target_Target_Target_Frame, iface);
end

function Perl_Target_Target_Initialize_Frame_Color()
	Perl_Target_Target_StatsFrame:SetBackdropColor(0, 0, 0, 1);
	Perl_Target_Target_StatsFrame:SetBackdropBorderColor(0.5, 0.5, 0.5, 1);
	Perl_Target_Target_NameFrame:SetBackdropColor(0, 0, 0, 1);
	Perl_Target_Target_NameFrame:SetBackdropBorderColor(0.5, 0.5, 0.5, 1);
	Perl_Target_Target_HealthBarText:SetTextColor(1, 1, 1, 1);
	Perl_Target_Target_ManaBarText:SetTextColor(1, 1, 1, 1);
	-- Alterado by MrWolf
	Perl_Target_Target_PortraitFrame:SetBackdropColor(0, 0, 0, 1);
	Perl_Target_Target_PortraitFrame:SetBackdropBorderColor(0.5, 0.5, 0.5, 1);
    --FIM
	Perl_Target_Target_Target_StatsFrame:SetBackdropColor(0, 0, 0, 1);
	Perl_Target_Target_Target_StatsFrame:SetBackdropBorderColor(0.5, 0.5, 0.5, 1);
	Perl_Target_Target_Target_NameFrame:SetBackdropColor(0, 0, 0, 1);
	Perl_Target_Target_Target_NameFrame:SetBackdropBorderColor(0.5, 0.5, 0.5, 1);
	Perl_Target_Target_Target_HealthBarText:SetTextColor(1, 1, 1, 1);
	Perl_Target_Target_Target_ManaBarText:SetTextColor(1, 1, 1, 1);
	-- Alterado by MrWolf
	Perl_Target_Target_Target_PortraitFrame:SetBackdropColor(0, 0, 0, 1);
	Perl_Target_Target_Target_PortraitFrame:SetBackdropBorderColor(0.5, 0.5, 0.5, 1);
	--FIM
end


--------------------------
-- The Update Functions --
--------------------------
function Perl_Target_Target_OnUpdate(arg1)
	Perl_Target_Target_Time_Elapsed = Perl_Target_Target_Time_Elapsed + arg1;
	if (Perl_Target_Target_Time_Elapsed > Perl_Target_Target_Time_Update_Rate) then
		Perl_Target_Target_Time_Elapsed = 0;

		if (UnitExists("targettarget") and totsupport == 1) then
			Perl_Target_Target_Warn();				-- Display any warnings if needed
			Perl_Target_Target_Frame:Show();			-- Show the frame

			-- Begin: Set the name
			targettargetname = UnitName("targettarget");
			if (GetLocale() == "koKR") then
				if (strlen(targettargetname) > 25) then
					targettargetname = strsub(targettargetname, 1, 24).."...";
				end
			elseif (GetLocale() == "zhCN") then
				if (strlen(targettargetname) > 21) then
					targettargetname = strsub(targettargetname, 1, 20).."...";
				end
			else
				if (strlen(targettargetname) > 11) then
					targettargetname = strsub(targettargetname, 1, 10).."...";
				end
			end
			Perl_Target_Target_NameBarText:SetText(targettargetname);
			-- End: Set the name

			-- Begin: Set the name text color
			if (UnitPlayerControlled("targettarget")) then		-- is it a player
				if (UnitCanAttack("targettarget", "player")) then				-- are we in an enemy controlled zone
					-- Hostile players are red
					if (not UnitCanAttack("player", "targettarget")) then			-- enemy is not pvp enabled
						r = 0.5;
						g = 0.5;
						b = 1.0;
					else									-- enemy is pvp enabled
						r = 1.0;
						g = 0.0;
						b = 0.0;
					end
				elseif (UnitCanAttack("player", "targettarget")) then				-- enemy in a zone controlled by friendlies or when we're a ghost
					-- Players we can attack but which are not hostile are yellow
					r = 1.0;
					g = 1.0;
					b = 0.0;
				elseif (UnitIsPVP("targettarget")) then						-- friendly pvp enabled character
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
				Perl_Target_Target_NameBarText:SetTextColor(r, g, b);
			elseif (UnitIsTapped("targettarget") and not UnitIsTappedByPlayer("targettarget")) then
				Perl_Target_Target_NameBarText:SetTextColor(0.5,0.5,0.5);			-- not our tap
			else
				if (UnitIsVisible("targettarget")) then
					reaction = UnitReaction("targettarget", "player");
					if (reaction) then
						r = UnitReactionColor[reaction].r;
						g = UnitReactionColor[reaction].g;
						b = UnitReactionColor[reaction].b;
						Perl_Target_Target_NameBarText:SetTextColor(r, g, b);
					else
						Perl_Target_Target_NameBarText:SetTextColor(0.5, 0.5, 1.0);
					end
				else
					if (UnitCanAttack("targettarget", "player")) then				-- are we in an enemy controlled zone
						-- Hostile players are red
						if (not UnitCanAttack("player", "targettarget")) then			-- enemy is not pvp enabled
							r = 0.5;
							g = 0.5;
							b = 1.0;
						else									-- enemy is pvp enabled
							r = 1.0;
							g = 0.0;
							b = 0.0;
						end
					elseif (UnitCanAttack("player", "targettarget")) then				-- enemy in a zone controlled by friendlies or when we're a ghost
						-- Players we can attack but which are not hostile are yellow
						r = 1.0;
						g = 1.0;
						b = 0.0;
					elseif (UnitIsPVP("targettarget")) then						-- friendly pvp enabled character
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
					Perl_Target_Target_NameBarText:SetTextColor(r, g, b);
				end
			end

			if (classcolorednames == 1) then
				if (UnitIsPlayer("targettarget")) then
					if (UnitClass("targettarget") == PERL_LOCALIZED_WARRIOR) then
						Perl_Target_Target_NameBarText:SetTextColor(0.78, 0.61, 0.43);
					elseif (UnitClass("targettarget") == PERL_LOCALIZED_MAGE) then
						Perl_Target_Target_NameBarText:SetTextColor(0.41, 0.8, 0.94);
					elseif (UnitClass("targettarget") == PERL_LOCALIZED_ROGUE) then
						Perl_Target_Target_NameBarText:SetTextColor(1, 0.96, 0.41);
					elseif (UnitClass("targettarget") == PERL_LOCALIZED_DRUID) then
						Perl_Target_Target_NameBarText:SetTextColor(1, 0.49, 0.04);
					elseif (UnitClass("targettarget") == PERL_LOCALIZED_HUNTER) then
						Perl_Target_Target_NameBarText:SetTextColor(0.67, 0.83, 0.45);
					elseif (UnitClass("targettarget") == PERL_LOCALIZED_SHAMAN) then
						Perl_Target_Target_NameBarText:SetTextColor(0.96, 0.55, 0.73);
					elseif (UnitClass("targettarget") == PERL_LOCALIZED_PRIEST) then
						Perl_Target_Target_NameBarText:SetTextColor(1, 1, 1);
					elseif (UnitClass("targettarget") == PERL_LOCALIZED_WARLOCK) then
						Perl_Target_Target_NameBarText:SetTextColor(0.58, 0.51, 0.79);
					elseif (UnitClass("targettarget") == PERL_LOCALIZED_PALADIN) then
						Perl_Target_Target_NameBarText:SetTextColor(0.96, 0.55, 0.73);
					end
				end
			end
			-- End: Set the name text color


-- Begin: Update TargetTarget Portrait by MrWolf
			Perl_Target_Target_PortraitFrame:Show();								-- Show the main portrait frame
			SetPortraitTexture(Perl_Target_Target_Portrait, "targettarget");					-- Load the correct 2d graphic
			Perl_Target_Target_PortraitFrame_TargetModel:Hide();						-- Hide the 3d graphic
			Perl_Target_Target_Portrait:Show();								-- Show the 2d graphic
-- End: Update TargetTarget Portrait by MrWolf

-- Begin: Update TargetTarget RaidIcon by MrWolf
			Perl_Target_Target_UpdateRaidTargetIcon();
-- End: Update TargetTarget RaidIcon by MrWolf

			-- Begin: Update the health bar
			targettargethealth = UnitHealth("targettarget");
			targettargethealthmax = UnitHealthMax("targettarget");
			targettargethealthpercent = floor(targettargethealth/targettargethealthmax*100+0.5);

			if (UnitIsDead("targettarget") or UnitIsGhost("targettarget")) then				-- This prevents negative health
				targettargethealth = 0;
				targettargethealthpercent = 0;
			end

			Perl_Target_Target_HealthBar_Fade_Check();

			Perl_Target_Target_HealthBar:SetMinMaxValues(0, targettargethealthmax);
			if (PCUF_INVERTBARVALUES == 1) then
				Perl_Target_Target_HealthBar:SetValue(targettargethealthmax - targettargethealth);
			else
				Perl_Target_Target_HealthBar:SetValue(targettargethealth);
			end

			if (PCUF_COLORHEALTH == 1) then
--				if ((targettargethealthpercent <= 100) and (targettargethealthpercent > 75)) then
--					Perl_Target_Target_HealthBar:SetStatusBarColor(0, 0.8, 0);
--					Perl_Target_Target_HealthBarBG:SetStatusBarColor(0, 0.8, 0, 0.25);
--				elseif ((targettargethealthpercent <= 75) and (targettargethealthpercent > 50)) then
--					Perl_Target_Target_HealthBar:SetStatusBarColor(1, 1, 0);
--					Perl_Target_Target_HealthBarBG:SetStatusBarColor(1, 1, 0, 0.25);
--				elseif ((targettargethealthpercent <= 50) and (targettargethealthpercent > 25)) then
--					Perl_Target_Target_HealthBar:SetStatusBarColor(1, 0.5, 0);
--					Perl_Target_Target_HealthBarBG:SetStatusBarColor(1, 0.5, 0, 0.25);
--				else
--					Perl_Target_Target_HealthBar:SetStatusBarColor(1, 0, 0);
--					Perl_Target_Target_HealthBarBG:SetStatusBarColor(1, 0, 0, 0.25);
--				end

				local rawpercent = targettargethealth / targettargethealthmax;
				local red, green;

				if(rawpercent > 0.5) then
					red = (1.0 - rawpercent) * 2;
					green = 1.0;
				else
					red = 1.0;
					green = rawpercent * 2;
				end

				Perl_Target_Target_HealthBar:SetStatusBarColor(red, green, 0, 1);
				Perl_Target_Target_HealthBarBG:SetStatusBarColor(red, green, 0, 0.25);
			else
				Perl_Target_Target_HealthBar:SetStatusBarColor(0, 0.8, 0);
				Perl_Target_Target_HealthBarBG:SetStatusBarColor(0, 0.8, 0, 0.25);
			end

			if (mouseovertargettargethealthflag == 1) then
				Perl_Target_Target_HealthShow();
			else
				if (showfriendlyhealth == 1) then
					if (targettargethealthmax == 100) then
						Perl_Target_Target_HealthBarText:SetText(targettargethealthpercent.."%");
					else
						Perl_Target_Target_HealthBarText:SetText(targettargethealth.."/"..targettargethealthmax);
					end
				else
					Perl_Target_Target_HealthBarText:SetText(targettargethealthpercent.."%");
				end
			end
			-- End: Update the health bar

			if (hidepowerbars == 0) then
				-- Begin: Update the mana bar
				targettargetmana = UnitMana("targettarget");
				targettargetmanamax = UnitManaMax("targettarget");

				if (UnitIsDead("targettarget") or UnitIsGhost("targettarget")) then				-- This prevents negative mana
					targettargetmana = 0;
				end

				Perl_Target_Target_ManaBar_Fade_Check();

				Perl_Target_Target_ManaBar:SetMinMaxValues(0, targettargetmanamax);
				if (PCUF_INVERTBARVALUES == 1) then
					Perl_Target_Target_ManaBar:SetValue(targettargetmanamax - targettargetmana);
				else
					Perl_Target_Target_ManaBar:SetValue(targettargetmana);
				end

				if (mouseovertargettargetmanaflag == 1) then
					if (UnitPowerType("targettarget") == 1 or UnitPowerType("targettarget") == 2) then
						Perl_Target_Target_ManaBarText:SetText(targettargetmana);
					else
						Perl_Target_Target_ManaBarText:SetText(targettargetmana.."/"..targettargetmanamax);
					end
				else
					Perl_Target_Target_ManaBarText:Hide();
				end
				-- End: Update the mana bar

				-- Begin: Update the mana bar color
				targettargetpower = UnitPowerType("targettarget");

				-- Set mana bar color
				if (UnitManaMax("targettarget") == 0) then
					Perl_Target_Target_ManaBar:Hide();
					Perl_Target_Target_ManaBarBG:Hide();
					Perl_Target_Target_ManaBar_CastClickOverlay:Hide();
					Perl_Target_Target_StatsFrame:SetHeight(30);
					Perl_Target_Target_StatsFrame_CastClickOverlay:SetHeight(30);
				elseif (targettargetpower == 1) then
					Perl_Target_Target_ManaBar:SetStatusBarColor(1, 0, 0, 1);
					Perl_Target_Target_ManaBarBG:SetStatusBarColor(1, 0, 0, 0.25);
					Perl_Target_Target_ManaBar:Show();
					Perl_Target_Target_ManaBarBG:Show();
					Perl_Target_Target_ManaBar_CastClickOverlay:Show();
					Perl_Target_Target_StatsFrame:SetHeight(42);
					Perl_Target_Target_StatsFrame_CastClickOverlay:SetHeight(42);
				elseif (targettargetpower == 2) then
					Perl_Target_Target_ManaBar:SetStatusBarColor(1, 0.5, 0, 1);
					Perl_Target_Target_ManaBarBG:SetStatusBarColor(1, 0.5, 0, 0.25);
					Perl_Target_Target_ManaBar:Show();
					Perl_Target_Target_ManaBarBG:Show();
					Perl_Target_Target_ManaBar_CastClickOverlay:Show();
					Perl_Target_Target_StatsFrame:SetHeight(42);
					Perl_Target_Target_StatsFrame_CastClickOverlay:SetHeight(42);
				elseif (targettargetpower == 3) then
					Perl_Target_Target_ManaBar:SetStatusBarColor(1, 1, 0, 1);
					Perl_Target_Target_ManaBarBG:SetStatusBarColor(1, 1, 0, 0.25);
					Perl_Target_Target_ManaBar:Show();
					Perl_Target_Target_ManaBarBG:Show();
					Perl_Target_Target_ManaBar_CastClickOverlay:Show();
					Perl_Target_Target_StatsFrame:SetHeight(42);
					Perl_Target_Target_StatsFrame_CastClickOverlay:SetHeight(42);
				else
					Perl_Target_Target_ManaBar:SetStatusBarColor(0, 0, 1, 1);
					Perl_Target_Target_ManaBarBG:SetStatusBarColor(0, 0, 1, 0.25);
					Perl_Target_Target_ManaBar:Show();
					Perl_Target_Target_ManaBarBG:Show();
					Perl_Target_Target_ManaBar_CastClickOverlay:Show();
					Perl_Target_Target_StatsFrame:SetHeight(42);
					Perl_Target_Target_StatsFrame_CastClickOverlay:SetHeight(42);
				end
				-- End: Update the mana bar color
			else
				Perl_Target_Target_ManaBar:Hide();
				Perl_Target_Target_ManaBarBG:Hide();
				Perl_Target_Target_ManaBar_CastClickOverlay:Hide();
				Perl_Target_Target_StatsFrame:SetHeight(30);
				Perl_Target_Target_StatsFrame_CastClickOverlay:SetHeight(30);
			end

			-- Begin: Update buffs and debuffs
			Perl_Target_Target_Update_Buffs();			-- Apparently too many nested if's make lua cry, slow function call MUST be done here to avoid errors.
			-- End: Update buffs and debuffs
		else
			Perl_Target_Target_Frame:Hide();			-- Hide the frame
		end

		if (UnitExists("targettargettarget") and tototsupport == 1) then
			Perl_Target_Target_Target_Frame:Show();			-- Show the frame

			if (UnitAffectingCombat("targettarget")) then
				if (UnitIsDead("targettargettarget") or UnitIsCorpse("targettargettarget")) then
					-- Im thinking targetting something that is targetting a corpse or dead thing is causing crashes
					-- Hence this safety check. If it is, we do nothing.
				else
					if (UnitName("targettargettarget")) then
						if (UnitIsEnemy("targettarget", "player")) then
							if (UnitName("targettargettarget") == UnitName("player")) then			-- play the warning sound if needed
								if (aggroWarningCount == 0 and aggroToToTWarningCount == 0) then
									-- Its coming right for us!
									if (aggroToToTWarningCount == 0) then
										aggroToToTWarningCount = 1;
										Perl_Target_Target_Play_Sound();
									end
								end
							else
								-- Whew it isnt fighting us
								aggroToToTWarningCount = 0;
							end
						else
							-- Friendly target
							aggroToToTWarningCount = 0;
						end
					end
				end
			end
			

			-- Begin: Set the name
			targettargettargetname = UnitName("targettargettarget");
			if (GetLocale() == "koKR") then
				if (strlen(targettargettargetname) > 25) then
					targettargettargetname = strsub(targettargettargetname, 1, 24).."...";
				end
			elseif (GetLocale() == "zhCN") then
				if (strlen(targettargettargetname) > 21) then
					targettargettargetname = strsub(targettargettargetname, 1, 20).."...";
				end
			else
				if (strlen(targettargettargetname) > 11) then
					targettargettargetname = strsub(targettargettargetname, 1, 10).."...";
				end
			end
			Perl_Target_Target_Target_NameBarText:SetText(targettargettargetname);
			-- End: Set the name

			-- Begin: Set the name text color
			if (UnitPlayerControlled("targettargettarget")) then	-- is it a player
				if (UnitCanAttack("targettargettarget", "player")) then					-- are we in an enemy controlled zone
					-- Hostile players are red
					if (not UnitCanAttack("player", "targettargettarget")) then			-- enemy is not pvp enabled
						r = 0.5;
						g = 0.5;
						b = 1.0;
					else										-- enemy is pvp enabled
						r = 1.0;
						g = 0.0;
						b = 0.0;
					end
				elseif (UnitCanAttack("player", "targettargettarget")) then				-- enemy in a zone controlled by friendlies or when we're a ghost
					-- Players we can attack but which are not hostile are yellow
					r = 1.0;
					g = 1.0;
					b = 0.0;
				elseif (UnitIsPVP("targettargettarget")) then						-- friendly pvp enabled character
					-- Players we can assist but are PvP flagged are green
					r = 0.0;
					g = 1.0;
					b = 0.0;
				else											-- friendly non pvp enabled character
					-- All other players are blue (the usual state on the "blue" server)
					r = 0.5;
					g = 0.5;
					b = 1.0;
				end
				Perl_Target_Target_Target_NameBarText:SetTextColor(r, g, b);
			elseif (UnitIsTapped("targettargettarget") and not UnitIsTappedByPlayer("targettargettarget")) then
				Perl_Target_Target_Target_NameBarText:SetTextColor(0.5,0.5,0.5);			-- not our tap
			else
				if (UnitIsVisible("targettargettarget")) then
					reaction = UnitReaction("targettargettarget", "player");
					if (reaction) then
						local r, g, b;
						r = UnitReactionColor[reaction].r;
						g = UnitReactionColor[reaction].g;
						b = UnitReactionColor[reaction].b;
						Perl_Target_Target_Target_NameBarText:SetTextColor(r, g, b);
					else
						Perl_Target_Target_Target_NameBarText:SetTextColor(0.5, 0.5, 1.0);
					end
				else
					if (UnitCanAttack("targettargettarget", "player")) then					-- are we in an enemy controlled zone
						-- Hostile players are red
						if (not UnitCanAttack("player", "targettargettarget")) then			-- enemy is not pvp enabled
							r = 0.5;
							g = 0.5;
							b = 1.0;
						else										-- enemy is pvp enabled
							r = 1.0;
							g = 0.0;
							b = 0.0;
						end
					elseif (UnitCanAttack("player", "targettargettarget")) then				-- enemy in a zone controlled by friendlies or when we're a ghost
						-- Players we can attack but which are not hostile are yellow
						r = 1.0;
						g = 1.0;
						b = 0.0;
					elseif (UnitIsPVP("targettargettarget")) then						-- friendly pvp enabled character
						-- Players we can assist but are PvP flagged are green
						r = 0.0;
						g = 1.0;
						b = 0.0;
					else											-- friendly non pvp enabled character
						-- All other players are blue (the usual state on the "blue" server)
						r = 0.5;
						g = 0.5;
						b = 1.0;
					end
					Perl_Target_Target_Target_NameBarText:SetTextColor(r, g, b);
				end
			end

			if (classcolorednames == 1) then
				if (UnitIsPlayer("targettargettarget")) then
					if (UnitClass("targettargettarget") == PERL_LOCALIZED_WARRIOR) then
						Perl_Target_Target_Target_NameBarText:SetTextColor(0.78, 0.61, 0.43);
					elseif (UnitClass("targettargettarget") == PERL_LOCALIZED_MAGE) then
						Perl_Target_Target_Target_NameBarText:SetTextColor(0.41, 0.8, 0.94);
					elseif (UnitClass("targettargettarget") == PERL_LOCALIZED_ROGUE) then
						Perl_Target_Target_Target_NameBarText:SetTextColor(1, 0.96, 0.41);
					elseif (UnitClass("targettargettarget") == PERL_LOCALIZED_DRUID) then
						Perl_Target_Target_Target_NameBarText:SetTextColor(1, 0.49, 0.04);
					elseif (UnitClass("targettargettarget") == PERL_LOCALIZED_HUNTER) then
						Perl_Target_Target_Target_NameBarText:SetTextColor(0.67, 0.83, 0.45);
					elseif (UnitClass("targettargettarget") == PERL_LOCALIZED_SHAMAN) then
						Perl_Target_Target_Target_NameBarText:SetTextColor(0.96, 0.55, 0.73);
					elseif (UnitClass("targettargettarget") == PERL_LOCALIZED_PRIEST) then
						Perl_Target_Target_Target_NameBarText:SetTextColor(1, 1, 1);
					elseif (UnitClass("targettargettarget") == PERL_LOCALIZED_WARLOCK) then
						Perl_Target_Target_Target_NameBarText:SetTextColor(0.58, 0.51, 0.79);
					elseif (UnitClass("targettargettarget") == PERL_LOCALIZED_PALADIN) then
						Perl_Target_Target_Target_NameBarText:SetTextColor(0.96, 0.55, 0.73);
					end
				end
			end
			-- End: Set the name text color

-- Begin: Update TargetTargetTarget Portrait by MrWolf
			Perl_Target_Target_Target_PortraitFrame:Show();									-- Show the main portrait frame
			SetPortraitTexture(Perl_Target_Target_Target_Portrait, "targettargettarget");	-- Load the correct 2d graphic
			Perl_Target_Target_Target_PortraitFrame_TargetModel:Hide();						-- Hide the 3d graphic
			Perl_Target_Target_Target_Portrait:Show();										-- Show the 2d graphic
-- End: Update TargetTargetTarget Portrait by MrWolf

-- Begin: Update TargetTargetTarget RaidIcon by MrWolf
			Perl_Target_Target_Target_UpdateRaidTargetIcon();
-- End: Update TargetTargetTarget RaidIcon by MrWolf



			-- Begin: Update the health bar
			targettargettargethealth = UnitHealth("targettargettarget");
			targettargettargethealthmax = UnitHealthMax("targettargettarget");
			targettargettargethealthpercent = floor(targettargettargethealth/targettargettargethealthmax*100+0.5);

			if (UnitIsDead("targettargettarget") or UnitIsGhost("targettargettarget")) then				-- This prevents negative health
				targettargettargethealth = 0;
				targettargettargethealthpercent = 0;
			end

			Perl_Target_Target_Target_HealthBar_Fade_Check();

			Perl_Target_Target_Target_HealthBar:SetMinMaxValues(0, targettargettargethealthmax);
			if (PCUF_INVERTBARVALUES == 1) then
				Perl_Target_Target_Target_HealthBar:SetValue(targettargettargethealthmax - targettargettargethealth);
			else
				Perl_Target_Target_Target_HealthBar:SetValue(targettargettargethealth);
			end

			if (PCUF_COLORHEALTH == 1) then
--				if ((targettargettargethealthpercent <= 100) and (targettargettargethealthpercent > 75)) then
--					Perl_Target_Target_Target_HealthBar:SetStatusBarColor(0, 0.8, 0);
--					Perl_Target_Target_Target_HealthBarBG:SetStatusBarColor(0, 0.8, 0, 0.25);
--				elseif ((targettargettargethealthpercent <= 75) and (targettargettargethealthpercent > 50)) then
--					Perl_Target_Target_Target_HealthBar:SetStatusBarColor(1, 1, 0);
--					Perl_Target_Target_Target_HealthBarBG:SetStatusBarColor(1, 1, 0, 0.25);
--				elseif ((targettargettargethealthpercent <= 50) and (targettargettargethealthpercent > 25)) then
--					Perl_Target_Target_Target_HealthBar:SetStatusBarColor(1, 0.5, 0);
--					Perl_Target_Target_Target_HealthBarBG:SetStatusBarColor(1, 0.5, 0, 0.25);
--				else
--					Perl_Target_Target_Target_HealthBar:SetStatusBarColor(1, 0, 0);
--					Perl_Target_Target_Target_HealthBarBG:SetStatusBarColor(1, 0, 0, 0.25);
--				end

				local rawpercent = targettargettargethealth / targettargettargethealthmax;
				local red, green;

				if(rawpercent > 0.5) then
					red = (1.0 - rawpercent) * 2;
					green = 1.0;
				else
					red = 1.0;
					green = rawpercent * 2;
				end

				Perl_Target_Target_Target_HealthBar:SetStatusBarColor(red, green, 0, 1);
				Perl_Target_Target_Target_HealthBarBG:SetStatusBarColor(red, green, 0, 0.25);
			else
				Perl_Target_Target_Target_HealthBar:SetStatusBarColor(0, 0.8, 0);
				Perl_Target_Target_Target_HealthBarBG:SetStatusBarColor(0, 0.8, 0, 0.25);
			end

			if (mouseovertargettargettargethealthflag == 1) then
				Perl_Target_Target_Target_HealthShow();
			else
				if (showfriendlyhealth == 1) then
					if (targettargettargethealthmax == 100) then
						Perl_Target_Target_Target_HealthBarText:SetText(targettargettargethealthpercent.."%");
					else
						Perl_Target_Target_Target_HealthBarText:SetText(targettargettargethealth.."/"..targettargettargethealthmax);
					end
				else
					Perl_Target_Target_Target_HealthBarText:SetText(targettargettargethealthpercent.."%");
				end
			end
			-- End: Update the health bar

			if (hidepowerbars == 0) then
				-- Begin: Update the mana bar
				targettargettargetmana = UnitMana("targettargettarget");
				targettargettargetmanamax = UnitManaMax("targettargettarget");

				if (UnitIsDead("targettargettarget") or UnitIsGhost("targettargettarget")) then				-- This prevents negative mana
					targettargettargetmana = 0;
				end

				Perl_Target_Target_Target_ManaBar_Fade_Check();

				Perl_Target_Target_Target_ManaBar:SetMinMaxValues(0, targettargettargetmanamax);
				if (PCUF_INVERTBARVALUES == 1) then
					Perl_Target_Target_Target_ManaBar:SetValue(targettargettargetmanamax - targettargettargetmana);
				else
					Perl_Target_Target_Target_ManaBar:SetValue(targettargettargetmana);
				end

				if (mouseovertargettargettargetmanaflag == 1) then
					if (UnitPowerType("targettargettarget") == 1 or UnitPowerType("targettargettarget") == 2) then
						Perl_Target_Target_Target_ManaBarText:SetText(targettargettargetmana);
					else
						Perl_Target_Target_Target_ManaBarText:SetText(targettargettargetmana.."/"..targettargettargetmanamax);
					end
				else
					Perl_Target_Target_Target_ManaBarText:Hide();
				end
				-- End: Update the mana bar

				-- Begin: Update the mana bar color
				targettargettargetpower = UnitPowerType("targettargettarget");

				-- Set mana bar color
				if (UnitManaMax("targettargettarget") == 0) then
					Perl_Target_Target_Target_ManaBar:Hide();
					Perl_Target_Target_Target_ManaBarBG:Hide();
					Perl_Target_Target_Target_ManaBar_CastClickOverlay:Hide();
					Perl_Target_Target_Target_StatsFrame:SetHeight(30);
					Perl_Target_Target_Target_StatsFrame_CastClickOverlay:SetHeight(30);
				elseif (targettargettargetpower == 1) then
					Perl_Target_Target_Target_ManaBar:SetStatusBarColor(1, 0, 0, 1);
					Perl_Target_Target_Target_ManaBarBG:SetStatusBarColor(1, 0, 0, 0.25);
					Perl_Target_Target_Target_ManaBar:Show();
					Perl_Target_Target_Target_ManaBarBG:Show();
					Perl_Target_Target_Target_ManaBar_CastClickOverlay:Show();
					Perl_Target_Target_Target_StatsFrame:SetHeight(42);
					Perl_Target_Target_Target_StatsFrame_CastClickOverlay:SetHeight(42);
				elseif (targettargettargetpower == 2) then
					Perl_Target_Target_Target_ManaBar:SetStatusBarColor(1, 0.5, 0, 1);
					Perl_Target_Target_Target_ManaBarBG:SetStatusBarColor(1, 0.5, 0, 0.25);
					Perl_Target_Target_Target_ManaBar:Show();
					Perl_Target_Target_Target_ManaBarBG:Show();
					Perl_Target_Target_Target_ManaBar_CastClickOverlay:Show();
					Perl_Target_Target_Target_StatsFrame:SetHeight(42);
					Perl_Target_Target_Target_StatsFrame_CastClickOverlay:SetHeight(42);
				elseif (targettargettargetpower == 3) then
					Perl_Target_Target_Target_ManaBar:SetStatusBarColor(1, 1, 0, 1);
					Perl_Target_Target_Target_ManaBarBG:SetStatusBarColor(1, 1, 0, 0.25);
					Perl_Target_Target_Target_ManaBar:Show();
					Perl_Target_Target_Target_ManaBarBG:Show();
					Perl_Target_Target_Target_ManaBar_CastClickOverlay:Show();
					Perl_Target_Target_Target_StatsFrame:SetHeight(42);
					Perl_Target_Target_Target_StatsFrame_CastClickOverlay:SetHeight(42);
				else
					Perl_Target_Target_Target_ManaBar:SetStatusBarColor(0, 0, 1, 1);
					Perl_Target_Target_Target_ManaBarBG:SetStatusBarColor(0, 0, 1, 0.25);
					Perl_Target_Target_Target_ManaBar:Show();
					Perl_Target_Target_Target_ManaBarBG:Show();
					Perl_Target_Target_Target_ManaBar_CastClickOverlay:Show();
					Perl_Target_Target_Target_StatsFrame:SetHeight(42);
					Perl_Target_Target_Target_StatsFrame_CastClickOverlay:SetHeight(42);
				end
				-- End: Update the mana bar color
			else
				Perl_Target_Target_Target_ManaBar:Hide();
				Perl_Target_Target_Target_ManaBarBG:Hide();
				Perl_Target_Target_Target_ManaBar_CastClickOverlay:Hide();
				Perl_Target_Target_Target_StatsFrame:SetHeight(30);
				Perl_Target_Target_Target_StatsFrame_CastClickOverlay:SetHeight(30);
			end

			-- Begin: Update buffs and debuffs
			Perl_Target_Target_Target_Update_Buffs();		-- Apparently too many nested if's make lua cry, slow function call MUST be done here to avoid errors.
			-- End: Update buffs and debuffs
		else
			Perl_Target_Target_Target_Frame:Hide();			-- Hide the frame
		end

	end
end

function Perl_Target_Target_Update_Buffs()
	local button, buffCount, buffTexture, buffApplications, color, debuffType;							-- Variables for both buffs and debuffs (yes, I'm using buff names for debuffs, wanna fight about it?)

	local numBuffs = 0;														-- Buff counter for correct layout
	if (showtotbuffs == 1) then
		for buffnum=1,16 do													-- Start main buff loop
			buffTexture, buffApplications = UnitBuff("targettarget", buffnum, displaycastablebuffs);			-- Get the texture and buff stacking information if any
			button = getglobal("Perl_Target_Target_BuffFrame_Buff"..buffnum);						-- Create the main icon for the buff
			if (buffTexture) then												-- If there is a valid texture, proceed with buff icon creation
				getglobal(button:GetName().."Icon"):SetTexture(buffTexture);						-- Set the texture
				getglobal(button:GetName().."DebuffBorder"):Hide();							-- Hide the debuff border
				buffCount = getglobal(button:GetName().."Count");							-- Declare the buff counting text variable
				if (buffApplications > 1) then
					buffCount:SetText(buffApplications);								-- Set the text to the number of applications if greater than 0
					buffCount:Show();										-- Show the text
				else
					buffCount:Hide();										-- Hide the text if equal to 0
				end
				numBuffs = numBuffs + 1;										-- Increment the buff counter
				button:Show();												-- Show the final buff icon
			else
				button:Hide();												-- Hide the icon since there isn't a buff in this position
			end
		end															-- End main buff loop
	else
		numBuffs = 0;														-- ToT Buffs are disabled
	end

	local numDebuffs = 0;														-- Debuff counter for correct layout
	if (showtotdebuffs == 1) then
		for debuffnum=1,16 do													-- Start main debuff loop
			buffTexture, buffApplications, debuffType = UnitDebuff("targettarget", debuffnum, displaycastablebuffs);	-- Get the texture and debuff stacking information if any
			button = getglobal("Perl_Target_Target_BuffFrame_Debuff"..debuffnum);						-- Create the main icon for the debuff
			if (buffTexture) then												-- If there is a valid texture, proceed with debuff icon creation
				getglobal(button:GetName().."Icon"):SetTexture(buffTexture);						-- Set the texture
				if (debuffType) then
					color = DebuffTypeColor[debuffType];
				else
					color = DebuffTypeColor[PERL_LOCALIZED_BUFF_NONE];
				end
				getglobal(button:GetName().."DebuffBorder"):SetVertexColor(color.r, color.g, color.b);			-- Set the debuff border color
				getglobal(button:GetName().."DebuffBorder"):Show();							-- Show the debuff border
				buffCount = getglobal(button:GetName().."Count");							-- Declare the debuff counting text variable
				if (buffApplications > 1) then
					buffCount:SetText(buffApplications);								-- Set the text to the number of applications if greater than 0
					buffCount:Show();										-- Show the text
				else
					buffCount:Hide();										-- Hide the text if equal to 0
				end
				numDebuffs = numDebuffs + 1;										-- Increment the debuff counter
				button:Show();												-- Show the final debuff icon
			else
				button:Hide();												-- Hide the icon since there isn't a debuff in this position
			end
		end															-- End main debuff loop
	else
		numDebuffs = 0;														-- ToT Debuffs are disabled
	end

	if (UnitIsFriend("player", "targettarget")) then										-- Position the buffs according to friendly or enemy status
		if (numBuffs < 9) then
			if (showtotbuffs == 0) then
				Perl_Target_Target_BuffFrame_Debuff1:SetPoint("TOPLEFT", "Perl_Target_Target_StatsFrame", "BOTTOMLEFT", 3, 1);
			else
				Perl_Target_Target_BuffFrame_Buff1:SetPoint("TOPLEFT", "Perl_Target_Target_StatsFrame", "BOTTOMLEFT", 3, 1);
				Perl_Target_Target_BuffFrame_Debuff1:SetPoint("TOPLEFT", "Perl_Target_Target_BuffFrame_Buff1", "BOTTOMLEFT", 0, -1);
			end
		else
			Perl_Target_Target_BuffFrame_Buff1:SetPoint("TOPLEFT", "Perl_Target_Target_StatsFrame", "BOTTOMLEFT", 3, 1);
			Perl_Target_Target_BuffFrame_Debuff1:SetPoint("TOPLEFT", "Perl_Target_Target_BuffFrame_Buff9", "BOTTOMLEFT", 0, -1);
		end
	else
		if (numDebuffs < 9) then
			if (showtotdebuffs == 0) then
				Perl_Target_Target_BuffFrame_Buff1:SetPoint("TOPLEFT", "Perl_Target_Target_StatsFrame", "BOTTOMLEFT", 3, 1);
			else
				Perl_Target_Target_BuffFrame_Debuff1:SetPoint("TOPLEFT", "Perl_Target_Target_StatsFrame", "BOTTOMLEFT", 3, 1);
				Perl_Target_Target_BuffFrame_Buff1:SetPoint("TOPLEFT", "Perl_Target_Target_BuffFrame_Debuff1", "BOTTOMLEFT", 0, -1);
			end
		else
			Perl_Target_Target_BuffFrame_Debuff1:SetPoint("TOPLEFT", "Perl_Target_Target_StatsFrame", "BOTTOMLEFT", 3, 1);
			Perl_Target_Target_BuffFrame_Buff1:SetPoint("TOPLEFT", "Perl_Target_Target_BuffFrame_Debuff9", "BOTTOMLEFT", 0, -1);
		end
	end

	if (showtotbuffs == 1 or showtotdebuffs == 1) then
		Perl_Target_Target_BuffFrame:Show();											-- Show the final buff/debuff frame
	else
		Perl_Target_Target_BuffFrame:Hide();											-- Hide the buff/debuff frame since it's disabled
	end
end

function Perl_Target_Target_Target_Update_Buffs()
	local button, buffCount, buffTexture, buffApplications, color, debuffType;							-- Variables for both buffs and debuffs (yes, I'm using buff names for debuffs, wanna fight about it?)

	local numBuffs = 0;														-- Buff counter for correct layout
	if (showtototbuffs == 1) then
		for buffnum=1,16 do
			buffTexture, buffApplications = UnitBuff("targettargettarget", buffnum, displaycastablebuffs);			-- Get the texture and buff stacking information if any
			button = getglobal("Perl_Target_Target_Target_BuffFrame_Buff"..buffnum);					-- Create the main icon for the buff
			if (buffTexture) then
				getglobal(button:GetName().."Icon"):SetTexture(buffTexture);						-- Set the texture
				getglobal(button:GetName().."DebuffBorder"):Hide();							-- Hide the debuff border
				buffCount = getglobal(button:GetName().."Count");							-- Declare the buff counting text variable
				if (buffApplications > 1) then
					buffCount:SetText(buffApplications);								-- Set the text to the number of applications if greater than 0
					buffCount:Show();										-- Show the text
				else
					buffCount:Hide();										-- Hide the text if equal to 0
				end
				numBuffs = numBuffs + 1;										-- Increment the buff counter
				button:Show();												-- Show the final buff icon
			else
				button:Hide();												-- Hide the icon since there isn't a buff in this position
			end
		end
	else
		numBuffs = 0;														-- ToToT Buffs are disabled
	end

	local numDebuffs = 0;														-- Debuff counter for correct layout
	if (showtototdebuffs == 1) then
		for debuffnum=1,16 do
			buffTexture, buffApplications, debuffType = UnitDebuff("targettargettarget", debuffnum, displaycastablebuffs);	-- Get the texture and debuff stacking information if any
			button = getglobal("Perl_Target_Target_Target_BuffFrame_Debuff"..debuffnum);					-- Create the main icon for the debuff
			if (buffTexture) then
				getglobal(button:GetName().."Icon"):SetTexture(buffTexture);						-- Set the texture
				if (debuffType) then
					color = DebuffTypeColor[debuffType];
				else
					color = DebuffTypeColor[PERL_LOCALIZED_BUFF_NONE];
				end
				getglobal(button:GetName().."DebuffBorder"):SetVertexColor(color.r, color.g, color.b);			-- Set the debuff border color
				getglobal(button:GetName().."DebuffBorder"):Show();							-- Show the debuff border
				buffCount = getglobal(button:GetName().."Count");							-- Declare the debuff counting text variable
				if (buffApplications > 1) then
					buffCount:SetText(buffApplications);								-- Set the text to the number of applications if greater than 0
					buffCount:Show();										-- Show the text
				else
					buffCount:Hide();										-- Hide the text if equal to 0
				end
				numDebuffs = numDebuffs + 1;										-- Increment the debuff counter
				button:Show();												-- Show the final debuff icon
			else
				button:Hide();												-- Hide the icon since there isn't a debuff in this position
			end
		end
	else
		numBuffs = 0;														-- ToToT Debuffs are disabled
	end

	if (UnitIsFriend("player", "targettargettarget")) then										-- Position the buffs according to friendly or enemy status
		if (numBuffs < 9) then
			if (showtototbuffs == 0) then
				Perl_Target_Target_Target_BuffFrame_Debuff1:SetPoint("TOPLEFT", "Perl_Target_Target_Target_StatsFrame", "BOTTOMLEFT", 3, 1);
			else
				Perl_Target_Target_Target_BuffFrame_Buff1:SetPoint("TOPLEFT", "Perl_Target_Target_Target_StatsFrame", "BOTTOMLEFT", 3, 1);
				Perl_Target_Target_Target_BuffFrame_Debuff1:SetPoint("TOPLEFT", "Perl_Target_Target_Target_BuffFrame_Buff1", "BOTTOMLEFT", 0, -1);
			end
		else
			Perl_Target_Target_Target_BuffFrame_Buff1:SetPoint("TOPLEFT", "Perl_Target_Target_Target_StatsFrame", "BOTTOMLEFT", 3, 1);
			Perl_Target_Target_Target_BuffFrame_Debuff1:SetPoint("TOPLEFT", "Perl_Target_Target_Target_BuffFrame_Buff9", "BOTTOMLEFT", 0, -1);
		end
	else
		if (numDebuffs < 9) then
			if (showtotdebuffs == 0) then
				Perl_Target_Target_Target_BuffFrame_Buff1:SetPoint("TOPLEFT", "Perl_Target_Target_Target_StatsFrame", "BOTTOMLEFT", 3, 1);
			else
				Perl_Target_Target_Target_BuffFrame_Debuff1:SetPoint("TOPLEFT", "Perl_Target_Target_Target_StatsFrame", "BOTTOMLEFT", 3, 1);
				Perl_Target_Target_Target_BuffFrame_Buff1:SetPoint("TOPLEFT", "Perl_Target_Target_Target_BuffFrame_Debuff1", "BOTTOMLEFT", 0, -1);
			end
		else
			Perl_Target_Target_Target_BuffFrame_Debuff1:SetPoint("TOPLEFT", "Perl_Target_Target_Target_StatsFrame", "BOTTOMLEFT", 3, 1);
			Perl_Target_Target_Target_BuffFrame_Buff1:SetPoint("TOPLEFT", "Perl_Target_Target_Target_BuffFrame_Debuff9", "BOTTOMLEFT", 0, -1);
		end
	end

	if (showtototbuffs == 1 or showtototdebuffs == 1) then
		Perl_Target_Target_Target_BuffFrame:Show();										-- Show the final buff/debuff frame
	else
		Perl_Target_Target_Target_BuffFrame:Hide();										-- Hide the buff/debuff frame since it's disabled
	end
end

function Perl_Target_Target_Warn()
	-- Player has something targetted
	if (UnitAffectingCombat("target")) then								-- Target is in an active combat situation
		if (UnitIsDead("targettarget") or UnitIsCorpse("targettarget")) then			-- Target is dead, do nothing
			-- Previous author had this in as a safety check
		else
			if (not UnitIsFriend("target", "player")) then					-- Target isn't dead
				-- Stupid mobs dont have targets when they are trapped/polyd/sapped/stunned, check for this
				if (alertmode == 0) then	-- Disabled but still have audible alert enabled
					if (UnitName("targettarget") == UnitName("player")) then	-- play the warning sound if needed
						-- Its coming right for us!
						if (aggroWarningCount == 0) then
							aggroWarningCount = 1;
							Perl_Target_Target_Play_Sound();
						end
					else
						-- Whew it isnt fighting us
						aggroWarningCount = 0;
					end
				elseif (alertmode == 1) then	-- DPS Mode
					if (UnitName("targettarget") == UnitName("player")) then
						-- Its coming right for us!
						if (aggroWarningCount == 0) then
							if (alertsize == 0) then
								UIErrorsFrame:AddMessage(UnitName("target")..PERL_LOCALIZED_TARGET_TARGET_CHANGED_TO_YOU,1,0,0,1,3);
							elseif (alertsize == 1) then
								Perl_Target_Target_BigWarning_Show(UnitName("target")..PERL_LOCALIZED_TARGET_TARGET_CHANGED_TO_YOU);
							elseif (alertsize == 2) then
								-- Warning disabled
							end
							aggroWarningCount = 1;
							Perl_Target_Target_Play_Sound();
						end
					else
						-- Whew it isnt fighting us
						aggroWarningCount = 0;
					end
				elseif (alertmode == 2) then	-- Tank mode
					if (UnitName("targettarget") == UnitName("player")) then
						-- Its coming right for us! (A good thing, im tanking it)
						aggroWarningCount = 0;
					else
						-- Some dumb hunter pulled aggro
						if (aggroWarningCount == 0) then
							if (alertsize == 0) then
								if (GetLocale() == "deDE") then
									UIErrorsFrame:AddMessage("Du hast die Aggro verloren an "..UnitName("targettarget").."!",1,0,0,1,3);
								elseif (GetLocale() == "koKR") then
									UIErrorsFrame:AddMessage("당신은 "..UnitName("targettarget").."의 어그로 획득에 실패했습니다!",1,0,0,1,3);
								elseif (GetLocale() == "zhCN") then
									UIErrorsFrame:AddMessage("你的目标已经转移到 "..UnitName("targettarget").."!",1,0,0,1,3);
								else
									UIErrorsFrame:AddMessage("You have lost aggro to "..UnitName("targettarget").."!",1,0,0,1,3);
								end
							elseif (alertsize == 1) then
								if (GetLocale() == "deDE") then
									Perl_Target_Target_BigWarning_Show("Du hast die Aggro verloren an "..UnitName("targettarget").."!");
								elseif (GetLocale() == "koKR") then
									Perl_Target_Target_BigWarning_Show("당신은 "..UnitName("targettarget").."의 어그로 획득에 실패했습니다!");
								elseif (GetLocale() == "zhCN") then
									Perl_Target_Target_BigWarning_Show("你的目标已经转移到 "..UnitName("targettarget").."!");
								else
									Perl_Target_Target_BigWarning_Show("You have lost aggro to "..UnitName("targettarget").."!");
								end
							elseif (alertsize == 2) then
								-- Warning disabled
							end
							aggroWarningCount = 1;
							Perl_Target_Target_Play_Sound();
						end
					end
				elseif (alertmode == 3) then	-- Healer Mode (Do this check down here for sanity reasons)
					Perl_Target_Target_Warn_Healer_Mode();
				else
					-- Friendly target
					aggroWarningCount = 0;
				end
				--end
			else
				if (alertmode == 3) then	-- Healer Mode (Do this check down here for sanity reasons)
					Perl_Target_Target_Warn_Healer_Mode();
				else
					-- Friendly target
					aggroWarningCount = 0;
				end
			end
		end
	end
end

function Perl_Target_Target_Warn_Healer_Mode()		-- This chunk of code is called in 2 places so may as well place it as it's own function
	if (UnitIsPlayer("target")) then
		if (UnitIsFriend("player", "target")) then
			if (UnitIsUnit("target", "targettargettarget")) then	-- The target and the targets target target (whew) are the same
				if (aggroWarningCount == 0) then
					if (alertsize == 0) then
						if (GetLocale() == "deDE") then
							UIErrorsFrame:AddMessage(UnitName("target").." tankt nun "..UnitName("targettarget"),1,0,0,1,3);
						elseif (GetLocale() == "koKR") then
							UIErrorsFrame:AddMessage(UnitName("target").."님이 "..UnitName("targettarget").."|1을;를; 탱킹중입니다.",1,0,0,1,3);
						elseif (GetLocale() == "zhCN") then
							UIErrorsFrame:AddMessage(UnitName("targettarget").." 正在攻击 "..UnitName("target"),1,0,0,1,3);
						else
							UIErrorsFrame:AddMessage(UnitName("target").." is now tanking "..UnitName("targettarget"),1,0,0,1,3);
						end
					elseif (alertsize == 1) then
						if ((UnitName("player") == UnitName("target")) or (UnitName("target") == UnitName("targettarget"))) then
							-- Do nothing
						else
							if (GetLocale() == "deDE") then
								Perl_Target_Target_BigWarning_Show(UnitName("target").." tankt nun "..UnitName("targettarget"));
							elseif (GetLocale() == "koKR") then
								Perl_Target_Target_BigWarning_Show(UnitName("target").."님이 "..UnitName("targettarget").."|1을;를; 탱킹중입니다.");
							elseif (GetLocale() == "zhCN") then
								Perl_Target_Target_BigWarning_Show(UnitName("targettarget").." 正在攻击 "..UnitName("target"));
							else
								Perl_Target_Target_BigWarning_Show(UnitName("target").." is now tanking "..UnitName("targettarget"));
							end
						end
					elseif (alertsize == 2) then
						-- Warning disabled
					end
					aggroWarningCount = 1;
				end
			else
				-- Lazy warrior isnt tanking anything!
				aggroWarningCount = 0;
			end
		else
			if (UnitName("targettarget") == UnitName("player")) then
				-- Its coming right for us!
				if (aggroWarningCount == 0) then
					if (alertsize == 0) then
						UIErrorsFrame:AddMessage(UnitName("target")..PERL_LOCALIZED_TARGET_TARGET_CHANGED_TO_YOU,1,0,0,1,3);
					elseif (alertsize == 1) then
						Perl_Target_Target_BigWarning_Show(UnitName("target")..PERL_LOCALIZED_TARGET_TARGET_CHANGED_TO_YOU);
					elseif (alertsize == 2) then
						-- Warning disabled
					end
					aggroWarningCount = 1;
					Perl_Target_Target_Play_Sound();
				end
			else
				-- Whew it isnt fighting us
				aggroWarningCount = 0;
			end
		end
	else
		if (UnitName("targettarget") == UnitName("player")) then
			-- Its coming right for us!
			if (aggroWarningCount == 0) then
				if (alertsize == 0) then
					UIErrorsFrame:AddMessage(UnitName("target")..PERL_LOCALIZED_TARGET_TARGET_CHANGED_TO_YOU,1,0,0,1,3);
				elseif (alertsize == 1) then
					Perl_Target_Target_BigWarning_Show(UnitName("target")..PERL_LOCALIZED_TARGET_TARGET_CHANGED_TO_YOU);
				elseif (alertsize == 2) then
					-- Warning disabled
				end
				aggroWarningCount = 1;
				Perl_Target_Target_Play_Sound();
			end
		else
			-- Whew it isnt fighting us
			aggroWarningCount = 0;
		end
	end
end

function Perl_Target_Target_Play_Sound()
	if (alertsound == 1) then
		PlaySoundFile("Sound\\Spells\\PVPFlagTakenHorde.wav");
	end
end

function Perl_Target_Target_Reset_Buffs()
	local button, debuff;
	for buffnum=1,16 do
		button = getglobal("Perl_Target_Target_BuffFrame_Buff"..buffnum);
		debuff = getglobal(button:GetName().."DebuffBorder");
		button:Hide();
		debuff:Hide();
	end
	for debuffnum=1,16 do
		button = getglobal("Perl_Target_Target_BuffFrame_Debuff"..debuffnum);
		debuff = getglobal(button:GetName().."DebuffBorder");
		button:Hide();
		debuff:Hide();
	end
end

function Perl_Target_Target_Target_Reset_Buffs()
	local button, debuff;
	for buffnum=1,16 do
		button = getglobal("Perl_Target_Target_Target_BuffFrame_Buff"..buffnum);
		debuff = getglobal(button:GetName().."DebuffBorder");
		button:Hide();
		debuff:Hide();
	end
	for debuffnum=1,16 do
		button = getglobal("Perl_Target_Target_Target_BuffFrame_Debuff"..debuffnum);
		debuff = getglobal(button:GetName().."DebuffBorder");
		button:Hide();
		debuff:Hide();
	end
end


-------------------------
-- Mouseover Functions --
-------------------------
-- Target of Target Start
function Perl_Target_Target_HealthShow()
	targettargethealth = UnitHealth("targettarget");
	targettargethealthmax = UnitHealthMax("targettarget");

	if (UnitIsDead("targettarget") or UnitIsGhost("targettarget")) then				-- This prevents negative health
		targettargethealth = 0;
		targettargethealthpercent = 0;
	end

	if (targettargethealthmax == 100) then
		-- Begin Mobhealth support
		if (mobhealthsupport == 1) then
			if (MobHealth3) then
				targettargethealth, targettargethealthmax, mobhealththreenumerics = MobHealth3:GetUnitHealth("targettarget", UnitHealth("targettarget"), UnitHealthMax("targettarget"), UnitName("targettarget"), UnitLevel("targettarget"));
				if (mobhealththreenumerics) then
					Perl_Target_Target_HealthBarText:SetText(targettargethealth.."/"..targettargethealthmax);	-- Stored unit info from the DB
				else
					Perl_Target_Target_HealthBarText:SetText(targettargethealth.."%");	-- Unit not in MobHealth DB
				end
			elseif (MobHealthFrame) then

				local index;
				if UnitIsPlayer("targettarget") then
					index = UnitName("targettarget");
				else
					index = UnitName("targettarget")..":"..UnitLevel("targettarget");
				end

				if ((MobHealthDB and MobHealthDB[index]) or (MobHealthPlayerDB and MobHealthPlayerDB[index])) then
					local s, e;
					local pts;
					local pct;

					if MobHealthDB[index] then
						if (type(MobHealthDB[index]) ~= "string") then
							Perl_Target_Target_HealthBarText:SetText(targettargethealth.."%");
						end
						s, e, pts, pct = string.find(MobHealthDB[index], "^(%d+)/(%d+)$");
					else
						if (type(MobHealthPlayerDB[index]) ~= "string") then
							Perl_Target_Target_HealthBarText:SetText(targettargethealth.."%");
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

					local currentPct = UnitHealth("targettarget");
					if (pointsPerPct > 0) then
						Perl_Target_Target_HealthBarText:SetText(string.format("%d", (currentPct * pointsPerPct) + 0.5).."/"..string.format("%d", (100 * pointsPerPct) + 0.5));	-- Stored unit info from the DB
					end
				else
					Perl_Target_Target_HealthBarText:SetText(targettargethealth.."%");	-- Unit not in MobHealth DB
				end
			-- End MobHealth Support
			else
				Perl_Target_Target_HealthBarText:SetText(targettargethealth.."%");	-- MobHealth isn't installed
			end
		else	-- mobhealthsupport == 0
			Perl_Target_Target_HealthBarText:SetText(targettargethealth.."%");	-- MobHealth support is disabled
		end
	else
		Perl_Target_Target_HealthBarText:SetText(targettargethealth.."/"..targettargethealthmax);	-- Self/Party/Raid member
	end

	mouseovertargettargethealthflag = 1;
end

function Perl_Target_Target_HealthHide()
	targettargethealthpercent = floor(UnitHealth("targettarget")/UnitHealthMax("targettarget")*100+0.5);

	if (UnitIsDead("targettarget") or UnitIsGhost("targettarget")) then				-- This prevents negative health
		targettargethealthpercent = 0;
	end

	Perl_Target_Target_HealthBarText:SetText(targettargethealthpercent.."%");
	mouseovertargettargethealthflag = 0;
end

function Perl_Target_Target_ManaShow()
	targettargetmana = UnitMana("targettarget");
	targettargetmanamax = UnitManaMax("targettarget");

	if (UnitIsDead("targettarget") or UnitIsGhost("targettarget")) then				-- This prevents negative mana
		targettargetmana = 0;
	end

	if (UnitPowerType("targettarget") == 1) then
		Perl_Target_Target_ManaBarText:SetText(targettargetmana);
	else
		Perl_Target_Target_ManaBarText:SetText(targettargetmana.."/"..targettargetmanamax);
	end
	Perl_Target_Target_ManaBarText:Show();
	mouseovertargettargetmanaflag = 1;
end

function Perl_Target_Target_ManaHide()
	Perl_Target_Target_ManaBarText:Hide();
	mouseovertargettargetmanaflag = 0;
end

-- MrWolf
function Perl_Target_Target_UpdateRaidTargetIcon()
	local index = GetRaidTargetIndex("targettarget");
	if (index) then
		SetRaidTargetIconTexture(Perl_Target_Target_RaidTargetIcon, index);
		Perl_Target_Target_RaidTargetIcon:Show();
	else
		Perl_Target_Target_RaidTargetIcon:Hide();
	end
end
-- END MrWolf

-- Target of Target End

-- Target of Target of Target Start
function Perl_Target_Target_Target_HealthShow()
	targettargettargethealth = UnitHealth("targettargettarget");
	targettargettargethealthmax = UnitHealthMax("targettargettarget");

	if (UnitIsDead("targettargettarget") or UnitIsGhost("targettargettarget")) then				-- This prevents negative health
		targettargettargethealth = 0;
		targettargettargethealthpercent = 0;
	end

	if (targettargettargethealthmax == 100) then
		-- Begin Mobhealth support
		if (mobhealthsupport == 1) then
			if (MobHealth3) then
				targettargettargethealth, targettargettargethealthmax, mobhealththreenumerics = MobHealth3:GetUnitHealth("targettargettarget", UnitHealth("targettargettarget"), UnitHealthMax("targettargettarget"), UnitName("targettargettarget"), UnitLevel("targettargettarget"));
				if (mobhealththreenumerics) then
					Perl_Target_Target_HealthBarText:SetText(targettargettargethealth.."/"..targettargettargethealthmax);	-- Stored unit info from the DB
				else
					Perl_Target_Target_HealthBarText:SetText(targettargettargethealth.."%");	-- Unit not in MobHealth DB
				end
			elseif (MobHealthFrame) then

				local index;
				if UnitIsPlayer("targettargettarget") then
					index = UnitName("targettargettarget");
				else
					index = UnitName("targettargettarget")..":"..UnitLevel("targettargettarget");
				end

				if ((MobHealthDB and MobHealthDB[index]) or (MobHealthPlayerDB and MobHealthPlayerDB[index])) then
					local s, e;
					local pts;
					local pct;

					if MobHealthDB[index] then
						if (type(MobHealthDB[index]) ~= "string") then
							Perl_Target_Target_Target_HealthBarText:SetText(targettargettargethealth.."%");
						end
						s, e, pts, pct = string.find(MobHealthDB[index], "^(%d+)/(%d+)$");
					else
						if (type(MobHealthPlayerDB[index]) ~= "string") then
							Perl_Target_Target_Target_HealthBarText:SetText(targettargettargethealth.."%");
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

					local currentPct = UnitHealth("targettargettarget");
					if (pointsPerPct > 0) then
						Perl_Target_Target_Target_HealthBarText:SetText(string.format("%d", (currentPct * pointsPerPct) + 0.5).."/"..string.format("%d", (100 * pointsPerPct) + 0.5));	-- Stored unit info from the DB
					end
				else
					Perl_Target_Target_Target_HealthBarText:SetText(targettargettargethealth.."%");	-- Unit not in MobHealth DB
				end
			-- End MobHealth Support
			else
				Perl_Target_Target_Target_HealthBarText:SetText(targettargettargethealth.."%");	-- MobHealth isn't installed
			end
		else	-- mobhealthsupport == 0
			Perl_Target_Target_Target_HealthBarText:SetText(targettargettargethealth.."%");	-- MobHealth support is disabled
		end
	else
		Perl_Target_Target_Target_HealthBarText:SetText(targettargettargethealth.."/"..targettargettargethealthmax);	-- Self/Party/Raid member
	end

	mouseovertargettargettargethealthflag = 1;
end

function Perl_Target_Target_Target_HealthHide()
	targettargettargethealthpercent = floor(UnitHealth("targettargettarget")/UnitHealthMax("targettargettarget")*100+0.5);

	if (UnitIsDead("targettargettarget") or UnitIsGhost("targettargettarget")) then				-- This prevents negative health
		targettargettargethealthpercent = 0;
	end

	Perl_Target_Target_Target_HealthBarText:SetText(targettargettargethealthpercent.."%");
	mouseovertargettargettargethealthflag = 0;
end

function Perl_Target_Target_Target_ManaShow()
	targettargettargetmana = UnitMana("targettargettarget");
	targettargettargetmanamax = UnitManaMax("targettargettarget");

	if (UnitIsDead("targettargettarget") or UnitIsGhost("targettargettarget")) then				-- This prevents negative mana
		targettargettargetmana = 0;
	end

	if (UnitPowerType("targettargettarget") == 1) then
		Perl_Target_Target_Target_ManaBarText:SetText(targettargettargetmana);
	else
		Perl_Target_Target_Target_ManaBarText:SetText(targettargettargetmana.."/"..targettargettargetmanamax);
	end
	Perl_Target_Target_Target_ManaBarText:Show();
	mouseovertargettargettargetmanaflag = 1;
end

function Perl_Target_Target_Target_ManaHide()
	Perl_Target_Target_Target_ManaBarText:Hide();
	mouseovertargettargettargetmanaflag = 0;
end

--MrWolf
function Perl_Target_Target_Target_UpdateRaidTargetIcon()
	local index = GetRaidTargetIndex("targettargettarget");
	if (index) then
		SetRaidTargetIconTexture(Perl_Target_Target_Target_RaidTargetIcon, index);
		Perl_Target_Target_Target_RaidTargetIcon:Show();
	else
		Perl_Target_Target_Target_RaidTargetIcon:Hide();
	end
end
--End MrWolf


-- Target of Target of Target End


------------------------
-- Fade Bar Functions --
------------------------
function Perl_Target_Target_HealthBar_Fade_Check()
	if (PCUF_FADEBARS == 1) then
		if (targettargethealth < Perl_Target_Target_HealthBar:GetValue()) then
			Perl_Target_Target_HealthBarFadeBar:SetMinMaxValues(0, targettargethealthmax);
			Perl_Target_Target_HealthBarFadeBar:SetValue(Perl_Target_Target_HealthBar:GetValue());
			Perl_Target_Target_HealthBarFadeBar:Show();
			Perl_Target_Target_HealthBar_Fade_Color = 1;
			Perl_Target_Target_HealthBar_Fade_Time_Elapsed = 0;
			Perl_Target_Target_HealthBarFadeBar:SetStatusBarColor(0, Perl_Target_Target_HealthBar_Fade_Color, 0, Perl_Target_Target_HealthBar_Fade_Color);
			Perl_Target_Target_HealthBar_Fade_OnUpdate_Frame:Show();
		end
	end
end

function Perl_Target_Target_ManaBar_Fade_Check()
	if (PCUF_FADEBARS == 1) then
		if (targettargetmana < Perl_Target_Target_ManaBar:GetValue()) then
			Perl_Target_Target_ManaBarFadeBar:SetMinMaxValues(0, targettargetmanamax);
			Perl_Target_Target_ManaBarFadeBar:SetValue(Perl_Target_Target_ManaBar:GetValue());
			Perl_Target_Target_ManaBarFadeBar:Show();
			Perl_Target_Target_ManaBar_Fade_Color = 1;
			Perl_Target_Target_ManaBar_Fade_Time_Elapsed = 0;
			if (targettargetpower == 0) then			-- Forcing an initial value will prevent the fade from starting incorrectly
				Perl_Target_Target_ManaBarFadeBar:SetStatusBarColor(0, 0, Perl_Target_Target_ManaBar_Fade_Color, Perl_Target_Target_ManaBar_Fade_Color);
			elseif (targettargetpower == 1) then
				Perl_Target_Target_ManaBarFadeBar:SetStatusBarColor(Perl_Target_Target_ManaBar_Fade_Color, 0, 0, Perl_Target_Target_ManaBar_Fade_Color);
			elseif (targettargetpower == 2) then
				Perl_Target_Target_ManaBarFadeBar:SetStatusBarColor(Perl_Target_Target_ManaBar_Fade_Color, (Perl_Target_Target_ManaBar_Fade_Color-0.5), 0, Perl_Target_Target_ManaBar_Fade_Color);
			elseif (targettargetpower == 3) then
				Perl_Target_Target_ManaBarFadeBar:SetStatusBarColor(Perl_Target_Target_ManaBar_Fade_Color, Perl_Target_Target_ManaBar_Fade_Color, 0, Perl_Target_Target_ManaBar_Fade_Color);
			end
			Perl_Target_Target_ManaBar_Fade_OnUpdate_Frame:Show();
		end
	end
end

function Perl_Target_Target_Target_HealthBar_Fade_Check()
	if (PCUF_FADEBARS == 1) then
		if (targettargettargethealth < Perl_Target_Target_Target_HealthBar:GetValue()) then
			Perl_Target_Target_Target_HealthBarFadeBar:SetMinMaxValues(0, targettargettargethealthmax);
			Perl_Target_Target_Target_HealthBarFadeBar:SetValue(Perl_Target_Target_Target_HealthBar:GetValue());
			Perl_Target_Target_Target_HealthBarFadeBar:Show();
			Perl_Target_Target_Target_HealthBar_Fade_Color = 1;
			Perl_Target_Target_Target_HealthBar_Fade_Time_Elapsed = 0;
			Perl_Target_Target_Target_HealthBarFadeBar:SetStatusBarColor(0, Perl_Target_Target_Target_HealthBar_Fade_Color, 0, Perl_Target_Target_Target_HealthBar_Fade_Color);
			Perl_Target_Target_Target_HealthBar_Fade_OnUpdate_Frame:Show();
		end
	end
end

function Perl_Target_Target_Target_ManaBar_Fade_Check()
	if (PCUF_FADEBARS == 1) then
		if (targettargettargetmana < Perl_Target_Target_Target_ManaBar:GetValue()) then
			Perl_Target_Target_Target_ManaBarFadeBar:SetMinMaxValues(0, targettargettargetmanamax);
			Perl_Target_Target_Target_ManaBarFadeBar:SetValue(Perl_Target_Target_Target_ManaBar:GetValue());
			Perl_Target_Target_Target_ManaBarFadeBar:Show();
			Perl_Target_Target_Target_ManaBar_Fade_Color = 1;
			Perl_Target_Target_Target_ManaBar_Fade_Time_Elapsed = 0;
			if (targettargettargetpower == 0) then
				Perl_Target_Target_Target_ManaBarFadeBar:SetStatusBarColor(0, 0, Perl_Target_Target_Target_ManaBar_Fade_Color, Perl_Target_Target_Target_ManaBar_Fade_Color);
			elseif (targettargettargetpower == 1) then
				Perl_Target_Target_Target_ManaBarFadeBar:SetStatusBarColor(Perl_Target_Target_Target_ManaBar_Fade_Color, 0, 0, Perl_Target_Target_Target_ManaBar_Fade_Color);
			elseif (targettargettargetpower == 2) then
				Perl_Target_Target_Target_ManaBarFadeBar:SetStatusBarColor(Perl_Target_Target_Target_ManaBar_Fade_Color, (Perl_Target_Target_Target_ManaBar_Fade_Color-0.5), 0, Perl_Target_Target_Target_ManaBar_Fade_Color);
			elseif (targettargettargetpower == 3) then
				Perl_Target_Target_Target_ManaBarFadeBar:SetStatusBarColor(Perl_Target_Target_Target_ManaBar_Fade_Color, Perl_Target_Target_Target_ManaBar_Fade_Color, 0, Perl_Target_Target_Target_ManaBar_Fade_Color);
			end
			Perl_Target_Target_Target_ManaBar_Fade_OnUpdate_Frame:Show();
		end
	end
end

function Perl_Target_Target_HealthBar_Fade(arg1)
	Perl_Target_Target_HealthBar_Fade_Color = Perl_Target_Target_HealthBar_Fade_Color - arg1;
	Perl_Target_Target_HealthBar_Fade_Time_Elapsed = Perl_Target_Target_HealthBar_Fade_Time_Elapsed + arg1;

	Perl_Target_Target_HealthBarFadeBar:SetStatusBarColor(0, Perl_Target_Target_HealthBar_Fade_Color, 0, Perl_Target_Target_HealthBar_Fade_Color);

	if (Perl_Target_Target_HealthBar_Fade_Time_Elapsed > 1) then
		Perl_Target_Target_HealthBar_Fade_Color = 1;
		Perl_Target_Target_HealthBar_Fade_Time_Elapsed = 0;
		Perl_Target_Target_HealthBarFadeBar:Hide();
		Perl_Target_Target_HealthBar_Fade_OnUpdate_Frame:Hide();
	end
end

function Perl_Target_Target_ManaBar_Fade(arg1)
	Perl_Target_Target_ManaBar_Fade_Color = Perl_Target_Target_ManaBar_Fade_Color - arg1;
	Perl_Target_Target_ManaBar_Fade_Time_Elapsed = Perl_Target_Target_ManaBar_Fade_Time_Elapsed + arg1;

	if (targettargetpower == 0) then
		Perl_Target_Target_ManaBarFadeBar:SetStatusBarColor(0, 0, Perl_Target_Target_ManaBar_Fade_Color, Perl_Target_Target_ManaBar_Fade_Color);
	elseif (targettargetpower == 1) then
		Perl_Target_Target_ManaBarFadeBar:SetStatusBarColor(Perl_Target_Target_ManaBar_Fade_Color, 0, 0, Perl_Target_Target_ManaBar_Fade_Color);
	elseif (targettargetpower == 2) then
		Perl_Target_Target_ManaBarFadeBar:SetStatusBarColor(Perl_Target_Target_ManaBar_Fade_Color, (Perl_Target_Target_ManaBar_Fade_Color-0.5), 0, Perl_Target_Target_ManaBar_Fade_Color);
	elseif (targettargetpower == 3) then
		Perl_Target_Target_ManaBarFadeBar:SetStatusBarColor(Perl_Target_Target_ManaBar_Fade_Color, Perl_Target_Target_ManaBar_Fade_Color, 0, Perl_Target_Target_ManaBar_Fade_Color);
	end

	if (Perl_Target_Target_ManaBar_Fade_Time_Elapsed > 1) then
		Perl_Target_Target_ManaBar_Fade_Color = 1;
		Perl_Target_Target_ManaBar_Fade_Time_Elapsed = 0;
		Perl_Target_Target_ManaBarFadeBar:Hide();
		Perl_Target_Target_ManaBar_Fade_OnUpdate_Frame:Hide();
	end
end

function Perl_Target_Target_Target_HealthBar_Fade(arg1)
	Perl_Target_Target_Target_HealthBar_Fade_Color = Perl_Target_Target_Target_HealthBar_Fade_Color - arg1;
	Perl_Target_Target_Target_HealthBar_Fade_Time_Elapsed = Perl_Target_Target_Target_HealthBar_Fade_Time_Elapsed + arg1;

	Perl_Target_Target_Target_HealthBarFadeBar:SetStatusBarColor(0, Perl_Target_Target_Target_HealthBar_Fade_Color, 0, Perl_Target_Target_Target_HealthBar_Fade_Color);

	if (Perl_Target_Target_Target_HealthBar_Fade_Time_Elapsed > 1) then
		Perl_Target_Target_Target_HealthBar_Fade_Color = 1;
		Perl_Target_Target_Target_HealthBar_Fade_Time_Elapsed = 0;
		Perl_Target_Target_Target_HealthBarFadeBar:Hide();
		Perl_Target_Target_Target_HealthBar_Fade_OnUpdate_Frame:Hide();
	end
end

function Perl_Target_Target_Target_ManaBar_Fade(arg1)
	Perl_Target_Target_Target_ManaBar_Fade_Color = Perl_Target_Target_Target_ManaBar_Fade_Color - arg1;
	Perl_Target_Target_Target_ManaBar_Fade_Time_Elapsed = Perl_Target_Target_Target_ManaBar_Fade_Time_Elapsed + arg1;

	if (targettargettargetpower == 0) then
		Perl_Target_Target_Target_ManaBarFadeBar:SetStatusBarColor(0, 0, Perl_Target_Target_Target_ManaBar_Fade_Color, Perl_Target_Target_Target_ManaBar_Fade_Color);
	elseif (targettargettargetpower == 1) then
		Perl_Target_Target_Target_ManaBarFadeBar:SetStatusBarColor(Perl_Target_Target_Target_ManaBar_Fade_Color, 0, 0, Perl_Target_Target_Target_ManaBar_Fade_Color);
	elseif (targettargettargetpower == 2) then
		Perl_Target_Target_Target_ManaBarFadeBar:SetStatusBarColor(Perl_Target_Target_Target_ManaBar_Fade_Color, (Perl_Target_Target_Target_ManaBar_Fade_Color-0.5), 0, Perl_Target_Target_Target_ManaBar_Fade_Color);
	elseif (targettargettargetpower == 3) then
		Perl_Target_Target_Target_ManaBarFadeBar:SetStatusBarColor(Perl_Target_Target_Target_ManaBar_Fade_Color, Perl_Target_Target_Target_ManaBar_Fade_Color, 0, Perl_Target_Target_Target_ManaBar_Fade_Color);
	end

	if (Perl_Target_Target_Target_ManaBar_Fade_Time_Elapsed > 1) then
		Perl_Target_Target_Target_ManaBar_Fade_Color = 1;
		Perl_Target_Target_Target_ManaBar_Fade_Time_Elapsed = 0;
		Perl_Target_Target_Target_ManaBarFadeBar:Hide();
		Perl_Target_Target_Target_ManaBar_Fade_OnUpdate_Frame:Hide();
	end
end


--------------------------
-- GUI Config Functions --
--------------------------
function Perl_Target_Target_Set_ToT(newvalue)
	totsupport = newvalue;
	Perl_Target_Target_UpdateVars();
end

function Perl_Target_Target_Set_ToToT(newvalue)
	tototsupport = newvalue;
	Perl_Target_Target_UpdateVars();
end

function Perl_Target_Target_Set_Mode(newvalue)
	alertmode = newvalue;
	Perl_Target_Target_UpdateVars();
end

function Perl_Target_Target_Set_Sound_Alert(newvalue)
	alertsound = newvalue;
	Perl_Target_Target_UpdateVars();
end

function Perl_Target_Target_Set_Alert_Size(newvalue)
	alertsize = newvalue;
	Perl_Target_Target_UpdateVars();
end

function Perl_Target_Target_Set_MobHealth(newvalue)
	mobhealthsupport = newvalue;
	Perl_Target_Target_UpdateVars();
end

function Perl_Target_Target_Set_Lock(newvalue)
	locked = newvalue;
	Perl_Target_Target_UpdateVars();
end

function Perl_Target_Target_Set_Buffs(newvalue)
	showtotbuffs = newvalue;
	Perl_Target_Target_UpdateVars();
	Perl_Target_Target_Reset_Buffs();
end

function Perl_Target_Target_Set_Debuffs(newvalue)
	showtotdebuffs = newvalue;
	Perl_Target_Target_UpdateVars();
	Perl_Target_Target_Reset_Buffs();
end

function Perl_Target_Target_Target_Set_Buffs(newvalue)
	showtototbuffs = newvalue;
	Perl_Target_Target_UpdateVars();
	Perl_Target_Target_Target_Reset_Buffs();
end

function Perl_Target_Target_Target_Set_Debuffs(newvalue)
	showtototdebuffs = newvalue;
	Perl_Target_Target_UpdateVars();
	Perl_Target_Target_Target_Reset_Buffs();
end

function Perl_Target_Target_Set_Hide_Power_Bars(newvalue)
	hidepowerbars = newvalue;
	Perl_Target_Target_UpdateVars();
end

function Perl_Target_Target_Set_Class_Colored_Names(newvalue)
	classcolorednames = newvalue;
	Perl_Target_Target_UpdateVars();
end

function Perl_Target_Target_Set_Class_Buffs(newvalue)
	displaycastablebuffs = newvalue;
	Perl_Target_Target_UpdateVars();
	Perl_Target_Target_Reset_Buffs();
	Perl_Target_Target_Target_Reset_Buffs();
end

function Perl_Target_Target_Set_Show_Friendly_Health(newvalue)
	showfriendlyhealth = newvalue;
	Perl_Target_Target_UpdateVars();
end

function Perl_Target_Target_Set_Scale(number)
	local unsavedscale;
	if (number ~= nil) then
		scale = (number / 100);					-- convert the user input to a wow acceptable value
		--DEFAULT_CHAT_FRAME:AddMessage("|cffffff00Target of Target Display is now scaled to |cffffffff"..floor(scale * 100 + 0.5).."%|cffffff00.");	-- only display if the user gave us a number
	end
	unsavedscale = 1 - UIParent:GetEffectiveScale() + scale;	-- run it through the scaling formula introduced in 1.9
	Perl_Target_Target_Frame:SetScale(unsavedscale);
	Perl_Target_Target_Target_Frame:SetScale(unsavedscale);
	Perl_Target_Target_UpdateVars();
end

function Perl_Target_Target_Set_Transparency(number)
	if (number ~= nil) then
		transparency = (number / 100);				-- convert the user input to a wow acceptable value
	end
	Perl_Target_Target_Frame:SetAlpha(transparency);
	Perl_Target_Target_Target_Frame:SetAlpha(transparency);
	Perl_Target_Target_UpdateVars();
end

function Perl_Target_Target_Allign(button)
	if (Perl_Target_Frame) then
		local vartable = Perl_Target_GetVars();			-- Get the target frame settings

		Perl_Target_Target_Frame:SetUserPlaced(1);		-- This makes wow remember the changes if the frames have never been moved before
		Perl_Target_Target_Target_Frame:SetUserPlaced(1);

		if (button == 1) then
			if (vartable["showportrait"] == 1) then
				if (vartable["showcp"] == 1 or vartable["comboframedebuffs"] == 1) then
					Perl_Target_Target_Frame:SetPoint("TOPLEFT", Perl_Target_PortraitFrame, "TOPRIGHT", 17, 0);
--Changed by MrWolf
					Perl_Target_Target_Target_Frame:SetPoint("TOPLEFT", Perl_Target_Target_PortraitFrame, "TOPRIGHT", -4, 0);--END
				else
					Perl_Target_Target_Frame:SetPoint("TOPLEFT", Perl_Target_PortraitFrame, "TOPRIGHT", -4, 0);
--Changed by MrWolf
					Perl_Target_Target_Target_Frame:SetPoint("TOPLEFT", Perl_Target_Target_PortraitFrame, "TOPRIGHT", -4, 0);--END
				end
			else
				if (vartable["showcp"] == 1 or vartable["comboframedebuffs"] == 1) then
					Perl_Target_Target_Frame:SetPoint("TOPLEFT", Perl_Target_LevelFrame, "TOPRIGHT", 17, 0);
--Changed by MrWolf
					Perl_Target_Target_Target_Frame:SetPoint("TOPLEFT", Perl_Target_Target_PortraitFrame, "TOPRIGHT", -4, 0);--END
				else
					Perl_Target_Target_Frame:SetPoint("TOPLEFT", Perl_Target_LevelFrame, "TOPRIGHT", -4, 0);
--Changed by MrWolf
					Perl_Target_Target_Target_Frame:SetPoint("TOPLEFT", Perl_Target_Target_PortraitFrame, "TOPRIGHT", -4, 0);--END
				end
			end
		elseif (button == 2) then
			if (vartable["showclassframe"] == 1 or vartable["showrareeliteframe"] == 1) then
				Perl_Target_Target_Frame:SetPoint("TOPLEFT", Perl_Target_NameFrame, "TOPLEFT", 0, 77);
--Changed by MrWolf
					Perl_Target_Target_Target_Frame:SetPoint("TOPLEFT", Perl_Target_Target_PortraitFrame, "TOPRIGHT", 1, 0);--END
			else
				Perl_Target_Target_Frame:SetPoint("TOPLEFT", Perl_Target_NameFrame, "TOPLEFT", 0, 57);
--Changed by MrWolf
					Perl_Target_Target_Target_Frame:SetPoint("TOPLEFT", Perl_Target_Target_PortraitFrame, "TOPRIGHT", 1, 0);--END
			end
		end
	else
		DEFAULT_CHAT_FRAME:AddMessage("This feature is disabled due to Perl_Target not being installed/enabled.");
	end
end


------------------------------
-- Saved Variable Functions --
------------------------------
function Perl_Target_Target_GetVars(name, updateflag)
	if (name == nil) then
		name = UnitName("player");
	end

	locked = Perl_Target_Target_Config[name]["Locked"];
	mobhealthsupport = Perl_Target_Target_Config[name]["MobHealthSupport"];
	scale = Perl_Target_Target_Config[name]["Scale"];
	totsupport = Perl_Target_Target_Config[name]["ToTSupport"];
	tototsupport = Perl_Target_Target_Config[name]["ToToTSupport"];
	transparency = Perl_Target_Target_Config[name]["Transparency"];
	alertsound = Perl_Target_Target_Config[name]["AlertSound"];
	alertmode = Perl_Target_Target_Config[name]["AlertMode"];
	alertsize = Perl_Target_Target_Config[name]["AlertSize"];
	showtotbuffs = Perl_Target_Target_Config[name]["ShowToTBuffs"];
	showtototbuffs = Perl_Target_Target_Config[name]["ShowToToTBuffs"];
	hidepowerbars = Perl_Target_Target_Config[name]["HidePowerBars"];
	showtotdebuffs = Perl_Target_Target_Config[name]["ShowToTDebuffs"];
	showtototdebuffs = Perl_Target_Target_Config[name]["ShowToToTDebuffs"];
	displaycastablebuffs = Perl_Target_Target_Config[name]["DisplayCastableBuffs"];
	classcolorednames = Perl_Target_Target_Config[name]["ClassColoredNames"];
	showfriendlyhealth = Perl_Target_Target_Config[name]["ShowFriendlyHealth"];

	if (locked == nil) then
		locked = 0;
	end
	if (mobhealthsupport == nil) then
		mobhealthsupport = 1;
	end
	if (scale == nil) then
		scale = 1;
	end
	if (totsupport == nil) then
		totsupport = 1;
	end
	if (tototsupport == nil) then
		tototsupport = 1;
	end
	if (transparency == nil) then
		transparency = 1;
	end
	if (alertsound == nil) then
		alertsound = 0;
	end
	if (alertmode == nil) then
		alertmode = 0;
	end
	if (alertsize == nil) then
		alertsize = 0;
	end
	if (showtotbuffs == nil) then
		showtotbuffs = 0;
	end
	if (showtototbuffs == nil) then
		showtototbuffs = 0;
	end
	if (hidepowerbars == nil) then
		hidepowerbars = 0;
	end
	if (showtotdebuffs == nil) then
		showtotdebuffs = 0;
	end
	if (showtototdebuffs == nil) then
		showtototdebuffs = 0;
	end
	if (displaycastablebuffs == nil) then
		displaycastablebuffs = 0;
	end
	if (classcolorednames == nil) then
		classcolorednames = 0;
	end
	if (showfriendlyhealth == nil) then
		showfriendlyhealth = 0;
	end

	if (updateflag == 1) then
		-- Save the new values
		Perl_Target_Target_UpdateVars();

		-- Call any code we need to activate them
		Perl_Target_Target_Set_Scale();
		Perl_Target_Target_Set_Transparency();
		return;
	end

	local vars = {
		["locked"] = locked,
		["mobhealthsupport"] = mobhealthsupport,
		["scale"] = scale,
		["totsupport"] = totsupport,
		["tototsupport"] = tototsupport,
		["transparency"] = transparency,
		["alertsound"] = alertsound,
		["alertmode"] = alertmode,
		["alertsize"] = alertsize,
		["showtotbuffs"] = showtotbuffs,
		["showtototbuffs"] = showtototbuffs,
		["hidepowerbars"] = hidepowerbars,
		["showtotdebuffs"] = showtotdebuffs,
		["showtototdebuffs"] = showtototdebuffs,
		["displaycastablebuffs"] = displaycastablebuffs,
		["classcolorednames"] = classcolorednames,
		["showfriendlyhealth"] = showfriendlyhealth,
	}
	return vars;
end

function Perl_Target_Target_UpdateVars(vartable)
	if (vartable ~= nil) then
		-- Sanity checks in case you use a load from an old version
		if (vartable["Global Settings"] ~= nil) then
			if (vartable["Global Settings"]["Locked"] ~= nil) then
				locked = vartable["Global Settings"]["Locked"];
			else
				locked = nil;
			end
			if (vartable["Global Settings"]["MobHealthSupport"] ~= nil) then
				mobhealthsupport = vartable["Global Settings"]["MobHealthSupport"];
			else
				mobhealthsupport = nil;
			end
			if (vartable["Global Settings"]["Scale"] ~= nil) then
				scale = vartable["Global Settings"]["Scale"];
			else
				scale = nil;
			end
			if (vartable["Global Settings"]["ToTSupport"] ~= nil) then
				totsupport = vartable["Global Settings"]["ToTSupport"];
			else
				totsupport = nil;
			end
			if (vartable["Global Settings"]["ToToTSupport"] ~= nil) then
				tototsupport = vartable["Global Settings"]["ToToTSupport"];
			else
				tototsupport = nil;
			end
			if (vartable["Global Settings"]["Transparency"] ~= nil) then
				transparency = vartable["Global Settings"]["Transparency"];
			else
				transparency = nil;
			end
			if (vartable["Global Settings"]["AlertSound"] ~= nil) then
				alertsound = vartable["Global Settings"]["AlertSound"];
			else
				alertsound = nil;
			end
			if (vartable["Global Settings"]["AlertMode"] ~= nil) then
				alertmode = vartable["Global Settings"]["AlertMode"];
			else
				alertmode = nil;
			end
			if (vartable["Global Settings"]["AlertSize"] ~= nil) then
				alertsize = vartable["Global Settings"]["AlertSize"];
			else
				alertsize = nil;
			end
			if (vartable["Global Settings"]["ShowToTBuffs"] ~= nil) then
				showtotbuffs = vartable["Global Settings"]["ShowToTBuffs"];
			else
				showtotbuffs = nil;
			end
			if (vartable["Global Settings"]["ShowToToTBuffs"] ~= nil) then
				showtototbuffs = vartable["Global Settings"]["ShowToToTBuffs"];
			else
				showtototbuffs = nil;
			end
			if (vartable["Global Settings"]["HidePowerBars"] ~= nil) then
				hidepowerbars = vartable["Global Settings"]["HidePowerBars"];
			else
				hidepowerbars = nil;
			end
			if (vartable["Global Settings"]["ShowToTDebuffs"] ~= nil) then
				showtotdebuffs = vartable["Global Settings"]["ShowToTDebuffs"];
			else
				showtotdebuffs = nil;
			end
			if (vartable["Global Settings"]["ShowToToTDebuffs"] ~= nil) then
				showtototdebuffs = vartable["Global Settings"]["ShowToToTDebuffs"];
			else
				showtototdebuffs = nil;
			end
			if (vartable["Global Settings"]["DisplayCastableBuffs"] ~= nil) then
				displaycastablebuffs = vartable["Global Settings"]["DisplayCastableBuffs"];
			else
				displaycastablebuffs = nil;
			end
			if (vartable["Global Settings"]["ClassColoredNames"] ~= nil) then
				classcolorednames = vartable["Global Settings"]["ClassColoredNames"];
			else
				classcolorednames = nil;
			end
			if (vartable["Global Settings"]["ShowFriendlyHealth"] ~= nil) then
				showfriendlyhealth = vartable["Global Settings"]["ShowFriendlyHealth"];
			else
				showfriendlyhealth = nil;
			end
		end

		-- Set the new values if any new values were found, same defaults as above
		if (locked == nil) then
			locked = 0;
		end
		if (mobhealthsupport == nil) then
			mobhealthsupport = 1;
		end
		if (scale == nil) then
			scale = 1;
		end
		if (totsupport == nil) then
			totsupport = 1;
		end
		if (tototsupport == nil) then
			tototsupport = 1;
		end
		if (transparency == nil) then
			transparency = 1;
		end
		if (alertsound == nil) then
			alertsound = 0;
		end
		if (alertmode == nil) then
			alertmode = 0;
		end
		if (alertsize == nil) then
			alertsize = 0;
		end
		if (showtotbuffs == nil) then
			showtotbuffs = 0;
		end
		if (showtototbuffs == nil) then
			showtototbuffs = 0;
		end
		if (hidepowerbars == nil) then
			hidepowerbars = 0;
		end
		if (showtotdebuffs == nil) then
			showtotdebuffs = 0;
		end
		if (showtototdebuffs == nil) then
			showtototdebuffs = 0;
		end
		if (displaycastablebuffs == nil) then
			displaycastablebuffs = 0;
		end
		if (classcolorednames == nil) then
			classcolorednames = 0;
		end
		if (showfriendlyhealth == nil) then
			showfriendlyhealth = 0;
		end

		-- Call any code we need to activate them
		Perl_Target_Target_Set_Scale();
		Perl_Target_Target_Set_Transparency();
	end

	-- IFrameManager Support
	if (IFrameManager) then
		IFrameManager:Refresh();
	end

	Perl_Target_Target_Config[UnitName("player")] = {
		["Locked"] = locked,
		["MobHealthSupport"] = mobhealthsupport,
		["Scale"] = scale,
		["ToTSupport"] = totsupport,
		["ToToTSupport"] = tototsupport,
		["Transparency"] = transparency,
		["AlertSound"] = alertsound,
		["AlertMode"] = alertmode,
		["AlertSize"] = alertsize,
		["ShowToTBuffs"] = showtotbuffs,
		["ShowToToTBuffs"] = showtototbuffs,
		["HidePowerBars"] = hidepowerbars,
		["ShowToTDebuffs"] = showtotdebuffs,
		["ShowToToTDebuffs"] = showtototdebuffs,
		["DisplayCastableBuffs"] = displaycastablebuffs,
		["ClassColoredNames"] = classcolorednames,
		["ShowFriendlyHealth"] = showfriendlyhealth,
	};
end


--------------------
-- Click Handlers --
--------------------
-- Target of Target Start
function Perl_TargetTargetDropDown_OnLoad()
	UIDropDownMenu_Initialize(this, Perl_TargetTargetDropDown_Initialize, "MENU");
end

function Perl_TargetTargetDropDown_Initialize()
	local menu, name;
	if (UnitExists("targettarget") and (UnitIsEnemy("targettarget", "player") or (UnitReaction("player", "targettarget") and (UnitReaction("player", "targettarget") >= 4) and not UnitIsPlayer("targettarget")))) then
		menu = "RAID_TARGET_ICON";
		name = RAID_TARGET_ICON;
	elseif (UnitIsUnit("targettarget", "player")) then
		menu = "SELF";
	elseif (UnitIsUnit("targettarget", "pet")) then
		menu = "PET";
	elseif (UnitIsPlayer("targettarget")) then
		if (UnitInParty("targettarget")) then
			menu = "PARTY";
		else
			menu = "PLAYER";
		end
	end
	if (menu) then
		UnitPopup_ShowMenu(Perl_Target_Target_DropDown, menu, "targettarget", name);
	end
end

function Perl_Target_Target_MouseClick(button)
	if (Perl_Custom_ClickFunction) then					-- Check to see if someone defined a custom click function
		if (Perl_Custom_ClickFunction(button, "targettarget")) then	-- If the function returns true, then we return
			return;
		end
	end									-- Otherwise, it did nothing, so take default action

	if (PCUF_CASTPARTYSUPPORT == 1) then
		if (not string.find(GetMouseFocus():GetName(), "Name") or PCUF_NAMEFRAMECLICKCAST == 1) then
			if (CastPartyConfig) then
				CastParty_OnClickByUnit(button, "targettarget");
				return;
			elseif (Genesis_MouseHeal and Genesis_MouseHeal("targettarget", button)) then
				return;
			elseif (CH_Config) then
				if (CH_Config.PCUFEnabled) then
					CH_UnitClicked("targettarget", button);
					return;
				end
			elseif (SmartHeal) then
				if (SmartHeal.Loaded and SmartHeal:getConfig("enable", "clickmode")) then
					local KeyDownType = SmartHeal:GetClickHealButton();
					if(KeyDownType and KeyDownType ~= "undetermined") then
						SmartHeal:ClickHeal(KeyDownType..button, "targettarget");
					else
						SmartHeal:DefaultClick(button, "targettarget");
					end
					return;
				end
			end
		end
	end

	if (button == "LeftButton") then
		if (SpellIsTargeting()) then
			SpellTargetUnit("targettarget");
		elseif (CursorHasItem()) then
			DropItemOnUnit("targettarget");
		else
			TargetUnit("targettarget");
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
		ToggleDropDownMenu(1, nil, Perl_Target_Target_DropDown, "Perl_Target_Target_NameFrame", 40, 0);
	end
end

function Perl_Target_Target_DragStart(button)
	if (button == "LeftButton" and locked == 0) then
		Perl_Target_Target_Frame:StartMoving();
	end
end

function Perl_Target_Target_DragStop(button)
	Perl_Target_Target_Frame:StopMovingOrSizing();
end
-- Target of Target End

-- Target of Target of Target Start
function Perl_TargetTargetTargetDropDown_OnLoad()
	UIDropDownMenu_Initialize(this, Perl_TargetTargetTargetDropDown_Initialize, "MENU");
end

function Perl_TargetTargetTargetDropDown_Initialize()
	local menu, name;
	if (UnitExists("targettargettarget") and (UnitIsEnemy("targettargettarget", "player") or (UnitReaction("player", "targettargettarget") and (UnitReaction("player", "targettargettarget") >= 4) and not UnitIsPlayer("targettargettarget")))) then
		menu = "RAID_TARGET_ICON";
		name = RAID_TARGET_ICON;
	elseif (UnitIsUnit("targettargettarget", "player")) then
		menu = "SELF";
	elseif (UnitIsUnit("targettargettarget", "pet")) then
		menu = "PET";
	elseif (UnitIsPlayer("targettargettarget")) then
		if (UnitInParty("targettargettarget")) then
			menu = "PARTY";
		else
			menu = "PLAYER";
		end
	end
	if (menu) then
		UnitPopup_ShowMenu(Perl_Target_Target_Target_DropDown, menu, "targettargettarget", name);
	end
end

function Perl_Target_Target_Target_MouseClick(button)
	if (Perl_Custom_ClickFunction) then						-- Check to see if someone defined a custom click function
		if (Perl_Custom_ClickFunction(button, "targettargettarget")) then	-- If the function returns true, then we return
			return;
		end
	end										-- Otherwise, it did nothing, so take default action

	if (PCUF_CASTPARTYSUPPORT == 1) then
		if (not string.find(GetMouseFocus():GetName(), "Name") or PCUF_NAMEFRAMECLICKCAST == 1) then
			if (CastPartyConfig) then
				CastParty_OnClickByUnit(button, "targettargettarget");
				return;
			elseif (Genesis_MouseHeal and Genesis_MouseHeal("targettargettarget", button)) then
				return;
			elseif (CH_Config) then
				if (CH_Config.PCUFEnabled) then
					CH_UnitClicked("targettargettarget", button);
					return;
				end
			elseif (SmartHeal) then
				if (SmartHeal.Loaded and SmartHeal:getConfig("enable", "clickmode")) then
					local KeyDownType = SmartHeal:GetClickHealButton();
					if(KeyDownType and KeyDownType ~= "undetermined") then
						SmartHeal:ClickHeal(KeyDownType..button, "targettargettarget");
					else
						SmartHeal:DefaultClick(button, "targettargettarget");
					end
					return;
				end
			end
		end
	end

	if (button == "LeftButton") then
		if (SpellIsTargeting()) then
			SpellTargetUnit("targettargettarget");
		elseif (CursorHasItem()) then
			DropItemOnUnit("targettargettarget");
		else
			TargetUnit("targettargettarget");
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
		ToggleDropDownMenu(1, nil, Perl_Target_Target_Target_DropDown, "Perl_Target_Target_Target_NameFrame", 40, 0);
	end
end

function Perl_Target_Target_Target_DragStart(button)
	if (button == "LeftButton" and locked == 0) then
		Perl_Target_Target_Target_Frame:StartMoving();
	end
end

function Perl_Target_Target_Target_DragStop(button)
	Perl_Target_Target_Target_Frame:StopMovingOrSizing();
end
-- Target of Target of Target End


----------------------------
-- Big Warning Text Frame --
----------------------------
-- Fade in/out frame stuff
-- Ripped/modified from FadingFrame from Blizzard
-- Ripped from AggroAlert 1.5

function Perl_Target_Target_BigWarning_OnLoad()
	Perl_Target_Target_BigWarning:Hide();
end

function Perl_Target_Target_BigWarning_Show(message)
	startTime = GetTime();
	if (message) then
		Perl_Target_Target_BigWarning_Text:SetText(message);
	end
	Perl_Target_Target_BigWarning:Show();
end


function Perl_Target_Target_BigWarning_OnUpdate()
	local elapsed = GetTime() - startTime;
	local fadeInTime = 0.2;
	if (elapsed < fadeInTime) then
		local alpha = (elapsed / fadeInTime);
		Perl_Target_Target_BigWarning:SetAlpha(alpha);
		return;
	end
	local holdTime = 2.5;
	if (elapsed < (fadeInTime + holdTime)) then
		Perl_Target_Target_BigWarning:SetAlpha(1.0);
		return;
	end
	local fadeOutTime = 2;
	if (elapsed < (fadeInTime + holdTime + fadeOutTime)) then
		local alpha = 1.0 - ((elapsed - holdTime - fadeInTime) / fadeOutTime);
		Perl_Target_Target_BigWarning:SetAlpha(alpha);
		return;
	end
	Perl_Target_Target_BigWarning:Hide();
end


-------------
-- Tooltip --
-------------
function Perl_Target_Target_SetBuffTooltip()
	GameTooltip:SetOwner(this, "ANCHOR_BOTTOMRIGHT");
	if (this:GetID() > 16) then
		GameTooltip:SetUnitDebuff("targettarget", this:GetID()-16, displaycastablebuffs);		-- 16 being the number of buffs before debuffs in the xml
	else
		GameTooltip:SetUnitBuff("targettarget", this:GetID(), displaycastablebuffs);
	end
end

function Perl_Target_Target_Target_SetBuffTooltip()
	GameTooltip:SetOwner(this, "ANCHOR_BOTTOMRIGHT");
	if (this:GetID() > 16) then
		GameTooltip:SetUnitDebuff("targettargettarget", this:GetID()-16, displaycastablebuffs);		-- 16 being the number of buffs before debuffs in the xml
	else
		GameTooltip:SetUnitBuff("targettargettarget", this:GetID(), displaycastablebuffs);
	end
end

function Perl_Target_Target_Tip()
	UnitFrame_Initialize("targettarget")
end

function Perl_Target_Target_Target_Tip()
	UnitFrame_Initialize("targettargettarget")
end

function UnitFrame_Initialize(unit)	-- Hopefully this doesn't break any mods
	this.unit = unit;
end


----------------------
-- myAddOns Support --
----------------------
function Perl_Target_Target_myAddOns_Support()
	-- Register the addon in myAddOns
	if (myAddOnsFrame_Register) then
		local Perl_Target_Target_myAddOns_Details = {
			name = "Perl_Target_Target",
			version = PERL_LOCALIZED_VERSION,
			releaseDate = PERL_LOCALIZED_DATE,
			author = "Global",
			email = "global@g-ball.com",
			website = "http://www.curse-gaming.com/mod.php?addid=2257",
			category = MYADDONS_CATEGORY_OTHERS
		};
		Perl_Target_Target_myAddOns_Help = {};
		Perl_Target_Target_myAddOns_Help[1] = "/perl";
		myAddOnsFrame_Register(Perl_Target_Target_myAddOns_Details, Perl_Target_Target_myAddOns_Help);
	end
end
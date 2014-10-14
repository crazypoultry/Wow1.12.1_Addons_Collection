---------------
-- Variables --
---------------
Perl_Player_Config = {};
local Perl_Player_Events = {};	-- event manager

-- Default Saved Variables (also set in Perl_Player_GetVars)
local locked = 0;		-- unlocked by default
local xpbarstate = 1;		-- show default xp bar by default
local compactmode = 0;		-- compact mode is disabled by default
local showraidgroup = 1;	-- show the raid group number by default when in raids
local scale = 1;		-- default scale
local healermode = 0;		-- nurfed unit frame style
local transparency = 1;		-- transparency for frames
local showportrait = 0;		-- portrait is hidden by default
local compactpercent = 0;	-- percents are not shown in compact mode by default
local threedportrait = 0;	-- 3d portraits are off by default
local portraitcombattext = 0;	-- Combat text is disabled by default on the portrait frame
local showdruidbar = 0;		-- Druid Bar support is enabled by default
local fivesecsupport = 0;	-- FiveSec support is disabled by default
local shortbars = 0;		-- Health/Power/Experience bars are all normal length
local classcolorednames = 0;	-- names are colored based on pvp status by default
local hideclasslevelframe = 0;	-- Showing the class icon and level frame by default
local showpvprank = 0;		-- hide the pvp rank by default
local showmanadeficit = 0;	-- Mana deficit in healer mode is off by default
local hiddeninraid = 0;		-- player frame is shown in a raid by default
local showpvpicon = 1;		-- show the pvp icon
local showbarvalues = 0;	-- healer mode will have the bar values hidden by default

-- Default Local Variables
local InCombat = 0;		-- used to track if the player is in combat and if the icon should be displayed
local Initialized = nil;	-- waiting to be initialized
local Perl_Player_DruidBar_Time_Elapsed = 0;		-- set the update timer to 0
local Perl_Player_DruidBar_Time_Update_Rate = 0.2;	-- the update interval
local mouseoverhealthflag = 0;	-- is the mouse over the health bar for healer mode?
local mouseovermanaflag = 0;	-- is the mouse over the mana bar for healer mode?

-- Fade Bar Variables
local Perl_Player_HealthBar_Fade_Color = 1;		-- the color fading interval
local Perl_Player_HealthBar_Fade_Time_Elapsed = 0;	-- set the update timer to 0
local Perl_Player_ManaBar_Fade_Color = 1;		-- the color fading interval
local Perl_Player_ManaBar_Fade_Time_Elapsed = 0;	-- set the update timer to 0
--local Perl_Player_DruidBar_Fade_Color = 1;		-- the color fading interval
--local Perl_Player_DruidBar_Fade_Time_Elapsed = 0;	-- set the update timer to 0

-- Local variables to save memory
local playerhealth, playerhealthmax, playerhealthpercent, playermana, playermanamax, playermanapercent, playerdruidbarmana, playerdruidbarmanamax, playerdruidbarmanapercent, playerpower;

-- Variables for position of the class icon texture.
local Perl_Player_ClassPosRight = {};
local Perl_Player_ClassPosLeft = {};
local Perl_Player_ClassPosTop = {};
local Perl_Player_ClassPosBottom = {};


----------------------
-- Loading Function --
----------------------
function Perl_Player_OnLoad()
	-- Combat Text
	CombatFeedback_Initialize(Perl_Player_HitIndicator, 30);

	-- Events
	this:RegisterEvent("PARTY_LEADER_CHANGED");
	this:RegisterEvent("PARTY_LOOT_METHOD_CHANGED");
	this:RegisterEvent("PARTY_MEMBERS_CHANGED");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("PLAYER_REGEN_DISABLED");
	this:RegisterEvent("PLAYER_REGEN_ENABLED");
	this:RegisterEvent("PLAYER_UPDATE_RESTING");
	this:RegisterEvent("PLAYER_XP_UPDATE");
	this:RegisterEvent("RAID_ROSTER_UPDATE");
	this:RegisterEvent("UNIT_COMBAT");
	this:RegisterEvent("UNIT_DISPLAYPOWER");
	this:RegisterEvent("UNIT_ENERGY");
	this:RegisterEvent("UNIT_FACTION");
	this:RegisterEvent("UNIT_HEALTH");
	this:RegisterEvent("UNIT_LEVEL");
	this:RegisterEvent("UNIT_MANA");
	this:RegisterEvent("UNIT_MAXENERGY");
	this:RegisterEvent("UNIT_MAXHEALTH");
	this:RegisterEvent("UNIT_MAXMANA");
	this:RegisterEvent("UNIT_MAXRAGE");
	this:RegisterEvent("UNIT_MODEL_CHANGED");
	this:RegisterEvent("UNIT_PORTRAIT_UPDATE");
	this:RegisterEvent("UNIT_PVP_UPDATE");
	this:RegisterEvent("UNIT_RAGE");
	this:RegisterEvent("UNIT_SPELLMISS");
	this:RegisterEvent("UPDATE_FACTION");
	this:RegisterEvent("VARIABLES_LOADED");

	-- Scripts
	this:SetScript("OnEvent", Perl_Player_OnEvent);
	this:SetScript("OnUpdate", CombatFeedback_OnUpdate);

	-- Button Click Overlays (in order of occurrence in XML)
	Perl_Player_Name_CastClickOverlay:SetFrameLevel(Perl_Player_Name:GetFrameLevel() + 2);
	Perl_Player_RaidGroupNumberFrame_CastClickOverlay:SetFrameLevel(Perl_Player_RaidGroupNumberFrame:GetFrameLevel() + 1);
	Perl_Player_LevelFrame_CastClickOverlay:SetFrameLevel(Perl_Player_LevelFrame:GetFrameLevel() + 1);
	Perl_Player_PortraitFrame_CastClickOverlay:SetFrameLevel(Perl_Player_PortraitFrame:GetFrameLevel() + 2);
	Perl_Player_PortraitTextFrame:SetFrameLevel(Perl_Player_PortraitFrame:GetFrameLevel() + 1);
	Perl_Player_StatsFrame_CastClickOverlay:SetFrameLevel(Perl_Player_StatsFrame:GetFrameLevel() + 1);
	Perl_Player_HealthBar_CastClickOverlay:SetFrameLevel(Perl_Player_StatsFrame:GetFrameLevel() + 2);
	Perl_Player_ManaBar_CastClickOverlay:SetFrameLevel(Perl_Player_StatsFrame:GetFrameLevel() + 2);
	Perl_Player_DruidBar_CastClickOverlay:SetFrameLevel(Perl_Player_StatsFrame:GetFrameLevel() + 2);
	Perl_Player_XPBar_CastClickOverlay:SetFrameLevel(Perl_Player_StatsFrame:GetFrameLevel() + 2);
	Perl_Player_HealthBarFadeBar:SetFrameLevel(Perl_Player_HealthBar:GetFrameLevel() - 1);
	Perl_Player_ManaBarFadeBar:SetFrameLevel(Perl_Player_ManaBar:GetFrameLevel() - 1);
	--Perl_Player_DruidBarFadeBar:SetFrameLevel(Perl_Player_DruidBar:GetFrameLevel() - 1);
end


-------------------
-- Event Handler --
-------------------
function Perl_Player_OnEvent()
	local func = Perl_Player_Events[event];
	if (func) then
		func();
--	else
--		DEFAULT_CHAT_FRAME:AddMessage("Perl Classic - Player: Report the following event error to the author: "..event);
	end
end

function Perl_Player_Events:UNIT_HEALTH()
	if (arg1 == "player") then
		Perl_Player_Update_Health();		-- Update health values
	end
end
Perl_Player_Events.UNIT_MAXHEALTH = Perl_Player_Events.UNIT_HEALTH;

function Perl_Player_Events:UNIT_MANA()
	if (arg1 == "player") then
		Perl_Player_Update_Mana();		-- Update energy/mana/rage values
	end
end
Perl_Player_Events.UNIT_MAXMANA = Perl_Player_Events.UNIT_MANA;
Perl_Player_Events.UNIT_ENERGY = Perl_Player_Events.UNIT_MANA;
Perl_Player_Events.UNIT_MAXENERGY = Perl_Player_Events.UNIT_MANA;
Perl_Player_Events.UNIT_RAGE = Perl_Player_Events.UNIT_MANA;
Perl_Player_Events.UNIT_MAXRAGE = Perl_Player_Events.UNIT_MANA;

function Perl_Player_Events:UNIT_DISPLAYPOWER()
	if (arg1 == "player") then
		Perl_Player_Update_Mana_Bar();		-- What type of energy are we using now?
		Perl_Player_Update_Mana();		-- Update the energy info immediately
	end
end

function Perl_Player_Events:UNIT_COMBAT()
	if (arg1 == "player") then
		CombatFeedback_OnCombatEvent(arg2, arg3, arg4, arg5);
	end
end

function Perl_Player_Events:UNIT_SPELLMISS()
	if (arg1 == "player") then
		CombatFeedback_OnSpellMissEvent(arg2);
	end
end

function Perl_Player_Events:PLAYER_UPDATE_RESTING()
	Perl_Player_Update_Combat_Status(event);	-- Are we fighting, resting, or none?
end
Perl_Player_Events.PLAYER_REGEN_DISABLED = Perl_Player_Events.PLAYER_UPDATE_RESTING;
Perl_Player_Events.PLAYER_REGEN_ENABLED = Perl_Player_Events.PLAYER_UPDATE_RESTING;

function Perl_Player_Events:PLAYER_XP_UPDATE()
	if (xpbarstate == 1) then
		Perl_Player_Update_Experience();	-- Set the experience bar info
	end
end

function Perl_Player_Events:UPDATE_FACTION()
	if (xpbarstate == 4) then
		Perl_Player_Update_Reputation();	-- Set faction info
	end
end

function Perl_Player_Events:UNIT_FACTION()
	Perl_Player_Update_PvP_Status();		-- Is the character PvP flagged?
end
Perl_Player_Events.UNIT_PVP_UPDATE = Perl_Player_Events.UNIT_FACTION;

function Perl_Player_Events:UNIT_LEVEL()
	if (arg1 == "player") then
		Perl_Player_LevelFrame_LevelBarText:SetText(UnitLevel("player"));	-- Set the player's level
	end
end

function Perl_Player_Events:RAID_ROSTER_UPDATE()
	Perl_Player_Update_Raid_Group_Number();		-- What raid group number are we in?
	Perl_Player_Check_Hidden();			-- Are suppossed to hide the frame?
end

function Perl_Player_Events:PARTY_LEADER_CHANGED()
	Perl_Player_Update_Leader();			-- Are we the party leader?
end
Perl_Player_Events.PARTY_MEMBERS_CHANGED = Perl_Player_Events.PARTY_LEADER_CHANGED;

function Perl_Player_Events:PARTY_LOOT_METHOD_CHANGED()
	Perl_Player_Update_Loot_Method();
end

function Perl_Player_Events:UNIT_PORTRAIT_UPDATE()
	if (arg1 == "player") then
		Perl_Player_Update_Portrait();
	end
end
Perl_Player_Events.UNIT_MODEL_CHANGED = Perl_Player_Events.UNIT_PORTRAIT_UPDATE;

function Perl_Player_Events:VARIABLES_LOADED()
	Perl_Player_Initialize();
end
Perl_Player_Events.PLAYER_ENTERING_WORLD = Perl_Player_Events.VARIABLES_LOADED;


-------------------------------
-- Loading Settings Function --
-------------------------------
function Perl_Player_Initialize()
	-- Code to be run after zoning or logging in goes here
	if (Initialized) then
		InCombat = 0;				-- You can't be fighting if you're zoning, and no event is sent, force it to no combat.
		Perl_Player_Set_Scale();		-- Set the scale
		Perl_Player_Set_Transparency();		-- Set the transparency
		Perl_Player_Update_Once();		-- Set all the correct information
		return;
	end

	-- Check if a previous exists, if not, enable by default.
	if (type(Perl_Player_Config[UnitName("player")]) == "table") then
		Perl_Player_GetVars();
	else
		Perl_Player_UpdateVars();
	end

	-- Major config options.
	Perl_Player_Initialize_Frame_Color();		-- Give the borders (and background if applicable) that "Perl" look
	Perl_Player_Set_Localized_ClassIcons();		-- Set the correct class icon
	Perl_Player_Frame:Show();			-- Show the player frame

	-- Unregister and Hide the Blizzard frames
	Perl_clearBlizzardFrameDisable(PlayerFrame);

	-- MyAddOns Support
	Perl_Player_myAddOns_Support();

	-- IFrameManager Support
	if (IFrameManager) then
		Perl_Player_IFrameManager();
	end

	Initialized = 1;
end

function Perl_Player_IFrameManager()
	local iface = IFrameManager:Interface();
	function iface:getName(frame)
		return "Perl Player";
	end
	function iface:getBorder(frame)
		local bottom, left, right, top;
		if (xpbarstate == 3) then
			bottom = 38;
		else
			bottom = 50;
		end
		if (showraidgroup == 1) then
			top = 20;
		else
			top = 0;
		end
		if (compactmode == 0) then
			right = 70;
		else
			if (compactpercent == 0) then
				if (shortbars == 0) then
					right = 0;
				else
					right = -35;
				end
			else
				if (shortbars == 0) then
					right = 35;
				else
					right = 0;
				end
			end
		end
		if (showportrait == 0) then
			left = 0;
		else
			left = 55;
		end
		return top, right, bottom, left;
	end
	IFrameManager:Register(this, iface);
end

function Perl_Player_Initialize_Frame_Color()
	Perl_Player_StatsFrame:SetBackdropColor(0, 0, 0, 1);
	Perl_Player_StatsFrame:SetBackdropBorderColor(0.5, 0.5, 0.5, 1);
	Perl_Player_LevelFrame:SetBackdropColor(0, 0, 0, 1);
	Perl_Player_LevelFrame:SetBackdropBorderColor(0.5, 0.5, 0.5, 1);
	Perl_Player_NameFrame:SetBackdropColor(0, 0, 0, 1);
	Perl_Player_NameFrame:SetBackdropBorderColor(0.5, 0.5, 0.5, 1);
	Perl_Player_RaidGroupNumberFrame:SetBackdropColor(0, 0, 0, 1);
	Perl_Player_RaidGroupNumberFrame:SetBackdropBorderColor(0.5, 0.5, 0.5, 1);
	Perl_Player_PortraitFrame:SetBackdropColor(0, 0, 0, 1);
	Perl_Player_PortraitFrame:SetBackdropBorderColor(0.5, 0.5, 0.5, 1);

	Perl_Player_HealthBarText:SetTextColor(1, 1, 1, 1);
	--Perl_Player_ManaBarText:SetTextColor(1, 1, 1, 1);
	Perl_Player_RaidGroupNumberBarText:SetTextColor(1, 1, 1);
end


----------------------
-- Update Functions --
----------------------
function Perl_Player_Update_Once()
	local localizedclass = UnitClass("player");

	Perl_Player_NameBarText:SetText(UnitName("player"));			-- Set the player's name
	Perl_Player_LevelFrame_LevelBarText:SetText(UnitLevel("player"));	-- Set the player's level
	Perl_Player_ClassTexture:SetTexCoord(Perl_Player_ClassPosRight[localizedclass], Perl_Player_ClassPosLeft[localizedclass], Perl_Player_ClassPosTop[localizedclass], Perl_Player_ClassPosBottom[localizedclass]);	-- Set the player's class icon
	Perl_Player_Update_Portrait();						-- Set the player's portrait
	Perl_Player_Update_PvP_Status();					-- Is the character PvP flagged?
	Perl_Player_Set_Text_Positions();					-- Align the text according to compact and healer mode
	Perl_Player_Update_Health();						-- Set the player's health on load or toggle
	Perl_Player_Update_Mana();						-- Set the player's mana/energy on load or toggle
	Perl_Player_Update_Mana_Bar();						-- Set the type of mana used
	Perl_Player_XPBar_Display(xpbarstate);					-- Set the xp bar mode and update the experience if needed
	Perl_Player_Update_Raid_Group_Number();					-- Are we in a raid at login?
	Perl_Player_Portrait_Combat_Text();					-- Are we showing combat text?
	Perl_Player_Update_Leader();						-- Are we the party leader?
	Perl_Player_Update_Loot_Method();					-- Are we the master looter?
	Perl_Player_Update_Combat_Status();					-- Are we already fighting or resting?
	Perl_Player_Set_CompactMode();						-- Are we using compact mode?
	Perl_Player_PvP_Rank_Icon();						-- Are we displaying our rank icon?
	Perl_Player_Check_Hidden();						-- Are we in a raid and suppossed to be hidden?
end

function Perl_Player_Update_Health()
	playerhealth = UnitHealth("player");
	playerhealthmax = UnitHealthMax("player");
	playerhealthpercent = floor(playerhealth/playerhealthmax*100+0.5);

	if (UnitIsDead("player") or UnitIsGhost("player")) then			-- This prevents negative health
		playerhealth = 0;
		playerhealthpercent = 0;
	end

	if (PCUF_FADEBARS == 1) then
		if (playerhealth < Perl_Player_HealthBar:GetValue()) then
			Perl_Player_HealthBarFadeBar:SetMinMaxValues(0, playerhealthmax);
			Perl_Player_HealthBarFadeBar:SetValue(Perl_Player_HealthBar:GetValue());
			Perl_Player_HealthBarFadeBar:Show();
			Perl_Player_HealthBar_Fade_Color = 1;
			Perl_Player_HealthBar_Fade_Time_Elapsed = 0;
			Perl_Player_HealthBar_Fade_OnUpdate_Frame:Show();
		end
	end

	Perl_Player_HealthBar:SetMinMaxValues(0, playerhealthmax);
	if (PCUF_INVERTBARVALUES == 1) then
		Perl_Player_HealthBar:SetValue(playerhealthmax - playerhealth);
	else
		Perl_Player_HealthBar:SetValue(playerhealth);
	end

	if (PCUF_COLORHEALTH == 1) then
--		if ((playerhealthpercent <= 100) and (playerhealthpercent > 75)) then
--			Perl_Player_HealthBar:SetStatusBarColor(0, 0.8, 0);
--			Perl_Player_HealthBarBG:SetStatusBarColor(0, 0.8, 0, 0.25);
--		elseif ((playerhealthpercent <= 75) and (playerhealthpercent > 50)) then
--			Perl_Player_HealthBar:SetStatusBarColor(1, 1, 0);
--			Perl_Player_HealthBarBG:SetStatusBarColor(1, 1, 0, 0.25);
--		elseif ((playerhealthpercent <= 50) and (playerhealthpercent > 25)) then
--			Perl_Player_HealthBar:SetStatusBarColor(1, 0.5, 0);
--			Perl_Player_HealthBarBG:SetStatusBarColor(1, 0.5, 0, 0.25);
--		else
--			Perl_Player_HealthBar:SetStatusBarColor(1, 0, 0);
--			Perl_Player_HealthBarBG:SetStatusBarColor(1, 0, 0, 0.25);
--		end

		local rawpercent = playerhealth / playerhealthmax;
		local red, green;

		if(rawpercent > 0.5) then
			red = (1.0 - rawpercent) * 2;
			green = 1.0;
		else
			red = 1.0;
			green = rawpercent * 2;
		end

		Perl_Player_HealthBar:SetStatusBarColor(red, green, 0, 1);
		Perl_Player_HealthBarBG:SetStatusBarColor(red, green, 0, 0.25);
	else
		Perl_Player_HealthBar:SetStatusBarColor(0, 0.8, 0);
		Perl_Player_HealthBarBG:SetStatusBarColor(0, 0.8, 0, 0.25);
	end

	if (compactmode == 0) then
		if (healermode == 1) then									-- Compact mode OFF and Healer mode ON
			Perl_Player_HealthBarText:SetText("-"..playerhealthmax - playerhealth);
			if (showbarvalues == 0) then
				if (mouseoverhealthflag == 0) then
					Perl_Player_HealthBarTextPercent:SetText();					-- Add text here if you dont't want the bar values hidden in healer mode.  Set the value in the function Perl_Player_HealthHide to the same as this.
				else
					Perl_Player_HealthBarTextPercent:SetText(playerhealth.."/"..playerhealthmax);
				end
			else
				Perl_Player_HealthBarTextPercent:SetText(playerhealth.."/"..playerhealthmax);
			end
		else												-- Compact mode OFF and Healer mode OFF
			Perl_Player_HealthBarText:SetText(playerhealth.."/"..playerhealthmax);
			Perl_Player_HealthBarTextPercent:SetText(playerhealthpercent .. "%");
		end
		Perl_Player_HealthBarTextCompactPercent:SetText();						-- Hide the compact mode percent text in full mode
	else
		if (healermode == 1) then									-- Compact mode ON and Healer mode ON
			Perl_Player_HealthBarText:SetText("-"..playerhealthmax - playerhealth);
			if (showbarvalues == 0) then
				if (mouseoverhealthflag == 0) then
					Perl_Player_HealthBarTextPercent:SetText();					-- Add text here if you dont't want the bar values hidden in healer mode.  Set the value in the function Perl_Player_HealthHide to the same as this.
				else
					Perl_Player_HealthBarTextPercent:SetText(playerhealth.."/"..playerhealthmax);
				end
			else
				Perl_Player_HealthBarTextPercent:SetText(playerhealth.."/"..playerhealthmax);
			end
		else												-- Compact mode ON and Healer mode OFF
			Perl_Player_HealthBarText:SetText();
			Perl_Player_HealthBarTextPercent:SetText(playerhealth.."/"..playerhealthmax);
		end

		if (compactpercent == 1) then
			Perl_Player_HealthBarTextCompactPercent:SetText(playerhealthpercent.."%");
		else
			Perl_Player_HealthBarTextCompactPercent:SetText();
		end
	end
end

function Perl_Player_Update_Mana()
	playermana = UnitMana("player");
	playermanamax = UnitManaMax("player");
	playermanapercent = floor(playermana/playermanamax*100+0.5);

	if (UnitIsDead("player") or UnitIsGhost("player")) then			-- This prevents negative mana
		playermana = 0;
		playermanapercent = 0;
	end

	if (PCUF_FADEBARS == 1) then
		if (playermana < Perl_Player_ManaBar:GetValue()) then
			Perl_Player_ManaBarFadeBar:SetMinMaxValues(0, playermanamax);
			Perl_Player_ManaBarFadeBar:SetValue(Perl_Player_ManaBar:GetValue());
			Perl_Player_ManaBarFadeBar:Show();
			Perl_Player_ManaBar_Fade_Color = 1;
			Perl_Player_ManaBar_Fade_Time_Elapsed = 0;
			Perl_Player_ManaBar_Fade_OnUpdate_Frame:Show();
		end
	end

	Perl_Player_ManaBar:SetMinMaxValues(0, playermanamax);
	if (PCUF_INVERTBARVALUES == 1) then
		Perl_Player_ManaBar:SetValue(playermanamax - playermana);
	else
		Perl_Player_ManaBar:SetValue(playermana);
	end

	if (compactmode == 0) then
		if (healermode == 1) then
			Perl_Player_ManaBarText:SetTextColor(0.5, 0.5, 0.5, 1);
			if (showmanadeficit == 1) then
				Perl_Player_ManaBarText:SetText("-"..playermanamax - playermana);
			else
				Perl_Player_ManaBarText:SetText();
			end
			if (showbarvalues == 0) then
				if (mouseovermanaflag == 0) then
					Perl_Player_ManaBarTextPercent:SetText();
				else
					if (UnitPowerType("player") == 1) then
						Perl_Player_ManaBarTextPercent:SetText(playermana);
					else
						Perl_Player_ManaBarTextPercent:SetText(playermana.."/"..playermanamax);
					end
				end
			else
				if (UnitPowerType("player") == 1) then
					Perl_Player_ManaBarTextPercent:SetText(playermana);
				else
					Perl_Player_ManaBarTextPercent:SetText(playermana.."/"..playermanamax);
				end
			end
		else
			Perl_Player_ManaBarText:SetTextColor(1, 1, 1, 1);
			Perl_Player_ManaBarText:SetText(playermana.."/"..playermanamax);
			if (UnitPowerType("player") == 1) then
				Perl_Player_ManaBarTextPercent:SetText(playermana);
			else
				Perl_Player_ManaBarTextPercent:SetText(playermanapercent.."%");
			end
		end
		Perl_Player_ManaBarTextCompactPercent:SetText();		-- Hide the compact mode percent text in full mode
	else
		if (healermode == 1) then
			Perl_Player_ManaBarText:SetTextColor(0.5, 0.5, 0.5, 1);
			if (showmanadeficit == 1) then
				Perl_Player_ManaBarText:SetText("-"..playermanamax - playermana);
			else
				Perl_Player_ManaBarText:SetText();
			end
			if (showbarvalues == 0) then
				if (mouseovermanaflag == 0) then
					Perl_Player_ManaBarTextPercent:SetText();
				else
					if (UnitPowerType("player") == 1) then
						Perl_Player_ManaBarTextPercent:SetText(playermana);
					else
						Perl_Player_ManaBarTextPercent:SetText(playermana.."/"..playermanamax);
					end
				end
			else
				if (UnitPowerType("player") == 1) then
					Perl_Player_ManaBarTextPercent:SetText(playermana);
				else
					Perl_Player_ManaBarTextPercent:SetText(playermana.."/"..playermanamax);
				end
			end
		else
			Perl_Player_ManaBarText:SetTextColor(1, 1, 1, 1);
			Perl_Player_ManaBarText:SetText();
			if (UnitPowerType("player") == 1) then
				Perl_Player_ManaBarTextPercent:SetText(playermana);
			else
				Perl_Player_ManaBarTextPercent:SetText(playermana.."/"..playermanamax);
			end
		end

		if (compactpercent == 1) then
			Perl_Player_ManaBarTextCompactPercent:SetText(playermanapercent.."%");
		else
			Perl_Player_ManaBarTextCompactPercent:SetText();
		end
	end

	if (showdruidbar == 1) then
		if (DruidBarKey and (UnitClass("player") == PERL_LOCALIZED_DRUID)) then		-- Is Druid Bar installed and are we a Druid?
			if (UnitPowerType("player") > 0) then					-- Are we in a manaless form?
				Perl_Player_DruidBar_OnUpdate_Frame:Show();			-- Do all our work here (OnUpdate since it's very random if it works with just the UNIT_MANA event)
			else
				-- Hide it all (bars and text)
				Perl_Player_DruidBar_OnUpdate_Frame:Hide();
				Perl_Player_DruidBarText:SetText();
				Perl_Player_DruidBarTextPercent:SetText();
				Perl_Player_DruidBarTextCompactPercent:SetText();
				Perl_Player_DruidBar:Hide();
				Perl_Player_DruidBarBG:Hide();
				Perl_Player_DruidBar_CastClickOverlay:Hide();
				Perl_Player_ManaBar:SetPoint("TOP", "Perl_Player_HealthBar", "BOTTOM", 0, -2);
				if (xpbarstate == 3) then
					Perl_Player_StatsFrame:SetHeight(42);			-- Experience Bar is hidden
					Perl_Player_StatsFrame_CastClickOverlay:SetHeight(42);
				else
					Perl_Player_StatsFrame:SetHeight(54);			-- Experience Bar is shown
					Perl_Player_StatsFrame_CastClickOverlay:SetHeight(54);
				end
			end
		else
			-- Hide it all (bars and text)
			Perl_Player_DruidBar_OnUpdate_Frame:Hide();
			Perl_Player_DruidBarText:SetText();
			Perl_Player_DruidBarTextPercent:SetText();
			Perl_Player_DruidBarTextCompactPercent:SetText();
			Perl_Player_DruidBar:Hide();
			Perl_Player_DruidBarBG:Hide();
			Perl_Player_DruidBar_CastClickOverlay:Hide();
			Perl_Player_ManaBar:SetPoint("TOP", "Perl_Player_HealthBar", "BOTTOM", 0, -2);
			if (xpbarstate == 3) then
				Perl_Player_StatsFrame:SetHeight(42);				-- Experience Bar is hidden
				Perl_Player_StatsFrame_CastClickOverlay:SetHeight(42);
			else
				Perl_Player_StatsFrame:SetHeight(54);				-- Experience Bar is shown
				Perl_Player_StatsFrame_CastClickOverlay:SetHeight(54);
			end
		end
	else
		-- Hide it all (bars and text)
		Perl_Player_DruidBar_OnUpdate_Frame:Hide();
		Perl_Player_DruidBarText:SetText();
		Perl_Player_DruidBarTextPercent:SetText();
		Perl_Player_DruidBarTextCompactPercent:SetText();
		Perl_Player_DruidBar:Hide();
		Perl_Player_DruidBarBG:Hide();
		Perl_Player_DruidBar_CastClickOverlay:Hide();
		Perl_Player_ManaBar:SetPoint("TOP", "Perl_Player_HealthBar", "BOTTOM", 0, -2);
		if (xpbarstate == 3) then
			Perl_Player_StatsFrame:SetHeight(42);					-- Experience Bar is hidden
			Perl_Player_StatsFrame_CastClickOverlay:SetHeight(42);
		else
			Perl_Player_StatsFrame:SetHeight(54);					-- Experience Bar is shown
			Perl_Player_StatsFrame_CastClickOverlay:SetHeight(54);
		end
	end

	if (fivesecsupport == 1) then
		if (REGENERATING_MANA ~= nil) then						-- Is FiveSec installed?
			if (UnitPowerType("player") == 0) then					-- If we aren't in mana mode, bail out
				if (REGENERATING_MANA == false) then				-- If we aren't in regen mode, color light blue
					Perl_Player_ManaBar:SetStatusBarColor(0, 0.7, 1, 1);
					Perl_Player_ManaBarBG:SetStatusBarColor(0, 0.7, 1, 0.25);
				else								-- Then we must be in regen mode, color bar normally
					Perl_Player_ManaBar:SetStatusBarColor(0, 0, 1, 1);
					Perl_Player_ManaBarBG:SetStatusBarColor(0, 0, 1, 0.25);
				end
			end
		end
	end
end

function Perl_Player_Update_DruidBar(arg1)
	Perl_Player_DruidBar_Time_Elapsed = Perl_Player_DruidBar_Time_Elapsed + arg1;
	if (Perl_Player_DruidBar_Time_Elapsed > Perl_Player_DruidBar_Time_Update_Rate) then
		Perl_Player_DruidBar_Time_Elapsed = 0;
		-- Show the bars and set the text and reposition the original mana bar below the druid bar
		playerdruidbarmana = floor(DruidBarKey.keepthemana);
		playerdruidbarmanamax = DruidBarKey.maxmana;
		playerdruidbarmanapercent = floor(playerdruidbarmana/playerdruidbarmanamax*100+0.5);

		if (playerdruidbarmanapercent == 100) then			-- This is to ensure the value isn't 1 or 2 mana under max when 100%
			playerdruidbarmana = playerdruidbarmanamax;
		end

--		if (PCUF_FADEBARS == 1) then
--			if (playerdruidbarmana < Perl_Player_DruidBar:GetValue()) then
--				Perl_Player_DruidBarFadeBar:SetMinMaxValues(0, playerdruidbarmanamax);
--				Perl_Player_DruidBarFadeBar:SetValue(Perl_Player_DruidBarFadeBar:GetValue());
--				Perl_Player_DruidBarFadeBar:Show();
--				Perl_Player_DruidBar_Fade_Color = 1;
--				Perl_Player_DruidBar_Fade_Time_Elapsed = 0;
--				Perl_Player_DruidBar_Fade_OnUpdate_Frame:Show();
--			end
--		end

		Perl_Player_DruidBar:SetMinMaxValues(0, playerdruidbarmanamax);
		if (PCUF_INVERTBARVALUES == 1) then
			Perl_Player_DruidBar:SetValue(playerdruidbarmanamax - playerdruidbarmana);
		else
			Perl_Player_DruidBar:SetValue(playerdruidbarmana);
		end

		-- Show the bar and adjust the stats frame
		Perl_Player_DruidBar:Show();
		Perl_Player_DruidBarBG:Show();
		Perl_Player_DruidBar_CastClickOverlay:Show();
		Perl_Player_ManaBar:SetPoint("TOP", "Perl_Player_DruidBar", "BOTTOM", 0, -2);
		if (xpbarstate == 3) then
			Perl_Player_StatsFrame:SetHeight(54);			-- Experience Bar is hidden
			Perl_Player_StatsFrame_CastClickOverlay:SetHeight(54);
		else
			Perl_Player_StatsFrame:SetHeight(66);			-- Experience Bar is shown
			Perl_Player_StatsFrame_CastClickOverlay:SetHeight(66);
		end

		-- Display the needed text
		if (compactmode == 0) then
			if (healermode == 1) then
				Perl_Player_DruidBarText:SetTextColor(0.5, 0.5, 0.5, 1);
				if (showmanadeficit == 1) then
					Perl_Player_DruidBarText:SetText("-"..playerdruidbarmanamax - playerdruidbarmana);
				else
					Perl_Player_DruidBarText:SetText();
				end
				if (showbarvalues == 0) then
					if (mouseovermanaflag == 0) then
						Perl_Player_DruidBarTextPercent:SetText();
					else
						Perl_Player_DruidBarTextPercent:SetText(playerdruidbarmana.."/"..playerdruidbarmanamax);
					end
				else
					Perl_Player_DruidBarTextPercent:SetText(playerdruidbarmana.."/"..playerdruidbarmanamax);
				end
			else
				Perl_Player_DruidBarText:SetTextColor(1, 1, 1, 1);
				Perl_Player_DruidBarText:SetText(playerdruidbarmana.."/"..playerdruidbarmanamax);
				Perl_Player_DruidBarTextPercent:SetText(playerdruidbarmanapercent.."%");
			end
			Perl_Player_DruidBarTextCompactPercent:SetText();	-- Hide the compact mode percent text in full mode
		else
			if (healermode == 1) then
				Perl_Player_DruidBarText:SetTextColor(0.5, 0.5, 0.5, 1);
				if (showmanadeficit == 1) then
					Perl_Player_DruidBarText:SetText("-"..playermanamax - playermana);
				else
					Perl_Player_DruidBarText:SetText();
				end
				if (showbarvalues == 0) then
					if (mouseovermanaflag == 0) then
						Perl_Player_DruidBarTextPercent:SetText();
					else
						Perl_Player_DruidBarTextPercent:SetText(playerdruidbarmana.."/"..playerdruidbarmanamax);
					end
				else
					Perl_Player_DruidBarTextPercent:SetText(playerdruidbarmana.."/"..playerdruidbarmanamax);
				end
			else
				Perl_Player_DruidBarText:SetTextColor(1, 1, 1, 1);
				Perl_Player_DruidBarText:SetText();
				Perl_Player_DruidBarTextPercent:SetText(playerdruidbarmana.."/"..playerdruidbarmanamax);
			end

			if (compactpercent == 1) then
				Perl_Player_DruidBarTextCompactPercent:SetText(playerdruidbarmanapercent.."%");
			else
				Perl_Player_DruidBarTextCompactPercent:SetText();
			end
		end
	end
end

function Perl_Player_Update_Mana_Bar()
	playerpower = UnitPowerType("player");

	-- Set mana bar color
	if (playerpower == 0) then		-- mana
		Perl_Player_ManaBar:SetStatusBarColor(0, 0, 1, 1);
		Perl_Player_ManaBarBG:SetStatusBarColor(0, 0, 1, 0.25);
	elseif (playerpower == 1) then		-- rage
		Perl_Player_ManaBar:SetStatusBarColor(1, 0, 0, 1);
		Perl_Player_ManaBarBG:SetStatusBarColor(1, 0, 0, 0.25);
	elseif (playerpower == 3) then		-- energy
		Perl_Player_ManaBar:SetStatusBarColor(1, 1, 0, 1);
		Perl_Player_ManaBarBG:SetStatusBarColor(1, 1, 0, 0.25);
	end
end

function Perl_Player_Update_Experience()
	if (UnitLevel("player") ~= 70) then
		-- XP Bar stuff
		local playerxp = UnitXP("player");
		local playerxpmax = UnitXPMax("player");
		local playerxprest = GetXPExhaustion();

		Perl_Player_XPBar:SetMinMaxValues(0, playerxpmax);
		Perl_Player_XPRestBar:SetMinMaxValues(0, playerxpmax);
		Perl_Player_XPBar:SetValue(playerxp);

		-- Set xp text
		local xptext = playerxp.."/"..playerxpmax;
		local xptextpercent = floor(playerxp/playerxpmax*100+0.5);

		if (playerxprest) then
			xptext = xptext.."(+"..(playerxprest)..")";
			Perl_Player_XPBar:SetStatusBarColor(0, 0.6, 0.6, 1);
			Perl_Player_XPRestBar:SetStatusBarColor(0, 0.6, 0.6, 0.5);
			Perl_Player_XPBarBG:SetStatusBarColor(0, 0.6, 0.6, 0.25);
			Perl_Player_XPRestBar:SetValue(playerxp + playerxprest);
			Perl_Player_XPBarText:SetText(xptextpercent.."%".." (+"..floor(playerxprest/playerxpmax*100+0.5).."%)");
		else
			Perl_Player_XPBar:SetStatusBarColor(0, 0.6, 0.6, 1);
			Perl_Player_XPRestBar:SetStatusBarColor(0, 0.6, 0.6, 0.5);
			Perl_Player_XPBarBG:SetStatusBarColor(0, 0.6, 0.6, 0.25);
			Perl_Player_XPRestBar:SetValue(playerxp);
			Perl_Player_XPBarText:SetText(xptextpercent.."%");
		end
	else
		Perl_Player_XPBar:SetMinMaxValues(0, 1);
		Perl_Player_XPRestBar:SetMinMaxValues(0, 1);
		Perl_Player_XPBar:SetValue(1);
		Perl_Player_XPRestBar:SetValue(1);

		Perl_Player_XPBar:SetStatusBarColor(0, 0.6, 0.6, 1);
		Perl_Player_XPRestBar:SetStatusBarColor(0, 0.6, 0.6, 0.5);
		Perl_Player_XPBarBG:SetStatusBarColor(0, 0.6, 0.6, 0.25);

		Perl_Player_XPBarText:SetText(PERL_LOCALIZED_PLAYER_LEVEL_SEVENTY);
	end
	
end

function Perl_Player_Update_Reputation()
	local name, reaction, min, max, value = GetWatchedFactionInfo();
	if (name) then
		value = value - min;
		max = max - min;
		min = 0;
		
		Perl_Player_XPBar:SetMinMaxValues(min, max);
		Perl_Player_XPRestBar:SetMinMaxValues(min, max);
		Perl_Player_XPBar:SetValue(value);
		Perl_Player_XPRestBar:SetValue(value);

		local color = FACTION_BAR_COLORS[reaction];
		Perl_Player_XPBar:SetStatusBarColor(color.r, color.g, color.b, 1);
		Perl_Player_XPRestBar:SetStatusBarColor(color.r, color.g, color.b, 0.5);
		Perl_Player_XPBarBG:SetStatusBarColor(color.r, color.g, color.b, 0.25);

		Perl_Player_XPBarText:SetText(value.."/"..max);
	else
		Perl_Player_XPBar:SetMinMaxValues(0, 1);
		Perl_Player_XPRestBar:SetMinMaxValues(0, 1);
		Perl_Player_XPBar:SetValue(1);
		Perl_Player_XPRestBar:SetValue(1);

		Perl_Player_XPBar:SetStatusBarColor(0.9, 0.7, 0, 1);
		Perl_Player_XPRestBar:SetStatusBarColor(0.9, 0.7, 0, 0.5);
		Perl_Player_XPBarBG:SetStatusBarColor(0.9, 0.7, 0, 0.25);

		Perl_Player_XPBarText:SetText(PERL_LOCALIZED_PLAYER_SELECT_REPUTATION);
	end
end

function Perl_Player_Update_Combat_Status(event)
	-- Rest/Combat Status Icon
	if (event == "PLAYER_REGEN_DISABLED") then
		InCombat = 1;
		Perl_Player_ActivityStatus:SetTexCoord(0.5, 1.0, 0.0, 0.5);
		Perl_Player_ActivityStatus:Show();
	elseif (event == "PLAYER_REGEN_ENABLED") then
		InCombat = 0;
		Perl_Player_ActivityStatus:Hide();
	elseif (IsResting()) then
		if (InCombat == 1) then
			return;
		else
			Perl_Player_ActivityStatus:SetTexCoord(0, 0.5, 0.0, 0.5);
			Perl_Player_ActivityStatus:Show();
		end
	else
		if (InCombat == 1) then
			return;
		else
			Perl_Player_ActivityStatus:Hide();
		end
	end
end

function Perl_Player_Update_Raid_Group_Number()		-- taken from 1.8
	if (showraidgroup == 1) then
		Perl_Player_RaidGroupNumberFrame:Hide();
		local name, rank, subgroup;
		if (GetNumRaidMembers() == 0) then
			Perl_Player_RaidGroupNumberFrame:Hide();
			Perl_Player_MasterIcon:Hide();				-- This was added to correctly hide the master loot icon after leaving a party/raid
			return;
		end
		local numRaidMembers = GetNumRaidMembers();
		for i=1,40 do
			if (i <= numRaidMembers) then
				name, rank, subgroup = GetRaidRosterInfo(i);
				-- Set the player's group number indicator
				if (name == UnitName("player")) then
					Perl_Player_RaidGroupNumberBarText:SetText(PERL_LOCALIZED_PLAYER_GROUP..subgroup);
					Perl_Player_RaidGroupNumberFrame:Show();
					return;
				end
			end
		end
	else
		Perl_Player_RaidGroupNumberFrame:Hide();
	end
end

function Perl_Player_Update_Leader()
	if (IsPartyLeader()) then
		Perl_Player_LeaderIcon:Show();
	else
		Perl_Player_LeaderIcon:Hide();
	end
end

function Perl_Player_Update_Loot_Method()
	local lootMaster;
	_, lootMaster = GetLootMethod();
	if (lootMaster == 0) then
		Perl_Player_MasterIcon:Show();
	else
		Perl_Player_MasterIcon:Hide();
	end
end

function Perl_Player_Update_PvP_Status()
	if (UnitIsPVP("player")) then
		if (UnitFactionGroup("player")) then
			Perl_Player_NameBarText:SetTextColor(0, 1, 0);		-- Green if PvP flagged
			if (showpvpicon == 1) then
				Perl_Player_PVPStatus:SetTexture("Interface\\TargetingFrame\\UI-PVP-"..UnitFactionGroup("player"));
				Perl_Player_PVPStatus:Show();
			else
				Perl_Player_PVPStatus:Hide();
			end
		else
			Perl_Player_NameBarText:SetTextColor(1, 0, 0);		-- Red if charmed
			Perl_Player_PVPStatus:Hide();
		end
	else
		Perl_Player_NameBarText:SetTextColor(0.5, 0.5, 1);		-- Blue if not PvP flagged
		Perl_Player_PVPStatus:Hide();
	end

		if (classcolorednames == 1) then				-- Color by class
		if (UnitClass("player") == PERL_LOCALIZED_WARRIOR) then
			Perl_Player_NameBarText:SetTextColor(0.78, 0.61, 0.43);
		elseif (UnitClass("player") == PERL_LOCALIZED_MAGE) then
			Perl_Player_NameBarText:SetTextColor(0.41, 0.8, 0.94);
		elseif (UnitClass("player") == PERL_LOCALIZED_ROGUE) then
			Perl_Player_NameBarText:SetTextColor(1, 0.96, 0.41);
		elseif (UnitClass("player") == PERL_LOCALIZED_DRUID) then
			Perl_Player_NameBarText:SetTextColor(1, 0.49, 0.04);
		elseif (UnitClass("player") == PERL_LOCALIZED_HUNTER) then
			Perl_Player_NameBarText:SetTextColor(0.67, 0.83, 0.45);
		elseif (UnitClass("player") == PERL_LOCALIZED_SHAMAN) then
			Perl_Player_NameBarText:SetTextColor(0.96, 0.55, 0.73);
		elseif (UnitClass("player") == PERL_LOCALIZED_PRIEST) then
			Perl_Player_NameBarText:SetTextColor(1, 1, 1);
		elseif (UnitClass("player") == PERL_LOCALIZED_WARLOCK) then
			Perl_Player_NameBarText:SetTextColor(0.58, 0.51, 0.79);
		elseif (UnitClass("player") == PERL_LOCALIZED_PALADIN) then
			Perl_Player_NameBarText:SetTextColor(0.96, 0.55, 0.73);
		end
	end
end

function Perl_Player_Set_CompactMode()
	if (compactmode == 0) then
		Perl_Player_XPBar:SetWidth(220);
		Perl_Player_XPRestBar:SetWidth(220);
		Perl_Player_XPBarBG:SetWidth(220);
		Perl_Player_XPBar_CastClickOverlay:SetWidth(220);
		Perl_Player_StatsFrame:SetWidth(240);
		Perl_Player_StatsFrame_CastClickOverlay:SetWidth(240);
	else
		if (compactpercent == 0) then
			if (shortbars == 0) then
				Perl_Player_XPBar:SetWidth(150);
				Perl_Player_XPRestBar:SetWidth(150);
				Perl_Player_XPBarBG:SetWidth(150);
				Perl_Player_XPBar_CastClickOverlay:SetWidth(150);
				Perl_Player_StatsFrame:SetWidth(170);
				Perl_Player_StatsFrame_CastClickOverlay:SetWidth(170);
			else
				Perl_Player_XPBar:SetWidth(115);
				Perl_Player_XPRestBar:SetWidth(115);
				Perl_Player_XPBarBG:SetWidth(115);
				Perl_Player_XPBar_CastClickOverlay:SetWidth(115);
				Perl_Player_StatsFrame:SetWidth(135);
				Perl_Player_StatsFrame_CastClickOverlay:SetWidth(135);
			end
		else
			if (shortbars == 0) then
				Perl_Player_XPBar:SetWidth(185);
				Perl_Player_XPRestBar:SetWidth(185);
				Perl_Player_XPBarBG:SetWidth(185);
				Perl_Player_XPBar_CastClickOverlay:SetWidth(185);
				Perl_Player_StatsFrame:SetWidth(205);
				Perl_Player_StatsFrame_CastClickOverlay:SetWidth(205);
			else
				Perl_Player_XPBar:SetWidth(150);
				Perl_Player_XPRestBar:SetWidth(150);
				Perl_Player_XPBarBG:SetWidth(150);
				Perl_Player_XPBar_CastClickOverlay:SetWidth(150);
				Perl_Player_StatsFrame:SetWidth(170);
				Perl_Player_StatsFrame_CastClickOverlay:SetWidth(170);
			end
		end
	end

	if (compactmode == 1 and shortbars == 1) then
		Perl_Player_NameFrame:SetWidth(165);
		Perl_Player_Name:SetWidth(165);
		Perl_Player_Name_CastClickOverlay:SetWidth(165);

		Perl_Player_HealthBar:SetWidth(115);
		Perl_Player_HealthBarFadeBar:SetWidth(115);
		Perl_Player_HealthBarBG:SetWidth(115);
		Perl_Player_HealthBar_CastClickOverlay:SetWidth(115);
		Perl_Player_ManaBar:SetWidth(115);
		Perl_Player_ManaBarFadeBar:SetWidth(115);
		Perl_Player_ManaBarBG:SetWidth(115);
		Perl_Player_ManaBar_CastClickOverlay:SetWidth(115);
		Perl_Player_DruidBar:SetWidth(115);
		--Perl_Player_DruidBarFadeBar:SetWidth(115);
		Perl_Player_DruidBarBG:SetWidth(115);
		Perl_Player_DruidBar_CastClickOverlay:SetWidth(115);
	else
		Perl_Player_NameFrame:SetWidth(200);
		Perl_Player_Name:SetWidth(200);
		Perl_Player_Name_CastClickOverlay:SetWidth(200);

		Perl_Player_HealthBar:SetWidth(150);
		Perl_Player_HealthBarFadeBar:SetWidth(150);
		Perl_Player_HealthBarBG:SetWidth(150);
		Perl_Player_HealthBar_CastClickOverlay:SetWidth(150);
		Perl_Player_ManaBar:SetWidth(150);
		Perl_Player_ManaBarFadeBar:SetWidth(150);
		Perl_Player_ManaBarBG:SetWidth(150);
		Perl_Player_ManaBar_CastClickOverlay:SetWidth(150);
		Perl_Player_DruidBar:SetWidth(150);
		--Perl_Player_DruidBarFadeBar:SetWidth(150);
		Perl_Player_DruidBarBG:SetWidth(150);
		Perl_Player_DruidBar_CastClickOverlay:SetWidth(150);
	end

	if (hideclasslevelframe == 1) then
		Perl_Player_LevelFrame:Hide();
		Perl_Player_StatsFrame:SetPoint("TOPLEFT", Perl_Player_NameFrame, "BOTTOMLEFT", 0, 5);
		Perl_Player_StatsFrame:SetWidth(Perl_Player_StatsFrame:GetWidth() + 30);
		Perl_Player_StatsFrame_CastClickOverlay:SetWidth(Perl_Player_StatsFrame_CastClickOverlay:GetWidth() + 30);
		
		Perl_Player_HealthBar:SetWidth(Perl_Player_HealthBar:GetWidth() + 30);
		Perl_Player_HealthBarFadeBar:SetWidth(Perl_Player_HealthBarFadeBar:GetWidth() + 30);
		Perl_Player_HealthBarBG:SetWidth(Perl_Player_HealthBarBG:GetWidth() + 30);
		Perl_Player_HealthBar_CastClickOverlay:SetWidth(Perl_Player_HealthBar_CastClickOverlay:GetWidth() + 30);
		
		Perl_Player_ManaBar:SetWidth(Perl_Player_ManaBar:GetWidth() + 30);
		Perl_Player_ManaBarFadeBar:SetWidth(Perl_Player_ManaBarFadeBar:GetWidth() + 30);
		Perl_Player_ManaBarBG:SetWidth(Perl_Player_ManaBarBG:GetWidth() + 30);
		Perl_Player_ManaBar_CastClickOverlay:SetWidth(Perl_Player_ManaBar_CastClickOverlay:GetWidth() + 30);
		
		Perl_Player_DruidBar:SetWidth(Perl_Player_DruidBar:GetWidth() + 30);
		--Perl_Player_DruidBarFadeBar:SetWidth(Perl_Player_DruidBarFadeBar:GetWidth() + 30);
		Perl_Player_DruidBarBG:SetWidth(Perl_Player_DruidBarBG:GetWidth() + 30);
		Perl_Player_DruidBar_CastClickOverlay:SetWidth(Perl_Player_DruidBar_CastClickOverlay:GetWidth() + 30);

		Perl_Player_XPBar:SetWidth(Perl_Player_XPBar:GetWidth() + 30);
		Perl_Player_XPRestBar:SetWidth(Perl_Player_XPRestBar:GetWidth() + 30);
		Perl_Player_XPBarBG:SetWidth(Perl_Player_XPBarBG:GetWidth() + 30);
		Perl_Player_XPBar_CastClickOverlay:SetWidth(Perl_Player_XPBar_CastClickOverlay:GetWidth() + 30);
	else
		Perl_Player_LevelFrame:Show();
		Perl_Player_StatsFrame:SetPoint("TOPLEFT", Perl_Player_NameFrame, "BOTTOMLEFT", 30, 5);
	end

	Perl_Player_Update_Health();
	Perl_Player_Update_Mana();
end

function Perl_Player_Set_Text_Positions()
	Perl_Player_HealthBarTextPercent:ClearAllPoints();
	Perl_Player_ManaBarTextPercent:ClearAllPoints();
	Perl_Player_DruidBarTextPercent:ClearAllPoints();
	if (compactmode == 0) then
		Perl_Player_HealthBarText:SetPoint("RIGHT", 70, 0);
		Perl_Player_HealthBarTextPercent:SetPoint("TOP", 0, 1);
		Perl_Player_ManaBarText:SetPoint("RIGHT", 70, 0);
		Perl_Player_ManaBarTextPercent:SetPoint("TOP", 0, 1);
		Perl_Player_DruidBarText:SetPoint("RIGHT", 70, 0);
		Perl_Player_DruidBarTextPercent:SetPoint("TOP", 0, 1);
	else
		if (healermode == 0) then
			Perl_Player_HealthBarText:SetPoint("RIGHT", 70, 0);
			Perl_Player_HealthBarTextPercent:SetPoint("TOP", 0, 1);
			Perl_Player_ManaBarText:SetPoint("RIGHT", 70, 0);
			Perl_Player_ManaBarTextPercent:SetPoint("TOP", 0, 1);
			Perl_Player_DruidBarText:SetPoint("RIGHT", 70, 0);
			Perl_Player_DruidBarTextPercent:SetPoint("TOP", 0, 1);
		else
			Perl_Player_HealthBarText:SetPoint("RIGHT", -10, 0);
			Perl_Player_HealthBarTextPercent:SetPoint("TOPLEFT", 5, 1);
			Perl_Player_ManaBarText:SetPoint("RIGHT", -10, 0);
			Perl_Player_ManaBarTextPercent:SetPoint("TOPLEFT", 5, 1);
			Perl_Player_DruidBarText:SetPoint("RIGHT", -10, 0);
			Perl_Player_DruidBarTextPercent:SetPoint("TOPLEFT", 5, 1);
		end
	end
end

function Perl_Player_HealthShow()
	if (healermode == 1) then
		if (showbarvalues == 0) then
			playerhealth = UnitHealth("player");
			playerhealthmax = UnitHealthMax("player");

			if (UnitIsDead("player") or UnitIsGhost("player")) then				-- This prevents negative health
				playerhealth = 0;
			end

			Perl_Player_HealthBarTextPercent:SetText(playerhealth.."/"..playerhealthmax);
			mouseoverhealthflag = 1;
		end
	end
end

function Perl_Player_HealthHide()
	if (healermode == 1) then
		if (showbarvalues == 0) then
			Perl_Player_HealthBarTextPercent:SetText();
			mouseoverhealthflag = 0;
		end
	end
end

function Perl_Player_ManaShow()
	if (healermode == 1) then
		if (showbarvalues == 0) then
			playermana = UnitMana("player");
			playermanamax = UnitManaMax("player");

			if (UnitIsDead("player") or UnitIsGhost("player")) then				-- This prevents negative mana
				playermana = 0;
			end

			if (UnitPowerType("player") == 1) then
				Perl_Player_ManaBarTextPercent:SetText(playermana);
			else
				Perl_Player_ManaBarTextPercent:SetText(playermana.."/"..playermanamax);
			end
			mouseovermanaflag = 1;
		end
	end
end

function Perl_Player_ManaHide()
	if (healermode == 1) then
		if (showbarvalues == 0) then
			Perl_Player_ManaBarTextPercent:SetText();
			mouseovermanaflag = 0;
		end
	end
end

function Perl_Player_DruidBarManaShow()
	if (DruidBarKey and (UnitClass("player") == PERL_LOCALIZED_DRUID)) then
		if (healermode == 1) then
			playerdruidbarmana = floor(DruidBarKey.keepthemana);
			playerdruidbarmanamax = DruidBarKey.maxmana;
			playerdruidbarmanapercent = floor(playerdruidbarmana/playerdruidbarmanamax*100+0.5);

			if (playerdruidbarmanapercent == 100) then			-- This is to ensure the value isn't 1 or 2 mana under max when 100%
				playerdruidbarmana = playerdruidbarmanamax;
			end

			if (UnitIsDead("player") or UnitIsGhost("player")) then		-- This prevents negative mana
				playerdruidbarmana = 0;
			end

			Perl_Player_DruidBarTextPercent:SetText(playerdruidbarmana.."/"..playerdruidbarmanamax);

			mouseovermanaflag = 1;
		end
	end
end

function Perl_Player_DruidBarManaHide()
	if (healermode == 1) then
		Perl_Player_DruidBarTextPercent:SetText();
		mouseovermanaflag = 0;
	end
end

function Perl_Player_Update_Portrait()
	if (showportrait == 1) then
		Perl_Player_PortraitFrame:Show();					-- Show the main portrait frame

		if (threedportrait == 0) then
			SetPortraitTexture(Perl_Player_Portrait, "player");		-- Load the correct 2d graphic
			Perl_Player_PortraitFrame_PlayerModel:Hide();			-- Hide the 3d graphic
			Perl_Player_Portrait:Show();					-- Show the 2d graphic
		else
			Perl_Player_PortraitFrame_PlayerModel:SetUnit("player");	-- Load the correct 3d graphic
			Perl_Player_Portrait:Hide();					-- Hide the 2d graphic
			Perl_Player_PortraitFrame_PlayerModel:Show();			-- Show the 3d graphic
			Perl_Player_PortraitFrame_PlayerModel:SetCamera(0);
		end
	else
		Perl_Player_PortraitFrame:Hide();					-- Hide the frame and 2d/3d portion
	end

	if (Perl_Player_Buff_Script_Frame) then
		if (showportrait == 1) then
			if (xpbarstate == 3) then
				Perl_Player_BuffFrame:SetPoint("TOPLEFT", "Perl_Player_PortraitFrame", "BOTTOMLEFT", 0, -2);
			else
				Perl_Player_BuffFrame:SetPoint("TOPLEFT", "Perl_Player_PortraitFrame", "BOTTOMLEFT", 0, -10);
			end
		else
			Perl_Player_BuffFrame:SetPoint("TOPLEFT", "Perl_Player_StatsFrame", "BOTTOMLEFT", 0, -2);
		end
	end
end

function Perl_Player_Portrait_Combat_Text()
	if (portraitcombattext == 1) then
		Perl_Player_PortraitTextFrame:Show();
	else
		Perl_Player_PortraitTextFrame:Hide();
	end
end

function Perl_Player_PvP_Rank_Icon()
	if (showpvprank == 1) then
		local rankNumber = UnitPVPRank("player");
		if (rankNumber == 0) then
			Perl_Player_PVPRank:Hide();
		elseif (rankNumber < 14) then
			rankNumber = rankNumber - 4;
			Perl_Player_PVPRank:SetTexture("Interface\\PvPRankBadges\\PvPRank0"..rankNumber);
			Perl_Player_PVPRank:Show();
		else
			rankNumber = rankNumber - 4;
			Perl_Player_PVPRank:SetTexture("Interface\\PvPRankBadges\\PvPRank"..rankNumber);
			Perl_Player_PVPRank:Show();
		end
	else
		Perl_Player_PVPRank:Hide();
	end
end

function Perl_Player_Check_Hidden()
	if (hiddeninraid == 1) then
		if (UnitInRaid("player")) then
			Perl_Player_Frame:Hide();
		else
			Perl_Player_Frame:Show();
		end
	else
		Perl_Player_Frame:Show();
	end
end

function Perl_Player_Set_Localized_ClassIcons()
	Perl_Player_ClassPosRight = {
		[PERL_LOCALIZED_DRUID] = 0.75,
		[PERL_LOCALIZED_HUNTER] = 0,
		[PERL_LOCALIZED_MAGE] = 0.25,
		[PERL_LOCALIZED_PALADIN] = 0,
		[PERL_LOCALIZED_PRIEST] = 0.5,
		[PERL_LOCALIZED_ROGUE] = 0.5,
		[PERL_LOCALIZED_SHAMAN] = 0.25,
		[PERL_LOCALIZED_WARLOCK] = 0.75,
		[PERL_LOCALIZED_WARRIOR] = 0,
	};
	Perl_Player_ClassPosLeft = {
		[PERL_LOCALIZED_DRUID] = 1,
		[PERL_LOCALIZED_HUNTER] = 0.25,
		[PERL_LOCALIZED_MAGE] = 0.5,
		[PERL_LOCALIZED_PALADIN] = 0.25,
		[PERL_LOCALIZED_PRIEST] = 0.75,
		[PERL_LOCALIZED_ROGUE] = 0.75,
		[PERL_LOCALIZED_SHAMAN] = 0.5,
		[PERL_LOCALIZED_WARLOCK] = 1,
		[PERL_LOCALIZED_WARRIOR] = 0.25,
	};
	Perl_Player_ClassPosTop = {
		[PERL_LOCALIZED_DRUID] = 0,
		[PERL_LOCALIZED_HUNTER] = 0.25,
		[PERL_LOCALIZED_MAGE] = 0,
		[PERL_LOCALIZED_PALADIN] = 0.5,
		[PERL_LOCALIZED_PRIEST] = 0.25,
		[PERL_LOCALIZED_ROGUE] = 0,
		[PERL_LOCALIZED_SHAMAN] = 0.25,
		[PERL_LOCALIZED_WARLOCK] = 0.25,
		[PERL_LOCALIZED_WARRIOR] = 0,
		
	};
	Perl_Player_ClassPosBottom = {
		[PERL_LOCALIZED_DRUID] = 0.25,
		[PERL_LOCALIZED_HUNTER] = 0.5,
		[PERL_LOCALIZED_MAGE] = 0.25,
		[PERL_LOCALIZED_PALADIN] = 0.75,
		[PERL_LOCALIZED_PRIEST] = 0.5,
		[PERL_LOCALIZED_ROGUE] = 0.25,
		[PERL_LOCALIZED_SHAMAN] = 0.5,
		[PERL_LOCALIZED_WARLOCK] = 0.5,
		[PERL_LOCALIZED_WARRIOR] = 0.25,
	};
end


------------------------
-- Fade Bar Functions --
------------------------
function Perl_Player_HealthBar_Fade(arg1)
	Perl_Player_HealthBar_Fade_Color = Perl_Player_HealthBar_Fade_Color - arg1;
	Perl_Player_HealthBar_Fade_Time_Elapsed = Perl_Player_HealthBar_Fade_Time_Elapsed + arg1;

	Perl_Player_HealthBarFadeBar:SetStatusBarColor(0, Perl_Player_HealthBar_Fade_Color, 0, Perl_Player_HealthBar_Fade_Color);

	if (Perl_Player_HealthBar_Fade_Time_Elapsed > 1) then
		Perl_Player_HealthBar_Fade_Color = 1;
		Perl_Player_HealthBar_Fade_Time_Elapsed = 0;
		Perl_Player_HealthBarFadeBar:Hide();
		Perl_Player_HealthBar_Fade_OnUpdate_Frame:Hide();
	end
end

function Perl_Player_ManaBar_Fade(arg1)
	Perl_Player_ManaBar_Fade_Color = Perl_Player_ManaBar_Fade_Color - arg1;
	Perl_Player_ManaBar_Fade_Time_Elapsed = Perl_Player_ManaBar_Fade_Time_Elapsed + arg1;

	if (playerpower == 0) then
		Perl_Player_ManaBarFadeBar:SetStatusBarColor(0, 0, Perl_Player_ManaBar_Fade_Color, Perl_Player_ManaBar_Fade_Color);
	elseif (playerpower == 1) then
		Perl_Player_ManaBarFadeBar:SetStatusBarColor(Perl_Player_ManaBar_Fade_Color, 0, 0, Perl_Player_ManaBar_Fade_Color);
	elseif (playerpower == 3) then
		Perl_Player_ManaBarFadeBar:SetStatusBarColor(Perl_Player_ManaBar_Fade_Color, Perl_Player_ManaBar_Fade_Color, 0, Perl_Player_ManaBar_Fade_Color);
	end

	if (Perl_Player_ManaBar_Fade_Time_Elapsed > 1) then
		Perl_Player_ManaBar_Fade_Color = 1;
		Perl_Player_ManaBar_Fade_Time_Elapsed = 0;
		Perl_Player_ManaBarFadeBar:Hide();
		Perl_Player_ManaBar_Fade_OnUpdate_Frame:Hide();
	end
end

--function Perl_Player_DruidBar_Fade(arg1)
--	Perl_Player_DruidBar_Fade_Color = Perl_Player_DruidBar_Fade_Color - arg1;
--	Perl_Player_DruidBar_Fade_Time_Elapsed = Perl_Player_DruidBar_Fade_Time_Elapsed + arg1;
--
--	Perl_Player_DruidBarFadeBar:SetStatusBarColor(0, 0, Perl_Player_DruidBar_Fade_Color, Perl_Player_DruidBar_Fade_Color);
--
--	if (Perl_Player_DruidBar_Fade_Time_Elapsed > 1) then
--		Perl_Player_DruidBar_Fade_Color = 1;
--		Perl_Player_DruidBar_Fade_Time_Elapsed = 0;
--		Perl_Player_DruidBarFadeBar:Hide();
--		Perl_Player_DruidBar_Fade_OnUpdate_Frame:Hide();
--	end
--end


--------------------------
-- GUI Config Functions --
--------------------------
function Perl_Player_XPBar_Display(state)
	if (state == 1) then							-- Experience
		Perl_Player_StatsFrame:SetHeight(54);
		Perl_Player_StatsFrame_CastClickOverlay:SetHeight(54);
		Perl_Player_XPBar:Show();
		Perl_Player_XPBarBG:Show();
		Perl_Player_XPRestBar:Show();
		Perl_Player_XPBar_CastClickOverlay:Show();
		Perl_Player_Update_Experience();
	elseif (state == 2) then						-- PvP
		Perl_Player_StatsFrame:SetHeight(54);
		Perl_Player_StatsFrame_CastClickOverlay:SetHeight(54);
		Perl_Player_XPBar:Show();
		Perl_Player_XPBarBG:Show();
		Perl_Player_XPRestBar:Show();
		Perl_Player_XPBar_CastClickOverlay:Show();
		local rankNumber, rankName, rankProgress;
		rankNumber = UnitPVPRank("player")
		if (rankNumber < 1) then
			rankName = "Unranked"
		else
			rankName = GetPVPRankInfo(rankNumber, "player");
		end
		Perl_Player_XPBar:SetMinMaxValues(0, 1);
		Perl_Player_XPRestBar:SetMinMaxValues(0, 1);
		Perl_Player_XPBar:SetValue(GetPVPRankProgress());
		Perl_Player_XPRestBar:SetValue(GetPVPRankProgress());
		Perl_Player_XPBarText:SetText(rankName);
		Perl_Player_XPBar:SetStatusBarColor(0, 0.6, 0.6, 1);
		Perl_Player_XPRestBar:SetStatusBarColor(0, 0.6, 0.6, 0.5);
		Perl_Player_XPBarBG:SetStatusBarColor(0, 0.6, 0.6, 0.25);
	elseif (state == 3) then						-- Hidden
		Perl_Player_XPBar:Hide();
		Perl_Player_XPBarBG:Hide();
		Perl_Player_XPRestBar:Hide();
		Perl_Player_XPBar_CastClickOverlay:Hide();
		Perl_Player_StatsFrame:SetHeight(42);
		Perl_Player_StatsFrame_CastClickOverlay:SetHeight(42);
	elseif (state == 4) then						-- Reputation
		Perl_Player_StatsFrame:SetHeight(54);
		Perl_Player_StatsFrame_CastClickOverlay:SetHeight(54);
		Perl_Player_XPBar:Show();
		Perl_Player_XPBarBG:Show();
		Perl_Player_XPRestBar:Show();
		Perl_Player_XPBar_CastClickOverlay:Show();
		Perl_Player_Update_Reputation();
	end
	if (DruidBarKey and (UnitClass("player") == PERL_LOCALIZED_DRUID) and (UnitPowerType("player") > 0)) then		-- Only change the size if the player has Druid Bar, is a Druid, and is morphed currently
		if (state == 3) then
			Perl_Player_StatsFrame:SetHeight(54);			-- Experience Bar is hidden
			Perl_Player_StatsFrame_CastClickOverlay:SetHeight(54);
		else
			Perl_Player_StatsFrame:SetHeight(66);			-- Experience Bar is shown
			Perl_Player_StatsFrame_CastClickOverlay:SetHeight(66);
		end
	end
	xpbarstate = state;
	Perl_Player_Update_Portrait();		-- Update the Player_Buff position if needed
	Perl_Player_UpdateVars();
end

function Perl_Player_Set_Compact(newvalue)
	compactmode = newvalue;
	Perl_Player_UpdateVars();
	Perl_Player_Set_Text_Positions();
	Perl_Player_Set_CompactMode();
end

function Perl_Player_Set_Healer(newvalue)
	healermode = newvalue;
	Perl_Player_UpdateVars();
	Perl_Player_Set_Text_Positions();
	Perl_Player_Update_Health();
	Perl_Player_Update_Mana();
end

function Perl_Player_Set_RaidGroupNumber(newvalue)
	showraidgroup = newvalue;
	Perl_Player_UpdateVars();
	Perl_Player_Update_Raid_Group_Number();
end

function Perl_Player_Set_Lock(newvalue)
	locked = newvalue;
	Perl_Player_UpdateVars();
end

function Perl_Player_Set_Portrait(newvalue)
	showportrait = newvalue;
	Perl_Player_UpdateVars();
	Perl_Player_Update_Portrait();
end

function Perl_Player_Set_3D_Portrait(newvalue)
	threedportrait = newvalue;
	Perl_Player_UpdateVars();
	Perl_Player_Update_Portrait();
end

function Perl_Player_Set_Portrait_Combat_Text(newvalue)
	portraitcombattext = newvalue;
	Perl_Player_UpdateVars();
	Perl_Player_Portrait_Combat_Text();
end

function Perl_Player_Set_Compact_Percent(newvalue)
	compactpercent = newvalue;
	Perl_Player_UpdateVars();
	Perl_Player_Set_Text_Positions();
	Perl_Player_Set_CompactMode();
end

function Perl_Player_Set_Short_Bars(newvalue)
	shortbars = newvalue;
	Perl_Player_UpdateVars();
	Perl_Player_Set_Text_Positions();
	Perl_Player_Set_CompactMode();
end

function Perl_Player_Set_DruidBar(newvalue)
	showdruidbar = newvalue;
	Perl_Player_UpdateVars();
	Perl_Player_Set_Text_Positions();
	Perl_Player_Set_CompactMode();		-- Perl_Player_Update_Mana() called here
end

function Perl_Player_Set_FiveSec(newvalue)
	fivesecsupport = newvalue;
	Perl_Player_UpdateVars();
	Perl_Player_Update_Mana_Bar();
	Perl_Player_Update_Mana();
end

function Perl_Player_Set_Class_Colored_Names(newvalue)
	classcolorednames = newvalue;
	Perl_Player_UpdateVars();
	Perl_Player_Update_PvP_Status();
end

function Perl_Player_Set_Hide_Class_Level_Frame(newvalue)
	hideclasslevelframe = newvalue;
	Perl_Player_UpdateVars();
	Perl_Player_Set_Text_Positions();
	Perl_Player_Set_CompactMode();
end

function Perl_Player_Set_PvP_Rank_Icon(newvalue)
	showpvprank = newvalue;
	Perl_Player_UpdateVars();
	Perl_Player_PvP_Rank_Icon();
end

function Perl_Player_Set_Mana_Deficit(newvalue)
	showmanadeficit = newvalue;
	Perl_Player_UpdateVars();
	Perl_Player_Update_Mana();
end

function Perl_Player_Set_Hidden_In_Raids(newvalue)
	hiddeninraid = newvalue;
	Perl_Player_UpdateVars();
	Perl_Player_Check_Hidden();
end

function Perl_Player_Set_PvP_Icon(newvalue)
	showpvpicon =  newvalue;
	Perl_Player_UpdateVars();
	Perl_Player_Update_PvP_Status();
end

function Perl_Player_Set_Show_Bar_Values(newvalue)
	showbarvalues = newvalue;
	Perl_Player_UpdateVars();
	Perl_Player_Update_Health();
	Perl_Player_Update_Mana();
end

function Perl_Player_Set_Scale(number)
	local unsavedscale;
	if (number ~= nil) then
		scale = (number / 100);					-- convert the user input to a wow acceptable value
	end
	unsavedscale = 1 - UIParent:GetEffectiveScale() + scale;	-- run it through the scaling formula introduced in 1.9
	Perl_Player_Frame:SetScale(unsavedscale);
	Perl_Player_UpdateVars();
end

function Perl_Player_Set_Transparency(number)
	if (number ~= nil) then
		transparency = (number / 100);				-- convert the user input to a wow acceptable value
	end
	Perl_Player_Frame:SetAlpha(transparency);
	Perl_Player_UpdateVars();
end


------------------------------
-- Saved Variable Functions --
------------------------------
function Perl_Player_GetVars(name, updateflag)
	if (name == nil) then
		name = UnitName("player");
	end

	locked = Perl_Player_Config[name]["Locked"];
	xpbarstate = Perl_Player_Config[name]["XPBarState"];
	compactmode = Perl_Player_Config[name]["CompactMode"];
	showraidgroup = Perl_Player_Config[name]["ShowRaidGroup"];
	scale = Perl_Player_Config[name]["Scale"];
	healermode = Perl_Player_Config[name]["HealerMode"];
	transparency = Perl_Player_Config[name]["Transparency"];
	showportrait = Perl_Player_Config[name]["ShowPortrait"];
	compactpercent = Perl_Player_Config[name]["CompactPercent"];
	threedportrait = Perl_Player_Config[name]["ThreeDPortrait"];
	portraitcombattext = Perl_Player_Config[name]["PortraitCombatText"];
	showdruidbar = Perl_Player_Config[name]["ShowDruidBar"];
	fivesecsupport = Perl_Player_Config[name]["FiveSecSupport"];
	shortbars = Perl_Player_Config[name]["ShortBars"];
	classcolorednames = Perl_Player_Config[name]["ClassColoredNames"];
	hideclasslevelframe = Perl_Player_Config[name]["HideClassLevelFrame"];
	showpvprank = Perl_Player_Config[name]["ShowPvPRank"];
	showmanadeficit = Perl_Player_Config[name]["ShowManaDeficit"];
	hiddeninraid = Perl_Player_Config[name]["HiddenInRaid"];
	showpvpicon = Perl_Player_Config[name]["ShowPvPIcon"];
	showbarvalues = Perl_Player_Config[name]["ShowBarValues"];

	if (locked == nil) then
		locked = 0;
	end
	if (xpbarstate == nil) then
		xpbarstate = 1;
	end
	if (compactmode == nil) then
		compactmode = 0;
	end
	if (showraidgroup == nil) then
		showraidgroup = 1;
	end
	if (scale == nil) then
		scale = 1;
	end
	if (healermode == nil) then
		healermode = 0;
	end
	if (transparency == nil) then
		transparency = 1;
	end
	if (showportrait == nil) then
		showportrait = 0;
	end
	if (compactpercent == nil) then
		compactpercent = 0;
	end
	if (threedportrait == nil) then
		threedportrait = 0;
	end
	if (portraitcombattext == nil) then
		portraitcombattext = 0;
	end
	if (showdruidbar == nil) then
		showdruidbar = 0;
	end
	if (fivesecsupport == nil) then
		fivesecsupport = 0;
	end
	if (shortbars == nil) then
		shortbars = 0;
	end
	if (classcolorednames == nil) then
		classcolorednames = 0;
	end
	if (hideclasslevelframe == nil) then
		hideclasslevelframe = 0;
	end
	if (showpvprank == nil) then
		showpvprank = 0;
	end
	if (showmanadeficit == nil) then
		showmanadeficit = 0;
	end
	if (hiddeninraid == nil) then
		hiddeninraid = 0;
	end
	if (showpvpicon == nil) then
		showpvpicon = 1;
	end
	if (showbarvalues == nil) then
		showbarvalues = 0;
	end

	if (updateflag == 1) then
		-- Save the new values
		Perl_Player_UpdateVars();

		-- Call any code we need to activate them
		Perl_Player_XPBar_Display(xpbarstate);
		Perl_Player_Set_Compact(compactmode);
		Perl_Player_Set_Healer(healermode);
		Perl_Player_Update_Raid_Group_Number();
		Perl_Player_Update_Health();
		Perl_Player_Update_Mana();
		Perl_Player_Update_Portrait();
		Perl_Player_Portrait_Combat_Text();
		Perl_Player_Update_PvP_Status();
		Perl_Player_PvP_Rank_Icon();
		Perl_Player_Set_Scale();
		Perl_Player_Set_Transparency();
		Perl_Player_Check_Hidden();
		return;
	end

	local vars = {
		["locked"] = locked,
		["xpbarstate"] = xpbarstate,
		["compactmode"] = compactmode,
		["showraidgroup"] = showraidgroup,
		["scale"] = scale,
		["healermode"] = healermode,
		["transparency"] = transparency,
		["showportrait"] = showportrait,
		["compactpercent"] = compactpercent,
		["threedportrait"] = threedportrait,
		["portraitcombattext"] = portraitcombattext,
		["showdruidbar"] = showdruidbar,
		["fivesecsupport"] = fivesecsupport,
		["shortbars"] = shortbars,
		["classcolorednames"] = classcolorednames,
		["hideclasslevelframe"] = hideclasslevelframe,
		["showpvprank"] = showpvprank,
		["showmanadeficit"] = showmanadeficit,
		["hiddeninraid"] = hiddeninraid,
		["showpvpicon"] = showpvpicon,
		["showbarvalues"] = showbarvalues,
	}
	return vars;
end

function Perl_Player_UpdateVars(vartable)
	if (vartable ~= nil) then
		-- Sanity checks in case you use a load from an old version
		if (vartable["Global Settings"] ~= nil) then
			if (vartable["Global Settings"]["Locked"] ~= nil) then
				locked = vartable["Global Settings"]["Locked"];
			else
				locked = nil;
			end
			if (vartable["Global Settings"]["XPBarState"] ~= nil) then
				xpbarstate = vartable["Global Settings"]["XPBarState"];
			else
				xpbarstate = nil;
			end
			if (vartable["Global Settings"]["CompactMode"] ~= nil) then
				compactmode = vartable["Global Settings"]["CompactMode"];
			else
				compactmode = nil;
			end
			if (vartable["Global Settings"]["ShowRaidGroup"] ~= nil) then
				showraidgroup = vartable["Global Settings"]["ShowRaidGroup"];
			else
				showraidgroup = nil;
			end
			if (vartable["Global Settings"]["Scale"] ~= nil) then
				scale = vartable["Global Settings"]["Scale"];
			else
				scale = nil;
			end
			if (vartable["Global Settings"]["HealerMode"] ~= nil) then
				healermode = vartable["Global Settings"]["HealerMode"];
			else
				healermode = nil;
			end
			if (vartable["Global Settings"]["Transparency"] ~= nil) then
				transparency = vartable["Global Settings"]["Transparency"];
			else
				transparency = nil;
			end
			if (vartable["Global Settings"]["ShowPortrait"] ~= nil) then
				showportrait = vartable["Global Settings"]["ShowPortrait"];
			else
				showportrait = nil;
			end
			if (vartable["Global Settings"]["CompactPercent"] ~= nil) then
				compactpercent = vartable["Global Settings"]["CompactPercent"];
			else
				compactpercent = nil;
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
			if (vartable["Global Settings"]["ShowDruidBar"] ~= nil) then
				showdruidbar = vartable["Global Settings"]["ShowDruidBar"];
			else
				showdruidbar = nil;
			end
			if (vartable["Global Settings"]["FiveSecSupport"] ~= nil) then
				fivesecsupport = vartable["Global Settings"]["FiveSecSupport"];
			else
				fivesecsupport = nil;
			end
			if (vartable["Global Settings"]["ShortBars"] ~= nil) then
				shortbars = vartable["Global Settings"]["ShortBars"];
			else
				shortbars = nil;
			end
			if (vartable["Global Settings"]["ClassColoredNames"] ~= nil) then
				classcolorednames = vartable["Global Settings"]["ClassColoredNames"];
			else
				classcolorednames = nil;
			end
			if (vartable["Global Settings"]["HideClassLevelFrame"] ~= nil) then
				hideclasslevelframe = vartable["Global Settings"]["HideClassLevelFrame"];
			else
				hideclasslevelframe = nil;
			end
			if (vartable["Global Settings"]["ShowPvPRank"] ~= nil) then
				showpvprank = vartable["Global Settings"]["ShowPvPRank"];
			else
				showpvprank = nil;
			end
			if (vartable["Global Settings"]["ShowManaDeficit"] ~= nil) then
				showmanadeficit = vartable["Global Settings"]["ShowManaDeficit"];
			else
				showmanadeficit = nil;
			end
			if (vartable["Global Settings"]["HiddenInRaid"] ~= nil) then
				hiddeninraid = vartable["Global Settings"]["HiddenInRaid"];
			else
				hiddeninraid = nil;
			end
			if (vartable["Global Settings"]["ShowPvPIcon"] ~= nil) then
				showpvpicon = vartable["Global Settings"]["ShowPvPIcon"];
			else
				showpvpicon = nil;
			end
			if (vartable["Global Settings"]["ShowBarValues"] ~= nil) then
				showbarvalues = vartable["Global Settings"]["ShowBarValues"];
			else
				showbarvalues = nil;
			end
		end

		-- Set the new values if any new values were found, same defaults as above
		if (locked == nil) then
			locked = 0;
		end
		if (xpbarstate == nil) then
			xpbarstate = 1;
		end
		if (compactmode == nil) then
			compactmode = 0;
		end
		if (showraidgroup == nil) then
			showraidgroup = 1;
		end
		if (scale == nil) then
			scale = 1;
		end
		if (healermode == nil) then
			healermode = 0;
		end
		if (transparency == nil) then
			transparency = 1;
		end
		if (showportrait == nil) then
			showportrait = 0;
		end
		if (compactpercent == nil) then
			compactpercent = 0;
		end
		if (threedportrait == nil) then
			threedportrait = 0;
		end
		if (portraitcombattext == nil) then
			portraitcombattext = 0;
		end
		if (showdruidbar == nil) then
			showdruidbar = 0;
		end
		if (fivesecsupport == nil) then
			fivesecsupport = 0;
		end
		if (shortbars == nil) then
			shortbars = 0;
		end
		if (classcolorednames == nil) then
			classcolorednames = 0;
		end
		if (hideclasslevelframe == nil) then
			hideclasslevelframe = 0;
		end
		if (showpvprank == nil) then
			showpvprank = 0;
		end
		if (showmanadeficit == nil) then
			showmanadeficit = 0;
		end
		if (hiddeninraid == nil) then
			hiddeninraid = 0;
		end
		if (showpvpicon == nil) then
			showpvpicon = 1;
		end
		if (showbarvalues == nil) then
			showbarvalues = 0;
		end

		-- Call any code we need to activate them
		Perl_Player_XPBar_Display(xpbarstate);
		Perl_Player_Set_Compact(compactmode);
		Perl_Player_Set_Healer(healermode);
		Perl_Player_Update_Raid_Group_Number();
		Perl_Player_Update_Health();
		Perl_Player_Update_Mana();
		Perl_Player_Update_Portrait();
		Perl_Player_Portrait_Combat_Text();
		Perl_Player_Update_PvP_Status();
		Perl_Player_PvP_Rank_Icon();
		Perl_Player_Set_Scale();
		Perl_Player_Set_Transparency();
		Perl_Player_Check_Hidden();
	end

	-- IFrameManager Support
	if (IFrameManager) then
		IFrameManager:Refresh();
	end

	Perl_Player_Config[UnitName("player")] = {
		["Locked"] = locked,
		["XPBarState"] = xpbarstate,
		["CompactMode"] = compactmode,
		["ShowRaidGroup"] = showraidgroup,
		["Scale"] = scale,
		["HealerMode"] = healermode,
		["Transparency"] = transparency,
		["ShowPortrait"] = showportrait,
		["CompactPercent"] = compactpercent,
		["ThreeDPortrait"] = threedportrait,
		["PortraitCombatText"] = portraitcombattext,
		["ShowDruidBar"] = showdruidbar,
		["FiveSecSupport"] = fivesecsupport,
		["ShortBars"] = shortbars,
		["ClassColoredNames"] = classcolorednames,
		["HideClassLevelFrame"] = hideclasslevelframe,
		["ShowPvPRank"] = showpvprank,
		["ShowManaDeficit"] = showmanadeficit,
		["HiddenInRaid"] = hiddeninraid,
		["ShowPvPIcon"] = showpvpicon,
		["ShowBarValues"] = showbarvalues,
	};
end


--------------------
-- Click Handlers --
--------------------
function Perl_PlayerDropDown_OnLoad()
	UIDropDownMenu_Initialize(this, Perl_PlayerDropDown_Initialize, "MENU");
end

function Perl_PlayerDropDown_Initialize()
	UnitPopup_ShowMenu(Perl_Player_DropDown, "SELF", "player");
end

function Perl_Player_MouseClick(button)
	if (Perl_Custom_ClickFunction) then				-- Check to see if someone defined a custom click function
		if (Perl_Custom_ClickFunction(button, "player")) then	-- If the function returns true, then we return
			return;
		end
	end								-- Otherwise, it did nothing, so take default action

	if (PCUF_CASTPARTYSUPPORT == 1) then
		if (not string.find(GetMouseFocus():GetName(), "Name") or PCUF_NAMEFRAMECLICKCAST == 1) then
			if (CastPartyConfig) then
				CastParty.Event.OnClickByUnit(button, "player");
				return;
			elseif (Genesis_MouseHeal and Genesis_MouseHeal("player", button)) then
				return;
			elseif (CH_Config) then
				if (CH_Config.PCUFEnabled) then
					CH_UnitClicked("player", button);
					return;
				end
			elseif (SmartHeal) then
				if (SmartHeal.Loaded and SmartHeal:getConfig("enable", "clickmode")) then
					local KeyDownType = SmartHeal:GetClickHealButton();
					if(KeyDownType and KeyDownType ~= "undetermined") then
						SmartHeal:ClickHeal(KeyDownType..button, "player");
					else
						SmartHeal:DefaultClick(button, "player");
					end
					return;
				end
			end
		end
	end

	if (button == "LeftButton") then
		if (SpellIsTargeting()) then
			SpellTargetUnit("player");
		elseif (CursorHasItem()) then
			DropItemOnUnit("player");
		else
			TargetUnit("player");
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
		ToggleDropDownMenu(1, nil, Perl_Player_DropDown, "Perl_Player_NameFrame", 40, 0);
	end
end

function Perl_Player_DragStart(button)
	if (button == "LeftButton" and locked == 0) then
		Perl_Player_Frame:StartMoving();
	end
end

function Perl_Player_DragStop(button)
	Perl_Player_Frame:StopMovingOrSizing();
end


------------------------
-- Experience Tooltip --
------------------------
function Perl_Player_XPTooltip()
	local playerxp, playerxpmax, xptext
	GameTooltip_SetDefaultAnchor(GameTooltip, this);
	if (xpbarstate == 1) then
		local playerlevel = UnitLevel("player");			-- Player's next level
		if (playerlevel < 70) then
			playerxp = UnitXP("player");				-- Player's current XP
			playerxpmax = UnitXPMax("player");			-- Experience for the current level
			local playerxprest = GetXPExhaustion();			-- Amount of bonus xp we have
			local xptolevel = playerxpmax - playerxp		-- XP till level

			if (playerxprest) then
				xptext = playerxp.."/"..playerxpmax .." (+"..(playerxprest)..")";	-- Create the experience string w/ rest xp
			else
				xptext = playerxp.."/"..playerxpmax;		-- Create the experience string w/ no rest xp
			end

			GameTooltip:SetText(xptext, 255/255, 209/255, 0/255);
			if (GetLocale() == "deDE") then
				GameTooltip:AddLine(xptolevel.." ("..floor((playerxpmax-playerxp)/playerxpmax*100+0.5).."%) bis Level "..(playerlevel + 1), 255/255, 209/255, 0/255);
			elseif (GetLocale() == "koKR") then
				GameTooltip:AddLine((playerlevel + 1).." 레벨 까지 "..xptolevel.." ("..floor((playerxpmax-playerxp)/playerxpmax*100+0.5).."%) 남음", 255/255, 209/255, 0/255);
			elseif (GetLocale() == "zhCN") then
				GameTooltip:AddLine("还有"..xptolevel.." ("..floor((playerxpmax-playerxp)/playerxpmax*100+0.5).."%) 才能到达级别 "..(playerlevel + 1), 255/255, 209/255, 0/255);
			else
				GameTooltip:AddLine(xptolevel.." ("..floor((playerxpmax-playerxp)/playerxpmax*100+0.5).."%) until level "..(playerlevel + 1), 255/255, 209/255, 0/255);
			end
		else
			GameTooltip:SetText(PERL_LOCALIZED_PLAYER_NOMORE_EXPERIENCE, 255/255, 209/255, 0/255);
		end
		
	elseif (xpbarstate == 2) then
		local rankNumber, rankName, rankProgress;			-- Some variables
		rankNumber = UnitPVPRank("player")
		if (rankNumber < 1) then
			rankName = "Unranked"
			GameTooltip:SetText(PERL_LOCALIZED_PLAYER_UNRANKED, 255/255, 209/255, 0/255);
		else
			rankName = GetPVPRankInfo(rankNumber, "player");
			rankProgress = floor(GetPVPRankProgress() * 100);
			if (GetLocale() == "deDE") then
				GameTooltip:SetText(rankProgress.."% in Rang "..(rankNumber - 4).." ("..rankName..")", 255/255, 209/255, 0/255);
			elseif (GetLocale() == "koKR") then
				GameTooltip:SetText((rankNumber - 4).."등급 ("..rankName..")의 "..rankProgress.."% 입니다", 255/255, 209/255, 0/255);
			elseif (GetLocale() == "zhCN") then
				GameTooltip:SetText(rankProgress.."% 处于荣誉 "..(rankNumber - 4).." ("..rankName..")", 255/255, 209/255, 0/255);
			else
				GameTooltip:SetText(rankProgress.."% into Rank "..(rankNumber - 4).." ("..rankName..")", 255/255, 209/255, 0/255);
			end
			if (rankNumber < 18) then
				rankNumber = rankNumber + 1;
				rankName = GetPVPRankInfo(rankNumber, "player");
				if (GetLocale() == "deDE") then
					GameTooltip:AddLine((100 - rankProgress).."% bis Rang "..(rankNumber - 4).." ("..rankName..")", 255/255, 209/255, 0/255);
				elseif (GetLocale() == "koKR") then
					GameTooltip:AddLine((rankNumber - 4).."등급 ("..rankName..")까지 "..(100 - rankProgress).."% 남음", 255/255, 209/255, 0/255);
				elseif (GetLocale() == "zhCN") then
					GameTooltip:AddLine("还有"..(100 - rankProgress).."% 将达到荣誉 "..(rankNumber - 4).." ("..rankName..")", 255/255, 209/255, 0/255);
				else
					GameTooltip:AddLine((100 - rankProgress).."% until Rank "..(rankNumber - 4).." ("..rankName..")", 255/255, 209/255, 0/255);
				end
			end
		end
	elseif (xpbarstate == 4) then
		local name, reaction, min, max, value = GetWatchedFactionInfo();
		if (name) then
			value = value - min;
			max = max - min;
			min = 0;
			GameTooltip:SetText(name, 255/255, 209/255, 0/255);
			if (GetLocale() == "koKR") then
				GameTooltip:AddLine(Perl_Player_Get_Reaction_Name(reaction).."의 "..floor(value/max*100+0.5).."%", 255/255, 209/255, 0/255);
			elseif (GetLocale() == "zhCN") then
				GameTooltip:AddLine(Perl_Player_Get_Reaction_Name( reaction).."进度 "..floor(value/max*100+0.5).."%", 255/255, 209/255, 0/255);
			else
				GameTooltip:AddLine(floor(value/max*100+0.5).."% into "..Perl_Player_Get_Reaction_Name(reaction), 255/255, 209/255, 0/255);
			end
			GameTooltip:AddLine(value.."/"..max, 255/255, 209/255, 0/255);
			if (reaction ~= 8) then
				if (GetLocale() == "koKR") then
					GameTooltip:AddLine(Perl_Player_Get_Reaction_Name(reaction + 1).."까지 "..(max - value).." 남음", 255/255, 209/255, 0/255);
				elseif (GetLocale() == "zhCN") then
					GameTooltip:AddLine("还有"..(max - value).." 到达 "..Perl_Player_Get_Reaction_Name(reaction + 1), 255/255, 209/255, 0/255);
				else
					GameTooltip:AddLine((max - value).." until "..Perl_Player_Get_Reaction_Name(reaction + 1), 255/255, 209/255, 0/255);
				end
			end
		else
			GameTooltip:SetText(PERL_LOCALIZED_PLAYER_NO_REPUTATION, 255/255, 209/255, 0/255);
		end
	end
	GameTooltip:Show();
end

function Perl_Player_Get_Reaction_Name(reaction)
	local reactionname;
	if (reaction == 1) then
		reactionname = PERL_LOCALIZED_PLAYER_REACTIONNAME_ONE;
	elseif (reaction == 2) then
		reactionname = PERL_LOCALIZED_PLAYER_REACTIONNAME_TWO;
	elseif (reaction == 3) then
		reactionname = PERL_LOCALIZED_PLAYER_REACTIONNAME_THREE;
	elseif (reaction == 4) then
		reactionname = PERL_LOCALIZED_PLAYER_REACTIONNAME_FOUR;
	elseif (reaction == 5) then
		reactionname = PERL_LOCALIZED_PLAYER_REACTIONNAME_FIVE;
	elseif (reaction == 6) then
		reactionname = PERL_LOCALIZED_PLAYER_REACTIONNAME_SIX;
	elseif (reaction == 7) then
		reactionname = PERL_LOCALIZED_PLAYER_REACTIONNAME_SEVEN;
	elseif (reaction == 8) then
		reactionname = PERL_LOCALIZED_PLAYER_REACTIONNAME_EIGHT;
	end
	return reactionname;
end


-----------------------
-- Scripting Support --
-----------------------
function Perl_Player_InCombat()
	if (InCombat == 1) then
		return 1;
	else
		return nil;
	end
end


----------------------
-- myAddOns Support --
----------------------
function Perl_Player_myAddOns_Support()
	-- Register the addon in myAddOns
	if (myAddOnsFrame_Register) then
		local Perl_Player_myAddOns_Details = {
			name = "Perl_Player",
			version = PERL_LOCALIZED_VERSION,
			releaseDate = PERL_LOCALIZED_DATE,
			author = "Perl; Maintained by Global",
			email = "global@g-ball.com",
			website = "http://www.curse-gaming.com/mod.php?addid=2257",
			category = MYADDONS_CATEGORY_OTHERS
		};
		Perl_Player_myAddOns_Help = {};
		Perl_Player_myAddOns_Help[1] = "/perl";
		myAddOnsFrame_Register(Perl_Player_myAddOns_Details, Perl_Player_myAddOns_Help);
	end
end
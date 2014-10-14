---------------
-- Variables --
---------------
Perl_Target_Config = {};
local Perl_Target_Events = {};	-- event manager

-- Default Saved Variables (also set in Perl_Target_GetVars)
local locked = 0;		-- unlocked by default
local showcp = 1;		-- combo points displayed by default
local showclassicon = 1;	-- show the class icon
local showclassframe = 1;	-- show the class frame
local showpvpicon = 1;		-- show the pvp icon
local numbuffsshown = 16;	-- buff row is 16 long
local numdebuffsshown = 16;	-- debuff row is 16 long
local mobhealthsupport = 1;	-- mobhealth support is on by default
local scale = 1;		-- default scale
local showpvprank = 0;		-- hide the pvp rank by default
local transparency = 1;		-- transparency for frames
local buffdebuffscale = 1;	-- default scale for buffs and debuffs
local showportrait = 0;		-- portrait is hidden by default
local threedportrait = 0;	-- 3d portraits are off by default
local portraitcombattext = 0;	-- Combat text is disabled by default on the portrait frame
local showrareeliteframe = 0;	-- rare/elite frame is hidden by default
local nameframecombopoints = 0;	-- combo points are not displayed in the name frame by default
local comboframedebuffs = 0;	-- combo point frame will not be used for debuffs by default
local framestyle = 1;		-- default frame style is "classic"
local compactmode = 0;		-- compact mode is disabled by default
local compactpercent = 0;	-- percents are not shown in compact mode by default
local hidebuffbackground = 0;	-- buff and debuff backgrounds are shown by default
local shortbars = 0;		-- Health/Power/Experience bars are all normal length
local healermode = 0;		-- nurfed unit frame style
local soundtargetchange = 0;	-- sound when changing targets is off by default
local displaycastablebuffs = 0;	-- display all buffs by default
local classcolorednames = 0;	-- names are colored based on pvp status by default
local showmanadeficit = 0;	-- Mana deficit in healer mode is off by default
local invertbuffs = 0;		-- buffs and debuffs are below the target frame by default

-- Default Local Variables
local Initialized = nil;	-- waiting to be initialized

-- Fade Bar Variables
local Perl_Target_HealthBar_Fade_Color = 1;		-- the color fading interval
local Perl_Target_HealthBar_Fade_Time_Elapsed = 0;	-- set the update timer to 0
local Perl_Target_ManaBar_Fade_Color = 1;		-- the color fading interval
local Perl_Target_ManaBar_Fade_Time_Elapsed = 0;	-- set the update timer to 0

-- Local variables to save memory
local targethealth, targethealthmax, targethealthpercent, targetmana, targetmanamax, targetmanapercent, targetpower, targetname, targetlevel, targetlevelcolor, targetclassification, targetclassificationframetext, localizedclass, creatureType, r, g, b, namelengthrestrictor, mobhealththreenumerics;

-- Variables for position of the class icon texture.
local Perl_Target_ClassPosRight = {};
local Perl_Target_ClassPosLeft = {};
local Perl_Target_ClassPosTop = {};
local Perl_Target_ClassPosBottom = {};


----------------------
-- Loading Function --
----------------------
function Perl_Target_OnLoad()
	-- Combat Text
	CombatFeedback_Initialize(Perl_Target_HitIndicator, 30);

	-- Events
	this:RegisterEvent("PARTY_LEADER_CHANGED");
	this:RegisterEvent("PARTY_MEMBER_DISABLE");
	this:RegisterEvent("PARTY_MEMBER_ENABLE");
	this:RegisterEvent("PARTY_MEMBERS_CHANGED");
	this:RegisterEvent("PLAYER_COMBO_POINTS");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("PLAYER_TARGET_CHANGED");
	this:RegisterEvent("RAID_TARGET_UPDATE");
	this:RegisterEvent("UNIT_AURA");
	this:RegisterEvent("UNIT_COMBAT");
	this:RegisterEvent("UNIT_DISPLAYPOWER");
	this:RegisterEvent("UNIT_DYNAMIC_FLAGS");
	this:RegisterEvent("UNIT_ENERGY");
	this:RegisterEvent("UNIT_FOCUS");
	this:RegisterEvent("UNIT_HEALTH");
	this:RegisterEvent("UNIT_LEVEL");
	this:RegisterEvent("UNIT_MANA");
	this:RegisterEvent("UNIT_MAXENERGY");
	this:RegisterEvent("UNIT_MAXFOCUS");
	this:RegisterEvent("UNIT_MAXHEALTH");
	this:RegisterEvent("UNIT_MAXMANA");
	this:RegisterEvent("UNIT_MAXRAGE");
	this:RegisterEvent("UNIT_NAME_UPDATE");
	this:RegisterEvent("UNIT_PORTRAIT_UPDATE");
	this:RegisterEvent("UNIT_PVP_UPDATE");
	this:RegisterEvent("UNIT_FACTION");
	this:RegisterEvent("UNIT_RAGE");
	this:RegisterEvent("UNIT_SPELLMISS");
	this:RegisterEvent("VARIABLES_LOADED");

	-- Scripts
	this:SetScript("OnEvent", Perl_Target_OnEvent);
	this:SetScript("OnHide", Perl_Target_OnHide);
	this:SetScript("OnShow", Perl_Target_OnShow);
	this:SetScript("OnUpdate", CombatFeedback_OnUpdate);

	-- Button Click Overlays (in order of occurrence in XML)
	Perl_Target_NameFrame_CastClickOverlay:SetFrameLevel(Perl_Target_NameFrame:GetFrameLevel() + 2);
	Perl_Target_Name:SetFrameLevel(Perl_Target_NameFrame:GetFrameLevel() + 1);
	Perl_Target_LevelFrame_CastClickOverlay:SetFrameLevel(Perl_Target_LevelFrame:GetFrameLevel() + 1);
	Perl_Target_RareEliteFrame_CastClickOverlay:SetFrameLevel(Perl_Target_RareEliteFrame:GetFrameLevel() + 1);
	Perl_Target_PortraitFrame_CastClickOverlay:SetFrameLevel(Perl_Target_PortraitFrame:GetFrameLevel() + 2);
	Perl_Target_PortraitTextFrame:SetFrameLevel(Perl_Target_PortraitFrame:GetFrameLevel() + 1);
	Perl_Target_ClassNameFrame_CastClickOverlay:SetFrameLevel(Perl_Target_ClassNameFrame:GetFrameLevel() + 1);
	Perl_Target_CivilianFrame_CastClickOverlay:SetFrameLevel(Perl_Target_CivilianFrame:GetFrameLevel() + 1);
	Perl_Target_CPFrame_CastClickOverlay:SetFrameLevel(Perl_Target_CPFrame:GetFrameLevel() + 1);
	Perl_Target_StatsFrame_CastClickOverlay:SetFrameLevel(Perl_Target_StatsFrame:GetFrameLevel() + 1);
	Perl_Target_RaidIconFrame:SetFrameLevel(Perl_Target_PortraitFrame_CastClickOverlay:GetFrameLevel() - 1);
	Perl_Target_HealthBarFadeBar:SetFrameLevel(Perl_Target_HealthBar:GetFrameLevel() - 1);
	Perl_Target_ManaBarFadeBar:SetFrameLevel(Perl_Target_ManaBar:GetFrameLevel() - 1);
end


-------------------
-- Event Handler --
-------------------
function Perl_Target_OnEvent()
	local func = Perl_Target_Events[event];
	if (func) then
		func();
--	else
--		DEFAULT_CHAT_FRAME:AddMessage("Perl Classic - Target: Report the following event error to the author: "..event);
	end
end

function Perl_Target_Events:PLAYER_TARGET_CHANGED()
	if (UnitExists("target")) then
		Perl_Target_Update_Once();		-- Set the unchanging info for the target
	else
		Perl_Target_Frame:Hide();		-- There is no target, hide the frame
	end
end
Perl_Target_Events.PARTY_MEMBERS_CHANGED = Perl_Target_Events.PLAYER_TARGET_CHANGED;
Perl_Target_Events.PARTY_LEADER_CHANGED = Perl_Target_Events.PLAYER_TARGET_CHANGED;
Perl_Target_Events.PARTY_MEMBER_ENABLE = Perl_Target_Events.PLAYER_TARGET_CHANGED;
Perl_Target_Events.PARTY_MEMBER_DISABLE = Perl_Target_Events.PLAYER_TARGET_CHANGED;

function Perl_Target_Events:UNIT_HEALTH()
	if (arg1 == "target") then
		Perl_Target_Update_Health();		-- Update health values
	end
end
Perl_Target_Events.UNIT_MAXHEALTH = Perl_Target_Events.UNIT_HEALTH;

function Perl_Target_Events:UNIT_ENERGY()
	if (arg1 == "target") then
		Perl_Target_Update_Mana();		-- Update energy/mana/rage values
	end
end
Perl_Target_Events.UNIT_MAXENERGY = Perl_Target_Events.UNIT_ENERGY;
Perl_Target_Events.UNIT_MANA = Perl_Target_Events.UNIT_ENERGY;
Perl_Target_Events.UNIT_MAXMANA = Perl_Target_Events.UNIT_ENERGY;
Perl_Target_Events.UNIT_RAGE = Perl_Target_Events.UNIT_ENERGY;
Perl_Target_Events.UNIT_MAXRAGE = Perl_Target_Events.UNIT_ENERGY;
Perl_Target_Events.UNIT_FOCUS = Perl_Target_Events.UNIT_ENERGY;
Perl_Target_Events.UNIT_MAXFOCUS = Perl_Target_Events.UNIT_ENERGY;

function Perl_Target_Events:UNIT_AURA()
	if (arg1 == "target") then
		Perl_Target_Buff_UpdateAll();		-- Update the buffs
	end
end

function Perl_Target_Events:UNIT_DYNAMIC_FLAGS()
	if (arg1 == "target") then
		Perl_Target_Update_Text_Color();	-- Has the target been tapped by someone else?
	end
end

function Perl_Target_Events:UNIT_COMBAT()
	if (arg1 == "target") then
		CombatFeedback_OnCombatEvent(arg2, arg3, arg4, arg5);
	end
end

function Perl_Target_Events:UNIT_SPELLMISS()
	if (arg1 == "target") then
		CombatFeedback_OnSpellMissEvent(arg2);
	end
end

function Perl_Target_Events:UNIT_NAME_UPDATE()
	if (arg1 == "target") then
		Perl_Target_Update_Name();
	end
end

function Perl_Target_Events:UNIT_FACTION()
	Perl_Target_Update_Text_Color();		-- Is the character PvP flagged?
	Perl_Target_Update_PvP_Status_Icon();		-- Set pvp status icon
end
Perl_Target_Events.UNIT_PVP_UPDATE = Perl_Target_Events.UNIT_FACTION;

function Perl_Target_Events:UNIT_PORTRAIT_UPDATE()
	if (arg1 == "target") then
		Perl_Target_Update_Portrait();
	end
end

function Perl_Target_Events:PLAYER_COMBO_POINTS()
	Perl_Target_Update_Combo_Points();		-- How many combo points are we at?
end

function Perl_Target_Events:RAID_TARGET_UPDATE()
	Perl_Target_UpdateRaidTargetIcon();
end

function Perl_Target_Events:UNIT_LEVEL()
	if (arg1 == "target") then
		Perl_Target_Frame_Set_Level();		-- What level is it and is it rare/elite/boss
	end
end

function Perl_Target_Events:UNIT_DISPLAYPOWER()
	if (arg1 == "target") then
		Perl_Target_Update_Mana_Bar();		-- What type of energy are they using now?
		Perl_Target_Update_Mana();		-- Update the energy info immediately
	end
end

function Perl_Target_Events:VARIABLES_LOADED()
	Perl_Target_Initialize();
end
Perl_Target_Events.PLAYER_ENTERING_WORLD = Perl_Target_Events.VARIABLES_LOADED;


-------------------------------
-- Loading Settings Function --
-------------------------------
function Perl_Target_Initialize()
	-- Code to be run after zoning or logging in goes here
	if (Initialized) then
		Perl_Target_Set_Scale();		-- Set the scale
		Perl_Target_Set_Transparency();		-- Set the transparency
		return;
	end

	-- Check if a previous exists, if not, enable by default.
	if (type(Perl_Target_Config[UnitName("player")]) == "table") then
		Perl_Target_GetVars();
	else
		Perl_Target_UpdateVars();
	end

	-- Major config options.
	Perl_Target_Initialize_Frame_Color();		-- Give the borders (and background if applicable) that "Perl" look
	Perl_Target_Frame_Style();			-- Layout the frame according to our mode
	Perl_Target_Portrait_Combat_Text();		-- Are we showing combat text?
	Perl_Target_Buff_Debuff_Background();		-- Do the buffs and debuffs have their transparent background frame?
	Perl_Target_Set_Localized_ClassIcons();		-- Assign class icons to the appropriate classes
	Perl_Target_Frame:Hide();			-- Shouldn't have a target upon logging in so hide the frame

	-- Unregister and Hide the Blizzard frames
	Perl_clearBlizzardFrameDisable(TargetFrame);
	Perl_clearBlizzardFrameDisable(ComboFrame);

	-- MyAddOns Support
	Perl_Target_myAddOns_Support();

	-- IFrameManager Support
	if (IFrameManager) then
		Perl_Target_IFrameManager();
	end

	-- Set the initialization flag
	Initialized = 1;
end

function Perl_Target_IFrameManager()
	local iface = IFrameManager:Interface();
	function iface:getName(frame)
		return "Perl Target";
	end
	function iface:getBorder(frame)
		local bottom, right, top;
		if (showclassframe == 1 or showrareeliteframe == 1) then
			top = 20;
		else
			top = 0;
		end
		if (framestyle == 1) then
			right = 41;
		else
			if (compactmode == 0) then
				right = 60;
			else
				if (compactpercent == 0) then
					if (shortbars == 0) then
						right = -10;
					else
						right = -45;
					end
				else
					if (shortbars == 0) then
						right = 25;
					else
						right = -10;
					end
				end
			end
		end
		if (showportrait == 1) then
			right = right + 55;
		end
		if (showcp == 1) then
			right = right + 21;
		end
		bottom = 0;
		if (invertbuffs == 0) then
			if (numbuffsshown == 0) then
				-- bottom is already 0
			elseif (numbuffsshown < 9) then
				bottom = 24;
			else
				bottom = 48;
			end
			if (numdebuffsshown == 0) then
				-- add nothing to bottom
			elseif (numdebuffsshown < 9) then
				bottom = bottom + 24;
			else
				bottom = bottom + 48;
			end
		else
			if (numbuffsshown == 0) then
				-- top is already set
			elseif (numbuffsshown < 9) then
				top = top + 24;
			else
				top = top + 48;
			end
			if (numdebuffsshown == 0) then
				-- add nothing to top
			elseif (numdebuffsshown < 9) then
				top = top + 24;
			else
				top = top + 48;
			end
		end
		bottom = bottom + 38;	-- Offset for the stats frame
		return top, right, bottom, 0;
	end
	IFrameManager:Register(this, iface);
end

function Perl_Target_Initialize_Frame_Color()
	Perl_Target_StatsFrame:SetBackdropColor(0, 0, 0, 1);
	Perl_Target_StatsFrame:SetBackdropBorderColor(0.5, 0.5, 0.5, 1);
	Perl_Target_NameFrame:SetBackdropColor(0, 0, 0, 1);
	Perl_Target_NameFrame:SetBackdropBorderColor(0.5, 0.5, 0.5, 1);
	Perl_Target_ClassNameFrame:SetBackdropColor(0, 0, 0, 1);
	Perl_Target_ClassNameFrame:SetBackdropBorderColor(0.5, 0.5, 0.5, 1);
	Perl_Target_CivilianFrame:SetBackdropColor(1, 1, 1, 1);
	Perl_Target_CivilianFrame:SetBackdropBorderColor(0.5, 0.5, 0.5, 1);
	Perl_Target_LevelFrame:SetBackdropColor(0, 0, 0, 1);
	Perl_Target_LevelFrame:SetBackdropBorderColor(0.5, 0.5, 0.5, 1);
	Perl_Target_BuffFrame:SetBackdropColor(0, 0, 0, 1);
	Perl_Target_BuffFrame:SetBackdropBorderColor(0.5, 0.5, 0.5, 1);
	Perl_Target_DebuffFrame:SetBackdropColor(0, 0, 0, 1);
	Perl_Target_DebuffFrame:SetBackdropBorderColor(0.5, 0.5, 0.5, 1);
	Perl_Target_CPFrame:SetBackdropColor(0, 0, 0, 1);
	Perl_Target_CPFrame:SetBackdropBorderColor(0.5, 0.5, 0.5, 1);
	Perl_Target_PortraitFrame:SetBackdropColor(0, 0, 0, 1);
	Perl_Target_PortraitFrame:SetBackdropBorderColor(0.5, 0.5, 0.5, 1);
	Perl_Target_RareEliteFrame:SetBackdropColor(0, 0, 0, 1);
	Perl_Target_RareEliteFrame:SetBackdropBorderColor(0.5, 0.5, 0.5, 1);

	Perl_Target_HealthBarText:SetTextColor(1, 1, 1, 1);
	Perl_Target_ManaBarText:SetTextColor(1, 1, 1, 1);
	Perl_Target_ClassNameBarText:SetTextColor(1, 1, 1);
end


--------------------------
-- The Update Functions --
--------------------------
function Perl_Target_Update_Once()
	if (UnitExists("target")) then
		Perl_Target_HealthBarFadeBar:Hide();	-- Hide the fade bars so we don't see fading bars when we shouldn't
		Perl_Target_ManaBarFadeBar:Hide();	-- Hide the fade bars so we don't see fading bars when we shouldn't
		Perl_Target_HealthBar:SetValue(0);	-- Do this so we don't fade the bar on a fresh target switch
		Perl_Target_ManaBar:SetValue(0);	-- Do this so we don't fade the bar on a fresh target switch
		Perl_Target_Update_Combo_Points();	-- Do we have any combo points (we shouldn't)
		Perl_Target_Update_Portrait();		-- Set the target's portrait and adjust the combo point frame
		Perl_Target_Update_Health();		-- Set the target's health
		Perl_Target_Update_Mana_Bar();		-- What type of mana bar is it?
		Perl_Target_Update_Mana();		-- Set the target's mana
		Perl_Target_Update_PvP_Status_Icon();	-- Set pvp status icon
		Perl_Target_Frame_Set_Level();		-- What level is it and is it rare/elite/boss
		Perl_Target_Buff_UpdateAll();		-- Update the buffs
		Perl_Target_UpdateRaidTargetIcon();	-- Display the raid target icon if needed
		Perl_Target_Update_Name();		-- Update the name
		Perl_Target_Update_Text_Color();	-- Has the target been tapped by someone else?

		-- Begin: Draw the class icon?
		if (showclassicon == 1) then
			if (UnitIsPlayer("target")) then
				localizedclass = UnitClass("target");
				Perl_Target_ClassTexture:SetTexCoord(Perl_Target_ClassPosRight[localizedclass], Perl_Target_ClassPosLeft[localizedclass], Perl_Target_ClassPosTop[localizedclass], Perl_Target_ClassPosBottom[localizedclass]);
				Perl_Target_ClassTexture:Show();
			else
				Perl_Target_ClassTexture:Hide();
			end
		else
			Perl_Target_ClassTexture:Hide();
		end
		-- End: Draw the class icon?

		-- Begin: Set the target's class in the class frame
		if (showclassframe == 1) then
			if (UnitIsPlayer("target")) then
				Perl_Target_ClassNameBarText:SetText(UnitClass("target"));
				Perl_Target_ClassNameFrame:Show();
				Perl_Target_CivilianFrame:Hide();
			else
				creatureType = UnitCreatureType("target");
				if (creatureType == PERL_LOCALIZED_NOTSPECIFIED) then
					creatureType = PERL_LOCALIZED_CREATURE;
				end
				Perl_Target_ClassNameBarText:SetText(creatureType);
				Perl_Target_ClassNameFrame:Show();

				if (UnitIsCivilian("target")) then
					Perl_Target_CivilianBarText:SetText(PERL_LOCALIZED_CIVILIAN);
					Perl_Target_CivilianBarText:SetTextColor(1, 0, 0);
					Perl_Target_CivilianFrame:Show();
				else
					Perl_Target_CivilianFrame:Hide();
				end
			end
		else
			Perl_Target_ClassNameFrame:Hide();
			Perl_Target_CivilianFrame:Hide();
		end
		-- End: Set the target's class in the class frame

		-- Begin: Set the pvp rank icon
		if (showpvprank == 1) then
			if (UnitIsPlayer("target")) then
				local rankNumber = UnitPVPRank("target");
				if (rankNumber == 0) then
					Perl_Target_PVPRank:Hide();
				elseif (rankNumber < 14) then
					rankNumber = rankNumber - 4;
					Perl_Target_PVPRank:SetTexture("Interface\\PvPRankBadges\\PvPRank0"..rankNumber);
					Perl_Target_PVPRank:Show();
				else
					rankNumber = rankNumber - 4;
					Perl_Target_PVPRank:SetTexture("Interface\\PvPRankBadges\\PvPRank"..rankNumber);
					Perl_Target_PVPRank:Show();
				end
			else
				Perl_Target_PVPRank:Hide();
			end
		else
			Perl_Target_PVPRank:Hide();
		end
		-- End: Set the pvp rank icon

		-- Begin: Set the text positions
		Perl_Target_HealthBarText:ClearAllPoints();
		Perl_Target_ManaBarText:ClearAllPoints();
		if (framestyle == 1) then
			Perl_Target_HealthBarText:SetPoint("TOP", 0, 1);
			Perl_Target_ManaBarText:SetPoint("TOP", 0, 1);
		elseif (framestyle == 2) then
			if (compactmode == 0) then
				Perl_Target_HealthBarText:SetPoint("TOP", 0, 1);
				Perl_Target_ManaBarText:SetPoint("TOP", 0, 1);
				Perl_Target_HealthBarTextRight:SetPoint("RIGHT", 70, 0);
				Perl_Target_ManaBarTextRight:SetPoint("RIGHT", 70, 0);
			else
				if (healermode == 0) then
					Perl_Target_HealthBarText:SetPoint("TOP", 0, 1);
					Perl_Target_ManaBarText:SetPoint("TOP", 0, 1);
				else
					Perl_Target_HealthBarText:SetPoint("TOPLEFT", 5, 1);
					Perl_Target_ManaBarText:SetPoint("TOPLEFT", 5, 1);
					Perl_Target_HealthBarTextRight:SetPoint("RIGHT", -5, 0);
					Perl_Target_ManaBarTextRight:SetPoint("RIGHT", -5, 0);
				end
			end
		end
		-- End: Set the text positions

		Perl_Target_Frame:Show();		-- Show frame
	end
end

function Perl_Target_Update_Health()
	targethealth = UnitHealth("target");
	targethealthmax = UnitHealthMax("target");
	targethealthpercent = floor(targethealth/targethealthmax*100+0.5);

	if (UnitIsDead("target") or UnitIsGhost("target")) then				-- This prevents negative health
		targethealth = 0;
		targethealthpercent = 0;
	end

	-- Set Dead Icon
	if (UnitIsDead("target") or UnitIsGhost("target")) then
		Perl_Target_DeadStatus:Show();
	else
		Perl_Target_DeadStatus:Hide();
	end

	if (PCUF_FADEBARS == 1) then
		if (targethealth < Perl_Target_HealthBar:GetValue()) then
			Perl_Target_HealthBarFadeBar:SetMinMaxValues(0, targethealthmax);
			Perl_Target_HealthBarFadeBar:SetValue(Perl_Target_HealthBar:GetValue());
			Perl_Target_HealthBarFadeBar:Show();
			Perl_Target_HealthBar_Fade_Color = 1;
			Perl_Target_HealthBar_Fade_Time_Elapsed = 0;
			Perl_Target_HealthBar_Fade_OnUpdate_Frame:Show();
		end
	end

	Perl_Target_HealthBar:SetMinMaxValues(0, targethealthmax);
	if (PCUF_INVERTBARVALUES == 1) then
		Perl_Target_HealthBar:SetValue(targethealthmax - targethealth);
	else
		Perl_Target_HealthBar:SetValue(targethealth);
	end

	if (PCUF_COLORHEALTH == 1) then
--		if ((targethealthpercent <= 100) and (targethealthpercent > 75)) then
--			Perl_Target_HealthBar:SetStatusBarColor(0, 0.8, 0);
--			Perl_Target_HealthBarBG:SetStatusBarColor(0, 0.8, 0, 0.25);
--		elseif ((targethealthpercent <= 75) and (targethealthpercent > 50)) then
--			Perl_Target_HealthBar:SetStatusBarColor(1, 1, 0);
--			Perl_Target_HealthBarBG:SetStatusBarColor(1, 1, 0, 0.25);
--		elseif ((targethealthpercent <= 50) and (targethealthpercent > 25)) then
--			Perl_Target_HealthBar:SetStatusBarColor(1, 0.5, 0);
--			Perl_Target_HealthBarBG:SetStatusBarColor(1, 0.5, 0, 0.25);
--		else
--			Perl_Target_HealthBar:SetStatusBarColor(1, 0, 0);
--			Perl_Target_HealthBarBG:SetStatusBarColor(1, 0, 0, 0.25);
--		end

		local rawpercent = targethealth / targethealthmax;
		local red, green;

		if(rawpercent > 0.5) then
			red = (1.0 - rawpercent) * 2;
			green = 1.0;
		else
			red = 1.0;
			green = rawpercent * 2;
		end

		Perl_Target_HealthBar:SetStatusBarColor(red, green, 0, 1);
		Perl_Target_HealthBarBG:SetStatusBarColor(red, green, 0, 0.25);
	else
		Perl_Target_HealthBar:SetStatusBarColor(0, 0.8, 0);
		Perl_Target_HealthBarBG:SetStatusBarColor(0, 0.8, 0, 0.25);
	end

	if (targethealthmax == 100) then
		-- Begin Mobhealth support
		if (mobhealthsupport == 1) then
			if (MobHealth3) then
				targethealth, targethealthmax, mobhealththreenumerics = MobHealth3:GetUnitHealth("target", UnitHealth("target"), UnitHealthMax("target"), UnitName("target"), UnitLevel("target"));
				if (mobhealththreenumerics) then
					-- MobHealth3 was successful in getting a numeric value
					if (framestyle == 1) then
						Perl_Target_HealthBarTextRight:SetText();							-- Hide this text in this frame style
						Perl_Target_HealthBarTextCompactPercent:SetText();						-- Hide this text in this frame style
						Perl_Target_HealthBarText:SetText(targethealth.."/"..targethealthmax.." | "..targethealthpercent.."%");
					elseif (framestyle == 2) then
						if (compactmode == 0) then
							Perl_Target_HealthBarTextCompactPercent:SetText();					-- Hide this text in this frame style
							if (targethealthmax > 9999) then
								Perl_Target_HealthBarText:SetText(targethealth.."/"..targethealthmax);
								Perl_Target_HealthBarTextRight:SetText(targethealthpercent.."%");
							else
								Perl_Target_HealthBarText:SetText(targethealthpercent.."%");
								Perl_Target_HealthBarTextRight:SetText(targethealth.."/"..targethealthmax);
							end
							
						else
							if (compactpercent == 0) then
								Perl_Target_HealthBarTextRight:SetText();					-- Hide this text in this frame style
								Perl_Target_HealthBarTextCompactPercent:SetText();				-- Hide this text in this frame style
								Perl_Target_HealthBarText:SetText(targethealth.."/"..targethealthmax);
							else
								Perl_Target_HealthBarTextRight:SetText();					-- Hide this text in this frame style
								Perl_Target_HealthBarText:SetText(targethealth.."/"..targethealthmax);
								Perl_Target_HealthBarTextCompactPercent:SetText(targethealthpercent.."%");
							end
						end
					end
				else
					-- MobHealth3 was unable to give us a numeric value, fall back to percentage
					if (framestyle == 1) then
						Perl_Target_HealthBarTextRight:SetText();							-- Hide this text in this frame style
						Perl_Target_HealthBarTextCompactPercent:SetText();						-- Hide this text in this frame style
						Perl_Target_HealthBarText:SetText(targethealth.."%");
					elseif (framestyle == 2) then
						if (compactmode == 0) then
							Perl_Target_HealthBarTextCompactPercent:SetText();					-- Hide this text in this frame style
							Perl_Target_HealthBarText:SetText(targethealth.."%");
							Perl_Target_HealthBarTextRight:SetText(targethealth.."%");
						else
							if (compactpercent == 0) then
								Perl_Target_HealthBarTextRight:SetText();					-- Hide this text in this frame style
								Perl_Target_HealthBarTextCompactPercent:SetText();				-- Hide this text in this frame style
								Perl_Target_HealthBarText:SetText(targethealth.."%");
							else
								Perl_Target_HealthBarTextRight:SetText();					-- Hide this text in this frame style
								Perl_Target_HealthBarText:SetText(targethealth.."%");
								Perl_Target_HealthBarTextCompactPercent:SetText(targethealth.."%");
							end
						end
					end
				end
			elseif (MobHealthFrame) then	-- mobhealth2, telo, and mobinfo
				MobHealthFrame:Hide();

				local index;
				if UnitIsPlayer("target") then
					index = UnitName("target");
				else
					index = UnitName("target")..":"..UnitLevel("target");
				end

				if ((MobHealthDB and MobHealthDB[index]) or (MobHealthPlayerDB and MobHealthPlayerDB[index])) then
					local s, e;
					local pts;
					local pct;

					if MobHealthDB[index] then
						if (type(MobHealthDB[index]) ~= "string") then
							Perl_Target_HealthBarText:SetText(targethealth.."%");
						end
						s, e, pts, pct = string.find(MobHealthDB[index], "^(%d+)/(%d+)$");
					else
						if (type(MobHealthPlayerDB[index]) ~= "string") then
							Perl_Target_HealthBarText:SetText(targethealth.."%");
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

					local currentPct = UnitHealth("target");
					if (pointsPerPct > 0) then
						-- Stored unit info from the DB
						if (framestyle == 1) then
							Perl_Target_HealthBarTextRight:SetText();							-- Hide this text in this frame style
							Perl_Target_HealthBarTextCompactPercent:SetText();						-- Hide this text in this frame style
							Perl_Target_HealthBarText:SetText(string.format("%d", (currentPct * pointsPerPct) + 0.5).."/"..string.format("%d", (100 * pointsPerPct) + 0.5).." | "..targethealth.."%");
						elseif (framestyle == 2) then
							if (compactmode == 0) then
								Perl_Target_HealthBarTextCompactPercent:SetText();					-- Hide this text in this frame style
								if (tonumber(string.format("%d", (100 * pointsPerPct) + 0.5)) > 9999) then
									Perl_Target_HealthBarText:SetText(string.format("%d", (currentPct * pointsPerPct) + 0.5).."/"..string.format("%d", (100 * pointsPerPct) + 0.5));
									Perl_Target_HealthBarTextRight:SetText(targethealth.."%");
								else
									Perl_Target_HealthBarText:SetText(targethealth.."%");
									Perl_Target_HealthBarTextRight:SetText(string.format("%d", (currentPct * pointsPerPct) + 0.5).."/"..string.format("%d", (100 * pointsPerPct) + 0.5));
								end
								
							else
								if (compactpercent == 0) then
									Perl_Target_HealthBarTextRight:SetText();					-- Hide this text in this frame style
									Perl_Target_HealthBarTextCompactPercent:SetText();				-- Hide this text in this frame style
									Perl_Target_HealthBarText:SetText(string.format("%d", (currentPct * pointsPerPct) + 0.5).."/"..string.format("%d", (100 * pointsPerPct) + 0.5));
								else
									Perl_Target_HealthBarTextRight:SetText();					-- Hide this text in this frame style
									Perl_Target_HealthBarText:SetText(string.format("%d", (currentPct * pointsPerPct) + 0.5).."/"..string.format("%d", (100 * pointsPerPct) + 0.5));
									Perl_Target_HealthBarTextCompactPercent:SetText(targethealth.."%");
								end
							end
						end
					end
				else
					-- Unit not in MobHealth DB
					if (framestyle == 1) then	-- This chunk of code is the same as the next two blocks in case you customize this
						Perl_Target_HealthBarTextRight:SetText();							-- Hide this text in this frame style
						Perl_Target_HealthBarTextCompactPercent:SetText();						-- Hide this text in this frame style
						Perl_Target_HealthBarText:SetText(targethealth.."%");
					elseif (framestyle == 2) then
						if (compactmode == 0) then
							Perl_Target_HealthBarTextCompactPercent:SetText();					-- Hide this text in this frame style
							Perl_Target_HealthBarText:SetText(targethealth.."%");
							Perl_Target_HealthBarTextRight:SetText(targethealth.."%");
						else
							if (compactpercent == 0) then
								Perl_Target_HealthBarTextRight:SetText();					-- Hide this text in this frame style
								Perl_Target_HealthBarTextCompactPercent:SetText();				-- Hide this text in this frame style
								Perl_Target_HealthBarText:SetText(targethealth.."%");
							else
								Perl_Target_HealthBarTextRight:SetText();					-- Hide this text in this frame style
								Perl_Target_HealthBarText:SetText(targethealth.."%");
								Perl_Target_HealthBarTextCompactPercent:SetText(targethealth.."%");
							end
						end
					end
				end
			-- End MobHealth Support
			else
				-- MobHealth isn't installed
				if (framestyle == 1) then
					Perl_Target_HealthBarTextRight:SetText();							-- Hide this text in this frame style
					Perl_Target_HealthBarTextCompactPercent:SetText();						-- Hide this text in this frame style
					Perl_Target_HealthBarText:SetText(targethealth.."%");
				elseif (framestyle == 2) then
					if (compactmode == 0) then
						Perl_Target_HealthBarTextCompactPercent:SetText();					-- Hide this text in this frame style
						Perl_Target_HealthBarText:SetText(targethealth.."%");
						Perl_Target_HealthBarTextRight:SetText(targethealth.."%");
					else
						if (compactpercent == 0) then
							Perl_Target_HealthBarTextRight:SetText();					-- Hide this text in this frame style
							Perl_Target_HealthBarTextCompactPercent:SetText();				-- Hide this text in this frame style
							Perl_Target_HealthBarText:SetText(targethealth.."%");
						else
							Perl_Target_HealthBarTextRight:SetText();					-- Hide this text in this frame style
							Perl_Target_HealthBarText:SetText(targethealth.."%");
							Perl_Target_HealthBarTextCompactPercent:SetText(targethealth.."%");
						end
					end
				end
			end
		else	-- mobhealthsupport == 0
			if (MobHealthFrame) then
				MobHealthFrame:Show();
			end

			-- MobHealth support is disabled
			if (framestyle == 1) then
				Perl_Target_HealthBarTextRight:SetText();							-- Hide this text in this frame style
				Perl_Target_HealthBarTextCompactPercent:SetText();						-- Hide this text in this frame style
				Perl_Target_HealthBarText:SetText(targethealth.."%");
			elseif (framestyle == 2) then
				if (compactmode == 0) then
					Perl_Target_HealthBarTextCompactPercent:SetText();					-- Hide this text in this frame style
					Perl_Target_HealthBarText:SetText(targethealth.."%");
					Perl_Target_HealthBarTextRight:SetText(targethealth.."%");
				else
					if (compactpercent == 0) then
						Perl_Target_HealthBarTextRight:SetText();					-- Hide this text in this frame style
						Perl_Target_HealthBarTextCompactPercent:SetText();				-- Hide this text in this frame style
						Perl_Target_HealthBarText:SetText(targethealth.."%");
					else
						Perl_Target_HealthBarTextRight:SetText();					-- Hide this text in this frame style
						Perl_Target_HealthBarText:SetText(targethealth.."%");
						Perl_Target_HealthBarTextCompactPercent:SetText(targethealth.."%");
					end
				end
			end
		end
	else
		-- Self/Party/Raid member
		if (framestyle == 1) then
			Perl_Target_HealthBarTextRight:SetText();							-- Hide this text in this frame style
			Perl_Target_HealthBarTextCompactPercent:SetText();						-- Hide this text in this frame style
			Perl_Target_HealthBarText:SetText(targethealth.."/"..targethealthmax);
		elseif (framestyle == 2) then
			if (compactmode == 0) then
				if (healermode == 0) then
					Perl_Target_HealthBarTextCompactPercent:SetText();					-- Hide this text in this frame style
					Perl_Target_HealthBarText:SetText(targethealthpercent.."%");
					Perl_Target_HealthBarTextRight:SetText(targethealth.."/"..targethealthmax);
				else
					Perl_Target_HealthBarTextCompactPercent:SetText();					-- Hide this text in this frame style
					Perl_Target_HealthBarText:SetText(targethealth.."/"..targethealthmax);
					Perl_Target_HealthBarTextRight:SetText("-"..targethealthmax - targethealth);
				end
				
			else
				if (compactpercent == 0) then
					if (healermode == 0) then
						Perl_Target_HealthBarTextRight:SetText();					-- Hide this text in this frame style
						Perl_Target_HealthBarTextCompactPercent:SetText();				-- Hide this text in this frame style
					else
						Perl_Target_HealthBarTextRight:SetText("-"..targethealthmax - targethealth);
						Perl_Target_HealthBarTextCompactPercent:SetText();				-- Hide this text in this frame style
					end
					Perl_Target_HealthBarText:SetText(targethealth.."/"..targethealthmax);
				else
					if (healermode == 0) then
						Perl_Target_HealthBarTextRight:SetText();					-- Hide this text in this frame style
					else
						Perl_Target_HealthBarTextRight:SetText("-"..targethealthmax - targethealth);
					end
					Perl_Target_HealthBarText:SetText(targethealth.."/"..targethealthmax);
					Perl_Target_HealthBarTextCompactPercent:SetText(targethealthpercent.."%");
				end
			end
		end
	end

	if (UnitIsDead("target")) then
		if (UnitIsPlayer("target")) then
			if (UnitClass("target") == PERL_LOCALIZED_HUNTER) then	-- If the dead is a hunter, check for Feign Death
				local buffnum = 1;
				local buffTexture = UnitBuff("target", buffnum);
				while (buffTexture) do
					if (buffTexture == "Interface\\Icons\\Ability_Rogue_FeignDeath") then
						Perl_Target_HealthBarText:SetText(PERL_LOCALIZED_STATUS_FEIGNDEATH);
						break;
					end
					buffnum = buffnum + 1;
					buffTexture = UnitBuff("target", buffnum);
				end
			end
		end
	end
end

function Perl_Target_Update_Mana()
	targetmana = UnitMana("target");
	targetmanamax = UnitManaMax("target");
	targetpower = UnitPowerType("target");

	if (UnitIsDead("target") or UnitIsGhost("target")) then				-- This prevents negative mana
		targetmana = 0;
	end

	if (PCUF_FADEBARS == 1) then
		if (targetmana < Perl_Target_ManaBar:GetValue()) then
			Perl_Target_ManaBarFadeBar:SetMinMaxValues(0, targetmanamax);
			Perl_Target_ManaBarFadeBar:SetValue(Perl_Target_ManaBar:GetValue());
			Perl_Target_ManaBarFadeBar:Show();
			Perl_Target_ManaBar_Fade_Color = 1;
			Perl_Target_ManaBar_Fade_Time_Elapsed = 0;
			Perl_Target_ManaBar_Fade_OnUpdate_Frame:Show();
		end
	end

	Perl_Target_ManaBar:SetMinMaxValues(0, targetmanamax);
	if (PCUF_INVERTBARVALUES == 1) then
		Perl_Target_ManaBar:SetValue(targetmanamax - targetmana);
	else
		Perl_Target_ManaBar:SetValue(targetmana);
	end

	if (framestyle == 1) then
		Perl_Target_ManaBarTextRight:SetTextColor(1, 1, 1, 1);
		Perl_Target_ManaBarTextRight:SetText();			-- Hide this text in this frame style
		Perl_Target_ManaBarTextCompactPercent:SetText();	-- Hide this text in this frame style

		if (targetpower == 1 or targetpower == 2) then
			Perl_Target_ManaBarText:SetText(targetmana);
		else
			Perl_Target_ManaBarText:SetText(targetmana.."/"..targetmanamax);
		end
	elseif (framestyle == 2) then
		targetmanapercent = floor(targetmana/targetmanamax*100+0.5);

		if (compactmode == 0) then
			Perl_Target_ManaBarTextCompactPercent:SetText();	-- Hide this text in this frame style

			if (healermode == 0) then
				Perl_Target_ManaBarTextRight:SetTextColor(1, 1, 1, 1);
				if (targetpower == 1 or targetpower == 2) then
					Perl_Target_ManaBarText:SetText(targetmana.."%");
					Perl_Target_ManaBarTextRight:SetText(targetmana);
				else
					Perl_Target_ManaBarText:SetText(targetmanapercent.."%");
					Perl_Target_ManaBarTextRight:SetText(targetmana.."/"..targetmanamax);
				end
			else
				Perl_Target_ManaBarTextRight:SetTextColor(0.5, 0.5, 0.5, 1);
				if (showmanadeficit == 1) then
					Perl_Target_ManaBarTextRight:SetText("-"..targetmanamax - targetmana);
				else
					Perl_Target_ManaBarTextRight:SetText();
				end
				if (targetpower == 1 or targetpower == 2) then
					Perl_Target_ManaBarText:SetText(targetmana);
				else
					Perl_Target_ManaBarText:SetText(targetmana.."/"..targetmanamax);
				end
			end
		else
			if (compactpercent == 0) then
				Perl_Target_ManaBarTextCompactPercent:SetText();	-- Hide this text in this frame style
				if (healermode == 1) then
					if (showmanadeficit == 1) then
						Perl_Target_ManaBarTextRight:SetTextColor(0.5, 0.5, 0.5, 1);
						Perl_Target_ManaBarTextRight:SetText("-"..targetmanamax - targetmana);			-- Hide this text in this frame style
					else
						Perl_Target_ManaBarTextRight:SetText();			-- Hide this text in this frame style
					end
				else
					Perl_Target_ManaBarTextRight:SetText();			-- Hide this text in this frame style
				end
				if (targetpower == 1 or targetpower == 2) then
					Perl_Target_ManaBarText:SetText(targetmana);
				else
					Perl_Target_ManaBarText:SetText(targetmana.."/"..targetmanamax);
				end
			else
				if (healermode == 1) then
					if (showmanadeficit == 1) then
						Perl_Target_ManaBarTextRight:SetTextColor(0.5, 0.5, 0.5, 1);
						Perl_Target_ManaBarTextRight:SetText("-"..targetmanamax - targetmana);			-- Hide this text in this frame style
					else
						Perl_Target_ManaBarTextRight:SetText();			-- Hide this text in this frame style
					end
				else
					Perl_Target_ManaBarTextRight:SetText();			-- Hide this text in this frame style
				end

				if (targetpower == 1 or targetpower == 2) then
					Perl_Target_ManaBarText:SetText(targetmana);
					Perl_Target_ManaBarTextCompactPercent:SetText(targetmana.."%");
				else
					Perl_Target_ManaBarText:SetText(targetmana.."/"..targetmanamax);
					Perl_Target_ManaBarTextCompactPercent:SetText(targetmanapercent.."%");
				end
			end
		end
	end
end

function Perl_Target_Update_Mana_Bar()
	targetpower = UnitPowerType("target");

	-- Set mana bar color
	if (UnitManaMax("target") == 0) then
		Perl_Target_ManaBar:Hide();
		Perl_Target_ManaBarBG:Hide();
		Perl_Target_StatsFrame:SetHeight(30);
		Perl_Target_StatsFrame_CastClickOverlay:SetHeight(30);
	elseif (targetpower == 1) then
		Perl_Target_ManaBar:SetStatusBarColor(1, 0, 0, 1);
		Perl_Target_ManaBarBG:SetStatusBarColor(1, 0, 0, 0.25);
		Perl_Target_ManaBar:Show();
		Perl_Target_ManaBarBG:Show();
		Perl_Target_StatsFrame:SetHeight(42);
		Perl_Target_StatsFrame_CastClickOverlay:SetHeight(42);
	elseif (targetpower == 2) then
		Perl_Target_ManaBar:SetStatusBarColor(1, 0.5, 0, 1);
		Perl_Target_ManaBarBG:SetStatusBarColor(1, 0.5, 0, 0.25);
		Perl_Target_ManaBar:Show();
		Perl_Target_ManaBarBG:Show();
		Perl_Target_StatsFrame:SetHeight(42);
		Perl_Target_StatsFrame_CastClickOverlay:SetHeight(42);
	elseif (targetpower == 3) then
		Perl_Target_ManaBar:SetStatusBarColor(1, 1, 0, 1);
		Perl_Target_ManaBarBG:SetStatusBarColor(1, 1, 0, 0.25);
		Perl_Target_ManaBar:Show();
		Perl_Target_ManaBarBG:Show();
		Perl_Target_StatsFrame:SetHeight(42);
		Perl_Target_StatsFrame_CastClickOverlay:SetHeight(42);
	else
		Perl_Target_ManaBar:SetStatusBarColor(0, 0, 1, 1);
		Perl_Target_ManaBarBG:SetStatusBarColor(0, 0, 1, 0.25);
		Perl_Target_ManaBar:Show();
		Perl_Target_ManaBarBG:Show();
		Perl_Target_StatsFrame:SetHeight(42);
		Perl_Target_StatsFrame_CastClickOverlay:SetHeight(42);
	end
end

function Perl_Target_Update_Combo_Points()
	local combopoints = GetComboPoints();				-- How many Combo Points does the player have?

	if (showcp == 1) then
		Perl_Target_CPText:SetText(combopoints);
		Perl_Target_CPText:SetTextHeight(20);
		if (combopoints == 5) then
			Perl_Target_CPFrame:Show();
			Perl_Target_CPText:SetTextColor(1, 0, 0);	-- red text
		elseif (combopoints == 4) then
			Perl_Target_CPFrame:Show();
			Perl_Target_CPText:SetTextColor(1, 0.5, 0);	-- orange text
		elseif (combopoints == 3) then
			Perl_Target_CPFrame:Show();
			Perl_Target_CPText:SetTextColor(1, 1, 0);	-- yellow text
		elseif (combopoints == 2) then
			Perl_Target_CPFrame:Show();
			Perl_Target_CPText:SetTextColor(0.5, 1, 0);	-- yellow-green text
		elseif (combopoints == 1) then
			Perl_Target_CPFrame:Show();
			Perl_Target_CPText:SetTextColor(0, 1, 0);	-- green text
		else
			Perl_Target_CPFrame:Hide();
		end
	else
		Perl_Target_CPFrame:Hide();
	end

	if (nameframecombopoints == 1) then				-- this isn't nested since you can have both combo point styles on at the same time
		Perl_Target_NameFrame_CPMeter:SetMinMaxValues(0, 5);
		Perl_Target_NameFrame_CPMeter:SetValue(combopoints);
		if (combopoints == 5) then
			Perl_Target_NameFrame_CPMeter:Show();
			
		elseif (combopoints == 4) then
			Perl_Target_NameFrame_CPMeter:Show();
		elseif (combopoints == 3) then
			Perl_Target_NameFrame_CPMeter:Show();
		elseif (combopoints == 2) then
			Perl_Target_NameFrame_CPMeter:Show();
		elseif (combopoints == 1) then
			Perl_Target_NameFrame_CPMeter:Show();
		else
			Perl_Target_NameFrame_CPMeter:Hide();
		end
	else
		Perl_Target_NameFrame_CPMeter:Hide();
	end
end

function Perl_Target_Update_PvP_Status_Icon()
	if (showpvpicon == 1) then
		if (UnitIsPVPFreeForAll("target")) then
			Perl_Target_PVPStatus:SetTexture("Interface\\TargetingFrame\\UI-PVP-FFA");
			Perl_Target_PVPStatus:Show();
		elseif (UnitFactionGroup("target") and UnitIsPVP("target")) then
			Perl_Target_PVPStatus:SetTexture("Interface\\TargetingFrame\\UI-PVP-"..UnitFactionGroup("target"));
			Perl_Target_PVPStatus:Show();
		else
			Perl_Target_PVPStatus:Hide();
		end
	else
		Perl_Target_PVPStatus:Hide();
	end
end

function Perl_Target_Update_Name()
	targetname = UnitName("target");
	namelengthrestrictor = 0;

	if (GetLocale() == "koKR") then
		if (framestyle == 1) then
			namelengthrestrictor = 38;
		elseif (framestyle == 2) then
			if (compactmode == 0) then
				namelengthrestrictor = 36;
			else
				if (compactpercent == 0) then
					if (shortbars == 0) then
						namelengthrestrictor = 24;
					else
						namelengthrestrictor = 12;
					end
				else
					if (shortbars == 0) then
						namelengthrestrictor = 34;
					else
						namelengthrestrictor = 24;
					end
				end
			end
		end
	elseif (GetLocale() == "zhCN") then
		if (framestyle == 1) then
			namelengthrestrictor = 32;
		elseif (framestyle == 2) then
			if (compactmode == 0) then
				namelengthrestrictor = 30;
			else
				if (compactpercent == 0) then
					if (shortbars == 0) then
						namelengthrestrictor = 20;
					else
						namelengthrestrictor = 14;
					end
				else
					if (shortbars == 0) then
						namelengthrestrictor = 25;
					else
						namelengthrestrictor = 21;
					end
				end
			end
		end
	else
		if (framestyle == 1) then
			namelengthrestrictor = 16;
		elseif (framestyle == 2) then
			if (compactmode == 0) then
				namelengthrestrictor = 18;
			else
				if (compactpercent == 0) then
					if (shortbars == 0) then
						namelengthrestrictor = 8;
					else
						namelengthrestrictor = 2;
					end
				else
					if (shortbars == 0) then
						namelengthrestrictor = 13;
					else
						namelengthrestrictor = 9;
					end
				end
			end
		end
	end

	if (UnitIsPlayer("target")) then
		if (showpvprank == 0) then
			if (showpvpicon == 1) then
				namelengthrestrictor = namelengthrestrictor + 2;
			else
				namelengthrestrictor = namelengthrestrictor + 4;
			end
		end
		if (showclassicon == 1) then
			Perl_Target_NameBarText:SetPoint("LEFT", "Perl_Target_ClassTexture", "RIGHT", 5, 0);
		else
			namelengthrestrictor = namelengthrestrictor + 3;
			Perl_Target_NameBarText:SetPoint("LEFT", "Perl_Target_ClassTexture", "RIGHT", -10, 0);
		end
	else
		if (UnitIsPVP("target") and showpvpicon == 1) then
			namelengthrestrictor = namelengthrestrictor + 4;
		else
			namelengthrestrictor = namelengthrestrictor + 7;
		end
		Perl_Target_NameBarText:SetPoint("LEFT", "Perl_Target_ClassTexture", "RIGHT", -10, 0);
	end

	if (strlen(targetname) > (namelengthrestrictor + 1)) then
		targetname = strsub(targetname, 1, namelengthrestrictor).."...";
	end

	Perl_Target_NameBarText:SetText(targetname);
end

function Perl_Target_Update_Text_Color()
	if (classcolorednames == 0) then
		if (UnitPlayerControlled("target")) then					-- is it a player
			if (UnitCanAttack("target", "player")) then				-- are we in an enemy controlled zone
				-- Hostile players are red
				if (not UnitCanAttack("player", "target")) then			-- enemy is not pvp enabled
					r = 0.5;
					g = 0.5;
					b = 1.0;
				else								-- enemy is pvp enabled
					r = 1.0;
					g = 0.0;
					b = 0.0;
				end
			elseif (UnitCanAttack("player", "target")) then				-- enemy in a zone controlled by friendlies or when we're a ghost
				-- Players we can attack but which are not hostile are yellow
				r = 1.0;
				g = 1.0;
				b = 0.0;
			elseif (UnitIsPVP("target")) then					-- friendly pvp enabled character
				-- Players we can assist but are PvP flagged are green
				r = 0.0;
				g = 1.0;
				b = 0.0;
			else									-- friendly non pvp enabled character
				-- All other players are blue (the usual state on the "blue" server)
				r = 0.5;
				g = 0.5;
				b = 1.0;
			end
			Perl_Target_NameBarText:SetTextColor(r, g, b);
		elseif (UnitIsTapped("target") and not UnitIsTappedByPlayer("target")) then
			Perl_Target_NameBarText:SetTextColor(0.5, 0.5, 0.5);			-- not our tap
		else
			if (UnitIsVisible("target")) then
				local reaction = UnitReaction("target", "player");
				if (reaction) then
					r = UnitReactionColor[reaction].r;
					g = UnitReactionColor[reaction].g;
					b = UnitReactionColor[reaction].b;
					Perl_Target_NameBarText:SetTextColor(r, g, b);
				else
					Perl_Target_NameBarText:SetTextColor(0.5, 0.5, 1.0);
				end
			else
				if (UnitCanAttack("target", "player")) then				-- are we in an enemy controlled zone
					-- Hostile players are red
					if (not UnitCanAttack("player", "target")) then			-- enemy is not pvp enabled
						r = 0.5;
						g = 0.5;
						b = 1.0;
					else								-- enemy is pvp enabled
						r = 1.0;
						g = 0.0;
						b = 0.0;
					end
				elseif (UnitCanAttack("player", "target")) then				-- enemy in a zone controlled by friendlies or when we're a ghost
					-- Players we can attack but which are not hostile are yellow
					r = 1.0;
					g = 1.0;
					b = 0.0;
				elseif (UnitIsPVP("target")) then					-- friendly pvp enabled character
					-- Players we can assist but are PvP flagged are green
					r = 0.0;
					g = 1.0;
					b = 0.0;
				else									-- friendly non pvp enabled character
					-- All other players are blue (the usual state on the "blue" server)
					r = 0.5;
					g = 0.5;
					b = 1.0;
				end
				Perl_Target_NameBarText:SetTextColor(r, g, b);
			end
			
		end
	else
		if (UnitIsPlayer("target")) then
			if (UnitClass("target") == PERL_LOCALIZED_WARRIOR) then
				Perl_Target_NameBarText:SetTextColor(0.78, 0.61, 0.43);
			elseif (UnitClass("target") == PERL_LOCALIZED_MAGE) then
				Perl_Target_NameBarText:SetTextColor(0.41, 0.8, 0.94);
			elseif (UnitClass("target") == PERL_LOCALIZED_ROGUE) then
				Perl_Target_NameBarText:SetTextColor(1, 0.96, 0.41);
			elseif (UnitClass("target") == PERL_LOCALIZED_DRUID) then
				Perl_Target_NameBarText:SetTextColor(1, 0.49, 0.04);
			elseif (UnitClass("target") == PERL_LOCALIZED_HUNTER) then
				Perl_Target_NameBarText:SetTextColor(0.67, 0.83, 0.45);
			elseif (UnitClass("target") == PERL_LOCALIZED_SHAMAN) then
				Perl_Target_NameBarText:SetTextColor(0.96, 0.55, 0.73);
			elseif (UnitClass("target") == PERL_LOCALIZED_PRIEST) then
				Perl_Target_NameBarText:SetTextColor(1, 1, 1);
			elseif (UnitClass("target") == PERL_LOCALIZED_WARLOCK) then
				Perl_Target_NameBarText:SetTextColor(0.58, 0.51, 0.79);
			elseif (UnitClass("target") == PERL_LOCALIZED_PALADIN) then
				Perl_Target_NameBarText:SetTextColor(0.96, 0.55, 0.73);
			end
		else
			if (UnitIsTapped("target") and not UnitIsTappedByPlayer("target")) then
				Perl_Target_NameBarText:SetTextColor(0.5, 0.5, 0.5);			-- not our tap
			else
				if (UnitIsVisible("target")) then
					local reaction = UnitReaction("target", "player");
					if (reaction) then
						r = UnitReactionColor[reaction].r;
						g = UnitReactionColor[reaction].g;
						b = UnitReactionColor[reaction].b;
						Perl_Target_NameBarText:SetTextColor(r, g, b);
					else
						Perl_Target_NameBarText:SetTextColor(0.5, 0.5, 1.0);
					end
				else
					if (UnitCanAttack("target", "player")) then				-- are we in an enemy controlled zone
						-- Hostile players are red
						if (not UnitCanAttack("player", "target")) then			-- enemy is not pvp enabled
							r = 0.5;
							g = 0.5;
							b = 1.0;
						else								-- enemy is pvp enabled
							r = 1.0;
							g = 0.0;
							b = 0.0;
						end
					elseif (UnitCanAttack("player", "target")) then				-- enemy in a zone controlled by friendlies or when we're a ghost
						-- Players we can attack but which are not hostile are yellow
						r = 1.0;
						g = 1.0;
						b = 0.0;
					elseif (UnitIsPVP("target")) then					-- friendly pvp enabled character
						-- Players we can assist but are PvP flagged are green
						r = 0.0;
						g = 1.0;
						b = 0.0;
					else									-- friendly non pvp enabled character
						-- All other players are blue (the usual state on the "blue" server)
						r = 0.5;
						g = 0.5;
						b = 1.0;
					end
					Perl_Target_NameBarText:SetTextColor(r, g, b);
				end
				
			end
		end
	end
end

function Perl_Target_Frame_Set_Level()
	targetlevel = UnitLevel("target");			-- Get and store the level of the target
	targetlevelcolor = GetDifficultyColor(targetlevel);	-- Get the "con color" of the target
	targetclassification = UnitClassification("target");	-- Get the type of character the target is (rare, elite, worldboss)
	targetclassificationframetext = nil;			-- Variable set to nil so we can easily track if target is a player or not elite

	Perl_Target_LevelBarText:SetVertexColor(targetlevelcolor.r, targetlevelcolor.g, targetlevelcolor.b);
	Perl_Target_RareEliteBarText:SetVertexColor(targetlevelcolor.r, targetlevelcolor.g, targetlevelcolor.b);

	if (targetlevel < 0) then
		Perl_Target_LevelBarText:SetTextColor(1, 0, 0);
		if (UnitIsPlayer("target")) then
			targetclassificationframetext = nil;
		end
		targetlevel = "??";
	end

	if (targetclassification == "worldboss") then
		Perl_Target_RareEliteBarText:SetTextColor(1, 0, 0);
		targetclassificationframetext = PERL_LOCALIZED_TARGET_BOSS;
	end

	if (targetclassification == "rareelite") then
		targetclassificationframetext = PERL_LOCALIZED_TARGET_RAREELITE;
		targetlevel = targetlevel.."r+";
	elseif (targetclassification == "elite") then
		targetclassificationframetext = PERL_LOCALIZED_TARGET_ELITE;
		targetlevel = targetlevel.."+";
	elseif (targetclassification == "rare") then
		targetclassificationframetext = PERL_LOCALIZED_TARGET_RARE;
		targetlevel = targetlevel.."r";
	end

	Perl_Target_LevelBarText:SetText(targetlevel);							-- Set level frame text

	if (showrareeliteframe == 1) then
		if (targetclassificationframetext == nil) then
			Perl_Target_RareEliteFrame:Hide();						-- RareElite is hidden if target is a player
		else
			Perl_Target_RareEliteFrame:Show();						-- RareElite is hidden if shown if target is a npc
			Perl_Target_RareEliteBarText:SetText(targetclassificationframetext);		-- Set the text
		end
	else
		Perl_Target_RareEliteFrame:Hide();							-- RareElite is hidden if disabled
	end
end

function Perl_Target_UpdateRaidTargetIcon()
	local index = GetRaidTargetIndex("target");
	if (index) then
		SetRaidTargetIconTexture(Perl_Target_RaidTargetIcon, index);
		Perl_Target_RaidTargetIcon:Show();
	else
		Perl_Target_RaidTargetIcon:Hide();
	end
end

function Perl_Target_Update_Portrait()
	if (showportrait == 1) then
		Perl_Target_HitIndicator:SetPoint("CENTER", Perl_Target_PortraitFrame, "CENTER", 0, 0);		-- Position the Combat Text correctly on the portrait
		Perl_Target_CPFrame:SetPoint("TOPLEFT", Perl_Target_PortraitFrame, "TOPRIGHT", -4, -31);		-- Reposition the combo point frame
		Perl_Target_PortraitFrame:Show();									-- Show the main portrait frame

		if (threedportrait == 0) then
			SetPortraitTexture(Perl_Target_Portrait, "target");						-- Load the correct 2d graphic
			Perl_Target_PortraitFrame_TargetModel:Hide();							-- Hide the 3d graphic
			Perl_Target_Portrait:Show();									-- Show the 2d graphic
		else
			if UnitIsVisible("target") then
				Perl_Target_PortraitFrame_TargetModel:SetUnit("target");				-- Load the correct 3d graphic
				Perl_Target_Portrait:Hide();								-- Hide the 2d graphic
				Perl_Target_PortraitFrame_TargetModel:Show();						-- Show the 3d graphic
				Perl_Target_PortraitFrame_TargetModel:SetCamera(0);
			else
				SetPortraitTexture(Perl_Target_Portrait, "target");					-- Load the correct 2d graphic
				Perl_Target_PortraitFrame_TargetModel:Hide();						-- Hide the 3d graphic
				Perl_Target_Portrait:Show();								-- Show the 2d graphic
			end
		end
	else
		if (showcp == 1) then
			Perl_Target_HitIndicator:SetPoint("CENTER", Perl_Target_PortraitFrame, "CENTER", 25, 0);	-- Position the Combat Text to the right of the combo point frame
		else
			Perl_Target_HitIndicator:SetPoint("CENTER", Perl_Target_PortraitFrame, "CENTER", 0, 0);		-- Position the Combat Text correctly on the portrait
		end
		Perl_Target_CPFrame:SetPoint("TOPLEFT", Perl_Target_StatsFrame, "TOPRIGHT", -4, 0);			-- Reposition the combo point frame
		Perl_Target_PortraitFrame:Hide();									-- Hide the frame and 2d/3d portion
	end
end

function Perl_Target_Portrait_Combat_Text()
	if (portraitcombattext == 1) then
		Perl_Target_PortraitTextFrame:Show();
	else
		Perl_Target_PortraitTextFrame:Hide();
	end
end

function Perl_Target_Buff_Debuff_Background()
	if (hidebuffbackground == 0) then
		Perl_Target_BuffFrame:SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, insets = { left = 5, right = 5, top = 5, bottom = 5 }});
		Perl_Target_DebuffFrame:SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, insets = { left = 5, right = 5, top = 5, bottom = 5 }});
		Perl_Target_BuffFrame:SetBackdropColor(0, 0, 0, 1);
		Perl_Target_BuffFrame:SetBackdropBorderColor(0.5, 0.5, 0.5, 1);
		Perl_Target_DebuffFrame:SetBackdropColor(0, 0, 0, 1);
		Perl_Target_DebuffFrame:SetBackdropBorderColor(0.5, 0.5, 0.5, 1);
	else
		Perl_Target_BuffFrame:SetBackdrop(nil);
		Perl_Target_DebuffFrame:SetBackdrop(nil);
	end
end

function Perl_Target_Frame_Style()
	Perl_Target_RareEliteFrame:SetPoint("TOPLEFT", "Perl_Target_CivilianFrame", "TOPRIGHT", -5, 0);

	if (framestyle == 1) then
		Perl_Target_HealthBar:SetWidth(200);
		Perl_Target_HealthBarFadeBar:SetWidth(200);
		Perl_Target_HealthBarBG:SetWidth(200);
		Perl_Target_ManaBar:SetWidth(200);
		Perl_Target_ManaBarFadeBar:SetWidth(200);
		Perl_Target_ManaBarBG:SetWidth(200);
		Perl_Target_HealthBar:SetPoint("TOP", "Perl_Target_StatsFrame", "TOP", 0, -10);
		Perl_Target_ManaBar:SetPoint("TOP", "Perl_Target_HealthBar", "BOTTOM", 0, -2);

		Perl_Target_CivilianFrame:SetWidth(95);
		Perl_Target_ClassNameFrame:SetWidth(90);
		Perl_Target_LevelFrame:SetWidth(46);
		Perl_Target_Name:SetWidth(180);
		Perl_Target_NameFrame:SetWidth(180);
		Perl_Target_RareEliteFrame:SetWidth(46);
		Perl_Target_StatsFrame:SetWidth(221);

		Perl_Target_NameFrame_CPMeter:SetWidth(170);

		Perl_Target_CivilianFrame_CastClickOverlay:SetWidth(95);
		Perl_Target_NameFrame_CastClickOverlay:SetWidth(180);
		Perl_Target_StatsFrame_CastClickOverlay:SetWidth(221);
	elseif (framestyle == 2) then
		Perl_Target_HealthBar:SetWidth(150);
		Perl_Target_HealthBarFadeBar:SetWidth(150);
		Perl_Target_HealthBarBG:SetWidth(150);
		Perl_Target_ManaBar:SetWidth(150);
		Perl_Target_ManaBarFadeBar:SetWidth(150);
		Perl_Target_ManaBarBG:SetWidth(150);
		Perl_Target_HealthBar:SetPoint("TOPLEFT", "Perl_Target_StatsFrame", "TOPLEFT", 10, -10);
		Perl_Target_ManaBar:SetPoint("TOP", "Perl_Target_HealthBar", "BOTTOM", 0, -2);

		if (compactmode == 0) then
			Perl_Target_CivilianFrame:SetWidth(114);
			Perl_Target_ClassNameFrame:SetWidth(90);
			Perl_Target_LevelFrame:SetWidth(46);
			Perl_Target_Name:SetWidth(199);
			Perl_Target_NameFrame:SetWidth(199);
			Perl_Target_RareEliteFrame:SetWidth(46);
			Perl_Target_StatsFrame:SetWidth(240);

			Perl_Target_NameFrame_CPMeter:SetWidth(189);

			Perl_Target_CivilianFrame_CastClickOverlay:SetWidth(114);
			Perl_Target_NameFrame_CastClickOverlay:SetWidth(199);
			Perl_Target_StatsFrame_CastClickOverlay:SetWidth(240);
		else
			if (shortbars == 0) then
				if (compactpercent == 0) then
					Perl_Target_CivilianFrame:SetWidth(85);
					Perl_Target_ClassNameFrame:SetWidth(90);
					Perl_Target_LevelFrame:SetWidth(46);
					Perl_Target_Name:SetWidth(129);
					Perl_Target_NameFrame:SetWidth(129);
					Perl_Target_RareEliteFrame:SetWidth(46);
					Perl_Target_StatsFrame:SetWidth(170);
					Perl_Target_RareEliteFrame:SetPoint("TOPLEFT", "Perl_Target_CivilianFrame", "TOPRIGHT", -46, 0);

					Perl_Target_NameFrame_CPMeter:SetWidth(119);

					Perl_Target_CivilianFrame_CastClickOverlay:SetWidth(85);
					Perl_Target_NameFrame_CastClickOverlay:SetWidth(129);
					Perl_Target_StatsFrame_CastClickOverlay:SetWidth(170);
				else
					Perl_Target_CivilianFrame:SetWidth(79);
					Perl_Target_ClassNameFrame:SetWidth(90);
					Perl_Target_LevelFrame:SetWidth(46);
					Perl_Target_Name:SetWidth(164);
					Perl_Target_NameFrame:SetWidth(164);
					Perl_Target_RareEliteFrame:SetWidth(46);
					Perl_Target_StatsFrame:SetWidth(205);

					Perl_Target_NameFrame_CPMeter:SetWidth(154);

					Perl_Target_CivilianFrame_CastClickOverlay:SetWidth(79);
					Perl_Target_NameFrame_CastClickOverlay:SetWidth(164);
					Perl_Target_StatsFrame_CastClickOverlay:SetWidth(205);
				end
			else
				Perl_Target_HealthBar:SetWidth(115);
				Perl_Target_HealthBarFadeBar:SetWidth(115);
				Perl_Target_HealthBarBG:SetWidth(115);
				Perl_Target_ManaBar:SetWidth(115);
				Perl_Target_ManaBarFadeBar:SetWidth(115);
				Perl_Target_ManaBarBG:SetWidth(115);

				if (compactpercent == 0) then				-- civilian probably needs resizing
					Perl_Target_CivilianFrame:SetWidth(79);
					Perl_Target_ClassNameFrame:SetWidth(90);
					Perl_Target_LevelFrame:SetWidth(46);
					Perl_Target_Name:SetWidth(94);
					Perl_Target_NameFrame:SetWidth(94);
					Perl_Target_RareEliteFrame:SetWidth(46);
					Perl_Target_StatsFrame:SetWidth(135);

					Perl_Target_NameFrame_CPMeter:SetWidth(84);

					Perl_Target_CivilianFrame_CastClickOverlay:SetWidth(79);
					Perl_Target_NameFrame_CastClickOverlay:SetWidth(94);
					Perl_Target_StatsFrame_CastClickOverlay:SetWidth(135);
				else
					Perl_Target_CivilianFrame:SetWidth(79);
					Perl_Target_ClassNameFrame:SetWidth(90);
					Perl_Target_LevelFrame:SetWidth(46);
					Perl_Target_Name:SetWidth(129);
					Perl_Target_NameFrame:SetWidth(129);
					Perl_Target_RareEliteFrame:SetWidth(46);
					Perl_Target_StatsFrame:SetWidth(170);

					Perl_Target_NameFrame_CPMeter:SetWidth(119);

					Perl_Target_CivilianFrame_CastClickOverlay:SetWidth(79);
					Perl_Target_NameFrame_CastClickOverlay:SetWidth(129);
					Perl_Target_StatsFrame_CastClickOverlay:SetWidth(170);
				end
			end
		end
	end
end

function Perl_Target_Set_Localized_ClassIcons()
	Perl_Target_ClassPosRight = {
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
	Perl_Target_ClassPosLeft = {
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
	Perl_Target_ClassPosTop = {
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
	Perl_Target_ClassPosBottom = {
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
function Perl_Target_HealthBar_Fade(arg1)
	Perl_Target_HealthBar_Fade_Color = Perl_Target_HealthBar_Fade_Color - arg1;
	Perl_Target_HealthBar_Fade_Time_Elapsed = Perl_Target_HealthBar_Fade_Time_Elapsed + arg1;

	Perl_Target_HealthBarFadeBar:SetStatusBarColor(0, Perl_Target_HealthBar_Fade_Color, 0, Perl_Target_HealthBar_Fade_Color);

	if (Perl_Target_HealthBar_Fade_Time_Elapsed > 1) then
		Perl_Target_HealthBar_Fade_Color = 1;
		Perl_Target_HealthBar_Fade_Time_Elapsed = 0;
		Perl_Target_HealthBarFadeBar:Hide();
		Perl_Target_HealthBar_Fade_OnUpdate_Frame:Hide();
	end
end

function Perl_Target_ManaBar_Fade(arg1)
	Perl_Target_ManaBar_Fade_Color = Perl_Target_ManaBar_Fade_Color - arg1;
	Perl_Target_ManaBar_Fade_Time_Elapsed = Perl_Target_ManaBar_Fade_Time_Elapsed + arg1;

	if (targetpower == 0) then
		Perl_Target_ManaBarFadeBar:SetStatusBarColor(0, 0, Perl_Target_ManaBar_Fade_Color, Perl_Target_ManaBar_Fade_Color);
	elseif (targetpower == 1) then
		Perl_Target_ManaBarFadeBar:SetStatusBarColor(Perl_Target_ManaBar_Fade_Color, 0, 0, Perl_Target_ManaBar_Fade_Color);
	elseif (targetpower == 2) then
		Perl_Target_ManaBarFadeBar:SetStatusBarColor(Perl_Target_ManaBar_Fade_Color, (Perl_Target_ManaBar_Fade_Color-0.5), 0, Perl_Target_ManaBar_Fade_Color);
	elseif (targetpower == 3) then
		Perl_Target_ManaBarFadeBar:SetStatusBarColor(Perl_Target_ManaBar_Fade_Color, Perl_Target_ManaBar_Fade_Color, 0, Perl_Target_ManaBar_Fade_Color);
	end

	if (Perl_Target_ManaBar_Fade_Time_Elapsed > 1) then
		Perl_Target_ManaBar_Fade_Color = 1;
		Perl_Target_ManaBar_Fade_Time_Elapsed = 0;
		Perl_Target_ManaBarFadeBar:Hide();
		Perl_Target_ManaBar_Fade_OnUpdate_Frame:Hide();
	end
end


--------------------------
-- GUI Config Functions --
--------------------------
function Perl_Target_Set_Buffs(newbuffnumber)
	if (newbuffnumber == nil) then
		newbuffnumber = 16;
	end
	numbuffsshown = newbuffnumber;
	Perl_Target_UpdateVars();
	Perl_Target_Reset_Buffs();	-- Reset the buff icons
	Perl_Target_Buff_UpdateAll();	-- Repopulate the buff icons
end

function Perl_Target_Set_Debuffs(newdebuffnumber)
	if (newdebuffnumber == nil) then
		newdebuffnumber = 16;
	end
	numdebuffsshown = newdebuffnumber;
	Perl_Target_UpdateVars();
	Perl_Target_Reset_Buffs();	-- Reset the buff icons
	Perl_Target_Buff_UpdateAll();	-- Repopulate the buff icons
end

function Perl_Target_Set_Class_Buffs(newvalue)
	if (newvalue ~= nil) then
		displaycastablebuffs = newvalue;
	end
	Perl_Target_UpdateVars();
	Perl_Target_Reset_Buffs();	-- Reset the buff icons
	Perl_Target_Buff_UpdateAll();	-- Repopulate the buff icons
end

function Perl_Target_Set_Invert_Buffs(newvalue)
	if (newvalue ~= nil) then
		invertbuffs = newvalue;
	end
	Perl_Target_UpdateVars();
	Perl_Target_Reset_Buffs();	-- Reset the buff icons
	Perl_Target_Buff_UpdateAll();	-- Repopulate the buff icons
end

function Perl_Target_Set_Class_Icon(newvalue)
	showclassicon = newvalue;
	Perl_Target_UpdateVars();
	Perl_Target_Update_Once();
end

function Perl_Target_Set_PvP_Rank_Icon(newvalue)
	showpvprank = newvalue;
	Perl_Target_UpdateVars();
	Perl_Target_Update_Once();
end

function Perl_Target_Set_PvP_Status_Icon(newvalue)
	showpvpicon = newvalue;
	Perl_Target_UpdateVars();
	Perl_Target_Update_Once();
end

function Perl_Target_Set_Class_Frame(newvalue)
	showclassframe = newvalue;
	Perl_Target_UpdateVars();
	Perl_Target_Update_Once();
end

function Perl_Target_Set_Combo_Points(newvalue)
	showcp = newvalue;
	Perl_Target_UpdateVars();
	Perl_Target_Update_Once();
	Perl_Target_Portrait_Combat_Text();
end

function Perl_Target_Set_MobHealth(newvalue)
	mobhealthsupport = newvalue;
	Perl_Target_UpdateVars();
	Perl_Target_Update_Once();
end

function Perl_Target_Set_Lock(newvalue)
	locked = newvalue;
	Perl_Target_UpdateVars();
end

function Perl_Target_Set_Portrait(newvalue)
	showportrait = newvalue;
	Perl_Target_UpdateVars();
	Perl_Target_Update_Once();
end

function Perl_Target_Set_3D_Portrait(newvalue)
	threedportrait = newvalue;
	Perl_Target_UpdateVars();
	Perl_Target_Update_Once();
end

function Perl_Target_Set_Rare_Elite(newvalue)
	showrareeliteframe = newvalue;
	Perl_Target_UpdateVars();
	Perl_Target_Update_Once();
end

function Perl_Target_Set_Portrait_Combat_Text(newvalue)
	portraitcombattext = newvalue;
	Perl_Target_UpdateVars();
	Perl_Target_Portrait_Combat_Text();
end

function Perl_Target_Set_Combo_Name_Frame(newvalue)
	nameframecombopoints = newvalue;
	Perl_Target_UpdateVars();
	Perl_Target_Update_Once();
end

function Perl_Target_Set_Combo_Frame_Debuffs(newvalue)
	comboframedebuffs = newvalue;
	Perl_Target_UpdateVars();
	Perl_Target_Update_Once();
end

function Perl_Target_Set_Frame_Style(newvalue)
	framestyle = newvalue;
	Perl_Target_UpdateVars();
	Perl_Target_Frame_Style();
	Perl_Target_Update_Once();
end

function Perl_Target_Set_Compact_Mode(newvalue)
	compactmode = newvalue;
	Perl_Target_UpdateVars();
	Perl_Target_Frame_Style();
	Perl_Target_Update_Once();
end

function Perl_Target_Set_Compact_Percents(newvalue)
	compactpercent = newvalue;
	Perl_Target_UpdateVars();
	Perl_Target_Frame_Style();
	Perl_Target_Update_Once();
end

function Perl_Target_Set_Short_Bars(newvalue)
	shortbars = newvalue;
	Perl_Target_UpdateVars();
	Perl_Target_Frame_Style();
	Perl_Target_Update_Once();
end

function Perl_Target_Set_Healer(newvalue)
	healermode = newvalue;
	Perl_Target_UpdateVars();
	Perl_Target_Update_Once();
end

function Perl_Target_Set_Class_Colored_Names(newvalue)
	classcolorednames = newvalue;
	Perl_Target_UpdateVars();
	Perl_Target_Update_Once();
end

function Perl_Target_Set_Buff_Debuff_Background(newvalue)
	hidebuffbackground = newvalue;
	Perl_Target_UpdateVars();
	Perl_Target_Buff_Debuff_Background();
end

function Perl_Target_Set_Sound_Target_Change(newvalue)
	soundtargetchange = newvalue;
	Perl_Target_UpdateVars();
end

function Perl_Target_Set_Mana_Deficit(newvalue)
	showmanadeficit = newvalue;
	Perl_Target_UpdateVars();
	Perl_Target_Update_Once();
end

function Perl_Target_Set_Scale(number)
	local unsavedscale;
	if (number ~= nil) then
		scale = (number / 100);						-- convert the user input to a wow acceptable value
	end
	unsavedscale = 1 - UIParent:GetEffectiveScale() + scale;		-- run it through the scaling formula introduced in 1.9
	Perl_Target_Frame:SetScale(unsavedscale);
	Perl_Target_Set_BuffDebuff_Scale(buffdebuffscale*100);			-- maintain the buff/debuff scale
	Perl_Target_UpdateVars();
end

function Perl_Target_Set_BuffDebuff_Scale(number)
	local unsavedscale;
	if (number ~= nil) then
		buffdebuffscale = (number / 100);				-- convert the user input to a wow acceptable value
	end
	unsavedscale = 1 - UIParent:GetEffectiveScale() + buffdebuffscale;	-- run it through the scaling formula introduced in 1.9
	Perl_Target_BuffFrame:SetScale(buffdebuffscale);
	Perl_Target_DebuffFrame:SetScale(buffdebuffscale);
	Perl_Target_UpdateVars();
end

function Perl_Target_Set_Transparency(number)
	if (number ~= nil) then
		transparency = (number / 100);					-- convert the user input to a wow acceptable value
	end
	Perl_Target_Frame:SetAlpha(transparency);
	Perl_Target_UpdateVars();
end


------------------------------
-- Saved Variable Functions --
------------------------------
function Perl_Target_GetVars(name, updateflag)
	if (name == nil) then
		name = UnitName("player");
	end

	locked = Perl_Target_Config[name]["Locked"];
	showcp = Perl_Target_Config[name]["ComboPoints"];
	showclassicon = Perl_Target_Config[name]["ClassIcon"];
	showclassframe = Perl_Target_Config[name]["ClassFrame"];
	showpvpicon = Perl_Target_Config[name]["PvPIcon"]; 
	numbuffsshown = Perl_Target_Config[name]["Buffs"];
	numdebuffsshown = Perl_Target_Config[name]["Debuffs"];
	mobhealthsupport = Perl_Target_Config[name]["MobHealthSupport"];
	scale = Perl_Target_Config[name]["Scale"];
	showpvprank = Perl_Target_Config[name]["ShowPvPRank"];
	transparency = Perl_Target_Config[name]["Transparency"];
	buffdebuffscale = Perl_Target_Config[name]["BuffDebuffScale"];
	showportrait = Perl_Target_Config[name]["ShowPortrait"];
	threedportrait = Perl_Target_Config[name]["ThreeDPortrait"];
	portraitcombattext = Perl_Target_Config[name]["PortraitCombatText"];
	showrareeliteframe = Perl_Target_Config[name]["ShowRareEliteFrame"];
	nameframecombopoints = Perl_Target_Config[name]["NameFrameComboPoints"];
	comboframedebuffs = Perl_Target_Config[name]["ComboFrameDebuffs"];
	framestyle = Perl_Target_Config[name]["FrameStyle"];
	compactmode = Perl_Target_Config[name]["CompactMode"];
	compactpercent = Perl_Target_Config[name]["CompactPercent"];
	hidebuffbackground = Perl_Target_Config[name]["HideBuffBackground"];
	shortbars = Perl_Target_Config[name]["ShortBars"];
	healermode = Perl_Target_Config[name]["HealerMode"];
	soundtargetchange = Perl_Target_Config[name]["SoundTargetChange"];
	displaycastablebuffs = Perl_Target_Config[name]["DisplayCastableBuffs"];
	classcolorednames = Perl_Target_Config[name]["ClassColoredNames"];
	showmanadeficit = Perl_Target_Config[name]["ShowManaDeficit"];
	invertbuffs = Perl_Target_Config[name]["InvertBuffs"];

	if (locked == nil) then
		locked = 0;
	end
	if (showcp == nil) then
		showcp = 1;
	end
	if (showclassicon == nil) then
		showclassicon = 1;
	end
	if (showclassframe == nil) then
		showclassframe = 1;
	end
	if (showpvpicon == nil) then
		showpvpicon = 1;
	end
	if (numbuffsshown == nil) then
		numbuffsshown = 16;
	end
	if (numdebuffsshown == nil) then
		numdebuffsshown = 16;
	end
	if (mobhealthsupport == nil) then
		mobhealthsupport = 1;
	end
	if (scale == nil) then
		scale = 1;
	end
	if (showpvprank == nil) then
		showpvprank = 0;
	end
	if (transparency == nil) then
		transparency = 1;
	end
	if (buffdebuffscale == nil) then
		buffdebuffscale = 1;
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
	if (showrareeliteframe == nil) then
		showrareeliteframe = 0;
	end
	if (nameframecombopoints == nil) then
		nameframecombopoints = 0;
	end
	if (comboframedebuffs == nil) then
		comboframedebuffs = 0;
	end
	if (framestyle == nil) then
		framestyle = 1;
	end
	if (compactmode == nil) then
		compactmode = 0;
	end
	if (compactpercent == nil) then
		compactpercent = 0;
	end
	if (hidebuffbackground == nil) then
		hidebuffbackground = 0;
	end
	if (shortbars == nil) then
		shortbars = 0;
	end
	if (healermode == nil) then
		healermode = 0;
	end
	if (soundtargetchange == nil) then
		soundtargetchange = 0;
	end
	if (displaycastablebuffs == nil) then
		displaycastablebuffs = 0;
	end
	if (classcolorednames == nil) then
		classcolorednames = 0;
	end
	if (showmanadeficit == nil) then
		showmanadeficit = 0;
	end
	if (invertbuffs == nil) then
		invertbuffs = 0;
	end

	if (updateflag == 1) then
		-- Save the new values
		Perl_Target_UpdateVars();

		-- Call any code we need to activate them
		Perl_Target_Reset_Buffs();		-- Reset the buff icons
		Perl_Target_Frame_Style();		-- Reposition the frames
		Perl_Target_Buff_Debuff_Background();	-- Hide/Show the background frame
		Perl_Target_Set_Scale();		-- Set the scale
		Perl_Target_Set_Transparency();		-- Set the transparency
		Perl_Target_Update_Once();
		return;
	end

	local vars = {
		["locked"] = locked,
		["showcp"] = showcp,
		["showclassicon"] = showclassicon,
		["showclassframe"] = showclassframe,
		["showpvpicon"] = showpvpicon,
		["numbuffsshown"] = numbuffsshown,
		["numdebuffsshown"] = numdebuffsshown,
		["mobhealthsupport"] = mobhealthsupport,
		["scale"] = scale,
		["showpvprank"] = showpvprank,
		["transparency"] = transparency,
		["buffdebuffscale"] = buffdebuffscale,
		["showportrait"] = showportrait,
		["threedportrait"] = threedportrait,
		["portraitcombattext"] = portraitcombattext,
		["showrareeliteframe"] = showrareeliteframe,
		["nameframecombopoints"] = nameframecombopoints,
		["comboframedebuffs"] = comboframedebuffs,
		["framestyle"] = framestyle,
		["compactmode"] = compactmode,
		["compactpercent"] = compactpercent,
		["hidebuffbackground"] = hidebuffbackground,
		["shortbars"] = shortbars,
		["healermode"] = healermode,
		["soundtargetchange"] = soundtargetchange,
		["displaycastablebuffs"] = displaycastablebuffs,
		["classcolorednames"] = classcolorednames,
		["showmanadeficit"] = showmanadeficit,
		["invertbuffs"] = invertbuffs,
	}
	return vars;
end

function Perl_Target_UpdateVars(vartable)
	if (vartable ~= nil) then
		-- Sanity checks in case you use a load from an old version
		if (vartable["Global Settings"] ~= nil) then
			if (vartable["Global Settings"]["Locked"] ~= nil) then
				locked = vartable["Global Settings"]["Locked"];
			else
				locked = nil;
			end
			if (vartable["Global Settings"]["ComboPoints"] ~= nil) then
				showcp = vartable["Global Settings"]["ComboPoints"];
			else
				showcp = nil;
			end
			if (vartable["Global Settings"]["ClassIcon"] ~= nil) then
				showclassicon = vartable["Global Settings"]["ClassIcon"];
			else
				showclassicon = nil;
			end
			if (vartable["Global Settings"]["ClassFrame"] ~= nil) then
				showclassframe = vartable["Global Settings"]["ClassFrame"];
			else
				showclassframe = nil;
			end
			if (vartable["Global Settings"]["PvPIcon"] ~= nil) then
				showpvpicon = vartable["Global Settings"]["PvPIcon"];
			else
				showpvpicon = nil;
			end
			if (vartable["Global Settings"]["Buffs"] ~= nil) then
				numbuffsshown = vartable["Global Settings"]["Buffs"];
			else
				numbuffsshown = nil;
			end
			if (vartable["Global Settings"]["Debuffs"] ~= nil) then
				numdebuffsshown = vartable["Global Settings"]["Debuffs"];
			else
				numdebuffsshown = nil;
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
			if (vartable["Global Settings"]["ShowPvPRank"] ~= nil) then
				showpvprank = vartable["Global Settings"]["ShowPvPRank"];
			else
				showpvprank = nil;
			end
			if (vartable["Global Settings"]["Transparency"] ~= nil) then
				transparency = vartable["Global Settings"]["Transparency"];
			else
				transparency = nil;
			end
			if (vartable["Global Settings"]["BuffDebuffScale"] ~= nil) then
				buffdebuffscale = vartable["Global Settings"]["BuffDebuffScale"];
			else
				buffdebuffscale = nil;
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
			if (vartable["Global Settings"]["ShowRareEliteFrame"] ~= nil) then
				showrareeliteframe = vartable["Global Settings"]["ShowRareEliteFrame"];
			else
				showrareeliteframe = nil;
			end
			if (vartable["Global Settings"]["NameFrameComboPoints"] ~= nil) then
				nameframecombopoints = vartable["Global Settings"]["NameFrameComboPoints"];
			else
				nameframecombopoints = nil;
			end
			if (vartable["Global Settings"]["ComboFrameDebuffs"] ~= nil) then
				comboframedebuffs = vartable["Global Settings"]["ComboFrameDebuffs"];
			else
				comboframedebuffs = nil;
			end
			if (vartable["Global Settings"]["FrameStyle"] ~= nil) then
				framestyle = vartable["Global Settings"]["FrameStyle"];
			else
				framestyle = nil;
			end
			if (vartable["Global Settings"]["CompactMode"] ~= nil) then
				compactmode = vartable["Global Settings"]["CompactMode"];
			else
				compactmode = nil;
			end
			if (vartable["Global Settings"]["CompactPercent"] ~= nil) then
				compactpercent = vartable["Global Settings"]["CompactPercent"];
			else
				compactpercent = nil;
			end
			if (vartable["Global Settings"]["HideBuffBackground"] ~= nil) then
				hidebuffbackground = vartable["Global Settings"]["HideBuffBackground"];
			else
				hidebuffbackground = nil;
			end
			if (vartable["Global Settings"]["ShortBars"] ~= nil) then
				shortbars = vartable["Global Settings"]["ShortBars"];
			else
				shortbars = nil;
			end
			if (vartable["Global Settings"]["HealerMode"] ~= nil) then
				healermode = vartable["Global Settings"]["HealerMode"];
			else
				healermode = nil;
			end
			if (vartable["Global Settings"]["SoundTargetChange"] ~= nil) then
				soundtargetchange = vartable["Global Settings"]["SoundTargetChange"];
			else
				soundtargetchange = nil;
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
			if (vartable["Global Settings"]["ShowManaDeficit"] ~= nil) then
				showmanadeficit = vartable["Global Settings"]["ShowManaDeficit"];
			else
				showmanadeficit = nil;
			end
			if (vartable["Global Settings"]["InvertBuffs"] ~= nil) then
				invertbuffs = vartable["Global Settings"]["InvertBuffs"];
			else
				invertbuffs = nil;
			end
		end

		-- Set the new values if any new values were found, same defaults as above
		if (locked == nil) then
			locked = 0;
		end
		if (showcp == nil) then
			showcp = 1;
		end
		if (showclassicon == nil) then
			showclassicon = 1;
		end
		if (showclassframe == nil) then
			showclassframe = 1;
		end
		if (showpvpicon == nil) then
			showpvpicon = 1;
		end
		if (numbuffsshown == nil) then
			numbuffsshown = 16;
		end
		if (numdebuffsshown == nil) then
			numdebuffsshown = 16;
		end
		if (mobhealthsupport == nil) then
			mobhealthsupport = 1;
		end
		if (scale == nil) then
			scale = 1;
		end
		if (showpvprank == nil) then
			showpvprank = 0;
		end
		if (transparency == nil) then
			transparency = 1;
		end
		if (buffdebuffscale == nil) then
			buffdebuffscale = 1;
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
		if (showrareeliteframe == nil) then
			showrareeliteframe = 0;
		end
		if (nameframecombopoints == nil) then
			nameframecombopoints = 0;
		end
		if (comboframedebuffs == nil) then
			comboframedebuffs = 0;
		end
		if (framestyle == nil) then
			framestyle = 1;
		end
		if (compactmode == nil) then
			compactmode = 0;
		end
		if (compactpercent == nil) then
			compactpercent = 0;
		end
		if (hidebuffbackground == nil) then
			hidebuffbackground = 0;
		end
		if (shortbars == nil) then
			shortbars = 0;
		end
		if (healermode == nil) then
			healermode = 0;
		end
		if (soundtargetchange == nil) then
			soundtargetchange = 0;
		end
		if (displaycastablebuffs == nil) then
			displaycastablebuffs = 0;
		end
		if (classcolorednames == nil) then
			classcolorednames = 0;
		end
		if (showmanadeficit == nil) then
			showmanadeficit = 0;
		end
		if (invertbuffs == nil) then
			invertbuffs = 0;
		end

		-- Call any code we need to activate them
		Perl_Target_Reset_Buffs();		-- Reset the buff icons
		Perl_Target_Frame_Style();		-- Reposition the frames
		Perl_Target_Buff_Debuff_Background();	-- Hide/Show the background frame
		Perl_Target_Set_Scale();		-- Set the scale
		Perl_Target_Set_Transparency();		-- Set the transparency
		Perl_Target_Update_Once();
	end

	-- IFrameManager Support
	if (IFrameManager) then
		IFrameManager:Refresh();
	end

	Perl_Target_Config[UnitName("player")] = {
		["Locked"] = locked,
		["ComboPoints"] = showcp,
		["ClassIcon"] = showclassicon,
		["ClassFrame"] = showclassframe,
		["PvPIcon"] = showpvpicon,
		["Buffs"] = numbuffsshown,
		["Debuffs"] = numdebuffsshown,
		["MobHealthSupport"] = mobhealthsupport,
		["Scale"] = scale,
		["ShowPvPRank"] = showpvprank,
		["Transparency"] = transparency,
		["BuffDebuffScale"] = buffdebuffscale,
		["ShowPortrait"] = showportrait,
		["ThreeDPortrait"] = threedportrait,
		["PortraitCombatText"] = portraitcombattext,
		["ShowRareEliteFrame"] = showrareeliteframe,
		["NameFrameComboPoints"] = nameframecombopoints,
		["ComboFrameDebuffs"] = comboframedebuffs,
		["FrameStyle"] = framestyle,
		["CompactMode"] = compactmode,
		["CompactPercent"] = compactpercent,
		["HideBuffBackground"] = hidebuffbackground,
		["ShortBars"] = shortbars,
		["HealerMode"] = healermode,
		["SoundTargetChange"] = soundtargetchange,
		["DisplayCastableBuffs"] = displaycastablebuffs,
		["ClassColoredNames"] = classcolorednames,
		["ShowManaDeficit"] = showmanadeficit,
		["InvertBuffs"] = invertbuffs,
	};
end


--------------------
-- Buff Functions --
--------------------
function Perl_Target_Buff_UpdateAll()
	if (UnitName("target")) then

		if (nameframecombopoints == 1 or comboframedebuffs == 1) then
			Perl_Target_Buff_UpdateCPMeter();
		end

		local button, buffCount, buffTexture, buffApplications, color, debuffType;				-- Variables for both buffs and debuffs (yes, I'm using buff names for debuffs, wanna fight about it?)

		local numBuffs = 0;											-- Buff counter for correct layout
		for buffnum=1,numbuffsshown do										-- Start main buff loop
			buffTexture, buffApplications = UnitBuff("target", buffnum, displaycastablebuffs);		-- Get the texture and buff stacking information if any
			button = getglobal("Perl_Target_Buff"..buffnum);						-- Create the main icon for the buff
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
				numBuffs = numBuffs + 1;								-- Increment the buff counter
				button:Show();										-- Show the final buff icon
			else
				button:Hide();										-- Hide the icon since there isn't a buff in this position
			end
		end													-- End main buff loop

		local numDebuffs = 0;											-- Debuff counter for correct layout
		for debuffnum=1,numdebuffsshown do									-- Start main debuff loop
			buffTexture, buffApplications, debuffType = UnitDebuff("target", debuffnum, displaycastablebuffs);	-- Get the texture and debuff stacking information if any
			button = getglobal("Perl_Target_Debuff"..debuffnum);						-- Create the main icon for the debuff
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
				numDebuffs = numDebuffs + 1;								-- Increment the debuff counter
				button:Show();										-- Show the final debuff icon
			else
				button:Hide();										-- Hide the icon since there isn't a debuff in this position
			end
		end													-- End main debuff loop

		if (numBuffs == 0) then
			Perl_Target_BuffFrame:Hide();
		else
			if (invertbuffs == 0) then
				Perl_Target_BuffFrame:ClearAllPoints();
				if (UnitIsFriend("player", "target")) then
					Perl_Target_BuffFrame:SetPoint("TOPLEFT", "Perl_Target_StatsFrame", "BOTTOMLEFT", 0, 5);
				else
					if (numDebuffs > 8) then
						Perl_Target_BuffFrame:SetPoint("TOPLEFT", "Perl_Target_StatsFrame", "BOTTOMLEFT", 0, -51);
					else
						Perl_Target_BuffFrame:SetPoint("TOPLEFT", "Perl_Target_StatsFrame", "BOTTOMLEFT", 0, -25);
					end
				end
			else
				Perl_Target_BuffFrame:ClearAllPoints();
				if (UnitIsFriend("player", "target")) then
					if (showclassframe == 1 or showrareeliteframe == 1) then
						Perl_Target_BuffFrame:SetPoint("BOTTOMLEFT", "Perl_Target_NameFrame", "TOPLEFT", 0, 16);
					else
						Perl_Target_BuffFrame:SetPoint("BOTTOMLEFT", "Perl_Target_NameFrame", "TOPLEFT", 0, -5);
					end
				else
					if (showclassframe == 1 or showrareeliteframe == 1) then
						if (numDebuffs > 8) then
							Perl_Target_BuffFrame:SetPoint("BOTTOMLEFT", "Perl_Target_NameFrame", "TOPLEFT", 0, 72);
						else
							Perl_Target_BuffFrame:SetPoint("BOTTOMLEFT", "Perl_Target_NameFrame", "TOPLEFT", 0, 46);
						end
					else
						if (numDebuffs > 8) then
							Perl_Target_BuffFrame:SetPoint("BOTTOMLEFT", "Perl_Target_NameFrame", "TOPLEFT", 0, 51);
						else
							Perl_Target_BuffFrame:SetPoint("BOTTOMLEFT", "Perl_Target_NameFrame", "TOPLEFT", 0, 25);
						end
					end
				end
			end

			Perl_Target_BuffFrame:Show();
			if (numBuffs > 8) then
				Perl_Target_BuffFrame:SetWidth(221);			-- 5 + 8 * (24 + 3)	5 = border gap, 8 buffs across, 24 = icon size + 3 for pixel alignment, only holds true for default size
				Perl_Target_BuffFrame:SetHeight(61);			-- 2 rows tall
			else
				Perl_Target_BuffFrame:SetWidth(5 + numBuffs * 27);	-- Dynamically extend the background frame
				Perl_Target_BuffFrame:SetHeight(34);			-- 1 row tall
			end
		end

		if (numDebuffs == 0) then
			Perl_Target_DebuffFrame:Hide();
		else
			if (invertbuffs == 0) then
				Perl_Target_DebuffFrame:ClearAllPoints();
				if (UnitIsFriend("player", "target")) then
					if (numBuffs > 8) then
						Perl_Target_DebuffFrame:SetPoint("TOPLEFT", "Perl_Target_StatsFrame", "BOTTOMLEFT", 0, -51);
					else
						Perl_Target_DebuffFrame:SetPoint("TOPLEFT", "Perl_Target_StatsFrame", "BOTTOMLEFT", 0, -25);
					end
				else
					Perl_Target_DebuffFrame:SetPoint("TOPLEFT", "Perl_Target_StatsFrame", "BOTTOMLEFT", 0, 5);
				end
			else
				Perl_Target_DebuffFrame:ClearAllPoints();
				if (UnitIsFriend("player", "target")) then
					if (showclassframe == 1 or showrareeliteframe == 1) then
						if (numBuffs > 8) then
							Perl_Target_DebuffFrame:SetPoint("BOTTOMLEFT", "Perl_Target_NameFrame", "TOPLEFT", 0, 72);
						else
							Perl_Target_DebuffFrame:SetPoint("BOTTOMLEFT", "Perl_Target_NameFrame", "TOPLEFT", 0, 46);
						end
					else
						if (numBuffs > 8) then
							Perl_Target_DebuffFrame:SetPoint("BOTTOMLEFT", "Perl_Target_NameFrame", "TOPLEFT", 0, 51);
						else
							Perl_Target_DebuffFrame:SetPoint("BOTTOMLEFT", "Perl_Target_NameFrame", "TOPLEFT", 0, 25);
						end
					end
				else
					if (showclassframe == 1 or showrareeliteframe == 1) then
						Perl_Target_DebuffFrame:SetPoint("BOTTOMLEFT", "Perl_Target_NameFrame", "TOPLEFT", 0, 16);
					else
						Perl_Target_DebuffFrame:SetPoint("BOTTOMLEFT", "Perl_Target_NameFrame", "TOPLEFT", 0, -5);
					end
				end
			end

			Perl_Target_DebuffFrame:Show();
			if (numDebuffs > 8) then
				Perl_Target_DebuffFrame:SetWidth(221);			-- 5 + 8 * (24 + 3)	5 = border gap, 8 buffs across, 24 = icon size + 3 for pixel alignment, only holds true for default size
				Perl_Target_DebuffFrame:SetHeight(61);			-- 2 rows tall
			else
				Perl_Target_DebuffFrame:SetWidth(5 + numDebuffs * 27);	-- Dynamically extend the background frame
				Perl_Target_DebuffFrame:SetHeight(34);			-- 1 row tall
			end
		end
	end
end

function Perl_Target_Buff_UpdateCPMeter()
	local debuffapplications;
	local playerclass = UnitClass("player");

	if (playerclass == PERL_LOCALIZED_MAGE) then
		debuffapplications = Perl_Target_Buff_GetApplications(PERL_LOCALIZED_TARGET_FIRE_VULNERABILITY);
	elseif (playerclass == PERL_LOCALIZED_PRIEST) then
		debuffapplications = Perl_Target_Buff_GetApplications(PERL_LOCALIZED_TARGET_SHADOW_VULNERABILITY);
	elseif (playerclass == PERL_LOCALIZED_WARRIOR) then
		debuffapplications = Perl_Target_Buff_GetApplications(PERL_LOCALIZED_TARGET_SUNDER_ARMOR);
	elseif ((playerclass == PERL_LOCALIZED_ROGUE) or (playerclass == PERL_LOCALIZED_DRUID)) then
		return;
	else
		Perl_Target_NameFrame_CPMeter:Hide();
		return;
	end

	if (debuffapplications == 0) then
		Perl_Target_CPFrame:Hide();
		Perl_Target_NameFrame_CPMeter:Hide();
	else
		if (comboframedebuffs == 1) then
			Perl_Target_CPText:SetText(debuffapplications);
			Perl_Target_CPText:SetTextHeight(20);
			if (debuffapplications == 5) then
				Perl_Target_CPFrame:Show();
				Perl_Target_CPText:SetTextColor(1, 0, 0);	-- red text
			elseif (debuffapplications == 4) then
				Perl_Target_CPFrame:Show();
				Perl_Target_CPText:SetTextColor(1, 0.5, 0);	-- orange text
			elseif (debuffapplications == 3) then
				Perl_Target_CPFrame:Show();
				Perl_Target_CPText:SetTextColor(1, 1, 0);	-- yellow text
			elseif (debuffapplications == 2) then
				Perl_Target_CPFrame:Show();
				Perl_Target_CPText:SetTextColor(0.5, 1, 0);	-- yellow-green text
			elseif (debuffapplications == 1) then
				Perl_Target_CPFrame:Show();
				Perl_Target_CPText:SetTextColor(0, 1, 0);	-- green text
			else
				Perl_Target_CPFrame:Hide();
			end
		else
			Perl_Target_CPFrame:Hide();
		end

		if (nameframecombopoints == 1) then				-- this isn't nested since you can have both combo point styles on at the same time
			Perl_Target_NameFrame_CPMeter:SetMinMaxValues(0, 5);
			Perl_Target_NameFrame_CPMeter:SetValue(debuffapplications);
			if (debuffapplications == 5) then
				Perl_Target_NameFrame_CPMeter:Show();
			elseif (debuffapplications == 4) then
				Perl_Target_NameFrame_CPMeter:Show();
			elseif (debuffapplications == 3) then
				Perl_Target_NameFrame_CPMeter:Show();
			elseif (debuffapplications == 2) then
				Perl_Target_NameFrame_CPMeter:Show();
			elseif (debuffapplications == 1) then
				Perl_Target_NameFrame_CPMeter:Show();
			else
				Perl_Target_NameFrame_CPMeter:Hide();
			end
		else
			Perl_Target_NameFrame_CPMeter:Hide();
		end
	end
end

function Perl_Target_Buff_GetApplications(debuffname)
	local debuffApplications;
	local i = 1;

	while UnitDebuff("target", i) do
		Perl_Target_Tooltip:SetOwner(this, "ANCHOR_BOTTOMRIGHT");
		Perl_Target_Tooltip:SetUnitDebuff("target", i);
		if (Perl_Target_TooltipTextLeft1:GetText() == debuffname) then
			_, debuffApplications = UnitDebuff("target", i);
			Perl_Target_Tooltip:Hide();
			return debuffApplications;
		end

		i = i + 1;
	end

	Perl_Target_Tooltip:Hide();
	return 0;
end

function Perl_Target_Reset_Buffs()
	local button;
	for buffnum=1,16 do
		button = getglobal("Perl_Target_Buff"..buffnum);
		button:Hide();
		button = getglobal("Perl_Target_Debuff"..buffnum);
		button:Hide();
	end
end

function Perl_Target_SetBuffTooltip()
	GameTooltip:SetOwner(this, "ANCHOR_BOTTOMRIGHT");
	if (this:GetID() > 16) then
		GameTooltip:SetUnitDebuff("target", this:GetID()-16, displaycastablebuffs);
	else
		GameTooltip:SetUnitBuff("target", this:GetID(), displaycastablebuffs);
	end
end


--------------------
-- Click Handlers --
--------------------
function Perl_TargetDropDown_OnLoad()
	UIDropDownMenu_Initialize(this, Perl_TargetDropDown_Initialize, "MENU");
end

function Perl_TargetDropDown_Initialize()
	local menu, name;
	if (UnitIsUnit("target", "player")) then
		menu = "SELF";
	elseif (UnitIsUnit("target", "pet")) then
		menu = "PET";
	elseif (UnitIsPlayer("target")) then
		if (UnitInParty("target")) then
			menu = "PARTY";
		else
			menu = "PLAYER";
		end
	else
		menu = "RAID_TARGET_ICON";
		name = RAID_TARGET_ICON;
	end
	if (menu) then
		UnitPopup_ShowMenu(Perl_Target_DropDown, menu, "target", name);
	end
end

function Perl_Target_MouseClick(button)
	if (Perl_Custom_ClickFunction) then				-- Check to see if someone defined a custom click function
		if (Perl_Custom_ClickFunction(button, "target")) then	-- If the function returns true, then we return
			return;
		end
	end								-- Otherwise, it did nothing, so take default action

	if (PCUF_CASTPARTYSUPPORT == 1) then
		if (not string.find(GetMouseFocus():GetName(), "Name") or PCUF_NAMEFRAMECLICKCAST == 1) then
			if (CastPartyConfig) then
				CastParty.Event.OnClickByUnit(button, "target");
				return;
			elseif (Genesis_MouseHeal and Genesis_MouseHeal("target", button)) then
				return;
			elseif (CH_Config) then
				if (CH_Config.PCUFEnabled) then
					CH_UnitClicked("target", button);
					return;
				end
			elseif (SmartHeal) then
				if (SmartHeal.Loaded and SmartHeal:getConfig("enable", "clickmode")) then
					local KeyDownType = SmartHeal:GetClickHealButton();
					if(KeyDownType and KeyDownType ~= "undetermined") then
						SmartHeal:ClickHeal(KeyDownType..button, "target");
					else
						SmartHeal:DefaultClick(button, "target");
					end
					return;
				end
			end
		end
	end

	if (button == "LeftButton") then
		if (SpellIsTargeting()) then
			SpellTargetUnit("target");
		elseif (CursorHasItem()) then
			DropItemOnUnit("target");
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
		ToggleDropDownMenu(1, nil, Perl_Target_DropDown, "Perl_Target_NameFrame", 40, 0);
	end
end

function Perl_Target_DragStart(button)
	if (button == "LeftButton" and locked == 0) then
		Perl_Target_Frame:StartMoving();
	end
end

function Perl_Target_DragStop(button)
	Perl_Target_Frame:StopMovingOrSizing();
end

function Perl_Target_OnShow()
	if (soundtargetchange == 1) then
		if (UnitIsEnemy("target", "player")) then
			PlaySound("igCreatureAggroSelect");
		elseif (UnitIsFriend("player", "target")) then
			PlaySound("igCharacterNPCSelect");
		else
			PlaySound("igCreatureNeutralSelect");
		end
	end
end

function Perl_Target_OnHide()
	if (soundtargetchange == 1) then
		PlaySound("INTERFACESOUND_LOSTTARGETUNIT");
	end
end


-------------
-- Tooltip --
-------------
function Perl_Target_Tip()
	UnitFrame_Initialize("target")
end

function UnitFrame_Initialize(unit)	-- Hopefully this doesn't break any mods
	this.unit = unit;
end


----------------------
-- myAddOns Support --
----------------------
function Perl_Target_myAddOns_Support()
	-- Register the addon in myAddOns
	if (myAddOnsFrame_Register) then
		local Perl_Target_myAddOns_Details = {
			name = "Perl_Target",
			version = PERL_LOCALIZED_VERSION,
			releaseDate = PERL_LOCALIZED_DATE,
			author = "Perl; Maintained by Global",
			email = "global@g-ball.com",
			website = "http://www.curse-gaming.com/mod.php?addid=2257",
			category = MYADDONS_CATEGORY_OTHERS
		};
		Perl_Target_myAddOns_Help = {};
		Perl_Target_myAddOns_Help[1] = "/perl";
		myAddOnsFrame_Register(Perl_Target_myAddOns_Details, Perl_Target_myAddOns_Help);
	end
end
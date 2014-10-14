local InfoMsg=true;				-- Is info messages shown
local DebugMsg=false;			-- Is debug messages shown
local Loaded=false;				-- Is addon loaded
local ForceVisible=false;		-- If bar is forced to be shown

-- Spell data
local SpellName=nil;			-- Spell name, set to nil to disable
local SpellRank=0;				-- Spell rank
local SpellTime=0;				-- Spell cast time
local SpellHealAmount=1;		-- Suspected healing amount
local SpellTarget=nil;			-- Spell target
local SpellTargetName=nil;		-- Target's name
local UpdateHealth=false;		-- Is target's health changed
local OverhealDetected=false;	-- If spell detected to do overhealing

-- Party data
local GroupMaxHeal={};			-- How much each party member can receive healing, sorted by name

-- Healing meter
local TotalHealing=0;			-- Total healing
local TotalOverHealing=0;		-- Total overhealing

-- Saved variables
HealingEstimatorData=
	{
	Scale=1;					-- Healing bar scale
	Limit=0.5;					-- Overhealing alert limit
	Icon=true;					-- If minimap icon is shown
	IconPos=4.98;				-- Position in radians
	IconAnchoredAtMinimap=true;	-- If icon is anchored to minimap
	ConvertCrits=true;			-- If crits are to be converted to normal heals, new in 1.2
	};
HealingEstimatorCharData={};	-- Spell data goes here

--[[
TODO:
- Different limits for different spells
- Fix localization in menu
]]--

--------------------------------------------------------------------
-- Debug print
--
function HealingEstimator_Print(Visible, Txt)
	if (Visible and Txt) then
		DEFAULT_CHAT_FRAME:AddMessage("|cFFA0A0FF[HealingEstimator]|r "..Txt,0.5,0.5,1);
	end
end

--------------------------------------------------------------------
-- Initialization
--------------------------------------------------------------------

--------------------------------------------------------------------
-- OnLoad
--
function HealingEstimator_OnLoad()
	-- Register events

	-- For initialization
	this:RegisterEvent("VARIABLES_LOADED");
end

--------------------------------------------------------------------
-- Init
--
function HealingEstimator_Init()
	if (Loaded) then
		return;
	end
	Loaded=true;

	-- Check if addon needs to be enabled
	if ( not HealingEstimator_IsHealingClass(UnitClass("player")) ) then
		return;
	end

	-- Register more events
	-- When unit heal changes
	this:RegisterEvent("UNIT_HEALTH");
	this:RegisterEvent("UNIT_MAXHEALTH");
	this:RegisterEvent("PARTY_MEMBERS_CHANGED");
	-- Healing spell you casted
	this:RegisterEvent("CHAT_MSG_SPELL_SELF_BUFF");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_BUFFS");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_PARTY_BUFFS");
	-- For spells
	this:RegisterEvent("SPELLCAST_START");
	this:RegisterEvent("SPELLCAST_DELAYED");
	this:RegisterEvent("SPELLCAST_STOP");
	this:RegisterEvent("SPELLCAST_FAILED");
	this:RegisterEvent("SPELLCAST_INTERRUPTED");

	-- Set slash command
	SlashCmdList["HEALINGESTIMATORCOMMAND"] = HealingEstimator_SlashHandler;
	SLASH_HEALINGESTIMATORCOMMAND1 = "/healingestimator";
	SLASH_HEALINGESTIMATORCOMMAND2 = "/heal";

	-- Set new saved variables
	if (HealingEstimatorData.ConvertCrits==nil) then HealingEstimatorData.ConvertCrits=true; end

	-- Init data
	GroupMaxHeal={};
	GroupMaxHeal[UnitName("player")]=UnitHealthMax("player")-UnitHealth("player");

	-- Set scale
	HealingEstimator:SetScale( HealingEstimatorData.Scale );

	-- Set BarBG color
	HealingEstimatorBarBG:SetVertexColor(0.4,0.4,0.4, 0.8);

	-- Initialize the spell target and rank resolving engine
	HealingEstimator_InitTargetEngine();

	-- Replace text parsing functions on "difficult" locales
	local Locale=GetLocale();
	if (Locale=="frFR") then
		HealingEstimator_ParseSelfBuff=HealingEstimator_ParseSelfBuff_FR;
		HealingEstimator_ParsePeriodicSelfBuff=HealingEstimator_ParsePeriodicSelfBuff_FR;
	end

	-- Print welcome message
	HealingEstimator_Print(InfoMsg,HealingEstimatorLoc.Welcome);
end

--------------------------------------------------------------------
-- Slash command handling
--------------------------------------------------------------------

--------------------------------------------------------------------
-- Slash handler
--
function HealingEstimator_SlashHandler(msg)
	if (msg=="cancel") then
		-- "/heal cancel" - cancels the spell if it would be overhealing
		HealingEstimator_CancelSpell();

	elseif (msg=="debug") then
		-- "/heal debug" - turn debug on/off
		if (DebugMsg) then
			DebugMsg=false;
		else
			DebugMsg=true;
		end

	else
		-- Show menu
		HealingEstimatorMenu:Show();
	end
end

--------------------------------------------------------------------
-- Event handling
--------------------------------------------------------------------

--------------------------------------------------------------------
-- OnEvent
--
function HealingEstimator_OnEvent(event)
	--HealingEstimator_Print(DebugMsg,event);

	if (event=="UNIT_HEALTH" or event=="UNIT_MAXHEALTH") then
		-- Unit health changed
		-- Update max heal
		local Name=UnitName(arg1);
		if (Name) then
			GroupMaxHeal[Name]=UnitHealthMax(arg1)-UnitHealth(arg1);
			HealingEstimator_Print(DebugMsg,Name..": "..GroupMaxHeal[Name]);
		end
		-- Check if this is spell target
		if (arg1==SpellTarget) then
			UpdateHealth=true;
			
			-- Update maximum values if needed
			if (event=="UNIT_MAXHEALTH") then
				local MaxHealth=UnitHealthMax(arg1);
				HealingEstimatorBar:SetMinMaxValues(0,MaxHealth);
				HealingEstimatorHealingBar:SetMinMaxValues(0,MaxHealth);
				HealingEstimatorHealFlash:SetWidth( (SpellHealAmount*200)/MaxHealth );
			end
		end
	elseif (event=="PARTY_MEMBERS_CHANGED") then
		-- Party changed
		-- Clear data
		GroupMaxHeal={};
		-- Set player data
		GroupMaxHeal[UnitName("player")]=UnitHealthMax("player")-UnitHealth("player");

		-- Set group data
		local c;
		local Group,Count=HealingEstimator_GetGroupInfo();
		for c=1,Count do
			local Name=Group..c;
			if (UnitName(Name)) then
				GroupMaxHeal[UnitName(Name)]=UnitHealthMax(Name)-UnitHealth(Name);
			end
		end

	elseif (event=="SPELLCAST_START") then
		-- Spellcast started, get spell info
		SpellTime=arg2/1000;
		HealingEstimator_StartSpell(arg1);
	elseif (event=="SPELLCAST_DELAYED") then
		-- Spellcast was delayed, add cast time
		SpellTime=SpellTime+(arg1/1000);
	elseif (event=="SPELLCAST_FAILED") then
		-- Spell failed
		SpellName=nil;
		OverhealDetected=false;
	elseif (event=="SPELLCAST_INTERRUPTED") then
		-- Spell interrupted
		SpellName=nil;
		OverhealDetected=false;
	elseif (event=="SPELLCAST_STOP") then
		-- Spell finished
		SpellName=nil;
		OverhealDetected=false;

	elseif (event=="CHAT_MSG_SPELL_SELF_BUFF") then
		-- You healed someone
		-- Parse combat log message at localized function
		HealingEstimator_AddHealing( true, HealingEstimator_ParseSelfBuff(arg1) );
		
		-- Show flash
		HealingEstimatorFlash:Show();
		HealingEstimatorHealFlash:SetPoint("LEFT","HealingEstimatorHealingBar","LEFT");
		HealingEstimatorHealFlash:Show();

	elseif (event=="CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS" or
			event=="CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS" or
			event=="CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_BUFFS" or
			event=="CHAT_MSG_SPELL_PERIODIC_PARTY_BUFFS" ) then
		-- Your heal-over-time healed someone
		-- Parse combat log message at localized function
		HealingEstimator_AddHealing( false, HealingEstimator_ParsePeriodicSelfBuff(arg1) );

	elseif (event == "VARIABLES_LOADED") then
		-- Variables loaded, do initialization
		HealingEstimator_Init();
	end
end

--------------------------------------------------------------------
-- Misc functions
--------------------------------------------------------------------

--------------------------------------------------------------------
-- Cancels spell if it is overhealing
--
function HealingEstimator_CancelSpell()
	if (OverhealDetected) then
		SpellStopCasting();
		OverhealDetected=false;	-- Clear the flag
	end
end

--------------------------------------------------------------------
-- Adds healing data
--
function HealingEstimator_AddHealing(UpdateSpellData, Spell, Target, Heal, Crit)
	-- If spell name and heal value was resolved
	if (not (Spell and Target and Heal)) then
		-- Was not, bail out
		return;
	end

	-- Update healing amount
	Heal=Heal+0;		-- Convert healing amount to number
	TotalHealing=TotalHealing+Heal;
	
	-- Check that unit data exists
	if (not GroupMaxHeal[Target]) then 
		-- Somehow unit data was missing, do not process further
		return;
	end
	local MaxHeal=GroupMaxHeal[Target];

	-- Check overhealing
	if (Heal>MaxHeal) then
		TotalOverHealing=TotalOverHealing+(Heal-MaxHeal);
		local Over=floor(((Heal-MaxHeal)/Heal)*100);
		HealingEstimator_Print(DebugMsg,Over.."% overheal");
	end
	HealingEstimatorPie_SetValue(TotalOverHealing/TotalHealing);

	-- Check if healing data is to be updated to spell data
	if (not UpdateSpellData) then
		return;
	end

	-- Check if heal was critical
	if (Crit and HealingEstimatorData.ConvertCrits) then
		Heal=Heal/1.5;
	end

	-- Make sure that data exists
	HealingEstimator_Print(DebugMsg,Spell.." "..Heal);
	if (not HealingEstimatorCharData[Spell]) then return; end
	if (not HealingEstimatorCharData[Spell][SpellRank]) then return; end
	local Avg=HealingEstimatorCharData[Spell][SpellRank];
	if (Avg==0) then
		Avg=Heal;
	else
		Avg=(Avg*3 + Heal)/4;	
		--Avg=(Avg+Heal)/2;
	end
	HealingEstimatorCharData[Spell][SpellRank]=Avg;
end

--------------------------------------------------------------------
-- Returns healing data
--
function HealingEstimator_GetData()
	return TotalHealing,TotalOverHealing;
end

--------------------------------------------------------------------
-- Clears healing data
--
function HealingEstimator_ClearData()
	TotalHealing=0;
	TotalOverHealing=0;
	HealingEstimatorPie_SetValue(0);
	HealingEstimator_Print(InfoMsg,"Healing data cleared");
end

--------------------------------------------------------------------
-- Forces bar visible
--
function HealingEstimator_ForceVisible(Value)
	ForceVisible=Value;
	if (ForceVisible) then
		HealingEstimatorBar:SetMinMaxValues(0,1);
		HealingEstimatorBar:SetValue(1);
		HealingEstimatorHealingBar:SetMinMaxValues(0,1);
		HealingEstimatorHealingBar:SetValue(0);
		
		HealingEstimatorText:SetText(HealingEstimatorLoc.TargetName);
		HealingEstimatorFlash:Hide();
		HealingEstimatorHealFlash:Hide();
		HealingEstimator:SetAlpha(1);
		HealingEstimator:Show();
	else
		HealingEstimator:Hide();
	end	
end

--------------------------------------------------------------------
-- Tells if heal bar can be moved
--
function HealingEstimator_CanMove()
	if (IsShiftKeyDown() or ForceVisible) then
		return true;
	end
	return false;
end

--------------------------------------------------------------------
-- Gets the "name" and count of group
-- i.e. returns "party" or "raid", so those can be used like "partyX" or "raidX"
--
function HealingEstimator_GetGroupInfo()
	-- Assume that player is in raid
	local Group="raid";
	local Count=GetNumRaidMembers();

	-- If he is not in the group, assume party
	if (Count==0) then
		Group="party";
		Count=GetNumPartyMembers();
	end

	-- If he isn't even in raid, then he is alone
	if (Count==0) then
		Group=nil;
		Count=0;
	end

	-- Return group data
	return Group,Count;
end

--------------------------------------------------------------------
-- Tries to get group name for given unit
--
function HealingEstimator_GetGroupName(Unit)
	-- Check if unit it player
	if (UnitIsUnit(Unit,"player")) then
		return "player";
	else
		-- Check if unit is in group or raid
		local Group,Count = HealingEstimator_GetGroupInfo();
		if (Count~=0) then
			local c;
				for c=1,Count do
				if (UnitIsUnit(Unit,Group..c)) then
					-- Unit was found, return
					HealingEstimator_Print(DebugMsg,"Group target: "..Group..c);
					return Group..c;
				end
			end
		end
	end

	-- Unit was not found from group or raid
	return nil;
end

--------------------------------------------------------------------
-- Sets visual data of the unit
--
function HealingEstimator_SetTargetData(Unit,HealAverage)
	-- Check that unit is not nil
	if (not Unit) then
		return;
	end

	-- Store target name
	SpellTargetName=UnitName(Unit);

	-- Set target health bar
	local Health=UnitHealth(Unit);
	local MaxHealth=UnitHealthMax(Unit);
	HealingEstimatorBar:SetMinMaxValues(0,MaxHealth);
	HealingEstimatorBar:SetValue(Health);
	HealingEstimatorText:SetText(SpellTargetName);

	-- Set healing bar
	HealingEstimatorHealingBar:SetMinMaxValues(0,MaxHealth);
	HealingEstimatorHealingBar:SetValue(HealAverage);
	local Pos=(Health*200)/MaxHealth;
	HealingEstimatorHealingBar:SetPoint("LEFT","HealingEstimatorBar","LEFT",Pos,0);
	HealingEstimatorHealingBar:SetStatusBarColor(1,1,0);

	-- Set flash bar width
	HealingEstimatorHealFlash:SetWidth( (HealAverage*200)/MaxHealth );

	-- Show bars
	HealingEstimatorFlash:Hide();
	HealingEstimatorHealFlash:Hide();
	HealingEstimator:SetAlpha(1);
	HealingEstimator:Show();
	UpdateHealth=true;
end

--------------------------------------------------------------------
-- StartSpell
-- Does the initialization for spellcast
--
function HealingEstimator_StartSpell(arg1)
	-- Check if spell is healing spell (localized function)
	if (not HealingEstimator_IsHealingSpell(arg1)) then
		-- It wasn't
		return;
	end

	-- Get spell info
	local HealAverage;
	SpellName,SpellRank,HealAverage,SpellTarget=HealingEstimator_GetSpellInfo();

	-- Check that unit exists
	if ((not SpellTarget) or (not UnitName(SpellTarget))) then
		-- There is no target, but still casting is going on
		-- Probably spell was run with selfcast, can't be sure
		return;
	end

	-- Make sure that spell data exists
	if (not HealingEstimatorCharData[SpellName]) then
		HealingEstimatorCharData[SpellName]={};
	end
	-- Check also that rank data exists
	if (not HealingEstimatorCharData[SpellName][SpellRank]) then
		-- The rank was not found, create it's data
		HealingEstimatorCharData[SpellName][SpellRank]={};
		HealingEstimatorCharData[SpellName][SpellRank]=HealAverage;
	end

	-- Get healing value
	SpellHealAmount=HealingEstimatorCharData[SpellName][SpellRank];
	HealingEstimator_Print(DebugMsg,SpellName.." "..SpellRank.." ("..SpellHealAmount..") -> "..SpellTarget);

	-- Try to find target unit and set data
	SpellTarget=HealingEstimator_GetGroupName(SpellTarget);
	HealingEstimator_SetTargetData(SpellTarget,SpellHealAmount);
end

--------------------------------------------------------------------
-- OnUpdate
-- Updates the target health, healing & overhealing values
--
function HealingEstimator_OnUpdate(Time)
	-- Check that there is some spell
	if (SpellName==nil or SpellTarget==nil) then
		--HealingEstimator:Hide();
		
		-- If this is forced to be visible don't fade out
		if (ForceVisible) then return; end
		
		-- Fade out
		local Alpha=this:GetAlpha()-Time;
		if (Alpha<0) then
			this:Hide();
		end
		-- Set alpha
		this:SetAlpha(Alpha);
		return;
	end
	-- Update time
	SpellTime=SpellTime-Time;

	-- Check if update is needed
	if (not UpdateHealth) then
		return;
	end
	UpdateHealth=false;

	-- Target is lost somehow
	if (UnitName(SpellTarget) ~= SpellTargetName) then
		SpellName=nil;
		OverhealDetected=false;
		return;
	end

	-- Find target health
	local Health=UnitHealth(SpellTarget);
	local MaxHealth=UnitHealthMax(SpellTarget);
	local MaxHeal=GroupMaxHeal[SpellTargetName];
	if (not MaxHeal) then
		-- Somehow unit data is missing
		MaxHeal=MaxHealth-Health;	-- Calculate "rough" value
	end

	-- Calculate healing and overhealing values
	local OverHealing=SpellHealAmount-MaxHeal;
	HealingEstimator_Print(DebugMsg,Health.."/"..MaxHealth..": "..SpellHealAmount.."("..OverHealing..")");

	if (OverHealing < 0) then
		-- There is no overhealing
		OverHealing=0;
	end

	-- Update target health bar
	HealingEstimatorBar:SetValue(Health);

	-- Set color of healing bar
	-- Yellow (1,1,0) if overhealing is under the limit
	-- Red    (1,0,0) if there is overhealing
	local Green=1;
	local Ratio=OverHealing/SpellHealAmount;
	OverhealDetected=false;
	if (Ratio > HealingEstimatorData.Limit) then
		-- Overhealing detected, change color to red
		OverhealDetected=true;
		Green=0;
	end
	HealingEstimatorHealingBar:SetStatusBarColor(1,Green,0);

	-- Update healing bar position
	local Pos=(Health*200)/MaxHealth;
	if (Pos>200) then
		Pos=200;
	end
	HealingEstimatorHealingBar:SetPoint("LEFT","HealingEstimatorBar","LEFT",Pos,0);
end

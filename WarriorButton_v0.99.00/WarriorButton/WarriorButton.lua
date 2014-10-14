--[[
  Written by Plumac - Thanks to BigRedBrent and Bhaerau whose code has provided the underpinnings for this mod
  
  Available Functions:
		WarriorButton()
		
		/wb
		/warriorbutton
		
  Fully Controlled Abilities:
		Battle Shout
		Bloodthirst
		Charge
		Cleave
		Demoralizing Shout 
		Execute
		Hamstring
		Heroic Strike
		Intercept
		Mortal Strike
		Overpower
		Piercing Howl
		Pummel
		Rend
		Revenge
		Shield Bash
		Shield Slam
		Sunder Armor
		Sweeping Strikes
		Thunder Clap
		Whirlwind
						
  Partially Conrolled Abilities:
		Berserker Rage
		Bloodrage
		Concussion Blow
		Death Wish
		Disarm
		Last Stand
		Mocking Blow
		Shield Block
		Taunt
						
  Uncontrolled Abilities:
		Challenging Shout
		Intimidating Shout
		Recklessness
		Retaliation
		Shield Wall
		Slam

Version 0.99.00 (August 2006)
		Improved Berserker Rage and Bloodrage use
		Improved interaction between Heroic Strike and Whirlwind
		Improved rage saving for use of Whirlwind and Sweeping Strikes
		Improved tanking code with regards to Improved Sunder Armor
		Improved use of Heroic Strike to prevent possible interference with other abilities
		Changed funcitonality of Constant Shield Block to priorize shield block above hate generating attacks
		Updated tooltips
		Updated default settings
		
Version 0.98.00 (August 2006)
		Improved totem recognition
		Improved AoE logic with relation to Sweeping Strikes and Whirlwind
		Improved PVP use of Rend against Rogues
		Improved Rend immunity detection
		Fixed bug causing auto targeting when auto target is disabled
		Fixed bug causing use of AoE abilities at inappropriate rage levels
		Fixed another bug related to AoE that may have been causing unneccessary target switching
		Fixed bug causing the mod to fail to dismount
		Removed dependency on MountMaster
				
Version 0.97.01 (August 2006)
		Minor Bug fix related to AoE Damage
		Fixed Hook Battle Shout tooltip
		
Version 0.97.00 (August 2006)
		Added Concussion Blow toggle box
		Updated use of Concussion Blow
		Sunder Armor should now throw occasional Sunders while tanking to maintain the debuff once 5 sunders are reached and unlimited Sunder Armor is not selected
		Removed rage checks for changing to Defensive Stance while tanking
		Disabled low rage generation code that caused a switch to berserker stance while in tank or off tank mode
		Ony/Nef/Mag fear code updated and should now add a message to the main chat menu when it detects an incoming raid fear
		Magmadar fear code has been tested and works successfully
		Significant update to Off Tanking code
		Fixed Heroic Strike related bug causing the player to drop below the rage buffer needlessly
		Fixed Major Bug causing infrequent code lock ups and preventing use of the Hooked Heroic Strike
		Changed Hook option to Hook Battle Shout instead of Heroic Strike due to technical issues
			
Version 0.96.10 (August 2006)
		Fixed a small issue with different zorlen versions
		Fixed an issue with Heroic Strike overwriting Cleave
		Fixed an issue with Concussion Blow while tanking
		Added castConcussionBlow to WarriorButton to reduce dependence on Zorlen version
		
Version 0.96.00 (August 2006)
		Further updates to tanking code based on tester feedback
		Major updates to use of Heroic Strike and Cleave
		Added toggle box for Constant Shield Blocks
		Added toggle box for Stance Changes
		Improved Berserker Rage use
		Fixed a Heroic Strike related bug that caused infrequent lock-ups in the code
		Removed code preventing the mod from attacking a targeted mob which is CC'd
		Added code preventing the mod from automatically targeting a CC'd mob
		
Version 0.95.00 (August 2006)
		Added toggle box for use of 31 point abilities
		Added toggle box for use of Heroic Strike
		Added toggle box for use of Overpower/Revenge
		Reorganized layout of Options Menu
		Updated dismounting code for new dependency versions
		
Version 0.94.10 (August 2006)
		Auto-Detects incoming fears from Onyxia/Nefarion and pre-emptively uses berserker rage or death wish to avoid them if the break fears option is set
		Auto-Detects incoming fear from Magmadar if CT Raid is present and pre-emptively uses berserker rage or death wish to avoid them if the break fears option is set
		Updated tooltips
		
Version 0.94.00 (August 2006)
		Updated tanking code
		Changed default settings based on tester input
		Changed Priority Sunder Armor to also perform unlimited sunders
		Added Shield Block option
		
Version 0.93.10 (August 2006)
		Added tooltips to the options menu

Version 0.93.00 (August 2006)
		Minor improvements to the use of Overpower
		Added priority sunder armor option
		Added prefer berserker stance option
		
Version 0.92.11 (August 2006)
		Added castLastStand() and castPiercingHowl() to this mod to reduce dependance on Zorlen Library Version
		
Version 0.92.10 (August 2006)
		Fixed bugs in the use of Last Stand
		Added automatic rogue rends in PVP - This will occur even if the rend box is unchecked
		Added Berserker Rage toggle box - This does not affect whether berserker rage is used to break fears/incapacitates.
		Improved variable initialization, defaults should now load on first use.
		
Version 0.92.00 (July 2006)
		Fixed a bug dealing preventing auto fear breaking
		Fixed a bug dealing with Berserker Rage and fear breaking that caused unnecessary use of Berserker Rage
		Added configuration boxes for auto targeting and auto tanking when a shield is equippped
		Corrected the Attack button check
		
Version 0.91.00 (July 2006)
		Sunder Armor and Heroic Strike related bugs fixed
	
Version 0.90.00 (June 2006)
		Initial version released
]]

--------------------------------------------------
--
-- Variables
--
--------------------------------------------------

WarriorButton_version = "0.99.00"
local WarriorButton_SpellInterrupt = nil
local WarriorButton_InstantCooldown = nil
local WarriorButton_ChargeDelay = nil
local WarriorButton_AoEDelay = nil
local WarriorButton_ShortAoEDelay = nil 
local WarriorButtonAoE = false
local WarriorButton_StanceDelay = nil
local WarriorButton_Delay = nil
local WarriorButton_ShieldBlockDelay = nil
local WarriorButton_SunderArmorDelay = nil
local WarriorButton_FearEvent = nil
local WarriorButton_FearTime = nil
local WarriorButton_HeroicStrike = nil
local WarriorButton_Cleave = nil
local WB_RendSpellCastImmune = nil
local WarriorButton_RogueEvasion = nil
local totem = false

local function WarriorButton_Configuration_Init()
	if (not WarriorButton_Configuration) then
		WarriorButton_Configuration = { }
	end
	if (WarriorButton_Configuration["Enabled"] == nil) then
		WarriorButton_Configuration["Enabled"] = true --Set to false to disable the addon
	end
	if (WarriorButton_Configuration["Mode"] == nil) then
		WarriorButton_Configuration["Mode"] = nil --Set this to change between normal, tanking, and offtanking WarriorButton_Configuration["Mode"] (nil, tank, hate) 
	end
	if (WarriorButton_Configuration["StanceChangeRage"] == nil) then
		WarriorButton_Configuration["StanceChangeRage"] = 15 --Set this to the amount of rage allowed to be wasted when switching stances
	end
	if (WarriorButton_Configuration["MaximumRage"] == nil) then
		WarriorButton_Configuration["MaximumRage"] = 10 --Set this to the maximum amount of rage allowed when using abilities to increase rage
	end
	if (WarriorButton_Configuration["BloodrageHealth"] == nil) then
		WarriorButton_Configuration["BloodrageHealth"] = 30 --Set this to the minimum percent of health to have when using Bloodrage
	end
	if (WarriorButton_Configuration["LastStandHealth"] == nil) then
		WarriorButton_Configuration["LastStandHealth"] = 10 --Set this to the minimum percent of health to have when using Bloodrage
	end
	if (WarriorButton_Configuration["RageBuffer"] == nil) then
		WarriorButton_Configuration["RageBuffer"] = 10 --Set the minimum amount of rage to protect for emergency abilities
	end
	if (WarriorButton_Configuration["InterruptTimer"] == nil) then
		WarriorButton_Configuration["InterruptTimer"] = 2 --Set the time to attempt to interrupt spells after they begin casting
	end
	if (WarriorButton_Configuration["InstantBuildTime"] == nil) then
		WarriorButton_Configuration["InstantBuildTime"] = 2 --Set the time to spend building rage for upcoming 31 point instant attacks
	end
	if (WarriorButton_Configuration["AoETime"] == nil) then
		WarriorButton_Configuration["AoETime"] = 1 --Set the frequency of multiple target checks in seconds
	end
	if (WarriorButton_Configuration["StanceTime"] == nil) then
		WarriorButton_Configuration["StanceTime"] = 1 --Set the minimum delay between stance changes
	end
	if (WarriorButton_Configuration["ShieldBlockTime"] == nil) then
		WarriorButton_Configuration["ShieldBlockTime"] = .5 --Set the amount of time after revenge is available before using shield block
	end
	if (WarriorButton_Configuration["MaxCycles"] == nil) then
		WarriorButton_Configuration["MaxCycles"] = 10 --Set the maximum number of function calls per second
	end
	if (WarriorButton_Configuration["Stance"] == nil) then
		WarriorButton_Configuration["Stance"] = false --Set to false for Battle DPS and true for Berserk DPS
	end
	if (WarriorButton_Configuration["AutoAttack"] == nil) then
		WarriorButton_Configuration["AutoAttack"] = true 
	end
	if (WarriorButton_Configuration["AutoTarget"] == nil) then
		WarriorButton_Configuration["AutoTarget"] = false
	end
	if (WarriorButton_Configuration["BattleShout"] == nil) then
		WarriorButton_Configuration["BattleShout"] = true
	end
	if (WarriorButton_Configuration["Charge"] == nil) then
		WarriorButton_Configuration["Charge"] = true
	end
	if (WarriorButton_Configuration["DemoShout"] == nil) then
		WarriorButton_Configuration["DemoShout"] = false
	end
	if (WarriorButton_Configuration["Disarm"] == nil) then
		WarriorButton_Configuration["Disarm"] = true
	end
	if (WarriorButton_Configuration["Execute"] == nil) then
		WarriorButton_Configuration["Execute"] = true
	end
	if (WarriorButton_Configuration["HeroicStrike"] == nil) then
		WarriorButton_Configuration["HeroicStrike"] = true
	end
	if (WarriorButton_Configuration["Intercept"] == nil) then
		WarriorButton_Configuration["Intercept"] = true
	end
	if (WarriorButton_Configuration["InterruptSpells"] == nil) then
		WarriorButton_Configuration["InterruptSpells"] = true
	end
	if (WarriorButton_Configuration["Rend"] == nil) then
		WarriorButton_Configuration["Rend"] = false
	end
	if (WarriorButton_Configuration["SnareRunners"] == nil) then
		WarriorButton_Configuration["SnareRunners"] = true
	end
	if (WarriorButton_Configuration["ThunderClap"] == nil) then
		WarriorButton_Configuration["ThunderClap"] = false
	end
	if (WarriorButton_Configuration["Whirlwind"] == nil) then
		WarriorButton_Configuration["Whirlwind"] = false
	end
	if (WarriorButton_Configuration["AutoTank"] == nil) then
		WarriorButton_Configuration["AutoTank"] = true 
	end
	if (WarriorButton_Configuration["AoE"] == nil) then
		WarriorButton_Configuration["AoE"] = false
	end
	if (WarriorButton_Configuration["Fear"] == nil) then
		WarriorButton_Configuration["Fear"] = true
	end
	if (WarriorButton_Configuration["Berserk"] == nil) then
		WarriorButton_Configuration["Berserk"] = true
	end
	if (WarriorButton_Configuration["PSunder"] == nil) then
		WarriorButton_Configuration["PSunder"] = true
	end
	if (WarriorButton_Configuration["ShieldBlock"] == nil) then
		WarriorButton_Configuration["ShieldBlock"] = true
	end
	if (WarriorButton_Configuration["HS"] == nil) then
		WarriorButton_Configuration["HS"] = true
	end
	if (WarriorButton_Configuration["Strike"] == nil) then
		WarriorButton_Configuration["Strike"] = true
	end
	if (WarriorButton_Configuration["Overpower"] == nil) then
		WarriorButton_Configuration["Overpower"] = true
	end
	if (WarriorButton_Configuration["SChange"] == nil) then
		WarriorButton_Configuration["SChange"] = true
	end
	if (WarriorButton_Configuration["CSB"] == nil) then
		WarriorButton_Configuration["CSB"] = false
	end
	if (WarriorButton_Configuration["Concussion"] == nil) then
		WarriorButton_Configuration["Concussion"] = true
	end
end

--------------------------------------------------

function WarriorButton_Configuration_Default()
	WarriorButton_Configuration["Enabled"] = true
	WarriorButton_Configuration["Mode"] = nil
	WarriorButton_Configuration["StanceChangeRage"] = 15
	WarriorButton_Configuration["MaximumRage"] = 10
	WarriorButton_Configuration["BloodrageHealth"] = 30
	WarriorButton_Configuration["LastStandHealth"] = 10
	WarriorButton_Configuration["RageBuffer"] = 10
	WarriorButton_Configuration["InterruptTimer"] = 2
	WarriorButton_Configuration["InstantBuildTime"] = 2
	WarriorButton_Configuration["AoETime"] = 1
	WarriorButton_Configuration["StanceTime"] = 1
	WarriorButton_Configuration["ShieldBlockTime"] = .5
	WarriorButton_Configuration["MaxCycles"] = 10
	WarriorButton_Configuration["Stance"] = false
	WarriorButton_Configuration["AutoAttack"] = true
	WarriorButton_Configuration["AutoTarget"] = false	
	WarriorButton_Configuration["BattleShout"] = true
	WarriorButton_Configuration["Charge"] = true
	WarriorButton_Configuration["DemoShout"] = false
	WarriorButton_Configuration["Disarm"] = true
	WarriorButton_Configuration["Execute"] = true
	WarriorButton_Configuration["HeroicStrike"] = true
	WarriorButton_Configuration["Intercept"] = true
	WarriorButton_Configuration["InterruptSpells"] = true
	WarriorButton_Configuration["Rend"] = false
	WarriorButton_Configuration["SnareRunners"] = true
	WarriorButton_Configuration["ThunderClap"] = false
	WarriorButton_Configuration["Whirlwind"] = false
	WarriorButton_Configuration["AutoTank"] = true
	WarriorButton_Configuration["AoE"] = false
	WarriorButton_Configuration["Fear"] = true
	WarriorButton_Configuration["Berserk"] = true
	WarriorButton_Configuration["PSunder"] = true
	WarriorButton_Configuration["ShieldBlock"] = true
	WarriorButton_Configuration["HS"] = true
	WarriorButton_Configuration["Strike"] = true
	WarriorButton_Configuration["Overpower"] = true
	WarriorButton_Configuration["SChange"] = true
	WarriorButton_Configuration["CSB"] = false
	WarriorButton_Configuration["Concussion"] = true
end

--------------------------------------------------

function WarriorButton_LoadSettings()
	WarriorButton_Configuration_Init()
	WBEnabled:SetChecked(WarriorButton_Check(WarriorButton_Configuration["Enabled"]))
	WBBerserker:SetChecked(WarriorButton_Check(WarriorButton_Configuration["Berserk"]))
	WBAutoAttack:SetChecked(WarriorButton_Check(WarriorButton_Configuration["AutoAttack"]))
	WBAutoTarget:SetChecked(WarriorButton_Check(WarriorButton_Configuration["AutoTarget"]))
	WBAutoTank:SetChecked(WarriorButton_Check(WarriorButton_Configuration["AutoTank"]))
	WBBattleShout:SetChecked(WarriorButton_Check(WarriorButton_Configuration["BattleShout"]))
	WBDemoShout:SetChecked(WarriorButton_Check(WarriorButton_Configuration["DemoShout"]))
	WBCharge:SetChecked(WarriorButton_Check(WarriorButton_Configuration["Charge"]))
	WBIntercept:SetChecked(WarriorButton_Check(WarriorButton_Configuration["Intercept"]))
	WBExecute:SetChecked(WarriorButton_Check(WarriorButton_Configuration["Execute"]))
	WBHeroicStrike:SetChecked(WarriorButton_Check(WarriorButton_Configuration["HeroicStrike"]))
	WBRend:SetChecked(WarriorButton_Check(WarriorButton_Configuration["Rend"]))
	WBWhirlwind:SetChecked(WarriorButton_Check(WarriorButton_Configuration["Whirlwind"]))
	WBThunderClap:SetChecked(WarriorButton_Check(WarriorButton_Configuration["ThunderClap"]))
	WBDisarm:SetChecked(WarriorButton_Check(WarriorButton_Configuration["Disarm"]))
	WBSnareRunners:SetChecked(WarriorButton_Check(WarriorButton_Configuration["SnareRunners"]))
	WBInterruptSpells:SetChecked(WarriorButton_Check(WarriorButton_Configuration["InterruptSpells"]))
	WBAoE:SetChecked(WarriorButton_Check(WarriorButton_Configuration["AoE"]))
	WBFear:SetChecked(WarriorButton_Check(WarriorButton_Configuration["Fear"]))
	WBPSunder:SetChecked(WarriorButton_Check(WarriorButton_Configuration["PSunder"]))
	WBStance:SetChecked(WarriorButton_Check(WarriorButton_Configuration["Stance"]))
	WBShieldBlock:SetChecked(WarriorButton_Check(WarriorButton_Configuration["ShieldBlock"]))
	WBHS:SetChecked(WarriorButton_Check(WarriorButton_Configuration["HS"]))
	WBStrike:SetChecked(WarriorButton_Check(WarriorButton_Configuration["Strike"]))
	WBOverpower:SetChecked(WarriorButton_Check(WarriorButton_Configuration["Overpower"]))
	WBSChange:SetChecked(WarriorButton_Check(WarriorButton_Configuration["SChange"]))
	WBCSB:SetChecked(WarriorButton_Check(WarriorButton_Configuration["CSB"]))
	WBConcussion:SetChecked(WarriorButton_Check(WarriorButton_Configuration["Concussion"]))
	WBRageBuffer:SetText(WarriorButton_Configuration["RageBuffer"])
	WBRageLoss:SetText(WarriorButton_Configuration["StanceChangeRage"])
	WBRageOff:SetText(WarriorButton_Configuration["MaximumRage"])
	WBHealthMin:SetText(WarriorButton_Configuration["BloodrageHealth"])
	WBLastStandHealth:SetText(WarriorButton_Configuration["LastStandHealth"])
	WBSpellWindow:SetText(WarriorButton_Configuration["InterruptTimer"])
	WBRageTime:SetText(WarriorButton_Configuration["InstantBuildTime"])
	WBAoETime:SetText(WarriorButton_Configuration["AoETime"])
	WBStanceDelay:SetText(WarriorButton_Configuration["StanceTime"])
	WBSBDelay:SetText(WarriorButton_Configuration["ShieldBlockTime"])
	WBMaxCycles:SetText(WarriorButton_Configuration["MaxCycles"])
	
	if (WarriorButton_Configuration["Mode"] == "Tank") then
		UIDropDownMenu_SetText("Tank", WBMode)
	elseif WarriorButton_Configuration["Mode"] == "Off Tank" then
		UIDropDownMenu_SetText("Off Tank", WBMode)
	else
		UIDropDownMenu_SetText("Standard", WBMode)
	end
end

--------------------------------------------------

function WarriorButton_SaveSettings()
	WarriorButton_Configuration["Enabled"] = WarriorButton_toBoolean(getglobal("WBEnabled"):GetChecked())
	WarriorButton_Configuration["Berserk"] = WarriorButton_toBoolean(getglobal("WBBerserker"):GetChecked())
	WarriorButton_Configuration["AutoAttack"] = WarriorButton_toBoolean(getglobal("WBAutoAttack"):GetChecked())
	WarriorButton_Configuration["AutoTarget"] = WarriorButton_toBoolean(getglobal("WBAutoTarget"):GetChecked())
	WarriorButton_Configuration["AutoTank"] = WarriorButton_toBoolean(getglobal("WBAutoTank"):GetChecked())
	WarriorButton_Configuration["BattleShout"] = WarriorButton_toBoolean(getglobal("WBBattleShout"):GetChecked())
	WarriorButton_Configuration["DemoShout"] = WarriorButton_toBoolean(getglobal("WBDemoShout"):GetChecked())
	WarriorButton_Configuration["Charge"] = WarriorButton_toBoolean(getglobal("WBCharge"):GetChecked())
	WarriorButton_Configuration["Intercept"] = WarriorButton_toBoolean(getglobal("WBIntercept"):GetChecked())
	WarriorButton_Configuration["Execute"] = WarriorButton_toBoolean(getglobal("WBExecute"):GetChecked())
	WarriorButton_Configuration["HeroicStrike"] = WarriorButton_toBoolean(getglobal("WBHeroicStrike"):GetChecked())
	WarriorButton_Configuration["Rend"] = WarriorButton_toBoolean(getglobal("WBRend"):GetChecked())
	WarriorButton_Configuration["Whirlwind"] = WarriorButton_toBoolean(getglobal("WBWhirlwind"):GetChecked())
	WarriorButton_Configuration["ThunderClap"] = WarriorButton_toBoolean(getglobal("WBThunderClap"):GetChecked())
	WarriorButton_Configuration["Disarm"] = WarriorButton_toBoolean(getglobal("WBDisarm"):GetChecked())
	WarriorButton_Configuration["SnareRunners"] = WarriorButton_toBoolean(getglobal("WBSnareRunners"):GetChecked())
	WarriorButton_Configuration["InterruptSpells"] = WarriorButton_toBoolean(getglobal("WBInterruptSpells"):GetChecked())
	WarriorButton_Configuration["AoE"] = WarriorButton_toBoolean(getglobal("WBAoE"):GetChecked())
	WarriorButton_Configuration["Fear"] = WarriorButton_toBoolean(getglobal("WBFear"):GetChecked())
	WarriorButton_Configuration["PSunder"] = WarriorButton_toBoolean(getglobal("WBPSunder"):GetChecked())
	WarriorButton_Configuration["Stance"] = WarriorButton_toBoolean(getglobal("WBStance"):GetChecked())
	WarriorButton_Configuration["ShieldBlock"] = WarriorButton_toBoolean(getglobal("WBShieldBlock"):GetChecked())
	WarriorButton_Configuration["HS"] = WarriorButton_toBoolean(getglobal("WBHS"):GetChecked())
	WarriorButton_Configuration["Strike"] = WarriorButton_toBoolean(getglobal("WBStrike"):GetChecked())
	WarriorButton_Configuration["Overpower"] = WarriorButton_toBoolean(getglobal("WBOverpower"):GetChecked())
	WarriorButton_Configuration["SChange"] = WarriorButton_toBoolean(getglobal("WBSChange"):GetChecked())
	WarriorButton_Configuration["CSB"] = WarriorButton_toBoolean(getglobal("WBCSB"):GetChecked())
	WarriorButton_Configuration["Concussion"] = WarriorButton_toBoolean(getglobal("WBConcussion"):GetChecked())
	WarriorButton_Configuration["RageBuffer"] = tonumber(getglobal("WBRageBuffer"):GetText())
	WarriorButton_Configuration["StanceChangeRage"] = tonumber(getglobal("WBRageLoss"):GetText())
	WarriorButton_Configuration["MaximumRage"] = tonumber(getglobal("WBRageOff"):GetText())
	WarriorButton_Configuration["BloodrageHealth"] = tonumber(getglobal("WBHealthMin"):GetText())
	WarriorButton_Configuration["LastStandHealth"] = tonumber(getglobal("WBLastStandHealth"):GetText())
	WarriorButton_Configuration["InterruptTimer"] = tonumber(getglobal("WBSpellWindow"):GetText())
	WarriorButton_Configuration["InstantBuildTime"] = tonumber(getglobal("WBRageTime"):GetText())
	WarriorButton_Configuration["AoETime"] = tonumber(getglobal("WBAoETime"):GetText())
	WarriorButton_Configuration["StanceTime"] = tonumber(getglobal("WBStanceDelay"):GetText())
	WarriorButton_Configuration["ShieldBlockTime"] = tonumber(getglobal("WBSBDelay"):GetText())
	WarriorButton_Configuration["MaxCycles"] = tonumber(getglobal("WBMaxCycles"):GetText())
	
	if UIDropDownMenu_GetText(WBMode) == "Tank" then
		WarriorButton_Configuration["Mode"] = "Tank"
	elseif UIDropDownMenu_GetText(WBMode) == "Off Tank" then
		WarriorButton_Configuration["Mode"] = "Off Tank"
	else
		WarriorButton_Configuration["Mode"] = nil
	end
	
	if not WarriorButton_Configuration["HeroicStrike"] then
		WarriorButton_Configuration["Fear"] = false
	end
	
	if WarriorButton_Configuration["MaxCycles"] == 0 then
		WarriorButton_Configuration["MaxCycles"] = nil
	end
	
	WarriorButton_Configuration_Init()
end

--------------------------------------------------

function WarriorButton_toBoolean(var)
	if var == 1 then
		return true
	end
	return false
end

--------------------------------------------------

function WarriorButton_Check(var)
	if var == true then
		return true
	end
	return nil
end

--------------------------------------------------

function WarriorButton_HandleTooltip(sTitle,sDescription)
  GameTooltip_SetDefaultAnchor( GameTooltip, UIParent )
  GameTooltip:SetText("|cffffffff"..sTitle)
  GameTooltip:AddLine("|cffffcc00"..sDescription)  
  GameTooltip:Show()
end

--------------------------------------------------

function WarriorButton_UpdateTime()
	if (WarriorButton_SpellInterrupt) then
		if (GetTime() - WarriorButton_SpellInterrupt) > WarriorButton_Configuration["InterruptTimer"] then
			WarriorButton_SpellInterrupt = nil
		end
	end
	if (WarriorButton_InstantCooldown) then
		if (GetTime() - WarriorButton_InstantCooldown) > (6 - WarriorButton_Configuration["InstantBuildTime"]) then
			WarriorButton_InstantCooldown = nil
		end
	end
	if (WarriorButton_ChargeDelay) then
		if (GetTime() - WarriorButton_ChargeDelay) > 1 then
			WarriorButton_ChargeDelay = nil
		end
	end
	if (WarriorButton_AoEDelay) then
		if (GetTime() - WarriorButton_AoEDelay) > WarriorButton_Configuration["AoETime"] then
			WarriorButton_AoEDelay = nil
		end
	end
	if (WarriorButton_ShortAoEDelay) then
		if (GetTime() - WarriorButton_ShortAoEDelay) > .5 then
			WarriorButton_ShortAoEDelay = nil
		end
	end
	if (WarriorButton_StanceDelay) then
		if (GetTime() - WarriorButton_StanceDelay) > WarriorButton_Configuration["StanceTime"] then
			WarriorButton_StanceDelay = nil
		end
	end
	if (WarriorButton_Delay) then
		if (GetTime() - WarriorButton_Delay) > (1 / WarriorButton_Configuration["MaxCycles"]) then
			WarriorButton_Delay = nil
		end
	end
	if (WarriorButton_ShieldBlockDelay) then
		if (GetTime() - WarriorButton_ShieldBlockDelay) > (5 - WarriorButton_Configuration["ShieldBlockTime"])then
			WarriorButton_ShieldBlockDelay = nil
		end
	end
	if (WarriorButton_SunderArmorDelay) then
		if (GetTime() - WarriorButton_SunderArmorDelay) > 13 then
			WarriorButton_SunderArmorDelay = nil
		end
	elseif isSunderFull() then
		WarriorButton_SunderArmorDelay = GetTime()
	end
	if (WarriorButton_FearEvent) then
		if (GetTime() - WarriorButton_FearEvent) > WarriorButton_FearTime then
			WarriorButton_FearEvent = nil
			WarriorButton_FearTime = nil
		end
	end
	if (WarriorButton_RogueEvasion) then
		if (GetTime() - WarriorButton_RogueEvasion) > 10 then
			WarriorButton_RogueEvasion = nil
		end
	end
end

--------------------------------------------------
--
-- Normal Functions
--
--------------------------------------------------

function WarriorButton()
	local t = Zorlen_GetTalentRank(LOCALIZATION_ZORLEN_TacticalMastery)
	local b = Zorlen_GetTalentRank(LOCALIZATION_ZORLEN_ImprovedBerserkerRage)
	local br = Zorlen_GetTalentRank(LOCALIZATION_ZORLEN_ImprovedBloodrage)
	local m = UnitMana("player")
	local h = UnitHealth("player")
	local hmax = UnitHealthMax("player")
	local TempMode = false
	local action = false
	
	WarriorButton_UpdateTime()
			
	if not WarriorButton_Configuration["Enabled"] then
		return false
	end
					
	--Delay Immune Code
	if WarriorButton_Configuration["Fear"] and Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN_BerserkerRage) and WarriorButton_FearEvent and castBerserkerStance() then
		return true --castBerserkerStance()
	elseif WarriorButton_Configuration["Fear"] and ((Zorlen_Button_BerserkerRage and Zorlen_Button_Bloodrage and IsUsableAction(Zorlen_Button_BerserkerRage) and not IsUsableAction(Zorlen_Button_Bloodrage)) or WarriorButton_FearEvent) and castBerserkerRage() then 
		WarriorButton_FearEvent = nil
		WarriorButton_FearTime = nil
		return true --castBerserkerRage()
	elseif WarriorButton_Configuration["Fear"] and ((Zorlen_Button_DeathWish and Zorlen_Button_Bloodrage and IsUsableAction(Zorlen_Button_DeathWish) and not IsUsableAction(Zorlen_Button_Bloodrage)) or WarriorButton_FearEvent)  and castDeathWish() then 
		WarriorButton_FearEvent = nil
		WarriorButton_FearTime = nil
		return true --castDeathWish()
	elseif Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_LastStand) and Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN_LastStand) and 
		(h / hmax) * 100 <= WarriorButton_Configuration["LastStandHealth"] and Zorlen_inCombat() and castLastStand() then
		return true --castLastStand()
	elseif UnitIsCivilian("target") then
		stopAttack()
		return false
	elseif WarriorButton_Delay then
		return false
	end
	
	WarriorButton_Delay = GetTime()
	
	if Zorlen_isShieldEquipped() and not WarriorButton_Configuration["Mode"] and WarriorButton_Configuration["AutoTank"] then
		TempMode = true
	end
	if UnitName("target") and string.find(string.lower(UnitName("target")), "totem") then
		totem = true
	end
	if Zorlen_RendSpellCastImmune and Zorlen_inCombat() then
		WB_RendSpellCastImmune = true
	elseif not Zorlen_inCombat() then
		WB_RendSpellCastImmune = false
	end
	if Zorlen_Button_HeroicStrike then
		WarriorButton_HeroicStrike = IsCurrentAction(Zorlen_Button_HeroicStrike)
	end
	if Zorlen_Button_Cleave then
		WarriorButton_Cleave = IsCurrentAction(Zorlen_Button_Cleave)
	end
	if WarriorButton_HeroicStrike then
		m = (m - Zorlen_HeroicStrikeRageCost())
	end
	if WarriorButton_Cleave then
		m = (m - 20)
	end
	if m < WarriorButton_Configuration["RageBuffer"] and WarriorButton_Configuration["Enabled"] and (WarriorButton_HeroicStrike or WarriorButton_Cleave) then
		SpellStopCasting()
	end
	
	if Zorlen_TargetIsEnemy() and ((CheckInteractDistance("target",4) and
		(not Zorlen_inCombat() or (m>=10 and (isBerserkerStance() or t>=2)) or (m>=5 and (isBerserkerStance() or t>=1) and
		b>=1 and (WarriorButton_Configuration["Berserk"]  and Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN_BerserkerRage))) or
		(b==2 and (WarriorButton_Configuration["Berserk"]  and Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN_BerserkerRage))) or
		Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN_Bloodrage))) or (CheckInteractDistance("target", 1))) and WBDismount() then
		return true	--Dismount
	end
	if not Zorlen_inCombat() and not Zorlen_TargetIsEnemy() and WarriorButton_Configuration["BattleShout"] and testBattleShout() then
		WarriorButton_Real_UseAction(Zorlen_Button_BattleShout)
		return true --castBattleShout
	elseif WarriorButton_Configuration["SChange"] and WarriorButton_Configuration["Charge"] and not Zorlen_inCombat() and not 
		(Zorlen_TargetIsEnemy() and CheckInteractDistance("target", 1)) and not WarriorButton_StanceDelay and
		m <= (t * 5 + WarriorButton_Configuration["StanceChangeRage"]) and castBattleStance() then
		WarriorButton_StanceDelay = GetTime()
		return true --castBattleStance()
	elseif not Zorlen_TargetIsEnemy() and WarriorButton_Configuration["AutoTarget"] then
		Zorlen_TargetEnemy()
		if Zorlen_isNoDamageCC() then
			ClearTarget()
			return false
		end
		return true
	end
	if Zorlen_TargetIsEnemy() and WarriorButton_Configuration["AutoAttack"] then
		castAttack()
	end
	if WarriorButton_Configuration["Charge"] and Zorlen_TargetIsEnemy() and castCharge() then
		WarriorButton_ChargeDelay = GetTime()
		return true --castCharge()
	end
			
	--Priority in Combat Ability Effects (No Rage Buffer Protection)
	--Auto Spell Interrupts 
	if WarriorButton_Configuration["InterruptSpells"] and WarriorButton_SpellInterrupt and castShieldBash() then
		return true --castShieldBash()
	elseif WarriorButton_Configuration["InterruptSpells"] and WarriorButton_SpellInterrupt and castPummel() then
		return true --castPummel()
	elseif WarriorButton_Configuration["InterruptSpells"] and WarriorButton_SpellInterrupt and CheckInteractDistance("target", 1)
		and Zorlen_isShieldEquipped() and isBerserkerStance() and Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_ShieldBash) and m < 10 and
		Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN_ShieldBash) and t >= 2 and (b == 2 or (b == 1 and m >= 5)) and (WarriorButton_Configuration["Berserk"] and castBerserkerRage()) then
		return true --(WarriorButton_Configuration["Berserk"] and castBerserkerRage())
	elseif WarriorButton_Configuration["SChange"] and WarriorButton_Configuration["InterruptSpells"] and not WarriorButton_GlobalCooldown() and not WarriorButton_StanceDelay and 
		m <= (t * 5 + WarriorButton_Configuration["StanceChangeRage"]) and WarriorButton_SpellInterrupt and
		CheckInteractDistance("target", 1) and Zorlen_isShieldEquipped() and Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_ShieldBash)
		and Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN_ShieldBash) and isBerserkerStance() and ((m >= 10 and t >= 2) or
		(h / hmax >= (WarriorButton_Configuration["BloodrageHealth"] / 100) and 
		Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN_Bloodrage))) and castDefensiveStance() then
		WarriorButton_StanceDelay = GetTime()
		return true --castDefensiveStance()
	elseif WarriorButton_Configuration["SChange"] and WarriorButton_Configuration["InterruptSpells"] and not WarriorButton_GlobalCooldown() and not WarriorButton_StanceDelay and
		m <= (t * 5 + WarriorButton_Configuration["StanceChangeRage"]) and WarriorButton_SpellInterrupt and
		not isBerserkerStance() and CheckInteractDistance("target", 1) and Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_Pummel) and
		Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN_Pummel) and ((m >= 10 and t >= 2) or
		(h / hmax >= (WarriorButton_Configuration["BloodrageHealth"] / 100) and 
		Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN_Bloodrage)) or 
		(((WarriorButton_Configuration["Berserk"]  and Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN_BerserkerRage))) and (b == 2 or (b == 1 and	t >= 1 and m >= 5)))) and castBerserkerStance() then
		WarriorButton_StanceDelay = GetTime()
		return true --castBerserkerStance()
	elseif WarriorButton_Configuration["InterruptSpells"] and WarriorButton_SpellInterrupt and CheckInteractDistance("target", 1)
		and Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_Pummel) and Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN_Pummel) and
		isBerserkerStance() and m < 10 and (b == 2 or (b == 1 and m >= 5)) and (WarriorButton_Configuration["Berserk"] and castBerserkerRage()) then
		return true --(WarriorButton_Configuration["Berserk"] and castBerserkerRage())
	elseif WarriorButton_Configuration["InterruptSpells"] and not WarriorButton_GlobalCooldown() and WarriorButton_SpellInterrupt
		and CheckInteractDistance("target", 1) and m < 10 and h / hmax >= (WarriorButton_Configuration["BloodrageHealth"] / 100)
		and ((Zorlen_isShieldEquipped() and not isBerserkerStance() and Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_ShieldBash) and
		Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN_ShieldBash)) or (Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_Pummel) and
		Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN_Pummel) and isBerserkerStance())) and castBloodrage() then
		return true --castBloodrage()
	elseif WarriorButton_Configuration["Concussion"] and WarriorButton_Configuration["InterruptSpells"] and WarriorButton_SpellInterrupt and castConcussionBlow() then
		WarriorButton_SpellInterrupt = nil
		return true --castConcussionBlow()
	
	--Auto Taunt While Tanking
	elseif (WarriorButton_Configuration["Mode"] == "Tank" or TempMode) and not UnitIsPlayer("target") and not totem and castTaunt() then
		return true --castTaunt()
	elseif (WarriorButton_Configuration["Mode"] == "Tank" or TempMode) and not UnitIsPlayer("target") and not totem and 
		not Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN_Taunt) and castMockingBlow() then
		return true --castMockingBlow()
	elseif WarriorButton_Configuration["SChange"] and not WarriorButton_GlobalCooldown() and not totem and (WarriorButton_Configuration["Mode"] == "Tank" or TempMode) and not UnitIsPlayer("target") and 
		Zorlen_TargetIsEnemyTargetingFriendButNotYou() and CheckInteractDistance("target", 1) and
		Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_MockingBlow) and not Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN_Taunt) and 
		Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN_MockingBlow) and m < 10 and t >= 2 and (b == 2 or (b == 1 and m >= 5))
		and (WarriorButton_Configuration["Berserk"]  and Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN_BerserkerRage)) and not WarriorButton_StanceDelay and castBerserkerStance() then
		WarriorButton_StanceDelay = GetTime()
		return true --castBerserkerStance()
	elseif (WarriorButton_Configuration["Mode"] == "Tank" or TempMode) and not UnitIsPlayer("target") and not totem and Zorlen_TargetIsEnemyTargetingFriendButNotYou()
		and CheckInteractDistance("target", 1) and Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_MockingBlow) and
		not Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN_Taunt) and Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN_MockingBlow)
		and isBerserkerStance() and m < 10 and t >= 2 and (b == 2 or (b == 1 and m >= 5)) and (WarriorButton_Configuration["Berserk"] and castBerserkerRage()) then
		return true --(WarriorButton_Configuration["Berserk"] and castBerserkerRage())
	elseif WarriorButton_Configuration["SChange"] and not WarriorButton_GlobalCooldown() and not totem and (WarriorButton_Configuration["Mode"] == "Tank" or TempMode) and not UnitIsPlayer("target") and
		m <= (t * 5 + WarriorButton_Configuration["StanceChangeRage"]) and not isBattleStance() and Zorlen_TargetIsEnemyTargetingFriendButNotYou()
		and CheckInteractDistance("target", 1) and Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_MockingBlow) and
		not Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN_Taunt) and Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN_MockingBlow)
		and ((m >= 10 and t >= 2) or (h / hmax >= (WarriorButton_Configuration["BloodrageHealth"] / 100) and 
		Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN_Bloodrage))) and not WarriorButton_StanceDelay and castBattleStance() then
		WarriorButton_StanceDelay = GetTime()
		return true --castBattleStance()
	elseif not WarriorButton_GlobalCooldown() and (WarriorButton_Configuration["Mode"] == "Tank" or TempMode) and not totem and not UnitIsPlayer("target") and 
		Zorlen_TargetIsEnemyTargetingFriendButNotYou() and CheckInteractDistance("target", 1) and
		Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_MockingBlow) and not Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN_Taunt) and 
		Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN_MockingBlow) and isBattleStance() and m < 10 and
		h / hmax >= (WarriorButton_Configuration["BloodrageHealth"] / 100) and castBloodrage() then
		return true --castBloodrage()
	elseif WarriorButton_Configuration["Concussion"] and (WarriorButton_Configuration["Mode"] == "Tank" or TempMode) and not totem and not UnitIsPlayer("target") and Zorlen_TargetIsEnemyTargetingFriendButNotYou() and castConcussionBlow() then
		return true --castConcussionBlow()
	
	--Auto Intercept
	elseif WarriorButton_Configuration["Intercept"] and Zorlen_TargetIsEnemy() and castIntercept() then
		return true --castIntercept()
	elseif WarriorButton_Configuration["SChange"] and WarriorButton_Configuration["Intercept"] and not WarriorButton_GlobalCooldown() and not WarriorButton_ChargeDelay and not WarriorButton_StanceDelay and  
		m <= (t * 5 + WarriorButton_Configuration["StanceChangeRage"]) and Zorlen_TargetIsEnemy() and Zorlen_Button_Intercept
		and Zorlen_inCombat() and IsActionInRange(Zorlen_Button_Intercept) == 1 and
		Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN_Intercept) and ((m >= 10 and t >= 2) or
		(Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN_Bloodrage) and 
		h / hmax > (WarriorButton_Configuration["BloodrageHealth"] / 100)) or 
		((WarriorButton_Configuration["Berserk"]  and Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN_BerserkerRage)) and (b == 2 or (b == 1 and t >= 1 and m >= 5)))) and castBerserkerStance() then
		WarriorButton_StanceDelay = GetTime()
		return true --castBerserkerStance()
	elseif WarriorButton_Configuration["Intercept"] and Zorlen_TargetIsEnemy() and Zorlen_Button_Intercept and 
		((Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN_Intercept) and Zorlen_Combat)) and
		(IsActionInRange(Zorlen_Button_Intercept) == 1) and Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN_Intercept) and
		m < 10 and (b == 2 or (b == 1 and m >= 5)) and (WarriorButton_Configuration["Berserk"] and castBerserkerRage()) then
		return true --(WarriorButton_Configuration["Berserk"] and castBerserkerRage())
	elseif WarriorButton_Configuration["Intercept"] and not WarriorButton_GlobalCooldown() and Zorlen_TargetIsEnemy() and Zorlen_Button_Intercept and isBerserkerStance() 
		and h / hmax >= (WarriorButton_Configuration["BloodrageHealth"] / 100) and
		((Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN_Intercept) and Zorlen_Combat)) and IsActionInRange(Zorlen_Button_Intercept) == 1 and
		Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN_Intercept) and m < 10 and castBloodrage() then
		return true --castBloodrage()
	
	--PVP Rogue Rend to Prevent Re-Stealth
	elseif not WarriorButton_GlobalCooldown() and not isRend() and UnitIsPlayer("target") and Zorlen_UnitClass("target") == "Rogue" and castBattleStance() then
		WarriorButton_StanceDelay = GetTime()
		return true --castBattleStance()
	elseif not isRend() and UnitIsPlayer("target") and Zorlen_UnitClass("target") == "Rogue" and castRend() then
		return true --castRend()
	
	--Auto Snare Runners
	elseif WarriorButton_Configuration["SnareRunners"] and not totem and (UnitIsPlayer("target") or Zorlen_TargetIsDieingEnemyWithNoTarget()) and not isPiercingHowl() and 
		CheckInteractDistance("target", 1) and castHamstring() then
		return true --castHamstring()
	elseif WarriorButton_Configuration["SnareRunners"] and not totem and not isHamstring() and not isPiercingHowl() and Zorlen_TargetIsDieingEnemyWithNoTarget() and 
		CheckInteractDistance("target", 2) and castPiercingHowl() then
		return true --castPiercingHowl()
	elseif WarriorButton_Configuration["SnareRunners"] and not totem and isDefensiveStance() and (WarriorButton_Configuration["Mode"] or TempMode) and not (isPiercingHowl() or isHamstring()) and 
		Zorlen_TargetIsDieingEnemyWithNoTarget() and CheckInteractDistance("target", 2) and m < 10 and 
		Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_PiercingHowl) and castBloodrage() then
		return true --castBloodrage()
	elseif WarriorButton_Configuration["SChange"] and not totem and WarriorButton_Configuration["SnareRunners"] and not WarriorButton_GlobalCooldown() and not (isPiercingHowl() or isHamstring()) and 
		b >= 1 and (((Zorlen_TargetIsDieingEnemyWithNoTarget() or UnitIsPlayer("target")) and CheckInteractDistance("target", 1)
		and m < 5) or (Zorlen_TargetIsDieingEnemyWithNoTarget() and CheckInteractDistance("target", 2) and m < 10 and 
		(m + b * 5) >= 10)) and (WarriorButton_Configuration["Berserk"]  and Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN_BerserkerRage)) and not WarriorButton_StanceDelay and castBerserkerStance() then
		WarriorButton_StanceDelay = GetTime()
		return true --castBerserkerStance()
	elseif WarriorButton_Configuration["SnareRunners"] and not totem and not (isPiercingHowl() or isHamstring()) and isBerserkerStance() and 
		b >= 1 and (((Zorlen_TargetIsDieingEnemyWithNoTarget() or UnitIsPlayer("target")) and CheckInteractDistance("target", 1)
		and m < 5) or (Zorlen_TargetIsDieingEnemyWithNoTarget() and CheckInteractDistance("target", 2) and m < 10 and 
		Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_PiercingHowl) and (m + b * 5) >= 10)) and (WarriorButton_Configuration["Berserk"] and castBerserkerRage()) then
		return true --(WarriorButton_Configuration["Berserk"] and castBerserkerRage())
	elseif WarriorButton_Configuration["SChange"] and not totem and WarriorButton_Configuration["SnareRunners"] and not WarriorButton_GlobalCooldown() and isDefensiveStance() and not (isPiercingHowl() or isHamstring()) and 
		(Zorlen_TargetIsDieingEnemyWithNoTarget() or UnitIsPlayer("target")) and CheckInteractDistance("target", 1) and
		m < 5 and Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN_Bloodrage) and not WarriorButton_StanceDelay and castBattleStance() then
		WarriorButton_StanceDelay = GetTime()
		return true --castBattleStance()
	elseif WarriorButton_Configuration["SnareRunners"] and not totem and not WarriorButton_GlobalCooldown() and not (isPiercingHowl() or isHamstring()) and 
		(((Zorlen_TargetIsDieingEnemyWithNoTarget() or UnitIsPlayer("target")) and CheckInteractDistance("target", 1) and
		m < 5) or (Zorlen_TargetIsDieingEnemyWithNoTarget() and CheckInteractDistance("target", 2) and
		m < 10 and Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_PiercingHowl))) and castBloodrage() then
		return true --castBloodRage()
	elseif WarriorButton_Configuration["Concussion"] and not totem and WarriorButton_Configuration["SnareRunners"] and not isHamstring() and not isPiercingHowl() and Zorlen_TargetIsDieingEnemyWithNoTarget() and castConcussionBlow() then
		return true --castConcussionBlow()
		
	--Revenge/Overpower (Rage Buffer Protection)
	elseif WarriorButton_Configuration["Overpower"] and m >= WarriorButton_Configuration["RageBuffer"] + 5 and castRevenge() then
		WarriorButton_ShieldBlockDelay = GetTime()
		return true --castRevenge()
	elseif WarriorButton_Configuration["Overpower"] and m >= WarriorButton_Configuration["RageBuffer"] + 5 and Zorlen_TargetDodgedYou_Overpower and castOverpower() then
		WarriorButton_ShieldBlockDelay = GetTime()
		return true --castOverpower()
	elseif WarriorButton_Configuration["SChange"] and WarriorButton_Configuration["Overpower"] and not WarriorButton_GlobalCooldown() and not (WarriorButton_Configuration["Mode"] or TempMode) and CheckInteractDistance("target", 1) and 
		Zorlen_TargetDodgedYou_Overpower and Zorlen_TargetIsActiveEnemy() and 
		Zorlen_GetTalentRank(LOCALIZATION_ZORLEN_ImprovedOverpower)>=1 and Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN_Overpower) 
		and t>=3 and ((m>=5 and m < WarriorButton_Configuration["RageBuffer"] + 5 and b == 2) or
		(m>=10 and m < WarriorButton_Configuration["RageBuffer"] + 5 and b == 1)) and 
		(WarriorButton_Configuration["Berserk"]  and Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN_BerserkerRage)) and not WarriorButton_StanceDelay and castBerserkerStance() then	
		WarriorButton_StanceDelay = GetTime()
		return true --castBerserkerStance()
	elseif WarriorButton_Configuration["Overpower"] and not (WarriorButton_Configuration["Mode"] or TempMode) and CheckInteractDistance("target", 1) and Zorlen_TargetDodgedYou_Overpower and 
		Zorlen_TargetIsActiveEnemy() and Zorlen_GetTalentRank(LOCALIZATION_ZORLEN_ImprovedOverpower) >= 1 and 
		Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN_Overpower) and isBerserkerStance() and t >= 3 and 
		((m >= 5 and m < WarriorButton_Configuration["RageBuffer"] + 5 and b == 2) or 
		(m >= 10 and m < WarriorButton_Configuration["RageBuffer"] + 5 and b == 1)) and (WarriorButton_Configuration["Berserk"] and castBerserkerRage()) then
		return true --castBerserkerRage()
	elseif WarriorButton_Configuration["SChange"] and WarriorButton_Configuration["Overpower"] and not WarriorButton_GlobalCooldown() and m <= (t * 5 + WarriorButton_Configuration["StanceChangeRage"]) and
		not (WarriorButton_Configuration["Mode"] or TempMode) and (Zorlen_TargetDodgedYou_Overpower and not Zorlen_TargetIsDieingEnemy() and 
		Zorlen_GetTalentRank(LOCALIZATION_ZORLEN_ImprovedOverpower)>=1 and Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN_Overpower)) and
		CheckInteractDistance("target", 1) and ((m >= 15 and t >= 3) or ((math.min(t * 5,m) + br * 2.5 + 10) and 
		(h / hmax) >= (WarriorButton_Configuration["BloodrageHealth"] / 100) and 
		Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN_Bloodrage))) and not WarriorButton_StanceDelay and castBattleStance() then
		WarriorButton_StanceDelay = GetTime()
		return true --castBattleStance()
	elseif WarriorButton_Configuration["Overpower"] and not WarriorButton_GlobalCooldown() and not (WarriorButton_Configuration["Mode"] or TempMode) and CheckInteractDistance("target", 1) and 
		Zorlen_TargetDodgedYou_Overpower and Zorlen_TargetIsActiveEnemy() and Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN_Overpower) 
		and isBattleStance() and m >= (5 - br * 2.5) and m < 15 and h / hmax >= (WarriorButton_Configuration["BloodrageHealth"] / 100) and castBloodrage() then
		return true --castBloodrage()	
	
	--Execute Code (No Rage Buffer Protection)
	elseif WarriorButton_Configuration["Execute"] and castExecute() then
		return true --castExecute()
	elseif WarriorButton_Configuration["SChange"] and WarriorButton_Configuration["Execute"] and not WarriorButton_GlobalCooldown() and CheckInteractDistance("target",1) and  
		isDefensiveStance() and math.min(t*5,m) >= Zorlen_ExecuteRageCost() and m <= t*5 + WarriorButton_Configuration["StanceChangeRage"] and
		UnitHealth("target") <= 20 and not WarriorButton_StanceDelay and castBattleStance() then	
		WarriorButton_StanceDelay = GetTime()
		return true --castBattleStance()
		
	--Shouts (No Rage Buffer Protection)
	elseif WarriorButton_Configuration["DemoShout"] and not totem and not Zorlen_DemoSpellCastImmune and not isDemoralized() and CheckInteractDistance("target", 3) and 
		Zorlen_TargetIsActiveEnemy() and castDemoralizingShout() then
		return true --castDemoralizingShout()
	elseif WarriorButton_Configuration["BattleShout"] and (m >= (15 + WarriorButton_Configuration["RageBuffer"]) or not (WarriorButton_Configuration["Mode"] == "Tank" or TempMode)) and testBattleShout() then
		WarriorButton_Real_UseAction(Zorlen_Button_BattleShout)
		return true --castBattleShout()
	
	--Rage Buffer Rebuilding Effects
	elseif not WarriorButton_Configuration["Mode"] and WarriorButton_Configuration["SChange"] and not WarriorButton_GlobalCooldown() and (Zorlen_TargetIsActiveEnemy() and Zorlen_inCombat() and not Zorlen_TargetIsDieingEnemy() and
		CheckInteractDistance("target", 1) and m < WarriorButton_Configuration["MaximumRage"] and
		m + b * 3.5 <= t * 5 and (WarriorButton_Configuration["Berserk"]  and Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN_BerserkerRage))) and not WarriorButton_StanceDelay and castBerserkerStance() then
		WarriorButton_StanceDelay = GetTime()
		return true --castBerserkerStance()
	elseif Zorlen_TargetIsActiveEnemy() and Zorlen_inCombat() and not Zorlen_TargetIsDieingEnemy() and 
		m < WarriorButton_Configuration["MaximumRage"] and WarriorButton_Configuration["Berserk"] and castBerserkerRage() then
		return true --castBerserkerRage()
		
	--Intelligent Stance Change Effects	
	elseif WarriorButton_Configuration["SChange"] and not WarriorButton_GlobalCooldown() and m <= (t * 5 + WarriorButton_Configuration["StanceChangeRage"]) 
		and (not WarriorButton_Configuration["Rend"] or isRend() or WB_RendSpellCastImmune) and not ((Zorlen_TargetDodgedYou_Overpower or WarriorButton_RogueEvasion) and
 		isBattleStance() and WarriorButton_Configuration["Overpower"]) and ((Zorlen_TargetIsEnemyTargetingFriendButNotYou() and not (WarriorButton_Configuration["Mode"] == "Tank" or TempMode)) or 
		(Zorlen_inCombat() and UnitIsPlayer("target") and not (WarriorButton_Configuration["Mode"] or TempMode)) or 
		(WarriorButton_Configuration["Stance"] and Zorlen_inCombat() and not (WarriorButton_Configuration["Mode"] == "Off Tank" and Zorlen_TargetIsEnemyTargetingYou()) 
		and not (WarriorButton_Configuration["Mode"] or TempMode))) and
		not (not isThunderClap() and WarriorButton_Configuration["Mode"] == "Off Tank" and WarriorButton_Configuration["ThunderClap"] and 
		not	Zorlen_TargetIsEnemyTargetingYou()) and not WarriorButton_StanceDelay and castBerserkerStance() then
		WarriorButton_StanceDelay = GetTime()
		return true --castBerserkerStance()
	elseif WarriorButton_Configuration["SChange"] and not WarriorButton_GlobalCooldown() and m <= (t * 5 + WarriorButton_Configuration["StanceChangeRage"]) and
		((not UnitIsPlayer("target") and not (WarriorButton_Configuration["Mode"] or TempMode) and isBerserkerStance() and Zorlen_TargetIsEnemyTargetingYou()) 
		or (not isThunderClap() and WarriorButton_Configuration["Mode"] == "Off Tank" and WarriorButton_Configuration["ThunderClap"] and 
		not	Zorlen_TargetIsEnemyTargetingYou()) or WarriorButton_RogueEvasion) and not WarriorButton_StanceDelay and not WarriorButton_Configuration["Stance"] and castBattleStance() then
		WarriorButton_StanceDelay = GetTime()
		return true --castBattleStance()
	elseif WarriorButton_Configuration["ThunderClap"] and CheckInteractDistance("target", 1) and not isThunderClap() and
		WarriorButton_Configuration["Mode"] == "Off Tank" and m >= WarriorButton_Configuration["RageBuffer"] + 20 and castThunderClap() then
		return true --castThunderClap()
	end
	
	--Hate Generating Effects (Rage Buffer Protection)
	if WarriorButton_Configuration["Mode"] or TempMode and not totem then
		if Zorlen_isShieldEquipped() then
			if WarriorButton_Configuration["SChange"] and CheckInteractDistance("target", 1) and not WarriorButton_GlobalCooldown() 
				and not WarriorButton_StanceDelay and castDefensiveStance() then
				WarriorButton_StanceDelay = GetTime()
				return true --castDefensiveStance()
			elseif WarriorButton_Configuration["HS"] and CheckInteractDistance("target", 1) and not WarriorButton_Cleave and not WarriorButton_HeroicStrike and
				((Zorlen_isShieldEquipped() and m >= (WarriorButton_Configuration["RageBuffer"] + 15 + Zorlen_HeroicStrikeRageCost() + Zorlen_ShieldSlamRageCost() + Zorlen_SunderArmorRageCost())) or
				((not Zorlen_isShieldEquipped() or WarriorButton_InstantCooldown or not WarriorButton_Configuration["Strike"] or Zorlen_ShieldSlamRageCost() == 0) and
				m >= (WarriorButton_Configuration["RageBuffer"] + 15 + Zorlen_HeroicStrikeRageCost() + Zorlen_SunderArmorRageCost())))and castHeroicStrike() then
				m = (m - Zorlen_HeroicStrikeRageCost())
				action = true --castHeroicStrike()
			elseif WarriorButton_Configuration["ShieldBlock"] and Zorlen_TargetIsEnemyTargetingYou() and m >= (10 + WarriorButton_Configuration["RageBuffer"])
				and WarriorButton_Configuration["CSB"] and castShieldBlock() then
				action = true --castShieldBlock()
			elseif (WarriorButton_Configuration["PSunder"] or not WarriorButton_SunderArmorDelay) and Zorlen_GetTalentRank(LOCALIZATION_ZORLEN_ImprovedSunderArmor)>0 and
				m >= (WarriorButton_Configuration["RageBuffer"] + Zorlen_SunderArmorRageCost()) and castSunderArmor() then
				if isSunderFull() then
					WarriorButton_SunderArmorDelay = GetTime()
				end
				return true --castSunderArmor()
			elseif WarriorButton_Configuration["Strike"] and m >= (WarriorButton_Configuration["RageBuffer"] + Zorlen_ShieldSlamRageCost()) and castShieldSlam() then
				WarriorButton_InstantCooldown = GetTime()
				return true --castShieldSlam()
			elseif WarriorButton_Configuration["Strike"] and Zorlen_ShieldSlamRageCost() > 0 and not WarriorButton_InstantCooldown then
				if (WarriorButton_Configuration["PSunder"] or not WarriorButton_SunderArmorDelay) and
					m >= (WarriorButton_Configuration["RageBuffer"] + Zorlen_SunderArmorRageCost() + Zorlen_ShieldSlamRageCost()) and castSunderArmor() then
					if isSunderFull() then
						WarriorButton_SunderArmorDelay = GetTime()
					end
					return true --castSunderArmor()
				elseif WarriorButton_Configuration["ShieldBlock"] and Zorlen_TargetIsEnemyTargetingYou() and m >= (15 + WarriorButton_Configuration["RageBuffer"] + Zorlen_ShieldSlamRageCost() + Zorlen_SunderArmorRageCost())
					and not WarriorButton_ShieldBlockDelay and Zorlen_Button_Revenge and not IsUsableAction(Zorlen_Button_Revenge) and castShieldBlock() then
					action = true --castShieldBlock()
				end
			elseif (WarriorButton_Configuration["PSunder"] or not WarriorButton_SunderArmorDelay) and
				m >= (WarriorButton_Configuration["RageBuffer"] + Zorlen_SunderArmorRageCost()) and castSunderArmor() then
				if isSunderFull() then
					WarriorButton_SunderArmorDelay = GetTime()
				end
				return true --castSunderArmor()
			elseif WarriorButton_Configuration["ShieldBlock"] and Zorlen_TargetIsEnemyTargetingYou() and m >= (15 + WarriorButton_Configuration["RageBuffer"] + Zorlen_SunderArmorRageCost())
				and not WarriorButton_ShieldBlockDelay and Zorlen_Button_Revenge and not IsUsableAction(Zorlen_Button_Revenge) and castShieldBlock() then
				action = true --castShieldBlock()
			end
		else
			if WarriorButton_Configuration["SChange"] and CheckInteractDistance("target", 1) and not WarriorButton_GlobalCooldown() 
				and not WarriorButton_StanceDelay and castDefensiveStance() then
				WarriorButton_StanceDelay = GetTime()
				return true --castDefensiveStance()
			elseif WarriorButton_Configuration["HS"] and CheckInteractDistance("target", 1) and not WarriorButton_Cleave and not WarriorButton_HeroicStrike and
				(not Zorlen_isShieldEquipped() or WarriorButton_InstantCooldown or not WarriorButton_Configuration["Strike"] or Zorlen_ShieldSlamRageCost() == 0) and
				m >= (WarriorButton_Configuration["RageBuffer"] + 15 + Zorlen_HeroicStrikeRageCost() + Zorlen_SunderArmorRageCost()) and castHeroicStrike() then
				m = (m - Zorlen_HeroicStrikeRageCost())
				action = true --castHeroicStrike()
			elseif (WarriorButton_Configuration["PSunder"] or not WarriorButton_SunderArmorDelay) and m >= (WarriorButton_Configuration["RageBuffer"] + Zorlen_SunderArmorRageCost()) and castSunderArmor() then
				if isSunderFull() then
					WarriorButton_SunderArmorDelay = GetTime()
				end
				return true --castSunderArmor()
			end
		end
	end
	
	--AoE Damage Effects
	if WarriorButton_Configuration["AoE"] and WarriorButton_CheckAoE() and WarriorButton_AoE(m,t) then
		return true --Casts Sweeping Strikes, Whirlwind, or Thunder Clap for AoE damage
	elseif WarriorButton_Configuration["AoE"] and not WarriorButton_Cleave and not (UnitHealth("target") <= 20 and WarriorButton_Configuration["Execute"]) and WarriorButton_CheckAoE() then
		if (WarriorButton_Configuration["Mode"] or TempMode) and (Zorlen_TargetIsEnemyTargetingYou() or (WarriorButton_Configuration["Mode"] == "Tank" or TempMode)) then
			if Zorlen_isShieldEquipped() and m >= (WarriorButton_Configuration["RageBuffer"] + 35 + Zorlen_ShieldSlamRageCost() + Zorlen_SunderArmorRageCost()) and castCleave() then
				m = (m - 20)
				action = true --castCleave()
			elseif (not Zorlen_isShieldEquipped() or WarriorButton_InstantCooldown or Zorlen_ShieldSlamRageCost() == 0 or not WarriorButton_Configuration["Strike"]) and
				m >= (WarriorButton_Configuration["RageBuffer"] + 35 + Zorlen_SunderArmorRageCost()) and castCleave() then
				m = (m - 20)
				action = true --castCleave()
			end
		elseif WarriorButton_Configuration["Mode"] == "Off Tank" then
			if Zorlen_isShieldEquipped() and m >= (WarriorButton_Configuration["RageBuffer"] + 20 + Zorlen_ShieldSlamRageCost() + Zorlen_SunderArmorRageCost()) and castCleave() then
				m = (m - 20)
				action = true --castCleave()
			elseif (not Zorlen_isShieldEquipped() or WarriorButton_InstantCooldown or Zorlen_ShieldSlamRageCost() == 0 or not WarriorButton_Configuration["Strike"]) and
				m >= (WarriorButton_Configuration["RageBuffer"] + 20 + Zorlen_SunderArmorRageCost()) and castCleave() then
				m = (m - 20)
				action = true --castCleave()
			end
		elseif m >= (WarriorButton_Configuration["RageBuffer"] + 20) and castCleave() then
			m = (m - 20)
			action = true --castCleave()
		end
	end
				
	--Misc/Damage Effects (Rage Buffer Protection)
	if WarriorButton_Configuration["HS"] and CheckInteractDistance("target", 1) and not WarriorButton_Cleave and not WarriorButton_HeroicStrike and Zorlen_isShieldEquipped() and m >= (WarriorButton_Configuration["RageBuffer"] + Zorlen_HeroicStrikeRageCost()
		+ Zorlen_MortalStrikeRageCost() + Zorlen_BloodthirstRageCost() + Zorlen_ShieldSlamRageCost()) and not (WarriorButton_Configuration["Whirlwind"] and isBerserkerStance() and Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN_Whirlwind)) and castHeroicStrike() then
		m = (m - Zorlen_HeroicStrikeRageCost())
		action = true --castHeroicStrike()
	elseif WarriorButton_Configuration["HS"] and CheckInteractDistance("target", 1) and not WarriorButton_Cleave and not WarriorButton_HeroicStrike and Zorlen_isShieldEquipped() and m >= (WarriorButton_Configuration["RageBuffer"] + Zorlen_HeroicStrikeRageCost()) and
		(WarriorButton_InstantCooldown or not WarriorButton_Configuration["Strike"] or (Zorlen_BloodthirstRageCost() + Zorlen_MortalStrikeRageCost() + Zorlen_ShieldSlamRageCost()) == 0)
		and not (WarriorButton_Configuration["Whirlwind"] and isBerserkerStance() and Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN_Whirlwind)) and castHeroicStrike() then
		m = (m - Zorlen_HeroicStrikeRageCost())
		action = true --castHeroicStrike()
	elseif WarriorButton_Configuration["HS"] and CheckInteractDistance("target", 1) and not WarriorButton_Cleave and not WarriorButton_HeroicStrike and not Zorlen_isShieldEquipped() and m >= (WarriorButton_Configuration["RageBuffer"] + Zorlen_HeroicStrikeRageCost() + Zorlen_MortalStrikeRageCost()
		+ Zorlen_BloodthirstRageCost()) and not (WarriorButton_Configuration["Whirlwind"] and isBerserkerStance() and Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN_Whirlwind)) and castHeroicStrike() then
		m = (m - Zorlen_HeroicStrikeRageCost())
		action = true --castHeroicStrike()
	elseif WarriorButton_Configuration["HS"] and CheckInteractDistance("target", 1) and not WarriorButton_Cleave and not WarriorButton_HeroicStrike and not Zorlen_isShieldEquipped() and m >= (WarriorButton_Configuration["RageBuffer"] + Zorlen_HeroicStrikeRageCost()) and
		(WarriorButton_InstantCooldown or not WarriorButton_Configuration["Strike"] or (Zorlen_BloodthirstRageCost() + Zorlen_MortalStrikeRageCost()) == 0) 
		and not (WarriorButton_Configuration["Whirlwind"] and isBerserkerStance() and Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN_Whirlwind)) and castHeroicStrike() then
		m = (m - Zorlen_HeroicStrikeRageCost())
		action = true --castHeroicStrike()
	elseif WarriorButton_Configuration["Strike"] and m >= (WarriorButton_Configuration["RageBuffer"] + 30) and castMortalStrike() then
		WarriorButton_InstantCooldown = GetTime()
		return true --castMortalStrike()
	elseif WarriorButton_Configuration["Strike"] and m >= (WarriorButton_Configuration["RageBuffer"] + 30) and castBloodthirst() then
		WarriorButton_InstantCooldown = GetTime()
		return true --castBloodthirst()
	elseif WarriorButton_Configuration["Strike"] and m >= (WarriorButton_Configuration["RageBuffer"] + 20) and castShieldSlam() then
		WarriorButton_InstantCooldown = GetTime()
		return true --castShieldSlam()
	elseif WarriorButton_Configuration["Rend"] and m >= (WarriorButton_Configuration["RageBuffer"] + 10) and not Zorlen_TargetIsDieingEnemy() and not isRend() and not WB_RendSpellCastImmune and castRend() then
		return true --castRend()
	elseif Zorlen_isShieldEquipped() and WarriorButton_Configuration["Whirlwind"] and m >= (WarriorButton_Configuration["RageBuffer"] + 25) and 
		(WarriorButton_InstantCooldown or not WarriorButton_Configuration["Strike"] or (Zorlen_BloodthirstRageCost() + Zorlen_MortalStrikeRageCost() + Zorlen_ShieldSlamRageCost()) == 0) and castWhirlwind() then
		return true --castWhirlwind()
	elseif not Zorlen_isShieldEquipped() and WarriorButton_Configuration["Whirlwind"] and m >= (WarriorButton_Configuration["RageBuffer"] + 25) and 
		(WarriorButton_InstantCooldown or not WarriorButton_Configuration["Strike"] or (Zorlen_BloodthirstRageCost() + Zorlen_MortalStrikeRageCost()) == 0) and castWhirlwind() then
		return true --castWhirlwind()
	elseif Zorlen_isShieldEquipped() and WarriorButton_Configuration["Disarm"] and m >= (WarriorButton_Configuration["RageBuffer"] + 20) and not Zorlen_TargetIsDieingEnemy() and
		(WarriorButton_InstantCooldown or not WarriorButton_Configuration["Strike"] or (Zorlen_BloodthirstRageCost() + Zorlen_MortalStrikeRageCost() + Zorlen_ShieldSlamRageCost()) == 0) and castDisarm() then
		return true --castDisarm()
	elseif not Zorlen_isShieldEquipped() and WarriorButton_Configuration["Disarm"] and m >= (WarriorButton_Configuration["RageBuffer"] + 20) and not Zorlen_TargetIsDieingEnemy() and
		(WarriorButton_InstantCooldown or not WarriorButton_Configuration["Strike"] or (Zorlen_BloodthirstRageCost() + Zorlen_MortalStrikeRageCost()) == 0) and castDisarm() then
		return true --castDisarm()
	end
	if action == true then
		return true
	end
	return false
end

--------------------------------------------------

function WarriorButton_CheckAoE(event)
	if not WarriorButton_Configuration["AoE"] or not Zorlen_TargetIsActiveEnemy() or totem or UnitHealth("target") == 0 or not CheckInteractDistance("target", 1) or Zorlen_isNoDamageCC("target") then
		WarriorButtonAoE = false
		return false
	end
	
	if WarriorButton_AoEDelay or WarriorButton_ShortAoEDelay or event == "PLAYER_TARGET_CHANGED" then
		return WarriorButtonAoE
	end
	
	WarriorButton_AoEDelay = GetTime()
	
	TargetNearestEnemy()
	if Zorlen_TargetIsActiveEnemy() and not Zorlen_isNoDamageCC("target") and not totem and CheckInteractDistance("target", 1) and not UnitIsUnit("playertarget","target") then
		if Zorlen_TargetIsActiveEnemy("playertarget") then
			TargetUnit("playertarget")
		elseif WarriorButton_Configuration["AutoTarget"] then
			Zorlen_TargetEnemy()
		else
			ClearTarget()
		end
		WarriorButtonAoE = true
		return true
	end
	if Zorlen_TargetIsActiveEnemy("playertarget") then
		TargetUnit("playertarget")
	elseif WarriorButton_Configuration["AutoTarget"] then
		Zorlen_TargetEnemy()
	else
		ClearTarget()
	end
	WarriorButtonAoE = false
	return false
end

--------------------------------------------------

function WarriorButton_AoE(mana,tactical)
	if isBattleStance() and Zorlen_Button_SweepingStrikes and Zorlen_Button_Whirlwind and Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN_SweepingStrikes) and tactical > 1 then
		if mana >= (30 + tactical*5) and Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN_Whirlwind) and not WarriorButton_StanceDelay and castSweepingStrikes() then
			castBerserkerStance()
			WarriorButton_StanceDelay = (GetTime() + 2)
		end
		return true
	elseif mana >= 30 + WarriorButton_Configuration["RageBuffer"] and castSweepingStrikes() then
		return true
	elseif castWhirlwind() then
		return true
	elseif mana >= 20 + WarriorButton_Configuration["RageBuffer"] and not (Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN_SweepingStrikes)
		and Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_SweepingStrikes)) and not isThunderClap() and castThunderClap() then
		return true
	end
	return false
end

--------------------------------------------------

function WarriorButton_GlobalCooldown()
	if not Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN_BattleShout) then
		return true
	end
	return false
end

--------------------------------------------------

function isPiercingHowl(unit, dispelable)
	return Zorlen_checkDebuff("Spell_Shadow_DeathScream", unit, dispelable)
end

--------------------------------------------------

function castLastStand()
	local SpellName = LOCALIZATION_ZORLEN_LastStand
	local SpellButton = Zorlen_Button_LastStand
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and not ( isCurrent == 1 ) then
			UseAction(SpellButton)
			return true
		end
	else if Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		local SpellID = Zorlen_GetSpellID(SpellName)
		if Zorlen_checkCooldown(SpellID) then
			CastSpell(SpellID, 0)
			return true
		end
	end
	end
	return false
end

--------------------------------------------------

function castConcussionBlow()
	local SpellName = LOCALIZATION_ZORLEN_ConcussionBlow
	local SpellButton = Zorlen_Button_ConcussionBlow
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and not ( isCurrent == 1 ) then
			UseAction(SpellButton)
			return true
		end
	else if Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		local SpellID = Zorlen_GetSpellID(SpellName)
		if Zorlen_checkCooldown(SpellID) then
			CastSpell(SpellID, 0)
			return true
		end
	end
	end
	return false
end

--------------------------------------------------

function castPiercingHowl()
	local SpellName = LOCALIZATION_ZORLEN_PiercingHowl
	local SpellButton = Zorlen_Button_PiercingHowl
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and not ( isCurrent == 1 ) then
			UseAction(SpellButton)
			return true
		end
	else if Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		local SpellID = Zorlen_GetSpellID(SpellName)
		if (UnitMana("player") >= 10) then
			if Zorlen_checkCooldown(SpellID) then
				CastSpell(SpellID, 0)
				return true
			end
		end
	end
	end
	return false
end

--------------------------------------------------

function testBattleShout()
	local SpellName = LOCALIZATION_ZORLEN_BattleShout
	local SpellButton = Zorlen_Button_BattleShout
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and not ( isCurrent == 1 ) and not isBattleShoutActive() then
			return true
		end
	else if Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		local SpellID = Zorlen_GetSpellID(SpellName)
		if (UnitMana("player") >= 10 and not isBattleShoutActive()) then
			return true
		end
	end
	end
	return false
end

--------------------------------------------------

function WBDismount()
	--try to dismount when mounted
	local bufnum = WBMounted()
	if bufnum then
    	CancelPlayerBuff(bufnum)
		return true
	end
	return false
end

--------------------------------------------------

function WBMounted()
	--go over all bufs to find a mount icon
	local i,buftexture
	i = 0
	buftexture = GetPlayerBuffTexture(i)
	while buftexture do
		buftexture = string.lower(buftexture)
		if string.find(buftexture,"_mount_",17,true) or string.find(buftexture,"spell_nature_swiftness",17,true) or string.find(buftexture,"_qirajicrystal_",17,true) then return i end
		i = i + 1
		buftexture = GetPlayerBuffTexture(i)
	end
	return nil
end

--------------------------------------------------

function WarriorButton_CheckButtons()
	if not Zorlen_Button_SweepingStrikes then
		if Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_SweepingStrikes) then
			Zorlen_RegisterButtons()
			if not Zorlen_Button_SweepingStrikes then
				DEFAULT_CHAT_FRAME:AddMessage("You must put "..LOCALIZATION_ZORLEN_SweepingStrikes.." on one of your action bars (even if it is hidden) for Warrior Button to work right!")
			end
		end
	end
	if not Zorlen_Button_Cleave then
		if Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_Cleave) then
			Zorlen_RegisterButtons()
			if not Zorlen_Button_Cleave then
				DEFAULT_CHAT_FRAME:AddMessage("You must put "..LOCALIZATION_ZORLEN_Cleave.." on one of your action bars (even if it is hidden) for Warrior Button to work right!")
			end
		end
	end
	if not Zorlen_Button_Whirlwind then
		if Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_Whirldwind) then
			Zorlen_RegisterButtons()
			if not Zorlen_Button_Whirlwind then
				DEFAULT_CHAT_FRAME:AddMessage("You must put "..LOCALIZATION_ZORLEN_Whirlwind.." on one of your action bars (even if it is hidden) for Warrior Button to work right!")
			end
		end
	end
	if not Zorlen_Button_ThunderClap then
		if Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_ThunderClap) then
			Zorlen_RegisterButtons()
			if not Zorlen_Button_ThunderClap then
				DEFAULT_CHAT_FRAME:AddMessage("You must put "..LOCALIZATION_ZORLEN_ThunderClap.." on one of your action bars (even if it is hidden) for Warrior Button to work right!")
			end
		end
	end
	if not Zorlen_Button_Disarm then
		if Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_Disarm) then
			Zorlen_RegisterButtons()
			if not Zorlen_Button_Disarm then
				DEFAULT_CHAT_FRAME:AddMessage("You must put "..LOCALIZATION_ZORLEN_Disarm.." on one of your action bars (even if it is hidden) for Warrior Button to work right!")
			end
		end
	end
	if not Zorlen_Button_MortalStrike then
		if Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_MortalStrike) then
			Zorlen_RegisterButtons()
			if not Zorlen_Button_MortalStrike then
				DEFAULT_CHAT_FRAME:AddMessage("You must put "..LOCALIZATION_ZORLEN_MortalStrike.." on one of your action bars (even if it is hidden) for Warrior Button to work right!")
			end
		end
	end
	if not Zorlen_Button_Bloodthirst then
		if Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_Bloodthirst) then
			Zorlen_RegisterButtons()
			if not Zorlen_Button_Bloodthirst then
				DEFAULT_CHAT_FRAME:AddMessage("You must put "..LOCALIZATION_ZORLEN_Bloodthirst.." on one of your action bars (even if it is hidden) for Warrior Button to work right!")
			end
		end
	end
	if not Zorlen_Button_ShieldSlam then
		if Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_ShieldSlam) then
			Zorlen_RegisterButtons()
			if not Zorlen_Button_ShieldSlam then
				DEFAULT_CHAT_FRAME:AddMessage("You must put "..LOCALIZATION_ZORLEN_ShieldSlam.." on one of your action bars (even if it is hidden) for Warrior Button to work right!")
			end
		end
	end
	if not Zorlen_Button_Charge then
		if Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_Charge) then
			Zorlen_RegisterButtons()
			if not Zorlen_Button_Charge then
				DEFAULT_CHAT_FRAME:AddMessage("You must put "..LOCALIZATION_ZORLEN_Charge.." on one of your action bars (even if it is hidden) for Warrior Button to work right!")
			end
		end
	end
	if not Zorlen_Button_Intercept then
		if Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_Intercept) then
			Zorlen_RegisterButtons()
			if not Zorlen_Button_Intercept then
				DEFAULT_CHAT_FRAME:AddMessage("You must put "..LOCALIZATION_ZORLEN_Intercept.." on one of your action bars (even if it is hidden) for Warrior Button to work right!")
			end
		end
	end
	if not Zorlen_Button_Taunt then
		if Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_Taunt) then
			Zorlen_RegisterButtons()
			if not Zorlen_Button_Taunt then
				DEFAULT_CHAT_FRAME:AddMessage("You must put "..LOCALIZATION_ZORLEN_Taunt.." on one of your action bars (even if it is hidden) for Warrior Button to work right!")
			end
		end
	end
	if not Zorlen_Button_MockingBlow then
		if Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_MockingBlow) then
			Zorlen_RegisterButtons()
			if not Zorlen_Button_MockingBlow then
				DEFAULT_CHAT_FRAME:AddMessage("You must put "..LOCALIZATION_ZORLEN_MockingBlow.." on one of your action bars (even if it is hidden) for Warrior Button to work right!")
			end
		end
	end
	if not Zorlen_Button_Overpower then
		if Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_Overpower) then
			Zorlen_RegisterButtons()
			if not Zorlen_Button_Overpower then
				DEFAULT_CHAT_FRAME:AddMessage("You must put "..LOCALIZATION_ZORLEN_Overpower.." on one of your action bars (even if it is hidden) for Warrior Button to work right!")
			end
		end
	end
	if not Zorlen_Button_Revenge then
		if Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_Revenge) then
			Zorlen_RegisterButtons()
			if not Zorlen_Button_Revenge then
				DEFAULT_CHAT_FRAME:AddMessage("You must put "..LOCALIZATION_ZORLEN_Revenge.." on one of your action bars (even if it is hidden) for Warrior Button to work right!")
			end
		end
	end
	if not Zorlen_Button_Rend then
		if Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_Rend) then
			Zorlen_RegisterButtons()
			if not Zorlen_Button_Rend then
				DEFAULT_CHAT_FRAME:AddMessage("You must put "..LOCALIZATION_ZORLEN_Rend.." on one of your action bars (even if it is hidden) for Warrior Button to work right!")
			end
		end
	end
	if not Zorlen_Button_Hamstring then
		if Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_Hamstring) then
			Zorlen_RegisterButtons()
			if not Zorlen_Button_Hamstring then
				DEFAULT_CHAT_FRAME:AddMessage("You must put "..LOCALIZATION_ZORLEN_Hamstring.." on one of your action bars (even if it is hidden) for Warrior Button to work right!")
			end
		end
	end
	if not Zorlen_Button_Execute then
		if Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_Execute) then
			Zorlen_RegisterButtons()
			if not Zorlen_Button_Execute then
				DEFAULT_CHAT_FRAME:AddMessage("You must put "..LOCALIZATION_ZORLEN_Execute.." on one of your action bars (even if it is hidden) for Warrior Button to work right!")
			end
		end
	end
	if not Zorlen_Button_SunderArmor then
		if Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_SunderArmor) then
			Zorlen_RegisterButtons()
			if not Zorlen_Button_SunderArmor then
				DEFAULT_CHAT_FRAME:AddMessage("You must put "..LOCALIZATION_ZORLEN_SunderArmor.." on one of your action bars (even if it is hidden) for Warrior Button to work right!")
			end
		end
	end
	if not Zorlen_Button_ShieldBlock then
		if Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_ShieldBlock) then
			Zorlen_RegisterButtons()
			if not Zorlen_Button_ShieldBlock then
				DEFAULT_CHAT_FRAME:AddMessage("You must put "..LOCALIZATION_ZORLEN_ShieldBlock.." on one of your action bars (even if it is hidden) for Warrior Button to work right!")
			end
		end
	end
	if not Zorlen_Button_ShieldBash then
		if Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_ShieldBash) then
			Zorlen_RegisterButtons()
			if not Zorlen_Button_ShieldBash then
				DEFAULT_CHAT_FRAME:AddMessage("You must put "..LOCALIZATION_ZORLEN_ShieldBash.." on one of your action bars (even if it is hidden) for Warrior Button to work right!")
			end
		end
	end
	if not Zorlen_Button_Pummel then
		if Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_Pummel) then
			Zorlen_RegisterButtons()
			if not Zorlen_Button_Pummel then
				DEFAULT_CHAT_FRAME:AddMessage("You must put "..LOCALIZATION_ZORLEN_Pummel.." on one of your action bars (even if it is hidden) for Warrior Button to work right!")
			end
		end
	end
	if not Zorlen_Button_DemoralizingShout then
		if Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_DemoralizingShout) then
			Zorlen_RegisterButtons()
			if not Zorlen_Button_DemoralizingShout then
				DEFAULT_CHAT_FRAME:AddMessage("You must put "..LOCALIZATION_ZORLEN_DemoralizingShout.." on one of your action bars (even if it is hidden) for Warrior Button to work right!")
			end
		end
	end
	if not Zorlen_Button_BerserkerRage then
		if Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_BerserkerRage) then
			Zorlen_RegisterButtons()
			if not Zorlen_Button_BerserkerRage then
				DEFAULT_CHAT_FRAME:AddMessage("You must put "..LOCALIZATION_ZORLEN_BerserkerRage.." on one of your action bars (even if it is hidden) for Warrior Button to work right!")
			end
		end
	end
	if not Zorlen_Button_Bloodrage then
		if Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_Bloodrage) then
			Zorlen_RegisterButtons()
			if not Zorlen_Button_Bloodrage then
				DEFAULT_CHAT_FRAME:AddMessage("You must put "..LOCALIZATION_ZORLEN_Bloodrage.." on one of your action bars (even if it is hidden) for Warrior Button to work right!")
			end
		end
	end
	if not Zorlen_Button_DeathWish then
		if Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_DeathWish) then
			Zorlen_RegisterButtons()
			if not Zorlen_Button_DeathWish then
				DEFAULT_CHAT_FRAME:AddMessage("You must put "..LOCALIZATION_ZORLEN_DeathWish.." on one of your action bars (even if it is hidden) for Warrior Button to work right!")
			end
		end
	end
	if not Zorlen_Button_PiercingHowl then
		if Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_PiercingHowl) then
			Zorlen_RegisterButtons()
			if not Zorlen_Button_PiercingHowl then
				DEFAULT_CHAT_FRAME:AddMessage("You must put "..LOCALIZATION_ZORLEN_PiercingHowl.." on one of your action bars (even if it is hidden) for Warrior Button to work right!")
			end
		end
	end
	if not Zorlen_Button_ConcussionBlow then
		if Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_ConcussionBlow) then
			Zorlen_RegisterButtons()
			if not Zorlen_Button_ConcussionBlow then
				DEFAULT_CHAT_FRAME:AddMessage("You must put "..LOCALIZATION_ZORLEN_ConcussionBlow.." on one of your action bars (even if it is hidden) for Warrior Button to work right!")
			end
		end
	end
	if not Zorlen_Button_LastStand then
		if Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_LastStand) then
			Zorlen_RegisterButtons()
			if not Zorlen_Button_LastStand then
				DEFAULT_CHAT_FRAME:AddMessage("You must put "..LOCALIZATION_ZORLEN_LastStand.." on one of your action bars (even if it is hidden) for Warrior Button to work right!")
			end
		end
	end
	if not Zorlen_Button_HeroicStrike then
		if Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_HeroicStrike) then
			Zorlen_RegisterButtons()
			if not Zorlen_Button_HeroicStrike then
				DEFAULT_CHAT_FRAME:AddMessage("You must put "..LOCALIZATION_ZORLEN_HeroicStrike.." on one of your action bars (even if it is hidden) for Warrior Button to work right!")
			end
		end
	end
	if not Zorlen_Button_BattleShout then
		if Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_BattleShout) then
			Zorlen_RegisterButtons()
			if not Zorlen_Button_BattleShout then
				DEFAULT_CHAT_FRAME:AddMessage("You must put "..LOCALIZATION_ZORLEN_BattleShout.." on one of your action bars (even if it is hidden) for Warrior Button to work right!")
			end
		end
	end
end

--------------------------------------------------
--
-- Event Handlers
--
--------------------------------------------------

function WarriorButton_OnLoad()
	this:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE")
	this:RegisterEvent("CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE")
	this:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF")
	this:RegisterEvent("CHAT_MSG_SPELL_HOSTILEPLAYER_BUFF")
	this:RegisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE")
	this:RegisterEvent("VARIABLES_LOADED")
	this:RegisterEvent("PLAYER_TARGET_CHANGED")
	this:RegisterEvent("CHAT_MSG_RAID_LEADER")
	this:RegisterEvent("CHAT_MSG_RAID")
	this:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_SELF_BUFF")
						
	SlashCmdList["WarriorButton"] = function (msg)
		WarriorButton_SlashHandler(msg)
	end
	SLASH_WarriorButton1 = "/WarriorButton"
	SLASH_WarriorButton2 = "/WB"
	
	WarriorButton_Configuration_Init()
end

--------------------------------------------------

function WarriorButton_SlashHandler(msg)
	if Zorlen_isCurrentClassWarrior then
		if WarriorButtonForm:IsVisible() then
			WarriorButtonForm:Hide()
		else
			WarriorButtonForm:Show()
		end
	else
		DEFAULT_CHAT_FRAME:AddMessage("Warrior Button: You are not a warrior class character")
	end
end

--------------------------------------------------

function WarriorButton_OnEvent(event, arg1, arg2, arg3)
	if (event == "VARIABLES_LOADED") then
		WarriorButton_Configuration_Init()
		WarriorButton_CheckButtons()
		if Zorlen_isCurrentClassWarrior then
			DEFAULT_CHAT_FRAME:AddMessage("Warrior Button v"..WarriorButton_version.." enabled")
		else
			WarriorButton_Configuration["Enabled"] = false
			DEFAULT_CHAT_FRAME:AddMessage("Warrior Button: Disabled for this session")
			return
		end
		WarriorButton_RegisterHooks()
	elseif (event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE" or event == "CHAT_MSG_SPELL_HOSTILEPLAYER_BUFF" or event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF" or event == "CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE" or event == "CHAT_MSG_SPELL_CREATURE_VS_SELF_BUFF") then
		--Check to see if enemy casts spell
		for mob, spell in string.gfind(arg1, "(.+) begins to cast (.+).") do
			if (mob == UnitName("target") and UnitCanAttack("player", "target") and mob ~= spell) then
				WarriorButton_SpellInterrupt = GetTime()
			end
		end
	elseif (event == "CHAT_MSG_SPELL_SELF_DAMAGE" and string.find(arg1, "You interrupt (.+).")) then
	--Check to see if enemy spellcasting is interrupted
		WarriorButton_SpellInterrupt = nil
	elseif ((event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE") and string.find(arg1, "begins to cast Bellowing Roar")) then
		WarriorButton_FearEvent = GetTime()
		WarriorButton_FearTime = 2
		DEFAULT_CHAT_FRAME:AddMessage("Warrior Button: Detected incoming fear in "..WarriorButton_FearTime.." seconds.")
		--Onyxia/Nefarion fear check
	elseif ((event == "CHAT_MSG_RAID_LEADER" or event == "CHAT_MSG_RAID") and string.find(arg1, "5 SECONDS UNTIL AE FEAR")) then
		WarriorButton_FearEvent = GetTime()
		WarriorButton_FearTime = 5
		DEFAULT_CHAT_FRAME:AddMessage("Warrior Button: Detected incoming fear in "..WarriorButton_FearTime.." seconds.")
		--Magmadar fear check w/ CT Raid
	elseif (event == "PLAYER_TARGET_CHANGED") then
		WarriorButton_ShortAoEDelay = GetTime()
		WarriorButton_RogueEvasion = nil
		WarriorButton_SpellInterrupt = nil
		WB_RendSpellCastImmune = false
	end
end

--------------------------------------------------

function WarriorButton_OnUpdate()
	local m = UnitMana("player")
			
	if Zorlen_RendSpellCastImmune and Zorlen_inCombat() then
		WB_RendSpellCastImmune = true
	elseif not Zorlen_inCombat() then
		WB_RendSpellCastImmune = false
	end
		
	if Zorlen_Button_HeroicStrike then
		WarriorButton_HeroicStrike = IsCurrentAction(Zorlen_Button_HeroicStrike)
	end
	if Zorlen_Button_Cleave then
		WarriorButton_Cleave = IsCurrentAction(Zorlen_Button_Cleave)
	end
	if WarriorButton_HeroicStrike then
		m = (m - Zorlen_HeroicStrikeRageCost())
	end
	if WarriorButton_Cleave then
		m = (m - 20)
	end
	if m < WarriorButton_Configuration["RageBuffer"] and WarriorButton_Configuration["Enabled"] and (WarriorButton_HeroicStrike or WarriorButton_Cleave) then
		SpellStopCasting()
	end
end

--------------------------------------------------

function WarriorButton_RegisterHooks()
	WarriorButton_Real_UseAction = UseAction
	UseAction = WarriorButton_OnUseAction
end

--------------------------------------------------

function WarriorButton_OnUseAction(slot, checkFlags, checkSelf)
	if WarriorButton_Configuration["Enabled"] and WarriorButton_Configuration["HeroicStrike"] then
		local texture = GetActionTexture(slot)
		local text = GetActionText(slot)
		if texture and (not text) and (not CursorHasSpell()) and (not CursorHasItem()) 
			and string.find(texture,Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_BattleShout)) then
			WarriorButton()
			return
		end
	end
	WarriorButton_Real_UseAction(slot, checkFlags, checkSelf)
end


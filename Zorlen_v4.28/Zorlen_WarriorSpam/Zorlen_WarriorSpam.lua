

local TOC_FBN = 688

local XML_FBN = 680

local MinimumRequiredZorlenBuildNumber = 688


Zorlen_WarriorSpam_SunderRemainingDurationCastTime = 10


--[[
  Written by BigRedBrent
  
  2.47
		Added a GUI Options Window. To open it you may use the slash command:
		/zws
		or
		/ws
  
  2.46
		New slash command option to turn off hamstring for mobs completely:
		/zws hamstring off
  
  2.45
		Removed physical damage class scanning
  
  2.44
		Removed overpower and execute from being able to cast with the tanking functions
		Updated "ZWS Tanking" macro so that it does not use demo shout or rend since this may lower your aggro, the "ZWS Off Tanking" macro will still use demo shout and rend
  
  2.43.01
		Will now use Shield Block when using regular tanking modes if Shield Slam is not on cool down,
		will still require Shield Slam to be on cool down with hate builder and will always require Revenge to be on cool down
  
  2.43
		Will use sunder armor less when useing hate builder if you have shield slam
  
  2.42
		Will now try to use Shield Slam more then Sunder Armor if less then 2 physical damage classes are targeting your target when useing the tanking macros
  
  2.41
		Gave less priority to shield bash when tanking if shield slam is learned
  
  2.40
		You can use "/zws icons" to enable and disable icon updating on the built in macros added with "/zws make macros", this is disabled by default since it will lower frame rates
		Removed bugs that prevented Overpower and Revenge to cast correctly on a boss
		HateBuilder will now always give Revenge priority over Sunder Armor even if Sunder Armor is about to expire from the target
		Updated tanking casting logic to try to increase hate generation
  
  2.38
		Added slash command to make some WarriorSpam macros that I like to use:
		/zws make macros
  
  2.37
		Fixed a long running lag problem if the attack spell was not on any of your action bars
		Added targeting option slash commands:  Use /ws or /zws to see them
  
  2.36.00
		Added Concussion Blow as a spell interrupt
  
  2.35.01
		The command "/zws hamstring" will now have hamstring cast if the target's health is at 50%  or lower instead of 40% or lower
  
  2.35.00
		Should no longer try to cast Hamstring on a boss
  
  2.34.00
		Will try to use defensive stance if immobilized and not able to attack
		The tanking and off tanking functions will now remove Blessing of Salvation and Greater Blessing of Salvation
		All functions will now remove Blessing of Wisdom and Greater Blessing of Wisdom
  
  2.33.00
		Added auto casting of "Insignia of the Alliance" and "Insignia of the Horde" with help from Miravlix
  
  2.32.00
		Updated Hamstring
  
  2.31.00
		Updated the rage cost of Shield Slam 
  
  2.30.00
		Added "nocharge" options that will not charge or intercept an aggored mob
		Added options:
		"nocharge"
		"targetnocharge"
		"disarmnocharge"
		"targetdisarmnocharge"
		Added slash command: /zws hamstring
  
  2.29.00
		Will no longer switch to Berserker Stance for you just to gain the extra crit chance damage when an enemy target is not targeting you
		Will now try to go back to the original stance if the stance is changed to perform an action
  
  2.28.00
		Improved Sunder Armor casting some
		Will no longer switch to Battle Stance for you just to avoid the extra damage when an enemy target is targeting you
  
  2.27.00
		Will now only cast Death Wish for you if you are feared, instead of always if your target is a player
		Will try to cast Berserker Rage if you are feared or incapacitated when you are in berserker stance
		Unlimited sunder for tanking has now been turned on by default, will now by default give priority to sunder armor over heroic strike for tanking, use "/zws sunder" to change the setting.
  
  2.26.00
		Added slash command:
		/zws sunder
  
  2.25.01
		Small updates.
  
  2.25.00
		Added:
		Zorlen_WarriorSpam_OffTankingHateBuilder()
		Zorlen_WarriorSpam_OffTankingWithRendAndDemoShout()
		Zorlen_WarriorSpam_OffTankingWithRend()
		Zorlen_WarriorSpam_OffTankingWithDemoShout()
		Zorlen_WarriorSpam_OffTanking()
		I only removed the taunts from the OffTanking functions
  
  2.23.01
		Tiny update.
  
  2.23.00
		Improved casting of Heroic Strike. Will now cast Heroic Strike independently of other spells.
		Tweaked the casting of a few other spells some.
  
  2.22.00
		Removed force targeting from the control key, will now only force targeting if you use the alt key.
  
  2.21.00
		Fixed a bug with Bloodrage not casting for rage to use intercept.
		Will now always target inactive enemys for you if you hold down the alt key when you use the functions.
		Will now always target inactive enemys for you and force charge for you even if you are in combat and targeting an inactive enemy if you hold down the control key when you use the functions.
  
  2.20.00
		Put taunt back in the tanking functions.
		Improved the tanking logic and will no longer let any rage go to wast.
  
  2.18.00
		Reduced stance change for Mocking Blow from taunt not being detected fast enough.
		A few other bug fixes.
  
  2.17.00
		Added distance check for Heroic Strike.
  
  2.16.00
		Added some key bindings.
  
  2.15.01
		Removed Zorlen_backOff()
  
  2.15.00
		Improved targeting some.
		Improved stance swapping some.
  
  2.14.00
		Shield Block will now only cast when tanking if Revenge is not on cool down. This is so revenge may be active more often.
  
  2.13.00
		Shield Slam will now be used for dps and not just tanking if it can cast.
		Updated stance swapping.
		Updated intercept stance swapping logic. It should now be able to swap stances correctly when charge is on cool down.
  
  2.12.00
		Updated stance swapping.
  
  2.10.00
		Improved Overpower casting logic.
		Will try to stay in berserker stance if your target is not attacking you, to try to increase damage.
		Will switch to battle stance from berserker if your target is attacking you, to try to reduce down time by avoiding the extra 10% damage caused to player.
  
  2.01.00
		Lowered the rage buffer for the 31 talent point abilitys by 10.
  
  2.0
		Will change stances to overpower, taunt, spell interrupt, and intercept.
		Will cast bloodrage or improved berserker rage when rage is required.
  
  1.2.0
		Replaced a lot of the CastSpellByName commands.
  
  1.1.2
		Will not Hamstring mobs any more unless they are fleeing.
  
  1.1.1
		Attack no longer required to be on an action button bar slot.
  
  1.1.0
		Updated Tanking and HateBuilder casting logic.
  
  1.0.9
		Updated some of the Demoralizing Shout casting logic.
  
  1.0.8
		Updated some of the casting logic.
  
  1.0.7
		Updated some of the charge stance changing logic.
  
  1.0.6
		Updated some of the casting logic.
  
  1.0.5
		Updated some of the casting logic.
		Added the "forcecharge" option. force may now be placed in front of charge in all the function options to force the switching of stances if doing so will allow you to cast  Charge or Intercept.
		Added: Zorlen_WarriorSpam_HateBuilder()
  
  1.0.4
		Updated some of the casting logic.
  
  1.0.2
		Added:
		Zorlen_WarriorSpam_TankingWithRendAndDemoShout("disarm")
		Zorlen_WarriorSpam_TankingWithRendAndDemoShout("targetdisarm")
		Zorlen_WarriorSpam_TankingWithRendAndDemoShout("chargedisarm")
		Zorlen_WarriorSpam_TankingWithRendAndDemoShout("targetchargedisarm")
		Zorlen_WarriorSpam_TankingWithRend("disarm")
		Zorlen_WarriorSpam_TankingWithRend("targetdisarm")
		Zorlen_WarriorSpam_TankingWithRend("chargedisarm")
		Zorlen_WarriorSpam_TankingWithRend("targetchargedisarm")
		Zorlen_WarriorSpam_TankingWithDemoShout("disarm")
		Zorlen_WarriorSpam_TankingWithDemoShout("targetdisarm")
		Zorlen_WarriorSpam_TankingWithDemoShout("chargedisarm")
		Zorlen_WarriorSpam_TankingWithDemoShout("targetchargedisarm")
		Zorlen_WarriorSpam_Tanking("disarm")
		Zorlen_WarriorSpam_Tanking("targetdisarm")
		Zorlen_WarriorSpam_Tanking("chargedisarm")
		Zorlen_WarriorSpam_Tanking("targetchargedisarm")
		Zorlen_WarriorSpam_WithRendAndDemoShout("disarm")
		Zorlen_WarriorSpam_WithRendAndDemoShout("targetdisarm")
		Zorlen_WarriorSpam_WithRendAndDemoShout("chargedisarm")
		Zorlen_WarriorSpam_WithRendAndDemoShout("targetchargedisarm")
		Zorlen_WarriorSpam_WithRend("disarm")
		Zorlen_WarriorSpam_WithRend("targetdisarm")
		Zorlen_WarriorSpam_WithRend("chargedisarm")
		Zorlen_WarriorSpam_WithRend("targetchargedisarm")
		Zorlen_WarriorSpam_WithDemoShout("disarm")
		Zorlen_WarriorSpam_WithDemoShout("targetdisarm")
		Zorlen_WarriorSpam_WithDemoShout("chargedisarm")
		Zorlen_WarriorSpam_WithDemoShout("targetchargedisarm")
		Zorlen_WarriorSpam("disarm")
		Zorlen_WarriorSpam("targetdisarm")
		Zorlen_WarriorSpam("chargedisarm")
		Zorlen_WarriorSpam("targetchargedisarm")
  
  1.0.1
		Added:
		Zorlen_WarriorSpam_TankingWithRendAndDemoShout("target")
		Zorlen_WarriorSpam_TankingWithRendAndDemoShout("targetcharge")
		Zorlen_WarriorSpam_TankingWithRend("target")
		Zorlen_WarriorSpam_TankingWithRend("targetcharge")
		Zorlen_WarriorSpam_TankingWithDemoShout("target")
		Zorlen_WarriorSpam_TankingWithDemoShout("targetcharge")
		Zorlen_WarriorSpam_Tanking("target")
		Zorlen_WarriorSpam_Tanking("targetcharge")
		Zorlen_WarriorSpam_WithRendAndDemoShout("target")
		Zorlen_WarriorSpam_WithRendAndDemoShout("targetcharge")
		Zorlen_WarriorSpam_WithRend("target")
		Zorlen_WarriorSpam_WithRend("targetcharge")
		Zorlen_WarriorSpam_WithDemoShout("target")
		Zorlen_WarriorSpam_WithDemoShout("targetcharge")
		Zorlen_WarriorSpam("target")
		Zorlen_WarriorSpam("targetcharge")
  
  1.0.1
		Removed:
		Zorlen_WarriorSpam_PVP()
		Zorlen_WarriorSpam_PVP("charge")
		Made all functions detect if you are targeting a player or not so they will all work in pvp or not.
		Added:
		Zorlen_WarriorSpam_Tanking()
		Zorlen_WarriorSpam_Tanking("charge")
  
  1.0.0
		Added:
		Zorlen_WarriorSpam_TankingWithRendAndDemoShout()
		Zorlen_WarriorSpam_TankingWithRendAndDemoShout("charge")
		Zorlen_WarriorSpam_TankingWithRend()
		Zorlen_WarriorSpam_TankingWithRend("charge")
		Zorlen_WarriorSpam_TankingWithDemoShout()
		Zorlen_WarriorSpam_TankingWithDemoShout("charge")
		Zorlen_WarriorSpam_Tanking()
		Zorlen_WarriorSpam_Tanking("charge")
		Zorlen_WarriorSpam_WithRendAndDemoShout()
		Zorlen_WarriorSpam_WithRendAndDemoShout("charge")
		Zorlen_WarriorSpam_WithRend()
		Zorlen_WarriorSpam_WithRend("charge")
		Zorlen_WarriorSpam_WithDemoShout()
		Zorlen_WarriorSpam_WithDemoShout("charge")
		Zorlen_WarriorSpam()
		Zorlen_WarriorSpam("charge")
--]]


Zorlen_WarriorSpam_LocalizedPlayerClass, Zorlen_WarriorSpam_PlayerClass = UnitClass("player");
if (Zorlen_WarriorSpam_PlayerClass == "WARRIOR") then
	Zorlen_WarriorSpam_isCurrentClassWarrior = 1
end

zorlen_warriorspam_version = GetAddOnMetadata("Zorlen_WarriorSpam", "Version")
Zorlen_WarriorSpamOptionsFrame_Title = "Zorlen WarriorSpam"
Zorlen_WarriorSpam_TOC_FileBuildNumber = GetAddOnMetadata("Zorlen_WarriorSpam", "X-TocFileBuildNumber")
Zorlen_WarriorSpam_Active = 1;
BINDING_HEADER_ZORLEN_WARRIORSPAM_BINDINGS = "Zorlen WarriorSpam"
local zorlen_warriorspam_startup_message = "Zorlen WarriorSpam enabled"
local ZPN = nil;
local UNLIMITEDSUNDER = "unlimited_sunder";
local ALWAYSHAMSTRING = "always_hamstring";
local HAMSTRINGOFF = "hamstring_off";
local CYCLES = "cycles";
local TARGETINGOFF = "targeting_off";
local MACROICONSOFF = "macro_icons_off";
local MACROUPDATENAME = "macro_update_name";
local Zorlen_WarriorSpam_VariablesLoaded = nil;
local Zorlen_WarriorSpam_Initialized = nil;


function Zorlen_WarriorSpam_OnLoad()
	if Zorlen_WarriorSpam_isCurrentClassWarrior then
		this:RegisterEvent("PLAYER_ENTERING_WORLD");
		this:RegisterEvent("VARIABLES_LOADED");
	end
	SlashCmdList["ZorlenWarriorSpam"] = Zorlen_WarriorSpam_SlashHandler;
	SLASH_ZorlenWarriorSpam1 = "/Zorlen_warriorspam"
	SLASH_ZorlenWarriorSpam2 = "/Zorlenwarriorspam"
	SLASH_ZorlenWarriorSpam3 = "/Zorlen_ws"
	SLASH_ZorlenWarriorSpam4 = "/Zorlenws"
	SLASH_ZorlenWarriorSpam5 = "/Z_warriorspam"
	SLASH_ZorlenWarriorSpam6 = "/Zwarriorspam"
	SLASH_ZorlenWarriorSpam7 = "/Z_ws"
	SLASH_ZorlenWarriorSpam8 = "/Zws"
	SLASH_ZorlenWarriorSpam9 = "/Z_w"
	SLASH_ZorlenWarriorSpam10 = "/Zw"
	SLASH_ZorlenWarriorSpam11 = "/Zwspam"
	SLASH_ZorlenWarriorSpam12 = "/warriorspam"
	SLASH_ZorlenWarriorSpam13 = "/Wspam"
	SLASH_ZorlenWarriorSpam14 = "/Ws"
end

function Zorlen_WarriorSpam_FileBuildCheck()
	if not Zorlen_WarriorSpam_isCurrentClassWarrior then
		return
	end
	if Zorlen_WarriorSpam_TOC_FileBuildNumber == ""..TOC_FBN.."" and Zorlen_WarriorSpam_XML_FileBuildNumber == XML_FBN then
		return true
	end
	return false
end

local ZorlenBuildNumber = 0
function Zorlen_WarriorSpam_GetZorlenBuildNumber()
	if not Zorlen_WarriorSpam_isCurrentClassWarrior then
		return
	end
	if ZorlenBuildNumber == 0 then
		if Zorlen_TOC_FileBuildNumber and Zorlen_TOC_FileBuildNumber ~= "" then
			ZorlenBuildNumber = Zorlen_TOC_FileBuildNumber
		end
	end
end


function Zorlen_WarriorSpam_SlashHandler(message)
	local msg = nil
	if message then
		msg = string.lower(""..message.."")
	end
	if (msg == "resetall") or (msg == "reset all") then
		ZorlenWarriorSpamConfig = nil
		if Zorlen_WarriorSpam_isCurrentClassWarrior then
			Zorlen_WarriorSpam_Initialized = nil
			Zorlen_WarriorSpam_CheckVariables()
			if Zorlen_WarriorSpamMakeFirstMacros then
				Zorlen_WarriorSpam_MakeMacros(1, 1)
				Zorlen_WarriorSpamMakeFirstMacros = nil
			end
		end
		Zorlen_debug("Zorlen WarriorSpam settings have been reset for all warrior players", 1)
		return
	end
	if Zorlen_WarriorSpam_isCurrentClassWarrior then
		if (msg == "") then
			Zorlen_WarriorSpamOptionsFrame:Show()
		end
		if (msg == "options") or (msg == "help") or (msg == "debug options") or (msg == "debug help") then
			if Zorlen_WarriorSpam_FileBuildCheck() then
				Zorlen_debug("Zorlen WarriorSpam "..zorlen_warriorspam_version.." options:", 1);
			else
				Zorlen_debug("Zorlen WarriorSpam options:", 1);
			end
			Zorlen_debug("   [  status  |  version  |  make macros  |  icons  |  targeting  ]", 1);
			Zorlen_debug("   [  sunder  |  hamstring  |  cycles  |  reset  |  reset all  ]", 1);
		end
		if (msg == "reset") then
			ZorlenWarriorSpamConfig[ZPN] = nil
			Zorlen_WarriorSpam_Initialized = nil
			Zorlen_WarriorSpam_CheckVariables()
			if Zorlen_WarriorSpamMakeFirstMacros then
				Zorlen_WarriorSpam_MakeMacros(1, 1)
				Zorlen_WarriorSpamMakeFirstMacros = nil
			end
			Zorlen_debug("Zorlen WarriorSpam settings have been reset for "..UnitName("player"), 1)
		end
		if (msg == "macro") or (msg == "macros") or (msg == "make macro") or (msg == "make macros") or (msg == "makemacro") or (msg == "makemacros") then
			Zorlen_WarriorSpam_MakeMacros(1, 1)
		end
		if (msg == "targeting") then
			if ZorlenWarriorSpamConfig[ZPN][TARGETINGOFF] then
				ZorlenWarriorSpamConfig[ZPN][TARGETINGOFF] = nil;
				Zorlen_debug("Targeting has been enabled", 1);
			else
				ZorlenWarriorSpamConfig[ZPN][TARGETINGOFF] = true;
				Zorlen_debug("Targeting has been disabled", 1);
			end
		elseif (msg == "targeting off") then
			ZorlenWarriorSpamConfig[ZPN][TARGETINGOFF] = true;
			Zorlen_debug("Targeting has been disabled", 1);
		elseif (msg == "targeting on") then
			ZorlenWarriorSpamConfig[ZPN][TARGETINGOFF] = nil;
			Zorlen_debug("Targeting has been enabled", 1);
		end
		if (msg == "icons") or (msg == "icon") then
			if ZorlenWarriorSpamConfig[ZPN][MACROICONSOFF] then
				ZorlenWarriorSpamConfig[ZPN][MACROICONSOFF] = nil;
				Zorlen_WarriorSpam_RegisterMacroIcons()
				Zorlen_debug("Macro icons enabled", 1);
			else
				ZorlenWarriorSpamConfig[ZPN][MACROICONSOFF] = true;
				Zorlen_debug("Macro icons disabled", 1);
			end
		elseif (msg == "icons off") or (msg == "icon off") then
			ZorlenWarriorSpamConfig[ZPN][MACROICONSOFF] = true;
			Zorlen_debug("Macro icons disabled", 1);
		elseif (msg == "icons on") or (msg == "icon on") then
			ZorlenWarriorSpamConfig[ZPN][MACROICONSOFF] = nil;
			Zorlen_WarriorSpam_RegisterMacroIcons()
			Zorlen_debug("Macro icons enabled", 1);
		end
		if (msg == "cycles") then
			Zorlen_debug("This may set how many targeting cycles will be used to find a target", 1);
			Zorlen_debug("Valid options are: [  cycles normal  |  cycles #  ]", 1);
		elseif (msg == "cycles normal") then
			ZorlenWarriorSpamConfig[ZPN][CYCLES] = nil;
			Zorlen_debug("Targeting cycles have been set to normal", 1);
		elseif msg and msg ~= '' and string.find(msg, "cycles (%d+)") then
			local CyclesFound, _, CyclesNumber = string.find(msg, "cycles (%d+)")
			if CyclesFound then
				CyclesNumber = tonumber(CyclesNumber)
				if CyclesNumber and CyclesNumber <= 9 and CyclesNumber > 0 then
					ZorlenWarriorSpamConfig[ZPN][CYCLES] = CyclesNumber;
					Zorlen_debug("Targeting cycles have been set to: "..ZorlenWarriorSpamConfig[ZPN][CYCLES], 1);
				else
					Zorlen_debug("Valid numbers are 1 to 9", 1);
				end
			end
		elseif (msg == "cycles #") or (msg and msg ~= '' and string.find(msg, "cycles ")) then
			Zorlen_debug("Valid numbers are 1 to 9", 1);
		end
		if (msg == "hamstring") or (msg == "hs") then
			Zorlen_debug("Valid options for Hamstring are:", 1);
			Zorlen_debug("   [  hamstring mode  |  hamstring on  |  hamstring off  ]", 1);

		end
		if (msg == "hamstring off") or (msg == "hs off") then
			ZorlenWarriorSpamConfig[ZPN][HAMSTRINGOFF] = true;
			Zorlen_debug("Hamstring is now turned off for mobs", 1);
		end
		if (msg == "hamstring on") or (msg == "hs on") then
			ZorlenWarriorSpamConfig[ZPN][HAMSTRINGOFF] = nil;
			Zorlen_debug("Hamstring is now turned on for mobs", 1);
		end
		if (msg == "hamstring mode") or (msg == "hs mode") then
			if ZorlenWarriorSpamConfig[ZPN][ALWAYSHAMSTRING] then
				ZorlenWarriorSpamConfig[ZPN][ALWAYSHAMSTRING] = nil;
				Zorlen_debug("Zorlen WarriorSpam will now use Hamstring on MOB's only if they are running away", 1);
			else
				ZorlenWarriorSpamConfig[ZPN][ALWAYSHAMSTRING] = true;
				Zorlen_debug("Zorlen WarriorSpam will now use Hamstring if the targeted MOB's health is 50% or lower, even if the MOB is not running away", 1);
			end
		end
		if (msg == "hamstring always") or (msg == "hs always") then
			ZorlenWarriorSpamConfig[ZPN][ALWAYSHAMSTRING] = true;
			Zorlen_debug("Zorlen WarriorSpam will now use Hamstring if the targeted MOB's health is 50% or lower, even if the MOB is not running away", 1);
		end
		if (msg == "hamstring normal") or (msg == "hs normal") then
			ZorlenWarriorSpamConfig[ZPN][ALWAYSHAMSTRING] = nil;
			Zorlen_debug("Zorlen WarriorSpam will now use Hamstring on MOB's only if they are running away", 1);
		end
		if (msg == "sunder") or (msg == "sa") then
			if ZorlenWarriorSpamConfig[ZPN][UNLIMITEDSUNDER] then
				ZorlenWarriorSpamConfig[ZPN][UNLIMITEDSUNDER] = nil;
				Zorlen_debug("Zorlen WarriorSpam will now wait 20 seconds to sunder after sunder is stacked 5 times on the target", 1);
			else
				ZorlenWarriorSpamConfig[ZPN][UNLIMITEDSUNDER] = true;
				Zorlen_debug("Zorlen WarriorSpam will now use sunder even if sunder is stacked 5 times on the target", 1);
			end
		end
		if (msg == "sunder unlimited") or (msg == "sa unlimited") then
			ZorlenWarriorSpamConfig[ZPN][UNLIMITEDSUNDER] = true;
			Zorlen_debug("Zorlen WarriorSpam will now use sunder even if sunder is stacked 5 times on the target", 1);
		end
		if (msg == "sunder normal") or (msg == "sa normal") or (msg == "sunder limited") or (msg == "sa limited") then
			ZorlenWarriorSpamConfig[ZPN][UNLIMITEDSUNDER] = nil;
			Zorlen_debug("Zorlen WarriorSpam will now wait 20 seconds to sunder after sunder is stacked 5 times on the target", 1);
		end
		if (msg == "version") or (msg == "ver") or (msg == "v") then
			if Zorlen_WarriorSpam_FileBuildCheck() then
				Zorlen_debug("Zorlen WarriorSpam Version: "..zorlen_warriorspam_version.."", 1);
			end
		end
		if (msg == "status") or (msg == "show") or (msg == "debug status") or (msg == "debug show") then
			if Zorlen_WarriorSpam_FileBuildCheck() then
				Zorlen_debug("Zorlen WarriorSpam "..zorlen_warriorspam_version.." Status:", 1);
			else
				Zorlen_debug("Zorlen WarriorSpam Status:", 1);
			end
			if ZorlenWarriorSpamConfig[ZPN][UNLIMITEDSUNDER] then
				Zorlen_debug("-  Sunder mode is set to unlimited:", 1);
				Zorlen_debug("      ( Zorlen WarriorSpam will use sunder even if", 1);
				Zorlen_debug("         sunder is stacked 5 times on the target )", 1);
			else
				Zorlen_debug("-  Sunder mode is set to limited:", 1);
				Zorlen_debug("      ( Zorlen WarriorSpam will wait 20 seconds to sunder after", 1);
				Zorlen_debug("         sunder is stacked 5 times on the target )", 1);
			end
			if ZorlenWarriorSpamConfig[ZPN][HAMSTRINGOFF] then
				Zorlen_debug("-  Hamstring is turned OFF:", 1);
			else
				Zorlen_debug("-  Hamstring is turned ON:", 1);
			end
			if ZorlenWarriorSpamConfig[ZPN][ALWAYSHAMSTRING] then
				Zorlen_debug("-  Hamstring mode is set to always:", 1);
				Zorlen_debug("      ( Zorlen WarriorSpam will use Hamstring if", 1);
				Zorlen_debug("         the targeted MOB's health is 50% or lower,", 1);
				Zorlen_debug("          even if the MOB is not running away )", 1);
			else
				Zorlen_debug("-  Hamstring mode is set to normal:", 1);
				Zorlen_debug("      ( Zorlen WarriorSpam will use Hamstring on", 1);
				Zorlen_debug("         MOB's only if they are running away )", 1);
			end
			if ZorlenWarriorSpamConfig[ZPN][TARGETINGOFF] then
				Zorlen_debug("-  Targeting is disabled", 1);
			else
				Zorlen_debug("-  Targeting is enabled", 1);
			end
			if ZorlenWarriorSpamConfig[ZPN][CYCLES] then
				Zorlen_debug("-  Targeting cycles set to: "..ZorlenWarriorSpamConfig[ZPN][CYCLES], 1);
			else
				Zorlen_debug("-  Targeting cycles set to normal", 1);
			end
			if ZorlenWarriorSpamConfig[ZPN][MACROICONSOFF] then
				Zorlen_debug("-  Macro icons disabled", 1);
			else
				Zorlen_debug("-  Macro icons enabled", 1);
			end
		end
		if ZorlenBuildNumber < MinimumRequiredZorlenBuildNumber then
			Zorlen_debug("<<< A newer version of Zorlen is required for Zorlen_WarriorSpam to work correctly! >>>", 1);
		end
		if not Zorlen_WarriorSpam_FileBuildCheck() then
			Zorlen_debug("<<< Files that are not the same version have been detected in the Zorlen_WarriorSpam folder! >>>", 1);
		end
		if not Zorlen_FileBuildCheck() then
			Zorlen_debug("<<< Files that are not the same version have been detected in the Zorlen folder! >>>", 1);
		end
	else
		Zorlen_debug("Zorlen WarriorSpam: You are not on a warrior class character", 1);
	end
end

function Zorlen_WarriorSpam_OnUpdate(arg1)
	if not Zorlen_WarriorSpam_isCurrentClassWarrior or (not this.WarriorSpamBerserkerStanceDelay_timer and not this.MockingBlowDelay_timer and not this.RefreshIcons_timer) then
		this:Hide()
	end
	if this.MockingBlowDelay_timer then
		this.MockingBlowDelay_timer = this.MockingBlowDelay_timer - arg1;
		if (this.MockingBlowDelay_timer <= 0) or Zorlen_TargetIsEnemyTargetingYou() or not Zorlen_TargetIsEnemyTargetingFriendButNotYou() then
			Zorlen_WarriorSpam_MockingBlowDelay = nil;
			this.MockingBlowDelay_timer = nil;
		end
	end
	if this.FirstEnemyTargetDelay_timer then
		this.FirstEnemyTargetDelay_timer = this.FirstEnemyTargetDelay_timer - arg1;
		if (this.FirstEnemyTargetDelay_timer <= 0) then
			Zorlen_WarriorSpam_FirstEnemyTarget = nil;
			this.FirstEnemyTargetDelay_timer = nil;
		end
	end
	if this.RefreshIcons_timer then
		this.RefreshIcons_timer = this.RefreshIcons_timer - arg1;
		if (this.RefreshIcons_timer <= 0) then
			if ZorlenWarriorSpamConfig[ZPN][MACROICONSOFF] then
				Zorlen_EditMacro("ZWS DPS", nil, "Ability_Warrior_OffensiveStance")
				Zorlen_EditMacro("ZWS Grind", nil, "Ability_BackStab")
				Zorlen_EditMacro("ZWS HateBuilder", nil, "Ability_Creature_Cursed_02")
				Zorlen_EditMacro("ZWS Tanking", nil, "Ability_Warrior_DefensiveStance")
				Zorlen_EditMacro("ZWS Off Tanking", nil, "Spell_Magic_MageArmor")
				this.RefreshIcons_timer = nil
			else
				this.RefreshIcons_timer = 0.2
				Zorlen_WarriorSpam_UpdateMacro()
			end
		end
	end
end

function Zorlen_WarriorSpam_EnteringWorld_timer_function()
	Zorlen_WarriorSpam_RegisterMacroIcons()
	if Zorlen_WarriorSpamMakeFirstMacros then
		Zorlen_WarriorSpam_MakeMacros(1, 1)
		Zorlen_WarriorSpamMakeFirstMacros = nil
	else
		Zorlen_WarriorSpam_MakeMacros(nil, 1, 1)
	end
end

function Zorlen_WarriorSpam_OnEvent(event, arg1, arg2, arg3)
	if not Zorlen_WarriorSpam_isCurrentClassWarrior then
		return
	end
	if (event == ("PLAYER_ENTERING_WORLD")) then
		Zorlen_WarriorSpam_GetZorlenBuildNumber()
		Zorlen_WarriorSpam_CheckVariables()
		Zorlen_SetTimer(2, "WarriorSpamEnteringWorld", nil, "InternalZorlenMiscTimer", 2, Zorlen_WarriorSpam_EnteringWorld_timer_function)
		ZorlenWarriorSpamFrame:Show();
	elseif (event == ("VARIABLES_LOADED")) then
		Zorlen_WarriorSpam_VariablesLoaded = true;
		Zorlen_WarriorSpam_GetZorlenBuildNumber()
		Zorlen_WarriorSpam_CheckVariables()
		if Zorlen_WarriorSpam_isCurrentClassWarrior then
			Zorlen_WarriorSpam_RegisterMacroIcons()
		end
	elseif Zorlen_WarriorSpam_isCurrentClassWarrior then
		if (event == "PLAYER_REGEN_ENABLED") then
			ZorlenWarriorSpamFrame.FirstEnemyTargetDelay_timer = nil;
			Zorlen_WarriorSpam_FirstEnemyTarget = nil;
		elseif (event == "PLAYER_REGEN_DISABLED") then
			if Zorlen_TargetIsEnemy() and not Zorlen_TargetIsActiveEnemy() and not Zorlen_isBreakOnDamageCC() then
				Zorlen_WarriorSpam_HealthWhenCombatStarted = UnitHealth("player");
				Zorlen_WarriorSpam_FirstEnemyTarget = 1;
				ZorlenWarriorSpamFrame.FirstEnemyTargetDelay_timer = 5;
				ZorlenWarriorSpamFrame:Show();
			end
		elseif (event == "UPDATE_BONUS_ACTIONBAR") then
			Zorlen_WarriorSpam_RegisterWarriorStance()
			if (Zorlen_WarriorSpam_CurrentStance == LOCALIZATION_ZORLEN.BerserkerStance) then
				Zorlen_WarriorSpam_SwapFromBerserkerToDoAction = nil;
			end
			if (Zorlen_WarriorSpam_CurrentStance == LOCALIZATION_ZORLEN.BattleStance) then
				Zorlen_WarriorSpam_SwapFromBattleToDoAction = nil;
			end
			if (Zorlen_WarriorSpam_CurrentStance == LOCALIZATION_ZORLEN.DefensiveStance) then
				Zorlen_WarriorSpam_SwapFromDefensiveToDoAction = nil;
			end
		elseif (event == ("PLAYER_TARGET_CHANGED")) then
			ZorlenWarriorSpamFrame.MockingBlowDelay_timer = nil;
			Zorlen_WarriorSpam_MockingBlowDelay = nil;
			ZorlenWarriorSpamFrame.FirstEnemyTargetDelay_timer = nil;
			Zorlen_WarriorSpam_FirstEnemyTarget = nil;
		elseif (event == "CHAT_MSG_SPELL_SELF_DAMAGE") then
			if string.find(arg1, LOCALIZATION_ZORLEN.Taunt.." ") then
				Zorlen_debug("Target has resisted "..LOCALIZATION_ZORLEN.Taunt.."!");
				ZorlenWarriorSpamFrame.MockingBlowDelay_timer = nil;
				Zorlen_WarriorSpam_MockingBlowDelay = nil;
			end
		elseif (event == "LEARNED_SPELL_IN_TAB") then
			Zorlen_WarriorSpam_RegisterMacroIcons()
		end
	end
end


-------- All functions below this line will only load if you are playing the corresponding class
if not Zorlen_WarriorSpam_isCurrentClassWarrior then return end


function Zorlen_WarriorSpam_CheckVariables()
	if (not Zorlen_WarriorSpam_VariablesLoaded) or (not Zorlen_WarriorSpam_isCurrentClassWarrior) then
		return false;
	end
	if (Zorlen_WarriorSpam_Initialized) then
		return true;
	end
	this:RegisterEvent("PLAYER_REGEN_ENABLED");
	this:RegisterEvent("PLAYER_REGEN_DISABLED");
	this:RegisterEvent("UPDATE_BONUS_ACTIONBAR");
	this:RegisterEvent("PLAYER_TARGET_CHANGED");
	this:RegisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE");
	this:RegisterEvent("LEARNED_SPELL_IN_TAB");
	if (ZPN == nil) then
		ZPN = UnitName("player");
		if (ZPN == nil) then
			--Character name not available yet
			return false;
		else 
			ZPN = GetCVar("realmName") .. "." .. ZPN;
		end
	end
	--Build our variable table
	if (not ZorlenWarriorSpamConfig) then
		ZorlenWarriorSpamConfig = {};
	end
	--Initialize the array for this character
	if (not ZorlenWarriorSpamConfig[ZPN]) then
		ZorlenWarriorSpamConfig[ZPN] = {};
		ZorlenWarriorSpamConfig[ZPN][UNLIMITEDSUNDER] = true;
		ZorlenWarriorSpamConfig[ZPN][ALWAYSHAMSTRING] = nil;
		ZorlenWarriorSpamConfig[ZPN][HAMSTRINGOFF] = nil;
		ZorlenWarriorSpamConfig[ZPN][CYCLES] = nil;
		ZorlenWarriorSpamConfig[ZPN][TARGETINGOFF] = nil;
		ZorlenWarriorSpamConfig[ZPN][MACROICONSOFF] = true;
		ZorlenWarriorSpamConfig[ZPN][MACROUPDATENAME] = "ZWS DPS";
		Zorlen_WarriorSpamMakeFirstMacros = 1
	end
	Zorlen_WarriorSpam_Initialized = true;
	Zorlen_debug(zorlen_warriorspam_startup_message, 1);
	if ZorlenBuildNumber < MinimumRequiredZorlenBuildNumber then
		Zorlen_debug("<<< A newer version of Zorlen is required for Zorlen_WarriorSpam to work correctly! >>>", 1);
	end
	return true;
end

function Zorlen_WarriorSpam_LoadOptionsFrameSettings()
	Zorlen_WarriorSpamOptionsFrame_UnlimitedSunder:SetChecked(ZorlenWarriorSpamConfig[ZPN][UNLIMITEDSUNDER])
	Zorlen_WarriorSpamOptionsFrame_AlwaysHamstringMode:SetChecked(ZorlenWarriorSpamConfig[ZPN][ALWAYSHAMSTRING])
	local Hamstring = (not ZorlenWarriorSpamConfig[ZPN][HAMSTRINGOFF])
	Zorlen_WarriorSpamOptionsFrame_HamstringMobs:SetChecked(Hamstring)
	local Targeting = (not ZorlenWarriorSpamConfig[ZPN][TARGETINGOFF])
	Zorlen_WarriorSpamOptionsFrame_AutoTargeting:SetChecked(Targeting)
	local icons = (not ZorlenWarriorSpamConfig[ZPN][MACROICONSOFF])
	Zorlen_WarriorSpamOptionsFrame_UpdateMacroIcons:SetChecked(icons)
	local cycles = ZorlenWarriorSpamConfig[ZPN][CYCLES] or ""
	Zorlen_WarriorSpamOptionsFrame_Cycles:SetText(cycles)
end

function Zorlen_WarriorSpam_SaveOptionsFrameSettings()
	if Zorlen_WarriorSpamOptionsFrame_UnlimitedSunder:GetChecked() then
		ZorlenWarriorSpamConfig[ZPN][UNLIMITEDSUNDER] = true
	else
		ZorlenWarriorSpamConfig[ZPN][UNLIMITEDSUNDER] = nil
	end
	if Zorlen_WarriorSpamOptionsFrame_AlwaysHamstringMode:GetChecked() then
		ZorlenWarriorSpamConfig[ZPN][ALWAYSHAMSTRING] = true
	else
		ZorlenWarriorSpamConfig[ZPN][ALWAYSHAMSTRING] = nil
	end
	if Zorlen_WarriorSpamOptionsFrame_HamstringMobs:GetChecked() then
		ZorlenWarriorSpamConfig[ZPN][HAMSTRINGOFF] = nil
	else
		ZorlenWarriorSpamConfig[ZPN][HAMSTRINGOFF] = true
	end
	if Zorlen_WarriorSpamOptionsFrame_AutoTargeting:GetChecked() then
		ZorlenWarriorSpamConfig[ZPN][TARGETINGOFF] = nil
	else
		ZorlenWarriorSpamConfig[ZPN][TARGETINGOFF] = true
	end
	if Zorlen_WarriorSpamOptionsFrame_UpdateMacroIcons:GetChecked() then
		if ZorlenWarriorSpamConfig[ZPN][MACROICONSOFF] then
			ZorlenWarriorSpamConfig[ZPN][MACROICONSOFF] = nil
			Zorlen_WarriorSpam_RegisterMacroIcons()
		end
	else
		ZorlenWarriorSpamConfig[ZPN][MACROICONSOFF] = true
	end
	local cycles = Zorlen_WarriorSpamOptionsFrame_Cycles:GetText()
	if cycles and cycles ~= "" then
		if cycles ~= ZorlenWarriorSpamConfig[ZPN][CYCLES] then
			if tonumber(""..cycles.."") > 0 then
				ZorlenWarriorSpamConfig[ZPN][CYCLES] = cycles
			end
		end
	else
		ZorlenWarriorSpamConfig[ZPN][CYCLES] = nil
	end
end


function Zorlen_WarriorSpam_RegisterWarriorStance()
	if not Zorlen_WarriorSpam_isCurrentClassWarrior then
		return
	end
	local i;
	local max = GetNumShapeshiftForms();
	for i = 1 , max do
		local _, name, isActive = GetShapeshiftFormInfo(i);
		if isActive then
			Zorlen_WarriorSpam_CurrentStance = name;
			return;
		end
	end
	Zorlen_WarriorSpam_CurrentStance = "Default";
end



function Zorlen_WarriorSpam_RegisterMacroIcons()
	if not Zorlen_WarriorSpam_isCurrentClassWarrior then
		return
	end
	if not ZorlenWarriorSpamConfig[ZPN][MACROICONSOFF] then
		Zorlen_WarriorSpam_IconIndex_Idle = Zorlen_GiveMacroIconIndex("Spell_Shadow_SacrificialShield")
		Zorlen_WarriorSpam_IconIndex_Attack = Zorlen_GiveMacroIconIndex("Ability_DualWield")
		Zorlen_WarriorSpam_IconIndex_BattleStance = Zorlen_GiveMacroIconIndex("Ability_Warrior_OffensiveStance")
		Zorlen_WarriorSpam_IconIndex_DefensiveStance = Zorlen_GiveMacroIconIndex("Ability_Warrior_DefensiveStance")
		Zorlen_WarriorSpam_IconIndex_BerserkerStance = Zorlen_GiveMacroIconIndex("Ability_Racial_Avatar")
		Zorlen_WarriorSpam_IconIndex_Execute = Zorlen_GiveMacroIconIndex("Ability_Hunter_SwiftStrike")
		Zorlen_WarriorSpam_IconIndex_HeroicStrike = Zorlen_GiveMacroIconIndex("Ability_Rogue_Ambush")
		Zorlen_WarriorSpam_IconIndex_SunderArmor = Zorlen_GiveMacroIconIndex("Ability_Warrior_Sunder")
		Zorlen_WarriorSpam_IconIndex_MortalStrike = Zorlen_GiveMacroIconIndex("Ability_Warrior_SavageBlow")
		Zorlen_WarriorSpam_IconIndex_Bloodthirst = Zorlen_GiveMacroIconIndex("Spell_Nature_BloodLust")
		Zorlen_WarriorSpam_IconIndex_ShieldSlam = Zorlen_GiveMacroIconIndex("Spell_Fire_FireArmor")
		Zorlen_WarriorSpam_IconIndex_Charge = Zorlen_GiveMacroIconIndex("Ability_Warrior_Charge")
		Zorlen_WarriorSpam_IconIndex_Taunt = Zorlen_GiveMacroIconIndex("Spell_Nature_Reincarnation")
		Zorlen_WarriorSpam_IconIndex_Intercept = Zorlen_GiveMacroIconIndex("Ability_Rogue_Sprint")
		Zorlen_WarriorSpam_IconIndex_Overpower = Zorlen_GiveMacroIconIndex("Ability_MeleeDamage")
		Zorlen_WarriorSpam_IconIndex_Revenge = Zorlen_GiveMacroIconIndex("Ability_Warrior_Revenge")
		Zorlen_WarriorSpam_IconIndex_Rend = Zorlen_GiveMacroIconIndex("Ability_Gouge")
		Zorlen_WarriorSpam_IconIndex_Hamstring = Zorlen_GiveMacroIconIndex("Ability_ShockWave")
		Zorlen_WarriorSpam_IconIndex_ShieldBash = Zorlen_GiveMacroIconIndex("Ability_Warrior_ShieldBash")
		Zorlen_WarriorSpam_IconIndex_Pummel = Zorlen_GiveMacroIconIndex("Spell_Holy_FistOfJustice")
		Zorlen_WarriorSpam_IconIndex_ShieldBlock = Zorlen_GiveMacroIconIndex("Ability_Defend")
		Zorlen_WarriorSpam_IconIndex_DemoralizingShout = Zorlen_GiveMacroIconIndex("Ability_Warrior_WarCry")
		Zorlen_WarriorSpam_IconIndex_BattleShout = Zorlen_GiveMacroIconIndex("Ability_Warrior_BattleShout")
		Zorlen_WarriorSpam_IconIndex_BerserkerRage = Zorlen_GiveMacroIconIndex("Spell_Nature_AncestralGuardian")
		Zorlen_WarriorSpam_IconIndex_Bloodrage = Zorlen_GiveMacroIconIndex("Ability_Racial_BloodRage")
		Zorlen_WarriorSpam_IconIndex_DeathWish = Zorlen_GiveMacroIconIndex("Spell_Shadow_DeathPact")
		Zorlen_WarriorSpam_IconIndex_MockingBlow = Zorlen_GiveMacroIconIndex("Ability_Warrior_PunishingBlow")
		Zorlen_WarriorSpam_IconIndex_Disarm = Zorlen_GiveMacroIconIndex("Ability_Warrior_Disarm")
		Zorlen_WarriorSpam_IconIndex_ConcussionBlow = Zorlen_GiveMacroIconIndex("Ability_ThunderBolt")
		Zorlen_WarriorSpam_MakeMacros(nil, 1, 1)
		ZorlenWarriorSpamFrame.RefreshIcons_timer = 0.2
		ZorlenWarriorSpamFrame:Show();
	end
end




function Zorlen_WarriorSpam_GetGroupPhysicalDamageClassUnitArray()
	local group = "party"
	local NumMembers = nil
	local GroupPhysicalDamageClassUnitArray = {}
	local counter = 1
	local N = 0
	local u = nil
	local c = nil
	if UnitInRaid("player") then
		NumMembers = GetNumRaidMembers()
		counter = 2
		group = "raid"
	else
		NumMembers = GetNumPartyMembers()
	end
	while counter <= NumMembers do
		u = group..""..counter
		if UnitExists(u) then
			c = Zorlen_UnitClass(u)
			if (c == "Rogue") or (c == "Paladin") or (c == "Warrior") or (c == "Hunter") or ((c == "Druid") and (Zorlen_checkBuff("Ability_Druid_CatForm", u) or Zorlen_checkBuff("Ability_Racial_BearForm", u))) then
				N = N + 1
				GroupPhysicalDamageClassUnitArray[N] = u
			end
		end
		counter = counter + 1
	end
	Zorlen_debug("Group Physical Damage Class Count:  "..N);
	return GroupPhysicalDamageClassUnitArray
end








function Zorlen_WarriorSpam_TankingWithRendAndDemoShout(mode, macro, test)
	if not Zorlen_WarriorSpam_isCurrentClassWarrior then
		return
	end
	if (mode == "targetdisarm") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "yes", "yes", "no", "yes", "yes", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "yes", "yes", "no", "no", "yes", "yes", "yes", "yes", macro, test)
		end
	elseif (mode == "targetdisarmnocharge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "yes", "yes", "no", "yes", "yes", "no", "no", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "yes", "yes", "no", "no", "yes", "yes", "yes", "no", macro, test)
		end
	elseif (mode == "chargedisarm") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "yes", "yes", "yes", "no", "yes", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "yes", "yes", "no", "yes", "no", "yes", "yes", "yes", macro, test)
		end
	elseif (mode == "targetchargedisarm") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "yes", "yes", "yes", "yes", "yes", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "yes", "yes", "no", "yes", "yes", "yes", "yes", "yes", macro, test)
		end
	elseif (mode == "forcechargedisarm") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "yes", "yes", "force", "no", "yes", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "yes", "yes", "no", "force", "no", "yes", "yes", "yes", macro, test)
		end
	elseif (mode == "targetforcechargedisarm") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "yes", "yes", "force", "yes", "yes", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "yes", "yes", "no", "force", "yes", "yes", "yes", "yes", macro, test)
		end
	elseif (mode == "disarm") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "yes", "yes", "no", "no", "yes", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "yes", "yes", "no", "no", "no", "yes", "yes", "yes", macro, test)
		end
	elseif (mode == "disarmnocharge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "yes", "yes", "no", "no", "yes", "no", "no", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "yes", "yes", "no", "no", "no", "yes", "yes", "no", macro, test)
		end
	elseif (mode == "target") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "yes", "yes", "no", "yes", "no", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "yes", "yes", "no", "no", "yes", "no", "yes", "yes", macro, test)
		end
	elseif (mode == "targetnocharge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "yes", "yes", "no", "yes", "no", "no", "no", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "yes", "yes", "no", "no", "yes", "no", "yes", "no", macro, test)
		end
	elseif (mode == "charge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "yes", "yes", "yes", "no", "no", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "yes", "yes", "no", "yes", "no", "no", "yes", "yes", macro, test)
		end
	elseif (mode == "targetcharge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "yes", "yes", "yes", "yes", "no", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "yes", "yes", "no", "yes", "yes", "no", "yes", "yes", macro, test)
		end
	elseif (mode == "forcecharge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "yes", "yes", "force", "no", "no", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "yes", "yes", "no", "force", "no", "no", "yes", "yes", macro, test)
		end
	elseif (mode == "targetforcecharge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "yes", "yes", "force", "yes", "no", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "yes", "yes", "no", "force", "yes", "no", "yes", "yes", macro, test)
		end
	elseif (mode == "nocharge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "yes", "yes", "no", "no", "no", "no", "no", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "yes", "yes", "no", "no", "no", "no", "yes", "no", macro, test)
		end
	else
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "yes", "yes", "no", "no", "no", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "yes", "yes", "no", "no", "no", "no", "yes", "yes", macro, test)
		end
	end
end

function Zorlen_WarriorSpam_TankingWithRend(mode, macro, test)
	if not Zorlen_WarriorSpam_isCurrentClassWarrior then
		return
	end
	if (mode == "targetdisarm") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "no", "yes", "no", "yes", "yes", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "yes", "no", "no", "no", "yes", "yes", "yes", "yes", macro, test)
		end
	elseif (mode == "targetdisarmnocharge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "no", "yes", "no", "yes", "yes", "no", "no", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "yes", "no", "no", "no", "yes", "yes", "yes", "no", macro, test)
		end
	elseif (mode == "chargedisarm") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "no", "yes", "yes", "no", "yes", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "yes", "no", "no", "yes", "no", "yes", "yes", "yes", macro, test)
		end
	elseif (mode == "targetchargedisarm") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "no", "yes", "yes", "yes", "yes", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "yes", "no", "no", "yes", "yes", "yes", "yes", "yes", macro, test)
		end
	elseif (mode == "forcechargedisarm") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "no", "yes", "force", "no", "yes", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "yes", "no", "no", "force", "no", "yes", "yes", "yes", macro, test)
		end
	elseif (mode == "targetforcechargedisarm") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "no", "yes", "force", "yes", "yes", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "yes", "no", "no", "force", "yes", "yes", "yes", "yes", macro, test)
		end
	elseif (mode == "disarm") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "no", "yes", "no", "no", "yes", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "yes", "no", "no", "no", "no", "yes", "yes", "yes", macro, test)
		end
	elseif (mode == "disarmnocharge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "no", "yes", "no", "no", "yes", "no", "no", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "yes", "no", "no", "no", "no", "yes", "yes", "no", macro, test)
		end
	elseif (mode == "target") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "no", "yes", "no", "yes", "no", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "yes", "no", "no", "no", "yes", "no", "yes", "yes", macro, test)
		end
	elseif (mode == "targetnocharge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "no", "yes", "no", "yes", "no", "no", "no", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "yes", "no", "no", "no", "yes", "no", "yes", "no", macro, test)
		end
	elseif (mode == "charge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "no", "yes", "yes", "no", "no", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "yes", "no", "no", "yes", "no", "no", "yes", "yes", macro, test)
		end
	elseif (mode == "targetcharge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "no", "yes", "yes", "yes", "no", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "yes", "no", "no", "yes", "yes", "no", "yes", "yes", macro, test)
		end
	elseif (mode == "forcecharge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "no", "yes", "force", "no", "no", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "yes", "no", "no", "force", "no", "no", "yes", "yes", macro, test)
		end
	elseif (mode == "targetforcecharge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "no", "yes", "force", "yes", "no", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "yes", "no", "no", "force", "yes", "no", "yes", "yes", macro, test)
		end
	elseif (mode == "nocharge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "no", "yes", "no", "no", "no", "no", "no", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "yes", "no", "no", "no", "no", "no", "yes", "no", macro, test)
		end
	else
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "no", "yes", "no", "no", "no", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "yes", "no", "no", "no", "no", "no", "yes", "yes", macro, test)
		end
	end
end

function Zorlen_WarriorSpam_TankingWithDemoShout(mode, macro, test)
	if not Zorlen_WarriorSpam_isCurrentClassWarrior then
		return
	end
	if (mode == "targetdisarm") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "yes", "yes", "no", "yes", "yes", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "no", "yes", "no", "no", "yes", "yes", "yes", "yes", macro, test)
		end
	elseif (mode == "targetdisarmnocharge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "yes", "yes", "no", "yes", "yes", "no", "no", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "no", "yes", "no", "no", "yes", "yes", "yes", "no", macro, test)
		end
	elseif (mode == "chargedisarm") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "yes", "yes", "yes", "no", "yes", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "no", "yes", "no", "yes", "no", "yes", "yes", "yes", macro, test)
		end
	elseif (mode == "targetchargedisarm") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "yes", "yes", "yes", "yes", "yes", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "no", "yes", "no", "yes", "yes", "yes", "yes", "yes", macro, test)
		end
	elseif (mode == "forcechargedisarm") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "yes", "yes", "force", "no", "yes", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "no", "yes", "no", "force", "no", "yes", "yes", "yes", macro, test)
		end
	elseif (mode == "targetforcechargedisarm") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "yes", "yes", "force", "yes", "yes", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "no", "yes", "no", "force", "yes", "yes", "yes", "yes", macro, test)
		end
	elseif (mode == "disarm") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "yes", "yes", "no", "no", "yes", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "no", "yes", "no", "no", "no", "yes", "yes", "yes", macro, test)
		end
	elseif (mode == "disarmnocharge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "yes", "yes", "no", "no", "yes", "no", "no", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "no", "yes", "no", "no", "no", "yes", "yes", "no", macro, test)
		end
	elseif (mode == "target") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "yes", "yes", "no", "yes", "no", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "no", "yes", "no", "no", "yes", "no", "yes", "yes", macro, test)
		end
	elseif (mode == "targetnocharge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "yes", "yes", "no", "yes", "no", "no", "no", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "no", "yes", "no", "no", "yes", "no", "yes", "no", macro, test)
		end
	elseif (mode == "charge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "yes", "yes", "yes", "no", "no", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "no", "yes", "no", "yes", "no", "no", "yes", "yes", macro, test)
		end
	elseif (mode == "targetcharge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "yes", "yes", "yes", "yes", "no", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "no", "yes", "no", "yes", "yes", "no", "yes", "yes", macro, test)
		end
	elseif (mode == "forcecharge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "yes", "yes", "force", "no", "no", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "no", "yes", "no", "force", "no", "no", "yes", "yes", macro, test)
		end
	elseif (mode == "targetforcecharge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "yes", "yes", "force", "yes", "no", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "no", "yes", "no", "force", "yes", "no", "yes", "yes", macro, test)
		end
	elseif (mode == "nocharge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "yes", "yes", "no", "no", "no", "no", "no", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "no", "yes", "no", "no", "no", "no", "yes", "no", macro, test)
		end
	else
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "yes", "yes", "no", "no", "no", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "no", "yes", "no", "no", "no", "no", "yes", "yes", macro, test)
		end
	end
end

function Zorlen_WarriorSpam_Tanking(mode, macro, test)
	if not Zorlen_WarriorSpam_isCurrentClassWarrior then
		return
	end
	if (mode == "targetdisarm") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "no", "yes", "no", "yes", "yes", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "no", "no", "no", "no", "yes", "yes", "yes", "yes", macro, test)
		end
	elseif (mode == "targetdisarmnocharge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "no", "yes", "no", "yes", "yes", "no", "no", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "no", "no", "no", "no", "yes", "yes", "yes", "no", macro, test)
		end
	elseif (mode == "chargedisarm") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "no", "yes", "yes", "no", "yes", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "no", "no", "no", "yes", "no", "yes", "yes", "yes", macro, test)
		end
	elseif (mode == "targetchargedisarm") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "no", "yes", "yes", "yes", "yes", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "no", "no", "no", "yes", "yes", "yes", "yes", "yes", macro, test)
		end
	elseif (mode == "forcechargedisarm") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "no", "yes", "force", "no", "yes", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "no", "no", "no", "force", "no", "yes", "yes", "yes", macro, test)
		end
	elseif (mode == "targetforcechargedisarm") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "no", "yes", "force", "yes", "yes", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "no", "no", "no", "force", "yes", "yes", "yes", "yes", macro, test)
		end
	elseif (mode == "disarm") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "no", "yes", "no", "no", "yes", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "no", "no", "no", "no", "no", "yes", "yes", "yes", macro, test)
		end
	elseif (mode == "disarmnocharge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "no", "yes", "no", "no", "yes", "no", "no", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "no", "no", "no", "no", "no", "yes", "yes", "no", macro, test)
		end
	elseif (mode == "target") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "no", "yes", "no", "yes", "no", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "no", "no", "no", "no", "yes", "no", "yes", "yes", macro, test)
		end
	elseif (mode == "targetnocharge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "no", "yes", "no", "yes", "no", "no", "no", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "no", "no", "no", "no", "yes", "no", "yes", "no", macro, test)
		end
	elseif (mode == "charge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "no", "yes", "yes", "no", "no", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "no", "no", "no", "yes", "no", "no", "yes", "yes", macro, test)
		end
	elseif (mode == "targetcharge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "no", "yes", "yes", "yes", "no", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "no", "no", "no", "yes", "yes", "no", "yes", "yes", macro, test)
		end
	elseif (mode == "forcecharge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "no", "yes", "force", "no", "no", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "no", "no", "no", "force", "no", "no", "yes", "yes", macro, test)
		end
	elseif (mode == "targetforcecharge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "no", "yes", "force", "yes", "no", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "no", "no", "no", "force", "yes", "no", "yes", "yes", macro, test)
		end
	elseif (mode == "nocharge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "no", "yes", "no", "no", "no", "no", "no", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "no", "no", "no", "no", "no", "no", "yes", "no", macro, test)
		end
	else
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "no", "yes", "no", "no", "no", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "no", "no", "no", "no", "no", "no", "yes", "yes", macro, test)
		end
	end
end

function Zorlen_WarriorSpam_OffTankingWithRendAndDemoShout(mode, macro, test)
	if not Zorlen_WarriorSpam_isCurrentClassWarrior then
		return
	end
	if (mode == "targetdisarm") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "yes", "yes", "no", "yes", "yes", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "yes", "yes", "no", "no", "yes", "yes", "no", "yes", macro, test)
		end
	elseif (mode == "targetdisarmnocharge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "yes", "yes", "no", "yes", "yes", "no", "no", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "yes", "yes", "no", "no", "yes", "yes", "no", "no", macro, test)
		end
	elseif (mode == "chargedisarm") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "yes", "yes", "yes", "no", "yes", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "yes", "yes", "no", "yes", "no", "yes", "no", "yes", macro, test)
		end
	elseif (mode == "targetchargedisarm") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "yes", "yes", "yes", "yes", "yes", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "yes", "yes", "no", "yes", "yes", "yes", "no", "yes", macro, test)
		end
	elseif (mode == "forcechargedisarm") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "yes", "yes", "force", "no", "yes", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "yes", "yes", "no", "force", "no", "yes", "no", "yes", macro, test)
		end
	elseif (mode == "targetforcechargedisarm") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "yes", "yes", "force", "yes", "yes", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "yes", "yes", "no", "force", "yes", "yes", "no", "yes", macro, test)
		end
	elseif (mode == "disarm") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "yes", "yes", "no", "no", "yes", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "yes", "yes", "no", "no", "no", "yes", "no", "yes", macro, test)
		end
	elseif (mode == "disarmnocharge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "yes", "yes", "no", "no", "yes", "no", "no", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "yes", "yes", "no", "no", "no", "yes", "no", "no", macro, test)
		end
	elseif (mode == "target") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "yes", "yes", "no", "yes", "no", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "yes", "yes", "no", "no", "yes", "no", "no", "yes", macro, test)
		end
	elseif (mode == "targetnocharge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "yes", "yes", "no", "yes", "no", "no", "no", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "yes", "yes", "no", "no", "yes", "no", "no", "no", macro, test)
		end
	elseif (mode == "charge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "yes", "yes", "yes", "no", "no", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "yes", "yes", "no", "yes", "no", "no", "no", "yes", macro, test)
		end
	elseif (mode == "targetcharge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "yes", "yes", "yes", "yes", "no", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "yes", "yes", "no", "yes", "yes", "no", "no", "yes", macro, test)
		end
	elseif (mode == "forcecharge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "yes", "yes", "force", "no", "no", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "yes", "yes", "no", "force", "no", "no", "no", "yes", macro, test)
		end
	elseif (mode == "targetforcecharge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "yes", "yes", "force", "yes", "no", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "yes", "yes", "no", "force", "yes", "no", "no", "yes", macro, test)
		end
	elseif (mode == "nocharge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "yes", "yes", "no", "no", "no", "no", "no", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "yes", "yes", "no", "no", "no", "no", "no", "no", macro, test)
		end
	else
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "yes", "yes", "no", "no", "no", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "yes", "yes", "no", "no", "no", "no", "no", "yes", macro, test)
		end
	end
end

function Zorlen_WarriorSpam_OffTankingWithRend(mode, macro, test)
	if not Zorlen_WarriorSpam_isCurrentClassWarrior then
		return
	end
	if (mode == "targetdisarm") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "no", "yes", "no", "yes", "yes", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "yes", "no", "no", "no", "yes", "yes", "no", "yes", macro, test)
		end
	elseif (mode == "targetdisarmnocharge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "no", "yes", "no", "yes", "yes", "no", "no", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "yes", "no", "no", "no", "yes", "yes", "no", "no", macro, test)
		end
	elseif (mode == "chargedisarm") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "no", "yes", "yes", "no", "yes", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "yes", "no", "no", "yes", "no", "yes", "no", "yes", macro, test)
		end
	elseif (mode == "targetchargedisarm") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "no", "yes", "yes", "yes", "yes", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "yes", "no", "no", "yes", "yes", "yes", "no", "yes", macro, test)
		end
	elseif (mode == "forcechargedisarm") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "no", "yes", "force", "no", "yes", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "yes", "no", "no", "force", "no", "yes", "no", "yes", macro, test)
		end
	elseif (mode == "targetforcechargedisarm") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "no", "yes", "force", "yes", "yes", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "yes", "no", "no", "force", "yes", "yes", "no", "yes", macro, test)
		end
	elseif (mode == "disarm") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "no", "yes", "no", "no", "yes", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "yes", "no", "no", "no", "no", "yes", "no", "yes", macro, test)
		end
	elseif (mode == "disarmnocharge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "no", "yes", "no", "no", "yes", "no", "no", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "yes", "no", "no", "no", "no", "yes", "no", "no", macro, test)
		end
	elseif (mode == "target") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "no", "yes", "no", "yes", "no", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "yes", "no", "no", "no", "yes", "no", "no", "yes", macro, test)
		end
	elseif (mode == "targetnocharge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "no", "yes", "no", "yes", "no", "no", "no", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "yes", "no", "no", "no", "yes", "no", "no", "no", macro, test)
		end
	elseif (mode == "charge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "no", "yes", "yes", "no", "no", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "yes", "no", "no", "yes", "no", "no", "no", "yes", macro, test)
		end
	elseif (mode == "targetcharge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "no", "yes", "yes", "yes", "no", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "yes", "no", "no", "yes", "yes", "no", "no", "yes", macro, test)
		end
	elseif (mode == "forcecharge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "no", "yes", "force", "no", "no", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "yes", "no", "no", "force", "no", "no", "no", "yes", macro, test)
		end
	elseif (mode == "targetforcecharge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "no", "yes", "force", "yes", "no", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "yes", "no", "no", "force", "yes", "no", "no", "yes", macro, test)
		end
	elseif (mode == "nocharge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "no", "yes", "no", "no", "no", "no", "no", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "yes", "no", "no", "no", "no", "no", "no", "no", macro, test)
		end
	else
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "no", "yes", "no", "no", "no", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "yes", "no", "no", "no", "no", "no", "no", "yes", macro, test)
		end
	end
end

function Zorlen_WarriorSpam_OffTankingWithDemoShout(mode, macro, test)
	if not Zorlen_WarriorSpam_isCurrentClassWarrior then
		return
	end
	if (mode == "targetdisarm") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "yes", "yes", "no", "yes", "yes", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "no", "yes", "no", "no", "yes", "yes", "no", "yes", macro, test)
		end
	elseif (mode == "targetdisarmnocharge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "yes", "yes", "no", "yes", "yes", "no", "no", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "no", "yes", "no", "no", "yes", "yes", "no", "no", macro, test)
		end
	elseif (mode == "chargedisarm") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "yes", "yes", "yes", "no", "yes", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "no", "yes", "no", "yes", "no", "yes", "no", "yes", macro, test)
		end
	elseif (mode == "targetchargedisarm") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "yes", "yes", "yes", "yes", "yes", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "no", "yes", "no", "yes", "yes", "yes", "no", "yes", macro, test)
		end
	elseif (mode == "forcechargedisarm") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "yes", "yes", "force", "no", "yes", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "no", "yes", "no", "force", "no", "yes", "no", "yes", macro, test)
		end
	elseif (mode == "targetforcechargedisarm") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "yes", "yes", "force", "yes", "yes", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "no", "yes", "no", "force", "yes", "yes", "no", "yes", macro, test)
		end
	elseif (mode == "disarm") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "yes", "yes", "no", "no", "yes", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "no", "yes", "no", "no", "no", "yes", "no", "yes", macro, test)
		end
	elseif (mode == "disarmnocharge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "yes", "yes", "no", "no", "yes", "no", "no", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "no", "yes", "no", "no", "no", "yes", "no", "no", macro, test)
		end
	elseif (mode == "target") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "yes", "yes", "no", "yes", "no", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "no", "yes", "no", "no", "yes", "no", "no", "yes", macro, test)
		end
	elseif (mode == "targetnocharge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "yes", "yes", "no", "yes", "no", "no", "no", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "no", "yes", "no", "no", "yes", "no", "no", "no", macro, test)
		end
	elseif (mode == "charge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "yes", "yes", "yes", "no", "no", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "no", "yes", "no", "yes", "no", "no", "no", "yes", macro, test)
		end
	elseif (mode == "targetcharge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "yes", "yes", "yes", "yes", "no", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "no", "yes", "no", "yes", "yes", "no", "no", "yes", macro, test)
		end
	elseif (mode == "forcecharge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "yes", "yes", "force", "no", "no", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "no", "yes", "no", "force", "no", "no", "no", "yes", macro, test)
		end
	elseif (mode == "targetforcecharge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "yes", "yes", "force", "yes", "no", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "no", "yes", "no", "force", "yes", "no", "no", "yes", macro, test)
		end
	elseif (mode == "nocharge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "yes", "yes", "no", "no", "no", "no", "no", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "no", "yes", "no", "no", "no", "no", "no", "no", macro, test)
		end
	else
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "yes", "yes", "no", "no", "no", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "no", "yes", "no", "no", "no", "no", "no", "yes", macro, test)
		end
	end
end

function Zorlen_WarriorSpam_OffTanking(mode, macro, test)
	if not Zorlen_WarriorSpam_isCurrentClassWarrior then
		return
	end
	if (mode == "targetdisarm") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "no", "yes", "no", "yes", "yes", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "no", "no", "no", "no", "yes", "yes", "no", "yes", macro, test)
		end
	elseif (mode == "targetdisarmnocharge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "no", "yes", "no", "yes", "yes", "no", "no", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "no", "no", "no", "no", "yes", "yes", "no", "no", macro, test)
		end
	elseif (mode == "chargedisarm") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "no", "yes", "yes", "no", "yes", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "no", "no", "no", "yes", "no", "yes", "no", "yes", macro, test)
		end
	elseif (mode == "targetchargedisarm") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "no", "yes", "yes", "yes", "yes", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "no", "no", "no", "yes", "yes", "yes", "no", "yes", macro, test)
		end
	elseif (mode == "forcechargedisarm") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "no", "yes", "force", "no", "yes", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "no", "no", "no", "force", "no", "yes", "no", "yes", macro, test)
		end
	elseif (mode == "targetforcechargedisarm") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "no", "yes", "force", "yes", "yes", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "no", "no", "no", "force", "yes", "yes", "no", "yes", macro, test)
		end
	elseif (mode == "disarm") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "no", "yes", "no", "no", "yes", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "no", "no", "no", "no", "no", "yes", "no", "yes", macro, test)
		end
	elseif (mode == "disarmnocharge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "no", "yes", "no", "no", "yes", "no", "no", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "no", "no", "no", "no", "no", "yes", "no", "no", macro, test)
		end
	elseif (mode == "target") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "no", "yes", "no", "yes", "no", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "no", "no", "no", "no", "yes", "no", "no", "yes", macro, test)
		end
	elseif (mode == "targetnocharge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "no", "yes", "no", "yes", "no", "no", "no", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "no", "no", "no", "no", "yes", "no", "no", "no", macro, test)
		end
	elseif (mode == "charge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "no", "yes", "yes", "no", "no", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "no", "no", "no", "yes", "no", "no", "no", "yes", macro, test)
		end
	elseif (mode == "targetcharge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "no", "yes", "yes", "yes", "no", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "no", "no", "no", "yes", "yes", "no", "no", "yes", macro, test)
		end
	elseif (mode == "forcecharge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "no", "yes", "force", "no", "no", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "no", "no", "no", "force", "no", "no", "no", "yes", macro, test)
		end
	elseif (mode == "targetforcecharge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "no", "yes", "force", "yes", "no", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "no", "no", "no", "force", "yes", "no", "no", "yes", macro, test)
		end
	elseif (mode == "nocharge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "no", "yes", "no", "no", "no", "no", "no", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "no", "no", "no", "no", "no", "no", "no", "no", macro, test)
		end
	else
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "no", "yes", "no", "no", "no", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "yes", "no", "no", "no", "no", "no", "no", "no", "yes", macro, test)
		end
	end
end





function Zorlen_WarriorSpam_HateBuilder(mode, macro, test)
	if not Zorlen_WarriorSpam_isCurrentClassWarrior then
		return
	end
	if (mode == "targetdisarm") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "no", "yes", "no", "yes", "yes", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("hate", "yes", "no", "no", "no", "no", "yes", "no", "yes", "yes", macro, test)
		end
	elseif (mode == "targetdisarmnocharge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "no", "yes", "no", "yes", "yes", "no", "no", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("hate", "yes", "no", "no", "no", "no", "yes", "no", "yes", "no", macro, test)
		end
	elseif (mode == "chargedisarm") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "no", "yes", "yes", "no", "yes", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("hate", "yes", "no", "no", "no", "yes", "no", "no", "yes", "yes", macro, test)
		end
	elseif (mode == "targetchargedisarm") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "no", "yes", "yes", "yes", "yes", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("hate", "yes", "no", "no", "no", "yes", "yes", "no", "yes", "yes", macro, test)
		end
	elseif (mode == "forcechargedisarm") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "no", "yes", "force", "no", "yes", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("hate", "yes", "no", "no", "no", "force", "no", "no", "yes", "yes", macro, test)
		end
	elseif (mode == "targetforcechargedisarm") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "no", "yes", "force", "yes", "yes", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("hate", "yes", "no", "no", "no", "force", "yes", "no", "yes", "yes", macro, test)
		end
	elseif (mode == "disarm") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "no", "yes", "no", "no", "yes", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("hate", "yes", "no", "no", "no", "no", "no", "no", "yes", "yes", macro, test)
		end
	elseif (mode == "disarmnocharge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "no", "yes", "no", "no", "yes", "no", "no", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("hate", "yes", "no", "no", "no", "no", "no", "no", "yes", "no", macro, test)
		end
	elseif (mode == "target") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "no", "yes", "no", "yes", "no", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("hate", "yes", "no", "no", "no", "no", "yes", "no", "yes", "yes", macro, test)
		end
	elseif (mode == "targetnocharge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "no", "yes", "no", "yes", "no", "no", "no", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("hate", "yes", "no", "no", "no", "no", "yes", "no", "yes", "no", macro, test)
		end
	elseif (mode == "charge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "no", "yes", "yes", "no", "no", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("hate", "yes", "no", "no", "no", "yes", "no", "no", "yes", "yes", macro, test)
		end
	elseif (mode == "targetcharge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "no", "yes", "yes", "yes", "no", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("hate", "yes", "no", "no", "no", "yes", "yes", "no", "yes", "yes", macro, test)
		end
	elseif (mode == "forcecharge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "no", "yes", "force", "no", "no", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("hate", "yes", "no", "no", "no", "force", "no", "no", "yes", "yes", macro, test)
		end
	elseif (mode == "targetforcecharge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "no", "yes", "force", "yes", "no", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("hate", "yes", "no", "no", "no", "force", "yes", "no", "yes", "yes", macro, test)
		end
	elseif (mode == "nocharge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "no", "yes", "no", "no", "no", "no", "no", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("hate", "yes", "no", "no", "no", "no", "no", "no", "yes", "no", macro, test)
		end
	else
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "no", "yes", "no", "no", "no", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("hate", "yes", "no", "no", "no", "no", "no", "no", "yes", "yes", macro, test)
		end
	end
end





function Zorlen_WarriorSpam_OffTankingHateBuilder(mode, macro, test)
	if not Zorlen_WarriorSpam_isCurrentClassWarrior then
		return
	end
	if (mode == "targetdisarm") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "no", "yes", "no", "yes", "yes", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("hate", "yes", "no", "no", "no", "no", "yes", "no", "no", "yes", macro, test)
		end
	elseif (mode == "targetdisarmnocharge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "no", "yes", "no", "yes", "yes", "no", "no", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("hate", "yes", "no", "no", "no", "no", "yes", "no", "no", "no", macro, test)
		end
	elseif (mode == "chargedisarm") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "no", "yes", "yes", "no", "yes", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("hate", "yes", "no", "no", "no", "yes", "no", "no", "no", "yes", macro, test)
		end
	elseif (mode == "targetchargedisarm") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "no", "yes", "yes", "yes", "yes", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("hate", "yes", "no", "no", "no", "yes", "yes", "no", "no", "yes", macro, test)
		end
	elseif (mode == "forcechargedisarm") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "no", "yes", "force", "no", "yes", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("hate", "yes", "no", "no", "no", "force", "no", "no", "no", "yes", macro, test)
		end
	elseif (mode == "targetforcechargedisarm") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "no", "yes", "force", "yes", "yes", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("hate", "yes", "no", "no", "no", "force", "yes", "no", "no", "yes", macro, test)
		end
	elseif (mode == "disarm") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "no", "yes", "no", "no", "yes", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("hate", "yes", "no", "no", "no", "no", "no", "no", "no", "yes", macro, test)
		end
	elseif (mode == "disarmnocharge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "no", "yes", "no", "no", "yes", "no", "no", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("hate", "yes", "no", "no", "no", "no", "no", "no", "no", "no", macro, test)
		end
	elseif (mode == "target") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "no", "yes", "no", "yes", "no", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("hate", "yes", "no", "no", "no", "no", "yes", "no", "no", "yes", macro, test)
		end
	elseif (mode == "targetnocharge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "no", "yes", "no", "yes", "no", "no", "no", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("hate", "yes", "no", "no", "no", "no", "yes", "no", "no", "no", macro, test)
		end
	elseif (mode == "charge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "no", "yes", "yes", "no", "no", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("hate", "yes", "no", "no", "no", "yes", "no", "no", "no", "yes", macro, test)
		end
	elseif (mode == "targetcharge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "no", "yes", "yes", "yes", "no", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("hate", "yes", "no", "no", "no", "yes", "yes", "no", "no", "yes", macro, test)
		end
	elseif (mode == "forcecharge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "no", "yes", "force", "no", "no", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("hate", "yes", "no", "no", "no", "force", "no", "no", "no", "yes", macro, test)
		end
	elseif (mode == "targetforcecharge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "no", "yes", "force", "yes", "no", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("hate", "yes", "no", "no", "no", "force", "yes", "no", "no", "yes", macro, test)
		end
	elseif (mode == "nocharge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "no", "yes", "no", "no", "no", "no", "no", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("hate", "yes", "no", "no", "no", "no", "no", "no", "no", "no", macro, test)
		end
	else
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "no", "yes", "no", "no", "no", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("hate", "yes", "no", "no", "no", "no", "no", "no", "no", "yes", macro, test)
		end
	end
end









function Zorlen_WarriorSpam_WithRendAndDemoShout(mode, macro, test)
	if not Zorlen_WarriorSpam_isCurrentClassWarrior then
		return
	end
	if (mode == "targetdisarm") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "yes", "yes", "no", "yes", "yes", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "yes", "no", "no", "yes", "yes", "no", "yes", macro, test)
		end
	elseif (mode == "targetdisarmnocharge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "yes", "yes", "no", "yes", "yes", "no", "no", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "yes", "no", "no", "yes", "yes", "no", "no", macro, test)
		end
	elseif (mode == "chargedisarm") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "yes", "yes", "yes", "no", "yes", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "yes", "no", "yes", "no", "yes", "no", "yes", macro, test)
		end
	elseif (mode == "targetchargedisarm") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "yes", "yes", "yes", "yes", "yes", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "yes", "no", "yes", "yes", "yes", "no", "yes", macro, test)
		end
	elseif (mode == "forcechargedisarm") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "yes", "yes", "force", "no", "yes", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "yes", "no", "force", "no", "yes", "no", "yes", macro, test)
		end
	elseif (mode == "targetforcechargedisarm") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "yes", "yes", "force", "yes", "yes", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "yes", "no", "force", "yes", "yes", "no", "yes", macro, test)
		end
	elseif (mode == "disarm") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "yes", "yes", "no", "no", "yes", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "yes", "no", "no", "no", "yes", "no", "yes", macro, test)
		end
	elseif (mode == "disarmnocharge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "yes", "yes", "no", "no", "yes", "no", "no", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "yes", "no", "no", "no", "yes", "no", "no", macro, test)
		end
	elseif (mode == "target") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "yes", "yes", "no", "yes", "no", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "yes", "no", "no", "yes", "no", "no", "yes", macro, test)
		end
	elseif (mode == "targetnocharge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "yes", "yes", "no", "yes", "no", "no", "no", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "yes", "no", "no", "yes", "no", "no", "no", macro, test)
		end
	elseif (mode == "charge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "yes", "yes", "yes", "no", "no", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "yes", "no", "yes", "no", "no", "no", "yes", macro, test)
		end
	elseif (mode == "targetcharge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "yes", "yes", "yes", "yes", "no", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "yes", "no", "yes", "yes", "no", "no", "yes", macro, test)
		end
	elseif (mode == "forcecharge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "yes", "yes", "force", "no", "no", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "yes", "no", "force", "no", "no", "no", "yes", macro, test)
		end
	elseif (mode == "targetforcecharge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "yes", "yes", "force", "yes", "no", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "yes", "no", "force", "yes", "no", "no", "yes", macro, test)
		end
	elseif (mode == "nocharge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "yes", "yes", "no", "no", "no", "no", "no", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "yes", "no", "no", "no", "no", "no", "no", macro, test)
		end
	else
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "yes", "yes", "no", "no", "no", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "yes", "no", "no", "no", "no", "no", "yes", macro, test)
		end
	end
end

function Zorlen_WarriorSpam_WithRend(mode, macro, test)
	if not Zorlen_WarriorSpam_isCurrentClassWarrior then
		return
	end
	if (mode == "targetdisarm") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "no", "yes", "no", "yes", "yes", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "no", "no", "no", "yes", "yes", "no", "yes", macro, test)
		end
	elseif (mode == "targetdisarmnocharge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "no", "yes", "no", "yes", "yes", "no", "no", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "no", "no", "no", "yes", "yes", "no", "no", macro, test)
		end
	elseif (mode == "chargedisarm") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "no", "yes", "yes", "no", "yes", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "no", "no", "yes", "no", "yes", "no", "yes", macro, test)
		end
	elseif (mode == "targetchargedisarm") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "no", "yes", "yes", "yes", "yes", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "no", "no", "yes", "yes", "yes", "no", "yes", macro, test)
		end
	elseif (mode == "forcechargedisarm") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "no", "yes", "force", "no", "yes", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "no", "no", "force", "no", "yes", "no", "yes", macro, test)
		end
	elseif (mode == "targetforcechargedisarm") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "no", "yes", "force", "yes", "yes", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "no", "no", "force", "yes", "yes", "no", "yes", macro, test)
		end
	elseif (mode == "disarm") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "no", "yes", "no", "no", "yes", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "no", "no", "no", "no", "yes", "no", "yes", macro, test)
		end
	elseif (mode == "disarmnocharge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "no", "yes", "no", "no", "yes", "no", "no", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "no", "no", "no", "no", "yes", "no", "no", macro, test)
		end
	elseif (mode == "target") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "no", "yes", "no", "yes", "no", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "no", "no", "no", "yes", "no", "no", "yes", macro, test)
		end
	elseif (mode == "targetnocharge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "no", "yes", "no", "yes", "no", "no", "no", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "no", "no", "no", "yes", "no", "no", "no", macro, test)
		end
	elseif (mode == "charge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "no", "yes", "yes", "no", "no", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "no", "no", "yes", "no", "no", "no", "yes", macro, test)
		end
	elseif (mode == "targetcharge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "no", "yes", "yes", "yes", "no", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "no", "no", "yes", "yes", "no", "no", "yes", macro, test)
		end
	elseif (mode == "forcecharge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "no", "yes", "force", "no", "no", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "no", "no", "force", "no", "no", "no", "yes", macro, test)
		end
	elseif (mode == "targetforcecharge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "no", "yes", "force", "yes", "no", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "no", "no", "force", "yes", "no", "no", "yes", macro, test)
		end
	elseif (mode == "nocharge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "no", "yes", "no", "no", "no", "no", "no", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "no", "no", "no", "no", "no", "no", "no", macro, test)
		end
	else
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "no", "yes", "no", "no", "no", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "yes", "no", "no", "no", "no", "no", "no", "yes", macro, test)
		end
	end
end

function Zorlen_WarriorSpam_WithDemoShout(mode, macro, test)
	if not Zorlen_WarriorSpam_isCurrentClassWarrior then
		return
	end
	if (mode == "targetdisarm") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "yes", "yes", "no", "yes", "yes", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "yes", "no", "no", "yes", "yes", "no", "yes", macro, test)
		end
	elseif (mode == "targetdisarmnocharge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "yes", "yes", "no", "yes", "yes", "no", "no", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "yes", "no", "no", "yes", "yes", "no", "no", macro, test)
		end
	elseif (mode == "chargedisarm") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "yes", "yes", "yes", "no", "yes", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "yes", "no", "yes", "no", "yes", "no", "yes", macro, test)
		end
	elseif (mode == "targetchargedisarm") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "yes", "yes", "yes", "yes", "yes", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "yes", "no", "yes", "yes", "yes", "no", "yes", macro, test)
		end
	elseif (mode == "forcechargedisarm") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "yes", "yes", "force", "no", "yes", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "yes", "no", "force", "no", "yes", "no", "yes", macro, test)
		end
	elseif (mode == "targetforcechargedisarm") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "yes", "yes", "force", "yes", "yes", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "yes", "no", "force", "yes", "yes", "no", "yes", macro, test)
		end
	elseif (mode == "disarm") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "yes", "yes", "no", "no", "yes", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "yes", "no", "no", "no", "yes", "no", "yes", macro, test)
		end
	elseif (mode == "disarmnocharge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "yes", "yes", "no", "no", "yes", "no", "no", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "yes", "no", "no", "no", "yes", "no", "no", macro, test)
		end
	elseif (mode == "target") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "yes", "yes", "no", "yes", "no", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "yes", "no", "no", "yes", "no", "no", "yes", macro, test)
		end
	elseif (mode == "targetnocharge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "yes", "yes", "no", "yes", "no", "no", "no", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "yes", "no", "no", "yes", "no", "no", "no", macro, test)
		end
	elseif (mode == "charge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "yes", "yes", "yes", "no", "no", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "yes", "no", "yes", "no", "no", "no", "yes", macro, test)
		end
	elseif (mode == "targetcharge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "yes", "yes", "yes", "yes", "no", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "yes", "no", "yes", "yes", "no", "no", "yes", macro, test)
		end
	elseif (mode == "forcecharge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "yes", "yes", "force", "no", "no", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "yes", "no", "force", "no", "no", "no", "yes", macro, test)
		end
	elseif (mode == "targetforcecharge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "yes", "yes", "force", "yes", "no", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "yes", "no", "force", "yes", "no", "no", "yes", macro, test)
		end
	elseif (mode == "nocharge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "yes", "yes", "no", "no", "no", "no", "no", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "yes", "no", "no", "no", "no", "no", "no", macro, test)
		end
	else
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "yes", "yes", "no", "no", "no", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "yes", "no", "no", "no", "no", "no", "yes", macro, test)
		end
	end
end

function Zorlen_WarriorSpam(mode, macro, test)
	if not Zorlen_WarriorSpam_isCurrentClassWarrior then
		return
	end
	if (mode == "targetdisarm") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "no", "yes", "no", "yes", "yes", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "no", "no", "no", "yes", "yes", "no", "yes", macro, test)
		end
	elseif (mode == "targetdisarmnocharge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "no", "yes", "no", "yes", "yes", "no", "no", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "no", "no", "no", "yes", "yes", "no", "no", macro, test)
		end
	elseif (mode == "chargedisarm") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "no", "yes", "yes", "no", "yes", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "no", "no", "yes", "no", "yes", "no", "yes", macro, test)
		end
	elseif (mode == "targetchargedisarm") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "no", "yes", "yes", "yes", "yes", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "no", "no", "yes", "yes", "yes", "no", "yes", macro, test)
		end
	elseif (mode == "forcechargedisarm") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "no", "yes", "force", "no", "yes", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "no", "no", "force", "no", "yes", "no", "yes", macro, test)
		end
	elseif (mode == "targetforcechargedisarm") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "no", "yes", "force", "yes", "yes", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "no", "no", "force", "yes", "yes", "no", "yes", macro, test)
		end
	elseif (mode == "disarm") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "no", "yes", "no", "no", "yes", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "no", "no", "no", "no", "yes", "no", "yes", macro, test)
		end
	elseif (mode == "disarmnocharge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "no", "yes", "no", "no", "yes", "no", "no", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "no", "no", "no", "no", "yes", "no", "no", macro, test)
		end
	elseif (mode == "target") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "no", "yes", "no", "yes", "no", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "no", "no", "no", "yes", "no", "no", "yes", macro, test)
		end
	elseif (mode == "targetnocharge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "no", "yes", "no", "yes", "no", "no", "no", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "no", "no", "no", "yes", "no", "no", "no", macro, test)
		end
	elseif (mode == "charge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "no", "yes", "yes", "no", "no", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "no", "no", "yes", "no", "no", "no", "yes", macro, test)
		end
	elseif (mode == "targetcharge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "no", "yes", "yes", "yes", "no", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "no", "no", "yes", "yes", "no", "no", "yes", macro, test)
		end
	elseif (mode == "forcecharge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "no", "yes", "force", "no", "no", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "no", "no", "force", "no", "no", "no", "yes", macro, test)
		end
	elseif (mode == "targetforcecharge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "no", "yes", "force", "yes", "no", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "no", "no", "force", "yes", "no", "no", "yes", macro, test)
		end
	elseif (mode == "nocharge") then
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "no", "yes", "no", "no", "no", "no", "no", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "no", "no", "no", "no", "no", "no", "no", macro, test)
		end
	else
		if not Zorlen_TargetIsEnemyMob() then
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "no", "yes", "no", "no", "no", "no", "yes", macro, test)
		else
			Zorlen_WarriorSpam_UseSelectedConfiguration("forward", "no", "no", "no", "no", "no", "no", "no", "no", "yes", macro, test)
		end
	end
end






















function Zorlen_WarriorSpam_UseSelectedConfiguration(mode, tanking, rend, demo, pvp, charge, targ, disarm, taunt, aggrocharge, macro, test)
	if not Zorlen_WarriorSpam_isCurrentClassWarrior then
		return
	end
	if not test then
		Zorlen_WarriorSpam_TestButtons()
		Zorlen_CancelSelfBuff("Spell_Holy_GreaterBlessingofWisdom")
		Zorlen_CancelSelfBuff("Spell_Holy_SealOfWisdom")
		Zorlen_RegisterIfWasHamstring()
	end
	local ZWS_END = nil;
	local ActiveEnemy = nil
	local Enemy = Zorlen_TargetIsEnemy()
	local ImmobilizingEffect = nil;
	local IncapacitateEffect = nil;
	local StunEffect = nil;
	local SlowEffect = nil;
	local FearEffect = nil;
	if test and not Enemy then
		Zorlen_WarriorSpam_UpdateIcons(Zorlen_WarriorSpam_IconIndex_Idle, macro, test)
		return
	end
	local CID = nil
	if Zorlen_Button[LOCALIZATION_ZORLEN.Rend..".Any"] then
		if IsActionInRange(Zorlen_Button[LOCALIZATION_ZORLEN.Rend..".Any"]) ~= 0 then
			CID = 1
		end
	else
		CID = CheckInteractDistance("target", 3)
	end
	if not test and (tanking == "yes") then
		Zorlen_CancelSelfBuff("Spell_Holy_GreaterBlessingofSalvation")
		Zorlen_CancelSelfBuff("Spell_Holy_SealOfSalvation")
	end
	if not test then
		if
			Zorlen_checkDebuffByName(LOCALIZATION_ZORLEN.Fear, "player") --Fear
			or
			Zorlen_checkDebuffByName(LOCALIZATION_ZORLEN.HowlOfTerror, "player") --Fear: Howl of Terror
			or
			Zorlen_checkDebuffByName(LOCALIZATION_ZORLEN.PsychicScream, "player") --Fear: Psychic Scream
			then
				FearEffect = 1;
				IncapacitateEffect = 1;
		elseif
			-- Rogue Stun effects
			Zorlen_checkDebuffByName(LOCALIZATION_ZORLEN.KidneyShot, "player")
			or
			Zorlen_checkDebuffByName(LOCALIZATION_ZORLEN.CheapShot, "player")
			or
			-- Warrior Stun Effect - to short to bother with?
			-- Warstomp - short stun not worth it?
			--Zorlen_checkDebuff("Ability_WarStomp", "player") or
			-- Paladin Stun Effect
			Zorlen_checkDebuffByName(LOCALIZATION_ZORLEN.HammerOfJustice, "player")
			then
				StunEffect = 1;
				IncapacitateEffect = 1;
		elseif
			Zorlen_checkDebuffByName(LOCALIZATION_ZORLEN.Polymorph, "player") --Polymorph
			or
			Zorlen_checkDebuff("Spell_Nature_Sleep", "player") --Sleep: Hibernate
			or
			Zorlen_checkDebuffByName(LOCALIZATION_ZORLEN.Sap, "player") --Sap
			or
			Zorlen_checkDebuffByName(LOCALIZATION_ZORLEN.Seduction, "player") --Succubus Seduction
			or
			Zorlen_checkDebuffByName(LOCALIZATION_ZORLEN.ScatterShot, "player") --Scatter Shot
			or
			Zorlen_checkDebuffByName(LOCALIZATION_ZORLEN.FreezingTrap, "player") --Freezing Trap
			or
			Zorlen_checkDebuffByName(LOCALIZATION_ZORLEN.Banish, "player") --Banish
			or
			Zorlen_checkDebuffByName(LOCALIZATION_ZORLEN.MindControl, "player") --Mind Control
			then
				IncapacitateEffect = 1;
		elseif
			-- Mage Immobilizing effect
			Zorlen_checkDebuffByName(LOCALIZATION_ZORLEN.FrostNova, "player")
			or
			-- Druid Root
			Zorlen_checkDebuff("Spell_Nature_StrangleVines", "player")
			then
				ImmobilizingEffect = 1;
		elseif
			-- Mage Slow effects
			Zorlen_checkDebuff("Spell_Frost_FrostArmor02", "player")
			or
			Zorlen_checkDebuff("Spell_Frost_FrostBolt02", "player")
			or
			Zorlen_checkDebuff("Spell_Frost_Glacier", "player")
			or
			-- Rogue Slow effect
			Zorlen_checkDebuffByName(LOCALIZATION_ZORLEN.CripplingPoison, "player")
			or
			-- Warrior Slow/Immobilizing Effect
			Zorlen_checkDebuff("Ability_ShockWave", "player")
			or
			-- Hunter Slow/Immobilizing Effect
			Zorlen_checkDebuff("Ability_Rogue_Trip", "player")
			or
			Zorlen_checkDebuff("Spell_Frost_Stun", "player")
			or
			Zorlen_checkDebuff("Spell_Frost_FreezingBreath", "player")
			or
			-- Shaman
			Zorlen_checkDebuff("Spell_Frost_FrostBrand", "player")
			or
			Zorlen_checkDebuff("Spell_Frost_FrostShock", "player")
			or
			-- Trinket/Gadget Stun/Slow/Immobilizing effects
			Zorlen_checkDebuff("Ability_Ensnare", "player")
			or
			-- Hunter Stun Effect
			Zorlen_checkDebuff("Spell_Frost_Stun", "player")
			then
				SlowEffect = 1;
		end
	end
	if (IncapacitateEffect) and isBerserkerStance() and castBerserkerRage(test) then
		--castBerserkerRage()
		Zorlen_WarriorSpam_UpdateIcons(Zorlen_WarriorSpam_IconIndex_BerserkerRage, macro, test)
		ZWS_END = 1;
	elseif (FearEffect) and castDeathWish(test) then
		--castDeathWish()
		Zorlen_WarriorSpam_UpdateIcons(Zorlen_WarriorSpam_IconIndex_DeathWish, macro, test)
		ZWS_END = 1;
	elseif not test and (ImmobilizingEffect or StunEffect or SlowEffect) and ((UnitFactionGroup("player") == "Alliance" and Zorlen_useTrinketByItemID(18854)) or (UnitFactionGroup("player") == "Horde" and Zorlen_useTrinketByItemID(18834))) then
		--Zorlen_useTrinketByName("Insignia of the Alliance")
		--Zorlen_useTrinketByName("Insignia of the Horde")
	end
	if Zorlen_TargetIsActiveEnemy() then
		ActiveEnemy = 1;
		if Zorlen_WarriorSpam_FirstEnemyTarget then
			ZorlenWarriorSpamFrame.FirstEnemyTargetDelay_timer = nil;
			Zorlen_WarriorSpam_FirstEnemyTarget = nil;
		end
	end
	if Zorlen_WarriorSpam_FirstEnemyTarget then
		if Zorlen_WarriorSpam_HealthWhenCombatStarted > UnitHealth("player") then
			ZorlenWarriorSpamFrame.FirstEnemyTargetDelay_timer = nil;
			Zorlen_WarriorSpam_FirstEnemyTarget = nil;
		end
	end
	if IncapacitateEffect then
		if test and ActiveEnemy and CID and castAttack(test) then
			Zorlen_WarriorSpam_UpdateIcons(Zorlen_WarriorSpam_IconIndex_Attack, macro, test)
			return
		end
		Zorlen_WarriorSpam_UpdateIcons(Zorlen_WarriorSpam_IconIndex_Idle, macro, test)
		return
	end
	if ImmobilizingEffect and not CID and castDefensiveStance(test) then
		if not test and tanking ~= "yes" and not Zorlen_WarriorSpam_SwapFromBerserkerToDoAction and not Zorlen_WarriorSpam_SwapFromDefensiveToDoAction and not Zorlen_WarriorSpam_SwapFromBattleToDoAction then
			if isBattleStance() then
				Zorlen_WarriorSpam_SwapFromBattleToDoAction = 1;
			else
				Zorlen_WarriorSpam_SwapFromBerserkerToDoAction = 1;
			end
		end
		--castDefensiveStance()
		Zorlen_WarriorSpam_UpdateIcons(Zorlen_WarriorSpam_IconIndex_DefensiveStance, macro, test)
		ZWS_END = 1;
	end
	if ((Zorlen_Combat and not ActiveEnemy) or ((targ == "no") and not Zorlen_TargetIsEnemy())) and not IsAltKeyDown() then
		if not test and Zorlen_Combat and Zorlen_TargetIsEnemy() then
			stopAttack()
			SpellStopCasting()
		end
		if not test and not Zorlen_WarriorSpam_FirstEnemyTarget or Zorlen_isNoDamageCC() then
			if not ZorlenWarriorSpamConfig[ZPN][TARGETINGOFF] then
				Zorlen_TargetActiveEnemyOnly(ZorlenWarriorSpamConfig[ZPN][CYCLES])
			end
		end
		if not ZWS_END then
			if castBattleShout(test) then
				if macro then
					Zorlen_WarriorSpam_UpdateIcons(Zorlen_WarriorSpam_IconIndex_BattleShout, macro, test)
					return
				end
			end
		end
		if test and ActiveEnemy and CID and castAttack(test) then
			Zorlen_WarriorSpam_UpdateIcons(Zorlen_WarriorSpam_IconIndex_Attack, macro, test)
			return
		end
		Zorlen_WarriorSpam_UpdateIcons(Zorlen_WarriorSpam_IconIndex_Idle, macro, test)
		return
	elseif ((targ == "yes") or IsAltKeyDown()) and not Zorlen_TargetIsEnemy() then
		if not test and not ZorlenWarriorSpamConfig[ZPN][TARGETINGOFF] then
			if (ZorlenWarriorSpamConfig[ZPN][CYCLES] == 1) then
				Zorlen_TargetFirstEnemy()
			else
				Zorlen_TargetEnemy(ZorlenWarriorSpamConfig[ZPN][CYCLES])
			end
		end
		if not ZWS_END then
			if castBattleShout(test) then
				if macro then
					Zorlen_WarriorSpam_UpdateIcons(Zorlen_WarriorSpam_IconIndex_BattleShout, macro, test)
					return
				end
			end
		end
		if test and ActiveEnemy and CID and castAttack(test) then
			Zorlen_WarriorSpam_UpdateIcons(Zorlen_WarriorSpam_IconIndex_Attack, macro, test)
			return
		end
		Zorlen_WarriorSpam_UpdateIcons(Zorlen_WarriorSpam_IconIndex_Idle, macro, test)
		return
	end
	local PlayerMana = UnitMana("player")
	if ActiveEnemy then
		if CID then
			if Zorlen_Button[LOCALIZATION_ZORLEN.HeroicStrike] then
				if (tanking == "yes") then
					if Zorlen_isShieldEquipped() then
						if (PlayerMana >= (5 + Zorlen_HeroicStrikeRageCost() + Zorlen_SunderArmorRageCost() + Zorlen_ShieldSlamRageCost())) then
							if castHeroicStrike(test) then
								if test then
									Zorlen_WarriorSpam_UpdateIcons(Zorlen_WarriorSpam_IconIndex_HeroicStrike, macro, test)
									return
								end
							end
						end
					elseif (PlayerMana >= (5 + Zorlen_HeroicStrikeRageCost() + Zorlen_SunderArmorRageCost())) then
						if castHeroicStrike(test) then
							if test then
								Zorlen_WarriorSpam_UpdateIcons(Zorlen_WarriorSpam_IconIndex_HeroicStrike, macro, test)
								return
							end
						end
					end
				elseif isDefensiveStance() then
					if Zorlen_isShieldEquipped() then
						if (PlayerMana >= (5 + Zorlen_HeroicStrikeRageCost() + Zorlen_MortalStrikeRageCost() + Zorlen_BloodthirstRageCost() + Zorlen_ShieldSlamRageCost())) then
							if castHeroicStrike(test) then
								if test then
									Zorlen_WarriorSpam_UpdateIcons(Zorlen_WarriorSpam_IconIndex_HeroicStrike, macro, test)
									return
								end
							end
						end
					elseif (PlayerMana >= (5 + Zorlen_HeroicStrikeRageCost() + Zorlen_MortalStrikeRageCost() + Zorlen_BloodthirstRageCost())) then
						if castHeroicStrike(test) then
							if test then
								Zorlen_WarriorSpam_UpdateIcons(Zorlen_WarriorSpam_IconIndex_HeroicStrike, macro, test)
								return
							end
						end
					end
				elseif Zorlen_isShieldEquipped() then
					if (PlayerMana >= (5 + Zorlen_HeroicStrikeRageCost() + Zorlen_MortalStrikeRageCost() + Zorlen_BloodthirstRageCost() + Zorlen_ShieldSlamRageCost() + Zorlen_ExecuteRageCost())) then
						if castHeroicStrike(test) then
							if test then
								Zorlen_WarriorSpam_UpdateIcons(Zorlen_WarriorSpam_IconIndex_HeroicStrike, macro, test)
								return
							end
						end
					end
				elseif (PlayerMana >= (5 + Zorlen_HeroicStrikeRageCost() + Zorlen_MortalStrikeRageCost() + Zorlen_BloodthirstRageCost() + Zorlen_ExecuteRageCost())) then
					if castHeroicStrike(test) then
						if test then
							Zorlen_WarriorSpam_UpdateIcons(Zorlen_WarriorSpam_IconIndex_HeroicStrike, macro, test)
							return
						end
					end
				end
			end
			if not test then
				castAttack()
			end
		end
	end
	if ZWS_END then
		return
	elseif ImmobilizingEffect and not CID then
		if castBattleShout(test) then
			if macro then
				Zorlen_WarriorSpam_UpdateIcons(Zorlen_WarriorSpam_IconIndex_BattleShout, macro, test)
				return
			end
		end
		if test and ActiveEnemy and CID and castAttack(test) then
			Zorlen_WarriorSpam_UpdateIcons(Zorlen_WarriorSpam_IconIndex_Attack, macro, test)
			return
		end
		Zorlen_WarriorSpam_UpdateIcons(Zorlen_WarriorSpam_IconIndex_Idle, macro, test)
		return
	end
	local TIETE = Zorlen_TargetIsEnemyTargetingEnemy()
	local TMRP = Zorlen_TacticalMasteryRagePoints()
	local BRRP = Zorlen_BerserkerRageRagePoints()
	local PlayerHealthFraction = UnitHealth("player") / UnitHealthMax("player")
	local Classification = UnitClassification("target") or ""
	local boss = string.find(string.lower(Classification), "boss")
	local hamstrung = isHamstring()
	if Zorlen_Button[LOCALIZATION_ZORLEN.ShieldBash] and pvp ~= "yes" and TIETE and castShieldBash(test) then
		--castShieldBash()
		Zorlen_WarriorSpam_UpdateIcons(Zorlen_WarriorSpam_IconIndex_ShieldBash, macro, test)
	elseif Zorlen_Button[LOCALIZATION_ZORLEN.Pummel] and pvp ~= "yes" and TIETE and castPummel(test) then
		--castPummel()
		Zorlen_WarriorSpam_UpdateIcons(Zorlen_WarriorSpam_IconIndex_Pummel, macro, test)
	elseif Zorlen_Button[LOCALIZATION_ZORLEN.ConcussionBlow] and pvp ~= "yes" and TIETE and castConcussionBlow(test) then
		--castConcussionBlow()
		Zorlen_WarriorSpam_UpdateIcons(Zorlen_WarriorSpam_IconIndex_ConcussionBlow, macro, test)
	elseif
		Zorlen_Button[LOCALIZATION_ZORLEN.BerserkerRage] and Zorlen_Button[LOCALIZATION_ZORLEN.ConcussionBlow] and pvp ~= "yes" and TIETE and CID and isBerserkerStance() and PlayerMana < 15 and Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN.ConcussionBlow) and (BRRP + PlayerMana) >= 15 and castBerserkerRage(test)
		then
		--castBerserkerRage()
		Zorlen_WarriorSpam_UpdateIcons(Zorlen_WarriorSpam_IconIndex_BerserkerRage, macro, test)
	elseif
		Zorlen_Button[LOCALIZATION_ZORLEN.Bloodrage] and Zorlen_Button[LOCALIZATION_ZORLEN.ConcussionBlow] and pvp ~= "yes" and TIETE and CID and PlayerMana < 15 and PlayerHealthFraction >= 0.5 and Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN.ConcussionBlow) and (Zorlen_BloodrageRagePoints() + PlayerMana) >= 15 and castBloodrage(test)
		then
		--castBloodrage()
		Zorlen_WarriorSpam_UpdateIcons(Zorlen_WarriorSpam_IconIndex_Bloodrage, macro, test)
	elseif
		Zorlen_Button[LOCALIZATION_ZORLEN.BerserkerRage] and Zorlen_Button[LOCALIZATION_ZORLEN.ShieldBash] and pvp ~= "yes" and TIETE and CID and Zorlen_isShieldEquipped() and isBerserkerStance() and PlayerMana < 10 and Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN.ShieldBash) and TMRP >= 10 and (BRRP + PlayerMana) >= 10 and castBerserkerRage(test)
		then
		--castBerserkerRage()
		Zorlen_WarriorSpam_UpdateIcons(Zorlen_WarriorSpam_IconIndex_BerserkerRage, macro, test)
	elseif
		Zorlen_Button[LOCALIZATION_ZORLEN.ShieldBash] and pvp ~= "yes" and TIETE and CID and Zorlen_isShieldEquipped() and Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN.ShieldBash) and isBerserkerStance()
		 and
		(
			(
				PlayerMana >= 10 and TMRP >= 10
			)
			 or
			(
				PlayerHealthFraction >= 0.5 and Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN.Bloodrage)
			)
		)
		 and
		castDefensiveStance(test)
		then
		if not test and tanking ~= "yes" and not Zorlen_WarriorSpam_SwapFromBerserkerToDoAction and not Zorlen_WarriorSpam_SwapFromDefensiveToDoAction and not Zorlen_WarriorSpam_SwapFromBattleToDoAction then
			Zorlen_WarriorSpam_SwapFromBerserkerToDoAction = 1;
		end
		--castDefensiveStance()
		Zorlen_WarriorSpam_UpdateIcons(Zorlen_WarriorSpam_IconIndex_DefensiveStance, macro, test)
	elseif
		Zorlen_Button[LOCALIZATION_ZORLEN.Pummel] and pvp ~= "yes" and not isBerserkerStance() and TIETE and CID and Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN.Pummel)
		 and
		(
			(
				PlayerMana >= 10 and TMRP >= 10
			)
			 or
			(
				PlayerHealthFraction >= 0.5 and Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN.Bloodrage)
			)
			 or
			(
				Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN.BerserkerRage)
				 and
				(
					BRRP >= 10
					 or
					(
						BRRP >= 5 and TMRP >= 5 and PlayerMana >= 5
					)
				)
			)
		)
		 and
		castBerserkerStance(test)
		then
		if not test and tanking ~= "yes" and not Zorlen_WarriorSpam_SwapFromBerserkerToDoAction and not Zorlen_WarriorSpam_SwapFromDefensiveToDoAction and not Zorlen_WarriorSpam_SwapFromBattleToDoAction then
			if isBattleStance() then
				Zorlen_WarriorSpam_SwapFromBattleToDoAction = 1;
			else
				Zorlen_WarriorSpam_SwapFromDefensiveToDoAction = 1;
			end
		end
		--castBerserkerStance()
		Zorlen_WarriorSpam_UpdateIcons(Zorlen_WarriorSpam_IconIndex_BerserkerStance, macro, test)
	elseif
		Zorlen_Button[LOCALIZATION_ZORLEN.BerserkerRage] and Zorlen_Button[LOCALIZATION_ZORLEN.Pummel] and pvp ~= "yes" and TIETE and CID and Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN.Pummel) and isBerserkerStance() and PlayerMana < 10
		 and
		(
			BRRP >= 10
			 or
			(
				BRRP >= 5 and PlayerMana >= 5
			)
		)
		 and
		castBerserkerRage(test)
		then
		--castBerserkerRage()
		Zorlen_WarriorSpam_UpdateIcons(Zorlen_WarriorSpam_IconIndex_BerserkerRage, macro, test)
	elseif
		Zorlen_Button[LOCALIZATION_ZORLEN.Bloodrage] and pvp ~= "yes" and TIETE and CID and PlayerMana < 10 and PlayerHealthFraction >= 0.5
		 and
		(
			(
				Zorlen_isShieldEquipped() and not isBerserkerStance() and Zorlen_Button[LOCALIZATION_ZORLEN.ShieldBash] and Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN.ShieldBash)
			)
			 or
			(
				Zorlen_Button[LOCALIZATION_ZORLEN.Pummel] and Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN.Pummel) and isBerserkerStance()
			)
		)
		 and
		castBloodrage(test)
		then
		--castBloodrage()
		Zorlen_WarriorSpam_UpdateIcons(Zorlen_WarriorSpam_IconIndex_Bloodrage, macro, test)
	elseif Zorlen_Button[LOCALIZATION_ZORLEN.Taunt] and (tanking == "yes") and (taunt == "yes") and castTaunt(test) then
		if not test then
			Zorlen_WarriorSpam_MockingBlowDelay = 1;
			ZorlenWarriorSpamFrame.MockingBlowDelay_timer = 3;
			ZorlenWarriorSpamFrame:Show();
		end
		--castTaunt()
		Zorlen_WarriorSpam_UpdateIcons(Zorlen_WarriorSpam_IconIndex_Taunt, macro, test)
	elseif
		Zorlen_Button[LOCALIZATION_ZORLEN.MockingBlow] and (mode == "hate") and (taunt == "yes") and not Zorlen_WarriorSpam_MockingBlowDelay and not Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN.Taunt) and castMockingBlow(test)
		then
		--castMockingBlow()
		Zorlen_WarriorSpam_UpdateIcons(Zorlen_WarriorSpam_IconIndex_MockingBlow, macro, test)
	elseif
		Zorlen_Button[LOCALIZATION_ZORLEN.BerserkerRage] and Zorlen_Button[LOCALIZATION_ZORLEN.MockingBlow] and (mode == "hate") and (taunt == "yes") and not Zorlen_WarriorSpam_MockingBlowDelay and Zorlen_TargetIsEnemyTargetingFriendButNotYou() and CID and not Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN.Taunt) and Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN.MockingBlow) and isBerserkerStance() and PlayerMana < 10 and TMRP >= 10 and (BRRP + PlayerMana) >= 10 and castBerserkerRage(test)
		then
		--castBerserkerRage()
		Zorlen_WarriorSpam_UpdateIcons(Zorlen_WarriorSpam_IconIndex_BerserkerRage, macro, test)
	elseif
		Zorlen_Button[LOCALIZATION_ZORLEN.MockingBlow] and (mode == "hate") and (taunt == "yes") and not isBattleStance() and not Zorlen_WarriorSpam_MockingBlowDelay and Zorlen_TargetIsEnemyTargetingFriendButNotYou() and CID and not Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN.Taunt) and Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN.MockingBlow)
		 and
		(
			(
				PlayerMana >= 10 and TMRP >= 10
			)
			 or
			(
				PlayerHealthFraction >= 0.5 and Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN.Bloodrage)
			)
		)
		 and
		castBattleStance(test)
		then
		--castBattleStance()
		Zorlen_WarriorSpam_UpdateIcons(Zorlen_WarriorSpam_IconIndex_BattleStance, macro, test)
	elseif
		Zorlen_Button[LOCALIZATION_ZORLEN.Bloodrage] and Zorlen_Button[LOCALIZATION_ZORLEN.MockingBlow] and (mode == "hate") and (taunt == "yes") and not Zorlen_WarriorSpam_MockingBlowDelay and Zorlen_TargetIsEnemyTargetingFriendButNotYou() and CID and not Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN.Taunt) and Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN.MockingBlow) and isBattleStance() and PlayerMana < 10 and PlayerHealthFraction >= 0.5 and castBloodrage(test)
		then
		--castBloodrage()
		Zorlen_WarriorSpam_UpdateIcons(Zorlen_WarriorSpam_IconIndex_Bloodrage, macro, test)
	elseif
		Zorlen_Button[LOCALIZATION_ZORLEN.Charge] and not ImmobilizingEffect and not IncapacitateEffect and not IsAltKeyDown()
		 and
		(
			(
				(aggrocharge == "yes") and ActiveEnemy
			)
			 or
			(charge == "yes") or (charge == "force") or IsControlKeyDown()
		)
		 and
		castCharge(test)
		then
		if not test then
			Zorlen_SetTimer(5, "CastChargeDelay", nil, "InternalZorlenMiscTimer", 2)
		end
		--castCharge()
		Zorlen_WarriorSpam_UpdateIcons(Zorlen_WarriorSpam_IconIndex_Charge, macro, test)
	elseif
		Zorlen_Button[LOCALIZATION_ZORLEN.Intercept] and not ImmobilizingEffect and not IncapacitateEffect and not IsAltKeyDown()
		 and
		(
			(
				(aggrocharge == "yes") and ActiveEnemy
			)
			 or
			(charge == "yes") or (charge == "force") or IsControlKeyDown()
		)
		 and
		castIntercept(test)
		then
		--castIntercept()
		Zorlen_WarriorSpam_UpdateIcons(Zorlen_WarriorSpam_IconIndex_Intercept, macro, test)
	elseif
		Zorlen_Button[LOCALIZATION_ZORLEN.Charge] and not ImmobilizingEffect and not IncapacitateEffect and not isBattleStance() and not IsAltKeyDown()
		 and
		(
			(
				(aggrocharge == "yes") and ActiveEnemy
			)
			 or
			charge == "force" or IsControlKeyDown()
		)
		 and
		IsActionInRange(Zorlen_Button[LOCALIZATION_ZORLEN.Charge..".Any"]) ~= 0 and Zorlen_notInCombat() and Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN.Charge)
		 and
		castBattleStance(test)
		then
		if not test and tanking ~= "yes" and not Zorlen_WarriorSpam_SwapFromBerserkerToDoAction and not Zorlen_WarriorSpam_SwapFromDefensiveToDoAction and not Zorlen_WarriorSpam_SwapFromBattleToDoAction then
			if isBerserkerStance() then
				Zorlen_WarriorSpam_SwapFromBerserkerToDoAction = 1;
			else
				Zorlen_WarriorSpam_SwapFromDefensiveToDoAction = 1;
			end
		end
		--castBattleStance()
		Zorlen_WarriorSpam_UpdateIcons(Zorlen_WarriorSpam_IconIndex_BattleStance, macro, test)
	elseif
		Zorlen_Button[LOCALIZATION_ZORLEN.Intercept] and not ImmobilizingEffect and not IncapacitateEffect and not isBerserkerStance() and not IsAltKeyDown()
		 and
		(((aggrocharge == "yes") and ActiveEnemy) or (charge == "force") or IsControlKeyDown())
		 and
		not
		(
			Zorlen_TargetIsEnemyTargetingYou() and CheckInteractDistance("target", 3)
		)
		 and
		((Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN.Charge) and Zorlen_Combat) or not Zorlen_IsTimer("CastChargeDelay", nil, "InternalZorlenMiscTimer"))
		 and
		(IsActionInRange(Zorlen_Button[LOCALIZATION_ZORLEN.Intercept..".Any"]) ~= 0) and Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN.Intercept)
		 and
		(
			(
				PlayerMana >= 10 and TMRP >= 10
			)
			 or
			(
				(
					Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN.Bloodrage)
					 and
					(
						(
							ActiveEnemy and PlayerHealthFraction > 0.5
						)
						 or
						(
							IsControlKeyDown() and PlayerHealthFraction > 0.2
						)
					)
				)
				 or
				(
					Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN.BerserkerRage)
					 and
					(
						BRRP >= 10
						 or
						(
							BRRP >= 5 and TMRP >= 5 and PlayerMana >= 5
						)
					)
				)
			)
		)
		 and
		castBerserkerStance(test)
		then
		if not test and tanking ~= "yes" and not Zorlen_WarriorSpam_SwapFromBerserkerToDoAction and not Zorlen_WarriorSpam_SwapFromDefensiveToDoAction and not Zorlen_WarriorSpam_SwapFromBattleToDoAction then
			if isBattleStance() then
				Zorlen_WarriorSpam_SwapFromBattleToDoAction = 1;
			else
				Zorlen_WarriorSpam_SwapFromDefensiveToDoAction = 1;
			end
		end
		--castBerserkerStance()
		Zorlen_WarriorSpam_UpdateIcons(Zorlen_WarriorSpam_IconIndex_BerserkerStance, macro, test)
	elseif
		Zorlen_Button[LOCALIZATION_ZORLEN.BerserkerRage] and Zorlen_Button[LOCALIZATION_ZORLEN.Intercept] and not ImmobilizingEffect and not IncapacitateEffect
		 and
		(
			(
				(aggrocharge == "yes") and ActiveEnemy
			)
			 or
			(charge == "force") or IsControlKeyDown()
		)
		 and
		not IsAltKeyDown() and isBerserkerStance()
		 and
		(
			(
				Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN.Charge) and Zorlen_Combat
			)
			 or
			not Zorlen_IsTimer("CastChargeDelay", nil, "InternalZorlenMiscTimer")
		)
		and
		(IsActionInRange(Zorlen_Button[LOCALIZATION_ZORLEN.Intercept..".Any"]) ~= 0) and Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN.Intercept) and PlayerMana < 10 and (BRRP + PlayerMana) >= 10 and castBerserkerRage(test)
		then
		--castBerserkerRage()
		Zorlen_WarriorSpam_UpdateIcons(Zorlen_WarriorSpam_IconIndex_BerserkerRage, macro, test)
	elseif
		Zorlen_Button[LOCALIZATION_ZORLEN.Bloodrage] and Zorlen_Button[LOCALIZATION_ZORLEN.Intercept] and not ImmobilizingEffect and not IncapacitateEffect
		 and
		(
			(
				(aggrocharge == "yes") and ActiveEnemy
			)
			 or
			IsControlKeyDown()
		)
		 and
		not IsAltKeyDown() and isBerserkerStance()
		 and
		(
			PlayerHealthFraction >= 0.5 or IsControlKeyDown()
		)
		 and
		(
			not Zorlen_IsTimer("CastChargeDelay", nil, "InternalZorlenMiscTimer")
			 or
			(
				Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN.Charge) and Zorlen_Combat
			)
		)
		 and
		(IsActionInRange(Zorlen_Button[LOCALIZATION_ZORLEN.Intercept..".Any"]) ~= 0) and Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN.Intercept) and PlayerMana < 10 and castBloodrage(test)
		then
		--castBloodrage()
		Zorlen_WarriorSpam_UpdateIcons(Zorlen_WarriorSpam_IconIndex_Bloodrage, macro, test)
	elseif
		Zorlen_Button[LOCALIZATION_ZORLEN.Hamstring] and not boss
		 and
		(
			(pvp == "yes")
			 or
			(
				not ZorlenWarriorSpamConfig[ZPN][HAMSTRINGOFF] and ZorlenWarriorSpamConfig[ZPN][ALWAYSHAMSTRING] and UnitHealth("target") / UnitHealthMax("target") <= 0.5
			)
			 or
			(not ZorlenWarriorSpamConfig[ZPN][HAMSTRINGOFF] and Zorlen_TargetIsDieingEnemyWithNoTarget())
		)
		 and
		castHamstring(test)
		then
		--castHamstring()
		Zorlen_WarriorSpam_UpdateIcons(Zorlen_WarriorSpam_IconIndex_Hamstring, macro, test)
	elseif
		Zorlen_Button[LOCALIZATION_ZORLEN.BerserkerRage] and Zorlen_Button[LOCALIZATION_ZORLEN.Hamstring] and not boss
		 and
		(
			not Zorlen_WasHamstringSpellCastImmune
			 or
			(
				Zorlen_WasHamstring and not Zorlen_IsTimer(LOCALIZATION_ZORLEN.Hamstring, "immune", "InternalZorlenMiscTimer")
			)
			 or
			(
				(pvp == "yes") and not Zorlen_IsTimer(LOCALIZATION_ZORLEN.Hamstring, "immune", "InternalZorlenMiscTimer")
			)
		)
		 and
		not hamstrung
		 and
		(
			(pvp == "yes")
			 or
			(
				not ZorlenWarriorSpamConfig[ZPN][HAMSTRINGOFF] and ZorlenWarriorSpamConfig[ZPN][ALWAYSHAMSTRING] and UnitHealth("target") / UnitHealthMax("target") <= 0.5
			)
			 or
			(not ZorlenWarriorSpamConfig[ZPN][HAMSTRINGOFF] and Zorlen_TargetIsDieingEnemyWithNoTarget())
		)
		 and
		CID and Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN.Hamstring) and isBerserkerStance() and PlayerMana < 10 and (BRRP + PlayerMana) >= 10 and castBerserkerRage(test)
		then
		--castBerserkerRage()
		Zorlen_WarriorSpam_UpdateIcons(Zorlen_WarriorSpam_IconIndex_BerserkerRage, macro, test)
	elseif
		Zorlen_Button[LOCALIZATION_ZORLEN.Hamstring] and not boss
		 and
		(
			not Zorlen_WasHamstringSpellCastImmune
			 or
			(
				Zorlen_WasHamstring and not Zorlen_IsTimer(LOCALIZATION_ZORLEN.Hamstring, "immune", "InternalZorlenMiscTimer")
			)
			 or
			(
				(pvp == "yes") and not Zorlen_IsTimer(LOCALIZATION_ZORLEN.Hamstring, "immune", "InternalZorlenMiscTimer")
			)
		)
		 and
		not hamstrung
		 and
		(
			(pvp == "yes")
			 or
			(
				not ZorlenWarriorSpamConfig[ZPN][HAMSTRINGOFF] and ZorlenWarriorSpamConfig[ZPN][ALWAYSHAMSTRING] and UnitHealth("target") / UnitHealthMax("target") <= 0.5
			)
			 or
			(not ZorlenWarriorSpamConfig[ZPN][HAMSTRINGOFF] and Zorlen_TargetIsDieingEnemyWithNoTarget())
		)
		 and
		CID and Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN.Hamstring) and isDefensiveStance()
		 and
		(
			(
				PlayerMana >= 10 and TMRP >= 10
			)
			 or
			(
				PlayerHealthFraction >= 0.5 and Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN.Bloodrage)
			)
		)
		 and
		castBattleStance(test)
		then
		if not test and tanking ~= "yes" and not Zorlen_WarriorSpam_SwapFromBerserkerToDoAction and not Zorlen_WarriorSpam_SwapFromDefensiveToDoAction and not Zorlen_WarriorSpam_SwapFromBattleToDoAction then
			Zorlen_WarriorSpam_SwapFromDefensiveToDoAction = 1;
		end
		--castBattleStance()
		Zorlen_WarriorSpam_UpdateIcons(Zorlen_WarriorSpam_IconIndex_BattleStance, macro, test)
	elseif
		Zorlen_Button[LOCALIZATION_ZORLEN.Hamstring] and not boss
		 and
		(
			not Zorlen_WasHamstringSpellCastImmune
			 or
			(
				Zorlen_WasHamstring and not Zorlen_IsTimer(LOCALIZATION_ZORLEN.Hamstring, "immune", "InternalZorlenMiscTimer")
			)
			 or
			(
				(pvp == "yes") and not Zorlen_IsTimer(LOCALIZATION_ZORLEN.Hamstring, "immune", "InternalZorlenMiscTimer")
			)
		)
		 and
		not hamstrung
		 and
		(
			(
				PlayerMana < 10 and (pvp == "yes")
				 and
				(
					not Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN.Bloodrage) or PlayerHealthFraction < 0.5
				)
			)
			 or
			(
				pvp ~= "yes"
				 and
				(
					Zorlen_TargetIsDieingEnemyWithNoTarget()
					 or
					(
						PlayerMana < 10
						 and
						(
							not Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN.Bloodrage) or PlayerHealthFraction < 0.5
						)
						 and
						UnitHealth("target") / UnitHealthMax("target") <= 0.5
					)
				)
			)
		)
		 and
		CID and Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN.Hamstring) and not isBerserkerStance()
		 and
		(
			(
				PlayerMana >= 10 and TMRP >= 10 and not isBattleStance()
			)
			 or
			(
				PlayerMana < 10
				 and 
				(
					(
						Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN.Bloodrage) and PlayerHealthFraction >= 0.5 and not isBattleStance()
					)
					 or
					(
						Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN.BerserkerRage)
						 and
						(
							BRRP >= 10
							 or
							(
								BRRP >= 5 and PlayerMana >= 5 and TMRP >= 5
							)
						)
					)
				)
			)
		)
		and
		castBerserkerStance(test)
		then
		if not test and tanking ~= "yes" and not Zorlen_WarriorSpam_SwapFromBerserkerToDoAction and not Zorlen_WarriorSpam_SwapFromDefensiveToDoAction and not Zorlen_WarriorSpam_SwapFromBattleToDoAction then
			if isBattleStance() then
				Zorlen_WarriorSpam_SwapFromBattleToDoAction = 1;
			else
				Zorlen_WarriorSpam_SwapFromDefensiveToDoAction = 1;
			end
		end
		--castBerserkerStance()
		Zorlen_WarriorSpam_UpdateIcons(Zorlen_WarriorSpam_IconIndex_BerserkerStance, macro, test)
	elseif
		Zorlen_Button[LOCALIZATION_ZORLEN.Bloodrage] and Zorlen_Button[LOCALIZATION_ZORLEN.Hamstring] and not boss
		 and
		(
			not Zorlen_WasHamstringSpellCastImmune
			 or
			(
				Zorlen_WasHamstring and not Zorlen_IsTimer(LOCALIZATION_ZORLEN.Hamstring, "immune", "InternalZorlenMiscTimer")
			)
			 or
			(
				(pvp == "yes") and not Zorlen_IsTimer(LOCALIZATION_ZORLEN.Hamstring, "immune", "InternalZorlenMiscTimer")
			)
		)
		 and
		not hamstrung
		 and
		(
			(pvp == "yes")
			 or
			(
				not ZorlenWarriorSpamConfig[ZPN][HAMSTRINGOFF] and ZorlenWarriorSpamConfig[ZPN][ALWAYSHAMSTRING] and UnitHealth("target") / UnitHealthMax("target") <= 0.5
			)
			 or
			(not ZorlenWarriorSpamConfig[ZPN][HAMSTRINGOFF] and Zorlen_TargetIsDieingEnemyWithNoTarget())
		)
		 and
		CID and PlayerMana < 10 and PlayerHealthFraction >= 0.5 and not isDefensiveStance() and Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN.Hamstring) and castBloodrage(test)
		then
		--castBloodrage()
		Zorlen_WarriorSpam_UpdateIcons(Zorlen_WarriorSpam_IconIndex_Bloodrage, macro, test)
	elseif
		Zorlen_Button[LOCALIZATION_ZORLEN.Revenge]
		 and
		(
			mode == "hate"
			 or
			(
				(
					tanking ~= "yes"
					 or
					(
						Zorlen_IsTimer(LOCALIZATION_ZORLEN.SunderArmor, "immune", "InternalZorlenMiscTimer")
						 or
						(
							(
								Zorlen_GetTimer(LOCALIZATION_ZORLEN.SunderArmor, nil, "InternalZorlenSpellTimers") > Zorlen_WarriorSpam_SunderRemainingDurationCastTime
							)
							 or
							not isSunder()
						)
					)
				)
				 and
				not
				(
					not boss
					 and
					(
						not Zorlen_WasHamstringSpellCastImmune
						 or
						(
							Zorlen_WasHamstring and not Zorlen_IsTimer(LOCALIZATION_ZORLEN.Hamstring, "immune", "InternalZorlenMiscTimer")
						)
						 or
						(
							(pvp == "yes") and not Zorlen_IsTimer(LOCALIZATION_ZORLEN.Hamstring, "immune", "InternalZorlenMiscTimer")
						)
					)
					 and
					not hamstrung
					 and
					(
						(pvp == "yes")
						 or
						(
							not ZorlenWarriorSpamConfig[ZPN][HAMSTRINGOFF] and ZorlenWarriorSpamConfig[ZPN][ALWAYSHAMSTRING] and UnitHealth("target") / UnitHealthMax("target") <= 0.5
						)
						 or
						(not ZorlenWarriorSpamConfig[ZPN][HAMSTRINGOFF] and Zorlen_TargetIsDieingEnemyWithNoTarget())
					)
					 and
					CID and Zorlen_Button[LOCALIZATION_ZORLEN.Hamstring] and Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN.Hamstring)
					 and
					(
						TMRP >= 10
						 or
						(
							PlayerMana < 10 and Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN.Bloodrage) and PlayerHealthFraction >= 0.5
						)
						 or
						(
							PlayerMana < 10 and Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN.BerserkerRage)
							 and
							(
								BRRP >= 10
								 or
								(
									BRRP >= 5 and TMRP >= 5
								)
							)
						)
					)
				)
			)
		)
		 and
		castRevenge(test)
		then
		--castRevenge()
		Zorlen_WarriorSpam_UpdateIcons(Zorlen_WarriorSpam_IconIndex_Revenge, macro, test)
	elseif
		Zorlen_Button[LOCALIZATION_ZORLEN.Overpower] and tanking ~= "yes"
		 and
		not
		(
			not boss
			 and
			(
				not Zorlen_WasHamstringSpellCastImmune
				 or
				(
					Zorlen_WasHamstring and not Zorlen_IsTimer(LOCALIZATION_ZORLEN.Hamstring, "immune", "InternalZorlenMiscTimer")
				)
				 or
				(
					(pvp == "yes") and not Zorlen_IsTimer(LOCALIZATION_ZORLEN.Hamstring, "immune", "InternalZorlenMiscTimer")
				)
			)
			 and
			not hamstrung
			 and
			(
				(pvp == "yes")
				 or
				(
					not ZorlenWarriorSpamConfig[ZPN][HAMSTRINGOFF] and ZorlenWarriorSpamConfig[ZPN][ALWAYSHAMSTRING] and UnitHealth("target") / UnitHealthMax("target") <= 0.5
				)
				 or
				(not ZorlenWarriorSpamConfig[ZPN][HAMSTRINGOFF] and Zorlen_TargetIsDieingEnemyWithNoTarget())
			)
			 and
			CID and Zorlen_Button[LOCALIZATION_ZORLEN.Hamstring] and Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN.Hamstring)
		)
		 and
		castOverpower(test)
		then
		--castOverpower()
		Zorlen_WarriorSpam_UpdateIcons(Zorlen_WarriorSpam_IconIndex_Overpower, macro, test)
	elseif
		Zorlen_Button[LOCALIZATION_ZORLEN.BerserkerRage] and Zorlen_Button[LOCALIZATION_ZORLEN.Overpower] and tanking ~= "yes" and CID and Zorlen_IsTimer("TargetDodgedYou_Overpower", nil, "InternalZorlenMiscTimer") and Zorlen_GetTalentRank(LOCALIZATION_ZORLEN.ImprovedOverpower) >= 1 and Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN.Overpower) and isBerserkerStance() and PlayerMana < 5 and TMRP >= 5 and BRRP >= 5 and castBerserkerRage(test)
		then
		--castBerserkerRage()
		Zorlen_WarriorSpam_UpdateIcons(Zorlen_WarriorSpam_IconIndex_BerserkerRage, macro, test)
	elseif
		Zorlen_Button[LOCALIZATION_ZORLEN.Bloodrage] and Zorlen_Button[LOCALIZATION_ZORLEN.Overpower] and tanking ~= "yes" and CID and Zorlen_IsTimer("TargetDodgedYou_Overpower", nil, "InternalZorlenMiscTimer") and ActiveEnemy and Zorlen_GetTalentRank(LOCALIZATION_ZORLEN.ImprovedOverpower) >= 1 and Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN.Overpower) and isBattleStance() and PlayerMana < 5 and PlayerHealthFraction >= 0.5 and castBloodrage(test)
		then
		--castBloodrage()
		Zorlen_WarriorSpam_UpdateIcons(Zorlen_WarriorSpam_IconIndex_Bloodrage, macro, test)
	elseif
		Zorlen_Button[LOCALIZATION_ZORLEN.Overpower] and tanking ~= "yes" and Zorlen_IsTimer("TargetDodgedYou_Overpower", nil, "InternalZorlenMiscTimer") and not isBattleStance() and CID and Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN.Overpower)
		 and
		(
			not Zorlen_TargetIsDieingEnemy() or isDefensiveStance()
		)
		 and
		(
			(
				PlayerMana >= 5 and PlayerMana <= (TMRP + 5)
			)
			 or
			(
				Zorlen_GetTalentRank(LOCALIZATION_ZORLEN.ImprovedOverpower) >= 1
				 and
				(
					(
						PlayerMana <= (TMRP + 10)
					)
				)
			)
		)
		 and
		castBattleStance(test)
		then
		if not test and tanking ~= "yes" and not Zorlen_WarriorSpam_SwapFromBerserkerToDoAction and not Zorlen_WarriorSpam_SwapFromDefensiveToDoAction and not Zorlen_WarriorSpam_SwapFromBattleToDoAction then
			if isBerserkerStance() then
				Zorlen_WarriorSpam_SwapFromBerserkerToDoAction = 1;
			else
				Zorlen_WarriorSpam_SwapFromDefensiveToDoAction = 1;
			end
		end
		--castBattleStance()
		Zorlen_WarriorSpam_UpdateIcons(Zorlen_WarriorSpam_IconIndex_BattleStance, macro, test)
	elseif Zorlen_Button[LOCALIZATION_ZORLEN.Execute] and tanking ~= "yes" and castExecute(test) then
		Zorlen_WarriorSpam_UpdateIcons(Zorlen_WarriorSpam_IconIndex_Execute, macro, test)
	elseif
		Zorlen_Button[LOCALIZATION_ZORLEN.Bloodrage] and (mode == "hate") and ActiveEnemy and CheckInteractDistance("target", 3) and PlayerHealthFraction > 0.5 and castBloodrage(test)
		then
		--castBloodrage()
		Zorlen_WarriorSpam_UpdateIcons(Zorlen_WarriorSpam_IconIndex_Bloodrage, macro, test)
	elseif Zorlen_Button[LOCALIZATION_ZORLEN.ShieldBash] and (mode == "hate") and (((Zorlen_GetTimer(LOCALIZATION_ZORLEN.SunderArmor, nil, "InternalZorlenSpellTimers") > Zorlen_WarriorSpam_SunderRemainingDurationCastTime or not Zorlen_Button[LOCALIZATION_ZORLEN.SunderArmor]) and PlayerMana >= (15 + Zorlen_ShieldSlamRageCost())) or PlayerMana >= (10 + Zorlen_SunderArmorRageCost() + Zorlen_ShieldSlamRageCost())) and isSunder() and (not Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN.ShieldSlam) or not Zorlen_isShieldEquipped()) and castShieldBash(test) then
		--castShieldBash()
		Zorlen_WarriorSpam_UpdateIcons(Zorlen_WarriorSpam_IconIndex_ShieldBash, macro, test)
	elseif (tanking == "yes") then
		if
			CID and PlayerMana < 35
			 and
			(
				mode == "hate" or Zorlen_IsTimer(LOCALIZATION_ZORLEN.Hamstring, "immune", "InternalZorlenMiscTimer")
				 or
				(
					Zorlen_WasHamstringSpellCastImmune and not Zorlen_WasHamstring
				)
				 or
				not
				(
					not boss and not hamstrung
					 and
					(
						(pvp == "yes")
						 or
						(
							not ZorlenWarriorSpamConfig[ZPN][HAMSTRINGOFF] and ZorlenWarriorSpamConfig[ZPN][ALWAYSHAMSTRING] and UnitHealth("target") / UnitHealthMax("target") <= 0.5
						)
						 or
						(not ZorlenWarriorSpamConfig[ZPN][HAMSTRINGOFF] and Zorlen_TargetIsDieingEnemyWithNoTarget())
					)
				)
			)
			 and
			castDefensiveStance(test)
			then
			--castDefensiveStance()
			Zorlen_WarriorSpam_UpdateIcons(Zorlen_WarriorSpam_IconIndex_DefensiveStance, macro, test)
		elseif
			Zorlen_Button[LOCALIZATION_ZORLEN.ShieldSlam]
			 and
			(
				(
					(
						not Zorlen_Button[LOCALIZATION_ZORLEN.SunderArmor]
						 or
						(
							(
								mode == "hate" or isSunderFull()
							)
							 and
							(
								(
									Zorlen_GetTimer(LOCALIZATION_ZORLEN.SunderArmor, nil, "InternalZorlenSpellTimers") > Zorlen_WarriorSpam_SunderRemainingDurationCastTime
								)
								 or
								not isSunder()
							)
						)
					)
					 and
					PlayerMana >= 25
				)
				 or
				(
					PlayerMana >= (20 + Zorlen_SunderArmorRageCost())
				)
			)
			 and
			castShieldSlam(test)
			then
			--castShieldSlam()
			Zorlen_WarriorSpam_UpdateIcons(Zorlen_WarriorSpam_IconIndex_ShieldSlam, macro, test)
		elseif
			Zorlen_Button[LOCALIZATION_ZORLEN.ShieldBlock] and ((Zorlen_GetTimer(LOCALIZATION_ZORLEN.SunderArmor, nil, "InternalZorlenSpellTimers") > Zorlen_WarriorSpam_SunderRemainingDurationCastTime and PlayerMana >= 15) or PlayerMana >= (15 + Zorlen_SunderArmorRageCost())) and isSunder() and (mode ~= "hate" or not Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN.ShieldSlam) or not Zorlen_isShieldEquipped()) and Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN.Revenge)
			 and
			castShieldBlock(test)
			then
			--castShieldBlock()
			Zorlen_WarriorSpam_UpdateIcons(Zorlen_WarriorSpam_IconIndex_ShieldBlock, macro, test)
		elseif
			Zorlen_Button[LOCALIZATION_ZORLEN.Disarm] and mode ~= "hate" and (disarm == "yes")
			 and
			(
				Zorlen_IsTimer(LOCALIZATION_ZORLEN.SunderArmor, "immune", "InternalZorlenMiscTimer")
				 or
				(
					Zorlen_GetTimer(LOCALIZATION_ZORLEN.SunderArmor, nil, "InternalZorlenSpellTimers") > Zorlen_WarriorSpam_SunderRemainingDurationCastTime and isSunder()
				)
			)
			 and
			castDisarm(test)
			then
			--castDisarm()
			Zorlen_WarriorSpam_UpdateIcons(Zorlen_WarriorSpam_IconIndex_Disarm, macro, test)
		elseif
			Zorlen_Button[LOCALIZATION_ZORLEN.DemoralizingShout] and mode ~= "hate" and (demo == "yes")
			 and
			(
				Zorlen_IsTimer(LOCALIZATION_ZORLEN.SunderArmor, "immune", "InternalZorlenMiscTimer")
				 or
				(
					Zorlen_GetTimer(LOCALIZATION_ZORLEN.SunderArmor, nil, "InternalZorlenSpellTimers") > Zorlen_WarriorSpam_SunderRemainingDurationCastTime and isSunder()
				)
			)
			 and
			castDemoralizingShout(test)
			then
			--castDemoralizingShout()
			Zorlen_WarriorSpam_UpdateIcons(Zorlen_WarriorSpam_IconIndex_DemoralizingShout, macro, test)
		elseif
			Zorlen_Button[LOCALIZATION_ZORLEN.BattleShout] and mode ~= "hate"
			 and
			(
				Zorlen_IsTimer(LOCALIZATION_ZORLEN.SunderArmor, "immune", "InternalZorlenMiscTimer")
				 or
				(
					Zorlen_GetTimer(LOCALIZATION_ZORLEN.SunderArmor, nil, "InternalZorlenSpellTimers") > Zorlen_WarriorSpam_SunderRemainingDurationCastTime and isSunder()
				)
			)
			 and
			castBattleShout(test) then
			--castBattleShout()
			Zorlen_WarriorSpam_UpdateIcons(Zorlen_WarriorSpam_IconIndex_BattleShout, macro, test)
		elseif 
			Zorlen_Button[LOCALIZATION_ZORLEN.Rend] and mode ~= "hate" and (rend == "yes")
			 and
			(
				Zorlen_IsTimer(LOCALIZATION_ZORLEN.SunderArmor, "immune", "InternalZorlenMiscTimer")
				 or
				(
					Zorlen_GetTimer(LOCALIZATION_ZORLEN.SunderArmor, nil, "InternalZorlenSpellTimers") > Zorlen_WarriorSpam_SunderRemainingDurationCastTime and isSunderFull()
				)
			)
			 and
			((not Zorlen_Button[LOCALIZATION_ZORLEN.SunderArmor] and PlayerMana >= 15) or (PlayerMana >= (10 + Zorlen_SunderArmorRageCost())))
			 and
			castRend(test)
			then
			--castRend()
			Zorlen_WarriorSpam_UpdateIcons(Zorlen_WarriorSpam_IconIndex_Rend, macro, test)
		elseif
			Zorlen_Button[LOCALIZATION_ZORLEN.SunderArmor]
			 and
			(
				(
					(
						Zorlen_GetTimer(LOCALIZATION_ZORLEN.SunderArmor, nil, "InternalZorlenSpellTimers") <= Zorlen_WarriorSpam_SunderRemainingDurationCastTime
					)
					 and
					isSunder()
				)
				 or
				(
					(not Zorlen_Button[LOCALIZATION_ZORLEN.ShieldSlam] or not Zorlen_isShieldEquipped() or mode ~= "hate" or not Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN.ShieldSlam))
					 and
					not
					(
						(
							not Zorlen_WasHamstringSpellCastImmune
							 or
							(
								Zorlen_WasHamstring and not Zorlen_IsTimer(LOCALIZATION_ZORLEN.Hamstring, "immune", "InternalZorlenMiscTimer")
							)
						)
						 and
						not boss and not hamstrung
						 and
						(
							(
								not ZorlenWarriorSpamConfig[ZPN][HAMSTRINGOFF] and ZorlenWarriorSpamConfig[ZPN][ALWAYSHAMSTRING] and UnitHealth("target") / UnitHealthMax("target") <= 0.5
							)
							 or
							(not ZorlenWarriorSpamConfig[ZPN][HAMSTRINGOFF] and Zorlen_TargetIsDieingEnemyWithNoTarget())
						)
						 and
						CID and Zorlen_Button[LOCALIZATION_ZORLEN.Hamstring] and Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN.Hamstring)
						 and
						(
							TMRP >= 10
							 or
							(
								PlayerMana < 10 and Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN.Bloodrage) and PlayerHealthFraction >= 0.5
							)
							 or
							(
								PlayerMana < 10 and Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN.BerserkerRage)
								 and
								(
									BRRP >= 10
									 or
									(
										BRRP >= 5 and TMRP >= 5
									)
								)
							)
						)
					)
				)
			)
			 and
			castSunderArmor(Zorlen_WarriorSpam_SunderRemainingDurationCastTime, test)
			then
			--castSunderArmor()
			Zorlen_WarriorSpam_UpdateIcons(Zorlen_WarriorSpam_IconIndex_SunderArmor, macro, test)
		elseif Zorlen_Button[LOCALIZATION_ZORLEN.SunderArmor] and ZorlenWarriorSpamConfig[ZPN][UNLIMITEDSUNDER] then
			if PlayerMana >= (25 + Zorlen_SunderArmorRageCost()) or ((not Zorlen_Button[LOCALIZATION_ZORLEN.ShieldSlam] or not Zorlen_isShieldEquipped()) and (PlayerMana >= (10 + Zorlen_SunderArmorRageCost()))) then
				if castUnlimitedSunderArmor(test) then
					Zorlen_WarriorSpam_UpdateIcons(Zorlen_WarriorSpam_IconIndex_SunderArmor, macro, test)
				else
					if test and ActiveEnemy and CID and castAttack(test) then
						Zorlen_WarriorSpam_UpdateIcons(Zorlen_WarriorSpam_IconIndex_Attack, macro, test)
						return
					end
					Zorlen_WarriorSpam_UpdateIcons(Zorlen_WarriorSpam_IconIndex_Idle, macro, test)
				end
			else
				if test and ActiveEnemy and CID and castAttack(test) then
					Zorlen_WarriorSpam_UpdateIcons(Zorlen_WarriorSpam_IconIndex_Attack, macro, test)
					return
				end
				Zorlen_WarriorSpam_UpdateIcons(Zorlen_WarriorSpam_IconIndex_Idle, macro, test)
			end
		else
			if test and ActiveEnemy and CID and castAttack(test) then
				Zorlen_WarriorSpam_UpdateIcons(Zorlen_WarriorSpam_IconIndex_Attack, macro, test)
				return
			end
			Zorlen_WarriorSpam_UpdateIcons(Zorlen_WarriorSpam_IconIndex_Idle, macro, test)
		end
	else
		if Zorlen_Button[LOCALIZATION_ZORLEN.Disarm] and (disarm == "yes") and not Zorlen_TargetIsDieingEnemy() and castDisarm(test) then
			--castDisarm()
			Zorlen_WarriorSpam_UpdateIcons(Zorlen_WarriorSpam_IconIndex_Disarm, macro, test)
		elseif Zorlen_Button[LOCALIZATION_ZORLEN.BattleShout] and castBattleShout(test) then
			--castBattleShout()
			Zorlen_WarriorSpam_UpdateIcons(Zorlen_WarriorSpam_IconIndex_BattleShout, macro, test)
		elseif Zorlen_Button[LOCALIZATION_ZORLEN.Rend] and (rend == "yes") and not Zorlen_TargetIsDieingEnemy() and castRend(test) then
			--castRend()
			Zorlen_WarriorSpam_UpdateIcons(Zorlen_WarriorSpam_IconIndex_Rend, macro, test)
		elseif Zorlen_Button[LOCALIZATION_ZORLEN.DemoralizingShout] and (demo == "yes") and not Zorlen_TargetIsDieingEnemy() and castDemoralizingShout(test) then
			--castDemoralizingShout()
			Zorlen_WarriorSpam_UpdateIcons(Zorlen_WarriorSpam_IconIndex_DemoralizingShout, macro, test)
		elseif
			Zorlen_Button[LOCALIZATION_ZORLEN.MortalStrike]
			 and 
			(
				(
					(isDefensiveStance() or not Zorlen_Button[LOCALIZATION_ZORLEN.Execute]) and PlayerMana >= 35
				)
				 or
				PlayerMana >= (30 + Zorlen_ExecuteRageCost())
			)
			 and
			castMortalStrike(test)
			then
			--castMortalStrike()
			Zorlen_WarriorSpam_UpdateIcons(Zorlen_WarriorSpam_IconIndex_MortalStrike, macro, test)
		elseif
			Zorlen_Button[LOCALIZATION_ZORLEN.Bloodthirst]
			 and 
			(
				(
					(isDefensiveStance() or not Zorlen_Button[LOCALIZATION_ZORLEN.Execute]) and PlayerMana >= 35
				)
				 or
				PlayerMana >= (30 + Zorlen_ExecuteRageCost())
			)
			 and
			castBloodthirst(test)
			then
			--castBloodthirst()
			Zorlen_WarriorSpam_UpdateIcons(Zorlen_WarriorSpam_IconIndex_Bloodthirst, macro, test)
		elseif
			Zorlen_Button[LOCALIZATION_ZORLEN.ShieldSlam]
			 and 
			(
				(
					(isDefensiveStance() or not Zorlen_Button[LOCALIZATION_ZORLEN.Execute]) and PlayerMana >= 25
				)
				 or
				PlayerMana >= (20 + Zorlen_ExecuteRageCost())
			)
			 and
			castShieldSlam(test)
			then
			--castShieldSlam()
			Zorlen_WarriorSpam_UpdateIcons(Zorlen_WarriorSpam_IconIndex_ShieldSlam, macro, test)
		elseif Zorlen_Button[LOCALIZATION_ZORLEN.ShieldBlock] and PlayerMana >= 35 and castShieldBlock(test) then
			--castShieldBlock()
			Zorlen_WarriorSpam_UpdateIcons(Zorlen_WarriorSpam_IconIndex_ShieldBlock, macro, test)
		elseif
			Zorlen_WarriorSpam_SwapFromBerserkerToDoAction and PlayerMana < 35
			 and
			(
				isBerserkerStance()
				 or
				not
				(
					(rend == "yes") and not isRend() and not Zorlen_IsTimer(LOCALIZATION_ZORLEN.Rend, "immune", "InternalZorlenMiscTimer")
				)
			)
			 and
			(
				not isBattleStance() or not Zorlen_IsTimer("TargetDodgedYou_Overpower", nil, "InternalZorlenMiscTimer")
			)
			 and
			(
				isDefensiveStance() or Zorlen_IsTimer(LOCALIZATION_ZORLEN.Hamstring, "immune", "InternalZorlenMiscTimer")
				 or
				(
					Zorlen_WasHamstringSpellCastImmune and not Zorlen_WasHamstring
				)
				 or
				not
				(
					not boss and not hamstrung
					 and
					(
						(pvp == "yes")
						 or
						(
							not ZorlenWarriorSpamConfig[ZPN][HAMSTRINGOFF] and ZorlenWarriorSpamConfig[ZPN][ALWAYSHAMSTRING] and UnitHealth("target") / UnitHealthMax("target") <= 0.5
						)
						 or
						(not ZorlenWarriorSpamConfig[ZPN][HAMSTRINGOFF] and Zorlen_TargetIsDieingEnemyWithNoTarget())
					)
				)
			)
			 and
			castBerserkerStance(test)
			then
			--castBerserkerStance()
			Zorlen_WarriorSpam_UpdateIcons(Zorlen_WarriorSpam_IconIndex_BerserkerStance, macro, test)
		elseif
			Zorlen_WarriorSpam_SwapFromDefensiveToDoAction and PlayerMana < 35
			 and
			(
				isBerserkerStance()
				 or
				not
				(
					(rend == "yes") and not isRend() and not Zorlen_IsTimer(LOCALIZATION_ZORLEN.Rend, "immune", "InternalZorlenMiscTimer")
				)
			)
			 and
			(
				not isBattleStance() or not Zorlen_IsTimer("TargetDodgedYou_Overpower", nil, "InternalZorlenMiscTimer")
			)
			 and
			(
				isDefensiveStance() or Zorlen_IsTimer(LOCALIZATION_ZORLEN.Hamstring, "immune", "InternalZorlenMiscTimer")
				 or
				(
					Zorlen_WasHamstringSpellCastImmune and not Zorlen_WasHamstring
				)
				 or
				not
				(
					not boss and not hamstrung
					 and
					(
						(pvp == "yes")
						 or
						(
							not ZorlenWarriorSpamConfig[ZPN][HAMSTRINGOFF] and ZorlenWarriorSpamConfig[ZPN][ALWAYSHAMSTRING] and UnitHealth("target") / UnitHealthMax("target") <= 0.5
						)
						 or
						(not ZorlenWarriorSpamConfig[ZPN][HAMSTRINGOFF] and Zorlen_TargetIsDieingEnemyWithNoTarget())
					)
				)
			)
			 and
			castDefensiveStance(test)
			then
			--castDefensiveStance()
			Zorlen_WarriorSpam_UpdateIcons(Zorlen_WarriorSpam_IconIndex_DefensiveStance, macro, test)
		elseif
			Zorlen_WarriorSpam_SwapFromBattleToDoAction  and PlayerMana < 35
			 and
			(
				isBerserkerStance()
				 or
				not
				(
					(rend == "yes") and not isRend() and not Zorlen_IsTimer(LOCALIZATION_ZORLEN.Rend, "immune", "InternalZorlenMiscTimer")
				)
			)
			 and
			(
				not isBattleStance() or not Zorlen_IsTimer("TargetDodgedYou_Overpower", nil, "InternalZorlenMiscTimer")
			)
			 and
			(
				isDefensiveStance() or Zorlen_IsTimer(LOCALIZATION_ZORLEN.Hamstring, "immune", "InternalZorlenMiscTimer")
				 or
				(
					Zorlen_WasHamstringSpellCastImmune and not Zorlen_WasHamstring
				)
				 or
				not
				(
					not boss and not hamstrung
					 and
					(
						(pvp == "yes")
						 or
						(
							not ZorlenWarriorSpamConfig[ZPN][HAMSTRINGOFF] and ZorlenWarriorSpamConfig[ZPN][ALWAYSHAMSTRING] and UnitHealth("target") / UnitHealthMax("target") <= 0.5
						)
						 or
						(not ZorlenWarriorSpamConfig[ZPN][HAMSTRINGOFF] and Zorlen_TargetIsDieingEnemyWithNoTarget())
					)
				)
			)
			 and
			castBattleStance(test)
			then
			--castBattleStance()
			Zorlen_WarriorSpam_UpdateIcons(Zorlen_WarriorSpam_IconIndex_BattleStance, macro, test)
		else
			if test and ActiveEnemy and CID and castAttack(test) then
				Zorlen_WarriorSpam_UpdateIcons(Zorlen_WarriorSpam_IconIndex_Attack, macro, test)
				return
			end
			Zorlen_WarriorSpam_UpdateIcons(Zorlen_WarriorSpam_IconIndex_Idle, macro, test)
		end
	end
end

function Zorlen_WarriorSpam_TestButtons()
	if not Zorlen_WarriorSpam_isCurrentClassWarrior then
		return
	end
	if not Zorlen_Button[LOCALIZATION_ZORLEN.Execute] then
		if Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN.Execute) then
			Zorlen_RegisterButtons()
			if not Zorlen_Button[LOCALIZATION_ZORLEN.Execute] then
				Zorlen_debug("You must put "..LOCALIZATION_ZORLEN.Execute.." on one of your action bars (even if it is hidden) for Zorlen WarriorSpam to work right!", 1);
				return
			end
		end
	end
	if not Zorlen_Button[LOCALIZATION_ZORLEN.HeroicStrike] then
		if Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN.HeroicStrike) then
			Zorlen_RegisterButtons()
			if not Zorlen_Button[LOCALIZATION_ZORLEN.HeroicStrike] then
				Zorlen_debug("You must put "..LOCALIZATION_ZORLEN.HeroicStrike.." on one of your action bars (even if it is hidden) for Zorlen WarriorSpam to work right!", 1);
				return
			end
		end
	end
	if not Zorlen_Button[LOCALIZATION_ZORLEN.SunderArmor] then
		if Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN.SunderArmor) then
			Zorlen_RegisterButtons()
			if not Zorlen_Button[LOCALIZATION_ZORLEN.SunderArmor] then
				Zorlen_debug("You must put "..LOCALIZATION_ZORLEN.SunderArmor.." on one of your action bars (even if it is hidden) for Zorlen WarriorSpam to work right!", 1);
				return
			end
		end
	end
	if not Zorlen_Button[LOCALIZATION_ZORLEN.MortalStrike] then
		if Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN.MortalStrike) then
			Zorlen_RegisterButtons()
			if not Zorlen_Button[LOCALIZATION_ZORLEN.MortalStrike] then
				Zorlen_debug("You must put "..LOCALIZATION_ZORLEN.MortalStrike.." on one of your action bars (even if it is hidden) for Zorlen WarriorSpam to work right!", 1);
				return
			end
		end
	end
	if not Zorlen_Button[LOCALIZATION_ZORLEN.Bloodthirst] then
		if Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN.Bloodthirst) then
			Zorlen_RegisterButtons()
			if not Zorlen_Button[LOCALIZATION_ZORLEN.Bloodthirst] then
				Zorlen_debug("You must put "..LOCALIZATION_ZORLEN.Bloodthirst.." on one of your action bars (even if it is hidden) for Zorlen WarriorSpam to work right!", 1);
				return
			end
		end
	end
	if not Zorlen_Button[LOCALIZATION_ZORLEN.ShieldSlam] then
		if Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN.ShieldSlam) then
			Zorlen_RegisterButtons()
			if not Zorlen_Button[LOCALIZATION_ZORLEN.ShieldSlam] then
				Zorlen_debug("You must put "..LOCALIZATION_ZORLEN.ShieldSlam.." on one of your action bars (even if it is hidden) for Zorlen WarriorSpam to work right!", 1);
				return
			end
		end
	end
	if not Zorlen_Button[LOCALIZATION_ZORLEN.Charge] then
		if Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN.Charge) then
			Zorlen_RegisterButtons()
			if not Zorlen_Button[LOCALIZATION_ZORLEN.Charge] then
				Zorlen_debug("You must put "..LOCALIZATION_ZORLEN.Charge.." on one of your action bars (even if it is hidden) for Zorlen WarriorSpam to work right!", 1);
				return
			end
		end
	end
	if not Zorlen_Button[LOCALIZATION_ZORLEN.Taunt] then
		if Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN.Taunt) then
			Zorlen_RegisterButtons()
			if not Zorlen_Button[LOCALIZATION_ZORLEN.Taunt] then
				Zorlen_debug("You must put "..LOCALIZATION_ZORLEN.Taunt.." on one of your action bars (even if it is hidden) for Zorlen WarriorSpam to work right!", 1);
				return
			end
		end
	end
	if not Zorlen_Button[LOCALIZATION_ZORLEN.Intercept] then
		if Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN.Intercept) then
			Zorlen_RegisterButtons()
			if not Zorlen_Button[LOCALIZATION_ZORLEN.Intercept] then
				Zorlen_debug("You must put "..LOCALIZATION_ZORLEN.Intercept.." on one of your action bars (even if it is hidden) for Zorlen WarriorSpam to work right!", 1);
				return
			end
		end
	end
	if not Zorlen_Button[LOCALIZATION_ZORLEN.Overpower] then
		if Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN.Overpower) then
			Zorlen_RegisterButtons()
			if not Zorlen_Button[LOCALIZATION_ZORLEN.Overpower] then
				Zorlen_debug("You must put "..LOCALIZATION_ZORLEN.Overpower.." on one of your action bars (even if it is hidden) for Zorlen WarriorSpam to work right!", 1);
				return
			end
		end
	end
	if not Zorlen_Button[LOCALIZATION_ZORLEN.Revenge] then
		if Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN.Revenge) then
			Zorlen_RegisterButtons()
			if not Zorlen_Button[LOCALIZATION_ZORLEN.Revenge] then
				Zorlen_debug("You must put "..LOCALIZATION_ZORLEN.Revenge.." on one of your action bars (even if it is hidden) for Zorlen WarriorSpam to work right!", 1);
				return
			end
		end
	end
	if not Zorlen_Button[LOCALIZATION_ZORLEN.Rend] then
		if Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN.Rend) then
			Zorlen_RegisterButtons()
			if not Zorlen_Button[LOCALIZATION_ZORLEN.Rend] then
				Zorlen_debug("You must put "..LOCALIZATION_ZORLEN.Rend.." on one of your action bars (even if it is hidden) for Zorlen WarriorSpam to work right!", 1);
				return
			end
		end
	end
	if not Zorlen_Button[LOCALIZATION_ZORLEN.Hamstring] then
		if Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN.Hamstring) then
			Zorlen_RegisterButtons()
			if not Zorlen_Button[LOCALIZATION_ZORLEN.Hamstring] then
				Zorlen_debug("You must put "..LOCALIZATION_ZORLEN.Hamstring.." on one of your action bars (even if it is hidden) for Zorlen WarriorSpam to work right!", 1);
				return
			end
		end
	end
	if not Zorlen_Button[LOCALIZATION_ZORLEN.ShieldBash] then
		if Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN.ShieldBash) then
			Zorlen_RegisterButtons()
			if not Zorlen_Button[LOCALIZATION_ZORLEN.ShieldBash] then
				Zorlen_debug("You must put "..LOCALIZATION_ZORLEN.ShieldBash.." on one of your action bars (even if it is hidden) for Zorlen WarriorSpam to work right!", 1);
				return
			end
		end
	end
	if not Zorlen_Button[LOCALIZATION_ZORLEN.Pummel] then
		if Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN.Pummel) then
			Zorlen_RegisterButtons()
			if not Zorlen_Button[LOCALIZATION_ZORLEN.Pummel] then
				Zorlen_debug("You must put "..LOCALIZATION_ZORLEN.Pummel.." on one of your action bars (even if it is hidden) for Zorlen WarriorSpam to work right!", 1);
				return
			end
		end
	end
	if not Zorlen_Button[LOCALIZATION_ZORLEN.ShieldBlock] then
		if Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN.ShieldBlock) then
			Zorlen_RegisterButtons()
			if not Zorlen_Button[LOCALIZATION_ZORLEN.ShieldBlock] then
				Zorlen_debug("You must put "..LOCALIZATION_ZORLEN.ShieldBlock.." on one of your action bars (even if it is hidden) for Zorlen WarriorSpam to work right!", 1);
				return
			end
		end
	end
	if not Zorlen_Button[LOCALIZATION_ZORLEN.DemoralizingShout] then
		if Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN.DemoralizingShout) then
			Zorlen_RegisterButtons()
			if not Zorlen_Button[LOCALIZATION_ZORLEN.DemoralizingShout] then
				Zorlen_debug("You must put "..LOCALIZATION_ZORLEN.DemoralizingShout.." on one of your action bars (even if it is hidden) for Zorlen WarriorSpam to work right!", 1);
				return
			end
		end
	end
	if not Zorlen_Button[LOCALIZATION_ZORLEN.BattleShout] then
		if Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN.BattleShout) then
			Zorlen_RegisterButtons()
			if not Zorlen_Button[LOCALIZATION_ZORLEN.BattleShout] then
				Zorlen_debug("You must put "..LOCALIZATION_ZORLEN.BattleShout.." on one of your action bars (even if it is hidden) for Zorlen WarriorSpam to work right!", 1);
				return
			end
		end
	end
	if not Zorlen_Button[LOCALIZATION_ZORLEN.BerserkerRage] then
		if Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN.BerserkerRage) then
			Zorlen_RegisterButtons()
			if not Zorlen_Button[LOCALIZATION_ZORLEN.BerserkerRage] then
				Zorlen_debug("You must put "..LOCALIZATION_ZORLEN.BerserkerRage.." on one of your action bars (even if it is hidden) for Zorlen WarriorSpam to work right!", 1);
				return
			end
		end
	end
	if not Zorlen_Button[LOCALIZATION_ZORLEN.Bloodrage] then
		if Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN.Bloodrage) then
			Zorlen_RegisterButtons()
			if not Zorlen_Button[LOCALIZATION_ZORLEN.Bloodrage] then
				Zorlen_debug("You must put "..LOCALIZATION_ZORLEN.Bloodrage.." on one of your action bars (even if it is hidden) for Zorlen WarriorSpam to work right!", 1);
				return
			end
		end
	end
	if not Zorlen_Button[LOCALIZATION_ZORLEN.DeathWish] then
		if Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN.DeathWish) then
			Zorlen_RegisterButtons()
			if not Zorlen_Button[LOCALIZATION_ZORLEN.DeathWish] then
				Zorlen_debug("You must put "..LOCALIZATION_ZORLEN.DeathWish.." on one of your action bars (even if it is hidden) for Zorlen WarriorSpam to work right!", 1);
				return
			end
		end
	end
	if not Zorlen_Button[LOCALIZATION_ZORLEN.MockingBlow] then
		if Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN.MockingBlow) then
			Zorlen_RegisterButtons()
			if not Zorlen_Button[LOCALIZATION_ZORLEN.MockingBlow] then
				Zorlen_debug("You must put "..LOCALIZATION_ZORLEN.MockingBlow.." on one of your action bars (even if it is hidden) for Zorlen WarriorSpam to work right!", 1);
				return
			end
		end
	end
	if not Zorlen_Button[LOCALIZATION_ZORLEN.Disarm] then
		if Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN.Disarm) then
			Zorlen_RegisterButtons()
			if not Zorlen_Button[LOCALIZATION_ZORLEN.Disarm] then
				Zorlen_debug("You must put "..LOCALIZATION_ZORLEN.Disarm.." on one of your action bars (even if it is hidden) for Zorlen WarriorSpam to work right!", 1);
				return
			end
		end
	end
	if not Zorlen_Button[LOCALIZATION_ZORLEN.ConcussionBlow] then
		if Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN.ConcussionBlow) then
			Zorlen_RegisterButtons()
			if not Zorlen_Button[LOCALIZATION_ZORLEN.ConcussionBlow] then
				Zorlen_debug("You must put "..LOCALIZATION_ZORLEN.ConcussionBlow.." on one of your action bars (even if it is hidden) for Zorlen WarriorSpam to work right!", 1);
				return
			end
		end
	end
	if not Zorlen_Button[LOCALIZATION_ZORLEN.Attack] then
		Zorlen_RegisterButtons()
		if not Zorlen_Button[LOCALIZATION_ZORLEN.Attack] then
			Zorlen_debug("You must put "..LOCALIZATION_ZORLEN.Attack.." on one of your action bars (even if it is hidden) for Zorlen WarriorSpam to work right!", 1);
			return
		end
	end
end


function Zorlen_WarriorSpam_MakeMacros(show, replace, nocreate)
	if not Zorlen_WarriorSpam_isCurrentClassWarrior then
		return
	end
	Zorlen_WarriorSpam_MakeDPSMacro(show, replace, nocreate)
	Zorlen_WarriorSpam_MakeHateBuilderMacro(show, replace, nocreate)
	Zorlen_WarriorSpam_MakeTankingMacro(show, replace, nocreate)
	Zorlen_WarriorSpam_MakeOffTankingMacro(show, replace, nocreate)
	Zorlen_WarriorSpam_MakeGrindMacro(show, replace, nocreate)
end


function Zorlen_WarriorSpam_MakeDPSMacro(show, replace, nocreate)
	if not Zorlen_WarriorSpam_isCurrentClassWarrior then
		return
	end
	return Zorlen_MakeMacro("ZWS DPS", "/script Zorlen_WarriorSpam_WithRendAndDemoShout(nil, \"ZWS DPS\")", 1, "Ability_Warrior_OffensiveStance", nil, replace, show, nocreate)
end

function Zorlen_WarriorSpam_MakeGrindMacro(show, replace, nocreate)
	if not Zorlen_WarriorSpam_isCurrentClassWarrior then
		return
	end
	return Zorlen_MakeMacro("ZWS Grind", "/script Zorlen_WarriorSpam_WithRendAndDemoShout(\"targetforcecharge\", \"ZWS Grind\")", 1, "Ability_BackStab", nil, replace, show, nocreate)
end

function Zorlen_WarriorSpam_MakeHateBuilderMacro(show, replace, nocreate)
	if not Zorlen_WarriorSpam_isCurrentClassWarrior then
		return
	end
	return Zorlen_MakeMacro("ZWS HateBuilder", "/script Zorlen_WarriorSpam_HateBuilder(nil, \"ZWS HateBuilder\")", 1, "Ability_Creature_Cursed_02", nil, replace, show, nocreate)
end

function Zorlen_WarriorSpam_MakeTankingMacro(show, replace, nocreate)
	if not Zorlen_WarriorSpam_isCurrentClassWarrior then
		return
	end
	return Zorlen_MakeMacro("ZWS Tanking", "/script Zorlen_WarriorSpam_Tanking(nil, \"ZWS Tanking\")", 1, "Ability_Warrior_DefensiveStance", nil, replace, show, nocreate)
end

function Zorlen_WarriorSpam_MakeOffTankingMacro(show, replace, nocreate)
	if not Zorlen_WarriorSpam_isCurrentClassWarrior then
		return
	end
	return Zorlen_MakeMacro("ZWS Off Tanking", "/script Zorlen_WarriorSpam_OffTankingWithRendAndDemoShout(nil, \"ZWS Off Tanking\")", 1, "Spell_Magic_MageArmor", nil, replace, show, nocreate)
end




function Zorlen_WarriorSpam_UpdateIcons(iconslot, macro, test)
	if not Zorlen_WarriorSpam_isCurrentClassWarrior then
		return
	end
	if macro and not ZorlenWarriorSpamConfig[ZPN][MACROICONSOFF] then
		if not test then
			if ZorlenWarriorSpamConfig[ZPN][MACROUPDATENAME] == "ZWS DPS" and macro ~= "ZWS DPS" then
				Zorlen_EditMacro("ZWS DPS", nil, "Ability_Warrior_OffensiveStance", nil, 0)
			elseif ZorlenWarriorSpamConfig[ZPN][MACROUPDATENAME] == "ZWS Grind" and macro ~= "ZWS Grind" then
				Zorlen_EditMacro("ZWS Grind", nil, "Ability_BackStab", nil, 0)
			elseif ZorlenWarriorSpamConfig[ZPN][MACROUPDATENAME] == "ZWS HateBuilder" and macro ~= "ZWS HateBuilder" then
				Zorlen_EditMacro("ZWS HateBuilder", nil, "Ability_Creature_Cursed_02", nil, 0)
			elseif ZorlenWarriorSpamConfig[ZPN][MACROUPDATENAME] == "ZWS Tanking" and macro ~= "ZWS Tanking" then
				Zorlen_EditMacro("ZWS Tanking", nil, "Ability_Warrior_DefensiveStance", nil, 0)
			elseif ZorlenWarriorSpamConfig[ZPN][MACROUPDATENAME] == "ZWS Off Tanking" and macro ~= "ZWS Off Tanking" then
				Zorlen_EditMacro("ZWS Off Tanking", nil, "Spell_Magic_MageArmor", nil, 0)
			end
			ZorlenWarriorSpamConfig[ZPN][MACROUPDATENAME] = macro
			ZorlenWarriorSpamFrame.RefreshIcons_timer = 0.2
		end
		if Zorlen_Button["Macro.ZWS DPS"] and ZorlenWarriorSpamConfig[ZPN][MACROUPDATENAME] == "ZWS DPS" then
			Zorlen_EditMacro("ZWS DPS", nil, nil, iconslot, 0)
		elseif Zorlen_Button["Macro.ZWS Grind"] and ZorlenWarriorSpamConfig[ZPN][MACROUPDATENAME] == "ZWS Grind" then
			Zorlen_EditMacro("ZWS Grind", nil, nil, iconslot, 0)
		elseif Zorlen_Button["Macro.ZWS HateBuilder"] and ZorlenWarriorSpamConfig[ZPN][MACROUPDATENAME] == "ZWS HateBuilder" then
			Zorlen_EditMacro("ZWS HateBuilder", nil, nil, iconslot, 0)
		elseif Zorlen_Button["Macro.ZWS Tanking"] and ZorlenWarriorSpamConfig[ZPN][MACROUPDATENAME] == "ZWS Tanking" then
			Zorlen_EditMacro("ZWS Tanking", nil, nil, iconslot, 0)
		elseif Zorlen_Button["Macro.ZWS Off Tanking"] and ZorlenWarriorSpamConfig[ZPN][MACROUPDATENAME] == "ZWS Off Tanking" then
			Zorlen_EditMacro("ZWS Off Tanking", nil, nil, iconslot, 0)
		end
	end
end




function Zorlen_WarriorSpam_UpdateMacro()
	if not Zorlen_WarriorSpam_isCurrentClassWarrior then
		return
	end
	if Zorlen_Button["Macro.ZWS DPS"] and ZorlenWarriorSpamConfig[ZPN][MACROUPDATENAME] == "ZWS DPS" then
		return Zorlen_WarriorSpam_WithRendAndDemoShout(nil, "ZWS DPS", 1)
	elseif Zorlen_Button["Macro.ZWS Grind"] and ZorlenWarriorSpamConfig[ZPN][MACROUPDATENAME] == "ZWS Grind" then
		return Zorlen_WarriorSpam_WithRendAndDemoShout("targetforcecharge", "ZWS Grind", 1)
	elseif Zorlen_Button["Macro.ZWS HateBuilder"] and ZorlenWarriorSpamConfig[ZPN][MACROUPDATENAME] == "ZWS HateBuilder" then
		return Zorlen_WarriorSpam_HateBuilder(nil, "ZWS HateBuilder", 1)
	elseif Zorlen_Button["Macro.ZWS Tanking"] and ZorlenWarriorSpamConfig[ZPN][MACROUPDATENAME] == "ZWS Tanking" then
		return Zorlen_WarriorSpam_TankingWithRendAndDemoShout(nil, "ZWS Tanking", 1)
	elseif Zorlen_Button["Macro.ZWS Off Tanking"] and ZorlenWarriorSpamConfig[ZPN][MACROUPDATENAME] == "ZWS Off Tanking" then
		return Zorlen_WarriorSpam_OffTankingWithRendAndDemoShout(nil, "ZWS Off Tanking", 1)
	end
end




--[[
Shammy Buff
By: kneeki of Kil'Jaeden - geekbocks@yahoo.com
Compatable with patch: 1.11

FEATURE LIST:
Use a single keybind to:
Cast Nature's Swiftness and Big heal if needed
If debuffed w/ poison/disease use Decursive
Cast Lightning Shield
Cast Weapon buff of user choice
Cast Troll racial 'Beserking'... If a troll
Cast Lesser Healing Wave.

COMMAND LIST:
/sbuff - launch config
/sbuff wep name - replace 'name' with one of the 4 weapon buffs. Windfury, Frostbrand, Flametongue, Rockbiter
/sbuff cast - Used in a macro to cast buffs instead of using a keybinding
/sbuff reset - break something? use this to reset all values
/sbuff debug - spams your main window with all the current casting flags
/sbuff help - this help menu
    
---- version 3.5 ----
Fixed:
Fixed the issue with options resetting for no reason on load. (really this time)

---- Bugs ----
If a troll and activating troll beserking while SPAM clicking the button, you will get a stack overflow error.
]]

SBVAR = {}
SB_UpdateInterval = 1.0

function SB_OnLoad()
    this:RegisterEvent("ADDON_LOADED") 
	if SB_ShammyCheck() then
        if (CT_RegisterMod) then CT_RegisterMod(SBCT_Name, nil, 5, SBCT_Icon, SBCT_Description, "switch", nil, SB_FrameToggle) end

		SlashCmdList["SBUFF"] = SB_ChatCommandHandler
		SLASH_SBUFF1 = "/sbuff"
		SLASH_SBUFF2 = "/shammybuff"
	
		SB_ChatMsg("".. SB_Welcome)
    else
        SB_ChatMsg("".. SB_NotWelcome)
	end
end

function SB_OnEvent(event, arg1)
    if ((event == "ADDON_LOADED") and (arg1 == "ShammyBuff")) then
        SBMessageFrame:ClearAllPoints(); SBMessageFrame:SetPoint("CENTER", "UIParent", "CENTER", 0, SBVAR["SliderValue"])
        SB_VarCheck = false
        -- Misc
        if SBVAR["DebuffToggle"] == nil then SB_VarCheck = true
		elseif SBVAR["minmana"] == nil then SB_VarCheck = true
		elseif SBVAR["minhealth"]==nil then SB_VarCheck = true
		elseif SBVAR["ListOrder"]==nil then SB_VarCheck = true
		elseif SBVAR["NSHeal"]==nil then SB_VarCheck = true
		elseif SBVAR["NSHealValue"]==nil then SB_VarCheck = true
        elseif SBVAR["LazyAssNamsar"] == nil then SB_VarCheck = true
        elseif SBVAR["HealthThreshold"] == nil then SB_VarCheck = true
        -- Weapon Stuff
		elseif SBVAR["WeaponBuff"] == nil then SB_VarCheck = true
		elseif SBVAR["WeaponBuffTog"] == nil then SB_VarCheck = true
		elseif SBVAR["WeaponSpellName"]== nil then SB_VarCheck = true
        -- Buff Stuff
		elseif SBVAR["AutoLSCast"]==nil then SB_VarCheck = true
        elseif SBVAR["DebuffToggle"] == nil then SB_VarCheck = true
		elseif SBVAR["BezerkHealValue"]==nil then SB_VarCheck = true
        -- Messages
        elseif SBVAR["LSMessage"] == nil then SB_VarCheck = true
        elseif SBVAR["BeserkMsg"] == nil then SB_VarCheck = true
        elseif SBVAR["WepMessage"] == nil then SB_VarCheck = true
        elseif SBVAR["NSMsg"] == nil then SB_VarCheck = true
        elseif SBVAR["BeserkMsg"] == nil then SB_VarCheck = true
        elseif SBVAR["PlaySounds"] == nil then SB_VarCheck = true
        elseif SBVAR["SliderValue"] == nil then SB_VarCheck = true
        elseif SBVAR["City"] == nil then SB_VarCheck = true
        end
        
        if (SB_VarCheck == true) then
            SB_VarCheck = false
            SB_ChatMsg("".. SB_VarError)
            SB_Reset()
        end
    end
end

function SB_OnUpdate()
    local time,Continue,enoughhealth,enoughmana,CityStop = GetTime(),false,false,false,false
    if ignoreTime == nil then ignoreTime = GetTime() + 10 end
    if GetTime() > ignoreTime then
        SoundAlerted = false
    end
    if (SBVAR["City"] == 1) then
        local zoneText = GetZoneText()
        if ((zoneText == SB_UC) or (zoneText == SB_Org) or (zoneText == SB_Thu)) then CityStop = true end
    end
    
    if (SB_ShammyCheck() and not UnitOnTaxi("player") and not UnitIsDeadOrGhost("player") and SB_TravelCheck() and not SB_FishingCheck() and not CityStop) then
		if (not this.TimeOfNextUpdate or (time > this.TimeOfNextUpdate)) then
			if LastMsgTime==nil then LastMsgTime = GetTime() end
            
            -- #### Health/Mana checks
            if SBVAR["HealthThreshold"] == 1 then
		        if (SB_ManaCheck() >= tonumber(SBVAR["minmana"]) ) then enoughmana = true end
		        if (SB_HealthCheck() >= tonumber(SBVAR["minhealth"]) ) then enoughhealth = true end
                if enoughhealth and enoughmana then Continue = true end
            elseif SBVAR["HealthThreshold"] == 0 then
                Continue = true
            end
            
            -- #### NS Heal Message
            if not SB_NSTime then SB_NSTime = GetTime() end
			if ((SB_HealthCheck() < tonumber(SBVAR["NSHealValue"]) and SB_HealthCheck() >= 1) and (time > SB_NSTime)) then
				if SBVAR["NSMsg"] == 1 then
                    SB_FrameMsg("".. SB_NSNOW)
                    if ((not SoundAlerted) and (SBVAR["PlaySounds"] == 1)) then
                        PlaySound("igQuestFailed")
                        SoundAlerted = true
                        ignoreTime = GetTime() + 10
                    end
				end
			end

            -- #### Curable Buffs
            if ((SBVAR["DebuffMsg"] == 1) and UnitDebuff("player", 1, 1) and Continue) then
                SB_FrameMsg("".. SB_DebuffMsg)
                if ((not SoundAlerted) and (SBVAR["PlaySounds"] == 1)) then
                    PlaySound("igQuestFailed")
                    SoundAlerted = true
                    ignoreTime = GetTime() + 10
                end
            end

            -- #### Lightning Shield
			if (not SBuff_IsBuffActive(SB_LS) and Continue) then
                if (SBVAR["LSMessage"] == 1) then
                    SB_FrameMsg("".. SB_RecastLS)
                    if ((not SoundAlerted) and (SBVAR["PlaySounds"] == 1)) then
                        PlaySound("igQuestFailed")
                        SoundAlerted = true
                        ignoreTime = GetTime() + 10
                    end
                end
			end

            -- #### Weapon Buffs
            if (GetWeaponEnchantInfo(hasMainHandEnchant)==nil and GetInventoryItemQuality("player", 16) and Continue) then
                if GetInventoryItemQuality("player", 16) then
			        local mainHandLink = GetInventoryItemLink("player",GetInventorySlotInfo("MainHandSlot"))
			        local _, _, itemCode = strfind(mainHandLink, "(%d+):")
			        local _, _, _, _, _, itemType = GetItemInfo(itemCode)
			        if itemType == "Fishing Pole" then FishingPole = true end
                end
                if (not FishingPole and SBVAR["WepMessage"] == 1) then
                    SB_FrameMsg("".. SB_RecastWep)
                    if ((not SoundAlerted) and (SBVAR["PlaySounds"] == 1)) then
                        PlaySound("igQuestFailed")
                        SoundAlerted = true
                        ignoreTime = GetTime() + 10
                    end
                end
            end

            -- #### Beserking Message
            if not SB_BesTime then SB_BesTime = GetTime() end
			if ((SB_HealthCheck() < tonumber(SBVAR["BezerkHealValue"]) and SB_HealthCheck() >= 1) and (time > SB_BesTime) and SB_RaceCheck()) then
                if SBVAR["BeserkMsg"] == 1 then SB_FrameMsg("".. SB_BezNOW) end
                if ((not SoundAlerted) and (SBVAR["PlaySounds"] == 1)) then
                    PlaySound("igQuestFailed")
                    SoundAlerted = true
                    ignoreTime = GetTime() + 10
                end
			end
            
            -- #### Updates
			this.TimeOfNextUpdate = time + SB_UpdateInterval;
		end
	else
		local time = GetTime(); -- Just do something.
	end
end

--#############################################################
--########################################### COMMAND MISC
--#############################################################

function SB_ChatCommandHandler(msg)
	argv = {};
	for arg in string.gfind(string.lower(msg), '[%a%d%-%.]+') do
		table.insert(argv, arg);
	end
	if (argv[1] == nil) then SB_FrameToggle()
	elseif (argv[1] == SB_HelpCom) then SB_Help()
	elseif (argv[1] == SB_ResetCom) then SB_Reset()
	elseif (argv[1] == SB_DebugCom) then SB_Debug()
	elseif (argv[1] == SB_CastCom) then SB_Check()
	elseif (argv[1] == "wep" and argv[2] == SB_Windfury) then SBVAR["WeaponBuff"] = 1; SB_ChatMsg("".. SB_AutoBuff .. argv[2] .. SB_Weapon)
	elseif (argv[1] == "wep" and argv[2] == SB_Rockbiter) then SBVAR["WeaponBuff"] = 2; SB_ChatMsg("".. SB_AutoBuff .. argv[2] .. SB_Weapon)
	elseif (argv[1] == "wep" and argv[2] == SB_Flametongue) then SBVAR["WeaponBuff"] = 3; SB_ChatMsg("".. SB_AutoBuff .. argv[2] .. SB_Weapon)
	elseif (argv[1] == "wep" and argv[2] == SB_Frostbrand) then SBVAR["WeaponBuff"] = 4; SB_ChatMsg("".. SB_AutoBuff .. argv[2] .. SB_Weapon)
	else SB_ChatMsg("".. SB_Invalid .. argv[1])
	end
end

function SB_Reset()
-- Messages
    SBVAR["MCR"] = 1.0
    SBVAR["MCG"] = 0
    SBVAR["MCB"] = 0
    SBVAR["LSMessage"] = 1
    if SB_RaceCheck() then SBVAR["BeserkMsg"] = 1 else SBVAR["BeserkMsg"] = 0 end
    SBVAR["WepMessage"] = 1
    SBVAR["DebuffMsg"] = 0
    SBVAR["NSMsg"] = 0
    SBVAR["PlaySounds"] = 1
    SBVAR["City"] = 1
-- Misc
	SBVAR["minmana"] = 40
	SBVAR["minhealth"] = 40
    SBVAR["NSHeal"] = 0
    nameTalent, icon, tier, column, currRank, maxRank= GetTalentInfo(3,12)
    if (currRank == 1) then SBVAR["NSHeal"] = 1 end    
    SBVAR["NSHealValue"] = 25
    SBVAR["LazyAssNamsar"] = 0
    SBVAR["HealthThreshold"] = 1
    SBVAR["SliderValue"] = 0
-- Weapons
	SBVAR["WeaponBuff"] = 1
	SBVAR["WeaponBuffTog"] = 1
	SBVAR["WeaponSpellName"] = SB_WindWep
-- Buff stuff
	SBVAR["AutoLSCast"] = 1
	SBVAR["ListOrder"] = 1
    SBVAR["BezerkHealValue"] = 40
    if (Dcr_Saved) then SBVAR["DebuffToggle"] = 1; SBVAR["DebuffMsg"] = 1 else SBVAR["DebuffToggle"] = 0; SBVAR["DebuffMsg"] = 1 end
    if SB_RaceCheck() then SBVAR["TrollBezerk"] = 1 else SBVAR["TrollBezerk"] = 0 end

	SB_ChatMsg("".. SB_ResetCom2)
end

function SB_Help()
	SB_ChatMsg("".. SB_Help1)
    SB_ChatMsg("".. SB_Help2)
    SB_ChatMsg("".. SB_Help3)
    SB_ChatMsg("".. SB_Help4)
    SB_ChatMsg("".. SB_Help5)
    SB_ChatMsg("".. SB_Help6)
    SB_ChatMsg("".. SB_Help7)
end

--#############################################################
--########################################### Misc Stuff
--#############################################################

function SB_FishingCheck()
    if GetInventoryItemQuality("player", 16) then
        local mainHandLink = GetInventoryItemLink("player",GetInventorySlotInfo("MainHandSlot"))
        local _, _, itemCode = strfind(mainHandLink, "(%d+):")
        local _, _, _, _, _, itemType = GetItemInfo(itemCode)
        if (itemType == SB_Fish) then return true else return false end
    end
end

function SB_TravelCheck()
    local sb_go = true
    for i=1,40 do
        buff = UnitBuff("player",i)
        if buff and string.find(buff,"Mount_") then sb_go = false end
    end
    if SBuff_IsBuffActive("".. SB_GhostWolf) then sb_go = false end
    if (sb_go == true) then return true end
end

function SB_ShammyCheck()
    local playerClass, englishClass = UnitClass("player")
	if englishClass == "SHAMAN" then return true
    else return false
    end
end

function SB_HealthCheck()
    return ((UnitHealth("player") / UnitHealthMax("player"))*100)
end

function SB_ManaCheck()
    return ((UnitMana("player") / UnitManaMax("player"))*100)
end

function SB_RaceCheck()
    local _, raceEn = UnitRace("player")
    if raceEn == "Troll" then return true
    else return false
    end
end

--#############################################################
--########################################### Messages
--#############################################################

function SB_ChatMsg(msg)
	if(DEFAULT_CHAT_FRAME) then
		DEFAULT_CHAT_FRAME:AddMessage("|cffffd200SB:|cffffff00 " .. msg );
	end
end

function SB_FrameMsg(msg)
	if SBMessageFrame then
		SBMessageFrame:AddMessage("" ..  msg, SBVAR["MCR"], SBVAR["MCG"], SBVAR["MCB"], 1.0, .5);
	end
end

--#############################################################
--########################################### The below code is credit to Tyndral [root@brokengod.net] for the mod IsBuffActive
--########################################### All I did was rename IsBuffActiveTooltip to SBuff_IsBuffActiveTooltip to reduce confict errors.
--#############################################################

function SBuff_IsBuffActive(buffname, unit)
	SBuff_IsBuffActiveTooltip:SetOwner(UIParent, "ANCHOR_NONE");
	if (not buffname) then
		return;
	end;
	if (not unit) then
		unit="player";
	end;
	if string.lower(unit) == "mainhand" then
		SBuff_IsBuffActiveTooltip:ClearLines();
		SBuff_IsBuffActiveTooltip:SetInventoryItem("player",GetInventorySlotInfo("MainHandSlot"));
		for i = 1,SBuff_IsBuffActiveTooltip:NumLines() do
			if string.find((getglobal("SBuff_IsBuffActiveTooltipTextLeft"..i):GetText() or ""),buffname) then
				return true
			end;
		end
		return false
	end
	if string.lower(unit) == "offhand" then
		SBuff_IsBuffActiveTooltip:ClearLines();
		SBuff_IsBuffActiveTooltip:SetInventoryItem("player",GetInventorySlotInfo("SecondaryHandSlot"));
		for i=1,SBuff_IsBuffActiveTooltip:NumLines() do
			if string.find((getglobal("SBuff_IsBuffActiveTooltipTextLeft"..i):GetText() or ""),buffname) then
				return true
			end;
		end
		return false
	end
  local i = 1;
  while UnitBuff(unit, i) do 
		SBuff_IsBuffActiveTooltip:ClearLines();
		SBuff_IsBuffActiveTooltip:SetUnitBuff(unit,i);
    if string.find(SBuff_IsBuffActiveTooltipTextLeft1:GetText() or "", buffname) then
      return true, i
    end;
    i = i + 1;
  end;
  local i = 1;
  while UnitDebuff(unit, i) do 
		SBuff_IsBuffActiveTooltip:ClearLines();
		SBuff_IsBuffActiveTooltip:SetUnitDebuff(unit,i);
    if string.find(SBuff_IsBuffActiveTooltipTextLeft1:GetText() or "", buffname) then
      return true, i
    end;
    i = i + 1;
  end;
end
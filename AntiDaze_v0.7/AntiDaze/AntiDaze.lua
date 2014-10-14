--------------------------------------------------
--
--  AddOn: AntiDaze
--  Date: 06.04.2006
--  Author: Qsek
--  Contact: qsek@111.com
--
--------------------------------------------------

AD_VERSION = "v0.7";
AD_TITLE = "AntiDaze";
AD_SUBTITLE = "Prevent multiple Dazing";
AD_DESC = "Cancel Cheetah when active and dazed";
AD_VERS_TITLE = AD_TITLE.." "..AD_VERSION;

BINDING_HEADER_AD_TITLE = AD_TITLE;
BINDING_NAME_AD_TOGGLE = "Toggle "..AD_TITLE;
BINDING_NAME_AD_TOGGLE_OPTIONS = "Toggle Options";
BINDING_NAME_AD_MANUAL = "Cancel Cheetah/Pack"

BINDING_HEADER_AD_OPTIONS_TITLE = AD_TITLE;

AD_TEXT_AURA = string.gsub(AURAADDEDOTHERHARMFUL,'%%s','(.+)')

function AD_OnLoad()
  local _,class = UnitClass("player"); 		
	if (class == "HUNTER") then

    this:RegisterEvent("VARIABLES_LOADED");

    this:RegisterEvent("UNIT_AURA"); -- Triggers when Player becomes Buff

    this:RegisterEvent("PLAYER_AURAS_CHANGED");

    DEFAULT_CHAT_FRAME:AddMessage(AD_VERS_TITLE.." loaded.", 1, 1, 0.5);
	else
    DEFAULT_CHAT_FRAME:AddMessage(AD_VERS_TITLE.." not loaded: Player is not a Hunter.", 1, 1, 0.5);
  end
  SLASH_AD1 = "/AD";
  SLASH_AD2 = "/antidaze";

  SlashCmdList["AD"] = function(msg)
    AD_SlashCommand(msg);
  end
end

function AD_OnEvent()
	if (IsMounted) and UnitIsMounted("player") then
		--do nothing
	else
		if (event == "UNIT_AURA") then 
			if ADOptions.ADtoggle == 1 then 
				if  ADOptions.ADCCheet == 1 and arg1 == "player" and PlayerBuff("Spell_Frost_Stun") and isCheetahActive() then 
					CPlayerBuff("JungleTiger")
				end
				if  ADOptions.ADCPack == 1 and arg1 == "player" and PlayerBuff("Spell_Frost_Stun") and isPackActive() then 
					CPlayerBuff("WhiteTiger")
				end
				if  ADOptions.ADCPack == 1 and (string.find(arg1,"party%d")) and TargetBuff("Spell_Frost_Stun",arg1) and isPackActive() then 
					CPlayerBuff("WhiteTiger")
				end
				if  ADOptions.ADCPackPets == 1 and (string.find(arg1,"pet")) and TargetBuff("Spell_Frost_Stun",arg1) and isPackActive() then 
					CPlayerBuff("WhiteTiger")
				end
			end
		end
	end

	if(event == "VARIABLES_LOADED") then

		ADOptions_Init();

		---------------------
		-- support for Cosmos
		---------------------
		if(Cosmos_RegisterButton) then
			Cosmos_RegisterButton(
				AD_VERS_TITLE,
				AD_SUBTITLE,
				AD_DESC,
				"Interface\\Icons\\Ability_Mount_JungleTiger",
				ADOptions_Toggle);
		end

		-----------------------
		-- support for myAddOns
		-----------------------
 		if(myAddOnsFrame) then
			myAddOnsList.AD = {
				name = AD_TITLE,
				description = AD_DESC,
				version = AD_VERSION,
				category = MYADDONS_CATEGORY_COMBAT,
        frame = "AntiDazeFrame",
				optionsframe = 'AntiDazeOptionsFrame'};
		end
	end
end

function AD_SlashCommand(msg)
  local _,class = UnitClass("player"); 		
	if (class == "HUNTER") then
    if(msg == "toggle") then
      AD_Toggle();
    elseif (msg == "ccheet") then
      ADCCheet_Toogle()
    elseif (msg == "cpack") then
      ADCPack_Toogle()
    elseif (msg == "cpackpets") then
      ADCPackPets_Toogle()
    elseif (msg == "options") then
      ADOptions_Toggle();
    else
      if ( DEFAULT_CHAT_FRAME ) then
        DEFAULT_CHAT_FRAME:AddMessage(AD_VERS_TITLE, 1, 1, 0.5);
        DEFAULT_CHAT_FRAME:AddMessage("Syntax: /ad [command] or /antidaze [command]", 1, 1, 0.5);
        DEFAULT_CHAT_FRAME:AddMessage("toggle     ---   Toggles Canceling of all Aspects", 1, 1, 0.5);
        DEFAULT_CHAT_FRAME:AddMessage("ccheet     ---   Toggles Canceling Cheetah when Dazed", 1, 1, 0.5);
        DEFAULT_CHAT_FRAME:AddMessage("cpack      ---   Toggles Canceling Pack when Party is Dazed", 1, 1, 0.5);
        DEFAULT_CHAT_FRAME:AddMessage("cpackpets  ---   Toggles Canceling Pack when your or a Party Pet is Dazed", 1, 1, 0.5);
        DEFAULT_CHAT_FRAME:AddMessage("options    ---   Toggles Options Frame", 1, 1, 0.5);
      end
    end
    ADOptions_Init();
  else
    DEFAULT_CHAT_FRAME:AddMessage(AD_VERS_TITLE.." not loaded: Player is not a Hunter.", 1, 1, 0.5);
  end
end

function AD_Toggle()
	if(ADOptions.ADtoggle == 1) then
    ADOptions.ADtoggle = 0;
    if ( DEFAULT_CHAT_FRAME ) then
      DEFAULT_CHAT_FRAME:AddMessage("AntiDaze off", 1, 1, 0.5);
    end
	else
		ADOptions.ADtoggle = 1
    if ( DEFAULT_CHAT_FRAME ) then
      DEFAULT_CHAT_FRAME:AddMessage("AntiDaze on", 1, 1, 0.5);
    end
	end
end

function ADCCheet_Toogle()
	if(ADOptions.ADCCheet == 1) then
		ADOptions.ADCCheet = 0;
    if ( DEFAULT_CHAT_FRAME ) then
      DEFAULT_CHAT_FRAME:AddMessage("AntiDaze: Cancel Cheetah off", 1, 1, 0.5);
    end
	else
		ADOptions.ADCCheet = 1
    if ( DEFAULT_CHAT_FRAME ) then
      DEFAULT_CHAT_FRAME:AddMessage("AntiDaze: Cancel Cheetah on", 1, 1, 0.5);
    end
	end
end

function ADCPack_Toogle()
	if(ADOptions.ADCPack == 1) then
		ADOptions.ADCPack = 0;
    if ( DEFAULT_CHAT_FRAME ) then
      DEFAULT_CHAT_FRAME:AddMessage("AntiDaze: Cancel Pack off", 1, 1, 0.5);
    end
	else
		ADOptions.ADCPack = 1;
    if ( DEFAULT_CHAT_FRAME ) then
      DEFAULT_CHAT_FRAME:AddMessage("AntiDaze: Cancel Pack on", 1, 1, 0.5);
    end
	end
end

function ADCPackPets_Toogle()
	if(ADOptions.ADCPackPets == 1) then
		ADOptions.ADCPackPets = 0;
    if ( DEFAULT_CHAT_FRAME ) then
      DEFAULT_CHAT_FRAME:AddMessage("AntiDaze: Cancel Pack on Pets off", 1, 1, 0.5);
    end
	else
		ADOptions.ADCPackPets = 1
    if ( DEFAULT_CHAT_FRAME ) then
      DEFAULT_CHAT_FRAME:AddMessage("AntiDaze: Cancel Pack on Pets on", 1, 1, 0.5);
    end
	end
end

-- Manual Cancel Function for Macros

function CancelCheetah()
  if PlayerBuff("JungleTiger") then 
    CPlayerBuff("JungleTiger")
  end      
  if PlayerBuff("WhiteTiger") then 
    CPlayerBuff("WhiteTiger")
  end
end

------------------------
--  Helper Functions  --
------------------------

--Loops through all of the buffs currently active looking for a string match
function PlayerBuff(buff)
  local iIterator = 1
  while (UnitBuff("player", iIterator)) or (UnitDebuff("player", iIterator)) do
    Buff1 = UnitBuff("player", iIterator)
    DeBuff1 = UnitDebuff("player", iIterator)
    if (Buff1) then
      if (string.find(Buff1, buff)) then 
        return iIterator-1
      end
		end
    if (DeBuff1) then
      if (string.find(DeBuff1, buff)) then 
        return iIterator-1
      end
    end
    iIterator = iIterator + 1
  end
end

-- same for Target or (if specified) for Unit
function TargetBuff(buff,Unit)
  local iIterator = 1
  if (Unit) then what = Unit else what = "target" end
  while (UnitBuff(what, iIterator)) or (UnitDebuff(what, iIterator)) do
    found = false
    Buff1 = UnitBuff(what, iIterator)
    DeBuff1 = UnitDebuff(what, iIterator)
    if (Buff1) then
      if (string.find(Buff1, buff)) then 
        found = true
      end
    end
    if (DeBuff1) then
      if (string.find(DeBuff1, buff)) then 
        found = true
      end
    end
    if (found) then
      return iIterator;
    end
    iIterator = iIterator + 1
  end
end

-- same but will return right index for use with CancelPlayerBuff
function CPlayerBuff(buff,a)
  local iIterator = 0
  while not (GetPlayerBuff(iIterator) == -1) do
    if (string.find(GetPlayerBuffTexture(iIterator), buff)) then 
      if (a) and ( DEFAULT_CHAT_FRAME ) then DEFAULT_CHAT_FRAME:AddMessage("CPlayer: "..GetPlayerBuffTexture(iIterator)..", iIterator: "..iIterator, 1, 1, 0.5) end
			CancelPlayerBuff(GetPlayerBuff(iIterator))
      return GetPlayerBuff(iIterator)
    end
    iIterator = iIterator + 1
  end
end


function GetSpellBookSlotTex(wtexture)
  --Sea.IO.print("----- "..spell)
	local i = 1;
	while true do
		local spellName, spellRank = GetSpellName(i, BOOKTYPE_SPELL);
    local texture = GetSpellTexture(i, BOOKTYPE_SPELL)
		if not spellName then
			do break end;
		end
    --Sea.IO.print("Vergleiche: "..spellName.." == "..spell);
		if (string.find(texture, wtexture)) then
      --Sea.IO.print("Tex: "..texture.." == "..wtexture..", Buchplatz: "..i);
      spelltexture = texture
      spellbookslot = i
      --Sea.IO.print("Textur: "..spelltexture);
      do break end;
		end
		i = i + 1;
	end
  BuffPos = TargetBuff(spelltexture)
  --Sea.IO.print(BuffPos)
  return spellbookslot, spellName, spelltexture, BuffPos
end


function GetSpellBookSlot(spell)
  --Sea.IO.print("----- "..spell)
	local i = 1;
	while true do
		local spellName, spellRank = GetSpellName(i, BOOKTYPE_SPELL);
    local texture = GetSpellTexture(i, BOOKTYPE_SPELL)
		if not spellName then
			do break end;
		end
    --Sea.IO.print("Vergleiche: "..spellName.." == "..spell);
		if (string.find(spellName, spell)) then
      --Sea.IO.print(spellName.." == "..spell..", Buchplatz: "..i);
      spelltexture = texture
      spellbookslot = i
      --Sea.IO.print("Textur: "..spelltexture);
      do break end;
		end
		i = i + 1;
	end
  BuffPos = TargetBuff(spelltexture)
  --Sea.IO.print(BuffPos)
  return spellbookslot, spellName, spelltexture, BuffPos
end

--Returns true if Aspect of the Cheetah is active
function isCheetahActive()
  if PlayerBuff("JungleTiger")  then
    return true
  end
end

--Returns true if Aspect of the Pack is active
function isPackActive()
  if PlayerBuff("WhiteTiger") then
    return true
  end
end
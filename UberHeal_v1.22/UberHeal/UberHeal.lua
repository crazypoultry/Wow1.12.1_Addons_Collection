UBERHEAL_OLDTARGET = nil;
UBERHEAL_TARGETS = { };

UBERHEAL_SLOT1 = 0;
UBERHEAL_SLOT2 = 0;
UBERHEAL_SLOT3 = 0;
UBERHEAL_SLOT4 = 0;
UBERHEAL_SLOT5 = 0;
UBERHEAL_SLOTSET = false;

UBERHEAL_SPELLSTRING1 = "bob";
UBERHEAL_SPELLSTRING2 = "bob";
UBERHEAL_SPELLSTRING3 = "bob";
UBERHEAL_SPELLSTRING4 = "bob";
UBERHEAL_SPELLSTRING5 = "bob";
UberAutoTargetFunction = 2;

UberCastingSpell = 0;
UberLOSTarget = "";


UberTableCounter = 0;

UBERHEAL_LOSTARGET1 = "";
UBERHEAL_LOSTIME1 = 0;
UBERHEAL_LOSTARGET2 = "";
UBERHEAL_LOSTIME2 = 0;
UBERHEAL_LOSTARGET3 = "";
UBERHEAL_LOSTIME3 = 0;
UBERHEAL_LOSTARGET4 = "";
UBERHEAL_LOSTIME4 = 0;
UBERHEAL_LOSTARGET5 = "";
UBERHEAL_LOSTIME5 = 0;
UBERHEAL_LOSTARGET6 = "";
UBERHEAL_LOSTIME6 = 0;
UBERHEAL_LOSTARGET7 = "";
UBERHEAL_LOSTIME7 = 0;
UBERHEAL_LOSTARGET8 = "";
UBERHEAL_LOSTIME8 = 0;
UBERHEAL_LOSTARGET9 = "";
UBERHEAL_LOSTIME9 = 0;



local UberHeal_Range_Icons = { };


function Uberheal_SetUpVariables()
		if (not UberHealConfig) then
			UberHealConfig = {};
		end
		if (not (UberHealConfig["Version"] == "1.22")) then
			UberHealConfig = {};
		end
		if(not UberHealConfig[UBERHEAL_PLAYERID]) then

			UberHealConfig["Version"] = "1.22";

			local playerClass, englishClass = UnitClass("player");
			if (englishClass == "PRIEST") then 
				UberHealConfig[UBERHEAL_PLAYERID] = {};
				UberHealConfig[UBERHEAL_PLAYERID]["Spell1"] = "Renew";
				UberHealConfig[UBERHEAL_PLAYERID]["Rank1"] = 9;
				UberHealConfig[UBERHEAL_PLAYERID]["BuffCheck1"] = 1;
				UberHealConfig[UBERHEAL_PLAYERID]["Spell2"] = "Flash Heal";
				UberHealConfig[UBERHEAL_PLAYERID]["Rank2"] = 7;
				UberHealConfig[UBERHEAL_PLAYERID]["BuffCheck2"] = 0;
				UberHealConfig[UBERHEAL_PLAYERID]["Spell3"] = "Greater Heal";
				UberHealConfig[UBERHEAL_PLAYERID]["Rank3"] = 4;
				UberHealConfig[UBERHEAL_PLAYERID]["BuffCheck3"] = 0;
				UberHealConfig[UBERHEAL_PLAYERID]["Verbose"] = "0";
				UberHealConfig[UBERHEAL_PLAYERID]["Announce"] = 1;
				UberHealConfig[UBERHEAL_PLAYERID]["Spell4"] = "Flash Heal";
				UberHealConfig[UBERHEAL_PLAYERID]["Rank4"] = 5;
				UberHealConfig[UBERHEAL_PLAYERID]["BuffCheck4"] = 0;
				UberHealConfig[UBERHEAL_PLAYERID]["Spell5"] = "Power Word: Shield";
				UberHealConfig[UBERHEAL_PLAYERID]["Rank5"] = 10;
				UberHealConfig[UBERHEAL_PLAYERID]["BuffCheck5"] = 0;
				
			elseif (englishClass == "DRUID") then

				UberHealConfig[UBERHEAL_PLAYERID] = {};
				UberHealConfig[UBERHEAL_PLAYERID]["Spell1"] = "Rejuvenation";
				UberHealConfig[UBERHEAL_PLAYERID]["Rank1"] = 10;
				UberHealConfig[UBERHEAL_PLAYERID]["BuffCheck1"] = 1;
				UberHealConfig[UBERHEAL_PLAYERID]["Spell2"] = "Healing Touch";
				UberHealConfig[UBERHEAL_PLAYERID]["Rank2"] = 10;
				UberHealConfig[UBERHEAL_PLAYERID]["BuffCheck2"] = 0;
				UberHealConfig[UBERHEAL_PLAYERID]["Spell3"] = "Regrowth";
				UberHealConfig[UBERHEAL_PLAYERID]["Rank3"] = 4;
				UberHealConfig[UBERHEAL_PLAYERID]["BuffCheck3"] = 0;
				UberHealConfig[UBERHEAL_PLAYERID]["Verbose"] = "0";
				UberHealConfig[UBERHEAL_PLAYERID]["Announce"] = 1;
				UberHealConfig[UBERHEAL_PLAYERID]["Spell4"] = "Rejuvenation";
				UberHealConfig[UBERHEAL_PLAYERID]["Rank4"] = 5;
				UberHealConfig[UBERHEAL_PLAYERID]["BuffCheck4"] = 1;
				UberHealConfig[UBERHEAL_PLAYERID]["Spell5"] = "Swiftmend";
				UberHealConfig[UBERHEAL_PLAYERID]["Rank5"] = 0;
				UberHealConfig[UBERHEAL_PLAYERID]["BuffCheck5"] = 0;




			elseif (englishClass == "PALADIN") then

				UberHealConfig[UBERHEAL_PLAYERID] = {};
				UberHealConfig[UBERHEAL_PLAYERID]["Spell1"] = "Flash of Light";
				UberHealConfig[UBERHEAL_PLAYERID]["Rank1"] = 5;
				UberHealConfig[UBERHEAL_PLAYERID]["BuffCheck1"] = 1;
				UberHealConfig[UBERHEAL_PLAYERID]["Spell2"] = "Flash of Light";
				UberHealConfig[UBERHEAL_PLAYERID]["Rank2"] = 4;
				UberHealConfig[UBERHEAL_PLAYERID]["BuffCheck2"] = 0;
				UberHealConfig[UBERHEAL_PLAYERID]["Spell3"] = "Holy Light";
				UberHealConfig[UBERHEAL_PLAYERID]["Rank3"] = 5;
				UberHealConfig[UBERHEAL_PLAYERID]["BuffCheck3"] = 0;
				UberHealConfig[UBERHEAL_PLAYERID]["Verbose"] = "0";
				UberHealConfig[UBERHEAL_PLAYERID]["Announce"] = 1;
				UberHealConfig[UBERHEAL_PLAYERID]["Spell4"] = "Blessing of Protection";
				UberHealConfig[UBERHEAL_PLAYERID]["Rank4"] = 3;
				UberHealConfig[UBERHEAL_PLAYERID]["BuffCheck4"] = 1;
				UberHealConfig[UBERHEAL_PLAYERID]["Spell5"] = "Lay on Hands";
				UberHealConfig[UBERHEAL_PLAYERID]["Rank5"] = 3;
				UberHealConfig[UBERHEAL_PLAYERID]["BuffCheck5"] = 0;




			elseif (englishClass == "SHAMAN") then



				UberHealConfig[UBERHEAL_PLAYERID] = {};
				UberHealConfig[UBERHEAL_PLAYERID]["Spell1"] = "Lesser Healing Wave";
				UberHealConfig[UBERHEAL_PLAYERID]["Rank1"] = 6;
				UberHealConfig[UBERHEAL_PLAYERID]["BuffCheck1"] = 1;
				UberHealConfig[UBERHEAL_PLAYERID]["Spell2"] = "Healing Wave";
				UberHealConfig[UBERHEAL_PLAYERID]["Rank2"] = 9;
				UberHealConfig[UBERHEAL_PLAYERID]["BuffCheck2"] = 0;
				UberHealConfig[UBERHEAL_PLAYERID]["Spell3"] = "Chain Heal";
				UberHealConfig[UBERHEAL_PLAYERID]["Rank3"] = 3;
				UberHealConfig[UBERHEAL_PLAYERID]["BuffCheck3"] = 0;
				UberHealConfig[UBERHEAL_PLAYERID]["Verbose"] = "0";
				UberHealConfig[UBERHEAL_PLAYERID]["Announce"] = 1;
				UberHealConfig[UBERHEAL_PLAYERID]["Spell4"] = "Healing Wave";
				UberHealConfig[UBERHEAL_PLAYERID]["Rank4"] = 5;
				UberHealConfig[UBERHEAL_PLAYERID]["BuffCheck4"] = 1;
				UberHealConfig[UBERHEAL_PLAYERID]["Spell5"] = "Healing Wave";
				UberHealConfig[UBERHEAL_PLAYERID]["Rank5"] = 4;
				UberHealConfig[UBERHEAL_PLAYERID]["BuffCheck5"] = 0;




			end
			
			UberHealConfig[UBERHEAL_PLAYERID]["Button1"] = -5;
			UberHealConfig[UBERHEAL_PLAYERID]["Button2"] = -3;
			UberHealConfig[UBERHEAL_PLAYERID]["Button3"] = -4;
			UberHealConfig[UBERHEAL_PLAYERID]["Button4"] = -5;
			UberHealConfig[UBERHEAL_PLAYERID]["Button5"] = -6;
			UberHealConfig[UBERHEAL_PLAYERID]["Modifier1"] = 3;
			UberHealConfig[UBERHEAL_PLAYERID]["Modifier2"] = 3;
			UberHealConfig[UBERHEAL_PLAYERID]["Modifier3"] = 4;
			UberHealConfig[UBERHEAL_PLAYERID]["Modifier4"] = 4;
			UberHealConfig[UBERHEAL_PLAYERID]["Modifier5"] = 3;

			UberHealConfig[UBERHEAL_PLAYERID]["EmergencyMonitor"] = 2;
			UberHealConfig[UBERHEAL_PLAYERID]["PrimaryDirection"] = -1;
			UberHealConfig[UBERHEAL_PLAYERID]["SecondaryDirection"] = 1;
			UberHealConfig[UBERHEAL_PLAYERID]["PrimaryValue"] = 1;
			UberHealConfig[UBERHEAL_PLAYERID]["SecondaryValue"] = 3;
			
		end
		UberHealConfigure();

		
end



function Uber_Init()

	local playerClass, englishClass = UnitClass("player");


	if (englishClass == "PRIEST" or englishClass == "DRUID" or englishClass == "PALADIN" or englishClass == "SHAMAN") then 

		UBERHEAL_PLAYERID = UnitName("player") .. " of " .. GetCVar("realmName");
		SLASH_UBERHEAL1 = UBERHEAL_MACRO_COMMAND;
		SlashCmdList["UBERHEAL"] = function(msg)

		ShowUberOptions();
		end

		SLASH_UBERHEALVERBOSE1 = UBERHEAL_MACRO_VERBOSECOMMAND;
		SlashCmdList["UBERHEALVERBOSE"] = function(msg)

		UberHealVerboseMode(msg);
		end

		SLASH_UberHealAnnounce1 = UBERHEAL_MACRO_ANNOUNCEOFFCOMMAND;
		SlashCmdList["UberHealAnnounce"] = function(msg)

		UberHealAnnounce(msg);
		end

		SLASH_UberHealSet1 = UBERHEAL_MACRO_SET;
		SlashCmdList["UberHealSet"] = function(msg)

		UberHealSet(msg);
		end


		SLASH_UberHealCastSpell1onone1 = UBERHEAL_MACRO_PRIMARY_CAST_SPELL_1;
		SlashCmdList["UberHealCastSpell1onone"] = function(msg)
			BuildTargetTables(1,1);
		end

		SLASH_UberHealCastSpell2onone1 = UBERHEAL_MACRO_PRIMARY_CAST_SPELL_2;
		SlashCmdList["UberHealCastSpell2onone"] = function(msg)
			BuildTargetTables(2,1);
		end

		SLASH_UberHealCastSpell3onone1 = UBERHEAL_MACRO_PRIMARY_CAST_SPELL_3;
		SlashCmdList["UberHealCastSpell3onone"] = function(msg)
			BuildTargetTables(3,1);
		end

		SLASH_UberHealCastSpell4onone1 = UBERHEAL_MACRO_PRIMARY_CAST_SPELL_4;
		SlashCmdList["UberHealCastSpell4onone"] = function(msg)
			BuildTargetTables(4,1);
		end

		SLASH_UberHealCastSpell5onone1 = UBERHEAL_MACRO_PRIMARY_CAST_SPELL_5;
		SlashCmdList["UberHealCastSpell5onone"] = function(msg)
			BuildTargetTables(5,1);
		end

		SLASH_UberHealCastSpell1ontwo1 = UBERHEAL_MACRO_SECONDARY_CAST_SPELL_1;
		SlashCmdList["UberHealCastSpell1ontwo"] = function(msg)
			BuildTargetTables(1,2);
		end

		SLASH_UberHealCastSpell2ontwo1 = UBERHEAL_MACRO_SECONDARY_CAST_SPELL_2;
		SlashCmdList["UberHealCastSpell2ontwo"] = function(msg)
			BuildTargetTables(2,2);
		end

		SLASH_UberHealCastSpell3ontwo1 = UBERHEAL_MACRO_SECONDARY_CAST_SPELL_3;
		SlashCmdList["UberHealCastSpell3ontwo"] = function(msg)
			BuildTargetTables(3,2);
		end

		SLASH_UberHealCastSpell4ontwo1 = UBERHEAL_MACRO_SECONDARY_CAST_SPELL_4;
		SlashCmdList["UberHealCastSpell3ontwo"] = function(msg)
			BuildTargetTables(4,2);
		end

		SLASH_UberHealCastSpell5ontwo1 = UBERHEAL_MACRO_SECONDARY_CAST_SPELL_5;
		SlashCmdList["UberHealCastSpell3ontwo"] = function(msg)
			BuildTargetTables(5,2);
		end


		Uberheal_SetUpVariables();

		if ( UberHealConfig[UBERHEAL_PLAYERID]["Announce"] == 1  ) then
			UberHealStatus:Show();
		end

				Spell1:SetText(UberHealConfig[UBERHEAL_PLAYERID]["Spell1"]);
				Rank1:SetText(UberHealConfig[UBERHEAL_PLAYERID]["Rank1"]);
				Slot1:SetText(UBERHEAL_SLOT1);                                    
		
				Spell2:SetText(UberHealConfig[UBERHEAL_PLAYERID]["Spell2"]);
				Rank2:SetText(UberHealConfig[UBERHEAL_PLAYERID]["Rank2"]);
				Slot2:SetText(UBERHEAL_SLOT2);
		
				Spell3:SetText(UberHealConfig[UBERHEAL_PLAYERID]["Spell3"]);
				Rank3:SetText(UberHealConfig[UBERHEAL_PLAYERID]["Rank3"]);
				Slot3:SetText(UBERHEAL_SLOT3);
		
				Spell4:SetText(UberHealConfig[UBERHEAL_PLAYERID]["Spell4"]);
				Rank4:SetText(UberHealConfig[UBERHEAL_PLAYERID]["Rank4"]);
				Slot4:SetText(UBERHEAL_SLOT4);
		
				Spell5:SetText(UberHealConfig[UBERHEAL_PLAYERID]["Spell5"]);
				Rank5:SetText(UberHealConfig[UBERHEAL_PLAYERID]["Rank5"]);
				Slot5:SetText(UBERHEAL_SLOT5);

		
		UberHealOnClick_Minimap:SetPoint("TOPLEFT","Minimap","TOPLEFT",52-(80*cos(UberHealConfig["IconPosition"] or 45)),(80*sin(UberHealConfig["IconPosition"] or 45))-52);
		UberHealInitializeMenus();

		---------------------------------------------------
		if (IsAddOnLoaded("Squishy") == 1) then
			UberAutoTargetFunction = 2;
			UberUseSquishy();

			if ( UberHealConfig[UBERHEAL_PLAYERID]["EmergencyMonitor"] == 2) then

				UberCTRaidToggle:SetChecked(false);
				UberSquishyToggle:SetChecked(true);
				PrimaryThresholdSlider:SetValue(UberHealConfig[UBERHEAL_PLAYERID]["PrimaryValue"]);
				SecondaryThresholdSlider:SetValue(UberHealConfig[UBERHEAL_PLAYERID]["SecondaryValue"]);
			else
				UberCTRaidToggle:SetChecked(true);
				UberSquishyToggle:SetChecked(false);
				UberAutoTargetFunction = 1;
				UberUseCTRaid();
				if ((UberHealConfig[UBERHEAL_PLAYERID]["PrimaryValue"] < 6) and (UberHealConfig[UBERHEAL_PLAYERID]["SecondaryValue"] < 6)) then
					PrimaryThresholdSlider:SetValue(UberHealConfig[UBERHEAL_PLAYERID]["PrimaryValue"]);
					SecondaryThresholdSlider:SetValue(UberHealConfig[UBERHEAL_PLAYERID]["SecondaryValue"]);

				else
					PrimaryThresholdSlider:SetValue(1);
					SecondaryThresholdSlider:SetValue(2);
				end
				

			end
			

		else
			UberUseCTRaid();
			
			UberCTRaidToggle:Hide();
			UberSquishyToggle:Hide();
			UberCTRaidLabel:Hide();
			UberSquishyLabel:Hide();
			
			if ((UberHealConfig[UBERHEAL_PLAYERID]["PrimaryValue"] < 6) and (UberHealConfig[UBERHEAL_PLAYERID]["SecondaryValue"] < 6)) then
				PrimaryThresholdSlider:SetValue(UberHealConfig[UBERHEAL_PLAYERID]["PrimaryValue"]);
				SecondaryThresholdSlider:SetValue(UberHealConfig[UBERHEAL_PLAYERID]["SecondaryValue"]);

			else
				PrimaryThresholdSlider:SetValue(1);
				SecondaryThresholdSlider:SetValue(2);
			end


			
		end
		if (not(IsAddOnLoaded("CT_RaidAssist") == 1)) then
			UberCTRaidToggle:Hide();
			UberCTRaidLabel:Hide();
			UberSquishyToggle:Hide();
			UberSquishyLabel:Hide();
		end
		UberHealOption_OnShow();
		UberHealConfigure();
		
	else
		UberHealOnClick_Minimap:Hide();
		UberHealOnClick_IconDragging:Hide();
	
	end
	
end



function UberHealInitializeMenus()


	local playerClass, englishClass = UnitClass("player");


	if (englishClass == "PRIEST" or englishClass == "DRUID" or englishClass == "PALADIN" or englishClass == "SHAMAN") then 

		UIDropDownMenu_SetSelectedValue(Spell1SelectionMenu, UberHealConfig[UBERHEAL_PLAYERID]["Modifier1"]);

		UIDropDownMenu_SetSelectedValue(Spell1ButtonMenu, UberHealConfig[UBERHEAL_PLAYERID]["Button1"]);

		UIDropDownMenu_SetSelectedValue(Spell2SelectionMenu, UberHealConfig[UBERHEAL_PLAYERID]["Modifier2"]);

		UIDropDownMenu_SetSelectedValue(Spell2ButtonMenu, UberHealConfig[UBERHEAL_PLAYERID]["Button2"]);

		UIDropDownMenu_SetSelectedValue(Spell3SelectionMenu, UberHealConfig[UBERHEAL_PLAYERID]["Modifier3"]);

		UIDropDownMenu_SetSelectedValue(Spell3ButtonMenu, UberHealConfig[UBERHEAL_PLAYERID]["Button3"]);

		UIDropDownMenu_SetSelectedValue(Spell4SelectionMenu, UberHealConfig[UBERHEAL_PLAYERID]["Modifier4"]);

		UIDropDownMenu_SetSelectedValue(Spell4ButtonMenu, UberHealConfig[UBERHEAL_PLAYERID]["Button4"]);

		UIDropDownMenu_SetSelectedValue(Spell5SelectionMenu, UberHealConfig[UBERHEAL_PLAYERID]["Modifier5"]);

		UIDropDownMenu_SetSelectedValue(Spell5ButtonMenu, UberHealConfig[UBERHEAL_PLAYERID]["Button5"]);
	end
	UberHealConfigure();

end



function UberHealOption_OnLoad()
	Spell1_Description:SetText("#1");
	Spell2_Description:SetText("#2");
	Spell3_Description:SetText("#3");
	Spell4_Description:SetText("#4");
	Spell5_Description:SetText("#5");
	ChangeSpells:SetText("Save Spell Changes");
end



function UberHealOption_OnShow()

	local playerClass, englishClass = UnitClass("player");


	if (englishClass == "PRIEST" or englishClass == "DRUID" or englishClass == "PALADIN" or englishClass == "SHAMAN") then 

		Spell1:SetText(UberHealConfig[UBERHEAL_PLAYERID]["Spell1"]);
		Rank1:SetText(UberHealConfig[UBERHEAL_PLAYERID]["Rank1"]);
		Slot1:SetText(UBERHEAL_SLOT1);                                    

		Spell2:SetText(UberHealConfig[UBERHEAL_PLAYERID]["Spell2"]);
		Rank2:SetText(UberHealConfig[UBERHEAL_PLAYERID]["Rank2"]);
		Slot2:SetText(UBERHEAL_SLOT2);

		Spell3:SetText(UberHealConfig[UBERHEAL_PLAYERID]["Spell3"]);
		Rank3:SetText(UberHealConfig[UBERHEAL_PLAYERID]["Rank3"]);
		Slot3:SetText(UBERHEAL_SLOT3);

		Spell4:SetText(UberHealConfig[UBERHEAL_PLAYERID]["Spell4"]);
		Rank4:SetText(UberHealConfig[UBERHEAL_PLAYERID]["Rank4"]);
		Slot4:SetText(UBERHEAL_SLOT4);

		Spell5:SetText(UberHealConfig[UBERHEAL_PLAYERID]["Spell5"]);
		Rank5:SetText(UberHealConfig[UBERHEAL_PLAYERID]["Rank5"]);
		Slot5:SetText(UBERHEAL_SLOT5);

		if ( UberHealConfig[UBERHEAL_PLAYERID]["BuffCheck1"] == 1 ) then
			BuffToggle1:SetChecked();
		end

		if ( UberHealConfig[UBERHEAL_PLAYERID]["BuffCheck2"] == 1 ) then
			BuffToggle2:SetChecked();
		end

		if ( UberHealConfig[UBERHEAL_PLAYERID]["BuffCheck3"] == 1 ) then
			BuffToggle3:SetChecked();
		end

		if ( UberHealConfig[UBERHEAL_PLAYERID]["BuffCheck4"] == 1 ) then
			BuffToggle4:SetChecked();
		end

		if ( UberHealConfig[UBERHEAL_PLAYERID]["BuffCheck5"] == 1 ) then
			BuffToggle5:SetChecked();
		end

		if (Rank1:GetText() == "") then
			UBERHEAL_SPELLSTRING1 = Spell1:GetText();
		else
			UBERHEAL_SPELLSTRING1 = Spell1:GetText() .. "(Rank " .. Rank1:GetText() .. ")";
		end

		if (Rank2:GetText() == "") then
			UBERHEAL_SPELLSTRING2 = Spell2:GetText();
		else
			UBERHEAL_SPELLSTRING2 = Spell2:GetText() .. "(Rank " .. Rank2:GetText() .. ")";
		end

		if (Rank3:GetText() == "") then
			UBERHEAL_SPELLSTRING3 = Spell3:GetText();
		else
			UBERHEAL_SPELLSTRING3 = Spell3:GetText() .. "(Rank " .. Rank3:GetText() .. ")";
		end

		if (Rank4:GetText() == "") then
			UBERHEAL_SPELLSTRING4 = Spell4:GetText();
		else
			UBERHEAL_SPELLSTRING4 = Spell4:GetText() .. "(Rank " .. Rank4:GetText() .. ")";
		end

		if (Rank5:GetText() == "") then
			UBERHEAL_SPELLSTRING5 = Spell5:GetText();
		else
			UBERHEAL_SPELLSTRING5 = Spell5:GetText() .. "(Rank " .. Rank5:GetText() .. ")";
		end

	end		

	
	

end

function VerbosePrint(stringmsg, passint)
	if (passint == 1 or passint == nil or passint == "") then
		DEFAULT_CHAT_FRAME:AddMessage(stringmsg);
	elseif (passint == 2) then
		DEFAULT_CHAT_FRAME:AddMessage(stringmsg);
	elseif (passint == 3) then
		DEFAULT_CHAT_FRAME:AddMessage(stringmsg);
	end
end


function UberHealVerboseMode(arg1)

	local playerClass, englishClass = UnitClass("player");

	if (englishClass == "PRIEST" or englishClass == "DRUID" or englishClass == "PALADIN" or englishClass == "SHAMAN") then 

		if ( UberHealConfig[UBERHEAL_PLAYERID]["Verbose"] == arg1  ) then
			UBERHEAL_VERBOSE = 1;
			UberHealConfig[UBERHEAL_PLAYERID]["Verbose"] = arg1;
		else
			UBERHEAL_VERBOSE = 0;
			UberHealConfig[UBERHEAL_PLAYERID]["Verbose"] = arg1;

		end
	end
end







function UberPrimaryCast(UBERHEAL_SLOT, UBERHEAL_BUFF, UBERHEAL_SPELLSTRING, UBERHEAL_BUFFCHECK)
----------------------------------------------------------------------------------------------------------------------PRIMARY CAST
		if(not(isInBlacklist(UnitName("target")))) then
			if (IsActionInRange(UBERHEAL_SLOT) == 1) then
--				DEFAULT_CHAT_FRAME:AddMessage("Action was in range");
				local UberRdyForCast = 1;
				if(UBERHEAL_BUFFCHECK == 1) then
--					DEFAULT_CHAT_FRAME:AddMessage("Checking for Buff Right Now");
					if (not(UberCheckForBuff(UBERHEAL_BUFF))) then
						UberStatusText:SetText("Not Ready to cast the spell cause they have the buff");
						UberRdyForCast = 0;
					end

				end
				if (UberRdyForCast == 1) then
					UberCastingSpell = 1;
					UberLOSTarget = UnitName("target");
					CastSpellByName(UBERHEAL_SPELLSTRING);

					UberStatusText:SetText("|c0000FF00Casting " .. UBERHEAL_SPELLSTRING .. " on " .. UnitName("target") .. "|r");
					return 1;
				else
					UberStatusText:SetText("Target already had the specified buff");
				end



			else
				UberStatusText:SetText("Target out of range");
			end
		else
--				UberStatusText:SetText(UnitName("target") .. " was alrdy in the blacklist");
		end
	return 0;
end

function UberCheckForBuff(UBERHEAL_BUFF)
	--returns true is the unit doesnt have the buff and is ready to be cast upon
	if (UBERHEAL_BUFF == "Swiftmend") then
		if (isUnitBuffUp("target", "Rejuvination")) then
			return true;	
		else
			return false;
		end
	elseif(UBERHEAL_BUFF == "Power Word: Fortitude") then
		if (isUnitBuffUp("target", "Weakened Soul")) then
			return false;	
		else
			return true;
		end
	elseif(UBERHEAL_BUFF == "Divine Shield") then
		if (isUnitBuffUp("target", "Forbearance")) then
			return false;	
		else
			return true;
		end
	elseif(UBERHEAL_BUFF == "Blessing of Protection") then
		if (isUnitBuffUp("target", "Forbearance")) then
			return false;	
		else
			return true;
		end
	elseif(UBERHEAL_BUFF == "Divine Protection") then
		if (isUnitBuffUp("target", "Forbearance")) then
			return false;	
		else
			return true;
		end
	else
		if (isUnitBuffUp("target", UBERHEAL_BUFF)) then
			return false;
		else
			return true;
		end
	
	end
	
end

function BuildTargetTables(passint, UberSlider)

	UberTableCounter = 0;
	UBERHEAL_TARGETS = { }

	local name, realm = UnitName("target");
	UBERHEAL_OLDTARGET = name;


	if(UBERHEAL_SLOTSET == false) then
		UberHealConfigure();
	end
	

	if(UBERHEAL_SLOTSET == false) then
		UberHealConfigure();
		UBERHEAL_SLOTSET = true;
	end


	local playerClass, englishClass = UnitClass("player");

	if (englishClass == "PRIEST" or englishClass == "DRUID" or englishClass == "PALADIN" or englishClass == "SHAMAN") then 

		local blaah = 0;
		if (passint == 1) then
			blaah = UBERHEAL_SLOT1;		
		elseif (passint == 2) then
			blaah = UBERHEAL_SLOT2;		
		elseif (passint == 3) then
			blaah = UBERHEAL_SLOT3;		
		elseif (passint == 4) then
			blaah = UBERHEAL_SLOT4;		
		elseif (passint == 5) then
			blaah = UBERHEAL_SLOT5;		
		end		

		local start, duration, enable = GetActionCooldown(blaah);
		local isUsable, notEnoughMana = IsUsableAction(blaah);
		local isCurrent = IsCurrentAction(blaah);


		if(not (notEnoughMana == 1)) then
			if(isUsable == 1) then
				if(start == 0) then
					if( not (isCurrent == 1)) then

						
						local success = 0;
						local UberSliderValue = 1;
						if(UberSlider == 2) then
							UberSliderValue  = SecondaryThresholdSlider:GetValue(1);
						else
							UberSliderValue  = PrimaryThresholdSlider:GetValue(1);
						
						end
						for i=UberSliderValue,1,-1 do
--							DEFAULT_CHAT_FRAME:AddMessage("Doing Ascending Healing   stuff -> 1   checling " .. i);
							ClearTarget();
							UberEmergencyTarget(i);
							local TempName = UnitName("target");

								UberTableCounter = UberTableCounter + 1;
								UBERHEAL_TARGETS[UberTableCounter] = TempName;

								if (passint == 1) then 
									if (UberPrimaryCast(UBERHEAL_SLOT1, Spell1:GetText(), UBERHEAL_SPELLSTRING1, UberHealConfig[UBERHEAL_PLAYERID]["BuffCheck1"])==1) then
										success = 1;
										break;
									end
								elseif (passint == 2) then
									if (UberPrimaryCast(UBERHEAL_SLOT2, Spell2:GetText(), UBERHEAL_SPELLSTRING2, UberHealConfig[UBERHEAL_PLAYERID]["BuffCheck2"])==1) then
										success = 1;
										break;
									end
								elseif (passint == 3) then
									if (UberPrimaryCast(UBERHEAL_SLOT3, Spell3:GetText(), UBERHEAL_SPELLSTRING3, UberHealConfig[UBERHEAL_PLAYERID]["BuffCheck3"])==1) then
										success = 1;
										break;
									end
								elseif (passint == 4) then
									if (UberPrimaryCast(UBERHEAL_SLOT4, Spell4:GetText(), UBERHEAL_SPELLSTRING4, UberHealConfig[UBERHEAL_PLAYERID]["BuffCheck4"])==1) then
										success = 1;
										break;
									end
								elseif (passint == 5) then
									if (UberPrimaryCast(UBERHEAL_SLOT5, Spell5:GetText(), UBERHEAL_SPELLSTRING5, UberHealConfig[UBERHEAL_PLAYERID]["BuffCheck5"])==1) then
										success = 1;
										break;
									end
								end

						end




						if (success == 0) then
							for i=(UberSliderValue+1),10 do
--								DEFAULT_CHAT_FRAME:AddMessage("Doing Ascending Healing   stuff-1 -> 10   checking " .. i);
								ClearTarget();
								UberEmergencyTarget(i);
								local TempName = UnitName("target");

								if (TempName ~= "" and TempName ~= nil) then	
									UberTableCounter = UberTableCounter + 1;
									UBERHEAL_TARGETS[UberTableCounter] = TempName;
									--------------------------------------------------ADD HEALING HERE
									if (passint == 1) then 
										if (UberPrimaryCast(UBERHEAL_SLOT1, Spell1:GetText(), UBERHEAL_SPELLSTRING1, UberHealConfig[UBERHEAL_PLAYERID]["BuffCheck1"])==1) then
											break;
										end
									elseif (passint == 2) then
										if (UberPrimaryCast(UBERHEAL_SLOT2, Spell2:GetText(), UBERHEAL_SPELLSTRING2, UberHealConfig[UBERHEAL_PLAYERID]["BuffCheck2"])==1) then
											break;
										end
									elseif (passint == 3) then
										if (UberPrimaryCast(UBERHEAL_SLOT3, Spell3:GetText(), UBERHEAL_SPELLSTRING3, UberHealConfig[UBERHEAL_PLAYERID]["BuffCheck3"])==1) then
											break;
										end
									elseif (passint == 4) then
										if (UberPrimaryCast(UBERHEAL_SLOT4, Spell4:GetText(), UBERHEAL_SPELLSTRING4, UberHealConfig[UBERHEAL_PLAYERID]["BuffCheck4"])==1) then
											break;
										end
									elseif (passint == 5) then
										if (UberPrimaryCast(UBERHEAL_SLOT5, Spell5:GetText(), UBERHEAL_SPELLSTRING5, UberHealConfig[UBERHEAL_PLAYERID]["BuffCheck5"])==1) then
											break;
										end
									end

								else
									break;
								end
							end
						end




					else
						UberStatusText:SetText("Currently Casting Spell");
						targetOldTarget();
					end
				else
					UberStatusText:SetText("Cooldown still active");
					targetOldTarget();
				end
			else
				UberStatusText:SetText("Action Not Usable");
				targetOldTarget();
			end
		else
			UberStatusText:SetText("Out of MAna");
			targetOldTarget();
		end


	end
	
	PrintTargetTables();

	ClearTarget();
	targetOldTarget();
	


end


function UberEmergencyTarget(i)

	if(UberAutoTargetFunction == 2) then
		Squishy:TargetSquishyUnitByPriority(i);
	else
		CT_RA_Emergency_TargetMember(i);
	end
end


function PrintTargetTables()

	for i=1,UberTableCounter do
--				DEFAULT_CHAT_FRAME:AddMessage("*********** At position # " .. i .. " is the name " .. (UBERHEAL_TARGETS[i]));
	end

end

function UberPrint(theKey, theValue)
	
--	DEFAULT_CHAT_FRAME:AddMessage("Adding " .. theKey .. "   " .. theValue);

	return nil;
end




function targetOldTarget()
	if(UBERHEAL_OLDTARGET ~=nil and UBERHEAL_OLDTARGET ~="" and UBERHEAL_OLDTARGET ~="Unknown Entity") then
		TargetByName(UBERHEAL_OLDTARGET, true);
	else
		ClearTarget();
	end
end

function UberSpellCastStop()

	if(UberCastingSpell == 1) then
		UberCastingSpell = 0;
		UberLOSTarget = "";
--		DEFAULT_CHAT_FRAME:AddMessage("Spellcast STOP Fired");
	end
end


function targetOutOfLOS()   -- called when spellcast failed
	if (UberCastingSpell == 1) then 
		addToBlacklist(UberLOSTarget);
--		DEFAULT_CHAT_FRAME:AddMessage("Spellcast failed on " .. UberLOSTarget);
		UberCastingSpell = 0;
		UberLOSTarget = "";
	else	
--		DEFAULT_CHAT_FRAME:AddMessage("Spellcast Failed Fired");
	end
end



function addToBlacklist(inputstring)
	if (inputstring ~= "" and inputstring ~= nil) then

		if(isInBlacklist() == false) then
			if(UBERHEAL_LOSTARGET1 == "") then
				UBERHEAL_LOSTARGET1 = inputstring;
				UBERHEAL_LOSTIME1 = GetTime();
				return true;
			elseif(BERHEAL_LOSTARGET1 == "") then

				if(UBERHEAL_LOSTARGET2 == "") then
					UBERHEAL_LOSTARGET2 = inputstring;
					UBERHEAL_LOSTIME2 = GetTime();
				elseif(BERHEAL_LOSTARGET2 == "") then
					if(UBERHEAL_LOSTARGET3 == "") then
						UBERHEAL_LOSTARGET3 = inputstring;
						UBERHEAL_LOSTIME3 = GetTime();
					elseif(BERHEAL_LOSTARGET3 == "") then
						if(UBERHEAL_LOSTARGET4 == "") then
							UBERHEAL_LOSTARGET4 = inputstring;
							UBERHEAL_LOSTIME4 = GetTime();
						elseif(BERHEAL_LOSTARGET4 == "") then
							if(UBERHEAL_LOSTARGET5 == "") then
								UBERHEAL_LOSTARGET5 = inputstring;
								UBERHEAL_LOSTIME5 = GetTime();
							elseif(BERHEAL_LOSTARGET5 == "") then
								if(UBERHEAL_LOSTARGET6 == "") then
									UBERHEAL_LOSTARGET6 = inputstring;
									UBERHEAL_LOSTIME6 = GetTime();
								elseif(BERHEAL_LOSTARGET6 == "") then
									if(UBERHEAL_LOSTARGET7 == "") then
										UBERHEAL_LOSTARGET7 = inputstring;
										UBERHEAL_LOSTIME7 = GetTime();
									elseif(BERHEAL_LOSTARGET7 == "") then
										if(UBERHEAL_LOSTARGET8 == "") then
											UBERHEAL_LOSTARGET8 = inputstring;
											UBERHEAL_LOSTIME8 = GetTime();
										elseif(BERHEAL_LOSTARGET8 == "") then
											if(UBERHEAL_LOSTARGET9 == "") then
												UBERHEAL_LOSTARGET9 = inputstring;
												UBERHEAL_LOSTIME9 = GetTime();
											elseif(BERHEAL_LOSTARGET9 == "") then
												UBERHEAL_LOSTARGET9 = inputstring;
												UBERHEAL_LOSTIME9 = GetTime();
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end
		cleanUpLOS();

end


function isInBlacklist(inputstring)
	cleanUpLOS();

	if(UBERHEAL_LOSTARGET1 == inputstring) then
		return true;
	elseif(BERHEAL_LOSTARGET1 == inputstring) then

		if(UBERHEAL_LOSTARGET2 == inputstring) then
			return true;
		elseif(BERHEAL_LOSTARGET2 == inputstring) then
			if(UBERHEAL_LOSTARGET3 == inputstring) then
				return true;
			elseif(BERHEAL_LOSTARGET3 == inputstring) then
				if(UBERHEAL_LOSTARGET4 == inputstring) then
					return true;
				elseif(BERHEAL_LOSTARGET4 == inputstring) then
					if(UBERHEAL_LOSTARGET5 == inputstring) then
						return true;
					elseif(BERHEAL_LOSTARGET5 == inputstring) then
						if(UBERHEAL_LOSTARGET6 == inputstring) then
							return true;
						elseif(BERHEAL_LOSTARGET6 == inputstring) then
							if(UBERHEAL_LOSTARGET7 == inputstring) then
								return true;
							elseif(BERHEAL_LOSTARGET7 == inputstring) then
								if(UBERHEAL_LOSTARGET8 == inputstring) then
									return true;
								elseif(BERHEAL_LOSTARGET8 == inputstring) then
									if(UBERHEAL_LOSTARGET9 == inputstring) then
										return true;
									elseif(BERHEAL_LOSTARGET9 == inputstring) then
										return false;
									end
								end
							end
						end
					end
				end
			end
		end
	end


end


function cleanUpLOS()

	local mySeconds = 3;							-- you can change the seconds here to change how long a unit will remain in the blacklist
	if(((UBERHEAL_LOSTIME1 + mySeconds)< GetTime()) and (not (UBERHEAL_LOSTIME1 == 0))) then 
		UBERHEAL_LOSTIME1 = 0;
		UBERHEAL_LOSTARGET1 = "";
	end
	if(((UBERHEAL_LOSTIME2 + mySeconds)< GetTime()) and (not (UBERHEAL_LOSTIME2 == 0))) then
		UBERHEAL_LOSTIME2 = 0;
		UBERHEAL_LOSTARGET2 = "";
	end
	if(((UBERHEAL_LOSTIME3 + mySeconds)< GetTime()) and (not (UBERHEAL_LOSTIME3 == 0))) then
		UBERHEAL_LOSTIME3 = 0;
		UBERHEAL_LOSTARGET3 = "";
	end
	if(((UBERHEAL_LOSTIME4 + mySeconds)< GetTime()) and (not (UBERHEAL_LOSTIME4 == 0))) then
		UBERHEAL_LOSTIME4 = 0;
		UBERHEAL_LOSTARGET4 = "";
	end
	if(((UBERHEAL_LOSTIME5 + mySeconds)< GetTime()) and (not (UBERHEAL_LOSTIME5 == 0))) then
		UBERHEAL_LOSTIME5 = 0;
		UBERHEAL_LOSTARGET5 = "";
	end
	if(((UBERHEAL_LOSTIME6 + mySeconds)< GetTime()) and (not (UBERHEAL_LOSTIME6 == 0))) then
		UBERHEAL_LOSTIME6 = 0;
		UBERHEAL_LOSTARGET6 = "";
	end
	if(((UBERHEAL_LOSTIME7 + mySeconds)< GetTime()) and (not (UBERHEAL_LOSTIME7 == 0))) then
		UBERHEAL_LOSTIME7 = 0;
		UBERHEAL_LOSTARGET7 = "";
	end
	if(((UBERHEAL_LOSTIME8 + mySeconds)< GetTime()) and (not (UBERHEAL_LOSTIME8 == 0))) then
		UBERHEAL_LOSTIME8 = 0;
		UBERHEAL_LOSTARGET8 = "";
	end
	if(((UBERHEAL_LOSTIME9 + mySeconds)< GetTime()) and (not (UBERHEAL_LOSTIME9 == 0))) then
		UBERHEAL_LOSTIME9 = 0;
		UBERHEAL_LOSTARGET9 = "";
	end
	
	if (UBERHEAL_VERBOSE == 1) then 
	

		if (UBERHEAL_LOSTARGET1 == "" or UBERHEAL_LOSTARGET1 == nil) then
			DEFAULT_CHAT_FRAME:AddMessage("LOS target 1 is Blank");
		else
			DEFAULT_CHAT_FRAME:AddMessage(UBERHEAL_LOSTARGET1);
		end

		if (UBERHEAL_LOSTARGET2 == "") then
			DEFAULT_CHAT_FRAME:AddMessage("LOS target 2 is Blank");
		else
			DEFAULT_CHAT_FRAME:AddMessage(UBERHEAL_LOSTARGET2);
		end


		if (UBERHEAL_LOSTARGET3 == "") then
			DEFAULT_CHAT_FRAME:AddMessage("LOS target 3 is Blank");
		else
			DEFAULT_CHAT_FRAME:AddMessage(UBERHEAL_LOSTARGET3);
		end

		if (UBERHEAL_LOSTARGET4 == "") then
			DEFAULT_CHAT_FRAME:AddMessage("LOS target 4 is Blank");
		else
			DEFAULT_CHAT_FRAME:AddMessage(UBERHEAL_LOSTARGET4);
		end

		if (UBERHEAL_LOSTARGET5 == "") then
			DEFAULT_CHAT_FRAME:AddMessage("LOS target 5 is Blank");
		else
			DEFAULT_CHAT_FRAME:AddMessage(UBERHEAL_LOSTARGET5);
		end

		if (UBERHEAL_LOSTARGET6 == "") then
			DEFAULT_CHAT_FRAME:AddMessage("LOS target 6 is Blank");
		else
			DEFAULT_CHAT_FRAME:AddMessage(UBERHEAL_LOSTARGET6);
		end

		if (UBERHEAL_LOSTARGET7 == "") then
			DEFAULT_CHAT_FRAME:AddMessage("LOS target 7 is Blank");
		else
			DEFAULT_CHAT_FRAME:AddMessage(UBERHEAL_LOSTARGET7);
		end

		if (UBERHEAL_LOSTARGET8 == "") then
			DEFAULT_CHAT_FRAME:AddMessage("LOS target 8 is Blank");
		else
			DEFAULT_CHAT_FRAME:AddMessage(UBERHEAL_LOSTARGET8);
		end

		if (UBERHEAL_LOSTARGET9 == "") then
			DEFAULT_CHAT_FRAME:AddMessage("LOS target 9 is Blank");
		else
			DEFAULT_CHAT_FRAME:AddMessage(UBERHEAL_LOSTARGET9);
		end




	end
	
	



end


function Mellow()
		DEFAULT_CHAT_FRAME:AddMessage("Casting failed");

			Squishy:TargetSquishyUnitByPriority(19);
			isUnitBuffUp("target", "Renew") 
end




function isUnitBuffUp(sUnitname, sBuffname) 
  local iIterator = 1;
  while (UnitBuff(sUnitname, iIterator)) do
    if (string.find(UnitBuff(sUnitname, iIterator), sBuffname)) then
      return true;
    end
    iIterator = iIterator + 1;
  end
  return false;
end





function UberHealAnnounce(arg1)

	local playerClass, englishClass = UnitClass("player");


	if (englishClass == "PRIEST" or englishClass == "DRUID" or englishClass == "PALADIN" or englishClass == "SHAMAN") then 

		if ( UberHealConfig[UBERHEAL_PLAYERID]["Announce"] == 0  ) then
			UberHealConfig[UBERHEAL_PLAYERID]["Announce"] = 1;
			DEFAULT_CHAT_FRAME:AddMessage("Announcing of Heals Turned On");
			UberHealStatus:Show();
		else
			UberHealConfig[UBERHEAL_PLAYERID]["Announce"] = 0;
			DEFAULT_CHAT_FRAME:AddMessage("Announcing of Heals Turned Off");
			UberHealStatus:Hide();
		end
--		UberHealSpells();
	end

end



function UberHealSpells()

	str = "Spell # 1 is " .. UberHealConfig[UBERHEAL_PLAYERID]["Spell1"] .. ", Rank " .. UberHealConfig[UBERHEAL_PLAYERID]["Rank1"] .. ", and using actionbar slot " .. UBERHEAL_SLOT1 .. " for range checking, and checking target for " .. UBERHEAL_BUFF1 .. " buff.";
	DEFAULT_CHAT_FRAME:AddMessage(str);
	str = "Spell # 2 is " .. UberHealConfig[UBERHEAL_PLAYERID]["Spell2"] .. ", Rank " .. UberHealConfig[UBERHEAL_PLAYERID]["Rank2"] .. ", and using actionbar slot " .. UBERHEAL_SLOT2 .. " for range checking, and checking target for " .. UBERHEAL_BUFF2 .. " buff.";
	DEFAULT_CHAT_FRAME:AddMessage(str);
	str = "Spell # 3 is " .. UberHealConfig[UBERHEAL_PLAYERID]["Spell3"] .. ", Rank " .. UberHealConfig[UBERHEAL_PLAYERID]["Rank3"] .. ", and using actionbar slot " .. UBERHEAL_SLOT3 .. " for range checking, and checking target for " .. UBERHEAL_BUFF3 .. " buff.";
	DEFAULT_CHAT_FRAME:AddMessage(str);
	str = "Spell # 4 is " .. UberHealConfig[UBERHEAL_PLAYERID]["Spell4"] .. ", Rank " .. UberHealConfig[UBERHEAL_PLAYERID]["Rank4"] .. ", and using actionbar slot " .. UBERHEAL_SLOT4 .. " for range checking, and checking target for " .. UBERHEAL_BUFF4 .. " buff.";
	DEFAULT_CHAT_FRAME:AddMessage(str);
	str = "Spell # 5 is " .. UberHealConfig[UBERHEAL_PLAYERID]["Spell5"] .. ", Rank " .. UberHealConfig[UBERHEAL_PLAYERID]["Rank5"] .. ", and using actionbar slot " .. UBERHEAL_SLOT5 .. " for range checking, and checking target for " .. UBERHEAL_BUFF5 .. " buff.";
	DEFAULT_CHAT_FRAME:AddMessage(str);

end







function ShowHideBuffs(myint)


	if (myint == 1) then
		if (BuffToggle1:GetChecked()) then
			DEFAULT_CHAT_FRAME:AddMessage(BuffToggle1:GetChecked());
			DEFAULT_CHAT_FRAME:AddMessage("booo");

			UBERHEAL_BUFFCHECK1 = 1;
			UberHealConfig[UBERHEAL_PLAYERID]["BuffCheck1"] = 1;
		else
			UBERHEAL_BUFFCHECK1 = 0;
			UberHealConfig[UBERHEAL_PLAYERID]["BuffCheck1"] = 0;
		end
	
	elseif (myint == 2) then
		if (BuffToggle2:GetChecked()) then
			UBERHEAL_BUFFCHECK2 = 1;
			UberHealConfig[UBERHEAL_PLAYERID]["BuffCheck2"] = 1;
		else
			UBERHEAL_BUFFCHECK2 = 0;
			UberHealConfig[UBERHEAL_PLAYERID]["BuffCheck2"] = 0;
		end
	
	elseif (myint == 3) then
		if (BuffToggle3:GetChecked()) then
			UBERHEAL_BUFFCHECK3 = 1;
			UberHealConfig[UBERHEAL_PLAYERID]["BuffCheck3"] = 1;
		else
			UBERHEAL_BUFFCHECK3 = 0;
			UberHealConfig[UBERHEAL_PLAYERID]["BuffCheck3"] = 0;
		end
	
	elseif (myint == 4) then
		if (BuffToggle4:GetChecked()) then
			UBERHEAL_BUFFCHECK4 = 1;
			UberHealConfig[UBERHEAL_PLAYERID]["BuffCheck4"] = 1;
		else
			UBERHEAL_BUFFCHECK4 = 0;
			UberHealConfig[UBERHEAL_PLAYERID]["BuffCheck4"] = 0;
		end
	
	elseif (myint == 5) then
		if (BuffToggle5:GetChecked()) then
			UBERHEAL_BUFFCHECK5 = 1;
			UberHealConfig[UBERHEAL_PLAYERID]["BuffCheck5"] = 1;
		else
			UBERHEAL_BUFFCHECK5 = 0;
			UberHealConfig[UBERHEAL_PLAYERID]["BuffCheck5"] = 0;
		end
	
	end




end





function UpdateSpellsOnMyClick()


		if (Rank1:GetText() == "") then
			UBERHEAL_SPELLSTRING1 = Spell1:GetText();
		else
			UBERHEAL_SPELLSTRING1 = Spell1:GetText() .. "(Rank " .. Rank1:GetText() .. ")";
		end

		if (Rank2:GetText() == "") then
			UBERHEAL_SPELLSTRING2 = Spell2:GetText();
		else
			UBERHEAL_SPELLSTRING2 = Spell2:GetText() .. "(Rank " .. Rank2:GetText() .. ")";
		end

		if (Rank3:GetText() == "") then
			UBERHEAL_SPELLSTRING3 = Spell3:GetText();
		else
			UBERHEAL_SPELLSTRING3 = Spell3:GetText() .. "(Rank " .. Rank3:GetText() .. ")";
		end

		if (Rank4:GetText() == "") then
			UBERHEAL_SPELLSTRING4 = Spell4:GetText();
		else
			UBERHEAL_SPELLSTRING4 = Spell4:GetText() .. "(Rank " .. Rank4:GetText() .. ")";
		end

		if (Rank5:GetText() == "") then
			UBERHEAL_SPELLSTRING5 = Spell5:GetText();
		else
			UBERHEAL_SPELLSTRING5 = Spell5:GetText() .. "(Rank " .. Rank5:GetText() .. ")";
		end


	UberHealConfig[UBERHEAL_PLAYERID]["Spell1"] = Spell1:GetText();
	UberHealConfig[UBERHEAL_PLAYERID]["Rank1"] = Rank1:GetText();
	UberHealConfig[UBERHEAL_PLAYERID]["Slot1"] = Slot1:GetText();
	UberHealConfig[UBERHEAL_PLAYERID]["Spell2"] = Spell2:GetText();
	UberHealConfig[UBERHEAL_PLAYERID]["Rank2"] = Rank2:GetText();
	UberHealConfig[UBERHEAL_PLAYERID]["Slot2"] = Slot2:GetText();
	UberHealConfig[UBERHEAL_PLAYERID]["Spell3"] = Spell3:GetText();
	UberHealConfig[UBERHEAL_PLAYERID]["Rank3"] = Rank3:GetText();
	UberHealConfig[UBERHEAL_PLAYERID]["Slot3"] = Slot3:GetText();
	UberHealConfig[UBERHEAL_PLAYERID]["Spell4"] = Spell4:GetText();
	UberHealConfig[UBERHEAL_PLAYERID]["Rank4"] = Rank4:GetText();
	UberHealConfig[UBERHEAL_PLAYERID]["Slot4"] = Slot4:GetText();
	UberHealConfig[UBERHEAL_PLAYERID]["Spell5"] = Spell5:GetText();
	UberHealConfig[UBERHEAL_PLAYERID]["Rank5"] = Rank5:GetText();
	UberHealConfig[UBERHEAL_PLAYERID]["Slot5"] = Slot5:GetText();



	UberHealSetup:Hide();
	

end

function ShowUberOptions()

	local playerClass, englishClass = UnitClass("player");


	if (englishClass == "PRIEST" or englishClass == "DRUID" or englishClass == "PALADIN" or englishClass == "SHAMAN") then 

		UberHealSetup:Show();
		if( UberHealConfig[UBERHEAL_PLAYERID]["Verbose"] == "0") then
			Slot1:Hide();
			Slot2:Hide();
			Slot3:Hide();
			Slot4:Hide();
			Slot5:Hide();
		else
			Slot1:Show();
			Slot2:Show();
			Slot3:Show();
			Slot4:Show();
			Slot5:Show();
		end
		
		
	end

end


function UberHealConfigure()

	-- this wont be called everytime the spellbook changes.  only when the options window open's and closes and when variables load.
--		DEFAULT_CHAT_FRAME:AddMessage("UBER HEAL CONFIGURE RAN");
	
	local i = 1;

	while (true) do
		local spellName, spellRank = GetSpellName(i, BOOKTYPE_SPELL);
		if (not spellName) then
			do break end;
		end


			local icon = GetSpellTexture(i, BOOKTYPE_SPELL);
			UberHeal_Range_Icons[icon] = spellName;


			if ((spellName == Spell1:GetText()) or (spellName == Spell2:GetText()) or (spellName == Spell3:GetText()) or (spellName == Spell4:GetText()) or (spellName == Spell5:GetText()) )  then

		   		if (spellName == Spell1:GetText()) then
					if (UBERHEAL_VERBOSE == 1) then 
			   			DEFAULT_CHAT_FRAME:AddMessage( "   SPELL " .. spellName .. " FOUND RANK " .. spellRank  );
					end
					UberHeal_FindActionSlot( UberHeal_Range_Icons, Spell1:GetText());
		   		end
		   		if (spellName == Spell2:GetText()) then
					if (UBERHEAL_VERBOSE == 1) then 
			   			DEFAULT_CHAT_FRAME:AddMessage( "   SPELL " .. spellName .. " FOUND RANK " .. spellRank  );
					end
					UberHeal_FindActionSlot( UberHeal_Range_Icons, Spell2:GetText());
		   		end
		   		if (spellName == Spell3:GetText()) then
					if (UBERHEAL_VERBOSE == 1) then 
			   			DEFAULT_CHAT_FRAME:AddMessage( "   SPELL " .. spellName .. " FOUND RANK " .. spellRank  );
					end
					UberHeal_FindActionSlot( UberHeal_Range_Icons, Spell3:GetText());
		   		end
		   		if (spellName == Spell4:GetText()) then
					if (UBERHEAL_VERBOSE == 1) then 
			   			DEFAULT_CHAT_FRAME:AddMessage( "   SPELL " .. spellName .. " FOUND RANK " .. spellRank  );
					end
					UberHeal_FindActionSlot( UberHeal_Range_Icons, Spell4:GetText());
		   		end
		   		if (spellName == Spell5:GetText()) then
					if (UBERHEAL_VERBOSE == 1) then 
			   			DEFAULT_CHAT_FRAME:AddMessage( "   SPELL " .. spellName .. " FOUND RANK " .. spellRank  );
					end
					UberHeal_FindActionSlot( UberHeal_Range_Icons, Spell5:GetText());
		   		end

			end
			

		i = i + 1;
	end
	

end
-------------------------------------------------------------------------------



function UberHeal_FindActionSlot( iconArray, mySpellName)
	local i = 0;
	for i = 1, 120 do
		if (HasAction(i)) then
			icon = GetActionTexture(i);
			if (iconArray[icon]) then
				if (GetActionText(i) == nil) then
					local spellName = iconArray[icon];

					if (spellName == mySpellName) then
						if (UBERHEAL_VERBOSE == 1) then 
					   		DEFAULT_CHAT_FRAME:AddMessage( "Found " ..mySpellName .." in action bar " .. i  );
						end
						
						if (Spell1:GetText() == mySpellName) then
							UBERHEAL_SLOT1 = i;
							Slot1:SetText(i);
						end
						if (Spell2:GetText() == mySpellName) then
							UBERHEAL_SLOT2 = i;
							Slot2:SetText(i);
						end
						if (Spell3:GetText() == mySpellName) then
							UBERHEAL_SLOT3 = i;
							Slot3:SetText(i);
						end
						if (Spell4:GetText() == mySpellName) then
							UBERHEAL_SLOT4 = i;
							Slot4:SetText(i);
						end
						if (Spell5:GetText() == mySpellName) then
							UBERHEAL_SLOT5 = i;
							Slot5:SetText(i);
						end
						
						
						
						
						return i;
					end
				end
			end
		end
	end
	DEFAULT_CHAT_FRAME:AddMessage( "UBERHEAL WARNING:  Could not find " .. mySpellName .. " on any of the action bars" );
	return 0;
end







function UberHealOnClick (button, targetName )


	local playerClass, englishClass = UnitClass("player");


	if (englishClass == "PRIEST" or englishClass == "DRUID" or englishClass == "PALADIN" or englishClass == "SHAMAN") then 


		TargetUnit( targetName );

			if (button == "LeftButton") then

				if ( 	IsShiftKeyDown() ) then
					if (UIDropDownMenu_GetSelectedValue(Spell1SelectionMenu)==5 and UIDropDownMenu_GetSelectedValue(Spell1ButtonMenu)==-2) then
						CastSpellByName(UBERHEAL_SPELLSTRING1);
						TargetLastTarget();
						return true;
					elseif (UIDropDownMenu_GetSelectedValue(Spell2SelectionMenu)==5 and UIDropDownMenu_GetSelectedValue(Spell2ButtonMenu)==-2) then
						CastSpellByName(UBERHEAL_SPELLSTRING2);
						TargetLastTarget();
						return true;
					elseif (UIDropDownMenu_GetSelectedValue(Spell3SelectionMenu)==5 and UIDropDownMenu_GetSelectedValue(Spell3ButtonMenu)==-2) then
						CastSpellByName(UBERHEAL_SPELLSTRING3);
						TargetLastTarget();
						return true;
					elseif (UIDropDownMenu_GetSelectedValue(Spell4SelectionMenu)==5 and UIDropDownMenu_GetSelectedValue(Spell4ButtonMenu)==-2) then
						CastSpellByName(UBERHEAL_SPELLSTRING4);
						TargetLastTarget();
						return true;
					elseif (UIDropDownMenu_GetSelectedValue(Spell5SelectionMenu)==5 and UIDropDownMenu_GetSelectedValue(Spell5ButtonMenu)==-2) then
						CastSpellByName(UBERHEAL_SPELLSTRING5);
						TargetLastTarget();
						return true;
					end	
				elseif( IsControlKeyDown() ) then
					if (UIDropDownMenu_GetSelectedValue(Spell1SelectionMenu)==3 and UIDropDownMenu_GetSelectedValue(Spell1ButtonMenu)==-2) then
						CastSpellByName(UBERHEAL_SPELLSTRING1);
						TargetLastTarget();
						return true;
					elseif (UIDropDownMenu_GetSelectedValue(Spell2SelectionMenu)==3 and UIDropDownMenu_GetSelectedValue(Spell2ButtonMenu)==-2) then
						CastSpellByName(UBERHEAL_SPELLSTRING2);
						TargetLastTarget();
						return true;
					elseif (UIDropDownMenu_GetSelectedValue(Spell3SelectionMenu)==3 and UIDropDownMenu_GetSelectedValue(Spell3ButtonMenu)==-2) then
						CastSpellByName(UBERHEAL_SPELLSTRING3);
						TargetLastTarget();
						return true;
					elseif (UIDropDownMenu_GetSelectedValue(Spell4SelectionMenu)==3 and UIDropDownMenu_GetSelectedValue(Spell4ButtonMenu)==-2) then
						CastSpellByName(UBERHEAL_SPELLSTRING4);
						TargetLastTarget();
						return true;
					elseif (UIDropDownMenu_GetSelectedValue(Spell5SelectionMenu)==3 and UIDropDownMenu_GetSelectedValue(Spell5ButtonMenu)==-2) then
						CastSpellByName(UBERHEAL_SPELLSTRING5);
						TargetLastTarget();
						return true;
					end	
				elseif ( IsAltKeyDown()  ) then
					if (UIDropDownMenu_GetSelectedValue(Spell1SelectionMenu)==4 and UIDropDownMenu_GetSelectedValue(Spell1ButtonMenu)==-2) then
						CastSpellByName(UBERHEAL_SPELLSTRING1);
						TargetLastTarget();
						return true;
					elseif (UIDropDownMenu_GetSelectedValue(Spell2SelectionMenu)==4 and UIDropDownMenu_GetSelectedValue(Spell2ButtonMenu)==-2) then
						CastSpellByName(UBERHEAL_SPELLSTRING2);
						TargetLastTarget();
						return true;
					elseif (UIDropDownMenu_GetSelectedValue(Spell3SelectionMenu)==4 and UIDropDownMenu_GetSelectedValue(Spell3ButtonMenu)==-2) then
						CastSpellByName(UBERHEAL_SPELLSTRING3);
						TargetLastTarget();
						return true;
					elseif (UIDropDownMenu_GetSelectedValue(Spell4SelectionMenu)==4 and UIDropDownMenu_GetSelectedValue(Spell4ButtonMenu)==-2) then
						CastSpellByName(UBERHEAL_SPELLSTRING4);
						TargetLastTarget();
						return true;
					elseif (UIDropDownMenu_GetSelectedValue(Spell5SelectionMenu)==4 and UIDropDownMenu_GetSelectedValue(Spell5ButtonMenu)==-2) then
						CastSpellByName(UBERHEAL_SPELLSTRING5);
						TargetLastTarget();
						return true;
					end	
				else
					if (UIDropDownMenu_GetSelectedValue(Spell1SelectionMenu)==2 and UIDropDownMenu_GetSelectedValue(Spell1ButtonMenu)==-2) then
						CastSpellByName(UBERHEAL_SPELLSTRING1);
						TargetLastTarget();
						return true;
					elseif (UIDropDownMenu_GetSelectedValue(Spell2SelectionMenu)==2 and UIDropDownMenu_GetSelectedValue(Spell2ButtonMenu)==-2) then
						CastSpellByName(UBERHEAL_SPELLSTRING2);
						TargetLastTarget();
						return true;
					elseif (UIDropDownMenu_GetSelectedValue(Spell3SelectionMenu)==2 and UIDropDownMenu_GetSelectedValue(Spell3ButtonMenu)==-2) then
						CastSpellByName(UBERHEAL_SPELLSTRING3);
						TargetLastTarget();
						return true;
					elseif (UIDropDownMenu_GetSelectedValue(Spell4SelectionMenu)==2 and UIDropDownMenu_GetSelectedValue(Spell4ButtonMenu)==-2) then
						CastSpellByName(UBERHEAL_SPELLSTRING4);
						TargetLastTarget();
						return true;
					elseif (UIDropDownMenu_GetSelectedValue(Spell5SelectionMenu)==2 and UIDropDownMenu_GetSelectedValue(Spell5ButtonMenu)==-2) then
						CastSpellByName(UBERHEAL_SPELLSTRING5);
						TargetLastTarget();
						return true;
					end	

				end

			elseif (button == "RightButton") then
				if ( 	IsShiftKeyDown() ) then
					if (UIDropDownMenu_GetSelectedValue(Spell1SelectionMenu)==5 and UIDropDownMenu_GetSelectedValue(Spell1ButtonMenu)==-4) then
						CastSpellByName(UBERHEAL_SPELLSTRING1);
						TargetLastTarget();
						return true;
					elseif (UIDropDownMenu_GetSelectedValue(Spell2SelectionMenu)==5 and UIDropDownMenu_GetSelectedValue(Spell2ButtonMenu)==-4) then
						CastSpellByName(UBERHEAL_SPELLSTRING2);
						TargetLastTarget();
						return true;
					elseif (UIDropDownMenu_GetSelectedValue(Spell3SelectionMenu)==5 and UIDropDownMenu_GetSelectedValue(Spell3ButtonMenu)==-4) then
						CastSpellByName(UBERHEAL_SPELLSTRING3);
						TargetLastTarget();
						return true;
					elseif (UIDropDownMenu_GetSelectedValue(Spell4SelectionMenu)==5 and UIDropDownMenu_GetSelectedValue(Spell4ButtonMenu)==-4) then
						CastSpellByName(UBERHEAL_SPELLSTRING4);
						TargetLastTarget();
						return true;
					elseif (UIDropDownMenu_GetSelectedValue(Spell5SelectionMenu)==5 and UIDropDownMenu_GetSelectedValue(Spell5ButtonMenu)==-4) then
						CastSpellByName(UBERHEAL_SPELLSTRING5);
						TargetLastTarget();
						return true;
					end	
				elseif( IsControlKeyDown() ) then
					if (UIDropDownMenu_GetSelectedValue(Spell1SelectionMenu)==3 and UIDropDownMenu_GetSelectedValue(Spell1ButtonMenu)==-4) then
						CastSpellByName(UBERHEAL_SPELLSTRING1);
						TargetLastTarget();
						return true;
					elseif (UIDropDownMenu_GetSelectedValue(Spell2SelectionMenu)==3 and UIDropDownMenu_GetSelectedValue(Spell2ButtonMenu)==-4) then
						CastSpellByName(UBERHEAL_SPELLSTRING2);
						TargetLastTarget();
						return true;
					elseif (UIDropDownMenu_GetSelectedValue(Spell3SelectionMenu)==3 and UIDropDownMenu_GetSelectedValue(Spell3ButtonMenu)==-4) then
						CastSpellByName(UBERHEAL_SPELLSTRING3);
						TargetLastTarget();
						return true;
					elseif (UIDropDownMenu_GetSelectedValue(Spell4SelectionMenu)==3 and UIDropDownMenu_GetSelectedValue(Spell4ButtonMenu)==-4) then
						CastSpellByName(UBERHEAL_SPELLSTRING4);
						TargetLastTarget();
						return true;
					elseif (UIDropDownMenu_GetSelectedValue(Spell5SelectionMenu)==3 and UIDropDownMenu_GetSelectedValue(Spell5ButtonMenu)==-4) then
						CastSpellByName(UBERHEAL_SPELLSTRING5);
						TargetLastTarget();
						return true;
					end	
				elseif ( IsAltKeyDown()  ) then
					if (UIDropDownMenu_GetSelectedValue(Spell1SelectionMenu)==4 and UIDropDownMenu_GetSelectedValue(Spell1ButtonMenu)==-4) then
						CastSpellByName(UBERHEAL_SPELLSTRING1);
						TargetLastTarget();
						return true;
					elseif (UIDropDownMenu_GetSelectedValue(Spell2SelectionMenu)==4 and UIDropDownMenu_GetSelectedValue(Spell2ButtonMenu)==-4) then
						CastSpellByName(UBERHEAL_SPELLSTRING2);
						TargetLastTarget();
						return true;
					elseif (UIDropDownMenu_GetSelectedValue(Spell3SelectionMenu)==4 and UIDropDownMenu_GetSelectedValue(Spell3ButtonMenu)==-4) then
						CastSpellByName(UBERHEAL_SPELLSTRING3);
						TargetLastTarget();
						return true;
					elseif (UIDropDownMenu_GetSelectedValue(Spell4SelectionMenu)==4 and UIDropDownMenu_GetSelectedValue(Spell4ButtonMenu)==-4) then
						CastSpellByName(UBERHEAL_SPELLSTRING4);
						TargetLastTarget();
						return true;
					elseif (UIDropDownMenu_GetSelectedValue(Spell5SelectionMenu)==4 and UIDropDownMenu_GetSelectedValue(Spell5ButtonMenu)==-4) then
						CastSpellByName(UBERHEAL_SPELLSTRING5);
						TargetLastTarget();
						return true;
					end	
				else
					if (UIDropDownMenu_GetSelectedValue(Spell1SelectionMenu)==2 and UIDropDownMenu_GetSelectedValue(Spell1ButtonMenu)==-4) then
						CastSpellByName(UBERHEAL_SPELLSTRING1);
						TargetLastTarget();
						return true;
					elseif (UIDropDownMenu_GetSelectedValue(Spell2SelectionMenu)==2 and UIDropDownMenu_GetSelectedValue(Spell2ButtonMenu)==-4) then
						CastSpellByName(UBERHEAL_SPELLSTRING2);
						TargetLastTarget();
						return true;
					elseif (UIDropDownMenu_GetSelectedValue(Spell3SelectionMenu)==2 and UIDropDownMenu_GetSelectedValue(Spell3ButtonMenu)==-4) then
						CastSpellByName(UBERHEAL_SPELLSTRING3);
						TargetLastTarget();
						return true;
					elseif (UIDropDownMenu_GetSelectedValue(Spell4SelectionMenu)==2 and UIDropDownMenu_GetSelectedValue(Spell4ButtonMenu)==-4) then
						CastSpellByName(UBERHEAL_SPELLSTRING4);
						TargetLastTarget();
						return true;
					elseif (UIDropDownMenu_GetSelectedValue(Spell5SelectionMenu)==2 and UIDropDownMenu_GetSelectedValue(Spell5ButtonMenu)==-4) then
						CastSpellByName(UBERHEAL_SPELLSTRING5);
						TargetLastTarget();
						return true;
					end	

				end
			elseif (button == "MiddleButton") then

				if ( 	IsShiftKeyDown() ) then
					if (UIDropDownMenu_GetSelectedValue(Spell1SelectionMenu)==5 and UIDropDownMenu_GetSelectedValue(Spell1ButtonMenu)==-3) then
						CastSpellByName(UBERHEAL_SPELLSTRING1);
						TargetLastTarget();
						return true;
					elseif (UIDropDownMenu_GetSelectedValue(Spell2SelectionMenu)==5 and UIDropDownMenu_GetSelectedValue(Spell2ButtonMenu)==-3) then
						CastSpellByName(UBERHEAL_SPELLSTRING2);
						TargetLastTarget();
						return true;
					elseif (UIDropDownMenu_GetSelectedValue(Spell3SelectionMenu)==5 and UIDropDownMenu_GetSelectedValue(Spell3ButtonMenu)==-3) then
						CastSpellByName(UBERHEAL_SPELLSTRING3);
						TargetLastTarget();
						return true;
					elseif (UIDropDownMenu_GetSelectedValue(Spell4SelectionMenu)==5 and UIDropDownMenu_GetSelectedValue(Spell4ButtonMenu)==-3) then
						CastSpellByName(UBERHEAL_SPELLSTRING4);
						TargetLastTarget();
						return true;
					elseif (UIDropDownMenu_GetSelectedValue(Spell5SelectionMenu)==5 and UIDropDownMenu_GetSelectedValue(Spell5ButtonMenu)==-3) then
						CastSpellByName(UBERHEAL_SPELLSTRING5);
						TargetLastTarget();
						return true;
					end	
				elseif( IsControlKeyDown() ) then
					if (UIDropDownMenu_GetSelectedValue(Spell1SelectionMenu)==3 and UIDropDownMenu_GetSelectedValue(Spell1ButtonMenu)==-3) then
						CastSpellByName(UBERHEAL_SPELLSTRING1);
						TargetLastTarget();
						return true;
					elseif (UIDropDownMenu_GetSelectedValue(Spell2SelectionMenu)==3 and UIDropDownMenu_GetSelectedValue(Spell2ButtonMenu)==-3) then
						CastSpellByName(UBERHEAL_SPELLSTRING2);
						TargetLastTarget();
						return true;
					elseif (UIDropDownMenu_GetSelectedValue(Spell3SelectionMenu)==3 and UIDropDownMenu_GetSelectedValue(Spell3ButtonMenu)==-3) then
						CastSpellByName(UBERHEAL_SPELLSTRING3);
						TargetLastTarget();
						return true;
					elseif (UIDropDownMenu_GetSelectedValue(Spell4SelectionMenu)==3 and UIDropDownMenu_GetSelectedValue(Spell4ButtonMenu)==-3) then
						CastSpellByName(UBERHEAL_SPELLSTRING4);
						TargetLastTarget();
						return true;
					elseif (UIDropDownMenu_GetSelectedValue(Spell5SelectionMenu)==3 and UIDropDownMenu_GetSelectedValue(Spell5ButtonMenu)==-3) then
						CastSpellByName(UBERHEAL_SPELLSTRING5);
						TargetLastTarget();
						return true;
					end	
				elseif ( IsAltKeyDown()  ) then
					if (UIDropDownMenu_GetSelectedValue(Spell1SelectionMenu)==4 and UIDropDownMenu_GetSelectedValue(Spell1ButtonMenu)==-3) then
						CastSpellByName(UBERHEAL_SPELLSTRING1);
						TargetLastTarget();
						return true;
					elseif (UIDropDownMenu_GetSelectedValue(Spell2SelectionMenu)==4 and UIDropDownMenu_GetSelectedValue(Spell2ButtonMenu)==-3) then
						CastSpellByName(UBERHEAL_SPELLSTRING2);
						TargetLastTarget();
						return true;
					elseif (UIDropDownMenu_GetSelectedValue(Spell3SelectionMenu)==4 and UIDropDownMenu_GetSelectedValue(Spell3ButtonMenu)==-3) then
						CastSpellByName(UBERHEAL_SPELLSTRING3);
						TargetLastTarget();
						return true;
					elseif (UIDropDownMenu_GetSelectedValue(Spell4SelectionMenu)==4 and UIDropDownMenu_GetSelectedValue(Spell4ButtonMenu)==-3) then
						CastSpellByName(UBERHEAL_SPELLSTRING4);
						TargetLastTarget();
						return true;
					elseif (UIDropDownMenu_GetSelectedValue(Spell5SelectionMenu)==4 and UIDropDownMenu_GetSelectedValue(Spell5ButtonMenu)==-3) then
						CastSpellByName(UBERHEAL_SPELLSTRING5);
						TargetLastTarget();
						return true;
					end	
				else
					if (UIDropDownMenu_GetSelectedValue(Spell1SelectionMenu)==2 and UIDropDownMenu_GetSelectedValue(Spell1ButtonMenu)==-3) then
						CastSpellByName(UBERHEAL_SPELLSTRING1);
						TargetLastTarget();
						return true;
					elseif (UIDropDownMenu_GetSelectedValue(Spell2SelectionMenu)==2 and UIDropDownMenu_GetSelectedValue(Spell2ButtonMenu)==-3) then
						CastSpellByName(UBERHEAL_SPELLSTRING2);
						TargetLastTarget();
						return true;
					elseif (UIDropDownMenu_GetSelectedValue(Spell3SelectionMenu)==2 and UIDropDownMenu_GetSelectedValue(Spell3ButtonMenu)==-3) then
						CastSpellByName(UBERHEAL_SPELLSTRING3);
						TargetLastTarget();
						return true;
					elseif (UIDropDownMenu_GetSelectedValue(Spell4SelectionMenu)==2 and UIDropDownMenu_GetSelectedValue(Spell4ButtonMenu)==-3) then
						CastSpellByName(UBERHEAL_SPELLSTRING4);
						TargetLastTarget();
						return true;
					elseif (UIDropDownMenu_GetSelectedValue(Spell5SelectionMenu)==2 and UIDropDownMenu_GetSelectedValue(Spell5ButtonMenu)==-3) then
						CastSpellByName(UBERHEAL_SPELLSTRING5);
						TargetLastTarget();
						return true;
					end	

				end


			elseif (button == "Button4") then
				if ( 	IsShiftKeyDown() ) then
					if (UIDropDownMenu_GetSelectedValue(Spell1SelectionMenu)==5 and UIDropDownMenu_GetSelectedValue(Spell1ButtonMenu)==-5) then
						CastSpellByName(UBERHEAL_SPELLSTRING1);
						TargetLastTarget();
						return true;
					elseif (UIDropDownMenu_GetSelectedValue(Spell2SelectionMenu)==5 and UIDropDownMenu_GetSelectedValue(Spell2ButtonMenu)==-5) then
						CastSpellByName(UBERHEAL_SPELLSTRING2);
						TargetLastTarget();
						return true;
					elseif (UIDropDownMenu_GetSelectedValue(Spell3SelectionMenu)==5 and UIDropDownMenu_GetSelectedValue(Spell3ButtonMenu)==-5) then
						CastSpellByName(UBERHEAL_SPELLSTRING3);
						TargetLastTarget();
						return true;
					elseif (UIDropDownMenu_GetSelectedValue(Spell4SelectionMenu)==5 and UIDropDownMenu_GetSelectedValue(Spell4ButtonMenu)==-5) then
						CastSpellByName(UBERHEAL_SPELLSTRING4);
						TargetLastTarget();
						return true;
					elseif (UIDropDownMenu_GetSelectedValue(Spell5SelectionMenu)==5 and UIDropDownMenu_GetSelectedValue(Spell5ButtonMenu)==-5) then
						CastSpellByName(UBERHEAL_SPELLSTRING5);
						TargetLastTarget();
						return true;
					end	
				elseif( IsControlKeyDown() ) then
					if (UIDropDownMenu_GetSelectedValue(Spell1SelectionMenu)==3 and UIDropDownMenu_GetSelectedValue(Spell1ButtonMenu)==-5) then
						CastSpellByName(UBERHEAL_SPELLSTRING1);
						TargetLastTarget();
						return true;
					elseif (UIDropDownMenu_GetSelectedValue(Spell2SelectionMenu)==3 and UIDropDownMenu_GetSelectedValue(Spell2ButtonMenu)==-5) then
						CastSpellByName(UBERHEAL_SPELLSTRING2);
						TargetLastTarget();
						return true;
					elseif (UIDropDownMenu_GetSelectedValue(Spell3SelectionMenu)==3 and UIDropDownMenu_GetSelectedValue(Spell3ButtonMenu)==-5) then
						CastSpellByName(UBERHEAL_SPELLSTRING3);
						TargetLastTarget();
						return true;
					elseif (UIDropDownMenu_GetSelectedValue(Spell4SelectionMenu)==3 and UIDropDownMenu_GetSelectedValue(Spell4ButtonMenu)==-5) then
						CastSpellByName(UBERHEAL_SPELLSTRING4);
						TargetLastTarget();
						return true;
					elseif (UIDropDownMenu_GetSelectedValue(Spell5SelectionMenu)==3 and UIDropDownMenu_GetSelectedValue(Spell5ButtonMenu)==-5) then
						CastSpellByName(UBERHEAL_SPELLSTRING5);
						TargetLastTarget();
						return true;
					end	
				elseif ( IsAltKeyDown()  ) then
					if (UIDropDownMenu_GetSelectedValue(Spell1SelectionMenu)==4 and UIDropDownMenu_GetSelectedValue(Spell1ButtonMenu)==-5) then
						CastSpellByName(UBERHEAL_SPELLSTRING1);
						TargetLastTarget();
						return true;
					elseif (UIDropDownMenu_GetSelectedValue(Spell2SelectionMenu)==4 and UIDropDownMenu_GetSelectedValue(Spell2ButtonMenu)==-5) then
						CastSpellByName(UBERHEAL_SPELLSTRING2);
						TargetLastTarget();
						return true;
					elseif (UIDropDownMenu_GetSelectedValue(Spell3SelectionMenu)==4 and UIDropDownMenu_GetSelectedValue(Spell3ButtonMenu)==-5) then
						CastSpellByName(UBERHEAL_SPELLSTRING3);
						TargetLastTarget();
						return true;
					elseif (UIDropDownMenu_GetSelectedValue(Spell4SelectionMenu)==4 and UIDropDownMenu_GetSelectedValue(Spell4ButtonMenu)==-5) then
						CastSpellByName(UBERHEAL_SPELLSTRING4);
						TargetLastTarget();
						return true;
					elseif (UIDropDownMenu_GetSelectedValue(Spell5SelectionMenu)==4 and UIDropDownMenu_GetSelectedValue(Spell5ButtonMenu)==-5) then
						CastSpellByName(UBERHEAL_SPELLSTRING5);
						TargetLastTarget();
						return true;
					end	
				else
					if (UIDropDownMenu_GetSelectedValue(Spell1SelectionMenu)==2 and UIDropDownMenu_GetSelectedValue(Spell1ButtonMenu)==-5) then
						CastSpellByName(UBERHEAL_SPELLSTRING1);
						TargetLastTarget();
						return true;
					elseif (UIDropDownMenu_GetSelectedValue(Spell2SelectionMenu)==2 and UIDropDownMenu_GetSelectedValue(Spell2ButtonMenu)==-5) then
						CastSpellByName(UBERHEAL_SPELLSTRING2);
						TargetLastTarget();
						return true;
					elseif (UIDropDownMenu_GetSelectedValue(Spell3SelectionMenu)==2 and UIDropDownMenu_GetSelectedValue(Spell3ButtonMenu)==-5) then
						CastSpellByName(UBERHEAL_SPELLSTRING3);
						TargetLastTarget();
						return true;
					elseif (UIDropDownMenu_GetSelectedValue(Spell4SelectionMenu)==2 and UIDropDownMenu_GetSelectedValue(Spell4ButtonMenu)==-5) then
						CastSpellByName(UBERHEAL_SPELLSTRING4);
						TargetLastTarget();
						return true;
					elseif (UIDropDownMenu_GetSelectedValue(Spell5SelectionMenu)==2 and UIDropDownMenu_GetSelectedValue(Spell5ButtonMenu)==-5) then
						CastSpellByName(UBERHEAL_SPELLSTRING5);
						TargetLastTarget();
						return true;
					end	

				end


			elseif (button == "Button5") then
				if ( 	IsShiftKeyDown() ) then
					if (UIDropDownMenu_GetSelectedValue(Spell1SelectionMenu)==5 and UIDropDownMenu_GetSelectedValue(Spell1ButtonMenu)==-6) then
						CastSpellByName(UBERHEAL_SPELLSTRING1);
						TargetLastTarget();
						return true;
					elseif (UIDropDownMenu_GetSelectedValue(Spell2SelectionMenu)==5 and UIDropDownMenu_GetSelectedValue(Spell2ButtonMenu)==-6) then
						CastSpellByName(UBERHEAL_SPELLSTRING2);
						TargetLastTarget();
						return true;
					elseif (UIDropDownMenu_GetSelectedValue(Spell3SelectionMenu)==5 and UIDropDownMenu_GetSelectedValue(Spell3ButtonMenu)==-6) then
						CastSpellByName(UBERHEAL_SPELLSTRING3);
						TargetLastTarget();
						return true;
					elseif (UIDropDownMenu_GetSelectedValue(Spell4SelectionMenu)==5 and UIDropDownMenu_GetSelectedValue(Spell4ButtonMenu)==-6) then
						CastSpellByName(UBERHEAL_SPELLSTRING4);
						TargetLastTarget();
						return true;
					elseif (UIDropDownMenu_GetSelectedValue(Spell5SelectionMenu)==5 and UIDropDownMenu_GetSelectedValue(Spell5ButtonMenu)==-6) then
						CastSpellByName(UBERHEAL_SPELLSTRING5);
						TargetLastTarget();
						return true;
					end	
				elseif( IsControlKeyDown() ) then
					if (UIDropDownMenu_GetSelectedValue(Spell1SelectionMenu)==3 and UIDropDownMenu_GetSelectedValue(Spell1ButtonMenu)==-6) then
						CastSpellByName(UBERHEAL_SPELLSTRING1);
						TargetLastTarget();
						return true;
					elseif (UIDropDownMenu_GetSelectedValue(Spell2SelectionMenu)==3 and UIDropDownMenu_GetSelectedValue(Spell2ButtonMenu)==-6) then
						CastSpellByName(UBERHEAL_SPELLSTRING2);
						TargetLastTarget();
						return true;
					elseif (UIDropDownMenu_GetSelectedValue(Spell3SelectionMenu)==3 and UIDropDownMenu_GetSelectedValue(Spell3ButtonMenu)==-6) then
						CastSpellByName(UBERHEAL_SPELLSTRING3);
						TargetLastTarget();
						return true;
					elseif (UIDropDownMenu_GetSelectedValue(Spell4SelectionMenu)==3 and UIDropDownMenu_GetSelectedValue(Spell4ButtonMenu)==-6) then
						CastSpellByName(UBERHEAL_SPELLSTRING4);
						TargetLastTarget();
						return true;
					elseif (UIDropDownMenu_GetSelectedValue(Spell5SelectionMenu)==3 and UIDropDownMenu_GetSelectedValue(Spell5ButtonMenu)==-6) then
						CastSpellByName(UBERHEAL_SPELLSTRING5);
						TargetLastTarget();
						return true;
					end	
				elseif ( IsAltKeyDown()  ) then
					if (UIDropDownMenu_GetSelectedValue(Spell1SelectionMenu)==4 and UIDropDownMenu_GetSelectedValue(Spell1ButtonMenu)==-6) then
						CastSpellByName(UBERHEAL_SPELLSTRING1);
						TargetLastTarget();
						return true;
					elseif (UIDropDownMenu_GetSelectedValue(Spell2SelectionMenu)==4 and UIDropDownMenu_GetSelectedValue(Spell2ButtonMenu)==-6) then
						CastSpellByName(UBERHEAL_SPELLSTRING2);
						TargetLastTarget();
						return true;
					elseif (UIDropDownMenu_GetSelectedValue(Spell3SelectionMenu)==4 and UIDropDownMenu_GetSelectedValue(Spell3ButtonMenu)==-6) then
						CastSpellByName(UBERHEAL_SPELLSTRING3);
						TargetLastTarget();
						return true;
					elseif (UIDropDownMenu_GetSelectedValue(Spell4SelectionMenu)==4 and UIDropDownMenu_GetSelectedValue(Spell4ButtonMenu)==-6) then
						CastSpellByName(UBERHEAL_SPELLSTRING4);
						TargetLastTarget();
						return true;
					elseif (UIDropDownMenu_GetSelectedValue(Spell5SelectionMenu)==4 and UIDropDownMenu_GetSelectedValue(Spell5ButtonMenu)==-6) then
						CastSpellByName(UBERHEAL_SPELLSTRING5);
						TargetLastTarget();
						return true;
					end	
				else
					if (UIDropDownMenu_GetSelectedValue(Spell1SelectionMenu)==2 and UIDropDownMenu_GetSelectedValue(Spell1ButtonMenu)==-6) then
						CastSpellByName(UBERHEAL_SPELLSTRING1);
						TargetLastTarget();
						return true;
					elseif (UIDropDownMenu_GetSelectedValue(Spell2SelectionMenu)==2 and UIDropDownMenu_GetSelectedValue(Spell2ButtonMenu)==-6) then
						CastSpellByName(UBERHEAL_SPELLSTRING2);
						TargetLastTarget();
						return true;
					elseif (UIDropDownMenu_GetSelectedValue(Spell3SelectionMenu)==2 and UIDropDownMenu_GetSelectedValue(Spell3ButtonMenu)==-6) then
						CastSpellByName(UBERHEAL_SPELLSTRING3);
						TargetLastTarget();
						return true;
					elseif (UIDropDownMenu_GetSelectedValue(Spell4SelectionMenu)==2 and UIDropDownMenu_GetSelectedValue(Spell4ButtonMenu)==-6) then
						CastSpellByName(UBERHEAL_SPELLSTRING4);
						TargetLastTarget();
						return true;
					elseif (UIDropDownMenu_GetSelectedValue(Spell5SelectionMenu)==2 and UIDropDownMenu_GetSelectedValue(Spell5ButtonMenu)==-6) then
						CastSpellByName(UBERHEAL_SPELLSTRING5);
						TargetLastTarget();
						return true;
					end	

				end


			end


		return false;
	
	else
		return false;
	
	end
	
	
end



function UberHealOnClick_IconDragging_OnUpdate(arg1)
	local xpos,ypos = GetCursorPosition();
	local xmin,ymin = Minimap:GetLeft(), Minimap:GetBottom();

	xpos = xmin-xpos/Minimap:GetEffectiveScale()+70;
	ypos = ypos/Minimap:GetEffectiveScale()-ymin-70;

	ICONPOSITION = math.deg(math.atan2(ypos,xpos));
	UberHealOnClick_Minimap:SetPoint("TOPLEFT","Minimap","TOPLEFT",52-(80*cos(ICONPOSITION or 45)),(80*sin(ICONPOSITION or 45))-52);
	UberHealConfig["IconPosition"] = ICONPOSITION;


end

function UberHealOnClick_IconFrame_OnClick(arg1)

	if (arg1=="LeftButton") then

		if (UberHealSetup:IsVisible()) then
			PlaySound( "igMainMenuOption" );
			UberHealSetup:Hide();

		else
			PlaySound( "igMainMenuOption" );
			ShowUberOptions();
		end

	end

end




function UberUseSquishy()

	UberAutoTargetFunction = 2;
	UberCTRaidToggle:SetChecked(false);
	UberSquishyToggle:SetChecked(true);


	PrimaryThresholdSlider:SetMinMaxValues(1,5);
	SecondaryThresholdSlider:SetMinMaxValues(1,5);
	PrimaryThresholdSlider:SetValue(1);
	SecondaryThresholdSlider:SetValue(3);



end





function UberUseCTRaid()

	UberAutoTargetFunction = 1;
	UberCTRaidToggle:SetChecked(true);
	UberSquishyToggle:SetChecked(false);


	PrimaryThresholdSlider:SetMinMaxValues(1,5);
	SecondaryThresholdSlider:SetMinMaxValues(1,5);
	PrimaryThresholdSlider:SetValue(1);
	SecondaryThresholdSlider:SetValue(2);




end




function SaveAdvanced()
	UberHealConfig[UBERHEAL_PLAYERID]["PrimaryValue"] = PrimaryThresholdSlider:GetValue();
	UberHealConfig[UBERHEAL_PLAYERID]["SecondaryValue"] = SecondaryThresholdSlider:GetValue();
end




CT_RA_CustomOnClickFunction = UberHealOnClick;
Perl_Custom_ClickFunction = UberHealOnClick;
SquishyCustomClick = UberHealOnClick;
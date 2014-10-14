--[[

PanzaPHM.lua
Panza Healing Module (PHM) Dialog
Revision 4.0

10-01-06 "for in pairs()" completed for BC
--]]

local CurrentTrinket = {};
local PanzaTrinket_SavedBagFunc = nil;
local PanzaTrinket_SavedInvFunc = nil;


function PA:PHM_OnLoad()
	PA.OptionsMenuTree[4] = {Title="Healing", Frame=this, Tooltip="Healing Options", Check=true, Sub={}, Filter={Spell="Heal"}};
	PA.OptionsMenuTree[4].Sub[1] = {Title="Advanced", Frame=PanzaPHMAdvancedFrame, Tooltip="Advanced Healing Options"};
	PA.OptionsMenuTree[4].Sub[2] = {Title="Biases", Frame=PanzaPHMBiasFrame, Tooltip="Bias Options"};
	PA.OptionsMenuTree[4].Sub[3] = {Title="Panic", Frame=PanzaPPMFrame, Tooltip="Panic Options"};
	PA.GUIFrames[this:GetName()] = this;
	UIPanelWindows[this:GetName()] = {area = "center", pushable = 0};
end

function PA:PHM_SetValues()
	SliderPanzaMinTH:SetValue(PASettings.Heal.MinTH * 100);
	SliderPanzaOverHeal:SetValue(PASettings.Heal.OverHeal * 100);
	SliderPanzaFlash:SetValue(PASettings.Heal.Flash * 100);
	SliderPanzaMid:SetValue(PASettings.Heal.MidHealth * 100);
    SliderPanzaLowFlash:SetValue(PASettings.Heal.LowFlash * 100);
	SliderPanzaPetTH:SetValue(PASettings.Heal.PetTH * 100);
	cbxPanzaOOCHealing:SetChecked(PASettings.Heal.OOCHealing==true);

	PA:PHM_UpdateFlash();
	PA:PHM_UpdateMid();
	PA:PHM_UpdateLowFlash();
	PA:PHM_UpdatePetTH();
	PA:PHM_UpdateOverHeal();

	
	if (PA.PlayerClass=="DRUID" and PA:SpellInSpellBook("FLASH")) then
		PA:EnableCheckBox(cbxPanzaHealUseRegrowth);
		cbxPanzaHealUseRegrowth:SetChecked(PASettings.Heal.UseRegrowth==true);
	else
		PA:DisableCheckBox(cbxPanzaHealUseRegrowth);
		cbxPanzaHealUseRegrowth:Disable();
	end

	if (PA:SpellInSpellBook("HOT")) then
		PA:EnableCheckBox(cbxPanzaHealUseHoTs);
		cbxPanzaHealUseHoTs:SetChecked(PASettings.Heal.UseHoTs==true);
		PA:EnableCheckBox(cbxPanzaHealHotMove);
		cbxPanzaHealHotMove:SetChecked(PASettings.Heal.HoTOnMove==true);
	else
		PA:DisableCheckBox(cbxPanzaHealUseHoTs);
		PA:DisableCheckBox(cbxPanzaHealHotMove);
	end

	PA:PHM_Drawbar();

end

function PA:PHM_Defaults()
	PASettings["Heal"]				= {};
	PASettings.Heal["Flash"]		= 0.70;
	PASettings.Heal["PetTH"]		= 0.90;
	PASettings.Heal["MinTH"]		= 0.98;
	PASettings.Heal["OverHeal"]		= 1.0;
	PASettings.Heal["LowFlash"] 	= 0.10;
	PASettings.Heal["MidHealth"] 	= 0.50;
	PASettings.Heal.OOCHealing 		= true;
	PASettings.Heal.UseHoTs			= true;
	PASettings.Heal.UseRegrowth		= true;
	PASettings.Heal.HoTOnMove		= true;
	PA:PHMBias_Defaults();
	PA:PHMAdvanced_Defaults();
	PA:DefaultHealZoneSteps();
end

function PA:DefaultHealZoneSteps()
	PASettings.Heal.ZoneSteps = {};
	PASettings.Heal.ZoneSteps[5] = {};
	if (PA.PlayerClass=="PRIEST") then
		PASettings.Heal.ZoneSteps[4] = {};
		table.insert(PASettings.Heal.ZoneSteps[4], {Spell="HOT", Condition="Always"});
		table.insert(PASettings.Heal.ZoneSteps[4], {Spell="FLASH", Condition="Always"});
		table.insert(PASettings.Heal.ZoneSteps[4], {Spell="GREATERHEAL", Condition="Always"});
		table.insert(PASettings.Heal.ZoneSteps[4], {Spell="HEAL", Condition="Always"});
		table.insert(PASettings.Heal.ZoneSteps[4], {Spell="LESSERHEAL", Condition="Always"});
		PASettings.Heal.ZoneSteps[3] = {};
		table.insert(PASettings.Heal.ZoneSteps[3], {Spell="HOT", Condition="Always"});
		table.insert(PASettings.Heal.ZoneSteps[3], {Spell="GREATERHEAL", Condition="Always"});
		table.insert(PASettings.Heal.ZoneSteps[3], {Spell="HEAL", Condition="Always"});
		table.insert(PASettings.Heal.ZoneSteps[3], {Spell="LESSERHEAL", Condition="Always"});
		PASettings.Heal.ZoneSteps[2] = {};
		table.insert(PASettings.Heal.ZoneSteps[2], {Spell="GREATERHEAL", Condition="Always"});
		table.insert(PASettings.Heal.ZoneSteps[2], {Spell="HEAL", Condition="Always"});
		table.insert(PASettings.Heal.ZoneSteps[2], {Spell="LESSERHEAL", Condition="Always"});
		PASettings.Heal.ZoneSteps[1] = {};
		table.insert(PASettings.Heal.ZoneSteps[1], {Spell="FLASH", Condition="Always"});
		table.insert(PASettings.Heal.ZoneSteps[1], {Spell="GREATERHEAL", Condition="Always"});
		table.insert(PASettings.Heal.ZoneSteps[1], {Spell="HEAL", Condition="Always"});
		table.insert(PASettings.Heal.ZoneSteps[1], {Spell="LESSERHEAL", Condition="Always"});
	elseif (PA.PlayerClass=="DRUID") then
		PASettings.Heal.ZoneSteps[4] = {};
		table.insert(PASettings.Heal.ZoneSteps[4], {Spell="HOT", Condition="Always"});
		table.insert(PASettings.Heal.ZoneSteps[4], {Spell="HEAL", Condition="Always"});
		PASettings.Heal.ZoneSteps[3] = {};
		table.insert(PASettings.Heal.ZoneSteps[3], {Spell="FLASH", Condition="Always"});
		table.insert(PASettings.Heal.ZoneSteps[3], {Spell="HEAL", Condition="Always"});
		PASettings.Heal.ZoneSteps[2] = {};
		table.insert(PASettings.Heal.ZoneSteps[2], {Spell="HEAL", Condition="Always"});
		PASettings.Heal.ZoneSteps[1] = {};
		table.insert(PASettings.Heal.ZoneSteps[1], {Spell="FLASH", Condition="Always"});
		table.insert(PASettings.Heal.ZoneSteps[1], {Spell="HEAL", Condition="Always"});
	else
		PASettings.Heal.ZoneSteps[4] = {};
		table.insert(PASettings.Heal.ZoneSteps[4], {Spell="FLASH", Condition="Always"});
		table.insert(PASettings.Heal.ZoneSteps[4], {Spell="HEAL", Condition="Always"});
		PASettings.Heal.ZoneSteps[3] = {};
		table.insert(PASettings.Heal.ZoneSteps[3], {Spell="HEAL", Condition="Always"});
		PASettings.Heal.ZoneSteps[2] = {};
		table.insert(PASettings.Heal.ZoneSteps[2], {Spell="HEAL", Condition="Always"});
		PASettings.Heal.ZoneSteps[1] = {};
		table.insert(PASettings.Heal.ZoneSteps[1], {Spell="FLASH", Condition="Always"});
		table.insert(PASettings.Heal.ZoneSteps[1], {Spell="HEAL", Condition="Always"});
	end
end


-- Draw the Healing Indicator bar
function PA:PHM_Drawbar()
	local MaxWidth = PanzaPHMFramePanel1:GetWidth() - 110;
	local CombatFlag = (PASettings.Heal.OOCHealing==false or PanzaPHMFramePanel1BarOOC:GetChecked()==1);

	-- No heals
	local NoneSpan = 1.0 - PASettings.Heal.MinTH;
	if (NoneSpan<0.0001) then
		NoneSpan = 0.0001;
	end
	if (NoneSpan>1) then
		NoneSpan = 1;
	end
	--PA:ShowText("NoneSpan=", NoneSpan);
	PanzaPHMFramePanel1BarNone:SetWidth(NoneSpan * MaxWidth);
	if (NoneSpan==0.0001) then
		PanzaPHMFramePanel1BarNone:Hide();
	else
		PanzaPHMFramePanel1BarNone:Show();
	end

	-- High Health
	local HighSpan;
	if (CombatFlag or not PA:SpellInSpellBook("HOT")) then
		HighSpan = PASettings.Heal.MinTH - PASettings.Heal.Flash;
		if (HighSpan<0.0001) then
			HighSpan = 0.0001;
		end
		if (HighSpan>1) then
			HighSpan = 1;
		end
	else
		HighSpan = 0.0001;
	end
	--PA:ShowText("HighSpan=", HighSpan);
	PanzaPHMFramePanel1BarHigh:SetWidth(HighSpan * MaxWidth);
	if (HighSpan==0.0001) then
		PanzaPHMFramePanel1BarHigh:Hide();
	else
		PanzaPHMFramePanel1BarHigh:Show();
	end

	-- Low Health
	local LowSpan;
	if (CombatFlag) then
		LowSpan = PASettings.Heal.LowFlash;
		if (LowSpan>PASettings.Heal.MidHealth) then
			LowSpan = PASettings.Heal.MidHealth;
		end
		if (LowSpan>PASettings.Heal.MinTH) then
			LowSpan = PASettings.Heal.MinTH;
		end
		if (LowSpan<0.0001) then
			LowSpan = 0.0001;
		end
		if ((LowSpan + HighSpan + NoneSpan)>1) then
			LowSpan = 1 - HighSpan - NoneSpan;
			if (LowSpan<0.0001) then
				LowSpan = 0.0001;
			end
		end
		if (LowSpan>1) then
			LowSpan = 1;
		end
	else
		LowSpan = 0.0001;
	end
	--PA:ShowText("LowSpan=", LowSpan);
	PanzaPHMFramePanel1BarLow:SetWidth(LowSpan * MaxWidth);
	if (LowSpan==0.0001) then
		PanzaPHMFramePanel1BarLow:Hide();
	else
		PanzaPHMFramePanel1BarLow:Show();
	end

	-- Mid Health
	local MidSpan = PASettings.Heal.MidHealth - LowSpan;
	if (PASettings.Heal.MinTH<PASettings.Heal.MidHealth or (not CombatFlag and PA:SpellInSpellBook("HOT"))) then
		MidSpan = PASettings.Heal.MinTH - LowSpan;
	end
	if (MidSpan<0.0001) then
		MidSpan = 0.0001;
	end
	if ((MidSpan + HighSpan + LowSpan + NoneSpan)>1) then
		MidSpan = 1 - HighSpan - LowSpan - NoneSpan;
		if (MidSpan<0.0001) then
			MidSpan = 0.0001;
		end
	end
	--PA:ShowText("MidSpan=", MidSpan);
	PanzaPHMFramePanel1BarMid:SetWidth(MidSpan * MaxWidth);
	if (MidSpan==0.0001) then
		PanzaPHMFramePanel1BarMid:Hide();
	else
		PanzaPHMFramePanel1BarMid:Show();
	end

	-- Mid Health2
	local MidSpan2 = PASettings.Heal.Flash - LowSpan - MidSpan;
	if (PASettings.Heal.MinTH<PASettings.Heal.Flash or (not CombatFlag and PA:SpellInSpellBook("HOT"))) then
		MidSpan2 = PASettings.Heal.MinTH - LowSpan - MidSpan;
	end
	if (MidSpan2<0.0001) then
		MidSpan2 = 0.0001;
	end
	if ((MidSpan2 + MidSpan + HighSpan + LowSpan + NoneSpan)>1) then
		MidSpan = 1 - HighSpan - LowSpan - NoneSpan - MidSpan;
		if (MidSpan2<0.0001) then
			MidSpan2 = 0.0001;
		end
	end
	--PA:ShowText("MidSpan=", MidSpan);
	PanzaPHMFramePanel1BarMid2:SetWidth(MidSpan2 * MaxWidth);
	if (MidSpan2==0.0001) then
		PanzaPHMFramePanel1BarMid2:Hide();
	else
		PanzaPHMFramePanel1BarMid2:Show();
	end

	-- Pet Health
	local PetSpan = PASettings.Heal.PetTH;
	if (PetSpan<0.0001) then
		PetSpan = 0.0001;
	end
	if (PetSpan>1) then
		PetSpan = 1;
	end
	PanzaPHMFramePanel1BarPets:SetWidth(PetSpan * MaxWidth);
	if (PetSpan==0.0001) then
		PanzaPHMFramePanel1BarPets:Hide();
	else
		PanzaPHMFramePanel1BarPets:Show();
	end

	if (PASettings.Heal.OOCHealing==true) then
		PanzaPHMFramePanel1BarOOC:Show();
	else
		PanzaPHMFramePanel1BarOOC:Hide();
	end

end

function PA:HealingBarClick()
	local LastID = PA.CurrentZone;
	PA.CurrentZone = this:GetParent():GetID();
	--PA:ShowText("HealingBarClick id=", PA.CurrentZone);
	if (LastID==PA.CurrentZone) then
		-- Same Zone
		if (not PA_ZoneStepsFrame:IsVisible()) then
			PA.CurrentZoneSteps = PA:CopyTable(PASettings.Heal.ZoneSteps[PA.CurrentZone]);
			--PA:ShowText("Resisplay Zone ", PA.CurrentZone, " temp=", PA.CurrentZoneSteps, " orig=", PASettings.Heal.ZoneSteps[PA.CurrentZone]);
		end
		PA:FrameToggle(PA_ZoneStepsFrame);
	else
		-- New Zone
		PA.CurrentZoneSteps = PA:CopyTable(PASettings.Heal.ZoneSteps[PA.CurrentZone]);
		--PA:ShowText("New Zone ", PA.CurrentZone, " temp=", PA.CurrentZoneSteps, " orig=", PASettings.Heal.ZoneSteps[PA.CurrentZone]);
		if (PA_ZoneStepsFrame:IsVisible()) then
			PA:PHM_ZoneStepsOnShow();
		else
			PA_ZoneStepsFrame:Show();
		end
	end
	PA.CurrentFocus = nil;
end

function PA:PHM_ZoneStepsOnLoad()
end

function PA:PHM_ZoneStepsOnShow()
	--PA:ShowText("PHM_ZoneStepsOnShow id=", PA.CurrentZone);
	PA_ZoneStepsFrameTitle:SetText(PANZA_PHM_ZONETITLES[PA.CurrentZone]);
	PA:ZoneStepsDropDown_InitAllDropDowns();
end


function PA:ZoneStepsDropDown_InitAllDropDowns()
	-- Initialize action drop-downs
	for index = 1, 9 do
		PA:ZoneInitializeStep(index);
	end
end

function PA:ZoneInitializeStep(index)
	UIDropDownMenu_Initialize(getglobal("PA_ZoneAction"..index.."Actions"), getglobal("PA_ZoneActionDropDown_Initialize"..index));
	UIDropDownMenu_Initialize(getglobal("PA_ZoneAction"..index.."Conditions"), getglobal("PA_ZoneConditionDropDown_Initialize"..index));
	PA:ZoneInitializeModifier(index);
end

function PA:ZoneInitializeModifier(index)
	local Hide = true;
	local InputBox = getglobal("PA_ZoneAction"..index.."Modifier");
	local Step = PA.CurrentZoneSteps[index];
	if (Step~=nil) then
		if (Step.Condition~=nil) then
			local Modifier = PA.HealConditions[Step.Condition].Modifier;
			if (Modifier~="NONE") then
				InputBox:SetText(Step.Modifier or "");
				Hide = false;
				local Units = getglobal("PA_ZoneAction"..index.."ModifierUnits");
				if (Modifier~="TEXT") then
					--InputBox:SetNumeric(true);
					Units:SetText(Modifier);
				else
					--InputBox:SetNumeric(false);
					Units:SetText("");
				end
			end
		end
	end	
	if (Hide) then
		InputBox:Hide();
	elseif (not InputBox:IsVisible()) then
		InputBox:Show();
	end
end

function PA:ZoneSetModifier(index, text)
	local Step = PA.CurrentZoneSteps[index];
	if (Step~=nil) then
		Step.Modifier = text;
	end
end

function PA_ZoneActionDropDown_Initialize1()
	PA:ZoneStepsDropDown_Initialize(1);
end
function PA_ZoneActionDropDown_Initialize2()
	PA:ZoneStepsDropDown_Initialize(2);
end
function PA_ZoneActionDropDown_Initialize3()
	PA:ZoneStepsDropDown_Initialize(3);
end
function PA_ZoneActionDropDown_Initialize4()
	PA:ZoneStepsDropDown_Initialize(4);
end
function PA_ZoneActionDropDown_Initialize5()
	PA:ZoneStepsDropDown_Initialize(5);
end
function PA_ZoneActionDropDown_Initialize6()
	PA:ZoneStepsDropDown_Initialize(6);
end
function PA_ZoneActionDropDown_Initialize7()
	PA:ZoneStepsDropDown_Initialize(7);
end
function PA_ZoneActionDropDown_Initialize8()
	PA:ZoneStepsDropDown_Initialize(8);
end
function PA_ZoneActionDropDown_Initialize9()
	PA:ZoneStepsDropDown_Initialize(9);
end

function PA_ZoneConditionDropDown_Initialize1()
	PA:ZoneConditionDropDown_Initialize(1);
end
function PA_ZoneConditionDropDown_Initialize2()
	PA:ZoneConditionDropDown_Initialize(2);
end
function PA_ZoneConditionDropDown_Initialize3()
	PA:ZoneConditionDropDown_Initialize(3);
end
function PA_ZoneConditionDropDown_Initialize4()
	PA:ZoneConditionDropDown_Initialize(4);
end
function PA_ZoneConditionDropDown_Initialize5()
	PA:ZoneConditionDropDown_Initialize(5);
end
function PA_ZoneConditionDropDown_Initialize6()
	PA:ZoneConditionDropDown_Initialize(6);
end
function PA_ZoneConditionDropDown_Initialize7()
	PA:ZoneConditionDropDown_Initialize(7);
end
function PA_ZoneConditionDropDown_Initialize8()
	PA:ZoneConditionDropDown_Initialize(8);
end
function PA_ZoneConditionDropDown_Initialize9()
	PA:ZoneConditionDropDown_Initialize(9);
end


-----------------------------------------
-- Populate the dropdown list with Actions
-----------------------------------------
function PA:ZoneStepsDropDown_Initialize(index)
    if (PA:CheckMessageLevel('UI', 5)) then
	    PA:Message4('ZoneStepsDropDown_Initialize() index='..index);
	   end
	--PA:ShowText("Initialise dd index=", index);

	local Dd = getglobal("PA_ZoneAction"..index.."Actions");
	local HealActions = {"HEAL", "FLASH"};
	if (PA.PlayerClass=="DRUID" or PA.PlayerClass=="PRIEST") then
		table.insert(HealActions, "HOT");
		table.insert(HealActions, "GROUPHEAL");
		if (PA.PlayerClass=="PRIEST") then
			table.insert(HealActions, "LESSERHEAL");
			table.insert(HealActions, "GREATERHEAL");
		end
	end

	for Index, Spell in pairs(HealActions) do
		PA:ZoneStepsDropDown_AddEntry(Spell, PA:GetSpellProperty(Spell, "Name"), index, PA_ZoneActionsDropDown_OnClick);
	end
    -- There should alway be a nothing entry
	PA:ZoneStepsDropDown_AddEntry("SKIP", "-Nothing-", index, PA_ZoneActionsDropDown_OnClick);

	-- Show relevant entry
	local Step = PA.CurrentZoneSteps[index];	
	if (Step==nil) then
		Step = "SKIP";
	else
		Step = Step.Spell;
	end
	--PA:ShowText("Step=", Step);
	UIDropDownMenu_SetSelectedValue(Dd, Step);
end


-----------------------------------------
-- Populate the dropdown list with Conditions
-----------------------------------------
function PA:ZoneConditionDropDown_Initialize(index)
    if (PA:CheckMessageLevel('UI', 5)) then
	    PA:Message4('ZoneStepsDropDown_Initialize() index='..index);
	   end
	--PA:ShowText("Initialise dd index=", index);

	local Dd = getglobal("PA_ZoneAction"..index.."Conditions");

	for Condition, Info in pairs(PA.HealConditions) do
		PA:ZoneStepsDropDown_AddEntry(Condition, Info.Text, index, PA_ZoneConditionsDropDown_OnClick);
	end

	-- Show relevant entry
	local Step = PA.CurrentZoneSteps[index];	
	if (Step==nil) then
		Step = "Always";
	else
		Step = Step.Condition;
	end
	--PA:ShowText("Step=", Step);
	UIDropDownMenu_SetSelectedValue(Dd, Step);
end

function PA:PHMZoneUp_OnClick(index)
	--PA:ShowText("Up index=", index);
	local Step = PA.CurrentZoneSteps[index];
	PA.CurrentZoneSteps[index] = PA.CurrentZoneSteps[index-1];
	PA.CurrentZoneSteps[index-1] = Step;
	PA:ZoneInitializeStep(index);
	PA:ZoneInitializeStep(index-1);
end

function PA:PHMZoneDown_OnClick(index)
	--PA:ShowText("Down index=", index);
	local Step = PA.CurrentZoneSteps[index];
	PA.CurrentZoneSteps[index] = PA.CurrentZoneSteps[index+1];
	PA.CurrentZoneSteps[index+1] = Step;
	PA:ZoneInitializeStep(index);
	PA:ZoneInitializeStep(index+1);
end

function PA:ZoneStepsDropDown_AddEntry(spell, text, index, func, notCheckable)
	--PA:ShowText("text = ", text, " spell=", spell, " index=", index);
	local info = {};
	if (text==nil) then
		text = "["..spell.."]";
		info.textR = 0.8;	--  Red color value of the button text
		info.textG = 0.1;	--  Green color value of the button text
		info.textB = 0.1;	--  Blue color value of the button text
	end
	if (PA:CheckMessageLevel("UI", 5)) then
		PA:Message4("text = "..text.." spell="..spell.." index="..index);
	end
	info.text = text;
	info.value = spell;
	info.func = func;
	info.arg1 = index;
	info.notCheckable = notCheckable;
	UIDropDownMenu_AddButton(info);
end

function PA_ZoneActionsDropDown_OnClick()
	--PA:ShowText("Value=", this.value, " index=", this.arg1, " zone=", PA.CurrentZone);
	local Step = PA.CurrentZoneSteps[this.arg1];	
	if (Step==nil) then
		PA.CurrentZoneSteps[this.arg1] = {Spell="SKIP", Condition="Always"};
		Step = PA.CurrentZoneSteps[this.arg1];
	end
	Step.Spell = this.value;
	PA:ZoneStepsDropDown_InitAllDropDowns();
end

function PA_ZoneConditionsDropDown_OnClick()
	--PA:ShowText("Value=", this.value, " index=", this.arg1, " zone=", PA.CurrentZone);
	local Step = PA.CurrentZoneSteps[this.arg1];	
	if (Step==nil) then
		PA.CurrentZoneSteps[this.arg1] = {Spell="SKIP", Condition="Always"};
		Step = PA.CurrentZoneSteps[this.arg1];
	end
	Step.Condition = this.value;
	PA:ZoneStepsDropDown_InitAllDropDowns();
end



function PA:PHM_UpdatePetTH()
	local txt;

	txt = PASettings.Heal.PetTH * 100 .. "%";
	txtPHMPetTH:SetText(txt);
	txtPHMPetTH:Show();

	if(PanzaSTAFrame:IsVisible()) then
		txtPanzaSTAL6:SetText(format(PANZA_PET_THRESHOLD,(PASettings.Heal.PetTH * 100).."%"));
	end
end

function PA:PHM_UpdateFlash()
	local txt;

	txt = PASettings.Heal.Flash * 100 .. "%";
	txtPHMFlash:SetText(txt);
	txtPHMFlash:Show();

	if(PanzaSTAFrame:IsVisible()) then
		txtPanzaSTAL8:SetText(format(PANZA_FOL_HEALTH_THRESHOLD,(PASettings.Heal.Flash * 100).."%"));
	end

end

function PA:PHM_UpdateMid()
	local txt;

	txt = PASettings.Heal.MidHealth * 100 .. "%";
	txtPHMMid:SetText(txt);
	txtPHMMid:Show();

end

function PA:PHM_UpdateLowFlash()
	local txt;

	txt = PASettings.Heal.LowFlash * 100 .. "%";
	txtPHMLowFlash:SetText(txt);
	txtPHMLowFlash:Show();

	--[[
	if(PanzaSTAFrame:IsVisible()) then
		txtPanzaSTAL8:SetText(format(PANZA_FOL_HEALTH_THRESHOLD,(PASettings.Heal.LowFlash * 100).."%"));
	end
	--]]

end

--------------------------------
-- 2.0 Minimum health Threshold
--------------------------------
function PA:PHM_UpdateMinTH()
	local txt;
	local OverHeal,MinTH = 0,0;
	
	MinTH = getglobal("SliderPanzaMinTH"):GetValue();
	OverHeal = getglobal("SliderPanzaOverHeal"):GetValue();
	
	txt = PASettings.Heal.MinTH * 100 .. "%";
	txtPHMMinTH:SetText(txt);
	txtPHMMinTH:Show();

	if(PanzaSTAFrame:IsVisible()) then
		txtPanzaSTAL7:SetText(format(PANZA_MINHEALTH_THRESHOLD,(PASettings.Heal.MinTH * 100).."%"));
	end
	
	if (OverHeal < MinTH and OverHeal>0) then
		--PA:ShowText("PHM Adjusting OverHeal Slider");
		getglobal("SliderPanzaOverHeal"):SetMinMaxValues(getglobal("SliderPanzaOverHeal"):GetValue()+1,180);
		getglobal("SliderPanzaOverHeal"):SetValue(getglobal("SliderPanzaOverHeal"):GetValue()+1);
	elseif (OverHeal >0) then
		getglobal("SliderPanzaOverHeal"):SetMinMaxValues(getglobal("SliderPanzaMinTH"):GetValue()+1,180);
	end		
end

---------------------
-- OverHeal Indicator
---------------------
function PA:PHM_UpdateOverHeal()
	local txt;
	local MinTH;
	local OverHeal;
	
	txt = PASettings.Heal.OverHeal * 100 .. "%";
	txtPHMOverHeal:SetText(txt);
	txtPHMOverHeal:Show();
	
	MinTH = getglobal("SliderPanzaMinTH"):GetValue();
	OverHeal = getglobal("SliderPanzaOverHeal"):GetValue();
	
	--PA:ShowText("MinTH=",MinTH," OverHeal=",OverHeal);
	getglobal("SliderPanzaOverHeal"):SetMinMaxValues(getglobal("SliderPanzaMinTH"):GetValue()+1,180);
	
end


function PA:PHM_OnShow()
	PA:Reposition(PanzaPHMFrame, "UIParent", true);
	PanzaPHMFrame:SetAlpha(PASettings.Alpha);
	PA:PHM_SetValues();

	if (PA_ZoneStepsFrame:IsVisible()) then
		PA_ZoneStepsFrame:Hide();
	end
end

function PA:PHM_OnHide()
	if (PA_ZoneStepsFrame:IsVisible()) then
		PA_ZoneStepsFrame:Hide();
	end

end

function PA:PHM_btnDone_OnClick()
	PA:FrameToggle(PanzaPHMFrame);
end

--------------------------------------
-- Generic Tooltip Function
--------------------------------------
function PA:PHM_ShowTooltip(item)
	GameTooltip:SetOwner(getglobal(item:GetName()), "ANCHOR_TOP");
	GameTooltip:ClearLines();
	GameTooltip:ClearAllPoints();
	GameTooltip:SetPoint("TOPLEFT", item:GetName(), "BOTTOMLEFT", 0, -2);
	local TipIndex = 1;
	local TipLine = PA.PHM_Tooltips[item:GetName()]["tooltip"..TipIndex];
	while (TipLine~=nil) do
		if (TipIndex==1) then
			GameTooltip:AddLine(TipLine);
		else
			GameTooltip:AddLine(TipLine, 1, 1, 1, 1, 1);
		end
		TipIndex = TipIndex + 1;
		TipLine = PA.PHM_Tooltips[item:GetName()]["tooltip"..TipIndex];
	end
	GameTooltip:Show();
end

function PA:PHM_AddSpell(step)
	if (step.Spell~=nil and PA:HealAllowed(step.Spell)) then
		local SpellName = PA:GetSpellProperty(step.Spell, "Name");
		if (SpellName~=nil) then
			if (step.Condition~=nil) then
				local ModifierText = "";
				if (step.Modifier~=nil) then
					local Modifier = PA.HealConditions[step.Condition].Modifier;
					if (Modifier=="TEXT") then
						ModifierText = step.Modifier;
					elseif (Modifier~="NONE") then
						ModifierText = step.Modifier.." "..Modifier;
					end
				end
				local ConditionText = PA.HealConditions[step.Condition].Text;
				GameTooltip:AddLine(SpellName.." "..ConditionText.." "..ModifierText , 0.3, 0.3, 0.9, 1, 1 );
			end
		end
	end
end

--------------------------------------
-- Indicator Bar Tooltip Function
--------------------------------------
function PA:PHM_ShowBarTooltip(item, zone)
	GameTooltip:SetOwner(getglobal(item:GetName()), "ANCHOR_TOP", 0, 60);
	GameTooltip:ClearLines();
	GameTooltip:ClearAllPoints();
	GameTooltip:SetPoint("TOPLEFT", item:GetName(), "BOTTOMLEFT");
	GameTooltip:AddLine(PA.PHM_Tooltips[item:GetName()].tooltip1);
	GameTooltip:AddLine(PA.PHM_Tooltips[item:GetName()].tooltip2, 1, 1, 1, 1, 1);
	if (zone~=nil and PASettings.Heal.ZoneSteps[zone]~=nil) then
		for Index, Step in pairs(PASettings.Heal.ZoneSteps[zone]) do
			if (PA:SpellInSpellBook(Step.Spell)) then
				PA:PHM_AddSpell(Step);
			end
		end
	end
	GameTooltip:AddLine(PA.PHM_Tooltips[item:GetName()].tooltip3, 1, 1, 1, 1, 1);
	GameTooltip:Show();
end

----------------------------
-- Modifier Tooltip Function
----------------------------
function PA:PHM_ShowModifierTooltip(item, index)
	local Step = PA.CurrentZoneSteps[index];	
	if (Step~=nil) then
		if (Step.Condition~=nil) then
			local Text = PA.HealConditions[Step.Condition].ModifierTooltip;
			if (Text~=nil) then
				GameTooltip:SetOwner(item, "ANCHOR_TOPLEFT");
				GameTooltip:ClearLines();
				GameTooltip:ClearAllPoints();
				GameTooltip:AddLine(Text);
				GameTooltip:Show();
			end
		end
	end
end



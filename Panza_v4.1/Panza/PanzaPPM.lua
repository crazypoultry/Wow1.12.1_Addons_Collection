--[[

PanzaPPM.lua
Panza Panic Healing Module (PPM) Dialog
Revision 4.0

10-01-06 "for in pairs()" completed for BC
--]]

-- Lookup Table
function PA:SetupPanic()
	PA.PanicLookup = {};
	PA.PanicLookup[1] = "PRIEST";
	PA.PanicLookup[2] = "DRUID";
	PA.PanicLookup[3] = "MAGE";
	PA.PanicLookup[4] = "WARLOCK";
	PA.PanicLookup[5] = PA.HybridClass;
	PA.PanicLookup[6] = "WARRIOR";
	PA.PanicLookup[7] = "HUNTER";
	PA.PanicLookup[8] = "ROGUE";
end

function PA:PPM_OnLoad()
	PA.GUIFrames[this:GetName()] = this;
	UIPanelWindows[this:GetName()] = {area = "center", pushable = 0};
end

function PA:PPM_SetValues()

	SliderPAPPM1:SetValue(PASettings.PanicMinHealth[PA.PanicLookup[1]]);
	SliderPAPPM2:SetValue(PASettings.PanicMinHealth[PA.PanicLookup[2]]);
	SliderPAPPM3:SetValue(PASettings.PanicMinHealth[PA.PanicLookup[3]]);
	SliderPAPPM4:SetValue(PASettings.PanicMinHealth[PA.PanicLookup[4]]);
	SliderPAPPM5:SetValue(PASettings.PanicMinHealth[PA.PanicLookup[5]]);
	SliderPAPPM6:SetValue(PASettings.PanicMinHealth[PA.PanicLookup[6]]);
	SliderPAPPM7:SetValue(PASettings.PanicMinHealth[PA.PanicLookup[7]]);
	SliderPAPPM8:SetValue(PASettings.PanicMinHealth[PA.PanicLookup[8]]);

	SliderPAPPM1Text:SetText(PA:Capitalize(PA.ClassName[PA.PanicLookup[1]]));
	SliderPAPPM2Text:SetText(PA:Capitalize(PA.ClassName[PA.PanicLookup[2]]));
	SliderPAPPM3Text:SetText(PA:Capitalize(PA.ClassName[PA.PanicLookup[3]]));
	SliderPAPPM4Text:SetText(PA:Capitalize(PA.ClassName[PA.PanicLookup[4]]));
	SliderPAPPM5Text:SetText(PA:Capitalize(PA.ClassName[PA.PanicLookup[5]]));
	SliderPAPPM6Text:SetText(PA:Capitalize(PA.ClassName[PA.PanicLookup[6]]));
	SliderPAPPM7Text:SetText(PA:Capitalize(PA.ClassName[PA.PanicLookup[7]]));
	SliderPAPPM8Text:SetText(PA:Capitalize(PA.ClassName[PA.PanicLookup[8]]));

	if (PA:SpellInSpellBook(PA.ShieldSpell)) then
		cbxPanzaPPMStage1:SetChecked(PASettings.Switches.PanicStages[1]);
		cbxPanzaPPMStage1:Enable();
	else
		cbxPanzaPPMStage1:SetChecked(false);
		cbxPanzaPPMStage1:Disable();
	end
	if (PA:SpellInSpellBook("hs")) then
		cbxPanzaPPMStage2:SetChecked(PASettings.Switches.PanicStages[2]);
		cbxPanzaPPMStage2:Enable();
	else
		cbxPanzaPPMStage2:SetChecked(false);
		cbxPanzaPPMStage2:Disable();
	end
	if (PA:SpellInSpellBook("loh")) then
		cbxPanzaPPMStage3:SetChecked(PASettings.Switches.PanicStages[3]);
		cbxPanzaPPMStage3:Enable();
	else
		cbxPanzaPPMStage3:SetChecked(false);
		cbxPanzaPPMStage3:Disable();
	end
	if (PA:TableEmpty(PA.SpellBook.DeDebuffs)) then
		cbxPanzaPPMStage4:SetChecked(false);
		cbxPanzaPPMStage4:Disable();
	else
		cbxPanzaPPMStage4:SetChecked(PASettings.Switches.PanicStages[4]);
		cbxPanzaPPMStage4:Enable();
	end
	if (PA:SpellInSpellBook("HEALSPECIAL")) then
		cbxPanzaPPMStage5:SetChecked(PASettings.Switches.PanicStages[5]);
		cbxPanzaPPMStage5:Enable();
	else
		cbxPanzaPPMStage5:SetChecked(false);
		cbxPanzaPPMStage5:Disable();
	end
	cbxPanzaPPMStage6:SetChecked(PASettings.Switches.PanicStages[6]);
	
	cbxPanzaPPMOnHeal:SetChecked(PASettings.Switches.PanicOnHeal==true);
end

function PA:PPM_Defaults()

	if (PA:CheckMessageLevel("Core", 4)) then
		PA:Message4("Resetting panic to default");
	end

	if (not PA.HybridClass) then
		PA:SetupClasses();
	end

	PASettings.PanicClass = {};
	PASettings.PanicClass["PRIEST"] 		= 1;
	PASettings.PanicClass["DRUID"] 			= 2;
	PASettings.PanicClass["MAGE"] 			= 3;
	PASettings.PanicClass["WARLOCK"]		= 4;
	PASettings.PanicClass[PA.HybridClass]	= 5;
	PASettings.PanicClass["WARRIOR"]		= 6;
	PASettings.PanicClass["HUNTER"] 		= 7;
	PASettings.PanicClass["ROGUE"] 			= 8;

	PASettings.PanicMinHealth = {};
	PASettings.PanicMinHealth["PRIEST"] 	= 25; -- these are percentage of max health
	PASettings.PanicMinHealth["DRUID"]		= 20;
	PASettings.PanicMinHealth["MAGE"] 		= 25;
	PASettings.PanicMinHealth["WARLOCK"]	= 25;
	PASettings.PanicMinHealth["PALADIN"]	= 15;
	PASettings.PanicMinHealth["SHAMAN"]		= 20;
	PASettings.PanicMinHealth["WARRIOR"]	= 10;
	PASettings.PanicMinHealth["HUNTER"] 	= 20;
	PASettings.PanicMinHealth["ROGUE"]		= 20;

	PA:SetupPanic();
	PA.PanicLookup = {};
	for key, value in pairs(PASettings.PanicClass) do
		--PA:Message(PA_GREN..key..""..PA_WHITE.." - "..PA_BLUE..""..value);
		PA.PanicLookup[value] = key;
	end

	PASettings.Switches["PanicStages"]	= {true, true, true, true, true, true}; -- Panic Stage enable/disable.
	PASettings.Switches.PanicOnHeal		= true; -- Check for panic every AutoHeal.

end


function PA:PPM_OnShow()
	PA:Reposition(PanzaPPMFrame, "UIParent", true);
	PanzaPPMFrame:SetAlpha(PASettings.Alpha);
	PA:PPM_SetValues();
end

function PA:PPM_OnHide()
	-- place holder
end

function PA:PPM_btnDone_OnClick()
	PA:FrameToggle(PanzaPPMFrame);
end

function PA:PPM_btnDown_OnClick(index)
	local Swap = PASettings.PanicClass[PA.PanicLookup[index]];
	PASettings.PanicClass[PA.PanicLookup[index]] = PASettings.PanicClass[PA.PanicLookup[index+1]];
	PASettings.PanicClass[PA.PanicLookup[index+1]] = Swap;
	Swap = PA.PanicLookup[index];
	PA.PanicLookup[index] = PA.PanicLookup[index+1];
	PA.PanicLookup[index+1] = Swap;
end

function PA:PPM_btnUp_OnClick(index)
	local Swap = PASettings.PanicClass[PA.PanicLookup[index]];
	PASettings.PanicClass[PA.PanicLookup[index]] = PASettings.PanicClass[PA.PanicLookup[index-1]];
	PASettings.PanicClass[PA.PanicLookup[index-1]] = Swap;
	Swap = PA.PanicLookup[index];
	PA.PanicLookup[index] = PA.PanicLookup[index-1];
	PA.PanicLookup[index-1] = Swap;
end

function PA:PPM_chkStage_OnClick(index)
	PASettings.Switches.PanicStages[index] = not PASettings.Switches.PanicStages[index];
end


--------------------------------------
-- Generic Tooltip Function
--------------------------------------
function PA:PPM_ShowTooltip(item, index)
	GameTooltip:SetOwner( getglobal(item:GetName()), "ANCHOR_TOP" );
	GameTooltip:ClearLines();
	GameTooltip:ClearAllPoints();
	GameTooltip:SetPoint("TOPLEFT", item:GetName(), "BOTTOMLEFT", 0, -2);
	if (index>0) then
		GameTooltip:AddLine(PA.PPM_Tooltips.SliderPAPPM.tooltip1.." - "..PA_YEL..PA:Capitalize(PA.ClassName[PA.PanicLookup[index]]));
		GameTooltip:AddLine(PA.PPM_Tooltips.SliderPAPPM.tooltip2, 1, 1, 1, 1, 1 );
	else
		GameTooltip:AddLine(PA.PPM_Tooltips[item:GetName()].tooltip1 );
		GameTooltip:AddLine(PA.PPM_Tooltips[item:GetName()].tooltip2, 1, 1, 1, 1, 1 );
	end
	GameTooltip:Show();
end

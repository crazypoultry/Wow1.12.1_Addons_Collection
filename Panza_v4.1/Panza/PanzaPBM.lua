--[[

PanzaPBM.lua
Panza
Panza Blessing Module (PBM)
Revision 4.0

]]

function PA:PBM_OnLoad()
	PA.OptionsMenuTree[5] = {Title="Buffing", Frame=this, Tooltip="Buffing Options", Check=true, Sub={}, Filter={Spell="Bless"}};
	PA.OptionsMenuTree[5].Sub[1] = {Title="Class Buffs", Frame=PanzaDCBFrame, Tooltip="Default Class Buff set-up"};
	PA.OptionsMenuTree[5].Sub[2] = {Title="Individual Buffs", Frame=PanzaPBMIndiFrame, Tooltip="Individual Buff List"};
	PA.OptionsMenuTree[5].Sub[3] = {Title="Group Buffs", Frame=PanzaPBMGroupFrame, Tooltip="Group Buffs"};

	PA.GUIFrames[this:GetName()] = this;
	UIPanelWindows[this:GetName()] = {area = "center", pushable = 0};
end

function PA:PBM_SetValues()
	cbxPanzaEnableOut:SetChecked(PASettings.Switches.EnableOutside == true);
	cbxPanzaEnableCycle:SetChecked(PASettings.Switches.EnableCycle == true);
	cbxPanzaBowOnLowMana:SetChecked(PASettings.Switches.BlessBowOnLowMana.enabled == true);
	cbxPanzaPVPUseBG:SetChecked(PASettings.Switches.PVPUseBG.enabled == true);
	cbxPanzaEnableNPC:SetChecked(PASettings.Switches.EnableNPC == true);
	cbxPanzaShowProgress:SetChecked(PASettings.Switches.ShowBlessingProgress.enabled);
	cbxPanzaEnableWarn:SetChecked(PASettings.Switches.EnableWarn == true);
	cbxPanzaPets:SetChecked(PASettings.Switches.Pets.Bless == true);
	cbxPanzaIgnoreParty:SetChecked(PASettings.Switches.IgnorePartyInRaid.enabled == true);
	cbxPanzaBoSaf:SetChecked(PASettings.Switches.BoSafOnPVP==true);

	cbxPanzaBEWSParty:SetChecked(PASettings.Switches.BEWS.party==true);
	cbxPanzaBEWSRaid:SetChecked(PASettings.Switches.BEWS.raid==true);
	cbxPanzaBEWSAll:SetChecked(PASettings.Switches.BEWS.all==true);
	cbxPanzaBEWSGreater:SetChecked(PASettings.Switches.GreaterBlessings.Warn==true);
	cbxPanzaBEWSSounds:SetChecked(PASettings.Switches.BEWS.sounds==true);

	SliderPanzaPBMNPC:SetValue(tonumber(PASettings.Switches.NPCount));
	SliderPanzaPBMRebless:SetValue(tonumber(PASettings.Switches.Rebless));
	SliderPanzaPBMNearRestart:SetValue(tonumber(PASettings.Switches.NearRestart));
	SliderPanzaPBMNotBlessed:SetValue(tonumber(PASettings.NotBlessedCount));
	
	if (not PA:SpellInSpellBook("bow")) then
		cbxPanzaBowOnLowMana:Disable();
	end
	
	if (not PA:SpellInSpellBook("bosaf")) then
		cbxPanzaBoSaf:Disable();
	end	

end

function PA:PBM_Defaults()
	PASettings["NotBlessedCount"] 				= 5;
	PASettings.Switches["EnableOutside"]		= false; -- Allows AutoSelect to look outside the party when in a Party. Use Carefully.
	PASettings.Switches["EnableCycle"]			= true;  -- Automatically enable CycleBless when in party or raid
	PASettings.Switches["BlessBowOnLowMana"]	= {enabled=false};    -- When true BoW will be cast on group members with low mana.
	PASettings.Switches["PVPUseBG"] 			= {enabled=false};    -- When true BG blessings will be used on units with PVP flag set.
	PASettings.Switches["NearRestart"]  		= 240;  -- Number of seconds that must elapse before the Near List Times Out.
	PASettings.Switches["EnableNPC"]			= false;  -- Bless NPCS in CycleNear (default is false)
	PASettings.Switches["NPCount"]				= 20;    -- Max NPCs that will be skipped in CycleNear if NPCs are skipped.
	PASettings.Switches["Rebless"] 				= 60;    -- Time in seconds below which blessings will get refreshed.
	PASettings.Switches["IgnorePartyInRaid"]	= {enabled=true};    -- When true only Raid setting will be used.
	PASettings.Switches["Pets"]					= {Bless=true, Cure=true, Heal=true, Free=true};
	PASettings.Switches["EnableWarn"]			= true;  -- BEWS
	PASettings.Switches["BEWS"]					= {raid=false, party=false, all=false, sounds=true};
	PASettings.Switches.GreaterBlessings.Warn	= true;
	PASettings.Switches.BoSafOnPVP				= true;
end

function PA:PBM_OnShow()
	PA:Reposition(PanzaPBMFrame, "UIParent", true);
	PanzaPBMFrame:SetAlpha(PASettings.Alpha);
	PA:PBM_SetValues();
end

function PA:PBM_OnHide()
	-- place holder
end


function PA:PBM_UpdateNPCS()
	local txt = PASettings.Switches.NPCount;
	txtPanzaPBMNPCount:SetText(txt);
	txtPanzaPBMNPCount:Show();
end

function PA:PBM_UpdateRebless()
	local txt = PASettings.Switches.Rebless;
	txtPanzaPBMRebless:SetText(txt);
	txtPanzaPBMRebless:Show();
end

function PA:PBM_UpdateNotBlessed()
	local txt = PASettings.NotBlessedCount;
	txtPanzaPBMNotBlessed:SetText(txt);
	txtPanzaPBMNotBlessed:Show();
end

function PA:PBM_UpdateNearRestart()
	local txt = PASettings.Switches.NearRestart;
	txtPanzaPBMNearRestart:SetText(txt);
	txtPanzaPBMNearRestart:Show();
end

function PA:PBM_btnDone_OnClick()
	PA:FrameToggle(PanzaPBMFrame);
end

--------------------------------------
-- Generic Tooltip Function
--------------------------------------

function PA:PBM_ShowTooltip(item)
	GameTooltip:SetOwner(getglobal(item:GetName()), "ANCHOR_TOP");
	GameTooltip:ClearLines();
	GameTooltip:ClearAllPoints();
	GameTooltip:SetPoint("TOPLEFT", item:GetName(), "BOTTOMLEFT", 0, -2);
	local TipIndex = 1;
	local TipLine = PA.PBM_Tooltips[item:GetName()]["tooltip"..TipIndex];
	while (TipLine~=nil) do
		if (TipIndex==1) then
			GameTooltip:AddLine(TipLine);
		else
			GameTooltip:AddLine(TipLine, 1, 1, 1, 1, 1);
		end
		TipIndex = TipIndex + 1;
		TipLine = PA.PBM_Tooltips[item:GetName()]["tooltip"..TipIndex];
	end
	GameTooltip:Show();
end

--[[

PanzaPHM.lua
Panza Healing Module (PHM) Advanced options Dialog
Revision 4.0

--]]

local CurrentTrinket = {};
local PanzaTrinket_SavedBagFunc = nil;
local PanzaTrinket_SavedInvFunc = nil;

function PA:PHMAdvanced_OnLoad()
	PA.GUIFrames[this:GetName()] = this;
	UIPanelWindows[this:GetName()] = {area = "center", pushable = 0};
end

function PA:PHMAdvanced_SetValues()
	SliderPanzaFolTH:SetValue(PASettings.Heal.FolTH * 100);
	SliderPanzaManaBuff:SetValue(PASettings.Heal.ManaBuffer);
	SliderPanzaSense:SetValue(PASettings.Heal.Sense);
	SliderPanzaPHMGroupLimit:SetValue(PASettings.Heal.GroupLimit);
	cbxPanzaHealAbort:SetChecked(PASettings.Heal.Abort.enabled == true);
	cbxPanzaIgnoreRange:SetChecked(PASettings.Heal.IgnoreRange==true);
	cbxPanzaUseDFAll:SetChecked(PASettings.Heal.UseDFAll==true);
	cbxPanzaUseDF:SetChecked(PASettings.Heal.UseDF==true);
	cbxPanzaUseDFOOC:SetChecked(PASettings.Heal.UseDFOOC==true);
	cbxPanzaOnDF:SetChecked(PASettings.Heal.Trinket.OnDF==true);
	cbxPanzaOnFlash:SetChecked(PASettings.Heal.Trinket.OnFlash==true);
	cbxPanzaOnHeal:SetChecked(PASettings.Heal.Trinket.OnHeal==true);
	cbxPanzaOwnBars:SetChecked(PASettings.Heal.Bars.OwnBars==true);
	cbxPanzaOtherBars:SetChecked(PASettings.Heal.Bars.OtherBars==true);
	cbxPanzaCoop:SetChecked(PASettings.Heal.Coop.enabled==true);

	PA:PHMAdvanced_UpdateFolTH();
	PA:PHMAdvanced_UpdateManaBuff();
	PA:PHMAdvanced_UpdateOverHeal();
	PA:PHMAdvanced_UpdateBarLock();
	PA:PHMAdvanced_UpdateGroupLimit();

	if (PA:SpellInSpellBook("HEALSPECIAL")) then
		local totalhranks = getn(PA.SpellBook["HEAL"]);
		getglobal(SliderPanzaPHMCritRank:GetName().."High"):SetText(PANZA_RANK.." "..totalhranks);
		getglobal(SliderPanzaPHMCritRank:GetName().."Low"):SetText(PANZA_ALLRANKS);
		SliderPanzaPHMCritRank:SetMinMaxValues(0,totalhranks);
		SliderPanzaPHMCritRank:SetValue(PASettings.Heal.MinCritRank);
		cbxPanzaUseDFAll:Enable();
		cbxPanzaUseDF:Enable();
		cbxPanzaUseDFOOC:Enable();
		if (PASettings.Heal.UseDF==true) then
			cbxPanzaOnDF:Enable();
		else
			cbxPanzaOnDF:Enable();
		end
	else
		getglobal(SliderPanzaPHMCritRank:GetName().."High"):SetText("N/A");
		getglobal(SliderPanzaPHMCritRank:GetName().."Low"):SetText("N/A");
		SliderPanzaPHMCritRank:SetMinMaxValues(0,0);
		SliderPanzaPHMCritRank:SetValue(0);
		cbxPanzaUseDFAll:Disable();
		cbxPanzaUseDF:Disable();
		cbxPanzaUseDFOOC:Disable();
		cbxPanzaOnDF:Disable();
	end
	
	if (PA:SpellInSpellBook("GROUPHEAL")) then
		SliderPanzaPHMGroupLimit:EnableMouse(true);
	else
		SliderPanzaPHMGroupLimit:EnableMouse(false);
		SliderPanzaPHMGroupLimit:SetValue(0);
		SliderPanzaPHMGroupLimitText:SetTextColor(0.3,0.3,0.3);
		txtPHMGroupLimit:SetTextColor(0.3,0.3,0.3);
	end

end

function PA:PHMAdvanced_Defaults()
	PASettings.Heal["FolTH"]		= 0.10;
	PASettings.Heal["ManaBuffer"]	= 1;
	PASettings.Heal["GroupLimit"]	= 3;
	PASettings.Heal["Sense"]		= 0;
	PASettings.Heal["Abort"]		= {enabled=true};
	PASettings.Heal["IB"]			= {enabled=true, BonusScan=true};
	PASettings.Heal["IgnoreRange"]	= false;
	PASettings.Heal["Coop"] 		= {enabled=true, timer=2};
	PASettings.Heal["Bars"]			= {enabled=true};
	PASettings.Heal["MinCritRank"]	= 0;
	PASettings.Heal["Trinket"]		= {OnDF=false, OnFlash=false, OnHeal=true};
	PASettings.Heal.UseDFAll 		= true;
	PASettings.Heal.UseDF			= true;
	PASettings.Heal.UseDFOOC		= false;
end


-------------------------------------------------------------------------------------
-- Update the status of the healing bars position.
-- This function is also called whenever OwnBars or OtherBars checkboxes are changed.
-- If neither of the bar options are selected, this function will disable the
-- SetPos button
-------------------------------------------------------------------------------------
function PA:PHMAdvanced_UpdateBarLock()
	local locked = nil;

	local BarLocktxt = {
		["true"] 		= "Locked",
		["false"] 		= "Unlocked",
		["disabled"] 	= "Disabled",
		};

	if (PASettings.Heal.Bars.OtherBars == true or PASettings.Heal.Bars.OwnBars==true) then

		if (PASettings.Heal.Bars.OtherBars==true) then
			locked = PanzaFrame_HealBars1.isLocked;
		elseif (PASettings.Heal.Bars.OwnBars==true) then
			locked = PanzaFrame_HealCurrentSpell.isLocked;
		end

		if (locked == 0 or locked == false) then
			locked = "false";
		elseif (locked == 1 or locked == true) then
			locked = "true";
		else
			locked = "false";
		end

	else
		locked = "disabled";
	end

	-- Display the status text
	txtPHMBarLock:SetText(BarLocktxt[locked]);
	txtPHMBarLock:Show();

	-- Enable or disable depending on status
	if (locked=="disabled") then
		btnPanzaPHMSetPos:Disable();
	else
		btnPanzaPHMSetPos:Enable();
	end
end

function PA:PHMAdvanced_UpdateGroupLimit()
	local txt;
	if (PASettings.Heal.GroupLimit==0) then
		txt = "Off";
	else
		txt = PASettings.Heal.GroupLimit;
	end
	txtPHMGroupLimit:SetText(txt);
	txtPHMGroupLimit:Show();
end

function PA:PHMAdvanced_UpdatePetTH()
	local txt;

	txt = PASettings.Heal.PetTH * 100 .. "%";
	txtPHMPetTH:SetText(txt);
	txtPHMPetTH:Show();

	if(PanzaSTAFrame:IsVisible()) then
		txtPanzaSTAL6:SetText(format(PANZA_PET_THRESHOLD,(PASettings.Heal.PetTH * 100).."%"));
	end
end

function PA:PHMAdvanced_UpdateMid()
	local txt;

	txt = PASettings.Heal.MidHealth * 100 .. "%";
	txtPHMMid:SetText(txt);
	txtPHMMid:Show();

end

function PA:PHMAdvanced_UpdateLowFlash()
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

function PA:PHMAdvanced_UpdateFolTH()
	local txt;
	local maxmana = UnitManaMax("player");

	txt = PASettings.Heal.FolTH * 100 .. "% (" .. format("%.0f", maxmana * PASettings.Heal.FolTH) .. ")";
	txtPHMFolTH:SetText(txt);
	txtPHMFolTH:Show();

	if(PanzaSTAFrame:IsVisible()) then
		txtPanzaSTAL9:SetText(format(PANZA_FOL_MANA_THRESHOLD,(PASettings.Heal.FolTH * 100).."%"));
	end

end

--------------------------------
-- 2.0 Minimum health Threshold
--------------------------------
function PA:PHMAdvanced_UpdateMinTH()
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
function PA:PHMAdvanced_UpdateOverHeal()
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

--------------
-- Mana Buffer
--------------
function PA:PHMAdvanced_UpdateManaBuff()
	local txt;
	if (PASettings.Heal.ManaBuffer == 0) then
		txt = "Disabled";
	elseif (PASettings.Heal.ManaBuffer > 1) then
		txt = PASettings.Heal.ManaBuffer.." Spells";
	else
		txt = PASettings.Heal.ManaBuffer.." Spell";
	end
	txtPHMManaBuff:SetText(txt);
	txtPHMManaBuff:Show();
end

----------------
-- Healing Sense
----------------
function PA:PHMAdvanced_UpdateSense()
	local txt;
	if (PASettings.Heal.Sense == 0) then
		txt = "0 (No Adjustment)";
	elseif (PASettings.Heal.Sense == 1) then
		txt = "+"..PASettings.Heal.Sense.." Rank";
	elseif (PASettings.Heal.Sense > 1) then
			txt = "+"..PASettings.Heal.Sense.." Ranks";
	elseif (PASettings.Heal.Sense == -1) then
		txt = PASettings.Heal.Sense.." Rank";
	elseif (PASettings.Heal.Sense < -1) then
		txt = PASettings.Heal.Sense.." Ranks";
	end
	txtPHMSense:SetText(txt);
	txtPHMSense:Show();
end

--------------------
-- Minimum Crit Rank
--------------------
function PA:PHMAdvanced_UpdateMinCritRank()
	local txt;
	if (PASettings.Heal.MinCritRank == 0) then
		txt = PANZA_ALLRANKS;
	else
		txt = PANZA_RANK.." "..PASettings.Heal.MinCritRank;
	end
	txtPHMMinCritRank:SetText(txt);
	txtPHMMinCritRank:Show();
end

--------------------------------
-- 2.0 Abort Heal Toggle
--------------------------------
function PA:PHMAdvanced_AbortHeal()
	if (PASettings.Heal.Abort.enabled) then
		PASettings.Heal.Abort = {enabled=false};
		if (PA:CheckMessageLevel("Heal",1)) then
			PA:Message4(PANZA_HEAL_ABORT_DISABLE);
		end
	else
		PASettings.Heal.Abort = {enabled=true};
		if (PA:CheckMessageLevel("Heal",1)) then
			PA:Message4(PANZA_HEAL_ABORT_ENABLE);
		end
	end
end


function PanzaTrinket_HookFunction(func, newfunc)
	local oldValue = getglobal(func);
	if ( oldValue ~= getglobal(newfunc) ) then
		setglobal(func, getglobal(newfunc));
		return true;
	end
	return false;
end

function PA:PHMAdvanced_OnShow()
	PA:Reposition(PanzaPHMAdvancedFrame, "UIParent", true);
	PanzaPHMAdvancedFrame:SetAlpha(PASettings.Alpha);
	PA:PHMAdvanced_SetValues();
	local temp = PickupContainerItem;
	if ( PanzaTrinket_HookFunction("PickupContainerItem", "PanzaTrinket_PickupContainerItem") ) then
		PanzaTrinket_SavedBagFunc = temp;
	end

	local temp = PickupInventoryItem;
	if ( PanzaTrinket_HookFunction("PickupInventoryItem", "PanzaTrinket_PickupInventoryItem") ) then
		PanzaTrinket_SavedInvFunc = temp;
	end
	if (PA_ZoneStepsFrame:IsVisible()) then
		PA_ZoneStepsFrame:Hide();
	end
end


function PA:PHMAdvanced_btnDone_OnClick()
	PA:FrameToggle(PanzaPHMAdvancedFrame);
end

--------------------------------------
-- Generic Tooltip Function
--------------------------------------
function PA:PHMAdvanced_ShowTooltip(item)
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

--------------------
-- Trinket Functions
--------------------
function PanzaTrinket_PickupContainerItem(bag, slot)
	--PA:ShowText("PanzaTrinket_PickupContainerItem Slot=", slot, " Bag=", bag);
	if ( PanzaTrinket_SavedBagFunc ) then
		PanzaTrinket_SavedBagFunc(bag, slot);
	end
	local texture, itemCount, locked = GetContainerItemInfo(bag, slot);
	if ( texture ) then
      	name = PanzaTrinket_GetItemName(bag, slot)
	end
	local empty = true;
	if (CursorHasItem()) then
		PanzaTrinket_PickupItem(bag, slot, name, texture)
		empty = false
	end
	if empty then
		CurrentTrinket = {};
	end
end

function PanzaTrinket_PickupInventoryItem(slot)
	--PA:ShowText("PanzaTrinket_PickupInventoryItem Slot=", slot);
	local autoflag = false;
	local name = nil;
	if ( PanzaTrinket_SavedInvFunc ) then
      	PanzaTrinket_SavedInvFunc(slot);
	end
	local texture = GetInventoryItemTexture("player", slot);
	if ( texture ) then
		name = PanzaTrinket_GetItemName(nil, slot)
	end
	local empty = true;
	if (CursorHasItem() and name~=nil) then
		PanzaTrinket_PickupItem(nil, slot, name, texture)
		empty = false
	end
	if empty then
		CurrentTrinket = {};
	end
end

function PanzaTrinket_DropItem()
	--PA:ShowText("PanzaTrinket_DropItem ", CurrentTrinket);
	if CursorHasItem() then
		if (CurrentTrinket.Bag~=nil) then
			PickupContainerItem(CurrentTrinket.Bag, CurrentTrinket.Slot);
      	elseif (CurrentTrinket.Slot~=nil) then
			PickupInventoryItem(CurrentTrinket.Slot);
		end
	end
	CurrentTrinket = {};
end

function PanzaTrinket_GetItemName(bag, slot)
	if (bag==nil or type(bag)~="number") then
		PanzaTooltip:SetInventoryItem("player", slot);
	else
		PanzaTooltip:SetBagItem(tonumber(bag), slot);
	end
	local name = PanzaTooltipTextLeft1:GetText();
	--PA:ShowText("PanzaTrinket_GetItemName bag=", bag, " slot=", slot, " name=", name);
	return name;
end

-- Tracks the last item picked up
function PanzaTrinket_PickupItem(bag, slot, name, texture)
	--PA:ShowText("PanzaTrinket_PickupItem bag=", bag, " slot=", slot, " name=", name, " texture=", texture);
	CurrentTrinket.Bag = bag;
	CurrentTrinket.Slot = slot;
	CurrentTrinket.Name = name;
	CurrentTrinket.Texture = texture;
end

-- Sets the trinket to the one in hand
function PanzaTrinket_SetButton()
	--PA:ShowText("PanzaTrinket_SetButton");
	-- Set the new button
	PASettings.Heal.Trinket.Name = CurrentTrinket.Name;
	PASettings.Heal.Trinket.Texture = CurrentTrinket.Texture;
	PanzaTrinket_DropItem();
	PanzaPHM_ButtonUpdate(this);
end

-- Button Update
function PanzaPHM_ButtonUpdate(button)
	--PA:ShowText("PanzaPHM_ButtonUpdate");
	-- Check the button
	if ( button == nil ) then return; end

	-- Uncheck it
	button:SetChecked("false");

	-- Enable the button
	button:Enable();
	PanzaPHM_SetSelfTexture(button);
end

-- Self Texture Button
function PanzaPHM_SetSelfTexture(button)
	local name = button:GetName();
	local icon = getglobal(name.."Icon");
	-- Set the texture
	local Texture = PASettings.Heal.Trinket.Texture;
	--PA:ShowText("PanzaPHM_SetSelfTexture ", name, " Texture=", Texture);
	if (Texture~=nil) then
		icon:SetTexture(Texture);
		icon:Show();
	else
		icon:Hide();
	end
end

function PanzaPHM_ButtonLoad()
	--PA:ShowText("PanzaPHM_ButtonLoad");
	this:RegisterForDrag("LeftButton", "RightButton");
	this:RegisterForClicks("LeftButtonUp", "RightButtonUp");
end

-- Dragging resets to empty
function PanzaPHM_ButtonDragStart()
	--PA:ShowText("PanzaPHM_ButtonDragStart");
	CurrentTrinket = {};
	PanzaTrinket_SetButton();
end

function PanzaPHM_ButtonDragEnd()
	--PA:ShowText("PanzaPHM_ButtonDragEnd");
	PanzaTrinket_SetButton();
end

function PanzaPHM_ButtonEnter()
	local tooltip = PANZA_TRINKETEMPTY;
	GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
	if (PASettings.Heal.Trinket~=nil and PASettings.Heal.Trinket.Name~=nil) then
		tooltip = PASettings.Heal.Trinket.Name;
	end

	GameTooltip:AddLine(tooltip);
	GameTooltip:AddLine(PANZA_TRINKETEXTRA);
	GameTooltipTextLeft2:SetTextColor(0.57, 0.80, 0.20);
	GameTooltip:Show();
end

function PanzaPHM_ButtonLeave()
	GameTooltip:Hide();
end


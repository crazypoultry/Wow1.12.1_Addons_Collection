local realUnitPopup_OnClick=     nil;
local realUnitPopup_HideButtons= nil;
local realUnitPopup_OnUpdate=    nil;

-- hook unitframes popup onlick method to catch our own summoning entry
local function HookedOnClick(...)
  local dropdownMenu= getglobal(UIDROPDOWNMENU_INIT_MENU);
  local button= this.value;

  if (button == "RAID_SUMMON" and dropdownMenu.unit) then
    rsm.SummonUnit(dropdownMenu.unit);
  end;

  realUnitPopup_OnClick(unpack(arg));
end;

-- hide "Summon" when target not in raid
local function HookedHideButtons(--[[...]]) -- see below
  --local rettab= { realUnitPopup_HideButtons(unpack(arg)) }; -- future compatibility disabled for performance reasons
  realUnitPopup_HideButtons();

  local dropdownMenu= getglobal(UIDROPDOWNMENU_INIT_MENU);
  for index, value in UnitPopupMenus[dropdownMenu.which] do
    if (value == "RAID_SUMMON") then
      if (rsmSaved.enabled and dropdownMenu.unit and (GetNumPartyMembers() > 0 or GetNumRaidMembers() > 0) --[[and (UnitInRaid(dropdownMenu.unit) or UnitInParty(dropdownMenu.unit))]]) then
        UnitPopupShown[index]= 1;
      else
        UnitPopupShown[index]= 0;
      end;
    end;
  end;

  --return unpack(rettab);
end;

-- disable "Summon" if target dead
local function HookedOnUpdate(elapsed)
  realUnitPopup_OnUpdate(elapsed);
 	
  -- return if dropdownlist not currently shown
	if (not (rsmSaved.enabled and DropDownList1:IsVisible())) then
		return;
	else
		-- make sure it's a unit-dropdown
		for index, value in UnitPopupFrames do
			if (UIDROPDOWNMENU_OPEN_MENU == value) then
				break;
			elseif (index == getn(UnitPopupFrames)) then
				return;
			end;
		end;
	end;
  
  --  locate summon button, enable or disable it
  local count= 0;
	local dropdownFrame= getglobal(UIDROPDOWNMENU_OPEN_MENU);
	for index, value in UnitPopupMenus[dropdownFrame.which] do
		if (UnitPopupShown[index] == 1) then
      count= count +1;
      if (value == "RAID_SUMMON") then
				if (UnitIsDeadOrGhost("player") or (not HasFullControl()) or UnitIsDeadOrGhost(dropdownFrame.unit)) then
          UIDropDownMenu_DisableButton(1, count+1);
				else
					UIDropDownMenu_EnableButton(1, count+1);
        end;
      end;
    end;
  end;
end;

-- public interface
rsmTargetFrame= {

  -- add "Summon" option to the targetframes dropdown menu (if target in group/raid)
  OnLoad= function()
    -- hook unit-popup menu functions
    realUnitPopup_OnClick=     UnitPopup_OnClick;
    UnitPopup_OnClick=         HookedOnClick;
    realUnitPopup_OnUpdate=    UnitPopup_OnUpdate;
    UnitPopup_OnUpdate=        HookedOnUpdate;
    realUnitPopup_HideButtons= UnitPopup_HideButtons;
    UnitPopup_HideButtons=     HookedHideButtons;
    
    -- register "Summon" with appropriate menus
    UnitPopupButtons["RAID_SUMMON"] = { text= RSM_UFMENU_SUMMON, dist = 0 };
    for index, value in UnitPopupMenus["PARTY"] do
      if (value == "CANCEL") then
        table.insert(UnitPopupMenus["PARTY"], index, "RAID_SUMMON");
        break;
      end;
    end;
    for index, value in UnitPopupMenus["RAID"] do
      if (value == "CANCEL") then
        table.insert(UnitPopupMenus["RAID"], index, "RAID_SUMMON");
        break;
      end;
    end;
    for index, value in UnitPopupMenus["PLAYER"] do
      if (value == "CANCEL") then
        table.insert(UnitPopupMenus["PLAYER"], index, "RAID_SUMMON");
        break;
      end;
    end;
  end;

}
-----------------------------  CT_RA Emergency Monitor Integration ---------------------------------
if not SqueakyWheel then SqueakyWheel = {} end

local _min_CTRA = 1.53  -- CT_RAOptions.lua
local _max_CTRA = 1.541

-- CT_RA_Emergency_UpdateHealth 1.53, with SqueakyWheel's unit sort instead of CT_RA
function SqueakyWheel.Emergency_UpdateHealth153()
	local tempOptions = CT_RAMenu_Options["temp"];
	local numRaidMembers = GetNumRaidMembers();
	if ( not tempOptions["ShowEmergency"] or ( numRaidMembers == 0 and not tempOptions["ShowEmergencyOutsideRaid"] ) ) then
		CT_RA_EmergencyFrame:Hide();
		return;
	else
		CT_RA_EmergencyFrame:Show();
	end
	for i = 1, 5, 1 do
		CT_RA_EmergencyFrame["frame"..i]:Hide();
	end
	CT_RA_EmergencyFrame.maxPercent = nil;
	local healthThreshold = tempOptions["EMThreshold"];
	if ( not healthThreshold ) then
		healthThreshold = 0.9;
	end
	CT_RA_Emergency_Units = { };
	local health;
	if ( not tempOptions["ShowEmergencyParty"] and GetNumRaidMembers() > 0 ) then
		health = CT_RA_Emergency_RaidHealth;
		health = { };
		local numMembers = GetNumRaidMembers();
		for i = 1, numMembers, 1 do
			local uId = "raid" .. i;
			local curr, max = UnitHealth(uId), UnitHealthMax(uId);
			if ( curr and max and curr/max <= healthThreshold ) then
				tinsert(health, { curr, max, uId, i, curr/max });
			end
		end
	else
		health = { };
		for i = 1, GetNumPartyMembers(), 1 do
			local uId = "party" .. i;
			local curr, max = UnitHealth(uId), UnitHealthMax(uId);
			if ( curr and max and curr/max <= healthThreshold) then
				tinsert(health, { curr, max, uId, nil, curr/max });
			end
		end
		local curr, max = UnitHealth("player"), UnitHealthMax("player");
		if ( curr/max <= healthThreshold ) then
			tinsert(health, { curr, max, "player", nil, curr/max });
		end
	end
	
	table.sort(
		health, 
		SqueakyWheel.EMSortComparator
	);
	CT_RA_EmergencyFrameTitle:Show();
	CT_RA_EmergencyFrameDrag:Show();
	local nextFrame = 0;
	for k, v in health do
		if ( not UnitIsDead(v[3]) and not UnitIsGhost(v[3]) and UnitIsConnected(v[3]) and UnitIsVisible(v[3]) and ( not CT_RA_Stats[UnitName(v[3])] or not CT_RA_Stats[UnitName(v[3])]["Dead"] ) and ( not tempOptions["EMClasses"] or not tempOptions["EMClasses"][UnitClass(v[3])] ) ) then
			local name, rank, subgroup, level, class, fileName;
			local obj = CT_RA_EmergencyFrame["frame" .. (nextFrame+1)];
			if ( GetNumRaidMembers() > 0 and not tempOptions["ShowEmergencyParty"] and v[4] ) then
				name, rank, subgroup, level, class, fileName = GetRaidRosterInfo(v[4]);
				local colors = RAID_CLASS_COLORS[fileName];
				if ( colors ) then
					obj.Name:SetTextColor(colors.r, colors.g, colors.b);
				end
			else
				obj.Name:SetTextColor(1, 1, 1);
			end
			if ( not subgroup or not tempOptions["EMGroups"] or not tempOptions["EMGroups"][subgroup] ) then
				nextFrame = nextFrame + 1;
				obj:Show();
				CT_RA_EmergencyFrame.maxPercent = v[5];
				CT_RA_Emergency_Units[UnitName(v[3])] = 1;
				obj.ClickFrame.unitid = v[3];
				obj.HPBar:SetMinMaxValues(0, v[2]);
				obj.HPBar:SetValue(v[1]);
				obj.Name:SetText(UnitName(v[3]));
				obj.Deficit:SetText(v[1]-v[2]);
				
				if ( UnitIsUnit(v[3], "player") ) then
					obj.HPBar:SetStatusBarColor(1, 0, 0);
					obj.HPBG:SetVertexColor(1, 0, 0, tempOptions["BGOpacity"]);
				elseif ( UnitInParty(v[3]) ) then
					obj.HPBar:SetStatusBarColor(0, 1, 1);
					obj.HPBG:SetVertexColor(0, 1, 1, tempOptions["BGOpacity"]);
				else
					obj.HPBar:SetStatusBarColor(0, 1, 0);
					obj.HPBG:SetVertexColor(0, 1, 0, tempOptions["BGOpacity"]);
				end
			end
		end
		if ( nextFrame == 5 ) then
			break;
		end
	end
end

function Squeaky_EM_OnClick(arg1)
  local stopDefaultBehaviour;
  if ( type(CT_RA_CustomOnClickFunction) == "function" ) then
    stopDefaultBehaviour = SqueakyWheel.OnClick(arg1, this.unitid);
  end
  if ( not stopDefaultBehaviour ) then
    if ( SpellIsTargeting() ) then
      SpellTargetUnit(this.unitid);
    else
      TargetUnit(this.unitid);
    end
  end
end

function CT_RA_EM_SetHooks()
  getglobal("CT_RA_EmergencyFrameFrame1ClickFrame"):SetScript("OnClick",Squeaky_EM_OnClick)
  getglobal("CT_RA_EmergencyFrameFrame2ClickFrame"):SetScript("OnClick",Squeaky_EM_OnClick)
  getglobal("CT_RA_EmergencyFrameFrame3ClickFrame"):SetScript("OnClick",Squeaky_EM_OnClick)
  getglobal("CT_RA_EmergencyFrameFrame4ClickFrame"):SetScript("OnClick",Squeaky_EM_OnClick)
  getglobal("CT_RA_EmergencyFrameFrame5ClickFrame"):SetScript("OnClick",Squeaky_EM_OnClick)
end

local squeakCT_RA_Emergency_UpdateHealth
function SqueakyWheel.CT_RA()
  if SqueakyConfig.displayEmergency then
    if CT_RA_VersionNumber and 
       CT_RA_VersionNumber>=_min_CTRA and 
       CT_RA_VersionNumber<=_max_CTRA then
      SqueakyWheel.Debug("SqueakyWheel CT_RaidAssist 1.53x integration enabled")
    else
      SqueakyWheel.Debug("SqueakyWheel: |cffff0000new CT_RaidAssist version -- integration may not work.  Check SqueakyWheel for new version.|r")
    end
    if not squeakCT_RA_Emergency_UpdateHealth then
      squeakCT_RA_Emergency_UpdateHealth = CT_RA_Emergency_UpdateHealth
    end
    CT_RA_Emergency_UpdateHealth = SqueakyWheel.Emergency_UpdateHealth153
    CT_RA_EM_SetHooks()
  else
    CT_RA_Emergency_UpdateHealth = squeakCT_RA_Emergency_UpdateHealth
  end
end

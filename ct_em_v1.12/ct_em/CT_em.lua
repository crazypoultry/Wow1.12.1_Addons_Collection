CT_RA_Emergency2_RaidHealth = { };
CT_RA_Emergency2_Units = { };

Emer2="Emergency Monitor2"

local oldCT_RAMenu_UpdateMenu;
local oldCT_RAMenuMisc_OnUpdate;
local oldCT_RAMenuAdditional_EM_OnValueChanged;
local oldCT_RAMenu_SaveWindowPositions;
ctem_enable=0;

function CT_em_OnLoad()


	SLASH_CTEM1 = "/ctem";
	SlashCmdList["CTEM"] = function(msg)
		ctem_Cmd(msg);
	end
	this:RegisterEvent("ADDON_LOADED");
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("PLAYER_LEAVING_WORLD");
	this:RegisterEvent("RAID_ROSTER_UPDATE");
	this:RegisterEvent("UNIT_HEALTH");
	this:RegisterEvent("UNIT_MAXHEALTH");
-- hook

oldCT_RAMenu_UpdateMenu = CT_RAMenu_UpdateMenu;
oldCT_RAMenuMisc_OnUpdate = CT_RAMenuMisc_OnUpdate;
oldCT_RAMenuAdditional_EM_OnValueChanged = CT_RAMenuAdditional_EM_OnValueChanged;

-- CT_RAMenuMisc_OnUpdate =CT_emMenuMisc_OnUpdate;
-- CT_RAMenu_UpdateMenu = CT_emMenu_UpdateMenu;
-- CT_RAMenuAdditional_EM_OnValueChanged = CT_emMenuAdditional_EM_OnValueChanged;

oldCT_RAMenu_SaveWindowPositions =CT_RAMenu_SaveWindowPositions;
CT_RAMenu_SaveWindowPositions = CT_em_SaveWindowPositions
end

function ctem_Cmd(msg)

	if (CT_RA_Emergency2Frame:IsVisible()) then
		CT_RAMenu_UpdateMenu = oldCT_RAMenu_UpdateMenu;
		CT_RAMenuMisc_OnUpdate = oldCT_RAMenuMisc_OnUpdate;
		CT_RAMenuAdditional_EM_OnValueChanged = oldCT_RAMenuAdditional_EM_OnValueChanged;
--		ChatFrame1:AddMessage("|cffffff80  1->0"..ctem_enable);
	
	        ctem_enable=0
		CT_RA_Emergency2Frame:Hide();
	elseif  (not CT_RA_Emergency2Frame:IsVisible())  then
		CT_RAMenu_UpdateMenu = CT_emMenu_UpdateMenu;
		CT_RAMenuMisc_OnUpdate =CT_emMenuMisc_OnUpdate;
		CT_RAMenuAdditional_EM_OnValueChanged = CT_emMenuAdditional_EM_OnValueChanged;
--		ChatFrame1:AddMessage("|cffffff80 0->1"..ctem_enable);
		ctem_enable=1;
		CT_RA_Emergency2Frame:Show();
		CT_RA_Emergency2_UpdateHealth();
	end
end


function  ctem_Event()
	if (ctem_enable==1) then
		CT_RA_Emergency2_UpdateHealth();
	end
	if (event == "VARIABLES_LOADED") then
		CT_RA_Emergency2FrameTitle:SetText(Emer2);
	end
end


function CT_em_SaveWindowPositions()
	oldCT_RAMenu_SaveWindowPositions();
	windowpos2();
end


function windowpos2()
	left, top, uitop = CT_RA_Emergency2FrameDrag:GetLeft(), CT_RA_Emergency2FrameDrag:GetTop(), UIParent:GetTop();
	if ( left and top and uitop ) then
		CT_RAMenu_Options["temp"]["WindowPositions"]["CT_RA_Emergency2FrameDrag"] = { left, top-uitop };
	end
end


-- hooked functions
function CT_emMenuAdditional_EM_OnValueChanged()
	if ( this:GetID() == 1 ) then
		CT_RAMenu_Options["temp"]["EMThreshold"] = floor(this:GetValue()*100+0.5)/100;
		getglobal(this:GetName() .. "Text"):SetText("Health Threshold - " .. floor(this:GetValue()*100+0.5) .. "%");
		CT_RA_Emergency_UpdateHealth();
		CT_RA_Emergency2_UpdateHealth();
	else
		CT_RAMenu_Options["temp"]["EMScaling"] = floor(this:GetValue()*100+0.5)/100;
		getglobal(this:GetName() .. "Text"):SetText("Scaling - " .. floor(this:GetValue()*100+0.5) .. "%");
		
		local newScaling = CT_RAMenu_Options["temp"]["EMScaling"];
		CT_RA_EmergencyFrame:SetScale(newScaling);
		CT_RA_EmergencyFrameDrag:SetWidth(CT_RA_EmergencyFrame:GetWidth()*newScaling+(27.5*newScaling));
		CT_RA_EmergencyFrameDrag:SetHeight(CT_RA_EmergencyFrame:GetHeight()*newScaling/5);
		CT_RA_Emergency2Frame:SetScale(newScaling);
		CT_RA_Emergency2FrameDrag:SetWidth(CT_RA_Emergency2Frame:GetWidth()*newScaling+(27.5*newScaling));
		CT_RA_Emergency2FrameDrag:SetHeight(CT_RA_Emergency2Frame:GetHeight()*newScaling/5);
	end
end



function CT_emMenuMisc_OnUpdate(elapsed)
	if ( this.scaleupdate ) then
		this.scaleupdate = this.scaleupdate - elapsed;
		if ( this.scaleupdate <= 0 ) then
			this.scaleupdate = 10;
			if ( CT_RAMenu_Options["temp"]["WindowScaling"] ) then
				local newScaling = CT_RAMenu_Options["temp"]["WindowScaling"];
				for i = 1, 40, 1 do
					if ( i <= 8 ) then
						getglobal("CT_RAGroupDrag" .. i):SetWidth(CT_RAGroup1:GetWidth()*newScaling+(22*newScaling));
						getglobal("CT_RAGroupDrag" .. i):SetHeight(CT_RAMember1:GetHeight()*newScaling/2);
						getglobal("CT_RAGroup" .. i):SetScale(newScaling);
					end
					getglobal("CT_RAMember" .. i):SetScale(newScaling);
				end
			end
			if ( CT_RAMenu_Options["temp"]["MTScaling"] ) then
				local newScaling = CT_RAMenu_Options["temp"]["MTScaling"];
				for i = 1, 10, 1 do
					getglobal("CT_RAMTGroupMember" .. i):SetScale(newScaling);
					getglobal("CT_RAPTGroupMember" .. i):SetScale(newScaling);
				end
				CT_RAMTGroup:SetScale(newScaling);
				CT_RAPTGroup:SetScale(newScaling);
				CT_RAMTGroupDrag:SetWidth(CT_RAMTGroup:GetWidth()*newScaling+(22*newScaling));
				CT_RAMTGroupDrag:SetHeight(CT_RAMTGroupMember1:GetHeight()*newScaling/2);
				CT_RAPTGroupDrag:SetWidth(CT_RAPTGroup:GetWidth()*newScaling+(22*newScaling));
				CT_RAPTGroupDrag:SetHeight(CT_RAPTGroupMember1:GetHeight()*newScaling/2);
			end
			if ( CT_RAMenu_Options["temp"]["EMScaling"] ) then
				local newScaling = CT_RAMenu_Options["temp"]["EMScaling"];
				CT_RA_EmergencyFrame:SetScale(newScaling);
				CT_RA_EmergencyFrameDrag:SetWidth(CT_RA_EmergencyFrame:GetWidth()*newScaling+(27.5*newScaling));
				CT_RA_EmergencyFrameDrag:SetHeight(CT_RA_EmergencyFrame:GetHeight()*newScaling/5);
				CT_RA_Emergency2Frame:SetScale(newScaling);
				CT_RA_Emergency2FrameDrag:SetWidth(CT_RA_Emergency2Frame:GetWidth()*newScaling+(27.5*newScaling));
				CT_RA_Emergency2FrameDrag:SetHeight(CT_RA_Emergency2Frame:GetHeight()*newScaling/5);
			end
		end
	end
end



function CT_emMenu_UpdateMenu()
	local tempOptions = CT_RAMenu_Options["temp"];
	local admiralsHat, foundDampen;
	for k, v in tempOptions["BuffArray"] do
		if ( v["name"] == CT_RA_DAMPENMAGIC ) then
			foundDampen = k;
		elseif ( v["name"] == CT_RA_ADMIRALSHAT ) then
			admiralsHat = k;
		elseif ( v["name"] == "Don du fauve" ) then
			-- Change name of buffs.. Not a too great way of doing it, but it works (I'll fix this design as soon as possible, it's terrible I know)
			tempOptions["BuffArray"][k]["name"] = CT_RA_MARKOFTHEWILD[2];
		elseif ( v["name"] == "Marque du fauve" ) then
			tempOptions["BuffArray"][k]["name"] = CT_RA_MARKOFTHEWILD[1];
		elseif ( v["name"] == CT_RA_BLESSINGOFMIGHT[1] ) then
			tempOptions["BuffArray"][k]["name"] = CT_RA_BLESSINGOFMIGHT;
		elseif ( v["name"] == CT_RA_BLESSINGOFWISDOM[1] ) then
			tempOptions["BuffArray"][k]["name"] = CT_RA_BLESSINGOFWISDOM;
		elseif ( v["name"] == CT_RA_BLESSINGOFKINGS[1] ) then
			tempOptions["BuffArray"][k]["name"] = CT_RA_BLESSINGOFKINGS;
		elseif ( v["name"] == CT_RA_BLESSINGOFSALVATION[1] ) then
			tempOptions["BuffArray"][k]["name"] = CT_RA_BLESSINGOFSALVATION;
		elseif ( v["name"] == CT_RA_BLESSINGOFLIGHT[1] ) then
			tempOptions["BuffArray"][k]["name"] = CT_RA_BLESSINGOFLIGHT;
		elseif ( v["name"] == CT_RA_BLESSINGOFSANCTUARY[1] ) then
			tempOptions["BuffArray"][k]["name"] = CT_RA_BLESSINGOFSANCTUARY;
		elseif ( v["name"] == CT_RA_DIVINESPIRIT[1] ) then
			tempOptions["BuffArray"][k]["name"] = CT_RA_DIVINESPIRIT;
		elseif ( v["name"] == CT_RA_SHADOWPROTECTION[1] ) then
			tempOptions["BuffArray"][k]["name"] = CT_RA_SHADOWPROTECTION;
		end
	end
	if ( admiralsHat ) then
		tremove(tempOptions["BuffArray"], admiralsHat);
	end
	if ( not foundDampen ) then
		tinsert(tempOptions["BuffArray"], { ["show"] = -1, ["name"] = CT_RA_AMPLIFYMAGIC, ["index"] = 20 });
		tinsert(tempOptions["BuffArray"], { ["show"] = -1, ["name"] = CT_RA_DAMPENMAGIC, ["index"] = 21 });
	end
	for i = 1, 6, 1 do
		if ( type(tempOptions["DebuffColors"][i]["type"]) == "table" ) then
			getglobal("CT_RAMenuFrameBuffsDebuff" .. i .. "Text"):SetText(string.gsub(tempOptions["DebuffColors"][i]["type"][CT_RA_GetLocale()], "_", " "));
		else
			getglobal("CT_RAMenuFrameBuffsDebuff" .. i .. "Text"):SetText(string.gsub(tempOptions["DebuffColors"][i]["type"], "_", " "));
		end
		local val = tempOptions["DebuffColors"][i];
		getglobal("CT_RAMenuFrameBuffsDebuff" .. i .. "SwatchNormalTexture"):SetVertexColor(val.r, val.g, val.b);

		if ( val["id"] ~= -1 ) then
			getglobal("CT_RAMenuFrameBuffsDebuff" .. i .. "CheckButton"):SetChecked(1);
			getglobal("CT_RAMenuFrameBuffsDebuff" .. i .. "Text"):SetTextColor(1, 1, 1);
		else
			getglobal("CT_RAMenuFrameBuffsDebuff" .. i .. "CheckButton"):SetChecked(nil);
			getglobal("CT_RAMenuFrameBuffsDebuff" .. i .. "Text"):SetTextColor(0.3, 0.3, 0.3);
		end
	end
	for key, val in tempOptions["BuffArray"] do
		if ( val["show"] ~= -1 ) then
			getglobal("CT_RAMenuFrameBuffsBuff" .. key .. "CheckButton"):SetChecked(1);
			getglobal("CT_RAMenuFrameBuffsBuff" .. key .. "Text"):SetTextColor(1, 1, 1);
		else
			getglobal("CT_RAMenuFrameBuffsBuff" .. key .. "CheckButton"):SetChecked(nil);
			getglobal("CT_RAMenuFrameBuffsBuff" .. key .. "Text"):SetTextColor(0.3, 0.3, 0.3);
		end
		local spell = val["name"];
		if ( type(spell) == "table" ) then
			getglobal("CT_RAMenuFrameBuffsBuff" .. key .. "Text"):SetText(spell[1]);
			getglobal("CT_RAMenuFrameBuffsBuff" .. key).tooltip = spell[1] .. " & " .. spell[2];
		else
			getglobal("CT_RAMenuFrameBuffsBuff" .. key .. "Text"):SetText(spell);
			getglobal("CT_RAMenuFrameBuffsBuff" .. key).tooltip = nil;
		end
	end
	CT_RAMenuFrameBuffsNotifyDebuffs:SetChecked(tempOptions["NotifyDebuffs"]);

	for i = 1, 8, 1 do
		getglobal("CT_RAMenuFrameBuffsNotifyDebuffsGroup" .. i .. "Text"):SetText("Group " .. i);
		if ( not tempOptions["NotifyDebuffs"] or ( not tempOptions["NotifyDebuffs"]["main"] and tempOptions["NotifyDebuffs"]["hidebuffs"] ) ) then
			getglobal("CT_RAMenuFrameBuffsNotifyDebuffsGroup" .. i .. "Text"):SetTextColor(0.3, 0.3, 0.3);
			getglobal("CT_RAMenuFrameBuffsNotifyDebuffsGroup" .. i .. "CheckButton"):Disable();
			getglobal("CT_RAMenuFrameBuffsNotifyDebuffsClass" .. i .. "Text"):SetTextColor(0.3, 0.3, 0.3);
			getglobal("CT_RAMenuFrameBuffsNotifyDebuffsClass" .. i .. "CheckButton"):Disable();
		end
		getglobal("CT_RAMenuFrameBuffsNotifyDebuffs"):SetChecked(tempOptions["NotifyDebuffs"]["main"]);
		getglobal("CT_RAMenuFrameBuffsNotifyBuffs"):SetChecked(not tempOptions["NotifyDebuffs"]["hidebuffs"]);

		getglobal("CT_RAMenuFrameBuffsNotifyDebuffsGroup" .. i .. "CheckButton"):SetChecked(tempOptions["NotifyDebuffs"][i]);
		getglobal("CT_RAMenuFrameBuffsNotifyDebuffsClass" .. i .. "CheckButton"):SetChecked(tempOptions["NotifyDebuffsClass"][i]);
	end
	for k, v in CT_RA_ClassPositions do
		if ( k ~= CT_RA_SHAMAN or ( UnitFactionGroup("player") and UnitFactionGroup("player") == "Horde" ) ) then
			getglobal("CT_RAMenuFrameBuffsNotifyDebuffsClass" .. v .. "Text"):SetText(k);
		end
	end
	CT_RAMenuFrameGeneralDisplayShowMPCB:SetChecked(tempOptions["HideMP"]);
	CT_RAMenuFrameGeneralDisplayShowRPCB:SetChecked(tempOptions["HideRP"]);
	if ( tempOptions["MemberHeight"] == 32 ) then
		CT_RAMenuFrameGeneralDisplayShowHealthCB:SetChecked(1);
	else
		CT_RAMenuFrameGeneralDisplayShowHealthCB:SetChecked(nil);
	end

	CT_RAMenuFrameGeneralDisplayShowGroupsCB:SetChecked(not tempOptions["HideNames"]);
	CT_RAMenuFrameGeneralDisplayLockGroupsCB:SetChecked(tempOptions["LockGroups"]);
	CT_RAMenuFrameGeneralDisplayWindowColorSwatchNormalTexture:SetVertexColor(tempOptions["DefaultColor"].r, tempOptions["DefaultColor"].g, tempOptions["DefaultColor"].b);
	CT_RAMenuFrameGeneralDisplayShowHPSwatchNormalTexture:SetVertexColor(tempOptions["PercentColor"].r, tempOptions["PercentColor"].g, tempOptions["PercentColor"].b);
	CT_RAMenuFrameGeneralDisplayAlertColorSwatchNormalTexture:SetVertexColor(tempOptions["DefaultAlertColor"].r, tempOptions["DefaultAlertColor"].g, tempOptions["DefaultAlertColor"].b);

	CT_RA_UpdateRaidGroupColors();
	CT_RA_UpdateRaidMovability();
	if ( tempOptions["ShowHP"] ) then
		UIDropDownMenu_SetSelectedID(CT_RAMenuFrameGeneralDisplayHealthDropDown, tempOptions["ShowHP"]);
	else
		UIDropDownMenu_SetSelectedID(CT_RAMenuFrameGeneralDisplayHealthDropDown, 5);
	end
	if ( tempOptions["ShowDebuffs"] ) then
		UIDropDownMenu_SetSelectedID(CT_RAMenuFrameBuffsBuffsDropDown, 2);
		CT_RAMenuFrameBuffsBuffsDropDownText:SetText("Show debuffs");
	elseif ( tempOptions["ShowBuffsDebuffed"] ) then
		UIDropDownMenu_SetSelectedID(CT_RAMenuFrameBuffsBuffsDropDown, 3);
		CT_RAMenuFrameBuffsBuffsDropDownText:SetText("Show buffs until debuffed");
	else
		UIDropDownMenu_SetSelectedID(CT_RAMenuFrameBuffsBuffsDropDown, 1);
		CT_RAMenuFrameBuffsBuffsDropDownText:SetText("Show buffs");
	end
	local num = 0;
	if ( tempOptions["ShowGroups"] ) then
		for k, v in tempOptions["ShowGroups"] do
			num = num + 1;
			getglobal("CT_RAOptionsGroupCB" .. k):SetChecked(1);
		end
		if ( num > 0 ) then
			CT_RACheckAllGroups:SetChecked(1);
		else
			CT_RACheckAllGroups:SetChecked(nil);
		end
	else
		for i = 1, 8, 1 do
			getglobal("CT_RAOptionsGroupCB" .. i):SetChecked(nil);
		end
	end
	CT_RAMenuFrameGeneralMiscHideOfflineCB:SetChecked(tempOptions["HideOffline"]);
	CT_RAMenuFrameGeneralMiscSortAlphaCB:SetChecked(tempOptions["SubSortByName"]);
	CT_RAMenuFrameGeneralMiscBorderCB:SetChecked(tempOptions["HideBorder"]);
	CT_RAMenuFrameGeneralMiscRemoveSpacingCB:SetChecked(tempOptions["HideSpace"]);
	CT_RAMenuFrameGeneralMiscShowHorizontalCB:SetChecked(tempOptions["ShowHorizontal"]);
	CT_RAMenuFrameGeneralMiscShowReversedCB:SetChecked(tempOptions["ShowReversed"]);
	CT_RAMenuFrameGeneralMiscShowMTsCB:SetChecked(not tempOptions["HideMTs"]);
	CT_RAMenuFrameGeneralMiscShowMetersCB:SetChecked( (tempOptions["StatusMeters"] and tempOptions["StatusMeters"]["Show"] ) );
	CT_RAMenuFrameMiscNotificationsShowTankDeathCB:SetChecked(not tempOptions["HideTankNotifications"]);
	CT_RAMenuFrameMiscNotificationsPlayRSSoundCB:SetChecked(tempOptions["PlayRSSound"]);
	CT_RAMenuFrameMiscNotificationsSendRARSCB:SetChecked(tempOptions["SendRARS"]);
	CT_RAMenuFrameMiscDisplayShowAFKCB:SetChecked(tempOptions["ShowAFK"]);
	CT_RAMenuFrameMiscDisplayShowTooltipCB:SetChecked(not tempOptions["HideTooltip"]);
	CT_RAMenuFrameMiscNotificationsDisableQueryCB:SetChecked(tempOptions["DisableQuery"]);
	CT_RAMenuFrameMiscNotificationsNotifyGroupChangeCB:SetChecked(tempOptions["NotifyGroupChange"]);
	CT_RAMenuFrameMiscNotificationsNotifyGroupChangeCBSound:SetChecked(tempOptions["NotifyGroupChangeSound"]);
	CT_RAMenuFrameMiscDisplayNoColorChangeCB:SetChecked(tempOptions["HideColorChange"]);
	CT_RAMenuFrameMiscDisplayShowResMonitorCB:SetChecked(tempOptions["ShowMonitor"]);
	CT_RAMenuFrameMiscDisplayHideButtonCB:SetChecked(tempOptions["HideButton"]);
	CT_RAMenuFrameMiscDisplayShowPTTCB:SetChecked(tempOptions["ShowPTT"]);
	CT_RAMenuFrameMiscDisplayShowMTTTCB:SetChecked(tempOptions["ShowMTTT"]);
	CT_RAMenuFrameAdditionalEMShowCB:SetChecked(tempOptions["ShowEmergency"]);
	CT_RAMenuFrameMiscNotificationsAggroNotifierCB:SetChecked(tempOptions["AggroNotifier"]);
	CT_RAMenuFrameMiscNotificationsAggroNotifierSoundCB:SetChecked(tempOptions["AggroNotifierSound"]);
	CT_RAMenuFrameMiscDisplayColorLeaderCB:SetChecked( ( not tempOptions["leaderColor"] or tempOptions["leaderColor"].enabled ) );
	
	if ( tempOptions["leaderColor"] ) then
		CT_RAMenuFrameMiscDisplayColorLeaderColorSwatchNormalTexture:SetVertexColor(tempOptions["leaderColor"].r, tempOptions["leaderColor"].g, tempOptions["leaderColor"].b);
	else
		CT_RAMenuFrameMiscDisplayColorLeaderColorSwatchNormalTexture:SetVertexColor(1, 1, 0);
	end
	
	if ( not tempOptions["HideBorder"] ) then
		CT_RAMenuFrameGeneralMiscRemoveSpacingCB:Disable();
		CT_RAMenuFrameGeneralMiscRemoveSpacingText:SetTextColor(0.3, 0.3, 0.3);
	end
	
	local numMts = tempOptions["ShowNumMTs"];
	if ( numMts == 1 ) then
		CT_RAMenuFrameGeneralMTsSubtract:Disable();
	elseif ( numMts == 10 ) then
		CT_RAMenuFrameGeneralMTsAdd:Disable();
	end
	CT_RAMenuFrameGeneralMTsNum:SetText(numMts or 10);
	
	if ( not tempOptions["AggroNotifier"] ) then
		CT_RAMenuFrameMiscNotificationsAggroNotifierSoundCB:Disable();
		CT_RAMenuFrameMiscNotificationsAggroNotifierSound:SetTextColor(0.3, 0.3, 0.3);
	end
	if ( not tempOptions["ShowEmergency"] ) then
		CT_RAMenuFrameAdditionalEMPartyCB:Disable();
		CT_RAMenuFrameAdditionalEMPartyText:SetTextColor(0.3, 0.3, 0.3);
		CT_RAMenuFrameAdditionalEMOutsideRaidCB:Disable();
		CT_RAMenuFrameAdditionalEMOutsideRaidText:SetTextColor(0.3, 0.3, 0.3);
	end
	CT_RAMenuFrameAdditionalEMPartyCB:SetChecked(tempOptions["ShowEmergencyParty"]);
	CT_RAMenuFrameAdditionalEMOutsideRaidCB:SetChecked(tempOptions["ShowEmergencyOutsideRaid"]);
	if ( tempOptions["HideButton"] ) then
		CT_RASets_Button:Hide();
	else
		CT_RASets_Button:Show();
	end
	if ( not tempOptions["NotifyGroupChange"] ) then
		CT_RAMenuFrameMiscNotificationsNotifyGroupChangeCBSound:Disable();
		CT_RAMenuFrameMiscNotificationsNotifyGroupChangeSound:SetTextColor(0.3, 0.3, 0.3);
	else
		CT_RAMenuFrameMiscNotificationsNotifyGroupChangeCBSound:Enable();
		CT_RAMenuFrameMiscNotificationsNotifyGroupChangeSound:SetTextColor(1, 1, 1);
	end
	if ( not tempOptions["ShowMTTT"] ) then
		CT_RAMenuFrameMiscDisplayNoColorChangeCB:Disable();
		CT_RAMenuFrameMiscDisplayNoColorChange:SetTextColor(0.3, 0.3, 0.3);
	else
		CT_RAMenuFrameMiscDisplayNoColorChangeCB:Enable();
		CT_RAMenuFrameMiscDisplayNoColorChange:SetTextColor(1, 1, 1);
	end
	if ( tempOptions["WindowScaling"] ) then
		CT_RAMenuGlobalFrame.scaleupdate = 0.1;
	end
	if ( tempOptions["SORTTYPE"] == "class" ) then
		CT_RA_SetSortType("class");
	elseif ( tempOptions["SORTTYPE"] == "custom" ) then
		CT_RA_SetSortType("custom");
	elseif ( tempOptions["SORTTYPE"] == "virtual" ) then
		CT_RA_SetSortType("virtual");
	else
		CT_RA_SetSortType("group");
	end
	if ( tempOptions["StatusMeters"] ) then
		CT_RAMetersFrame:SetBackdropColor(tempOptions["StatusMeters"]["Background"].r, tempOptions["StatusMeters"]["Background"].g, tempOptions["StatusMeters"]["Background"].b, tempOptions["StatusMeters"]["Background"].a);
		CT_RAMetersFrame:SetBackdropBorderColor(1, 1, 1, tempOptions["StatusMeters"]["Background"].a);
		if ( tempOptions["StatusMeters"]["Show"] and GetNumRaidMembers() > 0 ) then
			CT_RAMetersFrame:Show();
		else
			CT_RAMetersFrame:Hide();
		end
	end
	if ( tempOptions["EMBG"] ) then
		CT_RA_EmergencyFrame:SetBackdropColor(tempOptions["EMBG"].r, tempOptions["EMBG"].g, tempOptions["EMBG"].b, tempOptions["EMBG"].a);
		CT_RA_EmergencyFrame:SetBackdropBorderColor(1, 1, 1, tempOptions["EMBG"].a);
		CT_RA_Emergency2Frame:SetBackdropColor(tempOptions["EMBG"].r, tempOptions["EMBG"].g, tempOptions["EMBG"].b, tempOptions["EMBG"].a);
		CT_RA_Emergency2Frame:SetBackdropBorderColor(1, 1, 1, tempOptions["EMBG"].a);
	end
	if ( tempOptions["RMBG"] ) then
		CT_RA_ResFrame:SetBackdropColor(tempOptions["RMBG"].r, tempOptions["RMBG"].g, tempOptions["RMBG"].b, tempOptions["RMBG"].a);
		CT_RA_ResFrame:SetBackdropBorderColor(1, 1, 1, tempOptions["RMBG"].a);
	end
	if ( tempOptions["ShowHP"] ) then
		local table = { "Show Values", "Show Percentages", "Show Deficit", "Show only MTT HP %" };
		UIDropDownMenu_SetSelectedID(CT_RAMenuFrameGeneralDisplayHealthDropDown, tempOptions["ShowHP"]);
		CT_RAMenuFrameGeneralDisplayHealthDropDownText:SetText(table[tempOptions["ShowHP"]]);
	else
		UIDropDownMenu_SetSelectedID(CT_RAMenuFrameGeneralDisplayHealthDropDown, 5);
		CT_RAMenuFrameGeneralDisplayHealthDropDownText:SetText("Show None");
	end
	CT_RAMenuAdditional_Scaling_OnShow(CT_RAMenuFrameAdditionalScalingSlider1);
	CT_RAMenuAdditional_ScalingMT_OnShow(CT_RAMenuFrameAdditionalScalingSlider2);
	CT_RAMenuAdditional_EM_OnShow(CT_RAMenuFrameAdditionalEMSlider);
	CT_RAMenuAdditional_EM_OnShow(CT_RAMenuFrameAdditionalEMSlider2);
	CT_RAMenuAdditional_BG_OnShow(CT_RAMenuFrameAdditionalBGSlider);
	CT_RA_Emergency_UpdateHealth();
	CT_RA_Emergency2_UpdateHealth();
	CT_RAMenu_UpdateWindowPositions();
	windowpos2();
end


-- monitor2 

function CT_RA_Emergency2_UpdateHealth()
	local tempOptions = CT_RAMenu_Options["temp"];
	local numRaidMembers = GetNumRaidMembers();
	if ( not tempOptions["ShowEmergency"] or ( numRaidMembers == 0 and not tempOptions["ShowEmergencyOutsideRaid"] ) ) then
		CT_RA_Emergency2Frame:Hide();
		return;

	else
		CT_RA_Emergency2Frame:Show();
	end
	for i = 1, 5, 1 do
		CT_RA_Emergency2Frame["frame"..i]:Hide();
	end
	CT_RA_Emergency2Frame.maxPercent = nil;
	local healthThreshold = tempOptions["EMThreshold"];
	if ( not healthThreshold ) then
		healthThreshold = 0.9;
	end
	CT_RA_Emergency2_Units = { };
	local health;
	if ( not tempOptions["ShowEmergencyParty"] and GetNumRaidMembers() > 0 ) then
		health = CT_RA_Emergency2_RaidHealth;
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
		function(v1, v2)
			return v1[5] < v2[5];
		end
	);
	CT_RA_Emergency2FrameTitle:Show();
	CT_RA_Emergency2FrameDrag:Show();
	local nextFrame = 0;
	for k, v in health do
		if ( not UnitIsDead(v[3]) and not UnitIsGhost(v[3]) and UnitIsConnected(v[3]) and UnitIsVisible(v[3]) and ( not CT_RA_Stats[UnitName(v[3])] or not CT_RA_Stats[UnitName(v[3])]["Dead"] ) and ( not tempOptions["EM2Classes"] or not tempOptions["EM2Classes"][UnitClass(v[3])] ) ) then
			local name, rank, subgroup, level, class, fileName;
			local obj = CT_RA_Emergency2Frame["frame" .. (nextFrame+1)];
			if ( GetNumRaidMembers() > 0 and not tempOptions["ShowEmergencyParty"] and v[4] ) then
				name, rank, subgroup, level, class, fileName = GetRaidRosterInfo(v[4]);
				local colors = RAID_CLASS_COLORS[fileName];
				if ( colors ) then
					obj.Name:SetTextColor(colors.r, colors.g, colors.b);
				end
			else
				obj.Name:SetTextColor(1, 1, 1);
			end
			if ( not subgroup or not tempOptions["EM2Groups"] or not tempOptions["EM2Groups"][subgroup] ) then
				nextFrame = nextFrame + 1;
				obj:Show();
				CT_RA_Emergency2Frame.maxPercent = v[5];
				CT_RA_Emergency2_Units[UnitName(v[3])] = 1;
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

function CT_RA_Emergency2_TargetMember(num)
	local obj = CT_RA_Emergency2Frame["frame"..num];
	if ( obj:IsVisible() and obj.ClickFrame.unitid ) then
		TargetUnit(obj.ClickFrame.unitid);
	end
end

function CT_RA_Emergency2_OnEnter()
	if ( SpellIsTargeting() ) then
		SetCursor("CAST_CURSOR");
	elseif ( not SpellCanTargetUnit(this.unitid) and SpellIsTargeting() ) then
		SetCursor("CAST_ERROR_CURSOR");
	end
end

function CT_RA_Emergency2_OnUpdate(elapsed)
	this.update = this.update - elapsed;
	if ( this.update <= 0 ) then
		this.update = 0.1;
		if ( this.cursor ) then
			if ( SpellIsTargeting() and SpellCanTargetUnit(this.unitid) ) then
				SetCursor("CAST_CURSOR");
			elseif ( SpellIsTargeting() ) then
				SetCursor("CAST_ERROR_CURSOR");
			end
		end
	end
end

function CT_RA_Emergency2_DropDown_OnLoad()
	UIDropDownMenu_Initialize(this, CT_RA_Emergency2_DropDown_Initialize, "MENU");
end

function CT_RA_Emergency2_DropDown_Initialize()
	local tempOptions = CT_RAMenu_Options["temp"];
	local dropdown, info;
	if ( UIDROPDOWNMENU_OPEN_MENU ) then
		dropdown = getglobal(UIDROPDOWNMENU_OPEN_MENU);
	else
		dropdown = this;
	end
	if ( UIDROPDOWNMENU_MENU_VALUE == "Classes" ) then
		info = {};
		info.text = "Classes";
		info.isTitle = 1;
		info.notCheckable = 1;
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
		for k, v in CT_RA_ClassPositions do
			if ( ( k ~= CT_RA_SHAMAN or ( UnitFactionGroup("player") and UnitFactionGroup("player") == "Horde" ) ) and ( k ~= CT_RA_PALADIN or ( UnitFactionGroup("player") and UnitFactionGroup("player") == "Alliance" ) ) ) then
				info = {};
				info.text = k;
				info.value = k;
				info.func = CT_RA_Emergency2_DropDown_OnClick;
				info.checked = ( not tempOptions["EM2Classes"] or not tempOptions["EM2Classes"][k] );
				info.keepShownOnClick = 1;
				info.tooltipTitle = "Toggle Class";
				info.tooltipText = "Toggles displaying the selected class, allowing you to hide certain classes from the Emergency Monitor.";
				UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
			end
		end
		return;
	end

	if ( UIDROPDOWNMENU_MENU_VALUE == "Groups" ) then
		info = {};
		info.text = "Groups";
		info.isTitle = 1;
		info.notCheckable = 1;
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
		for i = 1, 8, 1 do
			info = {};
			info.text = "Group " .. i;
			info.value = i;
			info.func = CT_RA_Emergency2_DropDown_OnClick;
			info.checked = ( not tempOptions["EM2Groups"] or not tempOptions["EM2Groups"][i] );
			info.keepShownOnClick = 1;
			info.tooltipTitle = "Toggle Group";
			info.tooltipText = "Toggles displaying the selected group, allowing you to hide certain groups from the Emergency Monitor.";
			UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
		end
		return;
	end
	info = {};
	info.text = "Emergency Monitor2";
	info.isTitle = 1;
	info.notCheckable = 1;
	UIDropDownMenu_AddButton(info);
	
	info = {};
	info.text = "Classes";
	info.hasArrow = 1;
	info.notCheckable = 1;
	UIDropDownMenu_AddButton(info);
	
	info = {};
	info.text = "Groups";
	info.hasArrow = 1;
	info.notCheckable = 1;
	UIDropDownMenu_AddButton(info);

	info = { };
	info.text = "Background Color";
	info.hasColorSwatch = 1;
	info.hasOpacity = 1;
	if ( tempOptions["EMBG"] ) then
		info.r = ( tempOptions["EMBG"].r );
		info.g = ( tempOptions["EMBG"].g );
		info.b = ( tempOptions["EMBG"].b );
		info.opacity = ( tempOptions["EMBG"].a );
	else
		info.r = 0;
		info.g = 0;
		info.b = 1;
		info.opacity = 0;
	end
	info.notClickable = 1;
	info.swatchFunc = CT_RA_Emergency2_DropDown_SwatchFunc;
	info.opacityFunc = CT_RA_Emergency2_DropDown_OpacityFunc;
	info.cancelFunc = CT_RA_Emergency2_DropDown_CancelFunc;
	info.notCheckable = 1;
	UIDropDownMenu_AddButton(info);


	info = { };
	if ( tempOptions["LockMonitor"] ) then
		info.text = "Unlock Emergency`s";
	else
		info.text = "Lock Emergency`s";
	end
	info.notCheckable = 1;
	info.func = CT_em_DropDown_OnClick;
        UIDropDownMenu_AddButton(info);

	info = { };
	if (Emer2==" ") then
		info.text = "Show Label";
	else
		info.text = "Hide Label";
	end
	info.notCheckable = 1;
	info.func = CT_em_Name_OnClick;
        UIDropDownMenu_AddButton(info);


end

function CT_RA_Emergency2_DropDown_SwatchFunc()
	local tempOptions = CT_RAMenu_Options["temp"];
	local r, g, b = ColorPickerFrame:GetColorRGB();
	if ( not tempOptions["EMBG"] ) then
		tempOptions["EMBG"] = { ["r"] = r, ["g"] = g, ["b"] = b, ["a"] = 0 };
	else
		tempOptions["EMBG"]["r"] = r;
		tempOptions["EMBG"]["g"] = g;
		tempOptions["EMBG"]["b"] = b;
	end
	CT_RA_Emergency2Frame:SetBackdropColor(r, g, b, tempOptions["EMBG"]["a"]);
	CT_RA_Emergency2Frame:SetBackdropBorderColor(1, 1, 1, tempOptions["EMBG"]["a"]);
end

function CT_RA_Emergency2_DropDown_OpacityFunc()
	local tempOptions = CT_RAMenu_Options["temp"];
	local r, g, b = 1, 1, 1;
	if ( tempOptions["EMBG"] ) then
		r, g, b = tempOptions["EMBG"].r, tempOptions["EMBG"].g, tempOptions["EMBG"].b;
	end
	local a = OpacitySliderFrame:GetValue();
	tempOptions["EMBG"]["a"] = a;
	CT_RA_Emergency2Frame:SetBackdropColor(r, g, b, a);
	CT_RA_Emergency2Frame:SetBackdropBorderColor(1, 1, 1, a);
end

function CT_RA_Emergency2_DropDown_CancelFunc(val)
	local tempOptions = CT_RAMenu_Options["temp"];
	tempOptions["EMBG"] = { 
		["r"] = val.r,
		["g"] = val.g,
		["b"] = val.b,
		["a"] = val.opacity
	};
	CT_RA_Emergency2Frame:SetBackdropColor(val.r, val.g, val.b, val.opacity);
	CT_RA_Emergency2Frame:SetBackdropBorderColor(1, 1, 1, val.opacity);
end

function CT_RA_Emergency2_DropDown_OnClick()
	local tempOptions = CT_RAMenu_Options["temp"];
	if ( UIDROPDOWNMENU_MENU_VALUE == "Classes" ) then
		if ( not tempOptions["EM2Classes"] ) then
			tempOptions["EM2Classes"] = { };
		end
		tempOptions["EM2Classes"][this.value] = not tempOptions["EM2Classes"][this.value];
		CT_RA_Emergency2_UpdateHealth();
	elseif ( UIDROPDOWNMENU_MENU_VALUE == "Groups" ) then
		if ( not tempOptions["EM2Groups"] ) then
			tempOptions["EM2Groups"] = { };
		end
		tempOptions["EM2Groups"][this.value] = not tempOptions["EM2Groups"][this.value];
		CT_RA_Emergency2_UpdateHealth();	
	end
end

function CT_RA_Emergency2_ToggleDropDown()
	local left, top = this:GetCenter();
	local uileft, uitop = UIParent:GetCenter();
	if ( left > uileft ) then
		CT_RA_Emergency2FrameDropDown.point = "TOPRIGHT";
		CT_RA_Emergency2FrameDropDown.relativePoint = "BOTTOMLEFT";
	else
		CT_RA_Emergency2FrameDropDown.point = "TOPLEFT";
		CT_RA_Emergency2FrameDropDown.relativePoint = "BOTTOMRIGHT";
	end
	CT_RA_Emergency2FrameDropDown.relativeTo = this:GetName();
	ToggleDropDownMenu(1, nil, CT_RA_Emergency2FrameDropDown);
end


function CT_em_DropDown_OnClick()
	local tempOptions = CT_RAMenu_Options["temp"];
	tempOptions["LockMonitor"] = not tempOptions["LockMonitor"];
end

function CT_em_Name_OnClick()
	if (Emer2==" ") then
		Emer2="Emergency Monitor2";		
	else
		Emer2=" ";
	end
	CT_RA_Emergency2FrameTitle:SetText(Emer2);
end



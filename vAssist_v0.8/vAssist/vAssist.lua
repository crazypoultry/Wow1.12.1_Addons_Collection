VASSIST_MT_NAME = {["vA_MT1"] = nil, ["vA_MT2"] = nil, ["vA_MT3"] = nil, ["vA_MT4"] = nil, ["vA_MT5"] = nil, ["vA_MT6"] = nil}
VASSIST_MT_UNIT = {["vA_MT1"] = nil, ["vA_MT2"] = nil, ["vA_MT3"] = nil, ["vA_MT4"] = nil, ["vA_MT5"] = nil, ["vA_MT6"] = nil}
VASSIST_MT_TYPE = {["vA_MT1"] = nil, ["vA_MT2"] = nil, ["vA_MT3"] = nil, ["vA_MT4"] = nil, ["vA_MT5"] = nil, ["vA_MT6"] = nil}
VASSIST_MTTINFO = {}
for i=1, 6 do
	VASSIST_MTTINFO["vA_MT"..i] = {["NAME"] = nil, ["LEVEL"] = nil, ["ELITE"] = nil, ["HP"] = nil, ["HPMAX"] = nil, ["HPPERC"] = nil, ["TARGET"] = nil}
end


function vAssist_OnLoad()

	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("PARTY_MEMBERS_CHANGED");
	this:RegisterEvent("RAID_ROSTER_UPDATE");
	vAssist_Register_Slash();
	
end


function vAssist_OnEvent()

	if( event ==	"VARIABLES_LOADED" ) then
		VASSIST_USER = UnitName("player").." of "..GetRealmName();
		vAssist_Register_myAddOns();
		vAssist_Print(format(VASSIST_LOADED, VASSIST_USER));
		vAssistConfigDefaults = {
			["display"] = true,
			["mttt"] = false,
			["colors"] = true,
			["border"] = true,
			["scale"] = 1;
			["interval"] = 0.5;
		}
		if( vAssistConfig == nil ) then
			vAssistConfig = {};
		end
		for ind in vAssistConfigDefaults do
			if( vAssistConfig[ind] == nil ) then
				vAssistConfig[ind] = vAssistConfigDefaults[ind];
			end
		end
	end
	if( event == "PARTY_MEMBERS_CHANGED" or event == "RAID_ROSTER_UPDATE" ) then
		local i;
		for i=1, 6 do
			vAssist_UpdateMT(i);
		end
	end
		
end


function vAssist_OnUpdate(arg1)

	if( vAssistConfig.interval ) then
		if( not this.updateTime ) then
			this.updateTime = 0;
		else
			this.updateTime = this.updateTime + arg1;
		end
		if( this.updateTime > vAssistConfig.interval ) then
			local i;
			for i=1,6 do
				vAssist_GetMTTInfo(i);
			end
			this.updateTime = 0;
		end
	end

end


function vAssist_UpdateMTFrame(frame)

	local slot = string.sub(frame,4,6);
	local frName = getglobal(frame);
	vAssist_SetScale(frame);
	if( not frName:IsVisible() ) then
		if( vAssistConfig["display"] and VASSIST_MT_UNIT[frame] ~= nil ) then
			frName:Show();
		end
	else
		if( not vAssistConfig["display"] or VASSIST_MT_UNIT[frame] == nil ) then
			frName:Hide();
		end
	end
	local strMT = getglobal(frame.."MTName");
	local strName = getglobal(frame.."TargetName");
	local strHp = getglobal(frame.."HealthBarText");
	local strTarg = getglobal(frame.."TargetsTarget");
	local barHp = getglobal(frame.."HealthBar");
	local barBG = getglobal(frame.."HealthBarBG");
	barBG:SetVertexColor(1, 0, 0, 0.4);
	if( VASSIST_MTTINFO[frame].NAME ~= nil and VASSIST_MT_UNIT[frame] ~= nil ) then
		strNameText = VASSIST_MTTINFO[frame].NAME;
		if( UnitExists(VASSIST_MT_UNIT[frame].."targettarget") and vAssistConfig["colors"] ) then
			if( VASSIST_MT_NAME[frame] == UnitName(VASSIST_MT_UNIT[frame].."targettarget") ) then
				frName:SetBackdropColor(0.1,0.4,0.1);
			elseif( UnitName(VASSIST_MT_UNIT[frame].."targettarget") == UnitName("player") ) then
				frName:SetBackdropColor(0.6,0.2,0.2);
			else
				frName:SetBackdropColor(0,0,0);
			end
		else
			frName:SetBackdropColor(0,0,0);
		end
	elseif( VASSIST_MT_NAME[frame] ~= nil ) then
		strNameText = format(VASSIST_MTTARGET,VASSIST_MT_NAME[frame]);
		frName:SetBackdropColor(0,0,0);
	else
		strNameText = VASSIST_NOTANK;
		frName:SetBackdropColor(0,0,0);
	end
	if( string.len(strNameText) > 20 ) then
		strName:SetText(string.sub(strNameText,1,18).."...");		
	else
		strName:SetText(strNameText);
	end
	if( VASSIST_MT_NAME[frame] ) then
		strMT:SetText(slot..": "..VASSIST_MT_NAME[frame]);
	else
		strMT:SetText(slot);
	end
	if( VASSIST_MTTINFO[frame].HPPERC ~= nil ) then
		if( not barHp:IsVisible() ) then
			barHp:Show()
		end
		barHp:SetMinMaxValues(0,VASSIST_MTTINFO[frame].HPMAX);
		barHp:SetValue(VASSIST_MTTINFO[frame].HP);
		strHp:SetText(VASSIST_MTTINFO[frame].HPPERC.."%");
	elseif( barHp:IsVisible() ) then
		barHp:Hide();
	end
	if( vAssistConfig["mttt"] ) then
		frName:SetHeight(75);
		strTarg:Show();
		if( VASSIST_MTTINFO[frame].TARGET ~= nil ) then
			if(string.len(VASSIST_MTTINFO[frame].TARGET) > 16 ) then
				strTarg:SetText(VASSIST_TARGET..": "..string.sub(VASSIST_MTTINFO[frame].TARGET,1,14).."...");
			else
				strTarg:SetText(VASSIST_TARGET..": "..VASSIST_MTTINFO[frame].TARGET);
			end
		else
			strTarg:SetText(VASSIST_TARGET..": n/a");
		end
	else
		frName:SetHeight(63);
		strTarg:Hide();
	end
	if( vAssistConfig["border"] ) then
		frName:SetBackdropBorderColor(TOOLTIP_DEFAULT_COLOR.r, TOOLTIP_DEFAULT_COLOR.g, TOOLTIP_DEFAULT_COLOR.b,1);
	else
		frName:SetBackdropBorderColor(TOOLTIP_DEFAULT_COLOR.r, TOOLTIP_DEFAULT_COLOR.g, TOOLTIP_DEFAULT_COLOR.b,0);
	end
			
end


function vAssist_Register_Slash()

	SlashCmdList["VASSIST"] = vAssistSlash;
	SLASH_VASSIST1	=	"/vassist";
	SLASH_VASSIST2	=	"/va";
		
end


function vAssist_Register_myAddOns()

	vAssist_myAddons = {
		name = VASSIST_NAME,
		description = VASSIST_DESC,
		version = VASSIST_VERSION,
		author = "ven",
		email = "m.fasse@gmail.com",
		website = "venlab.de",
		category = MYADDONS_CATEGORY_COMBAT,
		frame = "vAssist"
	};
	
	if(myAddOnsFrame_Register) then
		myAddOnsFrame_Register(vAssist_myAddons);
	end

end


function vAssist_Print(msg)

	DEFAULT_CHAT_FRAME:AddMessage("|cFF44FF33[vAssist]|r " .. msg,0.3,0.7,0.2);

end


function vAssist_Error(msg)

	UIErrorsFrame:AddMessage("[vAssist] "..msg,1,.1,.1,1,UIERRORS_HOLD_TIME)

end


function vAssistSlash(msg)

	if( string.find(msg, " ") ) then
		local index = string.find(msg, " ");
		cmd = string.sub(msg, 1, index-1);
		param = string.sub(msg, index+1);
	else
		cmd = msg;
		param = nil;	
	end
	
	if( cmd == "set" ) then
		
		local slot;
		if( UnitExists("target") and UnitIsFriend("target","player") ) then
			if( vAssist_ValidSlot(param) ) then
				slot = param;	
			else
				slot = 0;
			end
			if( UnitIsPlayer("target") ) then
				vAssist_SetMT(UnitName("target"),"player",slot);
			elseif( vAssist_UnitIsPet("target") ) then
				vAssist_SetMT(UnitName("target"),"pet",slot);
			end
		else
			vAssist_Error(VASSIST_NOTARGET);
		end
					
	elseif( cmd == "unset" and vAssist_ValidSlot(param) ) then
	
		vAssist_UnsetMT(param);
		
	elseif( cmd == "unsetall" ) then
		
		vAssist_UnsetAllMTs();
	
	elseif( cmd == "showinfo" and vAssist_ValidSlot(param) ) then
	
		vAssist_ShowInfoMsg(param);
		
	elseif( cmd == "show" ) then
	
		vAssist_SetCFG("display",true);
		
	elseif( cmd == "scale" ) then
	
		local scale = tonumber(param) / 10;
		if( scale >= 0.1 and scale <= 1.5 ) then
			vAssist_SetCFG("scale", scale);
		end
	
	elseif( cmd == "hide" ) then
	
		vAssist_SetCFG("display",false);
		
	elseif( cmd == "colors" or cmd == "border" or cmd == "mttt" ) then
	
		if( param == "on" ) then
			vAssist_SetCFG(cmd,true);
		elseif( param == "off" ) then
			vAssist_SetCFG(cmd,false);
		end
		
	elseif( cmd == "help" ) then
	
		for index in VASSIST_HELPMSG do
			vAssist_Print(VASSIST_HELPMSG[index]);
		end
		
	elseif( cmd == "interval" ) then
	
		if( tonumber(param) ) then
			vAssist_SetCFG("interval", tonumber(param));
		end
				
	else
	
		local slot;
		if( vAssist_ValidSlot(param) ) then
			slot = param;
		else
			slot = 0;
		end
		vAssist_AssistMT(slot);
	
	end
	
end


function vAssist_SetCFG(ind,val)

	vAssistConfig[ind] = val;
	vAssist_UpdateMTFrames();

end


function vAssist_UnitIsPet(unit)

	if( not UnitIsPlayer(unit) and UnitPlayerControlled(unit) ) then
		return true
	end
	return false

end


function vAssist_ValidSlot(slot)

	if( tonumber(slot) ) then
		slot = tonumber(slot);
		if( (slot >= 1) and (slot <= 6)  ) then
		 return true
		end
	end
	return false
	
end


function vAssist_FreeSlot(slot)
	
	local i;
	for i=1, 6 do
		if( VASSIST_MT_NAME["vA_MT"..i] == nil ) then
			return i;
		end
	end
	return 0;

end


function vAssist_SetMT(name,ctrl,slot)

	if( slot == 0 ) then
		slot = vAssist_FreeSlot(slot);
	end
	if( vAssist_ValidSlot(slot) ) then
		VASSIST_MT_NAME["vA_MT"..slot] = name;
		VASSIST_MT_TYPE["vA_MT"..slot] = ctrl;
		VASSIST_MT_UNIT["vA_MT"..slot] = vAssist_GetUnit(name,ctrl);
		VASSIST_MTTINFO["vA_MT"..slot] = {["NAME"] = nil, ["LEVEL"] = nil, ["ELITE"] = nil, ["HP"] = nil, ["HPMAX"] = nil, ["HPPERC"] = nil, ["TARGET"] = nil};
		vAssist_Print(format(VASSIST_MTSET, name));
		if(not VASSIST_MT_UNIT["vA_MT"..slot]) then
			vAssist_Print(format(VASSIST_MTNOGROUP, VASSIST_MT_NAME["vA_MT"..slot]).." "..VASSIST_MTNOINFO);
		end
		vAssist_UpdateMTFrames();
	end
	
end


function vAssist_UnsetMT(slot)

	VASSIST_MT_NAME["vA_MT"..slot] = nil;
	VASSIST_MT_UNIT["vA_MT"..slot] = nil;
	vAssist_UpdateMTFrames();

end


function vAssist_UnsetAllMTs()

	VASSIST_MT_NAME = {["vA_MT1"] = nil, ["vA_MT2"] = nil, ["vA_MT3"] = nil, ["vA_MT4"] = nil, ["vA_MT5"] = nil, ["vA_MT6"] = nil}
	VASSIST_MT_UNIT = {["vA_MT1"] = nil, ["vA_MT2"] = nil, ["vA_MT3"] = nil, ["vA_MT4"] = nil, ["vA_MT5"] = nil, ["vA_MT6"] = nil}
	VASSIST_MT_TYPE = {["vA_MT1"] = nil, ["vA_MT2"] = nil, ["vA_MT3"] = nil, ["vA_MT4"] = nil, ["vA_MT5"] = nil, ["vA_MT6"] = nil}
	vAssist_Print(VASSIST_NOTANK);
	vAssist_UpdateMTFrames();

end


function vAssist_UpdateMT(slot)

	if( VASSIST_MT_NAME["vA_MT"..slot] ~= nil ) then
		VASSIST_MT_UNIT["vA_MT"..slot] = vAssist_GetUnit(VASSIST_MT_NAME["vA_MT"..slot], VASSIST_MT_TYPE["vA_MT"..slot]);
	end
	vAssist_UpdateMTFrame("vA_MT"..slot);
	
end


function vAssist_ValidName(name)
	
	return string.upper(string.sub(name,1,1)) .. string.lower(string.sub(name,2));
	
end


function vAssist_GetUnit(name,ctrl)

	local numParty = GetNumPartyMembers();
	local numRaid = GetNumRaidMembers();
	if( name == UnitName((ctrl == "pet" and "pet" or "player")) ) then
		return (ctrl == "pet" and "pet" or "player");
	end
	if( numParty > 0 ) then
		for i=1, numParty do
			if( name == UnitName("party"..(ctrl == "pet" and "pet" or "")..i) ) then
				return "party"..(ctrl == "pet" and "pet" or "")..i;
			end
		end
	end
	if( numRaid > 0 ) then
		for i=1, numRaid do
			if( name == UnitName("raid"..(ctrl == "pet" and "pet" or "")..i) ) then
				return "raid"..(ctrl == "pet" and "pet" or "")..i;
			end
		end
	end
	return nil;

end


function vAssist_GetMTTInfo(slot)
	
	if( UnitExists(VASSIST_MT_UNIT["vA_MT"..slot]) ) then
		local VASSIST_MT_TARGET = VASSIST_MT_UNIT["vA_MT"..slot].."target";
		if( UnitExists(VASSIST_MT_TARGET) ) then
			VASSIST_MTTINFO["vA_MT"..slot] = {
				["NAME"] = UnitName(VASSIST_MT_TARGET),
				["LEVEL"] = UnitLevel(VASSIST_MT_TARGET),
				["ELITE"] = UnitIsPlusMob(VASSIST_MT_TARGET),
				["HP"] = UnitHealth(VASSIST_MT_TARGET),
				["HPMAX"] = UnitHealthMax(VASSIST_MT_TARGET),
				["HPPERC"] = ceil((UnitHealth(VASSIST_MT_TARGET) / UnitHealthMax(VASSIST_MT_TARGET)) * 100)
			};
			if( UnitExists(VASSIST_MT_TARGET.."target") ) then
				VASSIST_MTTINFO["vA_MT"..slot].TARGET = UnitName(VASSIST_MT_TARGET.."target");
			else
				VASSIST_MTTINFO["vA_MT"..slot].TARGET = nil;
			end
		else
			VASSIST_MTTINFO["vA_MT"..slot] = {["NAME"] = nil, ["LEVEL"] = nil, ["ELITE"] = nil, ["HP"] = nil, ["HPMAX"] = nil, ["HPPERC"] = nil, ["TARGET"] = nil};
		end
	end

end


function vAssist_GetValidMT()

	local i;
	local q = {[1] = 0, [2] = 0, [3] = 0, [4] = 0, [5] = 0, [6] = 0};
	local g = 1;
	for i=1, 6 do
		if( VASSIST_MT_NAME["vA_MT"..i] ~= nil ) then
			q[i] = q[i] + 1;
		end
		if( VASSIST_MT_UNIT["vA_MT"..i] ~= nil ) then
			q[i] = q[i] + 1;
		end
		if( VASSIST_MTTINFO["vA_MT"..i].HPPERC ~= nil ) then
			q[i] = q[i] + (10 - (VASSIST_MTTINFO["vA_MT"..i].HPPERC / 10));
		end
	end
	for i=2,6 do
		if(q[i] > q[g]) then
			g=i;
		end
	end
	return g;

end


function vAssist_ShowInfoMsg(slot)

	if( VASSIST_MTTINFO["vA_MT"..slot].NAME ~= nil ) then
		vAssist_Print(format(VASSIST_MTTINFOMSG, VASSIST_MT_NAME["vA_MT"..slot], VASSIST_MTTINFO["vA_MT"..slot].LEVEL..(VASSIST_MTTINFO["vA_MT"..slot].ELITE and "+"), VASSIST_MTTINFO["vA_MT"..slot].NAME, VASSIST_MTTINFO["vA_MT"..slot].HPPERC));
	else
		vAssist_Print(VASSIST_NOTARGET);
	end

end


function vAssist_UpdateMTFrames()

	vAssist_UpdateMTFrame("vA_MT1");
	vAssist_UpdateMTFrame("vA_MT2");
	vAssist_UpdateMTFrame("vA_MT3");
	vAssist_UpdateMTFrame("vA_MT4");
	vAssist_UpdateMTFrame("vA_MT5");
	vAssist_UpdateMTFrame("vA_MT6");

end


function vAssist_AssistMT(slot)

	if( slot == 0 ) then
		slot = vAssist_GetValidMT();
	end
	if( VASSIST_MT_UNIT["vA_MT"..slot] ~= nil ) then
		AssistUnit(VASSIST_MT_UNIT["vA_MT"..slot]);
	elseif( VASSIST_MT_NAME["vA_MT"..slot] ) then		
		AssistByName(VASSIST_MT_NAME["vA_MT"..slot]);
	end

end


function vAssist_TargetMTTT()
	
	if( VASSIST_MT_UNIT["vA_MT"..slot] ~= nil and UnitExists(VASSIST_MT_UNIT["vA_MT"..slot].."targettarget") ) then
		TargetUnit(VASSIST_MT_UNIT["vA_MT"..slot].."targettarget");
	end
	
end


function vAssist_SetScale(frame)

	if( vAssistConfig["scale"] ~= nil ) then
		local frName = getglobal(frame);
		frName:SetScale(1 - UIParent:GetEffectiveScale() + vAssistConfig["scale"]);
	end

end
-- JustClick 1.2.4
-- Click on a unit frame with any mouse/key combos defined as key binding to trigger the associated action
-- Created by Soin (EU-Vol'jin) on May 17, 2006

--[[

*** Developers Note ***

Feel free to add JustClick support to your AddOn, it's really simple,
just call the JC_CatchKeyBinding(button, unit) from your OnClick
function. This function returns true in case a mouse/key binding is
caught. Have a look to the JC_OnClick function for a sample.

--]]

JC_hooks = { };

function JC_Init()	
	-- Hook RaidFrame_LoadUI
	JC_SavedRaidFrame_LoadUI = RaidFrame_LoadUI;
	RaidFrame_LoadUI = JC_RaidFrame_LoadUI;
	
	-- Hook KeyBindingFrame_LoadUI
	JC_SavedKeyBindingFrame_LoadUI = KeyBindingFrame_LoadUI;
	KeyBindingFrame_LoadUI = JC_KeyBindingFrame_LoadUI;

	-- Hook UseAction to handle selfcast
	JC_SavedUseAction = UseAction;
	UseAction = JC_UseAction;

	-- Unit Frames hooking
	JC_RegisterUnitFrame("PlayerFrame");	
	JC_Hook("PlayerFrame_OnClick", "player");

	JC_RegisterUnitFrame("PetFrame");
	JC_Hook("PetFrame_OnClick", "pet");

	JC_RegisterUnitFrame("TargetFrame");	
	JC_Hook("TargetFrame_OnClick", "target");

	JC_RegisterUnitFrame("TargetofTargetFrame");	
	JC_Hook("TargetofTarget_OnClick", "targettarget");

	JC_RegisterUnitFrame("PartyMemberFrame%d");
	JC_Hook("PartyMemberFrame_OnClick", function (frame) return "party"..frame:GetID() end);

	JC_RegisterUnitFrame("PartyMemberFrame%dPetFrame");
	JC_Hook("PartyMemberPetFrame_OnClick", function (frame) return "partypet"..frame:GetParent():GetID() end);

	if ( IsAddOnLoaded("EasyRaid") and ER_VERSION_NUMBER < 020101) then
		JC_RegisterUnitFrame("ER_TargetsFrameButton%d+ClearButton");
		JC_Hook("ER_TargetButtonOnClick", function (frame) return frame:GetParent().unit end);
	end

	if ( IsAddOnLoaded("CT_UnitFrames") ) then
		JC_RegisterUnitFrame("CT_AssistFrame");
		JC_Hook("CT_AssistFrame_OnClick", "targettarget");
	end

	if ( IsAddOnLoaded("CT_RaidAssist") ) then
		CT_RA_CustomOnClickFunction = function (button, unit) return JC_CatchKeyBinding(button, unit); end
		JC_RegisterUnitFrame("CT_RAMember%d+CastFrame", "Down");
		JC_RegisterUnitFrame("CT_RAMTGroupMember%d+CastFrame", "Down");
		JC_Hook("CT_RA_MemberFrame_OnClick", JC_CTRA_UnitHandler);

		JC_RegisterUnitFrame("CT_RAMTGroupMember%d+MTTTCastFrame", "Down");
		JC_Hook("CT_RA_AssistMTTT", function (frame) return frame.id end);
	end
	
	if ( IsAddOnLoaded("PerfectRaid") ) then
		PerfectRaidCustomClick = JC_OnClick;
	end

	if ( IsAddOnLoaded("XRaid") ) then
		JC_RegisterUnitFrame("XRaid%d+_StatsFrame_CastClickOverlay", "Up", "OnMouseUp", nil);
		XRaid.OnClick = XRaid.MouseUp;
		JC_Hook("XRaid.OnClick", JC_XRaid_UnitHandler);
	end

	if ( IsAddOnLoaded("DiscordUnitFrames") ) then
		JC_RegisterUnitFrame("DUF_PlayerFrame.*");
		JC_RegisterUnitFrame("DUF_PetFrame.*");	
		JC_RegisterUnitFrame("DUF_TargetFrame.*");	
		JC_RegisterUnitFrame("DUF_TargetOfTargetFrame.*");	
		JC_RegisterUnitFrame("DUF_PartyFrame%d.*");
		JC_RegisterUnitFrame("DUF_PartyPetFrame%d.*");
		JC_Hook("DUF_UnitFrame_OnClick", function (frame) return frame.unit end);
		JC_Hook("DUF_Element_OnClick", function (frame) return frame.unit or frame:GetParent().unit end);
	end

	if ( IsAddOnLoaded("Sage") ) then
		JC_Hook("SUnit_OnClick", function (frame) return SUnit_GetUnit(frame) end);
	end
	
	-- Perl Classic Unit Frames support
	if ( IsAddOnLoaded("Perl_Player") ) then
		JC_Hook("Perl_Player_MouseClick", "player");
	end
	if ( IsAddOnLoaded("Perl_Player_Pet") ) then
		JC_Hook("Perl_Player_Pet_MouseClick", "pet");
	end
	if ( IsAddOnLoaded("Perl_Target") ) then
		JC_Hook("Perl_Target_MouseClick", "target");
	end
	if ( IsAddOnLoaded("Perl_Target_Target") ) then
		JC_Hook("Perl_Target_Target_MouseClick", "targettarget");
		JC_Hook("Perl_Target_Target_Target_MouseClick", "targettargettarget");
	end
	if ( IsAddOnLoaded("Perl_Party") ) then
		JC_Hook("Perl_Party_MouseClick", function (frame) local id = frame:GetID();
			if ( id == 0 ) then id = string.sub(frame:GetName(), 23, 23); end; return "party"..id; end);
		JC_Hook("Perl_Party_Pet_MouseClick", function (frame) local id = frame:GetID();
			if ( id == 0 ) then id = string.sub(frame:GetName(), 23, 23); end; return "partypet"..id; end);
	end
	if ( IsAddOnLoaded("Perl_Raid") ) then
		JC_Hook("Perl_Raid_MouseClick", function (frame) return "raid"..frame:GetID() end);
	end
	if ( IsAddOnLoaded("Perl_CombatDisplay") ) then
		JC_Hook("Perl_CombatDisplay_MouseClick", "player");
		JC_Hook("Perl_CombatDisplay_Target_MouseClick", "target");
	end
	
	-- Nymbia's Perl Unitframes support
	-- Not sure it works since Nymbia's click management is really ugly!
	if ( IsAddOnLoaded("Perl") ) then
		JC_Hook("Perl_Player_OnClick", "player");
		JC_Hook("Perl_Player_Pet_MouseUp", "pet");
		JC_Hook("Perl_Target_MouseUp", "target");
		JC_Hook("Perl_TargetTarget_MouseUp", "targettarget");
		JC_Hook("Perl_Party_OnClick", function (frame) return "party"..Perl_Party_FindID(frame) end);
		JC_Hook("Perl_Party_Pet_MouseUp", function (frame) return "partypet"..Perl_Party_Pet_FindID(frame) end);
		JC_Hook("Perl_Raid_MouseUp", function (frame) return "raid"..Perl_Raid_FindID(frame) end);
	end
	
	DEFAULT_CHAT_FRAME:AddMessage(JC_VERSION_STRING.." loaded.", 1, 1, 1);
end

function JC_RaidFrame_LoadUI()
	JC_SavedRaidFrame_LoadUI();
	if ( not JC_RaidFrameHasBeenLoaded ) then
		if ( (IsAddOnLoaded("EasyRaid") and ER_VERSION_NUMBER < 020101) or not IsAddOnLoaded("EasyRaid") ) then
			JC_RegisterUnitFrame("RaidPullout%d+Button%d+ClearButton");
			JC_Hook("RaidPulloutButton_OnClick", function (frame) return frame.unit end);
		end
		JC_RaidFrameHasBeenLoaded = true;
	end
end

-----------------------------------------------------------------------

function JC_Hook(onClickFunctionName, unitHandler)
	local obj, func;

	if ( onClickFunctionName ) then
		_, _, obj, func = string.find(onClickFunctionName, "^(.+)%.(.+)$");
		if ( not obj ) then
			if ( not getglobal(onClickFunctionName) ) then
				JC_Error('"'..onClickFunctionName..'"'.." function doesn't exist");
				return;
			end
		else
			if ( not getglobal(obj)[func] ) then
				JC_Error('"'..onClickFunctionName..'"'.." function doesn't exist");
				return;
			end
		end
	else
		message("onClickFunctionName parameter can't be nil");
		return;
	end

	if ( JC_hooks[onClickFunctionName] ) then
		message('"'..onClickFunctionName..'"'.." hook can't be defined twice");
		return;
	end
	
	if ( not unitHandler ) then
		message("unitHandler parameter can't be nil");
		return;
	end

	if ( not (type(unitHandler) == "string" or type(unitHandler) == "function") ) then
		message("unitHandler parameter must be a string or a function");
		return;
	end

	JC_hooks[onClickFunctionName] = { };

	if ( not obj ) then
		local newFunctionName = "JC_"..onClickFunctionName;
		JC_hooks[onClickFunctionName].savedOnClickFunction = getglobal(onClickFunctionName);
		RunScript('function '..newFunctionName..'(button) '..
				'if ( not JC_CatchKeyBinding(button, JC_GetUnit("'..onClickFunctionName..'")) ) then '..
					'JC_hooks["'..onClickFunctionName..'"].savedOnClickFunction(button) '..
				'end '..
			'end');
		setglobal(onClickFunctionName, getglobal(newFunctionName));
	else
		local newFunctionName = "JC_"..obj.."_"..func;
		JC_hooks[onClickFunctionName].savedOnClickFunction = getglobal(obj)[func];
		RunScript('function '..newFunctionName..'(self, button) '..
				'if ( not JC_CatchKeyBinding(button, JC_GetUnit("'..onClickFunctionName..'")) ) then '..
					'JC_hooks["'..onClickFunctionName..'"].savedOnClickFunction(XRaid, button) '..
				'end '..
			'end');
		getglobal(obj)[func] = getglobal(newFunctionName);
	end

	JC_hooks[onClickFunctionName].unitHandler = unitHandler;
end

function JC_GetUnit(onClickFunctionName, frame)
	local unit;

	local unitHandler = JC_hooks[onClickFunctionName].unitHandler;
	if ( type(unitHandler) == "string" ) then
		unit = unitHandler;
	elseif ( type(unitHandler) == "function" ) then
		if ( not frame ) then
			frame = this;
		end
		if ( frame ) then
			-- JC_Debug(frame:GetName());
			unit = unitHandler(frame);
		end
	end
	
	return unit;
end

function JC_RegisterUnitFrame(framePattern, buttonState, scriptHandler, scriptFunction)
	if ( not framePattern ) then
		message("framePattern parameter can't be nil");
		return;
	end

	framePattern = "^("..framePattern..")$";

	if ( not buttonState ) then
		buttonState = "Up";
	end
	
	local frame, frameName;
	repeat
		frame = EnumerateFrames(frame);
		if ( frame ) then
			frameName = frame:GetName();
			if ( frameName and string.find(frameName, framePattern) and frame:GetFrameType() == "Button" ) then
				frame:RegisterForClicks("LeftButton"..buttonState, "RightButton"..buttonState,
					"MiddleButton"..buttonState, "Button4"..buttonState, "Button5"..buttonState);
				if ( scriptHandler ) then
					frame:SetScript(scriptHandler, scriptFunction);
				end
			end
		end
	until not frame;
end

function JC_TargetUnitBegin(unit)
	JC_isTargeting = true;
	JC_targetedName = nil;
	JC_targetHasChanged = false;
	if ( unit ) then
		if ( not UnitIsUnit(unit, "target") ) then
			if ( UnitExists(unit) ) then
				if ( SpellIsTargeting() ) then
					SpellStopTargeting();
				end
				TargetUnit(unit);
				JC_targetedName = UnitName("target");
				JC_targetHasChanged = true;
			else
				if ( UnitExists("target") ) then
					ClearTarget();
					JC_targetHasChanged = true;
				end
			end
		end
	end
end

function JC_TargetUnitEnd()
	if ( SpellIsTargeting() ) then
		SpellStopTargeting();
	end
	if ( JC_targetHasChanged and UnitName("target") == JC_targetedName ) then
		TargetLastTarget();
	end
	JC_isTargeting = false;
end

function JC_CatchKeyBinding(button, unit)
	if ( (not button) or type(button) ~= "string") then
		button = arg1;
	end

	-- Convert the mouse button names
	if ( button == "LeftButton" ) then
		button = "BUTTON1";
	elseif ( button == "RightButton" ) then
		button = "BUTTON2";
	elseif ( button == "MiddleButton" ) then
		button = "BUTTON3";
	elseif ( button == "Button4" ) then
		button = "BUTTON4"
	elseif ( button == "Button5" ) then
		button = "BUTTON5"
	end
	
	if ( IsShiftKeyDown() ) then
		button = "SHIFT-"..button;
	end
	if ( IsControlKeyDown() ) then
		button = "CTRL-"..button;
	end
	if ( IsAltKeyDown() ) then
		button = "ALT-"..button;
	end	
	
	if ( not (button == "BUTTON1" or button == "BUTTON2") ) then
		local action = GetBindingAction(button);
		if ( action and action ~= "" ) then
			local _, _, id = string.find(action, "^ACTIONBUTTON(%d+)");
			if ( id ) then
				JC_TargetUnitBegin(unit);
				ActionButtonDown(id);
				ActionButtonUp(id);
				JC_TargetUnitEnd();
				return true;
			end
			
			local _, _, id = string.find(action, "^BONUSACTIONBUTTON(%d+)");
			if ( id ) then
				JC_TargetUnitBegin(unit);
				BonusActionButtonDown(id);
				BonusActionButtonUp(id);
				JC_TargetUnitEnd();
				return true;
			end

			local _, _, bar, id = string.find(action, "^MULTIACTIONBAR(%d)BUTTON(%d+)");
			if ( bar and id ) then
				if ( bar == "1" ) then
					bar = "MultiBarBottomLeft";
				elseif ( bar == "2" ) then
					bar = "MultiBarBottomRight";
				elseif ( bar == "3" ) then
					bar = "MultiBarRight";
				elseif ( bar == "4" ) then
					bar = "MultiBarLeft";
				end
				JC_TargetUnitBegin(unit);
				MultiActionButtonDown(bar, id);
				MultiActionButtonUp(bar, id);
				JC_TargetUnitEnd();
				return true;
			end

			-- Bongos support
			if ( IsAddOnLoaded("Bongos") ) then
				local _, _, id = string.find(action, "^ActionButton(%d+)");
				if ( id ) then
					JC_TargetUnitBegin(unit);
					ActionButtonDown(id);
					ActionButtonUp(id);
					JC_TargetUnitEnd();
					return true;
				end
			end

			-- FlexBar support
			if ( IsAddOnLoaded("FlexBar") ) then
				local _, _, id = string.find(action, "^FLEXACTIONBUTTON(%d+)");
				if ( id ) then
					JC_TargetUnitBegin(unit);
					FB_FlexActionButtonBindingCode(tonumber(id), "down")
					FB_FlexActionButtonBindingCode(tonumber(id), "up")
					JC_TargetUnitEnd();
					return true;
				end
			end

			-- DiscordActionBars support
			if ( IsAddOnLoaded("DiscordActionBars") ) then
				local _, _, id = string.find(action, "^DAB_(%d+)");
				if ( id ) then
					JC_TargetUnitBegin(unit);
					DAB_KeybindingDown(tonumber(id))
					DAB_KeybindingUp(tonumber(id))
					JC_TargetUnitEnd();
					return true;
				end
			end

			-- BottomBar support
			if ( IsAddOnLoaded("BottomBar") ) then
				local _, _, id = string.find(action, "^BOTTOMACTIONBUTTON(%d+)");
				if ( id ) then
					JC_TargetUnitBegin(unit);
					BottomBarButtonDown(tonumber(id));
					BottomBarButtonUp(tonumber(id));
					JC_TargetUnitEnd();
					return true;
				end
			end

			-- SideBar support
			if ( IsAddOnLoaded("SideBar") ) then
				local _, _, id = string.find(action, "^SIDEACTIONBUTTON(%d+)");
				if ( id ) then
					JC_TargetUnitBegin(unit);
					SideBarButtonDown(tonumber(id));
					SideBarButtonUp(tonumber(id));
					JC_TargetUnitEnd();
					return true;
				end
			end
			
			if ( action ~= "CAMERAORSELECTORMOVESTICKY" ) then
				JC_TargetUnitBegin(unit);
				RunBinding(action);
				JC_TargetUnitEnd();
				return true;
			end
		end
	end
	
	return false;
end

function JC_OnClick(button, unit)
	if ( not JC_CatchKeyBinding(button, unit) ) then
		if ( not UnitExists(unit) ) then
			return;
		end

		if ( SpellIsTargeting() ) then
			if ( button == "LeftButton" ) then
				SpellTargetUnit(unit);
			elseif ( button == "RightButton" ) then
				SpellStopTargeting();
			end
			return;
		end
	
		if ( CursorHasItem() ) then
			if ( button == "LeftButton" ) then
				if ( UnitIsUnit(unit, "player") ) then
					AutoEquipCursorItem();
				else
					DropItemOnUnit(unit);
				end
			else
				PutItemInBackpack();
			end
			return;
		end
		
		TargetUnit(unit);
	end
end

function JC_UseAction(slot, checkCursor, onSelf)
	local savedOnSelf = onSelf;
	
	if ( arg1 == "RightButton" and not JC_isTargeting ) then
		onSelf = 1;
	end

	if ( onSelf == 1 and not savedOnSelf ) then
		JC_TargetUnitBegin("player"); -- Turn around for bugged action (Bandage)
		JC_SavedUseAction(slot, checkCursor, onSelf);
		JC_TargetUnitEnd();
	else
		JC_SavedUseAction(slot, checkCursor, onSelf);
	end
end

-----------------------------------------------------------------------

function JC_KeyBindingFrame_LoadUI()
	JC_SavedKeyBindingFrame_LoadUI();

	if ( not JC_KeyBindingFrameHasBeenLoaded ) then
		-- Hook KeyBindingButton_OnClick
		JC_SavedKeyBindingButton_OnClick = KeyBindingButton_OnClick;
		KeyBindingButton_OnClick = JC_KeyBindingButton_OnClick;
		
		JC_KeyBindingFrameHasBeenLoaded = true;
	end
end

function JC_KeyBindingButton_OnClick(button)
	if ( KeyBindingFrame.selected ) then
		if ( button == "LeftButton" or button == "RightButton" ) then
			if ( IsShiftKeyDown() or IsControlKeyDown() or IsAltKeyDown() ) then
				if (KeyBindingFrame.buttonPressed == this) then
					if ( button == "LeftButton" ) then
						arg1 = "BUTTON1";
					elseif ( button == "RightButton" ) then
						arg1 = "BUTTON2";
					end
					button = nil;
				end
			end
		end
	end

	JC_SavedKeyBindingButton_OnClick(button);
end

-----------------------------------------------------------------------

function JC_Debug(message)
	DEFAULT_CHAT_FRAME:AddMessage(message, 0, 1, 0);
end

function JC_Error(message)
	DEFAULT_CHAT_FRAME:AddMessage(message, 1, 0, 0);
end

function JC_Dump(expression)
	SlashCmdList["DEVTOOLSDUMP"](expression);
end

-----------------------------------------------------------------------

function JC_CTRA_UnitHandler(frame)
	local parent = frame.frameParent;
	local id = parent.id;
	if ( strsub(parent.name, 1, 12) == "CT_RAMTGroup" ) then
		local unit = JC_GetRaidUnitByName(CT_RA_MainTanks[id]);
		if ( unit ) then
			return unit.."target";
		end
	elseif ( strsub(parent.name, 1, 12) == "CT_RAPTGroup" ) then
		return JC_GetRaidUnitByName(CT_RA_PTargets[id]);
	else
		return "raid"..id;
	end
end

function JC_GetRaidUnitByName(name)
	local i;
	for i = 1, GetNumRaidMembers() do
		local unit = "raid"..i;
		if (UnitName(unit) == name) then
			return unit, i;
		end
	end
end

function JC_XRaid_UnitHandler(frame)
	local id = frame:GetID();
	local unit;
	if ( id <= 40 ) then
		unit = ("raid"..id);
	else
	   local mtframe = getglobal("XRaidMenu"..id-40);
	   local mttframe = getglobal("XRaidMenu"..id-50);
		if ( mtframe and mtframe.mt ) then          
		  unit = ("raid"..mtframe.mt.."target");
		elseif ( mttframe and mttframe.mt ) then
		  unit = ("raid"..mttframe.mt.."targettarget");
		elseif ( mtframe and not ("raid"..mtframe.mt.."target") ) then
		  unit = ("raid"..id-40);
		end
	end
	return unit;
end
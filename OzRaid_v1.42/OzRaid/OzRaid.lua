
local function ggf(String, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
	return getglobal(string.format(String, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9))
end







OZ_Initialised = nil
OZ_UpdateTimer = 0
OZ_UpdatePause = 0.2
local roster = 0

function OzRaid_OnUpdate()
	local i
	if(OZ_Initialised) then
		local _CurrentTime = GetTime()
		if (_CurrentTime >= OZ_UpdateTimer) then
			OZ_UpdateTimer = (_CurrentTime + OZ_UpdatePause)

			if(OzRaidOptions:IsVisible())then
				OZ_OptionsSetConfigFromOptions()
			end

			roster = roster + 1
			if(roster > 15)then
				roster = 0
				OZ_UpdateRoster()
				if(OZ_Config[1].hideparty)then
					HidePartyFrame()
				else
					ShowPartyFrame()
				end
			end

 		end

		-- Now update windows
		for i=1,OZ_NWINDOWS do
			OzRaid_Update(i)
		end
	end
end

function OzRaid_Update(n)
	local _CurrentTime = GetTime()
	local config = OZ_Config[n]
	if(config.active)then
		local window = OZ_GetWindowArray(n)
		local frame = window.frame
		if(frame.tNext < _CurrentTime)then
			-- Check for hide on solo
			if( ((config.hideSolo)and(OZ_RaidRoster.solo)) or
				((config.hideParty)and(OZ_RaidRoster.inParty)) )then
				if( frame:IsVisible() )then
						frame:Hide()
				end
			else
				if(not frame.moving)then
					OZ_ProcessBars(n)
					OZ_SetBars(n)
					OZ_CheckVisibility(n)
				end
			end
			frame.tNext = _CurrentTime + config.refresh
		end
	end
end

-- This function ensure health/mana is updated as frequently as the fastest window
-- but no faster than 5 times a second
local LastUnitUpdate = 0
function OzRaid_UpdateUnitData()
	local _CurrentTime = GetTime()
	local i
	if( _CurrentTime > LastUnitUpdate + 0.2)then
--DEFAULT_CHAT_FRAME:AddMessage("|c0033CCFF".."Updating Units");
		for i=1,OZ_RaidRoster.nMembers do
			OZ_SetExtraMemberData(i)
		end
		LastUnitUpdate = _CurrentTime
	end
end

local LastTargetUpdate = 0
function OzRaid_UpdateTargetData()
	local _CurrentTime = GetTime()
	local i
	if( _CurrentTime > LastTargetUpdate + 0.2)then
--DEFAULT_CHAT_FRAME:AddMessage("|c0033CCFF".."Updating Targets");
		OZ_UpdateTargets()
		LastTargetUpdate = _CurrentTime
	end
end

function OzRaidFormEvent(arg1)
	if(event == "RAID_ROSTER_UPDATE")then
		OZ_UpdateRoster()
    elseif(event == "VARIABLES_LOADED") then
		OzRaidLoadSavedVariables(OzRaid_Frame1);
    end

end


function OzRaid_OnEvent(event)
end

function OZ_Button_OnLeave()
-- TODO: clear tooltip
end

function OZ_Button_OnEnter(name)
-- TODO: Set tooltip
end

function OZ_Button_Close(frame)
	local id = frame:GetParent():GetParent():GetID()
	OZ_Config[id].active = nil
	OZ_Windows[id].frame:Hide()
	if(id == OZ_OptionsCurrentWindow)then
		OZ_OptionsSetOptionsFromConfig(id)
	end
end

function OZ_Button_Options(frame)
	-- Need to get the frame name...
	local id = frame:GetParent():GetParent():GetID()
	OZ_OptionsSetOptionsFromConfig(id)
	-- Bung a hide in - this refreshes the dropdowns ;)
	OzRaidOptions:Hide()
	OzRaidOptions:Show()
end

function OZ_Button_BuffClick(frame)
-- TODO: Handle the click
end


function DumpHierarchy(src, q, depth)
--DEFAULT_CHAT_FRAME:AddMessage("Dumping Depth "..q);
--	if (src and (q>0) and src:IsShown()) then
	local i
	if (src and (q>0)) then
		local a="";
		if(depth) then
			for i=0,depth do
				a = a.."   "
			end
		else
			depth = 0
		end
		if (src:GetName()) then
			a = a..src:GetName();
		end
		if (src:GetObjectType()) then
			local x,y,w,h;
			x = src:GetLeft();
			if (not x) then
				x=0;
			end
			y = src:GetTop();
			if (not y) then
				y=0;
			end
			w = src:GetWidth();
			if (not y) then
				y=0;
			end
			h = src:GetHeight();
			if (not y) then
				y=0;
			end

			a = a..format(":  x=%.2f, y=%.2f, w=%.2f, h=%.2f",x,y,w,h);
		end

		DEFAULT_CHAT_FRAME:AddMessage(a);

		if (src:IsObjectType("Frame")) then
			local kids = { src:GetChildren() };
			for _,child in ipairs(kids) do
				DumpHierarchy(child, q-1, depth+1);
			end
			local kids2 = { src:GetRegions() };
			for _,child in ipairs(kids2) do
				DumpHierarchy(child, q-1, depth+1);
			end
		end

	end
end

function OZ_Button_BarClick(frame)
	DEFAULT_CHAT_FRAME:AddMessage("Bar pressed: "..frame:GetName());

end

function OZ_ToggleWindow( n )
	local window = "OzRaid_Frame"..n
	local wObj = getglobal(window)
	if(wObj)then
		local i = wObj:GetID()
		if(OZ_Config[i].active)then
			wObj:Hide()
			OZ_Config[i].active = nil
		else
			wObj:Show()
			OZ_Config[i].active = 1
		end
	else
		OZ_OptionsSetOptionsFromConfig(1)
		OzRaidOptions:Show()
	end
end

function OzTarget( window, bar )
	if(not window)then
		DEFAULT_CHAT_FRAME:AddMessage("|c0033CCFF".."OzRaid: Error, no window ID!\nUsage: /oztarget <window ID> <bar number>");
		return
	end
	if(not bar)then
		DEFAULT_CHAT_FRAME:AddMessage("|c0033CCFF".."OzRaid: Error, no bar ID!\nUsage: /oztarget <window ID> <bar number>");
		return
	end
	local wName = "OzRaid_Frame"..window
	local wObj = getglobal(wName)
	local i
	if(not wObj)then
		-- Hmm, try finding the window by name
		for i=1,OZ_NWINDOWS do
			if( window == OZ_Config[i].text )then
				wObj = OZ_Windows[i].frame
				wName = wObj:GetName()
				break
			end
		end
		if(not wObj)then
			DEFAULT_CHAT_FRAME:AddMessage("|c0033CCFF".."OzRaid: Error, cannot find window with id/name '"..window.."'!");
			return
		end
	end

	local barName = wName.."TableRow"..bar.."BarFrame"
	local barObj = getglobal(barName)
	if(not barObj)then
		DEFAULT_CHAT_FRAME:AddMessage("|c0033CCFF".."OzRaid: Error, cannot find bar with id '"..bar.."'!");
		return
	end
	if(barObj.unit)then
		TargetUnit(barObj.unit)
		return true
	else
		DEFAULT_CHAT_FRAME:AddMessage("|c0033CCFF".."OzRaid: Error, No unit info on bar!");
	end
end
function OZ_ClickBar(unit,button)
--DEFAULT_CHAT_FRAME:AddMessage("|c0033CCFF".."Click received: "..button);
	if(unit)then
		-- Allow a custom click function 'OzRaidCustomClick'
		if OzRaidCustomClick and OzRaidCustomClick(button, unit) then
		  return
		end

		-- 'JustClick' 
		if( JC_CatchKeyBinding ) then
			if ( JC_CatchKeyBinding(button, unit) ) then
				return;
			end
		end
		-- 'ClickHeal'
		if( CH_UnitClicked )then
			if ( CH_UnitClicked(unit, button) ) then
				return;
			end
		end

		if ( SpellIsTargeting() ) then
			if ( not SpellCanTargetUnit(unit) ) then
				SetCursor("CAST_ERROR_CURSOR");
			else
				if ( button == "LeftButton" ) then
					SpellTargetUnit(unit);
				elseif ( button == "RightButton" ) then
					SpellStopTargeting();
				end
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
		if( button == "RightButton" )then
--DEFAULT_CHAT_FRAME:AddMessage("|c0033CCFF".."Click received: "..button);
			ToggleDropDownMenu(1, nil, TargetFrameDropDown, this:GetName(), 0, 10);
		end
	end
end

SLASH_OZRAID1 = "/ozraid";
SLASH_OZRAID2 = "/oz"; -- A shortcut or alias

SlashCmdList["OZRAID"] = OZ_ToggleWindow;

BINDING_HEADER_OZRAID	= "OzRaid Keys"
BINDING_NAME_WINDOW1	= "Toggle OzRaid 1"
BINDING_NAME_WINDOW2	= "Toggle OzRaid 2"
BINDING_NAME_WINDOW3	= "Toggle OzRaid 3"
BINDING_NAME_WINDOW4	= "Toggle OzRaid 4"
BINDING_NAME_WINDOW5	= "Toggle OzRaid 5"
BINDING_NAME_WINDOW6	= "Toggle OzRaid 6"
BINDING_NAME_WINDOW7	= "Toggle OzRaid 7"
BINDING_NAME_WINDOW8	= "Toggle OzRaid 8"

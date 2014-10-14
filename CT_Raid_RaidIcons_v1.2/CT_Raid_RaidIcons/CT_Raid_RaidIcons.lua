SLASH_CTRaidTargetIcon1 = "/ctri";
SlashCmdList["CTRaidTargetIcon"] = function(msg) CT_Raid_TargetIcon_Slash(msg); end

SLASHHELP_CTRaidTargetIcon = function(text, cmd, key)
	if string.find(string.lower(text), "side") then
		helptext = "%cmd% side [side]\n Set the side on which side the RaidIcons appear.\n [side] - can only be 'left' or 'right'."
		helptext = CT_Raid_TargetIcon_Format_SlashHelpText(helptext)
		SlashHelp_AddLine(string.gsub(helptext,"%%cmd%%", GREEN_FONT_COLOR_CODE .. "/" .. cmd .. "|r"))
	else
		helptext = "%cmd% [option]\n Set options for the CT_Raid_TargetIcon mod.\n [option] - can only be 'side' at the moment."
		helptext = CT_Raid_TargetIcon_Format_SlashHelpText(helptext)
		SlashHelp_AddLine(string.gsub(helptext,"%%cmd%%", GREEN_FONT_COLOR_CODE .. "/" .. cmd .. "|r"))
	end
	return true
end
function CT_Raid_TargetIcon_Format_SlashHelpText(text)
  text = string.gsub(text,"(%b[])", function (a) return strsub(a,2,1) == "|" and a or (HIGHLIGHT_FONT_COLOR_CODE .. "[" .. strsub(a,2,-2) .. "]|r") end);
  text = string.gsub(text,"(%b{})", function (a) return strsub(a,2,1) == "|" and a or ("|c00d0d0d0{" .. strsub(a,2,-2) .. "}|r") end);
  text = string.gsub(text,"\n","\n         ");
  return text
end

function CT_Raid_TargetIcon_OnEvent()
	if not CT_RaidIcons_Settings then
		CT_RaidIcons_Settings = { 
									Side = "LEFT"
								}
	end
	
	CT_Raid_TargetIcon_SetSide()
end

function CT_Raid_TargetIcon_Slash(msg)
	msg = string.lower(msg)
	if msg then
		if string.find(msg, "side") then
			CT_Raid_TargetIcon_SetSideOption(string.gsub(msg, "side",""));
		else
			CT_Raid_TargetIcon_Error("false parameters. Supported parameter is 'side'")
		end
	
	end
end
function CT_Raid_TargetIcon_SetSideOption(side)
	--side = string.lower(side)
	side = string.gsub(side," ","") -- trim
	if side == "left" then
		CT_RaidIcons_Settings.Side = "LEFT"
		CT_Raid_TargetIcon_SetSide()
	elseif side == "right" then
		CT_RaidIcons_Settings.Side = "RIGHT"
		CT_Raid_TargetIcon_SetSide()
	else
		CT_Raid_TargetIcon_Error("false parameters. Supported parameters are 'left' or 'right'")
	end
end
function CT_Raid_TargetIcon_SetSide()
	if CT_RaidIcons_Settings.Side == "RIGHT" then
		local frame, x
		local tempOptions = CT_RAMenu_Options["temp"]
		if tempOptions["ShowMTTT"] and not tempOptions["HideMTs"] then
			frame = "CT_RAMTGroupMember%dMTTT"
			x = 20
		else
			frame = "CT_RAMTGroupMember%d"
			x = 0
		end
		for i = 1, 10 do
			getglobal("CT_Raid_RaidIcons_Icon"..i):ClearAllPoints()
			getglobal("CT_Raid_RaidIcons_Icon"..i):SetPoint("LEFT", getglobal(string.format(frame,i)), "RIGHT", x, 0)
		end
	elseif CT_RaidIcons_Settings.Side == "LEFT" then
		for i = 1, 10 do
			getglobal("CT_Raid_RaidIcons_Icon"..i):ClearAllPoints()
			getglobal("CT_Raid_RaidIcons_Icon"..i):SetPoint("RIGHT", getglobal("CT_RAMTGroupMember"..i), "LEFT")
		end
	else
		CT_RaidIcons_Settings.Side = "LEFT"
		CT_Raid_TargetIcon_SetSide()
	end
end
function CT_RAMenu_Misc_ShowMTTT_New()
	CT_RAMenu_Misc_ShowMTTT_Original() -- execute Original CT_Raid Function
	CT_Raid_TargetIcon_SetSide()
end
--Hooking CT_Raid Function
CT_RAMenu_Misc_ShowMTTT_Original = CT_RAMenu_Misc_ShowMTTT
CT_RAMenu_Misc_ShowMTTT = CT_RAMenu_Misc_ShowMTTT_New

function CT_RA_UpdateMTs_New()
	CT_RA_UpdateMTs_Original() -- execute Original CT_Raid Function
	
	
	if CT_RA_MainTanks then
		for id = 1, 10 do
			local target = (CT_Raid_TargetIcon_GetRaidID(CT_RA_MainTanks[id]) or "") .. "target"
			if UnitExists(target) and target ~= "target" then
				local index = GetRaidTargetIndex(target);
				if ( index ) then
					CT_Raid_TargetIcon_SetIcon(id, index)
				else
					CT_Raid_TargetIcon_ClearIcon(id)
				end
			else
				CT_Raid_TargetIcon_ClearIcon(id)
			end
		end
	end
end
--Hooking CT_Raid Function
CT_RA_UpdateMTs_Original = CT_RA_UpdateMTs
CT_RA_UpdateMTs = CT_RA_UpdateMTs_New

function CT_Raid_TargetIcon_GetRaidID(name)
	for i = 1, GetNumRaidMembers(), 1 do
		local uId = "raid" .. i;
		if (  UnitName(uId) == name ) then
			return uId
		end
	end
end

function CT_Raid_TargetIcon_SetIcon(RaidTarget, IconIndex)
	SetRaidTargetIconTexture(getglobal("CT_Raid_RaidIcons_Icon"..RaidTarget.."_Icon"), IconIndex)
	getglobal("CT_Raid_RaidIcons_Icon"..RaidTarget):Show();
	getglobal("CT_Raid_RaidIcons_Icon"..RaidTarget.."_Icon"):Show();
end
function CT_Raid_TargetIcon_ClearIcon(RaidTarget)
	getglobal("CT_Raid_RaidIcons_Icon"..RaidTarget):Hide();
	getglobal("CT_Raid_RaidIcons_Icon"..RaidTarget.."_Icon"):Hide();
end

function CT_Raid_TargetIcon_Error(x)
	DEFAULT_CHAT_FRAME:AddMessage(RED_FONT_COLOR_CODE .. x .."|r")
end
countdown = 0
BWP_FREQ = 1

BWPMENU_ID = "BetterWaypoints"
BWP_ICON 				= "Interface\\Addons\\BetterWaypoints\\Artwork\\Titan_Button"; --Location of Icon

function BWP_Tooltip()
	GameTooltip_SetDefaultAnchor(GameTooltip, UIParent);
	GameTooltip:SetText(BWP_BUTTON_TOOLTIP);
end
function BWPButton_OnClick(button)
	if(button == "RightButton" ) and (IsShiftKeyDown())then 
		BWP_ClearDest()
	else
	ToggleDropDownMenu(1,1,BetterWaypointsMenuFrame_DropDown, "cursor",-150,0) end
end

function BWP_ToggleDocking()

	if(TitanPlugins) and (not BWP_Hide.TitanUndock) then 
		
		TitanPanel_RemoveButton("BWP")
		Abnormal_TitanBWP:SetChecked(1)
	end
	if(not BWP_Hide.Undocked) then --If its not undocked
		BWP_UndockMini()
	else		--Otherwise ReDock It
		BWP_DockMini()
	end
	
end
function BWP_ChecknumPOI()
	BWP_CZone_XTRA = nil
	local POIinZone = table.getn(BWP_CZone)
	if( POIinZone > 28) then
		
		local temp_CZone = {nil}
		BWP_CZone_XTRA = {nil}
		BWP_CZone_XTRA[1] = {nil}
		BWP_CZone_XTRA[2] = {nil}
		BWP_CZone_XTRA[3] = {nil}
		BWP_CZone_XTRA[4] = {nil}
		BWP_CZone_XTRA[5] = {nil}
		BWP_CZone_XTRA[6] = {nil}
		BWP_CZone_XTRA[7] = {nil}
		BWP_CZone_XTRA[8] = {nil}
					local BWPcount = 0
					table.sort(BWP_CZone,BWPsortbyName)
					for k,v in BWP_CZone do
						BWPcount = BWPcount + 1
						
						if(BWPcount < 29) then
							tinsert(temp_CZone, v)
						elseif(BWPcount < 57) then 
							tinsert(BWP_CZone_XTRA[1], v );
						elseif(BWPcount < 85) then 
							tinsert(BWP_CZone_XTRA[2], v );
						elseif(BWPcount < 113) then 
							tinsert(BWP_CZone_XTRA[3], v );
						elseif(BWPcount < 141) then 
							tinsert(BWP_CZone_XTRA[4], v );
						elseif(BWPcount < 169) then 
							tinsert(BWP_CZone_XTRA[5], v );
						elseif(BWPcount < 197) then 
							tinsert(BWP_CZone_XTRA[6], v );
						elseif(BWPcount < 225) then 
							tinsert(BWP_CZone_XTRA[7], v );
						elseif(BWPcount < 253) then 
							tinsert(BWP_CZone_XTRA[8], v );
						end
						
					end
					BWP_CZone = temp_CZone
				end
end
function BWP_UndockTitan_OnClick()
	if(not BWPOption) then BWPOptions = {} end
	if(this:GetChecked()) then 
		TitanPanel_RemoveButton("BWP")
		if(BWP_Hide.Undocked) then 
			BetterWaypointsMenuFrame:Show() 
		else
			BWPMiniMapButtonFrame:Show() 
		end
	elseif (not this:GetChecked())then
		TitanPanel_AddButton("BWP")
		BetterWaypointsMenuFrame:Hide() 
		BWPMiniMapButtonFrame:Hide() 
		BWPUndockButton:SetText(BWP_Titan_UndockText)
	end
end

function BWP_ToggleMini()
	if(not BWPOptions) or (not BWPOptions.Hidden) then
		if (not BWPOptions) then BWPOptions = {} end
			BWPOptions.Hidden = 1
			BWPMiniMapButtonFrame:Hide()
			HideOptionButton:SetText(BWP_ShowButtonText) 
		else
			if(BWPOptions.Hidden) then BWPOptions.Hidden = nil end
			BWPMiniMapButtonFrame:Show()
			HideOptionButton:SetText(BWP_HideButtonText) end
end
function BWPButton_UpdatePosition()
	if(BWP_Hide) and (BWP_Hide.BWPButtonPosition) then
		BWPMiniMapButtonFrame:SetPoint(
			"TOPLEFT",
			"Minimap",
			"TOPLEFT",
			54 - (78 * cos(BWP_Hide.BWPButtonPosition)),
			(78 * sin(BWP_Hide.BWPButtonPosition)) - 55
		);
	end

end
function BetterWaypoints_OnLoad()
	SLASH_BETTERW1 = "/betterwaypoints";
	SLASH_BETTERW2 = "/bwp"; 
	SlashCmdList["BETTERW"] = BWP_Command
	this:RegisterEvent("CHAT_MSG_SYSTEM")
	this:RegisterEvent("QUEST_GREETING")
	this:RegisterEvent("ZONE_CHANGED")
	this:RegisterEvent("UNIT_NAME_UPDATE");
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterForDrag("LeftButton")
	this:RegisterEvent("QUEST_COMPLETE") -- This one is for right before you turn it in
	this:RegisterEvent("QUEST_FINISHED") --this one is for hitting accept both at beginning and when you actually hit the complete button of quest
	this:RegisterEvent("QUEST_GREETING")
	this:RegisterEvent("QUEST_ACCEPT_CONFIRM")
	this:RegisterEvent("GOSSIP_CLOSED")
	this:RegisterEvent("PLAYER_DEAD")
	this:RegisterEvent("PLAYER_ENTERING_WORLD")
	
end
function BWPEVENT_mini()
	if(not BWP_Hide) then BWP_Hide = {}  end
	if(not BWP_Hide.Distance) then DistDisplayCheckOption:SetChecked(1)elseif(BWP_Hide.Distance == 1)then DistDisplayCheckOption:SetChecked(0)end
	if(not BWP_Hide.Destination) then DispTargetCheckOption:SetChecked(1)elseif(BWP_Hide.Destination == 1) then DispTargetCheckOption:SetChecked(0) end
	BWPButton_UpdatePosition();
	
end
function BetterWaypoints_OnUpdate(arg)
	monitor_Minimap()
	if(UnitIsDeadOrGhost("player")) and (not BWP_playerIsDead) then	DeadMan()end
	if(not UnitIsDeadOrGhost("player"))and (BWP_playerIsDead) then	BWP_Alive()	end
	if(BWP_Dest)and((not BWP_Hide) or (not BWP_Hide.Destination))then BWPText:SetText("("..BWP_Dest.name..")")else BWPText:SetText(nil); end
	if(BWP_Dest) and ((not BWP_Hide) or (not BWP_Hide.Distance))then BWPDistanceText:SetText(BetterWaypoints_GetDistText())	else BWPDistanceText:SetText(nil) end
	if(BWPspecialintrest) then BWP_Special_Dest(); end
	if(not BWP_Dest) then BetterWaypointsArrow:SetTexture(nil); return nil; end
	if (countdown > 0) then 
		countdown = countdown - 1; 
		if (countdown == 1) then countdown = 0; BWP_ClearDest(); end
		return;
	end
	
	local UpdateBWP = BetterWaypoints_GetDir()
	if(UpdateBWP) then Figure_It_all_Out(UpdateBWP) end
	
	

end
function BetterWaypoints_SelectionDropDown_OnLoad()
	
	UIDropDownMenu_Initialize(BWPOptionsDropDown, BetterWaypointsFrameDropDown_Initialize );
	
	UIDropDownMenu_SetWidth(175);
end
function BWP_InitializeLocalizationStrings()
	MapPointsCheckOptionText:SetText(BWP_Check_ShowMapPoints)
	DispTargetCheckOptionText:SetText(BWP_Check_ShowTarget)
	DistDisplayCheckOptionText:SetText(BWP_Check_ShowDistance)
	ConfirmButtonOption:SetText(BWP_Option_Add)
	LocationSliderOptionSliderTitle:SetText(BWP_Slider_Position)
	DistanceSliderOptionSliderTitle:SetText(BWP_CLEARDIST_TEXT)
	QNPCCheckOptionText:SetText(BWP_Check_ShowQNPC)
	BetterWaypointsClearButton:SetText(BWPClear)
	HideOptionButton:SetText(BWP_HideButtonText)
end

function BetterWaypoints_GetDistText()--Turns the Distance into a displayable string
		local px , py = GetPlayerMapPosition("player")
		if(px == 0 and py==0) then 
			return nil 
		end
		local dx, dy = nil,nil
		if(BWP_Dest and BWP_Dest.x and BWP_Dest.y) then
			dx, dy = BWP_Dest.x, BWP_Dest.y
		else 
			return nil 
		end
		local loc1,loc2 = {x = px , y= py},{x=dx,y=dy}
		local thisDistance, theseUnits , flag = formatdist(loc1,loc2)
		if (flag == "A") then 
			return "("..BWP_Arrived..")" 
		elseif flag == "Y" then 
			return "("..thisDistance..theseUnits..")"
		end
		local colortext = getglobal("BWP"..flag.."Text")
		local testtext = colortext(thisDistance..theseUnits)
		return "("..testtext..")"

end
function DeadMan()--Your Dead
	deadx,deady = nil,nil
	deadx,deady = GetCorpseMapPosition() 
	if(not MapNotes_Data) then deadx = deadx * 100 ; deady = deady * 100 ; end
	if(deadx) and (deady)and (deadx ~= 0) and (deady ~=0) then
	    if(BWP_Dest) and ( deadx ~= BWP_Dest.X ) and (deady ~= BWP_Dest.Y) then
			BWP_OldDest = BWP_Dest
		end
		if(BWP_OldDest)then
			BWP_OldDest.name = BWP_Dest.name
			BWP_OldDest.zone = GetCurrentMapZone()
			BWP_OldDest.continent = GetCurrentMapContinent()
		end
		if(not BWP_playerIsDead)  then
			BWP_playerIsDead = "true"
			setmininote(deadx, deady, BWP_Corpse_Text , "7")
		end
		
	end
end
function BWP_Alive() --Alive!
	if(BWP_OldDest)then
		setmininote(BWP_OldDest.x,BWP_OldDest.y,BWP_OldDest.name,"7",BWP_OldDest.continent,BWP_OldDest.zone)
		BWP_OldDest = nil
		BWP_playerIsDead=nil
	elseif(BWP_playerIsDead)then
		
		BWP_playerIsDead = nil
		BWP_ClearDest()
	end 
end
oldBWPFOLLOW_UnitPopup_OnClick = UnitPopup_OnClick
function UnitPopup_OnClick()
	if UnitPopupMenus[this.owner][this.value]=="BWPFOLLOW" then
		BWPFOLLOW_Name = UnitName(getglobal(UIDROPDOWNMENU_INIT_MENU).unit)
		if(not BWPFOLLOWPLAYER) then
			
			BWP_TargetPlayer = string.lower(BWPFOLLOW_Name) 
			BWPspecialintrest = 1
			BWPFOLLOWPLAYER = 1
			DEFAULT_CHAT_FRAME:AddMessage("Now Following "..BWPFOLLOW_Name)
			UnitPopupButtons["BWPFOLLOW"] = { text = "Stop Following", dist = 0 } 
		else
			BWPFOLLOWPLAYER = nil
			BWPspecialintrest = nil
			BWP_ClearDest()
			DEFAULT_CHAT_FRAME:AddMessage("No Longer Following "..BWPFOLLOW_Name)
			UnitPopupButtons["BWPFOLLOW"] = { text = "Set As Waypoint", dist = 0 } 
		end	
	end
	oldBWPFOLLOW_UnitPopup_OnClick()
end 




function BetterWaypoints_OnEvent(event) --Event Handleing
	if (event == "VARIABLES_LOADED") then
		BWP_InitializeLocalizationStrings()
		BWP_InitializeSavedVariables()		
		DistanceSliderOptionSlider:SetValue(BWP_Hide.ClearDistance)
		BetterWaypoints_Generate()
		BWP_MoveFrames(0)--lock the frames
		--add dropdown for follow 
		table.insert(UnitPopupMenus["PARTY"],"BWPFOLLOW")
	--	table.insert(UnitPopupMenus["PLAYER"],"BWPFOLLOW")
		table.insert(UnitPopupMenus["RAID"],"BWPFOLLOW")
		UnitPopupButtons["BWPFOLLOW"] = { text = "Set As Waypoint", dist = 0 } 
		--set hooks
		if(TitanPlugins) then
			BWPHook_Titan()
		end
		if (MapNotes_Data) then 
			BWPHook_MN()
		end
		if (CT_UserMap_Notes) then
			BWPHook_CTMap()
		end
		if (MetaMapNotes_MiniNote_Data) then
			BWPHook_MetaMap()
		end
		local old_ToggleDropDownMenu=ToggleDropDownMenu
		function ToggleDropDownMenu(level, value, dropDownFrame, anchorName, xOffset, yOffset)
			if(this:GetParent()) and (this:GetParent():GetName())and(this:GetParent():GetName()== "BetterWaypointsMenuFrame_DropDown")then
				old_ToggleDropDownMenu(level, value, dropDownFrame,"BetterWaypointsMenuFrame", xOffset, yOffset)
			else
				old_ToggleDropDownMenu(level, value, dropDownFrame, anchorName, xOffset, yOffset)
			end
			return nil
			
		end
				
	
		
		funkyEditOptionsFrame()
		DEFAULT_CHAT_FRAME:AddMessage("/bwp help     -for help")
		return;
		


	elseif (event == "UNIT_NAME_UPDATE" and arg1 == "player") then 
		if (BWP_FirstLoad) then
			BWP_Player = UnitName("player");
			if (playerName ~= UNKNOWNOBJECT) then 
				BWP_FirstLoad = nil;
			end
		end
	
	elseif(event == "GOSSIP_CLOSED") then
		BWPspecialintrest = 1
	elseif(strsub(event,1,16) == "CHAT_MSG_SYSTEM") then

		local msg = arg1;
		local plr = arg2;
		if ( (msg and msg ~= nil) and (plr and plr ~= nil) ) then
			local _,_,questname = string.find(msg,"Quest accepted: (.*)")
			if(questname) then
				addQuestBWP(questname)
			end						
		end	
	
	
		
		
		
	elseif(event == "QUEST_COMPLETE") then
		local title = GetTitleText() or "";
		clearquest(title)
	elseif(event == "PLAYER_ENTERING_WORLD") then
		BWP_ClearDest()
	end
		
end
function BWP_StartMove()
	if(isMoveable_BWPFRAMES)then
		this:StartMoving();
		this.isMoving = true;
	end
end
function BWP_StopMove()
	this:StopMovingOrSizing();
	this.isMoving = false;
end

function BetterWaypointsFrameDropDown_Initialize() --Create Dropdown
	if( UIDROPDOWNMENU_MENU_LEVEL == 1) then
		descript = {};
		descript.text = BWPGreenText(BWP_OptionsString)
		descript.func = BWP_ShowOptions;
	--	descript.isTitle = 1;
		UIDropDownMenu_AddButton(descript)
		
		info = {};--MESSAGE TO SELECT WAYPOINT
		info.text = BETTERWAYPOINTS_SELECTMSG
		info.notClickable = 1;
		info.isTitle = 1;
		info.notCheckable = 1;
		UIDropDownMenu_AddButton(info);
		local x, y = GetPlayerMapPosition("player");
		if (x == 0 and y == 0) or ((MapNotes_ZoneNames) and MapNotes_GetZone() == 0)then 
			--Header 
			info = {--mESSAGE THAT THIS IS AN INVALID LOCATION
				text = BETTERWAYPOINTS_NILLOCATION;
				notClickable = 1;
				isTitle = 1;
				notCheckable = 1; }
			UIDropDownMenu_AddButton(info);
			--TitanPanelRightClickMenu_AddTitle("No destinations possible in region");
			--TitanPanelRightClickMenu_AddSpacer();
			--TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, Titan_SpeedNote_ID, TITAN_PANEL_MENU_FUNC_HIDE);
			return;
		end
	end
	BetterWaypoints_Generate();
	
	bwpx,bwpy = nil,nil
	local BWP_BREAK_IT_DOWN = nil
	if(BWPgetnumpoints() > 28) then BWP_BREAK_IT_DOWN = 1 end
	if(MapPointsCheckOption) and(MapPointsCheckOption:GetChecked()) then
		if(not BWP_BREAK_IT_DOWN) or  ( UIDROPDOWNMENU_MENU_LEVEL == 2 ) then
			local ZonePoints = {nil}
			local isExtra = nil
			if(this.value == "BWP_CZone") then
				
				ZonePoints = getglobal(this.value)
				
			elseif(this.value) and (BWP_CZone_XTRA) and (BWP_CZone_XTRA[this.value])then
				ZonePoints = BWP_CZone_XTRA[this.value]
				
			elseif(not this.value) then
				ZonePoints = BWP_CZone
			end
			if(ZonePoints) then
				for val,k in ZonePoints do
					
					if(k) then
						if(MapNotes_Data)then bwpx = tostring(ZonePoints[val].xcoord*100) else bwpx = tostring(ZonePoints[val].xcoord) end
						if (MapNotes_Data) then bwpy = tostring(ZonePoints[val].ycoord*100) else bwpy = tostring(ZonePoints[val].ycoord) end
						_,_,bwpx = string.find(bwpx,"(.*)%.")
						_,_,bwpy = string.find(bwpy,"(.*)%.")
					
						title =  ZonePoints[val].title;
						
					end
					if (strlen(title) >= 24) and (not BWP_Hide.Bad_Idea) then 
						title = strsub(title, 1, 21).."..."; 
					end
			
					if (title == "") then 
						title = SN_CZone[val]:getNote1();
					end
					
					if(bwpx) and (bwpy)then
						descript = {};--Make our menu Options
						descript.text = val..".  "..BWPHilightText(("("..bwpx.." , "..bwpy..")")).." - \""..title.."\""
						descript.func = BetterWaypoints_SetDest;
						descript.value = k;
						
						UIDropDownMenu_AddButton(descript, UIDROPDOWNMENU_MENU_LEVEL);
					end
				end
			end
		else --Break It Down Too many Points		
			info = {};
			info.text = BWP_Get_MenuTitle(BWP_CZone);
			info.hasArrow = 1;
			info.value = "BWP_CZone";
			UIDropDownMenu_AddButton(info);
			if(BWP_CZone_XTRA) then
				for k,v in BWP_CZone_XTRA do
					if(BWP_Get_MenuTitle(v)) then
					local info = {};
					info.disabled = 1;
					UIDropDownMenu_AddButton(info)
				
					local info = {};
					info.text = BWP_Get_MenuTitle(v);
					info.hasArrow = 1;
					info.value = k;
					UIDropDownMenu_AddButton(info);
					end
				end
			end
		end	
	end
	
	local LocalQList = GetLocalQuestList()
	if(LocalQList) and (QNPCCheckOption) and (QNPCCheckOption:GetChecked()) then
		if(not BWP_BREAK_IT_DOWN) or (( UIDROPDOWNMENU_MENU_LEVEL == 2 ) and (this.value == "Q")) then
			table.sort(LocalQList,BWPSortByQuestGiverName)
			local thisindex = 0
			for v, thisquest in LocalQList do
				if(thisquest) then 
					local thisX = string.format("%.0f",(thisquest.X*100))
					local thisY = string.format("%.0f",(thisquest.Y*100))
					descript = {};--Make our menu Options
					descript.text = BWPQuestNPCtext..BWPHilightText("(".. thisX .." , "..thisY ..")").." - \""..thisquest["QuestGiver"].."\"";
					descript.func = BetterWaypoints_SetDest;
					descript.value = thisquest;
					UIDropDownMenu_AddButton(descript,UIDROPDOWNMENU_MENU_LEVEL );
				end
			end	
		elseif(UIDROPDOWNMENU_MENU_LEVEL == 1) then
			local info = {};
				info.disabled = 1;
				UIDropDownMenu_AddButton(info)
				
				local info = {};
				info.text = BWP_QUEST_NPCSTRING	;
				info.hasArrow = 1;
				info.value = "Q";
				UIDropDownMenu_AddButton(info);
		end
	end
	
	--if(not BWP_Hide.MenuTop) then BWPDDmenu() end
end

function BWP_Get_MenuTitle(MList)
	local tempstring = nil
	local firstword,lastword = nil, nil
	for k,v in MList do
		
		if(not tempstring) then -- if its our first word in the List
			if(v.title) then 
				tempstring = v.title 
			elseif (v.QuestGiver) then 
				tempstring = v.QuestGiver 
			end --set tempstring(so it will have a value)
			firstword = tempstring
		else
			if(v.title) then 
				tempstring = v.title 
			elseif (v.QuestGiver) then 
				tempstring = v.QuestGiver 
			end
		end
		
	end
	if(tempstring) and (firstword) then
		lastword = strsub(tempstring, 1, 5)
		firstword = strsub(firstword, 1, 5)
		return "Notes: "..firstword.." - "..lastword
	else return nil end
		
	
	
	
end

function BWP_ShowOptions()
	BetterWaypointsOptionsForm:Show()
end
function BWP_ClearDest() --Removes current destination
	UIDropDownMenu_SetText(nil, BetterWaypointsMenuFrame_DropDown)
	if(MiniNotePOI)then
	if(MapNotes_ClearMiniNote) then	MapNotes_ClearMiniNote() end
	if(MetaMapNotes_ClearMiniNote) then	MetaMapNotes_ClearMiniNote() end
	end
	BWP_Dest = nil
	BetterWaypointsArrow:SetTexture(nil)
	if(BWPFOLLOWPLAYER)then	BWPFOLLOWPLAYER = nil; UnitPopupButtons["BWPFOLLOW"] = { text = "Set As Waypoint", dist = 0 }; end
	BWPspecialintrest = nil
end
function BWPGreenText(inText) --TextOverride
	if (inText) then
		return BWP_Greentext..inText..FONT_COLOR_CODE_CLOSE;
	end
end
function BWPRedText(inText) --Text Override
	if (inText) then
		return BWP_Redtext..inText..FONT_COLOR_CODE_CLOSE;
	end
end
function BWPHilightText(inText)	 --Text Override
	if (inText) then
		return BWP_Highlighttext..inText..FONT_COLOR_CODE_CLOSE;
	end
end


function BetterWaypoints_SetDest() --Sets the current Destination
	if(BWP_Debug)then
		DEFAULT_CHAT_FRAME:AddMessage("Debugging Set Destination")
		if(this.value)then
			for k , v in this.value do
			DEFAULT_CHAT_FRAME:AddMessage("Set Destination."..k.." = "..v)
			end
		else
			DEFAULT_CHAT_FRAME:AddMessage("Error No Destination Selected")
		end
	end
	if(this.value.QuestGiver) then
		UIDropDownMenu_SetText(this.value.QuestGiver, BetterWaypointsMenuFrame_DropDown)
		setmininote(this.value.X,this.value.Y,this.value.QuestGiver,"7")
	elseif(this.value.title) then
		UIDropDownMenu_SetText(this.value.title, BetterWaypointsMenuFrame_DropDown)
		setmininote(this.value.xcoord, this.value.ycoord,this.value.title,"7")
	end
	
end	
	

function clearquest(title)	--Removes a quest/questgiver
	_,_,realtitle = string.find(title,".*%[%d%]% (.*)")
	if(realtitle)then
		
		title = realtitle
	end
	if(BWP_QuestList)then
		for v, thisquest in BWP_QuestList do
			if(string.find(thisquest["QuestName"],title))then
				if(thisquest["QuestName"] == title) then
					if(BWP_Dest) and (thisquest["QuestGiver"] == BWP_Dest.name)then
						BWP_ClearDest()
					end
					
					BWP_QuestList[v]= nil
					tempQuestlist = {}
					local index = 1 
					for i,q in BWP_QuestList do
						tempQuestlist[index] = q
						index = index + 1
					end
					BWP_QuestList = tempQuestlist
				else
					BWPqnamestring=BWP_QuestList[v]["QuestName"]
					_,_,tempstring1 = string.find(BWPqnamestring,"(.*)"..title)
					_,_,tempstring2 = string.find(BWPqnamestring,".*"..title.."%,(.*)")
					if(not tempstring1)and (tempstring2)then 
						BWPqnamestring = tempstring2
					elseif(not tempstring2)and(tempstring1)then
						BWPqnamestring = tempstring1
					elseif(tempstring2) and (tempstring1) then
						BWPqnamestring = tempstring1..tempstring2
					else
						DEFAULT_CHAT_FRAME:AddMessage("ERROR ON QUEST TURN IN:Better Waypoints[Unable to perform string operation]")
					end
					BWP_QuestList[v]["QuestName"]=BWPqnamestring
				end
			end
		end
	end
end
	
	


function BWP_AddNewPoint()
	if (not CT_UserMap_Notes)and(not MapNotes_Data) then DEFAULT_CHAT_FRAME:AddMessage(Error_NoMapMods) return 1 end
	local x, y = GetPlayerMapPosition("player")
	x=x*100
	y=y*100
	x= math.floor(x*100)/100 
	y= math.floor(y*100)/100 
	if(UnitExists("target")) and (not UnitIsPlayer("target") )then
		BWPADDTITLEBOX:SetText(UnitName("target"))
	else
		BWPADDTITLEBOX:SetFocus()
		DEFAULT_CHAT_FRAME:AddMessage("No Target or Invalid Target")
	end
	BWPADDX:SetText(tostring(x))
	BWPADDY:SetText(tostring(y))
			
	BetterWaypointsAddForm:Show()
	BetterWaypointsOptionsForm:Hide()
	
end

function BWPgetnumpoints()
	if(table.getn(BWP_CZone) > 28 ) then BWP_ChecknumPOI() end
	local tempnum = 0
	if(BWP_CZone) then
			tempnum = table.getn(BWP_CZone)
			
	end
	if (BWP_CZone_XTRA) then 
		if(BWP_CZone_XTRA[1]) then tempnum = tempnum + table.getn(BWP_CZone_XTRA[1]) end
		if(BWP_CZone_XTRA[2]) then tempnum = tempnum + table.getn(BWP_CZone_XTRA[2]) end
		if(BWP_CZone_XTRA[3]) then tempnum = tempnum + table.getn(BWP_CZone_XTRA[3]) end
		if(BWP_CZone_XTRA[4]) then tempnum = tempnum + table.getn(BWP_CZone_XTRA[4]) end
		if(BWP_CZone_XTRA[5]) then tempnum = tempnum + table.getn(BWP_CZone_XTRA[5]) end
		if(BWP_CZone_XTRA[6]) then tempnum = tempnum + table.getn(BWP_CZone_XTRA[6]) end
		if(BWP_CZone_XTRA[7]) then tempnum = tempnum + table.getn(BWP_CZone_XTRA[7]) end
		if(BWP_CZone_XTRA[8]) then tempnum = tempnum + table.getn(BWP_CZone_XTRA[8]) end -- max number of second menus
	end
	if(BWP_QuestList) then
		for v, thisquest in BWP_QuestList do
			if(thisquest)and(thisquest.Zone == GetCurrentMapZone())then
				tempnum = tempnum + 1
			end
		end
	end
	return tempnum
end

local specialindex = 1
function BWP_Special_Dest()

	if(BWPFOLLOWPLAYER)then
	
		if(BWP_TargetPlayer) then
			local bwpthisflag 
			local playeridindex = GetNumRaidMembers()
			
			if (playeridindex == 0) then playeridindex = GetNumPartyMembers();bwpthisflag = nil else  bwpthisflag = "R" end
			if (playeridindex == 0 ) then
				DEFAULT_CHAT_FRAME:AddMessage(BWPGROUPERROR)
				BWPspecialintrest = nil
			else
				
				if(bwpthisflag) then -- if its a raid group
					
					for x =  1, playeridindex do
					local Rname, Rrank, Rsubgroup, Rlevel, Rclass, RfileName, Rzone, Ronline = GetRaidRosterInfo(x)
						if (Rname) then
							local tempuid = "raid"..x
							if(string.lower(Rname) == BWP_TargetPlayer) then
								BWP_TargetUnitID = tempuid
								
							elseif(x == 1) then --If the player wasnt found in the current group
								DEFAULT_CHAT_FRAME:AddMessage(BWPGROUPERROR1)
								BWPspecialintrest = nil
								BWPFOLLOWPLAYER = nil
							end
						end
					end
				else -- its a normal PARTy
					
					for x = 1,playeridindex do
						if (GetPartyMember(x)) then  --Doesnt work in Raid :(
							local tempuid = "party"..x
							if(string.lower(UnitName(tempuid)) == BWP_TargetPlayer) then
								BWP_TargetUnitID = tempuid
								
							elseif(x == playeridindex) and (not BWP_TargetUnitID) then --If the player wasnt found in the current group
								DEFAULT_CHAT_FRAME:AddMessage(BWPGROUPERROR2)
								BWPspecialintrest = nil
								BWPFOLLOWPLAYER = nil
							end
						end
					end
				end
				if(BWP_TargetUnitID) then
					
					local posX, posY = GetPlayerMapPosition(BWP_TargetUnitID)
					BWP_TargetUnitID = nil
					BWP_Dest = {
						name = BWP_TargetPlayer,
						x = posX ,
						y = posY ,			
						zone = GetRealZoneText()}						
					Figure_It_all_Out()
					
				end
					
			end
		end
	else
		if(specialindex == 1) then specialindex = 50 end
		specialindex = specialindex - 1
		if(specialindex == 2) then BWPspecialintrest = nil ; specialindex = 1 end
		local numPOIs = GetNumMapLandmarks()
		if(numPOIs) then
			for x = 1, numPOIs do
				local POIname, POIdescription, POItextureIndex, POIx, POIy = GetMapLandmarkInfo(x)
				
				if(POItextureIndex == 6) then
					
					BWP_Dest = {
						name = POIname,
						x = POIx ,
						y = POIy ,			
						zone = GetRealZoneText()}
					BWPspecialintrest = nil
					specialindex = 1
				end
			end
		end
	end
end	
			
function  BWP_Command(msg) -- togles text/visibility of dropdown
	msg = string.lower(msg)
	if(msg == "add") then
		BWP_AddNewPoint()
		return 1
	elseif (msg == "clear") then
		BWP_ClearDest()
		DEFAULT_CHAT_FRAME:AddMessage("Clearing Destination.")
		return 1
	elseif(msg == "help")then
		DEFAULT_CHAT_FRAME:AddMessage(BWP_HelpString)
		return 1
	elseif(string.find(msg,"follow"))then
	
		local _,_,target = string.find(msg, "follow (.*)")
		BWP_TargetPlayer = target 
		BWPspecialintrest = 1
		BWPFOLLOWPLAYER = 1
		return 1
	elseif (string.find(msg,"%,"))then
		local _,_,tempX,tempY = string.find(msg,"([0-9]*)%,([0-9]*)")
		tempX = tonumber(tempX)
		tempY = tonumber(tempY)
		
		if(tempX) and (tempY) and (tempX > 0) and (tempY > 0) and (tempX < 101) and (tempY < 101) then
			setmininote(tempX,tempY,"QuickNote",7)
		else
			DEFAULT_CHAT_FRAME:AddMessage("Invalid Syntax, correct usage is '/bwp XX,YY' where X and Y are between 1 - 100")
		end
		return 1
	end
	
	BWP_ShowOptions()
end
function BetterWaypoints_Hide() -- Hides the dropdown
	BWP_Hide.DropDown = 1
	BetterWaypointsMenuFrame:Hide()
end
function GetLocalQuestList() -- Returns an Array of QuestNPC Data
	local localquestlist = {}
	if(BWP_QuestList) then
		for k,v in BWP_QuestList do
			if (Mapnotes_ZoneNames)	then local BWP_mnCont, zone = BetterWaypoints_MNZone();
			else zone = GetCurrentMapZone() end
			if(v.Zone == zone) then
				table.insert(localquestlist,v)
			end
		end
	end
	return localquestlist
end
function addQuestBWP(questname)--Adds a quest giver to waypoint menu
if(UnitExists("target")) and(not UnitIsPlayer("Target")) and (UnitReaction("Player", "Target")>3)and (not UnitAffectingCombat("Player"))and ((UnitName("target")~= nil)or(UnitName("target")~= "")) then
	
	if (not BWP_QuestList) then
			    BWP_QuestList = {}
				local Questlist ={}
				local questitem = {}
				questitem["QuestName"] = questname
				questitem["QuestGiver"] = UnitName("Target")
				questitem["X"],questitem["Y"] = GetPlayerMapPosition("Player")
				questitem["Zone"]= GetCurrentMapZone()
				Questlist[1] = questitem
				BWP_QuestList = Questlist
	else
		local Questlist = BWP_QuestList
		local questitem = {}
		local index = 0
		questitem["QuestName"] = questname
		questitem["QuestGiver"] = UnitName("Target")
		questitem["Zone"]= GetCurrentMapZone()
		questitem["X"],questitem["Y"] = GetPlayerMapPosition("Player")
		for k,v in Questlist do 
			index = index + 1
			if(UnitName("Target") == v["QuestGiver"]) then
			
			
			
				if(v["QuestName"])then
					questitem = nil
					questitem = v 
					if(questitem["QuestName"])then
						if(not string.find(questitem["QuestName"],questname))then
							questitem["QuestName"] = (questitem["QuestName"]..","..questname)
						end
					end
				end
				Questlist[index] = questitem
				BWP_QuestList = Questlist
				return 1
			end
		end
		
		
		Questlist[index+1] = questitem
		BWP_QuestList = Questlist
	end
	
end
	
end
--Set our Hooks
--Abandon quest to know when you drop a quest and no longer require that questgiver
local Old_AbandonQuest =  AbandonQuest
function  AbandonQuest() 
	local title = GetAbandonQuestName()
	if(title)then
		DEFAULT_CHAT_FRAME:AddMessage("Abandoning:"..title)
		clearquest(title)
		
	end
	Old_AbandonQuest()
	return Old_AbandonQuest
	
end

function setmininote(x,y,name,icon,continent,zone)--taps into mapnotes to create a mininote
	if(not continent)then
		continent = GetCurrentMapContinent()
	end
	if(not zone)then
	
			zone = GetCurrentMapZone()
	if(x >= 1) then x = x / 100 end
		if(y >= 1) then y = y / 100 end
	end
	if (MapNotes_Data) then
		if(not icon) then icon = "7" end
		MapNotes_MiniNote_Data.xPos = x;
		MapNotes_MiniNote_Data.yPos = y;
		MapNotes_MiniNote_Data.continent =continent;
		MapNotes_MiniNote_Data.zone = zone;
		MapNotes_MiniNote_Data.id = -1; -- only shown if the note was written...
		MapNotes_MiniNote_Data.name = name;
		MapNotes_MiniNote_Data.color = 0;
		MapNotes_MiniNote_Data.icon = icon;
		MiniNotePOITexture:SetTexture("Interface\\AddOns\\MapNotes\\POIIcons\\Icon"..icon);
		MiniNotePOI:Show();
		MapNotes_SetNextAsMiniNote = 1;
		--MapNotes_StatusPrint(MAPNOTES_SETMININOTE)
	elseif(MetaMapNotes_MiniNote_Data) then
		MetaMapNotes_MiniNote_Data.xPos = x
		MetaMapNotes_MiniNote_Data.yPos = y
		MetaMapNotes_MiniNote_Data.name = name
		MetaMapNotes_MiniNote_Data.color = 0
		MetaMapNotes_MiniNote_Data.icon = "tloc"
		MetaMapNotes_MiniNote_Data.continent = continent
		MetaMapNotes_MiniNote_Data.zone  = zone;
		MetaMapNotes_MiniNote_Data.id = -1
		MiniNotePOITexture:SetTexture("Interface\\AddOns\\MetaMap\\Icons\\Icontloc")
		MiniNotePOI:Show()

		
	end
	BWP_Dest = {}
	BWP_Dest.name = name
	BWP_Dest.x = x
	BWP_Dest.y = y
	BWP_Dest.zone = GetRealZoneText()
end
function BWP_MoveFrames(thisflag) --sets frames to moveable or not
	if(not thisflag)then
		if(isMoveable_BWPFRAMES) then
			thisflag = 0
		else
			thisflag = 1
		end
	end
    if(thisflag == 0)then--Redock
		BetterWaypointsMainFrame:EnableMouse(0)
		isMoveable_BWPFRAMES= nil
		BetterWaypointsMoveMenuTexture:SetTexture(nil)
		BetterWaypointsMoveMainTexture:SetTexture(nil)
		BWPUnlockButton:SetText(BWP_Unlock)
	elseif(thisflag==1) then --undock
		BetterWaypointsMainFrame:EnableMouse(1) -- enablemouse
		isMoveable_BWPFRAMES= 1
		if(BWP_Hide.Undocked) then BetterWaypointsMoveMenuTexture:SetTexture("Interface\\TutorialFrame\\TutorialFrameBackground") end
		BetterWaypointsMoveMainTexture:SetTexture("Interface\\TutorialFrame\\TutorialFrameBackground")
		BWPUnlockButton:SetText(BWP_Lock)
	end
end

function BWP_TT_Menu()--This just adds a [] to the menu text informing current text display settings
	if(not BWP_Hide.Dest) and (not BWP_Hide.Dist)then
		return BWP_TextToggle.."[ALL]"
	elseif(BWP_Hide.Dest)and (BWP_Hide.Dist) then
		return BWP_TextToggle.."[NONE]"
	elseif(not BWP_Hide.Dest) and (BWP_Hide.Dist) then
		return BWP_TextToggle.."[Dest]"
	elseif(BWP_Hide.Dest) and (not BWP_Hide.Dist) then
		return BWP_TextToggle.."[Dist]"
	end
end
function BWPAddNewMapNote(x,y,name,desc)
	
	
	if(MapNotes_Data) then
		if(not desc) then desc = "" end
		local continent, zone = BetterWaypoints_MNZone()
		if(BetterWaypoints_MNZone() == 0) then DEFAULT_CHAT_FRAME:AddMessage("This Area is not Supported"); return 0 end
		local i = 0
		for j, value in MapNotes_Data[continent][zone] do
			i = i + 1;		
		end

	
		if (i < MapNotes_NotesPerZone) then
		
			MapNotes_TempData_Id = i + 1;
			MapNotes_Data[continent][zone][MapNotes_TempData_Id] = {};
			MapNotes_Data[continent][zone][MapNotes_TempData_Id].name = name;
			MapNotes_Data[continent][zone][MapNotes_TempData_Id].ncol = 0;
			MapNotes_Data[continent][zone][MapNotes_TempData_Id].inf1 = desc;
			MapNotes_Data[continent][zone][MapNotes_TempData_Id].in1c = 0;
			MapNotes_Data[continent][zone][MapNotes_TempData_Id].inf2 = "";
			MapNotes_Data[continent][zone][MapNotes_TempData_Id].in2c = 0;
			MapNotes_Data[continent][zone][MapNotes_TempData_Id].creator = UnitName("player");
			MapNotes_Data[continent][zone][MapNotes_TempData_Id].icon = "9";
			MapNotes_Data[continent][zone][MapNotes_TempData_Id].xPos = x;
			MapNotes_Data[continent][zone][MapNotes_TempData_Id].yPos = y;
	

	
			MapNotes_StatusPrint(format(MAPNOTES_QUICKNOTE_OK, MapNotes_ZoneNames[continent][zone]));
		
		else
			MapNotes_StatusPrint(format(MAPNOTES_QUICKNOTE_TOOMANY, MapNotes_ZoneNames[continent][zone]));
		end
	elseif(CT_UserMap_Notes) then
			zone = GetRealZoneText()
			CT_MapMod_AddNote(x, y, zone, name, desc, 1, 1)
		
	end
end
function BWPADDIT_OnCLICK()
	local name,x,y,desc = nil,nil,nil
	local name = BWPADDTITLEBOX:GetText()
	local desc = BWPADDCOMMENTBOX:GetText()				
	local x = (tonumber(BWPADDX:GetText()))/100				
	local y = (tonumber(BWPADDY:GetText()))/100				
	if (name ~= "") then
		BWPAddNewMapNote(x,y,name,desc)
		BetterWaypointsAddForm:Hide()					
	else
		DEFAULT_CHAT_FRAME:AddMessage("You Must Add a Title!")
	end
end
function funkyEditOptionsFrame()
	if (MapNotes_Data) and (not TitanPlugins) then return 1
	elseif(not CT_UserMap_Notes) and (not MapNotes_Data) and (not MetaMapNotes_Data) and (not BWP_Hide.WarningDisplayed) then
		message("Warning \nMapNotes/MetaMapNotes/CT_MapMod\n Not Detected! You must Have one of these\nmods in order to Unlock BetterWaypoints\nTrue Potential")
		Abnormal_NoMods:Show()
	elseif(BWP_Hide) and (BWP_Hide.WarningDisplayed) then Abnormal_NoMods:SetChecked(1)
	end
	if(BWP_Hide.TitanUndock) then Abnormal_TitanBWP:SetChecked(1) end

	if(CT_UserMap_Notes) then Abnormal_CT_CheckText:SetText(BWP_CT_CheckText); Abnormal_CT_Check:Show() end
	
	if(TitanPlugins)then Abnormal_TitanBWPText:SetText(BWP_Titan_UndockText) ;Abnormal_TitanBWP:Show() end
	if(MapLibrary) then 
		DistDisplayCheckOption:ClearAllPoints()
		DistDisplayCheckOption:SetPoint("TOPLEFT","BetterWaypointsOptionsForm","TOPLEFT", 27, -65)
		DistDisplayCheckOptionText:SetText(BWP_DistanceText_Meters)
		DistDisplayCheckOption_YardsText:SetText(BWP_DistanceText_Yards)
		DistDisplayCheckOption_Yards:Show()
		if(not BWP_Hide.Yards) then
			DistDisplayCheckOption_Yards:SetChecked(1)
			DistDisplayCheckOption:SetChecked(0)
		end
		
	end
	abnormalmenuresized = 1
	
	
end
--Set up Mini Menu
function BWP_MiniDropMenu_OnLoad()
   UIDropDownMenu_Initialize(this, BWP_MiniDropMenu_Initialize);
  
   UIDropDownMenu_SetWidth(90, BWP_MiniDropMenu);
end 
--Initialize minimenu with options
function BWP_MiniDropMenu_Initialize()
	
	local info;
	if(tempitem_XBWP) then -- Make sure you have a valid object
	   if(tempitem_XBWP.X and tempitem_XBWP.Y) then -- Make sure X and Y coords Exist(means were in same zone)
		   info = {};
		   info.text = SetasWAYPOINT1of2..tempitem_XBWP.Name..SetAsWayPoint_End; --Option message "Set"..$name.."as waypoint"
		   info.func = QuickSetMiniMenu; -- Function to set as destination
		   info.value = tempitem_XBWP --Pass the object value
		   tempitem_XBWP = nil
		   UIDropDownMenu_AddButton(info);
		else --X and Y dont Exist so its not in out current zone
			info = {};
		   info.text = SetWP_ErrorString1of2..tempitem_XBWP.Name..SetAsWayPoint_End; --non click message "Must be in same zone blah blah"
			info.isTitle = 1
		   
		   tempitem_XBWP = nil
		   UIDropDownMenu_AddButton(info);
		end
	end
end
--sets a mininote from the value passed by the mini menu
function  QuickSetMiniMenu()
	UIDropDownMenu_SetText(this.value.Name, BetterWaypointsMenuFrame_DropDown)
	setmininote(this.value.X,this.value.Y,this.value.Name)
end

--[[Hooked Functions
]]--
--MetaMap Hooks
function BWPHook_MetaMap()
		--hook right click for minimenu drop on Knowledge Base
		local BWP_oldMetaKBScrollclick = MetaKB_ScrollFrameButtonOnClick
		function MetaKB_ScrollFrameButtonOnClick(button)
			if(button == "RightButton") then button = "" end

			local name = getglobal("MetaKB_ScrollFrameButton"..this:GetID().."Name"):GetText();
			local zone = getglobal("MetaKB_ScrollFrameButton"..this:GetID().."Coords"):GetText();
			
			local _,_,x,y= string.find(zone, "%((.*)%,(.*)%)") --Parse it format (XX,YY) when its in same zone
			local cx, cy = GetCursorPosition();
			
			BWP_MiniDropMenu:ClearAllPoints()
			BWP_MiniDropMenu:SetPoint("BOTTOM","UIParent","BOTTOMLEFT", cx, cy)
			
			tempitem_XBWP ={X = tonumber(x),Y = tonumber(y) ,Name = name} --call our minimenu (only option is to set waypoint)
			BWP_oldMetaKBScrollclick(button)
			ToggleDropDownMenu(1,1,BWP_MiniDropMenu)
		end
		
		--hook right click on map note to drop down mini menu
		local BWP_oldMetaMapNotes_Note_OnClick = MetaMapNotes_Note_OnClick
		function MetaMapNotes_Note_OnClick(button, id)
			BWP_oldMetaMapNotes_Note_OnClick(button, id)
			MapNoteMenuOverride(button,id,"MetaMapNotes")
		end
end
--CTMAP HOOKS
function BWPHook_CTMap()
	
	local BWP_oldCT_MapMod_OnClick = CT_MapMod_OnClick
	function CT_MapMod_OnClick(btn)
		
		local cx, cy = GetCursorPosition();
		BWP_MiniDropMenu:ClearAllPoints()
		BWP_MiniDropMenu:SetPoint("BOTTOM","WorldMapFrame","BOTTOMLEFT", cx, cy)
		
		if(btn == "LeftButton") then
			if(GetRealZoneText() == WorldMapZoneDropDownText:GetText()) then
				tempitem_XBWP = {X = CT_UserMap_Notes[WorldMapZoneDropDownText:GetText()][this.id].x ,Y = CT_UserMap_Notes[WorldMapZoneDropDownText:GetText()][this.id].y,Name = CT_UserMap_Notes[WorldMapZoneDropDownText:GetText()][this.id].name}
			else tempitem_XBWP = {Name = CT_UserMap_Notes[WorldMapZoneDropDownText:GetText()][this.id].name} end
		end
		ToggleDropDownMenu(1,1,BWP_MiniDropMenu)
		BWP_oldCT_MapMod_OnClick(btn)
	end
		
	
end
--TitanHooks
function BWPHook_Titan()
		local old_TitanPanel_AddButton = TitanPanel_AddButton
		function TitanPanel_AddButton(msg)
			if(msg == "BWP") then
				BWP_Hide.TitanUndock = nil
				BetterWaypointsMenuFrame:Hide() 
				BWPMiniMapButtonFrame:Hide() 
				Abnormal_TitanBWP:SetChecked(0)
				BWPUndockButton:SetText(BWP_Titan_UndockText)
			end
			old_TitanPanel_AddButton(msg)
		end
		local old_TitanPanel_RemoveButton = TitanPanel_RemoveButton
		function TitanPanel_RemoveButton(msg)
			if(msg == "BWP") then
					
				BWP_Hide.TitanUndock = 1
				if(BWP_Hide.Undocked) then 
					BetterWaypointsMenuFrame:Show()
					BWPUndockButton:SetText(BWP_Dock)
				else
					BWPMiniMapButtonFrame:Show() 
					BWPUndockButton:SetText(BWP_Undock)
				end
				BWPMiniMapButtonFrame:Hide() 
				Abnormal_TitanBWP:SetChecked(1)
			
			end
		old_TitanPanel_RemoveButton(msg)
	end
end
function BWP_InitializeSavedVariables()
	if (not BWP_Hide) then -- IF our Saved Variable hasnt been used(only case this should happen is first load
		BWP_Hide = {} --Establish the saved variable
		BWP_Hide.TitanUndock = 1;  --Undock Titan
		BWP_ToggleDocking()  -- Toggle docking (not sure why i need to)
	end 
	if(not BWP_Hide.ClearDistance) then BWP_Hide.ClearDistance = 0.0040 end --set the default cleardistance if one is not assinged
	if(BWP_Hide.Undocked) then  --If The Menu is Currently Undocked 
		BWP_UndockMini()
	else BWPUndockButton:SetText(BWP_Undock) -- Otherwise Set the Text to Undocking text on the options button
	end
	if(TitanPlugins) and (not BWP_Hide.TitanUndock) then -- Titan Docking Sequence
			
		TitanPanel_AddButton("BWP")
		BetterWaypointsMenuFrame:Hide() 
		BWPMiniMapButtonFrame:Hide() 
		BWPUndockButton:SetText(BWP_Titan_UndockText)
	end
	if(BWP_Hide) and (BWP_Hide.TitanUndock) then Abnormal_TitanBWP:SetChecked(1) else Abnormal_TitanBWP:SetChecked(0) end
	if(BWP_Hide) and (BWP_Hide.WarningDisplayed) then Abnormal_NoMods:SetChecked(1) else Abnormal_NoMods:SetChecked(0) end

end
function BWP_UndockMini()

		BWPMiniMapButtonFrame:Hide()
		BetterWaypointsMenuFrame:Show()
		BetterWaypointsMenuFrame_DropDown:Show()
		BWPUndockButton:SetText(BWP_Dock)
		BWP_Hide.Undocked  = 1
		
end
function BWP_DockMini()

	BWPMiniMapButtonFrame:Show()
	BWPMiniMapButtonFrame:SetFrameStrata("High")
	BetterWaypointsMenuFrame:SetFrameStrata("Low")
	
	BetterWaypointsMenuFrame:Hide()
	BetterWaypointsMenuFrame_DropDown:Hide()
	BWPUndockButton:SetText(BWP_Undock)
	BWP_Hide.Undocked = nil
end	
function MapNoteMenuOverride(button,id,addonID)
				if(button == "RightButton") then
				
				if(not getglobal(addonID.."_FramesHidden")()) then return; end
				local currentZone
				local continent = GetCurrentMapContinent()
				local zone
				
				if continent == -1 then
					if(MetaMapNotes_Data) then
					currentZone = MetaMapNotes_Data[GetRealZoneText()]
					zone = -1
					end
				else
					zone = getglobal(addonID.."_ZoneShift")[continent][GetCurrentMapZone()]
					currentZone = getglobal(addonID.."_Data")[continent][zone]
				end
				if(getglobal(addonID.."Frame")) and (getglobal(addonID.."Frame"):IsVisible()) then
					continent = 0;
					zone = getglobal(addonID.."Options").MetaMapZone;
					currentZone = getglobal(addonID.."_Data")[continent][zone];
				end
				
				if not currentZone then	return end
				
				local localzones = {GetMapZones(GetCurrentMapContinent())}
				 --Make Sure were in the zone the map is set to
				if(localzones[GetCurrentMapZone()] == GetRealZoneText())then tempitem_XBWP ={X = currentZone[id].xPos,Y = currentZone[id].yPos ,Name = currentZone[id].name} --call our minimenu (only option is to set waypoint)
				else tempitem_XBWP = {Name = currentZone[id].name} -- If its not same zone only assign name
				end	
				
				
				ToggleDropDownMenu(1,1,BWP_MiniDropMenu,"cursor",-150,0)
			end
end

function BWPHook_MN()
	local BWP_oldMapNotes_Note_OnClick = MapNotes_Note_OnClick
		function MapNotes_Note_OnClick(button, id)
			BWP_oldMapNotes_Note_OnClick(button, id)
			MapNoteMenuOverride(button,id,"MapNotes")
		end
end

--[[
MapNotes_ClearMiniNote()

				MapNotes_MiniNote_Data.xPos = x;
				MapNotes_MiniNote_Data.yPos = y;
				MapNotes_MiniNote_Data.continent = continent;
				MapNotes_MiniNote_Data.zone = zone;
				MapNotes_MiniNote_Data.id = id; -- only shown if the note was written...
				MapNotes_MiniNote_Data.name = name;
				MapNotes_MiniNote_Data.color = 0;
				MapNotes_MiniNote_Data.icon = icon;
				MiniNotePOITexture:SetTexture("Interface\\AddOns\\MapNotes\\POIIcons\\Icon"..icon);
				MiniNotePOI:Show();
				MapNotes_SetNextAsMiniNote = 0;
				MapNotes_StatusPrint(MAPNOTES_SETMININOTE)


MapNotes_GetNoteBySlashCommand("c<"..cont.."> z<"..zone.."> x<"..x.."> y<"..y.."> t<"..name.."> i1<> i2<> cr<GuardNote> i<9> tf<0> i1f<0> i2f<0>")
]]--
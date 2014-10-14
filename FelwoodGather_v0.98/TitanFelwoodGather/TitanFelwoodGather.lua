TITAN_FELWOODGATHER_ID = "FelwoodGather";
TITAN_FELWOODGATHER_FREQUENCY = 0.5;
TITAN_FELWOODGATHER_TOOLTIP=TITAN_FELWOODGATHER_ID;

function TitanPanelFelwoodGatherButton_OnLoad()
	this.registry = { 
		id = TITAN_FELWOODGATHER_ID,
		menuText = TITAN_FELWOODGATHER_MENU_TEXT, 
		buttonTextFunction = "TitanPanelFelwoodGatherButton_GetButtonText",
		tooltipTitle = TITAN_FELWOODGATHER_TOOLTIP, 
		tooltipTextFunction = "TitanPanelFelwoodGatherButton_GetTooltipText", 
		frequency = TITAN_FELWOODGATHER_FREQUENCY, 
		updateType = TITAN_PANEL_UPDATE_BUTTON;
		icon = TFWG_WRT_TEXTURE;
		iconWidth = 16,
		savedVariables = {
			ShowZoneText = 1,
			ShowIcon = 1,
			ShowCoordsText = 1,
			ShowTimer = 1,
		}
	};

end 

function TitanPanelFelwoodGatherButton_GetButtonText(id)
	local button, id = TitanUtils_GetButton(id, true);
	local etatext;
	local text = "";
	Obj = FelwoodGather_GetLatestObject();
	if (Obj ~= nil ) then
		local buton, id = TitanUtils_GetButton(TITAN_FELWOODGATHER_ID, true);
		button.registry.icon = Obj.texture;
		eta = (Obj.timer + 1500 ) - GetTime();
		d, h, m, s = ChatFrame_TimeBreakDown(eta);
		etatext = format("%02d:%02d ", m, s);
	else
		etatext = TFWG_NO_TIMER;
	end;
	if( TitanGetVar(TITAN_FELWOODGATHER_ID, "ShowTimer") == 1 ) then 
		text = text .. etatext;
	end

	if ( (Obj ~= nil) and (TitanGetVar(TITAN_FELWOODGATHER_ID, "ShowZoneText") == 1) ) then
		text = text .. Obj.location;
	end
	if ( (Obj ~= nil) and (TitanGetVar(TITAN_FELWOODGATHER_ID, "ShowCoordsText") == 1) ) then
		text = text .. format("(%d, %d)", Obj.x, Obj.y);
	end

	local locationRichText;
	if ( Obj ~= nil ) then
		if (Obj.status == 2 ) then
			locationRichText = TitanUtils_GetRedText(text);
		elseif (Obj.status == 1 ) then
			locationRichText = TitanUtils_GetNormalText(text);
		else
			locationRichText = TitanUtils_GetGreenText(text);
		end
	else 
		locationRichText = TitanUtils_GetNormalText(text);
	end
	return TITAN_FELWOODGATHER_BUTTON_LABEL, locationRichText;
end
function sortFunc(a,b)
	return a.eta < b.eta;
--[[
	return ((string.byte(a, 1) < string.byte(b,1))
		or (string.byte(a, 2) < string.byte(b,2))
		or (string.byte(a, 4) < string.byte(b,4))
		or (string.byte(a, 5) < string.byte(b,5))
	);
--]]
end
function TitanPanelFelwoodGatherTipsLine(Objs, eta)
	d, h, m, s = ChatFrame_TimeBreakDown(eta);
	text = string.format("%02d:%02d\t%s - %s(%d, %d)\n",
		m, s, Objs.item, Objs.location, Objs.x, Objs.y);
	if (Objs.status == 2 ) then
		locationRichText = TitanUtils_GetRedText(text);
	elseif (Objs.status == 1 ) then
		locationRichText = TitanUtils_GetNormalText(text);
	else
		locationRichText = TitanUtils_GetGreenText(text);
	end
	return locationRichText;
end

function TitanPanelFelwoodGatherButton_GetTooltipText()
	local text = "";
	Obj = FelwoodGather_GetLatestObject();
	local Tips = {};
	curTime = GetTime();
	for n, Objs in FelwoodGather_WorldObjs do
		if ((Objs.timer ~= 0) and (Objs.timer + 1500 > curTime )) then
			eta = Objs.timer + 1500 - curTime;
			local Tip = {};
			Tip.eta = eta;
			Tip.richText = TitanPanelFelwoodGatherTipsLine(Objs, eta);
			table.insert(Tips, Tip);
		end
	end

	if(table.getn(Tips)> 0) then
		table.sort(Tips, sortFunc);

		for n, tiptext in Tips do
			text = text .. tiptext.richText;
		end
	else
		text = "";
	end
	return text;
end

function TitanPanelFelwoodGatherButton_OnEvent()
end

function TitanPanelFelwoodGatherButton_OnClick(button)
end

function TFelwoodGather_Menu_Announce()
	Objs = FelwoodGather_GetLatestObject();
	if ( (Objs ~= nil) and (Objs.timer ~= 0) ) then
		local eta = (Objs.timer + 1500) - GetTime();
		FelwoodGather_NotifyEstimate(Objs, eta, true);
	end
end
function TFelwoodGather_Menu_Count()
	FelwoodGather_PickupCountDown(true);
end


function TitanPanelRightClickMenu_PrepareFelwoodGatherMenu()
	TitanPanelRightClickMenu_AddTitle(TitanPlugins[TITAN_FELWOODGATHER_ID].menuText);
	
	local info = {};

	info.func = TFelwoodGather_Menu_Announce;
	info.text = TFWG_MENU_ANNOUNCE;
	UIDropDownMenu_AddButton(info);

	info = {};
	info.func = FelwoodGather_ShareTimer;
	info.text = TFWG_MENU_SHARE_TIMER;
	UIDropDownMenu_AddButton(info);

	info = {};
	info.func = TFelwoodGather_Menu_Count;
	info.text = TFWG_MENU_COUNT;
	UIDropDownMenu_AddButton(info);

	TitanPanelRightClickMenu_AddSpacer();

	local info = {};
	info.text = TFWG_MENU_SHOW_TIMER;
	info.func = TitanPanelFelwoodGatherButton_ToggleDisplayTimer;
	info.checked = TitanGetVar(TITAN_FELWOODGATHER_ID, "ShowTimer");
	UIDropDownMenu_AddButton(info);

	info = {};
	info.text = TFWG_MENU_SHOW_SUBZONE;
	info.func = TitanPanelCoordsButton_ToggleDisplayLocation;
	info.checked = TitanGetVar(TITAN_FELWOODGATHER_ID, "ShowZoneText");
	UIDropDownMenu_AddButton(info);

	info = {};
	info.text = TFWG_MENU_SHOW_COORDS;
	info.func = TitanPanelCoordsButton_ToggleDisplayCoords;
	info.checked = TitanGetVar(TITAN_FELWOODGATHER_ID, "ShowCoordsText");
	UIDropDownMenu_AddButton(info);

	TitanPanelRightClickMenu_AddSpacer();
	info = {};
	info.text = TFWG_MENU_SHOW_CONFIG;
	info.func = FelwoodGather_ToggleConfigWindow;
	UIDropDownMenu_AddButton(info);

	info = {};
	info.text = TFWG_MENU_SHOW_MINIMAP;
	info.func = FelwoodGatherMap_ToggleMapWindow;
	UIDropDownMenu_AddButton(info);

	TitanPanelRightClickMenu_AddSpacer();
	TitanPanelRightClickMenu_AddToggleIcon(TITAN_FELWOODGATHER_ID);	
	TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, TITAN_FELWOODGATHER_ID, TITAN_PANEL_MENU_FUNC_HIDE);
end

function TitanPanelFelwoodGatherButton_ToggleDisplayTimer() 
	TitanToggleVar(TITAN_FELWOODGATHER_ID, "ShowTimer");
	TitanPanelButton_UpdateButton(TITAN_FELWOODGATHER_ID);	
end

function TitanPanelCoordsButton_ToggleDisplayLocation() 
	TitanToggleVar(TITAN_FELWOODGATHER_ID, "ShowZoneText");
	TitanPanelButton_UpdateButton(TITAN_FELWOODGATHER_ID);	
end

function TitanPanelCoordsButton_ToggleDisplayCoords()
	TitanToggleVar(TITAN_FELWOODGATHER_ID, "ShowCoordsText");
	TitanPanelButton_UpdateButton(TITAN_FELWOODGATHER_ID);	
end

function TitanPanelFelwoodGatherButton_OnClick(arg1) 
	if (arg1 == "LeftButton" and IsShiftKeyDown()) then
		if (ChatFrameEditBox:IsVisible()) then
			Objs = FelwoodGather_GetLatestObject();
			if ( Objs ~= nil ) then
				local eta = (Objs.timer + 1500) - GetTime();
				local d, h, m, s = ChatFrame_TimeBreakDown(eta);
				local message = format(TFWG_NOTIFY_MESSAGE, Objs.item, m, s, Objs.location);
				ChatFrameEditBox:Insert(message);
			end
		end
	end
end



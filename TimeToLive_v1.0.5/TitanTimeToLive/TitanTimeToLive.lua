TITAN_TIMETOLIVE_ID =  "TimeToLive";
TITAN_TIMETOLIVE_MENU_TEXT = "Time To Live";
TITAN_TIMETOLIVE_TOOLTIP = "Time To Live v1.0.0";
TITAN_TIMETOLIVE_BUTTON_LABEL =  "TTL: "
TITAN_TIMETOLIVE_FREQUENCY = 1;
BODY_TEXT_COLOR  = "|cffffffff";

function TitanPanelTimeToLiveButton_OnLoad()
	this.registry = { 
		id = TITAN_TIMETOLIVE_ID,
		menuText = TITAN_TIMETOLIVE_MENU_TEXT, 
		buttonTextFunction = "TitanPanelTimeToLiveButton_GetButtonText", 
		tooltipTitle = TITAN_TIMETOLIVE_TOOLTIP,
		frequency = TITAN_TIMETOLIVE_FREQUENCY, 
		savedVariables = {
			ShowLabelText = 1,  -- Default to 1
		}
	};
end

function TitanPanelTimeToLiveButton_GetButtonText(id)
	return TITAN_TIMETOLIVE_BUTTON_LABEL, COLOR(BODY_TEXT_COLOR, TitanTTLString);
end
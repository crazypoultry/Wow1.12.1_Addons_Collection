-- Version : English
-- $LastChangedBy: PattyPur $
-- $Date: 2005-08-15 $

function LocalizeEN() 

	
	
	TITAN_VOLUME2_TOOLTIP = "Volume Control";
	
	TITAN_VOLUME2_MASTER_TOOLTIP_VALUE = "Master sound volume: ";
	TITAN_VOLUME2_SOUND_TOOLTIP_VALUE = "Effects sound volume: ";
	TITAN_VOLUME2_AMBIENCE_TOOLTIP_VALUE = "Ambience sound volume: ";
	TITAN_VOLUME2_MUSIC_TOOLTIP_VALUE = "Music sound volume: ";
	
	
	TITAN_VOLUME2_TOOLTIP_HINT1 = "Hint: Left-click to adjust the"
	TITAN_VOLUME2_TOOLTIP_HINT2 = "sound volume.";
	
	TITAN_VOLUME2_CONTROL_TOOLTIP = "Volume: ";
	TITAN_VOLUME2_CONTROL_TITLE = "Volume";
	TITAN_VOLUME2_MASTER_CONTROL_TITLE = "Master";
	TITAN_VOLUME2_SOUND_CONTROL_TITLE = "Effects";
	TITAN_VOLUME2_AMBIENCE_CONTROL_TITLE = "Ambience";
	TITAN_VOLUME2_MUSIC_CONTROL_TITLE = "Music";

	TITAN_VOLUME2_CONTROL_HIGH = "High";
	TITAN_VOLUME2_CONTROL_LOW = "Low";
	TITAN_VOLUME2_MENU_TEXT = "Volumeadjust";

end

function Localize()
	LocalizeEN();

	-- Put all locale specific string adjustments here
	if ( GetLocale() == "deDE" ) then
		LocalizeDE();
	end
	if ( GetLocale() == "frFR" ) then
		LocalizeFR();
	end
end

function LocalizeFrames()
	-- Put all locale specific UI adjustments here
end

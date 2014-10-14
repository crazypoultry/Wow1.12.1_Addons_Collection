rpgoCPlocales={
	enUS={
		TEXT_SAVE="save",
		TEXT_EXPORT="export",
	};
	deDE={
		TEXT_SAVE="save",
		TEXT_EXPORT="export",
	};
	frFR={
		TEXT_SAVE="save",
		TEXT_EXPORT="export",
	};
};
local myLocale=GetLocale();
if(not rpgoCPlocales[myLocale]) then myLocale="enUS"; end
rpgo_myLocals=rpgoCPlocales[myLocale];
rpgoCPlocales=nil;
	RPGO_CP_TEXT_SAVE=rpgo_myLocals["TEXT_SAVE"];
	RPGO_CP_TEXT_EXPORT=rpgo_myLocals["TEXT_EXPORT"];
rpgo_myLocals=nil;

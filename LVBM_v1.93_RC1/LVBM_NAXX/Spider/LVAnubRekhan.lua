--La Vendetta Anub'Rekhan Raid Warning AddOn

LVBM.AddOns.AnubRekhan = {
	["Name"] = LVBM_AR_NAME,
	["Abbreviation1"] = "Anub",
	["Abbreviation2"] = "ar",
	["Abbreviation3"] = "AnubRekhan",
	["Version"] = "1.8",
	["Author"] = "Tandanu",
	["Description"] = LVBM_AR_DESCRIPTION,
	["Instance"] = LVBM_NAXX,
	["GUITab"] = LVBMGUI_TAB_NAXX,
	["Sort"] = 11,
	["Options"] = {
		["Enabled"] = true,
		["Announce"] = false,
	},
	["Events"] = {
		["CHAT_MSG_MONSTER_YELL"] = true,
		["CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS"] = true,
		["CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF"] = true,
	},	
	["OnEvent"] = function(event, arg1)
		if (event == "CHAT_MSG_MONSTER_YELL") then
			if (arg1 == LVBM_AR_YELL_1) or (arg1 == LVBM_AR_YELL_2) or (arg1 == LVBM_AR_YELL_3) then
				LVBM.Announce(string.format(LVBM_AR_LOCUST_WARNING, 90));
				LVBM.StartStatusBarTimer(90, "Locust Swarm");
				LVBM.Schedule(30, "LVBM.AddOns.AnubRekhan.OnEvent", "LocustWarning", 60);
				LVBM.Schedule(60, "LVBM.AddOns.AnubRekhan.OnEvent", "LocustWarning", 30);
				LVBM.Schedule(80, "LVBM.AddOns.AnubRekhan.OnEvent", "LocustWarning", 10);
			end
		elseif (event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF") then
			if (arg1 == LVBM_AR_CAST_LOCUST_SWARM) then
				LVBM.Announce(LVBM_AR_LOCUST_INC_WARNING);
				LVBM.EndStatusBarTimer("Locust Swarm");
				LVBM.StartStatusBarTimer(3, "Locust Swarm Cast");
				LVBM.Schedule(23, "LVBM.AddOns.AnubRekhan.OnEvent", "StartNewLocustTimer");
				LVBM.Schedule(3, "LVBM.AddOns.AnubRekhan.OnEvent", "CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS", LVBM_AR_GAIN_LOCUST_SWARM);
			end
		elseif (event == "CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS") then
			if (arg1 == LVBM_AR_GAIN_LOCUST_SWARM) and not LVBM.GetScheduleTimeLeft("LVBM.AddOns.AnubRekhan.OnEvent", "LocustEndWarning", 3) then
				LVBM.Schedule(10, "LVBM.AddOns.AnubRekhan.OnEvent", "LocustEndWarning", 10);
				LVBM.Schedule(17, "LVBM.AddOns.AnubRekhan.OnEvent", "LocustEndWarning", 3);
				LVBM.Announce(LVBM_AR_GAIN_LOCUST_WARNING);
				LVBM.EndStatusBarTimer("Locust Swarm Cast", true);
				LVBM.StartStatusBarTimer(20, "Locust Swarm");
			end
		elseif (event == "LocustWarning") then
			if arg1 and arg1 ~= 10 then
				LVBM.Announce(string.format(LVBM_AR_LOCUST_WARNING, arg1));
			else
				LVBM.Announce(LVBM_AR_LOCUST_SOON_WARNING);
			end
		elseif (event == "LocustEndWarning") then
			if arg1 then
				LVBM.Announce(string.format(LVBM_AR_LOCUST_END_WARNING, arg1));		
			end
		elseif (event == "StartNewLocustTimer") then
			LVBM.Announce(string.format(LVBM_AR_LOCUST_WARNING, 60));
			LVBM.EndStatusBarTimer("Locust Swarm");
			LVBM.StartStatusBarTimer(62, "Locust Swarm");
			LVBM.Schedule(32, "LVBM.AddOns.AnubRekhan.OnEvent", "LocustWarning", 30);
			LVBM.Schedule(52, "LVBM.AddOns.AnubRekhan.OnEvent", "LocustWarning", 10);
		end	
	end,
};

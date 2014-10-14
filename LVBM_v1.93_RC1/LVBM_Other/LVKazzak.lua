-- 
-- Lord Kazzak v1.0
--
-- todo:
-- Twisted Reflection !!! - Magic 
-- Your own streght feeds me, %s!
--

LVBM.AddOns.Kazzak = { 
	["Name"] = LVBM_KAZZAK_NAME,
	["Abbreviation1"] = "kazzak", 
	["Version"] = "1.0",
	["Author"] = "La Vendetta|Nitram",
	["Description"] = LVBM_KAZZAK_INFO,
	["Instance"] = LVBM_OTHER,
	["GUITab"] = LVBMGUI_TAB_OTHER,
	["Options"] = {  
		["Enabled"] = true,
		["Announce"] = false,
	},
	["FightStartTime"] = 0,
	["Events"] = {
		["CHAT_MSG_MONSTER_YELL"] = true,
		["CHAT_MSG_COMBAT_HOSTILE_DEATH"] = true,
	},	
	["OnEvent"] = function(event, arg1) 
		if ( (event == "CHAT_MSG_MONSTER_YELL") and ( arg1 == LVBM_KAZZAK_START_YELL ) and ( arg2 == LVBM_KAZZAK_NAME ) ) then
			LVBM.AddOns.Kazzak.FightStartTime = time();
			LVBM.EndStatusBarTimer("Supreme Mode")
			LVBM.UnSchedule("LVBM.AddOns.Kazzak.OnEvent");

			LVBM.StartStatusBarTimer(180, LVBM_KAZZAK_BAR_TEXT);
			LVBM.Schedule(90, "LVBM.AddOns.Kazzak.OnEvent", "SupremeWarning1");
			LVBM.Schedule(150, "LVBM.AddOns.Kazzak.OnEvent", "SupremeWarning2");
			LVBM.Schedule(170, "LVBM.AddOns.Kazzak.OnEvent", "SupremeWarning3");

			LVBM.Announce(LVBM_KAZZAK_ANNOUNCE_START);

		elseif ( event == "CHAT_MSG_COMBAT_HOSTILE_DEATH" ) then
			if arg1 == LVBM_KAZZAK_DIES and LVBM.AddOns.Kazzak.FightStartTime > 0 then
				LVBM.UnSchedule("LVBM.AddOns.Kazzak.OnEvent");
				LVBM.EndStatusBarTimer("Supreme Mode");

				local temptime = time() - LVBM.AddOns.Kazzak.FightStartTime;

				LVBM.Announce(string.format(LVBM_KAZZAK_ANNOUNCE_TIMENEEDED, temptime));
				LVBM.AddOns.Kazzak.FightStartTime = 0;
			end

		elseif (event == "SupremeWarning1") then
			LVBM.Announce(string.format(LVBM_KAZZAK_ANNOUNCE_SEC, 90));

		elseif (event == "SupremeWarning2") then
			LVBM.Announce(string.format(LVBM_KAZZAK_ANNOUNCE_SEC, 30));

		elseif (event == "SupremeWarning3") then
			LVBM.Announce(string.format(LVBM_KAZZAK_ANNOUNCE_SEC, 10));

		end
	end,		
};

--
-- Three Bugs (Vem, Yauj & Kri) - Optional Boss in AQ40 
-- Mod by Nitram
--

LVBM.AddOns.ThreeBugs = {
	["Name"] = LVBM_THREEBUGS_NAME,
	["Abbreviation1"] = "Bugs",
	["Version"] = "1.0",
	["Author"] = "La Vendetta|Nitram",
	["Description"] = LVBM_THREEBUGS_DESCRIPTION,
	["Instance"] = LVBM_AQ40,
	["GUITab"] = LVBMGUI_TAB_AQ40,
	["Sort"] = 2,
	["Options"] = {
		["Enabled"] = true,
		["Announce"] = false,
	},	
	["Events"] = {
		["CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE"] = true,
		["CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE"] = true,
		["CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE"] = true,
		["CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF"] = true,
	},
	["LastFear"] = 0,
	["OnEvent"] = function(event, arg1)

		if (event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF") then
			if( arg1 ~= nil and string.find(arg1, LVBM_THREEBUGS_CASTHEAL_EXPR) ) then
				LVBM.Announce(LVBM_THREEBUGS_CASTHEAL_ANNOUNCE);
				LVBM.StartStatusBarTimer(2, "Great Heal Cast");
			end
		end

		if (event == "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE"
		 or event == "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE"
		 or event == "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE") then

		 	if (time() - LVBM.AddOns.ThreeBugs.LastFear) > 10 and LVBM.AddOns.ThreeBugs.InCombat then
				local _, _, sArg1, sArg2 = string.find(arg1, LVBM_THREEBUGS_FEAR_EXPR);
				if( sArg1 ~= nil and sArg2 ~= nil ) then
					LVBM.AddOns.ThreeBugs.LastFear = time();
					LVBM.Schedule(17, "LVBM.AddOns.ThreeBugs.OnEvent", "FearIn3");	-- 20 Sec Fear

					LVBM.EndStatusBarTimer("Yauj Fear");
					LVBM.StartStatusBarTimer(20, "Yauj Fear");
				end
			end
		end

		if (event == "FearIn3") then
			LVBM.Announce(string.format(LVBM_THREEBUGS_FEAR_ANNOUNCE, 3));
		end


	end,
	
};

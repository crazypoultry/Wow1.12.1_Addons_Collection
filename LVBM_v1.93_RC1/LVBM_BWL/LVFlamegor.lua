LVBM.AddOns.Flamegor = {
	["Name"] = LVBM_FLAMEGOR_NAME,
	["Version"] = "1.0",
	["Author"] = "Tandanu",
	["Description"] = LVBM_FLAMEGOR_DESCRIPTION,
	["Instance"] = LVBM_BWL,
	["GUITab"] = LVBMGUI_TAB_BWL,
	["Sort"] = 6,
	["Options"] = {
		["Enabled"] = true,
		["Announce"] = false,
		["Frenzy"] = true,
	},
	["DropdownMenu"] = {
		[1] = {
			["variable"] = "LVBM.AddOns.Flamegor.Options.Frenzy",
			["text"] = LVBM_FLAMEGOR_ANNOUNCE_FRENZY,
			["func"] = function() LVBM.AddOns.Flamegor.Options.Frenzy = not LVBM.AddOns.Flamegor.Options.Frenzy; end,
		},
	},
	["Events"] = {
		["CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE"] = true,
		["CHAT_MSG_MONSTER_EMOTE"] = true,
	},
	["OnCombatStart"] = function(delay)
		LVBM.StartStatusBarTimer(31 - delay, "Wing Buffet");
		LVBM.Schedule(28 - delay, "LVBM.AddOns.Flamegor.OnEvent", "WingBuffetWarning", 3);
	end,
	["OnEvent"] = function(event, arg1)
		if event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE" then
			if arg1 == LVBM_FLAMEGOR_WING_BUFFET then
				LVBM.Announce(string.format(LVBM_WING_BUFFET_WARNING, 1))
				LVBM.StartStatusBarTimer(1, "Wing Buffet Cast");
				LVBM.Schedule(29, "LVBM.AddOns.Flamegor.OnEvent", "WingBuffetWarning", 3);
				LVBM.Schedule(1, "LVBM.AddOns.Flamegor.OnEvent", "WingBuffetWarning", 31);
			elseif arg1 == LVBM_FLAMEGOR_SHADOW_FLAME then
				LVBM.Announce(LVBM_SHADOW_FLAME_WARNING);
				LVBM.StartStatusBarTimer(2, "Shadow Flame Cast");
			end
		elseif event == "WingBuffetWarning" then
			if arg1 == 3 then
				LVBM.Announce(string.format(LVBM_WING_BUFFET_WARNING, 3));
			elseif arg1 == 31 then
				LVBM.EndStatusBarTimer("Wing Buffet");
				LVBM.StartStatusBarTimer(31, "Wing Buffet");
			end
		elseif event == "CHAT_MSG_MONSTER_EMOTE" then
			if arg1 == LVBM_FLAMEGOR_FRENZY and arg2 == LVBM_FLAMEGOR_FLAMEGOR then
				LVBM.EndStatusBarTimer("Frenzy")
				LVBM.StartStatusBarTimer(9, "Frenzy");
				if LVBM.AddOns.Flamegor.Options.Frenzy then
					LVBM.Announce(LVBM_FLAMEGOR_FRENZY_ANNOUNCE);
				end
			end
		end
	end,
};

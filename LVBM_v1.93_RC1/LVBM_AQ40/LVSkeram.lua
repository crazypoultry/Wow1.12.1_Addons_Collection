
-- End Yell :  You only delay the inevitable!

LVBM.AddOns.Skeram = {
	["Name"] = LVBM_SKERAM_NAME,
	["Abbreviation1"] = "Prophet",
	["Version"] = "1.5",
	["Author"] = "Tandanu",
	["Description"] = LVBM_SKERAM_DESCRIPTION,
	["Instance"] = LVBM_AQ40,
	["GUITab"] = LVBMGUI_TAB_AQ40,
	["Sort"] = 1,
	["Options"] = {
		["Enabled"] = true,
		["Announce"] = false,
	},	
	["Events"] = {
		["CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE"] = true,
	},
	["CharmedPlayers"] = {};
	["OnEvent"] = function(event, arg1)
		if (event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE") then
			if (arg1 == LVBM_SKERAM_CAST_SPELL_AE) then
				LVBM.Announce(LVBM_SKERAM_AE);
	--			LVBM.StartStatusBarTimer(1.5, "Arcane Explosion Cast"); --timer?
			end
		elseif (event == "ClearMindControl") and type(arg1) == "string" then
			LVBM.AddOns.Skeram.CharmedPlayers[arg1] = nil;
		end
	end,		
	["OnUpdate"] = function(elapsed)
		if GetRealZoneText() ~= LVBM_AQ40 then
			return;
		end
		for i = 1, GetNumRaidMembers() do
			if LVBM.GetDebuff("raid"..i, LVBM_SKERAM_MIND_CONTROL_DEBUFF) and (not LVBM.AddOns.Skeram.CharmedPlayers[UnitName("raid"..i)]) then
				LVBM.AddOns.Skeram.CharmedPlayers[UnitName("raid"..i)] = true;
				LVBM.Schedule(21, "LVBM.AddOns.Skeram.OnEvent", "ClearMindControl", UnitName("raid"..i));
				LVBM.Announce(string.format(LVBM_SKERAM_MC, UnitName("raid"..i)));
			end
		end
	end,
	["UpdateInterval"] = 0.66,
};

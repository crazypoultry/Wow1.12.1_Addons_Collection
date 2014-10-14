--
-- Developement AddOn for La Vendetta Boss Mods (dry testing)
--

LVBM.AddOns.Developement = { 
	["Name"] = "Developement (Test Studio)", 
	["Abbreviation1"] = "dev", 
	["Version"] = "0.1", 
	["Author"] = "Nitram",
	["Description"] = "Allow test of new BossMod features without fighting against Bosses.",
	["Instance"] = LVBM_OTHER,
	["GUITab"] = LVBMGUI_TAB_OTHER,
	["Sort"] = 0,
	["Options"] = {
		["Enabled"] = false, 
		["Announce"] = false, 
	}, 
	["Events"] = {
		["CHAT_MSG_SAY"] = true, 	-- We want to Start with "/s Boooom!" or some stuff
	}, 	
	["OnEvent"] = function(event,  arg1)

		if (event == "CHAT_MSG_SAY" and arg1 == "boom") then
			
			LVBM.StartStatusBarTimer(10, "Try LVBM");
			
		end
	end,
};



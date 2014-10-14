
LVBM.AddOns.Maexxna = {
	["Name"] = LVBM_MAEXXNA_NAME,
	["Abbreviation1"] = "Maex",
	["Abbreviation2"] = "Maexx",
	["Abbreviation3"] = "Mae",
	["Version"] = "1.7",
	["Author"] = "Tandanu",
	["Description"] = LVBM_MAEXXNA_DESCRIPTION,
	["Instance"] = LVBM_NAXX,
	["GUITab"] = LVBMGUI_TAB_NAXX,
	["Sort"] = 13,
	["Options"] = {
		["Enabled"] = true,
		["Announce"] = false,
		["Yell"] = true,
	},
	["isSpraying"] = false,
	["DropdownMenu"] = {
		[1] = {
			["variable"] = "LVBM.AddOns.Maexxna.Options.Yell",
			["text"] = LVBM_MAEXXNA_YELL_ON_WRAP,
			["func"] = function() LVBM.AddOns.Maexxna.Options.Yell = not LVBM.AddOns.Maexxna.Options.Yell; end,
		},
	},
	["Events"] = {
		["CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE"] = true,
		["CHAT_MSG_COMBAT_CREATURE_VS_CREATURE_HITS"] = true,
		["CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE"] = true,
		["CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE"] = true,
		["CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE"] = true,
		["CHAT_MSG_COMBAT_FRIENDLY_DEATH"] = true,
	},	
	["OnCombatStart"] = function(delay)
			LVBM.Schedule(25 - delay, "LVBM.AddOns.Maexxna.OnEvent", "SprayWarning", 15);
			LVBM.Schedule(35 - delay, "LVBM.AddOns.Maexxna.OnEvent", "SprayWarning", 5);
			LVBM.Schedule(25 - delay, "LVBM.AddOns.Maexxna.OnEvent", "SpiderWarning", 5);
			LVBM.Schedule(30 - delay, "LVBM.AddOns.Maexxna.OnEvent", "SpiderWarning", 0);
			LVBM.StartStatusBarTimer(40 - delay, "Web Spray");
			LVBM.StartStatusBarTimer(30 - delay, "Spider Spawn");
	end,
	["OnEvent"] = function(event, arg1)
		if (event == "CHAT_MSG_COMBAT_CREATURE_VS_CREATURE_HITS" 
		    or event == "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE" 
		    or event == "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE" 
		    or event == "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE") then
			if (string.find(arg1, LVBM_MAEXXNA_WEB_SPRAY) and (not LVBM.AddOns.Maexxna.isSpraying)) then			
				LVBM.Schedule(25, "LVBM.AddOns.Maexxna.OnEvent", "SprayWarning", 15);
				LVBM.Schedule(35, "LVBM.AddOns.Maexxna.OnEvent", "SprayWarning", 5);
				LVBM.Schedule(25, "LVBM.AddOns.Maexxna.OnEvent", "SpiderWarning", 5);
				LVBM.Schedule(30, "LVBM.AddOns.Maexxna.OnEvent", "SpiderWarning", 0);
				LVBM.StartStatusBarTimer(40, "Web Spray");
				LVBM.StartStatusBarTimer(30, "Spider Spawn");
				
				LVBM.AddOns.Maexxna.isSpraying = true;
				LVBM.Schedule(10, "LVBM.AddOns.Maexxna.OnEvent", "ResetIsSpraying"); 
			end
         
			local _, _, playerName = string.find(arg1, LVBM_MAEXXNA_WEB_WRAP_REGEXP);
			if playerName == LVBM_YOU then
				playerName = UnitName("player");
				if LVBM.AddOns.Maexxna.Options.Yell then
					for i = 1, GetNumRaidMembers() do
						local name, rank, subgroup;
						name, rank, subgroup = GetRaidRosterInfo(i)
						if name == UnitName("player") then
							SendChatMessage(string.format(LVBM_MAEXXNA_WEB_WRAP_YELL, name, subgroup), "YELL");
							break;
						end
					end
				end
			end
			if (playerName) then
				LVBM.Announce(string.format(LVBM_MAEXXNA_WRAP_WARNING, tostring(playerName)));
			end		
		elseif event == "ResetIsSpraying"  then
			LVBM.AddOns.Maexxna.isSpraying = false;			
		elseif event == "SprayWarning" then
			if arg1 then
				LVBM.Announce(string.format(LVBM_MAEXXNA_SPRAY_WARNING, arg1));
			end
		elseif event == "SpiderWarning" then
			if arg1 and arg1 > 0 then
				LVBM.Announce(string.format(LVBM_MAEXXNA_SPIDER_WARNING, arg1));
			elseif arg1 == 0 then
				LVBM.Announce(LVBM_MAEXXNA_SPIDERS_SPAWNED);
			end
		end      
   end,   
};

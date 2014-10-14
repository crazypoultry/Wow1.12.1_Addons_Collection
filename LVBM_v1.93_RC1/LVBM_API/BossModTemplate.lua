if (GetLocale() == "enGB") or (GetLocale() == "enUS") then	
	TMP_YELL_1 = "";
	TMP_YELL_2 = "";	
	TMP_YELL_3 = "";
	TMP_EMOTE_1 = "";
	TMP_EMOTE_2 = "";
	TMP_CAST_SPELL_1 = "";
	TMP_CAST_SPELL_2 = "";
	TMP_GAIN_BUFF_1 = "";
	TMP_GAIN_BUFF_2 = "";	
end

LVBM.AddOns.Template = { --the table index (here: Template) must be the filename..."LV" as prefix in the filename will be ignored
	["Name"] = "Template",
	["Abbreviation1"] = "tmp", --optional; used as slash command alias...you dont have to set optional values...just delete them if you dont need them
	["Abbreviation2"] = "", --optional
	["Abbreviation3"] = "", --optional
	["Version"] = "1.0",
	["Author"] = "Tandanu",
	["Description"] = "",
	["MinVersionToSync"] = 1.91,	-- Dont accept Sync Messages from Clients older than x.xx
	["SlashCmdHelpText"] = { --optional, this text will be displayed when typing /template without arguments or with invalid/unknown arguments
		[1] = "first line",  -- you dont need a help text for enable/disable addon, enable/disable announce and stop timers, a standard help text is generated automatically
		[2] = "second line",
	},
	["Instance"] = LVBM_NAXX|LVBM_BWL|LVBM_MC..etc, --the onevent and onupdate functions will only be called if you are in the zone. If you want to enable your mod everywhere, use LVBM_OTHER as zone
	["GUITab"] = LVBMGUI_TAB_NAXX|BWL|MC..etc,
	["Sort"] = 0,
	["Options"] = {  --this table will be saved
		["Enabled"] = true,
		["Announce"] = false,
	},
	["DropdownMenu"] = { --optional, enable/disable boss mod and announce buttons will be created automatically
		[1] = {
			["variable"] = "LVBM.AddOns.Template.Options.BooleanVariable", --a string which contains the name of a boolean variable, used to check the button or not
			["text"] = "Set Option xyz",
			["func"] = function() LVBM.AddOns.Template.Options.BooleanVariable = not LVBM.AddOns.Template.Options.BooleanVariable; end,
			--you can use every button attribute that is supported by blizzards UIDropDownMenu_AddButton(info) function...see comment in FrameXML\UIDropDownMenu.lua or LVBM_GUI.lua (line 59 et sqq.)
		}, 
	},	
	["Events"] = {
		["CHAT_MSG_MONSTER_YELL"] = true,
		["CHAT_MSG_MONSTER_EMOTE"] = true,
		["CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE"] = true,
		["CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF"] = true,
		["CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS"] = true,
	},	
	
	["OnLoad"] = function() end, --optional, you dont need standard things like registering slash commands/events, onload messages, etc....this is all done by the API
	["OnSlashCommand"] = function(msg) end, --optional, the commands /template on/off /template announce on/off and /template stop will be created automatically. If this function does not return true the help text will be displayed
	["OnCombatStart"] = function(delay) end, --optional, this function will be called when the boss is pulled. The boss mod needs to be registered in the boss table LVBM.Bosses[localized instance name][boss ID, see bosses.lua for IDs].BossMods. Just insert this boss mods table index in this table OnLoad. The call of this function may be delayed because UnitAffectingCombat("mobUnitID") is sometimes not available directly after a pull. The function receives the delay in seconds as the first argument. It will be 0 if the boss mod is started by a yell or emote. Again, see Bosses.lua for details
	["OnCombatEnd"] = function() end, --called when combat ends...only available if the boss mod is registered in the boss mod table, see OnCombatStart
	["OnEvent"] = function(event, arg1) --you don't need to check if the addon is enabled...this function will not be called if Options.Enabled is set to false or nil
		if (event == "CHAT_MSG_MONSTER_YELL") then
			if (arg1 == TMP_YELL_1) or (arg1 == TMP_YELL_2) or (arg1 == TMP_YELL_3) then -- mob yells something (= pull)
				LVBM.Announce("***  ***");
				LVBM.Schedule(0, "LVBM.AddOns.Template.OnEvent", "Warning", 0);
				LVBM.StartStatusBarTimer(0, "Pulled!");
			end
		elseif (event == "CHAT_MSG_MONSTER_EMOTE") then -- emote
			if arg1 == TMP_EMOTE_1 and arg2 == "Template" then
				LVBM.Announce("***  ***");
				LVBM.Schedule(0, "LVBM.AddOns.Template.OnEvent", "Warning", 0);
				LVBM.StartStatusBarTimer(0, "Emote");
			end
		elseif (event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE") or (event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF") then -- mob casts a spell
			if (arg1 == TMP_CAST_SPELL_1) then
				LVBM.Announce("*** Spell inc - x sec ***");
			elseif (arg1 == TMP_CAST_SPELL_2) then
				LVBM.Announce("*** Spell inc - x sec ***");
			end
		elseif (event == "CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS") then -- mob gains a buff
			if (arg1 == TMP_GAIN_BUFF_1) then
				LVBM.Announce("***  ***");				
			end
		elseif (event == "Warning") then
			if arg1 == 0 then
				LVBM.Announce("***  ***");
			elseif arg1 == 0 then
				LVBM.Announce("***  SEC ***");
			end
		end
	end,
	["OnStop"] = function() end, --optional,	
	["OnUpdate"] = function(elapsed) end, --optional
	["UpdateInterval"] = 0.25, --optional
};

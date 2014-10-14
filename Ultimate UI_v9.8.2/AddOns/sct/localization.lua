--Version
SCT_Version = "v4.1";
SCT_EXAMPLE = "SCT";
SCT_MSG_EXAMPLE = "SCT Message";

--Everything From here on would need to be translated and put
--into if statements for each specific language.

--***********
--ENGLISH
--***********

-- Static Messages
SCT_LowHP= "Low Health!";					-- Message to be displayed when HP is low
SCT_LowMana= "Low Mana!";					-- Message to be displayed when Mana is Low
SCT_SelfFlag = "*";								-- Icon to show self hits
SCT_Combat = "+Combat";						-- Message to be displayed when entering combat
SCT_NoCombat = "-Combat";					-- Message to be displayed when leaving combat
SCT_ComboPoint = "CP";			  		-- Message to be displayed when gaining a combo point
SCT_FiveCPMessage = "Finish It!"; -- Message to be displayed when you have 5 combo points
SCT_ExecuteMessage = "Execute Now!"; -- Message to be displayed when time to execute
SCT_WrathMessage = "Hammer of Wrath Now!"; -- Message to be displayed when time Wrath

--Option messages
SCT_STARTUP = "Scrolling Combat Text "..SCT_Version.." AddOn loaded. Type /sct for options.";
SCT_Option_Crit_Tip = "Make this event always appear as a CRITICAL.";
SCT_Option_Msg_Tip = "Make this event always appear as a MESSAGE. Overrides Criticals.";

--nouns
SCT_TARGET = "Target ";
SCT_PROFILE = "SCT Profile Loaded: |cff00ff00";
SCT_PROFILE_DELETE = "SCT Profile Deleted: |cff00ff00";
SCT_PROFILE_NEW = "SCT New Profile Created: |cff00ff00";
SCT_WARRIOR = "Warrior";
SCT_ROGUE = "Rogue";
SCT_HUNTER = "Hunter";
SCT_MAGE = "Mage";
SCT_WARLOCK = "Warlock";
SCT_DRUID = "Druid";
SCT_PRIEST = "Priest";
SCT_SHAMAN = "Shaman";
SCT_PALADIN = "Paladin";

--Useage
SCT_DISPLAY_USEAGE = "Useage: \n";
SCT_DISPLAY_USEAGE = SCT_DISPLAY_USEAGE .. "/sctdisplay 'message' (for white text)\n";
SCT_DISPLAY_USEAGE = SCT_DISPLAY_USEAGE .. "/sctdisplay 'message' red(0-10) green(0-10) blue(0-10)\n";
SCT_DISPLAY_USEAGE = SCT_DISPLAY_USEAGE .. "Example: /sctdisplay 'Heal Me' 10 0 0\nThis will display 'Heal Me' in bright red\n";
SCT_DISPLAY_USEAGE = SCT_DISPLAY_USEAGE .. "Some Colors: red = 10 0 0, green = 0 10 0, blue = 0 0 10,\nyellow = 10 10 0, magenta = 10 0 10, cyan = 0 10 10";

--Event and Damage option values
SCT_OPTION_EVENT1 = {name = "Damage", tooltipText = "Enables or Disables melee and misc. (fire, fall, etc...) damage"};
SCT_OPTION_EVENT2 = {name = "Misses", tooltipText = "Enables or Disables melee misses"};
SCT_OPTION_EVENT3 = {name = "Dodges", tooltipText = "Enables or Disables melee dodges"};
SCT_OPTION_EVENT4 = {name = "Parries", tooltipText = "Enables or Disables melee parries"};
SCT_OPTION_EVENT5 = {name = "Blocks", tooltipText = "Enables or Disables melee blocks and partial blocks"};
SCT_OPTION_EVENT6 = {name = "Spell Damage", tooltipText = "Enables or Disables spell damage"};
SCT_OPTION_EVENT7 = {name = "Spell Heals", tooltipText = "Enables or Disables spell heals"};
SCT_OPTION_EVENT8 = {name = "Spell Resists", tooltipText = "Enables or Disables spell resists"};
SCT_OPTION_EVENT9 = {name = "Debuffs", tooltipText = "Enables or Disables showing when you get debuffs"};
SCT_OPTION_EVENT10 = {name = "Absorb", tooltipText = "Enables or Disables showing when monsters damage is absorbed"};
SCT_OPTION_EVENT11 = {name = "Low HP", tooltipText = "Enables or Disables showing when you have low health"};
SCT_OPTION_EVENT12 = {name = "Low Mana", tooltipText = "Enables or Disables showing when you have low mana"};
SCT_OPTION_EVENT13 = {name = "Power Gains", tooltipText = "Enables or Disables showing when you gain Mana, Rage, Energy from potions, items, buffs, etc...(Not regular regen)"};
SCT_OPTION_EVENT14 = {name = "Combat Flags", tooltipText = "Enables or Disables showing when you enter or leave combat"};
SCT_OPTION_EVENT15 = {name = "Combo Points", tooltipText = "Enables or Disables showing when you gain combo points"};
SCT_OPTION_EVENT16 = {name = "Honor Gain", tooltipText = "Enables or Disables showing when you gain Honor Contribution points"};
SCT_OPTION_EVENT17 = {name = "Buffs", tooltipText = "Enables or Disables showing when you gain buffs"};
SCT_OPTION_EVENT18 = {name = "Buff Fades", tooltipText = "Enables or Disables showing when you lose buffs"};
SCT_OPTION_EVENT19 = {name = "Execute/Wrath", tooltipText = "Enables or Disables alerting when to Execute or Hammer of Wrath (Warrior/Paladin Only)"};
SCT_OPTION_EVENT20 = {name = "Reputation", tooltipText = "Enables or Disables showing when you gain or lose Reputation"};
SCT_OPTION_EVENT21 = {name = "Your Heals", tooltipText = "Enables or Disables showing how much you heal others for"};
SCT_OPTION_EVENT22 = {name = "Skills", tooltipText = "Enables or Disables showing when you gain Skill points"};

--Check Button option values
SCT_OPTION_CHECK1 = { name = "Enable Scrolling Combat Text", tooltipText = "Enables or Disables the Scrolling Combat Text"};
SCT_OPTION_CHECK2 = { name = "Flag Combat Text", tooltipText = "Enables or Disables placing a * around all Scrolling Combat Text"};
SCT_OPTION_CHECK3 = { name = "Show Healers", tooltipText = "Enables or Disables showing who or what heals you."};
SCT_OPTION_CHECK4 = { name = "Scroll Text Down", tooltipText = "Enables or Disables scrolling text downwards"};
SCT_OPTION_CHECK5 = { name = "Sticky Crits", tooltipText = "Enables or Disables having crtical hits/heals stick above your head"};
SCT_OPTION_CHECK6 = { name = "Spell Damage Type", tooltipText = "Enables or Disables showing spell damage type"};
SCT_OPTION_CHECK7 = { name = "Apply Font to Damage", tooltipText = "Enables or Disables changing the in game damage font to match the font used for SCT Text.\n\nIMPORTANT: YOU MUST LOG OUT AND BACK IN FOR THIS TO TAKE EFFECT. RELOADING THE UI WON'T WORK"};

--Slider options values
SCT_OPTION_SLIDER1 = { name="Text Animation Speed", minText="Faster", maxText="Slower", tooltipText = "Controls the speed at which the text animation scrolls"};
SCT_OPTION_SLIDER2 = { name="Text Size", minText="Smaller", maxText="Larger", tooltipText = "Controls the size of the scrolling text"};
SCT_OPTION_SLIDER3 = { name="HP %", minText="10%", maxText="90%", tooltipText = "Controls the % of health needed to give a warning"};
SCT_OPTION_SLIDER4 = { name="Mana %",  minText="10%", maxText="90%", tooltipText = "Controls the % of mana needed to give a warning"};
SCT_OPTION_SLIDER5 = { name="Text Opacity", minText="0%", maxText="100%", tooltipText = "Controls the opacity of the text"};
SCT_OPTION_SLIDER6 = { name="Text Movement Distance", minText="Smaller", maxText="Larger", tooltipText = "Controls the movement distance of the text between each update"};
SCT_OPTION_SLIDER7 = { name="Text Center X Position", minText="-300", maxText="300", tooltipText = "Controls the placement of the text center"};
SCT_OPTION_SLIDER8 = { name="Text Center Y Position", minText="-300", maxText="300", tooltipText = "Controls the placement of the text center"};
SCT_OPTION_SLIDER9 = { name="Message Center X Position", minText="-600", maxText="600", tooltipText = "Controls the placement of the message center"};
SCT_OPTION_SLIDER10 = { name="Message Center Y Position", minText="-600", maxText="600", tooltipText = "Controls the placement of the message center"};
SCT_OPTION_SLIDER11 = { name="Message Fade Speed", minText="Faster", maxText="Slower", tooltipText = "Controls the speed that messages fade"};
SCT_OPTION_SLIDER12 = { name="Message Size", minText="Smaller", maxText="Larger", tooltipText = "Controls the size of the message text"};

--Misc option values
SCT_OPTION_MISC1 = {name="SCT Options "..SCT_Version};
SCT_OPTION_MISC2 = {name="Event Options"};
SCT_OPTION_MISC3 = {name="Text Options"};
SCT_OPTION_MISC4 = {name="Misc. Options"};
SCT_OPTION_MISC5 = {name="Warning Options"};
SCT_OPTION_MISC6 = {name="Animation Options"};
SCT_OPTION_MISC7 = {name="Select Profile"};
SCT_OPTION_MISC8 = {name="Save & Close", tooltipText = "Saves all current settings and close the options"};
SCT_OPTION_MISC9 = {name="Reset", tooltipText = "-Warning-\n\nAre you sure you want to reset SCT to defaults?"};
SCT_OPTION_MISC10 = {name="Select", tooltipText = "Select another characters profile"};
SCT_OPTION_MISC11 = {name="Load", tooltipText = "Load another characters profile for this character"};
SCT_OPTION_MISC12 = {name="Delete", tooltipText = "Delete a characters profile"}; 
SCT_OPTION_MISC13 = {name="Cancel", tooltipText = "Cancel Selection"};
SCT_OPTION_MISC14 = {name="Text", tooltipText = ""};
SCT_OPTION_MISC15 = {name="Messages", tooltipText = ""};
SCT_OPTION_MISC16 = {name="Message Options"};

--Fonts
SCT_FONTS = { 
	[1] = { name="Default", path="Fonts\\FRIZQT__.TTF"},
	[2] = { name="TwCenMT", path="Interface\\Addons\\sct\\fonts\\Tw_Cen_MT_Bold.TTF"},
	[3] = { name="Adventure", path="Interface\\Addons\\sct\\fonts\\Adventure.ttf"},
	[4] = { name="Enigma", path="Interface\\Addons\\sct\\fonts\\Enigma__2.TTF"},
}

--Animation Types
SCT_OPTION_SELECTION1 = { name="Animation Type", tooltipText = "Which animation type to use", table = {[1] = "Verticle (Normal)",[2] = "Rainbow",[3] = "Horizontal",[4] = "Angled Down"}};
SCT_OPTION_SELECTION2 = { name="Side Style", tooltipText = "How side scrolling text should display", table = {[1] = "Alternating",[2] = "Damage Left",[3] = "Damage Right"}};
SCT_OPTION_SELECTION3 = { name="Font", tooltipText = "What font to use", table = {[1] = SCT_FONTS[1].name,[2] = SCT_FONTS[2].name,[3] = SCT_FONTS[3].name,[4] = SCT_FONTS[4].name}};
SCT_OPTION_SELECTION4 = { name="Font Outline", tooltipText = "What font outline to use", table = {[1] = "None",[2] = "Thin",[3] = "Thick"}};
SCT_OPTION_SELECTION5 = { name="Message Font", tooltipText = "What font to use for messages", table = {[1] = SCT_FONTS[1].name,[2] = SCT_FONTS[2].name,[3] = SCT_FONTS[3].name,[4] = SCT_FONTS[4].name}};
SCT_OPTION_SELECTION6 = { name="Message Font Outline", tooltipText = "What font outline to use for messages", table = {[1] = "None",[2] = "Thin",[3] = "Thick"}};

-- Cosmos button
SCT_CB_NAME			= "Scrolling Combat Text".." "..SCT_Version;
SCT_CB_SHORT_DESC	= "by Grayhoof";
SCT_CB_LONG_DESC	= "Pops up useful combat messages above your head - try it!";
SCT_CB_ICON			= "Interface\\Icons\\Spell_Shadow_EvilEye"; -- "Interface\\Icons\\Spell_Shadow_FarSight"
-- English/Generic Localization
-- Translates user interface and query output to English.
-- Version 0.10.1/full

sRAB_Localization_ENUS_LANG = "English"; -- Keep this value in English
sRAB_Localization_ENUS_NATIVE = "English"; -- Localize this one instead.
sRAB_Localization_ENUS_DESCRIPTION = "RABuffs default language.";
sRAB_Localization_ENUS_CAPABILITIES = "|vui|out|book|";

sRAB_LOCALIZATION["enUS"] = function (ui, output, spells) 
 if (output) then
  sRAB_Localization_Output = "|c0000ff00English Output|r";
  sRAB_BuffOutputPrefix = "<Buffs> ";
  sRAB_BuffOutput_MissingOn = "%s is missing on";
  sRAB_BuffOutput_IsOn = "%s is on";
  sRAB_BuffOutput_EveryoneHas = "Everyone has %s.";
  sRAB_BuffOutput_EveryoneMissing = "Everyone is missing %s.";
  sRAB_BuffOutput_Group = "Group ";
  sRAB_BuffOutput_Here_Here = "Here:";
  sRAB_BuffOutput_Here_NotHere = "Not Here:";
  sRAB_BuffOutput_Here_Everyone = "Everyone is here.";
  sRAB_BuffOutput_Here_AFK = "AFK";
  sRAB_BuffOutput_Here_OOS = "Out of sight";
  sRAB_BuffOutput_Here_OFF = "Offline";
  sRAB_BuffOutput_Here_OK = "Here";
  sRAB_BuffOutput_Water_Have = "Have water:";
  sRAB_BuffOutput_Water_Out = "Out of water:";
  sRAB_BuffOutput_Water_Everyone = "Everyone has water.";
  sRAB_BuffOutput_CTRA_Recent = "Up-to-date CTRA:";
  sRAB_BuffOutput_CTRA_OutOfDate = "Outdated CTRA:";
  sRAB_BuffOutput_CTRA_Everyone = "Everyone is using an up-to-date version of CT_RaidAssist.";
  sRAB_BuffOutput_CTRA_NotInRaid = "You are not in a raid group.";
  sRAB_BuffOutput_CTRA_NoCTRA = "You are not using a compatible version of CT_RaidAssist.";
  sRAB_BuffOutput_Health_Alive = "Alive:";
  sRAB_BuffOutput_Health_Dead = "Dead:";
  sRAB_BuffOutput_Health_Misc = " (%s dead)";
  sRAB_BuffOutput_Health_EveryoneDead = "Everyone is dead.";
  sRAB_BuffOutput_Health_Default = "HP: %s / %s (%s%%)%s";
  sRAB_BuffOutput_Health_AlivePart = "; %s alive: %s.";
  sRAB_BuffOutput_Health_DeadPart = "; %s dead: %s.";
  sRAB_BuffOutput_Mana_OutOfMana = "Out of mana:";
  sRAB_BuffOutput_Mana_Fine = "OK:";
  sRAB_BuffOutput_Mana_DeadAppend = " (dead)";
  sRAB_BuffOutput_Item_Unknown = "Unknown Item (#%s)";
  sRAB_BuffOutput_Item_Have = "Wearing %s:";
  sRAB_BuffOutput_Item_Missing = "Not wearing %s:";
  sRAB_BuffOutput_Item_Everyone = "Everyone is wearing %s.";
  sRAB_BuffOutput_Item_NoOne = "No one is wearing %s.";
  sRAB_BuffOutput_BuffInfo_NoTarget = "Nothing is targeted.";
  sRAB_BuffOutput_BuffInfo_General = "[%s] Buffs: %s. Debuffs: %s.";
  sRAB_BuffOutput_BuffInfo_None = "none";
  sRAB_BuffOutput_Debuff_Have = "Affected by %s:";
  sRAB_BuffOutput_Debuff_NotHave = "Not affected by %s:";
  sRAB_BuffOutput_Debuff_Everyone = "Everyone is affected by %s.";
  sRAB_BuffOutput_Debuff_NoOne = "No one is affected by %s.";
  sRAB_BuffOutput_Debuff_Magic = "magic debuffs";
  sRAB_BuffOutput_Debuff_Curse = "curses";
  sRAB_BuffOutput_Debuff_Poison = "poisons";
  sRAB_BuffOutput_Debuff_Typeless = "typeless debuffs";
  sRAB_BuffOutput_Debuff_Disease = "diseases";
  sRAB_BuffOutput_Debuff_Curable = "debuffs I can cure";
 end
 if (ui) then
  sRAB_Localization_UI = "|c0000ff00English UI|r";
  sRAB_Settings_Welcome = "<p>RABuffs can be configured using this dialog. A list of buff queries in the 'Buffs' tab, the visual interface is configurable through the 'Layout' tab, and a list of general options is available in the 'Settings' tab.</p><br/><p>You can also use /rab and /rabq to execute addon actions without using the VUI.</p>";
  sRAB_Settings_Version = "<h2 align=\"left\">Version / localization data</h2><p>Version: %s<br/>Localization: %s (Client: %s)<br/><br/>Download updates from:<br/>|c000077ff" ..   sRAB_DownloadURL .. "|r</p>";
  sRAB_Settings_VersionNewest = " (Up to date)";
  sRAB_Settings_VersionOutdated = " (Newest: %s used by %s on %s)";
  sRAB_Settings_CastLayerGuessed = " (Guessed)";
  sRAB_Settings_TabSettings = "Settings";
  sRAB_Settings_TabBuffs = "Buffs";
  sRAB_Settings_TabLayout = "Layout";
  sRAB_Settings_Tab1Overview = "Overview";
  sRAB_Settings_Tab1Welcome = "Intro";
  sRAB_Settings_Tab1Changelog = "Recent Changes";
  sRAB_Settings_BuffList_Header = "Query listing";
  sRAB_Settings_BuffList_Description = "The list below displays all queries (buffs) RABuffs currently supports. Click on a query to view detailed information about it.";
  sRAB_Settings_BuffList_Name = "Buff Name";
  sRAB_Settings_BuffList_Query = "Query";
  sRAB_Settings_BuffList_Type = "Type";
  sRAB_Settings_BuffList_Buff = "Buff";
  sRAB_Settings_BuffList_self = "Self-buff";
  sRAB_Settings_BuffList_Groupbuff = "Buff";
  sRAB_Settings_BuffList_aura = "Aura";
  sRAB_Settings_BuffList_debuff = "Debuff";
  sRAB_Settings_BuffList_Dunno = "Custom";
  sRAB_Settings_BuffList_special = "Special";
  sRAB_Settings_BuffList_dummy = "Spell";
  sRAB_Settings_BuffList_DummyDesc = "This spell's casting data is used by another query.\n\nThis query should not be used to check for buffs.";
  sRAB_Settings_BuffList_NoUI = "This query can not be used as a bar.";
  sRAB_Settings_BuffList_ToolTip_CastBy = "cast by %s";
  sRAB_Settings_BuffList_Detail_Priority = NORMAL_FONT_COLOR_CODE .. "Class priority:|r\n%s" .. NORMAL_FONT_COLOR_CODE .. " > |reveryone else" .. NORMAL_FONT_COLOR_CODE .. ".|r";
  sRAB_Settings_BuffList_Detail_Group = NORMAL_FONT_COLOR_CODE .. "Use group version:|r\nAt least %s people.";
  sRAB_Settings_BuffList_Detail_Class = NORMAL_FONT_COLOR_CODE .. "Use class version:|r\nAt least %s people.";
  sRAB_Settings_BarList_Position = "Position";

  sRAB_Settings_Layout_Header = "Layout";
  sRAB_Settings_Layout_Description = "The list below shows the currently displayed bars. To modify or remove a bar, click on its entry in the list.";
  sRAB_Settings_Layout_AddNewBar = "(Click here to add a new bar)";

  sRAB_Settings_BarDetail_Label = "Label:";
  sRAB_Settings_BarDetail_Query = "Query:";
  sRAB_Settings_BarDetail_Limits = "Limit scan to only include:";
  sRAB_Settings_BarDetail_Priority = "Update frequency:"
  sRAB_Settings_BarDetail_PriorityLess = "Less often";
  sRAB_Settings_BarDetail_PriorityMore = "More often";
  sRAB_Settings_BarDetail_PriorityTip = "%ss";
  sRAB_Settings_BarDetail_ClassesAll = "(No class restriction)";
  sRAB_Settings_BarDetail_ClassesSome = "%s";
  sRAB_Settings_BarDetail_GroupsAll = "(No group restriction)";
  sRAB_Settings_BarDetail_GroupsSome = "Groups %s";
  sRAB_Settings_BarDetail_Remove = "Remove";

  sRAB_Settings_BarDetail_OutputTarget = "Output to:";
  sRAB_Settings_BarDetail_Output_RaidParty = "Raid/party chat";
  sRAB_Settings_BarDetail_Output_Party = "Party chat";
  sRAB_Settings_BarDetail_Output_Whisper = "Whisper";
  sRAB_Settings_BarDetail_Output_Officer = "Officers' chat";
  sRAB_Settings_BarDetail_Output_Channel = "Channel";
  sRAB_Settings_BarDetail_WhisperPrompt = "Whisper to:";
  sRAB_Settings_BarDetail_Output_WhisperSuffix = " (whisper)";

  sRAB_Settings_Settings_Header = "Settings";
  sRAB_Settings_Settings_Description = "Configure RABuffs using the options below.";
  sRAB_Settings_Settings_Buffing = "Spell casting";
  sRAB_Settings_Option_stoppvp="PvP sanity check"
  sRAB_Settings_Option_stoppvp_Description = "If checked, RABuffs will not buff PvP-enabled players in your group unless you are PvP-enabled as well.";
  sRAB_Settings_Option_castbigbuffs = "Cast group/class buffs by default";
  sRAB_Settings_Option_castbigbuffs_Description = "Cast group/class buffs when more effective by default (rather than only on ALT+Click).";
  sRAB_Settings_Option_alwayscastbigbuffs = "Ignore efficiency requirements";
  sRAB_Settings_Option_alwayscastbigbuffs_Description = "Allows casting of group / class buffs on a single person.";
  sRAB_Settings_Option_partymode = "Prioritize own party";
  sRAB_Settings_Option_partymode_Description = "When casting single buffs, buff everyone in your own party before moving on to the rest of the raid.";
  sRAB_Settings_Option_trustctra = "Trust CTRA's RN feedback";
  sRAB_Settings_Option_trustctra_Description = "CT_RaidAssist buff duration broadcasts can be parsed by RABuffs, but are not always accurate (fix it, Cide!).\nIf checked, RABuffs will use those messages for duration feedback when RABuffs' native broadcasts are not available.";
  sRAB_Settings_Settings_VUIConfig = "User Interface";
  sRAB_Settings_Option_syntaxhelp = "Show syntax help";
  sRAB_Settings_Option_syntaxhelp_Description = "Displays syntax help in a tooltip when you type /rab or /rabq into the chat box.\nRequires SlashHelp.";
  sRAB_Settings_Option_dummymode = "Show help in bar tooltips";
  sRAB_Settings_Option_dummymode_Description = "If unchecked, the \"CTRL+Click to ... SHIFT to invert\" line will not appear in bar tooltips.";
  sRAB_Settings_Option_lockwindow = "Lock UI position";
  sRAB_Settings_Option_lockwindow_Description = "Stops you from accidentally moving the RABuffs window.";
  sRAB_Settings_Option_colorizechat = "Color incoming <Buffs> messages";
  sRAB_Settings_Option_colorizechat_Description = "Colors player names rather than displaying their class as text in incoming <Buffs> messages.";
  sRAB_Settings_Option_showsolo = "Display while soloing";
  sRAB_Settings_Option_showsolo_Description = "RABuffs window will be shown when you're outside a party or raid group.";
  sRAB_Settings_Option_showparty = "Display in a party";
  sRAB_Settings_Option_showparty_Description = "RABuffs window will be shown when you're in a party.";
  sRAB_Settings_Option_showraid = "Display in a raid";
  sRAB_Settings_Option_showraid_Description = "RABuffs window will be shown when you're in a raid group.";
  sRAB_Settings_Option_showsampleoutputonclick = "Show sample output";
  sRAB_Settings_Option_showsampleoutputonclick_Description = "When clicking on a bar does not result in a spell being cast, display query text output in console window.";
  sRAB_Settings_Option_enablefadingfx = "Flash 'fading' segment";
  sRAB_Settings_Option_enablefadingfx_Description = "If checked, segments of bars displaying soon-expiring buffs will flash.\n\nRequires interface reload to take effect.";
  sRAB_Settings_Localization_TextFormat = "Localization: %s UI, %s Output";
  sRAB_Settings_Localization_vui = "User Interface";
  sRAB_Settings_Localization_out = "Chat Output";

  sRAB_IntroText = "<html><body><h1 align=\"center\">Introduction</h1><p>RABuffs user interface works by allowing you to view the status of different buffs within a party/raid group: the more complete the bar is, the more people have the buff in question (flashing or fading segments indicate that the buff will soon expire) . By default, RABuffs displays at least three bars: &quot;alive&quot;, the number of people not dead out of the total raid headcount; &quot;healer&quot;, mana status of Priests, Druids, Paladins and Shamans; and &quot;dps&quot;, the mana status of Mages, Warlocks and Hunters. If you are playing as a priest, druid or mage, the default window may contain additional bars for your specific buff spells.</p><br/>" .. 
		 "<p>Point your mouse over a bar and a tooltip detailing the people missing (or having it, depending on the buff) -- some buffs will pop up different information specific to the query they're handling (health, for example, would display dead people as unbuffed). If you hold down SHIFT, the tooltip will invert to show the buffed group members.</p><br/>" ..
		 "<p>If you click on a bar that shows a buff you can cast, RABuffs will attempt to buff one of the unbuffed group member in the order determined by the buff priorities (for example, healing classes always get Arcane Intellect before dps, and you yourself get buffed first). Clicking on special bars may alter this behaviour slightly - clicking on a health or alive bar will cast resurrection if you're playing as a Priest, Paladin or Shaman. If you want to cast a group version of the buff, hold down ALT while clicking (you can turn on casting group buffs by default in the settings tab).</p><br/>" ..
		 "<p>If you click on a bar that shows a buff you can't cast, RABuffs will output buff status to your local chat window, showing unbuffed people. Holding SHIFT will also invert this output. If you want to broadcast this message to your raid or party group, hold CTRL while clicking the bar (the destination of the broadcast is customizable in the Layout tab of this configuration dialog).</p><br/>" ..
		 "<h2>Author Notes</h2><p>RABuffs periodically joins a channel to check its version among other RABuffs installations on your server -- this enables it to notify you in game when updates are available.</p><br/><p>Although RABuffs versions tend to be relatively stable, some bugs may sneak in - depending on the severity, they may be patched immediately or in the next version. If RABuffs generates errors too frequently without user interaction, try hiding its UI window (/rab hide) to turn off most of the non-requested calls.</p><br/><br/></body></html>";

  sRAB_Slash_Help = {
		"/rab show -- shows the UI frame.",
		"/rab info -- displays texture names of the buffs and debuffs on your current target.",
		"/rab versioncheck (raid|party|guild|PlayerName) -- checks RABuffs version used by the raid (default), party, guild or a specific player.",
		"/rabq {buffquery} -- runs a buff query. Run /rabq for specific syntax help."
	   };
  sRAB_Slash_QHelp = {
		"General syntax: /rabq [target] [buff] [groups] [classes]",
		"[target], [groups] and [classes] are optional parameters.",
		"[target]: raid/party/w PlayerName/c Channel - specify where to output.",
		"[buff]: a valid buff to query (use the Valid Query List). If you want to invert the output, prefix with 'not'.",
		"[groups]: # of each group to scan. '148' would only scan groups 1, 4 and 8.",
		"[classes]: letter for each class to scan (Mage warLock Priest Rogue Druid Hunter Shaman Warrior pAladin)."
	   };
  sRAB_Slash_SyntaxHelp = {
		{"^/rab ","-/rab+ [command] {parameters}","_show= -- shows the UI frame.","_info= -- displays buffs/debuffs on current target.","_versioncheck= {target} -- checks RABuffs verion.","_=Try also /rabq for querying buffs from the chat window."},
		{"^/rab show","-/rab show+","Displays the RABuffs user interface after it's been hidden."},
		{"^/rab info","-/rab info+","Displays the buff/debuff textures present on current target."},
		{"^/rab versioncheck","-/rab versioncheck+ {parameters}","_raid= -- checks versions in current raid.","_party= -- checks versions in current party.","_guild= -- checks versions in the guild.","_PlayerName= -- checks Player's version."},
		{"^/rab versioncheck guild","-/rab versioncheck guild+","Checks versions in your guild."},
		{"^/rab versioncheck party","-/rab versioncheck party+","Checks versions in your party."},
		{"^/rab versioncheck raid","-/rab versioncheck raid+","Checks versions in your raid group."},
		{"^/rab versioncheck %a%a%a%a%a%a+","-/rab versioncheck PlayerName+","Checks version through a whisper."},
	};
  sRAB_Slash_QSyntaxHelp = {
		target={"-/rabq +{target} [command] {group limit} {class limit}","_=(Optional) output destination. Default = console.","_raid= -- output to /raid.","_party= -- output to /party.","_officer= -- output to /officer","_w PlayerName= -- whisper to PlayerName.","_c ChannelNameOr#= -- Output to channel."},
		buffquery={"-/rabq target +[command] {group limit} {class limit}","_=Use the Valid Query List to find the query name.  If you want to invert the output, prefix with 'not '."},
		buffqueryinvalid={"-/rabq target + [command] {group limit} {class limit}","_=Use the Valid Query List to find the query name.","_=" .. RED_FONT_COLOR_CODE .. " You picked an invalid buff query. Go back and revise." .. FONT_COLOR_CODE_CLOSE},
		limits={"-/rabq target command +{group limit} {class limit}","_=(Optional) Limits the scan to the specified groups / classes. Default = all.","_={group limit} -- Group numbers. Example: 12345678","_={class limit} -- letter / class.","_=Begin typing a limit to view detailed help"},
		limitg={"-/rabq target command +{group limit} {class limit}","_=(Optional) One # for each group to scan.","_=Default: 12345678. To skip, start typing the class limit."},
		limitc={"-/rabq target command group limit+ {class limit}","_=(Optional) One letter for each class to scan:","_m=age, war_l=ock, _p=riest.","_r=ogue, _d=ruid.","_h=unter, _s=haman.","_w=arrior, p_a=ladin."}
		};
  sRAB_Slash_UnrecognizedCommand = "[RABuffs] Command not recognized. You probably wanted /rabq [query].";
  sRAB_Slash_UnrecognizedQuery = "[RABuffs] Buff query not recongized. You probably wanted /rab [command].";


  sRAB_Error_NotReady = "RABuffs is not ready (crashed during loading?).";
  sRAB_Error_NoBuffData = "Missing buff data for this query.";
  sRAB_Error_NoBuffDataBar = " (invalid query)";
  sRAB_Greeting = "[RABuffs] Version %s loaded. /rab.";
  sRAB_UpdateComplete = "[RABuffs] Updated from %s to %s. See Recent Changes for more information."
  sRAB_OutOfDate_Box = NORMAL_FONT_COLOR_CODE .. "You are not using the most recent version of RABuffs (%s). Download updates from:|r\n|c000077ff" ..   sRAB_DownloadURL .. "|r";
  sRAB_OutOfDate = "[RABuffs] Your version of RABuffs is out of date. The newest version you are aware of is %s (used by %s of %s).";
  sRAB_DownloadLink = "[RABuffs] Download URL: " ..   sRAB_DownloadURL;

  sRAB_Menu_HideWindow = "Hide Window";
  sRAB_Menu_Settings = "Configure";
  sRAB_Menu_HiddenWindow = "[RABuffs] UI frame has been hidden. Use /rab show to make it visible again.";

  sRAB_VersionCheck_BeginGuild = "[Version] Checking guild's RABuffs versions.";
  sRAB_VersionCheck_BeginRaid = "[Version] Checking raid group's RABuffs versions.";
  sRAB_VersionCheck_BeginParty = "[Version] Checking party's RABuffs versions.";
  sRAB_VersionCheck_BeginWhisper = "[Version] Checking %s's RABuffs version.";
  sRAB_VersionCheck_NotInGroup = "[Version] You're in not in a raid / party.";
  sRAB_VersionCheck_Requested = "[Version] |Hplayer:%s|h[%s]|h: Checking %s RABuffs version.";
  sRAB_VersionCheck_Requested_You = "your";
  sRAB_VersionCheck_Requested_Party = "the party's";
  sRAB_VersionCheck_Requested_Raid = "the raid's";
  sRAB_VersionCheck_Requested_Guild = "the guild's";
  sRAB_VersionCheck_Reply = "[Version] |Hplayer:%s|h[%s]|h: Using version %s.";
  sRAB_VersionCheck_Same = " Same.";
  sRAB_VersionCheck_Older = " Out of date.";
  sRAB_VersionCheck_Newer = " More recent.";

  sRAB_AddBar_ToggleAll = "Toggle All";
  sRAB_AddBarFrame_AddBar = "Add Bar";
  sRAB_AddBarFrame_EditBar = "Edit Bar";
  sRAB_AddBarFrame_Add = "Add";
  sRAB_AddBarFrame_Edit = "Edit";

  sRAB_CastBuff_CouldNotCast = "[RABuffs] Could not cast " .. HIGHLIGHT_FONT_COLOR_CODE .. "%s|r.";
  sRAB_CastBuff_Cast = "[RABuffs] Cast " .. HIGHLIGHT_FONT_COLOR_CODE .. "%s|r on %s|r.";
  sRAB_CastBuff_CastNeutral = "[RABuffs] Cast " .. HIGHLIGHT_FONT_COLOR_CODE .. "%s|r.";
  sRAB_CastBuff_CouldNotTarget = "[RABuffs] Could not buff %s.";
  sRAB_CastingLayer_NoSession = "[RABuffs] Unable to intialize casting.";
  sRAB_CastingLayer_NoEntry = "[RABuffs] Could not resolve '" .. HIGHLIGHT_FONT_COLOR_CODE .. "%s|r': not localized (not learned?).";
  sRAB_CastingLayer_Cooldown = "[RABuffs] Could not cast " .. HIGHLIGHT_FONT_COLOR_CODE .. "%s|r: not cooled down.";
  sRAB_CastingLayer_NoSpell = "[RABuffs] Could not cast " .. HIGHLIGHT_FONT_COLOR_CODE .. "%s|r: you have not learned this spell.";
  sRAB_CastingLayer_Mounted = "[RABuffs] Could not cast " .. HIGHLIGHT_FONT_COLOR_CODE .. "%s|r: you're using a taxi.";
  sRAB_CastingLayer_NoMana = "[RABuffs] Could not cast " .. HIGHLIGHT_FONT_COLOR_CODE .. "%s|r: insufficient mana/rage/energy.";
  sRAB_CastingLayer_Dead = "[RABuffs] Could not cast " .. HIGHLIGHT_FONT_COLOR_CODE .. "%s|r: you're looking mighty dead at the moment.";
  sRAB_CastingLayer_NoCast = "No one to cast " .. HIGHLIGHT_FONT_COLOR_CODE .. "%s|r on: %s PvP, %s out of range.";
  sRAB_CastingLayer_NoNeed = "No one needs " .. HIGHLIGHT_FONT_COLOR_CODE .. "%s|r.";

  sRAB_Tooltip_FadeSoon = "%s will soon fade on:";
  sRAB_Tooltip_ClickToRecast = "Click to recast " .. HIGHLIGHT_FONT_COLOR_CODE .. "%s|r on %s|r.";
  sRAB_Tooltip_ClickToCast = "Click to cast " .. HIGHLIGHT_FONT_COLOR_CODE .. "%s|r on %s|r.";
  sRAB_Tooltip_ClickToCastNeutral = "Click to cast " .. HIGHLIGHT_FONT_COLOR_CODE .. "%s|r.";
  sRAB_Tooltip_ClickToRecastNeutral = "Click to cast " .. HIGHLIGHT_FONT_COLOR_CODE .. "%s|r.";
  sRAB_Tooltip_ClickToSoulstone = "Click to soulstone %s.";
  sRAB_Tooltip_ClickToEquip = "Click to equip " .. HIGHLIGHT_FONT_COLOR_CODE .. "%s|r.";
  sRAB_Tooltip_ClickToUse = "Click to use " .. HIGHLIGHT_FONT_COLOR_CODE .. "%s|r.";
  sRAB_Tooltip_ClickToOutput = "CTRL+Click to send to " .. HIGHLIGHT_FONT_COLOR_CODE .. "%s|r.";
  sRAB_Tooltip_HoldToInvert = "Hold SHIFT to invert.";
  sRAB_Tooltip_ReleaseToInvert = "Release SHIFT to invert.";
  sRAB_Tooltip_NoOne = "No one.";
  sRAB_Tooltip_CastFail_What = "|cffff0000Cannot cast: casting layer rejects.|r";
  sRAB_Tooltip_CastFail_Mana = "|cffff0000Cannot cast: Out of mana.|r";
  sRAB_Tooltip_CastFail_Shapeshift = "|cffff0000Cannot cast: Shapeshifted.|r";
  sRAB_Tooltip_CastFail_Taxi = "|cffff0000Cannot cast: on a taxi.|r";
  sRAB_Tooltip_CastFail_Dead = "|cffff0000Cannot cast: not alive.|r";
  sRAB_Tooltip_CastFail_Cooldown = "|cffff0000Cooldown (%ss).|r";
  sRAB_Tooltip_CastFail_Combat = "|cffff0000In combat.|r";
  sRAB_Tooltip_CastFail_NoItem = "|cffff0000Can't find %s.|r";

  sRAB_Tooltip_TimeLeft = NORMAL_FONT_COLOR_CODE .. "Time left: |r" .. HIGHLIGHT_FONT_COLOR_CODE .. "%s|r" .. NORMAL_FONT_COLOR_CODE .. ".";

  sRAB_OutputLayerError_NotInChannel = "[RABuffs] Can not output to '" .. HIGHLIGHT_FONT_COLOR_CODE .. "%s|r': you must join this channel first.";

  sRAB_Core_GroupFormat = "Group %s";

 end
 if (spells and GetLocale() == "enUS") then
  sRAB_Localization_SpellLayer = "|c0000ff00English spellbook|r";
  if (RAB_UnitClass("player") == "Druid") then
   sRAB_SpellNames.motw = "Mark of the Wild";
   sRAB_SpellIDs.motw = sRAB_FindSpellId("Mark of the Wild");
   sRAB_SpellNames.gotw = "Gift of the Wild";
   sRAB_SpellIDs.gotw = sRAB_FindSpellId("Gift of the Wild");   
   if (sRAB_SpellIDs.gotw == 0) then
    sRAB_SpellIDs.gotw = nil; sRAB_SpellNames.gotw = nil;
   end
   if (sRAB_SpellIDs.motw == 0) then
    sRAB_SpellIDs.motw = nil; sRAB_SpellNames.motw = nil;
   end
  end
 end
end
--------------------------------------------------
-- localization.lua (English)
--------------------------------------------------

-- Binding Configuration
BINDING_HEADER_UBERHEAL_HEADER		= "UBER HEAL....The last healing mod you will ever need.";
BINDING_HEADER_UBERHEAL_2HEADER		= "UBER HEAL....This heals 2-5 and then 1";
BINDING_HEADER_UBERHEAL_1HEADER		= "UBER HEAL....This heals 1-5";
BINDING_NAME_UBERHEAL_TOP			= "\"Primary\" Cast Spell 1";
BINDING_NAME_UBERHEAL_MIDDLE			= "\"Primary\" Cast Spell 2";
BINDING_NAME_UBERHEAL_BOTTOM			= "\"Primary\" Cast Spell 3";
BINDING_NAME_UBERHEAL_BOTTOMER 			= "\"Primary\" Cast Spell 4";
BINDING_NAME_UBERHEAL_BOTTOMEST			= "\"Primary\" Cast Spell 5";
BINDING_NAME_UBERHEAL_TOP2			= "\"Secondary\" Cast Spell 1";
BINDING_NAME_UBERHEAL_MIDDLE2			= "\"Secondary\" Cast Spell 2";
BINDING_NAME_UBERHEAL_BOTTOM2			= "\"Secondary\" Cast Spell 3";
BINDING_NAME_UBERHEAL_BOTTOMER2			= "\"Secondary\" Cast Spell 4";
BINDING_NAME_UBERHEAL_BOTTOMEST2		= "\"Secondary\" Cast Spell 5";
BINDING_NAME_UBERHEAL_TOP3			= "Toggle Announcing of healing";
BINDING_NAME_UBERHEAL_MIDDLE3			= "Toggle Verbose mode";
BINDING_NAME_UBERHEAL_BOTTOM3			= "Open Options Window";




UBERHEAL_MACRO_COMMAND  = "/UBERHEAL";
UBERHEAL_MACRO_VERBOSECOMMAND  = "/UBERHEALVERBOSE";
UBERHEAL_MACRO_ANNOUNCEOFFCOMMAND  = "/UBERHEALANNOUNCE";
UBERHEAL_MACRO_SET  = "/UBERHEALSET";
UBERHEAL_MACRO_PRIMARY_CAST_SPELL_1 = "/UBERHEALPRIMARYCASTSPELL1";
UBERHEAL_MACRO_PRIMARY_CAST_SPELL_2 = "/UBERHEALPRIMARYCASTSPELL2";
UBERHEAL_MACRO_PRIMARY_CAST_SPELL_3 = "/UBERHEALPRIMARYCASTSPELL3";
UBERHEAL_MACRO_PRIMARY_CAST_SPELL_4 = "/UBERHEALPRIMARYCASTSPELL4";
UBERHEAL_MACRO_PRIMARY_CAST_SPELL_5 = "/UBERHEALPRIMARYCASTSPELL5";
UBERHEAL_MACRO_SECONDARY_CAST_SPELL_1 = "/UBERHEALSECONDARYCASTSPELL1";
UBERHEAL_MACRO_SECONDARY_CAST_SPELL_2 = "/UBERHEALSECONDARYCASTSPELL2";
UBERHEAL_MACRO_SECONDARY_CAST_SPELL_3 = "/UBERHEALSECONDARYCASTSPELL3";
UBERHEAL_MACRO_SECONDARY_CAST_SPELL_4 = "/UBERHEALSECONDARYCASTSPELL4";
UBERHEAL_MACRO_SECONDARY_CAST_SPELL_5 = "/UBERHEALSECONDARYCASTSPELL5";

UBERHEAL_CLICKCASTHELPTEXT2 = "   Click casting is used for casting pre-defined spells on targets quickly.  (e.g. If a mage is going down you want to get a power word: shield off on them.) With click casting you can press for example Ctrl + left mouse button on a ctraid assist, Perl Classic Unit Frame, or Squishy Emergency window. (MT target list, emergency monitor, raid groups).";
UBERHEAL_CLICKCASTHELPTEXT3 = "   This uses the same 5 spells of the auto target healing.";
UBERHEAL_CLICKCASTHELPTEXT4 = "   Once you have the spells set up, you need to choose which keycombination will go with which spell.  Just select your choices from the drop down menu.  (e.g. mage is low on health.  I have power word shield set up as spell 4.  I have ctrl and mouse 4 selected for spell4.  I could click on the mage on the emergency monitor with ctrl + mouse button 4 to cast the shield on them.)  [NOTE: using mouse buttons 4&5 to cast spells by clicking on the MT window does not work.  Those buttons work on all the other CT Raid windows.  This is a CT Raid problem.]";

UBERHEAL_AUTOMATICCASTHELPTEXT2 = "   NOTE: for the automatic targeting functions to work CT Raid Assist emergency monitor must be turned on or have Squishy Emergency Monitor.";
UBERHEAL_AUTOMATICCASTHELPTEXT3 = "   The main UberHeal window is where you set up you spells. Spells 1-5 can be used for auto target healing.  Set the name and rank of the spells you want to use here.  The spells must be somewhere on one of your action bars.  Buff checking will check the target for a buff of the same name as the spell and NOT cast the spell if they have that buff(buff checking is recommended for heal over time spells).  Also, leaving the rank field blank will cast the highest rank spell that you can on that target. If a target is out of line of sight they will be ignored for 3 seconds.";
UBERHEAL_AUTOMATICCASTHELPTEXT4 = "|c00FFFFFFThere are 2 key bindings set up for each spell. You will need to set these in the key bindings window. (They are in the Uber Heal section, near the bottom)|r";
UBERHEAL_AUTOMATICCASTHELPTEXT5 = "   (By Default)\"Primary\" casting will try to cast on E.M. target #1 first then will move on down the list if target is out of range.  (recommended for fast casting spells: flash of light, etc) You can change the defaults in the advanced options menu.";
UBERHEAL_AUTOMATICCASTHELPTEXT6 = "   (by Default)\"Secondary\" casting will try to cast on E.M. target # 2 first then go on down the list.  If targets 2-5 are out of range/ (already have the buff) it will check E.M. target 1.  (recommended for longer casting spells: greater heal, healing touch, etc)";
UBERHEAL_AUTOMATICCASTHELPTEXT7 = "|c00FFFFFFHere is how the logic for healing works:|r";
UBERHEAL_AUTOMATICCASTHELPTEXT8 = "   1.  Checks to see #x on emergency monitor is in range.  If target is not in range it skips to next # on emergency monitor and starts step #1 on that target.  If in range goes to step 2.";
UBERHEAL_AUTOMATICCASTHELPTEXT9 = "   2.  If \"Buff checking before cast\" is not checked in the options screen, it will skip to step #3.  If it is checked, it will look for the specified buff on the target.  If the target has the buff it skips to next # on emergency monitor and starts step #1 on that target.  If the target doesn’t have that buff it skips to step #3.";
UBERHEAL_AUTOMATICCASTHELPTEXT10 = "   3.  Casts heal spell on the target.";

UBERHEAL_MAINHELPTEXT2 = "NOTE: for the automatic targeting functions to work, CT Raid Assist emergency monitor or Squishy Emergency monitor must be turned on.";
UBERHEAL_MAINHELPTEXT3 = "|c00FFFFFFHow does Uber Heal work?|r";
UBERHEAL_MAINHELPTEXT4 = "   There are 2 parts to Uber Heal.  There is the automatically targeting heal spell. And manual target click casting.  Please click the buttons above to see how these sections work.";
UBERHEAL_MAINHELPTEXT5 = "|c00FFFFFFHow do I turn on the CT Raid Assist emergency monitor?|r";
UBERHEAL_MAINHELPTEXT6 = "   To turn on the emergency monitor, click the RA button around the minimap.  Then click on \"Open Options\", then on \"Additional Options\".  Now click on \"Show emergency monitor\".";
UBERHEAL_MAINHELPTEXT7 = "   You can adjust the emergency monitor scaling here.  You can also set it to show when not in raids.  (For when you want to use Uber Heal to heal a party.";
UBERHEAL_MAINHELPTEXT8 = "   Once the emergency monitor is showing, you can customize the emergency monitor to only show specific classes/groups.  Right click on the emergency monitor.  You can choose which classes/groups you want the emergency monitor to show/ignore.";

UBERHEAL_MAINHELPTEXT9 = "|c00FFFFFFI'm getting a error. What do i do?|r  This is caused when upgrading from the beta versions of uberheal.  Go into your \\World ofWarcraft\\WTF\\Account\\(Account Name)\\Saved Variables\\ directory and delete UberHeal.lua and UberHeal.lua.bak";

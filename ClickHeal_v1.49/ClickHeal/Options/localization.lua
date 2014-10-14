

-- ---------- GLOBALS ----------------------------------------------------------------
CHHT_LABEL_CLOSE       = "Close";
CHHT_LABEL_DEFAULT     = "Default";
CHHT_LABEL_DEFAULTS    = "Defaults";
CHHT_LABEL_CONFIGURE   = "Configure";

CHHT_LABEL_NONE        = 'None';

CHHT_LABEL_MOUSE_1_3   = "Mouse 1/3";
CHHT_LABEL_MOUSE_2_3   = "Mouse 2/3";
CHHT_LABEL_MOUSE_3_3   = "Mouse 3/3";

CHHT_LABEL_PLAYER      = 'Player';
CHHT_LABEL_PET         = 'Pet';
CHHT_LABEL_PARTY       = 'Party';
CHHT_LABEL_PARTYPET    = 'PartyPet';
CHHT_LABEL_RAID        = 'Raid';
CHHT_LABEL_RAIDPET     = 'RaidPet';
CHHT_LABEL_TARGET      = 'Target';
CHHT_LABEL_PARTY1      = 'Party 1';
CHHT_LABEL_PARTY2      = 'Party 2';
CHHT_LABEL_PARTY3      = 'Party 3';
CHHT_LABEL_PARTY4      = 'Party 4';
CHHT_LABEL_PARTYPET1   = 'Party Pet 1';
CHHT_LABEL_PARTYPET2   = 'Party Pet 2';
CHHT_LABEL_PARTYPET3   = 'Party Pet 3';
CHHT_LABEL_PARTYPET4   = 'Party Pet 4';

CHHT_LABEL_PLAYER_LC   = 'player';
CHHT_LABEL_PET_LC      = 'pet';
CHHT_LABEL_PARTY_LC    = 'party';
CHHT_LABEL_PARTYPET_LC = 'partypet';
CHHT_LABEL_RAID_LC     = 'raid';
CHHT_LABEL_RAIDPET_LC  = 'raidpet';
CHHT_LABEL_TARGET_LC   = 'target';
CHHT_LABEL_PARTY1_LC   = 'party 1';
CHHT_LABEL_PARTY2_LC   = 'party 2';
CHHT_LABEL_PARTY3_LC   = 'party 3';
CHHT_LABEL_PARTY4_LC   = 'party 4';
CHHT_LABEL_PARTYPET1_LC= 'party pet 1';
CHHT_LABEL_PARTYPET2_LC= 'party pet 2';
CHHT_LABEL_PARTYPET3_LC= 'party pet 3';
CHHT_LABEL_PARTYPET4_LC= 'party pet 4';

CHHT_LABEL_RAID_GROUP_FORMAT = 'Raid Group %d';

CHHT_LABEL_MAX         = "max";
CHHT_LABEL_MIN         = "min";
CHHT_LABEL_ALWAYS      = "always";
CHHT_LABEL_NEVER       = "never";
CHHT_LABEL_CONTINOUSLY = "continously";

CHHT_LABEL_UP          = "Up";
CHHT_LABEL_DOWN        = "Down";
CHHT_LABEL_DN          = "Dn";

CHHT_LABEL_LEFT        = 'Left';
CHHT_LABEL_RIGHT       = 'Right';
CHHT_LABEL_TOP         = 'Top';
CHHT_LABEL_BOTTOM      = 'Bottom';
CHHT_LABEL_TOPLEFT     = 'TopLeft';
CHHT_LABEL_TOPRIGHT    = 'TopRIght';
CHHT_LABEL_BOTTOMLEFT  = 'BottomLeft';
CHHT_LABEL_BOTTOMRIGHT = 'BottomRight';

CHHT_LABEL_HIGHEST     = 'highest';
CHHT_LABEL_MEMBERS     = 'members';

CHHT_NUMBER_ONE        = 'one';
CHHT_NUMBER_TWO        = 'two';
CHHT_NUMBER_THREE      = 'three';
CHHT_NUMBER_FOUR       = 'four';
CHHT_NUMBER_FIVE       = 'five';

CHHT_LABEL_UPDATE      = 'Update';

-- ---------- TABs -------------------------------------------------------------------
CHHT_TAB_HELP      = "Help";
CHHT_TAB_CONFIG    = "Config";
CHHT_TAB_GUI       = "GUI";
CHHT_TAB_EXTENDED  = "Extended";
CHHT_TAB_FRIEND    = "Friendly";
CHHT_TAB_ENEMY     = "Enemy";
CHHT_TAB_PANIC     = "Panic";
CHHT_TAB_EXTRA     = "Extra";
CHHT_TAB_CHAINS    = "Chain";
CHHT_TAB_BUFFS     = "Buffs";
CHHT_TAB_TOTEMS    = "Totems";

-- ---------- HELP / FAQ -------------------------------------------------------------
CHHT_HELP_TRACKING_BUFF = "(Missing Tracking Buff, like Find Herbs, Find Minerals, Track Beasts, ..)";
CHHT_HELP_TITLE         = 'Help / FAQ';
CHHT_HELP_MSG           = "ClickHeal Help";
CHHT_HELP_PAGE1         = "Help";
CHHT_HELP_PAGE2         = "Abbrevations";
CHHT_HELP_PAGE3         = "FAQs";
CHHT_HELP_PAGE4         = "Credits";

CHHT_HELP_HELP =
  '|c00FFFF00Introduction|r\n'
..'ClickHeal enables you to cast a spell on a unit/player with only one mouse click, without previously targeting the unit and then casting the spell. '
..'By history, ClickHeal was geared towards healers. Although this is still the strongest point of ClickHeal, it is also extremely useful for other '
..'casters.\n\n'
..'|c00FFFF00Spells assignment|r\n'
..'The power of ClickHeal is the ease of assigning spells to your mouse buttons. You can map all your buttons (left,middle,right) and for five button '
..'mice also the button4 and button5. In addition you can map modification keys, like SHIFT-left mouse button.\n'
..'Spells and mouse buttons will be assigned to groups, like enemies, friends and the so called Extra buttons. Dependant on what unit/frame you then click, '
..'the mapped spell will be cast. This is, that for example you left click a friendly unit, you will cast a heal spell but when left clicking an enemy '
..'unit, a damage spell will be cast.\n'
..'Spells can be assigned with this config screen. Just select on the bottom one of the tabs you would like to assign spells for. In the new section you '
..'can then define global options for this section and map the spells to mouse buttons.\n\n'
..'|c00FFFF00There is more to ClickHeal|r\n'
..'ClickHeal not only allows you to map spells, you can also map certain actions, like attack, have your pet attack, drink potions, and more. '
..'ClickHeal also finetunes your spells, checks overhealing and many more.\n\n'
..'|c00FFFF00The ClickHeal Frames|r\n'
..'By default the ClickHeal frames are located on the left side, but can be moved around with the the thin dark bar on the top. '
..'The four buttons on the top are the so called Extra buttons, where you can map gobal spells and actions to.\n'
..'Right below them, the big blue button, is the panic button. Here your mana is displayed, together with alerts of missing buffs or active debuffs. '
..'When clicking this special PANIC action will become active. At this point, ClickHeal will decide what is needed most at that moment and either heals, '
..'cures or buffs your party and raid members.\n'
..'Following below the PANIC button is a button for your Avatar, followed by the button of your party members. At the very bottom follow the frames '
..'for your pet and the pets of your party members. Next to these buttons the respective targets are displayed. Same colors of the name of the targets '
..'indicate that these party members target the same target.\n\n'
..'|c00FFFF00Detailed help|r\n'
..'A detailed help describing ClickHeal in general and giving help to all the configurations can be found at '
..'|c0000CCFFhttp://www.xs4all.nl/~rmetzger/ClickHeal|r '
..'Please check out this page for detailed information.';

CHHT_HELP_TEXT_DEBUFFS = 
  '|c00FFFF00Debuffs (red):\n'
..'|c00FF0000M|c00FFFFFF (magic)\n'
..'|c00FF0000C|c00FFFFFF (curse)\n'
..'|c00FF0000D|c00FFFFFF (disease)\n'
..'|c00FF0000P|c00FFFFFF (poison)\n'
..'|c00FF8800B|c00FFFFFF (recently bandaged)\n'
..'|c00FF8800P|c00FFFFFF (phase shifted imp)\n\n';

CHHT_HELP_TEXT_HOT = 
  '|c00FFFF00Heal over Time (HOT) (green)\n'
..'|c0000FF00J|c00FFFFFF (Rejuvenation)\n'
..'|c0000FF00G|c00FFFFFF (Regrowth)\n'
..'|c0000FF00N|c00FFFFFF (Renew)\n\n';

CHHT_HELP_TEXT_SHIELD = 
  '|c00FFFF00Shield\n'
..'|c0000FF00S|c00FFFFFF (Power Word: Shield)\n'
..'|c00FF8800S|c00FFFFFF (Weakend Soul)\n\n';

CHHT_HELP_TEXT_BUFFS =
  '|c00FFFF00Missing Buffs (yellow):\n'
..'|c00FFFF00B|r (Any buff, PANIC frame only)\n';

CHHT_HELP_TEXT_FINETUNE =
  '|c00FFFF00Spell Finetuning:|c00FFFFFF\n'
..'|c0000CCFFPower Word: Shield|c00FFFFFF -> Renew -> Flash Heal\n'
..'|c0000CCFFRenew|c00FFFFFF -> Flash Heal\n'
..'|c0000CCFFRejuvenation|c00FFFFFF -> Regrowth -> Healing Touch\n'
..'|c0000CCFFRegrowth|c00FFFFFF -> Rejuvenation -> Regrowth (yes, back to Regrowth)\n\n'
;

CHHT_HELP_TEXT_UPPER_LOWER =
  '|c00FFFF00HOT and Buff effects which are in lower case are about to expire.|r\n';

CHHT_HELP_FAQ =
  '|c00FFFF00Where can I find detailed help?|r\n'
..'Please consult |c0000CCFFhttp://www.xs4all.nl/~rmetzger/ClickHeal|r for full documentation.\n\n'
..'|c00FFFF00I read the help but still have questions. Where can I ask them?|r\n'
..'I am frequently consulting the pages of |c0000CCFFui.worldofwar.net|r and |c0000CCFFwww.curse-gaming.com|r. Search there for ClickHeal and check the '
..'message board for the AddOn. Alot of questions are already answered there. But if you are still not satified, please feel free to place your questions '
..'there.\n\n'
..'|c00FFFF00I have found a bug, want to request a feature or want to give feedback. Where can I do this?|r\n'
..'Please post it at |c0000CCFFui.worldofwar.net|r and |c0000CCFFwww.curse-gaming.com|r, in the ClickHeal section. I am extremely interested '
..'in your feedback and bugreports.';

CHHT_HELP_CREDITS =
  '|c00FFFF00About|r\n'
..'ClickHeal is developed by rmet0815. It is licenced under the GPL (Gnu Public Licence), which generally implies that everyone may use it '
..'without restriction. GPL is sticky however, meaning that if you make modifications to the AddOn or use parts of it in your own '
..'applications, these have to be licenced under GPL again.\n\n'
..'|c00FFFF00Credits|r\n'
..'French localization by: Genre, Mainsacr\195\169\n'
..'Korean localization by: Damjau\n'
..'German localization by: Rastibor, Teodred@Rat von Dalaran, Farook\n'
..'Simple Chinese localization by: Space Dragon\n'
..'Traditional Chinese localization by: Bell\n\n'
..'And thanx to all you guys out there using ClickHeal, commenting on it and delivering feedback and bugreports. Without you, '
..'ClickHeal would not be what it is today!';

-- ---------- COMMON / CH_HELP -------------------------------------------------------
CHHT_PET_ATTACK_NONE         = 'None';
CHHT_PET_ATTACK_HUNTERS_MARK = CH_SPELL_HUNTERS_MARK;

CHHT_UNITBUFF_AUTOMATIC      = 'Automatic';
CHHT_UNITBUFF_POPUP          = 'Popup';

CHHT_GROUPBUFF_REFRESH_TIME  = 'Refresh Time';
CHHT_GROUPBUFF_WARN_TIME     = 'Warn Time';

-- ---------- MISC -------------------------------------------------------------------
CHHT_MISC_OPTIONS                       = 'Misc Options';
CHHT_MISC_ADDONS                        = 'Addons';
CHHT_MISC_CTRA                          = "CT Raid Assist (CTRA)";
CHHT_MISC_DUF                           = "Discord Unit Frames (DUF)";
CHHT_MISC_BONUSSCANNER                  = "BonusScanner";
CHHT_MISC_PCUF                          = "Perl Classic Unit Frames (PCUF)";
CHHT_MISC_ORA                           = "oRA";
CHHT_MISC_WOWGUI                        = "Standard WoW GUI";
CHHT_MISC_DECURSIVE                     = "Decursive";
CHHT_MISC_NEEDYLIST                     = "Ralek's Needy List";
CHHT_MISC_ADDON_INFO                    = "Note that not all addons which make use of ClickHeal are listed here. "..
                                          "Check out the ClickHeal webpage for a list of supported and supporting addons.";
CHHT_CAST_SPELL_BY_NAME_ON_SELF         = "Use new self-cast mechanism of World of Warcraft";
CHHT_MISC_DEBUG_LEVEL                   = "Debug Messages";
CHHT_MISC_RESETALL_Q                    = "Checking this option and then pressing the button on the right will reset the COMPLETE ClickHeal configuration";
CHHT_MISC_RESETALL                      = "Reset ALL";
CHHT_MISC_PLUGINS                       = 'Plugins';
CHHT_CONFIG_PLUGIN_INFO_MSG             = 'Plugins can be disabled in the character login screen, "Plugin" button on the lower right';
CHHT_MISC_COMBAT                        = "Combat";
CHHT_MISC_COMBAT_SAFE_TAUNT             = "Safe taunt";
CHHT_MISC_COMBAT_SD                     = 'Self defense';
CHHT_MISC_COMBAT_SD_ATTACK              = "If under attack but not in active combat, attack your target";
CHHT_MISC_COMBAT_SD_PET                 = "If under attack and pet not in combat, have pet attack your target";
CHHT_MISC_COMBAT_SD_HIT                 = "Only consider yourself under attack, if you are actively hit upon";
CHHT_MISC_COMBAT_SD_MES                 = "Never auto-attack mesmerized (sheeped,shackled,..) units";
CHHT_MISC_COMBAT_SD_SWITCH              = 'Switch off self defense when in party/raid';
CHHT_MISC_CDW                           = 'Cooldown Watch';
CHHT_MISC_CDW_EXTRA1                    = 'Extra1 Button';
CHHT_MISC_CDW_EXTRA2                    = 'Extra2 Button';
CHHT_MISC_CDW_EXTRA3                    = 'Extra3 Button';
CHHT_MISC_CDW_EXTRA4                    = 'Extra4 Button';
CHHT_MISC_CDW_SPELLS                    = 'Spells';
CHHT_MISC_CDW_BAG                       = "Show cooldown of bag items";
CHHT_MISC_OVERHEAL                      = 'Healing';
CHHT_MISC_OVERHEAL_COMBAT               = "In combat, only start casting if player health below or at";
CHHT_MISC_OVERHEAL_NOCOMBAT             = "Take most efficient spell if player is out of combat";
CHHT_MISC_OVERHEAL_DOWNSCALE            = "Downscale spell rank in combat to minimize overhealing";
CHHT_MISC_OVERHEAL_LOM_DOWNSCALE        = "How many ranks to maximally downscale spell rank in combat if too low on mana";
CHHT_MISC_OVERHEAL_BASE                 = "Percentage of variable heal amount to consider in calculations";
CHHT_MISC_OVERHEAL_HOT                  = "Percentage of HOT to consider in calucations";
CHHT_MISC_OVERHEAL_QUICK                = 'QUICK';
CHHT_MISC_OVERHEAL_SLOW                 = 'SLOW';
CHHT_MISC_OVERHEAL_DPSCHECK             = 'How long ago the player had to take damage to include DPS into calculations';
CHHT_MISC_OVERHEAL_CLICK_ABORT_PERC     = 'Health percentage of target to abort spell when heal underway and clicking again';
CHHT_MISC_OVERHEAL_MODIFY_TOTAL_PERC    = 'Percentage to modify total healing result with';
CHHT_MISC_OVERHEAL_OVERHEAL_ALLOWANCE   = 'How much overhealing per spell rank is allowed';
CHHT_MISC_OVERHEAL_LOM_NONE             = 'None';
CHHT_MISC_OVERHEAL_LOM_MAX              = 'Maximum';
CHHT_MISC_OVERHEAL_LOM_TITLE_FORMAT     = '%d spell ranks';
CHHT_MISC_OVERHEAL_GEAR                 = 'Include item heal bonuses in calculations (currently %s +heal)';
CHHT_MISC_OVERHEAL_FORMULA_QUICK        = "Formula for QUICK:";
CHHT_MISC_OVERHEAL_FORMULA_SLOW         = "Formula for SLOW:";
CHHT_MISC_NOTIFY_HIT                    = 'Avatar is hit';
CHHT_MISC_NOTIFY_HIT_SOUND              = "Play sound";
CHHT_MISC_NOTIFY_HIT_SOUND_REPEAT       = "Do not repeat sound before";
CHHT_MISC_NOTIFY_HIT_ANNOUNCE_PARTY     = "Announce to party";
CHHT_MISC_NOTIFY_HIT_ANNOUNCE_PLAY_EMOTE= "Play emote";
CHHT_MISC_NOTIFY_HIT_HITPOINTS          = "Only announce if hitpoints below or at";
CHHT_MISC_NOTIFY_HIT_HITPOINT_SLIDER_TITLE = "hitpoints (%d%%)";
CHHT_MISC_NOTIFY_HIT_HITPOINTS_FADE     = "With active Fade (or cooldown on Fade), only announce if hitpoints below or at (Priest only)";
CHHT_MISC_NOTIFY_HIT_REPEAT             = "Do not repeat announce before";
CHHT_MISC_NOTIFY_HIT_MSG                = "Message to display";
CHHT_MISC_NOTIFY_OOM                    = 'Out of Mana';
CHHT_MISC_NOTIFY_OOM_PARTY              = "Announce to party";
CHHT_MISC_NOTIFY_OOM_RAID               = "Announce to raid";
CHHT_MISC_NOTIFY_OOM_CUSTOM_CHANNEL     = "Announce to custom channel";
CHHT_MISC_NOTIFY_OOM_PLAY_EMOTE         = "Play Emote";
CHHT_MISC_NOTIFY_OOM_MANA               = "Announce if mana below or at";
CHHT_MISC_NOTIFY_OOM_SLIDER_TITLE       = 'mana (%d%%)';
CHHT_MISC_NOTIFY_OOM_REPEAT             = "Do not repeat announce before";
CHHT_MISC_NOTIFY_CUSTOM_CHANNEL         = "Custom Channel"
CHHT_MISC_NOTIFY_CUSTOM_CHANNEL_NAME    = "Name"
CHHT_MISC_NOTIFY_CUSTOM_CHANNEL_PASSWORD= "Password"
CHHT_MISC_NOTIFY_CUSTOM_CHANNEL_CHAT_BOX= "Chat Box";
CHHT_MISC_NOTIFY_DEFAULT_CHAT_WINDOW_LABEL="Default Window";
CHHT_MISC_NOTIFY_CHAT_WINDOW_LABEL_FORMAT="Chat Window %d";
CHHT_MISC_NOTIFY_SPELLCAST              = 'Announce Spellcast';
CHHT_MISC_NOTIFY_SPELLCAST_SAY          = "Announce in say";
CHHT_MISC_NOTIFY_SPELLCAST_TELL         = "Tell recipient/target";
CHHT_MISC_NOTIFY_SPELLCAST_PARTY        = "Announce in party chat";
CHHT_MISC_NOTIFY_SPELLCAST_RAID         = "Announce in raid chat";
CHHT_MISC_NOTIFY_SPELLCAST_CUSTOM_CHANNEL="Custom Channel";
CHHT_MISC_PAGE1                         = "Misc";
CHHT_MISC_PAGE2                         = "Plugins";
CHHT_MISC_PAGE3                         = "Combat";
CHHT_MISC_PAGE4                         = "Cooldown";
CHHT_MISC_PAGE5                         = "Healing";
CHHT_MISC_PAGE6                         = "Notify";
CHHT_MISC_PAGE7                         = "Notify 2";
CHHT_MISC_HEALTH_PERCENT_TITLE_FORMAT   = "Health Percent (%s%%)";
CHHT_MISC_HEAL_POTENTIAL_TITLE_FORMAT   = "heal potential (%s%%)";
CHHT_MISC_HOT_PERCENTAGE_TITLE_FORMAT   = "HOT percentage (%s%%)";
CHHT_MISC_HIT_AGO_TITLE_FORMAT          = "hit %s seconds ago";
CHHT_MISC_CLICK_ABORT_PERC_TITLE_FORMAT = "Health Percent (%s%%)";
CHHT_MISC_OVERHEAL_ALLOWANCE_TITLE_FORMAT="Overheal allowance (%s%%)";
CHHT_MISC_SECONDS_TITLE_FORMAT          = "seconds (%s)";
CHHT_MISC_MODIFY_TOTAL_PERC_FORMAT      = "modify total by (%s%%)";

-- ---------- GUI --------------------------------------------------------------------
CHHT_GUI_PARTY_SORT                   = 'Party Sort';
CHHT_GUI_MISC                         = 'Misc';
CHHT_GUI_PARTY_MEMBER_LABEL           = "Party/Raid member label";
CHHT_GUI_SHOW_FRIEND_DEBUFFS          = "Show debuffs on friendly units";
CHHT_GUI_TARGET_BACKGROUND_COLOR      = "Health color target background";
CHHT_GUI_SHOW_TARGET_DEBUFFS          = "Show Target Debuffs";
CHHT_GUI_FRAME_GROUP_MODE             = "Frame Group Mode";
CHHT_GUI_SHOW_CLICKHEAL_FRAMES        = "Show ClickHeal Frames";
CHHT_GUI_SHOW_PARTY_FRAMES            = "Show Party Frames";
CHHT_GUI_SHOW_PARTY_PETS_FRAMES       = "Show Party Pets";
CHHT_GUI_SHOW_WOW_PARTY_FRAMES        = "Show WoW Party Frames";
CHHT_GUI_SHOW_PLAYER_MANA             = "Show Player Mana (in player box)";
CHHT_GUI_SHOW_PET_FOCUS               = "Show Pet Focus";
CHHT_GUI_SHOW_PARTYPET_TARGET         = "Show party pets targets";
CHHT_GUI_SHOW_MES                     = "Show mesmerize duration (Shackle, Poly,...)";
CHHT_GUI_SHOW_FIVE_SEC_RULE           = 'Show bar with "Five Seconds Rule" and mana regain';
CHHT_GUI_SHOW_HINTS                   = "Show hints in config";
CHHT_GUI_UPDATE_SLIDER_TITLE          = 'Update Unit Effects Interval (%3.1f seconds)';
CHHT_GUI_RESET_FRAME_POS              = "Reset Frame Positions";
CHHT_GUI_MAIN_FRAMES                  = 'Main Frames';
CHHT_GUI_FRAME_ALIGNMENT              = "Frame Alignment";
CHHT_GUI_FRAME_EXTRA_WIDTH            = 'Extra Frame Width (%d)';
CHHT_GUI_FRAME_PANIC_WIDTH            = 'PANIC Frame Width (%d)';
CHHT_GUI_FRAME_PLAYER_WIDTH           = 'Player Frame Width (%d)';
CHHT_GUI_FRAME_PARTY_WIDTH            = 'Party Frame Width (%d)';
CHHT_GUI_FRAME_PET_WIDTH              = 'Pet Frame Width (%d)';
CHHT_GUI_FRAME_PARTYPET_WIDTH         = 'Party Pet Frame Width (%d)';
CHHT_GUI_FRAME_EXTRA_HEIGHT           = 'Extra Frame Height (%d)';
CHHT_GUI_FRAME_PANIC_HEIGHT           = 'PANIC Frame Height (%d)';
CHHT_GUI_FRAME_PLAYER_HEIGHT          = 'Player Frame Height (%d)';
CHHT_GUI_FRAME_PARTY_HEIGHT           = 'Party Frame Height (%d)';
CHHT_GUI_FRAME_PET_HEIGHT             = 'Pet Frame Height (%d)';
CHHT_GUI_FRAME_PARTYPET_HEIGHT        = 'Party Pet Frame Height (%d)';
CHHT_GUI_FRAME_EXTRA_SCALE            = 'Extra Frame Scale (%d%%)';
CHHT_GUI_FRAME_PANIC_SCALE            = 'Panic Frame Scale (%d%%)';
CHHT_GUI_FRAME_PLAYER_SCALE           = 'Player Frame Scale (%d%%)';
CHHT_GUI_FRAME_PARTY_SCALE            = 'Party Frame Scale (%d%%)';
CHHT_GUI_FRAME_PET_SCALE              = 'Pet Frame Scale (%d%%)';
CHHT_GUI_FRAME_PARTYPET_SCALE         = 'Party Pet Frame Scale (%d%%)';
CHHT_GUI_TARGET_FRAMES                = 'Target Frames';
CHHT_GUI_SHOW_TARGETS                 = "Show Targets";
CHHT_GUI_FRAME_PLAYER_TARGET_WIDTH    = 'Player Target Frame Width (%d)';
CHHT_GUI_FRAME_PARTY_TARGET_WIDTH     = 'Party Target Frame Width (%d)';
CHHT_GUI_FRAME_PET_TARGET_WIDTH       = 'Pet Target Frame Width (%d)';
CHHT_GUI_FRAME_PARTYPET_TARGET_WIDTH  = 'Party Pet Target Frame Width (%d)';
CHHT_GUI_FRAME_PLAYER_TARGET_HEIGHT   = 'Player Target Frame Height (%d)';
CHHT_GUI_FRAME_PARTY_TARGET_HEIGHT    = 'Party Target Frame Height (%d)';
CHHT_GUI_FRAME_PET_TARGET_HEIGHT      = 'Pet Target Frame Height (%d)';
CHHT_GUI_FRAME_PARTYPET_TARGET_HEIGHT = 'Party Pet Target Frame Height (%d)';
CHHT_GUI_FRAME_PLAYER_TARGET_SCALE    = 'Player Target Frame Scale (%d%%)';
CHHT_GUI_FRAME_PARTY_TARGET_SCALE     = 'Party Target Frame Scale (%d%%)';
CHHT_GUI_FRAME_PET_TARGET_SCALE       = 'Pet Target Frame Scale (%d%%)';
CHHT_GUI_FRAME_PARTYPET_TARGET_SCALE  = 'Party Pet Target Frame Scale (%d%%)';
CHHT_GUI_TOOLTIPS                     = 'Tooltips';
CHHT_GUI_SHOW_GAME_TOOLTIPS           = "Show Game Tooltips on float over";
CHHT_GUI_SHOW_GAME_TOOLTIPS_LOCATION  = "Location of game tooltips";
CHHT_GUI_SHOW_ACTION_TOOLTIPS         = "Show tooltips with spell/action assignments";
CHHT_GUI_TOOLTIP_SHOW_SPELLRANK       = "Show spell rank in tooltip";
CHHT_GUI_TOOLTIP_SHOW_SPELLRANK_MAX   = "Show indication that highest spell is used";
CHHT_GUI_PAGE1                        = "Misc";
CHHT_GUI_PAGE2                        = "Main Frames";
CHHT_GUI_PAGE3                        = "Target Frames";
CHHT_GUI_PAGE4                        = "Tooltips";
CHHT_GUI_PAGE5                        = "Anchors";
CHHT_GUI_FRAME_GROUP_MODE_ALL         = 'Group All';
CHHT_GUI_FRAME_GROUP_MODE_GROUP       = 'Make Groups';
CHHT_GUI_TARGET_COLOR_NEVER           = 'Never';
CHHT_GUI_TARGET_COLOR_PLAYER          = 'Player';
CHHT_GUI_TARGET_COLOR_ALWAYS          = 'Always';
CHHT_GUI_TARGET_DEBUFF_NONE           = 'None';
CHHT_GUI_TARGET_DEBUFF_CASTABLE       = 'Castable';
CHHT_GUI_TARGET_DEBUFF_ENEMY_CASTABLE = 'Enemy castable';
CHHT_GUI_TARGET_DEBUFF_ENEMY_ALL      = 'Enemy All';
CHHT_GUI_TARGET_DEBUFF_ALL            = 'All';
CHHT_GUI_FRAME_ALIGN_LEFT             = 'Left';
CHHT_GUI_FRAME_ALIGN_CENTER           = 'Centered';
CHHT_GUI_FRAME_ALIGN_RIGHT            = 'Right';
CHHT_GUI_DOCK_TARGET_NONE             = 'None';
CHHT_GUI_DOCK_TARGET_RIGHT            = 'Right';
CHHT_GUI_DOCK_TARGET_LEFT             = 'Left';
CHHT_GUI_UNIT_TOOLTIP_ALWAYS          = 'Always';
CHHT_GUI_UNIT_TOOLTIP_NEVER           = 'Never';
CHHT_GUI_UNIT_TOOLTIP_SHIFT           = 'Shift';
CHHT_GUI_UNIT_TOOLTIP_CTRL            = 'Control';
CHHT_GUI_UNIT_TOOLTIP_ALT             = 'Alt';
CHHT_GUI_UNIT_TOOLTIP_SHIFTCTRL       = 'Shift-Ctrl';
CHHT_GUI_UNIT_TOOLTIP_SHIFTALT        = 'Shift-Alt';
CHHT_GUI_UNIT_TOOLTIP_CTRLALT         = 'Ctrl-Alt';
CHHT_GUI_UNIT_TOOLTIP_SHIFTCTRLALT    = 'Shift-Ctrl-Alt';
CHHT_GUI_UNIT_TOOLTIP_LOCATION_MAIN   = 'ClickHeal Frames';
CHHT_GUI_UNIT_TOOLTIP_LOCATION_WOW    = 'Standard WoW';
CHHT_GUI_ACTION_TOOLTIP_ALWAYS        = 'Always';
CHHT_GUI_ACTION_TOOLTIP_NEVER         = 'Never';
CHHT_GUI_TOOLTIP_UNIT_TOOLTIP_SCALE   = 'Scale of the unit tooltip (%d%%)';
CHHT_GUI_TOOLTIP_ACTIONS_TOOLTIP_SCALE= 'Scale of the actions tooltip (%d%%)';
CHHT_GUI_TOOLTIP_HINT_TOOLTIP_SCALE   = 'Scale of the hints tooltip (%d%%)';
CHHT_GUI_ANCHORS                      = 'Anchors';
CHHT_GUI_ANCHORS_ANCHOR_NAME          = 'Anchor';
CHHT_GUI_ANCHORS_RELATIVE_TO          = 'Anchor To';
CHHT_GUI_ANCHORS_RELATIVE_POINT       = 'Direction';
CHHT_GUI_ANCHORS_OFFSET_X             = 'X-Offset';
CHHT_GUI_ANCHORS_OFFSET_Y             = 'Y-Offset';
CHHT_GUI_ANCHORS_GROW                 = "Grow";
CHHT_GUI_ANCHORS_SHOW_MENU            = "Menu";
CHHT_GUI_ANCHORS_VISIBILITY           = 'Visibility';
CHHT_GUI_ANCHORS_VISIBILITY_SHOW      = 'Show';
CHHT_GUI_ANCHORS_VISIBILITY_AUTOHIDE  = 'Autohide';
CHHT_GUI_ANCHORS_VISIBILITY_COLLAPSE  = 'Collapse';
CHHT_GUI_ANCHORS_GROW_UP              = 'Up';
CHHT_GUI_ANCHORS_GROW_DOWN            = 'Down';
CHHT_GUI_ANCHOR_SHOW_DOCK_ANCHORS     = 'Show all anchors';
CHHT_GUI_ANCHOR_SHOW_ANCHORS          = "Movable anchors";
CHHT_GUI_ANCHOR_MAGNETIC_RANGE_TITLE  = "Magnetic Range (%d pixels)";
CHHT_GUI_ANCHOR_MAGNETIC_RANGE_LOW    = "none";
CHHT_GUI_ANCHOR_MAGNETIC_RANGE_HIGH   = "20 px";
CHHT_GUI_ANCHOR_MAGNETIC_TITLE_LOW    = "No Magnetism";

-- ---------- EXTENDED ---------------------------------------------------------------
CHHT_EXTENDED_TOOLTIP_ORIENTATION_HIDE           = 'Do not show';
CHHT_EXTENDED_TOOLTIP_ORIENTATION_LEFT           = 'Left';
CHHT_EXTENDED_TOOLTIP_ORIENTATION_TOP            = 'Top';
CHHT_EXTENDED_TOOLTIP_ORIENTATION_RIGHT          = 'Right';
CHHT_EXTENDED_TOOLTIP_ORIENTATION_BOTTOM         = 'Bottom';
CHHT_EXTENDED_TOOLTIP_ORIENTATION_MAIN           = 'ClickHeal frames';
CHHT_EXTENDED_TOOLTIP_ORIENTATION_WOW            = 'Standard WoW';
CHHT_EXTENDED_RAID_GROUPS                        = 'Raid Groups';
CHHT_EXTENDED_RAID_GROUP1                        = "Raid Group 1";
CHHT_EXTENDED_RAID_GROUP2                        = "Raid Group 2";
CHHT_EXTENDED_RAID_GROUP3                        = "Raid Group 3";
CHHT_EXTENDED_RAID_GROUP4                        = "Raid Group 4";
CHHT_EXTENDED_RAID_GROUP5                        = "Raid Group 5";
CHHT_EXTENDED_RAID_GROUP6                        = "Raid Group 6";
CHHT_EXTENDED_RAID_GROUP7                        = "Raid Group 7";
CHHT_EXTENDED_RAID_GROUP8                        = "Raid Group 8";
CHHT_EXTENDED_RAID_CLASSES                       = 'Raid Classes';
CHHT_EXTENDED_RAID_PETS                          = "Raid Pets";
CHHT_EXTENDED_RAID_PETS_SCAN_INTERVAL            = "Scan for new raid pets every %d seconds";
CHHT_EXTENDED_RAID_PETS_SCAN_INTERVAL_MAX        = "seconds (%s)";
CHHT_EXTENDED_RAID_GROUP_FRAME_WIDTH             = 'Raid Group Frame Width (%d)';
CHHT_EXTENDED_RAID_GROUP_FRAME_HEIGHT            = 'Raid Group Frame Heigth (%d)';
CHHT_EXTENDED_RAID_CLASS_FRAME_WIDTH             = 'Raid Class Frame Width (%d)';
CHHT_EXTENDED_RAID_CLASS_FRAME_HEIGHT            = 'Raid Class Frame Heigth (%d)';
CHHT_EXTENDED_RAID_GROUP_FRAME_SCALE             = 'Raid Group Frame Scale (%d%%)';
CHHT_EXTENDED_RAID_CLASS_FRAME_SCALE             = 'Raid Class Frame Scale (%d%%)';
CHHT_EXTENDED_RAID_HIDE_PARTY_HIDE               = 'Hide Party';
CHHT_EXTENDED_RAID_HIDE_PARTY_SHOW               = 'Show Party';
CHHT_EXTENDED_RAID_HIDE_PARTY_WOW                = 'Use WoW setting';
CHHT_EXTENDED_RAID_HIDE_PARTY_IN_RAID            = 'Hide party in raid';
CHHT_EXTENDED_RAID_TOOLTIP_ORIENTATION           = "Tooltip orientation";
CHHT_EXTENDED_RAID                               = 'Raid';
CHHT_EXTENDED_MAINTANK                           = 'Tank/Assist';
CHHT_EXTENDED_MT1_LABEL                          = 'Tank #1';
CHHT_EXTENDED_MT2_LABEL                          = 'Tank #2';
CHHT_EXTENDED_MT3_LABEL                          = 'Tank #3';
CHHT_EXTENDED_MT4_LABEL                          = 'Tank #4';
CHHT_EXTENDED_MT5_LABEL                          = 'Tank #5';
CHHT_EXTENDED_MT6_LABEL                          = 'Tank #6';
CHHT_EXTENDED_MT7_LABEL                          = 'Tank #7';
CHHT_EXTENDED_MT8_LABEL                          = 'Tank #8';
CHHT_EXTENDED_MT9_LABEL                          = 'Tank #9';
CHHT_EXTENDED_MT10_LABEL                         = 'Tank #10';
CHHT_EXTENDED_MT_CTRA_MT                         = 'CTRA MT';
CHHT_EXTENDED_MT_CTRA_MT_FORMAT                  = 'CTRA MT #%d';
CHHT_EXTENDED_MT_CTRA_PT                         = 'CTRA PT';
CHHT_EXTENDED_MT_CTRA_PT_FORMAT                  = 'CTRA PT #%d';
CHHT_EXTENDED_MT_TOOLTIP_ORIENTATION             = 'Tooltip orientation';
CHHT_EXTENDED_MT_FRAME_WIDTH                     = 'MainTank Frame Width (%d)';
CHHT_EXTENDED_MT_FRAME_HEIGHT                    = 'MainTank Frame Height (%d)';
CHHT_EXTENDED_MT_FRAME_SCALE                     = 'MainTank Frame Scale (%d%%)';
CHHT_EXTENDED_NEEDY_LIST_ENABLED                 = "Needy List Enabled";
CHHT_EXTENDED_NEEDY_LIST_HIDE_IN_BATTLEFIELD     = "Hide in BG";
CHHT_EXTENDED_NEEDY_LIST_TOOLTIP_ORIENTATION     = "Tooltip orientation";
CHHT_EXTENDED_NEEDY_LIST_SCAN_INTERVAL           = "Scan for new needers every %3.1f seconds";
CHHT_EXTENDED_NEEDY_LIST_SCAN_INTERVAL_CONT      = "Continously scan for new needers";
CHHT_EXTENDED_NEEDY_LIST_MAX_UNITS               = "Maximum number of units to display (%d)";
CHHT_EXTENDED_NEEDY_LIST_FRAME_WIDTH             = "Frame Width (%d)";
CHHT_EXTENDED_NEEDY_LIST_FRAME_HEIGHT            = "Frame Height (%d)";
CHHT_EXTENDED_NEEDY_LIST_FRAME_SCALE             = "Frame Scale (%d%%)";
CHHT_EXTENDED_NEEDY_LIST_UNITS_LABEL             = "Units";
CHHT_EXTENDED_NEEDY_LIST_CLASSES_LABEL           = "Classes";
CHHT_EXTENDED_NEEDY_LIST_ENABLED_ALWAYS          = "Always";
CHHT_EXTENDED_NEEDY_LIST_ENABLED_PARTY           = "Party";
CHHT_EXTENDED_NEEDY_LIST_ENABLED_RAID            = "Raid";
CHHT_EXTENDED_NEEDY_LIST_ENABLED_PARTYRAID       = "Party & Raid";
CHHT_EXTENDED_NEEDY_LIST_ENABLED_NEVER           = "Never";
CHHT_EXTENDED_NEEDY_LIST_SORT                    = 'Sorting';
CHHT_EXTENDED_NEEDY_LIST_HIDE_OOR                = 'Hide OOR';
CHHT_EXTENDED_NEEDY_LIST_HIDE_OOR_NONE           = 'Do not hide';
CHHT_EXTENDED_NEEDY_LIST_HIDE_OOR_POSSIBLE       = 'Possibly OOR';
CHHT_EXTENDED_NEEDY_LIST_HIDE_OOR_VERIFIED       = 'Only Verified';
CHHT_EXTENDED_NEEDY_LIST_HEAL                    = "Needy List Heal"
CHHT_EXTENDED_NEEDY_LIST_HEAL_HEALTH_PERCENTAGE  = "Health percentage for unit to show up (%d%%)";
CHHT_EXTENDED_NEEDY_LIST_HEAL_LOCK_TANKS         = "Lock and show tanks";
CHHT_EXTENDED_NEEDY_LIST_HEAL_SORT_UNSORTED      = 'Not sorted';
CHHT_EXTENDED_NEEDY_LIST_HEAL_SORT_LOCKED        = 'Locked units';
CHHT_EXTENDED_NEEDY_LIST_HEAL_SORT_EMERGENCY     = 'Emergency';
CHHT_EXTENDED_NEEDY_LIST_HEAL_SORT_EMERGLOCKED   = 'Emergency, locked';
CHHT_EXTENDED_NEEDY_LIST_CURE                    = "Needy List Cure"
CHHT_EXTENDED_NEEDY_LIST_CURE_SHOW_CURSE         = "Show Curse";
CHHT_EXTENDED_NEEDY_LIST_CURE_SHOW_DISEASE       = "Show Disease";
CHHT_EXTENDED_NEEDY_LIST_CURE_SHOW_POISON        = "Show Poison";
CHHT_EXTENDED_NEEDY_LIST_CURE_SHOW_MAGIC         = "Show Magic";
CHHT_EXTENDED_NEEDY_LIST_CURE_SORT_UNSORTED      = 'Not sorted';
CHHT_EXTENDED_NEEDY_LIST_CURE_SORT_LOCKED        = 'Locked units';
CHHT_EXTENDED_NEEDY_LIST_BUFF                    = "Needy List Buff"
CHHT_EXTENDED_NEEDY_LIST_BUFF_SORT_UNSORTED      = 'Not sorted';
CHHT_EXTENDED_NEEDY_LIST_BUFF_SORT_LOCKED        = 'Locked units';
CHHT_EXTENDED_NEEDY_LIST_DEAD                    = "Needy List Dead"
CHHT_EXTENDED_NEEDY_LIST_DEAD_SORT_UNSORTED      = 'Not sorted';
CHHT_EXTENDED_NEEDY_LIST_DEAD_SORT_LOCKED        = 'Locked units';
CHHT_EXTENDED_PAGE1                              = "Raid";
CHHT_EXTENDED_PAGE2                              = "Tank/Assist";
CHHT_EXTENDED_PAGE3                              = "NL Heal";
CHHT_EXTENDED_PAGE4                              = "NL Cure";
CHHT_EXTENDED_PAGE5                              = "NL Buff";
CHHT_EXTENDED_PAGE6                              = "NL Dead";

-- ---------- FRIEND -----------------------------------------------------------------
CHHT_FRIEND_OPTIONS                = 'Friend Options';
CHHT_FRIEND_HITPOINT_LABEL         = "Label hitpoints of party/raid members as";
CHHT_FRIEND_FRAME_BACKGROUND       = "Background of Avatar and party/raid member frames";
CHHT_FRIEND_FRAME_BACKGROUND_ALPHA = 'Opacity (%3.2f)';
CHHT_FRIEND_PICK_COLOR             = 'Pick Color';
CHHT_FRIEND_RESURRECT              = "Resurrect dead players";
CHHT_FRIEND_ADJUST_SPELLRANK       = "Adjust spell rank to level of target";
CHHT_FRIEND_SHOW_MANA              = "Show Mana";
CHHT_FRIEND_SHOW_RAGE              = "Show Rage";
CHHT_FRIEND_SHOW_ENERGY            = "Show Energy";
CHHT_FRIEND_SHOW_FOCUS             = "Show Focus (Pets)";
CHHT_FRIEND_SHADOWFORM             = "Toggle Shadowform/Ghost Wolf/Stealth";
CHHT_FRIEND_CAST_ON_CHARMED        = "Cast offensive spells on charmed friend";
CHHT_FRIEND_MOUSE_TITLE            = 'Friend actions';
CHHT_FRIEND_PAGE1                  = "Options";
CHHT_FRIEND_PAGE2                  = "Mouse 1/3";
CHHT_FRIEND_PAGE3                  = "Mouse 2/3";
CHHT_FRIEND_PAGE4                  = "Mouse 3/3";
CHHT_FRIEND_HP_LABEL_PERCENT       = 'percentage';
CHHT_FRIEND_HP_LABEL_PERCENT_SIGN  = 'percentage with sign';
CHHT_FRIEND_HP_LABEL_CURRENT       = 'current hitpoints';
CHHT_FRIEND_HP_LABEL_MISSING       = 'missing hitpoins';
CHHT_FRIEND_HP_LABEL_NONE          = 'do not label';
CHHT_FRIEND_FRAME_BACKGROUND_HEALTH= 'Health color';
CHHT_FRIEND_FRAME_BACKGROUND_CLASS = 'Class color';
CHHT_FRIEND_FRAME_BACKGROUND_CUSTOM= 'Custom';
CHHT_FRIEND_PARTY_LABEL_CLASS      = 'Class';
CHHT_FRIEND_PARTY_LABEL_NAME       = 'Name';
CHHT_FRIEND_PARTY_LABEL_BOTH       = 'Class-Name';
CHHT_FRIEND_PARTY_LABEL_COLOR      = 'Color coded name';
CHHT_FRIEND_PARTY_LABEL_BOTHCOLOR  = 'Class-Name Color';
CHHT_FRIEND_FRIEND_DEBUFF_NONE     = 'None';
CHHT_FRIEND_FRIEND_DEBUFF_CURABLE  = 'Curable';
CHHT_FRIEND_FRIEND_DEBUFF_ALL      = 'All';
CHHT_FRIEND_RESURRECT_AFTER_COMBAT = 'after combat';
CHHT_FRIEND_RESURRECT_ALWAYS       = 'always';
CHHT_FRIEND_RESURRECT_NEVER        = 'never';
CHHT_FRIEND_POWER_WORD_SHIELD      = 'Do not cast Power Word: Shield when already active';
CHHT_FRIEND_RENEW                  = 'Do not cast Renew when already active';
CHHT_FRIEND_REGROWTH               = 'Do not cast Regrowth when already active';
CHHT_FRIEND_REJUVENATION           = 'Do not cast Rejuvenation when already active';
CHHT_FRIEND_SWIFTMEND              = 'Do not cast Swiftmend when already active';

CHHT_FRIEND_CHECK_HEAL_RANGE                              = 'Check heal range';
CHHT_FRIEND_CHECK_HEAL_RANGE_MODE                         = 'Mode';
CHHT_FRIEND_CHECK_HEAL_RANGE_NEVER                        = 'Do not check';
CHHT_FRIEND_CHECK_HEAL_RANGE_FOLLOW                       = 'Approximation ~28 yards';
CHHT_FRIEND_CHECK_HEAL_RANGE_ONHWEVENT                    = 'Scan on every hardware event';
CHHT_FRIEND_CHECK_HEAL_RANGE_BOUNDARY_FORMAT              = '%3.1f sec';
CHHT_FRIEND_CHECK_HEAL_RANGE_KEEP_DURATION                = 'Keep duration (%3.1f sec)';
CHHT_FRIEND_CHECK_HEAL_RANGE_VISUALIZATION_OOR            = 'Show OOR at hp';
CHHT_FRIEND_CHECK_HEAL_RANGE_VISUALIZATION_HP             = 'Color hitpoints';
CHHT_FRIEND_CHECK_HEAL_RANGE_VISUALIZATION_BACKGROUND     = 'Custom background';
CHHT_FRIEND_CHECK_HEAL_RANGE_VISUALIZATION_NONE           = 'Do not show';
CHHT_FRIEND_CHECK_HEAL_RANGE_VISUALIZATION_POSSIBLE       = 'Possible OOR';
CHHT_FRIEND_CHECK_HEAL_RANGE_VISUALIZATION_VERIFIED       = 'Verified OOR';
CHHT_FRIEND_CHECK_HEAL_RANGE_VISUALIZATION_POSSIBLE_COLOR = 'Color Possible';
CHHT_FRIEND_CHECK_HEAL_RANGE_VISUALIZATION_VERIFIED_COLOR = 'Color Verified';

-- ---------- TARGET/ENEMY -----------------------------------------------------------
CHHT_TARGET_TARGETING          = "Target acquisition mode";
CHHT_TARGET_PLAYER_TARGET      = "Player Target";
CHHT_TARGET_PARTY1_TARGET      = "Party 1 Target";
CHHT_TARGET_PARTY2_TARGET      = "Party 2 Target";
CHHT_TARGET_PARTY3_TARGET      = "Party 3 Target";
CHHT_TARGET_PARTY4_TARGET      = "Party 4 Target";
CHHT_TARGET_PET_TARGET         = "Pet Target";
CHHT_TARGET_PARTYPET1_TARGET   = "Party Pet 1 Target";
CHHT_TARGET_PARTYPET2_TARGET   = "Party Pet 2 Target";
CHHT_TARGET_PARTYPET3_TARGET   = "Party Pet 3 Target";
CHHT_TARGET_PARTYPET4_TARGET   = "Party Pet 4 Target";
CHHT_TARGET_OPTIONS            = 'Enemy Options';
CHHT_TARGET_SHOW_LEVEL_DIFF    = "Show level Difference";
CHHT_TARGET_SHOW_MANA          = "Show Mana";
CHHT_TARGET_SHOW_RAGE          = "Show Rage";
CHHT_TARGET_SHOW_ENERGY        = "Show Energy";
CHHT_TARGET_SHOW_FOCUS         = "Show Focus (Pets)";
CHHT_TARGET_CAST_ON_CHARMED    = "Cast beneficial spells on charmed enemy";
CHHT_TARGET_MOUSE_TITLE        = 'Enemy actions';
CHHT_TARGET_COLORS             = 'Colors';
CHHT_TARGET_PAGE1              = "Options";
CHHT_TARGET_PAGE2              = "Mouse 1/3";
CHHT_TARGET_PAGE3              = "Mouse 2/3";
CHHT_TARGET_PAGE4              = "Mouse 3/3";
CHHT_TARGET_GROUP_LABEL_FORMAT = "Group %d";
CHHT_TARGET_TARGETING_KEEP     = 'Keep current target';
CHHT_TARGET_TARGETING_TARGET   = 'Target spell target';
CHHT_TARGET_TARGETING_INT      = 'Intelligent targeting';
CHHT_COLOR_GROUP_LABEL_FORMAT  = 'Color Group %s';

-- ---------- PANIC ------------------------------------------------------------------
CHHT_PANIC_OPTIONS                     = 'Panic Options';
CHHT_PANIC_NO_BATTLEFIELD              = 'Outside Battlefield';
CHHT_PANIC_IN_BATTLEFIELD              = 'In Battlefield';
CHHT_PANIC_CURE_UNITS                  = "Cure Units with 'PANIC'";
CHHT_PANIC_UNMAPPED                    = "Use 'PANIC' behavior for unmapped buttons";
CHHT_PANIC_CHECK_RANGE                 = "Do range checks";
CHHT_PANIC_SPELL_DOWNGRADE             = "Enable overheal minimization";
CHHT_PANIC_COMBAT_HEALING_IN_BATTLEFIELD="Always use combat healing";
CHHT_PANIC_MOUSE_TITLE                 = 'Panic actions';
CHHT_PANIC_BEHAVIOR                    = 'Panic Behavior';
CHHT_PANIC_BEHAVIOR_LABEL              = "Panic behavior template";
CHHT_PANIC_BEHAVIOR_SPELL_TITLE_FORMAT = "Spell %d";
CHHT_PANIC_BEHAVIOR_FORCE_CAST         = "force cast";
CHHT_PANIC_BEHAVIOR_CLASSES            = 'Classes';
CHHT_PANIC_BEHAVIOR_EMERGENCY_LEVELS   = 'Emergency Levels';
CHHT_PANIC_BEHAVIOR_SPELL_EDIT         = 'Spell Configuration';
CHHT_PANIC_PAGE1                       = "Options";
CHHT_PANIC_PAGE2                       = "Behavior";
CHHT_PANIC_PAGE3                       = "Mouse 1/3";
CHHT_PANIC_PAGE4                       = "Mouse 2/3";
CHHT_PANIC_PAGE5                       = "Mouse 3/3";
CHHT_PANIC_TITLE_HEAL                  = 'PANIC: Heal';
CHHT_PANIC_TITLE_BUFF                  = 'PANIC: Buff';
CHHT_PANIC_TITLE_FULL                  = 'Full spell range';
CHHT_PANIC_TITLE_TRASH                 = 'Trash healing';
CHHT_PANIC_TITLE_BATTLEFIELD           = 'Battlefield';
CHHT_PANIC_TITLE_CUSTOM1               = 'Custom 1';
CHHT_PANIC_TITLE_CUSTOM2               = 'Custom 2';
CHHT_PANIC_TITLE_CUSTOM3               = 'Custom 3';

-- ---------- EXTRA ------------------------------------------------------------------
CHHT_EXTRA_LABEL         = "Label";
CHHT_EXTRA_SHOW_COOLDOWN = "Show cooldown of";
CHHT_EXTRA_OPTIONS       = 'Extra Options';
CHHT_EXTRA_HIDE_BUTTON   = "Hide Button";
CHHT_EXTRA_PAGE1         = "Options";
CHHT_EXTRA_PAGE2         = "Mouse 1/3";
CHHT_EXTRA_PAGE3         = "Mouse 2/3";
CHHT_EXTRA_PAGE4         = "Mouse 3/3";
CHHT_EXTRA_LABEL_FORMAT  = 'Extra %d';
CHHT_EXTRA_TITLE_FORMAT  = 'Extra %d buttons';

-- ---------- CHAINS -----------------------------------------------------------------
CHHT_CHAINS_BUTTON_ASSIGNMENT = 'Button assignment';
CHHT_CHAINS_CHAIN1            = "Chain 1";
CHHT_CHAINS_CHAIN2            = "Chain 2";
CHHT_CHAINS_CHAIN3            = "Chain 3";
CHHT_CHAINS_CHAIN4            = "Chain 4";
CHHT_CHAINS_NAME_FORMAT       = "Chain %d";
CHHT_CHAINS_TITLE_FORMAT      = 'Chain %d setup';

-- ---------- BUFFS ------------------------------------------------------------------
CHHT_BUFF_TITLE              = 'Buff Options';
CHHT_BUFF_EXPIRE_PLAY_SOUND  = "Play sound when buff has expired";
CHHT_BUFF_EXPIRE_SHOW_MSG    = "Show message when buff has expired";
CHHT_BUFF_WARN_PLAY_SOUND    = "Play sound when buff about to expire";
CHHT_BUFF_WARN_SHOW_MSG      = "Show message when buff about to expire";
CHHT_BUFF_SHOW_TRACKING_BUFF = "Show tracking buff as missing (Find Herbs, Find Minerals, Track Humanoids, ...)";
CHHT_BUFF_SHOW_RAID_EFFECTS  = "Show effects on raid members (missing buffs, active debuffs)";
CHHT_BUFF_COMBINE_IN_PANIC   = "Combine missing buffs in PANIC frame";
CHHT_BUFF_AVAILABLE_BUFFS    = 'Available Buffs';
CHHT_BUFF_ALLOWED_CLASSES    = 'Allowed Classes';
CHHT_BUFF_ALLOWED_UNITS      = 'Allowed Units';
CHHT_BUFF_BUFF_DATA          = 'Buff Data';
CHHT_BUFF_UPGRADE_Q          = "Cast #PARTYSPELLNAME# if at least (n) #PARTYSPELLSPEC# members need the buff";
CHHT_BUFF_UPGRADE_MSG        = "Upgrade unit spell";
CHHT_BUFF_IN_BATTLEFIELD     = "Cast in Battlefield";
CHHT_BUFF_PAGE1              = "Options";
CHHT_BUFF_PAGE2              = "Buff List";
CHHT_BUFFS_NEVER_WARN        = "Never warn";
CHHT_BUFFS_ALWAYS_WARN       = "Always warn";
CHHT_BUFFS_WARN_EXPIRE_TITLE = "Warn %s before expiration";
CHHT_BUFFS_NEVER_REFRESH     = "Never refresh";
CHHT_BUFFS_ALWAYS_REFRESH    = "Always refresh";
CHHT_BUFFS_REFRESH_TITLE     = "Refresh %s before expiration";

-- ---------- TOTEMSET ---------------------------------------------------------------
CHHT_TOTEMSET_LABEL_FORMAT            = "Totem Set %d";
CHHT_TOTEMSET_RESET_TIME_TITLE_FORMAT = "Reset time (%s)";
CHHT_TOTEMSET_SLIDER_TITLE_FORMAT     = "%d sec";

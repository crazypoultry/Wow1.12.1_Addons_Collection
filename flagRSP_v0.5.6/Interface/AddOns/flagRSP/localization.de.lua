if ( GetLocale() == "deDE" ) then
   -- This is how "Level" is called in tooltip, (MUST BE EXACT!)
   -- flagRSP needs to detect which line contains the level.
   -- Think it's niveau or similar in French.
   FlagRSP_Locale_Level = "Stufe";
   -- This determines how the common language is called. (MUST BE EXACT!)
   -- This is the alliance language speakable by all four races.
   FlagRSP_Locale_CLanguage = "Gemeinsprache";

   -- This determines how pets are named in the tooltip. (MUST BE EXACT!)
   -- It's needed to get their owners name.
   -- Should be something like: "Minion of <player Name>"
   -- (.+) stands for the player's name.
   -- IMPORTANT: replace player's name  by (.+), the rest MUST be exact!
   -- All occurrances must be included.
   FlagRSP_Locale_MinionLine = {};
   FlagRSP_Locale_MinionLine[0] = "Begleiter von (.+)";
   FlagRSP_Locale_MinionLine[1] = "Diener von (.+)";

   -- keywords which determine the owner line in the tooltip of a pet. (MUST BE EXACT!)
   -- If flagRSP finds these words it knows that the line is a owner line.
   -- All occurrances must be included.
   FlagRSP_Locale_MinionText = {};
   FlagRSP_Locale_MinionText[0] = "Begleiter";
   FlagRSP_Locale_MinionText[1] = "Diener";

   -- messages from client after getting AFK. (MUST BE EXACT!)
   FlagRSP_Locale_AFK = "Ihr seid jetzt AFK:";
   FlagRSP_Locale_NOTAFK = "Ihr werdet nicht mehr mit 'Nicht an der Tastatur' angezeigt.";

   -- This is how civilians are called in tooltip.
   FlagRSP_Locale_CivilianText = "Zivilist";
   -- This is how "Skinnable" is called in tooltip.
   FlagRSP_Locale_SkinnableText = "H\195\164utbar";
   -- This is how the resurrectable line is called in tooltip.
   FlagRSP_Locale_ResurrectableText = "Wiederbelebbar";
   -- This is how your skinning skill is called.
   FlagRSP_Locale_Skinning = "K\195\188rschnerei";
    
   --------------------------------------------------------------------------------------------------
   -- Having translated until here flagRSP should run on your client. It will be in English however.
   --------------------------------------------------------------------------------------------------
     
   -- This is how the civilian line should appear in tooltip.
   FlagRSP_Locale_CivilianLine = "Zivilist";
   -- This is how the "Skinnable" line should appear in tooltip.
   FlagRSP_Locale_SkinnableLine = "H\195\164utbar";
      
   -- This is how unknown players should be named.
   FlagRSP_Locale_Unknown = "<Unbekannt>";
   FlagRSP_Locale_UnknownPet = "<Unbekanntes Wesen>";
   -- %flagRSPPetOwnerLine is a dynamical variable. flagRSP will care about such variables. 
   -- These MUST NOT be translated.
   --FlagRSP_Locale_UnknownPetKnownPlayer = "<%flagRSPPetOwnerLine>";

   -- Tooltip texts for alternative level display. Do not change this
   -- %-variables. You can use them as a substitution for the alternative 
   -- level descriptions which follow later. flagRSP will decide which
   -- description will be chosen.
   FlagRSP_Locale_AltLevelLine = "Erfahrung: ";
   -- Tooltip texts for traditional level display. Should be the same as your client
   -- uses to display level/class/race information in tooltip.
   FlagRSP_Locale_TradLevelLine = "Stufe ";

   -- Tooltip texts for name display of known players.
   --FlagRSP_Locale_KnownNameLine = "%UnitName %flagRSPSurname";
   --FlagRSP_Locale_KnownPetNameLine = "%UnitName";
   -- Line for unknown pets which owner we know (comment out or leave empty for the standard line).
   -- A "--" means comment. Unless you don't want to change default behaviour you can ignore this.
   --FlagRSP_Locale_KnownPetOwnerLine = "Gef\195\164hrte von %flagRSPPetOwner";

   -- Tooltip texts for PvP rank display.
   FlagRSP_Locale_PVPRankLine = "Rang: ";

   -- Tooltip texts for character status display.
   FlagRSP_Locale_CharStatusLine = "Charakter-Status: ";

   -- Tooltip texts for PvP rank display.
   FlagRSP_Locale_TitleLine = "%UnitTitle";

   -- Tooltip texts for guild display.
   --FlagRSP_Locale_GuildLine = "<%UnitGuild>";
   
   -- Prefix before alternative level display.
   -- Commented out because not needed anymore.
   --FlagRSP_Locale_AltLevelPrefix = "Experience: ";
   -- Prefix before traditional level display.
   --FlagRSP_Locale_TradLevelPrefix = "Level ";

   -- Prefix for PvP rank display.
   --FlagRSP_Locale_PVPRankPrefix = "Rang: ";

   -- Descriptions for alternative level display.
   -- Objects that are 7 or more levels weaker than you.
   FlagRSP_Locale_Epuny = "keine Herausforderung";
   -- Objects 5 or 6 levels weaker than you.
   FlagRSP_Locale_Puny = "deutlich unterlegen";
   -- Objects 2 to 4 levels weaker.
   FlagRSP_Locale_Weak = "unterlegen";
   -- Objects 1 level weaker to 1 level stronger.
   FlagRSP_Locale_Equal = "ebenb\195\188rtig";
   -- Objects 2 to 3 levels stronger.
   FlagRSP_Locale_Strong = "stark";
   -- Objects 4 to 6 levels stronger.
   FlagRSP_Locale_Vstrong = "sehr stark";
   -- Objects 7 to 9 levels stronger.
   FlagRSP_Locale_Estrong = "\195\164u\195\159erst stark";
   -- Objects 10 or more levels stronger.
   FlagRSP_Locale_Impossible = "hoffnungslos \195\188berlegen";

   -- Targetframe texts for alternative level display.
   -- Objects that are 7 or more levels weaker than you.
   FlagRSP_Locale_TF_Epuny = "<<";
   -- Objects 5 or 6 levels weaker than you.
   FlagRSP_Locale_TF_Puny = "<<";
   -- Objects 2 to 4 levels weaker.
   FlagRSP_Locale_TF_Weak = "<";
   -- Objects 1 level weaker to 1 level stronger.
   FlagRSP_Locale_TF_Equal = "=";
   -- Objects 2 to 3 levels stronger.
   FlagRSP_Locale_TF_Strong = ">";
   -- Objects 4 to 6 levels stronger.
   FlagRSP_Locale_TF_Vstrong = ">>";
   -- Objects 7 to 9 levels stronger.
   FlagRSP_Locale_TF_Estrong = "!";
   -- Objects 10 or more levels stronger.
   FlagRSP_Locale_TF_Impossible = "!!";
   
   -- Elite Objects.
   -- will be added behind alternative description (therefore the ",").
   FlagRSP_Locale_Elite = ", Elite";
   -- Boss Objects.
   FlagRSP_Locale_Boss = ", Anf\195\188hrer";
   
   -- This is how roleplayers should be called.
   FlagRSP_Locale_RP = "<Rollenspieler>";
   FlagRSP_Locale_RP2 = "<Gelegenheitsrollenspieler>"; 
   FlagRSP_Locale_RP3 = "<Vollzeitrollenspieler>";
   FlagRSP_Locale_RP4 = "<Rollenspielanf\195\164nger>"; 

   -- This is how character status should be called.
   FlagRSP_Locale_OOC = "<au\195\159erhalb der Rolle>";
   FlagRSP_Locale_IC = "<in der Rolle>"; 
   FlagRSP_Locale_FFAIC = "<in der Rolle, sucht nach Kontakt>";
   FlagRSP_Locale_ST = "<Spielleiter>";
   
   -- Notification that player is on ignore list.
   FlagRSP_Locale_Ignored = "Wird ignoriert!";

   -- Command line options for "/rsp" command.
   -- For example "/rsp names".
   -- Option to (de)activate hiding of names.
   FlagRSP_Locale_HideNames_Cmd = "namen";
   -- Option to (de)activate alternative level display.
   FlagRSP_Locale_LevelDisp_Cmd = "level";
   -- Option to (de)activate PvP rank display.
   FlagRSP_Locale_RankDisp_Cmd = "ranks";
   -- Option to (de)activate guild display.
   FlagRSP_Locale_GuildDisp_Cmd = "guilds";
   -- Option to set your surname.
   FlagRSP_Locale_Surname_Cmd = "nachname";
   -- Option to set title.
   FlagRSP_Locale_Title_Cmd = "titel";
   -- Option to set player afk.
   FlagRSP_Locale_AFK_Cmd = "afk";
   -- Option to plot status.
   FlagRSP_Locale_Status_Cmd = "status";

   -- Option to show own tooltip.
   FlagRSP_Locale_OwnTooltip_Cmd = "owntooltip";
   
   -- Option to set beginner flag.
   FlagRSP_Locale_Beginner_Cmd = "beginner";
   -- Option for casual flag.
   FlagRSP_Locale_Casual_Cmd = "leicht";
   -- Option for normal flag.
   FlagRSP_Locale_Normal_Cmd = "normal";
   -- Option for fulltime flag.
   FlagRSP_Locale_Fulltime_Cmd = "dauer";
   -- Option to deactivate rp flag.
   FlagRSP_Locale_NoRP_Cmd = "aus";

   -- Option to set ooc flag.
   FlagRSP_Locale_OOC_Cmd = "ooc";
   -- Option for ic flag.
   FlagRSP_Locale_IC_Cmd = "ic";
   -- Option for ic-ffa flag.
   FlagRSP_Locale_ICFFA_Cmd = "ffa-ic";
   -- Option to deactivate character status flag.
   FlagRSP_Locale_NoCStatus_Cmd = "stopcharstat";
   -- Option for st flag.
   FlagRSP_Locale_ST_Cmd = "st";

   -- OnLoad-Message (%s for flagRSP version).
   FlagRSP_Locale_OnLoad = {};
   FlagRSP_Locale_OnLoad[0] = "flagRSP %flagRSPVersion wird initialisiert...";
   FlagRSP_Locale_OnLoad[1] = "Du kannst bereits spielen, aber flagRSP braucht noch ein paar Augenblicke, bis es fertig ist.";
   FlagRSP_Locale_OnLoad[2] = "/rsp ? f\195\188r eine \195\156bersicht der Optionen."

   -- Messages after several commands.
   -- Message if Hiding of Names was activated.
   FlagRSP_Locale_HideNames = "Verstecken unbekannter Namen aktiviert.";
   FlagRSP_Locale_UnhideNames = "Verstecken unbekannter Namen deaktiviert.";

   -- Hiding of exact levels.
   FlagRSP_Locale_HideLevels = "Alternative Levelanzeige aktiviert.";
   FlagRSP_Locale_UnhideLevels = "Alternative Levelanzeige deaktiviert.";

   -- PvP rank display options.
   FlagRSP_Locale_ShowRanks = "Anzeige der PvP-R\195\164nge aktiviert.";
   FlagRSP_Locale_HideRanks = "Anzeige der PvP-R\195\164nge deaktiviert.";
   
   -- Guild display options.
   FlagRSP_Locale_ShowAllGuild = "Anzeige aller Gildennamen aktiviert.";
   FlagRSP_Locale_ShowKnownGuild = "Anzeige nur bekannter Gildennamen aktiviert.";
   FlagRSP_Locale_HideGuild = "Anzeige der Gildennamen komplett deaktiviert.";

   -- Message if beginner flag set.
   FlagRSP_Locale_BeginnerFlagSet = "Rollenspielanf\195\164nger-Tag gesetzt. Viel Spa\195\159 beim Endecken einer neuen Leidenschaft!";
   -- Casual roleplayer.
   FlagRSP_Locale_CasualFlagSet = "Gelegenheitsrollenspieler-Tag gesetzt.";
   -- Normal roleplayer.
   FlagRSP_Locale_NormalRPFlagSet = "Normales Rollenspieler-Tag gesetzt.";
   -- Fulltime roleplayer.
   FlagRSP_Locale_FulltimeFlagSet = "Vollzeitrollenspieler-Tag gesetzt.";
   -- No roleplayer.
   FlagRSP_Locale_NoRPFlagSet = "Rollenspieler-Tag deaktiviert!";

   -- 
   -- 
   FlagRSP_Locale_UnicornOfficial = "<Einhorn>"; 
   FlagRSP_Locale_UnicornNonOfficial = "<Einhorn, NICHT OFFIZIELL BEST\195\132TIGT>"; 

   -- Message if ooc flag set.
   FlagRSP_Locale_OOCFlag = "Spieler spielt out of character, also au\195\159erhalb seiner Rolle.";
   -- Message if ic flag set.
   FlagRSP_Locale_ICFlag = "Spieler spielt in character, verk\195\182rpert also seine Rolle!";
   -- Message if free for all ic flag set.
   FlagRSP_Locale_FFAICFlag = "Spieler spielt in character free-for-all. Symbolische Einladung f\195\188r IC-Kontaktkn\195\188pfungen.";
   -- Message if no character status flag set.
   FlagRSP_Locale_NoCFlag = "Kein Charakter-Status gew\195\164hlt.";
   -- Message if st flag set.
   FlagRSP_Locale_STFlag = "Spieler spielt als Spielleiter. Das Abenteuer beginnt!";
   
   -- Message that no surname is set.
   FlagRSP_Locale_NoSurname = "Kein Nachname gesetzt.";
   -- Message with new surname (%s is new name).
   FlagRSP_Locale_NewSurname = "Nachname gesetzt auf: %s.";

   -- Message that no title is set.
   FlagRSP_Locale_NoTitle = "Kein Titel gesetzt.";
   -- Message with new title (%s is new title).
   FlagRSP_Locale_NewTitle = "Titel gesetzt auf: %s.";

   -- Message for updated description.
   FlagRSP_Locale_DescUpdate = "Description aktualisiert."

   -- Message for flagRSP-AFK activated.
   FlagRSP_Locale_AFK_Activated = "AFK aktiviert. Senden der Flags deaktiviert.";
   -- Message for flagRSP-AFK deactivated.
   FlagRSP_Locale_AFK_Deactivated = "AFK deaktiviert. Senden der Flags aktiviert.";

   -- Message for sending rp-help request.
   FlagRSP_Locale_RPTicket = "Sende RP-Help-Anfrage:";
   
   -- Help.
   FlagRSP_Locale_Help = {};
   FlagRSP_Locale_Help[0] = "flagRSP: Hilfe --------------------------------------------------------------";
   FlagRSP_Locale_Help[1] = "/rsp toggle --> (De)Aktiviert Rollenspieler-Flag.";
   FlagRSP_Locale_Help[2] = "/rsp " .. FlagRSP_Locale_HideNames_Cmd .. " --> (De)Aktiviert das Verstecken unbekannter Namen.";
   FlagRSP_Locale_Help[3] = "/rsp " .. FlagRSP_Locale_LevelDisp_Cmd .. " --> (De)Aktiviert die alternative Levelanzeige.";
   FlagRSP_Locale_Help[4] = "/rsp " .. FlagRSP_Locale_RankDisp_Cmd .. " --> (De)Aktiviert die Anzeige der PvP-R\195\164nge.";
   FlagRSP_Locale_Help[5] = "/rsp " .. FlagRSP_Locale_GuildDisp_Cmd .. " --> (De)Aktiviert die Anzeige der Gildennamen.";
   FlagRSP_Locale_Help[6] = "/rsp " .. FlagRSP_Locale_Surname_Cmd .. " <TEXT> --> Setzt Nachname auf <TEXT>.";
   FlagRSP_Locale_Help[7] = "/rsp " .. FlagRSP_Locale_Title_Cmd .. " <TEXT> --> Setzt Titel auf <TEXT>.";
   FlagRSP_Locale_Help[8] = "/rsp [" .. FlagRSP_Locale_Beginner_Cmd .. "/" .. FlagRSP_Locale_Casual_Cmd .. "/" .. FlagRSP_Locale_Normal_Cmd .. "/" .. FlagRSP_Locale_Fulltime_Cmd .. "/" .. FlagRSP_Locale_NoRP_Cmd .. "] --> Setzt bevorzugte Rollenspielart:";
   FlagRSP_Locale_Help[9] = "   " .. FlagRSP_Locale_Beginner_Cmd .. ": RP-Anf\195\164nger, d.h. RP-Newbie, dem Fehler verziehen werden sollten.";
   FlagRSP_Locale_Help[10] = "   " .. FlagRSP_Locale_Casual_Cmd .. ": Gelegenheits-RPler, d.h. jemand, der OOC-Chat braucht oder zumindest akzeptiert.";
   FlagRSP_Locale_Help[11] = "   " .. FlagRSP_Locale_Normal_Cmd .. ": Normaler RPler, d.h. jemand, der generell kein OOC w\195\188nscht, sich aber ggf. anpasst.";
   FlagRSP_Locale_Help[12] = "   " .. FlagRSP_Locale_Fulltime_Cmd .. ": Vollzeit-RPler, d.h. jemand, der OOC strikt ablehnt und vollzeit in seiner Rolle ist.";
   FlagRSP_Locale_Help[13] = "   " .. FlagRSP_Locale_NoRP_Cmd .. ": Rollenspiel-Flag komplett entfernen.";
   FlagRSP_Locale_Help[14] = "/rsp [" .. FlagRSP_Locale_OOC_Cmd .. "/" .. FlagRSP_Locale_IC_Cmd .. "/" .. FlagRSP_Locale_ICFFA_Cmd .. "/" .. FlagRSP_Locale_ST_Cmd .. "/" .. FlagRSP_Locale_NoCStatus_Cmd .. "] --> Setzt Charakter-Status:";
   FlagRSP_Locale_Help[15] = "   " .. FlagRSP_Locale_OOC_Cmd .. ": Out of character, Spieler spielt nicht seine Rolle.";
   FlagRSP_Locale_Help[16] = "   " .. FlagRSP_Locale_IC_Cmd .. ": In character, Spieler spielt seine Rolle!";
   FlagRSP_Locale_Help[17] = "   " .. FlagRSP_Locale_ICFFA_Cmd .. ": In character free-for-all, wie ".. FlagRSP_Locale_IC_Cmd .. ", Spieler w\195\188nscht Kontakt zu anderen Rollenspielern.";
   FlagRSP_Locale_Help[18] = "   " .. FlagRSP_Locale_ST_Cmd .. ": Spielleiter-Modus. Spieler leitet RP bzw. einen Plot. ";
   FlagRSP_Locale_Help[18] = "   " .. FlagRSP_Locale_NoCStatus_Cmd .. ": Charakter-Status-Flag entfernen.";
   FlagRSP_Locale_Help[20] = "/rsp " .. FlagRSP_Locale_AFK_Cmd .. " --> Setzt Spieler auf afk uns stoppt das Senden der eigenen Flags.";
   FlagRSP_Locale_Help[21] = "/rsp " .. FlagRSP_Locale_Status_Cmd .. " --> Zeigt eine \195\156bersicht der Optionen f\195\188r den aktuellen Spieler.";
   FlagRSP_Locale_Help[22] = "/rsp " ..FlagRSP_Locale_OwnTooltip_Cmd .. " --> (De)Aktiviert die Anzeige eines Tooltips f\195\188r sich selbst.";
   FlagRSP_Locale_Help[23] = "/rspan --> Aktiviert normales Rollenspiel-Flag und alternative Namens- und Levelanzeige.";
   FlagRSP_Locale_Help[24] = "/rspaus --> Deaktiviert Rollenspiel-Flag, alternative Namens- und Levelanzeige und l\195\182scht Nachnamen und Titel.";
   
   -- Text for notes in info box.
   FlagRSP_Locale_InfoBoxNotes = "Notizen:";
   -- Text for description in info box.
   FlagRSP_Locale_InfoBoxDesc = "Beschreibung:";

   -- Text for title in description tag warning.
   FlagRSP_Locale_DescWarnTitle = "WARNUNG!";
   -- Text for description tag warning.
   -- This is important to show the user a warning box when entering a description.
   -- Ugly readable, isn't it? 
   -- Some explanations: "\n" means new line (same as if you hit enter).
   --                    |CFFFF0000...|r means everything inbewtween will be colored red ("..." here).
   --                    \" is a "-character.
   FlagRSP_Locale_DescWarnText = "Du hast soeben eine Option aufgerufen, mit der du eine Beschreibung deines Charakters eingeben kannst. |CFFFF0000BITTE LIES DIESE INFORMATIONEN AUFMERKSAM, BEVOR DU EINE BESCHREIBUNG ANLEGST!|r\n\nDer EINZIGE Sinn und Zweck des Description-Tags ist, eine Beschreibung der \195\164u\195\159eren Merkmale seines Charakters anzugeben. Dementsprechend sollte die Beschreibung auch nur Merkmale enthalten, die andere Charaktere deinem Charakter von au\195\159en ansehen k\195\182nnen. Dazu z\195\164hlt nicht die Hintergrundgeschichte deines Charakters oder irgendwas, dass man ihm/ihr nicht ohne weiteres Wissen ansehen k\195\182nnte.\n\nSo kann man z.B. das Aussehen beschreiben oder immer wiederkehrende Bewegungen aufz\195\164hlen.\n\nBeispiele f\195\188r sinngem\195\164\195\159en Gebrauch:\n\n- \"Beispielus ist recht gro\195\159 f\195\188r einen Zwerg und hat einen sehr dicken Bauch.\"\n- \"Beispielus hat lange eine Narbe am Hals, die im Dunkeln leicht leuchtet.\"\n- \"Bei jedem Schritt, den Beispielus macht, hinkt er mit dem rechten Bein hinterher.\"\n\nBeispiele f\195\188r |CFFFF0000NICHT SINNGEM\195\132\195\159EN|r Gebrauch:\n\n- \"Beispielus war schon als kleines Kind sehr dick.\"\n- \"Beispielus hat seine Narbe aus einem Kampf mit einem b\195\182\195\182sen D\195\164mon.\"\n- \"Beispielus hat ein gebrochenes Bein.\"\n\nIch hoffe dieses Feature ist n\195\188tzlich und hilft, das Rollenspiel in WoW etwas zu verbessern!";

   -- Text for title in welcome box.
   FlagRSP_Locale_WelcomeTitle = "Willkommen!";
   -- Text for welcome box.
   FlagRSP_Locale_WelcomeHeader = "Willkommen zu |CFFFFFF7FflagRSP Version %flagRSPVersion|r!\n\n";
   FlagRSP_Locale_WelcomeText = "Offensichtlich benutzt du flagRSP zum ersten Mal (zumindest auf dieser WoW-Installation). Wenn du diese Nachricht liest, hast du flagRSP anscheinend erfolgreich installiert. Ich hoffe, du findest alle Optionen und Funktionen, die du suchst. Du kannst die Friendlist und flagRSPs Optionen \195\188ber den Button an der Minimap (den mit der Schriftrolle) \195\182ffnen. Weitere Optionen sind \195\188ber die Slash-Befehle /rsp und /fl verf\195\188gbar.\n\n|CFFFF0000BEACHTE:|r Du solltest unbedingt die Readme-Datei von flagRSP lesen (wenn nicht bereits geschehen). Diese befindet sich im flagRSP-Verzeichnis (<WoW>\\Interface\\AddOns\\flagRSP\\documentation\\flagRSP_readme_DE.txt) und enth\195\164lt einige wichtige Infomationen. Besonders der Teil |CFFFFFF7FSICHERHEIT|r ist absolut wichtig, wenn du deine Friendlist-Eintr\195\164ge oder deine Description nicht nach einem Crash m\195\182glicherweise verlieren m\195\182chtest.\n\n";
   FlagRSP_Locale_WelcomeHomepage = "F\195\188r aktuellste Informationen \195\188ber flagRSP besuche die flagRSP-Homepage:\n\nhttp://flokru.org/flagrsp/\n\nIch hoffe, flagRSP gef\195\164llt dir! Wenn du irgendwelche Probleme, W\195\188nsche, Vorschl\195\164ge oder Kritik bez\195\188glich flagRSP hast, z\195\182gere nicht, mich zu kontaktieren.\n\n\n|CFFD4D4D4Wichtigste \195\132nderungen in dieser Version (siehe Changelog f\195\188r Details):\n\n";
   FlagRSP_Locale_WelcomeChanges = "- Problem behoben, dass Auctioneer daran hinderte sich selbst beim \195\150ffnen des Auktionsfensters zu laden.\n- Bug gefixt, der flagRSP Beschreibungen anderer Spieler bei Pets mit gleichem Namen anzeigen lie\195\159.\n- \"/rsp purge\" hinzugef\195\188gt. L\195\164sst flagRSP alle gespeicherten Flags l\195\182schen.\n- Kleinere Bugs beim Light-Tooltip-Mode behoben.";


   -- Text for title in new version notification.
   FlagRSP_Locale_NewVersionTitle = "Neue Version!";
   -- Text for new version notification.
   -- |CFFFFFF7F%r.%m.%n|r is a color code again. %r.%m.%n will be the version number.
   FlagRSP_Locale_NewVersionText = "Eine neue Version von flagRSP ist verf\195\188gbar, zu der man ggf. updaten sollte.\n\nVerf\195\188gbare Version von flagRSP (mindestens): |CFFFFFF7F%r.%m.%n|r";
   -- Text for checkbutton.
   FlagRSP_Locale_NewVersionCheckButton = "Diese Meldung nicht wieder anzeigen.";

   -- Message after enabling ui names.
   FlagRSP_Locale_UINamesEnabled = "Anzeige der Namen im User-Interface aktiviert.";
   -- Message after disabling ui names.
   FlagRSP_Locale_UINamesDisabled = "Anzeige der Namen im User-Interface deaktiviert.";
   
   -- Messages for toggling the always show InfoBox option.
   FlagRSP_Locale_AlwaysShowInfoBox = "InfoBox wird automatisch neu ge\195\182ffnet, nachdem das Target ge\195\164ndert wurde."
   FlagRSP_Locale_InfoBoxTradBehaviour = "InfoBox wird nur automatisch neu ge\195\182ffnet, wenn neue Inhalte verf\195\188gbar sind oder sie manuell ge\195\182ffnet wird.";

   -- Message that flagRSP had to (re)join channel.
   FlagRSP_Locale_ReJoinedChannel = "Trete dem Kommunikations-Chatkanal bei.";

   -- Message that flagRSP is fully initialized.
   FlagRSP_Locale_Initialized = "flagRSP ist initialisiert. Viel Spa\195\159!";

   -- Message that tooltip manipulation is (de)activated.
   FlagRSP_Locale_ModifyTooltip = "Modifiziere Tooltips.";
   FlagRSP_Locale_LightModifyTooltip = "Modifiziere Tooltips nur im Light-Modus.";
   FlagRSP_Locale_NoModifyTooltip = "Modifiziere keine Tooltips mehr.";

   -- Message that flagRSP has been (un)set from/to standby.
   FlagRSP_Locale_StandBy = "Standby aktiviert. flagRSP verl\195\164sst Daten-Chatkanal.";
   FlagRSP_Locale_StandBy2 = "|CFFFF0000WARNUNG|r: Das Senden und Empfangen der Flags funktioniert nun |CFFFF0000NICHT|r mehr!";
   FlagRSP_Locale_NoStandBy = "Standby deaktiviert.";

   -- Message for purged entries.
   FlagRSP_Locale_EntriesPurged = "Es wurden |CFFFFFF7F%s|r alte, zwischengespeicherte Flags gel\195\182scht.";
   
   -- Message for changed purge interval.
   FlagRSP_Locale_PurgeInterval = "Neues Purge-Intervall f\195\188r zwischengespeicherte Flags gesetzt auf: |CFFFFFF7F%s|r Tage.";

   -- Buttons for DYK window.
   FlagRSP_Locale_NextTipButton = "N\195\164chster Tip";
   FlagRSP_Locale_CloseButton = "Schlie\195\159en";
   FlagRSP_Locale_DYKTitle = "Schon gewu\195\159t?";
   FlagRSP_Locale_DYKCheckText = "Diese Tips nicht wieder anzeigen.";

   FlagRSP_Locale_TipText = {};
   FlagRSP_Locale_TipText[1] = "Schon gewu\195\159t?\n\nflagRSP kann (auf nicht-PvP-Realms) auch Flags und Descriptions von Nutzern der anderen Fraktion anzeigen. Um flagRSP das Empfangen dieser Flags zu erm\195\182glichen, muss man sich einfach mit einem Charakter der anderen Fraktion einloggen. Je l\195\164nger man mit diesem eingeloggt bleibt, desto mehr Flags kann flagRSP empfangen.\nBenutze \"/rsp collect\", damit flagRSP auh\195\182rt, den AFK-Modus zu erkennen. Dann wird flagRSP trotz AFK weiterhin Descriptions anfordern (was AFK dann allerdings unterbricht). Mit diesem Befehl kann flagRSP Flags und Descriptions sammeln, ohne dass man AFK manuell regelm\195\164\195\159ig unterbrechen muss.";
   FlagRSP_Locale_TipText[2] = "Schon gewu\195\159t?\n\nflagRSP speichert Flags und Descriptions dauerhaft. Das schlie\195\159t auch Flags der anderen Fraktion mit ein. Mit Hilfe des Befehls \"/rsp purgeinterval x\" kann man einstellen, wie lange diese gespeichert werden sollen (\"x\" in Tagen).";
   FlagRSP_Locale_TipText[3] = "Schon gewu\195\159t?\n\nUm den Verlust der eigenen Description und der Friendlist-Eintr\195\164ge zu verhindern, solltest du REGELM\195\132\195\159IG flagRSPs Einstellungen sichern. In der flagRSP-Readme ist erkl\195\164rt, wie das geht.";
   FlagRSP_Locale_TipText[4] = "Schon gewu\195\159t?\n\nflagRSPs Minimap-Button kann mit Hilfe des Befehls \"/fl buttonpos x\" verschoben werden (mit \"x\" als Winkel zwischen 0 und 360).";
   FlagRSP_Locale_TipText[5] = "Schon gewu\195\159t?\n\nSowohl die InfoBox (die Box auf der linken Seite, die Descriptions und andere Informationen anzeigt) als auch der InfoBox-Button am TargetFrame (das Fenster, das Portrait und Lebens-/Manabalken des Ziels anzeigt) k\195\182nnen verschoben werden. Dazu muss man diese einfach mit der rechten Maustaste anklicken.";
   FlagRSP_Locale_TipText[6] = "Schon gewu\195\159t?\n\nFriendlisteintr\195\164ge k\195\182nnen einfach durch Doppelklick editiert werden.";
   FlagRSP_Locale_TipText[7] = "Schon gewu\195\159t?\n\nflagRSP \195\182ffnet kurz nach dem Betreten der Spielwelt f\195\188r wenige Sekunden die WoW-Freundesliste. Dies ist kein Bug.\nDie Funktionen, welche Informationen \195\188ber die Eintr\195\164ge der WoW-Freundesliste liefern, funktionieren nur, wenn diese Liste zuvor einmal ge\195\182ffnet war. Deshalb \195\182ffnet flagRSP sie f\195\188r einen kurzen Moment. Sobald ich eine bessere L\195\182sung f\195\188r dieses Problem finde, werde ich diese \195\150ffneroutine auch entfernen.";
   FlagRSP_Locale_TipText[8] = "Schon gewu\195\159t?\n\nWenn man einen anderen Charakter anw\195\164hlt, kann man ein Kontextmen\195\188 \195\182ffnen, indem man auf sein Portrait im TargetFrame rechtsklickt. Dieses Men\195\188 enth\195\164lt auch eine Option, um den Charakter zur Friendlist hinzuzuf\195\188gen bzw. seinen Eintrag zu editieren. Damit kann man Eintr\195\164ge hinzuf\195\188gen/editieren, ohne die Friendlist zu \195\182ffnen.";
   FlagRSP_Locale_TipText[9] = "Schon gewu\195\159t?\n\nMit Hilfe der Befehle \"/fl import\" bzw. \"/fl export\" kann man den Inhalt seiner WoW-Freundesliste in die Friendlist importieren (bzw. Friendlist nach WoW-Freundesliste exportieren).";
   FlagRSP_Locale_TipText[10] = "Schon gewu\195\159t?\n\nflagRSP unterst\195\188tzt Load-on-Demand-Funktionalit\195\164t. Daher enth\195\164lt es ein kleines Hilfsaddon namens flagRSPLoader, das flagRSP automatisch nach Betreten der Spielwelt l\195\164dt. flagRSPLoader kann so konfiguriert werden, dass das automatische Laden von flagRSP im Generellen, f\195\188r den aktuellen Realm oder f\195\188r den aktuellen Charakter (de)aktiviert wird. flagRSPLoader kann \195\188ber \"/rspload ?\" aufgerufen werden.";
   FlagRSP_Locale_TipText[11] = "Schon gewu\195\159t?\n\nflagRSP kennt drei verschiedene Methoden, die Tooltips zu behandeln.\n- Ein Modus ver\195\164ndert die Tooltips gar nicht. Dies ist sinnvoll f\195\188r Spieler, die andere Tooltip-Addons benutzen, die mit flagRSP gar nicht kompatibel sind (bzw. andersherum).\n- Der zweite Modus (Light-Modus) f\195\188gt zum Tooltip nur die Flags (Nachname, Titel, RP-Flag, Charakterstatus) hinzu, macht aber keine weitergehenden Ver\195\164nderungen (wie z.B. Farben oder das Verstecken von Informationen). Dieser Modus sollte zu allen anderen Tooltip-Addons kompatibel sein. Au\195\159erdem ist er signifikant schneller als der dritte Modus.\nProbiere diesen Modus, wenn du Probleme mit anderen Tooltip-Addons feststellst oder unbedingt h\195\182chste Performance willst (z.B. f\195\188r PvP oder Raids).\n- Der dritte Modus ist flagRSPs Standardmodus. Er benutzt eine Handlerroutine, die direkt mehrere Dinge am Tooltip \195\164ndert und unterst\195\188tzt alle flagRSP-Tooltip-Features (Flags, farbige Zeilen, versteckte Namen und Level, schicke H\195\164utbar-Zeile, etc.). Allerdings kann dieser Modus im Zusammenhang mit anderen Tooltip-Addons problematisch sein. Er ist nicht so schnell wie der zweite Modus, allerdings wird die Zeit, um einen Tooltip zu generieren, f\195\188r die meisten Nutzer \195\188berhaupt nicht sp\195\188rbar sein (in Zahlen: Tooltip-Generierung braucht ca. 1-10 ms).\n\nflagRSPs Tooltip-Modi k\195\182nnen durch Eingabe von \"/rsp toggletooltip\" umgeschaltet werden.";
   
   -- Message for collecting flags.
   FlagRSP_Locale_Collecting = "AFK-Erkennung deaktiviert, um Flags und Descriptions zu sammeln."
   FlagRSP_Locale_NoCollecting = "AFK-Erkennung aktiviert.";

   -- Texts for UnitPopupMenu.
   FlagRSP_Locale_AddEntry = "%UnitName zur Friendlist hinzuf\195\188gen";
   FlagRSP_Locale_EditEntry = "Eintrag f\195\188r %UnitName in Friendlist editieren";
   FlagRSP_Locale_ToggleBox = "InfoBox (de)aktivieren";

   -- Button to add friend/foe.
   FRIENDLIST_LOCALE_ADDFRIENDBUTTON = "Freund hinzuf.";
   -- Button to add Guild to Friendlist.
   FRIENDLIST_LOCALE_ADDGUILDBUTTON = "Gilde hinzuf.";
   -- Button to edit entry in Friendlist.
   FRIENDLIST_LOCALE_EDITENTRYBUTTON = "Eintrag editieren";
   -- Button to remove friend/foe.
   FRIENDLIST_LOCALE_REMOVEFRIENDBUTTON = "Freund entfernen";
   -- Button to edit own title and surname.
   FRIENDLIST_LOCALE_EDITTITLEBUTTON = "Titel";

   -- Button for filtering options in Friendlist.
   FRIENDLIST_LOCALE_FilterButton = "Filter";

   -- Button for saving char options in Friendlist.
   FRIENDLIST_LOCALE_CharResetButton = "R\195\188ckg\195\164ngig";
   -- Button for turning over Friendlist frames.
   FRIENDLIST_LOCALE_TurnPageButton = "Umbl\195\164ttern";

   -- General ok button.
   FRIENDLIST_LOCALE_OK_BUTTON = "OK";
   -- General abort button.
   FRIENDLIST_LOCALE_ABORT_BUTTON = "Abbrechen";
   -- General add button.
   FRIENDLIST_LOCALE_ADD_BUTTON = "Hinzuf\195\188gen";

   -- Title of add friend frame.
   FRIENDLIST_LOCALE_ADD_FRIEND_FRAME_TITLE = "Freund hinzuf\195\188gen";
   -- Text before name field in add friend frame.
   FRIENDLIST_LOCALE_ADD_FRIEND_FRAME_NAME_FIELD = "Name:";
   -- Text before surname field in add friend frame.
   FRIENDLIST_LOCALE_ADD_FRIEND_FRAME_SURNAME_FIELD = "Nachname:";
   -- Text before title field in add friend frame.
   FRIENDLIST_LOCALE_ADD_FRIEND_FRAME_TITLE_FIELD = "Titel:";
   -- Text before friendstate field in add friend frame.
   FRIENDLIST_LOCALE_ADD_FRIEND_FRAME_FRIENDSTATE_FIELD = "Friendstate:";
   -- Text before notes field in add friend frame.
   FRIENDLIST_LOCALE_ADD_FRIEND_FRAME_NOTES_FIELD = "Notizen:";
   -- Checkbutton for foe option in add friend frame.
   FRIENDLIST_LOCALE_ADD_FRIEND_FRAME_FOE_BUTTON = "Feind:";
   -- Button to add friend/foe in add friend frame.
   FRIENDLIST_LOCALE_ADD_FRIEND_FRAME_ADD_BUTTON = FRIENDLIST_LOCALE_ADD_BUTTON;
   -- Button to abort in add friend frame.
   FRIENDLIST_LOCALE_ADD_FRIEND_FRAME_ABORT_BUTTON = FRIENDLIST_LOCALE_ABORT_BUTTON;

   -- Title of add guild frame.
   FRIENDLIST_LOCALE_ADD_GUILD_FRAME_TITLE = "Gilde hinzuf\195\188gen";
   -- Button to add friend/foe in add guild frame.
   FRIENDLIST_LOCALE_ADD_FRIEND_FRAME_ADD_BUTTON = FRIENDLIST_LOCALE_ADD_BUTTON;
   -- Button to abort in add guild frame.
   FRIENDLIST_LOCALE_ADD_FRIEND_FRAME_ABORT_BUTTON = FRIENDLIST_LOCALE_ABORT_BUTTON;
   
   -- Title of edit entry frame.
   FRIENDLIST_LOCALE_EDITENTRY_FRAME_TITLE = "Eintrag editieren";
   -- Text before name field in edit entry frame.
   FRIENDLIST_LOCALE_EDITENTRY_FRAME_NAME_FIELD = FRIENDLIST_LOCALE_ADD_FRIEND_FRAME_NAME_FIELD;
   -- Text before surname field in edit entry frame.
   FRIENDLIST_LOCALE_EDITENTRY_FRAME_SURNAME_FIELD = FRIENDLIST_LOCALE_ADD_FRIEND_FRAME_SURNAME_FIELD;
   -- Text before notes field in edit entry frame.
   FRIENDLIST_LOCALE_EDITENTRY_FRAME_NOTES_FIELD = FRIENDLIST_LOCALE_ADD_FRIEND_FRAME_NOTES_FIELD;
   -- Checkbutton for foe option in edit entry frame.
   FRIENDLIST_LOCALE_EDITENTRY_FRAME_FOE_BUTTON = FRIENDLIST_LOCALE_ADD_FRIEND_FRAME_FOE_BUTTON;
   -- Button to accept friend/foe in edit entry frame.
   FRIENDLIST_LOCALE_EDITENTRY_FRAME_OK_BUTTON = FRIENDLIST_LOCALE_OK_BUTTON;
   -- Button to abort in edit entry frame.
   FRIENDLIST_LOCALE_EDITENTRY_FRAME_ABORT_BUTTON = FRIENDLIST_LOCALE_ABORT_BUTTON;

   -- Help.
   FRIENDLIST_LOCALE_HELP = {};
   FRIENDLIST_LOCALE_HELP[0] = "Friendlist: Hilfe --------------------------------------------------------------";
   FRIENDLIST_LOCALE_HELP[1] = "/fl --> Diese Hilfe anzeigen.";
   FRIENDLIST_LOCALE_HELP[2] = "/fl help --> Diese Hilfe anzeigen.";
   FRIENDLIST_LOCALE_HELP[3] = "/fl show --> Friendlist-Fenster anzeigen.";
   FRIENDLIST_LOCALE_HELP[4] = "/fl hide --> Friendlist-Fenster verstecken.";
   FRIENDLIST_LOCALE_HELP[5] = "/fl mm <an/aus> --> Zeigt den Button an der Minimap an oder blendet ihn aus.";
   FRIENDLIST_LOCALE_HELP[6] = "/fl buttonpos <ANGLE> --> Setzt Position des Minimapbuttons auf <ANGLE> mit 0<= <ANGLE> <=360.";
   FRIENDLIST_LOCALE_HELP[7] = "/fl add <NAME> <NACHNAME> --> Spieler/Objekt <NAME> mit Nachname <NACHNAME> zur Friendlist hinzuf\195\188gen.";
   FRIENDLIST_LOCALE_HELP[8] = "/fl addguild <NAME> --> Gilde <NAME> zur Friendlist hinzuf\195\188gen.";
   FRIENDLIST_LOCALE_HELP[9] = "/fl del <NAME> --> Spieler/Objekt/Gilde <NAME> aus Friendlist entfernen.";
   FRIENDLIST_LOCALE_HELP[10] = "/fl reset --> Komplette Friendlist OHNE WEITERE WARNUNG l\195\182schen.";
   FRIENDLIST_LOCALE_HELP[11] = "/fl import --> Importiere WoW-Freundesliste in die Friendlist.";
   FRIENDLIST_LOCALE_HELP[12] = "/fl export --> Exportiere die Friendlist in die WoW-Freundesliste.";
   FRIENDLIST_LOCALE_HELP[13] = "/add <NAME> <NACHNAME> <NOTIZ> --> F\195\188gt Spieler <NAME> mit <NACHNAME> und <NOTIZ> zur Friendlist hinzu.";

   FRIENDLIST_LOCALE_FRIENDSTATE_TEXT = {};
   -- Text for friendstate -10.
   FRIENDLIST_LOCALE_FRIENDSTATE_TEXT[-10] = "Feind";
   -- Text for friendstate +10.
   FRIENDLIST_LOCALE_FRIENDSTATE_TEXT[10] = "Freund";
   -- Text for friendstate 0.
   FRIENDLIST_LOCALE_FRIENDSTATE_TEXT[0] = "Bekannt";

   FRIENDLIST_LOCALE_GUILDFRIENDSTATE_TEXT = {};
   -- Text for friendstate -10.
   FRIENDLIST_LOCALE_GUILDFRIENDSTATE_TEXT[10] = "Befreundete Gilde";
   -- Text for friendstate +10.
   FRIENDLIST_LOCALE_GUILDFRIENDSTATE_TEXT[-10] = "Verfeindete Gilde";
   -- Text for friendstate 0.
   FRIENDLIST_LOCALE_GUILDFRIENDSTATE_TEXT[0] = "Bekannte Gilde";

   -- Bindings.
   -- Texts for the bindings menu in WoW.
   BINDING_HEADER_FRIENDLIST_LOCALE_HEADER = "flagRSP & Friendlist";
   BINDING_NAME_FRIENDLIST_LOCALE_NAME = "Friendlist Frame \195\182ffnen";
   BINDING_NAME_FRIENDLIST_LOCALE_ADDFRIEND = "Freund hinzuf\195\188gen";
   BINDING_NAME_FRIENDLIST_LOCALE_ADDGUILD = "Gilde hinzuf\195\188gen";
   BINDING_NAME_FRIENDLIST_LOCALE_TOGGLEBOX = "InfoBox umschalten";

   -- Strings for the new GUI.
   -- Online status for Friendlist.
   -- does not need to be translated.
   FRIENDLIST_LOCALE_OnlineStatusLoc = "[%FriendlistOnline, %FriendlistLocation]";
   FRIENDLIST_LOCALE_OnlineStatusNoLoc = "[%FriendlistOnline]";

   -- Title for char page.
   -- %UnitName is the player's name.
   FRIENDLIST_LOCALE_CharFrameTitle = "Charakterseite von %UnitName";
   -- Title of certificate.
   FRIENDLIST_LOCALE_CertTitle = "Identit\195\164tsnachweis";
   -- Line 1 of certificate.
   FRIENDLIST_LOCALE_CertText1 = "Dieses Dokument bescheinigt, dass der %UnitRace, %UnitClass";
   -- Line 2 of certificate.
   FRIENDLIST_LOCALE_CertText2 = "%UnitName";
   -- Line 3 of certificate.
   FRIENDLIST_LOCALE_CertText3 = "folgenden Titel tr\195\164gt:";
   -- Line 4 of certificate.
   FRIENDLIST_LOCALE_CertText4 = "\195\132u\195\159ere Merkmale:";
   -- Line 5 of certificate.
   FRIENDLIST_LOCALE_CertText5 = "Azeroth Identifikationsb\195\188ro";

   -- Line before rp type dropdown box.
   FRIENDLIST_LOCALE_RpTypeText = "Bevorzugte Rollenspielart:";
   -- Line before explanation of rp type.
   FRIENDLIST_LOCALE_RpExplanation = "Erkl\195\164rung:";
   -- Line before character status dropdown box.
   FRIENDLIST_LOCALE_CSText = "Derzeitiger Charakterstatus:";
   
   -- Different rp type texts for drop down box.
   FRIENDLIST_LOCALE_DropDownRP0 = "Kein Rollenspiel-Flag"; 
   FRIENDLIST_LOCALE_DropDownRP1 = "Normales Rollenspiel"; 
   FRIENDLIST_LOCALE_DropDownRP2 = "Gelegenheitsrollenspiel, teilweise OOC"; 
   FRIENDLIST_LOCALE_DropDownRP3 = "Vollzeitrollenspiel, gar kein OOC"; 
   FRIENDLIST_LOCALE_DropDownRP4 = "Rollenspielanf\195\164nger"; 
   
   -- Different character status texts for drop down box.
   FRIENDLIST_LOCALE_DropDownCSNone = "Kein Charakterstatus";
   FRIENDLIST_LOCALE_DropDownCSOOC = "Out of character spielen";
   FRIENDLIST_LOCALE_DropDownCSIC = "In character spielen";
   FRIENDLIST_LOCALE_DropDownCSFFAIC = "In character spielen, nach Kontakt suchen";
   FRIENDLIST_LOCALE_DropDownCSST = "Als Spielleiter spielen";

   -- Different explanations for rp types.
   -- again color codes and others.
   FRIENDLIST_LOCALE_DropDownRP0Expl = "W\195\164hle dies, wenn du gar kein Rollenspiel-Flag senden m\195\182chtest. Da die Idee dieses Flags ist, anderen Spielern seine bevorzugte Rollenspielart zu zeigen, solltest du es dir sogf\195\164ltig \195\188berlegen, bevor du es deaktivierst.\nBitte beachte, dass das RP-Flag nicht dazu gedacht ist, die Qualit\195\164t des Rollenspiels der Spieler zu bewerten. Der einzige Sinn liegt darin, anderen zu zeigen, wie du deine Rolle spielen willst.";
   FRIENDLIST_LOCALE_DropDownRP1Expl = "Ein |cffE0E0E0normaler bzw. durchschnittlicher Rollenspieler|r spielt haupts\195\164chlich seine Rolle. Allerdings benutzt er manchmal OOC-Sprache (z.B. zur Koordination in /p) oder akzeptiert zumindest sporadische OOC-Sprache.\nBitte beachte, dass dies nur deine bevorzugte Spielart ist. Du solltest immer in der Lage sein, dich anzupassen, wenn du mit anderen Spielern spielst.";
   FRIENDLIST_LOCALE_DropDownRP2Expl = "Ein |cffE0E0E0Gelegenheitsrollenspieler|r will seine Rolle spielen, kann aber auf OOC-Sprache nicht verzichten.\nBitte beachte, dass dies nur deine bevorzugte Spielart ist. Du solltest immer in der Lage sein, dich anzupassen, wenn du mit anderen Spielern spielst. Da OOC-Sprache f\195\188r manche Rollenspieler ein sehr kritisches Thema ist, solltest du immer r\195\188cksichtsvoll damit umgehen.";
   FRIENDLIST_LOCALE_DropDownRP3Expl = "Ein |cffE0E0E0Vollzeitrollenspieler|r will zu jeder Zeit seine Rolle spielen und nie OOC-Sprache benutzen oder h\195\182ren.\nBitte beachte, dass dies nur deine bevorzugte Spielart ist. Du solltest immer in der Lage sein, dich anzupassen, wenn du mit anderen Spielern spielst. Au\195\159erdem solltest du beachten, dass einige Spieler OOC-Sprache brauchen. Sei r\195\188cksichtsvoll und bleibe gelassen, wenn es jemand nutzt.";
   FRIENDLIST_LOCALE_DropDownRP4Expl = "W\195\164hle |cffE0E0E0Rollenspielanf\195\164nger|r, wenn Rollenspiel f\195\188r dich etwas Neues ist und du bef\195\188rchtest, nicht zu wissen, wie du dich in bestimmten Situationen verhalten sollst oder Angst hast, Fehler zu machen. Andere Spieler k\195\182nnen sehen, dass du ein Anf\195\164nger bist. Sie sollten dich unterst\195\188tzen und dir Hilfen geben. Z\195\182gere nicht, nach Hilfe zu fragen! Normalerweise sind Rollenspieler sehr nett, wenn sie feststellen, dass man interessiert ist.";
   
   -- Different explanations for character status.
   FRIENDLIST_LOCALE_DropDownCSNoneExpl = "W\195\164hle dies, wenn du keine Informationen zu deinem derzeitigen Charakterstatus senden willst. Kein anderer Spieler kann feststellen, ob du IC oder OOC spielst oder ob du nach Mitspielern suchst.";
   FRIENDLIST_LOCALE_DropDownCSOOCExpl = "W\195\164hle |cffE0E0E0out of character|r,wenn du zur Zeit NICHT deine Rolle spielst und du auch keine IC-Kontakte willst (z.B. beim Farmen nach Questgegenst\195\164nden oder beim Leveln). Diese Information kann f\195\188r dich und auch andere Spieler sinnvoll sein.";
   FRIENDLIST_LOCALE_DropDownCSICExpl = "W\195\164hle |cffE0E0E0in Character|r, wenn du zur Zeit deine Rolle spielst. Denke immer daran, dass deine Handlungen und deine Sprache zu deinem Charakter passen sollten. Andere Spieler k\195\182nnen dich ansprechen.";
   FRIENDLIST_LOCALE_DropDownCSFFAICExpl = "W\195\164hle dies, wenn du z.Zt. deine Rolle spielst (s. |cffE0E0E0in Character|r) und auf der Suche nach Mitspielern bist. Dieser spezielle \"Einladungs\"-Modus zeigt anderen Spielern, dass du an Rollenspiel interessiert bist und f\195\188r dieses zur Verf\195\188gung stehst.";
   FRIENDLIST_LOCALE_DropDownCSSTExpl = "|cffE0E0E0Spielleiter|r sind erfahrene Spieler, die Plots schreiben und diese spielen lassen wollen. Dies geschieht in der Spielwelt, im Chat oder beidem. Benutze dieses Flag, falls du gerade einen Plot ausspielen willst bzw. daf\195\188r Spieler (als PC oder NPC) suchst.";

   -- Drop down elements for Friendlist sorting.
   FRIENDLIST_LOCALE_SortDropDown_AlphOnline = "Alphabetisch (Vorname) sortieren, Online zuerst";
   FRIENDLIST_LOCALE_SortDropDown_AlphOnlineSurname = "Alphabetisch (Nachname) sortieren, Online zuerst";
   FRIENDLIST_LOCALE_SortDropDown_FStateOnline = "Nach Freundesstatus sortieren, Online zuerst";
   FRIENDLIST_LOCALE_SortDropDown_TypeOnline = "Nach Typ sortieren, Online zuert";
   FRIENDLIST_LOCALE_SortDropDown_EDateOnline = "Nach Eintragszeitpunkt sortieren, Online zuerst";
   FRIENDLIST_LOCALE_SortDropDown_Alph = "Alphabetisch (Vorname) sortieren";
   FRIENDLIST_LOCALE_SortDropDown_AlphSurname = "Alphabetisch (Nachname) sortieren";
   FRIENDLIST_LOCALE_SortDropDown_FState = "Nach Freundesstatus sortieren";
   FRIENDLIST_LOCALE_SortDropDown_Type = "Nach Typ sortieren";
   FRIENDLIST_LOCALE_SortDropDown_EDate = "Nach Eintragszeitpunkt sortieren";
   
   -- Friendlist text for trad. Level display.
   FRIENDLIST_LOCALE_LevelLine = "Stufe ";
   -- Friendlist text for online players.
   FRIENDLIST_LOCALE_OnlineLine = "Online";
   -- Friendlist text for offline players.
   FRIENDLIST_LOCALE_OfflineLine = "Offline";
   -- Friendlist text for guilds.
   FRIENDLIST_LOCALE_GuildLine = "Gilde";

   -- old and former unlocalized strings.
   -- Entry added to Friendlist.
   -- %n is the name of the entry.
   FRIENDLIST_LOCALE_AddFriendMsg = "%n zur Friendlist hinzugef\195\188gt.";
   -- Entry deleted from Friendlist.
   FRIENDLIST_LOCALE_DelFriendMsg = "%n von der Friendlist gel\195\182scht.";
   -- Edit entry and select new name that already exists error / Add existing name error.
   FRIENDLIST_LOCALE_NameExistsMsg = "Eintrag %n existiert bereits.";
   
   -- Tab for normal view and group view.
   FRIENDLIST_LOCALE_NormalView = "Normalansicht";
   FRIENDLIST_LOCALE_GroupView = "Gruppenansicht";

   -- Tooltip for the minimap button.
   FRIENDLIST_LOCALE_MMBUTTON_TOOLTIP = "Friendlist bzw. flagRSP-Interface \195\182ffnen";
end


-- Version : English

GuildML_TITLE			= "Guild Mail List";

-- Main frame

GuildML_tSet1			= ": Mail timeout set to ";
GuildML_tSet2			= " seconds.";

GuildML_tSet3			= ": Usage: /gml timeout [1-60]";

GuildML_tDesc1 			= "Please select the players you wish";
GuildML_tDesc2 			= "to send the mail to:";

GuildML_tDesc3 			= "If you only see <Friends> in Delivery";
GuildML_tDesc4 			= "then you do not have rights to send";
GuildML_tDesc5 			= "to the guild.";

GuildML_tHelp			= "Guild Mail List: Guild Mail List adds a button to the Send Mail screen between the To: and Postage: areas.  This button opens a window where you cam create a mailing lists. Due to lag, GuildMailer may time out while trying to send a message.  You can adjust the timeout period in seconds using the \"/gml timeout [1-60]\" command."

GuildML_tCount 			= "Count";
GuildML_tUse 			= "Use";

GuildML_tClass		 	= "Class:";
GuildML_tRank		 	= "Rank:";
GuildML_tLevels		 	= "Levels:";
GuildML_tLevelSeparator = "to";
GuildML_tLastOn			= "On in Last:";
GuildML_tLastOnDays		= "Days"
GuildML_tGroup			= "Delivery to:";

GuildML_tNumCount		= "Number of Matching Players: "
GuildML_tCost			= "Send Cost:"
GuildML_tsNumCount		= "Found: "
GuildML_tsCost			= "Total Cost:"

GuildML_BUTTON_TOOLTIP1 = "Mailing List";
GuildML_BUTTON_TOOLTIP2 = "Click to create a Mailing List."

GuildML_sendStatus = "Sending Mail to: "

GuildML_sendTxt1		= ": Sending message <"
GuildML_sendTxt2		= "> to your mailing list. Please don't close the mail interface until sending is complete."

GuildML_UpdTxt1			= ": Finished sending <"

GuildML_sendFail1		= ": Failed to send <"
GuildML_sendFail2		= "> to "
GuildML_sendFail3		= "! Recipient invalid or timeout!"

-- Class				
GuildML_CLASSES		= {
					[1] = "All",
					[2] = "Warrior",
					[3] = "Shaman",
					[4] = "Paladin",
					[5] = "Druid",
					[6] = "Rogue",
					[7] = "Hunter",
					[8] = "Warlock",
					[9] = "Mage",
					[10] = "Priest"
				};

GuildML_RANK_QUALIFIER = {
					[1] = "<=",
					[2] = "==",
					[3] = ">="
				};
								
-- Version : German

if ( GetLocale() == "deDE" ) then

GuildML_TITLE			= "Guild Mail List";

-- Main frame

GuildML_tSet1			= ": Mail Timeout ist nun bei ";
GuildML_tSet2			= " Sekunden.";

GuildML_tSet3			= ": Benutze: /gml timeout [1-60]";

GuildML_tDesc1 			= "Bitte w\195\164hle die gew\195\188nschten";
GuildML_tDesc2 			= "Kategorien aus, um zu senden:";

GuildML_tDesc3 			= "Wenn du nur < Friends > bei < An >";
GuildML_tDesc4 			= "siehst, fehlt die Berechtigung";
GuildML_tDesc5 			= "an die Gilde zu senden.";

GuildML_tHelp			= "Guild Mail List: Guild Mail List addiert einen Button zwischen An: Bereich. Dieser Button \195\182ffnet ein Fenster wo eine Verteilerliste erstellt werden kann. Aufgrund von Laggs, kann GuildMailer abundzu ein Timeout w\195\164hrend des Sendens bekommen. Du kannst den maximalen Timeout mit \"/gml timeout [1-60]\" einstellen."

GuildML_tCount 			= "Z\195\164hlen";
GuildML_tUse 			= "Verwenden";

GuildML_tClass		 	= "Klasse:";
GuildML_tRank		 	= "Rang:";
GuildML_tLevels		 	= "Stufen:";
GuildML_tLevelSeparator = "bis";
GuildML_tLastOn			= "Online:";
GuildML_tLastOnDays		= "Tagen (Zuletzt)"
GuildML_tGroup			= "An:";

GuildML_tNumCount		= "Anzahl zutreffender Spieler: "
GuildML_tCost			= "Sendekosten:"
GuildML_tsNumCount		= "Gefunden: "
GuildML_tsCost			= "Gesamtkosten:"

GuildML_BUTTON_TOOLTIP1 = "Verteilerliste";
GuildML_BUTTON_TOOLTIP2 = "Dr\195\188cke um die Verteilerliste zu erstellen."

GuildML_sendStatus		= "Sende Mail an: "

GuildML_sendTxt1		= ": Sende Nachricht <"
GuildML_sendTxt2		= "> an deine Verteilerliste. Achtung, schlie\195\159e auf keinen Fall das Mail Fenster solange noch gesendet wird."

GuildML_UpdTxt1			= ": Senden beendet <"

GuildML_sendFail1		= ": Nicht gesendet <"
GuildML_sendFail2		= "> an "
GuildML_sendFail3		= "! Empf\195\164nger ung\195\188ltig oder Timeout!"

-- Class				
GuildML_CLASSES			= {
						[1] = "All",
						[2] = "Krieger",
						[3] = "Shamane",
						[4] = "Paladin",
						[5] = "Druide",
						[6] = "Schurke",
						[7] = "J\195\164ger",
						[8] = "Hexenmeister",
						[9] = "Magier",
						[10] = "Priester"
						};
end
--[[
   à : \195\160    è : \195\168    ì : \195\172    ò : \195\178    ù : \195\185   Ä : \195\132
   á : \195\161    é : \195\169    í : \195\173    ó : \195\179    ú : \195\186   Ö : \195\150
   â : \195\162    ê : \195\170    î : \195\174    ô : \195\180    û : \195\187   Ü : \195\156
   ã : \195\163    ë : \195\171    ï : \195\175    õ : \195\181    ü : \195\188   ß : \195\159
   ä : \195\164                    ñ : \195\177    ö : \195\182
   æ : \195\166                                    ø : \195\184
   ç : \195\167
--]]

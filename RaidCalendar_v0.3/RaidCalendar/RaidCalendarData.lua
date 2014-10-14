--[[
//##############################################################################
//# Autor: M. Herrmann
//# Datum: 2006-07-04
//# Letzte Aenderung: 20060709
//#
//# Enthält die Informationen über Serverstandorte.
//# Jeder Eintrag benötigt folgende Informationen:
//#
//# ShortName      : Ein eindeutiges Kuerzel für den Serverstandort. Dieses 
//#                  Kuerzel wird intern zur Identifizierung des Standortes
//#                  verwendet. 
//# Name           : Der volle Name des Standortes, wie er im Tooltip bzw. in 
//#                  der Serverauswahl angezeigt werden soll.
//#                  Der Text sollte mittels einer Konstante in der Datei 
//#                  localization.xx.lua definiert sein
//##############################################################################
]]
ICalServers = {
	[1] = {
		ShortName = "EU",
		Name = RAIDCLOC_SERVERS_EUROPE
	},
	[2] = {
		ShortName = "US",
		Name = RAIDCLOC_SERVERS_US
	}
}
--[[
//##############################################################################
//# Enthält die Instanzdefinitionen.
//# Zu jeder Instanz, die im Raidkalender angezeigt werden soll, werden
//# folgende Informationen benoetigt:
//#
//# ShortName      : Ein eindeutiges Kuerzel für die Instanz. Dieses Kuerzel 
//#                  wird intern zur Identifizierung der Instanz verwendet. 
//# Name           : Der volle Name der Instanz, wie er im Tooltip bzw. in der
//#                  Instanzauswahl angezeigt werden soll.
//#                  Der Text sollte mittels einer Konstante in der Datei 
//#                  localization.xx.lua definiert sein
//# ResetTime      : Die Uhrzeit, zu der die Instanz in der Regel zurückgesetzt 
//#                  wird. Kann auch ein freier Text seon, falls keine genaue 
//#                  Uhrzeit bekannt ist
//# ResetInterval  : Die Anzahl Tage, nach der die Instanz zurückgesetzt wird.
//# FirstResetDay  : Der Tag eines bekannten vergangenen Datums, an dem die 
//#                  Instanz zurückgesetzt wurde. Dieses Datum dient als 
//#                  Grundlage für die Berechnung der folgenden Tage
//# FirstResetMonth: Der Monat eines bekannten vergangenen Datums, an dem die 
//#                  Instanz zurückgesetzt wurde
//# FirstResetYear : Das Jahrt eines bekannten vergangenen Datums, an dem die 
//#                  Instanz zurückgesetzt wurde.
//# Texture        : Der Pfad zur textur, die für das Icon im Kalender 
//#                  verwendet werden soll
//##############################################################################
]]
	
ICalInstances = {
	[1] = {
		ShortName = "MC",
		Name = RAIDCLOC_INSTANCENAMES_MC, 
		Texture = "interface\\icons\\spell_nature_earthquake",
		Reset = {
			EU = {
				ResetTime = RAIDCLOC_RESETTIME_MAINTENANCE,
				ResetInterval = 7,
				FirstResetDay = 4,
				FirstResetMonth = 1,
				FirstResetYear = 2006,
			},
			US = {
				ResetTime = RAIDCLOC_RESETTIME_MAINTENANCE,
				ResetInterval = 7,
				FirstResetDay = 3,
				FirstResetMonth = 1,
				FirstResetYear = 2006,
			}
		}
	},
	[2] = {
		ShortName = "BWL",
		Name = RAIDCLOC_INSTANCENAMES_BWL,
		Texture = "interface\\icons\\inv_misc_head_dragon_black",
		Reset = {
			EU = {
				ResetTime = RAIDCLOC_RESETTIME_MAINTENANCE,
				ResetInterval = 7,
				FirstResetDay = 4,
				FirstResetMonth = 1,
				FirstResetYear = 2006
			},
			US = {
				ResetTime = RAIDCLOC_RESETTIME_MAINTENANCE,
				ResetInterval = 7,
				FirstResetDay = 3,
				FirstResetMonth = 1,
				FirstResetYear = 2006
			}
		}
	},
	[3] = {
		ShortName = "AQ40",
		Name = RAIDCLOC_INSTANCENAMES_AQ40, 
		Texture = "interface\\icons\\spell_shadow_auraofdarkness",
		Reset = {
			EU = {
				ResetTime = RAIDCLOC_RESETTIME_MAINTENANCE,
				ResetInterval = 7,
				FirstResetDay = 4,
				FirstResetMonth = 1,
				FirstResetYear = 2006
			},
			US = {
				ResetTime = RAIDCLOC_RESETTIME_MAINTENANCE,
				ResetInterval = 7,
				FirstResetDay = 3,
				FirstResetMonth = 1,
				FirstResetYear = 2006
			}
		}
	},
	[4] = {
		ShortName = "NAX",
		Name = RAIDCLOC_INSTANCENAMES_NAX, 
		Texture = "interface\\icons\\spell_nature_removecurse",
		Reset = {
			EU = {
				ResetTime = RAIDCLOC_RESETTIME_MAINTENANCE,
				ResetInterval = 7,
				FirstResetDay = 4,
				FirstResetMonth = 1,
				FirstResetYear = 2006
			},
			US = {
				ResetTime = RAIDCLOC_RESETTIME_MAINTENANCE,
				ResetInterval = 7,
				FirstResetDay = 3,
				FirstResetMonth = 1,
				FirstResetYear = 2006
			}
		}
	},
	[5] = {
		ShortName = "ZG",
		Name = RAIDCLOC_INSTANCENAMES_ZG, 
		Texture = "interface\\icons\\spell_nature_guardianward",
		Reset = {
			EU = {
				ResetTime = "4:00",
				ResetInterval = 3,
				FirstResetDay = 4,
				FirstResetMonth = 1,
				FirstResetYear = 2006
			},
			US = {
				ResetTime = "3:00",
				ResetInterval = 3,
				FirstResetDay = 4,
				FirstResetMonth = 1,
				FirstResetYear = 2006
			}
		}
	},
	[6] = {
		ShortName = "AQ20",
		Name = RAIDCLOC_INSTANCENAMES_AQ20, 
		Texture = "interface\\icons\\spell_shadow_carrionswarm",
		Reset = {
			EU = {
				ResetTime = "4:00",
				ResetInterval = 3,
				FirstResetDay = 4,
				FirstResetMonth = 1,
				FirstResetYear = 2006
			},
			US = {
				ResetTime = "3:00",
				ResetInterval = 3,
				FirstResetDay = 4,
				FirstResetMonth = 1,
				FirstResetYear = 2006
			}
		}
	},
	[7] = {
		ShortName = "ONY",
		Name = RAIDCLOC_INSTANCENAMES_ONY, 
		Texture = "interface\\icons\\inv_misc_head_dragon_01",
		Reset = {
			EU = {
				ResetTime = "4:00",
				ResetInterval = 5,
				FirstResetDay = 3,
				FirstResetMonth = 1,
				FirstResetYear = 2006
			},
			US = {
				ResetTime = "3:00",
				ResetInterval = 5,
				FirstResetDay = 4,
				FirstResetMonth = 1,
				FirstResetYear = 2006
			}
		}
	}
};


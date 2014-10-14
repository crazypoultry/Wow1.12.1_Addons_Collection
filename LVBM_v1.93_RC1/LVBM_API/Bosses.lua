



function LVBosses_Load_Naxx()
LVBM.Bosses[LVBM_NAXX] = {
		["ANUB"] = {
			["startMethod"] = "YELL",
			["name"] = LVBM_AR_NAME,
			["startTrigger"] = {
				[LVBM_AR_YELL_1] = true,
				[LVBM_AR_YELL_2] = true,
				[LVBM_AR_YELL_3] = true,
			},
			["BossMods"] = {
				"AnubRekhan",
			},
		},
		["FAERLINA"] = {
			["startMethod"] = "YELL",
			["name"] = LVBM_GWF_NAME,
			["startTrigger"] = {
				[LVBM_GWF_YELL_1] = true,
				[LVBM_GWF_YELL_2] = true,
				[LVBM_GWF_YELL_3] = true,
				[LVBM_GWF_YELL_4] = true,
			},
			["BossMods"] = {
				"GrandWidowFaerlina",
			},
		},
		["MAEXXNA"] = {
			["startMethod"] = "COMBAT",
			["name"] = LVBM_MAEXXNA_NAME,
			["delay"] = 4,
			["BossMods"] = {
				"Maexxna",
			},
		},

		["RAZUVIOUS"] = {
			["startMethod"] = "YELL",
			["name"] = LVBM_IR_NAME,
			["startTrigger"] = {
				[LVBM_IR_YELL_1] = true,
				[LVBM_IR_YELL_2] = true,
				[LVBM_IR_YELL_3] = true,
				[LVBM_IR_YELL_4] = true,
			},
			["BossMods"] = {
				"Razuvious",
			},
		},
		["GOTHIK"] = {
			["startMethod"] = "YELL",
			["name"] = LVBM_GOTH_NAME,
			["startTrigger"] = {
				[LVBM_GOTH_YELL_START1] = true,
			},
			["BossMods"] = {
				"Gothik",
			},
		},
		["HORSEMEN"] = {
			["startMethod"] = "COMBAT",
			["name"] = LVBM_FOURHORSEMEN_THANE,
			["realName"] = LVBM_FOURHORSEMEN_REAL_NAME,
			["killName"] = {
				["THANE"] = {
					["notKilled"] = true,
					["name"] = LVBM_FOURHORSEMEN_THANE,
				},
				["LADY"] = {
					["notKilled"] = true,
					["name"] = LVBM_FOURHORSEMEN_LADY,
				},
				["MOGRAINE"] = {
					["notKilled"] = true,
					["name"] = LVBM_FOURHORSEMEN_MOGRAINE,
				},
				["ZELIEK"] = {
					["notKilled"] = true,
					["name"] = LVBM_FOURHORSEMEN_ZELIEK,
				},
			},
			["delay"] = 5,
			["BossMods"] = {
				"FourHorsemen",
			},
		},


		["NOTH"] = {
			["startMethod"] = "YELL",
			["name"] = LVBM_NTP_NAME,
			["startTrigger"] = {
				[LVBM_NTP_YELL_START1] = true,
				[LVBM_NTP_YELL_START2] = true,
				[LVBM_NTP_YELL_START3] = true,
			},
			["BossMods"] = {
				"Noth",
			},
		},
		["HEIGAN"] = {
			["startMethod"] = "YELL",
			["name"] = LVBM_HTU_NAME,
			["startTrigger"] = {
				[LVBM_HTU_YELL_START1] = true,
				[LVBM_HTU_YELL_START2] = true,
				[LVBM_HTU_YELL_START3] = true,
			},
			["BossMods"] = {
				"Heigan",
			},
		},
		["LOATHEB"] = {
			["startMethod"] = "COMBAT",
			["name"] = LVBM_LOATHEB_NAME,
			["delay"] = 5,
			["BossMods"] = {
				"Loatheb",
			},
		},

		["PATCHWERK"] = {
			["startMethod"] = "YELL",
			["name"] = LVBM_PW_NAME,
			["startTrigger"] = {
				[LVBM_PW_YELL_1] = true,
				[LVBM_PW_YELL_2] = true,
			},
			["BossMods"] = {
				"Patchwerk",
			},
		},
		["GROBBULUS"] = {
			["startMethod"] = "COMBAT",
			["name"] = LVBM_GROBB_NAME,
			["delay"] = 5,
			["BossMods"] = {
				"Grobbulus",
			},
		},
		["GLUTH"] = {
			["startMethod"] = "COMBAT",
			["name"] = LVBM_GLUTH_NAME,
			["delay"] = 10,
			["BossMods"] = {
				"Gluth",
			},
		},
		["THADDIUS"] = {
			["startMethod"] = "YELL",
			["name"] = LVBM_THADDIUS_NAME,
			["startTrigger"] = {
				[LVBM_THADDIUS_PHASE1_YELL1] = true,
			},
			["BossMods"] = {
				"Thaddius",
			},
		},
		
		["SAPPHIRON"] = {
			["startMethod"] = "COMBAT",
			["name"] = LVBM_SAPPHIRON_NAME,
			["delay"] = 5,
			["BossMods"] = {
				"Sapphiron",
			},
		},
		["KELTHUZAD"] = {
			["startMethod"] = "YELL",
			["name"] = LVBM_KELTHUZAD_NAME,
			["minCombatTime"] = 60,
			["startTrigger"] = {
				[LVBM_KELTHUZAD_PHASE1_EXPR] = true,
			},
			["BossMods"] = {
				"Kelthuzad",
			},
		},
	};
end

function LVBosses_Load_AQ40()
LVBM.Bosses[LVBM_AQ40] = {
		["SKERAM"] = {
			["startMethod"] = "COMBAT",
			["name"] = LVBM_SKERAM_NAME,
			["delay"] = 5,
			["BossMods"] = {
				"Skeram",
			},
		},
		["BUGS"] = {
			["startMethod"] = "COMBAT",
			["name"] = LVBM_THREEBUGS_VEM,
			["killName"] = {
				["YAUJ"] = {
					["notKilled"] = true,
					["name"] = LVBM_THREEBUGS_YAUJ,
				},
				["VEM"] = {
					["notKilled"] = true,
					["name"] = LVBM_THREEBUGS_VEM,
				},
				["KRI"] = {
					["notKilled"] = true,
					["name"] = LVBM_THREEBUGS_KRI,
				},
			},
			["realName"] = LVBM_THREEBUGS_REAL_NAME,
			["delay"] = 10,
			["BossMods"] = {
				"ThreeBugs",
			},
		},
		["SARTURA"] = {
			["startMethod"] = "COMBAT",
			["name"] = LVBM_SARTURA_NAME,
			["delay"] = 5,
			["BossMods"] = {
				"Sartura",
			},
		},
		["FANKRISS"] = {
			["startMethod"] = "COMBAT",
			["name"] = LVBM_FANKRISS_NAME,
			["delay"] = 5,
			["BossMods"] = {
				"Fankriss",
			},
		},
		["HUHURAN"] = {
			["startMethod"] = "COMBAT",
			["name"] = LVBM_HUHURAN_NAME,
			["delay"] = 15,
			["BossMods"] = {
				"Huhuran",
			},
		},
		["TWINS"] = {
			["startMethod"] = "COMBAT",
			["name"] = LVBM_TWINEMPS_VEKNILASH,
			["realName"] = LVBM_TWINEMPS_REAL_NAME,
			["delay"] = 10,
			["BossMods"] = {
				"TwinEmps",
			},
		},
		["OURO"] = {
			["startMethod"] = "COMBAT",
			["name"] = LVBM_OURO_NAME,
			["delay"] = 25,
			["BossMods"] = {
				"Ouro",
			},
		},
		["CTHUN"] = {
			["startMethod"] = "COMBAT",
			["name"] = LVBM_CTHUN_EYE_OF_CTHUN,
			["killName"] = LVBM_CTHUN_NAME,
			["delay"] = 7.5,
			["BossMods"] = {
				"CThun",
			},
		},
		["VISCIDUS"] = {
			["startMethod"] = "COMBAT",
			["name"] = LVBM_VISCIDUS_NAME,
			["delay"] = 1.5,
			["BossMods"] = {
				"Viscidus",
			},
		},
	};
end

function LVBosses_Load_BWL()
LVBM.Bosses[LVBM_BWL] = {
		["RAZORGORE"] = {
			["startMethod"] = "YELL",
			["name"] = LVBM_RG_NAME,
			["startTrigger"] = {
				LVBM_RG_YELL,
			},
			["combatEndDelay"] = 25,
			["minCombatTime"] = 120,
			["BossMods"] = {
				"Razorgore",
			},
		},
		["VAELASTRASZ"] = {
			["startMethod"] = "COMBAT",
			["name"] = LVBM_VAEL_NAME,
			["delay"] = 5,
			["BossMods"] = {
				"Vaelastrasz",
			},
		},
		["LASHLAYER"] = {
			["startMethod"] = "YELL",
			["name"] = LVBM_LASHLAYER_NAME,
			["startTrigger"] = {
				[LVBM_LASHLAYER_YELL] = true,
			},
			["BossMods"] = {
			},
		},
		["FIREMAW"] = {
			["startMethod"] = "COMBAT",
			["name"] = LVBM_FIREMAW_NAME,
			["delay"] = 10,
			["BossMods"] = {
				"Firemaw",
			},
		},
		["EBONROC"] = {
			["startMethod"] = "COMBAT",
			["name"] = LVBM_EBONROC_NAME,
			["delay"] = 15,
			["BossMods"] = {
				"Ebonroc",
			},
		},
		["FLAMEGOR"] = {
			["startMethod"] = "COMBAT",
			["name"] = LVBM_FLAMEGOR_NAME,
			["delay"] = 15,
			["BossMods"] = {
				"Flamegor",
			},
		},
		["CHROMAGGUS"] = {
			["startMethod"] = "COMBAT",
			["name"] = LVBM_CHROMAGGUS_NAME,
			["delay"] = 6,
			["BossMods"] = {
				"Chromaggus",
			},
		},
		["NEFARIAN"] = {
			["startMethod"] = "YELL",
			["name"] = LVBM_NEFARIAN_NAME,
			["startTrigger"] = {
				[LVBM_NEFARIAN_YELL_PHASE1] = true,
			},
			["BossMods"] = {
				"Nefarian",
			},
		},
	};
end

function LVBosses_Load_MC()
LVBM.Bosses[LVBM_MC] = {
		["LUCIFRON"] = {
			["startMethod"] = "COMBAT",
			["name"] = LVBM_LUCIFRON_NAME,
			["delay"] = 5,
			["BossMods"] = {
				"Lucifron",
			},
		},
		["MAGMADAR"] = {
			["startMethod"] = "COMBAT",
			["name"] = LVBM_MAGMADAR_NAME,
			["delay"] = 5,
			["BossMods"] = {
				"Magmadar",
			},
		},
		["GEHENNAS"] = {
			["startMethod"] = "COMBAT",
			["name"] = LVBM_GEHENNAS_NAME,
			["delay"] = 5,
			["BossMods"] = {
				"Gehennas",
			},
		},
		["GARR"] = {
			["startMethod"] = "COMBAT",
			["name"] = LVBM_GARR_NAME,
			["delay"] = 5,
			["BossMods"] = {
			},
		},
		["GEDDON"] = {
			["startMethod"] = "COMBAT",
			["name"] = LVBM_BARON_NAME,
			["delay"] = 5,
			["BossMods"] = {
				"Geddon",
			},
		},
		["SHAZZRAH"] = {
			["startMethod"] = "COMBAT",
			["name"] = LVBM_SHAZZRAH_NAME,
			["delay"] = 5,
			["BossMods"] = {
				"Shazzrah",
			},
		},
		["SULFURON"] = {
			["startMethod"] = "COMBAT",
			["name"] = LVBM_SULFURON_NAME,
			["delay"] = 5,
			["BossMods"] = {
			},
		},
		["GOLEMAGG"] = {
			["startMethod"] = "COMBAT",
			["name"] = LVBM_GOLEMAGG_NAME,
			["delay"] = 5,
			["BossMods"] = {
			},
		},
		["MAJORDOMO"] = {
			["startMethod"] = "COMBAT",
			["name"] = LVBM_DOMO_NAME,
			["delay"] = 5,
			["BossMods"] = {
				"Majordomo",
			},
		},
		["RAGNAROS"] = {
			["startMethod"] = "COMBAT",
			["name"] = LVBM_RAGNAROS_NAME,
			["delay"] = 5,
			["BossMods"] = {
				"Ragnaros",
			},
		},
	};
end


function LVBosses_Load_AQ20()
LVBM.Bosses[LVBM_AQ20] = {
		["KURINAXX"] = {
			["startMethod"] = "COMBAT",
			["name"] = LVBM_KURINAXX_NAME,
			["delay"] = 5,
			["BossMods"] = {
			},
		},
		["RAJAXX"] = {
			["startMethod"] = "YELL",
			["name"] = LVBM_RAJAXX_NAME,
			["startTrigger"] = {
				[LVBM_RAJAXX_WAVE1_EXPR] = true,
			},
			["BossMods"] = {
				"Rajaxx",
			},
		},
		["MOAM"] = {
			["startMethod"] = "EMOTE",
			["name"] = LVBM_MOAM_NAME,
			["startTrigger"] = {
				[LVBM_MOAM_COMBAT_START] = true,
			},
			["BossMods"] = {
				"Moam",
			},
		},
		["BURU"] = {
			["startMethod"] = "COMBAT",
			["name"] = LVBM_BURU_NAME,
			["delay"] = 5,
			["BossMods"] = {
				"Buru",
			},
		},
		["AYAMISS"] = {
			["startMethod"] = "COMBAT",
			["name"] = LVBM_AYAMISS_NAME,
			["delay"] = 5,
			["BossMods"] = {
				"Ayamiss",
			},
		},
		["OSSIRIAN"] = {
			["startMethod"] = "COMBAT",
			["name"] = LVBM_OSSIRIAN_NAME,
			["delay"] = 15,
			["BossMods"] = {
				"Ossirian",
			},
		},
	};
end

function LVBosses_Load_ZG()
LVBM.Bosses[LVBM_ZG] = {
		["JEKLIK"] = {
			["startMethod"] = "COMBAT",
			["name"] = LVBM_JEKLIK_NAME,
			["delay"] = 5,
			["BossMods"] = {
				"Jeklik",
			},
		},
		["VENOXIS"] = {
			["startMethod"] = "COMBAT",
			["name"] = LVBM_VENOXIS_NAME,
			["delay"] = 5,
			["BossMods"] = {
				"Venoxis",
			},
		},
		["MARLI"] = {
			["startMethod"] = "COMBAT",
			["name"] = LVBM_MARLI_NAME,
			["delay"] = 5,
			["BossMods"] = {
				"Marli",
			},
		},
		["THEKAL"] = {
			["startMethod"] = "COMBAT",
			["name"] = LVBM_THEKAL_NAME,
			["delay"] = 5,
			["BossMods"] = {
			},
		},
		["ARLOKK"] = {
			["startMethod"] = "COMBAT",
			["name"] = LVBM_ARLOKK_NAME,
			["delay"] = 5,
			["BossMods"] = {
				"Arlokk",
			},
		},
		["JINDO"] = {
			["startMethod"] = "COMBAT",
			["name"] = LVBM_JINDO_NAME,
			["delay"] = 5,
			["BossMods"] = {
				"Jindo",
			},
		},
		["HAKKAR"] = {
			["startMethod"] = "COMBAT",
			["name"] = LVBM_HAKKAR_NAME,
			["delay"] = 5,
			["BossMods"] = {
				"Hakkar",
			},
		},
	};
end

function LVBosses_Load_Onyxia()
LVBM.Bosses[LVBM_ONYXIAS_LAIR] = {
		["ONYXIA"] = {
			["startMethod"] = "COMBAT",
			["name"] = LVBM_ONYXIA_NAME,
			["delay"] = 5,
			["BossMods"] = {
				"Onyxia",
			},
		},
	};
end

function LVBosses_Load_BlastedLands()
LVBM.Bosses[LVBM_BLASTED_LANDS] = {
		["KAZZAK"] = {
			["startMethod"] = "YELL",
			["name"] = LVBM_KAZZAK_NAME,
			["startTrigger"] = {
				[LVBM_KAZZAK_START_YELL] = true,
			},
			["BossMods"] = {
				"Kazzak",
			},
		},
	};
end

function LVBosses_Load_Azshara()
LVBM.Bosses[LVBM_AZSHARA] = {
		["AZUREGOS"] = {
			["startMethod"] = "COMBAT",
			["name"] = LVBM_AZUREGOS_NAME,
			["delay"] = 5,
			["BossMods"] = {
				"Azuregos",
			},
		},
	};
end

function LVBosses_Load_4Dragons()
LVBM.Dragons = {
	["YSONDRE"] = {
		["startMethod"] = "COMBAT",
		["name"] = LVBM_OUTDOOR_YSONDRE,
		["delay"] = 5,
		["BossMods"] = {
			"OutdoorDragons",
		},
	},
	["EMERISS"] = {
		["startMethod"] = "COMBAT",
		["name"] = LVBM_OUTDOOR_EMERISS,
		["delay"] = 5,
		["BossMods"] = {
			"OutdoorDragons",
		},
	},
	["TAERAR"] = {
		["startMethod"] = "COMBAT",
		["name"] = LVBM_OUTDOOR_TAERAR,
		["delay"] = 5,
		["BossMods"] = {
			"OutdoorDragons",
		},
	},
	["LETHON"] = {
		["startMethod"] = "COMBAT",
		["name"] = LVBM_OUTDOOR_LETHON,
		["delay"] = 5,
		["BossMods"] = {
			"OutdoorDragons",
		},
	},
}

LVBM.Bosses[LVBM_DUSKWOOD] = LVBM.Dragons;
LVBM.Bosses[LVBM_ASHENVALE] = LVBM.Dragons;
LVBM.Bosses[LVBM_FERALAS] = LVBM.Dragons;
LVBM.Bosses[LVBM_HINTERLANDS] = LVBM.Dragons;

end


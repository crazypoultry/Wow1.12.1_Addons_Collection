--{{{ Libraries

local L = AceLibrary("AceLocale-2.2"):new("Grid")

--}}}

GridLayout:AddLayout(L["None"], {})

GridLayout:AddLayout(L["By Group 40"], {
		defaults = {
			-- nameList = "",
			-- groupFilter = "",
			-- sortMethod = "INDEX", -- or "NAME"
			-- sortDir = "ASC", -- or "DESC"
			-- strictFiltering = false
		},
		[1] = {
			groupFilter = "1",
		},
		[2] = {
			groupFilter = "2",
		},
		[3] = {
			groupFilter = "3",
		},
		[4] = {
			groupFilter = "4",
		},
		[5] = {
			groupFilter = "5",
		},
		[6] = {
			groupFilter = "6",
		},
		[7] = {
			groupFilter = "7",
		},
		[8] = {
			groupFilter = "8",
		},
	})

GridLayout:AddLayout(L["By Group 25"], {
		[1] = {
			groupFilter = "1",
		},
		[2] = {
			groupFilter = "2",
		},
		[3] = {
			groupFilter = "3",
		},
		[4] = {
			groupFilter = "4",
		},
		[5] = {
			groupFilter = "5",
		},
	})

GridLayout:AddLayout(L["By Group 20"], {
		[1] = {
			groupFilter = "1",
		},
		[2] = {
			groupFilter = "2",
		},
		[3] = {
			groupFilter = "3",
		},
		[4] = {
			groupFilter = "4",
		},
	})

GridLayout:AddLayout(L["By Group 15"], {
		[1] = {
			groupFilter = "1",
		},
		[2] = {
			groupFilter = "2",
		},
		[3] = {
			groupFilter = "3",
		},
	})

GridLayout:AddLayout(L["By Group 10"], {
		[1] = {
			groupFilter = "1",
		},
		[2] = {
			groupFilter = "2",
		},
	})

GridLayout:AddLayout(L["By Class"], {
		[1] = {
			groupFilter = "WARRIOR",
		},
		[2] = {
			groupFilter = "PRIEST",
		},
		[3] = {
			groupFilter = "DRUID",
		},
		[4] = {
			groupFilter = "PALADIN",
		},
		[5] = {
			groupFilter = "SHAMAN",
		},
		[6] = {
			groupFilter = "MAGE",
		},
		[7] = {
			groupFilter = "WARLOCK",
		},
		[8] = {
			groupFilter = "HUNTER",
		},
		[9] = {
			groupFilter = "ROGUE",
		},
	})

GridLayout:AddLayout(L["Onyxia"], {
		[1] = {
			groupFilter = "1",
		},
		[2] = {
			groupFilter = "3",
		},
		[3] = {
			groupFilter = "5",
		},
		[4] = {
			groupFilter = "7",
		},
		[5] = {
			groupFilter = "",
		},
		[6] = {
			groupFilter = "2",
		},
		[7] = {
			groupFilter = "4",
		},
		[8] = {
			groupFilter = "6",
		},
		[9] = {
			groupFilter = "8",
		},
	})

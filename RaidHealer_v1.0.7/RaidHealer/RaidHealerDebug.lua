RAIDHEALER_DEBUG = false;

RaidHealer_DebugRaidMember = {
	[RAIDHEALER_CLASS_WARRIOR] = {
		{ ["NAME"] = "TankName1", ["CLASS"] = "Warrior", ["GROUP"] = 1, ["CTRA_MT"] = 1 },
		{ ["NAME"] = "TankName2", ["CLASS"] = "Warrior", ["GROUP"] = 2, ["CTRA_MT"] = 3 },
		{ ["NAME"] = "TankName3", ["CLASS"] = "Warrior", ["GROUP"] = 3, ["CTRA_MT"] = 0 },
		{ ["NAME"] = "TankName4", ["CLASS"] = "Warrior", ["GROUP"] = 1, ["CTRA_MT"] = 4 } 
	},
	[RAIDHEALER_CLASS_PRIEST] = {
		{ ["NAME"] = "PriestName1", ["CLASS"] = "Priest", ["GROUP"] = 1, ["CTRA_MT"] = 0 },
		{ ["NAME"] = "PriestName2", ["CLASS"] = "Priest", ["GROUP"] = 2, ["CTRA_MT"] = 0 },
		{ ["NAME"] = "PriestName3", ["CLASS"] = "Priest", ["GROUP"] = 4, ["CTRA_MT"] = 0 }
	},
	[RAIDHEALER_CLASS_DRUID] = {
		{ ["NAME"] = "DruidName1", ["CLASS"] = "Druid", ["GROUP"] = 1, ["CTRA_MT"] = 0 }
	},
	[RAIDHEALER_CLASS_PALADIN] = {
		{ ["NAME"] = "PaladinName1", ["CLASS"] = "Paladin", ["GROUP"] = 1, ["CTRA_MT"] = 0 }
	},
	[RAIDHEALER_CLASS_SHAMAN] = { 
		{ ["NAME"] = "ShamanName1", ["CLASS"] = "Shaman", ["GROUP"] = 1, ["CTRA_MT"] = 0 }
	},
	[RAIDHEALER_CLASS_WARLOCK] = { },
	[RAIDHEALER_CLASS_MAGE] = { 
		{ ["NAME"] = "MageName1", ["CLASS"] = "Mage", ["GROUP"] = 1, ["CTRA_MT"] = 0 }
	},
	[RAIDHEALER_CLASS_ROGUE] = { },
	[RAIDHEALER_CLASS_HUNTER] = { }
};

function RH_Debug(...)
	local i=1;
	while arg[i] do
		DEFAULT_CHAT_FRAME:AddMessage(arg[i], 1.0, 0.25, 0.25); -- Default green
		i=i+1;
	end
end
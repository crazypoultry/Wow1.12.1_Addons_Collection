BINDING_HEADER_SHARDACE = "ShardAce"
BINDING_NAME_SORT = "ShardAce Sort"
BINDING_NAME_HEALTH = "ShardAce Health"
BINDING_NAME_SOULSTONE = "ShardAce Soulstone"
BINDING_NAME_MOUNT = "ShardAce Mount"
BINDING_NAME_SPELLSTONE = "ShardAce Spellstone"
BINDING_NAME_FIRESTONE = "ShardAce Firestone"
BINDING_NAME_BUFF = "ShardAce Buff"
BINDING_NAME_SUMMONER = "ShardAce Summoner"

ShardAceLocals ={}

ShardAceLocals.Commands = {"/shardace","/sa"}
ShardAceLocals.Options = {
	type = 'group',
	args = {
		threshold = { 
			type = 'range', name = "Threshold",
			desc = "Controls when the shard counter will change colour",
			min = 0, max = 20,
			step = 1,
			get = "getThreshold",
			set = "setThreshold",
			},
		hstrade = {
				type = 'toggle', name = "HSTrade",
				desc = "Toggles healthstone trading",
				get = "getHSTradeState",
				set = "setHSTradeState",
			},
		sound = {
				type = 'toggle', name = "Sound",
				desc = "Toggles playing sound",
				get = "getSoundState",
				set = "setSoundState",
			},
		setmessage = {
			type = "group", desc = "Options for setting various messages", name="SetMessage",
			args = {
				soulstone = {
					type = 'text', desc = "Set the Soulstone message",
					name = "Soulstone",
					usage = "<message>",
					get = "getSoulstoneMessage",
					set = "setSoulstoneMessage",
				},
				summon = {
					type = 'text', desc = "Set the Summon message",
					name = "Summon",
					usage = "<message>",
					get = "getSummonMessage",
					set = "setSummonMessage",
				},
				presummon = {
					type = 'text', desc = "Set the Pre-Summon message",
					name = "Presummon",
					usage = "<message>",
					get = "getPreSummonMessage",
					set = "setPreSummonMessage",
				},
			},
		},
		shardsort = {
			type = "group", desc = "Options for shard sorting", name="ShardSort",
			args = {
				bag = { 
					type = 'range', name = "Bag",
					desc = "Sets which bag to sort shards into",
					min = 0, max = 4,
					step = 1,
					get = "getShardBag",
					set = "setShardBag",
				},
				auto = {
					type = 'toggle', name = "Auto",
					desc = "Toggles auto sorting",
					get = "getAutoSortState",
					set = "setAutoSortState",
				},
				reverse = {
					type = 'toggle', name = "HSTrade",
					desc = "Toggles sorting direction",
					get = "getReverseSortState",
					set = "setReverseSortState",
				},
			},
		},
		position = {
			type = "group", desc = "Options for button placement", name="Position",
			args = {
				buttons = {
					type = 'text', desc = "Sets position of minimap buttons",
					name = "Buttons",
				    get = "getMinimapButtonPosition",
				    set = "setMinimapButtonPosition",
				    validate = {"wayoutleft", "farleft", "closeleft", "wayoutright", "farright", "closeright"},
				},
				summon = {
					type = 'text', desc = "Sets position of the summoner menu",
					name = "Summon",
				    get = "getSummonMenuPosition",
				    set = "setSummonMenuPosition",
				    validate = {"left", "right", "top", "bottom"},
				},
				formation = {
					type = 'text', desc = "Sets formation of the minimap buttons",
					name = "Formation",
				    get = "getMinimapButtonFormation",
				    set = "setMinimapButtonFormation",
				    validate = {"leftcurve", "rightcurve", "horizontal", "vertical", "square", "diamond"},
				},
				cursor = {
					type = 'execute', desc = "Moves the minimap buttons to the cursor",
					name = "Cursor",
					func = "setCursorPosition",
				},
			},
		},
		togglemessage = {
			type = "group", desc = "Toggle various messages on and off", name="ToggleMessage",
			args = {
				summon = {
					type = 'toggle', name = "Summon",
					desc = "Toggles summoning messages",
					get = "getSummonMessageState",
					set = "setSummonMessageState",
				},
				presummon = {
					type = 'toggle', name = "Presummon",
					desc = "Toggles pre-summoning messages",
					get = "getPreSummonMessageState",
					set = "setPreSummonMessageState",
				},
				soulstone = {
					type = 'toggle', name = "Soulstone",
					desc = "Toggles soulstone messages",
					get = "getSoulstoneMessageState",
					set = "setSoulstoneMessageState",
				},
			},
		},
		setchannel = {
			type = "group", desc = "Toggle various messages on and off", name="ToggleMessage",
			args = {
				soulstone = {
					type = 'text', desc = "Set the Soulstone message channel",
					name = "Soulstone",
					usage = "<channel name>",
					get = "getSoulstoneMessageChannel",
					set = "setSoulstoneMessageChannel",
				},
				summon = {
					type = 'text', desc = "Set the Summon message channel",
					name = "Summon",
					usage = "<channel name>",
					get = "getSummonMessageChannel",
					set = "setSummonMessageChannel",
				},
				presummon = {
					type = 'text', desc = "Set the Pre-Summon message channel",
					name = "Presummon",
					usage = "<channel name>",
					get = "getPreSummonMessageChannel",
					set = "setPreSummonMessageChannel",
				},
				all = {
					type = 'text', desc = "Set the channel for all messages",
					name = "All",
					usage = "<channel name>",
					get = false,
					set = "setGlobalMessageChannel",
				},
			},
		},
	},
}

ShardAceLocals.SummonMsg1 = "Summoning >>%s<< Please Assist"
ShardAceLocals.SummonMsg2 = "Preparing to summon %s"
ShardAceLocals.SoulMsg = "%s has been soulstoned"

ShardAceLocals.CountTip = "Sort Shards/Cast Buff"
ShardAceLocals.SoulTip = "Soulstone/Mount"
ShardAceLocals.StoneTip = "Spell Stone/Fire Stone"
ShardAceLocals.HealthTip = "Health Stone/Summon Menu"
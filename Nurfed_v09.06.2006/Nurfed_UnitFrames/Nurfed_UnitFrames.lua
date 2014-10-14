
NURFED_UNITFRAMES_DEFAULT = {
	uselayout = 0,
	hideparty = 0,
	castable = 0,
	dispellable = 0,
	cancelbuffs = 0,
	targetbuffs = 0,
	targetdebuffs = 0,
	playerscale = 1,
	targetscale = 1,
	petscale = 1,
	partyscale = 1,
	bufflist = {},
};

local utility = Nurfed_Utility:New();
local framelib = Nurfed_Frames:New();
local units = Nurfed_Units:New();

local default = {
	templates = {
		Nurfed_UnitFont = {
			type = "Font",
			Font = { NRF_FONT.."framd.ttf", 10, "NONE" },
			TextColor = { 1, 1, 1 },
		},
		Nurfed_UnitFontOutline = {
			type = "Font",
			Font = { NRF_FONT.."framd.ttf", 10, "OUTLINE" },
			TextColor = { 1, 1, 1 },
		},
		Nurfed_UnitFontSmall = {
			type = "Font",
			Font = { NRF_FONT.."framd.ttf", 8, "NONE" },
			TextColor = { 1, 1, 1 },
		},
		Nurfed_UnitFontSmallOutline = {
			type = "Font",
			Font = { NRF_FONT.."framd.ttf", 8, "OUTLINE" },
			TextColor = { 1, 1, 1 },
		},
		Nurfed_CountFontOutline = {
			type = "Font",
			Font = { "Fonts\\ARIALN.TTF", 12, "OUTLINE" },
			TextColor = { 1, 1, 1 },
		},
		Nurfed_Unit_hp = {
			type = "StatusBar",
			FrameStrata = "LOW",
			Orientation = "HORIZONTAL",
			StatusBarTexture = NRF_IMG.."statusbar5",
			children = {
				bg = {
					type = "Texture",
					layer = "BACKGROUND",
					Texture = NRF_IMG.."statusbar5",
					VertexColor = { 1, 0, 0, 0.25 },
					Anchor = "all",
				},
				text = {
					type = "FontString",
					layer = "OVERLAY",
					FontObject = "Nurfed_UnitFont",
					JustifyH = "LEFT",
					ShadowColor = { 0, 0, 0, 0.75},
					ShadowOffset = { -1, -1 },
					Anchor = "all",
					vars = { format = "$cur ($max)" },
				},
				text2 = {
					type = "FontString",
					layer = "OVERLAY",
					FontObject = "Nurfed_UnitFontOutline",
					JustifyH = "RIGHT",
					TextColor = { 1, 0.25, 0 },
					Anchor = "all",
					vars = { format = "$miss" },
				},
			},
			vars = { ani = "glide" },
		},

		Nurfed_Unit_mp = {
			type = "StatusBar",
			FrameStrata = "LOW",
			Orientation = "HORIZONTAL",
			StatusBarTexture = NRF_IMG.."statusbar5",
			children = {
				bg = {
					type = "Texture",
					layer = "BACKGROUND",
					Texture = NRF_IMG.."statusbar5",
					VertexColor = { 0, 1, 1, 0.25 },
					Anchor = "all"
				},
				text = {
					type = "FontString",
					layer = "OVERLAY",
					FontObject = "Nurfed_UnitFont",
					JustifyH = "LEFT",
					ShadowColor = { 0, 0, 0, 0.75 },
					ShadowOffset = { -1, -1 },
					Anchor = "all",
					vars = { format = "$cur ($max)" },
				},
			},
			vars = { ani = "glide" },
		},

		Nurfed_Unit_xp = {
			type = "StatusBar",
			strata = "LOW",
			Orientation = "HORIZONTAL",
			StatusBarTexture = NRF_IMG.."statusbar5",
			children = {
				bg = {
					type = "Texture",
					layer = "BACKGROUND",
					Texture = NRF_IMG.."statusbar5",
					VertexColor = { 0, 0, 1, 0.25 },
					Anchor = "all"
				},
				text = {
					type = "FontString",
					layer = "OVERLAY",
					FontObject = "Nurfed_UnitFontSmall",
					JustifyH = "CENTER",
					ShadowColor = { 0, 0, 0, 0.75 },
					ShadowOffset = { -1, -1 },
					Anchor = "all",
					vars = { format = "$cur/$max$rest" },
				},
				text2 = {
					type = "FontString",
					layer = "OVERLAY",
					FontObject = "Nurfed_UnitFontSmall",
					JustifyH = "RIGHT",
					ShadowColor = { 0, 0, 0, 0.75 },
					ShadowOffset = { -1, -1 },
					Anchor = "all",
					vars = { format = "$perc" },
				}
			},
		},

		Nurfed_Unit_model = {
			type = "PlayerModel",
			size = { 40, 40 },
			FrameStrata = "LOW",
			ModelScale = 1.9,
			Camera = 0,
			FrameLevel = 1,
		},

		Nurfed_Unit_mini = {
			type = "Button",
			size = { 80, 22 },
			FrameStrata = "LOW",
			Backdrop = {
				bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
				edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
				tile = true,
				tileSize = 16,
				edgeSize = 8,
				insets = { left = 2, right = 2, top = 2, bottom = 2 }
			},
			BackdropColor = { 0, 0, 0, 0.75 },
			children = {
				hp = {
					type = "StatusBar",
					size = { 74, 9 },
					FrameStrata = "LOW",
					Orientation = "HORIZONTAL",
					StatusBarTexture = NRF_IMG.."statusbar5",
					Anchor = { "BOTTOMLEFT", "$parent", "BOTTOMLEFT", 3, 3 },
					children = {
						bg = {
							type = "Texture",
							layer = "BACKGROUND",
							Texture = NRF_IMG.."statusbar5",
							VertexColor = { 1, 0, 0, 0.25 },
							Anchor = "all",
						},
						text = {
							type = "FontString",
							layer = "OVERLAY",
							FontObject = "Nurfed_UnitFontSmallOutline",
							JustifyH = "RIGHT",
							TextColor = { 1, 0.25, 0 },
							Anchor = "all",
							vars = { format = "$perc" },
						},
					},
				},
				name = {
					type = "FontString",
					size = { 75, 8 },
					layer = "OVERLAY",
					FontObject = "Nurfed_UnitFontSmall",
					JustifyH = "LEFT",
					ShadowColor = { 0, 0, 0, 0.75 },
					ShadowOffset = { -1, -1 },
					Anchor = { "TOPLEFT", "$parent", "TOPLEFT", 3, -2 },
					vars = { format = "$name" },
				},
			},
			Hide = true,
		},

		Nurfed_Party = {
			type = "Button",
			size = { 180, 41 },
			FrameStrata = "LOW",
			ClampedToScreen = true,
			Backdrop = { bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, insets = { left = 5, right = 5, top = 5, bottom = 5 }, },
			BackdropColor = { 0, 0, 0, 0.75 },
			Movable = true,
			Mouse = true,
			children = {
				hp = {
					template = "Nurfed_Unit_hp",
					size = { 147, 12 },
					Anchor = { "BOTTOMRIGHT", "$parent", "BOTTOMRIGHT", -5, 14 },
				},
				mp = {
					template = "Nurfed_Unit_mp",
					size = { 147, 8 },
					Anchor = { "BOTTOMRIGHT", "$parent", "BOTTOMRIGHT", -5, 5 },
				},
				buff1 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "TOPLEFT", "$parent", "BOTTOMLEFT", 4, 2 } },
				buff2 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "LEFT", "$parentbuff1", "RIGHT", 0, 0 } },
				buff3 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "LEFT", "$parentbuff2", "RIGHT", 0, 0 } },
				buff4 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "LEFT", "$parentbuff3", "RIGHT", 0, 0 } },
				buff5 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "LEFT", "$parentbuff4", "RIGHT", 0, 0 } },
				buff6 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "LEFT", "$parentbuff5", "RIGHT", 0, 0 } },
				buff7 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "LEFT", "$parentbuff6", "RIGHT", 0, 0 } },
				buff8 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "LEFT", "$parentbuff7", "RIGHT", 0, 0 } },
				buff9 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "LEFT", "$parentbuff8", "RIGHT", 0, 0 } },
				buff10 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "LEFT", "$parentbuff9", "RIGHT", 0, 0 } },
				buff11 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "LEFT", "$parentbuff10", "RIGHT", 0, 0 } },
				buff12 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "LEFT", "$parentbuff11", "RIGHT", 0, 0 } },
				buff13 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "LEFT", "$parentbuff12", "RIGHT", 0, 0 } },
				buff14 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "LEFT", "$parentbuff13", "RIGHT", 0, 0 } },
				buff15 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "LEFT", "$parentbuff14", "RIGHT", 0, 0 } },
				buff16 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "LEFT", "$parentbuff15", "RIGHT", 0, 0 } },
				debuff1 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "TOPLEFT", "$parent", "TOPRIGHT", -3, -2 } },
				debuff2 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "LEFT", "$parentdebuff1", "RIGHT", 1, 0 } },
				debuff3 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "LEFT", "$parentdebuff2", "RIGHT", 1, 0 } },
				debuff4 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "LEFT", "$parentdebuff3", "RIGHT", 1, 0 } },
				classicon = {
					type = "Texture",
					size = { 23, 23 },
					layer = "OVERLAY",
					Texture = "Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes",
					Anchor = { "TOPLEFT", "$parent", "TOPLEFT", 5, -4 },
				},
				highlight = {
					type = "Texture",
					size = { 130, 12 },
					layer = "ARTWORK",
					Texture = "Interface\\QuestFrame\\UI-QuestTitleHighlight",
					BlendMode = "ADD",
					Anchor = { "TOPRIGHT", "$parent", "TOPRIGHT", -5, -4 },
					Hide = true,
				},
				leader = {
					type = "Texture",
					size = { 12, 13 },
					layer = "OVERLAY",
					Texture = "Interface\\GroupFrame\\UI-Group-LeaderIcon",
					Anchor = { "TOPLEFT", "$parent", "TOPLEFT", 5, -25 },
				},
				master = {
					type = "Texture",
					size = { 11, 11 },
					layer = "OVERLAY",
					Texture = "Interface\\GroupFrame\\UI-Group-MasterLooter",
					Anchor = { "TOPLEFT", "$parent", "TOPLEFT", 16, -26 },
				},
				pvp = {
					type = "Texture",
					size = { 20, 20 },
					layer = "OVERLAY",
					Anchor = { "TOPRIGHT", "$parent", "TOPRIGHT", 4, -4 },
				},
				name = {
					type = "FontString",
					size = { 140, 10 },
					layer = "OVERLAY",
					FontObject = "Nurfed_UnitFont",
					JustifyH = "LEFT",
					Anchor = { "TOPLEFT", "$parent", "TOPLEFT", 28, -4 },
					vars = { format = "[$key] $name" },
				},
				hpperc = {
					type = "FontString",
					layer = "OVERLAY",
					FontObject = "Nurfed_UnitFontOutline",
					JustifyH = "RIGHT",
					Anchor = { "TOPRIGHT", "$parent", "TOPRIGHT", -15, -5 },
					vars = { format = "$perc" },
				},
				pet = {
					template = "Nurfed_Unit_mini",
					Anchor = { "BOTTOMLEFT", "$parent", "BOTTOMRIGHT", -4, 2 },
				},
			},
			vars = { aurawidth = 176, aurasize = 16 },
		},
	},
	frames = {
		player = {
			type = "Button",
			size = { 180, 59 },
			FrameStrata = "LOW",
			ClampedToScreen = true,
			Backdrop = { bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, insets = { left = 5, right = 5, top = 5, bottom = 5 }, },
			BackdropColor = { 0, 0, 0, 0.75 },
			Movable = true,
			Mouse = true,
			children = {
				hp = {
					template = "Nurfed_Unit_hp",
					size = { 130, 13 },
					Anchor = { "BOTTOMRIGHT", "$parent", "BOTTOMRIGHT", -5, 25 },
				},
				mp = {
					template = "Nurfed_Unit_mp",
					size = { 130, 10 },
					Anchor = { "BOTTOMRIGHT", "$parent", "BOTTOMRIGHT", -5, 14 },
				},
				xp = {
					template = "Nurfed_Unit_xp",
					size = { 170, 8 },
					Anchor = { "BOTTOMRIGHT", "$parent", "BOTTOMRIGHT", -5, 5 },
				},
				model = {
					template = "Nurfed_Unit_model",
					Anchor = { "BOTTOMLEFT", "$parent", "BOTTOMLEFT", 5, 13 },
				},
				rank = {
					type = "Texture",
					size = { 17, 17 },
					layer = "OVERLAY",
					Anchor = { "TOPRIGHT", "$parent", "TOPRIGHT", -23, -4 },
					Hide = true,
				},
				status = {
					type = "Texture",
					size = { 20, 20 },
					layer = "OVERLAY",
					Texture = "Interface\\CharacterFrame\\UI-StateIcon",
					Anchor = { "TOPRIGHT", "$parent", "TOPRIGHT", -39, -3 },
					Hide = true,
				},
				pvp = {
					type = "Texture",
					size = { 28, 28 },
					layer = "OVERLAY",
					Anchor = { "TOPRIGHT", "$parent", "TOPRIGHT", 5, -4 },
					Hide = true,
				},
				leader = {
					type = "Texture",
					size = { 10, 10 },
					layer = "OVERLAY",
					Texture = "Interface\\GroupFrame\\UI-Group-LeaderIcon",
					Anchor = { "TOP", "$parent", "TOP", 28, -4 },
					Hide = true,
				},
				master = {
					type = "Texture",
					size = { 9, 9 },
					layer = "OVERLAY",
					Texture = "Interface\\GroupFrame\\UI-Group-MasterLooter",
					Anchor = { "TOP", "$parent", "TOP", 28, -12 },
					Hide = true,
				},
				name = {
					type = "FontString",
					size = { 65, 9 },
					layer = "OVERLAY",
					FontObject = "Nurfed_UnitFont",
					JustifyH = "LEFT",
					Anchor = { "TOPLEFT", "$parent", "TOPLEFT", 45, -4 },
					vars = { format = "$name" },
				},
				level = {
					type = "FontString",
					size = { 20, 10 },
					layer = "OVERLAY",
					FontObject = "Nurfed_UnitFont",
					JustifyH = "RIGHT",
					Anchor = { "TOP", "$parent", "TOP", 10, -5 },
					vars = { format = "$level" },
				},
				group = {
					type = "FontString",
					size = { 50, 8 },
					layer = "OVERLAY",
					FontObject = "Nurfed_UnitFontSmall",
					JustifyH = "LEFT",
					Anchor = { "TOPLEFT", "$parent", "TOPLEFT", 45, -13 },
				},
				feedbackheal = {
					type = "MessageFrame",
					layer = "OVERLAY",
					size = { 110, 11 },
					FontObject = "Nurfed_UnitFontOutline",
					JustifyH = "LEFT",
					InsertMode = "BOTTOM",
					Anchor = { "BOTTOMLEFT", "$parent", "BOTTOMLEFT", 5, 13 },
					FadeDuration = 0.5,
					TimeVisible = 1,
					vars = { heal = true },
				},
				feedbackdamage = {
					type = "MessageFrame",
					layer = "OVERLAY",
					size = { 110, 11 },
					FontObject = "Nurfed_UnitFontOutline",
					JustifyH = "LEFT",
					InsertMode = "TOP",
					Anchor = { "TOPLEFT", "$parent", "TOPLEFT", 5, -5 },
					FadeDuration = 0.5,
					TimeVisible = 1,
					vars = { damage = true },
				},
			},
		},

		target = {
			type = "Button",
			size = { 180, 50 },
			FrameStrata = "LOW",
			ClampedToScreen = true,
			Backdrop = { bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, insets = { left = 5, right = 5, top = 5, bottom = 5 }, },
			BackdropColor = { 0, 0, 0, 0.75 },
			Movable = true,
			Mouse = true,
			children = {
				hp = {
					template = "Nurfed_Unit_hp",
					size = { 130, 13 },
					Anchor = { "BOTTOMLEFT", "$parent", "BOTTOMLEFT", 5, 15 },
				},
				mp = {
					template = "Nurfed_Unit_mp",
					size = { 130, 10 },
					Anchor = { "BOTTOMLEFT", "$parent", "BOTTOMLEFT", 5, 5 },
				},
				model = {
					template = "Nurfed_Unit_model",
					size = { 40, 40 },
					Anchor = { "BOTTOMRIGHT", "$parent", "BOTTOMRIGHT", -4, 5 },
				},
				target = { template = "Nurfed_Unit_mini", Anchor = { "TOPLEFT", "$parent", "TOPRIGHT", -4, -3 } },
				targettarget = { template = "Nurfed_Unit_mini", Anchor = { "BOTTOMLEFT", "$parent", "BOTTOMRIGHT", -4, 3 } },
				buff1 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "TOPLEFT", "$parent", "BOTTOMLEFT", 4, 2 } },
				buff2 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "LEFT", "$parentbuff1", "RIGHT", 0, 0 } },
				buff3 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "LEFT", "$parentbuff2", "RIGHT", 0, 0 } },
				buff4 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "LEFT", "$parentbuff3", "RIGHT", 0, 0 } },
				buff5 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "LEFT", "$parentbuff4", "RIGHT", 0, 0 } },
				buff6 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "LEFT", "$parentbuff5", "RIGHT", 0, 0 } },
				buff7 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "LEFT", "$parentbuff6", "RIGHT", 0, 0 } },
				buff8 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "LEFT", "$parentbuff7", "RIGHT", 0, 0 } },
				buff9 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "LEFT", "$parentbuff8", "RIGHT", 0, 0 } },
				buff10 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "LEFT", "$parentbuff9", "RIGHT", 0, 0 } },
				buff11 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "LEFT", "$parentbuff10", "RIGHT", 0, 0 } },
				buff12 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "LEFT", "$parentbuff11", "RIGHT", 0, 0 } },
				buff13 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "LEFT", "$parentbuff12", "RIGHT", 0, 0 } },
				buff14 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "LEFT", "$parentbuff13", "RIGHT", 0, 0 } },
				buff15 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "LEFT", "$parentbuff14", "RIGHT", 0, 0 } },
				buff16 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "LEFT", "$parentbuff15", "RIGHT", 0, 0 } },
				debuff1 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "TOPLEFT", "$parentbuff1", "BOTTOMLEFT", 0, -1 } },
				debuff2 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "LEFT", "$parentdebuff1", "RIGHT", 0, 0 } },
				debuff3 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "LEFT", "$parentdebuff2", "RIGHT", 0, 0 } },
				debuff4 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "LEFT", "$parentdebuff3", "RIGHT", 0, 0 } },
				debuff5 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "LEFT", "$parentdebuff4", "RIGHT", 0, 0 } },
				debuff6 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "LEFT", "$parentdebuff5", "RIGHT", 0, 0 } },
				debuff7 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "LEFT", "$parentdebuff6", "RIGHT", 0, 0 } },
				debuff8 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "LEFT", "$parentdebuff7", "RIGHT", 0, 0 } },
				debuff9 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "LEFT", "$parentdebuff8", "RIGHT", 0, 0 } },
				debuff10 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "LEFT", "$parentdebuff9", "RIGHT", 0, 0 } },
				debuff11 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "LEFT", "$parentdebuff10", "RIGHT", 0, 0 } },
				debuff12 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "LEFT", "$parentdebuff11", "RIGHT", 0, 0 } },
				debuff13 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "LEFT", "$parentdebuff12", "RIGHT", 0, 0 } },
				debuff14 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "LEFT", "$parentdebuff13", "RIGHT", 0, 0 } },
				debuff15 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "LEFT", "$parentdebuff14", "RIGHT", 0, 0 } },
				debuff16 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "LEFT", "$parentdebuff15", "RIGHT", 0, 0 } },
				rank = {
					type = "Texture",
					size = { 20, 20 },
					layer = "OVERLAY",
					Anchor = { "TOPRIGHT", "$parent", "TOPLEFT", 3, -4 },
				},
				pvp = {
					type = "Texture",
					size = { 29, 29 },
					layer = "OVERLAY",
					Anchor = { "TOPRIGHT", "$parent", "TOPRIGHT", -35, -4 },
				},
				name = {
					type = "FontString",
					size = { 110, 9 },
					layer = "OVERLAY",
					FontObject = "Nurfed_UnitFont",
					JustifyH = "LEFT",
					Anchor = { "TOPLEFT", "$parent", "TOPLEFT", 5, -4 },
					vars = { format = "$name $guild" },
				},
				level = {
					type = "FontString",
					size = { 90, 8 },
					layer = "OVERLAY",
					FontObject = "Nurfed_UnitFontSmall",
					JustifyH = "LEFT",
					Anchor = { "TOPLEFT", "$parent", "TOPLEFT", 5, -13 },
					vars = { format = "$level $class" },
				},
				hpperc = {
					type = "FontString",
					size = { 100, 9 },
					layer = "OVERLAY",
					Font = {NRF_FONT.."framd.ttf", 9, "NONE" },
					JustifyH = "RIGHT",
					Anchor = { "TOPRIGHT", "$parent", "TOPRIGHT", -63, -12 },
					vars = { format = "$perc" },
				},
				combo = {
					type = "FontString",
					layer = "OVERLAY",
					Font = {NRF_FONT.."framd.ttf", 22, "OUTLINE" },
					TextHeight = 22,
					JustifyH = "RIGHT",
					Anchor = { "BOTTOMRIGHT", "$parent", "BOTTOMLEFT", 2, 3 },
				},
				raidtarget = {
					type = "Texture",
					Texture = "Interface\\TargetingFrame\\UI-RaidTargetingIcons",
					size = { 15, 15 },
					layer = "OVERLAY",
					Anchor = { "BOTTOMRIGHT", "$parent", "TOPRIGHT", -5, 0 },
					Hide = true,
				},
			},
			vars = { aurawidth = 176, aurasize = 17 },
		},
		pet = {
			type = "Button",
			size = { 160, 43 },
			FrameStrata = "LOW",
			ClampedToScreen = true,
			Backdrop = { bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, insets = { left = 5, right = 5, top = 5, bottom = 5 }, },
			BackdropColor = { 0, 0, 0, 0.75 },
			Movable = true,
			Mouse = true,
			children = {
				hp = {
					template = "Nurfed_Unit_hp",
					size = { 150, 12 },
					Anchor = { "BOTTOMRIGHT", "$parent", "BOTTOMRIGHT", -5, 14 },
				},
				mp = {
					template = "Nurfed_Unit_mp",
					size = { 150, 8 },
					Anchor = { "BOTTOMRIGHT", "$parent", "BOTTOMRIGHT", -5, 5 },
				},
				name = {
					type = "FontString",
					size = { 123, 10 },
					layer = "ARTWORK",
					FontObject = "Nurfed_UnitFont",
					JustifyH = "LEFT",
					Anchor = { "TOPLEFT", "$parent", "TOPLEFT", 5, -4 },
					vars = { format = "[$level] $name" },
				},
				hpperc = {
					type = "FontString",
					layer = "OVERLAY",
					Font = { NRF_FONT.."framd.ttf", 9, "OUTLINE" },
					JustifyH = "RIGHT",
					Anchor = { "TOPRIGHT", "$parent", "TOPRIGHT", -5, -5 },
					vars = { format = "$perc" },
				},
				happiness = {
					type = "Texture",
					Texture = "Interface\\PetPaperDollFrame\\UI-PetHappiness",
					size = { 14, 14 },
					layer = "OVERLAY",
					Anchor = { "TOPRIGHT", "$parent", "TOPRIGHT", -40, -4 },
					Hide = true,
				},
				buff1 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "TOPLEFT", "$parent", "BOTTOMLEFT", 4, 2 } },
				buff2 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "LEFT", "$parentbuff1", "RIGHT", 0, 0 } },
				buff3 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "LEFT", "$parentbuff2", "RIGHT", 0, 0 } },
				buff4 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "LEFT", "$parentbuff3", "RIGHT", 0, 0 } },
				buff5 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "LEFT", "$parentbuff4", "RIGHT", 0, 0 } },
				buff6 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "LEFT", "$parentbuff5", "RIGHT", 0, 0 } },
				buff7 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "LEFT", "$parentbuff6", "RIGHT", 0, 0 } },
				buff8 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "LEFT", "$parentbuff7", "RIGHT", 0, 0 } },
				buff9 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "LEFT", "$parentbuff8", "RIGHT", 0, 0 } },
				debuff1 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "TOPLEFT", "$parentbuff1", "BOTTOMLEFT", 0, -1 } },
				debuff2 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "LEFT", "$parentdebuff1", "RIGHT", 0, 0 } },
				debuff3 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "LEFT", "$parentdebuff2", "RIGHT", 0, 0 } },
				debuff4 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "LEFT", "$parentdebuff3", "RIGHT", 0, 0 } },
				debuff5 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "LEFT", "$parentdebuff4", "RIGHT", 0, 0 } },
				debuff6 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "LEFT", "$parentdebuff5", "RIGHT", 0, 0 } },
				debuff7 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "LEFT", "$parentdebuff6", "RIGHT", 0, 0 } },
				debuff8 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "LEFT", "$parentdebuff7", "RIGHT", 0, 0 } },
				debuff9 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "LEFT", "$parentdebuff8", "RIGHT", 0, 0 } },
			},
			vars = { aurawidth = 160, aurasize = 16 },
		},
		party1 = "Nurfed_Party",
		party2 = "Nurfed_Party",
		party3 = "Nurfed_Party",
		party4 = "Nurfed_Party",
	},
};

function Nurfed_UnitFrames_Templates()
	local templates;
	local uselayout = utility:GetOption("unitframes", "uselayout");
	if (uselayout == 1) then
		templates = Nurfed_UnitsLayout.templates;
	else
		templates = default.templates;
	end
	for k, v in pairs(templates) do
		framelib:CreateTemplate(k, v);
	end
end

function Nurfed_UnitFrames_Frames()
	local frames;
	local uselayout = utility:GetOption("unitframes", "uselayout");
	if (uselayout == 1) then
		frames = Nurfed_UnitsLayout.Layout;
	else
		frames = default.frames;
	end
	for k, v in pairs(frames) do
		local frame = framelib:ObjectInit("Nurfed_"..k, v);
		local pos = utility:GetOption("utility", frame:GetName());
		if (not pos) then
			frame:SetPoint("CENTER", "UIParent", "CENTER", 0, 0);
		else
			frame:SetPoint("CENTER", "UIParent", "BOTTOMLEFT", pos[1], pos[2]);
		end
		frame.unit = k;
		frame:RegisterForDrag("LeftButton");
		frame:SetScript("OnDragStart", Nurfed_Unit_OnDragStart);
		frame:SetScript("OnDragStop", Nurfed_Unit_OnDragStop);
		units:Imbue(frame);
	end
end

function Nurfed_CancelBuffs()
	local cancel = utility:GetOption("unitframes", "cancelbuffs");
	if (cancel == 1) then
		local bufftex;
		local bufflist = utility:GetOption("unitframes", "bufflist");
		for i = 0 , 20, 1 do
			bufftex = GetPlayerBuffTexture(i);
			if (bufftex) then
				local name = utility:GetAuraName("player", i, "buff");
				if (bufflist[name]) then
					CancelPlayerBuff(i);
				end
			else
				break;
			end
		end
	end
end

function Nurfed_Unit_OnDragStart()
	if (NRF_LOCKED ~= 1) then
		CloseDropDownMenus();
		this:StartMoving();
	end
end

function Nurfed_Unit_OnDragStop()
	this:StopMovingOrSizing();
	utility:SetPos(this);
end

function Nurfed_UnitFrames_ToggleParty()
	local hide = utility:GetOption("unitframes", "hideparty");
	for i = 1, 4 do
		local frame = getglobal("Nurfed_party"..i);
		if (UnitExists("party"..i) and UnitInRaid("player")) then
			if (hide == 1) then
				frame:Hide();
			else
				frame:Show();
			end
		end
	end
end

function Nurfed_UnitFrames_UpdateAuras()
	Nurfed_Units:UpdateAuras(Nurfed_player);
	Nurfed_Units:UpdateAuras(Nurfed_target);
	Nurfed_Units:UpdateAuras(Nurfed_pet);
	Nurfed_Units:UpdateAuras(Nurfed_party1);
	Nurfed_Units:UpdateAuras(Nurfed_party2);
	Nurfed_Units:UpdateAuras(Nurfed_party3);
	Nurfed_Units:UpdateAuras(Nurfed_party4);
	
end

function Nurfed_UnitFrames_UpdateScale(frame)
	local scale;
	if (not frame) then
		if (Nurfed_player) then
			scale = utility:GetOption("unitframes", "playerscale");
			Nurfed_player:SetScale(scale);
		end
		if (Nurfed_target) then
			scale = utility:GetOption("unitframes", "targetscale");
			Nurfed_target:SetScale(scale);
		end
		if (Nurfed_pet) then
			scale = utility:GetOption("unitframes", "petscale");
			Nurfed_pet:SetScale(scale);
		end
		if (Nurfed_party1) then
			scale = utility:GetOption("unitframes", "partyscale");
			Nurfed_party1:SetScale(scale);
			Nurfed_party2:SetScale(scale);
			Nurfed_party3:SetScale(scale);
			Nurfed_party4:SetScale(scale);
		end
	elseif (frame ~= "party") then
		scale = utility:GetOption("unitframes", frame.."scale");
		getglobal("Nurfed_"..frame):SetScale(scale);
	else
		scale = utility:GetOption("unitframes", frame.."scale");
		for i = 1, 4 do
			getglobal("Nurfed_"..frame..i):SetScale(scale);
		end
	end
end

function Nurfed_UnitFrames_Init()
	local blizzframes = { "PlayerFrame", "TargetFrame", "PartyMemberFrame1", "PartyMemberFrame2", "PartyMemberFrame3", "PartyMemberFrame4" };
	for _, v in pairs(blizzframes) do
		local frame = getglobal(v);
		frame:UnregisterAllEvents();
		frame:SetScript("OnEvent", nil);
		frame:SetScript("OnUpdate", nil);
		frame:Hide();
	end
	HIDE_PARTY_INTERFACE = 1;
	ShowPartyFrame = HidePartyFrame;
	ComboFrame:SetScript("OnEvent", nil);

	local tbl = {
		type = "Frame",
		events = { "PLAYER_AURAS_CHANGED" },
		OnEvent = function() Nurfed_CancelBuffs() end,
	};
	framelib:ObjectInit("Nurfed_PlayerBuffs", tbl);
	tbl = nil;

	Nurfed_UnitFrames_Templates();
	Nurfed_UnitFrames_Frames();
	Nurfed_UnitFrames_UpdateScale();
end
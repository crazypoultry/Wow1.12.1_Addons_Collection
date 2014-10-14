--Tknp Skinny 100406 (XP Bar)
----------------------------------------------------------------------------------------
--	Text Format Vars
--		(HP/MP text and status bars)
--		$miss = Missing hp/mp
--		$cur = current hp/mp
--		$max = Max hp/mp
--		$perc = Percent hp/mp
--
--		(Name/Level text)
--		$name = Name
--		$level = Level
--		$class = Class
--		$guild = Guild
--		$race = Race
--		$rname = PvP Rank Name
--		$rnum = PvP Rank Number
--		$key = Key Binding
--
--	Element Names
--		hp, mp, xp, combo, target
--		name, level, class, race
--		pvp, leader, master, feedback
--		group, status, buff, debuff
--		raidtarget, highlight, pet, portrait
--
--	StatusBar Animations
--		glide
----------------------------------------------------------------------------------------

function Nurfed_HealthPercColor(perc, unit)
	local color = {};
	if(perc > 0.6) then
			color.r = (101/255);
			color.g = (131/255);
			color.b = (41/255);
	else
		if(perc > 0.2) then
				color.r = (( 100+((0.6-perc)*100*(128/40)))/255);
				color.g = ((200+((0.6-perc)*100*(-89/40)))/255);
				color.b = ((12+((0.6-perc)*100*(-136/40)))/255);
		else
				color.r = (206/255);
				color.g = (17/255);
				color.b = (17/255);
		end
end


	
	if (unit) then
		local change = getglobal("Nurfed_"..unit.."name");
		if (unit == "target") then
			if (UnitIsTapped(unit) and not UnitIsTappedByPlayer(unit)) then
				change:SetBackdropColor(1, (165/255), 0, .95);
			elseif (UnitIsTapped(unit) and UnitIsTappedByPlayer(unit)) then
				change:SetBackdropColor(1, 0, 0, .95);
			elseif (UnitPlayerControlled(unit) and UnitCanAttack(unit, "player") and UnitCanAttack("player", unit)) then
				change:SetBackdropColor(1, 0, 0, .95);
			elseif (UnitCreatureType(unit) == "Humanoid" and UnitIsFriend("player", unit) and not UnitIsPlayer(unit)) then
				change:SetBackdropColor(0, (100/255), 0, .95);
			else
				change:SetBackdropColor(.06, .13, .22, .95);
			end
		end
	end
	return color;
end

ManaBarColor[0] = { r = (141/255), g = (185/255), b = (111/255), prefix = TEXT(MANA) };	-- mana
ManaBarColor[1] = { r = (230/255), g = (030/255), b = (030/255), prefix = TEXT(MANA) };	-- rage
ManaBarColor[2] = { r = (160/255), g = (170/255), b = (185/255), prefix = TEXT(MANA) };	-- focus
ManaBarColor[3] = { r = (230/255), g = (230/255), b = (030/255), prefix = TEXT(MANA) };	-- energy
ManaBarColor[4] = { r = (160/255), g = (170/255), b = (185/255), prefix = TEXT(MANA) };	-- happiness

if (not Nurfed_UnitsLayout) then

	Nurfed_UnitsLayout = {};

	Nurfed_UnitsLayout.Name = "Tknp Modified Nurfed (Now with less fat)";
	Nurfed_UnitsLayout.Author = "Tivoli";

	--Frame Templates
	Nurfed_UnitsLayout.templates = {
		Nurfed_UnitCharcoal_Outline = {
			type = "Font",
			Font = { NRF_FONT.."Charcoal.ttf", 15, "OUTLINE" },
			TextColor = { 1, 1, 1 },
		},
		Nurfed_UnitCharcoal_Name = {
			type = "Font",
			Font = { "Fonts\\FZBWJW.TTF", 18, "OUTLINE" },
			TextColor = { 1, 1, 1 },
		},

		Nurfed_Unit_backdrop = {
			bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
			edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
			tile = true,
			tileSize = 16,
			edgeSize = 16,
			insets = { left = 5, right = 5, top = 5, bottom = 5 },
		},

		Nurfed_Unit_hp = {
			type = "StatusBar",
			FrameStrata = "LOW",
			Orientation = "HORIZONTAL",
			StatusBarTexture = NRF_IMG.."statusbar6",
			children = {
				bg = {
					type = "Texture",
					layer = "BACKGROUND",
					Texture = NRF_IMG.."statusbar6",
					VertexColor = { 1, 0, 0, 0.15 },
					Anchor = "all"
				},
				text = {
					type = "FontString",
					layer = "OVERLAY",
					FontObject = "Nurfed_UnitCharcoal_Outline",
					JustifyH = "LEFT",
					ShadowColor = { 0, 0, 0, 0.25},
					ShadowOffset = { 1, -1 },
					TextColor = { 0.75, 0.75, 0.75 },
					Anchor = "all",
					vars = { format = "$cur / $max" },
				},
				text2 = {
					type = "FontString",
					layer = "OVERLAY",
					FontObject = "Nurfed_UnitCharcoal_Outline",
					JustifyH = "RIGHT",
					ShadowColor = { 0, 0, 0, 0.25 },
					ShadowOffset = { 1, -1 },
					TextColor = { 0.75, 0.75, 0.75 },
					Anchor = "all",
					vars = { format = "[$perc]" },
				},
			},
			vars = { ani = "glide" },
		},

		Nurfed_Unit_mp = {
			type = "StatusBar",
			FrameStrata = "LOW",
			Orientation = "HORIZONTAL",
			StatusBarTexture = NRF_IMG.."statusbar6",
			children = {
				bg = {
					type = "Texture",
					layer = "BACKGROUND",
					Texture = NRF_IMG.."statusbar6",
					VertexColor = { 0, 1, 1, 0.25 },
					Anchor = "all" },
				text = {
					type = "FontString",
					layer = "OVERLAY",
					FontObject = "Nurfed_UnitCharcoal_Outline",
					JustifyH = "LEFT",
					ShadowColor = { 0, 0, 0, 0.25 },
					ShadowOffset = { 1, -1 },
					TextColor = { 0.75, 0.75, 0.75 },
					Anchor = "all",
					vars = { format = "$cur / $max" },
				},
			},
			vars = { ani = "glide" },
		},

		Nurfed_Unit_xp = {
			type = "StatusBar",
			strata = "LOW",
			Orientation = "HORIZONTAL",
			StatusBarTexture = NRF_IMG.."statusbar6",
			children = {
				bg = {
					type = "Texture",
					layer = "BACKGROUND",
					Texture = NRF_IMG.."statusbar6",
					VertexColor = { 1, 1, 1, 0.21 },
					Anchor = "all" },
				text = {
					type = "FontString",
					layer = "OVERLAY",
					Font = { NRF_FONT.."Charcoal.ttf", 11, "NONE" },
					JustifyH = "CENTER",
					ShadowColor = { 0, 0, 0, 0.25 },
					ShadowOffset = { 1, -1 },
					TextColor = { 0.75, 0.75, 0.75 },
					Anchor = "all",
					vars = { format = "$cur/$max" },
				},
				text2 = {
					type = "FontString",
					layer = "OVERLAY",
					Font = { NRF_FONT.."Charcoal.ttf", 11, "NONE" },
					JustifyH = "RIGHT",
					ShadowColor = { 0, 0, 0, 0.25 },
					ShadowOffset = { 1, -1 },
					TextColor = { 0.75, 0.75, 0.75 },
					Anchor = "all",
					vars = { format = "[$perc]" },
				},
			},
		},

		Nurfed_Unit_model = {
			type = "PlayerModel",
			FrameStrata = "LOW",
			ModelScale = 1.9,
			Camera = 0,
			FrameLevel = 2,
		},

		Nurfed_Model_frame = {
			type = "Frame",
			FrameStrata = "LOW",
			FrameLevel = 2,
			Backdrop = { 
				bgFile = NRF_IMG.."statusbar6",
				edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
				tile = true,
				tileSize = 100,
				edgeSize = 16,
				insets = { left = 4, right = 4, top = 4, bottom = 4 },
				},
			BackdropColor = { .11, .23, .09, .95 },
--			BackdropBorderColor = { (141/255), (185/255), (111/255), 1 },
			BackdropBorderColor = { (141/255), (185/255), (111/255), 1 },
--			BackdropBorderColor = { (141/255), (185/255), (111/255), 1 },
--			BackdropBorderColor = { (141/255), (185/255), (111/255), 1 },
		}, 

		Nurfed_Pet_frame = {
			type = "Frame",
			FrameStrata = "LOW",
			FrameLevel = 2,
			Backdrop = { 
				bgFile = NRF_IMG.."statusbar6",
				edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
				tile = true,
				tileSize = 100,
				edgeSize = 16,
				insets = { left = 4, right = 4, top = 4, bottom = 4 },
				},
			BackdropColor = { .11, .23, .09, .95 },
			BackdropBorderColor = { (141/255), (185/255), (111/255), 1 },
		},

		Nurfed_Name_frame = {
			type = "Frame",
			Backdrop = {
				bgFile = NRF_IMG.."statusbar6",
				edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
				tile = true,
				tileSize = 100,
				edgeSize = 16,
				insets = { left = 4, right = 4, top = 4, bottom = 4 },
				},
			BackdropColor = { .11, .23, .09, .95 },
			BackdropBorderColor = { (141/255), (185/255), (111/255), 1 },
			children = {
				text = {
					type = "FontString",
					size = { 120, 28 },
					layer = "OVERLAY",
					FontObject = "Nurfed_UnitCharcoal_Name",
					JustifyH = "CENTER",
					Anchor = { "CENTER", "$parent", "CENTER", 0, 1 },
					vars = { format = "$name" },
				},
			},
		},

		Nurfed_Unit_hiighlight = {
			type = "Frame",
			FrameLevel = 3,
			children = {
				bg = {
					type = "Texture",
					layer = "BACKGROUND",
--					Texture = "Interface\\Buttons\\UI-Listbox-Highlight2",
--					Texture = "Interface\\QuestFrame\\UI-QuestLogTitleHighlight",
					Texture = "Interface\\PaperDollInfoFrame\\UI-Character-Tab-Highlight",
--					Texture = "Interface\\Spellbook\\UI-SpellbookPanel-Tab-Highlight",
					VertexColor = { (135/255), (206/255), (250/255), .75 },
					BlendMode = "ADD",
--					BlendMode = "MOD",
					Anchor = "all"
				},
			},
		},

		Nurfed_Unit_tottott = {
			type = "Button",
			size = { 110, 40 },
			FrameStrata = "LOW",
			Backdrop = {
				bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
				edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
				tile = true,
				tileSize = 16,
				edgeSize = 16,
				insets = { left = 2, right = 2, top = 2, bottom = 2 }
			},
			BackdropColor = { .2, .2, .2, 0.85 },
			BackdropBorderColor = { (141/255), (185/255), (111/255), 1 },
			children = {
				hp = {
					type = "StatusBar",
					size = { 70, 16 },
					FrameStrata = "LOW",
					Orientation = "HORIZONTAL",
					StatusBarTexture = NRF_IMG.."statusbar6",
					Anchor = { "BOTTOMLEFT", "$parent", "BOTTOMLEFT", 5, 5 },
					children = {
						bg = {
							type = "Texture",
							layer = "BACKGROUND",
							Texture = NRF_IMG.."statusbar6",
							VertexColor = { 0, 1, 1, 0.25 },
							Anchor = "all",
						},
						text = {
							type = "FontString",
							layer = "OVERLAY",
							Font = { NRF_FONT.."Charcoal.ttf", 12, "OUTLINE" },
							JustifyH = "RIGHT",
							ShadowColor = { 0, 0, 0, 0.25 },
							ShadowOffset = { 1, -1 },
							TextColor = { 0.75, 0.75, 0.75 },
							Anchor = "all",
							vars = { format = "[$perc]" },
						},
					},
				},
				name = {
					type = "FontString",
					size = { 74, 13 },
					layer = "OVERLAY",
					Font = { "Fonts\\FZBWJW.TTF", 12, "OUTLINE" },
					JustifyH = "LEFT",
					ShadowColor = { 0, 0, 0, 0.75 },
					ShadowOffset = { 1, -1 },
					Anchor = { "TOPLEFT", "$parent", "TOPLEFT", 5, -5 },
					vars = { format = "$name" },
				},
				classicon = {
					type = "Texture",
					size = { 30, 30 },
					layer = "OVERLAY",
					Texture = "Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes",
					Anchor = { "TOPRIGHT", "$parent", "TOPRIGHT", -4, -5 },
				},
				debuff1 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "TOPLEFT", "$parent", "TOPRIGHT", -1, -3 } },
				debuff2 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "LEFT", "$parentdebuff1", "RIGHT", 0, 0 } },
				debuff3 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "TOP", "$parentdebuff1", "BOTTOM", 0, 0 } },
				debuff4 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "LEFT", "$parentdebuff3", "RIGHT", 0, 0 } },
			},
			OnClick = function() Nurfed_Unit_OnClick(arg1) end,
			Hide = true,
		},

		Nurfed_Unit_mini = {
			type = "Button",
			size = { 80, 40 },
			FrameStrata = "LOW",
			Backdrop = {
				bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
				edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
				tile = true,
				tileSize = 16,
				edgeSize = 16,
				insets = { left = 2, right = 2, top = 2, bottom = 2 }
			},
			BackdropColor = { .2, .2, .2, 0.85 },
			BackdropBorderColor = { (141/255), (185/255), (111/255), 1 },
			children = {
				hp = {
					type = "StatusBar",
					size = { 70, 16 },
					FrameStrata = "LOW",
					Orientation = "HORIZONTAL",
					StatusBarTexture = NRF_IMG.."statusbar6",
					Anchor = { "BOTTOMLEFT", "$parent", "BOTTOMLEFT", 5, 5 },
					children = {
						bg = {
							type = "Texture",
							layer = "BACKGROUND",
							Texture = NRF_IMG.."statusbar6",
							VertexColor = { 1, 0, 0, 0.25 },
							Anchor = "all",
						},
						text = {
							type = "FontString",
							layer = "OVERLAY",
							Font = { NRF_FONT.."Charcoal.ttf", 12, "OUTLINE" },
							JustifyH = "RIGHT",
							ShadowColor = { 0, 0, 0, 0.25 },
							ShadowOffset = { 1, -1 },
							TextColor = { 0.75, 0.75, 0.75 },
							Anchor = "all",
							vars = { format = "[$perc]" },
						},
					},
				},
				name = {
					type = "FontString",
					size = { 74, 13 },
					layer = "OVERLAY",
					Font = { "Fonts\\FZBWJW.TTF", 12, "OUTLINE" },
					JustifyH = "LEFT",
					ShadowColor = { 0, 0, 0, 0.75 },
					ShadowOffset = { 1, -1 },
					Anchor = { "TOPLEFT", "$parent", "TOPLEFT", 5, -5 },
					vars = { format = "$name" },
				},
			},
			OnClick = function() Nurfed_Unit_OnClick(arg1) end,
			Hide = true,
		},

		Nurfed_Party = {
			type = "Button",
			size = { 200, 50 },
			FrameStrata = "LOW",
			ClampedToScreen = true,
			Backdrop = "Nurfed_Unit_backdrop",
			BackdropColor = { .2, .2, .2, 0.85 },
			BackdropBorderColor = { (141/255), (185/255), (111/255), 1 },
			Movable = true,
			Mouse = true,
			children = {
				hp = {
					template = "Nurfed_Unit_hp",
					size = { 190, 15 },
					Anchor = { "BOTTOMRIGHT", "$parent", "BOTTOMRIGHT", -5, 17 },
				},
				mp = {
					template = "Nurfed_Unit_mp",
					size = { 190, 11 },
					Anchor = { "BOTTOMRIGHT", "$parent", "BOTTOMRIGHT", -5, 5 },
				},
--				model_frame = {
--					template = "Nurfed_Model_frame",
--					size = { 50, 50 },
--					Anchor = { "TOPLEFT", "$parent", "TOPLEFT", 0, 4 },
--				},
--				model = {
--					template = "Nurfed_Unit_model",
--					size = { 40, 40 },
--					Anchor = { "BOTTOMLEFT", "$parentmodel_frame", "BOTTOMLEFT", 6, 4 },
--				},
				name = {
					template = "Nurfed_Name_frame",
					size = { 130, 28 },
					Anchor = { "TOPRIGHT", "$parent", "TOPRIGHT", -5, 15 },
				},
				highlight = {
					template = "Nurfed_Unit_hiighlight",
					size = { 120, 16 },
					Anchor = { "CENTER", "$parentname", "CENTER", 0, 0 },
				},
				leader = {
					type = "Texture",
					size = { 13, 13 },
					layer = "OVERLAY",
					Texture = "Interface\\GroupFrame\\UI-Group-LeaderIcon",
					Anchor = { "TOPLEFT", "$parent", "TOPLEFT", 30, 10 },
				},
				master = {
					type = "Texture",
					size = { 13, 13 },
					layer = "OVERLAY",
					Texture = "Interface\\GroupFrame\\UI-Group-MasterLooter",
					Anchor = { "TOPLEFT", "$parent", "TOPLEFT", 45, 12 },
				},
				level = {
					type = "FontString",
					size = { 30, 15 },
					layer = "OVERLAY",
					Font = { NRF_FONT.."Charcoal.ttf", 14, "NONE" },
					JustifyH = "LEFT",
					Anchor = { "TOPLEFT", "$parent", "TOPLEFT", 8, -3 },
					vars = { format = "$level" },
				},
				pvp = {
					type = "FontString",
					size = { 60, 15 },
					layer = "OVERLAY",
					Font = { NRF_FONT.."Charcoal.ttf", 14, "NONE" },
					JustifyH = "LEFT",
					TextColor = { 0.5, 0.5, 0.5 },
					Anchor = { "TOPLEFT", "$parent", "TOPLEFT", 30, -3 },
				},
				feedback = {
					type = "MessageFrame",
					layer = "OVERLAY",
					size = { 50, 16 },
					Font = { NRF_FONT.."Charcoal.ttf", 15, "OUTLINE" },
					JustifyH = "LEFT",
					Anchor = { "CENTER", "$parent", "CENTER", 20, -5 },
					FadeDuration = 0.5,
					TimeVisible = 1,
					FrameLevel = 3,
				},
				pet = {
					template = "Nurfed_Unit_mini",
					Anchor = { "BOTTOMLEFT", "$parent", "BOTTOMRIGHT", -4, 2 },
				},

				buff1 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "TOPLEFT", "$parent", "BOTTOMLEFT", 4, 0 } },
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
				debuff1 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "TOPLEFT", "$parent", "TOPRIGHT", -3, 14 } },
				debuff2 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "LEFT", "$parentdebuff1", "RIGHT", 1, 0 } },
				debuff3 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "LEFT", "$parentdebuff2", "RIGHT", 1, 0 } },
				debuff4 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "LEFT", "$parentdebuff3", "RIGHT", 1, 0 } },
			},
			vars = { aurawidth = 176, aurasize = 16 },
		},

	};

	--Frame Design
	Nurfed_UnitsLayout.Layout = {
		player = {
			type = "Button",
			size = { 246, 80 },
			FrameStrata = "LOW",
			ClampedToScreen = true,
			Backdrop = "Nurfed_Unit_backdrop",
			BackdropColor = { .2, .2, .2, 0.95 },
			BackdropBorderColor = { (141/255), (185/255), (111/255), 1 },
			Movable = true,
			Mouse = true,
			children = {
				hp = {
					template = "Nurfed_Unit_hp",
					size = { 163, 23 },
					Anchor = { "BOTTOMRIGHT", "$parentmp", "TOPRIGHT", 0, 1 },
				},
				mp = {
					template = "Nurfed_Unit_mp",
					size = { 163, 21 },
					Anchor = { "BOTTOMRIGHT", "$parent", "BOTTOMRIGHT", -5, 5 },
				},
				xp_frame = {
                    template = "Nurfed_Model_frame",
					size = { 246, 21 },
					Anchor = { "TOPLEFT", "$parent", "BOTTOMLEFT", 0, 4 },
				},
                xp = {
					template = "Nurfed_Unit_xp",
					size = { 235, 10 },
					Anchor = { "LEFT", "$parentxp_frame", "LEFT", 6, 0 },
				},
				model_frame = {
					template = "Nurfed_Model_frame",
					size = { 80, 80 },
					Anchor = { "TOPLEFT", "$parent", "TOPLEFT", 0, 0 },
				},
				model = {
					template = "Nurfed_Unit_model",
					size = { 70, 70 },
					Anchor = { "BOTTOMLEFT", "$parentmodel_frame", "BOTTOMLEFT", 6, 4 },
				},
				name = {
					template = "Nurfed_Name_frame",
					size = { 130, 28 },
					Anchor = { "TOPRIGHT", "$parent", "TOPRIGHT", -5, 15 },
				},
				level = {
					type = "FontString",
					size = { 30, 15 },
					layer = "OVERLAY",
					Font = { NRF_FONT.."Charcoal.ttf", 14, "NONE" },
					JustifyH = "LEFT",
					Anchor = { "TOPLEFT", "$parent", "TOPLEFT", 80, -12 },
					vars = { format = "$level" },
				},
				rank = {
					type = "Texture",
					size = { 15, 15 },
					layer = "OVERLAY",
					Anchor = { "TOPLEFT", "$parent", "TOPLEFT", 97, -12 },
				},
				pvp = {
					type = "FontString",
					size = { 60, 15 },
					layer = "OVERLAY",
					Font = { NRF_FONT.."Charcoal.ttf", 14, "NONE" },
					JustifyH = "LEFT",
					TextColor = { 0.5, 0.5, 0.5 },
					Anchor = { "TOPLEFT", "$parent", "TOPLEFT", 115, -12 },
				},
				class = {
					type = "FontString",
					size = { 125, 15 },
					layer = "OVERLAY",
					Font = { "Fonts\\FZBWJW.TTF", 14, "NONE" },
					JustifyH = "RIGHT",
					TextColor = { 0.5, 0.5, 0.5 },
					Anchor = { "TOPRIGHT", "$parent", "TOPRIGHT", -7, -12 },
					vars = { format = "$race / $class" },
				},
				status = {
					type = "Texture",
					size = { 17, 17 },
					layer = "OVERLAY",
					Texture = "Interface\\CharacterFrame\\UI-StateIcon",
					Anchor = { "TOPLEFT", "$parent", "TOPLEFT", 77, 5 },
				},
				leader = {
					type = "Texture",
					size = { 12, 12 },
					layer = "OVERLAY",
					Texture = "Interface\\GroupFrame\\UI-Group-LeaderIcon",
					Anchor = { "TOPLEFT", "$parent", "TOPLEFT", 104, 3 },
				},
				master = {
					type = "Texture",
					size = { 12, 12 },
					layer = "OVERLAY",
					Texture = "Interface\\GroupFrame\\UI-Group-MasterLooter",
					Anchor = { "TOPLEFT", "$parent", "TOPLEFT", 92, 4 },
				},
				group = {
					type = "FontString",
					size = { 50, 14 },
					layer = "OVERLAY",
					Font = { NRF_FONT.."Charcoal.ttf", 13, "NONE" },
					JustifyH = "LEFT",
					TextColor = { 0.5, 0.5, 0.5 },
					Anchor = { "CENTER", "$parentmodel_frame", "TOP", 0, 5 },
				},
				combo1 = {
					type = "Texture",
					layer = "OVERLAY",
					size = { 32, 16 },
					Texture = "Interface\\ComboFrame\\ComboPoint",
					VertexColor = { (200/255), (200/255), (255/255), 1 },
					Anchor = { "TOPLEFT", "$parent", "TOPLEFT", -11, 5 },
					vars = {
						id = 1,
					},
				},
				combo2 = {
					type = "Texture",
					layer = "OVERLAY",
					size = { 32, 16 },
					Texture = "Interface\\ComboFrame\\ComboPoint",
					VertexColor = { (200/255), (200/255), (255/255), 1 },
					Anchor = { "TOP", "$parentcombo1", "BOTTOM", 0, 0 },
					vars = { id = 2, },
				},
				combo3 = {
					type = "Texture",
					layer = "OVERLAY",
					size = { 32, 16 },
					Texture = "Interface\\ComboFrame\\ComboPoint",
					VertexColor = { (200/255), (200/255), (255/255), 1 },
					Anchor = { "TOP", "$parentcombo2", "BOTTOM", 0, 0 },
					vars = { id = 3, },
				},
				combo4 = {
					type = "Texture",
					layer = "OVERLAY",
					size = { 32, 16 },
					Texture = "Interface\\ComboFrame\\ComboPoint",
					VertexColor = { (200/255), (200/255), (255/255), 1 },
					Anchor = { "TOP", "$parentcombo3", "BOTTOM", 0, 0 },
					vars = { id = 4, },
				},
				combo5 = {
					type = "Texture",
					layer = "OVERLAY",
					size = { 32, 16 },
					Texture = "Interface\\ComboFrame\\ComboPoint",
					VertexColor = { (255/255), (255/255), (255/255), 1 },
					Anchor = { "TOP", "$parentcombo4", "BOTTOM", 0, 0 },
					vars = { id = 5, },
				},
				feedback = {
					type = "MessageFrame",
					layer = "OVERLAY",
					size = { 110, 21 },
					Font = { NRF_FONT.."Charcoal.ttf", 20, "OUTLINE" },
					JustifyH = "LEFT",
					Anchor = { "BOTTOMLEFT", "$parent", "BOTTOMLEFT", 7, -3 },
					FadeDuration = 0.5,
					TimeVisible = 1,
					FrameLevel = 3,
				},
			},
		},

		target = {
			type = "Button",
			size = { 250, 80 },
			FrameStrata = "LOW",
			ClampedToScreen = true,
			Backdrop = "Nurfed_Unit_backdrop",
			BackdropColor = { .2, .2, .2, 0.95 },
			BackdropBorderColor = { (141/255), (185/255), (111/255), 1 },
			Movable = true,
			Mouse = true,
			children = {
				hp = {
					template = "Nurfed_Unit_hp",
					size = { 166, 23 },
					Anchor = { "BOTTOMRIGHT", "$parentmp", "TOPRIGHT", 0, 1 },
				},
				mp = {
					template = "Nurfed_Unit_mp",
					size = { 166, 21 },
					Anchor = { "BOTTOMLEFT", "$parent", "BOTTOMLEFT", 5, 5 },
				},
				model_frame = {
					template = "Nurfed_Model_frame",
					size = { 80, 80 },
					Anchor = { "TOPRIGHT", "$parent", "TOPRIGHT", 0, 0 },
				},
				model = {
					template = "Nurfed_Unit_model",
					size = { 70, 70 },
					Anchor = { "BOTTOMLEFT", "$parentmodel_frame", "BOTTOMLEFT", 6, 4 },
				},
				name = {
					template = "Nurfed_Name_frame",
					size = { 155, 28 },
					Anchor = { "TOPLEFT", "$parent", "TOPLEFT", 5, 15 },
				},
				level = {
					type = "FontString",
					size = { 30, 15 },
					layer = "OVERLAY",
					Font = { NRF_FONT.."Charcoal.ttf", 14, "NONE" },
					JustifyH = "RIGHT",
					Anchor = { "TOPRIGHT", "$parent", "TOPRIGHT", -80, -12 },
					vars = { format = "$level" },
				},
				pvp = {
					type = "FontString",
					size = { 60, 15 },
					layer = "OVERLAY",
					Font = { NRF_FONT.."Charcoal.ttf", 14, "NONE" },
					JustifyH = "RIGHT",
					TextColor = { 0.5, 0.5, 0.5 },
					Anchor = { "TOPRIGHT", "$parent", "TOPRIGHT", -115, -12 },
				},
				rank = {
					type = "Texture",
					size = { 15, 15 },
					layer = "OVERLAY",
					Anchor = { "TOPRIGHT", "$parent", "TOPRIGHT", -97, -12 },
				},
				class = {
					type = "FontString",
					size = { 125, 15 },
					layer = "OVERLAY",
					Font = { "Fonts\\FZBWJW.TTF", 14, "NONE" },
					JustifyH = "LEFT",
					TextColor = { 0.5, 0.5, 0.5 },
					Anchor = { "TOPLEFT", "$parent", "TOPLEFT", 7, -12 },
					vars = { format = "$race / $class" },
				},
				raidtarget = {
					type = "Texture",
					Texture = "Interface\\TargetingFrame\\UI-RaidTargetingIcons",
					size = { 15, 15 },
					layer = "OVERLAY",
					Anchor = { "CENTER", "$parentmodel_frame", "TOP", 0, 10 },
					Hide = true,
				},

				target = { template = "Nurfed_Unit_tottott", Anchor = { "TOPLEFT", "$parent", "TOPRIGHT", -4, 0 } },
				targettarget = { template = "Nurfed_Unit_tottott", Anchor = { "BOTTOMLEFT", "$parent", "BOTTOMRIGHT", -4, 0 } },
				buff1 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "TOPLEFT", "$parent", "BOTTOMLEFT", 4, 0 } },
				buff2 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "LEFT", "$parentbuff1", "RIGHT", 0, 0 } },
				buff3 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "LEFT", "$parentbuff2", "RIGHT", 0, 0 } },
				buff4 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "LEFT", "$parentbuff3", "RIGHT", 0, 0 } },
				buff5 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "LEFT", "$parentbuff4", "RIGHT", 0, 0 } },
				buff6 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "LEFT", "$parentbuff5", "RIGHT", 0, 0 } },
				buff7 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "LEFT", "$parentbuff6", "RIGHT", 0, 0 } },
				buff8 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "LEFT", "$parentbuff7", "RIGHT", 0, 0 } },
				buff9 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "TOPLEFT", "$parentbuff1", "BOTTOMLEFT", 0, -1 } },
				buff10 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "LEFT", "$parentbuff9", "RIGHT", 0, 0 } },
				buff11 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "LEFT", "$parentbuff10", "RIGHT", 0, 0 } },
				buff12 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "LEFT", "$parentbuff11", "RIGHT", 0, 0 } },
				buff13 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "LEFT", "$parentbuff12", "RIGHT", 0, 0 } },
				buff14 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "LEFT", "$parentbuff13", "RIGHT", 0, 0 } },
				buff15 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "LEFT", "$parentbuff14", "RIGHT", 0, 0 } },
				buff16 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "LEFT", "$parentbuff15", "RIGHT", 0, 0 } },
				debuff1 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "TOPLEFT", "$parentbuff9", "BOTTOMLEFT", 0, -1 } },
				debuff2 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "LEFT", "$parentdebuff1", "RIGHT", 0, 0 } },
				debuff3 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "LEFT", "$parentdebuff2", "RIGHT", 0, 0 } },
				debuff4 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "LEFT", "$parentdebuff3", "RIGHT", 0, 0 } },
				debuff5 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "LEFT", "$parentdebuff4", "RIGHT", 0, 0 } },
				debuff6 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "LEFT", "$parentdebuff5", "RIGHT", 0, 0 } },
				debuff7 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "LEFT", "$parentdebuff6", "RIGHT", 0, 0 } },
				debuff8 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "LEFT", "$parentdebuff7", "RIGHT", 0, 0 } },
				debuff9 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "TOP", "$parentdebuff1", "BOTTOM", 0, 0 } },
				debuff10 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "LEFT", "$parentdebuff9", "RIGHT", 0, 0 } },
				debuff11 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "LEFT", "$parentdebuff10", "RIGHT", 0, 0 } },
				debuff12 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "LEFT", "$parentdebuff11", "RIGHT", 0, 0 } },
				debuff13 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "LEFT", "$parentdebuff12", "RIGHT", 0, 0 } },
				debuff14 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "LEFT", "$parentdebuff13", "RIGHT", 0, 0 } },
				debuff15 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "LEFT", "$parentdebuff14", "RIGHT", 0, 0 } },
				debuff16 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "LEFT", "$parentdebuff15", "RIGHT", 0, 0 } },
			},
			vars = { aurawidth = 336, aurasize = 21 },
		},

		pet = {
			type = "Button",
			size = { 163, 48 },
			FrameStrata = "LOW",
			ClampedToScreen = true,
			Backdrop = { template = "Nurfed_Unit_backdrop" },
			BackdropColor = { .2, .2, .2, 0.85 },
			BackdropBorderColor = { (141/255), (185/255), (111/255), 1 },
			Movable = true,
			Mouse = true,
			children = {
				hp = {
					template = "Nurfed_Unit_hp",
					size = { 110, 14 },
					Anchor = { "BOTTOMRIGHT", "$parent", "BOTTOMRIGHT", -5, 18 },
				},
				mp = {
					template = "Nurfed_Unit_mp",
					size = { 110, 12 },
					Anchor = { "BOTTOMRIGHT", "$parent", "BOTTOMRIGHT", -5, 5 },
				},
				model_frame = {
					template = "Nurfed_Pet_frame",
					size = { 50, 50 },
					Anchor = { "TOPLEFT", "$parent", "TOPLEFT", 0, 2 },
				},
				model = {
					template = "Nurfed_Unit_model",
					size = { 40, 40 },
					Anchor = { "BOTTOMLEFT", "$parentmodel_frame", "BOTTOMLEFT", 6, 4 },
				},
				name = {
					template = "Nurfed_Name_frame",
					size = { 90, 25 },
					Anchor = { "TOPRIGHT", "$parent", "TOPRIGHT", -5, 10 },
				},
				happiness = {
					type = "Texture",
					Texture = "Interface\\PetPaperDollFrame\\UI-PetHappiness",
					size = { 14, 14 },
					layer = "OVERLAY",
					Anchor = { "TOPLEFT", "$parent", "TOPLEFT", 51, 4 },
					Hide = true,
				},
				buff1 = { type = "Button", uitemp = "TargetDebuffButtonTemplate", Anchor = { "TOPLEFT", "$parent", "BOTTOMLEFT", 4, 0 } },
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
	};
end
local L = AceLibrary("AceLocale-2.2"):new("ag_UnitFrames")

-- Dewdrop stuff

function aUF:CreateMenu()
	local unitTable = {}
	unitTable.UnitHeader = {
		name = L["unitsettings"],
		type = 'header',
		order = 1,
	}
	for order,unit in ipairs(self.wowClasses) do
		unitTable[unit] = aUF:CreateDewdrop(unit,(order + 1),true)
		unitTable.Space = {
			name = " ",
			type = 'header',
			order = 50,
		}
		unitTable.Groups = aUF:CreateDewdropGrouplist()
	end
	
	local agDewdropMenu = {
		type= 'group',
		args = {
			AddonHeader = {
				name = L["addonname"],
				type = 'header',
				order = 1,
			},
			Units = {
				name = L["units"],
				type = 'group',
				desc = L["UnitDesc"],
				args = unitTable,
				order = 2,
			},
			Borders = {
				name = L["borders"],
				type = 'text',
				desc = L["BordersDesc"],
				get = function()
					return self.db.profile.BorderStyle
				end,
				set = function(option)
					self.db.profile.BorderStyle = option
					self:CallUnitMethods("BorderBackground")
					self:CallUnitMethods("BorderBackground",nil,nil,nil,"subgroups")
				end,
				validate = {"Classic", "Nurfed", "Hidden"},
				order = 3,
			},
			FrameColors = {
				type= 'group',
				name = L["framecolors"],
				desc = L["framecolorsdesc"],
				args = {
					partybg = {
						name = L["partybg"],
						type = 'color',
						desc = L["partybgdesc"],
						hasAlpha = true,
						get = function()
							return self.db.profile.PartyFrameColors.r, self.db.profile.PartyFrameColors.g, self.db.profile.PartyFrameColors.b, self.db.profile.PartyFrameColors.a
						end,
						set = function(r, g, b, a)
							self.db.profile.PartyFrameColors.r, self.db.profile.PartyFrameColors.g, self.db.profile.PartyFrameColors.b, self.db.profile.PartyFrameColors.a = r, g, b, a
							self:CallUnitMethods("BorderBackground")
							self:CallUnitMethods("BorderBackground",nil,nil,nil,"subgroups")
						end,
						order = 1,
					},
					targetbg = {
						name = L["targetbg"],
						type = 'color',
						desc = L["targetbgdesc"],
						hasAlpha = true,
						get = function()
							return self.db.profile.TargetFrameColors.r, self.db.profile.TargetFrameColors.g, self.db.profile.TargetFrameColors.b, self.db.profile.TargetFrameColors.a
						end,
						set = function(r, g, b, a)
							self.db.profile.TargetFrameColors.r, self.db.profile.TargetFrameColors.g, self.db.profile.TargetFrameColors.b, self.db.profile.TargetFrameColors.a = r, g, b, a
							self:CallUnitMethods("BorderBackground")
							self:CallUnitMethods("BorderBackground",nil,nil,nil,"subgroups")
						end,
						order = 2,
					},
					border = {
						name = L["bordercolor"],
						type = 'color',
						desc = L["bordercolordesc"],
						hasAlpha = true,
						get = function()
							return self.db.profile.FrameBorderColors.r, self.db.profile.FrameBorderColors.g, self.db.profile.FrameBorderColors.b, self.db.profile.FrameBorderColors.a
						end,
						set = function(r, g, b, a)
							self.db.profile.FrameBorderColors.r, self.db.profile.FrameBorderColors.g, self.db.profile.FrameBorderColors.b, self.db.profile.FrameBorderColors.a = r, g, b, a
							self:CallUnitMethods("BorderBackground")
							self:CallUnitMethods("BorderBackground",nil,nil,nil,"subgroups")
						end,
						order = 3,
					},
				},
				order = 4,
			},
			BarColors = {
				type= 'group',
				args = {
					Health = {
						name = L["health"],
						type = 'color',
						desc = L["healthDesc"],
						get = function()
							return self.db.profile.HealthColor.r, self.db.profile.HealthColor.g, self.db.profile.HealthColor.b
						end,
						set = function(r, g, b)
							self.db.profile.HealthColor.r, self.db.profile.HealthColor.g, self.db.profile.HealthColor.b = r, g, b
							self:CallUnitMethods("StatusBarsColor")
						end,
						order = 1,
					},
					Mana = {
						name = L["mana"],
						type = 'color',
						desc = L["manaDesc"],
						get = function()
							return self.db.profile.ManaColor[0].r, self.db.profile.ManaColor[0].g, self.db.profile.ManaColor[0].b
						end,
						set = function(r, g, b)
							self.db.profile.ManaColor[0].r, self.db.profile.ManaColor[0].g, self.db.profile.ManaColor[0].b = r, g, b
							self:CallUnitMethods("StatusBarsColor")
						end,
						order = 2,
					},
					Rage = {
						name = L["rage"],
						type = 'color',
						desc = L["rageDesc"],
						get = function()
							return self.db.profile.ManaColor[1].r, self.db.profile.ManaColor[1].g, self.db.profile.ManaColor[1].b
						end,
						set = function(r, g, b)
							self.db.profile.ManaColor[1].r, self.db.profile.ManaColor[1].g, self.db.profile.ManaColor[1].b = r, g, b
							self:CallUnitMethods("StatusBarsColor")
						end,
						order = 3,
					},
					Energy = {
						name = L["energy"],
						type = 'color',
						desc = L["energyDesc"],
						get = function()
							return self.db.profile.ManaColor[3].r, self.db.profile.ManaColor[3].g, self.db.profile.ManaColor[3].b
						end,
						set = function(r, g, b)
							self.db.profile.ManaColor[3].r, self.db.profile.ManaColor[3].g, self.db.profile.ManaColor[3].b = r, g, b
							self:CallUnitMethods("StatusBarsColor")
						end,
						order = 4,
					},
					PetFocus = {
						name = L["petfocus"],
						type = 'color',
						desc = L["petfocusDesc"],
						get = function()
							return self.db.profile.ManaColor[2].r, self.db.profile.ManaColor[2].g, self.db.profile.ManaColor[2].b
						end,
						set = function(r, g, b)
							self.db.profile.ManaColor[2].r, self.db.profile.ManaColor[2].g, self.db.profile.ManaColor[2].b = r, g, b
							self:CallUnitMethods("StatusBarsColor")
						end,
						order = 5,
					},
				},
				order = 5,
				name = L["barcolors"],
				desc = L["barcolorsDesc"],
			},
			BarStyle = {
				name = L["barstyle"],
				type = 'text',
				desc = L["BarStyleDesc"],
				get = function()
					return self.db.profile.BarStyle
				end,
				set = function(option)
					self.db.profile.BarStyle = option
					self:CallUnitMethods("BarTexture")
				end,
				validate = {"Classic", "Default","Smooth", "BantoBar", "Bars", "Bumps", "Button", "Charcoal", "Cloud", "Dabs", "DarkBottom", "Diagonal", "Fourths", "Fifths", "Gloss", "Grid", "Hatched", "Perl", "Rain", "Skewed", "Smudge", "Water", "Wisps"},
				order = 6,
			},
            Spacing1 = {
				name = " ",
				type = 'header',
				order = 7,
			},
			ShowPvPIcon = {
				name = L["pvpicon"],
				type = 'toggle',
				desc = L["ShowPVPIconDesc"],
				get = function()
					return self.db.profile.ShowPvPIcon
				end,
				set = function(option)
					self.db.profile.ShowPvPIcon = option
					self:CallUnitMethods("UpdatePvP",true)
				end,
				order = 8,
			},
			ShowGroupIcons = {
				name = L["groupicon"],
				type = 'toggle',
				desc = L["ShowGroupIconsDesc"],
				get = function()
					return self.db.profile.ShowGroupIcons
				end,
				set = function(option)
					self.db.profile.ShowGroupIcons = option
					self:CallUnitMethods("LabelsCheckLeader")
				end,
				order = 9,
			},
			HighlightSelected = {
				name = L["highlightselected"],
				type = 'toggle',
				desc = L["HighlightSelectedDesc"],
				get = function()
					return self.db.profile.HighlightSelected
				end,
				set = function(option)
					self.db.profile.HighlightSelected = option
				end,
				order = 10,
			},
            SmoothBarColoring = {
				name = L["smoothbarcoloring"],
				type = 'toggle',
				desc = L["SmoothBarColoringDesc"],
				get = function()
					return self.db.profile.SmoothHealthBars
				end,
				set = function(option)
					self.db.profile.SmoothHealthBars = option
                    self:CallUnitMethods("StatusBarsColor")
				end,
				order = 11,
			},
            Spacing2 = {
				name = " ",
				type = 'header',
				order = 12,
			},
			Locked = {
				name = L["lock"],
				type = 'toggle',
				desc = L["LockedDesc"],
				get = function()
					return self.db.profile.Locked
				end,
				set = function(option)
					self.db.profile.Locked = option
				end,
				order = 15,
			},
		}
	}
	self.dewdrop:InjectAceOptionsTable(self, agDewdropMenu)
	return agDewdropMenu
end

function aUF:InitMenu()
--	if not self.menu then	
--	end
	
	local agSlashMenu = {
		type = "group",
		args = {
			config = {
				name = L["config"],
				desc = L["configdesc"],
				type = 'execute',
				func = function()
					local menu = aUF:CreateMenu()
					self.dewdrop:Open(UIParent, 'children', function() self.dewdrop:FeedAceOptionsTable(menu) end,'cursorX', true, 'cursorY', true)
				end,
			},
			reset = {
				name = L["reset"],
				desc = L["resetdesc"],
				type = 'execute',
				func = function()
					self:Reset()
				end,
			}
		}
	}
	
	self:RegisterChatCommand({ "/aguf", "/ag_unitframes" }, agSlashMenu )
end

function aUF:CreateDewdrop(class,order,mainmenu)
	--local class = type
	local prettyname = L[class]

	local strings = {"Health","Mana","Name","Class"}
	local stringArgs = {}

	for k,v in pairs(strings) do
		local name = v
		local order = k
		local validate
		if v == "Health" or v == "Mana" then
			validate = {"Absolute", "Difference", "Percent", "Smart","Custom", "Hide"}
		else
			validate = {"Default","Custom", "Hide"}
		end
		stringArgs[v] = {
			name = string.format(L["%s Text"], L[name]),
			type = 'group',
			desc = L["UnitDesc"],
			order = order,
			args = {
				StatusTextStyle = {
					name = L["Style"],
					type = 'text',
					desc = L["StatusTextDesc"],
					get = function()
						return self.db.profile[class][name.."Style"]
					end,
					set = function(option)
						self.db.profile[class][name.."Style"] = option
						
						self:SetStringFormats(class)
						self:CallUnitMethods("UpdateTextStrings",nil,class,"type")
					end,
					validate = validate,
					order = 1,
				},
				HealthCustom = {
					name = L["Custom"],
					type = 'text',
					desc = L["StatusTextDesc"],
					get = function()
						return self.db.profile[class][name.."Format"]
					end,
					set = function(option)
						self.db.profile[class][name.."Format"] = option
						
						self:SetStringFormats(class)
						self:CallUnitMethods("UpdateTextStrings",nil,class,"type")
					end,
					usage = "",
					order = 2,
				}
			}
		}
	end

	local table = {
		name = prettyname,
		type = 'group',
		desc = string.format(L["%s Settings"], prettyname),
		order = order,
		args = {
			UnitHeader = {
				name = string.format(L["layoutsettings"], prettyname),
				type = 'header',
				order = 1,
			},
			FrameStyle = {
				name = L["framestyle"],
				type = 'text',
				desc = L["FrameStyleDesc"],
				validate = {},
				get = function()
					return self.db.profile[class].FrameStyle
				end,
				set = function(option)
					self.db.profile[class].FrameStyle = option
					self:CallUnitMethods("ApplyTheme",nil,class,"type")
					self:CallUnitMethods("UpdateName",true,class,"type")
				end,
				order = 2,
			},

			Width = {
				name = L["widthadjust"],
				type = 'range',
				desc = L["widthadjustDesc"],
				min = 50,
				max = 400,
				step = 1,
				get = function()
					return self.db.profile[class].Width
				end,
				set = function(option)
					self.db.profile[class].Width = option
					self:CallUnitMethods("SetWidth",nil,class,"type")
				end,
				order = 3,
			},
			
			StatusTextStyle = {
				name = L["Status Text"],
				type = 'group',
				desc = L["UnitDesc"],
				order = 5,
				args = stringArgs,
			},
			Scale = {
				name = L["scale"],
				type = 'range',
				desc = L["ScaleDesc"],
				min = 0.5,
				max = 2,
				step = 0.01,
				isPercent = true,
				get = function()
					return self.db.profile[class].Scale
				end,
				set = function(option)
					self.db.profile[class].Scale = option
					self:CallUnitMethods("LoadScale",nil,class,"type")
					self:CallUnitMethods("LoadPosition",nil,class,"type")
				end,
				order = 7,
			},
			ClassColorBars = {
				name = L["classcolorbar"],
				type = 'toggle',
				desc = L["ClassColorBarsDesc"],
				get = function()
					return self.db.profile[class].ClassColorBars
				end,
				set = function(option)
					self.db.profile[class].ClassColorBars = option
					self:CallUnitMethods("StatusBarsColor",nil,class,"type")
				end,
				order = 20,
			},
			RaidColorName = {
				name = L["raidcolorname"],
				type = 'toggle',
				desc = L["RaidColorNameDesc"],
				get = function()
					return self.db.profile[class].RaidColorName
				end,
				set = function(option)
					self.db.profile[class].RaidColorName = option
					self:CallUnitMethods("UpdateTextStrings",nil,class,"type")
				end,
				order = 21,
			},
			ShowCombat = {
				name = L["showcombat"],
				type = 'toggle',
				desc = L["ShowCombatDesc"],
				get = function()
					return self.db.profile[class].ShowCombat
				end,
				set = function(option)
					self.db.profile[class].ShowCombat = option
				end,
				order = 23,
			},
			ShowInCombatIcon = {
				name = L["showincombat"],
				type = 'toggle',
				desc = L["ShowInCombatDesc"],
				get = function ()
					return self.db.profile[class].ShowInCombatIcon
				end,
				set = function(option)
					self.db.profile[class].ShowInCombatIcon = option
				end,
				order = 24,
			},
			ShowRaidTargetIcon = {
				name = L["showraidicon"],
				type = 'toggle',
				desc = L["ShowRaidIconDesc"],
				get = function ()
					return self.db.profile[class].ShowRaidTargetIcon
				end,
				set = function(option)
					self.db.profile[class].ShowRaidTargetIcon = option
					self:CallUnitMethods("UpdateRaidTargetIcon",true,class,"type")
				end,
				order = 25,
			},
			LongStatusbars = {
				name = L["longbars"],
				type = 'toggle',
				desc = L["LongBarsDesc"],
				get = function()
					return self.db.profile[class].LongStatusbars
				end,
				set = function(option)
					self.db.profile[class].LongStatusbars = option
					self:CallUnitMethods("ApplyTheme",nil,class,"type")
				end,
				order = 26,
			},
			HideMana = {
				name = L["hidemana"],
				type = 'toggle',
				desc = L["HideManaDesc"],
				get = function()
					return self.db.profile[class].HideMana
				end,
				set = function(option)
					self.db.profile[class].HideMana = option
					self:CallUnitMethods("ApplyTheme",nil,class,"type")
					self:CallUnitMethods("UpdateName",true,class,"type")
				end,
				order = 27,
			},
			ShowPortrait = {
				name = L["showportrait"],
				type = 'toggle',
				desc = L["ShowPortraitDesc"],
				get = function()
					return self.db.profile[class].Portrait
				end,
				set = function(option)
					self.db.profile[class].Portrait = option
					self:CallUnitMethods("ApplyTheme",nil,class,"type")
				end,
				order = 30,
			},
			HideFrame = {
				name = L["hideframe"],
				type = 'toggle',
				desc = L["HideFrameDesc"],
				get = function()
					return self.db.profile[class].HideFrame
				end,
				set = function(option)
					self.db.profile[class].HideFrame = option
					self:RAID_ROSTER_UPDATE()
					self:CallUnitMethods("UpdateAll",nil,class,"type")
				end,
				order = 32,
			},			
			Spacing1 = {
				name = " ",
				type = 'header',
				order = 35,
			},
			AuraHeader = {
				name = L["aurasettings"],
				type = 'header',
				order = 39,
			},
			AuraStyle = {
				name = L["aurastyle"],
				type = 'text',
				desc = L["AuraStyleDesc"],
				get = function()
					return self.db.profile[class].AuraStyle
				end,
				set = function(option)
					self.db.profile[class].AuraStyle = option
					self:CallUnitMethods("UpdateAuras",true,class,"type")
					self:CallUnitMethods("AuraPosition",true,class,"type")
				end,
				validate = {OneLine = L["oneline"], TwoLines = L["twolines"], Hide = L["hide"]},
				order = 40,
			},
			AuraPos = {
				name = L["aurapos"],
				type = 'text',
				desc = L["AuraPosDesc"],
				get = function()
					return self.db.profile[class].AuraPos
				end,
				set = function(option)
					self.db.profile[class].AuraPos = option
					self:CallUnitMethods("UpdateAuras",true,class,"type")
					self:CallUnitMethods("AuraPosition",true,class,"type")
				end,
				validate = {"Right", "Left", "Above", "Below"},
				order = 41,
			},
			DebuffColoring = {
				name = L["debuffcoloring"],
				type = 'toggle',
				desc = L["DebuffColoringDesc"],
				get = function()
					return self.db.profile[class].AuraDebuffC
				end,
				set = function(option)
					self.db.profile[class].AuraDebuffC = option
					self:CallUnitMethods("UpdateAuras",true,class,"type")
				end,
				order = 42,
			},
			AuraFilter = {
				name = L["aurafilter"],
				type = 'toggle',
				desc = L["AuraFilterDesc"],
				get = function()
					if self.db.profile[class].AuraFilter == 1 then
						return true
					else
						return false
					end
				end,
				set = function(option)
					if option == true then
						self.db.profile[class].AuraFilter = 1
					else
						self.db.profile[class].AuraFilter = 0
					end
					self:CallUnitMethods("UpdateAuras",true,class,"type")
				end,
				order = 43,
			}
		}
	}
	-- Inject themes from the theme table
	local themetable = {}
	for k, v in pairs(self.Layouts) do
		tinsert(themetable,k)
	end
	table.args.FrameStyle.validate = themetable

	-- PLAYER/PET
	--[[
	if class == "player" then
		local ShowRestingIcon = {
				name = L["showresting"],
				type = 'toggle',
				desc = L["ShowRestingDesc"],
				get = function()
					return self.db.profile[class].ShowRestingIcon
				end,
				set = function(option)
					self.db.profile[class].ShowRestingIcon = option
					self:CallUnitMethods("UpdateResting",nil,class,"type")
				end,
				order = 26,
			}
		table.args.ShowRestingIcon = ShowRestingIcon
	end
	]]
	if class == "player" or class == "pet" then
		local ShowXP = {
				name = L["showxp"],
				type = 'toggle',
				desc = L["ShowXPDesc"],
				get = function()
					return self.db.profile[class].ShowXP
				end,
				set = function(option)
					self.db.profile[class].ShowXP = option
					self:CallUnitMethods("ApplyTheme",nil,class,"type")
				end,
				order = 26,
			}
		table.args.ShowXP = ShowXP
	end

	if class == "pet" then
		local PetGrouping = {
				name = L["petgrouping"],
				type = 'text',
				desc = L["PetGroupingDesc"],
				get = function()
					return self.db.profile.PetGrouping
				end,
				set = function(option)
					self.db.profile.PetGrouping = option
					self:CallUnitMethods("UpdateAll")
				end,
				validate = {["withplayer"] = L["withplayer"], ["nogroup"] = L["nogroup"]},
				order = 6,
			}
		table.args.PetGrouping = PetGrouping
	end
	
	if class == "pet" or class == "partypet" or class == "raidpet" then
		table.args.RaidColorName = nil
		table.args.ClassColorBars = nil
	end
	
	-- TARGET
	if string.find(class,"target") then	
		local TargetShowHostile = {
				name = L["targetshowhostile"],
				type = 'toggle',
				desc = L["TargetHostileDesc"],
				get = function()
					return self.db.profile.TargetShowHostile
				end,
				set = function(option)
					self.db.profile.TargetShowHostile = option
					self:CallUnitMethods("StatusBarsColor",nil,class,"type")
				end,
				order = 22,
			}
		table.args.TargetShowHostile = TargetShowHostile
	end

	-- PARTY
	if class == "party" then
		local RaidHideParty = {
				name = L["raidhideparty"],
				type = 'toggle',
				desc = L["RaidHidePartyDesc"],
				get = function()
					return self.db.profile.RaidHideParty
				end,
				set = function(option)
					self.db.profile.RaidHideParty = option
--					self:CallUnitMethods("UpdateAll",nil,"party","type")
--					self:CallUnitMethods("UpdateAll",nil,"partypet","type")
					self:RAID_ROSTER_UPDATE()
				end,
				order = 28,
			}
		table.args.RaidHideParty = RaidHideParty

		local PartyGrouping = {
				name = L["partygrouping"],
				type = 'text',
				desc = L["PartyGroupingDesc"],
				get = function()
					return self.db.profile.PartyGrouping
				end,
				set = function(option)
					self.db.profile.PartyGrouping = option
					self:PARTY_MEMBERS_CHANGED()
				end,
				validate = {["withplayer"] = L["withplayer"], ["withoutplayer"] = L["withoutplayer"], ["nogroup"] = L["nogroup"]},
				order = 6,
			}
		table.args.PartyGrouping = PartyGrouping
	end
	
	-- RAID
	if class == "raid" then
		local RaidGrouping = {
				name = L["raidgrouping"],
				type = 'text',
				desc = L["RaidGroupingDesc"],
				get = function()
					return self.db.profile.RaidGrouping
				end,
				set = function(option)
					self.db.profile.RaidGrouping = option
					self:RAID_ROSTER_UPDATE()
				end,
				validate = {["bysubgroup"] = L["bysubgroup"], ["byclass"] = L["byclass"], ["byrole"] = L["byrole"], ["nogroup"] = L["nogroup"], ["onebiggroup"] = L["onebiggroup"]},
				order = 6,
			}
		table.args.RaidGrouping = RaidGrouping
	end
	
	if not mainmenu then
		table.args.UnitHeader.name = string.format(L["frame"], L[class])
		local EndSpacing = {
			name = " ",
			type = 'header',
			order = 51,
		}
		table.args.EndSpacing = EndSpacing
	end
	
	return table
end

function aUF:GroupCreateMenu(object)
	local prettyname = "Group "..object.name
	
	local AnchorTable = {}
	for k,v in pairs(self.subgroups) do
		if v and v.name then
			tinsert(AnchorTable, tostring(v.name))
		end
	end
			
	local menu = {
		name = prettyname,
		type = 'group',
		desc = prettyname,
		order = order,
		args = {
			UnitHeader = {
				name = prettyname,
				type = 'header',
				order = 1,
			},
--			AnchorTo = {
--				name = L["groupanchorto"],
--				type = 'text',
--				desc = L["groupanchortoDesc"],
--				get = function()
--					return object.database.AnchorTo
--				end,
--				set = function(option)
--					object.database.AnchorTo = option
--				end,
--				validate = AnchorTable,
--				order = 6,
--			},
			Grow = {
				name = L["groupgrow"],
				type = 'text',
				desc = L["groupgrowDesc"],
				get = function()
					return object.database.Grow
				end,
				set = function(option)
					object.database.Grow = option
					object:Update()
				end,
				validate = {["up"] = L["up"], ["down"] = L["down"], ["left"] = L["left"], ["right"] = L["right"]},
				order = 10,
			},		
			ShowAnchor = {
				name = L["groupshowanchor"],
				type = 'toggle',
				desc = L["groupshowanchorDesc"],
				get = function()
					return object.database.ShowAnchor
				end,
				set = function(option)
					object.database.ShowAnchor = option
					object:Update()
				end,
				order = 12,
			},
		}
	}
	return menu
end

function aUF:CreateDewdropGrouplist()
	local groupTable = {}
	for k,v in pairs(self.subgroups) do
		groupTable["menu"..k] = aUF:GroupCreateMenu(v)
	end
	local menu = {
				name = L["groups"],
				type = 'group',
				desc = L["groupsDesc"],
				args = groupTable,
				order = 100,
	}
	return menu
end

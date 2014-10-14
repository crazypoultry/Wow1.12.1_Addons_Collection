BINDING_HEADER_sRaidFrames = "sRaidFrames"

local L = AceLibrary("AceLocale-2.2"):new("sRaidFrames")
local surface = AceLibrary("Surface-1.0") 

sRaidFrames.options = {
	type = "group",
	args = {
		lock = {
			name = L["Lock"],
			type = "toggle",
			desc = L["Lock/Unlock the raid frames"],
			get = function()
				return sRaidFrames.opt.lock
			end,
			set = function(locked)
				sRaidFrames:S("lock", locked)
				if not locked then
					sRaidFrames:S("ShowGroupTitles", true)
					for _,f in pairs(sRaidFrames.groupframes) do
						if not locked and f:IsVisible() then
							f.title:Show()
						else
							f.title:Hide()
						end
					end
				end
			end,
			map = {[false] = L["Unlocked"], [true] = L["Locked"]},
		},

		health = {
			name = L["Health text"],
			type = "text",
			desc = L["Set health display type"],
			get = function()
				return sRaidFrames.opt.healthDisplayType
			end,
			set = function(value)
				sRaidFrames:S("healthDisplayType", value)
			end,
			validate = {["curmax"] = L["Current and max health"], ["deficit"] = L["Health deficit"], ["percent"] = L["Health percentage"], ["current"] = L["Current health"], ["none"] = L["Hide health text"]},
		},

		bufffilter = {
			name = L["Buff filter"],
			type = "group",
			desc = L["Set buff filter"],
			args = {
				add = {
					name = L["Add buff"],
					type = "text",
					desc = L["Add a buff"],
					get = false,
					set = function(value)
						if not sRaidFrames.opt.BuffFilter[value] then
							sRaidFrames.opt.BuffFilter[value] = true
							sRaidFrames:chatUpdateBuffMenu()
						end
					end,
					usage = L["<name of buff>"],
				},
			},
			disabled = function() return (sRaidFrames.opt.BuffType == "debuffs") end,
		},

		titles = {
			name = L["Show group titles"],
			type = "toggle",
			desc = L["Toggle display of titles above each group frame"],
			get = function()
				return sRaidFrames.opt.ShowGroupTitles
			end,
			set = function(value)
				sRaidFrames:S("ShowGroupTitles", value)
				for _,f in pairs(sRaidFrames.groupframes) do
					if value and f:IsVisible() then
						f.title:Show()
					else
						f.title:Hide()
					end
				end
			end,
			disabled = function() return not sRaidFrames.opt.lock end,
		},

		subsort = {
			name = L["Member sort order"],
			type = "text",
			desc = L["Select how you wish to sort the members of each group"],
			get = function()
				return sRaidFrames.opt.SubSort
			end,
			set = function(value)
				sRaidFrames:S("SubSort", value)
				sRaidFrames:Sort()
			end,
			validate = {["name"] = L["By name"], ["class"] = L["By class"], ["none"] = L["Blizzard default"]},
		},

		sort = {
			name = L["Group by"],
			type = "text",
			desc = L["Select how you wish to show the groups"],
			get = function()
				return sRaidFrames.opt.SortBy
			end,
			set = "chatSortBy",
			validate = {["group"] = L["By group"], ["class"] = L["By class"]},
		},

		bufftype = {
			name = L["Buff/Debuff visibility"],
			type = "text",
			desc = L["Show buffs or debuffs on the raid frames"],
			get = function()
				return sRaidFrames.opt.BuffType
			end,
			set = "chatBuffType",
			validate = {["buffs"] = L["Only buffs"], ["debuffs"] = L["Only debuffs"], ["buffsifnotdebuffed"] = L["Buffs if not debuffed"]},
		},

		powerfilter = {
			name = L["Power type visiblity"],
			type = "group",
			desc = L["Toggle the display of certain power types (Mana, Rage, Energy)"],
			args = {
				mana = {
					name = L["Mana"],
					type = "toggle",
					desc = L["Toggle the display of mana bars"],
					get = function()
						return sRaidFrames.opt.PowerFilter[0]
					end,
					set = function(value)
						sRaidFrames.opt.PowerFilter[0] = value
						sRaidFrames:UpdateAll()
					end,
					map = {[false] = L["hidden"], [true] = L["shown"]},
				},
				energy = {
					name = L["Energy & Focus"],
					type = "toggle",
					desc = L["Toggle the display of energy and focus bars"],
					get = function()
						return sRaidFrames.opt.PowerFilter[2]
					end,
					set = function(value)
						sRaidFrames.opt.PowerFilter[2] = value
						sRaidFrames.opt.PowerFilter[3] = value
						sRaidFrames:UpdateAll()
					end,
					map = {[false] = L["hidden"], [true] = L["shown"]},
				},
				rage = {
					name = L["Rage"],
					type = "toggle",
					desc = L["Toggle the display of rage bars"],
					get = function()
						return sRaidFrames.opt.PowerFilter[1]
					end,
					set = function(value)
						sRaidFrames.opt.PowerFilter[1] = value
						sRaidFrames:UpdateAll()
					end,
					map = {[false] = L["hidden"], [true] = L["shown"]},
				},
			},
		},

		filterdebuffs = {
			name = L["Filter dispellable debuffs"],
			type = "toggle",
			desc = L["Toggle display of dispellable debuffs only"],
			get = function()
				return sRaidFrames.opt.ShowOnlyDispellable
			end,
			set = "chatToggleDispellable",
			disabled = function() return not (sRaidFrames.opt.BuffType ~= "buffs") end,
		},
		
		invert = {
			name = L["Invert health bars"],
			type = "toggle",
			desc = L["Invert the growth of the health bars"],
			get = function()
				return sRaidFrames.opt.Invert
			end,
			set = function(value)
				sRaidFrames.opt.Invert = value
				sRaidFrames:UpdateUnit(sRaidFrames.visible)
			end,
		},

		texture = {
			name = L["Bar textures"],
			type = "text",
			desc = L["Set the texture used on health and mana bars"],
			get = function()
				return sRaidFrames.opt.Texture
			end,
			set = "chatTexture",
			validate = surface:List(),
		},

		scale = {
			name = L["Scale"],
			type = "range",
			desc = L["Set the scale of the raid frames"],
			min = 0.1,
			max = 3.0,
			step = 0.05,
			get = function()
				return sRaidFrames.opt.Scale
			end,
			set = "chatScale",
		},

		layout = {
			name = L["Layout"],
			type = "group",
			desc = L["Set the layout of the raid frames"],
			args = {
				reset = {
					name = L["Reset layout"],
					type = "execute",
					desc = L["Reset the position of sRaidFrames"],
					func = "ResetPosition"
				},
				predefined = {
					name = L["Predefined Layout"],
					type = "text",
					desc = L["Set a predefined layout for the raid frames"],
					get = function() return nil end,
					set = "chatSetLayout",
					validate = {["ctra"] = L["CT_RaidAssist"], ["horizontal"] = L["Horizontal"], ["vertical"] = L["Vertical"]},
				},
			},
		},

		backgroundcolor = {
			type = "color",
			name = L["Background color"],
			desc = L["Change the background color"],
			get = function()
				local s = sRaidFrames.opt.BackgroundColor
				return s.r, s.g, s.b, s.a
			end,
			set = "chatBackgroundColor",
			hasAlpha = true,
		},

		bordercolor = {
			type = "color",
			name = L["Border color"],
			desc = L["Change the border color"],
			get = function()
				local s = sRaidFrames.opt.BorderColor
				return s.r, s.g, s.b, s.a
			end,
			set = "chatBorderColor",
			hasAlpha = true,
			disabled = function() return not sRaidFrames.opt.Border end,
		},

		tooltips = {
			name = L["Tooltip display"],
			type = "group",
			desc = L["Determine when a tooltip is displayed"],
			args = {
				units = {
					name = L["Unit tooltips"],
					type = "text",
					desc = L["Determine when a tooltip is displayed"],
					get = function() return sRaidFrames.opt.UnitTooltipMethod end,
					set = function(value)
						sRaidFrames:S("UnitTooltipMethod", value)
					end,
					validate = {["never"] = L["Never"], ["notincombat"] = L["Only when not in combat"], ["always"] = L["Always"]},			
				},
				buffs = {
					name = L["Buff tooltips"],
					type = "text",
					desc = L["Determine when a tooltip is displayed"],
					get = function() return sRaidFrames.opt.BuffTooltipMethod end,
					set = function(value)
						sRaidFrames:S("BuffTooltipMethod", value)
					end,
					validate = {["never"] = L["Never"], ["notincombat"] = L["Only when not in combat"], ["always"] = L["Always"]},
				},
				debuffs = {
					name = L["Debuff tooltips"],
					type = "text",
					desc = L["Determine when a tooltip is displayed"],
					get = function() return sRaidFrames.opt.DebuffTooltipMethod end,
					set = function(value)
						sRaidFrames:S("DebuffTooltipMethod", value)
					end,
					validate = {["never"] = L["Never"], ["notincombat"] = L["Only when not in combat"], ["always"] = L["Always"]},
				},
			},
		},

		aggro = {
				name = L["Highlight units with aggro"],
				type = "toggle",
				desc = L["Turn the border of units who have aggro red"],
				get = function() return sRaidFrames.opt.aggro end,
				set = function(value)
					sRaidFrames:S("aggro", value)
				end,
				disabled = function() return not sRaidFrames.opt.Border end,
		},
		
		highlight = {
				name = L["Highlight targetted unit"],
				type = "toggle",
				desc = L["Turn the border of unit you are targetting orange"],
				get = function() return sRaidFrames.opt.HighlightTarget end,
				set = function(value)
					sRaidFrames:S("HighlightTarget", value)
				end,
				disabled = function() return not sRaidFrames.opt.Border end,
		},

		range = {
			name = L["Range"],
			type = "group",
			desc = L["Set about range"],
			args = {
				enable = {
					name = L["Enable range check"],
					type = "toggle",
					desc = L["Enable range checking"],
					get = function() return sRaidFrames.opt.RangeCheck end,
					set = function(value)
						sRaidFrames.opt.RangeCheck = value
						if not value then
							for unit in pairs(sRaidFrames.frames) do
								sRaidFrames.frames[unit]:SetAlpha(1)
							end
						end
					end,
					order = 1,
				},
				alpha = {
					name = L["Alpha"],
					type = "range",
					desc = L["The alpha level for units who are out of range"],
					get = function() return sRaidFrames.opt.RangeAlpha end,
					set = function(value)
						sRaidFrames.opt.RangeAlpha = value
					end,
					min  = 0,
					max  = 1,
					step = 0.1,
					disabled = function() return not sRaidFrames.opt.RangeCheck end,
				},
				frequency = {
					name = L["Frequency"],
					type = "range",
					desc = L["The interval between which range checks are performed"],
					get = function() return sRaidFrames.opt.RangeFrequency end,
					set = function(value)
						sRaidFrames.opt.RangeFrequency = value
						sRaidFrames:UpdateRangeFrequency()
					end,
					min  = 0.2,
					max  = 2.0,
					step = 0.1,
					disabled = function() return not sRaidFrames.opt.RangeCheck end,
				},
			},
		},

		filter = {
			name = L["Show Group/Class"],
			type = "group",
			desc = L["Toggle the display of certain Groups/Classes"],
			args = {
				classes = {
					name = L["Classes"],
					type = "group",
					desc = L["Classes"],
					args = {
						warriors = {
							name = L["Warriors"],
							type = "toggle",
							desc = L["Toggle the display of Warriors"],
							get = function()
								return sRaidFrames.opt.ClassFilter["WARRIOR"]
							end,
							set = function(value)
								sRaidFrames.opt.ClassFilter["WARRIOR"] = value
								sRaidFrames:UpdateVisibility()
							end,
							map = {[false] = L["hidden"], [true] = L["shown"]},
						},
						paladins = {
							name = L["Paladins"],
							type = "toggle",
							desc = L["Toggle the display of Paladins"],
							get = function()
								return sRaidFrames.opt.ClassFilter["PALADIN"]
							end,
							set = function(value)
								sRaidFrames.opt.ClassFilter["PALADIN"] = value
								sRaidFrames:UpdateVisibility()
							end,
							map = {[false] = L["hidden"], [true] = L["shown"]},
							hidden = function() return UnitFactionGroup("player") == "Horde" end,
						},
						shamans = {
							name = L["Shamans"],
							type = "toggle",
							desc = L["Toggle the display of Shamans"],
							get = function()
								return sRaidFrames.opt.ClassFilter["SHAMAN"]
							end,
							set = function(value)
								sRaidFrames.opt.ClassFilter["SHAMAN"] = value
								sRaidFrames:UpdateVisibility()
							end,
							map = {[false] = L["hidden"], [true] = L["shown"]},
							hidden = function() return UnitFactionGroup("player") == "Alliance" end,
						},
						hunters = {
							name = L["Hunters"],
							type = "toggle",
							desc = L["Toggle the display of Hunters"],
							get = function()
								return sRaidFrames.opt.ClassFilter["HUNTER"]
							end,
							set = function(value)
								sRaidFrames.opt.ClassFilter["HUNTER"] = value
								sRaidFrames:UpdateVisibility()
							end,
							map = {[false] = L["hidden"], [true] = L["shown"]},
						},
						warlocks = {
							name = L["Warlocks"],
							type = "toggle",
							desc = L["Toggle the display of Warlocks"],
							get = function()
								return sRaidFrames.opt.ClassFilter["WARLOCK"]
							end,
							set = function(value)
								sRaidFrames.opt.ClassFilter["WARLOCK"] = value
								sRaidFrames:UpdateVisibility()
							end,
							map = {[false] = L["hidden"], [true] = L["shown"]},
						},
						mages = {
							name = L["Mages"],
							type = "toggle",
							desc = L["Toggle the display of Mages"],
							get = function()
								return sRaidFrames.opt.ClassFilter["MAGE"]
							end,
							set = function(value)
								sRaidFrames.opt.ClassFilter["MAGE"] = value
								sRaidFrames:UpdateVisibility()
							end,
							map = {[false] = L["hidden"], [true] = L["shown"]},
						},
						druids = {
							name = L["Druids"],
							type = "toggle",
							desc = L["Toggle the display of Druids"],
							get = function()
								return sRaidFrames.opt.ClassFilter["DRUID"]
							end,
							set = function(value)
								sRaidFrames.opt.ClassFilter["DRUID"] = value
								sRaidFrames:UpdateVisibility()
							end,
							map = {[false] = L["hidden"], [true] = L["shown"]},
						},
						rogues = {
							name = L["Rogues"],
							type = "toggle",
							desc = L["Toggle the display of Rogues"],
							get = function()
								return sRaidFrames.opt.ClassFilter["ROGUE"]
							end,
							set = function(value)
								sRaidFrames.opt.ClassFilter["ROGUE"] = value
								sRaidFrames:UpdateVisibility()
							end,
							map = {[false] = L["hidden"], [true] = L["shown"]},
						},
						priests = {
							name = L["Priests"],
							type = "toggle",
							desc = L["Toggle the display of Priests"],
							get = function()
								return sRaidFrames.opt.ClassFilter["PRIEST"]
							end,
							set = function(value)
								sRaidFrames.opt.ClassFilter["PRIEST"] = value
								sRaidFrames:UpdateVisibility()
							end,
							map = {[false] = L["hidden"], [true] = L["shown"]},
						},
					},
				},
				groups = {
					name = L["Groups"],
					type = "group",
					desc = L["Groups"],
					args = {
						group1 = {
							name = L["Group 1"],
							type = "toggle",
							desc = L["Toggle the display of Group 1"],
							get = function()
								return sRaidFrames.opt.GroupFilter[1]
							end,
							set = function(value)
								sRaidFrames.opt.GroupFilter[1] = value
								sRaidFrames:UpdateVisibility()
							end,
							map = {[false] = L["hidden"], [true] = L["shown"]},
						},
						group2 = {
							name = L["Group 2"],
							type = "toggle",
							desc = L["Toggle the display of Group 2"],
							get = function()
								return sRaidFrames.opt.GroupFilter[2]
							end,
							set = function(value)
								sRaidFrames.opt.GroupFilter[2] = value
								sRaidFrames:UpdateVisibility()
							end,
							map = {[false] = L["hidden"], [true] = L["shown"]},
						},
						group3 = {
							name = L["Group 3"],
							type = "toggle",
							desc = L["Toggle the display of Group 3"],
							get = function()
								return sRaidFrames.opt.GroupFilter[3]
							end,
							set = function(value)
								sRaidFrames.opt.GroupFilter[3] = value
								sRaidFrames:UpdateVisibility()
							end,
							map = {[false] = L["hidden"], [true] = L["shown"]},
						},
						group4 = {
							name = L["Group 4"],
							type = "toggle",
							desc = L["Toggle the display of Group 4"],
							get = function()
								return sRaidFrames.opt.GroupFilter[4]
							end,
							set = function(value)
								sRaidFrames.opt.GroupFilter[4] = value
								sRaidFrames:UpdateVisibility()
							end,
							map = {[false] = L["hidden"], [true] = L["shown"]},
						},
						group5 = {
							name = L["Group 5"],
							type = "toggle",
							desc = L["Toggle the display of Group 5"],
							get = function()
								return sRaidFrames.opt.GroupFilter[5]
							end,
							set = function(value)
								sRaidFrames.opt.GroupFilter[5] = value
								sRaidFrames:UpdateVisibility()
							end,
							map = {[false] = L["hidden"], [true] = L["shown"]},
						},
						group6 = {
							name = L["Group 6"],
							type = "toggle",
							desc = L["Toggle the display of Group 6"],
							get = function()
								return sRaidFrames.opt.GroupFilter[6]
							end,
							set = function(value)
								sRaidFrames.opt.GroupFilter[6] = value
								sRaidFrames:UpdateVisibility()
							end,
							map = {[false] = L["hidden"], [true] = L["shown"]},
						},
						group7 = {
							name = L["Group 7"],
							type = "toggle",
							desc = L["Toggle the display of Group 7"],
							get = function()
								return sRaidFrames.opt.GroupFilter[7]
							end,
							set = function(value)
								sRaidFrames.opt.GroupFilter[7] = value
								sRaidFrames:UpdateVisibility()
							end,
							map = {[false] = L["hidden"], [true] = L["shown"]},
						},
						group8 = {
							name = L["Group 8"],
							type = "toggle",
							desc = L["Toggle the display of Group 8"],
							get = function()
								return sRaidFrames.opt.GroupFilter[8]
							end,
							set = function(value)
								sRaidFrames.opt.GroupFilter[8] = value
								sRaidFrames:UpdateVisibility()
							end,
							map = {[false] = L["hidden"], [true] = L["shown"]},
						},
					},
				},
			},
		},

		growth = {
			name = L["Growth"],
			type = "text",
			desc = L["Set the growth of the raid frames"],
			get = function()
				return sRaidFrames.opt.Growth
			end,
			set = function(value)
				sRaidFrames:S("Growth", value)
				sRaidFrames:UpdateVisibility()
			end,
			validate = {["up"] = L["Up"], ["down"] = L["Down"], ["left"] = L["Left"], ["right"] = L["Right"]},
		},

		border = {
			name = L["Border"],
			type = "toggle",
			desc = L["Toggle the display of borders around the raid frames"],
			get = function()
				return sRaidFrames.opt.Border
			end,
			set = "chatToggleBorder",
		},

		spacing = {
			name = L["Frame Spacing"],
			type = "range",
			desc = L["Set the spacing between each of the raid frames"],
			min = -5,
			max = 5,
			step = 1,
			get = function()
				return sRaidFrames.opt.Spacing
			end,
			set = function(value)
				sRaidFrames:S("Spacing", value)
				sRaidFrames:Sort()
			end,
		},
	}
}

function sRaidFrames:chatUpdateBuffMenu()
	self.options.args.bufffilter.args["remove"] = {}
	self.options.args.bufffilter.args["remove"].type = 'group'
	self.options.args.bufffilter.args["remove"].name = 'Remove buff'
	self.options.args.bufffilter.args["remove"].desc = 'Remove buffs from the list'
	self.options.args.bufffilter.args["remove"].args = {}
	local i = 1
	for buff in pairs(self.opt.BuffFilter) do
		local buffName = buff -- Odd hack, don't know
		self.options.args.bufffilter.args["remove"].args["buff" .. i] = {}
		self.options.args.bufffilter.args["remove"].args["buff" .. i].type = 'execute'
		self.options.args.bufffilter.args["remove"].args["buff" .. i].name = buffName
		self.options.args.bufffilter.args["remove"].args["buff" .. i].desc = 'Remove '.. buffName .. ' from the buff list'
		self.options.args.bufffilter.args["remove"].args["buff" .. i].func = function() self.opt.BuffFilter[buffName] = nil self:chatUpdateBuffMenu()  end
		i = i + 1
	end
end

function sRaidFrames:chatSortBy(value)
	sRaidFrames:S("SortBy", value)
	sRaidFrames:Sort()
end

function sRaidFrames:chatBuffType(value)
	self:S("BuffType", value)

	self:UpdateBuffs(self.visible)
end

function sRaidFrames:chatToggleDispellable(value)
	self:S("ShowOnlyDispellable", value)

	self:UpdateBuffs(self.visible)
end

function sRaidFrames:chatTexture(t)
	self.opt.Texture = t

	for i = 1, MAX_RAID_MEMBERS do
		self.frames["raid" .. i].hpbar:SetStatusBarTexture(surface:Fetch(self.opt.Texture))
		self.frames["raid" .. i].mpbar:SetStatusBarTexture(surface:Fetch(self.opt.Texture))
	end
end

function sRaidFrames:chatScale(t)
	self:S("Scale", t)

	self.master:SetScale(t)
end

function sRaidFrames:chatBackgroundColor(r, g, b, a)
	self:S("BackgroundColor", {r = r, g = g, b = b, a = a})

	-- Need to do this, since someone might be debuffed, and so will need a diffirent background color
	self:UpdateBuffs(self.visible)
end

function sRaidFrames:chatBorderColor(r, g, b, a)
	self:S("BorderColor", {r = r, g = g, b = b, a = a})

	for k,f in pairs(self.frames) do
		f:SetBackdropBorderColor(r, g, b, a)
	end
end

function sRaidFrames:chatSetLayout(layout)
	self:PositionLayout(layout, self.groupframes[1]:GetLeft(), self.groupframes[1]:GetTop()-UIParent:GetTop())
end

function sRaidFrames:chatToggleBorder(value)
	self:S("Border", value)

	for k,f in pairs(self.frames) do
			self:SetBackdrop(f)
	end

	self:UpdateBuffs(self.visible)
end

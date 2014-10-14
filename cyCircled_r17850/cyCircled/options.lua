local L = AceLibrary("AceLocale-2.2"):new("cyCircled")

cyCircled.options = {
	type = "group",
	args = {
		elements = {
			name = L["Elements"], desc = L["elementsDesc"], type = "group", order = 1,
			args = {
			
			},
		},
		skins = {
			name = L["Skins"], desc = L["skinsDesc"], type = "text", order = 2,
			get = function() return cyCircled.db.profile.skin end,
			set = function(v)
				cyCircled.db.profile.skin = v
				cyCircled:ChangeSkin()
			end,
			validate = {},
		},
		colors = {
			name = L["Colors"], desc = L["ringcolorDesc"], type = "group", order = 3,
			args = {
				normal = {
					name = L["Normal"], desc = L["normalcolorDesc"], type = "color", order = 1,
					get = function()
						return cyCircled.db.profile.colors.normal.r, cyCircled.db.profile.colors.normal.g, cyCircled.db.profile.colors.normal.b
					end,
					set = function(r, g, b)
						cyCircled.db.profile.colors.normal.r, cyCircled.db.profile.colors.normal.g, cyCircled.db.profile.colors.normal.b = r, g, b
						cyCircled:ChangeColors()
					end,
				},
				hover = {
					name = L["Hover"], desc = L["hovercolorDesc"], type = "color", order = 2,
					get = function()
						return cyCircled.db.profile.colors.hover.r, cyCircled.db.profile.colors.hover.g, cyCircled.db.profile.colors.hover.b
					end,
					set = function(r, g, b)
						cyCircled.db.profile.colors.hover.r, cyCircled.db.profile.colors.hover.g, cyCircled.db.profile.colors.hover.b = r, g, b
						cyCircled:ChangeColors()
					end,
				},
				equipped = {
					name = L["Equipped"], desc = L["equipcolorDesc"], type = "color", order = 3,
					get = function()
						return cyCircled.db.profile.colors.equipped.r, cyCircled.db.profile.colors.equipped.g, cyCircled.db.profile.colors.equipped.b
					end,
					set = function(r, g, b)
						cyCircled.db.profile.colors.equipped.r, cyCircled.db.profile.colors.equipped.g, cyCircled.db.profile.colors.equipped.b = r, g, b
						cyCircled:ChangeColors()
					end,
				},
			},
		},
	},
}

for k,v in pairs(cyCircled.skins) do
	table.insert(cyCircled.options.args.skins.validate, k)
end

cyCircled:RegisterChatCommand({"/cycircled"}, cyCircled.options)
cyCircled.OnMenuRequest = cyCircled.options
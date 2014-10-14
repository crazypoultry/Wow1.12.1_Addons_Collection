--[[ $Id: RangeRecolor.lua 14603 2006-10-21 07:11:36Z hshh $ ]]--
-- ACE2 init
local L = AceLibrary("AceLocale-2.2"):new("RangeRecolor")
RangeRecolor = AceLibrary("AceAddon-2.0"):new("AceDB-2.0", "AceHook-2.1", "AceConsole-2.0")

function RangeRecolor:OnInitialize()
	--default style sets
	self.Styles = {
		gray	= { r = 0.4, g = 0.4, b = 0.4 },
		red		= { r = 0.8, g = 0.1, b = 0.1 },
		custom	= { r = 0.1, g = 0.3, b = 1.0 }
	}
	self.validateOptions = {}
	for k,_ in pairs(self.Styles) do
		tinsert(self.validateOptions, k)
	end

	-- register and init saved variables
	self:RegisterDB("RangeRecolorOptions")
	self:RegisterDefaults("profile", {
		style = "gray",
		custom = self.Styles.custom
	})

	--apply recolor style set
	self:ApplyStyle()

	-- register console slash commands
	self:RegisterChatCommand(
		{ "/rangerecolor", "/rr" },
		{
			type = "group",
			args = {
				style = {
					type = "text",
					name = "style",
					desc = L["style_desc"],
					usage = "<gray,red,custom>",
					validate = self.validateOptions,
					get = function() return self.db.profile.style end,
					set = function(style)
						self.db.profile.style = style
						self:ApplyStyle()
					end,
				},
				custom = {
					type = "text",
					name = "custom",
					desc = L["custom_desc"],
					usage = L["custom_usage"],
					get = function()
						local custom = self.db.profile.custom
						if (custom.r and custom.g and custom.b) then
							return "r="..custom.r.." g="..custom.g.." b="..custom.b
						end
					end,
					set = function(c)
						c = string.lower(c)
						local custom = {}
						for k,v in string.gfind(c, "([r|g|b])=([%d\.]+)") do
							custom[k]=v
						end
						if (custom.r and custom.g and custom.b) then
							self:ApplyStyle(custom)
						end
					end
				},
				reset = {
					type = "execute",
					name = "reset",
					desc = L["reset_desc"],
					func = function()
						self:ResetDB("profile")
						self:ApplyStyle()
						self:Print(L["MSG_RESETED"])
					end
				}
			}
		}
	)
end

function RangeRecolor:OnEnable()
	self:Hook("ActionButton_OnUpdate")
end

function RangeRecolor:ActionButton_OnUpdate(elapsed)
	local rangeChanged
	if ( IsActionInRange(ActionButton_GetPagedID(this)) == 0 ) then
		getglobal(this:GetName().."Icon"):SetVertexColor(self.color.r, self.color.g, self.color.b);
		getglobal(this:GetName().."NormalTexture"):SetVertexColor(self.color.r, self.color.g, self.color.b);
		rangeOut = 1
	else
		rangeOut = 0
	end
	self.hooks.ActionButton_OnUpdate(elapsed)
	if (this.rangeOut ~= rangeOut and rangeOut==0) then
		ActionButton_UpdateUsable()
	end
	this.rangeOut = rangeOut
end

function RangeRecolor:ApplyStyle(custom)
	local style = self.db.profile.style

	if type(self.Styles[style]) ~= "table" then
		style = "gray"
		self.db.profile.style = "gray"
	end

	if (type(custom)=="table" and custom.r and custom.g and custom.b) then
		self.db.profile.custom.r = custom.r
		self.db.profile.custom.g = custom.g
		self.db.profile.custom.b = custom.b
	end

	self.Styles.custom = self.db.profile.custom

	self.color = {
		r=self.Styles[style].r,
		g=self.Styles[style].g,
		b=self.Styles[style].b
	}
end

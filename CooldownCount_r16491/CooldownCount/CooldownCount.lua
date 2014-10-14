--[[ $Id: CooldownCount.lua 14691 2006-10-21 20:09:52Z damjau $ ]]--

local L = AceLibrary("AceLocale-2.2"):new("CooldownCount")
local CooldownFont = {
	["2002"] = "Fonts\\2002.TTF", 
	["FRIZQT__"] = "Fonts\\FRIZQT__.TTF", 
	["ARIALN"] = "Fonts\\ARIALN.TTF", 
	["K_Damage"] = "Fonts\\K_Damage.TTF", 
	["K_Pagetext"] = "Fonts\\K_Pagetext.TTF", 
}
CooldownCount = AceLibrary("AceAddon-2.0"):new("AceDB-2.0", "AceHook-2.1", "AceConsole-2.0")

function CooldownCount:OnInitialize()
	self:RegisterDB("CooldownCountDB")
	self:RegisterDefaults("profile", {
		shine = false,
		shineScale = 2,
		minimumDuration = 3,
		hideAnimation = false,
		font = L["FRIZQT__"],
		color1 = {r=1, g=1, b=0.2},
		color2 = {r=1, g=0, b=0},
		size = { [1] = 18, [2] = 24, [3] = 28, [4] = 34 }
	})
	self:RegisterChatCommand(
		{ "/cooldowncount", "/cc" },
		{
			type = "group",
			args = {
				reset = {
					type = "execute",
					name = L["reset"],
					desc = L["Reset all settings."],
					func = function()
						self:ResetDB("profile")
						self:Print(L["Reset to default settings."])
					end
				},
				shine = {
					type = "toggle",
					name = L["shine"],
					desc = L["Toggle icon shine display after finish cooldown."],
					get = function() return self.db.profile.shine end,
					set = function(t) self.db.profile.shine = t end
				},
				shinescale = {
					type = "range",
					name = L["shinescale"],
					desc = L["Adjust icon shine scale."],
					min = 0,
					max = 100,
					step = 0.1,
					get = function() return self.db.profile.shineScale end,
					set = function(r) self.db.profile.shineScale = r end
				},
				minimum_duration = {
					type = "range",
					name = L["minimum duration"],
					desc = L["Minimum duration for display cooldown count."],
					min = 0.5,
					max = 100,
					step = 0.5,
					get = function() return self.db.profile.minimumDuration end,
					set = function(r) self.db.profile.minimumDuration = r end
				},
				hide_animation = {
					type = "toggle",
					name = L["hide animation"],
					desc = L["Hide Bliz origin cooldown animation."],
					get = function() return self.db.profile.hideAnimation end,
					set = function(t) self.db.profile.hideAnimation = t end
				},
				font = {
					type = "text",
					name = L["font"],
					desc = L["Set cooldown value display font."],
					get = function() return self.db.profile.font end,
					set = function(f) self.db.profile.font = f end,
					validate =  {L["2002"], L["FRIZQT__"], L["ARIALN"], L["K_Damage"], L["K_Pagetext"], },
				},
				color1 = {
					type = "text",
					name = L["common color"],
					desc = L["Setup the common color for value display."],
					usage = "<r=n, g=n, b=n>",
					get = function()
						return "r="..self.db.profile.color1.r.." g="..self.db.profile.color1.g.." b="..self.db.profile.color1.b
					end,
					set = function(c)
						c = string.lower(c)
						local color = {}
						for k,v in string.gfind(c, "([r|g|b])=([%d\.]+)") do
							color[k]=v
						end
						if (color.r and color.g and color.b) then
							self.db.profile.color1={r=color.r, g=color.g, b=color.b}
						end
					end
				},
				color2 = {
					type = "text",
					name = L["warning color"],
					desc = L["Setup the warning color for value display."],
					usage = "<r=n, g=n, b=n>",
					get = function()
						return "r="..self.db.profile.color2.r.." g="..self.db.profile.color2.g.." b="..self.db.profile.color2.b
					end,
					set = function(c)
						c = string.lower(c)
						local color = {}
						for k,v in string.gfind(c, "([r|g|b])=([%d\.]+)") do
							color[k]=v
						end
						if (color.r and color.g and color.b) then
							self.db.profile.color2={r=color.r, g=color.g, b=color.b}
						end
					end
				},
				size = {
					type = "group",
					name = L["font size"],
					desc = L["Setup cooldown value display font size."],
					args = {
						small = {
							type = "range",
							name = L["small size"],
							desc = L["Small font size for cooldown is longer than 10 minutes."],
							min = 10,
							max = 45,
							step = 1,
							get = function() return self.db.profile.size[1] end,
							set = function(r) self.db.profile.size[1] = r end
						},
						medium = {
							type = "range",
							name = L["medium size"],
							desc = L["Medium font size for cooldown is longer than 1 minute and less than 10 minutes."],
							min = 10,
							max = 45,
							step = 1,
							get = function() return self.db.profile.size[2] end,
							set = function(r) self.db.profile.size[2] = r end
						},
						large = {
							type = "range",
							name = L["large size"],
							desc = L["Large font size for cooldown is longer than 10 seconds and less than 1 minutes."],
							min = 10,
							max = 45,
							step = 1,
							get = function() return self.db.profile.size[3] end,
							set = function(r) self.db.profile.size[3] = r end
						},
						warn = {
							type = "range",
							name = L["warning size"],
							desc = L["Warning font size for cooldown is less than 10 seconds."],
							min = 10,
							max = 45,
							step = 1,
							get = function() return self.db.profile.size[4] end,
							set = function(r) self.db.profile.size[4] = r end
						}
					}
				}
			}
		}
	)
end

function CooldownCount:OnEnable()
	self:Hook("CooldownFrame_SetTimer")
end

function CooldownCount:CooldownFrame_SetTimer(cooldownFrame, start, duration, enable)
	if not self.db.profile.hideAnimation then
		self.hooks.CooldownFrame_SetTimer(cooldownFrame, start, duration, enable)
	else
		cooldownFrame:Hide()
	end

	if start > 0 and duration > self.db.profile.minimumDuration and enable > 0 then
		local cooldownCount = cooldownFrame.textFrame or CooldownCount:CreateCooldownCount(cooldownFrame, start, duration)
		cooldownCount.start = start
		cooldownCount.duration = duration
		cooldownCount.timeToNextUpdate = 0
		cooldownCount:Show()
	elseif cooldownFrame.textFrame then
		cooldownFrame.textFrame:Hide()
	end
end

function CooldownCount:CreateCooldownCount(cooldown, start, duration)
	local textFrame = CreateFrame("Frame", nil, cooldown:GetParent())
	cooldown.textFrame = textFrame

	textFrame:SetAllPoints(cooldown:GetParent())
	textFrame:SetFrameLevel(cooldown.textFrame:GetFrameLevel() + 1)

	textFrame.text = cooldown.textFrame:CreateFontString(nil, "OVERLAY")
	textFrame.text:SetPoint("CENTER", cooldown.textFrame, "CENTER", 0, -1)

	textFrame.icon =
		--standard action button icon, $parentIcon
		getglobal(cooldown:GetParent():GetName() .. "Icon") or
		--standard item button icon,  $parentIconTexture
		getglobal(cooldown:GetParent():GetName() .. "IconTexture") or
		--discord action button, $parent_Icon
		getglobal(cooldown:GetParent():GetName() .. "_Icon")

	if textFrame.icon then
		textFrame:SetScript("OnUpdate", CooldownCount.Text_OnUpdate)
	end

	textFrame:Hide()

	return textFrame
end

function CooldownCount:Text_OnUpdate()
	if this.timeToNextUpdate <= 0 or not this.icon:IsVisible() then
		local remain = this.duration - (GetTime() - this.start)

		if floor(remain + 0.5) > 0 and this.icon:IsVisible() then
			local text, toNextUpdate, size, twoColor = CooldownCount:GetFormattedTime(remain)
			this.text:SetFont(CooldownFont[CooldownCount.db.profile.font], size, "OUTLINE")

			color = CooldownCount.db.profile.color1
			if twoColor then
				if this.twoColor then
					color = CooldownCount.db.profile.color2
					this.twoColor = nil
				else
					this.twoColor = true
				end
			end
			this.text:SetTextColor(color.r, color.g, color.b)

			this.text:SetText( text )
			this.timeToNextUpdate = toNextUpdate
		else
			if CooldownCount.db.profile.shine and this.icon:IsVisible() then
				CooldownCount:StartToShine(this);
			end
			this.twoColor = nil
			this:Hide()
		end
	else
		this.timeToNextUpdate = this.timeToNextUpdate - arg1
	end
end

function CooldownCount:GetFormattedTime(secs)
	-- return cc now value, next update value, font size, toggle two color
	if secs >= 86400 then
		return ceil(secs / 86400) .. L["d"], mod(secs, 86400), CooldownCount.db.profile.size[1]
	elseif secs >= 3600 then
		return ceil(secs / 3600) .. L["h"], mod(secs, 3600), CooldownCount.db.profile.size[1]
	elseif secs >= 600 then
		return ceil(secs / 60) .. L["m"], mod(secs, 60), CooldownCount.db.profile.size[1]
	elseif secs >= 60 then
		return ceil(secs / 60) .. L["m"], mod(secs, 60), CooldownCount.db.profile.size[2]
	elseif secs >= 10 then
		return floor(secs + 0.5), secs - floor(secs), CooldownCount.db.profile.size[3]
	end
	return floor(secs + 0.5), 0.5, CooldownCount.db.profile.size[4], true
end


--[[ Shine Codes ]]--
function CooldownCount:StartToShine(textFrame)
	local shineFrame = textFrame.shine or CooldownCount:CreateShineFrame(textFrame:GetParent())

	shineFrame.shine:SetAlpha(shineFrame:GetParent():GetAlpha())
	shineFrame.shine:SetHeight(shineFrame:GetHeight() * CooldownCount.db.profile.shineScale)
	shineFrame.shine:SetWidth(shineFrame:GetWidth() * CooldownCount.db.profile.shineScale)

	shineFrame:Show()
end

function CooldownCount:CreateShineFrame(parent)
	local shineFrame = CreateFrame("Frame", nil, parent)
	shineFrame:SetAllPoints(parent)

	local shine = shineFrame:CreateTexture(nil, "OVERLAY")
	shine:SetTexture("Interface\\Cooldown\\star4")
	shine:SetPoint("CENTER", shineFrame, "CENTER")
	shine:SetBlendMode("ADD")
	shineFrame.shine = shine

	shineFrame:Hide()
	shineFrame:SetScript("OnUpdate", CooldownCount.Shine_Update)
	shineFrame:SetAlpha(parent:GetAlpha())

	return shineFrame
end

function CooldownCount:Shine_Update()
	local shine = this.shine
	local alpha = shine:GetAlpha()
	shine:SetAlpha(alpha * 0.95)

	if alpha < 0.1 then
		this:Hide()
	else
		shine:SetHeight(alpha * this:GetHeight() * CooldownCount.db.profile.shineScale)
		shine:SetWidth(alpha * this:GetWidth() * CooldownCount.db.profile.shineScale)
	end
end

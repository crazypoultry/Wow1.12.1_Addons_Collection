--[[---------------------------------------------------------------------------------
  MyACEPercentage - Originally by Instant.  Upgraded to Ace2 (ManaPerc) by phyber
------------------------------------------------------------------------------------]]
ManaPerc = AceLibrary("AceAddon-2.0"):new("AceHook-2.1", "AceDB-2.0", "AceConsole-2.0")
ManaPerc:RegisterDB("ManaPercDB")
ManaPerc:RegisterDefaults('profile', {
	current = false,
	total = true,
	colour = true
})
local L = AceLibrary("AceLocale-2.2"):new("ManaPerc")

function ManaPerc:OnInitialize()
	local options = {
		desc = ManaPerc.notes,
		type = "group",
		args = {
			total = {
				name = "total",
				desc = L["TOTAL_DESC"],
				type = "toggle",
				get = function() return self.db.profile.total end,
				set = function(val) self.db.profile.total = val end,
			},
			current = {
				name = "current",
				desc = L["CURRENT_DESC"],
				type = "toggle",
				get = function() return self.db.profile.current end,
				set = function(val) self.db.profile.current = val end,
			},
			colour = {
				name = "colour",
				desc = L["COLOUR_DESC"],
				type = "toggle",
				get = function() return self.db.profile.colour end,
				set = function(val) self.db.profile.colour = val end,
			}
		}
	}
	ManaPerc:RegisterChatCommand(L["COMMANDS"], options)
end

--[[--------------------------------------------------------------------------------
  Addon Enabling/Disabling
-----------------------------------------------------------------------------------]]
function ManaPerc:OnEnable()
	self:HookScript(GameTooltip, "OnShow", "ProcessOnShow")
end

--[[--------------------------------------------------------------------------------
  Main Processing
-----------------------------------------------------------------------------------]]
function ManaPerc:ProcessOnShow()
	if GameTooltip:IsVisible() then
		local tipline2 = GameTooltipTextLeft2:GetText()
		if tipline2 and string.find(tipline2, MANA_COST) then
			local dttext, dctext = "", ""
			local line2cost = string.gsub(tipline2, string.gsub(MANA_COST, "%%d", ""), "")
			line2cost = tonumber(line2cost)
			if self.db.profile.total and line2cost then
				local ttext = string.format("%.1f", line2cost / (UnitManaMax('player') / 100))
				if self.db.profile.colour then
					dttext = "|cFFFFFF00("..ttext.."%)"			
				else
					dttext = "(t:"..ttext.."%)"
				end
			end
			if self.db.profile.current and line2cost then
				local ctext = string.format ("%.1f", line2cost / (UnitMana('player') / 100))
				if self.db.profile.colour then
					dctext = "|cFF00FF00("..ctext.."%)"
				else
					dctext = "(c:"..ctext.."%)"
				end
			end
			GameTooltipTextLeft2:SetText(string.format(MANA_COST, line2cost)..dctext..dttext)
		end
	end
end

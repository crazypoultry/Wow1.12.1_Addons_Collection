--[[
    NetStatsFu!

    Hollowed out version of MiniPerfsFu by Neronix
--]]

NetStatsFu = AceLibrary("AceAddon-2.0"):new("AceDB-2.0", "FuBarPlugin-2.0")

local tablet = AceLibrary("Tablet-2.0")
local dewdrop = AceLibrary("Dewdrop-2.0")
local crayon = AceLibrary("Crayon-2.0")
local gnome = AceLibrary("Metrognome-2.0")
local L = AceLibrary("AceLocale-2.2"):new("FuBar_NetStatsFu")
L:RegisterTranslations("enUS", function()
	return {
		["Session Totals"] = true,
		["Toggle bandwidth session totals."] = true,
		["Latency:"] = true,
		["Down:"] = true,
		["Up:"] = true
	}
end)

NetStatsFu:RegisterDB("NetStatsFuDB")
NetStatsFu:RegisterDefaults('profile', {
	showSessionTotals = true
})
NetStatsFu.hasIcon = true

local down, up, latency, str
local sDn, sUp = 0, 0

function NetStatsFu:OnInitialize()
	gnome:RegisterMetro(self.name, self.Update, 1, self)

	local options = {
		type = "group",
		args = {
			sessiontotals = {
				name = L["Session Totals"],
				desc = L["Toggle bandwidth session totals."],
				type = "toggle",
				get = function() return self.db.profile.showSessionTotals end,
				set = function(val)
					self.db.profile.showSessionTotals = val
					self:Update()
				end,
			}
		}
	}
	NetStatsFu.OnMenuRequest = options
end

function NetStatsFu:OnEnable()
	timeSinceLastUpdate = 0
	justEntered = true
    
	gnome:StartMetro(self.name)
end

function NetStatsFu:OnDisable()
	gnome:UnregisterMetro(self.name)
end

function NetStatsFu:OnDataUpdate()
	--if not latency then NetStatsFu:OnEnable() end -- FBP2 wants to run OnDataUpdate BEFORE OnInit/Enable >.>
    
	down, up, latency = GetNetStats()
	sDn = sDn + down
	sUp = sUp + up
	str = string.format("|cff%s%d|r ms", crayon:GetThresholdHexColor(latency, 1000, 500, 250, 100, 0), latency)
end


function NetStatsFu:OnTextUpdate()
	self:SetText(str)
end

function NetStatsFu:OnTooltipUpdate()
	local cat = tablet:AddCategory(
		'columns', 2,
		'child_textR', 1,
		'child_textG', 1,
		'child_textB', 0
	)

	local r, g, b = crayon:GetThresholdColor(latency, 1000, 500, 250, 100, 0)
	cat:AddLine(
		'text', L["Latency:"],
		'text2', string.format("%.1f ms", latency),
		'text2R', r,
		'text2G', g,
		'text2B', b
	)

	cat:AddLine(
		'text', L["Down:"],
		'text2', string.format("%.2f KiB/s", down),
		'text2R', 1,
		'text2G', 1,
		'text2B', 1
	)

	cat:AddLine(
		'text', L["Up:"],
		'text2', string.format("%.2f KiB/s", up),
		'text2R', 1,
		'text2G', 1,
		'text2B', 1
	)

	if self.db.profile.showSessionTotals then
		cat = tablet:AddCategory(
			'text', L["Session Totals"],
			'columns', 2,
			'child_textR', 1,
			'child_textG', 1,
			'child_textB', 0
		)
		
		cat:AddLine(
			'text', L["Down:"],
			'text2', string.format("%.2f KB", sDn),
			'text2R', 1,
			'text2G', 1,
			'text2B', 1
		)

		cat:AddLine(
			'text', L["Up:"],
			'text2', string.format("%.2f KB", sUp),
			'text2R', 1,
			'text2G', 1,
			'text2B', 1
		)
	end
end	

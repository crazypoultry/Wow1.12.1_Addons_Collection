BT2HunterBars = Bartender:NewModule("hunterbars")

local L = AceLibrary("AceLocale-2.2"):new("BT2HunterBars")

L:RegisterTranslations("enUS", function() return {
	["Auto Shot"]="Auto Shot",
} end)

L:RegisterTranslations("deDE", function() return {
	["Auto Shot"]="Automatischer Schuss",
} end)

L:RegisterTranslations("frFR", function() return {
	["Auto Shot"]="Tir automatique",
} end)

local _, playerclass = UnitClass("player")
if playerclass ~= "HUNTER" then
	DisableAddOn("Bartender2_HunterBars")
	return
end

function BT2HunterBars:OnInitialize()
	self.db = Bartender:AcquireDBNamespace('HunterBars')
	Bartender:RegisterDefaults('HunterBars', 'profile', {
		page = 7
	})
	Bartender.options.args.hunter = {
		name = "Hunter Bars",
		desc = "Config for Hunter Bars",
		type = "group",
		args = {
			page = {
				name = "Page",
				desc = "Page to switch main bar to while out of range for Auto-Shot",
				type = "range",
				min = 2, max = 10, step = 1,
				get = function() return self.db.profile.page end,
				set = function(v) self.db.profile.page = v end
			}
		}
	}
	CreateFrame("GameTooltip", "BT2HunterBarsTooltip", UIParent, "GameTooltipTemplate")
	BT2HunterBarsTooltip:SetOwner(UIParent, "ANCHOR_NONE")
end

function BT2HunterBars:OnEnable()
	for id = 1, 120 do
		if HasAction(id) then
			BT2HunterBarsTooltip:SetOwner(UIParent, "ANCHOR_NONE")
			BT2HunterBarsTooltip:SetAction(id)
			if BT2HunterBarsTooltipTextLeft1:GetText() == L["Auto Shot"] then
				self.AutoShotId = id
				break
			end
		end
   	end
	self:ScheduleRepeatingEvent("BT2HB", self.UpdateBars, 0.2, self)
end

function BT2HunterBars:UpdateBars()
	if UnitExists("target") and UnitCanAttack("player", "target") and self.AutoShotId then
		if IsActionInRange(self.AutoShotId) == 0 and CheckInteractDistance("target", 2) and not self.InMelee then
			self:ChangePage(self.db.profile.page)
			self.InMelee = true
		elseif self.InMelee and IsActionInRange(self.AutoShotId) == 1 then
			self.InMelee = false
			self:ChangePage(1)
		end
	elseif self.InMelee then
		self:ChangePage(1)
		self.InMelee = false
	end
end

function BT2HunterBars:ChangePage(num)
	if num and CURRENT_ACTIONBAR_PAGE ~= num then
		CURRENT_ACTIONBAR_PAGE = num
		ChangeActionBarPage()
	end
end

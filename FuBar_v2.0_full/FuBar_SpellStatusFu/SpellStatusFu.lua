local compost = AceLibrary("Compost-2.0")
local tablet = AceLibrary("Tablet-2.0")
local dewdrop = AceLibrary("Dewdrop-2.0")
local abacus = AceLibrary("Abacus-2.0")
local spellstatus = AceLibrary("SpellStatus-1.0")

SpellStatusFu = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "FuBarPlugin-2.0", "AceDB-2.0")

SpellStatusFu.hasIcon = true

SpellStatusFu:RegisterDB("SpellStatusFuDB")

SpellStatusFu:RegisterDefaults(
	"profile", 
	{
	}
)

local L = SpellStatusFuLocals

SpellStatusFu.options = {
    type = "group",
    handler = SpellStatusFu,
    args = 
    {
    },
}

function SpellStatusFu:OnInitialize()
end

function SpellStatusFu:OnEnable()
    self:ScheduleRepeatingEvent("SpellStatusFu_Update", self.Update, 0.1, self)
end

function SpellStatusFu:OnDisable()
    self:CancelScheduledEvent("SpellStatusFu_Update")
end

function SpellStatusFu:OnMenuRequest()
    dewdrop:FeedAceOptionsTable(self.options)
end


local function AddTooltipCategory()
    return tablet:AddCategory(
		'columns', 2,
		'child_textR', 1,
		'child_textG', 1,
		'child_textB', 0,
		'child_text2R', 1,
		'child_text2G', 1,
		'child_text2B', 1
    )
end

local function AddTooltipLine(category, caption, value)
    category:AddLine(
		'text', caption .. ":",
		'text2', value
    )
end

local function AddLocaleTooltipLine(category, locale, value)
	AddTooltipLine(category, L[locale], value)
end

local function AddBooleanTooltipLine(category, locale, value)
	AddTooltipLine(category, locale, value and "|cff00ff00"..L["true"].."|r" or "|cffff0000"..L["false"].."|r")
end

function SpellStatusFu:OnTooltipUpdate()
	local combating = spellstatus:IsCombating()
	local attacking = spellstatus:IsAttacking()
	local autoRepeating = spellstatus:IsAutoRepeating()
	local wanding = spellstatus:IsWanding()

    local category = AddTooltipCategory()

	AddBooleanTooltipLine(category, "Combating", combating)
	AddBooleanTooltipLine(category, "Attacking", attacking)
	AddBooleanTooltipLine(category, "Auto Repeating", autoRepeating)
	AddBooleanTooltipLine(category, "Wanding", wanding)

	local using = spellstatus:IsUsing()
	local preparing = spellstatus:IsPreparing()
	local casting = spellstatus:IsCasting()
	local channeling = spellstatus:IsChanneling()
	local nextMeleeing = spellstatus:IsNextMeleeing()
	
    category = AddTooltipCategory()

	AddBooleanTooltipLine(category, "Using", using)
	AddBooleanTooltipLine(category, "Preparing", preparing)
	AddBooleanTooltipLine(category, "Casting", casting)
	AddBooleanTooltipLine(category, "Channeling", channeling)
	AddBooleanTooltipLine(category, "Next Meleeing", nextMeleeing)

	local activeId, activeName, activeRank, activeFullName,
			activeCastStartTime, activeCastStopTime, activeCastDuration,
			activeAction = spellstatus:GetActiveSpellData()
    category = AddTooltipCategory()

	AddTooltipLine(category, "Active Id", activeId)
	AddTooltipLine(category, "Active Name", activeName)
	AddTooltipLine(category, "Active Rank", activeRank)
	AddTooltipLine(category, "Active Full Name", activeFullName)

	local nextMeleeId, nextMeleeName, 
			nextMeleeRank, nextMeleeFullName = spellstatus:GetNextMeleeSpellData()
    category = AddTooltipCategory()

	AddTooltipLine(category, "Next Melee Id", nextMeleeId)
	AddTooltipLine(category, "Next Melee Name", nextMeleeName)
	AddTooltipLine(category, "Next Melee Rank", nextMeleeRank)
	AddTooltipLine(category, "Next Melee Full Name", nextMeleeFullName)
end

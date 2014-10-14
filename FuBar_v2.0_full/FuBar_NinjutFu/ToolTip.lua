local L = AceLibrary("AceLocale-2.2"):new("NinjutFu")
local tablet = AceLibrary("Tablet-2.0")
local crayon = AceLibrary("Crayon-2.0")

function NinjutFu:OnTooltipUpdate()
	local cat = tablet:AddCategory(
		'columns', 2,
		'child_textR', 1,
		'child_textG', 1,
		'child_textB', 1,
		'child_textR2', 1,
		'child_textG2', 1,
		'child_textB2', 1
	)

	if (self.db.profile.showTipPowders) then
		if (self.db.profile.showTipTitles) then
			cat:AddLine('text', crayon:Green(L["Powders"]))
		end
		cat:AddLine('text', L["Flash Powder"], 'text2', self:Colorize(self.itemCounts[L["Flash Powder"]], self.db.profile.threshCount))
		cat:AddLine('text', L["Blinding Powder"], 'text2', self:Colorize(self.itemCounts[L["Blinding Powder"]], 20))
	end
	if (self.db.profile.showTipTea) then
		cat:AddLine()
		cat:AddLine('text', L["Thistle Tea"], 'text2', self:Colorize(self.itemCounts[L["Thistle Tea"]], 10))
	end
	if (self.db.profile.showTipPoisons) then
		cat:AddLine()
		if (self.db.profile.showTipTitles) then
			cat:AddLine('text', crayon:Green(L["Poisons"]))
		end
		self:TTRow(cat, L["Crippling Poison"])
		self:TTRow(cat, L["Crippling Poison II"])
		self:TTRow(cat, L["Deadly Poison"])
		self:TTRow(cat, L["Deadly Poison II"])
		self:TTRow(cat, L["Deadly Poison III"])
		self:TTRow(cat, L["Deadly Poison IV"])
		self:TTRow(cat, L["Deadly Poison V"])
		self:TTRow(cat, L["Instant Poison"])
		self:TTRow(cat, L["Instant Poison II"])
		self:TTRow(cat, L["Instant Poison III"])
		self:TTRow(cat, L["Instant Poison IV"])
		self:TTRow(cat, L["Instant Poison V"])
		self:TTRow(cat, L["Instant Poison VI"])
		self:TTRow(cat, L["Mind-numbing Poison"])
		self:TTRow(cat, L["Mind-numbing Poison II"])
		self:TTRow(cat, L["Mind-numbing Poison III"])
		self:TTRow(cat, L["Wound Poison"])
		self:TTRow(cat, L["Wound Poison II"])
		self:TTRow(cat, L["Wound Poison III"])
		self:TTRow(cat, L["Wound Poison IV"])
	end

	tablet:SetHint(L["Hint"])
	-- as a rule, if you have an OnClick or OnDoubleClick or OnMouseUp or OnMouseDown, you should set a hint.
end

function NinjutFu:TTRow(cat, poison)
	if (self.itemCounts[poison] and self.itemCounts[poison] > 0) then
		cat:AddLine('text', poison, 'text2', self:Colorize(self.itemCounts[poison], 20))
	end
end
GCInFu = AceLibrary("AceAddon-2.0"):new("FuBarPlugin-2.0", "AceDB-2.0")

GCInFu.clickableTooltip = true

GCInFu:RegisterDB("GCInFuDB")
GCInFu:RegisterDefaults("profile", {
	Type = 3,
})

function GCInFu:OnInitialize()
	self.tablet = AceLibrary("Tablet-2.0")
	self.gnome = AceLibrary("Metrognome-2.0")
	self.gnome:RegisterMetro("GCInFu", self.Update, 1, self)
end

function GCInFu:OnEnable()
	self.gnome:StartMetro("GCInFu")
end

function GCInFu:OnDisable()
	self.gnome:StopMetro("GCInFu")
end

function GCInFu:OnDataUpdate()
	self.previousMem = self.currentMem
	self.currentMem, self.gcThreshold = gcinfo()
end

function GCInFu:OnTextUpdate()
	if self.previousMem then
		if self.db.profile.Type == 1 then
			self.str = string.format("Cur: [%.1fMB]", self.currentMem/1024)
		elseif self.db.profile.Type == 2 then
			self.str = string.format("TH: [%.1fMB]", self.gcThreshold/1024)
		elseif self.db.profile.Type == 3 then
			self.str = string.format("Inc: [%.1fKB/s]", self.currentMem - self.previousMem)
		end
		self:SetText(self.str)
	end
end

function GCInFu:OnTooltipUpdate()
	self.tablet:SetTitle("GCInFu")
	self.tablet:SetHint("Shift+Ctrl-Click to force garbage collection.\nHint: Click tooltip to select visible InFu.")
	local cat = self.tablet:AddCategory("columns", 2)

	cat:AddLine(
		"text", "Current",
		"text2", string.format("%.1fMB", self.currentMem/1024),
		"text2R", 1,
		"text2G", 1,
		"text2B", 1,
		"func", function() self.db.profile.Type = 1 end
	)
	cat:AddLine(
		"text", "Threshold",
		"text2", string.format("%.1fMB", self.gcThreshold/1024),
		"text2R", 1,
		"text2G", 1,
		"text2B", 1,
		"func", function() self.db.profile.Type = 2 end
	)
	cat:AddLine(
		"text", "Increase",
		"text2", string.format("%.1fKB/s", self.currentMem - self.previousMem),
		"text2R", 1,
		"text2G", 1,
		"text2B", 1,
		"func", function() self.db.profile.Type = 3 end
	)
end

function GCInFu:OnClick()
	if ((IsControlKeyDown() and IsShiftKeyDown()) and arg1 == "LeftButton") then
		collectgarbage()
	end
end

-------------------------------------------------------------------------------
-- Locals                                                                    --
-------------------------------------------------------------------------------

local L = AceLibrary("AceLocale-2.2"):new("ClosetGnomeBigWigs")
local queuedSet = nil

-------------------------------------------------------------------------------
-- Localization                                                              --
-------------------------------------------------------------------------------

L:RegisterTranslations("enUS", function() return {
	["BigWigs module %s enabled, equipping set %s."] = true,
	["ClosetGnome - BigWigs"] = true,
	["Makes your ClosetGnome aware of the various boss monsters in this dangerous world."] = true,

	["%s has been enabled. Do you want to equip %s?\n\nYou can disable this confirmation dialog to autoequip with /cgbw confirm."] = true,
	["Equip"] = true,
	["Cancel"] = true,

	["Alias"] = true,
	["Alias a BigWigs bossmod to an existing set."] = true,
	["<boss> <set>"] = true,
	["ListAliases"] = true,
	["List aliases"] = true,
	["List the current aliases."] = true,
	["Confirm"] = true,
	["Confirm Autoequip"] = true,
	["Open a confirmation dialog before autoequipping a boss set."] = true,

	["%s aliased to %s."] = true,
	["%s: %s."] = true,
	["%d aliases registered."] = true,
} end)

-------------------------------------------------------------------------------
-- Addon declaration                                                         --
-------------------------------------------------------------------------------

ClosetGnomeBigWigs = AceLibrary("AceAddon-2.0"):new("AceConsole-2.0", "AceDB-2.0", "AceEvent-2.0")
ClosetGnomeBigWigs:RegisterDB("ClosetGnomeBigWigsDB", "ClosetGnomeBigWigsPCDB")
ClosetGnomeBigWigs:RegisterDefaults("profile", {
	enabled = true,
	confirmEquip = true,
})
ClosetGnomeBigWigs:RegisterDefaults("char", {
	alias = {},
})

ClosetGnomeBigWigs:RegisterChatCommand({"/cgbw"}, {
	type = "group",
	name = L["ClosetGnome - BigWigs"],
	desc = L["Makes your ClosetGnome aware of the various boss monsters in this dangerous world."],
	args = {
		[L["Alias"]] = {
			type = "text",
			name = L["Alias"],
			desc = L["Alias a BigWigs bossmod to an existing set."],
			get = false,
			set = function(v) ClosetGnomeBigWigs:AddAlias(v) end,
			usage = L["<boss> <set>"],
		},
		[L["ListAliases"]] = {
			type = "execute",
			name = L["List aliases"],
			desc = L["List the current aliases."],
			func = function() ClosetGnomeBigWigs:ListAliases() end,
		},
		[L["Confirm"]] = {
			type = "toggle",
			name = L["Confirm Autoequip"],
			desc = L["Open a confirmation dialog before autoequipping a boss set."],
			get = function() return ClosetGnomeBigWigs.db.profile.confirmEquip end,
			set = function(v) ClosetGnomeBigWigs.db.profile.confirmEquip = v end,
		},
	},
})
-------------------------------------------------------------------------------
-- Initialization                                                            --
-------------------------------------------------------------------------------

function ClosetGnomeBigWigs:OnEnable()
	if not ClosetGnome or not BigWigs then return end
	self:RegisterEvent("BigWigs_RecvSync")

	StaticPopupDialogs["ClosetGnomeBigWigsConfirm"] = {
		text = L["%s has been enabled. Do you want to equip %s?\n\nYou can disable this confirmation dialog to autoequip with /cgbw confirm."],
		button1 = L["Equip"],
		button2 = L["Cancel"],
		sound = "levelup2",
		whileDead = 0,
		hideOnEscape = 1,
		timeout = 0,
		OnAccept = function()
			ClosetGnome:WearSet(queuedSet)
		end,
	}
end

-------------------------------------------------------------------------------
-- Command handlers                                                          --
-------------------------------------------------------------------------------

function ClosetGnomeBigWigs:ListAliases()
	local frame = DEFAULT_CHAT_FRAME
	local counter = 0
	for k, v in pairs(self.db.char.alias) do
		frame:AddMessage(string.format(L["%s: %s."], k, v))
		counter = counter + 1
	end
	frame:AddMessage(string.format(L["%d aliases registered."], counter))
end

function ClosetGnomeBigWigs:AddAlias(alias)
	local _, _, boss, set = string.find(alias, "(.*) (.*)")
	if boss and set then
		self.db.char.alias[boss] = set
	end
	ClosetGnome:Print(string.format(L["%s aliased to %s."], boss, set))
end

-------------------------------------------------------------------------------
-- Events                                                                    --
-------------------------------------------------------------------------------

function ClosetGnomeBigWigs:BigWigs_RecvSync(sync, rest, nick)
	if not BigWigs or sync ~= "EnableModule" or not rest or not self.db.profile.enabled then return end

	if not BigWigs:HasModule(rest) then return end
	local m = BigWigs:GetModule(rest)
	if not m or m.zonename ~= GetRealZoneText() or not m:IsBossModule() then return end

	local strippedBoss = string.gsub(m:ToString(), " ", "")
	local setName = strippedBoss
	if self.db.char.alias[strippedBoss] then
		setName = self.db.char.alias[strippedBoss]
	end

	if ClosetGnome:HasSet(setName) and not ClosetGnome:IsSetFullyEquipped(setName) then
		if self.db.profile.confirmEquip then
			queuedSet = setName
			StaticPopup_Show("ClosetGnomeBigWigsConfirm", "|cffd9d919"..m:ToString().."|r", "|cffd9d919"..setName.."|r")
		else
			self:Print(string.format(L["BigWigs module %s enabled, equipping set %s."], m:ToString(), setName))
			ClosetGnome:WearSet(setName)
		end
	end
end


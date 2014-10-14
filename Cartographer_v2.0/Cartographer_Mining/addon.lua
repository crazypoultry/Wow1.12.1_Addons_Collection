local bs = AceLibrary("Babble-Spell-2.2")
local AceAddon = AceLibrary("AceAddon-2.0")
local Tablet = AceLibrary("Tablet-2.0")

local L = AceLibrary("AceLocale-2.2"):new("Cartographer_Mining")
L:RegisterTranslations("enUS", function() return {
	["Requires Mining"] = true,

	["Filter"] = true,
	["Filter out minerals"] = true,
	
	["Select all"] = true,
	["Select none"] = true,

	["Vein"] = true,
	["Deposit"] = true,

	["Copper"] = true,
	["Tin"] = true,
	["Iron"] = true,
	["Silver"] = true,
	["Gold"] = true,
	["Mithril"] = true,
	["Truesilver"] = true,
	["Thorium"] = true,
	["Small Thorium"] = true,
	["Rich Thorium"] = true,
	["Dark Iron"] = true,
	["Fel Iron"] = true,
	["Adamantite"] = true,
	["Rich Adamantite"] = true,
	["Khorium"] = true,
} end)

L:RegisterTranslations("deDE", function() return {
	["Requires Mining"] = "Ben\195\182tigt Bergbau",

	["Filter"] = "Filter",
	["Filter out minerals"] = "Filtere Mineralien",
	
  ["Select all"] = "Alle ausw\195\164hlen",
  ["Select none"] = "Nichts aus\195\164hlen",

	["Vein"] = "Ader", 
	["Deposit"] = "vorkommen", 

	["Copper"] = "Kupfer",
	["Tin"] = "Zinn",
	["Iron"] = "Eisen",
	["Silver"] = "Silber",
	["Gold"] = "Gold",
	["Mithril"] = "Mithril",
	["Truesilver"] = "Echtsilber",
	["Thorium"] = "Thorium",
	["Small Thorium"] = "Kleines Thorium", --check
	["Rich Thorium"] = "Reiches Thorium", -- check
	["Dark Iron"] = "Dunkeleisen",
	["Fel Iron"] = "Teufelseisen", -- check
	["Adamantite"] = "Adamantium", --check
	["Rich Adamantite"] = "Reiches Adamantium", -- check
	["Khorium"] = "Khorium", --check 
} end)

L:RegisterTranslations("koKR", function() return {
	["Requires Mining"] = "채광 필요",

	["Filter"] = "필터링",
	["Filter out minerals"] = "광맥에 따라서 지도에 표시 여부를 선택합니다.",

	["Select all"] = "모두 선택",
	["Select none"] = "선택 해제",

	["Vein"] = "광석",
	["Deposit"] = "광맥",

	["Copper"] = "구리",
	["Tin"] = "주석",
	["Iron"] = "철",
	["Silver"] = "은",
	["Gold"] = "금",
	["Mithril"] = "미스릴",
	["Truesilver"] = "진은",
	["Thorium"] = "토륨",
	["Small Thorium"] = "작은 토륨",
	["Rich Thorium"] = "풍부한 토륨",
	["Dark Iron"] = "검은무쇠",
    ["Fel Iron"] = "지옥무쇠",
	["Adamantite"] = "아다만타이트",
	["Rich Adamantite"] = "풍부한 아다만타이트",
	["Khorium"] = "코륨",
} end)

local mod = Cartographer:NewModule(bs["Mining"], "AceConsole-2.0", "AceEvent-2.0")

mod.icon = {
	["Copper"] = {
		text = L["Copper"],
		path = "Interface\\Icons\\INV_Ore_Copper_01",
		width = 12,
		height = 12
	},
	["Tin"] = {
		text = L["Tin"],
		path = "Interface\\Icons\\INV_Ore_Tin_01",
		width = 12,
		height = 12
	},
	["Silver"] = {
		text = L["Silver"],
		path = "Interface\\Icons\\INV_Stone_16",
		width = 12,
		height = 12
	},
	["Iron"] = {
		text = L["Iron"],
		path = "Interface\\Icons\\INV_Ore_Iron_01",
		width = 12,
		height = 12
	},
	["Gold"] = {
		text = L["Gold"],
		path = "Interface\\Icons\\INV_Ore_Copper_01",
		width = 12,
		height = 12
	},
	["Mithril"] = {
		text = L["Mithril"],
		path = "Interface\\Icons\\INV_Ore_Mithril_02",
		width = 12,
		height = 12
	},
	["Truesilver"] = {
		text = L["Truesilver"],
		path = "Interface\\Icons\\INV_Ore_TrueSilver_01",
		width = 12,
		height = 12
	},
	["Small Thorium"] = {
		text = L["Small Thorium"],
		path = "Interface\\Icons\\INV_Ore_Thorium_02",
		width = 12,
		height = 12
	},
	["Thorium"] = {
		text = L["Thorium"],
		path = "Interface\\Icons\\INV_Ore_Thorium_02",
		width = 12,
		height = 12
	},
	["Rich Thorium"] = {
		text = L["Rich Thorium"],
		path = "Interface\\Icons\\INV_Ore_Thorium_02",
		width = 12,
		height = 12
	},
	["Dark Iron"] = {
		text = L["Dark Iron"],
		path = "Interface\\Icons\\INV_Ore_Mithril_01",
		width = 12,
		height = 12
	},
	["Fel Iron"] = {
    text = L["Fel Iron"],
    path = "Interface\\Icons\\INV_Ore_FelIron",
    width = 12,
    height = 12
  },
  ["Adamantite"] = {
    text = L["Adamantite"],
    path = "Interface\\Icons\\INV_Ore_Adamantium",
    width = 12,
    height = 12
  },
  ["Rich Adamantite"] = {
    text = L["Rich Adamantite"],
    path = "Interface\\Icons\\INV_Ore_Adamantium_01",
    width = 12,
    height = 12
  },
  ["Khorium"] = {
    text = L["Khorium"],
    path = "Interface\\Icons\\INV_Ore_Khorium",
    width = 12,
    height = 12
  }, 
}

local lua51
function mod:OnInitialize()
	self.db = Cartographer:AcquireDBNamespace("Mining")
	Cartographer:RegisterDefaults("Mining", "profile", {
		filter = {
			['*'] = true,
		}
	})

	local aceopts = {}
	aceopts.toggle = {
		name = AceLibrary("AceLocale-2.2"):new("Cartographer")["Active"],
		desc = AceLibrary("AceLocale-2.2"):new("Cartographer")["Suspend/resume this module."],
		type  = 'toggle',
		order = -1,
		get   = function() return Cartographer:IsModuleActive(self) end,
		set   = function() Cartographer:ToggleModuleActive(self) end,
	}

	aceopts.filter = {
		name = L["Filter"],
		desc = L["Filter out minerals"],
		type = 'group',
		args = {
			all = {
				name = L["Select all"],
				desc = L["Select all"],
				type = 'execute',
				func = function()
					for k in pairs(self.icon) do
						self:ToggleShowingMineral(k, true)
					end
				end,
				order = 1,
			},
			none = {
				name = L["Select none"],
				desc = L["Select none"],
				type = 'execute',
				func = function()
					for k in pairs(self.icon) do
						self:ToggleShowingMineral(k, false)
					end
				end,
				order = 2,
			},
			blank = {
				type = 'header',
				order = 3,
			}
		}
	}
	for k,v in pairs(self.icon) do
		local k = k
		aceopts.filter.args[string.gsub(k, "%s", "-")] = {
			name = v.text,
			desc = v.text,
			type = 'toggle',
			get = function()
				return self:IsShowingMineral(k)
			end,
			set = function(value)
				return self:ToggleShowingMineral(k, value)
			end,
		}
	end

	Cartographer.options.args[bs["Mining"]] = {
		name = bs["Mining"],
		desc = self.notes,
		type = 'group',
		args = aceopts,
		handler = self,
	}
	Cartographer:GetModule('Professions').addons[bs["Mining"]] = self
	AceLibrary("AceConsole-2.0"):InjectAceOptionsTable(self, Cartographer.options.args[bs["Mining"]])

	if not Cartographer_MiningDB then
		Cartographer_MiningDB = {}
	else
		for _, zone in pairs(Cartographer_MiningDB) do
			for id, data in pairs(zone) do
				if type(data) == "table" then
					zone[id] = data.icon
				end
			end
		end
	end

	lua51 = loadstring("return function(...) return ... end") and true or false
end

function mod:OnEnable()
	if Cartographer_Notes then
		if not self.iconsregistered then
			for k,v in pairs(self.icon) do
				Cartographer_Notes:RegisterIcon(k, v)
			end
			self.iconsregistered = true
		end

		Cartographer_Notes:RegisterNotesDatabase('Mining', Cartographer_MiningDB, self)
	else
		Cartographer:ToggleModuleActive(self, false)
	end

	self:RegisterEvent("UI_ERROR_MESSAGE")

	if lua51 then
		self:RegisterEvent("CHAT_MSG_SPELL_SELF_BUFF")
	else
		self:RegisterEvent("SPELLCAST_START")
	end
end

function mod:OnDisable()
	self:UnregisterAllEvents()

	if Cartographer_Notes then
		Cartographer_Notes:UnregisterNotesDatabase('Mining')
	end
end

function mod:SetNote(what)
	local x, y = GetPlayerMapPosition("player")
	if x == 0 and y == 0 then return end
	local zone = GetRealZoneText()
	Cartographer_Notes:SetNote(zone, x, y, L:GetReverseTranslation(what), "Mining")
end

function mod:OnNoteTooltipRequest(zone, id)
	local icon = Cartographer_MiningDB[zone][id]
	
	Tablet:SetTitle(L[icon])
	Tablet:SetTitleColor(0, 0.8, 0)
	
	Tablet:AddCategory(
		'columns', 2,
		'hideBlankLine', true
	):AddLine(
		'text', AceLibrary("AceLocale-2.2"):new("Cartographer-Notes")["Created by"],
		'text2', bs["Mining"]
	)
end

function mod:RegisterOre(what)
	if what and strlen(what) > 0 then
		if string.find(what, L["Dark Iron"]) then
			self:SetNote(L["Dark Iron"])
		elseif string.find(what, L["Rich Thorium"]) then
			self:SetNote(L["Rich Thorium"])
		elseif string.find(what, L["Small Thorium"] ) then
			self:SetNote(L["Small Thorium"])
		elseif string.find(what, L["Rich Adamantite"] ) then
			self:SetNote(L["Rich Adamantite"])
		elseif string.find(what, L["Fel Iron"] ) then
			self:SetNote(L["Fel Iron"])
		else
			local w = string.gsub(what, " %(%d+%)", "")
			if w then
				what = w
			end
			local _, _, ore, veindep = string.find(what, "([^ ]+) ([^ ]+)$")
			if ore and veindep and veindep == L["Vein"] or veindep == L["Deposit"] then
				self:SetNote(ore)
			end
		end
	end
end

local perform_string = '^' .. string.gsub(string.gsub(string.format(SIMPLEPERFORMSELFOTHER, bs["Mining"], "%s"), "([%(%)%.%*%+%-%[%]%?%^%$%%])", "%%%1"), "%%%%s", "(.+)") .. '$'
function mod:CHAT_MSG_SPELL_SELF_BUFF(msg)
	local _,_,what = string.find(msg, perform_string)
	if what then
		self:RegisterOre(what)
	end
end

function mod:UI_ERROR_MESSAGE(msg)
	-- if string.find(msg, UNIT_SKINNABLE_ROCK) then -- TBC only
	if string.find(msg, L["Requires Mining"]) then
		self:RegisterOre(GameTooltipTextLeft1:GetText())
	end
end

function mod:SPELLCAST_START(msg)
	if msg == bs["Mining"] then
		self:RegisterOre(GameTooltipTextLeft1:GetText())
	end
end

function mod:IsNoteHidden(zone, id)
	return not self.db.profile.filter[Cartographer_MiningDB[zone][id]]
end

function mod:IsShowingMineral(mineral)
	return self.db.profile.filter[mineral]
end

function mod:ToggleShowingMineral(mineral, value)
	if value == nil then
		value = not self.db.profile.filter[mineral]
	end
	self.db.profile.filter[mineral] = value

	self:ScheduleEvent("CartographerMining_RefreshMap", Cartographer_Notes.RefreshMap, 0, Cartographer_Notes)
end

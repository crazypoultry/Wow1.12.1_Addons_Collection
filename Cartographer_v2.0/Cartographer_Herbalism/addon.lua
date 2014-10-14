local bs = AceLibrary("Babble-Spell-2.2")
local AceAddon = AceLibrary("AceAddon-2.0")
local Tablet = AceLibrary("Tablet-2.0")
local Deformat = AceLibrary("Deformat-2.0")

local L = AceLibrary("AceLocale-2.2"):new("Cartographer_Herbalism")
L:RegisterTranslations("enUS", function() return {
    ["Requires Herbalism"] = true,
    
    ["Filter"] = true,
    ["Filter out herbs"] = true,
    
    ["Select all"] = true,
    ["Select none"] = true,

    -- herbs
    ["Silverleaf"] = true,
    ["Peacebloom"] = true,
    ["Mageroyal"] = true,
    ["Bruiseweed"] = true,
    ["Kingsblood"] = true,
    ["Fadeleaf"] = true,
    ["Stranglekelp"] = true,
    ["Liferoot"] = true,
    ["Briarthorn"] = true,
    ["Earthroot"] = true,
    ["Sungrass"] = true,
    ["Blindweed"] = true,
    ["Gromsblood"] = true,
    ["Dreamfoil"] = true,
    ["Firebloom"] = true,
    ["Arthas' Tears"] = true,
    ["Purple Lotus"] = true,
    ["Goldthorn"] = true,
    ["Wildvine"] = true,
    ["Grave Moss"] = true,
    ["Mountain Silversage"] = true,
    ["Black Lotus"] = true,
    ["Ghost Mushroom"] = true,
    ["Golden Sansam"] = true,
    ["Icecap"] = true,
    ["Khadgar's Whisker"] = true,
    ["Plaguebloom"] = true,
    ["Swiftthistle"] = true,
    ["Wild Steelbloom"] = true,
    ["Wintersbite"] = true,
    -- tbc
	  ["Felweed"] = true,
	  ["Blood Thistle"] = true,
	  ["Mana Thistle"] = true,
	  ["Netherbloom"] = true,
	  ["Nightmare Vine"] = true,
	  ["Ragveil"] = true,
	  ["Terocone"] = true,
	  ["Flame Cap"] = true,
	  ["Dreaming Glory"] = true,
	  ["Fel Lotus"] = true,
	  ["Ancient Lichen"] = true,
} end)

L:RegisterTranslations("deDE", function() return {
    ["Requires Herbalism"] = "Ben\195\182tigt Kr\195\164uterkunde",
    
    ["Filter"] = "Filter",
    ["Filter out herbs"] = "Filtere Kräuter",
    
    ["Select all"] = "Alle auswählen",
    ["Select none"] = "Nichts auswählen",

    -- herbs
    ["Silverleaf"] = "Silberblatt",
    ["Peacebloom"] = "Friedensblume",
    ["Mageroyal"] = "Maguskönigskraut", 
    ["Bruiseweed"] = "Beulengras", 
    ["Kingsblood"] = "Königsblut",
    ["Fadeleaf"] = "Blassblatt",
    ["Stranglekelp"] = "Würgetang",
    ["Liferoot"] = "Lebenswurzel",
    ["Briarthorn"] = "Wilddornrose", 
    ["Earthroot"] = "Erdwurzel",
    ["Sungrass"] = "Sonnengras",
    ["Blindweed"] = "Blindkraut", 
    ["Gromsblood"] = "Gromsblut",
    ["Dreamfoil"] = "Traumblatt",
    ["Firebloom"] = "Feuerblüte",
    ["Arthas' Tears"] = "Arthas' Tränen", --check
    ["Purple Lotus"] = "Lila Lotus",
    ["Goldthorn"] = "Golddorn",
    ["Wildvine"] = "Wildranke",
    ["Grave Moss"] = "Grabmoos",
    ["Mountain Silversage"] = "Bergsilberweisling",
    ["Black Lotus"] = "Schwarzer Lotus",
    ["Ghost Mushroom"] = "Geisterpilz",
    ["Golden Sansam"] = "Goldener Sansam",
    ["Icecap"] = "Eiskappe",
    ["Khadgar's Whisker"] = "	Khadgars Schnurrbart",
    ["Plaguebloom"] = "Pestblüte",
    ["Swiftthistle"] = "Flitzdistel",
    ["Wild Steelbloom"] = "Wildstahlblume",
    ["Wintersbite"] = "Winterbiss",
    -- tbc
	  ["Felweed"] = "Teufelskraut",--check
	  ["Blood Thistle"] = "Blutdistel",--check
	  ["Mana Thistle"] = "Manadistel",--check
	  ["Netherbloom"] = "Netherblüte", --check
	  ["Nightmare Vine"] = "Albtraumranke", --check
	  ["Ragveil"] = "Ragveil", --check
	  ["Terocone"] = "Terocone", --check
	  ["Flame Cap"] = "Flammenkappe", --check
	  ["Dreaming Glory"] = "Dreaming Glory",
	  ["Fel Lotus"] = "Teufelslotus", -- check
	  ["Ancient Lichen"] = "Ancient Lichen", --check
} end)

L:RegisterTranslations("frFR", function() return {
    ["Requires Herbalism"] = "Requiert Herboristerie",
    
    ["Filter"] = "Filtrer",
    ["Filter out herbs"] = "Filtrer les plantes",
    
    ["Select all"] = "S\195\169lectinner toutes",
    ["Select none"] = "S\195\169lectinner aucune",

    -- herbs
    ["Silverleaf"] = "Feuillargent",
    ["Peacebloom"] = "Pacifique",
    ["Mageroyal"] = "Mage royal",
    ["Bruiseweed"] = "Doulourante",
    ["Kingsblood"] = "Sang-royal",
    ["Fadeleaf"] = "P\195\162lerette",
    ["Stranglekelp"] = "Etouffante",
    ["Liferoot"] = "Viet\195\169rule",
    ["Briarthorn"] = "Eglantine",
    ["Earthroot"] = "Terrestrine",
    ["Sungrass"] = "Soleillette",
    ["Blindweed"] = "Aveuglette",
    ["Gromsblood"] = "Gromsang",
    ["Dreamfoil"] = "Feuiller\195\170ve",
    ["Firebloom"] = "Fleur de feu",
    ["Arthas' Tears"] = "Larmes d'arthas",
    ["Purple Lotus"] = "Lotus pourpre",
    ["Goldthorn"] = "Dor\195\169pine",
    ["Wildvine"] = "Sauvageonne",
    ["Grave Moss"] = "Tombeline",
    ["Mountain Silversage"] = "Sauge\-argent des montagnes",
    ["Black Lotus"] = "Lotus noir",
    ["Ghost Mushroom"] = "Champignon fant\195\180me",
    ["Golden Sansam"] = "Sansam dor\195\169",
    ["Icecap"] = "Calot de glace",
    ["Khadgar's Whisker"] = "Moustache de khadgar",
    ["Plaguebloom"] = "Fleur de peste",
    ["Swiftthistle"] = "Chardonnier",
    ["Wild Steelbloom"] = "Aci\195\169rite sauvage",
    ["Wintersbite"] = "Hivernale",
    -- tbc
--	  ["Felweed"] = true,
--	  ["Blood Thistle"] = true,
--	  ["Mana Thistle"] = true,
--	  ["Netherbloom"] = true,
--	  ["Nightmare Vine"] = true,
--	  ["Ragveil"] = true,
--	  ["Terocone"] = true,
--	  ["Flame Cap"] = true,
--	  ["Dreaming Glory"] = true,
--	  ["Fel Lotus"] = true,
--	  ["Ancient Lichen"] = true,
} end)

L:RegisterTranslations("koKR", function() return {
    ["Requires Herbalism"] = "약초채집 필요",
    
    ["Filter"] = "필터링",
    ["Filter out herbs"] = "약초에 따라서 지도에 표시 여부를 선택합니다",

    ["Select all"] = "모두 선택",
    ["Select none"] = "선택 해제",

    -- herbs
    ["Silverleaf"] = "은엽수 덤불",
    ["Peacebloom"] = "평온초",
    ["Mageroyal"] = "마법초",
    ["Bruiseweed"] = "생채기풀",
    ["Kingsblood"] = "왕꽃잎풀",
    ["Fadeleaf"] = "미명초",
    ["Stranglekelp"] = "갈래물풀",
    ["Liferoot"] = "생명의 뿌리",
    ["Briarthorn"] = "찔레가시",
    ["Earthroot"] = "뱀뿌리",
    ["Sungrass"] = "태양풀",
    ["Blindweed"] = "실명초",
    ["Gromsblood"] = "그롬의 피",
    ["Dreamfoil"] = "꿈풀",
    ["Firebloom"] = "화염초",
    ["Arthas' Tears"] = "아서스의 눈물",
    ["Purple Lotus"] = "보라 연꽃",
    ["Goldthorn"] = "황금가시",
    ["Wildvine"] = "야생덩굴",
    ["Grave Moss"] = "무덤이끼",
    ["Mountain Silversage"] = "은초롱이",
    ["Black Lotus"] = "검은 연꽃",
    ["Ghost Mushroom"] = "유령버섯",
    ["Golden Sansam"] = "황금 산삼",
    ["Icecap"] = "얼음송이",
    ["Khadgar's Whisker"] = "카드가의 수염",
    ["Plaguebloom"] = "역병초",
    ["Swiftthistle"] = "토끼엉겅퀴풀",
    ["Wild Steelbloom"] = "야생 철쭉",
    ["Wintersbite"] = "겨울서리풀",
    ["Felweed"] = "지옥풀",
} end)

local mod = Cartographer:NewModule("Herbalism", "AceConsole-2.0", "AceEvent-2.0")

mod.icon = {
    ["Black Lotus"] = {
        text = L["Black Lotus"],
        path = "Interface\\Icons\\INV_Misc_Herb_BlackLotus",
        width = 12,
        height = 12
    },
    ["Blindweed"] = {
        text = L["Blindweed"],
        path = "Interface\\Icons\\INV_Misc_Herb_14",
        width = 12,
        height = 12
    },
    ["Briarthorn"] = {
        text = L["Briarthorn"],
        path = "Interface\\Icons\\INV_Misc_Root_01",
        width = 12,
        height = 12
    },
    ["Bruiseweed"] = {
        text = L["Bruiseweed"],
        path = "Interface\\Icons\\INV_Misc_Herb_01",
        width = 12,
        height = 12
    },
    ["Dreamfoil"] = {
        text = L["Dreamfoil"],
        path = "Interface\\Icons\\INV_Misc_Herb_DreamFoil",
        width = 12,
        height = 12
    },
    ["Earthroot"] = {
        text = L["Earthroot"],
        path = "Interface\\Icons\\INV_Misc_Herb_07",
        width = 12,
        height = 12
    },
    ["Fadeleaf"] = {
        text = L["Fadeleaf"],
        path = "Interface\\Icons\\INV_Misc_Herb_12",
        width = 12,
        height = 12
    },
    ["Felweed"] = {
        text = L["Felweed"],
        path = "Interface\\Icons\\INV_Misc_Herb_Felweed",
        width = 12,
        height = 12
    },
    ["Firebloom"] = {
        text = L["Firebloom"],
        path = "Interface\\Icons\\INV_Misc_Herb_19",
        width = 12,
        height = 12
    },
    ["Goldthorn"] = {
        text = L["Goldthorn"],
        path = "Interface\\Icons\\INV_Misc_Herb_15",
        width = 12,
        height = 12
    },
    ["Grave Moss"] = {
        text = L["Grave Moss"],
        path = "Interface\\Icons\\INV_Misc_Dust_02",
        width = 12,
        height = 12
    },
    ["Gromsblood"] = {
        text = L["Gromsblood"],
        path = "Interface\\Icons\\INV_Misc_Herb_16",
        width = 12,
        height = 12
    },
    ["Icecap"] = {
        text = L["Icecap"],
        path = "Interface\\Icons\\INV_Misc_Herb_IceCap",
        width = 12,
        height = 12
    },
    ["Kingsblood"] = {
        text = L["Kingsblood"],
        path = "Interface\\Icons\\INV_Misc_Herb_03",
        width = 12,
        height = 12
    },
    ["Liferoot"] = {
        text = L["Liferoot"],
        path = "Interface\\Icons\\INV_Misc_Root_02",
        width = 12,
        height = 12
    },
    ["Mageroyal"] = {
        text = L["Mageroyal"],
        path = "Interface\\Icons\\INV_Jewelry_Talisman_03",
        width = 12,
        height = 12
    },
    ["Peacebloom"] = {
        text = L["Peacebloom"],
        path = "Interface\\Icons\\INV_Misc_Flower_02",
        width = 12,
        height = 12
    },
    ["Plaguebloom"] = {
        text = L["Plaguebloom"],
        path = "Interface\\Icons\\INV_Misc_Herb_PlagueBloom",
        width = 12,
        height = 12
    },
    ["Silverleaf"] = {
        text = L["Silverleaf"],
        path = "Interface\\Icons\\INV_Misc_Herb_10",
        width = 12,
        height = 12
    },
    ["Stranglekelp"] = {
        text = L["Stranglekelp"],
        path = "Interface\\Icons\\INV_Misc_Herb_11",
        width = 12,
        height = 12
    },
    ["Sungrass"] = {
        text = L["Sungrass"],
        path = "Interface\\Icons\\INV_Misc_Herb_18",
        width = 12,
        height = 12
    },
    ["Swiftthistle"] = {
        text = L["Swiftthistle"],
        path = "Interface\\Icons\\INV_Misc_Herb_04",
        width = 12,
        height = 12
    },
    ["Wildvine"] = {
        text = L["Wildvine"],
        path = "Interface\\Icons\\INV_Misc_Herb_03",
        width = 12,
        height = 12
    },
    ["Wintersbite"] = {
        text = L["Wintersbite"],
        path = "Interface\\Icons\\INV_Misc_Flower_03",
        width = 12,
        height = 12
    },
    ["Arthas' Tears"] = {
        text = L["Arthas' Tears"],
        path = "Interface\\Icons\\INV_Misc_Herb_13",
        width = 12,
        height = 12
    },
    ["Ghost Mushroom"] = {
        text = L["Ghost Mushroom"],
        path = "Interface\\Icons\\INV_Mushroom_08",
        width = 12,
        height = 12
    },
    ["Golden Sansam"] = {
        text = L["Golden Sansam"],
        path = "Interface\\Icons\\INV_Misc_Herb_SansamRoot",
        width = 12,
        height = 12
    },
    ["Khadgar's Whisker"] = {
        text = L["Khadgar's Whisker"],
        path = "Interface\\Icons\\INV_Misc_Herb_08",
        width = 12,
        height = 12
    },
    ["Mountain Silversage"] = {
        text = L["Mountain Silversage"],
        path = "Interface\\Icons\\INV_Misc_Herb_MountainSilverSage",
        width = 12,
        height = 12
    },
    ["Purple Lotus"] = {
        text = L["Purple Lotus"],
        path = "Interface\\Icons\\INV_Misc_Herb_17",
        width = 12,
        height = 12
    },
    ["Wild Steelbloom"] = {
        text = L["Wild Steelbloom"],
        path = "Interface\\Icons\\INV_Misc_Flower_01",
        width = 12,
        height = 12
    },
    ["Felweed"] = {
        text = L["Felweed"],
        path = "Interface\\Icons\\INV_Misc_Herb_Felweed",
        width = 12,
        height = 12
    },
    ["Blood Thistle"] = {
        text = L["Blood Thistle"],
        path = "Interface\\Icons\\INV_Misc_Herb_Nightmareseed", --placeholder
        width = 12,
        height = 12
    },
    ["Mana Thistle"] = {
        text = L["Mana Thistle"],
        path = "Interface\\Icons\\INV_Misc_Herb_Manathistle",
        width = 12,
        height = 12
    },
    ["Netherbloom"] = {
        text = L["Netherbloom"],
        path = "Interface\\Icons\\INV_Misc_Herb_Netherbloom",
        width = 12,
        height = 12
    },
    ["Nightmare Vine"] = {
        text = L["Nightmare Vine"],
        path = "Interface\\Icons\\INV_Misc_Herb_Nightmarevine",
        width = 12,
        height = 12
    },
    ["Ragveil"] = {
        text = L["Ragveil"],
        path = "Interface\\Icons\\INV_Misc_Herb_Ragveil",
        width = 12,
        height = 12
    },
    ["Terocone"] = {
        text = L["Terocone"],
        path = "Interface\\Icons\\INV_Misc_Herb_Terrocone",
        width = 12,
        height = 12
    },
    ["Flame Cap"] = {
        text = L["Flame Cap"],
        path = "Interface\\Icons\\INV_Misc_Herb_Flamecap",
        width = 12,
        height = 12
    },
    ["Dreaming Glory"] = {
        text = L["Dreaming Glory"],
        path = "Interface\\Icons\\INV_Misc_Herb_Dreamingglory",
        width = 12,
        height = 12
    },
    ["Fel Lotus"] = {
        text = L["Fel Lotus"],
        path = "Interface\\Icons\\INV_Misc_Herb_FelLotus",
        width = 12,
        height = 12
    },
   	["Ancient Lichen"] = {
        text = L["Ancient Lichen"],
        path = "Interface\\Icons\INV_Misc_Herb_AncientLichen", --placeholder
        width = 12,
        height = 12
    },
}

local lua51 = loadstring("return function(...) return ... end") and true or false
function mod:OnInitialize()
	self.db = Cartographer:AcquireDBNamespace("Herbalism")
    Cartographer:RegisterDefaults("Herbalism", "profile", {
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
		desc = L["Filter out herbs"],
		type = 'group',
		args = {
			all = {
				name = L["Select all"],
				desc = L["Select all"],
				type = 'execute',
				func = function()
					for k in pairs(self.icon) do
						self:ToggleShowingHerb(k, true)
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
						self:ToggleShowingHerb(k, false)
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
				return self:IsShowingHerb(k)
			end,
			set = function(value)
				return self:ToggleShowingHerb(k, value)
			end,
		}
    end

    Cartographer.options.args[gsub(bs["Herbalism"], " ", "")] = {
        name = bs["Herbalism"],
        desc = self.notes,
        type = 'group',
        args = aceopts,
        handler = self,
    }
    AceLibrary("AceConsole-2.0"):InjectAceOptionsTable(self, Cartographer.options.args[gsub(bs["Herbalism"], " ", "")])
    Cartographer:GetModule('Professions').addons[bs["Herbalism"]] = self

    if not Cartographer_HerbalismDB then
        Cartographer_HerbalismDB = {}
    else
		for _, zone in pairs(Cartographer_HerbalismDB) do
			for id, data in pairs(zone) do
				if type(data) == "table" then
					zone[id] = data.icon
				end
			end
		end
    end
end

function mod:OnEnable()
    if Cartographer_Notes then
        if not self.iconsregistered then
            for k,v in pairs(self.icon) do
                Cartographer_Notes:RegisterIcon(k, v)
            end
            self.iconsregistered = true
        end

        Cartographer_Notes:RegisterNotesDatabase('Herbalism', Cartographer_HerbalismDB, self)
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
        Cartographer_Notes:UnregisterNotesDatabase('Herbalism')
    end
end

function mod:SetNote(what)
    local x, y = GetPlayerMapPosition("player")
    if x == 0 and y == 0 then return end
    local zone = GetRealZoneText()
    local _,_,w = string.find(what, "^(.-) %(%d+%)$")
    if w then
		what = w
	end
    Cartographer_Notes:SetNote(zone, x, y, L:GetReverseTranslation(what), "Herbalism")
end

function mod:OnNoteTooltipRequest(zone, id)
	local icon = Cartographer_HerbalismDB[zone][id]
	
	Tablet:SetTitle(L[icon])
	Tablet:SetTitleColor(0, 0.8, 0)
	
	Tablet:AddCategory(
		'columns', 2,
		'hideBlankLine', true
	):AddLine(
		'text', AceLibrary("AceLocale-2.2"):new("Cartographer-Notes")["Created by"],
		'text2', bs["Herbalism"]
	)
end

local perform_string = '^' .. string.gsub(string.gsub(string.format(SIMPLEPERFORMSELFOTHER, bs["Herb Gathering"], "%s"), "([%(%)%.%*%+%-%[%]%?%^%$%%])", "%%%1"), "%%%%s", "(.+)") .. '$'
function mod:CHAT_MSG_SPELL_SELF_BUFF(msg)
    local _,_,what = string.find(msg, perform_string)
    if what then
        self:SetNote(what)
    end
end

function mod:UI_ERROR_MESSAGE(msg)
    -- if string.find(msg, UNIT_SKINNABLE_HERB) then -- TBC only
    if string.find(msg, L["Requires Herbalism"]) then
        local what = GameTooltipTextLeft1:GetText()
        if what and strlen(what) > 0 then
            self:SetNote(what)
        end
    end
end

function mod:SPELLCAST_START(msg)
    if msg == bs["Herb Gathering"] then
        local what = GameTooltipTextLeft1:GetText()
        if what and strlen(what) > 0 then
            self:SetNote(what)
        end
    end
end

function mod:IsNoteHidden(zone, id)
	return not self.db.profile.filter[Cartographer_HerbalismDB[zone][id]]
end

function mod:IsShowingHerb(herb)
	return self.db.profile.filter[herb]
end

function mod:ToggleShowingHerb(herb, value)
	if value == nil then
		value = not self.db.profile.filter[herb]
	end
	self.db.profile.filter[herb] = value
	
	self:ScheduleEvent("CartographerHerbalism_RefreshMap", Cartographer_Notes.RefreshMap, 0, Cartographer_Notes)
end

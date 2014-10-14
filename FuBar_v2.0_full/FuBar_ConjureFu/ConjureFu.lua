local Tablet = AceLibrary("Tablet-2.0")
local L = AceLibrary("AceLocale-2.2"):new("ConjureFu")
local p = "Interface\\Icons\\"
local reagentTexture = { [1] = p.."INV_Misc_Dust_01", [2] = p.."INV_Misc_Rune_06", [3] = p.."INV_Misc_Rune_08" }
local waterTexture = { [1] = p.."INV_Drink_06", [2] = p.."INV_Drink_07", [3] = p.."INV_Drink_Milk_02", [4] = p.."INV_Drink_10", [5] = p.."INV_Drink_09", [6] = p.."INV_Drink_11", [7] = p.."INV_Drink_18" }
local foodTexture = { [1] = p.."INV_Misc_Food_10", [2] = p.."INV_Misc_Food_09", [3] = p.."INV_Misc_Food_12", [4] = p.."INV_Misc_Food_08", [5] = p.."INV_Misc_Food_11", [6] = p.."INV_Misc_Food_33", [7] = p.."INV_Misc_Food_73CinnamonRoll" }
local gemTexture = { [1] = p.."INV_Misc_Gem_Emerald_01", [2] = p.."INV_Misc_Gem_Emerald_02", [3] = p.."INV_Misc_Gem_Opal_01", [4] = p.."INV_Misc_Gem_Ruby_01" }
local hearthTexture = p.."INV_Misc_Rune_01"
local gemRankNames = { [1] = L['GEM_RANK1'], [2] = L['GEM_RANK2'], [3] = L['GEM_RANK3'], [4] = L['GEM_RANK4'] }

BINDING_HEADER_CONJUREFU = L["BINDING_HEADER_CONJUREFU"]
BINDING_NAME_CONJURE_WATER = L["BINDING_NAME_CONJURE_WATER"]
BINDING_NAME_CONJURE_FOOD = L["BINDING_NAME_CONJURE_FOOD"]
BINDING_NAME_CONJURE_GEM = L["BINDING_NAME_CONJURE_GEM"]
BINDING_NAME_CONSUME_WATER = L["BINDING_NAME_CONSUME_WATER"]
BINDING_NAME_CONSUME_FOOD = L["BINDING_NAME_CONSUME_FOOD"]
BINDING_NAME_CONSUME_GEM = L["BINDING_NAME_CONSUME_GEM"]

ConjureFu = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceConsole-2.0", "AceDB-2.0", "FuBarPlugin-2.0")
ConjureFu:RegisterDB("ConjureFuDB")
ConjureFu:RegisterDefaults('profile', {
	waterRank = 7,
	foodRank = 7,
	gemRank = 4,
	powderStacks = 0,
	teleportStacks = 0,
	portalStacks = 0,
})

function ConjureFu:OnEnable()
	self:RegisterEvent("BAG_UPDATE")
	self:RegisterEvent("MERCHANT_SHOW")
end

function ConjureFu:BAG_UPDATE()
	self:OnTextUpdate()
end

function ConjureFu:MERCHANT_SHOW()
	self:AutoBuy()
end

function ConjureFu:OnTextUpdate()
	waterCount = self:ItemCount(waterTexture[self.db.profile.waterRank])
	foodCount = self:ItemCount(foodTexture[self.db.profile.foodRank])
	gemCount = 0;
	for i=1,4 do
		gemCount = gemCount + self:ItemCount(gemTexture[i])
	end
	powderCount = self:ItemCount(reagentTexture[1])
	teleportCount = self:ItemCount(reagentTexture[2])
	portalCount = self:ItemCount(reagentTexture[3])
	self:SetText(waterCount.." | "..foodCount.." | "..gemCount)
end

function ConjureFu:OnClick()
	if IsShiftKeyDown() then
		self:Conjure("food")
	elseif IsControlKeyDown() then
		self:Conjure("gem")
	else
		self:Conjure("water")
	end
end

function ConjureFu:Conjure(item)
	if item=="water" then
		CastSpellByName(string.format(L['SPELL_CONJURE_WATER'], self.db.profile.waterRank))
	elseif item=="food" then
		CastSpellByName(string.format(L['SPELL_CONJURE_FOOD'], self.db.profile.foodRank))
	elseif item=="gem" then
		local r = 0
		while r<self.db.profile.gemRank do
			if self:ItemCount(gemTexture[self.db.profile.gemRank-r])==0 then
				CastSpellByName(string.format(L['SPELL_CONJURE_GEM'], gemRankNames[self.db.profile.gemRank-r]))
				break
			end
			r = r+1
		end
	end
end

function ConjureFu:Consume(item)
	if item=="water" and self:ItemFind(waterTexture[self.db.profile.waterRank]) then
		UseContainerItem(self:ItemFind(waterTexture[self.db.profile.waterRank]))
	elseif item=="food" and self:ItemFind(foodTexture[self.db.profile.foodRank]) then
		UseContainerItem(self:ItemFind(foodTexture[self.db.profile.foodRank]))
	elseif item=="gem" then
		local r = 0
		while r<self.db.profile.gemRank do
			if self:ItemFind(gemTexture[self.db.profile.gemRank-r]) then
				UseContainerItem(self:ItemFind(gemTexture[self.db.profile.gemRank-r]))
				break
			end
			r = r+1
		end
	elseif self:ItemFind(item) then
		UseContainerItem(self:ItemFind(item))
	end
end

function ConjureFu:Teleport(location)
	CastSpellByName(string.format(L['SPELL_TELEPORT'], location))
end

function ConjureFu:Portal(location)
	CastSpellByName(string.format(L['SPELL_PORTAL'], location))
end

function ConjureFu:AutoBuy()
	for i=1,GetMerchantNumItems() do
		if GetMerchantItemInfo(i)==L['ARCANE_POWDER'] and  self.db.profile.powderStacks*20>powderCount then
			BuyMerchantItem(i, self.db.profile.powderStacks*20-powderCount)
		end
		if GetMerchantItemInfo(i)==L['RUNE_OF_TELEPORTATION'] and self.db.profile.teleportStacks*10>teleportCount then
			BuyMerchantItem(i, self.db.profile.teleportStacks*10-teleportCount)
		end
		if GetMerchantItemInfo(i)==L['RUNE_OF_PORTALS'] and self.db.profile.portalStacks*10>portalCount then
			BuyMerchantItem(i, self.db.profile.portalStacks*10-portalCount)
		end
	end
end

function ConjureFu:ItemCount(itemTexture)
	local count=0
	for i=0,4 do
		for j=1,GetContainerNumSlots(i) do
			local texture, itemCount, locked, quality, readable = GetContainerItemInfo(i, j);
			if texture==itemTexture and quality==-1 then
				count=count+itemCount
			end
		end
	end
	return count;
end

function ConjureFu:ItemFind(itemTexture)
	for i=0,4 do
		for j=1,GetContainerNumSlots(i) do
			local texture, itemCount, locked, quality, readable = GetContainerItemInfo(i, j);
			if texture==itemTexture then
				return i, j
			end
		end
	end
	return false;
end

local options = {
	handler = ConjureFu,
	type = 'group',
	args = {
		conjure = {
			type = 'group',
			name = L['GROUP_CONJURE_NAME'],
			desc = L['GROUP_CONJURE_DESC'],
			order = 1,
			args = {
				water = {
					type = 'execute',
					name = L['OPT_CONJURE_WATER_NAME'],
					desc = L['OPT_CONJURE_WATER_DESC'],
					func = function() ConjureFu:Conjure("water") end,
					order = 1,
				},
				food = {
					type = 'execute',
					name = L['OPT_CONJURE_FOOD_NAME'],
					desc = L['OPT_CONJURE_FOOD_DESC'],
					func = function() ConjureFu:Conjure("food") end,
					order = 2,
				},
				gem = {
					type = 'execute',
					name = L['OPT_CONJURE_GEM_NAME'],
					desc = L['OPT_CONJURE_GEM_DESC'],
					func = function() ConjureFu:Conjure("gem") end,
					order = 3,
				},
			},
		},
		consume = {
			type = 'group',
			name = L['GROUP_CONSUME_NAME'],
			desc = L['GROUP_CONSUME_DESC'],
			order = 2,
			args = {
				water = {
					type = 'execute',
					name = L['OPT_CONSUME_WATER_NAME'],
					desc = L['OPT_CONSUME_WATER_DESC'],
					func = function() ConjureFu:Consume("water") end,
					order = 1,
				},
				food = {
					type = 'execute',
					name = L['OPT_CONSUME_FOOD_NAME'],
					desc = L['OPT_CONSUME_FOOD_DESC'],
					func = function() ConjureFu:Consume("food") end,
					order = 2,
				},
				gem = {
					type = 'execute',
					name = L['OPT_CONSUME_GEM_NAME'],
					desc = L['OPT_CONSUME_GEM_DESC'],
					func = function() ConjureFu:Consume("gem") end,
					order = 3,
				},
			},
		},
		rank = {
			type = 'group',
			name = L['GROUP_RANK_NAME'],
			desc = L['GROUP_RANK_DESC'],
			order = 3,
			args = {
				water = {
					type = 'range',
					name = L['OPT_RANK_WATER_NAME'],
					desc = L['OPT_RANK_WATER_DESC'],
					get = function() return ConjureFu.db.profile.waterRank end,
					set = function(rank) ConjureFu.db.profile.waterRank = rank; ConjureFu:OnTextUpdate(); end,
					min = 1,
					max = 7,
					step = 1,
     					order = 1,
				},
				food = {
					type = 'range',
					name = L['OPT_RANK_FOOD_NAME'],
					desc = L['OPT_RANK_FOOD_DESC'],
					get = function() return ConjureFu.db.profile.foodRank end,
					set = function(rank) ConjureFu.db.profile.foodRank = rank; ConjureFu:OnTextUpdate(); end,
					min = 1,
					max = 7,
					step = 1,
     					order = 2,
				},
				gem = {
					type = 'range',
					name = L['OPT_RANK_GEM_NAME'],
					desc = L['OPT_RANK_GEM_DESC'],
					get = function() return ConjureFu.db.profile.gemRank end,
					set = function(rank) ConjureFu.db.profile.gemRank = rank; ConjureFu:OnTextUpdate(); end,
					min = 1,
					max = 4,
					step = 1,
 		    			order = 3,
				},
			},
		},
		teleport = {
			type = 'group',
			name = L['GROUP_TELEPORT_NAME'],
			desc = L['GROUP_TELEPORT_DESC'],
			order = 4,
			args = {
				ironforge = {
					type = 'execute',
					name = L['OPT_TELEPORT_IRONFORGE_NAME'],
					desc = L['OPT_TELEPORT_IRONFORGE_DESC'],
					func = function() ConjureFu:Teleport(L['IRONFORGE']) end,
					order = 1,
				},
				stormwind = {
					type = 'execute',
					name = L['OPT_TELEPORT_STORMWIND_NAME'],
					desc = L['OPT_TELEPORT_STORMWIND_DESC'],
					func = function() ConjureFu:Teleport(L['STORMWIND']) end,
					order = 2,
				},
				darnassus = {
					type = 'execute',
					name = L['OPT_TELEPORT_DARNASSUS_NAME'],
					desc = L['OPT_TELEPORT_DARNASSUS_DESC'],
					func = function() ConjureFu:Teleport(L['DARNASSUS']) end,
					order = 3,
				},
				orgrimmar = {
					type = 'execute',
					name = L['OPT_TELEPORT_ORGRIMMAR_NAME'],
					desc = L['OPT_TELEPORT_ORGRIMMAR_DESC'],
					func = function() ConjureFu:Teleport(L['ORGRIMMAR']) end,
					order = 1,
				},
				undercity = {
					type = 'execute',
					name = L['OPT_TELEPORT_UNDERCITY_NAME'],
					desc = L['OPT_TELEPORT_UNDERCITY_DESC'],
					func = function() ConjureFu:Teleport(L['UNDERCITY']) end,
					order = 2,
				},
				thunderbluff = {
					type = 'execute',
					name = L['OPT_TELEPORT_THUNDERBLUFF_NAME'],
					desc = L['OPT_TELEPORT_THUNDERBLUFF_DESC'],
					func = function() ConjureFu:Teleport(L['THUNDERBLUFF']) end,
					order = 3,
				},
			},
		},
		portal = {
			type = 'group',
			name = L['GROUP_PORTAL_NAME'],
			desc = L['GROUP_PORTAL_DESC'],
			order = 5,
			args = {
				ironforge = {
					type = 'execute',
					name = L['OPT_PORTAL_IRONFORGE_NAME'],
					desc = L['OPT_PORTAL_IRONFORGE_DESC'],
					func = function() ConjureFu:Portal(L['IRONFORGE'])end,
					order = 1,
					hidden = true,
				},
				stormwind = {
					type = 'execute',
					name = L['OPT_PORTAL_STORMWIND_NAME'],
					desc = L['OPT_PORTAL_STORMWIND_DESC'],
					func = function() ConjureFu:Portal(L['STORMWIND']) end,
					order = 2,
					hidden = true,
				},
				darnassus = {
					type = 'execute',
					name = L['OPT_PORTAL_DARNASSUS_NAME'],
					desc = L['OPT_PORTAL_DARNASSUS_DESC'],
					func = function() ConjureFu:Portal(L['DARNASSUS']) end,
					order = 3,
					hidden = true,
				},
				orgrimmar = {
					type = 'execute',
					name = L['OPT_PORTAL_ORGRIMMAR_NAME'],
					desc = L['OPT_PORTAL_ORGRIMMAR_DESC'],
					func = function() ConjureFu:Portal(L['ORGRIMMAR']) end,
					order = 1,
					hidden = true,
				},
				undercity = {
					type = 'execute',
					name = L['OPT_PORTAL_UNDERCITY_NAME'],
					desc = L['OPT_PORTAL_UNDERCITY_DESC'],
					func = function() ConjureFu:Portal(L['UNDERCITY']) end,
					order = 2,
					hidden = true,
				},
				thunderbluff = {
					type = 'execute',
					name = L['OPT_PORTAL_THUNDERBLUFF_NAME'],
					desc = L['OPT_PORTAL_THUNDERBLUFF_DESC'],
					func = function() ConjureFu:Portal(L['THUNDERBLUFF']) end,
					order = 3,
					hidden = true,
				},
			},
		},
		autobuy = {
			type = 'group',
			name = L['GROUP_AUTOBUY_NAME'],
			desc = L['GROUP_AUTOBUY_DESC'],
			order = 6,
			args = {
				powder = {
					type = 'range',
					name = L['OPT_AUTOBUY_POWDER_NAME'],
					desc = L['OPT_AUTOBUY_POWDER_DESC'],
					get = function() return ConjureFu.db.profile.powderStacks end,
					set = function(stacks) ConjureFu.db.profile.powderStacks = stacks; ConjureFu:OnTextUpdate(); end,
					min = 0,
					max = 5,
					step = 1,
     					order = 1,
				},
				teleport = {
					type = 'range',
					name = L['OPT_AUTOBUY_TELEPORT_NAME'],
					desc = L['OPT_AUTOBUY_TELEPORT_DESC'],
					get = function() return ConjureFu.db.profile.teleportStacks end,
					set = function(stacks) ConjureFu.db.profile.teleportStacks = stacks; ConjureFu:OnTextUpdate(); end,
					min = 0,
					max = 5,
					step = 1,
     					order = 2,
				},
				portal = {
					type = 'range',
					name = L['OPT_AUTOBUY_PORTAL_NAME'],
					desc = L['OPT_AUTOBUY_PORTAL_DESC'],
					get = function() return ConjureFu.db.profile.portalStacks end,
					set = function(stacks) ConjureFu.db.profile.portalStacks = stacks; ConjureFu:OnTextUpdate(); end,
					min = 0,
					max = 5,
					step = 1,
 		    			order = 3,
				},
			},
		},
		hearthstone = {
			type = 'execute',
			name = L['OPT_HEARTHSTONE_NAME'],
			desc = L['OPT_HEARTHSTONE_DESC'],
			func = function() ConjureFu:Consume(hearthTexture) end,
			order = 7,
		},
	},
}

ConjureFu:RegisterChatCommand(L['SLASHCMD'], options)
ConjureFu.OnMenuRequest = options
ConjureFu.hasIcon = "Interface\\Icons\\Spell_Frost_FrostBolt02"
ConjureFu.defaultPosition = 'RIGHT'

function ConjureFu:OnTooltipUpdate()
	options.args.teleport.args.ironforge.hidden = UnitFactionGroup("player")=="Horde" or UnitLevel("player")<20
	options.args.teleport.args.stormwind.hidden = UnitFactionGroup("player")=="Horde" or UnitLevel("player")<20
	options.args.teleport.args.darnassus.hidden = UnitFactionGroup("player")=="Horde" or UnitLevel("player")<30
	options.args.teleport.args.orgrimmar.hidden = UnitFactionGroup("player")=="Alliance" or UnitLevel("player")<20
	options.args.teleport.args.undercity.hidden = UnitFactionGroup("player")=="Alliance" or UnitLevel("player")<20
	options.args.teleport.args.thunderbluff.hidden = UnitFactionGroup("player")=="Alliance" or UnitLevel("player")<30
	options.args.portal.args.ironforge.hidden = UnitFactionGroup("player")=="Horde" or UnitLevel("player")<40
	options.args.portal.args.stormwind.hidden = UnitFactionGroup("player")=="Horde" or UnitLevel("player")<40
	options.args.portal.args.darnassus.hidden = UnitFactionGroup("player")=="Horde" or UnitLevel("player")<50
	options.args.portal.args.orgrimmar.hidden = UnitFactionGroup("player")=="Alliance" or UnitLevel("player")<40
	options.args.portal.args.undercity.hidden = UnitFactionGroup("player")=="Alliance" or UnitLevel("player")<40
	options.args.portal.args.thunderbluff.hidden = UnitFactionGroup("player")=="Alliance" or UnitLevel("player")<50
end

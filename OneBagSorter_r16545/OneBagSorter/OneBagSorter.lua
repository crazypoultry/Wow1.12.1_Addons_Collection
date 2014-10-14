--$Id: OneBank.lua 14776 2006-10-22 04:38:09Z ckknight $
OneBagSorter = OneCore:NewModule("OneBagSorter", "AceHook-2.1", "AceDebug-2.0", "AceConsole-2.0", "AceDB-2.0")
local L = AceLibrary("AceLocale-2.2"):new("OneBagSorter")
local PT = PeriodicTableEmbed:GetInstance("1")
local g = AceLibrary("Gratuity-2.0")
local BC = AceLibrary("Babble-Class-2.2")

function OneBagSorter:OnInitialize()

	self:RegisterDB("OneBagSorterDB")
	self:RegisterDefaults('profile', self:GetDefaults())

	self.iteminfo = {
		"Quality",
		"Armor",
		"Consumable",
		"Reagent",
		"Recipe",
		"Projectile",
		"Quest",
		"Weapon",
		"Trade Goods",
	}
	
	self.ttinfo = {
		"Soulbound"
	}

	self.fBags	= {0, 1, 2, 3, 4}

	--use the OneBagFrame
	self.frame = OneBagFrame

end

function OneBagSorter:GetDefaults()
    if not self.defaults then
        self.defaults = {
			show={
				['*'] = true
			},
			name = {
				['*'] = "Default"
			},
			unsorted = 1,
			sort = true,
		}
    end
    return self.defaults
end

function OneBagSorter:OnEnable()
	self:SecureHook(OneBag, "OrganizeFrame")
	local obcmds = AceLibrary("AceConsole-2.0").registry["ONEBAG"]
	obcmds.args.sorter = self:GetMenu()
end

function OneBagSorter:GetMenu()
	local cmdops = {
		name = "Sorter Options", type = 'group', order = -7,
		desc = "Various Sorter options",
		args = {
			["sort"] = {
				name = "Sort", type = 'toggle', order = 1,
				desc = "Turns sorting of bag on and off.",
				get = function() return self.db.profile.sort end,
				set = function(v) 
					self.db.profile.sort = v 
					OneBag:OrganizeFrame(true)
				end,
			},
			["misc"] = {
				name = "Unsorted Catagory", type = 'range', order = 2,
				desc = "Catagory to place all unsorted items into.",
				get = function() return self.db.profile.unsorted end,
				set = function(v)
					self.db.profile.unsorted = v 
					self:OrganizeFrame(true)
				end,
				min = 1, max = 12, step = 1,
			}
		}
	}
	for i=1, 12 do
		local i = i
		cmdops.args[""..i] = {
			name = "Category "..i,
			type = 'group', order = i+2,
			desc = "Setup Category "..i,
			args = {
				["name"] = {
					name = "Title", type = 'text', order = 1,
					desc = "Sets the display title for the category",
					usage = "any string",
                    get = function() return self.db.profile.name[i] end,
                    set = function(v) 
						self.db.profile.name[i] = v
                    end,        
				},
				["isets"] = {
					name = "Include sets", type = 'group', order = 2,
					desc = "Sets item sets to include in the category",
					args = self:GetItemSets("iset", i)
				},
				["esets"] = {
					name = "Exclude sets", type = 'group', order = 3,
					desc = "Sets item sets to exclude from the category",
					args = self:GetItemSets("eset", i)
				},
			}
		}
	end
	return cmdops
end

function OneBagSorter:GetItemSets(set, cat)
	return {
		['food'] = {
			name = "Food", type = 'toggle',
			desc = "Food item set.",
			get = function() return self:GetPTSet(set, cat, "food") end,
			set = function(v) 
				if v then
					self:SetPTSet(set, cat, "food", {"food", "foodbonus", "foodstat"})
				else
					self:SetPTSet(set, cat, "food", false)
				end
				self:OrganizeFrame(true)
				end,
		},
		['water'] = {
			name = "Water", type = 'toggle',
			desc = "Water item set.",
			get = function() return self:GetPTSet(set, cat, "water") end,
			set = function(v) 
				if v then
					self:SetPTSet(set, cat, "water", {"water", "waterperc", "waterconjured", "waterarathi"})
				else
					self:SetPTSet(set, cat, "water", false)
				end
				self:OrganizeFrame(true)
			end,
		},
		['booze'] = {
			name = "booze", type = 'toggle',
			desc = "Booze item set.",
			get = function() return self:GetPTSet(set, cat, "booze") end,
			set = function(v) 
				if v then
					self:SetPTSet(set, cat, "booze", "booze")
				else
					self:SetPTSet(set, cat, "booze", false)
				end
				self:OrganizeFrame(true)
			end,
		},
		['foodspecial'] = {
			name = "Special food", type = 'toggle',
			desc = "Food that increases both health and mana.",
			get = function() return self:GetPTSet(set, cat, "foodspecial") end,
			set = function(v) 
				if v then
					self:SetPTSet(set, cat, "foodspecial", "foodspecial")
				else
					self:SetPTSet(set, cat, "foodspecial", false)
				end
				self:OrganizeFrame(true)
			end,
		},
		['ammo'] = {
			name = "ammo", type = 'toggle',
			desc = "All types of ammo.",
			get = function() return self:GetPTSet(set, cat, "ammo") end,
			set = function(v) 
				if v then
					self:SetPTSet(set, cat, "ammo", "ammo")
				else
					self:SetPTSet(set, cat, "ammo", false)
				end
				self:OrganizeFrame(true)
			end,
		},
		['antivenom'] = {
			name = "antivenom", type = 'toggle',
			desc = "All types of anti venom.",
			get = function() return self:GetPTSet(set, cat, "antivenom") end,
			set = function(v) 
				if v then
					self:SetPTSet(set, cat, "antivenom", "antivenom")
				else
					self:SetPTSet(set, cat, "antivenom", false)
				end
				self:OrganizeFrame(true)
			end,
		},
		['bandages'] = {
			name = "bandages", type = 'toggle',
			desc = "All types of bandages.",
			get = function() return self:GetPTSet(set, cat, "bandages") end,
			set = function(v) 
				if v then
					self:SetPTSet(set, cat, "bandages", "bandages")
				else
					self:SetPTSet(set, cat, "bandages", false)
				end
				self:OrganizeFrame(true)
			end,
		},
		['explosives'] = {
			name = "explosives", type = 'toggle',
			desc = "All types of explosives.",
			get = function() return self:GetPTSet(set, cat, "explosives") end,
			set = function(v) 
				if v then
					self:SetPTSet(set, cat, "explosives", "explosives")
				else
					self:SetPTSet(set, cat, "explosives", false)
				end
				self:OrganizeFrame(true)
			end,
		},
		['faire'] = {
			name = "faire", type = 'toggle',
			desc = "Items turned in for faire tickets.",
			get = function() return self:GetPTSet(set, cat, "faire") end,
			set = function(v) 
				if v then
					self:SetPTSet(set, cat, "faire", "faire")
				else
					self:SetPTSet(set, cat, "faire", false)
				end
				self:OrganizeFrame(true)
			end,
		},
		['fireworks'] = {
			name = "fireworks", type = 'toggle',
			desc = "All types of fireworks.",
			get = function() return self:GetPTSet(set, cat, "fireworks") end,
			set = function(v) 
				if v then
					self:SetPTSet(set, cat, "fireworks", "fireworks")
				else
					self:SetPTSet(set, cat, "fireworks", false)
				end
				self:OrganizeFrame(true)
			end,
		},
		['lockpickkeys'] = {
			name = "lockpickkeys", type = 'toggle',
			desc = "Skeleton keys and seaforium charges.",
			get = function() return self:GetPTSet(set, cat, "fireworks") end,
			set = function(v) 
				if v then
					self:SetPTSet(set, cat, "lockpickkeys", "lockpickkeys")
				else
					self:SetPTSet(set, cat, "lockpickkeys", false)
				end
				self:OrganizeFrame(true)
			end,
		},
		['healthpots'] = {
			name = "healthpots", type = 'toggle',
			desc = "All health potions including zone specific and health stones.",
			get = function() return self:GetPTSet(set, cat, "healthpots") end,
			set = function(v) 
				if v then
					self:SetPTSet(set, cat, "healthpots",  {"potionheal", "potionhealalterac", "healthstone"})
				else
					self:SetPTSet(set, cat, "healthpots", false)
				end
				self:OrganizeFrame(true)
			end,
		},
		['manapots'] = {
			name = "manapots", type = 'toggle',
			desc = "All mana potions including zone specific and mana stones.",
			get = function() return self:GetPTSet(set, cat, "manapots") end,
			set = function(v) 
				if v then
					self:SetPTSet(set, cat, "manapots",  {"potionmana", "potionmanaalterac", "manastone"})
				else
					self:SetPTSet(set, cat, "manapots", false)
				end
				self:OrganizeFrame(true)
			end,
		},
		['potionrejuv'] = {
			name = "potionrejuv", type = 'toggle',
			desc = "Rejuv type potions.  Those that restore both health and mana.",
			get = function() return self:GetPTSet(set, cat, "potionrejuv") end,
			set = function(v) 
				if v then
					self:SetPTSet(set, cat, "potionrejuv",  "potionrejuv")
				else
					self:SetPTSet(set, cat, "potionrejuv", false)
				end
				self:OrganizeFrame(true)
			end,
		},
		['otherpots'] = {
			name = "otherpots", type = 'toggle',
			desc = "Other postions including rage, cure and buff potions.",
			get = function() return self:GetPTSet(set, cat, "otherpots") end,
			set = function(v) 
				if v then
					self:SetPTSet(set, cat, "otherpots",  {"potionrage", "potioncure", "potionbuff"})
				else
					self:SetPTSet(set, cat, "otherpots", false)
				end
				self:OrganizeFrame(true)
			end,
		},
		['reagent'] = {
			name = "reagent", type = 'toggle',
			desc = "Class specific reagants.  Automaticly ajusts for your character class.",
			get = function() return self:GetPTSet(set, cat, "reagent") end,
			set = function(v) 
				if v then
					self:SetPTSet(set, cat, "reagent",  "ClassReagents")
				else
					self:SetPTSet(set, cat, "reagent", false)
				end
				self:OrganizeFrame(true)
			end,
		},
		['poisons'] = {
			name = "poisons", type = 'toggle',
			desc = "Rogue Poisons.",
			get = function() return self:GetPTSet(set, cat, "poisons") end,
			set = function(v) 
				if v then
					self:SetPTSet(set, cat, "poisons", "poisons")
				else
					self:SetPTSet(set, cat, "poisons", false)
				end
				self:OrganizeFrame(true)
			end,
		},
		['repitems'] = {
			name = "repitems", type = 'toggle',
			desc = "Reputation items.",
			get = function() return self:GetPTSet(set, cat, "repitems") end,
			set = function(v) 
				if v then
					self:SetPTSet(set, cat, "repitems", {"reputationjunk", "reputationtokens", "argentdawncommission"})
				else
					self:SetPTSet(set, cat, "repitems", false)
				end
				self:OrganizeFrame(true)
			end,
		},
		['scrolls'] = {
			name = "scrolls", type = 'toggle',
			desc = "Reputation items.",
			get = function() return self:GetPTSet(set, cat, "scrolls") end,
			set = function(v) 
				if v then
					self:SetPTSet(set, cat, "scrolls", "scrolls")
				else
					self:SetPTSet(set, cat, "scrolls", false)
				end
				self:OrganizeFrame(true)
			end,
		},
		['devices'] = {
			name = "devices", type = 'toggle',
			desc = "Engineering devices.",
			get = function() return self:GetPTSet(set, cat, "devices") end,
			set = function(v) 
				if v then
					self:SetPTSet(set, cat, "devices", "devices")
				else
					self:SetPTSet(set, cat, "devices", false)
				end
				self:OrganizeFrame(true)
			end,
		},
		['weapontempenchants'] = {
			name = "weapontempenchants", type = 'toggle',
			desc = "Temporary wepon enchants.  (weight stones, sharpening stones, poisons, mana oil, wizard oil)",
			get = function() return self:GetPTSet(set, cat, "weapontempenchants") end,
			set = function(v) 
				if v then
					self:SetPTSet(set, cat, "weapontempenchants", "weapontempenchants")
				else
					self:SetPTSet(set, cat, "weapontempenchants", false)
				end
				self:OrganizeFrame(true)
			end,
		},
		['minedgem'] = {
			name = "minedgem", type = 'toggle',
			desc = "Gems that come from mining",
			get = function() return self:GetPTSet(set, cat, "minedgem") end,
			set = function(v) 
				if v then
					self:SetPTSet(set, cat, "minedgem", "minedgem")
				else
					self:SetPTSet(set, cat, "minedgem", false)
				end
				self:OrganizeFrame(true)
			end,
		},
		['dmfcardsdecks'] = {
			name = "dmfcardsdecks", type = 'toggle',
			desc = "Darkmoon faire cards/decks.",
			get = function() return self:GetPTSet(set, cat, "dmfcardsdecks") end,
			set = function(v) 
				if v then
					self:SetPTSet(set, cat, "dmfcardsdecks", {"deckcards", "decks", "cards"})
				else
					self:SetPTSet(set, cat, "dmfcardsdecks", false)
				end
				self:OrganizeFrame(true)
			end,
		},
		['minipetall'] = {
			name = "minipetall", type = 'toggle',
			desc = "Mini pets.",
			get = function() return self:GetPTSet(set, cat, "minipetall") end,
			set = function(v) 
				if v then
					self:SetPTSet(set, cat, "minipetall", "minipetall")
				else
					self:SetPTSet(set, cat, "minipetall", false)
				end
				self:OrganizeFrame(true)
			end,
		},
		['mountsall'] = {
			name = "mountsall", type = 'toggle',
			desc = "All mounts.",
			get = function() return self:GetPTSet(set, cat, "mountsall") end,
			set = function(v) 
				if v then
					self:SetPTSet(set, cat, "mountsall", "mountsall")
				else
					self:SetPTSet(set, cat, "mountsall", false)
				end
				self:OrganizeFrame(true)
			end,
		},
	}
end

function OneBagSorter:GetPTSet(set, cat, items)
	if self.db.profile["PT"..set..cat] then
		return self.db.profile["PT"..set..cat][items]
	end
end

function OneBagSorter:SetPTSet(set, cat, items, val)
	-- remove set
	if not val then
		if self.db.profile["PT"..set..cat] then
			if self.db.profile["PT"..set..cat][items] then
				self.db.profile["PT"..set..cat][items] = nil
				if self.db.profile["PT"..set..cat][items] == {} then self.db.profile["PT"..set..cat] = nil end
			end
		end
	else
		-- add set
		if not self.db.profile["PT"..set..cat] then self.db.profile["PT"..set..cat] = {} end
		self.db.profile["PT"..set..cat][items] = val
	end
end

function OneBagSorter:ClassReagents()
	self:Print("checking class reagents")
	if UnitClass("player") == BC["Warlock"] then return "reagentwarlock"
	elseif  UnitClass("player") == BC["Warrior"] then return "reagentwarrior"
	elseif  UnitClass("player") == BC["Hunter"] then return "reagenthunter"
	elseif  UnitClass("player") == BC["Mage"] then return "reagentmage"
	elseif  UnitClass("player") == BC["Priest"] then return "reagentpriest"
	elseif  UnitClass("player") == BC["Druid"] then return "reagentdruid"
	elseif  UnitClass("player") == BC["Paladin"] then return "reagentpaladin"
	elseif  UnitClass("player") == BC["Shaman"] then return "reagentshaman"
	elseif  UnitClass("player") == BC["Rogue"] then return "reagentrogue"
	end
end

function OneBagSorter:OrganizeFrame(needs)
	if not self.db.profile.sort then return end
	if not OneBag.needToOrganize and not needs then return end

	-- clear my current sorting groups
	for i = 1, 12 do
		if not self.cats then self.cats = {} end
		self.cats[i] = {}
	end
	local additem = false
	-- lets loop though all the bag
	for k, bag in pairs(self.fBags) do
		local curBag = self.frame.bags[bag]
		-- if the bag has slots then lets go though them all
		if curBag and curBag.size and curBag.size > 0 then
			-- only if the bag should be shown via OneBag Options
			if OneBag:ShouldShow(bag, curBag.isAmmo, curBag.isSoul, curBag.isProf) then
				for slot = 1, curBag.size do
					additem = false
					-- get the item link 
					local item = PT:GetID(GetContainerItemLink(bag, slot))
					-- loop through all the catagories
					for i=1, 12 do 
						-- lets check PT sets first
						if self.db.profile["PTiset"..i] then 
							-- loop though each PTset for this catagory
							for s in self.db.profile["PTiset"..i] do
								if self:InPTSet(item, self.db.profile["PTiset"..i][s]) then
									-- we found the item in the PT set
									additem = true
									--we found the item so we can skip the rest of the checks
									break
								end
							end
						end
						-- if we found the item lets check the exclution sets 
						if additem then
							-- lets check the exclution PT sets now
							if self.db.profile["PTeset"..i] then
								for s in self.db.profile["PTeset"..i] do
									if self:InPTSet(item, self.db.profile["PTeset"..i][s]) then
										-- the item should be excluded to don't add it and move on
										additem = false
										break
									end
								end
							end
						end
						if additem then 
							-- add the item to the catagory
							table.insert(self.cats[i], {bag, slot})
							-- we added the item to a catagory so we can skip checking the rest.
							break
						end
					end
					if not additem then
						-- add the item to the unsorted catagory
						table.insert(self.cats[self.db.profile.unsorted], {bag, slot})
					end						
				end
			end
		end
	end
	local cols, curCol, curRow, justinc = OneBag.db.profile.cols, 1, 1, false

	-- Now lets reorder the display of the bag slots
	for i = 1, 12 do
	--for k, set in pairs(self.sets) do
		for j, bag in pairs(self.cats[i]) do
			local curBag = self.frame.bags[bag[1]]
			self.frame.bags[bag[1]][bag[2]]:ClearAllPoints()
			self.frame.bags[bag[1]][bag[2]]:SetPoint("TOPLEFT", self.frame:GetName(), "TOPLEFT", self.leftBorder + (self.colWidth * (curCol - 1)) , 0 - self.topBorder - (self.rowHeight * curRow))
			self.frame.bags[bag[1]][bag[2]]:Show()				
			curCol = curCol + 1
			if curCol > cols then curCol, curRow = 1, curRow + 1 end
		end
	end
end

function OneBagSorter:InPTSet(item, set)
	if not item or not set then return end
	-- check for custom function
	if self[set] then set = self[set](self) end
	if type(set) == "table" then
		for k, v in pairs(set) do
			if self:InPTSet(item, v) then
				return true
			end
		end
	else
		return PT:ItemInSet(item, set)
	end
end

function OneBagSorter:InItemInfo(item, set)
	if not item or not set then return end
	if type(set) == "table" then
		for k, v in pairs(set) do
			if self:InItemInfo(item, v) then
				return true
			end
		end
	else
		--  itemName, itemString, itemQuality, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture 
		local _, _, itemQuality, _, itemType, itemSubType = GetItemInfo(item)
		if set.Quality then
			if set.Quality >= itemQuality then return true end
		else
			if set == itemType then return true end
		end
	end
end

function OneBagSorter:InTTInfo(bag, slot, set)
	if not bag or not slot or not set then return end
	if type(set) == "table" then
		for k, v in pairs(set) do
			if self:InTTInfo(item, v) then
				return true
			end
		end
	else
		g:SetBagItem(bag, slot)
		return g:Find(set)
	end
end

function OneBagSorter:Print(a1,a2,a3,a4,a5)
	if not a1 then return end
	ChatFrame1:AddMessage("|cffffff78OneBagSorter: |r"..string.format(a1,a2,a3,a4,a5))
end
-- Copyright (c) 2005 William J. Rogers <wjrogers@gmail.com>
-- This file is released under the terms of the GNU General Public License v2

BINDING_HEADER_GAUTOBAR = "GAutoBar"
BINDING_NAME_GAUTOBARBUTTON1 = "Bandages"
BINDING_NAME_GAUTOBARBUTTON2 = "Health Potions"
BINDING_NAME_GAUTOBARBUTTON3 = "Mana/Rage/Energy Potions"
BINDING_NAME_GAUTOBARBUTTON4 = "Food"
BINDING_NAME_GAUTOBARBUTTON5 = "Water"

local item_types = {
	["bandaid"] = {
		"item:1251",		-- "Linen Bandage",
		"item:2581",		-- "Heavy Linen Bandage",
		"item:3530",		-- "Wool Bandage",
		"item:3531",		-- "Heavy Wool Bandage",
		"item:6450",		-- "Silk Bandage",
		"item:6451",		-- "Heavy Silk Bandage",
		"item:8544",		-- "Mageweave Bandage",
		"item:8545",		-- "Heavy Mageweave Bandage",
		"item:14529", 		-- "Runecloth Bandage",
		"item:14530",		-- "Heavy Runecloth Bandage"
	},

	["health"] = {
		"item:118",			-- "Minor Healing Potion",
		"item:858",			-- "Lesser Healing Potion",
		"item:4596",		-- "Discolored Healing Potion",
		"item:929",			-- "Healing Potion",
		"item:1710",		-- "Greater Healing Potion",
		"item:3928",		-- "Superior Healing Potion",
		"item:13446",		-- "Major Healing Potion"
		"item:5512",		-- "Minor Healthstone",
		"item:5511",		-- "Lesser Healthstone",
		"item:5509",		-- "Healthstone",
		"item:5510",		-- "Greater Healthstone",
		"item:9421",		-- "Major Healthstone",
		"item:19012",		-- "Major Healthstone" (w/talent +1),
		"item:19013",		-- "Major Healthstone" (w/talent +2)
	},

	["mana"] = {
		"item:2455",		-- "Minor Mana Potion",
		"item:3385",		-- "Lesser Mana Potion",
		"item:3827",		-- "Mana Potion",
		"item:6149",		-- "Greater Mana Potion",
		"item:13443",		-- "Superior Mana Potion",
		"item:13444", 		-- "Major Mana Potion"
		"item:5514",		-- "Mana Agate",
		"item:5513",		-- "Mana Jade",
		"item:8007",		-- "Mana Citrine",
		"item:8008",		-- "Mana Ruby",
	},

	["water"] = {
		"item:159",		-- "Refreshing Spring Water",
		"item:5350",		-- "Conjured Water",
		"item:1179",		-- "Ice Cold Milk",
		"item:2288",		-- "Conjured Fresh Water",
		"item:1205",		-- "Melon Juice",
		"item:9451",		-- "Bubbling Water",
		"item:2136",		-- "Conjured Purified Water",
		"item:1708",		-- "Sweet Nectar",
		"item:4791", 		-- "Enchanted Water",
		"item:10841",		-- "Goldthorn Tea",
		"item:3772",		-- "Conjured Spring Water",
		"item:1645",		-- "Moonberry Juice",
		"item:8077",		-- "Conjured Mineral Water",
		"item:8766",		-- "Morning Glory Dew",
		"item:13724",		-- "Enriched Manna Biscuit",
		"item:8078",		-- "Conjured Sparkling Water",
		"item:8079",		-- "Conjured Crystal Water",
		"item:13813",		-- "Blessed Sunfruit Juice",
	},

	["food"] = {
		{"item:2070", 61},				-- Darnassian Bleu - Vendor - Level 1, heals 61
		{"item:4540", 61},				-- Tough Hunk of Bread - Vendor - Level 1, heals 61
		{"item:4536", 61}, 				-- Shiny Red Apple - Vendor - Level 1, heals 61
		{"item:117", 61},				-- Tough Jerky - Vendor - Level 1, heals 61
		{"item:4604", 61},				-- Forest Mushroom Cap - Vendor - Level 1, heals 61
		{"item:16166", 61},				-- Bean Soup - Vendor - Level 1, heals 61
		{"item:9681", 61},				-- Charred Wolf Meat - Cooking - Level 1, heals 61
		{"item:2681", 61},				-- Roasted Boar Meat - Cooking - Level 1, heals 61
		{"item:787", 61},				-- Slitherskin Mackerel - Cooking - Level 1, heals 61
		{"item:6290", 61},				-- Brillian Smallfish - Cooking - Level 1, heals 61
		{"item:2680", 61, 1},				-- Spiced Wolf Meat - Cooking
		{"item:5349", 61, 0},				-- Conjured Muffin - Mage - Level 1, heals 61
		{"item:6888", 61, 1}, 				-- Herb Baked Egg - Cooking - Level 1, heals 61, with bonus
		{"item:12224", 61, 1},				-- Crispy Bat Wing - Cooking - Level 1, heals 61, with bonus
		{"item:17197", 61, 1},				-- Gingerbread Cookie - Cooking - Level 1, heals 61, with bonus
		{"item:17198", 61, 1},				-- Egg Nog - Cooking - Level 1, heals 61, with bonus
		{"item:5472", 61, 1},				-- Kaldorei Spider Kabob - Cooking - Level 1, heals 61, with bonus
		{"item:2888", 61, 1},				-- Beer Basted Boar Ribs - Cooking - Level 1, heals 61, with bonus
		{"item:5474", 61, 1},				-- Roasted Kodo Meat - Cooking - Level 1, heals 61, with bonus
		{"item:11584", 61, 1},				-- Cactus Apple Surprise - Quest - Level 1, heals 61, with bonus
		{"item:16167", 243},				-- Versicolor Treat - Vendor - Level 5, heals 243
		{"item:4605", 243},				-- Red-speckled Mushroom - Vendor - Level 5, heals 243
		{"item:2287", 243},				-- Haunch of Meat - Vendor - Level 5, heals 243
		{"item:4537", 243},				-- Tel'Abim Banana - Vendor - Level 5, heals 243
		{"item:414", 243},				-- Dalaran Sharp - Vendor - Level 5, heals 243
		{"item:4541", 243}, 				-- Freshly Baked Bread - Vendor - Level 5, heals 243
		{"item:6890", 243},				-- Smoked Bear Meat - Cooking - Level 5, heals 243
		{"item:6316", 243},				-- Loch Frenzy Delight - Cooking - Level 5, heals 243
		{"item:5095", 243}, 				-- Rainbow Fin Albacore - Cooking - Level 5, heals 243
		{"item:4592", 243},				-- Longjaw Mud Snapper - Cooking - Level 5, heals 243
		{"item:1113", 243, 0},				-- Conjured Bread - Mage - Level 5, heals 243
		{"item:2683", 243, 1},				-- Crab Cake - Cooking
		{"item:2684", 243, 1},				-- Coyote Steak - Cooking
		{"item:5525", 243, 1},				-- Boiled Clams - Cooking
		{"item:5476", 243, 1},				-- Fillet of Frenzy - Cooking - Level 5, heals 243, with bonus
		{"item:5477", 243, 1},				-- Strider Stew Cooking - Level 5, heals 243, with bonus
		{"item:724", 243, 1},				-- Goretusk Liver Pie - Cooking - Level 5, heals 243, with bonus
		{"item:3220", 243, 1},				-- Blood Sausage - Cooking - Level 5, heals 243, with bonus
		{"item:3662", 243, 1},				-- Crocolisk Steak - Cooking - Level 5, heals 243, with bonus
		{"Dry Pork Ribs", 243, 1},			-- Cooking - Level 5, heals 243, with bonus
		{"item:3448", 294, 1}, 				-- Senggin Root	Horde Quest - Level 1, heals 294, mana 294
		{"item:5473", 294, 1},				-- "Scorpid Surprise",	-- Cooking - Level 1, heals 294
		{"Cooked Crab Claw", 294, 1},			-- Cooking - Level 5, heals 294
		{"item:733", 552},				-- Westfall StewCooking - Level 5, heals 552
		{"item:422", 552},				-- "Dwarven Mild",		-- Vendor  - Level 15, heals 552
		{"item:4542", 552}, 				-- "Moist Cornbread",	-- Vendor  - Level 15, heals 552
		{"item:4538", 552},				-- Snapvine Watermelon Vendor  - Level 15, heals 552
		{"item:3770", 552},				-- Mutton Chop Vendor  - Level 15, heals 552
		{"Spongy Morel", 552},				-- Vendor  - Level 15, heals 552
		{"Steamed Mandu", 552},				-- Vendor  - Level 15, heals 552
		{"Clam Chowder", 552},				-- Cooking - Level 10, heals 552
		{"Dig Rat Stew", 552},				-- Cooking - Level 10, heals 552
		{"Succulent Pork Ribs", 552},			-- Cooking - Level 10, heals 552
		{"item:4593", 552},				-- Bristle Whisker Catfish Cooking - Level 15, heals 552
		{"item:1114", 552, 0},				-- Conjured Rye Mage    - Level 15, heals 552
		{"Redridge Goulash", 552, 1},			-- Cooking - Level 10, heals 552, with bonus
		{"item:5479", 552, 1}, 				-- "Crispy Lizard Tail",	-- Cooking - Level 12, heals 552, with bonus
		{"Seasoned Wolf Kabob", 552, 1},		-- Cooking - Level 15, heals 552, with bonus
		{"Murloc Fin Soup", 552, 1},			-- Cooking - Level 15, heals 552, with bonus
		{"Big Bear Steak", 552, 1},			-- Cooking - Level 15, heals 552, with bonus
		{"Lean Venison", 552, 1},			-- Cooking - Level 15, heals 552, with bonus
		{"Gooey Spider Cake", 552, 1},			-- Cooking - Level 15, heals 552, with bonus
		{"Crocolisk Gumbo", 552, 1},			-- Cooking - Level 15, heals 552, with bonus
		{"Goblin Deviled Clams", 552, 1},		-- Cooking - Level 15, heals 552, with bonus
		{"Hot Lion Chops", 552, 1},			-- Cooking - Level 15, heals 552, with bonus
		{"Lean Wolf Steak", 552, 1},			-- Cooking - Level 15, heals 552, with bonus
		{"Curiously Tasty Omelet", 552, 1},		-- Cooking - Level 15, heals 552, with bonus
		{"item:4594", 874}, 				-- "Rockscale Cod",	-- Cooking - Level 25, heals 874
		{"item:8364", 874},				-- Mithril Head Trout Cooking - Level 25, heals 874
		{"Wild Ricecake", 874},				-- Vendor  - Level 25, heals 874
		{"item:4607", 874}, 				-- "Delicious Cave Mold",	-- Vendor  - Level 25, heals 874
		{"item:3771", 874},				-- Wild Hog Shank Vendor  - Level 25, heals 874
		{"item:4539", 874},				-- Goldenbark Apple Vendor  - Level 25, heals 874
		{"item:4544", 874},				-- Mulgore Spice Bread Vendor  - Level 25, heals 874
		{"item:1707", 874},				-- Stormwind Brie Vendor  - Level 25, heals 874
		{"item:1487", 874, 0},				-- Conjured Pumpernickel Mage    - Level 25, heals 874
		{"Tasty Lion Steak", 874, 1},			-- Cooking - Level 20, heals 874, with bonus
		{"item:4457", 874, 1},				-- "Barbecued Buzzard Wing",-- Cooking - Level 25, heals 874, with bonus
		{"item:12213", 874, 1},				-- "Carrion Surprise",	-- Cooking - Level 25, heals 874, with bonus
		{"Giant Clam Corcho", 874, 1},			-- Cooking - Level 25, heals 874, with bonus
		{"Soothing Turtle Bisque", 874, 1},		-- Cooking - Level 25, heals 874, with bonus
		{"item:13851", 874, 1},				-- "Hot Wolf Ribs",	-- Cooking - Level 25, heals 874, with bonus
		{"item:12214", 874, 1},				-- "Mystery Stew",		-- Cooking - Level 25, heals 874, with bonus
		{"Roast Raptor", 874, 1},			-- Cooking - Level 25, heals 874, with bonus
		{"Jungle Stew", 874, 1},			-- Cooking - Level 25, heals 874, with bonus
		{"item:17222", 874, 1},				-- Spider Sausage Cooking
		{"item:13928", 874, 1},				-- "Grilled Squid",	-- Cooking - Level 35, heals 874, with bonus(agility)
		{"Hot Smoked Bass", 874, 1},			-- Cooking - Level 35, heals 874, with bonus
		{"Nightfin Soup", 874, 1},			-- Cooking - Level 35, heals 874, with bonus(mana regen)
		{"Poached Sunscale Salmon", 874, 1},		-- Cooking - Level 35, heals 874, with bonus(hp regen)
		{"item:13546", 1392},				-- "Bloodbelly Fish",	-- Quest   - Level 25, heals 1392
		{"item:3927", 1392},				-- "Fine Aged Cheddar",	-- Vendor  - Level 35, heals 1392
		{"item:4601", 1392},				-- "Soft Banana Bread",	-- Vendor  - Level 35, heals 1392
		{"Moon Harvest Pumpkin", 1392},			-- Vendor  - Level 35, heals 1392
		{"item:4599", 1392},				-- Cured Ham Steak Vendor  - Level 35, heals 1392
		{"item:4608", 1392}, 				-- Raw Black Truffle Vendor  - Level 35, heals 1392
		{"Heaven Peach", 1392},				-- Vendor  - Level 35, heals 1392
		{"Filet of Redgill", 1392},			-- Cooking - Level 35, heals 1392
		{"item:9681", 1392},				-- "Grilled King Crawler Legs",-- Quest   - Level 35, heals 1392
		{"item:8075", 1392, 0},				-- "Conjured Sourdough",	-- Mage    - Level 35, heals 1392
		{"Heavy Kodo Stew", 1392, 1},			-- Cooking - Level 35, heals 1392, with bonus
		{"item:6887", 1392, 1},				-- "Spotted Yellowtail",	-- Cooking - Level 35, heals 1392, with bonus
		{"Cooked Glossy Mightfish", 1392, 1},		-- Cooking - Level 35, heals 1392, with bonus
		{"Spider Chilli Crab", 1392, 1},		-- Cooking - Level 35, heals 1392, with bonus
		{"item:16766", 1392},				-- "Undermine Clam Chowder",-- Cooking - Level 35, heals 1392
		{"Monster Omelet", 1392, 1},			-- Cooking - Level 40, heals 1392, with bonus
		{"item:16971", 1392, 1},			-- Clamlette Surprise Cooking - Level 40, heals 1392, with bonus
		{"Tender Wolf Steak", 1392, 1}, 		-- Cooking - Level 40, heals 1392, with bonus
		{"Mightfish Steak", 1933, 1},			-- Cooking - Level 45, heals 1933, with bonus
		{"item:13810",1933, 1},				-- Argent Dawn - Level 45, heals 1933, with bonus
		{"Shinsollo", 2148},				-- Vendor  - Level 45, heals 2148
		{"item:8952", 2148}, 				-- Roasted Quail Vendor  - Level 45, heals 2148
		{"item:8953", 2148}, 				-- Deep Fried Plantains Vendor  - Level 45, heals 2148
		{"item:8950", 2148},				-- Homemade Cherry Pie Vendor  - Level 45, heals 2148
		{"item:8932", 2148}, 				-- Alterac Swiss Vendor  - Level 45, heals 2148 
		{"item:8948", 2148}, 				-- Dried King Bolete Vendor  - Level 45, heals 2148
		{"Spinefin Halibut", 2148},			-- Vendor  - Level 45, heals 2148
		{"Baked Salmon", 2148},				-- Cooking - Level 45, heals 2148
		{"Lobster Stew", 2148},				-- Cooking - Level 45, heals 2148
		{"Conjured Sweet Roll", 2148, 0},		-- Mage    - Level 45, heals 2148
		{"item:22895", 3180},				-- Mage Level 55, heals 3180
	}
}

local alt_types = {
	["rage"] = {
		"item:5631", 		-- "Rage Potion",
		"item:5633",		-- "Great Rage Potion",
		"item:13442",		-- "Mighty Rage Potion"
	},
	["energy"] = {
		"item:7676",		-- "Thistle Tea"
	},
}

local search_queue = {}
local elapsed = 0

local cache = {}
local item_list = {}
local button_ids = { ["bandaid"] = 1, ["health"] = 2, ["mana"] = 3, ["food"] = 4, ["water"] = 5 }

function GAutoBar_OnLoad()
	-- register with GBars
	GBars.bars["auto"] = "GAutoBar"
end

function GAutoBar_Init()
	-- set up the item_list
	GAutoBar_BlankList()

	-- set class specific things
	local eng_class
	_, eng_class = UnitClass("player")
	if (eng_class == "WARRIOR") then
		item_types["mana"] = alt_types["rage"]
		item_types["water"] = nil
	elseif (eng_class == "ROGUE") then
		item_types["mana"] = alt_types["energy"]
		item_types["water"] = nil
	end

	-- register for events
	GAutoBar:RegisterEvent("BAG_UPDATE")
	GAutoBar:RegisterEvent("UNIT_AURA")
	GAutoBar:RegisterEvent("ITEM_LOCK_CHANGED")
	GAutoBar:RegisterEvent("BAG_UPDATE_COOLDOWN")
	GAutoBar:RegisterEvent("UPDATE_INVENTORY_ALERTS")
	GAutoBar:RegisterEvent("PLAYER_LEVEL_UP")
	
	-- this tells the update handler whether we're waiting to scan the bags
	-- set to 1 and fill queue for initial scan on load
	GAutoBar.waiting = 1
	search_queue = { [0] = 1, [1] = 1, [2] = 1, [3] = 1, [4] = 1 }
end

function GAutoBar_Disable()
	-- unregister events, so we don't work anymore
	GAutoBar:UnregisterEvent("BAG_UPDATE")
	GAutoBar:UnregisterEvent("UNIT_AURA")
	GAutoBar:UnregisterEvent("ITEM_LOCK_CHANGED")
	GAutoBar:UnregisterEvent("BAG_UPDATE_COOLDOWN")
	GAutoBar:UnregisterEvent("UPDATE_INVENTORY_ALERTS")
	GAutoBar:UnregisterEvent("PLAYER_LEVEL_UP")

	-- clear out stuff
	GAutoBar.waiting = nil
	search_queue = {}
	GAutoBar_BlankList()
	GAutoBar_UpdateButtons()
end

function GAutoBar_BlankList()
	local item_type
	cache[0] = {}
	cache[1] = {}
	cache[2] = {}
	cache[3] = {}
	cache[4] = {}
	item_list = {}
	for item_type in pairs(item_types) do
		item_list[item_type] = {}
	end
end

function GAutoBar_OnEvent()
	if (event == "BAG_UPDATE" and arg1 >= 0 and arg1 <= 4) then
		search_queue[arg1] = 1
		GAutoBar.waiting = 1
		-- if (elapsed > -2) then
		-- 	elapsed = elapsed - 0.5 -- delay the processing slightly for each update
		-- end
	elseif (event == "UNIT_AURA" and arg1 == "player") then
		GAutoBar_UpdateButtons() -- hope perf penalty is not too bad for this, need to track Well Fed
	elseif (event == "ITEM_LOCK_CHANGED" or event == "BAG_UPDATE_COOLDOWN" or event == "UPDATE_INVENTORY_ALERTS") then
		for _, i in button_ids do
			GAutoBar_UpdateCooldown(getglobal("GAutoBarButton"..i))
		end
	elseif (event == "PLAYER_LEVEL_UP") then
		GAutoBar_UpdateButtons() -- since we are checking player level as a preq
	end
end

function GAutoBar_OnUpdate(time)
	if (GAutoBar.waiting) then
		elapsed = elapsed + time
		if (elapsed > 1) then
			GAutoBar_Scan()
		end
	end
end

function GAutoBar_IsFed()
	local counter = 1
	local buff = UnitBuff("player", counter)
	while (buff) do
		if (string.find(buff, "Spell_Misc_Food")) then return 1 end
		counter = counter + 1
		buff = UnitBuff("player", counter)
	end
	return nil
end

function GAutoBar_UpdateButtons()
	local item_type, slot_list, info, pick
	local id, texture, count
	local button, total
	local is_fed = GAutoBar_IsFed()
	local player_level = UnitLevel("player")
	for item_type, slot_list in pairs(item_list) do
		-- select the item from the category to be displayed
		pick = nil
		total = {}
		for slot, info in pairs(slot_list) do
			-- store total of each *id*
			if (total[info[1]]) then
				total[info[1]] = total[info[1]] + info[3]
			else
				total[info[1]] = info[3]
			end
			
			-- adjust priority by any special considerations (just food for now)
			info[6] = info[4]  -- adjusted priority
			if (item_type == "food" and is_fed and info[5] == 1) then
				info[6] = info[4] / 10 -- reduce priority of stat food if we're already well-fed
			elseif (item_type == "food" and not is_fed and info[5] == 1) then
				info[6] = info[4] * 2 -- if not fed, increase the priority of stat food
			elseif (item_type == "food" and info[5] == 0) then
				info[6] = info[4] + 1 -- eat conjured food before normal food
			end

			-- set this as the pick if we like it better than the others
			if (info[7] > player_level) then
				-- pass
			elseif (not pick or info[6] > slot_list[pick][6]) then
				pick = slot
			elseif (pick and info[6] == slot_list[pick][6] and info[3] < slot_list[pick][3]) then
				pick = slot -- prefer lower-count stacks if priority is equal
			end
		end

		-- if we found an item, set it on the button
		button = getglobal("GAutoBarButton"..button_ids[item_type])
		if (pick) then
			id, texture, count = unpack(slot_list[pick])
			_, _, button.bag, button.slot = string.find(pick, "(%d+)-(%d+)")
			getglobal(button:GetName().."Icon"):SetTexture(texture)
			getglobal(button:GetName().."Count"):SetText(total[id])
			GAutoBar_UpdateCooldown(button)
			button:Show()
		else
			getglobal(button:GetName().."Icon"):SetTexture(nil)
			getglobal(button:GetName().."Count"):SetText("")
			button.bag, button.slot = nil, nil
			button:Hide()
		end
	end
end

function GAutoBar_UpdateCooldown(button)
	if (button.bag and button.slot) then
		local cooldown = getglobal(button:GetName().."Cooldown")
		local start, duration, enable = GetContainerItemCooldown(button.bag, button.slot)
		CooldownFrame_SetTimer(cooldown, start, duration, enable)
		-- if (duration > 0 and enable == 0) then
		-- 	SetItemButtonTextureVertexColor(button, 0.4, 0.4, 0.4)
		-- end
	end
end

function GAutoBar_ShowTooltip(button)
	if (button.bag and button.slot) then
		GameTooltip:SetOwner(button, "ANCHOR_LEFT")
		GameTooltip:SetBagItem(button.bag, button.slot)
	end
end


function GAutoBar_UseItem(button)
	if (button.bag and button.slot) then
		UseContainerItem(button.bag, button.slot)
		elapsed = 4  -- should cause immediate scan
	end
end

function GAutoBar_Scan()
	-- prevent endless loop
	GAutoBar.waiting = nil
	elapsed = 0

	-- update the cache of items in the changed bag(s)
	for bag, val in pairs(search_queue) do
		GAutoBar_SearchBag(bag)
	end

	-- set that we have completed a scan
	search_queue = {}

	-- update the buttons
	GAutoBar_UpdateButtons()

	-- DEV see if it worked!
	--DevTools_Dump(item_list)
end

function GAutoBar_SearchBag(bag)
	local id, name
	for i = 1, GetContainerNumSlots(bag) do
		_, _, id, name = GAutoBar_ParseLink(GetContainerItemLink(bag, i))
		if ((not id or not name) and cache[bag][i]) then
			GAutoBar_CacheUpdate(bag, i, nil)
		elseif ((id and name) and (not cache[bag][i] or cache[bag][i]["id"] ~= id)) then
			GAutoBar_CacheUpdate(bag, i, { ["id"] = id, ["name"] = name })
		elseif ((id and name) and cache[bag][i]["type"]) then  -- update count in item_list
			_, item_list[cache[bag][i]["type"]][bag.."-"..i][3] = GetContainerItemInfo(bag, i)
		end
	end
end

function GAutoBar_CacheUpdate(bag, slot, contents)
	local pri, id
	local this_id, this_pri, special, req_level
	local item_type, id_list
	local texture, count
	local done
	
	-- remove the old item from the item_list
	if (cache[bag][slot] and cache[bag][slot]["type"]) then
		item_type = cache[bag][slot]["type"]
		item_list[item_type][bag.."-"..slot] = nil
	end

	-- detect the type of the new item
	if (contents) then
		for item_type, id_list in pairs(item_types) do
			done = false
			for pri, id in pairs(id_list) do
				-- we are handling food differently, since the list contains triples
				if item_type == "food" then
					this_id, this_pri, special = unpack(id)
				else
					this_id, this_pri, special = id, pri, nil
				end
				
				-- check if the item under consideration is this item from the list
				if (contents["id"] == this_id or contents["name"] == this_id) then
					contents["type"] = item_type
					texture, count = GetContainerItemInfo(bag, slot)
					req_level = GAutoBar_GetItemLevel(bag, slot)
					item_list[item_type][bag.."-"..slot] = { this_id, texture, count, this_pri, special, 0, req_level }
					done = true
					break
				end
			end
			if done then break end
		end
	end
	
	-- update the cache
	cache[bag][slot] = contents
end

-- uses the tooltip trick to get the required level for an item
function GAutoBar_GetItemLevel(bag, slot)
	local num_lines, fs, level

	-- set the bag tooltip and capture
	GameTooltip:Hide()
	GameTooltip:SetBagItem(bag, slot)
	num_lines = GameTooltip:NumLines()
	for i = 1, num_lines do
		fs = getglobal("GameTooltipTextLeft"..i)
		_, _, level = string.find(fs:GetText(), "Requires Level (%d+)")
		if level then return tonumber(level) end
	end
	return 0
end

function GAutoBar_ParseLink(link)
	if (not link) then return nil end
	return string.find(link, "|H(item:%d+):%d+:%d+:%d+|h%[([^]]+)%]|h|r$")
end

function GAutoBar_ButtonDown(id)
	local button = getglobal("GAutoBarButton"..id)
	if (button:GetButtonState() == "NORMAL") then
		button:SetButtonState("PUSHED")
	end
end

function GAutoBar_ButtonUp(id)
	local button = getglobal("GAutoBarButton"..id)
	if (button:GetButtonState() == "PUSHED") then
		button:SetButtonState("NORMAL")
		if (MacroFrame_SaveMacro) then
			MacroFrame_SaveMacro()
		end
		GAutoBar_UseItem(button)
	end
end

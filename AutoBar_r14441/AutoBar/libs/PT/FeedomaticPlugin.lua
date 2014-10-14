
PeriodicTableFeedOMatic = AceAddon:new({
	name          = "PeriodicTableFeedOMatic",
	description   = "Import PT data to Feed-o-matic",
	version       = "1",
	releaseDate   = "1-29-2005",
	aceCompatible = 102,
	author        = "Tekkub Stoutwrithe",
	email 		    = "tekkub@gmail.com",
	category      = "inventory",
})


function PeriodicTableFeedOMatic:Enable()
	if FOM_Feed then self:Hook("FOM_Feed") end
end


function PeriodicTableFeedOMatic:FOM_Feed(aFood)
	if not self.ImportDone then
		self:debug("Importing PT foods to FOM")
		local sets = {
			{"foodclassbread", FOM_DIET_BREAD},
			{"foodclassfish", FOM_DIET_FISH},
			{"foodclassmeat", FOM_DIET_MEAT},
			{"foodclasscheese", FOM_DIET_CHEESE},
			{"foodclassfruit", FOM_DIET_FRUIT},
			{"foodclassfungus", FOM_DIET_FUNGUS},
			{"foodbonus", FOM_DIET_BONUS},
		}

		for _,vals in sets do
			local dest = vals[2]
			PeriodicTable:ItemInSet(1, vals[1])
			FOM_Foods[dest] = {}
			for _,set in PeriodicTable.k.Food[vals[1]] do
				if PeriodicTable.vars.cache[set] then
					for item,v in PeriodicTable.vars.cache[set] do
						table.insert(FOM_Foods[dest], item)
					end
				end
			end
		end
		self.ImportDone = true
	end

	return self.Hooks["FOM_Feed"].orig(aFood)
end


--------------------------------
--      Load this bitch!      --
--------------------------------
PeriodicTableFeedOMatic:RegisterForLoad()

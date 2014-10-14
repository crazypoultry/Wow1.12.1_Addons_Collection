
-- module setup
local me = { name = "stats"}
local mod = thismod
mod[me.name] = me

--[[
An implementation of a specific data set. You can only add items to the set. They are all numbers. There is a maximum capacity. It records the average and standard deviation.
]]

me.newdataset = function(capacity)
	
	local value = 
	{
		["capacity"] = capacity,
		["values"] = { },
		["average"] = 0,
		["count"] = 0,
		["sum"] = 0,
		["squaresum"] = 0,
		["standarddeviation"] = 0,
		["lastitemindex"] = capacity, -- index of the most recently added item (only when collection is full)
	}
	
	return value
	
end

me.additem = function(data, item)

	-- 1) dataset is already full
	if data.count == data.capacity then
		
		-- locate the index of the oldest entry
		local oldestindex = math.mod(data.lastitemindex, data.capacity) + 1 -- this maps (1, n) to (1, n) taking x -> x + 1, n to 1.
		
		-- recompute sum and squaresum
		data.sum = data.sum + item - data.values[oldestindex]
		data.squaresum = data.squaresum + item ^ 2 - (data.values[oldestindex]) ^ 2
		
		-- update value
		data.values[oldestindex] = item
		
		-- update recent item
		data.lastitemindex = oldestindex
	
	-- 2) dataset is not yet ful
	else
		-- update count and values
		data.count = data.count + 1
		data.values[data.count] = item
	
		-- update sum and squaresum
		data.sum = data.sum + item
		data.squaresum = data.squaresum + item ^ 2
		
	end
	
	-- Now recomute average and standard deviation
	data.average = data.sum / data.count
	data.standarddeviation = math.sqrt((data.count / math.max(1, data.count - 1)) * (data.squaresum / data.count - data.average ^ 2))
	
end

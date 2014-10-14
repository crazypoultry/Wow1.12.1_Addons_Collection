sm = {}
sm.SMItem = {}

function sm.SMItem:new(itemId, power, battleground, localName, bag, slot, count, isPrecious)
   local obj = {}
   setmetatable(obj, { __index = self })
   obj.itemId = itemId
   obj.power = power
   obj.battleground = battleground
   obj.localName = localName
   obj.bag = bag
   obj.slot = slot
   obj.count = count
   obj.isPrecious = isPrecious
   return obj
end

function sm.SMItem:toString()
   local tmp = {}
   for idx, bagSlot in self.bagSlots do
      table.insert(tmp, bagSlot:toString())
   end
   local bagSlotsStr = table.concat(tmp, ',')
   
   return "["..sm.nonil(self.itemId)..","..sm.nonil(self.power)..","..
      sm.nonil(self.battleground)..","..sm.nonil(self.localName)..
      sm.nonil(self.bag).."/"..sm.nonil(self.slot)..","..
      sm.nonil(self.count).."]"
end


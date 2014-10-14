
YAK_SUBJECT = {}

function YAK_SUBJECT:Create()
   local result = {Observers = {}}
   setmetatable( result, self )
   self.__index = self
   return result
end

function YAK_SUBJECT:RegisterObserver(obs)
   -- shouldn't be able to register twice
   local found = false
   for k,v in self.Observers do
      if v == obs then
	 found = true
      end
   end
   if not found then
      table.insert(self.Observers, obs)
   end
end

function YAK_SUBJECT:UnregisterObserver(obs)
   --find index
   local index = -1
   for k,v in self.Observers do
      if v == obs then
	 index = k
      end
   end
   if index ~= -1 then
      table.remove( self.Observers, index )
   end
end

function YAK_SUBJECT:NotifyObservers(event)
   for k,v in self.Observers do
      v:OnSubjectChange(self, event)
   end
end

YAK_OBSERVER = {}

function YAK_OBSERVER:Create()
   local result = {}
   setmetatable( result, self )
   self.__index = self
   return result
end

function YAK_OBSERVER:OnSubjectChange( subject, event )
end

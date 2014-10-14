-- Wrapper around a census entity (so that users dont change it)

local Entity = {}; 

function Entity:new(type,family,name,entity)
   local obj = { 
      type=type,
      family=family,
      name=name,
      data=entity 
   };
   setmetatable(obj, { __index = self });
   return obj;
end

function Entity:GetType()
   return self.type;
end

function Entity:GetFamily()
   return self.family;
end

function Entity:GetName()
   return self.name;
end

function Entity:GetLevel()
   return self.data.level;
end

function Entity:GetLocation(zone)
   return self.data["loc_" .. zone];
end

function TargetCensus.internal.MakeEntity(type,family,name,entity)
   if (not entity) then
      return nil;
   end
   return Entity:new(type,family,name,entity);
end

-- Miscellaneous helper functions

function yak_print( msg )
   DEFAULT_CHAT_FRAME:AddMessage( tostring(msg) )
end

function yak_print_table( t )
   -- very juvenile print-each-item implementation
   for k,v in t do
      yak_print(k .. "->" ..tostring(v))
   end
end

function yak_string_split(s)   
   local result={}
   for match in string.gfind(s, "[^%s]+" ) do
      table.insert(result,match)
   end
   return result
end

function yak_console_command_string(msg)
   -- returns the "second command" and a table of arguments.  Does not
   -- handle quoted strings or spaces within an argument (spaces separate
   -- arguments).  Ie yak_console_command_string("/mymod command arg1 arg2")
   -- would return "command" as its first return value and {"arg1","arg2"} as
   -- its second return value.
   local commandlist = yak_string_split(msg)
   local command = commandlist[1]
   table.remove(commandlist, 1)
   return command, commandlist
end

YAK_LOGGER = {}

function YAK_LOGGER:Create( log_status, text_color )
   -- text color is a triplet table, ie {1,0,0} for red, etc
   local log_status = log_status or false
   local text_color = text_color or { 1,1,1 }
   local result = { log=log_status, chatframe=DEFAULT_CHAT_FRAME, color=text_color }
   setmetatable( result, self )
   self.__index = self
   return result
end

function YAK_LOGGER:SetLog( log_status )
   self.log = log_status
end

function YAK_LOGGER:Log(msg)
   if self.log then
      self.chatframe:AddMessage(msg, self.color[1], self.color[2], self.color[3] )
   end
end

function yak_PlayerIsSolo()
   return (GetNumPartyMembers() == 0) and not yak_PlayerIsInRaid()
end

function yak_PlayerIsInGroup()
   -- returns FALSE if player is in a raid!
   return ((not yak_PlayerIsInRaid()) and (GetNumPartyMembers() > 0))
end

function yak_PlayerIsInRaid()
   return (GetNumRaidMembers() > 0)
end

function yak_BuffsMatchPattern(unit,p)
   --thanks for hint from Gello of Underhill for this idea
   local f,b 
   for i=1,24 do 
      b=UnitBuff(unit,i) or "" 
      f=f or strfind(b,p)
   end 
   if f then
      return true
   end
end

function yak_DebuffsMatchPattern(unit,p)
   --thanks for hint from Gello of Underhill for this idea
   local f,b 
   for i=1,16 do 
      b=UnitDebuff(unit,i) or "" 
      f=f or strfind(b,p)
   end 
   if f then
      return true
   end
end

function yak_NamedUnitIsInRaid(name, checkpets)
   for k,v in yak_eachRaidID() do
      if UnitName(v) == name then
	 return true
      end
   end
   if checkpets then
      for k,v in yak_eachRaidPetID() do
	 if UnitName(v) == name then
	    return true
	 end
      end
   end
   return false
end

function yak_IdOfUnitInRaid( name )
   for k,v in yak_eachRaidID() do
      if UnitName(v) == name then
	 return v
      end
   end
   return nil
end

function yak_NamedUnitIsInParty(name, checkpets)
   for k,v in yak_eachPartyID() do
      if UnitName(v) == name then
	 return true
      end
   end
   if checkpets then
      for k,v in yak_eachPartyPetID() do
	 if UnitName(v) == name then
	    return true
	 end
      end
   end
   return false
end

function yak_IdOfUnitInParty( name )
   for k,v in yak_eachPartyID() do
      if UnitName(v) == name then
	 return v
      end
   end
   return nil
end
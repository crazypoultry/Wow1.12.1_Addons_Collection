-- Creates a scheduler class, for "cron" and "at"-like functionality
-- Going to handle "at" first.  But the basic idea holds

YAK_SCHEDULER = {}

function YAK_SCHEDULER:Create()
   result = {at_queue = {}, cron_queue = {}, last_purged = 0, log = YAK_LOGGER:Create(), last_check = 0, granularity = 0.25, now = 0}
   setmetatable(result, self)
   self.__index = self
--   result.log:SetLog(true)
   return result
end

function YAK_SCHEDULER:SetGranularity( new_value )
   self.granularity = new_value
end

function YAK_SCHEDULER:OnUpdate()
   self.now = GetTime()
   if (self.now - self.last_check) > self.granularity then
      if table.getn(self.at_queue) > 0 then
	 self:UpdateAtQueue(self.now)
      end
      self:UpdateCronQueue(self.now)
      self.last_check = self.now
   end
end

function YAK_SCHEDULER:UpdateAtQueue( now )
   -- the "at queue" is a table holding {at_time, id, closure, done} tuples indexed
   -- by integer
   for k,v in ipairs(self.at_queue) do
      if now > v[1] and (v[4] == false) then
--         self.log:Log("Doing at-job " .. v[2])
         v[3]()
	 v[4] = true
      end
   end
   if (now > (self.last_purged + 60)) or (table.getn(self.at_queue) > 60) then
      self:PurgeDoneJobs()
      self.last_purged = now
   end
end

function YAK_SCHEDULER:PurgeDoneJobs()
   local tasks_to_keep = {}
   for k,v in ipairs( self.at_queue ) do
      if v[4] == false then
	 table.insert(tasks_to_keep,v)
      else
--	 self.log:Log("Purging task "..v[2])
      end
   end
   self.at_queue = tasks_to_keep
end

function YAK_SCHEDULER:UpdateCronQueue( now )
   for k,v in self.cron_queue do
      if v[2] < now then
--	 self.log:Log("Doing cron-job " .. k )
	 v[3]()
	 v[2] = now + v[1]
      end
   end
end

function YAK_SCHEDULER:At(time, id, closure)
   table.insert( self.at_queue, {time, id, closure, false} )
end

function YAK_SCHEDULER:In( dt, id, closure )
--   self.log:Log("Time" .. GetTime().."; Adding at-job " .. id.. " at "..GetTime()+dt)
--   self.log:Log(table.getn(self.at_queue) .. "job in queue")
   table.insert( self.at_queue, {GetTime()+dt, id, closure, false} )
end

function YAK_SCHEDULER:Every( dt, id, closure )
   self.cron_queue[id] = {dt, GetTime()+dt, closure}
end

function YAK_SCHEDULER:SetCronDelay(id, new_dt)
   self.cron_queue[id][1] = new_dt
end

function YAK_SCHEDULER:RemoveCronJob(id)
   table.remove(self.cron_queue, id)
end

YakScheduler = YAK_SCHEDULER:Create()

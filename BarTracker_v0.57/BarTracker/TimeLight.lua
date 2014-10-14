--[[
--
--	TimeLight - Toolkit
--	by Dust of Turalyon
--
--]]

TimeLight_Schedule = function (delay, id, func, arg, reschedule)
	local timeNow = GetTime();
	local timeFire = timeNow + delay;
	local event = {
		[1] = timeFire,
		[2] = id,
		[3] = func,
		[4] = arg,
		[5] = delay,
		[6] = reschedule};
	TimeLight_ScheduleEvent(event);
end;

TimeLight_ScheduleEvent = function (event)
	TimeLight_UnscheduleByEvent(event);
	-- Could be done faster with binary search, since the list is sorted
	local i = 1;
	while TimeLight_ListByDelay[i] and TimeLight_ListByDelay[i][1] < event[1] do
		i = i + 1;
	end;
	table.insert(TimeLight_ListByDelay, i, event);
	return event;
end;

TimeLight_Unschedule = function (id)
	local typeString = type(id);
	if typeString == "string" then TimeLight_UnscheduleByName(id);
	elseif typeString == "table" then TimeLight_UnscheduleByEvent(id);
	end;
end;
		
TimeLight_UnscheduleByName = function (id)
	local i = 1;
	while TimeLight_ListByDelay[i] and TimeLight_ListByDelay[i][2] ~= id do
		i = i + 1;
	end;
	if TimeLight_ListByDelay[i] then
		table.remove(TimeLight_ListByDelay, i);
	end;
end;

TimeLight_UnscheduleByEvent = function (event)
	TimeLight_UnscheduleByName(event[2]);
end;

TimeLight_Run = function (event)
	event[3](event[4]);
	TimeLight_UnscheduleByEvent(event);
	if event[6] then
		event[1] = GetTime() + event[5];
		TimeLight_ScheduleEvent(event);
	end;
end;

TimeLight_ListByDelay = {};

TimeLight_OnLoad = function ()

end;

TimeLight_OnUpdate = function (delta)
	local timeNow = GetTime();
	for i, event in TimeLight_ListByDelay do
		if event[1] < timeNow then
			TimeLight_Run(TimeLight_ListByDelay[i])
		else
			return
		end;
	end;
end;

TimeLight_OnEvent = function ()
	
end;

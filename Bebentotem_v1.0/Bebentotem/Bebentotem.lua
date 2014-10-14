function Bebentotem_OnLoad()
	this:RegisterEvent("CHAT_MSG_SPELL_HOSTILEPLAYER_BUFF");
	this:RegisterEvent("CHAT_MSG_SPELL_SELF_BUFF");
end

function Bebentotem_OnEvent()
	if (event == "CHAT_MSG_SPELL_HOSTILEPLAYER_BUFF") then
		for mob, spell in string.gfind(arg1, BT_BEGIN) do
			if (Bebentotem_isParty(mob)) then
				if (arg1) then
					if ( string.ends(arg1,BT_TREMOR) ) then
					Bebentotem_Message(arg1);
					Bebentotem_Unschedule();
					Chronos.schedule(2, Bebentotem_Tick);
					Chronos.scheduleByName("u", 75, Bebentotem_Unschedule);
					end
				end
			end			
		end
	elseif (event == "CHAT_MSG_SPELL_SELF_BUFF") then
		if (arg1) then
			if ( string.ends(arg1,BT_TREMOR) ) then
			Bebentotem_Unschedule();
			Chronos.scheduleByName("w", 105, Bebentotem_Message, BT_WARNING);
			Chronos.scheduleByName("z", 120, Bebentotem_Message, BT_EXPIRE);
			end
		end
	end

end

function Bebentotem_Tick()
Bebentotem_Message("tick");
Chronos.scheduleByName("a", 1, Bebentotem_Message, "1");
Chronos.scheduleByName("b", 2, Bebentotem_Message, "2");
Chronos.scheduleByName("c", 3, Bebentotem_Message, "3");
Chronos.scheduleByName("d", 4, Bebentotem_Tick);
end

function Bebentotem_Unschedule()
Chronos.unscheduleByName("a");
Chronos.unscheduleByName("b");
Chronos.unscheduleByName("c");
Chronos.unscheduleByName("d");
Chronos.unscheduleByName("u");
end

function Bebentotem_Message(msg)
BebenFrame:AddMessage(msg, 70, 70, 70, 1, 4);
end

function Bebentotem_isParty(name)
	for i = 1, 4, 1 do
		local partyname = UnitName("party" .. i);
		if (name == partyname) then
			return 1;
		end
	end
	return nil;
end

function string.ends(String,End)
      return End=='' or string.sub(String,-string.len(End))==End
end
-- AutoGrats by Krod
--
-- version  2.0
-- Date   11.10.2005
--
-- Comments to: ram@catsec.com
--
-- Sends automatic congrats messages when a guild member dings...

function AG_OnLoad()
	this:RegisterEvent("GUILD_ROSTER_UPDATE");
	this:RegisterEvent("CHAT_MSG_GUILD");
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("CHAT_MSG_CHANNEL"); 
	this:RegisterEvent("CHAT_MSG_SYSTEM");
end

function AG_OnEvent(event)
	if (event == "VARIABLES_LOADED")then AG_Init();
	elseif (AGenabled and event == "CHAT_MSG_GUILD" ) then AG_GuildText(arg1, arg2, arg3);
	elseif (event == "GUILD_ROSTER_UPDATE")then AG_GotRoster();
	end
	if (AGtimer) then
		AG_CheckDelayedMsg();
	end
end

function AG_Init()
	Agwho=false;
	AGding=false;
	Agtimer=nil;
	SlashCmdList["autograts"] = AG_Cmd;
	SLASH_autograts1 = "/grats";
	if (AGenabled==nil) then
		AGenabled=true;
	end
	AG_Print("Autograts by Krod, type: /grats help for more information");
	if (AGenabled) then
		AG_Print("Autograts by Krod: Enabled");
	else
		AG_Print("Autograts by Krod: Disabled");
	end
	if (AGgrats==nil) then
		AG_Reset();
	end
	if (AGplayers==nil) then
		AGplayers={};
		AG_CmdWho();
	end
	if (AGnicks==nil) then
		AGnicks={};
	end
	AG_Version();
end

function AG_Version()
	if (AGversion==nil) then
		AGversion=2.0;
	end
end

function AG_GuildText(m,w,l)
	local m=" "..string.lower(string.gsub(m,"%p+","")).." "
	if ((string.find(m,"%sding%s") or string.find(m,"%sdinged%s")) and w~=UnitName("player")) then
		AGdinger=w;
		AGlang=l;
		AGding=true;
		AGwho=false;
		GuildRoster();
	end
end

function AG_Cmd(m)
	if (not m or m=="") then
		m="help";
	end
	local arg1,arg2,arg3,arg4=AG_Spliter(m);
	local i;
	if (arg1=="off") then AG_CmdOff();
	elseif (arg1=="on") then AG_CmdOn();
	elseif (arg1=="players") then AG_CmdPlayers();
	elseif (arg1=="who") then AG_CmdWho();
	elseif (arg1=="list") then AG_CmdList();
	elseif (arg1=="reset") then AG_CmdReset();
	elseif (arg1=="nick") then AG_CmdNick(arg2,arg3);
	elseif (arg1=="remove") then AG_CmdRemove(arg2);
	elseif (arg1=="add") then AG_CmdAdd(arg2,arg3,arg4);
	elseif (arg1=="op") then AG_showOptions();
	else AG_CmdHelp();
	end
end

function AG_CmdOff()
	AGenabled=false;
	AG_Print("Autograts Disabled");
end

function AG_CmdOn()
	AGenabled=true;
	AG_Print("Autograts Enabled")
end

function AG_CmdPlayers()
	AG_Print("Registered players:");
	table.foreach(AGplayers,function(i,l) AG_Print(i.."  ("..l..")") end);
end

function AG_CmdWho()
		AGwho=true;
		AGding=false;
		if (GetGuildRosterShowOffline()) then
			AGshowoffline=true;
		else
			AGshowoffline=false;
		end
		SetGuildRosterShowOffline(true);
		GuildRoster();
end

function AG_CmdList()
	AG_Print("Showing grats list");
	if (AGgrats) then
		for i=1,table.getn(AGgrats),1 do
			AG_Print(i..". Level range: "..AGgrats[i][1].." - "..AGgrats[i][2].." : "..AGgrats[i][3]);
		end
	else
		AG_Print("***Empty***");
	end
end

function AG_CmdReset()
	AG_Print("Reseting all grats to defaults");
	AGgrats=nil;
	AG_Reset();
end

function AG_CmdNick(a1,a2)
	if (a1) then
		if (a1=="clear") then
			AGnicks={};
			AG_Print("All nicknames cleared");
		elseif (a1=="list") then
			AG_Print("Nicknames:");
			table.foreach(AGnicks,function(p,n) AG_Print("Player: "..p.." is nicknamed: '"..n.."'.") end);
		elseif (a2) then
			a1=string.gsub(a1, "%l", string.upper, 1)
			a2=string.gsub(a2, "%l", string.upper, 1)
			AGnicks[a1]=a2;
			AG_Print("Player: "..a1.." is now nicknamed: '"..a2.."'.");
		else
			if (AGnicks[a1]) then
				AGnicks[a1]=nil;
				AG_Print("Removed nickname for: "..a1..".");
			else
				AG_Print("Couldn't remove nickname for: "..a1..", Player not found.");
			end
		end
	else
		AG_Print("Syntax Error, use /grats nick {clear/list/<player name>}");
	end
end

function AG_CmdRemove(a)
	if (a) then
		if (a=="all") then
			AGgrats=nil;
			AG_Print("All grats removed");
		else
			local ln=tonumber(a);
			if (AGgrats[ln]) then
				table.remove(AGgrats,ln);
				AG_Print("Removed Line: "..ln);
			else
				AG_Print("No such line");
			end
		end
	else
		AG_Print("syntax error: use /grats remove {all/<line number>}");
	end
end

function AG_CmdAdd(a1,a2,a3)
	local e=nil;
	if (a1 and a2 and a3) then
		local low=tonumber(a1);
		if (low<1 or low>60) then
			e="lower level out of range. ";
		end
		if (AGgrats) then
			for i=1,table.getn(AGgrats) do
				if (low>=AGgrats[i][1] and low<=AGgrats[i][2]) then
					e="lower level conflicts with another message (line"..i.."). ";
				end
			end
		end
		local high=tonumber(a2);
		if (high<1 or high>60 or high<low) then
			e=e.."high level out of range.";
		end
		if (AGgrats) then
			for i=1,table.getn(AGgrats) do
				if (high>=AGgrats[i][1] and high<=AGgrats[i][2]) then
					e=e.."high level collides with another message (line"..i..")";
				end
			end
		end
		if (not e) then
			local p=1;
			AG_Print("Adding: "..low.."-"..high.." : "..a3);
			if (AGgrats) then
				for i=1,table.getn(AGgrats) do
					if (low>AGgrats[i][1]) then
						p=i;
					end
				end
				if (p==table.getn(AGgrats)) then
					table.insert(AGgrats,{low,high,a3});
				else
					table.insert(AGgrats,p,{low,high,a3});
				end
			else
				AGgrats={[1]={low,high,a3}};
			end

		else
			AG_Print("syntax error: "..e);
		end
	else
		AG_Print("syntax error: use /grats add {low} {high} {message}");
	end
end

function AG_CmdHelp()
	AG_Print("/grats on - turns autograts on");
	AG_Print("/grats off - turns autograts off");
	AG_Print("/grats players - list all known players");
	AG_Print("/grats list - list all messages");
	AG_Print("/grats reset - reset messages to the default ones");
	AG_Print("/grats remove all - removes all messages");
	AG_Print("/grats remove <line> - removes the specified message line");
	AG_Print("/grats who - shows you all guild members who leveled since you were last online");
	AG_Print("/grats nick <player> <nickname> - sets the <nickname> for <player>");
	AG_Print("/grats nick list - lists all nicknames");
	AG_Print("/grats nick clear - clears all nicknames");
	AG_Print("/grats nick {player} - clears the nickname for {player}");
	AG_Print("/grats add <low> <high> <message> - adds a message for the specified level range:");
	AG_Print("    in <message> the following will be replaced by autograts:");
	AG_Print("    @c will be replaced by the player who dinged Class");
	AG_Print("    @p will be replaced by the player who dinged Name or nickname");
	AG_Print("    @l will be replaced by the player who dinged Level");
	AG_Print("    @t will be replaced by number of levels left till 60");
	AG_Print("example: /grats add 1 60 Woohoo @p you are a great @c. will yield: 'Woohoo Krod you are a great Hunter'");
end

function AG_Print(out)
	DEFAULT_CHAT_FRAME:AddMessage(out,0.5,1,1);
end

function AG_GetInfo(p)
	 local g = GetNumGuildMembers();
	 local i;
	 for i=1,g do
			local name, rank, rankIndex, level, class, zone, group, note, officernote, online = GetGuildRosterInfo(i);
			if (name == p) then
				return level,class;
			end
	 end
	 return 0, "none";
end

function AG_GotRoster()
	if (AGwho) then
		AG_Who();
	elseif (AGding) then
		AG_Ding();
	end
end

function AG_GetMsg(lvl)
	if (AGgrats==nil) then
		return nil;
	end
	local i;
	for i=1,table.getn(AGgrats),1 do
		local low=AGgrats[i][1];
		local high=AGgrats[i][2];
		if (lvl>=low and lvl<=high) then
			return i;
		end
	end
	return nil;
end

function AG_Spliter(s)
	local t = {};
	local a,b,c,d;
	for w in string.gfind(s, "%S+") do
		table.insert(t,w)
	end
	if t[1] then
		a=string.lower(t[1]);
	end
	if t[2] then
		b=string.lower(t[2]);
	end
	if t[3] then
		c=string.lower(t[3]);
	end
	if t[4] then
		d=table.concat(t," ",4);
	end
	return a,b,c,d;
end

function AG_Reset()
	AGgrats={
	[1]={1,9,"*cough* Well.. Hmm.. grats I guess. Surely you're the mightiest @c in the world."},
	[2]={10,49,"Grats @p, only @t to go :-)"},
	[3]={50,59,"WOW! Grats @p, only @t to go ... almost there!"},
	[4]={60,60,"WOW! @p, you're 60!!! that calls for a party!"},
	}
end

function AG_Who()
	AGwho=false;
	local g = GetNumGuildMembers();
	local i;
	local f=false;
	for i=1,g do
		local name, rank, rankIndex, level, class, zone, group, note, officernote, online = GetGuildRosterInfo(i);
		if (AGplayers[name]==nil) then
			AG_Print("Added "..name.." to your guild list");
			AGplayers[name]=level;
			f=true;
		elseif (AGplayers[name]~=level) then
			AGplayers[name]=level;
			f=true;
			AG_Print(name.." had leveled since you were last online. ("..level..").");
		end
	end
	if (not f) then
		AG_Print("No online guild member had leveled since you were last online.");
	end
	if(AGplayers) then
		table.sort(AGplayers);
	end
	SetGuildRosterShowOffline(AGshowoffline);
end

function AG_Ding()
	AGding=false;
	local l,c=AG_GetInfo(AGdinger);
	local t=60-l;
	local s;
	local m=AG_GetMsg(l);
	if (AGplayers[AGdinger]~=l) then
		if (m) then
			local s=AGgrats[m][3];
			if (AGnicks[AGdinger]) then
				s=string.gsub(s,"@p",AGnicks[AGdinger]);
			else
				s=string.gsub(s,"@p",AGdinger);
			end
			s=string.gsub(s,"@l",l);
			s=string.gsub(s,"@t",t);
			s=string.gsub(s,"@c",c);
			AG_SendDelayedMsg(s, "GUILD", AGlang,5);
		else
			AG_SendDelayedMsg("Grats!", "GUILD", AGlang,5);
		end
		AGplayers[AGdinger]=l;
	end
end

function AG_SendDelayedMsg(m,c,l,d)
	AGtimer=GetTime();
	AGtimer=AGtimer+d;
	AGdmsg=m;
	AGdchn=c;
	AGdlng=l;
end

function AG_CheckDelayedMsg()
	if AGtimer<GetTime() then
		AGtimer=nil;
		SendChatMessage(AGdmsg, AGdchn, AGdlng);
	end
end

function AG_showOptions()
	local frame = getglobal("autogratsOptionsFrame");
	if (frame) then
		if(frame:IsVisible()) then
  		frame:Hide();
		else
  		frame:Show();
		end
	end
end
	
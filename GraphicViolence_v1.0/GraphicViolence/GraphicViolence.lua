GraphicViolence_DB={};
GraphicViolence_times={};

GraphicViolence_Moving=true;
GraphicViolence_PlotInProgress=false;
GraphicViolence_Filter=false;

GraphicViolence_MouseOnTooltip=false;

GraphicViolence_EventRetention=600; -- number of seconds to retain combat info

-- size of graph dots
pixelWidth=3;
pixelHeight=3;

GraphicViolence_Pixels={};
GraphicViolence_Pixels["DD"]={}; -- damage done
GraphicViolence_Pixels["DT"]={}; -- damage taken
GraphicViolence_Pixels["H"]={};  -- healing done
GraphicViolence_Pixels["HP"]={}; -- raid health%
GraphicViolence_Pixels["D"]={};  -- party/raid death events
GraphicViolence_Pixels["O"]={}; -- non-graphable events

GraphicViolence_CatFriendly={};
GraphicViolence_CatFriendly["DD"]="Damage Done";
GraphicViolence_CatFriendly["DT"]="Damage Taken";
GraphicViolence_CatFriendly["H"]="Healing Done";
GraphicViolence_CatFriendly["HP"]="Health";
GraphicViolence_CatFriendly["D"]="Player Deaths";
GraphicViolence_CatFriendly["O"]="Other Events";

if not GraphicViolence_StaticTop then GraphicViolence_StaticTop = 1000; end -- top damage displayed
GraphicViolence_StaticLow = 0; -- low damage displayed
	
GraphicViolence_lastGraph=time();
GraphicViolence_lastScan=time();
GraphicViolence_lastFade=time();

GraphicViolence_dragging=false;
GraphicViolence_dragRefX=0;
GraphicViolence_dragRefY=0;
GraphicViolence_dragSaveX=0;
GraphicViolence_dragSaveY=0;
GraphicViolence_dragX=0;
GraphicViolence_dragY=0;

GraphicViolence_resizing=false;

GraphicViolence_SyncTime=nil;
GraphicViolence_SyncMinute=nil;
GraphicViolence_SyncHour=nil;

function GraphicViolence_PlotPoints()
	if GraphicViolence_PlotInProgress then return end
	GraphicViolence_PlotInProgress=true;
	
	-- hide all graph pixels
	for pindex,pvalue in pairs(GraphicViolence_Pixels) do
		for pi,pv in pairs(pvalue) do
			pv:Hide();
		end
	end

	-- graph colors
	local pixelColors={};
	pixelColors["DD"]={0,0,1,0.4}; -- damage done: blue
	pixelColors["DT"]={1,0,0,0.4}; --  damage taken: red
	pixelColors["H"]={1,1,1,0.3}; -- healing done: white
	pixelColors["HP"]={0,1,0,0.4}; -- raid health: green
	pixelColors["D"]={1,1,0,0.4}; -- player death: yellow
	pixelColors["O"]={1,0.6,0,1}; -- nongraph events: orange
	

	
	-- number of graph dots that can fit horizontally in the frame
	numPixels=math.floor(GraphicViolence:GetWidth()/pixelWidth);
	
	GraphicViolence_topmark=GraphicViolence_StaticTop;
	GraphicViolence_lowmark=GraphicViolence_StaticLow;
	
	-- frame height
	local frameH=math.floor(((GraphicViolence:GetHeight()-49)+ 0.5) - pixelHeight);
	
	local damageDiff = GraphicViolence_topmark - GraphicViolence_lowmark
	local damageStep = frameH/damageDiff;

	local x,y = GetCursorPosition();
	if GraphicViolence_dragging then
		GraphicViolence_dragX=x-GraphicViolence_dragRefX;
		GraphicViolence_dragY=y-GraphicViolence_dragRefY;
	end
	
	-- delete to re-enable y-scrolling --
	GraphicViolence_dragY=0;
	GraphicViolence_dragSaveY=0;
	-------------------------------------
	
	if (GraphicViolence_StaticTop < 50) then
		GraphicViolence_StaticTop = 50;
		getglobal("GraphicViolence_Graph_YLabel"):SetText(GraphicViolence_StaticTop.."-")
	end

	if not GraphicViolence_SyncTime then GraphicViolence_PlotInProgress=false; return end
	if (GraphicViolence_dragSaveX) < 0 then GraphicViolence_dragSaveX=0; end
	local graphEndTime = math.floor(GetTime()+GraphicViolence_SyncTime) - (GraphicViolence_dragX + GraphicViolence_dragSaveX)/pixelWidth;

	
	local graphZeroTime = graphEndTime - numPixels;

	GraphicViolence_topmark = GraphicViolence_topmark - (GraphicViolence_dragY + GraphicViolence_dragSaveY)/damageStep;
	GraphicViolence_lowmark = GraphicViolence_topmark - damageDiff;

	for index,value in ipairs(GraphicViolence_times) do
		if GraphicViolence_DB[value] and value > (math.floor(GetTime()+GraphicViolence_SyncTime)-GraphicViolence_EventRetention) then
			for ind,val in pairs(GraphicViolence_DB[value]) do
			
				local filterDmg=GraphicViolence_DB[value][ind]["num"];
				if GraphicViolence_Filter and strlen(GraphicViolence_Select_Filter:GetText())>0 then
					filterDmg=GraphicViolence_DmgTotal(value,ind,GraphicViolence_Select_Filter:GetText());
					if filterDmg==0 then filterDmg=false; end
				end

				if filterDmg and (getglobal("GraphicViolence_Select_"..ind.."Check")==nil or getglobal("GraphicViolence_Select_"..ind.."Check"):GetChecked()==1) and value >= graphZeroTime and value <=graphEndTime then
					-- set x (seconds) and y (magnitude) for each category of combat info.
					local xpoint = math.floor((value - graphZeroTime) * pixelWidth);
					local ypoint = math.floor((filterDmg-GraphicViolence_lowmark)*(frameH/(GraphicViolence_topmark-GraphicViolence_lowmark)));
					if ypoint < pixelHeight then ypoint = pixelHeight end
					
					if ind=="D" then ypoint=0; end --set death event to Y-min;
					if ind=="O" then ypoint=-3; end --nongraphable events display on the bottom timeline bar
					-- for raid health scale the point to max at 100%
					-- if ind=="HP" then ypoint = math.floor(GraphicViolence_DB[value][ind]["num"]*(frameH/100)); end
					if ind=="HP" then ypoint = math.floor(filterDmg*(frameH/100)); end
					-- if scaling is fixed and the point is higher than the max, set it to the max
					if ypoint > frameH then ypoint = frameH end
					-- if the frame has already been created, reuse it
					
					if GraphicViolence_Pixels[ind][xpoint] then
						GraphicViolence_Pixels[ind][xpoint]:SetPoint("BOTTOMLEFT", "GraphicViolence_Graph",xpoint,0);
						GraphicViolence_Pixels[ind][xpoint]:Show();

						GraphicViolence_Pixels[ind][xpoint].frametime=GraphicViolence_times[index];
						
						GraphicViolence_Pixels[ind][xpoint]:SetHeight(ypoint);
						if ind=="HP" or ind=="O" then
							GraphicViolence_Pixels[ind][xpoint]:SetHeight(pixelHeight)
							GraphicViolence_Pixels[ind][xpoint]:SetPoint("BOTTOMLEFT", "GraphicViolence_Graph", "BOTTOMLEFT" , xpoint, ypoint);
						end
						if ind=="D" then GraphicViolence_Pixels[ind][xpoint]:SetHeight(GraphicViolence_Graph:GetHeight()); end
					-- otherwise create the frame for that x-value and category
					else
						local f = CreateFrame("Frame",nil,GraphicViolence_Graph)
						f:SetWidth(pixelWidth);
						f:SetHeight(ypoint);
						if ind=="D" then f:SetHeight(GraphicViolence_Graph:GetHeight()); end
						if ind=="HP" then f:SetHeight(pixelHeight) end

						f:EnableMouse(true);

						f.frametime=GraphicViolence_times[index];
						f.frametype=ind;

						f:SetScript("OnEnter", function() GraphicViolence_Moving=false; GraphicViolence_PrintEvents(this.frametime,this.frametype) end)
						f:SetScript("OnLeave", function() GraphicViolence_Moving=true; if not GraphicViolence_MouseOnTooltip then GraphicViolence_Tip:Hide(); end  end)

						local t = f:CreateTexture(nil,"BACKGROUND")
						t:SetBlendMode("BLEND");
						t:SetTexture(pixelColors[ind][1],pixelColors[ind][2],pixelColors[ind][3],pixelColors[ind][4]);

						t:SetAllPoints(f);
						
						f:SetPoint("BOTTOMLEFT", "GraphicViolence_Graph", "BOTTOMLEFT" , xpoint, 0);
						if ind=="HP" then f:SetPoint("BOTTOMLEFT", "GraphicViolence_Graph", "BOTTOMLEFT" , xpoint, ypoint); end
						f:Show();
						GraphicViolence_Pixels[ind][xpoint] = f;
					end	
				end
			end
		else
			table.remove(GraphicViolence_times,index);
			GraphicViolence_DB[value]=nil;
		end
	end
	GraphicViolence_PlotInProgress=false;
end

function GraphicViolence_OnEvent()
	if (event=="VARIABLES_LOADED") then
		if not GraphicViolence_DB then GraphicViolence_DB={}; end
		GraphicViolence_Graph_YLabel:SetText(GraphicViolence_StaticTop.."-");

	elseif (event=="UNIT_HEALTH") then
		local idnumber = arg1;
		if string.find(idnumber,"raid") and idnumber~="target" and UnitIsDeadOrGhost(idnumber) then
			local confirmDead=false;
			if GetNumRaidMembers()>0 and UnitInRaid(arg1) then
				local name, rank, subgroup, level, class, fileName, zone, online, isDead = GetRaidRosterInfo(tonumber(string.sub(idnumber,5)));
				if isDead then confirmDead=true; end
			else
				confirmDead=true;
			end
			if confirmDead then
				local updateTime=time();

				local mtime=GetTime();
				if not GraphicViolence_SyncTime then return end
				updateTime = math.floor(mtime + GraphicViolence_SyncTime);

	
				if not GraphicViolence_DB[updateTime] then GraphicViolence_DB[updateTime] = {}; end
				if not GraphicViolence_DB[updateTime]["D"] then GraphicViolence_DB[updateTime]["D"] = {}; end
				if not GraphicViolence_DB[updateTime]["D"]["evt"] then GraphicViolence_DB[updateTime]["D"]["evt"] = {}; end
				if not GraphicViolence_DB[updateTime]["D"]["dmg"] then GraphicViolence_DB[updateTime]["D"]["dmg"] = {}; end
				if not GraphicViolence_DB[updateTime]["D"]["time"] then GraphicViolence_DB[updateTime]["D"]["time"] = {}; end
				
				table.insert(GraphicViolence_DB[updateTime]["D"]["evt"],UnitName(idnumber).." died.");
				table.insert(GraphicViolence_DB[updateTime]["D"]["dmg"],1);
				table.insert(GraphicViolence_DB[updateTime]["D"]["time"],mtime);
				
				GraphicViolence_DB[updateTime]["D"]["num"]=table.getn(GraphicViolence_DB[updateTime]["D"]["evt"]);
				
				
			end
			
		end
	elseif (GraphicViolence_DB) then
		GraphicViolence_ParseMessage(arg1, event, arg2)
	end

end

function GraphicViolence_OnUpdate()
	local updateTime=time();

	if not GraphicViolence_SyncTime then
		GraphicViolence_Tabs_Time:SetText("Syncing Time");
	end
	local hour,minute=GetGameTime();
	if GraphicViolence_SyncMinute ~= minute then
		local timetable=date("*t");
		timetable["hour"]=hour;
		timetable["min"]=minute;
		timetable["sec"]=0;
		GraphicViolence_SyncTime=time(timetable)-GetTime();
		GraphicViolence_SyncMinute = minute;
		GraphicViolence_lastGraph = math.floor(GetTime() + GraphicViolence_SyncTime);
	end
	

	if not GraphicViolence_SyncTime then return end
	updateTime = math.floor(GetTime() + GraphicViolence_SyncTime);

	GraphicViolence_Tabs_Time:SetText(date("%I:%M:%S",updateTime));
	
	-- plot points
	if GraphicViolence_times and table.getn(GraphicViolence_times)>0 and updateTime >= GraphicViolence_lastGraph+1 and GraphicViolence_Moving and GraphicViolence_Graph:IsVisible() then
		GraphicViolence_PlotPoints();
		GraphicViolence_lastGraph = updateTime;
	elseif GraphicViolence_times and table.getn(GraphicViolence_times)>0 and (GraphicViolence_dragging or GraphicViolence_resizing) then
		GraphicViolence_PlotPoints();
		GraphicViolence_lastGraph = updateTime;
	end
	
	-- add raid health info to database
	local rm=GetNumRaidMembers();
	local pm=GetNumPartyMembers();
	if updateTime >= GraphicViolence_lastScan+1 and not GraphicViolence_DB[updateTime] then
		-- local health=0;
		-- local healthmax=0;
		local healthpercent=nil;
		local playername=nil;
		-- local grouptype=nil;
		if (rm>0) then
			-- grouptype="Raid";
			for r=1,rm do
				-- health=health+UnitHealth("raid"..r);
				-- healthmax=healthmax+UnitHealthMax("raid"..r);
				healthpercent=math.floor((UnitHealth("raid"..r)/UnitHealthMax("raid"..r))*100);
				if healthpercent>100 then healthpercent=100 end
				if (UnitIsUnit("player","raid"..r)) then playername="You" else playername=UnitName("raid"..r) end
				GraphicViolence_AddCombatInfo("HP", healthpercent, playername..": "..healthpercent.."%.");
			end
		elseif (pm>0) then
			-- grouptype="Party";
			-- health=UnitHealth("player");
			-- healthmax=UnitHealthMax("player");
			healthpercent=math.floor((UnitHealth("player")/UnitHealthMax("player"))*100);
			if healthpercent>100 then healthpercent=100 end
			GraphicViolence_AddCombatInfo("HP", healthpercent, "You: "..healthpercent.."%.");
			for p=1,pm do
				healthpercent=math.floor((UnitHealth("party"..p)/UnitHealthMax("party"..p))*100);
				if healthpercent>100 then healthpercent=100 end
				GraphicViolence_AddCombatInfo("HP", healthpercent, UnitName("party"..p)..": "..healthpercent.."%.");
			end
		else
			--bgrouptype="Player";
			--health=UnitHealth("player");
			--healthmax=UnitHealthMax("player");\
			healthpercent=math.floor((UnitHealth("player")/UnitHealthMax("player"))*100);
			if healthpercent>100 then healthpercent=100 end
			GraphicViolence_AddCombatInfo("HP", healthpercent, "You: "..healthpercent.."%.");
			
		end
		
		GraphicViolence_DB[updateTime]["HP"]["num"]=GraphicViolence_DmgTotal(updateTime,"HP");
		
		-- local hp=math.floor((health/healthmax)*100);
		-- if hp>100 then hp=100 end
		--if not GraphicViolence_DB[updateTime] then GraphicViolence_DB[updateTime] = {}; end
		--if not GraphicViolence_DB[updateTime]["HP"] then GraphicViolence_DB[updateTime]["HP"] = {}; end
		--if not GraphicViolence_DB[updateTime]["HP"]["evt"] then GraphicViolence_DB[updateTime]["HP"]["evt"] = {}; end
		
		-- GraphicViolence_DB[updateTime]["HP"]["num"]=hp;
		-- table.insert(GraphicViolence_DB[updateTime]["HP"]["evt"],grouptype.." Health: "..hp.."%");
		
		-- if not GraphicViolence_TimeSet(updateTime) then table.insert(GraphicViolence_times,updateTime); end

	end
		GraphicViolence_lastScan=updateTime;
end

function GraphicViolence_TimeSet(num)
	for index,value in ipairs(GraphicViolence_times) do
		if value==num then return true end
	end
	return false
end

function GraphicViolence_AddCombatInfo(evtype, evnum, evtext)
	if not evtype or not evnum or not evtext or not GraphicViolence_SyncTime then return end;
	
	local mtime=GetTime();
	local curtime=math.floor(mtime + GraphicViolence_SyncTime);

	evnum=tonumber(evnum);

	if not  GraphicViolence_DB[curtime] then
		GraphicViolence_DB[curtime]={};
	end
	if not GraphicViolence_DB[curtime][evtype] then
		GraphicViolence_DB[curtime][evtype] = {};
	end
	if not GraphicViolence_DB[curtime][evtype]["num"] then
		GraphicViolence_DB[curtime][evtype]["num"]=evnum;
	elseif(evtype=="HP") then
		local entries = 0;
		if (GraphicViolence_DB[curtime][evtype]["dmg"] and table.getn(GraphicViolence_DB[curtime][evtype]["dmg"])>0) then
			entries = table.getn(GraphicViolence_DB[curtime][evtype]["dmg"])
		end
		if (entries>0) then
			GraphicViolence_DB[curtime][evtype]["num"] = math.floor(((GraphicViolence_DB[curtime][evtype]["num"]*entries)+evnum)/(entries+1) +0.5);
			if GraphicViolence_DB[curtime][evtype]["num"]>100 then GraphicViolence_DB[curtime][evtype]["num"]=100 end
		else
			GraphicViolence_DB[curtime][evtype]["num"]=evnum;
			if GraphicViolence_DB[curtime][evtype]["num"]>100 then GraphicViolence_DB[curtime][evtype]["num"]=100 end
		end
		
	else
		GraphicViolence_DB[curtime][evtype]["num"]=GraphicViolence_DB[curtime][evtype]["num"]+evnum;
	end
	if not GraphicViolence_DB[curtime][evtype]["evt"] then
		GraphicViolence_DB[curtime][evtype]["evt"]={};
	end
	if not GraphicViolence_DB[curtime][evtype]["dmg"] then
		GraphicViolence_DB[curtime][evtype]["dmg"]={};
	end
	-- sync test -------
	if not GraphicViolence_DB[curtime][evtype]["time"] then
		GraphicViolence_DB[curtime][evtype]["time"]={};
	end
	table.insert(GraphicViolence_DB[curtime][evtype]["time"],mtime);
	--------------------
	table.insert(GraphicViolence_DB[curtime][evtype]["evt"],evtext);
	table.insert(GraphicViolence_DB[curtime][evtype]["dmg"],evnum);

	if not GraphicViolence_TimeSet(curtime) then table.insert(GraphicViolence_times,curtime); end
end

function GraphicViolence_Reset()
	GraphicViolence_DB={};
	GraphicViolence_times={};
	
	GraphicViolence_dragSaveX=0;
	GraphicViolence_dragSaveY=0;
	
	GraphicViolence_StaticTop = 1000;
	GraphicViolence_StaticLow = 0;
	
	getglobal("GraphicViolence_Graph_YLabel"):SetText(GraphicViolence_StaticTop.."-");
	
	for index,value in pairs(GraphicViolence_Pixels) do
		for i,v in pairs(value) do
			v:Hide();
		end
	end
end

function GraphicViolence_PrintEvents(evtime,evtype)

	local evtlines="";
	local evtitle="";
	if GraphicViolence_DB and GraphicViolence_DB[evtime] and GraphicViolence_DB[evtime][evtype] and GraphicViolence_DB[evtime][evtype]["evt"] then
		for index,value in pairs(GraphicViolence_DB[evtime][evtype]["evt"]) do

			local filter=true
			if GraphicViolence_Filter and strlen(GraphicViolence_Select_Filter:GetText())>0 and ind~="HP" then
				if not string.find(string.upper(value),string.upper(GraphicViolence_Select_Filter:GetText())) then
					filter=false;
				end
			end
			if filter then
				if GraphicViolence_DB[evtime][evtype]["time"] and GraphicViolence_DB[evtime][evtype]["time"][index] and GraphicViolence_SyncTime then
					local mtime=GraphicViolence_DB[evtime][evtype]["time"][index];
					evtlines=evtlines..date("%S",math.floor(mtime+GraphicViolence_SyncTime)).."."..math.floor(100*(mtime-math.floor(mtime)))..": ";
				else
					evtlines=evtlines..index..". ";
				end
				evtlines=evtlines..value.."\n";
			end
		end
		local dmgtext="";
		if GraphicViolence_Filter and strlen(GraphicViolence_Select_Filter:GetText())>0 and evtype~="HP" then
			dmgtext=GraphicViolence_DmgTotal(evtime,evtype,GraphicViolence_Select_Filter:GetText());
		else
			dmgtext=GraphicViolence_DmgTotal(evtime,evtype);
		end
				
		evtitle=date("%I:%M:%S",evtime).." "..GraphicViolence_CatFriendly[evtype]..": "..dmgtext;
		if evtype=="HP" then evtitle=evtitle.."%" end

		GraphicViolence_Tip:SetPoint("CENTER", "UIParent", "CENTER");
		GraphicViolence_Tip_Title:SetText(evtitle);
		GraphicViolence_Tip_Text:SetText(evtlines);
		if GraphicViolence_Tip_Text:GetStringWidth()<300 and GraphicViolence_Tip_Title:GetStringWidth()<300 then
			if GraphicViolence_Tip_Text:GetStringWidth() > GraphicViolence_Tip_Title:GetStringWidth() then
				GraphicViolence_Tip:SetWidth(GraphicViolence_Tip_Text:GetStringWidth());
				GraphicViolence_Tip_Text:SetWidth(GraphicViolence_Tip_Text:GetStringWidth());
				GraphicViolence_Tip_Text:SetText(evtlines);
				GraphicViolence_Tip_Title:SetWidth(GraphicViolence_Tip_Text:GetStringWidth());
				GraphicViolence_Tip_Title:SetText(evtitle);
			else
				GraphicViolence_Tip:SetWidth(GraphicViolence_Tip_Title:GetStringWidth());
				GraphicViolence_Tip_Text:SetWidth(GraphicViolence_Tip_Title:GetStringWidth());
				GraphicViolence_Tip_Text:SetText(evtlines);
				GraphicViolence_Tip_Title:SetWidth(GraphicViolence_Tip_Title:GetStringWidth());
				GraphicViolence_Tip_Title:SetText(evtitle);
			end
		 else
			GraphicViolence_Tip:SetWidth(300);
			GraphicViolence_Tip_Title:SetWidth(300);
			GraphicViolence_Tip_Title:SetText(evtitle);
			GraphicViolence_Tip_Text:SetWidth(300);
			GraphicViolence_Tip_Text:SetText(evtlines);
		 end
		GraphicViolence_Tip:SetHeight(GraphicViolence_Tip_Text:GetHeight()+GraphicViolence_Tip_Title:GetHeight()+10);
		GraphicViolence_Tip:Show();
	end
end

function GraphicViolence_DmgTotal(sec,cat,filter)
	local dmg=0;
	local count=0;
	if not sec or not cat then return dmg end
	if GraphicViolence_DB and GraphicViolence_DB[sec] and GraphicViolence_DB[sec][cat] and GraphicViolence_DB[sec][cat]["dmg"] and GraphicViolence_DB[sec][cat]["evt"] then
		for i=1,table.getn(GraphicViolence_DB[sec][cat]["dmg"]) do
			if not filter or string.find(string.upper(GraphicViolence_DB[sec][cat]["evt"][i]),string.upper(filter)) then
				dmg=dmg+GraphicViolence_DB[sec][cat]["dmg"][i];
				count=count+1;
			end
		end
		if cat=="HP" then
			dmg=math.floor(dmg/count);
			if dmg>100 then dmg=100 end
		end
	end
	return dmg;
end

function GraphicViolence_Print(msg)
	if msg==true then msg="true";
	elseif msg==false then msg="false";
	elseif msg==nil then msg="nil";
	end
	DEFAULT_CHAT_FRAME:AddMessage(msg, 0.8, 0.8, 1);
end

function GraphicViolence_Announce(msg)
	UIErrorsFrame:AddMessage(msg, 1.0, 1.0, 0) 
end

function GraphicViolence_RegisterEvents()
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("UNIT_HEALTH"); -- unit health change

	-- NonGraphable combat messages:
	this:RegisterEvent("CHAT_MSG_MONSTER_EMOTE"); --  arg2+arg1 <Mob> becomes enraged! / is fully grown! etc
	this:RegisterEvent("CHAT_MSG_MONSTER_YELL"); --  (Feast upon <player>, my pretties!)
	this:RegisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH"); --  (<Mob> dies.)
	this:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF"); --  (<Mob> casts/performs/begins to cast <spell>., etc)
	this:RegisterEvent("CHAT_MSG_SPELL_BREAK_AURA (Gurubashi Blood"); --  Drinker's Polymorph: Pig is removed. / Your Venom Spit is removed. / Brewmasher's Dazed is removed. etc);
	this:RegisterEvent("CHAT_MSG_COMBAT_CREATURE_VS_CREATURE_MISSES"); --  dodges/parries/full absorbs/immune/etc
	this:RegisterEvent("CHAT_MSG_COMBAT_CREATURE_VS_PARTY_MISSES"); --  ''


	-- Messages to measure how much damage is dealt.
	this:RegisterEvent("CHAT_MSG_COMBAT_SELF_HITS");	-- Melee you do on things.
	this:RegisterEvent("CHAT_MSG_COMBAT_PET_HITS");		-- Melee your pets do.
	this:RegisterEvent("CHAT_MSG_COMBAT_PARTY_HITS");	-- Melee done by party.
	this:RegisterEvent("CHAT_MSG_COMBAT_FRIENDLYPLAYER_HITS");	-- Melee done by friendlies.
	this:RegisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE");	-- Your spells that damage other things.
	this:RegisterEvent("CHAT_MSG_SPELL_PET_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_PARTY_DAMAGE");	-- Party member's spell hits.
	this:RegisterEvent("CHAT_MSG_SPELL_FRIENDLYPLAYER_DAMAGE"); -- Spells other people cast on things.
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE"); -- Blah suffers # Arcane damage from #'s/your Spell.  Works on self, party, friendly.
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_DAMAGESHIELDS_ON_SELF");		-- Thorns on self.
	this:RegisterEvent("CHAT_MSG_SPELL_DAMAGESHIELDS_ON_OTHERS");	-- Thorns on others.

	-- Messages to measure healing done and received.
	this:RegisterEvent("CHAT_MSG_SPELL_SELF_BUFF");
	this:RegisterEvent("CHAT_MSG_SPELL_PARTY_BUFF");
	this:RegisterEvent("CHAT_MSG_SPELL_FRIENDLYPLAYER_BUFF");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_PARTY_BUFFS");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_BUFFS");
	this:RegisterEvent("CHAT_MSG_SPELL_HOSTILEPLAYER_BUFF");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_BUFFS");

	-- Messages to measure damage taken.
	this:RegisterEvent("CHAT_MSG_COMBAT_CREATURE_VS_SELF_HITS");-- [enemy] hits you/pet for [X]( [school] damage). (crushing/absorbed/etc))
	this:RegisterEvent("CHAT_MSG_COMBAT_CREATURE_VS_SELF_MISSES");
	this:RegisterEvent("CHAT_MSG_COMBAT_CREATURE_VS_PARTY_HITS"); -- "[enemy] hits [partym] for [X]( (crushing))( ([X] blocked).
	this:RegisterEvent("CHAT_MSG_COMBAT_CREATURE_VS_PARTY_MISSES");
	this:RegisterEvent("CHAT_MSG_COMBAT_CREATURE_VS_CREATURE_HITS"); -- [enemy] hits [friendly] for [X]( ([school] damage). (crushing/[X] blocked/absorbed etc)
	this:RegisterEvent("CHAT_MSG_COMBAT_CREATURE_VS_CREATURE_MISSES");
	this:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE");
		-- The HOSTILEPLAYER ones are for dueling and pvp.
	this:RegisterEvent("CHAT_MSG_COMBAT_HOSTILEPLAYER_HITS");
	this:RegisterEvent("CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE");

end

function GraphicViolence_ShowUI()
	GraphicViolence:Show();
end

function GraphicViolence_RegisterSlashCommands()	
	SlashCmdList["gvreset"] = GraphicViolence_Reset;
	SLASH_gvreset1 = "/gvreset";

	SlashCmdList["gvshow"] = GraphicViolence_ShowUI;
	SLASH_gvshow1 = "/gvshow";
end

function GraphicViolence_ParseMessage(evarg, event, evarg2)
	if not evarg or not event then return end
	if event=="CHAT_MSG_MONSTER_EMOTE" and evarg2 then evarg=evarg2.." "..evarg; end
	
	local unused1,unused2,damage;
	if evarg then unused1,unused2,damage = string.find(evarg,"^.-(%d+)"); else return end
	local graphable=false;
	
	if damage then
		-- DAMAGE DONE
		if (event == "CHAT_MSG_COMBAT_SELF_HITS"
			or event == "CHAT_MSG_SPELL_SELF_DAMAGE"
			or event == "CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE"
			or event == "CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE"
			or event == "CHAT_MSG_COMBAT_PARTY_HITS"
			or event == "CHAT_MSG_COMBAT_FRIENDLYPLAYER_HITS"
			or event == "CHAT_MSG_COMBAT_PET_HITS"
			or event == "CHAT_MSG_SPELL_PARTY_DAMAGE"
			or event == "CHAT_MSG_SPELL_FRIENDLYPLAYER_DAMAGE"
			or event == "CHAT_MSG_SPELL_PET_DAMAGE"
			or event == "CHAT_MSG_SPELL_DAMAGESHIELDS_ON_SELF"
			or event == "CHAT_MSG_SPELL_DAMAGESHIELDS_ON_OTHERS") then
			
				if string.find(evarg,"points of fire damage") or string.find(evarg,"You fall and lose") or string.find(evarg,"falls and loses") or string.find(evarg,"health for swimming") then
					GraphicViolence_AddCombatInfo("DT", damage, evarg);
				else
					GraphicViolence_AddCombatInfo("DD", damage, evarg);
				end
				graphable=true;
				
		-- DAMAGE TAKEN	
		elseif (event == "CHAT_MSG_COMBAT_CREATURE_VS_SELF_HITS"
			or event == "CHAT_MSG_COMBAT_CREATURE_VS_PARTY_HITS"
			or event == "CHAT_MSG_COMBAT_CREATURE_VS_CREATURE_HITS"
			or event == "CHAT_MSG_COMBAT_HOSTILEPLAYER_HITS"
			or event == "CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE"
			or event == "CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE"
			or event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE"
			or event == "CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE"
			or event == "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE"
			or event == "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE"
			or event == "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE"
			or event == "CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE") then
			
				GraphicViolence_AddCombatInfo("DT", damage, evarg);
				graphable=true;
				
		-- HEALING DONE			
		elseif (
			(
				(event == "CHAT_MSG_SPELL_SELF_BUFF" or event == "CHAT_MSG_SPELL_PARTY_BUFF" or event == "CHAT_MSG_SPELL_FRIENDLYPLAYER_BUFF" or event == "CHAT_MSG_SPELL_HOSTILEPLAYER_BUFF")
				and string.find(evarg," heals ")
			)
			or
			(string.find(event,"CHAT_MSG_SPELL_PERIODIC_") and string.find(event,"_BUFFS") and string.find(evarg, " health from ")))
			
			then
	
				GraphicViolence_AddCombatInfo("H", damage, evarg);
				graphable=true;
		end
	end

	-- if there was no number found in the event	
	if not graphable then
		-- ignore BoW/JoW spam
		if not string.find(evarg,"Blessing of Wisdom") and not string.find(evarg,"Judgement of Wisdom") then
			GraphicViolence_AddCombatInfo("O", 1, evarg);
		end
	end

end
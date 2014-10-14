BINDING_HEADER_CHATRBUDDIES="ChatrBuddies";
BINDING_NAME_CHATRBUDDIES_TOGGLE="Toggle Buddy List";


ChatrBuddies_RequestInterval = 30.0;
ChatrBuddies_LastRequest=0;
ChatrBuddies_Max=64;
ChatrBuddies_Info={};
ChatrBuddies_Names={};
ChatrBuddies_Levels={};
ChatrBuddies_Dinged={};
ChatrBuddies_NewInc={};
ChatrBuddies_InCurrentList={};

ChatrBuddies_OnlineNames={};
ChatrBuddies_OfflineNames={};
ChatrBuddies_Guildies={};

ChatrBuddies_Count=0;
ChatrBuddies_OnlineCount=0;
ChatrBuddies_ID=0;

Chatr_BuddiesShowCount=32;
Chatr_BuddiesShowByDefault=0;
Chatr_BuddiesShowOffline=0;
Chatr_BuddiesShowGuildies=0;
Chatr_BuddiesCustom=0;

function ChatrBuddies_OnUpdate(elapsed)
	ChatrBuddies_LastRequest = ChatrBuddies_LastRequest + elapsed;
	if (ChatrBuddies_LastRequest > ChatrBuddies_RequestInterval) then
		ShowFriends();
		Chatr_Debug("Buddies requesting update");
		ChatrBuddies_LastRequest = 0;
	end
end

function ChatrBuddies_Init()
	Chatr_SaveThis("BuddiesShowCount","BuddiesShowByDefault","BuddiesShowOffline","BuddiesCustom","BuddiesShowGuildies");
	Chatr_CallMe("ShowSettings",ChatrBuddies_ShowSettings);
	Chatr_CallMe("SettingsLoaded",ChatrBuddies_PostInit);
	Chatr_CallMe("IncomingWhisper",ChatrBuddies_SetActive);
	Chatr_CallMe("OutgoingWhisper",ChatrBuddies_ResetActive);
	Chatr_Slashes["buddies"]=function(args) ChatrBuddies_Toggle(); end;
end

function ChatrBuddies_PostInit()
	Chatr_Print(GetAddOnMetadata("ChatrBuddies","Title").." loaded.");
	ChatrBuddiesOptionsTitle:SetText(GetAddOnMetadata("ChatrBuddies","Title"));	
	Chatr_AddPlugin("ChatrBuddies");
	if Chatr_BuddiesShowByDefault==1 then
		ChatrBuddiesFrame:Show()
	else
		ChatrBuddiesFrame:Hide()
	end
	ShowFriends();
end

function ChatrBuddies_ShowSettings(tab)
	ChatrBuddiesShowCount:SetValue(Chatr_BuddiesShowCount);	
	ChatrBuddiesShowByDefault:SetChecked(Chatr_BuddiesShowByDefault);	
	ChatrBuddiesShowOffline:SetChecked(Chatr_BuddiesShowOffline);
	ChatrBuddiesShowGuildies:SetChecked(Chatr_BuddiesShowGuildies);
end

function ChatrBuddies_SetActive(tab)
	local event,chatr,name,msg,fmtd=unpack(tab);
	ChatrBuddies_NewInc[name]=true;
	ChatrBuddies_UpdateFrame();
end
function ChatrBuddies_ResetActive(tab)
	local event,chatr,name,msg,fmtd=unpack(tab);
	ChatrBuddies_NewInc[name]=nil;
	ChatrBuddies_UpdateFrame();
end


function ChatrBuddies_Toggle()
	if ChatrBuddiesFrame:IsShown() then
		ChatrBuddiesFrame:Hide()
	else
		ChatrBuddiesFrame:Show()
	end
end

function ChatrBuddies_GetGuildies()
	local i,n,name, rank, rankIndex, level, class, zone, note, officernote, online, status,guild;
	ChatrBuddies_Guildies={};
	
	if IsInGuild() then
		guild,i,n=GetGuildInfo("player");
		local n = GetNumGuildMembers(true);
		for i=1,n do
			name,rank,rankIndex,level,class,zone,note,officernote,online,status=GetGuildRosterInfo(i)
			ChatrBuddies_Guildies[name]={name,rank,rankIndex,level,class,zone,note,officernote,online,status};
			if Chatr_WhoInfo[name]==nil then
				Chatr_WhoInfo[name]={time(),guild,level,"",class,zone};
			else
				Chatr_WhoInfo[name]={time(),guild,level,Chatr_WhoInfo[name][4],class,zone};
			end
		end
	end
end

function ChatrBuddies_GetFriends()
	local n=GetNumFriends();
	local _,v,i,name, level, class, area, connected, status;
	
	ChatrBuddies_Info={};
	ChatrBuddies_Names={};
	ChatrBuddies_OfflineNames={};
	ChatrBuddies_OnlineNames={};
	ChatrBuddies_Count=n;
	ChatrBuddies_OnlineCount=0;
	ChatrBuddies_GetGuildies();
	if n==0 then return; end
	for i = 1,n do
		name, level, class, area, connected, status=GetFriendInfo(i);
		if name~=nil then
			ChatrBuddies_Info[name]={level,class,area,connected,status};
			if Chatr_WhoInfo[name]==nil then
				Chatr_WhoInfo[name]={time(),"", level, "", class, area};
			else
				Chatr_WhoInfo[name]={time(),Chatr_WhoInfo[name][2],level,Chatr_WhoInfo[name][4],class,area};
			end
			if ChatrBuddies_Levels[name]~=nil and level>ChatrBuddies_Levels[name] then
				ChatrBuddies_Dinged[name]=true;
			end
			if connected then
				ChatrBuddies_OnlineCount=ChatrBuddies_OnlineCount+1;
				tinsert(ChatrBuddies_OnlineNames,name);
			else
				tinsert(ChatrBuddies_OfflineNames,name);
			end
			if level>0 then
				ChatrBuddies_Levels[name]=level;
			else
				ChatrBuddies_Levels[name]=nil;
			end
			tinsert(ChatrBuddies_Names,name);
		end
	end
	if Chatr_BuddiesShowGuildies==1 then
		for _,v in ChatrBuddies_Guildies do
			name,level,class,area,connected=v[1],v[4],v[5],v[6],v[9];
			ChatrBuddies_Info[name]={level,class,area,connected,status};
			if connected then
				tinsert(ChatrBuddies_OnlineNames,name);
			else
				tinsert(ChatrBuddies_OfflineNames,name);
			end
			tinsert(ChatrBuddies_Names,name);			
		end
	end
	sort(ChatrBuddies_Names);
	sort(ChatrBuddies_OnlineNames);
	sort(ChatrBuddies_OfflineNames);
end

function CB_MULTCOLOR(c,r,g,b,a)
	if a==nil then a=1; end
	return {c[1]*r,c[2]*g,c[3]*b,c[4]*a};
end
function CB_MODCOLOR(c,z,r,g,b,a)
	local z2=1-z;
	return {c[1]*z2+r*z,c[2]*z2+g*z,c[3]*z2+b*z,c[4]*z2+a*z};
end

function CB_FILTERV(tab,func)
	newTab={};
	for k in tab do
		if func(tab[k]) then tinsert(newTab,tab[k]); end
	end
	return newTab;
end

function CB_FILTERK(tab,func)
	newTab={};
	for k in tab do
		if func(tab[k]) then newTab[k]=tab[k]; end
	end
	return newTab;
end

function ChatrBuddies_ShowInfo(f)
	local s,name;
	name=f:GetText();
	if ChatrBuddies_Info[name] then
		
		ChatrBuddiesInfoLine:ClearAllPoints();
		if f:GetLeft()<=GetScreenWidth()/2.0 then
			ChatrBuddiesInfoLine:SetPoint("LEFT",f,"RIGHT",5,0);
		else
			ChatrBuddiesInfoLine:SetPoint("RIGHT",f,"LEFT",-5,0);
		end		
		
		s="";
		if ChatrBuddies_Info[name][4]==nil then
			s=name.." (Offline)";
		else
			if ChatrBuddies_Info[name][5]~="" then s=s..ChatrBuddies_Info[name][5]; end
			s=s..name;
			s=s.." ("..ChatrBuddies_Info[name][1].." "..ChatrBuddies_Info[name][2]..")";
			s=s.." - "..ChatrBuddies_Info[name][3];
		end
		ChatrBuddiesInfoLine:SetText(s);
		ChatrBuddiesInfoLine:Show();
	end
end

function ChatrBuddies_Append(name)
	local p,color,status,zone;
	if ChatrBuddies_ID>ChatrBuddies_Max or ChatrBuddies_ID>Chatr_BuddiesShowCount then return; end
	if name==nil or type(name)~="string" or strlen(name)<=1 then return; end
	p=getglobal("ChatrBuddiesBtn"..ChatrBuddies_ID);
	if p~=nil and ChatrBuddies_InCurrentList[name]==nil then
		ChatrBuddies_InCurrentList[name]=true;
		if ChatrBuddies_Info[name] then
			if ChatrBuddies_Info[name][4]==nil then
				status="off"
			else
				status=ChatrBuddies_Info[name][5];
			end
		else
			status="";
		end
		
		color={1,1,1,1};
		if status=="off" then
			color={1,1,1,0.5};
		else
			if ChatrBuddies_Info[name] and ChatrBuddies_Info[name][3]==GetRealZoneText() then color={0.6,0.6,1,1}; end
			if status=="<AFK>" then color=CB_MODCOLOR(color,0.5,1,0.8,0,1); end
			if status=="<DND>" then color=CB_MODCOLOR(color,0.5,0.6,0,0,1); end
			if ChatrBuddies_Dinged[name] then
				color=CB_MODCOLOR(color,0.7,1,0.9,0,1);
			end
			if ChatrBuddies_NewInc[name] then
				color=CB_MODCOLOR(color,0.7,0.7,1,0.7,1);
			end
			if ChatrBuddies_Guildies[name] and ChatrBuddies_ShowGuildies~=1 then
				color=CB_MODCOLOR(color,0.3,0,1,0,1);
			end
		end
		
		p:SetText(name);
		p:SetTextColor(unpack(color));
		p:ClearAllPoints();
		p:Show();
		if ChatrBuddies_ID==1 then
			p:SetPoint("TOP","ChatrBuddiesFrame","TOP",0,-5);
		else
			p:SetPoint("TOP","ChatrBuddiesBtn"..(ChatrBuddies_ID-1),"BOTTOM");
		end
		
		ChatrBuddies_ID=ChatrBuddies_ID+1;
	end
end


function ChatrBuddies_UpdateFrame()
	local n,i,z;
	ChatrBuddies_GetFriends();
	ChatrBuddies_ID=1;
	ChatrBuddies_InCurrentList={};
	for i=1,ChatrBuddies_Max do getglobal("ChatrBuddiesBtn"..i):Hide(); end
	if ChatrBuddies_Count>0 then
		for _,name in ChatrBuddies_OnlineNames do
			ChatrBuddies_Append(name);
		end
		if Chatr_BuddiesShowOffline==1 then
			for _,name in ChatrBuddies_OfflineNames do
				ChatrBuddies_Append(name);
			end
		end
	end
	if Chatr_BuddiesCustom~="" then
		n,i=Chatr_Split(",",Chatr_BuddiesCustom,0);
		for _,z in i do
			ChatrBuddies_Append(z);
		end
	end
	ChatrBuddiesFrame:SetHeight(14*ChatrBuddies_ID+5);
	ChatrBuddiesTitle:SetText(""..ChatrBuddies_OnlineCount.."/"..ChatrBuddies_Count);
end

function ChatrBuddies_Click(f)
	local name=f:GetText();
	if name==nil then return; end
	ChatrBuddies_Dinged[name]=nil;
	ChatrBuddies_NewInc[name]=nil;
	
	ChatrBuddies_UpdateFrame();
end

function ChatrBuddies_DClick(f)
	local c;
	local name=f:GetText();
	if name=="Buddies" and ChatrBuddies_Toggle then
		ChatrBuddies_Toggle();
		return;
	end
	c=Chatr_FindByName(name);
	if c==-1 then
		c=getglobal("Chatr"..Chatr_OpenFor(name));
	else
		c=getglobal("Chatr"..c);
	end
	c.editBox:SetFocus();
	if c.minimized and not c.docked then Chatr_Minimize(c); end
	Chatr_Enter(c);
end
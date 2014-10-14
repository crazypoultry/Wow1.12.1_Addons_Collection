BUB_DebugEvents = {
	"PLAYER_TARGET_CHANGED",
	--"CHAT_MSG_SPELL_AURA_GONE_SELF",
	--"CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF",
	"CHAT_MSG_COMBAT_SELF_HITS",
	"CHAT_MSG_COMBAT_PARTY_HITS",
	"CHAT_MSG_COMBAT_FRIENDLYPLAYER_HITS",
	"CHAT_MSG_COMBAT_HOSTILEPLAYER_HITS",
	"CHAT_MSG_COMBAT_CREATURE_VS_SELF_HITS";
	"CHAT_MSG_COMBAT_CREATURE_VS_PARTY_HITS",
	"CHAT_MSG_COMBAT_CREATURE_VS_CREATURE_HITS",
	"CHAT_MSG_SPELL_SELF_DAMAGE",
	"CHAT_MSG_SPELL_PARTY_DAMAGE",
	"CHAT_MSG_SPELL_FRIENDLYPLAYER_DAMAGE",
	"CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE",
	"CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE",
	"CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE",
	"CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE",
	"CHAT_MSG_SPELL_SELF_BUFF",
	"CHAT_MSG_SPELL_PARTY_BUFF",
	"CHAT_MSG_SPELL_FRIENDLYPLAYER_BUFF",
	"CHAT_MSG_SPELL_HOSTILEPLAYER_BUFF",
	"CHAT_MSG_SPELL_CREATURE_VS_SELF_BUFF",
	"CHAT_MSG_SPELL_CREATURE_VS_PARTY_BUFF",
	"CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF",
	"CHAT_MSG_SPELL_DAMAGESHIELDS_ON_OTHERS",
	"CHAT_MSG_SPELL_DAMAGESHIELDS_ON_SELF",
	"CHAT_MSG_SPELL_FAILED_LOCALPLAYER",
	"CHAT_MSG_SPELL_ITEM_ENCHANTMENTS",
	"CHAT_MSG_SPELL_PARTY_DAMAGE",
	"CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_BUFFS",
	"CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE",
	"CHAT_MSG_SPELL_PERIODIC_PARTY_BUFFS",
	"CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE",
	"CHAT_MSG_SPELL_PET_BUFF",
	"CHAT_MSG_SPELL_TRADESKILLS",
	"CHAT_MSG_COMBAT_PARTY_MISSES",
	"CHAT_MSG_COMBAT_CREATURE_VS_CREATURE_MISSES",
	"CHAT_MSG_COMBAT_CREATURE_VS_PARTY_MISSES",
	"CHAT_MSG_COMBAT_FRIENDLYPLAYER_MISSES",
	"CHAT_MSG_COMBAT_FRIENDLY_DEATH",
	"CHAT_MSG_COMBAT_MISC_INFO",
};

local cbi=0;
local bub_namelist = {};
local line_i=0;
local bub_CanTarget = {};
local bub_CanTarget_ID = {};
local bub_CanTargetTarget = {};
local bub_event_bub = 1;
local bub_spawn_on_target = 0;

function bubbles_OnLoad() 
	for key, value in BUB_DebugEvents do
		this:RegisterEvent(value);
	end
	SlashCmdList["Bubbles_EBT"] = bubblesSlash_EBT;
	SLASH_Bubbles_EBT1 = "/bubetoggle";
	SLASH_Bubbles_EBT2 = "/bubblesventtoggle";
	SlashCmdList["Bubbles_AP"] = bubblesSlash_AP;
	SLASH_Bubbles_AP1 = "/bubblesparty";
	SLASH_Bubbles_AP2 = "/bubp";
	SlashCmdList["Bubbles_AR"] = bubblesSlash_AR;
	SLASH_Bubbles_AR1 = "/bubblesraid";
	SLASH_Bubbles_AR2 = "/bubr";
	SlashCmdList["Bubbles_SOT"] = bubblesSlash_SOT;
	SLASH_Bubbles_SOT1 = "/bubblesspawnontarget";
	SLASH_Bubbles_SOT2 = "/bubsot";
	
end

function bubblesSlash_EBT()
if(bub_event_bub == 1) then
	bub_event_bub=0;
	print("disabled event bubbles");
else
	bub_event_bub=1;
	print("enabled event bubbles");
end
end

function bubblesSlash_SOT()
if(bub_spawn_on_target == 1) then
	bub_spawn_on_target=0;
	print("disabled bubble spawn on target");
else
	bub_spawn_on_target=1;
	print("enabled bubble spawn on target");
end
end



-- print debug messages to chat frame
function bubbles_Debug(...)
   local msg = ''
   for k,v in ipairs(arg) do
      msg = msg .. tostring(v) .. ' : '
   end
   DEFAULT_CHAT_FRAME:AddMessage(msg)
end



local names = {}
local ids = {}
local line_show = {}
local line_start = {}
local line_end = {}
local id = 1

local class_patterns = {
   Rogue = '^Your Eviscerate (%w+).-(%d+)%.',
   Druid = '^Your Ferocious Bite (%w+).-(%d+)%.',
}

-- be sure we have a history table even if not loaded from saved variables
if not bubbles_History then
   bubbles_History = { }
end

-- build the list of keys necessary for accessing the currently applicable history of eviscerate damage
function bubbles_HistoryKeys(hit_type, max_combo)

   local combo_points = combo_points_now

   -- there is a race condition existing between when combo points get
   -- updated and the '^Your Eviscerate (%w+).-(%d+)%.' message occurs.
   -- To compensate, we keep a history of 2 combo point observations,
   -- using the highest one for recording purposes. You could end up
   -- with values like 2,3 or 3,0; but never 3,2.
   if max_combo then
      combo_points = math.max(combo_points_now, combo_points_then)
   end

   return {
      GetCVar('realmName'),
      UnitName('player'),
      target_type,
      target_class,
      target_power,
      target_level,
      hit_type,
      combo_points
   }

end

function print(msg)
DEFAULT_CHAT_FRAME:AddMessage(msg);
end

function bubbles_hasId(list,vv)
for i= 0,getn(list) do
if(list[i]==vv) then 
	return 1 
end 
end
return 0
end

function bubbles_NameID(list,name)
for i= 0,getn(list) do 
if(list[i]==name) then 
	return i
end
end
return -1
end


function bubbles_OnUpdate()
if(cbi > 0) then
	Bub_ScanAll();
	bub_update_textbubs();
end	
end


function bubbles_showbub(i,target,x,y) 
	 frame=getglobal("BubblesFrame"..i);
 	 frame:ClearAllPoints()	
	 frame:SetFrameLevel(BubblesFrame_Template:GetFrameLevel() + 1)
	 frame:SetFrameStrata(BubblesFrame_Template:GetFrameStrata())
	 frame:SetPoint("CENTER",  BubblesFrame_Template,    "CENTER", x, y);	 
         frame:Show()	 
	 text=getglobal("BubblesFrame"..i.."Texture");
	 SetPortraitTexture (text,target);
	 frame:SetScale(BubblesFrame_Template:GetScale())
	 frame:SetHeight(BubblesFrame_Template:GetHeight());
	 frame:SetWidth(BubblesFrame_Template:GetWidth());

end

function bubbles_AddBubble(name) 
if (bubbles_hasId(ids,name) == 1) then return end
TargetByName(name);
if (not(UnitExists('target')) or bubbles_hasId(ids,UnitName('target')) == 1) then
else
	ids[id]=UnitName('target')
	bubbles_showbub(id,'target',id*50,-100);
	id=id+1
	if(id > 10) then id = 1 end
end
end

function bubbles_OnEvent()
if (event == "PLAYER_TARGET_CHANGED" and bub_spawn_on_target==1) then
	bubbles_Create_On_Target();
end
bubbles_scanner(event,arg1);
end

function bubbles_Connect(id,im1,im2) 
	rim1=getglobal("BubblesFrame"..im1);
	rim2=getglobal("BubblesFrame"..im2);
	x1=rim1:GetLeft()+rim1:GetWidth()/2.-BubblesFrame_Template:GetLeft();
	x2=rim2:GetLeft()+rim2:GetWidth()/2.-BubblesFrame_Template:GetLeft();
	y1=rim1:GetBottom()+rim1:GetHeight()/2.-BubblesFrame_Template:GetTop();
	y2=rim2:GetBottom()+rim2:GetHeight()/2.-BubblesFrame_Template:GetTop();
	--bubbles_DrawLine(id,x1 ,y1, x2,y2)
	if(BubblesFrame1 and BubblesFrame2) then
		bubbles_DrawlLine1(id, BubblesFrame1,BubblesFrame2)
	end
end

function bubbles_AddLine(n1,n2) 
for i= 0,getn(line_show) do 
if(line_show[i] == 0) then
	i1=bubbles_NameID(ids,n1)
	i2=bubbles_NameID(ids,n2)
	if(i1 ~= -1 and i2 ~= -1) then
		line_show[i]=1;
		line_start[i]=n1;
		line_end[i]=n2;
		return
	end
end
end
i=getn(line_show)+1
line_show[i]=1;
line_start[i]=n1;
line_end[i]=n2;
end

function bubbles_DrawlLine1(id)
   local line = getglobal("AutoTravel_Line_" .. id);
   n1=line_start[id];
   n2=line_end[id];
   i1=bubbles_NameID(ids,n1)
   i2=bubbles_NameID(ids,n2)
   if(i1 ~= -1 and i2 ~= -1) then   
   b1=getglobal("BubblesFrame"..i1);
   b2=getglobal("BubblesFrame"..i2);
   dx = b2:GetLeft()-b1:GetLeft();
   dy = b2:GetTop()-b1:GetTop();
   gx = 25.*(dx/sqrt(dx^2+dy^2));
   gy = 25.*(dy/sqrt(dx^2+dy^2));
   
   local linetexture = getglobal("AutoTravel_Line_" .. id .. "Texture");
   dx=dx-gx*2.
   dy=dy-gy*2.  
   if((dy < 0 and dx > 0) or (dy > 0 and dx < 0)) then
   linetexture:SetTexture("Interface\\AddOns\\AutoTravel\\linedown-path"); 
   line:SetPoint("BOTTOMLEFT",b1,"CENTER",0+gx,0+gy-256);
   linetexture:SetHeight(abs(dy)*len(dx));
   linetexture:SetWidth(abs(dx)*len(dx));
   linetexture:SetTexCoord(0,min((min(abs(dx),abs(dy))/256.),1), 0, min(min(abs(dx),abs(dy))/256.,1));  
   else
   line:SetPoint("BOTTOMLEFT",b1,"CENTER",0+gx,dy-256+gy);
   linetexture:SetTexture("Interface\\AddOns\\AutoTravel\\lineup-path"); 
   linetexture:SetHeight(dy);
   linetexture:SetWidth(dx);
   linetexture:SetTexCoord(max(1-(min(abs(dx),abs(dy))/256.),0),1, 0, min(min(abs(dx),abs(dy))/256.,1));   
   end
   line:Show();  
   else
   line:Hide();
   line_start[i]="";
   line_end[i]="";
   line_show[i]=0;
   end 
end

function bubbles_DrawLine(id, v1x,v1y, v2x,v2y)
   if not path then
      path = "";
   else
      path = "-path";
   end
   
   local line = getglobal("AutoTravel_Line_" .. id);
   local linetexture = getglobal("AutoTravel_Line_" .. id .. "Texture");

   --local pcoords1 = AutoTravel_GetPoint(point1);
   --local v1x, v1y = MapLibrary.TranslateWorldToZone(pcoords1.x, pcoords1.y, AutoTravel_MapFrame_Zone);

   --local pcoords2 = AutoTravel_GetPoint(point2);
   --local v2x, v2y = MapLibrary.TranslateWorldToZone(pcoords2.x, pcoords2.y, AutoTravel_MapFrame_Zone);

   local fwidth = 500;
   local fheight = 500;
   --local zoom = AutoTravel_MapFrame_Zoom;

   --v1x = v1x * fwidth * zoom - AutoTravel_MapFrame_ZoomOffsetX;
   --v1y = v1y * fheight * zoom - AutoTravel_MapFrame_ZoomOffsetY;

   --v2x = v2x * fwidth * zoom - AutoTravel_MapFrame_ZoomOffsetX;
   --v2y = v2y * fheight * zoom - AutoTravel_MapFrame_ZoomOffsetY;

   -- Cut the line to fit on screen
   if v1x ~= v2x then
      if v1x < 0 then
	 v1y = v1y + (0 - v1x) * (v2y - v1y) / (v2x - v1x);
	 v1x = 0;
      elseif v1x > fwidth then
	 v1y = v1y + (fwidth - v1x) * (v2y - v1y) / (v2x - v1x);
	 v1x = fwidth;
      end
      if v2x < 0 then
	 v2y = v2y + (0 - v2x) * (v1y - v2y) / (v1x - v2x);
	 v2x = 0;
      elseif v2x > fwidth then
	 v2y = v2y + (fwidth - v2x) * (v1y - v2y) / (v1x - v2x);
	 v2x = fwidth;
      end
   end
   if v1y ~= v2y then
      if v1y < 0 then
	 v1x = v1x + (0 - v1y) * (v2x - v1x) / (v2y - v1y);
	 v1y = 0;	 
      elseif v1y > fheight then
	 v1x = v1x + (fheight - v1y) * (v2x - v1x) / (v2y - v1y);
	 v1y = fheight;	 
      end
      if v2y < 0 then
	 v2x = v2x + (0 - v2y) * (v1x - v2x) / (v1y - v2y);
	 v2y = 0;	 
      elseif v2y > fheight then
	 v2x = v2x + (fheight - v2y) * (v1x - v2x) / (v1y - v2y);
	 v2y = fheight;	 
      end
   end

   -- Don't draw if the line is off screen
   if (v1x < 0 and v2x < 0) or
      (v1x > fwidth and v2x > fwidth) or
      (v1y < 0 and v2y < 0) or
      (v1y > fheight and v2y > fheight) then
      return false;
   end

   local x1 = math.min(v1x, v2x);
   local y1 = math.min(v1y, v2y);

   local x2 = math.max(v1x, v2x);
   local y2 = math.max(v1y, v2y);

   if x1 < 0 or y1 < 0 or
      x2 > fwidth or y2 > fheight then
      return false;
   end
      
   local real_width = math.max(3, math.abs(v1x - v2x));
   local real_height = math.max(3, math.abs(v1y - v2y));

   if real_width == 3 and real_height == 3 then
      return false;
   end

   local thickness = math.min(1, math.min(real_height, real_width) / 256);
   linetexture:SetWidth(real_width);
   linetexture:SetHeight(real_height);
  if real_width == 3 or real_width == 3 then
      linetexture:SetTexture("Interface\\AddOns\\AutoTravel\\road");
      linetexture:SetTexCoord(0, 1, 0, 1);
   elseif (v1x < v2x) ~= (v1y < v2y) then
      linetexture:SetTexture("Interface\\AddOns\\AutoTravel\\lineup");
      linetexture:SetTexCoord(0, thickness, 1 - thickness, 1);
   else
      linetexture:SetTexture("Interface\\AddOns\\AutoTravel\\linedown");
      linetexture:SetTexCoord(0, thickness, 0, thickness);
   end

   line:SetPoint("TOPLEFT",
		 "BubblesFrame_Template", 
		 "TOPLEFT", x1, -y1);

   line:Show();

   return true;
end

local bub_spell={"CHAT_MSG_SPELL_SELF_DAMAGE",
	"CHAT_MSG_SPELL_PARTY_DAMAGE",
	"CHAT_MSG_SPELL_FRIENDLYPLAYER_DAMAGE",
	"CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE",
	"CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE",
	"CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE",
	"CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE",
	"CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE"}
local bub_combat={"CHAT_MSG_COMBAT_SELF_HITS",
	"CHAT_MSG_COMBAT_PARTY_HITS",
	"CHAT_MSG_COMBAT_FRIENDLYPLAYER_HITS",
	"CHAT_MSG_COMBAT_HOSTILEPLAYER_HITS",
	"CHAT_MSG_COMBAT_CREATURE_VS_SELF_HITS";
	"CHAT_MSG_COMBAT_CREATURE_VS_PARTY_HITS",
	"CHAT_MSG_COMBAT_CREATURE_VS_CREATURE_HITS"}
local bub_heal={"CHAT_MSG_SPELL_SELF_BUFF",
	"CHAT_MSG_SPELL_PARTY_BUFF",
	"CHAT_MSG_SPELL_FRIENDLYPLAYER_BUFF",
	"CHAT_MSG_SPELL_HOSTILEPLAYER_BUFF",
	"CHAT_MSG_SPELL_CREATURE_VS_SELF_BUFF",
	"CHAT_MSG_SPELL_CREATURE_VS_PARTY_BUFF",
	"CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF"}

function bubbles_scanner(event,arg1)
if (Bub_ArraySearch(bub_combat,event) ~= -1) then	
	for n2, damage in string.gfind(arg1, "You hit (.+) for (%d+).") do				
		bubble_scanner_do_hit("you",n2,damage);
		return;
	end
	for n2, damage in string.gfind(arg1, "You crit (.+) for (%d+).") do				
		bubble_scanner_do_hit("you",n2,damage);
		return;
	end
	for n1, n2, damage in string.gfind(arg1, "(.+) hits (.+) for (%d+).") do			
		bubble_scanner_do_hit(n1,n2,damage);
		return;
	end
	for n1, n2, damage in string.gfind(arg1, "(.+) crits (.+) for (%d+).") do			
		bubble_scanner_do_hit(n1,n2,damage);
		return;
	end
end
if (Bub_ArraySearch(bub_spell,event) ~= -1) then
	for blank, n2, damage in string.gfind(arg1, "Your (.+) hits (.+) for (.%d+).") do
		bubble_scanner_do_hit("you",n2,damage);						
		return;
	end
	for blank, n2, damage in string.gfind(arg1, "Your (.+) crits (.+) for (.%d+).") do
		bubble_scanner_do_hit("you",n2,damage);						
		return;
	end
	for n1,blank, n2, damage in string.gfind(arg1, "(.+)'s (.+) hits (.+) for (.%d+).") do
		bubble_scanner_do_hit(n1,n2,damage);						
		return;
	end
	for n1,blank, n2, damage in string.gfind(arg1, "(.+)'s (.+) crits (.+) for (.%d+).") do
		bubble_scanner_do_hit(n1,n2,damage);						
		return;
	end
end  
if (Bub_ArraySearch(bub_heal,event) ~= -1) then
	for blank, n2, damage in string.gfind(arg1, "Your (.+) heals (.+) for (.%d+).") do
		bubble_scanner_do_heal("you",n2,damage);						
		return;
	end
	for blank, n2, damage in string.gfind(arg1, "Your (.+) critically heals (.+) for (.%d+).") do
		bubble_scanner_do_heal("you",n2,damage);						
		return;
	end
	for n1,blank, n2, damage in string.gfind(arg1, "(.+)'s (.+) heals (.+) for (.%d+).") do
		bubble_scanner_do_heal(n1,n2,damage);						
		return;
	end
	for n1,blank, n2, damage in string.gfind(arg1, "(.+)'s (.+) critically heals (.+) for (.%d+).") do
		bubble_scanner_do_heal(n1,n2,damage);						
		return;
	end
end  
end

function bubble_scanner_do_hit(n1,n2,damage)
bf_event(1,n1,n2,damage);
end

function bubble_scanner_do_heal(n1,n2,damage)
bf_event(2,n1,n2,damage);
end




function bubblesFrame_OnMouseDown(arg1)  
	if (arg1 == "LeftButton") then
		this:StartMoving();
	end
		
end

function bubblesFrame_OnMouseUp(arg1)
	if (arg1 == "LeftButton") then
		this:StopMovingOrSizing();
		if (this ~= BubblesFrame_Template) then
			x=this:GetLeft()-BubblesFrame_Template:GetLeft();
			y=this:GetTop()-BubblesFrame_Template:GetTop();			
			this:SetPoint("TOPLEFT",BubblesFrame_Template,"TOPLEFT",(x-BubblesFrame_Template:GetWidth()),(y-BubblesFrame_Template:GetHeight()))
		end
	end
end

-- event handler for changing targets
function bubbles_PLAYER_TARGET_CHANGED()

end

function len(value)
if(value > 0) then 
return 1.
elseif(value < 0) then
return -1.
else return 0
end
end

--########################################################################
--MISC

function Bub_ArraySearch(array,search)
for i=1,getn(array) do 
	if(array[i]==search) then 
		return i
	end
end
return -1
end

function Bub_ArraySearchN(array,search)
res={}
for i=1,getn(array) do 
	if(array[i]==search) then 
		res[getn(res)+1]=i
	end
end
return res
end

function printarr(array)
for i=1,getn(array) do 
	print(array[i]);
end
end


--########################################################################
--WoW


function Bub_ScanTargets(name) 
--Cleaner Searching
id=Bub_ArraySearch(bub_CanTarget,name);
if(id ~= -1) then 
	return bub_CanTarget_ID[id];
end
return -1

--local s_string={"player","mouseover"};
--local add_string={"pet","target"};
--local passed_names = {};
--for i=1,4 do 
--	s_string[1+i]="party"..i
--end
--for i=1,40 do
--	s_string[4+i]="raid"..i
--end
--ci=0;
--while(getn(s_string) >= ci and ci < 500) do 
--	cs=s_string[ci];	
--	if (UnitExists(cs)) then		
--		if(UnitName(cs) == name) then return cs 
--		end
--		if(Bub_ArraySearch(passed_names,UnitName(cs)) == -1) then
--			passed_names[getn(passed_names)+1]=UnitName(cs)
--			s_string[getn(s_string)+1]=cs.."pet";
--			s_string[getn(s_string)+1]=cs.."target";
--		end
--	end	
--	ci=ci+1;
--end
--return -1;
end

function Bub_ScanAll()
bub_CanTarget = {};
bub_CanTarget_ID = {};
bub_CanTargetTarget = {};
local s_string={"player","mouseover"};
local add_string={"pet","target"};
local passed_names = {};
for i=1,4 do 
	s_string[1+i]="party"..i
end
for i=1,40 do
	s_string[4+i]="raid"..i
end
ci=0;
while(getn(s_string) >= ci and ci < 500) do 
	cs=s_string[ci];	
	if (UnitExists(cs)) then				
		if(Bub_ArraySearch(passed_names,UnitName(cs)) == -1) then
			passed_names[getn(passed_names)+1]=UnitName(cs)
			if(UnitExists(cs.."pet")) then
				s_string[getn(s_string)+1]=cs.."pet";
			end
			if(UnitExists(cs.."target")) then
				s_string[getn(s_string)+1]=cs.."target";
			end
			bub_CanTarget[getn(bub_CanTarget)+1]=UnitName(cs);
			bub_CanTarget_ID[getn(bub_CanTarget_ID)+1]=cs;	
			if (UnitExists(cs..'target')) then
				bub_CanTargetTarget[getn(bub_CanTargetTarget)+1]=UnitName(cs..'target');
			else
				bub_CanTargetTarget[getn(bub_CanTargetTarget)+1]=NULL;
			end
		end
	end	
	ci=ci+1;
end
end
--########################################################################
--BUBBLES

function Bubbles_GetFree_Bub()
cbi=cbi+1;
if(cbi > 999) then 
	cbi=1 
end
return cbi
end

function Bubbles_Add_Target()
if (UnitExists('target')) then
	n=Bub_ArraySearch(bub_namelist,UnitName('target'));	
	x,y=GetCursorPosition(UIParent);
	if(n == -1) then
		frame=bubbles_Create_Bubble(UnitName('target'),x,y);							
		SetPortraitTexture(frame.tex,'target');		
 	else
		frame=bubbles_Update_Bubble(n,x,y);
	end
	bf_ToMouse(frame);
end
end

function Bubbles_Add_ByID(id,x,y)
if (UnitExists(id)) then
	n=Bub_ArraySearch(bub_namelist,UnitName(id));		
	if(n == -1) then
		frame=bubbles_Create_Bubble(UnitName(id),x,y);							
		SetPortraitTexture(frame.tex,id);		
 	else
		frame=bubbles_Update_Bubble(n,x,y);
	end
	return frame;
end
end

function Bubbles_Add_ByName(name,x,y)
	n=Bub_ArraySearch(bub_namelist,name);	
	if(n == -1) then
		frame=bubbles_Create_Bubble(name,x,y);				
 	else
		frame=bubbles_Update_Bubble(n,x,y);
	end
	return frame
end

function bubbles_Create_Bubble(name,x,y)
id=Bubbles_GetFree_Bub()
frame=getglobal("BF_"..id);
tex=getglobal("BF_"..id.."Texture");
frame.tex=tex;
bf_SetPos(frame,x,y);
frame:Show();
frame.hidden=0;
frame.bub_name=name;
gtex=getglobal("BF_"..id.."glowtext");
gtext=frame:CreateTexture(gtext,"FOREGROUND");
gtext:SetTexture("Interface\\Minimap\\Ping\\ping4.blp");
gtext:SetBlendMode("Add");
gtext:SetPoint("CENTER",  frame,    "CENTER", 0,0);
gtext:SetHeight(frame:GetHeight()+12);
gtext:SetWidth(frame:GetWidth()+12);
gtext:SetVertexColor(0.5,0.5,1,1);
frame.gtex = gtext;
ctext = frame:CreateFontString("BF_"..id.."ctext","FOREGROUND");
ctext:SetFont(bubbleText:GetFont(),10);
ctext:SetFontObject(bubbleText:GetFontObject());
ctext:SetPoint("CENTER", frame, "CENTER",0,0);
frame.text=ctext;
bf_SetName(frame,name)
tex:SetBlendMode("Add");
frame.name=name;
bub_namelist[getn(bub_namelist)+1]=name;
frame.auto_add = 0;
frame.spawnpoint = 0;
frame.moving=0;
return frame
end

function bubbles_Update_Bubble(n,x,y)
frame=getglobal("BF_"..n);
bf_SetPos(frame,x,y);
frame:Show();
frame.hidden=0;
frame.auto_add = 0;
frame.spawnpoint = 0;
frame.moving=0;

return frame
end

function bf_SetPos(frame,x,y)
frame:ClearAllPoints();
frame:SetPoint("CENTER",x-UIParent:GetWidth()/2,y-UIParent:GetHeight()/2);
frame.rx=x;
frame.ry=y;
end

function bf_GetPos(frame)
x=frame:GetLeft()-frame:GetWidth()/2;
y=frame:GetBottom()-frame:GetHeight()/2;
return {x,y}
end

function bf_CheckPicture()
if(this.tex:GetTexture() ~= "Portrait1") then
	id=Bub_ArraySearch(bub_CanTarget,this.name);
	if(id ~= -1) then 
		t=bub_CanTarget_ID[id];
		SetPortraitTexture(this.tex,t);
	end
	this.tex:SetTexture("Interface\CharacterFrame\TempPortrait.blp");
	end
end

function bf_ToMouse(frame)
x,y=GetCursorPosition(UIParent);
frame:SetPoint("CENTER",x-UIParent:GetWidth()/2,y-UIParent:GetHeight()/2);
end

function bf_Spawn_from(spawn,name)
x=spawn:GetLeft()-spawn:GetWidth()/2;
y=spawn:GetBottom()-spawn:GetHeight()/2;
nx=x+cos(spawn.spawnpoint*60)*75;
ny=y+sin(spawn.spawnpoint*60)*75;
frame=Bubbles_Add_ByName(name,nx,ny);
spawn.spawnpoint=spawn.spawnpoint+1;
return frame
end
	

function bf_OnMouseDown(arg1)
this.lastmouse=GetTime();
this.l_mousex,this.l_mousey=GetCursorPosition(UIParent);
if (arg1 == "LeftButton") then
		--this.text:SetText(this.name);
		bf_SetName(this,this.name)
		this.text:SetTextColor(1,1,1,1);
		this:StartMoving();
		this.moving=1;
end
end

function bf_OnMouseUp(arg1)
x,y=GetCursorPosition(UIParent);
if (arg1 == "LeftButton") then
		this:StopMovingOrSizing();
		this.moving=0;		
		
		if(GetTime()-this.lastmouse < 0.2) then
			target=Bub_ScanTargets(this.name);
			if(target == -1) then
				TargetByName(this.name);
			else
				TargetUnit(target);
			end
		elseif(sqrt((this.l_mousex-x)^2+(this.l_mousey-y)^2)<5) then
			this.auto_add = this.auto_add+1
			if(this.auto_add > 4)  then
				this.auto_add = 0;
			end
		end
end
if (arg1 == "RightButton") then
		if(GetTime()-this.lastmouse < 0.2) then
			this:Hide();
			this.hidden=1;
		end
end
end

function bf_OnMouseScroll(arg1)
end

function bf_SetName(frame,name)
str=string.gsub(name,"%s","\n")
frame.text:SetText(str);
end

function bf_OnUpdate()
if(this.moving==0) then
	t=GetTime();
	x = this:GetLeft();
	y = this:GetBottom();
	dz=(cos(mod(t*90+x,360)))*0.25;
	this:ClearAllPoints();
	this:SetPoint("BOTTOMLEFT",UIParent,"BOTTOMLEFT",x,y+dz);
end

res=Bub_ScanTargets(this.name)
bf_CheckPicture();
lup=1.0
if(res == -1) then lup = 0.5 end
	if(this.auto_add == 0) then
		this.gtex:SetVertexColor(0.5,0.5,1,lup);
	elseif(this.auto_add == 1) then
		this.gtex:SetVertexColor(1,0.5,1,lup);
	elseif(this.auto_add == 2) then
		this.gtex:SetVertexColor(0.5,1,1,lup);
	elseif(this.auto_add == 3) then
		this.gtex:SetVertexColor(1,1,1,lup);
	elseif(this.auto_add == 4) then
		this.gtex:SetVertexColor(0,0,1,lup);
	end
if(res ~= -1) then	
	if(UnitExists(res.."target")) then
		bf_event(0,this.name,UnitName(res.."target"),-1);
		ress=Bub_ArraySearchN(bub_CanTargetTarget,this.name);		
		if(getn(ress) ~= 0) then
			for i=0,getn(ress) do
				bf_event(0,bub_CanTarget[ress[i]],this.name,-1);
			end
		end
	end
end
end

--[events]
--0 nothing
--1 dammage only
--2 healing only
--3 dammage and healing only
--4 everything

--[events]
--0 target
--1 dammage
--2 healing

function bf_event(event,actor,victim,value)	
	if(actor == NULL or victim == NULL) then return; end
	if(actor == "you") then actor = UnitName('player'); end
	if(victim == "you") then victim = UnitName('player'); end
	id1=Bub_ArraySearch(bub_namelist,actor);
	id2=Bub_ArraySearch(bub_namelist,victim);
	f1=getglobal("BF_"..id1);
	f2=getglobal("BF_"..id2);	
	if(id1 ~= -1 and (id2 == -1 or f2.hidden==1)) then	
		f1=getglobal("BF_"..id1);
		if(f1.hidden == 1) then return end
		faa=f1.auto_add
		if((event == 0 and faa == 4) or (event == 1 and (faa == 1 or faa == 3 or faa ==4)) or (event == 2 and (faa == 2 or faa == 3 or faa ==4))) then
			f2=bf_Spawn_from(f1,victim);
			id2=f2:GetID()
		end			
	elseif((id1 == -1 or f1.hidden==1) and id2 ~= -1) then	
		f2=getglobal("BF_"..id2);
		if(f2.hidden == 1) then return end
		faa=f2.auto_add
		if((event == 0 and faa == 4) or (event == 1 and (faa == 1 or faa == 3 or faa ==4)) or (event == 2 and (faa == 2 or faa == 3 or faa ==4))) then
			f1=bf_Spawn_from(f2,actor);
			id1=f1:GetID()
		end			
	end
	if(id1 ~= -1 and id2 ~= -1) then
		f1=getglobal("BF_"..id1);
		f2=getglobal("BF_"..id2);		
		if(f1.hidden ~= 1 and f2.hidden ~= 1) then
			if(event == 0) then
				line=bub_make_line(id1,id2,1,0.5,-1);
				if(bub_line_new(line) == 1) then
					if(line.id1 == id1) then
						bub_make_textbub(line.x2,line.y2,"T",{0,0,1});
					else 
						bub_make_textbub(line.x1,line.y1,"T",{0,0,1});
					end
				end			
			elseif(event == 1) then
				line=bub_make_line(id1,id2,1,0.5,{1,0,0});				
				if(line.id1 == id1) then
					bub_make_textbub(line.x2,line.y2,value,{1,0,0});
				else 
					bub_make_textbub(line.x1,line.y1,value,{1,0,0});
				end		
			elseif(event == 2) then
				line=bub_make_line(id1,id2,1,0.5,{0,1,0});				
				if(line.id1 == id1) then
					bub_make_textbub(line.x2,line.y2,value,{0,1,0});
				else 
					bub_make_textbub(line.x1,line.y1,value,{0,1,0});
				end
			end
		end
	end
end


function bubblesSlash_AP()
Bubbles_Add_ByID("player",(UIParent:GetWidth()/2),(UIParent:GetHeight()/2)+45);
for i=1,4 do 	
	x=(UIParent:GetWidth()/2)+sin(i*360/5)*45;
	y=(UIParent:GetHeight()/2)+cos(i*360/5)*45;
	Bubbles_Add_ByID("party"..i,x,y);
end
end

function bubblesSlash_AR()
for i=0,7 do
	for j=1,5 do
		k=i*5+j;
		x=(UIParent:GetWidth()/2)+sin(j*360/5+i*360/8)*45+sin(i*360/8)*200;
		y=(UIParent:GetHeight()/2)+cos(j*360/5+i*360/8)*45+cos(i*360/8)*200;
		Bubbles_Add_ByID("raid"..k,x,y);
	end
end
end

function bubbles_Create_On_Target()
x=BF_1:GetLeft()-BF_1:GetWidth()/2;
y=BF_1:GetBottom()-BF_1:GetHeight()/2;
Bubbles_Add_ByID("target",x,y);
end

--########################################################################
--LINES



function Bubbles_GetFree_Line()
line_i=line_i+1;
if(line_i > 999) then 
	line_i=1 
end
return line_i
end

function bub_find_line(id1,id2)
for i=1,line_i do 
	line=getglobal("BL_" .. i);
	if((line.id1 == id1 and line.id2 == id2) or (line.id2 == id1 and line.id1 == id2)) then
		return line
	end
end
return -1
end

function bub_make_line(id1,id2,fade_t1,fade_t2,color)
line=bub_find_line(id1,id2)
if(line == -1) then
	id=Bubbles_GetFree_Line()	
	line = bub_line_Connect(id,id1,id2)	
end

line.fade_t0=GetTime();
line.fade_t1=GetTime()+fade_t1;
line.fade_t2=GetTime()+fade_t1+fade_t2;
if(color ~= -1) then
	line.color_fade1 = line.fade_t1;
	line.color_fade2 = line.fade_t2;
	line.color=color
elseif(bub_line_new(line) == 1) then
	line.color={0.5,0.5,0.5}
	line.color_fade1 = GetTime()-5;
	line.color_fade2 = GetTime();
end
bub_obj_Fade(line);
return line
end


--/script bub_line_Connect(1,1,2)
function bub_line_Connect(id,id1,id2)
local line = getglobal("BL_" .. id);
line.tex = getglobal("BL_" .. id .. "Texture");
line.id1=id1;
line.id2=id2;
line.gf1=getglobal("BF_" .. id1);
line.gf2=getglobal("BF_" .. id2);
line:Show();
line.hidden=0;
bub_line_Position(line,id1,id2);
return line
end

function bub_line_OnUpdate()
if(this.gf1 == NULL or this.gf2 == NULL) then return; end
if(this.gf1.hidden == 1 or this.gf2.hidden == 1) then
	this:Hide();
	this.hidden=1;
	this.fade_t2=GetTime();	
else
	bub_line_Position(this,this.id1,this.id2);
	bub_obj_Fade(this);
end
end

function bub_line_new(line)
if(line.new ~= -1) then
	line.new = -1;
	return 1;
	end
return 0	
end

function bub_obj_Fade(obj)
if(obj.fade_t1 == NULL) then
	obj:Show();
	obj.hidden=0;
	return
end
if(obj.fade_t2 <= GetTime()) then
	obj:Hide();
	obj.hidden=1;
	line.new=1;
	return
end
obj:Show();
obj.hidden=0;
if(obj.fade_t1 < GetTime()) then
	per=1-(GetTime()-obj.fade_t1)/(obj.fade_t2-obj.fade_t1);
else
	per=1.0
end
if(obj.color_fade2 < GetTime()) then
	c={0.5,0.5,0.5}
elseif(obj.color_fade1 < GetTime()) then
	pero=1-(GetTime()-obj.color_fade1)/(obj.color_fade2-obj.color_fade1)
	perc=(GetTime()-obj.color_fade1)/(obj.color_fade2-obj.color_fade1)
	c={obj.color[1]*pero+0.5*perc,obj.color[2]*pero+0.5*perc,obj.color[3]*pero+0.5*perc}
else
	c={obj.color[1],obj.color[2],obj.color[3]}
end
obj.tex:SetVertexColor(c[1],c[2],c[3],per);
end

function bub_line_Position(line,id1,id2)   
   b1=getglobal("BF_"..id1);
   b2=getglobal("BF_"..id2);
   dx = b2:GetLeft()-b1:GetLeft();
   dy = b2:GetTop()-b1:GetTop();
   gx = b1:GetWidth()*0.5*(dx/sqrt(dx^2+dy^2));
   gy = b1:GetWidth()*0.5*(dy/sqrt(dx^2+dy^2));
   local linetext = line.tex;
   dx=dx-gx*2.
   dy=dy-gy*2.  
   line:ClearAllPoints();
   line.x1,line.y1 = b1:GetCenter();
   line.x1=line.x1+gx;
   line.y1=line.y1+gy;
   line.x2,line.y2 = b2:GetCenter();
   line.x2=line.x2-gx;
   line.y2=line.y2-gy;
   linetext:SetBlendMode("Add");
   if((dy < 0 and dx > 0) or (dy > 0 and dx < 0)) then
   linetext:SetTexture("Interface\\AddOns\\bubbles\\linedown-white"); 
   if(abs(dx) < 4 or abs(dy) < 4) then
   	linetext:SetTexture("Interface\\AddOns\\bubbles\\road-white"); 
	dx=max(abs(dx),3)*len(dx)
	dy=max(abs(dy),3)*len(dy)
   end
   line:SetPoint("BOTTOMLEFT",b1,"CENTER",0+gx,0+gy-256);
   linetext:SetHeight(abs(dy)*len(dx));
   linetext:SetWidth(abs(dx)*len(dx));
   linetext:SetTexCoord(0,min((min(abs(dx),abs(dy))/256.),1), 0, min(min(abs(dx),abs(dy))/256.,1));    
   else
   linetext:SetTexture("Interface\\AddOns\\bubbles\\lineup-white"); 
   if(abs(dx) < 4 or abs(dy) < 4) then
   	linetext:SetTexture("Interface\\AddOns\\bubbles\\road-white"); 
	dx=max(abs(dx),3)*len(dx)
	dy=max(abs(dy),3)*len(dy)
   end
   line:SetPoint("BOTTOMLEFT",b1,"CENTER",0+gx,dy-256+gy);
   linetext:SetHeight(dy);
   linetext:SetWidth(dx);
   linetext:SetTexCoord(max(1-(min(abs(dx),abs(dy))/256.),0),1, 0, min(min(abs(dx),abs(dy))/256.,1));   
   end   
end


--########################################################################
--SBT

--/script bub_line_textbub(BL_1,1,"t");

function bub_get_free_tb()
i=1
tb=getglobal("tb_"..i);
while(tb ~= Null) do
	if(tb.dead == 1) then return i;
	end
	i=i+1
	tb=getglobal("tb_"..i);
end
return i
end

function bub_make_textbub(x,y,text,color)
if(bub_event_bub==0) then return;end
id=bub_get_free_tb();
bub=getglobal("tb_"..id);
if(tb == Null) then 
	bub     = bubblesFrame:CreateTexture("tb_"..id,"FOREGROUND"); 
	bubtext = bubblesFrame:CreateFontString("tbtext_"..id,"FOREGROUND");
	bub.text=bubtext
end
bubtext=bub.text
bub:SetTexture("Interface\\Minimap\\Ping\\ping4.blp");
bub:SetBlendMode("Add");
bub:SetPoint("BOTTOMLEFT",UIParent,"BOTTOMLEFT",x,y);
bub:SetHeight(10+strlen(text)*5);
bub:SetWidth(10+strlen(text)*5);
bub:SetVertexColor(0.5,0.5,1,1);

bubtext:SetFont(bubbleText:GetFont(),10);
bubtext:SetFontObject(bubbleText:GetFontObject());
bubtext:SetPoint("CENTER", bub, "CENTER",0,0);
bubtext:SetText(text);
bubtext:SetVertexColor(color[1],color[2],color[3],1);
bub.dead=0;
bub:Show();
bub.dz=math.random()*5+5-strlen(text);
bub.text:Show();
end	

function bub_update_textbub(bub)
x = bub:GetLeft();
y = bub:GetBottom();

dx=(cos(mod(y*10,360)));
bub:ClearAllPoints();
bub:SetPoint("BOTTOMLEFT",UIParent,"BOTTOMLEFT",x+dx,y+bub.dz+math.random()*4-2);
if(y > 1000) then 
	bub.dead=1; 
	bub:Hide();
	bub.text:Hide();
end
end

function bub_update_textbubs()
i=1
tb=getglobal("tb_"..i);
while(tb ~= Null) do
	if(tb.dead ~= 1) then
		bub_update_textbub(tb);
	end
	i=i+1
	tb=getglobal("tb_"..i);
end
end
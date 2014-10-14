-- RABuffs_core.lua
--  Administrative/core elements.
-- Version 0.10.2

RAB_Lock = 1;

RABuffs_Version = "0.10.2";
RABuffs_DeciVersion = 0.100200;

RABui_Settings = {};
RABui_DefSettings = {
			Layout = {},
			updateInterval = 0.3,
			firstRun = true,
			enableGreeting = true,
			lastVersion=RABuffs_Version,
			stoppvp = true,
			castbigbuffs = false,
			alwayscastbigbuffs = false,
			syntaxhelp = true,
			lockwindow = false,
			colorizechat = true,
			dummymode = true,
			partymode = true,
			uilocale = "",
			outlocale = "",
			showsolo = true,
			showparty = true,
			showraid = true,
			trustctra = false,
			keepversions = false,
			enablefadingfx = true,
			showsampleoutputonclick = true,
			newestVersion="fresh",
			newestVersionTitle=RABuffs_Version,
			newestVersionPlayer="Default",
			newestVersionRealm="Default"
		 };
RABui_DefBars = {
			{class="ALL",cmd="alive",label="Alive",color={0.3,1,0.3},priority=1,out="RAID"},
			{class="ALL",cmd="mana pdsa",label="Healer",color={0.4,0.6,1},priority=1,out="RAID"},
			{class="ALL",cmd="mana mlh",label="DPS",color={0.2,0.2,1},priority=1,out="RAID"},
			{class="DRUID",cmd="motw",label="Mark",color={0.8,0.2,1},priority=10,out="RAID"},
			{class="DRUID",cmd="thorns",label="Thorns",color={0.8,0.6,1},priority=5,out="RAID"},
			{class="PRIEST",cmd="pwf",label="Fortitude",color={0.9,0.9,0.9},priority=10,out="RAID"},
			{class="PRIEST",cmd="sprot",label="Shadow Protection",color={0.6,0.6,0.6},priority=5,out="RAID"},
			{class="MAGE",cmd="ai",label="Intellect",color={0,0.6,1},priority=10,out="RAID"}
		};
RAB_ClassShort = {
			Mage="m",
			Warlock="l",
			Priest="p",
			Rogue="r",
			Druid="d",
			Hunter="h",
			Shaman="s",
			Warrior="w",
			Paladin="a"
		  };

RAB_CastLog = {}; -- Spell targets out of LoS. [unit] = expires;
RAB_CurrentGroupStatus = -1;


ptr = CreateFrame("Frame","RAB_CoreDummy", UIParent);
ptr.subscribers = {};
ptr:SetScript("OnEvent", function ()
  if (this.subscribers[event] ~= nil) then
   local key, val, unsub;
   for key, val in this.subscribers[event] do
    unsub = val();
    if (unsub == "remove") then
     this.subscribers[event][key] = nil;
    end
   end
  end
 end);
ptr:SetScript("OnUpdate", function ()
  if (this.timerNext ~= nil and this.timers ~= nil and this.timerNext < GetTime()) then
   local key, val, nt;
   nt = GetTime()+86400;
   for key, val in this.timers do
    if (val.trigger < GetTime() and val.enabled) then
     val.trigger = GetTime() + val.interval;
     okay = val.func();
    end
    nt = min(nt,val.trigger);
   end
  end
 end);
function RAB_Core_Register(event, key, func)
 if (RAB_CoreDummy.subscribers[event] == nil) then
  RAB_CoreDummy:RegisterEvent(event);
  RAB_CoreDummy.subscribers[event] = {};
 end
 if (RAB_CoreDummy.subscribers[event][key] == nil or RAB_CoreDummy.subscribers[event][key] == func) then
  RAB_CoreDummy.subscribers[event][key] = func;
 else
  RAB_Print("[RABuffs/Core] Register event/key conflict for " .. event .. ":" .. key .. "; ignoring add request.","warn");
 end
end
function RAB_Core_Unregister(event, key)
 if (RAB_CoreDummy.subscribers[event] ~= nil and RAB_CoreDummy.subscribers[event][key] ~= nil) then
  RAB_CoreDummy.subscribers[event][key] = nil;
  local k,v;
  for k,v in RAB_CoreDummy.subscribers[event] do
   return;
  end
  RAB_CoreDummy.subscribers[event] = nil;
  RAB_CoreDummy:UnregisterEvent(event);
 end
end
function RAB_Core_AddTimer(interval, key, func)
 if (RAB_CoreDummy.timers == nil) then
  RAB_CoreDummy.timers = {};
  RAB_CoreDummy.timerNext = GetTime() + interval;
 end
 tinsert(RAB_CoreDummy.timers,{interval=interval,id=key,trigger=GetTime()+interval,enabled=true,func=func});
end
function RAB_Core_RemoveTimer(id)
 if (RAB_CoreDummy.timers ~= nil) then
  local key, val;
  for key, val in RAB_CoreDummy.timers do
   if (val.id == id) then
    RAB_CoreDummy.timers[key] = nil;
   end
  end
 end
end
function RAB_Core_Raise(eve, ar1, ar2, ar3, ar4, ar5, ar6, ar7, ar8, ar9)
 if (RAB_CoreDummy.subscribers[eve] ~= nil) then
  local e, a1, a2, a3, a4, a5, a6, a7, a8, a9 = event, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9;
  event, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9 = eve, ar1, ar2, ar3, ar4, ar5, ar6, ar7, ar8, ar9;
  RAB_CoreDummy:GetScript("OnEvent")();
  event, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9 = e, a1, a2, a3, a4, a5, a6, a7, a8, a9;
 end
end
function RAB_Core_List()
 local key, val, k2, v2;
 for key, val in RAB_CoreDummy.subscribers do
  for k2, v2 in val do
   RAB_Print(key .. "." .. k2 .. ":" .. tostring(v2));
  end
 end
 for key, val in RAB_CoreDummy.timers do
  RAB_Print("TIMER: " .. val.id .. " " .. val.interval .. " " .. tostring(val.func));
 end
end

function RAB_StartUp()
 local key, val;
 for key, val in RABui_Settings do
  if (RABui_DefSettings[key] == nil) then
   RABui_Settings[key] = nil;
  end
 end
 for key, val in RABui_DefSettings do
  if (RABui_Settings[key] == nil) then
   RABui_Settings[key] = RABui_DefSettings[key];
  end
 end
 RABui_DefSettings = nil;

 if (RABui_Bars == nil) then -- First run, populate.
  if (RABui_Settings.Layout[GetCVar("realmName") .. "." .. UnitName("player") .. ".current"] ~= nil) then
   RABui_Bars = RABui_Settings.Layout[GetCVar("realmName") .. "." .. UnitName("player") .. ".current"];
  else
   local _, uc = UnitClass("player");
   RABui_Bars = {};
   for key, val in RABui_DefBars do
    if (val.class == uc or val.class == "ALL") then
     tinsert(RABui_Bars,val);
    end
   end
  end
 end
 RABui_DefBars = nil;

 RAB_Versions = type(RABui_Settings.keepversions) == "table" and RABui_Settings.keepversions or {};

 return "remove";
end
function RAB_CleanUp()
 if (GetChannelName(RAB_gSync_Channel) ~= 0) then
  LeaveChannelByName(RAB_gSync_Channel);
 end
 RABui_IsUIShown = (RABFrame:IsShown() == 1);

 RABui_Settings.Layout[GetCVar("realmName") .. "." .. UnitName("player") .. ".current"] = RABui_Bars;
 RABui_Bars = nil;
 RABui_Settings.keepversions = type(RABui_Settings.keepversions) == "table" and RAB_Versions or false;
end
function RAB_GroupStatusChange()
 local ns = 0;
 if (event == "CHAT_MSG_SYSTEM" and arg1 == ERR_RAID_YOU_JOINED) then
  ns = 2;
 elseif (event == "CHAT_MSG_SYSTEM" and arg1 == ERR_RAID_YOU_LEFT) then
  ns = 0;
 elseif (GetNumRaidMembers() > 0) then 
  ns = 2;
 elseif (GetNumPartyMembers() > 0) then
  ns = 1;
 end
 if (ns ~= RAB_CurrentGroupStatus) then
  RAB_Core_Raise("RAB_GROUPSTATUS",ns,RAB_CurrentGroupStatus);
  RAB_CurrentGroupStatus = ns;
 end
 if (event == "PLAYER_ENTERING_WORLD") then
  return "remove";
 end
end
RAB_Core_Register("PLAYER_ENTERING_WORLD","groupStatus",RAB_GroupStatusChange);
RAB_Core_Register("CHAT_MSG_SYSTEM","groupStatus",RAB_GroupStatusChange);
RAB_Core_Register("VARIABLES_LOADED","load",RAB_StartUp);
RAB_Core_Register("PLAYER_LOGOUT","unload",RAB_CleanUp);

function RAB_SendMessage(st,target, prefix) -- Chunk up at commas.
 if (target == "CONSOLE") then
  RAB_Print(st);
 elseif (strlen(st) < 256) then
  RAB_DoSendMessage(st,target);
 else
  local chunk1 = strsub(st,1,250);
  local chunk2 = strsub(st,251);
  local lcpos = strrpos(chunk1,",");
  chunk2 = "... " .. strsub(chunk1, lcpos+1) .. chunk2;
  chunk1 = strsub(chunk1, 1, lcpos) .. " ...";
  RAB_DoSendMessage(chunk1,target);
  RAB_SendMessage((prefix ~= nil and prefix or "") .. chunk2,target);
 end
end 
function RAB_DoSendMessage(st,target) -- Get a string, send a string
 local autoClearAFK = GetCVar("autoClearAFK");
 SetCVar("autoClearAFK", 0);
 if (target == "RAID" or target == "RAID_WARNING" or target == "GUILD" or target == "OFFICER" or target == "PARTY" or target == "SAY") then
  SendChatMessage(st,target);
 elseif (string.find(target,"CHANNEL:(%w+)") ~= nil) then
  local _,_,chan = string.find(target,"CHANNEL:(%w+)");
  local chanid = GetChannelName(chan);
  if (chanid ~= 0) then
   SendChatMessage(st, "CHANNEL", DEFAULT_CHAT_FRAME.editBox.language, chanid);
  else
   RAB_Print(string.format(sRAB_OutputLayerError_NotInChannel,chan),"warn");
  end
 else
  if (string.find(target,"WHISPER:(.+)") ~= nil) then
   _, _, target = string.find(target,"WHISPER:(.+)");
  end
  SendChatMessage(st, "WHISPER",  DEFAULT_CHAT_FRAME.editBox.language, target); 
 end
 SetCVar("autoClearAFK", autoClearAFK);
end


function RAB_GroupMembers(init) return RAB_GroupMember,init,0 end  
function RAB_GroupMember(state, i)
	local party_prefix, party_max, ok, group, u;
	if (UnitInRaid("player")) then
		party_prefix = "raid"; party_max = 40;
	else
		party_prefix = "party"; party_max = 5;
	end
	ok = false;

	local _, _, _, sGroupLimit, sClassLimit = string.find(state,"(%a*) ?(%d*) ?(%a*)");

	while true do
		i = i + 1;
		if (i > party_max) then return nil; end;
		u = party_prefix .. i;
		if (u == "party5") then u = "player" end
		_, _, group = GetRaidRosterInfo(i);
		if (UnitExists(u) and RAB_UnitClass(u) ~= nil) then
			if (sGroupLimit == "" or string.find(sGroupLimit,tostring(group)) ~= nil) then
				if (sClassLimit == "" or string.find(sClassLimit,RAB_ClassShort[RAB_UnitClass(u)]) ~= nil) then
					return i,u, group;
				end
			end
		end
	end
end

-- GENERAL BUFF-QUERY CODELINE.
function RAB_BuffCheckOutput(msg,outputTo,invert) -- Check query, output results (Called by the /rab handler (command UI), bar clicks (visual UI)).
	local _, _, cmd, grouplimit, classlimit = string.find(msg,"(%a+) ?(%d*) ?(%a*)");
	local out = (grouplimit ~= "" and grouplimit ~= "12345678") and ("[G" .. grouplimit .. "] ") or "";
	out = out .. (classlimit ~= "" and strlen(classlimit) < 8 and "[" .. classlimit .. "] " or "");
	if (RAB_Buffs[cmd] ~= nil) then
		local _,_,_,_,_,_, mtext, htext, invert2 = RAB_CallRaidBuffCheck(msg, false, true);
		if (invert2) then
			invert = not invert;
		end
		if (mtext == nil) then
			return;
		end
		out = out .. (invert and htext or mtext);
	else
		out = "Unknown buff requested ('".. cmd .."').";
		outputTo = "CONSOLE";
	end
	if (outputTo == "RAID" and not UnitInRaid("player")) then outputTo = "PARTY"; end
	out = sRAB_BuffOutputPrefix .. out;
	RAB_SendMessage(out,outputTo, sRAB_BuffOutputPrefix);
end
function RAB_CallRaidBuffCheck(msg, needraw, needtxt) -- Check query, return results (UI)
	local repl;
	if (RAB_Lock == 1) then
		return {total=0,buffed=0,txt=sRAB_Error_NotReady,hastxt=sRAB_Error_NotReady};
	end
	local _, _, cmd = string.find(msg,"(%a+)");


	if (RAB_Buffs ~= nil and RAB_Buffs[cmd] ~= nil and RAB_Buffs[cmd].queryFunc ~= nil) then
		return RAB_Buffs[cmd].queryFunc(msg, needraw, needtxt);
	elseif (RAB_Buffs ~= nil and RAB_Buffs[cmd] ~= nil) then
		return RAB_DefaultQueryHandler(msg, cmd, needraw, needtxt);
	else
		return 0,0,0,sRAB_Error_NoBuffDataBar,"","",sRAB_Error_NoBuffData,sRAB_Error_NoBuffData;
	end
end

function RAB_IsEligible(u,cmd)
 if (UnitIsConnected(u) and not RAB_UnitIsDead(u)) then
  if ((RAB_Buffs[cmd].ignoreMTs == nil or not RAB_CTRA_IsMT(UnitName(u))) and
      (RAB_Buffs[cmd].type ~= "self" or RAB_UnitClass(u) == RAB_Buffs[cmd].castClass) and
      (RAB_Buffs[cmd].ignoreClass == nil or string.find(RAB_Buffs[cmd].ignoreClass, RAB_ClassShort[RAB_UnitClass(u)]) == nil)) then
   return true;
  end
 end
 return false;
end
function RAB_IsSanePvP(target)
 return (RABui_Settings.stoppvp ~= true or UnitIsPVP("player")) or not UnitIsPVP(target);
end

-- Casting abstraction layer: get rid of errors in a humane way.
function RAB_CastSpell_Start(spellkey, muteobvious, mute)
 local sName = sRAB_SpellNames[spellkey];

 if (not RAB_CastSpell_IsCastable(spellkey, muteobvious, mute)) then
  return false;
 end

 RAB_SpellCast_ShouldRetarget = UnitExists("target");
 ClearTarget();
 local ok, reason = pcall(CastSpellByName,sName);
 if (not ok) then
  if (not mute) then RAB_Print(string.format(sRAB_CastingLayer_NoSpell,sRAB_SpellNames[spellkey]),"warn"); end
  if (RAB_SpellCast_ShouldRetarget) then TargetLastTarget(); end
  return false;
 end
 if (not SpellIsTargeting()) then
  if (RAB_SpellCast_ShouldRetarget and not SpellIsTargeting()) then TargetLastTarget(); end
  if (not mute) then RAB_Print(string.format(sRAB_CastBuff_CouldNotCast,sRAB_SpellNames[spellkey]),"warn"); end
  return false;
 end
 return true;
end
function RAB_CastSpell_IsCastable(spellkey, mute, muteobvious)
 if (sRAB_SpellNames[spellkey] == nil or sRAB_SpellIDs[spellkey] == nil) then
  if (not mute) then RAB_Print(string.format(sRAB_CastingLayer_NoEntry,spellkey),"warn"); end
  return false, "What";
 end
 if (RAB_UnitIsDead("player")) then
  if (not muteobvious) then RAB_Print(string.format(sRAB_CastingLayer_Dead,sRAB_SpellNames[spellkey]),"warn"); end
  return false, "Dead";
 end
 if (UnitMana("player") < RAB_SpellManaCost(sRAB_SpellIDs[spellkey],BOOKTYPE_SPELL)) then
  if (not muteobvious) then RAB_Print(string.format(sRAB_CastingLayer_NoMana,sRAB_SpellNames[spellkey]),"warn"); end
  return false, "Mana";
 end
 if (UnitOnTaxi("player")) then
  if (not muteobvious) then RAB_Print(string.format(sRAB_CastingLayer_NoMana,sRAB_SpellNames[spellkey]),"warn"); end
  return false, "Taxi";
 end
 local start, duration = GetSpellCooldown(sRAB_SpellIDs[spellkey],BOOKTYPE_SPELL);
 if (start ~= 0) then
  if (not mute) then RAB_Print(string.format(sRAB_CastingLayer_Cooldown,sRAB_SpellNames[spellkey]),"warn"); end
  return false, "Cooldown", start+duration-GetTime();
 end
 return true;
end
function RAB_CastSpell_Target(targ)
 if (SpellIsTargeting()) then
  SpellTargetUnit(targ);
  if (RAB_SpellCast_ShouldRetarget) then TargetLastTarget(); RAB_SpellCast_ShouldRetarget = false; end
  if (not UnitIsUnit("player",targ)) then RAB_CastLog[targ] = time() + 15; end
  return true;
 end
end
function RAB_CastSpell_Abort()
 if (SpellIsTargeting()) then
  SpellStopTargeting();
  if (RAB_SpellCast_ShouldRetarget) then TargetLastTarget(); RAB_SpellCast_ShouldRetarget = false; end
  return true;
 end
end

-- BACKGROUND CORE
function RAB_RaidMemberInfo(name) -- Is "Marvin" in raid?
 local i,u;
 for i,u in RAB_GroupMembers("all") do
  if (UnitName(u) == name) then
   local rank = 0;
   if (UnitInRaid("player")) then _, rank = GetRaidRosterInfo(i); end
   if (UnitIsPartyLeader(u)) then rank = 2; end
   return true, u, rank;
  end
 end
 return false,"", -1;
end
function RAB_TextureToBuff(text) -- Convert texture shotname to buff key, if known.
 if (strsub(text,1,16) == "Interface\\Icons\\") then
  text = strsub(text, 17);
 end
 local key,val,key2,val2;
 for key, val in RAB_Buffs do
  if (val.textures ~= nil) then
   for key2, val2 in val.textures do
    if (val2 == text) then
     return key;
    end
   end
  end
 end
 return nil;
end
function RAB_IsBuffUp(unit,bkey) -- Resolve and check a buff based on its key [Custom stuff doesn't work]
 local key, val, ret;
 if (RAB_Buffs[bkey].sfuncmodel == 2) then
  return RAB_Buffs[bkey].sfunc(unit);
 elseif (RAB_Buffs[bkey].sfuncmodel == 1) then
  for key,val in RAB_Buffs[bkey].textures do
   if (RAB_Buffs[bkey].sfunc(unit,val)) then
    return true;
   end
  end
  return false;
 elseif (RAB_Buffs[bkey].type == "debuff") then
  for key,val in RAB_Buffs[bkey].textures do
   if (isUnitDebuffUp(unit,val)) then
    return true;
   end
  end
  return false;
 elseif (RAB_Buffs[bkey].type == "special") then
  return nil;
 else
  for key,val in RAB_Buffs[bkey].textures do
   if (isUnitBuffUp(unit,val)) then
    return true;
   end
  end
  return false;
 end
end
function RAB_UnitClass(unit) -- Localization/nil workaround.
 local _, ec = UnitClass(unit);
 ec = (ec ~= nil) and ec or "Mage";
 return strsub(ec,1,1) .. strlower(strsub(ec,2));
end
function RAB_UnitIsDead(unit) -- Still hopelessly bugged.
 return (UnitIsDeadOrGhost(unit) and not isUnitBuffUp(unit,"Ability_Rogue_FeignDeath"));
end
function isUnitBuffUp(unit, buff) 
 if (unit == nil or not UnitExists(unit) or buff == nil) then
  return false;
 end
 local i = 1;
 while (UnitBuff(unit, i)) do
  if (string.find(UnitBuff(unit, i), buff)) then
   local _, stack = UnitBuff(unit,i);
   return true, stack;
  end
  i = i + 1;
 end
 return false;
end
function isUnitDebuffUp(unit, buff) 
 if (unit == nil or not UnitExists(unit) or buff == nil) then
  return false;
 end
 local i = 1;
 while (UnitDebuff(unit, i)) do
  if (string.find(UnitDebuff(unit, i), tostring(buff))) then
   local _, stack = UnitDebuff(unit,i);
   return true, stack;
  end
  i = i + 1;
 end
 return false;
end

function strrpos(str,chr)
 local start = string.find(str,chr,1,true);
 while string.find(str,chr,start+1,true) ~= nil do
  start = string.find(str,chr,start+1,true);
 end
 return start;
end
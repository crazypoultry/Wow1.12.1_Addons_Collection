-- RABuffs_data.lua
--  Dictionary between RABuffs_core.lua and user -- provides core-information for queriable effects.
-- Version 0.10.1
-- BLOCK 1: Query functions
-- BLOCK 2: Casting functions
-- BLOCK 3: Query definitions


RAB_PendingRes = {}; --Name=expire;
RAB_BuffTimers = {}; -- Name.query = expire;

function RAB_ShouldRecast(unit, cmd, isbuffed)
 local bkey = UnitName(unit) .. "." .. cmd;
 if (RAB_BuffTimers[bkey] ~= nil and RAB_BuffTimers[bkey] > GetTime() and RAB_Buffs[cmd].recast ~= nil) then
  if (isbuffed) then
   fadetime = RAB_BuffTimers[bkey] - GetTime();
   if (fadetime < RAB_Buffs[cmd].recast*60) then
    return true, fadetime;
   end
   return false, fadetime;
  else
   RAB_BuffTimers[bkey] = 0;
  end
 end
 return false;
end
function RAB_ResetRecastTimer(unit, cmd, castType)
 local i, u, g, m;
 if (castType == nil) then
  RAB_BuffTimers[UnitName(unit) .. "." .. cmd] = 0;
 elseif (castType == "group") then
  for i, u, g in RAB_GroupMembers("all") do
   if (UnitIsUnit(unit, u)) then
    m = g;
    break;
   end
  end
  for i, u, g in RAB_GroupMembers("all") do
   if (g == m) then
    RAB_BuffTimers[UnitName(u) .. "." .. cmd] = 0;
   end
  end
 elseif (castType == "class") then
  m = RAB_UnitClass(unit);
  for i, u, g in RAB_GroupMembers("all") do
   if (RAB_UnitClass(u) == m) then
    RAB_BuffTimers[UnitName(u) .. "." .. cmd] = 0;
   end
  end
 end
end


-- BLOCK 1: Query functions
function RAB_DefaultQueryHandler(query, cmd, needraw, needtxt)
 local buffed, fading, total, misc, txthead, hashead, txt, hastxt, invert, raw, rawsort, rawgroup = 0,0,0, "", "", "", "","", (RAB_Buffs[cmd].invert ~= nil);

 local buffname = RAB_Buffs[cmd].name;

 local i, u, key, val, group, isbuffed;

 local sfunc, sfuncmodel = RAB_Buffs[cmd].sfunc, RAB_Buffs[cmd].sfuncmodel;
 if (RAB_Buffs[cmd].sfunc == nil) then
  if (RAB_Buffs[cmd].type ~= "debuff") then
   sfunc, sfuncmodel = isUnitBuffUp, 1;
  else
   sfunc, sfuncmodel = isUnitDebuffUp, 1;
  end
 end
 if (needraw or needtxt) then
  raw = {}; rawsort = "group"; rawgroup = sRAB_Core_GroupFormat;
 end

 for i, u, group in RAB_GroupMembers(query) do
  local appl,fadetime, isFading = 0;
  if (RAB_IsEligible(u,cmd)) then
	isbuffed = false;
	if (sfuncmodel == 1) then
		for key, val in RAB_Buffs[cmd].textures do
			if (sfunc(u,val)) then
				isbuffed = true
				_, appl = sfunc(u,val);
				break;
			end
		end
	elseif (sfuncmodel == 2 and sfunc(u)) then
		isbuffed = true;
	end
	isFading, fadetime = RAB_ShouldRecast(u, cmd, isbuffed);
	fading = fading + (isFading and 1 or 0);
	if (needraw or needtxt) then
		tinsert(raw, {unit=u, name=UnitName(u) .. ((appl ~= nil and appl > 1) and " [" .. appl .. "]" or ""), class=RAB_UnitClass(u), group=group, buffed=isbuffed,fade=fadetime});
	end
        if (RAB_Buffs[cmd].unique == nil or (RAB_Buffs[cmd].unique == true and RAB_UnitClass(u) == RAB_Buffs[cmd].castClass)) then
		total = total + 1;
	end
	buffed = buffed + (isbuffed and 1 or 0);
   end
 end

 if (not (needraw or needtxt)) then
  return buffed, fading, total, "";
 end

 if (total > 1 and UnitInRaid("player") and (needraw or needtxt)) then 
  if (RAB_Buffs[cmd].sort == "class") then
   rawsort = "class"; rawgroup = "%s";
   table.sort(raw,function (a,b) return a.class < b.class end);
  else
   table.sort(raw,function (a,b) return a.group < b.group end);
  end
 end

 txthead = ((RAB_Buffs[cmd].missbuff ~= nil) and RAB_Buffs[cmd].missbuff or string.format(sRAB_BuffOutput_MissingOn, buffname)) .. ":";
 hashead = ((RAB_Buffs[cmd].havebuff ~= nil) and RAB_Buffs[cmd].havebuff or string.format(sRAB_BuffOutput_IsOn, buffname)) .. ":";

 if (table.getn(raw) > 0) then
  local ub, bb, uc, bc,ident = "","",0,0,false;

  for i=1,table.getn(raw) do
   if (ident ~= raw[i][rawsort] and ident ~= false) then
    if (uc == 0) then
     if (bc > 1) then
	hastxt = hastxt .. (hastxt ~= "" and ", " or "") .. (rawsort == "group" and sRAB_BuffOutput_Group or "") .. ident .. (rawsort == "class" and "s" or "") .. " [" .. bc .. "]";
     else
	hastxt = hastxt .. (hastxt ~= "" and ", " or "") .. bb;
     end
    elseif (bc == 0) then
     if (uc > 1) then
	txt = txt .. (txt ~= "" and ", " or "") .. (rawsort == "group" and sRAB_BuffOutput_Group  or "") .. ident  .. (rawsort == "class" and "s" or "") .. " [" .. uc .. "]";
     else
	txt = txt .. (txt ~= "" and ", " or "") .. ub;
     end
    else
	hastxt = hastxt .. (hastxt ~= "" and ", " or "") .. bb;
	txt = txt .. (txt ~= "" and ", " or "") .. ub;
    end
    ub, bb, uc, bc = "","",0,0;
   end
   ident = raw[i][rawsort];
   if (raw[i].buffed) then
    bc = bc + 1;
    bb = bb .. ((bb ~= "") and ", " or "") .. raw[i].name .. " [" .. raw[i].class .. "; G" .. raw[i].group .. "]";
   else
    uc = uc + 1;
    ub = ub .. ((ub ~= "") and ", " or "") .. raw[i].name .. " [" .. raw[i].class .. "; G" .. raw[i].group .. "]";
   end
  end
  if (uc == 0) then
   hastxt = hastxt .. (hastxt ~= "" and ", " or "") .. (rawsort == "group" and sRAB_BuffOutput_Group  or "") .. ident .. (rawsort == "class" and "s" or "")  .. " [" .. bc .. "]";
  elseif (bc == 0) then
   txt = txt .. (txt ~= "" and ", " or "") .. (rawsort == "group" and sRAB_BuffOutput_Group  or "") .. ident .. (rawsort == "class" and "s" or "")  .. " [" .. uc .. "]";
  else
   hastxt = hastxt .. (hastxt ~= "" and ", " or "") .. bb;
   txt = txt .. (txt ~= "" and ", " or "") .. ub;
  end

  if (buffed == total and total > 0) then
   txt = string.format(sRAB_BuffOutput_EveryoneHas, RAB_Buffs[cmd].name);
   hastxt = txt;
  elseif (buffed > 0) then
   txt = txthead .. " [" .. (total - buffed) .. " / " .. total .. "] " .. txt .. ".";
   hastxt = hashead .. " [" .. buffed .. " / " .. total .. "] " .. hastxt .. ".";
  else
   txt = string.format(sRAB_BuffOutput_EveryoneMissing, RAB_Buffs[cmd].name);
   hastxt = txt;
  end
 else
  txt = RAB_Buffs[cmd].name .. ": not applicable.";
  hastxt = RAB_Buffs[cmd].name .. ": not applicable.";
 end

 return buffed, fading, total, misc, txthead, hashead, txt, hastxt, invert, raw, rawsort, rawgroup;
end

function RAB_QueryStatus(msg) -- Overview.
	local out, buffed, total = "", 0, 0;
	local _, _, glspaced = string.find(msg,"%a+( %w+)");
	if (glspaced == nil) then
		glspaced = "";
	end
	buffed, _, total = RAB_CallRaidBuffCheck("ai" .. glspaced,false,false);
	out = out .. "AI: " .. buffed .. "/" .. total .. ", ";
	buffed, _, total = RAB_CallRaidBuffCheck("pwf" .. glspaced,false,false);
	out = out .. "PWF: " ..  buffed .. "/" .. total .. ", ";
	buffed, _, total = RAB_CallRaidBuffCheck("motw" .. glspaced,false,false);
	out = out .. "MoTW: " ..  buffed .. "/" .. total .. ", ";
	buffed, _, total = RAB_CallRaidBuffCheck("bos" .. glspaced,false,false);
	out = out .. "BoS: " ..  buffed .. "/" .. total .. ", ";
	buffed, _, total = RAB_CallRaidBuffCheck("bok" .. glspaced,false,false);
	out = out .. "BoK: " ..  buffed .. "/" .. total .. ", ";
	buffed, _, total = RAB_CallRaidBuffCheck("bow" .. glspaced,false,false);
	out = out .. "BoW: " ..  buffed .. "/" .. total .. ", ";
	buffed, _, total = RAB_CallRaidBuffCheck("ss" .. glspaced,false,false);
	out = out .. buffed .. " SS.";	
	return 1,0,1,"","","",out,out;
end
function RAB_QueryBlank()
 return 0, 0, 0, "";
end
function RAB_QueryBuffInfo()
	local buffs, debuffs, i,b, bn = "","",1;
	if (not UnitExists("target")) then
		return 0,0,0,"","","",sRAB_BuffOutput_BuffInfo_NoTarget,sRAB_BuffOutput_BuffInfo_NoTarget, false;
	end
	while (UnitBuff("target",i)) do
		b = string.sub(UnitBuff("target",i),17);
		bn = RAB_TextureToBuff(b);
		if (bn ~= nil) then
			b = "[" .. RAB_Buffs[bn].name .. "]";
		end
		buffs = buffs .. (buffs  == "" and "" or ", ") .. b;
		i = i + 1;
	end
	i = 1;
	while (UnitDebuff("target",i)) do
		b = string.sub(UnitDebuff("target",i),17);
		debuffs = debuffs .. (debuffs == "" and "" or ", ") .. b;
		i = i + 1;
	end
	local text = string.format(sRAB_BuffOutput_BuffInfo_General,UnitName("target"),(buffs == "" and sRAB_BuffOutput_BuffInfo_None or buffs), (debuffs == "" and sRAB_BuffOutput_BuffInfo_None or debuffs));
	return 0,0,0,"","","",text,text;
end
function RAB_QueryHere(msg,needraw,needtxt)
	local buffed, total, misc, txthead, hashead, txt, hastxt, invert, raw, rawsort = 0,0, "", sRAB_BuffOutput_Here_NotHere, sRAB_BuffOutput_Here_Here, sRAB_BuffOutput_Here_NotHere .. " ",sRAB_BuffOutput_Here_Here .. " ", false, nil, "append";
	if (needraw) then raw = {}; end
	local inraid = UnitInRaid("player");
	local myzone = "noraid";
	local zone, group;

	if (inraid) then
		for i=1,40 do 
			if (UnitIsUnit("raid" .. i, "player")) then
				 _, _, group, _, _, _, myzone = GetRaidRosterInfo(i);
			end
		end
	end

	local isbuffed, append;
	for i,u,group in RAB_GroupMembers(msg) do
		if (inraid) then
			_, _, group, _, _, _, zone = GetRaidRosterInfo(i);
			zone = tostring(zone);
			group = tonumber(group);
		else
			zone = sRAB_BuffOutput_Here_OK;
			group = 1;
		end
		total = total + 1; append = ""; isbuffed = false;
		if (inraid and RAB_CTRA_IsAFK(UnitName(u))) then
			if (needtxt) then txt =  txt .. UnitName(u) .. " [" .. sRAB_BuffOutput_Here_AFK .. "], "; end
			if (needraw) then zone = sRAB_BuffOutput_Here_AFK; end
		elseif (not UnitIsConnected(u)) then
			if (needtxt) then txt =  txt .. UnitName(u) .. " [" .. sRAB_BuffOutput_Here_OFF .. "], "; end
			if (needraw) then zone = sRAB_BuffOutput_Here_OFF; end
		elseif (inraid and (zone ~= myzone and not UnitIsVisible(u))) then
			if (needtxt) then txt =  txt ..  UnitName(u) .. " [" .. zone .. "], "; end
		elseif (not UnitIsVisible(u)) then
			if (needtxt) then txt =  txt ..  UnitName(u) .. " [" .. sRAB_BuffOutput_Here_OOS .. "], "; end
			if (needraw) then zone = sRAB_BuffOutput_Here_OOS; end
		else
			if (needtxt) then hastxt = hastxt .. UnitName(u) .. ", "; end
			buffed = buffed + 1; isbuffed = true;
		end
--		if (UnitInRaid("player")) then append = " [" .. group .. "]"; end
		if (needraw) then tinsert(raw, {name=UnitName(u),class=RAB_UnitClass(u),group=group,buffed=false,unit=u,append=append,buffed=isbuffed,zone=zone}); end
	end
	if (total > 1 and needraw and UnitInRaid("player")) then 
		table.sort(raw,function (a,b) return a.zone < b.zone end);
	end
	if (needtxt) then
		if (buffed == total) then
			txt = sRAB_BuffOutput_Here_Everyone;
			hastxt = sRAB_BuffOutput_Here_Everyone;
		else
			txt = strsub(txt,1,-3) .. ".";
			hastxt = strsub(hastxt,1,-3) .. ".";
		end
	end
	return buffed, 0, total, misc, txthead, hashead, txt, hastxt, invert, raw, "zone", "%s";
end
function RAB_QueryCTRAVersion(msg, needraw, needtxt)
	local buffed, total, misc, txthead, hashead, txt, hastxt, invert, raw, rawsort = 0,0, "", sRAB_BuffOutput_CTRA_OutOfDate, sRAB_BuffOutput_CTRA_Recent, sRAB_BuffOutput_CTRA_OutOfDate .. " ",sRAB_BuffOutput_CTRA_Recent .. " ", false;
	if (needraw) then raw = {}; rawsort = "group"; end
	if (RAB_CTRA_ResponsibleHandler ~= "CTRA") then
		return 0, 0, 0, sRAB_BuffOutput_CTRA_NoCTRA, "", "", sRAB_BuffOutput_CTRA_NoCTRA, sRAB_BuffOutput_CTRA_NoCTRA;
	end
	local i, pv, isbuffed = 1, RAB_CTRA_GetVersion(UnitName("player"));

	if (not UnitInRaid("player")) then
		txt = sRAB_BuffOutput_CTRA_NotInRaid;
		hastxt = txt;
	else
		for i,u,group in RAB_GroupMembers(msg) do
			local cv = RAB_CTRA_GetVersion(UnitName(u));
			if (cv) then
				total = total + 1; isbuffed = false; append = "";
				if (cv >= pv) then
					isbuffed = true; buffed = buffed + 1;
					hastxt = hastxt .. UnitName(u) .. ", ";
				else			
					txt = txt .. UnitName(u) .. " [" .. cv .. "], ";
				end
				if (needraw) then tinsert(raw, {name=UnitName(u),class=RAB_UnitClass(u),group=group,buffed=isbuffed,unit=u, version=cv}); end
			end
		end
		if (total > 1 and UnitInRaid("player") and needraw) then 
			table.sort(raw,function (a,b) return a.version < b.version end);
		end
		if (needtxt) then
			if (buffed == total) then
				txt = sRAB_BuffOutput_CTRA_Everyone; hastxt = sRAB_BuffOutput_CTRA_Everyone;
			else
				txt = strsub(txt,1,-3) .. ".";
				hastxt = strsub(hastxt,1,-3) .. ".";
			end
		end
	end
	return buffed, 0, total, misc, txthead, hashead, txt, hastxt, invert, raw, "version", "%s";
end
function RAB_ScanRaid(msg)
	local _,_,bkey = string.find(msg,"(%a+)");
	local scanwhat = RAB_Buffs[bkey].ext;
	local out, oc, key, val = "", {};
	for i,u,group in RAB_GroupMembers(msg) do
		local j = 1;
		while (UnitBuff(u,j)) do
			b = RAB_TextureToBuff(string.sub(UnitBuff(u,j),17));
			if (b ~= nil and scanwhat == "known") then
				oc[b] = (oc[b] ~= nil and oc[b] or 0) + 1;
			elseif (b == nil and scanwhat == "unknown") then
				b = string.sub(UnitBuff(u,j),17);
				oc[b] = (oc[b] ~= nil and oc[b] or 0) + 1;				
			end
			j = j + 1;
		end
	end
	for key, val in oc do 
		out = (out == "" and "" or (out .. ", ")) .. "[" .. (scanwhat == "known" and RAB_Buffs[key].name or key) .. "]x" .. val;
	end

	out = (scanwhat == "known" and "B" or "Unknown b") .. "uffs: " .. (out == "" and "none" or out) .. ".";
	return 1,1,"","","", out, out;
end
function RAB_QueryHealth(msg, needraw, needtxt)
	local _,_,bkey = string.find(msg,"(%a+)");
	local type = RAB_Buffs[bkey].ext;
	local buffed, fading, total, misc, txthead, hashead, txt, hastxt, invert, raw, rawsort = 0,0,0, "", sRAB_BuffOutput_Health_Dead, sRAB_BuffOutput_Health_Alive,"","", false;
	local i,hp_cur, hp_max, hp_alive, hp_dead, hp_deadtext,hp_alivetext = 0,0,0,0,0,"","";
	if (needraw) then raw = {}; end
	local group, uinfo,u, isbuffed, append;

	for i,u,group in RAB_GroupMembers(msg) do
		total = total + 1; append = ""; isbuffed = false;
		if (RAB_UnitIsDead(u)) then
			hp_dead = hp_dead + 1;
			hp_deadtext = (hp_dead == 1 and "" or (hp_deadtext .. ", ")) .. UnitName(u);
		else				
			hp_alive = hp_alive + 1;
			hp_alivetext = (hp_alive == 1 and "" or (hp_alivetext .. ", ")) .. UnitName(u);
			hp_cur = hp_cur + UnitHealth(u);
			hp_max = hp_max + UnitHealthMax(u);
			buffed = buffed + 1; isbuffed = true;
			if (UnitHealth(u) / UnitHealthMax(u) < 0.15) then
				fading = fading + 1;
			end
		end
		if (needraw) then tinsert(raw, {name=UnitName(u),class=RAB_UnitClass(u),group=group,buffed=isbuffed,unit=u,append=append}); end
	end 
	if (total > 1 and UnitInRaid("player") and needraw) then 
		table.sort(raw,function (a,b) return a.group < b.group end);
	end
	if (hp_dead > 0) then
		misc = string.format(sRAB_BuffOutput_Health_Misc,hp_dead);
	end

	if (type == "hp") then
		buffed = hp_cur; 
		total = hp_max;
		fading = 0;
	end
	if (needtxt) then
		if (hp_dead > 0) then
			if (hp_alive > 0) then
				txt = string.format(sRAB_BuffOutput_Health_Default,hp_cur, hp_max, floor(hp_cur*100/(hp_max > 0 and hp_max or 1)), string.format(sRAB_BuffOutput_Health_DeadPart,hp_dead, hp_deadtext));
				hastxt = string.format(sRAB_BuffOutput_Health_Default,hp_cur, hp_max, floor(hp_cur*100/(hp_max > 0 and hp_max or 1)), string.format(sRAB_BuffOutput_Health_AlivePart,hp_alive, hp_alivetext));
			else
				repl.txt = sRAB_BuffOutput_Health_EveryoneDead;
				repl.hastxt = sRAB_BuffOutput_Health_EveryoneDead;
			end
		else
			txt = string.format(sRAB_BuffOutput_Health_Default,hp_cur, hp_max, floor(hp_cur*100/(hp_max > 0 and hp_max or 1)), ".");
			hastxt = txt;
		end
	end
	return buffed, fading, total, misc, txthead, hashead, txt, hastxt, invert, raw, "group", sRAB_Core_GroupFormat;
end
function RAB_QueryInventoryItem(msg, needraw, needtxt)
	local _,_,bkey = string.find(msg,"(%a+)");
	local _,_, slot, match = string.find(RAB_Buffs[bkey].ext,"(%d+):(%d+)");
	slot,match = tonumber(slot), tonumber(match);
	local itemName = GetItemInfo(match);
	if (itemName == nil) then itemName = string.format(sRAB_BuffOutput_Item_Unknown,match); end


	local buffed, total, misc, txthead, hashead, txt, hastxt, invert, raw, rawsort = 0,0, "", string.format(sRAB_BuffOutput_Item_Missing,itemName), string.format(sRAB_BuffOutput_Item_Have,itemName),"","", false;
	if (needraw) then raw = {}; end
	local i, u, group, isbuffed, item;

	for i,u,group in RAB_GroupMembers(msg) do
		if (CheckInteractDistance(u,1) and GetInventoryItemLink(u,slot)) then
			total = total + 1; isbuffed = false;
			_,_, item = string.find(tostring(GetInventoryItemLink(u,slot)),"item:(%d+):");
			if (tonumber(item) == match) then
				isbuffed = true; buffed = buffed + 1;
				hastxt =  hastxt .. UnitName(u) .. ", ";
			else
				txt =  txt .. UnitName(u) .. ", ";
			end
			if (needraw) then tinsert(raw, {name=UnitName(u),class=RAB_UnitClass(u),group=group,buffed=isbuffed,unit=u,append=append}); end
		end
	end 
	if (total > 1 and UnitInRaid("player") and needraw) then 
		table.sort(raw,function (a,b) return a.group < b.group end);
	end

	if (needtxt) then
		if (buffed == total) then
			txt = string.format(sRAB_BuffOutput_Item_Everyone,itemName);
			hastxt = string.format(sRAB_BuffOutput_Item_Everyone,itemName);
		elseif (buffed > 0) then
			txt = txthead .. " " .. strsub(txt,1,-3) .. ".";
			hastxt = hashead .. " " .. strsub(hastxt,1,-3) .. ".";
		else
			txt = string.format(sRAB_BuffOutput_Item_NoOne,itemName);
			hastxt = string.format(sRAB_BuffOutput_Item_NoOne,itemName);
		end
	end
	return buffed, 0, total, misc, txthead, hashead, txt, hastxt, invert, raw, "group", sRAB_Core_GroupFormat;
end
function RAB_QueryMana(msg, needraw, needtxt)
	local buffed, fading, total, misc, txthead, hashead, txt, hastxt, invert, raw, rawsort = 0,0,0, "", sRAB_BuffOutput_Mana_OutOfMana, sRAB_BuffOutput_Mana_Fine,"","", false;
	local mana_max, mana_cur, mana_dead, mana_oom, mana_oomt = 0,0,0,0, "";
	if (needraw) then raw = {}; end
	local group, u, i, isbuffed, append = 0,"",0;

	for i,u,group in RAB_GroupMembers(msg) do
		if (UnitPowerType(u) == 0) then 
			total = total + 1; isbuffed = false; append = "";
			if (RAB_UnitIsDead(u)) then
				mana_dead = mana_dead + 1;
				append = sRAB_BuffOutput_Mana_DeadAppend;
			else
				mana_cur = mana_cur + UnitMana(u);
				mana_max = mana_max + UnitManaMax(u);
				if (UnitMana(u) < UnitManaMax(u) * 0.15) then
					mana_oom = mana_oom + 1;
					append = " (" .. UnitMana(u).. " mana)";
				else
					append = " (" .. floor(UnitMana(u) * 100 / UnitManaMax(u)).. "%)";
					isbuffed = true;
					if (UnitMana(u) < UnitManaMax(u) * 0.25) then
						fading = fading + UnitMana(u);
					end
				end

			end
			if (needraw) then tinsert(raw, {name=UnitName(u), class=RAB_UnitClass(u), group=group, buffed=isbuffed, unit=u, append=append}); end
		end 
	end
	if (total > 1 and UnitInRaid("player") and needraw) then 
		table.sort(raw,function (a,b) return a.group < b.group end);
	end
	buffed, total = mana_cur, mana_max;

	if (mana_oom > 0 or mana_dead > 0) then
		misc = " (" .. mana_oom .. " oom; " .. mana_dead .. " dead)";
		misc = string.gsub(string.gsub(misc,"; 0 dead",""),"0 oom; ","");
	end

	if (needtxt) then
		txt = "Mana: " .. mana_cur .. " / " .. mana_max .. " (" .. (mana_max > 0 and floor(mana_cur*100/mana_max) or "0") .. "%); " .. mana_oom .. " oom; " .. mana_dead .. " dead.";
		txt = string.gsub(string.gsub(txt,"; 0 oom",""),"; 0 dead","");
		hastxt = txt;	
	end
	return buffed, fading, total, misc, txthead, hashead, txt, hastxt, invert, raw, "group", sRAB_Core_GroupFormat;
end
function RAB_QueryWater(msg,needraw,needtxt)
	local buffed, total, misc, txthead, hashead, txt, hastxt, invert, raw, rawsort = 0,0, "", sRAB_BuffOutput_Water_Out, sRAB_BuffOutput_Water_Have, sRAB_BuffOutput_Water_Out .. " ",sRAB_BuffOutput_Water_Have .. " ", false;
	if (needraw) then raw = {}; end

	local isbuffed, append;
	for i,u,group in RAB_GroupMembers(msg) do
		if (UnitIsUnit(u,"player")) then
			RAB_BuffTimers[UnitName(u) .. ".h2oc"] = RAB_CountItems(8079);
		end
		if (RAB_BuffTimers[UnitName(u) .. ".h2oc"] ~= nil) then
			total = total + 1; append = " [" .. RAB_BuffTimers[UnitName(u) .. ".h2oc"] .. "]" ; isbuffed = false;
			isbuffed = (RAB_BuffTimers[UnitName(u) .. ".h2oc"] > 3);
			if (needtxt and isbuffed) then 
				hastxt =  hastxt .. UnitName(u) .. " [" .. RAB_BuffTimers[UnitName(u) .. ".h2oc"] .. "], ";
			elseif (needtxt and not isbuffed) then
				txt =  txt .. UnitName(u) .. " [" .. RAB_BuffTimers[UnitName(u) .. ".h2oc"] .. "], ";
			end
			if (isbuffed) then buffed = buffed + 1; end
			if (needraw) then tinsert(raw, {name=UnitName(u),class=RAB_UnitClass(u),group=group,unit=u,append=append,buffed=isbuffed}); end
		end
	end
	if (total > 1 and needraw and UnitInRaid("player")) then 
		table.sort(raw,function (a,b) return a.group < b.group end);
	end
	if (needtxt) then
		if (buffed == total) then
			txt = sRAB_BuffOutput_Water_Everyone;
			hastxt = sRAB_BuffOutput_Water_Everyone;
		else
			txt = strsub(txt,1,-3) .. ".";
			hastxt = strsub(hastxt,1,-3) .. ".";
		end
	end
	return buffed, 0, total, misc, txthead, hashead, txt, hastxt, invert, raw, rawsort, false;
end

function RAB_QueryDebuff(msg,needraw,needtxt)
	local _,_,bkey = string.find(msg,"(%a+)");
	local btype = RAB_Buffs[bkey].ext
	local bText = getglobal("sRAB_BuffOutput_Debuff_" .. (btype == "" and "Typeless" or (btype == "SELF" and "Curable" or btype)));

	local buffed, total, misc, txthead, hashead, txt, hastxt, invert, raw, rawsort = 0,0, "", string.format(sRAB_BuffOutput_Debuff_NotHave,bText), string.format(sRAB_BuffOutput_Debuff_Have,bText),"","", true;
	if (needraw) then raw = {}; end
	local i, u, group, j, isbuffed, item;
	local f = (btype == "SELF") and 1 or 0;
	for i,u,group in RAB_GroupMembers(msg) do
		if (not RAB_UnitIsDead(u)) then
			total = total + 1;
			j, isbuffed = 1, false;
			while (UnitDebuff(u,j,f) ~= nil) do
				local tex, app, type = UnitDebuff(u,j,f);
				if (f == 1 or type == btype or (type == nil and btype == "")) then
					isbuffed = true;
					break;
				end
				j = j + 1;
			end
			if (needtxt and isbuffed) then 
				hastxt =  hastxt .. UnitName(u) .. ", ";
			elseif (needtxt and not isbuffed) then
				txt =  txt .. UnitName(u) .. ", ";
			end
			if (isbuffed) then buffed = buffed + 1; end
			if (needraw) then tinsert(raw, {name=UnitName(u),class=RAB_UnitClass(u),group=group,unit=u,append=append,buffed=isbuffed}); end
		end
	end 
	if (total > 1 and UnitInRaid("player") and needraw) then 
		table.sort(raw,function (a,b) return a.group < b.group end);
	end

	if (needtxt) then
		if (buffed == total) then
			txt = string.format(sRAB_BuffOutput_Debuff_Everyone, bText);
			hastxt = txt;
		elseif (buffed > 0) then
			txt = txthead .. " " .. strsub(txt,1,-3) .. ".";
			hastxt = hashead .. " " .. strsub(hastxt,1,-3) .. ".";
		else
			txt = string.format(sRAB_BuffOutput_Debuff_NoOne, bText);
			hastxt = txt;
		end
	end
	return buffed, 0, total, misc, txthead, hashead, txt, hastxt, invert, raw, "group", sRAB_Core_GroupFormat;
end

function RAB_CountItems(itemId, justNeedSlot)
 local bag, slot, count = 0,0,0;

 itemId = tostring(itemId);
 for i=0, 4 do
  for j = 1, GetContainerNumSlots(i) do
   local link = GetContainerItemLink(i, j);
   if (link ~= nil) then
    local _, _, id = string.find(link, "item:(%d+):");
    if (id == itemId) then
     local _, itemCount = GetContainerItemInfo(i,j);
     count = count + itemCount;
     bag, slot = i, j;
     if (justNeedSlot ~= nil) then return count, bag, slot; end
    end
   end
  end
 end
 return count, bag, slot;
end

-- BLOCK 2: Casting functions

function RAB_DefaultCastingHandler(mode, query)
 local _,_, cmd = string.find(query,"^(%a+)");
 local clicktocast = sRAB_Tooltip_ClickToCast;


 if (RAB_Buffs[cmd].castClass ~= RAB_UnitClass("player") or sRAB_SpellNames[cmd] == nil) then
  return false;
 end
 if (mode == "tip" and RAB_IsBuffUp("player","druidshift")) then
  return sRAB_Tooltip_CastFail_Shapeshift;
 end

 if (RAB_Buffs[cmd].type == "self" or RAB_Buffs[cmd].type == "aura") then
  local isup = RAB_IsBuffUp("player",cmd);
  if (RAB_ShouldRecast("player",cmd,isup)) then
   clicktocast = sRAB_Tooltip_ClickToRecast;
  elseif (isup) then
   return false;
  end
  local buff = sRAB_SpellNames[cmd];
  local canbuff, reason, howmuch = RAB_CastSpell_IsCastable(cmd,true,true);
  if (not (canbuff or dogroupbuff)) then
   if (reason == "Cooldown") then
    return mode == "tip" and string.format(getglobal("sRAB_Tooltip_CastFail_" .. reason),floor(howmuch*10)/10) or false;
   else
    return mode == "tip" and getglobal("sRAB_Tooltip_CastFail_" .. reason) or false;
   end
  end
  if (mode == "tip") then
   return string.format(clicktocast, buff, RAB_Chat_Colors[RAB_UnitClass("player")] .. UnitName("player"));
  elseif (mode == "cast") then
   CastSpellByName(buff,true);
   RAB_ResetRecastTimer("player",cmd);
   RAB_Print(string.format(sRAB_CastBuff_CastNeutral,buff));
   return true;
  end
 end


 local dogroupbuff, mygroup = IsAltKeyDown(), 0;
 if (RABui_Settings.castbigbuffs) then dogroupbuff = not dogroupbuff; end
 if (RAB_Buffs[cmd].bigcast == nil or not RAB_CastSpell_IsCastable(RAB_Buffs[cmd].bigcast,true,true)) then dogroupbuff = false; end

 local canbuff, reason, howmuch = RAB_CastSpell_IsCastable(cmd,true,true);
 if (not (canbuff or dogroupbuff)) then
  if (reason == "Cooldown") then
   return mode == "tip" and string.format(getglobal("sRAB_Tooltip_CastFail_" .. reason),floor(howmuch*10)/10) or false;
  else
   return mode == "tip" and getglobal("sRAB_Tooltip_CastFail_" .. reason) or false;
  end
 end

 if (UnitInRaid("player") and RABui_Settings.partymode == true) then
  for i=1,40 do 
   if (UnitIsUnit("raid" .. i, "player")) then
    _, _, mygroup = GetRaidRosterInfo(i);
    break;
   end
  end
 end 

 local people, group, i, u, g, ir = {};
 if (mode == "cast") then
  if (not RAB_CastSpell_Start(cmd)) then
   return false;
  end
 end
 local faderenew, pvpfail, rangefail = {},0,0;
 for i, u, g in RAB_GroupMembers(query) do
  local ekey = UnitName(u) .. "." .. cmd;
  local pri = UnitIsUnit("player",u) and (RAB_Buffs[cmd].selfPriority ~= nil and RAB_Buffs[cmd].selfPriority or 5) or 1;
  if (g == mygroup) then pri = pri + 1; end
  if (RAB_CastLog[u] ~= nil and RAB_CastLog[u] >= time()) then pri = pri / 10; end
  if (RAB_Buffs[cmd].priority ~= nil and RAB_Buffs[cmd].priority[strlower(RAB_UnitClass(u))] ~= nil) then pri = pri + RAB_Buffs[cmd].priority[strlower(RAB_UnitClass(u))]; end
  if (RAB_IsEligible(u,cmd) and RAB_IsSanePvP(u) and RAB_RangeCheck(mode, u, cmd) and pri > 0) then
   if (not RAB_IsBuffUp(u,cmd)) then
    tinsert(people,{u=u,group=g,class=RAB_UnitClass(u),p=pri});
   elseif (RAB_ShouldRecast(u, cmd, true) and pri > 0) then
    pri = 10000-RAB_BuffTimers[ekey]+GetTime();
    if (RAB_CastLog[u] ~= nil and RAB_CastLog[u] >= time()) then pri = pri / 10; end
    tinsert(faderenew,{u=u,group=g,class=RAB_UnitClass(u),p=pri})
   end
  elseif (RAB_IsEligible(u,cmd) and pri > 0) then
   if (not RAB_IsSanePvP(u)) then
    pvpfail = pvpfail + 1;
   elseif (not RAB_IsBuffUp(u,cmd) and not RAB_RangeCheck(mode,u,cmd)) then
    rangefail = rangefail + 1;
   end
  end
 end


 if (table.getn(people) == 0 and table.getn(faderenew) == 0) then
  if (mode == "cast") then 
   RAB_CastSpell_Abort(); 
   if (pvpfail > 0 or rangefail > 0) then
    UIErrorsFrame:AddMessage( string.format(sRAB_CastingLayer_NoCast, RAB_Buffs[cmd].name, pvpfail, rangefail), 1, 0, 0, 1, 1.5);
   else
    UIErrorsFrame:AddMessage( string.format(sRAB_CastingLayer_NoNeed, RAB_Buffs[cmd].name), 1, 0, 0, 1, 1.5);
   end
  end
  return false;
 elseif (table.getn(people) == 0) then
  people = faderenew;
  clicktocast = sRAB_Tooltip_ClickToRecast;
 end

 if (dogroupbuff and table.getn(people) < RAB_Buffs[cmd].bigthreshold and not RABui_Settings.alwayscastbigbuffs) then dogroupbuff = false; end
 if (dogroupbuff) then
  local bsort, bsortkeys, stype = {}, {}, RAB_Buffs[cmd].bigsort;
  for key, val in people do
   if (bsortkeys[val[stype]] == nil) then
    tinsert(bsort,{pri=val.p,cast=val.u,heads=1,key=val[stype]});
    bsortkeys[val[stype]] = table.getn(bsort);
   else
    local ckey = bsortkeys[val[stype]];
    bsort[ckey].pri, bsort[ckey].heads = bsort[ckey].pri + val.p, bsort[ckey].heads + 1;
   end
  end
  table.sort(bsort,function (a,b) return (a.heads == b.heads) and (a.pri > b.pri) or (a.heads > b.heads) end);
  if (bsort[1].heads >= RAB_Buffs[cmd].bigthreshold or RABui_Settings.alwayscastbigbuffs) then
   local bname = sRAB_SpellNames[RAB_Buffs[cmd].bigcast];
   if (mode == "cast") then
    RAB_CastSpell_Abort();
    if (RAB_CastSpell_Start(RAB_Buffs[cmd].bigcast)) then
     RAB_CastSpell_Target(bsort[1].cast);
     RAB_ResetRecastTimer(bsort[1].cast, cmd, RAB_Buffs[cmd].bigsort);
     RAB_Print(string.format(sRAB_CastBuff_Cast, bname, RAB_Chat_Colors[RAB_UnitClass(bsort[1].cast)] .. UnitName(bsort[1].cast) .. " [" .. bsort[1].key .. "]"));
     return true;
    else
     RAB_CastSpell_Start(cmd);
    end
   else
    return string.format(clicktocast, bname, RAB_Chat_Colors[RAB_UnitClass(bsort[1].cast)] .. UnitName(bsort[1].cast) .. " [" .. bsort[1].key .. "]");
   end
  end
 end

 table.sort(people,function (a,b) return (a.p > b.p) end);
 local bname = sRAB_SpellNames[cmd] ~= nil and sRAB_SpellNames[cmd] or RAB_Buffs[cmd].name;
 if (mode == "cast") then
  RAB_CastSpell_Target(people[1].u);
  RAB_ResetRecastTimer(people[1].u,cmd);
  RAB_Print(string.format(sRAB_CastBuff_Cast, sRAB_SpellNames[cmd] ~= nil and sRAB_SpellNames[cmd] or RAB_Buffs[cmd].name, RAB_Chat_Colors[RAB_UnitClass(people[1].u)] .. UnitName(people[1].u)));
  return true;
 elseif (mode == "tip") then
  return string.format(clicktocast,bname, RAB_Chat_Colors[RAB_UnitClass(people[1].u)] .. UnitName(people[1].u));
 end
 return people;
end
function RAB_RangeCheck(mode, u) -- Optimistic.
 return (mode == "tip" and UnitIsVisible(u)) or (mode == "cast" and SpellCanTargetUnit(u));
end
function RAB_CastInventoryItem(mode, query)
 local _,_, bkey = string.find(query,"(%a+)");
 if (RAB_Buffs[bkey] == nil or RAB_Buffs[bkey].ext == nil or RAB_UnitIsDead("player")) then
  return;
 end
 if (UnitAffectingCombat("player")) then
  return (mode == "tip" and sRAB_Tooltip_CastFail_Combat or nil);
 end
 local _,_, inv, iid = string.find(RAB_Buffs[bkey].ext,"(%d+):(%d+)");

 if (string.find(tostring(GetInventoryItemLink("player",inv)),"item:" .. iid .. ":") ~= nil) then
  return nil;
 end

 local iname = GetItemInfo(tonumber(iid));
 if (iname == nil) then iname = string.format(sRAB_BuffOutput_Item_Unknown,iid); end
 local c, b, s = RAB_CountItems(iid,true);
 if (c == 0) then
  return (mode == "tip" and string.format(sRAB_Tooltip_CastFail_NoItem,iname) or nil);
 end
 if (mode == "tip") then
  return string.format(sRAB_Tooltip_ClickToEquip,iname);
 elseif (mode == "cast") then
  PickupContainerItem(b,s);
  AutoEquipCursorItem();
 end
end
function RAB_CastSoulstone(mode, query)
 local i, item, bag, slot;

 if (sRAB_SpellNames.ss == nil or RAB_UnitClass("player") ~= "Warlock") then
  return false; -- We don't do this, sorry.
 end

 -- Stage 1: Do we have a stone?
 for i=16892,16896 do
  _, bag, slot = RAB_CountItems(i == 16894 and 5232 or i,true);
  if (bag ~= 0) then
   item = i;
   break;
  end
 end

 if (bag == 0) then -- We need a stone!
  if (mode == "tip") then
   return string.format(sRAB_Tooltip_ClickToCastNeutral, sRAB_SpellNames.ss);
  elseif (mode == "cast" and RAB_CastSpell_IsCastable("ss")) then
   CastSpellByName(sRAB_SpellNames.ss);
   RAB_Print(string.format(sRAB_CastBuff_CastNeutral, sRAB_SpellNames.ss));
   return true;
  end
 else
  if (GetContainerItemCooldown(bag, slot) ~= 0) then
   if (mode == "cast") then
    RAB_Print(string.format(sRAB_CastingLayer_Cooldown,GetItemInfo(item)),"warn");
    return false;
   else
    local start, duration = GetContainerItemCooldown(bag, slot);
    return string.format(sRAB_Tooltip_CastFail_Cooldown,start+duration-GetTime());
   end
  end
  local shouldRetarget = UnitExists("target");
  if (mode == "cast") then
   ClearTarget();
   UseContainerItem(bag, slot);
   if (not SpellIsTargeting()) then
    RAB_Print(sRAB_CastingLayer_NoSession,"warn")
    return false;
   end
  end
  local cmd, people, pri = "ss", {}, 0;
  local maxpri, maxpriunit = 0, "";
  for i, u, g in RAB_GroupMembers(query) do
   if (RAB_IsEligible(u,cmd) and RAB_IsSanePvP(u) and not RAB_IsBuffUp(u,cmd) and RAB_RangeCheck(mode, u)) then
    local pri = UnitIsUnit("player",u) and (RAB_Buffs[cmd].selfPriority ~= nil and RAB_Buffs[cmd].selfPriority or 5) or 1;
    if (RAB_CastLog[u] ~= nil and RAB_CastLog[u] >= time()) then pri = pri / 10; end
    if (RAB_Buffs[cmd].priority ~= nil and RAB_Buffs[cmd].priority[strlower(RAB_UnitClass(u))] ~= nil) then pri = pri + RAB_Buffs[cmd].priority[strlower(RAB_UnitClass(u))]; end 
    if (pri > maxpri) then
     maxpri = pri; maxpriunit = u;
    end
   end
  end
  if (mode == "cast" and maxpri > 0) then
   SpellTargetUnit(maxpriunit);
   if (shouldRetarget) then TargetLastTarget(); end
   RAB_Print(string.format(sRAB_CastBuff_Cast, GetItemInfo(item), RAB_Chat_Colors[RAB_UnitClass(maxpriunit)] .. UnitName(maxpriunit)));
   return true;
  elseif (mode == "tip" and maxpri > 0) then
   return string.format(sRAB_Tooltip_ClickToSoulstone, RAB_Chat_Colors[RAB_UnitClass(maxpriunit)] .. UnitName(maxpriunit));
  elseif (mode == "cast") then
   SpellStopCasting();
   if (shouldRetarget) then TargetLastTarget(); end
  end
 end
 return false;
end
function RAB_CastResurrect(mode, msg)
 local res, i, u = strlower(RAB_UnitClass("player")) .. "res";

 if (sRAB_SpellNames[res] == nil) then
  return false;
 end

 local toRes = {}; -- {u="",pri=deci};
 for i, u, group in RAB_GroupMembers(msg) do
  if (UnitIsUnit(u,"player") ~= 1 and UnitIsVisible(u) and (RAB_UnitIsDead(u) and not UnitIsGhost(u)) and RAB_IsSanePvP(u) and (RAB_CTRA_IsBeingRessed == nil or not RAB_CTRA_IsBeingRessed(UnitName(u)))) then
   local pri = (RAB_UnitClass(u) == "Priest" and 2 or 0) + (RAB_UnitClass(u) == "Paladin" and 2 or 0) + (RAB_UnitClass(u) == "Shaman" and 2 or 0) + (RAB_UnitClass(u) == "Mage" and 1 or 0) + (RAB_Versions[UnitName(u)] ~= nil and 0.25 or 0);
   if (RAB_CastLog[u] ~= nil and RAB_CastLog[u] > GetTime()) then pri = pri / 15; end
   tinsert(toRes, {u=u,pri=pri});
  end
 end
 if (table.getn(toRes) == 0) then
  return false;
 elseif (table.getn(toRes) > 1) then
  table.sort(toRes,function (a,b) return a.pri > b.pri end);
 end

 if (mode == "tip") then
  return string.format(sRAB_Tooltip_ClickToCast, sRAB_SpellNames[res], RAB_Chat_Colors[RAB_UnitClass(toRes[1].u)] .. UnitName(toRes[1].u));
 end

 if (not RAB_CastSpell_Start(res)) then
  return false;
 end

 for i=1,table.getn(toRes) do
  u = toRes[i].u;
  if (SpellCanTargetUnit(u)) then
   RAB_CastSpell_Target(u);
   RAB_Print(string.format(sRAB_CastBuff_Cast, sRAB_SpellNames[res], RAB_Chat_Colors[RAB_UnitClass(u)] .. UnitName(u)));
   RAB_PendingRes[UnitName(u)] = GetTime() + 70;
   return true;
  end
 end
 RAB_CastSpell_Abort();
 return false;
end
function RAB_CastWater(mode, msg)
 if (not RAB_CastSpell_IsCastable("water",true,true)) then
  return; -- Lazy.
 end
 if (mode == "tip") then
  return string.format(sRAB_Tooltip_ClickToCastNeutral,sRAB_SpellNames.water);
 elseif (mode == "cast") then
  CastSpellByName(sRAB_SpellNames.water);
  RAB_Print(string.format(sRAB_CastBuff_CastNeutral,sRAB_SpellNames.water));
 end
end

-- BLOCK 3: Query definitions
RAB_Buffs = 	{
			ai={name="Arcane Intellect",bigcast="ab",bigsort="group",bigthreshold=3,textures={"Spell_Holy_MagicalSentry", "Spell_Holy_ArcaneIntellect"},ignoreClass="wr",castClass="Mage",priority={priest=0.5,druid=0.5,paladin=0.4,shaman=0.4,warlock=0.3},ctraid=3,recast=5},
			dampen={name="Dampen Magic",textures={"Spell_Nature_AbolishMagic"},castClass="Mage",ctraid=21,recast=3},
			amplify={name="Amplify Magic",textures={"Spell_Holy_FlashHeal"},castClass="Mage",ctraid=20,recast=3},
			barrier={name="Ice Barrier",textures={"Spell_Ice_Lament"},castClass="Mage",type="self",invert=true},
			block={name="Ice Block",textures={"Spell_Frost_Frost"},castClass="Mage",type="self",invert=true},
			magearmor={name="Mage Armor",textures={"Spell_MageArmor"},castClass="Mage",type="self",recast=5},
			frostarmor={name="Frost Armor",textures={"Spell_Frost_FrostArmor02"},castClass="Mage",type="self",recast=5},
			water={name="Water",type="special",textures={"INV_Drink_18"},castClass="Mage",queryFunc=RAB_QueryWater,buffFunc=RAB_CastWater,description="H2O data as reported by RABuffs.",ignoreClass="rw"},

			pwf={name="Power Word: Fortitude",bigsort="group",bigthreshold=3,bigcast="pof",textures={"Spell_Holy_WordFortitude", "Spell_Holy_PrayerOfFortitude"},castClass="Priest",ctraid=1,recast=5},
			sprot={name="Shadow Protection",bigsort="group",bigthreshold=3,bigcast="posprot",textures={"Spell_Shadow_AntiShadow","Spell_Holy_PrayerofShadowProtection"},castClass="Priest",ctraid=5,recast=3},
			ds={name="Divine Spirit",bigsort="group",bigthreshold=3,bigcast="pos",textures={"Spell_Holy_DivineSpirit","Spell_Holy_PrayerofSpirit"},ignoreClass="wr",castClass="Priest",priority={priest=0.5,druid=0.3,mage=0.4,paladin=0.3},ctraid=8,recast=5},
			pws={name="Power Word: Shield",textures={"Spell_Holy_PowerWordShield"},castClass="Priest",invert=true,ctraid=6},
			fearward={name="Fear Ward",textures={"Spell_Holy_Excorcism"},castClass="Priest",invert=true,ctraid=10,recast=3},
			innerfire={name="Inner Fire",textures={"Spell_Holy_InnerFire"},castClass="Priest",type="self",recast=3},
			pi={name="Power Infusion",textures={"Spell_Holy_PowerInfusion"},castClass="Priest",ignoreClass="wrh",priority={priest=0.2,druid=0.2,mage=0.5,warlock=0.5},selfPriority=0},

			motw={name="Mark of the Wild",bigcast="gotw",bigsort="group",bigthreshold=3,textures={"Spell_Nature_Regeneration","Spell_Nature_Regeneration"},castClass="Druid",ctraid=2,recast=5},
			thorns={name="Thorns",textures={"Spell_Nature_Thorns"},castClass="Druid",ctraid=9,recast=3},
			clarity={name="Omen of Clarity",textures={"Spell_Nature_CrystalBall"},castClass="Druid",type="self",recast=2},
			druidshift={name="Shapeshifted",textures={"Ability_Druid_TravelForm","Ability_Racial_BearForm","Ability_Druid_CatForm","Ability_Druid_AquaticForm"},type="dummy",castClass="Druid"},

			bos={name="Blessing of Salvation",bigcast="gbos",bigsort="class",bigthreshold=3,textures={"Spell_Holy_SealOfSalvation","Spell_Holy_GreaterBlessingofSalvation"},ignoreMTs=true,castClass="Paladin",priority={priest=0.5,druid=0.5,mage=0.4,warlock=0.4,paladin=0.4},sort="class",ctraid=14,recast=3},
			bow={name="Blessing of Wisdom",bigcast="gbow",bigsort="class",bigthreshold=3,textures={"Spell_Holy_SealOfWisdom","Spell_Holy_GreaterBlessingofWisdom"},ignoreClass="wr",castClass="Paladin",priority={priest=0.5,druid=0.5,mage=0.4,warlock=0.4,paladin=0.4},sort="class",ctraid=12,recast=3},
			bok={name="Blessing of Kings",bigcast="gbok",bigsort="class",bigthreshold=3,textures={"Spell_Magic_MageArmor","Spell_Magic_GreaterBlessingofKings"},castClass="Paladin",sort="class",ctraid=13,recast=3},
			bol={name="Blessing of Light",bigcast="gbol",bigsort="class",bigthreshold=3,textures={"Spell_Holy_PrayerOfHealing02","Spell_Holy_GreaterBlessingofLight"},castClass="Paladin",sort="class",ctraid=15,recast=3},
			bom={name="Blessing of Might",bigcast="gbom",bigsort="class",bigthreshold=3,textures={"Spell_Holy_FistOfJustice","Spell_Holy_GreaterBlessingofKings"},ignoreClass="mplh",castClass="Paladin",sort="class",ctraid=11,recast=3},
			bosanc={name="Blessing of Sanctuary",bigcast="gbosanc",bigsort="class",bigthreshold=3,textures={"Spell_Nature_LightningShield","Spell_Holy_GreaterBlessingofSanctuary"},castClass="Paladin",sort="class",ctraid=16,recast=3},
			bop={name="Blessing of Protection",textures={"Spell_Holy_SealOfProtection"},castClass="Paladin",unique=true},
			command={name="Seal of Command",textures={"Ability_Warrior_InnerRage"},castClass="Paladin",type="self"},
			devotion={name="Devotion Aura",textures={"Spell_Holy_DevotionAura"},castClass="Paladin",type="aura"},
			concentration={name="Concentration Aura",textures={"Spell_Holy_MindSooth"},castClass="Paladin",type="aura"},
			fireaura={name="Fire Resistance Aura",textures={"Spell_Fire_SealOfFire"},castClass="Paladin",type="aura"},
			shadowaura={name="Shadow Resistance Aura",textures={"Spell_Shadow_SealOfKings"},castClass="Paladin",type="aura"},
			retribution={name="Retribution Aura",textures={"Spell_Holy_AuraOfLight"},castClass="Paladin",type="aura"},
			frostaura={name="Frost Resistance Aura",textures={"Spell_Frost_WizardMark"},castClass="Paladin",type="aura"},
			di={name="Divine Intervention",textures={"Spell_Nature_TimeStop"},castClass="Paladin",priority={priest=2,paladin=2,druid=1,mage=0.5},selfPriority=-10},

			ss={name="Soulstone",textures={"Spell_Shadow_SoulGem"},castClass="Warlock",buffFunc=RAB_CastSoulstone,priority={priest=2,paladin=2,shaman=2,druid=1},selfPriority=1.2,invert=true,unique=true,ctraid=7,recast=5},
			ub={name="Unending Breath",textures={"Spell_Shadow_DemonBreath"},castClass="Warlock",recast=3},
			detectinvisibility={name="Detect Invisibility",textures={"Spell_Shadow_DetectInvisibility","Spell_Shadow_DetectLesserInvisibility"},castClass="Warlock",recast=3},
			demonarmor={name="Demon Armor",textures={"Spell_Shadow_RagingScream"},castClass="Warlock",type="self",recast=5},
			bloodpact={name="Blood Pact",textures={"Spell_Shadow_BloodBoil"},castClass="Warlock",type="aura"},
			paranoia={name="Paranoia",textures={"Spell_Shadow_AuraOfDarkness"},castClass="Warlock",invert=true,type="aura"},

			hawk={name="Aspect of the Hawk",textures={"Spell_Nature_RavenForm"},castClass="Hunter",type="self"},
			cheetah={name="Aspect of the Cheetah",textures={"Ability_Mount_JungleTiger"},castClass="Hunter",type="self"},
			beast={name="Aspect of the Beast",textures={"Ability_Mount_PinkTiger"},castClass="Hunter",type="self"},
			aspectwild={name="Aspect of the Wild",textures={"Spell_Nature_ProtectionformNature"},castClass="Hunter",type="aura"},
			pack={name="Aspect of the Pack",textures={"Ability_Mount_WhiteTiger"},castClass="Hunter",type="aura"},
			monkey={name="Aspect of the Monkey",textures={"Ability_Hunter_AspectOfTheMonkey"},castClass="Hunter",type="self"},
			trueshot={name="True Shot Aura",textures={"Ability_TrueShot"},castClass="Hunter",type="aura"},

			battleshout={name="Battle Shout",textures={"Ability_Warrior_BattleShout"},castClass="Warrior",type="aura"},

			incombat={name="In Combat",sfunc=UnitAffectingCombat,sfuncmodel=2,havebuff="In Combat",missbuff="Out of combat",invert=true},
			pvp={name="PvP Enabled",sfunc=UnitIsPVP,sfuncmodel=2,invert=true,havebuff="PvP Enabled",missbuff="Not PvP Enabled"},


			flag={name="WSG Flag",textures={"INV_BannerPVP_01","INV_BannerPVP_02"},invert=true,havebuff="Carrying Flag",missbuff="No Flag"},
			battlestandard={name="Battle Standard",textures={"INV_Banner_02","INV_Banner_01"},castClass="Item",invert=true,type="aura"},

			dragonslayer={name="Rallying Cry of the Dragonslayer",textures={"INV_Misc_Head_Dragon_01"},castClass="Item"},
			regen={name="Regenerating",textures={"INV_Drink_18","INV_Drink_07","INV_Misc_Fork&Knife"},castClass="Item",invert=true,havebuff="Regenerating",missbuff="Not Regenerating",type="self"},
			hat={name="Admiral's Hat",textures={"INV_Misc_Horn_03"},castClass="Item",type="aura"},

			giants={name="Elixir of the Giants",textures={"INV_Potion_61"},castClass="Item",invert=true,type="self"},
			sages={name="Elixir of the Sages",textures={"INV_Potion_29"},castClass="Item",invert=true,type="self"},
			arcane={name="Arcane Elixir",textures={"INV_Potion_30"},castClass="Item",invert=true,type="self",type="self"},
			greaterarcane={name="Greater Arcane Elixir",textures={"INV_Potion_25"},castClass="Item",invert=true,type="self"},
			mongoose={name="Elixir of the Mongoose",textures={"INV_Potion_32"},castClass="Item",invert=true,type="self"},
			titans={name="Flask of the Titans",textures={"INV_Potion_62"},castClass="Item",invert=true,type="self"},
			tuber={name="Runn Tum Tuber Surprise",textures={"INV_Misc_Organ_03"},castClass="Item",invert=true,type="self"},

			flute={name="Piccolo of the Dancing Flame",textures={"INV_Misc_Flute_01"},castClass="Item",invert=true,type="aura"},
			adcommision={name="Argent Dawn Commission",textures={"INV_Jewelry_Talisman_07"},castClass="Item",invert=true,type="self"},
			furbolg={name="Furbolg Transform",textures={"INV_Misc_MonsterClaw_04"},castClass="Item",invert=true},
			cozyfire={name="Cozy Fire",textures={"Spell_Fire_Fire"},castClass="Item",type="aura",invert=true},

			frostmark={name="Mark of Frost",textures={"Spell_Frost_ChainsOfIce"},invert=true,type="debuff"},
			naturemark={name="Mark of Nature",textures={"Spell_Nature_SpiritArmor"},invert=true,type="debuff"},
			shazz={name="Amplify Magic [Shazzrah]",textures={"Spell_Arcane_StarFire"},type="debuff"},
			cthun={name="Digestive Acid [C'Thun]",textures={"Ability_Creature_Disease_02"},type="debuff",invert=true},
			drunk={name="Drunk [ZG]",textures={"Ability_Creature_Poison_01"},type="debuff"},
			dcurse={name="Type: Curse",queryFunc=RAB_QueryDebuff,ext="Curse",type="debuff"},
			dmagic={name="Type: Magic",queryFunc=RAB_QueryDebuff,ext="Magic",type="debuff"},
			ddisease={name="Type: Disease",queryFunc=RAB_QueryDebuff,ext="Disease",type="debuff"},
			dpoison={name="Type: Poison",queryFunc=RAB_QueryDebuff,ext="Poison",type="debuff"},
			dtypeless={name="Type: Typeless",queryFunc=RAB_QueryDebuff,ext="",type="debuff"},
			dicanremove={name="Type: You can remove",queryFunc=RAB_QueryDebuff,ext="SELF",type="debuff"},

			health={name="Health",type="special",queryFunc=RAB_QueryHealth,ext="hp",buffFunc=RAB_CastResurrect,description="Sum of health versus sum of max health."},
			alive={name="Alive",type="special",queryFunc=RAB_QueryHealth,ext="alive",buffFunc=RAB_CastResurrect,description="Number of people alive versus total headcount."},
			mana={name="Mana",type="special",queryFunc=RAB_QueryMana,description="Sum of current mana vs sum of max mana.",ignoreClass="rw"},
			status={name="Status",type="special",queryFunc=RAB_QueryStatus,description="Displays buff sumary for PW:F, AI, MotW, BoK, BoS, BoW and Soulstones.",noUI=true},
			scanunknown={name="Unknown Buff Scan",type="special",queryFunc=RAB_ScanRaid,ext="unknown",description="Scans raid for unknown buff textures.",noUI=true},
			scanraid={name="Raid Scan",type="special",queryFunc=RAB_ScanRaid,ext="known",description="Scans raid and displays a report of all known buffs.",noUI=true},
			ishere={name="Is Here",type="special",queryFunc=RAB_QueryHere,description="Displays people currently afk, offline or invisible."},
			ctra={name="CTRA Version",type="special",queryFunc=RAB_QueryCTRAVersion,description="Displays people whose CTRA is out of date."},
			blank={name="Blank",type="special",queryFunc=RAB_QueryBlank,description="Displays a blank bar - use as a header if you wish."},
			onycloak={name="Onyxia Cloak",type="special",queryFunc=RAB_QueryInventoryItem,ext="15:15138",buffFunc=RAB_CastInventoryItem,description="Checks that people are wearing their Onyxia Cloak."},
			info={name="Target's (De)Buffs",type="special",queryFunc=RAB_QueryBuffInfo,description="Outputs buff names / textures for buffs and debuffs on your current target.",noUI=true},

			priestres={name="Resurrection",type="dummy",textures={"Spell_Holy_Resurrection"},castClass="Priest"},
			paladinres={name="Redemption",type="dummy",textures={"Spell_Holy_Resurrection"},castClass="Paladin"},
			shamanres={name="Ancestral Spirit",type="dummy",textures={"Spell_Nature_Regenerate"},castClass="Shaman"}
		};
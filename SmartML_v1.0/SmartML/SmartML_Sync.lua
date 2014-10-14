------------------------------------------------------------------------------
-- Itemlog sync
------------------------------------------------------------------------------

SML_PROTOCOL_VER = 1;

--[[
	entry has:
	
	entry.item
	entry.player
	entry.bid
	entry.pool
--]]

function SL_ParseMsg(msg, player)
	local data = split(msg, ";");
	if (tonumber(data[1]) ~= SML_PROTOCOL_VER) then
		-- version mismatch
		SL_Print("ERROR: Player "..player.." has incompatible (older/newer) SmartML version.");
		return;
	end
	if (data[2]=="ENTRY") then
		SL_ParseEntry(msg, player);
	end
	if (data[2]=="DEL") then
		SL_ParseDel(msg, player);
	end
end

function SL_SendLogEntry(entry)
	local pool = entry.pool;
	if (not pool) then
		pool = "_NIL_";
	end
	-- encode link so that it can be sent trough chat channel
	local link = entry.item.link;
	link = string.gsub(link, "|","*");
	--|cffa335ee|Hitem:21128:0:0:0|h[Staff of the Qiraji Prophets]|h|r
	SendAddonMessage("SML", SML_PROTOCOL_VER..";ENTRY;"..link..";"..entry.player..";"..entry.bid..";"..pool, "RAID");
end

function SL_SendLogDel(entry)
	local pool = entry.pool;
	if (not pool) then
		pool = "_NIL_";
	end
	-- encode link so that it can be sent trough chat channel
	local link = entry.item.link;
	link = string.gsub(link, "|","*");
	SendAddonMessage("SML", SML_PROTOCOL_VER..";DEL;"..link..";"..entry.player..";"..entry.bid..";"..pool, "RAID");
end

function SL_ParseDel(msg, player)
	local data = split(msg, ";");
	local entry={};
	-- decode link back to normal
	local item = SL_ParseItem(string.gsub(data[3], "*","|"));
	entry["item"] = item;
	entry["player"] = data[4];
	entry["bid"] = tonumber(data[5]);
	entry["pool"] = data[6];
	-- convert to proper
	if (entry.pool=="_NIL_") then
		entry.pool=nil;
	end
	-- delete the selected entry
	for i,logged in SL_LOG[SL_LOG_CURRENT] do
		if (logged.item == entry.item and
			logged.player == entry.player and
			logged.bid == entry.bid and
			logged.pool == entry.pool) 
		then
			SL_Print("Received |cffff0000delete logged item|r from "..player..". Item: "..logged.item.link.." Player: |cffffffff"..logged.player.."|r Bid: |cffffffff"..logged.bid.."|r Pool: |cffffffff"..pool.."|r");
			table.remove(SL_LOG[SL_LOG_CURRENT], i);
			-- refund points
			if (SL_ModifyUsedDKP(player, -points, pool)) then
				SL_Print("Refunded "..points.." ("..pool..") points to "..player);
			end
			SL_UpdateLog();
			return;
		end
	end
end

function SL_ParseEntry(msg, player)
	local data = split(msg, ";");
	local logged={};
	-- decode link back to normal
	local item = SL_ParseItem(string.gsub(data[3], "*","|"));
	logged["item"] = item;
	logged["player"] = data[4];
	logged["bid"] = tonumber(data[5]);
	logged["pool"] = data[6];
	-- convert to proper
	if (logged.pool=="_NIL_") then
		logged.pool=nil;
	end
	-- if no pool, set message text to N/A
	local pool = logged.pool;
	if (not pool) then
		pool="N/A";
	end
	SL_Print("Received logged item from "..player..". Item: "..logged.item.link.." Player: |cffffffff"..logged.player.."|r Bid: |cffffffff"..logged.bid.."|r Pool: |cffffffff"..pool.."|r");
	SL_AddToLog(logged, true);
	SL_UpdateLog();
end

------------------------------------------------------------------------------
-- Bid start / stop broadcasts
------------------------------------------------------------------------------

function SL_BroadcastItemStart(link)
	link = string.gsub(link, "|","*");
	local msg = SML_PROTOCOL_VER..";START;"..link;
	SendAddonMessage("SML", msg, "RAID");
	
	--SB_ParseMessage(msg, "paranoidi"); -- test!
end

function SL_BroadcastItemClosed(link)
	link = string.gsub(link, "|","*");
	local msg = SML_PROTOCOL_VER..";CLOSE;"..link;
	SendAddonMessage("SML", msg, "RAID");

	--SB_ParseMessage(msg, "paranoidi"); -- test!
end

------------------------------------------------------------------------------
-- UTILS
------------------------------------------------------------------------------

function split(str, pat)
   local t = {n = 0}
   local fpat = "(.-)"..pat
   local last_end = 1
   local s,e,cap = string.find(str, fpat, 1)
   while s ~= nil do
      if s~=1 or cap~="" then
	 table.insert(t,cap)
      end
      last_end = e+1
      s,e,cap = string.find(str, fpat, last_end)
   end
   if last_end<=string.len(str) then
      cap = string.sub(str,last_end)
      table.insert(t,cap)
   end
   return t
end

function SL_InRaid(player)
	if (not player) then return false; end;
	local mode, members = SL_GetIterInfo();
	if (mode==nil or members==nil) then return false; end;
	for i = 1, members do
		if (string.lower(UnitName(mode..i))==string.lower(player)) then 
			return true; 
		end
	end
end
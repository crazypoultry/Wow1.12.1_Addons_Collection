----------------------------------------------------------------------------------
--
-- GuildAdsTooltip.lua
--
-- Author: Zarkan, Fkaï of European Ner'zhul (Horde)
-- URL : http://guildads.sourceforge.net
-- Email : guildads@gmail.com
-- Licence: GPL version 2 (General Public License)
----------------------------------------------------------------------------------

-- TODO : rajouter les items craftés
GuildAdsItems = {};

GuildAdsTradeTooltip = {

	metaInformations = { 
		name = "TradeTooltip",
        guildadsCompatible = 200,
	};
	
	colors = {
		TradeNeed = {
			[true]   = { 1, 0.75, 0 };
			[false]  = { 1, 1   , 0.5 };
		};
		TradeOffer = {
			[true]   = { 1, 0   , 0.75 };
			[false]  = { 1, 0.5 , 1 };
		}
	};
	
	onInit = function()
		-- Hook SetItemRef
		-- TODO : add support for LootLink, ItemMatrix, KC_Items 
		GuildAdsTradeTooltip.hookSetItemRef = SetItemRef;
		SetItemRef = GuildAdsTradeTooltip.SetItemRef;
	end;
	
	onChannelJoin = function()
		-- Register for events
		GuildAdsDB.channel[GuildAds.channelName].TradeNeed:registerEvent(GuildAdsTradeTooltip.onDBUpdate);
		GuildAdsDB.channel[GuildAds.channelName].TradeOffer:registerEvent(GuildAdsTradeTooltip.onDBUpdate);
		
		-- Scan database
		GuildAdsItems = {};
		for _, item, playerName, data in GuildAdsDB.channel[GuildAds.channelName].TradeNeed:iterator() do
			GuildAdsTradeTooltip.onDBUpdate(GuildAdsDB.channel[GuildAds.channelName].TradeNeed, playerName, item);
		end
		for _, item, playerName, data in GuildAdsDB.channel[GuildAds.channelName].TradeOffer:iterator() do
			GuildAdsTradeTooltip.onDBUpdate(GuildAdsDB.channel[GuildAds.channelName].TradeOffer, playerName, item);
		end
	end;
	
	onChannelLeave = function()
		-- Unregister for events
		GuildAdsDB.channel[GuildAds.channelName].TradeNeed:unregisterEvent(GuildAdsTradeTooltip.onDBUpdate);
		GuildAdsDB.channel[GuildAds.channelName].TradeOffer:unregisterEvent(GuildAdsTradeTooltip.onDBUpdate);
	
		-- Clear database
		GuildAdsItems = {};
	end;
	
	onDBUpdate = function(dataType, playerName, item)
		local dataTypeName = dataType.metaInformations.name -- TradeNeed / TradeOffer
		local info = dataType:get(playerName, item);
		local count = 0;
		local inf = false;
		if info then
			if info.q then
				count = info.q;
			else
				inf = true;
			end
		else
			count = 0;
		end
		local itemName = (GuildAds_ItemInfo[item] or {}).name; -- TODO : problem when item info not ready
		if (itemName ~= nil) then
			if (GuildAdsItems[itemName] == nil) then
				GuildAdsItems[itemName] = {
					TradeNeed = {};
					TradeOffer = {};
				};
			end
			
			local f = function(k, v)
				if v.owner==playerName then
					return k;
				end
			end;
			local index = table.foreach(GuildAdsItems[itemName][dataTypeName], f);
			
			if index then
				if info then
					local t = GuildAdsItems[itemName][dataTypeName][index];
					t.count = count;
					t.inf = inf;
				else
					tremove(GuildAdsItems[itemName][dataTypeName], index);
				end
			else
				if info then
					tinsert(GuildAdsItems[itemName][dataTypeName], {
						count = count;
						inf = inf;
						owner = playerName;
					});
				end
			end
			table.sort(GuildAdsItems[itemName][dataTypeName], GuildAdsTradeTooltip.predicate);
		end
	end;
	
	predicate = function(a, b)
		-- nil references are always less than
		if (a == nil) then
			if (b == nil) then
				return false;
			else
				return true;
			end
		elseif (b == nil) then
			return false;
		end
	
		-- inf/count
		if (a.inf) then
			if (not b.inf) then
				return true;
			end
		else
			if (b.inf) then
				return false;
			else
				if (a.count < b.count) then
					return false;
				elseif (a.count > b.count) then
					return true;
				end
			end
		end
	
		-- owner
		if (a.owner<b.owner) then
			return true;
		elseif (a.owner>b.owner) then
			return false;
		end
	
		-- same
		return false;
	end;
		
	SetItemRef = function(itemLink, text, button)
		GuildAdsTradeTooltip.hookSetItemRef(itemLink, text, button);
		GuildAdsTradeTooltip.addInformations(ItemRefTooltip);
	end;
	
	formatData = function(dataTypeName, data)
		if data then
			local t = GuildAdsTradeTooltip.colors[dataTypeName][GuildAdsDB.profile.Main:get(data.owner, GuildAdsDB.profile.Main.Account)==GuildAdsDB.account];
			
			if data.count>0 then
				if data.inf then
					return data.owner .. " (" .. data.count .. "+)", t[1], t[2], t[3];
				else
					return data.owner .. " (" .. data.count .. ")", t[1], t[2], t[3];
				end
			else
				return data.owner, t[1], t[2], t[3];
			end
		else
			return " ", 1, 1, 1;
		end
	end;
	
	addInformations = function(tooltip)
		local lbl = getglobal(tooltip:GetName().."TextLeft1");
		if lbl then
			local t = GuildAdsItems[lbl:GetText()];
			if t then
				local infosR = t.TradeNeed;
				local infosA = t.TradeOffer;
				if infosR or infosA then
					local i=1;
					while (infosR[i] or infosA[i]) and i<5 do
						local msgR, msgRr, msgRg, msgRb = GuildAdsTradeTooltip.formatData("TradeNeed", infosR[i]);
						local msgA, msgAr, msgAg, msgAb = GuildAdsTradeTooltip.formatData("TradeOffer", infosA[i]);
						tooltip:AddDoubleLine(msgR, msgA, msgRr, msgRg, msgRb, msgAr, msgAg, msgAb);
						i= i+1;
					end
					tooltip:Show();
				end
			end
		end
	end;
	
}

GuildAdsPlugin.UIregister(GuildAdsTradeTooltip);
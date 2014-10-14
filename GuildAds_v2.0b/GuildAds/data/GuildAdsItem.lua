----------------------------------------------------------------------------------
--
-- GuildAdsItem.lua
--
-- Author: Zarkan, Fkaï of European Ner'zhul (Horde)
-- URL : http://guildads.sourceforge.net
-- Email : guildads@gmail.com
-- Licence: GPL version 2 (General Public License)
----------------------------------------------------------------------------------

function GuildAds_ImplodeItemRef(color, ref, name)
	color = color or "ffffffff";
	name = name or "??";
	if (ref) then
		return "|c"..color.."|H"..ref.."|h["..name.."]|h|r";
	elseif (color) then
		return "|c"..color.."["..name.."]|r";
	end
end

function GuildAds_ExplodeItemRef(itemRef)
	local start, _, color, ref, name = string.find(itemRef, "|c([%w]+)|H([^|]+)|h%[([^|]+)%]|h|r");
	if (start) then
		return color, ref, name;
	else
		local _, _, color, name = string.find(itemRef, "|c([%w]+)%[([^|]+)%]|r");
		return color, nil, name;
	end
end

--[[
	GuildAds_ItemInfo[itemRef]
	GuildAds_GetItemInfo(itemRef, needTooltipInformation)
]]

GuildAds_ItemInfo = {};			-- cache for GetItemInfo and Tooltip information.

setmetatable(GuildAds_ItemInfo, {
	__index = function(t, n)
		local v = GuildAds_GetItemInfo(n);
		if v then
			rawset(t, n, v);
			return v;
		end;
	end;
	
	__newindex = function(t, n, v)
		error("GuildAds_ItemInfo can't be assigned", 2);
	end;
});	

---------------------------------------------------------------------------------
--
-- Get item information (GetItemInfo)
--
-- fill when needTooltipInformation~=true
-- *name, type, subtype, slot, quality, stackcount, minlevel, texture
--
-- fill when needTooltipInformation==true
-- *_tt, soulbound, questitem, spellKnown
--
-- if item is known, you have to wait for GAS_EVENT_ITEMINFOREADY
-- 
-- test : /dump GuildAds_GetItemInfo("item:9387:0:1200:0")
---------------------------------------------------------------------------------
function GuildAds_GetItemInfo(itemRef, needTooltipInformation)
	if itemRef and not(rawget(GuildAds_ItemInfo, itemRef) and (not needTooltipInformation or rawget(GuildAds_ItemInfo, itemRef)._tt))  then
		local found, _, itemLink1, itemLink2, itemLink3, itemLink4 = string.find(itemRef, "item:(%d+):(%d+):(%d+):(%d+)");
		if not found then
			-- for enchant:xxx
			found, _, itemLink1 = string.find(itemRef, "enchant:(%d+)");
			if found then
				GuildAdsInternalTooltip_AddItem(itemRef);
			end
			return;
		end
		itemName, itemLink, itemRarity, itemMinLevel, itemType, itemSubType, itemStackCount, itemSlot, itemTexture = GetItemInfo(itemRef);
		if (not itemName) or needTooltipInformation then
			GuildAdsInternalTooltip_AddItem(itemRef);
		end
		if itemName then
			if itemSlot and getglobal(itemSlot) then
				itemSlot = getglobal(itemSlot);
			end
		
			if not rawget(GuildAds_ItemInfo, itemRef) then
				rawset(GuildAds_ItemInfo, itemRef, { });
			end
			
			GuildAds_ItemInfo[itemRef].name = itemName;
			GuildAds_ItemInfo[itemRef].type = itemType;
			GuildAds_ItemInfo[itemRef].subtype = itemSubType;
			GuildAds_ItemInfo[itemRef].slot = itemSlot;
			GuildAds_ItemInfo[itemRef].quality = itemRarity; 
			GuildAds_ItemInfo[itemRef].stackcount = itemStackCount;
			GuildAds_ItemInfo[itemRef].minlevel = itemMinLevel;
			GuildAds_ItemInfo[itemRef].texture = itemTexture;
		end
	end
	
	return rawget(GuildAds_ItemInfo, itemRef);
end

function GuildAdsInternalTooltip_SetItem(itemRef)
	GuildAds_ChatDebug(GA_DEBUG_STORAGE, "  - SetItem:"..itemRef);
	GuildAdsITT.currentItemRef = itemRef;
	GuildAdsITT:ClearLines();
	GuildAdsITT:SetOwner(WorldFrame, "ANCHOR_NONE"); 
	GuildAdsITT:SetPoint("BOTTOMRIGHT", "UIParent", "BOTTOMRIGHT", -13, 80);
	
	GuildAdsITT:SetHyperlink(itemRef);
	GuildAdsTask:AddNamedSchedule("GuildAdsInternalTooltip_Timeout", 2, nil, nil, GuildAdsInternalTooltip_Timeout);
end

function GuildAdsInternalTooltip_Timeout()
	if next(GuildAdsITT.itemRefs) then
		GuildAds_ChatDebug(GA_DEBUG_STORAGE, "  - Timeout:"..GuildAdsITT.currentItemRef);
		local itemRef = next(GuildAdsITT.itemRefs);
		GuildAdsInternalTooltip_SetItem(itemRef);
	end
end

function GuildAdsInternalTooltip_AddItem(itemRef)
	if itemRef then
		if not GuildAdsITT.itemRefs then
			GuildAdsITT.itemRefs = {};
			GuildAdsITT.count = 0;
		end
		if not GuildAdsITT.itemRefs[itemRef] then
			-- GuildAds_ChatDebug(GA_DEBUG_STORAGE, "AddItem:"..itemRef);
			GuildAdsITT.itemRefs[itemRef] = true;
			GuildAdsITT.count = 1 + GuildAdsITT.count;
			if GuildAdsITT.count == 1 then
				GuildAdsInternalTooltip_SetItem(itemRef);
			end
		end
	end
end

function GuildAdsInternalTooltip_ItemReady()
	GuildAds_ChatDebug(GA_DEBUG_STORAGE, "  - ItemReady:"..GuildAdsITT.currentItemRef);
	
	-- GetItemInfo again
	GuildAds_GetItemInfo(GuildAdsITT.currentItemRef);
	-- parse tooltips
	GuildAdsInternalTooltip_ParseTooltip(GuildAdsITT.currentItemRef);
	-- for enchant link : create a fake texture, type, subtype
	local found, _, itemLink1 = string.find(GuildAdsITT.currentItemRef, "enchant:(%d+)");
	if found then
		local t = GuildAds_ItemInfo[GuildAdsITT.currentItemRef];
		t.texture = "Interface/Icons/Spell_Holy_GreaterHeal";
		t.type = GUILDADS_SKILLS[9];
		t.subtype = "";
	end
	
	-- hide tooltip
	GuildAdsITT.itemRefs[GuildAdsITT.currentItemRef] = nil;
	GuildAdsITT.count = GuildAdsITT.count-1;
	
	GuildAdsITT:Hide();
	
	-- next item if there is one
	local itemRef = next(GuildAdsITT.itemRefs);
	if itemRef then
--~ 		GuildAdsTask:AddNamedSchedule("GuildAdsInternalTooltip_SetItem", 2, nil, nil, GuildAdsInternalTooltip_SetItem, itemRef);
		GuildAdsInternalTooltip_SetItem(itemRef);
	else
		GuildAdsPlugin_OnEvent(GAS_EVENT_ITEMINFOREADY);
	end
end

function GuildAdsInternalTooltip_ParseTooltip(itemRef)
	if not rawget(GuildAds_ItemInfo, itemRef) then
		rawset(GuildAds_ItemInfo, itemRef, { _tt = true });
	else
		GuildAds_ItemInfo[itemRef]._tt = true;
	end
	
	-- use first line of the tooltip to get a name
	if not GuildAds_ItemInfo[itemRef].name then
		GuildAds_ItemInfo[itemRef].name = getglobal("GuildAdsITTTextLeft1"):GetText();
	end
	
	-- use color of first line of the tooltip to get quality
	if not GuildAds_ItemInfo[itemRef].quality then
		local r, g, b = getglobal("GuildAdsITTTextLeft1"):GetTextColor()
		local color = string.format("%02x%02x%02x", r*255, g*255, b*255);
		-- there is some round problem : find the minimum distance between GetItemQualityColor() values and GetTextColor() values
		local rr, gg, bb;
		local d = 10;
		local q = 1;
		for quality=1,6,1 do
			rr, gg, bb = GetItemQualityColor(quality);
			local dd = math.abs(rr-r)+math.abs(gg-g)+math.abs(bb-b);
			if dd<d then
				d = dd;
				q = quality;
			end
		end
		GuildAds_ItemInfo[itemRef].quality = q;
	end
	
	
	GuildAds_ItemInfo[itemRef].soulbound = false;
	GuildAds_ItemInfo[itemRef].questitem = false;
	-- TODO : voir pour ITEM_CREATED_BY, ITEM_CLASSES_ALLOWED, ITEM_CONJURED, ITEM_RACES_ALLOWED, ITEM_STARTS_QUEST
	for idx = 2, 5 do
		local ttext = getglobal("GuildAdsITTTextLeft"..idx);
		if(ttext and ttext:GetText() ~= nil) then
			local textLeft = ttext:GetText();
			if textLeft==ITEM_BIND_ON_PICKUP or textLeft==ITEM_SOULBOUND then
				GuildAds_ItemInfo[itemRef].soulbound = true;
			elseif textLeft==ITEM_BIND_QUEST then
				GuildAds_ItemInfo[itemRef].questitem = true;
			elseif textLeft==ITEM_SPELL_KNOWN then
				GuildAds_ItemInfo[itemRef].spellKnown = true;
			end
		end
	end
end
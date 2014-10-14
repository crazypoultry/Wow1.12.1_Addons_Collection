-- Plug-in for Titan Panel by CrowGoblin.

TITAN_CLASSTRACKER_FREQUENCY=1.0;

-- Version information
local TitanClassTrackerName = "TitanClassTracker";
local TitanClassTrackerVersion = "2.7";

-- Declare our warning thresholds
SHARD_WARNING = 3;
ANKH_WARNING = 1;
RUNE_WARNING = 1;
ROGUE_WARNING = 1;
DRUID_WARNING = 1;
PRIEST_WARNING = 1;
PALADIN_WARNING = 1;

-- WARLOCK
local shardCount = 0;
local healthCount = 0;
local soulCount = 0;
local spellCount = 0;
local fireCount = 0;
-- SHAMAN
local ankhCount = 0;
local scalesCount = 0;
local oilCount = 0;
-- MAGE
local teleCount = 0;
local portalCount = 0;
local arcaneCount = 0;
-- ROGUE
local flashCount = 0;
local blindCount = 0;
local instantCount = 0;
local deadlyCount = 0;
local cripplingCount = 0;
local mindnumbCount = 0;
local woundCount = 0;
local thistleCount = 0;
-- DRUID
local mseedCount = 0;
local sseedCount = 0;
local aseedCount = 0;
local hseedCount = 0;
local iseedCount = 0;
local berriesCount = 0;
local thornrootCount = 0;
-- PRIEST
local featherCount = 0;
local hcandleCount = 0;
local scandleCount = 0;
-- PALADIN
local symbolCount = 0;
local kingcount = 0;

function TitanPanelClassTrackerButton_OnLoad()
	this.registry={
		id="ClassTracker",
		menuText=TITAN_CLASSTRACKER_MENU_TEXT,
		buttonTextFunction="TitanPanelClassTrackerButton_GetButtonText",
		tooltipTitle = TITAN_CLASSTRACKER_TOOLTIP,
		tooltipTextFunction = "TitanPanelClassTrackerButton_GetTooltipText",
		frequency=TITAN_CLASSTRACKER_FREQUENCY,
		savedVariables = {
			ShowLabelText = 1,
			ButtonTextType = 1,
		}
	}

    -- Register for inventory change events
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("BAG_UPDATE");
	this:RegisterEvent("BANKFRAME_CLOSED");
	this:RegisterEvent("UNIT_INVENTORY_CHANGED");
--	this:RegisterEvent("UNIT_NAME_UPDATE");
end

-- Event handling code
function TitanPanelClassTrackerButton_OnEvent()
	TitanClassTracker_Count();
	TitanPanelButton_UpdateButton("ClassTracker");
	TitanPanelButton_UpdateTooltip();       
end


-- Function to count Shards
function TitanClassTracker_Count()

-- Reset the count so we can count them again
-- WARLOCK
		if (shardCount ~= 0) then
			shardCount = 0;
		end
		if (healthCount ~= 0) then
			healthCount = 0;
		end
		if (soulCount ~= 0) then
			soulCount = 0;
		end
		if (spellCount ~= 0) then
			spellCount = 0;
		end
		if (fireCount ~= 0) then
			fireCount = 0;
		end

-- SHAMAN
		if (ankhCount ~= 0) then
			ankhCount = 0;
		end
		if (scalesCount ~= 0) then
			scalesCount = 0;
		end
		if (oilCount ~= 0) then
			oilCount = 0;
		end
-- MAGE
		if (teleCount ~= 0) then
			teleCount = 0;
		end
		if (portalCount ~= 0) then
			portalCount = 0;
		end
		if (arcaneCount ~= 0) then
			arcaneCount = 0;
		end

-- ROGUE
		if (flashCount ~= 0) then
			flashCount = 0;
		end
		if (blindCount ~= 0) then
			blindCount = 0;
		end
		if (instantCount ~= 0) then
			instantCount = 0;
		end
		if (deadlyCount ~= 0) then
			deadlyCount = 0;
		end
		if (cripplingCount ~= 0) then
			cripplingCount = 0;
		end
		if (mindnumbCount ~= 0) then
			mindnumbCount = 0;
		end
		if (woundCount ~= 0) then
			woundCount = 0;
		end
		if (thistleCount ~= 0) then
			thistleCount = 0;
		end

-- DRUID
		if (mseedCount ~= 0) then
			mseedCount = 0;
		end
		if (sseedCount ~= 0) then
			sseedCount = 0;
		end
		if (aseedCount ~= 0) then
			aseedCount = 0;
		end
		if (hseedCount ~= 0) then
			hseedCount = 0;
		end
		if (iseedCount ~= 0) then
			iseedCount = 0;
		end
		if (berriesCount ~= 0) then
			berriesCount = 0;
		end
		if (thornrootCount ~= 0) then
			thornrootCount = 0;
		end

-- PRIEST (featherCount for MAGE also)
		if (featherCount ~= 0) then
			featherCount = 0;
		end
		if (hcandleCount ~= 0) then
			hcandleCount = 0;
		end
		if (scandleCount ~= 0) then
			scandleCount = 0;
		end

-- PALADIN 
		if (symbolCount ~= 0) then
			symbolCount = 0;
		end
		if (kingCount ~= 0) then
			kingCount = 0;
		end

	local bag; 
	local slot; 
	local idx; 
	local itemName = nil; 
	local size; 
	local count = 0;
	local texture = 0;

	for bag = 0, 4, 1 do
		if (bag == 0) then
			size = 16;
		else
			size = GetContainerNumSlots(bag);
		end
		if (size and size > 0) then
			for slot = 1, size, 1 do
				itemType = nil; itemIdx = nil; itemName=nil;
				itemName = GetContainerItemLink(bag,slot);
				if (itemName) then
					local idx = string.find(itemName,"[[]");
					itemName = string.sub (itemName,idx+1);
					idx = string.find(itemName,"]");
					itemName = string.sub (itemName,1,idx-1);
				end
				if (itemName == "영혼의 조각") then
					texture, count = GetContainerItemInfo(bag,slot);
                        	shardCount = shardCount + count;
				end
				if (itemName == "생명석") or (itemName == "최하급 생명석") or (itemName == "하급 생명석") or (itemName == "상급 생명석") or (itemName == "최상급 생명석")  then
					texture, count = GetContainerItemInfo(bag,slot);
                        	healthCount = healthCount + count;
                    	end
				if (itemName == "최하급 영혼석") or (itemName == "영혼석")  then
					texture, count = GetContainerItemInfo(bag,slot);
                        	soulCount = soulCount + count;
                    	end
				if (itemName == "주문석") then
					texture, count = GetContainerItemInfo(bag,slot);
                        	spellCount = spellCount + count;
                    	end
				if (itemName == "화염석") then
					texture, count = GetContainerItemInfo(bag,slot);
                        	fireCount = fireCount + count;
                    	end
				if (itemName == "십자가") then
					texture, count = GetContainerItemInfo(bag,slot);
                        	ankhCount = ankhCount + count;
                    	end
				if (itemName == "반짝이는 물고기 비늘") then
					texture, count = GetContainerItemInfo(bag,slot);
                        	scalesCount = scalesCount + count;
                    	end
				if (itemName == "물고기 오일") then
					texture, count = GetContainerItemInfo(bag,slot);
                        	oilCount = oilCount + count;
                    	end
				if (itemName == "순간이동의 룬") then
					texture, count = GetContainerItemInfo(bag,slot);
                        	teleCount = teleCount + count;
                    	end
				if (itemName == "차원이동의 룬") then
					texture, count = GetContainerItemInfo(bag,slot);
                        	portalCount = portalCount + count;
                    	end
				if (itemName == "불가사의한 가루") then
					texture, count = GetContainerItemInfo(bag,slot);
                        	arcaneCount = arcaneCount + count;
                    	end
				if (itemName == "섬광 화약") then
					texture, count = GetContainerItemInfo(bag,slot);
                        	flashCount = flashCount + count;
                    	end
				if (itemName == "실명 가루") then
					texture, count = GetContainerItemInfo(bag,slot);
                        	blindCount = blindCount + count;
                    	end
				if (itemName == "순간 효과 독 VI") or (itemName == "순간 효과 독 V") or (itemName ==  "순간 효과 독 IV") or (itemName == "순간 효과 독 III") or (itemName == "순간 효과 독 II") or (itemName == "순간 효과 독") then
					texture, count = GetContainerItemInfo(bag,slot);
                        	instantCount = instantCount + count;
                    	end
				if (itemName == "맹독 IV") or (itemName == "맹독 III") or (itemName ==  "맹독 II") or (itemName == "맹독") then
					texture, count = GetContainerItemInfo(bag,slot);
                        	deadlyCount = deadlyCount + count;
                    	end
				if (itemName == "신경 마비 독 II") or (itemName == "신경 마비 독") then
					texture, count = GetContainerItemInfo(bag,slot);
                        	cripplingCount = cripplingCount + count;
                    	end
				if (itemName == "정신 마비 독 III") or (itemName == "정신 마비 독 II") or  (itemName == "정신 마비 독") then
					texture, count = GetContainerItemInfo(bag,slot);
                        	mindnumbCount = mindnumbCount + count;
                    	end
				if (itemName == "상처 감염 독 IV") or (itemName == "상처 감염 독 III") or (itemName == "상처 감염 독 II") or (itemName == "상처 감염 독") then
					texture, count = GetContainerItemInfo(bag,slot);
                        	woundCount = woundCount + count;
                    	end
				if (itemName == "엉겅퀴 차") then
					texture, count = GetContainerItemInfo(bag,slot);
                        	thistleCount = thistleCount + count;
                    	end
				if (itemName == "단풍나무 씨앗") then
					texture, count = GetContainerItemInfo(bag,slot);
                        	mseedCount = mseedCount + count;
                    	end
				if (itemName == "가시덩굴 씨앗") then
					texture, count = GetContainerItemInfo(bag,slot);
                        	sseedCount = sseedCount + count;
                    	end
				if (itemName == "잿빛나무 씨앗") then
					texture, count = GetContainerItemInfo(bag,slot);
                        	aseedCount = aseedCount + count;
                    	end
				if (itemName == "자작나무 씨앗") then
					texture, count = GetContainerItemInfo(bag,slot);
                        	hseedCount = hseedCount + count;
                    	end
				if (itemName == "강철나무 씨앗") then
					texture, count = GetContainerItemInfo(bag,slot);
                        	iseedCount = iseedCount + count;
                    	end
				if (itemName == "야생 가지") then
					texture, count = GetContainerItemInfo(bag,slot);
                        	berriesCount = berriesCount + count;
                    	end
				if (itemName == "야생 가시뿌리") then
					texture, count = GetContainerItemInfo(bag,slot);
                        	thornrootCount = thornrootCount + count;
                    	end
				if (itemName == "가벼운 깃털") then
					texture, count = GetContainerItemInfo(bag,slot);
                        	featherCount = featherCount + count;
                    	end
				if (itemName == "성스러운 양초") then
					texture, count = GetContainerItemInfo(bag,slot);
                        	hcandleCount = hcandleCount + count;
                    	end
				if (itemName == "신성한 양초") then
					texture, count = GetContainerItemInfo(bag,slot);
                        	scandleCount = scandleCount + count;
                    	end
				if (itemName == "신앙의 징표") then
					texture, count = GetContainerItemInfo(bag,slot);
                        	symbolCount = symbolCount + count;
                    	end
				if (itemName == "왕의 징표") then
					texture, count = GetContainerItemInfo(bag,slot);
                        	kingCount = kingCount + count;
                    	end
                	end
            end

	end

    return shardCount,healthCount,soulCount,spellCount,fireCount,ankhCount,scalesCount,oilCount,teleCount,portalCount,arcaneCount,flashCount,blindCount,instantCount,deadlyCount,cripplingCount,mindnumbCount,woundCount,thistleCount,mseedCount,sseedCount,aseedCount,hseedCount,iseedCount,featherCount,hcandleCount,scandleCount,symbolCount,kingCount;

end

function TitanPanelClassTrackerButton_GetButtonText(id)
	local soulshards = shardCount;
	local ankhs = ankhCount;
	local tele = teleCount;
	local portal = portalCount;
	local flash = flashCount;
	local blind = blindCount;
	local poisons = instantCount + deadlyCount + cripplingCount + mindnumbCount + woundCount;
	local thistle = thistleCount;
	local seeds = mseedCount + sseedCount + aseedCount + hseedCount + iseedCount;
	local wild = berriesCount + thornrootCount;
	local feather = featherCount;
	local candles = hcandleCount + scandleCount;
	local symbol = symbolCount;
	local buttontext = "";
	local buttontext2 = "";
	local buttontext3 = "";

        if (UnitClass("player") == "흑마법사") then
if(ButtonTextType == 1) then
	return format(TITAN_WARLOCK_TITLE)
else
		if (shardCount <= SHARD_WARNING) then
			buttontext = format(TITAN_WARLOCK_BUTTON_TEXTSHARDS,TitanUtils_GetRedText(soulshards))
            else
			buttontext = format(TITAN_WARLOCK_BUTTON_TEXTSHARDS,TitanUtils_GetHighlightText(soulshards))
            end
			-- supports turning off labels
			return TITAN_WARLOCK_BUTTON_LABEL, buttontext;
end

        elseif (UnitClass("player") == "주술사") then
if(ButtonTextType == 1) then
return format(TITAN_SHAMAN_TITLE)
else
		if (ankhCount <= ANKH_WARNING) then
			buttontext = format(TITAN_SHAMAN_BUTTON_TEXTANKHS,TitanUtils_GetRedText(ankhs))
		else
			buttontext = format(TITAN_SHAMAN_BUTTON_TEXTANKHS,TitanUtils_GetHighlightText(ankhs))
            end
			-- supports turning off labels
			return TITAN_SHAMAN_BUTTON_LABEL, buttontext;
end

        elseif (UnitClass("player") == "마법사") then          
if(ButtonTextType == 1) then
return format(TITAN_MAGE_TITLE)
else
		if (tele <= RUNE_WARNING and portal <= RUNE_WARNING) then
			buttontext = format(TITAN_MAGE_BUTTON_TEXTTELE, TitanUtils_GetRedText(tele))..
			" ";
			buttontext2 = format(TITAN_MAGE_BUTTON_TEXTPORTAL, TitanUtils_GetRedText(portal));
			-- supports turning off labels
			return TITAN_MAGE_BUTTON_LABELTELE, buttontext, TITAN_MAGE_BUTTON_LABELPORTAL, buttontext2;
            elseif (tele <= RUNE_WARNING and portal >= RUNE_WARNING) then
			buttontext = format(TITAN_MAGE_BUTTON_TEXTTELE, TitanUtils_GetRedText(tele))..
			" ";
			buttontext2 = format(TITAN_MAGE_BUTTON_TEXTPORTAL, TitanUtils_GetHighlightText(portal));
			return TITAN_MAGE_BUTTON_LABELTELE, buttontext, TITAN_MAGE_BUTTON_LABELPORTAL, buttontext2;
            elseif (tele >= RUNE_WARNING and portal <= RUNE_WARNING) then
			buttontext = format(TITAN_MAGE_BUTTON_TEXTTELE, TitanUtils_GetHighlightText(tele))..
			" ";
			buttontext2 = format(TITAN_MAGE_BUTTON_TEXTPORTAL, TitanUtils_GetRedText(portal));
			return TITAN_MAGE_BUTTON_LABELTELE, buttontext, TITAN_MAGE_BUTTON_LABELPORTAL, buttontext2;
            else
			buttontext = format(TITAN_MAGE_BUTTON_TEXTTELE, TitanUtils_GetHighlightText(tele))..
			" ";
			buttontext2 = format(TITAN_MAGE_BUTTON_TEXTPORTAL, TitanUtils_GetHighlightText(portal));
			return TITAN_MAGE_BUTTON_LABELTELE, buttontext, TITAN_MAGE_BUTTON_LABELPORTAL, buttontext2;
		end
end

        elseif (UnitClass("player") == "도적") then
if(ButtonTextType == 1) then
return format(TITAN_ROGUE_TITLE)
else
		if (flash <= ROGUE_WARNING and blind <= ROGUE_WARNING) then
			buttontext = format(TITAN_ROGUE_BUTTON_TEXTFLASH, TitanUtils_GetRedText(flash))..
			" ";
			buttontext2 = format(TITAN_ROGUE_BUTTON_TEXTBLIND, TitanUtils_GetRedText(blind))..
			" ";
			buttontext3 = format(TITAN_ROGUE_BUTTON_TEXTPOISONS, TitanUtils_GetHighlightText(poisons));
			return TITAN_ROGUE_BUTTON_LABELFLASH, buttontext, TITAN_ROGUE_BUTTON_LABELBLIND, buttontext2, TITAN_ROGUE_BUTTON_LABELPOISONS, buttontext3;
            elseif (flash <= ROGUE_WARNING and blind >= ROGUE_WARNING) then
			buttontext = format(TITAN_ROGUE_BUTTON_TEXTFLASH, TitanUtils_GetRedText(flash))..
			" ";
			buttontext2 = format(TITAN_ROGUE_BUTTON_TEXTBLIND, TitanUtils_GetHighlightText(blind))..
			" ";
			buttontext3 = format(TITAN_ROGUE_BUTTON_TEXTPOISONS, TitanUtils_GetHighlightText(poisons));
			return TITAN_ROGUE_BUTTON_LABELFLASH, buttontext, TITAN_ROGUE_BUTTON_LABELBLIND, buttontext2, TITAN_ROGUE_BUTTON_LABELPOISONS, buttontext3;
            elseif (flash >= ROGUE_WARNING and blind <= ROGUE_WARNING) then
			buttontext = format(TITAN_ROGUE_BUTTON_TEXTFLASH, TitanUtils_GetHighlightText(flash))..
			" ";
			buttontext2 = format(TITAN_ROGUE_BUTTON_TEXTBLIND, TitanUtils_GetRedText(blind))..
			" ";
			buttontext3 = format(TITAN_ROGUE_BUTTON_TEXTPOISONS, TitanUtils_GetHighlightText(poisons));
			return TITAN_ROGUE_BUTTON_LABELFLASH, buttontext, TITAN_ROGUE_BUTTON_LABELBLIND, buttontext2, TITAN_ROGUE_BUTTON_LABELPOISONS, buttontext3;
            else
			buttontext = format(TITAN_ROGUE_BUTTON_TEXTFLASH, TitanUtils_GetHighlightText(flash))..
			" ";
			buttontext2 = format(TITAN_ROGUE_BUTTON_TEXTBLIND, TitanUtils_GetHighlightText(blind))..
			" ";
			buttontext3 = format(TITAN_ROGUE_BUTTON_TEXTPOISONS, TitanUtils_GetHighlightText(poisons));
			return TITAN_ROGUE_BUTTON_LABELFLASH, buttontext, TITAN_ROGUE_BUTTON_LABELBLIND, buttontext2, TITAN_ROGUE_BUTTON_LABELPOISONS, buttontext3;
		end
end

        elseif (UnitClass("player") == "드루이드") then          
if(ButtonTextType == 1) then
return format(TITAN_DRUID_TITLE)
else
		if (seeds <= DRUID_WARNING and wild <= DRUID_WARNING) then
			buttontext = format(TITAN_DRUID_BUTTON_TEXTSEEDS, TitanUtils_GetRedText(seeds))..
			" ";
			buttontext2 = format(TITAN_DRUID_BUTTON_TEXTWILD, TitanUtils_GetRedText(wild));
			return TITAN_DRUID_BUTTON_LABELSEEDS, buttontext, TITAN_DRUID_BUTTON_LABELWILD, buttontext2;
            elseif (seeds <= DRUID_WARNING and wild >= DRUID_WARNING) then
			buttontext = format(TITAN_DRUID_BUTTON_TEXTSEEDS, TitanUtils_GetRedText(seeds))..
			" ";
			buttontext2 = format(TITAN_DRUID_BUTTON_TEXTWILD, TitanUtils_GetHighlightText(wild));
			return TITAN_DRUID_BUTTON_LABELSEEDS, buttontext, TITAN_DRUID_BUTTON_LABELWILD, buttontext2;
            elseif (seeds >= DRUID_WARNING and wild <= DRUID_WARNING) then
			buttontext = format(TITAN_DRUID_BUTTON_TEXTSEEDS, TitanUtils_GetHighlightText(seeds))..
			" ";
			buttontext2 = format(TITAN_DRUID_BUTTON_TEXTWILD, TitanUtils_GetRedText(wild));
			return TITAN_DRUID_BUTTON_LABELSEEDS, buttontext, TITAN_DRUID_BUTTON_LABELWILD, buttontext2;
            else
			buttontext = format(TITAN_DRUID_BUTTON_TEXTSEEDS, TitanUtils_GetHighlightText(seeds))..
			" ";
			buttontext2 = format(TITAN_DRUID_BUTTON_TEXTWILD, TitanUtils_GetHighlightText(wild));
			return TITAN_DRUID_BUTTON_LABELSEEDS, buttontext, TITAN_DRUID_BUTTON_LABELWILD, buttontext2;
		end
end

        elseif (UnitClass("player") == "사제") then
if(ButtonTextType == 1) then
return format(TITAN_PRIEST_TITLE)
else
		if (feather <= PRIEST_WARNING and candles <= PRIEST_WARNING) then
			buttontext = format(TITAN_PRIEST_BUTTON_TEXTFEATHER, TitanUtils_GetRedText(feather))..
			" ";
			buttontext2 = format(TITAN_PRIEST_BUTTON_TEXTCANDLES, TitanUtils_GetRedText(candles));
			return TITAN_PRIEST_BUTTON_LABELFEATHERS, buttontext, TITAN_PRIEST_BUTTON_LABELCANDLES, buttontext2;
            elseif (feather <= PRIEST_WARNING and candles >= PRIEST_WARNING) then
			buttontext = format(TITAN_PRIEST_BUTTON_TEXTFEATHER, TitanUtils_GetRedText(feather))..
			" ";
			buttontext2 = format(TITAN_PRIEST_BUTTON_TEXTCANDLES, TitanUtils_GetHighlightText(candles));
			return TITAN_PRIEST_BUTTON_LABELFEATHERS, buttontext, TITAN_PRIEST_BUTTON_LABELCANDLES, buttontext2;
            elseif (feather >= PRIEST_WARNING and candles <= PRIEST_WARNING) then
			buttontext = format(TITAN_PRIEST_BUTTON_TEXTFEATHER, TitanUtils_GetHighlightText(feather))..
			" ";
			buttontext2 = format(TITAN_PRIEST_BUTTON_TEXTCANDLES, TitanUtils_GetRedText(candles));
			return TITAN_PRIEST_BUTTON_LABELFEATHERS, buttontext, TITAN_PRIEST_BUTTON_LABELCANDLES, buttontext2;
            else
			buttontext = format(TITAN_PRIEST_BUTTON_TEXTFEATHER, TitanUtils_GetHighlightText(feather))..
			" ";
			buttontext2 = format(TITAN_PRIEST_BUTTON_TEXTCANDLES, TitanUtils_GetHighlightText(candles));
			return TITAN_PRIEST_BUTTON_LABELFEATHERS, buttontext, TITAN_PRIEST_BUTTON_LABELCANDLES, buttontext2;
		end
end

	elseif (UnitClass("player") == "성기사") then
		if(ButtonTextType == 1) then
		return format(TITAN_PALADIN_TITLE)
		else
		if (symbolCount <= PALADIN_WARNING) then
			buttontext = format(TITAN_PALADIN_BUTTON_TEXTSYMBOL,TitanUtils_GetRedText(symbol))
            else
			buttontext = format(TITAN_PALADIN_BUTTON_TEXTSYMBOL,TitanUtils_GetHighlightText(symbol))
            end
			-- supports turning off labels
			return TITAN_PALADIN_BUTTON_LABEL, buttontext;
end

	elseif (UnitClass("player") == "전사") then
            return format(TITAN_WARRIOR_TITLE)
	elseif (UnitClass("player") == "사냥꾼") then
            return format(TITAN_HUNTER_TITLE)
      else
            return format(TITAN_CLASSTRACKER_BUTTON_TEXT)
      end
end

function TitanPanelClassTrackerButton_GetTooltipText()
	local soulshards = shardCount;
	local ankhs = ankhCount;
	local scales = scalesCount;
	local oil = oilCount;
	local tele = teleCount;
	local portal = portalCount;
	local arcane = arcaneCount;
	local flash = flashCount;
	local blind = blindCount;
	local thistle = thistleCount;
	local instant = instantCount;
	local deadly = deadlyCount;
	local crippling = cripplingCount;
	local mindnumb = mindnumbCount;
	local wound = woundCount;
	local mseed = mseedCount;
	local sseed = sseedCount;
	local aseed = aseedCount;
	local hseed = hseedCount;
	local iseed = iseedCount;
	local berries = berriesCount;
	local thornroot = thornrootCount;
	local feather = featherCount;
	local hcandle = hcandleCount;
	local scandle = scandleCount;
	local symbol = symbolCount;
	local king = kingCount;

		if (healthCount == 1) then
			health = "만들었습니다.";
		else
			health = "";
		end
		if (soulCount == 1) then
			soul = "만들었습니다.";
		else
			soul = "";
		end
		if (spellCount == 1) then
			spell = "만들었습니다.";
		else
			spell = "";
		end
		if (fireCount == 1) then
			fire = "만들었습니다.";
		else
			fire = "";
		end

        if (UnitClass("player") == "흑마법사") then
        	return "".. format(TITAN_CLASSTRACKER_TOOLTIP_CLICK).."\n".."\n"..
		format(TITAN_WARLOCK_TOOLTIP_SHARDS, TitanUtils_GetHighlightText(soulshards)).."\n"..
		format(TITAN_WARLOCK_TOOLTIP_HEALTH, TitanUtils_GetHighlightText(health)).."\n"..
		format(TITAN_WARLOCK_TOOLTIP_SOUL, TitanUtils_GetHighlightText(soul)).."\n"..
		format(TITAN_WARLOCK_TOOLTIP_SPELL, TitanUtils_GetHighlightText(spell)).."\n"..
		format(TITAN_WARLOCK_TOOLTIP_FIRE, TitanUtils_GetHighlightText(fire));

        elseif (UnitClass("player") == "주술사") then
        	return "".. format(TITAN_CLASSTRACKER_TOOLTIP_CLICK).."\n".."\n"..
		format(TITAN_SHAMAN_TOOLTIP_ANKHS, TitanUtils_GetHighlightText(ankhs)).."\n"..
		format(TITAN_SHAMAN_TOOLTIP_SCALES, TitanUtils_GetHighlightText(scales)).."\n"..
        	format(TITAN_SHAMAN_TOOLTIP_OIL, TitanUtils_GetHighlightText(oil));

        elseif (UnitClass("player") == "마법사") then
        	return "".. format(TITAN_CLASSTRACKER_TOOLTIP_CLICK).."\n".."\n"..
		format(TITAN_MAGE_TOOLTIP_TELE, TitanUtils_GetHighlightText(tele)).."\n"..
		format(TITAN_MAGE_TOOLTIP_PORTAL, TitanUtils_GetHighlightText(portal)).."\n"..
		format(TITAN_MAGE_TOOLTIP_ARCANE, TitanUtils_GetHighlightText(arcane)).."\n"..
		format(TITAN_MAGE_TOOLTIP_FEATHER, TitanUtils_GetHighlightText(feather));

        elseif (UnitClass("player") == "도적") then
        	return "".. format(TITAN_CLASSTRACKER_TOOLTIP_CLICK).."\n".."\n"..
		format(TITAN_ROGUE_TOOLTIP_FLASH, TitanUtils_GetHighlightText(flash)).."\n"..
		format(TITAN_ROGUE_TOOLTIP_BLIND, TitanUtils_GetHighlightText(blind)).."\n"..
		format(TITAN_ROGUE_TOOLTIP_THISTLE, TitanUtils_GetHighlightText(thistle)).."\n"..
		format(TITAN_ROGUE_TOOLTIP_INSTANT, TitanUtils_GetHighlightText(instant)).."\n"..
		format(TITAN_ROGUE_TOOLTIP_DEADLY, TitanUtils_GetHighlightText(deadly)).."\n"..
		format(TITAN_ROGUE_TOOLTIP_CRIPPLING, TitanUtils_GetHighlightText(crippling)).."\n"..
		format(TITAN_ROGUE_TOOLTIP_MINDNUMB, TitanUtils_GetHighlightText(mindnumb)).."\n"..
		format(TITAN_ROGUE_TOOLTIP_WOUND, TitanUtils_GetHighlightText(wound));

        elseif (UnitClass("player") == "드루이드") then
        	return "".. format(TITAN_CLASSTRACKER_TOOLTIP_CLICK).."\n".."\n"..
		format(TITAN_DRUID_TOOLTIP_MSEED, TitanUtils_GetHighlightText(mseed)).."\n"..
		format(TITAN_DRUID_TOOLTIP_SSEED, TitanUtils_GetHighlightText(sseed)).."\n"..
		format(TITAN_DRUID_TOOLTIP_ASEED, TitanUtils_GetHighlightText(aseed)).."\n"..
		format(TITAN_DRUID_TOOLTIP_HSEED, TitanUtils_GetHighlightText(hseed)).."\n"..
		format(TITAN_DRUID_TOOLTIP_ISEED, TitanUtils_GetHighlightText(iseed)).."\n"..
		format(TITAN_DRUID_TOOLTIP_BERRIES, TitanUtils_GetHighlightText(berries)).."\n"..
		format(TITAN_DRUID_TOOLTIP_THORNROOT, TitanUtils_GetHighlightText(thornroot));

        elseif (UnitClass("player") == "사제") then
        	return "".. format(TITAN_CLASSTRACKER_TOOLTIP_CLICK).."\n".."\n"..
		format(TITAN_PRIEST_TOOLTIP_FEATHER, TitanUtils_GetHighlightText(feather)).."\n"..
		format(TITAN_PRIEST_TOOLTIP_HCANDLE, TitanUtils_GetHighlightText(hcandle)).."\n"..
		format(TITAN_PRIEST_TOOLTIP_SCANDLE, TitanUtils_GetHighlightText(scandle));

	  elseif (UnitClass("player") == "성기사") then
        	return "".. format(TITAN_CLASSTRACKER_TOOLTIP_CLICK).."\n".."\n"..
		format(TITAN_PALADIN_TOOLTIP_SYMBOL, TitanUtils_GetHighlightText(symbol)).."\n"..
		format(TITAN_PALADIN_TOOLTIP_KING, TitanUtils_GetHighlightText(king));

        else
            return format(TITAN_CLASSTRACKER_TOOLTIP_NA);
        end
end

function TitanPanelRightClickMenu_PrepareClassTrackerMenu()
	local id="ClassTracker"
	local info
	TitanPanelRightClickMenu_AddTitle(TitanPlugins[id].menuText)

	info={}
	info.text=TITAN_CT_MENU_SHOW_TRACKER
	info.func=function()
		ButtonTextType=nil
		TitanPanelButton_UpdateButton("ClassTracker")
	end
	info.checked=TitanUtils_Toggle(ButtonTextType)
	UIDropDownMenu_AddButton(info)

	info={}
	info.text=TITAN_CT_MENU_SHOW_TITLE
	info.func=function()
		ButtonTextType=1
		TitanPanelButton_UpdateButton("ClassTracker")
	end
	info.checked=ButtonTextType
	UIDropDownMenu_AddButton(info)

	TitanPanelRightClickMenu_AddSpacer();

	TitanPanelRightClickMenu_AddToggleLabelText("ClassTracker");

	TitanPanelRightClickMenu_AddSpacer();

	TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_CUSTOMIZE..TITAN_PANEL_MENU_POPUP_IND,id,TITAN_PANEL_MENU_FUNC_CUSTOMIZE)
	TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE,id,TITAN_PANEL_MENU_FUNC_HIDE)
end
--------------------------------------------------------------------------------------------------
-- Titan [BuffReagent]
-- Author: WalleniuM @ Mal'Ganis
-- Last Update: 06.03.2006
-- Revision-nr: $0808-1
--------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------
-- Globals Variables (do not change)
--------------------------------------------------------------------------------------------------

-- names
TITAN_BUFFREAGENT_ID =  "BuffReagent";
TITAN_BUFFREAGENT_VERSION = " 0.9.0";
TITAN_BUFFREAGENT_BUTTON_TEXT = "%s";
TITAN_BUFFREAGENT_CUSTOMTHING_N = nil;

-- colors
TEXT_COLOR_WHITE = "|cffffffff";
TEXT_COLOR_GOLD = "|cffCEA208";
TEXT_COLOR_RED = "|cffff0000";
TEXT_COLOR_GREEN = "|cff00ff00";

if (tms_RedStatus == nil) then
tms_RedStatus = 5;
end

looping=200;
--------------------------------------------------------------------------------------------------
-- OnLoad Functions
--------------------------------------------------------------------------------------------------
function tms_OnLoad()
if (UnitClass("player") == TITAN_BUFFREAGENT_CLASS_PRIEST) then
TITAN_BUFFREAGENT_BUTTON_ICON = "Interface\\Icons\\INV_Misc_Candle_03";
elseif (UnitClass("player") == TITAN_BUFFREAGENT_CLASS_ROGUE) then
TITAN_BUFFREAGENT_BUTTON_ICON = "Interface\\Icons\\INV_Misc_Powder_Purple";
elseif (UnitClass("player") == TITAN_BUFFREAGENT_CLASS_DRUID) then
TITAN_BUFFREAGENT_BUTTON_ICON = "Interface\\Icons\\INV_Misc_Branch_01";
elseif (UnitClass("player") == TITAN_BUFFREAGENT_CLASS_PALA) then
TITAN_BUFFREAGENT_BUTTON_ICON = "Interface\\Icons\\INV_Stone_WeightStone_05";
elseif (UnitClass("player") == TITAN_BUFFREAGENT_CLASS_SHAMAN) then
TITAN_BUFFREAGENT_BUTTON_ICON = "Interface\\Icons\\INV_Jewelry_Talisman_06";
elseif (UnitClass("player") == TITAN_BUFFREAGENT_CLASS_WARLOCK) then
TITAN_BUFFREAGENT_BUTTON_ICON = "Interface\\Icons\\INV_Misc_Gem_Amethyst_02";
elseif (UnitClass("player") == TITAN_BUFFREAGENT_CLASS_MAGE) then
TITAN_BUFFREAGENT_BUTTON_ICON = "Interface\\Icons\\INV_Misc_Dust_01";
else
TITAN_BUFFREAGENT_BUTTON_ICON = "Interface\\Icons\\INV_Misc_Book_09";
end

	this.registry = { 
		id = TITAN_BUFFREAGENT_ID,
		menuText = TITAN_BUFFREAGENT_ID, 
		buttonTextFunction = "TitanPanelBuffReagent_GetButtonText", 
		tooltipTitle = TITAN_BUFFREAGENT_ID.." "..TITAN_BUFFREAGENT_VERSION,
		tooltipTextFunction = "tms_getToolTip", 
		icon = TITAN_BUFFREAGENT_BUTTON_ICON,
		iconWidth = 16,
		category = "Information", 
		version = TITAN_BUFFREAGENT_VERSION,
		savedVariables = {
			ShowIcon = 1,
			ShowLabelText = 1,
			ShowColoredButton = TITAN_NIL,
			MonitorCaption = TITAN_NIL,
			ShowWarnings = TITAN_NIL,
		},
	};
	-- register Events to update the Buttons
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("SPELLCAST_STOP");
	this:RegisterEvent("MERCHANT_SHOW");
	this:RegisterEvent("MERCHANT_CLOSED");
	this:RegisterEvent("SPELLS_CHANGED");
	this:RegisterEvent("SPELL_UPDATE_COOLDOWN");
	this:RegisterEvent("MAIL_CLOSED");
	this:RegisterEvent("BAG_UPDATE");
	this:RegisterEvent("BANKFRAME_CLOSED");
	this:RegisterEvent("UNIT_INVENTORY_CHANGED");
end

--------------------------------------------------------------------------------------------------
-- SPELL RANKS
--------------------------------------------------------------------------------------------------
local function tms_GetSpellRank(spell)
	local rank = 0;
	for i = 1, 180 do 
		local spellName, spellRank = GetSpellName(i, BOOKTYPE_SPELL);
		if( spellName ) then
			if( string.find(spellName, spell, 1, true) ) then
				rank = spellRank;
		  end    	                        
		end
 	end
  return rank;
end

function tms_NameFromLink(link)
	local name
	if (link) then
		for name in string.gfind(link, "|c%x+|Hitem:%d+:%d+:%d+:%d+|h%[(.-)%]|h|r") do
			return name
		end
	end
end 

--------------------------------------------------------------------------------------------------
-- Sound if no reagents
--------------------------------------------------------------------------------------------------

function tms_playsound()
	PlaySoundFile("Sound\\interface\\mapping.wav")
end

-- check if the char is in a town
function tms_isCowTown()
		a=false
		if (GetZoneText()== TITAN_BUFFREAGENT_CITY_IF) then a=true end
		if (GetZoneText()== TITAN_BUFFREAGENT_CITY_SW) then a=true end
		if (GetZoneText()== TITAN_BUFFREAGENT_CITY_DS) then a=true end
		if (GetZoneText()== TITAN_BUFFREAGENT_CITY_OG) then a=true end
		if (GetZoneText()== TITAN_BUFFREAGENT_CITY_TB) then a=true end
		if (GetZoneText()== TITAN_BUFFREAGENT_CITY_UC) then a=true end
		return a;
end

--------------------------------------------------------------------------------------------------
-- Insert Window
--------------------------------------------------------------------------------------------------
function InsertWindowSave(aart)
    if (aart == "tms_CustomText1") then
        if (BRGInsertFrameEditBox:GetText() ~= "") then
            tms_CustomText1 = BRGInsertFrameEditBox:GetText();
        else
            tms_CustomText1 = nil;
        end
    elseif (aart == "tms_CustomText2") then
        if (BRGInsertFrameEditBox:GetText() ~= "") then
            tms_CustomText2 = BRGInsertFrameEditBox:GetText();
        else
            tms_CustomText2 = nil;
        end
    end
    TitanPanelButton_UpdateButton(TITAN_BUFFREAGENT_ID); -- force the update!
end

function BRGInsert_Toggle()
	if(BRGInsertFrame:IsVisible()) then
		BRGInsertFrame:Hide();
	else
		BRGInsertFrame:Show();
	end
end

--------------------------------------------------------------------------------------------------
-- Reagent Classes
--------------------------------------------------------------------------------------------------
-- rogue
function tms_GetRoguePowder()
if (UnitClass("player") == TITAN_BUFFREAGENT_CLASS_ROGUE) then
	local rogue_powder = 0
	for bag = 4, 0, -1 do
		local size = GetContainerNumSlots(bag);
		if (size > 0) then
			for slot=1, size, 1 do
				local texture, itemCount = GetContainerItemInfo(bag, slot);
				if (itemCount) then
					local itemName = tms_NameFromLink(GetContainerItemLink(bag, slot));	
					if  ((itemName) and (itemName ~= "")) then -- if the item has a name
                        if (itemName == TMS_ROGUE_POWDER) then -- if the item is a rogue powder, increase the count
							rogue_powder  = rogue_powder + itemCount;
						end
					end
				end
			end            
		end
	end	
	return rogue_powder
	end
end

function tms_GetRogueBlind()
if (UnitClass("player") == TITAN_BUFFREAGENT_CLASS_ROGUE) then
	local rogue_blind = 0
	for bag = 4, 0, -1 do
		local size = GetContainerNumSlots(bag);
		if (size > 0) then
			for slot=1, size, 1 do
				local texture, itemCount = GetContainerItemInfo(bag, slot);
				if (itemCount) then
					local itemName = tms_NameFromLink(GetContainerItemLink(bag, slot));	
					if  ((itemName) and (itemName ~= "")) then -- if the item has a name
                        if (itemName == TMS_ROGUE_BLIND) then -- if the item is a rogue powder, increase the count
							rogue_blind  = rogue_blind + itemCount;
						end
					end
				end
			end            
		end
	end	
	return rogue_blind
	end
end

function tms_GetRogueThistle()
if (UnitClass("player") == TITAN_BUFFREAGENT_CLASS_ROGUE) then
	local rogue_thistle = 0
	for bag = 4, 0, -1 do
		local size = GetContainerNumSlots(bag);
		if (size > 0) then
			for slot=1, size, 1 do
				local texture, itemCount = GetContainerItemInfo(bag, slot);
				if (itemCount) then
					local itemName = tms_NameFromLink(GetContainerItemLink(bag, slot));	
					if  ((itemName) and (itemName ~= "")) then -- if the item has a name
                        if (itemName == TMS_ROGUE_THISTLE) then -- if the item is a rogue powder, increase the count
							rogue_thistle  = rogue_thistle + itemCount;
						end
					end
				end
			end            
		end
	end	
	return rogue_thistle
	end
end

function tms_GetPoisonInstant()
if (UnitClass("player") == TITAN_BUFFREAGENT_CLASS_ROGUE) then
	local rogue_instant = 0
	for bag = 4, 0, -1 do
		local size = GetContainerNumSlots(bag);
		if (size > 0) then
			for slot=1, size, 1 do
				local texture, itemCount = GetContainerItemInfo(bag, slot);
				if (itemCount) then
					local itemName = tms_NameFromLink(GetContainerItemLink(bag, slot));	
					if  ((itemName) and (itemName ~= "")) then -- if the item has a name
                       if (itemName == TMS_ROGUE_INSTANT) or (itemName == TMS_ROGUE_INSTANT..TMS_NUMBER_1) or (itemName == TMS_ROGUE_INSTANT..TMS_NUMBER_2) or (itemName == TMS_ROGUE_INSTANT..TMS_NUMBER_3) or (itemName == TMS_ROGUE_INSTANT..TMS_NUMBER_4) or (itemName == TMS_ROGUE_INSTANT..TMS_NUMBER_5) or (itemName == TMS_ROGUE_INSTANT..TMS_NUMBER_6) then
							rogue_instant  = rogue_instant + itemCount;
						end
					end
				end
			end            
		end
	end	
	return rogue_instant
	end
end

function tms_GetPoisonDeadly()
if (UnitClass("player") == TITAN_BUFFREAGENT_CLASS_ROGUE) then
	local rogue_deadly = 0
	for bag = 4, 0, -1 do
		local size = GetContainerNumSlots(bag);
		if (size > 0) then
			for slot=1, size, 1 do
				local texture, itemCount = GetContainerItemInfo(bag, slot);
				if (itemCount) then
					local itemName = tms_NameFromLink(GetContainerItemLink(bag, slot));	
					if  ((itemName) and (itemName ~= "")) then -- if the item has a name
                        if (itemName == TMS_ROGUE_DEADLY) or (itemName == TMS_ROGUE_DEADLY..TMS_NUMBER_1) or (itemName == TMS_ROGUE_DEADLY..TMS_NUMBER_2) or (itemName == TMS_ROGUE_DEADLY..TMS_NUMBER_3) or (itemName == TMS_ROGUE_DEADLY..TMS_NUMBER_4) or (itemName == TMS_ROGUE_DEADLY..TMS_NUMBER_5) then
							rogue_deadly  = rogue_deadly + itemCount;
						end
					end
				end
			end            
		end
	end	
	return rogue_deadly
	end
end

function tms_GetPoisonCrippling()
if (UnitClass("player") == TITAN_BUFFREAGENT_CLASS_ROGUE) then
	local rogue_crippling = 0
	for bag = 4, 0, -1 do
		local size = GetContainerNumSlots(bag);
		if (size > 0) then
			for slot=1, size, 1 do
				local texture, itemCount = GetContainerItemInfo(bag, slot);
				if (itemCount) then
					local itemName = tms_NameFromLink(GetContainerItemLink(bag, slot));	
					if  ((itemName) and (itemName ~= "")) then -- if the item has a name
                       if (itemName == TMS_ROGUE_CRIPPLING) or (itemName == TMS_ROGUE_CRIPPLING..TMS_NUMBER_1) or (itemName == TMS_ROGUE_CRIPPLING..TMS_NUMBER_2) then
							rogue_crippling  = rogue_crippling + itemCount;
						end
					end
				end
			end            
		end
	end	
	return rogue_crippling
	end
end

function tms_GetPoisonMindnumb()
if (UnitClass("player") == TITAN_BUFFREAGENT_CLASS_ROGUE) then
	local rogue_mindnumb = 0
	for bag = 4, 0, -1 do
		local size = GetContainerNumSlots(bag);
		if (size > 0) then
			for slot=1, size, 1 do
				local texture, itemCount = GetContainerItemInfo(bag, slot);
				if (itemCount) then
					local itemName = tms_NameFromLink(GetContainerItemLink(bag, slot));	
					if  ((itemName) and (itemName ~= "")) then -- if the item has a name
                       if (itemName == TMS_ROGUE_MINDNUMB) or (itemName == TMS_ROGUE_MINDNUMB..TMS_NUMBER_1) or (itemName == TMS_ROGUE_MINDNUMB..TMS_NUMBER_2) or (itemName == TMS_ROGUE_MINDNUMB..TMS_NUMBER_3) then
							rogue_mindnumb  = rogue_mindnumb + itemCount;
						end
					end
				end
			end            
		end
	end	
	return rogue_mindnumb
	end
end

function tms_GetPoisonWound()
if (UnitClass("player") == TITAN_BUFFREAGENT_CLASS_ROGUE) then
	local rogue_wound = 0
	for bag = 4, 0, -1 do
		local size = GetContainerNumSlots(bag);
		if (size > 0) then
			for slot=1, size, 1 do
				local texture, itemCount = GetContainerItemInfo(bag, slot);
				if (itemCount) then
					local itemName = tms_NameFromLink(GetContainerItemLink(bag, slot));	
					if  ((itemName) and (itemName ~= "")) then -- if the item has a name
                       if (itemName == TMS_ROGUE_WOUND) or (itemName == TMS_ROGUE_WOUND..TMS_NUMBER_1) or (itemName == TMS_ROGUE_WOUND..TMS_NUMBER_2) or (itemName == TMS_ROGUE_WOUND..TMS_NUMBER_3) or (itemName == TMS_ROGUE_WOUND..TMS_NUMBER_4) then
							rogue_wound  = rogue_wound + itemCount;
						end
					end
				end
			end            
		end
	end	
	return rogue_wound
	end
end

-- Warlock
function tms_GetSShard()
if (UnitClass("player") == TITAN_BUFFREAGENT_CLASS_WARLOCK) then
	local warlock_sshard = 0
	for bag = 4, 0, -1 do
		local size = GetContainerNumSlots(bag);
		if (size > 0) then
			for slot=1, size, 1 do
				local texture, itemCount = GetContainerItemInfo(bag, slot);
				if (itemCount) then
					local itemName = tms_NameFromLink(GetContainerItemLink(bag, slot));	
					if  ((itemName) and (itemName ~= "")) then -- if the item has a name
                        if (itemName == TMS_WARLOCK_SOULSHARD) then -- if the item is a rogue powder, increase the count
							warlock_sshard  = warlock_sshard + itemCount;
						end
					end
				end
			end            
		end
	end	
	return warlock_sshard
	end
end

function tms_GetSoulStone()
if (UnitClass("player") == TITAN_BUFFREAGENT_CLASS_WARLOCK) then
	local warlock_soulstone = 0
	for bag = 4, 0, -1 do
		local size = GetContainerNumSlots(bag);
		if (size > 0) then
			for slot=1, size, 1 do
				local texture, itemCount = GetContainerItemInfo(bag, slot);
				if (itemCount) then
					local itemName = tms_NameFromLink(GetContainerItemLink(bag, slot));	
					if  ((itemName) and (itemName ~= "")) then -- if the item has a name
					   if ( GetLocale() == "frFR" ) then   -- french one
					       if (itemName == TMS_WARLOCK_SOUL) or (itemName == TMS_WARLOCK_SOUL..TMS_RANKS_2) or (itemName == TMS_WARLOCK_SOUL..TMS_RANKS_3) or (itemName == TMS_WARLOCK_SOUL..TMS_RANKS_4) or (itemName == TMS_WARLOCK_SOUL..TMS_RANKS_5) then -- if the item is a rogue powder, increase the count
					       warlock_soulstone  = warlock_soulstone + itemCount;
						    end
                       else   -- the rest
                            if (itemName == TMS_WARLOCK_SOUL) or (itemName == TMS_RANKS_2..TMS_WARLOCK_SOUL) or (itemName == TMS_RANKS_3..TMS_WARLOCK_SOUL) or (itemName == TMS_RANKS_4..TMS_WARLOCK_SOUL) or (itemName == TMS_RANKS_5..TMS_WARLOCK_SOUL) then -- if the item is a rogue powder, increase the count
						    warlock_soulstone  = warlock_soulstone + itemCount;
						    end
                        end	
					end
				end
			end            
		end
	end	
	return warlock_soulstone
	end
end

function tms_GetFireStone()
if (UnitClass("player") == TITAN_BUFFREAGENT_CLASS_WARLOCK) then
	local warlock_firestone = 0
	for bag = 4, 0, -1 do
		local size = GetContainerNumSlots(bag);
		if (size > 0) then
			for slot=1, size, 1 do
				local texture, itemCount = GetContainerItemInfo(bag, slot);
				if (itemCount) then
					local itemName = tms_NameFromLink(GetContainerItemLink(bag, slot));	
					if  ((itemName) and (itemName ~= "")) then -- if the item has a name
                        if ( GetLocale() == "frFR" ) then   -- french one
                            if (itemName == TMS_WARLOCK_FIRE) or (itemName == TMS_WARLOCK_FIRE..TMS_RANKS_3) or (itemName == TMS_WARLOCK_FIRE..TMS_RANKS_4) or (itemName == TMS_WARLOCK_FIRE..TMS_RANKS_5) then -- if the item is a rogue powder, increase the count
						    warlock_firestone  = warlock_firestone + itemCount;
						    end
                        else  -- the rest
						     if (itemName == TMS_WARLOCK_FIRE) or (itemName == TMS_RANKS_3..TMS_WARLOCK_FIRE) or (itemName == TMS_RANKS_4..TMS_WARLOCK_FIRE) or (itemName == TMS_RANKS_5..TMS_WARLOCK_FIRE) then -- if the item is a rogue powder, increase the count
                            warlock_firestone  = warlock_firestone + itemCount;
						    end
                        end
					end
				end
			end            
		end
	end	
	return warlock_firestone
	end
end

function tms_GetHealthStone()
if (UnitClass("player") == TITAN_BUFFREAGENT_CLASS_WARLOCK) then
	local warlock_healthstone = 0
	for bag = 4, 0, -1 do
		local size = GetContainerNumSlots(bag);
		if (size > 0) then
			for slot=1, size, 1 do
				local texture, itemCount = GetContainerItemInfo(bag, slot);
				if (itemCount) then
					local itemName = tms_NameFromLink(GetContainerItemLink(bag, slot));	
					if  ((itemName) and (itemName ~= "")) then -- if the item has a name
					    if ( GetLocale() == "frFR" ) then   -- french one
                            if (itemName == TMS_WARLOCK_HEALTH) or (itemName == TMS_WARLOCK_HEALTH..TMS_RANKS_2) or (itemName == TMS_WARLOCK_HEALTH..TMS_RANKS_3)  or (itemName == TMS_WARLOCK_HEALTH..TMS_RANKS_4) or (itemName == TMS_WARLOCK_HEALTH..TMS_RANKS_5) then -- if the item is a rogue powder, increase the count
                            warlock_healthstone  = warlock_healthstone + itemCount;
						    end
                        else -- the rest
                            if (itemName == TMS_WARLOCK_HEALTH) or (itemName == TMS_RANKS_2..TMS_WARLOCK_HEALTH) or (itemName == TMS_RANKS_3..TMS_WARLOCK_HEALTH)  or (itemName == TMS_RANKS_4..TMS_WARLOCK_HEALTH) or (itemName == TMS_RANKS_5..TMS_WARLOCK_HEALTH) then -- if the item is a rogue powder, increase the count
						    warlock_healthstone  = warlock_healthstone + itemCount;
						    end
                        end
                            
					end
				end
			end            
		end
	end	
	return warlock_healthstone
	end
end

function tms_GetSpellStone()
if (UnitClass("player") == TITAN_BUFFREAGENT_CLASS_WARLOCK) then
	local warlock_spellstone = 0
	for bag = 4, 0, -1 do
		local size = GetContainerNumSlots(bag);
		if (size > 0) then
			for slot=1, size, 1 do
				local texture, itemCount = GetContainerItemInfo(bag, slot);
				if (itemCount) then
					local itemName = tms_NameFromLink(GetContainerItemLink(bag, slot));	
					if  ((itemName) and (itemName ~= "")) then -- if the item has a name
                        if ( GetLocale() == "frFR" ) then   -- french one
                            if (itemName == TMS_WARLOCK_SPELL) or (itemName == TMS_WARLOCK_SPELL..TMS_RANKS_4) or (itemName == TMS_WARLOCK_SPELL..TMS_RANKS_5) then -- if the item is a rogue powder, increase the count
						    warlock_spellstone  = warlock_spellstone + itemCount;
						    end
                        else
                            if (itemName == TMS_WARLOCK_SPELL) or (itemName == TMS_RANKS_4..TMS_WARLOCK_SPELL) or (itemName == TMS_RANKS_5..TMS_WARLOCK_SPELL) then -- if the item is a rogue powder, increase the count
                            warlock_spellstone  = warlock_spellstone + itemCount;
						    end
                        end
					end
				end
			end            
		end
	end	
	return warlock_spellstone
	end
end

-- Shaman
function tms_GetFishPiec()
if (UnitClass("player") == TITAN_BUFFREAGENT_CLASS_SHAMAN) then
	local fishpieces = 0
	for bag = 4, 0, -1 do
		local size = GetContainerNumSlots(bag);
		if (size > 0) then
			for slot=1, size, 1 do
				local texture, itemCount = GetContainerItemInfo(bag, slot);
				if (itemCount) then
					local itemName = tms_NameFromLink(GetContainerItemLink(bag, slot));	
					if  ((itemName) and (itemName ~= "")) then -- if the item has a name
                        if (itemName == TMS_SHAMAN_FISHSCALES) then -- if the item is a rogue powder, increase the count
							fishpieces  = fishpieces + itemCount;
						end
					end
				end
			end            
		end
	end	
	return fishpieces
	end
end

function tms_GetFishOil()
if (UnitClass("player") == TITAN_BUFFREAGENT_CLASS_SHAMAN) then
	local fishoil = 0
	for bag = 4, 0, -1 do
		local size = GetContainerNumSlots(bag);
		if (size > 0) then
			for slot=1, size, 1 do
				local texture, itemCount = GetContainerItemInfo(bag, slot);
				if (itemCount) then
					local itemName = tms_NameFromLink(GetContainerItemLink(bag, slot));	
					if  ((itemName) and (itemName ~= "")) then -- if the item has a name
                        if (itemName == TMS_SHAMAN_FISHOIL) then -- if the item is a rogue powder, increase the count
							fishoil  = fishoil + itemCount;
						end
					end
				end
			end            
		end
	end	
	return fishoil
	end
end

function tms_GetAnkh()
if (UnitClass("player") == TITAN_BUFFREAGENT_CLASS_SHAMAN) then
	local ankh = 0
	for bag = 4, 0, -1 do
		
		local size = GetContainerNumSlots(bag);
		
		if (size > 0) then
			for slot=1, size, 1 do
				local texture, itemCount = GetContainerItemInfo(bag, slot);
				
				if (itemCount) then
					local itemName = tms_NameFromLink(GetContainerItemLink(bag, slot));
					if  ((itemName) and (itemName ~= "")) then 	  -- if the item has a name
						if (itemName == TMS_SHAMAN_ANKH) then     -- if the item is an ankh, increase the count
							ankh  = ankh + itemCount;
						end
					end
				end
			end            
		end
	end	
	return ankh
	end
end

-- Paladin
function tms_GetSymbol()
if (UnitClass("player") == TITAN_BUFFREAGENT_CLASS_PALA) then
	local symbol = 0
	for bag = 4, 0, -1 do
		local size = GetContainerNumSlots(bag);
		if (size > 0) then
			for slot=1, size, 1 do
				local texture, itemCount = GetContainerItemInfo(bag, slot);
				if (itemCount) then
					local itemName = tms_NameFromLink(GetContainerItemLink(bag, slot));
					if  ((itemName) and (itemName ~= "")) then  	-- if the item has a name
						if (itemName == TMS_PALA_SYMBOL) then       -- if the item is a symbol, increase the count
							symbol  = symbol + itemCount;
						end
					end
				end
			end            
		end
	end	
	return symbol
	end
end

function tms_GetPalaKing()
if (UnitClass("player") == TITAN_BUFFREAGENT_CLASS_PALA) then
	local kingsymbol = 0
	for bag = 4, 0, -1 do
		local size = GetContainerNumSlots(bag);
		if (size > 0) then
			for slot=1, size, 1 do
				local texture, itemCount = GetContainerItemInfo(bag, slot);
				if (itemCount) then
					local itemName = tms_NameFromLink(GetContainerItemLink(bag, slot));
					if  ((itemName) and (itemName ~= "")) then  	-- if the item has a name
						if (itemName == TMS_PALA_KING) then       -- if the item is a symbol, increase the count
							kingsymbol  = kingsymbol + itemCount;
						end
					end
				end
			end            
		end
	end	
	return kingsymbol
	end
end

-- Mage
function tms_RunePortal()
if (UnitClass("player") == TITAN_BUFFREAGENT_CLASS_MAGE) then
	local portal = 0
	for bag = 4, 0, -1 do
		local size = GetContainerNumSlots(bag);
		if (size > 0) then
			for slot=1, size, 1 do
				local texture, itemCount = GetContainerItemInfo(bag, slot);
				if (itemCount) then
					local itemName = tms_NameFromLink(GetContainerItemLink(bag, slot));	
					if  ((itemName) and (itemName ~= "")) then -- if the item has a name
						if (itemName == TMS_RUNE_PORTAL) then -- if the item is the "choosen one", increase the count
							portal  = portal + itemCount;
						end
					end
				end
			end            
		end
	end	
	return portal
	end
end

function tms_RuneTeleport()
if (UnitClass("player") == TITAN_BUFFREAGENT_CLASS_MAGE) then
	local teleport = 0
	for bag = 4, 0, -1 do
		local size = GetContainerNumSlots(bag);
		if (size > 0) then
			for slot=1, size, 1 do
				local texture, itemCount = GetContainerItemInfo(bag, slot);
				if (itemCount) then
					local itemName = tms_NameFromLink(GetContainerItemLink(bag, slot));	
					if  ((itemName) and (itemName ~= "")) then -- if the item has a name
						if (itemName == TMS_RUNE_TELEPORT) then -- if the item is the "choosen one", increase the count
							teleport  = teleport + itemCount;
						end
					end
				end
			end            
		end
	end	
	return teleport
	end
end

function tms_LightFeather()
if (UnitClass("player") == TITAN_BUFFREAGENT_CLASS_MAGE) or (UnitClass("player") == TITAN_BUFFREAGENT_CLASS_PRIEST) then
	local lfeather = 0
	for bag = 4, 0, -1 do
		local size = GetContainerNumSlots(bag);
		if (size > 0) then
			for slot=1, size, 1 do
				local texture, itemCount = GetContainerItemInfo(bag, slot);
				if (itemCount) then
					local itemName = tms_NameFromLink(GetContainerItemLink(bag, slot));	
					if  ((itemName) and (itemName ~= "")) then -- if the item has a name
						if (itemName == TMS_LIGHT_FEATHER) then -- if the item is the "choosen one", increase the count
							lfeather  = lfeather + itemCount;
						end
					end
				end
			end            
		end
	end	
	return lfeather
	end
end

function tms_GetPowder()
if (UnitClass("player") == TITAN_BUFFREAGENT_CLASS_MAGE) then
	local powder = 0
	for bag = 4, 0, -1 do
		
		local size = GetContainerNumSlots(bag);
		
		if (size > 0) then
			for slot=1, size, 1 do
				local texture, itemCount = GetContainerItemInfo(bag, slot);
				
				if (itemCount) then
					local itemName = tms_NameFromLink(GetContainerItemLink(bag, slot));
					if  ((itemName) and (itemName ~= "")) then     -- if the item has a name
						if (itemName == TMS_ARCANE_POWDER) then    -- if the item is an arcabe powder, increase the count
							powder  = powder + itemCount;
						end
					end
				end
			end            
		end
	end	
	return powder
	end
end

-- Priest
function tms_GetCandle()
if (UnitClass("player") == TITAN_BUFFREAGENT_CLASS_PRIEST) then
	local candle = 0;
	local rank = tms_GetSpellRank(TMS_PRIEST_SPELL);
	local _, _, _, ranknumber = string.find( rank, "(.+) (.+)" );
	for bag = 4, 0, -1 do
		
		local size = GetContainerNumSlots(bag);
		
		if (size > 0) then
			for slot=1, size, 1 do
				local texture, itemCount = GetContainerItemInfo(bag, slot);
				
				if (itemCount) then
					local itemName = tms_NameFromLink(GetContainerItemLink(bag, slot));	
					if  ((itemName) and (itemName ~= "")) then     -- if the item has a name
						if (ranknumber == "1") then
						if (itemName == TMS_HOLY_CANDLE1 ) then   -- if the item is a candle, increase the count
							candle  = candle + itemCount;
						end
						else
							if (itemName == TMS_HOLY_CANDLE ) then
							candle  = candle + itemCount;
						end
						end
						
					end
				end
			end            
		end
	end	
	return candle
	end
end

--Druid
function tms_GetBerry()
if (UnitClass("player") == TITAN_BUFFREAGENT_CLASS_DRUID) then
	local berry = 0
	local rank = tms_GetSpellRank(TMS_DRUID_SPELL1);
	local _, _, _, ranknumber = string.find( rank, "(.+) (.+)" );
	for bag = 4, 0, -1 do
		
		local size = GetContainerNumSlots(bag);
		
		if (size > 0) then
			for slot=1, size, 1 do
				local texture, itemCount = GetContainerItemInfo(bag, slot);
				
				if (itemCount) then
					local itemName = tms_NameFromLink(GetContainerItemLink(bag, slot));	
					if  ((itemName) and (itemName ~= "")) then        -- if the item has a name
						if (ranknumber == "1") then
						if (itemName == TMS_DRUID_WILDBERRY ) then    -- if the item is the "chosen one", increase the count
							berry  = berry + itemCount;
						end
						else
							if (itemName == TMS_DRUID_DORN ) then
							berry  = berry + itemCount;
						end
						end
					end
				end
			end            
		end
	end	
	return berry
	end
end

function tms_GetSemen()
if (UnitClass("player") == TITAN_BUFFREAGENT_CLASS_DRUID) then
	local semen = 0
	local rank = tms_GetSpellRank(TMS_DRUID_SPELL2);
	local _, _, _, ranknumber = string.find( rank, "(.+) (.+)" );
	for bag = 4, 0, -1 do
		
		local size = GetContainerNumSlots(bag);
		
		if (size > 0) then
			for slot=1, size, 1 do
				local texture, itemCount = GetContainerItemInfo(bag, slot);
				
				if (itemCount) then
					local itemName = tms_NameFromLink(GetContainerItemLink(bag, slot));
					if  ((itemName) and (itemName ~= "")) then     -- if the item has a name
					if (ranknumber == "1") then                    -- if the item is the "chosen one", increase the count
						if (itemName == TMS_DRUID_SEMEN1 ) then
							semen  = semen + itemCount;
						end
					elseif (ranknumber == "2") then
						if (itemName == TMS_DRUID_SEMEN2 ) then
							semen  = semen + itemCount;
						end
					elseif (ranknumber == "3") then
						if (itemName == TMS_DRUID_SEMEN3 ) then
							semen  = semen + itemCount;
						end
					elseif (ranknumber == "4") then
						if (itemName == TMS_DRUID_SEMEN4 ) then
							semen  = semen + itemCount;
						end
					else
						if (itemName == TMS_DRUID_SEMEN5 ) then
							semen  = semen + itemCount;
						end
					end	
					end
				end
			end            
		end
	end	
	return semen
	end
end

-- Custom Reagent 1
function tms_GetCustom1()
if (tms_CustomText1) then
	local custom_reagent1 = 0
	for bag = 4, 0, -1 do
		local size = GetContainerNumSlots(bag);
		if (size > 0) then
			for slot=1, size, 1 do
				local texture, itemCount = GetContainerItemInfo(bag, slot);
				if (itemCount) then
					local itemName = tms_NameFromLink(GetContainerItemLink(bag, slot));	
					if  ((itemName) and (itemName ~= "")) then -- if the item has a name
                        if (itemName == tms_CustomText1) then -- if the item is the searched one, increase the count
							custom_reagent1  = custom_reagent1 + itemCount;
						end
					end
				end
			end            
		end
	end	
	return custom_reagent1
	end
end

-- Custom Reagent 2
function tms_GetCustom2()
if (tms_CustomText2) then
	local custom_reagent2 = 0
	for bag = 4, 0, -1 do
		local size = GetContainerNumSlots(bag);
		if (size > 0) then
			for slot=1, size, 1 do
				local texture, itemCount = GetContainerItemInfo(bag, slot);
				if (itemCount) then
					local itemName = tms_NameFromLink(GetContainerItemLink(bag, slot));	
					if  ((itemName) and (itemName ~= "")) then -- if the item has a name
                        if (itemName == tms_CustomText2) then -- if the item is the searched one, increase the count
							custom_reagent2  = custom_reagent2 + itemCount;
						end
					end
				end
			end            
		end
	end	
	return custom_reagent2
	end
end

--------------------------------------------------------------------------------------------------
-- OnEvent
--------------------------------------------------------------------------------------------------

function tms_OnEvent(event)
	if ( event == "PLAYER_ENTERING_WORLD" ) then
		if ( TMS_SETTINGS == nil ) then
			tms_Initialize(); -- init
		end
		if ( TMS_SETTINGS["VERSION"] ~= TITAN_BUFFREAGENT_VERSION ) then
			tms_Update(TMS_SETTINGS["VERSION"]);
		end
		TitanPanelButton_UpdateButton(TITAN_BUFFREAGENT_ID);
		TitanPanelButton_UpdateTooltip();
		--DEFAULT_CHAT_FRAME:AddMessage(TMS_ROGUE_WOUND..TMS_NUMBER_1);
		return;
	end
	
	if (event == "VARIABLES_LOADED") then
	   tms_Msg(TITAN_BUFFREAGENT_ID.." "..TITAN_BUFFREAGENT_NAME_VERSION.." "..TITAN_BUFFREAGENT_VERSION.." "..TITAN_BUFFREAGENT_LOADED..".");
	end
		-- update variables for vutton events
		if ( event == "MAIL_CLOSED") or ( event == "BAG_UPDATE") or ( event == "BANKFRAME_CLOSED") or ( event == "UNIT_INVENTORY_CHANGED") then
          TitanPanelButton_UpdateButton(TITAN_BUFFREAGENT_ID);
		return;
	end
	
	if ( event == "SPELLCAST_STOP") or ( event == "MERCHANT_CLOSED") or ( event == "SPELLS_CHANGED") or ( event == "SPELL_UPDATE_COOLDOWN") or ( event == "MERCHANT_SHOW") then
          TitanPanelButton_UpdateButton(TITAN_BUFFREAGENT_ID);
		return;
	end	
end

function tms_OnClick(button)
	if ( button == "LeftButton" and IsShiftKeyDown() ) then
		
	end
end

--------------------------------------------------------------------------------------------------
-- Database Functions
--------------------------------------------------------------------------------------------------

function tms_Initialize()
	tms_DEBUG("Initializing ...");
	TMS_SETTINGS = {};
	TMS_SETTINGS["VERSION"] = TITAN_BUFFREAGENT_VERSION;
	TMS_SETTINGS["COUNT"] = 0;
	-- addional saves
    tms_CustomText1 = nil;
    tms_CustomText2 = nil;
    tms_RedStatus = 5;
	tms_DEBUG("Initializing done !");
end

function tms_Update(version)
	tms_Msg(TITAN_BUFFREAGENT_ID.." "..TITAN_BUFFREAGENT_SYS_UPDATING.." "..version.." !");
	if ( version == nil or version == "UNKNOWN" ) then
		tms_Initialize();
	else
		tms_Msg(TITAN_BUFFREAGENT_SYS_NOUPDATE.." !");
		-- added in 0.8.x
		tms_CustomText1 = nil;
        tms_CustomText2 = nil;
        tms_RedStatus = 5;
		TMS_SETTINGS["VERSION"] = TITAN_BUFFREAGENT_VERSION;
		return;
	end
	tms_Msg(TITAN_BUFFREAGENT_SYS_UPDATE.." !");
end

function tms_Reset()
	tms_DEBUG("Resetting database ...");
	tms_Initialize();
	tms_DEBUG("Resetting done !");
end

--------------------------------------------------------------------------------------------------
-- Titan Panel Functions
--------------------------------------------------------------------------------------------------

function TitanPanelBuffReagent_GetButtonText(id)
	local tms_buttonText;
	
	if (UnitClass("player") == TITAN_BUFFREAGENT_CLASS_MAGE) then
	   if (TitanGetVar(TITAN_BUFFREAGENT_ID, "MonitorCaption") == 1) then
            tms_buttonText = TMS_ARCANE_SH_POWDER..tms_ButtonColor(tms_GetPowder(),TMS_ARCANE_POWDER).." "..TMS_RUNE_SH_TELEPORT..tms_ButtonColor(tms_RuneTeleport(), TMS_RUNE_TELEPORT).." "..TMS_RUNE_SH_PORTAL..tms_ButtonColor(tms_RunePortal(), TMS_RUNE_PORTAL).." "..TMS_LIGHT_SH_FEATHER..tms_ButtonColor(tms_LightFeather(),TMS_LIGHT_FEATHER);
	   else
            tms_buttonText = tms_ButtonColor(tms_GetPowder(),TMS_ARCANE_POWDER).."/"..tms_ButtonColor(tms_RuneTeleport(), TMS_RUNE_TELEPORT).."/"..tms_ButtonColor(tms_RunePortal(), TMS_RUNE_PORTAL).."/"..tms_ButtonColor(tms_LightFeather(),TMS_LIGHT_FEATHER);
	   end
	elseif (UnitClass("player") == TITAN_BUFFREAGENT_CLASS_PRIEST) then
		 if (TitanGetVar(TITAN_BUFFREAGENT_ID, "MonitorCaption") == 1) then
            tms_buttonText = TMS_HOLY_SH_CANDLE..tms_ButtonColor(tms_GetCandle(),TMS_HOLY_CANDLE).." "..TMS_LIGHT_SH_FEATHER..tms_ButtonColor(tms_LightFeather(),TMS_LIGHT_FEATHER);
        else
            tms_buttonText = tms_ButtonColor(tms_GetCandle(),TMS_HOLY_CANDLE).."/"..tms_ButtonColor(tms_LightFeather(),TMS_LIGHT_FEATHER);
        end
	elseif (UnitClass("player") == TITAN_BUFFREAGENT_CLASS_ROGUE) then
	   local poisons = 0;
	   local poisons = tms_GetPoisonInstant() + tms_GetPoisonDeadly() + tms_GetPoisonCrippling() + tms_GetPoisonMindnumb() + tms_GetPoisonWound();
		if (TitanGetVar(TITAN_BUFFREAGENT_ID, "MonitorCaption") == 1) then
            tms_buttonText = TMS_ROGUE_SH_POWDER..tms_ButtonColor(tms_GetRoguePowder(),TMS_ROGUE_POWDER).." "..TMS_ROGUE_SH_BLIND..tms_ButtonColor(tms_GetRogueBlind(),TMS_ROGUE_BLIND).." "..TMS_ROGUE_SH_THISTLE..tms_ButtonColor(tms_GetRogueThistle(),TMS_ROGUE_THISTLE).." "..TMS_ROGUE_SH_POISON..tms_ButtonColor(poisons, TMS_ROGUE_POISON);
        else
            tms_buttonText = tms_ButtonColor(tms_GetRoguePowder(),TMS_ROGUE_POWDER).."/"..tms_ButtonColor(tms_GetRogueBlind(),TMS_ROGUE_BLIND).."/"..tms_ButtonColor(tms_GetRogueThistle(),TMS_ROGUE_THISTLE).."/"..tms_ButtonColor(poisons, TMS_ROGUE_POISON);
        end
	elseif (UnitClass("player") == TITAN_BUFFREAGENT_CLASS_PALA) then
	if (TitanGetVar(TITAN_BUFFREAGENT_ID, "MonitorCaption") == 1) then
		  tms_buttonText = TMS_PALA_SH_SYMBOL..tms_ButtonColor(tms_GetSymbol(),TMS_PALA_SYMBOL).." "..TMS_PALA_SH_KING..tms_ButtonColor(tms_GetPalaKing(),TMS_PALA_KING);
		else
		  tms_buttonText = tms_ButtonColor(tms_GetSymbol(),TMS_PALA_SYMBOL).."/"..tms_ButtonColor(tms_GetPalaKing(),TMS_PALA_KING);
		end
	elseif (UnitClass("player") == TITAN_BUFFREAGENT_CLASS_SHAMAN) then
		if (TitanGetVar(TITAN_BUFFREAGENT_ID, "MonitorCaption") == 1) then
          tms_buttonText = TMS_SHAMAN_SH_ANKH..tms_ButtonColor(tms_GetAnkh(),TMS_SHAMAN_ANKH).." "..TMS_SHAMAN_SH_FISHSCALES..tms_ButtonColor(tms_GetFishPiec(),TMS_SHAMAN_FISHSCALES).." "..TMS_SHAMAN_SH_FISHOIL..tms_ButtonColor(tms_GetFishOil(),TMS_SHAMAN_FISHOIL);
		else
		  tms_buttonText = tms_ButtonColor(tms_GetAnkh(),TMS_SHAMAN_ANKH).."/"..tms_ButtonColor(tms_GetFishPiec(),TMS_SHAMAN_FISHSCALES).."/"..tms_ButtonColor(tms_GetFishOil(),TMS_SHAMAN_FISHOIL);
		end
	elseif (UnitClass("player") == TITAN_BUFFREAGENT_CLASS_DRUID) then
		if (TitanGetVar(TITAN_BUFFREAGENT_ID, "MonitorCaption") == 1) then
            tms_buttonText = TMS_DRUID_SH_BERRY..tms_ButtonColor(tms_GetBerry(),TMS_DRUID_BERRY).." "..TMS_DRUID_SH_SEMEN..tms_ButtonColor(tms_GetSemen(),TMS_DRUID_SEMEN);
		else
		  tms_buttonText = tms_ButtonColor(tms_GetBerry(),TMS_DRUID_BERRY).."/"..tms_ButtonColor(tms_GetSemen(),TMS_DRUID_SEMEN);
		end
	elseif (UnitClass("player") == TITAN_BUFFREAGENT_CLASS_WARLOCK) then
		if (TitanGetVar(TITAN_BUFFREAGENT_ID, "MonitorCaption") == 1) then
            tms_buttonText = TMS_WARLOCK_SOULSHARD..": "..tms_ButtonColor(tms_GetSShard(),TMS_WARLOCK_SOULSHARD);
		else
		  tms_buttonText = tms_ButtonColor(tms_GetSShard(),TMS_WARLOCK_SOULSHARD);
		end
	else
	    tms_buttonText = tms_COLOR(TITAN_BUFFREAGENT_NA);
    end
    if (tms_CustomText1) then
        if (TitanGetVar(TITAN_BUFFREAGENT_ID, "MonitorCaption") == 1) then
            tms_buttonText = tms_buttonText.." ".."Custom 1: "..tms_ButtonColor(tms_GetCustom1(),"no");
        else
            tms_buttonText = tms_buttonText.."/"..tms_ButtonColor(tms_GetCustom1(),"no");
        end
    end
    if (tms_CustomText2) then
        if (TitanGetVar(TITAN_BUFFREAGENT_ID, "MonitorCaption") == 1) then
            tms_buttonText = tms_buttonText.." ".."Custom 2: "..tms_ButtonColor(tms_GetCustom2(),"no");
        else
            tms_buttonText = tms_buttonText.."/"..tms_ButtonColor(tms_GetCustom2(),"no");
        end
    end
	return TITAN_BUFFREAGENT_BUTTON_LABEL, tms_buttonText;
end

--------------------------------------------------------------------------------------------------
-- BuffReagent Menu
--------------------------------------------------------------------------------------------------

function TitanPanelRightClickMenu_PrepareBuffReagentMenu()
	tms_DEBUG("Preparing "..TITAN_BUFFREAGENT_ID.." menu ...");
	local id = TITAN_BUFFREAGENT_ID;
	if (UIDROPDOWNMENU_MENU_LEVEL == 1) then
	TitanPanelRightClickMenu_AddTitle(TitanPlugins[id].menuText..TITAN_BUFFREAGENT_VERSION);
	TitanPanelRightClickMenu_AddToggleIcon(id);
	TitanPanelRightClickMenu_AddToggleLabelText(id);
	info = {};
		info.text = TITAN_BUFFREAGENT_MENU_CAPTION;
		info.func = TitanPanelBuffReagent_ToggleShowCaption;
		info.checked = TitanGetVar(TITAN_BUFFREAGENT_ID, "MonitorCaption");
		UIDropDownMenu_AddButton(info);
	TitanPanelRightClickMenu_AddSpacer();
	
	-- menu Set RedStatus
		info = {};
		info.text = TITAN_BUFFREAGENT_MENU_RED;
		info.hasArrow = 1;
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	-- reset text
        local info = {};
	    info.text = TITAN_BUFFREAGENT_MENU_WARNINGS;
	    info.func = TitanPanelBuffReagent_ToggleShowWarnings;
	    info.checked = TitanGetVar(TITAN_BUFFREAGENT_ID, "ShowWarnings");
	    UIDropDownMenu_AddButton(info);
		
	TitanPanelRightClickMenu_AddSpacer();
	TitanPanelRightClickMenu_AddTitle(TITAN_BUFFREAGENT_MENU_CREAGENTS); -- Title for the Custom Menu
	
	if (tms_CustomText1 ~= nil) then
	TITAN_BUFFREAGENT_MENU_CUSTOM1A = tms_CustomText1;
	else
	TITAN_BUFFREAGENT_MENU_CUSTOM1A = TITAN_BUFFREAGENT_MENU_CUSTOM1;
	end
	
	if (tms_CustomText2 ~= nil) then
	TITAN_BUFFREAGENT_MENU_CUSTOM2A = tms_CustomText2;
	else
	TITAN_BUFFREAGENT_MENU_CUSTOM2A = TITAN_BUFFREAGENT_MENU_CUSTOM2;
	end
	-- menu for the custom reagents
	info = {};
		info.text = TITAN_BUFFREAGENT_MENU_CUSTOM1A;
		info.func = TitanPanelBuffReagent_ShowInsert1;
		UIDropDownMenu_AddButton(info);
	info = {};
		info.text = TITAN_BUFFREAGENT_MENU_CUSTOM2A;
		info.func = TitanPanelBuffReagent_ShowInsert2;
		UIDropDownMenu_AddButton(info);
	info = {};
		info.text = TITAN_BUFFREAGENT_MENU_RESET2;
		info.func = TitanPanelBuffReagent_DeleteCustom;
		UIDropDownMenu_AddButton(info);
	
    TitanPanelRightClickMenu_AddSpacer(); -- spacer
    
    -- reset text
    local info = {};
	info.text = TITAN_BUFFREAGENT_MENU_RESET;
	info.func = tms_Reset;
	UIDropDownMenu_AddButton(info);
	TitanPanelRightClickMenu_AddSpacer();
	TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, id, TITAN_PANEL_MENU_FUNC_HIDE);
	tms_DEBUG("Preparing done !");
	elseif (UIDROPDOWNMENU_MENU_LEVEL == 2) then
		if (UIDROPDOWNMENU_MENU_VALUE == TITAN_BUFFREAGENT_MENU_RED) then -- set menu		
		        UIDropDownMenu_AddButton ({text=TITAN_BUFFREAGENTS_RED_4, func=TitanPaneBuffReagent_SetRedStatus, checked = TitanPaneBuffReagent_CheckStatus(5), value=5}, UIDROPDOWNMENU_MENU_LEVEL);
				UIDropDownMenu_AddButton ({text=TITAN_BUFFREAGENTS_RED_5, func=TitanPaneBuffReagent_SetRedStatus, checked = TitanPaneBuffReagent_CheckStatus(6), value=6}, UIDROPDOWNMENU_MENU_LEVEL);
				UIDropDownMenu_AddButton ({text=TITAN_BUFFREAGENTS_RED_6, func=TitanPaneBuffReagent_SetRedStatus, checked = TitanPaneBuffReagent_CheckStatus(7), value=7}, UIDROPDOWNMENU_MENU_LEVEL);
		        UIDropDownMenu_AddButton ({text=TITAN_BUFFREAGENTS_RED_7, func=TitanPaneBuffReagent_SetRedStatus, checked = TitanPaneBuffReagent_CheckStatus(8), value=8}, UIDROPDOWNMENU_MENU_LEVEL);
                UIDropDownMenu_AddButton ({text=TITAN_BUFFREAGENTS_RED_8, func=TitanPaneBuffReagent_SetRedStatus, checked = TitanPaneBuffReagent_CheckStatus(9), value=9}, UIDROPDOWNMENU_MENU_LEVEL);
                UIDropDownMenu_AddButton ({text=TITAN_BUFFREAGENTS_RED_10, func=TitanPaneBuffReagent_SetRedStatus, checked = TitanPaneBuffReagent_CheckStatus(11), value=11}, UIDROPDOWNMENU_MENU_LEVEL);
        end
	end
	
end

-- the reagent numbers-red menu
function TitanPaneBuffReagent_SetRedStatus()
tms_RedStatus = this.value;
TitanPanelButton_UpdateButton(TITAN_BUFFREAGENT_ID); -- force the update!
end

-- check in the submenu which one is checked.
function TitanPaneBuffReagent_CheckStatus(msg)
areturn = false

	if msg==tms_RedStatus then 
		areturn=true;
	end;	

return areturn
end;

-- show the warnings if low reagents in big cities
function TitanPanelBuffReagent_ToggleShowWarnings()
	TitanToggleVar(TITAN_BUFFREAGENT_ID, "ShowWarnings");
	--TitanPanelButton_UpdateButton(TITAN_BUFFREAGENT_ID); -- force the update!
end

-- show the shortnames of the reagents in the titan bar
function TitanPanelBuffReagent_ToggleShowCaption()
	TitanToggleVar(TITAN_BUFFREAGENT_ID, "MonitorCaption");
	TitanPanelButton_UpdateButton(TITAN_BUFFREAGENT_ID); -- force the update!
end

-- show the insert frame for custom reagent 1
function TitanPanelBuffReagent_ShowInsert1()
    TITAN_BUFFREAGENT_CUSTOMTHING_N = "tms_CustomText1";
    BRGInsertFrameEditBox:SetText("");
    if (tms_CustomText1) then
    BRGInsertFrameEditBox:SetText(tms_CustomText1);
    end
    BRGInsertFrame:Show()
end

-- show the insert frame for custom reagent 2
function TitanPanelBuffReagent_ShowInsert2()
    TITAN_BUFFREAGENT_CUSTOMTHING_N = "tms_CustomText2";
    BRGInsertFrameEditBox:SetText("");
    if (tms_CustomText2) then
    BRGInsertFrameEditBox:SetText(tms_CustomText2);
    end
    BRGInsertFrame:Show()
end

-- delete all custom reagents
function TitanPanelBuffReagent_DeleteCustom()
    tms_CustomText1 = nil;
    tms_CustomText2 = nil;
    TITAN_BUFFREAGENT_MENU_CUSTOM1A = TITAN_BUFFREAGENT_MENU_CUSTOM1;
    TITAN_BUFFREAGENT_MENU_CUSTOM2A = TITAN_BUFFREAGENT_MENU_CUSTOM2;
    TitanPanelButton_UpdateButton(TITAN_BUFFREAGENT_ID); -- force the update!
end
--------------------------------------------------------------------------------------------------
-- Misc Help Functions
--------------------------------------------------------------------------------------------------

function tms_Msg(msg)
	if ( msg == nil ) then
		msg = "------------------------------";
	end
	if ( DEFAULT_CHAT_FRAME ) then
		DEFAULT_CHAT_FRAME:AddMessage(msg, 1.0, 0.82, 0);
	end
end

function tms_DEBUG(msg)
	if ( msg == nil or msg == false ) then
		msg = "nil";
	end
	if ( DEFAULT_CHAT_FRAME and TDC_DEBUG ) then
		DEFAULT_CHAT_FRAME:AddMessage(msg, 1.0, 0.22, 0);
	end
end

function tms_Round(num)
	if(num - math.floor(num) >= 0.5) then
		num = num + 0.5;
	end
	return math.floor(num);
end

--------------------------------------------------------------------------------------------------
-- Color, Buttoncolor Functions
--------------------------------------------------------------------------------------------------

function tms_COLOR(color, msg)
	if ( msg == nil ) then
		msg = color;
		color = TEXT_COLOR_GOLD;
	end
	return color..msg..FONT_COLOR_CODE_CLOSE;
end

function tms_ButtonColor(lalala, name)
	local r, g, b;
	if(tms_RedStatus and lalala < tms_RedStatus) then
		r = 1.0;
		g = 0;
		-- new shit for the warnings
		if (name and name ~= "no" and tms_isCowTown() and looping>400 and TitanGetVar(TITAN_BUFFREAGENT_ID, "ShowWarnings") == 1) then
		TitanPanelBuffReagent_WarningFrame:AddMessage(TITAN_BUFFREAGENT_LOW.." "..name, 1.0, 0, 0, 1.0, 1);		
		tms_playsound();
		DEFAULT_CHAT_FRAME:AddMessage(TITAN_BUFFREAGENT_LOW.." "..name, 1.0, 0, 0, 1.0, 1);
		looping=0
	end
	looping=looping+1
		
	else
	    r = 0;
		g = 1.0;
	end
	b = 0;
	local rcode = format("%02x", r * 255);
	local gcode = format("%02x", g * 255);
	local bcode = format("%02x", b * 255);
	local colorcode = "|cff"..rcode..gcode..bcode;
	local returnvalue = colorcode..format(TITAN_BUFFREAGENT_BUTTON_TEXT ,lalala).."|r";
	tms_DEBUG("tms_ButtonColor = "..returnvalue);
	return returnvalue;
end

function tms_ButtonColor_yesno(lalazu)
	local r, g, b;
	if(lalazu == 1) then
		r = 0;
		g = 1.0;
		lalazu = TITAN_BUFFREAGENT_YES;
	else
	    r = 1.0;
		g = 0;
		lalazu = TITAN_BUFFREAGENT_NO;
	end
	b = 0;
	local rcode = format("%02x", r * 255);
	local gcode = format("%02x", g * 255);
	local bcode = format("%02x", b * 255);
	local colorcode = "|cff"..rcode..gcode..bcode;
	local returnvalue = colorcode..format(TITAN_BUFFREAGENT_BUTTON_TEXT ,lalazu).."|r";
	tms_DEBUG("tms_ButtonColor = "..returnvalue);
	return returnvalue;
end

--------------------------------------------------------------------------------------------------
-- Tooltip Function
--------------------------------------------------------------------------------------------------

function tms_getToolTip()
text = "";
	if (UnitClass("player") == TITAN_BUFFREAGENT_CLASS_MAGE) then
		local rank = tms_GetSpellRank(TMS_MAGE_SPELL);
	    local _, _, _, ranknumber = string.find( rank, "(.+) (.+)" );
	    text = text.."\n"..tms_COLOR(TMS_ARCANE_POWDER).."\t"..tms_ButtonColor(tms_GetPowder(),'').."\n";
	    text = text..tms_COLOR(TMS_RUNE_TELEPORT).."\t"..tms_ButtonColor(tms_RuneTeleport(),'').."\n";
	    text = text..tms_COLOR(TMS_RUNE_PORTAL).."\t"..tms_ButtonColor(tms_RunePortal(),'').."\n";
	    text = text..tms_COLOR(TMS_LIGHT_FEATHER).."\t"..tms_ButtonColor(tms_LightFeather(),'').."\n";
	elseif (UnitClass("player") == TITAN_BUFFREAGENT_CLASS_PRIEST) then
		local lolo = tms_ButtonColor(tms_GetCandle(),'');
        local rank = tms_GetSpellRank(TMS_PRIEST_SPELL);
	    local _, _, _, ranknumber = string.find( rank, "(.+) (.+)" );
		if (lolo and ranknumber and ranknumber == "1") then
	       text = text.."\n"..tms_COLOR(TMS_HOLY_CANDLE1).."\t"..lolo.."\n";
	    elseif (lolo and ranknumber and ranknumber == "2") then
	       text = text.."\n"..tms_COLOR(TMS_HOLY_CANDLE).."\t"..lolo.."\n";
	    else
	       text = text.."\n"..tms_COLOR(TMS_HOLY_CANDLE).."\t"..tms_ButtonColor(0).."\n";
	    end
	    text = text..tms_COLOR(TMS_LIGHT_FEATHER).."\t"..tms_ButtonColor(tms_LightFeather(),'').."\n";
	elseif (UnitClass("player") == TITAN_BUFFREAGENT_CLASS_DRUID) then
		local lolo = tms_ButtonColor(tms_GetBerry(),TMS_DRUID_WILDBERRY);
		local lele = tms_ButtonColor(tms_GetSemen(),TMS_DRUID_SEMEN1);
		local rank = tms_GetSpellRank(TMS_DRUID_SPELL1);
		local _, _, _, ranknumber = string.find( rank, "(.+) (.+)" );
		local rank2 = tms_GetSpellRank(TMS_DRUID_SPELL2);
		local _, _, _, ranknumber2 = string.find( rank2, "(.+) (.+)" );
		if (ranknumber and ranknumber == "1") then
	       text = text.."\n"..tms_COLOR(TMS_DRUID_WILDBERRY).."\t"..lolo.."\n";
	    elseif (ranknumber and ranknumber == "2") then
	       text = text.."\n"..tms_COLOR(TMS_DRUID_DORN).."\t"..lolo.."\n";
	    else
	       text = text.."\n"..tms_COLOR(TMS_DRUID_DORN).."\t"..tms_ButtonColor(0).."\n";
	    end
	    if (ranknumber2 and ranknumber2 == "1") then
	       text = text..tms_COLOR(TMS_DRUID_SEMEN1).."\t"..lele.."\n";
	    elseif (ranknumber2 and ranknumber2 == "2") then
	       text = text..tms_COLOR(TMS_DRUID_SEMEN2).."\t"..lele.."\n";
	    elseif (ranknumber2 and ranknumber2 == "3") then
	       text = text..tms_COLOR(TMS_DRUID_SEMEN3).."\t"..lele.."\n";
	    elseif (ranknumber2 and ranknumber2 == "4") then
	       text = text..tms_COLOR(TMS_DRUID_SEMEN4).."\t"..lele.."\n";
	    elseif (ranknumber2 and ranknumber2 == "5") then
	       text = text..tms_COLOR(TMS_DRUID_SEMEN5).."\t"..lele.."\n";
	    else
	       text = text..tms_COLOR(TMS_DRUID_SEMEN1).."\t"..tms_ButtonColor(0).."\n";
	    end
	elseif (UnitClass("player") == TITAN_BUFFREAGENT_CLASS_ROGUE) then
	    text = text.."\n"..tms_COLOR(TMS_ROGUE_POWDER).."\t"..tms_ButtonColor(tms_GetRoguePowder()).."\n";
	    text = text..tms_COLOR(TMS_ROGUE_BLIND).."\t"..tms_ButtonColor(tms_GetRogueBlind()).."\n";
	    text = text..tms_COLOR(TMS_ROGUE_THISTLE).."\t"..tms_ButtonColor(tms_GetRogueThistle()).."\n";
	    text = text..tms_COLOR(TMS_ROGUE_INSTANT).."\t"..tms_ButtonColor(tms_GetPoisonInstant()).."\n";
	    text = text..tms_COLOR(TMS_ROGUE_DEADLY).."\t"..tms_ButtonColor(tms_GetPoisonDeadly()).."\n";
	    text = text..tms_COLOR(TMS_ROGUE_CRIPPLING).."\t"..tms_ButtonColor(tms_GetPoisonCrippling()).."\n";
	    text = text..tms_COLOR(TMS_ROGUE_MINDNUMB).."\t"..tms_ButtonColor(tms_GetPoisonMindnumb()).."\n";
	    text = text..tms_COLOR(TMS_ROGUE_WOUND).."\t"..tms_ButtonColor(tms_GetPoisonWound()).."\n";
	elseif (UnitClass("player") == TITAN_BUFFREAGENT_CLASS_PALA) then
	    text = text.."\n"..tms_COLOR(TMS_PALA_SYMBOL).."\t"..tms_GetSymbol().."\n";
	    text = text.."\n"..tms_COLOR(TMS_PALA_KING).."\t"..tms_GetPalaKing().."\n";
	elseif (UnitClass("player") == TITAN_BUFFREAGENT_CLASS_SHAMAN) then
	    text = text.."\n"..tms_COLOR(TMS_SHAMAN_ANKH).."\t"..tms_ButtonColor(tms_GetAnkh()).."\n";
        text = text..tms_COLOR(TMS_SHAMAN_FISHSCALES).."\t"..tms_ButtonColor(tms_GetFishPiec()).."\n";
	    text = text..tms_COLOR(TMS_SHAMAN_FISHOIL).."\t"..tms_ButtonColor(tms_GetFishOil()).."\n";
	elseif (UnitClass("player") == TITAN_BUFFREAGENT_CLASS_WARLOCK) then
	    text = text.."\n"..tms_COLOR(TMS_WARLOCK_SOULSHARD).."\t"..tms_ButtonColor(tms_GetSShard()).."\n";
	    text = text..tms_COLOR(TMS_WARLOCK_SOUL).."\t"..tms_ButtonColor_yesno(tms_GetSoulStone()).."\n";
        text = text..tms_COLOR(TMS_WARLOCK_HEALTH).."\t"..tms_ButtonColor_yesno(tms_GetHealthStone()).."\n";
        text = text..tms_COLOR(TMS_WARLOCK_SPELL).."\t"..tms_ButtonColor_yesno(tms_GetSpellStone()).."\n";
        text = text..tms_COLOR(TMS_WARLOCK_FIRE).."\t"..tms_ButtonColor_yesno(tms_GetFireStone()).."\n";
    else
	    text = text.."\n"..tms_COLOR(TITAN_BUFFREAGENT_TOOLTIP_ERROR).."\n";
    end
    if (tms_CustomText1) then
    text = text..tms_COLOR(tms_CustomText1).."\t"..tms_ButtonColor(tms_GetCustom1()).."\n";
    end
    if (tms_CustomText2) then
    text = text..tms_COLOR(tms_CustomText2).."\t"..tms_ButtonColor(tms_GetCustom2()).."\n";
    end
    
	return text;
end

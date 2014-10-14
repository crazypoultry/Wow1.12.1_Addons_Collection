local GREY = "|cff999999";
local RED = "|cffff0000";
local WHITE = "|cffFFFFFF";
local GREEN = "|cff1eff00";
local PURPLE = "|cff9F3FFF";
local BLUE = "|cff0070dd";
local ORANGE = "|cffFF8400";
local DEFAULT = "|cffFFd200";
local ParseTooltip_Enabled = false;

--------------------------------------------------------------------------------
-- Item OnEnter
-- Called when a loot item is moused over
--------------------------------------------------------------------------------
function AtlasLootItem_OnEnter()
    AtlasLootTooltip:ClearLines();
    for i=1, 30, 1 do
        getglobal("AtlasLootTooltipTextRight"..i):SetText("");
    end
    if (this.itemID ~= 0) then
        local yOffset;
        local color = strsub(getglobal("AtlasLootItem_"..this:GetID().."_Name"):GetText(), 3, 10);
        local name = strsub(getglobal("AtlasLootItem_"..this:GetID().."_Name"):GetText(), 11);
        if(this.itemID ~= 0 and this.itemID ~= "" and this.itemID ~= nil and AtlasLootDKPValues and AtlasLootClassPriority) then
            Identifier = "Item"..this.itemID;
            DKP = AtlasLootDKPValues[Identifier];
            priority = AtlasLootClassPriority[Identifier];
        else
            DKP = nil;
            priority = nil;
        end
        --Lootlink tooltips
        if( AtlasLootOptions.LootlinkTT ) then
            --If we have seen the item, use the game tooltip to minimise same name item problems
            if(GetItemInfo(this.itemID) ~= nil) then
                AtlasLootTooltip:SetOwner(this, "ANCHOR_RIGHT", -(this:GetWidth() / 2), 24);
                AtlasLootTooltip:SetHyperlink("item:"..this.itemID..":0:0:0");
                if ( AtlasLootOptions.ItemIDs ) then
                    AtlasLootTooltip:AddLine(BLUE..ATLASLOOT_ERRORTOOLTIP_L2.." "..this.itemID, nil, nil, nil, 1);
                end
                if( this.droprate ~= nil) then
                    AtlasLootTooltip:AddLine(ATLASLOOT_DROP_RATE..this.droprate, 1, 1, 0);
                end
                if( DKP ~= nil and DKP ~= "" ) then
                    AtlasLootTooltip:AddLine(RED..DKP.." "..ATLASLOOT_DKP, 1, 1, 0, 1);
                end
                if( priority ~= nil and priority ~= "" ) then
                    AtlasLootTooltip:AddLine(GREEN..ATLASLOOT_PRIORITY.." "..priority, 1, 1, 0, 1);
                end
                AtlasLootTooltip:Show();
                if (LootLink_AddItem) then
                    LootLink_AddItem(name, this.itemID..":0:0:0", color);
                end
            else
                AtlasLootTooltip:SetOwner(this, "ANCHOR_RIGHT", -(this:GetWidth() / 2), 24);
                LootLink_SetTooltip(AtlasLootTooltip, strsub(getglobal("AtlasLootItem_"..this:GetID().."_Name"):GetText(), 11), 1);
                if ( AtlasLootOptions.ItemIDs ) then
                    AtlasLootTooltip:AddLine(BLUE..ATLASLOOT_ERRORTOOLTIP_L2.." "..this.itemID, nil, nil, nil, 1);
                end
                if( this.droprate ~= nil) then
                    AtlasLootTooltip:AddLine(ATLASLOOT_DROP_RATE..this.droprate, 1, 1, 0, 1);
                end
                if( DKP ~= nil and DKP ~= "" ) then
                    AtlasLootTooltip:AddLine(RED..DKP.." "..ATLASLOOT_DKP, 1, 1, 0);
                end
                if( priority ~= nil and priority ~= "" ) then
                    AtlasLootTooltip:AddLine(GREEN..ATLASLOOT_PRIORITY.." "..priority, 1, 1, 0);
                end
                AtlasLootTooltip:AddLine(" ");
                AtlasLootTooltip:AddLine(ATLASLOOT_ERRORTOOLTIP_L4, nil, nil, nil, 1);
                if(AtlasLootTooltipTextLeft1==" " and AtlasLootTooltipDB[this.itemID]) then
                    AtlasLoot_GenerateTooltip(AtlasLootTooltipDB[this.itemID]);
                else
                    AtlasLootTooltip:Show();
                end
            end
        --Item Sync tooltips
        elseif( AtlasLootOptions.ItemSyncTT ) then
            ISync:ButtonEnter();
            if ( AtlasLootOptions.ItemIDs ) then
                GameTooltip:AddLine(BLUE..ATLASLOOT_ERRORTOOLTIP_L2.." "..this.itemID, nil, nil, nil, 1);
            end
            if( this.droprate ~= nil) then
                GameTooltip:AddLine(ATLASLOOT_DROP_RATE..this.droprate, 1, 1, 0);
            end
            if( DKP ~= nil and DKP ~= "" ) then
                GameTooltip:AddLine(RED..DKP.." "..ATLASLOOT_DKP, 1, 1, 0);
            end 
            if( priority ~= nil and priority ~= "" ) then
                GameTooltip:AddLine(GREEN..ATLASLOOT_PRIORITY.." "..priority, 1, 1, 0);
            end
            if(GetItemInfo(this.itemID) ~= nil) then
                GameTooltip:AddLine(" ");
                GameTooltip:AddLine(ATLASLOOT_ERRORTOOLTIP_L4, nil, nil, nil, 1);
            end
            GameTooltip:Show();
        --Default game tooltips
        else
            if(this.itemID ~= nil) then
                if(GetItemInfo(this.itemID) ~= nil) then
                    AtlasLootTooltip:SetOwner(this, "ANCHOR_RIGHT", -(this:GetWidth() / 2), 24);
                    AtlasLootTooltip:SetHyperlink("item:"..this.itemID..":0:0:0");
                    if ( AtlasLootOptions.ItemIDs ) then
                        AtlasLootTooltip:AddLine(BLUE..ATLASLOOT_ERRORTOOLTIP_L2.." "..this.itemID, nil, nil, nil, 1);
                    end
                    if( this.droprate ~= nil) then
                        AtlasLootTooltip:AddLine(ATLASLOOT_DROP_RATE..this.droprate, 1, 1, 0);
                    end
                    if( DKP ~= nil and DKP ~= "" ) then
                        AtlasLootTooltip:AddLine(RED..DKP.." "..ATLASLOOT_DKP, 1, 1, 0);
                    end
                    if( priority ~= nil and priority ~= "" ) then
                        AtlasLootTooltip:AddLine(GREEN..ATLASLOOT_PRIORITY.." "..priority, 1, 1, 0);
                    end
                    AtlasLootTooltip:Show();
                else
                    AtlasLootTooltip:SetOwner(this, "ANCHOR_RIGHT", -(this:GetWidth() / 2), 24);
                    if(AtlasLootTooltipDB[this.itemID]) then
                        AtlasLoot_GenerateTooltip(AtlasLootTooltipDB[this.itemID]);
                    else
                        AtlasLootTooltip:ClearLines();
                        AtlasLootTooltip:AddLine(RED..ATLASLOOT_ERRORTOOLTIP_L1, nil, nil, nil, 1);
                        AtlasLootTooltip:AddLine(BLUE..ATLASLOOT_ERRORTOOLTIP_L2.." "..this.itemID, nil, nil, nil, 1);
                        AtlasLootTooltip:AddLine(ATLASLOOT_ERRORTOOLTIP_L3, nil, nil, nil, 1);
                        AtlasLootTooltip:AddLine(" ");
                        AtlasLootTooltip:AddLine(ATLASLOOT_ERRORTOOLTIP_L4, nil, nil, nil, 1);
                        AtlasLootTooltip:Show();
                    end
                end
            end
        end
    else
        itemname=strsub(getglobal("AtlasLootItem_"..this:GetID().."_Name"):GetText(), 11);
        if(AtlasLootConstructedTooltips[itemname]) then
            AtlasLootTooltip:SetOwner(this, "ANCHOR_RIGHT", -(this:GetWidth() / 2), 24);
            AtlasLoot_GenerateTooltip(AtlasLootConstructedTooltips[itemname]);
        end            
    end
end

--------------------------------------------------------------------------------
-- Item OnLeave
-- Called when the mouse cursor leaves a loot item
--------------------------------------------------------------------------------
function AtlasLootItem_OnLeave()
    --Hide the necessary tooltips
    if( AtlasLootOptions.LootlinkTT ) then
        AtlasLootTooltip:Hide();
    elseif( AtlasLootOptions.ItemSyncTT ) then
        if(GameTooltip:IsVisible()) then
            GameTooltip:Hide();
        end
    else
        if(this.itemID ~= nil) then
		    AtlasLootTooltip:Hide();
            GameTooltip:Hide();
	    end
    end
end

--------------------------------------------------------------------------------
-- Item OnClick
-- Called when a loot item is clicked on
--------------------------------------------------------------------------------
function AtlasLootItem_OnClick(arg1)
	local color = strsub(getglobal("AtlasLootItem_"..this:GetID().."_Name"):GetText(), 1, 10);
	local id = this:GetID();
	local name = strsub(getglobal("AtlasLootItem_"..this:GetID().."_Name"):GetText(), 11);
	local iteminfo = GetItemInfo(this.itemID);
    local itemName, itemLink, itemQuality, itemLevel, itemType, itemSubType, itemCount, itemEquipLoc, itemTexture = GetItemInfo(this.itemID);
    --If shift-clicked, link in the chat window
    if(arg1=="RightButton" and not iteminfo and this.itemID ~= 0) then
        AtlasLootTooltip:SetHyperlink("item:"..this.itemID..":0:0:0");
        DEFAULT_CHAT_FRAME:AddMessage(ATLASLOOT_QUERY_MESSAGE..color.."["..name.."]".."|r"..ATLASLOOT_RECLICK_MESSAGE);
    elseif(arg1=="RightButton" and iteminfo) then
        DEFAULT_CHAT_FRAME:AddMessage(color.."|Hitem:"..this.itemID..":0:0:0|h["..name.."]|h|r"..ATLASLOOT_SAFE_MESSAGE);
	elseif(ChatFrameEditBox:IsVisible() and IsShiftKeyDown() and iteminfo and (AtlasLootOptions.SafeLinks or AtlasLootOptions.AllLinks)) then
    	ChatFrameEditBox:Insert(color.."|Hitem:"..this.itemID..":0:0:0|h["..name.."]|h|r");
        --ChatFrameEditBox:Insert(itemLink);
	elseif(ChatFrameEditBox:IsVisible() and IsShiftKeyDown() and AtlasLootOptions.AllLinks) then
		ChatFrameEditBox:Insert(color.."|Hitem:"..this.itemID..":0:0:0|h["..name.."]|h|r");
    elseif(ChatFrameEditBox:IsVisible()) then
		ChatFrameEditBox:Insert(name);
    --If control-clicked, use the dressing room
    elseif(IsControlKeyDown() and iteminfo) then
        DressUpItemLink(this.itemID);
    elseif(IsAltKeyDown() and iteminfo and ParseTooltip_Enabled) then
        AtlasLoot_ParseTooltip(this.itemID);
	end
end

function AtlasLoot_ParseTooltip(IDno)
    if(AtlasLootSavedTooltips[IDno]) then 
        return; 
    else
        AtlasLootSavedTooltips[IDno]={};
    end
    AtlasLootTooltip:ClearLines();
    AtlasLootTooltip:SetHyperlink("item:"..IDno..":0:0:0");
    line=0;
    for index = 1, 30, 1 do
        line=line+1;
        r,g,b,_ = getglobal("AtlasLootTooltipTextLeft"..index):GetTextColor();
        if(line==1) then
            _, _, quality, _, _, _, _, _, _ = GetItemInfo(IDno);
            _, _, _, colour = GetItemQualityColor(quality);
        else
            colour = AtlasLoot_CheckColour(r, g, b);
        end
        text=getglobal("AtlasLootTooltipTextLeft"..index):GetText();
        if(text==nil or text=="\n" or text==" \n") then
            return;
        else
            AtlasLootSavedTooltips[IDno][line]=colour..text;
        end
        line=line+1;
        r,g,b,_ = getglobal("AtlasLootTooltipTextRight"..index):GetTextColor();
        colour = AtlasLoot_CheckColour(r, g, b);
        text=getglobal("AtlasLootTooltipTextRight"..index):GetText();
        if(text==nil) then
            AtlasLootSavedTooltips[IDno][line] = "";
        else
            AtlasLootSavedTooltips[IDno][line]=colour..text;
        end
    end
end

function AtlasLoot_CheckColour(r, g, b)
    if( r==0.5019596815109253 and g==0.5019596815109253 and b==0.5019596815109253 ) then
        return GREY;
    elseif( r==0.9999978030100465 and g==0.8235275745391846 and b==0 ) then
        return DEFAULT;
    elseif( r==0.9999978030100465 and g==0.1254899203777313 and b==0.1254899203777313 ) then
        return RED;
    elseif( r==0.9999978030100465 and g==0.9999977946281433 and b==0.9999977946281433) then
        return WHITE;
    elseif( r==0.6392142819240689 and g==0.2078426778316498 and b==0.933331310749054 ) then
        return PURPLE;
    elseif( r==0.63921428192407 and g==0.20784267783165 and b==0.93333131074905 ) then
        return PURPLE;
    elseif( r==0 and g==0.9999977946281433 and b==0) then
        return GREEN;
    elseif( r==0.1176468003541231 and g==0.9999977946281433 and b==0) then
        return GREEN;
    elseif( r==0 and g==0.4392147064208984 and b==0.8666647672653198 ) then
        return BLUE;
    elseif( r==0.9999978030100465 and g==0.5019596815109253 and b==0) then
        return ORANGE;
    else
        return WHITE;
    end
end

function AtlasLoot_GenerateTooltip(tooltip)
    AtlasLootTooltip:ClearLines();
    curline=1;
    increment=false;
    local i=1;
    for i,v in ipairs(tooltip) do
        if(increment==false) then
            AtlasLootTooltip:AddLine(v, nil, nil, nil, 1);
            increment=true;
        else
            getglobal("AtlasLootTooltipTextRight"..curline):SetText(v);
            getglobal("AtlasLootTooltipTextRight"..curline):Show();
            increment=false;
            curline=curline+1;
        end
    end
    AtlasLootTooltip:AddLine(" ");
    AtlasLootTooltip:AddLine(RED..ATLASLOOT_ERRORTOOLTIP_L1, nil, nil, nil, 1);
    AtlasLootTooltip:AddLine(ATLASLOOT_ERRORTOOLTIP_L4, nil, nil, nil, 1);
    AtlasLootTooltip:Show();
end
    

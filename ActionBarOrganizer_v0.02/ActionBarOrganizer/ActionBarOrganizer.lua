-- ActionBarOrganizer by jascha@ja-s.de

ABO_CONF = {}

function ABO_OnUpdate(elapsed)

end

function ABO_AllUpdate()
    for i=1, 10 do
        for j=1, 12 do
            local button = ABO_GetButton(i, j);
            ABO_Update(button);
        end
    end
end

function ABO_Update(button)
    if (not button) then
        return nil;
    end
    local id = ABO_GetId(button);
    -- abim(button:GetName());
    local icon = getglobal(button:GetName().."Icon");
    -- local buttonCooldown = getglobal(button:GetName().."Cooldown");
    local texture = GetActionTexture(id);
    if ( texture ) then
        icon:SetTexture(texture);
        icon:Show();
        button:SetNormalTexture("Interface\\Buttons\\UI-Quickslot2");
    else
        icon:Hide();
        button.rangeTimer = nil;
        button:SetNormalTexture("Interface\\Buttons\\UI-Quickslot");
    end
    getglobal(button:GetName().."Name"):SetText(GetActionText(id));
    count = GetActionCount(id);
    if ( count ~= nil and IsConsumableAction(id)) then
        getglobal(button:GetName().."Count"):SetText(count);
    else
        getglobal(button:GetName().."Count"):SetText("");
    end
    if (not HasAction(id)) then
        --button:hide();
        button:SetButtonState("NORMAL");
        button:SetChecked(0);
        if (ABOSHOWGRID == 0) then
            button:Disable();
            button.showgrid = 1;
        end
        button:SetNormalTexture("Interface\\Buttons\\UI-Quickslot2");
        local flashTexture = getglobal(this:GetName().."Flash");
        if (flashTexture) then
            flashTexture:Hide();
        end
    else
        button:Enable();
        button.showgrid = 0;
    end
    local border = getglobal(button:GetName().."Border");
    if ( IsEquippedAction(id) ) then
        border:SetVertexColor(0, 1.0, 0, 0.35);
        border:Show();
    else
        border:Hide();
    end
    if ( GameTooltip:IsOwned(this) ) then
            ABO_SetTooltip(button);
    else
            this.updateTooltip = nil;
    end
end

function ABO_OnEvent(event)
    if ( (event == "ADDON_LOADED" and arg1 == "ActionBarOrganizer") or event == "VARIABLES_LOADED" ) then
            PanelTemplates_SetNumTabs(getglobal("ABOFrame"), 2);
            PanelTemplates_SetTab(getglobal("ABOFrame"), 1);
            abim("ActionBarOrganizer Loaded.");
    elseif (event == "ADDON_LOADED" and arg1 ~= "ActionBarOrganizer") then
        return nil;
    elseif ( event == "ACTIONBAR_SHOWGRID" ) then
            ABOSHOWGRID = 1;
            if (getglobal("ABOFrame"):IsVisible()) then
                ABO_AllUpdate();
            end
    elseif ( event == "ACTIONBAR_HIDEGRID" ) then
            ABOSHOWGRID = 0;
            if (getglobal("ABOFrame"):IsVisible()) then
                ABO_AllUpdate();
            end
    end
    -- ABO_AllUpdate();
end

function ABO_OnLoad()
    ABOSHOWGRID = 0;
    ABOROWTEMP = 0;
    ABOROWTEMP2 = 0;
    this:RegisterForDrag("LeftButton");
    this:RegisterEvent("ADDON_LOADED");
    this:RegisterEvent("VARIABLES_LOADED");
    this:RegisterEvent("ACTIONBAR_SHOWGRID");
    this:RegisterEvent("ACTIONBAR_HIDEGRID");
    this:RegisterEvent("ACTIONBAR_PAGE_CHANGED");
    this:RegisterEvent("ACTIONBAR_SLOT_CHANGED");
    this:RegisterEvent("ACTIONBAR_UPDATE_STATE");
    this:RegisterEvent("ACTIONBAR_UPDATE_USABLE");
    this:RegisterEvent("ACTIONBAR_UPDATE_COOLDOWN");
    tinsert(UISpecialFrames,"ABOFrame");
    SLASH_ABO1 = "/ActionBarOrganizer";
    SLASH_ABO2 = "/abo";
    SlashCmdList["ABO"] = function(msg)
        ABO_Slash(msg);
    end
end

function ABO_GetId(button)
    if (not button) then
        return nil;
    end
    if (string.len(button:GetID()) > 3) then
        _, _, row10, row, col10, col = string.find (button:GetID(), "(%d)(%d)(%d)(%d)");
        row = row10 * 10 + row;
    else
        _, _, row, col10, col = string.find (button:GetID(), "(%d)(%d)(%d)");
    end
    --[[if (row == nil or col10 == nil or col == nil) then
        return nil;
    end]]--
    col = col10 * 10 + col;
    offset = (row - 1) * 12;
    return (offset + col);
end

function ABO_Slash(command)
    local i,j, cmd, param = string.find(command, "^([^ ]+) (.+)$");
    if (not cmd) then cmd = command; end
    if (not cmd) then cmd = ""; end
    if (not param) then param = ""; end
    
    getglobal("ABOFrame"):Show();
    ABO_AllUpdate();
end

function abim(msg)
    DEFAULT_CHAT_FRAME:AddMessage(msg);
end

function ABOTab_OnClick(index)
	if ( not index ) then
		index = this:GetID();
	end
        PanelTemplates_SetTab(getglobal("ABOFrame"), index);
        getglobal("ABOFrameNormalBars"):Hide();
        getglobal("ABOFrameSpecialBars"):Hide();
        if (index == 1) then
            getglobal("ABOFrameNormalBars"):Show();
        elseif (index == 2) then
            getglobal("ABOFrameSpecialBars"):Show();
        end
end

function ABORow_OnClick(index)
	if ( not index ) then
		index = this:GetID();
	end
        if (ABOROWTEMP ~= 0) then
            for i=1, 12 do
                local id1 = ABO_GetId(ABO_GetButton(index, i));
                local id2 = ABO_GetId(ABO_GetButton(ABOROWTEMP, i));
                if (HasAction(id1) and HasAction(id2)) then
                    PickupAction(id1);
                    PlaceAction(id2);
                    PlaceAction(id1);
                elseif (HasAction(id1) and not HasAction(id2)) then
                    PickupAction(id1);
                    PlaceAction(id2);
                elseif (not HasAction(id1) and HasAction(id2)) then
                    PickupAction(id2);
                    PlaceAction(id1);
                end
            end
            getglobal("ABORow"..ABOROWTEMP):Enable();
            ABOROWTEMP = 0;
            getglobal("ABOFrameStatus"):Hide();
            getglobal("ABOCancleRow"):Hide();
            getglobal("ABOSwapRow"):Show();
        elseif (ABOROWTEMP2 ~= 0) then
            for i=1, 6 do
                local id1 = ABO_GetId(ABO_GetButton(index, i));
                local id2 = ABO_GetId(ABO_GetButton(index, (13 - i)));
                if (HasAction(id1) and HasAction(id2)) then
                    PickupAction(id1);
                    PlaceAction(id2);
                    PlaceAction(id1);
                elseif (HasAction(id1) and not HasAction(id2)) then
                    PickupAction(id1);
                    PlaceAction(id2);
                elseif (not HasAction(id1) and HasAction(id2)) then
                    PickupAction(id2);
                    PlaceAction(id1);
                end
            end
            ABOROWTEMP2 = 0;
            getglobal("ABOFrameStatus"):Hide();
            getglobal("ABOCancleRow"):Hide();
            getglobal("ABOSwapRow"):Show();
        else
            getglobal("ABOFrameStatusText"):SetText(ABO_SELECTROW);
            getglobal("ABOFrameStatus"):Show();
            getglobal("ABOCancleRow"):Show();
            getglobal("ABOSwapRow"):Hide();
            ABOROWTEMP = index;
            getglobal("ABORow"..index):Disable();
        end
end

function ABORow_Cancle()
        if (ABOROWTEMP ~= 0) then
            getglobal("ABORow"..ABOROWTEMP):Enable();
        end
        ABOROWTEMP = 0;
        ABOROWTEMP2 = 0;
        getglobal("ABOFrameStatus"):Hide();
        getglobal("ABOCancleRow"):Hide();
        getglobal("ABOSwapRow"):Show();
end

function ABORow_Swap()
        getglobal("ABOFrameStatusText"):SetText(ABO_SELECTROW2);
        getglobal("ABOFrameStatus"):Show();
        getglobal("ABOCancleRow"):Show();
        getglobal("ABOSwapRow"):Hide();
        ABOROWTEMP2 = 1;
end

function ABO_GetButton(row, col)
    if (row and col) then
        return getglobal(string.format ("ABOButton%d%02d", row, col));
    end
end

function ABO_SetTooltip(button)
    if (not button) then
            button = this;
    end
    if ( GetCVar("UberTooltips") == "1" ) then
            GameTooltip_SetDefaultAnchor(GameTooltip, this);
    else
            GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
    end
    
    if ( GameTooltip:SetAction(ABO_GetId(this)) ) then
            this.updateTooltip = TOOLTIP_UPDATE_TIME;
    else
            this.updateTooltip = nil;
    end
end
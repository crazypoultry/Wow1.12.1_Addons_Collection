function AtlasLootTypeDropDown_Init()
    local info;
	for i = 1, getn(AtlasLoot_LootTypes), 1 do
		info = {
			text = AtlasLoot_LootTypes[i];
			func = AtlasLootTypeDropDown_OnClick;
		};
		UIDropDownMenu_AddButton(info);
	end
end

function AtlasLootTypeDropDown_OnShow()
    UIDropDownMenu_Initialize(AtlasLootTypeDropDown, AtlasLootTypeDropDown_Init);
    if AtlasLootOptions["SelectedType"] == "" then
	UIDropDownMenu_SetSelectedID(AtlasLootTypeDropDown, 1);
    else
	UIDropDownMenu_SetSelectedID(AtlasLootTypeDropDown, AtlasLootOptions["SelectedType"]);
    end
    AtlasLootZoneDropDown_OnShow();
end

function AtlasLootTypeDropDown_OnClick()
    i = this:GetID();
    UIDropDownMenu_SetSelectedID(AtlasLootTypeDropDown, i);
    AtlasLootOptions["SelectedType"] = i;
    AtlasLootOptions["SelectedZone"] = 1;
     AtlasLootOptions["SelectedBoss"] = 1;
    AtlasLootZoneDropDown_OnShow();
end

function AtlasLootZoneDropDown_Init()
    local info;
    local index = AtlasLootOptions["SelectedType"];
    for i = 1, getn(AtlasLoot_Zones[index]), 1 do
        info = {
            text = AtlasLoot_Zones[index][i][1];
            func = AtlasLootZoneDropDown_OnClick;
        };
        UIDropDownMenu_AddButton(info);
    end
end

function AtlasLootZoneDropDown_OnShow()
    UIDropDownMenu_Initialize(AtlasLootZoneDropDown, AtlasLootZoneDropDown_Init);
    UIDropDownMenu_SetSelectedID(AtlasLootZoneDropDown, AtlasLootOptions["SelectedZone"]);
    UIDropDownMenu_SetWidth(170, AtlasLootZoneDropDown);
    local index1 = AtlasLootOptions["SelectedType"];
    local index2 = AtlasLootOptions["SelectedZone"];
    AtlasLootOptions["SelectedZoneText"] = AtlasLoot_Zones[index1][index2][1];
    AtlasLootBossDropDown_OnShow();
end

function AtlasLootZoneDropDown_OnClick()
    i = this:GetID();
    UIDropDownMenu_SetSelectedID(AtlasLootZoneDropDown, i);
    AtlasLootOptions["SelectedZone"] = i;
    AtlasLootOptions["SelectedZoneText"] = this:GetText();
    AtlasLootOptions["SelectedBoss"] = 1;
    AtlasLootBossDropDown_OnShow();
end

function AtlasLootBossDropDown_Init()
    local info;
    local index = AtlasLootOptions["SelectedZoneText"];
    if AtlasLoot_Bosses[index] then
        for i = 1, getn(AtlasLoot_Bosses[index]), 1 do
            info = {
                text = AtlasLoot_Bosses[index][i][1];
                func = AtlasLootBossDropDown_OnClick;
            };
            UIDropDownMenu_AddButton(info);
        end
    else
        info = {
            text = "-----";
            func = AtlasLootBossDropDown_OnClick;
        };
        UIDropDownMenu_AddButton(info);
    end
end

function AtlasLootBossDropDown_OnShow()
    UIDropDownMenu_Initialize(AtlasLootBossDropDown, AtlasLootBossDropDown_Init);
    UIDropDownMenu_SetSelectedID(AtlasLootBossDropDown, AtlasLootOptions["SelectedBoss"]);
    UIDropDownMenu_SetWidth(170, AtlasLootBossDropDown);
    AtlasLootDefaultFrame_SelectLootTable();
end

function AtlasLootBossDropDown_OnClick()
    i = this:GetID();
    UIDropDownMenu_SetSelectedID(AtlasLootBossDropDown, i);
    AtlasLootOptions["SelectedBoss"] = i;
    AtlasLootDefaultFrame_SelectLootTable();
end

function AtlasLootDefaultFrame_OnShow()
    if AtlasFrame then
        AtlasFrame:Hide();
    end
end

function AtlasLootDefaultFrame_OnHide()
    if AtlasFrame then
        AtlasLoot_SetupForAtlas();
    end
end

function AtlasLootDefaultFrame_SelectLootTable()
    pFrame = { "TOPLEFT", "AtlasLootDefaultFrame_LootBackground", "TOPLEFT", "2", "-2" };
    if AtlasLootOptions["SelectedType"] == 1 then
        local index = AtlasLootOptions["SelectedZoneText"];
        if AtlasLoot_Bosses[index] then
            local subindex = AtlasLootOptions["SelectedBoss"];
            AtlasLoot_ShowItemsFrame(AtlasLoot_Bosses[index][subindex][2], AtlasLootItems, AtlasLoot_Bosses[index][subindex][1], pFrame);
        end
    elseif AtlasLootOptions["SelectedType"] == 2 then
        local index = AtlasLootOptions["SelectedZone"];
        AtlasLoot_ShowItemsFrame(AtlasLoot_Zones[2][index][2], AtlasLootWBItems, AtlasLoot_Zones[2][index][1], pFrame);
    elseif AtlasLootOptions["SelectedType"] == 3 then
        local index = AtlasLootOptions["SelectedZone"];
        if AtlasLoot_Zones[3][index][2]~="" then
            AtlasLoot_ShowItemsFrame(AtlasLoot_Zones[3][index][2], AtlasLootSetItems, AtlasLoot_Zones[3][index][1], pFrame);
        else
            local i1 = AtlasLootOptions["SelectedZoneText"];
            local i2 = AtlasLootOptions["SelectedBoss"];
            if AtlasLoot_Bosses[i1] then
                AtlasLoot_ShowItemsFrame(AtlasLoot_Bosses[i1][i2][2], AtlasLootSetItems, AtlasLoot_Bosses[i1][i2][1], pFrame);
            end
        end
    elseif AtlasLootOptions["SelectedType"] == 4 then
        local index = AtlasLootOptions["SelectedZone"];
        if AtlasLoot_Zones[4][index][2]~="" then
            if AtlasLoot_Zones[4][index][2] == "AQBroodRings" then
                AtlasLoot_ShowItemsFrame(AtlasLoot_Zones[4][index][2], AtlasLootItems, AtlasLoot_Zones[4][index][1], pFrame);
            else
                AtlasLoot_ShowItemsFrame(AtlasLoot_Zones[4][index][2], AtlasLootRepItems, AtlasLoot_Zones[4][index][1], pFrame);
            end
        else
            local i1 = AtlasLootOptions["SelectedZoneText"];
            local i2 = AtlasLootOptions["SelectedBoss"];
            if AtlasLoot_Bosses[i1] then
                AtlasLoot_ShowItemsFrame(AtlasLoot_Bosses[i1][i2][2], AtlasLootRepItems, AtlasLoot_Bosses[i1][i2][1], pFrame);
            end
        end
    elseif AtlasLootOptions["SelectedType"] == 5 then
        local index = AtlasLootOptions["SelectedZoneText"];
        if AtlasLoot_Bosses[index] then
            local subindex = AtlasLootOptions["SelectedBoss"];
            if AtlasLootOptions["SelectedZone"] == 3 then --PvP Set exception
                AtlasLoot_ShowItemsFrame(AtlasLoot_Bosses[index][subindex][2], AtlasLootSetItems, AtlasLoot_Bosses[index][subindex][1], pFrame);
            elseif AtlasLootBGItems[AtlasLoot_Bosses[index][subindex][2]] then
                AtlasLoot_ShowItemsFrame(AtlasLoot_Bosses[index][subindex][2], AtlasLootBGItems, AtlasLoot_Bosses[index][subindex][1], pFrame);
            else
                AtlasLoot_ShowItemsFrame(AtlasLoot_Bosses[index][subindex][2], AtlasLootWorldPvPItems, AtlasLoot_Bosses[index][subindex][1], pFrame);
            end
        end
    end
end
            
            
        

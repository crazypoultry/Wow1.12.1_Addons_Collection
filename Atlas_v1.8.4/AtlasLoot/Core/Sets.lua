function AtlasLoot_SetMenu(setname)
    if(setname=="AQ40SET") then
        getglobal("AtlasLootItemsFrame_Druid"):Show();
        getglobal("AtlasLootItemsFrame_Druid").lootpage="AQ40Druid";
        getglobal("AtlasLootItemsFrame_Hunter"):Show();
        getglobal("AtlasLootItemsFrame_Hunter").lootpage="AQ40Hunter";
        getglobal("AtlasLootItemsFrame_Mage"):Show();
        getglobal("AtlasLootItemsFrame_Mage").lootpage="AQ40Mage";
        getglobal("AtlasLootItemsFrame_Paladin"):Show();
        getglobal("AtlasLootItemsFrame_Paladin").lootpage="AQ40Paladin";
        getglobal("AtlasLootItemsFrame_Priest"):Show();
        getglobal("AtlasLootItemsFrame_Priest").lootpage="AQ40Priest";
        getglobal("AtlasLootItemsFrame_Rogue"):Show();
        getglobal("AtlasLootItemsFrame_Rogue").lootpage="AQ40Rogue";
        getglobal("AtlasLootItemsFrame_Shaman"):Show();
        getglobal("AtlasLootItemsFrame_Shaman").lootpage="AQ40Shaman";
        getglobal("AtlasLootItemsFrame_Warlock"):Show();
        getglobal("AtlasLootItemsFrame_Warlock").lootpage="AQ40Warlock";
        getglobal("AtlasLootItemsFrame_Warrior"):Show();
        getglobal("AtlasLootItemsFrame_Warrior").lootpage="AQ40Warrior";
        getglobal("AtlasLootItemsFrame_Weapons"):Hide();
        getglobal("AtlasLootItemsFrame_NEXT"):Hide();
        getglobal("AtlasLootItemsFrame_PREV"):Hide();
        getglobal("AtlasLootItemsFrame_BACK"):Hide();
        getglobal("AtlasLootItemsFrame_BACK").setname="AQ40SET";
        AtlasLoot_BossName:SetText("|cffFFFFFF"..ATLASLOOT_AQ40_SETS);
        AtlasLootItemsFrame:Show();
    elseif(setname=="AQ20SET") then
        getglobal("AtlasLootItemsFrame_Druid"):Show();
        getglobal("AtlasLootItemsFrame_Druid").lootpage="AQ20Druid";
        getglobal("AtlasLootItemsFrame_Hunter"):Show();
        getglobal("AtlasLootItemsFrame_Hunter").lootpage="AQ20Hunter";
        getglobal("AtlasLootItemsFrame_Mage"):Show();
        getglobal("AtlasLootItemsFrame_Mage").lootpage="AQ20Mage";
        getglobal("AtlasLootItemsFrame_Paladin"):Show();
        getglobal("AtlasLootItemsFrame_Paladin").lootpage="AQ20Paladin";
        getglobal("AtlasLootItemsFrame_Priest"):Show();
        getglobal("AtlasLootItemsFrame_Priest").lootpage="AQ20Priest";
        getglobal("AtlasLootItemsFrame_Rogue"):Show();
        getglobal("AtlasLootItemsFrame_Rogue").lootpage="AQ20Rogue";
        getglobal("AtlasLootItemsFrame_Shaman"):Show();
        getglobal("AtlasLootItemsFrame_Shaman").lootpage="AQ20Shaman";
        getglobal("AtlasLootItemsFrame_Warlock"):Show();
        getglobal("AtlasLootItemsFrame_Warlock").lootpage="AQ20Warlock";
        getglobal("AtlasLootItemsFrame_Warrior"):Show();
        getglobal("AtlasLootItemsFrame_Warrior").lootpage="AQ20Warrior";
        getglobal("AtlasLootItemsFrame_Weapons"):Hide();
        getglobal("AtlasLootItemsFrame_NEXT"):Hide();
        getglobal("AtlasLootItemsFrame_PREV"):Hide();
        getglobal("AtlasLootItemsFrame_BACK"):Hide();
        getglobal("AtlasLootItemsFrame_BACK").setname="AQ20SET";
        AtlasLoot_BossName:SetText("|cffFFFFFF"..ATLASLOOT_AQ20_SETS);
        AtlasLootItemsFrame:Show();
    elseif(setname=="ZGSET") then
        getglobal("AtlasLootItemsFrame_Druid"):Show();
        getglobal("AtlasLootItemsFrame_Druid").lootpage="ZGDruid";
        getglobal("AtlasLootItemsFrame_Hunter"):Show();
        getglobal("AtlasLootItemsFrame_Hunter").lootpage="ZGHunter";
        getglobal("AtlasLootItemsFrame_Mage"):Show();
        getglobal("AtlasLootItemsFrame_Mage").lootpage="ZGMage";
        getglobal("AtlasLootItemsFrame_Paladin"):Show();
        getglobal("AtlasLootItemsFrame_Paladin").lootpage="ZGPaladin";
        getglobal("AtlasLootItemsFrame_Priest"):Show();
        getglobal("AtlasLootItemsFrame_Priest").lootpage="ZGPriest";
        getglobal("AtlasLootItemsFrame_Rogue"):Show();
        getglobal("AtlasLootItemsFrame_Rogue").lootpage="ZGRogue";
        getglobal("AtlasLootItemsFrame_Shaman"):Show();
        getglobal("AtlasLootItemsFrame_Shaman").lootpage="ZGShaman";
        getglobal("AtlasLootItemsFrame_Warlock"):Show();
        getglobal("AtlasLootItemsFrame_Warlock").lootpage="ZGWarlock";
        getglobal("AtlasLootItemsFrame_Warrior"):Show();
        getglobal("AtlasLootItemsFrame_Warrior").lootpage="ZGWarrior";
        getglobal("AtlasLootItemsFrame_Weapons"):Hide();
        getglobal("AtlasLootItemsFrame_NEXT"):Hide();
        getglobal("AtlasLootItemsFrame_PREV"):Hide();
        getglobal("AtlasLootItemsFrame_BACK"):Hide();
        getglobal("AtlasLootItemsFrame_BACK").setname="ZGSET";
        AtlasLoot_BossName:SetText("|cffFFFFFF"..ATLASLOOT_ZG_SETS);
        AtlasLootItemsFrame:Show();
    elseif(setname=="T3SET") then
        getglobal("AtlasLootItemsFrame_Druid"):Show();
        getglobal("AtlasLootItemsFrame_Druid").lootpage="T3Druid";
        getglobal("AtlasLootItemsFrame_Hunter"):Show();
        getglobal("AtlasLootItemsFrame_Hunter").lootpage="T3Hunter";
        getglobal("AtlasLootItemsFrame_Mage"):Show();
        getglobal("AtlasLootItemsFrame_Mage").lootpage="T3Mage";
        getglobal("AtlasLootItemsFrame_Paladin"):Show();
        getglobal("AtlasLootItemsFrame_Paladin").lootpage="T3Paladin";
        getglobal("AtlasLootItemsFrame_Priest"):Show();
        getglobal("AtlasLootItemsFrame_Priest").lootpage="T3Priest";
        getglobal("AtlasLootItemsFrame_Rogue"):Show();
        getglobal("AtlasLootItemsFrame_Rogue").lootpage="T3Rogue";
        getglobal("AtlasLootItemsFrame_Shaman"):Show();
        getglobal("AtlasLootItemsFrame_Shaman").lootpage="T3Shaman";
        getglobal("AtlasLootItemsFrame_Warlock"):Show();
        getglobal("AtlasLootItemsFrame_Warlock").lootpage="T3Warlock";
        getglobal("AtlasLootItemsFrame_Warrior"):Show();
        getglobal("AtlasLootItemsFrame_Warrior").lootpage="T3Warrior";
        getglobal("AtlasLootItemsFrame_Weapons"):Hide();
        getglobal("AtlasLootItemsFrame_NEXT"):Hide();
        getglobal("AtlasLootItemsFrame_PREV"):Hide();
        getglobal("AtlasLootItemsFrame_BACK"):Hide();
        getglobal("AtlasLootItemsFrame_BACK").setname="T3SET";
        AtlasLoot_BossName:SetText("|cffFFFFFF"..ATLASLOOT_TIER3_SETS);
        AtlasLootItemsFrame:Show();
    elseif(setname=="T2SET") then
        getglobal("AtlasLootItemsFrame_Druid"):Show();
        getglobal("AtlasLootItemsFrame_Druid").lootpage="T2Druid";
        getglobal("AtlasLootItemsFrame_Hunter"):Show();
        getglobal("AtlasLootItemsFrame_Hunter").lootpage="T2Hunter";
        getglobal("AtlasLootItemsFrame_Mage"):Show();
        getglobal("AtlasLootItemsFrame_Mage").lootpage="T2Mage";
        getglobal("AtlasLootItemsFrame_Paladin"):Show();
        getglobal("AtlasLootItemsFrame_Paladin").lootpage="T2Paladin";
        getglobal("AtlasLootItemsFrame_Priest"):Show();
        getglobal("AtlasLootItemsFrame_Priest").lootpage="T2Priest";
        getglobal("AtlasLootItemsFrame_Rogue"):Show();
        getglobal("AtlasLootItemsFrame_Rogue").lootpage="T2Rogue";
        getglobal("AtlasLootItemsFrame_Shaman"):Show();
        getglobal("AtlasLootItemsFrame_Shaman").lootpage="T2Shaman";
        getglobal("AtlasLootItemsFrame_Warlock"):Show();
        getglobal("AtlasLootItemsFrame_Warlock").lootpage="T2Warlock";
        getglobal("AtlasLootItemsFrame_Warrior"):Show();
        getglobal("AtlasLootItemsFrame_Warrior").lootpage="T2Warrior";
        getglobal("AtlasLootItemsFrame_Weapons"):Hide();
        getglobal("AtlasLootItemsFrame_NEXT"):Hide();
        getglobal("AtlasLootItemsFrame_PREV"):Hide();
        getglobal("AtlasLootItemsFrame_BACK"):Hide();
        getglobal("AtlasLootItemsFrame_BACK").setname="T2SET";
        AtlasLoot_BossName:SetText("|cffFFFFFF"..ATLASLOOT_TIER2_SETS);
        AtlasLootItemsFrame:Show();
    elseif(setname=="T1SET") then
        getglobal("AtlasLootItemsFrame_Druid"):Show();
        getglobal("AtlasLootItemsFrame_Druid").lootpage="T1Druid";
        getglobal("AtlasLootItemsFrame_Hunter"):Show();
        getglobal("AtlasLootItemsFrame_Hunter").lootpage="T1Hunter";
        getglobal("AtlasLootItemsFrame_Mage"):Show();
        getglobal("AtlasLootItemsFrame_Mage").lootpage="T1Mage";
        getglobal("AtlasLootItemsFrame_Paladin"):Show();
        getglobal("AtlasLootItemsFrame_Paladin").lootpage="T1Paladin";
        getglobal("AtlasLootItemsFrame_Priest"):Show();
        getglobal("AtlasLootItemsFrame_Priest").lootpage="T1Priest";
        getglobal("AtlasLootItemsFrame_Rogue"):Show();
        getglobal("AtlasLootItemsFrame_Rogue").lootpage="T1Rogue";
        getglobal("AtlasLootItemsFrame_Shaman"):Show();
        getglobal("AtlasLootItemsFrame_Shaman").lootpage="T1Shaman";
        getglobal("AtlasLootItemsFrame_Warlock"):Show();
        getglobal("AtlasLootItemsFrame_Warlock").lootpage="T1Warlock";
        getglobal("AtlasLootItemsFrame_Warrior"):Show();
        getglobal("AtlasLootItemsFrame_Warrior").lootpage="T1Warrior";
        getglobal("AtlasLootItemsFrame_Weapons"):Hide();
        getglobal("AtlasLootItemsFrame_NEXT"):Hide();
        getglobal("AtlasLootItemsFrame_PREV"):Hide();
        getglobal("AtlasLootItemsFrame_BACK"):Hide();
        getglobal("AtlasLootItemsFrame_BACK").setname="T1SET";
        AtlasLoot_BossName:SetText("|cffFFFFFF"..ATLASLOOT_TIER1_SETS);
        AtlasLootItemsFrame:Show();
    elseif(setname=="T0SET") then
        getglobal("AtlasLootItemsFrame_Druid"):Show();
        getglobal("AtlasLootItemsFrame_Druid").lootpage="T0Druid";
        getglobal("AtlasLootItemsFrame_Hunter"):Show();
        getglobal("AtlasLootItemsFrame_Hunter").lootpage="T0Hunter";
        getglobal("AtlasLootItemsFrame_Mage"):Show();
        getglobal("AtlasLootItemsFrame_Mage").lootpage="T0Mage";
        getglobal("AtlasLootItemsFrame_Paladin"):Show();
        getglobal("AtlasLootItemsFrame_Paladin").lootpage="T0Paladin";
        getglobal("AtlasLootItemsFrame_Priest"):Show();
        getglobal("AtlasLootItemsFrame_Priest").lootpage="T0Priest";
        getglobal("AtlasLootItemsFrame_Rogue"):Show();
        getglobal("AtlasLootItemsFrame_Rogue").lootpage="T0Rogue";
        getglobal("AtlasLootItemsFrame_Shaman"):Show();
        getglobal("AtlasLootItemsFrame_Shaman").lootpage="T0Shaman";
        getglobal("AtlasLootItemsFrame_Warlock"):Show();
        getglobal("AtlasLootItemsFrame_Warlock").lootpage="T0Warlock";
        getglobal("AtlasLootItemsFrame_Warrior"):Show();
        getglobal("AtlasLootItemsFrame_Warrior").lootpage="T0Warrior";
        getglobal("AtlasLootItemsFrame_Weapons"):Hide();
        getglobal("AtlasLootItemsFrame_NEXT"):Hide();
        getglobal("AtlasLootItemsFrame_PREV"):Hide();
        getglobal("AtlasLootItemsFrame_BACK"):Hide();
        getglobal("AtlasLootItemsFrame_BACK").setname="T0SET";
        AtlasLoot_BossName:SetText("|cffFFFFFF"..ATLASLOOT_TIER0_SETS);
        AtlasLootItemsFrame:Show();
    elseif(setname=="PVPSET") then
        getglobal("AtlasLootItemsFrame_Druid"):Show();
        getglobal("AtlasLootItemsFrame_Druid").lootpage="PVPDruid";
        getglobal("AtlasLootItemsFrame_Hunter"):Show();
        getglobal("AtlasLootItemsFrame_Hunter").lootpage="PVPHunter";
        getglobal("AtlasLootItemsFrame_Mage"):Show();
        getglobal("AtlasLootItemsFrame_Mage").lootpage="PVPMage";
        getglobal("AtlasLootItemsFrame_Paladin"):Show();
        getglobal("AtlasLootItemsFrame_Paladin").lootpage="PVPPaladin";
        getglobal("AtlasLootItemsFrame_Priest"):Show();
        getglobal("AtlasLootItemsFrame_Priest").lootpage="PVPPriest";
        getglobal("AtlasLootItemsFrame_Rogue"):Show();
        getglobal("AtlasLootItemsFrame_Rogue").lootpage="PVPRogue";
        getglobal("AtlasLootItemsFrame_Shaman"):Show();
        getglobal("AtlasLootItemsFrame_Shaman").lootpage="PVPShaman";
        getglobal("AtlasLootItemsFrame_Warlock"):Show();
        getglobal("AtlasLootItemsFrame_Warlock").lootpage="PVPWarlock";
        getglobal("AtlasLootItemsFrame_Warrior"):Show();
        getglobal("AtlasLootItemsFrame_Warrior").lootpage="PVPWarrior";
        getglobal("AtlasLootItemsFrame_Weapons"):Show();
        getglobal("AtlasLootItemsFrame_Weapons").lootpage="PVPWeapons1";
        getglobal("AtlasLootItemsFrame_NEXT"):Hide();
        getglobal("AtlasLootItemsFrame_PREV"):Hide();
        getglobal("AtlasLootItemsFrame_BACK"):Hide();
        getglobal("AtlasLootItemsFrame_BACK").setname="PVPSET";
        AtlasLoot_BossName:SetText("|cffFFFFFF"..ATLASLOOT_PVP_SET_PIECES_HEADER);
        AtlasLootItemsFrame:Show();
    end
    for i=1, 30, 1 do
        getglobal("AtlasLootItem_"..i):Hide();
    end
end

--------------------------------------------------------------------------------
-- Deal with items sets
--------------------------------------------------------------------------------
function AtlasLoot_Set(setname)
    if(setname~=nil) then
        AtlasLoot_SetMenu(setname);
    elseif(this:GetName()=="AtlasLootItemsFrame_BACK") then
        AtlasLoot_SetMenu(this.setname);
    elseif((this:GetName()=="AtlasLootItemsFrame_Weapons" and AtlasLoot_BossName:GetText()=="|cffFFFFFF"..ATLASLOOT_PVP_SET_PIECES_HEADER) or (this:GetName()=="AtlasLootItemsFrame_PREV" and AtlasLoot_BossName:GetText()==getglobal("AtlasLootItemsFrame_Weapons"):GetText())) then
        getglobal("AtlasLootItemsFrame_Druid"):Hide();
        getglobal("AtlasLootItemsFrame_Hunter"):Hide();
        getglobal("AtlasLootItemsFrame_Mage"):Hide();
        getglobal("AtlasLootItemsFrame_Paladin"):Hide();
        getglobal("AtlasLootItemsFrame_Priest"):Hide();
        getglobal("AtlasLootItemsFrame_Rogue"):Hide();
        getglobal("AtlasLootItemsFrame_Shaman"):Hide();
        getglobal("AtlasLootItemsFrame_Warlock"):Hide();
        getglobal("AtlasLootItemsFrame_Warrior"):Hide();
        getglobal("AtlasLootItemsFrame_Weapons"):Hide();
        getglobal("AtlasLootItemsFrame_PREV"):Hide();
        AtlasLoot_ShowItemsFrame(this.lootpage, AtlasLootSetItems, getglobal("AtlasLootItemsFrame_Weapons"):GetText(), AtlasLoot_AnchorFrame);
        getglobal("AtlasLootItemsFrame_BACK"):Show();
        getglobal("AtlasLootItemsFrame_NEXT"):Show();
        getglobal("AtlasLootItemsFrame_NEXT").lootpage="PVPWeapons2";
    elseif(this:GetName()=="AtlasLootItemsFrame_NEXT" and AtlasLoot_BossName:GetText()==getglobal("AtlasLootItemsFrame_Weapons"):GetText()) then
        getglobal("AtlasLootItemsFrame_Druid"):Hide();
        getglobal("AtlasLootItemsFrame_Hunter"):Hide();
        getglobal("AtlasLootItemsFrame_Mage"):Hide();
        getglobal("AtlasLootItemsFrame_Paladin"):Hide();
        getglobal("AtlasLootItemsFrame_Priest"):Hide();
        getglobal("AtlasLootItemsFrame_Rogue"):Hide();
        getglobal("AtlasLootItemsFrame_Shaman"):Hide();
        getglobal("AtlasLootItemsFrame_Warlock"):Hide();
        getglobal("AtlasLootItemsFrame_Warrior"):Hide();
        getglobal("AtlasLootItemsFrame_Weapons"):Hide();
        getglobal("AtlasLootItemsFrame_NEXT"):Hide();
        AtlasLoot_ShowItemsFrame(this.lootpage, AtlasLootSetItems, getglobal("AtlasLootItemsFrame_Weapons"):GetText(), AtlasLoot_AnchorFrame);
        getglobal("AtlasLootItemsFrame_BACK"):Show();
        getglobal("AtlasLootItemsFrame_PREV"):Show();
        getglobal("AtlasLootItemsFrame_PREV").lootpage="PVPWeapons1";
    elseif(this:GetName()=="AtlasLootItemsFrame_NEXT" or this:GetName()=="AtlasLootItemsFrame_PREV") then
        AtlasLoot_Rep(this.lootpage, AtlasLoot_BossName:GetText());
    else
        getglobal("AtlasLootItemsFrame_Druid"):Hide();
        getglobal("AtlasLootItemsFrame_Hunter"):Hide();
        getglobal("AtlasLootItemsFrame_Mage"):Hide();
        getglobal("AtlasLootItemsFrame_Paladin"):Hide();
        getglobal("AtlasLootItemsFrame_Priest"):Hide();
        getglobal("AtlasLootItemsFrame_Rogue"):Hide();
        getglobal("AtlasLootItemsFrame_Shaman"):Hide();
        getglobal("AtlasLootItemsFrame_Warlock"):Hide();
        getglobal("AtlasLootItemsFrame_Warrior"):Hide();
        getglobal("AtlasLootItemsFrame_Weapons"):Hide();
        getglobal("AtlasLootItemsFrame_NEXT"):Hide();
        getglobal("AtlasLootItemsFrame_PREV"):Hide();
        AtlasLoot_ShowItemsFrame(this.lootpage, AtlasLootSetItems, this:GetText(), AtlasLoot_AnchorFrame);
        getglobal("AtlasLootItemsFrame_BACK"):Show();
    end
end

function AtlasLootSetButton_OnClick(setid)
    for i = 1, 30, 1 do
        getglobal("AtlasLootMenuItem_"..i):Hide();
    end
    if (setid=="Legendaries") then
        AtlasLoot_ShowItemsFrame(setid, AtlasLootSetItems, ATLASLOOT_LEGENDARIES, AtlasLoot_AnchorFrame);
    else
        AtlasLoot_ShowItemsFrame(setid, AtlasLootSetItems, "Sets", AtlasLoot_AnchorFrame);
    end
end

function AtlasLootRepButton_OnClick(setid, text)
    for i = 1, 30, 1 do
        getglobal("AtlasLootMenuItem_"..i):Hide();
    end
    getglobal("AtlasLootItemsFrame_NEXT"):Hide();
    getglobal("AtlasLootItemsFrame_PREV"):Hide();
    if (setid=="Darkmoon" or setid=="Timbermaw" or setid=="CExpedition1" or setid=="Sporeggar1" or setid=="Kurenai1") then
        AtlasLoot_ShowItemsFrame(setid, AtlasLootRepItems, text, AtlasLoot_AnchorFrame);
    elseif (setid=="Scryer1" or setid=="Aldor1" or setid=="HonorHold1" or setid=="Thrallmar1" or setid=="Tranquillien1" or setid=="Maghar1") then
        AtlasLoot_ShowItemsFrame(setid, AtlasLootRepItems, text, AtlasLoot_AnchorFrame);
    elseif (setid=="AQBroodRings") then
        AtlasLoot_ShowItemsFrame(setid, AtlasLootItems, ATLASLOOT_FACTION_BROOD, AtlasLoot_AnchorFrame);
    else
        AtlasLoot_Rep(setid, text);
    end
end

function AtlasLoot_Rep(setid, text)
    for i = 1, 30, 1 do
        getglobal("AtlasLootMenuItem_"..i):Hide();
    end
    getglobal("AtlasLootItemsFrame_NEXT"):Hide();
    getglobal("AtlasLootItemsFrame_PREV"):Hide();
    if(setid=="Thorium1") then
        AtlasLoot_ShowItemsFrame(setid, AtlasLootRepItems, ATLASLOOT_FACTION_THORIUM..": "..ATLASLOOT_FRIENDLY, AtlasLoot_AnchorFrame);
        getglobal("AtlasLootItemsFrame_NEXT").lootpage="Thorium2";
        getglobal("AtlasLootItemsFrame_NEXT"):Show();
    elseif(setid=="Thorium2") then
        AtlasLoot_ShowItemsFrame(setid, AtlasLootRepItems, ATLASLOOT_FACTION_THORIUM..": "..ATLASLOOT_HONORED, AtlasLoot_AnchorFrame);
        getglobal("AtlasLootItemsFrame_NEXT").lootpage="Thorium3";
        getglobal("AtlasLootItemsFrame_NEXT"):Show();
        getglobal("AtlasLootItemsFrame_PREV").lootpage="Thorium1";
        getglobal("AtlasLootItemsFrame_PREV"):Show();
    elseif(setid=="Thorium3") then
        AtlasLoot_ShowItemsFrame(setid, AtlasLootRepItems, ATLASLOOT_FACTION_THORIUM..": "..ATLASLOOT_REVERED, AtlasLoot_AnchorFrame);
        getglobal("AtlasLootItemsFrame_NEXT").lootpage="Thorium4";
        getglobal("AtlasLootItemsFrame_NEXT"):Show();
        getglobal("AtlasLootItemsFrame_PREV").lootpage="Thorium2";
        getglobal("AtlasLootItemsFrame_PREV"):Show();
    elseif(setid=="Thorium4") then
        AtlasLoot_ShowItemsFrame(setid, AtlasLootRepItems, ATLASLOOT_FACTION_THORIUM..": "..ATLASLOOT_EXALTED, AtlasLoot_AnchorFrame);
        getglobal("AtlasLootItemsFrame_PREV").lootpage="Thorium3";
        getglobal("AtlasLootItemsFrame_PREV"):Show();
    elseif(setid=="Cenarion1") then
        AtlasLoot_ShowItemsFrame(setid, AtlasLootRepItems, ATLASLOOT_FACTION_CENARION..": "..ATLASLOOT_FRIENDLY, AtlasLoot_AnchorFrame);
        getglobal("AtlasLootItemsFrame_NEXT").lootpage="Cenarion2";
        getglobal("AtlasLootItemsFrame_NEXT"):Show();
    elseif(setid=="Cenarion2") then
        AtlasLoot_ShowItemsFrame(setid, AtlasLootRepItems, ATLASLOOT_FACTION_CENARION..": "..ATLASLOOT_HONORED, AtlasLoot_AnchorFrame);
        getglobal("AtlasLootItemsFrame_NEXT").lootpage="Cenarion3";
        getglobal("AtlasLootItemsFrame_NEXT"):Show();
        getglobal("AtlasLootItemsFrame_PREV").lootpage="Cenarion1";
        getglobal("AtlasLootItemsFrame_PREV"):Show();
    elseif(setid=="Cenarion3") then
        AtlasLoot_ShowItemsFrame(setid, AtlasLootRepItems, ATLASLOOT_FACTION_CENARION..": "..ATLASLOOT_REVERED, AtlasLoot_AnchorFrame);
        getglobal("AtlasLootItemsFrame_NEXT").lootpage="Cenarion4";
        getglobal("AtlasLootItemsFrame_NEXT"):Show();
        getglobal("AtlasLootItemsFrame_PREV").lootpage="Cenarion2";
        getglobal("AtlasLootItemsFrame_PREV"):Show();
    elseif(setid=="Cenarion4") then
        AtlasLoot_ShowItemsFrame(setid, AtlasLootRepItems, ATLASLOOT_FACTION_CENARION..": "..ATLASLOOT_EXALTED, AtlasLoot_AnchorFrame);
        getglobal("AtlasLootItemsFrame_PREV").lootpage="Cenarion3";
        getglobal("AtlasLootItemsFrame_PREV"):Show();
    elseif(setid=="Argent1") then
        AtlasLoot_ShowItemsFrame(setid, AtlasLootRepItems, ATLASLOOT_FACTION_ARGENT..": "..ATLASLOOT_FACTION_ARGENT_TOKEN, AtlasLoot_AnchorFrame);
        getglobal("AtlasLootItemsFrame_NEXT").lootpage="Argent2";
        getglobal("AtlasLootItemsFrame_NEXT"):Show();
    elseif(setid=="Argent2") then
        AtlasLoot_ShowItemsFrame(setid, AtlasLootRepItems, ATLASLOOT_FACTION_ARGENT..": "..ATLASLOOT_FRIENDLY.."/"..ATLASLOOT_HONORED, AtlasLoot_AnchorFrame);
        getglobal("AtlasLootItemsFrame_NEXT").lootpage="Argent3";
        getglobal("AtlasLootItemsFrame_NEXT"):Show();
        getglobal("AtlasLootItemsFrame_PREV").lootpage="Argent1";
        getglobal("AtlasLootItemsFrame_PREV"):Show();
    elseif(setid=="Argent3") then
        AtlasLoot_ShowItemsFrame(setid, AtlasLootRepItems, ATLASLOOT_FACTION_ARGENT..": "..ATLASLOOT_REVERED.."/"..ATLASLOOT_EXALTED, AtlasLoot_AnchorFrame);
        getglobal("AtlasLootItemsFrame_PREV").lootpage="Argent2";
        getglobal("AtlasLootItemsFrame_PREV"):Show();
    elseif(setid=="Zandalar1") then
        AtlasLoot_ShowItemsFrame(setid, AtlasLootRepItems, ATLASLOOT_FACTION_ZANDALAR..": "..ATLASLOOT_FRIENDLY, AtlasLoot_AnchorFrame);
        getglobal("AtlasLootItemsFrame_NEXT").lootpage="Zandalar2";
        getglobal("AtlasLootItemsFrame_NEXT"):Show();
    elseif(setid=="Zandalar2") then
        AtlasLoot_ShowItemsFrame(setid, AtlasLootRepItems, ATLASLOOT_FACTION_ZANDALAR..": "..ATLASLOOT_HONORED, AtlasLoot_AnchorFrame);
        getglobal("AtlasLootItemsFrame_NEXT").lootpage="Zandalar3";
        getglobal("AtlasLootItemsFrame_NEXT"):Show();
        getglobal("AtlasLootItemsFrame_PREV").lootpage="Zandalar1";
        getglobal("AtlasLootItemsFrame_PREV"):Show();
    elseif(setid=="Zandalar3") then
        AtlasLoot_ShowItemsFrame(setid, AtlasLootRepItems, ATLASLOOT_FACTION_ZANDALAR..": "..ATLASLOOT_REVERED, AtlasLoot_AnchorFrame);
        getglobal("AtlasLootItemsFrame_NEXT").lootpage="Zandalar4";
        getglobal("AtlasLootItemsFrame_NEXT"):Show();
        getglobal("AtlasLootItemsFrame_PREV").lootpage="Zandalar2";
        getglobal("AtlasLootItemsFrame_PREV"):Show();
    elseif(setid=="Zandalar4") then
        AtlasLoot_ShowItemsFrame(setid, AtlasLootRepItems, ATLASLOOT_FACTION_ZANDALAR..": "..ATLASLOOT_EXALTED, AtlasLoot_AnchorFrame);
        getglobal("AtlasLootItemsFrame_PREV").lootpage="Zandalar3";
        getglobal("AtlasLootItemsFrame_PREV"):Show();
    elseif(this:GetName()=="AtlasLootItemsFrame_NEXT" or this:GetName()=="AtlasLootItemsFrame_PREV") then
        AtlasLootPvPButton_OnClick(this.lootpage);
    end
end

function AtlasLootPvPButton_OnClick(setid)
    for i = 1, 30, 1 do
        getglobal("AtlasLootMenuItem_"..i):Hide();
    end
    getglobal("AtlasLootItemsFrame_NEXT"):Hide();
    getglobal("AtlasLootItemsFrame_PREV"):Hide();
    if AtlasLootBGItems[setid]~=nil then
        if(setid=="AVFriendly") then
            AtlasLoot_ShowItemsFrame(setid, AtlasLootBGItems, ATLASLOOT_FACTION_ALTERAC..": "..ATLASLOOT_FRIENDLY, AtlasLoot_AnchorFrame);
            getglobal("AtlasLootItemsFrame_NEXT").lootpage="AVHonored";
            getglobal("AtlasLootItemsFrame_NEXT"):Show();
        elseif(setid=="AVHonored") then
            AtlasLoot_ShowItemsFrame(setid, AtlasLootBGItems, ATLASLOOT_FACTION_ALTERAC..": "..ATLASLOOT_HONORED, AtlasLoot_AnchorFrame);
            getglobal("AtlasLootItemsFrame_NEXT").lootpage="AVRevered";
            getglobal("AtlasLootItemsFrame_NEXT"):Show();
            getglobal("AtlasLootItemsFrame_PREV").lootpage="AVFriendly";
            getglobal("AtlasLootItemsFrame_PREV"):Show();
        elseif(setid=="AVRevered") then
            AtlasLoot_ShowItemsFrame(setid, AtlasLootBGItems, ATLASLOOT_FACTION_ALTERAC..": "..ATLASLOOT_REVERED, AtlasLoot_AnchorFrame);
            getglobal("AtlasLootItemsFrame_NEXT").lootpage="AVExalted";
            getglobal("AtlasLootItemsFrame_NEXT"):Show();
            getglobal("AtlasLootItemsFrame_PREV").lootpage="AVHonored";
            getglobal("AtlasLootItemsFrame_PREV"):Show();
        elseif(setid=="AVExalted") then
            AtlasLoot_ShowItemsFrame(setid, AtlasLootBGItems, ATLASLOOT_FACTION_ALTERAC..": "..ATLASLOOT_EXALTED, AtlasLoot_AnchorFrame);
            getglobal("AtlasLootItemsFrame_PREV").lootpage="AVRevered";
            getglobal("AtlasLootItemsFrame_PREV"):Show();
        elseif(setid=="ABFriendly") then
            AtlasLoot_ShowItemsFrame(setid, AtlasLootBGItems, ATLASLOOT_FACTION_ARATHI..": "..ATLASLOOT_FRIENDLY, AtlasLoot_AnchorFrame);
            getglobal("AtlasLootItemsFrame_NEXT").lootpage="ABHonored";
            getglobal("AtlasLootItemsFrame_NEXT"):Show();
        elseif(setid=="ABHonored") then
            AtlasLoot_ShowItemsFrame(setid, AtlasLootBGItems, ATLASLOOT_FACTION_ARATHI..": "..ATLASLOOT_HONORED, AtlasLoot_AnchorFrame);
            getglobal("AtlasLootItemsFrame_NEXT").lootpage="ABRevered";
            getglobal("AtlasLootItemsFrame_NEXT"):Show();
            getglobal("AtlasLootItemsFrame_PREV").lootpage="ABFriendly";
            getglobal("AtlasLootItemsFrame_PREV"):Show();
        elseif(setid=="ABRevered") then
            AtlasLoot_ShowItemsFrame(setid, AtlasLootBGItems, ATLASLOOT_FACTION_ARATHI..": "..ATLASLOOT_REVERED, AtlasLoot_AnchorFrame);
            getglobal("AtlasLootItemsFrame_NEXT").lootpage="ABExalted";
            getglobal("AtlasLootItemsFrame_NEXT"):Show();
            getglobal("AtlasLootItemsFrame_PREV").lootpage="ABHonored";
            getglobal("AtlasLootItemsFrame_PREV"):Show();
        elseif(setid=="ABExalted") then
            AtlasLoot_ShowItemsFrame(setid, AtlasLootBGItems, ATLASLOOT_FACTION_ARATHI..": "..ATLASLOOT_EXALTED, AtlasLoot_AnchorFrame);
            getglobal("AtlasLootItemsFrame_PREV").lootpage="ABRevered";
            getglobal("AtlasLootItemsFrame_PREV"):Show();
        elseif(setid=="WSGFriendly") then
            AtlasLoot_ShowItemsFrame(setid, AtlasLootBGItems, ATLASLOOT_FACTION_WARSONG..": "..ATLASLOOT_FRIENDLY, AtlasLoot_AnchorFrame);
            getglobal("AtlasLootItemsFrame_NEXT").lootpage="WSGHonored";
            getglobal("AtlasLootItemsFrame_NEXT"):Show();
        elseif(setid=="WSGHonored") then
            AtlasLoot_ShowItemsFrame(setid, AtlasLootBGItems, ATLASLOOT_FACTION_WARSONG..": "..ATLASLOOT_HONORED, AtlasLoot_AnchorFrame);
            getglobal("AtlasLootItemsFrame_NEXT").lootpage="WSGRevered";
            getglobal("AtlasLootItemsFrame_NEXT"):Show();
            getglobal("AtlasLootItemsFrame_PREV").lootpage="WSGFriendly";
            getglobal("AtlasLootItemsFrame_PREV"):Show();
        elseif(setid=="WSGRevered") then
            AtlasLoot_ShowItemsFrame(setid, AtlasLootBGItems, ATLASLOOT_FACTION_WARSONG..": "..ATLASLOOT_REVERED, AtlasLoot_AnchorFrame);
            getglobal("AtlasLootItemsFrame_NEXT").lootpage="WSGExalted";
            getglobal("AtlasLootItemsFrame_NEXT"):Show();
            getglobal("AtlasLootItemsFrame_PREV").lootpage="WSGHonored";
            getglobal("AtlasLootItemsFrame_PREV"):Show();
        elseif(setid=="WSGExalted") then
            AtlasLoot_ShowItemsFrame(setid, AtlasLootBGItems, ATLASLOOT_FACTION_WARSONG..": "..ATLASLOOT_EXALTED, AtlasLoot_AnchorFrame);
            getglobal("AtlasLootItemsFrame_PREV").lootpage="WSGRevered";
            getglobal("AtlasLootItemsFrame_PREV"):Show();
        end
    else
        AtlasLoot_ShowItemsFrame(setid, AtlasLootWorldPvPItems, this.text, AtlasLoot_AnchorFrame);
    end
end

function AtlasLootSetMenu()
    for i = 1, 30, 1 do
        getglobal("AtlasLootItem_"..i):Hide();
    end
    for i = 1, 30, 1 do
        getglobal("AtlasLootMenuItem_"..i):Hide();
    end
    getglobal("AtlasLootItemsFrame_BACK"):Hide();
    getglobal("AtlasLootItemsFrame_Druid"):Hide();
    getglobal("AtlasLootItemsFrame_Hunter"):Hide();
    getglobal("AtlasLootItemsFrame_Mage"):Hide();
    getglobal("AtlasLootItemsFrame_Paladin"):Hide();
    getglobal("AtlasLootItemsFrame_Priest"):Hide();
    getglobal("AtlasLootItemsFrame_Rogue"):Hide();
    getglobal("AtlasLootItemsFrame_Shaman"):Hide();
    getglobal("AtlasLootItemsFrame_Warlock"):Hide();
    getglobal("AtlasLootItemsFrame_Warrior"):Hide();
    getglobal("AtlasLootItemsFrame_Weapons"):Hide();
    getglobal("AtlasLootItemsFrame_NEXT"):Hide();
    getglobal("AtlasLootItemsFrame_PREV"):Hide();
    --Tier 0
    AtlasLootMenuItem_3_Name:SetText(ATLASLOOT_TIER0_SETS);
    AtlasLootMenuItem_3_Extra:SetText("");
    AtlasLootMenuItem_3_Icon:SetTexture("Interface\\Icons\\INV_Chest_Chain_03");
    AtlasLootMenuItem_3.type="Sets";
    AtlasLootMenuItem_3.lootpage="T0SET";
    AtlasLootMenuItem_3:Show();
    --Tier 1
    AtlasLootMenuItem_4_Name:SetText(ATLASLOOT_TIER1_SETS);
    AtlasLootMenuItem_4_Extra:SetText("");
    AtlasLootMenuItem_4_Icon:SetTexture("Interface\\Icons\\INV_Pants_Mail_03");
    AtlasLootMenuItem_4.type="Sets";
    AtlasLootMenuItem_4.lootpage="T1SET";
    AtlasLootMenuItem_4:Show();
    --Tier 2
    AtlasLootMenuItem_5_Name:SetText(ATLASLOOT_TIER2_SETS);
    AtlasLootMenuItem_5_Extra:SetText("");
    AtlasLootMenuItem_5_Icon:SetTexture("Interface\\Icons\\INV_Shoulder_32");
    AtlasLootMenuItem_5.type="Sets";
    AtlasLootMenuItem_5.lootpage="T2SET";
    AtlasLootMenuItem_5:Show();
    --Tier 3
    AtlasLootMenuItem_6_Name:SetText(ATLASLOOT_TIER3_SETS);
    AtlasLootMenuItem_6_Extra:SetText("");
    AtlasLootMenuItem_6_Icon:SetTexture("Interface\\Icons\\INV_Pants_Cloth_05");
    AtlasLootMenuItem_6.type="Sets";
    AtlasLootMenuItem_6.lootpage="T3SET";
    AtlasLootMenuItem_6:Show();
    --ZG
    AtlasLootMenuItem_18_Name:SetText(ATLASLOOT_ZG_SETS);
    AtlasLootMenuItem_18_Extra:SetText("");
    AtlasLootMenuItem_18_Icon:SetTexture("Interface\\Icons\\INV_Jewelry_Necklace_19");
    AtlasLootMenuItem_18.type="Sets";
    AtlasLootMenuItem_18.lootpage="ZGSET";
    AtlasLootMenuItem_18:Show();
    --AQ20
    AtlasLootMenuItem_19_Name:SetText(ATLASLOOT_AQ20_SETS);
    AtlasLootMenuItem_19_Extra:SetText("");
    AtlasLootMenuItem_19_Icon:SetTexture("Interface\\Icons\\INV_Jewelry_Ring_AhnQiraj_03");
    AtlasLootMenuItem_19.type="Sets";
    AtlasLootMenuItem_19.lootpage="AQ20SET";
    AtlasLootMenuItem_19:Show();
    --AQ40
    AtlasLootMenuItem_20_Name:SetText(ATLASLOOT_AQ40_SETS);
    AtlasLootMenuItem_20_Extra:SetText("");
    AtlasLootMenuItem_20_Icon:SetTexture("Interface\\Icons\\INV_Sword_59");
    AtlasLootMenuItem_20.type="Sets";
    AtlasLootMenuItem_20.lootpage="AQ40SET";
    AtlasLootMenuItem_20:Show();
    --PvP
    AtlasLootMenuItem_21_Name:SetText(ATLASLOOT_PVP_SETS);
    AtlasLootMenuItem_21_Extra:SetText("");
    AtlasLootMenuItem_21_Icon:SetTexture("Interface\\Icons\\INV_Axe_02");
    AtlasLootMenuItem_21.type="Sets";
    AtlasLootMenuItem_21.lootpage="PVPSET";
    AtlasLootMenuItem_21:Show();
    --Legendaries
    AtlasLootMenuItem_22_Name:SetText(ATLASLOOT_LEGENDARIES);
    AtlasLootMenuItem_22_Extra:SetText("");
    AtlasLootMenuItem_22_Icon:SetTexture("Interface\\Icons\\INV_Staff_Medivh");
    AtlasLootMenuItem_22.type="Sets";
    AtlasLootMenuItem_22.lootpage="Legendaries";
    AtlasLootMenuItem_22:Show();
    AtlasLoot_BossName:SetText("|cffFFFFFF"..ATLASLOOT_PANEL_BUTTON_SETS);
    AtlasLoot_SetItemInfoFrame(AtlasLoot_AnchorFrame);
end

function AtlasLootRepMenu()
    for i = 1, 30, 1 do
        getglobal("AtlasLootItem_"..i):Hide();
    end
    for i = 1, 30, 1 do
        getglobal("AtlasLootMenuItem_"..i):Hide();
    end
    getglobal("AtlasLootItemsFrame_BACK"):Hide();
    getglobal("AtlasLootItemsFrame_Druid"):Hide();
    getglobal("AtlasLootItemsFrame_Hunter"):Hide();
    getglobal("AtlasLootItemsFrame_Mage"):Hide();
    getglobal("AtlasLootItemsFrame_Paladin"):Hide();
    getglobal("AtlasLootItemsFrame_Priest"):Hide();
    getglobal("AtlasLootItemsFrame_Rogue"):Hide();
    getglobal("AtlasLootItemsFrame_Shaman"):Hide();
    getglobal("AtlasLootItemsFrame_Warlock"):Hide();
    getglobal("AtlasLootItemsFrame_Warrior"):Hide();
    getglobal("AtlasLootItemsFrame_Weapons"):Hide();
    getglobal("AtlasLootItemsFrame_NEXT"):Hide();
    getglobal("AtlasLootItemsFrame_PREV"):Hide();
    --Argent Dawn
    AtlasLootMenuItem_2_Name:SetText(ATLASLOOT_FACTION_ARGENT);
    AtlasLootMenuItem_2_Extra:SetText("");
    AtlasLootMenuItem_2_Icon:SetTexture("Interface\\Icons\\INV_Jewelry_Talisman_08");
    AtlasLootMenuItem_2.type="Factions";
    AtlasLootMenuItem_2.lootpage="Argent1";
    AtlasLootMenuItem_2.text=ATLASLOOT_FACTION_ARGENT;
    AtlasLootMenuItem_2:Show();
    --Thorium Brotherhood
    AtlasLootMenuItem_3_Name:SetText(ATLASLOOT_FACTION_THORIUM);
    AtlasLootMenuItem_3_Extra:SetText("");
    AtlasLootMenuItem_3_Icon:SetTexture("Interface\\Icons\\INV_Ingot_Mithril");
    AtlasLootMenuItem_3.type="Factions";
    AtlasLootMenuItem_3.lootpage="Thorium1";
    AtlasLootMenuItem_3.text=ATLASLOOT_FACTION_THORIUM;
    AtlasLootMenuItem_3:Show();
    --Cenarion Hold
    AtlasLootMenuItem_4_Name:SetText(ATLASLOOT_FACTION_CENARION);
    AtlasLootMenuItem_4_Extra:SetText("");
    AtlasLootMenuItem_4_Icon:SetTexture("Interface\\Icons\\INV_Chest_Plate07");
    AtlasLootMenuItem_4.type="Factions";
    AtlasLootMenuItem_4.lootpage="Cenarion1";
    AtlasLootMenuItem_4.text=ATLASLOOT_FACTION_CENARION;
    AtlasLootMenuItem_4:Show();
    --Zandalar Tribe
    AtlasLootMenuItem_5_Name:SetText(ATLASLOOT_FACTION_ZANDALAR);
    AtlasLootMenuItem_5_Extra:SetText("");
    AtlasLootMenuItem_5_Icon:SetTexture("Interface\\Icons\\INV_Misc_Coin_08");
    AtlasLootMenuItem_5.type="Factions";
    AtlasLootMenuItem_5.lootpage="Zandalar1";
    AtlasLootMenuItem_5.text=ATLASLOOT_FACTION_ZANDALAR;
    AtlasLootMenuItem_5:Show();
    --Kurenai
    --AtlasLootMenuItem_6_Name:SetText(ATLASLOOT_FACTION_KURENAI);
    --AtlasLootMenuItem_6_Extra:SetText("");
    --AtlasLootMenuItem_6_Icon:SetTexture("Interface\\Icons\\INV_Misc_Foot_Centaur");
    --AtlasLootMenuItem_6.type="Factions";
    --AtlasLootMenuItem_6.lootpage="Kurenai1";
    --AtlasLootMenuItem_6.text=ATLASLOOT_FACTION_KURENAI;
    --AtlasLootMenuItem_6:Show();
    --Honor Hold
    --AtlasLootMenuItem_7_Name:SetText(ATLASLOOT_FACTION_HONOR_HOLD);
    --AtlasLootMenuItem_7_Extra:SetText("");
    --AtlasLootMenuItem_7_Icon:SetTexture("Interface\\Icons\\INV_BannerPVP_02");
    --AtlasLootMenuItem_7.type="Factions";
    --AtlasLootMenuItem_7.lootpage="HonorHold1";
    --AtlasLootMenuItem_7.text=ATLASLOOT_FACTION_HONOR_HOLD;
    --AtlasLootMenuItem_7:Show();
    --The Aldor
    --AtlasLootMenuItem_8_Name:SetText(ATLASLOOT_FACTION_ALDOR);
    --AtlasLootMenuItem_8_Extra:SetText("");
    --AtlasLootMenuItem_8_Icon:SetTexture("Interface\\Icons\\Spell_Holy_SealOfSalvation");
    --AtlasLootMenuItem_8.type="Factions";
    --AtlasLootMenuItem_8.lootpage="Aldor1";
    --AtlasLootMenuItem_8.text=ATLASLOOT_FACTION_ALDOR;
    --AtlasLootMenuItem_8:Show();
    --The Tranquillien
    --AtlasLootMenuItem_9_Name:SetText(ATLASLOOT_FACTION_TRANQ);
    --AtlasLootMenuItem_9_Extra:SetText("");
    --AtlasLootMenuItem_9_Icon:SetTexture("Interface\\Icons\\INV_Misc_Bandana_03");
    --AtlasLootMenuItem_9.type="Factions";
    --AtlasLootMenuItem_9.lootpage="Tranquillien1";
    --AtlasLootMenuItem_9.text=ATLASLOOT_FACTION_TRANQ;
    --AtlasLootMenuItem_9:Show();
    --The Timbermaw
    AtlasLootMenuItem_17_Name:SetText(ATLASLOOT_FACTION_TIMBERMAW);
    AtlasLootMenuItem_17_Extra:SetText("");
    AtlasLootMenuItem_17_Icon:SetTexture("Interface\\Icons\\INV_Misc_Horn_01");
    AtlasLootMenuItem_17.type="Factions";
    AtlasLootMenuItem_17.lootpage="Timbermaw";
    AtlasLootMenuItem_17.text=ATLASLOOT_FACTION_TIMBERMAW;
    AtlasLootMenuItem_17:Show();
    --Darkmoon Faire
    AtlasLootMenuItem_18_Name:SetText(ATLASLOOT_FACTION_DARKMOON);
    AtlasLootMenuItem_18_Extra:SetText("");
    AtlasLootMenuItem_18_Icon:SetTexture("Interface\\Icons\\INV_Misc_Ticket_Tarot_Maelstrom_01");
    AtlasLootMenuItem_18.type="Factions";
    AtlasLootMenuItem_18.lootpage="Darkmoon";
    AtlasLootMenuItem_18.text=ATLASLOOT_FACTION_DARKMOON;
    AtlasLootMenuItem_18:Show();
    --Brood of Nozdormu
    AtlasLootMenuItem_19_Name:SetText(ATLASLOOT_FACTION_BROOD);
    AtlasLootMenuItem_19_Extra:SetText("");
    AtlasLootMenuItem_19_Icon:SetTexture("Interface\\Icons\\INV_Jewelry_Ring_40");
    AtlasLootMenuItem_19.type="Factions";
    AtlasLootMenuItem_19.lootpage="AQBroodRings";
    AtlasLootMenuItem_19.text=ATLASLOOT_FACTION_BROOD;
    AtlasLootMenuItem_19:Show();
    --Cenarion Expedition
    --AtlasLootMenuItem_20_Name:SetText(ATLASLOOT_FACTION_CENARION_EXPEDITION);
    --AtlasLootMenuItem_20_Extra:SetText("");
    --AtlasLootMenuItem_20_Icon:SetTexture("Interface\\Icons\\INV_Misc_Ammo_Arrow_02");
    --AtlasLootMenuItem_20.type="Factions";
    --AtlasLootMenuItem_20.lootpage="CExpedition1";
    --AtlasLootMenuItem_20.text=ATLASLOOT_FACTION_CENARION_EXPEDITION;
    --AtlasLootMenuItem_20:Show();
    --Sporeggar
    --AtlasLootMenuItem_21_Name:SetText(ATLASLOOT_FACTION_SPOREGGAR);
    --AtlasLootMenuItem_21_Extra:SetText("");
    --AtlasLootMenuItem_21_Icon:SetTexture("Interface\\Icons\\INV_Mushroom_10");
    --AtlasLootMenuItem_21.type="Factions";
    --AtlasLootMenuItem_21.lootpage="Sporeggar1";
    --AtlasLootMenuItem_21.text=ATLASLOOT_FACTION_SPOREGGAR;
    --AtlasLootMenuItem_21:Show();
    --Thrallmar
    --AtlasLootMenuItem_22_Name:SetText(ATLASLOOT_FACTION_THRALLMAR);
    --AtlasLootMenuItem_22_Extra:SetText("");
    --AtlasLootMenuItem_22_Icon:SetTexture("Interface\\Icons\\INV_BannerPVP_01");
    --AtlasLootMenuItem_22.type="Factions";
    --AtlasLootMenuItem_22.lootpage="Thrallmar1";
    --AtlasLootMenuItem_22.text=ATLASLOOT_FACTION_THRALLMAR;
    --AtlasLootMenuItem_22:Show();
    --The Scryers
    --AtlasLootMenuItem_23_Name:SetText(ATLASLOOT_FACTION_SCRYER);
    --AtlasLootMenuItem_23_Extra:SetText("");
    --AtlasLootMenuItem_23_Icon:SetTexture("Interface\\Icons\\Spell_Holy_ChampionsBond");
    --AtlasLootMenuItem_23.type="Factions";
    --AtlasLootMenuItem_23.lootpage="Scryer1";
    --AtlasLootMenuItem_23.text=ATLASLOOT_FACTION_SCRYER;
    --AtlasLootMenuItem_23:Show();
    --The Mag'har
    --AtlasLootMenuItem_24_Name:SetText(ATLASLOOT_FACTION_MAGHAR);
    --AtlasLootMenuItem_24_Extra:SetText("");
    --AtlasLootMenuItem_24_Icon:SetTexture("Interface\\Icons\\INV_Misc_Foot_Centaur");
    --AtlasLootMenuItem_24.type="Factions";
    --AtlasLootMenuItem_24.lootpage="Maghar1";
    --AtlasLootMenuItem_24.text=ATLASLOOT_FACTION_MAGHAR;
    --AtlasLootMenuItem_24:Show();
    AtlasLoot_BossName:SetText("|cffFFFFFF"..ATLASLOOT_PANEL_BUTTON_REPUTATION);
    AtlasLoot_SetItemInfoFrame(AtlasLoot_AnchorFrame);
end

function AtlasLootPvPMenu()
    for i = 1, 30, 1 do
        getglobal("AtlasLootItem_"..i):Hide();
    end
    for i = 1, 30, 1 do
        getglobal("AtlasLootMenuItem_"..i):Hide();
    end
    getglobal("AtlasLootItemsFrame_BACK"):Hide();
    getglobal("AtlasLootItemsFrame_Druid"):Hide();
    getglobal("AtlasLootItemsFrame_Hunter"):Hide();
    getglobal("AtlasLootItemsFrame_Mage"):Hide();
    getglobal("AtlasLootItemsFrame_Paladin"):Hide();
    getglobal("AtlasLootItemsFrame_Priest"):Hide();
    getglobal("AtlasLootItemsFrame_Rogue"):Hide();
    getglobal("AtlasLootItemsFrame_Shaman"):Hide();
    getglobal("AtlasLootItemsFrame_Warlock"):Hide();
    getglobal("AtlasLootItemsFrame_Warrior"):Hide();
    getglobal("AtlasLootItemsFrame_Weapons"):Hide();
    getglobal("AtlasLootItemsFrame_NEXT"):Hide();
    getglobal("AtlasLootItemsFrame_PREV"):Hide();
    --Alterac Valley
    AtlasLootMenuItem_1_Name:SetText(ATLASLOOT_FACTION_ALTERAC);
    AtlasLootMenuItem_1_Extra:SetText("");
    AtlasLootMenuItem_1_Icon:SetTexture("Interface\\Icons\\INV_Jewelry_Necklace_21");
    AtlasLootMenuItem_1.type="PvP";
    AtlasLootMenuItem_1.lootpage="AVFriendly";
    AtlasLootMenuItem_1.text=ATLASLOOT_FACTION_ALTERAC;
    AtlasLootMenuItem_1:Show();
    --Arathi Basin
    AtlasLootMenuItem_2_Name:SetText(ATLASLOOT_FACTION_ARATHI);
    AtlasLootMenuItem_2_Extra:SetText("");
    AtlasLootMenuItem_2_Icon:SetTexture("Interface\\Icons\\INV_Jewelry_Amulet_07");
    AtlasLootMenuItem_2.type="PvP";
    AtlasLootMenuItem_2.lootpage="ABFriendly";
    AtlasLootMenuItem_2.text=ATLASLOOT_FACTION_ARATHI;
    AtlasLootMenuItem_2:Show();
    --Hellfire Alliance
    --AtlasLootMenuItem_4_Name:SetText(ATLASLOOT_ZONE_HELLFIRE);
    --AtlasLootMenuItem_4_Extra:SetText(ATLASLOOT_ZONE_HELLFIRE_W_PVP_AL);
    --AtlasLootMenuItem_4_Icon:SetTexture("Interface\\Icons\\INV_Misc_Token_HonorHold");
    --AtlasLootMenuItem_4.type="PvP";
    --AtlasLootMenuItem_4.lootpage="HellAlliance";
    --AtlasLootMenuItem_4.text=ATLASLOOT_ZONE_HELLFIRE_W_PVP_AL;
    --AtlasLootMenuItem_4:Show();
    --Zangarmarsh
    --AtlasLootMenuItem_5_Name:SetText(ATLASLOOT_ZONE_ZANGAR);
    --AtlasLootMenuItem_5_Extra:SetText(ATLASLOOT_ZONE_ZANGAR_W_PVP);
    --AtlasLootMenuItem_5_Icon:SetTexture("Interface\\Icons\\Spell_Nature_ElementalPrecision_1");
    --AtlasLootMenuItem_5.type="PvP";
    --AtlasLootMenuItem_5.lootpage="Zangarmarsh";
    --AtlasLootMenuItem_5.text=ATLASLOOT_ZONE_ZANGAR_W_PVP;
    --AtlasLootMenuItem_5:Show();
    --Nagrand
    --AtlasLootMenuItem_6_Name:SetText(ATLASLOOT_ZONE_NAGRAND);
    --AtlasLootMenuItem_6_Extra:SetText(ATLASLOOT_ZONE_NAGRAND_W_PVP);
    --AtlasLootMenuItem_6_Icon:SetTexture("Interface\\Icons\\INV_Misc_Rune_09");
    --AtlasLootMenuItem_6.type="PvP";
    --AtlasLootMenuItem_6.lootpage="Nagrand";
    --AtlasLootMenuItem_6.text=ATLASLOOT_ZONE_NAGRAND_W_PVP;
    --AtlasLootMenuItem_6:Show();
    --Warsong Gulch
    AtlasLootMenuItem_16_Name:SetText(ATLASLOOT_FACTION_WARSONG);
    AtlasLootMenuItem_16_Extra:SetText("");
    AtlasLootMenuItem_16_Icon:SetTexture("Interface\\Icons\\INV_Misc_Rune_07");
    AtlasLootMenuItem_16.type="PvP";
    AtlasLootMenuItem_16.lootpage="WSGFriendly";
    AtlasLootMenuItem_16.text=ATLASLOOT_FACTION_WARSONG;
    AtlasLootMenuItem_16:Show();
    --Hellfire Horde
    --AtlasLootMenuItem_19_Name:SetText(ATLASLOOT_ZONE_HELLFIRE);
    --AtlasLootMenuItem_19_Extra:SetText(ATLASLOOT_ZONE_HELLFIRE_W_PVP_HO);
    --AtlasLootMenuItem_19_Icon:SetTexture("Interface\\Icons\\INV_Misc_Token_Thrallmar");
    --AtlasLootMenuItem_19.type="PvP";
    --AtlasLootMenuItem_19.lootpage="HellHorde";
    --AtlasLootMenuItem_19.text=ATLASLOOT_ZONE_HELLFIRE_W_PVP_HO;
    --AtlasLootMenuItem_19:Show();
    --Terokkar Forest
    --AtlasLootMenuItem_20_Name:SetText(ATLASLOOT_ZONE_TEROKKAR);
    --AtlasLootMenuItem_20_Extra:SetText(ATLASLOOT_ZONE_TEROKKAR_W_PVP);
    --AtlasLootMenuItem_20_Icon:SetTexture("Interface\\Icons\\INV_Jewelry_FrostwolfTrinket_04");
    --AtlasLootMenuItem_20.type="PvP";
    --AtlasLootMenuItem_20.lootpage="Terokkar";
    --AtlasLootMenuItem_20.text=ATLASLOOT_ZONE_TEROKKAR_W_PVP;
    --AtlasLootMenuItem_20:Show();
    AtlasLoot_BossName:SetText("|cffFFFFFF"..ATLASLOOT_PANEL_BUTTON_PVP);
    AtlasLoot_SetItemInfoFrame(AtlasLoot_AnchorFrame);
end

function AtlasLootMenuItem_OnClick()
    if this.type=="Factions" then
        AtlasLootRepButton_OnClick(this.lootpage, this.text);
    elseif this.type=="Sets" then
        AtlasLootSetButton_OnClick(this.lootpage);
    elseif this.type=="PvP" then
        AtlasLootPvPButton_OnClick(this.lootpage);
    end
end

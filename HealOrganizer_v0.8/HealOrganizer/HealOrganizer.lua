local L = AceLibrary("AceLocale-2.1"):GetInstance("HealOrganizer", true)

local options = {
    type = 'group',
    args = {
        show = {
            type = 'execute',
            name = 'Show Dialog',
            desc = L["SHOW_DIALOG"],
            func = 'ShowDialog'
        },
        autosort = {
            type = 'toggle',
            name = 'Autosort',
            desc = L["AUTOSORT_DESC"],
            get = function() return HealOrganizer.db.char.autosort end,
            set = function() HealOrganizer.db.char.autosort = not HealOrganizer.db.char.autosort end
        }
    }
}
-- units
-- healer["raid3"] = "Rest"
-- Werte: Rest, 1, 2, 3, 4, 5, 6, 7, 8, 9
local healer = {
}
local position = {
}
local overrideSort = false
local lastAction = {
    unit = {},
    position = {},
    group = {},
}

local einteilung = {
    Rest = {},
    [1] = {},
    [2] = {},
    [3] = {},
    [4] = {},
    [5] = {},
    [6] = {},
    [7] = {},
    [8] = {},
    [9] = {},
}
local stats = {
    DRUID = 0,
    PRIEST = 0,
    PALADIN = 0,
    SHAMAN = 0,
}

local current_set = L["SET_DEFAULT"]

local grouplabels = {
    Rest = "GROUP_LOCALE_REMAINS",
    [1] = "GROUP_LOCALE_1",
    [2] = "GROUP_LOCALE_2",
    [3] = "GROUP_LOCALE_3",
    [4] = "GROUP_LOCALE_4",
    [5] = "GROUP_LOCALE_5",
    [6] = "GROUP_LOCALE_6",
    [7] = "GROUP_LOCALE_7",
    [8] = "GROUP_LOCALE_8",
    [9] = "GROUP_LOCALE_9",
}

local change_id = 0

-- button level speichern
local level_of_button = -1;


HealOrganizer = AceLibrary("AceAddon-2.0"):new("AceConsole-2.0", "AceDebug-2.0", "AceDB-2.0")
HealOrganizer:RegisterChatCommand({"/healorganizer", "/hlorg"}, options)
HealOrganizer:RegisterDB("HealOrganizerDB", "HealOrganizerDBPerChar")
HealOrganizer:RegisterDefaults('char', {
    chan = "",
    autosort = true,
})
HealOrganizer:RegisterDefaults('account', {
    sets = {
        [L["SET_DEFAULT"]] = {
            Name = L["SET_DEFAULT"],
            Rest = L["REMAINS"],
            [1] = L["MT"].."1",
            [2] = L["MT"].."2",
            [3] = L["MT"].."3",
            [4] = L["MT"].."4",
            [5] = L["MT"].."5",
            [6] = L["MT"].."6",
            [7] = L["MT"].."7",
            [8] = L["MT"].."8",
            [9] = L["DISPEL"],
        },
    }
})

function HealOrganizer:OnInitialize() -- {{{
    -- Called when the addon is loaded
    --self:SetDebugging(true)
    StaticPopupDialogs["HEALORGANIZER_EDITLABEL"] = { --{{{
        text = L["EDIT_LABEL"],
        button1 = TEXT(SAVE),
        button2 = TEXT(CANCEL),
        OnAccept = function(a,b,c)
            -- button gedrueckt, auf GetName/GetParent achten
            self:Debug("accept gedrueckt")
            self:Debug(a)
            self:Debug(b)
            self:Debug(c)
            self:Debug(this:GetParent():GetName())
            self:Debug(this:GetParent():GetName().."EditBox")
            self:Debug(getglobal(this:GetParent():GetName()):GetName())
            self:Debug(getglobal(this:GetParent():GetName().."EditBox"):GetText())
            self:Debug("ID ist "..change_id)
            self:SaveNewLabel(change_id, getglobal(this:GetParent():GetName().."EditBox"):GetText())
        end,
        OnHide = function()
            getglobal(this:GetName().."EditBox"):SetText("")
        end,
        OnShow = function()
            if grouplabels[change_id] ~= nil then
                getglobal(this:GetName().."EditBox"):SetText(grouplabels[change_id])
            end
        end,
	EditBoxOnEnterPressed = function()
            self:SaveNewLabel(change_id, this:GetText())
            this:GetParent():Hide()
        end,
        EditBoxOnEscapePressed = function()
            this:GetParent():Hide();
        end,
        timeout = 0,
        whileDead = 1,
        hideOnEscape = 1,
        hasEditBox = 1,
    }; --}}}
    StaticPopupDialogs["HEALORGANIZER_SETSAVEAS"] = { --{{{
        text = L["SET_SAVEAS"],
        button1 = TEXT(SAVE),
        button2 = TEXT(CANCEL),
        OnAccept = function()
            -- button gedrueckt, auf GetName/GetParent achten
            self:SetSaveAs(getglobal(this:GetParent():GetName().."EditBox"):GetText())
        end,
        OnHide = function()
            getglobal(this:GetName().."EditBox"):SetText("")
        end,
        OnShow = function()
        end,
	EditBoxOnEnterPressed = function()
            self:SetSaveAs(getglobal(this:GetParent():GetName().."EditBox"):GetText())
            this:GetParent():Hide()
        end,
        EditBoxOnEscapePressed = function()
            this:GetParent():Hide();
        end,
        timeout = 0,
        whileDead = 1,
        hideOnEscape = 1,
        hasEditBox = 1,
    }; --}}}
    current_set = L["SET_DEFAULT"]

    self:Debug("starte locale")
    -- dialog labels aus locale einstellen {{{
    
    HealOrganizerDialogEinteilungTitle:SetText(L["ARRANGEMENT"])
    --
    --HealOrganizerDialogEinteilungHealerpoolLabel:SetText(L["REMAINS"])
    for i=1, 20 do
        getglobal("HealOrganizerDialogEinteilungHealerpoolSlot"..i.."Label"):SetText(L["FREE"])
    end
    for j=1, 9 do
        for i=1, 4 do
            getglobal("HealOrganizerDialogEinteilungHealGroup"..j.."Slot"..i.."Label"):SetText(L["FREE"])
        end
    end
    HealOrganizerDialogEinteilungOptionenTitle:SetText(L["OPTIONS"])
    HealOrganizerDialogEinteilungOptionenDecurseText:SetText(L["DECURSE"])
    HealOrganizerDialogEinteilungOptionenHealText:SetText(L["HEAL"])
    HealOrganizerDialogEinteilungStatsTitle:SetText(L["STATS"])
    HealOrganizerDialogEinteilungStatsPriests:SetText(L["PRIESTS"]..": "..5)
    HealOrganizerDialogEinteilungStatsPriests:SetTextColor(RAID_CLASS_COLORS["PRIEST"].r,
                                                           RAID_CLASS_COLORS["PRIEST"].g,
                                                           RAID_CLASS_COLORS["PRIEST"].b)
    HealOrganizerDialogEinteilungStatsDruids:SetText(L["DRUIDS"]..": "..6)
    HealOrganizerDialogEinteilungStatsDruids:SetTextColor(RAID_CLASS_COLORS["DRUID"].r,
                                                          RAID_CLASS_COLORS["DRUID"].g,
                                                          RAID_CLASS_COLORS["DRUID"].b)
    self:Debug(UnitFactionGroup("player"))
    local faction = UnitFactionGroup("player")
    if faction == "Alliance" then
        HealOrganizerDialogEinteilungStatsHybrids:SetText(L["PALADINS"]..": "..5)
        HealOrganizerDialogEinteilungStatsHybrids:SetTextColor(RAID_CLASS_COLORS["PALADIN"].r,
                                                               RAID_CLASS_COLORS["PALADIN"].g,
                                                               RAID_CLASS_COLORS["PALADIN"].b)
    else
        HealOrganizerDialogEinteilungStatsHybrids:SetText(L["SHAMANS"]..": "..5)
        HealOrganizerDialogEinteilungStatsHybrids:SetTextColor(RAID_CLASS_COLORS["SHAMAN"].r,
                                                               RAID_CLASS_COLORS["SHAMAN"].g,
                                                               RAID_CLASS_COLORS["SHAMAN"].b)
    end
    HealOrganizerDialogEinteilungSetsTitle:SetText(L["LABELS"])
    HealOrganizerDialogEinteilungSetsSave:SetText(TEXT(SAVE))
    HealOrganizerDialogEinteilungSetsSaveAs:SetText(L["SAVEAS"])
    HealOrganizerDialogEinteilungSetsDelete:SetText(TEXT(DELETE))
    HealOrganizerDialogBroadcastTitle:SetText(L["BROADCAST"])
    HealOrganizerDialogBroadcastChannel:SetText(L["CHANNEL"])
    HealOrganizerDialogBroadcastRaid:SetText(L["RAID"])
    HealOrganizerDialogClose:SetText(L["CLOSE"])
    HealOrganizerDialogReset:SetText(L["RESET"])
    -- }}}
    self:Debug("locale zuende")
    self:Debug("channel aus der DB ist gesetzt auf: \""..self.db.char.chan.."\"")
    -- standard fuer dropdown setzen
    UIDropDownMenu_SetSelectedValue(HealOrganizerDialogEinteilungSetsDropDown, L["SET_DEFAULT"], L["SET_DEFAULT"]); 
    self:LoadCurrentLabels()
    self:UpdateDialogValues()
end -- }}}

function HealOrganizer:OnEnable() -- {{{
    -- Called when the addon is enabled
end -- }}}

function HealOrganizer:OnDisable() -- {{{
    -- Called when the addon is disabled
end -- }}}

function HealOrganizer:RefreshTables() --{{{
    self:Debug("aktuallisiere tabellen")
    stats = {
        DRUID = 0,
        PRIEST = 0,
        PALADIN = 0,
        SHAMAN = 0,
    }
    local gruppen = {
        Rest = 0,
        [1] = 0,
        [2] = 0,
        [3] = 0,
        [4] = 0,
        [5] = 0,
        [6] = 0,
        [7] = 0,
        [8] = 0,
        [9] = 0,
    }
    -- heiler suchen
    for i=1, MAX_RAID_MEMBERS do
        if not UnitExists("raid"..i) then
            -- kein mitglied, also auch kein heiler
            healer["raid"..i] = nil
        else
            -- prüfen ob er ein heiler ist
            local class,engClass = UnitClass("raid"..i)
            if engClass == "DRUID" or engClass == "PRIEST" or
                    engClass == "PALADIN" or engClass == "SHAMAN" then
                -- ist ein heiler, aber schon eingeteilt?
                if healer["raid"..i] then
                    -- schon eingeteilt, nichts machen
                    if healer["raid"..i] ~= "Rest" then
                        if gruppen[healer["raid"..i]] >= 4 then
                            -- schon zu viele, mach ihm zum rest
                            healer["raid"..i] = "Rest"
                        end
                    end
                else
                    -- nicht eingeteilt, neu, "rest"
                    healer["raid"..i] = "Rest"
                    position["raid"..i] = 0
                end
                self:Debug(healer["raid"..i])
                gruppen[healer["raid"..i]] = gruppen[healer["raid"..i]] + 1
                stats[engClass] = stats[engClass] + 1                
            else
            -- ist kein heiler, nil
            healer["raid"..i] = nil
            end
        end
    end
    self:Debug("stats generiert")
    self:Debug("healertabelle aktuallisiert")
    -- healer[...] -> einteilungsarray
    -- einteilung resetten
    einteilung = {
        Rest = {},
        [1] = {},
        [2] = {},
        [3] = {},
        [4] = {},
        [5] = {},
        [6] = {},
        [7] = {},
        [8] = {},
        [9] = {},
    }
    for unit, ort in pairs(healer) do
        table.insert(einteilung[ort], unit)    
    end
    self:Debug("einteilungstabelle aktuallisiert")
    -- einteilungstabelle sortieren (Klasse, Name)
    local function SortEinteilung(a, b) --{{{
        if (self.db.char.autosort or overrideSort) then
            --[[
            -- Priester,
            -- Druiden,
            -- Paladine,
            -- Schamanen,
            --    NameA,
            --    NameZ
            --]]
            local classA, engClassA = UnitClass(a)
            local classB, engClassB = UnitClass(b)
            if engClassA ~= engClassB then
                    -- unterscheidung an der Klasse
                    -- ecken abfangen
                    if engClassA == "PRIEST" then -- (Priest, *)
                            return true
                    end
                    if engClassB == "PRIEST" then -- (*, Priest)
                            return false
                    end
                    if engClassB == "SHAMAN" then -- (*, Shaman)
                            return true
                    end
                    if engClassA == "SHAMAN" then -- (Shaman, *)
                            return false
                    end
                    -- inneren zwei
                    if engClassA == "DRUID" then -- (Druid, *)
                            return true
                    end
                    if engClassB == "DRUID" then -- (*, Druid)
                            return false
                    end
                    if engClassB == "PALADIN" then -- (*, Paladin)
                            return true
                    end
                    if engClassA == "PALADIN" then -- (Paladin, *)
                            return false
                    end
            else
                    -- klassen sind gleich, nach namen sortieren
                    local nameA = UnitName(a)
                    local nameB = UnitName(b)
                    return a<b
            end
            return true
	else 
            if (position[a] and position[b]) then
                self:Debug("sortdebug: ("..a..")"..position[a].." < ("..b..")"..position[b])
                if position[a] == position[b] and lastAction["position"] then
                    if lastAction["position"] == 0 then
                        if a == lastAction["unit"] then -- Spieler a wurde verschoben
                            self:Debug("sortdebug: a aus anderer grp - nach unten verschieben")
                            return true
                        elseif b == lastAction["unit"] then -- Spieler b wurde verschoben
                            self:Debug("sortdebug: b aus anderer grp - nach unten verschieben")
                            return false
                        end
                        return true
                    end
                    --Sonderfall - kann nur eintreten wenn ein Spieler AUF einen anderen gezogen wurde - also hier in die Richtung verschieben aus der der alte Spieler kommt
                    --lastAction ist die letzte Aktion die ausgefuehrt wurde + Position von der bewegt wurde
                    if a == lastAction["unit"] then -- Spieler a wurde verschoben
                        if lastAction["position"] > position[a] then-- kommt von Unten
                            self:Debug("sortdebug: a, von unten")
                            return true
                        else
                            self:Debug("sortdebug: a, von oben")
                            return false
                        end
                    elseif b == lastAction["unit"] then -- Spieler b wurde verschoben
                        if lastAction["position"] > position[b] then-- kommt von Unten
                            self:Debug("sortdebug: b, von unten")
                            return false
                        else
                            self:Debug("sortdebug: b, von oben")
                            return true
                        end
                    end
                end
                return position[a] < position[b] 
            end
            return true
        end
    end --}}}
    for key, tab in pairs(einteilung) do
        if key == "Rest" then --Nicht zugeordnete Heiler werden immer sortiert
                overrideSort = true
        end
        table.sort(einteilung[key], SortEinteilung)
        --Positionen entsprechend dem Index updaten 
        for index,unit in pairs(einteilung[key]) do
                position[unit] = index
        end
        overrideSort = false
    end
end -- }}}

function HealOrganizer:ShowDialog() -- {{{
    self:UpdateDialogValues()
    self:Debug("Zeige dialog")
    HealOrganizerDialog:Show()
end -- }}}

function HealOrganizer:UpdateDialogValues() -- {{{
    self:RefreshTables()
    -- stats aktuallisieren {{{
    HealOrganizerDialogEinteilungStatsPriests:SetText(L["PRIESTS"]..": "..stats["PRIEST"])
    HealOrganizerDialogEinteilungStatsPriests:SetTextColor(RAID_CLASS_COLORS["PRIEST"].r,
                                                           RAID_CLASS_COLORS["PRIEST"].g,
                                                           RAID_CLASS_COLORS["PRIEST"].b)
    HealOrganizerDialogEinteilungStatsDruids:SetText(L["DRUIDS"]..": "..stats["DRUID"])
    HealOrganizerDialogEinteilungStatsDruids:SetTextColor(RAID_CLASS_COLORS["DRUID"].r,
                                                          RAID_CLASS_COLORS["DRUID"].g,
                                                          RAID_CLASS_COLORS["DRUID"].b)
    self:Debug(UnitFactionGroup("player"))
    local faction = UnitFactionGroup("player")
    if faction == "Alliance" then
        HealOrganizerDialogEinteilungStatsHybrids:SetText(L["PALADINS"]..": "..stats["PALADIN"])
        HealOrganizerDialogEinteilungStatsHybrids:SetTextColor(RAID_CLASS_COLORS["PALADIN"].r,
                                                               RAID_CLASS_COLORS["PALADIN"].g,
                                                               RAID_CLASS_COLORS["PALADIN"].b)
    else
        HealOrganizerDialogEinteilungStatsHybrids:SetText(L["SHAMANS"]..": "..stats["SHAMAN"])
        HealOrganizerDialogEinteilungStatsHybrids:SetTextColor(RAID_CLASS_COLORS["SHAMAN"].r,
                                                               RAID_CLASS_COLORS["SHAMAN"].g,
                                                               RAID_CLASS_COLORS["SHAMAN"].b)
    end
    -- }}}
    -- {{{ gruppen-labels aktuallisieren
    HealOrganizerDialogEinteilungHealerpoolLabel:SetText(grouplabels["Rest"])
    for i=1,9 do
        getglobal("HealOrganizerDialogEinteilungHealGroup"..i.."Label"):SetText(grouplabels[i])
    end
    -- }}}
    HealOrganizerDialogBroadcastChannelEditbox:SetText(self.db.char.chan)
    -- einteilungen aktuallisieren -- {{{
    -- alle buttons verstecken
    for i=1, 20 do
        getglobal("HealOrganizerDialogButton"..i):ClearAllPoints()
        getglobal("HealOrganizerDialogButton"..i):Hide()
    end
    local zaehler = 1
    -- Rest {{{
    for i=1, table.getn(einteilung.Rest) do
        -- max 20 durchläufe
        if zaehler > 20 then
            -- zu viel, abbrechen
            break
        end
        local button = getglobal("HealOrganizerDialogButton"..zaehler)
        local buttonlabel = getglobal(button:GetName().."Label")
        local buttoncolor = getglobal(button:GetName().."Color")
        -- habe den Button an sich, das Label und die Farbe, einstellen
        buttonlabel:SetText(UnitName(einteilung.Rest[i]))
        local class, engClass = UnitClass(einteilung.Rest[i])
        local color = RAID_CLASS_COLORS[engClass];
        if color then
            buttoncolor:SetTexture(color.r, color.g, color.b)
        end
        -- ancher und position einstellen
        button:SetPoint("TOP", "HealOrganizerDialogEinteilungHealerpoolSlot"..i)
        button:Show()
        -- RaidID im button speichern
        button.raidID = einteilung.Rest[i]
        zaehler = zaehler + 1
    end
    -- }}}
    -- MTs {{{
    for j=1,9 do
        for i=1, table.getn(einteilung[j]) do
            -- max 20 durchläufe
            if zaehler > 20 then
                -- zu viel, abbrechen
                break
            end
            local button = getglobal("HealOrganizerDialogButton"..zaehler)
            local buttonlabel = getglobal(button:GetName().."Label")
            local buttoncolor = getglobal(button:GetName().."Color")
            -- habe den Button an sich, das Label und die Farbe, einstellen
            buttonlabel:SetText(UnitName(einteilung[j][i]))
            local class, engClass = UnitClass(einteilung[j][i])
            local color = RAID_CLASS_COLORS[engClass];
            if color then
                buttoncolor:SetTexture(color.r, color.g, color.b)
            end
            -- ancher und position einstellen
            button:SetPoint("TOP", "HealOrganizerDialogEinteilungHealGroup"..j.."Slot"..i)
            button:Show()
            -- RaidID im button speichern
            button.raidID = einteilung[j][i]
            zaehler = zaehler + 1
        end
    end
    -- }}}
    -- }}}
    -- {{{ Sets aktuallisieren 
    local function HealOrganizer_changeSet(set)
        self:Debug("aendern auf :"..set)
        UIDropDownMenu_SetSelectedValue(HealOrganizerDialogEinteilungSetsDropDown, set, set)
        current_set = set
        self:LoadCurrentLabels()
        self:UpdateDialogValues()
    end
    local function HealOrganizerDropDown_Initialize()
        local selectedValue = UIDropDownMenu_GetSelectedValue(HealOrganizerDialogEinteilungSetsDropDown)  
        local info

        -- aus DB fuellen
        for key, value in pairs(self.db.account.sets) do
            info = {}
            info.text = key
            info.value = key
            info.func = HealOrganizer_changeSet
            info.arg1 = key
            self:Debug("value ist :"..info.value)
            self:Debug(selectedValue)
            if ( info.value == selectedValue ) then 
                info.checked = 1; 
            end
            UIDropDownMenu_AddButton(info);
        end
    end
    -- }}} 
    -- dropdown initialisieren
    UIDropDownMenu_Initialize(HealOrganizerDialogEinteilungSetsDropDown, HealOrganizerDropDown_Initialize); 
    UIDropDownMenu_Refresh(HealOrganizerDialogEinteilungSetsDropDown)
    UIDropDownMenu_SetWidth(150, HealOrganizerDialogEinteilungSetsDropDown); 
end -- }}}

function HealOrganizer:HideDialog() -- {{{
    self:Debug("schließe dialog")
    -- TODO: chan in DB speichern
    HealOrganizerDialog:Hide()
end -- }}}

function HealOrganizer:ResetData() -- {{{
    -- einfach alle heiler löschen und neu bauen
    self:Debug("einteilung resetten") 
    healer = {}
    self:Debug("labels resetten")
    current_set = L["SET_DEFAULT"]
    self:LoadCurrentLabels()
    self:UpdateDialogValues()
end -- }}}

function HealOrganizer:BroadcastChan() --{{{
    self:Debug("broadcast to chan")
    -- bin ich im chan?
    if GetNumRaidMembers() == 0 then
        self:ErrorMessage(L["NOT_IN_RAID"])
        return;
    end
    local id, name = GetChannelName(self.db.char.chan)
    if id == 0 then
        -- nein, nicht drin
        self:Print(L["NO_CHANNEL"], self.db.char.chan)
        return;
    end
    local messages = self:BuildMessages()
    self:Debug("sende nachrichten in den chan "..self.db.char.chan)
    for _, message in pairs(messages) do
        SendChatMessage(message, "CHANNEL", nil, id)
    end
end -- }}}

function HealOrganizer:BroadcastRaid() -- {{{
    self:Debug("broadcast to raid")
    if GetNumRaidMembers() == 0 then
        self:CustomPrint(1, 0.2, 0.2, self.printFrame, nil, " ", L["NOT_IN_RAID"])
        return;
    end
    local messages = self:BuildMessages()
    for _, message in pairs(messages) do
        SendChatMessage(message, "RAID")
    end
end -- }}}

function HealOrganizer:BuildMessages() -- {{{
    local messages = {}
    table.insert(messages, L["HEALARRANGEMENT"]..":")
    -- 1-5, rest
    -- {{{ gruppen
    for i=1,9 do
        if getn(einteilung[i]) ~= 0 then
            local names={}
            for _, unit in pairs(einteilung[i]) do
                if UnitExists(unit) then
                    name = UnitName(unit)
                    table.insert(names, name)
                end
            end
            table.insert(messages, getglobal("HealOrganizerDialogEinteilungHealGroup"..i.."Label"):GetText()..": "..table.concat(names, ","))
        end
    end
    -- }}}
    -- {{{ Rest
    local decurse = HealOrganizerDialogEinteilungOptionenDecurse:GetChecked()
    local heal = HealOrganizerDialogEinteilungOptionenHeal:GetChecked()
    local action = L["FFA"] -- default ffa
    if decurse or heal then
        -- decursen und/oder heilen
        if decurse and heal then
            action = L["HEAL"]..", "..L["DECURSE"]
        elseif decurse then
            action = L["DECURSE"]
        elseif heal then
            action = L["HEAL"]
        end
    end
    table.insert(messages, L["REMAINS"]..": "..action)
    -- }}}
    return messages
end -- }}}

function HealOrganizer:ChangeChan() -- {{{
    self:Debug("speicher channel")
    self.db.char.chan = HealOrganizerDialogBroadcastChannelEditbox:GetText()
end -- }}}

function HealOrganizer:HealerOnClick(a) -- {{{
    self:Debug("Healer OnClick")
    self:Debug(a)
end -- }}}

function HealOrganizer:HealerOnDragStart() -- {{{
    self:Debug("Healer OnDragStart")
    local cursorX, cursorY = GetCursorPosition()
    this:ClearAllPoints();
    this:SetPoint("CENTER", nil, "BOTTOMLEFT", cursorX*GetScreenWidthScale(), cursorY*GetScreenHeightScale());
    this:StartMoving()
    level_of_button = this:GetFrameLevel();
    this:SetFrameLevel(this:GetFrameLevel()+30) -- sehr hoch
end -- }}}

function HealOrganizer:HealerOnDragStop() -- {{{
    self:Debug("Healer OnDragStop")
    this:SetFrameLevel(level_of_button)
    this:StopMovingOrSizing()
    -- gucken wo ich bin?
    local pools = {
        "HealOrganizerDialogEinteilungHealerpool",
        "HealOrganizerDialogEinteilungHealGroup1Slot1",
        "HealOrganizerDialogEinteilungHealGroup1Slot2",
        "HealOrganizerDialogEinteilungHealGroup1Slot3",
        "HealOrganizerDialogEinteilungHealGroup1Slot4",
        "HealOrganizerDialogEinteilungHealGroup2Slot1",
        "HealOrganizerDialogEinteilungHealGroup2Slot2",
        "HealOrganizerDialogEinteilungHealGroup2Slot3",
        "HealOrganizerDialogEinteilungHealGroup2Slot4",
        "HealOrganizerDialogEinteilungHealGroup3Slot1",
        "HealOrganizerDialogEinteilungHealGroup3Slot2",
        "HealOrganizerDialogEinteilungHealGroup3Slot3",
        "HealOrganizerDialogEinteilungHealGroup3Slot4",
        "HealOrganizerDialogEinteilungHealGroup4Slot1",
        "HealOrganizerDialogEinteilungHealGroup4Slot2",
        "HealOrganizerDialogEinteilungHealGroup4Slot3",
        "HealOrganizerDialogEinteilungHealGroup4Slot4",
        "HealOrganizerDialogEinteilungHealGroup5Slot1",
        "HealOrganizerDialogEinteilungHealGroup5Slot2",
        "HealOrganizerDialogEinteilungHealGroup5Slot3",
        "HealOrganizerDialogEinteilungHealGroup5Slot4",
        "HealOrganizerDialogEinteilungHealGroup6Slot1",
        "HealOrganizerDialogEinteilungHealGroup6Slot2",
        "HealOrganizerDialogEinteilungHealGroup6Slot3",
        "HealOrganizerDialogEinteilungHealGroup6Slot4",
        "HealOrganizerDialogEinteilungHealGroup7Slot1",
        "HealOrganizerDialogEinteilungHealGroup7Slot2",
        "HealOrganizerDialogEinteilungHealGroup7Slot3",
        "HealOrganizerDialogEinteilungHealGroup7Slot4",
        "HealOrganizerDialogEinteilungHealGroup8Slot1",
        "HealOrganizerDialogEinteilungHealGroup8Slot2",
        "HealOrganizerDialogEinteilungHealGroup8Slot3",
        "HealOrganizerDialogEinteilungHealGroup8Slot4",
        "HealOrganizerDialogEinteilungHealGroup9Slot1",
        "HealOrganizerDialogEinteilungHealGroup9Slot2",
        "HealOrganizerDialogEinteilungHealGroup9Slot3",
        "HealOrganizerDialogEinteilungHealGroup9Slot4",
    }
    for _, pool in pairs(pools) do
        poolframe = getglobal(pool)
        if MouseIsOver(poolframe) then
            self:Debug("Bin ueber "..poolframe:GetName())
            local _,_,group,slot = string.find(poolframe:GetName(), "HealOrganizerDialogEinteilungHealGroup(%d+)Slot(%d+)")
            group,slot = tonumber(group),tonumber(slot)
            if (slot and group) then
                    self:Debug("Parent HealOrganizerDialogEinteilungHealGroup"..group.." und slot: "..slot)
            end
            self:Debug("ich habe "..this:GetName())
            self:Debug("vorher "..healer[this.raidID])
            -- den heiler da zuordnen
            if "HealOrganizerDialogEinteilungHealerpool" == pool then
                healer[this.raidID] = "Rest"
		position[this.raidID] = 0
            else
                if group >= 1 and group <= 9 then
                        lastAction["group"] = healer[this.raidID]
                        healer[this.raidID] = group
                end
                if slot >= 1 and slot <= 4 then
                        lastAction["unit"] = this.raidID
                        --Nur setzen wenn innerhalb einer Gruppe verschoben wird, 0 = Kommt von ausserhalb und wird an der position eingefuegt und Gruppe nach unten verschoben
                        if lastAction["group"] == group then
                                lastAction["position"] = position[this.raidID]
                        else
                                lastAction["position"] = 0
                        end
                        --neue Position
                        position[this.raidID] = slot
                end
            end
            self:Debug("nachher "..healer[this.raidID])
            break
        end
    end
    -- positionen aktuallisieren
    self:UpdateDialogValues()
end -- }}}

function HealOrganizer:HealerOnLoad() -- {{{
    self:Debug("OnLoad")
    -- 0 = pool, MT1-M5
    -- 1 = slots
    -- 2 = passt ;)
    this:SetFrameLevel(this:GetFrameLevel() + 2)
    this:RegisterForDrag("LeftButton")
end -- }}}

function HealOrganizer:EditGroupLabel(group) -- {{{
    self:Debug(group:GetName())
    self:Debug(group:GetID())
    if group:GetID() == 0 then
        return -- Rest nicht bearbeiten
    end
    change_id = group:GetID()
    StaticPopup_Show("HEALORGANIZER_EDITLABEL", group:GetID())    
end -- }}}

function HealOrganizer:SaveNewLabel(id, text) -- {{{
    if id == 0 then
        return
    end
    if text == "" then
        return
    end
    if grouplabels[id] ~= nil then
        grouplabels[id] = text
        self:UpdateDialogValues()
    end
end -- }}}

function HealOrganizer:LoadLabelsFromSet(set) -- {{{
    if not set then
        return nil
    end
    if self.db.account.sets[set] then
        local keys = {"Rest", 1, 2, 3, 4, 5, 6, 7, 8, 9}
        for _, key in pairs(keys) do
            grouplabels[key] = self.db.account.sets[set][key]
        end
        return true
    end
    return nil
end -- }}}

function HealOrganizer:LoadCurrentLabels() -- {{{
    if not self:LoadLabelsFromSet(current_set) then
        self:LoadLabelsFromSet(L["SET_DEFAULT"])
    end
end -- }}}

function HealOrganizer:SetSave() -- {{{
    self:Debug("set speichern")
    if current_set == L["SET_DEFAULT"] then
        self:ErrorMessage(L["SET_CANNOT_SAVE_DEFAULT"])
        return
    end
    self.db.account.sets[current_set] = {}
    local keys = {"Rest", 1, 2, 3, 4, 5, 6, 7, 8, 9}
    for _, key in pairs(keys) do
        self.db.account.sets[current_set][key] = grouplabels[key]
    end
end -- }}}

function HealOrganizer:SetSaveAs(name) -- {{{
    if not name then
        return
    end
    if name == "" then
        return
    end
    if name == L["SET_DEFAULT"] then
        self:ErrorMessage(L["SET_CANNOT_SAVE_DEFAULT"])
        return
    end
    local count = 0
    for a,b in pairs(self.db.account.sets) do
        count = count+1
    end
    self:Debug("anzahl sets:" ..count)
    if count >= 32 then
        self:ErrorMessage(L["SET_TO_MANY_SETS"])
        return
    end
    self:Debug("set speichern als :"..name)
    if self.db.account.sets[name] then
        self:ErrorMessage(string.format(L["SET_ALREADY_EXISTS"], name))
        return
    end
    -- anlegen
    self.db.account.sets[name] = {}
    self.db.account.sets[name]["Name"] = name
    local keys = {"Rest", 1, 2, 3, 4, 5, 6, 7, 8, 9}
    for _, key in pairs(keys) do
        self.db.account.sets[name][key] = grouplabels[key]
    end
    current_set = name
    self:LoadCurrentLabels()
    UIDropDownMenu_SetSelectedValue(HealOrganizerDialogEinteilungSetsDropDown, current_set)
    UIDropDownMenu_Refresh(HealOrganizerDialogEinteilungSetsDropDown)
    self:UpdateDialogValues()
end -- }}}

function HealOrganizer:SetDelete() -- {{{
    if current_set == L["SET_DEFAULT"] then
        self:ErrorMessage(L["SET_CANNOT_DELETE_DEFAULT"])
        return
    end
    self:Debug("set loeschen")
    if not self.db.account.sets[current_set] then
        return
    end
    self.db.account.sets[current_set] = nil
    current_set = L["SET_DEFAULT"]
    UIDropDownMenu_SetSelectedValue(HealOrganizerDialogEinteilungSetsDropDown, current_set)
    self:LoadCurrentLabels()
    self:UpdateDialogValues()
end -- }}}

function HealOrganizer:ErrorMessage(str) -- {{{
    if not str then
        return
    end
    if str == "" then
        return
    end
    self:CustomPrint(1, 0.2, 0.2, self.printFrame, nil, " ", str)
end -- }}}

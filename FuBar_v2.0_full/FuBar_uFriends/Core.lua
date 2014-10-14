local compost = AceLibrary("Compost-2.0")
local dewdrop = AceLibrary("Dewdrop-2.0")
local tablet = AceLibrary("Tablet-2.0")
local blclass = AceLibrary("Babble-Class-2.0")

local L = AceLibrary("AceLocale-2.0"):new("uFriends")

uFriends = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "FuBarPlugin-2.0", "AceDB-2.0")
uFriends.hasIcon = true
uFriends.guildOnline = 0
uFriends.clickableTooltip = true
uFriends:RegisterDB("uFriendsDB")

function uFriends:OnEnable()
    self:RegisterEvent("FRIENDLIST_UPDATE", "UpdateData")
    self:RegisterEvent("PLAYER_ENTERING_WORLD", "UpdateData")
    self:RegisterEvent("CHAT_MSG_SYSTEM")

    self:ScheduleRepeatingEvent(self.name, ShowFriends, 300)

    self:UpdateData()
end

function uFriends:OnDisable()
    self:UnregisterEvent("FRIENDLIST_UPDATE")
    self:UnregisterEvent("PLAYER_ENTERING_WORLD")
    self:UnregisterEvent("CHAT_MSG_SYSTEM")
    self:CancelEvent(self.name)
end

function uFriends:CHAT_MSG_SYSTEM()
    if (string.find(arg1, L"has come online") or string.find(arg1, L"has gone offline")) then
        self:OnDataUpdate()
    end
end

function uFriends:OnDataUpdate()
    -- DEFAULT_CHAT_FRAME:AddMessage("uFriends:OnDataUpdate()")

    self.total = GetNumFriends() or 0
    self.online = 0

    if (not self.friends) then self.friends = compost:Acquire() end
    for i = 1, self.total do
        local name, level, class, area, connected = GetFriendInfo(i)
        if (name) then
            if (connected) then
                self.friends[name] = compost:Acquire()
                local t = self.friends[name]
                t.level = level
                t.class = class
                t.area  = area
                self.online = self.online + 1
            elseif (self.friends[name]) then
                compost:Reclaim(self.friends[name])
                self.friends[name] = nil
            end
        end
    end

    self:UpdateText()
end

function uFriends:OnClick()
    if (FriendsFrame:IsVisible()) then
        HideUIPanel(FriendsFrame)
    else
        ToggleFriendsFrame(1)
        FriendsFrame_Update()
    end
end


function uFriends:UpdateText()
    if (self.online > 0) then
        self:SetText(string.format("%d/%d", self.online, self.total))
    elseif (self.total > 0) then
        self:SetText(string.format("0/%d", self.total))
    else
        self:SetText("No Friends")
    end
end


function uFriends:OnTooltipUpdate()
    if (self.total > 0) then
        tablet:SetTitle("Friends")
        local cat
        local nCats = (self.db.profile.showNotes and 4) or 3

        cat = tablet:AddCategory("columns", nCats)
        if (nCats == 3) then
            cat:AddCategory(
            "text", L"Name",
            "text2", L"Level",
            "text3", L"Area"
            )
        else
            cat:AddCategory(
            "text", L"Name",
            "text2", L"Level",
            "text3", L"Note",
            "text4", L"Area"
            )
        end

        for name, data in pairs(self.friends) do
            if (nCats == 4) then
                cat:AddLine(
                "text", string.format("|cff%s%s|r", (blclass:GetHexColor(data.class) or "000000"), name),
                "justify", "LEFT",
                "text2", data.level or "?",
                "justify2", "RIGHT",
                "text3", string.format("%s %s", note or "", officernote or ""),
                "text4", data.area or "",
                "func", "WhisperPlayer",
                "arg1", self,
                "arg2", name
                )
            else
                cat:AddLine(
                "text", string.format("|cff%s%s|r", (blclass:GetHexColor(data.class) or "000000"), name),
                "justify", "LEFT",
                "text2", data.level or "?",
                "justify2", "RIGHT",
                "text3", data.area or "",
                "func", "WhisperPlayer",
                "arg1", self,
                "arg2", name
                )
            end
        end
    else
        tablet:AddCategory("text", L"No Friends Online")
    end
end

function uFriends:WhisperPlayer(name)
    if (name) then
        SetItemRef(string.format("player:%s", name), string.format("|Hplayer:%s|h[%s|h", name, name), "LeftButton")
    end
end


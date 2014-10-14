local dewdrop = AceLibrary("Dewdrop-2.0")
local tablet = AceLibrary("Tablet-2.0")
local blclass = AceLibrary("Babble-Class-2.0")

local L = AceLibrary("AceLocale-2.0"):new("uGuild")

uGuild = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "FuBarPlugin-2.0", "AceDB-2.0")
uGuild.hasIcon = true
uGuild.guildOnline = 0
uGuild.clickableTooltip = true
uGuild:RegisterDB("uGuildDB")

local options = {
    type = "group",
    args = {
        motd = {
            type = "toggle",
            name = L"Toggle MotD",
            desc = L"Toggle display of the Guild Message of the Day",
            set  = function(v) uGuild.db.profile.showMOTD = v end,
            get  = function() return uGuild.db.profile.showMOTD end,
        },
        notes = {
            type = "toggle",
            name = L"Toggle Player Notes",
            desc = L"Toggle display of the Player Notes",
            set  = function(v) uGuild.db.profile.showNotes = v end,
            get  = function() return uGuild.db.profile.showNotes end,
        },
    },
}

function uGuild:OnEnable()
    self:RegisterEvent("GUILD_ROSTER_UPDATE", "UpdateData")
    self:RegisterEvent("PLAYER_GUILD_UPDATE", "UpdateData")
    self:RegisterEvent("PLAYER_ENTERING_WORLD", "UpdateData")
    self:RegisterEvent("CHAT_MSG_SYSTEM")

    self:ScheduleRepeatingEvent(self.name, GuildRoster, 300)

    self:UpdateData()
end

function uGuild:OnDisable()
    self:UnregisterEvent("GUILD_ROSTER_UPDATE")
    self:UnregisterEvent("PLAYER_ENTERING_WORLD")
    self:UnregisterEvent("PLAYER_GUILD_UPDATE")
    self:UnregisterEvent("CHAT_MSG_SYSTEM")
    self:CancelEvent(self.name)
end

function uGuild:OnMenuRequest()
    dewdrop:FeedAceOptionsTable(options)
end

function uGuild:CHAT_MSG_SYSTEM()
    if (string.find(arg1, L"has come online") or string.find(arg1, L"has gone offline")) then
        self:OnDataUpdate()
    end
end

function uGuild:OnDataUpdate()
    if (IsInGuild()) then
        GuildRoster()

        self.guildSize = GetNumGuildMembers(true) or 0
        self.guildName = GetGuildInfo("player") or "Lonely Soul"
        self.guildMOTD = GetGuildRosterMOTD()

        self.guildOnline = 0
        for i = 1, self.guildSize do
            local _, _, _, _, _, _, _, _, connected = GetGuildRosterInfo(i)
            if (connected) then
                self.guildOnline = self.guildOnline + 1
            end
        end

        self:UpdateText()
    end
end

function uGuild:OnClick()
    if (FriendsFrame:IsVisible()) then
        HideUIPanel(FriendsFrame)
    else
        ToggleFriendsFrame(3)
        FriendsFrame_Update()
    end
end


function uGuild:UpdateText()
    if (IsInGuild()) then
        self:SetText(string.format("%d/%d", self.guildOnline, self.guildSize))
    else
        self:SetText("No Guild")
    end
end


function uGuild:OnTooltipUpdate()
    if (IsInGuild()) then
        tablet:SetTitle(string.format("<%s>", self.guildName))
        local cat
        if (self.db.profile.showMOTD) then
            cat:AddLine(
            "text", self.guildMOTD,
            "wrap", true
            )
        end

        local nCats = (self.db.profile.showNotes and 4) or 3

        cat = tablet:AddCategory("columns", nCats)
        if (self.guildSize > 0) then
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
        end

        for i=1, self.guildSize do
            local name, rank, rankIndex, level, class, area, note, officernote, connected, status = GetGuildRosterInfo(i)
            if connected then
                if (nCats == 4) then
                    cat:AddLine(
                    "text", string.format("|cff%s%s|r", (blclass:GetHexColor(class) or "000000"), name),
                    "justify", "LEFT",
                    "text2", level or "?",
                    "justify2", "RIGHT",
                    "text3", string.format("%s %s", note or "", officernote or ""),
                    "text4", area or "",
                    "func", "WhisperPlayer",
                    "arg1", self,
                    "arg2", name
                    )
                else
                    cat:AddLine(
                    "text", string.format("|cff%s%s|r", (blclass:GetHexColor(class) or "000000"), name),
                    "justify", "LEFT",
                    "text2", level or "?",
                    "justify2", "RIGHT",
                    "text3", area or "",
                    "func", "WhisperPlayer",
                    "arg1", self,
                    "arg2", name
                    )
                end
            end
        end
    else
        tablet:AddCategory():AddLine("text", L"Not in guild")
    end
end

function uGuild:WhisperPlayer(name)
    if (name) then
        SetItemRef(string.format("player:%s", name), string.format("|Hplayer:%s|h[%s|h", name, name), "LeftButton")
    end
end


local L = AceLibrary("AceLocale-2.2"):new("AutoReady")

L:RegisterTranslations("enUS", function() return {
    ["Sound"] = true,
    ["Toggles playing the raid warning sound"] = true,
} end)

local AutoReady = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceHook-2.1", "AceDB-2.0", "AceConsole-2.0")

AutoReady:RegisterDB("AutoReadyDB")
AutoReady:RegisterDefaults("profile",
    {
        sound = true,
    }
)

function AutoReady:OnInitialize()
    self:RegisterChatCommand({"/AutoReady", "/autoready"} ,
        {
            type = "group",
            args = {
                sound = {
                    type = "toggle",
                    name = L["Sound"],
                    desc = L["Toggles playing the raid warning sound"],
                    get = function() return self.db.profile.sound end,
                    set = function(v) self.db.profile.sound = v end,
                },
            },
        }
    )
end

function AutoReady:OnEnable()
    self:RegisterEvent("READY_CHECK", function() ConfirmReadyCheck(true) end)
    if ShowReadyCheck then
        self:Hook("ShowReadyCheck", function() if self.db.profile.sound then PlaySound("ReadyCheck") end end)
    else
        self:RegisterEvent("RAID_ROSTER_UPDATE",
            function()
                if ShowReadyCheck then
                    self:UnregisterEvent("RAID_ROSTER_UPDATE")
                    self:Hook("ShowReadyCheck", function() if self.db.profile.sound then PlaySound("ReadyCheck") end end)
                end
            end
        )
    end
end

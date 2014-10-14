-- AceLibrary("SpecialEvents-Aura-2.0")
local ccdebuffs = {
	["Polymorph: Pig"] = "MAGE",
	["Polymorph: Turtle"] = "MAGE",
	["Banish"] = "WARLOCK",
	["Polymorph"] = "MAGE",
	["Sap"] = "ROGUE",
	["Seduction"] = "WARLOCK",
	["Hibernate"] = "DRUID",
	["Shackle Undead"] = "PRIEST",
	["Freezing Trap Effect"] = "HUNTER",
}

Sheppard = AceLibrary("AceAddon-2.0"):new("AceConsole-2.0", "AceEvent-2.0", "AceDB-2.0")
Sheppard:RegisterDB("SheppardDB")
Sheppard:RegisterDefaults("profile", {
    whitelist = "none",
})

local options = {
    type = "group",
    args = {
        ctrltarget = {
            type = "toggle",
            name = "Ctrl-Target",
            desc = "Allow targetting of crowd controled mobs when Ctrl is held.",
            get  = function() return Sheppard.db.profile.ctrltarget end,
            set  = function(v) Sheppard.db.profile.ctrltarget = v end,
        },
        whitelist = {
            type = "text",
            name = "whitelist",
            desc = "Only warn on which types of crowd control?",
            get = function() return Sheppard.db.profile.whitelist end,
            set = function(v) Sheppard.db.profile.whitelist = v end,
            validate = {
                [1] = "none",
                [2] = "mine",
                [3] = "all",
            },
        },
    },
}

function Sheppard:OnEnable()
    self:RegisterEvent("SpecialEvents_UnitDebuffGained")

    _, self.myclass = UnitClass("player")

    self:RegisterChatCommand({"/shep", "/sheppard"}, options)
end


function Sheppard:OnDisable()
    self:UnregisterEvent("SpecialEvents_UnitDebuffGained")
end

function Sheppard:OSD(msg)
    if (MikSBT) then
        MikSBT.DisplayMessage(msg, MikSBT.DISPLAYTYPE_NOTIFICATION, true, 1.0, 0.1, 0.1)
    elseif (SCT and SCT_MSG_FRAME) then
        SCT_MSG_FRAME:AddMessage(msg, 1.0, 0.1, 0.1, 1)
    elseif (CombatText_AddMessage) then
        CombatText_AddMessage(msg, COMBAT_TEXT_SCROLL_FUNCTION, 1.0, 0.1, 0.1, "sticky", nil)
    else
        UIErrorsFrame:AddMessage(msg, 1.0, 0.1, 0.1, 1.0, UIERRORS_HOLD_TIME)
    end
end

function Sheppard:SpecialEvents_UnitDebuffGained(targ, debuff)
    if (targ == "target" and ccdebuffs[debuff]) then
        if (((self.db.profile.whitelist == "none") or
            (self.db.profile.whitelist == "mine" and ccdebuffs[debuff] ~= self.myclass)) and
            (not self.db.profile.ctrltarget or (self.db.profile.ctrltarget and not IsControlKeyDown()))) then
            self:ScheduleEvent("Sheppard_ClearTarget", ClearTarget, 0.1)
            self:OSD("Clearing target due to "..debuff)
        else
            self:OSD("Your target is crowd-controled (" .. debuff .. ")")
        end
        PlaySoundFile("Interface\\AddOns\\Sheppard\\wreee.wav")
    end
end



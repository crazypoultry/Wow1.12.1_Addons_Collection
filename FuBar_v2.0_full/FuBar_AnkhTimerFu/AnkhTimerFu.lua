
AnkhTimerFu = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceConsole-2.0", "AceDB-2.0", "FuBarPlugin-2.0")

local L = AceLibrary("AceLocale-2.0"):new("AnkhTimerFu")
local tablet = AceLibrary("Tablet-2.0")
local dewdrop = AceLibrary("Dewdrop-2.0")
local BS = AceLibrary("Babble-Spell-2.0")
local crayon = AceLibrary("Crayon-2.0")

AnkhTimerFu:RegisterDB("AnkhTimerFuDB")
AnkhTimerFu:RegisterDefaults('profile', {
    timeLastUsed        = 0,
    ankhCount           = 0,
    showAnkhCount       = true,
    showCooldown        = true,
    ankhCheckNumber     = 0
})

AnkhTimerFu.version = "0.7." .. string.sub("$Revision$", 12, -3)
AnkhTimerFu.date = string.sub("$Date$", 8, 17)
AnkhTimerFu.hasIcon = true

L:RegisterTranslations("enUS", function() return {
    ANKH_NAME = "Ankh",
    ANKH_READY = "Ready",
} end)

L:RegisterTranslations("deDE", function() return {
    ANKH_NAME = "Ankh",
    ANKH_READY = "Bereit",
} end)


function AnkhTimerFu:OnInitialize()
    self.optionsTable = {
        handler = AnkhTimerFu,
        type = 'group',
        args = {
            ankhcheck = {
                name = "Ankh Count Check", type = "range",
                desc = "Minimum ankhs in inventory. If there are less, a warning popup will be displayed.\n'0' = disable",
                get = function() return self.db.profile.ankhCheckNumber end,
                set = function(v)
                    self.db.profile.ankhCheckNumber = v
                end,
                min = 0,
                max = 10,
                step = 1,
                order = 1
            },
        }
    }
    
    self:RegisterChatCommand({ "/ankhtimerfu" }, self.optionsTable)
    self.OnMenuRequest = self.optionsTable
end

function AnkhTimerFu:OnEnable()
    --self:RegisterEvent("BAG_UPDATE", "ReincarnationTest")
    
    self:RegisterEvent("SpecialEvents_BagSlotUpdate", "ReincarnationTest")
    
    -- If talents have changed, check for the reincarnation ability
    self:RegisterEvent("SPELLS_CHANGED", "TalentCheck")
    self:RegisterEvent("LEARNED_SPELL_IN_TAB", "TalentCheck")
    
    self:RegisterEvent("PLAYER_ALIVE", "StoreResTime")
    self:RegisterEvent("PLAYER_DEAD", "ChangeStatus")
    
    self.testInterval = 5
    self.resTime = 0
    self.isDead = false
    self.talentCooldown = self:GetTalentCooldown()
    self.db.profile.ankhCount = self:GetAnkhs()
    
    StaticPopupDialogs["ANKHTIMERFU_POPUP"] = {
        text = "You have only "..self.db.profile.ankhCount.." Ankh(s) left!\n(check at "..self.db.profile.ankhCheckNumber..")",
        button1 = TEXT(ACCEPT),
        showAlert = 1,
        timeout = 0,
        hideOnEscape = 1
    }
    
    self:AnkhCheck()
    
    self:ScheduleRepeatingEvent(self.Update, 1, self)
end

function AnkhTimerFu:OnTextUpdate()
    local s = ""
    s = s .. format("|cff%s%d|r Ankh(s)", crayon:GetThresholdHexColor(self.db.profile.ankhCount, 0, 1, 3, 5, 10), self.db.profile.ankhCount)

    local cooldown = (time() - 1100304000) - tonumber(self.db.profile.timeLastUsed)
    if (cooldown > self:GetTalentCooldown()) then
        cooldown =  0
    end
    if (cooldown > 0) then
       if (string.len(s) > 0) then
          s = s .. " "
       end
       s = s .. format("|cff%s%s|r", crayon:GetThresholdHexColor(self:GetTalentCooldown()-cooldown, 3600, 1800, 600, 300, 60), date("%M:%S",self:GetTalentCooldown()-cooldown))
    end
    
    self:SetText(s)
end

function AnkhTimerFu:OnTooltipUpdate()
    local cat = tablet:AddCategory(
        'columns', 2,
        'child_textR', 1,
        'child_textG', 1,
        'child_textB', 0,
        'child_text2R', 1,
        'child_text2G', 1,
        'child_text2B', 1
    )
    
    local resDate = date("%c", tonumber(self.db.profile.timeLastUsed) + 1100304000)
    cat:AddLine(
        'text', "Reincarnated since:",
        'text2', resDate
    )
    cat:AddLine(
        'text', "Ankhs:",
        'text2', self.db.profile.ankhCount
    )

    local cooldown = (time() - 1100304000) - tonumber(self.db.profile.timeLastUsed)
    if( cooldown < self:GetTalentCooldown() ) then
        cat:AddLine(
            'text', "Cooldown:",
            'text2', date("%M:%S",self:GetTalentCooldown()-cooldown)
        )
    else
        cat:AddLine(
            'text', "Cooldown:",
            'text2', L"ANKH_READY"
        )
    end
    
    cat:AddLine(
        'text', "Ability cooldown:",
        'text2', (self:GetTalentCooldown()/60).." min"
    )
end

function AnkhTimerFu:GetItemInfoFromLink(l)
    if(not l) then return end
    for c,i,n in string.gfind(l,"|c(%x+)|Hitem:(%d+:%d+:%d+:%d+)|h%[(.-)%]|h|r") do
        return n,c,i
    end
end

function AnkhTimerFu:GetAnkhs()
    local ankhs = 0
    for bag = 4, 0, -1 do
        local size = GetContainerNumSlots(bag)
        
        if (size > 0) then
            for slot=1, size, 1 do
                local texture, itemCount = GetContainerItemInfo(bag, slot)
                
                if (itemCount) then
                    local itemName = self:GetItemInfoFromLink(GetContainerItemLink(bag, slot))
                    
                    -- if the item has a name
                    if  ((itemName) and (itemName ~= "")) then
                        -- if the item is an ankh, increase the count
                        if (itemName == L"ANKH_NAME") then
                            ankhs  = ankhs + itemCount
                        end
                    end
                end
            end
        end
    end
    
    return ankhs
end

function AnkhTimerFu:GetTalentCooldown()
    -- scan for talent points in Restoration --> Improved Self-Reincarnation
    local talentPoints = 0
    
    for talent = 1, GetNumTalentTabs(), 1 do
        for talentIdx  = 1, GetNumTalents(talent), 1 do
            nameTalent, icon, iconx, icony, currRank, maxRank = GetTalentInfo(talent, talentIdx)
            
            if (nameTalent) then
                if (nameTalent == BS"Improved Reincarnation") then
                    talentPoints = currRank
                end
            end
        end
    end
    
    return (3600 - (600 * talentPoints))
end

function AnkhTimerFu:TalentCheck()
    if (self.db.profile.talentCooldown ~= self:GetTalentCooldown()) then
        self.db.profile.talentCooldown = self:GetTalentCooldown()
        self:Update()
    end
end

function AnkhTimerFu:ReincarnationTest(bag, slot, itemlink, stack, oldlink, oldstack)
	local itemName = self:GetItemInfoFromLink(itemlink)
	if itemName == L"ANKH_NAME" then
		local aCount = self:GetAnkhs()
		
		if (aCount ~= self.db.profile.ankhCount) then
			if (aCount == self.db.profile.ankhCount - 1 ) then
				if (self.isDead) then
					self:StartAnkhTimer()
				elseif ((GetTime() - self.resTime) < self.testInterval) then
					self:StartAnkhTimer()
				end
			end
			self.db.profile.ankhCount = aCount
			self:Update()
		end
	end
end

function AnkhTimerFu:StoreResTime()
    self.resTime = GetTime()
    self.isDead = false
end

function AnkhTimerFu:StartAnkhTimer()
    self.db.profile.timeLastUsed = tostring(time() - 1100304000)
end

function AnkhTimerFu:AnkhCheck()
    if self.db.profile.ankhCheckNumber == 0 then return end
    if (UnitLevel("player")>=30 and self.db.profile.ankhCount <= self.db.profile.ankhCheckNumber) then
        StaticPopup_Show("ANKHTIMERFU_POPUP")
    end
end

function AnkhTimerFu:ChangeStatus()
    self.isDead = true
end

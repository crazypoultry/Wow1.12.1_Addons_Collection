
------------------------------
--      Are you local?      --
------------------------------

local BB = AceLibrary("Babble-Boss-2.2")
local D = AceLibrary("Deformat-2.0")
local L = AceLibrary("AceLocale-2.2"):new("VoicesFromBeyond")


----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	announcement = "~~~ %s update ~~~ %s has been defeated! ~~~",  -- "~~~ <zone> update ~~~ <boss> has been defeated! ~~~"
--~~ 	domo = "Impossible! Stay your attack, mortals... I submit! I submit!",
} end)


---------------------------------
--      Addon Declaration      --
---------------------------------

VoicesFromBeyond = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceConsole-2.0", "AceDB-2.0")
VoicesFromBeyond:RegisterChatCommand({"/vfb"})
VoicesFromBeyond:RegisterDB("VoicesFromBeyondDB")


------------------------------
--      Initialization      --
------------------------------

function VoicesFromBeyond:OnEnable()
	self:RegisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH")
end


------------------------------
--      Event Handling      --
------------------------------

function VoicesFromBeyond:CHAT_MSG_COMBAT_HOSTILE_DEATH(msg)
	local mob = D:Deformat(msg, UNITDIESOTHER)
	if mob and BB:HasReverseTranslation(mob) then
		SendChatMessage(string.format(L["announcement"], GetRealZoneText(), mob), "GUILD")
	end
end



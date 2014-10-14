PH_VERSION = "1.0";

PH_GUILD_SEND_BUTTON      = "Send to Guild"
PH_PARTY_SEND_BUTTON      = "Send to Party"
PH_PLAYER_SEND_BUTTON     = "Send to Player"
PH_CHANNEL_SEND_BUTTON    = "Send to Channel"

-----New Strings-----
--Display
PH_SEND_BUTTON    = "Send"
PH_REFRESH_BUTTON = "Set"
PH_GUILD          = "Guild"
PH_PARTY          = "Party"
PH_RAID           = "Raid"
PH_PLAYER         = "Player"
PH_CHANNEL        = "Channel"
PH_ITEM           = "Item:"
PH_AMOUNT         = "Amount:"
PH_SEND_TO        = "Send to:"

--Craft names
PH_ENCHANTING  = "Enchanting"

--Sent out
PH_BUILD_GETMAT_SENTENCE_START = "To make "
PH_BUILD_GETMAT_SENTENCE_END   = ", you need the following:"

local function buildGetMatSentence(matNumber, matName)
	return PH_BUILD_GETMAT_SENTENCE_START .. matNumber .. "x" .. matName .. PH_BUILD_GETMAT_SENTENCE_END
end

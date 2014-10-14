AUCTIONLINK = {}
if( not ace:LoadTranslation("AuctionLink") ) then

AUCTIONLINK.NAME			= "AuctionLink"
AUCTIONLINK.DESCRIPTION	= "Lets you shift-click items into the auction search box."
AUCTIONLINK.AUTOSEARCH	= "Auto searching"

-- Chat handler locals
AUCTIONLINK.COMMANDS		= {"/alink", "/auctionlink"}
AUCTIONLINK.CMD_CLEAR		= "clear"
AUCTIONLINK.CMD_OPTIONS	= {
	{
		option	= "autosearch",
		desc		= "Toggle auto searching after shift clicking an item",
		method	=	"ToggleAutoSearch",
	},
}
end

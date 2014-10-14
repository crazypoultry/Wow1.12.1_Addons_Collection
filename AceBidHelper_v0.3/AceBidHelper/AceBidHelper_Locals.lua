if( not ace:LoadTranslation("AceBidHelper") ) then

AceBidHelperLocals = {
	NAME = "AceBidHelper",
	DESCRIPTION = "Track Successful and Failed Bid Records.",
	COMMANDS = {"/acebidhelper", "/abh"},
	CMD_OPTIONS = {
		{
			option  = "list",
			desc	= "List AceBidHelper Records. (successful or failed)",
			method	= "ListAll",
			args	= {
				{
					option  = "successful",
					desc	= "List successful records.",
					method  = "ListSuccessful"
				},
				{
					option  = "failed",
					desc	= "List failed records.",
					method  = "ListFailed"
				},
			},
		},
		{
			option  = "loc",
			desc	= "Change Minimap Icon Location. (0-360)",
			method	= "MinimapLoc",
		},
		{
			option  = "reset",
			desc	= "Reset All data.",
			method	= "Reset",
		},
	},

	TEXT = {
		successful_records = "Successful Records:",
		failed_records = "Failed Records:",
	},

	SUCCESSFUL_MESSAGES = {
		TEXT(ERR_AUCTION_SOLD_S),
		TEXT(ERR_AUCTION_WON_S)
	},

	FAILED_MESSAGES = {
		TEXT(ERR_AUCTION_OUTBID_S),
		TEXT(ERR_AUCTION_EXPIRED_S),
		TEXT(ERR_AUCTION_REMOVED_S)
	},
}
end
function AceBidHelper_Locals_zhCN ()

AceBidHelperLocals = {
	NAME = "AceBidHelper",
	DESCRIPTION = "跟踪成功或失败的拍卖纪录.",
	COMMANDS = {"/acebidhelper", "/abh"},
	CMD_OPTIONS = {
		{
			option  = "list",
			desc	= "列出所有拍卖纪录. (successful 或 failed)",
			method	= "ListAll",
			args	= {
				{
					option  = "successful",
					desc	= "列出成功拍卖纪录.",
					method  = "ListSuccessful"
				},
				{
					option  = "failed",
					desc	= "列出失败拍卖纪录.",
					method  = "ListFailed"
				},
			},
		},
		{
			option  = "loc",
			desc	= "更改小地图图标位置. (0-360)",
			method	= "MinimapLoc",
		},
		{
			option  = "reset",
			desc	= "重置所有数据.",
			method	= "Reset",
		},
	},

	TEXT = {
		successful_records = "成功拍卖纪录:",
		failed_records = "失败拍卖纪录:",
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
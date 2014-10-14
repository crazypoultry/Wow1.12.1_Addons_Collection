--------------------------------------------------
-- localization.cn.lua (Chinese) by shu
-- $LastChangedBy: gryphon $
-- $Date: 2006-04-28 11:07:37 -0500 (Fri, 28 Apr 2006) $

if ( GetLocale() == "zhCN" ) then

	BINDING_HEADER_APB_HEADER				= "神奇队伍条";
	BINDING_NAME_APB_TOGGLE_MOBILITY		= "移动性钉子";
	BINDING_DESCRIPTION_APB_TOGGLE_MOBILITY	= "允许你拖动和重置神奇队伍条.";

	RESET_ALL		= "重置所有";

	ArcanePartyBars.localization = {};
	ArcanePartyBars.localization.TOOLTIP_TEXT = "点击拖动 %s.\nShift-Right-点击出重置菜单.";

	ArcanePartyBars.localization.BAR_TITLES = {};
	ArcanePartyBars.localization.BAR_TITLES[1] = "队友1施法条";
	ArcanePartyBars.localization.BAR_TITLES[2] = "队友2施法条";
	ArcanePartyBars.localization.BAR_TITLES[3] = "队友3施法条";
	ArcanePartyBars.localization.BAR_TITLES[4] = "队友4施法条";

	ArcanePartyBars.localization.SIMULATION_FAILURE = "不能生效神奇队伍条,请更新.";

	ArcanePartyBars.localization.info = {};
	ArcanePartyBars.localization.MASTER_ENABLE = "神奇队伍条";
	ArcanePartyBars.localization.info.MASTER_ENABLE = "队友施法条.";
	ArcanePartyBars.localization.OPTIONS_HEADER = "神奇队伍条选项.";
	ArcanePartyBars.localization.info.OPTIONS_HEADER = "";
	ArcanePartyBars.localization.RESET_BARS = "重置神奇队伍条的位置.";
	ArcanePartyBars.localization.info.RESET_BARS = "默认的位置是队友栏的顶部右边.";
	ArcanePartyBars.localization.MAKE_DRAGGABLE = "可拖动.";
	ArcanePartyBars.localization.info.MAKE_DRAGGABLE = "使施法条可视化拖动. 在重定位以后,钉住.";
	ArcanePartyBars.localization.TOP_TEXT = "文字在顶部";
	ArcanePartyBars.localization.info.TOP_TEXT = "目标文字和施法时间在施法条上部. 默认是右边.";
	ArcanePartyBars.localization.AUTO_JOIN = "自动加入SkyParty频道.";
	ArcanePartyBars.localization.AUTO_JOIN_ALERT = "你必需加入SkyParty频道,神奇队伍条才能工作.";
	ArcanePartyBars.localization.info.AUTO_JOIN = "加入正确的SkyParty频道,当你加入队伍或者是队长变换了.";
	ArcanePartyBars.localization.SEND_CASTS = "发送施法事件给队伍的成员.";
	ArcanePartyBars.localization.info.SEND_CASTS = "允许队友知晓你施法.";
	ArcanePartyBars.localization.SHOW_CASTS = "显示队友施法.";
	ArcanePartyBars.localization.info.SHOW_CASTS = "队友施法时,通知你.";
	ArcanePartyBars.localization.SIMULATE_ONUPDATE = "模拟刷新.(是通过频道发送的刷新,不是wow发送的刷新,所以叫模拟)";
	ArcanePartyBars.localization.info.SIMULATE_ONUPDATE = "队友施法时候,降低动画帧数,(如果显卡不好的话必选).";
	ArcanePartyBars.localization.SIM_PERIOD = "模拟刷新间隔.";
	ArcanePartyBars.localization.SIM_PERIOD_TEXT = "每秒";
	ArcanePartyBars.localization.info.SIM_PERIOD = "显示神奇队伍条的刷新间隔.";

end
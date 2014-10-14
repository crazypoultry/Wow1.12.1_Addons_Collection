--**************************
-- zhTW Chinese Traditional
-- 2006/9/21 艾娜羅沙@布蘭卡德
--**************************

if GetLocale() ~= "zhTW" then return end 
-- Static Messages
SCT.LOCALS.LowHP= "生命值過低！";					-- Message to be displayed when HP is low
SCT.LOCALS.LowMana= "魔法值過低！";					-- Message to be displayed when Mana is Low
SCT.LOCALS.SelfFlag = "*";								-- Icon to show self hits
SCT.LOCALS.Combat = "進入戰鬥";						-- Message to be displayed when entering combat
SCT.LOCALS.NoCombat = "脫離戰鬥";					-- Message to be displayed when leaving combat
SCT.LOCALS.ComboPoint = "連擊點";			  		-- Message to be displayed when gaining a combo point
SCT.LOCALS.FiveCPMessage = "◇◆連擊點已滿◆◇"; -- Message to be displayed when you have 5 combo points
SCT.LOCALS.ExtraAttack = "▽▼斬殺▼▽"; -- Message to be displayed when time to execute

--Option messages
SCT.LOCALS.STARTUP = "SCT（Scrolling Combat Text）"..SCT.Version.." 插件已載入。輸入/sct顯示可用的指令。";
SCT.LOCALS.Option_Crit_Tip = "將此事件以致命一擊效果顯示";
SCT.LOCALS.Option_Msg_Tip = "將此事件以靜態訊息顯示，覆蓋致命一擊效果";
SCT.LOCALS.Frame1_Tip = "在動畫框架1中顯示此事件";
SCT.LOCALS.Frame2_Tip = "在動畫框架2中顯示此事件"; 

--Warnings
SCT.LOCALS.Version_Warning= "|cff00ff00SCT警告|r\n\n你當前的存檔是舊版本SCT的設置。如果遇到錯誤或不正常現象，請按“重置”按鈕或輸入/sctreset恢復預設設定。";
SCT.LOCALS.Load_Error = "|cff00ff00載入SCT設置選單SCT - Damage（SCTD）時發生錯誤。設置插件可能被禁用了。|r 錯誤：";

--nouns
SCT.LOCALS.TARGET = "目標 ";
SCT.LOCALS.PROFILE = "載入 SCT 配置：|cff00ff00";
SCT.LOCALS.PROFILE_DELETE = "刪除 SCT 配置：|cff00ff00";
SCT.LOCALS.PROFILE_NEW = "新增 SCT 配置：|cff00ff00";
SCT.LOCALS.WARRIOR = "戰士";
SCT.LOCALS.ROGUE = "盜賊";
SCT.LOCALS.HUNTER = "獵人";
SCT.LOCALS.MAGE = "法師";
SCT.LOCALS.WARLOCK = "術士";
SCT.LOCALS.DRUID = "德魯伊";
SCT.LOCALS.PRIEST = "牧師";
SCT.LOCALS.SHAMAN = "薩滿";
SCT.LOCALS.PALADIN = "聖騎士";

--Useage
SCT.LOCALS.DISPLAY_USEAGE = "SCT語法：\n";
SCT.LOCALS.DISPLAY_USEAGE = SCT.LOCALS.DISPLAY_USEAGE .. "/sctdisplay '訊息'（顯示白色字）\n";
SCT.LOCALS.DISPLAY_USEAGE = SCT.LOCALS.DISPLAY_USEAGE .. "/sctdisplay '訊息' red(0-10) green(0-10) blue(0-10)\n";
SCT.LOCALS.DISPLAY_USEAGE = SCT.LOCALS.DISPLAY_USEAGE .. "例如：/sctdisplay '治療我' 10 0 0\n將顯示紅色字的『治療我』訊息\n";
SCT.LOCALS.DISPLAY_USEAGE = SCT.LOCALS.DISPLAY_USEAGE .. "某些常用顏色：紅 = 10 0 01綠 = 0 10 0, 藍 = 0 0 10，\n黃 = 10 10 0, 紫 = 10 0 10, 青 = 0 10 10";

--Fonts
SCT.LOCALS.FONTS = { 
	[1] = { name="剪紙", path="Fonts\\FZJZJW.TTF"},
	[2] = { name="北魏", path="Fonts\\FZBWJW.TTF"},
	[3] = { name="隸變", path="Fonts\\FZLBJW.TTF"},
	[4] = { name="細黑", path="Fonts\\FZLBJW.ttf"},
}

-- Cosmos button
SCT.LOCALS.CB_NAME			= "Scrolling Combat Text".." "..SCT.Version;
SCT.LOCALS.CB_SHORT_DESC	= "by Grayhoof";
SCT.LOCALS.CB_LONG_DESC	= "按這開啟SCT設定畫面";
SCT.LOCALS.CB_ICON			= "Interface\\Icons\\Spell_Shadow_EvilEye"; -- "Interface\\Icons\\Spell_Shadow_FarSight"
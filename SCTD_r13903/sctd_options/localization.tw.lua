--**************************
-- zhTW Chinese Traditional
-- 2006/9/21 艾娜羅沙@布蘭卡德
--**************************

if GetLocale() ~= "zhTW" then return end

--Event and Damage option values
SCT.LOCALS.OPTION_EVENT101 = {name = "近戰傷害", tooltipText = "顯示你造成的近戰傷害"};
SCT.LOCALS.OPTION_EVENT102 = {name = "週期性傷害", tooltipText = "顯示你造成的週期性傷害"};
SCT.LOCALS.OPTION_EVENT103 = {name = "法術/技能傷害", tooltipText = "顯示你造成的法術/技能傷害"};
SCT.LOCALS.OPTION_EVENT104 = {name = "寵物傷害", tooltipText = "顯示你的寵物造成的傷害"};
SCT.LOCALS.OPTION_EVENT105 = {name = "彩色重擊文字", tooltipText = "以指定的色彩，顯示致命一擊傷害"}; 

--Check Button option values
SCT.LOCALS.OPTION_CHECK101 = { name = "啟用SCTD", tooltipText = "啟用SCT - Damage"};
SCT.LOCALS.OPTION_CHECK102 = { name = "標記傷害訊息", tooltipText = "在傷害訊息兩側添加'*'標記"};
SCT.LOCALS.OPTION_CHECK103 = { name = "法術類型", tooltipText = "顯示你造成的法術傷害的類型"};
SCT.LOCALS.OPTION_CHECK104 = { name = "法術名稱", tooltipText = "顯示你造成傷害的法術/技能的名稱"};
SCT.LOCALS.OPTION_CHECK105 = { name = "抵抗", tooltipText = "顯示你被敵人抵抗了的傷害"};
SCT.LOCALS.OPTION_CHECK106 = { name = "目標名字", tooltipText = "顯示目標的名字"};
SCT.LOCALS.OPTION_CHECK107 = { name = "關閉WoW傷害顯示", tooltipText = "關閉WoW內建的傷害顯示。\n\n注意：此設置與遊戲選單“介面->進階”中的相關設定有一樣的作用。但WOW本身介面的設定更為詳盡。"};
SCT.LOCALS.OPTION_CHECK108 = { name = "僅限目標", tooltipText = "只顯示你對目前目標造成的傷害。AE效果不會顯示，除非多個目標名字重複。"};
--109 skipped, old pvp flag.
SCT.LOCALS.OPTION_CHECK110 = { name = "使用SCT動畫", tooltipText = "使用SCT動畫效果顯示，而非以靜態訊息方式顯示"};
SCT.LOCALS.OPTION_CHECK111 = { name = "傷害重擊效果", tooltipText = "以特效顯示你造成的致命一擊或極效治療。關閉後，將以例如 +1236+ 的格式顯示"};
SCT.LOCALS.OPTION_CHECK112 = { name = "法術顏色", tooltipText = "以不同的顏色顯示不同類型的法術傷害（顏色不可更改）"};
SCT.LOCALS.OPTION_CHECK113 = { name = "傷害文字向下捲動", tooltipText = "傷害訊息向下捲動"};

--Slider options values
SCT.LOCALS.OPTION_SLIDER101 = { name="中心X坐標", minText="-600", maxText="600", tooltipText = "調整文字的位置"};
SCT.LOCALS.OPTION_SLIDER102 = { name="中心Y坐標", minText="-400", maxText="400", tooltipText = "調整文字的位置"};
SCT.LOCALS.OPTION_SLIDER103 = { name="淡出速度", minText="快", maxText="慢", tooltipText = "調整靜態訊息淡出的速度"};
SCT.LOCALS.OPTION_SLIDER104 = { name="字體大小", minText="小", maxText="大", tooltipText = "調整文字大小"};
SCT.LOCALS.OPTION_SLIDER105 = { name="透明度", minText="0%", maxText="100%", tooltipText = "調整文字透明度"};

--Misc option values
SCT.LOCALS.OPTION_MISC101 = {name="SCTD設定"..SCTD.Version};
SCT.LOCALS.OPTION_MISC102 = {name="關閉", tooltipText = "保存所有目前的設定，並關閉設定選單"};
SCT.LOCALS.OPTION_MISC103 = {name="SCTD", tooltipText = "打開 SCT - Damage 設定選單"};
SCT.LOCALS.OPTION_MISC104 = {name="傷害事件", tooltipText = ""};
SCT.LOCALS.OPTION_MISC105 = {name="顯示設定", tooltipText = ""};
SCT.LOCALS.OPTION_MISC106 = {name="框體設定", tooltipText = ""};

--Animation Types
SCT.LOCALS.OPTION_SELECTION101 = { name="傷害字體", tooltipText = "選擇文字字體", table = {[1] = SCT.LOCALS.FONTS[1].name,[2] = SCT.LOCALS.FONTS[2].name,[3] = SCT.LOCALS.FONTS[3].name,[4] = SCT.LOCALS.FONTS[4].name}};
SCT.LOCALS.OPTION_SELECTION102 = { name="傷害字體輪廓", tooltipText = "選擇文字輪廓類型", table = {[1] = "無",[2] = "細",[3] = "粗"}};
SCT.LOCALS.OPTION_SELECTION103 = { name="傷害動畫類型", tooltipText = "選擇動畫類型", table = {[1] = "垂直(預設)",[2] = "彩虹",[3] = "水平",[4] = "斜下",[5] = "斜上",[6] = "灑落"}};
SCT.LOCALS.OPTION_SELECTION104 = { name="傷害彈出方式", tooltipText = "選擇彈出方式", table = {[1] = "交替",[2] = "傷害向左",[3] = "傷害向右", [4] = "全部向左", [5] = "全部向右"}};
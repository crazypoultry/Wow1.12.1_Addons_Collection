--**************************
-- zhTW Chinese Traditional
-- 2006/9/21 艾娜羅沙@布蘭卡德
--**************************

if GetLocale() ~= "zhTW" then return end
--Event and Damage option values
SCT.LOCALS.OPTION_EVENT1 = {name = "傷害", tooltipText = "顯示受到的近戰傷害與其他傷害（火焰、摔落等）"};
SCT.LOCALS.OPTION_EVENT2 = {name = "未擊中", tooltipText = "顯示敵人未擊中你的近戰攻擊"};
SCT.LOCALS.OPTION_EVENT3 = {name = "閃避", tooltipText = "顯示閃避的近戰攻擊"};
SCT.LOCALS.OPTION_EVENT4 = {name = "招架", tooltipText = "顯示招架的近戰攻擊"};
SCT.LOCALS.OPTION_EVENT5 = {name = "格擋", tooltipText = "顯示格擋的近戰攻擊"};
SCT.LOCALS.OPTION_EVENT6 = {name = "法術傷害", tooltipText = "顯示受到的法術傷害"};
SCT.LOCALS.OPTION_EVENT7 = {name = "法術治療", tooltipText = "顯示受到的法術治療"};
SCT.LOCALS.OPTION_EVENT8 = {name = "法術抵抗", tooltipText = "顯示抵抗敵人的法術"};
SCT.LOCALS.OPTION_EVENT9 = {name = "不良效果", tooltipText = "顯示受到的不良效果影響"};
SCT.LOCALS.OPTION_EVENT10 = {name = "吸收/其它", tooltipText = "顯示對敵人傷害的吸收、反射、免疫效果等"};
SCT.LOCALS.OPTION_EVENT11 = {name = "生命過低", tooltipText = "生命值過低警告"};
SCT.LOCALS.OPTION_EVENT12 = {name = "法力過低", tooltipText = "法力值過低警告"};
SCT.LOCALS.OPTION_EVENT13 = {name = "能量獲得", tooltipText = "顯示透過藥水、物品、增益效果等獲得的法力值、怒氣、能量（非正常恢復）"};
SCT.LOCALS.OPTION_EVENT14 = {name = "戰鬥標記", tooltipText = "顯示進入、脫離戰鬥狀態的提示訊息"};
SCT.LOCALS.OPTION_EVENT15 = {name = "連擊點", tooltipText = "顯示獲得的連擊點數"};
SCT.LOCALS.OPTION_EVENT16 = {name = "榮譽獲得", tooltipText = "顯示獲得的榮譽點數"};
SCT.LOCALS.OPTION_EVENT17 = {name = "增益效果", tooltipText = "顯示獲得的增益效果"};
SCT.LOCALS.OPTION_EVENT18 = {name = "增益消失", tooltipText = "顯示從你身上消失的增益效果"};
SCT.LOCALS.OPTION_EVENT19 = {name = "可使用技能", tooltipText = "顯示進入可使用狀態的特定技能（斬殺、貓鼬撕咬、憤怒之錘等）"};
SCT.LOCALS.OPTION_EVENT20 = {name = "聲望", tooltipText = "顯示聲望的提昇或降低"};
SCT.LOCALS.OPTION_EVENT21 = {name = "玩家治療", tooltipText = "顯示對別人的治療"};
SCT.LOCALS.OPTION_EVENT22 = {name = "技能點數", tooltipText = "顯示技能點數的提昇"};

--Check Button option values
SCT.LOCALS.OPTION_CHECK1 = { name = "啟用 Scrolling Combat Text", tooltipText = "啟用 Scrolling Combat Text"};
SCT.LOCALS.OPTION_CHECK2 = { name = "標記戰鬥訊息", tooltipText = "在戰鬥訊息兩側添加'*'標記"};
SCT.LOCALS.OPTION_CHECK3 = { name = "顯示治療者", tooltipText = "顯示治療你的玩家或生物的名字"};
SCT.LOCALS.OPTION_CHECK4 = { name = "文字向下捲動", tooltipText = "戰鬥訊息向下捲動"};
SCT.LOCALS.OPTION_CHECK5 = { name = "重擊效果", tooltipText = "以特效顯示受到的致命一擊或極效治療"};
SCT.LOCALS.OPTION_CHECK6 = { name = "法術傷害類型", tooltipText = "顯示你受到的法術傷害的類型"};
SCT.LOCALS.OPTION_CHECK7 = { name = "對傷害啟用字體設定", tooltipText = "以SCT使用的字體顯示游戲預設的傷害數字。\n\n注意：此設定必須重新登入才能生效。重新載入界面無效。"};
SCT.LOCALS.OPTION_CHECK8 = { name = "顯示所有能量獲得", tooltipText = "顯示所有的能量獲得，而不是僅顯示戰鬥記錄中出現的。 \n\n注意：必須先啟用普通的“能量獲得”事件。非常容易洗頻。且德魯伊在切換回施法者形態時會有不正常的現象。"};
SCT.LOCALS.OPTION_CHECK9 = { name = "FPS獨立模式", tooltipText = "切換動畫顯示速度是否與畫面的FPS同步。打開後動畫速度會更穩定，且在電腦畫面卡住或不順的情況下，能夠使SCT動畫表現流暢速度。"};
SCT.LOCALS.OPTION_CHECK10 = { name = "顯示過量治療", tooltipText = "顯示你的過量治療值，必須先啟用“玩家治療”事件。"};
SCT.LOCALS.OPTION_CHECK11 = { name = "警報聲音", tooltipText = "當發出警告時播放聲音。"};
SCT.LOCALS.OPTION_CHECK12 = { name = "法術傷害顏色", tooltipText = "以不同的顏色顯示不同類型的法術傷害（顏色不可更改）"};
SCT.LOCALS.OPTION_CHECK13 = { name = "啟用自定義事件", tooltipText = "啟用自定義事件。關閉後能節省大量記憶體的使用。"};
SCT.LOCALS.OPTION_CHECK14 = { name = "啟用低耗模式", tooltipText = "啟用低CPU消耗模式。低耗模式使用WoW內建的事件來驅動大部分SCT事件，減少對戰鬥記錄的監控分析。能夠提高整體效能，但部分功能將不能使用，包括自定事件。\n\n請注意這些WoW事件回饋的訊息不如戰鬥記錄那麼豐富，而且可能會出錯。"};
SCT.LOCALS.OPTION_CHECK15 = { name = "閃爍", tooltipText = "使得致命／極效的效果呈現閃爍狀態。"};
SCT.LOCALS.OPTION_CHECK16 = { name = "Glancing/Crushing", tooltipText = "Enables or Disables showing Glancing ~150~ and Crushing ^150^ blows"};
SCT.LOCALS.OPTION_CHECK17 = { name = "Show your HOT's", tooltipText = "Enables or Disables showing your healing over time spells cast on others. Note: this can be very spammy if you cast a lot of them."};

--Slider options values
SCT.LOCALS.OPTION_SLIDER1 = { name="文字動畫速度", minText="快", maxText="慢", tooltipText = "調整動態文字捲動速度"};
SCT.LOCALS.OPTION_SLIDER2 = { name="文字大小", minText="小", maxText="大", tooltipText = "調整動態文字的大小"};
SCT.LOCALS.OPTION_SLIDER3 = { name="生命百分比", minText="10%", maxText="90%", tooltipText = "設定玩家生命值降低到幾％時發出警告"};
SCT.LOCALS.OPTION_SLIDER4 = { name="法力百分比",  minText="10%", maxText="90%", tooltipText = "設定玩家法力值降低到幾％時發出警告"};
SCT.LOCALS.OPTION_SLIDER5 = { name="文字透明度", minText="0%", maxText="100%", tooltipText = "調整動態文字的透明度"};
SCT.LOCALS.OPTION_SLIDER6 = { name="文字移動距離", minText="小", maxText="大", tooltipText = "調整動態文字間的距離"};
SCT.LOCALS.OPTION_SLIDER7 = { name="文字中心X坐標", minText="-600", maxText="600", tooltipText = "調整動態文字的左右位置"};
SCT.LOCALS.OPTION_SLIDER8 = { name="文字中心Y坐標", minText="-400", maxText="400", tooltipText = "調整動態文字的上下位置"};
SCT.LOCALS.OPTION_SLIDER9 = { name="靜態訊息中心X坐標", minText="-600", maxText="600", tooltipText = "調整靜態訊息的位置"};
SCT.LOCALS.OPTION_SLIDER10 = { name="靜態訊息中心Y坐標", minText="-400", maxText="400", tooltipText = "調整靜態訊息的位置"};
SCT.LOCALS.OPTION_SLIDER11 = { name="靜態訊息淡出速度", minText="快", maxText="慢", tooltipText = "調整靜態訊息淡出的速度"};
SCT.LOCALS.OPTION_SLIDER12 = { name="靜態訊息字體大小", minText="小", maxText="大", tooltipText = "調整靜態訊息的文字大小"};
SCT.LOCALS.OPTION_SLIDER13 = { name="治療者過濾", minText="0", maxText="500", tooltipText = "調整SCT要顯示的最小的治療量的值。用於不想顯示如恢復，回春術，祝福等小量的治療效果時"};
SCT.LOCALS.OPTION_SLIDER14 = { name="法力過濾", minText="0", maxText="500", tooltipText = "設定SCT要顯示的數字的最低法力獲得的門檻值。對於過濾掉少量的法力恢復如圖騰，祝福效果...等等。"};

--Misc option values
SCT.LOCALS.OPTION_MISC1 = {name="SCT 設定"..SCT.Version, tooltipText = "點擊拖曳來移動"};
--SCT.LOCALS.OPTION_MISC2 = {name="事件設定"};           --SCT.LOCALS.OPTION_MISC2 = { }; -- old option will reuse later
--SCT.LOCALS.OPTION_MISC3 = {name="動態文字框體1設定"};  --SCT.LOCALS.OPTION_MISC3 = { }; -- old option will reuse later
SCT.LOCALS.OPTION_MISC4 = {name="雜項設定"};
SCT.LOCALS.OPTION_MISC5 = {name="警告設定"};
SCT.LOCALS.OPTION_MISC6 = {name="動畫設定"};
SCT.LOCALS.OPTION_MISC7 = {name="選擇設定方案"};
SCT.LOCALS.OPTION_MISC8 = {name="存檔並關閉", tooltipText = "儲存所有目前設定並關閉設定選單"};
SCT.LOCALS.OPTION_MISC9 = {name="重置", tooltipText = "＞＞警告＜＜\n\n確定要還原所有SCT設定為預設狀態嗎？"};
SCT.LOCALS.OPTION_MISC10 = {name="設定檔", tooltipText = "選擇一個設定配置"};
SCT.LOCALS.OPTION_MISC11 = {name="載入", tooltipText = "載入一個設定配置"};
SCT.LOCALS.OPTION_MISC12 = {name="刪除", tooltipText = "刪除一個設定配置"}; 
--SCT.LOCALS.OPTION_MISC13 = {name="取消", tooltipText = "取消選擇"};  -- old option will reuse later
SCT.LOCALS.OPTION_MISC14 = {name="動畫1", tooltipText = ""};
SCT.LOCALS.OPTION_MISC15 = {name="靜態訊息", tooltipText = ""};
SCT.LOCALS.OPTION_MISC16 = {name="靜態訊息"};
SCT.LOCALS.OPTION_MISC17 = {name="法術設定"};
SCT.LOCALS.OPTION_MISC18 = {name="雜項", tooltipText = ""};
SCT.LOCALS.OPTION_MISC19 = {name="法術", tooltipText = ""};
SCT.LOCALS.OPTION_MISC20 = {name="動畫2", tooltipText = ""};
SCT.LOCALS.OPTION_MISC21 = {name="動態文字", tooltipText = ""};
SCT.LOCALS.OPTION_MISC22 = {name="典型配置", tooltipText = "載入典型設定檔，使得SCT的動作行為接近內定值。"};
SCT.LOCALS.OPTION_MISC23 = {name="效能配置", tooltipText = "載入高效能配置。選取所有的設定來得到最佳的效能。"};
SCT.LOCALS.OPTION_MISC24 = {name="分割設定檔", tooltipText = "載入分割配置。使得傷害和事件顯示在右側，治療和增益效果在左側。"};
SCT.LOCALS.OPTION_MISC25 = {name="Grayhoof配置", tooltipText = "載入Grayhoof配置。使SCT有如Grayhoof(作者)在使用它時一般的運作"};
SCT.LOCALS.OPTION_MISC26 = {name="內建配置", tooltipText = ""};
SCT.LOCALS.OPTION_MISC27 = {name="分割的SCTD配置", tooltipText = "載入分割SCTD配置。如果有安裝SCTD，會使得收到的事件在右側，輸出的事件在左側，其它的事件在上方。"};

--Animation Types
SCT.LOCALS.OPTION_SELECTION1 = { name="動畫類型", tooltipText = "選擇動態文字動畫類型", table = {[1] = "垂直(預設)",[2] = "彩虹",[3] = "水平",[4] = "斜下", [5] = "斜上", [6] = "飄灑"}};
SCT.LOCALS.OPTION_SELECTION2 = { name="彈出方式", tooltipText = "選擇動態文字彈出方式", table = {[1] = "交錯",[2] = "傷害向左",[3] = "傷害向右", [4] = "全部向左", [5] = "全部向右"}};
SCT.LOCALS.OPTION_SELECTION3 = { name="字體", tooltipText = "選擇動態文字字體", table = {[1] = SCT.LOCALS.FONTS[1].name,[2] = SCT.LOCALS.FONTS[2].name,[3] = SCT.LOCALS.FONTS[3].name,[4] = SCT.LOCALS.FONTS[4].name}};
SCT.LOCALS.OPTION_SELECTION4 = { name="字體描邊", tooltipText = "選擇動態文字字體描邊類型", table = {[1] = "無",[2] = "細",[3] = "粗"}};
SCT.LOCALS.OPTION_SELECTION5 = { name="靜態訊息字體", tooltipText = "選擇靜態訊息字體", table = {[1] = SCT.LOCALS.FONTS[1].name,[2] = SCT.LOCALS.FONTS[2].name,[3] = SCT.LOCALS.FONTS[3].name,[4] = SCT.LOCALS.FONTS[4].name}};
SCT.LOCALS.OPTION_SELECTION6 = { name="靜態訊息字體輪廓", tooltipText = "選擇靜態訊息字體輪廓類型", table = {[1] = "無",[2] = "細",[3] = "粗"}};

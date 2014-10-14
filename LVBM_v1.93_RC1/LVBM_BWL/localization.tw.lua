if (GetLocale() == "zhTW") then

--Razorgore
LVBM_RG_NAME                = "狂野的拉佐格爾";
LVBM_RG_DESCRIPTION         = "心靈控制/摧毀蛋 警報";
LVBM_RG_YELL                = "入侵者已經到達孵卵所了，鳴放警報！不惜一切代價也要保護這些蛋！";

LVBM_RG_CONTROLLER          = "黑翼控制者";


--Vaelastrasz
LVBM_VAEL_NAME              = "墮落的瓦拉斯塔茲";
LVBM_VAEL_DESCRIPTION       = "燃燒刺激警報";
LVBM_VAEL_SEND_WHISPER      = "通知目標";
LVBM_VAEL_SET_ICON          = "設置圖示";

LVBM_VAEL_BA_WARNING        = "*** %s 正在燃燒！ ***";
LVBM_VAEL_BA_WHISPER        = "你正在燃燒！";
LVBM_VAEL_BA                = "燃燒刺激";

LVBM_VAEL_BA_REGEXP         = "([^%s]+)受到(.*)燃燒刺激";
LVBM_VAEL_BA_FADES_REGEXP   = "燃燒刺激效果從([^%s]+)身上消失。";

--Lashlayer
LVBM_LASHLAYER_NAME = "勒西雷爾";
LVBM_LASHLAYER_YELL = "你怎麼進來的？你們這種生物不能進來！我要毀滅你們！";

--Firemaw/Ebonroc/Flamegor
LVBM_FIREMAW_NAME               = "費爾默";
LVBM_FIREMAW_DESCRIPTION        = "龍翼打擊/暗影烈焰 警報";
LVBM_EBONROC_NAME               = "埃博諾克";
LVBM_EBONROC_DESCRIPTION        = "龍翼打擊/暗影烈焰/埃博諾克之影 警報";
LVBM_EBONROC_SET_ICON           = "設置圖示"
LVBM_FLAMEGOR_NAME              = "弗萊格爾";
LVBM_FLAMEGOR_DESCRIPTION       = "龍翼打擊/狂暴 警報";
LVBM_FLAMEGOR_ANNOUNCE_FRENZY       = "狂暴警報";

LVBM_FIREMAW_FIREMAW            = "費爾默";
LVBM_EBONROC_EBONROC            = "埃博諾克";
LVBM_FLAMEGOR_FLAMEGOR          = "弗萊格爾";

LVBM_FIREMAW_WING_BUFFET        = "費爾默開始施放龍翼打擊。";
LVBM_EBONROC_WING_BUFFET        = "埃博諾克開始施放龍翼打擊。";
LVBM_FLAMEGOR_WING_BUFFET       = "弗萊格爾開始施放龍翼打擊。";

LVBM_FIREMAW_SHADOW_FLAME       = "費爾默開始施放暗影烈焰。";
LVBM_EBONROC_SHADOW_FLAME       = "埃博諾克開始施放暗影烈焰。";
LVBM_FLAMEGOR_SHADOW_FLAME      = "弗萊格爾開始施放暗影烈焰。";

LVBM_SHADOW_FLAME_WARNING       = "*** 2 秒後發動暗影烈焰 ***";
LVBM_WING_BUFFET_WARNING        = "*** %s 秒後發動龍翼打擊 ***";
LVBM_EBONROC_SHADOW_WARNING     = "*** %s 中了埃博諾克之影 ***";
LVBM_FLAMEGOR_FRENZY            = "%s變得狂暴起來！";
LVBM_FLAMEGOR_FRENZY_ANNOUNCE   = "*** 狂暴 ***";

LVBM_EBONROC_SHADOW_REGEXP      = "^(.+)受到(.*)埃博諾克之影";
LVBM_EBONROC_SHADOW_REGEXP2     = "埃博諾克之影效果從(.+)%";

LVBM_SBT["Wing Buffet"]         = "龍翼打擊";
LVBM_SBT["Wing Buffet Cast"]    = "施放龍翼打擊";
LVBM_SBT["Shadow Flame Cast"]   = "施放暗影烈焰";


--Chromaggus
LVBM_CHROMAGGUS_NAME            = "克洛瑪古斯";
LVBM_CHROMAGGUS_DESCRIPTION     = "吐息/狂暴/抗性改變/弱點 警報";
LVBM_CHROMAGGUS_ANNOUNCE_FRENZY     = "狂暴警告";
LVBM_CHROMAGGUS_ANNOUNCE_VULNERABILITY  = "抗性弱點偵查"
LVBM_CHROMAGGUS_BREATH_1        = "吐息一";
LVBM_CHROMAGGUS_BREATH_2        = "吐息二";

LVBM_CHROMAGGUS_BREATH_CAST_WARNING = "*** 克洛瑪古斯開始施放 %s ***"
LVBM_CHROMAGGUS_BREATH_WARNING      = "*** 10 秒內施放 %s ***"

LVBM_CHROMAGGUS_BREATH_REGEXP       = "克洛瑪古斯開始施放(.+)。";
LVBM_CHROMAGGUS_VULNERABILITY_REGEXP    = "^.+的(.+)克洛瑪古斯造成(%d+)點(.+)傷害。";
LVBM_CHROMAGGUS_CHROMAGGUS      = "克洛瑪古斯";

LVBM_CHROMAGGUS_FRENZY_EXPR			= "%s變得極為狂暴！";
LVBM_CHROMAGGUS_FRENZY_ANNOUNCE			= "*** 狂暴 ***";

LVBM_CHROMAGGUS_VULNERABILITY_EXPR		= "%s因皮膚閃著微光而驚訝退縮。";
LVBM_CHROMAGGUS_VULNERABILITY_ANNOUNCE		= "*** 抗性已經改變 ***";
LVBM_CHROMAGGUS_NEW_VULNERABILITY_ANNOUNCE  = "*** 新弱點: ";

LVBM_SBT["Breath 1"]            = "吐息一";
LVBM_SBT["Breath 2"]            = "吐息二";

--Nefarian
LVBM_NEFARIAN_NAME              = "奈法利安";
LVBM_NEFARIAN_DESCRIPTION       = "職業點名計時";
LVBM_NEFARIAN_BLOCK_HEALS       = "點名牧師時禁止治療";
LVBM_NEFARIAN_UNEQUIP_BOW       = "點名獵人時自動卸下遠程武器";

LVBM_NEFARIAN_FEAR_WARNING          = "*** 1.5 秒後群體恐懼 ***";
LVBM_NEFARIAN_PHASE2_WARNING        = "*** 奈法利安將在 15 秒後降落 ***";
LVBM_NEFARIAN_CLASS_CALL_WARNING    = "*** 職業點名 - 獵人換弓/牧師停止施放恢復 ***";
LVBM_NEFARIAN_SHAMAN_WARNING        = "** 薩滿 - 圖騰湧現 **";
LVBM_NEFARIAN_PALA_WARNING          = "** 聖騎士 - BOSS受到保護祝福，物理攻擊免疫 30 秒 **";
LVBM_NEFARIAN_DRUID_WARNING     = "** 德魯伊 - 強制貓形態，無法治療和解詛咒 **";
LVBM_NEFARIAN_PRIEST_WARNING        = "** 牧師 - 停止治療 25 秒！ 可幫隊友上盾！ **";
LVBM_NEFARIAN_WARRIOR_WARNING       = "** 戰士 - 強制狂暴姿態，加大對MT的治療量 **";
LVBM_NEFARIAN_ROGUE_WARNING     = "** 盜賊 - 被傳送，MT將龍頭偏向 **";
LVBM_NEFARIAN_WARLOCK_WARNING       = "** 術士 - 地獄火出現，DPS職業盡快將其消滅 **";
LVBM_NEFARIAN_HUNTER_WARNING        = "** 獵人 - 遠程武器損壞 **";
LVBM_NEFARIAN_MAGE_WARNING      = "** 法師 - 變形術發動，注意解除 **";
LVBM_NEFARIAN_PRIEST_CALL       = "牧師點名";
LVBM_NEFARIAN_HEAL_BLOCKED      = "牧師點名時禁止施放 %s ！";
LVBM_NEFARIAN_UNEQUIP_ERROR         = "當卸除你的弓/槍的時候發生錯誤."
LVBM_NEFARIAN_EQUIP_ERROR           = "當裝備你的弓/槍的時候發生錯誤."
LVBM_NEFARIAN_PHASE3_WARNING    = "*** 第三階段 - AoE ***";

LVBM_NEFARIAN_DRAKONID_DOWN = {};
LVBM_NEFARIAN_DRAKONID_DOWN[1] = "黑色龍獸死亡了。";
LVBM_NEFARIAN_DRAKONID_DOWN[2] = "藍色龍獸死亡了。";
LVBM_NEFARIAN_DRAKONID_DOWN[3] = "綠色龍獸死亡了。";
LVBM_NEFARIAN_DRAKONID_DOWN[4] = "青銅龍獸死亡了。";
LVBM_NEFARIAN_DRAKONID_DOWN[5] = "紅色龍獸死亡了。";
LVBM_NEFARIAN_DRAKONID_DOWN[6] = "多彩龍獸死亡了。";

LVBM_NEFARIAN_BLOCKED_SPELLS    = {
    ["快速治療"]            = 1.5,
    ["強效治療術"]          = 2.5,
    ["治療禱言"]            = 3,
    ["治療術"]              = 2.5,
    ["次級治療術"]          = 1.5,
--  ["神聖新星"]            = 0,
}

LVBM_NEFARIAN_CAST_SHADOW_FLAME     = "奈法利安開始施放暗影烈焰。";
LVBM_NEFARIAN_CAST_FEAR         = "奈法利安開始施放低沉咆哮。";
LVBM_NEFARIAN_YELL_PHASE1       = "讓遊戲開始吧！";
LVBM_NEFARIAN_YELL_PHASE2       = "幹得好，我的手下。凡人的勇氣開始消退！現在，現在讓我們看看他們如何應對黑石尖塔真正主人的力量！！！";
LVBM_NEFARIAN_YELL_PHASE3       = "不可能！出現吧，我的僕人！再次為我的主人服務！";
LVBM_NEFARIAN_YELL_SHAMANS      = "薩滿，讓我看看";
LVBM_NEFARIAN_YELL_PALAS        = "聖騎士……聽說你有無數條命。讓我看看到底是怎麼樣的吧。";
LVBM_NEFARIAN_YELL_DRUIDS       = "德魯伊和你們愚蠢的變形。讓我們看看什麼會發生吧！";
LVBM_NEFARIAN_YELL_PRIESTS      = "牧師！如果你要繼續這麼治療的話，那我們來玩點有趣的東西！";
LVBM_NEFARIAN_YELL_WARRIORS     = "戰士，我知道你應該比較抗打！讓我們來見識一下吧！";
LVBM_NEFARIAN_YELL_ROGUES       = "盜賊？不要躲了，面對我吧！";
LVBM_NEFARIAN_YELL_WARLOCKS     = "術士，不要隨便去玩那些你不理解的法術。看看會發生什麼吧？";
LVBM_NEFARIAN_YELL_HUNTERS      = "獵人和你那討厭的豌豆射擊！";
LVBM_NEFARIAN_YELL_MAGES        = "還有法師？你應該小心使用你的魔法……";
LVBM_NEFARIAN_YELL_DEAD         = "這不可能！我是這裡的主人！你們凡人對於我來說一無是處！聽到了沒有？一無是處！";

LVBM_SBT["Class call CD"]       = "職業點名 CD";
LVBM_SBT["Druid call"]          = "點名德魯伊";
LVBM_SBT["Priest call"]         = "點名牧師";
LVBM_SBT["Warrior call"]        = "點名戰士";
LVBM_SBT["Rogue call"]          = "點名盜賊";
LVBM_SBT["Mage call"]           = "點名法師";

end
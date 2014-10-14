------------------------------------------------------------------------------------------------------
-- Serenity
--
-- Based on Necrosis LdC by Lomig and Nyx (http://necrosis.larmes-cenarius.net)
-- Original Necrosis Idea : Infernal (http://www.revolvus.com/games/interface/necrosis/)
-- Serenity Maintainer : Kaeldra of Aegwynn
--
-- Contact : darklyte@gmail.com
-- Send me in-game mail!  Yersinia on Aegwynn, Horde side.
-- Guild: <Working as Intended>
-- Version Date: 07.14.2006
------------------------------------------------------------------------------------------------------



SerenityData = {};
SerenityData.Version = "1.0.2"
SerenityData.Author = "Kaeldra";
SerenityData.AppName = "Serenity";
SerenityData.Label = SerenityData.AppName.." "..SerenityData.Version.." by "..SerenityData.Author;


-- Raccourcis claviers
BINDING_HEADER_CRYO_BIND = "Serenity";
   
BINDING_NAME_SERENITYLEFT = "Use Main Serenity Button";
BINDING_NAME_SERENITYRIGHT = "Open Configuration Menu";

BINDING_NAME_DISPELLEFT = "Remove Dispel Decursively";
BINDING_NAME_DISPELRIGHT = "Remove Disease Decursively";

BINDING_NAME_DRINKLEFT = "Use Drink";
BINDING_NAME_DRINKMIDDLE = "Use Bandage (Disabled)";
BINDING_NAME_DRINKRIGHT =  "Use Food (Disabled)";

BINDING_NAME_POTIONLEFT = "Use Potion";
BINDING_NAME_POTIONMIDDLE = "Trade Potion";
BINDING_NAME_POTIONRIGHT = "Conjure Potion";

BINDING_NAME_LASTBUFF = "Recast Last Buff";
BINDING_NAME_LASTSPELL = "Recast Last Spell";
BINDING_NAME_STEED = "Steed";
BINDING_NAME_HEARTH = "Hearthstone";

BINDING_NAME_LEFTSPELLLEFT = "Left Spell Button: Main Function";
BINDING_NAME_LEFTSPELLRIGHT = "Left Spell Button: Secondary Function";
BINDING_NAME_MIDDLESPELLLEFT = "Middle Spell Button: Main Function";
BINDING_NAME_MIDDLESPELLRIGHT = "Middle Spell Button: Secondary Function";
BINDING_NAME_RIGHTSPELLLEFT = "Right Spell Button: Main Function";
BINDING_NAME_RIGHTSPELLRIGHT = "Right Spell Button: Secondary Function";


if GetLocale() == "zhCN" then

BINDING_NAME_SERENITYLEFT = "使用Serenity主按钮";
BINDING_NAME_SERENITYRIGHT = "开启配置菜单";

BINDING_NAME_DISPELLEFT = "驱散魔法";
BINDING_NAME_DISPELRIGHT = "移除疾病";

BINDING_NAME_DRINKLEFT = "使用饮水";
BINDING_NAME_DRINKMIDDLE = "使用背包 (禁用)";
BINDING_NAME_DRINKRIGHT =  "使用食物 (禁用)";

BINDING_NAME_POTIONLEFT = "使用药水";
BINDING_NAME_POTIONMIDDLE = "交易 - 药水";
BINDING_NAME_POTIONRIGHT = "制造药水-炼金术";

BINDING_NAME_LASTBUFF = "重新施放最近一次施放的BUFF";
BINDING_NAME_LASTSPELL = "重新施放最近一次施放法术";
BINDING_NAME_STEED = "座骑";
BINDING_NAME_HEARTH = "炉石";

BINDING_NAME_LEFTSPELLLEFT = "左施法按钮：主功能";
BINDING_NAME_LEFTSPELLRIGHT = "左施法按钮：第二功能";
BINDING_NAME_MIDDLESPELLLEFT = "中间施法按钮：主功能";
BINDING_NAME_MIDDLESPELLRIGHT = "中间施法按钮：第二功能";
BINDING_NAME_RIGHTSPELLLEFT = "右施法按钮：主功能";
BINDING_NAME_RIGHTSPELLRIGHT = "右施法按钮：第二功能";

end


if ( GetLocale() == "zhTW" ) then
------------------------------------------------
-- Traditional Chinese  VERSION TEXTS  - Nightly@布蘭卡德
------------------------------------------------

-- Raccourcis claviers
BINDING_NAME_SERENITYLEFT = "使用主要 Serenity 按鈕";
BINDING_NAME_SERENITYRIGHT = "開啟配置視窗";

BINDING_NAME_DISPELLEFT = "驅散魔法";
BINDING_NAME_DISPELRIGHT = "移除疾病";

BINDING_NAME_DRINKLEFT = "喝水";
BINDING_NAME_DRINKMIDDLE = "使用背包 (關閉)";
BINDING_NAME_DRINKRIGHT =  "進食 (關閉)";

BINDING_NAME_POTIONLEFT = "使用藥水";
BINDING_NAME_POTIONMIDDLE = "交易 - 藥水";
BINDING_NAME_POTIONRIGHT = "製造藥水-煉金術";

BINDING_NAME_LASTBUFF = "重新施放增益魔法";
BINDING_NAME_LASTSPELL = "重新施放";
BINDING_NAME_STEED = "坐騎";
BINDING_NAME_HEARTH = "爐石";

BINDING_NAME_LEFTSPELLLEFT = "左鍵施法按鈕：主要功能";
BINDING_NAME_LEFTSPELLRIGHT = "左鍵施法按鈕：次要功能";
BINDING_NAME_MIDDLESPELLLEFT = "中間鍵施法按鈕：主要功能";
BINDING_NAME_MIDDLESPELLRIGHT = "中間施法按鈕：次要功能";
BINDING_NAME_RIGHTSPELLLEFT = "右鍵施法按鈕：主要功能";
BINDING_NAME_RIGHTSPELLRIGHT = "右鍵施法按鈕：次要功能";

end
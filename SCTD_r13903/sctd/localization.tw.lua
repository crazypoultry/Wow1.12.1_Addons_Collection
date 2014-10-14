--Everything From here on would need to be translated and put
--into if statements for each specific language.

--**************************
-- zhTW Chinese Traditional
-- 2006/9/21 艾娜羅沙@布蘭卡德
--**************************


if GetLocale() ~= "zhTW" then return end

--Warnings
SCTD.LOCALS.Version_Warning = "SCT版本錯誤。必須使用SCT 4.13版或以上的版本，SCTD才能正確運作";
SCTD.LOCALS.Load_Error = "|cff00ff00載入SCTD設定插件時發生錯誤。SCTD_Options插件可能被停用了。|r 錯誤：";

--"Melee" ranged skills
SCTD.LOCALS.AUTO_SHOT = "自動射擊";
SCTD.LOCALS.SHOOT = "射擊";
SCTD.LOCALS.SHOOT_BOW = "弓射擊";
SCTD.LOCALS.SHOOT_CROSSBOW = "弩射擊";
SCTD.LOCALS.SHOOT_GUN = "槍械射擊";

SCTD.LOCALS.CB_NAME			= "SCT - Damage".." "..SCTD.Version;
SCTD.LOCALS.CB_SHORT_DESC	= "by Grayhoof";
SCTD.LOCALS.CB_LONG_DESC	= "把你的傷害量加到SCT中!";
SCTD.LOCALS.CB_ICON			= "Interface\\Icons\\Ability_Warrior_BattleShout"

-- Localizations

if (GetLocale() == "zhTW") then

XPERL_RAID_GROUP		= "小隊 %d"
XPERL_RAID_TOOLTIP_NOCTRA	= "沒有發現 CTRA"
XPERL_RAID_TOOLTIP_OFFLINE	= "離線計時： %s"
XPERL_RAID_TOOLTIP_AFK		= "暫離計時： %s"
XPERL_RAID_TOOLTIP_DND		= "勿擾計時： %s"
XPERL_RAID_TOOLTIP_DYING	= "死亡倒計時： %s"
XPERL_RAID_TOOLTIP_REBIRTH	= "重生倒計時： %s"
XPERL_RAID_TOOLTIP_ANKH		= "十字章失效： %s"
XPERL_RAID_TOOLTIP_SOULSTONE	= "靈魂石失效： %s"

XPERL_RAID_TOOLTIP_REMAINING	= "後消失"
XPERL_RAID_TOOLTIP_WITHBUFF	= "有該buff的成員： (%s)"
XPERL_RAID_TOOLTIP_WITHOUTBUFF	= "無該buff的成員： (%s)"
XPERL_RAID_TOOLTIP_BUFFEXPIRING	= "%s's %s 到期時間 %s"	-- Name, buff name, time to expire

XPERL_RAID_DROPDOWN_SHOWPET	= "顯示寵物"
XPERL_RAID_DROPDOWN_SHOWOWNER	= "顯示所有者"

XPERL_RAID_DROPDOWN_AUTOPROMOTE = "自動提升"
XPERL_RAID_DROPDOWN_MAINTANKS	= "主坦克"
XPERL_RAID_DROPDOWN_SETMT	= "設置 MT #%d"
XPERL_RAID_DROPDOWN_REMOVEMT	= "移除 MT #%d"

XPERL_RAID_RESSING		= "復活中"
XPERL_RAID_AFK			= "暫離"
XPERL_RAID_DND			= "勿擾"
XPERL_RAID_AUTOPROMOTE		= "自動提升"
XPERL_RAID_RESSER_AVAIL		= "可執行復活人員: "

if (not CT_RA_POWERWORDFORTITUDE) then

	CT_RA_POWERWORDFORTITUDE = { "真言術：韌", "堅韌禱言" }
	CT_RA_MARKOFTHEWILD = { "野性印記", "野性賜福" }
	CT_RA_ARCANEINTELLECT = { "祕法智慧", "祕法光輝" }
	CT_RA_ADMIRALSHAT = "將軍之帽"
	CT_RA_POWERWORDSHIELD = "真言術：盾"
	CT_RA_SOULSTONERESURRECTION = "靈魂石復活"
	CT_RA_DIVINESPIRIT = { "神聖之靈", "精神禱言" }
	CT_RA_THORNS = "荊棘術"
	CT_RA_FEARWARD = "防護恐懼結界"
	CT_RA_SHADOWPROTECTION = { "防護暗影", "暗影防護禱言" }
	CT_RA_BLESSINGOFMIGHT = { "力量祝福", "強效力量祝福" }
	CT_RA_BLESSINGOFWISDOM = { "智慧祝福", "強效智慧祝福" }
	CT_RA_BLESSINGOFKINGS = { "王者祝福", "強效王者祝福" }
	CT_RA_BLESSINGOFSALVATION = { "拯救祝福", "強效拯救祝福" }
	CT_RA_BLESSINGOFLIGHT = { "光明祝福", "強效光明祝福" }
	CT_RA_BLESSINGOFSANCTUARY = { "庇護祝福", "強效庇護祝福" }
	CT_RA_RENEW = "恢復"
	CT_RA_REGROWTH = "癒合"
	CT_RA_REJUVENATION = "回春術"
	CT_RA_FEIGNDEATH = { ["en"] = "假死" }
	CT_RA_FIRESHIELD = "火焰之盾"
	CT_RA_DAMPENMAGIC = "魔法抑制"
	CT_RA_AMPLIFYMAGIC = "魔法增效"
end
end

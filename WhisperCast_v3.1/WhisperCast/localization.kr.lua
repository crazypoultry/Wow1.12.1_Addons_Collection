
-- Korean by Esmir
if ( GetLocale() == "koKR" ) then

    WCLocale.UI.rank = "(%d 레벨)";
    WCLocale.UI.rankMatch = "^(%d+) 레벨$"

    WCLocale.PRIEST.Power_Word_Fortitude = "신의 권능: 인내"
    WCLocale.PRIEST.Power_Word_Fortitude_trigger = { "인내" }
    WCLocale.PRIEST.Prayer_of_Fortitude = "인내의 기원"
    WCLocale.PRIEST.Prayer_of_Fortitude_trigger = { "기원" }
    WCLocale.PRIEST.Shadow_Protection = "어둠의 보호"
    WCLocale.PRIEST.Shadow_Protection_trigger = { "어둠" }
    WCLocale.PRIEST.Divine_Spirit = "천상의 정신"
    WCLocale.PRIEST.Divine_Spirit_trigger = { "천정" }
    WCLocale.PRIEST.Power_Word_Shield = "신의 권능: 보호막"
    WCLocale.PRIEST.Power_Word_Shield_trigger = { "보망", "보막", "보호막" }
    WCLocale.PRIEST.Dispel_Magic = "마법 무효화"
    WCLocale.PRIEST.Dispel_Magic_trigger = { "마법", "해제" }
    WCLocale.PRIEST.Abolish_Disease = "질병 해제"
    WCLocale.PRIEST.Abolish_Disease_trigger = { "질병", "질병해제" }
    WCLocale.PRIEST.Cure_Disease = "질병 치료"
    WCLocale.PRIEST.Cure_Disease_trigger = { "질병치료" }
    WCLocale.PRIEST.Fear_Ward = "공포의 수호물"
    WCLocale.PRIEST.Fear_Ward_trigger = { "수호물" }
    WCLocale.PRIEST.Fear_Ward_rank = nil

    WCLocale.MAGE.Arcane_Intellect = "신비한 지능"
    WCLocale.MAGE.Arcane_Intellect_trigger = { "지능" }
    WCLocale.MAGE.Arcane_Brilliance = "신비한 총명함"
    WCLocale.MAGE.Arcane_Brilliance_trigger = { "총명" }
    WCLocale.MAGE.Dampen_Magic = "마법 감쇠"
    WCLocale.MAGE.Dampen_Magic_trigger = { "마법감쇠", "감쇠" }
    WCLocale.MAGE.Amplify_Magic = "마법 증폭"
    WCLocale.MAGE.Amplify_Magic_trigger = { "마법증폭", "증폭" }
    WCLocale.MAGE.Remove_Lesser_Curse = "하급 저주 해제"
    WCLocale.MAGE.Remove_Lesser_Curse_trigger = { "저주" }

    WCLocale.DRUID.Mark_of_the_Wild = "야생의 징표"
    WCLocale.DRUID.Mark_of_the_Wild_trigger = { "야징", "발바닥" }
    WCLocale.DRUID.Gift_of_the_Wild = "야생의 선물"
    WCLocale.DRUID.Gift_of_the_Wild_trigger = { "야선", "선물" }
    WCLocale.DRUID.Thorns = "가시"
    WCLocale.DRUID.Thorns_trigger = { "가시" }
    WCLocale.DRUID.Innervate = "정신 자극"
    WCLocale.DRUID.Innervate_trigger = { "정신", "자극" }
    WCLocale.DRUID.Remove_Curse = "저주 해제"
    WCLocale.DRUID.Remove_Curse_trigger = { "저주" }
    WCLocale.DRUID.Abolish_Poison = "독 해제"
    WCLocale.DRUID.Abolish_Poison_trigger = { "독", "독해제" }
    WCLocale.DRUID.Cure_Poison = "해독"
    WCLocale.DRUID.Cure_Poison_trigger = { "해독" }

    WCLocale.PALADIN.Blessing_of_Might = "힘의 축복"
    WCLocale.PALADIN.Blessing_of_Might_trigger = { "힘축" }
    WCLocale.PALADIN.Blessing_of_Wisdom = "지혜의 축복"
    WCLocale.PALADIN.Blessing_of_Wisdom_trigger = { "지축" }
    WCLocale.PALADIN.Blessing_of_Freedom = "자유의 축복"
    WCLocale.PALADIN.Blessing_of_Freedom_trigger = { "자축" }
    WCLocale.PALADIN.Blessing_of_Freedom_rank = nil
    WCLocale.PALADIN.Blessing_of_Light = "빛의 축복"
    WCLocale.PALADIN.Blessing_of_Light_trigger = { "빛축" }
    WCLocale.PALADIN.Blessing_of_Sacrifice = "희생의 축복"
    WCLocale.PALADIN.Blessing_of_Sacrifice_trigger = { "희축" }
    WCLocale.PALADIN.Blessing_of_Kings = "왕의 축복"
    WCLocale.PALADIN.Blessing_of_Kings_trigger = { "왕축" }
    WCLocale.PALADIN.Blessing_of_Salvation = "구원의 축복"
    WCLocale.PALADIN.Blessing_of_Salvation_trigger = { "구축" }
    WCLocale.PALADIN.Blessing_of_Sanctuary = "성역의 축복"
    WCLocale.PALADIN.Blessing_of_Sanctuary_trigger = { "성축" }
    WCLocale.PALADIN.Blessing_of_Protection = "보호의 축복"
    WCLocale.PALADIN.Blessing_of_Protection_trigger = { "보축" }
    WCLocale.PALADIN.Cleanse = "정화"
    WCLocale.PALADIN.Cleanse_trigger = { "정화", "독", "질병", "마법", "해제", "해독" }
    WCLocale.PALADIN.Purify = "순화"
    WCLocale.PALADIN.Purify_trigger = { "순화" }

    WCLocale.SHAMAN.Cure_Poison = "해독"
    WCLocale.SHAMAN.Cure_Poison_trigger = { "독", "해독" }
    WCLocale.SHAMAN.Cure_Disease = "질병 치료"
    WCLocale.SHAMAN.Cure_Disease_trigger = { "질병" }
    WCLocale.SHAMAN.Water_Breathing = "수중 호흡"
    WCLocale.SHAMAN.Water_Breathing_trigger = { "호흡" }

    WCLocale.WARLOCK.Unending_Breath = "영원의 숨결"
    WCLocale.WARLOCK.Unending_Breath_trigger = { "호흡", "숨결" }
    WCLocale.WARLOCK.Detect_Greater_Invisibility = "상급 투명체 감지"
    WCLocale.WARLOCK.Detect_Greater_Invisibility_trigger = { "은신감지", "감지" }
    WCLocale.WARLOCK.Ritual_of_Summoning = "소환 의식"
    WCLocale.WARLOCK.Ritual_of_Summoning_trigger = { "소환" }
end

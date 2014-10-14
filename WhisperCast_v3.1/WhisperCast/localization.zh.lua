
-- Chinese by killerking
if ( GetLocale() == "zhCN" ) then

    WCLocale.UI.rank = "(等级 %d)"
    WCLocale.UI.rankMatch = "^等级 (%d+)$"

    WCLocale.PRIEST.Power_Word_Fortitude = "真言术：韧"
    wc_append( WCLocale.PRIEST.Power_Word_Fortitude_trigger, { "韧" } )
    WCLocale.PRIEST.Prayer_of_Fortitude = "坚韧祷言"
    wc_append( WCLocale.PRIEST.Prayer_of_Fortitude_trigger, { "群韧" } )
    WCLocale.PRIEST.Shadow_Protection = "防护暗影"
    wc_append( WCLocale.PRIEST.Shadow_Protection_trigger, { "防护暗影", "暗影" } )
    WCLocale.PRIEST.Divine_Spirit = "神圣之灵"
    wc_append( WCLocale.PRIEST.Divine_Spirit_trigger, { "神圣之灵", "精神" } )
    WCLocale.PRIEST.Power_Word_Shield = "真言术：盾"
    wc_append( WCLocale.PRIEST.Power_Word_Shield_trigger, { "盾", "真言盾" } )
    WCLocale.PRIEST.Dispel_Magic = "驱散魔法"
    wc_append( WCLocale.PRIEST.Dispel_Magic_trigger, { "驱散魔法", "魔法" } )
    WCLocale.PRIEST.Abolish_Disease = "驱除疾病"
    wc_append( WCLocale.PRIEST.Abolish_Disease_trigger, { "驱除疾病", "疾病" } )
    WCLocale.PRIEST.Cure_Disease = "祛病术"
    wc_append( WCLocale.PRIEST.Cure_Disease_trigger, { "疾病" } )
    WCLocale.PRIEST.Fear_Ward = "防护恐惧结界"
    wc_append( WCLocale.PRIEST.Fear_Ward_trigger, { "恐惧结界", "恐惧", "结界" } )

    WCLocale.MAGE.Arcane_Intellect = "奥术智慧"
    wc_append( WCLocale.MAGE.Arcane_Intellect_trigger, { "智力" } )
    WCLocale.MAGE.Arcane_Brilliance = "奥术光辉"
    wc_append( WCLocale.MAGE.Arcane_Brilliance_trigger, { "群智力", "群智" } )
    WCLocale.MAGE.Dampen_Magic = "魔法抑制"
    wc_append( WCLocale.MAGE.Dampen_Magic_trigger, { "魔法抑制", "抑制" } )
    WCLocale.MAGE.Amplify_Magic = "魔法增效"
    wc_append( WCLocale.MAGE.Amplify_Magic_trigger, { "魔法增效", "增效" } )
    WCLocale.MAGE.Remove_Lesser_Curse = "解除次级诅咒"
    wc_append( WCLocale.MAGE.Remove_Lesser_Curse_trigger, { "诅咒" } )

    WCLocale.DRUID.Mark_of_the_Wild = "野性印记"
    wc_append( WCLocale.DRUID.Mark_of_the_Wild_trigger, { "野性印记", "印记", "爪子" } )
    WCLocale.DRUID.Gift_of_the_Wild = "野性赐福"
    wc_append( WCLocale.DRUID.Gift_of_the_Wild_trigger, { "野性赐福", "群野性", "群爪", "群爪子" } )
    WCLocale.DRUID.Thorns = "荆棘术"
    wc_append( WCLocale.DRUID.Thorns_trigger, { "荆棘" } )
    WCLocale.DRUID.Innervate = "激活"
    wc_append( WCLocale.DRUID.Innervate_trigger, { "激活" } )
    WCLocale.DRUID.Remove_Curse = "解除诅咒"
    wc_append( WCLocale.DRUID.Remove_Curse_trigger, { "诅咒"} )
    WCLocale.DRUID.Abolish_Poison = "驱毒术"
    wc_append( WCLocale.DRUID.Abolish_Poison_trigger, { "中毒", "毒" } ) 
    WCLocale.DRUID.Cure_Poison = "消毒术"
    wc_append( WCLocale.DRUID.Cure_Poison_trigger, { "中毒", "毒" } ) 

    WCLocale.PALADIN.Blessing_of_Might = "力量祝福"
    wc_append( WCLocale.PALADIN.Blessing_of_Might_trigger, { "力量" } )
    WCLocale.PALADIN.Blessing_of_Wisdom = "智慧祝福"
    wc_append( WCLocale.PALADIN.Blessing_of_Wisdom_trigger, { "智慧" } )
    WCLocale.PALADIN.Blessing_of_Freedom = "自由祝福"
    wc_append( WCLocale.PALADIN.Blessing_of_Freedom_trigger, { "自由" } )
    WCLocale.PALADIN.Blessing_of_Light = "光明祝福"
    wc_append( WCLocale.PALADIN.Blessing_of_Light_trigger, { "光明" } )
    WCLocale.PALADIN.Blessing_of_Sacrifice = "牺牲祝福"
    wc_append( WCLocale.PALADIN.Blessing_of_Sacrifice_trigger, { "牺牲" } ) 
    WCLocale.PALADIN.Blessing_of_Kings = "王者祝福"
    wc_append( WCLocale.PALADIN.Blessing_of_Kings_trigger, { "王者" } )
    WCLocale.PALADIN.Blessing_of_Salvation = "拯救祝福"
    wc_append( WCLocale.PALADIN.Blessing_of_Salvation_trigger, { "拯救" } )
    WCLocale.PALADIN.Blessing_of_Sanctuary = "庇护祝福"
    wc_append( WCLocale.PALADIN.Blessing_of_Sanctuary_trigger, { "庇护" } )
    WCLocale.PALADIN.Blessing_of_Protection = "保护祝福"
    wc_append( WCLocale.PALADIN.Blessing_of_Protection_trigger, { "保护" } )
    WCLocale.PALADIN.Cleanse = "清洁术"
    wc_append( WCLocale.PALADIN.Cleanse_trigger, { "清洁", "魔法", "驱散" } )
    WCLocale.PALADIN.Purify = "纯净术"
    wc_append( WCLocale.PALADIN.Purify_trigger, { "纯净", "疾病", "中毒", "毒" } )

    WCLocale.SHAMAN.Cure_Poison = "消毒术"
    wc_append( WCLocale.SHAMAN.Cure_Poison_trigger, { "中毒", "毒"} ) 
    WCLocale.SHAMAN.Cure_Disease = "祛病术"
    wc_append( WCLocale.SHAMAN.Cure_Disease_trigger, { "疾病" } )
    WCLocale.SHAMAN.Water_Breathing = "水下呼吸"
    wc_append( WCLocale.SHAMAN.Water_Breathing_trigger, { "水下", "水下呼吸", "呼吸" } )

    WCLocale.WARLOCK.Unending_Breath = "魔息术"
    wc_append( WCLocale.WARLOCK.Unending_Breath_trigger, { "水下", "水下呼吸", "呼吸", "魔息" } )
    WCLocale.WARLOCK.Detect_Greater_Invisibility = "侦测强效隐形"
    wc_append( WCLocale.WARLOCK.Detect_Greater_Invisibility_trigger, { "隐形", "探隐", "反隐" } ) 
    WCLocale.WARLOCK.Ritual_of_Summoning = "召唤仪式"
    wc_append( WCLocale.WARLOCK.Ritual_of_Summoning_trigger, { "召唤" } )
end

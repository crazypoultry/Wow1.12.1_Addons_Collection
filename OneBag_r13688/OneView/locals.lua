--$Id: locals.lua 15193 2006-10-26 02:38:54Z caldar $-- 

-- zhCN localization by hk2717
-- deDE localization by Gamefaq
-- koKR localization by Next96
-- frFR loacalization by Tazmanyak

local AL = AceLibrary("AceLocale-2.2")

if GetLocale() == "koKR" then 
	ONEVIEW_LOCALE_CONFIGMENU = "설정 메뉴" 
	ONEVIEW_LOCALE_CHARSELECT = "캐릭터 선택"
elseif GetLocale() == "frFR" then 
    ONEVIEW_LOCALE_CONFIGMENU = "Menu" 
    ONEVIEW_LOCALE_CHARSELECT = "Perso"
elseif GetLocale() == "zhCN" then 
    ONEVIEW_LOCALE_CONFIGMENU = "设置菜单" 
    ONEVIEW_LOCALE_CHARSELECT = "人物选择"
elseif GetLocale() == "deDE" then 
    ONEVIEW_LOCALE_CONFIGMENU = "Config-Men\195\188" 
    ONEVIEW_LOCALE_CHARSELECT = "Charakterauswahl"
else 
    ONEVIEW_LOCALE_CONFIGMENU = "Config Menu" 
    ONEVIEW_LOCALE_CHARSELECT = "Char Select"
end

AL:new("OneView"):RegisterTranslations("enUS", function()
    return {
		["Show the OneView Frame"]	= true,
		
		["Quiver"]	= true,
		["Soul Bag"]	= true,
		["Container"]	= true,
		["Bag"]	= true,
		
		["Backpack"] = true,
		["Turns display of your backpack on and off."] = true,
		["First Bag"] = true,
		["Turns display of your first bag on and off."] = true,
		["Second Bag"] = true,
		["Turns display of your second bag on and off."] = true,
		["Third Bag"] = true,
		["Turns display of your third bag on and off."] = true,
		["Fourth Bag"] = true,
		["Turns display of your fourth bag on and off."] = true,
		["First Bank Bag"] = true,
		["Second Bank Bag"] = true,
		["Third Bank Bag"] = true,
		["Fourth Bank Bag"] = true,
		["Fifth Bank Bag"] = true,
		["Turns display of your fifth bag on and off."] = true,
		["Sixth Bank Bag"] = true,
		["Turns display of your sixth bag on and off."] = true,
                ["Show Button"] = true,
                ["Toggles if the OneView quick button is shown."] = true,
		
		["Remember"] = true,
		["Remember Selection"] = true,
		["Toggles wether to remember which was the last character you selected."] = true,
		["%s's Bank Bags"] = true,
		["%s's Bags"] = true,
		["%s/%s Slots"] = true,
		["%s/%s Ammo"] = true,
		["%s/%s Soul Shards"] = true,
		["%s/%s Profession Slots"] = true,
		["Characters on "] = true,
    }
end)

AL:new("OneView"):RegisterTranslations("frFR", function()
    return {
--		["Show the OneView Frame"]	= "Afficher OneView",
--		
		["Quiver"]	= "Carquois",
		["Soul Bag"]	= "Sac d'\195\162me",
		["Container"]	= "Conteneur",
		["Bag"]	        = "Conteneur",
--		
		["Backpack"] = "Sac \195\160 dos",
--		["Turns display of your backpack on and off."] = true,
		["First Bag"] = "Sac 1",
--		["Turns display of your first bag on and off."] = true,
		["Second Bag"] = "Sac 2",
--		["Turns display of your second bag on and off."] = true,
		["Third Bag"] = "Sac 3",
--		["Turns display of your third bag on and off."] = true,
		["Fourth Bag"] = "Sac 4",
--		["Turns display of your fourth bag on and off."] = true,
		["First Bank Bag"] = "Banque 1",
		["Second Bank Bag"] = "Banque 2",
		["Third Bank Bag"] = "Banque 3",
		["Fourth Bank Bag"] = "Banque 4",
		["Fifth Bank Bag"] = "Banque 5",
--		["Turns display of your fifth bag on and off."] = true,
		["Sixth Bank Bag"] = "Banque 6",
--		["Turns display of your sixth bag on and off."] = true,
--              ["Show Button"] = true,
--              ["Toggles if the OneView quick button is shown."] = true,
--		
--		["Remember"] = true,
--		["Remember Selection"] = true,
--		["Toggles wether to remember which was the last character you selected."] = true,
		["%s's Bank Bags"] = "%s : Banque",
		["%s's Bags"] = "%s : Inventaire",
		["%s/%s Slots"] = "%s/%s places",
		["%s/%s Ammo"] = "%s/%s munitions",
		["%s/%s Soul Shards"] = "%s/%s fragments",
		["%s/%s Profession Slots"] = "%s/%s de profession",
--		["Characters on "] = true,
    }
end)

AL:new("OneView"):RegisterTranslations("zhCN", function()
    return {
		["Show the OneView Frame"]	= "显示OneView框体",
		
		["Quiver"]	= "箭袋",
		["Soul Bag"]	= "灵魂袋",
		["Container"]	= "背包",
		["Bag"]	= "行囊",
		
		["Backpack"] = "背包",
		["Turns display of your backpack on and off."] = "切换是否显示背包。",
		["First Bag"] = "第一个包",
		["Turns display of your first bag on and off."] = "切换是否显示第一个包。",
		["Second Bag"] = "第二个包",
		["Turns display of your second bag on and off."] = "切换是否显示第二个包。",
		["Third Bag"] = "第三个包",
		["Turns display of your third bag on and off."] = "切换是否显示第三个包。",
		["Fourth Bag"] = "第四个包",
		["Turns display of your fourth bag on and off."] = "切换是否显示第四个包。",
		["First Bank Bag"] = "第一个银行包",
		["Second Bank Bag"] = "第二个银行包",
		["Third Bank Bag"] = "第三个银行包",
		["Fourth Bank Bag"] = "第四个银行包",
		["Fifth Bank Bag"] = "第五个银行包",
		["Turns display of your fifth bag on and off."] = "切换是否显示第五个包。",
		["Sixth Bank Bag"] = "第六个银行包",
		["Turns display of your sixth bag on and off."] = "切换是否显示第六个包。",
		
		["Remember"] = "记忆",
		["Remember Selection"] = "记忆选择",
		["Toggles wether to remember which was the last character you selected."] = "切换是否记忆你选择的最后一个人物。",
		["%s's Bank Bags"] = "%s的银行",
		["%s's Bags"] = "%s的背包",
		["%s/%s Slots"] = "%s/%s背包",
		["%s/%s Ammo"] = "%s/%s弹药",
		["%s/%s Soul Shards"] = "%s/%s灵魂碎片",
		["%s/%s Profession Slots"] = "%s/%s专业袋",
		["Characters on "] = "人物所在服务器阵营：",
    }
end)

AL:new("OneView"):RegisterTranslations("deDE", function()
    return {
		["Show the OneView Frame"]	= "Zeige das OneView Fenster",
		
		["Quiver"]	= "K\195\182cher",
		["Soul Bag"]	= "Seelentasche",
		["Container"]	= "Beh\195\164lter",
		["Bag"]	= "Beh\195\164lter",
		
		["Backpack"] = "Rucksack",
		["Turns display of your backpack on and off."] = "Schaltet das Anzeigen des Rucksacks an und aus.",
		["First Bag"] = "Erste Tasche",
		["Turns display of your first bag on and off."] = "Schaltet das Anzeigen der ersten Tasche an und aus.",
		["Second Bag"] = "Zweite Tasche",
		["Turns display of your second bag on and off."] = "Schaltet das Anzeigen der zweiten Tasche an und aus.",
		["Third Bag"] = "Dritte Tasche",
		["Turns display of your third bag on and off."] = "Schaltet das Anzeigen der dritten Tasche an und aus.",
		["Fourth Bag"] = "Vierte Tasche",
		["Turns display of your fourth bag on and off."] = "Schaltet das Anzeigen der vierten Tasche an und aus.",
		["First Bank Bag"] = "Erste Bank Tasche",
		["Second Bank Bag"] = "Zweite Bank Tasche",
		["Third Bank Bag"] = "Dritte Bank Tasche",
		["Fourth Bank Bag"] = "Vierte Bank Tasche",
		["Fifth Bank Bag"] = "F\195\188nfte Bank Tasche",
		["Turns display of your fifth bag on and off."] = "Schaltet das Anzeigen der f\195\188nften Bank Tasche an und aus.",
		["Sixth Bank Bag"] = "Sechste Bank Tasche",
		["Turns display of your sixth bag on and off."] = "Schaltet das Anzeigen der sechsten Bank Tasche an und aus.",
		["Show Button"] = "Zeige Taste",
    ["Toggles if the OneView quick button is shown."] = "Schaltet das Anzeigen der OneView schnell Taste f\195\188r die Minimap bzw. Fubarleiste an und aus.",
		
		["Remember"] = "Erinnern",
		["Remember Selection"] = "Merke Auswahl",
		["Toggles wether to remember which was the last character you selected."] = "Aktiviert das merken des von dir letzten ge\195\182ffneten Charakters.",
		["%s's Bank Bags"] = "%s's Bank Taschen",
		["%s's Bags"] = "%s's Taschen",
		["%s/%s Slots"] = "%s's Pl\195\164tze",
		["%s/%s Ammo"] = "%s's Munition",
		["%s/%s Soul Shards"] = "%s's Seelensplitter",
		["%s/%s Profession Slots"] = "%s's Beruf Pl\195\164tze",
		["Characters on "] = "Charaktere auf ",
    }
end)

AL:new("OneView"):RegisterTranslations("koKR", function()
    return {
		["Show the OneView Frame"]	= "다른 캐릭터 보기 사용",
		
		["Quiver"]	= "화살통",
		["Soul Bag"]	= "영혼의 가방",
		["Container"]	= "가방",
		["Bag"]	= "가방",
		
		["Backpack"] = "소지품",
		["Turns display of your backpack on and off."] = "소지품을 열거나 닫습니다.",
		["First Bag"] = "첫번째 가방",
		["Turns display of your first bag on and off."] = "첫번째 가방을 열거나 닫습니다.",
		["Second Bag"] = "두번째 가방",
		["Turns display of your second bag on and off."] = "두번째 가방을 열거나 닫습니다.",
		["Third Bag"] = "세번째 가방",
		["Turns display of your third bag on and off."] = "세번째 가방을 열거나 닫습니다.",
		["Fourth Bag"] = "네번째 가방",
		["Turns display of your fourth bag on and off."] = "네번째 가방을 열거나 닫습니다.",
		["First Bank Bag"]	= "은행 첫번째 가방",
--		["Turns display of your first bag on and off."]	= "첫번째 가방을 열거나 닫습니다.",
		["Second Bank Bag"]	= "은행 두번째 가방",
--		["Turns display of your second bag on and off."]	= "두번째 가방을 열거나 닫습니다.",
		["Third Bank Bag"]	= "은행 세번째 가방",
--		["Turns display of your third bag on and off."]	= "세번째 가방을 열거나 닫습니다.",
		["Fourth Bank Bag"]	= "은행 네번째 가방",
--		["Turns display of your fourth bag on and off."]	= "네번째 가방을 열거나 닫습니다.",
		["Fifth Bank Bag"]	= "은행 다섯번째 가방",
		["Turns display of your fifth bag on and off."]	= "다섯번째 가방을 열거나 닫습니다.",
		["Sixth Bank Bag"]	= "은행 여섯번째 가방",
		["Turns display of your sixth bag on and off."]	= "여섯번째 가방을 열거나 닫습니다.",
		["Show Button"] = "버튼 표시",
		["Toggles if the OneView quick button is shown."] = "단축 버튼 표시 토글",
		
		["Remember"] = "보기 기억",
		["Remember Selection"] = "선택사항을 저장합니다.",
		["Toggles wether to remember which was the last character you selected."] = "마지막으로 선택한 캐릭터 보기를 기억합니다.",
		["%s's Bank Bags"] = "%s의 은행 가방",
		["%s's Bags"] = "%s의 가방",
		["%s/%s Slots"]	= "%s/%s 공간",
		["%s/%s Ammo"]	= "%s/%s 화살(탄환)",
		["%s/%s Soul Shards"]	= "%s/%s 조각",
		["%s/%s Profession Slots"]	="%s/%s 전문기술",
		["Characters on "] = "(캐릭터)",
    }
end)

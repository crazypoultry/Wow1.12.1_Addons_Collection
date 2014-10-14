-- zhTW localization by hk2717

local L = AceLibrary("AceLocale-2.2"):new("Squishy")

L:RegisterTranslations("zhTW", function() return {

	-- bindings
	["Target unit with highest priority"] = "選擇第一優先單位。",
	["Target unit with 2nd highest priority"] = "選擇第二優先單位。",
	["Target unit with 3rd highest priority"] = "選擇第三優先單位。",

	-- from combatlog
	["(.+) begins to cast (.+)."] = "(.+)開始施放(.+)。",
	["(.+) gains (.+) Mana from (.+)'s Life Tap."] = "(.+) 獲得 (.+) 法力從 (.+) 的生命分流.",
	
	-- options	
	["Default"] = "預設",
	["Smooth"] = "平滑",
	["Button"]		= "按鈕",
	["BantoBar"]	= "BantoBar",
	["Charcoal"]	= "炭畫",
	["Otravi"]		= "Otravi",
	["Perl"]		= "Perl",
	["Smudge"]		= "斑點",
	
	["always"] = "一直",
	["grouped"] = "組隊時",
	
	["Frame options"] = "框架設置",
	["Show Border"] = "顯示邊框",
	["Shows/hides the frame border."] = "顯示/隱藏框架的邊框。",
	["Show Header"] = "顯示標題",
	["Shows/hides the frame header."] = "顯示/隱藏框架的標題。",
	["Scale"] = "縮放",
	["Scales the Emergency Monitor."] = "縮放緊急狀況監視器。",
	["Number of units"] = "單位數量",
	["Number of max visible units."] = "最大顯示單位數量",
	["Frame lock"] = "鎖定框架",
	["Locks/unlocks the emergency monitor."] = "鎖定/解鎖緊急狀況監視器。",
	["Show Frame"] = "框架顯示",
	["Sets when the Squishy frame is visible: Choose 'always' or 'grouped'."] = "設置Squishy框架的顯示方式。選擇<一直>或<組隊時>。",
	["Pet support"] = "顯示寵物",
	["Toggles the display of pets in the emergency frame."] = "切換是否在緊急狀況監視器中顯示寵物。",
	
	["Unit options"] = "外觀選項",
	["Alpha"] = "透明度",
	["Changes background+border visibility"] = "設定背景與邊框的透明度。",
	["Style"] = "風格",
	["Color bar either by health, class or use the CTRA style."] = "用血量多少，職業來決定顏色，或是使用 CTRA(團隊助手) 風格",
	["Health"] = "血量",
	["Class"] = "職業",
	["CTRA"] = "CTRA(團隊助手)",
	["Texture"] = "材質",
	["Sets the bar texture. Choose 'Default', 'BantoBar', 'Button', 'Charcoal', 'Otravi', 'Perl', 'Smooth' or 'Smudge'."] = "設置狀態條的材質。選擇<暴雪>，<預設>或<平滑>。",
	["Health deficit"] = "生命減少量",
	["Toggles the display of health deficit in the emergency frame."] = "切換是否在緊急狀況監視器中顯示生命減少量。",
	["Unit bar height"] = "單位列高度",
	["Unit bar width"] = "單位列寬度",
	["Bar Spacing"] = "單位列間隔",
	["Change the spacing between bars"] = "改變單位列之間的間隔",
	["Inside Bar"] = "單位列的內部",
	["Outside Bar"] = "單位列外部",
	["Name position inside bar"] = "姓名於單位列內",
	["Show name position inside bar"] = "將姓名置於列內",
	["Class colored name"] = "姓名套用職業顏色",
	["Color names by class"] = "姓名使用職業顏色",
	
	["Class options"] = "職業選項",
	
	["Various options"] = "其他選項",
	["Audio alert on aggro"] = "取得AGGRO時發出聲音警報",
	["Toggle on/off audio alert on aggro."] = "切換是否在取得AGGRO時發出聲音警報。",
	["Log range"] = "記錄範圍",
	["Changes combat log range. Set it to your max healing range"] = "設定戰鬥記錄範圍。設定為你治療法術的最大施法距離。",
	["Version Query"] = "版本查詢",
	["Checks the group for Squishy users and prints their version data."] = "檢查團隊中 Squishy 使用者的版本。",
	["Checking group for Squishy users, please wait."] = "正在檢查團隊中 Squishy 使用者的版本，請稍後。",
	["using"] = "using",

	-- notifications in frame
	[" is healing you."] = "正在治療你。",
	[" healing your group."] = "正在治療你的小組。",
	[" died."] = " 死亡了",
	
	-- frame header
	["Squishy Emergency"] = "Squishy緊急狀況監視器",

	["Hide minimap icon"] = "隱藏小地圖按鈕",
	
	-- debuffs and other spell related locals
	["Mortal Strike"] = "致死打擊",
	["Mortal Cleave"] = "致死順劈",
	["Gehennas\' Curse"] = "基赫納斯的詛咒",
	["Curse of the Deadwood"] = "死木詛咒",
	["Blood Fury"] = "血性狂暴",
	["Brood Affliction: Green"] = "龍血之痛：綠",
	["Necrotic Poison"] = "墓地毒",
	["Conflagration"] = "燃燒",
	["Petrification"] = "化石",
} end)

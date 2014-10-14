ItemRackTitan = {};

ITEMRACK_TITAN_ID = "ItemRack";
ITEMRACK_TITAN_BUTTON_TEXT = "장비교환: ";

ITEMRACK_TITAN_TOOLTIP_TITLE = "ItemRack";
ITEMRACK_TITAN_TOOLTIP_TEXT = "Click to change outfit";
ITEMRACK_TITAN_NO_OUTFIT = "<no outfit>";
ITEMRACK_TITAN_MENU_SHOW_MINIMAP_ICON = "Show minimap icon";
ITEMRACK_TITAN_MENU_SHOW_HIDDEN_ITEMS = "List hidden items";
ITEMRACK_TITAN_MENU_COLOR_HIDDEN_ITEMS = "Color when hidden set is equipped";
ITEMRACK_TITAN_MENU_OPEN_ON_MOUSEOVER = "Open selection on mouseover";
ITEMRACK_TITAN_MENU_OPTIONS = "Options"


if (GetLocale() == "deDE") then
   ITEMRACK_TITAN_TOOLTIP_TEXT = "Klicken um anderes Set anzulegen"
   ITEMRACK_TITAN_NO_OUTFIT = "<kein Set angelegt>"
   ITEMRACK_TITAN_MENU_SHOW_MINIMAP_ICON = "Show minimap icon"
   ITEMRACK_TITAN_MENU_SHOW_HIDDEN_ITEMS = "Versteckte Sets aufz\195\164hlen"
   ITEMRACK_TITAN_MENU_OPTIONS = "Optionen"

elseif (GetLocale() == "koKR") then
   ITEMRACK_TITAN_TOOLTIP_TITLE = "장비교환";
   ITEMRACK_TITAN_TOOLTIP_TEXT = "클릭하면 장비셋을 교환할 수 있습니다.";
   ITEMRACK_TITAN_NO_OUTFIT = "<장비없음>";
   ITEMRACK_TITAN_MENU_SHOW_MINIMAP_ICON = "미니맵 아이콘 보기";
   ITEMRACK_TITAN_MENU_SHOW_HIDDEN_ITEMS = "List hidden items";
ITEMRACK_TITAN_MENU_COLOR_HIDDEN_ITEMS = "세트 장착시 색으로 표시";
ITEMRACK_TITAN_MENU_OPEN_ON_MOUSEOVER = "마우스를 가져다 대면 설정 보기";
   ITEMRACK_TITAN_MENU_OPTIONS = "설정";
end
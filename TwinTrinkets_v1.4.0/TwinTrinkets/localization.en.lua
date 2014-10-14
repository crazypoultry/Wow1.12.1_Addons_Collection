--localization.en.lua
--TwinTrinkets enUS/Default.
--1.2.2


BINDING_HEADER_JT_TWINTRINKETS = "Twin Trinkets";
BINDING_NAME_JT_TRINKET = "Trinket only";
_,pc = UnitClass("player");
if (pc == "PRIEST") then
 BINDING_NAME_JT_TRINKETAPANDPOM = "Trinket + PI"
 BINDING_NAME_JT_TRINKETAPPOM = "Trinket + PI";
 BINDING_NAME_JT_TRINKETPOM = "Trinket only";
 BINDING_NAME_JT_TRINKETORPOM = "Trinket only";
elseif (pc == "SHAMAN") then
 BINDING_NAME_JT_TRINKETAPANDPOM = "Trinket + EM"
 BINDING_NAME_JT_TRINKETAPPOM = "Trinket + EM";
 BINDING_NAME_JT_TRINKETPOM = "Trinket only";
 BINDING_NAME_JT_TRINKETORPOM = "Trinket only";
elseif (pc == "MAGE") then
 BINDING_NAME_JT_TRINKETAPANDPOM = "Trinket + AP + PoM"
 BINDING_NAME_JT_TRINKETAPPOM = "(Trinket + AP) / PoM";
 BINDING_NAME_JT_TRINKETPOM = "Trinket + PoM";
 BINDING_NAME_JT_TRINKETORPOM = "Trinket / PoM";
else
 BINDING_NAME_JT_TRINKETAPANDPOM = "Trinket only"
 BINDING_NAME_JT_TRINKETAPPOM = "Trinket only";
 BINDING_NAME_JT_TRINKETPOM = "Trinket only";
 BINDING_NAME_JT_TRINKETORPOM = "Trinket only";
end

sTrinket_EnableSwapping = "Enable swapping";
sTrinket_EnableSwappingDescription = "If checked, TwinTrinkets will attempt to equip trinkets based on the priority list below.";
sTrinket_UseBothSlots = "Use both slots";
sTrinket_UseBothDescription = "If checked, TwinTrinkets will use both slots to equip trinkets. Otherwise, TwinTrinkets will only swap trinkets into the top trinket slot.";
sTrinket_LockUI = "Lock position";
sTrinket_LockUIDescription = "If not checked, the trinket/spell icon frame will display a draggable header.";
sTrinket_ShowUI = "Show icons frame";
sTrinket_ShowUIDescription = "If checked, TwinTrinkets will display the cooldown feedback frame.";
sTrinket_HotSwap_Header = "TwinTrinkets Configuration";
sTrinket_HotSwap_PriorityHeader = "Trinket Swapping";
sTrinket_HotSwap_Detail = "Drop trinkets over this window to add them to the list. Top two/one 'ready' trinkets will be equipped. Right click to remove.";
sTrinket_DoNotSwapOut = "Do not swap out if ready";
sTrinket_DoNotSwapOutDescription = "If checked, this trinket will not be swapped out when its cooldown is 0.";

sTrinket_Menu_Title = "TwinTrinkets";
sTrinket_Menu_Lock = "Lock this frame";
sTrinket_Menu_Options = "Configure swapping";

sTrinket_SH_Main = GREEN_FONT_COLOR_CODE .. "/%s|r\nShow TwinTrinkets configuration dialog.";
sTrinket_SH_Use = GREEN_FONT_COLOR_CODE .. "/%s|r" .. HIGHLIGHT_FONT_COLOR_CODE .. " [things to use]|r\n         Activate specified spells/trinkets. Combine as needed. \n         " .. HIGHLIGHT_FONT_COLOR_CODE .. "trinket|r - Use a trinket.";
sTrinket_SH_UseLine = HIGHLIGHT_FONT_COLOR_CODE .. "         %s|r - Use %s.";
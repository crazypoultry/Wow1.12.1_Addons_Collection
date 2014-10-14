Trinket_TrinketsInfo = {
		--GENERIC +DAMAGE
		[18820] = {name="ToEP",cool=90,duration=15},
		[19950] = {name="ZHC",cool=120,duration=20},
		[19949] = {name="ZHM",cool=120,duration=20},
		[19948] = {name="ZHB",cool=120,duration=20},
		[22268] = {name="DIE",cool=75,duration=15},
		[22678] = {name="ToA",cool=60,duration=20},

		--ZG Summon TRINKETS
		[19959] = {name="HCoM",cool=180,duration=20}, -- Mage
		[19957] = {name="HCoD",cool=180,duration=20}, -- Warlock
		[19958] = {name="HCoH",cool=180,duration=15}, -- Priest
		[19954] = {name="RCoT",cool=180,duration=0}, -- Rogue
		[19955] = {name="WCoN",cool=180,duration=15}, -- Druid
		[19953] = {name="RCoB",cool=180,duration=0}, -- Hunter
		[19956] = {name="WCoS",cool=180,duration=20}, -- Shaman
		[19951] = {name="GCoM",cool=180,duration=0}, -- Warrior
		[19952] = {name="GCoV",cool=180,duration=15}, -- Paladin

		--BWL TRINKETS
		[19339] = {name="MQG",cool=300,duration=20,noPoM=true}, -- Mage
		[19337] = {name="TBB",cool=300,duration=20}, -- Warlock
		[19342] = {name="VT",cool=300,duration=20}, -- Rogue
		[19340] = {name="RoM",cool=300,duration=20}, -- Druid
		[19344] = {name="NAC",cool=300,duration=20}, -- Shaman
		[19336] = {name="AIG",cool=300,duration=20}, -- Hunter
		[19343] = {name="SoBL",cool=300,duration=20}, -- Paladin
		[19341] = {name="LG",cool=300,duration=20}, -- Warrior

		-- AQ
		[21647] = {name="FoSR", cool=180,duration=20}, -- Fetish of the Sand Reaver
		[23570] = {name="JG", cool=120, duration=20}, -- Jom Gabbar
		[21670] = {name="BotS", cool=180, duration=30,exclusive=false}, -- Badge of the Swarm Guard

		-- NAXX
		[22954] = {name="KotS",cool=120,duration=15}, -- Kiss of the Spider

		--MISC
		[21180] = {name="ES",cool=120,duration=20}, -- Earthstrike
		[21473] = {name="EoM",cool=180,duration=30}, -- Eye of Moam
		[20636] = {name="HC",cool=90,duration=15}, -- Hibernation Crystal
		[19947] = {name="NPBR",cool=75,duration=15}, -- Nat Pagle's Broken Reel
		[11832] = {name="BoK",cool=900,duration=10, exclusive=false}, -- Burst of Knowledge
		[20036] = {name="FR",cool=180,duration=10}, -- Fire Ruby (mage)
		[19990] = {name="BPB",cool=120,duration=20}, -- Blessed Prayer Beads (priest)
		[19991] = {name="DE",cool=120,duration=20}, -- Devilsaur Eye (hunter)
		[20130] = {name="DF",cool=360,duration=60}, -- Diamond Flask (warrior)
		[20512] = {name="SO",cool=180,duration=25} -- Sanctified Orb (paladin)
		};
Trinket_SpellsInfo = {
		{name="AP",cool=180,duration=15,texture="Spell_Nature_Lightning",class="MAGE",ck=1},
		{name="PoM",cool=180,duration=1,texture="Spell_Nature_EnchantArmor",class="MAGE",ck=2},
		{name="Cmb",cool=180,duration=1,texture="Spell_Fire_SealOfFire",class="MAGE",ck=1},
		{name="PI",cool=180,duration=15,texture="Spell_Holy_PowerInfusion",class="PRIEST",ck=1},
		{name="EM",cool=180,duration=1,texture="Spell_Nature_WispHeal",class="SHAMAN",ck=1}
		};
Trinket_EquipPrio = {

		};

Trinket_Usable = {};

Trinket_DoDebug = 0;

Trinket_Locked = 1;
Trinket_TrinketCount = 0;
Trinket_SpellCount = 0;
Trinket_HotSwapSlots = 2;
Trinket_NextPrioUpdate = 0;
Trinket_LocationCache = {}; -- [itemid] = {bag,slot};
Trinket_CursorItemId = 0;
Trinket_InstancedPrioLines = 0;
Trinket_LockFrame = false;
Trinket_ShowFrame = true;

function Trinket_Load()
 this:RegisterEvent("SPELLS_CHANGED");
 this:RegisterEvent("UNIT_INVENTORY_CHANGED");
 this:RegisterEvent("PLAYER_ENTERING_WORLD");
 this:RegisterEvent("PLAYER_LEAVING_WORLD");
 this:RegisterEvent("PLAYER_REGEN_ENABLED");
 this:RegisterEvent("VARIABLES_LOADED");
 Trinket_PickupContainerItem_Orig = PickupContainerItem; PickupContainerItem = Trinket_PickupContainerItem;
 Trinket_PickupInventoryItem_Orig = PickupInventoryItem; PickupInventoryItem = Trinket_PickupInventoryItem;
 Trinket_EnableSwappingText:SetText(sTrinket_EnableSwapping);
 Trinket_UseBothSlotsText:SetText(sTrinket_UseBothSlots);
 Trinket_ShowUIText:SetText(sTrinket_ShowUI);
 Trinket_LockUIText:SetText(sTrinket_LockUI);
 Trinket_EnableSwapping.tooltipText = sTrinket_EnableSwappingDescription;
 Trinket_UseBothSlots.tooltipText = sTrinket_UseBothDescription;
 Trinket_ShowUI.tooltipText = sTrinket_ShowUIDescription;
 Trinket_LockUI.tooltipText = sTrinket_LockUIDescription;
end
function Trinket_PickupContainerItem(a,b)
 local lnk = GetContainerItemLink(a,b);
 _,_, lnk = string.find(tostring(lnk),"item:(%d+):");
 Trinket_CursorItemId = tonumber(lnk);
 Trinket_PickupContainerItem_Orig(a,b);
end
function Trinket_PickupInventoryItem(a,b,c)
 local lnk = GetInventoryItemLink("player",a);
 _,_, lnk = string.find(tostring(lnk),"item:(%d+):");
 Trinket_CursorItemId = tonumber(lnk);
 Trinket_PickupInventoryItem_Orig(a); 
end

SLASH_TWINTRINKET1 = "/tt";
SLASH_TWINTRINKET2 = "/trinkets";
SlashCmdList["TWINTRINKET"] = function (msg)
 Trinket_Container:Show();
end
SLASHHELP_TWINTRINKET = function (text, alias) 
 SlashHelp_AddLine(string.format(sTrinket_SH_Main,alias));
 return true;
end
SLASH_USETWINTRINKET1 = "/usett";
SLASH_USETWINTRINKET2 = "/usetrinket";
SlashCmdList["USETWINTRINKET"] = function (msg)
 msg = strlower(msg);
 local uT, uP, uA = (string.find(msg,"trinket") ~= nil), (string.find(msg,"pom") ~= nil), (string.find(msg,"ap") ~= nil) or (string.find(msg,"em") ~= nil) or (string.find(msg,"pi") ~= nil) or (string.find(msg,"cmb") ~= nil); -- Trinket, PoM, AP
 if (uT or uP or uA) then
  Trinket_UseTrinket(uT and 1 or 0,uP and 1 or 0,uA and 1 or 0);
 end
end
SLASHHELP_USETWINTRINKET = function (text, alias) 
 local i;
 SlashHelp_AddLine(string.format(sTrinket_SH_Use,alias));
 for i=1,2 do
  local cu, sn, sk = Trinket_CanCastSpell(i);
  if (cu) then
   SlashHelp_AddLine(string.format(sTrinket_SH_UseLine,strlower(sk),sn));
  end
 end
 return true;
end


function Trinket_OnEvent()
 if (event == "PLAYER_ENTERING_WORLD" and Trinket_Locked == 1) then
  Trinket_ScanTrinkets();
  Trinket_ScanSpells();
  Trinket_UpdateUI();
  Trinket_Locked = 0;
 elseif (event == "PLAYER_LEAVING_WORLD") then
  Trinket_Locked = 1;
 elseif (event == "UNIT_INVENTORY_CHANGED" and arg1 == "player" and Trinket_Locked ~= 1) then
  Trinket_ScanTrinkets();
  Trinket_UpdateUI();
 elseif (event == "SPELLS_CHANGED" and arg1 == nil and Trinket_Locked ~= 1) then
  Trinket_ScanSpells();
  Trinket_UpdateUI();
 elseif (event == "PLAYER_REGEN_ENABLED") then
  Trinket_CheckPriorityList();
 elseif (event == "VARIABLES_LOADED") then
  Trinket_ShowFrame = Trinket_ShowFrame == nil and true or Trinket_ShowFrame;
  Trinket_LockFrame = Trinket_LockFrame == nil and true or Trinket_LockFrame;
  Trinket_HotSwapSlots = Trinket_HotSwapSlots == nil and 2 or Trinket_HotSwapSlots;
  if (Trinket_EquipPrio == nil) then Trinket_EquipPrio = {}; end
  Trinket_EnableSwapping:SetChecked(Trinket_HotSwapSlots > 0);
  Trinket_UseBothSlots:SetChecked(Trinket_HotSwapSlots > 1);
  Trinket_ShowUI:SetChecked(Trinket_ShowFrame);
  Trinket_LockUI:SetChecked(Trinket_LockFrame);
  Trinket_UpdatePriorityList();
  Trinket_UpdateUI();
 end
end
function Trinket_ScanTrinkets()
 Trinket_TrinketCount, Trinket_Usable[1], Trinket_Usable[2] = 0, nil, nil;
 local i;
 for i=0,1 do
  local lnk = GetInventoryItemLink("player",GetInventorySlotInfo("Trinket" .. i .. "Slot"));
  if (lnk ~= nil) then
   _, _, lnk = string.find(tostring(lnk),"item:(%d+):");
   if (lnk ~= nil and Trinket_TrinketsInfo[tonumber(lnk)] ~= nil) then
    Trinket_TrinketCount = Trinket_TrinketCount + 1;
    Trinket_Usable[Trinket_TrinketCount] = {tonumber(lnk),GetInventorySlotInfo("Trinket" .. i .. "Slot")};
    Trinket_Debug("Detected " .. Trinket_TrinketsInfo[tonumber(lnk)].name .. " in Trinket" .. i .. "Slot");
   end
  end
 end
end
function Trinket_ScanSpells()
 local key, val, i, myclass = GetSpellTabInfo(2);
 _, myclass = UnitClass("player");
 Trinket_SpellCount, Trinket_Usable[3], Trinket_Usable[4] = 0, nil, nil;
 
 for key, val in Trinket_SpellsInfo do
  Trinket_SpellsInfo[key].castId, Trinket_SpellsInfo[key].castName = nil, nil;
 end

 while true do
  i = i + 1;
  sName, sRank = GetSpellName(i,BOOKTYPE_SPELL)
  if (sName == nil) then break; end
  for key, val in Trinket_SpellsInfo do
   if (val.class == myclass and string.find(GetSpellTexture(i,BOOKTYPE_SPELL),val.texture .. "$") ~= nil) then
    Trinket_SpellCount = Trinket_SpellCount + 1;
    Trinket_Usable[Trinket_SpellCount+2] = {key, i};
    Trinket_SpellsInfo[key].castId, Trinket_SpellsInfo[key].castName  = i, GetSpellName(i,BOOKTYPE_SPELL);
    Trinket_Debug("Detected " .. val.name .. " as Spell #" .. i .. " (" .. GetSpellName(i,BOOKTYPE_SPELL) .. ")");
   end
  end
 end

end
function Trinket_UpdateUI()
 if ((Trinket_TrinketCount + Trinket_SpellCount) == 0 or not Trinket_ShowFrame) then
  Trinket_Feedback:Hide();
  return;
 else
  Trinket_Feedback:Show();
  Trinket_Feedback:SetWidth(36*(Trinket_TrinketCount + Trinket_SpellCount)-4);
  if (Trinket_LockFrame) then
   Trinket_FeedbackMoveBox:Hide();   
  else
   Trinket_FeedbackMoveBox:Show();
  end
 end

 local i = 0;
 for key, val in Trinket_Usable do
  i = i + 1;
  getglobal("Trinket_Btn" .. i):Show();
  if (key <= 2) then
   local _, _, _, _, _, _, _, _, itemTexture  = GetItemInfo(Trinket_Usable[key][1]);
   getglobal("Trinket_Btn" .. i .. "IconTexture"):SetTexture(itemTexture);
  else
   getglobal("Trinket_Btn" .. i .. "IconTexture"):SetTexture(GetSpellTexture(Trinket_Usable[key][2],BOOKTYPE_SPELL));
  end
  Trinket_Usable[key][3] = i;
  getglobal("Trinket_Btn" .. i).useId = key;
 end
 for i = (Trinket_TrinketCount + Trinket_SpellCount+1),4 do
  getglobal("Trinket_Btn" .. i):Hide();
 end
end

function Trinket_IsInUse()
 local i;
 for i=1,2 do
  if (Trinket_Usable[i] ~= nil) then
   local start, duration = GetInventoryItemCooldown("player",Trinket_Usable[i][2]);
   local left = start + duration - GetTime();
   if (start > 0 and left > duration - Trinket_TrinketsInfo[Trinket_Usable[i][1]].duration) then
    return start+duration;
   end
  end
 end
 return 0;
end

function Trinket_UseTrinket(useTrinket, usePoM, useAP)
 local Trinket_InUse = Trinket_IsInUse();
 Trinket_Debug("Trinkets call (" .. useTrinket .. ", " .. usePoM .. ", " .. useAP .. "). InUse: " .. Trinket_InUse);

 if (useTrinket == 1) then
  -- Check any trinkets that might be up, use them.
  local usedTrinket, usedExclusive = (Trinket_InUse > 0), false;
  for i=1,2 do
   if (Trinket_Usable[i] ~= nil and GetInventoryItemCooldown("player",Trinket_Usable[i][2]) == 0) then
    if (Trinket_TrinketsInfo[Trinket_Usable[i][1]].exclusive == false or usedExclusive == false) then
     Trinket_Debug("Activating " .. Trinket_TrinketsInfo[Trinket_Usable[i][1]].name .. " in slot " .. Trinket_Usable[i][2]);
     SpellStopCasting();
     UseInventoryItem(Trinket_Usable[i][2]);
     usedTrinket, usedExclusive = true, (Trinket_TrinketsInfo[Trinket_Usable[i][1]].exclusive ~= false);
     Trinket_NextPrioUpdate = min(GetTime() + Trinket_TrinketsInfo[Trinket_Usable[i][1]].duration+1,Trinket_NextPrioUpdate);
     SpellStopCasting();
     if (Trinket_TrinketsInfo[Trinket_Usable[i][1]].noPoM ~= nil) then
      usePoM = false;
     end
    end
   end
  end
 end
 if (((Trinket_InUse > 0 or usedTrinket == false) and usePoM == 1) or usePoM == 2) then
  Trinket_CastSpell(2);
  SpellStopCasting();
 end

 if (useAP == 1) then
  Trinket_CastSpell(1);
 end
end
function Trinket_CastSpell(spellType)
 local key, val;
 for key, val in Trinket_SpellsInfo do
  if (val.ck == spellType and val.castId ~= nil) then
   if (GetSpellCooldown(val.castId,BOOKTYPE_SPELL) == 0) then
    CastSpellByName(val.castName,1);
    Trinket_Debug("Activated " .. val.castName);
   else
    Trinket_Debug(val.castName .. " is cooling");
   end
  end
 end
end
function Trinket_CanCastSpell(spellType)
 local key, val;
 for key, val in Trinket_SpellsInfo do
  if (val.ck == spellType and val.castId ~= nil) then
   return true, val.castName, val.name;
  end
 end
end


function Trinket_Update()
 local i, j, start, duration, cool, eduration, name;
 j = 0;
 for i=1,4 do
  if (Trinket_Usable[i] ~= nil and Trinket_Usable[i][3] ~= nil) then
   j = j + 1;
   if (i < 3) then
    cool = Trinket_TrinketsInfo[Trinket_Usable[i][1]].cool;
    eduration = Trinket_TrinketsInfo[Trinket_Usable[i][1]].duration;
    name = Trinket_TrinketsInfo[Trinket_Usable[i][1]].name
    start, duration = GetInventoryItemCooldown("player",Trinket_Usable[i][2]);
   else
    cool = Trinket_SpellsInfo[Trinket_Usable[i][1]].cool;
    eduration = Trinket_SpellsInfo[Trinket_Usable[i][1]].duration;
    name = Trinket_SpellsInfo[Trinket_Usable[i][1]].name
    start, duration = GetSpellCooldown(Trinket_Usable[i][2],BOOKTYPE_SPELL);
   end
   
   if (duration ~= nil and duration > 2) then
    if (duration < 2) then duration = cool - 0.0001; end
    local left = start + duration - GetTime();
    getglobal("Trinket_Btn" .. j .. "Time"):SetText(ceil(left));
    getglobal("Trinket_Btn" .. j):Disable();
    getglobal("Trinket_Btn" .. j .. "IconTexture"):SetDesaturated(1);
    if (duration == cool and GetTime() - start < eduration) then
     getglobal("Trinket_Btn" .. j .. "Time"):SetText(ceil(eduration - GetTime() + start));
     getglobal("Trinket_Btn" .. j .. "Time"):SetVertexColor(0.1,1,0.1);
    else
     getglobal("Trinket_Btn" .. j .. "Time"):SetVertexColor(1,0.1,0.1);
    end
   else
    getglobal("Trinket_Btn" .. j .. "Time"):SetText(name);
    getglobal("Trinket_Btn" .. j .. "Time"):SetVertexColor(1,1,1);
    getglobal("Trinket_Btn" .. j):Enable();
    getglobal("Trinket_Btn" .. j .. "IconTexture"):SetDesaturated(0);
   end
  end
 end
end
function Trinket_TimerDummy()
 if (GetTime() > Trinket_NextPrioUpdate and Trinket_UnitIsAlive("player") and not UnitAffectingCombat("player")) then
  Trinket_CheckPriorityList();
 end
end

function Trinket_GetTrinketItemId(slt)
 local lnk = GetInventoryItemLink("player",GetInventorySlotInfo("Trinket" .. slt .. "Slot"));
 if (lnk == nil) then
  return 0;
 end
 _,_, lnk = string.find(lnk,"item:(%d+):");
 return tonumber(lnk);
end
function Trinket_CheckPriorityList()
 Trinket_NextPrioUpdate = GetTime() + 1;
 if (Trinket_HotSwapSlots == 0) then
  return false;
 end

 local key, val, lnk1, lnk2, coolStart, coolDuration;
 local seen1, seen2 = false, false;

 local use1, use2, slt1, slt2 = (Trinket_HotSwapSlots > 0), (Trinket_HotSwapSlots > 1), GetInventorySlotInfo("Trinket0Slot"), GetInventorySlotInfo("Trinket1Slot");

 if (not (use1 or use2)) then
  return;
 end

 lnk1, lnk2 = Trinket_GetTrinketItemId(0), Trinket_GetTrinketItemId(1);
 for key, val in Trinket_EquipPrio do
  if (val.id == lnk1) then
   seen1 = true;
   coolStart, coolDuration = GetInventoryItemCooldown("player",slt1);
   if (not val.swap) then
    use1 = use1 and ((coolStart + coolDuration - GetTime()) > 31);
   end
   if (Trinket_TrinketsInfo[val.id] ~= nil and coolDuration == Trinket_TrinketsInfo[val.id].cool and (GetTime() - coolStart) < Trinket_TrinketsInfo[val.id].duration) then
    use1 = false;
   end
  elseif (val.id == lnk2) then
   seen2 = true;
   coolStart, coolDuration = GetInventoryItemCooldown("player",slt2);
   if (not val.swap) then
    use2 = use2 and ((coolStart + coolDuration - GetTime()) > 31);   
   end
   if (Trinket_TrinketsInfo[val.id] ~= nil and coolDuration == Trinket_TrinketsInfo[val.id].cool and (GetTime() - coolStart) < Trinket_TrinketsInfo[val.id].duration) then
    use2 = false;
   end
  end
 end
 use1 = use1 and seen1;
 use2 = use2 and seen2;
 local swapcount = (use1 and 1 or 0) + (use2 and 1 or 0);
 if (swapcount == 0) then
  return;
 end

 local prilist = {};
 for key, val in Trinket_EquipPrio do
  local cd, bag, slot = Trinket_FindCooldownOfItem(val.id);
  if (cd < 30 and bag ~= -10) then
   Trinket_EquipTrinket(bag,slot, use1 and slt1 or slt2);
   Trinket_ScanTrinkets();
   Trinket_UpdateUI();
   break;
  elseif (cd <= 30 and bag == -10 and val.swap) then
   if (slot == slt1) then
    use1 = false;
   else
    use2 = false;
   end
   swapcount = swapcount - 1;
   if (swapcount == 0) then
    break;
   end
  end
 end
end
function Trinket_FindCooldownOfItem(item)
 local i, j, start, duration, left;
 for i=0,1 do
  local lnk = GetInventoryItemLink("player",GetInventorySlotInfo("Trinket" .. i .. "Slot"));
  if (lnk ~= nil) then
   _, _, lnk = string.find(tostring(lnk),"item:(%d+):");
   if (tonumber(lnk) == item) then
    start, duration = GetInventoryItemCooldown("player",GetInventorySlotInfo("Trinket" .. i .. "Slot"));
    if (start > 0) then
     start = start + duration - GetTime();
    end
    return start,-10,GetInventorySlotInfo("Trinket" .. i .. "Slot");
   end
  end
 end
 if (Trinket_LocationCache[item] ~= nil) then
  i,j = Trinket_LocationCache[item][1], Trinket_LocationCache[item][2];
  local link = GetContainerItemLink(i, j);
  if (link ~= nil) then
   local _, _, id = string.find(link, "item:(%d+):");
   if (tonumber(id) == item) then
    Trinket_LocationCache[item] = {i,j};
    start, duration = GetContainerItemCooldown(i,j);
    if (start > 0) then
     start = start + duration - GetTime();
    end
    return start,i,j;
   end
  end
 end
 
 for i=0, 4 do
  for j = 1, GetContainerNumSlots(i) do
   local link = GetContainerItemLink(i, j);
   if (link ~= nil) then
    local _, _, id = string.find(link, "item:(%d+):");
    if (tonumber(id) == item) then
     Trinket_LocationCache[item] = {i,j};
     start, duration = GetContainerItemCooldown(i,j);
     if (start > 0) then
      start = start + duration - GetTime();
     end
     return start,i,j;
    end
   end
  end
 end

 return 9999,-11,0;
end
function Trinket_EquipTrinket(bag, slot, toSlot)
 PickupContainerItem(bag,slot);
 EquipCursorItem(toSlot);
end

function Trinket_UpdatePriorityList()
 local i;
 for i=1,table.getn(Trinket_EquipPrio) do
  Trinket_UpdatePrioritySlot(i,Trinket_EquipPrio[i].id,Trinket_EquipPrio[i].swap);
  getglobal("Trinket_Prio" .. i):Show();
  if (i == 1) then
   getglobal("Trinket_Prio" .. i .. "MoveUp"):Disable();
  end
  if (i == table.getn(Trinket_EquipPrio)) then
   getglobal("Trinket_Prio" .. i .. "MoveDown"):Disable();
  else
   getglobal("Trinket_Prio" .. i .. "MoveDown"):Enable();
  end
 end
 for i=table.getn(Trinket_EquipPrio)+1,Trinket_InstancedPrioLines do
  getglobal("Trinket_Prio" .. i):Hide();
 end
 Trinket_Container:SetHeight(74+36*table.getn(Trinket_EquipPrio)+Trinket_ContainerListHeader:GetHeight()+Trinket_ContainerListDescription:GetHeight());
end
function Trinket_UpdatePrioritySlot(slot,itemId,swap)
 local frm = getglobal("Trinket_Prio" .. slot); 
 if (frm == nil) then
  frm = CreateFrame("BUTTON", "Trinket_Prio" .. slot, Trinket_Container, "Trinket_TrinketLine");
  frm:SetPoint("TOPLEFT",Trinket_ContainerListDescription,"BOTTOMLEFT",-2,31-36*slot);
  frm:SetID(slot);
  Trinket_InstancedPrioLines = max(Trinket_InstancedPrioLines,slot);
  getglobal("Trinket_Prio" .. slot .. "SwapOut").tooltipText = sTrinket_DoNotSwapOutDescription;
  getglobal("Trinket_Prio" .. slot .. "SwapOutText"):SetText(sTrinket_DoNotSwapOut);
 end
 local itemName, itemLink, itemRarity, _, _, _, _, itemEquipLoc, itemTexture  = GetItemInfo(itemId);
 getglobal("Trinket_Prio" .. slot .. "Name"):SetText(itemName);
 getglobal("Trinket_Prio" .. slot .. "IcoIconTexture"):SetTexture(itemTexture);
 getglobal("Trinket_Prio" .. slot .. "Ico").itemLink = itemLink;
 local r,g,b = GetItemQualityColor(itemRarity)
 getglobal("Trinket_Prio" .. slot .. "Name"):SetTextColor(r,g,b);
 getglobal("Trinket_Prio" .. slot .. "SwapOut"):SetChecked(not swap);
end
function Trinket_MovePrioList(slot, direction)
 if (Trinket_EquipPrio[slot] ~= nil and Trinket_EquipPrio[slot + direction] ~= nil) then
  local buffer = Trinket_EquipPrio[slot];
  Trinket_EquipPrio[slot] = Trinket_EquipPrio[slot+direction];
  Trinket_EquipPrio[slot+direction] = buffer;
  Trinket_UpdatePrioritySlot(slot,Trinket_EquipPrio[slot].id,Trinket_EquipPrio[slot].swap);
  Trinket_UpdatePrioritySlot(slot+direction,Trinket_EquipPrio[slot+direction].id,Trinket_EquipPrio[slot+direction].swap);
  if (not UnitAffectingCombat("player")) then
   Trinket_CheckPriorityList();
  end
 end
end
function Trinket_PrioListAttemptDrop(onID)
 if (Trinket_CursorItemId ~= nil and CursorHasItem()) then
  local itemName, itemLink, itemRarity, _, _, _, _, itemEquipLoc, itemTexture  = GetItemInfo(Trinket_CursorItemId);
  if (itemEquipLoc == "INVTYPE_TRINKET") then
   local i;
   for i=1,table.getn(Trinket_EquipPrio) do
    if (Trinket_EquipPrio[i].id == Trinket_CursorItemId) then
     ClearCursor();
     return;
    end
   end
   if (onID ~= nil) then
    tinsert(Trinket_EquipPrio,onID,{id=Trinket_CursorItemId,swap=true});
   else 
    tinsert(Trinket_EquipPrio,{id=Trinket_CursorItemId,swap=true});
   end
   Trinket_UpdatePriorityList();
   ClearCursor();
  end
 end
end
function Trinket_PrioListRemove(id)
 table.remove(Trinket_EquipPrio,id);
 Trinket_UpdatePriorityList();
end
function Trinket_UpdateHotswapSlots()
 local c1, c2 = Trinket_EnableSwapping:GetChecked(), Trinket_UseBothSlots:GetChecked();
 if (c1 == 1 and c2 == 1) then
  Trinket_HotSwapSlots = 2;
 elseif (c1 == 1) then
  Trinket_HotSwapSlots = 1;
 else
  Trinket_HotSwapSlots = 0;
 end
end

function Trinket_UnitIsAlive(unit)
 if (not UnitIsDeadOrGhost(unit)) then
  return true;
 end
 local i=1;
 while (UnitBuff(unit, i)) do
  if (string.find(UnitBuff(unit, i), "Ability_Rogue_FeignDeath")) then
   return true;
  end
  i = i + 1;
 end
 return false;
end

function Trinket_Debug(text)
 if (Trinket_DoDebug == 1) then
  DEFAULT_CHAT_FRAME:AddMessage(text,1,0.7,0.3);
 end
end

function Trinket_ButtonClick()
 if (this.useId ~= nil and this.useId < 3) then
  UseInventoryItem(Trinket_Usable[this.useId][2]);
 elseif (this.useId ~= nil and this.useId > 2) then
  CastSpellByName(Trinket_SpellsInfo[Trinket_Usable[this.useId][1]].castName,1);
 end
end
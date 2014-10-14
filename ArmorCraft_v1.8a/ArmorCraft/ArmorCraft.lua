--[[ ArmorCraft: Find the best armor that can be crafted for a level.
    Written by Vincent of Blackhand, (copyright (c) 2005-2006 by D.A.Down)

    Version history:
    1.8 - Now uses CharacterProfiler data instead of CharactersViewer.
    1.7.3 - Added command line help (CmdHelp)
    1.7.2 - WoW 1.12 update.
    1.7.1 - WoW 1.11 update.
    1.7 - WoW 1.10 update.
    1.6.4 - Updated French localization (by Verdhit of Eitrigg)
    1.6.3 - Fixed loot window paste link to chat.
    1.6.2 - Shift-click on equipment pastes link in chat edit.
    1.6.1 - Added right-click of craft selection to skip.
    1.6 - Added comparison of loot, group loot and chat link items.
    1.5.3 - Added off-hand weapon comparison.
    1.5.2 - Fixed engineer trickets not being recognized.
    1.5.1 - Fixed bug with switching between slot #1 & #2
    1.5 - WoW 1.9 update.
    1.4.3 - Fixed some German words.
    1.4.2 - Updated German localization.
    1.4.1 - Fixed 40+ hunter to not use shields.
    1.4 - Expanded buf value table with values by class.
    1.3.3 - Fix for dynamic tradeskill loading in WoW 1.8
    1.3.2 - Corrected weapon use table for axes.
    1.3.1 - WoW 1.7 update.
    1.3 - Added 2 slots and weapon crafting selection.
    1.2.6.1 - Fixed some minor item comparison logic errors.
    1.2.6 - Added support for MPO and '/ac <GCV name>'.
    1.2.5 - Added support for GCV and neck/ring/trinket items.
    1.2.4 - Added support for shields and off-hand trinkets.
    1.2.3 - Added support for comparing party member items.
    1.2.2 - Removed debug call.
    1.2.1 - Added armor or weapon comparison for target player.
    1.2 - Added armor or weapon comparison for CV characters.
    1.1.2 - Added paired tooltip for easier comparison.
    1.1.1 - Updated for CharactersViewer 0.67 compatability.
    1.1 - Displays calculated value and accepts custom values.
    1.0.2 - Moves the AC button if KC_EnhancedTrades is present.
    1.0.1 - Updated French localization.
    1.0 - Adds attribute weighting to prefered armor selection.
    0.8 - Adds support for CharactersViewer target selection.
    0.7 - Adds a target window for comparing equipment.
    0.6.3 - Adds AC button to trade skill window.
    0.6.2 - WoW 1.6, current chat window, German localization.
    0.6.1 - added target selection and 40+ upgrade.
    0.6 -  Initial public release.
]]--

local FCg = "|cff40c040" -- Green
local FCr = "|cffff0000" -- Red
local FCw = "|cffffffff" -- White
local FCy = "|cff9d9d9d" -- Grey
local White = {r=1,g=1,b=1}
local Gray = {r=0.5,g=0.5,b=0.5}
local Green = {r=0,g=1,b=0}
local Red = {r=1,g=0,b=0}
local CP_nr = 0
local function print(msg) SELECTED_CHAT_FRAME:AddMessage("AC: "..msg,0.5,1,0) end
local function debug(msg) if ACdebug then print(msg) end end

local FCrare = {[0]="|cff9d9d9d","|cffffffff","|cff1eff00","|cff0070dd",
                    "|cffa335ee","|cffff8000","|cff57BDFB"}
local function ItemLink(item)
    local name,ilink,rare = GetItemInfo(item)
    return format("%s|H%s|h[%s]|h|r",FCrare[rare],ilink,name)
end

local function LinkItem(link)
    if link then
      local i,j,item = strfind(link,"(item:%d+:%d+:%d+:%d+)")
      return item
    end
end

local function AC_Is2H(link)
    ArmorCraft_TT:SetHyperlink(link)
    local desc = AC_Parse()
    return desc.loc==AC_TWO
end

local function sorted_index(table)
    local index = {}
    for key in table do tinsert(index,key) end
    sort(index)
    return index
end

-- Global data
AC_Unit = "player"
ArmorCraft_ix = {[AC_GUNS]=11}
ArmorCraft_Class_ix = {}
ArmorCraft_CP_ix = {}
ArmorCraft_Value = {}

function ArmorCraft_Init()
    UIPanelWindows["AC_Use"] = {area="left", pushable=7}
    if TradeSkillFrame then AC_SetFrames() end
    -- add our chat commands
    SlashCmdList["AC"] = ArmorCraft_command
    SLASH_AC1 = "/armorcraft"
    SLASH_AC2 = "/ac"
    SlashCmdList["ACV"] = ArmorCraft_value
    SLASH_ACV1 = "/acv"
    SlashCmdList["ACIU"] = ArmorCraft_ItemUse
    SLASH_ACIU1 = "/itemuse"
    SLASH_ACIU2 = "/iu"
    if not AC_Value or not AC_Value[AC_MAGE] then AC_Value = ArmorCraft_Attr end
    -- hook inventory item split
    AC_InvSplit_Save = OpenStackSplitFrame
    OpenStackSplitFrame = AC_InvSplit;
    -- hook Chat OnCLick
    AC_ChatOnClick_Save = ChatFrame_OnHyperlinkShow
    ChatFrame_OnHyperlinkShow = AC_ChatOnClick
    -- hook Loot OnCLick
    AC_LootOnClick_Save = LootFrameItem_OnClick
    LootFrameItem_OnClick = AC_LootOnClick
    -- hook GroupLoot OnCLick
    AC_GLootOnClick_Save = GroupLootFrame1IconFrame:GetScript("OnClick")
    for n = 1,4 do
      getglobal("GroupLootFrame"..n.."IconFrame"):SetScript("OnClick",AC_GLootOnClick)
    end
    -- set up the location table
    local button,id
    for name,loc in ArmorCraft_Loc do
      loc.slotID,loc.tex = GetInventorySlotInfo(loc.slot)
      id = loc.ID
      if id then
        button = getglobal("AC_CraftButton"..id)
        button.loc = name
        button = getglobal("AC_TargetButton"..id)
        button.loc = name
      end
    end
    for ix,Type in ArmorCraft_Types do
      ArmorCraft_ix[Type] = ix
    end
    for Type,Data in ArmorCraft_Melee do
      ArmorCraft_ix[Type] = 10
    end
    ArmorCraft_Class_ix = sorted_index(ArmorCraft_Class)
    -- add support for MarsProfessionOrganizer
    if MarsProfessionOrganizer_RegisterTooltip then
      MarsProfessionOrganizer_RegisterTooltip(ArmorCraft_TT)
      MarsProfessionOrganizer_RegisterTooltip(ArmorCraft_TT1)
      MarsProfessionOrganizer_RegisterTooltip(ArmorCraft_TT2)
    end
    -- CmdHelp loaded check
    if not CmdHelp then CmdHelp = function () end end
    -- add support for CharacterProfiler
    if myProfile then
      local Server = GetCVar("realmName")
      AC_CP_Chars = myProfile[Server]
      if AC_CP_Chars then
        ArmorCraft_CP_ix = {}
        for name,data in AC_CP_Chars do
          tinsert(ArmorCraft_CP_ix,name)
        end
        CP_nr = getn(ArmorCraft_CP_ix)
        if CP_nr>1 then
          sort(ArmorCraft_CP_ix)
          AC_CP_DropDown:Show()
        end
      end
    end
end

function ArmorCraft_OnShow()
    if KC_EnhancedTrades_TSFButton then
      AC_ToggleButton:SetPoint("RIGHT","KC_EnhancedTrades_TSFButton","LEFT",2,0)
    else AC_ToggleButton:SetPoint("RIGHT","TradeSkillFrameCloseButton","LEFT")
    end
    AC_tsname = GetTradeSkillLine()
    if AC_tsname and ArmorCraft_TS[AC_tsname] then
      AC_ToggleButton:Enable()
      AC_UseButton:Enable()
    elseif AC_tsname==AC_ENG then AC_UseButton:Enable()
    else AC_ToggleButton:Disable(); AC_UseButton:Disable() end
end

-- Check for proper trade skill window open
local function AC_TScheck()
    local nts = GetNumTradeSkills()
    AC_tsname = GetTradeSkillLine()
    if nts==0 or AC_tsname=="UNKNOWN" then
      print(FCr..ARMORCRAFT_NOWINDOW)
      return true
    end
    AC_Type = ArmorCraft_TS[AC_tsname]
    if not AC_Type then
      print(FCr..AC_tsname..ARMORCRAFT_NOTARMOR)
      return true
    end
end

local function ClickOK() return IsShiftKeyDown() and not IsControlKeyDown() and
                        not IsAltKeyDown() and not ChatFrameEditBox:IsVisible() end

-- Handle Inventory Split events
function AC_InvSplit(count,this,BR,TR)
    if not CursorHasItem() and ClickOK() and count==1 then
      local PID,IID = this:GetParent():GetID(), this:GetID()
      if this.GetInventorySlot then PID = BANK_CONTAINER end
      local link = GetContainerItemLink(PID,IID)
      if link then
        ArmorCraft_TT:SetOwner(AC_Frame)
        if this.GetInventorySlot then
          ArmorCraft_TT:SetInventoryItem("player",this:GetInventorySlot())
        else ArmorCraft_TT:SetBagItem(PID,IID) end
        ArmorCraft_Use(link)
      end
    else AC_InvSplit_Save(count,this,BR,TR) end
end

-- Handle Chat OnClick events
function AC_ChatOnClick(item,link,button)
    if ACdebug and Cmd_Eval then Cmd_Eval(item,link,button) end
    local ok = strsub(item,1,5)=='item:' and button=="LeftButton"
    if ClickOK() and ok then
      ArmorCraft_TT:SetOwner(AC_Frame)
      ArmorCraft_TT:SetHyperlink(item)
      ArmorCraft_Use(link)
    else AC_ChatOnClick_Save(item,link,button) end
end

-- Handle Loot OnClick events
function AC_LootOnClick(button)
    if ClickOK() and button=="LeftButton" then
      local slot = ((LOOTFRAME_NUMBUTTONS - 1) * (LootFrame.page - 1)) + this:GetID()
      ArmorCraft_TT:SetOwner(AC_Frame)
      ArmorCraft_TT:SetLootItem(slot)
      ArmorCraft_Use(GetLootSlotLink(this.slot))
    else AC_LootOnClick_Save(button) end
end

-- Handle GroupLoot OnClick events
function AC_GLootOnClick()
    if ClickOK() and arg1=="LeftButton" then
      local id = this:GetParent().rollID
      ArmorCraft_TT:SetOwner(AC_Frame)
      ArmorCraft_TT:SetLootRollItem(id)
      ArmorCraft_Use(GetLootRollItemLink(id))
    else AC_GLootOnClick_Save() end
end

-- Handle craft item use
function ArmorCraft_CraftUse()
    local TSname = GetTradeSkillLine()
    local tsi = GetTradeSkillSelectionIndex()
    if tsi<1 then print(FCd..ARMORCRAFT_NOITEM) return end
    ArmorCraft_TT:SetOwner(AC_Frame)
    ArmorCraft_TT:SetTradeSkillItem(tsi)
    ArmorCraft_Use(GetTradeSkillItemLink(tsi))
end

function AC_PartyOnClick()
    AC_Name = ''
    ArmorCraft_TT:SetOwner(AC_Frame)
    ArmorCraft_TT:SetHyperlink(LinkItem(AC_Link))
    ArmorCraft_Use(AC_Link)
end

function AC_RadioButton_OnClick(id,init)
    AC_UseSlot1Button:SetChecked(id==1)
    AC_UseSlot2Button:SetChecked(id==2)
    if init then return end
    AC_Name = ''
    ArmorCraft_TT:SetOwner(AC_Frame)
    ArmorCraft_TT:SetHyperlink(LinkItem(AC_Link))
    ArmorCraft_Use(AC_Link,id==1 and 'slot' or 'slot1')
end

local function AC_AValue(desc)
    local wn
    local av = desc.ac
    local cl = AC_Value[AC_Class]
    for atr,val in desc.av do
      wn = cl[atr]
      if not wn then wn = cl[AC_OTHER] end
      av = av+val*wn
    end
    if desc.dps then
      wn = desc.loc==AC_TWO and 8 or 10
      av = av + wn*desc.dps
    end
    return av
end

function ArmorCraft_Use(link,slotname)
    if AC_Link==link and AC_Use:IsVisible() and AC_Name==UnitName("target") then
      AC_Link = nil
      HideUIPanel(AC_Use)
      return
    end
    AC_Link = link;
    local Party_nr = GetNumPartyMembers()
    if CP_nr<2 or Party_nr==0 then
      AC_UsePartyButton:Hide()
      AC_Party = Party_nr>0
    else
      AC_UsePartyButton:Show()
      AC_Party = AC_UsePartyButton:GetChecked()
    end
    local item = LinkItem(link)
    local name,il,ir,iml,class,Type = GetItemInfo(item)
    debug(name..' = '..class..':'..Type)
    local desc = AC_Parse()
    if Type==AC_SHIELDS then Type = AC_SHIELD end
    local Type_ix = ArmorCraft_ix[Type]
    local trinket = Type==AC_MISC and class==AC_ARMOR and ArmorCraft_Loc[desc.loc]
    if Type==AC_DEVICE then class = AC_ARMOR; trinket = true end
    if trinket then Type = desc.loc end
    if ACdebug and Cmd_Eval then Cmd_Eval(Type,desc) end
    if (class==AC_ARMOR or class==AC_WEAPON) and Type~=AC_MISC and Type~=AC_FISH then
      SetPortraitTexture(AC_UsePortrait,"player")
      AC_Use.item = item
      local slot,loc,RW_user,MW_user,button,label,dual
      if class==AC_WEAPON then
        RW_user = ArmorCraft_Ranged[Type]
        MW_user = ArmorCraft_Melee[Type]
        dual = desc.loc==AC_ONE
        loc = RW_user and AC_RANGED or AC_MAIN
      else loc = desc.loc; end
      if not slotname then
        slotname = 'slot'
        if ArmorCraft_Loc[loc].slot1 and (class~=AC_WEAPON or dual) then
          AC_UseSlot1Button:Show()
          AC_RadioButton_OnClick(1,true)
        else AC_UseSlot1Button:Hide() end
      end
      slot = ArmorCraft_Loc[loc][slotname]
      if slot==AC_SHSLOT then loc = AC_OFF end
      debug('Slot = '..slot)
      local slotID,tex = GetInventorySlotInfo(slot)
      local slotID2 = slot==AC_SHSLOT and ArmorCraft_Loc[AC_MAIN].slotID
      local CP_Char,CP_Eq,T_Link,T_Tex,T_Desc,nc,tc,lc,wn,cl,av
      local inc = class==AC_WEAPON and 5 or 2
      for ix = 1,11 do
        button = getglobal("AC_UseButton"..ix)
        button.item = nil
        T_Tex = nil
        AC_Name = nil
        AC_Type,AC_Type2 = '',''
        if ix<=CP_nr and not AC_Party then
          AC_Name = ArmorCraft_CP_ix[ix]
          CP_Char = AC_CP_Chars[AC_Name]
          AC_Level = CP_Char.Level
          AC_Class = CP_Char.Class
          CP_Eq = CP_Char.Equipment[strsub(slot,1,-5)]
          if CP_Eq then
            T_Tex = CP_Eq.Texture
            T_Link = 'Item:'..CP_Eq.Item
          elseif slotID2 then
            CP_Eq = CP_Char.Equipment.MainHand
            T_Link = 'Item:'..CP_Eq.Item
            if CP_Eq and AC_Is2H(T_Link) then
              T_Tex = CP_Eq.Texture
              AC_Type2 = AC_TWO
            else T_Link = nil end
          else T_Link = nil end
        else
          if ix==1 then AC_Unit = "player"
          elseif AC_Party and ix<6 then
            AC_Unit = "party"..(ix-1)
            if not UnitExists(AC_Unit) then AC_Unit = nil end
          elseif(ix==11) then
            if UnitIsPlayer("target") then
              AC_Unit = "target"
              SetPortraitTexture(AC_UsePortrait,AC_Unit)
            else AC_Unit = nil end
          else AC_Unit = nil end
          if AC_Unit then
            AC_Name = UnitName(AC_Unit)
            AC_Level = UnitLevel(AC_Unit)
            AC_Class = UnitClass(AC_Unit)
            T_Tex = GetInventoryItemTexture(AC_Unit,slotID)
            T_Link = LinkItem(GetInventoryItemLink(AC_Unit,slotID))
            if slotID2 and not T_Tex then
              link = LinkItem(GetInventoryItemLink(AC_Unit,slotID2))
              if link and AC_Is2H(link) then
                T_Tex = GetInventoryItemTexture(AC_Unit,slotID2)
                T_Link = link
                AC_Type2 = AC_TWO
              end
            end
            if not T_Tex and not GetInventoryItemLink(AC_Unit,8) then T_Tex = '' end
          end
        end
        av = AC_AValue(desc)
        if AC_Name then
          if not T_Tex then
            T_Tex = tex
            button.loc = loc
          end
          nc = ''; lc = FCw
          if T_Link then
            button.item = T_Link
            ArmorCraft_TT:SetOwner(AC_Frame)
            ArmorCraft_TT:SetHyperlink(T_Link)
            aw = AC_AValue(AC_Parse())
            button.av = av
            button.aw = aw
            if av<aw+inc then
              nc = av<aw-10 and FCy or FCw
            end
          end
          if AC_Level<desc.lvl then lc = FCr; nc = FCy end
          if class==AC_ARMOR then
            if Type~=AC_BACK and not trinket then
              AC_Type = AC_Get_Type(AC_Class)
              if Type==AC_SHIELD and ArmorCraft_Class2[AC_Class] then
                if AC_Class~=AC_HUNTER then
                  AC_Type = AC_Type2=='' and AC_SHIELD or AC_Type2
                  print("AC_Class="..AC_Class..", AC_Type2="..AC_Type2)
                  tc = FCg
                else tc = FCr; nc = FCy; end
              elseif AC_Type==Type then tc = FCg
              elseif ArmorCraft_ix[AC_Type]>Type_ix then tc = FCw
              else tc = FCr; nc = FCy; end
            else AC_Type = AC_Type2; tc = '' end
          else
            if T_Link then
              wn,il,ir,iml,cl,AC_Type = GetItemInfo(T_Link)
              if AC_Type then
                AC_Type = gsub(AC_Type,AC_1H.f,AC_1H.r)
                AC_Type = gsub(AC_Type,AC_2H.f,AC_2H.r)
              else print("Error on "..T_Link); end
            elseif not RW_user then AC_Type = AC_MELEE
            else AC_Type = (AC_SHOOT[AC_Class] or AC_MAGIC[AC_Class]) and Type or AC_RANGED end
            if dual and slotname=='slot1' and (not ArmorCraft_Dual[AC_Class] or
                    ArmorCraft_Dual[AC_Class]>AC_Level) then tc = FCr; nc = FCy
            elseif AC_Type==Type then tc = FCg
            elseif RW_user and RW_user[AC_Class] then tc = FCw
            elseif MW_user and MW_user[AC_Class] then tc = FCw
            else tc = FCr; nc = FCy; end
          end
          if not AC_Type then AC_Type = '?' end
          label = format("%s%s\n%s%s\n%s%s %d",nc,AC_Name,tc,AC_Type,lc,AC_LEVEL,AC_Level)
        else label = nil; button.loc = nil; end
        SetItemButtonTexture(button,T_Tex)
        getglobal("AC_UseButton"..ix.."Text"):SetText(label)
      end
      HideUIPanel(AC_Craft)
      SetCenterFrame(AC_Use,true)
      return
    end
    print(FCr..ARMORCRAFT_WRONG)
end

-- handle our chat command /ac
function ArmorCraft_command(name)
    if name=='debug' then
      ACdebug = not ACdebug
      print("Debug is "..(ACdebug and 'on' or 'off'))
      return
    end
    if AC_Craft:IsVisible() and name=='' then
      HideUIPanel(AC_Craft)
      return
    end
    if name~='' and CmdHelp(AC_Help,'ac',name) then return end
    if AC_TScheck() then return end
    HideUIPanel(AC_Use)
    if name~='' and AC_Target:IsVisible() then
      AC_CP_DropDown_OnClick(name)
      return
    end
    AC_Skip = {}
    AC_Unit = "target"
    if not UnitIsPlayer(AC_Unit) then AC_Unit = "player" end
    SetPortraitTexture(AC_CraftPortrait,"player")
    SetPortraitTexture(AC_TargetPortrait,AC_Unit)
    name = UnitName(AC_Unit)
    AC_TargetTitle:SetText(name)
    AC_Level = UnitLevel(AC_Unit)
    AC_Class = UnitClass(AC_Unit)
    AC_Type = AC_Get_Type(AC_Class)
    if not AC_Type then
      print(FCr.."Undefined class: "..AC_Class)
      return
    end
    AC_MaxLevel:SetText(AC_Level)
    AC_MaxLevel:HighlightText(0,-1)
    UIDropDownMenu_SetWidth(90,AC_DropDown)
    UIDropDownMenu_Initialize(AC_DropDown,AC_DropDown_Init)
    UIDropDownMenu_SetText(AC_Class,AC_DropDown)
    AC_Craft:Show()
    if AC_CP_Chars then
      UIDropDownMenu_SetWidth(90,AC_CP_DropDown)
      UIDropDownMenu_Initialize(AC_CP_DropDown,AC_CP_DropDown_Init)
      if not AC_CP_Chars[name] then name = AC_SELECT end
      UIDropDownMenu_SetText(name,AC_CP_DropDown)
      UIDropDownMenu_SetSelectedValue(AC_CP_DropDown,name)
    end
    AC_Target:Show()
    AC_Scan(AC_Level)
end

-- handle our chat command /acv
function ArmorCraft_value(msg)
    if msg~='' and CmdHelp(AC_Help,'acv',msg) then return end
    if msg=='default' then AC_Value = ArmorCraft_Attr
    elseif msg=='list' then
      local n = 0
      for link,value in ArmorCraft_Value do
        print(format("%s = %d",link,value))
        n = n+1
      end
      if n==0 then print(ARMORCRAFT_EMPTY) end
      return
    elseif msg~='' then
      local value = tonumber(msg)
      if value then
        if AC_TScheck() then return end
        local tsi = GetTradeSkillSelectionIndex()
        if tsi==0 then
          print(FCr..ARMORCRAFT_NOITEM)
          return
        end
        local link = GetTradeSkillItemLink(tsi)
        if value==0 then
          ArmorCraft_Value[link] = nil
          print(link..ARMORCRAFT_RESET)
          return
        end
        ArmorCraft_Value[link] = value;
        print(format("%s = %d",link,value))
        return
      end
      if strsub(msg,1,1)>'Z' then
        msg = strupper(strsub(msg,1,1))..strsub(msg,2)
      end
      local i,j,attr,nr = strfind(msg,"^(%a+)=(%d+)$")
      if not nr then
        print(FCr..ARMORCRAFT_BADFORMAT..msg)
        return
      end
      if not AC_Class then print(FCr..ARMORCRAFT_NOCLASS) return end
      if not AC_Value[AC_Class][attr] then
        print(FCr..ARMORCRAFT_UNDEFINED..attr)
        return
      end
      AC_Value[AC_Class][attr] = tonumber(nr)
    end
    if not AC_Class then print(FCr..ARMORCRAFT_NOCLASS) return end
    local str = ''
    print(format(ARMORCRAFT_CLASS,AC_Class))
    for attr,nr in AC_Value[AC_Class] do
      if(str~='') then str = str..', ' end
      str = str..format("%s=%d",attr,nr)
    end
    print(str)
end

function AC_Get_Type(class)
    local Type = ArmorCraft_Class2[class]
    if(AC_Level<40 or not Type) then
      Type = ArmorCraft_Class[class]
    end
    return Type
end

function AC_DropDown_Init()
    local info
    for ix,class in ArmorCraft_Class_ix do
      info = {text=class, value=ix, func=AC_DropDown_OnClick}
      if class==AC_Class then info.checked = 1 end
      UIDropDownMenu_AddButton(info)
    end
end

function AC_CP_DropDown_Init()
    local info
    for ix,name in ArmorCraft_CP_ix do
      info = {text=name, value=name, func=AC_CP_DropDown_OnClick}
      UIDropDownMenu_AddButton(info)
    end
end

function AC_DropDown_OnClick()
    local value = this.value
    if value then
      AC_Class = ArmorCraft_Class_ix[value]
      AC_Type = AC_Get_Type(AC_Class)
      UIDropDownMenu_SetSelectedValue(AC_DropDown,value)
      AC_Scan(AC_Level)
    end
end

function AC_CP_DropDown_OnClick(name)
    local value
    if not name then
      value = this.value
      name = value
    end
    if AC_CP_Chars[name] then
      CP_Char = AC_CP_Chars[name]
      AC_Unit = CP_Char.Equipment
      AC_Level = CP_Char.Level
      AC_Class = CP_Char.Class
      AC_Type = AC_Get_Type(AC_Class)
      AC_TargetTitle:SetText(name)
      AC_MaxLevel:SetText(AC_Level)
      if name~=UnitName("player") then
        local sex = CP_Char.Sex
        local race =  CP_Char.Race
        if race=="Night Elf" then race = "NightElf" end
        AC_TargetPortrait:SetTexture("Interface\\CharacterFrame\\TemporaryPortrait-"..sex.."-"..race)
      else SetPortraitTexture(AC_TargetPortrait,"player"); end
      UIDropDownMenu_SetText(AC_Class,AC_DropDown)
      UIDropDownMenu_SetSelectedValue(AC_CP_DropDown,value)
      if not value then UIDropDownMenu_SetText(AC_SELECT,AC_CP_DropDown) end
      AC_Scan(AC_Level)
    else print(FCr..ARMORCRAFT_UNDEFINED..name) end
end

function AC_EnterLevel()
    local level = tonumber(this:GetText())
    if not level or level<1 or level>60 then
      this:HighlightText(0,-1);
      print(FCr..ARMORCRAFT_BADLEVEL)
      return;
    end
    this:ClearFocus()
    AC_Level = level
    AC_Scan(AC_Level)
end

function AC_Button_OnEnter()
    if this.tsi then
        ArmorCraft_TT1:SetOwner(this, "ANCHOR_LEFT")
        ArmorCraft_TT1:SetTradeSkillItem(this.tsi)
    elseif this.slot then
        ArmorCraft_TT1:SetOwner(this, "ANCHOR_RIGHT")
        if type(this.slot)=='number' then
          ArmorCraft_TT1:SetInventoryItem(AC_Unit,this.slot)
        else ArmorCraft_TT1:SetHyperlink(this.slot) end
        local button = getglobal("AC_CraftButton"..this:GetID())
        if button.tsi then
          ArmorCraft_TT2:SetOwner(this, "ANCHOR_LEFT")
          ArmorCraft_TT2:SetTradeSkillItem(button.tsi)
        end
    elseif this.item then
        ArmorCraft_TT1:SetOwner(this, "ANCHOR_RIGHT")
        ArmorCraft_TT1:SetHyperlink(this.item)
        ArmorCraft_TT2:SetOwner(this, "ANCHOR_LEFT")
        ArmorCraft_TT2:SetHyperlink(AC_Use.item)
    elseif this.loc then
        ArmorCraft_TT1:SetOwner(this, "ANCHOR_RIGHT")
        ArmorCraft_TT1:SetText(this.loc)
    end
end

function AC_Button_OnClick(button)
    if button=='RightButton' then
      if this.tsi then
        print(ARMORCRAFT_SKIP..GetTradeSkillItemLink(this.tsi))
        AC_Skip[this.tsi] = 1
        AC_Scan(AC_Level)
      end
      return
    end
    local av2,dif,link = ''
    if this.tsi then
      link = GetTradeSkillItemLink(this.tsi)
      if ChatFrameEditBox:IsVisible() then
        ChatFrameEditBox:Insert(link)
        return
      end
      TradeSkillFrame_SetSelection(this.tsi)
      local nts = GetNumTradeSkills()
      if nts>TRADE_SKILLS_DISPLAYED then
        local scroll = this.tsi - TRADE_SKILLS_DISPLAYED/2 -1
        if scroll<0 then scroll = 0; end
        if scroll>nts-TRADE_SKILLS_DISPLAYED then
          scroll = nts-TRADE_SKILLS_DISPLAYED
        end
        TradeSkillListScrollFrameScrollBar:SetValue(scroll*16)
      end
      TradeSkillFrame_Update()
      if AC_Target:IsVisible() then
        local name = "AC_TargetButton"..this:GetID()
        local button = getglobal(name)
        if button.av>0 then
          local label = getglobal(name.."Text"):GetText()
          dif = this.av-button.av
          av2 = format(", %s = %d (%+d)",label,button.av,dif)
        end
      end
    elseif this.item then
      if ChatFrameEditBox:IsVisible() then
        ChatFrameEditBox:Insert(ItemLink(this.item))
        return
      end
      link = AC_Link
      dif = this.av-this.aw
      av2 = format(", %s = %d (%+d)",GetItemInfo(this.item),this.aw,dif)
    else return; end
    print(format("%s = %d%s",link,this.av,av2))
end

function AC_Scan(level)
    local header,desc,cur,ix,tsname,tstype,link,value,av
    local tix,ix,wok = ArmorCraft_ix[AC_Type]
    if not tix then return end
    AC_set = {}
    for name,loc in ArmorCraft_Loc do
      if loc.ID then AC_set[name] = {ac=0; av=0; lvl=-1} end
    end
    local bop = AC_Unit~="player"
    for tsi = 1,GetNumTradeSkills() do
      tsname,tstype = GetTradeSkillInfo(tsi)
      if tstype=="header" then
        header,ix = tsname,ArmorCraft_ix[tsname]
        if tsname~=AC_GUNS then
          wok = ArmorCraft_Melee[tsname]
          if wok then wok = wok[AC_Class] and AC_MAIN end
        else wok = AC_SHOOT[AC_Class] and AC_RANGED end
      elseif ix and (ix<=tix or wok) and not AC_Skip[tsi] then
        ArmorCraft_TT:SetOwner(AC_Frame)
        ArmorCraft_TT:SetTradeSkillItem(tsi)
        desc = AC_Parse(bop)
        link = GetTradeSkillItemLink(tsi)
        value = ArmorCraft_Value[link]
        av = value or AC_AValue(desc)
        cur = AC_set[wok or desc.loc]
        if cur and desc.lvl<=level and av>cur.av then
          desc.tsi,desc.av = tsi,av
          AC_set[wok or desc.loc] = desc
        end
      end
    end
    local tex,name,color,targ,button,label
    local CPC,CPI,CPL,i,j = type(AC_Unit)=='table'
    for loc,desc in AC_set do
      cur = ArmorCraft_Loc[loc]
      tex,name,color = cur.tex, '', White
      ArmorCraft_TT:SetOwner(AC_Frame)
      if CPC then
        CPI = AC_Unit[strsub(cur.slot,1,-5)]
        ix = CPI
        if CPI then
          CPL = 'Item:'..CPI.Item
          if CPL then ArmorCraft_TT:SetHyperlink(CPL) end
        else CPL=nil end
      else ix = ArmorCraft_TT:SetInventoryItem(AC_Unit,cur.slotID) end
      if ix then
        targ = AC_Parse()
        av = AC_AValue(targ)
      else av = 0; targ = {name=''} end
      if desc.lvl>=0 then
        tex = GetTradeSkillIcon(desc.tsi)
        name = desc.name
        if av==nil then color = Red
        elseif desc.av>av+2 then color = Green
        elseif desc.av<av-10 then color = Gray
        end
      end
      button = getglobal("AC_CraftButton"..cur.ID)
      SetItemButtonTexture(button,tex)
      button.tsi = desc.tsi
      button.av = desc.av
      label = getglobal("AC_CraftButton"..cur.ID.."Text")
      label:SetText(name)
      label:SetTextColor(color.r, color.g, color.b)
      if CPC then tex = CPI and CPI.Texture
      else tex = GetInventoryItemTexture(AC_Unit,cur.slotID) end
      if tex==nil then tex = cur.tex end
      button = getglobal("AC_TargetButton"..cur.ID)
      SetItemButtonTexture(button,tex)
      button.slot = (not CPC) and targ.lvl and cur.slotID or CPL
      button.av = av
      label = getglobal("AC_TargetButton"..cur.ID.."Text")
      label:SetText(targ.name)
    end
end

function AC_Parse(bop)
    local n = ArmorCraft_TT:NumLines()
    local i,line = AC_NextLine(1)
    local desc = {name=line,lvl=0,ac=0,av={}}
    i,line = AC_NextLine(i)
    if line==ARMORCRAFT_SOULBOUND then
      i,line = AC_NextLine(i)
    elseif line==ARMORCRAFT_BOE then
      desc.boe = true
      i,line = AC_NextLine(i)
    elseif line==ARMORCRAFT_BOP then
      desc.bop = true
      if bop then return desc end
      i,line = AC_NextLine(i)
    end
    if line==ARMORCRAFT_UNIQUE then
      i,line = AC_NextLine(i)
    end
    desc.type = getglobal("ArmorCraft_TTTextRight"..(i-1)):GetText()
    if line==AC_GUN then
      desc.loc = AC_RANGED
      desc.type = AC_GUN
    else desc.loc = line end
    if i>n then return desc end
    i,line = AC_NextLine(i)
    local s,e,nr = string.find(line,ARMORCRAFT_ARMOR)
    if s then desc.ac = tonumber(nr) end
    local str
    while i<=n do
      i,line = AC_NextLine(i)
      s,e,nr,str = string.find(line,"^%+(%d+) (%a+)")
      if s then desc.av[str] = tonumber(nr)
      else
        s,e,nr = string.find(line,ARMORCRAFT_REQUIRES)
        if s then desc.lvl = tonumber(nr)
        else
          s,e,nr = string.find(line,ARMORCRAFT_DPS)
          if s then desc.dps = tonumber(nr) end
        end
      end
    end
    return desc
end

function AC_NextLine(ix)
    local ttf = getglobal("ArmorCraft_TTTextLeft"..ix)
    return ix+1, ttf:GetText()
end

-- Patching frames to handle dynamic loading
function AC_SetFrames()
    AC_Craft:SetParent(TradeSkillFrame);
    AC_Craft:SetPoint("TOPLEFT","TradeSkillFrame","TOPRIGHT",-40,100)
    AC_ToggleButton:SetParent(TradeSkillFrame)
    AC_ToggleButton:SetFrameLevel(TradeSkillFrame:GetFrameLevel()+3)
    AC_UseButton:SetPoint("RIGHT","AC_ToggleButton","LEFT")
    AC_SetFrames = function() end
end

if not TradeSkillFrame then
  local AC_TS_Load = TradeSkillFrame_LoadUI
  TradeSkillFrame_LoadUI = function() AC_TS_Load(); AC_SetFrames() end
end

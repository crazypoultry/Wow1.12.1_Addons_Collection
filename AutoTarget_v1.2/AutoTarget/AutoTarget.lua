--[[ AutoTarget: Automatically selects matching targets.
    Written by Vincent of Blackhand, (copyright (c) 2005 by D.A.Down)

    Version history:
    1.2 - WoW 1.12 update.
    1.1.3 - Added command line help (CmdHelp).
    1.1.2 - Only check corpses for skinnable.
    1.1.1 - Fixed defaults on check buttons.
    1.1 - WoW 1.11 update.
    1.0 - WoW 1.10 update.
    0.9.7 - Added PvP target log option.
    0.9.6 - Menu label changes color with active selections.
    0.9.5 - 'MyKill' and TargetingMe' default to set.
    0.9.4 - Added 'targeting me' targeting.
    0.9.3 - Added hunter's mark targeting.
    0.9.2 - Won't target unattackable unless friendly selected.
    0.9.1 - Added skinnable targeting.
    0.9 - WoW 1.9 update.
    0.8.2.2 - Clicking target button with no target clears name.
    0.8.2.1 - Fix for auto-on bug.
    0.8.2 - Added Default-to-on toggle command.
    0.8.1 - Added target-of-target key binding.
    0.8 - Added selections for Type, Class and Family.
    0.7.4 - Added max health filter.
    0.7.3 - WoW 1.8 update.
    0.7.2 - Check Control key to allow changing targets.
    0.7.1 - Added ClearTarget keybinding.
    0.7 - Initial public release.

]]--

local FCr = "|cffff4040"
local MinLevel,MaxLevel,Level,MaxHealth,MenuSet = 0,0,0,0,{}
local Names,Log,Opt,AT_On,Debug,Menu = {},{}
-- menu groups
local Groups = {[AT_TYPE]  = {M=AT_TypeMenu,  N=AT_TYPE_NAMES,  F=UnitCreatureType};
                [AT_CLASS] = {M=AT_ClassMenu, N=AT_CLASS_NAMES, F=UnitClass};
                [AT_FAMILY]= {M=AT_FamilyMenu,N=AT_FAMILY_NAMES,F=UnitCreatureFamily}; }
-- internal functions
local function print(msg) SELECTED_CHAT_FRAME:AddMessage("AT: "..msg, 0,1,1); end
local function UnitIsNeutral(unit) return UnitReaction(unit,'player')==4; end
local function UnitIsElite(unit) return UnitClassification(unit)=='elite'; end
local function UnitNotMine(unit) return UnitIsTapped(unit) and not UnitIsTappedByPlayer(unit); end
local function UnitIsDeadly(unit) return Level<0; end
local function UnitTargetingMe(unit) return UnitIsUnit('player','mouseovertarget'); end
local function OnLeave() GameTooltip:Hide(); end
local function OnEnter()
    GameTooltip:SetOwner(this,"ANCHOR_RIGHT")
    GameTooltip:SetText(AT_MENU_TIP)
end
local function UnitIsSkinable(unit)
    GameTooltip:SetUnit(unit)
    return GameTooltipTextLeft3:GetText()=='Skinnable'
end
local function UnitIsMarked(unit)
    local tex,cnt
    for ix = 1,16 do
      tex,cnt = UnitDebuff(unit,ix)
      if not tex then return; end
      if strfind(tex,'SniperShot') then return cnt end
    end
end
-- Saved Variables
AutoTarget_Option = {}

function AutoTarget_Initialize()
    UIPanelWindows["AT_Config"] = {area="left", pushable=11}
    -- add our chat commands
    SlashCmdList["AUTOTARGET"] = AutoTarget_command
    SLASH_AUTOTARGET1 = "/at"
    -- setup option window
    Opt = { Enemy   = {B=AT_EnemyButton,   F=UnitIsEnemy},
            Neutral = {B=AT_NeutralButton, F=UnitIsNeutral},
            Friend  = {B=AT_FriendButton,  F=UnitIsFriend},
            Elite   = {B=AT_EliteButton,   F=UnitIsElite,     R=AT_EliteExcl},
            Player  = {B=AT_PlayerButton,  F=UnitIsPlayer,    R=AT_PlayerExcl},
            PvP     = {B=AT_PvPButton,     F=UnitIsPVP,       R=AT_PvPExcl},
            MyKill  = {B=AT_MyKillButton,  F=UnitIsTappedByPlayer, R=AT_MyKillExcl},
            TargMe  = {B=AT_TargMeButton,  F=UnitTargetingMe, R=AT_TargMeExcl},
            Skin    = {B=AT_SkinButton,    F=UnitIsSkinable,  R=AT_SkinExcl},
            Marked  = {B=AT_MarkedButton,  F=UnitIsMarked,    R=AT_MarkedExcl},
--            Combat  = {B=AT_CombatButton,  F=UnitAffectingCombat},
            Charmed = {B=AT_CharmedButton, F=UnitIsCharmed},
            Civilian= {B=AT_CivilianButton,F=UnitIsCivilian},
            Trivial = {B=AT_TrivialButton, F=UnitIsTrivial},
            NotMine = {B=AT_NotMineButton, F=UnitNotMine},
            Deadly  = {B=AT_DeadlyButton,  F=UnitIsDeadly},
          }
    AT_OnButton.Tip = AT_ON_TIP
    AT_On = AutoTarget_Option.On
    AutoTarget_Option.MyKill = 1
    AutoTarget_Option.TargMe = 1
    for name,data in Groups do
      UIDropDownMenu_SetWidth(60,data.M)
      UIDropDownMenu_SetText(name,data.M)
      local button = getglobal(data.M:GetName()..'Button')
      button:SetScript('OnEnter',OnEnter)
      button:SetScript('OnLeave',OnLeave)
    end
    for name,data in Opt do
      data.B.Tip = getglobal('AT_'..strupper(name)..'_TIP')
      if data.R then
        data.R.Tie = data.B
        data.B.Tie = data.R
      end
    end
    -- CmdHelp loaded check
    if not CmdHelp then CmdHelp = function () end
    else CmdHelp(AT_Help,'at') end
end

-- Handle target mouse-overs
function AutoTarget_MouseOver(unit)
    if not AT_On then return end
    if AutoTarget_Option.Log and UnitIsPlayer(unit) and
                UnitIsPVP(unit) and UnitIsEnemy('player',unit) then
      local name = UnitName(unit)
      if not Log[name] then
        local level, class = UnitLevel(unit),UnitClass(unit)
        level = level < 1 and '??' or tostring(level)
        Log[name] = {l=level,c=class}
        print(FCr..format('%s, %s %s',name,level,class))
      end
    end
    if UnitExists('target') and (UnitIsUnit('target',unit) or
        not UnitIsDead('target') and not IsControlKeyDown()) then return end
    local fail = AutoTarget_CheckUnit(unit)
    if not fail then
      PlaySound("igCharacterInfoTab")
      TargetUnit(unit)
    elseif Debug then
      print(UnitName(unit)..' skipped on '..fail)
    end
end

function AutoTarget_CheckUnit(unit)
    if UnitIsDead(unit) then
      if AutoTarget_Option.Skin and UnitIsSkinable(unit) then return end
      return 'Dead'
    end
    if not AutoTarget_Option.Friend and not UnitCanAttack('player',unit) then
                                    return "Can'tAttack" end
    Level = UnitLevel(unit)
    if Level<MinLevel and Level>0 then return 'MinLevel' end
    if MaxLevel>0 and Level>MaxLevel then return 'MaxLevel' end
    if MaxHealth>0 then
      local Health = 100*UnitHealth(unit)/UnitHealthMax(unit)
      if Health>MaxHealth then return 'MaxHealth' end
      if UnitExists('target') and Health>UnitHealth('target') then return 'MinHealth' end
    end
    local set,match
    for name,data in Opt do
      set,match = AutoTarget_Option[name], data.F(unit,"player")
      if match and not set or set==2 and not match then return name end
    end
    for group,data in Groups do
      if AutoTarget_Option[group] then
        if not AutoTarget_Option[group][data.F(unit)] then return group end
      end
    end
    if getn(Names)>0 then
      local match,uname = false,strlower(UnitName(unit))
      for ix,name in Names do
        if strfind(uname,name) then match = true break end
      end
      if not match then return 'Name' end
    end
end

-- Handle our configuration setting
function AutoTarget_Toggle_Config()
    if AT_Config:IsVisible() then HideUIPanel(AT_Config)
    else SetCenterFrame(AT_Config,true); ShowUIPanel(AT_Config) end
end

local function SetName(field)
    field:SetText(field.old or '')
end

local function SetMenuColor(menu)
    local label = getglobal("AT_"..menu.."MenuText")
    label:SetTextColor(next(MenuSet[menu]) and 1 or 0,1,0)
end

local function Menu_Select()
    MenuSet[Menu][this.value] = not this.checked and 1 or nil
    SetMenuColor(Menu)
end

local function All_Select()
    MenuSet[Menu] = {}
    SetMenuColor(Menu)
end

local function Add_Names(group)
    if not group then return end
    Menu = group
    local any = format(AT_ANY,group)
    local info = {text=any;notCheckable=1;func=All_Select}
    UIDropDownMenu_AddButton(info)
    for ix,name in Groups[group].N do
      info = {text=name;keepShownOnClick=1;func=Menu_Select}
      if MenuSet[Menu][name] then info.checked = 1 end
      UIDropDownMenu_AddButton(info)
    end
end

function AutoTarget_Show()
    AT_OnButton:SetChecked(AT_On)
    AT_MinLevel:SetText(MinLevel>0 and MinLevel or '')
    AT_MaxLevel:SetText(MaxLevel>0 and MaxLevel or '')
    AT_MaxHealth:SetText(MaxHealth>0 and MaxHealth or '')
    SetName(AT_Name1Text)
    SetName(AT_Name2Text)
    SetName(AT_Name3Text)
    for set,data in Groups do
      local group = set
      local init = function(lvl) Add_Names(lvl and group) end
      UIDropDownMenu_Initialize(data.M,init,"MENU")
      MenuSet[set] = {}
      if AutoTarget_Option[set] then
        for name in AutoTarget_Option[set] do
          MenuSet[set][name] = 1
        end
      end
      SetMenuColor(set)
    end
    for name,data in Opt do
      data.B:SetChecked(AutoTarget_Option[name])
      if data.R then
        data.R:SetChecked(AutoTarget_Option[name]==2)
      end
    end
end

local function GetName(field)
    local name = field:GetText()
    field.old = name
    if name~='' then tinsert(Names,strlower(name)) end
end

function AutoTarget_Config()
    AT_On = AT_OnButton:GetChecked()
    MinLevel = AT_MinLevel:GetNumber()
    MaxLevel = AT_MaxLevel:GetNumber()
    MaxHealth = AT_MaxHealth:GetNumber()
    if MaxLevel>0 and MaxLevel<MinLevel then
      PlaySound("igQuestLogAbandonQuest")
      AT_MaxLevel:SetFocus()
      return;
    end
    Names = {}
    GetName(AT_Name1Text)
    GetName(AT_Name2Text)
    GetName(AT_Name3Text)
    for set,data in MenuSet do
      AutoTarget_Option[set] = next(data) and data or nil
    end
    for name,data in Opt do
      AutoTarget_Option[name] = data.B:GetChecked()
      if data.R and data.R:GetChecked() then
        AutoTarget_Option[name] = 2
      end
    end
    HideUIPanel(AT_Config)
end

function TS_OnClick(field)
    local name = UnitExists('target') and UnitName('target') or ''
    getglobal(field.."Text"):SetText(name)
end

function AutoTarget_Clear()
    AT_MinLevel:SetText('')
    AT_MaxLevel:SetText('')
    AT_MaxHealth:SetText('')
    AT_Name1Text:SetText('')
    AT_Name2Text:SetText('')
    AT_Name3Text:SetText('')
    for menu in MenuSet do
      MenuSet[menu] = {}
      SetMenuColor(menu)
    end
    for name,data in Opt do
      data.B:SetChecked(false)
    end
end

-- Handle our chat command
function AutoTarget_command(msg)
    if msg=='config' then AutoTarget_Toggle_Config()
    elseif msg=='' then
      AT_On = not AT_On
      print('AutoTarget '..(AT_On and AT_ON or AT_OFF))
    elseif msg=='on' then
      AutoTarget_Option.On = not AutoTarget_Option.On
      print(AT_DFLTON..(AutoTarget_Option.On and AT_ON or AT_OFF))
    elseif msg=='log' then
      Log = {}
      AutoTarget_Option.Log = not AutoTarget_Option.Log
      print(AT_PVPLOG..(AutoTarget_Option.Log and AT_ON or AT_OFF))
    elseif msg=='list' then
      if next(Log) then
        print(AT_LIST)
        for name,data in Log do
          print(FCr..format('%s, %s %s',name,data.l,data.c))
        end
      else print(AT_NOLOG) end
    elseif msg=='debug' then
      Debug = not Debug
      print(AT_DEBUG..(Debug and AT_ON or AT_OFF))
    elseif not CmdHelp(AT_Help,'at',msg) then print(AT_UNKNOWN..msg) end
end

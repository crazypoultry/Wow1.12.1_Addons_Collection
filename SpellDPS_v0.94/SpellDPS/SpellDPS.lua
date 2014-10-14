--[[ SpellDPS: Adds damage-per-second to spell tooltips.
    Written by Vincent of Blackhand, (copyright (c) 2005-2006 by D.A.Down)

    Version history:
    0.9.3 - WoW 1.12 update.
    0.9.4 - Fixed reagent based spells.
    0.9.2 - WoW 1.11 update.
    0.9.1 - WoW 1.10 update.
    0.9 - WoW 1.9 update.
    0.8.3 - Fixed reference to round() function.
    0.8.2 - WoW 1.8 update, German localization.
    0.8.1 - Added optional total damage/heal line.
    0.8 - Added support for spells listed at trainers.
    0.7.2 - Added font color selection, fixed several spells.
    0.7.1 - Added support for drains, absorbs, totems and hunter shots.
    0.7 - Converted parsing to table driven format.
    0.6.2 - Adjusted cooldown time, added localization.
    0.6.1 - Fix for a priest heal.
    0.6 - Added support for healing spells.
    0.5.1 - Fix for arcane missles.
    0.5 - Initial public release.
]]

local n,v = {},{};
local CDT,debug,text,s,e,ix,mana,cast,desc,flag,xps,xpm,FC,C,PC = 1.4;
local function print(msg) SELECTED_CHAT_FRAME:AddMessage("SDPS: "..msg,C.r,C.g,C.b); end
local function Debug(msg) if(debug) then print(msg); end end

function SpellDPS_Init()
    -- add our chat commands
    SlashCmdList["SPELLDPS"] = SpellDPS_Cmd
    SLASH_SPELLDPS1 = "/spelldps"
    SLASH_SPELLDPS2 = "/sdps"
    if UnitPowerType('player')~=0 then return end -- must be magic user
    -- Hook Tooltip calls
    SpellDPS_SetAction_Save = GameTooltip.SetAction
    GameTooltip.SetAction = SpellDPS_SetAction
    SpellDPS_SetSpell_Save = GameTooltip.SetSpell
    GameTooltip.SetSpell = SpellDPS_SetSpell
    SpellDPS_SetTS_Save = GameTooltip.SetTrainerService
    GameTooltip.SetTrainerService = SpellDPS_SetTS
    -- Font color table
    for i = 1,2 do
      if(not SpellDPS_Color[i]) then SpellDPS_Color[i] = {} end
      C = SpellDPS_Color[i]
      if not C.xps then C.xps = {r=1,g=1,b=1} end
      if not C.xpm then C.xpm = {r=1,g=1,b=0} end
      if not C.tx then  C.tx  = {r=0,g=0,b=0} end
    end
    FC = {dps=SpellDPS_Color[1].xps; dpm=SpellDPS_Color[1].xpm; td=SpellDPS_Color[1].tx;
          hps=SpellDPS_Color[2].xps; hpm=SpellDPS_Color[2].xpm; th=SpellDPS_Color[2].tx;
          chat=SpellDPS_Color.chat;}
    C = SpellDPS_Color.chat
end

function SpellDPS_SetAction(this,slot)
    SpellDPS_SetAction_Save(this,slot)
    SpellDPS_CheckSpell()
end

function SpellDPS_SetSpell(this,id,tab)
    SpellDPS_SetSpell_Save(this,id,tab)
    SpellDPS_CheckSpell()
end

function SpellDPS_SetTS(this,slot)
    SpellDPS_SetTS_Save(this,slot)
    SpellDPS_CheckSpell()
end

function SpellDPS_CheckSpell()
    local Lines = GameTooltip:NumLines()
    Debug('Lines = '..Lines)
    if Lines<4 then return end
    text = GameTooltipTextLeft2:GetText()
    s,e,n1,n2 = strfind(text,SpellDPS_Mana)
    if not s then return end
    mana = tonumber(n1)
    Debug('Mana = '..mana)
    text = GameTooltipTextLeft3:GetText()
    s,e,n1,n2 = strfind(text,SpellDPS_Cast2)
    if not s then
      s,e,n1 = strfind(text,SpellDPS_Cast1)
      if not s then cast = CDT
      else cast = tonumber(n1) end
    else cast = tonumber(n1)+tonumber(n2)/10 end
    Debug('Cast = '..cast)
    text = GameTooltipTextLeft4:GetText()
    if text==SpellDPS_Totem or strfind(text,SpellDPS_Weapon) or
    						strfind(text,SpellDPS_Reagents) then
      text = GameTooltipTextLeft5:GetText()
    end
    if not text then return end
    desc = table.foreachi(SpellDPS_Desc,SpellDPS_Parse)
    if not desc then return end
    Debug('Match: '..desc[3])
    ix = desc[2]; flag = ix[6]
    for i = 1,5 do v[i] = ix[i]<1 and abs(ix[i]) or tonumber(n[ix[i]]); end
    Debug(format('V= %d, %d, %d, %d, %d, %.1f',v[1],v[2],v[3],v[4],v[5],flag))
    if v[5]==0 then v[5] = cast end
    local dmg = (v[1]+v[2])/2
    secs = v[3]>0 and v[3] or cast
    if flag>0 then dmg = dmg*secs/flag
    elseif flag==-1 then dmg = 0; mana = mana+(v[1]+v[2]/10)*v[4]
    elseif flag==-2 then dmg = dmg/2  end
    if secs<CDT then secs = CDT end
    Debug(format('R1: %.1f/%.1f=%.1f, R2: %.1f',dmg,secs,dmg/secs,v[4]/v[5]))
    ix = desc[1]
    xps = format(SpellDPS_XPS[ix],dmg/secs+v[4]/v[5])
    xpm = format(SpellDPS_XPM[ix],(dmg+v[4])/mana)
    s,e = SpellDPS_Color[ix].xps, SpellDPS_Color[ix].xpm;
    GameTooltip:AddDoubleLine(xps,xpm, s.r, s.g, s.b, e.r, e.g, e.b)
    s = SpellDPS_Color[ix].tx
    if s.r+s.g+s.b>0.2 then
      text = format(SpellDPS_TX[ix],dmg+v[4])
      GameTooltip:AddLine(text, s.r, s.g, s.b)
    end
    GameTooltip:Show()
end

function SpellDPS_Parse(i,desc)
    if not text then return; end
    s,e,n[1],n[2],n[3],n[4] = strfind(text,desc[3])
    if s then return desc end
end

local function round2(n) return floor(n*100+0.5)/100 end

function SpellDPS_SetColor()
    local r,g,b = ColorPickerFrame:GetColorRGB()
    PC.r,PC.g,PC.b = round2(r),round2(g),round2(b)
end

-- handle our chat command
function SpellDPS_Cmd(msg)
    if msg=='debug' then
      debug = not debug
      print("Debug is "..(debug and 'on.' or 'off.'))
    elseif FC[msg] then
      PC = FC[msg]
      ColorPickerFrame.func = SpellDPS_SetColor
      ColorPickerFrame:SetColorRGB(PC.r,PC.g,PC.b)
      ShowUIPanel(ColorPickerFrame)
    else print("Unknown command: "..msg) end
end

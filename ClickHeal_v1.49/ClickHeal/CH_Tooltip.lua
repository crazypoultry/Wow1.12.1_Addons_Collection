--=============================================================================
-- File:	CH_Tooltip.lua
-- Author:	rudy
-- Description:	Tooltip helpers
--=============================================================================

--=============================================================================
--  General tooltip helper functions
--=============================================================================

local function CHL_TooltipInit()

  if ( CH_Tooltip:IsOwned(CH_ClickHeal) ) then return; end;
  CH_Tooltip:SetOwner( CH_ClickHeal, 'ANCHOR_NONE' );
  CH_Tooltip:ClearLines();

end

function CH_TooltipSetSpell( spellNo, booktype )

  CHL_TooltipInit();
  CH_Tooltip:SetSpell( spellNo, booktype );

end

function CH_TooltipSetUnit( unit )

  CHL_TooltipInit();
  CH_Tooltip:SetUnit( unit );

end

function CH_TooltipSetUnitBuff( unit, buffNo )

  CHL_TooltipInit();
  CH_Tooltip:SetUnitBuff( unit, buffNo );

end

function CH_TooltipSetUnitDebuff( unit, debuffNo )

  CHL_TooltipInit();
  CH_TooltipTextRight1:SetText( nil );
  CH_Tooltip:SetUnitDebuff( unit, debuffNo );

end

function CH_TooltipSetPlayerBuff( buffNo )

  CHL_TooltipInit();
  CH_Tooltip:SetPlayerBuff( buffNo );

end

function CH_TooltipSetAction( actionNo )

  CHL_TooltipInit();
  CH_Tooltip:SetAction( actionNo );

end

function CH_TooltipSetInventoryItem( unit, slotNo )

  CHL_TooltipInit();
  return( CH_Tooltip:SetInventoryItem(unit,slotNo) );

end

function CH_TooltipSetBagItem( bag, slot )

  CHL_TooltipInit();
  CH_Tooltip:SetBagItem( bag, slot );

end

function CH_TooltipNumLines( )

  return( CH_Tooltip:NumLines() );

end

--=============================================================================
--  tooltip check functions
--=============================================================================

function CH_TooltipContainsPatternLeft( pattern )

  local txt;
  local i = 2;
  local n = CH_TooltipNumLines();
  local found = false;

  while ( i <= n and (not found) ) do
    txt = getglobal('CH_TooltipTextLeft'..i):GetText( );
    if ( txt ) then
      _,_,manaCost = string.find( txt, CH_TOOLTIP_MANA_REGEXP );
    end
    i = i + 1;
  end

  return( found );

end


--=============================================================================
--  tooltip query functions
--=============================================================================

function CH_TooltipGetTitle()

  return( CH_TooltipTextLeft1:GetText() );

end

function CH_TooltipGetManaCost()

  local txt;
  local i = 2;
  local n = CH_TooltipNumLines();
  local manaCost = nil;

  while ( i <= n and manaCost == nil ) do
    txt = getglobal('CH_TooltipTextLeft'..i):GetText( );
    if ( txt ) then
      _,_,manaCost = string.find( txt, CH_TOOLTIP_MANA_REGEXP );
    end
    i = i + 1;
  end

  return( manaCost );

end

function CH_TooltipGetCastTime()

  local txt;
  local i = 2;
  local n = CH_TooltipNumLines();
  local castTime = nil;

  while ( i <= n and castTime == nil ) do
    txt = getglobal('CH_TooltipTextLeft'..i):GetText( );
    if ( txt ) then
      if ( txt == CH_TOOLTIP_INSTANT_CAST_LABEL ) then
        castTime = 0;
      else
        _,_,castTime = string.find( txt, CH_TOOLTIP_CAST_TIME_REGEXP );
      end
    end
    i = i + 1;
  end

  return( castTime );

end

function CH_TooltipGetHealOnce( pattern, pattern1 )

  local txt;
  local i = 2;
  local n = CH_TooltipNumLines();
  local minHeal = nil;
  local maxHeal = nil;

  while ( i <= n and minHeal == nil ) do
    txt = getglobal('CH_TooltipTextLeft'..i):GetText( );
    if ( txt ) then
      _,_,minHeal,maxHeal = string.find( txt, pattern );
      if ( minHeal == nil and pattern1 ~= nil ) then
        _,_,minHeal,maxHeal = string.find( txt, pattern1 );
      end
    end
    i = i + 1;
  end
 
  return minHeal, maxHeal;

end

function CH_TooltipGetHealRegrowth( pattern, pattern1 )

  local txt;
  local i = 2;
  local n = CH_TooltipNumLines();
  local minHeal = nil;
  local maxHeal = nil;
  local hotMinHeal = nil;
  local hotMaxHeal = nil;

  while ( i <= n and minHeal == nil ) do
    txt = getglobal('CH_TooltipTextLeft'..i):GetText( );
    if ( txt ) then
      _,_,minHeal,maxHeal,hotMinHeal = string.find( txt, pattern );
      hotMaxHeal = hotMinHeal;
      if ( minHeal == nil and pattern1 ~= nil ) then
        _,_,minHeal,maxHeal,hotMinHeal,hotMaxHeal = string.find( txt, pattern1 );
      end
    end
    i = i + 1;
  end
 
  return minHeal, maxHeal, hotMinHeal, hotMaxHeal;

end

function CH_TooltipGetReagents()

  local txt;
  local i = 2;
  local n = CH_TooltipNumLines();
  local reagents = nil;

  while ( i <= n and reagents == nil ) do
    txt = getglobal('CH_TooltipTextLeft'..i):GetText( );
    if ( txt ) then
      _,_,reagents = string.find( txt, CH_TOOLTIP_REAGENTS_REGEXP );
    end
    i = i + 1;
  end

  return( reagents );

end

function CH_TooltipGetCooldown()

  local txt;
  local i = 2;
  local n = CH_TooltipNumLines();
  local cooldown = nil;

  while ( i <= n and cooldown == nil ) do
    txt = getglobal('CH_TooltipTextRight'..i):GetText( );
    if ( txt ) then
      _,_,cooldown = string.find( txt, CH_TOOLTIP_COOLDOWN_SECONDS_REGEXP );
      if ( cooldown == nil ) then
        _,_,cooldown = string.find( txt, CH_TOOLTIP_COOLDOWN_MINUTES_REGEXP );
        if ( cooldown ) then
          cooldown = tonumber(cooldown) * 60;
        end
      end
    end
    i = i + 1;
  end

  return( tonumber(cooldown) );

end

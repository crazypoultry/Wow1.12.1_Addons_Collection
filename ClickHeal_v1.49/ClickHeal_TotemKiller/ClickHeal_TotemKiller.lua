--=============================================================================
-- File:		ClickHeal_TotemKiller.lua
-- Author:		rmet0815
-- Description:		ClickHeal Pluging: TotemKiller
--=============================================================================

ClickHeal_TotemKiller = { 

  pluginName    = "TotemKiller";
  pluginVersion = "10700";			-- 1.00.00

  actionID    = 'TOTEMKILLER';
  allowed     = {'extra'};
  classes     = {DRUID=1,HUNTER=1,MAGE=1,PALADIN=1,PRIEST=1,ROGUE=1,SHAMAN=1,WARLOCK=1,WARRIOR=1};
  editable    = 'DROPDOWN';
  editable2   = 'TEXT';
  insertAfter = 'USEWAND';

  totemList = { CH_SPELL_FIRE_NOVA_TOTEM, CH_SPELL_MAGMA_TOTEM, CH_SPELL_SEARING_TOTEM, CH_SPELL_FLAMETONGUE_TOTEM,
                CH_SPELL_MANA_TIDE_TOTEM, CH_SPELL_HEALING_STREAM_TOTEM, CH_SPELL_MANA_SPRING_TOTEM,
                CH_SPELL_STONESKIN_TOTEM, CH_SPELL_EARTHBIND_TOTEM, CH_SPELL_STONECLAW_TOTEM,
                CH_SPELL_STRENGTH_OF_EARTH_TOTEM, CH_SPELL_TREMOR_TOTEM, CH_SPELL_FROST_RESISTANCE_TOTEM,
                CH_SPELL_POISON_CLEANSING_TOTEM, CH_SPELL_DISEASE_CLEANSING_TOTEM, CH_SPELL_FIRE_RESISTANCE_TOTEM,
                CH_SPELL_GROUNDING_TOTEM, CH_SPELL_NATURE_RESISTANCE_TOTEM, CH_SPELL_WINDFURY_TOTEM,
                CH_SPELL_SENTRY_TOTEM, CH_SPELL_WINDWALL_TOTEM, CH_SPELL_GRACE_OF_AIR_TOTEM, CH_SPELL_TRANQUIL_AIR_TOTEM,
                CH_TOTEM_CORRUPTED_TOTEM, CH_TOTEM_MOONFLARE_TOTEM, CH_TOTEM_BRAIN_WASH_TOTEM,
                CH_TOTEM_EARTHGRAB_TOTEM, CH_TOTEM_LAVA_SPOUT_TOTEM, CH_TOTEM_ATALAI_TOTEM,
                CH_TOTEM_ICE_TOTEM, CH_TOTEM_DIRE_MAUL_CRYSTAL_TOTEM, 
                CH_TOTEM_ELEMENTAL_PROTECTION_TOTEM, CH_TOTEM_FLAME_BUFFET_TOTEM, CH_TOTEM_SPIRIT_TOTEM,
                CH_TOTEM_SCORCHING_TOTEM, CH_TOTEM_TRANQUIL_AIR_TOTEM, CH_TOTEM_ANCIENT_MANA_SPRING_TOTEM,
                CH_TOTEM_HEALING_WARD, CH_TOTEM_POWERFUL_HEALING_WARD, CH_TOTEM_SUPERIOR_HEALING_WARD,
              };

};

-- ========================================================================================================
-- Events
-- ========================================================================================================
function ClickHeal_TotemKiller:OnLoad()

  this:RegisterEvent( "VARIABLES_LOADED" );

end

function ClickHeal_TotemKiller:OnEvent( event, arg1, arg2, arg3 )

  if ( event == 'VARIABLES_LOADED' ) then
    CH_RegisterPlugin( self, self.actionID, self.allowed, self.classes, self.editable, self.editable2, self.insertAfter );
  end  

end

-- ========================================================================================================
-- Query Methods
-- ========================================================================================================

function ClickHeal_TotemKiller:GetClassName()

  return( 'ClickHeal_TotemKiller' );

end

function ClickHeal_TotemKiller:GetVersion()

  return( self.pluginVersion );

end

function ClickHeal_TotemKiller:GetName()

  return( self.pluginName );

end

function ClickHeal_TotemKiller:GetActionLabel( actionID )

  return( CLICKHEAL_TOTEMKILLER.ActionTypeText );

end

function ClickHeal_TotemKiller:GetTooltipInfo( actionID, data, unit )

  return( CLICKHEAL_TOTEMKILLER.ActionTypeText );

end

function ClickHeal_TotemKiller:DefaultData( actionID )

  return( {'MELEE',nil} );

end

function ClickHeal_TotemKiller:DropDownList( actionID, listIdx, data )

  return( {MELEE='Melee',PET='Pet',WAND='Wand',BOW='Bow',SPELL='Spell'} );

end

-- ========================================================================================================
-- Callback from ClickHeal
-- ========================================================================================================

function ClickHeal_TotemKiller:Callback( unit, data, actionID )

  local totem;
  local prevTarget = nil;
  local stompedBy;
  local nukeIt;
  local i = 1;

  if ( UnitExists('target') ) then
    prevTarget = UnitName('target');
  end

  while ( self.totemList[i] ) do
    totem = ClickHeal_TotemKiller.totemList[i];
    nukeIt = false;

    TargetByName( totem );
    if ( UnitExists('target') and strsub(UnitName('target'),1,strlen(totem)) == totem ) then			-- found a totem
      CH_TooltipSetUnit( 'target' );
      stompedBy = CH_TooltipTextLeft2:GetText();
      if ( stompedBy and stompedBy ~= '' ) then
        _,_,stompedBy = string.find( stompedBy, "(.+)'s? Creation" );
        if ( not stompedBy ) then
          _,_,stompedBy = string.find( stompedBy, "(.+)'s? Guardian" );
        end
        nukeIt = self:MayNuke( stompedBy );
      else
        nukeIt = true;
      end
      if ( nukeIt == true ) then
        self:NukeTotem( data[1], data[2], prevTarget );
        return;
      end
    end

    self:ReTarget( prevTarget);								-- nothing found, target changed ?
    i = i + 1;
  end

end

function ClickHeal_TotemKiller:ReTarget( prevTarget )

  if ( UnitExists('target') and UnitName('target') ~= prevTarget ) then
    if ( prevTarget ) then
      TargetLastTarget();
      if ( UnitExists('target') and UnitName('target') ~= prevTarget )then		-- could not retarget, try 'rescue'
        TargetByName( prevTarget );
      end
    else
      ClearTarget();
    end
  end

end

function ClickHeal_TotemKiller:MayNuke( stompedBy )

  local i;

  if ( not stompedBy ) then
    return( true );
  end

  if ( UnitName('player') == stompedBy ) then
    return( false );
  end

  for i=1,GetNumRaidMembers() do
    if ( UnitExists('raid'..i) and UnitName('raid'..i) == stompedBy ) then
      return( false );
    end
  end

  for i=1,GetNumPartyMembers() do
    if ( UnitExists('party'..i) and UnitName('party'..i) == stompedBy ) then
      return( false );
    end
  end

  return( true );

end

function ClickHeal_TotemKiller:NukeTotem( action, spellName, prevTarget )

  if ( action == 'MELEE' ) then
    AttackTarget();
  elseif ( action == 'PET' ) then
    PetAttack();
    self:ReTarget( prevTarget );
  elseif ( action == 'WAND' ) then
    if ( HasWandEquipped('player') ) then
      CH_CastSpellOnEnemy( 'Shoot', nil, 'target', 'SPELL' ); 
    else
      CH_Msg( CLICKHEAL_TOTEMKILLER.MsgNoWandEquipped );
      self:ReTarget( prevTarget );
    end
  elseif ( action == 'BOW' ) then
    if ( GetInventoryItemLink('player',GetInventorySlotInfo('RangedSlot')) ) then
      CH_CastSpellByName( 'Auto Shot' );
    else
      CH_Msg( CLICKHEAL_TOTEMKILLER.MsgNoBowEquipped );
      self:ReTarget( prevTarget );
    end
  elseif ( action == 'SPELL' ) then
    CH_CastSpellOnEnemy( spellName, nil, 'target', 'SPELL' ); 
    self:ReTarget( prevTarget );
  end

end

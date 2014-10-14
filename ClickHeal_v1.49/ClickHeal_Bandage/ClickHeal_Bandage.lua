--=============================================================================
-- File:		ClickHeal_Bandage.lua
-- Author:		rmet0815
-- Description:		ClickHeal Pluging: Bandage
--=============================================================================

ClickHeal_Bandage = { 

  pluginName    = "Bandage";
  pluginVersion = "10800";			-- 1.00.00

  actionID    = 'BANDAGE';
  allowed     = {'friend'};
  classes     = {DRUID=1,HUNTER=1,MAGE=1,PALADIN=1,PRIEST=1,ROGUE=1,SHAMAN=1,WARLOCK=1,WARRIOR=1};
  editable    = nil;
  editable2   = nil;
  insertAfter = 'USEWAND';

  BANDAGES = { [CLICKHEAL_BANDAGE.LinenBandage]          = {itemLevel=1, healTotal=66},
               [CLICKHEAL_BANDAGE.HeavyLinenBandage]     = {itemLevel=1, healTotal=114},
               [CLICKHEAL_BANDAGE.WoolBandage]           = {itemLevel=1, healTotal=161},
               [CLICKHEAL_BANDAGE.HeavyWoolBandage]      = {itemLevel=1, healTotal=301},
               [CLICKHEAL_BANDAGE.SilkBandage]           = {itemLevel=1, healTotal=400},
               [CLICKHEAL_BANDAGE.HeavySilkBandage]      = {itemLevel=1, healTotal=640},
               [CLICKHEAL_BANDAGE.MageweaveBandage]      = {itemLevel=1, healTotal=800},
               [CLICKHEAL_BANDAGE.HeavyMageweaveBandage] = {itemLevel=1, healTotal=1104},
               [CLICKHEAL_BANDAGE.RuneclothBandage]      = {itemLevel=52,healTotal=1360},
               [CLICKHEAL_BANDAGE.HeavyRuneclothBandage] = {itemLevel=58,healTotal=2000}
             };
};

-- ========================================================================================================
-- Events
-- ========================================================================================================
function ClickHeal_Bandage:OnLoad()

  this:RegisterEvent( "VARIABLES_LOADED" );

end

function ClickHeal_Bandage:OnEvent( event, arg1, arg2, arg3 )

  if ( event == 'VARIABLES_LOADED' ) then
    CH_RegisterPlugin( self, self.actionID, self.allowed, self.classes, self.editable, self.editable2, self.insertAfter );
  end  

end

-- ========================================================================================================
-- Query Methods
-- ========================================================================================================

function ClickHeal_Bandage:GetClassName()

  return( 'ClickHeal_Bandage' );

end

function ClickHeal_Bandage:GetVersion()

  return( self.pluginVersion );

end

function ClickHeal_Bandage:GetName()

  return( self.pluginName );

end

function ClickHeal_Bandage:GetActionLabel( actionID )

  return( CLICKHEAL_BANDAGE.ActionTypeText );

end

function ClickHeal_Bandage:GetTooltipInfo( actionID, data, unit )

  return( CLICKHEAL_BANDAGE.ActionTypeText );

end

-- ========================================================================================================
-- Callback from ClickHeal
-- ========================================================================================================

function ClickHeal_Bandage:Callback( unit, data, actionID )

  local bag, slot, itemLink, itemName;
  local bandageBag = -1;
  local bandageSlot = -1;
  local healTotal = -1;

  for bag=0,4 do
    for slot=1,GetContainerNumSlots(bag) do
      itemLink = GetContainerItemLink( bag, slot );
      if ( itemLink ) then
        _,_,itemName = strfind( itemLink, "%[(.*)%]" );
        if ( itemName and self.BANDAGES[itemName] and self.BANDAGES[itemName].healTotal > healTotal ) then
          healTotal = self.BANDAGES[itemName].healTotal;
          bandageBag = bag;
          bandageSlot = slot;
        end
      end
    end
  end

  if ( healTotal > 0 ) then
    CH_CastSpellOnFriend( {bag=bandageBag,slot=bandageSlot}, nil, unit, 'BAG' );
  else
    CH_Msg( CLICKHEAL_BANDAGE.MsgNoBandageFound );
  end

end

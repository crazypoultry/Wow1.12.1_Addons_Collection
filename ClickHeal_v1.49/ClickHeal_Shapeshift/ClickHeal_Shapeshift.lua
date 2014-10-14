--=============================================================================
-- File:		ClickHeal_Shapeshift.lua
-- Author:		rmet0815
-- Description:		ClickHeal Pluging: Shapeshift
--=============================================================================

ClickHeal_Shapeshift = { 

  pluginName    = "Shapeshift";
  pluginVersion = "10700";			-- 1.00.00

  actionID    = 'SHAPESHIFT';
  allowed     = {'extra'};
  classes     = {DRUID=1,HUNTER=0,MAGE=0,PALADIN=0,PRIEST=0,ROGUE=0,SHAMAN=0,WARLOCK=0,WARRIOR=0};
  editable    = 'DROPDOWN';
  editable2   = nil;
  insertAfter = 'SPELL';

  pattern = { BEAR    = CLICKHEAL_SHAPESHIFT.PatternBear,
              CAT     = CLICKHEAL_SHAPESHIFT.PatternCat,
              AQUATIC = CLICKHEAL_SHAPESHIFT.PatternAquatic,
              TRAVEL  = CLICKHEAL_SHAPESHIFT.PatternTravel,
            };

  dropdown1 = { BEAR    = CLICKHEAL_SHAPESHIFT.FormBear,
                CAT     = CLICKHEAL_SHAPESHIFT.FormCat,
                AQUATIC = CLICKHEAL_SHAPESHIFT.FormAquatic,
                TRAVEL  = CLICKHEAL_SHAPESHIFT.FormTravel,
              };

};

-- ========================================================================================================
-- Events
-- ========================================================================================================
function ClickHeal_Shapeshift:OnLoad()

  this:RegisterEvent( "VARIABLES_LOADED" );

end

function ClickHeal_Shapeshift:OnEvent( event, arg1, arg2, arg3 )

  if ( event == 'VARIABLES_LOADED' ) then
    CH_RegisterPlugin( self, self.actionID, self.allowed, self.classes, self.editable, self.editable2, self.insertAfter );
  end  

end

-- ========================================================================================================
-- Query Methods
-- ========================================================================================================

function ClickHeal_Shapeshift:GetClassName()

  return( 'ClickHeal_Shapeshift' );

end

function ClickHeal_Shapeshift:GetVersion()

  return( self.pluginVersion );

end

function ClickHeal_Shapeshift:GetName()

  return( self.pluginName );

end

function ClickHeal_Shapeshift:GetActionLabel( actionID )

  return( CLICKHEAL_SHAPESHIFT.ActionTypeText );

end

function ClickHeal_Shapeshift:GetTooltipInfo( actionID, data, unit )

  return( ClickHeal_Shapeshift.dropdown1[data[1]] );

end

function ClickHeal_Shapeshift:DefaultData( actionID )

  return( { 'BEAR', nil } );

end

function ClickHeal_Shapeshift:DropDownList( actionID, listIdx, data )

  return( ClickHeal_Shapeshift.dropdown1 );

end

-- ========================================================================================================
-- Callback from ClickHeal
-- ========================================================================================================

function ClickHeal_Shapeshift:Callback( unit, data, actionID )

  local i, icon, name, active, castable;
  local activeForm = -1;
  local cancelForm = true;

  for i=1,GetNumShapeshiftForms() do
    icon,name,active,castable = GetShapeshiftFormInfo( i );
    if ( active ) then
      activeForm = i;
    elseif ( castable and string.find(name,self.pattern[data[1]]) ) then
      CastShapeshiftForm( i );
      cancelForm = false;
    end
  end

  if ( activeForm > 0 ) then
    CastShapeshiftForm( activeForm );
  end

end

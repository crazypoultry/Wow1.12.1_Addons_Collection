--=============================================================================
-- File:		ClickHeal_Potion.lua
-- Author:		rmet0815
-- Description:		ClickHeal Pluging: Potion
--=============================================================================

ClickHeal_Potion = { 

  pluginName    = "Potion";
  pluginVersion = "10900";			-- 1.00.00

  healActionID    = 'HEALPOD';
  healAllowed     = {'extra','panic'};
  healClasses     = {DRUID=1,HUNTER=1,MAGE=1,PALADIN=1,PRIEST=1,ROGUE=1,SHAMAN=1,WARLOCK=1,WARRIOR=1};
  healEditable    = 'DROPDOWN';
  healEditable2   = 'DROPDOWN';
  healInsertAfter = 'USEWAND';

  manaActionID    = 'MANAPOD';
  manaAllowed     = {'extra','panic'};
  manaClasses     = {DRUID=1,HUNTER=1,MAGE=1,PALADIN=1,PRIEST=1,ROGUE=1,SHAMAN=1,WARLOCK=1,WARRIOR=1};
  manaEditable    = 'DROPDOWN';
  manaEditable2   = 'DROPDOWN';
  manaInsertAfter = 'HEALPOD';

  HealPotions =  { [CLICKHEAL_POTION.MinorHealingPotion] =      {requiredLevel=0, healAvg=80},
                   [CLICKHEAL_POTION.LesserHealingPotion] =     {requiredLevel=3, healAvg=160},
                   [CLICKHEAL_POTION.DiscoloredHealingPotion] = {requiredLevel=5, healAvg=160},
                   [CLICKHEAL_POTION.HealingPotion] =           {requiredLevel=12,healAvg=320},
                   [CLICKHEAL_POTION.GreaterHealingPotion] =    {requiredLevel=21,healAvg=520},
                   [CLICKHEAL_POTION.CombatHealingPotion] =     {requiredLevel=35,healAvg=800},
                   [CLICKHEAL_POTION.SuperiorHealingPotion] =   {requiredLevel=35,healAvg=800},
                   [CLICKHEAL_POTION.MajorHealingPotion] =      {requiredLevel=45,healAvg=1400},
                 };
  HealthStones = { [CLICKHEAL_POTION.MinorHealthstone] =        {requiredLevel=0, healAvg=100},
                   [CLICKHEAL_POTION.LesserHealthstone] =       {requiredLevel=0, healAvg=250},
                   [CLICKHEAL_POTION.Healthstone] =             {requiredLevel=0, healAvg=500},
                   [CLICKHEAL_POTION.GreaterHealthstone] =      {requiredLevel=0, healAvg=800},
                   [CLICKHEAL_POTION.MajorHealthstone] =        {requiredLevel=0, healAvg=1200},
                 };

  ManaPotions =  { [CLICKHEAL_POTION.MinorManaPotion] =         {requiredLevel=5, manaAvg=160},
                   [CLICKHEAL_POTION.LesserManaPotion] =        {requiredLevel=14,manaAvg=320},
                   [CLICKHEAL_POTION.ManaPotion] =              {requiredLevel=22,manaAvg=520},
                   [CLICKHEAL_POTION.GreaterManaPotion]  =      {requiredLevel=31,manaAvg=800},
                   [CLICKHEAL_POTION.CombatManaPotion] =        {requiredLevel=41,manaAvg=1200},
                   [CLICKHEAL_POTION.SuperiorManaPotion] =      {requiredLevel=41,manaAvg=1200},
                   [CLICKHEAL_POTION.MajorManaPotion] =         {requiredLevel=49,manaAvg=1800},
                 };

  ManaGems =     { [CLICKHEAL_POTION.ManaAgate] =               {requiredLevel=23,manaAvg=400},
                   [CLICKHEAL_POTION.ManaJade] =                {requiredLevel=38,manaAvg=600},
                   [CLICKHEAL_POTION.ManaCitrine] =             {requiredLevel=48,manaAvg=850},
                   [CLICKHEAL_POTION.ManaRuby] =                {requiredLevel=58,manaAvg=1100},
                 };
};

-- ========================================================================================================
-- Events
-- ========================================================================================================
function ClickHeal_Potion:OnLoad()

  this:RegisterEvent( "VARIABLES_LOADED" );

end

function ClickHeal_Potion:OnEvent( event, arg1, arg2, arg3 )

  if ( event == 'VARIABLES_LOADED' ) then
    CH_RegisterPlugin( self, self.healActionID, self.healAllowed, self.healClasses, self.healEditable, self.healEditable2, self.healInsertAfter );
    CH_RegisterPlugin( self, self.manaActionID, self.manaAllowed, self.manaClasses, self.manaEditable, self.manaEditable2, self.manaInsertAfter );
  end  

end

-- ========================================================================================================
-- Query Methods
-- ========================================================================================================

function ClickHeal_Potion:GetClassName()

  return( 'ClickHeal_Potion' );

end

function ClickHeal_Potion:GetVersion()

  return( self.pluginVersion );

end

function ClickHeal_Potion:GetName()

  return( self.pluginName );

end

function ClickHeal_Potion:GetActionLabel( actionID )

  return( CLICKHEAL_POTION.ActionTypeText[actionID] );

end

function ClickHeal_Potion:GetTooltipInfo( actionID, data, unit )

  return( CLICKHEAL_POTION.ActionTypeText[actionID] );

end

function ClickHeal_Potion:DefaultData( actionID )

  if ( actionID == 'HEALPOD' ) then
    return( {'STONE',50} );
  else
    return( {'GEM',50} );
  end

end

function ClickHeal_Potion:DropDownList( actionID, listIdx, data )

  if ( actionID == 'HEALPOD' and listIdx == 1 ) then
    return( {STONE='Healthstone',POTION='Potion',HIGHEST='Highest'} );
  elseif ( actionID == 'HEALPOD' and listIdx == 2 ) then
    return( {[25]='<= 25',[50]='<= 50',[75]='<= 75',[100]='always'} );
  elseif ( actionID == 'MANAPOD' and listIdx == 1 ) then
    return( {GEM='Mana Gem',POTION='Potion',HIGHEST='Highest'} );
  elseif ( actionID == 'MANAPOD' and listIdx == 2 ) then
    return( {[25]='<= 25',[50]='<= 50',[75]='<= 75',[100]='always'} );
  end

end

-- ========================================================================================================
-- Callback from ClickHeal
-- ========================================================================================================

function ClickHeal_Potion:Callback( unit, data, actionID )

  if ( actionID == 'HEALPOD' ) then
    self.QuaffHealPotion( self, data );
  elseif ( actionID == 'MANAPOD' ) then
    self.QuaffManaPotion( self, data );
  else
    CH_Msg( 'Unknown actionID ('..actionID..') at ClickHeal_Potion:Callback()' );
  end

end

-- ========================================================================================================
-- HEALPOD
-- ========================================================================================================

function ClickHeal_Potion:QuaffHealPotion( data )

  local bag, slot, itemLink, itemName;
  local potionBag = -1;
  local potionSlot = -1;
  local potionHealAvg = -1;
  local stoneBag = -1;
  local stoneSlot = -1;
  local stoneHealAvg = -1;
  local useBag = -1;
  local useSlot = -1;
  local playerLevel = UnitLevel('player');
  local start, duration;

  if ( floor(CH_CalcPercentage(UnitHealth('player'),UnitHealthMax('player'))) > data[2] ) then
    CH_Msg( CLICKHEAL_POTION.MsgTooHealthy );
    return;
  end

  for bag=0,4 do
    for slot=1,GetContainerNumSlots(bag) do
      itemLink = GetContainerItemLink( bag, slot );
      if ( itemLink ) then
        _,_,itemName = strfind( itemLink, "%[(.*)%]" );

        if ( itemName and ClickHeal_Potion.HealthStones[itemName] and ClickHeal_Potion.HealthStones[itemName].healAvg > stoneHealAvg and
             ClickHeal_Potion.HealthStones[itemName].requiredLevel <= playerLevel ) 
        then
          start,duration = GetContainerItemCooldown( bag, slot );
          if ( start <= 0 and duration <= 0 ) then
            stoneHealAvg = ClickHeal_Potion.HealthStones[itemName].healAvg;
            stoneBag = bag;
            stoneSlot = slot;
          end
        end

        if ( itemName and ClickHeal_Potion.HealPotions[itemName] and ClickHeal_Potion.HealPotions[itemName].healAvg > potionHealAvg and
             ClickHeal_Potion.HealPotions[itemName].requiredLevel <= playerLevel ) 
        then
          start,duration = GetContainerItemCooldown( bag, slot );
          if ( start <= 0 and duration <= 0 ) then
            potionHealAvg = ClickHeal_Potion.HealPotions[itemName].healAvg;
            potionBag = bag;
            potionSlot = slot;
          end
        end
      end
    end
  end

  if ( (data[1] == 'STONE' and stoneBag >= 0) or 					-- stone prefered
       (data[1] == 'HIGHEST' and stoneHealAvg >= potionHealAvg) ) 			-- highest and stone higher
  then
    useBag = stoneBag;
    useSlot = stoneSlot;
  elseif ( (data[1] == 'POTION' and potionBag >= 0) or 					-- potion prefered
          (data[1] == 'HIGHEST' and potionHealAvg < stoneHealAvg) ) 			-- highest and potion higher
  then
    useBag = potionBag;
    useSlot = potionSlot;
  elseif ( stoneBag >= 0 ) then								-- nothing of above, i have stone
    useBag = stoneBag;
    useSlot = stoneSlot;
  elseif ( potionBag >= 0 ) then							-- nothing of above, i have potion
    useBag = potionBag;
    useSlot = potionSlot;
  end

  if ( useBag >= 0 ) then
    CH_CastSpellOnFriend( {bag=useBag,slot=useSlot}, nil, 'player', 'BAG' );
  else
    CH_Msg( CLICKHEAL_POTION.MsgNoHealPotionFound );
  end

end

-- ========================================================================================================
-- MANAPOD
-- ========================================================================================================

function ClickHeal_Potion:QuaffManaPotion( data )

  local bag, slot, itemLink, itemName;
  local potionBag = -1;
  local potionSlot = -1;
  local potionManaAvg = -1;
  local gemBag = -1;
  local gemSlot = -1;
  local gemManaAvg = -1;
  local useBag = -1;
  local useSlot = -1;
  local playerLevel = UnitLevel('player');
  local start, duration;

  if ( floor(CH_CalcPercentage(UnitMana('player'),UnitManaMax('player'))) > data[2] ) then
    CH_Msg( CLICKHEAL_POTION.MsgTooManaish );
    return;
  end

  for bag=0,4 do
    for slot=1,GetContainerNumSlots(bag) do
      itemLink = GetContainerItemLink( bag, slot );
      if ( itemLink ) then
        _,_,itemName = strfind( itemLink, "%[(.*)%]" );

        if ( itemName and ClickHeal_Potion.ManaGems[itemName] and ClickHeal_Potion.ManaGems[itemName].manaAvg > gemManaAvg and
             ClickHeal_Potion.ManaGems[itemName].requiredLevel <= playerLevel ) 
        then
          local start,duration = GetContainerItemCooldown( bag, slot );
          if ( start <= 0 and duration <= 0 ) then
            gemManaAvg = ClickHeal_Potion.ManaGems[itemName].manaAvg;
            gemBag = bag;
            gemSlot = slot;
          end
        end

        if ( itemName and ClickHeal_Potion.ManaPotions[itemName] and ClickHeal_Potion.ManaPotions[itemName].manaAvg > potionManaAvg and
             ClickHeal_Potion.ManaPotions[itemName].requiredLevel <= playerLevel ) 
        then
          start,duration = GetContainerItemCooldown( bag, slot );
          if ( start <= 0 and duration <= 0 ) then
            potionManaAvg = ClickHeal_Potion.ManaPotions[itemName].manaAvg;
            potionBag = bag;
            potionSlot = slot;
          end
        end
      end
    end
  end

  if ( (data[1] == 'GEM' and gemBag >= 0) or 						-- gem prefered
       (data[1] == 'HIGHEST' and gemHealAvg >= potionHealAvg) ) 			-- highest and gem higher
  then
    useBag = gemBag;
    useSlot = gemSlot;
  elseif ( (data[1] == 'POTION' and potionBag >= 0) or 					-- potion prefered
          (data[1] == 'HIGHEST' and potionHealAvg < gemHealAvg) ) 			-- highest and potion higher
  then
    useBag = potionBag;
    useSlot = potionSlot;
  elseif ( gemBag >= 0 ) then								-- nothing of above, i have gem
    useBag = gemBag;
    useSlot = gemSlot;
  elseif ( potionBag >= 0 ) then							-- nothing of above, i have potion
    useBag = potionBag;
    useSlot = potionSlot;
  end

  if ( useBag >= 0 ) then
    CH_CastSpellOnFriend( {bag=useBag,slot=useSlot}, nil, 'player', 'BAG' );
  else
    CH_Msg( CLICKHEAL_POTION.MsgNoManaPotionFound );
  end

end

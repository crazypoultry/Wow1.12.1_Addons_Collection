--=============================================================================
-- File:		ClickHeal_Nutrition.lua
-- Author:		rmet0815
-- Description:		ClickHeal Pluging: Nutrition
--=============================================================================

ClickHeal_Nutrition = { 

  pluginName    = "Nutrition";
  pluginVersion = "10800";			-- 1.00.00

  foodActionID    = 'FOOD';
  foodAllowed     = {'extra'};
  foodClasses     = {DRUID=1,HUNTER=1,MAGE=1,PALADIN=1,PRIEST=1,ROGUE=1,SHAMAN=1,WARLOCK=1,WARRIOR=1};
  foodEditable    = nil;
  foodEditable2   = nil;
  foodInsertAfter = 'USEWAND';

  drinkActionID    = 'DRINK';
  drinkAllowed     = {'extra'};
  drinkClasses     = {DRUID=1,HUNTER=1,MAGE=1,PALADIN=1,PRIEST=1,ROGUE=1,SHAMAN=1,WARLOCK=1,WARRIOR=1};
  drinkEditable    = nil;
  drinkEditable2   = nil;
  drinkInsertAfter = 'FOOD';

  feastActionID    = 'FEAST';
  feastAllowed     = {'extra'};
  feastClasses     = {DRUID=1,HUNTER=1,MAGE=1,PALADIN=1,PRIEST=1,ROGUE=1,SHAMAN=1,WARLOCK=1,WARRIOR=1};
  feastEditable    = nil;
  feastEditable2   = nil;
  feastInsertAfter = 'DRINK';
};

-- ========================================================================================================
-- Events
-- ========================================================================================================
function ClickHeal_Nutrition:OnLoad()

  this:RegisterEvent( "VARIABLES_LOADED" );

end

function ClickHeal_Nutrition:OnEvent( event, arg1, arg2, arg3 )

  if ( event == 'VARIABLES_LOADED' ) then
    CH_RegisterPlugin( self, self.foodActionID, self.foodAllowed, self.foodClasses, self.foodEditable, self.foodEditable2, self.foodInsertAfter );
    CH_RegisterPlugin( self, self.drinkActionID, self.drinkAllowed, self.drinkClasses, self.drinkEditable, self.drinkEditable2, self.drinkInsertAfter );
    CH_RegisterPlugin( self, self.feastActionID, self.feastAllowed, self.feastClasses, self.feastEditable, self.feastEditable2, self.feastInsertAfter );
  end  

end

-- ========================================================================================================
-- Query Methods
-- ========================================================================================================

function ClickHeal_Nutrition:GetClassName()

  return( 'ClickHeal_Nutrition' );

end

function ClickHeal_Nutrition:GetVersion()

  return( self.pluginVersion );

end

function ClickHeal_Nutrition:GetName()

  return( self.pluginName );

end

function ClickHeal_Nutrition:GetActionLabel( actionID )

  return( CLICKHEAL_NUTRITION.ActionTypeText[actionID] );

end

function ClickHeal_Nutrition:GetTooltipInfo( actionID, data, unit )

  return( CLICKHEAL_NUTRITION.ActionTypeText[actionID] );

end

-- ========================================================================================================
-- Callback from ClickHeal
-- ========================================================================================================

function ClickHeal_Nutrition:Callback( unit, data, actionID )

  if ( actionID == 'FEAST' ) then
    self.UseItem( self, 'DRINK' );
    self.UseItem( self, 'FOOD' );
  else
    self.UseItem( self, actionID );
  end

end

function ClickHeal_Nutrition:GetActionLabel( actionID )

  return( CLICKHEAL_NUTRITION.ActionTypeText[actionID] );

end

-- ========================================================================================================
-- Common
-- ========================================================================================================
--
function ClickHeal_Nutrition:UseItem( actionID )

  local bag, slot, itemLink, itemName, itemNumber, itemString, itemRarity, itemminlevel, itemType, itemSubType;
  local nutriAmount, isSpeicalNutri, isConjured;
  local playerLevel = UnitLevel('player');
  local useIsConjured = false;
  local useNutriAmount = 0;
  local useBag = -1;
  local useSlot = -1;

  if ( actionID == 'FOOD' and UnitHealth('player') >= UnitHealthMax('player') ) then
    return; 
  elseif ( actionID == 'DRINK' and UnitMana('player') >= UnitManaMax('player') ) then
    return;
  end

  for bag=0,4 do
    for slot=1,GetContainerNumSlots(bag) do
      itemLink = GetContainerItemLink( bag, slot );
      if ( itemLink ) then
        _,_,itemNumber = string.find( itemLink, ':(%d+):' );
        if ( itemNumber ) then
          itemName,itemString,itemRarity,itemMinLevel,itemType,itemSubType = GetItemInfo( itemNumber );
          if ( itemType == CLICKHEAL_NUTRITION.ItemTypeConsumable and itemMinLevel <= playerLevel ) then
            if ( actionID == 'FOOD' ) then
              nutriAmount,isSpecialNutri,isConjured = self.GetFoodInfo( self, bag, slot );
            else
              nutriAmount,isSpecialNutri,isConjured = self.GetDrinkInfo( self, bag, slot );
            end
            if ( nutriAmount and (not isSpecialNutri) and 
                 ((isConjured == useIsConjured and nutriAmount > useNutriAmount) or (isConjured and (not useIsConjured))) ) 
            then
              useBag = bag;
              useSlot = slot;
              useNutriAmount = nutriAmount;
              useIsConjured = isConjured;
            end
          end
        end
      end
    end
  end

  if ( useBag > -1 ) then
    CH_CastSpellOnFriend( {bag=useBag,slot=useSlot}, nil, 'player', 'BAG' );
  end

end


-- ========================================================================================================
-- FOOD
-- ========================================================================================================

function ClickHeal_Nutrition:GetFoodInfo( bag, slot )

  local i, text, stuffAmount; 
  local isSpecialFood = false;
  local isConjured = false;

  CH_TooltipTextLeft2:SetText('');
  CH_TooltipTextLeft3:SetText('');
  CH_TooltipTextLeft4:SetText('');
  CH_TooltipSetBagItem( bag, slot );

  for i=2,4 do
    text = getglobal('CH_TooltipTextLeft'..i):GetText();
    if ( text ) then
      if ( text == CLICKHEAL_NUTRITION.PatternConjured ) then
        isConjured = true;
      end
      _,_,stuffAmount = string.find( text, CLICKHEAL_NUTRITION.PatternStuffAmount );
      if ( stuffAmount ) then
        if ( not string.find(text,CLICKHEAL_NUTRITION.PatternSpecialFood) ) then
          isSpecialFood = true;
        end
        return tonumber(stuffAmount), isSpecialFood, isConjured;
      end
    end
  end

  return nil, nil, nil;

end

-- ========================================================================================================
-- DRINK
-- ========================================================================================================

function ClickHeal_Nutrition:GetDrinkInfo( bag, slot )

  local i, text, soakAmount; 
  local isSpecialDrink = false;
  local isConjured = false;

  CH_TooltipTextLeft2:SetText('');
  CH_TooltipTextLeft3:SetText('');
  CH_TooltipTextLeft4:SetText('');
  CH_TooltipSetBagItem( bag, slot );

  for i=2,4 do
    text = getglobal('CH_TooltipTextLeft'..i):GetText();
    if ( text ) then
      if ( text == CLICKHEAL_NUTRITION.PatternConjured ) then
        isConjured = true;
      end
      _,_,soakAmount = string.find( text, CLICKHEAL_NUTRITION.PatternSoakAmount );
      if ( soakAmount ) then
        if ( not string.find(text,CLICKHEAL_NUTRITION.PatternSpecialDrink) ) then
          isSpecialDrink = true;
        end
        return tonumber(soakAmount), isSpecialDrink, isConjured;
      end
    end
  end

  return nil, nil, nil;

end

--=============================================================================
-- File:		TargetFuncs.lua
-- Author:		rudy
-- Description:	Events of TargetFuncs
--=============================================================================

CH_CHAT_MSG = { 'CHAT_MSG_SPELL_AURA_GONE_OTHER',
                'CHAT_MSG_SPELL_AURA_GONE_SELF',
                'CHAT_MSG_SPELL_BREAK_AURA',
                'CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF',
                'CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE',
                'CHAT_MSG_SPELL_CREATURE_VS_PARTY_BUFF',
                'CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE',
                'CHAT_MSG_SPELL_CREATURE_VS_SELF_BUFF',
                'CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE',
                'CHAT_MSG_SPELL_DAMAGESHIELDS_ON_OTHERS',
                'CHAT_MSG_SPELL_DAMAGESHIELDS_ON_SELF',
                'CHAT_MSG_SPELL_FAILED_LOCALPLAYER',
                'CHAT_MSG_SPELL_FRIENDLYPLAYER_BUFF',
                'CHAT_MSG_SPELL_FRIENDLYPLAYER_DAMAGE',
                'CHAT_MSG_SPELL_HOSTILEPLAYER_BUFF',
                'CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE',
                'CHAT_MSG_SPELL_ITEM_ENCHANTMENTS',
                'CHAT_MSG_SPELL_PARTY_BUFF',
                'CHAT_MSG_SPELL_PARTY_DAMAGE',
                'CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS',
                'CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE',
                'CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_BUFFS',
                'CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE',
                'CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_BUFFS',
                'CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE',
                'CHAT_MSG_SPELL_PERIODIC_PARTY_BUFFS',
                'CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE',
                'CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS',
                'CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE',
                'CHAT_MSG_SPELL_PET_BUFF',
                'CHAT_MSG_SPELL_PET_DAMAGE',
                'CHAT_MSG_SPELL_SELF_BUFF',
                'CHAT_MSG_SPELL_SELF_DAMAGE',
              };

function CH_OnLoad()

  this:RegisterEvent( "PLAYER_TARGET_CHANGED" );
  this:RegisterEvent( "PARTY_MEMBERS_CHANGED" );
  this:RegisterEvent( "VARIABLES_LOADED" );
  this:RegisterEvent( "PLAYER_LOGIN" );
  this:RegisterEvent( "SPELLS_CHANGED" );
  this:RegisterEvent( "LEARNED_SPELL_IN_TAB" );
  this:RegisterEvent( "SPELLCAST_START" );
  this:RegisterEvent( "SPELLCAST_INTERRUPTED" );
  this:RegisterEvent( "SPELLCAST_FAILED" );
  this:RegisterEvent( "SPELLCAST_STOP" );
  this:RegisterEvent( "SPELLCAST_DELAYED" );
  this:RegisterEvent( "SPELLCAST_CHANNEL_START" );
  this:RegisterEvent( "SPELLCAST_CHANNEL_UPDATE" );
  this:RegisterEvent( "SPELLCAST_CHANNEL_STOP" );
  this:RegisterEvent( "RAID_ROSTER_UPDATE" );
  this:RegisterEvent( "PLAYER_PET_CHANGED" );

  this:RegisterEvent( "UNIT_MANA" );
  this:RegisterEvent( "UNIT_COMBAT" );
  this:RegisterEvent( "PLAYER_REGEN_ENABLED" );
  this:RegisterEvent( "PLAYER_REGEN_DISABLED" );
  this:RegisterEvent( "PLAYER_ENTER_COMBAT" );
  this:RegisterEvent( "PLAYER_LEAVE_COMBAT" );

  this:RegisterEvent( "ACTIONBAR_SLOT_CHANGED" );
--  this:RegisterEvent( "ACTIONBAR_UPDATE_STATE" );
--  this:RegisterEvent( "ACTIONBAR_UPDATE_USABLE" );
--  this:RegisterEvent( "ACTIONBAR_UPDATE_COOLDOWN" );

  this:RegisterEvent( "BAG_UPDATE_COOLDOWN" );
  this:RegisterEvent( "BAG_UPDATE" );

--  local key,msg;
--  for key,msg in CH_CHAT_MSG do
--    this:RegisterEvent( msg );
--  end

end

function CH_OnEvent( event, arg1, arg2, arg3, arg4, arg5 )

  if ( event == 'PLAYER_TARGET_CHANGED' ) then
    CH_PlayerTargetChanged( arg1 );
    CH_TooltipTargetChanged();
    CH_HealRangeTargetChanged();
  elseif ( event == 'SPELLCAST_START' ) then
    CH_SpellcastStart( arg1, arg2 );
  elseif ( event == 'SPELLCAST_INTERRUPTED' or event == 'SPELLCAST_FAILED' or event == 'SPELLCAST_STOP' ) then
    CH_SpellcastStop( event );
  elseif ( event == 'SPELLCAST_DELAYED' ) then
    CH_SpellcastDelayed( arg1 );
  elseif ( event == 'SPELLCAST_CHANNEL_START' ) then
    CH_SpellcastChannelStart( arg1, arg2 );
  elseif ( event == 'SPELLCAST_CHANNEL_UPDATE' ) then
    CH_SpellcastChannelUpdate( arg1 );
  elseif ( event == 'SPELLCAST_CHANNEL_STOP' ) then
    CH_SpellcastChannelStop( );
  elseif ( event == 'UNIT_COMBAT' ) then
    CH_UnitHit( arg1, arg2, arg3, arg4, arg5 );
  elseif ( event == 'UNIT_MANA' ) then
    CH_UnitMana( arg1 );
  elseif ( event == 'PLAYER_REGEN_ENABLED' ) then
    CH_RegenEnabled();
  elseif ( event == 'PLAYER_REGEN_DISABLED' ) then
    CH_RegenDisabled();
  elseif ( event == 'PLAYER_ENTER_COMBAT' ) then
    CH_EnterCombat();
  elseif ( event == 'PLAYER_LEAVE_COMBAT' ) then
    CH_LeaveCombat();
  elseif ( event == 'ACTIONBAR_SLOT_CHANGED' ) then
    CH_ActionBarSlotChanged( arg1 );
  elseif ( event == 'BAG_UPDATE_COOLDOWN' or event == 'BAG_UPDATE' ) then
    CH_UpdateBags();
  elseif ( event == 'PARTY_MEMBERS_CHANGED' ) then
    CH_PartyMembersChanged();
  elseif ( event == 'RAID_ROSTER_UPDATE' ) then
    CH_RaidRosterUpdate();
  elseif ( event == "PLAYER_PET_CHANGED" ) then
    CH_InitCooldownWatchList();
  elseif ( event == 'VARIABLES_LOADED' ) then
    CH_InitVars();
    CH_CheckVersion();
    CH_AdjustFrames( 'all' );
    CH_DockTargetFrames();
    CH_PartyMembersChanged();
    CH_RaidRosterUpdate();
    CH_ActionBarInit();
    CH_UpdateBags();
    CH_MaskFunctions();
  elseif ( event == 'PLAYER_LOGIN' ) then
    CH_OnEvent( 'SPELLS_CHANGED' );
  elseif ( event == 'SPELLS_CHANGED' or event == 'LEARNED_SPELL_IN_TAB' ) then
    CH_InitSpellMap();
    CH_InitSpells();
    CH_InitTalents();
    CH_InitBuffs();
    CH_InitTotemSets();
    CH_InitCooldownWatchList();
  end

--  if ( CH_InTable(CH_CHAT_MSG,event) ) then
--    CH_Msg( event..": "..arg1 );
--  end

end


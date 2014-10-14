--
-- LazyScript
--
-- An attack scripting language and execution environment for World of
-- Warcraft.  Please see the file About.lua or the About page in-game
-- for the list of credits.
--

lazyScript = {}


-------------------------------------------------------------------------------
-- Metadata object used to track the name, version and revision of the addon
lazyScript.Metadata = {}

function lazyScript.Metadata:new(name)
   local obj = {}
   setmetatable(obj, { __index = self })

   obj.name = name
   obj.version = GetAddOnMetadata(name, "Version")
   obj.revision = nil
   obj.compatibility = tonumber(GetAddOnMetadata(name, "X-LazyScriptCompatibility"))

   obj:updateRevisionFromKeyword(GetAddOnMetadata(name, "X-Revision"))

   return obj
end

function lazyScript.Metadata:updateRevisionFromKeyword(tag)
   local revision = tonumber(string.sub(tag, 12, -3))
   if revision ~= nil and (self.revision == nil or revision > self.revision) then
      self.revision = revision
   end
end

function lazyScript.Metadata:getNameVersionString()
   return self.name.." v"..self.version
end

function lazyScript.Metadata:getNameVersionRevisionString()
   if not self.revision then
      return self:getNameVersionString()
   else
      return self:getNameVersionString().." (r"..self.revision..")"
   end
end
-------------------------------------------------------------------------------


lazyScript.metadata = lazyScript.Metadata:new("LazyScript")
lazyScript.metadata:updateRevisionFromKeyword("$Revision: 732 $")

SLASH_LAZYSCRIPT1 = "/lazyscript"
-- What about luaslinger?
-- SLASH_LAZYSCRIPT2 = "/ls"

BINDING_HEADER_LAZYSCRIPT = lazyScript.metadata.name
BINDING_NAME_LAZYSCRIPT_EXECUTE = "Execute Default Form"
BINDING_NAME_LAZYSCRIPT_KEYBIND1 = "Execute Form 1"
BINDING_NAME_LAZYSCRIPT_KEYBIND2 = "Execute Form 2"
BINDING_NAME_LAZYSCRIPT_KEYBIND3 = "Execute Form 3"
BINDING_NAME_LAZYSCRIPT_KEYBIND4 = "Execute Form 4"
BINDING_NAME_LAZYSCRIPT_KEYBIND5 = "Execute Form 5"
BINDING_NAME_LAZYSCRIPT_KEYBIND6 = "Execute Form 6"
BINDING_NAME_LAZYSCRIPT_KEYBIND7 = "Execute Form 7"
BINDING_NAME_LAZYSCRIPT_KEYBIND8 = "Execute Form 8"
BINDING_NAME_LAZYSCRIPT_KEYBIND9 = "Execute Form 9"
BINDING_NAME_LAZYSCRIPT_KEYBIND10 = "Execute Form 10"

LS_TEXTURE_PREFIX = "Interface\\Icons\\"

lazyScript.addOnIsActive = false
lazyScript.isInCombat = false
lazyScript.attackSlot = nil
lazyScript.autoShotSlot = nil
lazyScript.autoWandSlot = nil
lazyScript.behindAttackLastFailedAt = 0
lazyScript.inFrontAttackLastFailedAt = 0
lazyScript.outdoorsAttackLastFailedAt = 0
lazyScript.rangeCheckAction = nil
lazyScript.lastAttacker = ""
lazyScript.numberOfAttackers = 0
lazyScript.ganked= nil
lazyScript.InDuel = false
lazyScript.talentCache = {}
lazyScript.parsedFormCache = {}
lazyScript.parsedFormDependencies = {}
lazyScript.realmName = "Unknown"
lazyScript.playerName = "Unknown"
lazyScript.latestEnergy = 0
lazyScript.lastTickTime = 0
lazyScript.targetHealthHistory = nil
lazyScript.channellingInProgress = false
lazyScript.spellcastInProgress = false
lazyScript.lastDodgeTime = {}
lazyScript.lastBlockTime = {}
lazyScript.lastParryTime = {}
lazyScript.lastResistTime = {}
lazyScript.npcIsFleeing = nil
lazyScript.perPlayerConf = nil
lazyScript.defaultForms = nil

lsConf = {}
lsConfGlobal = {}
lsConfGlobal.SpellType = {};
lsConf.confVersion = 1
lsConf.perPlayer = {}

lsConf.interruptExceptionCriteria = {
   "-ifTargetIsCasting=^Shoot$",
   "# The following almost always works great, but",
   "# Reportedly some mobs in Winterspring may have",
   "# 0 mana but can still cast.",
   "-ifTarget=0mana-ifTargetNPC",
   "# example of possibile options",
   "#-ifTargetClass=Warrior",
   "# the following is an example for a weird boss that",
   "# behaves differently under 50% hp (no kicks)",
   "#-ifTargetNamed=Some%sMajor%sBoss-ifTarget<50%hp",
 }


lazyScript.perPlayerDefaults = {
   ["autoTarget"] = true,
   ["deathMinionHidesOutOfCombat"] = false,
   ["deathMinionIsVisible"] = false,
   ["debug"] = false,
   ["healthHistorySize"] = 5,
   ["initiateAutoAttack"] = true,
   ["showActionAlways"] = true,
   ["minimapButtonPos"] = 0,
   ["minionHidesOutOfCombat"] = false,
   ["minionIsVisible"] = true,
   ["mmIsVisible"] = true,
   ["showTargetCasts"] = false,
   ["showReasonForTargetCCd"] = false,
   ["showGankMessage"] = false,
   ["clearHistoryAfterCombat"] = false,
   ["useImmunities"] = true,
   ["Immunities"] = {} ,
}

function lazyScript.OnLoad()
   lazyScript.addOnIsActive = true

   lazyScript.LoadLocalization(GetLocale())
   lazyScript.loadBuffTable()
   lazyScript.loadActionTable()

   this:RegisterEvent("VARIABLES_LOADED")
   this:RegisterEvent("PLAYER_LOGIN")

   SlashCmdList["LAZYSCRIPT"] = lazyScript.SlashCommand
end

function lazyScript.OnEvent()
   if (event == "VARIABLES_LOADED") then
      -- Convenience variables
      lazyScript.realmName = GetRealmName()
      lazyScript.playerName = UnitName("player")

      -- Create the per-player config table for this character if it doesn't exist
      if (not lsConf.perPlayer[lazyScript.realmName]) then
         lsConf.perPlayer[lazyScript.realmName] = {}
      end
      if (not lsConf.perPlayer[lazyScript.realmName][lazyScript.playerName]) then
         lsConf.perPlayer[lazyScript.realmName][lazyScript.playerName] = {}
      end

      -- Another convenience variable
      lazyScript.perPlayerConf = lsConf.perPlayer[lazyScript.realmName][lazyScript.playerName]

      -- Load the Lazy<Class> addons if it exists
      local localeClass, class = UnitClass("player")
      lazyScript.LoadAddOnByClass(class)

      -- Initialize the forms table
      if (not lazyScript.perPlayerConf.forms) then
         lazyScript.perPlayerConf.forms = {}
      end

      -- Load up default forms if we haven't done so before
      if (lazyScript.defaultForms ~= nil and not lazyScript.perPlayerConf.loadedDefaultForms) then
         lazyScript.LoadDefaultForms()
         lazyScript.perPlayerConf.loadedDefaultForms = true
      end

      -- Load class-addon default settings
      if (lazyScript.customPerPlayerDefaults ~= nil) then
         lazyScript.LoadCustomDefaults()
      end

      -- Initialize the per-player configuration to defaults
      for key, val in pairs(lazyScript.perPlayerDefaults) do
         if (lazyScript.perPlayerConf[key] == nil) then
            lazyScript.perPlayerConf[key] = val
         end
      end

      -- Initialize keybindings
      if (not lazyScript.perPlayerConf.BoundFormsTable) then
         lazyScript.perPlayerConf.BoundFormsTable = {}
      end

   elseif (event == "PLAYER_LOGIN") then

      this:RegisterEvent("PLAYER_ENTERING_WORLD")
      this:RegisterEvent("PLAYER_ENTER_COMBAT")
      this:RegisterEvent("PLAYER_LEAVE_COMBAT")
      this:RegisterEvent("PLAYER_TARGET_CHANGED")
      this:RegisterEvent("PLAYER_REGEN_DISABLED")
      this:RegisterEvent("PLAYER_REGEN_ENABLED")
      this:RegisterEvent("ACTIONBAR_SLOT_CHANGED")
      this:RegisterEvent("SPELLS_CHANGED")
      this:RegisterEvent("UI_ERROR_MESSAGE")

      -- Determine if inventory position of items need to be checked again
      this:RegisterEvent("BAG_UPDATE")

      -- Deathstimator
      lazyScript.targetHealthHistory = lazyScript.deathstimator.HealthHistory:New()
      this:RegisterEvent("UNIT_HEALTH")

      if (lazyScript.perPlayerConf["useImmunities"]) then
         if lazyScript.ImmunityLocalized() then
            this:RegisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE")
         else
            lazyScript.d("Immunity tracking is not supported for your locale.")
         end
      end

      -- Casting interrupts
      -- PvE
      this:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE")
      this:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF")

      -- Ganked and Attacker tracking
      this:RegisterEvent("CHAT_MSG_COMBAT_SELF_HITS")
      if lazyScript.GankedLocalized() then
         this:RegisterEvent("CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE")
         this:RegisterEvent("CHAT_MSG_COMBAT_HOSTILEPLAYER_HITS")
      else
         lazyScript.p("ifGanked and ifXAttackers is not supported for your locale.")
      end

      -- Attacker tracking

      --WG flag tracking
      if lazyScript.BattlegroundsLocalized() then
         this:RegisterEvent("CHAT_MSG_BG_SYSTEM_ALLIANCE")
         this:RegisterEvent("CHAT_MSG_BG_SYSTEM_HORDE")
      else
         lazyScript.p("Battleground flag-holder detection is not supported for your locale.")
      end

      --duel detection
      if lazyScript.DuelingLocalized() then
         this:RegisterEvent("CHAT_MSG_SYSTEM")
      else
         lazyScript.p("Dueling detection is not supported for your locale.")
      end

      --spell type tracking
      this:RegisterEvent("CHAT_MSG_SPELL_FRIENDLYPLAYER_DAMAGE")
      this:RegisterEvent("CHAT_MSG_SPELL_PARTY_DAMAGE")
      this:RegisterEvent("CHAT_MSG_SPELL_HOSTILEPLAYER_BUFF")

      --player casting
      this:RegisterEvent("SPELLCAST_CHANNEL_START");
      this:RegisterEvent("SPELLCAST_CHANNEL_STOP");
      this:RegisterEvent("SPELLCAST_FAILED");
      this:RegisterEvent("SPELLCAST_INTERRUPTED");
      this:RegisterEvent("SPELLCAST_STOP");

      this:RegisterEvent("SPELLCAST_START");

      -- Determine melee range check spell
      this:RegisterEvent("LEARNED_SPELL_IN_TAB")

      -- Check if target is fleeing
      this:RegisterEvent("CHAT_MSG_MONSTER_EMOTE")

      -- Dodge/Parry/Block/Resist tracking
      if lazyScript.DodgeParryBlockResistLocalized() then
         this:RegisterEvent("CHAT_MSG_COMBAT_SELF_MISSES")
         this:RegisterEvent("CHAT_MSG_COMBAT_CREATURE_VS_SELF_MISSES")
         this:RegisterEvent("CHAT_MSG_COMBAT_HOSTILEPLAYER_MISSES")
         if (not lazyScript.perPlayerConf["useImmunities"]) then -- register if not already registered for immunities
            this:RegisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE")
         end
         this:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE")
         -- (registered above) this:RegisterEvent("CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE")
      else
         lazyScript.p("ifDodged/Parried/Blocked/Resisted are not supported for your locale.")
      end

      local rangeAction = lazyScript.getRangeCheckAction()
      if lazyScript.spellSearch(rangeAction) then
         lazyScript.rangeCheckAction = rangeAction
      end

      -- Parse interrupt exception criteria and cache the parsed form
      lazyScript.masks.parsingInterruptExceptionCriteria = true
      lazyScript.parsedInterruptExceptionCriteriaCache = lazyScript.ParseForm("interruptExceptionCriteria", lsConf.interruptExceptionCriteria)
      lazyScript.masks.parsingInterruptExceptionCriteria = false

      -- Parse all forms to insert them into the cache
      for formName in pairs(lazyScript.perPlayerConf.forms) do
         lazyScript.FindParsedForm(formName, false)
      end

      -- Show the minion
      if (lazyScript.perPlayerConf.minionIsVisible) then
         LazyScriptMinionFrame:Show()
      end

      if (lazyScript.perPlayerConf.showActionAlways == true and dummy ~= nil) then
         lazyScript.minion.OnUpdate()
      elseif (dummy ~= nil) then
         lazyScript.minion.SetText(lazyScript.perPlayerConf.defaultForm)
      else
         lazyScript.minion.SetText("Welcome to "..lazyScript.metadata.name)
      end

      -- Show the Deathstimator!
      lazyScript.deathstimator.minion.SetText("Deathstimator")
      if (lazyScript.perPlayerConf.deathMinionIsVisible) then
         LazyScriptDeathstimatorFrame:Show()
      end

      -- Everything registered and ready to go. Say Hello!
      lazyScript.chat(lazyScript.metadata:getNameVersionRevisionString().." loaded. All the rope you need...")

   elseif (event == "PLAYER_ENTERING_WORLD") then
      -- Player has entered world, reset combat flag just in case we didn't
      -- or won't get the REGEN_ENABLED event.
      lazyScript.OnPlayerRegenEnabled()

   -- Now for everything else that is used by LazyScript
   elseif (event == "CHAT_MSG_SYSTEM") then
      local duelCountdown = lazyScript.getLocaleString("DUEL_COUNTDOWN")
      local duelWinnerKnockOut = lazyScript.getLocaleString("DUEL_WINNER_KNOCKOUT")
      local duelWinnerRetreat = lazyScript.getLocaleString("DUEL_WINNER_RETREAT")

      if duelCountdown and duelWinnerKnockOut and duelWinnerRetreat then
         if lazyScript.re(arg1, duelCountdown) then
            if lazyScript.match1 == "3" then
               lazyScript.InDuel = true
               lazyScript.d("Entering Duel")
            end
         elseif lazyScript.re(arg1, duelWinnerKnockOut) or lazyScript.re(arg1, duelWinnerRetreat) then
            if lazyScript.match1 == UnitName("player") or lazyScript.match2 == UnitName("player") then
               lazyScript.InDuel = false
               lazyScript.d("Leaving Duel")
            end
         end
      end

   elseif event == "CHAT_MSG_BG_SYSTEM_ALLIANCE" or event == "CHAT_MSG_BG_SYSTEM_HORDE" then
      --lazyScript.d(event..": arg1="..lazyScript.safeString(arg1))

      local wsgZone = lazyScript.getLocaleString("BG_WSG_ZONE")
      local flagPickedUp = lazyScript.getLocaleString("BG_WSG_FLAG_PICKED_UP")
      local flagCaptured = lazyScript.getLocaleString("BG_WSG_FLAG_CAPTURED")
      local flagDropped = lazyScript.getLocaleString("BG_WSG_FLAG_DROPPED")
      local flagReturned = lazyScript.getLocaleString("BG_WSG_FLAG_RETURNED")

      if (wsgZone and flagPickedUp and flagCaptured and flagDropped and flagReturned) then
         if string.find(GetZoneText(), wsgZone) then
            local englishFaction, localizedFaction = UnitFactionGroup("player")
            flagPickedUp = string.format(flagPickedUp, localizedFaction)
            flagCaptured = string.format(flagCaptured, localizedFaction)
            flagDropped = string.format(flagDropped, localizedFaction)
            flagReturned = string.format(flagReturned, localizedFaction)
            if lazyScript.re(arg1, flagPickedUp) then
               lazyScript.flagHolder = lazyScript.match1
               lazyScript.d("Flag Holder: "..lazyScript.flagHolder)
            elseif string.find(arg1, flagCaptured) or string.find(arg1, flagDropped) or string.find(arg1, flagReturned) then
               lazyScript.flagHolder = ""
               lazyScript.d("Flag Holder: Empty")
            end
         end
      end

   elseif (event == "PLAYER_ENTER_COMBAT") then
      lazyScript.ResetEveryTimers()

   elseif (event == "PLAYER_LEAVE_COMBAT") then
      lazyScript.ResetNowAndEveryTimers()

   elseif (event == "PLAYER_TARGET_CHANGED") then
      lazyScript.lastDodgeTime["target"] = nil
      lazyScript.lastBlockTime["target"] = nil
      lazyScript.lastParryTime["target"] = nil
      lazyScript.lastResistTime["target"] = nil
      lazyScript.interrupt.targetCasting = nil
      lazyScript.ResetEveryTimers()
      lazyScript.ResetNowAndEveryTimers()
      lazyScript.targetHealthHistory:Reset()
      lazyScript.npcIsFleeing = nil

   elseif (event == "PLAYER_REGEN_DISABLED") then
      lazyScript.isInCombat = true
      lazyScript.minion.OnUpdate()  -- force refresh, in case it's hidden
      lazyScript.deathstimator.minion.OnUpdate()  -- force refresh, in case it's hidden

   elseif (event == "PLAYER_REGEN_ENABLED") then
      lazyScript.OnPlayerRegenEnabled()

   elseif (event == "ACTIONBAR_SLOT_CHANGED") then
      lazyScript.DeCacheActionSlotIds()
      lazyScript.attackSlot = nil
      lazyScript.autoShotSlot = nil
      lazyScript.autoWandSlot = nil
      lazyScript.globalCooldownSlot = nil

   elseif (event == "SPELLS_CHANGED") then
      lazyScript.DeCacheActionRanks()

   elseif (event == "BAG_UPDATE") then
      lazyScript.DeCacheItemSlots()

   elseif (event == "UI_ERROR_MESSAGE") then
      if (arg1 == SPELL_FAILED_NOT_BEHIND) then
         lazyScript.d("I see your behind-only attack just failed, will wait to use it again.")
         lazyScript.behindAttackLastFailedAt = GetTime()

      elseif (arg1 == SPELL_FAILED_NOT_INFRONT) then
         lazyScript.d("I see your infront-only attack just failed, will wait to use it again.")
         lazyScript.inFrontAttackLastFailedAt = GetTime()

      elseif (arg1 == SPELL_FAILED_ONLY_OUTDOORS) then
         lazyScript.d("I see your outdoors-only attack just failed, will wait to use it again.")
         lazyScript.outdoorsAttackLastFailedAt = GetTime()

      end

   elseif (event == "UNIT_HEALTH") then
      lazyScript.deathstimator.OnUnitHealth(arg1)

   elseif (event == "CHAT_MSG_COMBAT_SELF_HITS") then
      if lazyScript.ganked==nil then
         lazyScript.ganked = false
      end

   elseif (event == "CHAT_MSG_COMBAT_SELF_MISSES") then
      lazyScript.CheckDodgeParryBlockResist("target", event, arg1)

   elseif (event == "CHAT_MSG_SPELL_SELF_DAMAGE") then
      lazyScript.CheckDodgeParryBlockResist("target", event, arg1)

      local immune = lazyScript.getLocaleString("IMMUNE")
      if (immune) then
         if lazyScript.perPlayerConf["useImmunities"] then
            if string.find(arg1, immune ) then
               lazyScript.WatchForImmunes(arg1)
            end
         end
      end

   elseif (event == "CHAT_MSG_COMBAT_CREATURE_VS_SELF_MISSES") or
          (event == "CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE") or
          (event == "CHAT_MSG_COMBAT_HOSTILEPLAYER_MISSES") then
      lazyScript.CheckDodgeParryBlockResist("player", event, arg1)

   elseif (event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE" or
           event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF" or
           event == "CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE" or
           event == "CHAT_MSG_SPELL_HOSTILEPLAYER_BUFF" or
           event == "CHAT_MSG_COMBAT_HOSTILEPLAYER_HITS") then
      -- have to lump these two features together since
      -- CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE is used by a number of
      -- features: PvP kick support, attacker tracking,
      -- dodge/parry/block/resists tracking

      if event == "CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE" then
         lazyScript.CheckDodgeParryBlockResist("player", event, arg1)
      end

      if (event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE" or
          event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF" or
          event == "CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE" or
          event == "CHAT_MSG_SPELL_HOSTILEPLAYER_BUFF") then
         lazyScript.interrupt.OnChatMsgSpell(arg1)
         lazyScript.WatchForType(arg1)
      end

      if (event=="CHAT_MSG_COMBAT_HOSTILEPLAYER_HITS" or
          event=="CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE") then
         local gankedChats = lazyScript.getLocaleString("GANKED_CHATS")
         if gankedChats then
            for idx, regex in ipairs(gankedChats) do
               if (lazyScript.re(arg1, regex)) then
                  if lazyScript.ganked==nil then
                     lazyScript.ganked = true
                  end
                  player = lazyScript.match1

                  if not(string.find(lazyScript.lastAttacker," "..player..",")) then
                     lazyScript.numberOfAttackers = lazyScript.numberOfAttackers + 1
                     lazyScript.lastAttacker = lazyScript.lastAttacker.." "..player..","
                  end
                  break
               end
            end
         end
      end

   elseif (event == "CHAT_MSG_SPELL_FRIENDLYPLAYER_DAMAGE" or
           event == "CHAT_MSG_SPELL_PARTY_DAMAGE") then
      lazyScript.WatchForType(arg1)

   -- Stop interrupting those channel spells
   elseif (event == "SPELLCAST_CHANNEL_START") then
      --lazyScript.d("Channelling spell start detected: "..arg2)
      if (not lazyScript.channellingInProgress) then
         lazyScript.channellingInProgress = true
      end

   elseif (event == "SPELLCAST_CHANNEL_STOP") then
      --lazyScript.d("Channelling spell stop detected.")
      lazyScript.channellingInProgress = false

   elseif (event == "SPELLCAST_START") then
      --lazyScript.d("Spellcast start detected: "..arg1)
      if (not lazyScript.spellcastInProgress) then
         lazyScript.spellcastInProgress = true;
      end

   elseif (event == "SPELLCAST_STOP") then
      --lazyScript.d("Spellcast stop detected.")
      if (lazyScript.spellcastInProgress) then
         lazyScript.spellcastInProgress = false
      end

   elseif (event == "SPELLCAST_FAILED") then
      --lazyScript.d("Spellcast failure detected.")
      if (lazyScript.spellcastInProgress) then
         lazyScript.spellcastInProgress = false
      end

   elseif (event == "SPELLCAST_INTERRUPTED") then
      --lazyScript.d("Spellcast interruption detected.")
      if (lazyScript.spellcastInProgress) then
         lazyScript.spellcastInProgress = false
      end

   elseif (event == "LEARNED_SPELL_IN_TAB") then
      if (not lazyScript.rangeCheckAction) then
         local rangeAction = lazyScript.getRangeCheckAction()
         if lazyScript.spellSearch(rangeAction) then
            lazyScript.rangeCheckAction = rangeAction
         end
      end

   elseif (event == "CHAT_MSG_MONSTER_EMOTE") then
      lazyScript.OnChatMsgMonsterEmote(arg1,arg2)

   else
      lazyScript.d("Unhandled event: "..event..": ")
   end

end

function lazyScript.OnPlayerRegenEnabled()
   lazyScript.isInCombat = false
   if (lazyScript.perPlayerConf.showActionAlways == true) then
      lazyScript.minion.OnUpdate()
   else
      lazyScript.minion.SetText(lazyScript.perPlayerConf.defaultForm)
   end
   lazyScript.deathstimator.minion.SetText("Deathstimator")

   if lazyScript.numberOfAttackers ~= 0 then
      if lazyScript.ganked == true  then
         local ganked = lazyScript.getLocaleString("GANKED")
         if ganked then
            if lazyScript.perPlayerConf.showGankMessage then
               lazyScript.p(tostring("|cffe5e519"..string.format(ganked, lazyScript.lastAttacker, lazyScript.numberOfAttackers)))
            end
         else
            lazyScript.d("ifGanked not supported for your locale.")
         end
      else
         if lazyScript.perPlayerConf.showGankMessage then
            lazyScript.p(tostring("|cffe5e519PVP Opponents:"..lazyScript.lastAttacker.." Count:"..lazyScript.numberOfAttackers))
         end
      end
   end
   lazyScript.lastAttacker = ""
   lazyScript.numberOfAttackers = 0
   lazyScript.ganked = nil
   lazyScript.npcIsFleeing = nil

   if lazyScript.perPlayerConf.clearHistoryAfterCombat then
      lazyScript.actionHistory = {}
   end
end

function lazyScript.OnChatMsgMonsterEmote(arg1,arg2)
   lazyScript.d("Monster Emote: arg1="..lazyScript.safeString(arg1).." arg2="..lazyScript.safeString(arg2))

   local npcFleeMsg = lazyScript.getLocaleString("NPC_FLEE_MSG")

   if (npcFleeMsg) then
      if string.find(arg1, npcFleeMsg) then
         lazyScript.d("Detected fleeing NPC: "..arg2)
         lazyScript.npcIsFleeing = arg2
      end
   end
end

function lazyScript.DuelingLocalized()
   local duelCountdown = lazyScript.getLocaleString("DUEL_COUNTDOWN", false, true)
   local duelWinnerKnockOut = lazyScript.getLocaleString("DUEL_WINNER_KNOCKOUT", false, true)
   local duelWinnerRetreat = lazyScript.getLocaleString("DUEL_WINNER_RETREAT", false, true)

   return duelCountdown and duelWinnerKnockOut and duelWinnerRetreat
end


function lazyScript.BattlegroundsLocalized()
   local wsgZone = lazyScript.getLocaleString("BG_WSG_ZONE", false, true)
   local flagPickedUp = lazyScript.getLocaleString("BG_WSG_FLAG_PICKED_UP", false, true)
   local flagCaptured = lazyScript.getLocaleString("BG_WSG_FLAG_CAPTURED", false, true)
   local flagDropped = lazyScript.getLocaleString("BG_WSG_FLAG_DROPPED", false, true)
   local flagReturned = lazyScript.getLocaleString("BG_WSG_FLAG_RETURNED", false, true)

   return wsgZone and flagPickedUp and flagCaptured and flagDropped and flagReturned
end

function lazyScript.DodgeParryBlockResistLocalized()
   local unitIds = { "PLAYER", "TARGET" }
   local events = { "DODGE", "DODGE_SPELL", "PARRY", "PARRY_SPELL", "BLOCK", "BLOCK_SPELL", "RESIST_SPELL" }

   for _, unitId in ipairs(unitIds) do
      for _, event in ipairs(events) do
         local text = lazyScript.getLocaleString(unitId.."_"..event, false, true)
         if not text then
            return false
         end
      end
   end

   return true
end

function lazyScript.CheckDodgeParryBlockResist(unitId, event, arg1)
   local prefix = string.upper(unitId)
   local dodged = lazyScript.getLocaleString(prefix.."_DODGE", false, true)
   local dodgedSpell = lazyScript.getLocaleString(prefix.."_DODGE_SPELL", false, true)
   local parried = lazyScript.getLocaleString(prefix.."_PARRY", false, true)
   local parriedSpell = lazyScript.getLocaleString(prefix.."_PARRY_SPELL", false, true)
   local blocked = lazyScript.getLocaleString(prefix.."_BLOCK", false, true)
   local blockedSpell = lazyScript.getLocaleString(prefix.."_BLOCK_SPELL", false, true)
   local resistedSpell = lazyScript.getLocaleString(prefix.."_RESIST_SPELL", false, true)

   if dodged and dodgedSpell and parried and parriedSpell and blocked and blockedSpell and resistedSpell then
      local now = GetTime()
      if string.find(arg1, dodged) or string.find(arg1, dodgedSpell) then
         lazyScript.lastDodgeTime[unitId] = now
         lazyScript.d(unitId.." dodge detected at "..now)
      elseif string.find(arg1, parried) or string.find(arg1, parriedSpell) then
         lazyScript.lastParryTime[unitId] = now
         lazyScript.d(unitId.." parry detected at "..now)
      elseif string.find(arg1, blocked) or string.find(arg1, blockedSpell) then
         lazyScript.lastBlockTime[unitId] = now
         lazyScript.d(unitId.." block detected at "..now)
      elseif string.find(arg1, resistedSpell) then
         lazyScript.lastResistTime[unitId] = now
         lazyScript.d(unitId.." resist detected at "..now)
      end
   end
end

function lazyScript.ImmunityLocalized()
   local immune = lazyScript.getLocaleString("IMMUNE", false, true)
   return immune ~= nil
end

function lazyScript.GankedLocalized()
   local ganked = lazyScript.getLocaleString("GANKED_CHATS", false, true)
   return ganked ~= nill
end

function lazyScript.Help()
   lazyScript.chat(lazyScript.metadata:getNameVersionRevisionString())
   lazyScript.chat(SLASH_LAZYSCRIPT1.." do <attack1> [<attack2> ...]")
   lazyScript.chat(SLASH_LAZYSCRIPT1.." list")
   lazyScript.chat(SLASH_LAZYSCRIPT1.." edit <formName>")
   lazyScript.chat(SLASH_LAZYSCRIPT1.." set <formName> <attack1> [<attack2> ...]")
   lazyScript.chat(SLASH_LAZYSCRIPT1.." copy <formName> <formName2>")
   lazyScript.chat(SLASH_LAZYSCRIPT1.." clear <formName>")
   lazyScript.chat(SLASH_LAZYSCRIPT1.." default [<formName>] [quiet]")
   lazyScript.chat(SLASH_LAZYSCRIPT1.." [<formName>]")
   lazyScript.chat(SLASH_LAZYSCRIPT1.." summon")
   lazyScript.chat(SLASH_LAZYSCRIPT1.." dismiss")
   lazyScript.chat(SLASH_LAZYSCRIPT1.." hideMinionOutOfCombat")
   lazyScript.chat(SLASH_LAZYSCRIPT1.." summonDeath")
   lazyScript.chat(SLASH_LAZYSCRIPT1.." dismissDeath")
   lazyScript.chat(SLASH_LAZYSCRIPT1.." hideDeathMinionOutOfCombat")
   lazyScript.chat(SLASH_LAZYSCRIPT1.." mmshow")
   lazyScript.chat(SLASH_LAZYSCRIPT1.." mmhide")
   lazyScript.chat(SLASH_LAZYSCRIPT1.." interruptExceptionCriteria")
   lazyScript.chat(SLASH_LAZYSCRIPT1.." noLongerInterruptLastInterrupted")
   lazyScript.chat(SLASH_LAZYSCRIPT1.." showTargetCasts")
   lazyScript.chat(SLASH_LAZYSCRIPT1.." autoTarget")
   lazyScript.chat(SLASH_LAZYSCRIPT1.." initiateAutoAttack")
   lazyScript.chat(SLASH_LAZYSCRIPT1.." assist <playername>")
   lazyScript.chat(SLASH_LAZYSCRIPT1.." useImmunitiesList")
   lazyScript.chat(SLASH_LAZYSCRIPT1.." clearImmunitiesList")
   lazyScript.chat(SLASH_LAZYSCRIPT1.." imunityExceptionCriteria")
   lazyScript.chat(SLASH_LAZYSCRIPT1.." showGankMessage")
   lazyScript.chat(SLASH_LAZYSCRIPT1.." clearHistoryAfterCombat")

   if (lazyScript.CustomCommandLineHelp ~= nil) then
      lazyScript.CustomCommandLineHelp()
   end

   lazyScript.chat(SLASH_LAZYSCRIPT1.." resetDefaultForms")
   lazyScript.chat(SLASH_LAZYSCRIPT1.." resetAllForms")
   lazyScript.chat(SLASH_LAZYSCRIPT1.." about")
   lazyScript.chat(SLASH_LAZYSCRIPT1.." help")


end

function lazyScript.ListForms()
   -- sigh, table.sort() sorts the values, no way to sort by keys...
   local formNames = {}
   for form, actions in pairs(lazyScript.perPlayerConf.forms) do
      table.insert(formNames, form)
   end

   table.sort(formNames)

   for idx, formName in ipairs(formNames) do
      local name = formName
      local actions = lazyScript.perPlayerConf.forms[formName]

      if (lazyScript.perPlayerConf.defaultForm and formName == lazyScript.perPlayerConf.defaultForm) then
         name = "*"..name
      end
      lazyScript.chat(name..": "..table.concat(actions, ' '))
   end
end

function lazyScript.SlashCommand(line)
   if (not line) then
      line = ""
   end
   local args = lazyScript.SplitArgs(line)
   local cmd = args[1]
   table.remove(args, 1)

   local foundCMD = true

   if (not cmd or cmd == "") then
      if (not lazyScript.perPlayerConf.defaultForm) then
         lazyScript.p("No default form assigned, choose a form from the "..lazyScript.metadata.name.." minimap bubble, or use "..SLASH_LAZYSCRIPT1.." default <form> to set one.")
         return false
      end
      local noParse = false
      local actions = lazyScript.FindParsedForm(lazyScript.perPlayerConf.defaultForm, noParse)
      if (not actions) then
         lazyScript.p("Your default form is "..lazyScript.perPlayerConf.defaultForm..", but it doesn't exist or there is an error!  Please choose a form from the "..lazyScript.metadata.name.." minimap bubble or set it using "..SLASH_LAZYSCRIPT1.." default <form>.")
         return false
      end
      local doNothing = false
      lazyScript.TryActions(actions, doNothing)

   elseif (cmd == "help") then
      lazyScript.Help()

   elseif (cmd == "about") then
      LazyScriptAboutFrame:Show()

   elseif (cmd == "debug") then
      if (lazyScript.perPlayerConf.debug) then
         lazyScript.perPlayerConf.debug = false
         lazyScript.p("Debugging off.")
      else
         lazyScript.perPlayerConf.debug = true
         lazyScript.p("Debugging on.")
      end

   elseif (cmd == "list") then
      lazyScript.ListForms()

   elseif (cmd == "edit") then
      local form = args[1]
      LazyScriptFormEditFrame:Hide()
      lazyScript.formEditBox.currentForm = form
      LazyScriptFormScrollFrame:SetWidth(LazyScriptFormEditFrame:GetWidth()-50);
      LazyScriptFormEditFrameForm:SetWidth(LazyScriptFormScrollFrame:GetWidth()-50);
      LazyScriptFormScrollFrame:SetHeight(LazyScriptFormEditFrame:GetHeight()-110);
      LazyScriptFormEditFrameForm:SetHeight(LazyScriptFormScrollFrame:GetHeight()-110);
      LazyScriptFormEditFrame:Show()

   elseif (cmd == "set") then
      local form = args[1]
      table.remove(args, 1)
      local verb
      if (lazyScript.perPlayerConf.forms[form]) then
         verb = "updated"
      else
         verb = "created"
      end
      lazyScript.perPlayerConf.forms[form] = args
      lazyScript.ClearParsedForm(form)
      lazyScript.FindParsedForm(form)
      lazyScript.p("Form "..form.." "..verb..".")

   elseif (cmd == "copy") then
      local form1 = args[1]
      local form2 = args[2]
      --lazyScript.perPlayerConf.forms[form2] = form1
      if (not lazyScript.perPlayerConf.forms[form1]) then
         lazyScript.p("Form "..form1.." doesn't exist.")
         return false
      end
      -- I'm not sure exactly how lua works.. but I think I can't just
      -- point form2 to form1's actions, because it's by reference, and
      -- then any changes to form1 would affect form2.  So copy...
      local newActions = {}
      for idx, action in ipairs(lazyScript.perPlayerConf.forms[form1]) do
         table.insert(newActions, action)
      end
      lazyScript.perPlayerConf.forms[form2] = newActions
      lazyScript.p("Form "..form1.." copied to form "..form2..".")

   elseif (cmd == "clear") then
      local form = args[1]
      -- destroy this form entry
      -- this is how you do it in Lua, just set its value to nil
      lazyScript.perPlayerConf.forms[form] = nil
      lazyScript.ClearParsedForm(form)
      lazyScript.p("Form "..form.." removed.")

      -- Clear the cache for forms which depended on the one just removed
      local cleared = lazyScript.ClearDependentForms(form)
      if table.getn(cleared) > 0 then
         lazyScript.p("WARNING: The following forms included the form "..form.." which you just removed: "..table.concat(cleared, ", ")..". They have been invalidated and must be edited before you can use them.")
      end

      if (lazyScript.perPlayerConf.defaultForm == form) then
         if (lazyScript.perPlayerConf.forms.ls) then
            lazyScript.perPlayerConf.defaultForm = "ls"
            lazyScript.p("Default form is now lazyScript.")
         else
            lazyScript.perPlayerConf.defaultForm = nil
            lazyScript.p("WARNING: you no longer have a default form.  Choose one from the "..lazyScript.metadata.name.." minimap bubble.")
         end
      end

   elseif (cmd == "do") then
      local actions = lazyScript.ParseForm("*SlashCommand*", args)
      local doNothing = false
      if (actions) then
         lazyScript.TryActions(actions, doNothing)
      end

   elseif (cmd == "autoTarget") then
      if (lazyScript.perPlayerConf.autoTarget) then
         lazyScript.perPlayerConf.autoTarget = false
         lazyScript.p(lazyScript.metadata.name.." will no longer auto-target.")
         -- turning off autotargeting also means turning off initiating auto-attack
         if (lazyScript.perPlayerConf.initiateAutoAttack) then
            lazyScript.SlashCommand("initiateAutoAttack")
         end
      else
         lazyScript.perPlayerConf.autoTarget = true
         lazyScript.p(lazyScript.metadata.name.." will now auto-target.")
      end

   elseif (cmd == "initiateAutoAttack") then
      if (lazyScript.perPlayerConf.initiateAutoAttack) then
         lazyScript.perPlayerConf.initiateAutoAttack = false
         lazyScript.p(lazyScript.metadata.name.." will no longer initiate auto-attack.")
      else
         lazyScript.perPlayerConf.initiateAutoAttack = true
         lazyScript.p(lazyScript.metadata.name.." will now initiate auto-attack.")
      end

   elseif (cmd == "useImmunitiesList") then
      if (lazyScript.perPlayerConf.useImmunities) then
         lazyScript.perPlayerConf.useImmunities = false
         lazyScript.p(lazyScript.metadata.name.." will no longer check for immunities.")
      else
         lazyScript.perPlayerConf.useImmunities = true
         lazyScript.p(lazyScript.metadata.name.." will now check for immunities.")
      end

   elseif (cmd == "clearImmunitiesList") then
      lazyScript.perPlayerConf.Immunities = {}
      lazyScript.p("Immunities list cleared.")

   elseif (cmd == "summon") then
      lazyScript.perPlayerConf.minionIsVisible = true
      LazyScriptMinionFrame:Show()
      lazyScript.p("Now showing the minion.")

   elseif (cmd == "dismiss") then
      lazyScript.perPlayerConf.minionIsVisible = false
      LazyScriptMinionFrame:Hide()
      lazyScript.p("Hiding the minion.")

   elseif (cmd == "hideMinionOutOfCombat") then
      if (lazyScript.perPlayerConf.minionHidesOutOfCombat) then
         lazyScript.perPlayerConf.minionHidesOutOfCombat = false
         if lazyScript.perPlayerConf.minionIsVisible then
            LazyScriptMinionFrame:Show()
         end
         lazyScript.p("Minion will no longer hide out of combat.")
      else
         lazyScript.perPlayerConf.minionHidesOutOfCombat = true
         if not lazyScript.perPlayerConf.minionIsVisible and not lazyScript.isInCombat then
            LazyScriptMinionFrame:Hide()
         end
         lazyScript.p("Minion will now hide out of combat.")
      end

   elseif (cmd == "summonDeath") then
      lazyScript.perPlayerConf.deathMinionIsVisible = true
      LazyScriptDeathstimatorFrame:Show()
      lazyScript.p("Now showing the deathstimator minion.")

   elseif (cmd == "dismissDeath") then
      lazyScript.perPlayerConf.deathMinionIsVisible = false
      LazyScriptDeathstimatorFrame:Hide()
      lazyScript.p("Hiding the deathstimator minion.")

   elseif (cmd == "hideDeathMinionOutOfCombat") then
      if (lazyScript.perPlayerConf.deathMinionHidesOutOfCombat) then
         lazyScript.perPlayerConf.deathMinionHidesOutOfCombat = false
         LazyScriptDeathstimatorFrame:Show()
         lazyScript.p("Death minion will no longer hide out of combat.")
      else
         lazyScript.perPlayerConf.deathMinionHidesOutOfCombat = true
         lazyScript.p("Death minion will now hide out of combat.")
      end

   elseif (cmd == "showReasonForTargetCCd") then
      if (lazyScript.perPlayerConf.showReasonForTargetCCd) then
         lazyScript.perPlayerConf.showReasonForTargetCCd = false
         lazyScript.p("No longer showing why "..lazyScript.metadata.name.." thinks a target is CCd.")
      else
         lazyScript.perPlayerConf.showReasonForTargetCCd = true
         lazyScript.p("Now showing why "..lazyScript.metadata.name.." thinks a target is CCd.")
      end

   elseif (cmd == "showGankMessage") then
      if (lazyScript.perPlayerConf.showGankMessage) then
         lazyScript.perPlayerConf.showGankMessage = false
         lazyScript.p("No longer showing gank info.")
      else
         lazyScript.perPlayerConf.showGankMessage = true
         lazyScript.p("Now showing gank info.")
      end

   elseif (cmd == "clearHistoryAfterCombat") then
      if (lazyScript.perPlayerConf.clearHistoryAfterCombat) then
         lazyScript.perPlayerConf.clearHistoryAfterCombat = false
         lazyScript.p("No longer clearing History after combat.")
      else
         lazyScript.perPlayerConf.clearHistoryAfterCombat = true
         lazyScript.p("Now clearing History after combat.")
      end

   elseif (cmd == "mmshow") then
      lazyScript.perPlayerConf.mmIsVisible = true
      LazyScriptMinimapFrame:Show()
      LazyScriptMinimapButton:Show()

   elseif (cmd == "mmhide") then
      lazyScript.perPlayerConf.mmIsVisible = false
      LazyScriptMinimapFrame:Hide()
      LazyScriptMinimapButton:Hide()

   elseif (cmd == "immunityExceptionCriteria") then
      LazyScriptImmunityExceptionCriteriaEditFrame:Show()

   elseif (cmd == "interruptExceptionCriteria") then
      LazyScriptInterruptExceptionCriteriaEditFrame:Show()

   elseif (cmd == "noLongerInterruptLastInterrupted") then
      if (not lazyScript.interrupt.lastSpellInterrupted) then
         lazyScript.p("You haven't interrupted anything recently.")
      else
         local lastInterrupted = string.gsub(lazyScript.interrupt.lastSpellInterrupted,
                                             "([%^%$%(%)%%%.%[%]%*%+%-%?])", "%%%1")
         lastInterrupted = string.gsub(lastInterrupted, "%s", "%%s")
         local criteria = "-ifTargetIsCasting=^"..lastInterrupted.."$"
         table.insert(lsConf.interruptExceptionCriteria, criteria)
         lazyScript.p("Added new exception ("..criteria..") to global interrupt criteria.")
      end

   elseif (cmd == "showTargetCasts") then
      if (lazyScript.perPlayerConf.showTargetCasts) then
         lazyScript.perPlayerConf.showTargetCasts = false
         lazyScript.p("No longer showing when the target casts.")
      else
         lazyScript.perPlayerConf.showTargetCasts = true
         lazyScript.p("Now showing when the target casts.")
      end

   elseif (cmd == "assist") then
      if args[1] ~= nil then
         lazyScript.assistName = args[1]
         lazyScript.p("Assist set to "..lazyScript.assistName)
      elseif UnitExists("target") and UnitIsPlayer("target") and UnitIsFriend("target","player") and UnitName("target") ~= UnitName("player") then
         lazyScript.assistName = UnitName("target")
         if lazyScript.masks.PlayerInRaid() then
            SendChatMessage("Assist set to "..UnitName("target"), "Raid");
         elseif lazyScript.masks.PlayerInGroup() then
            SendChatMessage("Assist set to "..UnitName("target"), "Party");
         else
            SendChatMessage("Assist set to "..UnitName("target"), "Say");
         end
      else
         lazyScript.p("Target Assist Not Set!")
      end

   elseif (cmd == "default") then
      local form = args[1]
      local quiet = args[2] == "quiet"
      if (form) then
         local actions = lazyScript.FindForm(form)
         if (not actions) then
            lazyScript.p("Form "..form.." not found.")
            return false
         end
         lazyScript.perPlayerConf.defaultForm = form
         if (not quiet) then
            lazyScript.p("Default form is now "..form)
         end
      else
         lazyScript.p("Default form is "..lazyScript.safeString(lazyScript.perPlayerConf.defaultForm))
      end

      -- Parse default form to insert it into the cache
      local noParse = false
      local dummy = lazyScript.FindParsedForm(lazyScript.perPlayerConf.defaultForm, noParse)
      if (lazyScript.perPlayerConf.showActionAlways == true) then
         lazyScript.minion.OnUpdate()
      else
         lazyScript.minion.SetText(lazyScript.perPlayerConf.defaultForm)
      end

   elseif (cmd == "resetDefaultForms") then
      lazyScript.resetLazyScriptForms()

   elseif (cmd == "resetAllForms") then
      lazyScript.resetLazyScriptForms(true)

   elseif (lazyScript.CustomCommandLineArgs ~= nil) then
      foundCMD = lazyScript.CustomCommandLineArgs(cmd, args)

   else
      foundCMD = false

   end

   if (not foundCMD) then
      local noParse = false
      local actions = lazyScript.FindParsedForm(cmd, noParse)
      if (not actions) then
         lazyScript.p("Form "..cmd.." not found.  Try "..SLASH_LAZYSCRIPT1.." help for help.")
         return false
      end
      local doNothing = false
      if (actions) then
         lazyScript.TryActions(actions, doNothing)
      end
   end

end

function lazyScript.LoadDefaultForms()
   for key, val in pairs(lazyScript.defaultForms) do
      lazyScript.perPlayerConf.forms[key] = val
   end
end

function lazyScript.resetLazyScriptForms(all)
   for key, form in pairs(lazyScript.perPlayerConf.forms) do
      lazyScript.ClearParsedForm(key)
   end

   if (all) then
      lazyScript.perPlayerConf.forms = {}
      lazyScript.p("Erased all forms.")
   end

   if lazyScript.defaultForms ~= nil then
      for key, form in pairs(lazyScript.defaultForms) do
         lazyScript.perPlayerConf.forms[key] = form
      end
   end

   lazyScript.p("Reset forms to defaults.")
end


-- previous API for compatibility
function LazyScript()
   lazyScript.SlashCommand()
end


function lazyScript.LoadCustomDefaults()
   for key, val in pairs(lazyScript.customPerPlayerDefaults) do
      if (lazyScript.perPlayerConf[key] == nil) then
         lazyScript.perPlayerConf[key] = val
      end
   end
end

function lazyScript.LoadAddOnByClass(class)
   local loaded
   local reason
   if (class == "ROGUE") then
      loaded, reason = LoadAddOn("LazyRogue")
   elseif (class == "HUNTER") then
      loaded, reason = LoadAddOn("LazyHunter")
   elseif (class == "PRIEST") then
      loaded, reason = LoadAddOn("LazyPriest")
   elseif (class == "DRUID") then
      loaded, reason = LoadAddOn("LazyDruid")
   elseif (class == "WARRIOR") then
      loaded, reason = LoadAddOn("LazyWarrior")
   elseif (class == "MAGE") then
      loaded, reason = LoadAddOn("LazyMage")
   elseif (class == "SHAMAN") then
      loaded, reason = LoadAddOn("LazyShaman")
   elseif (class == "PALADIN") then
      loaded, reason = LoadAddOn("LazyPaladin")
   elseif (class == "WARLOCK") then
      loaded, reason = LoadAddOn("LazyWarlock")
   else
      lazyScript.p("A "..lazyScript.metadata.name.." addon was not found for your class.")
   end
end


function lazyScript.CheckCompatibility(addonMetadata)
   if lazyScript.metadata.compatibility == addonMetadata.compatibility then
      return true
   end

   StaticPopupDialogs["LAZYSCRIPT_INCOMPATIBLE_ADDON"] = {
      text = lazyScript.getLocaleString("INCOMPATIBLE_ADDON", true),
      button1 = TEXT(OKAY),
      timeout = 0,
      whileDead = 1,
      exclusive = 1,
      hideOnEscape = 1,
      showAlert = 1
   };

   StaticPopup_Show("LAZYSCRIPT_INCOMPATIBLE_ADDON", addonMetadata:getNameVersionRevisionString(), lazyScript.metadata:getNameVersionRevisionString());

   return false
end

function lazyScript.UseBoundForm(index)
   local keyForm = lazyScript.perPlayerConf.BoundFormsTable[index]
   if keyForm then
      lazyScript.SlashCommand(keyForm)
   else
      lazyScript.p("There is no form bound to this key.")
   end
end

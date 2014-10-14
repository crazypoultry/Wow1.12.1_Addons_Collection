lazyWarriorLoad.metadata:updateRevisionFromKeyword("$Revision: 644 $")

function lazyWarriorLoad.LoadWarriorLocalization(locale)

   lazyWarriorLocale.enUS.ACTION_TTS.bloodrage         = "Bloodrage"
   lazyWarriorLocale.enUS.ACTION_TTS.charge            = "Charge"
   lazyWarriorLocale.enUS.ACTION_TTS.battleShout       = "Battle Shout"
   lazyWarriorLocale.enUS.ACTION_TTS.thunderClap       = "Thunder Clap"
   lazyWarriorLocale.enUS.ACTION_TTS.rend              = "Rend"
   lazyWarriorLocale.enUS.ACTION_TTS.hamstring         = "Hamstring"
   lazyWarriorLocale.enUS.ACTION_TTS.heroicStrike      = "Heroic Strike"
   lazyWarriorLocale.enUS.ACTION_TTS.sunder            = "Sunder Armor"
   lazyWarriorLocale.enUS.ACTION_TTS.overpower         = "Overpower"
   lazyWarriorLocale.enUS.ACTION_TTS.demoShout         = "Demoralizing Shout"
   lazyWarriorLocale.enUS.ACTION_TTS.revenge           = "Revenge"
   lazyWarriorLocale.enUS.ACTION_TTS.mockingBlow       = "Mocking Blow"
   lazyWarriorLocale.enUS.ACTION_TTS.shieldBlock       = "Shield Block"
   lazyWarriorLocale.enUS.ACTION_TTS.disarm            = "Disarm"
   lazyWarriorLocale.enUS.ACTION_TTS.cleave            = "Cleave"
   lazyWarriorLocale.enUS.ACTION_TTS.execute           = "Execute"
   lazyWarriorLocale.enUS.ACTION_TTS.deathWish         = "Death Wish"
   lazyWarriorLocale.enUS.ACTION_TTS.intercept         = "Intercept"
   lazyWarriorLocale.enUS.ACTION_TTS.berserkerRage     = "Berserker Rage"
   lazyWarriorLocale.enUS.ACTION_TTS.whirlwind         = "Whirlwind"
   lazyWarriorLocale.enUS.ACTION_TTS.pummel            = "Pummel"
   lazyWarriorLocale.enUS.ACTION_TTS.bloodthirst       = "Bloodthirst"
   lazyWarriorLocale.enUS.ACTION_TTS.piercingHowl      = "Piercing Howl"
   lazyWarriorLocale.enUS.ACTION_TTS.taunt             = "Taunt"
   lazyWarriorLocale.enUS.ACTION_TTS.battle            = "Battle Stance"
   lazyWarriorLocale.enUS.ACTION_TTS.defensive         = "Defensive Stance"
   lazyWarriorLocale.enUS.ACTION_TTS.berserk           = "Berserker Stance"
   lazyWarriorLocale.enUS.ACTION_TTS.lastStand         = "Last Stand"
   lazyWarriorLocale.enUS.ACTION_TTS.shieldBash        = "Shield Bash"
   lazyWarriorLocale.enUS.ACTION_TTS.mortalStrike      = "Mortal Strike"
   lazyWarriorLocale.enUS.ACTION_TTS.shieldSlam        = "Shield Slam"
   lazyWarriorLocale.enUS.ACTION_TTS.sweepingStrikes   = "Sweeping Strikes"
   lazyWarriorLocale.enUS.ACTION_TTS.concussionBlow    = "Concussion Blow"
   lazyWarriorLocale.enUS.ACTION_TTS.challengingShout  = "Challenging Shout"
   lazyWarriorLocale.enUS.ACTION_TTS.intimidatingShout = "Intimidating Shout"
   lazyWarriorLocale.enUS.ACTION_TTS.recklessness      = "Recklessness"
   lazyWarriorLocale.enUS.ACTION_TTS.retaliation       = "Retaliation"
   lazyWarriorLocale.enUS.ACTION_TTS.shieldWall        = "Shield Wall"
   lazyWarriorLocale.enUS.ACTION_TTS.slam              = "Slam"

   -- assume english, unless overridden below
   if (locale == "deDE") then -- German
      lazyWarriorLocale.deDE.ACTION_TTS.overpower        = "\195\156berw\195\164ltigen"
      lazyWarriorLocale.deDE.ACTION_TTS.shieldBash       = "Schildhieb"

   elseif (locale == "frFR") then -- French
      lazyWarriorLocale.frFR.ACTION_TTS.overpower        = "Fulgurance"
      lazyWarriorLocale.frFR.ACTION_TTS.shieldBash       = "Coup de bouclier"

   end
end

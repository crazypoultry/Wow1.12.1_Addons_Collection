lazyMageLoad.metadata:updateRevisionFromKeyword("$Revision: 689 $")

function lazyMageLoad.LoadMageLocalization(locale)

   lazyMageLocale.enUS.ACTION_TTS.amplifyMagic     = "Amplify Magic"
   lazyMageLocale.enUS.ACTION_TTS.arcanePower      = "Arcane Power"
   lazyMageLocale.enUS.ACTION_TTS.blastWave        = "Blast Wave"
   lazyMageLocale.enUS.ACTION_TTS.blink            = "Blink"
   lazyMageLocale.enUS.ACTION_TTS.blizzard         = "Blizzard"
   lazyMageLocale.enUS.ACTION_TTS.brilliance       = "Arcane Brilliance"
   lazyMageLocale.enUS.ACTION_TTS.coldSnap         = "Cold Snap"
   lazyMageLocale.enUS.ACTION_TTS.combustion       = "Combustion"
   lazyMageLocale.enUS.ACTION_TTS.coneCold         = "Cone of Cold"
   lazyMageLocale.enUS.ACTION_TTS.conjureAgate     = "Conjure Mana Agate"
   lazyMageLocale.enUS.ACTION_TTS.conjureCitrine   = "Conjure Mana Citrine"
   lazyMageLocale.enUS.ACTION_TTS.conjureFood      = "Conjure Food"
   lazyMageLocale.enUS.ACTION_TTS.conjureJade      = "Conjure Mana Jade"
   lazyMageLocale.enUS.ACTION_TTS.conjureRuby      = "Conjure Mana Ruby"
   lazyMageLocale.enUS.ACTION_TTS.conjureWater     = "Conjure Water"
   lazyMageLocale.enUS.ACTION_TTS.counter          = "Counterspell"
   lazyMageLocale.enUS.ACTION_TTS.dampenMagic      = "Dampen Magic"
   lazyMageLocale.enUS.ACTION_TTS.detectMagic      = "Detect Magic"
   lazyMageLocale.enUS.ACTION_TTS.evocation        = "Evocation"
   lazyMageLocale.enUS.ACTION_TTS.explosion        = "Arcane Explosion"
   lazyMageLocale.enUS.ACTION_TTS.fireball         = "Fireball"
   lazyMageLocale.enUS.ACTION_TTS.fireBlast        = "Fire Blast"
   lazyMageLocale.enUS.ACTION_TTS.fireWard         = "Fire Ward"
   lazyMageLocale.enUS.ACTION_TTS.flamestrike      = "Flamestrike"
   lazyMageLocale.enUS.ACTION_TTS.frostArmor       = "Frost Armor"
   lazyMageLocale.enUS.ACTION_TTS.frostbolt        = "Frostbolt"
   lazyMageLocale.enUS.ACTION_TTS.frostNova        = "Frost Nova"
   lazyMageLocale.enUS.ACTION_TTS.frostWard        = "Frost Ward"
   lazyMageLocale.enUS.ACTION_TTS.iceArmor         = "Ice Armor"
   lazyMageLocale.enUS.ACTION_TTS.iceBarrier       = "Ice Barrier"
   lazyMageLocale.enUS.ACTION_TTS.iceBlock         = "Ice Block"
   lazyMageLocale.enUS.ACTION_TTS.intellect        = "Arcane Intellect"
   lazyMageLocale.enUS.ACTION_TTS.mageArmor        = "Mage Armor"
   lazyMageLocale.enUS.ACTION_TTS.manaShield       = "Mana Shield"
   lazyMageLocale.enUS.ACTION_TTS.missiles         = "Arcane Missiles"
   lazyMageLocale.enUS.ACTION_TTS.pig              = "Polymorph: Pig"
   lazyMageLocale.enUS.ACTION_TTS.pom              = "Presence of Mind"
   lazyMageLocale.enUS.ACTION_TTS.pyroblast        = "Pyroblast"
   lazyMageLocale.enUS.ACTION_TTS.removeCurse      = "Remove Curse"
   lazyMageLocale.enUS.ACTION_TTS.scorch           = "Scorch"
   lazyMageLocale.enUS.ACTION_TTS.sheep            = "Polymorph"
   lazyMageLocale.enUS.ACTION_TTS.slowFall         = "Slow Fall"
   lazyMageLocale.enUS.ACTION_TTS.teleDarnassus    = "Teleport: Darnassus"
   lazyMageLocale.enUS.ACTION_TTS.teleIronforge    = "Teleport: Ironforge"
   lazyMageLocale.enUS.ACTION_TTS.teleOgrimmar     = "Teleport: Ogrimmar"
   lazyMageLocale.enUS.ACTION_TTS.teleStormwind    = "Teleport: Stormwind"
   lazyMageLocale.enUS.ACTION_TTS.teleThunderBluff = "Teleport: Thunder Bluff"
   lazyMageLocale.enUS.ACTION_TTS.teleUndercity    = "Teleport: Undercity"
   lazyMageLocale.enUS.ACTION_TTS.turtle           = "Polymorph: Turtle"
   lazyMageLocale.enUS.ACTION_TTS.portDarnassus    = "Portal: Darnassus"
   lazyMageLocale.enUS.ACTION_TTS.portIronforge    = "Portal: Ironforge"
   lazyMageLocale.enUS.ACTION_TTS.portOgrimmar     = "Portal: Ogrimmar"
   lazyMageLocale.enUS.ACTION_TTS.portStormwind    = "Portal: Stormwind"
   lazyMageLocale.enUS.ACTION_TTS.portThunderBluff = "Portal: Thunder Bluff"
   lazyMageLocale.enUS.ACTION_TTS.portUndercity    = "Portal: Undercity"


   -- assume english, unless overridden below
   if (locale == "deDE") then
      -- German

      lazyMageLocale.deDE.ACTION_TTS.conjureAgate     = "Mana-Achat herbeizaubern"
      lazyMageLocale.deDE.ACTION_TTS.conjureCitrine   = "Mana-Citrin herbeizaubern"
      lazyMageLocale.deDE.ACTION_TTS.conjureJade      = "Mana-Jadestein herbeizaubern"
      lazyMageLocale.deDE.ACTION_TTS.conjureRuby      = "Mana-Rubin herbeizaubern"
      lazyMageLocale.deDE.ACTION_TTS.explosion        = "Arkane Explosion"
      lazyMageLocale.deDE.ACTION_TTS.frostArmor       = "Frostr\195\188stung"
      lazyMageLocale.deDE.ACTION_TTS.iceArmor         = "Eisr\195\188stung"


   elseif (locale == "frFR") then
      -- French

      lazyMageLocale.frFR.ACTION_TTS.conjureAgate     = "Invocation d'une agate de mana"
      lazyMageLocale.frFR.ACTION_TTS.conjureCitrine   = "Invocation d'une citrine de mana"
      lazyMageLocale.frFR.ACTION_TTS.conjureJade      = "Invocation d'une jade de mana"
      lazyMageLocale.frFR.ACTION_TTS.conjureRuby      = "Invocation d'un rubis de mana"
      lazyMageLocale.frFR.ACTION_TTS.explosion        = "Explosion des arcanes"
      lazyMageLocale.frFR.ACTION_TTS.frostArmor       = "Armure de givre"
      lazyMageLocale.frFR.ACTION_TTS.iceArmor         = "Armure de glace"

   end
end


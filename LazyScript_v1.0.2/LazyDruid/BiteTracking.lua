lazyDruidLoad.metadata:updateRevisionFromKeyword("$Revision: 524 $")

-- Ferocious bite tracking

function lazyDruidLoad.LoadBiteTracking()
   if (not lazyDruid.spellSearch(lazyDruid.actions.bite)) then
      lazyDruid.d("You don't have ferocious bite yet.")
      return
   end

   if (not lazyDruid.getLocaleString("BITE_HIT") or not lazyDruid.getLocaleString("BITE_CRIT")) then
      lazyDruid.p("Ferocious Bite tracking is not supported by your locale")
      return
   end

   lazyDruid.bite = {}


   function lazyDruid.bite.ResetBiteTracking()
      lazyDruid.perPlayerConf.biteTracker = { {0,0}, {0,0}, {0,0}, {0,0}, {0,0} }
      lazyDruid.p("Reset Ferocious Bite stats.")
   end

   function lazyDruid.bite.GetBiteTrackingInfo(cp)
      local observedDamage = lazyDruid.perPlayerConf.biteTracker[cp][1]
      local observedCt = lazyDruid.perPlayerConf.biteTracker[cp][2]
      return observedDamage, observedCt
   end

   function lazyDruid.bite.SetBiteTrackingInfo(cp, observedDamage, observedCt)
      lazyDruid.perPlayerConf.biteTracker[cp][1] = observedDamage
      lazyDruid.perPlayerConf.biteTracker[cp][2] = observedCt
   end

   function lazyDruid.bite.TrackBite(arg1)
      local biteHit = lazyDruid.getLocaleString("BITE_HIT")
      local biteCrit = lazyDruid.getLocaleString("BITE_CRIT")

      if (not biteHit or not biteCrit) then
         return
      end

      local thisDamage = nil
      if (lazyDruid.re(arg1, biteHit)) then
         thisDamage = lazyDruid.match2
      elseif (lazyDruid.perPlayerConf.trackBiteCrits and lazyDruid.re(arg1, biteCrit)) then
         thisDamage = lazyDruid.match2
      end

      if (not thisDamage) then
         return
      end

      if (not lazyDruid.biteComboPoints or lazyDruid.biteComboPoints == 0) then
         lazyDruid.d("lazyDruid.biteComboPoints is nil or 0, can't record")
         return
      end

      local observedDamage, observedCt = lazyDruid.bite.GetBiteTrackingInfo(lazyDruid.biteComboPoints)

      observedDamage = observedDamage * observedCt
      local newCt = observedCt + 1
      observedDamage = observedDamage + thisDamage
      observedDamage = observedDamage / newCt
      observedCt = math.min(lazyDruid.perPlayerConf.biteSample, newCt)

      lazyDruid.bite.SetBiteTrackingInfo(lazyDruid.biteComboPoints, observedDamage, observedCt)

      local expectedDamage = lazyDruid.masks.CalculateBaseBiteDamage(lazyDruid.biteComboPoints)
      local thisRatio = thisDamage / expectedDamage
      local avgRatio = observedDamage / expectedDamage
      lazyDruid.d("Ferocious Bite ("..lazyDruid.biteComboPoints.."cp): "..thisDamage.." damage (optimal "..
           expectedDamage..") "..string.format("%.2f", thisRatio).."/"..
           string.format("%.2f", avgRatio).." (cur/avg vs. optimal)")

      lazyDruid.biteComboPoints = nil
   end

   -- Hook UseAction() so we can record how many combo points the
   -- player had when he used ferocious bite.
   function lazyDruid.bite.UseActionHook(action, checkCursor, onSelf)
      if (action == lazyDruid.actions.bite:GetSlot()) then
         lazyDruid.biteComboPoints = GetComboPoints()
         --lazyDruid.d("UseActionHook, I see you're using ferocious bite with "..lazyDruid.biteComboPoints.." cps")
      end
      return lazyDruid.UseActionOrig(action, checkCursor, onSelf)
   end

   function lazyDruid.bite.CastSpellHook(spellIndex, spellBookType)
      local spellIndexStart, rankCount, maxRank = lazyDruid.actions.bite:FindSpellRanks(false)
      if ((spellIndexStart + rankCount - 1) == spellIndex) then
         lazyDruid.biteComboPoints = GetComboPoints()
         lazyDruid.d("CastSpellHook, I see you're using ferocious bite with "..lazyDruid.biteComboPoints.." cps")
      end
      return lazyDruid.CastSpellOrig(spellIndex, spellBookType)
   end


end -- function lazyDruidLoad.LoadBiteTracking()

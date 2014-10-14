lazyRogueLoad.metadata:updateRevisionFromKeyword("$Revision: 521 $")

-- Eviscerate tracking

function lazyRogueLoad.LoadEviscTracking()
   if (not lazyRogue.getLocaleString("EVISCERATE_HIT") or not lazyRogue.getLocaleString("EVISCERATE_CRIT")) then
      lazyRogue.p("Eviscerate tracking is not supported by your locale")
      return
   end

   lazyRogue.et = {}


   function lazyRogue.et.ResetEviscTracking()
      lazyRogue.perPlayerConf.eviscTracker = { {0,0}, {0,0}, {0,0}, {0,0}, {0,0} }
   end

   function lazyRogue.et.GetEviscTrackingInfo(cp)
      local observedDamage = lazyRogue.perPlayerConf.eviscTracker[cp][1]
      local observedCt = lazyRogue.perPlayerConf.eviscTracker[cp][2]
      return observedDamage, observedCt
   end

   function lazyRogue.et.SetEviscTrackingInfo(cp, observedDamage, observedCt)
      lazyRogue.perPlayerConf.eviscTracker[cp][1] = observedDamage
      lazyRogue.perPlayerConf.eviscTracker[cp][2] = observedCt
   end

   function lazyRogue.et.TrackEviscerates(arg1)
      local eviscerateHit = lazyRogue.getLocaleString("EVISCERATE_HIT")
      local eviscerateCrit = lazyRogue.getLocaleString("EVISCERATE_CRIT")

      if (not eviscerateHit or not eviscerateCrit) then
         return
      end

      local thisDamage = nil
      if (lazyRogue.re(arg1, eviscerateHit)) then
         thisDamage = lazyRogue.match2
      elseif (lazyRogue.perPlayerConf.trackEviscCrits and lazyRogue.re(arg1, eviscerateCrit)) then
         thisDamage = lazyRogue.match2
      end
      if (not thisDamage) then
         return
      end

      if (not lazyRogue.eviscComboPoints or lazyRogue.eviscComboPoints == 0) then
         lazyRogue.d("lazyRogue.eviscComboPoints is nil or 0, can't record")
         return
      end

      local observedDamage, observedCt = lazyRogue.et.GetEviscTrackingInfo(lazyRogue.eviscComboPoints)

      observedDamage = observedDamage * observedCt
      local newCt = observedCt + 1
      observedDamage = observedDamage + thisDamage
      observedDamage = observedDamage / newCt
      observedCt = math.min(lazyRogue.perPlayerConf.eviscerateSample, newCt)

      lazyRogue.et.SetEviscTrackingInfo(lazyRogue.eviscComboPoints, observedDamage, observedCt)

      local expectedDamage = lazyRogue.masks.CalculateBaseEviscDamage(lazyRogue.eviscComboPoints)
      local thisRatio = thisDamage / expectedDamage
      local avgRatio = observedDamage / expectedDamage
      lazyRogue.d("Eviscerate ("..lazyRogue.eviscComboPoints.."cp): "..thisDamage.." damage (optimal "..
           expectedDamage..") "..string.format("%.2f", thisRatio).."/"..
           string.format("%.2f", avgRatio).." (cur/avg vs. optimal)")

      lazyRogue.eviscComboPoints = nil
   end

   -- Hook UseAction() so we can record how many combo points the
   -- player had when he eviscerated.
   function lazyRogue.et.UseActionHook(action, checkCursor, onSelf)
      if (action == lazyRogue.actions.evisc:GetSlot()) then
         lazyRogue.eviscComboPoints = GetComboPoints()
         lazyRogue.d("UseActionHook, I see you're eviscerating with "..lazyRogue.eviscComboPoints.." cps")
      end
      return lazyRogue.UseActionOrig(action, checkCursor, onSelf)
   end

   function lazyRogue.et.CastSpellHook(spellIndex, spellBookType)
      local spellIndexStart, rankCount, maxRank = lazyRogue.actions.evisc:FindSpellRanks(false)
      if ((spellIndexStart + rankCount - 1) == spellIndex) then
         lazyRogue.eviscComboPoints = GetComboPoints()
         lazyRogue.d("CastSpellHook, I see you're eviscerating with "..lazyRogue.eviscComboPoints.." cps")
      end
      return lazyRogue.CastSpellOrig(spellIndex, spellBookType)
   end


end -- function lazyRogueLoad.LoadEviscTracking()

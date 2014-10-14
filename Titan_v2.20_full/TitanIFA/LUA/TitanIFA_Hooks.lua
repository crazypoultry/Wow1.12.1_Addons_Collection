--[[ ----------------- Function Hooks ----------------- ]]--

IFA_oldCastSpell = CastSpell;
function IFA_newCastSpell(spellId, spellbookTabNum)
   IFA_oldCastSpell(spellId, spellbookTabNum)
   IFA_CAST_Tooltip:SetSpell(spellId, spellbookTabNum)
   
   local spellName = IFA_CAST_TooltipTextLeft1:GetText()
       
   if SpellIsTargeting() then 
       VAR_TITAN_IFA_SPELL = spellName
   else
       VAR_TITAN_IFA_ENDCAST = spellName
       VAR_TITAN_IFA_TARGET = UnitName("target")
   end
end
CastSpell = IFA_newCastSpell

IFA_oldCastSpellByName = CastSpellByName;
function IFA_newCastSpellByName(spellName, onSelf)
   IFA_oldCastSpellByName(spellName, onSelf)

   local spellName = spellName
   
   if SpellIsTargeting() then
       VAR_TITAN_IFA_SPELL = spellName
   else
       VAR_TITAN_IFA_ENDCAST = spellName
       if onSelf then
           VAR_TITAN_IFA_TARGET = UnitName("player")
       else
           VAR_TITAN_IFA_TARGET = UnitName("target")
       end
   end
end
CastSpellByName = IFA_CastSpellByName

IFA_oldUseAction = UseAction
function IFA_newUseAction(a1, a2, a3)
   IFA_oldUseAction(a1, a2, a3)
   if GetActionText(a1) then return end
   
   IFA_CAST_Tooltip:SetAction(a1)
   local spellName = IFA_CAST_TooltipTextLeft1:GetText()
   
   if SpellIsTargeting() then
       VAR_TITAN_IFA_SPELL = spellName
   else
       VAR_TITAN_IFA_ENDCAST = spellName
       VAR_TITAN_IFA_TARGET = UnitName("target")
   end
end
UseAction = IFA_newUseAction

IFA_oldSpellTargetUnit = SpellTargetUnit
function IFA_newSpellTargetUnit(unit)

   IFA_oldSpellTargetUnit(unit)

   if VAR_TITAN_IFA_SPELL then
       VAR_TITAN_IFA_ENDCAST = VAR_TITAN_IFA_SPELL
       VAR_TITAN_IFA_TARGET = UnitName(unit)
       VAR_TITAN_IFA_SPELL = nil
   end
end
SpellTargetUnit = IFA_newSpellTargetUnit

IFA_oldTargetUnit = TargetUnit
function IFA_newTargetUnit(unit)
   IFA_oldTargetUnit(unit)
   if VAR_TITAN_IFA_SPELL then
       VAR_TITAN_IFA_ENDCAST = VAR_TITAN_IFA_SPELL
       VAR_TITAN_IFA_TARGET = UnitName(unit)
       VAR_TITAN_IFA_SPELL = nil
   end
end
TargetUnit = IFA_newTargetUnit

IFA_SpellStopTargeting = SpellStopTargeting
function IFA_newSpellStopTargeting()
   IFA_SpellStopTargeting()
   
   if VAR_TITAN_IFA_SPELL then
       VAR_TITAN_IFA_SPELL = nil
       VAR_TITAN_IFA_ENDCAST = nil
       VAR_TITAN_IFA_TARGET = nil
   end
end
SpellStopTargeting = IFA_newSpellStopTargeting

--[[ --------------- End Function Hooks --------------- ]]--
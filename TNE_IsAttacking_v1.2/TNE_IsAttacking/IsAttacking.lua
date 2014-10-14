
function IsAttacking_OnLoad()
  IsAttackingFrame:RegisterEvent("PLAYER_ENTER_COMBAT");
  IsAttackingFrame:RegisterEvent("PLAYER_LEAVE_COMBAT");
  IsAttackingFrame:RegisterEvent("START_AUTOREPEAT_SPELL");
  IsAttackingFrame:RegisterEvent("STOP_AUTOREPEAT_SPELL");
  IsAttackingFrame:RegisterEvent("PLAYER_REGEN_DISABLED");
  IsAttackingFrame:RegisterEvent("PLAYER_REGEN_ENABLED");
  IsAttackingFrame.isAttacking = nil;
  IsAttackingFrame.isAutorepeating = nil;
  IsAttackingFrame.inCombat = nil;
end

function IsAttacking_OnEvent()
  if (event == "PLAYER_ENTER_COMBAT") then
    IsAttackingFrame.isAttacking = true;
  elseif (event == "PLAYER_LEAVE_COMBAT") then
    IsAttackingFrame.isAttacking = nil;
  elseif (event == "START_AUTOREPEAT_SPELL") then
    IsAttackingFrame.isAutorepeating = true;
  elseif (event == "STOP_AUTOREPEAT_SPELL") then
    IsAttackingFrame.isAutorepeating = nil;
  elseif (event == "PLAYER_REGEN_DISABLED") then
    IsAttackingFrame.inCombat = true;
  elseif (event == "PLAYER_REGEN_ENABLED") then
    IsAttackingFrame.inCombat = nil;
  end
end

-- report functions

function IsAttacking()
  return IsAttackingFrame.isAttacking;
end

function IsAutoShooting()
  return IsAttackingFrame.isAutorepeating;
end

function IsWanding()
  return IsAttackingFrame.isAutorepeating;
end

function InCombat()
  return IsAttackingFrame.inCombat;
end


-- active functions

function AttackOn()
  if (not IsAttacking()) then
    AttackTarget();
  end
end

function AttackOff()
  if (IsAttacking()) then
    AttackTarget();
  end
end

function AutoShotOn()
  if (not IsAutoShooting()) then
    CastSpellByName("Auto Shot");
  end
end

function AutoShotOff()
  if (IsAutoShooting()) then
    SpellStopCasting();
  end
end

function WandOn()
  if (not IsAutoShooting()) then
    CastSpellByName("Shoot Wand")
  end
end

function WandOff()
  if (IsAutoShooting()) then
    SpellStopCasting();
  end
end
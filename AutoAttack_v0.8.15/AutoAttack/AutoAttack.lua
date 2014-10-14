--[[ AutoAttack -- Automated hotkey to select the best next attack.
    Written by Vincent of Blackhand, (copyright (c) 2005-2006 by D.A.Down)
    Version history:
    0.8.15 - Added paladin Holy Shock for ranged attack.
    0.8.14 - Druid Ferocious Bite now considers added energy damage.
    0.8.13 - Added 'breathe water' actions for druid, shaman and warlock.
    0.8.12 - Added druid Barkskin when healing in melee.
    0.8.11 - Added flag for 'indoor' state (inhibits outdoor actions).
    0.8.10 - Shapeshift error will cancel shapeshift.
    0.8.9 - Fixed a 'compare to nil' error.
    0.8.8 - WoW 1.12 client update.
    0.8.7 - fixed logic for dead warlock pet.
    0.8.6 - added warrior Revenge.
    0.8.5 - added rogue 'instant' alternatives.
    0.8.4 - added rogue Gouge on low health or casting.
    0.8.3 - fixed Aspect of the Wild won't be replaced.
    0.8.2 - added chat command help system (CmdHelp).
    0.8.1 - added Target Previous Target key binding.
    0.8.0 - replaced 'despell' key binding with 'instant'.
    0.7.25 - fixed to not feed hunter's pet when it is debuffed.
    0.7.24 - changed hunter to use Aspect of the Monkey in melee.
    0.7.23 - added priest Divine Spirit and Desperate Prayer.
    0.7.22 - added priest Feedback, Mana Burn and Vampiric Embrace.
    0.7.21 - fixed Bear form switching.
    0.7.20 - added Druid Entangling Roots and Nature's Grasp
    0.7.19 - added druid bear/cat switch form on low health.
    0.7.18 - added druid cat Bite and revised combo logic.
    0.7.17 - added mage Pyroblast, preempting Fireball to start combat.
    0.7.16 - fixed logic error in eat and drink actions.
    0.7.15 - added mage Mana Shield, Mana Agate/Jade/Citrine, Cone of Cold.
    0.7.14 - fixed priest to work in melee without Shield.
    0.7.13 - fixed '/aa immune' listing.
    0.7.12 - adjusted mage to use Frostbolt if Fireball is disabled.
    0.7.11 - fixed '/aause' argument processing.
    0.7.10 - added Shoot (wand) for Mage, Priest and Warlock.
    0.7.9 - added priest Psychic Scream and Mind Flay.
    0.7.8 - added warrior Disarm, Sunder Armor, Intimidating Shout.
    0.7.7 - added druid Faerie Fire in melee.
    0.7.6 - fixed null target when detecting spellcasting.
    0.7.5 - added '/aa immune' to display immunity table.
    0.7.4 - spellcasts from a non-target name will now be ignored.
    0.7.3 - fixed action immunity tracking.
    0.7.2 - fixed doubled feed pet error.
    0.7.1 - added start sound to hunter's Aimed Shot.
    0.7.0 - added '/aause' for disabling selected actions.
    0.6.9 - added Revive/Feed/Mend actions for hunter's pets.
    0.6.8 - improved melee Attack and fixed missing action error.
    0.6.7 - improved warlock action selection logic.
    0.6.6 - fixed '/aa slot'
    0.6.5 - added conjured food and water for mages.
    0.6.4 - added Bloodrage and Shoot to warrior actions.
    0.6.4 - improved druid bear form actions, including Erage.
    0.6.3 - fixed mage to use fireball when missles isn't available.
    0.6.2 - fixed self-buf bug with an out of range target.
    0.6.1 - improved hunter logic and added monkey aspect.
    0.6 - added form and mount switching
    0.5 - added Hunter and Warlock actions
    0.4 - added Mage and Shaman actions
    0.3 - added Druid and Priest actions
    0.2 - added Warrior and Paladin actions
    0.1.3 - added BackStab
    0.1.2 - converted to generized tables and restructured code.
    0.1.1 - added dynamic Eviscerate damage table and key binding.
    0.1 - basic Rogue actions derived from LazyRogue.

 Usage: Define an attack action key binding.  Use the key for auto-action.

 What it does:
 - checks bufs if not attacking.
 - starts an attack if target and not attacking.
 - check if heal or rebuf is needed.
 - uses an available special attack if it is appropriate.
 - does nothing if nothing is suitable.

 Thanks to Steve Kehlet's LazyRogue for the basic ideas.
]]

-- Global saved variables (per character)
AutoAttack_Options = {}
AutoAttack_Mount = nil
AutoAttack_Form = nil

local Slot, inCombat, Actions, Casting, Class, Plevel, DeadPet, Outside, Breath
local IAtime, LAtime, Ttime, Immune, EstDmg = 0, 0, 0, {}, {[0]=0}
local FCr = "|cffff4040" -- Red
local FCy = "|cffffff10" -- Yellow
local FCg = "|cff50c050" -- Green

local function t(gt) return floor((gt-floor(gt/100)*100)*10) end
local function print(msg) SELECTED_CHAT_FRAME:AddMessage("AA: "..msg, 1,.5,0) end
local function debug(msg) if AAdebug then print(msg) end end
local function melee() return CheckInteractDistance('target',2) end
local function ranged() return not melee() end
local function elite() return UnitClassification('target')~='normal' or UnitIsPlayer('target') end

-- Capitalize the first letter of words
local ignore = {of=1,on=1,the=1}
local function Caps(str)
	local list,word = ''
	for w in gfind(str,'%w+') do
	  word = ignore[w] and w or strupper(strsub(w,1,1))..strsub(w,2)
	  list = list..' '..word
	end
	return strsub(list,2)
end

-- Iterative function for a sorted table
local function sorted(tb,comp)
	local ix = {}
	for key in tb do
	  tinsert(ix,key)
	end
	sort(ix,comp)
	local iter = function (state,key)
	  state.ky,key = next(state.ix,state.ky)
	  return key,state.tb[key]
	end
	return iter,{ix=ix,tb=tb}
end

-- Perform an action if its valid.
local function action(name,self)
    local slot = Slot[name]
    if not slot then return end
	if Slot.Shoot and IsAutoRepeatAction(Slot.Shoot) then
				UseAction(Slot.Shoot) return end -- stop wand action
    if IsUsableAction(slot)==1 and GetActionCooldown(slot)==0 -- not in cooldown
            and (self or IsActionInRange(slot)~=0) then
      if IsCurrentAction(slot) then debug('Wait on '..name) return end
      local target = UnitName('target')
      if Immune[target] and Immune[target][name] then return end
      UseAction(slot,0,self)
      debug('Used '..name)
      return 1
    end
end

-- UnitBuff('player',1)
local function GotBuff(name,target)
    local tex,cnt
    if name=='Main' then
      tex,cnt = GetWeaponEnchantInfo()
      return tex and cnt>9000
    end
    local unit = target==1 and 'target' or target==2 and 'pet' or 'player'
    for ix = 1,16 do
      tex,cnt = UnitBuff(unit,ix)
      if not tex then return end
      if strfind(tex,name) then return cnt end
    end
end

-- UnitDebuff('target',1)
local function GotDebuff(name,target)
    if not target then target = 'target' end
    local tex,cnt
    for ix = 1,16 do
      tex,cnt = UnitDebuff(target,ix)
      if not tex then return; end
      if strfind(tex,name) then return cnt end
    end
end

-- Start using wand if available
local function Wand()
	if not Slot.Shoot or IsAutoRepeatAction(Slot.Shoot) then return end
	return action('Shoot')
end

-- Ability_Mount_RidingHorse (... Bridle), _MountainRam (... Ram),
-- Spell_Nature_Swiftness (Summon Felsteed) (Summon Warhorse)
-- Ability_Druid_TravelForm, _CatForm, _AquaticForm, Ability_Racial_BearForm,
-- Spell_Nature_SpiritWolf (Ghost Wolf)

local function CheckBuff()
    local tex,cnt,button,icon
    for ix = 0,16 do
      button = getglobal("BuffButton"..ix)
      if not button:IsVisible() then return end
	  if GetPlayerBuffTimeLeft(ix)==0 then
		tex = getglobal("BuffButton"..ix.."Icon"):GetTexture()
		if(strfind(tex,'Ability_Mount',1,1)) then return ix,'mount' end
		if(strfind(tex,'Ability_%u%l+_%u%l+Form')) then return ix,'form' end
		if(strfind(tex,'Spell_Nature_SpiritWolf',1,1)) then return ix,'form' end
		if(strfind(tex,'Spell_Nature_Swiftness',1,1)) then
		  if Class=='WARLOCK' or Class=='PALADIN' then return ix,'summon' end
		end
	  end
    end
end

-- Init checks by class
function AutoAttack_Class_Actions.DRUID.Init()
    if not Slot.Bite then return end
	AutoAttack_TT:SetOwner(AutoAttack_Frame)
    AutoAttack_TT:SetAction(Slot.Bite)
    if AutoAttack_TT:NumLines()<5 then return end
    local tip = AutoAttack_TTTextLeft5:GetText()
    local nextfind,lv,hv = string.gfind(tip," (%d+)%-(%d+) damage")
    for ix = 1,5 do
      lv,hv = nextfind()
      if lv then
        EstDmg[ix] = (tonumber(lv)+tonumber(hv))/2
        debug(ix..' = '..EstDmg[ix])
      end
    end
    local _,_,dmg = strfind(tip,'into %A additional')
    EstDmg.f = tonumber(dmg)
end

function AutoAttack_Class_Actions.MAGE.Init()
    if not Slot.Blast then return end
	AutoAttack_TT:SetOwner(AutoAttack_Frame)
    AutoAttack_TT:SetAction(Slot.Blast)
    if AutoAttack_TT:NumLines()<5 then return end
    local _,lv,hv = strfind(AutoAttack_TTTextLeft5:GetText()," (%d+)%-(%d+) fire")
    EstDmg.f = (tonumber(lv)+tonumber(hv))/2
end

function AutoAttack_Class_Actions.ROGUE.Init()
    if not Slot.Evis then return end
	AutoAttack_TT:SetOwner(AutoAttack_Frame)
    AutoAttack_TT:SetAction(Slot.Evis)
    if AutoAttack_TT:NumLines()<5 then return end
    local nextfind,lv = gfind(AutoAttack_TTTextLeft5:GetText()," (%d+)%-(%d+) damage")
    for ix = 1,5 do
      lv = nextfind()
      if lv then
        EstDmg[ix] = tonumber(lv)
        debug(ix..' = '..lv)
      end
    end
end

function AutoAttack_Class_Actions.WARRIOR.Init()
    if not Slot.Exec then return end
	AutoAttack_TT:SetOwner(AutoAttack_Frame)
    AutoAttack_TT:SetAction(Slot.Exec)
    if AutoAttack_TT:NumLines()<6 then return end
    local text = AutoAttack_TTTextLeft6:GetText()
    local s,e,n1,n2 = strfind(text,"causing (%d+) damage .+ into (%d+) ")
    if s then EstDmg[1],EstDmg[2] = tonumber(n1),tonumber(n2) end
end

-- Class actions start here
function AutoAttack_Class_Actions.DRUID.Auto(instant)
    if Breath and Slot.Breath and Breath-GetTime()<10 then
    	if CheckBuff() then AutoAttack_Switch()
    	else UseAction(Slot.Breath) end
    	return
	end
    if GotBuff('BearForm') then
      if not inCombat and ranged() and action('Enrage') then return end
      if not GotDebuff('Roar') and action('Roar') then return end
      local health = UnitHealth('player')/UnitHealthMax('player')
      if health<0.15 then
        if action('Regen') then return end
        AutoAttack_Switch('form')
        return
      end
      if action('Maul') then return end
    elseif GotBuff('CatForm') then
      if not inCombat then
        if not melee() and not GotBuff('Ambush') and action('Prowl') then return end
        if GotBuff('Ambush') and action('Ravage') or action('Shred')  then return end
      end
      local cp,tHP = GetComboPoints()
      if EstDmg[5] and MobHealth_GetTargetCurHP then
      	tHP = MobHealth_GetTargetCurHP()
      	if tHP then
      	  if EstDmg.f then tHP = tHP-(UnitMana('player')-35)*EstDmg.f end
      	  tHP = tHP<=EstDmg[cp]
      	end
      end
      if cp>=5 or tHP then
    	if UnitCreatureType('target')=='Humanoid' and UnitHealth('target')<50 and
        		not tHP and not GotDebuff('Frenzy') and action('Rip') then return end
        if action('Bite') then return end
      end
      local health = UnitHealth('player')/UnitHealthMax('player')
      if health<0.20 then AutoAttack_Switch('form') return end
      if not GotDebuff('Disemowel') and action('Rake') then return end
      if not GotBuff('Tiger') and action('Fury') then return end
      action('Claw')
    else
      if not inCombat then
        if not instant and Slot.Roots and UnitPowerType('target')~=0 and
        		Outside and not GotDebuff('Vines') and action('Roots') then return end
        if action('Starfire') or action('Wrath') then return end
      end
      if not GotDebuff('StarFall') and action('Moonfire') then return end
      local health = UnitHealth('player')/UnitHealthMax('player')
      if health<0.9 and not GotBuff('Rejuv') and action('Rejuv',1) then return end
      if melee() then
        if not GotDebuff('Faerie') and action('Faerie') then return end
        local target = UnitName('target')
        if not instant and Slot.Grasp and not (Immune[target] and Immune[target].Roots) and
        		Outside and not GotDebuff('Vines') and action('Grasp') then return end
      elseif instant and action('Moonfire') then return
      end
      if health<0.6 then
        if inCombat and not GotBuff('ResistNature') and action('Regrowth',1) then return end
        if melee() and not GotDebuff('StoneClaw') and action('Barkskin') then return end
        if action('Heal',1) then return end
      end
      if AutoAttack_Rebuff(instant) or not instant and
      		(action('Starfire') or action('Wrath')) then return end
    end
end

function AutoAttack_Class_Actions.HUNTER.Auto(instant)
    if not HasPetUI() and Slot.Call then
      if DeadPet and not inCombat and action('Revive') then return end
      if DeadPet==nil and action('Call') then return end
    end
    if ranged() and not GotBuff('formNature') and
    			not GotBuff('RavenForm') and action('Hawk') then return end
    if UnitExists('target') and ranged() and UnitHealth('target')>0.2 and
    			not GotDebuff('SniperShot') and action('Mark') then return end
    if HasPetUI() then
      if not UnitIsDead('pet') then
		DeadPet = nil
		if GotBuff('Training',2) then print("Pet is feeding...") return end
		local health = UnitHealth('pet')/UnitHealthMax('pet')
		if health<0.3 and action('Mend') then return end
		if not UnitExists('PetTarget') then PetAttack() return end
      elseif not inCombat and action('Revive') then return end
    end
    if not inCombat then
      if not GotBuff('formNature') and not GotBuff('RavenForm') and action('Hawk') then return end
      if not HasPetUI() and action('Concussive') then return end
      if action('Aimed') then PlaySound("igCharacterInfoTab") return end
    elseif not UnitExists('target') then
      if UnitExists('PetTarget') then TargetUnit('PetTarget') end
    end
    AutoAttack_Rebuff()
    if ranged() then
      if Slot.Viper and UnitPowerType('target')==0 and UnitMana('target')>10 then
        if not GotDebuff('AimedShot') and action('Viper') then return end
      elseif not GotDebuff('Quickshot') and action('Serpent') then return end
      if UnitHealth('target')>0.3 and action('Aimed') then
      			PlaySound("igCharacterInfoTab") return end
      if action('Arcane') then return end
      if not IsAutoRepeatAction(Slot.Auto) then action('Auto') return end
    else
      if not GotBuff('formNature') and not GotBuff('Monkey') and action('Monkey') then return end
      if action('Raptor') then return end
      if action('Intim') then return end
    end
    local health = UnitHealth('player')/UnitHealthMax('player')
    if health<0.1 then action('Feign') end
end

function AutoAttack_Class_Actions.MAGE.Auto(instant)
    AutoAttack_Rebuff(instant)
    if MobHealth_GetTargetCurHP and EstDmg.f then
      if EstDmg.f>=MobHealth_GetTargetCurHP() and action('Blast') then return end
    end
    if not inCombat then
      if (not Slot.Frostbolt or UnitPowerType('target')==0) and
      			(action('Pyroblast') or action('Fireball')) then return end
      if action('Frostbolt') then return end
    end
    local mana = UnitMana('player')/UnitManaMax('player')
    if instant and melee() then
      local health = UnitHealth('player')/UnitHealthMax('player')
      if action('Blast') or health<0.5 and action('Cone') then return end
      local health = UnitHealth('player')/UnitHealthMax('player')
      if (mana>0.5 or health<0.2) and not GotBuff('DetectLesser') and
      			action('Shield') then return end
    elseif action('Missiles') or action('Fireball') or action('Frostbolt') then return
    end
    if mana<0.15 and action('Gem') then return end
	if mana<0.2 and Wand() then return end
end

function AutoAttack_Class_Actions.PALADIN.Auto(instant)
    local health = UnitHealth('player')/UnitHealthMax('player')
    if health<0.2 and (action('Divine',1) or action('Prot',1)) then return end
    if health<0.1 and action('Hands',1) then return end
    AutoAttack_Rebuff()
    local tType = UnitCreatureType('target')
    if (tType=='Demon' or tType=='Undead') and action('Exorcism') then return end
    if (instant or ranged()) and action('Shock') then return end
    if not GotBuff('HealingAura') and not GotBuff('SealOfWrath') and (action('Light') or
    		not GotBuff('ThunderBolt') and action('Right')) then return end
    if not GotDebuff('HealingAura') and GotBuff('HealingAura') and action('Judge') then return end
    if health<0.5 and action('Heal',1) then return end
    health = UnitHealth('target')/UnitHealthMax('target')
    if tType=='Humanoid' and UnitHealth('target')<55 and not GotDebuff('SealOfWrath') then
      if GotBuff('SealOfWrath') and action('Judge') then return end
      if UnitHealth('target')<45 and action('Justice') then return end
    end
    local mana = UnitMana('player')/UnitManaMax('player')
    if not instant and melee() and mana>0.5 and action('Cons') then return end
    if mana>0.2 and GotBuff('ThunderBolt') and action('Judge') then return end
    if not inCombat then AttackTarget() return end
end

function AutoAttack_Class_Actions.PRIEST.Auto(instant)
    local health = UnitHealth('player')/UnitHealthMax('player')
    if health<0.85 and not GotBuff('Renew') and action('Renew',1) then return end
    if health<0.55 and (not Slot.Shield or GotBuff('WordShield')) and
    			(action('Focus') or action('Heal',1)) then return end
    if not inCombat then
      if not instant and UnitPowerType('target')==0 and action('Burn') then return end
      if action('HFire') or action('Blast') or action('Smite') then return end
    end
    if not GotDebuff('WordPain') and action('Pain') then return end
    if not GotDebuff('ToAshes','player') and not GotBuff('WordShield') and
    			(action('Focus') or action('Shield',1)) then return end
    if health<0.15 and action('Prayer') then return end
    if (melee() and (health<0.6 and not GotBuff('WordShield')) or
    			Slot.Flay and UnitIsPlayer()) and not GotDebuff('Scream') and
    			action('Scream') then return end
    if GotDebuff('Scream') and action('Flay') then return end
    if AutoAttack_Rebuff(instant) then return end
    if UnitPowerType('target')==0 and not GotBuff('WordShield') and
    			action('Feedback') then return end
    if health<0.85 and not GotDebuff('Unsummon') and action('Vampiric') then return end
    if ranged() or not Slot.Shield or GotBuff('WordShield') then
      local thealth = UnitHealth('target')
      if (thealth<0.15 or instant) and Wand() then return end
      if thealth>0.3 and not GotDebuff('SearingLight') and action('HFire') then return end
      if action('Blast') or action('Smite') then return end
    end
    if not GotBuff('DeadofNight') and not GotDebuff('DeadofNight') and
    			action('Weakness') then return end
    local mana = UnitMana('player')/UnitManaMax('player')
	if mana<0.2 and Wand() then return end
end

function AutoAttack_Class_Actions.ROGUE.Auto(instant)
    if ranged() and action('Shoot') then return end
    if not inCombat then
      if not melee() and not GotBuff('Ambush') and action('Stealth') then return end
      if instant and (action('Rip') or action('Strike')) then return end
      if action('Garrote') then return end
      if action('Stab') then return end
      if action('Stun') then return end
    end
    local cp,tHP = GetComboPoints()
    if EstDmg[5] then tHP = MobHealth_GetTargetCurHP and MobHealth_GetTargetCurHP() end
    if(cp>=5 or tHP and tHP<=EstDmg[cp]) then
      if(action('Evis')) then return end
    end
    local health = UnitHealth('player')/UnitHealthMax('player')
    if (health<0.3 or Casting) and action('Gouge') then return end
    if health<0.5 and action('Evasion') then return end
    if instant and action('Stab') then return end
    if action('Rip') then return end
    if action('Ghost') then return end
    action('Strike')
end

function AutoAttack_Class_Actions.SHAMAN.Auto(instant)
    if Breath and Breath-GetTime()<10 and action('Breath') then return end
    local health = UnitHealth('player')/UnitHealthMax('player')
    if health<0.5 and action('Heal',1) then return end
    if inCombat then
      if UnitHealth('target')>0.5 and not GotDebuff('FlameShock') and
    		action('Flame') or action('Frost') or action('Earth') then return end
      local lvl = UnitLevel('target') + (elite() and 9 or 3)
      if lvl>Plevel and UnitHealth('target')>0.7 and GetTime()>Ttime+40 then
    	if action('Searing') then Ttime = GetTime() return end
      end
    end
    if melee() and not GotBuff('StoneSkin') and action('Stone') then return end
    if AutoAttack_Rebuff(instant) then return end
    if (not instant or ranged()) and action('Bolt') then return end
end

function AutoAttack_Class_Actions.WARLOCK.Auto(instant)
    if Breath and Breath-GetTime()<10 and action('Breath') then return end
    AutoAttack_Rebuff()
    if HasPetUI() and not UnitIsDead('pet') and
    		not UnitExists('PetTarget') then PetAttack() return end
    if not inCombat then
      if action('Immolate') then return end
    elseif not UnitExists('target') then
      if UnitExists('PetTarget') then TargetUnit('PetTarget') end
    end
    local health = UnitHealth('player')/UnitHealthMax('player')
    if melee() then
      if health<0.7 and action('Coil') then return end
      if not GotDebuff('Sargeras') and not GotDebuff('Mannoroth') and
      			action('Weakness') then return end
      if health<0.4 and action('fear') then return end
    elseif UnitHealth('target')>0.3 and not GotDebuff('Sargeras') and
    			action('Agony') then return
    end
    if not GotDebuff('Abomination') and action('Corruption') then return end
    if not GotDebuff('Requiem') and action('Siphon') then return end
    local mana = UnitMana('player')/UnitManaMax('player')
    if mana<0.8 and health>0.95 and action('Tap') then return end
    if UnitHealth('target')>0.25 and not GotDebuff('Immolation') and
    		action('Immolate') then return end
    if health<0.7 and not GotDebuff('LifeDrain') and action('DrainLife') then return end
    if UnitPowerType('target')==0 and UnitMana('target')>15 and
		not GotDebuff('SiphonMana') and action('DrainMana') then return end
	if (mana<0.2 or not Slot.Bolt) and Wand() then return end
    if not instant and action('Bolt') then return end
end

function AutoAttack_Class_Actions.WARRIOR.Auto(instant)
    if action('Charge') then return end
    if EstDmg[2] then
      local tHP = MobHealth_GetTargetCurHP and MobHealth_GetTargetCurHP()
      if tHP and tHP<=EstDmg[1]+EstDmg[2]*UnitMana('player') and action('Exec') then return end
    end
    if UnitCreatureType('target')=='Humanoid' and UnitHealth('target')<50 and
            not GotDebuff('ShockWave') and action('Slow') then return end
    if action('Overpower') or action('Revenge') then return end
    if not GotDebuff('Ability_Gouge') and action('Rend') then return end
    if not GotDebuff('Sunder') and action('Sunder') then return end
    if action('Disarm') then return end
    if action('Strike') then return end
    if ranged() and action('Shoot') then return end
    if not inCombat and action('Rage') then return end
    local health = UnitHealth('player')/UnitHealthMax('player')
    if health<0.2 and action('IShout') then return end
    AutoAttack_Rebuff(instant)
end

-- Do class selection on initial load.
function AutoAttack_OnLoad()
    local LocClass
    LocClass, Class = UnitClass("player")
    Actions = AutoAttack_Class_Actions[Class]
    if not Actions then print(FCr.."Unknown class: "..Class) return end
    this:RegisterEvent("PLAYER_ENTERING_WORLD")
    Actions.Icons.Attack = 'Attack'
    Outside = true
    -- add our chat commands
    SlashCmdList["AUTOATTACK"] = AutoAttack_Cmd
    SLASH_AUTOATTACK1 = "/autoattack"
    SLASH_AUTOATTACK2 = "/aa"
    SlashCmdList["AAUSE"] = AutoAttack_Use
    SLASH_AAUSE1 = "/aause"
    SlashCmdList["AAFEED"] = AutoAttack_Feed
    SLASH_AAFEED1 = "/aafeed"
    -- CmdHelp loaded check
    if not CmdHelp then CmdHelp = function () end
    else CmdHelp(AA_Help,'aa') end
end

-- See if any buffs are needed
function AutoAttack_Rebuff(instant)
    local bufs = Actions.Buf
    if bufs then
	  for i = 1,getn(bufs),3 do
		if not GotBuff(bufs[i+1]) and action(bufs[i],1) then return 1 end
	  end
    end
    local button,name,group
    for ix = 16,23 do
      button = getglobal("BuffButton"..ix)
      if not button or not button:IsVisible() then break end
	  AutoAttack_TT:SetOwner(AutoAttack_Frame)
	  AutoAttack_TT:SetPlayerBuff(button.buffIndex)
	  name = AutoAttack_TTTextLeft1:GetText()
	  group = AutoAttack_TTTextRight1:GetText()
	  if name then debug("Found debuff: "..name) end
	  if group and action(group,1) then return 1 end
    end
    if inCombat then return end
    if Breath and Breath-GetTime()<5 and action('Breath') then return end
    if Slot.Call and HasPetUI() and not UnitIsDead('pet') then
	  local health = UnitHealth('pet')/UnitHealthMax('pet')
      if AutoAttack_Options.Feed and GetPetHappiness()<3 and not GotBuff('Training',2) then
		if UnitDebuff('pet',1) then
	      if health<0.8 and action('Mend') then
		  else print("Don't feed pet while debuffed.") end
		  return 1
		end
		local loc = AutoAttack_Options.Feed
		local link = GetContainerItemLink(loc[1],loc[2])
		if link then
		  PickupContainerItem(loc[1],loc[2])
		  DropItemOnUnit('pet')
		  print('Feeding pet with '..link)
		  return 1
		else print(format('Bag %d, Slot %d is empty for pet food.',loc[1],loc[2])) end
      end
	  if health<0.5 and action('Mend') then return 1 end
    end
    local drinking = GotBuff('Drink')
    if not drinking then
	  if Slot.Citrine and IsUsableAction(Slot.Citrine)~=1 and action('CMC') then return end
	  if Slot.Drink then
		if GetActionCount(Slot.Drink)<5 and action('Water') then return 1 end
		if Slot.Food and GetActionCount(Slot.Food)<5 and action('Bread') then return 1 end
		if UnitMana('player')/UnitManaMax('player')<0.6 and action('Drink') then return 1 end
	  end
    end
    if Slot.Food then
      local health = UnitHealth('player')/UnitHealthMax('player')
	  if (health<0.6 or drinking and health<0.75) and
			not GotBuff('Fork') and action('Food') then return 1 end
    end
end

local function CheckTargetBufs()
	if not CheckInteractDistance('target',4) or
		   UnitReaction('target','player')<5 then return end
	print("Checking "..UnitName('target'))
	  if Actions.Hot and UnitHealth('target')<0.9 and
	  		not GotBuff(Actions.Hot[2],1) and action(Actions.Hot[1]) then return end
    if UnitHealth('target')<0.7 and action('Heal') then return end
    local bufs = Actions.Buf
    if bufs then
	  for i = 1,getn(bufs),3 do
		if bufs[i+2] and not GotBuff(bufs[i+1],1) and action(bufs[i]) then return 1 end
	  end
    end
    local button,name,group
    for ix = 1,16 do
      button = getglobal("TargetFrameDebuff"..ix)
      if not button or not button:IsVisible() then return end
	  AutoAttack_TT:SetOwner(AutoAttack_Frame)
	  AutoAttack_TT:SetUnitDebuff("target",ix)
	  name = AutoAttack_TTTextLeft1:GetText()
	  group = AutoAttack_TTTextRight1:GetText()
	  if name then debug("Found debuff: "..name) end
	  if group and action(group,1) then return 1 end
    end
end

-- Decide what action to perform
function AutoAttack_Action(instant)
    if not Actions then return end
    inCombat = UnitAffectingCombat('player')
    if not inCombat then
      Casting = false
	  local health = UnitHealth('player')/UnitHealthMax('player')
	  if Actions.HoT and health<0.9 and
	  		not GotBuff(Actions.HoT[2]) and action(Actions.HoT[1],1) then return end
	  if health<0.7 and action('Heal',1) then return end
      local na = not UnitCanAttack('player','target')
      if na and Actions.Prep and GetTime()-LAtime>1.5 and
      	 not GotBuff(Actions.Prep.Buf) and action(Actions.Prep.Act) then return end
      if AutoAttack_Rebuff() or UnitIsDead('target') then return end
      if na then CheckTargetBufs() return end
    else
      LAtime = GetTime()
	  if Casting and Actions.DS and action(Actions.DS) then return end
	  if melee() and Slot.Attack and not IsCurrentAction(Slot.Attack) then
	    AttackTarget()
	    debug("Attack target.")
	  end
    end
    Actions.Auto(instant)
end

-- Scan the action bars for defined actions
local function ScanActions(Icons)
    Plevel = UnitLevel('player')
    Slot = {}
    local s,e,text,act
    local mage = Class=='MAGE'
    for slot=1,120 do
      if HasAction(slot) and not GetActionText(slot) then -- ignore macros
        AutoAttack_TT:SetOwner(AutoAttack_Frame)
        AutoAttack_TT:SetAction(slot)
        text = AutoAttack_TTTextLeft1:GetText()
        if text then
          act = IsAttackAction(slot) and 'Attack' or Icons[text]
          if act and not AutoAttack_Options[text] then
            Slot[act] = slot
            debug(act..' = '..slot)
          elseif mage and strsub(text,1,8)=="Conjured" then
            act = strsub(text,-5,-1)=="Water" and 'Drink' or 'Food'
            Slot[act] = slot
          end
        end
      end
    end
    if Slot.Magic then Slot.Poison = Slot.Magic; Slot.Disease = Slot.Magic end
    if Actions.Init then Actions.Init() end
    AutoAttack_TT:Hide()
end

local IMMUNE = 'Your (.+) failed%. (.+) is immune'
local function SpellFailMsg(msg)
    local _,_,spell,name = strfind(msg,IMMUNE)
    if not spell then return end
    debug('Immune: '..spell..' on '..name)
    local act = Actions.Icons[spell]
    if not act then print(FCr..spell..' lookup failed!') return end
    if not Immune[name] then Immune[name] = {} end
    Immune[name][act] = spell
end

local BEGIN = '(.+) begins to cast (.+)%.'
local function SpellBeginMsg(msg)
    local s,e,name,spell = strfind(msg,BEGIN)
    if not spell then return; end
    debug(name..' is casting '..spell)
    local target = UnitName('target')
    if name==target then Casting = spell
    elseif target then debug('Target is '..target) end
end

local function HitMsg(msg)
    debug(t(GetTime())..'; '..msg)
end

function AutoAttack_OnEvent(event)
    if event == "PLAYER_ENTERING_WORLD" then
      this:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF")
      this:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE")
      this:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_SELF_BUFF")
      this:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE")
      this:RegisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE")
	  this:RegisterEvent("MIRROR_TIMER_START")
	  this:RegisterEvent("MIRROR_TIMER_STOP")
      this:RegisterEvent("UI_ERROR_MESSAGE")
      ScanActions(Actions.Icons)
    elseif event == "CHAT_MSG_SPELL_SELF_DAMAGE" then SpellFailMsg(arg1)
    elseif event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF" then SpellBeginMsg(arg1)
    elseif event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE" then SpellBeginMsg(arg1)
    elseif event == "CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE" then Casting = false
    elseif event == "MIRROR_TIMER_START" and arg1=="BREATH" then Breath = GetTime()+arg2/1000
    elseif event == "MIRROR_TIMER_STOP" then Breath = nil
    elseif event == "UI_ERROR_MESSAGE" then
      if arg1=="You do not have a pet to summon." then DeadPet = false
      elseif arg1=="Your pet is dead." then DeadPet = true
      elseif arg1=="Can only use outside" then Outside = false
      elseif arg1=="Can't use items while shapeshifted." or
      		 arg1=="You are in shapeshift form" then AutoAttack_Switch()
      elseif arg1=="Can't use items while shapeshifted." or
      		 arg1=="Can't speak while shapeshifted." or
      		 arg1=="You are mounted" then AutoAttack_Switch('mount')
      end
    end
end

-- handle our chat command
function AutoAttack_Cmd(msg)
    if CmdHelp(AA_Help,'aa',msg) then return end
    if msg=='debug' then
      AAdebug = not AAdebug
      print("Debug is "..(AAdebug and 'on' or 'off'))
    elseif msg=='outside' then
      Outside = not Outside
      print("Outside flag is "..(Outside and 'on' or 'off'))
    elseif msg=='slot' then
      local list
      for name,slot in sorted(Slot) do
        list = (list and list..', ' or '')..name..'='..slot
      end
      print(list or FCr.."No actions are defined")
    elseif msg=='dmg' then Cmd_Eval(EstDmg)
    elseif msg=='scan' then
      print("Rescanning action bars")
      ScanActions(Actions.Icons)
    elseif msg=='immune' then
      print("Recorded immunities:")
      local list
      for name,data in sorted(Immune) do
        for act,spell in data do
          list = list and list..', '..spell or spell
        end
        print(name..' to '..list)
      end
      if not list then print("None.") end
    else print(FCr.."Unknown command: "..msg) end
end

-- handle our Use command
function AutoAttack_Use(msg)
    local Msg = Caps(msg)
    if msg=='' then
      local state
      print("Possible actions for a "..Class)
      for name,act in sorted(Actions.Icons) do
        state = AutoAttack_Options[name] and FCr..'Disabled' or
        		Slot[act] and FCg..'Enabled' or FCy..'Unused'
        print(format("%s (%s) is %s",name,act,state))
      end
    elseif Actions.Icons[Msg] then
      AutoAttack_Options[Msg] = not AutoAttack_Options[Msg]
      print(Msg.." is "..(AutoAttack_Options[Msg] and 'Disabled' or 'Enabled'))
      ScanActions(Actions.Icons)
    elseif CmdHelp(AA_Help,'aause',msg) then return
    else print(FCr.."Unknown action: "..msg) end
end

-- handle our Feed command
function AutoAttack_Feed(msg)
    if msg=='' then
      if Slot.Feed then
        local frame = GetMouseFocus()
        if frame.hasItem and strfind(frame:GetName(),'ContainerFrame%d+Item') then
          local bag,item = frame:GetParent():GetID(), frame:GetID()
          local link = GetContainerItemLink(bag,item)
          local _,_,id = strfind(link,'item:(%d+):')
          local _,_,_,_,it,_,_,_,tex = GetItemInfo(id)
          if it=='Consumable' or strfind(tex,'Food') then
            AutoAttack_Options.Feed = {bag,item}
            print('Your pet will be fed '..link..' when hungry.')
          else print(link..FCr..' is not recognized as consumable.') end
        else print(FCr..'You must be pointing at an inventory item.') end
      else print(FCr.."You don't have a Feed Pet action.") end
    elseif msg=='off' then
      AutoAttack_Options.Feed = nil
      print("Pet feeding is disabled")
    elseif CmdHelp(AA_Help,'aafeed',msg) then return
    else print(FCr.."Unknown command: "..msg) end
end

-- Ability_Mount_RidingHorse (... Bridle), _MountainRam (... Ram),
-- Spell_Nature_Swiftness (Summon Felsteed) (Summon Warhorse)
-- Ability_Druid_TravelForm, _CatForm, _AquaticForm, Ability_Racial_BearForm,
-- Spell_Nature_SpiritWolf (Ghost Wolf)

local function CheckBuff()
    local tex,cnt,button,icon
    for ix = 0,16 do
      button = getglobal("BuffButton"..ix)
      if not button:IsVisible() then return end
	  if GetPlayerBuffTimeLeft(ix)==0 then
		tex = getglobal("BuffButton"..ix.."Icon"):GetTexture()
		if(strfind(tex,'Ability_Mount',1,1)) then return ix,'mount' end
		if(strfind(tex,'Ability_%u%l+_%u%l+Form')) then return ix,'form' end
		if(strfind(tex,'Spell_Nature_SpiritWolf',1,1)) then return ix,'form' end
		if(strfind(tex,'Spell_Nature_Swiftness',1,1)) then
		  if Class=='WARLOCK' or Class=='PALADIN' then return ix,'summon' end
		end
	  end
    end
end

local function FindAction(name)
    AutoAttack_TT:SetOwner(AutoAttack_Frame)
    local len,text = strlen(name)
    for slot=1,120 do
	  if HasAction(slot) then
	    AutoAttack_TT:SetOwner(AutoAttack_Frame)
		AutoAttack_TT:SetAction(slot)
		text = AutoAttack_TTTextLeft1:GetText()
		if text and strfind(text,name) then return slot end
	  end
    end
end

-- Switch forms or mount status
function AutoAttack_Switch(switch)
	local ix,label = CheckBuff()
	if ix then
	  AutoAttack_TT:SetOwner(AutoAttack_Frame)
	  AutoAttack_TT:SetPlayerBuff(ix)
	  local name = AutoAttack_TTTextLeft1:GetText()
	  CancelPlayerBuff(ix)
      debug('Found buf: '..name)
      if strsub(name,-5,-1)=='saber' then label = 'mount'
	  elseif name=='Pinto Horse' then name = 'Pinto' end
	  if label=='form' or strsub(name,1,6)=='Aspect' then AutoAttack_Form = name
	  elseif label=='summon' then AutoAttack_Mount = name
	  else AutoAttack_Mount = FindAction(name) end
	elseif AutoAttack_Mount and (switch=='mount' or not AutoAttack_Form) then
	  if type(AutoAttack_Mount)=="number" then UseAction(AutoAttack_Mount)
	  else CastSpellByName(AutoAttack_Mount) end
	elseif AutoAttack_Form then CastSpellByName(AutoAttack_Form)
	else print(FCr.."No mount/form selected.") end
end

--[[ Notes:
curDur = getglobal("BuffButton"..i.."Duration")

hasMainHandEnchant, mainHandExpiration, mainHandCharges, hasOffHandEnchant,
                    offHandExpiration, offHandCharges = GetWeaponEnchantInfo()

 -- hasOffHandEnchant
textureName = GetInventoryItemTexture("player", 17)
duration = getglobal("TempEnchant1Duration"):GetText()

 -- hasMainHandEnchant
textureName = GetInventoryItemTexture("player", 16)

]]
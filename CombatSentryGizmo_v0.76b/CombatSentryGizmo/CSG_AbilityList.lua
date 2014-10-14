--[[

	Ability List: ---------
		-- A table list of abilities/spells, classes that use them, damage and art.
		-- Originally used by CombatSentryGizmo to give players a visual
		-- icon of what was being cast against them and others around them.

		copyright 2005 by Chester

	V 0.1

]]--

------------------------------------------------------------------

CSG_AbilityList = { 

--COMBAT
--BUFF
--DEBUFF
--------------------------------------------------
--------------------------------------------------

--==DRUID==
--26
	["Abolish Poison"] = {
		cl	= CSG_DRUID, 
		ob	= 1, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 26,		
	},
--
--44
	["Barkskin"] = {
		cl	= CSG_DRUID, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 44,		
	},
--
--14
	["Bash"] = {
		cl	= CSG_DRUID, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 14,
	},

--
--20
	["Cat Form"] = {
		cl	= CSG_DRUID, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,		
	},
  
--
--28
	["Challenging Roar"] = {
		cl	= CSG_DRUID, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,		
	},
--
--20
	["Claw"] = {
		cl	= CSG_DRUID, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 20,
	},

--
--28
	["Cower"] = {
		cl	= CSG_DRUID, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 28,
	},

--
--26
	["Dash"] = {
		cl	= CSG_DRUID, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 26,
	},

--
--10
	["Demoralizing Roar"] = {
		cl	= CSG_DRUID, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--40
	["Dire Bear Form"] = {
		cl	= CSG_DRUID, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,		
	},
  
--
--12
	["Enrage"] = {
		cl	= CSG_DRUID, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,		
	},
--
--8
	["Entangling Roots"] = {
		cl	= CSG_DRUID, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 8,
	},

--
--18
	["Faerie Fire"] = {
		cl	= CSG_DRUID, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 18,
	},

--
--25
	["Faerie Fire (Bear)"] = {
		cl	= CSG_DRUID, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 25,
	},

--
--25
	["Faerie Fire (Cat)"] = {
		cl	= CSG_DRUID, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 25,
	},

--
--40
	["Feline Grace"] = {
		cl	= CSG_DRUID, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 40,		
	},

--
--20
	["Feral Charge"] = {
		cl	= CSG_DRUID, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 20,		
	},

--
--32
	["Ferocious Bite"] = {
		cl	= CSG_DRUID, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 32,
	},

--
--36
	["Frenzied Regeneration"] = {
		cl	= CSG_DRUID, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 36,
	},

--
--8
	["Healing Touch"] = {
		cl	= CSG_DRUID, 
		ob	= 1, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 8,
	},

--
--18
	["Hibernate"] = {
		cl	= CSG_DRUID, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 18,
	},

--
--40
	["Hurricane"] = {
		cl	= CSG_DRUID, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 40,
	},

--
--40
	["Innervate"] = {
		cl	= CSG_DRUID, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,		
	},

--
--1
	["Mark of the Wild"] = {
		cl	= CSG_DRUID, 
		ob	= 1, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--18
	["Maul"] = {
		cl	= CSG_DRUID, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 18,
	},

-------FIX AFTER HERE
--
--4
	["Moonfire"] = {
		cl	= CSG_DRUID, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
		
		[10] = 10,
	},

--
--10
	["Nature's Grasp"] = {
		cl	= CSG_DRUID, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--30
	["Nature's Swiftness"] = {
		cl	= CSG_DRUID, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--20
	["Omen of Clarity"] = {
		cl	= CSG_DRUID, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--36
	["Pounce"] = {
		cl	= CSG_DRUID, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--20
	["Prowl"] = {
		cl	= CSG_DRUID, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--24
	["Rake"] = {
		cl	= CSG_DRUID, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--32
	["Ravage"] = {
		cl	= CSG_DRUID, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--20
	["Rebirth"] = {
		cl	= CSG_DRUID, 
		ob	= 1, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--12
	["Regrowth"] = {
		cl	= CSG_DRUID, 
		ob	= 1, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--4
	["Rejuvenation"] = {
		cl	= CSG_DRUID, 
		ob	= 1, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--24
	["Remove Curse"] = {
		cl	= CSG_DRUID, 
		ob	= 1, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--20
	["Rip"] = {
		cl	= CSG_DRUID, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--22
	["Shred"] = {
		cl	= CSG_DRUID, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--22
	["Soothe Animal"] = {
		cl	= CSG_DRUID, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--20
	["Starfire"] = {
		cl	= CSG_DRUID, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--16
	["Swipe"] = {
		cl	= CSG_DRUID, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--6
	["Thorns"] = {
		cl	= CSG_DRUID, 
		ob	= 1, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--24
	["Tiger's Fury"] = {
		cl	= CSG_DRUID, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--32
	["Track Humanoids"] = {
		cl	= CSG_DRUID, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--30
	["Tranquility"] = {
		cl	= CSG_DRUID, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--30
	["Travel Form"] = {
		cl	= CSG_DRUID, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
  
--
--6
	["Wrath"] = {
		cl	= CSG_DRUID, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--

--==HUNTER==
--20
	["Aimed Shot"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--6
	["Arcane Shot"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--30
	["Aspect of the Beast"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--20
	["Aspect of the Cheetah"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--10
	["Aspect of the Hawk"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--4
	["Aspect of the Monkey"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--40
	["Aspect of the Pack"] = {
		cl	= CSG_HUNTER, 
		ob	= 1, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--46
	["Aspect of the Wild"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--24
	["Beast Lore"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--8
	["Concussive Shot"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--30
	["Counterattack"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--20
	["Deterrence"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--20
	["Disengage"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--34
	["Disengage"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--48
	["Disengage"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--12
	["Distracting Shot"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--20
	["Distracting Shot"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--30
	["Distracting Shot"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--40
	["Distracting Shot"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--50
	["Distracting Shot"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--60
	["Distracting Shot"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--14
	["Eagle Eye"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--34
	["Explosive Trap"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--44
	["Explosive Trap"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--54
	["Explosive Trap"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--14
	["Eyes of the Beast"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--30
	["Feign Death"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--32
	["Flare"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--20
	["Freezing Trap"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--40
	["Freezing Trap"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--60
	["Freezing Trap"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--28
	["Frost Trap"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--20
	["Growl"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--30
	["Growl"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--40
	["Growl"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--50
	["Growl"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--60
	["Growl"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--6
	["Hunter's Mark"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--22
	["Hunter's Mark"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--40
	["Hunter's Mark"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--58
	["Hunter's Mark"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--16
	["Immolation Trap"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--26
	["Immolation Trap"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--36
	["Immolation Trap"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--46
	["Immolation Trap"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--56
	["Immolation Trap"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--30
	["Intimidation"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--40
	["Lacerate"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--50
	["Lacerate"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--60
	["Lacerate"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--12
	["Mend Pet"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--20
	["Mend Pet"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--28
	["Mend Pet"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--36
	["Mend Pet"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--44
	["Mend Pet"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--52
	["Mend Pet"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--60
	["Mend Pet"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--16
	["Mongoose Bite"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--30
	["Mongoose Bite"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--44
	["Mongoose Bite"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--58
	["Mongoose Bite"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--18
	["Multi-Shot"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--30
	["Multi-Shot"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--42
	["Multi-Shot"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--54
	["Multi-Shot"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--26
	["Rapid Fire"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--8
	["Raptor Strike"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--16
	["Raptor Strike"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--24
	["Raptor Strike"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--32
	["Raptor Strike"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--40
	["Raptor Strike"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--48
	["Raptor Strike"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--56
	["Raptor Strike"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--14
	["Scare Beast"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--30
	["Scare Beast"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--46
	["Scare Beast"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--30
	["Scatter Shot"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--22
	["Scorpid Sting"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--32
	["Scorpid Sting"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--42
	["Scorpid Sting"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--52
	["Scorpid Sting"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--4
	["Serpent Sting"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--10
	["Serpent Sting"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--18
	["Serpent Sting"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--26
	["Serpent Sting"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--34
	["Serpent Sting"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--42
	["Serpent Sting"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--50
	["Serpent Sting"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--58
	["Serpent Sting"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--40
	["Spirit Bond"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--50
	["Spirit Bond"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--60
	["Spirit Bond"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--1
	["Track Beasts"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--32
	["Track Demons"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--50
	["Track Dragonkin"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--26
	["Track Elementals"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--40
	["Track Giants"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--24
	["Track Hidden"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--10
	["Track Humanoids"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--18
	["Track Undead"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--40
	["Trueshot Aura"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--50
	["Trueshot Aura"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--60
	["Trueshot Aura"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--36
	["Viper Sting"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--46
	["Viper Sting"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--56
	["Viper Sting"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--40
	["Volley"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--50
	["Volley"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--58
	["Volley"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--12
	["Wing Clip"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--38
	["Wing Clip"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--60
	["Wing Clip"] = {
		cl	= CSG_HUNTER, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--

--==MAGE==
--18
	["Amplify Magic"] = {
		cl	= CSG_MAGE, 
		ob	= 1, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--14
	["Arcane Explosion"] = {
		cl	= CSG_MAGE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--1
	["Arcane Intellect"] = {
		cl	= CSG_MAGE, 
		ob	= 1, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--8
	["Arcane Missiles"] = {
		cl	= CSG_MAGE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--40
	["Arcane Power"] = {
		cl	= CSG_MAGE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--36
	["Blast Wave"] = {
		cl	= CSG_MAGE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--20
	["Blink"] = {
		cl	= CSG_MAGE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--20
	["Blizzard"] = {
		cl	= CSG_MAGE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--20
	["Cold Snap"] = {
		cl	= CSG_MAGE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--40
	["Combustion"] = {
		cl	= CSG_MAGE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--26
	["Cone of Cold"] = {
		cl	= CSG_MAGE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--6
	["Conjure Food"] = {
		cl	= CSG_MAGE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--28
	["Conjure Mana Agate"] = {
		cl	= CSG_MAGE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--48
	["Conjure Mana Citrine"] = {
		cl	= CSG_MAGE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--38
	["Conjure Mana Jade"] = {
		cl	= CSG_MAGE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--58
	["Conjure Mana Ruby"] = {
		cl	= CSG_MAGE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--4
	["Conjure Water"] = {
		cl	= CSG_MAGE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--24
	["Counterspell"] = {
		cl	= CSG_MAGE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--12
	["Dampen Magic"] = {
		cl	= CSG_MAGE, 
		ob	= 1, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--16
	["Detect Magic"] = {
		cl	= CSG_MAGE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--20
	["Evocation"] = {
		cl	= CSG_MAGE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--6
	["Fire Blast"] = {
		cl	= CSG_MAGE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--20
	["Fire Ward"] = {
		cl	= CSG_MAGE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--6
	["Fireball"] = {
		cl	= CSG_MAGE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--16
	["Flamestrike"] = {
		cl	= CSG_MAGE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--10
	["Frost Armor"] = {
		cl	= CSG_MAGE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--10
	["Frost Nova"] = {
		cl	= CSG_MAGE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--22
	["Frost Ward"] = {
		cl	= CSG_MAGE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--4
	["Frostbolt"] = {
		cl	= CSG_MAGE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--30
	["Ice Armor"] = {
		cl	= CSG_MAGE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--40
	["Ice Barrier"] = {
		cl	= CSG_MAGE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--30
	["Ice Block"] = {
		cl	= CSG_MAGE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--34
	["Mage Armor"] = {
		cl	= CSG_MAGE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--20
	["Mana Shield"] = {
		cl	= CSG_MAGE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--8
	["Polymorph"] = {
		cl	= CSG_MAGE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

-- Portals are here for completeness
--50
	["Portal: Darnassus"] = {
		cl	= CSG_MAGE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--40
	["Portal: Ironforge"] = {
		cl	= CSG_MAGE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--40
	["Portal: Orgrimmar"] = {
		cl	= CSG_MAGE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--40
	["Portal: Stormwind"] = {
		cl	= CSG_MAGE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--50
	["Portal: Thunder Bluff"] = {
		cl	= CSG_MAGE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--40
	["Portal: Undercity"] = {
		cl	= CSG_MAGE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--30
	["Presence of Mind"] = {
		cl	= CSG_MAGE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--20
	["Pyroblast"] = {
		cl	= CSG_MAGE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--18
	["Remove Lesser Curse"] = {
		cl	= CSG_MAGE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--22
	["Scorch"] = {
		cl	= CSG_MAGE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--12
	["Slow Fall"] = {
		cl	= CSG_MAGE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--30
	["Teleport: Darnassus"] = {
		cl	= CSG_MAGE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--20
	["Teleport: Ironforge"] = {
		cl	= CSG_MAGE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--20
	["Teleport: Orgrimmar"] = {
		cl	= CSG_MAGE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--20
	["Teleport: Stormwind"] = {
		cl	= CSG_MAGE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--30
	["Teleport: Thunder Bluff"] = {
		cl	= CSG_MAGE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--20
	["Teleport: Undercity"] = {
		cl	= CSG_MAGE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--

--==PALADIN==
--18
	["Blessing of Freedom"] = {
		cl	= CSG_PALADIN, 
		ob	= 1, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--40
	["Blessing of Kings"] = {
		cl	= CSG_PALADIN, 
		ob	= 1, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--40
	["Blessing of Light"] = {
		cl	= CSG_PALADIN, 
		ob	= 1, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--4
	["Blessing of Might"] = {
		cl	= CSG_PALADIN, 
		ob	= 1, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--10
	["Blessing of Protection"] = {
		cl	= CSG_PALADIN, 
		ob	= 1, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--46
	["Blessing of Sacrifice"] = {
		cl	= CSG_PALADIN, 
		ob	= 1, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--26
	["Blessing of Salvation"] = {
		cl	= CSG_PALADIN, 
		ob	= 1, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--20
	["Blessing of Sanctuary"] = {
		cl	= CSG_PALADIN, 
		ob	= 1, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--14
	["Blessing of Wisdom"] = {
		cl	= CSG_PALADIN, 
		ob	= 1, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--42
	["Cleanse"] = {
		cl	= CSG_PALADIN, 
		ob	= 1, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--22
	["Concentration Aura"] = {
		cl	= CSG_PALADIN, 
		ob	= 1, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--30
	["Consecration"] = {
		cl	= CSG_PALADIN, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--1
	["Devotion Aura"] = {
		cl	= CSG_PALADIN, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--20
	["Divine Favor"] = {
		cl	= CSG_PALADIN, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},


--30
	["Divine Intervention"] = {
		cl	= CSG_PALADIN, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--6
	["Divine Protection"] = {
		cl	= CSG_PALADIN, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--34
	["Divine Shield"] = {
		cl	= CSG_PALADIN, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--20
	["Exorcism"] = {
		cl	= CSG_PALADIN, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--36
	["Fire Resistance Aura"] = {
		cl	= CSG_PALADIN, 
		ob	= 1, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--20
	["Flash of Light"] = {
		cl	= CSG_PALADIN, 
		ob	= 1, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--32
	["Frost Resistance Aura"] = {
		cl	= CSG_PALADIN, 
		ob	= 1, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--8
	["Hammer of Justice"] = {
		cl	= CSG_PALADIN, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--6
	["Holy Light"] = {
		cl	= CSG_PALADIN, 
		ob	= 1, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--30
	["Holy Shield"] = {
		cl	= CSG_PALADIN, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--40
	["Holy Shock"] = {
		cl	= CSG_PALADIN, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--50
	["Holy Wrath"] = {
		cl	= CSG_PALADIN, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--4
	["Judgement"] = {
		cl	= CSG_PALADIN, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--10
	["Lay on Hands"] = {
		cl	= CSG_PALADIN, 
		ob	= 1, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--8
	["Purify"] = {
		cl	= CSG_PALADIN, 
		ob	= 1, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--24
	["Redemption"] = {
		cl	= CSG_PALADIN, 
		ob	= 1, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--40
	["Repentance"] = {
		cl	= CSG_PALADIN, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--16
	["Retribution Aura"] = {
		cl	= CSG_PALADIN, 
		ob	= 1, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--30
	["Sanctity Aura"] = {
		cl	= CSG_PALADIN, 
		ob	= 1, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--20
	["Seal of Command"] = {
		cl	= CSG_PALADIN, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--16
	["Seal of Fury"] = {
		cl	= CSG_PALADIN, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--22
	["Seal of Justice"] = {
		cl	= CSG_PALADIN, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--30
	["Seal of Light"] = {
		cl	= CSG_PALADIN, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--10
	["Seal of Righteousness"] = {
		cl	= CSG_PALADIN, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--38
	["Seal of Wisdom"] = {
		cl	= CSG_PALADIN, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--6
	["Seal of the Crusader"] = {
		cl	= CSG_PALADIN, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--28
	["Shadow Resistance Aura"] = {
		cl	= CSG_PALADIN, 
		ob	= 1, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--24
	["Turn Undead"] = {
		cl	= CSG_PALADIN, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--

--==PRIEST==
--32
	["Abolish Disease"] = {
		cl	= CSG_PRIEST, 
		ob	= 1, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--14
	["Cure Disease"] = {
		cl	= CSG_PRIEST, 
		ob	= 1, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--18
	["Desperate Prayer"] = {
		cl	= CSG_PRIEST, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--28
	["Devouring Plague"] = {
		cl	= CSG_PRIEST, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--18
	["Dispel Magic"] = {
		cl	= CSG_PRIEST, 
		ob	= 1, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--40
	["Divine Spirit"] = {
		cl	= CSG_PRIEST, 
		ob	= 1, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--30
	["Elune's Grace"] = {
		cl	= CSG_PRIEST, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--8
	["Fade"] = {
		cl	= CSG_PRIEST, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--30
	["Feedback"] = {
		cl	= CSG_PRIEST, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--20
	["Flash Heal"] = {
		cl	= CSG_PRIEST, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--20
	["Focused Casting"] = {
		cl	= CSG_PRIEST, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--40
	["Greater Heal"] = {
		cl	= CSG_PRIEST, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--16
	["Heal"] = {
		cl	= CSG_PRIEST, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--20
	["Hex of Weakness"] = {
		cl	= CSG_PRIEST, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--20
	["Holy Fire"] = {
		cl	= CSG_PRIEST, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--40
	["Holy Nova"] = {
		cl	= CSG_PRIEST, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--12
	["Inner Fire"] = {
		cl	= CSG_PRIEST, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--30
	["Inner Focus"] = {
		cl	= CSG_PRIEST, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--4
	["Lesser Heal"] = {
		cl	= CSG_PRIEST, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--34
	["Levitate"] = {
		cl	= CSG_PRIEST, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--24
	["Mana Burn"] = {
		cl	= CSG_PRIEST, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--10
	["Mind Blast"] = {
		cl	= CSG_PRIEST, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--30
	["Mind Control"] = {
		cl	= CSG_PRIEST, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--20
	["Mind Flay"] = {
		cl	= CSG_PRIEST, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--20
	["Mind Soothe"] = {
		cl	= CSG_PRIEST, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--22
	["Mind Vision"] = {
		cl	= CSG_PRIEST, 
		ob	= 1, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--1
	["Power Word: Fortitude"] = {
		cl	= CSG_PRIEST, 
		ob	= 1, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--6
	["Power Word: Shield"] = {
		cl	= CSG_PRIEST, 
		ob	= 1, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--30
	["Prayer of Healing"] = {
		cl	= CSG_PRIEST, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--14
	["Psychic Scream"] = {
		cl	= CSG_PRIEST, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--8
	["Renew"] = {
		cl	= CSG_PRIEST, 
		ob	= 1, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--10
	["Resurrection"] = {
		cl	= CSG_PRIEST, 
		ob	= 1, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--20
	["Shackle Undead"] = {
		cl	= CSG_PRIEST, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--40
	["Shackle Undead"] = {
		cl	= CSG_PRIEST, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--60
	["Shackle Undead"] = {
		cl	= CSG_PRIEST, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--30
	["Shadow Protection"] = {
		cl	= CSG_PRIEST, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--42
	["Shadow Protection"] = {
		cl	= CSG_PRIEST, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--56
	["Shadow Protection"] = {
		cl	= CSG_PRIEST, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--4
	["Shadow Word: Pain"] = {
		cl	= CSG_PRIEST, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--10
	["Shadow Word: Pain"] = {
		cl	= CSG_PRIEST, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--18
	["Shadow Word: Pain"] = {
		cl	= CSG_PRIEST, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--26
	["Shadow Word: Pain"] = {
		cl	= CSG_PRIEST, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--34
	["Shadow Word: Pain"] = {
		cl	= CSG_PRIEST, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--42
	["Shadow Word: Pain"] = {
		cl	= CSG_PRIEST, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--50
	["Shadow Word: Pain"] = {
		cl	= CSG_PRIEST, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--58
	["Shadow Word: Pain"] = {
		cl	= CSG_PRIEST, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--40
	["Shadowform"] = {
		cl	= CSG_PRIEST, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},


--28
	["Shadowguard"] = {
		cl	= CSG_PRIEST, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--36
	["Shadowguard"] = {
		cl	= CSG_PRIEST, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--44
	["Shadowguard"] = {
		cl	= CSG_PRIEST, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--52
	["Shadowguard"] = {
		cl	= CSG_PRIEST, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--60
	["Shadowguard"] = {
		cl	= CSG_PRIEST, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--30
	["Silence"] = {
		cl	= CSG_PRIEST, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--6
	["Smite"] = {
		cl	= CSG_PRIEST, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--14
	["Smite"] = {
		cl	= CSG_PRIEST, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--22
	["Smite"] = {
		cl	= CSG_PRIEST, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--30
	["Smite"] = {
		cl	= CSG_PRIEST, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--38
	["Smite"] = {
		cl	= CSG_PRIEST, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--46
	["Smite"] = {
		cl	= CSG_PRIEST, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--54
	["Smite"] = {
		cl	= CSG_PRIEST, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--30
	["Spirit of Redemption"] = {
		cl	= CSG_PRIEST, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--18
	["Starshards"] = {
		cl	= CSG_PRIEST, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--26
	["Starshards"] = {
		cl	= CSG_PRIEST, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--34
	["Starshards"] = {
		cl	= CSG_PRIEST, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--42
	["Starshards"] = {
		cl	= CSG_PRIEST, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--50
	["Starshards"] = {
		cl	= CSG_PRIEST, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--58
	["Starshards"] = {
		cl	= CSG_PRIEST, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--20
	["Touch of Weakness"] = {
		cl	= CSG_PRIEST, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--30
	["Touch of Weakness"] = {
		cl	= CSG_PRIEST, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--40
	["Touch of Weakness"] = {
		cl	= CSG_PRIEST, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--50
	["Touch of Weakness"] = {
		cl	= CSG_PRIEST, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--60
	["Touch of Weakness"] = {
		cl	= CSG_PRIEST, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--30
	["Vampiric Embrace"] = {
		cl	= CSG_PRIEST, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--

--==ROGUE==
--40
	["Adrenaline Rush"] = {
		cl	= CSG_ROGUE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--18
	["Ambush"] = {
		cl	= CSG_ROGUE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--26
	["Ambush"] = {
		cl	= CSG_ROGUE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--34
	["Ambush"] = {
		cl	= CSG_ROGUE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--42
	["Ambush"] = {
		cl	= CSG_ROGUE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--50
	["Ambush"] = {
		cl	= CSG_ROGUE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--30
	["Blade Flurry"] = {
		cl	= CSG_ROGUE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--34
	["Blind"] = {
		cl	= CSG_ROGUE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--34
	["Blinding Powder"] = {
		cl	= CSG_ROGUE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--26
	["Cheap Shot"] = {
		cl	= CSG_ROGUE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--30
	["Cold Blood"] = {
		cl	= CSG_ROGUE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--20
	["Crippling Poison"] = {
		cl	= CSG_ROGUE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--30
	["Deadly Poison"] = {
		cl	= CSG_ROGUE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--38
	["Deadly Poison II"] = {
		cl	= CSG_ROGUE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--46
	["Deadly Poison III"] = {
		cl	= CSG_ROGUE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--54
	["Deadly Poison IV"] = {
		cl	= CSG_ROGUE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--24
	["Detect Traps"] = {
		cl	= CSG_ROGUE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--30
	["Disarm Trap"] = {
		cl	= CSG_ROGUE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--22
	["Distract"] = {
		cl	= CSG_ROGUE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--8
	["Evasion"] = {
		cl	= CSG_ROGUE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--8
	["Eviscerate"] = {
		cl	= CSG_ROGUE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--14
	["Expose Armor"] = {
		cl	= CSG_ROGUE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--16
	["Feint"] = {
		cl	= CSG_ROGUE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--14
	["Garrote"] = {
		cl	= CSG_ROGUE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--20
	["Ghostly Strike"] = {
		cl	= CSG_ROGUE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--6
	["Gouge"] = {
		cl	= CSG_ROGUE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--35
	["Hemorrhage"] = {
		cl	= CSG_ROGUE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--28
	["Instant Poison II"] = {
		cl	= CSG_ROGUE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--36
	["Instant Poison III"] = {
		cl	= CSG_ROGUE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--44
	["Instant Poison IV"] = {
		cl	= CSG_ROGUE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--52
	["Instant Poison V"] = {
		cl	= CSG_ROGUE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--60
	["Instant Poison VI"] = {
		cl	= CSG_ROGUE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--12
	["Kick"] = {
		cl	= CSG_ROGUE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--30
	["Kidney Shot"] = {
		cl	= CSG_ROGUE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--24
	["Mind-numbing Poison"] = {
		cl	= CSG_ROGUE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--38
	["Mind-numbing Poison II"] = {
		cl	= CSG_ROGUE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--52
	["Mind-numbing Poison III"] = {
		cl	= CSG_ROGUE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--16
	["Pick Lock"] = {
		cl	= CSG_ROGUE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--4
	["Pick Pocket"] = {
		cl	= CSG_ROGUE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--40
	["Premeditation"] = {
		cl	= CSG_ROGUE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--30
	["Preparation"] = {
		cl	= CSG_ROGUE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--20
	["Relentless Strikes"] = {
		cl	= CSG_ROGUE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--20
	["Riposte"] = {
		cl	= CSG_ROGUE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--20
	["Rupture"] = {
		cl	= CSG_ROGUE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--40
	["Safe Fall"] = {
		cl	= CSG_ROGUE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--10
	["Sap"] = {
		cl	= CSG_ROGUE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--1
	["Sinister Strike"] = {
		cl	= CSG_ROGUE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--10
	["Slice and Dice"] = {
		cl	= CSG_ROGUE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--42
	["Slice and Dice"] = {
		cl	= CSG_ROGUE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--10
	["Sprint"] = {
		cl	= CSG_ROGUE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--1
	["Stealth"] = {
		cl	= CSG_ROGUE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--22
	["Vanish"] = {
		cl	= CSG_ROGUE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--32
	["Wound Poison"] = {
		cl	= CSG_ROGUE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--40
	["Wound Poison II"] = {
		cl	= CSG_ROGUE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--48
	["Wound Poison III"] = {
		cl	= CSG_ROGUE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--56
	["Wound Poison IV"] = {
		cl	= CSG_ROGUE, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--

--==SHAMAN==
--12
	["Ancestral Spirit"] = {
		cl	= CSG_SHAMAN, 
		ob	= 1, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--30
	["Astral Recall"] = {
		cl	= CSG_SHAMAN, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--40
	["Chain Heal"] = {
		cl	= CSG_SHAMAN, 
		ob	= 1, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--32
	["Chain Lightning"] = {
		cl	= CSG_SHAMAN, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--22
	["Cure Disease"] = {
		cl	= CSG_SHAMAN, 
		ob	= 1, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--16
	["Cure Poison"] = {
		cl	= CSG_SHAMAN, 
		ob	= 1, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--38
	["Disease Cleansing Totem"] = {
		cl	= CSG_SHAMAN, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--4
	["Earth Shock"] = {
		cl	= CSG_SHAMAN, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--6
	["Earthbind Totem"] = {
		cl	= CSG_SHAMAN, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--20
	["Elemental Focus"] = {
		cl	= CSG_SHAMAN, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--40
	["Elemental Mastery"] = {
		cl	= CSG_SHAMAN, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--26
	["Far Sight"] = {
		cl	= CSG_SHAMAN, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--12
	["Fire Nova Totem"] = {
		cl	= CSG_SHAMAN, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--28
	["Fire Resistance Totem"] = {
		cl	= CSG_SHAMAN, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--10
	["Flame Shock"] = {
		cl	= CSG_SHAMAN, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--28
	["Flametongue Totem"] = {
		cl	= CSG_SHAMAN, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--10
	["Flametongue Weapon"] = {
		cl	= CSG_SHAMAN, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--24
	["Frost Resistance Totem"] = {
		cl	= CSG_SHAMAN, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--20
	["Frost Shock"] = {
		cl	= CSG_SHAMAN, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--20
	["Frostbrand Weapon"] = {
		cl	= CSG_SHAMAN, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--58
	["Frostbrand Weapon"] = {
		cl	= CSG_SHAMAN, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--20
	["Ghost Wolf"] = {
		cl	= CSG_SHAMAN, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--42
	["Grace of Air Totem"] = {
		cl	= CSG_SHAMAN, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--30
	["Grounding Totem"] = {
		cl	= CSG_SHAMAN, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--30
	["Healing Stream Totem"] = {
		cl	= CSG_SHAMAN, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--6
	["Healing Wave"] = {
		cl	= CSG_SHAMAN, 
		ob	= 1, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--20
	["Lesser Healing Wave"] = {
		cl	= CSG_SHAMAN, 
		ob	= 1, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--8
	["Lightning Bolt"] = {
		cl	= CSG_SHAMAN, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--8
	["Lightning Shield"] = {
		cl	= CSG_SHAMAN, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--26
	["Magma Totem"] = {
		cl	= CSG_SHAMAN, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--26
	["Mana Spring Totem"] = {
		cl	= CSG_SHAMAN, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--40
	["Mana Tide Totem"] = {
		cl	= CSG_SHAMAN, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--30
	["Nature Resistance Totem"] = {
		cl	= CSG_SHAMAN, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--30
	["Nature's Swiftness"] = {
		cl	= CSG_SHAMAN, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--22
	["Poison Cleansing Totem"] = {
		cl	= CSG_SHAMAN, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--12
	["Purge"] = {
		cl	= CSG_SHAMAN, 
		ob	= 1, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--30
	["Reincarnation"] = {
		cl	= CSG_SHAMAN, 
		ob	= 1, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--1
	["Rockbiter Weapon"] = {
		cl	= CSG_SHAMAN, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--20
	["Searing Totem"] = {
		cl	= CSG_SHAMAN, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--34
	["Sentry Totem"] = {
		cl	= CSG_SHAMAN, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--14
	["Stoneskin Totem"] = {
		cl	= CSG_SHAMAN, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--40
	["Stormstrike"] = {
		cl	= CSG_SHAMAN, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--10
	["Strength of Earth Totem"] = {
		cl	= CSG_SHAMAN, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--18
	["Tremor Totem"] = {
		cl	= CSG_SHAMAN, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--22
	["Water Breathing"] = {
		cl	= CSG_SHAMAN, 
		ob	= 1, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--28
	["Water Walking"] = {
		cl	= CSG_SHAMAN, 
		ob	= 1, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--32
	["Windfury Totem"] = {
		cl	= CSG_SHAMAN, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--30
	["Windfury Weapon"] = {
		cl	= CSG_SHAMAN, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--36
	["Windwall Totem"] = {
		cl	= CSG_SHAMAN, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--

--==WARLOCK==
--20
	["Amplify Curse"] = {
		cl	= CSG_WARLOCK, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--28
	["Banish"] = {
		cl	= CSG_WARLOCK, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--40
	["Conflagrate"] = {
		cl	= CSG_WARLOCK, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--4
	["Corruption"] = {
		cl	= CSG_WARLOCK, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--36
	["Create Firestone"] = {
		cl	= CSG_WARLOCK, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--46
	["Create Firestone (Greater)"] = {
		cl	= CSG_WARLOCK, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--28
	["Create Firestone (Lesser)"] = {
		cl	= CSG_WARLOCK, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--56
	["Create Firestone (Major)"] = {
		cl	= CSG_WARLOCK, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--34
	["Create Healthstone"] = {
		cl	= CSG_WARLOCK, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--46
	["Create Healthstone (Greater)"] = {
		cl	= CSG_WARLOCK, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--22
	["Create Healthstone (Lesser)"] = {
		cl	= CSG_WARLOCK, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--58
	["Create Healthstone (Major)"] = {
		cl	= CSG_WARLOCK, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--10
	["Create Healthstone (Minor)"] = {
		cl	= CSG_WARLOCK, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--40
	["Create Soulstone"] = {
		cl	= CSG_WARLOCK, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--50
	["Create Soulstone (Greater)"] = {
		cl	= CSG_WARLOCK, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--30
	["Create Soulstone (Lesser)"] = {
		cl	= CSG_WARLOCK, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--60
	["Create Soulstone (Major)"] = {
		cl	= CSG_WARLOCK, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--18
	["Create Soulstone (Minor)"] = {
		cl	= CSG_WARLOCK, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--36
	["Create Spellstone"] = {
		cl	= CSG_WARLOCK, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--48
	["Create Spellstone (Greater)"] = {
		cl	= CSG_WARLOCK, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--60
	["Create Spellstone (Major)"] = {
		cl	= CSG_WARLOCK, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--8
	["Curse of Agony"] = {
		cl	= CSG_WARLOCK, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--60
	["Curse of Doom"] = {
		cl	= CSG_WARLOCK, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--30
	["Curse of Exhaustion"] = {
		cl	= CSG_WARLOCK, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--14
	["Curse of Recklessness"] = {
		cl	= CSG_WARLOCK, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--44
	["Curse of Shadow"] = {
		cl	= CSG_WARLOCK, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--26
	["Curse of Tongues"] = {
		cl	= CSG_WARLOCK, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--4
	["Curse of Weakness"] = {
		cl	= CSG_WARLOCK, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--32
	["Curse of the Elements"] = {
		cl	= CSG_WARLOCK, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--40
	["Dark Pact"] = {
		cl	= CSG_WARLOCK, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--42
	["Death Coil"] = {
		cl	= CSG_WARLOCK, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--20
	["Demon Armor"] = {
		cl	= CSG_WARLOCK, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--10
	["Demon Skin"] = {
		cl	= CSG_WARLOCK, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--30
	["Demonic Sacrifice"] = {
		cl	= CSG_WARLOCK, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--50
	["Detect Greater Invisibility"] = {
		cl	= CSG_WARLOCK, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--38
	["Detect Invisibility"] = {
		cl	= CSG_WARLOCK, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--26
	["Detect Lesser Invisibility"] = {
		cl	= CSG_WARLOCK, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--14
	["Drain Life"] = {
		cl	= CSG_WARLOCK, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--24
	["Drain Mana"] = {
		cl	= CSG_WARLOCK, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--10
	["Drain Soul"] = {
		cl	= CSG_WARLOCK, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--30
	["Enslave Demon"] = {
		cl	= CSG_WARLOCK, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--22
	["Eye of Kilrogg"] = {
		cl	= CSG_WARLOCK, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--8
	["Fear"] = {
		cl	= CSG_WARLOCK, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--20
	["Fel Domination"] = {
		cl	= CSG_WARLOCK, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--12
	["Health Funnel"] = {
		cl	= CSG_WARLOCK, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--30
	["Hellfire"] = {
		cl	= CSG_WARLOCK, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--40
	["Howl of Terror"] = {
		cl	= CSG_WARLOCK, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--1
	["Immolate"] = {
		cl	= CSG_WARLOCK, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--50
	["Inferno"] = {
		cl	= CSG_WARLOCK, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--6
	["Life Tap"] = {
		cl	= CSG_WARLOCK, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--20
	["Rain of Fire"] = {
		cl	= CSG_WARLOCK, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--60
	["Ritual of Doom"] = {
		cl	= CSG_WARLOCK, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--20
	["Ritual of Summoning"] = {
		cl	= CSG_WARLOCK, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--18
	["Searing Pain"] = {
		cl	= CSG_WARLOCK, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--24
	["Sense Demons"] = {
		cl	= CSG_WARLOCK, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--6
	["Shadow Bolt"] = {
		cl	= CSG_WARLOCK, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--32
	["Shadow Ward"] = {
		cl	= CSG_WARLOCK, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--20
	["Shadowburn"] = {
		cl	= CSG_WARLOCK, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--30
	["Siphon Life"] = {
		cl	= CSG_WARLOCK, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--48
	["Soul Fire"] = {
		cl	= CSG_WARLOCK, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--40
	["Soul Link"] = {
		cl	= CSG_WARLOCK, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--5
	["Summon Dreadsteed"] = {
		cl	= CSG_WARLOCK, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--30
	["Summon Felhound"] = {
		cl	= CSG_WARLOCK, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--40
	["Summon Felsteed"] = {
		cl	= CSG_WARLOCK, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--5
	["Summon Imp"] = {
		cl	= CSG_WARLOCK, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--20
	["Summon Succubus"] = {
		cl	= CSG_WARLOCK, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--10
	["Summon Voidwalker"] = {
		cl	= CSG_WARLOCK, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--16
	["Unending Breath"] = {
		cl	= CSG_WARLOCK, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--

--==WARRIOR==
--20
	["Anger Management"] = {
		cl	= CSG_WARRIOR, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--1
	["Battle Shout"] = {
		cl	= CSG_WARRIOR, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--32
	["Berserker Rage"] = {
		cl	= CSG_WARRIOR, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--10
	["Bloodrage"] = {
		cl	= CSG_WARRIOR, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--40
	["Bloodthirst"] = {
		cl	= CSG_WARRIOR, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--60
	["Bloodthirst"] = {
		cl	= CSG_WARRIOR, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--26
	["Challenging Shout"] = {
		cl	= CSG_WARRIOR, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--4
	["Charge"] = {
		cl	= CSG_WARRIOR, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--20
	["Cleave"] = {
		cl	= CSG_WARRIOR, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--30
	["Concussion Blow"] = {
		cl	= CSG_WARRIOR, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--30
	["Death Wish"] = {
		cl	= CSG_WARRIOR, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--14
	["Demoralizing Shout"] = {
		cl	= CSG_WARRIOR, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--18
	["Disarm"] = {
		cl	= CSG_WARRIOR, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--24
	["Execute"] = {
		cl	= CSG_WARRIOR, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--8
	["Hamstring"] = {
		cl	= CSG_WARRIOR, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--8
	["Heroic Strike"] = {
		cl	= CSG_WARRIOR, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--30
	["Intercept"] = {
		cl	= CSG_WARRIOR, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--22
	["Intimidating Shout"] = {
		cl	= CSG_WARRIOR, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--20
	["Last Stand"] = {
		cl	= CSG_WARRIOR, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--16
	["Mocking Blow"] = {
		cl	= CSG_WARRIOR, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--40
	["Mortal Strike"] = {
		cl	= CSG_WARRIOR, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--12
	["Overpower"] = {
		cl	= CSG_WARRIOR, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--20
	["Piercing Howl"] = {
		cl	= CSG_WARRIOR, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--38
	["Pummel"] = {
		cl	= CSG_WARRIOR, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--50
	["Recklessness"] = {
		cl	= CSG_WARRIOR, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--4
	["Rend"] = {
		cl	= CSG_WARRIOR, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--20
	["Retaliation"] = {
		cl	= CSG_WARRIOR, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--14
	["Revenge"] = {
		cl	= CSG_WARRIOR, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--12
	["Shield Bash"] = {
		cl	= CSG_WARRIOR, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--16
	["Shield Block"] = {
		cl	= CSG_WARRIOR, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--40
	["Shield Slam"] = {
		cl	= CSG_WARRIOR, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--28
	["Shield Wall"] = {
		cl	= CSG_WARRIOR, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
--
--30
	["Slam"] = {
		cl	= CSG_WARRIOR, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--10
	["Sunder Armor"] = {
		cl	= CSG_WARRIOR, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--30
	["Sweeping Strikes"] = {
		cl	= CSG_WARRIOR, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--6
	["Thunder Clap"] = {
		cl	= CSG_WARRIOR, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},

--
--36
	["Whirlwind"] = {
		cl	= CSG_WARRIOR, 
		--type	= "Debuff",
		--icon	= "Interface\\InventoryItems\\WoWUnknownItem01",
		--minlvl	= 1,
	},
};
--

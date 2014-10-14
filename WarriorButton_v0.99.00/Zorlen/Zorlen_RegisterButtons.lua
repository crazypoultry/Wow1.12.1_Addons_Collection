


function Zorlen_RegisterButtons(option)
	if Zorlen_isCurrentClassHunter then
		Zorlen_RegisterHunterButtons(option)
	elseif Zorlen_isCurrentClassWarlock then
		Zorlen_RegisterWarlockButtons(option)
	elseif Zorlen_isCurrentClassWarrior then
		Zorlen_RegisterWarriorButtons(option)
	elseif Zorlen_isCurrentClassDruid then
		Zorlen_RegisterDruidButtons(option)
	elseif Zorlen_isCurrentClassRogue then
		Zorlen_RegisterRogueButtons(option)
	elseif Zorlen_isCurrentClassPriest then
		Zorlen_RegisterPriestButtons(option)
	--[[elseif Zorlen_isCurrentClassPaladin then
		Zorlen_RegisterPaladinButtons(option)
	elseif Zorlen_isCurrentClassMage then
		Zorlen_RegisterMageButtons(option)
	elseif Zorlen_isCurrentClassShaman then
		Zorlen_RegisterShamanButtons(option)--]]
	end
	Zorlen_RegisterOtherButtons(option)
end



function Zorlen_RegisterDruidButtons(option)
	Zorlen_Button_TravelForm = nil;
	Zorlen_Button_MoonkinForm = nil;
	Zorlen_Button_BearForm = nil;
	Zorlen_Button_DireBearForm = nil;
	Zorlen_Button_CatForm = nil;
	Zorlen_Button_AquaticForm = nil;
	Zorlen_Button_ChallengingRoar = nil;
	Zorlen_Button_DemoralizingRoar = nil;
	Zorlen_Button_AbolishPoison = nil;
	Zorlen_Button_Barkskin = nil;
	Zorlen_Button_Bash = nil;
	Zorlen_Button_Claw = nil;
	Zorlen_Button_Cower = nil;
	Zorlen_Button_Dash = nil;
	Zorlen_Button_Enrage = nil;
	Zorlen_Button_EntanglingRoots = nil;
	Zorlen_Button_FaerieFire = nil;
	Zorlen_Button_FaerieFireFeral = nil;
	Zorlen_Button_FeralCharge = nil;
	Zorlen_Button_FerociousBite = nil;
	Zorlen_Button_FrenziedRegeneration = nil;
	Zorlen_Button_GiftOfTheWild = nil;
	Zorlen_Button_HealingTouch = nil;
	Zorlen_Button_Hibernate = nil;
	Zorlen_Button_Hurricane = nil;
	Zorlen_Button_Innervate = nil;
	Zorlen_Button_InsectSwarm = nil;
	Zorlen_Button_LeaderOfThePack = nil;
	Zorlen_Button_MarkOfTheWild = nil;
	Zorlen_Button_Maul = nil;
	Zorlen_Button_Moonfire = nil;
	Zorlen_Button_NaturesGrasp = nil;
	Zorlen_Button_NaturesSwiftness = nil;
	Zorlen_Button_OmenOfClarity = nil;
	Zorlen_Button_Pounce = nil;
	Zorlen_Button_Prowl = nil;
	Zorlen_Button_Rake = nil;
	Zorlen_Button_Ravage = nil;
	Zorlen_Button_Rebirth = nil;
	Zorlen_Button_Regrowth = nil;
	Zorlen_Button_Rejuvenation = nil;
	Zorlen_Button_RemoveCurse = nil;
	Zorlen_Button_Rip = nil;
	Zorlen_Button_Shred = nil;
	Zorlen_Button_SootheAnimal = nil;
	Zorlen_Button_Starfire = nil;
	Zorlen_Button_Swipe = nil;
	Zorlen_Button_Thorns = nil;
	Zorlen_Button_TigersFury = nil;
	Zorlen_Button_Tranquility = nil;
	Zorlen_Button_Wrath = nil;
	for i = 1, 120 do
		if ( HasAction(i) ) then
		local texture = GetActionTexture(i);
		local text = GetActionText(i);
			if not ( Zorlen_Button_TravelForm ) and (not text) and not IsAttackAction(i) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_TravelForm)) ) then
				Zorlen_Button_TravelForm = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_TravelForm.." = " .. i);
				end
			elseif not ( Zorlen_Button_MoonkinForm ) and (not text) and not IsAttackAction(i) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_MoonkinForm)) ) then
				Zorlen_Button_MoonkinForm = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_MoonkinForm.." = " .. i);
				end
			elseif not ( Zorlen_Button_BearForm ) and (not text) and not IsAttackAction(i) and ( string.find(texture, "Ability_Racial_BearForm") ) then
				Zorlen_Button_BearForm = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_BearForm.." = " .. i);
				end
			elseif not ( Zorlen_Button_DireBearForm ) and (not text) and not IsAttackAction(i) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_DireBearForm)) ) then
				Zorlen_Button_DireBearForm = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_DireBearForm.." = " .. i);
				end
			elseif not ( Zorlen_Button_CatForm ) and (not text) and not IsAttackAction(i) and ( string.find(texture, "Ability_Druid_CatForm") ) then
				Zorlen_Button_CatForm = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_CatForm.." = " .. i);
				end
			elseif not ( Zorlen_Button_AquaticForm ) and (not text) and not IsAttackAction(i) and ( string.find(texture, "Ability_Druid_AquaticForm") ) then
				Zorlen_Button_AquaticForm = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_AquaticForm.." = " .. i);
				end
			elseif not ( Zorlen_Button_ChallengingRoar ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_ChallengingRoar)) ) then
				Zorlen_Button_ChallengingRoar = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_ChallengingRoar.." = " .. i);
				end
			elseif not ( Zorlen_Button_DemoralizingRoar ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_DemoralizingRoar)) ) then
				Zorlen_Button_DemoralizingRoar = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_DemoralizingRoar.." = " .. i);
				end
			elseif not ( Zorlen_Button_AbolishPoison ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_AbolishPoison)) ) then
				Zorlen_Button_AbolishPoison = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_AbolishPoison.." = " .. i);
				end
			elseif not ( Zorlen_Button_Barkskin ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_Barkskin)) ) then
				Zorlen_Button_Barkskin = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_Barkskin.." = " .. i);
				end
			elseif not ( Zorlen_Button_Bash ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_Bash)) ) then
				Zorlen_Button_Bash = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_Bash.." = " .. i);
				end
			elseif not ( Zorlen_Button_Claw ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_Claw)) ) then
				Zorlen_Button_Claw = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_Claw.." = " .. i);
				end
			elseif not ( Zorlen_Button_Cower ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_Cower)) ) then
				Zorlen_Button_Cower = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_Cower.." = " .. i);
				end
			elseif not ( Zorlen_Button_Dash ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_Dash)) ) then
				Zorlen_Button_Dash = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_Dash.." = " .. i);
				end
			elseif not ( Zorlen_Button_Enrage ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_Enrage)) ) then
				Zorlen_Button_Enrage = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_Enrage.." = " .. i);
				end
			elseif not ( Zorlen_Button_EntanglingRoots ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_EntanglingRoots)) ) then
				Zorlen_Button_EntanglingRoots = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_EntanglingRoots.." = " .. i);
				end
			elseif not ( Zorlen_Button_FaerieFire ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_FaerieFire)) ) then
				Zorlen_Button_FaerieFire = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_FaerieFire.." = " .. i);
				end
			elseif not ( Zorlen_Button_FaerieFireFeral ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_FaerieFireFeral)) ) then
				Zorlen_Button_FaerieFireFeral = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_FaerieFireFeral.." = " .. i);
				end
			elseif not ( Zorlen_Button_FeralCharge ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_FeralCharge)) ) then
				Zorlen_Button_FeralCharge = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_FeralCharge.." = " .. i);
				end
			elseif not ( Zorlen_Button_FerociousBite ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_FerociousBite)) ) then
				Zorlen_Button_FerociousBite = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_FerociousBite.." = " .. i);
				end
			elseif not ( Zorlen_Button_FrenziedRegeneration ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_FrenziedRegeneration)) ) then
				Zorlen_Button_FrenziedRegeneration = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_FrenziedRegeneration.." = " .. i);
				end
			elseif not ( Zorlen_Button_GiftOfTheWild ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_GiftOfTheWild)) ) then
				Zorlen_Button_GiftOfTheWild = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_GiftOfTheWild.." = " .. i);
				end
			elseif not ( Zorlen_Button_HealingTouch ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_HealingTouch)) ) then
				Zorlen_Button_HealingTouch = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_HealingTouch.." = " .. i);
				end
			elseif not ( Zorlen_Button_Hibernate ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_Hibernate)) ) then
				Zorlen_Button_Hibernate = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_Hibernate.." = " .. i);
				end
			elseif not ( Zorlen_Button_Hurricane ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_Hurricane)) ) then
				Zorlen_Button_Hurricane = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_Hurricane.." = " .. i);
				end
			elseif not ( Zorlen_Button_Innervate ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_Innervate)) ) then
				Zorlen_Button_Innervate = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_Innervate.." = " .. i);
				end
			elseif not ( Zorlen_Button_InsectSwarm ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_InsectSwarm)) ) then
				Zorlen_Button_InsectSwarm = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_InsectSwarm.." = " .. i);
				end
			elseif not ( Zorlen_Button_LeaderOfThePack ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_LeaderOfThePack)) ) then
				Zorlen_Button_LeaderOfThePack = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_LeaderOfThePack.." = " .. i);
				end
			elseif not ( Zorlen_Button_MarkOfTheWild ) and (not text) and ( string.find(texture, "Spell_Nature_Regeneration") ) then
				Zorlen_Button_MarkOfTheWild = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_MarkOfTheWild.." = " .. i);
				end
			elseif not ( Zorlen_Button_Maul ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_Maul)) ) then
				Zorlen_Button_Maul = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_Maul.." = " .. i);
				end
			elseif not ( Zorlen_Button_Moonfire ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_Moonfire)) ) then
				Zorlen_Button_Moonfire = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_Moonfire.." = " .. i);
				end
			elseif not ( Zorlen_Button_NaturesGrasp ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_NaturesGrasp)) ) then
				Zorlen_Button_NaturesGrasp = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_NaturesGrasp.." = " .. i);
				end
			elseif not ( Zorlen_Button_NaturesSwiftness ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_NaturesSwiftness)) ) then
				Zorlen_Button_NaturesSwiftness = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_NaturesSwiftness.." = " .. i);
				end
			elseif not ( Zorlen_Button_OmenOfClarity ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_OmenOfClarity)) ) then
				Zorlen_Button_OmenOfClarity = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_OmenOfClarity.." = " .. i);
				end
			elseif not ( Zorlen_Button_Pounce ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_Pounce)) ) then
				Zorlen_Button_Pounce = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_Pounce.." = " .. i);
				end
			elseif not ( Zorlen_Button_Prowl ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_Prowl)) ) then
				Zorlen_Button_Prowl = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_Prowl.." = " .. i);
				end
			elseif not ( Zorlen_Button_Rake ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_Rake)) ) then
				Zorlen_Button_Rake = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_Rake.." = " .. i);
				end
			elseif not ( Zorlen_Button_Ravage ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_Ravage)) ) then
				Zorlen_Button_Ravage = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_Ravage.." = " .. i);
				end
			elseif not ( Zorlen_Button_Rebirth ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_Rebirth)) ) then
				Zorlen_Button_Rebirth = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_Rebirth.." = " .. i);
				end
			elseif not ( Zorlen_Button_Regrowth ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_Regrowth)) ) then
				Zorlen_Button_Regrowth = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_Regrowth.." = " .. i);
				end
			elseif not ( Zorlen_Button_Rejuvenation ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_Rejuvenation)) ) then
				Zorlen_Button_Rejuvenation = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_Rejuvenation.." = " .. i);
				end
			elseif not ( Zorlen_Button_RemoveCurse ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_RemoveCurse)) ) then
				Zorlen_Button_RemoveCurse = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_RemoveCurse.." = " .. i);
				end
			elseif not ( Zorlen_Button_Rip ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_Rip)) ) then
				Zorlen_Button_Rip = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_Rip.." = " .. i);
				end
			elseif not ( Zorlen_Button_Shred ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_Shred)) ) then
				Zorlen_Button_Shred = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_Shred.." = " .. i);
				end
			elseif not ( Zorlen_Button_SootheAnimal ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_SootheAnimal)) ) then
				Zorlen_Button_SootheAnimal = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_SootheAnimal.." = " .. i);
				end
			elseif not ( Zorlen_Button_Starfire ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_Starfire)) ) then
				Zorlen_Button_Starfire = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_Starfire.." = " .. i);
				end
			elseif not ( Zorlen_Button_Swipe ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_Swipe)) ) then
				Zorlen_Button_Swipe = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_Swipe.." = " .. i);
				end
			elseif not ( Zorlen_Button_Thorns ) and (not text) and ( string.find(texture, "Spell_Nature_Thorns") ) then
				Zorlen_Button_Thorns = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_Thorns.." = " .. i);
				end
			elseif not ( Zorlen_Button_TigersFury ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_TigersFury)) ) then
				Zorlen_Button_TigersFury = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_TigersFury.." = " .. i);
				end
			elseif not ( Zorlen_Button_Tranquility ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_Tranquility)) ) then
				Zorlen_Button_Tranquility = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_Tranquility.." = " .. i);
				end
			elseif not ( Zorlen_Button_Wrath ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_Wrath)) ) then
				Zorlen_Button_Wrath = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_Wrath.." = " .. i);
				end
			end
		end
	end
end



function Zorlen_RegisterHunterButtons(option)
	Zorlen_Button_RaptorStrike = nil;
	Zorlen_Button_MongooseBite = nil;
	Zorlen_Button_Counterattack = nil;
	Zorlen_Button_WingClip = nil;
	Zorlen_Button_ConcussiveShot = nil;
	Zorlen_Button_AspectOfTheMonkey = nil;
	Zorlen_Button_MendPet = nil;
	Zorlen_Button_CallPet = nil;
	Zorlen_Button_RevivePet = nil;
	Zorlen_Button_DismissPet = nil;
	Zorlen_Button_AutoShot = nil;
	Zorlen_Button_ArcaneShot = nil;
	Zorlen_Button_SerpentSting = nil;
	Zorlen_Button_ViperSting = nil;
	Zorlen_Button_ScorpidSting = nil;
	Zorlen_Button_DistractingShot = nil;
	Zorlen_Button_AimedShot = nil;
	Zorlen_Button_HuntersMark = nil;
	Zorlen_Button_AspectOfTheHawk = nil;
	Zorlen_Button_AspectOfTheCheetah = nil;
	Zorlen_Button_AspectOfThePack = nil;
	Zorlen_Button_AspectOfTheWild = nil;
	Zorlen_Button_AspectOfTheBeast = nil;
	Zorlen_Button_FreezingTrap = nil;
	Zorlen_Button_FrostTrap = nil;
	Zorlen_Button_ExplosiveTrap = nil;
	Zorlen_Button_ImmolationTrap = nil;
	Zorlen_Button_FeignDeath = nil;
	Zorlen_Button_TranquilizingShot = nil;
	Zorlen_Button_Disengage = nil;
	Zorlen_Button_EyesOfTheBeast = nil;
	Zorlen_Button_BeastLore = nil;
	Zorlen_Button_BestialWrath = nil;
	Zorlen_Button_TrueshotAura = nil;
	Zorlen_Button_ScatterShot = nil;
	Zorlen_Button_WyvernSting = nil;
	Zorlen_Button_Deterrence = nil;
	Zorlen_Button_EagleEye = nil;
	Zorlen_Button_RapidFire = nil;
	Zorlen_Button_MultiShot = nil;
	Zorlen_Button_Flare = nil;
	Zorlen_Button_ScareBeast = nil;
	Zorlen_Button_Volley = nil;
	Zorlen_Button_Intimidation = nil;
	for i = 1, 120 do
		if ( HasAction(i) ) then
		local texture = GetActionTexture(i);
		local text = GetActionText(i);
			if not ( Zorlen_Button_RaptorStrike ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_RaptorStrike)) ) then
				Zorlen_Button_RaptorStrike = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_RaptorStrike.." = " .. i);
				end
			elseif not ( Zorlen_Button_MongooseBite ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_MongooseBite)) ) then
				Zorlen_Button_MongooseBite = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_MongooseBite.." = " .. i);
				end
			elseif not ( Zorlen_Button_Counterattack ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_Counterattack)) ) then
				Zorlen_Button_Counterattack = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_Counterattack.." = " .. i);
				end
			elseif not ( Zorlen_Button_WingClip ) and (not text) and ( string.find(texture, "Ability_Rogue_Trip") ) then
				Zorlen_Button_WingClip = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_WingClip.." = " .. i);
				end	
			elseif not ( Zorlen_Button_ConcussiveShot ) and (not text) and ( string.find(texture, "Spell_Frost_Stun") ) then
				Zorlen_Button_ConcussiveShot = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_ConcussiveShot.." = " .. i);
				end
			elseif not ( Zorlen_Button_AspectOfTheMonkey ) and (not text) and ( string.find(texture, "Ability_Hunter_AspectOfTheMonkey") ) then
				Zorlen_Button_AspectOfTheMonkey = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_AspectOfTheMonkey.." = " .. i);
				end
			elseif not ( Zorlen_Button_MendPet ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_MendPet)) ) then
				Zorlen_Button_MendPet = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_MendPet.." = " .. i);
				end
			elseif not ( Zorlen_Button_CallPet ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_CallPet)) ) then
				Zorlen_Button_CallPet = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_CallPet.." = " .. i);
				end
			elseif not ( Zorlen_Button_RevivePet ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_RevivePet)) ) then
				Zorlen_Button_RevivePet = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_RevivePet.." = " .. i);
				end
			elseif not ( Zorlen_Button_DismissPet ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_DismissPet)) ) then
				Zorlen_Button_DismissPet = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_DismissPet.." = " .. i);
				end
			elseif not ( Zorlen_Button_AutoShot ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_AutoShot)) ) then
				Zorlen_Button_AutoShot = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_AutoShot.." = " .. i);
				end
			elseif not ( Zorlen_Button_ArcaneShot ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_ArcaneShot)) ) then
				Zorlen_Button_ArcaneShot = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_ArcaneShot.." = " .. i);
				end
			elseif not ( Zorlen_Button_SerpentSting ) and (not text) and ( string.find(texture, "Ability_Hunter_Quickshot") ) then
				Zorlen_Button_SerpentSting = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_SerpentSting.." = " .. i);
				end
			elseif not ( Zorlen_Button_ViperSting ) and (not text) and ( string.find(texture, "Ability_Hunter_AimedShot") ) then
				Zorlen_Button_ViperSting = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_ViperSting.." = " .. i);
				end
			elseif not ( Zorlen_Button_ScorpidSting ) and (not text) and ( string.find(texture, "Ability_Hunter_CriticalShot") ) then
				Zorlen_Button_ScorpidSting = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_ScorpidSting.." = " .. i);
				end
			elseif not ( Zorlen_Button_DistractingShot ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_DistractingShot)) ) then
				Zorlen_Button_DistractingShot = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_DistractingShot.." = " .. i);
				end
			elseif not ( Zorlen_Button_AimedShot ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_AimedShot)) ) then
				Zorlen_Button_AimedShot = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_AimedShot.." = " .. i);
				end
			elseif not ( Zorlen_Button_HuntersMark ) and (not text) and ( string.find(texture, "Sniper") ) then
				Zorlen_Button_HuntersMark = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_HuntersMark.." = " .. i);
				end
			elseif not ( Zorlen_Button_AspectOfTheHawk ) and (not text) and ( string.find(texture, "Spell_Nature_RavenForm") ) then
				Zorlen_Button_AspectOfTheHawk = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_AspectOfTheHawk.." = " .. i);
				end
			elseif not ( Zorlen_Button_AspectOfTheCheetah ) and (not text) and ( string.find(texture, "Ability_Mount_JungleTiger") ) then
				Zorlen_Button_AspectOfTheCheetah = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_AspectOfTheCheetah.." = " .. i);
				end
			elseif not ( Zorlen_Button_AspectOfThePack ) and (not text) and ( string.find(texture, "Ability_Mount_WhiteTiger") ) then
				Zorlen_Button_AspectOfThePack = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_AspectOfThePack.." = " .. i);
				end
			elseif not ( Zorlen_Button_AspectOfTheWild ) and (not text) and ( string.find(texture, "Spell_Nature_ProtectionformNature") ) then
				Zorlen_Button_AspectOfTheWild = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_AspectOfTheWild.." = " .. i);
				end
			elseif not ( Zorlen_Button_AspectOfTheBeast ) and (not text) and ( string.find(texture, "Ability_Mount_PinkTiger") ) then
				Zorlen_Button_AspectOfTheBeast = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_AspectOfTheBeast.." = " .. i);
				end
			elseif not ( Zorlen_Button_FreezingTrap ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_FreezingTrap)) ) then
				Zorlen_Button_FreezingTrap = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_FreezingTrap.." = " .. i);
				end
			elseif not ( Zorlen_Button_FrostTrap ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_FrostTrap)) ) then
				Zorlen_Button_FrostTrap = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_FrostTrap.." = " .. i);
				end
			elseif not ( Zorlen_Button_ExplosiveTrap ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_ExplosiveTrap)) ) then
				Zorlen_Button_ExplosiveTrap = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_ExplosiveTrap.." = " .. i);
				end
			elseif not ( Zorlen_Button_ImmolationTrap ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_ImmolationTrap)) ) then
				Zorlen_Button_ImmolationTrap = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_ImmolationTrap.." = " .. i);
				end
			elseif not ( Zorlen_Button_FeignDeath ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_FeignDeath)) ) then
				Zorlen_Button_FeignDeath = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_FeignDeath.." = " .. i);
				end
			elseif not ( Zorlen_Button_TranquilizingShot ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_TranquilizingShot)) ) then
				Zorlen_Button_TranquilizingShot = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_TranquilizingShot.." = " .. i);
				end
			elseif not ( Zorlen_Button_Disengage ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_Disengage)) ) then
				Zorlen_Button_Disengage = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_Disengage.." = " .. i);
				end
			elseif not ( Zorlen_Button_EyesOfTheBeast ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_EyesOfTheBeast)) ) then
				Zorlen_Button_EyesOfTheBeast = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_EyesOfTheBeast.." = " .. i);
				end
			elseif not ( Zorlen_Button_BeastLore ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_BeastLore)) ) then
				Zorlen_Button_BeastLore = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_BeastLore.." = " .. i);
				end
			elseif not ( Zorlen_Button_BestialWrath ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_BestialWrath)) ) then
				Zorlen_Button_BestialWrath = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_BestialWrath.." = " .. i);
				end
			elseif not ( Zorlen_Button_TrueshotAura ) and (not text) and ( string.find(texture, "Ability_TrueShot") ) then
				Zorlen_Button_TrueshotAura = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_TrueshotAura.." = " .. i);
				end
			elseif not ( Zorlen_Button_ScatterShot ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_ScatterShot)) ) then
				Zorlen_Button_ScatterShot = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_ScatterShot.." = " .. i);
				end
			elseif not ( Zorlen_Button_WyvernSting ) and (not text) and ( string.find(texture, "INV_Spear_02") ) then
				Zorlen_Button_WyvernSting = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_WyvernSting.." = " .. i);
				end
			elseif not ( Zorlen_Button_Deterrence ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_Deterrence)) ) then
				Zorlen_Button_Deterrence = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_Deterrence.." = " .. i);
				end
			elseif not ( Zorlen_Button_EagleEye ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_EagleEye)) ) then
				Zorlen_Button_EagleEye = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_EagleEye.." = " .. i);
				end
			elseif not ( Zorlen_Button_RapidFire ) and (not text) and ( string.find(texture, "RunningShot") ) then
				Zorlen_Button_RapidFire = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_RapidFire.." = " .. i);
				end
			elseif not ( Zorlen_Button_MultiShot ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_MultiShot)) ) then
				Zorlen_Button_MultiShot = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_MultiShot.." = " .. i);
				end
			elseif not ( Zorlen_Button_Flare ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_Flare)) ) then
				Zorlen_Button_Flare = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_Flare.." = " .. i);
				end
			elseif not ( Zorlen_Button_ScareBeast ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_ScareBeast)) ) then
				Zorlen_Button_ScareBeast = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_ScareBeast.." = " .. i);
				end
			elseif not ( Zorlen_Button_Volley ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_Volley)) ) then
				Zorlen_Button_Volley = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_Volley.." = " .. i);
				end
			elseif not ( Zorlen_Button_Intimidation ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_Intimidation)) ) then
				Zorlen_Button_Intimidation = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_Intimidation.." = " .. i);
				end
			end
		end
	end
end



--[[
function Zorlen_RegisterMageButtons(option)
	Zorlen_Button_AmplifyMagic = nil;
	Zorlen_Button_ArcaneBrilliance = nil;
	Zorlen_Button_ArcaneExplosion = nil;
	Zorlen_Button_ArcaneIntellect = nil;
	Zorlen_Button_ArcaneMissiles = nil;
	Zorlen_Button_ArcanePower = nil;
	Zorlen_Button_BlastWave = nil;
	Zorlen_Button_Blink = nil;
	Zorlen_Button_Blizzard = nil;
	Zorlen_Button_ColdSnap = nil;
	Zorlen_Button_Combustion = nil;
	Zorlen_Button_ConeOfCold = nil;
	Zorlen_Button_ConjureFood = nil;
	Zorlen_Button_ConjureManaAgate = nil;
	Zorlen_Button_ConjureManaJade = nil;
	Zorlen_Button_ConjureManaCitrine = nil;
	Zorlen_Button_ConjureManaRuby = nil;
	Zorlen_Button_ConjureWater = nil;
	Zorlen_Button_Counterspell = nil;
	Zorlen_Button_DampenMagic = nil;
	Zorlen_Button_DetectMagic = nil;
	Zorlen_Button_Evocation = nil;
	Zorlen_Button_FireBlast = nil;
	Zorlen_Button_FireWard = nil;
	Zorlen_Button_Fireball = nil;
	Zorlen_Button_Flamestrike = nil;
	Zorlen_Button_FrostArmor = nil;
	Zorlen_Button_FrostNova = nil;
	Zorlen_Button_FrostWard = nil;
	Zorlen_Button_Frostbolt = nil;
	Zorlen_Button_IceArmor = nil;
	Zorlen_Button_IceBarrier = nil;
	Zorlen_Button_IceBlock = nil;
	Zorlen_Button_MageArmor = nil;
	Zorlen_Button_ManaShield = nil;
	Zorlen_Button_Polymorph = nil;
	Zorlen_Button_PortalDarnassus = nil;
	Zorlen_Button_PortalIronforge = nil;
	Zorlen_Button_PortalOrgrimmar = nil;
	Zorlen_Button_PortalStormwind = nil;
	Zorlen_Button_PortalThunderBluff = nil;
	Zorlen_Button_PortalUndercity = nil;
	Zorlen_Button_TeleportDarnassus = nil;
	Zorlen_Button_TeleportIronforge = nil;
	Zorlen_Button_TeleportOrgrimmar = nil;
	Zorlen_Button_TeleportStormwind = nil;
	Zorlen_Button_TeleportThunderBluff = nil;
	Zorlen_Button_TeleportUndercity = nil;
	Zorlen_Button_PresenceOfMind = nil;
	Zorlen_Button_Pyroblast = nil;
	Zorlen_Button_RemoveLesserCurse = nil;
	Zorlen_Button_Scorch = nil;
	Zorlen_Button_SlowFall = nil;
	for i = 1, 120 do
		if ( HasAction(i) ) then
		local texture = GetActionTexture(i);
		local text = GetActionText(i);
			if not ( Zorlen_Button_ ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_)) ) then
				Zorlen_Button_ = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_.." = " .. i);
				end
			elseif not ( Zorlen_Button_ ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_)) ) then
				Zorlen_Button_ = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_.." = " .. i);
				end
			end
		end
	end
end

--]]



--[[
function Zorlen_RegisterPaladinButtons(option)
	Zorlen_Button_BlessingOfFreedom = nil;
	Zorlen_Button_BlessingOfKings = nil;
	Zorlen_Button_BlessingOfLight = nil;
	Zorlen_Button_BlessingOfMight = nil;
	Zorlen_Button_BlessingOfProtection = nil;
	Zorlen_Button_BlessingOfSacrifice = nil;
	Zorlen_Button_BlessingOfSalvation = nil;
	Zorlen_Button_BlessingOfSanctuary = nil;
	Zorlen_Button_BlessingOfWisdom = nil;
	Zorlen_Button_Cleanse = nil;
	Zorlen_Button_ConcentrationAura = nil;
	Zorlen_Button_Consecration = nil;
	Zorlen_Button_DevotionAura = nil;
	Zorlen_Button_DivineFavor = nil;
	Zorlen_Button_DivineIntervention = nil;
	Zorlen_Button_DivineProtection = nil;
	Zorlen_Button_DivineShield = nil;
	Zorlen_Button_Exorcism = nil;
	Zorlen_Button_FireResistanceAura = nil;
	Zorlen_Button_FlashOfLight = nil;
	Zorlen_Button_FrostResistanceAura = nil;
	Zorlen_Button_GreaterBlessingOfKings = nil;
	Zorlen_Button_GreaterBlessingOfLight = nil;
	Zorlen_Button_GreaterBlessingOfMight = nil;
	Zorlen_Button_GreaterBlessingOfSalvation = nil;
	Zorlen_Button_GreaterBlessingOfSanctuary = nil;
	Zorlen_Button_GreaterBlessingOfWisdom = nil;
	Zorlen_Button_HammerOfJustice = nil;
	Zorlen_Button_HammerOfWrath = nil;
	Zorlen_Button_HolyLight = nil;
	Zorlen_Button_HolyShield = nil;
	Zorlen_Button_HolyShock = nil;
	Zorlen_Button_HolyWrath = nil;
	Zorlen_Button_Judgement = nil;
	Zorlen_Button_LayOnHands = nil;
	Zorlen_Button_Purify = nil;
	Zorlen_Button_Redemption = nil;
	Zorlen_Button_Repentance = nil;
	Zorlen_Button_RetributionAura = nil;
	Zorlen_Button_RighteousFury = nil;
	Zorlen_Button_SanctityAura = nil;
	Zorlen_Button_SealOfCommand = nil;
	Zorlen_Button_SealOfJustice = nil;
	Zorlen_Button_SealOfLight = nil;
	Zorlen_Button_SealOfRighteousness = nil;
	Zorlen_Button_SealOfWisdom = nil;
	Zorlen_Button_SealOfTheCrusader = nil;
	Zorlen_Button_ShadowResistanceAura = nil;
	Zorlen_Button_SummonCharger = nil;
	Zorlen_Button_SummonWarhorse = nil;
	Zorlen_Button_TurnUndead = nil;
	for i = 1, 120 do
		if ( HasAction(i) ) then
		local texture = GetActionTexture(i);
		local text = GetActionText(i);
			if not ( Zorlen_Button_ ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_)) ) then
				Zorlen_Button_ = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_.." = " .. i);
				end
			elseif not ( Zorlen_Button_ ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_)) ) then
				Zorlen_Button_ = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_.." = " .. i);
				end
			end
		end
	end
end
--]]



function Zorlen_RegisterPriestButtons(option)
	Zorlen_Button_AbolishDisease = nil;
	Zorlen_Button_CureDisease = nil;
	Zorlen_Button_DesperatePrayer = nil;
	Zorlen_Button_DevouringPlague = nil;
	Zorlen_Button_DispelMagic = nil;
	Zorlen_Button_DivineSpirit = nil;
	Zorlen_Button_ElunesGrace = nil;
	Zorlen_Button_Fade = nil;
	Zorlen_Button_FearWard = nil;
	Zorlen_Button_Feedback = nil;
	Zorlen_Button_FlashHeal = nil;
	Zorlen_Button_FocusedCasting = nil;
	Zorlen_Button_LesserHeal = nil;
	Zorlen_Button_Heal = nil;
	Zorlen_Button_GreaterHeal = nil;
	Zorlen_Button_HexOfWeakness = nil;
	Zorlen_Button_HolyFire = nil;
	Zorlen_Button_HolyNova = nil;
	Zorlen_Button_InnerFire = nil;
	Zorlen_Button_InnerFocus = nil;
	Zorlen_Button_Levitate = nil;
	Zorlen_Button_ManaBurn = nil;
	Zorlen_Button_MindBlast = nil;
	Zorlen_Button_MindControl = nil;
	Zorlen_Button_MindFlay = nil;
	Zorlen_Button_MindSoothe = nil;
	Zorlen_Button_MindVision = nil;
	Zorlen_Button_PowerWordFortitude = nil;
	Zorlen_Button_PowerWordShield = nil;
	Zorlen_Button_PrayerOfFortitude = nil;
	Zorlen_Button_PrayerOfHealing = nil;
	Zorlen_Button_PsychicScream = nil;
	Zorlen_Button_Renew = nil;
	Zorlen_Button_Resurrection = nil;
	Zorlen_Button_ShackleUndead = nil;
	Zorlen_Button_ShadowProtection = nil;
	Zorlen_Button_ShadowWordPain = nil;
	Zorlen_Button_Shadowform = nil;
	Zorlen_Button_Shadowguard = nil;
	Zorlen_Button_Silence = nil;
	Zorlen_Button_Smite = nil;
	Zorlen_Button_SpiritOfRedemption = nil;
	Zorlen_Button_Starshards = nil;
	Zorlen_Button_TouchOfWeakness = nil;
	Zorlen_Button_VampiricEmbrace = nil;
	for i = 1, 120 do
		if ( HasAction(i) ) then
		local texture = GetActionTexture(i);
		local text = GetActionText(i);
			if not ( Zorlen_Button_AbolishDisease ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_AbolishDisease)) ) then
				Zorlen_Button_AbolishDisease = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_AbolishDisease.." = " .. i);
				end
			elseif not ( Zorlen_Button_CureDisease ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_CureDisease)) ) then
				Zorlen_Button_CureDisease = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_CureDisease.." = " .. i);
				end
			elseif not ( Zorlen_Button_DesperatePrayer ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_DesperatePrayer)) ) then
				Zorlen_Button_DesperatePrayer = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_DesperatePrayer.." = " .. i);
				end
			elseif not ( Zorlen_Button_DevouringPlague ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_DevouringPlague)) ) then
				Zorlen_Button_DevouringPlague = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_DevouringPlague.." = " .. i);
				end
			elseif not ( Zorlen_Button_DispelMagic ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_DispelMagic)) ) then
				Zorlen_Button_DispelMagic = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_DispelMagic.." = " .. i);
				end
			elseif not ( Zorlen_Button_DivineSpirit ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_DivineSpirit)) ) then
				Zorlen_Button_DivineSpirit = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_DivineSpirit.." = " .. i);
				end
			elseif not ( Zorlen_Button_ElunesGrace ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_ElunesGrace)) ) then
				Zorlen_Button_ElunesGrace = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_ElunesGrace.." = " .. i);
				end
			elseif not ( Zorlen_Button_Fade ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_Fade)) ) then
				Zorlen_Button_Fade = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_Fade.." = " .. i);
				end
			elseif not ( Zorlen_Button_FearWard ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_FearWard)) ) then
				Zorlen_Button_FearWard = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_FearWard.." = " .. i);
				end
			elseif not ( Zorlen_Button_Feedback ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_Feedback)) ) then
				Zorlen_Button_Feedback = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_Feedback.." = " .. i);
				end
			elseif not ( Zorlen_Button_FlashHeal ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_FlashHeal)) ) then
				Zorlen_Button_FlashHeal = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_FlashHeal.." = " .. i);
				end
			elseif not ( Zorlen_Button_FocusedCasting ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_FocusedCasting)) ) then
				Zorlen_Button_FocusedCasting = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_FocusedCasting.." = " .. i);
				end
			elseif not ( Zorlen_Button_LesserHeal ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_LesserHeal)) ) then
				Zorlen_Button_LesserHeal = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_LesserHeal.." = " .. i);
				end
			elseif not ( Zorlen_Button_Heal ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_Heal)) ) then
				Zorlen_Button_Heal = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_Heal.." = " .. i);
				end
			elseif not ( Zorlen_Button_GreaterHeal ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_GreaterHeal)) ) then
				Zorlen_Button_GreaterHeal = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_GreaterHeal.." = " .. i);
				end
			elseif not ( Zorlen_Button_HexOfWeakness ) and (not text) and ( string.find(texture, "Spell_Shadow_FingerOfDeath") ) then
				Zorlen_Button_HexOfWeakness = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_HexOfWeakness.." = " .. i);
				end
			elseif not ( Zorlen_Button_HolyFire ) and (not text) and ( string.find(texture, "Spell_Holy_SearingLight") ) then
				Zorlen_Button_HolyFire = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_HolyFire.." = " .. i);
				end
			elseif not ( Zorlen_Button_HolyNova ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_HolyNova)) ) then
				Zorlen_Button_HolyNova = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_HolyNova.." = " .. i);
				end
			elseif not ( Zorlen_Button_InnerFire ) and (not text) and ( string.find(texture, "Holy_InnerFire") ) then
				Zorlen_Button_InnerFire = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_InnerFire.." = " .. i);
				end
			elseif not ( Zorlen_Button_InnerFocus ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_InnerFocus)) ) then
				Zorlen_Button_InnerFocus = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_InnerFocus.." = " .. i);
				end
			elseif not ( Zorlen_Button_Levitate ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_Levitate)) ) then
				Zorlen_Button_Levitate = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_Levitate.." = " .. i);
				end
			elseif not ( Zorlen_Button_ManaBurn ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_ManaBurn)) ) then
				Zorlen_Button_ManaBurn = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_ManaBurn.." = " .. i);
				end
			elseif not ( Zorlen_Button_MindBlast ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_MindBlast)) ) then
				Zorlen_Button_MindBlast = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_MindBlast.." = " .. i);
				end
			elseif not ( Zorlen_Button_MindControl ) and (not text) and ( string.find(texture, "Shadow_ShadowWordDominate") ) then
				Zorlen_Button_MindControl = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_MindControl.." = " .. i);
				end
			elseif not ( Zorlen_Button_MindFlay ) and (not text) and ( string.find(texture, "Spell_Shadow_SiphonMana") ) then
				Zorlen_Button_MindFlay = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_MindFlay.." = " .. i);
				end
			elseif not ( Zorlen_Button_MindSoothe ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_MindSoothe)) ) then
				Zorlen_Button_MindSoothe = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_MindSoothe.." = " .. i);
				end
			elseif not ( Zorlen_Button_MindVision ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_MindVision)) ) then
				Zorlen_Button_MindVision = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_MindVision.." = " .. i);
				end
			elseif not ( Zorlen_Button_PowerWordFortitude ) and (not text) and ( string.find(texture, "Holy_WordFortitude") ) then
				Zorlen_Button_PowerWordFortitude = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_PowerWordFortitude.." = " .. i);
				end
			elseif not ( Zorlen_Button_PowerWordShield ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_PowerWordShield)) ) then
				Zorlen_Button_PowerWordShield = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_PowerWordShield.." = " .. i);
				end
			elseif not ( Zorlen_Button_PrayerOfFortitude ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_PrayerOfFortitude)) ) then
				Zorlen_Button_PrayerOfFortitude = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_PrayerOfFortitude.." = " .. i);
				end
			elseif not ( Zorlen_Button_PrayerOfHealing ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_PrayerOfHealing)) ) then
				Zorlen_Button_PrayerOfHealing = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_PrayerOfHealing.." = " .. i);
				end
			elseif not ( Zorlen_Button_PsychicScream ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_PsychicScream)) ) then
				Zorlen_Button_PsychicScream = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_PsychicScream.." = " .. i);
				end
			elseif not ( Zorlen_Button_Renew ) and (not text) and ( string.find(texture, "Spell_Holy_Renew") ) then
				Zorlen_Button_Renew = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_Renew.." = " .. i);
				end
			elseif not ( Zorlen_Button_Resurrection ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_Resurrection)) ) then
				Zorlen_Button_Resurrection = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_Resurrection.." = " .. i);
				end
			elseif not ( Zorlen_Button_ShackleUndead ) and (not text) and ( string.find(texture, "Spell_Nature_Slow") ) then
				Zorlen_Button_ShackleUndead = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_ShackleUndead.." = " .. i);
				end
			elseif not ( Zorlen_Button_ShadowProtection ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_ShadowProtection)) ) then
				Zorlen_Button_ShadowProtection = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_ShadowProtection.." = " .. i);
				end
			elseif not ( Zorlen_Button_ShadowWordPain ) and (not text) and ( string.find(texture, "Shadow_ShadowWordPain") ) then
				Zorlen_Button_ShadowWordPain = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_ShadowWordPain.." = " .. i);
				end
			elseif not ( Zorlen_Button_Shadowform ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_Shadowform)) ) then
				Zorlen_Button_Shadowform = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_Shadowform.." = " .. i);
				end
			elseif not ( Zorlen_Button_Shadowguard ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_Shadowguard)) ) then
				Zorlen_Button_Shadowguard = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_Shadowguard.." = " .. i);
				end
			elseif not ( Zorlen_Button_Silence ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_Silence)) ) then
				Zorlen_Button_Silence = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_Silence.." = " .. i);
				end
			elseif not ( Zorlen_Button_Smite ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_Smite)) ) then
				Zorlen_Button_Smite = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_Smite.." = " .. i);
				end
			elseif not ( Zorlen_Button_SpiritOfRedemption ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_SpiritOfRedemption)) ) then
				Zorlen_Button_SpiritOfRedemption = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_SpiritOfRedemption.." = " .. i);
				end
			elseif not ( Zorlen_Button_Starshards ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_Starshards)) ) then
				Zorlen_Button_Starshards = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_Starshards.." = " .. i);
				end
			elseif not ( Zorlen_Button_TouchOfWeakness ) and (not text) and ( string.find(texture, "Spell_Shadow_DeadofNight") ) then
				Zorlen_Button_TouchOfWeakness = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_TouchOfWeakness.." = " .. i);
				end
			elseif not ( Zorlen_Button_VampiricEmbrace ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_VampiricEmbrace)) ) then
				Zorlen_Button_VampiricEmbrace = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_VampiricEmbrace.." = " .. i);
				end
			end
		end
	end
end



function Zorlen_RegisterRogueButtons(option)
	Zorlen_Button_CripplingPoison = nil;
	Zorlen_Button_CripplingPoisonII = nil;
	Zorlen_Button_DeadlyPoison = nil;
	Zorlen_Button_DeadlyPoisonII = nil;
	Zorlen_Button_DeadlyPoisonIII = nil;
	Zorlen_Button_DeadlyPoisonIV = nil;
	Zorlen_Button_DeadlyPoisonV = nil;
	Zorlen_Button_InstantPoison = nil;
	Zorlen_Button_InstantPoisonII = nil;
	Zorlen_Button_InstantPoisonIII = nil;
	Zorlen_Button_InstantPoisonIV = nil;
	Zorlen_Button_InstantPoisonV = nil;
	Zorlen_Button_InstantPoisonVI = nil;
	Zorlen_Button_MindnumbingPoison = nil;
	Zorlen_Button_MindnumbingPoisonII = nil;
	Zorlen_Button_MindnumbingPoisonIII = nil;
	Zorlen_Button_WoundPoison = nil;
	Zorlen_Button_WoundPoisonII = nil;
	Zorlen_Button_WoundPoisonIII = nil;
	Zorlen_Button_WoundPoisonIV = nil;
	Zorlen_Button_AdrenalineRush = nil;
	Zorlen_Button_Ambush = nil;
	Zorlen_Button_Backstab = nil;
	Zorlen_Button_BladeFlurry = nil;
	Zorlen_Button_Blind = nil;
	Zorlen_Button_BlindingPowder = nil;
	Zorlen_Button_CheapShot = nil;
	Zorlen_Button_ColdBlood = nil;
	Zorlen_Button_DetectTraps = nil;
	Zorlen_Button_DisarmTrap = nil;
	Zorlen_Button_Distract = nil;
	Zorlen_Button_Evasion = nil;
	Zorlen_Button_Eviscerate = nil;
	Zorlen_Button_ExposeArmor = nil;
	Zorlen_Button_Feint = nil;
	Zorlen_Button_Garrote = nil;
	Zorlen_Button_GhostlyStrike = nil;
	Zorlen_Button_Gouge = nil;
	Zorlen_Button_Hemorrhage = nil;
	Zorlen_Button_Kick = nil;
	Zorlen_Button_KidneyShot = nil;
	Zorlen_Button_PickLock = nil;
	Zorlen_Button_PickPocket = nil;
	Zorlen_Button_Premeditation = nil;
	Zorlen_Button_Preparation = nil;
	Zorlen_Button_RelentlessStrikes = nil;
	Zorlen_Button_Riposte = nil;
	Zorlen_Button_Rupture = nil;
	Zorlen_Button_Sap = nil;
	Zorlen_Button_SinisterStrike = nil;
	Zorlen_Button_SliceAndDice = nil;
	Zorlen_Button_Sprint = nil;
	Zorlen_Button_Stealth = nil;
	Zorlen_Button_Vanish = nil;
	for i = 1, 120 do
		if ( HasAction(i) ) then
		local texture = GetActionTexture(i);
		local text = GetActionText(i);
			if not ( Zorlen_Button_CripplingPoison ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_CripplingPoison)) ) then
				Zorlen_Button_CripplingPoison = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_CripplingPoison.." = " .. i);
				end
			elseif not ( Zorlen_Button_CripplingPoisonII ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_CripplingPoisonII)) ) then
				Zorlen_Button_CripplingPoisonII = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_CripplingPoisonII.." = " .. i);
				end
			elseif not ( Zorlen_Button_DeadlyPoison ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_DeadlyPoison)) ) then
				Zorlen_Button_DeadlyPoison = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_DeadlyPoison.." = " .. i);
				end
			elseif not ( Zorlen_Button_DeadlyPoisonII ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_DeadlyPoisonII)) ) then
				Zorlen_Button_DeadlyPoisonII = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_DeadlyPoisonII.." = " .. i);
				end
			elseif not ( Zorlen_Button_DeadlyPoisonIII ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_DeadlyPoisonIII)) ) then
				Zorlen_Button_DeadlyPoisonIII = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_DeadlyPoisonIII.." = " .. i);
				end
			elseif not ( Zorlen_Button_DeadlyPoisonIV ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_DeadlyPoisonIV)) ) then
				Zorlen_Button_DeadlyPoisonIV = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_DeadlyPoisonIV.." = " .. i);
				end
			elseif not ( Zorlen_Button_DeadlyPoisonV ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_DeadlyPoisonV)) ) then
				Zorlen_Button_DeadlyPoisonV = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_DeadlyPoisonV.." = " .. i);
				end
			elseif not ( Zorlen_Button_InstantPoison ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_InstantPoison)) ) then
				Zorlen_Button_InstantPoison = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_InstantPoison.." = " .. i);
				end
			elseif not ( Zorlen_Button_InstantPoisonII ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_InstantPoisonII)) ) then
				Zorlen_Button_InstantPoisonII = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_InstantPoisonII.." = " .. i);
				end
			elseif not ( Zorlen_Button_InstantPoisonIII ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_InstantPoisonIII)) ) then
				Zorlen_Button_InstantPoisonIII = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_InstantPoisonIII.." = " .. i);
				end
			elseif not ( Zorlen_Button_InstantPoisonIV ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_InstantPoisonIV)) ) then
				Zorlen_Button_InstantPoisonIV = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_InstantPoisonIV.." = " .. i);
				end
			elseif not ( Zorlen_Button_InstantPoisonV ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_InstantPoisonV)) ) then
				Zorlen_Button_InstantPoisonV = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_InstantPoisonV.." = " .. i);
				end
			elseif not ( Zorlen_Button_InstantPoisonVI ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_InstantPoisonVI)) ) then
				Zorlen_Button_InstantPoisonVI = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_InstantPoisonVI.." = " .. i);
				end
			elseif not ( Zorlen_Button_MindnumbingPoison ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_MindnumbingPoison)) ) then
				Zorlen_Button_MindnumbingPoison = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_MindnumbingPoison.." = " .. i);
				end
			elseif not ( Zorlen_Button_MindnumbingPoisonII ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_MindnumbingPoisonII)) ) then
				Zorlen_Button_MindnumbingPoisonII = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_MindnumbingPoisonII.." = " .. i);
				end
			elseif not ( Zorlen_Button_MindnumbingPoisonIII ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_MindnumbingPoisonIII)) ) then
				Zorlen_Button_MindnumbingPoisonIII = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_MindnumbingPoisonIII.." = " .. i);
				end
			elseif not ( Zorlen_Button_WoundPoison ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_WoundPoison)) ) then
				Zorlen_Button_WoundPoison = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_WoundPoison.." = " .. i);
				end
			elseif not ( Zorlen_Button_WoundPoisonII ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_WoundPoisonII)) ) then
				Zorlen_Button_WoundPoisonII = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_WoundPoisonII.." = " .. i);
				end
			elseif not ( Zorlen_Button_WoundPoisonIII ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_WoundPoisonIII)) ) then
				Zorlen_Button_WoundPoisonIII = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_WoundPoisonIII.." = " .. i);
				end
			elseif not ( Zorlen_Button_WoundPoisonIV ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_WoundPoisonIV)) ) then
				Zorlen_Button_WoundPoisonIV = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_WoundPoisonIV.." = " .. i);
				end
			elseif not ( Zorlen_Button_AdrenalineRush ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_AdrenalineRush)) ) then
				Zorlen_Button_AdrenalineRush = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_AdrenalineRush.." = " .. i);
				end
			elseif not ( Zorlen_Button_Ambush ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_Ambush)) ) then
				Zorlen_Button_Ambush = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_Ambush.." = " .. i);
				end
			elseif not ( Zorlen_Button_Backstab ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_Backstab)) ) then
				Zorlen_Button_Backstab = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_Backstab.." = " .. i);
				end
			elseif not ( Zorlen_Button_BladeFlurry ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_BladeFlurry)) ) then
				Zorlen_Button_BladeFlurry = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_BladeFlurry.." = " .. i);
				end
			elseif not ( Zorlen_Button_Blind ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_Blind)) ) then
				Zorlen_Button_Blind = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_Blind.." = " .. i);
				end
			elseif not ( Zorlen_Button_BlindingPowder ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_BlindingPowder)) ) then
				Zorlen_Button_BlindingPowder = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_BlindingPowder.." = " .. i);
				end
			elseif not ( Zorlen_Button_CheapShot ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_CheapShot)) ) then
				Zorlen_Button_CheapShot = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_CheapShot.." = " .. i);
				end
			elseif not ( Zorlen_Button_ColdBlood ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_ColdBlood)) ) then
				Zorlen_Button_ColdBlood = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_ColdBlood.." = " .. i);
				end
			elseif not ( Zorlen_Button_DetectTraps ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_DetectTraps)) ) then
				Zorlen_Button_DetectTraps = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_DetectTraps.." = " .. i);
				end
			elseif not ( Zorlen_Button_DisarmTrap ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_DisarmTrap)) ) then
				Zorlen_Button_DisarmTrap = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_DisarmTrap.." = " .. i);
				end
			elseif not ( Zorlen_Button_Distract ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_Distract)) ) then
				Zorlen_Button_Distract = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_Distract.." = " .. i);
				end
			elseif not ( Zorlen_Button_Evasion ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_Evasion)) ) then
				Zorlen_Button_Evasion = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_Evasion.." = " .. i);
				end
			elseif not ( Zorlen_Button_Eviscerate ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_Eviscerate)) ) then
				Zorlen_Button_Eviscerate = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_Eviscerate.." = " .. i);
				end
			elseif not ( Zorlen_Button_ExposeArmor ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_ExposeArmor)) ) then
				Zorlen_Button_ExposeArmor = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_ExposeArmor.." = " .. i);
				end
			elseif not ( Zorlen_Button_Feint ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_Feint)) ) then
				Zorlen_Button_Feint = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_Feint.." = " .. i);
				end
			elseif not ( Zorlen_Button_Garrote ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_Garrote)) ) then
				Zorlen_Button_Garrote = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_Garrote.." = " .. i);
				end
			elseif not ( Zorlen_Button_GhostlyStrike ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_GhostlyStrike)) ) then
				Zorlen_Button_GhostlyStrike = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_GhostlyStrike.." = " .. i);
				end
			elseif not ( Zorlen_Button_Gouge ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_Gouge)) ) then
				Zorlen_Button_Gouge = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_Gouge.." = " .. i);
				end
			elseif not ( Zorlen_Button_Hemorrhage ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_Hemorrhage)) ) then
				Zorlen_Button_Hemorrhage = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_Hemorrhage.." = " .. i);
				end
			elseif not ( Zorlen_Button_Kick ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_Kick)) ) then
				Zorlen_Button_Kick = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_Kick.." = " .. i);
				end
			elseif not ( Zorlen_Button_KidneyShot ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_KidneyShot)) ) then
				Zorlen_Button_KidneyShot = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_KidneyShot.." = " .. i);
				end
			elseif not ( Zorlen_Button_PickLock ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_PickLock)) ) then
				Zorlen_Button_PickLock = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_PickLock.." = " .. i);
				end
			elseif not ( Zorlen_Button_PickPocket ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_PickPocket)) ) then
				Zorlen_Button_PickPocket = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_PickPocket.." = " .. i);
				end
			elseif not ( Zorlen_Button_Premeditation ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_Premeditation)) ) then
				Zorlen_Button_Premeditation = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_Premeditation.." = " .. i);
				end
			elseif not ( Zorlen_Button_Preparation ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_Preparation)) ) then
				Zorlen_Button_Preparation = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_Preparation.." = " .. i);
				end
			elseif not ( Zorlen_Button_RelentlessStrikes ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_RelentlessStrikes)) ) then
				Zorlen_Button_RelentlessStrikes = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_RelentlessStrikes.." = " .. i);
				end
			elseif not ( Zorlen_Button_Riposte ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_Riposte)) ) then
				Zorlen_Button_Riposte = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_Riposte.." = " .. i);
				end
			elseif not ( Zorlen_Button_Rupture ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_Rupture)) ) then
				Zorlen_Button_Rupture = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_Rupture.." = " .. i);
				end
			elseif not ( Zorlen_Button_Sap ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_Sap)) ) then
				Zorlen_Button_Sap = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_Sap.." = " .. i);
				end
			elseif not ( Zorlen_Button_SinisterStrike ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_SinisterStrike)) ) then
				Zorlen_Button_SinisterStrike = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_SinisterStrike.." = " .. i);
				end
			elseif not ( Zorlen_Button_SliceAndDice ) and (not text) and ( string.find(texture, "Ability_Rogue_SliceDice") ) then
				Zorlen_Button_SliceAndDice = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_SliceAndDice.." = " .. i);
				end
			elseif not ( Zorlen_Button_Sprint ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_Sprint)) ) then
				Zorlen_Button_Sprint = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_Sprint.." = " .. i);
				end
			elseif not ( Zorlen_Button_Stealth ) and (not text) and ( string.find(texture, "Ability_Stealth") ) then
				Zorlen_Button_Stealth = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_Stealth.." = " .. i);
				end
			elseif not ( Zorlen_Button_Vanish ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_Vanish)) ) then
				Zorlen_Button_Vanish = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_Vanish.." = " .. i);
				end
			end
		end
	end
end



--[[
function Zorlen_RegisterShamanButtons(option)
	Zorlen_Button_DiseaseCleansingTotem = nil;
	Zorlen_Button_EarthbindTotem = nil;
	Zorlen_Button_FireNovaTotem = nil;
	Zorlen_Button_FireResistanceTotem = nil;
	Zorlen_Button_FlametongueTotem = nil;
	Zorlen_Button_FrostResistanceTotem = nil;
	Zorlen_Button_GraceOfAirTotem = nil;
	Zorlen_Button_GroundingTotem = nil;
	Zorlen_Button_HealingStreamTotem = nil;
	Zorlen_Button_MagmaTotem = nil;
	Zorlen_Button_ManaSpringTotem = nil;
	Zorlen_Button_ManaTideTotem = nil;
	Zorlen_Button_NatureResistanceTotem = nil;
	Zorlen_Button_PoisonCleansingTotem = nil;
	Zorlen_Button_SearingTotem = nil;
	Zorlen_Button_SentryTotem = nil;
	Zorlen_Button_StoneclawTotem = nil;
	Zorlen_Button_StoneskinTotem = nil;
	Zorlen_Button_StrengthOfEarthTotem = nil;
	Zorlen_Button_TremorTotem = nil;
	Zorlen_Button_WindfuryTotem = nil;
	Zorlen_Button_WindwallTotem = nil;
	Zorlen_Button_EarthShock = nil;
	Zorlen_Button_FlameShock = nil;
	Zorlen_Button_FrostShock = nil;
	Zorlen_Button_FlametongueWeapon = nil;
	Zorlen_Button_FrostbrandWeapon = nil;
	Zorlen_Button_RockbiterWeapon = nil;
	Zorlen_Button_WindfuryWeapon = nil;
	Zorlen_Button_AncestralSpirit = nil;
	Zorlen_Button_AstralRecall = nil;
	Zorlen_Button_ChainHeal = nil;
	Zorlen_Button_ChainLightning = nil;
	Zorlen_Button_CureDisease = nil;
	Zorlen_Button_CurePoison = nil;
	Zorlen_Button_ElementalFocus = nil;
	Zorlen_Button_ElementalMastery = nil;
	Zorlen_Button_FarSight = nil;
	Zorlen_Button_GhostWolf = nil;
	Zorlen_Button_LesserHealingWave = nil;
	Zorlen_Button_HealingWave = nil;
	Zorlen_Button_LightningBolt = nil;
	Zorlen_Button_LightningShield = nil;
	Zorlen_Button_NaturesSwiftness = nil;
	Zorlen_Button_Purge = nil;
	Zorlen_Button_Reincarnation = nil;
	Zorlen_Button_Stormstrike = nil;
	Zorlen_Button_WaterBreathing = nil;
	Zorlen_Button_WaterWalking = nil;
	for i = 1, 120 do
		if ( HasAction(i) ) then
		local texture = GetActionTexture(i);
		local text = GetActionText(i);
			if not ( Zorlen_Button_ ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_)) ) then
				Zorlen_Button_ = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_.." = " .. i);
				end
			elseif not ( Zorlen_Button_ ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_)) ) then
				Zorlen_Button_ = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_.." = " .. i);
				end
			end
		end
	end
end
--]]



function Zorlen_RegisterWarlockButtons(option)
	Zorlen_Button_AmplifyCurse = nil;
	Zorlen_Button_CurseOfAgony = nil;
	Zorlen_Button_CurseOfDoom = nil;
	Zorlen_Button_CurseOfShadow = nil;
	Zorlen_Button_CurseOfTheElements = nil;
	Zorlen_Button_CurseOfWeakness = nil;
	Zorlen_Button_CurseOfExhaustion = nil;
	Zorlen_Button_CurseOfRecklessness = nil;
	Zorlen_Button_CurseOfTongues = nil;
	Zorlen_Button_Corruption = nil;
	Zorlen_Button_Immolate = nil;
	Zorlen_Button_SiphonLife = nil;
	Zorlen_Button_DrainLife = nil;
	Zorlen_Button_DrainMana = nil;
	Zorlen_Button_Hellfire = nil;
	Zorlen_Button_RainOfFire = nil;
	Zorlen_Button_DrainSoul = nil;
	Zorlen_Button_LifeTap = nil;
	Zorlen_Button_DarkPact = nil;
	Zorlen_Button_ShadowBolt = nil;
	Zorlen_Button_Banish = nil;
	Zorlen_Button_Conflagrate = nil;
	Zorlen_Button_CreateFirestoneLesser = nil;
	Zorlen_Button_CreateFirestone = nil;
	Zorlen_Button_CreateFirestoneGreater = nil;
	Zorlen_Button_CreateFirestoneMajor = nil;
	Zorlen_Button_CreateHealthstoneMinor = nil;
	Zorlen_Button_CreateHealthstoneLesser = nil;
	Zorlen_Button_CreateHealthstone = nil;
	Zorlen_Button_CreateHealthstoneGreater = nil;
	Zorlen_Button_CreateHealthstoneMajor = nil;
	Zorlen_Button_CreateSoulstoneMinor = nil;
	Zorlen_Button_CreateSoulstoneLesser = nil;
	Zorlen_Button_CreateSoulstone = nil;
	Zorlen_Button_CreateSoulstoneGreater = nil;
	Zorlen_Button_CreateSoulstoneMajor = nil;
	Zorlen_Button_CreateSpellstone = nil;
	Zorlen_Button_CreateSpellstoneGreater = nil;
	Zorlen_Button_CreateSpellstoneMajor = nil;
	Zorlen_Button_DeathCoil = nil;
	Zorlen_Button_DemonArmor = nil;
	Zorlen_Button_DemonSkin = nil;
	Zorlen_Button_DemonicSacrifice = nil;
	Zorlen_Button_DetectLesserInvisibility = nil;
	Zorlen_Button_DetectInvisibility = nil;
	Zorlen_Button_DetectGreaterInvisibility = nil;
	Zorlen_Button_EnslaveDemon = nil;
	Zorlen_Button_Fear = nil;
	Zorlen_Button_FelDomination = nil;
	Zorlen_Button_HealthFunnel = nil;
	Zorlen_Button_HowlOfTerror = nil;
	Zorlen_Button_Inferno = nil;
	Zorlen_Button_SearingPain = nil;
	Zorlen_Button_ShadowWard = nil;
	Zorlen_Button_Shadowburn = nil;
	Zorlen_Button_SoulFire = nil;
	Zorlen_Button_SoulLink = nil;
	Zorlen_Button_UnendingBreath = nil;
	for i = 1, 120 do
		if ( HasAction(i) ) then
		local texture = GetActionTexture(i);
		local text = GetActionText(i);
			if not ( Zorlen_Button_AmplifyCurse ) and (not text) and ( string.find(texture, "Spell_Shadow_Contagion") ) then
				Zorlen_Button_AmplifyCurse = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_AmplifyCurse.." = " .. i);
				end
			elseif not ( Zorlen_Button_CurseOfAgony ) and (not text) and ( string.find(texture, "Spell_Shadow_CurseOfSargeras") ) then
				Zorlen_Button_CurseOfAgony = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_CurseOfAgony.." = " .. i);
				end
			elseif not ( Zorlen_Button_CurseOfDoom ) and (not text) and ( string.find(texture, "Spell_Shadow_AuraOfDarkness") ) then
				Zorlen_Button_CurseOfDoom = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_CurseOfDoom.." = " .. i);
				end
			elseif not ( Zorlen_Button_CurseOfShadow ) and (not text) and ( string.find(texture, "Spell_Shadow_CurseOfAchimonde") ) then
				Zorlen_Button_CurseOfShadow = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_CurseOfShadow.." = " .. i);
				end
			elseif not ( Zorlen_Button_CurseOfTheElements ) and (not text) and ( string.find(texture, "Spell_Shadow_ChillTouch") ) then
				Zorlen_Button_CurseOfTheElements = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_CurseOfTheElements.." = " .. i);
				end
			elseif not ( Zorlen_Button_CurseOfWeakness ) and (not text) and ( string.find(texture, "Spell_Shadow_CurseOfMannoroth") ) then
				Zorlen_Button_CurseOfWeakness = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_CurseOfWeakness.." = " .. i);
				end
			elseif not ( Zorlen_Button_CurseOfExhaustion ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_CurseOfExhaustion)) ) then
				Zorlen_Button_CurseOfExhaustion = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_CurseOfExhaustion.." = " .. i);
				end
			elseif not ( Zorlen_Button_CurseOfRecklessness ) and (not text) and ( string.find(texture, "Spell_Shadow_UnholyStrength") ) then
				Zorlen_Button_CurseOfRecklessness = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_CurseOfRecklessness.." = " .. i);
				end
			elseif not ( Zorlen_Button_CurseOfTongues ) and (not text) and ( string.find(texture, "Spell_Shadow_CurseOfTounges") ) then
				Zorlen_Button_CurseOfTongues = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_CurseOfTongues.." = " .. i);
				end
			elseif not ( Zorlen_Button_Corruption ) and (not text) and ( string.find(texture, "Spell_Shadow_AbominationExplosion") ) then
				Zorlen_Button_Corruption = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_Corruption.." = " .. i);
				end
			elseif not ( Zorlen_Button_Immolate ) and (not text) and ( string.find(texture, "Spell_Fire_Immolation") ) then
				Zorlen_Button_Immolate = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_Immolate.." = " .. i);
				end
			elseif not ( Zorlen_Button_SiphonLife ) and (not text) and ( string.find(texture, "Spell_Shadow_Requiem") ) then
				Zorlen_Button_SiphonLife = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_SiphonLife.." = " .. i);
				end
			elseif not ( Zorlen_Button_DrainLife ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_DrainLife)) ) then
				Zorlen_Button_DrainLife = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_DrainLife.." = " .. i);
				end
			elseif not ( Zorlen_Button_DrainMana ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_DrainMana)) ) then
				Zorlen_Button_DrainMana = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_DrainMana.." = " .. i);
				end
			elseif not ( Zorlen_Button_Hellfire ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_Hellfire)) ) then
				Zorlen_Button_Hellfire = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_Hellfire.." = " .. i);
				end
			elseif not ( Zorlen_Button_RainOfFire ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_RainOfFire)) ) then
				Zorlen_Button_RainOfFire = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_RainOfFire.." = " .. i);
				end
			elseif not ( Zorlen_Button_DrainSoul ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_DrainSoul)) ) then
				Zorlen_Button_DrainSoul = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_DrainSoul.." = " .. i);
				end
			elseif not ( Zorlen_Button_LifeTap ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_LifeTap)) ) then
				Zorlen_Button_LifeTap = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_LifeTap.." = " .. i);
				end
			elseif not ( Zorlen_Button_DarkPact ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_DarkPact)) ) then
				Zorlen_Button_DarkPact = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_DarkPact.." = " .. i);
				end
			elseif not ( Zorlen_Button_ShadowBolt ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_ShadowBolt)) ) then
				Zorlen_Button_ShadowBolt = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_ShadowBolt.." = " .. i);
				end
			elseif not ( Zorlen_Button_Banish ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_Banish)) ) then
				Zorlen_Button_Banish = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_Banish.." = " .. i);
				end
			elseif not ( Zorlen_Button_Conflagrate ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_Conflagrate)) ) then
				Zorlen_Button_Conflagrate = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_Conflagrate.." = " .. i);
				end
			elseif not ( Zorlen_Button_CreateFirestoneLesser ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_CreateFirestoneLesser)) ) then
				Zorlen_Button_CreateFirestoneLesser = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_CreateFirestoneLesser.." = " .. i);
				end
			elseif not ( Zorlen_Button_CreateFirestone ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_CreateFirestone)) ) then
				Zorlen_Button_CreateFirestone = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_CreateFirestone.." = " .. i);
				end
			elseif not ( Zorlen_Button_CreateFirestoneGreater ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_CreateFirestoneGreater)) ) then
				Zorlen_Button_CreateFirestoneGreater = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_CreateFirestoneGreater.." = " .. i);
				end
			elseif not ( Zorlen_Button_CreateFirestoneMajor ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_CreateFirestoneMajor)) ) then
				Zorlen_Button_CreateFirestoneMajor = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_CreateFirestoneMajor.." = " .. i);
				end
			elseif not ( Zorlen_Button_CreateHealthstoneMinor ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_CreateHealthstoneMinor)) ) then
				Zorlen_Button_CreateHealthstoneMinor = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_CreateHealthstoneMinor.." = " .. i);
				end
			elseif not ( Zorlen_Button_CreateHealthstoneLesser ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_CreateHealthstoneLesser)) ) then
				Zorlen_Button_CreateHealthstoneLesser = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_CreateHealthstoneLesser.." = " .. i);
				end
			elseif not ( Zorlen_Button_CreateHealthstone ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_CreateHealthstone)) ) then
				Zorlen_Button_CreateHealthstone = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_CreateHealthstone.." = " .. i);
				end
			elseif not ( Zorlen_Button_CreateHealthstoneGreater ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_CreateHealthstoneGreater)) ) then
				Zorlen_Button_CreateHealthstoneGreater = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_CreateHealthstoneGreater.." = " .. i);
				end
			elseif not ( Zorlen_Button_CreateHealthstoneMajor ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_CreateHealthstoneMajor)) ) then
				Zorlen_Button_CreateHealthstoneMajor = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_CreateHealthstoneMajor.." = " .. i);
				end
			elseif not ( Zorlen_Button_CreateSoulstoneMinor ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_CreateSoulstoneMinor)) ) then
				Zorlen_Button_CreateSoulstoneMinor = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_CreateSoulstoneMinor.." = " .. i);
				end
			elseif not ( Zorlen_Button_CreateSoulstoneLesser ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_CreateSoulstoneLesser)) ) then
				Zorlen_Button_CreateSoulstoneLesser = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_CreateSoulstoneLesser.." = " .. i);
				end
			elseif not ( Zorlen_Button_CreateSoulstone ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_CreateSoulstone)) ) then
				Zorlen_Button_CreateSoulstone = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_CreateSoulstone.." = " .. i);
				end
			elseif not ( Zorlen_Button_CreateSoulstoneGreater ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_CreateSoulstoneGreater)) ) then
				Zorlen_Button_CreateSoulstoneGreater = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_CreateSoulstoneGreater.." = " .. i);
				end
			elseif not ( Zorlen_Button_CreateSoulstoneMajor ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_CreateSoulstoneMajor)) ) then
				Zorlen_Button_CreateSoulstoneMajor = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_CreateSoulstoneMajor.." = " .. i);
				end
			elseif not ( Zorlen_Button_CreateSpellstone ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_CreateSpellstone)) ) then
				Zorlen_Button_CreateSpellstone = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_CreateSpellstone.." = " .. i);
				end
			elseif not ( Zorlen_Button_CreateSpellstoneGreater ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_CreateSpellstoneGreater)) ) then
				Zorlen_Button_CreateSpellstoneGreater = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_CreateSpellstoneGreater.." = " .. i);
				end
			elseif not ( Zorlen_Button_CreateSpellstoneMajor ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_CreateSpellstoneMajor)) ) then
				Zorlen_Button_CreateSpellstoneMajor = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_CreateSpellstoneMajor.." = " .. i);
				end
			elseif not ( Zorlen_Button_DeathCoil ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_DeathCoil)) ) then
				Zorlen_Button_DeathCoil = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_DeathCoil.." = " .. i);
				end
			elseif not ( Zorlen_Button_DemonArmor ) and (not text) and ( string.find(texture, "Spell_Shadow_RagingScream") ) then
				Zorlen_Button_DemonArmor = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_DemonArmor.." = " .. i);
				end
			elseif not ( Zorlen_Button_DemonArmor ) and not ( Zorlen_Button_DemonSkin ) and (not text) and ( string.find(texture, "Spell_Shadow_RagingScream") ) then
				Zorlen_Button_DemonSkin = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_DemonSkin.." = " .. i);
				end
			elseif not ( Zorlen_Button_DemonicSacrifice ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_DemonicSacrifice)) ) then
				Zorlen_Button_DemonicSacrifice = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_DemonicSacrifice.." = " .. i);
				end
			elseif not ( Zorlen_Button_DetectLesserInvisibility ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_DetectLesserInvisibility)) ) then
				Zorlen_Button_DetectLesserInvisibility = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_DetectLesserInvisibility.." = " .. i);
				end
			elseif not ( Zorlen_Button_DetectInvisibility ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_DetectInvisibility)) ) then
				Zorlen_Button_DetectInvisibility = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_DetectInvisibility.." = " .. i);
				end
			elseif not ( Zorlen_Button_DetectGreaterInvisibility ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_DetectGreaterInvisibility)) ) then
				Zorlen_Button_DetectGreaterInvisibility = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_DetectGreaterInvisibility.." = " .. i);
				end
			elseif not ( Zorlen_Button_EnslaveDemon ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_EnslaveDemon)) ) then
				Zorlen_Button_EnslaveDemon = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_EnslaveDemon.." = " .. i);
				end
			elseif not ( Zorlen_Button_EyeOfKilrogg ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_EyeOfKilrogg)) ) then
				Zorlen_Button_EyeOfKilrogg = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_EyeOfKilrogg.." = " .. i);
				end
			elseif not ( Zorlen_Button_Fear ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_Fear)) ) then
				Zorlen_Button_Fear = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_Fear.." = " .. i);
				end
			elseif not ( Zorlen_Button_FelDomination ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_FelDomination)) ) then
				Zorlen_Button_FelDomination = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_FelDomination.." = " .. i);
				end
			elseif not ( Zorlen_Button_HealthFunnel ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_HealthFunnel)) ) then
				Zorlen_Button_HealthFunnel = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_HealthFunnel.." = " .. i);
				end
			elseif not ( Zorlen_Button_HowlOfTerror ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_HowlOfTerror)) ) then
				Zorlen_Button_HowlOfTerror = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_HowlOfTerror.." = " .. i);
				end
			elseif not ( Zorlen_Button_Inferno ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_Inferno)) ) then
				Zorlen_Button_Inferno = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_Inferno.." = " .. i);
				end
			elseif not ( Zorlen_Button_RitualOfDoom ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_RitualOfDoom)) ) then
				Zorlen_Button_RitualOfDoom = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_RitualOfDoom.." = " .. i);
				end
			elseif not ( Zorlen_Button_RitualOfSummoning ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_RitualOfSummoning)) ) then
				Zorlen_Button_RitualOfSummoning = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_RitualOfSummoning.." = " .. i);
				end
			elseif not ( Zorlen_Button_SearingPain ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_SearingPain)) ) then
				Zorlen_Button_SearingPain = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_SearingPain.." = " .. i);
				end
			elseif not ( Zorlen_Button_ShadowWard ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_ShadowWard)) ) then
				Zorlen_Button_ShadowWard = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_ShadowWard.." = " .. i);
				end
			elseif not ( Zorlen_Button_Shadowburn ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_Shadowburn)) ) then
				Zorlen_Button_Shadowburn = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_Shadowburn.." = " .. i);
				end
			elseif not ( Zorlen_Button_SoulFire ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_SoulFire)) ) then
				Zorlen_Button_SoulFire = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_SoulFire.." = " .. i);
				end
			elseif not ( Zorlen_Button_SoulLink ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_SoulLink)) ) then
				Zorlen_Button_SoulLink = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_SoulLink.." = " .. i);
				end
			elseif not ( Zorlen_Button_SummonDreadsteed ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_SummonDreadsteed)) ) then
				Zorlen_Button_SummonDreadsteed = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_SummonDreadsteed.." = " .. i);
				end
			elseif not ( Zorlen_Button_SummonFelhunter ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_SummonFelhunter)) ) then
				Zorlen_Button_SummonFelhunter = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_SummonFelhunter.." = " .. i);
				end
			elseif not ( Zorlen_Button_SummonFelsteed ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_SummonFelsteed)) ) then
				Zorlen_Button_SummonFelsteed = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_SummonFelsteed.." = " .. i);
				end
			elseif not ( Zorlen_Button_SummonImp ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_SummonImp)) ) then
				Zorlen_Button_SummonImp = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_SummonImp.." = " .. i);
				end
			elseif not ( Zorlen_Button_SummonSuccubus ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_SummonSuccubus)) ) then
				Zorlen_Button_SummonSuccubus = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_SummonSuccubus.." = " .. i);
				end
			elseif not ( Zorlen_Button_SummonVoidwalker ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_SummonVoidwalker)) ) then
				Zorlen_Button_SummonVoidwalker = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_SummonVoidwalker.." = " .. i);
				end
			elseif not ( Zorlen_Button_UnendingBreath ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_UnendingBreath)) ) then
				Zorlen_Button_UnendingBreath = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_UnendingBreath.." = " .. i);
				end
			end
		end
	end
end



function Zorlen_RegisterWarriorButtons(option)
	Zorlen_Button_Execute = nil;
	Zorlen_Button_HeroicStrike = nil;
	Zorlen_Button_SunderArmor = nil;
	Zorlen_Button_ThunderClap = nil;
	Zorlen_Button_MortalStrike = nil;
	Zorlen_Button_Bloodthirst = nil;
	Zorlen_Button_ShieldSlam = nil;
	Zorlen_Button_Charge = nil;
	Zorlen_Button_Taunt = nil;
	Zorlen_Button_Intercept = nil;
	Zorlen_Button_Overpower = nil;
	Zorlen_Button_Revenge = nil;
	Zorlen_Button_Rend = nil;
	Zorlen_Button_Hamstring = nil;
	Zorlen_Button_ShieldBash = nil;
	Zorlen_Button_Pummel = nil;
	Zorlen_Button_ShieldBlock = nil;
	Zorlen_Button_DemoralizingShout = nil;
	Zorlen_Button_BattleShout = nil;
	Zorlen_Button_BerserkerRage = nil;
	Zorlen_Button_Bloodrage = nil;
	Zorlen_Button_ChallengingShout = nil;
	Zorlen_Button_Cleave = nil;
	Zorlen_Button_ConcussionBlow = nil;
	Zorlen_Button_DeathWish = nil;
	Zorlen_Button_Disarm = nil;
	Zorlen_Button_IntimidatingShout = nil;
	Zorlen_Button_LastStand = nil;
	Zorlen_Button_MockingBlow = nil;
	Zorlen_Button_PiercingHowl = nil;
	Zorlen_Button_Recklessness = nil;
	Zorlen_Button_Retaliation = nil;
	Zorlen_Button_ShieldWall = nil;
	Zorlen_Button_Slam = nil;
	Zorlen_Button_SweepingStrikes = nil;
	Zorlen_Button_Whirlwind = nil;
	for i = 1, 120 do
		if ( HasAction(i) ) then
		local texture = GetActionTexture(i);
		local text = GetActionText(i);
			if not ( Zorlen_Button_Execute ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_Execute)) ) then
				Zorlen_Button_Execute = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_Execute.." = " .. i);
				end
			elseif not ( Zorlen_Button_HeroicStrike ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_HeroicStrike)) ) then
				Zorlen_Button_HeroicStrike = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_HeroicStrike.." = " .. i);
				end
			elseif not ( Zorlen_Button_SunderArmor ) and (not text) and ( string.find(texture, "Ability_Warrior_Sunder") ) then
				Zorlen_Button_SunderArmor = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_SunderArmor.." = " .. i);
				end
			elseif not ( Zorlen_Button_ThunderClap ) and (not text) and ( string.find(texture, "Spell_Nature_ThunderClap") ) then
				Zorlen_Button_ThunderClap = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_ThunderClap.." = " .. i);
				end
			elseif not ( Zorlen_Button_MortalStrike ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_MortalStrike)) ) then
				Zorlen_Button_MortalStrike = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_MortalStrike.." = " .. i);
				end
			elseif not ( Zorlen_Button_Bloodthirst ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_Bloodthirst)) ) then
				Zorlen_Button_Bloodthirst = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_Bloodthirst.." = " .. i);
				end
			elseif not ( Zorlen_Button_ShieldSlam ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_ShieldSlam)) ) then
				Zorlen_Button_ShieldSlam = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_ShieldSlam.." = " .. i);
				end
			elseif not ( Zorlen_Button_Charge ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_Charge)) ) then
				Zorlen_Button_Charge = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_Charge.." = " .. i);
				end
			elseif not ( Zorlen_Button_Taunt ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_Taunt)) ) then
				Zorlen_Button_Taunt = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_Taunt.." = " .. i);
				end
			elseif not ( Zorlen_Button_Intercept ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_Intercept)) ) then
				Zorlen_Button_Intercept = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_Intercept.." = " .. i);
				end
			elseif not ( Zorlen_Button_Overpower ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_Overpower)) ) then
				Zorlen_Button_Overpower = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_Overpower.." = " .. i);
				end
			elseif not ( Zorlen_Button_Revenge ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_Revenge)) ) then
				Zorlen_Button_Revenge = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_Revenge.." = " .. i);
				end
			elseif not ( Zorlen_Button_Rend ) and (not text) and ( string.find(texture, "Ability_Gouge") ) then
				Zorlen_Button_Rend = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_Rend.." = " .. i);
				end
			elseif not ( Zorlen_Button_Hamstring ) and (not text) and ( string.find(texture, "Ability_ShockWave") ) then
				Zorlen_Button_Hamstring = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_Hamstring.." = " .. i);
				end
			elseif not ( Zorlen_Button_ShieldBash ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_ShieldBash)) ) then
				Zorlen_Button_ShieldBash = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_ShieldBash.." = " .. i);
				end
			elseif not ( Zorlen_Button_Pummel ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_Pummel)) ) then
				Zorlen_Button_Pummel = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_Pummel.." = " .. i);
				end
			elseif not ( Zorlen_Button_ShieldBlock ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_ShieldBlock)) ) then
				Zorlen_Button_ShieldBlock = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_ShieldBlock.." = " .. i);
				end
			elseif not ( Zorlen_Button_DemoralizingShout ) and (not text) and ( string.find(texture, "Ability_Warrior_WarCry") ) then
				Zorlen_Button_DemoralizingShout = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_DemoralizingShout.." = " .. i);
				end
			elseif not ( Zorlen_Button_BattleShout ) and (not text) and ( string.find(texture, "Ability_Warrior_BattleShout") ) then
				Zorlen_Button_BattleShout = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_BattleShout.." = " .. i);
				end
			elseif not ( Zorlen_Button_BerserkerRage ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_BerserkerRage)) ) then
				Zorlen_Button_BerserkerRage = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_BerserkerRage.." = " .. i);
				end
			elseif not ( Zorlen_Button_Bloodrage ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_Bloodrage)) ) then
				Zorlen_Button_Bloodrage = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_Bloodrage.." = " .. i);
				end
			elseif not ( Zorlen_Button_ChallengingShout ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_ChallengingShout)) ) then
				Zorlen_Button_ChallengingShout = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_ChallengingShout.." = " .. i);
				end
			elseif not ( Zorlen_Button_Cleave ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_Cleave)) ) then
				Zorlen_Button_Cleave = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_Cleave.." = " .. i);
				end
			elseif not ( Zorlen_Button_ConcussionBlow ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_ConcussionBlow)) ) then
				Zorlen_Button_ConcussionBlow = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_ConcussionBlow.." = " .. i);
				end
			elseif not ( Zorlen_Button_DeathWish ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_DeathWish)) ) then
				Zorlen_Button_DeathWish = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_DeathWish.." = " .. i);
				end
			elseif not ( Zorlen_Button_Disarm ) and (not text) and ( string.find(texture, "Ability_Warrior_Disarm") ) then
				Zorlen_Button_Disarm = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_Disarm.." = " .. i);
				end
			elseif not ( Zorlen_Button_IntimidatingShout ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_IntimidatingShout)) ) then
				Zorlen_Button_IntimidatingShout = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_IntimidatingShout.." = " .. i);
				end
			elseif not ( Zorlen_Button_LastStand ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_LastStand)) ) then
				Zorlen_Button_LastStand = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_LastStand.." = " .. i);
				end
			elseif not ( Zorlen_Button_MockingBlow ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_MockingBlow)) ) then
				Zorlen_Button_MockingBlow = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_MockingBlow.." = " .. i);
				end
			elseif not ( Zorlen_Button_PiercingHowl ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_PiercingHowl)) ) then
				Zorlen_Button_PiercingHowl = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_PiercingHowl.." = " .. i);
				end
			elseif not ( Zorlen_Button_Recklessness ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_Recklessness)) ) then
				Zorlen_Button_Recklessness = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_Recklessness.." = " .. i);
				end
			elseif not ( Zorlen_Button_Retaliation ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_Retaliation)) ) then
				Zorlen_Button_Retaliation = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_Retaliation.." = " .. i);
				end
			elseif not ( Zorlen_Button_ShieldWall ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_ShieldWall)) ) then
				Zorlen_Button_ShieldWall = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_ShieldWall.." = " .. i);
				end
			elseif not ( Zorlen_Button_Slam ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_Slam)) ) then
				Zorlen_Button_Slam = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_Slam.." = " .. i);
				end
			elseif not ( Zorlen_Button_SweepingStrikes ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_SweepingStrikes)) ) then
				Zorlen_Button_SweepingStrikes = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_SweepingStrikes.." = " .. i);
				end
			elseif not ( Zorlen_Button_Whirlwind ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_Whirlwind)) ) then
				Zorlen_Button_Whirlwind = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_Whirlwind.." = " .. i);
				end
			end
		end
	end
end



function Zorlen_RegisterOtherButtons(option)
	Zorlen_Button_Perception = nil;
	Zorlen_Button_Stoneform = nil;
	Zorlen_Button_EscapeArtist = nil;
	Zorlen_Button_Shadowmeld = nil;
	Zorlen_Button_BloodFury = nil;
	Zorlen_Button_Cannibalize = nil;
	Zorlen_Button_WillOfTheForsaken = nil;
	Zorlen_Button_WarStomp = nil;
	Zorlen_Button_Berserking = nil;
	Zorlen_Button_Attack = nil;
	Zorlen_Button_Throw = nil;
	Zorlen_Button_ShootBow = nil;
	Zorlen_Button_ShootCrossbow = nil;
	Zorlen_Button_ShootGun = nil;
	Zorlen_Button_Shoot = nil;
	for i = 1, 120 do
		if ( HasAction(i) ) then
		local texture = GetActionTexture(i);
		local text = GetActionText(i);
			if not ( Zorlen_Button_Perception ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_Perception)) ) then
				Zorlen_Button_Perception = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_Perception.." = " .. i);
				end
			elseif not ( Zorlen_Button_Stoneform ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_Stoneform)) ) then
				Zorlen_Button_Stoneform = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_Stoneform.." = " .. i);
				end
			elseif not ( Zorlen_Button_EscapeArtist ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_EscapeArtist)) ) then
				Zorlen_Button_EscapeArtist = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_EscapeArtist.." = " .. i);
				end
			elseif not ( Zorlen_Button_Shadowmeld ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_Shadowmeld)) ) then
				Zorlen_Button_Shadowmeld = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_Shadowmeld.." = " .. i);
				end
			elseif not ( Zorlen_Button_BloodFury ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_BloodFury)) ) then
				Zorlen_Button_BloodFury = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_BloodFury.." = " .. i);
				end
			elseif not ( Zorlen_Button_Cannibalize ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_Cannibalize)) ) then
				Zorlen_Button_Cannibalize = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_Cannibalize.." = " .. i);
				end
			elseif not ( Zorlen_Button_WillOfTheForsaken ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_WillOfTheForsaken)) ) then
				Zorlen_Button_WillOfTheForsaken = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_WillOfTheForsaken.." = " .. i);
				end
			elseif not ( Zorlen_Button_WarStomp ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_WarStomp)) ) then
				Zorlen_Button_WarStomp = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_WarStomp.." = " .. i);
				end
			elseif not ( Zorlen_Button_Berserking ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_Berserking)) ) then
				Zorlen_Button_Berserking = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_Berserking.." = " .. i);
				end
			elseif ( not Zorlen_Button_Attack ) and (not text) and ( IsAttackAction(i) ) then
				Zorlen_Button_Attack = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_Attack.." = " .. i);
				end
			elseif not ( Zorlen_Button_Throw ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_Throw)) ) then
				Zorlen_Button_Throw = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_Throw.." = " .. i);
				end
			elseif not ( Zorlen_Button_ShootBow ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_ShootBow)) ) then
				Zorlen_Button_ShootBow = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_ShootBow.." = " .. i);
				end
			elseif not ( Zorlen_Button_ShootCrossbow ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_ShootCrossbow)) ) then
				Zorlen_Button_ShootCrossbow = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_ShootCrossbow.." = " .. i);
				end
			elseif not ( Zorlen_Button_ShootGun ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_ShootGun)) ) then
				Zorlen_Button_ShootGun = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_ShootGun.." = " .. i);
				end
			elseif not ( Zorlen_Button_Shoot ) and (not text) and ( string.find(texture, Zorlen_GetSpellTextureByName(LOCALIZATION_ZORLEN_Shoot)) ) then
				Zorlen_Button_Shoot = i;
				if (option == "show") then
					DEFAULT_CHAT_FRAME:AddMessage("Zorlen Button: "..LOCALIZATION_ZORLEN_Shoot.." = " .. i);
				end
			end
		end
	end
end

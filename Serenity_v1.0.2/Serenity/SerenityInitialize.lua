------------------------------------------------------------------------------------------------------
-- Serenity
--
-- Based on Necrosis LdC by Lomig and Nyx (http://necrosis.larmes-cenarius.net)
-- Original Necrosis Idea : Infernal (http://www.revolvus.com/games/interface/necrosis/)
-- Serenity Maintainer : Kaeldra of Aegwynn
--
-- Contact : darklyte@gmail.com
-- Send me in-game mail!  Yersinia on Aegwynn, Horde side.
-- Guild: <Working as Intended>
-- Version Date: 07.14.2006
------------------------------------------------------------------------------------------------------



------------------------------------------------------------------------------------------------------
-- FONCTION D'INITIALISATION
------------------------------------------------------------------------------------------------------

function Serenity_Initialize()

	-- Initilialisation des Textes (VO / VF / VA)
	if SerenityConfig ~= {} then
		if (SerenityConfig.SerenityLanguage == "enUS") or (SerenityConfig.SerenityLanguage == "enGB") then
			Serenity_Localization_Dialog_En();
		elseif (SerenityConfig.SerenityLanguage == "deDE") then
			Serenity_Localization_Dialog_De();
		elseif (SerenityConfig.SerenityLanguage == "frFR") then
			Serenity_Localization_Dialog_Fr();
		elseif (SerenityConfig.SerenityLanguage == "zhCN") then
			Serenity_Localization_Dialog_Cn();
		else
			Serenity_Localization_Dialog_Tw();
		end
	elseif GetLocale() == "enUS" or GetLocale() == "enGB" then
		Serenity_Localization_Dialog_En();
	elseif GetLocale() == "deDE" then
		Serenity_Localization_Dialog_De();
	elseif GetLocale() == "frFR" then
		Serenity_Localization_Dialog_Fr();
	elseif GetLocale() == "zhCN" then
		Serenity_Localization_Dialog_Cn();
	else
		Serenity_Localization_Dialog_Tw();
	end


	-- On initialise ! Si le joueur n'est pas Démoniste, on cache Serenity (chuuuut !)
	-- On indique aussi que Nécrosis est initialisé maintenant
	if UnitClass("player") ~= SERENITY_UNIT_PRIEST then
		HideUIPanel(SerenityInventoryMenu);
		HideUIPanel(SerenitySpellTimerButton);
		HideUIPanel(SerenityButton);
		HideUIPanel(SerenitySpellMenuButton);
		HideUIPanel(SerenityBuffMenuButton);
		HideUIPanel(SerenityMountButton);
		HideUIPanel(SerenityPotionButton);
		HideUIPanel(SerenityDrinkButton);
		HideUIPanel(SerenityDispelButton);
		HideUIPanel(SerenityMiddleSpellButton);
		HideUIPanel(SerenityLeftSpellButton);
		HideUIPanel(SerenityRightSpellButton);
--		HideUIPanel(SerenityAntiFearButton);
--		HideUIPanel(SerenityConcentrationButton);
	else
		-- On charge (ou on crée) la configuration pour le joueur et on l'affiche sur la console
		if SerenityConfig == nil or SerenityConfig.Version ~= Default_SerenityConfig.Version then
			SerenityConfig = {};
			SerenityConfig = Default_SerenityConfig;
--			if UnitLevel("player") < 40 then SerenityConfig.StonePosition[8] = false; end			
			Serenity_Msg(SERENITY_MESSAGE.Personality.Greeting, "USER");		
			Serenity_Msg(SERENITY_MESSAGE.Interface.DefaultConfig, "USER");		
			SerenityButton:ClearAllPoints();
			SerenitySpellTimerButton:ClearAllPoints();
			SerenityButton:SetPoint("CENTER", "UIParent", "CENTER",0,-100);
			SerenitySpellTimerButton:SetPoint("CENTER", "UIParent", "CENTER",120,340);

		else
			Serenity_Msg(SERENITY_MESSAGE.Personality.Welcome, "USER");		
			Serenity_Msg(SERENITY_MESSAGE.Interface.UserConfig, "USER");
		end
		-----------------------------------------------------------
		-- Exécution des fonctions de démarrage
		-----------------------------------------------------------

		-- Affichage d'un message sur la console
		Serenity_Msg(SERENITY_MESSAGE.Interface.Welcome, "USER");
		-- Création de la liste des sorts disponibles
		Serenity_SpellSetup();
		-- Création de la liste des emplacements des fragments
		Serenity_ProvisionSetup();
		-- Inventaire des pierres et des fragments possédés par le Démoniste
--		Serenity_BagExplore();
		-- Création des menus de buff et d'invocation
		Serenity_CreateMenu();

		-- Lecture de la configuration dans le SavedVariables.lua, écriture dans les variables définies
		
		----------------------------------------
		-- Inventory Menu Setup
		----------------------------------------
		if (SerenityConfig.Restock) then SerenityRestock_Button:SetChecked(1); end
        if (SerenityConfig.RestockConfirm) then SerenityRestockConfirm_Button:SetChecked(1); end

  		SerenityHolyCandle_Slider:SetValue(SerenityConfig.RestockHolyCandle);
		SerenityHolyCandle_SliderLow:SetText("0");
		SerenityHolyCandle_SliderHigh:SetText("200");

  		SerenitySacredCandle_Slider:SetValue(SerenityConfig.RestockSacredCandle);
		SerenitySacredCandle_SliderLow:SetText("0");
		SerenitySacredCandle_SliderHigh:SetText("200");
        
  		SerenityCountType_Slider:SetValue(SerenityConfig.CountType);
		SerenityCountType_SliderLow:SetText("");
		SerenityCountType_SliderHigh:SetText("");

		SerenityButton_Slider:SetValue(SerenityConfig.Button);
		SerenityButton_SliderLow:SetText("");
		SerenityButton_SliderHigh:SetText("");
		
		SerenityCircle_Slider:SetValue(SerenityConfig.Circle);
		SerenityCircle_SliderLow:SetText("");
		SerenityCircle_SliderHigh:SetText("");
		

  		----------------------------------------
		-- Message Menu Setup
		----------------------------------------

		if SerenityConfig.SerenityLanguage == "frFR" then
			SerenityLanguage_Slider:SetValue(1);
		elseif SerenityConfig.SerenityLanguage == "enUS" then
			SerenityLanguage_Slider:SetValue(2);
		elseif SerenityConfig.SerenityLanguage == "deDE" then
			SerenityLanguage_Slider:SetValue(3);
		elseif SerenityConfig.SerenityLanguage == "zhTW" then
			SerenityLanguage_Slider:SetValue(4);
		else
			SerenityLanguage_Slider:SetValue(5);  --"zhCN"
		end
		SerenityLanguage_SliderText:SetText("Langue / Language / Sprache / èªžè¨€ / è¯­è¨€");
		SerenityLanguage_SliderLow:SetText("");
		SerenityLanguage_SliderHigh:SetText("")

		SerenityShackleWarn_Slider:SetValue(SerenityConfig.ShackleWarnTime);
		SerenityShackleWarn_SliderLow:SetText("");
		SerenityShackleWarn_SliderHigh:SetText("");

		if (SerenityConfig.SerenityToolTip) then SerenityShowTooltips_Button:SetChecked(1); end
		if (SerenityConfig.Sound) then SerenitySound_Button:SetChecked(1); end
   		if (SerenityConfig.ChatMsg) then SerenityShowMessage_Button:SetChecked(1); end
		if (SerenityConfig.QuickBuff) then SerenityQuickBuff_Button:SetChecked(1); end
		if (SerenityConfig.ShackleMessage) then SerenityShowShackleMessage_Button:SetChecked(1); end
		if (SerenityConfig.ResMessage) then SerenityShowResMessage_Button:SetChecked(1); end
		if (SerenityConfig.SteedSummon) then SerenityShowSteedSummon_Button:SetChecked(1); end
		if not (SerenityConfig.ChatType) then SerenityChatType_Button:SetChecked(1); end
		if (SerenityConfig.ShackleWarn) then SerenityShackleWarn_Button:SetChecked(1); end
		if (SerenityConfig.ShackleBreak) then SerenityShackleBreak_Button:SetChecked(1); end
		if (SerenityConfig.SteedMessage) then SerenityShowSteedMessage_Button:SetChecked(1); end


     	----------------------------------------
		-- Button Menu Setup
		----------------------------------------
		SerenityShowButton_String:SetText(SERENITY_CONFIGURATION.Show.Text)
		SerenityOnButton_String:SetText(SERENITY_CONFIGURATION.Text.Text)
		if (SerenityConfig.StonePosition[1]) then SerenityShowPotion_Button:SetChecked(1); end
		if (SerenityConfig.StonePosition[2]) then SerenityShowDrink_Button:SetChecked(1); end
		if (SerenityConfig.StonePosition[3]) then SerenityShowDispel_Button:SetChecked(1); end
		if (SerenityConfig.StonePosition[4]) then SerenityShowLeftSpell_Button:SetChecked(1); end
		if (SerenityConfig.StonePosition[5]) then SerenityShowMiddleSpell_Button:SetChecked(1); end
		if (SerenityConfig.StonePosition[6]) then SerenityShowRightSpell_Button:SetChecked(1); end
		if (SerenityConfig.StonePosition[7]) then SerenityShowBuffMenu_Button:SetChecked(1); end
		if (SerenityConfig.StonePosition[8]) then SerenityShowMount_Button:SetChecked(1); end
		if (SerenityConfig.StonePosition[9]) then SerenityShowSpellMenu_Button:SetChecked(1); end

		if (SerenityConfig.PotionCountText) then SerenityPotionText_Button:SetChecked(1); end
		if (SerenityConfig.DrinkCountText) then SerenityDrinkText_Button:SetChecked(1); end
--		if (SerenityConfig.PotionCooldownText) then SerenityPotionText_Button:SetChecked(1); end
		if (SerenityConfig.EvocationCooldownText) then SerenityEvocationText_Button:SetChecked(1); end
		if (SerenityConfig.HolyCandleCountText) then SerenityHolyCandleText_Button:SetChecked(1); end
		if (SerenityConfig.FeatherCountText) then SerenityFeatherText_Button:SetChecked(1); end
		if (SerenityConfig.SacredCandleCountText) then SerenitySacredCandleText_Button:SetChecked(1); end
		
		SerenityLeftSpell_Slider:SetValue(SerenityConfig.LeftSpell);
		SerenityLeftSpell_SliderLow:SetText("");
		SerenityLeftSpell_SliderHigh:SetText("");
		
		SerenityMiddleSpell_Slider:SetValue(SerenityConfig.MiddleSpell);
		SerenityMiddleSpell_SliderLow:SetText("");
		SerenityMiddleSpell_SliderHigh:SetText("");
		
		SerenityRightSpell_Slider:SetValue(SerenityConfig.RightSpell);
		SerenityRightSpell_SliderLow:SetText("");
		SerenityRightSpell_SliderHigh:SetText("");
		

        ----------------------------------------
		-- Timer Menu Setup
		----------------------------------------
		SerenityListSpells:ClearAllPoints();
		SerenityListSpells:SetJustifyH(SerenityConfig.SpellTimerJust);
		SerenityListSpells:SetPoint("TOP"..SerenityConfig.SpellTimerJust, "SerenitySpellTimerButton", "CENTER", SerenityConfig.SpellTimerPos * 23, 5);	
		ShowUIPanel(SerenityButton);

		if SerenityConfig.SpellTimerJust == -23 then 
			AnchorSpellTimerTooltip = "ANCHOR_LEFT";
		else
			AnchorSpellTimerTooltip = "ANCHOR_RIGHT";
		end


        if (SerenityConfig.ShowSpellTimers) then SerenityShowSpellTimers_Button:SetChecked(1); end
		if (SerenityConfig.ShowSpellTimerButton) then SerenityTimerButton_Button:SetChecked(1); end
		if (SerenityConfig.SpellTimerPos == -1) then SerenitySTimer_Button:SetChecked(1); end
		if (SerenityConfig.Graphical) then SerenityGraphicalTimer_Button:SetChecked(1); end
		if not (SerenityConfig.Yellow) then SerenityTimerColor_Button:SetChecked(1); end
		if (SerenityConfig.SensListe == -1) then SerenityTimerDirection_Button:SetChecked(1); end

        ----------------------------------------
		-- Graphical Menu Setup
		----------------------------------------
--		if (SerenityConfig.AntiFearAlert) then SerenityAntiFearAlert_Button:SetChecked(1); end
--		if (SerenityConfig.ConcentrationAlert) then SerenityConcentrationAlert_Button:SetChecked(1); end
		if (SerenityConfig.SerenityLockServ) then SerenityIconsLock_Button:SetChecked(1); end
		if (SerenityConfig.BuffMenuPos == -34) then SerenityBuffMenu_Button:SetChecked(1); end
		if (SerenityConfig.SpellMenuPos == -34) then SerenitySpellMenu_Button:SetChecked(1); end
		if (SerenityConfig.NoDragAll) then SerenityLock_Button:SetChecked(1); end
		

		
		SerenityBuffMenuAnchor_Slider:SetValue(SerenityConfig.BuffMenuAnchor);
		SerenityBuffMenuAnchor_SliderLow:SetText("");
		SerenityBuffMenuAnchor_SliderHigh:SetText("")

		SerenitySpellMenuAnchor_Slider:SetValue(SerenityConfig.SpellMenuAnchor);
		SerenitySpellMenuAnchor_SliderLow:SetText("");
		SerenitySpellMenuAnchor_SliderHigh:SetText("")
		
		SerenityButtonRotate_Slider:SetValue(SerenityConfig.SerenityAngle);
		SerenityButtonRotate_SliderLow:SetText("0");
		SerenityButtonRotate_SliderHigh:SetText("360");

		SerenityButtonScale_Slider:SetValue(SerenityConfig.SerenityButtonScale);
		SerenityButtonScale_SliderLow:SetText("50 %");
		SerenityButtonScale_SliderHigh:SetText("150 %");
		
		SerenityStoneScale_Slider:SetValue(SerenityConfig.SerenityStoneScale);
		SerenityStoneScale_SliderLow:SetText("50 %");
		SerenityStoneScale_SliderHigh:SetText("150 %");
		-- On règle la taille de la pierre et des boutons suivant les réglages du SavedVariables
		SerenityButton:SetScale(SerenityConfig.SerenityButtonScale/100);
		SerenityPotionButton:SetScale(SerenityConfig.SerenityStoneScale/100);
		SerenityDrinkButton:SetScale(SerenityConfig.SerenityStoneScale/100);
		SerenityDispelButton:SetScale(SerenityConfig.SerenityStoneScale/100);
		SerenityLeftSpellButton:SetScale(SerenityConfig.SerenityStoneScale/100);
		SerenityMiddleSpellButton:SetScale(SerenityConfig.SerenityStoneScale/100);
		SerenityRightSpellButton:SetScale(SerenityConfig.SerenityStoneScale/100);
		SerenityBuffMenuButton:SetScale(SerenityConfig.SerenityStoneScale/100);
		SerenityMountButton:SetScale(SerenityConfig.SerenityStoneScale/100);
		SerenitySpellMenuButton:SetScale(SerenityConfig.SerenityStoneScale/100);


		if SerenityConfig.NoDragAll then
			Serenity_NoDrag();
			SerenityButton:RegisterForDrag("");
			SerenitySpellTimerButton:RegisterForDrag("");
		else
			Serenity_Drag();
			SerenityButton:RegisterForDrag("LeftButton");
			SerenitySpellTimerButton:RegisterForDrag("LeftButton");
		end




		-- On vérifie que les fragments sont dans le sac défini par le Démoniste
--		Serenity_ProvisionSwitch("CHECK");

		-- Le Shard est-il vérouillé sur l'interface ?
		
		-- Les boutons sont-ils vérouillés sur le Shard ?
		Serenity_ButtonSetup();
		Serenity_LanguageInitialize();
		if SerenityConfig.SM then
			SERENITY_EVOCATION_ALERT_MESSAGE = SERENITY_SHORT_MESSAGES[1];
			SERENITY_INVOCATION_MESSAGES = SERENITY_SHORT_MESSAGES[2];
		end
	end
end

function Serenity_LanguageInitialize()
	
	-- Localisation du speech.lua
	SerenityLocalization();

	-- Localisation du XML
	SerenityVersion:SetText(SerenityData.Label);		
	
	----------------------------------------
	-- Inventory Menu Dialog Setup
	----------------------------------------

	SerenityButton_SliderText:SetText(SERENITY_CONFIGURATION.Button.Text);
	SerenityCircle_SliderText:SetText(SERENITY_CONFIGURATION.Circle.Text);
	SerenityRestock_Option:SetText(SERENITY_CONFIGURATION.Restock.Restock);
	SerenityRestockConfirm_Option:SetText(SERENITY_CONFIGURATION.Restock.Confirm);
	SerenityHolyCandle_SliderText:SetText(SERENITY_ITEM.HolyCandle);
    SerenitySacredCandle_SliderText:SetText(SERENITY_ITEM.SacredCandle);
	SerenityCountType_SliderText:SetText(SERENITY_CONFIGURATION.CountType);

	


	----------------------------------------
	-- Message Menu Dialog Setup
	----------------------------------------
	
	SerenitySound_Option:SetText(SERENITY_CONFIGURATION.Sound);
	SerenityShowMessage_Option:SetText(SERENITY_CONFIGURATION.ShowMessage);
	SerenityShowShackleMessage_Option:SetText(SERENITY_CONFIGURATION.ShowShackleMessage);
	SerenityShowResMessage_Option:SetText(SERENITY_CONFIGURATION.ShowResMessage);
    SerenityShowSteedMessage_Option:SetText(SERENITY_CONFIGURATION.ShowSteedMessage);
	SerenityShackleWarn_Option:SetText(SERENITY_CONFIGURATION.ShackleUndead.Warn);
	SerenityShackleBreak_Option:SetText(SERENITY_CONFIGURATION.ShackleUndead.Break);
	SerenityChatType_Option:SetText(SERENITY_CONFIGURATION.ChatType);
	
	----------------------------------------
	-- Button Menu Dialog Setup
	----------------------------------------
	
	SerenityShowPotion_Option:SetText(SERENITY_CONFIGURATION.Show.Potion);
	SerenityShowDrink_Option:SetText(SERENITY_CONFIGURATION.Show.Drink);
	SerenityShowDispel_Option:SetText(SERENITY_CONFIGURATION.Show.Dispel);
	SerenityShowLeftSpell_Option:SetText(SERENITY_CONFIGURATION.Show.LeftSpell);
	SerenityShowMiddleSpell_Option:SetText(SERENITY_CONFIGURATION.Show.MiddleSpell);
	SerenityShowRightSpell_Option:SetText(SERENITY_CONFIGURATION.Show.RightSpell);
	SerenityShowMount_Option:SetText(SERENITY_CONFIGURATION.Show.Steed);
	SerenityShowBuffMenu_Option:SetText(SERENITY_CONFIGURATION.Show.Buff);
	SerenityShowSpellMenu_Option:SetText(SERENITY_CONFIGURATION.Show.Spell);
	SerenityShowTooltips_Option:SetText(SERENITY_CONFIGURATION.Show.Tooltips);
	SerenityQuickBuff_Option:SetText(SERENITY_CONFIGURATION.QuickBuff);

	SerenityMessagePlayer_Section:SetText(SERENITY_CONFIGURATION.SpellMenu2);

	SerenityPotionText_Option:SetText(SERENITY_CONFIGURATION.Text.Potion);
	SerenityDrinkText_Option:SetText(SERENITY_CONFIGURATION.Text.Drink);
	SerenityDispelText_Option:SetText(SERENITY_CONFIGURATION.Text.Dispel);
	SerenitySpellButtonText_Option:SetText(SERENITY_CONFIGURATION.Text.SpellButton);	
	SerenityHolyCandleText_Option:SetText(SERENITY_CONFIGURATION.Text.HolyCandles);
	SerenityFeatherText_Option:SetText(SERENITY_CONFIGURATION.Text.Feather);
	SerenitySacredCandleText_Option:SetText(SERENITY_CONFIGURATION.Text.SacredCandles);
	
	----------------------------------------
	-- Timer Menu Dialog Setup
	----------------------------------------
	
	SerenityShowSpellTimers_Option:SetText(SERENITY_CONFIGURATION.SpellTime);
	SerenityTimerButton_Option:SetText(SERENITY_CONFIGURATION.Show.Spelltimer);
	SerenityGraphicalTimer_Section:SetText(SERENITY_CONFIGURATION.TimerMenu);
	SerenityGraphicalTimer_Option:SetText(SERENITY_CONFIGURATION.GraphicalTimer);
	SerenityTimerColor_Option:SetText(SERENITY_CONFIGURATION.TimerColor);

	SerenityTimerDirection_Option:SetText(SERENITY_CONFIGURATION.TimerDirection);
	
	----------------------------------------
	-- Graphical Menu Dialog Setup
	----------------------------------------

	SerenityLock_Option:SetText(SERENITY_CONFIGURATION.MainLock);
	SerenityBuffMenu_Option:SetText(SERENITY_CONFIGURATION.BuffMenu);
	SerenitySpellMenu_Option:SetText(SERENITY_CONFIGURATION.SpellMenu);
	SerenitySTimer_Option:SetText(SERENITY_CONFIGURATION.STimerLeft);
	SerenityIconsLock_Option:SetText(SERENITY_CONFIGURATION.ButtonLock);
	SerenityButtonRotate_SliderText:SetText(SERENITY_CONFIGURATION.MainRotation);
	SerenityButtonScale_SliderText:SetText(SERENITY_CONFIGURATION.SerenitySize);
	SerenityStoneScale_SliderText:SetText(SERENITY_CONFIGURATION.StoneScale)

	
		
		
end



------------------------------------------------------------------------------------------------------
-- FONCTION GERANT LA COMMANDE CONSOLE /CRYO
------------------------------------------------------------------------------------------------------

function Serenity_SlashHandler(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12)
	-- Blah blah blah, le joueur est-il bien un Démoniste ? On finira par le savoir !
	if UnitClass("player") ~= SERENITY_UNIT_PRIEST then
		return;
	end
	if string.find(string.lower(arg1), "recall") then
		SerenityButton:ClearAllPoints();
		SerenityButton:SetPoint("CENTER", "UIParent", "CENTER",0,0);
		SerenitySpellTimerButton:ClearAllPoints();
		SerenitySpellTimerButton:SetPoint("CENTER", "UIParent", "CENTER",0,0);
	elseif string.find(string.lower(arg1), "sm") then
		if SERENITY_Evocation_ALERT_MESSAGE == SERENITY_SHORT_MESSAGES[1] then
			SerenityConfig.SM = false;
			SerenityLocalization();
			Serenity_Msg("Short Messages : <red>Off", "USER");
		else
			SerenityConfig.SM = true;
			SERENITY_Evocation_ALERT_MESSAGE = SERENITY_SHORT_MESSAGES[1];
			SERENITY_INVOCATION_MESSAGES = SERENITY_SHORT_MESSAGES[2];
			Serenity_Msg("Short Messages : <brightGreen>On", "USER");
		end
	elseif string.find(string.lower(arg1), "reset") then
		SerenityConfig.Version = "reboot";
		Serenity_Loaded = false;
		Serenity_LoadVariables();
	elseif string.find(string.lower(arg1), "firefly") then
			PlaySoundFile(SERENITY_SOUND.Shackle);
			Serenity_Msg(SERENITY_MSG.Personality.Signal,"USER");
	elseif string.find(string.lower(arg1), "toggle") then
		if SerenityButton:IsVisible() then
			HideUIPanel(SerenityButton)
		else
			ShowUIPanel(SerenityButton)
		end
	else
		if SERENITY_MESSAGE.Help ~= nil then
			for i = 1, table.getn(SERENITY_MESSAGE.Help), 1 do
				Serenity_Msg(SERENITY_MESSAGE.Help[i], "USER");
			end
		end
		Serenity_Toggle();
	end
end

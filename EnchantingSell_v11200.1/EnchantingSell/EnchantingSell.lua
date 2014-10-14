ENCHANTINGSELL_VERSION = "11200.1";

--	Variable pour fonction debug, pour afficher ou non les messages de debugage
ESell_Debug = false;
--useMinimapIcon = true;

-- for MyAddOns ---------------------------
EnchantingSellDetails = {
name = "EnchantingSell",
description = "provides enchanters with a decent tool for managing their profession.",
version = ENCHANTINGSELL_VERSION,
releaseDate = "July 07, 2005",
author = "Shamino",
category = MYADDONS_CATEGORY_PROFESSIONS,
optionsframe = "EnchantingSell_Option_OpenFrame"
};
--------------------------------------------

EnchantingSellHelp = {};
EnchantingSellHelp[1] = "Color Code :\nClear green-> You have all ingredients and rod in your bags.\nDark green-> Some ingredients necessary is in bank.\nBrown-> Some ingredients necessary is on ReRoll.\nGray-> This enchantor do not know this enchantement.";

--	Table sauvegardé
EnchantingSell_ListEnchante = nil;
EnchantingSell_ListComponant = nil;
EnchantingSell_Config = nil;		--global config
EnchantingSell_PlayerConfig = nil;	--per player config
--------------------------

-- default global configuration
EnchantingSell_ConfigDefault = {
	PourcentageBenefice = 1.20;
	EnchantorPlayerSelected = nil;
	EnchantorTable = {};
	CheckSortByDoCraft = false;
	EnchanteSortOn = {"OnThis","Bonus","BonusNb","Price","Name"};
	EnchanteChatPrice = false;
	MiniMapButtonPosition = 15;
	EnchanteUseAuctioneer = false;
	UseTooltips=true;
	UseMinimapIcon = true;
};

-- per player configuration saved information.
EnchantingSell_PlayerConfig_Default = {
	UseMinimapIcon = EnchantingSell_ConfigDefault.UseMinimapIcon;
	UseTooltips=EnchantingSell_ConfigDefault.UseTooltips;
	EnchanteUseAuctioneer = EnchantingSell_ConfigDefault.EnchanteUseAuctioneer;
	MiniMapButtonPosition = EnchantingSell_ConfigDefault.MiniMapButtonPosition;
	EnchanteChatPrice = EnchantingSell_ConfigDefault.EnchanteChatPrice;
	CheckSortByDoCraft = EnchantingSell_ConfigDefault.CheckSortByDoCraft;
	PourcentageBenefice = EnchantingSell_ConfigDefault.PourcentageBenefice;
};



--	Fonction local de traitement ne peut etre appelé de code externe
local ESell_EnchanteSort_Modifier;
local ESell_EnchanteSort_Sort;
local ESell_EnchanteSort_SortUnderFunction;
local ESell_EnchanteSort_SortByDoCraft;

local ESell_Enchante_UpdateData;
local ESell_Reagent_UpdateData;
--------------------------

--runtime variables
ESell_AllVariableLoaded=false;
local ESell_IsEnterWord;
local ESell_playerIsEnchanter = false;
EnchantingSell_CourantPlayer = {};
local EnchantingSell_BankIsOpen = false;
EnchanteSortArmor = nil;
EnchanteSortTypeAZ = true;
ESell_currentEnchantSelected = nil;	--temp variable used to remember which enchant is currently selected.

--	Couleur pour les faisabilités enchante et disponibilité ingredients
TEXTECOLOR = {
	[-2] = {0.40, 0.40, 0.40};	-- Enchantor selected no know this
	[-1] = {0.80, 0.80, 0.80};	-- Neutre (Blanc) 
	[1] = {0.30, 1, 0.30};		-- Disponible dans les sacs (Vert Clair)
	[2] = {0.50, 0.70, 0.30};	-- Disponible en bank (Vert Foncé)
	[3] = {0.70, 0.50, 0.30};	-- Diponible sur les Reroll (Rouge Vert)
	[4] = {1, 0.30, 0.30};		-- Indisponible (Rouge vif)
};

--	Couleur de l'argent dans les listes et ToolTip
MONEYCOLOR = {
	Gold = {0.80, 0.70, 0.25};
	Silver = {0.90, 0.90, 1};
	Copper = {0.70, 0.45, 0.20};
};

function ESell_OnLoad()

	-- Hook in new tooltip code
	if (IsAddOnLoaded("EnhTooltip") and IsAddOnLoaded("Stubby")) then
		Stubby.RegisterFunctionHook("EnhTooltip.AddTooltip", 500, ES_HookTooltip)
	end

	-- events
	ESell_Register_Our_Events();
	------------------

	--	Commande / du logiciel
	DEFAULT_CHAT_FRAME:AddMessage("Addon EnchantingSeller");
	SlashCmdList["EnchantingSell"] = ESell_Command;
	SLASH_EnchantingSell1 = "/es";
	SLASH_EnchantingSell = "/enchantingsell";
	------------------

end

function ESell_Register_Our_Events()
	this:RegisterEvent("UNIT_NAME_UPDATE");
	this:RegisterEvent("BAG_UPDATE");
	this:RegisterEvent("CRAFT_SHOW");
	this:RegisterEvent("CRAFT_UPDATE");
	this:RegisterEvent("BANKFRAME_OPENED");
	this:RegisterEvent("BANKFRAME_CLOSED");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("PLAYER_LEAVING_WORLD");
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("SKILL_LINES_CHANGED");
	this:RegisterEvent("ADDON_LOADED");--added for myaddons	
end

function ESell_Unregister_Our_Events()
	this:UnregisterEvent("UNIT_NAME_UPDATE");
	this:UnregisterEvent("BAG_UPDATE");
	this:UnregisterEvent("CRAFT_SHOW");
	this:UnregisterEvent("CRAFT_UPDATE");
	this:UnregisterEvent("BANKFRAME_OPENED");
	this:UnregisterEvent("BANKFRAME_CLOSED");
	this:UnregisterEvent("VARIABLES_LOADED");
	this:UnregisterEvent("SKILL_LINES_CHANGED");
	this:UnregisterEvent("ADDON_LOADED");--added for myaddons
end


function ESell_OnEvent(event, arg1, arg2)
	if (event == "SKILL_LINES_CHANGED") then
		if (ESell_isPlayerEnchanter()) then
			ESell_playerIsEnchanter=true;
			ESell_MiniMapIcon_Update();
		end
	end
	if(event == "ADDON_LOADED" and arg1 == "myAddOns") then
		if(myAddOnsFrame_Register) then
			myAddOnsFrame_Register(EnchantingSellDetails, EnchantingSellHelp);
		end
	end	
	if(event == "VARIABLES_LOADED") then
		ESell_VARIABLES_LOADED();
		ESell_AllVariableLoaded = true;
	end
	if (event == "BAG_UPDATE") then
		if ESell_AllVariableLoaded and ESell_IsEnterWord then
			ESell_Reagent_UpdateNbInBag();
			ESell_UpdateEnchantButton();	--hoping to update the "enchant it" button when a bag_update event is triggered
		end
	end
	if (event == "CRAFT_SHOW") then
		DebugMessage("a craft window was opened: "..GetCraftName());
		if (NAME_SPELL_CRAFT_ENCHANTE ~= GetCraftName()) then
			HideUIPanel(EnchantingSell_Frame);
		end
	end
	if (event == "BANKFRAME_OPENED") then
		EnchantingSell_BankIsOpen = true;
		ESell_Reagent_UpdateNbInBank();
	end
	if (event == "BANKFRAME_CLOSED") then
		EnchantingSell_BankIsOpen = false;
	end
	if (event == "UNIT_NAME_UPDATE") and arg1 == "player" then
		DebugMessage("new player");
		EnchantingSell_CourantPlayer = {UnitName("player"), GetCVar("realmName")};
	end
	if (event == "PLAYER_ENTERING_WORLD") then
		DebugMessage("Event PLAYER_ENTERING_WORLD");
		ESell_Register_Our_Events();
		EnchantingSell_CourantPlayer = {UnitName("player"), GetCVar("realmName")};
		ESell_MiniMapIcon_Update();
		ESell_IsEnterWord = true;
	end
	if (event == "PLAYER_LEAVING_WORLD") then
		DebugMessage("Event PLAYER_LEAVING_WORLD");
		ESell_Unregister_Our_Events();
	end
end

function ESell_Command(arg1)
	if arg1 == "CreateDefaultBd" then
		-- in order to create a default database that is stored in the saved variables file.
		for j, enchanteTable in ipairs(EnchantingSell_ListEnchante) do
			enchanteTable["IdOriginal"] = nil;
			enchanteTable["IsKnow"] = nil;
			enchanteTable["Price"] = nil;
			enchanteTable["PriceNoBenef"] = nil;
			enchanteTable["TypePrice"] = nil;
			enchanteTable["Reagents"]["Etat"] = -2;
			newEnchante = false;
		end
		for i, reagent in ipairs(EnchantingSell_ListComponant) do
			reagent["Description"] = nil;
			reagent["ByPlayer"] = nil;
			reagent["IsUse"] = nil;
		end
		ESellSvgEnchante ={};
		ESellSvgEnchante.Componantes = EnchantingSell_ListComponant;
		ESellSvgEnchante.Enchantes = EnchantingSell_ListEnchante;
		
		DEFAULT_CHAT_FRAME:AddMessage("Bd Create close the game and copie Bd in Localization file");
		return;
	else 
		ESell_Launch();
	end
end


function ESell_Launch()
	-- in order to create a default database that is stored in the saved variables file.
	if ESellSvgEnchante then ESellSvgEnchante = nil end
	
	ESell_InizalizeData();

	Toggle_EnchantingSell();
end

function ESell_VARIABLES_LOADED() 
	-- initialize our SavedVariable
	if (not EnchantingSell_Config) then
		DebugMessage("Update Config with the default values");
		EnchantingSell_Config = EnchantingSell_ConfigDefault;
	end

	if (not EnchantingSell_PlayerConfig) then
		DebugMessage("Initializing per-player config values");
		EnchantingSell_PlayerConfig = EnchantingSell_PlayerConfig_Default;
	end
end

function ESell_InizalizeData()
	DebugMessage("Initialization");

	local isEnchanteur = ESell_LaunchFunctionInCraftSpellFrame(
		function () 
			if ((not EnchantingSell_Config.EnchantorPlayerSelected) or ESell_Player_IsEq(EnchantingSell_Config.EnchantorPlayerSelected, EnchantingSell_CourantPlayer)) then
				if not EnchantingSell_Config.EnchantorPlayerSelected then
					ESell_Reagent_DeleteAllplayerCount();
					EnchantingSell_Config.EnchantorPlayerSelected = EnchantingSell_CourantPlayer;
				end
				ESell_Enchante_UpdateData();
				ESell_Reagent_UpdateData();
				ESell_Enchante_UpdateAllPrice();
			end
		end
	);
	if isEnchanteur then
		ESell_Player_EnchantorTableAddIfNew(EnchantingSell_CourantPlayer);
	end
	
	EnchantingSell_CourantPlayer = {UnitName("player"), GetCVar("realmName")};
	ESell_Reagent_UpdateNbInBag();

	DebugMessage("Finished Initialization");
end

function ESell_Player_EnchantorTableAddIfNew(argEnchantorPlayer)
	if not EnchantingSell_Config.EnchantorTable then
		EnchantingSell_Config.EnchantorTable = {};
	end
	for i, enchantorPlayer in EnchantingSell_Config.EnchantorTable do
		if ESell_Player_IsEq(enchantorPlayer, argEnchantorPlayer) then
			return; 
		end
	end
	DebugMessage("Ajout enchanteur dans la table config");	

	tinsert(EnchantingSell_Config.EnchantorTable, argEnchantorPlayer);
	ESell_Option_Enchanting_DropDownEnchantorPlayerSelect_Initialize();
end

function ESell_Player_IsEq(playerAgr1, playerAgr2)
	if (not playerAgr1) or (not playerAgr2) then return false end
	if (playerAgr1[1] == playerAgr2[1]) and (playerAgr1[2] == playerAgr2[2]) then
		return true
	end
	return false;
end

function ESell_EnchanteSort(nameColums)
	if not EnchantingSell_ListEnchante then return end
	DebugMessage(nameColums);
	if nameColums then
		ESell_EnchanteSort_Modifier(nameColums);
	end
	table.sort(EnchantingSell_ListEnchante, ESell_EnchanteSort_Sort);
end

function ESell_EnchanteSort_Modifier(nameColums)
	if nameColums == EnchantingSell_Config.EnchanteSortOn[1] then
		EnchanteSortTypeAZ = not EnchanteSortTypeAZ;
		return;
	end
	for index, value in EnchantingSell_Config.EnchanteSortOn do
		if nameColums == value then
			table.remove(EnchantingSell_Config.EnchanteSortOn, index);
			if nameColums == "Bonus" then
				table.remove(EnchantingSell_Config.EnchanteSortOn, (index));
				table.insert(EnchantingSell_Config.EnchanteSortOn, 1, "BonusNb");
			end
			table.insert(EnchantingSell_Config.EnchanteSortOn, 1, nameColums);
			break;
		end
	end
end

function ESell_EnchanteSort_Sort(e1,e2)
	local sortTemp = EnchantingSell_Config.EnchanteSortOn;
	if not EnchanteSortArmor or (e1["OnThis"] == e2["OnThis"]) then
		if e1["IsKnow"] == e2["IsKnow"] then
			if ((not EnchantingSell_PlayerConfig.CheckSortByDoCraft) or (e1["Reagents"].Etat == e2["Reagents"].Etat)) then
				if (e1[sortTemp[1]] == e2[sortTemp[1]]) then
					if e1[sortTemp[2]] == e2[sortTemp[2]] then
						if e1[sortTemp[3]] == e2[sortTemp[3]] then
							if e1[sortTemp[4]] == e2[sortTemp[4]] then
								return ESell_EnchanteSort_SortUnderFunction(e1,e2,5);
							else
								return ESell_EnchanteSort_SortUnderFunction(e1,e2,4);
							end
						else
							return ESell_EnchanteSort_SortUnderFunction(e1,e2,3);
						end
					else
						return ESell_EnchanteSort_SortUnderFunction(e1,e2,2);
					end
				else
					return ESell_EnchanteSort_SortUnderFunction(e1,e2,1);
				end
			else
				return ESell_EnchanteSort_SortByDoCraft(e1, e2);
			end
		else
			return ESell_EnchanteSort_SortByKnowEnchante(e1, e2);
		end
	else
		if (e1["OnThis"] == EnchanteSortArmor) then
			return true;		
		end 
		if (e1["OnThis"] == EnchanteSortArmor) then
			return false;		
		end 
	end
end

function ESell_EnchanteSort_SortUnderFunction(e1,e2,indexSortTemp)
	local sortTemp = EnchantingSell_Config.EnchanteSortOn;	
	if (e1[sortTemp[indexSortTemp]] == nil) or (e1[sortTemp[indexSortTemp]] == "") or (e1[sortTemp[indexSortTemp]] == 0) then
		return false;		
	end 
	if (e2[sortTemp[indexSortTemp]] == nil) or (e2[sortTemp[indexSortTemp]] == "") or (e2[sortTemp[indexSortTemp]] == 0) then
		return true;		
	end 
	if EnchanteSortTypeAZ then
		if (e1[sortTemp[indexSortTemp]] < e2[sortTemp[indexSortTemp]] )then
			return true;		
		else
			return false;
		end
	else
		if (e1[sortTemp[indexSortTemp]] > e2[sortTemp[indexSortTemp]] )then
			return true;		
		else
			return false;
		end
	end
end

function ESell_EnchanteSort_SortByDoCraft(e1, e2)
	if (e1["Reagents"].Etat == -1) or (not e1["Reagents"].Etat) then return false end
	if (e2["Reagents"].Etat == -1) or (not e2["Reagents"].Etat) then return true end
	if (e1["Reagents"].Etat < e2["Reagents"].Etat )then
		return true;		
	else
		return false;
	end
end

function ESell_EnchanteSort_SortByKnowEnchante(e1, e2)
	if not e1["IsKnow"] then return false end
	if not e2["IsKnow"] then return true end
end

function ESell_ResetAllData()
	DebugMessage("reset Data");	
	EnchantingSell_ListEnchante = nil;
	EnchantingSell_ListComponant = nil;
	EnchantingSell_Config = EnchantingSell_ConfigDefault;
	EnchantingSell_Msg:AddMessage(ENCHANTINGSELL_MSG_RESETBD, 0.8, 0.2, 0.2, 1.0, 5);
	SelectIdEnchante(nil);
	SelectIdComponant(nil);
	UpDateListeEnchante();
	UpDateListeComponant();
--~ 	if EnchantingSell_Frame:IsShown() then
--~ 		Toggle_EnchantingSell();
--~ 	end
	ESell_MiniMapIcon_Update();
	EnchantingSell_Config = EnchantingSell_ConfigDefault;
	ESell_InizalizeData();
--~ 	ESell_MiniMapIcon_Update();
end



--trying to reset pricing data here.  hopefully this will work as expected.
-- expectation
--	1.  clear the prices of all components.
--	2.  clear the prices of all enchants
--	3.  either rest the prices of components to 0, or get auction prices.
--	4.  update enchant prices based on the use auction or not.

function ESell_ResetPricingRelatedInfo()
	DebugMessage("ESell_ResetPricingRelatedInfo called");	
--	EnchantingSell_Msg:AddMessage(ENCHANTINGSELL_MSG_RESETBD, 0.8, 0.2, 0.2, 1.0, 5);

	SelectIdEnchante(nil);
	SelectIdComponant(nil);

	ESell_InizalizeData();

	ESell_Enchante_UpdateAllPrice();

end


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Gestion de la base des enchantements ---------------------------------------------------------------------------------------------------------------------------------------------

function ESell_Enchante_LoadDefaultData()
	if (not EnchantingSell_DefaultList.Enchantes) then
		EnchantingSell_Msg:AddMessage(ENCHANTINGSELL_MSG_ERREUR_NOTLOADDEFAULTBD, 1, 0.1, 0.1, 1.0, 5);
		return;
	end
	EnchantingSell_Msg:AddMessage(ENCHANTINGSELL_MSG_LOADDEFAULTBD, 1, 1, 1, 1.0, 5);
	EnchantingSell_ListEnchante = EnchantingSell_DefaultList.Enchantes;
--~ 	EnchantingSell_ListComponant = EnchantingSell_DefaultList.Componantes;
	ESell_Enchante_UpdateAllPrice();
	ESell_InizalizeData();
	EnchantingSell_Enchante_Frame_OnUpdate();
	EnchantingSell_Componant_Frame_OnUpdate();
--~ 	if EnchantingSell_Frame:IsShown() then
--~ 		Toggle_EnchantingSell();
--~ 	end
end

--~  update : All data; in EnchantingSell_ListEnchante; with Crafts list of CraftSpellFrame;
--~  run only if player is Enchantor and CraftSpellFrame open
function ESell_Enchante_UpdateData()
	if not EnchantingSell_ListEnchante then
		EnchantingSell_ListEnchante = {};
	end
	
	DebugMessage("ESell_Enchante_UpdateData: update of the base enchants");

	ESell_Enchante_UpDateAllKnowByEnchantorAtFalse();

	-- iterate all the enchantements to find their information
	for i=1, GetNumCrafts(), 1 do
		local name, craftSubSpellName, craftType, numAvailable, isExpanded, trainingPointCost, requiredLevel = GetCraftInfo(i);
		local enchanteReagents = {};
		local nameOnly, bonusTexte, onThis, bonus, bonusNb;
		
	-- if the craftType=="header", then we need to skip this one.  Header is used for defining groups of enchants. 
	-- ie.  Boots, Bracer, Gloves are "headers"
		if (craftType~="header") then
		
		-- Seek all Reagents of enchants and place into tmp table (enchanteReagents)
			local numReagents = GetCraftNumReagents(i);
			for j=1, numReagents, 1 do
				local reagentName, reagentTexture, reagentCount = GetCraftReagentInfo(i, j);
				tinsert(enchanteReagents, {Name = reagentName, Count = reagentCount});
			end
		
		-- Seperate the name and the bonus from the craft name --ie.. name = Enchant Boots - Lesser Stamina
			--ie.. nameOnly = Enchant Boots
			_,_,nameOnly = string.find(name, EnchantingSell_ForTakeNameCaracBonusModel);
			--ie.. bonusTexte = Lesser Stamina
			_,_,bonusTexte = string.find(name, EnchantingSell_ForTakeQualityBonusModel);

			DebugMessage("ESell_Enchante_UpdateData nameOnly is "..isNullOrValue(nameOnly).. ", bonusTexte is "..isNullOrValue(bonusTexte));
			
			--for crafts that do not fit the above patterns, then nameOnly = name.  ie...Runed Arcanite Rod
			if not nameOnly then nameOnly = name end

			
		-- Seek on which equipment one can put enchantment
			for j, Armor in ipairs(EnchantingSell_ArmorCarac) do
				if string.find(nameOnly, Armor[1]) then
					DebugMessage("ESell_Enchante_UpdateData Armor[1] is "..isNullOrValue(Armor[1]) .. ", Armor[2] "..Armor[2]);
					onThis = Armor[2];
					break;
				end
			end

		-- if onThis has not been determined, it may be a rod or wand
			if not onThis  then 
				for j, nameObj in EnchantingSell_Objet do
					if nameObj[1] == nameOnly then
						onThis = nameObj[3];
						bonus = nameObj[2];
						break;
					end
				end
			end

		-- if not able to determine onThis, then make it other.
			if not onThis then onThis = EnchantingSell_ArmorCarac.Other end

			DebugMessage("ESell_Enchante_UpdateData onThis is "..isNullOrValue(onThis));

		-- Seek Type and Bonus value for each enchantment
			if (bonusTexte) then
				-- Seek the Type of the no-claims bonus in the EnchantingSell_BonusCarac.Type table
				-- In order to indicate the more readable no-claims bonus and more room in the list
				for j, bonusCarac in EnchantingSell_BonusCarac do
					-- Seek the Type of no-claims bonus
					-- Also test, if particular case or case normal
					if ((string.find(bonusTexte, bonusCarac[1])) and ((not bonusCarac[4]) or (bonusCarac[4] == onThis))) then
						bonus = bonusCarac[2];
						-- Si une table de Bonus existe pour le Type trouvé recherche du bonus dans la table EnchantingSell_Quality referencé dans EnchantingSell_BonusCarac["Type"][j][2]
						if (bonusCarac[3]) then
							local bonustextetmp = bonusTexte;
							-- Si bonusTexte = bonuscarac sans supplement, alors le bonusNb = bonus standard soit la valeur 3 dans les tables EnchantingSell_Quality						
							if (string.len(bonusTexte) == string.len(bonusCarac[1])) then
	--~ 							bonusNb = bonusCarac[3][3][2];
	--~ 							break;
								bonustextetmp = "None";
							end				
							-- Si supplement alors recherche dans la table EnchantingSell_Quality referencé dans EnchantingSell_BonusCarac[j][3] le bonus 
							for k, bonusAdd in bonusCarac[3] do
								-- Si bonus trouvé alors 'bonusNb' est mis a jour avec la valeur bonusAdd de la table EnchantingSell_Quality
								if string.find(bonustextetmp, bonusAdd[1]) then
									bonusNb = bonusAdd[2];
									break;
								end
							end
						end
						break;
					end
				end

				-- Si aucune table de type de bonus ne correspond mettre directement la descrition tel quel dans 'bonus'
				if not bonus then
					bonus = bonusTexte;
				end
			end

		-- if onThis has not been determined, it may be an Oil
			if not bonus  then 
				for j, nameObj in EnchantingSell_Objet do
					if nameObj[1] == nameOnly then
						bonus = nameObj[2];
						break;
					end
				end
			end

				
			local newEnchante = true;
			-- Update the table of the enchantements
			for j, enchanteTable in ipairs(EnchantingSell_ListEnchante) do
				if (name == enchanteTable["LongName"]) and (GetCraftDescription(i) == enchanteTable["Description"]) then
	--~ 				DebugMessage("update enchante");
					enchanteTable["IdOriginal"] = i;
					enchanteTable["LongName"] = name;
					enchanteTable["Name"] = nameOnly;
					enchanteTable["Description"] = GetCraftDescription(i);
					enchanteTable["Icon"] = GetCraftIcon(i);
					enchanteTable["OnThis"] = onThis;
					enchanteTable["Bonus"] = bonus;
					enchanteTable["BonusNb"] = bonusNb;
					enchanteTable["Reagents"] = enchanteReagents;
					enchanteTable["Required"] = GetCraftSpellFocus(i);
					enchanteTable["Link"] = GetCraftItemLink(i);
					enchanteTable["IsKnow"] = true;
					newEnchante = false;
					break;
				end
			end
			if newEnchante then
				DebugMessage("new enchante");
				tinsert( EnchantingSell_ListEnchante, {
					["IdOriginal"] = i ,
					["LongName"] = name,
					["Name"] = nameOnly,
					["Description"] = GetCraftDescription(i),
					["Icon"] = GetCraftIcon(i),
					["OnThis"] = onThis,
					["Bonus"] = bonus,
					["BonusNb"] = bonusNb,
					["Reagents"] = enchanteReagents,
					["Required"] = GetCraftSpellFocus(i),
					["Link"] = GetCraftItemLink(i),
					["IsKnow"] = true,
				});
			end
		end
	end

	ESell_EnchanteSort();
	EnchantingSell_ListEnchante.VersionBd = ESell_getNumVerToLongNum();
 	DebugMessage("Fin de l'update data enchante; data ver : "..EnchantingSell_ListEnchante.VersionBd);
end

function ESell_Enchante_UpDateAllKnowByEnchantorAtFalse()
	DebugMessage("Tous enchantement sur non connu");	

	if not EnchantingSell_ListEnchante then return end
	for i, enchanteTable in ipairs(EnchantingSell_ListEnchante) do
		enchanteTable["IsKnow"] = false;
	end
end

function ESell_Enchante_getUserTablePrice()
	local tableReturn = {};
	if EnchantingSell_ListEnchante then
		for i, enchanteTable in ipairs(EnchantingSell_ListEnchante) do
			if 	enchanteTable["TypePrice"] == 2 then
				tinsert(tableReturn, {
					["Name"] = enchanteTable["Name"];
					["Description"] = enchanteTable["Description"];
					["Price"] = enchanteTable["Price"];
				});
			end
		end
	end
	return tableReturn;
end

--~  return : numEnchante; in EnchantingSell_ListEnchante
function ESell_Enchante_getNb()
	if EnchantingSell_ListEnchante then
		return getn(EnchantingSell_ListEnchante);
	end
	return 0;
end

--~  get : idEnchante; and return : shortName, onThis, bonusType, bonusValue, Link; in EnchantingSell_ListEnchante
function ESell_Enchante_getInfoBonus(idEnchante)
	if idEnchante and EnchantingSell_ListEnchante[idEnchante] then
		return EnchantingSell_ListEnchante[idEnchante]["Name"], EnchantingSell_ListEnchante[idEnchante]["OnThis"], EnchantingSell_ListEnchante[idEnchante]["Bonus"], EnchantingSell_ListEnchante[idEnchante]["BonusNb"], EnchantingSell_ListEnchante[idEnchante]["Link"];
	end
	return nil;
end

--~  get : idEnchante; and return : longName, icon, description, required, itemLink; in EnchantingSell_ListEnchante
function ESell_Enchante_getInfoDetail(idEnchante)
	if idEnchante and EnchantingSell_ListEnchante[idEnchante] then
		return EnchantingSell_ListEnchante[idEnchante]["LongName"], EnchantingSell_ListEnchante[idEnchante]["Icon"], EnchantingSell_ListEnchante[idEnchante]["Description"], EnchantingSell_ListEnchante[idEnchante]["Required"], EnchantingSell_ListEnchante[idEnchante]["Link"];
	end
	return nil;
end

--~  get : nameEnchante; and return : idEnchante; in EnchantingSell_ListEnchante
function ESell_Enchante_getId(nameEnchante)
	if nameEnchante then
		for idEnchante in EnchantingSell_ListEnchante do
			if EnchantingSell_ListEnchante[idEnchante]["LongName"] == nameEnchante then
				return idEnchante;
			end
		end
	end
	return nil;
end

--~  get : idEnchante; and return : idOriginalEnchante; in EnchantingSell_ListEnchante
--~  idOriginal utilisé dans le traitement des enchantes dans la fenetre CraftSpell
function ESell_Enchante_getIdOriginal(idEnchante)
	if idEnchante and EnchantingSell_ListEnchante[idEnchante] then
		return EnchantingSell_ListEnchante[idEnchante]["IdOriginal"];
	end
	return nil;
end

--~  get : idEnchante; and return : numOfReagentNeeded; in EnchantingSell_ListEnchante
function ESell_Enchante_getNumReagent(idEnchante)
	if (not EnchantingSell_ListEnchante) or (not EnchantingSell_ListEnchante[idEnchante]) or (not EnchantingSell_ListEnchante[idEnchante]["Reagents"]) then
		return nil;
	end
	return getn(EnchantingSell_ListEnchante[idEnchante]["Reagents"]);
end

--~  get : idEnchante, idReagent; and return : coutReagentNeeded, nameReagent; in EnchantingSell_ListEnchante
function ESell_Enchante_getInfoReagent(idEnchante, idReagent)
	if (not EnchantingSell_ListEnchante[idEnchante]) or (not EnchantingSell_ListEnchante[idEnchante]["Reagents"][idReagent]) then
		return nil;
	end
	return EnchantingSell_ListEnchante[idEnchante]["Reagents"][idReagent].Count, EnchantingSell_ListEnchante[idEnchante]["Reagents"][idReagent].Name;
end

--~  update : Price, TypePrice, PriceNoBenef for all enchantes; in EnchantingSell_ListEnchante; with priceReagent in EnchantingSell_ListComponant
function ESell_Enchante_UpdateAllPrice()
	DebugMessage("Calcul des prix pour tt les enchantement");
	for idEnchante=1, ESell_Enchante_getNb(), 1 do
		ESell_Enchante_UpdatePrice(idEnchante)
	end
	DebugMessage("Fin du calcul de prix");
end

--~  update : Price, TypePrice, PriceNoBenef; in EnchantingSell_ListEnchante; with priceReagent in EnchantingSell_ListComponant
function ESell_Enchante_UpdatePrice(idEnchante)
	if not idEnchante then return end

	local price = 0;
	local isGoodPrice = 1;
	for numComponant=1, ESell_Enchante_getNumReagent(idEnchante),1 do
		local count, name = ESell_Enchante_getInfoReagent(idEnchante, numComponant);
		local idReagent = ESell_Reagent_getId(name);
--~ 		local NbBag, NbBank, NbReroll = ESell_Reagent_getCount(idReagent, EnchantingSell_CourantPlayer);
		local priceUnite = ESell_Reagent_getPrice(idReagent);
		if not priceUnite or priceUnite == 0 then isGoodPrice = -1;  priceUnite = 0 end
		price = price + (priceUnite*count);
	end

	EnchantingSell_ListEnchante[idEnchante]["PriceNoBenef"] = price;
	
	if EnchantingSell_ListEnchante[idEnchante]["TypePrice"] ~= 2 then
		price = floor(price * EnchantingSell_PlayerConfig.PourcentageBenefice);

		if not EnchantingSell_Config.EnchantePriceTypeCalculate then EnchantingSell_Config.EnchantePriceTypeCalculate = 1 end
		local priceType = EnchantingSell_Config.EnchantePriceTypeCalculate;
		local pricerounded = 0;
		local goldprice = ESell_Money_getMoney("Gold", price);
		local silverprice = ESell_Money_getMoney("Silver", price);
		local copperprice = ESell_Money_getMoney("Copper", price);
		if priceType == 1 then pricerounded = price end
		if priceType == 2 then
			if goldprice ~= 0 then
				pricerounded = floor(goldprice*10000 + silverprice*100);
				if copperprice ~= 0 then pricerounded = pricerounded+100 end
			else
				pricerounded = price;
			end
		end
		if priceType == 3 then
			if goldprice ~= 0 then
				pricerounded = floor(goldprice*10000);
				if silverprice ~= 0 then pricerounded = pricerounded+10000 end
			else
				if silverprice ~= 0 then
					pricerounded = floor(silverprice*100);
					if copperprice ~= 0 then pricerounded = pricerounded+100 end
				else
					pricerounded = price;
				end
			end
		end
		
		EnchantingSell_ListEnchante[idEnchante]["Price"] = pricerounded;
		EnchantingSell_ListEnchante[idEnchante]["TypePrice"] = isGoodPrice;
	end
end

--~  get : idEnchante; and return : price, typePrice, priceNoBenef; in EnchantingSell_ListEnchante
function ESell_Enchante_getPrice(idEnchante)
	local price = EnchantingSell_ListEnchante[idEnchante]["Price"];
	local priceNoBenef = EnchantingSell_ListEnchante[idEnchante]["PriceNoBenef"];
	local isGoodPrice = EnchantingSell_ListEnchante[idEnchante]["TypePrice"];
	return price, isGoodPrice, priceNoBenef;
end


------------------------------------------------------------------------------------------------------
--~  Management of the inventory position ------------------------ Gestion de l'etat des stocks ------
--~  1: Sufficient quantity in bags								-- Quantité suffisante dans les sacs,
--~  2: Sufficient quantity in bags								-- Quantité suffisante dans sacs et bank(player principal),
--~  3: Sufficient quantity in bags, bank(Enchantor) and reroll	-- Quantité suffisante dans sacs, bank(Enchanteur) et reroll,
--~  4: Not sufficient quantity									-- Quantité insuffisante.

--~  update : InvotoryPositionOfNumAllReagentAndRequired; in EnchantingSell_ListEnchante;
--~  	with numInBag, numInBank; for all player in EnchantingSell_ListComponant
function ESell_Enchante_UpdateEtat()
	DebugMessage("UpdateEtatEnchante");	
	for idEnchante=1, ESell_Enchante_getNb(), 1 do
		local etatForThisEnchante = ESell_Enchante_getRequiredEtat(idEnchante);
		if EnchantingSell_ListEnchante[idEnchante]["IsKnow"] then
			for idReagent=1, getn(EnchantingSell_ListEnchante[idEnchante]["Reagents"]), 1 do
				local etat = ESell_Enchante_getReagentEtat(idEnchante, idReagent);
				if (etat > etatForThisEnchante) then
					etatForThisEnchante = etat;
				end
			end
		else
			etatForThisEnchante = -2;
		end
		EnchantingSell_ListEnchante[idEnchante]["Reagents"].Etat = etatForThisEnchante;
	end
end

--~  get : idEnchante; and return : InvotoryPosition; in EnchantingSell_ListEnchante;
function ESell_Enchante_getEtat(idEnchante)
	--the index into EnchantingSell_ListEnchante array starts at 1.  
	-- so idEnchante needs to be a number higher than 0
	-- it cannot be 0
	-- it cannot be nil or undefined.
	-- it also cannot be higher than the EnchantingSell_ListEnchante index, which is ESell_Enchante_getNb

	if (idEnchante==nil) or (not idEnchante) or ((idEnchante > ESell_Enchante_getNb()) or (idEnchante < 1)) then
		return nil;
	end
	return EnchantingSell_ListEnchante[idEnchante]["Reagents"].Etat;
end


--~  get : idEnchante, idReagent; and return : InvotoryPositionNumReagent; in EnchantingSell_ListEnchante;
--~  	with numInBag, numInBank; for all player in EnchantingSell_ListComponant
function ESell_Enchante_getReagentEtat(idEnchante, idReagent)
	if not idEnchante or not idReagent then return end
	local etat = 1;
	local count, name = ESell_Enchante_getInfoReagent(idEnchante, idReagent);
	local nbInBag, nbInBank, nbInReroll = ESell_Reagent_getCount(ESell_Reagent_getId(name), EnchantingSell_Config.EnchantorPlayerSelected);
	if not nbInBag then return 4 end
	if (nbInBag < count) then
		etat = 2;
		if ((nbInBag + nbInBank) < count) then
			etat = 3;
			if ((nbInBag + nbInBank + nbInReroll) < count) then
				etat = 4;
			end
		end
	end
	return etat;
end

--~  get : idEnchante; and return : InvotoryPositionRequired; in EnchantingSell_ListEnchante;
--~  	with numInBag, numInBank; for playerEnchanting in EnchantingSell_ListComponant["Required"]
function ESell_Enchante_getRequiredEtat(idEnchante)
	if not EnchantingSell_ListComponant then return end
	local etat = 1;
	local nameRequired = EnchantingSell_ListEnchante[idEnchante]["Required"];
	if nameRequired then
		for required = 1, getn(EnchantingSell_ListComponant["Required"]) do
			if nameRequired == EnchantingSell_ListComponant["Required"][required]["Name"] then
				if not EnchantingSell_ListComponant["Required"][required]["NbInBag"] or EnchantingSell_ListComponant["Required"][required]["NbInBag"] == 0 then
					etat = 2;
					if not EnchantingSell_ListComponant["Required"][required]["NbInBank"] or EnchantingSell_ListComponant["Required"][required]["NbInBank"] == 0 then
						etat = 4;
					end
				end
			end
		end
	end
	return etat;
end

--~  get : idEnchante; and return : CountMakedWithBag, CountMakedWhitBagAndBank, CountMakedWithBagBankAndReRoll; in EnchantingSell_ListEnchante;
function ESell_Enchante_getCountMaked(idEnchante)
	local numReagent = ESell_Enchante_getNumReagent(idEnchante);
	local makeBagCount = nil;
	local makeBankCount = nil;
	local makeReRCount = nil;
	for i=1, numReagent, 1 do
		local mBgC, mBkC, mRC;
		local coutReagentNeeded, nameReagent = ESell_Enchante_getInfoReagent(idEnchante, i);
		local nbInBag, nbInBank, nbInReroll = ESell_Reagent_getCount(ESell_Reagent_getId(nameReagent), EnchantingSell_Config.EnchantorPlayerSelected);
		if (nbInBag + nbInBank + nbInReroll) >= coutReagentNeeded then
			mRC = floor((nbInBag + nbInBank + nbInReroll)/coutReagentNeeded);
		else
			makeBagCount = 0;
			makeBankCount = 0;
			makeReRCount = 0;
			break;
		end
		if (nbInBag + nbInBank) >= coutReagentNeeded then
			mBkC = floor((nbInBag + nbInBank)/coutReagentNeeded);
		else
			makeBankCount = 0;
		end
		if nbInBag >= coutReagentNeeded then
			mBgC = floor(nbInBag/coutReagentNeeded);
		else
			makeBagCount = 0;
		end
		if (not makeBagCount) or (makeBagCount > 1) then
			if makeBagCount then
				if makeBagCount > mBgC then
					makeBagCount = mBgC;
				end
			else
				makeBagCount = mBgC;
			end
		end
		if (not makeBankCount) or (makeBankCount > 1) then
			if makeBankCount then
				if makeBankCount > mBkC then
					makeBankCount = mBkC;
				end
			else
				makeBankCount = mBkC;
			end
		end
		if (not makeReRCount) or (makeReRCount > 1) then
			if makeReRCount then
				if makeReRCount > mRC then
					makeReRCount = mRC;
				end
			else
				makeReRCount = mRC;
			end
		end
	end
	return makeBagCount, makeBankCount, makeReRCount;
end
------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Management of BD Reagents --------------------- Gestion de la base de composants -------------------------------------------------------------------------------------------------------------

function ESell_Reagent_LoadDefaultData()
	if (not EnchantingSell_DefaultList.Componantes) then
		EnchantingSell_Msg:AddMessage(ENCHANTINGSELL_MSG_ERREUR_NOTLOADDEFAULTBD, 1, 0.1, 0.1, 1.0, 5);
		return;
	end
	EnchantingSell_Msg:AddMessage(ENCHANTINGSELL_MSG_LOADDEFAULTBD, 1, 1, 1, 1.0, 5);
--~ 	EnchantingSell_ListEnchante = nil;
	EnchantingSell_ListComponant = EnchantingSell_DefaultList.Componantes;
	EnchantingSell_ListComponant["Required"] = {};
	for i, reagent in ipairs(EnchantingSell_ListComponant) do
		reagent["Description"] = ESell_Reagent_getDescriptionDefault(reagent["Name"]);
	end
	ESell_Reagent_UpdateNbInBag();
	ESell_Enchante_UpdateAllPrice();
	ESell_InizalizeData();
	
	EnchantingSell_Enchante_Frame_OnUpdate();
	EnchantingSell_Componant_Frame_OnUpdate();
--~ 	if EnchantingSell_Frame:IsShown() then
--~ 		Toggle_EnchantingSell();
--~ 	end
end

function ESell_Reagent_DeleteAllplayerCount()
	DebugMessage("Delete quantité par player");	
	if not EnchantingSell_ListComponant then return end
	for i, reagentTable in ipairs(EnchantingSell_ListComponant) do
		reagentTable["ByPlayer"] = nil;
	end
end



--~  update : All data; in EnchantingSell_ListComponant; with Crafts list of CraftSpellFrame;
--~  run only if player is Enchantor and CraftSpellFrame open
function ESell_Reagent_UpdateData()
	local index = 0;
	local numComponante = 0;

	-- Teste si des données exist sinon chage les données par defaut
	if (ESell_Reagent_getNb() ~= 0) then
		DebugMessage("Base de composant en memoire");
	else 
		EnchantingSell_ListComponant = {};
	end

	numComponante = ESell_Reagent_getNb();
	
	ESell_Reagent_UpDateAllUseByEnchantorAtFalse();


	-- Recherche les Composants suivant la liste des crafts disponibles
	-- Mise a jour et ajouts des Composants manquants
	for i=1, GetNumCrafts(), 1 do

		local name, craftSubSpellName, craftType, numAvailable, isExpanded = GetCraftInfo(i);

		local required = GetCraftSpellFocus(i);
		local testRequiredIsAdd = true;
		if not EnchantingSell_ListComponant["Required"] then
			EnchantingSell_ListComponant["Required"] = {};
		end
		if required then
			nbRequire = getn(EnchantingSell_ListComponant["Required"])
			for idRequire=1, nbRequire,1 do
				if EnchantingSell_ListComponant["Required"][idRequire]["Name"] == required then
					testRequiredIsAdd = false;
				end
			end
			if testRequiredIsAdd then
				nbRequire = nbRequire + 1
				EnchantingSell_ListComponant["Required"][nbRequire]={};
				EnchantingSell_ListComponant["Required"][nbRequire]["Name"] =required;
				EnchantingSell_ListComponant["Required"][nbRequire]["NbInBag"] = 0;
				EnchantingSell_ListComponant["Required"][nbRequire]["NbInBank"] = 0;
			end
		end
--		DebugMessage(skillName.." "..skillType.." "..numAvailable.." "..isExpanded);
--		DebugMessage(name.." . "..craftSubSpellName.." . "..craftType.." . "..numAvailable.." . "..isExpanded);
		
		if (craftType ~="header") then
		
			enchanteReagents = {Nb=GetCraftNumReagents(i)};
			if enchanteReagents.Nb then
				if enchanteReagents.Nb ~= 0 then
					for j=1, enchanteReagents.Nb, 1 do
						local reagentName, reagentTexture, reagentCount, playerReagentCount = GetCraftReagentInfo(i, j);
						local reagentlink = GetCraftReagentItemLink(i,j);
						local testAjout = true;
						for k=1, numComponante,1 do
							if EnchantingSell_ListComponant[k]["Name"] == reagentName then
								if (not EnchantingSell_ListComponant[k]["Description"]) then
									EnchantingSell_ListComponant[k]["Description"] = ESell_Reagent_getDescriptionDefault(EnchantingSell_ListComponant[k]["Name"]);
								end
								EnchantingSell_ListComponant[k]["IsUse"] = true;
								testAjout = false;
							end
						end
						if testAjout then
							DebugMessage("Ajout d'un element dans la base composant");
							numComponante = numComponante +1;
							EnchantingSell_ListComponant[numComponante] ={};
							EnchantingSell_ListComponant[numComponante]["ByPlayer"] ={};
							EnchantingSell_ListComponant[numComponante]["Texture"] = reagentTexture;
							EnchantingSell_ListComponant[numComponante]["Link"] = reagentlink;
							EnchantingSell_ListComponant[numComponante]["PriceUnite"] = 0;
							EnchantingSell_ListComponant[numComponante]["Name"] = reagentName;
							EnchantingSell_ListComponant[numComponante]["Description"] = ESell_Reagent_getDescriptionDefault(reagentName);
							EnchantingSell_ListComponant[numComponante]["IsUse"] = true;							
						end
						
					end
				end
			end
		end		
	end
	DebugMessage("Fin prise de data componante");
	EnchantingSell_ListComponant.VersionBd = ENCHANTINGSELL_VERSION;
	ESell_Reagent_UpdateNbInBag();
end

function ESell_Reagent_UpDateAllUseByEnchantorAtFalse()
	DebugMessage("Udate tous reagente sur non use");	
	if not EnchantingSell_ListComponant then return end
	for i, ReagentTable in ipairs(EnchantingSell_ListComponant) do
		ReagentTable["IsUse"] = false;
	end
end


--~  update : countInBag; in EnchantingSell_ListComponant;
function ESell_Reagent_UpdateNbInBag()
	DebugMessage("Update nb in bag");	
	for Componant=1, ESell_Reagent_getNb(), 1 do
		if ESell_Reagent_InizializeNewPlayer(Componant, EnchantingSell_CourantPlayer) then
			EnchantingSell_ListComponant[Componant]["ByPlayer"][EnchantingSell_CourantPlayer[1]]["NbInBag"] = 0;
		end
	end
	if EnchantingSell_Config and ESell_Player_IsEq(EnchantingSell_CourantPlayer, EnchantingSell_Config.EnchantorPlayerSelected) and EnchantingSell_ListComponant["Required"] then
		for required=1, getn(EnchantingSell_ListComponant["Required"]), 1 do
			EnchantingSell_ListComponant["Required"][required]["NbInBag"] = 0;
		end
	end
	for container=0, 4, 1 do
		for slot=1, GetContainerNumSlots(container), 1 do
			local itemName = ESell_NameFromLink(GetContainerItemLink(container,slot)) ;
			for Componant=1, ESell_Reagent_getNb(), 1 do
				if (itemName == EnchantingSell_ListComponant[Componant]["Name"]) and (EnchantingSell_ListComponant[Componant]["Name"]) then
					local texture, itemCount = GetContainerItemInfo(container,slot);
					if ESell_Reagent_InizializeNewPlayer(Componant, EnchantingSell_CourantPlayer) then
						EnchantingSell_ListComponant[Componant]["ByPlayer"][EnchantingSell_CourantPlayer[1]]["NbInBag"] = itemCount + EnchantingSell_ListComponant[Componant]["ByPlayer"][EnchantingSell_CourantPlayer[1]]["NbInBag"];
					end
				end
			end
			if EnchantingSell_Config and ESell_Player_IsEq(EnchantingSell_CourantPlayer, EnchantingSell_Config.EnchantorPlayerSelected) and
				EnchantingSell_ListComponant["Required"] then
				for required=1, getn(EnchantingSell_ListComponant["Required"]), 1 do
					if (itemName == EnchantingSell_ListComponant["Required"][required]["Name"]) then
						local texture, itemCount = GetContainerItemInfo(container,slot);
						EnchantingSell_ListComponant["Required"][required]["NbInBag"] = itemCount + EnchantingSell_ListComponant["Required"][required]["NbInBag"];
					end
				end
			end
		end
	end	
	ESell_Reagent_UpdateNbInBank();
end
--~  update : countInBank; in EnchantingSell_ListComponant;
function ESell_Reagent_UpdateNbInBank()
	if EnchantingSell_BankIsOpen then
		DebugMessage("Modif base composant bank");
		for Componant=1, ESell_Reagent_getNb(), 1 do
			if ESell_Reagent_InizializeNewPlayer(Componant, EnchantingSell_CourantPlayer) then
				EnchantingSell_ListComponant[Componant]["ByPlayer"][EnchantingSell_CourantPlayer[1]]["NbInBank"]=0;
			end
		end
		if EnchantingSell_Config and ESell_Player_IsEq(EnchantingSell_CourantPlayer, EnchantingSell_Config.EnchantorPlayerSelected) and 
			EnchantingSell_ListComponant["Required"] then
			for required=1, getn(EnchantingSell_ListComponant["Required"]), 1 do
				EnchantingSell_ListComponant["Required"][required]["NbInBank"] = 0;
			end
		end
		for container=-1, (GetNumBankSlots()+4), 1 do
			if (container == 0) then container = 5 end
			for slot=1, GetContainerNumSlots(container), 1 do
				local itemName = ESell_NameFromLink(GetContainerItemLink(container,slot)) ;
--				DebugMessage(itemName);
				for Componant=1, ESell_Reagent_getNb(), 1 do
					if itemName == EnchantingSell_ListComponant[Componant]["Name"] and (EnchantingSell_ListComponant[Componant]["Name"]) then
						local texture, itemCount, locked, quality, readable = GetContainerItemInfo(container,slot);
						if ESell_Reagent_InizializeNewPlayer(Componant, EnchantingSell_CourantPlayer) then
							EnchantingSell_ListComponant[Componant]["ByPlayer"][EnchantingSell_CourantPlayer[1]]["NbInBank"]=(itemCount + EnchantingSell_ListComponant[Componant]["ByPlayer"][EnchantingSell_CourantPlayer[1]]["NbInBank"]);
						end
					end
				end
				if ESell_Player_IsEq(EnchantingSell_CourantPlayer, EnchantingSell_Config.EnchantorPlayerSelected) and
					EnchantingSell_ListComponant["Required"] then
					for required=1, getn(EnchantingSell_ListComponant["Required"]), 1 do
						if (itemName == EnchantingSell_ListComponant["Required"][required]["Name"]) then
							local texture, itemCount = GetContainerItemInfo(container,slot);
							EnchantingSell_ListComponant["Required"][required]["NbInBank"] = itemCount + EnchantingSell_ListComponant["Required"][required]["NbInBank"];
						end
					end
				end
			end
		end
	end
	ESell_Enchante_UpdateEtat();
	
	EnchantingSell_Componant_Frame_OnUpdate();
	EnchantingSell_Enchante_Frame_OnUpdate();
end

-- Inizialization d'un nouv player pour les quantités composants ------------------------------
function ESell_Reagent_InizializeNewPlayer(Reagent, player)
	if not Reagent or not player or not EnchantingSell_ListComponant or not EnchantingSell_ListComponant[Reagent] then return end
	if (EnchantingSell_Config.EnchantorPlayerSelected) and (player[2] ~= EnchantingSell_Config.EnchantorPlayerSelected[2]) then
		return nil;
	end
	local namePlayer = player[1];
	if (not EnchantingSell_ListComponant[Reagent]["ByPlayer"]) then
		EnchantingSell_ListComponant[Reagent]["ByPlayer"] = {};
		DebugMessage("inisialize ByPlayer for on reagant");	
	end
	if (not EnchantingSell_ListComponant[Reagent]["ByPlayer"][namePlayer]) then
		DebugMessage("inisialize new playerCount "..namePlayer.." for on reagant");	
 		EnchantingSell_ListComponant[Reagent]["ByPlayer"][namePlayer] = {};
		EnchantingSell_ListComponant[Reagent]["ByPlayer"][namePlayer]["NbInBag"] = 0;
		EnchantingSell_ListComponant[Reagent]["ByPlayer"][namePlayer]["NbInBank"] = 0;
	end
	return true;
end
-----------------------------------------------------------------------------------------------
--~  return : numreagent; in EnchantingSell_ListComponant;
function ESell_Reagent_getNb()
	if EnchantingSell_ListComponant then
		return getn(EnchantingSell_ListComponant);
	end
	return 0;
end

--~  get : nameReagent; and return : DescritionDefaultReagent; in DescritionDefaultReagents table in localization file;
function ESell_Reagent_getDescriptionDefault(nameReagent)
	description = "";
	for i=1, getn(DescritionDefaultReagents), 1 do
		if (nameReagent == DescritionDefaultReagents[i].Name) then
			description = DescritionDefaultReagents[i].Description;
		end
	end
	return description;
end

-- Prise d'info sur les ingredients -----------------------------------------------------------------
function ESell_Reagent_getId(reagentName)
	for idComponant=1, ESell_Reagent_getNb(), 1 do
		local name = EnchantingSell_ListComponant[idComponant].Name;
		if (name == reagentName) then
			return idComponant;
		end
	end
	return nil;
end

function ESell_Reagent_getInfo(reagentId)
	if not reagentId then return end
	if reagentId <= getn(EnchantingSell_ListComponant) then
		return EnchantingSell_ListComponant[reagentId].Name, EnchantingSell_ListComponant[reagentId].Texture, EnchantingSell_ListComponant[reagentId].Description, EnchantingSell_ListComponant[reagentId].Link;
	end
	return nil;
end

function ESell_Reagent_getPrice_default(idReagent)
	if not idReagent then return end
	if idReagent <= getn(EnchantingSell_ListComponant) then
		return EnchantingSell_ListComponant[idReagent].PriceUnite;
	end
	return nil;
end

function isNullOrFalse(value)
	if (value) then 
		return true;
	else 
		return false;
	end
end

function isNullOrValue(value)
	if (value) then 
		return value;
	else 
		return "nil";
	end
end

function getTrueOrFalse(value)
	if (value) then 
		return "true";
	else 
		return "false";
	end
end

function ES_getAuctioneerPrice(idReagent)
	if idReagent <= getn(EnchantingSell_ListComponant) then
		if not EnchantingSell_ListComponant[idReagent].Link then
		   return EnchantingSell_ListComponant[idReagent].PriceUnite;
		else
		   --updated for versions greater than auctioneerpack-3.2.0.0671+
		   local itemID, randomProp, enchant, uniqID, name;
		   if (Auctioneer_BreakLink) then
			DebugMessage("using Auctioneer_BreakLink");
			itemID, randomProp, enchant, uniqID, name = Auctioneer_BreakLink(EnchantingSell_ListComponant[idReagent].Link);

		   ---Auctioneer_BreakLink no longer exists..instead call EnhTooltip.BreakLink
		   elseif (EnhTooltip.BreakLink) then 
			DebugMessage("using EnhTooltip.BreakLink");
			itemID, randomProp, enchant, uniqID, name = EnhTooltip.BreakLink(EnchantingSell_ListComponant[idReagent].Link);

		   else 
			ErrorMessage("auctioneer BreakLink function not found. Using default prices.");
			return EnchantingSell_ListComponant[idReagent].PriceUnite;
		   end

		   local itemKey = itemID..":"..randomProp..":"..enchant;	
		   local medianPrice, medianCount;

		   DebugMessage("itemKey is "..itemKey);

		   --for auctioneer auctioneerpack-3.2.0.0671+
		   if (Auctioneer and Auctioneer.Statistic and Auctioneer.Statistic.GetUsableMedian) then
			DebugMessage("using auctioneerpack-3.2.0.0671+ method getUsableMedian(itemKey)");
			medianPrice, medianCount = Auctioneer.Statistic.GetUsableMedian(itemKey);

		   --for auctioneer beta 3.1 -> auctioneerpack-3.2.0.0620, this actually works in 3.0.11 as well, since 'name' arg seems to be optional anyway
		   elseif (Auctioneer_GetItemHistoricalMedianBuyout(itemKey)) then
			DebugMessage("using auctioneer 3.1 method");
			medianPrice, medianCount = Auctioneer_GetItemHistoricalMedianBuyout(itemKey);

		   --for auctioneer 3.0.11, incase the above does not work.
		   elseif (Auctioneer_GetItemHistoricalMedianBuyout(itemKey, name)) then
			DebugMessage("using auctioneer 3.0 method");
			medianPrice, medianCount = Auctioneer_GetItemHistoricalMedianBuyout(itemKey, name);

		   else 
			ErrorMessage("auctioneer get median function not found. Using default prices.");
			return EnchantingSell_ListComponant[idReagent].PriceUnite;
		   end

		   DebugMessage("auctioneer medianPrice is "..isNullOrValue(medianPrice));

		   if (not medianCount or not medianPrice) then
			return EnchantingSell_ListComponant[idReagent].PriceUnite;
		   end

		   if (medianCount < 5 or medianPrice == 0) then
			DebugMessage("using EnchantingSeller PriceUnite");
			return EnchantingSell_ListComponant[idReagent].PriceUnite;
		   else
			return medianPrice;
		   end
		end
	end

end

function ES_getKCItemPrice(idReagent)
	if idReagent <= getn(EnchantingSell_ListComponant) then
		if not EnchantingSell_ListComponant[idReagent].Link then
			return EnchantingSell_ListComponant[idReagent].PriceUnite;
		else
			local code = ESell_CodeFromLink(EnchantingSell_ListComponant[idReagent].Link)
			DebugMessage("item code is "..isNullOrValue(code));

			--kc_items auctiondb format
			--seen, avgstack, min,   sBidcount, bid, sBuycount, buy
			--4:    5:        10683: 0:       0:   4:       11208

			local seen, avgstack, min, sBidcount, bid, sBuycount, buy;
			if (KC_Auction:GetItemData(code)) then
				seen, avgstack, min, sBidcount, bid, sBuycount, buy = KC_Auction:GetItemData(code);

			elseif (KC_ItemsAuction:getItemData(code)) then
				seen, avgstack, min, sBidcount, bid, sBuycount, buy = KC_ItemsAuction:getItemData(code);
			end

			DebugMessage("kc min is "..isNullOrValue(min));

			if (min and min ~= 0) then
				return min;
			else 
				return EnchantingSell_ListComponant[idReagent].PriceUnite;
			end
		end
	end
end

function ES_getAuctionMatrixPrice(idReagent)
	if idReagent <= getn(EnchantingSell_ListComponant) then
		if not EnchantingSell_ListComponant[idReagent].Link then
		   return EnchantingSell_ListComponant[idReagent].PriceUnite;
		else
		   local name = ESell_NameFromLink(EnchantingSell_ListComponant[idReagent].Link);
		   local medianPrice = AM_GetMedian(name);
		   DebugMessage("auction matrix medianPrice is "..isNullOrValue(medianPrice));
		   if (medianPrice) then
			return medianPrice;
		   else 
			return EnchantingSell_ListComponant[idReagent].PriceUnite;
		   end
		end
	end
end

function ES_getWowEconPrice(idReagent)
	if idReagent <= getn(EnchantingSell_ListComponant) then
		if not EnchantingSell_ListComponant[idReagent].Link then
		   return EnchantingSell_ListComponant[idReagent].PriceUnite;
		else
		   --integer:auction_price in copper, integer:auction_volume, bool:server-specific data
		   local auction_price, auction_volume = WOWEcon_GetAuctionPrice_ByLink(EnchantingSell_ListComponant[idReagent].Link);
		   DebugMessage("wow econ price is "..isNullOrValue(auction_price));
		   if (auction_price) then
			return auction_price;
		   else 
			return EnchantingSell_ListComponant[idReagent].PriceUnite;
		   end
		end
	end
end


--START: updated method from auctioneer patch.
function ESell_Reagent_getPrice(idReagent)
	if not idReagent then return end

	auctioneerLoaded = IsAddOnLoaded("Auctioneer");
	auctionMatrixLoaded = IsAddOnLoaded("AuctionMatrix");
	kcItemsLoaded = IsAddOnLoaded("KC_Items");
	wowEconLoaded = IsAddOnLoaded("WOWEcon_PriceMod");
	useAuctionAddon = EnchantingSell_PlayerConfig.EnchanteUseAuctioneer;

	DebugMessage("auctioneerLoaded? ".. getTrueOrFalse(auctioneerLoaded));
	DebugMessage("auctionMatrixLoaded? ".. getTrueOrFalse(auctionMatrixLoaded));
	DebugMessage("kcItemsLoaded? ".. getTrueOrFalse(kcItemsLoaded));
	DebugMessage("wowEconLoaded? ".. getTrueOrFalse(wowEconLoaded));
	DebugMessage("useAuctionAddon? ".. getTrueOrFalse(useAuctionAddon));

	if (not useAuctionAddon) then
		DebugMessage("not using useAuctionAddon");
		return ESell_Reagent_getPrice_default(idReagent);
	else
		if (auctioneerLoaded) then
			DebugMessage("using auctioneer");
			return ES_getAuctioneerPrice(idReagent);

		elseif (auctionMatrixLoaded) then
			DebugMessage("using auction matrix");
			return ES_getAuctionMatrixPrice(idReagent);
			
		elseif (kcItemsLoaded) then
			DebugMessage("using kc items");
			return ES_getKCItemPrice(idReagent);			

		elseif (wowEconLoaded) then
			DebugMessage("using wow econ");
			return ES_getWowEconPrice(idReagent);			

		--incase auctionaddon flag is true, but no auction addons are enabled/loaded.
		else 
			return ESell_Reagent_getPrice_default(idReagent);
		end

	end
	return nil;
end
--END: updated method from auctioneer patch.

function ESell_Reagent_getUsed(idReagent)
	if EnchantingSell_ListComponant[idReagent] then
		return EnchantingSell_ListComponant[idReagent].IsUse;
	end
	return nil;
end

function ESell_Reagent_getCount(idReagent, player)
	if not idReagent then return 0,0,0; end
	if (not player) then player = EnchantingSell_CourantPlayer; end
	local tableNbArg = EnchantingSell_ListComponant[idReagent]["ByPlayer"];
	local nbInBag, nbInBank, nbInReroll = ESell_Reagent_getCountWhithTable(tableNbArg, player[1]);
	return nbInBag, nbInBank, nbInReroll;
end

function ESell_Reagent_getCountWhithTable(tableNbArg, namePlayer)
	if (not namePlayer) then namePlayer = EnchantingSell_CourantPlayer[1]; end
	
--~ 	playerName = player[1];

--	local tableNbArg = EnchantingSell_ListComponant[idReagent]["ByPlayer"];
	local nbInBank = 0;
	local nbInReroll =0;
	local nbInBag =0;	
	if (tableNbArg) then
		table.foreach(tableNbArg,
			function (name, bagTable) 
				if (name == namePlayer) then
					nbInBag = bagTable["NbInBag"];
					nbInBank = bagTable["NbInBank"];
				else
					nbInReroll = (bagTable["NbInBank"] + bagTable["NbInBag"] + nbInReroll);
				end
			end
		);
	end
	return nbInBag, nbInBank, nbInReroll;
end

function ESell_Reagent_getPlayerListSave(idReagent)
	if not idReagent then return end
	if not EnchantingSell_ListComponant[idReagent]["ByPlayer"] then return {} end
	
	local tableNbArg = EnchantingSell_ListComponant[idReagent]["ByPlayer"];
	local playerList ={};
	table.foreach(tableNbArg,
		function (name, bagTable)
			table.insert(playerList, name);
		end
	);
	return playerList;
end
------------------------------------------------------------------------------------------------------
-- Modification du prix composants dans la bd --------------------------------------------------------
function ESell_Reagent_setPrice(typeMoney, price, idReagent)
	EnchantingSell_ListComponant[idReagent]["PriceUnite"] = ESell_Money_PriceModifier(typeMoney, price, ESell_Reagent_getPrice(idReagent));
	ESell_Enchante_UpdateAllPrice();
end
------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------




-- Fonction pour la fenetre ChangeEnchantePrice ----------------------------
function ESell_ChangeEnchantePrice_LaunchFrame(idEnchantement)
	if not idEnchantement then
		return;
	end

	local price, goodPrice, priceNoBenef = ESell_Enchante_getPrice(idEnchantement);

	local goldValue = ESell_Money_getMoney("Gold", price);
	local silverValue = ESell_Money_getMoney("Silver", price);
	local copperValue = ESell_Money_getMoney("Copper", price);

	EnchantingSell_ChangeEnchantePriceFrame_PriceWithPourcent_Price:SetText(ESell_Money_getStringFormatWithColor(floor(priceNoBenef*EnchantingSell_PlayerConfig.PourcentageBenefice)));
	
	if goodPrice < 2 then
		EnchantingSell_ChangeEnchantePriceFrame_CheckButton:SetChecked(true);
	end

	EnchantingSell_ChangeEnchantePriceFrame.CalcuPrice = floor(priceNoBenef*EnchantingSell_PlayerConfig.PourcentageBenefice);
	EnchantingSell_ChangeEnchantePriceFrame.IdEnchante = idEnchantement;
	EnchantingSell_ChangeEnchantePriceFrame_GoldEditBox:SetNumber(goldValue);
	EnchantingSell_ChangeEnchantePriceFrame_SilverEditBox:SetNumber(silverValue);
	EnchantingSell_ChangeEnchantePriceFrame_CopperEditBox:SetNumber(copperValue);

	EnchantingSell_ChangeEnchantePriceFrame:Show();
end



-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Fonction pour la gestion de l'icone de lancement mini map ---------------------------------------------------------------------------------------------------------------------
function ESell_MiniMapIcon_Update()
--	iPosition = math.floor( (iValue / 100) * (377 - 256) ) + 256;

--SHAMINO: removed check on isPlayerEnchanter.  Let the user use the minimap button based on their own options. 
--		1/24/2006 version 1.45.1
--	if (not ESell_playerIsEnchanter) then
--		HideUIPanel(EnchantingSellMinimapButton);
--		return;
--	end

	if (not EnchantingSell_PlayerConfig.UseMinimapIcon) then
		HideUIPanel(EnchantingSellMinimapButton);
		return;
	end

	if not EnchantingSell_Config then
		ESell_MiniMapIcon_Modifier(EnchantingSellMinimapButton, 15, 80);
		return;
	end
	if not EnchantingSell_PlayerConfig.MiniMapButtonPosition then
		EnchantingSell_PlayerConfig.MiniMapButtonPosition = 15;
	end
	ESell_MiniMapIcon_Modifier(EnchantingSellMinimapButton, EnchantingSell_PlayerConfig.MiniMapButtonPosition, 80);
	ShowUIPanel(EnchantingSellMinimapButton);
end

function ESell_MiniMapIcon_Modifier(frame, pPos, pRadius)
	frame:ClearAllPoints();
	frame:SetFrameLevel(Minimap:GetFrameLevel() + 10);
	frame:SetPoint("TOPLEFT", "Minimap", "TOPLEFT", 52 - (pRadius * cos(pPos)), (pRadius * sin(pPos)) - 52);
end


function ESell_UseTooltips_Update()
	--need to hook tooltip
	if (EnchantingSell_PlayerConfig.UseTooltips) then
		if (IsAddOnLoaded("EnhTooltip") and IsAddOnLoaded("Stubby")) then
			Stubby.RegisterFunctionHook("EnhTooltip.AddTooltip", 500, ES_HookTooltip)
		end
	else
		if (IsAddOnLoaded("EnhTooltip") and IsAddOnLoaded("Stubby")) then
			Stubby.UnregisterFunctionHook("EnhTooltip.AddTooltip", ES_HookTooltip)
		end
	end

end


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Fonction Divers -------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- prends en argument une fonction qui sera lancé apres avoir ouvert 
-- la fenetre craft enchantement et retourn true,
-- si pas enchanteur alors ne lance pas la fonction et retourn false
function ESell_LaunchFunctionInCraftSpellFrame(arg1Function)
	local isEnchanteur = false;
	local craftSpellFocus = false;
	local i=1;
	while true do
		local spellName, spellRank = GetSpellName(i, "spell" ) 
		if (not spellName) then
			break;
		end
		if (spellName == NAME_SPELL_CRAFT_ENCHANTE) then
			if (not GetCraftSpellFocus(i)) then
				CastSpell(i, "spell");
			else
				craftSpellFocus = true;
			end
			arg1Function();
			isEnchanteur = true;
			break;
		end
		i = i + 1;
	end
	if not craftSpellFocus then CloseCraft() end
	return isEnchanteur;
end

function ESell_getNumVerToLongNum()
	local _,_,numVersion = string.find(ENCHANTINGSELL_VERSION, "^(%d+)%.-%d-");
	local _,_,numSubVersion = string.find(ENCHANTINGSELL_VERSION, "^%d+%.(%d+)");
	if numVersion then numVersion = tonumber(numVersion, 10); end
	if numVersion and numSubVersion then numVersion = numVersion + (tonumber(numSubVersion, 10) / (10^strlen(numSubVersion))); end

	return numVersion;
end

function ESell_CodeFromLink(link)
	if (not link) then return nil; end
	local _, _, code = strfind(link, "(%d+:%d+:%d+:%d+)");
	local code = code and string.gsub(code, "(%d+):(%d+):(%d+):(%d+)", "%1:0:%3:0");
	return code;
end


function ESell_NameFromLink(link)
	local name;
	if( not link ) then
		return nil;
	end
	for name in string.gfind(link, "|c%x+|Hitem:%d+:%d+:%d+:%d+|h%[(.-)%]|h|r") do
		return name;
	end
	return nil;
end

function ESell_HitemFromLink(link)
	local hitem;
	if( not link ) then
		return nil;
	end
	for hitem in string.gfind(link, "|c%x+|H(item:%d+:%d+:%d+:%d+)|h%[.-%]|h|r") do
		DebugMessage("item link is "..link..", hitem is "..hitem);
		return hitem;
	end
	    for hitem in string.gfind(link, "|c%x+|H(enchant:%d+)|h%[.-%]|h|r") do
		DebugMessage("enchant link is "..link..", hitem is "..hitem);
		return hitem;
	    end 
	    return nil;
end

function ESell_isPlayerEnchanter()
	local numSkills = GetNumSkillLines();
	local skillIndex = 0;

	for skillIndex=1, numSkills do
		skillName, isHeader, isExpanded, skillRank, numTempPoints, skillModifier, skillMaxRank, isAbandonable, stepCost, rankCost, minLevel, skillCostType = GetSkillLineInfo(skillIndex);
		if (skillName==NAME_SPELL_CRAFT_ENCHANTE) then
			DebugMessage("ESell_isPlayerEnchanter: player has the enchanting profession");
			return true;
		end
	end
	return false;
end

function ES_HookTooltip(funcVars, retVal, frame, name, link, quality, count)
	if (EnchantingSell_PlayerConfig.UseTooltips) then
		local idReagent = ESell_Reagent_getId(name);

		if idReagent then
			local nbInBag, nbInBank, nbInReroll = ESell_Reagent_getCount(idReagent);
			local priceUnite = ESell_Reagent_getPrice(idReagent);

			EnhTooltip.AddSeparator()
			EnhTooltip.AddLine(ENCHANTINGSELL_TOOLTIPADD_TITLE..":", nil, false);
			EnhTooltip.LineColor(0,1,1);
			EnhTooltip.AddLine(ENCHANTINGSELL_TOOLTIPADD_ONME..": "..nbInBag, nil, false);
			EnhTooltip.LineColor(1,0.3,1);
			EnhTooltip.AddLine(ENCHANTINGSELL_TOOLTIPADD_INBANK..": "..nbInBank, nil, false);
			EnhTooltip.LineColor(1,0.3,1);
			EnhTooltip.AddLine(ENCHANTINGSELL_TOOLTIPADD_OTHERPLAYER..": "..nbInReroll, nil, false);
			EnhTooltip.LineColor(1,0.3,1);
			EnhTooltip.AddLine(ENCHANTINGSELL_TOOLTIPADD_PRICEUNITE..": "..ESell_Money_getStringFormatWithColor(priceUnite), nil, false);
			EnhTooltip.LineColor(1,0.3,1);
		end
	end

end


function ErrorMessage(msg)
	DEFAULT_CHAT_FRAME:AddMessage(msg);
end

function DebugMessage(msg)
	if ESell_Debug then
		DEFAULT_CHAT_FRAME:AddMessage(msg);
	end
end

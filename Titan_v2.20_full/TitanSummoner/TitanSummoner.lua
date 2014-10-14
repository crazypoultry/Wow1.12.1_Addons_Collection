--------------------------------------------------------------------------
-- TitanSummoner.lua 
--------------------------------------------------------------------------
--[[
TitanSummoner
	Plugin for Titan Panel to Summon Warlock Pets. 


v11000r3

]]--

TITAN_SUMMONER_ID = "Summoner";

TITAN_SUMMONER_ICON = "Interface\\Icons\\Ability_Mount_Dreadsteed";

-- List of summoning abilities to look for.
summoner_Abilities = {
	[TITAN_SUMMONER_TEXT_IMP] = 0,
	[TITAN_SUMMONER_TEXT_VOIDWALKER] = 0,
	[TITAN_SUMMONER_TEXT_SUCCUBUS] = 0,
	[TITAN_SUMMONER_TEXT_FELHUNTER] = 0,
	[TITAN_SUMMONER_TEXT_INFERNAL] = 0,
	[TITAN_SUMMONER_TEXT_DOOMGAURD] = 0,
	[TITAN_SUMMONER_TEXT_ENSLAVE] = 0,
}
mount_Abilities = {
	[TITAN_SUMMONER_TEXT_FELSTEED] = 0,
	[TITAN_SUMMONER_TEXT_DREADSTEED] = 0,
}
stone_Abilities = {
	[TITAN_SUMMONER_TEXT_HEALTHSTONEMIN] = 0,
	[TITAN_SUMMONER_TEXT_HEALTHSTONEL] = 0,
	[TITAN_SUMMONER_TEXT_HEALTHSTONE] = 0,
	[TITAN_SUMMONER_TEXT_HEALTHSTONEG] = 0,
	[TITAN_SUMMONER_TEXT_HEALTHSTONEM] = 0,
	[TITAN_SUMMONER_TEXT_SOULSTONEMIN] = 0,
	[TITAN_SUMMONER_TEXT_SOULSTONEL] = 0,
	[TITAN_SUMMONER_TEXT_SOULSTONE] = 0,
	[TITAN_SUMMONER_TEXT_SOULSTONEG] = 0,
	[TITAN_SUMMONER_TEXT_SOULSTONEM] = 0,
	[TITAN_SUMMONER_TEXT_FIRESTONEL] = 0,
	[TITAN_SUMMONER_TEXT_FIRESTONE] = 0,
	[TITAN_SUMMONER_TEXT_FIRESTONEG] = 0,
	[TITAN_SUMMONER_TEXT_FIRESTONEM] = 0,
	[TITAN_SUMMONER_TEXT_SPELLSTONE] = 0,
	[TITAN_SUMMONER_TEXT_SPELLSTONEG] = 0,
	[TITAN_SUMMONER_TEXT_SPELLSTONEM] = 0,
}
ritual_Abilities = {
	[TITAN_SUMMONER_TEXT_RITUAL] = 0,
	[TITAN_SUMMONER_TEXT_EYE] = 0,
}


--
-- OnFunctions
--
function TitanPanelSummonerButton_OnLoad()
	-- only load if character is a warlock
	local dummy, unitClass= UnitClass("player");
	if (unitClass ~= "WARLOCK") then
		return;
	end

	this.registry = { 
		id = TITAN_SUMMONER_ID,
		menuText = TITAN_SUMMONER_MENU_TEXT, 
		buttonTextFunction = "TitanPanelSummonerButton_GetButtonText",	
		tooltipTitle = TITAN_SUMMONER_TOOLTIP,
		tooltipTextFunction = "TitanPanelSummonerButton_GetTooltipText",
		icon = TITAN_SUMMONER_ICON,
	    iconWidth = 16,
		savedVariables = {
			ShowIcon = 1,
			ShowLabelText = 1,
			HideMinimap = TITAN_NIL,
		}
	}

			-- add item to every possible context menu	
			table.insert(UnitPopupMenus["PARTY"], "PSUMMON");
			table.insert(UnitPopupMenus["PLAYER"], "PSUMMON");
			table.insert(UnitPopupMenus["RAID"], "PSUMMON");
			UnitPopupButtons["PSUMMON"] = { text = TEXT(TITAN_SUMMONER_TEXT_RITUAL), dist = 0 };
	
end

function TitanPanelSummonerButton_OnEvent()

end 

--
-- Titan functions
--
function TitanPanelSummonerButton_GetButtonText(id)
	local id = TitanUtils_GetButton(id, true);

	local buttonRichText = "";
	return TITAN_SUMMONER_BUTTON_LABEL, buttonRichText;
end

function TitanPanelSummonerButton_GetTooltipText()
	
	local tooltipRichText = "";
	
	tooltipRichText = tooltipRichText..TitanUtils_GetGreenText(TITAN_SUMMONER_TOOLTIP_TEXT);
	return tooltipRichText;
end

--
-- create right-click dropdown menu
--
function TitanPanelRightClickMenu_PrepareSummonerMenu() 
	
	local info = {};
	
	if ( UIDROPDOWNMENU_MENU_LEVEL == 2 ) then		
		if ( UIDROPDOWNMENU_MENU_VALUE == "DisplayAbout" ) then
			info = {};
			info.text = TITAN_SUMMONER_ABOUT_POPUP_TEXT;
			info.value = "AboutTextPopUP";
			info.notClickable = 1;
			info.isTitle = 0;
			UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
		end
		return;
	end
	
	-- Reset the available abilities.
	for spellName, id in ipairs(summoner_Abilities) do
		if (id > 0) then
			summoner_Abilities[spellName] = 0;
		end
	end
	
	-- Calculate the total number of spells known by scanning the spellbook.
	local numTotalSpells = 0;
	for i=1, MAX_SKILLLINE_TABS do
		local name, texture, offset, numSpells = GetSpellTabInfo(i);
		if (name) then
			numTotalSpells = numTotalSpells + numSpells
		end
	end
	
	-- Find available spells.
	local summonerFound = 0;
	local mountFound = 0;
	local ritualFound = 0;
	local stoneFound = 0;

	for i=1, numTotalSpells do
		local spellName, subSpellName = GetSpellName(i, SpellBookFrame.bookType);
		if (spellName) then
			if (summoner_Abilities[spellName]) then
				summoner_Abilities[spellName] = i;
				summonerFound = 1;
			elseif (mount_Abilities[spellName]) then
				mount_Abilities[spellName] = i;
				mountFound = 1;
			elseif (ritual_Abilities[spellName]) then
				ritual_Abilities[spellName] = i;
				ritualFound = 1;
			elseif (stone_Abilities[spellName]) then
				stone_Abilities[spellName] = i;
				stoneFound = 1;
			end
		end
	end
	
	-- Display found summons
	if (summonerFound == 1) then
		info = {};
		info.text = TITAN_SUMMONER_SET_SUMMONER_TEXT;
		info.isTitle = 1;
		UIDropDownMenu_AddButton(info);

		if (summoner_Abilities[TITAN_SUMMONER_TEXT_IMP] > 0) then
			info = {};
			info.text = TITAN_SUMMONER_TEXT_IMP;
			info.value = summoner_Abilities[TITAN_SUMMONER_TEXT_IMP];
			info.func = TitanPanelSummoner_CastSpell;
			UIDropDownMenu_AddButton(info);
		end
		if (summoner_Abilities[TITAN_SUMMONER_TEXT_VOIDWALKER] > 0) then
			info = {};
			info.text = TITAN_SUMMONER_TEXT_VOIDWALKER;
			info.value = summoner_Abilities[TITAN_SUMMONER_TEXT_VOIDWALKER];
			info.func = TitanPanelSummoner_CastSpell;
			UIDropDownMenu_AddButton(info);
		end
		if (summoner_Abilities[TITAN_SUMMONER_TEXT_SUCCUBUS] > 0) then
			info = {};
			info.text = TITAN_SUMMONER_TEXT_SUCCUBUS;
			info.value = summoner_Abilities[TITAN_SUMMONER_TEXT_SUCCUBUS];
			info.func = TitanPanelSummoner_CastSpell;
			UIDropDownMenu_AddButton(info);
		end
		if (summoner_Abilities[TITAN_SUMMONER_TEXT_FELHUNTER] > 0) then
			info = {};
			info.text = TITAN_SUMMONER_TEXT_FELHUNTER;
			info.value = summoner_Abilities[TITAN_SUMMONER_TEXT_FELHUNTER];
			info.func = TitanPanelSummoner_CastSpell;
			UIDropDownMenu_AddButton(info);
		end
		if (summoner_Abilities[TITAN_SUMMONER_TEXT_ENSLAVE] > 0) then
			info = {};
			info.text = TITAN_SUMMONER_TEXT_ENSLAVE;
			info.value = summoner_Abilities[TITAN_SUMMONER_TEXT_ENSLAVE];
			info.func = TitanPanelSummoner_CastSpell;
			UIDropDownMenu_AddButton(info);
		end
		if (summoner_Abilities[TITAN_SUMMONER_TEXT_INFERNAL] > 0) then
			info = {};
			info.text = TITAN_SUMMONER_TEXT_INFERNAL;
			info.value = summoner_Abilities[TITAN_SUMMONER_TEXT_INFERNAL];
			info.func = TitanPanelSummoner_CastSpell;
			UIDropDownMenu_AddButton(info);
		end
		if (summoner_Abilities[TITAN_SUMMONER_TEXT_DOOMGAURD] > 0) then
			info = {};
			info.text = TITAN_SUMMONER_TEXT_DOOMGAURD;
			info.value = summoner_Abilities[TITAN_SUMMONER_TEXT_DOOMGAURD];
			info.func = TitanPanelSummoner_CastSpell;
			UIDropDownMenu_AddButton(info);
		end

	end
	
	-- Display found mounts
	if (mountFound == 1) then
		TitanPanelRightClickMenu_AddSpacer();
		info = {};
		info.text = TITAN_SUMMONER_SET_MOUNT_TEXT;
		info.isTitle = 1;
		UIDropDownMenu_AddButton(info);

		if (mount_Abilities[TITAN_SUMMONER_TEXT_FELSTEED] > 0) then
			info = {};
			info.text = TITAN_SUMMONER_TEXT_FELSTEED;
			info.value = mount_Abilities[TITAN_SUMMONER_TEXT_FELSTEED];
			info.func = TitanPanelSummoner_CastSpell;
			UIDropDownMenu_AddButton(info);
		end
		if (mount_Abilities[TITAN_SUMMONER_TEXT_DREADSTEED] > 0) then
			info = {};
			info.text = TITAN_SUMMONER_TEXT_DREADSTEED;
			info.value = mount_Abilities[TITAN_SUMMONER_TEXT_DREADSTEED];
			info.func = TitanPanelSummoner_CastSpell;
			UIDropDownMenu_AddButton(info);
		end

	end
	
	-- Display found rituals
	if (ritualFound == 1) then
		TitanPanelRightClickMenu_AddSpacer();
		info = {};
		info.text = TITAN_SUMMONER_SET_PARTY_TEXT;
		info.isTitle = 1;
		UIDropDownMenu_AddButton(info);

		if (ritual_Abilities[TITAN_SUMMONER_TEXT_EYE] > 0) then
			info = {};
			info.text = TITAN_SUMMONER_TEXT_EYE;
			info.value = ritual_Abilities[TITAN_SUMMONER_TEXT_EYE];
			info.func = TitanPanelSummoner_CastSpell;
			UIDropDownMenu_AddButton(info);
		end
		if (ritual_Abilities[TITAN_SUMMONER_TEXT_RITUAL] > 0) then
			info = {};
			info.text = TITAN_SUMMONER_TEXT_RITUAL;
			info.value = ritual_Abilities[TITAN_SUMMONER_TEXT_RITUAL];
			info.func = TitanPanelSummoner_CastSpell;
			UIDropDownMenu_AddButton(info);
		end

	end
	
	-- Display found stones
	if (stoneFound == 1) then
		TitanPanelRightClickMenu_AddSpacer();
		info = {};
		info.text = TITAN_SUMMONER_SET_STONE_TEXT;
		info.isTitle = 1;
		UIDropDownMenu_AddButton(info);

		if (stone_Abilities[TITAN_SUMMONER_TEXT_HEALTHSTONEM] > 0) then
			spellName = TITAN_SUMMONER_TEXT_HEALTHSTONEM;
			id = stone_Abilities[TITAN_SUMMONER_TEXT_HEALTHSTONEM];
			info = {};
			info.text = spellName;
			info.value = id;
			info.func = TitanPanelSummoner_CastSpell;
			UIDropDownMenu_AddButton(info);
		elseif (stone_Abilities[TITAN_SUMMONER_TEXT_HEALTHSTONEG] > 0) then
			spellName = TITAN_SUMMONER_TEXT_HEALTHSTONEG;
			id = stone_Abilities[TITAN_SUMMONER_TEXT_HEALTHSTONEG];
			info = {};
			info.text = spellName;
			info.value = id;
			info.func = TitanPanelSummoner_CastSpell;
			UIDropDownMenu_AddButton(info);
		elseif (stone_Abilities[TITAN_SUMMONER_TEXT_HEALTHSTONE] > 0) then
			spellName = TITAN_SUMMONER_TEXT_HEALTHSTONE;
			id = stone_Abilities[TITAN_SUMMONER_TEXT_HEALTHSTONE];
			info = {};
			info.text = spellName;
			info.value = id;
			info.func = TitanPanelSummoner_CastSpell;
			UIDropDownMenu_AddButton(info);
		elseif (stone_Abilities[TITAN_SUMMONER_TEXT_HEALTHSTONEL] > 0) then
			spellName = TITAN_SUMMONER_TEXT_HEALTHSTONEL;
			id = stone_Abilities[TITAN_SUMMONER_TEXT_HEALTHSTONEL];
			info = {};
			info.text = spellName;
			info.value = id;
			info.func = TitanPanelSummoner_CastSpell;
			UIDropDownMenu_AddButton(info);
		elseif (stone_Abilities[TITAN_SUMMONER_TEXT_HEALTHSTONEMIN] > 0) then
			spellName = TITAN_SUMMONER_TEXT_HEALTHSTONEMIN;
			id = stone_Abilities[TITAN_SUMMONER_TEXT_HEALTHSTONEMIN];
			info = {};
			info.text = spellName;
			info.value = id;
			info.func = TitanPanelSummoner_CastSpell;
			UIDropDownMenu_AddButton(info);
		end

		if (stone_Abilities[TITAN_SUMMONER_TEXT_SOULSTONEM] > 0) then
			spellName = TITAN_SUMMONER_TEXT_SOULSTONEM;
			id = stone_Abilities[TITAN_SUMMONER_TEXT_SOULSTONEM];
			info = {};
			info.text = spellName;
			info.value = id;
			info.func = TitanPanelSummoner_CastSpell;
			UIDropDownMenu_AddButton(info);
		elseif (stone_Abilities[TITAN_SUMMONER_TEXT_SOULSTONEG] > 0) then
			spellName = TITAN_SUMMONER_TEXT_SOULSTONEG;
			id = stone_Abilities[TITAN_SUMMONER_TEXT_SOULSTONEG];
			info = {};
			info.text = spellName;
			info.value = id;
			info.func = TitanPanelSummoner_CastSpell;
			UIDropDownMenu_AddButton(info);
		elseif (stone_Abilities[TITAN_SUMMONER_TEXT_SOULSTONE] > 0) then
			spellName = TITAN_SUMMONER_TEXT_SOULSTONE;
			id = stone_Abilities[TITAN_SUMMONER_TEXT_SOULSTONE];
			info = {};
			info.text = spellName;
			info.value = id;
			info.func = TitanPanelSummoner_CastSpell;
			UIDropDownMenu_AddButton(info);
		elseif (stone_Abilities[TITAN_SUMMONER_TEXT_SOULSTONEL] > 0) then
			spellName = TITAN_SUMMONER_TEXT_SOULSTONEL;
			id = stone_Abilities[TITAN_SUMMONER_TEXT_SOULSTONEL];
			info = {};
			info.text = spellName;
			info.value = id;
			info.func = TitanPanelSummoner_CastSpell;
			UIDropDownMenu_AddButton(info);
		elseif (stone_Abilities[TITAN_SUMMONER_TEXT_SOULSTONEMIN] > 0) then
			spellName = TITAN_SUMMONER_TEXT_SOULSTONEMIN;
			id = stone_Abilities[TITAN_SUMMONER_TEXT_SOULSTONEMIN];
			info = {};
			info.text = spellName;
			info.value = id;
			info.func = TitanPanelSummoner_CastSpell;
			UIDropDownMenu_AddButton(info);
		end

		if (stone_Abilities[TITAN_SUMMONER_TEXT_FIRESTONEM] > 0) then
			spellName = TITAN_SUMMONER_TEXT_FIRESTONEM;
			id = stone_Abilities[TITAN_SUMMONER_TEXT_FIRESTONEM];
			info = {};
			info.text = spellName;
			info.value = id;
			info.func = TitanPanelSummoner_CastSpell;
			UIDropDownMenu_AddButton(info);
		elseif (stone_Abilities[TITAN_SUMMONER_TEXT_FIRESTONEG] > 0) then
			spellName = TITAN_SUMMONER_TEXT_FIRESTONEG;
			id = stone_Abilities[TITAN_SUMMONER_TEXT_FIRESTONEG];
			info = {};
			info.text = spellName;
			info.value = id;
			info.func = TitanPanelSummoner_CastSpell;
			UIDropDownMenu_AddButton(info);
		elseif (stone_Abilities[TITAN_SUMMONER_TEXT_FIRESTONE] > 0) then
			spellName = TITAN_SUMMONER_TEXT_FIRESTONE;
			id = stone_Abilities[TITAN_SUMMONER_TEXT_FIRESTONE];
			info = {};
			info.text = spellName;
			info.value = id;
			info.func = TitanPanelSummoner_CastSpell;
			UIDropDownMenu_AddButton(info);
		elseif (stone_Abilities[TITAN_SUMMONER_TEXT_FIRESTONEL] > 0) then
			spellName = TITAN_SUMMONER_TEXT_FIRESTONEL;
			id = stone_Abilities[TITAN_SUMMONER_TEXT_FIRESTONEL];
			info = {};
			info.text = spellName;
			info.value = id;
			info.func = TitanPanelSummoner_CastSpell;
			UIDropDownMenu_AddButton(info);
		end

		if (stone_Abilities[TITAN_SUMMONER_TEXT_SPELLSTONEM] > 0) then
			spellName = TITAN_SUMMONER_TEXT_SPELLSTONEM;
			id = stone_Abilities[TITAN_SUMMONER_TEXT_SPELLSTONEM];
			info = {};
			info.text = spellName;
			info.value = id;
			info.func = TitanPanelSummoner_CastSpell;
			UIDropDownMenu_AddButton(info);
		elseif (stone_Abilities[TITAN_SUMMONER_TEXT_SPELLSTONEG] > 0) then
			spellName = TITAN_SUMMONER_TEXT_SPELLSTONEG;
			id = stone_Abilities[TITAN_SUMMONER_TEXT_SPELLSTONEG];
			info = {};
			info.text = spellName;
			info.value = id;
			info.func = TitanPanelSummoner_CastSpell;
			UIDropDownMenu_AddButton(info);
		elseif (stone_Abilities[TITAN_SUMMONER_TEXT_SPELLSTONE] > 0) then
			spellName = TITAN_SUMMONER_TEXT_SPELLSTONE;
			id = stone_Abilities[TITAN_SUMMONER_TEXT_SPELLSTONE];
			info = {};
			info.text = spellName;
			info.value = id;
			info.func = TitanPanelSummoner_CastSpell;
			UIDropDownMenu_AddButton(info);
		end


	end


	TitanPanelRightClickMenu_AddSpacer();
	TitanPanelRightClickMenu_AddToggleLabelText(TITAN_SUMMONER_ID);
	TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE,TITAN_SUMMONER_ID,TITAN_PANEL_MENU_FUNC_HIDE);

	-- info about plugin
	info = {};
	info.text = TITAN_SUMMONER_ABOUT_TEXT;
	info.value = "DisplayAbout";
	info.hasArrow = 1;
	UIDropDownMenu_AddButton(info);
end

local old_UnitPopup_OnClick = UnitPopup_OnClick;
function UnitPopup_OnClick()
	local index = this.value;
	local dropdownFrame = getglobal(UIDROPDOWNMENU_INIT_MENU);
	local button = UnitPopupMenus[this.owner][index];
	local unit = dropdownFrame.unit;
	local name = dropdownFrame.name;
	if ( button == "PSUMMON" ) then
		CastSpellByName(TITAN_SUMMONER_TEXT_RITUAL);
	end
	return old_UnitPopup_OnClick();
end

function TitanPanelSummoner_CastSpell()
	CastSpell(this.value, 0);
end

function TitanPanelSummoner_ChatPrint(msg)
        DEFAULT_CHAT_FRAME:AddMessage(msg);
end
-------------------------------------------------------------------------------
-- Configure the user interface screen
-------------------------------------------------------------------------------
function ffy_ConfigOnLoad()

    -- First set up all the appearance text
	ffy_ConfigFrameVersionText:SetText(PRAVETZ_FORTIFY);
	ffy_ConfigFrameTitleText:SetText(BINDING_HEADER_FORTIFY);
	ffy_ConfigFrame_Options_Text:SetText(FFY_UI_OPTIONS);
	
	-- Set up the mana conservation slider
	ffy_ConfigFrame_Conserve_Text:SetText(FFY_UI_CONSERVE);
    ffy_ConfigFrame_ConserveLow:SetText("0");
    ffy_ConfigFrame_ConserveHigh:SetText("5000");
    ffy_ConfigFrame_Conserve:SetMinMaxValues(0,5000);
    ffy_ConfigFrame_Conserve:SetValueStep(1);
    ffy_ConfigFrame_Conserve:SetValue(0);

	-- Set up the user interface labels
	ffy_ConfigFrame_NotifyGroup_Text:SetText(FFY_UI_NOTIFYGROUP);
	ffy_ConfigFrame_ShowPanel_Text:SetText(FFY_UI_SHOWPANEL);
	ffy_ConfigFrame_PanelMovable_Text:SetText(FFY_UI_PANELMOVABLE);
	ffy_ConfigFrame_CastOnPets_Text:SetText(FFY_UI_CASTONPETS);
	ffy_ConfigFrame_TellBuffs_Text:SetText(FFY_UI_TELLBUFFS);
	ffy_ConfigFrame_ReminderAudio_Text:SetText(FFY_UI_REMINDERAUDIO);
	ffy_ConfigFrame_ReminderText_Text:SetText(FFY_UI_REMINDERTEXT);
	
	-- Make Frame Moveable.
	UIPanelWindows["ffy_ConfigFrame"] = { area = "left", pushable = 5, whileDead = 1 };
end


-------------------------------------------------------------------------------
-- When the window is shown, set all the parameters
-------------------------------------------------------------------------------
function ffy_ConfigOnShow()

    -- Set the checkboxes to reflect current settings
	if (ffy_Options.NotifyGroup) then
	    ffy_ConfigFrame_NotifyGroup:SetChecked(1);
	end
	if (ffy_Options.ShowPanel) then
	    ffy_ConfigFrame_ShowPanel:SetChecked(1);
	end
	if (not ffy_Options.PanelMovable) then
	    ffy_ConfigFrame_PanelMovable:SetChecked(1);
	end
	if (ffy_Options.CastOnPets) then
	    ffy_ConfigFrame_CastOnPets:SetChecked(1);
	end
	if (ffy_Options.TellBuffs) then
	    ffy_ConfigFrame_TellBuffs:SetChecked(1);
	end
	if (ffy_Options.ReminderAudio) then
	    ffy_ConfigFrame_ReminderAudio:SetChecked(1);
	end
	if (ffy_Options.ReminderText) then
	    ffy_ConfigFrame_ReminderText:SetChecked(1);
	end
	
	-- Set the mana conserve value correctly
    ffy_ConfigFrame_Conserve:SetValue(ffy_Options.ManaConserve);
    
    -- Set the drop-down menus for the weapon buffs
    UIDropDownMenu_SetSelectedID(ffy_ConfigFrame_MainHand_Buff, ffy_Options.MainHand);
    UIDropDownMenu_SetSelectedID(ffy_ConfigFrame_OffHand_Buff, ffy_Options.OffHand);

    -- Now set all the spell graphic icons
    local count = 0;
    local spellname, icon;
    for spellname in ffy_SpellRanks do
        ffy_debug("Checking " .. spellname .. " Rank " .. ffy_SpellRanks[spellname]);
        if ffy_SpellRanks[spellname] ~= nil and ffy_SpellRanks[spellname] > 0 then
            ffy_debug("Adding");
            count = count + 1;
            if (ffy_MyData[spellname].behavior == FFY_TYPE_POISON) then
                local bag, slot, link = ffy_FindItemByName(spellname);
                if (bag == nil) then
                    icon = "Interface\\Icons\\Spell_Holy_DispelMagic";
                else
                    icon, _, _, _, _ = GetContainerItemInfo(bag, slot);
                end
            else
                icon = GetSpellTexture(ffy_SpellID[ffy_BuildSpellName(spellname,ffy_SpellRanks[spellname])], BOOKTYPE_SPELL);
            end
            getglobal("ffy_ConfigFrame_Spell" .. count .. "Icon"):SetTexture(icon);
            ffy_UI_Lookup[count] = spellname;
            
            -- Grey out disabled spells
            if (ffy_Options.Enabled[spellname]) then
                getglobal("ffy_ConfigFrame_Spell" .. count):SetAlpha(1.0);
            else
                getglobal("ffy_ConfigFrame_Spell" .. count):SetAlpha(0.25);
            end
        end
    end
end


-------------------------------------------------------------------------------
-- Respond to a checkbox click
-------------------------------------------------------------------------------
function ffy_ClickCheckbox(name)
    ffy_debug("Checkbox: " .. name);
    
    -- Interpret the user's click
    if (name == "ffy_ConfigFrame_NotifyGroup") then
        ffy_Options.NotifyGroup = not ffy_Options.NotifyGroup;

    elseif (name == "ffy_ConfigFrame_ShowPanel") then
        ffy_Options.ShowPanel = not ffy_Options.ShowPanel;
        ffy_ButtonFrame_Update();
        
    elseif (name == "ffy_ConfigFrame_PanelMovable") then
        ffy_Options.PanelMovable = not ffy_Options.PanelMovable;
        ffy_ButtonFrame_Update();
        
    elseif (name == "ffy_ConfigFrame_CastOnPets") then
        ffy_Options.CastOnPets = not ffy_Options.CastOnPets;
        ffy_CreateTargetList();

    elseif (name == "ffy_ConfigFrame_TellBuffs") then
        ffy_Options.TellBuffs = not ffy_Options.TellBuffs;

    elseif (name == "ffy_ConfigFrame_ReminderAudio") then
        ffy_Options.ReminderAudio = not ffy_Options.ReminderAudio;

    elseif (name == "ffy_ConfigFrame_ReminderText") then
        ffy_Options.ReminderText = not ffy_Options.ReminderText;
    end
end


-------------------------------------------------------------------------------
-- Adjust our mana conserve values based on the slider
-------------------------------------------------------------------------------
function ffy_ConserveSlider()
    if (ffy_ConfigFrame:IsShown()) then
        ffy_Options.ManaConserve = ffy_ConfigFrame_Conserve:GetValue(0);
    	GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
        GameTooltip:SetText(ffy_Options.ManaConserve);
    end
end


-------------------------------------------------------------------------------
-- Toggle a spell
-------------------------------------------------------------------------------
function ffy_SpellToggle_OnClick(id)
    local spellname = ffy_UI_Lookup[id]
    ffy_debug("Clicked " .. id .. " (" .. spellname .. ")");
    ffy_Options.Enabled[spellname] = not ffy_Options.Enabled[spellname];
    if (ffy_Options.Enabled[spellname]) then
        getglobal("ffy_ConfigFrame_Spell" .. id):SetAlpha(1.0);
    else
        getglobal("ffy_ConfigFrame_Spell" .. id):SetAlpha(0.25);
    end
    ffy_SpellToggle_OnEnter(id)
end


-------------------------------------------------------------------------------
-- Highlight the name of a spell
-------------------------------------------------------------------------------
function ffy_SpellToggle_OnEnter(id)
    local tooltip = ffy_UI_Lookup[id];
    if (tooltip ~= nil) then
    	GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
        if (ffy_Options.Enabled[ffy_UI_Lookup[id]]) then
            GameTooltip:SetText(string.gsub(FFY_UI_ENABLED, "$s", tooltip), 0, 1, 0);
        else
            GameTooltip:SetText(string.gsub(FFY_UI_DISABLED, "$s", tooltip), 1, 0, 0);
        end
    end
end


-------------------------------------------------------------------------------
-- Un-highlight a spell name
-------------------------------------------------------------------------------
function ffy_SpellToggle_OnLeave(id)
    GameTooltip:SetText("");
end


-------------------------------------------------------------------------------
-- User selected one of the items in the drop down menu
-------------------------------------------------------------------------------
function ffy_ConfigFrame_SelectMainHandBuff(arg1)
	local i = arg1; this:GetID();
    UIDropDownMenu_SetSelectedID(ffy_ConfigFrame_MainHand_Buff, i);
    ffy_Options.MainHand = i;
    ffy_debug("Selected " .. i .. " for main hand buff.");
end


-------------------------------------------------------------------------------
-- User selected one of the items in the drop down menu
-------------------------------------------------------------------------------
function ffy_ConfigFrame_SelectOffHandBuff(arg1)
	local i = arg1; -- this:GetID();
    UIDropDownMenu_SetSelectedID(ffy_ConfigFrame_OffHand_Buff, i);
    ffy_Options.OffHand = i;
    ffy_debug("Selected " .. i .. " for offhand buff.");
end


-------------------------------------------------------------------------------
-- Prepare the list of options for the weapon buff drop down menu
-------------------------------------------------------------------------------
function ffy_ConfigFrame_WeaponBuff_Init(f, sel)
	local info;

    -- Add all the regular weapon buff items
	for i = 1, getn(FFY_WEAPONBUFF_DATA), 1 do
		info = {
			text = FFY_WEAPONBUFF_DATA[i].text;
			func = f;
			arg1 = i;
			checked = (i == sel);
		};
		if (FFY_WEAPONBUFF_DATA[i].type == FFY_TYPE_POISON) then
		    if (ffy_IsRogue) then
    		    UIDropDownMenu_AddButton(info);
    		else
    		    ffy_debug("Unit is not rogue");
		    end
		else
		    UIDropDownMenu_AddButton(info);
		end
	end
end


function ffy_ConfigFrame_MainHandInit()
    ffy_ConfigFrame_WeaponBuff_Init(ffy_ConfigFrame_SelectMainHandBuff, ffy_Options.MainHand);
end
function ffy_ConfigFrame_OffHandInit()
    ffy_ConfigFrame_WeaponBuff_Init(ffy_ConfigFrame_SelectOffHandBuff, ffy_Options.OffHand);
end


-------------------------------------------------------------------------------
-- Drop down a menu to select a weapon buff
-------------------------------------------------------------------------------
function ffy_ConfigFrame_WeaponBuff_OnShow(dropdown, mainhand)
	if (this:GetID() == 0) then
	    UIDropDownMenu_Initialize(dropdown, ffy_ConfigFrame_MainHandInit);
	else
    	UIDropDownMenu_Initialize(dropdown, ffy_ConfigFrame_OffHandInit);
	end
	UIDropDownMenu_SetWidth(140, dropdown);
end

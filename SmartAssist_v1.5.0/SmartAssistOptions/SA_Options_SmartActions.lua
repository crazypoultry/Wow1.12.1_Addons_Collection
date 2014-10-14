NUM_SLOTS = 120;

-------------------------------------------------------------------------------
-- smart spell configuration methods
-------------------------------------------------------------------------------

function SA_Options_SmartActions_OnShow()
	SATriggerAssistCB:SetChecked(SA_OPTIONS.TriggerAssist);
	SA_RefreshSlots();
end

function SA_RefreshSlots()
	local i = 0;
	for _,spell in SA_OPTIONS.AssistSpells do
		i = i + 1;
		local slot = getglobal("SAAssistSlot"..i);
		local texture = SA_GetTextureForSpell(spell);
		if (texture) then
			SetItemButtonTexture(slot, texture);
		else
			SA_Debug("unknown texture for spell "..tostring(spell));
			SetItemButtonTexture(slot, "Interface\\Icons\\INV_Misc_QuestionMark");
		end
	end
	-- clear old textures	
	for c = i+1, 20 do 
		local slot = getglobal("SAAssistSlot"..c);
		SetItemButtonTexture(slot, nil);
	end
end

function SA_SmartActionSlot_OnEnter(arg)
	if (SA_DRAGSLOT or SA_DRAGSPELL) then return; end;
	local text = SA_OPTIONS.AssistSpells[this:GetID()];
	if (text) then
		GameTooltip:SetOwner(arg, "ANCHOR_RIGHT");
		GameTooltip:SetText(text,1,1,1,1,1);
	end
end

function SA_SmartActionSlot_OnClick()
	if (CursorHasSpell()) then
		printInfo("This is drag instead of click!");
		SA_SmartActionSlot_OnReceiveDrag();
		return;
	end
	
	-- remove selected spell & update table element id's (why doesn't lua do this =P)
	if (SA_OPTIONS.AssistSpells[this:GetID()]) then
		table.remove(SA_OPTIONS.AssistSpells, this:GetID());
		local temp = {};
		for _,v in SA_OPTIONS.AssistSpells do
			table.insert(temp, v);
		end
		SA_OPTIONS.AssistSpells = temp;
	end
	
	SA_Options_SmartActions_OnShow();
end

function SA_SmartActionSlot_OnReceiveDrag()
	-- get spell name and release drag, Todo: separate to function?
	local spell = SA_DRAGNAME;
	if (SA_DRAGSLOT) then
		PickupAction(SA_DRAGSLOT);
	elseif (SA_DRAGSPELL) then
		PickupSpell(SA_DRAGSPELL.Id, SA_DRAGSPELL.BookType);
	else
		printInfo("bug #5933");
	end
	SA_ClearDragData();
	
	if (not spell) then
		printInfo("Problem: Unable to get spell name");
		return;
	end
	
	if (SA_TableIndex(SA_OPTIONS.AssistSpells, spell) ~= -1) then
		printInfo("Spell already exists in list");
		return;
	end
	
	SA_Debug("Adding spell "..tostring(spell));
	table.insert(SA_OPTIONS.AssistSpells, spell);

	-- refresh the view
	SA_Options_SmartActions_OnShow();
end

-------------------------------------------------------------------------------
-- reset all smartactions
-------------------------------------------------------------------------------

function SA_ResetSmartActions()
	SA_OPTIONS.AssistSpells = {};
	-- refresh the view
	SA_Options_SmartActions_OnShow();
end

-------------------------------------------------------------------------------
-- try to autoconfigure smart actions
-------------------------------------------------------------------------------

function SA_AutoConfigureSmartActions()
	local found = 0;
	for slot = 1, NUM_SLOTS do
		local spell = SA_GetSlotName(slot);
		if (spell) then
			if (AUTOCONF_ATTACKS[spell]) then
				if (SA_TableIndex(SA_OPTIONS.AssistSpells, spell) == -1) then 
					SA_Debug("found attack "..spell);
					table.insert(SA_OPTIONS.AssistSpells, spell);
					found = found + 1;
				end
			end
		end
	end
	if (found>0) then
		printInfo("Auto configured "..found.." actions.");
	else
		printInfo("Auto configure was unable to find any actions. This is most likelly because your class does not (yet) have predefined set of spells or you are using non-english client.");
	end
	
	-- refresh the view
	SA_Options_SmartActions_OnShow();
end

-------------------------------------------------------------------------------
-- slot & spell utilities
-------------------------------------------------------------------------------

function SA_GetTextureForSpell(name)
	local id = SA_FindSlotByName(name);
	if (id==nil) then return nil; end;
	return GetActionTexture(id);
end

function SA_FindSlotByName(name)
	local textName;
	for slot = 1, NUM_SLOTS do
		slotName = SA_GetSlotName(slot);
		if (slotName == name) then
			return slot;
		end		
	end
	return nil;
end
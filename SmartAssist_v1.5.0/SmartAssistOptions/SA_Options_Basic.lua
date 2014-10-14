function SA_Options_Basic_OnShow()
	SAPriorizeHealthCB:SetChecked(SA_OPTIONS.PriorizeHealth);
	SAAssistOnEmoteCB:SetChecked(SA_OPTIONS.AssistOnEmote);
	SAVisualWarningCB:SetChecked(SA_OPTIONS.VisualWarning);
	SAFallbackTargetNearestCB:SetChecked(SA_OPTIONS.FallbackTargetNearest);
	SACheckNearestCB:SetChecked(SA_OPTIONS.CheckNearest);
	SANearestMustBePvPCB:SetChecked(SA_OPTIONS.NearestMustBePvP);
	SANearestMustBeTargetingCB:SetChecked(SA_OPTIONS.NearestMustBeTargetting);
	SAAutoAssistCB:SetChecked(SA_OPTIONS.AutoAssist);

	SAAutoPetAttackCB:SetChecked(SA_OPTIONS.AutoPetAttack);
	SAAutoPetAttackBusyCB:SetChecked(SA_OPTIONS.AutoPetAttackBusy);
	
	-- hide irrelevant pet control checkboxes if player cannot have pet
	if (not SA_IsPetClass()) then
		SAAutoPetAttackCB:Hide();
		SAAutoPetAttackBusyCB:Hide();
	end
	
	SA_Options_UpdatePullerText();
		
	if (SA_OPTIONS.AutoAssistTexture) then
		SAAssistText:SetText(SA_OPTIONS.AutoAssistName);
		SA_Debug("setting button texture to="..SA_OPTIONS.AutoAssistTexture);
		SetItemButtonTexture(SAAssistWithSlot, SA_OPTIONS.AutoAssistTexture);
	end
	SA_Options_UpdateClassOrder();
	
	-- set health slider value & update text
	SAHealthSlider:SetValue(SA_OPTIONS.PriorizeHealthValue);
	SA_Options_UpdateHealthSlider();
end

-------------------------------------------------------------------------------
-- updates health slider TEXT (not value)
-------------------------------------------------------------------------------

function SA_Options_UpdateHealthSlider()
	SA_OPTIONS.PriorizeHealthValue = SAHealthSlider:GetValue();
	SAHealthSliderText:SetText("Priority health ("..SA_OPTIONS.PriorizeHealthValue.." %)");
end

-------------------------------------------------------------------------------
-- class order routines
-------------------------------------------------------------------------------

function SA_ClassOrderMove(move)
	local text = getglobal(this:GetParent():GetName() .. "Text"):GetText()
	-- where is our text in table, also check for boundaries
	local index = SA_TableIndex(SA_OPTIONS.ClassOrder, text);
	-- move the element in our list	
	local moving = SA_OPTIONS.ClassOrder[index];
	table.remove(SA_OPTIONS.ClassOrder, index);
	table.insert(SA_OPTIONS.ClassOrder, index+move, moving);
	SA_Options_UpdateClassOrder();
end

-------------------------------------------------------------------------------
-- updates classorder view
-------------------------------------------------------------------------------

function SA_Options_UpdateClassOrder()
	for k,v in SA_OPTIONS.ClassOrder do
		getglobal("ClassOrderFrameClass" .. k .. "Text"):SetText(v);
	end
end

-------------------------------------------------------------------------------
-- auto cast on assist slot
-------------------------------------------------------------------------------

function SA_SpellSlot_OnReceiveDrag()
	SA_Debug("Received drag");
	
	-- enable whining again, incase user has Auto Attack enabled which will screw the cast
	SA_OPTIONS.AutoAttackWhineIgnored = false;
	
	if (CursorHasSpell() and not SA_DRAGSLOT) then
		SA_OPTIONS.AutoAssist = true;
		SA_OPTIONS.AutoAssistTexture = SA_DRAGSPELL.Texture;
		SA_OPTIONS.AutoAssistName = SA_DRAGSPELL.Name;

		-- drop icon
		PickupSpell(SA_DRAGSPELL.Id, SA_DRAGSPELL.BookType);
		
		-- update the config window		
		SA_Options_Basic_OnShow();
	else
		SpellBookFrame:Show();
	end
end

----------------------------------------------------------------------------------
-- displays list of all available members in order of current assist configuration
----------------------------------------------------------------------------------

function SA_PullerText_OnEnter(arg)
	local text = "Current assist order:\n\n";
	local candidates, members = SA_GetCandidates(false);
	if (members > 0) then
		table.sort(candidates, function(a,b) return SA_SortCandidate(a,b,members) end);
		for _,candidate in candidates do
			-- colorize text by class
			local cv = RAID_CLASS_COLORS[string.upper(candidate["class"])];
			local color = "";
			if (not cv) then
				color = "|cff888888";
			else
				color = SA_ToTextCol(cv.r, cv.g, cv.b);
			end
			text = text .. color..candidate.unitName .. "|r" .. "\n";
		end
	else
		text = text .. "- no members";
	end
	GameTooltip:SetOwner(arg, "ANCHOR_LEFT");
	GameTooltip:SetText(text,1,1,1,1,1);
end

function SA_PullerText_OnLeave(arg)
	GameTooltip:Hide();
end

function SA_Options_UpdatePullerText()
	local candidates,_ = SA_GetCandidates();
	--SA_RefreshPuller(candidates); -- causes infinite loop and stack overflow because this method is called from refresh path also!
	if (SA_OPTIONS["puller"]==nil) then
		SACurrentPuller:SetText("Puller: none / pet when available");
	else
		SACurrentPuller:SetText("Puller: "..SA_OPTIONS["puller"]);
	end
end
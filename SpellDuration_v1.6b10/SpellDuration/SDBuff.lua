----------------------------------------------------------------------------------------------------
-- Name		: Spell Duration [Bar]
----------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------
-- USED ON EVENTS FUNCTIONS
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
-- Name		: SDBuffOnEvent
----------------------------------------------------------------------------------------------------
function SDBuffOnEvent(event)
	if(SDConfig.BarsOnly) then return; end
	if(event == "UNIT_AURA") then
		if(arg1 == "target") then
			local i = 1;
			local target = UnitName("target");
			while(UnitDebuff("target", i)) do
				SpellDurationTooltip:SetOwner(UIParent, "ANCHOR_NONE");
				SpellDurationTooltip:SetUnitDebuff("target", i);
				SDBuffDebuffs[i] = SpellDurationTooltipTextLeft1:GetText();
				i = i + 1;
			end
			i = i - 1;
			local index, spell
			for index, spell in SDSpellsTable[SDVars.Class] do
				for j = 1, i, 1 do
					if(string.find(SDBuffDebuffs[i], spell.name)) then
						SDBuffCreate(spell.name, target, GetTime());
					end
				end
			end
		end
	elseif(event == "CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE" or event == "CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE") then
		local spellName, target
		for target, spellName in string.gfind(arg1, SDCombatMsg["AFFLICTED"]) do
			SDBuffCreate(spellName, target, GetTime());
			return;
		end
	end
end

----------------------------------------------------------------------------------------------------
-- Name		: SDBuffOnUpdate
----------------------------------------------------------------------------------------------------
function SDBuffOnUpdate()
	local pointer, queue;
	-- Iterate through the queue and update the bar accordingly
	for pointer, queue in SDQueueTable do
		-- Make sure the right spell on the queue is updated for each of the bars
		if(this:GetName() == queue.frame) then
			local currentTime = GetTime();
			local TextTime = getglobal(this:GetName().."Time");
			local BuffFrameIcon = getglobal(this:GetName().."Icon");
			-- The spell is not yet to be finished
			if(currentTime <= queue.finish) then
				if(currentTime > queue.finish - 0.5) then
					-- Alpha ?
				elseif(currentTime > queue.finish - 1) then
					-- Alpha ?
				end
				TextTime:SetText(string.format("%.1f", math.max(queue.finish - currentTime, 0.0)))
			--[[ 
			When the bar breaks at the middle set the values back to default 
			and remove this item for the queue
			]]--
			else
				this:Hide();
				BuffFrameIcon:Hide();
				SDVars.Alpha = SDGlobal.Alpha;
				table.remove(SDQueueTable, pointer);
				SDEvent["Target"] = 0;
				SDEvent["IsPlayer"] = false;
			end
			break;
		end
	end
end

----------------------------------------------------------------------------------------------------
-- MAIN
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
-- Name		: SDBuffCreate
----------------------------------------------------------------------------------------------------
function SDBuffCreate(spellName, unit, time)
	local index, spell;
	local supported = false;
	for index, spell in SDSpellsTable[SDVars.Class] do
		if(spellName == spell.name) then
			if(spell.caststop and not SDIsNumber(unit)) then return; end
			if(spell.icon == "" or not spell.icon) then return; end
			supported = true;
			break;
		end
	end
	-- If the spell is not supported get out
	if(supported == false) then return; end
	
	-- Checking for critter match
	if(SDIsCritter(unit)) then return; end
	
	local frame;
	index = nil; spell = nil;
	-- Loop through all the appropriate class spells table and look for a spell match
	for index, spell in SDSpellsTable[SDVars.Class] do
		if(spellName == spell.name) then
			for frame = 1, SDGlobal.MaxBuffs, 1 do
				local BuffFrame = getglobal("SpellDurationBuff"..frame);
				local BuffFrameIcon = getglobal("SpellDurationBuff"..frame.."Icon");
				if(not BuffFrame:IsVisible()) then
					local stack = 0;
					local stackUnique = 0;
					local pointer, queue;
					--if(SDVars.IsPlayer) then 
					--	var = SDDiminishingHandler(spellName, unit, time, time + spell.duration); 
					--else 
					--	var = time + spell.duration;
					--end
					-- Insert this spell into the queue
					table.insert(SDQueueTable, {
						target = unit,
						start = time,
						finish = time + spell.duration,
						spell = spell.name,
						spellId = spell.id,
						frame = BuffFrame:GetName(),
						player = SDEvent["IsPlayer"],
					});
					-- Iterate through the queue and see if one of the spells found more then X
					for pointer, queue in SDQueueTable do
						if(spellName == queue.spell) then stack = stack + 1; end
						-- Check if we got this Mob/Player and Spell more then twice and remove it on the clean up
						if(spellName == queue.spell and unit == queue.target) then stackUnique = stackUnique + 1; end
					end
					-- Remove the last spells which got into the queue and need a clean up 
					if(stack > spell.targets or stackUnique > 1) then
						table.remove(SDQueueTable);
						return;
					end
					BuffFrameIcon:SetTexture("Interface\\Icons\\"..spell.icon);
					BuffFrameIcon:SetAlpha(1);
					BuffFrameIcon:Show();
					BuffFrame:Show();
					return;
				end
			end
		-- Only for debug matters so I can retrieve the rest of the data
		else
			--[[ SOME REAL JUNK CODE HERE ]]--
		end
	end
end

----------------------------------------------------------------------------------------------------
-- WIDGETS
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
-- Name		: SDBuffClick
----------------------------------------------------------------------------------------------------
function SDBuffClick()
	local pointer, queue;
	for pointer, queue in SDQueueTable do
		if(this:GetName() == queue.frame) then this:Hide(); end
	end
end

----------------------------------------------------------------------------------------------------
-- Name		: SDBuffStartMoving
----------------------------------------------------------------------------------------------------
function SDBuffStartMoving()
	if(SDGlobal.LockBuffs == 0) then
		SpellDurationBuffDragFrame:StartMoving();
	end
end

----------------------------------------------------------------------------------------------------
-- Name		: SDBuffsResetPosition
----------------------------------------------------------------------------------------------------
function SDBuffsResetPosition()
	SpellDurationBuffDragFrame:ClearAllPoints();
	SpellDurationBuffDragFrame:SetPoint("TOPRIGHT", "UIParent", "TOPRIGHT", -197, -180);
end
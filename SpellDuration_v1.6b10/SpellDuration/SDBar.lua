----------------------------------------------------------------------------------------------------
-- Name		: Spell Duration [Bar]
----------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------
-- USED ON EVENTS FUNCTIONS
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
-- Name		: SDBarOnEvent
----------------------------------------------------------------------------------------------------
function SDBarOnEvent(event)
	if(event == "UNIT_AURA") then
		if(arg1 == "target") then
			local i = 1;
			local target = UnitName("target");
			while(UnitDebuff("target", i)) do
				SpellDurationTooltip:SetOwner(UIParent, "ANCHOR_NONE");
				SpellDurationTooltip:SetUnitDebuff("target", i);
				SDBarDebuffs[i] = SpellDurationTooltipTextLeft1:GetText();
				i = i + 1;
			end
			i = i - 1;
			local index, spell
			for index, spell in SDSpellsTable[SDVars.Class] do
				for j = 1, i, 1 do
					if(string.find(SDBarDebuffs[i], spell.name)) then
						SDBarCreate(spell.name, target, GetTime());
					end
				end
			end
		end
	elseif(event == "CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE" or event == "CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE") then
		local spellName, target
		for target, spellName in string.gfind(arg1, SDCombatMsg["AFFLICTED"]) do
			SDBarCreate(spellName, target, GetTime());
			return;
		end
	elseif(event == "CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS") then
		local spellName;
		for spellName in string.gfind(arg1, SDCombatMsg["SELFAURA"]) do
			SDBarCreate(spellName, "", GetTime());
			return;
		end
	elseif(event == "CHAT_MSG_SPELL_SELF_DAMAGE") then
		local spellName, target
		for spellName, target in string.gfind(arg1, SDCombatMsg["PREFORM"]) do
			SDBarCreate(spellName, target, GetTime());
			return
		end
		for spellName, target in string.gfind(arg1, SDCombatMsg["CAST"]) do
			SDQueueUpdate(spellName, target, GetTime());
			SDBarCreate(spellName, target, GetTime());
			return
		end
	end
end
 
----------------------------------------------------------------------------------------------------
-- Name		: SDBarOnShow
----------------------------------------------------------------------------------------------------
function SDBarOnShow()
	this:SetAlpha(1);
	local StatusBar = getglobal(this:GetName().."StatusBar");
	local Spark = getglobal(this:GetName().."StatusBarSpark");
	StatusBar:SetStatusBarColor(1.0, 0.7, 0.0);
	Spark:SetPoint("CENTER", StatusBar:GetName(), "LEFT", 0, 0);
end

----------------------------------------------------------------------------------------------------
-- Name		: SDBarOnUpdate
----------------------------------------------------------------------------------------------------
function SDBarOnUpdate()
	local pointer, queue;
	local BarBerserkerFrame = getglobal("SpellDurationBerserkerFrame");
	local BarBerserkerText = getglobal(BarBerserkerFrame:GetName().."Text");
	-- Iterate through the queue and update the bar accordingly
	for pointer, queue in SDQueueTable do
		-- Make sure the right spell on the queue is updated for each of the bars
		if(this:GetName() == queue.frame) then
			local currentTime = GetTime();
			local duration = queue.finish;
			-- The spell is not yet to be finished
			if(currentTime <= duration) then
				local StatusBar = getglobal(this:GetName().."StatusBar");
				local Text = getglobal(this:GetName().."Text");
				local TextTime = getglobal(this:GetName().."Time");
				local Spark = getglobal(this:GetName().."StatusBarSpark");
				
				local sparkProgress = ((currentTime - queue.start) / (duration - queue.start)) * 197;

				Text:SetText(queue.spell);
				StatusBar:SetMinMaxValues(queue.start, duration);
				StatusBar:SetValue(GetTime());
				
				if(currentTime > duration - 0.5) then
					StatusBar:SetStatusBarColor(1.0, 0.0, 0.0);
				elseif(currentTime > duration - 1) then
					StatusBar:SetStatusBarColor(1.0, 0.88, 0.25);
				end
				
				TextTime:SetText(string.format("%.1f", math.max(duration - currentTime, 0.0)))
				
				if(sparkProgress < 0) then sparkProgress = 0; end
				
				Spark:SetPoint("CENTER", StatusBar:GetName(), "LEFT", sparkProgress, 0);
			-- Handle the alpha as long as the bar alpha is higher then its minimum value
			elseif(this:GetAlpha() > 0) then
				local a = this:GetAlpha() - SDVars.Alpha;
				if(a > 0) then
					this:SetAlpha(a);
				-- When we're done set the values back to default and remove this item for the queue
				else
					this.fadeOut = nil;
					this:Hide();
					SDVars.Alpha = SDGlobal.Alpha;
					BarBerserkerFrame:Hide();
					BarBerserkerText:SetText("");
					table.remove(SDQueueTable, pointer);
					SDEvent["Target"] = 0;
					SDEvent["IsPlayer"] = false;
				end
			--[[ 
			When the bar breaks at the middle set the values back to default 
			and remove this item for the queue
			]]--
			else
				this:Hide();
				SDVars.Alpha = SDGlobal.Alpha;
				BarBerserkerFrame:Hide();
				BarBerserkerText:SetText("");
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
-- Name		: SDBarCreate
----------------------------------------------------------------------------------------------------
function SDBarCreate(spellName, unit, time)
	local racial, index, spell;
	local supported = false;
	-- Racial Check
	if(SDVars.RegisteredRace) then
		for index, spell in SDRacialTable[SDVars.Race] do
			if(spellName == spell.name) then
				racial = true;
				supported = true;
				break;
			end
		end
	end
	-- Spells Check
	if(not racial) then
		index = nil; spell = nil;
		for index, spell in SDSpellsTable[SDVars.Class] do
			if(spellName == spell.name) then
				if(spell.caststop and not SDIsNumber(unit)) then return; end
				if(spell.icon and not SDConfig.BarsOnly) then return; end
				supported = true;
				break;
			end
		end
	end
	-- If the spell is not supported get out
	if(supported == false) then return; end

	-- Check whether is a racial bar to be activated or the spells bar
	if(not racial) then
		-- Checking for critter match
		if(SDIsCritter(unit)) then return; end

		local frame;
		index = nil; spell = nil;
		-- Loop through all the appropriate class spells table and look for a spell match
		for index, spell in SDSpellsTable[SDVars.Class] do
			if(spellName == spell.name) then
				for frame = 1, SDGlobal.MaxBars, 1 do
					local BarFrame = getglobal("SpellDurationBar"..frame);
					if(not BarFrame:IsVisible()) then
						local stack = 0;
						local stackUnique = 0;
						local pointer, queue;
						local duration =  spell.duration;
						--if(SDVars.IsPlayer) then 
						--	var = SDDiminishingHandler(spellName, unit, time, time + spell.duration); 
						--else 
						--	var = time + spell.duration;
						--end
						-- Insert this spell into the queue
						table.insert(SDQueueTable, {
							target = unit,
							start = time,
							finish = time + duration,
							spell = spell.name,
							spellId = spell.id,
							frame = BarFrame:GetName(),
							player = SDEvent["IsPlayer"],
						});
						-- Iterate through the queue and see if one of the spells found more then X
						for pointer, queue in SDQueueTable do
							if(spellName == queue.spell) then stack = stack + 1; end
							-- Check if we got this Mob/Player and Spell more then twice and remove it on the clean up
							if(spellName == queue.spell and (unit == queue.target and unit ~= SDGlobal.AoE)) then stackUnique = stackUnique + 1; end
						end
						-- Remove the last spells which got into the queue and need a clean up 
						if(stack > spell.targets or stackUnique > 1) then
							table.remove(SDQueueTable);
							return;
						end
						BarFrame:SetAlpha(1);
						BarFrame:Show();
						return;
					end
				end
			-- Only for debug matters so I can retrieve the rest of the data
			else
				--[[ SOME REAL JUNK CODE HERE ]]--
			end
		end
	else
		index = nil; spell = nil;
		for index, spell in SDRacialTable[SDVars.Race] do
			if(spellName == spell.name) then
				local BarFrame = getglobal("SpellDurationRacialBar");
				if(not BarFrame:IsVisible()) then
					local pointer, queue;
					-- Insert this spell into the queue
					table.insert(SDQueueTable, {
						target = unit,
						start = time,
						finish = time + spell.duration,
						spell = spellName,
						frame = BarFrame:GetName(),
						player = SDEvent["IsPlayer"],
					});
					if(spell.id == "Berserking" and SDConfig.BerserkerInfo) then SDRacialBarBerserker(); end
					BarFrame:SetAlpha(1);
					BarFrame:Show();
					return;
				end
			-- Only for debug matters so I can retrieve the rest of the data
			else
				--[[ SOME REAL JUNK CODE HERE ]]--
			end
		end
	end
end

----------------------------------------------------------------------------------------------------
-- RACIAL BAR
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
-- Name		: SDRacialBarBerserker
----------------------------------------------------------------------------------------------------
function SDRacialBarBerserker()
	local mainHandSpeed, offHandSpeed = UnitAttackSpeed("player");
	local mLowDmg, mHiDmg, offlowDmg, offhiDmg, posBuff, negBuff, percentmod = UnitDamage("player");
	local meleeAvgDmg = (mLowDmg + mHiDmg) / 2;
	local meleeAvgDPS = meleeAvgDmg / mainHandSpeed;
	
	local rannge;
	local rangedSpeed, lowDmg, hiDmg = UnitRangedDamage("player");
	local rangeAvgDmg = (lowDmg + hiDmg) / 2;
	local rangeAvgDPS = rangeAvgDmg / rangedSpeed;
	
	local BarBerserkerFrame = getglobal("SpellDurationBerserkerFrame");
	local BarBerserkerText = getglobal(BarBerserkerFrame:GetName().."Text");

	meleeAvgDPS = format("%.2f", meleeAvgDPS);
	rangeAvgDPS = format("%.2f", rangeAvgDPS);
	mainHandSpeed = format("%.2f", mainHandSpeed);
	
	if(offHandSpeed == nil) then 
		offHandSpeed = "none";
	else
		offHandSpeed = format("%.2f", offHandSpeed);
	end
	if(rangedSpeed == 0) then
		range = "\nRange: none";
	else
		range = "\nRange\n - Speed: "..format("%.2f", rangedSpeed).."\n - DPS: "..rangeAvgDPS;
	end
	
	BarBerserkerFrame:Show();
	BarBerserkerText:SetText("Melee\n - Main-Hand: "..mainHandSpeed.."\n - Off-Hand: "..offHandSpeed.."\n - Main-Hand DPS: "..meleeAvgDPS..range);
	BarBerserkerText:SetJustifyH("LEFT");
end

----------------------------------------------------------------------------------------------------
-- WIDGETS
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
-- Name		: SDBarClick
----------------------------------------------------------------------------------------------------
function SDBarClick()
	local pointer, queue;
	for pointer, queue in SDQueueTable do
		if(this:GetName() == queue.frame) then this:Hide(); end
	end
end

----------------------------------------------------------------------------------------------------
-- Name		: SDBarsStartMoving
----------------------------------------------------------------------------------------------------
function SDBarsStartMoving()
	if(SDGlobal.LockBars == 0) then
		SpellDurationBarDragFrame:StartMoving();
	end
end

----------------------------------------------------------------------------------------------------
-- Name		: SDRacialBarStartMoving
----------------------------------------------------------------------------------------------------
function SDRacialBarStartMoving()
	if(SDGlobal.LockRacialBar == 0) then
		SpellDurationRacialBarDragFrame:StartMoving();
	end
end

----------------------------------------------------------------------------------------------------
-- Name		: SDBerserkerStartMoving
----------------------------------------------------------------------------------------------------
function SDBerserkerStartMoving()
	if(SDGlobal.LockBerserker == 0) then
		SpellDurationBerserkerFrame:StartMoving();
	end
end

----------------------------------------------------------------------------------------------------
-- Name		: SDBarsResetPosition
----------------------------------------------------------------------------------------------------
function SDBarsResetPosition()
	-- Main Frame (Spell Bars)
	SpellDurationBarDragFrame:ClearAllPoints();
	SpellDurationBarDragFrame:SetPoint("CENTER", "UIParent", "CENTER", 0, -210);
	-- Racial Bar
	SpellDurationRacialBarDragFrame:ClearAllPoints();
	SpellDurationRacialBarDragFrame:SetPoint("CENTER", "UIParent", "CENTER", 0, 160);
	local BarFrame = getglobal("SpellDurationRacialBar");
	BarFrame:ClearAllPoints();
	BarFrame:SetPoint("TOP", "SpellDurationRacialBarDragFrame", "TOP", 0, -4);
	-- Berserker
	SpellDurationBerserkerFrame:ClearAllPoints();
	SpellDurationBerserkerFrame:SetPoint("TOPLEFT", "SpellDurationRacialBar", "TOPLEFT", 0, -30);
end
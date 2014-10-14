----------------------------------------------------------------------------------------------------
-- Name		: Spell Duration [Hooked]
----------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------
-- BLIZZARD SCOPE 
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
-- Name		: SDCastingBarFrame_OnUpdate
-- Support	: Blizzard Casting Bar
----------------------------------------------------------------------------------------------------
function SDCastingBarFrame_OnUpdate()
	-- Recast ...
	if(not SDVars.RegisteredClass) then return; end
	local BarFrame = CastingBarFrameStatusBar;
	if(this.casting) then
		if(not SDEvent["Casting"]) then
			local index, spell
			for index, spell in SDSpellsTable[SDVars.Class] do
				if(SDEvent["SpellName"] == spell.name and spell.special) then
					SDEvent["Casting"] = true;
					return
				end
			end
		end
	else
		if(not BarFrame:IsVisible() and SDEvent["Casting"]) then
			SDEvent["Casting"] = false;
			SDQueueUpdate(SDEvent["SpellName"], SDEvent["Target"], GetTime());
			SDEvent["SpellName"] = "";
			return;
		end
	end
end

----------------------------------------------------------------------------------------------------
-- Name		: SDUseAction
----------------------------------------------------------------------------------------------------
function SDUseAction(id, book, onself)
	-- Spell Casted
	local start, duration = GetActionCooldown(id);
	local isUsable, notEnoughMana = IsUsableAction(id);
	if(start <= 0 and duration <= 0 and isUsable and not notEnoughMana) then
		local oldVar = GetCVar("UberTooltips");
		SetCVar("UberTooltips", 1);
		SpellDurationTooltip:SetOwner(UIParent, "ANCHOR_NONE");
		SpellDurationTooltip:SetAction(id);
		SetCVar("UberTooltips", oldVar);
		SDEvent["SpellName"] = getglobal("SpellDurationTooltipTextLeft1"):GetText();
		SDSpell["Rank"] = getglobal("SpellDurationTooltipTextRight1"):GetText();
		if(SDEvent["SpellName"]) then
			SDEvent["Target"] = UnitName("target");
			SDEvent["IsPlayer"] = UnitIsPlayer("target");
			SDUseButton(SDSpell["Rank"]);
		end
	end
end

----------------------------------------------------------------------------------------------------
-- Name		: SDCastSpell
----------------------------------------------------------------------------------------------------
function SDCastSpell(id, book)
	-- Spell Casted
	local isSpell = SDIsSpellID(id);
	if(not isSpell) then return; end
	local start, duration = GetSpellCooldown(id,book);
	if(start <= 0 and duration <= 0) then
		SDSpell["Id"] = id;
		SDSpell["Book"] = book;
		SDEvent["SpellName"], SDSpell["Rank"] = GetSpellName(id, book);
		if(SDEvent["SpellName"]) then
			SDEvent["Target"] = UnitName("target");
			SDEvent["IsPlayer"] = UnitIsPlayer("target");
			SDUseButton(SDSpell["Rank"]);
		end
	end
end

----------------------------------------------------------------------------------------------------
-- Name		: SDCastSpellByName
----------------------------------------------------------------------------------------------------
function SDCastSpellByName(spellName)
	-- Spell Casted
	local id = SDGetSpellID(spellName);
	if(not id) then return; end
	local start, duration = GetSpellCooldown(id, BOOKTYPE_SPELL);
	if(start <= 0 and duration <= 0) then
		SDSpell["Id"] = id;
		SDSpell["Book"] = BOOKTYPE_SPELL;
		SDEvent["SpellName"], SDSpell["Rank"] = GetSpellName(id, BOOKTYPE_SPELL);
		if(SDEvent["SpellName"]) then
			SDEvent["Target"] = UnitName("target");
			SDEvent["IsPlayer"] = UnitIsPlayer("target");
			SDUseButton(SDSpell["Rank"]);
		end
	end
end

----------------------------------------------------------------------------------------------------
-- ADDONS SUPPORT SCOPE 
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
-- Name		: SDeCastingBar_OnUpdate
-- Support	: eCastingBar
----------------------------------------------------------------------------------------------------
function SDeCastingBar_OnUpdate(frame)
	-- Recast ...
	if(not SDVars.RegisteredClass) then return; end
	local BarFrame = getglobal("eCastingBar"..frame);
	if(BarFrame.casting) then
		if(not SDEvent["Casting"]) then
			local index, spell
			for index, spell in SDSpellsTable[SDVars.Class] do
				if(SDEvent["SpellName"] == spell.name and spell.special) then
					SDEvent["Casting"] = true;
					return
				end
			end
		end
	else
		if(not BarFrame:IsVisible() and SDEvent["Casting"]) then
			SDEvent["Casting"] = false;
			SDQueueUpdate(SDEvent["SpellName"], SDEvent["Target"], GetTime());
			SDEvent["SpellName"] = "";
			return;
		end
	end
end

----------------------------------------------------------------------------------------------------
-- Name		: SDDHUD_OnUpdate
-- Support	: DHUD
----------------------------------------------------------------------------------------------------
function SDDHUD_OnUpdate()
	-- Recast ...
	if(not SDVars.RegisteredClass) then return; end
	if(not DHUD_Config["castingbar"] == 1) then return; end
	local BarFrame = DHUD_CastingBarTexture;
	if(this.casting) then
		if(not SDEvent["Casting"]) then
			local index, spell
			for index, spell in SDSpellsTable[SDVars.Class] do
				if(SDEvent["SpellName"] == spell.name and spell.special) then
					SDEvent["Casting"] = true;
					return
				end
			end
		end
	else
		if(not BarFrame:IsVisible() and SDEvent["Casting"]) then
			SDEvent["Casting"] = false;
			SDQueueUpdate(SDEvent["SpellName"], SDEvent["Target"], GetTime());
			SDEvent["SpellName"] = "";
			return;
		end
	end
end

----------------------------------------------------------------------------------------------------
-- Name		: otravi_CastingBar
-- Support	: otravi
----------------------------------------------------------------------------------------------------
function SDOtravi_OnUpdate()
	-- Recast ...
	if(not SDVars.RegisteredClass) then return; end
	
	local BarFrame = CastingBarFrame;
	if(this.casting) then
		if(not SDEvent["Casting"]) then
			local index, spell
			for index, spell in SDSpellsTable[SDVars.Class] do
				if(SDEvent["SpellName"] == spell.name and spell.special) then
					SDEvent["Casting"] = true;
					return
				end
			end
		end
	else
		if(not BarFrame:IsVisible() and SDEvent["Casting"]) then
			SDEvent["Casting"] = false;
			SDQueueUpdate(SDEvent["SpellName"], SDEvent["Target"], GetTime());
			SDEvent["SpellName"] = "";
			return;
		end
	end
end
--[[
	Aspected by PoeticDragon

	Simply enough, this uses Blizzard's shapeshift bar
	for some specific class spells.  Priests and Shamans
	get their shapeshift form much like a druid would,
	and hunters get aspects similar paladin auras.

	A new feature of this version is the ability to toggle
	page switching for each individual spell and set
	which page it should go to.  This is turned off by
	default.  To enable, simply switch your main bar to
	the page you want, and alt-click on the spell to set.
	Alt-clicking a spell while on page 1 will reset it.

	This is actually a combination of two addons I wrote,
	called Aspected and Shapeshifter.  This incarnation
	maximizes the efficiency and simplicity of Aspected's
	hunter code while still supporting priest and shamans.
	It truly is new and improved.

]]--

-------------------------------------------------------------------------------
-- Constants
-------------------------------------------------------------------------------

ASPECTED_ACTIVE_NORMAL = "Interface\\Icons\\Spell_Nature_WispSplode";
ASPECTED_ACTIVE_PRIEST = "Interface\\Icons\\Spell_Shadow_ChillTouch";

-------------------------------------------------------------------------------
-- Variables
-------------------------------------------------------------------------------

Aspected_ClassSpells = {};
Aspected_FormID = {};
Aspected_PageID = {};
Aspected_OldActionBar = CURRENT_ACTIONBAR_PAGE;
Aspected_SwapPage = false;

-------------------------------------------------------------------------------
-- Functions
-------------------------------------------------------------------------------

-- Executed on load, calls general set-up functions
function Aspected_OnLoad()
	-- Class-based setup, abort if not supported
	local class = UnitClass("player");
	if ( class ~= ASPECTED_CLASS_PRIEST and
	     class ~= ASPECTED_CLASS_SHAMAN and
	     class ~= ASPECTED_CLASS_HUNTER ) then
		return;
	end

	-- Store the spell list for later
	Aspected_ClassSpells = ASPECTED_SPELLS[class];

	-- Set up the hooks into original shapeshift functions
	Aspected_Original_GetNumShapeshiftForms = GetNumShapeshiftForms;
	GetNumShapeshiftForms = Aspected_GetNumShapeshiftForms;
	Aspected_Original_CastShapeshiftForm = CastShapeshiftForm;
	CastShapeshiftForm = Aspected_CastShapeshiftForm;
	Aspected_Original_GetShapeshiftFormInfo = GetShapeshiftFormInfo;
	GetShapeshiftFormInfo = Aspected_GetShapeshiftFormInfo;
	Aspected_Original_GetShapeshiftFormCooldown = GetShapeshiftFormCooldown;
	GetShapeshiftFormCooldown = Aspected_GetShapeshiftFormCooldown;
	Aspected_Original_SetShapeshift = GameTooltip.SetShapeshift;
	GameTooltip.SetShapeshift = Aspected_SetShapeshift;

	-- Hooks for positioning the pet bar because Blizz handles it badly.  Blah.
	Aspected_Original_Update = MultiActionBar_Update;
	MultiActionBar_Update = Aspected_Update;
	ShowPetActionBar = Aspected_ShowPetActionBar;
	PetActionBar_UpdatePosition = Aspected_UpdatePosition;

	-- Only update when the player's buff or action page has changed
	this:RegisterEvent("PLAYER_AURAS_CHANGED");
	this:RegisterEvent("ACTIONBAR_PAGE_CHANGED");
end

-- Handles events, only called when the player's buffs or pages change
function Aspected_OnEvent(event)
	if ( event == "PLAYER_AURAS_CHANGED" ) then
		local currAspect = Aspected_GetCurrentAspect();
		local page = CURRENT_ACTIONBAR_PAGE;

		-- Switch back to the original action bar before checking new one
		if ( page ~= Aspected_OldActionBar ) then
			CURRENT_ACTIONBAR_PAGE = Aspected_OldActionBar;
		end

		-- Only swap pages for those which have one set
		if ( currAspect ) then
			local swap = Aspected_PageID[currAspect];
			if ( swap ) then
				-- Switch to the shapeshift action bar
				CURRENT_ACTIONBAR_PAGE = swap;
				Aspected_SwapPage = true;
			end
		end

		-- Update if page has changed
		if ( page ~= CURRENT_ACTIONBAR_PAGE ) then
			ChangeActionBarPage();
		end
	else
		-- Only store the old page when the player manually sets it
		if ( not Aspected_SwapPage ) then
			Aspected_OldActionBar = CURRENT_ACTIONBAR_PAGE;
		end
		Aspected_SwapPage = false;
	end
end

-- Displays the tooltip with spell information
function Aspected_SetShapeshift(tooltip, id)
	local spell = Aspected_GetAspectFromID(id);
	if ( spell ) then
		--Display the tooltip
		return tooltip:SetSpell(Aspected_GetAspectID(spell), BOOKTYPE_SPELL);
	else
		return Aspected_Original_SetShapeshift(tooltip, id);
	end
end

-- Gets the number of forms (should be 0) and adds the extra aspects the player has
function Aspected_GetNumShapeshiftForms()
	local numForms = Aspected_Original_GetNumShapeshiftForms();
	for n,spell in pairs(Aspected_ClassSpells) do
		if ( Aspected_GetAspectID(spell) > -1 ) then
			numForms = numForms + 1;
			Aspected_FormID[spell] = numForms;
		end
	end
	return numForms;
end

-- Casts an aspect or shapeshift
function Aspected_CastShapeshiftForm(id)
	local spell = Aspected_GetAspectFromID(id);
	if ( spell ) then
		if ( IsShiftKeyDown() ) then
			if ( IsAltKeyDown() ) then
				Aspected_SetPageSwap(id, CURRENT_ACTIONBAR_PAGE, spell);
			elseif ( IsControlKeyDown() ) then
				Aspected_SetPageSwap(id, nil, spell);
			end
		else
			-- Cast the aspect!
			CastSpell(Aspected_GetAspectID(spell), BOOKTYPE_SPELL);
		end
	else
		Aspected_Original_CastShapeshiftForm(id);
	end
end


-- Returns the icon, name, active state, and cast state of the given aspect
function Aspected_GetShapeshiftFormInfo(id)
	local name, texture = Aspected_GetAspectFromID(id);
	if ( name ) then
		local isActive = Aspected_IsAspectActive(texture);
		local isCastable = true;
		-- Fix to darken it while active
		if ( isActive ) then
			if ( UnitClass("player") == ASPECTED_CLASS_PRIEST ) then
				texture = ASPECTED_ACTIVE_PRIEST;
			else
				texture = ASPECTED_ACTIVE_NORMAL;
			end
		end
		return texture, name, isActive, isCastable;
	else
		return Aspected_Original_GetShapeshiftFormInfo(id);
	end
end

-- Returns the cooldown on the given aspect spell
function Aspected_GetShapeshiftFormCooldown(id)
	local spell = Aspected_GetAspectFromID(id);
	if ( spell ) then
		return GetSpellCooldown(Aspected_GetAspectID(spell), BOOKTYPE_SPELL);
	else
		return Aspected_Original_GetShapeshiftFormCooldown(id);
	end
end

-- Returns the ID of the given aspect spell from the spellbook
function Aspected_GetAspectID(aspect)
	local i = 1;
	local valid = -1;
	local spellName, spellRank = GetSpellName(i, BOOKTYPE_SPELL)
	while spellName do
		if ( spellName == aspect) then
			valid = i;
		elseif ( valid > -1 ) then
			return valid;
		end
		i = i + 1;
		spellName, spellRank = GetSpellName(i, BOOKTYPE_SPELL)
	end
	return -1;
end

-- Returns the name and texture of an aspect
function Aspected_GetAspectFromID(id)
	for spell,i in pairs(Aspected_FormID) do
		if ( i == id ) then
			return spell, GetSpellTexture(Aspected_GetAspectID(spell), BOOKTYPE_SPELL);
		end
	end
	return nil;
end

-- Returns the shapeshift bar ID of the currently active aspect
function Aspected_GetCurrentAspect()
	for spell,i in pairs(Aspected_FormID) do
		id = Aspected_GetAspectID(spell);
		if ( id > -1 ) then
			local texture = GetSpellTexture(id, BOOKTYPE_SPELL);
			if ( Aspected_IsAspectActive(texture) ) then
				return i;
			end
		end
	end
	return nil;
end

-- Returns whether the player has the aspect on or not, based on his buffs
function Aspected_IsAspectActive(texture)
	local id = 0;
	for id = 0, 15 do
		if ( GetPlayerBuffTexture(id) == texture ) then
			return true;
		end
	end
	return false;
end

-- Sets or unsets which page to switch to when activating the aspect
function Aspected_SetPageSwap(id, page, aspect)
	Aspected_PageID[id] = page;
	if ( not page ) then
		UIErrorsFrame:AddMessage(string.gsub(ASPECTED_MSG_RESET, "$a", aspect), 1.0, 0.1, 0.1, 1.0, UIERRORS_HOLD_TIME);
	else
		UIErrorsFrame:AddMessage(string.gsub(ASPECTED_MSG_BIND, "$a", aspect)..page, 1.0, 0.1, 0.1, 1.0, UIERRORS_HOLD_TIME);
	end
end

-- This is the only function that I can use to call the updates when the right bar is toggled
function Aspected_Update()
	Aspected_Original_Update();
	PetActionBar_UpdatePosition();
	ShapeshiftBar_UpdatePosition();
end

-- Pet action bar stuff ... copied and edited here to fix a positioning bug
function Aspected_ShowPetActionBar()
	PetActionBar_UpdatePosition();
	if ( PetHasActionBar() and PetActionBarFrame.showgrid == 0 and (PetActionBarFrame.mode ~= "show") and not PetActionBarFrame.locked and not PetActionBarFrame.ctrlPressed ) then
		PetActionBarFrame:Show();
		PetActionBarFrame:SetFrameStrata("BACKGROUND");
		if ( PetActionBarFrame.completed ) then
			PetActionBarFrame.slideTimer = 0;
		end
		PetActionBarFrame.timeToSlide = PETACTIONBAR_SLIDETIME;
		PetActionBarFrame.yTarget = PETACTIONBAR_YPOS;
		PetActionBarFrame.mode = "show";

		-- Rare case
		if ( GetNumShapeshiftForms() > 0 ) then
			-- THIS IS THE ONLY LINE I CHANGED:
			PETACTIONBAR_XPOS = 500;
		else
			PETACTIONBAR_XPOS = 36
		end
	end
end

-- More positioning petbar crap
function Aspected_UpdatePosition()
	-- Small edit to check which multibar we're checking
	if ( GetNumShapeshiftForms() > 0 ) then
		MultiBarOn = MultiBar2_IsVisible();
	else
		MultiBarOn = MultiBar1_IsVisible();
	end

	if ( MultiBarOn ) then
		PETACTIONBAR_YPOS = 141;
		SlidingActionBarTexture0:Hide();
		SlidingActionBarTexture1:Hide();
	else
		PETACTIONBAR_YPOS = 98;
		SlidingActionBarTexture0:Show();
		SlidingActionBarTexture1:Show();
	end
	if ( not PetActionBarFrame:IsVisible() ) then
		return;
	end
	PetActionBarFrame:SetPoint("TOPLEFT", "MainMenuBar", "BOTTOMLEFT", PETACTIONBAR_XPOS, PETACTIONBAR_YPOS);
end








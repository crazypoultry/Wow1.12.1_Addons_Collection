-- don't do this if we're actually running WoW 2.0
if not string.find(GetBuildInfo(), "^2%.") then

-- The modified attribute" takes the form of: modifier-name-button
-- The modifier is one of "shift-", "ctrl-", "alt-", and the button is a number from 1 through 5.
--
-- For example, you could set an action that is used for unmodified left click like this:
-- self:SetAttribute("action1", value);
-- You could set an action that is used for shift-right-click like this:
-- self:SetAttribute("shift-action2", value);
--
-- You can also use a wildcard in the place of the modifier or button to denote an attribute
-- that is used for any modifier or any button.
--
-- For example, you could set an action that is used for any left click like this:
-- self:SetAttribute("*action1", value);
-- You could set an action that is used for shift-click with any button like this:
-- self:SetAttribute("shift-action*", value);
--
ATTRIBUTE_NOOP = "";
-- You can exclude an action by explicitly setting its value to ATTRIBUTE_NOOP
--
-- For example, you could set an action that was used for all clicks except ctrl-left-click:
-- self:SetAttribute("*action*", value);
-- self:SetAttribute("shift-action1", ATTRIBUTE_NOOP);
--
-- Setting the attribute by itself is equivalent to *attribute*

function InsecureButton_GetModifierPrefix()
    local prefix = "";
    if ( IsShiftKeyDown() ) then
        prefix = "shift-"..prefix;
    end
    if ( IsControlKeyDown() ) then
        prefix = "ctrl-"..prefix;
    end
    if ( IsAltKeyDown() ) then
        prefix = "alt-"..prefix;
    end
	return prefix;
end

function InsecureButton_GetButtonSuffix(button)
	local suffix = "";
    if ( button == "LeftButton" ) then
        suffix = "1";
    elseif ( button == "RightButton" ) then
        suffix = "2";
    elseif ( button == "MiddleButton" ) then
        suffix = "3";
    elseif ( button == "Button4" ) then
        suffix = "4";
    elseif ( button == "Button5" ) then
        return "5";
    elseif ( button and button ~= "" ) then
        suffix = "-" .. tostring(button);
    end
    return suffix;
end

function InsecureButton_GetModifiedAttribute(frame, name, button, prefix, suffix)
	if ( not prefix ) then
		prefix = InsecureButton_GetModifierPrefix();
	end
	if ( not suffix ) then
		suffix = InsecureButton_GetButtonSuffix(button);
	end
    local value = frame:GetAttribute(prefix..name..suffix) or
                  frame:GetAttribute("*"..name..suffix) or
                  frame:GetAttribute(prefix..name.."*") or
                  frame:GetAttribute("*"..name.."*") or
                  frame:GetAttribute(name);
    if ( not value and (frame:GetAttribute("useparent-"..name) or
                        frame:GetAttribute("useparent*")) ) then
        local parent = frame:GetParent();
        if ( parent ) then
            value = InsecureButton_GetModifiedAttribute(parent, name, button, prefix, suffix);
        end
    end
    if ( value == ATTRIBUTE_NOOP ) then
        value = nil;
    end
    return value;
end
function InsecureButton_GetAttribute(frame, name)
	return InsecureButton_GetModifiedAttribute(frame, name, nil, "", "");
end

function InsecureButton_GetModifiedUnit(self, button)
	local unit = InsecureButton_GetModifiedAttribute(self, "unit", button);
	if ( unit ) then
		local unitsuffix = InsecureButton_GetModifiedAttribute(self, "unitsuffix", button);
		if ( unitsuffix ) then
			unit = unit .. unitsuffix;
			-- map raid1pet to raidpet1
			unit = gsub(unit, "^([^%d]+)([%d]+)[pP][eE][tT]", "%1pet%2");
		end
	end
	return unit;
end
function InsecureButton_GetUnit(self)
	local unit = InsecureButton_GetAttribute(self, "unit");
	if ( unit ) then
		local unitsuffix = InsecureButton_GetAttribute(self, "unitsuffix");
		if ( unitsuffix ) then
			unit = unit .. unitsuffix;
			-- map raid1pet to raidpet1
			unit = gsub(unit, "^([^%d]+)([%d]+)[pP][eE][tT]", "%1pet%2");
		end
	end
	return unit;
end

--
-- InsecureActionButton
--
-- InsecureActionButtons allow you to map different combinations of modifiers and buttons into
-- actions which are executed when the button is clicked.
--
-- For example, you could set up the button to respond to left clicks by targeting the focus:
-- self:SetAttribute("unit", "focus");
-- self:SetAttribute("type1", "target");
--
-- You could set up all other buttons to bring up a menu like this:
-- self:SetAttribute("type*", "menu");
-- self.showmenu = menufunc;
--
-- InsecureActionButtons are also able to perform different actions depending on whether you can
-- attack the unit or assist the unit associated with the action button.  It does so by mapping
-- mouse buttons into "virtual buttons" based on the state of the unit. For example, you can use
-- the following to cast "Mind Blast" on a left click and "Shadow Word: Death" on a right click
-- if the unit can be attacked:
-- self:SetAttribute("harmbutton1", "nuke1");
-- self:SetAttribute("type-nuke1", "spell");
-- self:SetAttribute("spell-nuke1", "Mind Blast");
-- self:SetAttribute("harmbutton2", "nuke2");
-- self:SetAttribute("type-nuke2", "spell");
-- self:SetAttribute("spell-nuke2", "Shadow Word: Death");
--
-- In this example, we use the special attribute "harmbutton" which is used to map a virtual
-- button when the unit is attackable. We also have the attribute "helpbutton" which is used
-- when the unit can be assisted.
--
-- Although it may not be immediately obvious, we are able to use this new virtual button
-- to set up very complex click behaviors on buttons. For example, we can define a new "heal"
-- virtual button for all friendly left clicks, and then set the button to cast "Flash Heal"
-- on an unmodified left click and "Renew" on a ctrl left click:
-- self:SetAttribute("*helpbutton1", "heal");
-- self:SetAttribute("*type-heal", "spell");
-- self:SetAttribute("spell-heal", "Flash Heal");
-- self:SetAttribute("ctrl-spell-heal", "Renew");
--
-- This system is very powerful, and provides a good layer of abstraction for setting up
-- a button's click behaviors.

function InsecureActionButton_OnClick(self, button)

	-- Allow remapping from a 'detached' state header
	local stateheader = self:GetAttribute("stateheader"); 
	if ( stateheader and (not InCombatLockdown() or stateheader:IsProtected()) ) then 
		local state = tostring(stateheader:GetAttribute("state") or "0");
		button = InsecureState_GetStateModifiedAttribute(self, state, "statebutton", button) or button;
	end

	-- Lookup the unit, based on the modifiers and button
	local unit = InsecureButton_GetModifiedUnit(self, button);

	-- Don't do anything if our unit doesn't exist
	if ( unit and not UnitExists(unit) ) then
		return;
	end
 
	-- Remap button suffixes based on the disposition of the unit (contributed by Iriel and Cladhaire)
    if ( unit ) then
		local origButton = button;
        if ( UnitCanAttack("player", unit) )then
            button = InsecureButton_GetModifiedAttribute(self, "harmbutton", button) or button;
        elseif ( UnitCanAssist("player", unit) )then
            button = InsecureButton_GetModifiedAttribute(self, "helpbutton", button) or button;
        end

		-- The unit may have changed based on button remapping
		if ( button ~= origButton ) then
			unit = InsecureButton_GetModifiedUnit(self, button);

			-- Don't do anything if our unit doesn't exist
			if ( unit and not UnitExists(unit) ) then
				return;
			end
		end
    end

	-- Lookup the action type, based on the modifiers and button
	local type = InsecureButton_GetModifiedAttribute(self, "type", button);

	-- Perform the requested action!
	if ( type == "actionbar" ) then
		local action = InsecureButton_GetModifiedAttribute(self, "action", button);
		if ( action == "increment" ) then
			ActionBar_PageUp();
		elseif ( action == "decrement" ) then
			ActionBar_PageDown();
		elseif ( tonumber(action) ) then
			ChangeActionBarPage(action);
		else
			local a, b = strmatch(action, "^(%d+),%s*(%d+)$");
			if ( GetActionBarPage() == tonumber(a) ) then
				ChangeActionBarPage(b);
			else
				ChangeActionBarPage(a);
			end
		end
	elseif ( type == "action" ) then
		local action = InsecureButton_GetModifiedAttribute(self, "action", button);
		if ( action ) then
			-- Save macros in case the one for this action is being edited
			MacroFrame_SaveMacro();

			UseAction(action, 0, unit);
		end
	elseif ( type == "pet" ) then
		local action = InsecureButton_GetModifiedAttribute(self, "action", button);
		if ( action ) then
			CastPetAction(action, unit);
		end
	elseif ( type == "spell" ) then
		local spell = InsecureButton_GetModifiedAttribute(self, "spell", button);
		if ( spell ) then
			CastSpellByName(spell, unit);

			-- Target items, if needed
			if ( SpellCanTargetItem() ) then
				local bag = InsecureButton_GetModifiedAttribute(self, "bag", button);
				local slot = InsecureButton_GetModifiedAttribute(self, "slot", button);
				if ( slot ) then
					if ( bag ) then
						UseContainerItem(bag, slot);
					else
						UseInventoryItem(slot);
					end
				else
					local item = InsecureButton_GetModifiedAttribute(self, "item", button);
					if ( item ) then
						SpellTargetItem(item);
					end
				end
			end
		end
	elseif ( type == "item" ) then
		local bag = InsecureButton_GetModifiedAttribute(self, "bag", button);
		local slot = InsecureButton_GetModifiedAttribute(self, "slot", button);
		if ( slot ) then
			if ( bag ) then
				UseContainerItem(bag, slot, unit);
			else
				UseInventoryItem(slot, unit);
			end
		else
			local item = InsecureButton_GetModifiedAttribute(self, "item", button);
			if ( item ) then
				UseItemByName(item, unit);
			end
		end
	elseif ( type == "macro" ) then
		local macro = InsecureButton_GetModifiedAttribute(self, "macro", button);
		if ( macro ) then
			-- Save macros in case the one for this action is being edited
			MacroFrame_SaveMacro();

			RunMacro(macro);
		end
	elseif ( type == "stop" ) then
		if ( SpellIsTargeting() ) then
			SpellStopTargeting();
		end
	elseif ( type == "target" ) then
		if ( SpellIsTargeting() ) then
			SpellTargetUnit(unit);
		elseif ( CursorHasItem() ) then
			DropItemOnUnit(unit);
		else
			TargetUnit(unit);
		end
	elseif ( type == "focus" ) then
		FocusUnit(unit);
	elseif ( type == "assist" ) then
		AssistUnit(unit);
	elseif ( type == "click" ) then
		local delegate = InsecureButton_GetModifiedAttribute(self, "clickbutton", button);
		if ( delegate ) then
			delegate:Click(button);
		end
	elseif ( type == "menu" ) then
		if ( self.showmenu ) then
			self:showmenu(unit);
		end
	end
end

function InsecureUnitButton_OnLoad(self, unit, menufunc)
	self:SetAttribute("type1", "target");
	self:SetAttribute("type*", "menu");
	self:SetAttribute("unit", unit);
	self.showmenu = menufunc;
end

function InsecureUnitButton_OnClick(self, button)
    local type = InsecureButton_GetModifiedAttribute(self, "type", button);
    if ( type == "menu" ) then
        if ( SpellIsTargeting() ) then
            SpellStopTargeting();
            return;
        end
    end
    InsecureActionButton_OnClick(self, button);
end

--
-- InsecureStateDriver contributed with permission by: Iriel
--

-- Prepare the frame to receive and process state changing events
function InsecureStateDriver_OnLoad(self)
	self:RegisterEvent("ACTIONBAR_PAGE_CHANGED");
    self:RegisterEvent("UPDATE_SHAPESHIFT_FORMS");
    self:RegisterEvent("PLAYER_AURAS_CHANGED");
end

-- Handle a state changing event and issue SetAttribute calls if the state changes.
function InsecureStateDriver_OnEvent(self, event)
	if ( event == "ACTIONBAR_PAGE_CHANGED" ) then
		local oldState = self:GetAttribute("state-actionbar");
		local curState = GetActionBarPage();
		if ( oldState ~= curState ) then
			self:SetAttribute("state-actionbar", curState);
		end
		return;
	end
	if ( event == "UPDATE_SHAPESHIFT_FORMS" or
	     event == "PLAYER_AURAS_CHANGED" ) then
		local oldState = self:GetAttribute("state-stance");

		local curState = 0;
		for i = 1, GetNumShapeshiftForms() do
			local _,_,isActive = GetShapeshiftFormInfo(i);
			if (isActive) then
				curState = i;
				break;
			end
		end

		if ( oldState ~= curState ) then
			self:SetAttribute("state-stance", curState);
		end
		return;
	end
end

--
-- InsecurePartyHeader and InsecureRaidGroupHeader contributed with permission by: Esamynn, Cide, and Iriel
--

--[[
List of the various configuration attributes
======================================================
nameList = [STRING] -- a comma separated list of player names (not used if 'groupFilter' is set)
groupFilter = [1-8, STRING] -- a comma seperated list of raid group numbers and/or uppercase class names
strictFiltering = [BOOLEAN] - if true, then characters must match both a group and a class from the groupFilter list
point = [STRING] -- a valid XML anchoring point (Default: "TOP")
xOffset = [NUMBER] -- the x-Offset to use when anchoring the unit buttons (Default: 0)
yOffset = [NUMBER] -- the y-Offset to use when anchoring the unit buttons (Default: 0)
sortMethod = ["INDEX", "NAME"] -- defines how the group is sorted (Default: "INDEX")
sortDir = ["ASC", "DESC"] -- defines the sort order (Default: "ASC")
template = [STRING] -- the XML template to use for the unit buttons
templateType = [STRING] - specifies the frame type of the managed subframes (Default: "Button")
--]]

function InsecurePartyHeader_OnLoad(self)
	this:RegisterEvent("PARTY_MEMBERS_CHANGED");
	this:RegisterEvent("PARTY_MEMBER_ENABLE");
	this:RegisterEvent("PARTY_MEMBER_DISABLE");
end

function InsecurePartyHeader_OnEvent(self, event)
	if ( (event == "PARTY_MEMBERS_CHANGED" or
	      event == "PARTY_MEMBER_ENABLE" or
	      event == "PARTY_MEMBER_DISABLE") and self:IsVisible() ) then
		InsecurePartyHeader_Update(self);
	end
end

function InsecurePartyHeader_OnAttributeChanged(self, name, value)
	if ( self:IsVisible() ) then
		InsecurePartyHeader_Update(self);
	end
end

function InsecureRaidGroupHeader_OnLoad(self)
	self:RegisterEvent("RAID_ROSTER_UPDATE");
end

function InsecureRaidGroupHeader_OnEvent(self, event)
	if ( event == "RAID_ROSTER_UPDATE" and self:IsVisible() ) then
		InsecureRaidGroupHeader_Update(self);
	end
end

function InsecureRaidGroupHeader_OnAttributeChanged(self, name, value)
	if ( self:IsVisible() ) then
		InsecureRaidGroupHeader_Update(self);
	end
end

-- relativePoint, xMultiplier, yMultiplier = getRelativePointAnchor( point )
-- Given a point return the opposite point and which axes the point
-- depends on.
local function getRelativePointAnchor( point )
	point = strupper(point);
	if (point == "TOP") then
		return "BOTTOM", 0, -1;
	elseif (point == "BOTTOM") then
		return "TOP", 0, 1;
	elseif (point == "LEFT") then
		return "RIGHT", 1, 0;
	elseif (point == "RIGHT") then
		return "LEFT", -1, 0;
	elseif (point == "TOPLEFT") then
		return "BOTTOMRIGHT", 1, -1;
	elseif (point == "TOPRIGHT") then
		return "BOTTOMLEFT", -1, -1;
	elseif (point == "BOTTOMLEFT") then
		return "TOPRIGHT", 1, 1;
	elseif (point == "BOTTOMRIGHT") then
		return "TOPLEFT", -1, 1;
	else
		return "CENTER", 0, 0;
	end
end

function ApplyUnitButtonConfiguration( ... )
	for i = 1, select("#", arg), 1 do
		local frame = select(i, arg);
		local anchor = frame:GetAttribute("initial-anchor");
		local width = tonumber(frame:GetAttribute("initial-width") or nil);
		local height = tonumber(frame:GetAttribute("initial-height")or nil);
		local scale = tonumber(frame:GetAttribute("initial-scale")or nil);
		local unitWatch = frame:GetAttribute("initial-unitWatch");
		if ( anchor ) then
			local point, relPoint, xOffset, yOffset = strsplit(",", anchor);
			relpoint = relpoint or point;
			xOffset = tonumber(xOffset) or 0;
			yOffset = tonumber(yOffset) or 0;
			frame:SetPoint(point, frame:GetParent(), relPoint, xOffset, yOffset);
		end
		if ( width ) then
			frame:SetWidth(width);
		end
		if ( height ) then
			frame:SetHeight(height);
		end
		if ( scale ) then
			frame:SetScale(scale);
		end
		if ( unitWatch ) then
			if ( unitWatch == "state" ) then
				RegisterUnitWatch(frame, true);
			else
				RegisterUnitWatch(frame);
			end
		end
		
		-- call this function recursively for the current frame's children
		ApplyUnitButtonConfiguration(frame:GetChildren());
	end
end

local function ApplyConfig( header, newChild, defaultConfigFunction )
	local configFunction = header.initialConfigFunction or defaultConfigFunction;
	if ( type(configFunction) == "function" ) then
		configFunction(newChild);
		return true;
	end
end

function SetupUnitButtonConfiguration( header, newChild, defaultConfigFunction )
	newChild:AllowAttributeChanges();
	if ( ApplyConfig(header, newChild, defaultConfigFunction) ) then
		ApplyUnitButtonConfiguration(newChild);
	end
end

-- empties tbl and assigns the value true to each key passed as part of ...
local function fillTable( tbl, ... )
	for key in pairs(tbl) do
		tbl[key] = nil;
	end
	for i = 1, select("#", arg), 1 do
		local key = select(i, arg);
		key = tonumber(key) or key;
		tbl[key] = true;
	end
end

-- same as fillTable() except that each key is also stored in 
-- the array portion of the table in order
local function doubleFillTable( tbl, ... )
	fillTable(tbl, unpack(arg));
	for i = 1, select("#", arg), 1 do
		tbl[i] = select(i, arg);
	end
end

--working tables
local tokenTable = {};
local sortingTable = {};

-- creates child frames and finished configuring them
local function configureChildren(self)
	local point = self:GetAttribute("point") or "TOP"; --default anchor point of "TOP"
	local relativePoint, xOffsetMult, yOffsetMult = getRelativePointAnchor(point);
	local xMultiplier, yMultiplier =  abs(xOffsetMult), abs(yOffsetMult);
	local xOffset = self:GetAttribute("xOffset") or 0; --default of 0
	local yOffset = self:GetAttribute("yOffset") or 0; --default of 0
	local sortMethod = self:GetAttribute("sortMethod") or "INDEX"; --sort by ID by default
	local sortDir = self:GetAttribute("sortDir") or "ASC"; --sort ascending by default

	if ( sortMethod == "NAME" ) then
		table.sort(sortingTable);
	end
	
	local unitCount = table.getn(sortingTable);
	
	-- ensure there are enough buttons
	local needButtons = max(1, unitCount);
	if not ( self:GetAttribute("child"..needButtons) ) then
		local buttonTemplate = self:GetAttribute("template");
		local templateType = self:GetAttribute("templateType") or "Button";
		local name = self:GetName();
		if not ( buttonTemplate and name ) then
			self:Hide();
			return;
		end
		for i = 1, needButtons, 1 do
			if not ( self:GetAttribute("child"..i) ) then
				local newButton = CreateFrame(templateType, name.."UnitButton"..i, self, buttonTemplate);
				SetupUnitButtonConfiguration(self, newButton);
				self:SetAttribute("child"..i, newButton);
			end
		end
	end
	
	local loopStart, loopFinish, step = 1, unitCount, 1;
	if ( sortDir == "DESC" ) then
		loopStart, loopFinish, step = unitCount, 1, -1;
	end
	
	local buttonNum = 0;
	local currentAnchor = self;
	local unitButton
	for i = loopStart, loopFinish, step do
		buttonNum = buttonNum + 1;
		
		unitButton = self:GetAttribute("child"..buttonNum);
		unitButton:Hide();
		unitButton:ClearAllPoints();
		if ( buttonNum == 1 ) then
			unitButton:SetPoint(point, currentAnchor, point, 0, 0);
		else
			unitButton:SetPoint(point, currentAnchor, relativePoint, xMultiplier * xOffset, yMultiplier * yOffset);
		end
		unitButton:SetAttribute("unit", sortingTable[sortingTable[i]]);
		unitButton:Show();
		
		currentAnchor = unitButton;
	end
	repeat
		buttonNum = buttonNum + 1;
		unitButton = self:GetAttribute("child"..buttonNum);
		if ( unitButton ) then
			unitButton:Hide();
			unitButton:SetAttribute("unit", nil);
		end
	until not ( unitButton )
	
	local unitButton = self:GetAttribute("child1");
	local unitButtonWidth = unitButton:GetWidth();
	local unitButtonHeight = unitButton:GetHeight();
	if ( unitCount > 0 ) then
		self:SetWidth( xMultiplier * (unitCount - 1) * unitButtonWidth + ( (unitCount - 1) * (xOffset * xOffsetMult) ) + unitButtonWidth );
		self:SetHeight( yMultiplier * (unitCount - 1) * unitButtonHeight + ( (unitCount - 1) * (yOffset * yOffsetMult) ) + unitButtonHeight );
	else
		local minWidth = self:GetAttribute("minWidth") or (yMultiplier * unitButtonWidth);
		local minHeight = self:GetAttribute("minHeight") or (xMultiplier * unitButtonHeight);
		self:SetWidth( max(minWidth, 0.1) );
		self:SetHeight( max(minHeight, 0.1) );
	end
end

function InsecurePartyHeader_Update(self)
	for key in pairs(sortingTable) do
		sortingTable[key] = nil
	end
	table.setn(sortingTable, 0)

	for i = 1, GetNumPartyMembers(), 1 do
		local unit = "party"..i;
		local name = UnitName(unit);
		tinsert(sortingTable, name);
		sortingTable[name] = unit;
	end

	configureChildren(self);
end

function InsecureRaidGroupHeader_Update(self)
	local nameList = self:GetAttribute("nameList");
	local groupFilter = self:GetAttribute("groupFilter");
	
	if not ( groupFilter or nameList ) then
		self:Hide();
		return;
	end
	
	for key in pairs(sortingTable) do
		sortingTable[key] = nil
	end
	table.setn(sortingTable, 0)
	
	if ( groupFilter ) then
		-- filtering by a list of group numbers and/or classes
		fillTable(tokenTable, strsplit(",", groupFilter));
		local strictFiltering = self:GetAttribute("strictFiltering"); -- non-strict by default
		for i = 1, GetNumRaidMembers(), 1 do
			local name, _, subgroup, _, _, className = GetRaidRosterInfo(i);
			if ( ((not strictFiltering) and 
			      (tokenTable[subgroup] or tokenTable[className]) -- non-strict filtering
			     ) or 
			      (tokenTable[subgroup] and tokenTable[className]) -- strict filtering
			) then
				tinsert(sortingTable, name);
				sortingTable[name] = "raid"..i;
			end
		end
	
	elseif ( nameList ) then
		-- filtering via a list of names
		doubleFillTable(sortingTable, strsplit(",", nameList));
		for i = 1, GetNumRaidMembers(), 1 do
			local name = GetRaidRosterInfo(i);
			if ( sortingTable[name] ) then
				sortingTable[name] = "raid"..i;
			end
		end
		for i = table.getn(sortingTable), 1, -1 do
			local name = sortingTable[i];
			if ( sortingTable[name] == true ) then
				tremove(sortingTable, i);
			end
		end
	
	else
		self:Hide();
		return;
	end

	configureChildren(self);
end

end

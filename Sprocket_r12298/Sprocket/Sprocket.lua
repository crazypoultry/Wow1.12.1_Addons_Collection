BINDING_HEADER_SPROCKET = "Sprocket";
BINDING_NAME_SPROCKET_KEYMENU1 = "Key Menu 1";
BINDING_NAME_SPROCKET_KEYMENU2 = "Key Menu 2";
BINDING_NAME_SPROCKET_KEYMENU3 = "Key Menu 3";
BINDING_NAME_SPROCKET_KEYMENU4 = "Key Menu 4";
BINDING_NAME_SPROCKET_KEYMENU5 = "Key Menu 5";
BINDING_NAME_SPROCKET_KEYMENU6 = "Key Menu 6";
BINDING_NAME_SPROCKET_KEYMENU7 = "Key Menu 7";
BINDING_NAME_SPROCKET_KEYMENU8 = "Key Menu 8";

SPROCKET_MODULE_ITEM = "SprocketItemModule"
SPROCKET_MODULE_MENU = "SprocketMenuModule"
SPROCKET_MODULE_TRIGGER = "SprocketTriggerModule"


BUTTON_FOR_INDEX = {
	[1] = "LeftButton",
	[2] = "RightButton",
	[3] = "MiddleButton",
	[4] = "Button4",
	[5] = "Button5",
}

INDEX_FOR_BUTTON = {
	["LeftButton"] = 1,
	["RightButton"] = 2,
	["MiddleButton"] = 3,
	["Button4"] = 4,
	["Button5"] = 5,
}

MAX_ITEMDEFS = 8;
MAX_MENULEVELS = 6;

local L = AceLibrary("AceLocale-2.0"):new("Sprocket")
local BS = AceLibrary("Babble-Spell-2.0")
local DewDrop = AceLibrary("Dewdrop-2.0")

-- Create the Addon object
Sprocket = AceLibrary("AceAddon-2.0"):new(
	"AceDB-2.0", 
	"AceConsole-2.0",
	"AceDebug-2.0",
	"AceModuleCore-2.0"
)

-- Get references to various required libraries
local Vector2D = AceLibrary("Vector2D-2.0")
local SprocketMenu = AceLibrary("SprocketMenu-2.0")
local SprocketKeyTrigger = AceLibrary("SprocketKeyTrigger-2.0")
local SprocketMouseTrigger = AceLibrary("SprocketMouseTrigger-2.0")
local SprocketMenuAction = AceLibrary( "SprocketMenuAction-2.0" )

-- Register the default config with AceDB
Sprocket:RegisterDB( "SprocketGlobalConfig", "SprocketCharConfig" )
Sprocket:RegisterDefaults( 'char', {
	dbVersion = 0.5,
	buttonPos = 318,
	showMiniButton = true,
	showEffects = true,
	showCenterButton = true,
	showItemRing = true,
	showBigButton = false,
	bigButtonIconTexture = "Interface\\Icons\\INV_Misc_Gear_01",
	bigButtonBorderTexture = "Interface\\AddOns\\Sprocket\\UI\\UI-Sprocket-Border",
	itemBorderTexture = "Interface\\AddOns\\Sprocket\\UI\\UI-Sprocket-Border",
	centerButtonBorderTexture = "Interface\\AddOns\\Sprocket\\UI\\UI-Sprocket-Border",
	showOverlays = false,
	menuScale = 1.0,
	hoverDelay = 0.1,
	Menus = {},
	Hotkeys = {},
	Buttons = {},
})

Sprocket:RegisterDefaults( 'account', {
	dbVersion = 0.5,
	Menus = {},
})

-- 
-- Setup various runtime defaults
--
function Sprocket:OnInitialize()

	-- Set the current states
	self.markingType = nil;
	self.usingOverlay = false;
	self.enabled = false;
	self.menuLevel = 0;
	self.reqAlt = false;
	self.reqControl = false;
	self.reqShift = false;

	-- The execution queue
	self.Queue = {};
	
	self.buttonFrames = {};
	self.firstUse = nil
	
	-- Variables used for the marking line
	self.StartPos = Vector2D:new( 0, 0 )
	self.EndPos = Vector2D:new( 0, 0 )
	self.HoverTime = 0

	if ( table.getn( self.db.char.Menus ) == 0 ) then
		self.firstUse = true
		self:SetDefaultConfig();
	end

	self:MinimapButton_Update()
	self:BigButton_Update()
	
	self:SetModuleMixins( "SprocketModuleMix-2.0" )
	
	self:VerifyMenus()
end


function Sprocket.modulePrototype:RegisterItemModule()
	Sprocket:ModuleRegistered( self, SPROCKET_MODULE_ITEM )
end

function Sprocket.modulePrototype:UnregisterItemModule()
	Sprocket:ModuleUnregistered( self, SPROCKET_MODULE_ITEM )
end

function Sprocket.modulePrototype:IsItemModule()
	return (self.itemModule or false)
end


function Sprocket:ModuleRegistered( module, moduleType )
	if ( moduleType == SPROCKET_MODULE_ITEM ) then
		module.itemModule = true
		itemClass = module:GetItemClass()
		assert( module and itemClass )
		
		for menu in self:MenuIter() do
			for itemID = 1, MAX_ITEMDEFS do
				item = menu:GetItem( itemID )
				if ( item:GetType() == "module" and item.moduleName == module.name ) then
					item:OnEnable()
				end
			end			
		end
	end
end

function Sprocket:ModuleUnregistered( module, moduleType )	
	if ( moduleType == SPROCKET_MODULE_ITEM ) then
		itemClass = module:GetItemClass()
		assert( module and itemClass )
		
		for menu in self:MenuIter() do
			for itemID = 1, MAX_ITEMDEFS do
				item = menu:GetItem( itemID )
				if ( item:GetType() == "module" and item.moduleName == module.name ) then
					item:OnDisable()
				end
			end
		end
	end
end

function Sprocket:OnEnable()
	self:UpdateButtonFrames()
	self:HideOverlays()
	self.enabled = true
end

function Sprocket:OnDisable()
	self.enabled = false
	for name, frame in pairs( self.buttonFrames ) do
		frame:Hide()
	end
end

function Sprocket:UpdateButtonFrames()
	-- Mark all of the overlay frames as dirty
	for name, frame in pairs( self.buttonFrames ) do
		frame.isDirty = true
	end

	-- Update the frames based on which buttons are using them
	for buttonID = 1, self:GetNumButtons() do
		button = self:GetButtonByID( buttonID )
		for frameID = 1, button:GetNumFrames() do
			frame = button:GetFrameByID( frameID )
			if ( not self.buttonFrames[frame:GetName()] ) then
				self:AddButtonFrame( frame:GetName() )
			end
			
			if ( self.buttonFrames[frame:GetName()] ) then
				self.buttonFrames[frame:GetName()].isDirty = false
				self.buttonFrames[frame:GetName()]:Show()
			end
		end
	end

	-- Since we can't destroy unused frames, hide them instead
	for name, frame in pairs( self.buttonFrames ) do
		if ( frame.isDirty ) then
			frame:Hide()
		end
	end
end

-- Setup the default configuration
function Sprocket:SetDefaultConfig()
	self.db.char.Menus = {}
	self.db.char.Hotkeys = {}
	self.db.char.Buttons = {}

	local menu, menuIndex = self:AddMenu( "Action Bar 1" )
	for index = 1, MAX_ITEMDEFS do
		local item = menu:SetItem( {["type"] = "action"}, index )
		item.barID = 1
		item.slotID = index
	end
	
	for index = 1, MAX_ITEMDEFS do
		self.db.char.Hotkeys[index] = SprocketKeyTrigger:new( "Binding "..index )
		self.db.char.Hotkeys[index]:GetFrameByID( 1 ).menuName = "Action Bar 1"
	end

	local menu, menuIndex = self:AddMenu( "Player Frame" )
	for index = 1, MAX_ITEMDEFS do
		local item = menu:SetItem( {["type"] = "action"}, 1 )
		item.barID = 1
		item.slotID = 1
		local item = menu:SetItem( {["type"] = "action"}, 8 )
		item.barID = 1
		item.slotID = 2
		local item = menu:SetItem( {["type"] = "action"}, 7 )
		item.barID = 1
		item.slotID = 3
	end

	for index = 1, 5 do
		self.db.char.Buttons[index] = SprocketMouseTrigger:new( BUTTON_FOR_INDEX[index] )
	end

	local menu, menuIndex = self:AddMenu( "Micro Buttons" )
	menu:SetItemOffset( 60 )
	menu:SetDeadzone( 55 )

	menu:SetItem( {
					["type"] = "script",
					["titleText"] = "Open Bags",
					["bodyText"] = "/script OpenAllBags()",
					["iconTexture"] = "Interface\\Icons\\INV_Misc_Bag_09",
				},
				1 )

	menu:SetItem( {
					["type"] = "script",
					["titleText"] = "Character",
					["bodyText"] = "/script ToggleCharacter(\"PaperDollFrame\")",
					["iconTexture"] = "Interface\\CharacterFrame\\TemporaryPortrait",
				},
				2 )

	menu:SetItem( {
					["type"] = "script",
					["titleText"] = "Spellbook",
					["bodyText"] = "/script ToggleSpellBook(BOOKTYPE_SPELL)",
					["iconTexture"] = "Interface\\Icons\\INV_Misc_Book_09",
				},
				3 )

	menu:SetItem( {
					["type"] = "script",
					["titleText"] = "Quest Log",
					["bodyText"] = "/script ToggleQuestLog()",
					["iconTexture"] = "Interface\\Icons\\INV_Letter_06",
				},
				4 )

	menu:SetItem( {
					["type"] = "script",
					["titleText"] = "Sprocket Config",
					["bodyText"] = "/sprocket config",
					["iconTexture"] = "Interface\\Icons\\INV_Misc_Gear_01",
				},
				5 )

	menu:SetItem( {
					["type"] = "script",
					["titleText"] = "World Map",
					["bodyText"] = "/script ToggleWorldMap()",
					["iconTexture"] = "Interface\\Icons\\INV_Misc_Map_01",
				},
				6 )

	menu:SetItem( {
					["type"] = "script",
					["titleText"] = "Talents",
					["bodyText"] = "/script ToggleTalentFrame()",
					["iconTexture"] = "Interface\\Icons\\Ability_Marksmanship",
				},
				7 )

	menu:SetItem( {
					["type"] = "script",
					["titleText"] = "Social",
					["bodyText"] = "/script ToggleFriendsFrame()",
					["iconTexture"] = "Interface\\ChatFrame\\UI-ChatIcon-Chat-Up",
				},
				8 )


	local trigger = self:GetButtonByName( "LeftButton" )
	trigger:AddFrame( SprocketMenuAction:new( "SprocketMinimapButton" ) )
	frame = trigger:GetFrameByName( "SprocketMinimapButton" )
	frame:SetMenuName( "Micro Buttons" )

end


-- Return the current marking type or nil if not marking
function Sprocket:IsMarking()
	if ( self.markingType ~= nil ) then
		return true;
	else
		return false;
	end
end

function Sprocket:IsEnabled()
	return self.enabled
end

function Sprocket:CanDoMarking()
	if ( not self:IsEnabled() ) then
		return false
	else
		return ( not self:IsMarking() )
	end
end

-- Set the current marking type
function Sprocket:SetMarking( type )
	if ( not type ) then
		assert( self.markingType, "markingType == nil" )
		self.markingType = nil;
	else
		assert( type == "key" or type == "mouse", "invalid marking type: "..type )
		assert( self.markingType == nil, "markingType != nil" )
		self.markingType = type
	end
end

Sprocket:RegisterChatCommand({ "/sprocket", "/sm" }, {
    type = 'group',
    args = {
        config = {
            name = "configuration",
            desc = "Enter configuration mode.",
            type = 'execute',
            func = "Configure", -- calls the :DoSomething() function.
        }
    }
})

-- Clear all active settings
function Sprocket:ClearActive()
	if ( self.activeMenu ) then
		for index = 1, MAX_ITEMDEFS do
		end
	end
	self.activeMenu = nil
	self.activeTrigger = nil
	self.activeAction = nil
end

-- Set the specified menu index as active
function Sprocket:SetActiveMenu( menu )
	assert( menu:GetType() == "menu", "SetActiveMenu called with invalid type "..menu:GetType() )
	assert( self.activeTrigger, "SetActiveMenu called without activeTrigger" )
	assert( self.activeAction, "SetActiveMenu called without activeAction" )
	self.activeMenu = menu
	self:UpdateItemButtons()
	self.activeMenu:UpdateSlots()
end

-- Set the specified trigger index as active
function Sprocket:SetActiveTrigger( trigger )
	assert( trigger:GetType() == "hotkey" or trigger:GetType() == "mouse", "SetActiveTrigger called with invalid type "..trigger:GetType() )
	self.activeTrigger = trigger
end

-- Set the specified menu action as active
function Sprocket:SetActiveAction( action )
	assert( self.activeTrigger, "SetActiveAction called without activeTrigger" )
	assert( action:GetType() == "menuaction", "SetActiveAction called with invalid type "..action:GetType() )
	self.activeAction = action;
end

-- Return a reference to the current active menu
function Sprocket:GetActiveMenu()
	return self.activeMenu
end

-- Return a reference to the current active trigger
function Sprocket:GetActiveTrigger()
	return self.activeTrigger
end

-- Return a reference to the current active trigger
function Sprocket:GetActiveAction()
	return self.activeAction
end

-- Return a reference to a menu by index
function Sprocket:GetMenuByID( index )
	assert( self.db.char.Menus[index], "invalid Menus index "..index );
	return self.db.char.Menus[index];	
end

function Sprocket:MenuIter()
	local menuID = 1
	local numMenus = self:GetNumMenus()
	local g_menuID = 1
	local g_numMenus = self:GetNumGlobalMenus()
	return function()
				--menuID = menuID + 1
				if ( menuID <= numMenus ) then
					menuID = menuID + 1
					return Sprocket:GetMenuByID( menuID - 1 )
				elseif ( g_menuID <= g_numMenus ) then
					g_menuID = g_menuID + 1
					return Sprocket:GetGlobalMenuByID( g_menuID - 1)
				end
			end
end

function Sprocket:GetGlobalMenuByID( index )
	assert( self.db.account.Menus[index], "invalid Global Menus index "..index );
	return self.db.account.Menus[index];	
end

-- Return a reference to a trigger by index
function Sprocket:GetHotkeyByID( index )
	assert( self.db.char.Hotkeys[index], "invalid Hotkeys index "..index );
	return self.db.char.Hotkeys[index];	
end

-- Return a reference to a menu by index
function Sprocket:GetButtonByID( index )
	assert( self.db.char.Buttons[index], "invalid Buttons index "..index );
	return self.db.char.Buttons[index];
end

function Sprocket:GetNumMenus()
	return table.getn( self.db.char.Menus );
end

function Sprocket:GetNumGlobalMenus()
	return table.getn( self.db.account.Menus );
end

function Sprocket:GetNumHotkeys()
	return table.getn( self.db.char.Hotkeys );
end

function Sprocket:GetNumButtons()
	return table.getn( self.db.char.Buttons );
end

-- Get a menu from either the char or global list (char takes precedence)
function Sprocket:MenuForName( name )
	for index, menu in ipairs( self.db.char.Menus ) do
		if ( self.db.char.Menus[index]:GetMenuName() == name ) then
			return self.db.char.Menus[index];
		end
	end

	for index, menu in ipairs( self.db.account.Menus ) do
		if ( self.db.account.Menus[index]:GetMenuName() == name ) then
			return self.db.account.Menus[index];
		end
	end
	
	return nil;
end

-- Return a reference to the menu of the specified name
function Sprocket:GetMenuByName( name )
	for index, menu in ipairs( self.db.char.Menus ) do
		if ( self.db.char.Menus[index]:GetMenuName() == name ) then
			return self.db.char.Menus[index], index;
		end
	end
	
	return nil, nil;
end

-- Return a reference to the menu of the specified name
function Sprocket:GetGlobalMenuByName( name )
	for index, menu in ipairs( self.db.account.Menus ) do
		if ( self.db.account.Menus[index]:GetMenuName() == name ) then
			return self.db.account.Menus[index], index;
		end
	end
	
	return nil, nil;
end

-- Return a reference to the trigger of the specified name
function Sprocket:GetHotkeyByName( name )
	for index, menu in ipairs( self.db.char.Hotkeys ) do
		if ( self.db.char.Hotkeys[index]:GetTriggerName() == name ) then
			return self.db.char.Hotkeys[index], index;
		end
	end
	
	return nil, nil;
end

-- Return a reference to the trigger of the specified name
function Sprocket:GetButtonByName( name )
	for index, menu in ipairs( self.db.char.Buttons ) do
		if ( self.db.char.Buttons[index]:GetTriggerName() == name ) then
			return self.db.char.Buttons[index], index;
		end
	end
	
	return nil, nil;
end


-- Add a new menu of the specified name
function Sprocket:AddMenu( name )
	-- Make sure the menu doesn't already exist
	if ( self:GetMenuByName( name ) ~= nil ) then
		return nil;
	end
	
	local newMenu = SprocketMenu:new( name );
	table.insert( self.db.char.Menus, newMenu );
	
	local index = table.getn( self.db.char.Menus )
	return self.db.char.Menus[index], index;
end

-- Delete the menu of the specified name
function Sprocket:DeleteMenu( name )
	-- Make sure there's at least one menu
	if ( table.getn( self.db.char.Menus ) == 1 ) then
		return; -- error, must have at least one menu
	end
	
	local _,index = self:GetMenuByName( name );
	assert( index );

	table.remove( self.db.char.Menus, index );

	self:VerifyMenus()
end

-- Add a new menu of the specified name
function Sprocket:AddGlobalMenu( name )
	-- Make sure the menu doesn't already exist
	if ( self:GetGlobalMenuByName( name ) ~= nil ) then
		return nil;
	end
	
	local newMenu = SprocketMenu:new( name );
	table.insert( self.db.account.Menus, newMenu );
	
	local index = table.getn( self.db.account.Menus )
	return self.db.account.Menus[index], index;
end

function Sprocket:DeleteGlobalMenu( name )
	local _,index = self:GetGlobalMenuByName( name );
	assert( index );

	table.remove( self.db.account.Menus, index );
	
	self:VerifyMenus()
end


function Sprocket:VerifyMenus()
	local menu;
	local item;
	-- Remove any usage of this menu as a sub-menu
	for menu in self:MenuIter() do
		for itemIndex = 1, MAX_ITEMDEFS do
			item = menu:GetItem( itemIndex );
			if ( item.subMenu and item.subMenu ~= "" ) then
				if ( not self:MenuForName( item.subMenu ) ) then
					item.subMenu = ""
				end
			end
		end		
	end

	local triggger;
	local action;
	-- Remove any usage of this menu as a trigger menu
	for triggerID = 1, self:GetNumHotkeys() do
		trigger = self:GetHotkeyByID( triggerID )
		for frameID = 1, trigger:GetNumFrames() do
			frame = trigger:GetFrameByID( frameID )
			if ( frame:GetMenuName() ~= "" and not self:MenuForName( frame:GetMenuName() ) ) then
				frame:SetMenuName( "" )
			end
		end
	end
	for triggerID = 1, self:GetNumButtons() do
		trigger = self:GetButtonByID( triggerID )
		for frameID = 1, trigger:GetNumFrames() do
			frame = trigger:GetFrameByID( frameID )
			if ( frame:GetMenuName() ~= "" and not self:MenuForName( frame:GetMenuName() ) ) then
				frame:SetMenuName( "" )
			end
		end
	end
end

-- Update the item buttons before rendering
function Sprocket:UpdateItemButtons()
	local activeMenu = self:GetActiveMenu();
	local button;
	local item;
	
	SprocketCenterButtonIconTexture:SetTexture( activeMenu:GetIconTexture() )
	SprocketCenterButtonOverlay:SetTexture( self:GetCenterButtonBorder() )
	
	for id=1, MAX_ITEMDEFS do
		button = getglobal( "SprocketItemButton"..id );
		item = activeMenu:GetItem( id );
		
		-- Only update enabled buttons, disabled buttons will not be :Show()'n
		if ( item:IsEnabled() ) then
			getglobal( button:GetName().."IconTexture" ):SetTexture( item:GetIconTexture() );
			getglobal( button:GetName().."IconTexture" ):SetTexCoord( item:GetIconCoord() );
			getglobal( button:GetName().."IconTexture" ):SetVertexColor( 1, 1, 1 );
			getglobal( button:GetName().."OverlayTexture" ):SetTexture( self:GetItemBorderTexture() );		
			
			getglobal( button:GetName().."Name" ):SetText( item:GetTitle() );
			getglobal( button:GetName().."NamePlate" ):SetWidth( getglobal( button:GetName().."Name" ):GetStringWidth() - 6 );
			getglobal( button:GetName().."Highlight" ):UnlockHighlight();
			if ( activeMenu.showNames ) then
				getglobal( button:GetName().."Name" ):SetTextColor( 1.0, 0.82, 0.0 );
				getglobal( button:GetName().."Name" ):Show();
				getglobal( button:GetName().."NamePlate" ):Show();
				getglobal( button:GetName().."NamePlateLeft" ):Show();
				getglobal( button:GetName().."NamePlateRight" ):Show();
			else
				getglobal( button:GetName().."Name" ):Hide();
				getglobal( button:GetName().."NamePlate" ):Hide();
				getglobal( button:GetName().."NamePlateLeft" ):Hide();
				getglobal( button:GetName().."NamePlateRight" ):Hide();
			end

			-- Actions Buttons and Use Item's can display counts
			if ( item.type == "action" ) then
				getglobal( button:GetName().."Text" ):SetText( item:GetCount() );
			elseif ( item.type == "item" and item.showCount ) then
				getglobal( button:GetName().."Text" ):SetText( item:GetCount() );
			else
				getglobal( button:GetName().."Text" ):SetText( "" );		
			end
			
			if ( item.OnActivate ) then
				item:OnActivate( button );
			end
		end
	end
end

-- Open and close the configuration pane
function Sprocket:Configure()
	if ( Sprocket:IsInConfig() ) then
		HideUIPanel( SprocketConfigFrame );
	else
		ShowUIPanel( SprocketConfigFrame );
	end
end

function Sprocket:IsInConfig()
	return SprocketConfigFrame:IsShown()
end

-- Attempt marking with the specified hotkey
function Sprocket:BeginKeyMarking( keyID, reqAlt, reqControl, reqShift )
	if ( not self:CanDoMarking() ) then
		return;
	end
	
	local hoverFrame = GetMouseFocus();
	
	if ( not hoverFrame ) then
		return
	end
	
	local hoverFrameName = "";
	local menuName = "";
	local trigger = self:GetHotkeyByID( keyID );

	self:SetActiveTrigger( trigger );

	-- See if the frame we're over has a menu/trigger association
	while ( 1 ) do
		for index = 1, trigger:GetNumFrames() do
			frame = trigger:GetFrameByID( index );
			if ( frame:GetName() == hoverFrame:GetName() ) then
				menuName = frame:GetMenuName();
				self:SetActiveAction( frame );
				break;
			end
		end
		
		if ( hoverFrame:GetParent() ) then
			hoverFrame = hoverFrame:GetParent();
		else
			break;
		end
	end

	if ( menuName == "" ) then
		if ( self:GetActiveAction() ) then
			binding1, binding2 = GetBindingKey( "SPROCKET_KEYMENU"..keyID )
			Sprocket:Print( "Hotkey "..(binding1 or binding2).." has no menu assigned." )  
			Sprocket:Print( "You can assign a menu in the 'Triggers' config panel." )
		end
		self:ClearActive()
		return;
	end

	-- Begin marking	
	local menu = self:MenuForName( menuName )
	self:SetActiveMenu( menu );

	self.reqAlt = reqAlt
	self.reqControl = reqControl
	self.reqShift = reqShift
	
	self:OnBeginMarking( "key" );
end

-- Stop key marking (this may execute an action)
function Sprocket:EndKeyMarking( keyID )
	if ( not self:IsMarking() ) then
		return
	end
	
	self:OnEndMarking()
end

-- Display the active menu and begin updating
function Sprocket:OnBeginMarking( type )
	-- Attempt to add the active menu's actions pre-action to the exec queue
	self:AddToExecQueue( self:GetActiveAction():GetPreItem() )

	-- Setup the default state
	local x, y = GetCursorPosition()
	self:ShowMenu( x, y )

	self:SetMarking( type )
end


function Sprocket:ShowMenu( x, y )
	self:UpdateItemPositions( x, y )
	self.StartPos:Set( x, y )
	self.HoverTime = 0

	-- Display any enabled marking buttons
	for index = 1, 8, 1 do
		if ( self:GetActiveMenu():IsItemEnabled( index ) ) then
			if ( self:GetShowEffects() ) then
				FadeInFrame( getglobal( "SprocketItemButton"..index ), 0.1 )
			else
				getglobal( "SprocketItemButton"..index ):Show()
				getglobal( "SprocketItemButton"..index ):SetAlpha( 1 )
			end
		end
	end

	if ( self:GetShowItemRing() ) then
		SprocketItemRingTexture:SetWidth( self:GetActiveMenu():GetItemOffset() * 2 + 35 )
		SprocketItemRingTexture:SetHeight( self:GetActiveMenu():GetItemOffset() * 2 + 35 )
		if ( self:GetShowEffects() ) then
			FadeInFrame( SprocketItemRing, 0.1 )
		else
			SprocketItemRing:Show()
			SprocketItemRing:SetAlpha( 1 )
		end
	else
		SprocketItemRing:Hide()
	end

	if ( self:GetShowCenterButton() ) then
		if ( self:GetShowEffects() ) then
			FadeInFrame( SprocketCenterButton, 0.1 )
		else
			SprocketCenterButton:Show()
			SprocketCenterButton:SetAlpha( 1 )
		end
	else
		SprocketCenterButton:Hide()
	end
	
	self.menuLevel = self.menuLevel + 1
end


-- Stop displaying the active menu and execute any actions if applicable
function Sprocket:OnEndMarking( wasCancelled )
	-- Hide the marking buttons
	local item
	for index = 1, MAX_ITEMDEFS do
		item = self:GetActiveMenu():GetItem( index )
		if ( item.OnDeactivate ) then
			item:OnDeactivate( getglobal( "SprocketItemButton"..index ) );
		end

		if ( getglobal( "SprocketItemButton"..index ):IsShown() ) then
			if ( self:GetShowEffects() ) then
				FadeOutFrame( getglobal( "SprocketItemButton"..index ), 0.15 )
			else
				getglobal( "SprocketItemButton"..index ):Hide()
			end
		end
	end

	if ( self:GetShowEffects() and self:GetShowCenterButton() ) then
		FadeOutFrame( SprocketCenterButton, 0.15 )
		FadeOutFrame( SprocketItemRing, 0.15 )
	else
		SprocketCenterButton:Hide()
		SprocketItemRing:Hide()
	end

	if ( self:GetShowEffects() and self:GetShowItemRing() ) then
		FadeOutFrame( SprocketItemRing, 0.15 )
	else
		SprocketItemRing:Hide()
	end

	-- Hide the marking lines
	for index = 1, MAX_MENULEVELS do
		getglobal( "MarkingLine"..index ):Hide()
		getglobal( "MarkingLine"..index ):SetAlpha( 1 )
		getglobal( "MarkingLine"..index ):SetVertexColor( 1, 1, 1 )
	end
	
	self.menuLevel = 0;

	-- If a marking button is selected add it's action to the queue and execute
	if ( self:GetActiveMenu():GetSelectedItemID() > 0 and not wasCancelled ) then
		self:AddToExecQueue( self:GetActiveMenu():GetSelectedItem() )
		-- Attemp to add the active menu's actions post-action to the exec queue
		self:AddToExecQueue( self:GetActiveAction():GetPostItem() )
		-- Execute the current queue
		self:ExecQueue();
	end
	-- Reset active menu, trigger and action
	self:ClearActive()
	self:SetMarking( nil )
	self.reqShift = false
	self.reqControl = false
	self.reqAlt = false
end

local lineVec = Vector2D:new( 0, 0 )
local length
local lastItemID
local angle
local slotID
local itemID

-- Main update loop, only valid when marking
function Sprocket:OnUpdate( timePassed )
	if ( not self:IsMarking() ) then
		return
	end
	
	if ( self.reqAlt and not IsAltKeyDown() ) then
		self:OnEndMarking( true )
		return
	elseif ( self.reqControl and not IsControlKeyDown() ) then
		self:OnEndMarking( true )
		return
	elseif ( self.reqShift and not IsShiftKeyDown() ) then
		self:OnEndMarking( true )
		return
	end
	
	-- Get the current end position and update marking line information
	self.EndPos:Set( GetCursorPosition() );
	lineVec:Set( self.EndPos.x - self.StartPos.x, self.EndPos.y - self.StartPos.y )
	length = lineVec:GetLength();

	-- Render the marking line
	DrawMarkingLine( getglobal( "MarkingLine"..self.menuLevel ), UIParent, self.StartPos.x, self.StartPos.y, self.EndPos.x, self.EndPos.y, 32);

	-- Save the last selected item
	lastItemID = self:GetActiveMenu():GetSelectedItemID();

	-- Convert the marking line to angle	
	lineVec:Normalize();
	angle = lineVec:GetAngle();
	if ( self:GetShowEffects() ) then
		setCoords( SprocketCenterButtonOverlay, 0.5, 0.5, cos(angle), sin(angle), 0, -sin(angle), cos(angle), 0 )
	end

	-- If we're inside of the menu deadzone deselect any items
	if ( length < (self:GetActiveMenu():GetDeadzone() * self:GetMenuScale()) or length > ( self:GetActiveMenu():GetSelectionRadius() * self:GetMenuScale()) ) then
		if ( lastItemID > 0 ) then
			getglobal( "SprocketItemButton"..lastItemID.."Highlight" ):UnlockHighlight();
			getglobal( "SprocketItemButton"..lastItemID.."Name" ):SetTextColor( 1.0, 0.82, 0.0 );
			if ( not self:GetActiveMenu():GetShowNames() ) then
				getglobal( "SprocketItemButton"..lastItemID.."Name" ):Hide();
				getglobal( "SprocketItemButton"..lastItemID.."NamePlate" ):Hide();
				getglobal( "SprocketItemButton"..lastItemID.."NamePlateLeft" ):Hide();
				getglobal( "SprocketItemButton"..lastItemID.."NamePlateRight" ):Hide();
			end
			self:GetActiveMenu():SetSelectedItemID( 0 );
		end
		return;		
	end
		
	-- Look up the owned button based on current marking line angle
	slotID = math.floor(angle / 22.5);
	itemID = self:GetActiveMenu():GetSlotOwnerID( slotID );

	-- If this currently selected item button has changed since the last update, update the settings
	if ( itemID ~= lastItemID ) then
		-- Reset the hove time to prevent instant submenu popups
		self.HoverTime = 0;

		-- Remove the highlight from the last selected button if necessary
		if ( lastItemID > 0 ) then
			getglobal( "SprocketItemButton"..lastItemID.."Highlight" ):UnlockHighlight();
			getglobal( "SprocketItemButton"..lastItemID.."Name" ):SetTextColor( 1.0, 0.82, 0.0 );
			if ( not self:GetActiveMenu():GetShowNames() ) then
				getglobal( "SprocketItemButton"..lastItemID.."Name" ):Hide();
				getglobal( "SprocketItemButton"..lastItemID.."NamePlate" ):Hide();
				getglobal( "SprocketItemButton"..lastItemID.."NamePlateLeft" ):Hide();
				getglobal( "SprocketItemButton"..lastItemID.."NamePlateRight" ):Hide();
			end
		end
		
		-- If we have a button selected set it as selected and set the highlight
		if ( itemID > 0 ) then
			self:GetActiveMenu():SetSelectedItemID( itemID );
			getglobal( "SprocketItemButton"..itemID.."Highlight" ):LockHighlight();
			getglobal( "SprocketItemButton"..itemID.."Name" ):SetTextColor( 1.0, 1.0, 1.0 );
			if ( not self:GetActiveMenu():GetShowNames() ) then
				getglobal( "SprocketItemButton"..itemID.."Name" ):Show();
				getglobal( "SprocketItemButton"..itemID.."NamePlate" ):Show();
				getglobal( "SprocketItemButton"..itemID.."NamePlateLeft" ):Show();
				getglobal( "SprocketItemButton"..itemID.."NamePlateRight" ):Show();
			end
		end
	elseif ( itemID > 0 and itemID == lastItemID or length > 120 ) then
		-- Increment hover time
		self.HoverTime = self.HoverTime + timePassed;
		
		-- Open the submenu if we've hovered long enough
		if ( self.HoverTime > self:GetHoverDelay() and self.menuLevel < MAX_MENULEVELS ) then
			if ( self:GetActiveMenu():GetSelectedItemID() > 0 ) then
				local item = self:GetActiveMenu():GetSelectedItem();
				local subMenu = item:GetSubMenu();
				-- If this item has a sub-menu, add the items action to the queue and open the submenu
				if ( subMenu ~= "" ) then
					self:AddToExecQueue( item );
					self:OpenSubMenu( subMenu );
				end
			end	
		end		
	end
end

-- Update the item buttons with things like range, cooldown, etc...
function SprocketItemButton_OnUpdate()
	if ( not Sprocket:IsMarking() ) then
		return
	end
	
	if ( Sprocket:GetActiveMenu():GetItem( this:GetID() ).OnUpdate ) then
		Sprocket:GetActiveMenu():GetItem( this:GetID() ):OnUpdate( this );
	end
end

function SprocketItemButton_OnEvent() 
	Sprocket:GetActiveMenu():GetItem( this:GetID() ):OnEvent( this ); 
end

-- Add an item the exec queue if applicable
function Sprocket:AddToExecQueue( item )
	if ( item.ExecItem ) then
		table.insert( self.Queue, item );
	end
end

-- Execute the current action queue
function Sprocket:ExecQueue()
	local consumed = false;
	for index = 1, table.getn( self.Queue ) do
		-- ExecItem returns true if the action is attempted
		if ( self.Queue[index]:ExecItem() ) then
			-- We may have already consumed this button/mouse keypress
			if ( consumed ) then
				--SprocketPrint( "Attemped more than one consume action in queue!" );
			else
				if ( self:GetShowEffects() ) then
					-- Fancy graphic effects
					local menu = self:GetActiveMenu()
					local item, itemIndex = menu:GetSelectedItem();
					ExecAnim:ClearAllPoints();
					ExecAnim:SetPoint( "CENTER", getglobal("SprocketItemButton"..itemIndex), "CENTER" );
					ExecAnim:ReplaceIconTexture( item:GetIconTexture() );
					ExecAnim:SetSequence(0);
					ExecAnim:SetSequenceTime(0, 0);
					ExecAnim:Show();
				
					local x, y = getglobal("SprocketItemButton"..itemIndex):GetCenter()
					local menuScale = self:GetMenuScale()
					
					-- Fancy graphic effects				
					ExecEffect:ClearAllPoints();
					ExecEffect:SetPoint( "CENTER", getglobal("SprocketItemButton"..itemIndex), "CENTER" );
					ExecEffect:SetPosition( 19 * (x / UIParent:GetWidth()) * menuScale, 19 * (y / UIParent:GetHeight()) * menuScale, 0 );
					ExecEffect:SetSequence(0);
					ExecEffect:SetSequenceTime(0, 0);
					ExecEffect:Show();
				end
			end
			consumed = true;
		end
		self.Queue[index] = nil;
	end
	-- Clear the queue for good measure
	self.Queue = {};
end

-- Open the specified sub-menu
-- TODO: roll this and BeginMarking together somehow
function Sprocket:OpenSubMenu( subMenu )
	local item
	for index = 1, MAX_ITEMDEFS do
		item = self:GetActiveMenu():GetItem( index )
		if ( item.OnDeactivate ) then
			item:OnDeactivate( getglobal( "SprocketItemButton"..index ) );
		end
	end

	-- Set the sub-menu as active
	local menuDef = Sprocket:MenuForName( subMenu );
	self:SetActiveMenu( menuDef );

	local alpha
	for lineIndex = self.menuLevel, 1, -1 do
		alpha = getglobal( "MarkingLine"..lineIndex ):GetAlpha()
		getglobal( "MarkingLine"..lineIndex ):SetAlpha( alpha * 0.65 )
		getglobal( "MarkingLine"..lineIndex ):SetVertexColor( 0.25, 0.25, 0.5 )
	end
	
	-- Setup the default state
	local x, y = GetCursorPosition();
	self:ShowMenu( x, y )
end

-- Calculate offsets of radial button display around specified point
function Sprocket:UpdateItemPositions( x, y )
	local itemOffset = self:GetActiveMenu():GetItemOffset()
	local buttonAngle = 0;	
	local menuScale = self:GetMenuScale()
	x = x / menuScale
	y = y / menuScale

	SprocketCenterButton:SetScale( menuScale )
	SprocketCenterButton:SetPoint( "CENTER", "UIParent", "BOTTOMLEFT", x, y )
	SprocketItemRing:SetScale( menuScale )
	SprocketItemRing:SetPoint( "CENTER", "UIParent", "BOTTOMLEFT", x, y )

	for index = 1, MAX_ITEMDEFS, 1 do
		curButton = getglobal( "SprocketItemButton"..index );
		curButton:SetScale( menuScale );
		curButton:Hide();
		curButton:SetPoint( "CENTER", "UIParent", "BOTTOMLEFT", x + (itemOffset * cos(-buttonAngle)), y + (itemOffset * sin(-buttonAngle)) );
		buttonAngle = buttonAngle - (360 / MAX_ITEMDEFS);
	end;
end


-- Create a new overlay and add it to the overlay table
function Sprocket:AddButtonFrame( parentFrameName )
	local parentFrame = getglobal( parentFrameName )
	if ( not parentFrame or not parentFrame.GetName or not parentFrame:GetName() ) then
		return
	end
	local overlay = CreateFrame( "Button", parentFrame:GetName().."SprocketOverlay", parentFrame, "SprocketOverlayTemplate" )
	overlay.parent = parentFrame
	overlay:SetScript( "OnHide", function()
										if ( this.isMarking ) then
											Sprocket:OnEndMarking( true )
											SetRectToParent( this )
										end
									end
						)

	SetRectToParent( overlay );
	self.buttonFrames[parentFrameName] = overlay;
end

function Sprocket:ShowOverlays()
	for name, frame in pairs( self.buttonFrames ) do
		frame:SetAlpha( 1 );
	end
end

function Sprocket:HideOverlays()
	for name, frame in pairs( self.buttonFrames ) do
		frame:SetAlpha( 0 );
	end
end

-- Register mouse activity for this overlay
function Sprocket:Overlay_OnLoad()
	this:RegisterForClicks( "LeftButtonUp", "RightButtonUp", "MiddleButtonUp", "Button4Up", "Button5Up" )
	--this:SetFrameLevel( 1 )
end

-- Overlay version of BeginKeyMarking, attempt mraking with specified overlay
function Sprocket:Overlay_OnMouseDown( arg1 )
	if ( not self:CanDoMarking() ) then
		return;
	end

	local frameName = this.parent:GetName()
	local trigger = self:GetButtonByID( INDEX_FOR_BUTTON[arg1] )
	
	local frameID = trigger:GetFrameIndex( frameName )
	if ( not frameID ) then
		return
	end
	
	local frame = trigger:GetFrameByID( frameID )

	-- Return if the menu isn't assigned
	if ( frame:GetMenuName() == "" ) then		
		return
	end

	local menu = self:MenuForName( frame:GetMenuName() )

	-- Set this overlay's trigger as active
	self:SetActiveTrigger( trigger );
	self:SetActiveAction( frame );
	self:SetActiveMenu( menu );
	
	-- Fill the screen with the overlay button so that we can catch clicks anywhere
	this:ClearAllPoints()
	this:SetPoint( "TOPLEFT", "UIParent" )
	this:SetPoint( "TOPRIGHT", "UIParent" )
	this:SetPoint( "BOTTOMLEFT", "UIParent" )
	this:SetPoint( "BOTTOMRIGHT", "UIParent" )
	this:SetFrameStrata( "HIGH" )
	this:SetFrameLevel( "10" )
	this.isMarking = true
	
	-- Begin marking
	self:OnBeginMarking( "mouse" );
end

-- Stop mouse marking (this may execute an action)
function Sprocket:Overlay_OnMouseUp( arg1 )
	if ( not Sprocket:IsMarking() ) then
		return;
	end

	-- If no marking button is selected, execute onclick so that endmarking is always called
	if ( Sprocket:GetActiveMenu():GetSelectedItemID() == 0 ) then
		Sprocket:Overlay_OnClick( buttonName )
	end
end

-- End of marking (this may execute an action)
function Sprocket:Overlay_OnClick( arg1 )
	if ( not Sprocket:IsMarking() ) then
		if ( this.parent:HasScript( "OnClick" ) and this.parent:GetScript( "OnClick" ) ) then
			local tempThis = this
			this = tempThis.parent
			tempThis.parent:GetScript( "OnClick" )()
			this = tempThis
		end		
		return;
	end

	-- Reset the active overlay to parent size
	SetRectToParent( this );
	
	-- Call end marking for further action
	Sprocket:OnEndMarking();
end

function Sprocket:Overlay_OnEnter()
	if ( self:GetShowOverlays() ) then
		this:SetAlpha( 0.25 )
	end
	--[[
	if ( this.parent:GetScript( "OnEnter" ) ) then
		local tempThis = this
		this = tempThis.parent
		tempThis.parent:GetScript( "OnEnter" )()
		this = tempThis
	end
	]]
end

function Sprocket:Overlay_OnLeave()
	if ( not SprocketConfigFrame:IsShown() ) then
		this:SetAlpha( 0 )
	end
	--[[
	if ( this.parent:GetScript( "OnLeave" ) ) then
		local tempThis = this
		this = tempThis.parent
		tempThis.parent:GetScript( "OnLeave" )()
		this = tempThis
	end
	]]
end

function Sprocket:EnterConfig()
	self:ShowOverlays()
end

function Sprocket:ExitConfig()
	self:HideOverlays()
end

function Sprocket:MinimapButton_OnClick( arg1 )
	if ( arg1 == "LeftButton" ) then
	elseif ( arg1 == "RightButton" ) then
		self:Configure()
	end
end

function Sprocket:MinimapDewDrop( level, value )
	DewDrop:AddLine( 	
		'text', "Sprocket",
		'isTitle', true
	)
	DewDrop:AddLine(
		'text', "Button Position",
		'hasArrow', true,
		'hasSlider', true,
		'sliderMin', 0,
		'sliderMax', 360,
		'sliderValue', Sprocket.db.char.buttonPos,
		'sliderFunc', function( value )
			Sprocket.db.char.buttonPos = value
			Sprocket:MinimapButton_Update()
		end		
	)
end

function Sprocket:SetHoverDelay( value )
	self.db.char.hoverDelay = value
end

function Sprocket:GetHoverDelay()
	return self.db.char.hoverDelay
end

function Sprocket:SetShowMiniButton( state )
	self.db.char.showMiniButton = (state or false)
	self:MinimapButton_Update()
end

function Sprocket:GetShowMiniButton()
	return self.db.char.showMiniButton
end

function Sprocket:SetShowBigButton( state )
	self.db.char.showBigButton = (state or false)
	self:BigButton_Update()
end

function Sprocket:GetShowBigButton()
	return self.db.char.showBigButton
end

function Sprocket:GetBigButtonBorder()
	return self.db.char.bigButtonBorderTexture
end

function Sprocket:SetBigButtonBorder( borderTexture )
	self.db.char.bigButtonBorderTexture = borderTexture
	self:BigButton_Update()
end

function Sprocket:GetItemBorderTexture()
	return self.db.char.itemBorderTexture
end

function Sprocket:SetItemBorderTexture( borderTexture )
	self.db.char.itemBorderTexture = borderTexture
end

function Sprocket:SetShowCenterButton( state )
	self.db.char.showCenterButton = (state or false)
end

function Sprocket:GetShowCenterButton()
	return self.db.char.showCenterButton
end

function Sprocket:GetCenterButtonBorder()
	return self.db.char.centerButtonBorderTexture
end

function Sprocket:SetCenterButtonBorder( borderTexture )
	self.db.char.centerButtonBorderTexture = borderTexture
end

function Sprocket:SetShowOverlays( state )
	self.db.char.showOverlays = (state or false)
end

function Sprocket:GetShowOverlays()
	return self.db.char.showOverlays
end

function Sprocket:SetShowItemRing( state )
	self.db.char.showItemRing = (state or false)
end

function Sprocket:GetShowItemRing()
	return self.db.char.showItemRing
end

function Sprocket:SetShowEffects( state )
	self.db.char.showEffects = (state or false)
end

function Sprocket:GetShowEffects()
	return self.db.char.showEffects
end

function Sprocket:SetMenuScale( value )
	self.db.char.menuScale = value
end

function Sprocket:GetMenuScale()
	return self.db.char.menuScale
end

function Sprocket:MinimapButton_GetPos()
	return self.db.char.buttonPos
end

function Sprocket:MinimapButton_UpdatePos( value )
	self.db.char.buttonPos = value
	self:MinimapButton_Update()
end

function Sprocket:MinimapButton_Update()
	if ( self.db.char.showMiniButton ) then
		SprocketMinimapButton:Show()
		SprocketMinimapButton:SetPoint( "TOPLEFT", "Minimap", "TOPLEFT", 54 - (80 * cos(self.db.char.buttonPos)), (80 * sin(self.db.char.buttonPos)) - 58);
	else
		SprocketMinimapButton:Hide()
	end
end

function Sprocket:SetBigButtonIconTexture( iconTexture )
	self.db.char.bigButtonIconTexture = iconTexture
	self:BigButton_Update()
end

function Sprocket:GetBigButtonIconTexture()
	return self.db.char.bigButtonIconTexture
end

function Sprocket:BigButton_Update()
	if ( self.db.char.showBigButton ) then
		SprocketBigButton:Show()
		SprocketBigButtonIconTexture:SetTexture( self.db.char.bigButtonIconTexture )
		SprocketBigButtonOverlayTexture:SetTexture( self.db.char.bigButtonBorderTexture )
	else
		SprocketBigButton:Hide()
	end
end


function Sprocket:MinimapButton_SetTooltip()
	GameTooltip_SetDefaultAnchor(GameTooltip, this);
	GameTooltip:ClearLines()
	GameTooltip:AddLine( "Sprocket" )
	GameTooltip:AddLine( "Right click to open configuration panel.", 1, 1, 1, 1 )

	local trigger = self:GetButtonByID( INDEX_FOR_BUTTON["LeftButton"] )
	local menuName = ""
	for frameID = 1, trigger:GetNumFrames() do
		frame = trigger:GetFrameByID( frameID )
		if ( frame:GetName() == "SprocketMinimapButton" ) then
			menuName = frame:GetMenuName()
		end
	end

	if ( menuName ~= "" ) then
		GameTooltip:AddLine( "Left click and hold to display '"..menuName.."' menu.", 0, 1, 0, 1 )
	end
	
	GameTooltip:Show()
end

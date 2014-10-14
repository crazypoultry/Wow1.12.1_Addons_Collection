local AceOO = AceLibrary("AceOO-2.0")


local SubMenu = AceOO.Mixin { "GetSubMenu", "SetSubMenu" }
function SubMenu:GetSubMenu()
	return (self.subMenu or "")
end
function SubMenu:SetSubMenu( name )
	self.subMenu = name
end

local ShowInfo = AceOO.Mixin { "GetShowInfo", "SetShowInfo" }
function ShowInfo:GetShowInfo()
	return (self.showInfo or false)
end
function ShowInfo:SetShowInfo( state )
	self.showInfo = state
end

local SprocketModuleMix = AceOO.Mixin { "GetModuleTitle", "GetModuleTooltipText" }
function SprocketModuleMix:GetModuleTitle()
	return self.title
end
function SprocketModuleMix:GetModuleTooltipText( name )
	return (self.tooltipText or "")
end

AceLibrary:Register( SprocketModuleMix, "SprocketModuleMix-2.0", 1 )
SprocketModuleMix = nil

-----------------------------------------
-- BlankItem (ItemDef Inherited Class)
-- 
-- Class for an dataless marking menu item
-----------------------------------------
local SprocketBlankItem = AceOO.Class( AceLibrary("ItemDef-2.0") );

function SprocketBlankItem.prototype:init()
	AceLibrary("SprocketBlankItem-2.0").super.prototype.init(self, "none", "Interface\\Icons\\INV_Misc_Map_01") -- very important. Will fail without this.
end

function SprocketBlankItem:Deserialize()
	return self:new()
end

function SprocketBlankItem.prototype:Serialize()
	return
end

function SprocketBlankItem.prototype:IsEnabled()
	return false
end

function SprocketBlankItem.prototype:SetTooltip()
	GameTooltip:ClearLines()
	GameTooltip:AddLine( "<None>" )
end

AceLibrary:Register( SprocketBlankItem, "SprocketBlankItem-2.0", 1 )
SprocketBlankItem = nil


-----------------------------------------
-- SprocketSubMenuItem (ItemDef Inherited Class)
-- 
-- Class for an submenu item
-----------------------------------------
local SprocketSubMenuItem = AceOO.Class( AceLibrary("ItemDef-2.0"), SubMenu );

function SprocketSubMenuItem.prototype:init( object )
	AceLibrary("SprocketSubMenuItem-2.0").super.prototype.init(self, "submenu", (object.iconTexture or "Interface\\Icons\\INV_Misc_Gear_01")) -- very important. Will fail without this.
end

function SprocketSubMenuItem:Deserialize( subMenu, iconTexture )
	local object = self:new({});
	object:SetIconTexture( iconTexture )
	object:SetSubMenu( subMenu )
	return object
end

function SprocketSubMenuItem.prototype:Serialize()
	return self.subMenu, self.iconTexture
end

function SprocketSubMenuItem.prototype:IsEnabled()
	return (self:GetSubMenu() ~= "")
end

function SprocketSubMenuItem.prototype:GetIconTexture()
	if ( self:GetSubMenu() ~= "" ) then
		local menu = Sprocket:MenuForName( self:GetSubMenu() )
		self:SetIconTexture( menu:GetIconTexture() )
		return AceLibrary("SprocketSubMenuItem-2.0").super.prototype.GetIconTexture( self )
	else
		return "Interface\\Icons\\INV_Misc_Gear_01"
	end
end

function SprocketSubMenuItem.prototype:GetTitle()
	return self:GetSubMenu();
end

function SprocketSubMenuItem.prototype:OnActivate( itemButton )
	getglobal( itemButton:GetName().."Cooldown" ):Hide()
end

function SprocketSubMenuItem.prototype:SetTooltip()
	GameTooltip:ClearLines()
	GameTooltip:AddLine( "Submenu Item" )
	GameTooltip:AddLine( "Menu: "..self:GetSubMenu(), 1, 1, 1 )
end

AceLibrary:Register( SprocketSubMenuItem, "SprocketSubMenuItem-2.0", 1 )
SprocketSubMenuItem = nil;


-----------------------------------------
-- SpellItem (ItemDef Inherited Class)
-- 
-- Class for an spell marking menu item
-----------------------------------------
local SprocketSpellItem = AceOO.Class( AceLibrary("SpellItem-2.0"), SubMenu, ShowInfo )

function SprocketSpellItem.prototype:init( object )
	AceLibrary("SprocketSpellItem-2.0").super.prototype.init(self, object) -- very important. Will fail without this.
end

function SprocketSpellItem:Deserialize( subMenu, parentArgs, showInfo )
	local object = self:new( AceLibrary("SprocketSpellItem-2.0").super:Deserialize( unpack(parentArgs) ) )
	object:SetSubMenu( subMenu )
	object:SetShowInfo( showInfo )
	return object
end

function SprocketSpellItem.prototype:Serialize()
	return self.subMenu, {AceLibrary("SprocketSpellItem-2.0").super.prototype.Serialize(self)}, self.showInfo
end

function SprocketSpellItem.prototype:GetTitle()
	title = AceLibrary("SprocketSpellItem-2.0").super.prototype.GetTitle( self )
	
	if ( self:GetShowInfo() ) then
		return (title.." "..self:GetRankString())
	end
	
	return title
end

function SprocketSpellItem.prototype:SetTooltip()
	GameTooltip:ClearLines()
	GameTooltip:AddLine( "Spell Item" )
	GameTooltip:AddLine( "Name: "..self.spellName, 1, 1, 1 )
	GameTooltip:AddLine( "Rank: "..self.spellRank, 1, 1, 1 )
end

function SprocketSpellItem.prototype:OnActivate( itemButton )
	itemButton:RegisterEvent( "SPELL_UPDATE_COOLDOWN" );
	self:OnEvent( itemButton );
end

function SprocketSpellItem.prototype:OnDeactivate( itemButton )
	itemButton:UnregisterEvent( "SPELL_UPDATE_COOLDOWN" );
end

function SprocketSpellItem.prototype:OnEvent( itemButton )
	local iconTexture = getglobal( itemButton:GetName().."IconTexture" );
	local cooldown = getglobal( itemButton:GetName().."Cooldown" );

	local start, duration, enable = GetSpellCooldown( self:GetSpellBookInfo() );
	SprocketCooldownFrame_SetTimer( cooldown, start, duration, enable );
	if ( enable == 1 ) then
		iconTexture:SetVertexColor(1.0, 1.0, 1.0);
	else
		iconTexture:SetVertexColor(0.4, 0.4, 0.4);
	end
end

AceLibrary:Register( SprocketSpellItem, "SprocketSpellItem-2.0", 1 )
SprocketSpellItem = nil

-----------------------------------------
-- MacroItem (ItemDef Inherited Class)
-- 
-- Class for an macro marking menu item
-----------------------------------------
local SprocketMacroItem = AceOO.Class( AceLibrary("MacroItem-2.0"), SubMenu )

function SprocketMacroItem.prototype:init( object )
	AceLibrary("SprocketMacroItem-2.0").super.prototype.init(self, object) -- very important. Will fail without this.
end

function SprocketMacroItem:Deserialize( subMenu, parentArgs )
	local object = self:new( AceLibrary("SprocketMacroItem-2.0").super:Deserialize( unpack(parentArgs) ) )
	object:SetSubMenu( subMenu )
	return object
end

function SprocketMacroItem.prototype:Serialize()
	return self.subMenu, {AceLibrary("SprocketMacroItem-2.0").super.prototype.Serialize(self)}
end

function SprocketMacroItem.prototype:OnActivate( itemButton )
	getglobal( itemButton:GetName().."Cooldown" ):Hide()
end

function SprocketMacroItem.prototype:ExecItem()
	if ( not AceLibrary("SprocketMacroItem-2.0").super.prototype.ExecItem( self ) ) then
		Sprocket:Print( "Macro Verify failed.  Stored macro name does not match macro index.  If you have recently modified your macros, you may want to recreate this Sprocket item." )
		return false
	end
	
	return true
end

function SprocketMacroItem.prototype:SetTooltip()
	GameTooltip:ClearLines()
	GameTooltip:AddLine( "Macro Item" )
	GameTooltip:AddLine( "Macro: "..self.macroName, 1, 1, 1 )
end

AceLibrary:Register( SprocketMacroItem, "SprocketMacroItem-2.0", 1 )
SprocketMacroItem = nil;

-----------------------------------------
-- UnitItem (ItemDef Inherited Class)
-- 
-- Class for an unit marking menu item
-----------------------------------------
local SprocketUnitItem = AceOO.Class( AceLibrary("UnitItem-2.0"), SubMenu )

function SprocketUnitItem.prototype:init( object )
	AceLibrary("SprocketUnitItem-2.0").super.prototype.init(self, object) -- very important. Will fail without this.
end

function SprocketUnitItem:Deserialize( subMenu, parentArgs )
	local object = self:new( AceLibrary("SprocketUnitItem-2.0").super:Deserialize( unpack(parentArgs) ) )
	object:SetSubMenu( subMenu )
	return object
end

function SprocketUnitItem.prototype:Serialize()
	return self.subMenu, {AceLibrary("SprocketUnitItem-2.0").super.prototype.Serialize(self)}
end

function SprocketUnitItem.prototype:OnActivate( itemButton )
	getglobal( itemButton:GetName().."Cooldown" ):Hide()
end

function SprocketUnitItem.prototype:SetTooltip()
	GameTooltip:ClearLines()
	GameTooltip:AddLine( "Unit Item" )
	GameTooltip:AddLine( "Unit: "..self.unitID, 1, 1, 1 )
end

AceLibrary:Register( SprocketUnitItem, "SprocketUnitItem-2.0", 1 );
SprocketUnitItem = nil;

-----------------------------------------
-- UseItem (ItemDef Inherited Class)
-- 
-- Class for an usable item marking menu item
-----------------------------------------
local SprocketUseItem = AceOO.Class( AceLibrary("UseItem-2.0"), SubMenu, ShowInfo )

function SprocketUseItem.prototype:init( object )
	AceLibrary("SprocketUseItem-2.0").super.prototype.init(self, object) -- very important. Will fail without this.
end

function SprocketUseItem:Deserialize( subMenu, parentArgs, showInfo )
	local object = self:new( AceLibrary("SprocketUseItem-2.0").super:Deserialize( unpack(parentArgs) ) )
	object:SetSubMenu( subMenu )
	object:SetShowInfo( showInfo )
	return object
end

function SprocketUseItem.prototype:Serialize()
	return self.subMenu, {AceLibrary("SprocketUseItem-2.0").super.prototype.Serialize(self)}, self.showInfo
end

function SprocketUseItem.prototype:SetTooltip()
	GameTooltip:ClearLines()
	GameTooltip:AddLine( "Use Item" )
	GameTooltip:AddLine( "Item: "..self.itemName, 1, 1, 1 )
end

function SprocketUseItem.prototype:OnActivate( itemButton )
	itemButton:RegisterEvent( "BAG_UPDATE_COOLDOWN" );
	self:OnEvent( itemButton );
end

function SprocketUseItem.prototype:OnDeactivate( itemButton )
	itemButton:UnregisterEvent( "BAG_UPDATE_COOLDOWN" );
end

local container
local slotID
local invSlotID
local start
local duration
local enable
local cooldown

function SprocketUseItem.prototype:GetCooldown()
	container, slotID = self:GetItemBagInfo()
	invSlotID = self:GetItemInventoryInfo()
	if ( container and slotID ) then
		start, duration, enable = GetContainerItemCooldown( container, slotID )
		if ( start > 0 and duration > 0 and enable > 0 ) then
			cooldown = (duration - (GetTime() - start))
			if ( cooldown > 60 ) then
				return floor( cooldown / 60 ).."m"..floor( math.mod( cooldown, 60 ) )
			else
				return floor( cooldown ).."s"
			end			
		else
			return nil
		end
	elseif( invSlotID ) then
		start, duration, enable = GetInventoryItemCooldown( "player", invSlotID )
		if ( start > 0 and duration > 0 and enable > 0 ) then
			cooldown = (duration - (GetTime() - start))
			if ( cooldown > 60 ) then
				return floor( cooldown / 60 ).."m"..math.mod( cooldown, 60 ) 
			else
				return floor( cooldown ).."s"
			end			
		else
			return nil
		end
	end	
end

function SprocketUseItem.prototype:OnEvent( itemButton )
	local iconTexture = getglobal( itemButton:GetName().."IconTexture" );
	local cooldown = getglobal( itemButton:GetName().."Cooldown" );

	local container, slotID = self:GetItemBagInfo()
	local invSlotID = self:GetItemInventoryInfo()
	if ( container and slotID ) then
		local start, duration, enable = GetContainerItemCooldown( container, slotID )
		SprocketCooldownFrame_SetTimer(cooldown, start, duration, enable);
		if ( enable == 1 ) then
			iconTexture:SetVertexColor(1.0, 1.0, 1.0);
		else
			iconTexture:SetVertexColor(0.4, 0.4, 0.4);
		end
	elseif( invSlotID ) then
		local start, duration, enable = GetInventoryItemCooldown( "player", invSlotID )
		SprocketCooldownFrame_SetTimer(cooldown, start, duration, enable);
		if ( enable == 1 ) then
			iconTexture:SetVertexColor(1.0, 1.0, 1.0);
		else
			iconTexture:SetVertexColor(0.4, 0.4, 0.4);
		end
	else
		iconTexture:SetVertexColor(0.4, 0.4, 0.4);
	end
end

function SprocketUseItem.prototype:IsEnabled()
	return true
--	if ( not AceLibrary("SprocketUseItem-2.0").super.prototype.IsEnabled( self ) ) then
--	end
end

function SprocketUseItem.prototype:OnUpdate( itemButton )
	if ( self.showCount ) then
		getglobal( itemButton:GetName().."Text" ):SetText( self:GetCount() );
	end
	if ( self:GetCount() == 0 ) then
		getglobal( itemButton:GetName().."IconTexture" ):SetVertexColor(0.4, 0.4, 0.4);
	end
end

AceLibrary:Register( SprocketUseItem, "SprocketUseItem-2.0", 1 )
SprocketUseItem = nil

-----------------------------------------
-- ActionItem (ItemDef Inherited Class)
-- 
-- Class for an action slot marking menu item
-----------------------------------------
local SprocketActionItem = AceOO.Class( AceLibrary("ActionItem-2.0"), SubMenu, ShowInfo )

function SprocketActionItem.prototype:init( object )
	AceLibrary("SprocketActionItem-2.0").super.prototype.init(self, object) -- very important. Will fail without this.
end

function SprocketActionItem:Deserialize( subMenu, parentArgs, showInfo )
	local object = self:new( AceLibrary("SprocketActionItem-2.0").super:Deserialize( unpack(parentArgs) ) )
	object:SetSubMenu( subMenu )
	object:SetShowInfo( showInfo )
	return object
end

function SprocketActionItem.prototype:Serialize()
	return self.subMenu, {AceLibrary("SprocketActionItem-2.0").super.prototype.Serialize(self)}, self.showInfo
end

function SprocketActionItem.prototype:GetTitle()
	local title = AceLibrary("SprocketActionItem-2.0").super.prototype.GetTitle( self )

	if ( not HasAction( self:GetSlotID() ) ) then
		return "None";
	end
	
	if ( not self:GetShowInfo() ) then
		return title
	end

	if ( self:GetCount() ) then
		return title.." ["..self:GetCount().."]"
	end
		
	ActionItemTooltip:SetOwner( UIParent, "ANCHOR_NONE" );
	ActionItemTooltip:ClearLines()
	ActionItemTooltip:SetAction( self:GetSlotID() )
	
	if ( ActionItemTooltipTextRight1:IsVisible() ) then
		return (title.." ("..ActionItemTooltipTextRight1:GetText()..")")
	end

	return title
end

function SprocketActionItem.prototype:SetTooltip()
	GameTooltip:ClearLines()
	GameTooltip:AddLine( "Action Item" )
	GameTooltip:AddLine( "SlotID: "..self.slotID, 1, 1, 1 )
	GameTooltip:AddLine( BAR_TEXTS[self.barID], 1, 1, 1 )
end


function SprocketActionItem.prototype:OnActivate( itemButton )
	itemButton:RegisterEvent( "ACTIONBAR_UPDATE_USABLE" );
	itemButton:RegisterEvent( "UPDATE_INVENTORY_ALERTS" );
	itemButton:RegisterEvent( "ACTIONBAR_UPDATE_COOLDOWN" );
	itemButton:RegisterEvent( "ACTIONBAR_UPDATE_STATE" );
	itemButton:RegisterEvent( "UPDATE_BONUS_ACTIONBAR" );
	self:OnEvent( itemButton );
end

function SprocketActionItem.prototype:OnDeactivate( itemButton )
	itemButton:UnregisterEvent( "ACTIONBAR_UPDATE_USABLE" );
	itemButton:UnregisterEvent( "UPDATE_INVENTORY_ALERTS" );
	itemButton:UnregisterEvent( "ACTIONBAR_UPDATE_COOLDOWN" );
	itemButton:UnregisterEvent( "ACTIONBAR_UPDATE_STATE" );
	itemButton:UnregisterEvent( "UPDATE_BONUS_ACTIONBAR" );
end

function SprocketActionItem.prototype:OnEvent( itemButton )
	local iconTexture = getglobal( itemButton:GetName().."IconTexture" );
	local cooldown = getglobal( itemButton:GetName().."Cooldown" );

	local start, duration, enable = GetActionCooldown( self:GetSlotID() )
	SprocketCooldownFrame_SetTimer(cooldown, start, duration, enable);
	if ( enable == 1 ) then
		iconTexture:SetVertexColor(1.0, 1.0, 1.0);
	else
		iconTexture:SetVertexColor(0.4, 0.4, 0.4);
	end
end

function SprocketActionItem.prototype:OnUpdate( itemButton )
	if ( self.showCount ) then
		getglobal( itemButton:GetName().."Text" ):SetText( self:GetCount() );
	else
		getglobal( itemButton:GetName().."Text" ):SetText();
	end

	local iconTexture = getglobal( itemButton:GetName().."IconTexture" );
	local isUsable, notEnoughMana = IsUsableAction( self:GetSlotID() )
	if ( IsActionInRange( self:GetSlotID() ) == 0 ) then
		if ( isUsable ) then			
			iconTexture:SetVertexColor( 0.8, 0.1, 0.1 );
			return;
		end
	end
	
	if ( (not isUsable) and notEnoughMana ) then
		iconTexture:SetVertexColor( 0.1, 0.3, 1.0 );
		return;
	end
	
	iconTexture:SetVertexColor( 1.0, 1.0, 1.0 );	
end

AceLibrary:Register( SprocketActionItem, "SprocketActionItem-2.0", 1 );
SprocketActionItem = nil;



-----------------------------------------
-- ScriptItem (ItemDef Inherited Class)
-- 
-- Class for an action script marking menu item
-----------------------------------------
local SprocketScriptItem = AceOO.Class( AceLibrary("ItemDef-2.0"), SubMenu )

function SprocketScriptItem.prototype:init( object )
	AceLibrary("SprocketScriptItem-2.0").super.prototype.init(self, "script", (object.iconTexture or "Interface\\Icons\\INV_Misc_Gear_01")) -- very important. Will fail without this.
	self.titleText = (object.titleText or "No title")
	self.bodyText = (object.bodyText or "")
end

function SprocketScriptItem:Deserialize( titleText, bodyText, subMenu, iconTexture )
	local object = self:new({})
	object.titleText = titleText
	object.bodyText = bodyText
	object:SetSubMenu( subMenu )
	object:SetIconTexture( iconTexture )
	return object
end

function SprocketScriptItem.prototype:Serialize()
	return self.titleText, self.bodyText, self:GetSubMenu(), self.iconTexture
end

function SprocketScriptItem.prototype:IsEnabled()
	return (self.bodyText ~= "")
end

function SprocketScriptItem.prototype:GetTitle()
	return self.titleText
end

function SprocketScriptItem.prototype:SetTitle( text )
	self.titleText = text
end

function SprocketScriptItem.prototype:OnActivate( itemButton )
	getglobal( itemButton:GetName().."Cooldown" ):Hide()
end

function SprocketScriptItem.prototype:SetTooltip()
	GameTooltip:ClearLines()
	GameTooltip:AddLine( "Script Item" )
	GameTooltip:AddLine( "Title: "..self.titleText, 1, 1, 1, 1 )
	GameTooltip:AddLine( "Body: "..self.bodyText, 1, 1, 1, 1 )
end

function SprocketScriptItem.prototype:ExecItem()
	local bodyLines = splitScriptBody( self.bodyText )

	for k, v in ipairs( bodyLines ) do
		MacroItemEditBox:SetText( "/"..v );
		ChatEdit_SendText( MacroItemEditBox );
	end
	
	return true
end

AceLibrary:Register( SprocketScriptItem, "SprocketScriptItem-2.0", 1 )
SprocketScriptItem = nil;


-----------------------------------------
-- ModuleDef (Class)
-- 
-- Virtual class for module items
-----------------------------------------
local ModuleDef = AceOO.Class()
ModuleDef.virtual = true

function ModuleDef.prototype:init()
	AceLibrary( "ModuleDef-2.0" ).super.prototype.init(self) -- very important. Will fail without this.
	self.type = tostring( self.class )
end

function ModuleDef.prototype:ToString()
	return string.format("<%s instance: %s>", tostring(self.class), tostring(self.type))
end

function ModuleDef.prototype:GetType()
	return self.type
end

function ModuleDef.prototype:IsEnabled()
	return false
end

function ModuleDef.prototype:GetTitle()
	return self.type.." method :GetTitle not implemented."
end

function ModuleDef.prototype:GetIconTexture()
	return "Interface\\Icons\\Temp"
end

function ModuleDef.prototype:GetIconCoord()
	return 0, 1, 0, 1
end

function ModuleDef.prototype:GetAceOptionsTable()
	return 	{
				type = "group",
				args = {
					nooptions = {
						name = tostring( self.type ), 
						type = 'execute',
				    	desc = "Method :GetAceOptionsTable not implemented.",
				    	order = 5,
				    	func = function()
			    		end
					},
				},
			}
end

function ModuleDef.prototype:GetSavedVariables()
end

function ModuleDef.prototype:ExecItem()
	Sprocket:Print( self.type, "method :ExecItem not implemented." )
	return false
end

function ModuleDef.prototype:SetTooltip()
	GameTooltip:ClearLines()
	GameTooltip:AddLine( self.type )
	GameTooltip:AddLine( "Method :SetTooltip not implemented.", 1, 1, 1, 1 )
end

AceLibrary:Register( ModuleDef, "ModuleDef-2.0", 1 )
ModuleDef = nil


-----------------------------------------
-- SprocketModuleItem (ItemDef Inherited Class)
-- 
-- Class for an action script marking menu item
-----------------------------------------
local SprocketModuleItem = AceOO.Class( AceLibrary("ItemDef-2.0"), "AceEvent-2.0", SubMenu )

function SprocketModuleItem.prototype:init( object )
	AceLibrary("SprocketModuleItem-2.0").super.prototype.init( self, "module" ) -- very important. Will fail without this.
	assert( object.moduleName )
	assert( object.moduleVars )
	self.moduleName = object.moduleName
	self.moduleVars = object.moduleVars

	if ( Sprocket:HasModule( self.moduleName ) ) then
		self.itemClassInst = Sprocket:GetModule( self.moduleName ):GetItemClass():new( self.moduleVars )
		self.moduleLoaded = true
	else
		self.itemClassInst = nil
		self.moduleLoaded = false
	end
	
	self:RegisterEvent( "PLAYER_LEAVING_WORLD" )
end

function SprocketModuleItem.prototype:PLAYER_LEAVING_WORLD()
	if ( self:IsLoaded() ) then
		moduleVars = self.itemClassInst:GetSavedVariables()
		if ( type( moduleVars ) == "table" ) then
			self.moduleVars = moduleVars
		end
	end
end

function SprocketModuleItem.prototype:OnEnable()
	if ( not self.itemClassInst ) then
		self.itemClassInst = Sprocket:GetModule( self.moduleName ):GetItemClass():new( self.moduleVars )
	end
	assert( self.itemClassInst )
	self.moduleLoaded = true
end

function SprocketModuleItem.prototype:OnDisable()
	if ( self:IsLoaded() ) then
		moduleVars = self.itemClassInst:GetSavedVariables()
		if ( type( moduleVars ) == "table" ) then
			self.moduleVars = moduleVars
		end
	end
	self.moduleLoaded = false
end

function SprocketModuleItem.prototype:GetAceOptionsTable()
	if ( not self.itemClassInst ) then
		return 	{
					type = 'group',
					args = {
					    notloaded = {
					    	name = self.moduleName,
					        type = 'execute',
					        desc = "Module not loaded.",
					        func = function()
					        end
					    }
					}
				}
	else
		return self.itemClassInst:GetAceOptionsTable()
	end
end

function SprocketModuleItem.prototype:GetModuleName()
	return self.moduleName
end

function SprocketModuleItem:Deserialize( moduleName, moduleVars, subMenu )
	local object = {}
	object.moduleName = moduleName
	object.moduleVars = moduleVars
	object.subMenu = subMenu
	return self:new( object )
end

function SprocketModuleItem.prototype:Serialize()
	return self.moduleName, self.moduleVars, self.subMenu
end

function SprocketModuleItem.prototype:IsLoaded()
	return self.moduleLoaded
end

function SprocketModuleItem.prototype:GetIconCoord()
	if ( not self:IsLoaded() ) then
		return 0, 1, 0, 1
	else
		return self.itemClassInst:GetIconCoord()
	end
end

function SprocketModuleItem.prototype:IsEnabled()
	if ( not self:IsLoaded() ) then
		return false
	else
		return self.itemClassInst:IsEnabled()
	end
end

function SprocketModuleItem.prototype:ExecItem()
	if ( not self:IsLoaded() ) then
		return false
	else
		return self.itemClassInst:ExecItem()
	end
end

function SprocketModuleItem.prototype:GetTitle()
	if ( not self:IsLoaded() ) then
		return "Module Item"
	else
		return self.itemClassInst:GetTitle()
	end
end

function SprocketModuleItem.prototype:GetIconTexture()
	if ( not self:IsLoaded() ) then
		return "Interface\\Icons\\INV_Misc_QuestionMark"
	else
		return self.itemClassInst:GetIconTexture()
	end
end

function SprocketModuleItem.prototype:OnActivate( itemButton )
	if ( not self:IsLoaded() ) then
		return
	elseif ( self.itemClassInst.OnActivate ) then
		self.itemClassInst:OnActivate( itemButton )
	end
end

function SprocketModuleItem.prototype:OnDeactivate( itemButton )
	if ( not self:IsLoaded() ) then
		return
	elseif ( self.itemClassInst.OnDeactivate ) then
		self.itemClassInst:OnDeactivate( itemButton )
	end
end

function SprocketModuleItem.prototype:OnEvent( itemButton )
	if ( not self:IsLoaded() ) then
		return 
	elseif ( self.itemClassInst.OnEvent ) then
		self.itemClassInst:OnEvent( itemButton )
	end
end

function SprocketModuleItem.prototype:SetTooltip()
	if ( not self:IsLoaded() ) then
		GameTooltip:ClearLines()
		GameTooltip:AddLine( "Module Item" )
		GameTooltip:AddLine( "Module: "..self.moduleName, 1, 1, 1, 1 )
		GameTooltip:AddLine( "Module not loaded.", 1, 1, 0, 1 )	
		return
	else
		self.itemClassInst:SetTooltip()
	end
end

AceLibrary:Register( SprocketModuleItem, "SprocketModuleItem-2.0", 1 )
SprocketModuleItem = nil;


local SprocketBlankItem = AceLibrary("SprocketBlankItem-2.0");
local SprocketSubMenuItem = AceLibrary("SprocketSubMenuItem-2.0");
local SprocketSpellItem = AceLibrary("SprocketSpellItem-2.0");
local SprocketMacroItem = AceLibrary("SprocketMacroItem-2.0");
local SprocketActionItem = AceLibrary("SprocketActionItem-2.0");
local SprocketUnitItem = AceLibrary("SprocketUnitItem-2.0");
local SprocketUseItem = AceLibrary("SprocketUseItem-2.0");
local SprocketScriptItem = AceLibrary("SprocketScriptItem-2.0");
local SprocketModuleItem = AceLibrary("SprocketModuleItem-2.0");


-----------------------------------------
-- SprocketMenu (Class)
-- 
-- Class for a marking menu
-----------------------------------------
local SprocketMenu = AceOO.Class()

function SprocketMenu.prototype:init( name, object )
	SprocketMenu.super.prototype.init(self) -- very important. Will fail without this.

	if ( not object ) then
		object = {}
	end

	self.type = "menu"
	self.menuName = name
	self.showNames = (object.showNames or false)
	self.selectedItemID = 0
	self.slotOwners = {}
	self.itemOffset = (object.itemOffset or 70)
	self.deadZone = (object.deadZone or 65)
	self.selectionRadius = (object.selectionRadius or 260)
	self.iconTexture = (object.iconTexture or "Interface\\Icons\\INV_Misc_Rune_06")
	
	for slotIndex = 0, 15 do
		self.slotOwners[slotIndex] = 0
	end

	if ( object.Items ) then
		self.Items = object.Items
	else
		self.Items = {}
		for index = 1, MAX_ITEMDEFS do
			self.Items[index] = SprocketBlankItem:new()
		end
	end
end

function SprocketMenu.prototype:SetIconTexture( iconTexture )
	self.iconTexture = iconTexture;
end

function SprocketMenu.prototype:GetIconTexture( iconTexture )
	return self.iconTexture;
end

function SprocketMenu.prototype:GetType()
	return self.type;
end

function SprocketMenu:Deserialize( name, itemOffset, Items, showNames, deadZone, iconTexture, selectionRadius )
	local objectDef = {}
	objectDef.itemOffset = itemOffset
	objectDef.Items = Items
	objectDef.showNames = showNames
	objectDef.deadZone = deadZone
	objectDef.iconTexture = iconTexture -- not currently used
	objectDef.selectionRadius = selectionRadius	
	
	return SprocketMenu:new( name, objectDef )
end

function SprocketMenu.prototype:Serialize()
	return self.menuName, self.itemOffset, self.Items, self.showNames, self.deadZone, self.iconTexture, self.selectionRadius;
end

function SprocketMenu.prototype:ToString() 
	return string.format("<%s instance: %s>", tostring(self.class), tostring(self.menuName))
end

function SprocketMenu.prototype:UpdateSlots()
	local firstEnabled = 0;
	local lastEnabled = 0;

	for popIndex = 1, MAX_ITEMDEFS do
		if ( self.Items[popIndex]:IsEnabled() ) then
			if ( lastEnabled < 1 ) then
				firstEnabled = popIndex;
				lastEnabled = popIndex;
			else
				local slotOffset = (lastEnabled - 1) * 2;
				local diff = popIndex - lastEnabled;
				for slotIndex = 0, diff * 2, 1 do
					if ( slotIndex < diff ) then
						self.slotOwners[slotIndex + slotOffset] = lastEnabled;
					else
						self.slotOwners[slotIndex + slotOffset] = popIndex;
					end
				end
				lastEnabled = popIndex;
			end
		end
	end
	
	if ( not firstEnabled ) then
		return;
	end
		
	if ( firstEnabled == lastEnabled ) then
		for slotIndex = 0, 15, 1 do
			self.slotOwners[slotIndex] = firstEnabled;
		end
	else
		local slotOffset = (lastEnabled - 1) * 2;
		local diff = (8 - lastEnabled) + firstEnabled;
		for slotIndex = 0, diff * 2, 1 do
			if ( (slotIndex  + slotOffset) == 16 ) then
				slotOffset = -slotIndex;
			end
			
			if ( slotIndex < diff ) then
				self.slotOwners[slotIndex + slotOffset] = lastEnabled;
			else
				self.slotOwners[slotIndex + slotOffset] = firstEnabled;
			end
		end
	end	
end

function SprocketMenu.prototype:SetItemOffset( value )
	self.itemOffset = value
end

function SprocketMenu.prototype:GetItemOffset()
	return self.itemOffset
end

function SprocketMenu.prototype:SetDeadzone( value )
	self.deadZone = value
end

function SprocketMenu.prototype:GetDeadzone()
	return self.deadZone
end

function SprocketMenu.prototype:SetSelectionRadius( value )
	self.selectionRadius = value
end

function SprocketMenu.prototype:GetSelectionRadius()
	return self.selectionRadius
end

function SprocketMenu.prototype:SetShowNames( state )
	self.showNames = (state or false)
end

function SprocketMenu.prototype:GetShowNames()
	return self.showNames
end

function SprocketMenu.prototype:SetItem( objectDef, id )
	assert( type(objectDef) == "table" );
	self.Items[id] = nil;
	if ( objectDef.type == "none" ) then
		self.Items[id] = SprocketBlankItem:new();
	elseif ( objectDef.type == "submenu" ) then
		self.Items[id] = SprocketSubMenuItem:new( objectDef );
	elseif ( objectDef.type == "spell" ) then
		self.Items[id] = SprocketSpellItem:new( objectDef );
	elseif ( objectDef.type == "macro" ) then
		self.Items[id] = SprocketMacroItem:new( objectDef );
	elseif ( objectDef.type == "unit" ) then
		self.Items[id] = SprocketUnitItem:new( objectDef );
	elseif ( objectDef.type == "item" ) then
		self.Items[id] = SprocketUseItem:new( objectDef );
	elseif ( objectDef.type == "action" ) then
		self.Items[id] = SprocketActionItem:new( objectDef );
	elseif ( objectDef.type == "script" ) then
		self.Items[id] = SprocketScriptItem:new( objectDef );
	elseif ( objectDef.type == "module" ) then
		self.Items[id] = SprocketModuleItem:new( objectDef );
	end
	assert( self.Items[id], "invalid object type "..objectDef.type )
	
	self:UpdateSlots();
	
	return self.Items[id];
end

function SprocketMenu.prototype:GetItem( id )
	if ( not self.Items[id] ) then
		Sprocket:Print( "Invalid item", id, "in menu \'"..self.menuName.."\'.", "Item being reset." )
		self.Items[id] = SprocketBlankItem:new();
	end
	return self.Items[id];
end

function SprocketMenu.prototype:IsItemEnabled( id )
	return self.Items[id]:IsEnabled();
end

function SprocketMenu.prototype:GetSlotOwnerID( slotID )
	return self.slotOwners[slotID];
end

function SprocketMenu.prototype:GetSelectedItemID()
	return self.selectedItemID;
end

function SprocketMenu.prototype:GetSelectedItem()
	return self.Items[self.selectedItemID], self.selectedItemID;
end

function SprocketMenu.prototype:SetSelectedItemID( id )
	self.selectedItemID = id;
end

function SprocketMenu.prototype:GetMenuName()
	return self.menuName;
end

function SprocketMenu.prototype:SetMenuName( name )
	self.menuName = name;
end

AceLibrary:Register( SprocketMenu, "SprocketMenu-2.0", 1 );
SprocketMenu = nil;
SprocketMenu = AceLibrary("SprocketMenu-2.0");


-----------------------------------------
-- SprocketMenuAction (Class)
-- 
-- Class ...
-----------------------------------------
local SprocketMenuAction = AceOO.Class()

function SprocketMenuAction.prototype:init( name )
	AceLibrary("SprocketMenuAction-2.0").super.prototype.init(self) -- very important. Will fail without this.
	
	self.type = "menuaction";
	self.name = name;
	self.menuName = "";
	self.isToggle = false;
	self.Items = {
		[1] = SprocketBlankItem:new();
		[2] = SprocketBlankItem:new();
	}
end

function SprocketMenuAction.prototype:GetType()
	return self.type;
end

function SprocketMenuAction.prototype:GetMenuName()
	return self.menuName;
end

function SprocketMenuAction.prototype:SetMenuName( name )
	self.menuName = name;
end

function SprocketMenuAction.prototype:GetName()
	return self.name;
end

function SprocketMenuAction:Deserialize( name, menuName, items, isToggle )
	local object = self:new( name );
	object.menuName = menuName;
	object.Items = items;
	object.isToggle = (isToggle or false);
	return object;
end

function SprocketMenuAction.prototype:Serialize()
	return self.name, self.menuName, self.Items, self.isToggle;
end

function SprocketMenuAction.prototype:GetItemCount()
	return table.getn( self.Items );
end

function SprocketMenuAction.prototype:GetItem( index )
	return self.Items[index];
end

function SprocketMenuAction.prototype:GetPreItem()
	return self.Items[1];
end

function SprocketMenuAction.prototype:GetPostItem()
	return self.Items[2];
end

function SprocketMenuAction.prototype:IsToggle()
	return self.isToggle;
end

function SprocketMenuAction.prototype:SetToggle( state )
	self.isToggle = state;
end

function SprocketMenuAction.prototype:SetItem( objectDef, id )
	assert( type(objectDef) == "table" );
	self.Items[id] = nil;
	if ( objectDef.type == "none" ) then
		self.Items[id] = SprocketBlankItem:new();
	elseif ( objectDef.type == "spell" ) then
		self.Items[id] = SprocketSpellItem:new( objectDef );
	elseif ( objectDef.type == "macro" ) then
		self.Items[id] = SprocketMacroItem:new( objectDef );
	elseif ( objectDef.type == "unit" ) then
		self.Items[id] = SprocketUnitItem:new( objectDef );
	elseif ( objectDef.type == "item" ) then
		self.Items[id] = SprocketUseItem:new( objectDef );
	elseif ( objectDef.type == "action" ) then
		self.Items[id] = SprocketActionItem:new( objectDef );
	elseif ( objectDef.type == "script" ) then
		self.Items[id] = SprocketScriptItem:new( objectDef );
	elseif ( objectDef.type == "module" ) then
		self.Items[id] = SprocketModuleItem:new( objectDef );
	else
		self.Items[id] = SprocketBlankItem:new();
	end
	assert( self.Items[id], "invalid object type "..objectDef.type )
	
	return self.Items[id];

end

function SprocketMenuAction.prototype:ToString() 
	return string.format("<%s instance: %s>", tostring(self.class), tostring(self.name))
end

AceLibrary:Register( SprocketMenuAction, "SprocketMenuAction-2.0", 1 );
SprocketMenuAction = nil;
local SprocketMenuAction = AceLibrary( "SprocketMenuAction-2.0" );


-----------------------------------------
-- TriggerDef (Class)
-- 
-- Virtual class for a trigger items
-----------------------------------------
local TriggerDef = AceOO.Class()
TriggerDef.virtual = true;

function TriggerDef.prototype:init( type, triggerName )
	AceLibrary("TriggerDef-2.0").super.prototype.init(self) -- very important. Will fail without this.

	assert( type, "Attempt to initialize TriggerDef without a type" )	
	self.type = type
	self.triggerName = triggerName
	self.frames = {}
end

function TriggerDef.prototype:GetType()
	return self.type;
end

function TriggerDef.prototype:ToString()
	return string.format("<%s instance: %s>", tostring(self.class), tostring(self.triggerName))
end

function TriggerDef.prototype:GetTriggerName()
	return self.triggerName;
end

function TriggerDef.prototype:GetNumFrames()
	return table.getn( self.frames );
end

function TriggerDef.prototype:GetFrameByID( index )
	assert( self.frames[index], "invalid frames index "..index )
	return self.frames[index];
end

function TriggerDef.prototype:GetFrameByName( name )
	for index = 1, table.getn( self.frames ) do
		if ( self.frames[index].name == name ) then
			return self.frames[index], index
		end
	end
	
	return nil, nil
end

function TriggerDef.prototype:SetFrame( objectDef, id )
	assert( objectDef.type == "menuaction", "invalid object type "..objectDef.type )	
	self.frames[id] = objectDef;
end

function TriggerDef.prototype:DeleteFrame( id )
	table.remove( self.frames, id );
end

function TriggerDef.prototype:GetFrameIndex( name )
	for index = 1, table.getn( self.frames ) do
		if ( self.frames[index].name == name ) then
			return index
		end
	end
	
	return nil
end

function TriggerDef.prototype:HasFrame( name )
	for index = 1, table.getn( self.frames ) do
		if ( self.frames[index].name == name ) then
			return true
		end
	end
	
	return false
end

function TriggerDef.prototype:AddFrame( object )
	assert( object.type == "menuaction", "invalid object type "..object.type )	

	if ( object.name == "UIParent" ) then
		Sprocket:Print( "Triggers cannot use UIParent" )
		return false;
	end

	for index = 1, table.getn( self.frames ) do
		if ( self.frames[index].name == object.name ) then
			return false;
		end
	end

	table.insert( self.frames, object );
	return true;
end

AceLibrary:Register( TriggerDef, "TriggerDef-2.0", 1 );
TriggerDef = nil;


-----------------------------------------
-- SprocketKeyTrigger (Class)
-- 
-- Class for a hotkey based trigger
-----------------------------------------
local SprocketKeyTrigger = AceOO.Class( AceLibrary("TriggerDef-2.0") )

function SprocketKeyTrigger.prototype:init( triggerName )
	AceLibrary("SprocketKeyTrigger-2.0").super.prototype.init(self, "hotkey", triggerName) -- very important. Will fail without this.
	
	self.frames = {
		[1] = SprocketMenuAction:new( "WorldFrame" ),
	}
end

function SprocketKeyTrigger:Deserialize( triggerName, frames )
	local object = self:new( triggerName );
	object.triggerName = triggerName;
	object.frames = frames;
	return object;
end

function SprocketKeyTrigger.prototype:Serialize()
	return self.triggerName, self.frames;
end

AceLibrary:Register( SprocketKeyTrigger, "SprocketKeyTrigger-2.0", 1 );
SprocketKeyTrigger = nil;


-----------------------------------------
-- SprocketMouseTrigger (Class)
-- 
-- Class for a hotkey based trigger
-----------------------------------------
local SprocketMouseTrigger = AceOO.Class( AceLibrary("TriggerDef-2.0") )

function SprocketMouseTrigger.prototype:init( triggerName )
	AceLibrary("SprocketMouseTrigger-2.0").super.prototype.init(self, "mouse", triggerName) -- very important. Will fail without this.
	
	self.frames = {}
end

function SprocketMouseTrigger:Deserialize( triggerName, frames )
	local object = self:new( triggerName );
	object.triggerName = triggerName;
	object.frames = frames;
	return object;
end

function SprocketMouseTrigger.prototype:Serialize()
	return self.triggerName, self.frames;
end

function SprocketMouseTrigger.prototype:AddFrame( object )
	if ( object.name == "WorldFrame" ) then
		Sprocket:Print( "Mouse Triggers cannot use WorldFrame" )
		return false;
	end
	return AceLibrary("SprocketMouseTrigger-2.0").super.prototype.AddFrame( self, object )
end


AceLibrary:Register( SprocketMouseTrigger, "SprocketMouseTrigger-2.0", 1 );
SprocketMouseTrigger = nil;


function SprocketCooldownFrame_SetTimer(cooldown, start, duration, enable)
	CooldownFrame_SetTimer(cooldown, start, duration, enable)
end

function splitScriptBody( str )
	str = string.gsub( str, "/", " /")
	str = string.gsub( str, "\" /", "\"/" )
	local bodyLines = splitStringBy( str,' /+')
	return bodyLines
end

UIPanelWindows["SprocketConfigFrame"] = { area = "left", pushable = 10, whileDead = 1 }

local DewDrop = AceLibrary("Dewdrop-2.0")
local SprocketMenuAction = AceLibrary( "SprocketMenuAction-2.0" )
local CursorItem = AceLibrary("CursorItem-2.0"):new()

SPROCKETCONFIG_TRIGGER_BUTTON_HEIGHT = 30;
SPROCKETCONFIG_TRIGGER_DISPLAY_BUTTONS = 3;

SPROCKETCONFIG_LOWER_BUTTON_HEIGHT = 30;
SPROCKETCONFIG_LOWER_DISPLAY_BUTTONS = 3;

SPROCKETCONFIG_MENU_BUTTON_HEIGHT = 30;
SPROCKETCONFIG_MENU_DISPLAY_BUTTONS = 6;

TAB_HOTKEY = 1
TAB_MOUSE = 2

TAB_TRIGGERS = 1
TAB_MENUS = 2

TAB_CHAR = 1
TAB_GLOBAL = 2

SprocketConfig = AceLibrary("AceAddon-2.0"):new(
	"AceConsole-2.0",
	"AceDebug-2.0"
)


function SprocketConfig:OnInitialize()
	self.dewDropSubMenus = true
	self.scanFrames = false
end

function SprocketConfig:GetSelectedMenu()
	if ( not SprocketMenuScrollList.selectedIndex ) then
		return nil;
	elseif ( SprocketMenuConfigFrame.selectedTab == TAB_CHAR ) then
		return Sprocket:GetMenuByID( SprocketMenuScrollList.selectedIndex );
	elseif ( SprocketMenuConfigFrame.selectedTab == TAB_GLOBAL ) then
		return Sprocket:GetGlobalMenuByID( SprocketMenuScrollList.selectedIndex );
	end
end

function SprocketConfig:GetSelectedMenuItem()
	local menu = self:GetSelectedMenu();
	if ( not menu or not SprocketMenuConfigFrame.selectedItemID ) then
		return nil;
	else
		return menu:GetItem( SprocketMenuConfigFrame.selectedItemID ), SprocketMenuConfigFrame.selectedItemID;
	end
end

function SprocketConfig:GetSelectedTrigger()
	if ( SprocketTriggerScrollList.selectedIndex == nil ) then
		return nil;
	elseif ( SprocketTriggerConfigFrame.selectedTab == TAB_HOTKEY ) then
		return Sprocket:GetHotkeyByID( SprocketTriggerScrollList.selectedIndex );
	elseif ( SprocketTriggerConfigFrame.selectedTab == TAB_MOUSE ) then
		return Sprocket:GetButtonByID( SprocketTriggerScrollList.selectedIndex );
	end
end

function SprocketConfig:GetSelectedTriggerAction()
	local trigger = self:GetSelectedTrigger();
	assert( trigger, "GetSelectedTriggerAction called with no selected trigger" );
	assert( SprocketLowerScrollList.selectedIndex, "GetSelectedTriggerAction called with no selected action" );

	return trigger:GetFrameByID( SprocketLowerScrollList.selectedIndex ), SprocketLowerScrollList.selectedIndex;
end

function SprocketConfig:GetSelectedTriggerActionItem()
	local action = self:GetSelectedTriggerAction();
	assert( action, "GetSelectedTriggerActionItem called with no selected action" );
	assert( SprocketTriggerConfigFrame.selectedItemID );

	return action:GetItem( SprocketTriggerConfigFrame.selectedItemID ), SprocketTriggerConfigFrame.selectedItemID;
end

function SprocketConfig:GetDewDropItem()
	if ( SprocketConfigFrame.selectedTab == TAB_MENUS ) then
		return SprocketConfig:GetSelectedMenuItem()
	elseif ( SprocketConfigFrame.selectedTab == TAB_TRIGGERS ) then
		return SprocketConfig:GetSelectedTriggerActionItem()
	end
end

--SprocketConfig:GetActiveItemOwner = SprocketConfig:GetDewDropItem

function SprocketConfig:GetDewDropItemOwner()
	if ( SprocketConfigFrame.selectedTab == TAB_MENUS ) then
		return SprocketConfig:GetSelectedMenu()
	elseif ( SprocketConfigFrame.selectedTab == TAB_TRIGGERS ) then
		return SprocketConfig:GetSelectedTriggerAction()
	end
end

--SprocketConfig:GetActiveItemButton = SprocketConfig:GetDewDropItem


SPROCKETCONFIGFRAME_SUBFRAMES = { "SprocketTriggerConfigFrame", "SprocketMenuConfigFrame", "SprocketGlobalConfigFrame" };
function SprocketConfigFrame_ShowSubFrame(frameName)
	DewDrop:Close()
	SprocketConfigPopupFrame:Hide()
	for index, value in SPROCKETCONFIGFRAME_SUBFRAMES do
		if ( value == frameName ) then
			getglobal(value):Show()
		else
			getglobal(value):Hide();
		end	
	end 
end


function SprocketConfigFrame_OnLoad()
	PanelTemplates_SetNumTabs(this, 3);
	SprocketConfigFrame.selectedTab = 2;
	PanelTemplates_UpdateTabs(this);
end


function SprocketConfigFrame_OnShow()
	CursorItem:Enable();

	SprocketConfigFrame_Update();
	PlaySound("igMainMenuOpen");
	Sprocket:EnterConfig();

	if ( Sprocket.firstUse ) then
		SprocketHintFrame:Show()
		Sprocket.firstUse = false
	end
	SprocketConfig.scanFrames = false
end


function SprocketConfigFrame_OnHide()
	CursorItem:Disable();	
	SprocketConfigPopupFrame:Hide()
	SprocketConfig:CloseDewDrop();
	
	PlaySound("igMainMenuClose");
	for index, value in SPROCKETCONFIGFRAME_SUBFRAMES do
		getglobal(value):Hide();
	end

	SprocketConfig.scanFrames = false
	Sprocket:ExitConfig();
end

function SprocketMenuConfigFrame_OnLoad()
	PanelTemplates_SetNumTabs(this, 2);
	SprocketMenuConfigFrame.selectedTab = TAB_CHAR;
	PanelTemplates_UpdateTabs(this);

	SprocketMenuScrollList.selectedIndex = 1
	SprocketMenuScrollList.selectedID = 1
end

function SprocketTriggerConfigFrame_OnLoad()
	PanelTemplates_SetNumTabs(this, 2);
	SprocketTriggerConfigFrame.selectedTab = TAB_HOTKEY;
	PanelTemplates_UpdateTabs(this);

	SprocketTriggerScrollList.selectedIndex = 1
	SprocketTriggerScrollList.selectedID = 1

	SprocketLowerScrollList.selectedIndex = 1
	SprocketLowerScrollList.selectedID = 1
end

function SprocketConfig:CloseDewDrop()
	local dewDropParent = DewDrop:GetOpenedParent();
	if ( dewDropParent ) then
		DewDrop:Close( 1 );
		return true;
	else
		return false;
	end
end

function SprocketConfigFrame_Update()
	if ( SprocketConfigFrame.selectedTab == 1 ) then
		SprocketConfigFrameTitleText:SetText( "Sprocket Trigger Config" );
		SprocketConfigFrame_ShowSubFrame("SprocketTriggerConfigFrame");
		SprocketConfigFrameTopLeft:SetTexture("Interface\\QuestFrame\\UI-QuestLog-TopLeft");
		SprocketConfigFrameTopRight:SetTexture("Interface\\QuestFrame\\UI-QuestLog-TopRight");
		SprocketConfigFrameBottomLeft:Show();
		SprocketConfigFrameBottomRight:Show();
		SprocketConfigFrameBottomLeftFull:Hide();
		SprocketConfigFrameBottomRightFull:Hide();
		SprocketConfigFrameTopLeftOverlay:Show()
		SprocketConfigFrameTopRightOverlay:Show()
		SprocketConfigFrameBottomLeftOverlay:Show()
		SprocketConfigFrameBottomRightOverlay:Show()
		SprocketTriggerConfigFrame_Update();
	elseif ( SprocketConfigFrame.selectedTab == 2 ) then
		SprocketConfigFrameTitleText:SetText( "Sprocket Menu Config" );
		SprocketConfigFrame_ShowSubFrame("SprocketMenuConfigFrame");
		SprocketConfigFrameTopLeft:SetTexture("Interface\\QuestFrame\\UI-QuestLog-TopLeft");
		SprocketConfigFrameTopRight:SetTexture("Interface\\QuestFrame\\UI-QuestLog-TopRight");
		SprocketConfigFrameBottomLeft:Show();
		SprocketConfigFrameBottomRight:Show();
		SprocketConfigFrameBottomLeftFull:Hide();
		SprocketConfigFrameBottomRightFull:Hide();
		SprocketConfigFrameTopLeftOverlay:Show()
		SprocketConfigFrameTopRightOverlay:Show()
		SprocketConfigFrameBottomLeftOverlay:Show()
		SprocketConfigFrameBottomRightOverlay:Show()
		SprocketMenuConfigFrame_Update();
	elseif( SprocketConfigFrame.selectedTab == 3 ) then
		SprocketConfigFrameTitleText:SetText( "Sprocket Global Config" );
		SprocketConfigFrame_ShowSubFrame("SprocketGlobalConfigFrame");
		SprocketConfigFrameTopLeft:SetTexture("Interface\\TaxiFrame\\UI-TaxiFrame-TopLeft");
		SprocketConfigFrameTopRight:SetTexture("Interface\\TaxiFrame\\UI-TaxiFrame-TopRight");
		SprocketConfigFrameBottomLeft:Hide();
		SprocketConfigFrameBottomRight:Hide();
		SprocketConfigFrameBottomLeftFull:Show();
		SprocketConfigFrameBottomRightFull:Show();
		SprocketConfigFrameTopLeftOverlay:Hide()
		SprocketConfigFrameTopRightOverlay:Hide()
		SprocketConfigFrameBottomLeftOverlay:Hide()
		SprocketConfigFrameBottomRightOverlay:Hide()
	end
	SprocketConfig:UpdateHelpText()
end

function SprocketConfig:Panel_Update()
	if ( SprocketConfigFrame.selectedTab == 1 ) then
		ScrollList_Update( SprocketTriggerScrollList );
		ScrollList_Update( SprocketLowerScrollList );
	elseif ( SprocketConfigFrame.selectedTab == 2 ) then
		ScrollList_Update( SprocketMenuScrollList );
	elseif( SprocketConfigFrame.selectedTab == 3 ) then
	end
	SprocketConfig:UpdateHelpText()
end

function SprocketMenuConfigFrame_Update()
	SprocketConfig:UpdateHelpText()
	ScrollList_Update( SprocketMenuScrollList );
end

function SprocketTriggerConfigFrame_Update()
	SprocketConfig:UpdateHelpText()
	ScrollList_Update( SprocketTriggerScrollList );
	ScrollList_Update( SprocketLowerScrollList );
end


function SprocketConfig_MenuItemOffset_OnValueChanged()
	local menu
	if ( SprocketMenuConfigFrame.selectedTab == TAB_CHAR ) then
		menu = Sprocket:GetMenuByID( SprocketMenuScrollList.selectedIndex )
	elseif ( SprocketMenuConfigFrame.selectedTab == TAB_GLOBAL ) then
		menu = Sprocket:GetGlobalMenuByID( SprocketMenuScrollList.selectedIndex )
	end
	menu:SetItemOffset( this:GetValue() )
end

function SprocketConfig_MenuDeadzone_OnValueChanged()
	local menu
	if ( SprocketMenuConfigFrame.selectedTab == TAB_CHAR ) then
		menu = Sprocket:GetMenuByID( SprocketMenuScrollList.selectedIndex )
	elseif ( SprocketMenuConfigFrame.selectedTab == TAB_GLOBAL ) then
		menu = Sprocket:GetGlobalMenuByID( SprocketMenuScrollList.selectedIndex )
	end
	menu:SetDeadzone( this:GetValue() )
end

function SprocketConfig_MenuSelectionRadius_OnValueChanged()
	local menu
	if ( SprocketMenuConfigFrame.selectedTab == TAB_CHAR ) then
		menu = Sprocket:GetMenuByID( SprocketMenuScrollList.selectedIndex )
	elseif ( SprocketMenuConfigFrame.selectedTab == TAB_GLOBAL ) then
		menu = Sprocket:GetGlobalMenuByID( SprocketMenuScrollList.selectedIndex )
	end
	menu:SetSelectionRadius( this:GetValue() )
end

function SprocketConfig_MenuShowNames_OnClick()
	local menu
	if ( SprocketMenuConfigFrame.selectedTab == TAB_CHAR ) then
		menu = Sprocket:GetMenuByID( SprocketMenuScrollList.selectedIndex )
	elseif ( SprocketMenuConfigFrame.selectedTab == TAB_GLOBAL ) then
		menu = Sprocket:GetGlobalMenuByID( SprocketMenuScrollList.selectedIndex )
	end
	menu:SetShowNames( this:GetChecked() )
end

function SprocketItemConfigPanel_Enable()
	local menu
	if ( SprocketMenuConfigFrame.selectedTab == TAB_CHAR ) then
		menu = Sprocket:GetMenuByID( SprocketMenuScrollList.selectedIndex )
	elseif ( SprocketMenuConfigFrame.selectedTab == TAB_GLOBAL ) then
		menu = Sprocket:GetGlobalMenuByID( SprocketMenuScrollList.selectedIndex )
	end

	SprocketConfigCenterButton:Enable()
	SprocketConfigCenterButtonIconTexture:SetTexture( menu:GetIconTexture() )
	SprocketMenuConfigFrameDeleteButton:Enable();
	SprocketMenuConfigFrameMenuLabel:SetVertexColor( 1, 1, 1 );
	SprocketMenuConfigFrameMenuLabel:SetText( menu:GetMenuName() );
	SprocketConfig_EnableSlider( SprocketMenuConfigOffset, menu:GetItemOffset() );
	SprocketConfig_EnableSlider( SprocketMenuConfigDeadzone, menu:GetDeadzone() );
	SprocketConfig_EnableSlider( SprocketMenuConfigSelRadius, menu:GetSelectionRadius() );
	SprocketConfig_EnableCheckBox( SprocketMenuConfigShowNames, menu:GetShowNames() );
	
	for index = 1, MAX_ITEMDEFS do
		item = menu:GetItem( index );
		getglobal( "SprocketItemConfigButton"..index ):Enable();
		getglobal( "SprocketItemConfigButton"..index.."IconTexture" ):SetVertexColor( 1, 1, 1 );
		getglobal( "SprocketItemConfigButton"..index.."OverlayTexture" ):SetVertexColor( 1, 1, 1 );
		getglobal( "SprocketItemConfigButton"..index.."IconTexture" ):SetTexture( item:GetIconTexture() );
		getglobal( "SprocketItemConfigButton"..index.."IconTexture" ):SetTexCoord( item:GetIconCoord() );
	end
end


function SprocketItemConfigPanel_Disable()
	SprocketConfigPopupFrame:Hide()
	SprocketConfigCenterButton:Disable()
	SprocketMenuConfigFrameDeleteButton:Disable();
	SprocketMenuConfigFrameMenuLabel:SetVertexColor( 0.25, 0.25, 0.25 );
	SprocketMenuConfigFrameMenuLabel:SetText( "<None>" );
	SprocketConfig_DisableSlider( SprocketMenuConfigOffset );
	SprocketConfig_DisableSlider( SprocketMenuConfigDeadzone );
	SprocketConfig_DisableSlider( SprocketMenuConfigSelRadius );
	SprocketConfig_DisableCheckBox( SprocketMenuConfigShowNames );

	for index = 1, MAX_ITEMDEFS do
		getglobal( "SprocketItemConfigButton"..index ):Disable();
		getglobal( "SprocketItemConfigButton"..index.."IconTexture" ):SetVertexColor( 0.25, 0.25, 0.25 );
		getglobal( "SprocketItemConfigButton"..index.."OverlayTexture" ):SetVertexColor( 0.25, 0.25, 0.25 );
	end
end


function SprocketConfig_DisableSlider( slider )
	local name = slider:GetName();
	getglobal(name.."Thumb"):Hide();
	getglobal(name.."Text"):SetVertexColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
	getglobal(name.."Low"):SetVertexColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
	getglobal(name.."High"):SetVertexColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
end

function SprocketConfig_EnableSlider( slider, value )
	local name = slider:GetName();
	getglobal(name.."Thumb"):Show();
	getglobal(name.."Text"):SetVertexColor(NORMAL_FONT_COLOR.r , NORMAL_FONT_COLOR.g , NORMAL_FONT_COLOR.b);
	getglobal(name.."Low"):SetVertexColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	getglobal(name.."High"):SetVertexColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	slider:SetValue( value );
end


function SprocketConfig_DisableCheckBox( checkBox )
	checkBox:Disable();
	getglobal(checkBox:GetName().."Text"):SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
end

function SprocketConfig_EnableCheckBox( checkBox, checked )
	checkBox:SetChecked( checked );
	checkBox:Enable();
	getglobal(checkBox:GetName().."Text"):SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
end

function SprocketConfig:Add_OnClick()
	if ( DewDrop:IsOpen( this ) ) then
		DewDrop:Close( 1 );
	else
		DewDrop:Open(this, 'point', "TOPLEFT", 'relativePoint', "TOPRIGHT", 'children', function( level, value ) AddFrame( level, value ) end);
	end
end

function SprocketConfig:Remove_OnClick()
	local trigger = SprocketConfig:GetSelectedTrigger();
	local action, id = SprocketConfig:GetSelectedTriggerAction();

	StaticPopupDialogs["DELETEACTION"] = {
		text = "Delete action '"..action.name.."'",
		button1 = TEXT(YES),
		button2 = TEXT(NO),
		OnAccept = function()
			local trigger = SprocketConfig:GetSelectedTrigger();
			local action, id = SprocketConfig:GetSelectedTriggerAction();
			trigger:DeleteFrame( id );
			ScrollList_Update( SprocketTriggerScrollList );
			Sprocket:UpdateButtonFrames();
		end,
		timeout = 0,
		hideOnEscape = 1
	};
	StaticPopup_Show("DELETEACTION","","");
end

function SprocketConfig:Create_OnClick()
	if ( DewDrop:IsOpen( this ) ) then
		DewDrop:Close( 1 );
	else
		DewDrop:Open(this, 'point', "TOPLEFT", 'relativePoint', "BOTTOMLEFT", 'children', function( level, value ) CreateMenu( level, value ) end);
	end
end

function SprocketConfig:Delete_OnClick()
	local menu = SprocketConfig:GetSelectedMenu();
	StaticPopupDialogs["DELETEMENU"] = {
		text = "Delete menu '"..menu:GetMenuName().."'",
		button1 = TEXT(YES),
		button2 = TEXT(NO),
		OnAccept = function()
			if ( SprocketMenuConfigFrame.selectedTab == TAB_CHAR ) then
				Sprocket:DeleteMenu( menu:GetMenuName() );
			elseif ( SprocketMenuConfigFrame.selectedTab == TAB_GLOBAL ) then
				Sprocket:DeleteGlobalMenu( menu:GetMenuName() );
			end
			ScrollList_Update( SprocketMenuScrollList );
		end,
		timeout = 0,
		hideOnEscape = 1
	};
	StaticPopup_Show("DELETEMENU","","");
end

function CreateMenu( level, value )
		DewDrop:AddLine(
			'text', "Menu Name: ",
			'hasArrow', true,
			'hasEditBox', true,
	   		'editBoxFunc', function( text )
								if ( text ~= nil and string.find( text, '%a' ) ) then
									if ( SprocketMenuConfigFrame.selectedTab == TAB_CHAR ) then
										if ( Sprocket:AddMenu( text ) ) then
											ScrollList_Update( SprocketMenuScrollList );
											PlaySound("igPlayerInvite");
										end
									elseif ( SprocketMenuConfigFrame.selectedTab == TAB_GLOBAL ) then
										if ( Sprocket:AddGlobalMenu( text ) ) then
											ScrollList_Update( SprocketMenuScrollList );
											PlaySound("igPlayerInvite");
										end
									end
									DewDrop:Close();
								end
		   					end
		)
end

function AddFrame( level, value )
	local trigger = SprocketConfig:GetSelectedTrigger()
	
	if ( not value ) then
		DewDrop:AddLine( 	
			'text', "Add Frame Trigger",
			'isTitle', true
		)
		DewDrop:AddLine( 	
			'text', "Blizzard",
			'hasArrow', true,
			'value', "blizzard"
		)
		DewDrop:AddLine( 	
			'text', "Sprocket",
			'hasArrow', true,
			'value', "sprocket"
		)
		DewDrop:AddLine(
			'text', "Custom",
			'hasArrow', true,
			'hasEditBox', true,
	   		'editBoxFunc', function(arg1, text)
								if ( text ~= nil and string.find( text, '%a' ) ) then
									AddFrameByName( arg1, text );
								end
								DewDrop:Close();
		   					end,
		   	'editBoxArg1', trigger
		)
		DewDrop:AddLine(
			'text', "Scan Frames",
			'tooltipTitle', "Scan Frames",
	    	'tooltipText', "Prints the name of frame frame under the cursor to your chat window.  This is useful for finding and adding custom frames.",
			'isRadio', true,
			'checked', SprocketConfig.scanFrames,
			'func', function()
						SprocketConfig.scanFrames = (not SprocketConfig.scanFrames);
					end
		)
	elseif ( value == "blizzard" ) then
		if ( trigger:GetType() == "hotkey" ) then
			DewDrop:AddLine( 
				'text', "WorldFrame",
				'disabled', trigger:HasFrame( "WorldFrame" ),
				'func', AddFrameByName,
				'arg1', trigger,
				'arg2', "WorldFrame"
			)
		end
		DewDrop:AddLine( 
			'text', "PlayerFrame",
			'disabled', trigger:HasFrame( "PlayerFrame" ),
			'func', AddFrameByName,
			'arg1', trigger,
			'arg2', "PlayerFrame"
		)
		DewDrop:AddLine( 
			'text', "TargetFrame",
			'disabled', trigger:HasFrame( "TargetFrame" ),
			'func', AddFrameByName,
			'arg1', trigger,
			'arg2', "TargetFrame"
		)
		DewDrop:AddLine( 
			'text', "PartyMemberFrame1",
			'disabled', trigger:HasFrame( "PartyMemberFrame1" ),
			'func', AddFrameByName,
			'arg1', trigger,
			'arg2', "PartyMemberFrame1"
		)
		DewDrop:AddLine( 
			'text', "PartyMemberFrame2",
			'disabled', trigger:HasFrame( "PartyMemberFrame2" ),
			'func', AddFrameByName,
			'arg1', trigger,
			'arg2', "PartyMemberFrame2"
		)
		DewDrop:AddLine( 
			'text', "PartyMemberFrame3",
			'disabled', trigger:HasFrame( "PartyMemberFrame3" ),
			'func', AddFrameByName,
			'arg1', trigger,
			'arg2', "PartyMemberFrame3"
		)
		DewDrop:AddLine( 
			'text', "PartyMemberFrame4",
			'disabled', trigger:HasFrame( "PartyMemberFrame4" ),
			'func', AddFrameByName,
			'arg1', trigger,
			'arg2', "PartyMemberFrame4"
		)
	elseif ( value == "sprocket" ) then
		DewDrop:AddLine( 
			'text', "SprocketBigButton",
			'disabled', trigger:HasFrame( "SprocketBigButton" ),
			'func', AddFrameByName,
			'arg1', trigger,
			'arg2', "SprocketBigButton"
		)
		DewDrop:AddLine( 
			'text', "SprocketMinimapButton",
			'disabled', trigger:HasFrame( "SprocketMinimapButton" ),
			'func', AddFrameByName,
			'arg1', trigger,
			'arg2', "SprocketMinimapButton"
		)
	end
end


function AddFrameByName( arg1, arg2 )
	local frame = getglobal( arg2 );
	if ( frame and frame.GetName and frame:GetName() ) then
		arg1:AddFrame( SprocketMenuAction:new( arg2 ) )
		ScrollList_Update( SprocketTriggerScrollList );
		Sprocket:UpdateButtonFrames();
	else
		Sprocket:Print( arg2.." is not a valid frame object." )		
	end
end


function SprocketItemConfigButton_ReceiveDrag( id )
	if ( not CursorItem:HasObjectDef() ) then
		return;
	end

	local menu = SprocketConfig:GetSelectedMenu();
	if ( menu == nil ) then
		return;
	end
	
	local item = menu:SetItem( CursorItem:GetObjectDef(), id );
	getglobal( "SprocketItemConfigButton"..id.."IconTexture" ):SetTexture( item:GetIconTexture() );
	getglobal( "SprocketItemConfigButton"..id.."IconTexture" ):SetTexCoord( item:GetIconCoord() );
	ClearCursor();

	for index = 1, MAX_ITEMDEFS do
		if ( index == id ) then
			getglobal( "SprocketItemConfigButton"..index ):LockHighlight();
		else
			getglobal( "SprocketItemConfigButton"..index ):UnlockHighlight();
		end
	end

	SprocketMenuConfigFrame.selectedItemID = id;
	if ( SprocketConfigPopupFrame:IsShown() ) then
		if ( SprocketConfig:GetSelectedMenuItem():GetType() ~= "script" ) then
			SprocketConfigPopupFrame:Hide()
		end
	end
end


function SprocketItemConfigButton_OnClick( id )
	local menu = SprocketConfig:GetSelectedMenu();
	if ( menu == nil ) then
		return;
	end

	local item = nil;
	if ( CursorItem:HasObjectDef() ) then
		item = menu:SetItem( CursorItem:GetObjectDef(), id );
		getglobal( "SprocketItemConfigButton"..id.."IconTexture" ):SetTexture( item:GetIconTexture() );
		getglobal( "SprocketItemConfigButton"..id.."IconTexture" ):SetTexCoord( item:GetIconCoord() );
		ClearCursor();
	else
		item = menu:GetItem( id );
	end

	for index = 1, MAX_ITEMDEFS do
		if ( index == id ) then
			getglobal( "SprocketItemConfigButton"..index ):LockHighlight();
		else
			getglobal( "SprocketItemConfigButton"..index ):UnlockHighlight();
		end
	end
	
	SprocketMenuConfigFrame.selectedItemID = id;
	if ( SprocketConfigPopupFrame:IsShown() ) then
		if ( SprocketConfig:GetSelectedMenuItem():GetType() ~= "script" ) then
			SprocketConfigPopupFrame:Hide()
		end
	end
	
	SprocketConfig.dewDropSubMenus = true;
	
	if ( arg1 == "LeftButton" ) then
		if ( DewDrop:IsOpen( this ) ) then
			DewDrop:Close( 1 );
		elseif ( item.type == "none" ) then
			DewDrop:Open(this, 'point', "TOPLEFT", 'relativePoint', "TOPRIGHT", 'children', function( level, value ) SetBlankItem( level, value ) end);
		elseif ( item.type == "submenu" ) then
			DewDrop:Open(this, 'point', "TOPLEFT", 'relativePoint', "TOPRIGHT", 'children', function( level, value ) SetSubMenuItem( level, value ) end);
		elseif ( item.type == "spell" ) then
			DewDrop:Open(this, 'point', "TOPLEFT", 'relativePoint', "TOPRIGHT", 'children', function( level, value ) SetSpellItem( level, value ) end);
		elseif ( item.type == "macro" ) then
			DewDrop:Open(this, 'point', "TOPLEFT", 'relativePoint', "TOPRIGHT", 'children', function( level, value ) SetMacroItem( level, value ) end);
		elseif ( item.type == "unit" ) then
			DewDrop:Open(this, 'point', "TOPLEFT", 'relativePoint', "TOPRIGHT", 'children', function( level, value ) SetUnitItem( level, value ) end);
		elseif ( item.type == "item" ) then
			DewDrop:Open(this, 'point', "TOPLEFT", 'relativePoint', "TOPRIGHT", 'children', function( level, value ) SetUseItem( level, value ) end);
		elseif ( item.type == "action" ) then
			DewDrop:Open(this, 'point', "TOPLEFT", 'relativePoint', "TOPRIGHT", 'children', function( level, value ) SetActionItem( level, value ) end);
		elseif ( item.type == "script" ) then
			DewDrop:Open(this, 'point', "TOPLEFT", 'relativePoint', "TOPRIGHT", 'children', function( level, value ) SetScriptItem( level, value ) end);
		elseif ( item.type == "module" ) then
			DewDrop:Open(this, 'point', "TOPLEFT", 'relativePoint', "TOPRIGHT", 'children', function( level, value ) SetModuleItem( level, value ) end);
		end
	elseif ( arg1 == "RightButton" ) then
		if ( DewDrop:IsOpen( this ) ) then
			DewDrop:Close( 1 );
		else
			DewDrop:Open(this, 'point', "TOPLEFT", 'relativePoint', "TOPRIGHT", 'children', function( level, value ) SetItemType( level, value ) end);
		end
	end
	
end


function SprocketTriggerItemConfigButton_ReceiveDrag( id )
	if ( not CursorItem:HasObjectDef() ) then
		return;
	end

	local action = SprocketConfig:GetSelectedTriggerAction();
	
	local item = action:SetItem( CursorItem:GetObjectDef(), id );
	getglobal( "SprocketLowerScrollListButton"..SprocketLowerScrollList.selectedID.."ItemButton"..id.."IconTexture" ):SetTexture( item:GetIconTexture() );
	getglobal( "SprocketLowerScrollListButton"..SprocketLowerScrollList.selectedID.."ItemButton"..id.."IconTexture" ):SetTexCoord( item:GetIconCoord() );
	ClearCursor();

	for index = 1, 2 do
		if ( index == id ) then
			getglobal( "SprocketLowerScrollListButton"..SprocketLowerScrollList.selectedID.."ItemButton"..index ):LockHighlight();
		else
			getglobal( "SprocketLowerScrollListButton"..SprocketLowerScrollList.selectedID.."ItemButton"..index ):UnlockHighlight();
		end
	end

	SprocketTriggerConfigFrame.selectedItemID = id;
end

function SprocketTriggerItemConfigButton_OnClick( id )
	local action = SprocketConfig:GetSelectedTriggerAction();

	if ( CursorItem:HasObjectDef() ) then
		item = action:SetItem( CursorItem:GetObjectDef(), id );
		getglobal( "SprocketLowerScrollListButton"..this:GetID().."ItemButton"..id.."IconTexture" ):SetTexture( item:GetIconTexture() );
		getglobal( "SprocketLowerScrollListButton"..this:GetID().."ItemButton"..id.."IconTexture" ):SetTexCoord( item:GetIconCoord() );
		ClearCursor();
	else
		item = action:GetItem( id );
	end

	for index = 1, 2 do
		if ( index == id ) then
			getglobal( "SprocketLowerScrollListButton"..this:GetID().."ItemButton"..index ):LockHighlight();
		else
			getglobal( "SprocketLowerScrollListButton"..this:GetID().."ItemButton"..index ):UnlockHighlight();
		end
	end
	
	SprocketTriggerConfigFrame.selectedItemID = id;
	
	SprocketConfig.dewDropSubMenus = false;

	if ( arg1 == "LeftButton" ) then
		if ( DewDrop:IsOpen( this ) ) then
			DewDrop:Close( 1 );
		elseif ( item.type == "none" ) then
			DewDrop:Open(this, 'point', "TOPLEFT", 'relativePoint', "TOPRIGHT", 'children', function( level, value ) SetBlankItem( level, value ) end);
		elseif ( item.type == "submenu" ) then
			DewDrop:Open(this, 'point', "TOPLEFT", 'relativePoint', "TOPRIGHT", 'children', function( level, value ) SetSubMenuItem( level, value ) end);
		elseif ( item.type == "spell" ) then
			DewDrop:Open(this, 'point', "TOPLEFT", 'relativePoint', "TOPRIGHT", 'children', function( level, value ) SetSpellItem( level, value ) end);
		elseif ( item.type == "macro" ) then
			DewDrop:Open(this, 'point', "TOPLEFT", 'relativePoint', "TOPRIGHT", 'children', function( level, value ) SetMacroItem( level, value ) end);
		elseif ( item.type == "unit" ) then
			DewDrop:Open(this, 'point', "TOPLEFT", 'relativePoint', "TOPRIGHT", 'children', function( level, value ) SetUnitItem( level, value ) end);
		elseif ( item.type == "item" ) then
			DewDrop:Open(this, 'point', "TOPLEFT", 'relativePoint', "TOPRIGHT", 'children', function( level, value ) SetUseItem( level, value ) end);
		elseif ( item.type == "action" ) then
			DewDrop:Open(this, 'point', "TOPLEFT", 'relativePoint', "TOPRIGHT", 'children', function( level, value ) SetActionItem( level, value ) end);
		elseif ( item.type == "script" ) then
			DewDrop:Open(this, 'point', "TOPLEFT", 'relativePoint', "TOPRIGHT", 'children', function( level, value ) SetScriptItem( level, value ) end);
		elseif ( item.type == "module" ) then
			DewDrop:Open(this, 'point', "TOPLEFT", 'relativePoint', "TOPRIGHT", 'children', function( level, value ) SetModuleItem( level, value ) end);
		end
	elseif ( arg1 == "RightButton" ) then
		if ( DewDrop:IsOpen( this ) ) then
			DewDrop:Close( 1 );
		else
			DewDrop:Open(this, 'point', "TOPLEFT", 'relativePoint', "TOPRIGHT", 'children', function( level, value ) SetItemType( level, value ) end);
		end
	end
end



function SetItemType()
	local item = SprocketConfig:GetDewDropItem();
	
	DewDrop:AddLine( 	
		'text', "Set Item Type",
		'isTitle', true,
		'textHeight', 14
	)
	DewDrop:AddLine( 	
		'text', "<None>",
		'func', SetDewDropItem,
		'arg1', {["type"]="none"},
		'closeWhenClicked', true,
		'checked', (item:GetType() == "none")
	)
	if ( SprocketConfig.dewDropSubMenus ) then
		DewDrop:AddLine( 	
			'text', "SubMenu",
			'func', SetDewDropItem,
			'arg1', {["type"]="submenu"},
			'closeWhenClicked', true,
			'checked', (item:GetType() == "submenu")
		)
	end
	DewDrop:AddLine( 	
		'text', "Spell",
		'closeWhenClicked', true,
		'disabled', true,
		'tooltipTitle', "Spell",
    	'tooltipText', "To set this button to cast\na spell, drop a spell from your\nspellbook onto it.",
		'checked', (item:GetType() == "spell")
	)
	DewDrop:AddLine( 	
		'text', "Action",
		'func', SetDewDropItem,
		'arg1', {["type"]="action"},
		'closeWhenClicked', true,
		'checked', (item:GetType() == "action")
	)
	DewDrop:AddLine( 	
		'text', "Macro",
		'closeWhenClicked', true,
		'disabled', true,
		'tooltipTitle', "Macro",
    	'tooltipText', "To set this button to trigger\na macro, drop a macro from your\nmacro panel onto it.",
		'checked', (item:GetType() == "macro")
	)
	DewDrop:AddLine( 	
		'text', "Unit",
		'func', SetDewDropItem,
		'arg1', {["type"]="unit"},
		'closeWhenClicked', true,
		'checked', (item:GetType() == "unit")
	)
	DewDrop:AddLine( 	
		'text', "Item",
		'closeWhenClicked', true,
		'disabled', true,
		'tooltipTitle', "Use Item",
    	'tooltipText', "To set this button to use an\nitem, drop and item from your\ninventory or bags onto it.",
    	'checked', (item:GetType() == "item")
	)
	DewDrop:AddLine( 	
		'text', "Script",
		'func', SetDewDropItem,
		'arg1', {["type"]="script"},
		'closeWhenClicked', true,
		'checked', (item:GetType() == "script")
	)
	for name, module in Sprocket:IterateModules() do
		if ( Sprocket:IsModuleActive( name ) and module:IsItemModule() ) then
			DewDrop:AddLine(
				'text', module:GetModuleTitle(),
				'tooltipTitle', module:GetModuleTitle(),
  			  	'tooltipText', module:GetModuleTooltipText(),
				'func', SetDewDropItem,
				'arg1', {["type"]="module", ["moduleName"]=name, ["moduleVars"]={}},
				'closeWhenClicked', true,
				'checked', (item:GetType() == "module" and item:GetModuleName() == name)
			)
		end
	end	
	DewDrop:AddLine( 	
		'text', "Cancel",
		'closeWhenClicked', true,
		'checkIcon', "Interface\\AddOns\\Sprocket\\UI\\UI-Cancel-Icon",
		'checked', true
	)	
end

function SetDewDropItem( arg1 )
	local owner = SprocketConfig:GetDewDropItemOwner();
	assert( owner );
	assert( type( arg1 ) == "table" );
	
	local oldItem, itemID = SprocketConfig:GetDewDropItem()
	local item = owner:SetItem( arg1, itemID );
	SprocketConfig:Panel_Update()
end


function SetBlankItem( level, value )
	DewDrop:AddLine(
		'text', "<None>",
		'isTitle', true,
		'textHeight', 14
   	)
	DewDrop:AddLine(
		'text', "Right-click a button to",
		'isClickable', false
   	)
	DewDrop:AddLine(
		'text', "set it's item type.",
		'isClickable', false
   	)
end

function SetModuleItem( level, value )
	local item = SprocketConfig:GetDewDropItem();

	if ( not Sprocket:HasModule( item:GetModuleName() ) or not Sprocket:IsModuleActive( item:GetModuleName() ) ) then
		DewDrop:AddLine(
			'text', item:GetModuleName().." not loaded.",
			'isTitle', true
	   	)
	   	return
	end

	if level == 1 then
		DewDrop:AddLine(
			'text', Sprocket:GetModule( item:GetModuleName() ).title,
			'isTitle', true,
			'textHeight', 14
	   	)
		DewDrop:FeedAceOptionsTable( item:GetAceOptionsTable() )
		AddFooter( item )
	elseif DewDrop:FeedAceOptionsTable( item:GetAceOptionsTable() ) then
	elseif ( value == "subMenu" ) then
		doSubMenu( item );
	end
end


function SetSubMenuItem( level, value )
	local item = SprocketConfig:GetDewDropItem();
	
	if ( not value ) then
		DewDrop:AddLine(
			'text', "SubMenu Item",
			'isTitle', true,
			'textHeight', 14
	   	)
		AddFooter( item );
	elseif ( value == "subMenu" ) then
		doSubMenu( item );
	end
	SprocketConfig:Panel_Update()
end

function SetSpellItem( level, value )
	local item = SprocketConfig:GetDewDropItem();
	
	if ( not value ) then
		DewDrop:AddLine(
			'text', "Spell Item",
			'isTitle', true,
			'textHeight', 14
	   	)
		DewDrop:AddLine(
			'text', item.spellName,
			'isTitle', true,
			'checked', true,
			'checkIcon', item:GetIconTexture(),
			'textR', 0.75,
			'textG', 0.75,
			'textB', 0.75,
			'textHeight', 12
	   	)
		DewDrop:AddLine(
			'text', item:GetRankString(),
		    'hasArrow', true,
		    'value', "spellRank"
	   	)
		DewDrop:AddLine(
			'text', "Use On Self",
			'isRadio', true,
			'checked', item.useOnSelf,
			'func', function()
						item.useOnSelf = (not item.useOnSelf);
					end,
			'arg1', item
		)
		DewDrop:AddLine(
			'text', "Show Rank in Title",
			'isRadio', true,
			'checked', item.showInfo,
			'func', function()
						item.showInfo = (not item.showInfo);
					end,
			'arg1', item
		)
		AddFooter( item );
	elseif ( value == "spellRank" ) then
		DewDrop:AddLine(
		    'text', "(Highest Rank)",
			'func', function()
					item.spellRank = 0;
					DewDrop:Close( 2 );
					DewDrop:Refresh( 1 );
				end,
			'arg1', item,
		    'checked', (item.spellRank == 0)
		)
		for index = 1, item:GetNumSpellRanks() do
			AddRank( index, item );
		end
	elseif ( value == "subMenu" ) then
		doSubMenu( item );
	end
	SprocketConfig:Panel_Update()
end


function AddRank( rankIndex, item )
	DewDrop:AddLine(
	    'text', "("..RANK.." "..rankIndex..")",
		'func', function()
				item.spellRank = rankIndex;
				DewDrop:Close( 2 );
				DewDrop:Refresh( 1 );
			end,
		'arg1', item,
	    'checked', (item.spellRank == rankIndex)
	)
end


function SetUnitItem( level, value )
	local item = SprocketConfig:GetDewDropItem();

	if ( not value ) then
		DewDrop:AddLine(
			'text', "Unit Item",
			'isTitle', true,
			'textHeight', 14
	   	)
		DewDrop:AddLine(
		    'text', "Unit: "..item.unitID,
		    'hasArrow', true,
		    'value', "unitName"
		)
		AddFooter( item );
	elseif ( value == "unitName" ) then
		DewDrop:AddLine(
		    'text', "Base Units",
		    'hasArrow', true,
		    'value', "baseUnits"
		)
		DewDrop:AddLine(
		    'text', "Party Units",
		    'hasArrow', true,
		    'value', "partyUnits"
		)
		DewDrop:AddLine(
		    'text', "Raid Units",
		    'hasArrow', true,
		    'value', "raidUnits"
		)
	elseif ( value == "baseUnits" ) then
		AddUnit( "player", item );
		AddUnit( "target", item );
		AddUnit( "pet", item );
	elseif ( value == "partyUnits" ) then
		for index = 1, 4 do
			AddUnit( "party"..index, item );
		end
	elseif ( value == "raidUnits" ) then
		for index = 1, 40 do
			AddUnit( "raid"..index, item );
		end
	elseif ( value == "subMenu" ) then
		doSubMenu( item );
	end
	SprocketConfig:Panel_Update()
end


function AddUnit( unitID, item )
	DewDrop:AddLine(
	    'text', unitID,
		'func', function()
				item.unitID = unitID;
				DewDrop:Close( 2 );
				DewDrop:Refresh( 1 );
			end,
		'arg1', item,
	    'checked', (item.unitID == unitID)
	)
end

function SetActionItem( level, value )
	local item = SprocketConfig:GetDewDropItem();
	
	if ( not value ) then
		DewDrop:AddLine(
			'text', "Action Item",
			'isTitle', true,
			'textHeight', 14
	   	)
		DewDrop:AddLine(
			'text', item:GetTitle(),
			'isTitle', true,
			'checked', true,
			'checkIcon', item:GetIconTexture(),
			'textR', 0.75,
			'textG', 0.75,
			'textB', 0.75,
			'textHeight', 12
	   	)
		DewDrop:AddLine(
			'text', "Bar: "..BAR_TEXTS[item.barID],
			'hasArrow', true,
			'value', "barID"
		)
		DewDrop:AddLine(
			'text', "Slot: "..item.slotID,
			'hasArrow', true,
			'value', "slotID"
		)
		DewDrop:AddLine(
			'text', "Use On Self",
			'isRadio', true,
			'checked', item.useOnSelf,
			'func', function()
						item.useOnSelf = (not item.useOnSelf);
					end,
			'arg1', item
		)
		DewDrop:AddLine(
			'text', "Show Count",
			'isRadio', true,
			'checked', item.showCount,
			'func', function()
						item.showCount = (not item.showCount);
					end,
			'arg1', item
		)
		DewDrop:AddLine(
			'text', "Show Count/Rank in Title",
			'isRadio', true,
			'checked', item.showInfo,
			'func', function()
						item.showInfo = (not item.showInfo);
					end,
			'arg1', item
		)
		AddFooter( item );
	elseif ( value == "barID" ) then
		for index = 0, 10 do
			AddBar( index, item );
		end
	elseif ( value == "slotID" ) then
		for index = 1, 12 do
			AddSlot( index, item );
		end
	elseif ( value == "subMenu" ) then
		doSubMenu( item );
	end
	
	SprocketConfig:Panel_Update()
end

function SetScriptItem( level, value )
	local item = SprocketConfig:GetDewDropItem();

	if ( not value ) then
		DewDrop:AddLine(
			'text', "Script Item",
			'isTitle', true,
			'textHeight', 14
	   	)
	   	DewDrop:AddLine(
	   		'text', CHOOSE_ICON,
	   		'func', function()
	   				if ( SprocketConfigPopupFrame:IsShown() ) then
		   				SprocketConfigPopupFrame:Hide()
		   			end
	   				SprocketConfigPopupFrame.mode = "scriptbutton"
	   				SprocketConfigPopupFrame:Show()
	   				DewDrop:Close()
		   		end
	   	)
		DewDrop:AddLine(
			'text', "Title: "..item:GetTitle(),
	   		'hasArrow', true,
	   		'hasEditBox', true,
	   		'editBoxText', item.titleText,
	   		'editBoxFunc', function(arg1, text)
	   							arg1:SetTitle( text )
								DewDrop:Close( 2 );
	   					end,
			'editBoxArg1', item
	   	)
	   	DewDrop:AddLine(
	   		'text', "Script Body",
	   		'hasArrow', true,
	   		'hasEditBox', true,
	   		'editBoxText', item.bodyText,
	   		'editBoxFunc', function(arg1, text)
	   							arg1.bodyText = text;
	   							Sprocket:Print( "Script Body:", text )
								DewDrop:Close( 2 );
	   					end,
			'editBoxArg1', item
	   	)
		AddFooter( item );
	elseif ( value == "subMenu" ) then
		doSubMenu( item );
	end
	SprocketConfig:Panel_Update()
end

function AddBar( barID, item )
	DewDrop:AddLine(
	    'text', BAR_TEXTS[barID],
		'func', function()
				item.barID = barID;
				DewDrop:Close( 2 );
				DewDrop:Refresh( 1 );
			end,
		'arg1', item,
		'arg2', barID,
	    'checked', (item.barID == barID)
	)
end

function AddSlot( slotID, item )
	DewDrop:AddLine(
	    'text', "Slot "..slotID.." ("..((item.barID - 1) * 12 + slotID)..")",
		'func', function()
				item.slotID = slotID;
				DewDrop:Close( 2 );
				DewDrop:Refresh( 1 );
			end,
		'arg1', item,
		'arg2', slotID,
	    'checked', (item.slotID == slotID)
	)
end


function SetMacroItem( level, value )
	local item = SprocketConfig:GetDewDropItem();
	
	if ( not value ) then
		DewDrop:AddLine(
			'text', "Macro Item",
			'isTitle', true,
			'textHeight', 14
	   	)
		DewDrop:AddLine(
			'text', item.macroName,
			'isTitle', true,
			'checked', true,
			'checkIcon', item:GetIconTexture(),
			'textR', 0.75,
			'textG', 0.75,
			'textB', 0.75,
			'textHeight', 12
	   	)
		AddFooter( item );
	elseif ( value == "subMenu" ) then
		doSubMenu( item );
	end
	SprocketConfig:Panel_Update()
end


function SetUseItem( level, value )
	local item = SprocketConfig:GetDewDropItem();
	
	if ( not value ) then
		DewDrop:AddLine(
			'text', "Use Item",
			'isTitle', true,
			'textHeight', 14
	   	)
		DewDrop:AddLine(
			'text', item.itemName,
			'isTitle', true,
			'checked', true,
			'checkIcon', item:GetIconTexture(),
			'textR', 0.75,
			'textG', 0.75,
			'textB', 0.75,
			'textHeight', 12
	   	)
		DewDrop:AddLine(
			'text', "Use On Self",
			'isRadio', true,
			'checked', item.useOnSelf,
			'func', function()
						item.useOnSelf = (not item.useOnSelf);
					end,
			'arg1', item
		)
		DewDrop:AddLine(
			'text', "Show Count",
			'isRadio', true,
			'checked', item.showCount,
			'func', function()
						item.showCount = (not item.showCount);
					end,
			'arg1', item
		)
		DewDrop:AddLine(
			'text', "Show Count in Title",
			'isRadio', true,
			'checked', item.showInfo,
			'func', function()
						item.showInfo = (not item.showInfo);
					end,
			'arg1', item
		)
		AddFooter( item );
	elseif ( value == "subMenu" ) then
		doSubMenu( item );
	end
	SprocketConfig:Panel_Update()
end


function doSubMenu( item )
	DewDrop:AddLine(
		'text', "<None>",
		'func', function()
					item:SetSubMenu( "" );
				end,
		'arg1', item
	)
	for menu in Sprocket:MenuIter() do
		AddMenu( menu:GetMenuName(), item );
	end
end


function AddMenu( menuName, item )
	DewDrop:AddLine(
		'text', menuName,
		'func', function()
					item:SetSubMenu( menuName )
					DewDrop:Close( 2 );
					DewDrop:Refresh( 1 );
				end,
		'arg1', item
	)
end


function AddFooter( item )
	if ( SprocketConfig.dewDropSubMenus ) then
		local subMenu;
		if ( item:GetSubMenu() == "" ) then
			subMenu = "<None>";
		else
			subMenu = item:GetSubMenu();
		end
		
		DewDrop:AddLine(
			'text', "SubMenu: "..subMenu,
			'hasArrow', true,
			'value', "subMenu"
		)
	end
	DewDrop:AddLine(
		'text', "Close",
		'checkIcon', "Interface\\AddOns\\Sprocket\\UI\\UI-Cancel-Icon",
		'checked', true,
		'closeWhenClicked', true
	)
	SprocketConfig:Panel_Update()
end


function ScrollList_Update( frame )
	if ( not frame ) then
		frame = this:GetParent();
	end

	local numItems = frame.GetNumItems();
	local itemOffset = FauxScrollFrame_GetOffset( getglobal( frame:GetName().."ScrollFrame" ) );
	local itemIndex;
	local showScrollBar = false;
	local displayText;
	if ( numItems > frame.numDisplayItems ) then
		showScrollBar = 1;
	end

	for i=1, frame.numDisplayItems, 1 do
		itemIndex = itemOffset + i;
		button = getglobal( frame:GetName().."Button"..i );
		button.itemIndex = itemIndex;

		if ( frame.selectedIndex == itemIndex ) then
			button:LockHighlight();
		else
			button:UnlockHighlight();
		end
		
		if ( itemIndex > numItems ) then
			button:Hide();
		else
			frame.UpdateItem( frame, itemIndex, i );
			button:Show();
		end
	end

	if ( frame.selectedIndex and frame.selectedIndex > numItems ) then
		frame.selectedIndex = nil;
	end
	
	frame.UpdateSelected( frame );

	FauxScrollFrame_Update( getglobal(frame:GetName().."ScrollFrame"), numItems, frame.numDisplayItems, frame.itemHeight );
end


function ScrollList_OnClick( mouseButton )
	this:GetParent().selectedIndex = this.itemIndex;
	this:GetParent().selectedID = this:GetID();
	SprocketConfig:CloseDewDrop();
	ScrollList_Update( this:GetParent() );
end


function SprocketMenu_UpdateSelected( frame )
	if ( frame.selectedIndex ) then
		SprocketItemConfigPanel_Enable();
		SprocketConfigPopupFrame_Update();
	else
		SprocketItemConfigPanel_Disable();
	end
end


function SprocketMenu_GetNumMenus()
	if ( SprocketMenuConfigFrame.selectedTab == TAB_CHAR ) then
		return Sprocket:GetNumMenus();
	elseif ( SprocketMenuConfigFrame.selectedTab == TAB_GLOBAL ) then
		return Sprocket:GetNumGlobalMenus();
	end
end

function SprocketMenu_UpdateButton( frame, menuIndex, buttonID )
	local menu
	if ( SprocketMenuConfigFrame.selectedTab == TAB_CHAR ) then
		menu = Sprocket:GetMenuByID( menuIndex );
	elseif ( SprocketMenuConfigFrame.selectedTab == TAB_GLOBAL ) then
		menu = Sprocket:GetGlobalMenuByID( menuIndex );
	end
	
	if ( menu ~= nil ) then
		getglobal( frame:GetName().."Button"..buttonID.."ButtonTextName" ):SetText( menu:GetMenuName() );
	end
end

function SprocketTrigger_UpdateSelected( frame )
	ScrollList_Update( SprocketLowerScrollList );
end

function SprocketTrigger_GetNumTriggers()
	if ( SprocketTriggerConfigFrame.selectedTab == TAB_MOUSE ) then
		return Sprocket:GetNumButtons();
	elseif ( SprocketTriggerConfigFrame.selectedTab == TAB_HOTKEY ) then
		return Sprocket:GetNumHotkeys();
	end
end

function SprocketTrigger_UpdateButton( frame, triggerIndex, buttonID )
	local trigger
	if ( SprocketTriggerConfigFrame.selectedTab == TAB_HOTKEY ) then
		trigger = Sprocket:GetHotkeyByID( triggerIndex );
	elseif ( SprocketTriggerConfigFrame.selectedTab == TAB_MOUSE ) then
		trigger = Sprocket:GetButtonByID( triggerIndex );
	end

	if ( trigger ~= nil ) then
		getglobal( frame:GetName().."Button"..buttonID.."ButtonTextName" ):SetText( trigger.triggerName );

		local binding1, binding2;
		if ( trigger.type == "hotkey" ) then
			binding1, binding2 = GetBindingKey( "SPROCKET_KEYMENU"..triggerIndex );
			getglobal( frame:GetName().."Button"..buttonID.."ButtonTextType" ):SetText( "Hotkey Trigger" )
		else
			getglobal( frame:GetName().."Button"..buttonID.."ButtonTextType" ):SetText( "Button Trigger" )
			getglobal( frame:GetName().."Button"..buttonID.."ButtonTextBind" ):SetText()
			getglobal( frame:GetName().."Button"..buttonID.."ButtonTextBind" ):SetAlpha( 0 )
			return;
		end
		local keyBindingButton = getglobal( frame:GetName().."Button"..buttonID.."ButtonTextBind" );
		if ( binding1 ) then
			keyBindingButton:SetText(GetBindingText(binding1, "KEY_"));
			keyBindingButton:SetAlpha(1);
		else
			keyBindingButton:SetText(NORMAL_FONT_COLOR_CODE..NOT_BOUND..FONT_COLOR_CODE_CLOSE);
			keyBindingButton:SetAlpha(0.8);
		end
	end
end


function LowerMenuDropDown_OnClick()
	if ( not SprocketLowerScrollList.selectedIndex or not (SprocketLowerScrollList.selectedIndex == this:GetParent():GetParent():GetID()) ) then
		SprocketLowerScrollList.selectedIndex = this:GetParent():GetParent().itemIndex;
		SprocketLowerScrollList.selectedID = this:GetParent():GetParent():GetID();
		SprocketConfig:CloseDewDrop();
		ScrollList_Update( SprocketLowerScrollList );
	end
	if ( DewDrop:IsOpen( this ) ) then
		DewDrop:Close( 1 );
	else
		DewDrop:Open(this, 'point', "TOPRIGHT", 'relativePoint', "BOTTOMRIGHT", 'children', function( level, value ) ChooseMenuItem( level, value ) end);
	end

end

function LowerMenuDropDown_OnEnter()
	if ( not SprocketLowerScrollList.selectedIndex or not (SprocketLowerScrollList.selectedIndex == this:GetParent():GetParent():GetID()) ) then
		this:GetParent():GetParent():LockHighlight()
	end
end

function LowerMenuDropDown_OnLeave()
	if ( not SprocketLowerScrollList.selectedIndex or not (SprocketLowerScrollList.selectedIndex == this:GetParent():GetParent():GetID()) ) then
		this:GetParent():GetParent():UnlockHighlight()
	end
end

function SprocketLower_UpdateSelected( frame )
	local button;

	if ( not SprocketConfigPopupFrame:IsShown() ) then
		return
	end
	
	if ( frame.selectedIndex and SprocketTriggerConfigFrame.selectedItemID ) then
		local item, itemID = SprocketConfig:GetSelectedTriggerActionItem()
		if ( item:GetType() == "script" ) then
			return
		end
	end	
	SprocketConfigPopupFrame:Hide()
end

function SprocketLower_GetNumItems()
	local trigger = SprocketConfig:GetSelectedTrigger();
	if ( trigger ) then
		return trigger:GetNumFrames();
	else
		return 0;
	end
end


function SprocketLower_UpdateButton( frame, itemIndex, buttonID )
	local trigger = SprocketConfig:GetSelectedTrigger();
	local action = trigger:GetFrameByID( itemIndex );
	getglobal( frame:GetName().."Button"..buttonID.."ButtonTextName" ):SetText( action:GetName() );
	getglobal( frame:GetName().."Button"..buttonID.."MenuDropDownText" ):SetText( action:GetMenuName() );
	getglobal( frame:GetName().."Button"..buttonID.."ItemButton1IconTexture" ):SetTexture( action:GetPreItem():GetIconTexture() );
	getglobal( frame:GetName().."Button"..buttonID.."ItemButton1IconTexture" ):SetTexCoord( action:GetPreItem():GetIconCoord() );
	getglobal( frame:GetName().."Button"..buttonID.."ItemButton2IconTexture" ):SetTexture( action:GetPostItem():GetIconTexture() );
	getglobal( frame:GetName().."Button"..buttonID.."ItemButton2IconTexture" ):SetTexCoord( action:GetPostItem():GetIconCoord() );
end


function ChooseMenuItem( level, value )
	for menu in Sprocket:MenuIter() do
	   	DewDrop:AddLine(
	   		'text', menu:GetMenuName(),
	   		'checked', menu:GetMenuName() == SprocketConfig:GetSelectedTriggerAction():GetMenuName(),
	   		'func', function( arg1 )
	   					SprocketConfig:GetSelectedTriggerAction():SetMenuName( arg1 );
	   					ScrollList_Update( SprocketLowerScrollList );
	   				end,
	   		'arg1', menu:GetMenuName(),
	   		'closeWhenClicked', true
	   	)
	end
end


function SprocketMenuItem_SetTooltip()
	local menu = SprocketConfig:GetSelectedMenu();
	local item = menu:GetItem( this:GetID() );
	
	GameTooltip_SetDefaultAnchor(GameTooltip, this);
	item:SetTooltip();
	GameTooltip:Show();
end

function SprocketTriggerItem_SetTooltip()
	local action = SprocketConfig:GetSelectedTriggerAction();
	local item = action:GetItem( this:GetID() );

	GameTooltip_SetDefaultAnchor(GameTooltip, this);
	item:SetTooltip();
	GameTooltip:Show();
end

NUM_MENU_ICONS_SHOWN = 20;
NUM_MENU_ICONS_PER_ROW = 5;
NUM_MENU_ICON_ROWS = 4;
MENU_ICON_ROW_HEIGHT = 36;

function SprocketConfig:PopupFrame_OnShow()
	SprocketConfigPopupFrame.selectedIcon = nil
	if ( not SprocketConfigPopupFrame.mode ) then
		SprocketConfigPopupFrame:Hide()
		return
	end

	PlaySound("igCharacterInfoOpen");
	SprocketConfigPopupFrame_Update();
end

function SprocketConfig:PopupFrame_OnHide()
	SprocketConfigPopupFrame.mode = nil
end

function SprocketConfig:PopupOkayButton_OnClick()
	if ( SprocketConfigPopupFrame.selectedIcon ) then
		local iconTexture = GetMacroIconInfo( SprocketConfigPopupFrame.selectedIcon )
		if ( SprocketConfigPopupFrame.mode == "centerbutton" ) then
			local menu = SprocketConfig:GetSelectedMenu()
			menu:SetIconTexture( iconTexture )
		elseif ( SprocketConfigPopupFrame.mode == "bigbutton" ) then
		elseif ( SprocketConfigPopupFrame.mode == "scriptbutton" ) then
			local item = SprocketConfig:GetSelectedMenuItem()
			item:SetIconTexture( iconTexture )
		end
	end
	
	SprocketConfigPopupFrame:Hide();
end

function SprocketConfig:PopupButton_OnClick()
	SprocketConfigPopupFrame.selectedIcon = this:GetID() + (FauxScrollFrame_GetOffset(SprocketConfigPopupScrollFrame) * NUM_MENU_ICONS_PER_ROW);
	local iconTexture = GetMacroIconInfo( SprocketConfigPopupFrame.selectedIcon )
	if ( SprocketConfigPopupFrame.mode == "centerbutton" ) then
		SprocketConfigCenterButtonIconTexture:SetTexture( iconTexture )
	elseif ( SprocketConfigPopupFrame.mode == "bigbutton" ) then
		Sprocket:SetBigButtonIconTexture( iconTexture )
	elseif ( SprocketConfigPopupFrame.mode == "scriptbutton" ) then
		local owner = SprocketConfig:GetDewDropItemOwner()
		local item, itemID = SprocketConfig:GetDewDropItem()

		if ( owner.type == "menuaction" ) then
			getglobal( "SprocketLowerScrollListButton"..SprocketLowerScrollList.selectedID.."ItemButton"..itemID.."IconTexture" ):SetTexture( iconTexture );
		else
			getglobal( "SprocketItemConfigButton"..itemID.."IconTexture" ):SetTexture( iconTexture );
		end
	end

	SprocketConfigPopupFrame_Update();
end

function SprocketConfigPopupFrame_Update()
	local numMenuIcons = GetNumMacroIcons();
	local menuPopupIcon, menuPopupButton;
	local menuPopupOffset = FauxScrollFrame_GetOffset(SprocketConfigPopupScrollFrame);
	local index;

	if ( SprocketConfigPopupFrame.mode == "centerbutton" ) then
		local menu
		if ( SprocketMenuConfigFrame.selectedTab == TAB_CHAR ) then
			menu = Sprocket:GetMenuByID( SprocketMenuScrollList.selectedIndex )
		elseif ( SprocketMenuConfigFrame.selectedTab == TAB_GLOBAL ) then
			menu = Sprocket:GetGlobalMenuByID( SprocketMenuScrollList.selectedIndex )
		end
		SprocketConfigPopupFrameMenuLabel:SetText( menu:GetMenuName().." Center Icon" )
	elseif ( SprocketConfigPopupFrame.mode == "bigbutton" ) then
		SprocketConfigPopupFrameMenuLabel:SetText( "Floating Button Icon" )
	elseif ( SprocketConfigPopupFrame.mode == "scriptbutton" ) then
		SprocketConfigPopupFrameMenuLabel:SetText( "Script Button Icon" )
	end

	-- Icon list
	for i=1, NUM_MENU_ICONS_SHOWN do
		menuPopupIcon = getglobal("SprocketConfigPopupButton"..i.."Icon");
		menuPopupButton = getglobal("SprocketConfigPopupButton"..i);
		index = (menuPopupOffset * NUM_MENU_ICONS_PER_ROW) + i;
		if ( index <= numMenuIcons ) then
			menuPopupIcon:SetTexture(GetMacroIconInfo(index));
			menuPopupButton:Show();
		else
			menuPopupIcon:SetTexture("");
			menuPopupButton:Hide();
		end
		if ( index == SprocketConfigPopupFrame.selectedIcon ) then
			menuPopupButton:SetChecked(1);
		else
			menuPopupButton:SetChecked(nil);
		end
	end
	
	-- Scrollbar stuff
	FauxScrollFrame_Update(SprocketConfigPopupScrollFrame, ceil(numMenuIcons / NUM_MENU_ICONS_PER_ROW) , NUM_MENU_ICON_ROWS, MENU_ICON_ROW_HEIGHT );
end

local curFrame
local curFrameName
local lastFrameName

function SprocketConfig:OnUpdate()
	if ( not self.scanFrames ) then
		return
	end
	
	curFrame = GetMouseFocus()
	
	if ( not curFrame ) then
		return
	end
	
	curFrameName = curFrame:GetName()
	
	if ( curFrameName and curFrameName ~= lastFrameName ) then
		SprocketConfig:Print( curFrameName )
		lastFrameName = curFrameName
	end
end

function SprocketConfig:UpdateHelpText()
	if ( SprocketConfigFrame.selectedTab == TAB_MENUS ) then
		hintText = "A Sprocket Menu is radial marking menu consisting of up to 8 items.  Each item in the menu can perform an action such as casting a spell, running a macro, selecting a unit, etc...\n\nThis menu is displayed around the mouse cursor when it is triggered by a key binding or mouse button.\n\nTo select one of the menu items, simply move the mouse cursor in it's general direction.  Once an item is selected, releasing the button that triggered the menu will execute the action associated with that item.\n\nYou cursor doesn't need to be directly over the item for it to be selected and executed; this makes using the menus very fast.\n\n"
		hintText = hintText..HIGHLIGHT_FONT_COLOR_CODE.."- Drag and drop a Spell, Item or Macro onto a button to set it to that action.\n"
		hintText = hintText..HIGHLIGHT_FONT_COLOR_CODE.."(You can also Right Click an item button to set advanced types such as Units or Scripts)\n\n"
		hintText = hintText..HIGHLIGHT_FONT_COLOR_CODE.."- Left Click an item button to edit it's current properties.  These will vary based on it's type."
	else
		hintText = "Triggers are used to display Sprocket menus.\n"
		hintText = hintText.."The upper pane contains a list of available triggers.  The lower pane contains a list of the frames associated with the selected trigger.\n\nWhen used, triggers detect which frame your cursor is over; if the trigger has an association with that frame, the menu is displayed.\n\n"
		hintText = hintText.."There are two types of triggers: Hotkeys and mouse buttons.\n\n"
		hintText = hintText.."Hotkeys open a menu while your cursor is over one of their associated frames, and execute the selected item (if any) when released. You can set your hotkeys from the Key Bindings menu.\n\n"
		hintText = hintText.."Mouse buttons open a menu when you click on one of their associated frames, and execute the selected item (if any) when released.\n\n"
		if ( SprocketTriggerConfigFrame.selectedTab == TAB_HOTKEY ) then
		else
			hintText = hintText..RED_FONT_COLOR_CODE.."Note: Associating a frame with a mouse button trigger creates a button that overlays this frame.  This overlay is transparent except when the configuration pane is open.  These overlays can prevent certain behaviors from happening.  For example: Using a PlayerFrame overlay will prevent the health and mana mouseovers from displaying text.  If you find this to be an issue, it is recommended you use hotkey overlays instead."
		end
	end

	SprocketHintText:SetText( hintText )
end

function SprocketConfig:Set_Tooltip( title, text )
	GameTooltip:SetOwner( this, "ANCHOR_RIGHT" )
	GameTooltip:ClearLines()
	GameTooltip:AddLine( title, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b )
	GameTooltip:AddLine( text, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b, 1 )
	GameTooltip:Show()
end

function SprocketConfig:GeneralOptions()
	if ( DewDrop:IsOpen( this ) ) then
		DewDrop:Close()
	else
		DewDrop:Open(this, 'point', "TOPLEFT", 'relativePoint', "TOPRIGHT", 'children', function( level, value ) DewDropGeneralOptions( level, value ) end);
	end
end

function SprocketConfig:MenuOptions()
	if ( DewDrop:IsOpen( this ) ) then
		DewDrop:Close()
	else
		DewDrop:Open(this, 'point', "TOPLEFT", 'relativePoint', "TOPRIGHT", 'children', function( level, value ) DewDropMenuOptions( level, value ) end);
	end
end

function SprocketConfig:MiniOptions()
	if ( DewDrop:IsOpen( this ) ) then
		DewDrop:Close()
	else
		DewDrop:Open(this, 'point', "TOPLEFT", 'relativePoint', "TOPRIGHT", 'children', function( level, value ) DewDropMiniOptions( level, value ) end);
	end
end

function SprocketConfig:BigOptions()
	if ( DewDrop:IsOpen( this ) ) then
		DewDrop:Close()
	else
		DewDrop:Open(this, 'point', "TOPLEFT", 'relativePoint', "TOPRIGHT", 'children', function( level, value ) DewDropBigOptions( level, value ) end);
	end
end



function DewDropGeneralOptions( level, value )
		DewDrop:AddLine( 
			'text', OVERLAYS_SHOW,
			'tooltipTitle', OVERLAYS_SHOW,
			'tooltipText', OVERLAYS_SHOW_TOOLTIP,
			'checked', Sprocket:GetShowOverlays(),
			'func', function()
					Sprocket:SetShowOverlays( not Sprocket:GetShowOverlays() )
				end
		)
		DewDrop:AddLine( 	
			'text', EFFECTS_SHOW,
			'tooltipTitle', EFFECTS_SHOW,
			'tooltipText', EFFECTS_SHOW_TOOLTIP,
			'checked', Sprocket:GetShowEffects(),
			'func', function()
					Sprocket:SetShowEffects( not Sprocket:GetShowEffects() )
				end
		)
end

function DewDropMenuOptions( level, value )
	if ( not value ) then
		DewDrop:AddLine( 
			'text', CENTER_SHOW,
			'tooltipTitle', CENTER_SHOW,
			'tooltipText', CENTER_SHOW_TOOLTIP,
			'checked', Sprocket:GetShowCenterButton(),
			'func', function()
					Sprocket:SetShowCenterButton( not Sprocket:GetShowCenterButton() )
				end
		)
		DewDrop:AddLine( 
			'text', CENTERBORDERTEXTURE,
			'tooltipTitle', CENTERBORDERTEXTURE,
			'tooltipText', CENTERBORDERTEXTURE_TOOLTIP,
			'disabled', not Sprocket:GetShowCenterButton(),
			'hasArrow', true,
			'value', "centerborder",
			'checked', true,
			'checkIcon', Sprocket:GetCenterButtonBorder()
		)
		DewDrop:AddLine( 	
			'text', RING_SHOW,
			'tooltipTitle', RING_SHOW,
			'tooltipText', RING_SHOW_TOOLTIP,
			'checked', Sprocket:GetShowItemRing(),
			'func', function()
					Sprocket:SetShowItemRing( not Sprocket:GetShowItemRing() )
				end
		)
		DewDrop:AddLine( 
			'text', ITEMBORDERTEXTURE,
			'tooltipTitle', ITEMBORDERTEXTURE,
			'tooltipText', ITEMBORDERTEXTURE_TOOLTIP,
			'hasArrow', true,
			'value', "itemborder",
			'checked', true,
			'checkIcon', Sprocket:GetItemBorderTexture()
		)
		DewDrop:AddLine( 	
			'text', MENUSCALE,
			'tooltipTitle', MENUSCALE,
			'tooltipText', MENUSCALE_TOOLTIP,
			'hasArrow', true,
			'hasSlider', true,
			'sliderMax', 1.5,
			'sliderMin', 0.65,
			'sliderValue', Sprocket:GetMenuScale(),
			'sliderStep', 0.05,
			'sliderFunc', function( value )
					Sprocket:SetMenuScale( value )
				end
		)
		DewDrop:AddLine(
			'text', HOVERDELAY,
			'tooltipTitle', HOVERDELAY,
			'tooltipText', HOVERDELAY_TOOLTIP,
			'hasArrow', true,
			'hasSlider', true,
			'sliderMax', 1.0,
			'sliderMin', 0,
			'sliderValue', Sprocket:GetHoverDelay(),
			'sliderStep', 0.05,
			'sliderFunc', function( value )
					Sprocket:SetHoverDelay( value )
				end
		)
	elseif ( value == "centerborder" ) then
		DewDrop:AddLine(
			'text', SPROCKETBORDER,
			'checked', Sprocket:GetCenterButtonBorder() == "Interface\\AddOns\\Sprocket\\UI\\UI-Sprocket-Border",
			'func', function()
					Sprocket:SetCenterButtonBorder( "Interface\\AddOns\\Sprocket\\UI\\UI-Sprocket-Border" )
				end
		)
		DewDrop:AddLine(
			'text', TRACKINGBORDER,
			'checked', Sprocket:GetCenterButtonBorder() == "Interface\\AddOns\\Sprocket\\UI\\UI-Sprocket-TrackingBorder",
			'func', function()
					Sprocket:SetCenterButtonBorder( "Interface\\AddOns\\Sprocket\\UI\\UI-Sprocket-TrackingBorder" )
				end
		)
		DewDrop:AddLine(
			'text', CUSTOMBORDER,
			'hasArrow', true,
			'hasEditBox', true,
	   		'editBoxFunc', function( text )
	   							Sprocket:SetCenterButtonBorder( text )
								DewDrop:Close();
		   					end			
		)
	elseif ( value == "itemborder" ) then
		DewDrop:AddLine(
			'text', SPROCKETBORDER,
			'checked', Sprocket:GetItemBorderTexture() == "Interface\\AddOns\\Sprocket\\UI\\UI-Sprocket-Border",
			'func', function()
					Sprocket:SetItemBorderTexture( "Interface\\AddOns\\Sprocket\\UI\\UI-Sprocket-Border" )
				end
		)
		DewDrop:AddLine(
			'text', TRACKINGBORDER,
			'checked', Sprocket:GetItemBorderTexture() == "Interface\\AddOns\\Sprocket\\UI\\UI-Sprocket-TrackingBorder",
			'func', function()
					Sprocket:SetItemBorderTexture( "Interface\\AddOns\\Sprocket\\UI\\UI-Sprocket-TrackingBorder" )
				end
		)
		DewDrop:AddLine(
			'text', CUSTOMBORDER,
			'hasArrow', true,
			'hasEditBox', true,
	   		'editBoxFunc', function( text )
	   							Sprocket:SetItemBorderTexture( text )
								DewDrop:Close();
		   					end			
		)
	end
end

function DewDropMiniOptions( level, value )
		DewDrop:AddLine( 	
			'text', MINIBUTTON_SHOW,
			'tooltipTitle', MINIBUTTON_SHOW,
			'tooltipText', MINIBUTTON_SHOW_TOOLTIP,
			'checked', Sprocket:GetShowMiniButton(),
			'func', function()
					Sprocket:SetShowMiniButton( not Sprocket:GetShowMiniButton() )
				end
		)
		DewDrop:AddLine(
			'text', MINIBUTTON_POS,
			'tooltipTitle', MINIBUTTON_POS,
			'tooltipText', MINIBUTTON_POS_TOOLTIP,
			'hasArrow', true,
			'hasSlider', true,
			'disabled', not Sprocket:GetShowMiniButton(),
			'sliderMax', 359,
			'sliderMin', 0,
			'sliderValue', Sprocket:MinimapButton_GetPos(),
			'sliderStep', 1,
			'sliderFunc', function( value )
					Sprocket:MinimapButton_UpdatePos( value )
				end
		)
end

function DewDropBigOptions( level, value )
	if ( not value ) then
		DewDrop:AddLine( 
			'text', BIGBUTTON_SHOW,
			'tooltipTitle', BIGBUTTON_SHOW,
			'tooltipText', BIGBUTTON_SHOW_TOOLTIP,
			'checked', Sprocket:GetShowBigButton(),
			'func', function()
					Sprocket:SetShowBigButton( not Sprocket:GetShowBigButton() )
				end
		)
		DewDrop:AddLine( 
			'text', BORDERTEXTURE,
			'tooltipTitle', BORDERTEXTURE,
			'tooltipText', BORDERTEXTURE_TOOLTIP,
			'hasArrow', true,
			'value', "border",
			'checked', true,
			'checkIcon', Sprocket:GetBigButtonBorder()
		)
		DewDrop:AddLine( 
			'text', CHOOSE_ICON,
			'disabled', not Sprocket:GetShowBigButton(),
			'checked', true,
			'checkIcon', Sprocket:GetBigButtonIconTexture(),
			'func', function()
					if ( SprocketConfigPopupFrame:IsShown() ) then
						SprocketConfigPopupFrame:Hide()
					end
					SprocketConfigPopupFrame.mode = "bigbutton"
					SprocketConfigPopupFrame:Show()
				end
		)
	elseif ( value == "border" ) then

		DewDrop:AddLine(
			'text', SPROCKETBORDER,
			'checked', Sprocket:GetBigButtonBorder() == "Interface\\AddOns\\Sprocket\\UI\\UI-Sprocket-Border",
			'func', function()
					Sprocket:SetBigButtonBorder( "Interface\\AddOns\\Sprocket\\UI\\UI-Sprocket-Border" )
				end
		)
		DewDrop:AddLine(
			'text', TRACKINGBORDER,
			'checked', Sprocket:GetBigButtonBorder() == "Interface\\AddOns\\Sprocket\\UI\\UI-Sprocket-TrackingBorder",
			'func', function()
					Sprocket:SetBigButtonBorder( "Interface\\AddOns\\Sprocket\\UI\\UI-Sprocket-TrackingBorder" )
				end
		)
		DewDrop:AddLine(
			'text', CUSTOMBORDER,
			'hasArrow', true,
			'hasEditBox', true,
	   		'editBoxFunc', function( text )
	   							Sprocket:SetBigButtonBorder( text )
								DewDrop:Close();
		   					end			
		)
	end
end

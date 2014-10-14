--[[ Revision: $LastChangedRevision: 16534 $ --]]
local L = AceLibrary("AceLocale-2.2"):new("myBindings2")

DEFAULT_BINDINGS = 0;
ACCOUNT_BINDINGS = 1;
CHARACTER_BINDINGS = 2;

-- Key binding to open up the myBindings window.
BINDING_HEADER_MYBINDINGS2 = "myBindings2"
BINDING_CATEGORY_MYBIDINGS2 = "Interface Enhancements"
BINDING_NAME_MYBINDINGS2_OPEN	= L["Opens the myBindings2 interface"]

BINDING_HEADER_MULTIACTIONBAR		= L["MultiActionBar Bottom Left"]
BINDING_HEADER_BLANK				= L["MultiActionBar Bottom Right"]
BINDING_HEADER_BLANK2				= L["MultiActionBar Right Side 1"]
BINDING_HEADER_BLANK3				= L["MultiActionBar Right Side 2"]

myBindings2 = AceLibrary("AceAddon-2.0"):new("AceDebug-2.0", "AceConsole-2.0", "AceDB-2.0")

local X_CATEGORIES = {
    ["Action Bars"] = L["Action Bars"],
    ["Auction"] = L["Auction"],
    ["Audio"] = L["Audio"],
    ["Battlegrounds/PvP"] = L["Battlegrounds/PvP"],
    ["Buffs"] = L["Buffs"],
    ["Chat/Communication"] = L["Chat/Communication"],
    ["Class"] = L["Class"],
    ["Healer"] = L["Healer"],
    ["Tank"] = L["Tank"],
    ["Caster"] = L["Caster"],
    ["Combat"] = L["Combat"],
    ["Compilations"] = L["Compilations"],
    ["Data Export"] = L["Data Export"],
    ["Development Tools"] = L["Development Tools"],
    ["Guild"] = L["Guild"],
    ["Frame Modification"] = L["Frame Modification"],
    ["Interface Enhancements"] = L["Interface Enhancements"],
    ["Inventory"] = L["Inventory"],
    ["Library"] = L["Library"],
    ["Map"] = L["Map"],
    ["Mail"] = L["Mail"],
    ["Miscellaneous"] = L["Miscellaneous"],
    ["Quest"] = L["Quest"],
    ["Raid"] = L["Raid"],
    ["Tradeskill"] = L["Tradeskill"],
    ["UnitFrame"] = L["UnitFrame"],
}

myBindings2.categoriesSort = {
    L["Standard Interface"],
    X_CATEGORIES["Action Bars"],
    X_CATEGORIES["Auction"],
    X_CATEGORIES["Audio"],
    X_CATEGORIES["Battlegrounds/PvP"],
    X_CATEGORIES["Buffs"],
    X_CATEGORIES["Chat/Communication"],
    X_CATEGORIES["Class"],
    X_CATEGORIES["Healer"],
    X_CATEGORIES["Tank"],
    X_CATEGORIES["Caster"],
    X_CATEGORIES["Combat"],
    X_CATEGORIES["Compilations"],
    X_CATEGORIES["Data Export"],
    X_CATEGORIES["Development Tools"],
    X_CATEGORIES["Guild"],
    X_CATEGORIES["Frame Modification"],
    X_CATEGORIES["Interface Enhancements"],
    X_CATEGORIES["Inventory"],
    X_CATEGORIES["Library"],
    X_CATEGORIES["Map"],
    X_CATEGORIES["Mail"],
    X_CATEGORIES["Quest"],
    X_CATEGORIES["Raid"],
    X_CATEGORIES["Tradeskill"],
    X_CATEGORIES["UnitFrame"],
    X_CATEGORIES["Miscellaneous"],
}

myBindings2.gameBindings = {}
myBindings2.currentMenuSelection = nil
myBindings2.confirmKeyBind		 = nil
myBindings2.maxMenuLines		 = 18
myBindings2.maxMenuLineHeight	 = 22
myBindings2.maxBindingLines		 = 17
myBindings2.maxBindingLineHeight = 25

myBindings2.chatOptions = {
    type = "group",
    name = "myBindings2",
    desc = L["An enhanced key bindings interface."],
    args = {
        setcat = {
            name = "Set category", type = "text",
            desc = "Set a category for a specific binding header (found in the addon's Bindings.xml).",
            usage = "<header> <category>",
            get = function() return end,
            set = function(t)
                myBindings2:SetCategory(t)
            end,
        },
        bind = {
            name = "Set category", type = "text",
            desc = "Bind a given key to a specific action.",
            usage = "Example: bind SHIFT-BUTTON2 BuffBot would bind the BuffBot() function to SHIFT + Right-Mouseclick. Give no action to unbind.",
            get = function() return end,
            set = function(t)
                myBindings2:SetBindOpt(t)
            end,
        },
    },
}

StaticPopupDialogs["MYBINDING2_CONFIRM_DELETING_CHARACTER_SPECIFIC_BINDINGS"] = {
	text = TEXT(CONFIRM_DELETING_CHARACTER_SPECIFIC_BINDINGS),
	button1 = TEXT(OKAY),
	button2 = TEXT(CANCEL),
	OnAccept = function()
		SaveBindings(myBindings2.which);
		myBindings2OptionsFrameOutputText:SetText("");
		myBindings2OptionsBindingsScrollFrame.selected = nil;
		HideUIPanel(myBindings2.frame);
		MYBINDING2_CONFIRMED_DELETING_CHARACTER_SPECIFIC_BINDINGS = 1;
	end,
	timeout = 0,
	whileDead = 1,
	showAlert = 1,
};

StaticPopupDialogs["MYBINDING2_CONFIRM_LOSE_BINDING_CHANGES"] = {
	text = TEXT(CONFIRM_LOSE_BINDING_CHANGES),
	button1 = TEXT(OKAY),
	button2 = TEXT(CANCEL),
	OnAccept = function()
		myBindings2:ChangeBindingProfile();
		myBindings2.bindingsChanged = nil;
	end,
	OnCancel = function()
		if myBindings2CharacterButton:GetChecked() then
			myBindings2CharacterButton:SetChecked();
		else
			myBindings2CharacterButton:SetChecked(1);
		end
	end,
	timeout = 0,
	whileDead = 1,
	showAlert = 1,
};

function myBindings2:OnInitialize()
	--self:SetDebugging(true)
	--self:SetDebugLevel(2)
	
	self:RegisterDB("myBindings2DB")
	self:RegisterDefaults('realm', {
		chars = {
			['*'] = {
				bindings = {},
				categories = {},
			}
		}
	})

	self:RegisterDefaults('profile', {
	    character = DEFAULT_BINDINGS,
	})
	
	self:RegisterChatCommand(L["Slash-Commands"], self.chatOptions)
	
	_G = getfenv(0)
	
	self.dontOpenGameMenu = true
	self.GameMenuButtonFrame = self:CreateGameMenuButtonFrame()
	self.frame = self:CreateOptionsFrame()
	self.categoryButton = nil
	self.bindingHeader = nil
	self.applySkins = true
	self.bindingsChanged = nil;
	
	self.Msg	= function(...) self:Print(format(unpack(arg))) end
	self.Error  = function(...) self:Print("|cffff6060[error]|r "..format(unpack(arg))) end

	self.savedKeyBindingFrame = KeyBindingFrame
end

function myBindings2:OnEnable()

	-- Override the existing key bindings dialog so that myBindingsOptionsFrame will
	-- get called just like any other UIPanel frame.
	KeyBindingFrame = _G["myBindings2OptionsFrame"]
	GameMenuButtonKeybindings:Hide()
	self.GameMenuButtonFrame:Show()

	--self:RegisterEvent("ACE_PROFILE_LOADED") -- not used

	self:SetGameBindings()
	self:ParseBindings()
	
	--self.which = GetCurrentBindingSet()
	self.which = self.db.profile.character
	self:LoadBindings(self.which)

	UIPanelWindows[self.frame] = {area = "center", pushable = 0}
	self.frame.selected = nil
end

function myBindings2:OnDisable()
	KeyBindingFrame = self.savedKeyBindingFrame
	GameMenuButtonKeybindings:Show()
	self.GameMenuButtonFrame:Hide()
end

--[[--------------------------------------------------------------------------
  Initialize Bindings List
-----------------------------------------------------------------------------]]

function myBindings2:SetGameBindings()
	-- This is just a reference list to check later which bindings are part of the
	-- standard game controls.
	self.gameBindings[BINDING_HEADER_ACTIONBAR]		 = 1
	self.gameBindings[BINDING_HEADER_CAMERA]		 = 1
	self.gameBindings[BINDING_HEADER_CHAT]			 = 1
	self.gameBindings[BINDING_HEADER_INTERFACE]		 = 1
	self.gameBindings[BINDING_HEADER_MISC]			 = 1
	self.gameBindings[BINDING_HEADER_MOVEMENT]		 = 1
	self.gameBindings[BINDING_HEADER_TARGETING]		 = 1
	self.gameBindings[BINDING_HEADER_MULTIACTIONBAR] = 1
	self.gameBindings[BINDING_HEADER_BLANK]			 = 1
	self.gameBindings[BINDING_HEADER_BLANK2]		 = 1
	self.gameBindings[BINDING_HEADER_BLANK3]		 = 1
end

function myBindings2:ParseBindings()
    local categories  = {}
    local commandName, binding1, binding2, header, addOnCat
    
    self.menuHeaders		= {}
    self.bindingIndexes		= {}
    self.expandedCategories	= {}
    
    for index = 1, GetNumBindings(), 1 do
        commandName, binding1, binding2 = GetBinding(index)
        
        if string.sub(commandName, 1, 6) == "HEADER" then
            header = _G["BINDING_"..commandName]
            if (header or "") == "" then 
                header = string.sub(commandName, 8) 
            end
            
            self.bindingIndexes[header] = {}
            
            -- Add to appropriate category
            if self.gameBindings[header] then
                if not categories[L["Standard Interface"]] then
                    categories[L["Standard Interface"]] = {}
                end
                table.insert(categories[L["Standard Interface"]], header)
            else
                local subName = string.sub(commandName, 8)
                local catName = self:GetCat(subName) or _G["BINDING_CATEGORY_"..string.upper(subName)]
				or GetAddOnMetadata(subName, "X-Category") or "Miscellaneous"
                addOnCat = X_CATEGORIES[catName] or X_CATEGORIES["Miscellaneous"]
                self:LevelDebug(2, "subName : "..subName)
                self:LevelDebug(2, "catName : "..catName)
                if not categories[addOnCat] then 
                    categories[addOnCat] = {}
                end
                table.insert(categories[addOnCat], header)
            end
        elseif header then
            -- Need to save the index so it can be used later to reference this command
            -- in the API's bindings list.
            table.insert(self.bindingIndexes[header], index)
        end
    end
    
    -- Now place all the sorted categories and headers into one list for easy
    -- display later on.
    for index, category in self.categoriesSort do
        if categories[category] then
            table.sort(categories[category])
            table.insert(self.menuHeaders, {text = category, isCategory = true})
            for i, header in categories[category] do
                table.insert(self.menuHeaders, {text = header, category = category})
            end
        end
    end
end

--[[--------------------------------------------------------------------------
  Dialog Handling Methods
-----------------------------------------------------------------------------]]

function myBindings2:HeadingsUpdate()
	local numHeaders = table.getn(self.menuHeaders)
	local offset	 = FauxScrollFrame_GetOffset(myBindings2OptionsHeadingsScrollFrame)
	local hdrinx	 = 0
	local visible	 = 0
	local line		 = 0
	local header, menuItem, button
	
	local bindCategory = "myBindings2OptionsBindCategory"
	local bindHeader = "myBindings2OptionsBindHeader"
	
	-- In case we were waiting for a key bind confirmation, cancel it.
	self:CancelKeyBind()
	
	-- create category buttons
	if self.categoryButton == nil then
		self.categoryButton = self:CreateCategoryButton(bindCategory.."1", self.frame, self.frame, "TOPLEFT", "TOPLEFT", 18, -54)
	end
	
	-- create binding headers
	if self.bindingHeader == nil then
		self.bindingHeader = self:CreateBindingHeader(bindHeader.."1", self.frame, self.frame, "TOPLEFT", "TOPLEFT", 18, -54)
	end

	-- Browse the lines
	while line < self.maxMenuLines do
		local bCategory = _G[bindCategory..line+1]
		local bBindings = _G[bindHeader..line+1]
		if  bCategory == nil then
			bCategory = self:CreateCategoryButton(bindCategory..line+1, self.frame, _G[bindCategory..line], "TOPLEFT", "BOTTOMLEFT", 0, 0)
		end
		if bBindings == nil then
			bBindings = self:CreateBindingHeader(bindHeader..line+1, self.frame, _G[bindHeader..line], "TOPLEFT", "BOTTOMLEFT", 0, 0)
		end
		
		if ((offset + line) <= numHeaders) and (hdrinx < numHeaders) then
			hdrinx	= hdrinx + 1
			header = self.menuHeaders[hdrinx]
			
			if header.isCategory then
				visible = visible + 1
				if( visible > offset ) then
					line = line + 1
					_G[bindCategory..line.."NormalText"]:SetText(header.text)
					--_G[bindCategory..line.."HighlightText"]:SetText(header.text)
					_G[bindCategory..line]:Show()
					_G[bindHeader..line]:Hide()
				end
			elseif self.expandedCategories[header.category] then
				visible = visible + 1
				if( visible > offset ) then
					line = line + 1
					menuItem = _G[bindHeader..line]
					button = _G[bindHeader..line.."Button"]
					
					_G[bindHeader..line.."ButtonNormalText"]:SetText(header.text)
					--_G[bindHeader..line.."ButtonHighlightText"]:SetText(header.text)
					_G[bindCategory..line]:Hide()
					menuItem:Show()
					
					if self.currentMenuSelection == header.text then
						myBindings2OptionsFrameBindingsTitle:SetText(header.text)
						menuItem:SetBackdropBorderColor(.9, .9, 0)
						menuItem:SetBackdropColor(1.0, 1.0, 0.5)
						button:LockHighlight()
					else
						menuItem:SetBackdropBorderColor(0.4, 0.4, 0.4)
						menuItem:SetBackdropColor(0.15, 0.15, 0.15)
						button:UnlockHighlight()
					end
					
					self.frame.highlightID = self.frame:GetParent():GetID()
				end
			end
		else
			line = line + 1
			_G[bindCategory..line]:Hide()
			_G[bindHeader..line]:Hide()
		end
	end
	
	FauxScrollFrame_Update(myBindings2OptionsHeadingsScrollFrame,
		self:GetMenuNumVisible(),
		self.maxMenuLines,
		self.maxMenuLineHeight
	)
end

function myBindings2:ExpandCollapseHeadings(val)
	for index, header in self.menuHeaders do
		if header.isCategory then
			self.expandedCategories[header.text] = val
		end
	end
end

function myBindings2:GetMenuNumVisible()
	local numVisible = 0

	for index = 1, table.getn(self.menuHeaders), 1 do
		if( self.menuHeaders[index].isCategory ) then
			numVisible = numVisible + 1
		elseif( self.expandedCategories[self.menuHeaders[index].category] ) then
			numVisible = numVisible + 1
		end
	end

	return numVisible
end

function myBindings2:CategoryOnClick(text)
	self.expandedCategories[text] = not self.expandedCategories[text]
	self:HeadingsUpdate()
end

function myBindings2:HeaderOnClick(text)
	self.currentMenuSelection = text
	self:HeadingsUpdate()
	self:BindingsUpdate()
end

--[[--------------------------------------------------------------------------
  Bindings ScrollFrame Methods
-----------------------------------------------------------------------------]]

-- Copied from Blizzard's UI as a temporary fix for game patch 1800. Since the
-- default key binding frame is no longer loaded at start, this function is
-- not available if the default key bind frame is never opened, which it probably
-- never is if someone is using myBindings. 10/11/2005
function KeyBindingFrame_GetLocalizedName(name, prefix)
	if not name then
		return "";
	end
	
	local tempName = name;
	local i = strfind(name, "-");
	local dashIndex = nil;
	
	while i do
		if not dashIndex then
			dashIndex = i;
		else
			dashIndex = dashIndex + i;
		end
		tempName = string.sub(tempName, i + 1);
		i = strfind(tempName, "-");
	end

	local modKeys = '';
	if not dashIndex then
		dashIndex = 0;
	else
		modKeys = string.sub(name, 1, dashIndex);
		if GetLocale() == "deDE" then
			modKeys = gsub(modKeys, "CTRL", "STRG");
		end
	end

	local variablePrefix = prefix;
	if not variablePrefix then
		variablePrefix = "";
	end
	
	local localizedName = nil;
	if IsMacClient() then
		-- see if there is a mac specific name for the key
		localizedName = getglobal(variablePrefix..tempName.."_MAC");
	end
	if not localizedName then
		localizedName = getglobal(variablePrefix..tempName);
	end
	if not localizedName then
		localizedName = tempName;
	end
	
	return modKeys..localizedName;
end

function myBindings2:BindingsUpdate()
    local header = self.currentMenuSelection
    local indexes = self.bindingIndexes[header]
    local scrollOffset = FauxScrollFrame_GetOffset(myBindings2OptionsBindingsScrollFrame)
    local bindLine, commandName, numCommands, keyOffset
    local keyBindingButton1, keyBindingButton2, keyBindingDescription
    
    -- In case we were waiting for a key bind confirmation, cancel it.
    if not myBindings2OptionsBindingsScrollFrame.buttonPressed then
        self:CancelKeyBind()
    end
    
    if indexes then
        numCommands = table.getn(indexes)
    else
        numCommands = 0
    end
    
    -- Browse the lines
    for line = 1, self.maxBindingLines, 1 do
        keyOffset = scrollOffset + line
        
        -- create BindingLine
        local bindingLine = "myBindings2OptionsBindingLine"
        bindLine = _G[bindingLine..line]
        if bindLine == nil then
            if line == 1 then
                self:CreateBindLine(bindingLine..line, self.frame, self.frame, "TOPLEFT", "TOPLEFT", 222, -56)
            else
                self:CreateBindLine(bindingLine..line, self.frame, _G[bindingLine..(line-1)], "TOPLEFT", "BOTTOMLEFT", 0, 2)
            end
        end
        
        keyBindingButton1 = _G[bindingLine..line.."Key1Button"]
        keyBindingButton2 = _G[bindingLine..line.."Key2Button"]
        
        if keyOffset <= numCommands then
            bindLine = _G[bindingLine..line]
            commandName, binding1, binding2 = GetBinding(self.bindingIndexes[header][keyOffset])
            
            keyBindingLabel = _G[bindingLine..line.."Label"]
            
            keyBindingLabel:SetText(KeyBindingFrame_GetLocalizedName(commandName, "BINDING_NAME_"))
            
            if binding1 then
                keyBindingButton1:SetText(
                    KeyBindingFrame_GetLocalizedName(binding1, "KEY_")
                )
                keyBindingButton1:SetAlpha(1)
            else
                keyBindingButton1:SetText(NORMAL_FONT_COLOR_CODE..NOT_BOUND..FONT_COLOR_CODE_CLOSE)
                keyBindingButton1:SetAlpha(0.8)
            end
            
            if binding2 then
                keyBindingButton2:SetText(
                    KeyBindingFrame_GetLocalizedName(binding2, "KEY_")
                )
                keyBindingButton2:SetAlpha(1)
            else
                keyBindingButton2:SetText(NORMAL_FONT_COLOR_CODE..NOT_BOUND..FONT_COLOR_CODE_CLOSE)
                keyBindingButton2:SetAlpha(0.8)
            end
            
            if myBindings2OptionsBindingsScrollFrame.selected == commandName then
                if myBindings2OptionsBindingsScrollFrame.keyID == 1 then
                    keyBindingButton1:LockHighlight()
                    keyBindingButton2:UnlockHighlight()
                else
                    keyBindingButton2:LockHighlight()
                    keyBindingButton1:UnlockHighlight()
                end
            else
                keyBindingButton1:UnlockHighlight()
                keyBindingButton2:UnlockHighlight()
            end
            
            keyBindingButton1.commandName = commandName
            keyBindingButton2.commandName = commandName
            
            bindLine:Show()
        else
            bindLine = _G[bindingLine..line]
            keyBindingButton1.commandName = nil
            keyBindingButton2.commandName = nil
            bindLine:Hide()
        end
    end
    
    FauxScrollFrame_Update(myBindings2OptionsBindingsScrollFrame,
        numCommands,
        self.maxBindingLines,
        self.maxBindingLineHeight
    )
end

function myBindings2:DeselectButton()
	myBindings2OptionsFrameOutputText:SetText("")
	myBindings2OptionsBindingsScrollFrame.selected = nil
	myBindings2OptionsBindingsScrollFrame.buttonPressed = nil
	myBindings2OptionsBindingsScrollFrame.keyID = nil
	self:BindingsUpdate()
end

function myBindings2:BindingOnClick(key)
    self:LevelDebug(2, "BindingOnClick")
    if myBindings2OptionsBindingsScrollFrame.buttonPressed == this then
        -- Code to be able to deselect or select another key to bind
        if key == "LeftButton" or key == "RightButton" then
            -- Deselect button if it was the pressed previously pressed
            self:DeselectButton()
        else
            self:OnKeyDown(key)
        end
    else
        myBindings2OptionsFrameUnbindButton:Enable()
        myBindings2OptionsBindingsScrollFrame.selected = this.commandName
        myBindings2OptionsBindingsScrollFrame.buttonPressed = this
        myBindings2OptionsBindingsScrollFrame.keyID	= this:GetID()
        myBindings2OptionsFrameOutputText:SetText(
        	format(BIND_KEY_TO_COMMAND, KeyBindingFrame_GetLocalizedName(this.commandName, "BINDING_NAME_"))
       	)
        self:BindingsUpdate()
    end
end

function myBindings2:OnKeyDown(button)
    self:LevelDebug(2, "OnKeyDown : "..button)
    if arg1 == "PRINTSCREEN" then
        Screenshot()
        return
    end
    
    -- Convert the mouse button names
    if button == "LeftButton" then
        button = "BUTTON1"
    elseif button == "RightButton" then
        button = "BUTTON2"
    elseif button == "MiddleButton" then
        button = "BUTTON3"
    elseif button == "Button4" then
        button = "BUTTON4"
    elseif button == "Button5" then
        button = "BUTTON5"
    end
    
    if myBindings2OptionsBindingsScrollFrame.selected then
        local keyPressed = arg1
        
        if button then
            if button == "BUTTON1" or button == "BUTTON2" then
                return
            end
            keyPressed = button
        else
            keyPressed = arg1
        end
        
        if keyPressed == "UNKNOWN" then
            return
        end
        
        if keyPressed == "SHIFT" or keyPressed == "CTRL" or keyPressed == "ALT" then
            return
        end
        if IsShiftKeyDown() then
            keyPressed = "SHIFT-"..keyPressed
        end
        if IsControlKeyDown() then
            keyPressed = "CTRL-"..keyPressed
        end
        if IsAltKeyDown() then
            keyPressed = "ALT-"..keyPressed
        end
        
        local oldAction = GetBindingAction(keyPressed)
        if (oldAction ~= "") and (oldAction ~= myBindings2OptionsBindingsScrollFrame.selected) then
            local key1, key2 = GetBindingKey(oldAction)
            if (not key1 or key1 == keyPressed) and ((not key2) or (key2 == keyPressed)) then
                --Error message
                myBindings2OptionsFrameOutputText:SetText(
                	format(L["|cffff0000%s is already bound to %s. Confirm replacement.|r"], keyPressed, KeyBindingFrame_GetLocalizedName(oldAction, "BINDING_NAME_"))
               	)
                self.confirmKeyBind = true
            end
        end
        
        if self.confirmKeyBind then
            myBindings2OptionsFrameConfirmBindButton:Show()
            myBindings2OptionsFrameConfirmBindButton.keyPressed = keyPressed
            myBindings2OptionsFrameCancelBindButton:Show()
        else
            self:BindKey(keyPressed)
        end
        
	self.bindingsChanged = 1;
    else
        if arg1 == "ESCAPE" then
            LoadBindings(GetCurrentBindingSet())
            myBindings2OptionsFrameOutputText:SetText("")
            myBindings2OptionsBindingsScrollFrame.selected = nil
            PlaySound("gsTitleOptionExit")
            HideUIPanel(this)
        end
    end
end

function myBindings2:BindKey(keyPressed)
    local key1, key2 = GetBindingKey(myBindings2OptionsBindingsScrollFrame.selected)
    
    if key1 then SetBinding(key1); end
    if key2 then SetBinding(key2); end
    
    if myBindings2OptionsBindingsScrollFrame.keyID == 1 then
        self:SetBinding(keyPressed, myBindings2OptionsBindingsScrollFrame.selected, key1)
        if key2 then
            SetBinding(key2, myBindings2OptionsBindingsScrollFrame.selected)
        end
    else
        if key1 then
            self:SetBinding(key1, myBindings2OptionsBindingsScrollFrame.selected)
        end
        self:SetBinding(keyPressed, myBindings2OptionsBindingsScrollFrame.selected, key2)
    end
    
    myBindings2OptionsBindingsScrollFrame.selected = nil
    myBindings2OptionsBindingsScrollFrame.buttonPressed = nil
    self:BindingsUpdate()
    myBindings2OptionsFrameOutputText:SetText(KEY_BOUND)
end

function myBindings2:SetBinding(key, selectedBinding, oldKey)
    if SetBinding(key, selectedBinding) then
        return
    else
        if oldKey then
            SetBinding(oldKey, selectedBinding)
        end
        --Error message
        myBindings2OptionsFrameOutputText:SetText(L["Can't bind mousewheel to actions with up and down states"])
    end
end

function myBindings2:ConfirmKeyBind()
	self:BindKey(this.keyPressed)
end

function myBindings2:CancelKeyBind()
	self.confirmKeyBind = false

	-- Button highlighting stuff
	myBindings2OptionsBindingsScrollFrame.selected = nil
	if( myBindings2OptionsBindingsScrollFrame.buttonPressed ) then
		myBindings2OptionsBindingsScrollFrame.buttonPressed:UnlockHighlight()
		myBindings2OptionsBindingsScrollFrame.buttonPressed = nil
	end

	myBindings2OptionsFrameConfirmBindButton:Hide()
	myBindings2OptionsFrameConfirmBindButton.keyPressed = nil
	myBindings2OptionsFrameCancelBindButton:Hide()
	myBindings2OptionsFrameUnbindButton:Disable()
	myBindings2OptionsFrameOutputText:SetText("")
end

function myBindings2:UnbindKey()
    if not myBindings2OptionsBindingsScrollFrame.selected then return end
    
    local key1, key2 = GetBindingKey(myBindings2OptionsBindingsScrollFrame.selected)
    
    if myBindings2OptionsBindingsScrollFrame.keyID == 1 then
        if key1 then 
            SetBinding(key1) 
        end
        if key2 then
            SetBinding(key2, myBindings2OptionsBindingsScrollFrame.selected)
        end
    elseif key2 then 
        SetBinding(key2)
    end
    
    self:CancelKeyBind()
    self:BindingsUpdate()
end

--[[--------------------------------------------------------------------------
  Binding Methods
-----------------------------------------------------------------------------]]

function myBindings2:LoadGameDefaultBindings()
	LoadBindings(DEFAULT_BINDINGS)
	self:BindingsUpdate()
end

function myBindings2:LoadBindings()
	-- If there's no binding set in the current profile, don't do anything or this
	-- will wipe out all settings, leaving mouse-control of the game only.
	--if not self:GetBind() then return end
	if table.getn(self:GetBind()) == 0 then return end

	local commandName, binding1, binding2, command

	for index = 1, GetNumBindings(), 1 do
		commandName, binding1, binding2 = GetBinding(index)

		-- I don't know why, but if the bindings aren't first erased, then attempting
		-- to overwrite the values from the stored values will wipe out all the second
		-- key bindings. They need clearing anyway in case the stored binding set
		-- doesn't have values, meaning these bindings should be empty.
		if binding1 then SetBinding(binding1) end
		if binding2 then SetBinding(binding2) end

		command = self:GetBind(commandName)
		if command then
			if command.bind1 then SetBinding(command.bind1, commandName, binding1) end
			if command.bind2 then SetBinding(command.bind2, commandName, binding2) end
		end
	end

	SaveBindings(GetCurrentBindingSet())
	self:BindingsUpdate()
end

function myBindings2:SaveBindings()
	if myBindings2CharacterButton:GetChecked() then
		self.which = CHARACTER_BINDINGS;
	else
		self.which = ACCOUNT_BINDINGS;
		if GetCurrentBindingSet() == CHARACTER_BINDINGS then
			if not MYBINDING2_CONFIRMED_DELETING_CHARACTER_SPECIFIC_BINDINGS then
				StaticPopup_Show("MYBINDING2_CONFIRM_DELETING_CHARACTER_SPECIFIC_BINDINGS");
				return;
			end
		end
	end
    
	-- Save the bindings in the system first.
	SaveBindings(self.which);

	local commandName, binding1, binding2

	-- Empty the stored bindings first.
	self:ClearBinds()

	for index = 1, GetNumBindings(), 1 do
		commandName, binding1, binding2 = GetBinding(index)
		local key1, key2 = GetBindingKey(commandName)
		-- Don't save empty bindings
		if binding1 or binding2 then
			self:SetBind(commandName, {bind1 = binding1, bind2 = binding2})
		end
	end

	self:CloseInterface()
end

--[[--------------------------------------------------------------------------
  Display Methods
-----------------------------------------------------------------------------]]

function myBindings2:UpdateLoadedLabel()
	if myBindings2CharacterButton:GetChecked() then
		myBindings2OptionsFrameBindingsLoadedLabel:SetText(format(CHARACTER_KEY_BINDINGS, UnitName("player")));
	else
		myBindings2OptionsFrameBindingsLoadedLabel:SetText(KEY_BINDINGS);
	end
end

function myBindings2:OpenInterface()
	if( self.disabled ) then return; end

	if( not self.frame:IsVisible() ) then
		ShowUIPanel(self.frame)
		self.dontOpenGameMenu = true
		self:HeadingsUpdate()
		self:BindingsUpdate()
	end
end

function myBindings2:CloseInterface()
	myBindings2OptionsBindingsScrollFrame.selected = nil
	HideUIPanel(self.frame)
end

function myBindings2:OnShow()
	self.bindingsChanged = nil;
	myBindings2CharacterButton:SetChecked(GetCurrentBindingSet() == 2);
	self:UpdateLoadedLabel()
    
	self:HeadingsUpdate()
	self:BindingsUpdate()
	
	-- apply oSkin
	self:applySkin()
end

function myBindings2:OnHide()
	self:CancelKeyBind()

	-- Check if it's currently showing an options frame or the myAddOns options frame.
	if (not MYADDONS_ACTIVE_OPTIONSFRAME) 
        and (not self.dontOpenGameMenu) 
        and ((not myAddOnsFrame) or (not myAddOnsFrame:IsVisible())) then
		ShowUIPanel(GameMenuFrame)
	-- Check if the options frame was opened by myAddOns
	elseif MYADDONS_ACTIVE_OPTIONSFRAME == this then
		ShowUIPanel(myAddOnsFrame)
	end

	self.dontOpenGameMenu = false
end

--[[--------------------------------------------------------------------------
  Chat Handlers
-----------------------------------------------------------------------------]]

function myBindings2:SetCategory(opt)
	--local header, cat = unpack(ace.ParseWords(opt))
	local _, _, header, cat = string.find(opt, "(.+) (.*)")

	if (not header) or (not cat) then
		self.Error("You have entered invalid options.")
		return
	elseif not X_CATEGORIES[cat] then
		self.Error("%s is not a valid category.", cat)
		return
	end

	local try, valid = _G["BINDING_HEADER_"..header]
	if try then
		valid = header
	else
		try = _G["BINDING_HEADER_"..string.lower(header)]
		if try then
			valid = string.lower(header)
		else
			try = _G["BINDING_HEADER_"..string.upper(header)]
			if try then
				valid = string.upper(header)
			else
				self.Error("%s does not seem to be a valid header to categorize. Be sure you enter the exact case and spelling.", header)
				return
			end
		end
	end

	self:SetCat(valid, cat)
	self:ParseBindings()
	self.Msg("Key header %s will now appear in the %s category.", valid, X_CATEGORIES[cat])
end

function myBindings2:SetBindOpt(opt)
	local oldaction = nil
	--local key, action = unpack(ace.ParseWords(opt))
	local _, _, key, action = string.find(opt, "(.+) (.*)")
	
	key = string.upper(key)
	-- Attempt to clear the binding. If this is an invalid key, it'll fail.
	oldaction = GetBindingAction(key)
	if not SetBinding(key, nil) then
		if not SetBinding(key, oldaction) then
			self.Msg("Error - " .. key .. " is not a valid key!")
		end
	elseif action then
		if SetBinding(key, action) then
			self.Msg("Key " .. key .. " successfully bound to action " .. action .. ".")
		else
			self.Msg("Action " .. action .. " is not valid!")
			SetBinding(key, oldaction)
		end
	else
		self.Msg("Key " .. key .. " cleared.")
	end
end

function myBindings2:ChangeBindingProfile()
	if myBindings2CharacterButton:GetChecked() then
		LoadBindings(CHARACTER_BINDINGS);
	else
		LoadBindings(ACCOUNT_BINDINGS);
	end
	
	self:UpdateLoadedLabel()
	myBindings2OptionsFrameOutputText:SetText("");
	self:BindingsUpdate()
end

--[[--------------------------------------------------------------------------
  Frame Functions
-----------------------------------------------------------------------------]]

function myBindings2:CreateGameMenuButtonFrame()
	local b_gamemenu = CreateFrame("Button", "myBindings2GameMenuButton", GameMenuFrame, "GameMenuButtonTemplate")
	
	b_gamemenu:SetPoint("TOP", GameMenuButtonUIOptions, "BOTTOM", 0, -1)
	--b_gamemenu:SetScript("OnLoad", function()
		if myAddOnsFrame then
			myGameMenuButtonAddOns:SetPoint("TOP", b_gamemenu:GetName(), "BOTTOM", 0, -1)
		else
			GameMenuButtonMacros:SetPoint("TOP", b_gamemenu:GetName(), "BOTTOM", 0, -1)
		end
	--end)
	b_gamemenu:SetScript("OnClick", function()
		PlaySound("igMainMenuOption");
		ShowUIPanel(myBindings2OptionsFrame);
	end)
	b_gamemenu:SetText(KEY_BINDINGS)
	
	return b_gamemenu
end

function myBindings2:CreateOptionsFrame()
	local f = CreateFrame("Frame", "myBindings2OptionsFrame", UIParent)
	f:SetFrameStrata("DIALOG")
	f:SetToplevel(true)
	f:SetWidth(796)
	f:SetHeight(518)
	f:SetPoint("CENTER", UIParent) --Center it on the screen.

	--MOUSE
	f:EnableMouse(true)
	f:SetMovable(true)
	f:RegisterForDrag("LeftButton")
	
	--KEYBOARD
	f:EnableKeyboard(true)
	
	--SCRIPT
	f:SetScript("OnShow", function()
		myBindings2:OnShow()
	end)
	f:SetScript("OnHide", function()
    	myBindings2OptionsFrameOutputText:SetText("")
		myBindings2:OnHide()
	end)
	f:SetScript("OnDragStart", function()
		this:StartMoving()
	end)
	f:SetScript("OnDragStop", function()
		this:StopMovingOrSizing()
	end)
	f:SetScript("OnKeyDown", function()
		myBindings2:OnKeyDown(arg1)
	end)
	f:SetScript("OnMouseWheel", function()
		return
	end)
	
    -- BACKGROUND TOP
	local top_l, top_t, top_r = f:CreateTexture(), f:CreateTexture(), f:CreateTexture()
	top_l:SetTexture("Interface\\KeyBindingFrame\\UI-KeyBindingFrame-TopLeft")
	top_l:SetWidth(256); top_l:SetHeight(258)
	top_l:SetPoint("TOPLEFT", f, nil)
	
	top_t:SetTexture("Interface\\KeyBindingFrame\\UI-KeyBindingFrame-Top")
	top_t:SetWidth(452); top_t:SetHeight(258)
	top_t:SetPoint("TOPLEFT", f, "TOPLEFT", 256, 0);
	
	top_r:SetTexture("Interface\\KeyBindingFrame\\UI-KeyBindingFrame-TopRight")
	top_r:SetWidth(128); top_r:SetHeight(258)
	top_r:SetPoint("TOPRIGHT", f, "TOPRIGHT", 40, 0);
	
	-- BACKGROUND BOTTOM
	local bot_l, bot_t, bot_r = f:CreateTexture(), f:CreateTexture(), f:CreateTexture()
	bot_l:SetTexture("Interface\\KeyBindingFrame\\UI-KeyBindingFrame-BotLeft")
	bot_l:SetWidth(256); bot_l:SetHeight(260)
	bot_l:SetPoint("BOTTOMLEFT", f, nil)
	
	bot_t:SetTexture("Interface\\KeyBindingFrame\\UI-KeyBindingFrame-Bot")
	bot_t:SetWidth(452); bot_t:SetHeight(260)
	bot_t:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", 256, 0);
	
	bot_r:SetTexture("Interface\\KeyBindingFrame\\UI-KeyBindingFrame-BotRight")
	bot_r:SetWidth(128); bot_r:SetHeight(260)
	bot_r:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", 40, 0);
	
	-- TEXTS
	local f_text1 = f:CreateFontString("myBindings2OptionsFrameBindingsLoadedLabel", nil, "GameFontNormal")
	f_text1:SetJustifyH("LEFT")
	f_text1:SetPoint("TOPLEFT", f, "TOPLEFT", 22, -17)
	f_text1:SetText("")
	
	local f_text2 = f:CreateFontString("myBindings2OptionsFrameMenuTitle", nil, "GameFontNormal")
	f_text2:SetPoint("TOPLEFT", f, "TOPLEFT", 22, -34)
	f_text2:SetText("Menu")
	
	local f_text3 = f:CreateFontString("myBindings2OptionsFrameBindingsTitle", nil, "GameFontNormal")
	f_text3:SetPoint("TOPLEFT", f, "TOPLEFT", 232, -34)
	f_text3:SetText("Title")
	
	local f_text4 = f:CreateFontString("myBindings2OptionsFrameKey1Title", nil, "GameFontNormal")
	f_text4:SetPoint("TOPRIGHT", f, "TOPRIGHT", -270, -34)
	f_text4:SetText("KEY1")
	
	local f_text5 = f:CreateFontString("myBindings2OptionsFrameKey2Title", nil, "GameFontNormal")
	f_text5:SetPoint("TOPRIGHT", f, "TOPRIGHT", -105, -34)
	f_text5:SetText("KEY2")
	
	local f_text6 = f:CreateFontString("myBindings2OptionsFrameOutputText", nil, "GameFontNormal")
	f_text6:SetPoint("BOTTOM", f, "BOTTOM", 0, 51)
	f_text6:SetText("Text")
	
	-- ARTWORK
	-- BUTTON
	local button = CreateFrame("Button", "myBindings2OptionsFrameExpandCollapseButton", f)
	button:SetWidth(16); button:SetHeight(16)
	button:SetPoint("LEFT", myBindings2OptionsFrameMenuTitle, "RIGHT", 6, -1)
	button:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up")
	
	--button:SetScript("OnLoad", function() 
	    button:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up") 
	--end)
	button:SetScript("OnClick", function() 
		self.expandAll = not self.expandAll
		
		if self.expandAll then
			button:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up")
		else
			button:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up")
		end
		
		myBindings2:ExpandCollapseHeadings(self.expandAll)
		myBindings2:HeadingsUpdate() 
	end)
	
	--SCROLL Headings
	local scrollHeadings = CreateFrame("ScrollFrame", "myBindings2OptionsHeadingsScrollFrame", f, "FauxScrollFrameTemplate")
	scrollHeadings:SetWidth(200); scrollHeadings:SetHeight(392)
	scrollHeadings:SetScript("OnVerticalScroll", function()
		FauxScrollFrame_OnVerticalScroll(22, function()
			myBindings2:HeadingsUpdate()
		end)
	end)
	scrollHeadings:SetScript("OnMouseWheel", function()
		ScrollFrameTemplate_OnMouseWheel(arg1)
	end)
	scrollHeadings:SetPoint("TOPLEFT", f, "TOPLEFT", 0, -57)
	
	--SCROLL Bindings
	local scrollBindings = CreateFrame("ScrollFrame", "myBindings2OptionsBindingsScrollFrame", f, "FauxScrollFrameTemplate")
	scrollBindings:SetWidth(517); scrollBindings:SetHeight(392)
	scrollBindings:SetScript("OnVerticalScroll", function()
		FauxScrollFrame_OnVerticalScroll(22, function()
			myBindings2:BindingsUpdate()
		end)
	end)
	scrollBindings:SetScript("OnMouseWheel", function()
        if self.selected then
            if arg1 > 0 then
                myBindings2:OnKeyDown("MOUSEWHEELUP")
            else
                myBindings2:OnKeyDown("MOUSEWHEELDOWN")
            end
        else
            ScrollFrameTemplate_OnMouseWheel(arg1)
        end
	end)
	scrollBindings:SetPoint("TOPLEFT", f, "TOPLEFT", 241, -54)
	
	self:CreateBottomButtons("myBindings2OptionsFrame", f)
	
	f:Hide()
	return f
end

function myBindings2:CreateCategoryButton(name, parent, relativeTo, point, relativePoint, x, y)
	local button = CreateFrame("Button", name, parent)
	button:SetWidth(185)
	button:SetHeight(22)
	button:SetPoint(point, relativeTo, relativePoint, x, y)
	
	local texture = button:CreateTexture()
	texture:SetTexture("Interface\\AuctionFrame\\UI-AuctionFrame-FilterBg")
	texture:SetWidth(185); texture:SetHeight(22)
	texture:SetPoint("TOPLEFT", button, nil)
	texture:SetTexCoord(0, 0.53125, 0 ,0.625)
	
	button:SetNormalTexture(texture)
	
	local normalText = button:CreateFontString(name.."NormalText", nil, "GameFontHighlightSmall")
	normalText:SetJustifyH("LEFT")
	normalText:SetPoint("LEFT", button, "LEFT", 8, 1)
	normalText:SetText("")
	
	local highlightText = button:CreateFontString(name.."HighlightText", nil, "GameFontNormalSmall")
	highlightText:SetJustifyH("LEFT")
	highlightText:SetPoint("LEFT", button, "LEFT", 8, 1)
	highlightText:SetText("")
	
	button:SetScript("OnClick", function() 
		myBindings2:CategoryOnClick(normalText:GetText()) 
	end)
	
	self:LevelDebug(3, "Created "..name.." (parent: "..parent:GetName()..")")
	return button
end

function myBindings2:CreateBindingHeader(name, parent, relativeTo, point, relativePoint, x, y)
	local f = CreateFrame("Frame", name, parent, "OptionFrameBoxTemplate")
	f:SetWidth(186)
	f:SetHeight(22)
	f:SetPoint(point, relativeTo, relativePoint, x, y)
	
	--SCRIPT
	--f:SetScript("OnLoad", function()
		f:SetBackdropBorderColor(0.4, 0.4, 0.4)
		f:SetBackdropColor(0.15, 0.15, 0.15)
	--end)
	
	local button = CreateFrame("Button", name.."Button", f)
	button:SetWidth(186); button:SetHeight(20)
	button:SetPoint("LEFT", f, "LEFT", 2, 0)
	
	local normalText = button:CreateFontString(name.."ButtonNormalText", nil, "GameFontHighlightSmall")
	normalText:SetJustifyH("LEFT")
	normalText:SetPoint("LEFT", button, "LEFT", 8, 1)
	normalText:SetText("")
	
	local highlightText = button:CreateFontString(name.."ButtonHighlightText", nil, "GameFontNormalSmall")
	highlightText:SetJustifyH("LEFT")
	highlightText:SetPoint("LEFT", button, "LEFT", 8, 1)
	highlightText:SetText("")
	
	button:SetScript("OnClick", function() 
		myBindings2:HeaderOnClick(normalText:GetText())
	end)
	
	self:LevelDebug(3, "Created "..name.." (parent: "..parent:GetName()..")")
	return f
end

function myBindings2:CreateBindLine(name, parent, relativeTo, point, relativePoint, x, y)
	local f = CreateFrame("Frame", name, parent)
	f:SetWidth(560)
	f:SetHeight(25)
	f:SetPoint(point, relativeTo, relativePoint, x, y)
	
	--BACKGROUND
	local text = f:CreateFontString(name.."Label", f, "GameFontNormalSmall")
	text:SetJustifyH("LEFT")
	text:SetWidth(170)
	text:SetHeight(24)
	text:SetPoint("LEFT", f, nil, 12, 0)
	text:SetText("")
	
	--BUTTON
	local bKey1 = CreateFrame("Button", name.."Key1Button", f, "UIPanelButtonTemplate2")
	bKey1:SetID(1)
	bKey1:SetWidth(165); bKey1:SetHeight(22)
	bKey1:SetPoint("LEFT", f, "LEFT", 204, 0)
	bKey1:SetTextFontObject(GameFontHighlightSmall)
	bKey1:SetHighlightFontObject(GameFontHighlightSmall) 
	bKey1:SetDisabledFontObject(GameFontDisable)
	bKey1:SetScript("OnClick", function() 
		myBindings2:BindingOnClick(arg1)
	end)
	--bKey1:SetScript("OnLoad", function() 
		bKey1:RegisterForClicks("LeftButtonUp", "RightButtonUp", "MiddleButtonUp", "Button4Up", "Button5Up")
	--end)
	
	local bKey2 = CreateFrame("Button", name.."Key2Button", f, "UIPanelButtonTemplate2")
	bKey2:SetID(2)
	bKey2:SetWidth(165); bKey2:SetHeight(22)
	bKey2:SetPoint("LEFT", bKey1, "RIGHT", 0, 0)
	bKey2:SetTextFontObject(GameFontHighlightSmall)
	bKey2:SetHighlightFontObject(GameFontHighlightSmall) 
	bKey2:SetDisabledFontObject(GameFontDisable)
	bKey2:SetScript("OnClick", function() 
		myBindings2:BindingOnClick(arg1)
	end)
	--bKey2:SetScript("OnLoad", function() 
		bKey2:RegisterForClicks("LeftButtonUp", "RightButtonUp", "MiddleButtonUp", "Button4Up", "Button5Up")
	--end)
	
	self:LevelDebug(3, "Created "..name.." (parent: "..parent:GetName()..")")
	return f
end

function myBindings2:CreateBottomButtons(name, parent)

    --BUTTONS
    local bCoGameDefaults = CreateFrame("Button", name.."GameDefaultsButton", parent, "UIPanelButtonTemplate")
	bCoGameDefaults:SetText(L["Game Defaults"])
	bCoGameDefaults:SetWidth(130); bCoGameDefaults:SetHeight(22)
	bCoGameDefaults:SetPoint("BOTTOMLEFT", parent, "BOTTOMLEFT", 10, 21)
	bCoGameDefaults:SetScript("OnShow", function() 
		this:UnlockHighlight()
	end)
	bCoGameDefaults:SetScript("OnClick", function() 
		myBindings2:LoadGameDefaultBindings()
	end)
	
	local bOkay = CreateFrame("Button", name.."OkayButton", parent, "UIPanelButtonTemplate")
	bOkay:SetText(L["Save"])
	bOkay:SetWidth(100); bOkay:SetHeight(22)
	bOkay:SetPoint("BOTTOMRIGHT", parent, "BOTTOMRIGHT", -111, 21)
	bOkay:SetScript("OnClick", function() 
		myBindings2:SaveBindings()
	end)
	
	local bCancel = CreateFrame("Button", name.."CancelButton", parent, "UIPanelButtonTemplate")
	bCancel:SetText(L["Cancel"])
	bCancel:SetWidth(100); bCancel:SetHeight(22)
	bCancel:SetPoint("BOTTOMRIGHT", parent, "BOTTOMRIGHT", -11, 21)
	bCancel:SetScript("OnClick", function() 
		PlaySound("gsTitleOptionExit")
		LoadBindings(GetCurrentBindingSet())
		myBindings2:CloseInterface()
	end)
	
	local bConfirm = CreateFrame("Button", name.."ConfirmBindButton", parent, "UIPanelButtonTemplate")
	bConfirm:SetText(L["Confirm"])
	bConfirm:SetWidth(100); bConfirm:SetHeight(22)
	bConfirm:SetPoint("BOTTOM", parent, "BOTTOM", -130, 21)
	bConfirm:SetScript("OnClick", function() 
		myBindings2:ConfirmKeyBind()
	end)
	bConfirm:Hide()
	
	local bCancelBind = CreateFrame("Button", name.."CancelBindButton", parent, "UIPanelButtonTemplate")
	bCancelBind:SetText(L["Cancel"])
	bCancelBind:SetWidth(100); bCancelBind:SetHeight(22)
	bCancelBind:SetPoint("BOTTOM", parent, "BOTTOM", -30, 21)
	bCancelBind:SetScript("OnClick", function() 
		myBindings2:CancelKeyBind()
	end)
	bCancelBind:Hide()
	
	local bUnbind = CreateFrame("Button", name.."UnbindButton", parent, "UIPanelButtonTemplate")
	bUnbind:SetText(L["Unbind"])
	bUnbind:SetWidth(100); bUnbind:SetHeight(22)
	bUnbind:SetPoint("BOTTOM", parent, "BOTTOM", -211, 21)
	bUnbind:SetScript("OnClick", function() 
		myBindings2:UnbindKey()
	end)
    
	--CHARATER Button
	local characterButton = CreateFrame("CheckButton", "myBindings2CharacterButton", parent, "UICheckButtonTemplate")
	characterButton:SetWidth(20)
	characterButton:SetHeight(20)
	characterButton:SetPoint("TOPRIGHT", parent, "TOPRIGHT", -20, -12)
	characterButton:SetScript("OnClick", function()
        if myBindings2.bindingsChanged then
            StaticPopup_Show("MYBINDING2_CONFIRM_LOSE_BINDING_CHANGES");
        else
            myBindings2:ChangeBindingProfile();
        end
	end)
	characterButton:SetScript("OnEnter", function()
	    GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
	    GameTooltip:SetText(CHARACTER_SPECIFIC_KEYBINDING_TOOLTIP, nil, nil, nil, nil, 1);
	end)
	characterButton:SetScript("OnLeave", function()
	    GameTooltip:Hide();
	end)
	
	return bCoGameDefaults
end

function myBindings2:applySkin()
    local skinObject
    
    if not self.applySkins then return end
    
    if IsAddOnLoaded("Skinner") then
        skinObject = Skinner
    elseif IsAddOnLoaded("oSkin") then
        skinObject = oSkin
    end
    
    if skinObject then
        if not skinObject.db.profile.MenuFrames then return end
        
        skinObject:keepRegions(_G["myBindings2OptionsFrame"], {7, 8, 9, 10, 11, 12, 14}) -- N.B. regions 7 - 12, 14 are text
        
        _G["myBindings2OptionsFrame"]:SetHeight(_G["myBindings2OptionsFrame"]:GetHeight() - 15)
        
        skinObject:removeRegions(_G["myBindings2OptionsHeadingsScrollFrame"])
        skinObject:skinScrollBar(_G["myBindings2OptionsHeadingsScrollFrame"])
        skinObject:removeRegions(_G["myBindings2OptionsBindingsScrollFrame"])
        skinObject:skinScrollBar(_G["myBindings2OptionsBindingsScrollFrame"])
        
        for i = 1, 18 do
            skinObject:removeRegions(_G["myBindings2OptionsBindCategory"..i], {1})
            skinObject:applySkin(_G["myBindings2OptionsBindCategory"..i])
        end
        for i = 1, 18 do
            skinObject:removeRegions(_G["myBindings2OptionsBindHeader"..i], {1})
            skinObject:applySkin(_G["myBindings2OptionsBindHeader"..i])
        end
        
        skinObject:moveObject(_G["myBindings2OptionsFrameOutputText"], nil, nil, "-", 15)
        skinObject:moveObject(_G["myBindings2OptionsFrameGameDefaultsButton"], nil, nil, "-", 15)
        skinObject:moveObject(_G["myBindings2OptionsFrameConfirmBindButton"], nil, nil, "-", 15)
        skinObject:moveObject(_G["myBindings2OptionsFrameCancelBindButton"], nil, nil, "-", 15)
        skinObject:moveObject(_G["myBindings2OptionsFrameUnbindButton"], nil, nil, "-", 15)
        skinObject:moveObject(_G["myBindings2OptionsFrameOkayButton"], nil, nil, "-", 15)
        skinObject:moveObject(_G["myBindings2OptionsFrameCancelButton"], nil, nil, "-", 15)
        
        skinObject:applySkin(_G["myBindings2OptionsFrame"], true)
        
        self.applySkins = false
    end
end

-- Data Management
function myBindings2:GetBind(val)
	if not val then
	    return self.db.realm.chars[UnitName("player")].bindings
	else
    	return self.db.realm.chars[UnitName("player")].bindings[val]
	end
end

function myBindings2:SetBind(var, val)
	self.db.realm.chars[UnitName("player")].bindings[var] = val
end

function myBindings2:ClearBinds()
	self.db.realm.chars[UnitName("player")].bindings = {}
end

function myBindings2:GetCat(var)
	return self.db.realm.chars[UnitName("player")].categories[var]
end

function myBindings2:SetCat(var, val)
	self.db.realm.chars[UnitName("player")].categories[var] = val
end

--[[
--function myBindings2:ACE_PROFILE_LOADED()
--	if( self.profilePath[2] == self.currentProfile ) then return end
--	self.currentProfile = self.profilePath[2]
--	self:LoadBindings(GetCurrentBindingSet())
--	self:UpdateLoadedLabel()
--end
--]]

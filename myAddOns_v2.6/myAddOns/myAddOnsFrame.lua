-- myAddOns v2.6 --


--------------------------------------------------------------------------------------------------
-- Global variables
--------------------------------------------------------------------------------------------------

MYREALM = GetRealmName();
MYCLASS = UnitClass("player");
MYCHARACTER = UnitName("player");
myAddOnsList = {};
myAddOnsAddOns = {};


--------------------------------------------------------------------------------------------------
-- Local variables
--------------------------------------------------------------------------------------------------

local myAddOnsTree = {};
local myAddOnsCategories = {};
local myAddOnsCharactersTree = {};


--------------------------------------------------------------------------------------------------
-- Popup Dialogs
--------------------------------------------------------------------------------------------------

StaticPopupDialogs["MYADDONS_ADDRESS_COPY"] = {
	text = TEXT(MYADDONS_ADDRESS_COPY),
	button1 = TEXT(OKAY),
	hasEditBox = 1,
	OnShow = function()
		getglobal(this:GetName().."Button1"):SetPoint("TOP", this:GetName().."EditBox", "BOTTOM", 0, -3);
		getglobal(this:GetName().."EditBox"):SetText(StaticPopupDialogs["MYADDONS_ADDRESS_COPY"].address);
		getglobal(this:GetName().."EditBox"):SetFocus();
		getglobal(this:GetName().."EditBox"):HighlightText(0, getglobal(this:GetName().."EditBox"):GetNumLetters());
	end,
	OnHide = function()
		getglobal(this:GetName().."EditBox"):SetText("");
	end,
	EditBoxOnEscapePressed = function ()
		this:GetParent():Hide();
	end,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = 1
};


--------------------------------------------------------------------------------------------------
-- Event functions
--------------------------------------------------------------------------------------------------

-- OnLoad event
function myAddOnsFrame_OnLoad()

	-- Register the events that need to be watched
	this:RegisterEvent("ADDON_LOADED");
	
	-- Register the frame in the UIPanelWindows table
	UIPanelWindows[this:GetName()] = {area = "doublewide", pushable = 0};
	
	-- Set the number of tabs for the frame
	PanelTemplates_SetNumTabs(this, 3);

end

-- OnEvent event
function myAddOnsFrame_OnEvent()

	-- Check the current event
	if (event == "ADDON_LOADED") then
		if (arg1 == "myAddOns") then
			-- Initialize the addon
			myAddOnsFrame_Initialize();
			-- Load the on demand addons
			myAddOnsFrame_AutomaticLoad();
		end
		if (myAddOnsAddOns[arg1] and getglobal(myAddOnsAddOns[arg1].helpVariable)) then
			local addon = myAddOnsAddOns[arg1];
			addon.help = getglobal(addon.helpVariable);
			addon.help.currentPage = 1;
			addon.helpVariable = nil;
		end
	end

end

-- OnShow event
function myAddOnsFrame_OnShow()

	-- Play the opening sound
	PlaySound("igCharacterInfoOpen");
	
	-- Register the addons using the v1.x registration method
	myAddOnsFrame_Register1x();
	
	-- Build the tree
	myAddOnsFrame_BuildTree();
	
	-- Update the display
	myAddOnsFrame_Update();

end

-- OnHide event
function myAddOnsFrame_OnHide()

	-- Play the closing sound
	PlaySound("igCharacterInfoClose");

end

-- Tab OnClick event
function myAddOnsFrameTab_OnClick(tab)

	-- Get the clicked tab
	if (not tab) then
		tab = this:GetID();
	end
	
	-- Set the selected tab
	PanelTemplates_SetTab(myAddOnsFrame, tab);
	
	-- Check if an addon is selected
	if (myAddOnsTree.selectedIndex ~= 0) then
		-- Check the selected tab
		if (tab == 1) then
			myAddOnsDetailsFrame:Show();
		else
			myAddOnsDetailsFrame:Hide();
		end
		if (tab == 2) then
			myAddOnsHelpFrame:Show();
		else
			myAddOnsHelpFrame:Hide();
		end
		if (tab == 3) then
			myAddOnsLoadFrame:Show();
		else
			myAddOnsLoadFrame:Hide();
		end
	else
		myAddOnsDetailsFrame:Hide();
		myAddOnsHelpFrame:Hide();
		myAddOnsLoadFrame:Hide();
	end

end

-- Button OnClick event
function myAddOnsFrameButton_OnClick()

	-- Get the index of the button that was clicked
	local index = myAddOnsFrame_GetIndex(this:GetID() + FauxScrollFrame_GetOffset(myAddOnsFrameScrollFrame));
	
	-- Check if the button is a category or an addon
	if (index ~= 0) then
		local category = myAddOnsCategories[myAddOnsTree[index]];
		if (category) then
			if (category.expanded) then
				category.expanded = nil;
			else
				category.expanded = 1;
			end
		else
			-- Set the selected addon
			myAddOnsTree.selectedIndex = index;
		end
		-- Update the display
		myAddOnsFrame_Update();
	end

end

-- Button OnEnter event
function myAddOnsFrameButton_OnEnter()

	-- Set the highlight color
	getglobal(this:GetName().."Name"):SetTextColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	
	-- Get the ID of the item that is highlighted
	local index = myAddOnsFrame_GetIndex(this:GetID() + FauxScrollFrame_GetOffset(myAddOnsFrameScrollFrame));
	
	-- Check if the item is an addon
	if (index ~= 0) then
		local item = myAddOnsTree[index];
		if (myAddOnsAddOns[item]) then
			local name, title, notes, enabled, loadable, reason, security = GetAddOnInfo(item);
			GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
			GameTooltip:SetText(HIGHLIGHT_FONT_COLOR_CODE..title..FONT_COLOR_CODE_CLOSE);
			GameTooltip:AddLine(notes);
			-- Check if the addon is loaded
			if (not IsAddOnLoaded(item)) then
				GameTooltip:AddLine(GRAY_FONT_COLOR_CODE..MYADDONS_NOT_LOADED..FONT_COLOR_CODE_CLOSE);
			end
			GameTooltip:Show();
		end
	end

end

-- Address copy button OnClick event
function myAddOnsDetailsFrameAddressCopyButton_OnClick()

	-- Get the ID of the address copy button
	local addressCopyButtonID = this:GetID();
	
	-- Get the addon
	local addon = myAddOnsAddOns[myAddOnsTree[myAddOnsTree.selectedIndex]];
	
	-- Get the address
	local address;
	if (addressCopyButtonID == 1) then
		address = addon.email;
	elseif (addressCopyButtonID == 2) then
		address = addon.website;
	end
	
	-- Shop the address copy window
	StaticPopupDialogs["MYADDONS_ADDRESS_COPY"].address = address;
	StaticPopup_Show("MYADDONS_ADDRESS_COPY");

end

-- Notes OnTextChanged event
function myAddOnsDetailsFrameNotesEditBox_OnTextChanged()

	-- Get the notes
	local notes = myAddOnsDetailsFrameNotesEditBox:GetText();
	
	-- Check if the notes are empty
	if (notes == "") then
		myAddOnsAddOns[myAddOnsTree[myAddOnsTree.selectedIndex]].notes = nil;
	else
		myAddOnsAddOns[myAddOnsTree[myAddOnsTree.selectedIndex]].notes = notes;
	end

end

-- Help previous page OnClick event
function myAddOnsHelpFramePrevPageButton_OnClick()

	-- Set the current page to previous page
	local help = myAddOnsAddOns[myAddOnsTree[myAddOnsTree.selectedIndex]].help;
	help.currentPage = help.currentPage - 1;
	
	-- Update the help
	myAddOnsHelpFrame_Update()

end

-- Help next page OnClick event
function myAddOnsHelpFrameNextPageButton_OnClick()

	-- Set the current page to next page
	local help = myAddOnsAddOns[myAddOnsTree[myAddOnsTree.selectedIndex]].help;
	help.currentPage = help.currentPage + 1;
	
	-- Update the help
	myAddOnsHelpFrame_Update();

end

-- Load method checkbutton OnClick event
function myAddOnsLoadOptionsFrameMethodCheckButton_OnClick()

	-- Check if the checkbutton is checked or not
	if (this:GetChecked()) then
		PlaySound("igMainMenuOptionCheckBoxOff");
	else
		PlaySound("igMainMenuOptionCheckBoxOn");
	end
	
	-- Set the load method
	myAddOnsAddOns[myAddOnsTree[myAddOnsTree.selectedIndex]].loadOptions.loadMethod = this:GetID();
	
	-- Update the load options buttons
	myAddOnsLoadOptionsFrame_UpdateButtons();

end

-- Load class checkbutton OnClick event
function myAddOnsLoadOptionsFrameClassCheckButton_OnClick()

	-- Check if the checkbutton is checked or not
	if (this:GetChecked()) then
		PlaySound("igMainMenuOptionCheckBoxOff");
	else
		PlaySound("igMainMenuOptionCheckBoxOn");
	end
	
	-- Get the ID of the checkbutton
	local checkButtonID = this:GetID();
	
	-- Get the class options
	local classes = myAddOnsAddOns[myAddOnsTree[myAddOnsTree.selectedIndex]].loadOptions.classes;
	
	-- Check which checkbutton was clicked
	if (checkButtonID == 1) then
		classes["Druid"] = this:GetChecked();
	elseif (checkButtonID == 2) then
		classes["Hunter"] = this:GetChecked();
	elseif (checkButtonID == 3) then
		classes["Mage"] = this:GetChecked();
	elseif (checkButtonID == 4) then
		classes["Paladin"] = this:GetChecked();
	elseif (checkButtonID == 5) then
		classes["Priest"] = this:GetChecked();
	elseif (checkButtonID == 6) then
		classes["Rogue"] = this:GetChecked();
	elseif (checkButtonID == 7) then
		classes["Shaman"] = this:GetChecked();
	elseif (checkButtonID == 8) then
		classes["Warlock"] = this:GetChecked();
	elseif (checkButtonID == 9) then
		classes["Warrior"] = this:GetChecked();
	end

end

-- Load character button OnClick Event
function myAddOnsLoadOptionsCharactersListFrameButton_OnClick()

	-- Get the index of the button that was clicked
	local characterIndex = this:GetID() + FauxScrollFrame_GetOffset(myAddOnsLoadOptionsCharactersListFrameScrollFrame);
	
	-- Check if the button is a character
	if (myAddOnsCharactersTree[characterIndex]) then
		-- Set the selected character
		myAddOnsCharactersTree.selectedIndex = characterIndex;
		-- Update the display the characters options
		myAddOnsLoadOptionsCharactersFrame_Update();
	end

end


--------------------------------------------------------------------------------------------------
-- Initialize functions
--------------------------------------------------------------------------------------------------

-- Initialize the addon
function myAddOnsFrame_Initialize()

	-- Initialize the categories table
	myAddOnsCategories[MYADDONS_CATEGORY_AUDIO] = {expanded = 1, addonCount = 0};
	myAddOnsCategories[MYADDONS_CATEGORY_BARS] = {expanded = 1, addonCount = 0};
	myAddOnsCategories[MYADDONS_CATEGORY_BATTLEGROUNDS] = {expanded = 1, addonCount = 0};
	myAddOnsCategories[MYADDONS_CATEGORY_CHAT] = {expanded = 1, addonCount = 0};
	myAddOnsCategories[MYADDONS_CATEGORY_CLASS] = {expanded = 1, addonCount = 0};
	myAddOnsCategories[MYADDONS_CATEGORY_COMBAT] = {expanded = 1, addonCount = 0};
	myAddOnsCategories[MYADDONS_CATEGORY_COMPILATIONS] = {expanded = 1, addonCount = 0};
	myAddOnsCategories[MYADDONS_CATEGORY_DEVELOPMENT] = {expanded = 1, addonCount = 0};
	myAddOnsCategories[MYADDONS_CATEGORY_GUILD] = {expanded = 1, addonCount = 0};
	myAddOnsCategories[MYADDONS_CATEGORY_INVENTORY] = {expanded = 1, addonCount = 0};
	myAddOnsCategories[MYADDONS_CATEGORY_MAP] = {expanded = 1, addonCount = 0};
	myAddOnsCategories[MYADDONS_CATEGORY_OTHERS] = {expanded = 1, addonCount = 0};
	myAddOnsCategories[MYADDONS_CATEGORY_PLUGINS] = {expanded = 1, addonCount = 0};
	myAddOnsCategories[MYADDONS_CATEGORY_PROFESSIONS] = {expanded = 1, addonCount = 0};
	myAddOnsCategories[MYADDONS_CATEGORY_QUESTS] = {expanded = 1, addonCount = 0};
	myAddOnsCategories[MYADDONS_CATEGORY_RAID] = {expanded = 1, addonCount = 0};
	myAddOnsCategories[MYADDONS_CATEGORY_UNKNOWN] = {expanded = 1, addonCount = 0};
	
	-- Set the notes scrollbar display
	myAddOnsDetailsFrameNotesScrollFrameScrollBarScrollUpButton:SetNormalTexture("Interface\\MainMenuBar\\UI-MainMenu-ScrollUpButton-Up");
	myAddOnsDetailsFrameNotesScrollFrameScrollBarScrollUpButton:SetPushedTexture("Interface\\MainMenuBar\\UI-MainMenu-ScrollUpButton-Down");
	myAddOnsDetailsFrameNotesScrollFrameScrollBarScrollUpButton:SetDisabledTexture("Interface\\MainMenuBar\\UI-MainMenu-ScrollUpButton-Disabled");
	myAddOnsDetailsFrameNotesScrollFrameScrollBarScrollUpButton:SetHighlightTexture("Interface\\MainMenuBar\\UI-MainMenu-ScrollUpButton-Highlight");
	myAddOnsDetailsFrameNotesScrollFrameScrollBarScrollDownButton:SetNormalTexture("Interface\\MainMenuBar\\UI-MainMenu-ScrollDownButton-Up");
	myAddOnsDetailsFrameNotesScrollFrameScrollBarScrollDownButton:SetPushedTexture("Interface\\MainMenuBar\\UI-MainMenu-ScrollDownButton-Down");
	myAddOnsDetailsFrameNotesScrollFrameScrollBarScrollDownButton:SetDisabledTexture("Interface\\MainMenuBar\\UI-MainMenu-ScrollDownButton-Disabled");
	myAddOnsDetailsFrameNotesScrollFrameScrollBarScrollDownButton:SetHighlightTexture("Interface\\MainMenuBar\\UI-MainMenu-ScrollDownButton-Highlight");
	myAddOnsDetailsFrameNotesScrollFrameScrollBarThumbTexture:SetTexture("");
	
	-- Set the characters scrollbar display
	myAddOnsLoadOptionsCharactersListFrameScrollFrameScrollBarScrollUpButton:SetNormalTexture("Interface\\MainMenuBar\\UI-MainMenu-ScrollUpButton-Up");
	myAddOnsLoadOptionsCharactersListFrameScrollFrameScrollBarScrollUpButton:SetPushedTexture("Interface\\MainMenuBar\\UI-MainMenu-ScrollUpButton-Down");
	myAddOnsLoadOptionsCharactersListFrameScrollFrameScrollBarScrollUpButton:SetDisabledTexture("Interface\\MainMenuBar\\UI-MainMenu-ScrollUpButton-Disabled");
	myAddOnsLoadOptionsCharactersListFrameScrollFrameScrollBarScrollUpButton:SetHighlightTexture("Interface\\MainMenuBar\\UI-MainMenu-ScrollUpButton-Highlight");
	myAddOnsLoadOptionsCharactersListFrameScrollFrameScrollBarScrollDownButton:SetNormalTexture("Interface\\MainMenuBar\\UI-MainMenu-ScrollDownButton-Up");
	myAddOnsLoadOptionsCharactersListFrameScrollFrameScrollBarScrollDownButton:SetPushedTexture("Interface\\MainMenuBar\\UI-MainMenu-ScrollDownButton-Down");
	myAddOnsLoadOptionsCharactersListFrameScrollFrameScrollBarScrollDownButton:SetDisabledTexture("Interface\\MainMenuBar\\UI-MainMenu-ScrollDownButton-Disabled");
	myAddOnsLoadOptionsCharactersListFrameScrollFrameScrollBarScrollDownButton:SetHighlightTexture("Interface\\MainMenuBar\\UI-MainMenu-ScrollDownButton-Highlight");
	myAddOnsLoadOptionsCharactersListFrameScrollFrameScrollBarThumbTexture:SetTexture("");
	
	-- Initialize the load options checkbuttons
	color = HIGHLIGHT_FONT_COLOR;
	myAddOnsLoadOptionsFrameManualCheckButtonText:SetTextColor(color.r, color.g, color.b);
	myAddOnsLoadOptionsFrameManualCheckButtonText:SetText(MYADDONS_LABEL_MANUAL);
	myAddOnsLoadOptionsFrameAutomaticCheckButtonText:SetTextColor(color.r, color.g, color.b);
	myAddOnsLoadOptionsFrameAutomaticCheckButtonText:SetText(MYADDONS_LABEL_AUTOMATIC);
	myAddOnsLoadOptionsFrameClassCheckButtonText:SetTextColor(color.r, color.g, color.b);
	myAddOnsLoadOptionsFrameClassCheckButtonText:SetText(MYADDONS_LABEL_CLASS);
	myAddOnsLoadOptionsFrameDruidCheckButtonText:SetText(MYADDONS_LABEL_DRUID);
	myAddOnsLoadOptionsFrameHunterCheckButtonText:SetText(MYADDONS_LABEL_HUNTER);
	myAddOnsLoadOptionsFrameMageCheckButtonText:SetText(MYADDONS_LABEL_MAGE);
	myAddOnsLoadOptionsFramePaladinCheckButtonText:SetText(MYADDONS_LABEL_PALADIN);
	myAddOnsLoadOptionsFramePriestCheckButtonText:SetText(MYADDONS_LABEL_PRIEST);
	myAddOnsLoadOptionsFrameRogueCheckButtonText:SetText(MYADDONS_LABEL_ROGUE);
	myAddOnsLoadOptionsFrameShamanCheckButtonText:SetText(MYADDONS_LABEL_SHAMAN);
	myAddOnsLoadOptionsFrameWarlockCheckButtonText:SetText(MYADDONS_LABEL_WARLOCK);
	myAddOnsLoadOptionsFrameWarriorCheckButtonText:SetText(MYADDONS_LABEL_WARRIOR);
	myAddOnsLoadOptionsFrameCharacterCheckButtonText:SetTextColor(color.r, color.g, color.b);
	myAddOnsLoadOptionsFrameCharacterCheckButtonText:SetText(MYADDONS_LABEL_CHARACTER);
	
	-- Select the details tab by default
	myAddOnsFrameTab_OnClick(1);
	
	-- Build the addons list
	myAddOnsFrame_BuildList();

end


--------------------------------------------------------------------------------------------------
-- Display functions
--------------------------------------------------------------------------------------------------

-- Update the display
function myAddOnsFrame_Update()

	-- Browse the lines
	for line = 1, 20, 1 do
		local index = myAddOnsFrame_GetIndex(line + FauxScrollFrame_GetOffset(myAddOnsFrameScrollFrame));
		-- Check if there is an item to display on the line
		if (index ~= 0) then
			local item = myAddOnsTree[index];
			local color;
			-- Check if the item is an addon
			if (myAddOnsAddOns[item]) then
				local name, title, notes, enabled, loadable, reason, security = GetAddOnInfo(item);
				if (IsAddOnLoaded(item)) then
					color = NORMAL_FONT_COLOR;
				else
					color = GRAY_FONT_COLOR;
				end
				getglobal("myAddOnsFrameButton"..line.."Name"):SetText("   "..title);
				-- Hide the toggle button
				getglobal("myAddOnsFrameButton"..line):SetNormalTexture("");
				getglobal("myAddOnsFrameButton"..line.."Highlight"):SetTexture("");
			else
				color = HIGHLIGHT_FONT_COLOR;
				getglobal("myAddOnsFrameButton"..line.."Name"):SetText(item);
				-- Show the toggle button
				if (myAddOnsCategories[item].expanded) then
					getglobal("myAddOnsFrameButton"..line):SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up");
				else
					getglobal("myAddOnsFrameButton"..line):SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up");
				end
				getglobal("myAddOnsFrameButton"..line.."Highlight"):SetTexture("Interface\\Buttons\\UI-PlusButton-Hilight");
			end
			-- Set the line's color
			getglobal("myAddOnsFrameButton"..line.."Name"):SetTextColor(color.r, color.g, color.b);
			getglobal("myAddOnsFrameButton"..line).r = color.r;
			getglobal("myAddOnsFrameButton"..line).g = color.g;
			getglobal("myAddOnsFrameButton"..line).b = color.b;
			getglobal("myAddOnsFrameButton"..line):Show();
		else
			getglobal("myAddOnsFrameButton"..line):Hide();
		end
	end
	
	-- Place/Remove the highlight
	myAddOnsFrame_UpdateHighlight();
	
	-- Enable/Disable the buttons
	myAddOnsFrame_UpdateButtons();
	
	-- Scroll frame stuff
	FauxScrollFrame_Update(myAddOnsFrameScrollFrame, myAddOnsFrame_GetNumVisibleItems(), 20, 16);
	
	-- Update the details
	myAddOnsDetailsFrame_Update();
	
	-- Update the help
	myAddOnsHelpFrame_Update();
	
	-- Update the load options
	myAddOnsLoadFrame_Update();
	
	-- Show the info of the selected tab
	myAddOnsFrameTab_OnClick(PanelTemplates_GetSelectedTab(myAddOnsFrame));

end

-- Place/Remove the highlight
function myAddOnsFrame_UpdateHighlight()

	-- Get the selected index
	local selectedIndex = myAddOnsTree.selectedIndex;
	
	-- Check if an addon is selected and if it's visible
	if (selectedIndex ~= 0 and myAddOnsCategories[myAddOnsAddOns[myAddOnsTree[selectedIndex]].category].expanded) then
		local selectedLine = myAddOnsFrame_GetSelectedLine();
		-- Check if the selected addon is currently displayed
		if (selectedLine > 0 and selectedLine <= 20) then
			getglobal("myAddOnsFrameButton"..selectedLine.."Name"):SetTextColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
			myAddOnsFrameHighlightFrame:SetPoint("TOPLEFT", "myAddOnsFrameButton"..selectedLine, "TOPLEFT", 10, -1);
			myAddOnsFrameHighlightFrame:Show();
		else
			myAddOnsFrameHighlightFrame:Hide();
		end
	else
		myAddOnsFrameHighlightFrame:Hide();
	end

end

-- Enable/Disable the buttons
function myAddOnsFrame_UpdateButtons()

	-- Get the selected index
	local selectedIndex = myAddOnsTree.selectedIndex;
	
	-- Check if an addon is selected
	if (selectedIndex ~= 0) then
		local item = myAddOnsTree[selectedIndex];
		local addon = myAddOnsAddOns[item];
		-- Check if the addon is loaded
		if (IsAddOnLoaded(item)) then
			myAddOnsFrameLoadButton:Disable();
		else
			myAddOnsFrameLoadButton:Enable();
		end
		-- Check if the addon has an options window
		if (getglobal(addon.optionsframe)) then
			myAddOnsFrameOptionsButton:Enable();
		else
			myAddOnsFrameOptionsButton:Disable();
		end
	else
		myAddOnsFrameLoadButton:Disable();
		myAddOnsFrameOptionsButton:Disable();
	end

end

-- Show the options frame of the selected addon
function myAddOnsFrame_ShowOptions()

	-- Show the options frame
	getglobal(myAddOnsAddOns[myAddOnsTree[myAddOnsTree.selectedIndex]].optionsframe):Show();

end

-- Update the details
function myAddOnsDetailsFrame_Update()

	-- Get the selected index
	local selectedIndex = myAddOnsTree.selectedIndex;
	
	-- Check if an addon is selected
	if (selectedIndex ~= 0) then
		local item = myAddOnsTree[selectedIndex];
		local addon = myAddOnsAddOns[item];
		local name, title, notes, enabled, loadable, reason, security = GetAddOnInfo(item);
		myAddOnsDetailsFrameName:SetText(title);
		myAddOnsDetailsFrameDescriptionValue:SetText(notes);
		myAddOnsDetailsFrameVersionValue:SetText(addon.version);
		myAddOnsDetailsFrameReleaseDateValue:SetText(addon.releaseDate);
		myAddOnsDetailsFrameAuthorValue:SetText(addon.author);
		local email = addon.email;
		if (email) then
			email = "["..email.."]";
			myAddOnsDetailsFrameEmailAddressCopyButton:Enable();
		else
			myAddOnsDetailsFrameEmailAddressCopyButton:Disable();
		end
		myAddOnsDetailsFrameEmailValue:SetText(email);
		myAddOnsDetailsFrameEmailAddressCopyButton:SetWidth(myAddOnsDetailsFrameEmailValue:GetWidth());
		local website = addon.website;
		if (website) then
			website = "["..website.."]";
			myAddOnsDetailsFrameWebsiteAddressCopyButton:Enable();
		else
			myAddOnsDetailsFrameWebsiteAddressCopyButton:Disable();
		end
		myAddOnsDetailsFrameWebsiteValue:SetText(website);
		myAddOnsDetailsFrameWebsiteAddressCopyButton:SetWidth(myAddOnsDetailsFrameWebsiteValue:GetWidth());
		local notes = addon.notes;
		if (not notes) then
			notes = "";
		end
		myAddOnsDetailsFrameNotesEditBox:SetText(notes);
	end

end

-- Update the help
function myAddOnsHelpFrame_Update()

	-- Get the selected index
	local selectedIndex = myAddOnsTree.selectedIndex;
	
	-- Check if an addon is selected
	if (selectedIndex ~= 0) then
		local item = myAddOnsTree[selectedIndex];
		local addon = myAddOnsAddOns[item];
		local name, title, notes, enabled, loadable, reason, security = GetAddOnInfo(item);
		myAddOnsHelpFrameName:SetText(title.." "..MYADDONS_TAB_HELP);
		local help = addon.help;
		local currentPage, totalPages;
		if (help) then
			currentPage = help.currentPage;
			totalPages = table.getn(help);
		else
			help = {};
			currentPage = 0;
			totalPages = 0;
		end
		myAddOnsHelpFrameHelp:SetText(help[currentPage]);
		myAddOnsHelpFramePage:SetText(format(TEXT(PAGE_NUMBER), currentPage).."/"..totalPages);
		myAddOnsHelpFrame_UpdateButtons()
	end

end

-- Enable/Disable the help buttons
function myAddOnsHelpFrame_UpdateButtons()

	-- Get the help
	local help = myAddOnsAddOns[myAddOnsTree[myAddOnsTree.selectedIndex]].help;
	
	-- Check if there is an help
	if (help) then
		local currentPage = help.currentPage;
		local totalPages = table.getn(help);
		-- Check if the current help page is the first one
		if (currentPage == 1) then
			myAddOnsHelpFramePrevPageButton:Disable();
		else
			myAddOnsHelpFramePrevPageButton:Enable();
		end
		-- Check if the current help page is the last one
		if (currentPage == totalPages) then
			myAddOnsHelpFrameNextPageButton:Disable();
		else
			myAddOnsHelpFrameNextPageButton:Enable();
		end
	else
		myAddOnsHelpFramePrevPageButton:Disable();
		myAddOnsHelpFrameNextPageButton:Disable();
	end

end

-- Update the load options
function myAddOnsLoadFrame_Update()

	-- Get the selected index
	local selectedIndex = myAddOnsTree.selectedIndex;
	
	-- Check if an addon is selected
	if (selectedIndex ~= 0) then
		local item = myAddOnsTree[selectedIndex];
		local addon = myAddOnsAddOns[item];
		local name, title, notes, enabled, loadable, reason, security = GetAddOnInfo(item);
		myAddOnsLoadFrameName:SetText(title.." "..MYADDONS_TAB_LOAD);
		if (addon.loadOptions) then
			myAddOnsLoadFrameNotLoadOnDemand:Hide();
			myAddOnsFrame_BuildCharactersTree();
			myAddOnsLoadOptionsFrame_UpdateButtons();
			myAddOnsLoadOptionsFrame:Show();
		else
			myAddOnsLoadOptionsFrame:Hide();
			myAddOnsLoadFrameNotLoadOnDemand:Show();
		end
	end

end

-- Update the load options buttons
function myAddOnsLoadOptionsFrame_UpdateButtons()

	-- Get the load options
	local loadOptions = myAddOnsAddOns[myAddOnsTree[myAddOnsTree.selectedIndex]].loadOptions;
	local loadMethod = loadOptions.loadMethod;
	local classes = loadOptions.classes;
	
	-- Update the class checkbuttons
	OptionsFrame_EnableCheckBox(myAddOnsLoadOptionsFrameDruidCheckButton, classes["Druid"]);
	OptionsFrame_EnableCheckBox(myAddOnsLoadOptionsFrameHunterCheckButton, classes["Hunter"]);
	OptionsFrame_EnableCheckBox(myAddOnsLoadOptionsFrameMageCheckButton, classes["Mage"]);
	OptionsFrame_EnableCheckBox(myAddOnsLoadOptionsFramePaladinCheckButton, classes["Paladin"]);
	OptionsFrame_EnableCheckBox(myAddOnsLoadOptionsFramePriestCheckButton, classes["Priest"]);
	OptionsFrame_EnableCheckBox(myAddOnsLoadOptionsFrameRogueCheckButton, classes["Rogue"]);
	OptionsFrame_EnableCheckBox(myAddOnsLoadOptionsFrameShamanCheckButton, classes["Shaman"]);
	OptionsFrame_EnableCheckBox(myAddOnsLoadOptionsFrameWarlockCheckButton, classes["Warlock"]);
	OptionsFrame_EnableCheckBox(myAddOnsLoadOptionsFrameWarriorCheckButton, classes["Warrior"]);
	
	-- Update the characters buttons
	myAddOnsLoadOptionsCharactersFrame_Update();
	
	-- Check the load method
	if (loadMethod == 1) then
		myAddOnsLoadOptionsFrameManualCheckButton:SetChecked(1);
	else
		myAddOnsLoadOptionsFrameManualCheckButton:SetChecked(0);
	end
	if (loadMethod == 2) then
		myAddOnsLoadOptionsFrameAutomaticCheckButton:SetChecked(1);
	else
		myAddOnsLoadOptionsFrameAutomaticCheckButton:SetChecked(0);
	end
	if (loadMethod == 3) then
		myAddOnsLoadOptionsFrameClassCheckButton:SetChecked(1);
	else
		myAddOnsLoadOptionsFrameClassCheckButton:SetChecked(0);
		OptionsFrame_DisableCheckBox(myAddOnsLoadOptionsFrameDruidCheckButton);
		OptionsFrame_DisableCheckBox(myAddOnsLoadOptionsFrameHunterCheckButton);
		OptionsFrame_DisableCheckBox(myAddOnsLoadOptionsFrameMageCheckButton);
		OptionsFrame_DisableCheckBox(myAddOnsLoadOptionsFramePaladinCheckButton);
		OptionsFrame_DisableCheckBox(myAddOnsLoadOptionsFramePriestCheckButton);
		OptionsFrame_DisableCheckBox(myAddOnsLoadOptionsFrameRogueCheckButton);
		OptionsFrame_DisableCheckBox(myAddOnsLoadOptionsFrameShamanCheckButton);
		OptionsFrame_DisableCheckBox(myAddOnsLoadOptionsFrameWarlockCheckButton);
		OptionsFrame_DisableCheckBox(myAddOnsLoadOptionsFrameWarriorCheckButton);
	end
	if (loadMethod == 4) then
		myAddOnsLoadOptionsFrameCharacterCheckButton:SetChecked(1);
		myAddOnsLoadOptionsCharactersListFrameButton1:Enable();
		myAddOnsLoadOptionsCharactersListFrameButton2:Enable();
		myAddOnsLoadOptionsCharactersListFrameButton3:Enable();
		myAddOnsLoadOptionsCharactersListFrameButton4:Enable();
		myAddOnsLoadOptionsCharactersListFrameAddButton:Enable();
	else
		myAddOnsLoadOptionsFrameCharacterCheckButton:SetChecked(0);
		myAddOnsLoadOptionsCharactersListFrameButton1:Disable();
		myAddOnsLoadOptionsCharactersListFrameButton1Name:SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
		myAddOnsLoadOptionsCharactersListFrameButton2:Disable();
		myAddOnsLoadOptionsCharactersListFrameButton2Name:SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
		myAddOnsLoadOptionsCharactersListFrameButton3:Disable();
		myAddOnsLoadOptionsCharactersListFrameButton3Name:SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
		myAddOnsLoadOptionsCharactersListFrameButton4:Disable();
		myAddOnsLoadOptionsCharactersListFrameButton4Name:SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
		myAddOnsLoadOptionsCharactersListFrameScrollFrameScrollBarScrollUpButton:Disable();
		myAddOnsLoadOptionsCharactersListFrameScrollFrameScrollBarScrollDownButton:Disable();
		myAddOnsLoadOptionsCharactersListFrameHighlightFrame:Hide();
		myAddOnsLoadOptionsCharactersListFrameAddButton:Disable();
		myAddOnsLoadOptionsCharactersListFrameRemoveButton:Disable();
	end

end

-- Update the display the characters options
function myAddOnsLoadOptionsCharactersFrame_Update()

	-- Browse the lines
	for line = 1, 4, 1 do
		local character = myAddOnsCharactersTree[line + FauxScrollFrame_GetOffset(myAddOnsLoadOptionsCharactersListFrameScrollFrame)];
		-- Check if there is a character to display on the line
		if (character) then
			getglobal("myAddOnsLoadOptionsCharactersListFrameButton"..line.."Name"):SetText(character);
			getglobal("myAddOnsLoadOptionsCharactersListFrameButton"..line.."Name"):SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
			getglobal("myAddOnsLoadOptionsCharactersListFrameButton"..line):Show();
		else
			getglobal("myAddOnsLoadOptionsCharactersListFrameButton"..line):Hide();
		end
	end
	
	-- Place/Remove the characters list highlight
	myAddOnsLoadOptionsCharactersListFrame_UpdateHighlight();
	
	-- Enable/Disable the characters options buttons
	myAddOnsLoadOptionsCharactersListFrame_UpdateButtons();
	
	-- Scroll frame stuff
	FauxScrollFrame_Update(myAddOnsLoadOptionsCharactersListFrameScrollFrame, table.getn(myAddOnsCharactersTree), 4, 11);

end

-- Place/Remove the characters list highlight
function myAddOnsLoadOptionsCharactersListFrame_UpdateHighlight()

	-- Check if a character is selected
	if (myAddOnsCharactersTree.selectedIndex ~= 0) then
		local selectedLine = myAddOnsLoadOptionsCharactersListFrame_GetSelectedLine();
		-- Check if the selected character is currently displayed
		if (selectedLine > 0 and selectedLine <= 20) then
			getglobal("myAddOnsLoadOptionsCharactersListFrameButton"..selectedLine.."Name"):SetTextColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
			myAddOnsLoadOptionsCharactersListFrameHighlightFrame:SetPoint("TOPLEFT", "myAddOnsLoadOptionsCharactersListFrameButton"..selectedLine, "TOPLEFT", -5, -1);
			myAddOnsLoadOptionsCharactersListFrameHighlightFrame:Show();
		else
			myAddOnsLoadOptionsCharactersListFrameHighlightFrame:Hide();
		end
	else
		myAddOnsLoadOptionsCharactersListFrameHighlightFrame:Hide();
	end

end

-- Enable/Disable the characters options buttons
function myAddOnsLoadOptionsCharactersListFrame_UpdateButtons()

	-- Check if a character is selected
	if (myAddOnsCharactersTree.selectedIndex ~= 0) then
		myAddOnsLoadOptionsCharactersListFrameRemoveButton:Enable();
	else
		myAddOnsLoadOptionsCharactersListFrameRemoveButton:Disable();
	end

end


--------------------------------------------------------------------------------------------------
-- AddOns functions
--------------------------------------------------------------------------------------------------

-- Build the addons list
function myAddOnsFrame_BuildList()

	-- Create a temporary list of the installed addons
	local tempAddOnsList = {};
	
	-- Browse the installed addons
	for addonIndex = 1, GetNumAddOns(), 1 do
		-- Get the AddOn info
		local name, title, notes, enabled, loadable, reason, security = GetAddOnInfo(addonIndex);
		
		tempAddOnsList[name] = 1;
		
		-- Check if the AddOn is already registered
		if (not myAddOnsAddOns[name]) then
			myAddOnsAddOns[name] = {};
			myAddOnsAddOns[name].category = MYADDONS_CATEGORY_UNKNOWN;
		end
		
		local addon = myAddOnsAddOns[name];
		
		-- Check if the addon is load on demand
		if (IsAddOnLoadOnDemand(name)) then
			if (not addon.loadOptions) then
				addon.loadOptions = {};
				addon.loadOptions.loadMethod = 1;
				addon.loadOptions.classes = {};
				addon.loadOptions.realms = {};
			end
		else
			myAddOnsAddOns[name].loadOptions = nil;
		end
		
		-- Get the AddOn details
		category = getglobal(GetAddOnMetadata(name, "X-Category"));
		-- Check if the category is valid
		if (myAddOnsCategories[category]) then
			addon.category = category;
		else
			addon.category = MYADDONS_CATEGORY_UNKNOWN;
		end
		addon.version = GetAddOnMetadata(name, "Version");
		addon.releaseDate = GetAddOnMetadata(name, "X-Date");
		addon.author = GetAddOnMetadata(name, "Author");
		addon.email = GetAddOnMetadata(name, "X-Email");
		addon.website = GetAddOnMetadata(name, "X-Website");
		addon.optionsframe = GetAddOnMetadata(name, "X-OptionsFrame");
		addon.helpVariable = GetAddOnMetadata(name, "X-Help");
	end
	
	-- Browse the saved addons list
	for addonName in myAddOnsAddOns do
		-- Check if the addon is still installed
		if (not tempAddOnsList[addonName]) then
			myAddOnsAddOns[addonName] = nil;
		end
	end

end

-- Register the addons using the v1.x registration method
function myAddOnsFrame_Register1x()

	-- Browse the v1.x addons list
	for addonName in myAddOnsList do
		local addon = myAddOnsList[addonName];
		local addonDetails = {
			name = addonName,
			version = addon.version,
			category = addon.category,
			optionsframe = addon.optionsframe
		};
		myAddOnsFrame_Register(addonDetails);
		myAddOnsList[addonName] = nil;
	end

end

-- Register an addon
function myAddOnsFrame_Register(addonDetails, addonHelp)

	-- Remove any color information from the name
	addonDetails.name = string.gsub(string.gsub(addonDetails.name, "%|c%x%x%x%x%x%x%x%x",""),"%|r","");
	
	-- Get the addon
	local addon = myAddOnsAddOns[addonDetails.name];
	
	-- Check if the addon name is valid
	if (not addon) then
		-- Browse the installed addons
		for addonIndex = 1, GetNumAddOns(), 1 do
			local name, title, notes, enabled, loadable, reason, security = GetAddOnInfo(addonIndex);
			-- Remove any color information from the title
			title = string.gsub(string.gsub(title, "%|c%x%x%x%x%x%x%x%x",""),"%|r","");
			-- Check if there is an addon with this title
			if (title == addonDetails.name) then
				addon = myAddOnsAddOns[name];
				break;
			end
		end
	end
	
	-- Check if the addon can be registered
	if (addon) then
		if (addonDetails.version) then
			addon.version = addonDetails.version;
		end
		if (addonDetails.releaseDate) then
			addon.releaseDate = addonDetails.releaseDate;
		end
		if (addonDetails.author) then
			addon.author = addonDetails.author;
		end
		if (addonDetails.email) then
			addon.email = addonDetails.email;
		end
		if (addonDetails.website) then
			addon.website = addonDetails.website;
		end
		-- Check if the category is valid
		if (addonDetails.category and myAddOnsCategories[addonDetails.category]) then
			addon.category = addonDetails.category;
		end
		if (addonDetails.optionsframe) then
			addon.optionsframe = addonDetails.optionsframe;
		end
		if (addonHelp) then
			addonHelp.currentPage = 1;
			addon.help = addonHelp;
		end
	else
		-- Display a message in the ChatFrame indicating an error in the registration of this addon
		DEFAULT_CHAT_FRAME:AddMessage(gsub(MYADDONS_REGISTRATION_ERROR, "addon", addonDetails.name), 1.0, 0.0, 0.0);
	end

end

-- Load the selected addon
function myAddOnsFrame_LoadAddOn()

	-- Get the addon
	local item = myAddOnsTree[myAddOnsTree.selectedIndex];
	
	-- Load the selected addon
	UIParentLoadAddOn(item);
	
	-- Register the addons using the v1.x registration method
	myAddOnsFrame_Register1x();
	
	-- Build the tree
	myAddOnsFrame_BuildTree();
	
	-- Get the new index of the addon
	for index in myAddOnsTree do
		if (myAddOnsTree[index] == item) then
			myAddOnsTree.selectedIndex = index;
			break;
		end
	end
	
	-- Update the display
	myAddOnsFrame_Update();

end

-- Load the on demand addons
function myAddOnsFrame_AutomaticLoad()

	-- Browse the addons
	for addonName in myAddOnsAddOns do
		local loadOptions = myAddOnsAddOns[addonName].loadOptions;
		local name, title, notes, enabled, loadable, reason, security = GetAddOnInfo(addonName);
		-- Check if the addon is load on demand
		if (loadOptions and enabled and loadable) then
			loadMethod = loadOptions.loadMethod;
			-- Check the load method
			if (loadMethod == 2) then
				UIParentLoadAddOn(addonName);
			elseif (loadMethod == 3) then
				-- Check the classes options
				if (loadOptions.classes[MYCLASS]) then
					UIParentLoadAddOn(addonName);
				end
			elseif (loadMethod == 4) then
				-- Check the characters options
				if (loadOptions.realms[MYREALM] and loadOptions.realms[MYREALM][MYCHARACTER]) then
					UIParentLoadAddOn(addonName);
				end
			end
		end
	end

end


--------------------------------------------------------------------------------------------------
-- Tree functions
--------------------------------------------------------------------------------------------------

-- Build the tree
function myAddOnsFrame_BuildTree()

	-- Create a temporary sorted categories list
	local tempCategories = {};
	
	-- Browse the categories list
	for category in myAddOnsCategories do
		table.insert(tempCategories, category);
	end
	
	-- Sort the temporary categories list
	table.sort(tempCategories);
	
	-- Create/Empty the tree
	myAddOnsTree = {};
	myAddOnsTree.selectedIndex = 0;
	
	-- Browse the categories list
	for categoryIndex in tempCategories do
		-- Create a temporary addons table for the current category
		local tempAddOns = {};
		local category = tempCategories[categoryIndex];
		myAddOnsCategories[category].addonCount = 0;
		-- Browse the addons list
		for addonName in myAddOnsAddOns do
			local addon = myAddOnsAddOns[addonName];
			if (addon.category == category) then
				local name, title, notes, enabled, loadable, reason, security = GetAddOnInfo(addonName);
				if (enabled and loadable) then
					table.insert(tempAddOns, addonName);
				end
			end
		end
		-- Check if there is any addon for the current category
		if (table.getn(tempAddOns) > 0) then
			-- Sort the temporary addons list
			table.sort(tempAddOns);
			-- Add the category header
			table.insert(myAddOnsTree, category);
			-- Browse the temporary addons list
			for addonIndex in tempAddOns do
				myAddOnsCategories[category].addonCount = myAddOnsCategories[category].addonCount + 1;
				table.insert(myAddOnsTree, tempAddOns[addonIndex]);
			end
		end
	end

end

-- Get the number of visible items in the tree
function myAddOnsFrame_GetNumVisibleItems()

	local numVisibleItems = 0;
	
	-- Browse the tree
	for index in myAddOnsTree do
		local category = myAddOnsCategories[myAddOnsTree[index]];
		-- Check if the current index is a category
		if (category) then
			-- Check if the category is visible
			if (category.addonCount > 0) then
				numVisibleItems = numVisibleItems + 1;
			end
			-- Check if the category is expanded
			if (category.expanded) then
				numVisibleItems = numVisibleItems + category.addonCount;
			end
		end
	end
	
	return numVisibleItems;

end

-- Get the index in the tree of the selected line
function myAddOnsFrame_GetIndex(selectedLine)

	local line = 0;
	
	-- Browse the tree
	for index in myAddOnsTree do
		local item = myAddOnsTree[index];
		local addon = myAddOnsAddOns[item];
		local category = myAddOnsCategories[item];
		-- Check if the current index is an addon
		if (addon) then
			-- Check if the addon is visible
			if (myAddOnsCategories[addon.category].expanded) then
				line = line + 1;
			end
		elseif (category) then
			-- Check if the category is visible
			if (category.addonCount > 0) then
				line = line + 1;
			end
		end
		-- Check if it has reached the selected line
		if (line == selectedLine) then
			return index;
		end
	end
	
	return 0;

end

-- Get the line of the selected addon
function myAddOnsFrame_GetSelectedLine()

	local selectedLine = -FauxScrollFrame_GetOffset(myAddOnsFrameScrollFrame);

	for index = 1, myAddOnsTree.selectedIndex, 1 do
		local item = myAddOnsTree[index];
		local addon = myAddOnsAddOns[item];
		local category = myAddOnsCategories[item];
		-- Check if the current item is an addon
		if (addon) then
			-- Check if the addon is visible
			if (myAddOnsCategories[addon.category].expanded) then
				selectedLine = selectedLine + 1;
			end
		elseif (category) then
			-- Check if the category is visible
			if (myAddOnsCategories[item].addonCount > 0) then
				selectedLine = selectedLine + 1;
			end
		end
	end
	
	return selectedLine;

end

-- Build the characters tree
function myAddOnsFrame_BuildCharactersTree()

	-- Create/Empty the tree
	myAddOnsCharactersTree = {};
	myAddOnsCharactersTree.selectedIndex = 0;
	
	-- Get the realms
	local realms = myAddOnsAddOns[myAddOnsTree[myAddOnsTree.selectedIndex]].loadOptions.realms;
	
	-- Browse the realms list
	for realmName in realms do
		for character in realms[realmName] do
			table.insert(myAddOnsCharactersTree, realmName.." - "..character);
		end
	end
	
	-- Sort the characters tree
	table.sort(myAddOnsCharactersTree);

end

-- Get the line of the selected character
function myAddOnsLoadOptionsCharactersListFrame_GetSelectedLine()

	return myAddOnsCharactersTree.selectedIndex - FauxScrollFrame_GetOffset(myAddOnsLoadOptionsCharactersListFrameScrollFrame);

end

-- Add the current character
function myAddOnsLoadOptionsCharactersListFrame_AddCharacter()

	-- Get the realms
	local realms = myAddOnsAddOns[myAddOnsTree[myAddOnsTree.selectedIndex]].loadOptions.realms;
	
	-- Check if the current realm is in the list
	if (not realms[MYREALM]) then
		realms[MYREALM] = {};
	end
	
	-- Check if the current character is not already in the list
	if (not realms[MYREALM][MYCHARACTER]) then
		-- Add the current character
		realms[MYREALM][MYCHARACTER] = 1;
		-- Build the caracters tree
		myAddOnsFrame_BuildCharactersTree();
		-- Update the display the characters options
		myAddOnsLoadOptionsCharactersFrame_Update();
	end

end

-- Remove the selected character
function myAddOnsLoadOptionsCharactersListFrame_RemoveCharacter()

	-- Get the character
	local character = myAddOnsCharactersTree[myAddOnsCharactersTree.selectedIndex];
	
	-- Get the realms
	local realms = myAddOnsAddOns[myAddOnsTree[myAddOnsTree.selectedIndex]].loadOptions.realms;
	
	-- Remove the character from the list
	local index = string.find(character, "-");
	realms[string.sub(character, 1, index-2)][string.sub(character, index+2, -1)] = nil;
	
	-- Build the caracters tree
	myAddOnsFrame_BuildCharactersTree();
	
	-- Update the display the characters options
	myAddOnsLoadOptionsCharactersFrame_Update();

end

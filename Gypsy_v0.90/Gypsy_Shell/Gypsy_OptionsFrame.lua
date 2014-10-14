--[[
	Gypsy_OptionsFrame.lua
	GypsyVersion++2004.11.08++
	
	Functions to handle add-on options and the menu items presenting them.
	
	* See Gypsy_RegisterOption for options registration information *			
]]

-- ** GENERAL VARIABLES ** --

-- GypsyMod version
GYPSY_VERSION = "0.90";

-- Value to check against for shell presence
GYPSY_SHELL = 1;

-- Register our new window with the built-in UI panel functions
UIPanelWindows["Gypsy_OptionsFrame"] = {area = "center", pushable = 1};

-- Track tab initialization
Gypsy_TabInit = 0;

-- Initialize an array to hold our global configuration variables, and one to hold our saved values, and register the later for saving
GYPSY_REGISTRATIONS = {};
GYPSY_SAVED = {};
--RegisterForSave('GYPSY_SAVED');

-- Registration variable text
GYPSY_ID = "id";
GYPSY_TYPE = "type";
GYPSY_VALUE = "value";
GYPSY_NAME = "name";
GYPSY_FUNC = "func";
GYPSY_LABEL = "label";
GYPSY_TOOLTIP = "tooltip";
GYPSY_SLIDMIN = "slidermin";
GYPSY_SLIDMAX = "slidermax";
GYPSY_SLIDSTEP = "sliderstep";
GYPSY_SLIDUNIT = "sliderunit";

-- ** REGISTRATION OPERATIONS ** --

--[[
	Gypsy_RegisterOption
	Master function to initiate an options configuration and save appropriate data.
	
	This function accepts a number of arguments to make available to other functions, and for saving.
	Items denoted with a * are required. Any optional argument may recieve 'nil' succesfully.
	This function also dynamically initializes options categories.
	
	ID*			= ID of cooresponding XML frame(s), must be a UNIQUE integer, see Gypsy_OptionsFrame.xml for reservations and usage
	Type*		= Type of option for displaying. There are 5 possibilities for this:
					'check' - Check button, to deal with toggle values (1/0)
					'button' - Push button, click to run a function
					'slider' - Range of integer values
					'header' - Graphical display header
					'category' - Options window tab
	Value		= Integer representing an option's state, this is saved and loaded between sessions if non-nil.
	Name		= Unique name representing a value's purpose, used to store the value. If value is nil, this should be nil.
	Func		= Run a function either to update a value or execute any other directive
	Label*		= Text written within the options menu.
					If type is 'category', this will be written over the options tab, and maximum length should be 10-12 chars
					If type is 'button', this will be written over push buttons, and maximum length should be 8-10
					If type is 'slider', this will be written above the slider, and should be kept below 20 characters
					If type is 'check', this will be written to the right of the checkbutton, and length need not be limited
					If type is 'header', this will be written over the header, and can be quite long
	Tooltip		= Description of your option that appears on mouse over in a tooltip.
	Slidermin	= Minimum number value for a slider.
	Slidermax	= Maximum number value for a slider.
	Sliderstep	= Size to make each step between the minimum and maximum values of a slider.
	Sliderunit	= If this is set, it will be appended to the min and max numbers and displayed on either end of the slider. Examples: 'px' 'ft.'
	
	Arguments need to be registered in this order! If the registration type is not 'slider', do NOT enter 'nil' for the last 4 arguments,
	simply leave them off. If value, name, or func are not used, 'nil' MUST be registered in their place.
]]

function Gypsy_RegisterOption(id, type, value, name, func, label, tooltip, slidermin, slidermax, sliderstep, sliderunit)
	-- Get the current number of registrations and then increment the number for indexing
	local n = getn(GYPSY_REGISTRATIONS);
	local index = n + 1;
	-- Set a new registration at the index
	GYPSY_REGISTRATIONS[index] = {		
		[GYPSY_ID] = id,
		[GYPSY_TYPE] = type,
		[GYPSY_VALUE] = value,
		[GYPSY_NAME] = name,		
		[GYPSY_FUNC] = func,
		[GYPSY_LABEL] = label,		
		[GYPSY_TOOLTIP] = tooltip,
		[GYPSY_SLIDMIN] = slidermin,
		[GYPSY_SLIDMAX] = slidermax,
		[GYPSY_SLIDSTEP] = sliderstep,
		[GYPSY_SLIDUNIT] = sliderunit
	}
	-- If a value is defined, add it to our saved values array at 'name'
	if (value ~= nil) then
		GYPSY_SAVED[name] = value;
	end
	-- Initialize category tabs, we do this so the Shell add-on doesn't break when particular add-ons aren't present
	if (type == "category") then
		-- If this is the first category we run into, or a category with a lower ID than is set, make this tab show when opening the options window
		if (Gypsy_VisibleTab == nil or Gypsy_VisibleTab > id) then
			Gypsy_VisibleTab = id;
		end
		-- Tab items hard-coded in the XML, which are hidden to start out
		local tabButton = getglobal("Gypsy_Tab"..id.."Button");
		local tabText = getglobal("Gypsy_Tab"..id.."Text");
		-- Make sure the elements are there and show them, or error
		if (tabButton ~= nil and tabText ~= nil) then
			tabButton:Show();
			tabText:Show();
		else
			Gypsy_Error("Invalid category ID, ID="..id);
		end
	end
end	

--[[
	Gypsy_RetrieveSaved
	Pre-registration function used in AddOns to retrieve saved values if they exist, so they can be re-registered.
	
	This function takes the unique 'name' field and returns the saved value, or nil if there is no saved data.
	Call this function when setting up default values after the 'variables loaded' event has run, and before registering with Gypsy_RegisterOption.
	
	Note that the 'name' indexes are saved with parentheses, ie "MyVar". Thus, when making a call to this function, pass your 'name' value with double parentheses.
]]

function Gypsy_RetrieveSaved(name)
	-- Simply check to see if there's an array index 'name', and return it's value if so, otherwise return nil
	if (GYPSY_SAVED[name] ~= nil) then
		local value = GYPSY_SAVED[name];
		return value;
	else
		return nil;
	end
end

--[[
	Gypsy_RetrieveOption
	This is the main function to get data out of our registration table
	
	This function requires an ID, which cooresponds to the 'id' field of our registrations, NOT the index of our registrations table
	If the ID is found in our table, this function returns the equivalent of using GYPSY_REGISTRATIONS[id]
	THUS, this function can be syntactically the exact same as the table itself, EXCEPT FOR MODIFYING ENTRIES
	If the ID supplied is not found in our table, nil is returned.
	
	No table entry modification should be done through this function. The only ways a person should change anything within our registration 
	table are the Gypsy_RegisterOption function above, and the Gypsy_UpdateValue function below.
]]

function Gypsy_RetrieveOption(id)
	-- Loop through each registration until we find the supplied ID, and then return it's registration information
	local n = getn(GYPSY_REGISTRATIONS);
	for i=1, n do
		if (GYPSY_REGISTRATIONS[i] ~= nil) then
			if (GYPSY_REGISTRATIONS[i][GYPSY_ID] == id) then
				local data = GYPSY_REGISTRATIONS[i];
				return data;
			end
		end
	end
	-- Return nil if the ID is not found
	return nil;
end

--[[
	Gypsy_UpdateValue
	This function is used to update saved values, called from various interfaces in our options menu.
	
	The function is supplied two arguments, ID and value.
	The ID is the cooresponding table entry's ID, used to get the name under which the value was saved from our registration table.
	The value is the new value to update our array with. We also update our registration table with this value, to stay properly
	synchronized.
]]

function Gypsy_UpdateValue(id, value)
	-- Check the ID, error if it's invalid
	if (Gypsy_RetrieveOption(id) ~= nil) then
		-- Check to be certain this is an ID that has a valid value for modifying, error if not
		if (Gypsy_RetrieveOption(id)[GYPSY_VALUE] ~= nil) then
			-- Update our registration table
			Gypsy_RetrieveOption(id)[GYPSY_VALUE] = value;
			-- Get the name our value is saved under
			local name = Gypsy_RetrieveOption(id)[GYPSY_NAME];
			-- Update our saved values
			GYPSY_SAVED[name] = value;
		else
			Gypsy_Error("No value registered at ID "..id);
		end
	else
		Gypsy_Error("Invalid ID request, ID="..id);
	end
end

-- ** TAB/PANEL FUNCTIONS ** --

-- OnShow initializations for option tabs
function Gypsy_OptionsTabOnShow ()
	-- Set the tab text above all so it always shows
	this:SetFrameLevel("100");
	local id = this:GetID();
	if (not Gypsy_RetrieveOption(id)) then
		Gypsy_Error('Invalid options frame present, ID='..id..', object='..this:GetName());
	elseif (Gypsy_RetrieveOption(id)[GYPSY_TYPE] ~= "category") then
		Gypsy_Error('Invalid options frame type present, ID='..id..', object='..this:GetName());
	else
		-- Cooresponding button
		local button = getglobal("Gypsy_Tab"..id.."Button");
		if (button == nil) then
			Gypsy_Error('Failed to find tab button, id='..id);
		end
		-- And text for it
		local buttonText = getglobal("Gypsy_Tab"..id.."Text");
		if (buttonText == nil) then
			Gypsy_Error('Failed to find tab text, id='..id);
		end
		-- Cooresponding panel
		local panel = getglobal("Gypsy_OptionsPanel"..id);
		if (panel == nil) then
			Gypsy_Error('Failed to find panel frame, id='..id);
		end
		-- If this tab is shown by default, then..
		if (id == Gypsy_VisibleTab) then
			-- Set checked state to true
			button:SetChecked(1);
			-- Show cooresponding panel
			panel:Show();
			-- Set cooresponding button frame level up
			button:SetFrameLevel("5");
			-- Set cooresponding panel frame level below the button
			panel:SetFrameLevel("4");
			-- If tabs haven't been initialized, set it up
			if (Gypsy_TabInit == 0) then
				-- Set this tab to be at the top of the options menu
				button:ClearAllPoints();
				button:SetPoint("TOPRIGHT", "Gypsy_OptionsFrame", "TOPRIGHT", -4, -10);
				buttonText:ClearAllPoints();
				buttonText:SetPoint("LEFT", button:GetName(), "LEFT", 0, 0);
			end
		else
			-- If this is not the default tab, set cooresponding button below the panel level
			button:SetFrameLevel("3");
			-- If tabs haven't been initialized, set it up
			if (Gypsy_TabInit == 0) then
				-- Anchor this tab to the last tab
				local lastId = id-50;
				local lastButton = getglobal("Gypsy_Tab"..lastId.."Button");
				button:ClearAllPoints();
				button:SetPoint("TOP", lastButton:GetName(), "BOTTOM", 0, 0);
				buttonText:ClearAllPoints();
				buttonText:SetPoint("LEFT", button:GetName(), "LEFT", 0, 0);
			end
		end
		local label = Gypsy_RetrieveOption(id)[GYPSY_LABEL];
		-- Get this frame's font string object
		local labelString = getglobal(this:GetName().."Text");
		-- Set font string to read out the category string
		labelString:SetText(label);
	end
end

-- Set tab tooltip OnEnter
function Gypsy_OptionsTabOnEnter ()
	local id = this:GetID();
	if (not Gypsy_RetrieveOption(id)) then
		Gypsy_Error('Invalid options frame present, ID='..id..', object='..this:GetName());
	elseif (Gypsy_RetrieveOption(id)[GYPSY_TYPE] ~= "category") then
		Gypsy_Error('Invalid options frame type present, ID='..id..', object='..this:GetName());
	else
		local description = Gypsy_RetrieveOption(id)[GYPSY_TOOLTIP];
		GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
		GameTooltip:SetText(description, 1.0, 1.0, 1.0);
	end
end

-- Set clicked tab and show cooresponding panel
function Gypsy_OptionsTabOnClick ()
	local id = this:GetID();
	-- Cooresponding button
	local button = getglobal("Gypsy_Tab"..id.."Button");
	-- Cooresponding panel
	local panel = getglobal("Gypsy_OptionsPanel"..id);
	-- If this was checked true then...
	if (button:GetChecked()) then
		-- Show cooresponding panel
		panel:Show();
		-- Set this button above panel level
		button:SetFrameLevel("5");
		-- Set panel level, should not be necesary, but do it in case
		panel:SetFrameLevel("4");
		-- Make this the visible tab
		Gypsy_VisibleTab = id;
		-- Play clicking sound!
		PlaySound("igCharacterInfoTab");
	else
		-- If someone tries to uncheck, or click an already selected tab, then deny them
		button:SetChecked(1);
	end
	-- Update all other tabs
	Gypsy_OptionsUpdateTabs();
end

-- Set checked conditions for non-clicked tabs
function Gypsy_OptionsUpdateTabs()
	-- Total number of records in our data table
	local n = getn(GYPSY_REGISTRATIONS);
	-- For each record...
	for i=1, n do
		-- If it is a category..
		if (GYPSY_REGISTRATIONS[i][GYPSY_TYPE] == "category") then
			local id = GYPSY_REGISTRATIONS[i][GYPSY_ID];
			-- And is not currently shown...
			if (Gypsy_VisibleTab ~= id) then
				-- Button & panel 'id'
				local button = getglobal("Gypsy_Tab"..id.."Button")
				local panel = getglobal("Gypsy_OptionsPanel"..id);
				-- Set checked state to false
				button:SetChecked(0);	
				-- Set button level below current panel level
				button:SetFrameLevel("3");
				-- Set panel level to 0 in case clicks could fall through
				panel:SetFrameLevel("0");
				-- Hide this panel
				panel:Hide();
			end
		end	
	end
end		
	
-- ** HEADER FUNCTIONS ** --

-- Write label text to headers
function Gypsy_OptionsHeaderOnShow()
	this:SetFrameLevel("5");
	local id = this:GetID();
	if (not Gypsy_RetrieveOption(id)) then
		Gypsy_Error('Invalid options frame present, ID='..id..', object='..this:GetName());
	elseif (Gypsy_RetrieveOption(id)[GYPSY_TYPE] ~= "header") then
		Gypsy_Error('Invalid options frame type present, ID='..id..', object='..this:GetName());
	else
		local label = Gypsy_RetrieveOption(id)[GYPSY_LABEL];
		-- Get this frame's font string object
		local labelString = getglobal(this:GetName().."Text");
		-- Set font string to read out the header string
		labelString:SetText(label);
	end
end

-- Set header tooltip OnEnter
function Gypsy_OptionsHeaderOnEnter ()
	local id = this:GetID();
	if (not Gypsy_RetrieveOption(id)) then
		Gypsy_Error('Invalid options frame present, ID='..id..', object='..this:GetName());
	elseif (Gypsy_RetrieveOption(id)[GYPSY_TYPE] ~= "header") then
		Gypsy_Error('Invalid options frame type present, ID='..id..', object='..this:GetName());
	else
		local description = Gypsy_RetrieveOption(id)[GYPSY_TOOLTIP];
		GameTooltip:SetOwner(this, "ANCHOR_LEFT");
		GameTooltip:SetText(description, 1.0, 1.0, 1.0);
	end
end

-- ** PUSH BUTTON FUNCTIONS ** --

-- Initialize our push buttons according to stored variables and update the button
function Gypsy_OptionsButtonOnShow()
	local id = this:GetID();
	if (not Gypsy_RetrieveOption(id)) then
		Gypsy_Error('Invalid options frame present, ID='..id..', object='..this:GetName());
	elseif (Gypsy_RetrieveOption(id)[GYPSY_TYPE] ~= "button") then
		Gypsy_Error('Invalid options frame type present, ID='..id..', object='..this:GetName());
	else
		-- Need buttons to float above other objects
		this:SetFrameLevel("10");
		-- String to write on button
		local label = Gypsy_RetrieveOption(id)[GYPSY_LABEL];
		-- Get this frame's font string object
		local labelString = getglobal(this:GetName());
		labelString:SetText(label);
	end
end

-- Set button tooltip OnEnter
function Gypsy_OptionsButtonOnEnter ()
	local id = this:GetID();
	if (not Gypsy_RetrieveOption(id)) then
		Gypsy_Error('Invalid options frame present, ID='..id..', object='..this:GetName());
	elseif (Gypsy_RetrieveOption(id)[GYPSY_TYPE] ~= "button") then
		Gypsy_Error('Invalid options frame type present, ID='..id..', object='..this:GetName());
	else
		local description = Gypsy_RetrieveOption(id)[GYPSY_TOOLTIP];
		GameTooltip:SetOwner(this, "ANCHOR_LEFT");
		GameTooltip:SetText(description, 1.0, 1.0, 1.0);
	end
end

-- Change settings OnClick
function Gypsy_OptionsButtonOnClick()
	-- Simply get the cooresponding function and run it
	local id = this:GetID();
	local func = Gypsy_RetrieveOption(id)[GYPSY_FUNC];
	func();
	-- Play sound
	PlaySound("igMainMenuOption");
end

-- ** CHECKBUTTON FUNCTIONS ** --

-- Initialize our check buttons according to stored variables and update the check button
function Gypsy_OptionsCheckButtonOnShow()
	local id = this:GetID();
	if (not Gypsy_RetrieveOption(id)) then
		Gypsy_Error('Invalid options frame present, ID='..id..', object='..this:GetName());
	elseif (Gypsy_RetrieveOption(id)[GYPSY_TYPE] ~= "check") then
		Gypsy_Error('Invalid options frame type present, ID='..id..', object='..this:GetName());
	else
		local value = Gypsy_RetrieveOption(id)[GYPSY_VALUE];
		local label = Gypsy_RetrieveOption(id)[GYPSY_LABEL];
		local func = Gypsy_RetrieveOption(id)[GYPSY_FUNC];
		-- Get this frame's font string object
		local labelString = getglobal(this:GetName().."Text");
		-- Set font string to read out our description
		labelString:SetText(label);
		if (value == 1) then
			this:SetChecked(1);
		else
			this:SetChecked(0);
		end
		-- If this option has a function, run it initially - use this for disabling
		if (func) then
			func();
		end
	end
end

-- Set check button tooltip OnEnter
function Gypsy_OptionsCheckButtonOnEnter ()
	local id = this:GetID();
	if (not Gypsy_RetrieveOption(id)) then
		Gypsy_Error('Invalid options frame present, ID='..id..', object='..this:GetName());
	elseif (Gypsy_RetrieveOption(id)[GYPSY_TYPE] ~= "check") then
		Gypsy_Error('Invalid options frame type present, ID='..id..', object='..this:GetName());
	else
		local description = Gypsy_RetrieveOption(id)[GYPSY_TOOLTIP];
		GameTooltip:SetOwner(this, "ANCHOR_LEFT");
		GameTooltip:SetText(description, 1.0, 1.0, 1.0);
	end
end

-- Change settings OnClick
function Gypsy_OptionsCheckButtonOnClick()
	local id = this:GetID();
	-- Value of refering variable, 0/1
	local value = Gypsy_RetrieveOption(id)[GYPSY_VALUE];
	-- Update function to use for changes
	local func = Gypsy_RetrieveOption(id)[GYPSY_FUNC];
	-- Check for incoming checked status, change our variable accordingly, and then run our function for changes
	if (this:GetChecked()) then
		Gypsy_UpdateValue(id, 1);
		-- Skip executing the function if it isn't defined
		if (func ~= nil) then
			func();
		end
		-- Checking sound
		PlaySound("igMainMenuOptionCheckBoxOff");
	else
		Gypsy_UpdateValue(id, 0);
		if (func ~= nil) then
			func();
		end
		-- Checking sound
		PlaySound("igMainMenuOptionCheckBoxOn");
	end
end

-- ** SLIDER FUNCTIONS ** --

-- Initialize slider frames
function Gypsy_OptionsSliderOnShow()
	local id = this:GetID();
	-- Main title text
	local text = getglobal(this:GetName().."Text");
	-- Low end label text, default is "Low"
	local minText = getglobal(this:GetName().."Low");
	-- High end label text, default is "High"
	local maxText = getglobal(this:GetName().."High");
	-- Set the minimum and maximum values of our slider
	this:SetMinMaxValues(Gypsy_RetrieveOption(id)[GYPSY_SLIDMIN], Gypsy_RetrieveOption(id)[GYPSY_SLIDMAX]);
	-- Set the value stepping of our slider
	this:SetValueStep(Gypsy_RetrieveOption(id)[GYPSY_SLIDSTEP]);
	-- Set the initial value of our slider
	this:SetValue(Gypsy_RetrieveOption(id)[GYPSY_VALUE]);
	-- Set the title text
	text:SetText(Gypsy_RetrieveOption(id)[GYPSY_LABEL]);
	-- If we define a suffix for our low and high labels, then substitute the min and max values and add the suffix
	if (Gypsy_RetrieveOption(id)[GYPSY_SLIDUNIT] ~= nil) then
		minText:SetText(Gypsy_RetrieveOption(id)[GYPSY_SLIDMIN]..Gypsy_RetrieveOption(id)[GYPSY_SLIDUNIT]);
		maxText:SetText(Gypsy_RetrieveOption(id)[GYPSY_SLIDMAX]..Gypsy_RetrieveOption(id)[GYPSY_SLIDUNIT]);
	end
end

-- Set slider tooltip OnEnter
function Gypsy_OptionsSliderOnEnter ()
	local id = this:GetID();
	if (not Gypsy_RetrieveOption(id)) then
		Gypsy_Error('Invalid options frame present, ID='..id..', object='..this:GetName());
	elseif (Gypsy_RetrieveOption(id)[GYPSY_TYPE] ~= "slider") then
		Gypsy_Error('Invalid options frame type present, ID='..id..', object='..this:GetName());
	else
		local description = Gypsy_RetrieveOption(id)[GYPSY_TOOLTIP];
		GameTooltip:SetOwner(this, "ANCHOR_LEFT");
		GameTooltip:SetText(description, 1.0, 1.0, 1.0);
	end
end

-- Update our value and run the update function when the value is changed
function Gypsy_OptionsSliderOnValueChanged()
	local id = this:GetID();
	-- Get the slider value into our array
	--Gypsy_RetrieveOption(id)[GYPSY_VALUE] = this:GetValue();
	Gypsy_UpdateValue(id, this:GetValue());
	-- Get cooresponding function
	local func = Gypsy_RetrieveOption(id)[GYPSY_FUNC];
	-- Run the function
	func();
	-- Play sound
	PlaySound("igMainMenuOptionCheckBoxOn");
end
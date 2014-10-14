-- myClock v1.8 --


--------------------------------------------------------------------------------------------------
-- Global variables
--------------------------------------------------------------------------------------------------

myClockOptions = {};


--------------------------------------------------------------------------------------------------
-- Local variables
--------------------------------------------------------------------------------------------------

local MYCLOCK_DEFAULT_SHOW_CLOCK = 1;
local MYCLOCK_DEFAULT_SHOW_DAYNIGHT = nil;
local MYCLOCK_DEFAULT_LOCK = 1;
local MYCLOCK_DEFAULT_HALFHOUR_OFFSETS = nil;
local MYCLOCK_DEFAULT_OFFSET = 0;
local MYCLOCK_NAME = "myClock";
local MYCLOCK_VERSION = "1.8";
local MYCLOCK_AUTHOR = "Scheid";
local MYCLOCK_EMAIL = "scheid@free.fr";
local MYCLOCK_WEBSITE = "http://scheid.free.fr";
local MYCLOCK_OPTIONS_FRAME = "myClockOptionsFrame";


--------------------------------------------------------------------------------------------------
-- Event functions
--------------------------------------------------------------------------------------------------

-- OnLoad event
function myClockFrame_OnLoad()

	-- Register the events that need to be watched
	this:RegisterEvent("ADDON_LOADED");
	
	-- Register the slash command
	SLASH_MYCLOCK1 = "/myclock";
	SlashCmdList["MYCLOCK"] = function()
		myClockOptionsFrame:Show();
	end

end

-- OnEvent event
function myClockFrame_OnEvent()

	if (event == "ADDON_LOADED" and arg1 == MYCLOCK_NAME) then
		-- Initialize the addon
		myClockFrame_Initialize();
	end

end

-- OnUpdate event
function myClockFrame_OnUpdate(elapsed)

	-- Check if the clock is visible
	if (this:IsVisible()) then
		-- Check if an update is needed
		if ( this.updateTimer <= elapsed ) then
			this.updateTimer = FRAMERATE_FREQUENCY;
			-- Get the server time
			local hour, minute = GetGameTime();
			-- Apply the offset option
			hour = hour + myClockOptions.offset;
			-- Apply the half hour offsets option
			if (myClockOptions.halfhourOffsets) then
				minute = minute + 30;
			end
			-- Check the minutes
			if (minute >= 60) then
				minute = minute - 60;
				hour = hour + 1;
			end
			-- Check the hours
			if (hour >= 24) then
				hour = hour - 24;
			elseif (hour < 0) then
				hour = hour + 24;
			end
			-- Check the time format option
			if (myClockOptions.timeFormat == 24) then
				myClockTimeFrameText:SetText(format(TEXT(TIME_TWENTYFOURHOURS), hour, minute));
			else
				local pm = 0;
				if (hour >= 12) then
					pm = 1;
				end
				if (hour > 12) then
					hour = hour - 12;
				end
				if (hour == 0) then
					hour = 12;
				end
				if (pm == 0) then
					myClockTimeFrameText:SetText(string.gsub(string.sub(format(TEXT(TIME_TWELVEHOURAM), hour, minute),1,5)," ","").." AM");
				else
					myClockTimeFrameText:SetText(string.gsub(string.sub(format(TEXT(TIME_TWELVEHOURPM), hour, minute),1,5)," ","").." PM");
				end
			end
		else
			this.updateTimer = this.updateTimer - elapsed;
		end
	end

end


--------------------------------------------------------------------------------------------------
-- Initialize functions
--------------------------------------------------------------------------------------------------

-- Initialize the addon
function myClockFrame_Initialize()

	-- Initialize the options
	myClockFrame_InitializeOptions();
	
	-- Initialize the display
	myClockFrame_Update();
	
	-- Check if myAddOns is loaded
	if (myAddOnsFrame_Register) then
		-- Initialize the addon's details
		local myClockDetails = {
			name = MYCLOCK_NAME,
			version = MYCLOCK_VERSION,
			releaseDate = MYCLOCK_RELEASE_DATE,
			author = MYCLOCK_AUTHOR,
			email = MYCLOCK_EMAIL,
			website = MYCLOCK_WEBSITE,
			category = MYADDONS_CATEGORY_OTHERS,
			optionsframe = MYCLOCK_OPTIONS_FRAME
		};
		-- Initialize the addon's help
		local myClockHelp = {
			MYCLOCK_HELP_PAGE1
		};
		-- Register the addon in myAddOns
		myAddOnsFrame_Register(myClockDetails, myClockHelp);
	else
		-- Display a message in the ChatFrame indicating a successful load of the addon
		DEFAULT_CHAT_FRAME:AddMessage(MYCLOCK_LOADED, 1.0, 1.0, 0.0);
	end

end

-- Initialize the options
function myClockFrame_InitializeOptions()

	-- Check the show clock option
	if (not myClockOptions.showClock) then
		myClockOptions.showClock = MYCLOCK_DEFAULT_SHOW_CLOCK;
	end
	
	-- Check the show day/night option
	if (not myClockOptions.showDayNight) then
		myClockOptions.showDayNight = MYCLOCK_DEFAULT_SHOW_DAYNIGHT;
	end
	
	-- Check the lock option
	if (not myClockOptions.lock) then
		myClockOptions.lock = MYCLOCK_DEFAULT_LOCK;
	end
	
	-- Check the halfhour offsets option
	if (not myClockOptions.halfhourOffsets) then
		myClockOptions.halfhourOffsets = MYCLOCK_DEFAULT_HALFHOUR_OFFSETS;
	end
	
	-- Check the timeformat option
	if (not myClockOptions.timeFormat) then
		myClockOptions.timeFormat = MYCLOCK_DEFAULT_TIME_FORMAT;
	end
	
	-- Check the offset option
	if (not myClockOptions.offset) then
		myClockOptions.offset = MYCLOCK_DEFAULT_OFFSET;
	end

end


--------------------------------------------------------------------------------------------------
-- Display functions
--------------------------------------------------------------------------------------------------

-- Update the display
function myClockFrame_Update()

	-- Reset the update timer
	myClockFrame.updateTimer = 0;
	
	-- Check the show clock option
	if (myClockOptions.showClock) then
		myClockFrame:Show();
	else
		myClockFrame:Hide();
	end
	
	-- Check the show day/night option
	if (myClockOptions.showDayNight) then
		GameTimeFrame:Show();
	else
		GameTimeFrame:Hide();
	end
	
	-- Check the lock option
	if (myClockOptions.lock) then
		myClockFrame:SetHeight(1);
		myClockFrame:SetWidth(1);
	else
		myClockFrame:SetHeight(24);
		myClockFrame:SetWidth(70);
	end

end


-- myMemory v1.2 --


--------------------------------------------------------------------------------------------------
-- Overriden functions
--------------------------------------------------------------------------------------------------

-- Save the original ToggleFramerate function
myToggleFramerate = ToggleFramerate;

-- Override the ToggleFramerate function to toggle the memory usage at the same time
function ToggleFramerate()

	-- Toggle the framerate display with the original ToggleFramerate function
	myToggleFramerate();
	
	-- Check if the framerate is visible
	if (FramerateLabel:IsVisible()) then
		myMemoryLabel:Show();
		myMemoryText:Show();
	else
		myMemoryLabel:Hide();
		myMemoryText:Hide();
	end
	
	-- Reset the update timer
	myMemoryFrame.updateTimer = 0;

end


--------------------------------------------------------------------------------------------------
-- Event functions
--------------------------------------------------------------------------------------------------

-- OnUpdate Event
function myMemoryFrame_OnUpdate(elapsed)

	-- Check if the memory usage is visible
	if (myMemoryLabel:IsVisible()) then
		-- Check if an update is needed
		if ( this.updateTimer <= elapsed ) then
			this.updateTimer = FRAMERATE_FREQUENCY;
			myMemoryText:SetText(math.floor(gcinfo()*1000/1024)/1000);
		else
			this.updateTimer = this.updateTimer - elapsed;
		end
	end

end

--[[
--	Minimap Button Mobility Code
--  Adapted from Earth Code
--]]

function RaidHealer_MinimapButton_OnLoad()
	this:RegisterEvent("VARIABLES_LOADED");
	RaidHealer_MinimapButton:SetFrameLevel(MinimapZoomIn:GetFrameLevel());
end

function RaidHealer_MinimapButton_Reset()
	--fixes a mysterious frame level problem that would hide  behind some unknown minimap frame.
	ToggleWorldMap();
	ToggleWorldMap(); 
end

function RaidHealer_MinimapButton_OnEvent(event)
	if (event == "VARIABLES_LOADED") then
		if ((RaidHealer_GlobalConfig["MINIMAP_SHOW"] ~= nil)) then
			if ((RaidHealer_GlobalConfig["MINIMAP_POS"])) then
				RaidHealer_SetMinimapButtonPos(RaidHealer_GlobalConfig["MINIMAP_POS"]);
			else
				RaidHealer_MinimapButton_Reset();
			end
			RaidHealer_MinimapButtonToggle(RaidHealer_GlobalConfig["MINIMAP_SHOW"])
		else
			RaidHealer_MinimapButton_Reset();
		end
	end
end

function RaidHealer_MinimapButton_OnMouseDown()
	if (IsShiftKeyDown()) then
		if ( arg1 == "RightButton" ) then
			--wait for reset
		else
			this.isMoving = true;
		end
	end
end

function RaidHealer_MinimapButton_OnMouseUp()
	if (MouseIsOver(RaidHealer_MinimapButton)) then
		if ( arg1 == "RightButton" ) then
			if (IsShiftKeyDown())  then
				RaidHealer_MinimapButton_Reset();
			end
		else
			RaidHealer_ToggleMainFrame();
		end
	end
end

function RaidHealer_MinimapButton_OnHide()
	this.isMoving = false;
end

function RaidHealer_MinimapButton_OnUpdate()
	if (this.isMoving) then
		local mouseX, mouseY = GetCursorPosition();
		local centerX, centerY = Minimap:GetCenter();
		local scale = Minimap:GetEffectiveScale();
		mouseX = mouseX / scale;
		mouseY = mouseY / scale;
		local radius = (Minimap:GetWidth()/2) + (this:GetWidth()/3);
		local x = math.abs(mouseX - centerX);
		local y = math.abs(mouseY - centerY);
		local xSign = 1;
		local ySign = 1;
		if not (mouseX >= centerX) then
			xSign = -1;
		end
		if not (mouseY >= centerY) then
			ySign = -1;
		end
		--Sea.io.print(xSign*x,", ",ySign*y);
		local angle = math.atan(x/y);
		x = math.sin(angle)*radius;
		y = math.cos(angle)*radius;
		this.currentX = xSign*x;
		this.currentY = ySign*y;
		this:SetPoint("CENTER", "Minimap", "CENTER", this.currentX, this.currentY);
	end
end

function RaidHealer_SetMinimapButtonPos(pos)
	RaidHealer_GlobalConfig["MINIMAP_POS"] = pos;
	RaidHealer_MinimapButton:ClearAllPoints();
	RaidHealer_MinimapButton:SetPoint("TOPLEFT", "Minimap", "TOPLEFT", 52 - (80 * cos(pos)), (80 * sin(pos)) - 52);
end

function RaidHealer_MinimapButton_Reset()
	RaidHealer_GlobalConfig["MINIMAP_SHOW"] = true;
	RaidHealer_SetMinimapButtonPos(RAIDHEALER_DEFAULT_MINIMAP_POS);
end

function RaidHealer_MinimapButtonToggle(show)
	if (show == true) then
		RaidHealer_MinimapButton:Show();
	else
		RaidHealer_MinimapButton:Hide();
	end
end
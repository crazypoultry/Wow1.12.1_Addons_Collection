--[[
	Gypsy_UnitBars.lua
	GypsyVersion++2004.11.08++
]]

-- ** DEFAULT SETTINGS ** --

-- Enable unit bars by default
Gypsy_DefaultEnableUnitBars = 1;
-- Local lock variables for unit bar capsule locks
Gypsy_DefaultLockPlayerFrameCapsule = 0;
Gypsy_DefaultLockTargetFrameCapsule = 0;
Gypsy_DefaultLockPartyFrameCapsule = 0;
-- Group unit frames by default
Gypsy_DefaultGroupUnitFrames = 1;
-- Invert unit frames by default
Gypsy_DefaultInvertUnitFrames = 1;

-- Default GypsyMod positions for each frame when it's inverted
Gypsy_InvertCapsulePositions = {};
Gypsy_InvertCapsulePositions["Player"] = {point = "BOTTOMLEFT", rel = "UIParent"};
Gypsy_InvertCapsulePositions["Target"] = {point = "BOTTOM", rel = "Gypsy_PlayerFrameCapsule", relPoint = "TOP", x = "15", y = "5"};
Gypsy_InvertCapsulePositions["Party"] = {point = "BOTTOM", rel = "Gypsy_TargetFrameCapsule", relPoint = "TOP", x = "-54", y = "-5"};
Gypsy_InvertCapsulePositions["Pet"] = {point = "BOTTOMLEFT", rel = "PlayerFrame", relPoint = "TOPLEFT", x = "83", y = "-28"};
Gypsy_InvertCapsulePositions["PartyMember1"] = {point = "BOTTOMLEFT", rel = "Gypsy_PartyFrameCapsuleArt", relPoint = "BOTTOMLEFT", x = "5", y = "25"};

-- Default positions for each frame normally
Gypsy_DefaultCapsulePositions = {};
Gypsy_DefaultCapsulePositions["Player"] = {point = "TOPLEFT", rel = "UIParent"};
Gypsy_DefaultCapsulePositions["Target"] = {point = "TOPLEFT", rel = "Gypsy_PlayerFrameCapsule", relPoint = "TOPRIGHT", x = "0", y = "2"};
Gypsy_DefaultCapsulePositions["Party"] = {point = "TOP", rel = "Gypsy_PlayerFrameCapsule", relPoint = "BOTTOM", x = "-40", y = "0"};
Gypsy_DefaultCapsulePositions["Pet"] = {point = "TOPLEFT", rel = "PlayerFrame", relPoint="TOPLEFT", x = "85", y = "-75"};
Gypsy_DefaultCapsulePositions["PartyMember1"] = {point = "TOPLEFT", rel = "Gypsy_PartyFrameCapsuleArt", relPoint = "TOPLEFT", x = "5", y = "-5"};

-- Default screen location of the player capsule
Gypsy_DefaultPlayerCapsuleLeft = 0;
Gypsy_DefaultPlayerCapsuleTop = 1199.999058247

-- ** GENERAL VARIABLES ** -- 

-- Pet offset distance
Gypsy_PetOffset = 30;

-- ** CAPSULE FRAME INITIALIZATION FUNCTIONS ** --

function Gypsy_PlayerFrameCapsuleOnLoad ()
	-- Required registrations, other capsules don't do this
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("PLAYER_PET_CHANGED");
end

function Gypsy_PlayerFrameCapsuleOnEvent (event)
	-- Check for pet summon/dismiss, and update our frames
	if (event == "PLAYER_PET_CHANGED") then
		Gypsy_UpdateUnitFrames();
		return;
	end
	-- Take care of configuration options once saved variables are in
	if (event == "VARIABLES_LOADED") then
		-- If our GypsyMod shell is present, use that, else register our variables for saves and register slash commands
		if (GYPSY_SHELL == 1) then
			-- Get saved information for our settings if it exists, else set defaults
			if (Gypsy_RetrieveSaved("EnableUnitBars") == nil) then
				Gypsy_EnableUnitBars = Gypsy_DefaultEnableUnitBars;
			else
				Gypsy_EnableUnitBars = Gypsy_RetrieveSaved("EnableUnitBars");
			end
			if (Gypsy_RetrieveSaved("GroupUnitFrames") == nil) then
				Gypsy_GroupUnitFrames = Gypsy_DefaultGroupUnitFrames;
			else
				Gypsy_GroupUnitFrames = Gypsy_RetrieveSaved("GroupUnitFrames");
			end
			if (Gypsy_RetrieveSaved("InvertUnitFrames") == nil) then
				Gypsy_InvertUnitFrames = Gypsy_DefaultInvertUnitFrames;
			else
				Gypsy_InvertUnitFrames = Gypsy_RetrieveSaved("InvertUnitFrames");
			end
			-- GypsyMod registrations
			Gypsy_RegisterOption(200, "category", nil, nil, nil, GYPSY_TEXT_UNITBARS_TABLABEL, GYPSY_TEXT_UNITBARS_TABTOOLTIP);
			Gypsy_RegisterOption(201, "check", Gypsy_GroupUnitFrames, "GroupUnitFrames", Gypsy_UpdateUnitFrames, GYPSY_TEXT_UNITBARS_GROUPLABEL, GYPSY_TEXT_UNITBARS_GROUPTOOLTIP);
			Gypsy_RegisterOption(202, "check", Gypsy_InvertUnitFrames, "InvertUnitFrames", Gypsy_UpdateUnitFrames, GYPSY_TEXT_UNITBARS_INVERTLABEL, GYPSY_TEXT_UNITBARS_INVERTTOOLTIP);
			Gypsy_RegisterOption(203, "button", nil, nil, Gypsy_ResetUnitFrames, GYPSY_TEXT_UNITBARS_RESETLABEL, GYPSY_TEXT_UNITBARS_RESETTOOLTIP);
			--Gypsy_RegisterOption(204, "check", Gypsy_EnableUnitBars, "EnableUnitBars", Gypsy_UpdateUnitFrames, "Enable UnitBars", "Toggle the GypsyMod UnitBars modifications.");
		else
			-- Set values to default if they have not been previously saved
			if (Gypsy_EnableUnitBars == nil) then
				Gypsy_EnableUnitBars = Gypsy_DefaultEnableUnitBars;
			end
			if (Gypsy_GroupUnitFrames == nil) then
				Gypsy_GroupUnitFrames = Gypsy_DefaultGroupUnitFrames;
			end
			if (Gypsy_InvertUnitFrames == nil) then
				Gypsy_InvertUnitFrames = Gypsy_DefaultInvertUnitFrames;
			end
			if (Gypsy_LockPartyFrameCapsule == nil) then
				Gypsy_LockPartyFrameCapsule = Gypsy_DefaultLockPartyFrameCapsule;
			end
			if (Gypsy_LockTargetFrameCapsule == nil) then
				Gypsy_LockTargetFrameCapsule = Gypsy_DefaultLockTargetFrameCapsule;
			end
			if (Gypsy_LockPartyFrameCapsule == nil) then
				Gypsy_LockPartyFrameCapsule = Gypsy_DefaultLockPartyFrameCapsule;
			end
			-- Save manually for standalone options
			--RegisterForSave("Gypsy_EnableUnitBars");
			--RegisterForSave("Gypsy_GroupUnitFrames");
			--RegisterForSave("Gypsy_InvertUnitFrames");
			--RegisterForSave("Gypsy_LockPartyFrameCapsule");
			--RegisterForSave("Gypsy_LockTargetFrameCapsule");
			--RegisterForSave("Gypsy_LockPartyFrameCapsule");
			-- Register slash commands
			--SlashCmdList["GYPSY_ENABLEUNITBARS"] = Gypsy_EnableUnitBarsSlashHandler;
			--SLASH_GYPSY_ENABLEUNITBARS1 = "/unitbarenable";
			--SLASH_GYPSY_ENABLEUNITBARS2 = "/ubenable";
			SlashCmdList["GYPSY_GROUPUNITFRAMES"] = Gypsy_GroupUnitFramesSlashHandler;
			SLASH_GYPSY_GROUPUNITFRAMES1 = "/unitbargroupunitframes";
			SLASH_GYPSY_GROUPUNITFRAMES2 = "/ubgroupunitframes";	
			SlashCmdList["GYPSY_INVERTUNITFRAMES"] = Gypsy_InvertUnitFramesSlashHandler;
			SLASH_GYPSY_INVERTUNITFRAMES1 = "/unitbarinvertunitframes";
			SLASH_GYPSY_INVERTUNITFRAMES2 = "/ubinvertunitframes";
			SlashCmdList["GYPSY_RESETUNITFRAMES"] = Gypsy_ResetUnitFramesSlashHandler;
			SLASH_GYPSY_RESETUNITFRAMES1 = "/unitbarreset";
			SLASH_GYPSY_RESETUNITFRAMES2 = "/ubreset";
			SlashCmdList["GYPSY_LOCKPLAYERCAPSULE"] = Gypsy_LockPlayerCapsuleSlashHandler;
			SLASH_GYPSY_LOCKPLAYERCAPSULE1 = "/unitbarlockplayer";
			SLASH_GYPSY_LOCKPLAYERCAPSULE2 = "/ublockplayer";
			SlashCmdList["GYPSY_LOCKTARGETCAPSULE"] = Gypsy_LockTargetCapsuleSlashHandler;
			SLASH_GYPSY_LOCKTARGETCAPSULE1 = "/unitbarlocktarget";
			SLASH_GYPSY_LOCKTARGETCAPSULE2 = "/ublocktarget";
			SlashCmdList["GYPSY_LOCKPARTYCAPSULE"] = Gypsy_LockPartyCapsuleSlashHandler;
			SLASH_GYPSY_LOCKPARTYCAPSULE1 = "/unitbarlockparty";
			SLASH_GYPSY_LOCKPARTYCAPSULE2 = "/ublockparty";
		end	
		-- Update our unit frames to an initial state
		Gypsy_UpdateUnitFrames(0, 1);
		return;
	end
end

function Gypsy_PlayerFrameCapsuleArtOnShow ()
	-- Make sure things are anchored for grouping if they need to be when we attempt to move
	Gypsy_UpdateUnitFrames(0);
end

-- ** CAPSULE ART DISPLAY FUNCTIONS ** --

function Gypsy_UnitBarOnUpdate ()
	-- Check whether the mouse is over the player frame capsule to show or hide it
	Gypsy_TogglePlayerFrameCapsule();
	-- Temporary fix for conflicting default chat frame position
	if (DEFAULT_CHAT_FRAME and not DEFAULT_CHAT_FRAME:IsUserPlaced()) then
		DEFAULT_CHAT_FRAME:ClearAllPoints();
		DEFAULT_CHAT_FRAME:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOMLEFT", 320, 30);
	end
end

function Gypsy_TogglePlayerFrameCapsule ()
	-- If Shell is present, update the local lock setting
	if (GYPSY_SHELL ~= nil) then
		Gypsy_LockPlayerFrameCapsule = GYPSY_LOCKALL;
	end	
	-- Then, if the player frame is not locked, go ahead and show/hide or drag the capsule as needed, or if it is locked, hide the capsule so it can't be dragged
	if (Gypsy_LockPlayerFrameCapsule == 0) then
		-- Make sure the capsule is showing, it might have been previously hidden
		if (not Gypsy_PlayerFrameCapsule:IsVisible()) then
			Gypsy_PlayerFrameCapsule:Show();
		end
		-- Quick function to check if the mouse is anywhere over our capsule
		if (MouseIsOver(Gypsy_PlayerFrameCapsule)) then
			-- Show the player frame art
			Gypsy_PlayerFrameCapsuleArt:Show();
			-- If the unit frames are grouped, show the others
			if (Gypsy_GroupUnitFrames == 1) then
				Gypsy_TargetFrameCapsule:Show();
				Gypsy_TargetFrameCapsuleArt:Show();
				Gypsy_PartyFrameCapsule:Show();
				Gypsy_PartyFrameCapsuleArt:Show();			
			end
		else
			-- Hide the player frame art
			Gypsy_PlayerFrameCapsuleArt:Hide();
			-- If the unit frames are grouped, hide the others - we have to hide the capsules themselves to prevent dragging
			if (Gypsy_GroupUnitFrames == 1) then
				Gypsy_TargetFrameCapsule:Hide();
				Gypsy_TargetFrameCapsuleArt:Hide();
				Gypsy_PartyFrameCapsule:Hide();
				Gypsy_PartyFrameCapsuleArt:Hide();			
			end
		end
	else
		Gypsy_PlayerFrameCapsule:Hide();
		if (Gypsy_GroupUnitFrames == 1) then
			Gypsy_TargetFrameCapsule:Hide();
			Gypsy_PartyFrameCapsule:Hide();
		end
	end
end

function Gypsy_TargetFrameCapsuleOnUpdate ()
	-- Check whether the mouse is over the target frame capsule to show or hide it, if unit frames are ungrouped
	Gypsy_ToggleTargetFrameCapsule();
end

function Gypsy_ToggleTargetFrameCapsule ()
	-- If Shell is present, update the local lock setting
	if (GYPSY_SHELL ~= nil) then
		Gypsy_LockTargetFrameCapsule = GYPSY_LOCKALL;
	end	
	-- Then, if the target capsule is not locked, go ahead and show/hide or drag the capsule as needed, or if it is locked, hide the capsule so it can't be dragged
	if (Gypsy_LockTargetFrameCapsule == 0) then
		if (Gypsy_RetrieveOption ~= nil) then
			if (Gypsy_RetrieveOption(201) ~= nil) then
				Gypsy_GroupUnitFrames = Gypsy_RetrieveOption(201)[GYPSY_VALUE];
			end
		end
		-- Make sure the capsule is showing, it might have been previously hidden, ONLY if frames are ungrouped
		if (Gypsy_GroupUnitFrames ~= 1) then
			Gypsy_TargetFrameCapsule:Show();
			if (MouseIsOver(Gypsy_TargetFrameCapsule)) then
				Gypsy_TargetFrameCapsuleArt:Show();
			else
				Gypsy_TargetFrameCapsuleArt:Hide();
			end
		end
	else
		Gypsy_TargetFrameCapsule:Hide();
	end
end

function Gypsy_PartyFrameCapsuleOnUpdate ()
	-- Check whether the mouse is over the party frame capsule to show or hide it, if unit frames are ungrouped
	Gypsy_TogglePartyFrameCapsule();
end

function Gypsy_TogglePartyFrameCapsule ()
	-- If Shell is present, update the local lock setting
	if (GYPSY_SHELL ~= nil) then
		Gypsy_LockPartyFrameCapsule = GYPSY_LOCKALL;
	end	
	-- Then, if GypsyMod is not locked, go ahead and show/hide or drag the capsule as needed, or if it is locked, hide the capsule so it can't be dragged
	if (Gypsy_LockPartyFrameCapsule == 0) then
		if (Gypsy_RetrieveOption ~= nil) then
			if (Gypsy_RetrieveOption(201) ~= nil) then
				Gypsy_GroupUnitFrames = Gypsy_RetrieveOption(201)[GYPSY_VALUE];
			end
		end
		-- Make sure the capsule is showing, it might have been previously hidden, ONLY if frames are ungrouped
		if (Gypsy_GroupUnitFrames ~= 1) then
			Gypsy_PartyFrameCapsule:Show();
			if (MouseIsOver(Gypsy_PartyFrameCapsule)) then
				Gypsy_PartyFrameCapsuleArt:Show();
			else
				Gypsy_PartyFrameCapsuleArt:Hide();
			end
		end
	else
		Gypsy_PartyFrameCapsule:Hide();
	end	
end

-- ** UNIT FRAME POSITIONING FUNCTIONS ** --

--[[
	Gypsy_UpdateUnitFrames
	This is the function to update all aspects of our unit frames in one fell swoop.
	
	This function accepts two arguments, reset and load. 
	a) If reset is undefined or nil, and the frames are set to group, then two things can happen. 
		1) If the invert option has been changed, then reset will be set to 1, and all frames will move to the default locations, depending on what the invert
			option was changed to.
		2) If the invert option was not changed, then reset will be set to 0, and all frames will re-anchored to the player frame, but the player frame
			will stay where it is.
	b) If reset is undefined or nil, and the frames are not set to group, then all that we do is make sure the various capsule frames are shown for movement.
	c) If reset is defined as 0, then all frames will be re-anchored to the player frame, and the player frame will stay put.
	d) If reset is defined as 1, then the player frame will be re-anchored to it's default position, depending on invert status, and all frames re-anchored to it.
	e) If load is set to non-nil, and the frames are set to group, and not inverted, then the player frame will return to it's default inverted position unless
		the player frame has been moved with the mouse, in which case it will be where it was put.
	
	No other possibilities should result in anything happening.
]]

function Gypsy_UpdateUnitFrames (reset, load) 	
	if (Gypsy_RetrieveOption ~= nil) then
		-- Update our local variables with updated settings from GypsyMod if applicable	
		--if (Gypsy_RetrieveOption(204) ~= nil) then
		--	Gypsy_EnableUnitBars = Gypsy_RetrieveOption(204)[GYPSY_VALUE];
		--end
		if (Gypsy_RetrieveOption(201) ~= nil) then
			Gypsy_GroupUnitFrames = Gypsy_RetrieveOption(201)[GYPSY_VALUE];
		end
		if (Gypsy_RetrieveOption(202) ~= nil) then
			-- If reset is not defined...
			if (reset == nil) then
				-- And the invert option was changed
				if (Gypsy_InvertUnitFrames ~= Gypsy_RetrieveOption(202)[GYPSY_VALUE]) then
					-- Then call to reset positions
					reset = 1;
				end
			end
			Gypsy_InvertUnitFrames = Gypsy_RetrieveOption(202)[GYPSY_VALUE];
		end	
	end
	if (Gypsy_EnableUnitBars == 1) then
		if (load ~= nil) then
			-- Make sure our art frame stays behind everything
			Gypsy_PlayerFrameCapsuleArt:SetFrameLevel("0");
			-- Setup the art frame colors
			Gypsy_PlayerFrameCapsuleArt:SetBackdropBorderColor(0, 0, 0);
			Gypsy_PlayerFrameCapsuleArt:SetBackdropColor(0, 0, 0);	
			-- Get the default player frame anchored to our capsule for movement and other functions
			PlayerFrame:ClearAllPoints();
			PlayerFrame:SetPoint("BOTTOMLEFT", "Gypsy_PlayerFrameCapsule", "BOTTOMLEFT", -22, -13);
			-- Make sure our art frame stays behind everything
			Gypsy_TargetFrameCapsuleArt:SetFrameLevel("0");
			-- Setup the art frame colors
			Gypsy_TargetFrameCapsuleArt:SetBackdropBorderColor(0, 0, 0);
			Gypsy_TargetFrameCapsuleArt:SetBackdropColor(0, 0, 0);
			-- Get the default target frame anchored to our capsule for movement and other functions
			TargetFrame:ClearAllPoints();
			TargetFrame:SetPoint("BOTTOMLEFT", "Gypsy_TargetFrameCapsule", "BOTTOMLEFT", 5, -20);
			-- Make sure our art frame stays behind everything
			Gypsy_PartyFrameCapsuleArt:SetFrameLevel("0");
			-- Setup the art frame colors
			Gypsy_PartyFrameCapsuleArt:SetBackdropBorderColor(0, 0, 0);
			Gypsy_PartyFrameCapsuleArt:SetBackdropColor(0, 0, 0);
		end
		-- By this point, if reset is still undefined, then we do not want to reset positions
		if (reset == nil) then
			reset = 0;
		end
		local button = getglobal("Gypsy_Option202");
		local string = getglobal("Gypsy_Option202Text");	
		-- If frames are grouped, then we may move them, else just make sure our capsules are shown for dragging
		if (Gypsy_GroupUnitFrames == 1) then
			-- If the shell is present, enable the button
			if (GYPSY_SHELL == 1) then
				button:Enable();
				string:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
			end
			-- Two seperate sets of locations for if our frames are inverted or not
			if (Gypsy_InvertUnitFrames == 1) then
				-- Get anchor info from the stored table
				local playerAnchor = Gypsy_InvertCapsulePositions["Player"];
				local targetAnchor = Gypsy_InvertCapsulePositions["Target"];
				local partyAnchor = Gypsy_InvertCapsulePositions["Party"];
				local petAnchor = Gypsy_InvertCapsulePositions["Pet"];
				local partyMemberAnchor = Gypsy_InvertCapsulePositions["PartyMember1"];
				-- If we're resetting positions, move the player frame capsule to it's default spot
				if (reset == 1) then
					Gypsy_PlayerFrameCapsule:ClearAllPoints();
					Gypsy_PlayerFrameCapsule:SetPoint(playerAnchor.point, playerAnchor.rel);
				end
				-- No matter what, make sure the other capsules are in their proper place in relation to the player frame
				Gypsy_TargetFrameCapsule:ClearAllPoints();
				Gypsy_TargetFrameCapsule:SetPoint(targetAnchor.point, targetAnchor.rel, targetAnchor.relPoint, targetAnchor.x, targetAnchor.y);
				Gypsy_PartyFrameCapsule:ClearAllPoints();
				Gypsy_PartyFrameCapsule:SetPoint(partyAnchor.point, partyAnchor.rel, partyAnchor.relPoint, partyAnchor.x, partyAnchor.y);
				PartyMemberFrame1:ClearAllPoints();
				PartyMemberFrame1:SetPoint(partyMemberAnchor.point, partyMemberAnchor.rel, partyMemberAnchor.relPoint, partyMemberAnchor.x, partyMemberAnchor.y);
				-- Update the pet frame location and make adjustments to the other capsules if applicable
				Gypsy_UpdatePetFrame();
				-- Update the order of the party frames
				for i=2, 4 do
					Gypsy_UnitUpdatePartyFrame(i);
				end
			else
				-- Get anchor info from the stored table
				local playerAnchor = Gypsy_DefaultCapsulePositions["Player"];
				local targetAnchor = Gypsy_DefaultCapsulePositions["Target"];
				local partyAnchor = Gypsy_DefaultCapsulePositions["Party"];
				local petAnchor = Gypsy_DefaultCapsulePositions["Pet"];
				local partyMemberAnchor = Gypsy_DefaultCapsulePositions["PartyMember1"];
				-- If we're resetting positions, move the player frame capsule to it's default spot
				if (reset == 1) then
					Gypsy_PlayerFrameCapsule:ClearAllPoints();
					Gypsy_PlayerFrameCapsule:SetPoint(playerAnchor.point, playerAnchor.rel);
				end
				-- If we're just loading up, make sure the player frame is in it's correct spot - this occurs before cached user defined positions load
				if (load ~= nil) then
					-- Get the left and top locations of the capsule currently
					local left = Gypsy_PlayerFrameCapsule:GetLeft();
					local top = Gypsy_PlayerFrameCapsule:GetTop();
					-- If the current location is not what it should be, then make it so
					if (left ~= Gypsy_DefaultPlayerCapsuleLeft or top ~= Gypsy_DefaultPlayerCapsuleTop) then
						Gypsy_PlayerFrameCapsule:ClearAllPoints();
						Gypsy_PlayerFrameCapsule:SetPoint(playerAnchor.point, playerAnchor.rel);
					end
				end
				-- No matter what, make sure the other capsules are in their proper place in relation to the player frame
				Gypsy_TargetFrameCapsule:ClearAllPoints();
				Gypsy_TargetFrameCapsule:SetPoint(targetAnchor.point, targetAnchor.rel, targetAnchor.relPoint, targetAnchor.x, targetAnchor.y);
				Gypsy_PartyFrameCapsule:ClearAllPoints();
				Gypsy_PartyFrameCapsule:SetPoint(partyAnchor.point, partyAnchor.rel, partyAnchor.relPoint, partyAnchor.x, partyAnchor.y);
				PartyMemberFrame1:ClearAllPoints();
				PartyMemberFrame1:SetPoint(partyMemberAnchor.point, partyMemberAnchor.rel, partyMemberAnchor.relPoint, partyMemberAnchor.x, partyMemberAnchor.y);
				-- Update the pet frame location and make adjustments to the other capsules if applicable
				Gypsy_UpdatePetFrame();
				-- Update the order of the party frames
				for i=2, 4 do
					Gypsy_UnitUpdatePartyFrame(i);
				end
			end
		else
			-- If the unit frames aren't grouped and the capsules aren't already visible for moving, make it so
			if (not Gypsy_TargetFrameCapsule:IsVisible()) then
				Gypsy_TargetFrameCapsule:Show();
			end
			if (not Gypsy_PartyFrameCapsule:IsVisible()) then
				Gypsy_PartyFrameCapsule:Show();
			end	
			-- If the shell is present, disable the button
			if (GYPSY_SHELL == 1) then
				button:Disable();
				string:SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
			end
		end
	else
		--[[PlayerFrame:ClearAllPoints();
		PlayerFrame:SetPoint("TOPLEFT", "UIParent", "TOPLEFT", -19, -4);
		for i=1, 4 do
			local partyMemberFrame = getglobal("PartyMemberFrame"..i);
			partyMemberFrame: ClearAllPoints();
			if (i == 1) then
				partyMemberFrame:SetPoint("TOPLEFT", "UIParent", "TOPLEFT", 10, -128);
			else
				local lastId = i - 1;
				local lastButton = getglobal("PartyMemberFrame"..lastId);
				partyMemberFrame:SetPoint("TOPLEFT", lastButton, "BOTTOMLEFT", 0, -10);
			end
		end
		TargetFrame:ClearAllPoints();
		TargetFrame:SetPoint("TOPLEFT", "UIParent", "TOPLEFT", 250, -4);
		PetFrame:ClearAllPoints();
		PetFrame:SetPoint("TOPLEFT", "UIParent", "TOPLEFT", 80, -60);
		]]		
	end
end

--[[
	Gypsy_UpdatePetFrame
	This function moves the pet frame to where it needs to be, and moves other frames out of it's way to make room.
	
	This is run from our unit frames update function, so we only need to make changes if there is a pet present. 
	Also we don't change anything if frames aren't grouped.
	If the frames are inverted, then the pet frame is placed above the player frame, and the target frame is shifted up, which also shifts the party capsule.
	If the frames are not inverted, then the pet frame is placed below the player frame, and the party capsule is shifted down.
]]
	
function Gypsy_UpdatePetFrame ()
	-- Only changing positions if the pet frame is shown,,
	if(PetFrame:IsVisible()) then
		-- And if frames are grouped
		if (Gypsy_GroupUnitFrames == 1) then
			-- Seperate movement routines for whether the frames are inverted or not
			if (Gypsy_InvertUnitFrames == 1) then
				-- Get anchor info from the stored tables
				local petAnchor = Gypsy_InvertCapsulePositions["Pet"];
				local targetAnchor = Gypsy_InvertCapsulePositions["Target"];
				-- Move the pet frame to where it needs to be relative to the player frame
				PetFrame:ClearAllPoints();
				PetFrame:SetPoint(petAnchor.point, petAnchor.rel, petAnchor.relPoint, petAnchor.x, petAnchor.y);
				-- We use the default anchor positions for the target frame to re-anchor it, and just add a defined offset value to the vertical offset
				Gypsy_TargetFrameCapsule:ClearAllPoints();
				Gypsy_TargetFrameCapsule:SetPoint(targetAnchor.point, targetAnchor.rel, targetAnchor.relPoint, targetAnchor.x, targetAnchor.y+Gypsy_PetOffset);
			else
				-- Get anchor info from the stored tables
				local petAnchor = Gypsy_DefaultCapsulePositions["Pet"];
				local partyAnchor = Gypsy_DefaultCapsulePositions["Party"];
				-- Move the pet frame to where it needs to be relative to the player frame
				PetFrame:ClearAllPoints();
				PetFrame:SetPoint(petAnchor.point, petAnchor.rel, petAnchor.relPoint, petAnchor.x, petAnchor.y);
				-- We use the default anchor positions for the target frame to re-anchor it, and just subtract a defined offset value from the vertical offset
				Gypsy_PartyFrameCapsule:ClearAllPoints();
				Gypsy_PartyFrameCapsule:SetPoint(partyAnchor.point, partyAnchor.rel, partyAnchor.relPoint, partyAnchor.x, partyAnchor.y-Gypsy_PetOffset);
			end
		end
	end
end

--[[
	Gypsy_UnitUpdatePartyFrame
	This function recieves an ID for a party member frame and moves it where it needs to go.
	
	An ID must be supplied, and if the cooresponding party member is present, party member frames will be positioned according to the invert setting.
]]

function Gypsy_UnitUpdatePartyFrame (id)
	-- Check to be sure an ID was supplied
	if (id == nil) then
		return nil;
	else
		-- Quick built-in function to check for party member presence
		if (GetPartyMember(id)) then
			-- Get cooresponding default frame
			local frame = getglobal("PartyMemberFrame" .. id);
			-- Must do this to properly prepare to move the default frame
			frame:ClearAllPoints();
			-- If the frame is the first, move it to where the positioning table tells us...
			if (id == 1) then
				-- If frames are inverted, anchor the first frame to the bottom of the capsule, else to the top
				if (Gypsy_InvertUnitFrames == 1) then
					local anchor = Gypsy_InvertCapsulePositions["PartyMember1"];	
					frame:SetPoint(anchor.point, anchor.rel, anchor.relPoint, anchor.x, anchor.y);
				else
					local anchor = Gypsy_DefaultCapsulePositions["PartyMember1"];
					frame:SetPoint(anchor.point, anchor.rel, anchor.relPoint, anchor.x, anchor.y);
				end								
			-- else if it's not, anchor it off the previous frame
			else
				local anchorId = id - 1;
				local anchorFrame = "PartyMemberFrame" .. anchorId;
				-- To the top of the frame if frames are inverted, bottom if not
				if (Gypsy_InvertUnitFrames == 1) then
					frame:SetPoint("BOTTOMLEFT", anchorFrame, "TOPLEFT", 0, 20);
				else
					frame:SetPoint("TOPLEFT", anchorFrame, "BOTTOMLEFT", 0, -20);
				end
			end
		end
	end
end

-- Function to reset everything to default
function Gypsy_ResetUnitFrames ()
	if (GYPSY_SHELL == 1) then
		Gypsy_UpdateValue(201, Gypsy_DefaultGroupUnitFrames);
		Gypsy_UpdateValue(202, Gypsy_DefaultInvertUnitFrames);
		Gypsy_Option201:SetChecked(Gypsy_DefaultGroupUnitFrames);
		Gypsy_Option202:SetChecked(Gypsy_DefaultInvertUnitFrames);
	else
		Gypsy_GroupUnitFrames = Gypsy_DefaultGroupUnitFrames;
		Gypsy_InvertUnitFrames = Gypsy_DefaultInvertUnitFrames;
	end
	Gypsy_UpdateUnitFrames(1);
end	

-- ** SLASH COMMAND HANDLERS ** --

function Gypsy_InvertUnitFramesSlashHandler (msg)
	msg = string.lower(msg);
	if (msg == "yes" or msg == "1" or msg == "true") then
		Gypsy_InvertUnitFrames = 1;
		DEFAULT_CHAT_FRAME:AddMessage("Reversing order of party frames and placing pet frame above player frame.", 1, 1, 1);
	elseif (msg == "no" or msg == "0" or msg == "false") then
		Gypsy_InvertUnitFrames = 0;
		DEFAULT_CHAT_FRAME:AddMessage("Setting order of party frames to normal, descending, and placing pet frame below player frame.", 1, 1, 1);
	elseif (msg == "default" or msg == "reset" or msg == "revert") then
		Gypsy_InvertUnitFrames = Gypsy_DefaultInvertUnitFrames;
		DEFAULT_CHAT_FRAME:AddMessage("Reverting unit frame invert state to default.", 1, 1, 1);
	elseif (msg == "help") then
		DEFAULT_CHAT_FRAME:AddMessage("Valid parameters for: /unitbarinvertunitframes /ubinvertunitframes", 1, 0.89, 0.01);
		DEFAULT_CHAT_FRAME:AddMessage("   help - This listing.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   yes, true, or 1 - Invert unit bars.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   no, false, or 0 - Do not invert unit bars.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   default, reset, or revert - Revert to default state.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   blank - Toggle based on current state.", 1, 1, 1);
	elseif (msg == "") then
		if (Gypsy_InvertUnitFrames == 1) then 
			Gypsy_InvertUnitFrames = 0;
			DEFAULT_CHAT_FRAME:AddMessage("Setting order of party frames to normal, descending, and placing pet frame below player frame.", 1, 1, 1);
		else 
			Gypsy_InvertUnitFrames = 1; 
			DEFAULT_CHAT_FRAME:AddMessage("Reversing order of party frames and placing pet frame above player frame.", 1, 1, 1);
		end
	else
		DEFAULT_CHAT_FRAME:AddMessage("Valid parameters for: /unitbarinvertunitframes /ubinvertunitframes", 1, 0.89, 0.01);
		DEFAULT_CHAT_FRAME:AddMessage("   help - This listing.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   yes, true, or 1 - Invert unit bars.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   no, false, or 0 - Do not invert unit bars.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   default, reset, or revert - Revert to default state.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   blank - Toggle based on current state.", 1, 1, 1);
	end
	Gypsy_UpdateUnitFrames(1);
end

function Gypsy_GroupUnitFramesSlashHandler (msg)
	msg = string.lower(msg);
	if (msg == "yes" or msg == "1" or msg == "true") then
		Gypsy_GroupUnitFrames = 1;
		DEFAULT_CHAT_FRAME:AddMessage("Anchoring unit frames to player frame.", 1, 1, 1);
	elseif (msg == "no" or msg == "0" or msg == "false") then
		Gypsy_GroupUnitFrames = 0;
		DEFAULT_CHAT_FRAME:AddMessage("Freeing unit frames for anchoring.", 1, 1, 1);
	elseif (msg == "default" or msg == "reset" or msg == "revert") then
		Gypsy_GroupUnitFrames = Gypsy_DefaultGroupUnitFrames;
		DEFAULT_CHAT_FRAME:AddMessage("Reverting unit frame grouping to default state.", 1, 1, 1);
	elseif (msg == "help") then
		DEFAULT_CHAT_FRAME:AddMessage("Valid parameters for: /unitbargroupunitframes /ubgroupunitframes", 1, 0.89, 0.01);
		DEFAULT_CHAT_FRAME:AddMessage("   help - This listing.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   yes, true, or 1 - Invert unit bars.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   no, false, or 0 - Do not invert unit bars.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   default, reset, or revert - Revert to default state.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   blank - Toggle based on current state.", 1, 1, 1);
	elseif (msg == "") then
		if (Gypsy_GroupUnitFrames == 1) then 
			Gypsy_GroupUnitFrames = 0;
			DEFAULT_CHAT_FRAME:AddMessage("Freeing unit frames for anchoring.", 1, 1, 1);
		else 
			Gypsy_GroupUnitFrames = 1; 
			DEFAULT_CHAT_FRAME:AddMessage("Anchoring unit frames to player frame.", 1, 1, 1);
		end
	else
		DEFAULT_CHAT_FRAME:AddMessage("Valid parameters for: /unitbargroupunitframes /ubgroupunitframes", 1, 0.89, 0.01);
		DEFAULT_CHAT_FRAME:AddMessage("   help - This listing.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   yes, true, or 1 - Invert unit bars.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   no, false, or 0 - Do not invert unit bars.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   default, reset, or revert - Revert to default state.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   blank - Toggle based on current state.", 1, 1, 1);
	end
	Gypsy_UpdateUnitFrames();
end

function Gypsy_EnableUnitBarsSlashHandler (msg)
	msg = string.lower(msg);
	if (msg == "enable" or msg == "1" or msg == "true") then
		Gypsy_EnableUnitBars = 1;
		DEFAULT_CHAT_FRAME:AddMessage("UnitBars enabled.", 1, 1, 1);
	elseif (msg == "disable" or msg == "0" or msg == "false") then
		Gypsy_EnableUnitBars = 0;
		DEFAULT_CHAT_FRAME:AddMessage("UnitBars disabled.", 1, 1, 1);
	elseif (msg == "default" or msg == "reset" or msg == "revert") then
		Gypsy_EnableUnitBars = Gypsy_DefaultEnableUnitBars;
		DEFAULT_CHAT_FRAME:AddMessage("Reverting UnitBars to default state.", 1, 1, 1);
	elseif (msg == "help") then
		DEFAULT_CHAT_FRAME:AddMessage("Valid parameters for: /unitbargroupunitframes /ubgroupunitframes", 1, 0.89, 0.01);
		DEFAULT_CHAT_FRAME:AddMessage("   help - This listing.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   enable, true, or 1 - Enable UnitBars.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   disable, false, or 0 - Disable UnitBars.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   default, reset, or revert - Revert to default state.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   blank - Toggle based on current state.", 1, 1, 1);
	elseif (msg == "") then
		if (Gypsy_EnableUnitBars == 1) then 
			Gypsy_EnableUnitBars = 0;
			DEFAULT_CHAT_FRAME:AddMessage("UnitBars disabled.", 1, 1, 1);
		else 
			Gypsy_EnableUnitBars = 1; 
			DEFAULT_CHAT_FRAME:AddMessage("UnitBars enabled.", 1, 1, 1);
		end
	else
		DEFAULT_CHAT_FRAME:AddMessage("Valid parameters for: /unitbargroupunitframes /ubgroupunitframes", 1, 0.89, 0.01);
		DEFAULT_CHAT_FRAME:AddMessage("   help - This listing.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   enable, true, or 1 - Enable UnitBars.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   disable, false, or 0 - Disable UnitBars.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   default, reset, or revert - Revert to default state.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   blank - Toggle based on current state.", 1, 1, 1);
	end
	Gypsy_UpdateUnitFrames();
end

function Gypsy_LockPlayerCapsuleSlashHandler (msg)
	msg = string.lower(msg);
	if (msg == "yes" or msg == "1" or msg == "true") then
		Gypsy_LockPlayerFrameCapsule = 1;
		DEFAULT_CHAT_FRAME:AddMessage("Locking player frame capsule.", 1, 1, 1);
	elseif (msg == "no" or msg == "0" or msg == "false") then
		Gypsy_LockPlayerFrameCapsule = 0;
		DEFAULT_CHAT_FRAME:AddMessage("Unlocking player frame capsule.", 1, 1, 1);
	elseif (msg == "default" or msg == "reset" or msg == "revert") then
		Gypsy_LockPlayerFrameCapsule = Gypsy_DefaultLockPlayerFrameCapsule;
		DEFAULT_CHAT_FRAME:AddMessage("Reverting player frame capsule locking to default state.", 1, 1, 1);
	elseif (msg == "help") then
		DEFAULT_CHAT_FRAME:AddMessage("Valid parameters for: /unitbarlockplayer /ublockplayer", 1, 0.89, 0.01);
		DEFAULT_CHAT_FRAME:AddMessage("   help - This listing.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   yes, true, or 1 - Lock player capsule.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   no, false, or 0 - Unlock player capsule.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   default, reset, or revert - Revert to default state.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   blank - Toggle based on current state.", 1, 1, 1);
	elseif (msg == "") then
		if (Gypsy_LockPlayerFrameCapsule == 1) then 
			Gypsy_LockPlayerFrameCapsule = 0;
			DEFAULT_CHAT_FRAME:AddMessage("Unlocking player frame capsule.", 1, 1, 1);
		else 
			Gypsy_LockPlayerFrameCapsule = 1; 
			DEFAULT_CHAT_FRAME:AddMessage("Locking player frame capsule.", 1, 1, 1);
		end
	else
		DEFAULT_CHAT_FRAME:AddMessage("Valid parameters for: /unitbarlockplayer /ublockplayer", 1, 0.89, 0.01);
		DEFAULT_CHAT_FRAME:AddMessage("   help - This listing.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   yes, true, or 1 - Lock player capsule.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   no, false, or 0 - Unlock player capsule.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   default, reset, or revert - Revert to default state.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   blank - Toggle based on current state.", 1, 1, 1);
	end
end

function Gypsy_LockTargetCapsuleSlashHandler (msg)
	msg = string.lower(msg);
	if (msg == "yes" or msg == "1" or msg == "true") then
		Gypsy_LockTargetFrameCapsule = 1;
		DEFAULT_CHAT_FRAME:AddMessage("Locking target frame capsule.", 1, 1, 1);
	elseif (msg == "no" or msg == "0" or msg == "false") then
		Gypsy_LockTargetFrameCapsule = 0;
		DEFAULT_CHAT_FRAME:AddMessage("Unlocking target frame capsule.", 1, 1, 1);
	elseif (msg == "default" or msg == "reset" or msg == "revert") then
		Gypsy_LockTargetFrameCapsule = Gypsy_DefaultLockTargetFrameCapsule;
		DEFAULT_CHAT_FRAME:AddMessage("Reverting target frame capsule locking to default state.", 1, 1, 1);
	elseif (msg == "help") then
		DEFAULT_CHAT_FRAME:AddMessage("Valid parameters for: /unitbarlocktarget /ublocktarget", 1, 0.89, 0.01);
		DEFAULT_CHAT_FRAME:AddMessage("   help - This listing.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   yes, true, or 1 - Lock target capsule.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   no, false, or 0 - Unlock target capsule.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   default, reset, or revert - Revert to default state.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   blank - Toggle based on current state.", 1, 1, 1);
	elseif (msg == "") then
		if (Gypsy_LockTargetFrameCapsule == 1) then 
			Gypsy_LockTargetFrameCapsule = 0;
			DEFAULT_CHAT_FRAME:AddMessage("Unlocking target frame capsule.", 1, 1, 1);
		else 
			Gypsy_LockTargetFrameCapsule = 1; 
			DEFAULT_CHAT_FRAME:AddMessage("Locking target frame capsule.", 1, 1, 1);
		end
	else
		DEFAULT_CHAT_FRAME:AddMessage("Valid parameters for: /unitbarlocktarget /ublocktarget", 1, 0.89, 0.01);
		DEFAULT_CHAT_FRAME:AddMessage("   help - This listing.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   yes, true, or 1 - Lock target capsule.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   no, false, or 0 - Unlock target capsule.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   default, reset, or revert - Revert to default state.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   blank - Toggle based on current state.", 1, 1, 1);
	end
end

function Gypsy_LockPartyCapsuleSlashHandler (msg)
	msg = string.lower(msg);
	if (msg == "yes" or msg == "1" or msg == "true") then
		Gypsy_LockPartyFrameCapsule = 1;
		DEFAULT_CHAT_FRAME:AddMessage("Locking party frame capsule.", 1, 1, 1);
	elseif (msg == "no" or msg == "0" or msg == "false") then
		Gypsy_LockPartyFrameCapsule = 0;
		DEFAULT_CHAT_FRAME:AddMessage("Unlocking party frame capsule.", 1, 1, 1);
	elseif (msg == "default" or msg == "reset" or msg == "revert") then
		Gypsy_LockPartyFrameCapsule = Gypsy_DefaultLockPartyFrameCapsule;
		DEFAULT_CHAT_FRAME:AddMessage("Reverting Party frame capsule locking to default state.", 1, 1, 1);
	elseif (msg == "help") then
		DEFAULT_CHAT_FRAME:AddMessage("Valid parameters for: /unitbarlockparty /ublockparty", 1, 0.89, 0.01);
		DEFAULT_CHAT_FRAME:AddMessage("   help - This listing.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   yes, true, or 1 - Lock party capsule.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   no, false, or 0 - Unlock party capsule.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   default, reset, or revert - Revert to default state.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   blank - Toggle based on current state.", 1, 1, 1);
	elseif (msg == "") then
		if (Gypsy_LockPartyFrameCapsule == 1) then 
			Gypsy_LockPartyFrameCapsule = 0;
			DEFAULT_CHAT_FRAME:AddMessage("Unlocking party frame capsule.", 1, 1, 1);
		else 
			Gypsy_LockPartyFrameCapsule = 1; 
			DEFAULT_CHAT_FRAME:AddMessage("Locking party frame capsule.", 1, 1, 1);
		end
	else
		DEFAULT_CHAT_FRAME:AddMessage("Valid parameters for: /unitbarlockparty /ublockparty", 1, 0.89, 0.01);
		DEFAULT_CHAT_FRAME:AddMessage("   help - This listing.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   yes, true, or 1 - Lock party capsule.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   no, false, or 0 - Unlock party capsule.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   default, reset, or revert - Revert to default state.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   blank - Toggle based on current state.", 1, 1, 1);
	end
end

function Gypsy_ResetUnitFramesSlashHandler ()
	Gypsy_ResetUnitFrames();
	DEFAULT_CHAT_FRAME:AddMessage("Resetting all UnitBar parameters.", 1, 1, 1);
end
--[[ maff : MoveAnything Frame Finder

	This is a frame finder for MoveAnything.  Its sole purpose is to do a /move and /unmove
	of frames without typing in their name.

	Anyone is welcome to use/edit part or all of it in their mod as their own.  It's too
	small to be an addon in itself and would probably be a better fit within MoveAnything
	itself. The maff.lua/xml can be copy/pasted verbatim into the MoveAnything.lua/xml files.

	To set up: Set up a key binding for MoveAnything Frame Finder.

	To use:
	1. Move the mouse over the frame you want to move.
	2. Hit the key binding.
	3. A pulsing frame will outline the frame beneath the mouse.
	4. Hit the key binding again to cycle up the parents of the frame.
	5. Once you've selected the frame you want to move:
	- Click to tell MoveAnything to /move this frame
	- Shift+click to tell MoveAnything to /unmove this frame

	Limitations:
	- It can only identify frames that receive mouse events and their parents.
	- Some frames (like bags) require special care and are already listed in MoveAnything.
	  It's a good idea to use MoveAnything directly for predefined frames.
]]

BINDING_HEADER_maff = "maff"

maff = {
	flashTimer = 0,		-- time since last OnUpdate
	flashStep = .1,		-- how much alpha changes in flash
	flashAlpha = 0,		-- current flash alpha
	frame = nil,		-- currently selected frame
}

function maff.OnLoad()
	table.insert(UISpecialFrames,"maffFrame") -- make the frame ESCable
end

-- sole purpose of this OnUpdate is to make our frame pulse
function maff.OnUpdate()

	maff.flashTimer = maff.flashTimer + arg1
	if maff.flashTimer>.1 then
		maff.flashTimer = 0
		maff.flashAlpha = maff.flashAlpha + maff.flashStep
		if maff.flashAlpha > 1 then
			maff.flashAlpha = 1
			maff.flashStep = -.1
		elseif maff.flashAlpha<0 then
			maff.flashAlpha = 0
			maff.flashStep = .1
		end
		maffFrame:SetBackdropColor(1-maff.flashAlpha,1-maff.flashAlpha,1-maff.flashAlpha,.25)
	end
end

-- the frame grabber, cycles through frames under the mouse and overlays maffFrame ontop
function maff.Identify()

	maffFrame:EnableMouse(0) -- momentarily make the frame invisible to mouse (to see stuff beneath)

	if not ResizingNudger:IsVisible() then
		-- Only if MoveAnything reticle is up, 

		if not maff.frame or not maffFrame:IsVisible() then
			maff.frame = GetMouseFocus() -- if starting with no frame, grab one beneath mouse
		else
			maff.frame = maff.frame:GetParent() -- otherwise get its parent
		end

		if not maff.frame or maff.frame==UIParent or maff.frame==WorldFrame then
			maff.frame = GetMouseFocus() -- if we ran out of parents, grab first frame again
			if maff.frame==UIParent or maff.frame==WorldFrame then
				maff.frame = nil -- or get nothing if we're not over a frame
			end
		end

		if maff.frame then
			-- if we have a frame selected, overlay the maffFrame
			maffFrame:ClearAllPoints()
			maffFrame:SetPoint("TOPLEFT",maff.frame,"TOPLEFT",-4,4)
			maffFrame:SetPoint("BOTTOMRIGHT",maff.frame,"BOTTOMRIGHT",4,-4)
			maffFrame:Show()
	
			maffLabel:SetText(maff.frame:GetName() or "<no frame>")
		else
			maffFrame:Hide()
		end

	end
	maffFrame:EnableMouse(1) -- make the frame opaque again, to receive mouse events

end

function maff.OnClick()
	maffFrame:Hide()
	if IsShiftKeyDown() then
		SlashCmdList["UNMOVEANYTHING"](maff.frame:GetName())
	else
		SlashCmdList["MOVEANYTHING"](maff.frame:GetName())
	end
end

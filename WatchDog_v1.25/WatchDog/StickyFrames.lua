--[[---------------------------------------------------------------------------------
  StickyFrames Library by Cladhaire (cladhaire@gmail.com)
  
  This first section is the standard embedded library stub declaration.  This code
  manages the versioning between different instances of the AceHooks library.
  
  See http://www.iriel.org/wow/addondev/embedlibrary1.html for more information
----------------------------------------------------------------------------------]]

local stub = {}

function stub:ReplaceInstance(old,new)
	for k,v in pairs(old) do old[k]=nil end
	for k,v in pairs(new) do old[k]=v end
end

function stub:NewStub()
	local newStub = {}
	self:ReplaceInstance(newStub, self)
	newStub.lastVersion = ''
	newStub.versions = {}
	return newStub
end

function stub:GetInstance(version)
	if not version then version = self.lastVersion end
	local versionData = self.versions[version]
	if not versionData then
		message("Cannot find StickyFrames instance with version '" .. version .. "'")
		return
	end
	return versionData.instance
end

function stub:Register(newInstance)
	local version,minor = newInstance:GetLibraryVersion()
	self.lastVersion = version
	local versionData = self.versions[version]
	if not versionData then
		-- This is new
		versionData = { instance=newInstance, minor=minor, old={}}
		self.versions[version] = versionData
		newInstance:LibActivate(self)
		return newInstance
	end
	if minor <= versionData.minor then
		-- This one is already obsolete
		if newInstance.LibDiscard then
			newInstance:LibDiscard()
		end
		return versionData.instance
	end
	
	-- This is an update
	local oldInstance = versionData.instance
	local oldList = versionData.old
	versionData.instance = newInstance
	versionData.minor = minor
	local skipCopy = newInstance:LibActivate(self, oldInstance, oldList)
	table.insert(oldList, oldInstance)
	if not skipCopy then
		for i,old in ipairs(oldList) do
			self:ReplaceInstance(old, newInstance)
		end
	end
	return newInstance
end

-- Bind stub to global scope if it's not already there
if not StickyFramesLib then
	StickyFramesLib = stub:NewStub()
end

stub = nil

--[[---------------------------------------------------------------------------------
  StickyFrames Library implementation.
 -----------------------------------------------------------------------------------]]

local StickyFrames = {}

-- You MUST update the major version whenever you make an incompatible
-- change (And check that libActivate is still valid!)
local MAJOR_VERSION = "1.0"

-- You MUST update the minor version wheneve you make a compatible 
-- change (And check that libActivate is still valid!)
local MINOR_VERSION = 7

function StickyFrames:GetLibraryVersion()
	return MAJOR_VERSION, MINOR_VERSION
end

function StickyFrames:LibActivate(stub, oldLib, oldLIst)
	local maj, min = self:GetLibraryVersion()
	
	--self:Debug("Activating " .. maj .. ", " .. min)

	-- Return nil to force the instance copy.
	return nil
end

function StickyFrames:LibDiscard()
	local maj, min = self:GetLibraryVersion()
	
	--self:Debug("Discarding " .. maj .. ", " .. min)
end

function StickyFrames:Debug(msg)
	local maj,min = self:GetLibraryVersion()
	if DEFAULT_CHAT_FRAME then
		DEFAULT_CHAT_FRAME:AddMessage("[|cffffff00StickyFrames "..maj.."|r] " .. tostring(msg))
	else
		print("[StickyFrames "..maj.."] " .. tostring(msg))
	end
end


--[[---------------------------------------------------------------------------------
  General Library providing an alternate StartMoving() that allows you to
  specify a number of frames to snap-to when moving the frame around
  
  Example Usage:
  
	<OnLoad>
		this:RegisterForDrag("LeftButton")
	</OnLoad>
	<OnDragStart>										
		StickyFrames:StartMoving(this, {WatchDogFrame_player, WatchDogFrame_target, WatchDogFrame_party1, WatchDogFrame_party2, WatchDogFrame_party3, WatchDogFrame_party4},3,3,3,3)
	</OnDragStart>
	<OnDragStop>
		StickyFrames:StopMoving(this)
		StickyFrames:AnchorFrame(this)
	</OnDragStop>			
------------------------------------------------------------------------------------]]

--[[---------------------------------------------------------------------------------
  Class declaration, along with a temporary table to hold any existing OnUpdate 
  scripts.
------------------------------------------------------------------------------------]]

StickyFrames.scripts = {}

--[[---------------------------------------------------------------------------------
  StickyFrames:StartMoving() - Sets a custom OnUpdate for the frame so it follows
  the mouse and snaps to the frames you specify
  
	frame:	 	The frame we want to move.  Is typically "this"

	frameList: 	A integer indexed list of frames that the given frame should try to
				stick to.  These don't have to have anything special done to them,
				and they don't really even need to exist.  You can inclue the 
				moving frame in this list, it will be ignored.  This helps you 
				if you have a number of frames, just make ONE list to pass.
				
				{WatchDogFrame_player, WatchDogFrame_party1, .. WatchDogFrame_party4}

	left:		If your frame has a tranparent border around the entire frame 
				(think backdrops with borders).  This can be used to fine tune the
				edges when you're stickying groups.  Refers to any offset on the 
				LEFT edge of the frame being moved.
	
	top:		same
	right:		same
	bottom:		same
------------------------------------------------------------------------------------]]

function StickyFrames:StartMoving(frame, frameList, left, top, right, bottom)
	if not frame then
		self:Debug("Specified a nil frame to StartMoving()")
		return
	end

	local x,y = GetCursorPosition()
	local aX,aY = frame:GetCenter()
	local aS = frame:GetEffectiveScale()
	
	aX,aY = aX*aS,aY*aS
	local xoffset,yoffset = (aX - x),(aY - y)
	self.scripts[frame] = frame:GetScript("OnUpdate")
	frame:SetScript("OnUpdate", self:GetUpdateFunc(frame, frameList, xoffset, yoffset, left, top, right, bottom))
end

--[[---------------------------------------------------------------------------------
  This stops the OnUpdate, leaving the frame at its last position.  This will
  leave it anchored to UIParent.  You can call StickyFrames:AnchorFrame() to 
  anchor it back "TOPLEFT" , "TOPLEFT" to the parent.
------------------------------------------------------------------------------------]]

function StickyFrames:StopMoving(frame)
	if not frame then
		self:Debug("Specified a nil frame to StopMoving()")
		return
	end

	frame:SetScript("OnUpdate", self.scripts[frame])
	self.scripts[frame] = nil
	self[frame] = nil
end

--[[---------------------------------------------------------------------------------
  This can be called in conjunction with StickyFrames:StopMoving() to anchor the 
  frame right back to the parent, so you can manipulate its children as a group
  (This is useful in WatchDog).
  
  If you choose not to anchor back to frame:GetParent() you can explicitly specify
  an "anchorFrame" as the second argument to AnchorFrame()
------------------------------------------------------------------------------------]]

function StickyFrames:AnchorFrame(frame, anchorFrame)
	local xA,yA = frame:GetLeft(), frame:GetTop()
	local parent = anchorFrame or frame:GetParent()
	
	if not parent then return end
	
	local xP,yP = parent:GetLeft(), parent:GetTop()
	local sA,sP = frame:GetEffectiveScale(), parent:GetEffectiveScale()
	
	xP,yP = (xP*sP) / sA, (yP*sP) / sA

	local xo,yo = (xP - xA)*-1, (yP - yA)*-1
	
	frame:ClearAllPoints()
	frame:SetPoint("TOPLEFT", parent, "TOPLEFT", xo, yo)
end	


--[[---------------------------------------------------------------------------------
  Internal Functions -- Do not call these.
------------------------------------------------------------------------------------]]

--[[---------------------------------------------------------------------------------
  Returns an anonymous OnUpdate function for the frame in question.  Need
  to provide the frame, frameList along with the x and y offset (difference between
  where the mouse picked up the frame, and the insets (left,top,right,bottom) in the
  case of borders, etc.w
------------------------------------------------------------------------------------]]

function StickyFrames:GetUpdateFunc(frame, frameList, xoffset, yoffset, left, top, right, bottom)
	return function()	
		local x,y = GetCursorPosition()
		local s = frame:GetEffectiveScale()
		local sticky = nil
		
		x,y = x/s,y/s
		
		if not self[frame] then 
			self[frame] = {} 
			self[frame].x = x
			self[frame].y = y
		end
		
		if self[frame].x == x and self[frame].y == y then return end
		
		frame:ClearAllPoints()
		frame:SetPoint("CENTER", UIParent, "BOTTOMLEFT", x+xoffset, y+yoffset)
		
		for k,v in ipairs(frameList) do
			if frame ~= v and v then
				if self:Overlap(frame, v, left, top, right, bottom) then
					local snapFrame, secSnap = self:SnapFrame(frame, v, left, top, right, bottom)
					if secSnap then return end
				end
			end
		end
	end
end


--[[---------------------------------------------------------------------------------
  Internal debug function.
------------------------------------------------------------------------------------]]

function StickyFrames:debug(msg)
	DEFAULT_CHAT_FRAME:AddMessage("|cffffff00StickyFrames: |r"..tostring(msg))
end

--[[---------------------------------------------------------------------------------
  Determines the overlap between two frames.  Returns true if the frames
  overlap anywhere, or false if they don't.  Does not consider alpha on the edges of
  textures.  
------------------------------------------------------------------------------------]]
function StickyFrames:Overlap(frameA, frameB, left, top, right, bottom)
	local sA, sB = frameA:GetEffectiveScale(), frameB:GetEffectiveScale()
	if not frameA:IsVisible() or not frameB:IsVisible() then return end
	return (((frameA:GetLeft()+left)*sA) < (frameB:GetRight()*sB))
		and ((frameB:GetLeft()*sB) < ((frameA:GetRight()-right)*sA))
		and (((frameA:GetBottom()+bottom)*sA) < (frameB:GetTop()*sB))
		and ((frameB:GetBottom()*sB) < ((frameA:GetTop()-top)*sA))
end

--[[---------------------------------------------------------------------------------
  This is called when finding an overlap between two sticky frame.  If frameA is near
  a sticky edge of frameB, then it will snap to that edge and return true.  If there
  is no sticky edge collision, will return false so we can test other frames for
  stickyness.
------------------------------------------------------------------------------------]]
function StickyFrames:SnapFrame(frameA, frameB, left, top, right, bottom)
	local sA, sB = frameA:GetEffectiveScale(), frameB:GetEffectiveScale()
	local xA, yA = frameA:GetCenter()
	local xB, yB = frameB:GetCenter()
	local hA, hB = frameA:GetHeight() / 2, ((frameB:GetHeight() * sB) / sA) / 2
	local wA, wB = frameA:GetWidth() / 2, ((frameB:GetWidth() * sB) / sA) / 2

	if not left then left = 0 end
	if not top then top = 0 end
	if not right then right = 0 end
	if not bottom then bottom = 0 end

	-- Lets translate B's coords into A's scale
	xB, yB = (xB*sB) / sA, (yB*sB) / sA

	local stickyAx, stickyAy = wA * 0.75, hA * 0.75
	local stickyBx, stickyBy = wB * 0.75, hB * 0.75

	-- Grab the edges of each frame, for easier comparison
	
	local lA, tA, rA, bA = frameA:GetLeft(), frameA:GetTop(), frameA:GetRight(), frameA:GetBottom()
	local lB, tB, rB, bB = frameB:GetLeft(), frameB:GetTop(), frameB:GetRight(), frameB:GetBottom()
	local snap,secSnap = nil,nil
	
	-- Translate into A's scale
	lB, tB, rB, bB = (lB * sB) / sA, (tB * sB) / sA, (rB * sB) / sA, (bB * sB) / sA

	local hMargin = hB * 0.15
	local wMargin = wB * 0.15
	
	-- Lets check for Left stickyness
	if lA > (rB - stickyAx) then
	
		-- If we are 5 pixels above or below the top of the sticky frame
		-- Snap to the top edge of it.
		if tA <= (tB + hMargin) and tA >= (tB - hMargin) then
			yA = (tB - hA)
			secSnap = true
		elseif bA <= (bB + hMargin) and bA >= (bB - hMargin) then 
			yA = (bB + hA)
			secSnap = true
		end

		-- Set the x sticky position
		xA = rB + (wA - left)
		
		-- Delay the snap until later
		snap = true		

		-- Check for Right stickyness
	elseif rA < (lB + stickyAx) then 
		-- If we are 5 pixels above or below the top of the sticky frame
		-- Snap to the top edge of it.
		if tA <= (tB + hMargin) and tA >= (tB - hMargin) then
			yA = (tB - hA)
			secSnap = true
		elseif bA <= (bB + hMargin) and bA >= (bB - hMargin) then 
			yA = (bB + hA)
			secSnap = true
		end

		-- Set the x sticky position
		xA = lB - (wA - right)
		
		-- Delay the snap until later
		snap = true		
	
	-- Bottom stickyness
	elseif bA > (tB - stickyAy) then
		
		-- If we are 5 pixels to the left or right of the sticky frame
		-- Snap to the edge of it.

		if lA <= (lB + hMargin) and lA >= (lB - hMargin) then
			xA = (lB + wA)
			secSnap = true
		elseif rA >= (rB - hMargin) and rA <= (rB + hMargin) then
			xA = (rB - wA)
			secSnap = true
		end
				
		-- Set the y sticky position
		yA = tB + (hA - bottom)
		
		-- Delay the snap
		snap = true
	
	elseif tA < (bB + stickyAy) then
		-- If we are 5 pixels to the left or right of the sticky frame
		-- Snap to the edge of it.
		if lA <= (lB + hMargin) and lA >= (lB - hMargin) then
			xA = (lB + wA)
			secSnap = true
		elseif rA >= (rB - hMargin) and rA <= (rB + hMargin) then
			xA = (rB - wA)
			secSnap = true
		end
			
		-- Set the y sticky position
		yA = bB - (hA - bottom)
		
		-- Delay the snap
		snap = true
	end

	if snap then
		frameA:ClearAllPoints()
		frameA:SetPoint("CENTER", UIParent, "BOTTOMLEFT", xA, yA)
		return frameB, secSnap
	end
end

StickyFramesLib:Register(StickyFrames)
StickyFrames = nil
-- The following function is a modification of Blizzard's taxi line drawing code
-- as originally written by Daniel Stephens <iriel@vigilance-committee.org>
MARKINGLINE_LINEFACTOR = 32/30; -- Multiplying factor for texture coordinates
MARKINGLINE_LINEFACTOR_2 = MARKINGLINE_LINEFACTOR / 2; -- Half o that

-- T        - Texture
-- C        - Canvas Frame (for anchoring)
-- sx,sy    - Coordinate of start of line
-- ex,ey    - Coordinate of end of line
-- w        - Width of line
-- relPoint - Relative point on canvas to interpret coords (Default BOTTOMLEFT)
function DrawMarkingLine(T, C, sx, sy, ex, ey, w, relPoint)
	if (not relPoint) then relPoint = "BOTTOMLEFT"; end
	
	-- Determine dimensions and center point of line
	local dx,dy = ex - sx, ey - sy;
	local cx,cy = (sx + ex) / 2, (sy + ey) / 2;
	
	-- Normalize direction if necessary
	if (dx < 0) then
		dx,dy = -dx,-dy;
	end
	
	-- Calculate actual length of line
	local l = sqrt((dx * dx) + (dy * dy));
	
	-- Quick escape if it's zero length
	if (l == 0) then
		T:SetTexCoord(0,0,0,0,0,0,0,0);
		T:SetPoint("BOTTOMLEFT", C, relPoint, cx,cy);
		T:SetPoint("TOPRIGHT",   C, relPoint, cx,cy);
	return;
	end
	
	-- Sin and Cosine of rotation, and combination (for later)
	local s,c = -dy / l, dx / l;
	local sc = s * c;
	
	-- Calculate bounding box size and texture coordinates
	local Bwid, Bhgt, BLx, BLy, TLx, TLy, TRx, TRy, BRx, BRy;
	if (dy >= 0) then
		Bwid = ((l * c) - (w * s)) * MARKINGLINE_LINEFACTOR_2;
		Bhgt = ((w * c) - (l * s)) * MARKINGLINE_LINEFACTOR_2;
		BLx, BLy, BRy = (w / l) * sc, s * s, (l / w) * sc;
		BRx, TLx, TLy, TRx = 1 - BLy, BLy, 1 - BRy, 1 - BLx; 
		TRy = BRx;
	else
		Bwid = ((l * c) + (w * s)) * MARKINGLINE_LINEFACTOR_2;
		Bhgt = ((w * c) + (l * s)) * MARKINGLINE_LINEFACTOR_2;
		BLx, BLy, BRx = s * s, -(l / w) * sc, 1 + (w / l) * sc;
		BRy, TLx, TLy, TRy = BLx, 1 - BRx, 1 - BLx, 1 - BLy;
		TRx = TLy;
	end
	
	-- Set texture coordinates and anchors
	T:ClearAllPoints();
	T:SetTexCoord(TLx, TLy, BLx, BLy, TRx, TRy, BRx, BRy);
	T:SetPoint("BOTTOMLEFT", C, relPoint, cx - Bwid, cy - Bhgt);
	T:SetPoint("TOPRIGHT",   C, relPoint, cx + Bwid, cy + Bhgt);
	T:Show();
end



local ULx
local ULy
local LLx
local LLy 
local URx 
local URy 
local LRx 
local LRy
function setCoords( t, Ox, Oy, A, B, C, D, E, F )
	ULx = 0;
	ULy = 0;
	LLx = 0;
	LLy = 1; 
	URx = 1; 
	URy = 0; 
	LRx = 1; 
	LRy = 1;
	
	ULx, ULy = Ox + (A*(ULx-Ox) + D*(ULy-Oy)) + C, Oy + (B*(ULx-Ox) + E*(ULy-Oy)) + F;
	LLx, LLy = Ox + (A*(LLx-Ox) + D*(LLy-Oy)) + C, Oy + (B*(LLx-Ox) + E*(LLy-Oy)) + F;
	URx, URy = Ox + (A*(URx-Ox) + D*(URy-Oy)) + C, Oy + (B*(URx-Ox) + E*(URy-Oy)) + F;
	LRx, LRy = Ox + (A*(LRx-Ox) + D*(LRy-Oy)) + C, Oy + (B*(LRx-Ox) + E*(LRy-Oy)) + F;
	
	t:SetTexCoord(ULx, ULy, LLx, LLy, URx, URy, LRx, LRy);
end


function ScaleFromCenter( object, newScale )
	local x, y = object:GetCenter();
	x = x * object:GetScale();
	y = y * object:GetScale();
	object:ClearAllPoints();
	object:SetPoint( "CENTER", "UIParent", "BOTTOMLEFT", x / newScale, y / newScale );
	object:SetScale( newScale );
	object:GetCenter(); -- CRITICAL: Without this call OnClick will not register!
end


function SetRectToParent( overlayFrame )
	local left, right, top, bottom = overlayFrame.parent:GetHitRectInsets()
	overlayFrame:ClearAllPoints()
	overlayFrame:SetPoint( "TOPLEFT", overlayFrame.parent, "TOPLEFT", left, -top );
	overlayFrame:SetPoint( "BOTTOMRIGHT", overlayFrame.parent, "BOTTOMRIGHT", -right, bottom );
	overlayFrame:SetFrameStrata( overlayFrame.parent:GetFrameStrata() )
	overlayFrame:SetFrameLevel( overlayFrame.parent:GetFrameLevel() + 1 )
	overlayFrame.isMarking = false
end

function FadeOutFrame( frame, time )
	local fadeInfo = {}
	fadeInfo.mode = "OUT"
	fadeInfo.timeToFade = time
	fadeInfo.startAlpha = frame:GetAlpha()
	fadeInfo.endAlpha = 0
	fadeInfo.finishedFunc = FadeFinished
	fadeInfo.finishedArg1 = frame

	frame.fadeMode = "OUT"
	UIFrameFade( frame, fadeInfo );
	frame:EnableMouse( false );
end

function FadeInFrame( frame, time )
	local fadeInfo = {}
	fadeInfo.mode = "IN"
	fadeInfo.timeToFade = time
	fadeInfo.startAlpha = 0
	fadeInfo.endAlpha = 1
	fadeInfo.finishedFunc = FadeFinished
	fadeInfo.finishedArg1 = frame

	frame.fadeMode = "IN"
	UIFrameFade( frame, fadeInfo );
	frame:Show();
	frame:EnableMouse( true );
end

function FadeFinished( frame )
	if ( frame.fadeMode == "OUT" ) then
		frame:Hide()
	end
	frame.fadeMode = nil
end
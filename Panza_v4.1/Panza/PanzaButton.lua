--[[ 

PanzaButton.lua
Panza MiniMap Button Controller
Revision 4.0

--]]

function PA:ButtonOnClick()
	PA:FrameToggle(PanzaTreeFrame);
end

function PA:ButtonInit()
	if (PASettings~=nil and PASettings.Switches.Button) then
		PanzaButtonFrame:Show();
	else
		PanzaButtonFrame:Hide();
	end	
end

function PA:ButtonToggle()
	if(PanzaButtonFrame:IsVisible()) then
		PanzaButtonFrame:Hide();
		PASettings.Switches.Button = false;
	else
		PanzaButtonFrame:Show();
		PASettings.Switches.Button = true;
	end
end

--------------------------------------
-- Button Tooltip Function
--------------------------------------
function PA:ButtonTooltip(item)
	GameTooltip:AddLine( PanzaButton_Tooltip[item:GetName()].tooltip1 );
	GameTooltip:AddLine( PanzaButton_Tooltip[item:GetName()].tooltip2, 1, 1, 1, 1, 1 );
	GameTooltip:Show();
end

--------------------------------------
-- Button Position Function
--------------------------------------
function PA:ButtonUpdatePosition()
	if (PASettings~=nil and PASettings.ButtonPosition~=nil) then
		PanzaButtonFrame:SetPoint(
			"TOPLEFT",
			"Minimap",
			"TOPLEFT",
			54 - (78 * cos(PASettings.ButtonPosition)),
			(78 * sin(PASettings.ButtonPosition)) - 55);
	end
end

function PA:IconDraggingFrame_OnUpdate(arg1)
	local xpos,ypos = GetCursorPosition()
	local xmin,ymin = Minimap:GetLeft(), Minimap:GetBottom()

	xpos = xmin-xpos/UIParent:GetScale()+70
	ypos = ypos/UIParent:GetScale()-ymin-70

	PASettings.ButtonPosition = math.deg(math.atan2(ypos,xpos));
	if (PASettings.ButtonPosition<0) then
		PASettings.ButtonPosition = 360 + PASettings.ButtonPosition;
	end
	--PA:Message("Button Pos = "..PASettings.ButtonPosition);

	PA:ButtonUpdatePosition();
	if (PanzaOptsFrame:IsVisible()) then
		SliderPanzaButtonPos:SetValue(PASettings.ButtonPosition);
	end
end


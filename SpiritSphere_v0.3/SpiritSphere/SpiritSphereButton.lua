SpiritSpherePosition = 230;

function SpiritSphereMoveButton()
	SpiritSphereToggleButton:SetPoint("TOPLEFT", "Minimap", "TOPLEFT", 52 - (80 * cos(SpiritSpherePosition)), (80 * sin(SpiritSpherePosition)) - 52)

end

----------------
--This function is called when the button is clicked.
--Note that 'AddonFrameName' should be replaced into the frame name of the window you want to toggle
-------------------
function SpiritSphereOnclick()
		if (SpiritSphereMenu:IsVisible()) then
			HideUIPanel(SpiritSphereMenu);
		else
			ShowUIPanel(SpiritSphereMenu);	
	
		end
end


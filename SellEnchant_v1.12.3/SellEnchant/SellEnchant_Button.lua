function ESell_MiniMapIcon_Update()
	SellEnchant_DebugMessage("Enter ESell_MiniMapIcon_Update");
	if not SellEnchant_Config then
		ESell_MiniMapIcon_Modifier(SellEnchantMinimapButton, 15, 80);
		return;
	end
	if not SellEnchant_Config.SellEnchant_MiniMapButtonPosition then
		SellEnchant_Config.SellEnchant_MiniMapButtonPosition = 290;
	end
	-------------------------------------
	-- Show or hide the MiniMap Button --
	-------------------------------------
	if (SellEnchant_Config_Player.SellEnchant_MiniMap_ButtonDisable) then
		HideUIPanel(SellEnchantMinimapButton);
	else
		ShowUIPanel(SellEnchantMinimapButton);
	end
	ESell_MiniMapIcon_Modifier(SellEnchantMinimapButton, SellEnchant_Config.SellEnchant_MiniMapButtonPosition, 80);
	SellEnchant_DebugMessage("Exit ESell_MiniMapIcon_Update");
end



function ESell_MiniMapIcon_Modifier(frame, pPos, pRadius)
	frame:ClearAllPoints();
	frame:SetFrameLevel(Minimap:GetFrameLevel() + 10);
	frame:SetPoint("TOPLEFT", "Minimap", "TOPLEFT", 52 - (pRadius * cos(pPos)), (pRadius * sin(pPos)) - 52);
end



function SellEnchant_MiniMap_ButtonToggle()
	---------------------------------------------------------
	-- Test If MiniMap option initialized first before use --
	---------------------------------------------------------
--	SellEnchant_DebugMessage("Enter SE_MiniMapButtonToggle");
--	if (SellEnchant_Config_Player.SellEnchant_MiniMap_ButtonDisable == nil) then
--			SellEnchant_Config_Player.SellEnchant_MiniMap_ButtonDisable = true;
--			SellEnchant_DebugMessage("<<<<< Set ButtonUse to true >>>>>");
--	end
	-------------------------------------------------------
	-- Toggle the value of SellEnchant_MiniMap_ButtonDisable --
	-------------------------------------------------------
	if (SellEnchant_Config_Player.SellEnchant_MiniMap_ButtonDisable) then
		SellEnchant_DebugMessage("(=- Turn MiniMap Button ON -=)");
		SellEnchant_Config_Player.SellEnchant_MiniMap_ButtonDisable = false;
		ShowUIPanel(SellEnchantMinimapButton);
		SellEnchant_Option_UseMiniMap_Button:SetChecked(false);
	else
		SellEnchant_DebugMessage("(=- Turn MiniMap Button OFF -=)");
		SellEnchant_Config_Player.SellEnchant_MiniMap_ButtonDisable = true;
		HideUIPanel(SellEnchantMinimapButton);
		SellEnchant_Option_UseMiniMap_Button:SetChecked(true);
	end
	SellEnchant_DebugMessage("Exit SE_MiniMapButtonToggle");
end

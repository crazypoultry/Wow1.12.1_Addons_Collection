--===========================================================================--
-- cMinimapButtonBag, version 1                                                      --
-- Description: An addon that lets you autobroadcast your own ding message   --
--   each time you level up =)                                               -- 
-- Created: 2005-06-25                                                       --
-- Developer: Christoffer Petterson, aka Corgrath, corgrath@corgrath.com     --
--===========================================================================--



--===================================================================================================================--
function cMinimapButtonBag_OnLoad()

	this:RegisterForDrag( "RightButton" );
	ChatFrame1:AddMessage( "cMinimapButtonBag loaded." );

end

function cMinimapButtonBag_Function_OnDragStart()

	cMinimapButtonBag_Frame_Button:StartMoving();

end

function cMinimapButtonBag_Function_OnDragStop()

	cMinimapButtonBag_Frame_Button:StopMovingOrSizing();

end
--===================================================================================================================--


function cMinimapButtonBag_Function_RenameBags()

	cMinimapButtonBag_Frame_MenuButton1:SetText( "Bag1 (" .. cMinimapButtonBag_Function_GetNumberOfStuffInBag(0)-1 .. "/" .. GetContainerNumSlots(0) .. ")" );
	cMinimapButtonBag_Frame_MenuButton2:SetText( "Bag2 (" .. cMinimapButtonBag_Function_GetNumberOfStuffInBag(1) .. "/" .. GetContainerNumSlots(1) .. ")" );
	cMinimapButtonBag_Frame_MenuButton3:SetText( "Bag3 (" .. cMinimapButtonBag_Function_GetNumberOfStuffInBag(2) .. "/" .. GetContainerNumSlots(2) .. ")" );
	cMinimapButtonBag_Frame_MenuButton4:SetText( "Bag4 (" .. cMinimapButtonBag_Function_GetNumberOfStuffInBag(3) .. "/" .. GetContainerNumSlots(3) .. ")" );
	cMinimapButtonBag_Frame_MenuButton5:SetText( "Bag5 (" .. cMinimapButtonBag_Function_GetNumberOfStuffInBag(4) .. "/" .. GetContainerNumSlots(4) .. ")" );

end

function cMinimapButtonBag_Function_GetNumberOfStuffInBag( BagNumber )

	local UsedSlots = 0;

	for BagSlot = 0, GetContainerNumSlots(BagNumber), 1 do
	
		if( GetContainerItemInfo(BagNumber,BagSlot) )
		then
			UsedSlots = UsedSlots + 1;
		end
	end

	return UsedSlots;

end


function cMinimapButtonBag_Function_ToggleBags()

	if( MainMenuBarBackpackButton:IsVisible() )
	then
		MainMenuBarBackpackButton:Hide();
		CharacterBag0Slot:Hide();
		CharacterBag1Slot:Hide();
		CharacterBag2Slot:Hide();
		CharacterBag3Slot:Hide();
		KeyRingButton:Hide();
	else
		MainMenuBarBackpackButton:Show();
		CharacterBag0Slot:Show();
		CharacterBag1Slot:Show();
		CharacterBag2Slot:Show();
		CharacterBag3Slot:Show();
		KeyRingButton:Show();
	end
	
end
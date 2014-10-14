BIB_MIN_SCALE = .5;
BIB_MAX_SCALE = 2.5;

function ScaleFrame(frame, absXanchor, absYanchor, scale)
	local oldscale = frame:GetEffectiveScale();
	local absLeft = frame:GetLeft() * oldscale;
	local absTop = frame:GetTop() * oldscale;
	local absHorDistance = absLeft - absXanchor;
	local absVerDistance = absYanchor - absTop;

	frame:SetScale(scale / frame:GetParent():GetEffectiveScale());
	frame:ClearAllPoints();
	frame:SetPoint("TOPLEFT", "UIParent", "BOTTOMLEFT", (absXanchor / scale) + (absHorDistance / oldscale), (absYanchor / scale) - (absVerDistance / oldscale));
end


CloseOnEscUIPanels = {"CharacterFrame", "SpellBookFrame", "TalentFrame", "QuestLogFrame", "FriendsFrame",
                      "MailFrame", "OpenMailFrame", "TradeSkillFrame", "MerchantFrame", "ClassTrainerFrame",
                      "GossipFrame", "MacroFrame", "AuctionFrame", "BankFrame", "LootFrame", "TaxiFrame",
                      "QuestFrame", "ItemTextFrame", "WorldMapFrame", "BibActionButtonIdMenu", "BibScaleEditBox",
                      "TradeFrame", "CraftFrame", "InspectFrame", "ClassTrainerFrame", "DressUpFrame"};

function ShowUIPanel(frame, force)
	if ( not frame or frame:IsVisible() ) then
		return;
	end
	if ( not CanOpenPanels() and (frame ~= GameMenuFrame and frame ~= UIOptionsFrame and frame ~= SoundOptionsFrame and frame ~= OptionsFrame and frame ~= KeyBindingFrame and frame ~= HelpFrame and frame ~= SuggestFrame and frame ~= WorldStateScoreFrame) ) then
		return;
	end
	
	local info = UIPanelWindows[frame:GetName()];
	if ( not info ) then
		frame:Show();
		return;
	end
	
	if ( UnitIsDead("player") and (info.area ~= "center") and (info.area ~= "full") and (frame ~= SuggestFrame) ) then
		NotWhileDeadError();
		return;
	end
	
	-- If we have a full-screen frame open, ignore other non-fullscreen open requests
	if ( GetFullScreenFrame() and (info.area ~= "full") ) then
		if ( force ) then
			SetFullScreenFrame(nil);
		else
			return;
		end
	end
	
	-- If we have a "center" frame open, only listen to other "center" open requests
	local centerFrame = GetCenterFrame();
	local centerInfo = nil;
	if ( centerFrame ) then
		centerInfo = UIPanelWindows[centerFrame:GetName()];
		if ( centerInfo and (centerInfo.area == "center")  and (info.area ~= "center") ) then
			if ( force ) then
				SetCenterFrame(nil);
			else
				return;
			end
		end
	end
	
	-- Full-screen frames just replace each other
	if ( info.area == "full" ) then
		CloseAllWindows();
		SetFullScreenFrame(frame);
		return;
	end
	
	-- Native "center" frames just replace each other, and they take priority over pushed frames
	if ( info.area == "center" ) then
		CloseWindows();
		CloseAllBags();
		SetCenterFrame(frame, 1);
		return;
	end
	
	frame:Show();
end

function HideUIPanel(frame)
	if ( not frame or not frame:IsShown() ) then
		return;
	end
	
	-- If we're hiding the full-screen frame, just hide it
	if ( frame == GetFullScreenFrame() ) then
		SetFullScreenFrame(nil);
		return;
	end
	
	-- If we're hiding the center frame, just hide it
	if ( frame == GetCenterFrame() ) then
		SetCenterFrame(nil);
		return;
	end
	
	frame:Hide();
end

function CloseWindows(ignoreCenter)
	-- This function will close all frames that are not the current frame
	local centerFrame = GetCenterFrame();
	local doublewideFrame = GetDoublewideFrame();
	local fullScreenFrame = GetFullScreenFrame();
	local found = centerFrame or fullScreenFrame;

	HideUIPanel(fullScreenFrame);
	
	BibScaleEditBox:Hide();
	for key, val in CloseOnEscUIPanels do
		panel = getglobal(val);
		if (panel ~= nil and panel:IsVisible()) then
			panel:Hide();
			found = 1;
		end
	end

	if ( centerFrame ) then
		local info = UIPanelWindows[centerFrame:GetName()];
		if ( not info or (info.area ~= "center") or not ignoreCenter ) then
			HideUIPanel(centerFrame);
		end	
	end

	local frame;
	for index, value in UISpecialFrames do
		frame = getglobal(value);
		if ( frame and frame:IsVisible() ) then
			frame:Hide();
			found = 1;
		end
	end

	return found;
end

function BibRound(number)
	if((number - floor(number)) >= .5) then
		return ceil(number);
	else
		return floor(number);
	end
end
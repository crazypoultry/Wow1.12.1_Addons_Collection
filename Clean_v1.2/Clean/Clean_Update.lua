function C_MouseOver()
	
	-- The formula is C_Frame(Frame, ButtonID connected to frame, combat);
	-- Combat is not inplanted yet
	-- if you just use button id connected to frame you can change the id in xml with no problem
	-- as long it is under C_Ant_Frames value
	
	C_Frame(PlayerFrame, CleanButton1:GetID(), false);
	C_Frame(MinimapCluster, CleanButton4:GetID(), false);
	
	if (UnitName("target")) then
		C_Frame(TargetFrame, CleanButton2:GetID(), false);
		
		-- I don't wanna show combo point at all for other classes that why it looks like this
		
		if (ComboFrame:IsVisible() and not TargetFrame:IsVisible()) then
			C_Frame(ComboFrame, false, false);
		end
	end
	
	-- The for loop ends with the ant partymembers. No party member and the for loop never starts
	
	for i = 1 ,GetNumPartyMembers() ,1 do
		C_Frame(getglobal("PartyMemberFrame"..i), getglobal("CleanButton"..i+5):GetID(), false);
	end

	if (CastingBarFrame:IsVisible() and C.CastingBar == false) then
		C_Frame(CastingBarFrame, true, false);
	end
		
	--if (CastingBarFrame)
	--	if (C.CastingBar == true);
	
	-- I'm not checking if the mouse is over MainMenuBar, ChatFrame1 and BuffFrame. 
	-- I check the mouse is over the frame I created, this becouse these frames are more then one piece
	
	if (MouseIsOver(C_BottomScreen) and C.Locked[3] == true or C.Frame[CleanButton3:GetID()] and C.Locked[3] == true or
		MouseIsOver(C_BottomScreen) and C.Lock == false or C.Frame[CleanButton3:GetID()]) then
		MainMenuBar:Show();
		MultiBarBottomLeft:Show();
		MultiBarBottomRight:Show();
	else
		MainMenuBar:Hide();
		MultiBarBottomLeft:Hide();
		MultiBarBottomRight:Hide();
	end
	
	if (MouseIsOver(C_ChatBox1) and C.Locked[5] == true or C.Frame[CleanButton5:GetID()] and C.Locked[5] == true or
		MouseIsOver(C_ChatBox1) and C.Lock == false or C.Frame[CleanButton5:GetID()]) then
		ChatFrame1:Show();
		ChatFrameMenuButton:Show();
		ChatFrame1Tab:Show();
		ChatFrame2Tab:Show();
		C_ChatBox1:Show();
	else
		ChatFrame1:Hide();
		ChatFrameMenuButton:Hide();
		ChatFrame1Tab:Hide();
		ChatFrame2Tab:Hide();
		C_ChatBox1:Hide();
	end
	if (MouseIsOver(C_BuffBox1) and C.Locked[10] == true or C.Frame[CleanButton10:GetID()] and C.Locked[10] == true or
		MouseIsOver(C_BuffBox1) and C.Lock == false or C.Frame[CleanButton10:GetID()]) then
		BuffFrame:Show();
	else
		BuffFrame:Hide();
	end
	
	-- I check if anyone have rezised the chatframe, the checkarea most be at least y=150 otherwhise the checkbox don't work
	
	if (ChatFrame1:GetHeight() > 150) then
  		C_ChatBox1:SetHeight(ChatFrame1:GetHeight()+30);
  	end
  	
  	C_ChatBox1:SetWidth(ChatFrame1:GetWidth()+30);

  	if (C.Button == false) then
  		for i=1, 10, 1 do
  			getglobal("CleanButton"..i):Hide();
  		end
  	else
  		for i=1, 10, 1 do
  			getglobal("CleanButton"..i):Show();
  		end
  	end
end


-- The function who shows frames

function C_Frame(frame, ID, ID2)
	if (C.Frame[ID] == true and C.Lock == false or
		C.Locked[ID] == true and C.Lock == true and C.Frame[ID] == true) then
		frame:Show();	
	elseif (MouseIsOver(frame) and C.Lock == false or
			MouseIsOver(frame) and C.Lock == true and C.Locked[ID] == true) then
		frame:Show();
	else
		frame:Hide();	
	end
end
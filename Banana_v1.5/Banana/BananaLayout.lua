
function Banana_SetLayout(layout)
	BANANA_BUTTON_LAYOUT = layout;
	Banana_Layout();
end

function Banana_Layout()
	if BANANA_BUTTON_LAYOUT == 1 then
		Banana_Layout1();
		return;
	end 
	if BANANA_BUTTON_LAYOUT == 2 then
		Banana_Layout2();
		return;
	end 
	if BANANA_BUTTON_LAYOUT == 3 then
		Banana_Layout3();
		return;
	end 
	if BANANA_BUTTON_LAYOUT == 4 then
		Banana_Layout4();
		return;
	end 
	Banana_Layout5();
end


function Banana_Layout1()
	Banana_Print("Layout 1");

	RaidTargetFrame1Button:SetMovable(true);
	RaidTargetFrame2Button:SetMovable(false);
	RaidTargetFrame3Button:SetMovable(false);
	RaidTargetFrame4Button:SetMovable(false);
	RaidTargetFrame5Button:SetMovable(false);
	RaidTargetFrame6Button:SetMovable(false);
	RaidTargetFrame7Button:SetMovable(false);
	RaidTargetFrame8Button:SetMovable(false);
	RaidTargetFrame9Button:SetMovable(true);

	RaidTargetFrame1Button:ClearAllPoints();
	RaidTargetFrame2Button:ClearAllPoints();
	RaidTargetFrame2Button:SetPoint("LEFT", RaidTargetFrame1Button, "RIGHT",4,0);
	RaidTargetFrame3Button:ClearAllPoints();
	RaidTargetFrame3Button:SetPoint("LEFT", RaidTargetFrame2Button, "RIGHT",4,0);
	RaidTargetFrame4Button:ClearAllPoints();
	RaidTargetFrame4Button:SetPoint("LEFT", RaidTargetFrame3Button, "RIGHT",4,0);
	RaidTargetFrame5Button:ClearAllPoints();
	RaidTargetFrame5Button:SetPoint("LEFT", RaidTargetFrame4Button, "RIGHT",4,0);
	RaidTargetFrame6Button:ClearAllPoints();
	RaidTargetFrame6Button:SetPoint("LEFT", RaidTargetFrame5Button, "RIGHT",4,0);
	RaidTargetFrame7Button:ClearAllPoints();
	RaidTargetFrame7Button:SetPoint("LEFT", RaidTargetFrame6Button, "RIGHT",4,0);
	RaidTargetFrame8Button:ClearAllPoints();
	RaidTargetFrame8Button:SetPoint("LEFT", RaidTargetFrame7Button, "RIGHT",4,0);
	RaidTargetFrame9Button:ClearAllPoints();
	
	BANANA_ICON[1].MovingButton = 1;
	BANANA_ICON[2].MovingButton = 1;
	BANANA_ICON[3].MovingButton = 1;
	BANANA_ICON[4].MovingButton = 1;
	BANANA_ICON[5].MovingButton = 1;
	BANANA_ICON[6].MovingButton = 1;
	BANANA_ICON[7].MovingButton = 1;
	BANANA_ICON[8].MovingButton = 1;
	BANANA_ICON[9].MovingButton = 9;
end

function Banana_Layout2()
	Banana_Print("Layout 2");
	RaidTargetFrame1Button:SetMovable(true);
	RaidTargetFrame2Button:SetMovable(false);
	RaidTargetFrame3Button:SetMovable(false);
	RaidTargetFrame4Button:SetMovable(false);
	RaidTargetFrame5Button:SetMovable(false);
	RaidTargetFrame6Button:SetMovable(false);
	RaidTargetFrame7Button:SetMovable(false);
	RaidTargetFrame8Button:SetMovable(false);
	RaidTargetFrame9Button:SetMovable(true);
    
	RaidTargetFrame1Button:ClearAllPoints();
	RaidTargetFrame2Button:ClearAllPoints();
	RaidTargetFrame2Button:SetPoint("LEFT", RaidTargetFrame1Button, "RIGHT",4,0);
	RaidTargetFrame3Button:ClearAllPoints();
	RaidTargetFrame3Button:SetPoint("LEFT", RaidTargetFrame2Button, "RIGHT",4,0);
	RaidTargetFrame4Button:ClearAllPoints();
	RaidTargetFrame4Button:SetPoint("LEFT", RaidTargetFrame3Button, "RIGHT",4,0);
	RaidTargetFrame5Button:ClearAllPoints();
	RaidTargetFrame5Button:SetPoint("TOP", RaidTargetFrame1Button, "BOTTOM",0,-4);
	RaidTargetFrame6Button:ClearAllPoints();
	RaidTargetFrame6Button:SetPoint("LEFT", RaidTargetFrame5Button, "RIGHT",4,0);
	RaidTargetFrame7Button:ClearAllPoints();
	RaidTargetFrame7Button:SetPoint("LEFT", RaidTargetFrame6Button, "RIGHT",4,0);
	RaidTargetFrame8Button:ClearAllPoints();
	RaidTargetFrame8Button:SetPoint("LEFT", RaidTargetFrame7Button, "RIGHT",4,0);
	RaidTargetFrame9Button:ClearAllPoints();

	BANANA_ICON[1].MovingButton = 1;
	BANANA_ICON[2].MovingButton = 1;
	BANANA_ICON[3].MovingButton = 1;
	BANANA_ICON[4].MovingButton = 1;
	BANANA_ICON[5].MovingButton = 1;
	BANANA_ICON[6].MovingButton = 1;
	BANANA_ICON[7].MovingButton = 1;
	BANANA_ICON[8].MovingButton = 1;
	BANANA_ICON[9].MovingButton = 9;

	
end

function Banana_Layout3()
	Banana_Print("Layout 3");
	RaidTargetFrame1Button:SetMovable(true);
	RaidTargetFrame2Button:SetMovable(false);
	RaidTargetFrame3Button:SetMovable(false);
	RaidTargetFrame4Button:SetMovable(false);
	RaidTargetFrame5Button:SetMovable(false);
	RaidTargetFrame6Button:SetMovable(false);
	RaidTargetFrame7Button:SetMovable(false);
	RaidTargetFrame8Button:SetMovable(false);
	RaidTargetFrame9Button:SetMovable(true);
    
	RaidTargetFrame1Button:ClearAllPoints();
	RaidTargetFrame2Button:ClearAllPoints();
	RaidTargetFrame2Button:SetPoint("LEFT", RaidTargetFrame1Button, "RIGHT",4,0);
	RaidTargetFrame3Button:ClearAllPoints();
	RaidTargetFrame3Button:SetPoint("TOP", RaidTargetFrame1Button, "BOTTOM",0,-4);
	RaidTargetFrame4Button:ClearAllPoints();
	RaidTargetFrame4Button:SetPoint("LEFT", RaidTargetFrame3Button, "RIGHT",4,0);
	RaidTargetFrame5Button:ClearAllPoints();
	RaidTargetFrame5Button:SetPoint("TOP", RaidTargetFrame3Button, "BOTTOM",0,-4);
	RaidTargetFrame6Button:ClearAllPoints();
	RaidTargetFrame6Button:SetPoint("LEFT", RaidTargetFrame5Button, "RIGHT",4,0);
	RaidTargetFrame7Button:ClearAllPoints();
	RaidTargetFrame7Button:SetPoint("TOP", RaidTargetFrame5Button, "BOTTOM",0,-4);
	RaidTargetFrame8Button:ClearAllPoints();
	RaidTargetFrame8Button:SetPoint("LEFT", RaidTargetFrame7Button, "RIGHT",4,0);
	RaidTargetFrame9Button:ClearAllPoints();

	BANANA_ICON[1].MovingButton = 1;
	BANANA_ICON[2].MovingButton = 1;
	BANANA_ICON[3].MovingButton = 1;
	BANANA_ICON[4].MovingButton = 1;
	BANANA_ICON[5].MovingButton = 1;
	BANANA_ICON[6].MovingButton = 1;
	BANANA_ICON[7].MovingButton = 1;
	BANANA_ICON[8].MovingButton = 1;
	BANANA_ICON[9].MovingButton = 9;

end

function Banana_Layout4()
	Banana_Print("Layout 4");
	RaidTargetFrame1Button:SetMovable(true);
	RaidTargetFrame2Button:SetMovable(false);
	RaidTargetFrame3Button:SetMovable(false);
	RaidTargetFrame4Button:SetMovable(false);
	RaidTargetFrame5Button:SetMovable(false);
	RaidTargetFrame6Button:SetMovable(false);
	RaidTargetFrame7Button:SetMovable(false);
	RaidTargetFrame8Button:SetMovable(false);
	RaidTargetFrame9Button:SetMovable(true);
	RaidTargetFrame1Button:ClearAllPoints();
	RaidTargetFrame2Button:ClearAllPoints();
	RaidTargetFrame2Button:SetPoint("TOP", RaidTargetFrame1Button, "BOTTOM",0,-4);
	RaidTargetFrame3Button:ClearAllPoints();
	RaidTargetFrame3Button:SetPoint("TOP", RaidTargetFrame2Button, "BOTTOM",0,-4);
	RaidTargetFrame4Button:ClearAllPoints();
	RaidTargetFrame4Button:SetPoint("TOP", RaidTargetFrame3Button, "BOTTOM",0,-4);
	RaidTargetFrame5Button:ClearAllPoints();
	RaidTargetFrame5Button:SetPoint("TOP", RaidTargetFrame4Button, "BOTTOM",0,-4);
	RaidTargetFrame6Button:ClearAllPoints();
	RaidTargetFrame6Button:SetPoint("TOP", RaidTargetFrame5Button, "BOTTOM",0,-4);
	RaidTargetFrame7Button:ClearAllPoints();
	RaidTargetFrame7Button:SetPoint("TOP", RaidTargetFrame6Button, "BOTTOM",0,-4);
	RaidTargetFrame8Button:ClearAllPoints();
	RaidTargetFrame8Button:SetPoint("TOP", RaidTargetFrame7Button, "BOTTOM",0,-4);
	RaidTargetFrame9Button:ClearAllPoints();

	BANANA_ICON[1].MovingButton = 1;
	BANANA_ICON[2].MovingButton = 1;
	BANANA_ICON[3].MovingButton = 1;
	BANANA_ICON[4].MovingButton = 1;
	BANANA_ICON[5].MovingButton = 1;
	BANANA_ICON[6].MovingButton = 1;
	BANANA_ICON[7].MovingButton = 1;
	BANANA_ICON[8].MovingButton = 1;
	BANANA_ICON[9].MovingButton = 9;

end

function Banana_Layout5()
	Banana_Print("Layout 5");
	
	RaidTargetFrame1Button:SetMovable(true);
	RaidTargetFrame2Button:SetMovable(true);
	RaidTargetFrame3Button:SetMovable(true);
	RaidTargetFrame4Button:SetMovable(true);
	RaidTargetFrame5Button:SetMovable(true);
	RaidTargetFrame6Button:SetMovable(true);
	RaidTargetFrame7Button:SetMovable(true);
	RaidTargetFrame8Button:SetMovable(true);
	RaidTargetFrame9Button:SetMovable(true);
	
	RaidTargetFrame1Button:ClearAllPoints();
	RaidTargetFrame2Button:ClearAllPoints();
	RaidTargetFrame3Button:ClearAllPoints();
	RaidTargetFrame4Button:ClearAllPoints();
	RaidTargetFrame5Button:ClearAllPoints();
	RaidTargetFrame6Button:ClearAllPoints();
	RaidTargetFrame7Button:ClearAllPoints();
	RaidTargetFrame8Button:ClearAllPoints();
	RaidTargetFrame9Button:ClearAllPoints();

	BANANA_ICON[1].MovingButton = 1;
	BANANA_ICON[2].MovingButton = 2;
	BANANA_ICON[3].MovingButton = 3;
	BANANA_ICON[4].MovingButton = 4;
	BANANA_ICON[5].MovingButton = 5;
	BANANA_ICON[6].MovingButton = 6;
	BANANA_ICON[7].MovingButton = 7;
	BANANA_ICON[8].MovingButton = 8;
	BANANA_ICON[9].MovingButton = 9;

	Banana_ReloadFramePositions();
end


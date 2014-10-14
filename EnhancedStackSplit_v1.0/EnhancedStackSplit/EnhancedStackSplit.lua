-- -----------------------------
-- EnhancedStackSplit v2.0.0
-- -----------------------------

local ESS_org_OpenStackSplitFrame;
ESS_ModeTXT = {};
ESS_ModeTXT[0] = "Standard";
ESS_ModeTXT[1] = "One-Click";
if ( not ESS_Mode ) then ESS_Mode = 0; end
if ( not ESS_ModeButton ) then ESS_ModeButton = 1; end

function ESS_ChatOutput(text)
	if( DEFAULT_CHAT_FRAME ) then
		DEFAULT_CHAT_FRAME:AddMessage(text);
	end
end

function ESS_OnLoad()
	ESS_org_OpenStackSplitFrame = OpenStackSplitFrame;
	OpenStackSplitFrame = ESS_OpenStackSplitFrame;
	ESS_ChatOutput("|cff6699ffEnhancedStackSplit v1.0.11000 |cffffffffloaded! - '|cffffff99/ess|cffffffff' for options and info");
	SLASH_ESS1 = "/enhancedstacksplit";
	SLASH_ESS2 = "/ess";
	SlashCmdList["ESS"] = function(msg)
		ESS_SlashCommand(msg);
	end
end

function ESS_OpenStackSplitFrame(maxStack, parent, anchor, anchorTo)
  ESS_showEnhancedStackSplitFrame(maxStack, parent, anchor, anchorTo);
	return ESS_org_OpenStackSplitFrame(maxStack, parent, anchor, anchorTo);
end

function ESS_showEnhancedStackSplitFrame(maxStack, parent, anchor, anchorTo)
	getglobal("EnhancedStackSplitFrame"):Show();
	getglobal("EnhancedStackSplitMaxTextFrame"):Show();
	if (ESS_ModeButton == 0) then getglobal("EnhancedStackSplitModeTXTButton"):Hide(); getglobal("EnhancedStackSplitFrame"):SetHeight(35); end
	if (ESS_ModeButton == 1) then getglobal("EnhancedStackSplitModeTXTButton"):Show(); getglobal("EnhancedStackSplitFrame"):SetHeight(50); end
	getglobal("EnhancedStackSplitMaxTextFrameTXT"):SetText("max:"..maxStack);
	getglobal("EnhancedStackSplitModeTXTButton"):SetText(ESS_ModeTXT[ESS_Mode].." mode");
	for i = 1, 6 do
		getglobal("EnhancedStackSplitButton"..i):Enable();
	end
	if ( maxStack == 2 ) then
		getglobal("EnhancedStackSplitButton2"):Disable();
		getglobal("EnhancedStackSplitButton3"):Disable();
		getglobal("EnhancedStackSplitButton4"):Disable();
		getglobal("EnhancedStackSplitButton5"):Disable();
		getglobal("EnhancedStackSplitButton6"):Disable();
	end
	if ( maxStack == 3 ) then
		getglobal("EnhancedStackSplitButton3"):Disable();
		getglobal("EnhancedStackSplitButton4"):Disable();
		getglobal("EnhancedStackSplitButton5"):Disable();
		getglobal("EnhancedStackSplitButton6"):Disable();
	end
	if ( maxStack == 4 ) then
		getglobal("EnhancedStackSplitButton4"):Disable();
		getglobal("EnhancedStackSplitButton5"):Disable();
		getglobal("EnhancedStackSplitButton6"):Disable();
	end
	if ( maxStack == 5 ) then
		getglobal("EnhancedStackSplitButton5"):Disable();
		getglobal("EnhancedStackSplitButton6"):Disable();
	end
	if ( maxStack > 5 and maxStack <= 10 ) then
		getglobal("EnhancedStackSplitButton6"):Disable();
	end
end

function ESS_SetNewSplitSize(num)
	if ( num >= StackSplitFrame.maxStack ) then
		num = StackSplitFrame.maxStack;
		StackSplitRightButton:Disable();
	end
	if ( num < StackSplitFrame.maxStack ) then
		StackSplitRightButton:Enable();
	end
	StackSplitLeftButton:Enable();
	StackSplitFrame.split = num;
	StackSplitText:SetText(num);
	if (num > 0) then StackSplitFrameOkay_Click(); end
	if ( ESS_Mode == 1 ) then StackSplitFrameOkay_Click(); end
end

function ESS_SlashCommand(msg)
	if (msg == "") then
		ESS_ChatOutput("|cff6699ffEnhancedStackSplit v1.0.11000");
		ESS_ChatOutput("- current StackSplit click mode: |cffffff99"..ESS_ModeTXT[ESS_Mode]);
		if (ESS_ModeButton == 0) then ESS_ChatOutput("- current mode toggle button: |cffffff99HIDE"); end
		if (ESS_ModeButton == 1) then ESS_ChatOutput("- current mode toggle button: |cffffff99SHOW"); end
		ESS_ChatOutput("- use '|cffffff99/ess button|cffffffff' for hide/show mode toggle button");
		ESS_ChatOutput("- use '|cffffff99/ess mode|cffffffff' for StackSplit click mode change");
		ESS_ChatOutput("- |cffffff99"..ESS_ModeTXT[0].."|cffffffff mode: click on an ESS Button to change the number for split or buy. click OK to confirm.");
		ESS_ChatOutput("- |cffffff99"..ESS_ModeTXT[1].."|cffffffff mode: click on an ESS Button to split or buy. |cffff9900ATTENTION: |cffffffffno OK to confirm!!!");
	end
	if (msg == "mode") then
		if (ESS_Mode == 0) then
			ESS_Mode = 1;
		else
			ESS_Mode = 0;
		end
		ESS_ChatOutput("|cff6699ffEnhancedStackSplit|cffffffff - StackSplit click mode changed to |cffffff99"..ESS_ModeTXT[ESS_Mode].."|cffffffff - '|cffffff99/ess|cffffffff' for info");
		getglobal("EnhancedStackSplitModeTXTButton"):SetText(ESS_ModeTXT[ESS_Mode].." mode");
	end
	if (msg == "button") then
		if (ESS_ModeButton == 0) then
			ESS_ModeButton = 1;
			ESS_ChatOutput("|cff6699ffEnhancedStackSplit|cffffffff - mode toggle button changed to |cffffff99SHOW|cffffffff - '|cffffff99/ess|cffffffff' for info");
			getglobal("EnhancedStackSplitFrame"):SetHeight(50);
			getglobal("EnhancedStackSplitModeTXTButton"):Show();
		else
			ESS_ModeButton = 0;
			ESS_ChatOutput("|cff6699ffEnhancedStackSplit|cffffffff - mode toggle button changed to |cffffff99HIDE|cffffffff - '|cffffff99/ess|cffffffff' for info");
			getglobal("EnhancedStackSplitFrame"):SetHeight(35);
			getglobal("EnhancedStackSplitModeTXTButton"):Hide();
		end
	end
end

function ER_ContainerFrame_InitLocation()
	local playerClass;
	_, playerClass = UnitClass("player");
	if ( not(playerClass == 'HUNTER' or playerClass == 'WARLOCK') ) then
		ER_ContainerFrame:SetPoint("TOPLEFT", "UIParent", "TOPLEFT", 10, -120);
	else
		ER_ContainerFrame:SetPoint("TOPLEFT", "UIParent", "TOPLEFT", 10, -135);
	end
	ER_ContainerFrame:SetWidth((72+10)*4);
	local height;
	if ( DEFAULT_CHAT_FRAME ) then
		height = ER_ContainerFrame:GetTop() - DEFAULT_CHAT_FRAME:GetTop() - 10;
	end
	if (not height or height < 350 ) then
		height = 350;
	end
	ER_ContainerFrame:SetHeight(height);
	ValidateFramePosition(ER_ContainerFrame);

	ER_ContainerFrame_SaveLocation();
end

function ER_ContainerFrame_LoadLocation()
	if ( ER_Config.containerFrameLocation ) then
		ER_ContainerFrame:SetPoint("TOPLEFT", "UIParent", "TOPLEFT", ER_Config.containerFrameLocation.left, ER_Config.containerFrameLocation.top);
		ER_ContainerFrame:SetWidth(ER_Config.containerFrameLocation.width);
		ER_ContainerFrame:SetHeight(ER_Config.containerFrameLocation.height);
	end
end

function ER_ContainerFrame_SaveLocation()
	ER_Config.containerFrameLocation = { };
	ER_Config.containerFrameLocation.left = ER_ContainerFrame:GetLeft() - UIParent:GetLeft();
	ER_Config.containerFrameLocation.top = ER_ContainerFrame:GetTop() - UIParent:GetTop();
	ER_Config.containerFrameLocation.width = ER_ContainerFrame:GetWidth();
	ER_Config.containerFrameLocation.height = ER_ContainerFrame:GetHeight();
end

function ER_ContainerFrame_StartMoving()
	ER_ContainerFrame:StartMoving();
	ER_ContainerFrameIsMovingOrSizing = true;
	ER_RaidPulloutFrame_Update();
end

function ER_ContainerFrame_StopMoving()
	ER_ContainerFrame:StopMovingOrSizing();
	ER_ContainerFrameIsMovingOrSizing = false;
	ValidateFramePosition(ER_ContainerFrame, 25);
	ER_ContainerFrame_SaveLocation();
	ER_RaidPulloutFrame_Update();
end

function ER_ContainerFrame_OnEnter()
	if ( not ER_OptionsSideFrame:IsShown() ) then
		if ( ER_ContainerFrame:GetAlpha() ~= ER_CONTAINER_FRAME_ALPHA ) then
			UIFrameFadeRemoveFrame(ER_ContainerFrame);
			UIFrameFadeIn(ER_ContainerFrame, 1, ER_ContainerFrame:GetAlpha(), ER_CONTAINER_FRAME_ALPHA);
		end
	end
end

function ER_ContainerFrame_OnLeave()
	if ( not ER_OptionsSideFrame:IsShown() ) then
		if ( GetMouseFocus() == WorldFrame ) then
			UIFrameFadeRemoveFrame(ER_ContainerFrame);
			local fadeInfo = {};
			fadeInfo.mode = "OUT";
			fadeInfo.timeToFade = 2;
			fadeInfo.startAlpha = ER_CONTAINER_FRAME_ALPHA;
			fadeInfo.endAlpha = 0;
			fadeInfo.finishedFunc = ER_ContainerFrame_OnFinishedFadeOut;
			UIFrameFade(ER_ContainerFrame, fadeInfo);
		end
	end
end

function ER_ContainerFrame_OnFinishedFadeOut()
	ER_ContainerFrame:Hide();
end

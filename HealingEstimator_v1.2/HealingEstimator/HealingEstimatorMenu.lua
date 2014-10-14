local Loaded=false;
local OverhealingValue=0;

--------------------------------------------------------------------
-- OnLoad
--
function HealingEstimatorMenu_OnLoad()
	this:RegisterEvent("VARIABLES_LOADED");
end

--------------------------------------------------------------------
-- OnEvent
--
function HealingEstimatorMenu_OnEvent(event)
	if (Loaded) then
		return;
	end
	Loaded=true;

	-- Check if addon needs to be enabled
	if ( not HealingEstimator_IsHealingClass(UnitClass("player")) ) then
		return;
	end

	-- Set menu text
	HealingEstimatorMenuOverhealTitle:SetText(HealingEstimatorLoc.OverhealTitle);
	HealingEstimatorMenuBarTitle:SetText(HealingEstimatorLoc.BarTitle);
	HealingEstimatorMenuMinimapTitle:SetText(HealingEstimatorLoc.MinimapTitle);
	HealingEstimatorMenuPosSliderText:SetText(HealingEstimatorLoc.IconPos);


	-- Set sliders
	HealingEstimatorMenuLimitSliderHigh:SetText("100%");
	HealingEstimatorMenuLimitSliderLow:SetText("0%");
	HealingEstimatorMenuLimitSlider:SetMinMaxValues(0,1);
	HealingEstimatorMenuLimitSlider:SetValueStep(0.01);
	HealingEstimatorMenuLimitSlider:SetValue(HealingEstimatorData.Limit);
	
	HealingEstimatorMenuScaleSliderHigh:SetText("3");
	HealingEstimatorMenuScaleSliderLow:SetText("0");
	HealingEstimatorMenuScaleSlider:SetMinMaxValues(0.1,3);
	HealingEstimatorMenuScaleSlider:SetValueStep(0.1);
	HealingEstimatorMenuScaleSlider:SetValue(HealingEstimatorData.Scale);
	
	HealingEstimatorMenuPosSliderHigh:SetText("320");
	HealingEstimatorMenuPosSliderLow:SetText("0");
	HealingEstimatorMenuPosSlider:SetMinMaxValues(0,6.28);
	HealingEstimatorMenuPosSlider:SetValueStep(0.01);
	HealingEstimatorMenuPosSlider:SetValue(HealingEstimatorData.IconPos);


	-- Set minimap icon
	HealingEstimatorPie_SetPos();
	HealingEstimatorPie_SetValue(0);
	HealingEstimatorPieChart:Hide();
	HealingEstimatorMenuButtonHide:SetText(HealingEstimatorLoc.ShowText);
	if (HealingEstimatorData.Icon) then
		HealingEstimatorPieChart:Show();
		HealingEstimatorMenuButtonHide:SetText(HealingEstimatorLoc.HideText);
	end
end

--------------------------------------------------------------------
-- OnShow
--
function HealingEstimatorMenu_OnShow()
	-- Set bar visible
	HealingEstimator_ForceVisible(true);

	-- Set slider values
	HealingEstimatorMenuScaleSlider:SetValue(HealingEstimatorData.Scale);
	HealingEstimatorMenuLimitSlider:SetValue(HealingEstimatorData.Limit);
	HealingEstimatorMenuPosSlider:SetValue(HealingEstimatorData.IconPos);

	-- Set checkboxes
	HealingEstimatorMenuMinimapCheck:SetChecked( HealingEstimatorData.IconAnchoredAtMinimap );
	HealingEstimatorMenuCritCheck:SetChecked( HealingEstimatorData.ConvertCrits );
end

--------------------------------------------------------------------
-- Hide - hides config window
--
function HealingEstimatorMenu_Hide()
	HealingEstimatorMenu:Hide();
	HealingEstimator_ForceVisible(false);
end

--------------------------------------------------------------------
-- Toggle
function HealingEstimatorMenu_Minimap_Toggle()
	if (HealingEstimatorData.IconAnchoredAtMinimap) then
		HealingEstimatorData.IconAnchoredAtMinimap=false;
		HealingEstimatorPieChart:SetPoint("TOPLEFT","HealingEstimatorMenu","TOPRIGHT");
	else
		HealingEstimatorData.IconAnchoredAtMinimap=true;
		HealingEstimatorMenuPosSlider:SetValue(HealingEstimatorData.IconPos);
		HealingEstimatorPie_SetPos();
	end
end

--------------------------------------------------------------------
-- Toggle / Convert crits
function HealingEstimatorMenu_ConvertCrits_Toggle()
	HealingEstimatorData.ConvertCrits= not HealingEstimatorData.ConvertCrits;
end

--------------------------------------------------------------------
-- OnClick
--
function HealingEstimatorMenu_OnClick()
	local Name=this:GetName();
	--HealingEstimator_Print(true,"OnClick: "..Name);

	if (Name=="HealingEstimatorMenuButtonClear") then
		-- Clear data
		HealingEstimator_ClearData();

	elseif (Name=="HealingEstimatorMenuButtonHide") then
		local Text=HealingEstimatorMenuButtonHide:GetText();
		if (Text==HealingEstimatorLoc.HideText) then
			-- Hide piechard
			HealingEstimatorPieChart:Hide();
			HealingEstimatorData.Icon=false;
			HealingEstimator_Print(true,HealingEstimatorLoc.HideMeter);
			HealingEstimatorMenuButtonHide:SetText(HealingEstimatorLoc.ShowText);
		else
			HealingEstimatorPieChart:Show();
			HealingEstimatorData.Icon=true;
			HealingEstimatorMenuButtonHide:SetText(HealingEstimatorLoc.HideText);
		end
		
	elseif (Name=="HealingEstimatorMenuButtonResetPos") then
		-- Reset bar position
		HealingEstimator:ClearAllPoints();
		HealingEstimator:SetPoint("CENTER",HealingEstimatorMenu,"BOTTOM", 0,-10);

	elseif (Name=="HealingEstimatorMenuLimitSlider") then
		-- Limit slider
		local Limit=this:GetValue();
		HealingEstimatorData.Limit=Limit;
		Limit=floor(Limit*100);
		getglobal(this:GetName().."Text"):SetText(HealingEstimatorLoc.Limit..Limit.."%");

	elseif (Name=="HealingEstimatorMenuPosSlider") then
		-- Minimap button pos slider
		if (HealingEstimatorData.IconAnchoredAtMinimap) then
			-- Works only when it is anchored
			HealingEstimatorData.IconPos=this:GetValue();
			HealingEstimatorPie_SetPos();
		end

	elseif (Name=="HealingEstimatorMenuScaleSlider") then
		-- Bar scale slider
		local Scale=this:GetValue();
		local ScaleMove=HealingEstimatorData.Scale/Scale;
		HealingEstimatorData.Scale=Scale;
		local x,y=HealingEstimator:GetCenter();		-- Store the previous position
		HealingEstimator:SetScale(Scale);
		Scale=floor(Scale*100)/100;
		getglobal(this:GetName().."Text"):SetText(HealingEstimatorLoc.Scale..Scale);

		-- Reposition the bar
		HealingEstimator:ClearAllPoints();
		HealingEstimator:SetPoint("CENTER",UIParent,"BOTTOMLEFT",x*ScaleMove,y*ScaleMove);

	end
end

--------------------------------------------------------------------
-- Pie chart functions
--------------------------------------------------------------------

--------------------------------------------------------------------
-- Set pos
--
function HealingEstimatorPie_SetPos()
	if (HealingEstimatorData.IconAnchoredAtMinimap) then
		local x=52-(80*math.cos(HealingEstimatorData.IconPos));
		local y=(80*math.sin(HealingEstimatorData.IconPos))-52;
		HealingEstimatorPieChart:SetPoint("TOPLEFT","Minimap","TOPLEFT",x,y);
	end
end

--------------------------------------------------------------------
-- Set value
-- /script HealingEstimatorPie_SetValue(
function HealingEstimatorPie_SetValue(Percent)
	--local Slice=getglobal(this:GetName().."Slice");
	local Slice=getglobal("HealingEstimatorPieChartSlice");
	OverhealingValue=floor(Percent*100);

	-- Make sure that value is on range
	if (Percent>1) then
		Percent=1;
	elseif (Percent<0) then
		Percent=0;
	end

	-- Fix display at 0% and 100%
	if (Percent<0.1) then
		HealingEstimatorPieChartCenter:Show();
		HealingEstimatorPieChartCenter:SetTexCoord(0.52,0.6, 0.5,1);
	elseif (Percent>0.9) then
		HealingEstimatorPieChartCenter:Show();
		HealingEstimatorPieChartCenter:SetTexCoord(0.48,0.4, 0.5,1);
	else
		HealingEstimatorPieChartCenter:Hide();
	end

	-- Fill correct side
	if (Percent < 0.5) then
		-- Fill left side with green
		HealingEstimatorPieChartRightHalf:Hide();
		HealingEstimatorPieChartLeftHalf:Show();
	else
		-- Fill right side with red
		HealingEstimatorPieChartRightHalf:Show();
		HealingEstimatorPieChartLeftHalf:Hide();
	end
--[[
	local Points=
		{
		-- Points for the image image which is centered to a origin
		-- obj:SetTexCoord(ULx,ULy,LLx,LLy,URx,URy,LRx,LRy);
		{-1,1},{-1,-1},{1,1},{1,-1};
		};

	local c;
	local PI = 3.14159265;
	local Rad=Percent*2*PI;
	for c=1,4 do
		local x=Points[c][1];
		local y=Points[c][2];

		-- Do the rotation
		-- x' = x cos f - y sin f
		-- y' = y cos f + x sin f
		local newx=(x*math.cos(Rad)) - (y*math.sin(Rad));
		local newy=(y*math.cos(Rad)) + (x*math.sin(Rad));

		-- Transform origin centered coords to a texture coords
		Points[c][1]=(newx/2)+0.5;
		Points[c][2]=(newy/2)+0.5;
	end
	-- Set texture coordinates
	Slice:SetTexCoord(Points[1][1],Points[1][2], Points[2][1],Points[2][2],
			Points[3][1],Points[3][2], Points[4][1],Points[4][2]);
]]--
--[[
	{-1,1}
	x*Cos - y*Sin
	y*Cos + x*Sin
	-1*Cos - 1*Sin		-Cos-Sin		-(Cos+Sin)	a
	1*Cos + -1*Sin		Cos-Sin			Cos-Sin		b

	{-1,-1}
	x*Cos - y*Sin
	y*Cos + x*Sin
	-1*Cos - -1*Sin		-Cos+Sin		-(Cos-Sin)	c
	-1*Cos + -1*Sin		-Cos-Sin		-(Cos+Sin)	a

	{1,1}
	x*Cos - y*Sin
	y*Cos + x*Sin
	1*Cos - 1*Sin		Cos-Sin			Cos-Sin		b
	1*Cos + 1*Sin		Cos+Sin			Cos+Sin		d

	{1,-1}
	x*Cos - y*Sin
	y*Cos + x*Sin
	1*Cos - -1*Sin		Cos+Sin			Cos+Sin		d
	-1*Cos + 1*Sin		-Cos+Sin		-(Cos-Sin)	c

]]--
	local PI = 3.14159265;
	local Rad=Percent*2*PI;
	local Cos,Sin=math.cos(Rad)/2,math.sin(Rad)/2;
	local a=-(Cos+Sin)+0.5;
	local b=(Cos-Sin)+0.5;
	local c=-(Cos-Sin)+0.5;
	local d=(Cos+Sin)+0.5;
	Slice:SetTexCoord(a,b, c,a, b,d, d,c);

end

--------------------------------------------------------------------
-- Pie OnClick
--
function HealingEstimatorPie_OnClick(Button)
	if( Button ~= "LeftButton" ) then
		return false;
	end
	
	-- Return false at first click
	local Shown=HealingEstimatorMenu:IsVisible();
	HealingEstimatorMenu:Show();
	if (not Shown) then 
		return false;
	end
	
	-- Return info if pie is allowed to move
	return not HealingEstimatorData.IconAnchoredAtMinimap;
end

--------------------------------------------------------------------
-- Pie Tooltip
--
function HealingEstimatorPie_Tooltip()
	GameTooltip:SetOwner(UIParent, "ANCHOR_NONE");
	GameTooltip:ClearAllPoints();
	GameTooltip:SetPoint("TOPRIGHT",this:GetName(),"BOTTOMLEFT");
	GameTooltip:SetText(OverhealingValue.."% overhealing",1,1,1);

	local Heal,Over=HealingEstimator_GetData();
	GameTooltip:AddLine("  Total healing: ",0,1,0);
	GameTooltip:AddLine("  Total overhealing: ",1,0,0);
	GameTooltip:AddLine("  Effective healing: ",0,1,0);
	
	GameTooltipTextRight2:SetText(Heal.."  ");
	GameTooltipTextRight3:SetText(Over.."  ");
	GameTooltipTextRight4:SetText((Heal-Over).."  ");
	GameTooltipTextRight2:SetTextColor(0,1,0);
	GameTooltipTextRight3:SetTextColor(1,0,0);
	GameTooltipTextRight4:SetTextColor(0,1,0);
	GameTooltipTextRight2:Show();
	GameTooltipTextRight3:Show();
	GameTooltipTextRight4:Show();

	GameTooltip:AddLine("Left click for settings",0.8,0.8,0.8);
	GameTooltip:Show();
end

--------------------------------------------------------------------
-- Button Tooltip
--
function HealingEstimatorButton_Tooltip()
	local Name=this:GetName();

	GameTooltip:SetOwner(UIParent, "ANCHOR_NONE");
	GameTooltip:ClearAllPoints();
	GameTooltip:SetPoint("TOPRIGHT",Name,"BOTTOMLEFT");

	local Text="";
	if (Name=="HealingEstimatorMenuButtonResetPos") then
		Text=HealingEstimatorLoc.ResetPosTooltip;
	elseif (Name=="HealingEstimatorMenuButtonHide") then
		Text=HealingEstimatorLoc.HideTooltip;
	elseif (Name=="HealingEstimatorMenuButtonClear") then
		Text=HealingEstimatorLoc.ClearTooltip;
	end

	-- Set text
	if (Text) then
		GameTooltip:SetText(Text,0.8,0.8,0.8);
		GameTooltip:Show();
	end
end

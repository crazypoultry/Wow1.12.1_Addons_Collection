
ClassVOptionsFrameEvents = { };
ClassVOptionsFrameEvents [CLASSVOPTIONS_CHECK1.name]  = { index = 1, tooltipText = CLASSVOPTIONS_CHECK1.tooltipText, ClassVVar = "Locked"};
ClassVOptionsFrameEvents [CLASSVOPTIONS_CHECK2.name]  = { index = 2, tooltipText = CLASSVOPTIONS_CHECK2.tooltipText, ClassVVar = "NoTarget"};
ClassVOptionsFrameEvents [CLASSVOPTIONS_CHECK3.name]  = { index = 3, tooltipText = CLASSVOPTIONS_CHECK3.tooltipText, ClassVVar = "Player"};
ClassVOptionsFrameEvents [CLASSVOPTIONS_CHECK4.name]  = { index = 4, tooltipText = CLASSVOPTIONS_CHECK4.tooltipText, ClassVVar = "NPC"};
ClassVOptionsFrameEvents [CLASSVOPTIONS_CHECK5.name]  = { index = 5, tooltipText = CLASSVOPTIONS_CHECK5.tooltipText, ClassVVar = "Monster"};
ClassVOptionsFrameEvents [CLASSVOPTIONS_CHECK6.name]  = { index = 6, tooltipText = CLASSVOPTIONS_CHECK6.tooltipText, ClassVVar = "Unknown"};
ClassVOptionsFrameEvents [CLASSVOPTIONS_CHECK7.name]  = { index = 7, tooltipText = CLASSVOPTIONS_CHECK7.tooltipText, ClassVVar = "Tooltip"};

function ClassVOptions_OnLoad()
	UIPanelWindows["ClassVOptionsFrame"] = {area = "center", pushable = 0};
end

function ClassVOptions_OnShow()
	local button, string, checked;
	for key, value in pairs(ClassVOptionsFrameEvents) do
		local string = getglobal("ClassVOptionsFrame_CheckButton"..value.index.."Text");
		local button = getglobal("ClassVOptionsFrame_CheckButton"..value.index);
		checked = nil;
		button.disabled = nil;		
		if ( value.ClassVVar ) then
			if ( ClassV_Get(value.ClassVVar) == 1 ) then
				checked = 1;
			else
				checked = 0;
			end
		else
			checked = 0;
		end
		OptionsFrame_EnableCheckBox(button);
		button:SetChecked(checked);
		string:SetText(key);
		button.tooltipText = value.tooltipText;
	end
end

function ClassVOptions_CheckButtonOnClick()
	local button;
	for key, value in pairs(ClassVOptionsFrameEvents) do
		if (this:GetName() == "ClassVOptionsFrame_CheckButton"..value.index) then
			local enable = nil;
			button = getglobal("ClassVOptionsFrame_CheckButton"..value.index);
			if ( button:GetChecked() ) then
				enable = 1;
			else
				enable = 0;
			end
			if ( value.ClassVVar ) then
				ClassV_Set(value.ClassVVar, enable);
			end
		end
	end
end

function ClassVOptions_OnHide()
 	if (MYADDONS_ACTIVE_OPTIONSFRAME == this) then
		ShowUIPanel(myAddOnsFrame);
	end
end

--[[

PanzaPMM.lua
Panza PMM (Panza Mouse Module) Dialog
Revision 4.0

for in pairs() complete for BC
]]

function PA:PMM_OnLoad()
	PA.OptionsMenuTree[8] = {Title="Mouse", Frame=this, Tooltip="Mouse Options"};
	PA.GUIFrames[this:GetName()] = this;
	UIPanelWindows[this:GetName()] = {area = "center", pushable = 0};
end

function PA:PMM_SetValues()
	cbxPanzaPMMenable:SetChecked(PASettings.Switches.clickmode.enabled == true);
	for key, value in pairs(PA.PMMSupport) do
		getglobal("cbxPanzaPMM_"..key):SetChecked(PASettings.PMM[key]==true);
	end
end

function PA:PMM_Defaults()
	if (PA:CheckMessageLevel("Core", 4)) then
		PA:Message4("Resetting PMM settings to default.");
	end
	PASettings.Switches["clickmode"] = { enabled=false }; -- Disable Mouse support by default

	-- Set Default Mouse Function Values
	PASettings["clickmods"] = PA.defaultClick[PA.PlayerClass];

	-- Set Default Frame Support
	PASettings['PMM'] = {};
	for key, value in pairs(PA.PMMSupport) do
		PASettings['PMM'][key]=false;
	end
end

function PA:PMM_OnShow()
	PA:Reposition(PanzaPMMFrame, "UIParent", true);
	PanzaPMMFrame:SetAlpha(PASettings.Alpha);
	PA:PMM_SetValues();
end

function PA:PMM_OnHide()
	-- place holder
end

function PA:PMM_btnDone_OnClick()
	PA:FrameToggle(PanzaPMMFrame);
end

function PA:PMM_btnDown_OnClick(index)
end

function PA:PMM_btnUp_OnClick(index)
end

--------------------------------------------------------------------------
-- Populate PMM Dropdowns
--------------------------------------------------------------------------
function PA:DropDownPMMMenuOnLoad(frame,dropList,selectedID,callback,width)
    if (PA:CheckMessageLevel("UI",5)) then
	    PA:Message4("(PMM) Loading "..tostring(frame).." with "..getn(dropList).." entries.");
	   end
	UIDropDownMenu_Initialize(this, function()
		for index,value in pairs(dropList) do
			local info={}
				info.text = value;
				info.func = function()
					PA.PMMDropDownSelectedId=this:GetID();
					PA.PMMDropDownFrame=frame;
					UIDropDownMenu_SetSelectedID(frame, PA.PMMDropDownSelectedId);
					if (type(callback)=="function") then
						callback();
					end
				end
			UIDropDownMenu_AddButton(info);
			end
		end
		);

	if(width) then
		UIDropDownMenu_SetWidth(width);
	end

	if(not selectedID) then selectedID=1; end

	UIDropDownMenu_SetSelectedID(this,selectedID);
end

------------------------------------
-- PMM selected option from DropDown
------------------------------------
function Panza_PMMClickOnSelect()
	local frameName=PA.PMMDropDownFrame:GetName();
	--PA:ShowText("Frame = "..frameName);
	local _,_,option=string.find(frameName,".*_DropDownPMM_([^_]*)");
	if (frameName and option) then
		--PA:ShowText("Option "..option);
		--PA:ShowText("Old Assignment = "..PASettings["clickmods"][option]);
		--PA:ShowText("New Assignment = "..PA.PMMDropDownSelectedId);
		if (option~=nil and PA.PMMDropDownSelectedId~=nil) then
			PASettings["clickmods"][option] = PA.PMMDropDownSelectedId;
		end
	else
		if (framename==nil) then
			if (PA:CheckMessageLevel("UI",5)) then
				PA:Message4("(PMM) Selected option has no frame id.");
			end
		end
		if (option==nil) then
			if (PA:CheckMessageLevel("UI",5)) then
				PA:Message4("(PMM) Option returned nil for selected id");
			end
		end
	end
end

--------------------------------------
-- Generic Tooltip Function
--------------------------------------
function PA:PMM_ShowTooltip(item, index)
	GameTooltip:SetOwner( getglobal(item:GetName()), "ANCHOR_TOP" );
	GameTooltip:ClearLines();
	GameTooltip:ClearAllPoints();
	GameTooltip:SetPoint("TOPLEFT", item:GetName(), "BOTTOMLEFT", 0, -2);
	GameTooltip:AddLine(PA.PMM_Tooltips[item:GetName()].tooltip1 );	
	if (PA.PMM_Tooltips[item:GetName()].tooltip2~=nil) then
		GameTooltip:AddLine(PA.PMM_Tooltips[item:GetName()].tooltip2, 1, 1, 1, 1, 1 );	
	end	
	if (PA.PMM_Tooltips[item:GetName()].tooltip3~=nil) then
		GameTooltip:AddLine(PA.PMM_Tooltips[item:GetName()].tooltip3, 1, 1, 1, 1, 1 );	
	end	
	if (PA.PMM_Tooltips[item:GetName()].tooltip4~=nil) then
		GameTooltip:AddLine(PA.PMM_Tooltips[item:GetName()].tooltip4, 1, 1, 1, 1, 1 );	
	end	
	if (PA.PMM_Tooltips[item:GetName()].tooltip5~=nil) then
		GameTooltip:AddLine(PA.PMM_Tooltips[item:GetName()].tooltip5, 1, 1, 1, 1, 1 );	
	end	


	--GameTooltip:AddLine(PA.PMM_Tooltips[item:GetName()].tooltip2, 1, 1, 1, 1, 1 );
	GameTooltip:Show();
end
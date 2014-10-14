local RaidHealer_Tabs = { 
	"RaidHealer_HealAssignmentFrame",
	"RaidHealer_BuffAssignmentFrame",
	"RaidHealer_ConfigurationFrame"
};

function RaidHealer_MainFrame_OnLoad()	
	local cfName = RaidHealer_MainFrame:GetName();
	
	PanelTemplates_SetNumTabs(RaidHealer_MainFrame, 3);
	RaidHealer_MainFrame.selectedTab=1;
	PanelTemplates_UpdateTabs(RaidHealer_MainFrame);

end

function RaidHealer_MainFrame_OnShow()
	RaidHealer_DrawAssignmentFrames();
	RaidHealer_RefreshHealAssignmentFrame();
	RaidHealer_RefreshConfigurationFrame();
end

function RaidHealer_InitInterface()
	getglobal(RaidHealer_MainFrame:GetName().."_TitleText"):SetText(RAIDHEALER_NAME.." "..RAIDHEALER_VERSION);
	
	getglobal(RaidHealer_MainFrame:GetName().."Tab1"):SetText(RAIDHEALER_TAB1_TEXT);
	getglobal(RaidHealer_MainFrame:GetName().."Tab1").tooltipText = RAIDHEALER_HA_DESC;
	getglobal(RaidHealer_MainFrame:GetName().."Tab2"):SetText(RAIDHEALER_TAB2_TEXT);
	getglobal(RaidHealer_MainFrame:GetName().."Tab2").tooltipText = RAIDHEALER_BA_DESC;
	getglobal(RaidHealer_MainFrame:GetName().."Tab3"):SetText(RAIDHEALER_TAB3_TEXT);
	
	RaidHealer_InitInterfaceHealAssignmentFrame();
	RaidHealer_InitInterfaceBuffAssignmentFrame();
	RaidHealer_InitInterfaceConfiguartionFrame();
end

function RaidHealer_Tab_OnClick(frameName)
	local tab = tonumber(string.sub(frameName, -1));
	RaidHealer_Tab_CloseAll();
	
	if (tab <= table.getn(RaidHealer_Tabs)) then
		getglobal(RaidHealer_Tabs[tab]):Show();
		RaidHealer_Tab_SetY(tab, 7);
		
		if ( not UnitInRaid("player") and RaidHealer_Tabs[tab] ~= "RaidHealer_ConfigurationFrame" ) then
			RaidHealer_MainFrame_InfoText:Show();
		else
			RaidHealer_MainFrame_InfoText:Hide();
		end
	end
end

function RaidHealer_Tab_CloseAll()
	for i=1, table.getn(RaidHealer_Tabs), 1 do
		getglobal(RaidHealer_Tabs[i]):Hide();
		RaidHealer_Tab_SetY(i, 10);
	end
end

function RaidHealer_Tab_SetY(tabId, y)
	getglobal("RaidHealer_MainFrameTab"..tabId):SetPoint("TOP", "RaidHealer_MainFrame", "BOTTOM", 0, y);
end

function RaidHealer_AssignmentCheckButton_OnClick(checkBt)
	if (string.find(checkBt:GetName(), "RaidHealer_Healer")) then
		local _, _, prefix, healerId, tankId  = string.find(checkBt:GetName(), "(%a+_%a+)(%d+)_%a+(%d+)");
		local healerName = getglobal(prefix..healerId.."PlayerName"):GetText();
		
		if (checkBt:GetChecked() == 1) then
			RaidHealer_AddHealerToTank(healerName, tonumber(tankId), RaidHealer_CharacterConfig["CURRENT_TANK_CLASS"]);
		else
			RaidHealer_RemoveHealerFromTank(healerName, tonumber(tankId), RaidHealer_CharacterConfig["CURRENT_TANK_CLASS"]);
		end
		-- set color coding
		RaidHealer_SetHealerAssignmentColor(healerName, healerId);
		RaidHealer_DrawUnassignedList();
	elseif (string.find(checkBt:GetName(), "RaidHealer_Buffer")) then
		local _, _, prefix, bufferId, groupId  = string.find(checkBt:GetName(), "(%a+_%a+)(%d+)_%a+(%d+)");
		local bufferName = getglobal(prefix..bufferId.."PlayerName"):GetText();
		local buff = RAIDHEALER_BUFFS[RaidHealer_CharacterConfig["CURRENT_BUFF_TYPE"]]["BUFF"];
		
		if (checkBt:GetChecked() == 1) then
			RaidHealer_AddBufferToGroup(buff, bufferName, tonumber(groupId));
		else
			RaidHealer_RemoveBufferFromGroup(buff, bufferName, tonumber(groupId));
		end
	end
end

function RaidHealer_SetClassIcon(texture, class)
	texture:SetTexture(RAIDHEALER_TEXTURE_PATH);
	texture:SetTexCoord(RaidHealer_GetClassTextureCoords(class));
end

function RaidHealer_GetClassTextureCoords(class)
	return RAID_HEALER_TEXTURE_COORDS[class][1], RAID_HEALER_TEXTURE_COORDS[class][2], RAID_HEALER_TEXTURE_COORDS[class][3], RAID_HEALER_TEXTURE_COORDS[class][4]
end

function RaidHealer_SetCoords(t, A, B, C, D, E, F)
	local det = A*E - B*D;
	local ULx, ULy, LLx, LLy, URx, URy, LRx, LRy;
	
	ULx, ULy = ( B*F - C*E ) / det, ( -(A*F) + C*D ) / det;
	LLx, LLy = ( -B + B*F - C*E ) / det, ( A - A*F + C*D ) / det;
	URx, URy = ( E + B*F - C*E ) / det, ( -D - A*F + C*D ) / det;
	LRx, LRy = ( E - B + B*F - C*E ) / det, ( -D + A -(A*F) + C*D ) / det;
	
	t:SetTexCoord(ULx, ULy, LLx, LLy, URx, URy, LRx, LRy);
end

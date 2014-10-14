--[[
	ImmersionRP Alpha 4 infobox handler.
	Purpose: Infobox functions.
	Author: Seagale.
	Last update: March 9th, 2007.
	
	NOTE: You may change values to customize your infobox, if you wish,
		  just make sure you know what you're doing.
		   
]]

ImmersionRPInfoboxHandler = {
	InfoboxPage = "",
	InfoboxPlayer = "",
	InfoboxChange = true,
	
	InfoboxMode = 1, -- 0 = normal, with description box. 1 = compact, no description.
	Reanchored = false, 
	
	LastUpdate = 0,
	UpdateInterval = 10
};

function ImmersionRPInfoboxHandler.SetPlayer(player)
	ImmersionRPInfobox:Hide();
	ImmersionRPInfoboxHandler.InfoboxPlayer = player;

	ImmersionRPInfobox:SetWidth(250);
	
	ImmersionRPInfoboxUnitName:SetFont(ImmersionRPInfoboxUnitName:GetFont(), 20);
	ImmersionRPInfoboxUnitName:SetText(ImmersionRPDatabaseHandler.GetPlayerName(player));
	ImmersionRPInfoboxUnitName:SetTextColor(IRP_INFOBOX_PLAYERNAME_COLORR, IRP_INFOBOX_PLAYERNAME_COLORG, IRP_INFOBOX_PLAYERNAME_COLORB);
	local _ , _ , _ , xoffset = ImmersionRPInfoboxUnitName:GetPoint();
	if (ImmersionRPInfoboxUnitName:GetStringWidth() > ImmersionRPInfobox:GetWidth() - xoffset - ImmersionRPInfoboxCloseButton:GetWidth()) then
		ImmersionRPInfobox:SetWidth(ImmersionRPInfoboxUnitName:GetStringWidth() + xoffset + ImmersionRPInfoboxCloseButton:GetWidth());
	end
	
	ImmersionRPInfoboxUnitTitle:SetWidth(ImmersionRPInfobox:GetWidth() - xoffset - 12);
	ImmersionRPInfoboxUnitTitle:SetText(ImmersionRPDatabaseHandler.GetPlayerTitle(player) or "");
	ImmersionRPInfoboxUnitTitle:SetTextColor(IRP_INFOBOX_TITLE_COLORR, IRP_INFOBOX_TITLE_COLORG, IRP_INFOBOX_TITLE_COLORB);
	
	ImmersionRPInfoboxDescPeek:SetWidth(ImmersionRPInfobox:GetWidth() - xoffset - 12);
	ImmersionRPInfoboxDescPeek:SetTextColor(IRP_INFOBOX_TITLE_COLORR, IRP_INFOBOX_TITLE_COLORG, IRP_INFOBOX_TITLE_COLORB);
	
	ImmersionRPInfoboxHandler.ModeUpdate();
	
	if (ImmersionRPDatabaseHandler.GetPlayerName(player) ~= player or ImmersionRPDatabaseHandler.GetDescription(player) ~= "" or ImmersionRPDatabaseHandler.GetPlayerTitle(player) ~= nil) then
		ImmersionRPInfobox:Show();
		if (ImmersionRPInfobox:IsUserPlaced() and not ImmersionRPInfoboxHandler.Reanchored) then
			ImmersionRPInfoboxHandler.Reanchor();
			ImmersionRPInfoboxHandler.Reanchored = true;
		end
		if (ImmersionRPDatabaseHandler.GetDescription(player) == "") then
			ImmersionRPInfoboxHandler.SetPage("notes");
			ImmersionRPChatHandler.SendMessage("<DP>" .. player);
		else
			ImmersionRPInfoboxHandler.SetPage("description");
		end
		return true;
	else
		ImmersionRPInfobox:Hide();
		return false;
	end
end

function ImmersionRPInfoboxHandler.Update()
	if (ImmersionRPInfoboxHandler.InfoboxPlayer ~= "" and ImmersionRPInfoboxHandler.InfoboxPlayer ~= "" and ImmersionRPInfobox:IsVisible()) then
		ImmersionRPInfobox:SetWidth(IRP_INFOBOX_NORMALWIDTH);
		
		ImmersionRPInfoboxUnitName:SetFont(ImmersionRPInfoboxUnitName:GetFont(), 20);
		ImmersionRPInfoboxUnitName:SetText(ImmersionRPDatabaseHandler.GetPlayerName(ImmersionRPInfoboxHandler.InfoboxPlayer));
		ImmersionRPInfoboxUnitName:SetTextColor(IRP_INFOBOX_PLAYERNAME_COLORR, IRP_INFOBOX_PLAYERNAME_COLORG, IRP_INFOBOX_PLAYERNAME_COLORB);
		local _ , _ , _ , xoffset = ImmersionRPInfoboxUnitName:GetPoint();
		if (ImmersionRPInfoboxUnitName:GetStringWidth() > IRP_INFOBOX_NORMALWIDTH - xoffset - ImmersionRPInfoboxCloseButton:GetWidth()) then
			ImmersionRPInfobox:SetWidth(ImmersionRPInfoboxUnitName:GetStringWidth() + xoffset + ImmersionRPInfoboxCloseButton:GetWidth());			
		end
		
		ImmersionRPInfoboxUnitTitle:SetWidth(ImmersionRPInfobox:GetWidth() - xoffset - 12);
		ImmersionRPInfoboxUnitTitle:SetText(ImmersionRPDatabaseHandler.GetPlayerTitle(ImmersionRPInfoboxHandler.InfoboxPlayer) or "");
		ImmersionRPInfoboxUnitTitle:SetTextColor(IRP_INFOBOX_TITLE_COLORR, IRP_INFOBOX_TITLE_COLORG, IRP_INFOBOX_TITLE_COLORB);
		
		ImmersionRPInfoboxDescPeek:SetWidth(ImmersionRPInfobox:GetWidth() - xoffset - 12);
		ImmersionRPInfoboxDescPeek:SetTextColor(IRP_INFOBOX_TITLE_COLORR, IRP_INFOBOX_TITLE_COLORG, IRP_INFOBOX_TITLE_COLORB);
			
		ImmersionRPInfoboxHandler.SetPage(ImmersionRPInfoboxHandler.InfoboxPage, false);
	end
end

function ImmersionRPInfoboxHandler.SetPage(page, scrollup)
	if (scrollup == nil) then scrollup = true; end
	if (page == "description") then
		ImmersionRPInfoboxHandler.SaveNotes();
		ImmersionRPInfoboxHandler.InfoboxPage = "description";
		ImmersionRPInfoboxLongTextTitle:SetText(IRP_STRING_CHARACTER_DESCRIPTION);
		ImmersionRPInfoboxScrollFrameLongText:SetText(ImmersionRPDatabaseHandler.GetDescription(ImmersionRPInfoboxHandler.InfoboxPlayer));
	elseif (page == "notes" and ImmersionRPInfoboxHandler.InfoboxPage ~= "notes") then
		ImmersionRPInfoboxHandler.InfoboxPage = "notes";
		ImmersionRPInfoboxLongTextTitle:SetText(IRP_STRING_CHARACTER_NOTES);
		ImmersionRPInfoboxScrollFrameLongText:SetText(ImmersionRPDatabaseHandler.GetNotes(ImmersionRPInfoboxHandler.InfoboxPlayer));
	end
	ImmersionRPInfoboxLongTextTitle:SetTextColor(IRP_INFOBOX_DESCRIPTION_COLORR, IRP_INFOBOX_DESCRIPTION_COLORG, IRP_INFOBOX_DESCRIPTION_COLORB);
	if (scrollup) then ImmersionRPInfoboxScrollFrameScrollBar:SetValue(0); end
end

function ImmersionRPInfoboxHandler.SaveNotes()
	if (ImmersionRPInfoboxHandler.InfoboxPage == "notes") then
		ImmersionRPDatabaseHandler.SetFlag(ImmersionRPInfoboxHandler.InfoboxPlayer, "NOTES", ImmersionRPInfoboxScrollFrameLongText:GetText());
	end
end

function ImmersionRPInfoboxHandler.Clear()
	ImmersionRPInfoboxHandler.InfoboxChange = true;
	ImmersionRPInfoboxHandler.InfoboxPage = "";
	ImmersionRPInfoboxHandler.InfoboxPlayer = "";
end

function ImmersionRPInfoboxHandler.ToggleMode()
	ImmersionRPInfoboxHandler.InfoboxMode = (0 - ImmersionRPInfoboxHandler.InfoboxMode) + 1;
	ImmersionRPInfoboxHandler.ModeUpdate();
end

function ImmersionRPInfoboxHandler.ModeUpdate()
	if (ImmersionRPInfoboxHandler.InfoboxMode == 0) then -- normal mode
		ImmersionRPInfobox:SetHeight(IRP_INFOBOX_NORMALHEIGHT);
		ImmersionRPInfoboxDescPeek:Hide();
		ImmersionRPInfoboxLongTextTitle:Show();
		ImmersionRPInfoboxScrollFrame:Show();
		ImmersionRPInfoboxNextButton:Show();
		ImmersionRPInfoboxPrevButton:Show();
		GameTooltip:Hide()
	elseif (ImmersionRPInfoboxHandler.InfoboxMode == 1) then -- compact mode
		local _ , _ , _ , _ , nameyoffset = ImmersionRPInfoboxUnitName:GetPoint();
		local _ , _ , _ , _ , titleyoffset = ImmersionRPInfoboxUnitTitle:GetPoint();
		local _ , _ , _ , _ , peekyoffset = ImmersionRPInfoboxDescPeek:GetPoint();
		ImmersionRPInfobox:SetHeight((ImmersionRPInfobox:GetTop() - ImmersionRPInfoboxUnitName:GetBottom() + ImmersionRPInfoboxUnitTitle:GetHeight() + ImmersionRPInfoboxDescPeek:GetHeight() - peekyoffset - titleyoffset) - nameyoffset );
		--ImmersionRPInfoboxHandler.SetPage(ImmersionRPInfoboxHandler.InfoboxPage, false);
		ImmersionRPInfoboxDescPeek:Show();
		ImmersionRPInfoboxLongTextTitle:Hide();
		ImmersionRPInfoboxScrollFrame:Hide();
		ImmersionRPInfoboxNextButton:Hide();
		ImmersionRPInfoboxPrevButton:Hide();
	end
end

function ImmersionRPInfoboxHandler.Reanchor()
	local top, height, left, width = ImmersionRPInfobox:GetTop(), ImmersionRPInfobox:GetHeight(), ImmersionRPInfobox:GetLeft(), ImmersionRPInfobox:GetWidth();
	if (ImmersionRPInfobox:GetTop() <= GetScreenHeight() / 2) then -- bottom half
		if (ImmersionRPInfobox:GetLeft() <= GetScreenWidth() / 2) then -- bottom half, left side
			ImmersionRPInfobox:ClearAllPoints();
			ImmersionRPInfobox:SetPoint("BOTTOMLEFT",ImmersionRPInfobox:GetParent(), "BOTTOMLEFT", left, top - height);
			ImmersionRPInfobox:SetUserPlaced(true);
		else -- bottom half, right side
			ImmersionRPInfobox:ClearAllPoints();
			ImmersionRPInfobox:SetPoint("BOTTOMRIGHT",ImmersionRPInfobox:GetParent(), "BOTTOMLEFT", left + width, top - height);
			ImmersionRPInfobox:SetUserPlaced(true);
		end
	else -- top half
		if (ImmersionRPInfobox:GetLeft() > GetScreenWidth() / 2) then -- top half, right side
			ImmersionRPInfobox:ClearAllPoints();
			ImmersionRPInfobox:SetPoint("TOPRIGHT",ImmersionRPInfobox:GetParent(), "BOTTOMLEFT", left + width, top);
		end
	end
	ImmersionRPInfobox:SetUserPlaced(1);
end
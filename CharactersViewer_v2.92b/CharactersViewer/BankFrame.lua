--[[
BANK_CONTAINER = -1;
NUM_BAG_SLOTS = 4;
NUM_BANKGENERIC_SLOTS = 24;
NUM_BANKBAGSLOTS = 6;
]]--

CharactersViewer.BankFrame = {}

function CharactersViewer.BankFrame.Toggle(toggle)
	if ( toggle == nil) then
		CharactersViewerConfig.SelfBank = false;
		if ( CharactersViewerConfig.ShowBank == nil or CharactersViewerConfig.ShowBank == false) then
			CharactersViewerConfig.ShowBank  = true;
		else
			CharactersViewerConfig.ShowBank  = false;
		end
	end
	if ( toggle == -1 and CVBankFrame:IsVisible() == 1 ) then
		CharactersViewer.BankFrame.Hide();
	elseif ( toggle == -1 ) then
		CharactersViewer.BankFrame.Show();
		CharactersViewerConfig.SelfBank = true;		
	elseif ( CharactersViewerConfig.ShowBank  == true or (CVBankFrame:IsVisible() == 1 and CharactersViewerConfig.SelfBank  == true) ) then
		CharactersViewer.BankFrame.Show();	
	else
		CharactersViewer.BankFrame.Hide();	
	end
end

function CharactersViewer.BankFrame.Show()
	-- Rescan modified thing
	if (rpgoCP_EventHandler ~= nil ) then
		rpgoCP_EventHandler('RPGOCP_SCAN');
	end
	
	CharactersViewer.SetScale();
	CVBankFrame:Show();
	if ( CVBankFrame.isLocked == true ) then
		CharactersViewer.BankFrame.Relocate();
	end
	--redraw bag;
	CharactersViewer.BankFrame.DrawMainBag();
	CharactersViewer.ContainerFrame.ToggleBankBag(CharactersViewerConfig.ShowBankBag);
	CharactersViewer.BankFrame.SetPortrait();
	CharactersViewer.BankFrame.SetMoney();
	CharactersViewer.BankFrame.SetTimestamp();
	
	if ( CVCharacterFrame:IsVisible() ~= 1 ) then
		CharactersViewer.xml.DropDown_SetText();
	end
	
end

function CharactersViewer.BankFrame.Hide()
	CVBankFrame:Hide();
	CharactersViewerConfig.SelfBank = false;
end

function CharactersViewer.BankFrame.DrawMainBag()
	local index, slotname, item;
	for index = 1, 24 do
		slotname = "CVBankFrameItem" .. index;	
		item = CharactersViewer.Api.getContainerItem  ( 19,  index);
		SetItemButtonCount(getglobal(slotname), 0 );
		if ( item ~= nil and item["Texture"] ~= nil) then
			getglobal(slotname .. "IconTexture"):SetTexture(item["Texture"]);
			if ( item["Quantity"] ~= nil) then
				SetItemButtonCount(getglobal(slotname), item["Quantity"] );
			end
		else
			SetItemButtonTexture(getglobal(slotname),0);
		end
	end
	
	for index = 1, 6 do
		getglobal("CVBankFrameBag" .. index .. "IconTexture"):SetTexture(CharactersViewer.Api.getContainerTexture(index+4));
	end
end


function CharactersViewer.BankFrame.ToggleBag_OnClick()
	local forceOpen = nil;
	CharactersViewer.ContainerFrame.ToggleBankBag(forceOpen);
end

function CharactersViewer.BankFrame.ToggleBag_OnEnter()
	local tooltip = getglobal("GameTooltip");
	local item = CharactersViewer.Api.getContainer(this:GetID());
	text = EMPTY;
	ShowUIPanel(tooltip);
	tooltip:SetOwner(this, "ANCHOR_RIGHT");
	if( item ~= nil and item["itemLink"] ) then
		if( GetItemInfo("item:" .. item["itemLink"]) ) then
			tooltip:SetHyperlink("item:" .. item["itemLink"]);
		else
		tooltip:SetText(item["itemTooltip"]);
		end
	else
		tooltip:SetText(text);
	end
	tooltip:AddLine(CharactersViewer.index .. " " .. INVENTORY_TOOLTIP);
	tooltip:Show();
end

function CharactersViewer.BankFrame.OnLoad()
	UIPanelWindows["CVBankFrame"] = { area = "left", pushable = 6, whileDead = 1};
	tinsert(UISpecialFrames,"CVBankFrame");
	CVBankFrameTitleText:SetText("CharactersViewer " .. CharactersViewer.version.text .. " by Flisher");
end

function CloseBankBagFrames() 
	for i=NUM_BAG_SLOTS+1, (NUM_BAG_SLOTS + NUM_BANKBAGSLOTS), 1 do
		CloseBag(i);
	end
end


function UpdateBagButtonHighlight(id) 
	local texture = getglobal("BankFrameBag"..(id - NUM_BAG_SLOTS).."HighlightFrameTexture");
	if ( not texture ) then
		return;
	end

	for i=1, NUM_CONTAINER_FRAMES, 1 do
		local frame = getglobal("ContainerFrame"..i);
		if ( ( frame:GetID() == id ) and frame:IsVisible() ) then
			texture:Show();
			return;
		end
	end
	texture:Hide();
end

function CharactersViewer.BankFrame.SetPortrait()
	local race = CharactersViewer.Api.GetParam("raceen");
	local sex = CharactersViewer.Api.GetParam("sexid");
	
	if (race ~= nil  and sex ~= nil ) then
		if(race == "Night Elf") then
			race = "NightElf";
		end
		if( sex == 0) then
			sex = "Male";
		else
			sex = "Female";
		end
		temp = "Interface\\CharacterFrame\\TemporaryPortrait-" .. sex .. "-" .. race;
   else
		temp = "Interface\\CharacterFrame\\TempPortrait";
   end
	CVBankPortraitTexture:SetTexture(temp);
end;

function CharactersViewer.BankFrame.SetMoney()
	MoneyFrame_Update("CVBankFrameMoneyFrame1", CharactersViewer.Api.GetParam("alliancemoney"));
	MoneyFrame_Update("CVBankFrameMoneyFrame2", CharactersViewer.Api.GetParam("hordemoney"));
	MoneyFrame_Update("CVBankFrameMoneyFrame3", CharactersViewer.Api.GetParam("servermoney"));
end

function CharactersViewer.BankFrame.SetTimestamp()
	if ( CharactersViewer.Api.GetParam("bankexist") == true ) then
		if (CharactersViewer.Api.GetParam("banktimestamp") ~= nil ) then
			CVBankFrameTimestamp:SetText(CharactersViewer.Api.GetParam("banktimestamp"));
		else
			CVBankFrameTimestamp:SetText("");
		end
	else
		CVBankFrameTimestamp:SetText(CHARACTERSVIEWER_BANK_NOTSCANNED);
	end
end

function CharactersViewer_BankFrame_isMovable()
	if ( CharactersViewer.Api.GetConfig("MovableBankFrame") == true ) then
		CVBankFrame.isLocked = false;
		CVBankFrame:SetUserPlaced()
	else
		CVBankFrame.isLocked = true;
		CVBankFrame:SetUserPlaced(0);
		CharactersViewer.BankFrame.Relocate();
	end
end;

function CharactersViewer.BankFrame.Relocate()
	CVBankFrame:SetPoint("TOPLEFT", "CVCharacterFrame", "BOTTOMLEFT", 0, 45);
end

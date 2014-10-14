
function ToggleBag(id)
	if ( IsOptionFrameOpen() ) then
		return;
	end

	local size;
	if(id == KEYRING_CONTAINER) then
		size = GetKeyRingSize();
	else
		size = GetContainerNumSlots(id);
	end
	
	if ( size > 0 ) then
		local frame;
		if(id == KEYRING_CONTAINER) then
			frame = getglobal("ContainerFrame12");
		else
			frame = getglobal("ContainerFrame"..(id+1));
		end
		
		if ( frame:IsVisible()) then
			frame:Hide();
		else
			if ( CanOpenPanels() ) then
				ContainerFrame_GenerateFrame(frame, size, id);
			else
				if ( UnitIsDead("player") ) then
					NotWhileDeadError();
				end
			end
		end
	end
end

function ToggleKeyRing()
	ToggleBag(KEYRING_CONTAINER);
end

function ToggleBackpack()
	if ( IsBagOpen(0) ) then
		local frame = ContainerFrame1;
		if ( frame:IsVisible() ) then
			frame:Hide();
		end
	else
		ToggleBag(0);
	end
end

function ContainerFrame_OnHide()
	if ( this:GetID() == 0 ) then
		MainMenuBarBackpackButton:SetChecked(0);
	else
		local bagButton = getglobal("CharacterBag"..(this:GetID() - 1).."Slot");
		if ( bagButton ) then
			bagButton:SetChecked(0);
		else
			-- If its a bank bag then update its highlight
			UpdateBagButtonHighlight(this:GetID()); 
		end
	end
	PlaySound("igBackPackClose");
end

function ContainerFrame_OnShow()
	if ( this:GetID() == 0 ) then
		MainMenuBarBackpackButton:SetChecked(1);
	elseif ( this:GetID() <= NUM_BAG_SLOTS ) then 
		local button = getglobal("CharacterBag"..(this:GetID() - 1).."Slot");
		if ( button ) then
			button:SetChecked(1);
		end
	end
end

function OpenBag(id)
	if ( not CanOpenPanels() ) then
		if ( UnitIsDead("player") ) then
			NotWhileDeadError();
		end
		return;
	end
	local size = GetContainerNumSlots(id);
	if ( size > 0 ) then
		local frame = getglobal("ContainerFrame"..id);
		if (not frame:IsVisible()) then
			ContainerFrame_GenerateFrame(ContainerFrame_GetOpenFrame(), size, id);
		end
	end
end

function CloseBag(id)
	local containerFrame = getglobal("ContainerFrame"..id);
	if (containerFrame:IsVisible()) then
		containerFrame:Hide();
	end
end

function IsBagOpen(id)
	for i=1, NUM_CONTAINER_FRAMES, 1 do
		local containerFrame = getglobal("ContainerFrame"..i);
		if ( containerFrame:IsShown() and (containerFrame:GetID() == id) ) then
			return i;
		end
	end
	return nil;
end

function OpenBackpack()
	if ( not CanOpenPanels() ) then
		if ( UnitIsDead("player") ) then
			NotWhileDeadError();
		end
		return;
	end
	local containerFrame = ContainerFrame1;
	if (not containerFrame:IsVisible()) then
		ToggleBackpack();
	end
end

function CloseBackpack()
	local containerFrame = ContainerFrame1;
	if (containerFrame:IsVisible()) then
		containerFrame:Hide();
	end
end

function ContainerFrame_GenerateFrame(frame, size, id)
	frame.size = size;
	local name = frame:GetName();
	local bgTextureTop = getglobal(name.."BackgroundTop");
	local bgTextureMiddle = getglobal(name.."BackgroundMiddle1");
	local bgTextureBottom = getglobal(name.."BackgroundBottom");
	local columns = NUM_CONTAINER_COLUMNS;
	local rows = ceil(size / columns);
	-- if size = 0 then its the backpack
	if ( id == 0 ) then
		getglobal(name.."MoneyFrame"):Show();
		-- Set Backpack texture
		bgTextureTop:SetTexture("Interface\\ContainerFrame\\UI-BackpackBackground");
		bgTextureTop:SetHeight(256);
		bgTextureTop:SetTexCoord(0, 1, 0, 1);
		
		-- Hide unused textures
		for i=1, MAX_BG_TEXTURES do
			getglobal(name.."BackgroundMiddle"..i):Hide();
		end
		bgTextureBottom:Hide();
		frame:SetHeight(240);
	else
		-- Not the backpack
		-- Set whether or not its a bank bag
		local bagTextureSuffix = "";
		if ( id > NUM_BAG_FRAMES ) then
			bagTextureSuffix = "-Bank";
		elseif ( id == KEYRING_CONTAINER ) then
			bagTextureSuffix = "-Keyring";
		end
		-- Set textures
		bgTextureTop:SetTexture("Interface\\ContainerFrame\\UI-Bag-Components"..bagTextureSuffix);
		for i=1, MAX_BG_TEXTURES do
			getglobal(name.."BackgroundMiddle"..i):SetTexture("Interface\\ContainerFrame\\UI-Bag-Components"..bagTextureSuffix);
			getglobal(name.."BackgroundMiddle"..i):Hide();
		end
		bgTextureBottom:SetTexture("Interface\\ContainerFrame\\UI-Bag-Components"..bagTextureSuffix);
		-- Hide the moneyframe since its not the backpack
		getglobal(name.."MoneyFrame"):Hide();	
		
		local bgTextureCount, height;
		local rowHeight = 41;
		-- Subtract one, since the top texture contains one row already
		local remainingRows = rows-1;

		-- See if the bag needs the texture with two slots at the top
		local isPlusTwoBag;
		if ( mod(size,columns) == 2 ) then
			isPlusTwoBag = 1;
		end

		-- Bag background display stuff
		if ( isPlusTwoBag ) then
			bgTextureTop:SetTexCoord(0, 1, 0.189453125, 0.330078125);
			bgTextureTop:SetHeight(72);
		else
			if ( rows == 1 ) then
				-- If only one row chop off the bottom of the texture
				bgTextureTop:SetTexCoord(0, 1, 0.00390625, 0.16796875);
				bgTextureTop:SetHeight(86);
			else
				bgTextureTop:SetTexCoord(0, 1, 0.00390625, 0.18359375);
				bgTextureTop:SetHeight(94);
			end
		end
		-- Calculate the number of background textures we're going to need
		bgTextureCount = ceil(remainingRows/ROWS_IN_BG_TEXTURE);
		
		local middleBgHeight = 0;
		-- If one row only special case
		if ( rows == 1 ) then
			bgTextureBottom:SetPoint("TOP", bgTextureMiddle:GetName(), "TOP", 0, 0);
			bgTextureBottom:Show();
			-- Hide middle bg textures
			for i=1, MAX_BG_TEXTURES do
				getglobal(name.."BackgroundMiddle"..i):Hide();
			end
		else
			-- Try to cycle all the middle bg textures
			local firstRowPixelOffset = 9;
			local firstRowTexCoordOffset = 0.353515625;
			for i=1, bgTextureCount do
				bgTextureMiddle = getglobal(name.."BackgroundMiddle"..i);
				if ( remainingRows > ROWS_IN_BG_TEXTURE ) then
					-- If more rows left to draw than can fit in a texture then draw the max possible
					height = ( ROWS_IN_BG_TEXTURE*rowHeight ) + firstRowTexCoordOffset;
					bgTextureMiddle:SetHeight(height);
					bgTextureMiddle:SetTexCoord(0, 1, firstRowTexCoordOffset, ( height/BG_TEXTURE_HEIGHT + firstRowTexCoordOffset) );
					bgTextureMiddle:Show();
					remainingRows = remainingRows - ROWS_IN_BG_TEXTURE;
					middleBgHeight = middleBgHeight + height;
				else
					-- If not its a huge bag
					bgTextureMiddle:Show();
					height = remainingRows*rowHeight-firstRowPixelOffset;
					bgTextureMiddle:SetHeight(height);
					bgTextureMiddle:SetTexCoord(0, 1, firstRowTexCoordOffset, ( height/BG_TEXTURE_HEIGHT + firstRowTexCoordOffset) );
					middleBgHeight = middleBgHeight + height;
				end
			end
			-- Position bottom texture
			bgTextureBottom:SetPoint("TOP", bgTextureMiddle:GetName(), "BOTTOM", 0, 0);
			bgTextureBottom:Show();
		end
		-- Set the frame height
		frame:SetHeight(bgTextureTop:GetHeight()+bgTextureBottom:GetHeight()+middleBgHeight);	
	end
	frame:SetWidth(CONTAINER_WIDTH);
	frame:SetID(id);
	getglobal(frame:GetName().."PortraitButton"):SetID(id);
	
	--Special case code for keyrings
	if ( id == KEYRING_CONTAINER ) then
		getglobal(frame:GetName().."Name"):SetText(KEYRING);
		SetPortraitToTexture(frame:GetName().."Portrait", "Interface\\ContainerFrame\\KeyRing-Bag-Icon");
	else
		getglobal(frame:GetName().."Name"):SetText(GetBagName(id));
		SetBagPortaitTexture(getglobal(frame:GetName().."Portrait"), id);
	end
	
	for j=1, size, 1 do
		local index = size - j + 1;
		local itemButton =getglobal(name.."Item"..j);
		itemButton:SetID(index);
		-- Set first button
		if ( j == 1 ) then
			-- Anchor the first item differently if its the backpack frame
			if ( id == 0 ) then
				itemButton:SetPoint("BOTTOMRIGHT", name, "BOTTOMRIGHT", -12, 30);
			else
				itemButton:SetPoint("BOTTOMRIGHT", name, "BOTTOMRIGHT", -12, 9);
			end
			
		else
			if ( mod((j-1), columns) == 0 ) then
				itemButton:SetPoint("BOTTOMRIGHT", name.."Item"..(j - columns), "TOPRIGHT", 0, 4);	
			else
				itemButton:SetPoint("BOTTOMRIGHT", name.."Item"..(j - 1), "BOTTOMLEFT", -5, 0);	
			end
		end

		local texture, itemCount, locked, quality, readable = GetContainerItemInfo(id, index);
		SetItemButtonTexture(itemButton, texture);
		SetItemButtonCount(itemButton, itemCount);
		SetItemButtonDesaturated(itemButton, locked, 0.5, 0.5, 0.5);

		if ( texture ) then
			ContainerFrame_UpdateCooldown(id, itemButton);
			itemButton.hasItem = 1;
		else
			getglobal(name.."Item"..j.."Cooldown"):Hide();
			itemButton.hasItem = nil;
		end
		
		itemButton.readable = readable;
		itemButton:Show();
	end
	for j=size + 1, MAX_CONTAINER_ITEMS, 1 do
		getglobal(name.."Item"..j):Hide();
	end
	
	-- Add the bag to the baglist
	ContainerFrame1.bags[ContainerFrame1.bagsShown + 1] = frame:GetName();
	updateContainerFrameAnchors();
	frame:Show();
end

function updateContainerFrameAnchors()
end

function OpenAllBags(forceOpen)
	local containerFrame;
	local bagButton;
	local openbagscount = 0;

	for i=0, NUM_BAG_FRAMES do
		containerFrame = getglobal("ContainerFrame"..i + 1);
		
		if ( containerFrame:IsVisible() ) then
			containerFrame:Hide();
			openbagscount = openbagscount + 1;
		elseif (GetContainerNumSlots(i) == 0) then
			openbagscount = openbagscount + 1;
		end
	end
	if (openbagscount == (NUM_BAG_FRAMES+1) and not forceOpen) then
		return;
	end
	ToggleBackpack();
	ToggleBag(1);
	ToggleBag(2);
	ToggleBag(3);
	ToggleBag(4);
end


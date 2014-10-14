CharactersViewer.ContainerFrame = {};				

function CharactersViewer.ContainerFrame.OnLoad()		-- Reviewed by Flisher 2006-07-25
end

function CharactersViewer.ContainerFrame.OnHide()
end

function CharactersViewer.ContainerFrame.OnShow()
end

function CharactersViewer.ContainerFrame.ToggleSingleBag(id, force)
	-- Pick the desired container
	local frameid = CharactersViewer.ContainerFrame.Bag2Frame(id);
	
	local frame = getglobal("CVContainerFrame" .. frameid);
	if ( (force == nil and frame:IsShown() == 1) or ( force == false ) )then
		frame:Hide();		
	elseif ( (frame:IsShown() == nil) or ( force == true ) ) then 
		frame:Show();
	end	
	getglobal("CVContainerFrame" .. frameid .. "CloseButton"):SetID(tostring(id));
	if ( frame:IsShown() == 1)  then
		if ( frameid == 1 ) then
			frame:SetPoint("TOPLEFT", "CVCharacterFrame", "TOPRIGHT", 0, 0 );
		elseif (frameid == 7 ) then
			frame:SetPoint("TOPLEFT", "CVBankFrame", "TOPRIGHT", 0, 0 );
		--elseif ( frameid >= 2 and frameid <= 6 ) then
		else
			if ( mod(id, 2) == 1) then
				local frame2  = getglobal ("CVContainerFrame" .. frameid-2);
				frame:SetPoint("TOPLEFT", frame2, "TOPRIGHT");
			else
				local frame2  = getglobal ("CVContainerFrame" .. frameid-1);
				frame:SetPoint("TOPLEFT", frame2, "BOTTOMLEFT" );
			end
		end		
		
		CharactersViewer.ContainerFrame.CharacterBag.Fill(id, frame, CharactersViewer.ContainerFrame.Bag2Frame(id, true) );
	end
end

function CharactersViewer.ContainerFrame.Bag2Frame(id , request)
	local frameid;
	if (id == -2) then 			-- Keyring
		frameid = 2
		option = "keyring";
	elseif (id == 0) then		-- Backpack
		frameid = 1;
		
	elseif (id == 1) then		-- Character Bag 1	
		frameid = 3;
		option = "bag";
	elseif (id == 2) then		-- Character Bag 2
		frameid = 4;
		option = "bag";
	elseif (id == 3) then		-- Character Bag 3	
		frameid = 5;
		option = "bag";
	elseif (id == 4) then		-- Character Bag 4
		frameid = 6;
		option = "bag";

	elseif (id == 5) then		-- Bank Bag 1
		frameid = 7;
		option = "bankbag";
	elseif (id == 6) then		-- Bank Bag 2
		frameid = 8;
		option = "bankbag";
	elseif (id == 7) then		-- Bank Bag 3
		frameid = 9;
		option = "bankbag";
	elseif (id == 8) then		-- Bank Bag 4
		frameid = 10;
		option = "bankbag";
	elseif (id == 9) then		-- Bank Bag 5
		frameid = 11;
		option = "bankbag";
	elseif (id == 10) then		-- Bank Bag 6
		frameid = 12;
		option = "bankbag";
	end
	
	if (request == nil) then
		return frameid;
	else
		return option;
	end
end

CharactersViewer.ContainerFrame.CharacterBag = {};

function CharactersViewer.ContainerFrame.ToggleBag(forceOpen)
	if ( forceOpen == nil) then
		if ( CharactersViewerConfig.ShowBag == nil ) then
			CharactersViewerConfig.ShowBag = false
		end
		if (CharactersViewerConfig.ShowBag == false) then
			forceOpen = true;
			CharactersViewerConfig.ShowBag  = true;
		else
			forceOpen = false;
			CharactersViewerConfig.ShowBag  = false;
		end
	end
	CharactersViewer.ContainerFrame.ToggleSingleBag(-2, forceOpen);		--KeyRing
	CharactersViewer.ContainerFrame.ToggleSingleBag(0, forceOpen);		--KeyRing
	CharactersViewer.ContainerFrame.ToggleSingleBag(1, forceOpen);		--KeyRing
	CharactersViewer.ContainerFrame.ToggleSingleBag(2, forceOpen);		--KeyRing
	CharactersViewer.ContainerFrame.ToggleSingleBag(3, forceOpen);		--KeyRing
	CharactersViewer.ContainerFrame.ToggleSingleBag(4, forceOpen);		--KeyRing
end

function CharactersViewer.ContainerFrame.ToggleBankBag(forceOpen)
	if ( forceOpen == nil) then
		if ( CharactersViewerConfig.ShowBankBag == nil ) then
			CharactersViewerConfig.ShowBankBag = false
		end
		if (CharactersViewerConfig.ShowBankBag == false) then
			forceOpen = true;
			CharactersViewerConfig.ShowBankBag  = true;
		else
			forceOpen = false;
			CharactersViewerConfig.ShowBankBag  = false;
		end
	end
	CharactersViewer.ContainerFrame.ToggleSingleBag(5, forceOpen);		--KeyRing
	CharactersViewer.ContainerFrame.ToggleSingleBag(6, forceOpen);		--KeyRing
	CharactersViewer.ContainerFrame.ToggleSingleBag(7, forceOpen);		--KeyRing
	CharactersViewer.ContainerFrame.ToggleSingleBag(8, forceOpen);		--KeyRing
	CharactersViewer.ContainerFrame.ToggleSingleBag(9, forceOpen);		--KeyRing
	CharactersViewer.ContainerFrame.ToggleSingleBag(10, forceOpen);		--KeyRing
end

function CharactersViewer.ContainerFrame.CharacterBag.Fill(id, frame, option)
	local theBag, name, bagTextureSuffix;
	if( option == "bag" ) then
	  name = frame:GetName();
	  bagTextureSuffix = "";

	elseif( option == "bankbag") then
	  name = frame:GetName();
	  bagTextureSuffix = "-Bank";
	elseif ( option == "keyring" ) then
	  name = frame:GetName();
	  bagTextureSuffix = "-Keyring";
	end
	frame.size = CharactersViewer.Api.getContainerSize(id);
	frame:Hide();
	
	local bgTextureTop = getglobal(name.."BackgroundTop");
	local bgTextureMiddle = getglobal(name.."BackgroundMiddle1");
	local bgTextureBottom = getglobal(name.."BackgroundBottom");
	local columns = NUM_CONTAINER_COLUMNS;
	local rows = ceil(frame.size / columns);
	-- if size = 0 then its the backpack
	if ( id == 0 ) then
		MoneyFrame_Update(name.."MoneyFrame", CharactersViewer.Api.GetParam("money"));
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
			
		-- Set textures
		bgTextureTop:SetTexture("Interface\\ContainerFrame\\UI-Bag-Components"..bagTextureSuffix);
		for i=1, MAX_BG_TEXTURES do
			getglobal(name.."BackgroundMiddle"..i):SetTexture("Interface\\ContainerFrame\\UI-Bag-Components"..bagTextureSuffix);
			getglobal(name.."BackgroundMiddle"..i):Hide();
		end
		bgTextureBottom:SetTexture("Interface\\ContainerFrame\\UI-Bag-Components"..bagTextureSuffix);
		-- Hide the moneyframe since its not the backpack
		getglobal(name.."MoneyFrame"):Hide();			-- not used in CV

		local bgTextureCount, height;
		local rowHeight = 41;
		-- Subtract one, since the top texture contains one row already
		local remainingRows = rows-1;

		-- See if the bag needs the texture with two slots at the top
		local isPlusTwoBag;
		if ( mod(frame.size,columns) == 2 ) then
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
	 
	--Special case code for keyrings
	if ( id == KEYRING_CONTAINER ) then
		getglobal(frame:GetName().."Name"):SetText(KEYRING);
		SetPortraitToTexture(frame:GetName().."Portrait", "Interface\\ContainerFrame\\KeyRing-Bag-Icon");
	else
		getglobal(frame:GetName().."Name"):SetText(CharactersViewer.Api.getContainerName(id));
		--SetPortraitToTexture(frame:GetName().."Portrait", "CharactersViewer.Api.getContainerTexture(id)");
		getglobal(name.."Portrait"):SetTexture(CharactersViewer.Api.getContainerTexture(id));
	end

	for j=1, frame.size, 1 do
		local index = frame.size - j + 1;
		--item = theBag[index];
		item = nil;
		itemButton = getglobal(name.."Item"..j);
		-- Set first button
		if( j == 1 ) then
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
	end

	 for j = 1, frame.size do
		  index = frame.size - (j - 1);
		  getglobal(name.."Item"..j):SetID(100 * id + index + 100 );
		  item = CharactersViewer.Api.getContainerItem(id, index);
		  -- todoproblem with the item stuff.
		  itemButton = getglobal(name.."Item"..j);
		  if( item ) then
				SetItemButtonTexture(itemButton, item.Texture);
				SetItemButtonCount(itemButton, item.Quantity);
		  else
				SetItemButtonTexture(itemButton,"");
				SetItemButtonCount(itemButton, nil);
		  end
		  itemButton:Show();
	 end
	for j=frame.size + 1, 36, 1 do
		getglobal(name.."Item"..j):Hide();
	end
	
	if ( frame.size > 0 ) then
		frame:Show();
	end
	 --PlaySound("igBackPackOpen");
end

function CharactersViewer.ContainerFrame.OnClose()
	id = this:GetID();
	-- Bag
	if (id == -2 or ( id >=0 and id <= 4) ) then
		CharactersViewer.ContainerFrame.ToggleBag();
	elseif (id >=5  and id <= 10)  then
		CharactersViewer.ContainerFrame.ToggleBankBag();
	end
end;


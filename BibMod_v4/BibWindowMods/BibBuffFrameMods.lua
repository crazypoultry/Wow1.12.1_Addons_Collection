--overridden because the default version of this function moves the buffframe
function BuffFrame_Enchant_OnUpdate(elapsed)
	local hasMainHandEnchant, mainHandExpiration, mainHandCharges, hasOffHandEnchant, offHandExpiration, offHandCharges = GetWeaponEnchantInfo();
	
	-- No enchants, kick out early
	if ( not hasMainHandEnchant and not hasOffHandEnchant ) then
		TempEnchant1:Hide();
		TempEnchant1Duration:Hide();
		TempEnchant2:Hide();
		TempEnchant2Duration:Hide();
		return;
	end
	-- Has enchants
	local enchantButton;
	local textureName;
	local buffAlphaValue;
	local enchantIndex = 0;
	if ( hasOffHandEnchant ) then
		enchantIndex = enchantIndex + 1;
		textureName = GetInventoryItemTexture("player", 17);
		TempEnchant1:SetID(17);
		TempEnchant1Icon:SetTexture(textureName);
		TempEnchant1:Show();
		hasEnchant = 1;

		-- Show buff durations if necessary
		if ( offHandExpiration ) then
			offHandExpiration = offHandExpiration/1000;
		end
		BuffFrame_UpdateDuration(TempEnchant1, offHandExpiration);

		-- Handle flashing
		if ( offHandExpiration and offHandExpiration < BUFF_WARNING_TIME ) then
			TempEnchant1:SetAlpha(BUFF_ALPHA_VALUE);
		end
		
	end
	if ( hasMainHandEnchant ) then
		enchantIndex = enchantIndex + 1;
		enchantButton = getglobal("TempEnchant"..enchantIndex);
		textureName = GetInventoryItemTexture("player", 16);
		enchantButton:SetID(16);
		getglobal(enchantButton:GetName().."Icon"):SetTexture(textureName);
		enchantButton:Show();
		hasEnchant = 1;

		-- Show buff durations if necessary
		if ( mainHandExpiration ) then
			mainHandExpiration = mainHandExpiration/1000;
		end
		
		BuffFrame_UpdateDuration(enchantButton, mainHandExpiration);

		-- Handle flashing
		if ( mainHandExpiration and mainHandExpiration < BUFF_WARNING_TIME ) then
			enchantButton:SetAlpha(BUFF_ALPHA_VALUE);
		end
	end
	--Hide unused enchants
	for i=enchantIndex+1, 2 do
		getglobal("TempEnchant"..i):Hide();
		getglobal("TempEnchant"..i.."Duration"):Hide();
	end

	-- Position buff frame
	TemporaryEnchantFrame:SetWidth(enchantIndex * 32);
end

function BuffButtons_UpdatePositions()
	if ( SHOW_BUFF_DURATIONS == "1" ) then
		BuffButton8:SetPoint("TOP", "BuffButton0", "BOTTOM", 0, -15);
		BuffButton16:SetPoint("TOPRIGHT", "BuffButton8", "BOTTOMRIGHT", 0, -15);
		BuffFrame:SetHeight(145);
		BuffFrameBackground:SetHeight(129);
	else
		BuffButton8:SetPoint("TOP", "BuffButton0", "BOTTOM", 0, -5);
		BuffButton16:SetPoint("TOPRIGHT", "BuffButton8", "BOTTOMRIGHT", 0, -5);
		BuffFrame:SetHeight(115);
		BuffFrameBackground:SetHeight(99);
	end
end

function BuffFrame_Enchant_OnUpdate(elapsed)
	local hasMainHandEnchant, mainHandExpiration, mainHandCharges, hasOffHandEnchant, offHandExpiration, offHandCharges = GetWeaponEnchantInfo();
	
	-- No enchants, kick out early
	if ( not hasMainHandEnchant and not hasOffHandEnchant ) then
		TempEnchant1:Hide();
		TempEnchant1Duration:Hide();
		TempEnchant2:Hide();
		TempEnchant2Duration:Hide();
		--BuffFrame:SetPoint("TOPRIGHT", "TemporaryEnchantFrame", "TOPRIGHT", 0, 0);
		return;
	end
	-- Has enchants
	local enchantButton;
	local textureName;
	local buffAlphaValue;
	local enchantIndex = 0;
	if ( hasOffHandEnchant ) then
		enchantIndex = enchantIndex + 1;
		textureName = GetInventoryItemTexture("player", 17);
		TempEnchant1:SetID(17);
		TempEnchant1Icon:SetTexture(textureName);
		TempEnchant1:Show();
		hasEnchant = 1;

		-- Show buff durations if necessary
		if ( offHandExpiration ) then
			offHandExpiration = offHandExpiration/1000;
		end
		BuffFrame_UpdateDuration(TempEnchant1, offHandExpiration);

		-- Handle flashing
		if ( offHandExpiration and offHandExpiration < BUFF_WARNING_TIME ) then
			TempEnchant1:SetAlpha(BUFF_ALPHA_VALUE);
		end
		
	end
	if ( hasMainHandEnchant ) then
		enchantIndex = enchantIndex + 1;
		enchantButton = getglobal("TempEnchant"..enchantIndex);
		textureName = GetInventoryItemTexture("player", 16);
		enchantButton:SetID(16);
		getglobal(enchantButton:GetName().."Icon"):SetTexture(textureName);
		enchantButton:Show();
		hasEnchant = 1;

		-- Show buff durations if necessary
		if ( mainHandExpiration ) then
			mainHandExpiration = mainHandExpiration/1000;
		end
		
		BuffFrame_UpdateDuration(enchantButton, mainHandExpiration);

		-- Handle flashing
		if ( mainHandExpiration and mainHandExpiration < BUFF_WARNING_TIME ) then
			enchantButton:SetAlpha(BUFF_ALPHA_VALUE);
		end
	end
	--Hide unused enchants
	for i=enchantIndex+1, 2 do
		getglobal("TempEnchant"..i):Hide();
		getglobal("TempEnchant"..i.."Duration"):Hide();
	end

	-- Position buff frame
	--TemporaryEnchantFrame:SetWidth(enchantIndex * 32);
	--BuffFrame:SetPoint("TOPRIGHT", "TemporaryEnchantFrame", "TOPLEFT", -5, 0);
end

function TicketStatusFrame_OnEvent()
	if ( event == "PLAYER_ENTERING_WORLD" ) then
		GetGMTicket();
	else
		if ( arg1 ~= 0 ) then		
			this:Show();
			--TemporaryEnchantFrame:SetPoint("TOPRIGHT", this:GetParent():GetName(), "TOPRIGHT", -205, (-this:GetHeight()));
			refreshTime = GMTICKET_CHECK_INTERVAL;
		else
			this:Hide();
			--TemporaryEnchantFrame:SetPoint("TOPRIGHT", "UIParent", "TOPRIGHT", -180, -13);
		end
	end	
end
local tablet = TabletLib:GetInstance('1.0')
local dewdrop = DewdropLib:GetInstance('1.0')
local metro = Metrognome:GetInstance('1')

QuanjureFu = FuBarPlugin:GetInstance("1.2"):new({
	name          = QuanjureFuLocals.NAME,
	description   = QuanjureFuLocals.DESCRIPTION,
	version       = "1.2.5",
	releaseDate   = "2006-06-22",
	aceCompatible = 103,
	author        = "Quantuvis",
	email         = "Quantuvis@represent.dk",
	website       = "http://represent.dk/pc",
	category      = "class",
	db            = AceDatabase:new("QuanjureDB"),
	defaults      = {},
	cmd           = AceChatCmd:new(QuanjureFuLocals.COMMANDS, QuanjureFuLocals.CMD_OPTIONS),
	loc           = QuanjureFuLocals,
	hasIcon       = true,
	canHideText   = true,
	hasNoColor    = true,
	isPortaling   = false,
	cannotDetachTooltip = true,
})

function QuanjureFu:Enable()
	metro:Register(self.name, self.OnUpdate, 1, self)
	metro:Start(self.name)
end

function QuanjureFu:OnClick()
	quanjure();
end

function QuanjureFu:OnUpdate()
	self:UpdateDisplay()
end

function QuanjureFu:UpdateTooltip()
	tablet:SetHint(self.loc.TOOLTIP)
end

function QuanjureFu:UpdateText()
	local portals
	if(UnitFactionGroup("player") == QUANJURE_HORDE) then
		portals = QUANJURE_PORTALS_HORDE;
	else
		portals = QUANJURE_PORTALS_ALLIANCE;
	end
	local portalpos,portalnum;
	local portaltime = 0;
	for i=1,3,1 do
		local portalpos = Quanjure_GetSpellPosition(QUANJURE_PORTALS_PORTAL .. ": " .. portals[i]);
		if portalpos ~= nil then
			local start,duration = GetSpellCooldown(portalpos, SpellBookFrame.bookType);
			if start ~= 0 and portaltime < floor(duration - (GetTime() - start)) then
				portaltime = floor(duration - (GetTime() - start));
				portalnum = i;
				if portaltime > 1 then self.data.isPortaling = true end;
			end
		end
	end
	if self.data.isPortaling then
		if portalnum ~= nil then self:SetText(portals[portalnum] .. " (" .. portaltime .. ")"); end;
		if portaltime <= 1 then self.data.isPortaling = false end;
	else
		self:SetText("Quanjure");
	end
end

function QuanjureFu:MenuSettings(level, value)
	local teleCount = Quanjure_ItemCount(QUANJURE_REAGENTS_TELEPORT);
	local portalCount = Quanjure_ItemCount(QUANJURE_REAGENTS_PORTAL);
	local plural = "";
	local portals, bgtrinkets;
	local miscStuff = {};
	if(UnitFactionGroup("player") == QUANJURE_HORDE) then
		portals = QUANJURE_PORTALS_HORDE;
		bgtrinkets = QUANJURE_MISC_BG_HORDE;
	else
		portals = QUANJURE_PORTALS_ALLIANCE;
		bgtrinkets = QUANJURE_MISC_BG_ALLIANCE;
	end
	
	dewdrop:AddLine('text'," ",'isTitle',true);

	if (UnitClass("Player") == QUANJURE_MAGE and UnitLevel("Player") > 19) then
		if(teleCount == 1) then	plural = QUANJURE_PORTALS_SINGULAR else plural = QUANJURE_PORTALS_PLURAL end
		dewdrop:AddLine(
    		'text', QUANJURE_PORTALS_TELEPORT .. " (" .. Quanjure_HighlightText(teleCount .. " " .. plural) .. ")",
    		'isTitle', true
		)
		if(teleCount > 0) then
			for i=1,3,1 do
				if Quanjure_GetSpellPosition(QUANJURE_PORTALS_TELEPORT .. ": " .. portals[i]) ~= nil then
					dewdrop:AddLine(
						'text', portals[i],
						'func', function (val) Quanjure_Tele(val) end,
						'arg1', QUANJURE_PORTALS_TELEPORT .. ": " .. portals[i],
						'closeWhenClicked', true
					)
				end
			end
		end
	end
	
	
	if (UnitClass("Player") == QUANJURE_MAGE and UnitLevel("Player") > 39) then
		dewdrop:AddLine('text'," ",'isTitle',true);
		if(portalCount == 1) then plural = QUANJURE_PORTALS_SINGULAR else plural = QUANJURE_PORTALS_PLURAL end
		dewdrop:AddLine(
    		'text', QUANJURE_PORTALS_PORTAL .. " (" .. Quanjure_HighlightText(portalCount .. " " ..plural) .. ")",
    		'isTitle', true
		)
		if(portalCount > 0) then
			for i=1,3,1 do
				if Quanjure_GetSpellPosition(QUANJURE_PORTALS_PORTAL .. ": " .. portals[i]) ~= nil then
					dewdrop:AddLine(
						'text', portals[i],
						'arg1', QUANJURE_PORTALS_PORTAL .. ": " .. portals[i],
						'func', function (val) Quanjure_Tele(val) end,
						'closeWhenClicked', true
					)
				elseif GetLocale() == "frFR" then -- Hardcoded fix for french localization inconsistency with "Portail: "'s trailing space.
					if Quanjure_GetSpellPosition(QUANJURE_PORTALS_PORTAL_FR .. ": " .. portals[i]) ~= nil then
						dewdrop:AddLine(
							'text', portals[i],
							'arg1', QUANJURE_PORTALS_PORTAL_FR .. ": " .. portals[i],
							'func', function (val) Quanjure_Tele(val) end,
							'closeWhenClicked', true
						)
					end
				end
			end
		end
	end
	
	if(Quanjure_ItemCount(QUANJURE_HEARTHSTONE) > 0) then
		if (UnitClass("Player") == QUANJURE_MAGE) then dewdrop:AddLine('text'," ",'isTitle',true); end;
		dewdrop:AddLine('text',QUANJURE_HEARTHSTONE .. " (" .. Quanjure_HearthCD() .. ")",'isTitle',true);
		dewdrop:AddLine(
			'text', GetBindLocation(),
			'func', function () Quanjure_Consume(QUANJURE_HEARTHSTONE) end,
			'closeWhenClicked', true
		)
	end
	
	for i=1,getn(QUANJURE_MISC_ENGINEER) do
		local trinkx,trinky = Quanjure_FindItem(nil,nil,QUANJURE_MISC_ENGINEER[i], nil, nil);
		if trinky > Q_NIL then table.insert(miscStuff, {trinkx,trinky,QUANJURE_MISC_ENGINEER[i]}) end
	end
	for i=1,getn(bgtrinkets) do
		local trinkx,trinky = Quanjure_FindItem(nil,nil,bgtrinkets[i], nil, nil);
		if trinky > Q_NIL then table.insert(miscStuff, {trinkx,trinky,bgtrinkets[i]}) end
	end
	for i=1,getn(QUANJURE_MISC_SPELLS) do
		if Quanjure_GetSpellPosition(QUANJURE_MISC_SPELLS[i]) ~= nil then
			table.insert(miscStuff, {Q_NIL,Q_NIL,QUANJURE_MISC_SPELLS[i]})
		end
	end
	if getn(miscStuff) > 0 then
		dewdrop:AddLine('text'," ",'isTitle',true);
		dewdrop:AddLine('text',QUANJURE_MISC_TITLE,'isTitle',true);
		for i=1,getn(miscStuff) do
			local cooldownText = "";
			if ( miscStuff[i][1] == Q_NIL and miscStuff[i][2] == Q_NIL ) then 
				start,duration = GetSpellCooldown(Quanjure_GetSpellPosition(miscStuff[i][3]), SpellBookFrame.bookType);
				if ( start == 0 ) then cooldownText = " (" .. QUANJURE_READY .. ")" else cooldownText = " (" .. Quanjure_HighlightText(Quanjure_GetTimeText(duration-floor(GetTime()-start))) .. ")" end
				dewdrop:AddLine(
					'text', miscStuff[i][3] .. cooldownText,
					'func', function () CastSpellByName(miscStuff[i][3])end,
					'closeWhenClicked', true
				)
			else
				if ( miscStuff[i][1] == Q_NIL ) then
					start, duration = GetInventoryItemCooldown("player", miscStuff[i][2]);
					if ( start == 0 ) then cooldownText = " (" .. QUANJURE_READY .. ")" else cooldownText = " (" .. Quanjure_HighlightText(Quanjure_GetTimeText(duration-floor(GetTime()-start))) .. ")" end
				else 
					start, duration = GetContainerItemCooldown(miscStuff[i][1], miscStuff[i][2]);
					if ( start == 0 or (GetTime() - (start + duration)) > -30) then cooldownText = " (" .. QUANJURE_BAG .. ")" else cooldownText = " (" .. Quanjure_HighlightText(Quanjure_GetTimeText(duration-floor(GetTime()-start))) .. ")" end
				end
				dewdrop:AddLine(
					'text', miscStuff[i][3] .. cooldownText,
					'arg1', miscStuff[i],
					'func', function (val) Quanjure_UseTrinket(val); end,
					'closeWhenClicked', true
				)
			end
		end
	end

	dewdrop:AddLine('text'," ",'isTitle',true);
	
	dewdrop:AddLine('text',self.loc.MENU_OPTIONS,'isTitle',true);
	
	dewdrop:AddLine(
		'text', QUANJURE_MINIMAP_SETUP,
		'arg1', self,
		'func', function () QuanjureButton_Toggle() end,
		'checked', QuanjureButtonFrame:IsVisible()
	)
	
	dewdrop:AddLine(
		'text', QUANJURE_SETUP,
		'arg1', self,
		'func', function () ShowUIPanel(QuanjureFrame) end,
		'closeWhenClicked', true
	)
end 

QuanjureFu:RegisterForLoad()
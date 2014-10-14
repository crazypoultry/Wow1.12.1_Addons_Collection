PORTALS_PAGE_NAME = "Телепорты и порталы"
REAGENTS = "Реагенты: |cff000000%s|r шт."

local Teleports = {};
local Portals = {};
local loaded = false;
local numSkillLineTabs = 4;

local frame = CreateFrame"Frame";
frame:RegisterEvent"SPELLS_CHANGED";
frame:SetScript("OnEvent",function()
		addTeleports();
	end)

oldSpellBookFrame_OnShow = SpellBookFrame_OnShow;
SpellBookFrame_OnShow = function()
	-- SpellBookSkillLineTab_OnClick(1);
	oldSpellBookFrame_OnShow();
	local _, class = UnitClass("player");
	if (class == "MAGE") then
		AddPortalTab();
		frame:Show();
	end
end

oldSpellBookFrame_OnUpdate = SpellBookFrame_OnUpdate;
SpellBookFrame_OnUpdate = function()
	oldSpellBookFrame_OnShow();
		AddPortalTab();
		frame:Show();
end

oldSpellButton_UpdateButton = SpellButton_UpdateButton;
SpellButton_UpdateButton = function()
	
	if SpellBookFrame.selectedSkillLine == numSkillLineTabs + 1 then
		AddPortalButtons();
	else
		SpellButton1:Show();
		SpellButton2:Show();
		SpellButton3:Show();
		SpellButton4:Show();
		SpellButton5:Show();
		SpellButton6:Show();
		SpellButton7:Show();
		SpellButton8:Show();
		SpellButton9:Show();
		SpellButton10:Show();
		SpellButton11:Show();
		SpellButton12:Show();
		oldSpellButton_UpdateButton();
	end
end

oldSpellBookFrame_Update = SpellBookFrame_Update;
SpellBookFrame_Update = function()
	PlaySound("igSpellBookOpen");
	oldSpellBookFrame_Update();
		AddPortalTab();
		frame:Show();
end

oldSpellBook_UpdatePageArrows = SpellBook_UpdatePageArrows;
SpellBook_UpdatePageArrows = function()
	-- local numSkillLineTabs = GetNumSpellTabs();
	if SpellBookFrame.selectedSkillLine == numSkillLineTabs + 1 then
		SpellBookPrevPageButton:Disable();
		SpellBookNextPageButton:Disable();
	else
		oldSpellBook_UpdatePageArrows();
	end
end

oldSpellButton_OnEnter = SpellButton_OnEnter;
SpellButton_OnEnter = function()
	-- local numSkillLineTabs = GetNumSpellTabs();
	if SpellBookFrame.selectedSkillLine == numSkillLineTabs + 1 and SpellBookFrame:IsShown() then
		TeleportButton_OnEnter();
	else
		oldSpellButton_OnEnter();
	end
end

oldSpellButton_OnClick = SpellButton_OnClick;
SpellButton_OnClick = function(drag)
	if SpellBookFrame.selectedSkillLine == numSkillLineTabs + 1 and SpellBookFrame:IsShown() then
		TeleportButton_OnClick(drag);
	else
		oldSpellButton_OnClick(drag);
	end
end

oldSpellButton_UpdateSelection = SpellButton_UpdateSelection;
SpellButton_UpdateSelection = function()
	local temp, texture, offset, numSpells = GetSpellTabInfo(SpellBookFrame.selectedSkillLine);
	local id = SpellBook_GetSpellID(this:GetID());
	if id <= 0 then	id = TeleportPage_GetSpellID(this);	end
	if ( (SpellBookFrame.bookType ~= BOOKTYPE_PET) and (id > (offset + numSpells)) ) then
		this:SetChecked("false");
		return;
	end

	if ( IsCurrentCast(id, BOOKTYPE_SPELL))then
		this:SetChecked("true");
	else
		this:SetChecked("false");
	end
end

function TeleportPage_GetSpellID(this)
	if this == SpellButton1 and Teleports[1] then return Teleports[1]; 
	elseif this == SpellButton2 and Teleports[2] then return Teleports[2]; 
	elseif this == SpellButton3 and Teleports[3] then return Teleports[3]; 
	elseif this == SpellButton4 and Teleports[4] then return Teleports[4]; 
	elseif this == SpellButton5 and Teleports[5] then return Teleports[5]; 
	elseif this == SpellButton6 and Teleports[6] then return Teleports[6]; 
	elseif this == SpellButton7 and Portals[1] then return Portals[1];
	elseif this == SpellButton8 and Portals[2] then return Portals[2];
	elseif this == SpellButton9 and Portals[3] then return Portals[3];
	elseif this == SpellButton10 and Portals[4] then return Portals[4];
	elseif this == SpellButton11 and Portals[5] then return Portals[5];
	elseif this == SpellButton12 and Portals[6] then return Portals[6];
	else return 1;
	end
end

function TeleportButton_OnEnter()
	local id = TeleportPage_GetSpellID(this);
	GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
	if ( GameTooltip:SetSpell(id, SpellBookFrame.bookType) ) then
		this.updateTooltip = TOOLTIP_UPDATE_TIME;
	else
		this.updateTooltip = nil;
	end
end

function TeleportButton_OnClick(drag)
	local id = TeleportPage_GetSpellID(this);
	if (drag) then
		PickupSpell(id, BOOKTYPE_SPELL);
		this:SetChecked("false");
	elseif ( IsShiftKeyDown() ) then
			PickupSpell(id, BOOKTYPE_SPELL);
			this:SetChecked("false");
	else
		-- local id = TeleportPage_GetSpellID(this);
		CastSpell(id, BOOKTYPE_SPELL);
		SpellButton_UpdateSelection();
	end
end

function AddPortalTab()

	if not loaded then
		numSkillLineTabs = GetNumSpellTabs();
		addTeleports();
		loaded = true;
	end

	-- local numSkillLineTabs = GetNumSpellTabs();
	local name, texture, offset, numSpells;
	local skillLineTab = getglobal("SpellBookSkillLineTab"..numSkillLineTabs + 1);
	name, texture, offset, numSpells = GetSpellTabInfo(numSkillLineTabs);
	skillLineTab:SetNormalTexture("Interface\\AddOns\\bonhoUI\\Spellbook\\Spell_Shadow_SoulLeech_2.blp");
	skillLineTab.tooltip = "Portals";
	skillLineTab:Show();

	if (SpellBookFrame.selectedSkillLine == numSkillLineTabs + 1) then
		skillLineTab:SetChecked(1);
		SpellBookTitleText:SetText(PORTALS_PAGE_NAME)
		SpellBookPageText:Hide();
		SpellBookPrevPageButton:Disable();
		SpellBookNextPageButton:Disable();
	else
		SpellBookPageText:Show();
		skillLineTab:SetChecked(nil);
	end
end

function addTeleports()
	Teleports = {};
	Portals = {};
	local i = 1
	while true do
	    local spellName, spellRank = GetSpellName(i, BOOKTYPE_SPELL)
	    if not spellName then
		    do break end
		    elseif string.find(spellName, "Teleport") then
		    table.insert(Teleports,i);
		   	-- Print("Teleport:"..i);
		   	elseif string.find(spellName, "Portal") then
		   	table.insert(Portals,i);
		   	-- Print("Portal:"..i)
	    end
	    i = i + 1
	end
	table.sort(Teleports);
	table.sort(Portals);
end

function AddTeleportButton(button_id,s_id, type)
	local items = 0;
	local spell_id = nil;
	if type == 1 and Teleports[s_id] then
		spell_id = Teleports[s_id];
		items = getTeleportRunes(type);
	elseif type == 2 and Portals[s_id] then
		spell_id = Portals[s_id];
		items = getTeleportRunes(type);
	end
	local button = getglobal("SpellButton"..button_id);

	if spell_id ~= nil then
		local name = "SpellButton"..button_id;
		local texture;
		local iconTexture = getglobal(name.."IconTexture");
		local spellString = getglobal(name.."SpellName");
		local subSpellString = getglobal(name.."SubSpellName");
		local cooldown = getglobal(name.."Cooldown");

		texture = GetSpellTexture(spell_id, BOOKTYPE_SPELL);

		local highlightTexture = getglobal(name.."Highlight");
		local normalTexture = getglobal(name.."NormalTexture");
		normalTexture:Hide();
		if ( not texture or (strlen(texture) == 0) ) then
			iconTexture:Hide();
			spellString:Hide();
			subSpellString:Hide();
			cooldown:Hide();
			highlightTexture:SetTexture("Interface\\Buttons\\ButtonHilight-Square");
			this:SetChecked(0);
			normalTexture:SetVertexColor(1.0, 1.0, 1.0);
			return;
		end

		local start, duration, enable = GetSpellCooldown(spell_id, BOOKTYPE_SPELL);
		CooldownFrame_SetTimer(cooldown, start, duration, enable);
		if ( enable == 1 ) then
			iconTexture:SetVertexColor(1.0, 1.0, 1.0);
		else
			iconTexture:SetVertexColor(0.4, 0.4, 0.4);
		end
		
		local spellName, subSpellName = GetSpellName(spell_id, BOOKTYPE_SPELL);
		iconTexture:SetTexture(texture);
		spellString:SetText(spellName);


		normalTexture:SetVertexColor(1.0, 1.0, 1.0);
		highlightTexture:SetTexture("Interface\\Buttons\\ButtonHilight-Square");
		spellString:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);

		-- subSpellString:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
		subSpellString:SetFont(STANDARD_TEXT_FONT, 10);
		-- subSpellString:SetTextColor(0, 0, 0);
		subSpellString:SetWidth(100);

		spellString:SetWidth(90);
		spellString:SetFont(STANDARD_TEXT_FONT, 11);

		subSpellString:SetText(string.format(REAGENTS,items));

		
		iconTexture:Show();
		spellString:Show();
		subSpellString:Show();
		SpellButton_UpdateSelection();


	else
		button:Hide();
	end
end

function AddPortalButtons()
	AddTeleportButton(1,1,1);
	AddTeleportButton(2,2,1);
	AddTeleportButton(3,3,1);
	AddTeleportButton(4,4,1);
	AddTeleportButton(5,5,1);
	AddTeleportButton(6,6,1);

	AddTeleportButton(7,1,2);
	AddTeleportButton(8,2,2);
	AddTeleportButton(9,3,2);
	AddTeleportButton(10,4,2);
	AddTeleportButton(11,5,2);
	AddTeleportButton(12,6,2);
end

function Print( text )
	if (not text) then
		return;	
	end
		ChatFrame1:AddMessage(GREEN_FONT_COLOR_CODE..""..text.."");
end

function getTeleportRunes(type)
	local _, class = UnitClass("player");
	if (class == "MAGE") then
		local mage_tp = 0;
		local mage_p = 0;
		for bag = 4, 0, -1 do
			local size = GetContainerNumSlots(bag);
			if (size > 0) then
				for slot=1, size, 1 do
					local texture, itemCount = GetContainerItemInfo(bag, slot);
					if (itemCount) then
						local itemName = tms_NameFromLink(GetContainerItemLink(bag, slot));
						if  ((itemName) and (itemName ~= "")) then -- if the item has a name
							if itemName == "Руна телепортации" or itemName == "Rune of Teleportation" then
								mage_tp = mage_tp + itemCount;
							elseif itemName == "Руна порталов" or itemName == "Rune of Portals" then
								mage_p = mage_p + itemCount;
							end
						end
					end
				end            
			end
		end 
	if type == 1 then return mage_tp
	else return mage_p;
	end
	end
end

function tms_NameFromLink(link)
local name
if (link) then
for name in string.gfind(link, "|c%x+|Hitem:%d+:%d+:%d+:%d+|h%[(.-)%]|h|r") do
return name
end
end
end 
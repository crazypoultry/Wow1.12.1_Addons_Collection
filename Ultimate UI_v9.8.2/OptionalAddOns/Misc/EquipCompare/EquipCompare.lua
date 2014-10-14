--
-- EquipCompare by Legorol
-- Version: 2.0 (UltimateUI compatible)
--
-- Equipment comparison tooltips, not just at the merchant. If you hover over
-- any item in places like your bag, quest reward page or loot window, you
-- get a comparison tooltip showing the item of that type that you currently
-- have equipped.
--
-- Usage:
-- Enabled by default, to disable type
-- /script EquipCompare_Enabled=false;
--

--
-- Global variables
--

EquipCompare_Enabled = true;
EquipCompare_Recheck = true;
EquipCompare_Protected = false;
EquipCompare_Showing = false;

EquipCompare_ItemTypes = {
	[INVTYPE_WEAPONMAINHAND] = 16, -- Main Hand
	[INVTYPE_2HWEAPON] = 16, -- Two-Hand
	[INVTYPE_WEAPON] = 16, -- One-Hand
	[INVTYPE_WEAPON.."_other"] = 17, -- One-Hand_other
--  Obsolete entries?
--	["Hand"] = 16,
--	["Held In Hand"] = 16,
	[INVTYPE_SHIELD] = 17, -- Off Hand
	[INVTYPE_WEAPONOFFHAND] = 17, -- Off Hand
	[INVTYPE_HOLDABLE] = 17, -- Held In Off-hand
	[INVTYPE_HEAD] = 1, -- Head
	[INVTYPE_WAIST] = 6, -- Waist
	[INVTYPE_SHOULDER] = 3, -- Shoulder
	[INVTYPE_LEGS] = 7, -- Legs
	[INVTYPE_CLOAK] = 15, -- Back
	[INVTYPE_FEET] = 8, -- Feet
	[INVTYPE_CHEST] = 5, -- Chest
	[INVTYPE_ROBE] = 5, -- Chest
	[INVTYPE_WRIST] = 9, -- Wrist
	[INVTYPE_HAND] = 10, -- Hands
	[INVTYPE_RANGED] = 18, -- Ranged
	[INVTYPE_BODY] = 4, -- Shirt
	[INVTYPE_TABARD] = 19, -- Tabard
	[INVTYPE_FINGER] = 11, -- Finger
	[INVTYPE_FINGER.."_other"] = 12, -- Finger_other
	[INVTYPE_NECK] = 2, -- Neck
	[INVTYPE_TRINKET] = 13, -- Trinket
	[INVTYPE_TRINKET.."_other"] = 14, -- Trinket_other
	[INVTYPE_WAND] = 18, -- Wand
	[INVTYPE_GUN] = 18, -- Gun
	[INVTYPE_GUNPROJECTILE] = 0, -- Projectile
	[INVTYPE_BOWPROJECTILE] = 0 -- Projectile
};

--
-- XML Event handlers
--

function EquipCompare_OnLoad()
	this:RegisterEvent("CLEAR_TOOLTIP");
	-- Check for UltimateUI. If available, register with it.
	if ( UltimateUI_RegisterConfiguration ) then
		this:RegisterEvent("VARIABLES_LOADED");
		UltimateUI_RegisterConfiguration(
			"UUI_EQC",
			"SECTION",
			EQUIPCOMPARE_ULTIMATEUI_SECTION,
			EQUIPCOMPARE_ULTIMATEUI_SECTION_INFO
		);
		UltimateUI_RegisterConfiguration(
			"UUI_EQC_SEPARATOR",
			"SEPARATOR",
			EQUIPCOMPARE_ULTIMATEUI_HEADER,
			EQUIPCOMPARE_ULTIMATEUI_HEADER_INFO
			
		);
		UltimateUI_RegisterConfiguration(
			"UUI_EQC_ENABLED",
			"CHECKBOX",
			EQUIPCOMPARE_ULTIMATEUI_ENABLE,
			EQUIPCOMPARE_ULTIMATEUI_ENABLE_INFO,
			EquipCompare_Toggle,
			1
		);
		local comlist = { "/equipcompare", "/eqc" };
		local desc = EQUIPCOMPARE_ULTIMATEUI_SLASH_DESC;
		local id = "EQUIPCOMPARE";
		local func = EquipCompare_SlashCommand
		UltimateUI_RegisterChatCommand ( id, comlist, func, desc, CSM_CHAINNONE );
	else
	-- otherwise, just register slash commands manually
		SlashCmdList["EQUIPCOMPARE"] = EquipCompare_SlashCommand;
		SLASH_EQUIPCOMPARE1 = "/equipcompare";
		SLASH_EQUIPCOMPARE2 = "/eqc";
	end
end

function EquipCompare_OnEvent(event)
	if ( event == "CLEAR_TOOLTIP" ) then
		if ( not EquipCompare_Protected ) then
			EquipCompare_Recheck = true;
			EquipCompare_HideTips();
		end
	elseif ( event == "VARIABLES_LOADED" ) then
		-- we have UltimateUI, so let's read the state of the AddOn from UltimateUI
		EquipCompare_Toggle(UUI_EQC_ENABLED_X);
	end
end

function EquipCompare_OnUpdate()
	EquipCompare_ShowCompare();
end

--
-- Other functions
--

function EquipCompare_SlashCommand(msg)
	if (not msg or msg == "") then
		-- toggle
		EquipCompare_Toggle(not EquipCompare_Enabled);
	elseif (msg == "on") then
		-- turn on
		EquipCompare_Toggle(true);
	elseif (msg == "off") then
		-- turn off
		EquipCompare_Toggle(false);
	else
		-- usage
		ChatFrame1:AddMessage(EQUIPCOMPARE_USAGE_TEXT);
	end
	-- update UltimateUI configuration setting
	if ( UltimateUI_RegisterConfiguration ) then
		local newvalue;
		if ( EquipCompare_Enabled ) then
			newvalue = 1;
		else
			newvalue = 0;
		end
		UUI_EQC_ENABLED_X=newvalue;
		UltimateUI_UpdateValue("UUI_EQC_ENABLED", CSM_CHECKONOFF, newvalue);
		UltimateUI_SetCVar("UUI_EQC_ENABLED_X", newvalue);
	end
end

function EquipCompare_Toggle(toggle)
	-- workaround, as UltimateUI sends a 0 when it wants to turn us off
	if ( toggle == 0 ) then toggle = false; end
	-- turn on
	if ( toggle and not EquipCompare_Enabled ) then
		EquipCompare_Enabled = true;
		EquipCompare_Recheck = true;
	end
	-- turn off
	if ( not toggle and EquipCompare_Enabled ) then
		EquipCompare_Enabled = false;
		EquipCompare_HideTips();
	end
end

function EquipCompare_HideTips()
	if ( EquipCompare_Showing ) then
		EquipCompare_Showing = false;
		ShoppingTooltip1:Hide();
		ShoppingTooltip2:Hide();
	end
end

-- This function is called on every OnUpdate. This is the only way to detect if a
-- game tooltip has been displayed, without overriding FrameXML files.
-- So that this function doesn't hog resources, the EquipCompare_Recheck flag is
-- set to false, until the game tooltip changes.
function EquipCompare_ShowCompare()
	--
	-- Local functions
	--
	
	-- Display a shopping tooltip and set its contents to currently equipped item
	-- occupying slotid
	local function ShowShoppingTooltip(parent, slotid)
		local leftAlign=true;
		ShoppingTooltip1:SetOwner(getglobal(parent), "ANCHOR_NONE");
		ShoppingTooltip1:SetPoint("TOPRIGHT", parent, "TOPLEFT", 0, -10);
		ShoppingTooltip1:SetInventoryItem("player", slotid);
		local left = ShoppingTooltip1:GetLeft();
		-- If the shopping tooltip would be off the screen, place it on other 
		-- side instead. Also, if we are over a QuestFrame, or the tooltip
		-- is a LootLink tooltip or ItemRef tooltip, place it on right
		if ( (left and left<0) or 
			  MouseIsOver(QuestFrame) or
			  parent == "ItemRefTooltip" or
			  parent == "LootLinkTooltip" ) then
			ShoppingTooltip1:ClearAllPoints();
			ShoppingTooltip1:SetPoint("TOPLEFT", parent, "TOPRIGHT", 0, -10);
			leftAlign=false;
		end
		return leftAlign
	end
	
	--
	-- Main code of EquipCompare_ShowCompare starts here
	--
	local tooltip, ttext, type, slotid, other, leftAlign;
	
	if ( not EquipCompare_Enabled ) then
		return;
	end

	if ( (not GameTooltip or not GameTooltip:IsVisible()) and
		  (not LootLinkTooltip or not LootLinkTooltip:IsVisible()) and
		  (not ItemRefTooltip or not ItemRefTooltip:IsVisible()) ) then
		EquipCompare_Recheck = true;
		EquipCompare_HideTips();
		return;
	end
	
	if ( not EquipCompare_Recheck ) then
	 	return;
	end
	
	-- Check if it's the GameTooltip or the LootLinkTooltip we are interested in
	if ( LootLinkTooltip and LootLinkTooltip:IsVisible() ) then
		tooltip = "LootLinkTooltip";
	elseif ( GameTooltip and GameTooltip:IsVisible() ) then
		tooltip = "GameTooltip";
	else
		tooltip = "ItemRefTooltip";
	end

	EquipCompare_Recheck = false;

	-- MerchantFrame provides equipment comparison tooltips already, so we don't need to
	if (( MerchantFrame:IsVisible() and MouseIsOver ( MerchantFrame )) or
	    ( PaperDollFrame:IsVisible() and MouseIsOver ( PaperDollFrame )) or
		( ShoppingTooltip1 and ShoppingTooltip1:IsVisible() ) ) then
		return;
	end
	
	-- Infer the type of the item from the 2nd or 3rd line of its tooltip description
	-- Match this type against the appropriate slot
	ttext = getglobal(tooltip.."TextLeft2");
	if ( ttext and ttext:IsVisible() and ttext:GetText() ) then
		type = ttext:GetText();
		slotid = EquipCompare_ItemTypes[type];
	end
	if ( not slotid ) then
		ttext = getglobal(tooltip.."TextLeft3");
		if ( ttext and ttext:IsVisible() and ttext:GetText() ) then
			type = ttext:GetText();
			slotid = EquipCompare_ItemTypes[type];
		end
	end
	
	if ( slotid ) then
		-- Whilst we are in the process of displaying additional tooltips, we don't
		-- want to reset the EquipCompare_Recheck flag. This protection is necessary
		-- because calling SetOwner or SetxxxItem on any tooltip causes a
		-- CLEAR_TOOLTIP event.
	    EquipCompare_Protected = true;
		EquipCompare_Showing = true;
		
		-- In case money line is visible on GameTooltip, must protect it by overriding
		-- GameTooltip_ClearMoney. This is because calling SetOwner or SetxxxItem on
		-- any tooltip causes money line of GameTooltip to be cleared.
		local oldFunction = GameTooltip_ClearMoney;
		GameTooltip_ClearMoney = function() end;
		
		-- Display a shopping tooltip and set its contents to currently equipped item
		leftAlign = ShowShoppingTooltip(tooltip,slotid);
		
		other = false;
		-- If this is an item that can go into multiple slots, display additional
		-- tooltips as appropriate
		if ( type == INVTYPE_FINGER ) then
			other = EquipCompare_ItemTypes[INVTYPE_FINGER.."_other"];
		end
		--if ( type == INVTYPE_TRINKET ) then
		--	other = EquipCompare_ItemTypes[INVTYPE_TRINKET.."_other"];
		--end
		if ( type == INVTYPE_WEAPON ) then
			other = EquipCompare_ItemTypes[INVTYPE_WEAPON.."_other"];
		end
		
		if ( other ) then
			if ( ShoppingTooltip1:IsVisible() ) then
				ShoppingTooltip2:SetOwner(ShoppingTooltip1, "ANCHOR_NONE");
				if ( leftAlign ) then
					ShoppingTooltip2:SetPoint("TOPRIGHT", "ShoppingTooltip1", "TOPLEFT", 0, 0);
				else
					ShoppingTooltip2:SetPoint("TOPLEFT", "ShoppingTooltip1", "TOPRIGHT", 0, 0);
				end
				ShoppingTooltip2:SetInventoryItem("player", other);
			else
				ShowShoppingTooltip(tooltip,other);
			end
		end
		
		-- Restore GameTooltip_ClearMoney overriding.
		GameTooltip_ClearMoney = oldFunction;
		
		EquipCompare_Protected = false;
	end
end

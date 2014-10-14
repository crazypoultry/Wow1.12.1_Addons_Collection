--[[

	SuperInspect_UI: ---------
		copyright 2005-2006 by Chester

]]

--what is with the inconsistant naming, bliz?
SI_BG = {
	[1] = "Dwarf",
	[2] = "Human",
	[3] = "NightElf",
	[4] = "Orc",
	[5] = "Scourge",
	[6] = "Tauren",
	};

SI_BG_Other = {
	[1] = "DruidBalance",
	[2] = "DruidFeralCombat",
	[3] = "DruidRestoration",
	[4] = "HunterBeastMastery",
	[5] = "HunterMarksmanship",
	[6] = "HunterSurvival",
	[7] = "MageArcane",
	[8] = "MageFire",
	[9] = "MageFrost",
	[10] = "PaladinCombat",
	[11] = "PaladinHoly",
	[12] = "PaladinProtection",
	[13] = "PriestDiscipline",
	[14] = "PriestHoly",
	[15] = "PriestShadow",
	[16] = "RogueAssassination",
	[17] = "RogueCombat",
	[18] = "RogueSubtlety",
	[19] = "ShamanElementalCombat",
	[20] = "ShamanEnhancement",
	[21] = "ShamanRestoration",
	[22] = "WarlockCurses",
	[23] = "WarlockDestruction",
	[24] = "WarlockSummoning",
};


SI_LOCAL_ITEM_CACHE = {};
SI_LOCAL_USERS_ITEM_CACHE = {};

SI_INFOTEXT_COLOR = "|cffe5cccc";

function SuperInspect_OnLoad()
	this:RegisterEvent("UNIT_MODEL_CHANGED");
	this:RegisterEvent("PLAYER_TARGET_CHANGED");
	this:RegisterEvent("UNIT_PORTRAIT_UPDATE");
	this:RegisterEvent("UNIT_INVENTORY_CHANGED");
	
	SLASH_SUPERINSPECT1 = "/superinspect";
	SlashCmdList["SUPERINSPECT"] = function(msg)
		SuperInspect_SlashCommand(msg);
	end
	
end


function SuperInspect_OnEvent()
	if( event == "UNIT_MODEL_CHANGED" or event == "UNIT_PORTRAIT_UPDATE") then
		SI_AddMessage("|cffffd200UNIT_PORTRAIT_UPDATE");
		if (arg1 == "target" and SuperInspectFrame:IsVisible()) then
			--SuperInspect_ModelFrame:SetUnit("target");
			SuperInspect_ModelFrame:RefreshUnit();
			SetPortraitTexture(SuperInspectFramePortrait, "target");
		end
	end
	if( event == "PLAYER_TARGET_CHANGED") then
		--SI_AddMessage("|cffffd200PLAYER_TARGET_CHANGED");
		if (SuperInspectFrame:IsVisible() or SI_Save.targ) then
			SI_Save.inrangeupdate = false;
			SI_Save.itemscached = false;
			SuperInspect_UpdateModel("target");
			SI_AddMessage("--UPDATING");
		end
	end
	if ( event == "UNIT_INVENTORY_CHANGED" ) then
		if ( arg1 == "target" ) then
			SI_AddMessage( "changed" )
			SuperInspect.bonus = nil;
			SuperInspect_InspectPaperDollFrame_OnShow();
		end
		return;
	end
end

function SuperInspect_Main_OnShow()
	if (not SuperInspectFrame.uiScale) then
		SuperInspectFrame.uiScale = SuperInspect_GetUIScale();	
	end
	if (not SI_Save.scale) then
		SI_Save.scale = 0.75;	
	end
	if (not SI_Save.default) then
		SuperInspectFrame:SetScale(3);
		SuperInspect_SetEffectiveScale(this, SI_Save.scale, "UIParent");
		--SuperInspect_ModelFrame:SetScale(SuperInspectFrame:GetEffectiveScale());	
	end
	if (SI_Save.snd) then
		PlaySound("igCharacterInfoOpen");
	end
	--SuperInspect_ModelFrame:RefreshUnit();
end

function SuperInspect_InspectFrame_Show(unit)
	if (not unit) then
		unit = "target";	
	end
	
	if (unit == "SI_FORCE") then
		SuperInspect.player = true;
	else
		SuperInspect.player = UnitIsPlayer(unit);
	end
	--SuperInspect.friend = UnitIsFriend(unit, "player");
	SuperInspect_InvFrame:Hide();
	if ((unit == "SI_FORCE") or (( UnitExists(unit) and SuperInspect.player))) then
		if (not (unit == "SI_FORCE")) then
			NotifyInspect(unit);
		else
			if (UnitExists("target") and (not UnitIsPlayer("target"))) then
				ClearTarget();
			end
		end
		SuperInspect_InvFrame.unit = unit;
		SuperInspect_Button_ShowItems:Enable();
		SuperInspect_Button_ShowItems:Show();
		SuperInspect_Button_ShowItems.isDisabled = nil;
		SuperInspect_Button_ShowHonor:Enable();
		SuperInspect_Button_ShowHonor:Show();
		SuperInspect_Button_ShowHonor.isVisible = 1;
		SuperInspect_Button_ShowHonor.isDisabled = nil;
		SuperInspect_Button_ShowBonuses:Enable();
		SuperInspect_Button_ShowBonuses:Show();
		SuperInspect_Button_ShowBonuses.isDisabled = nil;
		SuperInspect_Button_ShowBonuses.isVisible = 1;
		SuperInspect_Button_ShowMobInfo:Hide();
		if (not SI_Save.items or SI_Save.items == 0) then
			SuperInspect_InvFrame:Hide();
			--SI_AddMessage("HIDING INV: show items = nil");
		else
			SuperInspect_InvFrame:Show();	
			--SI_AddMessage("SHOW INV: show items = 1");
		end
		--SuperInspect_ShowItems_CheckChecked( SuperInspect_Button_ShowItems );
		if (not SuperInspect_HonorFrame.isShowing) then
			SuperInspect_HonorFrame:Hide();
		else
			SuperInspect_HonorFrame:Show();
		end
		if (CheckInteractDistance("target", 1) and SuperInspect_HonorFrame.isShowing) then
			SuperInspect_HonorFrame:Hide();
			SuperInspect_HonorFrame:Show();
		else
			SuperInspect_HonorFrame:Hide();
		end
	else
		SuperInspect_Button_ShowMobInfo:Hide();
		if (not SuperInspect.player) then
			SI_MI2_BuildMobInfoTooltip( UnitName("target"), UnitLevel("target") );	
		end
		SuperInspect_HonorFrame:Hide();
		SuperInspect.honor = nil;
		SuperInspect.bonus = nil;
		SuperInspect_InvFrame:Hide();
		--SI_AddMessage("HIDING INV: no target");
		SuperInspect_BonusFrameParent:Hide();
		SuperInspect_Button_ShowItems:Disable();
		SuperInspect_Button_ShowItems.isDisabled = 1;
		SuperInspect_Button_ShowItems:Hide();
		SuperInspect_Button_ShowItems.isVisible = nil;
		SuperInspect_Button_ShowHonor:Disable();
		SuperInspect_Button_ShowHonor.isDisabled = 1;
		SuperInspect_Button_ShowHonor:Hide();
		SuperInspect_Button_ShowHonor.isVisible = nil;
		--SuperInspect_Button_ShowBonuses:Hide();
		--SuperInspect_Button_ShowBonuses:Disable();
		--SuperInspect_Button_ShowBonuses.isDisabled = 1;
		--SuperInspect_Button_ShowBonuses.isVisible = nil;
	end

	SuperInspect_SetDefaultStyleScale();
	SuperInspect_UpdateCachedList();
end

--if the player has a target and the inspect frame is visible, check the player's distance to their target
--and disable the honor button if they are too far away
function SuperInspect_Main_OnUpdate()
	if ( SuperInspect.isVisible and SuperInspect_Button_ShowHonor.isVisible ) then
		if ( not CheckInteractDistance("target", 1) and not SuperInspect_HonorFrame.isShowing ) then--and not SuperInspect_HonorFrame.isShowing
			if (SuperInspect.honor) then
			else
				SuperInspect_Button_ShowHonor:Disable();
				SuperInspect_Button_ShowHonor.isDisabled = 1;
			end

			if (SuperInspect.bonus) then

			else
				--SuperInspect_Button_ShowBonuses:Disable();
				--SuperInspect_Button_ShowBonuses.isDisabled = 1;
			end


			--/script SI_AddMessage(CheckInteractDistance("target", 1));
			
		else

			SuperInspect_Button_ShowHonor:Enable();
			SuperInspect_Button_ShowHonor.isDisabled = nil;

			SuperInspect_Button_ShowBonuses:Enable();
			SuperInspect_Button_ShowBonuses.isDisabled = nil;
		

			if ( SI_Save.inrangeupdate == nil) then
				SI_Save.inrangeupdate = false;
				--SI_AddMessage('-- updateing zefix to data');
			end

			if (SI_Save.inrangeupdate == false) then
				SI_Save.inrangeupdate = true;
				SuperInspect_InspectPaperDollFrame_OnShow();
				SI_Save.inrangeupdate = true;
			end
			
		end
	end
end

function SuperInspect_InspectPaperDollItemSlotButton_OnLoad()
	local slotName = string.gsub(this:GetName(), "SuperInspect_", "");
	local id;
	local textureName;
	id, textureName = GetInventorySlotInfo(strsub(slotName,8));
	this:SetID(id);
	local texture = getglobal(this:GetName().."IconTexture");
	texture:SetTexture(textureName);
	this.backgroundTextureName = textureName;
	this:RegisterForDrag("LeftButton");
	this:RegisterForClicks("LeftButtonUp", "RightButtonUp");
	--SI_AddMessage(id.."   "..slotName.."  "..textureName);
end


function SuperInspect_InspectPaperDollItemSlotButton_OnClick(button, ignoreModifiers)
	local itemLink = this.link;
	--DEFAULT_CHAT_FRAME:AddMessage(GetInventoryItemLink("target", this:GetID()));
	--DEFAULT_CHAT_FRAME:AddMessage(this.link);
	if (not itemLink and UnitExists("target")) then
		itemLink = GetInventoryItemLink("target", this:GetID());
	end
	if (not itemLink) then
		return;	
	end
	if ( button == "LeftButton" ) then
		if ( IsControlKeyDown() and not ignoreModifiers ) then
			DressUpItemLink(itemLink);
		elseif ( IsShiftKeyDown() and not ignoreModifiers ) then
			if ( ChatFrameEditBox:IsVisible() ) then
				local link = "|c"..this.c.."|H"..itemLink.."|h["..GetItemInfo(itemLink).."]|h|r";
				ChatFrameEditBox:Insert(link);
			end
		elseif (UnitPVPName("player") == SuperInspectFrameHeader_Name:GetText()) then
			PickupInventoryItem(this:GetID());
		end
	elseif ( button == "RightButton" and UnitPVPName("player") == SuperInspectFrameHeader_Name:GetText()) then
		UseInventoryItem(this:GetID());
	end
end

function SuperInspect_InspectPaperDollFrame_OnShow()
	if (UnitExists("target") or (SuperInspect_InvFrame.unit == "SI_FORCE")) then
		this.datafound = false;
		SuperInspect_InspectPaperDollItemSlotButton_Update(SuperInspect_InspectHeadSlot);
		SuperInspect_InspectPaperDollItemSlotButton_Update(SuperInspect_InspectNeckSlot);
		SuperInspect_InspectPaperDollItemSlotButton_Update(SuperInspect_InspectShoulderSlot);
		SuperInspect_InspectPaperDollItemSlotButton_Update(SuperInspect_InspectBackSlot);
		SuperInspect_InspectPaperDollItemSlotButton_Update(SuperInspect_InspectChestSlot);
		SuperInspect_InspectPaperDollItemSlotButton_Update(SuperInspect_InspectShirtSlot);
		SuperInspect_InspectPaperDollItemSlotButton_Update(SuperInspect_InspectTabardSlot);
		SuperInspect_InspectPaperDollItemSlotButton_Update(SuperInspect_InspectWristSlot);
		SuperInspect_InspectPaperDollItemSlotButton_Update(SuperInspect_InspectHandsSlot);
		SuperInspect_InspectPaperDollItemSlotButton_Update(SuperInspect_InspectWaistSlot);
		SuperInspect_InspectPaperDollItemSlotButton_Update(SuperInspect_InspectLegsSlot);
		SuperInspect_InspectPaperDollItemSlotButton_Update(SuperInspect_InspectFeetSlot);
		SuperInspect_InspectPaperDollItemSlotButton_Update(SuperInspect_InspectFinger0Slot);
		SuperInspect_InspectPaperDollItemSlotButton_Update(SuperInspect_InspectFinger1Slot);
		SuperInspect_InspectPaperDollItemSlotButton_Update(SuperInspect_InspectTrinket0Slot);
		SuperInspect_InspectPaperDollItemSlotButton_Update(SuperInspect_InspectTrinket1Slot);
		SuperInspect_InspectPaperDollItemSlotButton_Update(SuperInspect_InspectMainHandSlot);
		SuperInspect_InspectPaperDollItemSlotButton_Update(SuperInspect_InspectSecondaryHandSlot);
		SuperInspect_InspectPaperDollItemSlotButton_Update(SuperInspect_InspectRangedSlot);
		if (not this.datafound) then
			if (CheckInteractDistance("target", 1)) then
				SuperInspect_InRangeFrame_Text:SetText('Player in Range');
				SuperInspect_InRangeFrame_Text2:SetText('but no data found ?!');		
			else
				SuperInspect_InRangeFrame_Text:SetText('Player not in Range');
				SuperInspect_InRangeFrame_Text2:SetText('Need aprox. 10 Yards to inspect.');
				--SI_AddMessage("SHOW INV: set to 1 a");
				SI_Save.items = 1;
			end
		else
			
			if (CheckInteractDistance("target", 1)) then
			else
				SI_Save.items = 1;
				--SI_AddMessage("SHOW INV: set to 1 b");		
			end
		end
	end

	
	if (SI_Save.items and (SI_Save.items == 1)) then
		SuperInspect_Button_ShowItems:SetText(SI_ITEMSHIDE);
	end
	
	if (SuperInspect_InvFrame.unit == "SI_FORCE") then
		--SuperInspect_InvFrame.unit = "";
		if (SI_LOCAL_USERS_ITEM_CACHE[SuperInspect_InvFrame.unit_force]) then
			SuperInspectFrameHeader_Guild:SetText(SI_LOCAL_USERS_ITEM_CACHE[SuperInspect_InvFrame.unit_force]['guild']);
			SuperInspectFrameHeader_Info:SetText(SI_LOCAL_USERS_ITEM_CACHE[SuperInspect_InvFrame.unit_force]['info']);
			SuperInspectFrameHeader_Realm:SetText(SI_LOCAL_USERS_ITEM_CACHE[SuperInspect_InvFrame.unit_force]['realm']);
			SuperInspectFrameHeader_Name:SetText(SuperInspect_InvFrame.unit_force);
			SuperInspect_ModelFrame:SetModelScale(1);
			SuperInspect_ModelFrame:ClearModel();			
		end
	end
	
	--SuperInspect_Button_ShowBonuses:Enable();
	SuperInspect_UpdateCachedList();
	SuperInspectItemBonusesButton_BuildTooltip();
end

function SuperInspect_ToggleCachedPlayers()
	if (SIInfoFrame:IsVisible()) then
		SIInfoFrame:Hide();
	else
		SIInfoFrame:Show();	
		SuperInspect_UpdateCachedList();
	end
end

function SuperInspect_UpdateCachedList()
	local i = 1;
	local maxitems = 8;
	local countmax = 0;
	local internalcount = 1;
	for index, value in SI_LOCAL_USERS_ITEM_CACHE do
			if (SI_LOCAL_USERS_ITEM_CACHE[index]['items']) then
				countmax = countmax + 1;
			end
	end
					
	FauxScrollFrame_Update(SIInfoScrollFrame,countmax,maxitems,40);
	for index, value in SI_LOCAL_USERS_ITEM_CACHE do
			if (SI_LOCAL_USERS_ITEM_CACHE[index]['items']) then
				lineplusoffset = FauxScrollFrame_GetOffset(SIInfoScrollFrame);
				--SI_AddMessage(">"..(lineplusoffset + 1).." vs "..i.." vs "..(lineplusoffset + 1 + maxitems));
				if (((lineplusoffset + 1) <= i) and ((lineplusoffset + 1 + maxitems) > i)) then
					txt = getglobal("SIInfoPlayer"..internalcount.."Name");
					txt:SetText(index);

					local newtxt = "";--SuperInspect_InvFrame.unit_force]['realm'];
					if (SI_LOCAL_USERS_ITEM_CACHE[index]['info'] == " ") then
						newtxt = SI_LOCAL_USERS_ITEM_CACHE[index]['guild'];			
					else
						newtxt = SI_LOCAL_USERS_ITEM_CACHE[index]['info'];					
					end
					txt = getglobal("SIInfoPlayer"..internalcount.."Info");
					txt:SetText(newtxt);	
					txt = getglobal("SIInfoPlayer"..internalcount.."Realm");
					if (not (SI_LOCAL_USERS_ITEM_CACHE[index]['realm'] == " ")) and (SI_LOCAL_USERS_ITEM_CACHE[index]['realm']) then
						txt:SetText(SI_LOCAL_USERS_ITEM_CACHE[index]['realm']);	
					else
						txt:SetText(" ");
					end
					frm = getglobal("SIInfoPlayer"..internalcount);
					frm:SetBackdropColor(1,1, 1, 0);
					if (index == SuperInspect_InvFrame.unit_force) and (SuperInspect_InvFrame.unit == "SI_FORCE") then
						frm:SetBackdropColor(0.5,0.5, 0.5, 0.8);
					end
					internalcount = internalcount + 1;
				end
				i = i + 1;
				
			end
	end
	
	if ( i > maxitems ) then
			SIInfoScrollFrameScrollBar:Show();
			--SIInfoScrollFrameScrollBar:SetPoint("TOPLEFT", SIInfoScrollFrame, "TOPRIGHT", 8, -3);
	else
			SIInfoScrollFrameScrollBar:Hide();
	end
	SIInfoScrollFrame:UpdateScrollChildRect();	
	
end

function SuperInspect_InspectPaperDollItemSlotButton_Update(button)
	local unit = SuperInspect_InvFrame.unit;
	local link = nil;
	if (not button or not unit) then
		return;	
	end
	local textureName = nil; 
	
	if not (unit == "SI_FORCE") then
		textureName = GetInventoryItemTexture(unit, button:GetID());
	end
		
	local bgBorder = getglobal(button:GetName().."BGTexture");	
	
	if ( textureName ) then
		SetItemButtonTexture(button, textureName);
		SetItemButtonCount(button, GetInventoryItemCount(unit, button:GetID()));
		button.hasItem = 1;
	else
		SetItemButtonTexture(button, button.backgroundTextureName);
		SetItemButtonCount(button, 0);
		button.hasItem = nil;
		bgBorder:Hide();
	end

	
	
	--try to load data from cachei
	if (SI_Save.playercache == nil) then
		SI_Save.playercache = true;
	end
	
	if (SI_Save.playercache) then
		local unitname = "";
		if (unit == "SI_FORCE") then
			unitname = SuperInspect_InvFrame.unit_force;
		else
			unitname = UnitName(unit);
			if (not unitname) then
				unitname = UnitName("target");
			end
		end

		if ((CheckInteractDistance("target", 1) and (not (unit == "SI_FORCE")))) then
			if (UnitIsPlayer("target") and UnitIsFriend("player","target")) then
				SuperInspect_InRangeFrame_Text:SetText(SI_TEXT_CACHEPLAYER);
				SuperInspect_InRangeFrame_Text2:SetText(SI_TEXT_CACHEPLAYERCACHED);
				if (not SI_LOCAL_USERS_ITEM_CACHE[unitname]) then
					SI_LOCAL_USERS_ITEM_CACHE[unitname] = {};
				end
				if (not SI_LOCAL_USERS_ITEM_CACHE[unitname]['items'] ) then
					SI_LOCAL_USERS_ITEM_CACHE[unitname]['items'] = {};
				end
				SI_LOCAL_USERS_ITEM_CACHE[unitname]['items'][button] = GetInventoryItemLink("target", button:GetID()); 
				SI_LOCAL_USERS_ITEM_CACHE[unitname]['cache_date'] = time();
				this.datafound  = true;
			end
		else
			if (SI_LOCAL_USERS_ITEM_CACHE[unitname]) then
				--SI_AddMessage('try'..unitname);
				if (SI_LOCAL_USERS_ITEM_CACHE[unitname]['items'] ) then
					--SI_AddMessage('try _items');
					if (SI_LOCAL_USERS_ITEM_CACHE[unitname]['items'][button]) then
						--SI_AddMessage('try _items button');
						link = SI_LOCAL_USERS_ITEM_CACHE[unitname]['items'][button]; 
						local mylink = string.sub(link, string.find(link, "item:%d+:%d+:%d+:%d+"));
						--SI_AddMessage('found_itemslink_a'..mylink);
						local itemName, itemLink, itemQuality, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture = GetItemInfo(mylink);
						textureName = itemTexture;
						link = itemLink;
						SetItemButtonCount(button, itemStackCount);
						SetItemButtonTexture(button, textureName);
						button.hasItem = 1;			
						local ttable = SI_LOCAL_USERS_ITEM_CACHE[unitname]['cache_date'];
						SuperInspect_InRangeFrame_Text:SetText(SI_TEXT_CACHEPLAYERFROMCACHE);
						SuperInspect_InRangeFrame_Text2:SetText("[" .. tonumber(date("%I",ttable)) .. date(":%M",ttable) .. "] ");	
						--SI_AddMessage('found _items button'..itemName);	
						if (unit == "SI_FORCE") then
							SuperInspect_InRangeFrame:Show();
						end
						local r, g, b, hex = GetItemQualityColor(itemQuality);
						bgBorder:SetVertexColor(r, g, b, 1); --r,g,b,a = FontString:GetTextColor()	
						bgBorder:Show();					
						this.datafound  = true;
					end
				end		
			end;
		
		end
	else
		SuperInspect_InRangeFrame:Hide();
	end
	
	if ( not textureName ) then
			SI_Save.itemscached = false;
	end	
	
	--SuperInspect_InRangeFrame_Text:SetText('Player not in Range');
	--SuperInspect_InRangeFrame_Text2:SetText('Need aprox. 5 Yards to inspect.');
	--SI_LOCAL_USERS_ITEM_CACHE
	--CheckInteractDistance("target", 1) 
	
	--[[
	-- removed its for the 1.11 fix. but not longer working with 1.12 :(
	
	-- other char is out of range... try to parse tooltips and get correct item from a itemdatabase mod.
	if ( not textureName ) then
		SI_Save.itemscached = false;
		SuperInspectTTScan:SetOwner(this, "ANCHOR_NONE");
		SuperInspectTTScan:ClearLines();
		if ( SuperInspectTTScan:SetInventoryItem(SuperInspect_InvFrame.unit, button:GetID())) then
			local line = getglobal("SuperInspectTTScanTextLeft1");
			local iname = line:GetText();
			if (not iname) then
				local iname = line:GetText();
			end
			if (not iname) then
				iname = "";
			end

			local r, g, b;
			--use by default temp texture
			textureName = 'Interface\\Icons\\INV_Misc_QuestionMark.blp';
			SetItemButtonCount(button, 0);


			--check first own item cache
			if (SI_LOCAL_ITEM_CACHE) then
				--SI_AddMessage('--search '..iname..' in local cache');
				if (SI_LOCAL_ITEM_CACHE[iname]) then
					local itemName, itemLink, itemQuality, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture = GetItemInfo(SI_LOCAL_ITEM_CACHE[iname]);
					textureName = itemTexture;
					link = itemLink;
					SetItemButtonCount(button, itemStackCount);
				end
			end

			--check for lootlink! quite fast
			if ((ItemLinks) and (textureName == 'Interface\\Icons\\INV_Misc_QuestionMark.blp')) then
				--SI_AddMessage('--search '..iname..' in lootlink');
				if (ItemLinks[iname]) then
					local itemName, itemLink, itemQuality, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture = GetItemInfo('item:'..ItemLinks[iname]["i"]);
					textureName = itemTexture;
					link = itemLink;
					SetItemButtonCount(button, itemStackCount);
				end
			end

			--check for itemsync! if you have a big database not soo fast! :(
			if (((ISyncDB_Names) and (textureName == 'Interface\\Icons\\INV_Misc_QuestionMark.blp'))) then
				--SI_AddMessage('--search '..iname..' in itemsync');
				for index, value in ISyncDB_Names do
					if(string.lower(value) == string.lower(iname)) then
						local name_X, link_X, quality_X, minLevel_X, class_X, subclass_X, maxStack_X, equipType_X, iconTexture_X  = GetItemInfo("item:"..index..":0:0:0");
						textureName = iconTexture_X;
						link = link_X;
						SetItemButtonCount(button, maxStack_X);
					end
				end
			end

			--check wowecon! quite fast
			if ((WOWEcon_Items) and (textureName == 'Interface\\Icons\\INV_Misc_QuestionMark.blp')) then
				--SI_AddMessage('--search '..iname..' in WOWEcon_Items');
				if (WOWEcon_Items[iname]) then
					local row = WOWEcon_Items[iname];
					local id = row[2];
					local itemName, itemLink, itemQuality, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture = GetItemInfo("item:"..id..":0:0:0");
					textureName = itemTexture;
					link = itemLink;
					SetItemButtonCount(button, itemStackCount);
				end

			end

			--check for Linkerator!  quite fast
			if ((FLT_ItemLinks) and (textureName == 'Interface\\Icons\\INV_Misc_QuestionMark.blp')) then
				if (FLT_ItemLinks[string.lower(iname)]) then
					local itemInfo = "";
					if type(FLT_ItemLinks[string.lower(iname)]) == "string" or type(FLT_ItemLinks[string.lower(iname)]) == "number" then
						itemInfo = FLT_ItemLinks[string.lower(iname)]
					else
						itemInfo = FLT_ItemLinks[string.lower(iname)][1]
					end
					local itemName, itemLink, itemQuality, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture = GetItemInfo(itemInfo);
					textureName = itemTexture;
					link = itemLink;
					SetItemButtonCount(button, itemStackCount);
				end
			end 

			-- check for ItemsMatrix! quite fast :]
			if ((IMDB) and (textureName == 'Interface\Icons\INV_Misc_QuestionMark.blp')) then
				--SI_AddMessage('--search '..iname..' in itemsmatrix');
				if (IMDB[iname]) then
					local itemName, itemLink, itemQuality, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture = GetItemInfo("item:"..IM_GetData(IMDB[iname], "item"));
					textureName = itemTexture;
					link = itemLink;
					SetItemButtonCount(button, itemStackCount);
				end
			end 

			--check KC_Items not working :(
			--if ((KC_ItemsDB) and (textureName == 'Interface\\Icons\\INV_Misc_QuestionMark.blp')) then

			--end

			-- cant get data
			if ((textureName == 'Interface\\Icons\\INV_Misc_QuestionMark.blp') or (textureName == "")  or (not textureName))then
				SI_Save.inrangeupdate = false;
				textureName = 'Interface\\Icons\\INV_Misc_QuestionMark.blp';
				--SI_AddMessage('--cant get item! '..iname..' from a database!');
			end


			SetItemButtonTexture(button, textureName);
			button.hasItem = 1;
			r, g, b = line:GetTextColor() 
			bgBorder:SetVertexColor(r, g, b, 1); --r,g,b,a = FontString:GetTextColor()	
			bgBorder:Show();
			SuperInspectTTScan:Hide();
		end

	end
	
]]--


	--SI_AddMessage(id.."   "..slotName.."  "..textureName);
	if ( GameTooltip:IsOwned(button) ) then
		--SI_AddMessage("GTT IS OWNED");
		if ( texture ) then
			--SI_AddMessage(texture);
			if ( not GameTooltip:SetInventoryItem(SuperInspect_InvFrame.unit, button:GetID()) ) then
				--GameTooltip:SetText(TEXT(getglobal(strupper(strsub(button:GetName(), 8)))));
			end
		else
			GameTooltip:Hide();
		end
	end
	if (UnitExists("target") or (unit == "SI_FORCE")) then
		local line = getglobal("SuperInspect_TTTextLeft1");
		local r, g, b;

		if ((not link) and (not (unit == "SI_FORCE"))) then
			link = GetInventoryItemLink("target", button:GetID());
			if (link) then
			--SI_AddMessage("load link:"..link);
			else
			--SI_AddMessage("load link faild ;(");
			end
		end

		SuperInspect_TT:ClearLines();
		local hasfounditemonslot = false;
		if (not (unit == "SI_FORCE")) then
			hasfounditemonslot = SuperInspect_TT:SetInventoryItem("target", button:GetID());	
		end
		if (link) then
			local itemCode = string.sub(link, string.find(link, "item:%d+:%d+:%d+:%d+"));
			local itemName, itemLink, itemQuality, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture = GetItemInfo(itemCode);
			SuperInspectTTScan:SetOwner(this, "ANCHOR_NONE");
			SuperInspectTTScan:ClearLines();
			SuperInspect_TT:ClearLines();			
			-- if not player user hyperlink else use setinventoryitem. (prevents loosing durability infos)
			
			if ((unit == "SI_FORCE") or (not UnitIsUnit("target", "player"))) then
				SuperInspectTTScan:SetHyperlink(itemCode);
				SuperInspect_TT:SetHyperlink(itemCode);
			else
				SuperInspectTTScan:SetInventoryItem(SuperInspect_InvFrame.unit, button:GetID());
				SuperInspect_TT:SetInventoryItem(SuperInspect_InvFrame.unit, button:GetID());			
			end
			--SI_AddMessage("itemCode="..itemCode);
			hasfounditemonslot = true;
			
			local line_scan = getglobal("SuperInspectTTScanTextLeft1");
			local iname = line_scan:GetText();
			if (not iname) then
				iname = "";
			end
			SuperInspectTTScan:Hide();

			-- do local cache!
			if (SI_LOCAL_ITEM_CACHE) then
				SI_LOCAL_ITEM_CACHE[iname] = itemCode;
				--SI_AddMessage("cache "..iname.." with "..link);
			end
			--SI_AddMessage("link");
			--SI_AddMessage(link);
			--r, g, b = line:GetTextColor() 
			local r, g, b, hex = GetItemQualityColor(itemQuality);
			bgBorder:SetVertexColor(r, g, b, 1); --r,g,b,a = FontString:GetTextColor()	
			bgBorder:Show();
		end

		local bgTex = getglobal(button:GetName().."BGTexture");
		if (SI_Save.itembg == 1) then
			bgTex:SetTexture("Interface\\Addons\\SuperInspect\\gfx\\ItemOverlay_Tab");
		elseif (SI_Save.itembg == 2) then
			bgTex:Hide();
		else
			getglobal(button:GetName().."BGTexture"):SetTexture("Interface\\Addons\\SuperInspect\\gfx\\ItemOverlay");
		end
		if ((unit == "SI_FORCE") or (not SuperInspect.bonus or SuperInspect.bonus ~= UnitName("target"))) then
			if (not SuperInspectFrame.buts) then
				SuperInspectFrame.buts = 0;	
			end
			SuperInspectFrame.buts = SuperInspectFrame.buts + 1;
			if (SuperInspectFrame.buts == 1) then
				SuperInspect_ItemBonuses_bonuses = {};
				SuperInspect_ItemBonuses_currentset = "";
				SuperInspect_ItemBonuses_sets = {};
				SuperInspect_ItemBonuses_coh = {};
				SuperInspect_ItemBonuses_use = {};
				SuperInspect_ItemBonuses_active = nil;		
			end
			if (link) then
				SI_AddMessage("|cffC0C0C0"..SuperInspectFrame.buts..">"..link);
			else
				SI_AddMessage("|cffC0C0C0"..SuperInspectFrame.buts..">?");
			end
			button.link = nil;
			if (not link) then
				if (SuperInspectFrame.buts == 19) then
					--DEFAULT_CHAT_FRAME:AddMessage("OnShow");
					SuperInspectFrame.buts = nil;
					if ( CheckInteractDistance("target", 1) ) then
						SuperInspect.bonus = UnitName("target");
						SuperInspectItemBonusesButton_BuildTooltip();
					end
					return;	
				end

			end
			--if (SI_Save.debug) then
			--	if (not SI_Save["debugtext"]) then
			--		SI_Save["debugtext"] = {};	
			--	end	
			--	SI_Save["debugtext"]["link"] = link;
			--end
			
			--"|cffa335ee|Hitem:18282:2523:0:0|h[Core Marksman Rifle]|h|r"
			if (link) then
				
				nstart, nend = string.find(link,'item:');
				if ((nstart) and (nstart == 1) and (nend == 5)) then
					local itemName, itemLink, itemQuality, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture  = GetItemInfo(link);
					local r, g, b, hex = GetItemQualityColor(itemQuality);
					button.link = link;
					--SI_AddMessage("set linkA:"..button.link);
					button.c = string.sub(hex,3);
				else
					for color, item in string.gfind(link, "|c(%x+)|Hitem:(%d+:%d+:%d+:%d+)|h%[.-%]|h|r") do
						if( item and item ~= "" ) then
							button.link = "item:"..string.gsub(item, "^(%d+):(%d+):(%d+):(%d+)$", "%1:%2:%3:%4");
							--SI_AddMessage("set linkB:"..button.link);
							button.c = color;
						end
					end
				end
			end

			--button.iteml = {};
			--button.itemr = {};
			local line, lineR, text;
			local durtext = getglobal(button:GetName().."DurabilityNumber");
			durtext:Hide();
			if (hasfounditemonslot) then
				--SI_AddMessage('found item!');
			else
				--SI_AddMessage('found no!');
			end
			
			
			
			for i=1, (SuperInspect_TT:NumLines()), 1 do
				line = getglobal("SuperInspect_TTTextLeft"..i);
				if (not line or not line:GetText()) then
					durtext:Hide();
					return;
				else
					if (not SI_Save.durabilityoff) then
						SuperInspect_GetItemDurability(button, line:GetText());		
					end	
					SuperInspectItemBonuses_ScanLine(line:GetText(), button:GetID());
				end
			end
			--if (SuperInspect_ItemBonuses_sets and table.getn( SuperInspect_ItemBonuses_sets ) >= 1) then
				
			--end
			if (SuperInspectFrame.buts == 19) then
				--DEFAULT_CHAT_FRAME:AddMessage("OnShow");
				SuperInspectFrame.buts = nil;
				if (UnitName("target") ~= UnitName("player")) then
					SuperInspectItemBonuses_GetSetBonuses();	
				end
				SuperInspect.bonus = UnitName("target");
				SuperInspectItemBonusesButton_BuildTooltip();
			end			
		end
	end
end

--[[ MINE
function SuperInspect_BonusInfo_StartCompare()	
		
		SuperInspect_ItemBonusesNameCompare:SetText(SuperInspectFrameHeader_Name:GetText());
		SuperInspect_ItemBonusesGuildCompare:SetText(SuperInspectFrameHeader_Guild:GetText().."\n"..SuperInspectFrameHeader_Info:GetText());
		SuperInspect_ItemBonusesGuildCompare:SetTextColor(1, 1, 1);

		--SuperInspectFrame_Name
		--SuperInspectFrame_Guild
		--SuperInspectFrame_Info

		for i=1, 5, 1 do
			local resTextorg = getglobal("SuperInspect_MagicResText"..i);
			local resText = getglobal("SuperInspect_MagicResTextCompare"..i);
			resText:Hide();
			if (resTextorg:IsVisible()) then
				resText:SetText(resTextorg:GetText());	
				resText:Show();
			end
		end
		SuperInspect_ItemBonusesTextCompare:SetText(SuperInspect_ItemBonusesText:GetText());
		SuperInspect_ItemBonusesTextRCompare:SetText(SuperInspect_ItemBonusesTextR:GetText());
		SuperInspect_ItemBonusesFrameCompare:Show();		
		--local iHeight = SuperInspect_ItemBonusesTextCompare:GetHeight();
		SuperInspect_ItemBonusesFrameCompare:SetHeight(SuperInspect_ItemBonusesTextCompare:GetHeight() + 116); 
end]]

function SuperInspect_BonusInfo_StartCompare()
	local cat = "";
	local text = "";
	local channel,chatnumber = ChatFrameEditBox.chatType
	--DEFAULT_CHAT_FRAME:AddMessage("clicked!");	
	if ( IsShiftKeyDown() and ChatFrameEditBox:IsVisible()) then
		if channel=="WHISPER" then
			chatnumber = ChatFrameEditBox.tellTarget
		elseif channel=="CHANNEL" then
			chatnumber = ChatFrameEditBox.channelTarget
		end
		--DEFAULT_CHAT_FRAME:AddMessage("reporting to"..channel);

--		DEFAULT_CHAT_FRAME:AddMessage(SuperInspect_ItemBonusesText:GetText());
		text = "Bonus de "..SuperInspectFrameHeader_Name:GetText();
--		DEFAULT_CHAT_FRAME:AddMessage(text);
		SendChatMessage(text,channel,nil,chatnumber);
		for i,e in SI_IB_EFFECTS do

			if(SuperInspect_ItemBonuses_bonuses[e.effect]) then
				if(e.format) then
		   			val = format(e.format,SuperInspect_ItemBonuses_bonuses[e.effect]);
				else
					val = SuperInspect_ItemBonuses_bonuses[e.effect];
				end
			
				if(e.cat ~= cat) then
					cat = e.cat;
					text = "  "..getglobal("SI_IB_CAT_"..cat)..":";
					SendChatMessage(text,channel,nil,chatnumber);
				end
				text = "    "..e.name.." = "..val;
				SendChatMessage(text,channel,nil,chatnumber);
			end
		end
		if (SuperInspect_ItemBonuses_sets and table.getn( SuperInspect_ItemBonuses_sets ) >= 1) then
			text = "  "..SI_SETS..":";
			SendChatMessage(text,channel,nil,chatnumber);
			for i=1, table.getn( SuperInspect_ItemBonuses_sets ), 1 do
				text="     "..SuperInspect_ItemBonuses_sets[i].s.." ("..SuperInspect_ItemBonuses_sets[i].n.."/"..SuperInspect_ItemBonuses_sets[i].m..")";
				SendChatMessage(text,channel,nil,chatnumber);
			end	
		end		
	else		
		SuperInspect_ItemBonusesNameCompare:SetText(SuperInspectFrameHeader_Name:GetText());
		SuperInspect_ItemBonusesGuildCompare:SetText(SuperInspectFrameHeader_Guild:GetText().."\n"..SuperInspectFrameHeader_Info:GetText());
		SuperInspect_ItemBonusesGuildCompare:SetTextColor(1, 1, 1);

		--SuperInspectFrame_Name
		--SuperInspectFrame_Guild
		--SuperInspectFrame_Info

		for i=1, 5, 1 do
			local resTextorg = getglobal("SuperInspect_MagicResText"..i);
			local resText = getglobal("SuperInspect_MagicResTextCompare"..i);
			resText:Hide();
			if (resTextorg:IsVisible()) then
				resText:SetText(resTextorg:GetText());	
				resText:Show();
			end
		end

		newtext = SuperInspect_ItemBonusesText:GetText();
		newtextr = SuperInspect_ItemBonusesTextR:GetText();
		nstart, nend = string.find(newtext, SI_IB_TEXT_MISSINGDATA);
		if (nend) and (nend > 0) then
			newtext = string.sub(newtext,nend+3);
			newtextr = string.sub(newtextr,4);
		end

		SuperInspect_ItemBonusesTextCompare:SetText(newtext);
		SuperInspect_ItemBonusesTextRCompare:SetText(newtextr);
		SuperInspect_ItemBonusesFrameCompare:Show();		
		--local iHeight = SuperInspect_ItemBonusesTextCompare:GetHeight();
		SuperInspect_ItemBonusesFrameCompare:SetHeight(SuperInspect_ItemBonusesTextCompare:GetHeight() + 116); 
	end
end

function SuperInspect_GetItemDurability(button, line)
	local text = getglobal(button:GetName().."DurabilityNumber");
	if (not UnitIsUnit("target", "player")) then
		text:Hide();
		--SI_AddMessage('get dura hide');
		return;
	end
	
	if(string.sub(line,0,string.len(SI_DURABILITY)) == SI_DURABILITY) then
		--SI_AddMessage(SI_DURABILITY);
		button.d1, button.d2 = nil, nil;
		_, _, button.d1, button.d2 = string.find(line, SI_DURABILITYPATTERN);
		if (button.d1 and button.d2) then
			--SI_AddMessage(button.d1.." / "..button.d2);
			text:SetText(button.d1.."/"..button.d2);
			local fraction = (button.d1 / button.d2);
			if (fraction > 0.8) then
				--text:SetTextColor( 1, 1, 1 );
				--text:SetText("");
				return;
			elseif (fraction > 0.6) then
				text:SetTextColor( 1, 1, 0.3 );
				--text:SetText("=");
			elseif (fraction > 0.4) then
				text:SetTextColor( 1, 0.6, 0 );
				--text:SetText("==");
			elseif (fraction > 0.2) then
				text:SetTextColor( 1, 0.3, 0 );
				--text:SetText("===");
			else
				text:SetTextColor( 1, 0, 0 );
				--text:SetText("====");
			end
			text:Show();
		end
	else
		--SI_AddMessage('get dura not found'..line);
	end
end

SuperInspect_ItemBonuses_bonuses = {};
SuperInspect_ItemBonuses_currentset = "";
SuperInspect_ItemBonuses_sets = {};
SuperInspect_ItemBonuses_coh = {};
SuperInspect_ItemBonuses_use = {};
SuperInspect_ItemBonuses_active = nil;

function SuperInspectItemBonuses_ScanLine(line, id)
	local tmpStr, found;
	
	--SI_AddMessage(line);
	local color = SuperInspect_RGBToHexColor( SuperInspect_TTTextLeft1:GetTextColor() );
	if (SuperInspect.name and SuperInspect.name == UnitName("player")) then
		-- Check for "Set: "
		if(string.sub(line,0,string.len(SI_IB_SET_PREFIX)) == SI_IB_SET_PREFIX and SuperInspect_ItemBonuses_currentset ~= "") then
			local fnd = nil;
			for i=1, table.getn( SuperInspect_ItemBonuses_sets ), 1 do
				if (SuperInspect_ItemBonuses_sets[i].s == SuperInspect_ItemBonuses_currentset) then
					if (SuperInspect_ItemBonuses_sets[i].n > 1) then
					return;
					end
				end
			end
			tmpStr = string.sub(line,string.len(SI_IB_SET_PREFIX)+1);
			SuperInspectItemBonuses_ScanPassive(tmpStr);
		end
	end
	-- Check for "Equip: "
	if(string.sub(line,0,string.len(SI_IB_EQUIP_PREFIX)) == SI_IB_EQUIP_PREFIX) then

		tmpStr = string.sub(line,string.len(SI_IB_EQUIP_PREFIX)+1);
		SI_AddMessage("equip? :"..tmpStr);
		SuperInspectItemBonuses_ScanPassive(tmpStr);

	-- Check for "Chance on hit: "
	elseif(string.sub(line,0,string.len(SI_IB_COH_PREFIX)) == SI_IB_COH_PREFIX) then
		tmpStr = string.sub(line,string.len(SI_IB_COH_PREFIX)+1);
		local item = color..SuperInspect_TTTextLeft1:GetText();
		--DEFAULT_CHAT_FRAME:AddMessage("FOUND COH in: "..item.." :: "..tmpStr);
		if (SuperInspect_ItemBonuses_coh) then
			local fnd = nil;
			local j = 1;
			for index, value in SuperInspect_ItemBonuses_coh do
				if (index == item) then
					tinsert(SuperInspect_ItemBonuses_coh[index], tmpStr);	
					fnd = 1;
					return;	
				end
			end	
			if (not fnd) then
				SuperInspect_ItemBonuses_coh[item] = {};
				tinsert(SuperInspect_ItemBonuses_coh[item], tmpStr);
			end
		else
			SuperInspect_ItemBonuses_coh[item] = {};
			tinsert(SuperInspect_ItemBonuses_coh[item], tmpStr);
		end
	-- Check for "Use: "
	elseif(string.sub(line,0,string.len(SI_IB_USE_PREFIX)) == SI_IB_USE_PREFIX) then

		tmpStr = string.sub(line,string.len(SI_IB_USE_PREFIX)+1);
		local item = color..SuperInspect_TTTextLeft1:GetText();
		--DEFAULT_CHAT_FRAME:AddMessage("FOUND USE in: "..item.." :: "..tmpStr);
		if (SuperInspect_ItemBonuses_use) then
			local fnd = nil;
			local j = 1;
			for index, value in SuperInspect_ItemBonuses_use do
				if (index == item) then
					tinsert(SuperInspect_ItemBonuses_use[index], tmpStr);	
					fnd = 1;
					return;	
				end
			end	
			if (not fnd) then
				SuperInspect_ItemBonuses_use[item] = {};
				tinsert(SuperInspect_ItemBonuses_use[item], tmpStr);
			end
		else
			SuperInspect_ItemBonuses_coh[item] = {};
			tinsert(SuperInspect_ItemBonuses_coh[item], tmpStr);
		end
	-- any other line (standard stats, enchantment, set name, etc.)
	else
		-- Check for set name
		local max;
		_, _, tmpStr, max = string.find(line, SI_IB_SETNAME_PATTERN);
		if(tmpStr) then
			SuperInspect_ItemBonuses_currentset = tmpStr;
			if (SuperInspect_ItemBonuses_sets) then
				local fnd = nil;
				local j = 1;
				for i=1, table.getn( SuperInspect_ItemBonuses_sets ), 1 do
					if (SuperInspect_ItemBonuses_sets[i].s == tmpStr) then
						SuperInspect_ItemBonuses_sets[i].n = SuperInspect_ItemBonuses_sets[i].n + 1;
						fnd = 1;
						return;	
					end
					j = j + 1;
				end	
				if (not fnd) then
					tinsert(SuperInspect_ItemBonuses_sets, tmpStr);	
					SuperInspect_ItemBonuses_sets[j] = {};
					SuperInspect_ItemBonuses_sets[j].s = tmpStr;
					SuperInspect_ItemBonuses_sets[j].n = 1;
					SuperInspect_ItemBonuses_sets[j].m = max;
					SuperInspect_ItemBonuses_sets[j].i = id;
					SuperInspect_ItemBonuses_sets[j].c = color;
				end
			else
				--tinsert(SuperInspect_ItemBonuses_sets, tmpStr);
				SuperInspect_ItemBonuses_sets[1] = {};
				SuperInspect_ItemBonuses_sets[1].s = tmpStr;
				SuperInspect_ItemBonuses_sets[1].n = 1;
				SuperInspect_ItemBonuses_sets[1].m = max;
				SuperInspect_ItemBonuses_sets[1].i = id;
				SuperInspect_ItemBonuses_sets[1].c = color;
			end		
		else
			found = SuperInspectItemBonuses_ScanGeneric(line);
			if(not found) then
				SuperInspectItemBonuses_ScanOther(line);
			end;
		end
	end
end

function SuperInspectItemBonuses_GetSetBonuses()
	local id, cnum, nnum, tmpStr, line;
	for i=1, table.getn( SuperInspect_ItemBonuses_sets ), 1 do
		if (SuperInspect_ItemBonuses_sets[i].n > 1) then
			id = SuperInspect_ItemBonuses_sets[i].i;
			--cnum = SuperInspect_ItemBonuses_sets[i].n;
			local check_inv = SuperInspect_TT:SetInventoryItem("target", id);
			for j=2, (SuperInspect_ItemBonuses_sets[i].n), 1 do
				for k=1, (SuperInspect_TT:NumLines()), 1 do
					line = getglobal("SuperInspect_TTTextLeft"..k);
					if (not line or not line:GetText()) then
					else		
						if(string.find(line:GetText(), SI_IB_MULTISET_PREFIX)) then
							_, _, nnum, tmpStr = string.find(line:GetText(), SI_IB_MULTISET_PREFIX.."(.*)");
							SI_AddMessage(RED_FONT_COLOR_CODE.."nnum = "..nnum.."  cnum = "..j.."  : ");
							if (tmpStr and nnum and tonumber(nnum) == j) then
								if (not SuperInspect_ItemBonuses_sets[i]["t"] or not SuperInspect_ItemBonuses_sets[i]["t"][nnum]) then
									SuperInspectItemBonuses_ScanPassive(tmpStr);
									if (not SuperInspect_ItemBonuses_sets[i]["t"]) then
										SuperInspect_ItemBonuses_sets[i]["t"] = {};
									end			
							

									SuperInspect_ItemBonuses_sets[i]["t"][nnum] = tmpStr;
									SI_AddMessage(RED_FONT_COLOR_CODE.."SET :"..(SuperInspect_ItemBonuses_sets[i].s).." ("..(SuperInspect_ItemBonuses_sets[i].n).."/"..(SuperInspect_ItemBonuses_sets[i].m)..") - "..tmpStr);						
								else
									SI_AddMessage(RED_FONT_COLOR_CODE.."SET : tried adding set bonus, but already exists: ("..nnum..")");						
								end
							end
						end
					end
				end
			end
		end
	end
end

-- Scans passive bonuses like "Set: " and "Equip: "
function SuperInspectItemBonuses_ScanPassive(line)
	local i, p, value, found;

	found = nil;
	for i,p in SI_IB_EQUIP_PATTERNS do
		_, _, value = string.find(line, "^" .. p.pattern);
		if(value) then
			SuperInspectItemBonuses_AddValue(p.effect, value)
			found = 1;
		end
	end
	if(not found) then
		SuperInspectItemBonuses_ScanGeneric(line);
	end
end


-- Scans generic bonuses like "+3 Intellect" or "Arcane Resistance +4"
function SuperInspectItemBonuses_ScanGeneric(line)
	local value, token, pos, tmpStr, found;

	-- split line at "/" for enchants with multiple effects
	found = false;
	while(string.len(line) > 0) do
		pos = string.find(line, "/", 1, true);
		if(pos) then
			tmpStr = string.sub(line,1,pos-1);
			line = string.sub(line,pos+1);
		else
			tmpStr = line;
			line = "";
		end

		-- trim line
		tmpStr = string.gsub( tmpStr, "^%s+", "" );
   		tmpStr = string.gsub( tmpStr, "%s+$", "" );
		tmpStr = string.gsub( tmpStr, "%.$", "" );

		_, _, value, token = string.find(tmpStr, SI_IB_PREFIX_PATTERN);
		if(not value) then
			_, _,  token, value = string.find(tmpStr, SI_IB_SUFFIX_PATTERN);
		end
		if(token and value) then
			-- trim token
			token = string.gsub( token, "^%s+", "" );
    			token = string.gsub( token, "%s+$", "" );
			token = string.gsub( token, "%.$", "" );
	
			if(SuperInspectItemBonuses_ScanToken(token,value)) then
				found = true;
			end
		end
	end
	return found;
end

-- Scans last fallback for not generic enchants, like "Mana Regen x per 5 sec."
function SuperInspectItemBonuses_ScanOther(line)
	local i, p, value, start, found;

	found = nil;
	for i,p in SI_IB_OTHER_PATTERNS do
		start, _, value = string.find(line, "^" .. p.pattern);
		if(start) then
			if(p.value) then
				SuperInspectItemBonuses_AddValue(p.effect, p.value)
			elseif(value) then
				SuperInspectItemBonuses_AddValue(p.effect, value)
			end
		end
	end
end

function SuperInspectItemBonuses_AddValue(effect, value)
	local i,e;
	if(type(effect) == "string") then
		if(SuperInspect_ItemBonuses_bonuses[effect]) then
			SuperInspect_ItemBonuses_bonuses[effect] = SuperInspect_ItemBonuses_bonuses[effect] + value;
		else
			SuperInspect_ItemBonuses_bonuses[effect] = value;
		end
		--SI_AddMessage(TEXT(effect).." - "..value);
	else 
	-- list of effects
		for i,e in effect do
			if(SuperInspect_ItemBonuses_bonuses[e]) then
				if(type(value) == "table") then
					SuperInspect_ItemBonuses_bonuses[e] = SuperInspect_ItemBonuses_bonuses[e] + value[i];
				else
					SuperInspect_ItemBonuses_bonuses[e] = SuperInspect_ItemBonuses_bonuses[e] + value;
				end
			else
				if(type(value) == "table") then
					SuperInspect_ItemBonuses_bonuses[e] = value[i];
				else
					SuperInspect_ItemBonuses_bonuses[e] = value;
				end
			end
			--SI_AddMessage(TEXT(e).." - "..value);
		end
	end

	
end

function SuperInspectItemBonuses_ScanToken(token, value)
	local i,p,s1,s2;
	if(SI_IB_TOKEN_EFFECT[token]) then
		SuperInspectItemBonuses_AddValue(SI_IB_TOKEN_EFFECT[token], value);
		return true;
	else
		s1 = nil;
		s2 = nil;
		for i,p in SI_IB_S1 do
			if(string.find(token,p.pattern,1,1)) then
				s1 = p.effect;
			end
		end	
		for i,p in SI_IB_S2 do
			if(string.find(token,p.pattern,1,1)) then
				s2 = p.effect;
			end
		end	
		if(s1 and s2) then
			SuperInspectItemBonuses_AddValue(s1..s2, value);
			return true;
		end 
	end
end


function SuperInspect_BonusShow()
	if (not SI_Save.bonus or SI_Save.bonus == 0) then
		return;
	else
		SuperInspect_BonusFrameParent:Show();
		return 1;
	end
end

function SuperInspectItemBonusesButton_BuildTooltip()
	if (not SuperInspect_BonusShow()) then
		return;	
	end
	local text,textR,ret,name,cat,val = "","","","","","";
	local i;
	for i=1, 5, 1 do
		getglobal("SuperInspect_MagicResText"..i):Hide();
	end

	if ((SI_Save) and (not SI_Save.inrangeupdate)) then
		text = text .. SI_IB_TEXT_MISSINGDATA .. "\n";
		textR = textR .. "\n".."\n";
	end

	for i,e in SI_IB_EFFECTS do

		if(SuperInspect_ItemBonuses_bonuses[e.effect]) then
			if(e.format) then
		   		val = format(e.format,SuperInspect_ItemBonuses_bonuses[e.effect]);
			else
				val = SuperInspect_ItemBonuses_bonuses[e.effect];
			end
			--DEFAULT_CHAT_FRAME:AddMessage(e.name);
			--catch the resistances and put them in the res icons instead
			if (e.name == RESISTANCE6_NAME) then
				SuperInspect_MagicResText1:SetText(val);
				SuperInspect_MagicResText1:Show();
				name = "";
				nameR = "";
				val = "";
				--return;
			elseif (e.name == RESISTANCE2_NAME) then
				SuperInspect_MagicResText2:SetText(val);
				SuperInspect_MagicResText2:Show();
				name = "";
				nameR = "";
				val = "";
			elseif (e.name == RESISTANCE3_NAME) then
				SuperInspect_MagicResText3:SetText(val);
				SuperInspect_MagicResText3:Show();
				name = "";
				nameR = "";
				val = "";
			elseif (e.name == RESISTANCE4_NAME) then
				SuperInspect_MagicResText4:SetText(val);
				SuperInspect_MagicResText4:Show();
				name = "";
				nameR = "";
				val = "";
			elseif (e.name == RESISTANCE5_NAME) then
				SuperInspect_MagicResText5:SetText(val);
				SuperInspect_MagicResText5:Show();
				name = "";
				nameR = "";
				val = "";			
			else
				name = "\n".. HIGHLIGHT_FONT_COLOR_CODE.. "  ".. e.name ..":\t";
				nameR = "\n";
			end
			if(e.cat ~= cat and e.cat ~= "RES") then
				cat = e.cat;
				ret = "";
				if(text ~= "") then
					text = text.."\n"
					textR = textR.."\n"
				elseif(text == "") then
					ret = "";
				end
				text = text .. ret .. "|cffffff00"..getglobal("SI_IB_CAT_"..cat) .. ":";
				textR = textR .. ret;
			end
			text = text ..name;
			textR = textR ..nameR.. GREEN_FONT_COLOR_CODE..val;
		end
	end
	if (text and text ~= "") then
		local cohText = "";
		local useText = "";
		local sntText = "";
		local bonusTab, setTab, cohTab, useTab = false;
		if (SuperInspect_ItemBonuses_sets and table.getn( SuperInspect_ItemBonuses_sets ) >= 1) then
			text = text.."\n\n".. SI_IB_YELLOW..SI_SETS .. ":";
			for i=1, table.getn( SuperInspect_ItemBonuses_sets ), 1 do
				text = text.."\n  ".. HIGHLIGHT_FONT_COLOR_CODE..SuperInspect_ItemBonuses_sets[i].s .." (".. GREEN_FONT_COLOR_CODE..SuperInspect_ItemBonuses_sets[i].n .."/"..SuperInspect_ItemBonuses_sets[i].m.. HIGHLIGHT_FONT_COLOR_CODE..")";
				if (SuperInspect_ItemBonuses_sets[i]["t"]) then
					sntText = sntText.."\n\n".. (SuperInspect_ItemBonuses_sets[i].c) ..SuperInspect_ItemBonuses_sets[i].s ..HIGHLIGHT_FONT_COLOR_CODE.." (".. GREEN_FONT_COLOR_CODE..SuperInspect_ItemBonuses_sets[i].n .."/"..SuperInspect_ItemBonuses_sets[i].m.. HIGHLIGHT_FONT_COLOR_CODE..")";
					for index, value in SuperInspect_ItemBonuses_sets[i]["t"] do
						sntText = sntText.."\n ".. GREEN_FONT_COLOR_CODE.."("..index..") "..SI_INFOTEXT_COLOR..value;	
						bonusTab = true;
						setTab = true;
					end
				end
			end	
			--text = text.."IMPORTANT: Bonuses awarded from multiple set pieces are not available for detection on your target.  Please adjust your number manually.";
		end
		--
		for index, value in SuperInspect_ItemBonuses_coh do
			cohText = cohText.."\n\n".. SI_IB_YELLOW..index;
			for index2, value2 in SuperInspect_ItemBonuses_coh[index] do
				cohText = cohText.."\n ".. SI_INFOTEXT_COLOR..value2;	
				--ChatFrame4:AddMessage(index.." : "..index2.."="..value2);
				bonusTab = true;
				cohTab = true;
			end
		end
		for index, value in SuperInspect_ItemBonuses_use do
			useText = useText.."\n\n".. SI_IB_YELLOW..index;
			for index2, value2 in SuperInspect_ItemBonuses_use[index] do
				useText = useText.."\n ".. SI_INFOTEXT_COLOR..value2;	
				--ChatFrame4:AddMessage(index.." : "..index2.."="..value2);
				bonusTab = true;
				useTab = true;
			end
		end
		--


		SuperInspect_ItemBonusesText:SetText(text, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
		SuperInspect_ItemBonusesTextR:SetText(textR, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
		SuperInspect_COHBonusesText:SetText(cohText, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
		SuperInspect_USEBonusesText:SetText(useText, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
		SuperInspect_SnTBonusesText:SetText(sntText, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
		for i=1, 4, 1 do
			getglobal("SuperInspect_BonusFrameParentTab"..i):Hide();
		end
		if (bonusTab == true) then
			SuperInspect_BonusFrameParentTab1:Show();
			local parent = "SuperInspect_BonusFrameParentTab1";
			if (cohTab == true) then
				SuperInspect_BonusFrameParentTab2:Show();
				SuperInspect_BonusFrameParentTab2:SetPoint("LEFT", parent, "RIGHT", 0, 0);
				parent = "SuperInspect_BonusFrameParentTab2";					
			end
			if (useTab == true) then
				SuperInspect_BonusFrameParentTab3:Show();
				SuperInspect_BonusFrameParentTab3:SetPoint("LEFT", parent, "RIGHT", 0, 0);
				parent = "SuperInspect_BonusFrameParentTab3";					
			end
			if (setTab == true) then
				SuperInspect_BonusFrameParentTab4:Show();
				SuperInspect_BonusFrameParentTab4:SetPoint("LEFT", parent, "RIGHT", 0, 0);
				parent = "SuperInspect_BonusFrameParentTab4";					
			end
		end
		--SI_AddMessage(" h= "..SuperInspect_ItemBonusesText:GetHeight());
		--SI_AddMessage(SuperInspect_ItemBonusesTextR:GetHeight());
		SuperInspect_Button_ShowBonuses:SetText(SI_BONUSESHIDE);
		local iHeight = SuperInspect_ItemBonusesText:GetHeight() + 74;
		if (iHeight < 277) then
			iHeight = 277;		
		end
		SuperInspect_BonusFrameParent:SetHeight(iHeight); 
		SuperInspect_ItemBonusesFrame:SetHeight(iHeight); 
		SuperInspect_SnTBonusesFrame:SetHeight(iHeight); 
		SuperInspect_COHBonusesFrame:SetHeight(iHeight); 
		SuperInspect_USEBonusesFrame:SetHeight(iHeight); 
		SuperInspect_ItemBonusesText:SetWidth(208);

		if (SI_Save.btab and getglobal("SuperInspect_BonusFrameParentTab"..(SI_Save.btab)):IsVisible()) then
			SI_BonusFrameTab_OnClick(SI_Save.btab, 1);	
		else
			SI_BonusFrameTab_OnClick(1, 1);	
		end
	else
		SuperInspect_BonusFrameParent:Hide();
	end
end

function SuperInspect_UpdateModel(unit)
	if (not unit) then
		unit = "target";	
	end
	if (UnitExists(unit)) then
		local x, y, z = SuperInspect_ModelFrame:GetPosition();
		SuperInspect_InvFrame.unit_force = "";
		SuperInspect_UpdateCachedList();
		SuperInspect_ModelFrame:SetModelScale(1);
		SuperInspect_ModelFrame:ClearModel();
		SuperInspect_ModelFrame:SetUnit(unit);

		SuperInspect_ModelFrame:SetPosition(x, y, z);

		--DEFAULT_CHAT_FRAME:AddMessage(SuperInspect_ModelFrame:GetModelScale());
		SetPortraitTexture(SuperInspectFramePortrait, "target");

		SuperInspect_MoveFrame.panoffset = SuperInspect_ModelFrame.positionx * 100;
		SuperInspect_MoveFrame.panoffsety = SuperInspect_ModelFrame.positiony * 100;
		if ( SI_Save.default ) then
			for key, val in UISpecialFrames do
				if ( val == "SuperInspectFrame" ) then val = nil; end
			end
			UIPanelWindows["SuperInspectFrame"] = { area = "left", pushable = 0 };
			SuperInspectFrame:EnableMouse(0);

		else
			tinsert(UISpecialFrames, "SuperInspectFrame");
			UIPanelWindows["SuperInspectFrame"] = nil;
			SuperInspectFrame:EnableMouse(1);
		end
		ShowUIPanel(SuperInspectFrame);	
		SuperInspect.isVisible = 1;
		SuperInspect_InspectFrame_Show(unit);
		SuperInspect_SetBackground(unit);
		
		--SI_AddMessage(SuperInspect.name..UnitName(unit));
		if (SuperInspect.name and SuperInspect.name ~= UnitName(unit)) then	
			SuperInspect.honor = nil;	
			SuperInspect.bonus = nil;
			--SI_AddMessage("CLEARING HONOR: OnEvent");
			--SI_AddMessage("|cffffd200PLAYER_TARGET_CHANGED: "..SuperInspect.name);
		end
		local uname,urealm = UnitName(unit);
		SuperInspect.name = uname;
		
		if (UnitRace(unit)) then
		
			if (urealm) then
				SuperInspectFrameHeader_Realm:SetText(urealm);
			else
				SuperInspectFrameHeader_Realm:SetText("");
			end
			
		
			local pvpname = UnitPVPName(unit);
			if (not pvpname) then
				SuperInspectFrameHeader_Name:SetText(UnitName(unit));
			else
				SuperInspectFrameHeader_Name:SetText(UnitPVPName(unit));
			end
			

			if (SI_Save.playercache == nil) then
				SI_Save.playercache = true;
			end
			
			if (SI_Save.playercache) then			
				if ((UnitName("target") ~= UnitName("player"))) then
				
					if (UnitFactionGroup("target") == UnitFactionGroup("player")) then
						SuperInspect_InRangeFrame:Show();
					else
						SuperInspect_InRangeFrame:Hide();
					end
				else
					SuperInspect_InRangeFrame:Hide();
				end
			else
				SuperInspect_InRangeFrame:Hide();
			end
			

			local guildname = nil;
			local guildtitle = nil;
			local guildrank = nil;	
			guildname, guildtitle, guildrank = GetGuildInfo(unit);
			local level = UnitLevel(unit);
			if (level == -1) then
				level = "??";	
			end
			if (guildname) then
				SuperInspectFrameHeader_Guild:SetText(format(TEXT(GUILD_TITLE_TEMPLATE), guildtitle, "<"..guildname..">"));
				SuperInspectFrameHeader_Info:SetText(SI_LEVEL.." "..level.." "..UnitRace(unit).." "..UnitClass(unit));				
			else
				SuperInspectFrameHeader_Guild:SetText(SI_LEVEL.." "..level.." "..UnitRace(unit).." "..UnitClass(unit));
				SuperInspectFrameHeader_Info:SetText(" ");				
			end
			if (SI_Save.playercache) then
				if (not SI_LOCAL_USERS_ITEM_CACHE[uname]) then
					SI_LOCAL_USERS_ITEM_CACHE[uname] = {};
				end			
				if (SI_LOCAL_USERS_ITEM_CACHE and SI_LOCAL_USERS_ITEM_CACHE[uname]) then
					SI_LOCAL_USERS_ITEM_CACHE[uname]['guild'] = SuperInspectFrameHeader_Guild:GetText(); 
					SI_LOCAL_USERS_ITEM_CACHE[uname]['info'] = SuperInspectFrameHeader_Info:GetText(); 
					SI_LOCAL_USERS_ITEM_CACHE[uname]['realm'] = SuperInspectFrameHeader_Realm:GetText(); 
					SI_AddMessage('-----------------setting text for'..uname);
					SuperInspect_UpdateCachedList();
				end
			end
						
		else
			SuperInspectFrameHeader_Name:SetText(UnitName(unit));
			SuperInspect_InRangeFrame:Hide();
			local level = UnitLevel(unit);
			if (level == -1) then
				level = "??";	
			end
			local classification = UnitClassification(unit);
			if ( classification == "worldboss" ) then
				classification = " ("..BOSS..")";
			elseif ( classification == "rareelite"  ) then
				classification = " ("..SI_RAREELITE..")";
			elseif ( classification == "elite"  ) then
				classification = " ("..ELITE..")";
			elseif ( classification == "rare"  ) then
				classification = " ("..ITEM_QUALITY3_DESC..")";
			else
				classification = "";
			end
			--BOSS
			--ELITE
			--ITEM_QUALITY3_DESC --rare
			SuperInspectFrameHeader_Guild:SetText(SI_LEVEL.." "..level..classification);
			SuperInspectFrameHeader_Info:SetText(" ");
			SuperInspectFrameHeader_Realm:SetText(" ");
		end
	else
		--SuperInspect_InvFrame:Hide();
		--SuperInspect_Button_ShowItems:Disable();
		--SuperInspect_Button_ShowItems.isDisabled = 1;
	end
end

function SuperInspect_GetBackgroundTexturePath(unit)
	-- HACK!!!
	local race, fileName = UnitRace(unit);
	if ( fileName == "Gnome" or fileName == "GNOME" ) then
		fileName = "Dwarf";
	elseif ( fileName == "Troll" or fileName == "TROLL" ) then
		fileName = "Orc";
	end
	if ( not fileName ) then
		local num = random( 1, table.getn(SI_BG_Other) );
		fileName = SI_BG_Other[num];
		return "Interface\\TalentFrame\\"..fileName.."-";
	else
		return "Interface\\DressUpFrame\\DressUpBackground-"..fileName, 1;
	end
	-- END HACK
end

function SuperInspect_SetBackground(unit)
	local texture, type = SuperInspect_GetBackgroundTexturePath(unit);
	if (type == 1) then
		SuperInspect_BackgroundTopLeft:SetTexture(texture..1);
		SuperInspect_BackgroundTopRight:SetTexture(texture..2);
		SuperInspect_BackgroundBotLeft:SetTexture(texture..3);
		SuperInspect_BackgroundBotRight:SetTexture(texture..4);
		SuperInspect_BackgroundBotRight:SetWidth(64);	
		SuperInspect_BackgroundTopLeft:SetWidth(256);
		SuperInspect_BackgroundTopRight:SetWidth(64);
		SuperInspect_BackgroundBotLeft:SetWidth(256);
	else
		SuperInspect_BackgroundTopLeft:SetTexture(texture.."TopLeft");
		SuperInspect_BackgroundTopRight:SetTexture(texture.."TopRight");
		SuperInspect_BackgroundBotLeft:SetTexture(texture.."BottomLeft");
		SuperInspect_BackgroundBotRight:SetTexture(texture.."BottomRight");		
		SuperInspect_BackgroundBotRight:SetWidth(74);	
		SuperInspect_BackgroundTopLeft:SetWidth(267);
		SuperInspect_BackgroundTopRight:SetWidth(74);
		SuperInspect_BackgroundBotLeft:SetWidth(267);
	end
end

function SuperInspect_ShowItems_CheckChecked( button )
	if (not SI_Save.items or SI_Save.items == 0) then
		SuperInspect_InvFrame:Show();
		SI_Save.items = 1;
		SuperInspect_Button_ShowItems:SetText(SI_ITEMSHIDE);
		--SI_AddMessage("SHOW INV: checkchecked");
	else
		SuperInspect_InvFrame:Hide();	
		SI_Save.items = 0;
		SI_Save.inrangeupdate = false;
		--SI_AddMessage("HIDING INV: checkitycheck");
	end
end

function SuperInspect_ShowHonor_CheckChecked( button )
	if (not SuperInspect_HonorFrame.isShowing or SuperInspect_HonorFrame.isShowing == 0) then
		SuperInspect_HonorFrame:Show();
		if (SuperInspect_BonusFrameParent:IsVisible()) then
			SuperInspect_ShowBonuses_CheckChecked();
		end
	else
		SuperInspect_HonorFrame:Hide();	
	end
end

function SuperInspect_ShowBonuses_CheckChecked( button )
	if (not SI_Save.bonus or SI_Save.bonus == 0) then
		SI_Save.bonus = 1;
		SuperInspectItemBonusesButton_BuildTooltip();
		--SI_AddMessage("SHOW BONUS: checkchecked");
		if (SuperInspect_HonorFrame:IsVisible()) then
			SuperInspect_ShowHonor_CheckChecked();
		end
	else
		SuperInspect_BonusFrameParent:Hide();	
		SI_Save.bonus = 0;
		--SI_AddMessage("HIDING BONUS: checkitycheck");
	end
end

function SuperInspect_ShowMobInfo_CheckChecked( button )
	if (not SI_Save.mi or SI_Save.mi == 0) then
		SuperInspect_MobInfoFrame:Show();
	else
		SuperInspect_MobInfoFrame:Hide();	
		SI_Save.mi = 0;
	end
end

function SuperInspect_HonorFrame_OnLoad()
	this:RegisterEvent("INSPECT_HONOR_UPDATE");
end

function SuperInspect_HonorFrame_OnEvent()
	if ( event == "INSPECT_HONOR_UPDATE" ) then
		--SI_AddMessage("INSPECT_HONOR_UPDATE");
		SuperInspect_HonorFrame_Update();

	end
end

function SuperInspect_HonorFrame_OnShow()
	
	SuperInspect_HonorFrame.isShowing = 1;
	SuperInspect_Button_ShowHonor:SetText(SI_HONORHIDE);

	if (SuperInspect.name) then
		--SI_AddMessage(SuperInspect.name);
	end
	if (SuperInspect_BonusFrameParent:IsVisible()) then
		SuperInspect_ShowBonuses_CheckChecked();
	end

	if (not UnitExists("target")) then
		if (not SuperInspect.honor and SuperInspect.name and SuperInspect.name ~= UnitName("target")) then
			SuperInspect_HonorFrameCurrentPVPTitle:SetText(SI_NOTARGET);
			SuperInspect_HonorFrameCurrentPVPTitle:Show();
			SuperInspect_HonorFrameCurrentPVPRank:SetText("");
			SuperInspect_HonorFrameHonorPercent:SetText("");
			SuperInspect_HonorFrameCurrentPVPRank:Hide();
			SuperInspect_HonorFrameCurrentPVPTitle:SetPoint("TOP", "$parent", "TOP", - SuperInspect_HonorFrameCurrentPVPRank:GetWidth()/2, -20);
			SuperInspect.honor = nil;
			--SI_AddMessage("CLEARING HONOR: OnShow 1");
			return;				
		else
			SuperInspect_HonorFrame_Update();
		end
	else
		if (not SuperInspect.name or SuperInspect.name ~= UnitName("target") or not SuperInspect.honor or not HasInspectHonorData()) then
			--SuperInspect.name = UnitName("target")
			SuperInspect.honor = nil;
			--SI_AddMessage("CLEARING HONOR: OnShow 2");
			SuperInspect_HonorFrame_Clear();

			SuperInspect_HonorFrameCurrentPVPTitle:SetText(SI_REQUESTHONOR);
			SuperInspect_HonorFrameCurrentPVPTitle:Show();
			this.requesting = GetTime();
			SuperInspect_HonorFrameCurrentPVPRank:SetText("");
			SuperInspect_HonorFrameCurrentPVPRank:Hide();
			SuperInspect_HonorFrameHonorPercent:SetText("");
			SuperInspect_HonorFrameCurrentPVPTitle:SetPoint("TOP", "$parent", "TOP", - SuperInspect_HonorFrameCurrentPVPRank:GetWidth()/2, -18);	

			RequestInspectHonorData();
			--SI_AddMessage("requesting honor update");
		else
			SuperInspect_HonorFrame_Update();
		end	
	end
end

--[[
SI_RANKNAME = {};
SI_RANKNAME.Alliance = {
	[1] = "Private",
	[2] = "Corporal",
	[3] = "Sergeant",
	[4] = "Master Sergeant",
	[5] = "Sergeant Major",
	[6] = "Knight",
	[7] = "Knight-Lieutenant",
	[8] = "Knight-Captain",
	[9] = "Knight-Champion",
	[10] = "Lieutenant Commander",
	[11] = "Commander",
	[12] = "Marshal",
	[13] = "Field Marshal",
	[14] = "Grand Marshal",
	};
SI_RANKNAME.Horde = {
	[1] = "Scout",
	[2] = "Grunt",
	[3] = "Sergeant",
	[4] = "Senior Sergeant",
	[5] = "First Sergeant",
	[6] = "Stone Guard",
	[7] = "Blood Guard",
	[8] = "Legionnare",
	[9] = "Centurion",
	[10] = "Champion",
	[11] = "Lieutenant General",
	[12] = "General",
	[13] = "Warlord",
	[14] = "High Warlord",
	};
]]
--[[
PVP_RANK_5_0 = "Scout";
PVP_RANK_5_1 = "Private";
PVP_RANK_6_0 = "Grunt";
PVP_RANK_6_1 = "Corporal";
PVP_RANK_7_0 = "Sergeant";
PVP_RANK_7_1 = "Sergeant";
PVP_RANK_8_0 = "Senior Sergeant";
PVP_RANK_8_1 = "Master Sergeant";
PVP_RANK_9_0 = "First Sergeant";
PVP_RANK_9_1 = "Sergeant Major";
PVP_RANK_10_0 = "Stone Guard";
PVP_RANK_10_1 = "Knight";
PVP_RANK_11_0 = "Blood Guard";
PVP_RANK_11_1 = "Knight-Lieutenant";
PVP_RANK_12_0 = "Legionnaire";
PVP_RANK_12_1 = "Knight-Captain";
PVP_RANK_13_0 = "Centurion";
PVP_RANK_13_1 = "Knight-Champion";
PVP_RANK_14_0 = "Champion";
PVP_RANK_14_1 = "Lieutenant Commander";
PVP_RANK_15_0 = "Lieutenant General";
PVP_RANK_15_1 = "Commander";
PVP_RANK_16_0 = "General";
PVP_RANK_16_1 = "Marshal";
PVP_RANK_17_0 = "Warlord";
PVP_RANK_17_1 = "Field Marshal";
PVP_RANK_18_0 = "High Warlord";
PVP_RANK_18_1 = "Grand Marshal";
PVP_RANK_19_0 = "Leader"; -- PvP Leader NPC
PVP_RANK_19_1 = "Leader"; -- PvP Leader NPC
]]

function SuperInspect_HonorFrame_Update()
	if (SuperInspect.honor and not UnitExists("target")) then
		SuperInspect.honor = 1;
		return;
	end	
	local sessionHK, sessionDK, yesterdayHK, yesterdayHonor, thisweekHK, thisweekHonor, lastweekHK, lastweekHonor, lastweekStanding, lifetimeHK, lifetimeDK, lifetimeRank = GetInspectHonorData();
	this.requesting = nil;

	-- Yesterday's values
	SuperInspect_HonorFrameYesterdayHKValue:SetText(yesterdayHK);
	SuperInspect_HonorFrameYesterdayContributionValue:SetText(yesterdayHonor);

	-- This week's values
	SuperInspect_HonorFrameThisWeekHKValue:SetText(thisweekHK);
	SuperInspect_HonorFrameThisWeekContributionValue:SetText(thisweekHonor);
	
	-- Last Week's values
	SuperInspect_HonorFrameLastWeekHKValue:SetText(lastweekHK);
	SuperInspect_HonorFrameLastWeekContributionValue:SetText(lastweekHonor);
	SuperInspect_HonorFrameLastWeekStandingValue:SetText(lastweekStanding);

	-- This session's values
	SuperInspect_HonorFrameCurrentHKValue:SetText(sessionHK);
	SuperInspect_HonorFrameCurrentDKValue:SetText(sessionDK);
	
	-- Lifetime stats
	SuperInspect_HonorFrameLifeTimeHKValue:SetText(lifetimeHK);
	SuperInspect_HonorFrameLifeTimeDKValue:SetText(lifetimeDK);
	local rankName, rankNumber = GetPVPRankInfo(lifetimeRank);
	SuperInspect_HonorFrameLifeTimeRankValue:SetText(rankName);

	-- Set rank progress and bar color
	local factionGroup, factionName = UnitFactionGroup("target");

	-- Set rank name and number
	rankName, rankNumber = GetPVPRankInfo(UnitPVPRank("target"));
	if ( not rankName ) then
		rankName = NONE;
	elseif (UnitFactionGroup("target") ~= UnitFactionGroup("player")) then
		local faction;
		if ( factionGroup == "Alliance" ) then
			faction = 1;
		else
			faction = 0;
		end
		rankName = getglobal("PVP_RANK_"..(tonumber(rankNumber)+4).."_"..faction);
	end

	SuperInspect_HonorFrameCurrentPVPRank:SetText("("..RANK.." "..rankNumber..")");
	SuperInspect_HonorFrameCurrentPVPRank:Show();
	SuperInspect_HonorFrameCurrentPVPTitle:SetText(rankName);
	SuperInspect_HonorFrameCurrentPVPTitle:Show();

	if ( factionGroup == "Alliance" ) then
		SuperInspect_HonorFrameProgressBar:SetStatusBarColor(0.05, 0.15, 0.36);
	else
		SuperInspect_HonorFrameProgressBar:SetStatusBarColor(0.63, 0.09, 0.09);
	end
	local progress = GetInspectPVPRankProgress();
	SuperInspect_HonorFrameProgressBar:SetValue(progress);
	SuperInspect_HonorFrameHonorPercent:SetText(format("%.2f", (progress*100) ).."%");

	-- Set icon
	if ( rankNumber > 0 ) then
		SuperInspect_HonorFramePvPIcon:SetTexture(format("%s%02d","Interface\\PvPRankBadges\\PvPRank",rankNumber));
		SuperInspect_HonorFramePvPIcon:Show();
	else
		SuperInspect_HonorFramePvPIcon:Hide();
	end

	-- Recenter rank text
	SuperInspect_HonorFrameCurrentPVPTitle:SetPoint("TOP", "$parent", "TOP", - (SuperInspect_HonorFrameCurrentPVPRank:GetWidth())/2, -18);

	SuperInspect.honor = 1;
	--SI_AddMessage("ADDING HONOR: OnShow");
end

--/script DEFAULT_CHAT_FRAME:AddMessage(UnitFactionGroup("target"));

function SuperInspect_HonorFrame_Clear()
	if (SuperInspect.name and not UnitExists("target")) then
		return;
	end
	-- Yesterday's values
	SuperInspect_HonorFrameYesterdayHKValue:SetText("");
	SuperInspect_HonorFrameYesterdayContributionValue:SetText("");

	-- This week's values
	SuperInspect_HonorFrameThisWeekHKValue:SetText("");
	SuperInspect_HonorFrameThisWeekContributionValue:SetText("");
	
	-- Last Week's values
	SuperInspect_HonorFrameLastWeekHKValue:SetText("");
	SuperInspect_HonorFrameLastWeekContributionValue:SetText("");
	SuperInspect_HonorFrameLastWeekStandingValue:SetText("");

	-- This session's values
	SuperInspect_HonorFrameCurrentHKValue:SetText("");
	SuperInspect_HonorFrameCurrentDKValue:SetText("");
	
	-- Lifetime stats
	SuperInspect_HonorFrameLifeTimeHKValue:SetText("");
	SuperInspect_HonorFrameLifeTimeDKValue:SetText("");

	SuperInspect_HonorFrameLifeTimeRankValue:SetText("");

	SuperInspect_HonorFrameCurrentPVPRank:SetText("");
	SuperInspect_HonorFrameCurrentPVPTitle:SetText("");
	SuperInspect_HonorFrameCurrentPVPTitle:Hide();
	SuperInspect_HonorFrameHonorPercent:SetText("");

	SuperInspect_HonorFramePvPIcon:Hide();
	SuperInspect_HonorFrameProgressBar:SetValue(0);
	SuperInspect_HonorFrameHonorPercent:SetText("");

end

function SuperInspect_HonorFrame_OnUpdate()
	if (this.requesting) then
		if ((GetTime() - this.requesting) >= 5) then
			this.requesting = nil;
			SuperInspect.honor = nil;
			--SI_AddMessage("CLEARING HONOR: OnUpdate");
			SuperInspect_HonorFrameCurrentPVPTitle:SetText(SI_REQUESTHONORFAILED);
			SuperInspect_HonorFrameCurrentPVPTitle:Show();
			SuperInspect_HonorFrameCurrentPVPRank:SetText("");
			SuperInspect_HonorFrameCurrentPVPRank:Hide();
			SuperInspect_HonorFrameHonorPercent:SetText("");
			SuperInspect_HonorFrameCurrentPVPTitle:SetPoint("TOP", "$parent", "TOP", - SuperInspect_HonorFrameCurrentPVPRank:GetWidth()/2, -20);
		end			
	end
end

function SuperInspect_InspectPaperDollItemSlotButton_OnEnter()
	GameTooltip_SetDefaultAnchor(GameTooltip, this);
	SuperInspect.uiwidth = UIParent:GetWidth() / SuperInspect_GetUIScale();
	if (SI_Save.default or (this:GetCenter(UIParent) / SuperInspect.uiwidth) < 0.7 ) then	
		GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
	else
		GameTooltip:SetOwner(this, "ANCHOR_LEFT");
	end
	local name = string.gsub(this:GetName(), "SuperInspect_", "");
	--SI_AddMessage("setting TT");
	--if we've lost our target, but gathered inv info when we had a target, ask the server for the item info
	if ( (SuperInspect_InvFrame.unit == "SI_FORCE") or (not (GameTooltip:SetInventoryItem(SuperInspect_InvFrame.unit, this:GetID()) ))) then
		if (this.link) then
			GameTooltip:ClearLines();
			GameTooltip:SetHyperlink(this.link);--GetItemInfo(this.link)
			--SI_AddMessage("setting TT to:"..this.link);
		else
			GameTooltip:ClearLines();
			GameTooltip:SetText(TEXT(getglobal(strupper(strsub(name, 8)))));	
		end
	end
	CursorUpdate();
end

function SI_BonusFrameTab_OnClick(index, silent)
	if ( not index ) then
		index = this:GetID();
	end
	PanelTemplates_SetTab(SuperInspect_BonusFrameParent, index);
	if (not silent) then
		PlaySound("igCharacterInfoTab");	
	end

	SuperInspect_ItemBonusesFrame:Hide();
	SuperInspect_COHBonusesFrame:Hide();
	SuperInspect_USEBonusesFrame:Hide();
	SuperInspect_SnTBonusesFrame:Hide();

	if ( index == 1 ) then
		SI_Save.btab = 1;
		-- ItemBonuses Tab
		SuperInspect_ItemBonusesFrame:Show();
	elseif ( index == 2 ) then
		SI_Save.btab = 2;
		-- CoHBonuses tab
		SuperInspect_COHBonusesFrame:Show();
	elseif ( index == 3 ) then
		SI_Save.btab = 3;
		-- UseBonuses tab
		SuperInspect_USEBonusesFrame:Show();
	else
		SI_Save.btab = 4;
		-- SnTBonuses tab
		SuperInspect_SnTBonusesFrame:Show();
	end
end

function SuperInspect_ModelFrame_OnLoad()
	this.rotation = 0.61;
	this.positionx = 0;
	this.positiony = 0;
	this.zoom = 0;
	SuperInspect_MoveFrame.panoffset = this.positionx;
	SuperInspect_MoveFrame.panoffsety = this.positiony;
	this:SetRotation(this.rotation);
	this:RefreshUnit();
	--, this.left_right, this.up_down
	--/script SuperInspect_ModelFrame:SetModelScale(2);
	--/script SuperInspect_ModelFrame:SetCamera(1)
end

function SuperInspect_Main_OnMouseDown(arg1)
	if (arg1 == "LeftButton") then
		this:StartMoving();
		if (UnitPVPName("player") == SuperInspectFrameHeader_Name:GetText()) then
			AutoEquipCursorItem();
		end
	end
end

-- this function is called when the frame is stopped being dragged around
function SuperInspect_Main_OnMouseUp(arg1)
	if (arg1 == "LeftButton") then
		this:StopMovingOrSizing();
		
		-- save the position 
		SI_Save.framepos_L = SuperInspectFrame:GetLeft();
		SI_Save.framepos_T = SuperInspectFrame:GetTop();

	end
end

function SuperInspect_Move_OnMouseDown(arg1)
	if (arg1 == "LeftButton") then
		this:StartMoving();
		this.ismoving = 1;
		--SI_AddMessage(this.offset);
	end
	if (arg1 == "RightButton") then
		this:StartMoving();
		this.ispaning = 1;
		--SI_AddMessage(SuperInspect_ModelFrame.positionx);
		--SI_AddMessage(SuperInspect_ModelFrame.positiony);
	end
end

-- this function is called when the frame is stopped being dragged around
function SuperInspect_Move_OnMouseUp(arg1)
	if (arg1 == "LeftButton") then
		this:StopMovingOrSizing();
		this.ismoving = nil;
		this.offset = SuperInspect_ModelFrame.rotation * 50;
		--SI_AddMessage(this.offset);
		this:ClearAllPoints();
		this:SetPoint("TOP", "SuperInspect_ModelFrame", "TOP", 0, 0);

	end
	if (arg1 == "RightButton") then
		this:StopMovingOrSizing();
		this.ispaning = nil;
		this.panoffset = SuperInspect_ModelFrame.positionx * 100;
		this.panoffsety = SuperInspect_ModelFrame.positiony * 100;
		this:ClearAllPoints();
		this:SetPoint("TOP", "SuperInspect_ModelFrame", "TOP", 0, 0);
		--/script SuperInspect_MoveFrame:SetPoint("CENTER", "SuperInspect_ModelFrame", "CENTER", 0, 0);

	end
end

function SuperInspect_Move_OnMouseWheel( value )
	--local scrollBar = getglobal(this:GetName().."ScrollBar");
	if ( value > 0 ) then
		SuperInspect_ModelFrame.zoom = SuperInspect_ModelFrame.zoom + 0.5;
		SuperInspect_ModelFrame:SetPosition(SuperInspect_ModelFrame.zoom, SuperInspect_ModelFrame.positionx, SuperInspect_ModelFrame.positiony);
	else
		SuperInspect_ModelFrame.zoom = SuperInspect_ModelFrame.zoom - 0.5;
		SuperInspect_ModelFrame:SetPosition(SuperInspect_ModelFrame.zoom, SuperInspect_ModelFrame.positionx, SuperInspect_ModelFrame.positiony);
	end
end

function SuperInspect_Move_OnUpdate(elapsedTime)
	if ( this.ismoving ) then
		if (not this.offset) then
			this.offset = 0;	
		end
		local move = this:GetCenter() + this.offset;
		local parent = this:GetParent():GetCenter();
		SuperInspect_ModelFrame.rotation = (move - parent) * 0.02;
		SuperInspect_ModelFrame:SetRotation(SuperInspect_ModelFrame.rotation);
	end
	if ( this.ispaning ) then
		if (not this.panoffset) then
			this.panoffset = 0;	
		end
		local move = this:GetCenter() + this.panoffset;
		local parent = this:GetParent():GetCenter();
		local position = (move - parent) * 0.01;
		SuperInspect_ModelFrame.positionx = position;

		if (not this.panoffsety) then
			this.panoffsety = -100;	
		end
		local movey = this:GetTop() + this.panoffsety;
		local parenty = this:GetParent():GetTop();
		local positiony = (movey - parenty) * 0.01;
		SuperInspect_ModelFrame.positiony = positiony;
		SuperInspect_ModelFrame:SetPosition(SuperInspect_ModelFrame.zoom, SuperInspect_ModelFrame.positionx, SuperInspect_ModelFrame.positiony);
		--/script SuperInspect_ModelFrame:SetPosition(1, 2, -100);
	end
end

function SuperInspect_ResetFrame()
	SuperInspectFrame:ClearAllPoints();
	if (not SI_Save.default) then
		SuperInspectFrame:SetPoint("CENTER", "UIParent", "CENTER", 0, 0);
		SI_Save.framepos_L = SuperInspectFrame:GetLeft();
		SI_Save.framepos_T = SuperInspectFrame:GetTop();	
	end
	if (not UnitExists("target")) then
		TargetUnit("player");	
	end
	if (SI_Save.default) then
		HideUIPanel(SuperInspectFrame);
		SuperInspect.isVisible = nil;
	end
	SuperInspect_InspectTargetHooked();
end

--/script SuperInspect_MoveFrame:ClearAllPoints(); SuperInspect_MoveFrame:SetPoint("CENTER", "UIParent", "CENTER", 0, 0);
--SuperInspect_MoveFrame


--/script TB_AddMessage(table.getn(SuperInspect));
--/script TB_AddMessage(table.getn(SuperInspect["Servers"][GetCVar("realmName")]["Mods"]["TipBuddy"]["Users"]));

function SuperInspect_SetDefaultStyleScale()
	if (SI_Save.default) then
		SuperInspectFrame:SetScale(3);
		local scale = UIParent:GetScale();
		SuperInspect_SetEffectiveScale(SuperInspectFrame, scale, "UIParent");
		--SuperInspect_ModelFrame:SetScale(SuperInspectFrame:GetEffectiveScale());
		SuperInspect_ModelFrame:RefreshUnit();
		SI_Save.scale = scale;
	end
end

function SI_MI2_BuildMobInfoTooltip( mobName, mobLevel )
	if (not MobInfoDB) then
		return;	
	end
	SuperInspect_Button_ShowMobInfo:Show();
	-- get mob data for targeted mob
	local simobData = MI2_GetMobData( mobName, mobLevel, "target" )
	simobData.combinedStr = ""

	MI2_MouseoverIndex = mobName..":"..mobLevel

	-- handle combined Mob mode : try to find the other Mobs with same
	-- name but differing level, add their data to the tooltip data
	if (mobLevel > 0) then
		for levelToCombine = mobLevel-3, mobLevel+3, 1 do
			if levelToCombine ~= mobLevel  then
				local dataToCombine = MI2_GetMobData( mobName, levelToCombine )
				if dataToCombine.color then
					SI_MI2_AddTwoMobs( simobData, dataToCombine )
					simobData.combinedStr = simobData.combinedStr.." L"..levelToCombine
				end
			else
				simobData.combinedStr = simobData.combinedStr.." L"..levelToCombine
			end
		end
	end

	-- calculate number of mobs to next level based on mob experience
	if simobData.xp then
		local xpCurrent = UnitXP("player") + simobData.xp
		local xpToLevel = UnitXPMax("player") - xpCurrent
		simobData.mob2Level = ceil(abs(xpToLevel / simobData.xp))+1
	end

	-- display the Mob data to the game tooltip
	SI_MI2_BuildQualityString( simobData )

	SI_MI2_CreateNormalTooltip( simobData, MI2_MouseoverIndex )
end  -- of MI2_BuildMobInfoTooltip()

function SI_MI2_BuildQualityString( simobData )
	local rt = simobData.loots or 1 
 
	simobData.qualityStr = ""

	if  simobData.r1  then
		simobData.qualityStr = simobData.qualityStr ..mifontGray..simobData.r1.."("..ceil((simobData.r1/rt)*100).."%) "
	end
	if  simobData.r2  then
		simobData.qualityStr = simobData.qualityStr ..mifontWhite..simobData.r2.."("..ceil((simobData.r2/rt)*100).."%) "
	end
	if  simobData.r3  then
		simobData.qualityStr = simobData.qualityStr ..mifontGreen..simobData.r3.."("..ceil((simobData.r3/rt)*100).."%) "
	end
	if  simobData.r4  then
		simobData.qualityStr = simobData.qualityStr ..mifontBlue..simobData.r4.."("..ceil((simobData.r4/rt)*100).."%) "
	end
	if  simobData.r5  then
		simobData.qualityStr = simobData.qualityStr ..mifontMageta..simobData.r5.."("..ceil((simobData.r5/rt)*100).."%) "
	end
end  -- MI2_CreateQualityString

-----------------------------------------------------------------------------
-- MI2_AddTwoMobs()
--
-- add the data for two mobs,
-- the data of the second mob (simobData2) is added to the data of the first
-- mob (simobData1). The result is returned in "simobData1".
-----------------------------------------------------------------------------
function SI_MI2_AddTwoMobs( simobData1, simobData2 )
	simobData1.loots = (simobData1.loots or 0) + (simobData2.loots or 0)
	simobData1.kills = (simobData1.kills or 0) + (simobData2.kills or 0)
	simobData1.emptyLoots = (simobData1.emptyLoots or 0) + (simobData2.emptyLoots or 0)
	simobData1.clothCount = (simobData1.clothCount or 0) + (simobData2.clothCount or 0)
	simobData1.copper = (simobData1.copper or 0) + (simobData2.copper or 0)
	simobData1.itemValue = (simobData1.itemValue or 0) + (simobData2.itemValue or 0)
	simobData1.r1 = (simobData1.r1 or 0) + (simobData2.r1 or 0)
	simobData1.r2 = (simobData1.r2 or 0) + (simobData2.r2 or 0)
	simobData1.r3 = (simobData1.r3 or 0) + (simobData2.r3 or 0)
	simobData1.r4 = (simobData1.r4 or 0) + (simobData2.r4 or 0)
	simobData1.r5 = (simobData1.r5 or 0) + (simobData2.r5 or 0)
	if simobData2.mobType then simobData1.mobType = simobData2.mobType end
	if simobData2.xp then simobData1.xp = simobData2.xp end

	-- combine DPS od two mobs
	if not simobData1.dps then
		simobData1.dps = simobData2.dps
	else
		if simobData2.dps then
			simobData1.dps = floor( ((2.0 * simobData1.dps) + simobData2.dps) / 3.0 )
		end
	end

	-- combine minimum and maximum damage	
	if (simobData2.minDamage or 99999) < (simobData1.minDamage or 99999) then
		simobData1.minDamage = simobData2.minDamage
	end
	if (simobData2.maxDamage or 0) > (simobData1.maxDamage or 0) then
		simobData1.maxDamage = simobData2.maxDamage
	end
	
	-- add loot item tables of the two mobs
	if simobData2.itemList then
		if not simobData1.itemList then simobData1.itemList = {} end
		for itemID, amount in simobData2.itemList do
			simobData1.itemList[itemID] = (simobData1.itemList[itemID] or 0) + simobData2.itemList[itemID]
		end
	end

	if simobData1.loots == 0 then simobData1.loots = nil end
	if simobData1.kills == 0 then simobData1.kills = nil end
	if simobData1.emptyLoots == 0 then simobData1.emptyLoots = nil end
	if simobData1.clothCount == 0 then simobData1.clothCount = nil end
	if simobData1.copper == 0 then simobData1.copper = nil end
	if simobData1.itemValue == 0 then simobData1.itemValue = nil end
	if simobData1.dps == 0 then simobData1.dps = nil end
	if simobData1.r1 == 0 then simobData1.r1 = nil end
	if simobData1.r2 == 0 then simobData1.r2 = nil end
	if simobData1.r3 == 0 then simobData1.r3 = nil end
	if simobData1.r4 == 0 then simobData1.r4 = nil end
	if simobData1.r5 == 0 then simobData1.r5 = nil end
end  -- MI2_AddTwoMobs

function SI_MI2_CreateNormalTooltip( simobData, mobIndex )
	local copperAvg, itemValueAvg
	local text, textR = "", "";

	if simobData.class then
		text = text..mifontGold..MI_TXT_CLASS.."\n";
		textR = textR..mifontWhite..simobData.class.."\n";
	end

	if simobData.healthCur then
		text = text..mifontGold..MI_TXT_HEALTH.."\n";
		textR = textR..mifontWhite..simobData.healthCur.." / "..simobData.healthMax.."\n";
	end

	if simobData.manaMax and simobData.manaMax > 0 then
		text = text..mifontGold..MI_TXT_MANA.."\n";
		textR = textR..mifontWhite..simobData.manaCur.." / "..simobData.manaMax.."\n";
	end

	-- exit right here if mob does not exist in database
	if not simobData.color then
		SuperInspect_Button_ShowMobInfo:Hide(); 
		return;
	end
	
	local mobGivesXp = not (simobData.color.r == 0.5  and  simobData.color.g == 0.5  and  simobData.color.b == 0.5)
	if mobGivesXp and simobData.xp then
		text = text..mifontGold..MI_TXT_XP.."\n";
		textR = textR..mifontWhite..simobData.xp.."\n";

		text = text..mifontGold..MI_TXT_TO_LEVEL.."\n";
		textR = textR..mifontWhite..simobData.mob2Level.."\n";
	end

	if (simobData.minDamage or simobData.dps) then 
		text = text..mifontGold..MI_TXT_DAMAGE.."\n";
		textR = textR..mifontWhite..(simobData.minDamage or 0).."-"..(simobData.maxDamage or 0).."  ["..(simobData.dps or 0).."]".."\n";
	end

	text = text.."\n"..mifontGray.."["..MI_TXT_COMBINED..simobData.combinedStr.."]".."\n";
	textR = textR.."\n\n";


	if simobData.kills then
		text = text..mifontGold..MI_TXT_KILLS.."\n";
		textR = textR..mifontWhite..simobData.kills.."\n";
	end          

	if  simobData.loots then
		text = text..mifontGold..MI_TXT_TIMES_LOOTED.."\n";
		textR = textR..mifontWhite..simobData.loots.."\n";
	end

	if  simobData.emptyLoots then
		local emptyLootsStr = mifontWhite..simobData.emptyLoots
		if  simobData.loots  then
			emptyLootsStr = emptyLootsStr.." ("..ceil((simobData.emptyLoots/simobData.loots)*100).."%) "
		end
		text = text..mifontGold..MI_TXT_EMPTY_LOOTS.."\n";
		textR = textR..emptyLootsStr.."\n";
	end

	if  simobData.qualityStr ~= "" then
		text = text.."\n"..mifontGold..MI_TXT_QUALITY.."\n";
		textR = textR.."\n"..simobData.qualityStr.."\n";
	end

	if simobData.clothCount then
		local clothStr = mifontWhite..simobData.clothCount
		if simobData.loots then
			clothStr = clothStr.." ("..ceil((simobData.clothCount/simobData.loots)*100).."%) "
		end
		text = text..mifontGold..MI_TXT_CLOTH_DROP.."\n";
		textR = textR..clothStr.."\n";
	end

	if simobData.copper and simobData.loots then
		copperAvg = ceil( simobData.copper / simobData.loots )
		text = text..mifontGold..MI_TXT_COIN_DROP.."\n";
		textR = textR..mifontWhite..copper2text(copperAvg).."\n";
	end

	if simobData.itemValue and simobData.loots then
		itemValueAvg = ceil( simobData.itemValue / simobData.loots )
		text = text..mifontGold..MI_TEXT_ITEM_VALUE.."\n";
		textR = textR..mifontWhite..copper2text(itemValueAvg).."\n";
	end

	local totalValue = (copperAvg or 0) + (itemValueAvg or 0)
	if totalValue > 0 then
		text = text..mifontGold..MI_TXT_MOB_VALUE.."\n";
		textR = textR..mifontWhite..copper2text(totalValue).."\n";
	end

	if simobData.itemList then
		text = text.."\n";
		textR = textR.."\n";
		text, textR = SI_MI2_AddItemsToTooltip( simobData, text, textR )
	end

	SuperInspect_MobInfoText:SetText(text);
	SuperInspect_MobInfoTextR:SetText(textR);
	if (SI_Save.mi and SI_Save.mi == 1) then
		SuperInspect_MobInfoFrame:Show();
		local iHeight = SuperInspect_MobInfoText:GetHeight();
		SuperInspect_MobInfoFrame:SetHeight(SuperInspect_MobInfoText:GetHeight() + 50); 
	end
end  -- of MI2_CreateNormalTooltip()

function SI_MI2_AddItemsToTooltip( simobData, text, textR )
	for itemID, amount in simobData.itemList do
		local itemText, itemColor = MI2_GetLootItemString(itemID)
		local itemText = itemText.." ("..amount..")"

		if string.len(itemText) < 40 then
			text = text..itemColor..itemText.."\n";
			textR = textR.."\n";
		else
			local pos = string.find( itemText, " ", 26 );
			text = text..itemColor..string.sub(itemText,1,pos-1).."\n";
			textR = textR.."\n";
			text = text..itemColor..string.sub(itemText,pos+1).."\n";
			textR = textR.."\n";
		end
	end
	return text, textR;
end -- of MI2_AddItemsToTooltip

function SuperInspect_MobInfoFrame_OnShow()
	SI_Save.mi = 1;
	SuperInspect_Button_ShowMobInfo:SetText(SI_MOBINFOHIDE);
	--if (SuperInspect_MobInfoText:GetText() and SuperInspect_MobInfoText:GetText() ~= "") then
		local iHeight = SuperInspect_MobInfoText:GetHeight();
		SuperInspect_MobInfoFrame:SetHeight(SuperInspect_MobInfoText:GetHeight() + 50); 
	--end
end

--/script DEFAULT_CHAT_FRAME:AddMessage(SuperInspect_RGBToHexColor( 0.9, 0.8, 0.8 ));
function SuperInspect_RGBToHexColor( r, g, b )
	--local num = 220;
	r = string.format("%x", (format("%.1f", r))*255);
	g = string.format("%x", (format("%.1f", g))*255);
	b = string.format("%x", (format("%.1f", b))*255);
	if (not r or r == "0" or r == 0) then
		r = "00";	
	end
	if (not g or g == "0" or g == 0) then
		g = "00";	
	end
	if (not b or b == "0" or b == 0) then
		b = "00";	
	end
	local hex = ("|cff"..r..g..b);
	--TB_AddMessage(hex);
	return hex;
end
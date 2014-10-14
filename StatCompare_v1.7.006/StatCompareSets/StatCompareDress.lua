local PlayerSlotNames = {
   [1] = { name = "HeadSlot", tooltip = HEADSLOT };
   [2] = { name = "NeckSlot", tooltip = NECKSLOT },
   [3] = { name = "ShoulderSlot", tooltip = SHOULDERSLOT },
   [4] = { name = "BackSlot", tooltip = BACKSLOT },
   [5] = { name = "ChestSlot", tooltip = CHESTSLOT },
   [6] = { name = "ShirtSlot", tooltip = SHIRTSLOT },
   [7] = { name = "TabardSlot", tooltip = TABARDSLOT },
   [8] = { name = "WristSlot", tooltip = WRISTSLOT },
   [9] = { name = "HandsSlot", tooltip = HANDSSLOT },
   [10] = { name = "WaistSlot", tooltip = WAISTSLOT },
   [11] = { name = "LegsSlot", tooltip = LEGSSLOT },
   [12] = { name = "FeetSlot", tooltip = FEETSLOT },
   [13] = { name = "Finger0Slot", tooltip = FINGER0SLOT },
   [14] = { name = "Finger1Slot", tooltip = FINGER1SLOT },
   [15] = { name = "Trinket0Slot", tooltip = TRINKET0SLOT },
   [16] = { name = "Trinket1Slot", tooltip = TRINKET1SLOT },
   [17] = { name = "MainHandSlot", tooltip = MAINHANDSLOT },
   [18] = { name = "SecondaryHandSlot", tooltip = SECONDARYHANDSLOT },
   [19] = { name = "RangedSlot", tooltip = RANGEDSLOT },
}

function StatCompareSetsFrame_OnLoad()
	local class = UnitClass("player");
	local name = UnitName("player");
	StatCompareSetsFrameTitle:SetText(class.."  "..name);

	if(StatCompareMinimapButton) then
		StatCompareMinimapButton.tooltip = STATCOMPARE_TOOLTIP_MINIMAP1;
	end
end

local function DressUpItem(model, itemID)
   if ( not model or not itemID or itemID == "" ) then
      return;
   end

   model:TryOn(itemID);
end

-- handle making the items in the outfit pane do nice things
function StatCompareSetsItemButton_OnEnter()
   if ( GameTooltip.finished ) then
      return;
   end

   GameTooltip.finished = 1;
   GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
   if (this.item) then
      local link = "item:"..this.item;
      if ( GetItemInfo(link) ) then
         GameTooltip:SetHyperlink(link);
      elseif ( this.name ) then
         GameTooltip:SetText(this.name);
      elseif ( this.tooltip ) then
         GameTooltip:SetText(this.tooltip);
      else
         GameTooltip:SetText("<unlinkable item>", 1, 0, 0);
      end
   elseif ( this.tooltip ) then
      GameTooltip:AddLine(this.tooltip);
   else
      local parentlen = string.len(this:GetParent():GetName())+1;
      local slotName = strsub(this:GetName(), parentlen);
      slotName = strsub(slotName, 1, string.len(slotName) - 4);
      this.tooltip = slotName;
      GameTooltip:AddLine(this.tooltip);
   end
   GameTooltip:Show();
end

function StatCompareSetsItemButton_Draw(button)
   if(not button) then
	return;
   end
   if ( button.texture ) then
      SetItemButtonTexture(button, button.texture);
   elseif(button.backgroundTextureName) then
      SetItemButtonTexture(button, button.backgroundTextureName);
   else
      SetItemButtonTexture(button,nil);
   end
   if ( button.missing ) then
      SetItemButtonTextureVertexColor(button, 1.0, 0.1, 0.1);
   elseif ( button.banked ) then
      SetItemButtonTextureVertexColor(button, 0.1, 0.1, 1.0);
   else
      SetItemButtonTextureVertexColor(button, 1.0, 1.0, 1.0);
   end
end

function StatCompare_DressSets(sets)
	local module = getglobal("StatCompareSetsFrameModel");
	module:Undress();

	for i = 1, 19 do
		if(StatCompare_BestItems and StatCompare_BestItems[i] and StatCompare_BestItems[i][sets]) then
			local id = StatCompare_BestItems[i][sets]["id"];
			local slotName = PlayerSlotNames[i].name;
			local button = getglobal("StatCompareSetsFrame"..slotName);
			button.tooltip = PlayerSlotNames[i].tooltip;
			button.texture = SCS_DB[id].icon;
			button.backgroundTextureName = SCS_DB[id].icon;
			button:SetID(id);
			button.banked = false;
			button.missing = false;
			button.empty = false;
			if(StatCompare_BestItems[i][sets]["enchantid"]) then
				button.eid = StatCompare_BestItems[i][sets]["enchantid"]
			else
				button.eid = 0;
			end
			button.item = id..":"..button.eid..":0:0";
			button.id = id;
			StatCompareSetsItemButton_Draw(button);
			DressUpItem(module, id);
		else
			local slotName = PlayerSlotNames[i].name;
			local button = getglobal("StatCompareSetsFrame"..slotName);
			button.empty = true;
			button.tooltip = PlayerSlotNames[i].tooltip;
			button.id = nil;
			button.eid = nil;
			button.backgroundTextureName = nil;
			button.item = nil;
			button.texture = nil;
			button.missing = false;
			button:SetID(0);
			StatCompareSetsItemButton_Draw(button);
		end
	end
	StatCompareSetsFrame:Show();
end

local function UpdateModel_ThisSlot(pname, model, idx)
	local slotName = PlayerSlotNames[idx].name;
	local what = getglobal(pname..slotName);
	local item = nil;
	if(not what) then
		return;
	end
	if ( not what.empty ) then
		item = what.id;
	end
	
	if ( item ) then
		DressUpItem(model, item);
	end
end

function StatCompareSetsFrame_UpdateModel(frame)
	local pname = "StatCompareSetsFrame";
	local model = getglobal("StatCompareSetsFrameModel");
	local empty = false;

	if ( not model ) then
		return;
	end
	
	model:Undress();

	for i=19,1,-1 do
		UpdateModel_ThisSlot(pname, model, i);
	end
end

function StatCompareSets_RelinkChat()
	local link = nil;

	if ( IsShiftKeyDown() and ChatFrameEditBox:IsVisible() ) then
		if(this.item) then
			local id = this.id;
			local _,_,_,hex = GetItemQualityColor(SCS_DB[id].quality);
			link = hex .. "|H".. "item:"..this.item .. "|h[" .. SCS_DB[id].name .. "]|h|r";
		end
	end

	if ( link ) then
		ChatFrameEditBox:Insert(link);
	end
end

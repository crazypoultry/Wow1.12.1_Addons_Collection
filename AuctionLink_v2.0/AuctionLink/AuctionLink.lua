---------------------------------
	---			Declerations			---
---------------------------------

local L = AceLibrary("AceLocale-2.2"):new("AuctionLink")
AuctionLink = AceLibrary("AceAddon-2.0"):new("AceConsole-2.0", "AceDB-2.0", "AceHook-2.1", "AceEvent-2.0")

---------------------------------
	---			Main Functions		---
---------------------------------

function AuctionLink:OnInitialize()

	local options = {
		type = "group",
		args = {
			autosearch = {
				name = "autosearch", type = "toggle",
				desc = "Automatically search after clicking an item",
				get = function() return self.db.profile.autosearch end,
				set = function(v) self.db.profile.autosearch = v end,
				order = 1
			}
		}
	}
	
	self:RegisterDB("AuctionLinkDB")
	self:RegisterDefaults("profile", {
		autosearch = true
	})
	self:RegisterChatCommand({"/alink", "/auctionlink"}, options)
end

function AuctionLink:OnEnable()
	self:HookScript(AuctionsButton1Item, "OnClick", "AuctionsButtonItem")
	self:HookScript(AuctionsButton2Item, "OnClick", "AuctionsButtonItem")
	self:HookScript(AuctionsButton3Item, "OnClick", "AuctionsButtonItem")
	self:HookScript(AuctionsButton4Item, "OnClick", "AuctionsButtonItem")
	self:HookScript(AuctionsButton5Item, "OnClick", "AuctionsButtonItem")
	self:HookScript(AuctionsButton6Item, "OnClick", "AuctionsButtonItem")
	self:HookScript(AuctionsButton7Item, "OnClick", "AuctionsButtonItem")
	self:HookScript(AuctionsButton8Item, "OnClick", "AuctionsButtonItem")
	self:HookScript(AuctionsButton9Item, "OnClick", "AuctionsButtonItem")
	
	self:HookScript(BrowseButton1Item, "OnClick", "BrowseButtonItem")
	self:HookScript(BrowseButton2Item, "OnClick", "BrowseButtonItem")
	self:HookScript(BrowseButton3Item, "OnClick", "BrowseButtonItem")
	self:HookScript(BrowseButton4Item, "OnClick", "BrowseButtonItem")
	self:HookScript(BrowseButton5Item, "OnClick", "BrowseButtonItem")
	self:HookScript(BrowseButton6Item, "OnClick", "BrowseButtonItem")
	self:HookScript(BrowseButton7Item, "OnClick", "BrowseButtonItem")
	self:HookScript(BrowseButton8Item, "OnClick", "BrowseButtonItem")
	
	self:Hook("ContainerFrameItemButton_OnClick", "ItemButton")
	self:Hook("SetItemRef")
	self:Hook("PaperDollItemSlotButton_OnClick")
	if(IsAddOnLoaded("Blizzard_TradeSkillUI")) then
		self:HookScript(TradeSkillSkillIcon, "OnClick", "TradeSkillIconClick")
		self:HookScript(TradeSkillReagent1, "OnClick", "TradeSkillReagentClick")
		self:HookScript(TradeSkillReagent2, "OnClick", "TradeSkillReagentClick")
		self:HookScript(TradeSkillReagent3, "OnClick", "TradeSkillReagentClick")
		self:HookScript(TradeSkillReagent4, "OnClick", "TradeSkillReagentClick")
		self:HookScript(TradeSkillReagent5, "OnClick", "TradeSkillReagentClick")
		self:HookScript(TradeSkillReagent6, "OnClick", "TradeSkillReagentClick")
		self:HookScript(TradeSkillReagent7, "OnClick", "TradeSkillReagentClick")
		self:HookScript(TradeSkillReagent8, "OnClick", "TradeSkillReagentClick")
	end
	if(IsAddOnLoaded("MyBags")) then
		self:Hook(MyInventory, "ItemButton_OnClick", "MyBagsInventory")
		self:Hook(MyBank, "ItemButton_OnClick", "MyBagsBank")
		self:Hook(MyEquipment, "MyEquipmentItemSlotButton_OnClick", "MyBagsEquipment")
	end
	if(IsAddOnLoaded("ACUI_MyInventory")) then
		self:Hook("ACUI_MyInventoryFrameItemButton_OnClick", "ACUI")
	end
	if(IsAddOnLoaded("Bagnon")) then
		self:Hook("BagnonItem_OnClick", "Bagnon")
	end
	if(IsAddOnLoaded("ChatMats")) then
		self:Hook("chatmats_DoOnClickTrade", "ChatmatsTrade")
	end
	if(IsAddOnLoaded("AdvancedTradeSkillWindow")) then
		self:HookScript(ATSWSkillIcon, "OnClick", "ATSWSkillIcon")
		self:HookScript(ATSWReagent1, "OnClick", "ATSWReagent")
		self:HookScript(ATSWReagent2, "OnClick", "ATSWReagent")
		self:HookScript(ATSWReagent3, "OnClick", "ATSWReagent")
		self:HookScript(ATSWReagent4, "OnClick", "ATSWReagent")
		self:HookScript(ATSWReagent5, "OnClick", "ATSWReagent")
		self:HookScript(ATSWReagent6, "OnClick", "ATSWReagent")
		self:HookScript(ATSWReagent7, "OnClick", "ATSWReagent")
		self:HookScript(ATSWReagent8, "OnClick", "ATSWReagent")
	end
	if(IsAddOnLoaded("AllInOneInventory")) then
		self:Hook("AllInOneInventoryFrameItemButton_OnClick", "AIOI")
	end
	self:RegisterEvent("ADDON_LOADED", "AddonLoaded")
end

function AuctionLink:OnDisable()
end

function AuctionLink:AddonLoaded(name)
	if(name == "Blizzard_TradeSkillUI") then
		self:HookScript(TradeSkillSkillIcon, "OnClick", "TradeSkillIconClick")
		self:HookScript(TradeSkillReagent1, "OnClick", "TradeSkillReagentClick")
		self:HookScript(TradeSkillReagent2, "OnClick", "TradeSkillReagentClick")
		self:HookScript(TradeSkillReagent3, "OnClick", "TradeSkillReagentClick")
		self:HookScript(TradeSkillReagent4, "OnClick", "TradeSkillReagentClick")
		self:HookScript(TradeSkillReagent5, "OnClick", "TradeSkillReagentClick")
		self:HookScript(TradeSkillReagent6, "OnClick", "TradeSkillReagentClick")
		self:HookScript(TradeSkillReagent7, "OnClick", "TradeSkillReagentClick")
		self:HookScript(TradeSkillReagent8, "OnClick", "TradeSkillReagentClick")
	elseif(name == "ChatMats") then
		self:Hook("chatmats_DoOnClickTrade", "ChatmatsTrade")
	elseif(name == "AdvancedTradeSkillWindow") then
		self:HookScript(ATSWSkillIcon, "OnClick", "ATSWSkillIcon")
		self:HookScript(ATSWReagent1, "OnClick", "ATSWReagent")
		self:HookScript(ATSWReagent2, "OnClick", "ATSWReagent")
		self:HookScript(ATSWReagent3, "OnClick", "ATSWReagent")
		self:HookScript(ATSWReagent4, "OnClick", "ATSWReagent")
		self:HookScript(ATSWReagent5, "OnClick", "ATSWReagent")
		self:HookScript(ATSWReagent6, "OnClick", "ATSWReagent")
		self:HookScript(ATSWReagent7, "OnClick", "ATSWReagent")
		self:HookScript(ATSWReagent8, "OnClick", "ATSWReagent")
	elseif( name == "ACUI_MyInventory") then
		self:Hook("ACUI_MyInventoryFrameItemButton_OnClick", "ACUI")
	elseif( name == "AllInOneInventory") then
		self:Hook("AllInOneInventoryFrameItemButton_OnClick", "AIOI")
	end
end

function AuctionLink:ChatmatsTrade()
	if (AuctionFrameBrowse:IsVisible() and IsShiftKeyDown() and not ChatFrameEditBox:IsVisible()) then
		local link = GetTradeSkillItemLink(TradeSkillFrame.selectedSkill)
		local name = string.gsub(link,"^.-%[(.*)%].*", "%1")
		if ( IsAltKeyDown()) then
			name = string.gsub(name, " of.-$", "") 
		end
		if(self.db.profile.autosearch) then
			QueryAuctionItems(name)
			BrowseName:SetText(name)
		else
			BrowseName:SetText(name)
		end
	else
		self.hooks.chatmats_DoOnClickCraft()
	end
end

function AuctionLink:AIOI(button, ignoreShift)
	if ( AuctionFrameBrowse:IsVisible() and IsShiftKeyDown() and not ChatFrameEditBox:IsVisible()) then
		local bag, slot = AllInOneInventory_GetIdAsBagSlot(this:GetID());
		local link = GetContainerItemLink(bag, slot)
		local name = string.gsub(link,"^.-%[(.*)%].*", "%1")
		if ( IsAltKeyDown()) then
			name = string.gsub(name, " of.-$", "") 
		end
		if(self.db.profile.autosearch) then
			QueryAuctionItems(name)
			BrowseName:SetText(name)
		else
			BrowseName:SetText(name)
		end
	else
		self.hooks.AllInOneInventoryFrameItemButton_OnClick(button, ignoreShift)
	end
end

--Thanks to Isharra for the MyBags functions
function AuctionLink:MyBagsInventory(button, ignoreShift)
	if ( AuctionFrameBrowse:IsVisible() and IsShiftKeyDown() and not ChatFrameEditBox:IsVisible()) then
		local self = this:GetParent():GetParent().self
		local _,_,ID = self:GetInfo(this:GetParent():GetID(), this:GetID())
		if ID then
			local name = GetItemInfo("item:"..ID)
			if(IsAltKeyDown()) then
				name = string.gsub(name, " of.-$", "") 
			end
			if(self.db.profile.autosearch) then
				QueryAuctionItems(name)
				BrowseName:SetText(name)
			else
				BrowseName:SetText(name)
			end
		end
	else
		self.Hooks[MyInventory].ItemButton_OnClick(MyInventory, button, ignoreShift)
	end
end

function AuctionLink:MyBagsBank(button, ignoreShift)
	if ( AuctionFrameBrowse:IsVisible() and IsShiftKeyDown() and not ChatFrameEditBox:IsVisible()) then
		local _,_,ID = MyBank:GetInfo(this:GetParent():GetID(), this:GetID())
		if ID then
			local name = GetItemInfo("item:"..ID)
			if(IsAltKeyDown()) then
				name = string.gsub(name, " of.-$", "") 
			end
			if(self.db.profile.autosearch) then
				QueryAuctionItems(name)
				BrowseName:SetText(name)
			else
				BrowseName:SetText(name)
			end
		end
	else
		self.Hooks[MyBank].ItemButton_OnClick(MyBank, button, ignoreShift)
	end
end

function AuctionLink:MyBagsEquipment(button, ignoreShift)
	if ( AuctionFrameBrowse:IsVisible() and IsShiftKeyDown() and not ChatFrameEditBox:IsVisible()) then
		local _,_,ID = MyEquipment:GetInfo(this:GetID())
		if ID then
			local name = GetItemInfo("item:"..ID)
			if(IsAltKeyDown()) then
				name = string.gsub(name, " of.-$", "") 
			end
			if(self.db.profile.autosearch) then
				QueryAuctionItems(name)
				BrowseName:SetText(name)
			else
				BrowseName:SetText(name)
			end
		end
	else
		self.Hooks[MyEquipment].MyEquipmentItemSlotButton_OnClick(MyEquipment, button, ignoreShift)
	end
end

function AuctionLink:ACUI(button, ignoreShift)
	local bag, slot = this.bagIndex, this.itemIndex;
	if ( AuctionFrameBrowse:IsVisible() and IsShiftKeyDown() and not ChatFrameEditBox:IsVisible()) then
		local link = GetContainerItemLink(bag, slot)
		local name = string.gsub(link,"^.-%[(.*)%].*", "%1")
		if(IsAltKeyDown()) then
			name = string.gsub(name, " of.-$", "") 
		end
		if(self.db.profile.autosearch) then
			QueryAuctionItems(name)
			BrowseName:SetText(name)
		else
			BrowseName:SetText(name)
		end
	else
		self.hooks.ACUI_MyInventoryFrameItemButton_OnClick(button, ignoreShift)
	end
end

function AuctionLink:Bagnon(mouseButton, ignoreModifiers)
	if ( AuctionFrameBrowse:IsVisible() and IsShiftKeyDown() and not ChatFrameEditBox:IsVisible()) then
		local link = BagnonDB.GetItemHyperlink(this:GetParent():GetParent().player, this:GetParent():GetID(), this:GetID())
		local name = string.gsub(link,"^.-%[(.*)%].*", "%1")
		if(IsAltKeyDown()) then
			name = string.gsub(name, " of.-$", "") 
		end
		if(self.db.profile.autosearch) then
			QueryAuctionItems(name)
			BrowseName:SetText(name)
		else
			BrowseName:SetText(name)
		end
	else
		self.hooks.BagnonItem_OnClick(mouseButton, ignoreModifiers)
	end
end
--New function for bags
function AuctionLink:ItemButton(button, index)
	if ( AuctionFrameBrowse:IsVisible() and IsShiftKeyDown() and not ChatFrameEditBox:IsVisible()) then
		local link = GetContainerItemLink(this:GetParent():GetID(), this:GetID())
		local name = string.gsub(link,"^.-%[(.*)%].*", "%1")
		if(IsAltKeyDown()) then
			name = string.gsub(name, " of.-$", "") 
		end
		if(self.db.profile.autosearch) then
			QueryAuctionItems(name)
			BrowseName:SetText(name)
		else
			BrowseName:SetText(name)
		end
	else
		self.hooks.ContainerFrameItemButton_OnClick(button, index)
	end
end

--New function for item links in the chat
function AuctionLink:SetItemRef(link, text, button)
	if ( AuctionFrameBrowse:IsVisible() and IsShiftKeyDown() and not ChatFrameEditBox:IsVisible()) then
		local name = string.gsub(text,"^.-%[(.*)%].*", "%1")
		if(IsAltKeyDown()) then
			name = string.gsub(name, " of.-$", "") 
		end
		if(self.db.profile.autosearch) then
			QueryAuctionItems(name)
			BrowseName:SetText(name)
		else
			BrowseName:SetText(name)
		end
	else
		self.hooks.SetItemRef(link, text, button)
	end
end

--New function for inventory
function AuctionLink:PaperDollItemSlotButton_OnClick(button, ignoreModifiers)
	if ( AuctionFrameBrowse:IsVisible() and IsShiftKeyDown() and not ChatFrameEditBox:IsVisible()) then
		local link = GetInventoryItemLink("player", this:GetID())
		local name = string.gsub(link,"^.-%[(.*)%].*", "%1")
		if(IsAltKeyDown()) then
			name = string.gsub(name, " of.-$", "") 
		end
		if(self.db.profile.autosearch) then
			QueryAuctionItems(name)
			BrowseName:SetText(name)
		else
			BrowseName:SetText(name)
		end
	else
		self.hooks.PaperDollItemSlotButton_OnClick(button, ignoreModifiers)
	end
end

function AuctionLink:TradeSkillReagentClick()
	if(IsShiftKeyDown() and AuctionFrameBrowse:IsVisible() and not ChatFrameEditBox:IsVisible()) then
		local link = GetTradeSkillReagentItemLink(TradeSkillFrame.selectedSkill, this:GetID())
		local name = string.gsub(link,"^.-%[(.*)%].*", "%1")
		if(IsAltKeyDown()) then
			name = string.gsub(name, " of.-$", "") 
		end
		if(self.db.profile.autosearch) then
			QueryAuctionItems(name)
			BrowseName:SetText(name)
		else
			BrowseName:SetText(name)
		end
	else
		self.hooks[GetMouseFocus()].OnClick()
	end
end

function AuctionLink:TradeSkillIconClick()
	if(IsShiftKeyDown() and AuctionFrameBrowse:IsVisible() and not ChatFrameEditBox:IsVisible()) then
		local link = GetTradeSkillItemLink(TradeSkillFrame.selectedSkill)
		local name = string.gsub(link,"^.-%[(.*)%].*", "%1")
		if(IsAltKeyDown()) then
			name = string.gsub(name, " of.-$", "") 
		end
		if(self.db.profile.autosearch) then
			QueryAuctionItems(name)
			BrowseName:SetText(name)
		else
			BrowseName:SetText(name)
		end
	else
		self.hooks[TradeSkillSkillIcon].OnClick()
	end
end

function AuctionLink:AuctionsButtonItem()
	if(IsShiftKeyDown() and not ChatFrameEditBox:IsVisible()) then
		local link = GetAuctionItemLink("owner", this:GetParent():GetID() + FauxScrollFrame_GetOffset(AuctionsScrollFrame))
		local name = string.gsub(link,"^.-%[(.*)%].*", "%1")
		if(IsAltKeyDown()) then
			name = string.gsub(name, " of.-$", "") 
		end
		if(self.db.profile.autosearch) then
			AuctionFrameTab_OnClick(1)
			QueryAuctionItems(name)
			BrowseName:SetText(name)
		else
			AuctionFrameTab_OnClick(1)
			BrowseName:SetText(name)
		end
	else
		self.hooks[GetMouseFocus()].OnClick()
	end
end

function AuctionLink:BrowseButtonItem()
	if(IsShiftKeyDown() and not ChatFrameEditBox:IsVisible()) then
		local link = GetAuctionItemLink("list", this:GetParent():GetID() + FauxScrollFrame_GetOffset(BrowseScrollFrame))
		local name = string.gsub(link,"^.-%[(.*)%].*", "%1")
		if(IsAltKeyDown()) then
			name = string.gsub(name, " of.-$", "") 
		end
		if(self.db.profile.autosearch) then
			QueryAuctionItems(name)
			BrowseName:SetText(name)
		else
			BrowseName:SetText(name)
		end
	else
		self.hooks[GetMouseFocus()].OnClick()
	end
end

function AuctionLink:ATSWSkillIcon()
	if(IsShiftKeyDown() and not ChatFrameEditBox:IsVisible()) then
		local link = ATSW_GetTradeSkillItemLink(ATSWFrame.selectedSkill)
		local name = string.gsub(link,"^.-%[(.*)%].*", "%1")
		if(IsAltKeyDown()) then
			name = string.gsub(name, " of.-$", "") 
		end
		if(self.db.profile.autosearch) then
			QueryAuctionItems(name)
			BrowseName:SetText(name)
		else
			BrowseName:SetText(name)
		end
	else
		self.hooks[ATSWSkillIcon].OnClick()
	end
end

function AuctionLink:ATSWReagent()
	if(IsShiftKeyDown() and not ChatFrameEditBox:IsVisible()) then
		local link = ATSW_GetTradeSkillReagentItemLink(ATSWFrame.selectedSkill, this:GetID())
		local name = string.gsub(link,"^.-%[(.*)%].*", "%1")
		if(IsAltKeyDown()) then
			name = string.gsub(name, " of.-$", "") 
		end
		if(self.db.profile.autosearch) then
			QueryAuctionItems(name)
			BrowseName:SetText(name)
		else
			BrowseName:SetText(name)
		end
	else
		self.hooks[GetMouseFocus()].OnClick()
	end
end
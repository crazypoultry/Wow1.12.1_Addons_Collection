--[[ $Id: EQCompare.lua 13770 2006-10-13 08:03:43Z hshh $ ]]--

EQCompare = AceLibrary("AceAddon-2.0"):new("AceHook-2.0", "AceDB-2.0", "AceConsole-2.0")

function EQCompare:OnInitialize()
	self.CMP_INV_SLOT = {
		[INVTYPE_2HWEAPON]={16,17},
		[INVTYPE_BODY]={4},
		[INVTYPE_CHEST]={5},
		[INVTYPE_CLOAK]={15},
		[INVTYPE_FEET]={8},
		[INVTYPE_FINGER]={11,12},
		[INVTYPE_HAND]={10},
		[INVTYPE_HEAD]={1},
		[INVTYPE_HOLDABLE]={17},
		[INVTYPE_LEGS]={7},
		[INVTYPE_NECK]={2},
		[INVTYPE_RANGED]={18},
		[INVTYPE_RELIC]={18},
		[INVTYPE_ROBE]={5},
		[INVTYPE_SHIELD]={17},
		[INVTYPE_SHOULDER]={3},
		[INVTYPE_TABARD]={19},
		[INVTYPE_TRINKET]={13,14},
		[INVTYPE_WAIST]={6},
		[INVTYPE_WEAPON]={16,17},
		[INVTYPE_WEAPONMAINHAND]={16},
		[INVTYPE_WEAPONOFFHAND]={17},
		[INVTYPE_WRIST]={9},
		-- need localization for following
		[INVTYPE_GUN]={18},
		[INVTYPE_CROSSBOW]={18},
		[INVTYPE_WAND]={18},
		[INVTYPE_THROWN]={18},
		[INVTYPE_GUNPROJECTILE]={0},
		[INVTYPE_BOWPROJECTILE]={0},
	}

	--init saved variables
	self:RegisterDB("EQCompareDB")
	self:RegisterDefaults("profile", {
		key = "none",
		hoverLink = false,
		hoverLinkSafe = true
	})

	-- register console slash commands
	self:RegisterChatCommand(
		{ "/eqcompare", "/eqc" },
		{
			type = "group",
			args = {
				key = {
					type = "text",
					name = "key",
					desc = EQCompare_KEY_DESC,
					usage = "<keyname>",
					validate = {"none","ctrl","alt","shift"},
					get = function() return self.db.profile.key end,
					set = function(c)
						self.db.profile.key = c
						self:SetupOriginHook()
					end
				},
				hoverlink = {
					type = "toggle",
					name = "hoverlink",
					desc = EQCompare_HOVERLINK_DESC,
					get = function() return self.db.profile.hoverLink end,
					set = function(c)
						self.db.profile.hoverLink = c
						self:HoverHyperlink_Toggle()
					end
				},
				hoverlink_safe = {
					type = "toggle",
					name = "hoverlink safe mode",
					desc = EQCompare_HOVERLINK_SAFE_DESC,
					get = function() return self.db.profile.hoverLinkSafe end,
					set = function(c)
						self.db.profile.hoverLinkSafe = c
					end
				},
				reset = {
					type = "execute",
					name = "reset",
					desc = EQCompare_RESET_DESC,
					func = function()
						self:ResetDB("profile")
						self:HoverHyperlink_Toggle()
						self:SetupOriginHook()
						self:Print(EQCompare_RESET)
					end
				}
			}
		}
	)
	--save bliz origin functions
	self.origin={ShoppingTooltip1={}, ShoppingTooltip2={}}
	local _G = getfenv(0)
	self.origin.ShoppingTooltip1.SetAuctionCompareItem = _G.ShoppingTooltip1.SetAuctionCompareItem
	self.origin.ShoppingTooltip1.SetMerchantCompareItem = _G.ShoppingTooltip1.SetMerchantCompareItem
	self.origin.ShoppingTooltip2.SetAuctionCompareItem = _G.ShoppingTooltip2.SetAuctionCompareItem
	self.origin.ShoppingTooltip2.SetMerchantCompareItem = _G.ShoppingTooltip2.SetMerchantCompareItem
end

function EQCompare:OnEnable()
	self:Hook("SetItemRef")
	self:HookScript(ItemRefTooltip, "OnHide", "Tooltip_OnHide")
	self:HookScript(GameTooltip, "OnShow", "Tooltip_OnShow")
	self:HoverHyperlink_Toggle()
	self:Compatibility()
	self:SetupOriginHook()
end

function EQCompare:OnDisable()
	self:Compatibility()
	self:SetupOriginHook(true)
end

function EQCompare:GetInventorySlot(tooltip)
	--possible texts starting at 2nd line. the first line is item name
	for i=2,5 do
		local text=getglobal(tooltip:GetName().."TextLeft"..i):GetText()
		if text and self.CMP_INV_SLOT[text] then
			local match_inv = self.CMP_INV_SLOT[text]

			-- check used slot
			local slot = {}
			for _,v in ipairs(match_inv) do
				local item=GetInventoryItemLink("player",v)
				if item then
					tinsert(slot, v)
				end
			end
			return slot
		end
	end
	return {}
end

function EQCompare:Tooltip_OnShow(object)
	--call origin script hook except ItemRefTooltip
	--call this at first may fix a lot problem, and keep compat with other mods
	if object ~= ItemRefTooltip then
		self.hooks[object].OnShow()
	end

	--check object if valid
	if type(object)~="table" then return end

	--check compare holding key
	if not self:CheckHoldKey() then return end

	--bypass these frame, WorldFrame, player's paperdoll, weapon enchants
	local frame=GetMouseFocus() and GetMouseFocus():GetName() or ""
	if frame == "WorldFrame" or strfind(frame,"^Character.*Slot$") or strfind(frame,"^TempEnchant%d+$")	then return end

	--check if any matched inventory items
	local slot = self:GetInventorySlot(object)
	if getn(slot) == 0 then return end

	--use custom tooltip to display compare info for ItemRefTooltip.
	--so it's stick display while mouse hover other things.
	local tooltip
	if object == ItemRefTooltip then
		tooltip = "EQCompareTooltip"
	else
		tooltip = "ShoppingTooltip"
	end

	--place code copy from QuickCompare, correct anchor if tooltip is in right half of screen
	local anchor,align="TOPLEFT","TOPRIGHT"
	local scale=object:GetScale()
	local tipleft=object:GetLeft()
	if tipleft and tipleft*scale>=UIParent:GetRight()/2 then
		anchor, align = align, anchor
	end
	local anchorframe = object
	local dy=-10*scale

	--display compare tooltip matched inv slot
	for i,invslot in ipairs(slot) do
		local shoptip=getglobal(tooltip..i)
		local shoptiptext=getglobal(shoptip:GetName().."TextLeft1")

		shoptip:SetOwner(object, "ANCHOR_NONE")
		shoptip:SetInventoryItem("player",invslot)
		shoptip:SetScale(scale)
		--reset tooltip point, so it can get the correct bottom and top position later.
		shoptip:ClearAllPoints()
		shoptip:SetPoint(anchor,anchorframe,align,0,dy)

		--show Currently Equipped in lightyellow
		local oldtext=shoptiptext:GetText() or ""
		local newtext=LIGHTYELLOW_FONT_COLOR_CODE..CURRENTLY_EQUIPPED.. FONT_COLOR_CODE_CLOSE.."\n"
		shoptiptext:SetText(newtext..oldtext)
		shoptiptext:SetJustifyH("LEFT")

		--place code copy from QuickCompare, correct placement, don't go off screen
		--coords get larger as move up: 0 at bottom, screen height at top
		local bottom,top=shoptip:GetBottom(),shoptip:GetTop()
		local uibottom,uitop=UIParent:GetBottom(),UIParent:GetTop()
		if bottom and bottom*scale-10<=uibottom then
			--10 for padding
			dy=uibottom-bottom+(10*scale)
		elseif top and (top+32)*scale>=uitop then
			--32 for icon
			top=(top+32)*scale
			dy=uitop-top-20
		end
		shoptip:ClearAllPoints()
		shoptip:SetPoint(anchor,anchorframe,align,0,dy)

		if (IsAddOnLoaded("oSkin")) then
			oSkin:skinTooltip(shoptip)
		end
		
		shoptip:Show()

		--last comparison tooltip becomes anchorframe for next comparison tooltip
		anchorframe=shoptip
		dy=0
	end
end

--[[ Hook SetItemRef, for display compare tooltip while clicked hyperlink in ChatFrame ]]--
function EQCompare:SetItemRef(link, text, button)
	self.hooks.SetItemRef(link, text, button)

	--only process tooltip for item
	if strfind(link,"^item") then
		--because SetItemRef will not display item tooltip while holding shift and ctrl key
		local key = self:CheckHoldKey()
		if key and key~="none" and key~="alt" then
			ShowUIPanel(ItemRefTooltip);
			if ( not ItemRefTooltip:IsVisible() ) then
				ItemRefTooltip:SetOwner(UIParent, "ANCHOR_PRESERVE");
			end
			ItemRefTooltip:SetHyperlink(link);
		end

		EQCompareTooltip1:Hide()
		EQCompareTooltip2:Hide()
		self:Tooltip_OnShow(ItemRefTooltip)
	end
end

--[[ Custom tooltip OnHide codes ]]--
function EQCompare:Tooltip_OnHide(object)
	self.hooks[object].OnHide()
	EQCompareTooltip1:Hide()
	EQCompareTooltip2:Hide()
end

--[[ ShoppingTooltip OnHide codes ]]--
function EQCompare:ShoppingTooltip_OnHide(object)
	self.hooks[object].OnHide()
	ShoppingTooltip1:Hide()
	ShoppingTooltip2:Hide()
end

--[[ Codes for display tooltip while mouse hovering hyperlink in ChatFrame ]]--
function EQCompare:CheckHoldKey()
	local key = self.db.profile.key
	if key == "none" then
		return "none"
	elseif key == "ctrl" and IsControlKeyDown() then
		return "ctrl"
	elseif key == "alt" and IsAltKeyDown() then
		return "alt"
	elseif key == "shift" and IsShiftKeyDown() then
		return "shift"
	end
end

function EQCompare:HoverHyperlink_Toggle()
	if self.db.profile.hoverLink then
		for i=1, NUM_CHAT_WINDOWS do
			local frame=getglobal("ChatFrame"..i)
			if not self:IsHooked(frame, "OnHyperlinkEnter") then
				self:HookScript(frame, "OnHyperlinkEnter")
			end
			if not self:IsHooked(frame, "OnHyperlinkLeave") then
				self:HookScript(frame, "OnHyperlinkLeave")
			end
		end
	else
		for i=1, NUM_CHAT_WINDOWS do
			local frame=getglobal("ChatFrame"..i)
			if self:IsHooked(frame, "OnHyperlinkEnter") then
				self:Unhook(frame, "OnHyperlinkEnter")
			end
			if self:IsHooked(frame, "OnHyperlinkLeave") then
				self:Unhook(frame, "OnHyperlinkLeave")
			end
		end
	end
end

function EQCompare:OnHyperlinkEnter(object)
	--checking if hoverlink feature is enabled
	if not self.db.profile.hoverLink then
		self:HoverHyperlink_Toggle()
		return self.hooks[object].OnHyperlinkEnter()
	end
	--chekcing holding key
	if not self:CheckHoldKey() then
		return self.hooks[object].OnHyperlinkEnter()
	end

	--copy from QuickCompare
	local link=arg1

	--only display tooltip for item or enchanting
	if strfind(link,"^item") then
		--process safe check for item link, don't disconnect me.
		local name,elink,quality=GetItemInfo(link)

		if self.db.profile.hoverLinkSafe then
			if name then
				GameTooltip:SetOwner(object,"ANCHOR_TOPRIGHT")
				GameTooltip:SetHyperlink(link)
				GameTooltip:Show()

				--Auctioneer/Enchantrix/EnhTooltip/Informant support
				if (EnhTooltip and elink and quality) then
					local item = EnhTooltip.FakeLink(elink, quality, name)
					EnhTooltip.TooltipCall(GameTooltip, name, item, quality)
				end
			end
		else
			GameTooltip:SetOwner(object,"ANCHOR_TOPRIGHT")
			GameTooltip:SetHyperlink(link)
			GameTooltip:Show()

			--Auctioneer/Enchantrix/EnhTooltip/Informant support
			if (EnhTooltip and name and elink and quality) then
				local item = EnhTooltip.FakeLink(elink, quality, name)
				EnhTooltip.TooltipCall(GameTooltip, name, item, quality)
			end
		end

	elseif strfind(link,"^enchant") then
		GameTooltip:SetOwner(object,"ANCHOR_TOPRIGHT")
		GameTooltip:SetHyperlink(link)
		GameTooltip:Show()
	end

	return self.hooks[object].OnHyperlinkEnter()
end

function EQCompare:OnHyperlinkLeave(object)
	if not self.db.profile.hoverLink then
		self:HoverHyperlink_Toggle()
	end
	GameTooltip:Hide()
	return self.hooks[object].OnHyperlinkLeave()
end

--[[ Support for other mod to register tooltip hook ]]--
function EQCompare:RegisterTooltip(tooltip)
	if type(tooltip)~="table" then return end

	if not self:IsHooked(tooltip, "OnShow") then
		self:HookScript(tooltip, "OnShow", "Tooltip_OnShow")
	end
	if not self:IsHooked(tooltip, "OnHide") then
		self:HookScript(tooltip, "OnHide", "ShoppingTooltip_OnHide")
	end
end

function EQCompare:UnRegisterTooltip(tooltip)
	if type(tooltip)~="table" then return end

	if self:IsHooked(tooltip, "OnShow") then
		self:Unhook(tooltip, "OnShow")
	end
	if self:IsHooked(tooltip, "OnHide") then
		self:Unhook(tooltip, "OnHide")
	end
end

--[[ Compat codes ]]--
function EQCompare:Compatibility()
	if self:IsActive() then
		--compat EquipCompare
		EquipCompare_RegisterTooltip=function(t) EQCompare:RegisterTooltip(t) end
		EquipCompare_UnregisterTooltip=function(t) EQCompare:UnRegisterTooltip(t) end
		--compat AtlasLoot
		if AtlasLootTooltip then
			AtlasLootOptionsFrameEquipCompare:Enable()
			AtlasLootOptionsFrameEquipCompareText:SetText(ATLASLOOT_OPTIONS_EQUIPCOMPARE)
			AtlasLootOptions.EquipCompare = true
			self:RegisterTooltip(AtlasLootTooltip)
		end

	--EQC disable codes
	else
		--compat EquipCompare
		EquipCompare_RegisterTooltip=nil
		EquipCompare_UnregisterTooltip=nil
		--compat AtlasLoot
		if AtlasLootTooltip then
			AtlasLootOptionsFrameEquipCompare:Disable()
			AtlasLootOptionsFrameEquipCompareText:SetText(ATLASLOOT_OPTIONS_EQUIPCOMPARE_DISABLED)
			AtlasLootOptions.EquipCompare = false
			self:UnRegisterTooltip(AtlasLootTooltip)
		end
	end
end

--[[ Setup Bliz origin compare tooltip hook for holding key enabled ]]--
function EQCompare:SetupOriginHook(unload)
	--restore origin functions
	if self.db.profile.key=="none" or unload then
		ShoppingTooltip1.SetAuctionCompareItem = self.origin.ShoppingTooltip1.SetAuctionCompareItem
		ShoppingTooltip1.SetMerchantCompareItem = self.origin.ShoppingTooltip1.SetMerchantCompareItem
		ShoppingTooltip2.SetAuctionCompareItem = self.origin.ShoppingTooltip2.SetAuctionCompareItem
		ShoppingTooltip2.SetMerchantCompareItem = self.origin.ShoppingTooltip2.SetMerchantCompareItem
	else
		ShoppingTooltip1.SetAuctionCompareItem = function(a1,a2,a3,a4,a5)
			if EQCompare:CheckHoldKey() then
				return EQCompare.origin.ShoppingTooltip1.SetAuctionCompareItem(a1,a2,a3,a4,a5)
			end
		end
		ShoppingTooltip1.SetMerchantCompareItem = function(a1,a2,a3,a4,a5)
			if EQCompare:CheckHoldKey() then
				return EQCompare.origin.ShoppingTooltip1.SetMerchantCompareItem(a1,a2,a3,a4,a5)
			end
		end
		ShoppingTooltip2.SetAuctionCompareItem = function(a1,a2,a3,a4,a5)
			if EQCompare:CheckHoldKey() then
				return EQCompare.origin.ShoppingTooltip2.SetAuctionCompareItem(a1,a2,a3,a4,a5)
			end
		end
		ShoppingTooltip2.SetMerchantCompareItem = function(a1,a2,a3,a4,a5)
			if EQCompare:CheckHoldKey() then
				return EQCompare.origin.ShoppingTooltip2.SetMerchantCompareItem(a1,a2,a3,a4,a5)
			end
		end
	end
end

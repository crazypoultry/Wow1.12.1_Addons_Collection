-- Version & Date
local MAJOR_VERSION = "2.0"
local MINOR_VERSION = tonumber((string.gsub("$Revision: 19279 $", "^.-(%d+).-$", "%1")))

-- Libs
AH_Wipe = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceDB-2.0", "AceConsole-2.0")
local L = AceLibrary("AceLocale-2.2"):new("AH_Wipe")

-- About
local AH_Wipe = AH_Wipe
AH_Wipe.title =  "AH Wipe"
AH_Wipe.version = MAJOR_VERSION .. "." .. MINOR_VERSION
AH_Wipe.date = string.gsub("$Date: 2006-12-05 20:51:46 -0500 (Tue, 05 Dec 2006) $", "^.-(%d%d%d%d%-%d%d%-%d%d).-$", "%1")


-- OnInitialize
function AH_Wipe:OnInitialize()
	self:RegisterDB("AH_WipeDB")
	self:RegisterDefaults('profile', {
		Show = true,
		Tooltip = true,
		HideDR = true,
		PosX = 746,
		PosY = -14
	})

	self:MakeButton()
	
	local options = {
		desc = L["AH Wipe options"],
		type = "group",
		args = {
			restore = {
				name = L["Restore"],
				desc = L["Restores the button to its default position"],
				type = "execute",
				func = function()
					self.db.profile.PosX = 746
					self.db.profile.PosY = -14
					AHWButton:ClearAllPoints()
					AHWButton:SetPoint("TOPLEFT", "AuctionFrameBrowse", "TOPLEFT", 746, -14)
				end,
			},
			clear = {
				name = L["Clear"],
				desc = L["Resets the AH-Browse view to its defaults"],
				type = "execute",
				func = "Wipe",
			},
			hidedr = {
				name = L["Hide Dressing-Room"],
				desc = L["Hides the Dressing-Room on reset."],
				type = "toggle",
				get = function() return self.db.profile.HideDR end,
				set = function(val) self.db.profile.HideDR = val end,
			},
			show = {
				name = L["Show"],
				desc = L["Shows or hides the button."],
				type = "toggle",
				get = function() return self.db.profile.Show end,
				set = function(val)
					self.db.profile.Show = val
					if self.db.profile.Show then
						AHWButton:Show()
					else
						AHWButton:Hide()
					end
				end,
			},
			auto = {
				name = L["Auto"],
				desc = L["Resets automatically on opening the auction frame."],
				type = "toggle",
				get = function() return self.db.profile.Auto end,
				set = function(val) self.db.profile.Auto = val end,
			},
			tooltip = {
				name = L["Tooltip"],
				desc = L["Toggles the tooltip display."],
				type = "toggle",
				get = function() return self.db.profile.Tooltip end,
				set = function(val) self.db.profile.Tooltip = val end,
			},
			usable = {
				name = L["Usable"],
				desc = L["Disable usable items on reset."],
				type = "toggle",
				get = function() return self.db.profile.Usable end,
				set = function(val) self.db.profile.Usable = val end,
			},

		},
	}
	AH_Wipe:RegisterChatCommand({"/ahw", "/ahwipe"}, options)
end

-- Make Button (great job done by phyber)
function AH_Wipe:MakeButton()
	local AHWButton = CreateFrame("Button", "AHWButton", AuctionFrameBrowse, "UIPanelButtonTemplate")
	AHWButton:SetWidth(60)
	AHWButton:SetHeight(19)
	AHWButton:SetMovable(true)
	AHWButton:RegisterForDrag("RightButton")
	AHWButton:RegisterForClicks("LeftButtonDown")
	AHWButton:SetScript("OnClick", function() self:Wipe() end)
	AHWButton:SetScript("OnDragStart", function()
		if IsShiftKeyDown() then
			AHWButton:StartMoving()
		end
	end)
	AHWButton:SetScript("OnDragStop", function()
		AHWButton:StopMovingOrSizing()
		self:SavePosition()
	end)
	AHWButton:SetScript("OnEnter", function() self:Tooltip() end)
	AHWButton:SetScript("OnLeave", function() GameTooltip:Hide() end)
	AHWButton:SetFrameStrata("HIGH")
	AHWButton:SetPoint("TOPLEFT", "AuctionFrameBrowse", "TOPLEFT", self.db.profile.PosX, self.db.profile.PosY)
	AHWButton:SetText(L["Reset"])
	AHWButton:Hide()
end

-- OnEnable
function AH_Wipe:OnEnable()
	self:RegisterEvent("AUCTION_HOUSE_SHOW", "Start")
end

-- OnDisable
function AH_Wipe:OnDisable()
	AHWButton:Hide()
end

function AH_Wipe:Start()
	if self.db.profile.Show then 
		AHWButton:Show()
	end
	if self.db.profile.Auto then
		self:Wipe()
	end
end

function AH_Wipe:Tooltip()
	if self.db.profile.Tooltip then
		GameTooltip_SetDefaultAnchor(GameTooltip, this)
		GameTooltip:AddLine(L["AH Wipe"])
		GameTooltip:AddLine(L["Resets the browser view to its defaults."], 1, 1, 1)
		GameTooltip:Show()
	end
end

function AH_Wipe:SavePosition()
	local cx, cy = AuctionFrameBrowse:GetLeft(), AuctionFrameBrowse:GetTop() 
	local ax, ay = AHWButton:GetLeft(), AHWButton:GetTop() 
	self.db.profile.PosX = ax - cx
	self.db.profile.PosY = ay - cy
	AHWButton:ClearAllPoints()
	AHWButton:SetPoint("TOPLEFT", "AuctionFrameBrowse", "TOPLEFT", self.db.profile.PosX, self.db.profile.PosY)
end

--[[-------------------------------------
	The function Blizzard never gave to us.
----------------------------------------]]

function AH_Wipe:Wipe()
	PlaySound("igMainMenuOptionCheckBoxOn")
	if self.db.profile.Usable then
		IsUsableCheckButton:SetChecked(false)
	end
	UIDropDownMenu_SetSelectedValue(BrowseDropDown, -1)
	AuctionFrameBrowse.selectedClass = nil
	AuctionFrameBrowse.selectedClassIndex = nil
	AuctionFrameFilters_Update()
	BrowseName:SetText("")
	BrowseName:SetFocus()
	BrowseMinLevel:SetText("")
	BrowseMaxLevel:SetText("")
	AuctionDressUpModel:Dress()
	if self.db.profile.HideDR then
		ShowOnPlayerCheckButton:SetChecked(false)
		SHOW_ON_CHAR = "0"
		HideUIPanel(AuctionDressUpFrame)
	end
end
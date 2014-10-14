local AuctionsFu = AceLibrary("AceAddon-2.0"):new("FuBarPlugin-2.0", "AceDB-2.0", "AceEvent-2.0") --"AceConsole-2.0")
local Tablet = AceLibrary("Tablet-2.0")
AuctionsFu:RegisterDB("FuBar_AuctionsFu_DB");
--AuctionsFu:RegisterDefaults('profile', {
--	AutoScan = true
--})


AuctionsFu.name = "FuBarAuctionsFu-2.0"
AuctionsFu.hasIcon = "Interface\\Icons\\INV_Misc_Bell_01.blp"
AuctionsFu.author = "Warloxx"
AuctionsFu.category = "Auction"


AuctionsFu.UpdateInterval = 2;
AuctionsFu.LastUpdate = GetTime();

AuctionsFu.TimeFormat = "%02d:%02d";

AuctionsFu.Status = { 	Active = 1,
						Outbid = 2,
						Won = 3,
						Expired = 4,
						Sold = 5
					}

AuctionsFu.MouseOnButton = false;

-- stored the item where last update occured
AuctionsFu.LastUpdateItem = nil;
-- if update was already noticed
AuctionsFu.UpdateNoticed = false;
-- flag for no auto update if needed, set true
AuctionsFu.AH_DontUpdate = false;
-- if present data is accurate
AuctionsFu.Data_Accurate = {false,false,false};

AuctionsFu.LocaleString = { "Alliance", "Steamwheedle Cartel", "Horde" };

 
				--ItemArray
-- 1 - name
-- 2 - texture
-- 3 - amount
-- 4 - quality
-- 5 - canUse
-- 6 - reqLevel
-- 7 - minBid
-- 8 - minIncrement
-- 9 - buyOutPrice
--10 - bidAmount
--11 - highBidder
--12 - owner
--13 - itemID (linkID)
--14 - timeLeft (0-none,1-short,2-medium,3-long,4-verylong)
--15 - presentStatus (s.a for codes)
--16 - statusString, 3x color codes
--17 - expiry/won/sold time

function AuctionsFu:OnInitialize()
	
	self.Updateframe = CreateFrame("Frame", nil, UIParent);
	self.Updateframe:SetScript("OnUpdate", self.OnUpdate)
	
	frame = self:GetFrame()
	if frame then
		self.OnEnterOrg = frame:GetScript("OnEnter")
		--self.OnEnterNew = function() (( (type(self.OnEnterOrg)=="function") and (self:OnEnterOrg(); self.MouseOnButton = true)) or self.MouseOnButton = true) self:Update() end
		self.OnEnterNew = 	function() 
								if self.OnEnterOrg and type(self.OnEnterOrg)=="function" then
									self:OnEnterOrg()
								end
								self.MouseOnButton = true
								--DEFAULT_CHAT_FRAME:AddMessage("OnEnter")
								self:Update()
							end
		
		
		frame:SetScript("OnEnter", self.OnEnterNew)
		
		self.OnLeaveOrg = frame:GetScript("OnLeave")
		--self.OnLeaveNew = function() (( (type(self.OnLeaveOrg)=="function") and (self:OnLeaveOrg(); self.MouseOnButton = false)) or self.MouseOnButton = false) self:Update() end
		self.OnLeaveNew = 	function() 
								if self.OnLeaveOrg and type(self.OnLeaveOrg)=="function" then
									self:OnLeaveOrg()
								end
								self.MouseOnButton = false
								--DEFAULT_CHAT_FRAME:AddMessage("OnLeave")
								self:Update()
							end
		frame:SetScript("OnLeave", self.OnLeaveNew)
	else
		DEFAULT_CHAT_FRAME:AddMessage(self.name .. ": No frame found")
	end
	
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:RegisterEvent("UNIT_NAME_UPDATE")
	self:RegisterEvent("AUCTION_HOUSE_CLOSED")
	self:RegisterEvent("AUCTION_HOUSE_SHOW")
	self:RegisterEvent("CHAT_MSG_SYSTEM")
	--self:RegisterChatCommand( { "/fbauc" }, optionsTable )
end
--[[
function AuctionsFu:OnEvent()
	--DEFAULT_CHAT_FRAME:AddMessage("OnEvent event=" .. event)
	--if (event == "PLAYER_ENTERING_WORLD") then
		--if(myAddOnsList) then
			--  myAddOnsList.TitanAuctions = {name = BINDING_HEADER_TitanAuctions, description = "Check your auctions from anywhere, updateAuctionsFus you when you win/lose/etc", version = TitanAuctions_VERSION, category = MYADDONS_CATEGORY_INVENTORY, frame = "TitanAuctionsMain"};
		--end
	if (event == "AUCTION_HOUSE_SHOW") then
		--DEFAULT_CHAT_FRAME:AddMessage("Auctions Opened");
		self.AuctionIsOpen = true;
		if (AuctionsFu:Is("AutoScan")) then
			AuctionsFu:ScanAH();
			AuctionsFu:Update()
		else
			AuctionsFu:Update()
		end
	elseif (event == "CHAT_MSG_SYSTEM") then
		--DEFAULT_CHAT_FRAME:AddMessage("System Msg : "..arg1);
		AuctionsFu:GetMessage(arg1);
	elseif (event == "AUCTION_HOUSE_CLOSED") then
		--DEFAULT_CHAT_FRAME:AddMessage("Auctions Closed");
		self.AuctionIsOpen = false;
		AuctionsFu:Update()
	elseif ((event == "PLAYER_ENTERING_WORLD") or (event == "UNIT_NAME_UPDATE" and arg1 == 'player')) then
		local pName = UnitName("player");
		if ((pName ~= nil) and (pname ~= UNKNOWNOBJECT) and (pname ~= UKNOWNBEING)) then
			if (not AuctionsFuSave) then AuctionsFuSave = {}; end
			self.myName = pName;
			self.myRealm = GetCVar("realmName");
			AuctionsFu:SetTable();
		end
	end
end
]]
function AuctionsFu:AUCTION_HOUSE_SHOW()
	--DEFAULT_CHAT_FRAME:AddMessage("Auction opend")
	self.AuctionIsOpen = true;
	if (self:Is("AutoScan")) then
		self:ScanAH();
		self:Update()
	else
		self:Update()
	end
end
function AuctionsFu:AUCTION_HOUSE_CLOSED()
	--DEFAULT_CHAT_FRAME:AddMessage("Auction closed")
	self.AuctionIsOpen = false;
	self:Update()
end

function AuctionsFu:CHAT_MSG_SYSTEM()
	self:GetMessage(arg1);
end

function AuctionsFu:PLAYER_ENTERING_WORLD()
	--DEFAULT_CHAT_FRAME:AddMessage("EnterWorld")
	local pName = UnitName("player");
	if ((pName ~= nil) and (pname ~= UNKNOWNOBJECT) and (pname ~= UKNOWNBEING)) then
		if (not AuctionsFuSave) then AuctionsFuSave = {}; end
		self.myName = pName;
		self.myRealm = GetCVar("realmName");
		--DEFAULT_CHAT_FRAME:AddMessage("Set Name and realm" .. self.myName .. " " .. self.myRealm)
		self:SetTable();
	end
end
function AuctionsFu:UNIT_NAME_UPDATE()
	--DEFAULT_CHAT_FRAME:AddMessage("Name Update")
	if arg1 == 'player' then
		local pName = UnitName("player");
		if ((pName ~= nil) and (pname ~= UNKNOWNOBJECT) and (pname ~= UKNOWNBEING)) then
			if (not AuctionsFuSave) then AuctionsFuSave = {}; end
			self.myName = pName;
			self.myRealm = GetCVar("realmName");
			--DEFAULT_CHAT_FRAME:AddMessage("Set Name and realm" .. self.myName .. " " .. self.myRealm)
			self:SetTable();
		end
	end
end

function AuctionsFu:OnClick(button)
	if (button == "LeftButton") then
		if (IsShiftKeyDown()) then
			self:UpdateTooltip()
		elseif (self.AuctionIsOpen) then
			self:ScanAH();
		end
	end
end


function AuctionsFu:OnTextUpdate()
	if (not AuctionsFuSave) then
		self:SetText("Auctions");
		return
	end
	
	local tn = self.myName;
	local tr = self.myRealm;

	local hideText = self:Is("HideText");
	local smallText = self:Is("SmallButton");
	local showIcon = self:IsIconShown();
	local colortxt = "";

	if (self.LastUpdateItem) and (self.UpdateNoticed == false) then
		color = {};
		color.r = self.LastUpdateItem[16][2];
		color.g = self.LastUpdateItem[16][3];
		color.b = self.LastUpdateItem[16][4];
		
		if (hideText) then
			colortxt = self:GetColoredText(AUCTIONSFU_PANELTEXT_UPDATE_SMALL, color);
		else
			colortxt = self:GetColoredText(AUCTIONSFU_PANELTEXT_UPDATE, color);
		end
		self:SetText(colortxt)
		return
	end

	if (hideText) and (not self.AuctionIsOpen) and (AuctionsFu.MouseOnButton == false) then
		if (not showIcon) then
			colortxt = "A";
		end
	else
		local totalAuctions = 0;
		local totalBids =0;
		for j = 1, 3, 1 do
			if ( (AuctionsFuSave[tn][tr].Owner[j].num) and (AuctionsFuSave[tn][tr].Bidder[j].num) ) then
				totalAuctions = totalAuctions + AuctionsFuSave[tn][tr].Owner[j].num[2];
				totalBids = totalBids + AuctionsFuSave[tn][tr].Bidder[j].num[2];
			end
		end
		self:SetText("" .. ((smallText and AUCTIONSFU_PANELTEXT_AUCTIONS_SMALL) or AUCTIONSFU_PANELTEXT_AUCTIONS) .. self:GetHighlightText(totalAuctions) .. " " .. ((smallText and AUCTIONSFU_PANELTEXT_BIDS_SMALL) or AUCTIONSFU_PANELTEXT_BIDS) .. self:GetHighlightText(totalBids))
		return
	end
	
	
    self:SetText(colortxt)
end

AuctionsFu.OldToggleIconShown = AuctionsFu.ToggleIconShown
AuctionsFu.ToggleIconShown = function() AuctionsFu:OldToggleIconShown() AuctionsFu:Update() end

function AuctionsFu:GetHighlightText(text)
	if (text) then
		return HIGHLIGHT_FONT_COLOR_CODE..text..FONT_COLOR_CODE_CLOSE;
	end
end

function AuctionsFu:GetMoneyText(money)
  -- Breakdown the money into denominations
  local gold = floor(money / (COPPER_PER_SILVER * SILVER_PER_GOLD));
  local silver = floor((money - (gold * COPPER_PER_SILVER * SILVER_PER_GOLD)) / COPPER_PER_SILVER);
  local copper = mod(money, COPPER_PER_SILVER);  
  
  local txt = "";
  if (gold > 0) then
  	txt = txt .. self:GetColoredText(gold, {r=1,g=0.7,b=0} ).." ";
  	txt = txt .. self:GetColoredText(silver, {r=0.7098,g=0.7215,b=0.6117} ).." ";
  else
  	if (silver > 0) then
  		txt = txt .. self:GetColoredText(silver, {r=0.7098,g=0.7215,b=0.6117} ).." ";
  	end
  end
  txt = txt .. self:GetColoredText(copper, {r=0.8431,g=0.3647,b=0.2078} );
  	
  return txt;
end
function AuctionsFu:GetColoredText(text, color)
	if (text and color) then
		local redColorCode = format("%02x", color.r * 255);		
		local greenColorCode = format("%02x", color.g * 255);
		local blueColorCode = format("%02x", color.b * 255);		
		local colorCode = "|cff"..redColorCode..greenColorCode..blueColorCode;
		return colorCode..text..FONT_COLOR_CODE_CLOSE;
	end
end

function AuctionsFu:OnTooltipUpdate()
    local cat = Tablet:AddCategory(
        'columns', 1
    )
    
	local rtxt = "";
	
	if (self.AuctionIsOpen) then
		cat:AddLine('text', AUCTIONSFU_TOOLTIPTEXT_IN_AH)
	end

	local ahs = self:GetNumAuctionHousesUsed();

	if ( ahs == 0 ) then
		cat:AddLine('text', AUCTIONSFU_TOOLTIPTEXT_NO_AUCTIONS_NO_BIDS)
		return
	end


	local tn = self.myName;
	local tr = self.myRealm;
  
	local needSeperate = false;
	local totalItems = 0;
	for j = 1, 3, 1 do
		if ( (AuctionsFuSave[tn][tr].Owner[j].num) and (AuctionsFuSave[tn][tr].Bidder[j].num) ) then
			if ( (AuctionsFuSave[tn][tr].Owner[j].num[2] > 0) or (AuctionsFuSave[tn][tr].Bidder[j].num[2] > 0) ) then
				totalItems = totalItems + 3; --for each autionhouse need xtra lines
				totalItems = totalItems + AuctionsFuSave[tn][tr].Owner[j].num[2] + AuctionsFuSave[tn][tr].Bidder[j].num[2];
			end
		end
	end  
	if (totalItems >28) then
		needSeperate = true;
	end
	
	
	local showExpiry = self:Is("ExpTime")
	local showEvent = self:Is("EventTime")
	
	for j = 1, 3, 1 do
		if ( (AuctionsFuSave[tn][tr].Owner[j].num) and (AuctionsFuSave[tn][tr].Bidder[j].num) ) then
			if ( (AuctionsFuSave[tn][tr].Owner[j].num[2] > 0) or (AuctionsFuSave[tn][tr].Bidder[j].num[2] > 0) ) then
	
				rtxt = rtxt .. self.LocaleString[j] .." [";
				local timeText = "";
				if (AuctionsFuSave[tn][tr].Bidder[j].time) then
					timeText = format(TEXT(self.TimeFormat), AuctionsFuSave[tn][tr].Bidder[j].time[1],AuctionsFuSave[tn][tr].Bidder[j].time[2]);
				end
				if (self.Data_Accurate[j]) then
					rtxt = rtxt .. self:GetColoredText(AUCTIONSFU_TOOLTIPTEXT_VALID .. timeText, {r=0,g=1,b=0} ) .. "]\n";
				else
					rtxt = rtxt .. self:GetColoredText(AUCTIONSFU_TOOLTIPTEXT_UNSURE .. timeText, {r=1,g=0,b=0} ) .. "]\n";
				end
				
				if (AuctionsFuSave[tn][tr].Owner[j].num[2] > 0)  and ((not IsShiftKeyDown() or (not needSeperate)) ) then
					--DEFAULT_CHAT_FRAME:AddMessage("Aucts "..AuctionsFuSave[tn][tr].Owner[j].num[2].." "..j);
					rtxt = rtxt .. "  " .. AUCTIONSFU_PANELTEXT_AUCTIONS;
					
					if (AuctionsFuSave[tn][tr].Owner[j].money) then
						rtxt = rtxt .. AUCTIONSFU_TOOLTIPTEXT_MINBID .. self:GetMoneyText(AuctionsFuSave[tn][tr].Owner[j].money.minbidValue);
						rtxt = rtxt .. AUCTIONSFU_TOOLTIPTEXT_BUYOUT .. self:GetMoneyText(AuctionsFuSave[tn][tr].Owner[j].money.buyoutValue);
						if (AuctionsFuSave[tn][tr].Owner[j].money.bids > 0 ) then
							rtxt = rtxt .. AUCTIONSFU_TOOLTIPTEXT_BIDS .. self:GetMoneyText(AuctionsFuSave[tn][tr].Owner[j].money.bids);
						end
					end
					cat:AddLine('text', rtxt)
					rtxt = "";
					
					for i = 1, AuctionsFuSave[tn][tr].Owner[j].num[2], 1 do
						rtxt = rtxt .. "  ";
						if (AuctionsFuSave[tn][tr].Owner[j].item[i][3] > 0) then
							rtxt = rtxt .. AuctionsFuSave[tn][tr].Owner[j].item[i][3] .. "x ";
						end
						rtxt = rtxt .. self:GetColoredText(AuctionsFuSave[tn][tr].Owner[j].item[i][1], ITEM_QUALITY_COLORS[AuctionsFuSave[tn][tr].Owner[j].item[i][4]]);
						
						local color = {};
						color.r = AuctionsFuSave[tn][tr].Owner[j].item[i][16][2];
						color.g = AuctionsFuSave[tn][tr].Owner[j].item[i][16][3];
						color.b = AuctionsFuSave[tn][tr].Owner[j].item[i][16][4];
						
						if (showEvent) and (not (AuctionsFuSave[tn][tr].Owner[j].item[i][15]== self.Status.Active)) and (AuctionsFuSave[tn][tr].Owner[j].item[i][17]) then
							rtxt = rtxt .. " (" .. format(TEXT(self.TimeFormat), AuctionsFuSave[tn][tr].Owner[j].item[i][17][1],AuctionsFuSave[tn][tr].Owner[j].item[i][17][2]) .. ")";
						end
						
						rtxt = rtxt .."\t";
						
						if (showExpiry) then
							if (AuctionsFuSave[tn][tr].Owner[j].item[i][15]== self.Status.Active) or (AuctionsFuSave[tn][tr].Owner[j].item[i][15]== self.Status.Outbid) then
								rtxt = rtxt .. self:CalculateExpiryTimes(AuctionsFuSave[tn][tr].Owner[j].item[i][14],AuctionsFuSave[tn][tr].Owner[j].time);
							end
						end
						
						rtxt = rtxt .. " [" .. self:GetColoredText(AuctionsFuSave[tn][tr].Owner[j].item[i][16][1],color) .. "]";
						cat:AddLine('text', rtxt)
						rtxt = "";
					end          
				end        
				if (AuctionsFuSave[tn][tr].Bidder[j].num[2] > 0) and  ((IsShiftKeyDown() or (not needSeperate)) ) then
					--DEFAULT_CHAT_FRAME:AddMessage("Bids "..AuctionsFuSave[tn][tr].Bidder[j].num[2].." "..j);
					rtxt = rtxt .. "  ".. AUCTIONSFU_PANELTEXT_BIDS;
					
					if (AuctionsFuSave[tn][tr].Bidder[j].money) then
						rtxt = rtxt .. AUCTIONSFU_TOOLTIPTEXT_MINBID .. self:GetMoneyText(AuctionsFuSave[tn][tr].Bidder[j].money.minbidValue);
						rtxt = rtxt .. AUCTIONSFU_TOOLTIPTEXT_BUYOUT .. self:GetMoneyText(AuctionsFuSave[tn][tr].Bidder[j].money.buyoutValue);
					end
					
					cat:AddLine('text', rtxt)
					rtxt = "";
					for i = 1, AuctionsFuSave[tn][tr].Bidder[j].num[2], 1 do
						rtxt = rtxt .. "  " .. self:GetColoredText(AuctionsFuSave[tn][tr].Bidder[j].item[i][1], ITEM_QUALITY_COLORS[AuctionsFuSave[tn][tr].Bidder[j].item[i][4]]);
						
						local color = {};
						color.r = AuctionsFuSave[tn][tr].Bidder[j].item[i][16][2];
						color.g = AuctionsFuSave[tn][tr].Bidder[j].item[i][16][3];
						color.b = AuctionsFuSave[tn][tr].Bidder[j].item[i][16][4];
						
						if (showEvent) and (not (AuctionsFuSave[tn][tr].Bidder[j].item[i][15]== self.Status.Active)) and (AuctionsFuSave[tn][tr].Bidder[j].item[i][17]) then
							rtxt = rtxt .. " (" .. format(TEXT(self.TimeFormat), AuctionsFuSave[tn][tr].Bidder[j].item[i][17][1],AuctionsFuSave[tn][tr].Bidder[j].item[i][17][2]) .. ")";
						end
						
						rtxt = rtxt .."\t";
						
						if (showExpiry) then
							if (AuctionsFuSave[tn][tr].Bidder[j].item[i][15]== self.Status.Active) or (AuctionsFuSave[tn][tr].Bidder[j].item[i][15]== self.Status.Outbid) then
								rtxt = rtxt .. self:CalculateExpiryTimes(AuctionsFuSave[tn][tr].Bidder[j].item[i][14],AuctionsFuSave[tn][tr].Bidder[j].time);
							end
						end
						
						rtxt = rtxt .. " [" .. self:GetColoredText(AuctionsFuSave[tn][tr].Bidder[j].item[i][16][1],color) .. "]";
						
						cat:AddLine('text', rtxt)
						rtxt = "";
						
						--DEFAULT_CHAT_FRAME:AddMessage("Txt "..rtxt);
					end
				end
			end
		end
	end
	
	if (needSeperate) then
		if (IsShiftKeyDown()) then
			cat:AddLine('text', " ")
			rtxt = self:GetColoredText(AUCTIONSFU_TOOLTIPTEXT_HINT_AUCTIONSNOTSHOWN, {r=1,g=0,b=0} ) .. "\n";
			cat:AddLine('text', rtxt)
		else
			cat:AddLine('text', " ")
			rtxt = self:GetColoredText(AUCTIONSFU_TOOLTIPTEXT_HINT_BIDSNOTSHOWN, {r=1,g=0,b=0} ) .. "\n";
			cat:AddLine('text', rtxt)
		end
	end
	
	
	if (self.UpdateNoticed == false) then
		self.UpdateNoticed = true;
		self:Update()
	end
	
	--AuctionsFu_GetMessage("Gyrochronatom sold.");
	
	return
end



local optionsTable = {
    type = 'group',
    args = {
		ExpTime = {
			type = "toggle",
			name = AUCTIONSFU_OPTIONS_SHOWEXPIRYTIME_NAME,
			desc = AUCTIONSFU_OPTIONS_SHOWEXPIRYTIME_HINT,
			get = function() return AuctionsFu:Is("ExpTime") end,
			set = function() AuctionsFu:Toggle("ExpTime") end,
			},
        RemTime = {
            type = "toggle",
            name = AUCTIONSFU_OPTIONS_REMAININGTIME_NAME,
            desc = AUCTIONSFU_OPTIONS_REMAININGTIME_HINT,
            get = function() return AuctionsFu:Is("RemTime") end,
			set = function() AuctionsFu:Toggle("RemTime") end,
			},
		EventTime = {
            type = "toggle",
            name = AUCTIONSFU_OPTIONS_SHOWEVENTTIME_NAME,
            desc = AUCTIONSFU_OPTIONS_SHOWEVENTTIME_HINT,
            get = function() return AuctionsFu:Is("EventTime") end,
			set = function() AuctionsFu:Toggle("EventTime") end,
			},
		Sound = {
            type = "toggle",
            name = AUCTIONSFU_OPTIONS_PLAYSOUND_NAME,
            desc = AUCTIONSFU_OPTIONS_PLAYSOUND_HINT,
            get = function() return AuctionsFu:Is("Sound") end,
			set = function() AuctionsFu:Toggle("Sound") end,
			},
		AutoScan = {
            type = "toggle",
            name = AUCTIONSFU_OPTIONS_AUTOSCAN_NAME,
            desc = AUCTIONSFU_OPTIONS_AUTOSCAN_HINT,
            get = function() return AuctionsFu:Is("AutoScan") end,
			set = function() AuctionsFu:Toggle("AutoScan") end,
			},
		SmallButton = {
            type = "toggle",
            name = AUCTIONSFU_OPTIONS_SMALLBUTTON_NAME,
            desc = AUCTIONSFU_OPTIONS_SMALLBUTTON_HINT,
            get = function() return AuctionsFu:Is("SmallButton") end,
			set = function() AuctionsFu:Toggle("SmallButton") end,
			},
		HideText = {
            type = "toggle",
            name = AUCTIONSFU_OPTIONS_HIDETEXT_NAME,
            desc = AUCTIONSFU_OPTIONS_HIDETEXT_HINT,
            get = function() return AuctionsFu:Is("HideText") end,
			set = function() AuctionsFu:Toggle("HideText") end,
			}
    }
}
AuctionsFu.OnMenuRequest = optionsTable
function AuctionsFu:Is(name)
	--return self.db.profile[self.myName][self.myRealm][name]
	--DEFAULT_CHAT_FRAME:AddMessage("Is " .. name .. " name:" .. (self.myName or "nil") .. " realm:" .. (self.myRealm or "nil"))
	return AuctionsFuSave[self.myName][self.myRealm][name]
end

function AuctionsFu:Toggle(name)
	--self.db.profile[self.myName][self.myRealm][name] = not self.db.profile[self.myName][self.myRealm][name]
	AuctionsFuSave[self.myName][self.myRealm][name] = not AuctionsFuSave[self.myName][self.myRealm][name]
    self:Update()
end

function AuctionsFu:SetTable()

	local tn = self.myName;
	local tr = self.myRealm;
	
	if (not AuctionsFuSave[tn]) then AuctionsFuSave[tn] = {}; end
	if (not AuctionsFuSave[tn][tr]) then AuctionsFuSave[tn][tr] = {}; end
	if (not AuctionsFuSave[tn][tr].Owner) then AuctionsFuSave[tn][tr].Owner = {}; end
	for i = 1, 3, 1 do
		if (not AuctionsFuSave[tn][tr].Owner[i]) then AuctionsFuSave[tn][tr].Owner[i] = {}; end
		if (not AuctionsFuSave[tn][tr].Owner[i].item) then AuctionsFuSave[tn][tr].Owner[i].item = {}; end
	end
	
	if (not AuctionsFuSave[tn][tr].Bidder) then AuctionsFuSave[tn][tr].Bidder = {}; end
	for i = 1, 3, 1 do
		if (not AuctionsFuSave[tn][tr].Bidder[i]) then AuctionsFuSave[tn][tr].Bidder[i] = {}; end
		if (not AuctionsFuSave[tn][tr].Bidder[i].item) then  AuctionsFuSave[tn][tr].Bidder[i].item = {}; end
	end

	self.AuctionIsOpen = false;
end

function AuctionsFu:OnUpdate() --- called by the frame in the xml file -- not any more
	if (not AuctionsFu:Is("AutoScan")) then
		return;
	end

	if (AuctionFrame == nil) then
		return;
	end

	
	if ((GetTime() - AuctionsFu.LastUpdate) > AuctionsFu.UpdateInterval) then
		AuctionsFu.LastUpdate = GetTime()
		if ( (AuctionFrame:IsVisible()) and (AuctionsFu.AH_DontUpdate == false) ) then
			AuctionsFu:ScanAH();
		end
	end
	
end

function AuctionsFu:ScanAH()
	--DEFAULT_CHAT_FRAME:AddMessage("Update");
	local time = { GetGameTime() };

	local tn = self.myName;
	local tr = self.myRealm;
	
	local area = GetMinimapZoneText();
	local locale;
	if (strfind(GetRealZoneText(), "Ironforge") or strfind(GetRealZoneText(), "Stormwind") or strfind(GetRealZoneText(), "Darnassus")) then
		locale = 1;
	elseif (strfind(area, "Gadgetzan") or strfind(area, "Booty Bay") or strfind(area, "Everlook")) then
		locale = 2;
	else
		locale = 3;
	end
	  
	AuctionsFuSave[tn][tr].Owner[locale] = nil;
	AuctionsFuSave[tn][tr].Owner[locale] = {};
	AuctionsFuSave[tn][tr].Owner[locale].item = {};
	
	self.Data_Accurate[locale] = true;
	  
	local tMoney = 0;
	local bMoney = 0;
	local boMoney = 0;
	
	local numBatchAuctions, totalAuctions = GetNumAuctionItems("owner");
	if (totalAuctions > 0) then
		AuctionsFuSave[tn][tr].Owner[locale].num = {numBatchAuctions, totalAuctions};
		AuctionsFuSave[tn][tr].Owner[locale].time = time;
		for index = 1, totalAuctions do
			local p = {GetAuctionItemInfo("owner", index)};
			local itemLink = GetAuctionItemLink("owner", index);
			local itemName, itemInfo = self:LinkDecode(itemLink);
			p[13] = itemInfo;
			p[14] = GetAuctionItemTimeLeft("owner", index);
			p[15] = self.Status.Active;
			p[16] = {"Active", 1, 1, 1};
			AuctionsFuSave[tn][tr].Owner[locale].item[index] = p;
			
			tMoney = tMoney + p[7];
			boMoney = boMoney + p[9];
			bMoney = bMoney + p[10];
		end
	else
		AuctionsFuSave[tn][tr].Owner[locale].num = {numBatchAuctions, totalAuctions};
		AuctionsFuSave[tn][tr].Owner[locale].item = {};
	end
	
	AuctionsFuSave[tn][tr].Owner[locale].money = {};
	AuctionsFuSave[tn][tr].Owner[locale].money.bids = bMoney;
	AuctionsFuSave[tn][tr].Owner[locale].money.buyoutValue = boMoney;
	AuctionsFuSave[tn][tr].Owner[locale].money.minbidValue = tMoney;
	
	AuctionsFuSave[tn][tr].Bidder[locale] = nil;
	AuctionsFuSave[tn][tr].Bidder[locale] = {};
	AuctionsFuSave[tn][tr].Bidder[locale].item = {};
	
	local bMoney = 0;
	local boMoney = 0;  
	
	local numBatchAuctions, totalAuctions = GetNumAuctionItems("bidder");
	--DEFAULT_CHAT_FRAME:AddMessage("Bidder scanned : ".. totalAuctions);
	if (totalAuctions > 0) then
		AuctionsFuSave[tn][tr].Bidder[locale].num = {numBatchAuctions, totalAuctions};
		AuctionsFuSave[tn][tr].Bidder[locale].time = time;
		for index = 1, totalAuctions do
			local p = {GetAuctionItemInfo("bidder", index)};
			local itemLink = GetAuctionItemLink("bidder", index);
			local itemName, itemInfo = self:LinkDecode(itemLink);
			p[13] = itemInfo;
			p[14] = GetAuctionItemTimeLeft("bidder", index);
			p[15] = self.Status.Active;
			p[16] = {"Active", 1, 1, 1};
			AuctionsFuSave[tn][tr].Bidder[locale].item[index] = p;
		
			boMoney = boMoney + p[9];      
			bMoney = bMoney + p[10];      
		end
	else
		AuctionsFuSave[tn][tr].Bidder[locale].num = {numBatchAuctions, totalAuctions};
		AuctionsFuSave[tn][tr].Bidder[locale].item = {};
	end
  
	AuctionsFuSave[tn][tr].Bidder[locale].money = {};
	AuctionsFuSave[tn][tr].Bidder[locale].money.buyoutValue = boMoney;
	AuctionsFuSave[tn][tr].Bidder[locale].money.minbidValue = bMoney;  
	
	self:UpdateText()
end

function AuctionsFu:LinkDecode(link)
	local id;
	local name;
	-- for id,name in string.gfind(link,"|c%x%x%x%x%x%x%x%x|H(item:%d+:%d+:%d+:%d+)|h%[([^]]+)%]|h|r$") do
	if link then
		for id,name in string.gfind(link,"|H(item:%d+:%d+:%d+:%d+)|h%[([^]]+)%]|h|r$") do
			-- Item nums: First num: Primary item id
			-- Second num: Enchantments
			-- Third num: ???
			-- Fourth num: "of the XXX" items
			if (id and name) then
				return name, id;
			end
		end
	end
end

function AuctionsFu:GetMessage(msg)
	local time = { GetGameTime() };
	if (strfind(msg,AuctionsFu_OUTBID)) then
		--"You have been outbid on"
		self.LastUpdateItem = self:GetNameAndNum("bidder", msg);
		if (self.LastUpdateItem) then
			--ahotg_statusupdate:SetText("Update!");
			--ahotg:SetBackdropColor(1.0,0,0);
			--ahotg_statusupdate:SetTextColor(1,0.3,0.3);
			--ahotgFrame.lastupdate = msg;
			--DEFAULT_CHAT_FRAME:AddMessage("Outbid");
			self.UpdateNoticed = false;
			self.LastUpdateItem[15] = self.Status.Outbid;
			self.LastUpdateItem[16] = {AUCTIONSFU_PANELTEXT_OUTBID, 1, 0, 0};
			self.LastUpdateItem[17] = time;
			self:PlaySound();
		end
	elseif (strfind(msg, AuctionsFu_WON)) then
		--"You won an auction for"
		self.LastUpdateItem = self:GetNameAndNum("bidder", msg);
		if (self.LastUpdateItem) then
			--ahotg_statusupdate:SetText("Update!");
			--ahotg:SetBackdropColor(0,1.0,0);
			--ahotg_statusupdate:SetTextColor(0.3,1,0.3);
			--ahotgFrame.lastupdate = msg;
			--DEFAULT_CHAT_FRAME:AddMessage("Won!");
			self.UpdateNoticed = false;
			self.LastUpdateItem[15] = self.Status.Won;
			self.LastUpdateItem[16] = {AUCTIONSFU_PANELTEXT_WON, 0, 1, 0};
			self.LastUpdateItem[17] = time;
			self:PlaySound();
		end
	elseif (strfind(msg, AuctionsFu_EXPIRED)) then
		--"has expired."
		self.LastUpdateItem = self:GetNameAndNum("owner", msg);
		if (self.LastUpdateItem) then
			--ahotg_statusupdate:SetText("Update!");
			--ahotg:SetBackdropColor(0.2,0.2,0.2);
			--ahotg_statusupdate:SetTextColor(0.5,0.5,0.5);
			--ahotgFrame.lastupdate = msg;
			--DEFAULT_CHAT_FRAME:AddMessage("Expired");
			self.UpdateNoticed = false;
			self.LastUpdateItem[15] = self.Status.Expired;
			self.LastUpdateItem[16] = {AUCTIONSFU_PANELTEXT_EXPIRED, 0.5, 0.5, 0.5};
			self.LastUpdateItem[17] = time;
			self:PlaySound();
		end
	--elseif (strfind(msg, "has been cancelled by the seller")) then
		--Saved in case i need it in the future.
	elseif (strfind(msg, AuctionsFu_SOLD)) then
		--" sold."
		self.LastUpdateItem = self:GetNameAndNum("owner", msg);
		if (self.LastUpdateItem) then
			--ahotg_statusupdate:SetText("Update!");
			--ahotg:SetBackdropColor(0,0,1);
			--ahotg_statusupdate:SetTextColor(0.3,0.3,1);
			--ahotgFrame.lastupdate = msg;
			--DEFAULT_CHAT_FRAME:AddMessage("Sold!");
			self.UpdateNoticed = false;
			self.LastUpdateItem[15] = self.Status.Sold;
			self.LastUpdateItem[16] = {AUCTIONSFU_PANELTEXT_SOLD, 0.3, 0.3, 1};
			self.LastUpdateItem[17] = time;
			self:PlaySound();
		end
	elseif (strfind(msg, AuctionsFu_CREATED)) then
		--DEFAULT_CHAT_FRAME:AddMessage("Created !");
		self.AH_DontUpdate = true;
		if (self:Is("AutoScan")) then
			self:ScanAH();
		end
		self.AH_DontUpdate = false;
	elseif (strfind(msg, AuctionsFu_ACCEPTED)) then
		--DEFAULT_CHAT_FRAME:AddMessage("Accepted !");
		self.AH_DontUpdate = true;
		if (self:Is("AutoScan")) then
			self:ScanAH();
		end
		self.AH_DontUpdate = false;
	end
	self:UpdateText()
end

function AuctionsFu:GetNameAndNum(type, msg)
	local tn = self.myName;
	local tr = self.myRealm;
	
	local myvar;
	for j = 1, 3 do
		if (type == "owner") then
			myvar = AuctionsFuSave[tn][tr].Owner[j];
		elseif (type == "bidder") then
			myvar = AuctionsFuSave[tn][tr].Bidder[j];
		end
		if (myvar.num) then
			for i = 1, myvar.num[2] do
				if (myvar.item[i][15] == self.Status.Active) then
					if (msg and strfind(msg, myvar.item[i][1])) then
						return myvar.item[i];
					end
				end
			end
		end
	end
	return nil;
end

function AuctionsFu:GetNumAuctionHousesUsed()
	local tn = self.myName;
	local tr = self.myRealm;

	local ahs = 0;
	for j = 1, 3, 1 do
		if ( (AuctionsFuSave[tn][tr].Owner[j].num) and (AuctionsFuSave[tn][tr].Bidder[j].num) ) then
			if ( (AuctionsFuSave[tn][tr].Owner[j].num[2] > 0) or (AuctionsFuSave[tn][tr].Bidder[j].num[2] > 0) ) then
				ahs = ahs+1;
			end
		end
	end
	return ahs;
end

function AuctionsFu:GetHourString(time, addon)
	local add1 = false;
	local nt = time[1] + addon;
	if (nt >= 24) then
		nt = nt - 24;
		add1 = true;
	end
	
	local time1 = format(TEXT(self.TimeFormat), nt, time[2]);
	
	if (not time1) then
		time1 = "";
	elseif (add1) then
		time1 = time1 .. "+";
	end

	return time1;
end

function AuctionsFu:GetMinuteString(time, addon)
	local add1 = false;
	local nt = time[2] + addon;
	if (nt >= 60) then
		nt = nt - 60;
		add1 = true;
	end

	local nth = time[1];
	if (add1) then
		nth = nth + 1;
		if (nth >= 24) then
			nth = nth - 24;
			add1 = true;
		else
			add1 = false;
		end
	end

	local time1 = format(TEXT(self.TimeFormat), nth, nt);
	
	if (not time1) then
		time1 = "";
	elseif (add1) then
		time1 = time1 .. "+";
	end

	return time1;
end

function AuctionsFu:GetRemainingTime(time, addon)
	--addon must be given in minutes
	local ptime = { GetGameTime() };

	local hdiff;
	local mdiff;

	if (ptime[1] < time[1]) then -- ptime is past 00:00
		hdiff = ptime[1] + 24 - time[1];
	else
		hdiff = ptime[1] - time[1];
	end

	if (ptime[2] < time[2]) then -- ptime is smaller than time b4
		mdiff = ptime[2] + 60 - time[2];
		if (hdiff == 0) then
			hdiff = 23;
		else
			hdiff = hdiff -1;
		end
	else
		mdiff = ptime[2] - time[2];
	end

	--DEFAULT_CHAT_FRAME:AddMessage("h/mdiff "..hdiff.." "..mdiff);

	--difference between local time and auction recorded time is stored in hdiff, mdiff
	local expired = false;
	local tdiff = mdiff + hdiff * 60; --diff in mins

	if ( addon <= tdiff) then
		return "00:00";
	else
		local diff = addon - tdiff; -- diff > 0
		hdiff = floor(diff / 60);
		mdiff = diff - hdiff *60;
		return format(TEXT(self.TimeFormat), hdiff, mdiff);
	end

end

function AuctionsFu:CalculateExpiryTimes(duration,scanTime)
  local rstr = "";

  local remaining = self:Is("RemTime");
  
  if (duration == 4) then
    if (remaining) then
      rstr = " {".. self:GetRemainingTime(scanTime,480) .. " - " .. self:GetRemainingTime(scanTime,1440) .. "}";
    else
      rstr = " {".. self:GetHourString(scanTime,8) .. " - " .. self:GetHourString(scanTime,24) .. "}";
    end
  elseif (duration == 3) then
    if (remaining) then
      rstr = " {".. self:GetRemainingTime(scanTime,120) .. " - " .. self:GetRemainingTime(scanTime,480) .. "}";
    else
      rstr = " {".. self:GetHourString(scanTime,2) .. " - " .. self:GetHourString(scanTime,8) .. "}";
    end
  elseif (duration == 2) then
    if (remaining) then
      rstr = " {".. self:GetRemainingTime(scanTime,30) .. " - " .. self:GetRemainingTime(scanTime,120) .. "}";
    else
      rstr = " {".. self:GetMinuteString(scanTime,30) .. " - " .. self:GetHourString(scanTime,2) .. "}";
    end
  elseif (duration == 1) then
    if (remaining) then
      rstr = " {".. "00:00" .. " - " .. self:GetRemainingTime(scanTime,30) .. "}";
    else
      rstr = " {".. format(TEXT(self.TimeFormat), scanTime[1],scanTime[2]) .. " - " .. self:GetMinuteString(scanTime,30) .. "}";
    end
  end

  return rstr;
end

function AuctionsFu:PlaySound()
  if (self:Is("Sound")) then
    PlaySoundFile("sound\AuctionsFu.wav");
  end
end

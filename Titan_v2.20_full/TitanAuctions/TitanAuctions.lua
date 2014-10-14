--[[----------------------------------------------------
Based on v1.1 of TitanAuctions:
http://www.curse-gaming.com/mod.php?addid=1787

Original addon by Smuggles:
http://www.curse-gaming.com/mod.php?authorid=1787

Modifications for WoW 1.9 patch by Samah:
Samahlockeh (Orc Warlock) on Proudmoore
samahnub@gmail.com

Changes:
 - Support added for linked auction houses.
 - Added "Automatically Scan" option to disable scanning
   while in AH.
 - Clicking the TitanAuctions button will now perform a
   manual scan.
----------------------------------------------------]]--

TITAN_AUCTIONS_ID = "Auctions";
TITAN_AUCTIONS_EXPIRY_TIME = "ShowExpiryTime";
TITAN_AUCTIONS_EVENT_TIME = "ShowEventTime";
TITAN_AUCTIONS_SMALL_BUTTON = "ShowSmallButton";
TITAN_AUCTIONS_REMAINING_TIME = "RemainingTime";
TITAN_AUCTIONS_PLAY_SOUND = "PlaySound";
TITAN_AUCTIONS_AUTO_SCAN = "AutoScan";
TitanAuctions_Update_Interval = 2;
TitanAuctions_LastUpdate = 0;

TitanAuctions_Time_Format = "%02d:%02d";

TitanAuctions_Status_Active = 1;
TitanAuctions_Status_Outbid = 2;
TitanAuctions_Status_Won = 3;
TitanAuctions_Status_Expired = 4;
TitanAuctions_Status_Sold = 5;

TitanAuctions_MouseOnButton = false;

-- stored the item where last update occured
TitanAuctions_LastUpdateItem = nil;
-- if update was already noticed
TitanAuctions_UpdateNoticed = false;
-- flag for no auto update if needed, set true
TitanAuctions_AH_DontUpdate = false;
-- if present data is accurate
TitanAuctions_Data_Accurate = {false,false,false};

TitanAuctions_LocaleString = { "Alliance", "Steamwheedle Cartel", "Horde" };

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

function TitanPanelAuctionsButton_OnLoad()

  this.registry = {
    id = TITAN_AUCTIONS_ID,
    menuText = TITAN_AUCTIONS_ID,
    buttonTextFunction = "TitanPanel"..TITAN_AUCTIONS_ID.."Button_GetButtonText",
    tooltipTitle = TITAN_AUCTIONS_ID,
    tooltipTextFunction = "TitanPanel".. TITAN_AUCTIONS_ID .."Button_GetTooltipText",
    icon = "Interface\\Icons\\INV_Misc_Bell_01.blp";
    iconWidth = 16,
    savedVariables = {
      ShowLabelText = 1,
      ShowExpiryTime = 1,
      ShowEventTime = 1,
      RemainingTime = 1,
      ShowSmallButton = 0,
      PlaySound = 0,
      ShowIcon = 1,
      hideguy = 0,
    }
  };

  this:RegisterEvent("PLAYER_ENTERING_WORLD");
  this:RegisterEvent("UNIT_NAME_UPDATE");
  this:RegisterEvent("VARIABLES_LOADED");

  this:RegisterEvent("AUCTION_HOUSE_CLOSED");
  this:RegisterEvent("AUCTION_HOUSE_SHOW");
  this:RegisterEvent("CHAT_MSG_SYSTEM");
end

function TitanPanelAuctionsButton_OnEvent()
  if (event == "PLAYER_ENTERING_WORLD") then
    if(myAddOnsList) then
      myAddOnsList.TitanAuctions = {name = BINDING_HEADER_TitanAuctions, description = "Check your auctions from anywhere, updates you when you win/lose/etc", version = TitanAuctions_VERSION, category = MYADDONS_CATEGORY_INVENTORY, frame = "TitanAuctionsMain"};
    end
  elseif (event == "AUCTION_HOUSE_SHOW") then
    --DEFAULT_CHAT_FRAME:AddMessage("Auctions Opened");
    TitanAuctionsSave.AuctionIsOpen = true;
    if (TitanGetVar(TITAN_AUCTIONS_ID,TITAN_AUCTIONS_AUTO_SCAN)) then
      TitanAuctions_ScanAH();
      TitanPanelButton_UpdateButton(TITAN_AUCTIONS_ID);
      TitanPanelButton_UpdateTooltip();
    end
    TitanPanelButton_UpdateButton(TITAN_AUCTIONS_ID);
  elseif (event == "CHAT_MSG_SYSTEM") then
    --DEFAULT_CHAT_FRAME:AddMessage("System Msg : "..arg1);
    TitanAuctions_GetMessage(arg1);
  elseif (event == "AUCTION_HOUSE_CLOSED") then
    --DEFAULT_CHAT_FRAME:AddMessage("Auctions Closed");
    TitanAuctionsSave.AuctionIsOpen = false;
    TitanPanelButton_UpdateButton(TITAN_AUCTIONS_ID);
  elseif ((event == "PLAYER_ENTERING_WORLD") or (event == "UNIT_NAME_UPDATE" and arg1 == 'player')) then
    local pName = UnitName("player");
  if ((pName ~= nil) and (pname ~= UNKNOWNOBJECT) and (pname ~= UKNOWNBEING)) then
      if (not TitanAuctionsSave) then TitanAuctionsSave = {}; end
      TitanAuctionsSave.myName = pName;
      TitanAuctionsSave.myRealm =GetCVar("realmName");
      TitanAuctions_Initialize();
    end
  end
end

function TitanPanelAuctionsButton_OnClick(button)
	if (button == "LeftButton") then
		if (IsShiftKeyDown()) then
			TitanPanelButton_UpdateTooltip();
		elseif (TitanAuctionsSave.AuctionIsOpen) then
			TitanAuctions_ScanAH();
		end
	end
end

function TitanPanelAuctionsButton_GetButtonText(id)
  if (not TitanAuctionsSave) then
    return "Auctions";
  end
  local tn = TitanAuctionsSave.myName;
  local tr = TitanAuctionsSave.myRealm;

  local smallButton = TitanGetVar(TITAN_AUCTIONS_ID,TITAN_AUCTIONS_SMALL_BUTTON);
  local showIcon = TitanGetVar(TITAN_AUCTIONS_ID,"ShowIcon");
  local colortxt = "";

  if (TitanAuctions_LastUpdateItem) and (TitanAuctions_UpdateNoticed == false) then
    color = {};
    color.r = TitanAuctions_LastUpdateItem[16][2];
    color.g = TitanAuctions_LastUpdateItem[16][3];
    color.b = TitanAuctions_LastUpdateItem[16][4];

    if (smallButton) then
      colortxt = TitanUtils_GetColoredText("U!", color);
    else
      colortxt = TitanUtils_GetColoredText("Update!", color);
    end
    return colortxt;
  end

  if (smallButton) and (not TitanAuctionsSave.AuctionIsOpen) and (TitanAuctions_MouseOnButton == false) then
    if (not showIcon) then
      colortxt = "A";
    end
  else
    local totalAuctions = 0;
    local totalBids =0;
    for j = 1, 3, 1 do
      if ( (TitanAuctionsSave[tn][tr].Owner[j].num) and (TitanAuctionsSave[tn][tr].Bidder[j].num) ) then
        totalAuctions = totalAuctions + TitanAuctionsSave[tn][tr].Owner[j].num[2];
        totalBids = totalBids + TitanAuctionsSave[tn][tr].Bidder[j].num[2];
      end
    end
    return ""..
      TITAN_AUCTIONS_AUCTIONS, TitanUtils_GetHighlightText(totalAuctions),
      TITAN_AUCTIONS_BIDS, TitanUtils_GetHighlightText(totalBids);
  end

  return colortxt;
end

function TitanPanel_GetMoneyText(money)
  -- Breakdown the money into denominations
  local gold = floor(money / (COPPER_PER_SILVER * SILVER_PER_GOLD));
  local silver = floor((money - (gold * COPPER_PER_SILVER * SILVER_PER_GOLD)) / COPPER_PER_SILVER);
  local copper = mod(money, COPPER_PER_SILVER);  
  
  local txt = "";
  if (gold > 0) then
  	txt = txt..TitanUtils_GetColoredText(gold, {r=1,g=0.7,b=0} ).." ";
  	txt = txt.. TitanUtils_GetColoredText(silver, {r=0.7098,g=0.7215,b=0.6117} ).." ";
  else
  	if (silver > 0) then
  		txt = txt.. TitanUtils_GetColoredText(silver, {r=0.7098,g=0.7215,b=0.6117} ).." ";
  	end
  end
  txt = txt.. TitanUtils_GetColoredText(copper, {r=0.8431,g=0.3647,b=0.2078} );
  	
  return txt;
end

function TitanPanelAuctionsButton_GetTooltipText()
  local rtxt = "";

  if (TitanAuctionsSave.AuctionIsOpen) then
    rtxt = rtxt .. "In Auction House" .. "\n";
  end

  local ahs = TitanAuctions_GetNumAuctionHousesUsed();

  if ( ahs == 0 ) then
    rtxt = rtxt .. "No Auctions / Bids Active";
    return rtxt;
  end

  rtxt = rtxt .. "\n";

  local tn = TitanAuctionsSave.myName;
  local tr = TitanAuctionsSave.myRealm;
  
  local needSeperate = false;
  local totalItems = 0;
  for j = 1, 3, 1 do
  	if ( (TitanAuctionsSave[tn][tr].Owner[j].num) and (TitanAuctionsSave[tn][tr].Bidder[j].num) ) then
      if ( (TitanAuctionsSave[tn][tr].Owner[j].num[2] > 0) or (TitanAuctionsSave[tn][tr].Bidder[j].num[2] > 0) ) then
      	totalItems = totalItems + 3; --for each autionhouse need xtra lines
      	totalItems = totalItems + TitanAuctionsSave[tn][tr].Owner[j].num[2] + TitanAuctionsSave[tn][tr].Bidder[j].num[2];
      end
    end
  end  
  if (totalItems >28) then
  	needSeperate = true;
  end


  local showExpiry = TitanGetVar(TITAN_AUCTIONS_ID,TITAN_AUCTIONS_EXPIRY_TIME);
  local showEvent = TitanGetVar(TITAN_AUCTIONS_ID,TITAN_AUCTIONS_EVENT_TIME);

  for j = 1, 3, 1 do
    if ( (TitanAuctionsSave[tn][tr].Owner[j].num) and (TitanAuctionsSave[tn][tr].Bidder[j].num) ) then
      if ( (TitanAuctionsSave[tn][tr].Owner[j].num[2] > 0) or (TitanAuctionsSave[tn][tr].Bidder[j].num[2] > 0) ) then

        rtxt = rtxt .. TitanAuctions_LocaleString[j] .." [";
        local timeText = "";
        if (TitanAuctionsSave[tn][tr].Bidder[j].time) then
          timeText = format(TEXT(TitanAuctions_Time_Format), TitanAuctionsSave[tn][tr].Bidder[j].time[1],TitanAuctionsSave[tn][tr].Bidder[j].time[2]);
        end
        if (TitanAuctions_Data_Accurate[j]) then
          rtxt = rtxt .. TitanUtils_GetColoredText("Valid"..timeText, {r=0,g=1,b=0} ) .. "]\n";
        else
          rtxt = rtxt .. TitanUtils_GetColoredText("Unsure! Please Update"..timeText, {r=1,g=0,b=0} ) .. "]\n";
        end
				
        if (TitanAuctionsSave[tn][tr].Owner[j].num[2] > 0)  and ((not IsShiftKeyDown() or (not needSeperate)) ) then
        	--DEFAULT_CHAT_FRAME:AddMessage("Aucts "..TitanAuctionsSave[tn][tr].Owner[j].num[2].." "..j);
          rtxt = rtxt .. "  " .. TITAN_AUCTIONS_AUCTIONS;
          
          if (TitanAuctionsSave[tn][tr].Owner[j].money) then
          	rtxt = rtxt .. " MinBid : ".. TitanPanel_GetMoneyText(TitanAuctionsSave[tn][tr].Owner[j].money.minbidValue);
          	rtxt = rtxt .. " Buyout : ".. TitanPanel_GetMoneyText(TitanAuctionsSave[tn][tr].Owner[j].money.buyoutValue);
          	if (TitanAuctionsSave[tn][tr].Owner[j].money.bids > 0 ) then
          		rtxt = rtxt .. " Bids : ".. TitanPanel_GetMoneyText(TitanAuctionsSave[tn][tr].Owner[j].money.bids);
          	end
          end
 
  				rtxt = rtxt .. "\n";

          for i = 1, TitanAuctionsSave[tn][tr].Owner[j].num[2], 1 do
            rtxt = rtxt .. "  ";
            if (TitanAuctionsSave[tn][tr].Owner[j].item[i][3] > 0) then
              rtxt = rtxt .. TitanAuctionsSave[tn][tr].Owner[j].item[i][3] .. "x ";
            end
            rtxt = rtxt .. TitanUtils_GetColoredText(TitanAuctionsSave[tn][tr].Owner[j].item[i][1], ITEM_QUALITY_COLORS[TitanAuctionsSave[tn][tr].Owner[j].item[i][4]]);

            local color = {};
            color.r = TitanAuctionsSave[tn][tr].Owner[j].item[i][16][2];
            color.g = TitanAuctionsSave[tn][tr].Owner[j].item[i][16][3];
            color.b = TitanAuctionsSave[tn][tr].Owner[j].item[i][16][4];

            if (showEvent) and (not (TitanAuctionsSave[tn][tr].Owner[j].item[i][15]== TitanAuctions_Status_Active)) and (TitanAuctionsSave[tn][tr].Owner[j].item[i][17]) then
              rtxt = rtxt .. " (" .. format(TEXT(TitanAuctions_Time_Format), TitanAuctionsSave[tn][tr].Owner[j].item[i][17][1],TitanAuctionsSave[tn][tr].Owner[j].item[i][17][2]) .. ")";
            end

            rtxt = rtxt .."\t";

            if (showExpiry) then
              if (TitanAuctionsSave[tn][tr].Owner[j].item[i][15]== TitanAuctions_Status_Active) or (TitanAuctionsSave[tn][tr].Owner[j].item[i][15]== TitanAuctions_Status_Outbid) then
                rtxt = rtxt .. TitanAuctions_CalculateExpiryTimes(TitanAuctionsSave[tn][tr].Owner[j].item[i][14],TitanAuctionsSave[tn][tr].Owner[j].time);
              end
            end

            rtxt = rtxt .. " [" .. TitanUtils_GetColoredText(TitanAuctionsSave[tn][tr].Owner[j].item[i][16][1],color) .. "]";

            rtxt = rtxt .. "\n";
          end          
        end        
        if (TitanAuctionsSave[tn][tr].Bidder[j].num[2] > 0) and  ((IsShiftKeyDown() or (not needSeperate)) ) then
        	--DEFAULT_CHAT_FRAME:AddMessage("Bids "..TitanAuctionsSave[tn][tr].Bidder[j].num[2].." "..j);
          rtxt = rtxt .. "  ".. TITAN_AUCTIONS_BIDS;
          
          if (TitanAuctionsSave[tn][tr].Bidder[j].money) then
          	rtxt = rtxt .. " MinBid : ".. TitanPanel_GetMoneyText(TitanAuctionsSave[tn][tr].Bidder[j].money.minbidValue);
          	rtxt = rtxt .. " Buyout : ".. TitanPanel_GetMoneyText(TitanAuctionsSave[tn][tr].Bidder[j].money.buyoutValue);
          end         
          
          rtxt = rtxt .. "\n";
          for i = 1, TitanAuctionsSave[tn][tr].Bidder[j].num[2], 1 do
            rtxt = rtxt .. "  " .. TitanUtils_GetColoredText(TitanAuctionsSave[tn][tr].Bidder[j].item[i][1], ITEM_QUALITY_COLORS[TitanAuctionsSave[tn][tr].Bidder[j].item[i][4]]);

            local color = {};
            color.r = TitanAuctionsSave[tn][tr].Bidder[j].item[i][16][2];
            color.g = TitanAuctionsSave[tn][tr].Bidder[j].item[i][16][3];
            color.b = TitanAuctionsSave[tn][tr].Bidder[j].item[i][16][4];

            if (showEvent) and (not (TitanAuctionsSave[tn][tr].Bidder[j].item[i][15]== TitanAuctions_Status_Active)) and (TitanAuctionsSave[tn][tr].Bidder[j].item[i][17]) then
              rtxt = rtxt .. " (" .. format(TEXT(TitanAuctions_Time_Format), TitanAuctionsSave[tn][tr].Bidder[j].item[i][17][1],TitanAuctionsSave[tn][tr].Bidder[j].item[i][17][2]) .. ")";
            end

            rtxt = rtxt .."\t";

            if (showExpiry) then
              if (TitanAuctionsSave[tn][tr].Bidder[j].item[i][15]== TitanAuctions_Status_Active) or (TitanAuctionsSave[tn][tr].Bidder[j].item[i][15]== TitanAuctions_Status_Outbid) then
                rtxt = rtxt .. TitanAuctions_CalculateExpiryTimes(TitanAuctionsSave[tn][tr].Bidder[j].item[i][14],TitanAuctionsSave[tn][tr].Bidder[j].time);
              end
            end

            rtxt = rtxt .. " [" .. TitanUtils_GetColoredText(TitanAuctionsSave[tn][tr].Bidder[j].item[i][16][1],color) .. "]";

            rtxt = rtxt .. "\n";
            
            --DEFAULT_CHAT_FRAME:AddMessage("Txt "..rtxt);
          end
        end
      end
    end
  end
  
  if (needSeperate) then
  	if (IsShiftKeyDown()) then
	   	rtxt = rtxt .. "\n";
  	 	rtxt = rtxt .. TitanUtils_GetColoredText("Auctions not shown (Use Mouseover (withouth Shift) to show Auctions) !", {r=1,g=0,b=0} ) .. "\n";
  	else
	   	rtxt = rtxt .. "\n";
  	 	rtxt = rtxt .. TitanUtils_GetColoredText("Bids not shown (Use Shift+Mouseover to show Bids) !", {r=1,g=0,b=0} ) .. "\n";  		
  	end
  end


  if (TitanAuctions_UpdateNoticed == false) then
    TitanAuctions_UpdateNoticed = true;
    TitanPanelButton_UpdateButton(TITAN_AUCTIONS_ID);
  end

  --TitanAuctions_GetMessage("Gyrochronatom sold.");

  return rtxt;
end

function TitanPanelRightClickMenu_PrepareAuctionsMenu()
  local info = {};

  TitanPanelRightClickMenu_AddTitle(TitanPlugins[TITAN_AUCTIONS_ID].menuText);

  --info = {};
  --info.text = TITAN_DURABILITY_MENU_ITEMS;
  --info.value = "iteminfo";
  --info.func = TitanPanelDurability_Toggle;
  --info.checked = TitanGetVar(TITAN_DURABILITY_ID, "iteminfo");
  --UIDropDownMenu_AddButton(info);

  TitanPanelRightClickMenu_AddToggleVar("Show Expiry Time",TITAN_AUCTIONS_ID,TITAN_AUCTIONS_EXPIRY_TIME);
  TitanPanelRightClickMenu_AddToggleVar("Remaining Time",TITAN_AUCTIONS_ID,TITAN_AUCTIONS_REMAINING_TIME);
  TitanPanelRightClickMenu_AddToggleVar("Show Event Time",TITAN_AUCTIONS_ID,TITAN_AUCTIONS_EVENT_TIME);
  TitanPanelRightClickMenu_AddToggleVar("Play Sound",TITAN_AUCTIONS_ID,TITAN_AUCTIONS_PLAY_SOUND);
  TitanPanelRightClickMenu_AddToggleVar("Automatically Scan",TITAN_AUCTIONS_ID,TITAN_AUCTIONS_AUTO_SCAN);
  TitanPanelRightClickMenu_AddSpacer();

  TitanPanelRightClickMenu_AddToggleVar("Small Button",TITAN_AUCTIONS_ID,TITAN_AUCTIONS_SMALL_BUTTON);
  TitanPanelRightClickMenu_AddToggleIcon(TITAN_AUCTIONS_ID);
  TitanPanelRightClickMenu_AddToggleLabelText(TITAN_AUCTIONS_ID);


  TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, TITAN_AUCTIONS_ID, TITAN_PANEL_MENU_FUNC_HIDE);
end

function TitanAuctions_Initialize()

  local tn = TitanAuctionsSave.myName;
   local tr = TitanAuctionsSave.myRealm;

  if (not TitanAuctionsSave[tn]) then TitanAuctionsSave[tn] = {}; end
  if (not TitanAuctionsSave[tn][tr]) then TitanAuctionsSave[tn][tr] = {}; end
  if (not TitanAuctionsSave[tn][tr].Owner) then TitanAuctionsSave[tn][tr].Owner = {}; end
  for i = 1, 3, 1 do
    if (not TitanAuctionsSave[tn][tr].Owner[i]) then TitanAuctionsSave[tn][tr].Owner[i] = {}; end
    if (not TitanAuctionsSave[tn][tr].Owner[i].item) then TitanAuctionsSave[tn][tr].Owner[i].item = {}; end
  end

  if (not TitanAuctionsSave[tn][tr].Bidder) then TitanAuctionsSave[tn][tr].Bidder = {}; end
  for i = 1, 3, 1 do
    if (not TitanAuctionsSave[tn][tr].Bidder[i]) then TitanAuctionsSave[tn][tr].Bidder[i] = {}; end
    if (not TitanAuctionsSave[tn][tr].Bidder[i].item) then  TitanAuctionsSave[tn][tr].Bidder[i].item = {}; end
  end

  TitanAuctionsSave.AuctionIsOpen = false;
end

function TitanAuctions_OnUpdate(elapsed)
  if (not TitanGetVar(TITAN_AUCTIONS_ID,TITAN_AUCTIONS_AUTO_SCAN)) then
    return;
  end

  if (AuctionFrame == nil) then
    return;
  end

  TitanAuctions_LastUpdate = TitanAuctions_LastUpdate + elapsed;

  if (TitanAuctions_LastUpdate > TitanAuctions_Update_Interval) then
    TitanAuctions_LastUpdate = 0;
    if ( (AuctionFrame:IsVisible()) and (TitanAuctions_AH_DontUpdate == false) ) then
      TitanAuctions_ScanAH();
    end
  end
end

function TitanAuctions_ScanAH()
  --DEFAULT_CHAT_FRAME:AddMessage("Update");
  local time = { GetGameTime() };

  local tn = TitanAuctionsSave.myName;
  local tr = TitanAuctionsSave.myRealm;

  local area = GetMinimapZoneText();
  local locale;
  if (strfind(GetRealZoneText(), "Ironforge") or strfind(GetRealZoneText(), "Stormwind") or strfind(GetRealZoneText(), "Darnassus")) then
    locale = 1;
  elseif (strfind(area, "Gadgetzan") or strfind(area, "Booty Bay") or strfind(area, "Everlook")) then
    locale = 2;
  else
    locale = 3;
  end
  
  TitanAuctionsSave[tn][tr].Owner[locale] = nil;
  TitanAuctionsSave[tn][tr].Owner[locale] = {};
  TitanAuctionsSave[tn][tr].Owner[locale].item = {};

  TitanAuctions_Data_Accurate[locale] = true;
  
  local tMoney = 0;
  local bMoney = 0;
  local boMoney = 0;

  local numBatchAuctions, totalAuctions = GetNumAuctionItems("owner");
  if (totalAuctions > 0) then
    TitanAuctionsSave[tn][tr].Owner[locale].num = {numBatchAuctions, totalAuctions};
    TitanAuctionsSave[tn][tr].Owner[locale].time = time;
    for index = 1, totalAuctions do
      local p = {GetAuctionItemInfo("owner", index)};
      local itemLink = GetAuctionItemLink("owner", index);
      local itemName, itemInfo = TitanAuctions_LinkDecode(itemLink);
      p[13] = itemInfo;
      p[14] = GetAuctionItemTimeLeft("owner", index);
      p[15] = TitanAuctions_Status_Active;
      p[16] = {"Active", 1, 1, 1};
      TitanAuctionsSave[tn][tr].Owner[locale].item[index] = p;
      
      tMoney = tMoney + p[7];
      boMoney = boMoney + p[9];
      bMoney = bMoney + p[10];
    end
  else
    TitanAuctionsSave[tn][tr].Owner[locale].num = {numBatchAuctions, totalAuctions};
    TitanAuctionsSave[tn][tr].Owner[locale].item = {};
  end
  
  TitanAuctionsSave[tn][tr].Owner[locale].money = {};
  TitanAuctionsSave[tn][tr].Owner[locale].money.bids = bMoney;
  TitanAuctionsSave[tn][tr].Owner[locale].money.buyoutValue = boMoney;
  TitanAuctionsSave[tn][tr].Owner[locale].money.minbidValue = tMoney;
  
  TitanAuctionsSave[tn][tr].Bidder[locale] = nil;
  TitanAuctionsSave[tn][tr].Bidder[locale] = {};
  TitanAuctionsSave[tn][tr].Bidder[locale].item = {};
  
  local bMoney = 0;
  local boMoney = 0;  

  local numBatchAuctions, totalAuctions = GetNumAuctionItems("bidder");
  --DEFAULT_CHAT_FRAME:AddMessage("Bidder scanned : ".. totalAuctions);
  if (totalAuctions > 0) then
    TitanAuctionsSave[tn][tr].Bidder[locale].num = {numBatchAuctions, totalAuctions};
    TitanAuctionsSave[tn][tr].Bidder[locale].time = time;
    for index = 1, totalAuctions do
      local p = {GetAuctionItemInfo("bidder", index)};
      local itemLink = GetAuctionItemLink("bidder", index);
      local itemName, itemInfo = TitanAuctions_LinkDecode(itemLink);
      p[13] = itemInfo;
      p[14] = GetAuctionItemTimeLeft("bidder", index);
      p[15] = TitanAuctions_Status_Active;
      p[16] = {"Active", 1, 1, 1};
      TitanAuctionsSave[tn][tr].Bidder[locale].item[index] = p;

      boMoney = boMoney + p[9];      
      bMoney = bMoney + p[10];      
    end
  else
    TitanAuctionsSave[tn][tr].Bidder[locale].num = {numBatchAuctions, totalAuctions};
    TitanAuctionsSave[tn][tr].Bidder[locale].item = {};
  end
  
  TitanAuctionsSave[tn][tr].Bidder[locale].money = {};
  TitanAuctionsSave[tn][tr].Bidder[locale].money.buyoutValue = boMoney;
  TitanAuctionsSave[tn][tr].Bidder[locale].money.minbidValue = bMoney;  
  
  TitanPanelButton_UpdateButton(TITAN_AUCTIONS_ID);
end

function TitanAuctions_LinkDecode(link)
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

function TitanAuctions_GetMessage(msg)
  local time = { GetGameTime() };
  if (strfind(msg,TitanAuctions_OUTBID)) then
      --"You have been outbid on"
      TitanAuctions_LastUpdateItem = TitanAuctions_GetNameAndNum("bidder", msg);
      if (TitanAuctions_LastUpdateItem) then
        --ahotg_statusupdate:SetText("Update!");
        --ahotg:SetBackdropColor(1.0,0,0);
        --ahotg_statusupdate:SetTextColor(1,0.3,0.3);
        --ahotgFrame.lastupdate = msg;
        --DEFAULT_CHAT_FRAME:AddMessage("Outbid");
        TitanAuctions_UpdateNoticed = false;
        TitanAuctions_LastUpdateItem[15] = TitanAuctions_Status_Outbid;
        TitanAuctions_LastUpdateItem[16] = {"Outbid", 1, 0, 0};
        TitanAuctions_LastUpdateItem[17] = time;
        TitanAuctions_PlaySound();
      end
  elseif (strfind(msg, TitanAuctions_WON)) then
      --"You won an auction for"
      TitanAuctions_LastUpdateItem = TitanAuctions_GetNameAndNum("bidder", msg);
      if (TitanAuctions_LastUpdateItem) then
        --ahotg_statusupdate:SetText("Update!");
        --ahotg:SetBackdropColor(0,1.0,0);
        --ahotg_statusupdate:SetTextColor(0.3,1,0.3);
        --ahotgFrame.lastupdate = msg;
        --DEFAULT_CHAT_FRAME:AddMessage("Won!");
        TitanAuctions_UpdateNoticed = false;
        TitanAuctions_LastUpdateItem[15] = TitanAuctions_Status_Won;
        TitanAuctions_LastUpdateItem[16] = {"Won!", 0, 1, 0};
        TitanAuctions_LastUpdateItem[17] = time;
        TitanAuctions_PlaySound();
      end
  elseif (strfind(msg, TitanAuctions_EXPIRED)) then
      --"has expired."
      TitanAuctions_LastUpdateItem = TitanAuctions_GetNameAndNum("owner", msg);
      if (TitanAuctions_LastUpdateItem) then
        --ahotg_statusupdate:SetText("Update!");
        --ahotg:SetBackdropColor(0.2,0.2,0.2);
        --ahotg_statusupdate:SetTextColor(0.5,0.5,0.5);
        --ahotgFrame.lastupdate = msg;
        --DEFAULT_CHAT_FRAME:AddMessage("Expired");
        TitanAuctions_UpdateNoticed = false;
        TitanAuctions_LastUpdateItem[15] = TitanAuctions_Status_Expired;
        TitanAuctions_LastUpdateItem[16] = {"Expired", 0.5, 0.5, 0.5};
        TitanAuctions_LastUpdateItem[17] = time;
        TitanAuctions_PlaySound();
      end
    --elseif (strfind(msg, "has been cancelled by the seller")) then
      --Saved in case i need it in the future.
  elseif (strfind(msg, TitanAuctions_SOLD)) then
      --" sold."
      TitanAuctions_LastUpdateItem = TitanAuctions_GetNameAndNum("owner", msg);
      if (TitanAuctions_LastUpdateItem) then
        --ahotg_statusupdate:SetText("Update!");
        --ahotg:SetBackdropColor(0,0,1);
        --ahotg_statusupdate:SetTextColor(0.3,0.3,1);
        --ahotgFrame.lastupdate = msg;
        --DEFAULT_CHAT_FRAME:AddMessage("Sold!");
        TitanAuctions_UpdateNoticed = false;
        TitanAuctions_LastUpdateItem[15] = TitanAuctions_Status_Sold;
        TitanAuctions_LastUpdateItem[16] = {"Sold!", 0.3, 0.3, 1};
        TitanAuctions_LastUpdateItem[17] = time;
        TitanAuctions_PlaySound();
      end
  elseif (strfind(msg, TitanAuctions_CREATED)) then
    --DEFAULT_CHAT_FRAME:AddMessage("Created !");
    TitanAuctions_AH_DontUpdate = true;
    if (TitanGetVar(TITAN_AUCTIONS_ID,TITAN_AUCTIONS_AUTO_SCAN)) then
      TitanAuctions_ScanAH();
    end
    TitanAuctions_AH_DontUpdate = false;
  elseif (strfind(msg, TitanAuctions_ACCEPTED)) then
    --DEFAULT_CHAT_FRAME:AddMessage("Accepted !");
    TitanAuctions_AH_DontUpdate = true;
    if (TitanGetVar(TITAN_AUCTIONS_ID,TITAN_AUCTIONS_AUTO_SCAN)) then
      TitanAuctions_ScanAH();
    end
    TitanAuctions_AH_DontUpdate = false;
  end
  TitanPanelButton_UpdateButton(TITAN_AUCTIONS_ID);
end

function TitanAuctions_GetNameAndNum(type, msg)
  local tn = TitanAuctionsSave.myName;
   local tr = TitanAuctionsSave.myRealm;

  local myvar;
  for j = 1, 3 do
    if (type == "owner") then
      myvar = TitanAuctionsSave[tn][tr].Owner[j];
    elseif (type == "bidder") then
      myvar = TitanAuctionsSave[tn][tr].Bidder[j];
    end
    if (myvar.num) then
      for i = 1, myvar.num[2] do
        if (myvar.item[i][15] == TitanAuctions_Status_Active) then
          if (msg and strfind(msg, myvar.item[i][1])) then
            return myvar.item[i];
          end
        end
      end
    end
  end
  return nil;
end

function TitanAuctions_GetNumAuctionHousesUsed()
  local tn = TitanAuctionsSave.myName;
   local tr = TitanAuctionsSave.myRealm;

   local ahs = 0;
  for j = 1, 3, 1 do
    if ( (TitanAuctionsSave[tn][tr].Owner[j].num) and (TitanAuctionsSave[tn][tr].Bidder[j].num) ) then
      if ( (TitanAuctionsSave[tn][tr].Owner[j].num[2] > 0) or (TitanAuctionsSave[tn][tr].Bidder[j].num[2] > 0) ) then
        ahs = ahs+1;
      end
    end
  end
  return ahs;
end

function TitanAuctions_GetHourString(time,addon)
  local add1 = false;
  local nt = time[1] + addon;
  if (nt >= 24) then
    nt = nt - 24;
    add1 = true;
  end

  local time1 = format(TEXT(TitanAuctions_Time_Format), nt, time[2]);

  if (not time1) then
    time1 = "";
  elseif (add1) then
    time1 = time1 .. "+";
  end

  return time1;
end

function TitanAuctions_GetMinuteString(time,addon)
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

  local time1 = format(TEXT(TitanAuctions_Time_Format), nth, nt);

  if (not time1) then
    time1 = "";
  elseif (add1) then
    time1 = time1 .. "+";
  end

  return time1;
end

function TitanAuctions_GetRemainingTime(time,addon)
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
    return format(TEXT(TitanAuctions_Time_Format), hdiff, mdiff);
  end

end

function TitanAuctions_CalculateExpiryTimes(duration,scanTime)
  local rstr = "";

  local remaining = TitanGetVar(TITAN_AUCTIONS_ID,TITAN_AUCTIONS_REMAINING_TIME);

  if (duration == 4) then
    if (remaining) then
      rstr = " {".. TitanAuctions_GetRemainingTime(scanTime,480) .. " - " .. TitanAuctions_GetRemainingTime(scanTime,1440) .. "}";
    else
      rstr = " {".. TitanAuctions_GetHourString(scanTime,8) .. " - " .. TitanAuctions_GetHourString(scanTime,24) .. "}";
    end
  elseif (duration == 3) then
    if (remaining) then
      rstr = " {".. TitanAuctions_GetRemainingTime(scanTime,120) .. " - " .. TitanAuctions_GetRemainingTime(scanTime,480) .. "}";
    else
      rstr = " {".. TitanAuctions_GetHourString(scanTime,2) .. " - " .. TitanAuctions_GetHourString(scanTime,8) .. "}";
    end
  elseif (duration == 2) then
    if (remaining) then
      rstr = " {".. TitanAuctions_GetRemainingTime(scanTime,30) .. " - " .. TitanAuctions_GetRemainingTime(scanTime,120) .. "}";
    else
      rstr = " {".. TitanAuctions_GetMinuteString(scanTime,30) .. " - " .. TitanAuctions_GetHourString(scanTime,2) .. "}";
    end
  elseif (duration == 1) then
    if (remaining) then
      rstr = " {".. "00:00" .. " - " .. TitanAuctions_GetRemainingTime(scanTime,30) .. "}";
    else
      rstr = " {".. format(TEXT(TitanAuctions_Time_Format), scanTime[1],scanTime[2]) .. " - " .. TitanAuctions_GetMinuteString(scanTime,30) .. "}";
    end
  end

  return rstr;
end

function TitanAuctions_PlaySound()
  if (TitanGetVar(TITAN_AUCTIONS_ID,TITAN_AUCTIONS_PLAY_SOUND)) then
    PlaySoundFile("titanauctions.wav");
  end
end
FlagRSPInfo = {
   isMoving = false;
   isExpanded = false; 

   FLInfoIsExpanded = false;
   FLInfoIsMoving = false;

   FLInfoBtnIsMoving = false;

   FLInfoX = 520;
   FLInfoY = 300;
  
   buttonIsBlinking = false;
   pullInterval = 70;
   pushInterval = 60;
   postInterval = 1;

   pullTick = {};
   pushTick = 0;
   postTick = 0;

   charPerPost = 240;
   maxDescChars = 1600;
   maxDesc = 0;
   partToPost = 1;
   --maxCharsExpanded = 7*240;

   maxCharsUnExpanded = 100;

   boxPurgeInterval = 2592000;

   buttonBlinkInterval = 0.5;
   buttonBlinkState = true;
   buttonBlinkTick = 0;

   descList = {};
   descPos = 1;

   targetChanged = false;
};

FlagRSPInfoBoxList = {};

function FlagRSPInfo.FrameOnMouseDown(arg1, id)
   --FlagRSP.print(arg1);

   if id:GetName() == "FlagRSPInfoBox" then
      if arg1 == "RightButton" and not FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].InfoBoxLocked then
	 FlagRSPInfo.isMoving = true;
	 id:StartMoving();
      elseif arg1 == "LeftButton" then
	 if FlagRSPInfo.isExpanded then
	    FlagRSPInfo.isExpanded = false;
	 else
	    FlagRSPInfo.isExpanded = true;
	 end
	 
	 FlagRSPInfo.displayBox("target");
      end
   elseif id:GetName() == "FRIENDLISTFrameInfoBox" then
      if arg1 == "RightButton" and not FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].FriendlistEntryBoxLocked then
	 FlagRSPInfo.FLInfoIsMoving = true;
	 id:StartMoving();
      elseif arg1 == "LeftButton" then
	 if FlagRSPInfo.FLInfoIsExpanded then
	    FlagRSPInfo.FLInfoIsExpanded = false;
	 else
	    FlagRSPInfo.FLInfoIsExpanded = true;
	 end
      end
      FriendlistMain_Update(true);
   elseif id:GetName() == "FlagRSPInfoBoxButton" then
      if arg1 == "RightButton" then
	 FlagRSPInfo.FLInfoBtnIsMoving = true;
	 id:StartMoving();
      end
   end
end

function FlagRSPInfo.FrameOnMouseUp(arg1, id)

   if arg1 == "RightButton" then
      id:StopMovingOrSizing();

      if id:GetName() == "FlagRSPInfoBox" then
	 if FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].InfoBoxExpandUpwards then
	    FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].InfoBoxX = FlagRSPInfoBox:GetLeft();
	    FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].InfoBoxY = FlagRSPInfoBox:GetBottom();
	 else
	    FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].InfoBoxX = FlagRSPInfoBox:GetLeft();
	    FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].InfoBoxY = FlagRSPInfoBox:GetTop();
	 end
	 
	 FlagRSPInfo.isMoving = false;
      elseif id:GetName() == "FRIENDLISTFrameInfoBox" then
	 FlagRSP.printDebug("FL left: " .. FRIENDLISTFrame:GetLeft());
	 FlagRSP.printDebug("FL top: " .. FRIENDLISTFrame:GetBottom());
	 FlagRSP.printDebug("Box left: " .. id:GetLeft());
	 FlagRSP.printDebug("Box top: " .. id:GetTop());

	 FlagRSPInfo.FLInfoX = id:GetLeft() - FRIENDLISTFrame:GetLeft();
	 FlagRSPInfo.FLInfoY = id:GetTop() - FRIENDLISTFrame:GetBottom();

	 FlagRSPInfo.FLInfoIsMoving = false;
      elseif id:GetName() == "FlagRSPInfoBoxButton" then
	 x,y = FlagRSPInfoBoxButton:GetCenter();
	 
	 FlagRSP.printDebug("x: " .. x);
	 FlagRSP.printDebug("y: " .. y);

	 FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].InfoBoxButtonX = x;
	 FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].InfoBoxButtonY = y;

	 FlagRSPInfo.FLInfoBtnIsMoving = false;
      end
   end
end

function FlagRSPInfo.test()
end


--[[

FlagRSPInfo.hideBox()

- Hide InfoBox.

]]--
function FlagRSPInfo.hideBox()
   FlagRSPInfo.isExpanded = false;
   FlagRSPInfoBox:Hide();
end


--[[

FlagRSPInfo.getBoxLines(playerID)

- Get lines for InfoBox.

]]--
function FlagRSPInfo.getBoxLines(playerID)
   local lines = {};

   local notesText = "";
   local descText = "";
   local titleText = "";
   local rpText = "";
   local rp2Text = "";
   local csText = "";
   
   local targetName = UnitName(playerID);

   if UnitExists(playerID) and targetName ~= nil then
   
         
      if FlagRSPInfo.isExpanded then
	 notesText = Friendlist.getNotes(targetName);
	 descText = FlagRSPInfo.getDescription(targetName, playerID);
      else
	 notesText = Friendlist.getNotes(targetName);
	 
	 if string.len(notesText) > FlagRSPInfo.maxCharsUnExpanded then
	    notesText = string.sub(notesText, 1, FlagRSPInfo.maxCharsUnExpanded) .. "..."; 
	 end
	 
	 descText = FlagRSPInfo.getDescription(targetName, playerID, FlagRSPInfo.maxCharsUnExpanded);
      end
      
      --local surname = TooltipHandler.getSurname(targetName);
      --if surname ~= nil and surname ~= "" then
	 --nameText = targetName .. " " .. surname;
      --else
	 --nameText = targetName;
      --end

      nameText = TooltipHandler.getNameTooltipText(playerID);
      
      --FlagRSP.printDebug(xTP_RPList[UnitName("target")]);

      
      if not FlagRSP.getNameDisp() or TooltipHandler.playerIsKnown(targetName) then
	 titleText = TooltipHandler.getTitle(targetName);
      end

      --rpText = TooltipHandler.compileString("%flagRSPRPLine", playerID);
      rpText = TooltipHandler.getRPTooltipText(targetName, playerID);
      --rp2Text = TooltipHandler.compileString("%flagRSPRP2Line", playerID);
      rp2Text = "";
      --csText = TooltipHandler.compileString("%flagRSPCharStatusLine", playerID);
      csText = TooltipHandler.getCharStatusTooltipText(targetName, playerID);
   else
      nameText = "";
      titleText = "";
      rpText = "";
      rp2Text = "";
      csText = "";
   end
      
   local lines = {};
   
   for i=1, 10 do
      lines[i] = "";
   end
   
   lines[1] = nameText;
   lines[2] = titleText;
   
   lines[3] = rpText;
   lines[4] = rp2Text;
   lines[5] = csText;
   
   if notesText ~= "" and notesText ~= nil then
      lines[6] = "|cFFFFFF00" .. FlagRSP_Locale_InfoBoxNotes .. "|r |cFFFFFFFF" .. notesText .. "|r";
   end
   if descText ~= "" and descText ~= nil then
      lines[7] = "|cFFFFFF00" .. FlagRSP_Locale_InfoBoxDesc .. "|r |cFFFFFFFF" .. descText .. "|r";
   end

   if UnitExists(playerID) and targetName ~= nil and not UnitIsPlayer(playerID) then
      local r, g, b = TooltipHandler.getTooltipNameColor(playerID);
      prefix = "|cFF" .. FlagRSP.getHexString(r*255,2) .. FlagRSP.getHexString(g*255,2) .. FlagRSP.getHexString(b*255,2);
      lines[1] = prefix ..targetName .. "|r";
      lines[2] = "";
      lines[3] = "";
      lines[4] = "";
      lines[5] = "";
      lines[7] = "";      
   end

   return lines;
end


--[[

FlagRSPInfo.checkShowBox(playerID)

- Check if user wants to see InfoBox.

]]--
function FlagRSPInfo.checkShowBox(playerID)
   local showBox = 0;
   local name = UnitName(playerID);
   
   if name ~= nil and name ~= "" and FlagRSPInfoBoxList[FlagRSP.rName][FlagRSP.pName][name] ~= nil then
      if FlagRSPInfoBoxList[FlagRSP.rName][FlagRSP.pName][name].showBox then
	 showBox = 1;
	 FlagRSPInfo.buttonIsBlinking = false;
	 FlagRSPInfoBoxButtonNormalTexture:SetTexture("Interface\\Addons\\flagRSP\\artwork\\flagRSPInfoBoxButton_Up");
      else 
	 showBox = -1;

	 local savedRev = FlagHandler.getDescRev("A", name);

	 if savedRev == nil then
	    savedRev = -1;
	 end

	 if FlagRSPInfoBoxList[FlagRSP.rName][FlagRSP.pName][name].seenRev ~= savedRev then
	    if FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].InfoBoxAutoPopUp then
	       showBox = 1;
	    else
	       FlagRSPInfo.buttonIsBlinking = true;
	    end
	 else
	    FlagRSPInfo.buttonIsBlinking = false;
	    FlagRSPInfoBoxButtonNormalTexture:SetTexture("Interface\\Addons\\flagRSP\\artwork\\flagRSPInfoBoxButton_Up");
	 end
      end
   else
      FlagRSPInfo.buttonIsBlinking = false;
      FlagRSPInfoBoxButtonNormalTexture:SetTexture("Interface\\Addons\\flagRSP\\artwork\\flagRSPInfoBoxButton_Up");
   end

   return showBox;
end


--[[

FlagRSPInfoBoxButton_OnClick(playerID)

- InfoBox button at targetframe clicked.

]]--
function FlagRSPInfoBoxButton_OnClick(playerID)
   local name = UnitName(playerID);
   
   --FlagRSP.printDebug("Toggle box!");

   FlagRSPInfo.targetChanged = false;

   if FlagRSPInfoBoxList[FlagRSP.rName][FlagRSP.pName][name] == nil then
      FlagRSPInfoBoxList[FlagRSP.rName][FlagRSP.pName][name] = {};
   end

   if FlagRSPInfoBoxButton:GetChecked() == nil then
      FlagRSP.printDebug("not checked!");

      FlagRSPInfoBoxList[FlagRSP.rName][FlagRSP.pName][name].showBox = false;
      FlagRSPInfoBoxList[FlagRSP.rName][FlagRSP.pName][name].timeStamp = time();
      if FlagRSP_CharDesc.savedRev[name] ~= nil then
	 FlagRSPInfoBoxList[FlagRSP.rName][FlagRSP.pName][name].seenRev = FlagRSP_CharDesc.savedRev[name];
      else
	 FlagRSPInfoBoxList[FlagRSP.rName][FlagRSP.pName][name].seenRev = -1;
      end
   else
      FlagRSP.printDebug("checked!");

      FlagRSPInfoBoxList[FlagRSP.rName][FlagRSP.pName][name].showBox = true;
      FlagRSPInfoBoxList[FlagRSP.rName][FlagRSP.pName][name].timeStamp = time();
      if FlagRSP_CharDesc.savedRev[name] ~= nil then
	 FlagRSPInfoBoxList[FlagRSP.rName][FlagRSP.pName][name].seenRev = FlagRSP_CharDesc.savedRev[name];
      else
	 FlagRSPInfoBoxList[FlagRSP.rName][FlagRSP.pName][name].seenRev = -1;
      end
   end

   FlagRSPInfo.displayBox("target");
end


--[[

FlagRSPInfoCloseButton_OnClick()

- Close button on InfoBox clicked.

]]--
function FlagRSPInfoBoxCloseButton_OnClick()
   --FlagRSP.print("Hey Ya!");
   FlagRSPInfoBoxButton:SetChecked(0);
   FlagRSPInfoBoxButton_OnClick("target");
end


function FlagRSPInfo.toggleBox()
   if FlagRSPInfoBoxButton:IsVisible() then
      if FlagRSPInfoBoxButton:GetChecked() == nil then
	 FlagRSPInfoBoxButton:SetChecked(1);
	 FlagRSPInfoBoxButton_OnClick("target");
      else
	 FlagRSPInfoBoxButton:SetChecked(0);
	 FlagRSPInfoBoxButton_OnClick("target");
      end
   end
end


--[[

FlagRSPInfo.updateTimestamp(name)

- Update timestamp in InfoBox list for object name.

]]--
function FlagRSPInfo.updateTimestamp(name)
   if FlagRSPInfoBoxList[FlagRSP.rName][FlagRSP.pName][name] ~= nil then
      FlagRSPInfoBoxList[FlagRSP.rName][FlagRSP.pName][name].timeStamp = time();
   end
end


--[[

FlagRSPInfo.displayBox(playerID)

- Display info box.

]]--
function FlagRSPInfo.displayBox(playerID)
   if not FlagRSPConfigure.isInitialized() or FlagRSPInfo.isMoving then
      return "";
   end

   local ticks = {};
   
   --ticks[0] = GetTime();

   targetName = UnitName(playerID);
   
   --if UIParent:IsVisible() then
      --FlagRSP.printM("Visible!");
   --else
      --FlagRSP.printM("Invisible!");
   --end

   if not FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].displayInfoBox then
      FlagRSPInfo.hideBox();
      FlagRSPInfoBoxButton:Hide();
   else
      if GetTime() > FlagRSP.newTickRescaleBoxBtn then
	 FlagRSPInfoBoxButton:SetScale(2);
	 FlagRSPInfoBoxButton:SetScale(1);
	 FlagRSP.newTickRescaleBoxBtn = GetTime() + FlagRSP.rescaleBoxBtnInterval;
      end

      if FlagRSPInfo.buttonIsBlinking then
	 if GetTime() > FlagRSPInfo.buttonBlinkTick then
	    if FlagRSPInfo.buttonBlinkState then
	       FlagRSPInfoBoxButtonNormalTexture:SetTexture("Interface\\Addons\\flagRSP\\artwork\\flagRSPInfoBoxButton_Blink");
	       FlagRSPInfo.buttonBlinkState = false;
	    else
	       FlagRSPInfoBoxButtonNormalTexture:SetTexture("Interface\\Addons\\flagRSP\\artwork\\flagRSPInfoBoxButton_Up");
	       FlagRSPInfo.buttonBlinkState = true;
	    end
	    
	    FlagRSPInfo.buttonBlinkTick = GetTime() + FlagRSPInfo.buttonBlinkInterval;
	 end
      end
      
      if UIParent:IsVisible() then
	 if not FlagRSPInfo.FLInfoBtnIsMoving then
	    if FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].InfoBoxButtonX ~= -1 and FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].InfoBoxButtonY ~= -1 then
	       
	       FlagRSPInfoBoxButton:ClearAllPoints();
	       FlagRSPInfoBoxButton:SetPoint("TOPLEFT", "UIParent", "BOTTOMLEFT", FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].InfoBoxButtonX-12, FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].InfoBoxButtonY+12);
	       --FlagRSPInfoBoxButton:SetPoint("BOTTOMRIGHT", "UIParent", "BOTTOMLEFT", FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].InfoBoxButtonX+12, FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].InfoBoxButtonY-12);
	    else
	       FlagRSPInfoBoxButton:ClearAllPoints();
	       FlagRSPInfoBoxButton:SetPoint("TOPLEFT", "TargetFrame", "CENTER", 12-12, 32+12);
	       --FlagRSPInfoBoxButton:SetPoint("BOTTOMRIGHT", "TargetFrame", "CENTER", 12+12, 32-12);
	    end
	 end
	 
	 FlagRSPInfoBoxButton:Show();
	 FlagRSPInfoBoxButton:Raise();
      else
	 --FlagRSP.printDebug("Targetframe is invisible.");
	 --FlagRSPInfoBoxButton:Hide();
	 --FlagRSPInfoBox:Hide();
	 
	 return;
      end	    

      --ticks[1] = GetTime();

      local check = FlagRSPInfo.checkShowBox(playerID);
      FlagRSPInfo.updateTimestamp(targetName);
      
      --FlagRSP.printDebug("check for InfoBox is: " .. check);
      showBox = true;

      if check == 1 then 
	 showBox = true; 
      elseif check == -1 then
	 showBox = false; 
      end

      if check == -1 and FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].alwaysShowInfoBox and FlagRSPInfo.targetChanged then
	 FlagRSPInfo.targetChanged = false;
	 FlagRSPInfoBoxList[FlagRSP.rName][FlagRSP.pName][targetName].showBox = true;
	 showBox = true;
      end

      --ticks[2] = GetTime();

      local lines = {};
      if showBox then
	 lines = FlagRSPInfo.getBoxLines(playerID);
 
	 if lines[2] == "" and lines[3] == "" and lines[4] == "" and lines[5] == "" and lines[6] == "" and lines[7] == "" and lines[8] == "" and lines[9] == "" and lines[10] == "" then
		 
	    -- find reasons to hide the box because of no information inside.
	    if not UnitIsPlayer(playerID) then
	       -- obviously a NPC or pet.
	       showBox = false;
	    elseif TooltipHandler.getSurname(UnitName(playerID)) == "" then
	       showBox = false;
	    end
	 end
      end      
      


      if UnitAffectingCombat("player") or not showBox then
	 FlagRSPInfo.hideBox();
	 FlagRSPInfoBoxButton:SetChecked(0);
	 
	 if UnitExists(playerID) and targetName ~= nil and (Friendlist.isFriend(UnitName(playerID)) or FlagHandler.getFlag("RPFlag", UnitName(playerID)) ~= "") then
	 else
	    --FlagRSP.printDebug("dont show button");
	    FlagRSPInfoBoxButton:Hide();
	 end
      else
	 
	 --FlagRSP.printDebug("Box is still visible.");
	 
	 FlagRSPInfoBoxButton:SetChecked(1);

	 --ticks[3] = GetTime();

	 FlagRSPInfo.updateBox("FlagRSPInfoBox", lines, "UIParent", FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].InfoBoxExpandUpwards, FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].InfoBoxX, FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].InfoBoxY, FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].InfoBoxWidth, showBox);
		 
      end
   end

   --ticks[4] = GetTime();

   --FlagRSP.printDebug("showBox. Time needed 0-1: " .. ticks[1]-ticks[0]);
   --FlagRSP.printDebug("showBox. Time needed 1-2: " .. ticks[2]-ticks[1]);
   --FlagRSP.printDebug("showBox. Time needed 2-3: " .. ticks[3]-ticks[2]);
   --FlagRSP.printDebug("showBox. Time needed 3-4: " .. ticks[4]-ticks[3]);
   --FlagRSP.printDebug("showBox. Time needed 0-4: " .. ticks[4]-ticks[0]);
end


function FlagRSPInfo.updateBox(boxS,lines,parent,expandDir,x,y,width,showBox)
   local box = getglobal(boxS);
   local height = 0;  
   local bText, bText2;

   if box ~= nil then
      if not showBox then
	 box:Hide();
      else
	 box:Show();
	 box:SetWidth(width);
	 box:SetAlpha(1);
	 box:SetBackdropColor(0,0,0,FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].InfoBoxAlphaBackdrop);
	 height = 22;
	 local ii = 1;

	 for i=1, 12 do
	    bText = getglobal(boxS .. "Text" .. i);

	    if i == 1 then 
	       bText:SetWidth(width - 32);
	       bText:SetTextHeight(FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].InfoBoxTextSize*1.5);
	    else
	       bText:SetWidth(width - 22);
	       bText:SetTextHeight(FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].InfoBoxTextSize);
	    end

	    while ((lines[ii] == "" or lines[ii] == nil) and ii <= 12) do
	       ii = ii + 1;
	    end
	    if ii <= 12 then
	       bText:SetText(lines[ii]);
	       bText:Show();

	       height = height + bText:GetHeight();

	       ii = ii + 1;
	    else
	       bText:SetText("");
	       bText:SetHeight(0);
	       bText:Hide();
	    end
	 end
	 
	 box:SetHeight(height);

	 if expandDir then
	    box:SetPoint("BOTTOMLEFT", parent, "BOTTOMLEFT", x, y);
	    box:SetPoint("TOPLEFT", parent, "BOTTOMLEFT", x, y+height);
	 else
	    box:SetPoint("TOPLEFT", parent, "BOTTOMLEFT", x, y);
	    box:SetPoint("BOTTOMLEFT", parent, "BOTTOMLEFT", x, y-height);
	 end
	 
	 if GetTime() > FlagRSP.newTickRescaleBox[boxS] then
	    box:SetScale(2);
	    box:SetScale(1);
	    FlagRSP.newTickRescaleBox[boxS] = GetTime() + FlagRSP.rescaleBoxInterval;
	 end
      end
   end
end


--[[

FlagRSPInfo.getDescription(name)

- Returns the character description for player name.

]]--
function FlagRSPInfo.getDescription(name, playerID, limit)
   desc= "";
   if limit == nil then
      limit = -1;
   end

   if playerID == nil then
      playerID = "";
   end

   if (playerID == "target" and UnitIsPlayer(playerID)) or playerID ~= "target" then
      if name ~= nil and name ~= "" then
	 --if FlagRSP_CharDesc.availRev[name] ~= nil and FlagRSP_CharDesc.availRev[name] >= 0 then

	 --if FlagRSP_CharDesc.savedRev[name] == nil then
	    -- -1 means we have no description yet.
	    --FlagRSP_CharDesc.savedRev[name] = -1;
	 --end
	 
	 local rev, complete;
	 local descLines;
	 
	 complete, rev, descLines = FlagHandler.getDesc("A", name);
	 
	 FlagRSP_CharDesc.savedRev[name] = rev;

	 -- if user has not (yet) send drev (e.g. because he cannot because he is playing the other faction)
         -- we will assume that our saved revision is his up to date revision.
	 if FlagRSP_CharDesc.availRev[name] == nil then
	    FlagRSP_CharDesc.availRev[name] = rev;
	 end

	 --FlagRSP.printDebug("rev is: " .. rev);
	 --FlagRSP.printDebug("avail is: " .. FlagRSP_CharDesc.availRev[name]);

	 if rev ~= FlagRSP_CharDesc.availRev[name] and FlagRSP_CharDesc.availRev[name] ~= -1 then
	    --FlagRSP.printDebug("pulling");
	    FlagRSPInfo.pullDescription(name);
	 elseif rev == FlagRSP_CharDesc.availRev[name] then
	    -- build desc from array.
	    for i=1, FlagRSPInfo.maxDesc do
	       if descLines[i] ~= nil then
		  desc = desc .. descLines[i];
	       end
	    end	

	    if not complete and FlagRSP_CharDesc.availRev[name] ~= -1 then
	       FlagRSP.printDebug("pulling");
	       FlagRSPInfo.pullDescription(name);
	    end
	 end
	 
	 if 1 == 0 then
	    if FlagRSP_CharDesc.savedRev[name] ~= FlagRSP_CharDesc.availRev[name] then
	       --pull description.
	       FlagRSPInfo.pullDescription(name);
	    else
	       if FlagRSP_CharDesc[name] ~= nil then
		  -- build desc from array.
		  for i=1, FlagRSPInfo.maxDesc do
		     if FlagRSP_CharDesc[name][i] ~= nil then
			desc = desc .. FlagRSP_CharDesc[name][i];
		     end
		  end
	       end
	    end
	 end
	 
	 if limit >= 0 and string.len(desc) > limit then
	    desc = string.sub(desc, 1, limit) .. "..."; 
	 end
	 
	 --elseif
	 --end
      end
   end

   return desc;
end


--[[

FlagRSPInfo.pullDescription(name)

- Pulls the character description for player name.

]]--
function FlagRSPInfo.pullDescription(name)
   if FlagRSP.isInitialized then
      
      --FlagRSP.printM("Pulling description for: " .. name);

      if FlagRSPInfo.pullTick[name] == nil then
	 FlagRSPInfo.pullTick[name] = 0;
      end
      
      --FlagRSP.printDebug("flagRSP: DEBUG: Time: " ..  GetTime());	 
      --FlagRSP.printDebug("flagRSP: DEBUG: Next pull: " ..  FlagRSPInfo.pullTick[name]);	 
      
      if GetTime() > FlagRSPInfo.pullTick[name] then
	 --FlagRSP.printDebug("flagRSP: DEBUG: We WILL pull for: " ..  name);	 
	 
	 --FlagRSP.printM("Pulling description from: " .. xTP_ChannelName);
	 id = GetChannelName(xTP_ChannelName);
	 --SendChatMessage("<DPULL>" .. name, "CHANNEL", FlagRSP_Locale_CLanguage, id); 
	 ChatHandler.sendMessage("<DP>" .. name);
	 
	 FlagRSPInfo.pullTick[name] = GetTime() + FlagRSPInfo.pullInterval;
      end
   end
end


--[[

FlagRSPInfo.pushDescription()

- Prepare posting of character description for self.

]]--
function FlagRSPInfo.pushDescription(partial)
   --FlagRSP.printDebug("flagRSP: DEBUG: Someone wants our description!");
   
   if partial == nil then
      partial = false;
   end

   if FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].CharDescRev >= 0 and FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].CharDesc ~= nil and FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].CharDesc ~= "" then
      
      local desc = string.gsub(FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].CharDesc, "\n", "\\l");

      if partial then
	 if 1 == 0 then
	    local partsNeeded = math.ceil(string.len(desc)/(FlagRSPInfo.charPerPost));
	    if partsNeeded > FlagRSPInfo.maxDesc then
	       partsNeeded = FlagRSPInfo.maxDesc;
	    end
	    
	    local partToPost = FlagRSPInfo.partToPost;
	    
	    FlagRSPInfo.partToPost = FlagRSPInfo.partToPost + 1;
	    if FlagRSPInfo.partToPost > partsNeeded then
	       FlagRSPInfo.partToPost = 1;
	    end
	    
	    FlagRSP.printDebug("maximum: " .. (FlagRSPInfo.maxDesc*FlagRSPInfo.charPerPost) .. ", length " .. string.len(desc) .. ". posting part of description. How many parts needed: " .. partsNeeded .. ". Posting part: " .. partToPost);
	    
	    local line = string.sub(desc, (partToPost-1)*FlagRSPInfo.charPerPost+1, partToPost*FlagRSPInfo.charPerPost);
	    FlagRSP.printDebug("line length: " .. string.len(line) .. ", line is: " .. line);
	    
	    if FlagRSPInfo.partToPost == partsNeeded then
	       line = line .. "\\eod";
	    end
	    
	    local n;
	    if FlagRSPInfo.descPos < 10 then
	       n = "0" .. partToPost;
	    else
	       n = partToPost;
	    end
	    
	    ChatHandler.sendMessage("<P" .. n .. ">" .. line);
	 end
      else
	 --FlagRSP.printDebug("we shall push");
	 if GetTime() > FlagRSPInfo.pushTick then
	    --FlagRSP.printDebug("we will push");
	    --local descList = {};
	    local p = 1;
	    local n = "";
	    FlagRSPInfo.descList = {};
	    FlagRSPInfo.descPos = 1;
	    FlagRSP.newTickDesc = 0;
	    --FlagRSPInfo.postDesc = false;
	       
	    local parts = 0;
	    for i=1, FlagRSPInfo.maxDesc do
	       FlagRSPInfo.descList[i] = string.sub(desc, p, p+FlagRSPInfo.charPerPost-1);
	       p = p + FlagRSPInfo.charPerPost;
	       
	       if FlagRSPInfo.descList[i] ~= nil and FlagRSPInfo.descList[i] ~= "" then
		  if i < 10 then
		     n = "0" .. i;
		  else
		     n = i;
		  end
		  
		  FlagRSPInfo.descList[i] = string.gsub(FlagRSPInfo.descList[i], "<", "\\(");
		  FlagRSPInfo.descList[i] = string.gsub(FlagRSPInfo.descList[i], ">", "\\)");
		  
		  
		  --FlagRSP.printDebug(FlagRSPInfo.maxDesc);
		  
		  --FlagRSP.printDebug("Desc: " .. i .. ": " .. FlagRSPInfo.descList[i]);
		  --SendChatMessage("<D" .. n .. ">" .. FlagRSPInfo.descList[i], "CHANNEL", FlagRSP_Locale_CLanguage, id); 	 
		  --FlagRSPInfo.descList[i] = "";
		  --FlagRSPInfo.postTick = GetTime() + FlagRSPInfo.postInterval;

		  parts = i;
	       end
	    end
	    
	    
	    if parts > 0 then
	       FlagRSPInfo.descList[parts] = FlagRSPInfo.descList[parts] .. "\\eod";
	    end

	    --FlagRSPInfo.postDesc = true;
	    
	    FlagRSPInfo.pushTick = GetTime() + FlagRSPInfo.pushInterval;
	    FlagRSP.ownDescriptionSent = FlagRSP.ownDescriptionSent + 1;
	 end
	 FlagRSP.ownDescriptionRequested = FlagRSP.ownDescriptionRequested + 1;
      end
   end
end


--[[

FlagRSPInfo.postDescription()

- Posts the character description for self.

]]--
function FlagRSPInfo.postDescription()
   --FlagRSP.printDebug("Test");
   --FlagRSP.printDebug(FlagRSPInfo.descPos);
   local n;

   if FlagRSPInfo.descList[FlagRSPInfo.descPos] ~= nil and FlagRSPInfo.descList[FlagRSPInfo.descPos] ~= "" and FlagRSPInfo.descPos <= FlagRSPInfo.maxDesc then

      if FlagRSPInfo.descPos < 10 then
	 n = "0" .. FlagRSPInfo.descPos;
      else
	 n = FlagRSPInfo.descPos;
      end

      FlagRSP_JoinChannel();
      id = GetChannelName(xTP_ChannelName);
      --SendChatMessage("<D" .. n .. ">" .. FlagRSPInfo.descList[FlagRSPInfo.descPos], "CHANNEL", FlagRSP_Locale_CLanguage, id); 	 
      ChatHandler.sendMessage("<D" .. n .. ">" .. FlagRSPInfo.descList[FlagRSPInfo.descPos]);
      FlagRSPInfo.descPos = FlagRSPInfo.descPos + 1;
   --elseif FlagRSP.descPos > FlagRSPInfo.maxDesc then
   end      
end
   

--[[

FlagRSPInfo.saveDescription()

- Saves the character description for player name.

]]--
function FlagRSPInfo.saveDescription(num, text, name, partial)
   if partial == nil then
      partial = false;
   end

   local no = tonumber(num);

   --FlagRSP.printDebug(num);   

   if no ~= nil then
      --FlagRSP.printDebug("Recieved description line number " .. no .. " by " .. name .. ". Text is: " .. text);
      if FlagRSP_CharDesc[name] == nil then
	 FlagRSP_CharDesc[name] = {};
      end
      
      FlagRSP_CharDesc[name][no] = string.gsub(text, "\\l", "\n");
      
      if FlagRSP_CharDesc.availRev[name] == nil then
	 FlagRSP_CharDesc.availRev[name] = FlagHandler.getDescRev("A", name);
      end

      --if not partial then
      --FlagRSP.printDebug("save new");
      FlagRSP_CharDesc.savedRev[name] = FlagRSP_CharDesc.availRev[name];
      --end

      FlagHandler.addDesc("A", no, string.gsub(text, "\\l", "\n"), name, FlagRSP_CharDesc.availRev[name], partial);
   end
end


--[[

FlagRSPInfo.saveEditDescription()

- Saves the own character description from the edit box.

]]--
function FlagRSPInfo.saveEditDescription()
   FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].CharDescRev = FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].CharDescRev + 1;
   
   FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].CharDesc = FlagRSPDescEditorEditBox:GetText();

   FlagRSPDescEditor:Hide();
   xTooltip_Post();
end


--[[

FlagRSPInfo.purgeBoxList()

- Purges the InfoBox list.

]]--
function FlagRSPInfo.purgeBoxList()
   local delTime = time() - FlagRSPInfo.boxPurgeInterval;

   --FlagRSP.print("delTime is: " .. delTime);
   --FlagRSP.print("nowTime is: " .. time());

   for name,value in FlagRSPInfoBoxList[FlagRSP.rName][FlagRSP.pName] do
      --FlagRSP.print(name);
      --FlagRSP.print(value.timeStamp);
      
      if value.timeStamp < delTime then
	 --FlagRSP.print("Delete entry for: " .. name);
	 --value = nil;
	 FlagRSPInfoBoxList[FlagRSP.rName][FlagRSP.pName][name] = nil;
      end
   end
end

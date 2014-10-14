sdVersion = "0.3." .. string.sub("$Rev: 122 $",string.find("$Rev: 122 $","%d+"));

sdFrame1 = nil;
sdFrame2 = nil;
sdTexture1 = nil;
sdTexture2 = nil;
sdText1 = nil;
sdColor_BAD = { 1, 0, 0, .4 };
sdColor_WARN = { 1, 1, 0, .4 };
sdColor_OK = { 0, 1, 0, .4 };

CT_RABoss_Announce_original = nil;
BigWigsMessages_BigWigs_Message_original = nil;

sdUpdateInterval = 0.5; -- time between update in seconds
sdLastUpdate = 0.0; -- time since last update

sdCurrentBombType = ""; -- either LB or BA

sdLivingBombDuration = 8.0; -- time from cast to explosion, in seconds
sdBurningAdrenalineDuration = 20.0; -- time from cast to explosion, in seconds

sdBombStartedAt1 = 0.0; -- time from GetTime() that bomb started
sdBombStartedAt2 = 0.0;
sdBombTarget1 = nil; -- current bomb target UnitID
sdBombTarget1Name = nil;
sdBombTarget2 = nil; -- current bomb target UnitID
sdBombTarget2Name = nil;

function SafeDistance_OnLoad()
	this:RegisterEvent("VARIABLES_LOADED");
end

function SafeDistance_OnEvent()
	if event=="VARIABLES_LOADED" then SafeDistance_Init() end
end

function SafeDistance_Init()
	SLASH_SD1 = SafeDistanceLocals.SDSlash1;
	SLASH_SD2 = SafeDistanceLocals.SDSlash2;
	SlashCmdList["SD"] = function(msg)
		SafeDistance_SlashCommandHandler(msg);
	end

	if(DEFAULT_CHAT_FRAME) then
		DEFAULT_CHAT_FRAME:AddMessage(SafeDistanceLocals.SDTitle .. " " .. sdVersion .. " by SlackerJer (slackerjer@gmail.com) http://slackerjer.wowinterface.com");
	end

	if (SafeDistanceVars == nil) then
		SafeDistanceVars = { left = nil; bottom = nil; };
	end
	if (CT_RABoss_Announce ~= nil) then
		CT_RABoss_Announce_original = CT_RABoss_Announce;
		CT_RABoss_Announce = SafeDistance_CTAnnounce;
	elseif (BigWigsMessages ~= nil) then
		BigWigsMessages_BigWigs_Message_original = BigWigsMessages.BigWigs_Message;
		BigWigsMessages.BigWigs_Message = SafeDistance_BWMessage;
	end
	sdFrame1 = CreateFrame("Frame",nil,UIParent);
	sdFrame1:SetFrameStrata("BACKGROUND");
	sdFrame1:SetWidth(80);
	sdFrame1:SetHeight(40);
	if ((SafeDistanceVars.left == nil) or (SafeDistanceVars.bottom == nil)) then
		sdFrame1:SetPoint("CENTER",0,0)
	else
		sdFrame1:SetPoint("BOTTOMLEFT",SafeDistanceVars.left,SafeDistanceVars.bottom);
	end
	sdFrame1:EnableMouse(true);
	sdFrame1:SetMovable(true);
	sdFrame1:SetScript("OnMouseDown",SafeDistance_OnMouseDown);
	sdFrame1:SetScript("OnMouseUp",SafeDistance_OnMouseUp);
	sdFrame1:SetScript("OnHide",SafeDistance_OnHide);

	sdTexture1 = sdFrame1:CreateTexture(nil,"BACKGROUND");
	sdTexture1:SetTexture(unpack(sdColor_OK));
	sdTexture1:SetAllPoints(sdFrame1);
	
	sdText1 = sdFrame1:CreateFontString("sdText1","OVERLAY");
	sdText1:SetFontObject(GameFontWhite);
	sdText1:SetAllPoints(sdFrame1);
	sdText1:SetText(SafeDistanceLocals.SDTitle .. "\n" .. SafeDistanceLocals.SDWindow .. " 1");

	sdFrame1.isLocked = true; -- lock frame by default

	sdFrame1:Hide();

	sdFrame2 = CreateFrame("Frame",nil,UIParent);
	sdFrame2:SetFrameStrata("BACKGROUND");
	sdFrame2:SetWidth(80);
	sdFrame2:SetHeight(40);
	sdFrame2:SetPoint("BOTTOMLEFT","sdFrame1","TOPLEFT");
	sdTexture2 = sdFrame2:CreateTexture(nil,"BACKGROUND");
	sdTexture2:SetTexture(unpack(sdColor_OK));
	sdTexture2:SetAllPoints(sdFrame2);
	sdText2 = sdFrame2:CreateFontString("sdText2","OVERLAY");
	sdText2:SetFontObject(GameFontWhite);
	sdText2:SetAllPoints(sdFrame2);
	sdText2:SetText(SafeDistanceLocals.SDTitle .. "\n" .. SafeDistanceLocals.SDWindow .. " 2");
	sdFrame2:Hide();


--	sdFrame1:Show();
end

function SafeDistance_CTAnnounce(msg, fullRaid)
	if (msg ~= nil) then
		SafeDistance_ProcessMessage(msg);
	end
	CT_RABoss_Announce_original(msg, fullraid);
end

function SafeDistance_BWMessage(bwpointer, msg, type)
	if (msg ~= nil) then
		SafeDistance_ProcessMessage(msg);
	end
	BigWigsMessages_BigWigs_Message_original(bwpointer, msg, type);
end

function SafeDistance_ProcessMessage(msg)
	local bombCheckMessage1 = "";
	local bombCheckMessage2 = "";

	-- check for Living Bomb
	if (CT_RABOSS_BARON_BOMBWARNRAID ~= nil) then
		bombCheckMessage1 = CT_RABOSS_BARON_BOMBWARNRAID;
	else
		bombCheckMessage1 = AceLibrary("AceLocale-2.2"):new("BigWigsBaron Geddon")["bomb_message_other"];
		bombCheckMessage2 = AceLibrary("AceLocale-2.2"):new("BigWigsBaron Geddon")["bomb_message_you"];
	end
	if ((string.find(msg, bombCheckMessage2)) or (string.find(msg, string.format(bombCheckMessage1,string.sub(msg,1,string.find(msg," ")-1))))) then
		if (string.find(msg, bombCheckMessage2)) then -- it is us, use playername
			sdBombTarget1Name = UnitName("player");
		else
			sdBombTarget1Name = string.sub(msg, 1, string.find(msg," ")-1);
		end
		sdBombStartedAt1 = GetTime();
		if (sdBombTarget1Name == UnitName("player")) then
			sdBombTarget1 = "player";
		else
			local i;
			local name = nil;
			for i = 1, 40 do
				name, _, _, _, _, _, _, _ = GetRaidRosterInfo(i);
				if (name == sdBombTarget1Name) then
					sdBombTarget1 = "raid" .. i
					break;
				end
			end
			if (string.sub(sdBombTarget1,1,4) ~= "raid") then -- didn't get the UnitID ??
				-- shouldn't get here, bomb target not in raid, set to nil
				sdBombTarget1 = nil;
				sdBombTarget1Name = nil;
			end
		end
		sdFrame1:Show();
		sdCurrentBombType = "LB";
	end
	
	-- check for Burning Adrenaline
	if (CT_RABOSS_VAEL_BURNINGWARNTELL ~= nil) then
		bombCheckMessage1 = " IS BURNING ***";
	else
		bombCheckMessage1 = AceLibrary("AceLocale-2.2"):new("BigWigsVaelastrasz the Corrupt")["warn2"];
		bombCheckMessage2 = AceLibrary("AceLocale-2.2"):new("BigWigsVaelastrasz the Corrupt")["warn1"];
	end
	if ((string.find(msg, bombCheckMessage1)) or (string.find(msg, bombCheckMessage2))) then
		if (string.find(msg, bombCheckMessage1)) then
			if (CT_RABOSS_VAEL_BURNINGWARNTELL ~= nil) then -- CTRA
				sdBombTarget2Name = string.sub(msg, 1, 0-(string.len(bombCheckMessage1) + 1));
				sdBombTarget2Name = string.sub(msg, 5);
			else -- BigWigs
				sdBombTarget2Name = string.sub(msg, 1, 0-(string.len(bombCheckMessage1) + 1));
			end
		else -- it is us, use playername
			sdBombTarget2Name = UnitName("player");
		end
		sdBombStartedAt2 = GetTime();
		if (sdBombTarget2Name == UnitName("player")) then
			sdBombTarget2 = "player";
		else
			local i;
			local name = nil;
			for i = 1, 40 do
				name, _, _, _, _, _, _, _ = GetRaidRosterInfo(i);
				if (name == sdBombTarget2Name) then
					sdBombTarget2 = "raid" .. i
					break;
				end
			end
			if (string.sub(sdBombTarget2,1,4) ~= "raid") then -- didn't get the UnitID ??
				-- shouldn't get here, bomb target not in raid, set to nil
				sdBombTarget2 = nil;
				sdBombTarget2Name = nil;
			end
		end
		if (sdBombTarget1 == nil) then -- if first target not there, move up second
			sdBombTarget1 = sdBombTarget2;
			sdBombTarget1Name = sdBombTarget2Name;
			sdBombStartedAt1 = sdBombStartedAt2;
			sdBombTarget2 = nil;
			sdBombTarget2Name = nil;
			sdBombStartedAt2 = 0;
			sdFrame2:Hide();
		end
		sdFrame1:Show();
		if (sdBombTarget2 ~= nil) then
			sdFrame2:Show();
		end
		sdCurrentBombType = "BA";
	end
	
end

function SafeDistance_OnUpdate(elapsed)
 	local distanceRange = "";
	sdLastUpdate = sdLastUpdate + elapsed;
	if (sdLastUpdate > sdUpdateInterval) then
		-- living bomb
	  if (sdCurrentBombType == "LB") then
		  if (sdBombTarget1 and ((GetTime() - sdBombStartedAt1) > sdLivingBombDuration)) then -- living bomb has gone off already, clear
		  	sdBombStartedAt1 = 0;
		  	sdBombTarget1 = nil;
		  	sdBombTarget1Name = nil;
		  	sdFrame1:Hide();
		  elseif (sdBombTarget1) then -- living bomb still active
		  	local distanceRange = "";
		  	if (CheckInteractDistance(sdBombTarget1,1) ~= nil) then -- definite danger
		  		distanceRange = SafeDistanceLocals.SD5Yards;
		  		sdTexture1:SetTexture(unpack(sdColor_BAD));
		  	elseif (CheckInteractDistance(sdBombTarget1,3) ~= nil) then -- definite danger
		  		distanceRange = SafeDistanceLocals.SD10Yards;
		  		sdTexture1:SetTexture(unpack(sdColor_BAD));
		  	elseif (CheckInteractDistance(sdBombTarget1,2) ~= nil) then -- definite danger
		  		distanceRange = SafeDistanceLocals.SD11Yards;
		  		sdTexture1:SetTexture(unpack(sdColor_BAD));
		  	elseif (CheckInteractDistance(sdBombTarget1,4) ~= nil) then -- possible danger
		  		distanceRange = SafeDistanceLocals.SD30Yards;
		  		sdTexture1:SetTexture(unpack(sdColor_WARN));
		  	else -- guaranteed safe
		  		distanceRange = SafeDistanceLocals.SD30PlusYards;
		  		sdTexture1:SetTexture(unpack(sdColor_OK));
		  	end
		  	sdText1:SetText(sdBombTarget1Name .. "\n" .. floor(sdLivingBombDuration - (GetTime() - sdBombStartedAt1)) .. SafeDistanceLocals.SDShorthandSecond .. "   " .. distanceRange);
		  	sdFrame1:Show();
		  end
		end
	  
	  -- burning adrenaline
	  if (sdCurrentBombType == "BA") then
		  if (sdBombTarget1 and ((GetTime() - sdBombStartedAt1) > sdBurningAdrenalineDuration)) then -- burning adrenaline has gone off already, clear
		  	sdBombStartedAt1 = 0;
		  	sdBombTarget1 = nil;
		  	sdBombTarget1Name = nil;
		  	sdFrame1:Hide();
		  end
		  if (sdBombTarget2 and ((GetTime() - sdBombStartedAt2) > sdBurningAdrenalineDuration)) then
		  	sdBombStartedAt2 = 0;
		  	sdBombTarget2 = nil;
		  	sdBombTarget2Name = nil;
		  	sdFrame2:Hide();
		  end
			if (sdBombTarget1 == nil) then -- if first target not there, move up second
				sdBombTarget1 = sdBombTarget2;
				sdBombTarget1Name = sdBombTarget2Name;
				sdBombStartedAt1 = sdBombStartedAt2;
				sdBombTarget2 = nil;
				sdBombTarget2Name = nil;
				sdBombStartedAt2 = 0;
				sdFrame2:Hide();
			end
			if (sdBombTarget1) then
		  	distanceRange = "";
		  	if (CheckInteractDistance(sdBombTarget1,1) ~= nil) then -- definite danger
		  		distanceRange = SafeDistanceLocals.SD5Yards;
		  		sdTexture1:SetTexture(unpack(sdColor_BAD));
		  	elseif (CheckInteractDistance(sdBombTarget1,3) ~= nil) then -- definite danger
		  		distanceRange = SafeDistanceLocals.SD10Yards;
		  		sdTexture1:SetTexture(unpack(sdColor_BAD));
		  	elseif (CheckInteractDistance(sdBombTarget1,2) ~= nil) then -- possible danger
		  		distanceRange = SafeDistanceLocals.SD11Yards;
		  		sdTexture1:SetTexture(unpack(sdColor_WARN));
		  	else -- guaranteed safe
		  		distanceRange = SafeDistanceLocals.SD11PlusYards;
		  		sdTexture1:SetTexture(unpack(sdColor_OK));
		  	end
		  	sdText1:SetText(sdBombTarget1Name .. "\n" .. floor(sdBurningAdrenalineDuration - (GetTime() - sdBombStartedAt1)) .. SafeDistanceLocals.SDShorthandSecond .. "   " .. distanceRange);
		  	sdFrame1:Show();
			end
			if (sdBombTarget2) then
		  	distanceRange = "";
		  	if (CheckInteractDistance(sdBombTarget2,1) ~= nil) then -- definite danger
		  		distanceRange = SafeDistanceLocals.SD5Yards;
		  		sdTexture2:SetTexture(unpack(sdColor_BAD));
		  	elseif (CheckInteractDistance(sdBombTarget2,3) ~= nil) then -- definite danger
		  		distanceRange = SafeDistanceLocals.SD10Yards;
		  		sdTexture2:SetTexture(unpack(sdColor_BAD));
		  	elseif (CheckInteractDistance(sdBombTarget2,2) ~= nil) then -- possible danger
		  		distanceRange = SafeDistanceLocals.SD11Yards;
		  		sdTexture2:SetTexture(unpack(sdColor_WARN));
		  	else -- guaranteed safe
		  		distanceRange = SafeDistanceLocals.SD11PlusYards;
		  		sdTexture2:SetTexture(unpack(sdColor_OK));
		  	end
		  	sdText2:SetText(sdBombTarget2Name .. "\n" .. floor(sdBurningAdrenalineDuration - (GetTime() - sdBombStartedAt2)) .. SafeDistanceLocals.SDShorthandSecond .. "   " .. distanceRange);
		  	sdFrame2:Show();
			end
		end
	end
end

function SafeDistance_SlashCommandHandler(msg)
	if (msg == "") then
		DEFAULT_CHAT_FRAME:AddMessage(SafeDistanceLocals.SDTitle .. " " .. sdVersion .. " by SlackerJer (slackerjer@gmail.com) http://slackerjer.wowinterface.com");
		DEFAULT_CHAT_FRAME:AddMessage(SafeDistanceLocals.SDHelp);
	elseif (msg == SafeDistanceLocals.SDLock) then
		sdFrame1.isLocked = true;
		sdFrame1:Hide();
		sdFrame2:Hide();
	elseif (msg == SafeDistanceLocals.SDUnlock) then
		sdFrame1.isLocked = false;
		sdText1:SetText(SafeDistanceLocals.SDFrameUnlocked);
		sdFrame1:Show();
		sdFrame2:Show();
	elseif (msg == SafeDistanceLocals.SDReset) then
		sdFrame1:Hide();
		sdFrame2:Hide();
		SafeDistanceVars = nil;
		SafeDistance_Init();
	end
end


function SafeDistance_OnMouseUp()
 if ( sdFrame1.isMoving ) then
  sdFrame1:StopMovingOrSizing();
  sdFrame1.isMoving = false;
  SafeDistanceVars.left = sdFrame1:GetLeft();
  SafeDistanceVars.bottom = sdFrame1:GetBottom();
 end
end

function SafeDistance_OnMouseDown()
 if ( ( ( not sdFrame1.isLocked ) or ( sdFrame1.isLocked == 0 ) ) and ( arg1 == "LeftButton" ) ) then
  sdFrame1:StartMoving();
  sdFrame1.isMoving = true;
 end
end

function SafeDistance_OnHide()
 sdTexture1:SetTexture(unpack(sdColor_OK));
 if ( sdFrame1.isMoving ) then
  sdFrame1:StopMovingOrSizing();
  sdFrame1.isMoving = false;
  SafeDistanceVars.left = sdFrame1:GetLeft();
  SafeDistanceVars.bottom = sdFrame1:GetBottom();
 end
end
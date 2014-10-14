BANANA_SYMBOL_COLOR1 = "00f7f26c";
BANANA_SYMBOL_COLOR2 = "00f69218";
BANANA_SYMBOL_COLOR3 = "00cb32dd";
BANANA_SYMBOL_COLOR4 = "000fb20a";
BANANA_SYMBOL_COLOR5 = "008cb0c5";
BANANA_SYMBOL_COLOR6 = "00007aff";
BANANA_SYMBOL_COLOR7 = "00d7422e";
BANANA_SYMBOL_COLOR8 = "00e7e4d9";

BANANA_PRINT_COLOR = "00c0ffc0";
BANANA_PRINT_FORMAT = "|c"..BANANA_PRINT_COLOR.."[|c"..BANANA_SYMBOL_COLOR4.."Banana|c"..BANANA_SYMBOL_COLOR4.."Bar|r|c"..BANANA_PRINT_COLOR.."] %s|r";


BINDING_HEADER_BANANA_PLUGINNAME = "BananaBar Raid Target Symbols";
BINDING_NAME_BANANA_TARGET_SYMBOL1 = "Target Symbol 1 ("..RAID_TARGET_1..")";
BINDING_NAME_BANANA_TARGET_SYMBOL2 = "Target Symbol 2 ("..RAID_TARGET_2..")";
BINDING_NAME_BANANA_TARGET_SYMBOL3 = "Target Symbol 3 ("..RAID_TARGET_3..")";
BINDING_NAME_BANANA_TARGET_SYMBOL4 = "Target Symbol 4 ("..RAID_TARGET_4..")";
BINDING_NAME_BANANA_TARGET_SYMBOL5 = "Target Symbol 5 ("..RAID_TARGET_5..")";
BINDING_NAME_BANANA_TARGET_SYMBOL6 = "Target Symbol 6 ("..RAID_TARGET_6..")";
BINDING_NAME_BANANA_TARGET_SYMBOL7 = "Target Symbol 7 ("..RAID_TARGET_7..")";
BINDING_NAME_BANANA_TARGET_SYMBOL8 = "Target Symbol 8 ("..RAID_TARGET_8..")";
BINDING_NAME_BANANA_TARGET_SYMBOL9 = "Target Symbol 9 (Huntersmark)";

--"Interface\TargetingFrame\UI-RaidTargetingIcons"
local snipershot = "Interface\\Icons\\Ability_Hunter_SniperShot";

BANANA_HIDE_UNUSED_BUTTONS = nil;
BANANA_BUTTON_LAYOUT = nil;
BANANA_BUTTON_SCALE = nil;
BANANA_HIDE_BUTTON_FRAMES = nil;
BANANA_GREY_OUT_DEATH = nil;
BANANA_POS = nil;
BANANA_SHOW_IN_RAID = nil;
BANANA_SHOW_IN_PARTY = nil;
BANANA_SHOW_OUT_OF_GROUP = nil;
BANANA_SHOW_EXTRA_INFO = nil;

SLASH_BANANA1 = "/bananabar";
SLASH_BANANA2 = "/bb"; 

SLASH_BANANABAR1 = "/banana";
SLASH_BANANABAR2 = "/bbr"; 

local BANANA_READY = nil;
	
local raidTargetStatus =
{
	[1] = {["Count"] = 0,["Target"] = nil,["Players"] = {},},
	[2] = {["Count"] = 0,["Target"] = nil,["Players"] = {},},
	[3] = {["Count"] = 0,["Target"] = nil,["Players"] = {},},
	[4] = {["Count"] = 0,["Target"] = nil,["Players"] = {},},
	[5] = {["Count"] = 0,["Target"] = nil,["Players"] = {},},
	[6] = {["Count"] = 0,["Target"] = nil,["Players"] = {},},
	[7] = {["Count"] = 0,["Target"] = nil,["Players"] = {},},
	[8] = {["Count"] = 0,["Target"] = nil,["Players"] = {},},
	[9] = {["Count"] = 0,["Target"] = nil,["Players"] = {},},
}

 

BANANA_ICON = nil;

function Banana_InitArrays()
	if not BANANA_ICON then
		BANANA_ICON = {};
		local i;
		for i = 1, 9, 1 do
			BANANA_ICON[i] = {};
			BANANA_ICON[i].FrameIcon = getglobal("RaidTargetFrame"..i.."ButtonIcon");
			BANANA_ICON[i].FrameButton = getglobal("RaidTargetFrame"..i.."Button");
			BANANA_ICON[i].FrameFlash = getglobal("RaidTargetFrame"..i.."ButtonFlash");
			BANANA_ICON[i].FrameHotKey = getglobal("RaidTargetFrame"..i.."ButtonHotKey");
			BANANA_ICON[i].FrameName = getglobal("RaidTargetFrame"..i.."ButtonName");
			BANANA_ICON[i].FrameCount = getglobal("RaidTargetFrame"..i.."ButtonCount");
			BANANA_ICON[i].FrameNormalTexture = getglobal("RaidTargetFrame"..i.."ButtonNormalTexture");
			BANANA_ICON[i].FrameMobName = getglobal("RaidTargetFrame"..i.."ButtonMobName");
            BANANA_ICON[i].FrameTargetSymbol = getglobal("RaidTargetFrame"..i.."ButtonTargetSymbol");
			BANANA_ICON[i].Count = 0;
			BANANA_ICON[i].Target = nil;
			BANANA_ICON[i].Players = {};
			BANANA_ICON[i].Info = nil;
			BANANA_ICON[i].Debuff = nil;
			BANANA_ICON[i].MovingButton = 1;
			BANANA_ICON[i].IsDeath = nil;
			BANANA_ICON[i].MyTarget = nil;
		end
	end
end

function Banana_UpdateButton(index)
	if BANANA_ICON[index].MyTarget == 1 then
		BANANA_ICON[index].FrameButton:SetChecked(1);
	else
		BANANA_ICON[index].FrameButton:SetChecked(0);
	end
	
	if BANANA_ICON[index].IsDeath == 1 and BANANA_GREY_OUT_DEATH == 1 then
		BANANA_ICON[index].FrameButton:SetAlpha(0.33);
	else
        if BANANA_HIDE_UNUSED_BUTTONS == 1 and (not raidTargetStatus[index].Target) then
            Banana_HideButton(BANANA_ICON[index].FrameButton);
        else
            BANANA_ICON[index].FrameButton:SetAlpha(1);
            BANANA_ICON[index].FrameButton:Show();
        end
	end
	
	if BANANA_HIDE_BUTTON_FRAMES == 1 then
		BANANA_ICON[index].FrameNormalTexture:Hide();
	else
		BANANA_ICON[index].FrameNormalTexture:Show();
	end
	
	if raidTargetStatus[index].Target and BANANA_SHOW_EXTRA_INFO == 1 then
        BANANA_ICON[index].FrameMobName:SetText(raidTargetStatus[index].Target);
		BANANA_ICON[index].FrameMobName:Show();
        if raidTargetStatus[index].TargetSymbol and raidTargetStatus[index].TargetSymbol ~= 0 then        
            Banana_TexCoord(BANANA_ICON[index].FrameTargetSymbol,raidTargetStatus[index].TargetSymbol)    
            BANANA_ICON[index].FrameTargetSymbol:Show();
        else
            BANANA_ICON[index].FrameTargetSymbol:Hide();
        end
	else
		BANANA_ICON[index].FrameMobName:SetText();
		BANANA_ICON[index].FrameMobName:Hide();
        BANANA_ICON[index].FrameTargetSymbol:Hide();
	end
	
end


function Banana_Print(msg)
	if not DEFAULT_CHAT_FRAME then 
		return 
	end

	local strx = string.format(BANANA_PRINT_FORMAT,tostring(msg)); 

	DEFAULT_CHAT_FRAME:AddMessage(strx);
end

function Banana_Debug(msg)
	if not DEFAULT_CHAT_FRAME then 
		return 
	end

	local strx = string.format(BANANA_PRINT_FORMAT,tostring(msg)); 

	DEFAULT_CHAT_FRAME:AddMessage(strx);
end



function Banana_OnLoad()
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	SlashCmdList["BANANA"] = Banana_Command;
	SlashCmdList["BANANABAR"] = Banana_Command;
end

function Banana_OnEvent()
	if ( event == "PLAYER_ENTERING_WORLD" ) then
		
		if not BANANA_READY then
			Banana_InitArrays();
		end
		
		Banana_Print("Banana Raid Symbols loaded. Type /bb, /bbr, /banana or /bananabar to open config panel.");

		if not BANANA_SHOW_EXTRA_INFO then
			Banana_Print("First start of BananaBar detected, showing config window.");
			UIDropDownMenu_Initialize(BananaConfigFrameComboBoxLayout, Banana_ComboBoxLayout_Initialize); 
			Banana_ResetAll()
			BananaConfigFrame:Show();
		else
			if not BANANA_READY then
				Banana_UpdateScale();
				Banana_Layout();
				Banana_ReloadFramePositions();
				UIDropDownMenu_Initialize(BananaConfigFrameComboBoxLayout, Banana_ComboBoxLayout_Initialize); 
                Banana_UpdateDialogFromVariables();
			end
		end
		BANANA_READY = true;
	end
end

local ticker = 0;
local debugticker = 0;

function Banana_OnUpdate(elapsed)
	ticker = ticker + elapsed;
	if ticker > 0.1 then
		ticker = ticker -0.1;
		Banana_OnUpdateTick();
	end
	if ticker > 0.1 then
		ticker = 0;
	end

	debugticker = debugticker + elapsed;
	if debugticker > 1 then
		debugticker = debugticker -1;
		--Banana_OnUpdateDebug();
	end
	if debugticker > 1 then
		debugticker = 0;
	end
end

BANANA_CLEAR_PLAYER_SYMBOL_TRY = 1;

function Banana_OnUpdateTick()
	if BANANA_READY then
		Banana_UpdateStatus();
        Banana_CtRaMainTankUpdate();
	end
    
	if BANANA_CLEAR_PLAYER_SYMBOL then
		if BANANA_CLEAR_PLAYER_SYMBOL > 0 then
			BANANA_CLEAR_PLAYER_SYMBOL = BANANA_CLEAR_PLAYER_SYMBOL - 1;
			if Banana_GetSymbol("PLAYER") then
				Banana_Print("Clearing own symbol again try "..BANANA_CLEAR_PLAYER_SYMBOL_TRY.." (fix for a wow bug)");
				BANANA_CLEAR_PLAYER_SYMBOL_TRY = BANANA_CLEAR_PLAYER_SYMBOL_TRY+1;
				Banana_SetSymbol("PLAYER",0);
			else
				BANANA_CLEAR_PLAYER_SYMBOL_TRY = 1;
			end
			if BANANA_CLEAR_PLAYER_SYMBOL == 0 and Banana_GetSymbol("PLAYER") then
				Banana_Print("Clearing own symbol failed");
				BANANA_CLEAR_PLAYER_SYMBOL_TRY = 1;
			end
		end
	end
	
end
--/script Banana_TexCoord(RaidTargetFrame2ButtonTargetSymbol,5)
function Banana_TexCoord(icon,index)
    if index == 9 then
        icon:SetTexture("Interface\\AddOns\\Banana\\Images\\HuntermarkArrow");            
        icon:SetTexCoord(0, 1, 0, 1);
        return;
    end
    local button = UnitPopupButtons["RAID_TARGET_"..index];
    local x1 = button.tCoordLeft;
	local y1 = button.tCoordTop;
	local x2 = button.tCoordRight;
	local y2 = button.tCoordBottom;
    
    icon:SetTexture("Interface/TargetingFrame/UI-RaidTargetingIcons");            
	icon:SetTexCoord(x1, x2, y1, y2);
end

function Banana_IndexFromButtonName(name)
	return tonumber(string.sub(name,16,-7));
end


function Banana_RaidTargetButtonOnLoad()
	local index = Banana_IndexFromButtonName(this:GetName());
	local icon = getglobal(this:GetName().."Icon");
    Banana_TexCoord(icon,index)
end

function Banana_CanSetSymbols()
    if GetNumRaidMembers() > 0 then
        if IsRaidOfficer() or IsRaidLeader() then
            return 1;
        end
    end
    if GetNumPartyMembers() > 0 then
        if IsPartyLeader() then
            return 1;
        end
    end
    return nil;
end
function Banana_CanUseSymbols()
    if GetNumRaidMembers() > 0 then
        return 1;
    end
    if GetNumPartyMembers() > 0 then
        return 1;
    end
    return nil;
end

function Banana_ButtonOnClick(mousebutton)
	local index = tonumber(string.sub(this:GetName(),16,-7));
	if (IsControlKeyDown()) and mousebutton == "LeftButton" then 
		Banana_SetRaidSymbol(index);
		return;
	end
	if (not IsControlKeyDown()) and mousebutton == "LeftButton" then 
		if Banana_CanUseSymbols() then
			Banana_TargetRaidSymbol(index);
		else
            Banana_PlayError();
			Banana_Print("Raid targets can only be used if you are in raid or party."); 
			Banana_Print("Type /bb, /bbr or /bananabar to open config window and hide unused buttons.");
		end
		return;
	end
	if (IsControlKeyDown()) and mousebutton == "RightButton" then 
		--moving
		return;
	end
	Banana_Print("Use Ctrl+RightMouseButtonc to move buttons");
end
 
local movingbutton = nil;

function Banana_ButtonOnMouseDown(mousebutton)
	if IsControlKeyDown() and mousebutton == "RightButton" then 
		local index = Banana_IndexFromButtonName(this:GetName());
		if not movingbutton then
			if getglobal("RaidTargetFrame"..BANANA_ICON[index].MovingButton.."Button"):IsMovable() then
				Banana_Debug("Start Moving Button "..index);
				movingbutton = index;
				getglobal("RaidTargetFrame"..BANANA_ICON[index].MovingButton.."Button"):StartMoving();
			end
		end
	end
	if (not IsControlKeyDown()) and mousebutton == "RightButton" then 
		Banana_RemoveRaidSymbol(index);
	end
end

function Banana_ButtonOnMouseUp(mousebutton)
	local index = tonumber(string.sub(this:GetName(),16,-7));
	if movingbutton then
		Banana_Debug("Stop Moving Button "..movingbutton);
		getglobal("RaidTargetFrame"..BANANA_ICON[movingbutton].MovingButton.."Button"):StopMovingOrSizing();
		getglobal("RaidTargetFrame"..BANANA_ICON[movingbutton].MovingButton.."Button"):SetUserPlaced(false);
		Banana_SaveFramePos(getglobal("RaidTargetFrame"..BANANA_ICON[movingbutton].MovingButton.."Button"));
		movingbutton = nil;
	end
	
end

function Banana_ButtonOnEnter()
	if ( GetCVar("UberTooltips") == "1" ) then
		GameTooltip_SetDefaultAnchor(GameTooltip, this);
	else
		GameTooltip:SetOwner(button, "ANCHOR_RIGHT");
	end

	local index = tonumber(string.sub(this:GetName(),16,-7));
	if (raidTargetStatus[index].Target) then
		GameTooltip:AddLine(raidTargetStatus[index].Target);
		if raidTargetStatus[index].Count > 0 then
			GameTooltip:AddLine(raidTargetStatus[index].Count.." Players",0.5,0.5,0.5);
			local loop;
			for loop = 1,raidTargetStatus[index].Count,1 do
				GameTooltip:AddLine(raidTargetStatus[index].Players[loop].Name,raidTargetStatus[index].Players[loop].Color.r,raidTargetStatus[index].Players[loop].Color.g,raidTargetStatus[index].Players[loop].Color.b);
			end
		end
		GameTooltip:Show();
	else
		GameTooltip:SetText("Not used\n/bananabar to open config window\nCtrl+RightMouseButton to move buttons");
	end
	
end

function Banana_ButtonOnLeave()
	GameTooltip:Hide();
end

function Banana_SetRaidSymbol(index)
	if not UnitExists("target") then
        Banana_TargetRaidSymbol(index);
        if not UnitExists("target") then
            Banana_Print("Not target selected.");
            Banana_PlayError();
            return;
        end
    end
    
    local oldindex = (Banana_GetSymbol("TARGET") or 0);
	if oldindex == index then
		Banana_SetSymbol("TARGET", 0)
		Banana_PlayRemove1();
	else
		Banana_SetSymbol("TARGET", index)
	end
	Banana_UpdateStatus();
end




function Banana_TargetRaidSymbol(index)
  for i = 1, 40, 1 do
    if Banana_TargetRaidSymbolUnit("raid"..i,index) then
        return;
    end
  end;
  for i = 1, 4, 1 do
    if Banana_TargetRaidSymbolUnit("party"..i,index) then
        return;
    end
  end;
  if Banana_TargetRaidSymbolUnit("player",index) then
      return;
  end
  Banana_PlayError();
  Banana_Print("Nothing to target");
  Banana_UpdateStatus();
end

function Banana_TargetRaidSymbolUnit(unit,index)
	if UnitExists(unit) then
	    if ( Banana_GetSymbol(unit) == index ) then
	      TargetUnit(unit);
		  Banana_UpdateStatus();
	      return 1;
	    end;
	
		if UnitExists(unit.."target") then
		    if ( Banana_GetSymbol(unit.."target") == index ) then
		      TargetUnit(unit.."target");
		      Banana_Print("Target: "..(UnitName(unit.."target") or "<Unknown>"));
		      return 1;
		    end;
		end
	end
    return nil;
end

function Banana_RemoveRaidSymbol(index)
	Banana_UpdateStatus();
end

function Banana_UpdateStatusInit()
	local index;
	for index = 1, 9, 1 do
		raidTargetStatus[index].Count = 0;
    	raidTargetStatus[index].Target = nil;
    	raidTargetStatus[index].TargetSymbol = nil;
    	raidTargetStatus[index].Players = {};
		BANANA_ICON[index].Debuff = nil;
		BANANA_ICON[index].IsDeath = nil;
		BANANA_ICON[index].MyTarget = nil;
  	end
end




function Banana_DebuffCheckAll(target) 
	local result;

	result = Banana_DebuffCheck(target, "Interface\\Icons\\Spell_Shadow_GatherShadows");
	if result ~= "" then
		return result;
	end
	
	return "";
end

function Banana_DebuffCheck(sUnitname, sBuffname) 
	local iIterator = 1
	while (true) do
		local debuffTexture, debuffApplications, debuffDispelType = UnitDebuff(sUnitname, iIterator);
		if not debuffTexture then
			return "";
		end
		--Banana_Print("t;"..debuffTexture);
		--Banana_Print("u;"..sBuffname);
		if debuffTexture == sBuffname then
			return sBuffname;
		end
		iIterator = iIterator + 1
	end
end


function Banana_HideButton(frame)
    if BananaConfigFrame:IsVisible() then
        frame:Show();
        frame:SetAlpha(0.16);
    else
        frame:Hide();
        frame:SetAlpha(1);
    end
    
end

function Banana_UpdateStatus()
	local index;

	if GetNumRaidMembers() > 0 then
        if BANANA_SHOW_IN_RAID == 1 then
            Banana_UpdateStatusInit();
            Banana_UpdateStatusPlayerLoop("RAID",40);
            Banana_UpdateStatusUpdate();
        else
            for index = 1, 9, 1 do
                local button = getglobal("RaidTargetFrame"..index.."Button");
                Banana_HideButton(button)
            end
        end
	elseif GetNumPartyMembers() > 0 then
        if BANANA_SHOW_IN_PARTY == 1 then
            Banana_UpdateStatusInit();
            Banana_UpdateStatusPlayerLoop("PARTY",5);
            Banana_UpdateStatusUpdate();
        else
            for index = 1, 9, 1 do
                local button = getglobal("RaidTargetFrame"..index.."Button");
                Banana_HideButton(button)
            end
        end
	else
        if BANANA_SHOW_OUT_OF_GROUP == 1 then
            Banana_UpdateStatusInit();
            Banana_UpdateStatusPlayerLoop("PARTY",5);
            Banana_UpdateStatusUpdate();
        else
            for index = 1, 9, 1 do
                local button = getglobal("RaidTargetFrame"..index.."Button");
                Banana_HideButton(button)
            end
        end
--        Banana_UpdateStatusInit();
--        Banana_UpdateStatusPlayerLoop("PARTY",5);
--        Banana_UpdateStatusUpdate();
--		for index = 1, 9, 1 do
--			local button = getglobal("RaidTargetFrame"..index.."Button");
--			Banana_UpdateButton(index);
--			if BANANA_SHOW_OUT_OF_GROUP == 1 then
--				button:Show();
--			else
--				Banana_HideButton(button);
--			end
--	  	end
	end	
end

function Banana_UpdateStatusPlayerLoop(prefix,count)

  	for i = 1, count, 1 do
        local loopmember = prefix..i;
        if loopmember == "PARTY5" or loopmember == "party5" then
            loopmember = "PLAYER";
        end
        if UnitExists(loopmember) then
			local loopmembersymbol = (Banana_GetSymbol(loopmember) or 0);
            if loopmembersymbol ~= 0 then
                Banana_UpdateTargetSymbol(loopmember,loopmembersymbol);
		    	raidTargetStatus[loopmembersymbol].Target = UnitName(loopmember);
				
                -- loopmember has aggro?
                if UnitIsUnit(loopmember,loopmember.."TARGETTARGET") then
					raidTargetStatus[loopmembersymbol].Aggro = true;
				end
				Banana_UpdateStatusScanTarget(loopmember,i,loopmembersymbol);
            end

            local loopmembertarget = loopmember.."TARGET";
     
            if UnitExists(loopmembertarget) then
                local symbol = (Banana_GetSymbol(loopmembertarget) or 0);
                if symbol ~= 0 then
                    Banana_UpdateTargetSymbol(loopmembertarget,symbol);
                    raidTargetStatus[symbol].Target = UnitName(loopmembertarget);
                    
                    raidTargetStatus[symbol].Count = raidTargetStatus[symbol].Count + 1;
                    raidTargetStatus[symbol].Players[raidTargetStatus[symbol].Count] = {};
                    raidTargetStatus[symbol].Players[raidTargetStatus[symbol].Count].Name = UnitName(loopmember);
                    local _, englishClass = UnitClass(loopmember);
                    raidTargetStatus[symbol].Players[raidTargetStatus[symbol].Count].Color = RAID_CLASS_COLORS[englishClass];
                    
                    Banana_UpdateStatusScanTarget(loopmembertarget,i,symbol)
                end
            end
        end
    end
    
end

function Banana_UpdateTargetSymbol(unit,symbol)
    local target = unit.."TARGET";
    if not raidTargetStatus[symbol].TargetSymbol  then
        if not UnitExists(target) then
            raidTargetStatus[symbol].TargetSymbol = 0;
        else
            local tts = Banana_GetSymbol(target) or 0;
            raidTargetStatus[symbol].TargetSymbol = tts;
        end
    end
end
function Banana_UpdateStatusScanTarget(targettype,i,index)
	if not BANANA_ICON[index].Debuff then
		BANANA_ICON[index].Debuff = Banana_DebuffCheckAll(targettype);
	end

	if not BANANA_ICON[index].IsDeath then
		if UnitIsDead(targettype) then
			BANANA_ICON[index].IsDeath = 1;
		else
			BANANA_ICON[index].IsDeath = 0;
		end
	end
	
	if not BANANA_ICON[index].MyTarget then
		if UnitIsUnit(targettype,"TARGET") then
			BANANA_ICON[index].MyTarget = 1;
		else
			BANANA_ICON[index].MyTarget = 0;
		end
	end
end

function Banana_UpdateStatusUpdate()
	for index = 1, 9, 1 do
		local button = getglobal("RaidTargetFrame"..index.."Button");
		local flash = getglobal("RaidTargetFrame"..index.."ButtonFlash");
		local count = getglobal("RaidTargetFrame"..index.."ButtonCount");
		
		if ( raidTargetStatus[index].Target) then
			count:SetText(tostring(raidTargetStatus[index].Count));
			count:Show();
			button:Show();
			
			if BANANA_ICON[index].Debuff ~= "" then
				flash:ClearAllPoints();
				flash:SetPoint("TOPLEFT",button,"TOPLEFT")
				flash:SetWidth(18);
				flash:SetHeight(18);
				flash:SetTexture(BANANA_ICON[index].Debuff);
				flash:Show();
			else
				flash:Hide();
			end
			
		else
			flash:Hide();
			count:Hide();
		end
		Banana_UpdateButton(index);
  	end
end


function Banana_ComboBoxLayout_Initialize()
	local info; 

	info = {}; 
	info.text = BANANA_LAYOUT1;
	info.func = Banana_ComboBoxLayout_OnClick; 
	info.value = 1; 
	UIDropDownMenu_AddButton(info); 

	info = {}; 
	info.text = BANANA_LAYOUT2;
	info.func = Banana_ComboBoxLayout_OnClick; 
	info.value = 2; 
	UIDropDownMenu_AddButton(info); 

	info = {}; 
	info.text = BANANA_LAYOUT3;
	info.func = Banana_ComboBoxLayout_OnClick; 
	info.value = 3; 
	UIDropDownMenu_AddButton(info); 

	info = {}; 
	info.text = BANANA_LAYOUT4;
	info.func = Banana_ComboBoxLayout_OnClick; 
	info.value = 4; 
	UIDropDownMenu_AddButton(info); 

	info = {}; 
	info.text = BANANA_LAYOUT5;
	info.func = Banana_ComboBoxLayout_OnClick; 
	info.value = 5; 
	UIDropDownMenu_AddButton(info); 
end

function Banana_ComboBoxLayout_OnClick()
	if not BANANA_READY then
		return;
	end
	UIDropDownMenu_SetSelectedID(BananaConfigFrameComboBoxLayout, this:GetID()); 
	if BANANA_BUTTON_LAYOUT ~= this:GetID() then
		BANANA_BUTTON_LAYOUT = this:GetID()
		Banana_Layout();
	end
end

function BananaConfig_ValueChangedResize()
	if BANANA_READY then
		BANANA_BUTTON_SCALE = this:GetValue();
		Banana_UpdateScale();
	end
end


function Banana_UpdateScale()
    Banana_Print("scale:"..(BANANA_BUTTON_SCALE or "?"));
	Banana_UpdateFrameScale(RaidTargetFrame1Button,BANANA_BUTTON_SCALE / 100)		
	Banana_UpdateFrameScale(RaidTargetFrame2Button,BANANA_BUTTON_SCALE / 100)		
	Banana_UpdateFrameScale(RaidTargetFrame3Button,BANANA_BUTTON_SCALE / 100)		
	Banana_UpdateFrameScale(RaidTargetFrame4Button,BANANA_BUTTON_SCALE / 100)		
	Banana_UpdateFrameScale(RaidTargetFrame5Button,BANANA_BUTTON_SCALE / 100)		
	Banana_UpdateFrameScale(RaidTargetFrame6Button,BANANA_BUTTON_SCALE / 100)		
	Banana_UpdateFrameScale(RaidTargetFrame7Button,BANANA_BUTTON_SCALE / 100)		
	Banana_UpdateFrameScale(RaidTargetFrame8Button,BANANA_BUTTON_SCALE / 100)		
	Banana_UpdateFrameScale(RaidTargetFrame9Button,BANANA_BUTTON_SCALE / 100)		
end

function Banana_UpdateFrameScale(frame,scale)
	if frame:IsMovable() then
		frame:ClearAllPoints();
		Banana_SaveFramePos(frame);
		frame:SetScale(scale);
		Banana_LoadFramePos(frame);	
	else
		frame:SetScale(scale);
	end
	
end



function BananaConfig_ValueChangedShowInRaid()
	if BANANA_READY then
		if this:GetChecked() then
			BANANA_SHOW_IN_RAID = 1;
		else
			BANANA_SHOW_IN_RAID = 0;
		end
		Banana_UpdateStatus();
	end
end
function BananaConfig_ValueChangedShowInParty()
	if BANANA_READY then
		if this:GetChecked() then
			BANANA_SHOW_IN_PARTY = 1;
		else
			BANANA_SHOW_IN_PARTY = 0;
		end
		Banana_UpdateStatus();
	end
end
function BananaConfig_ValueChangedShowOutOfGroup()
	if BANANA_READY then
		if this:GetChecked() then
			BANANA_SHOW_OUT_OF_GROUP = 1;
		else
			BANANA_SHOW_OUT_OF_GROUP = 0;
		end
		Banana_UpdateStatus();
	end
end

function BananaConfig_ValueChangedHideButtonFrames()
	if BANANA_READY then
		if this:GetChecked() then
			BANANA_HIDE_BUTTON_FRAMES = 1;
		else
			BANANA_HIDE_BUTTON_FRAMES = 0;
		end
		Banana_UpdateStatus();
	end
end

function BananaConfig_ValueChangedGreyOutDeath()
	if BANANA_READY then
		if this:GetChecked() then
			BANANA_GREY_OUT_DEATH = 1;
		else
			BANANA_GREY_OUT_DEATH = 0;
		end
        Banana_Print("BANANA_GREY_OUT_DEATH="..BANANA_GREY_OUT_DEATH);
		Banana_UpdateStatus();
	end
end

function BananaConfig_ValueChangedShowExtraInfo()
	if BANANA_READY then
		if this:GetChecked() then
			BANANA_SHOW_EXTRA_INFO = 1;
		else
			BANANA_SHOW_EXTRA_INFO = 0;
		end
		Banana_UpdateStatus();
	end
end


function BananaConfig_ValueChangedHideUnused()
	if BANANA_READY then
		if this:GetChecked() then
			BANANA_HIDE_UNUSED_BUTTONS = 1;
		else
			BANANA_HIDE_UNUSED_BUTTONS = 0;
		end
		Banana_UpdateStatus();
	end
end

function Banana_Command(command)
	if BananaConfigFrame:IsVisible() then
		BananaConfigFrame:Hide();
	else
		BananaConfigFrame:Show();
	end
	
end


function BananaConfig_Close(command)
	BananaConfigFrame:Hide();
end

function Banana_ResetAll()
	Banana_Print("Loading defaults.");
    BANANA_SHOW_IN_RAID = 1;
    BANANA_SHOW_IN_PARTY = 1;
    BANANA_SHOW_OUT_OF_GROUP = 0;
	BANANA_HIDE_UNUSED_BUTTONS = 0;
	BANANA_BUTTON_LAYOUT = 3;
	BANANA_BUTTON_SCALE = 100;
	BANANA_HIDE_BUTTON_FRAMES = 1;
	BANANA_GREY_OUT_DEATH = 0;
    BANANA_SHOW_EXTRA_INFO = 1;
    
	Banana_UpdateDialogFromVariables();
	
    Banana_UpdateScale();
	RaidTargetFrame1Button:ClearAllPoints();
	RaidTargetFrame2Button:ClearAllPoints();
	RaidTargetFrame3Button:ClearAllPoints();
	RaidTargetFrame4Button:ClearAllPoints();
	RaidTargetFrame5Button:ClearAllPoints();
	RaidTargetFrame6Button:ClearAllPoints();
	RaidTargetFrame7Button:ClearAllPoints();
	RaidTargetFrame8Button:ClearAllPoints();
	RaidTargetFrame9Button:ClearAllPoints();
	Banana_Layout();

	local starty = -GetScreenHeight()/5;
	local startx = GetScreenWidth()/5;
	local ofsx = -70;
	local ofsy = 70;

	BANANA_POS = {
		["RaidTargetFrame1Button"] = {
			["x"] = startx-(0*ofsx),
			["y"] = starty-(0*ofsy),
		},
		["RaidTargetFrame2Button"] = {
			["x"] = startx-(0*ofsx),
			["y"] = starty-(1*ofsy),
		},
		["RaidTargetFrame3Button"] = {
			["x"] = startx-(0*ofsx),
			["y"] = starty-(2*ofsy),
		},
		["RaidTargetFrame4Button"] = {
			["x"] = startx-(0*ofsx),
			["y"] = starty-(3*ofsy),
		},
		["RaidTargetFrame5Button"] = {
			["x"] = startx-(1*ofsx),
			["y"] = starty-(0*ofsy),
		},
		["RaidTargetFrame6Button"] = {
			["x"] = startx-(1*ofsx),
			["y"] = starty-(1*ofsy),
		},
		["RaidTargetFrame7Button"] = {
			["x"] = startx-(1*ofsx),
			["y"] = starty-(2*ofsy),
		},
		["RaidTargetFrame8Button"] = {
			["x"] = startx-(1*ofsx),
			["y"] = starty-(3*ofsy),
		},
		["RaidTargetFrame9Button"] = {
			["x"] = startx-(0.5*ofsx),
			["y"] = starty-(4*ofsy),
		},
	};
	Banana_ReloadFramePositions();
end


function Banana_TargetSymbol1()
	Banana_TargetRaidSymbol(1);
end

function Banana_TargetSymbol2()
	Banana_TargetRaidSymbol(2);
end

function Banana_TargetSymbol3()
	Banana_TargetRaidSymbol(3);
end

function Banana_TargetSymbol4()
	Banana_TargetRaidSymbol(4);
end

function Banana_TargetSymbol5()
	Banana_TargetRaidSymbol(5);
end

function Banana_TargetSymbol6()
	Banana_TargetRaidSymbol(6);
end

function Banana_TargetSymbol7()
	Banana_TargetRaidSymbol(7);
end

function Banana_TargetSymbol8()
	Banana_TargetRaidSymbol(8);
end

function Banana_TargetSymbol9()
	Banana_TargetRaidSymbol(9);
end

function Banana_ShowDebugInfo()
   Banana_Print("BANANA_HIDE_UNUSED_BUTTONS "..(BANANA_HIDE_UNUSED_BUTTONS or "<nil>"));
   Banana_Print("BANANA_BUTTON_LAYOUT "..(BANANA_BUTTON_LAYOUT or "<nil>"));
   Banana_Print("BANANA_BUTTON_SCALE "..(BANANA_BUTTON_SCALE or "<nil>"));
   Banana_Print("BANANA_HIDE_BUTTON_FRAMES "..(BANANA_HIDE_BUTTON_FRAMES or "<nil>"));
   Banana_Print("BANANA_GREY_OUT_DEATH "..(BANANA_GREY_OUT_DEATH or "<nil>"));
   Banana_Print("BANANA_SHOW_IN_RAID "..(BANANA_SHOW_IN_RAID or "<nil>"));
   Banana_Print("BANANA_SHOW_IN_PARTY "..(BANANA_SHOW_IN_PARTY or "<nil>"));
   Banana_Print("BANANA_SHOW_OUT_OF_GROUP "..(BANANA_SHOW_OUT_OF_GROUP or "<nil>"));
   Banana_Print("BANANA_SHOW_EXTRA_INFO "..(BANANA_SHOW_EXTRA_INFO or "<nil>"));
    
--    BananaMtSymbolTemplate    
--    CreateFrame("frameType"[ ,"name"][, parent][, "inheritFrame"])   -

    Banana_Print((UnitDebuff("TARGET", 0,0) or "nix"));
    Banana_Print((UnitDebuff("TARGET", 1,0) or "nix"));
    Banana_Print((UnitDebuff("TARGET", 2,0) or "nix"));
    Banana_Print((UnitDebuff("TARGET", 3,0) or "nix"));
    Banana_Print((UnitDebuff("TARGET", 4,0) or "nix"));

    local spell = nil;
    local searchid = 1;
    local tex;
    repeat
        tex = GetSpellTexture(searchid, BOOKTYPE_SPELL); 

        
        Banana_Print(searchid.." "..(tex or "niiil"));
    
        if tex == snipershot then
            Banana_Print("ss");
            spell,_ = GetSpellName( searchid, BOOKTYPE_SPELL );
        end
        
        searchid = searchid +1;
        
    until spell ~= nil or tex == nil;
    Banana_Print(tex or "texnil");
    Banana_Print(spell or "spellnil");
end

function Banana_SpellHuntersmark()
    local spell = Banana_FindSpellNameByTexture(snipershot);
    if spell == nil then
        Banana_Print("Huntersmark Spell not found");
        Banana_PlayError();
        return;
    end
    CastSpellByName(spell);
end

function Banana_FindSpellNameByTexture(searchtex)
    local spell = nil;
    local searchid = 1;
    local tex;
    repeat
        tex = GetSpellTexture(searchid, BOOKTYPE_SPELL); 

        if tex == searchtex then
            spell,_ = GetSpellName( searchid, BOOKTYPE_SPELL );
        end
        
        searchid = searchid +1;
        
    until spell ~= nil or tex == nil;
    return spell;
end

function Banana_CtRaMainTankUpdate()
    Banana_CtRaMainTankUpdateByIndex(1);
    Banana_CtRaMainTankUpdateByIndex(2);
    Banana_CtRaMainTankUpdateByIndex(3);
    Banana_CtRaMainTankUpdateByIndex(4);
    Banana_CtRaMainTankUpdateByIndex(5);
    Banana_CtRaMainTankUpdateByIndex(6);
    Banana_CtRaMainTankUpdateByIndex(7);
    Banana_CtRaMainTankUpdateByIndex(8);
    Banana_CtRaMainTankUpdateByIndex(9);
    Banana_CtRaMainTankUpdateByIndex(10);
end

function Banana_CtRaMainTankUpdateByIndex(mtindex)
    ctraframe = "CT_RAMTGroupMember"..mtindex.."CastFrame";
    if getglobal(ctraframe) == nil then
        --Banana_Print(ctraframe.." not found");
        return;
    end

    frameName = "BananaMt"..mtindex;
    texName = "BananaMt"..mtindex.."Symbol";

    local f;
    if getglobal(frameName) == nil then
        Banana_Print("Creating symbol frame for MainTank "..mtindex);
        f = CreateFrame("Frame",frameName,getglobal(ctraframe),"BananaMtSymbolTemplate");
        f:SetFrameStrata("BACKGROUND")
        f:SetPoint("RIGHT", ctraframe, "LEFT", 0, 0);
        f:Hide();
    else
        f = getglobal(frameName);
    end

    local tex = getglobal(texName);

    if CT_RATarget then
        if CT_RATarget.MainTanks then
            if CT_RATarget.MainTanks[mtindex] then
                if CT_RATarget.MainTanks[mtindex][1] then
                    if UnitExists("RAID"..CT_RATarget.MainTanks[mtindex][1].."TARGET") then
                        local idx = (Banana_GetSymbol("RAID"..CT_RATarget.MainTanks[mtindex][1].."TARGET") or 0);
                        if idx ~= 0 then
                            Banana_TexCoord(tex,idx);
                            f:Show()    
                            return;
                        end
                    end;
                end
            end
        end
    end
    f:Hide()    
end

function Banana_ClearRaidSymbols()
	Banana_Print("Clearing all raid symbols");
    Banana_PlayRemoveAll();
    Banana_SetSymbol("PLAYER",1);
   	Banana_SetSymbol("PLAYER",2);
   	Banana_SetSymbol("PLAYER",3);
   	Banana_SetSymbol("PLAYER",4);
   	Banana_SetSymbol("PLAYER",5);
   	Banana_SetSymbol("PLAYER",6);
   	Banana_SetSymbol("PLAYER",7);
   	Banana_SetSymbol("PLAYER",8);
	Banana_SetSymbol("PLAYER",0);
	BANANA_CLEAR_PLAYER_SYMBOL = 10;
end

function Banana_SaveFramePos(frame)
	if frame then
		if frame:GetLeft() and frame:GetBottom() then
			local framePos = {}
			framePos.x = frame:GetLeft()*frame:GetScale()
			framePos.y = frame:GetTop()*frame:GetScale() -GetScreenHeight()
			--Banana_Print("Top:"..frame:GetTop().." Scale:"..frame:GetScale().." "..frame:GetEffectiveScale().." Scr:"..GetScreenHeight().." Pos:"..framePos.y.." uip:"..UIParent:GetTop().." "..UIParent:GetBottom().." "..UIParent:GetScale())
			if not BANANA_POS then
				BANANA_POS = {};
			end
			BANANA_POS[frame:GetName()] = framePos;
			--Banana_Print("Saving position for "..frame:GetName());
		end
	end
end
function Banana_LoadFramePos(frame)
	if frame then
		if frame:IsMovable() then
			if BANANA_POS then
				framePos = BANANA_POS[frame:GetName()];
				if framePos then
					frame:SetPoint("TOPLEFT",UIParent,"TOPLEFT",framePos.x/frame:GetScale(),framePos.y/frame:GetScale())
					--Banana_Print("Restoring saved position for "..frame:GetName());
				else
					--Banana_Print("No saved position for "..frame:GetName());
				end
			else
				--Banana_Print("No saved position for "..frame:GetName().." or any other frame");
			end
		else
			--Banana_Print("Dont load saved position for "..frame:GetName()..", no movable frame");
		end
	end
end

function Banana_ReloadFramePositions()
	Banana_LoadFramePos(RaidTargetFrame1Button);
	Banana_LoadFramePos(RaidTargetFrame2Button);
	Banana_LoadFramePos(RaidTargetFrame3Button);
	Banana_LoadFramePos(RaidTargetFrame4Button);
	Banana_LoadFramePos(RaidTargetFrame5Button);
	Banana_LoadFramePos(RaidTargetFrame6Button);
	Banana_LoadFramePos(RaidTargetFrame7Button);
	Banana_LoadFramePos(RaidTargetFrame8Button);
	Banana_LoadFramePos(RaidTargetFrame9Button);
end


function Banana_HeaderMouseDown()
	if not movingconfig then
		--Banana_Print("Start Moving Config Window");
		movingconfig = true;
		BananaConfigFrame:StartMoving();
	end
end

function Banana_HeaderMouseUp()
	if movingconfig then
		--Banana_Print("Stop Moving Config Window");
		movingconfig = nil;
		BananaConfigFrame:StopMovingOrSizing();
	end
end

function Banana_UpdateDialogFromVariables()
    UIDropDownMenu_SetSelectedID(BananaConfigFrameComboBoxLayout, BANANA_BUTTON_LAYOUT); 
	
    BananaConfigFrameCheckButtonShowInRaid:SetChecked(BANANA_SHOW_IN_RAID == 1);
    BananaConfigFrameCheckButtonShowInParty:SetChecked(BANANA_SHOW_IN_PARTY == 1);
    BananaConfigFrameCheckButtonShowOutOfGroup:SetChecked(BANANA_SHOW_OUT_OF_GROUP == 1);
	
    BananaConfigFrameCheckButtonHideUnused:SetChecked(BANANA_HIDE_UNUSED_BUTTONS == 1);
	BananaConfigFrameCheckButtonHideButtonFrames:SetChecked(BANANA_HIDE_BUTTON_FRAMES == 1);
	BananaConfigFrameCheckButtonGreyOutDeath:SetChecked(BANANA_GREY_OUT_DEATH == 1);
    BananaConfigFrameCheckButtonShowExtraInfo:SetChecked(BANANA_SHOW_EXTRA_INFO == 1);
    
	BananaConfigFrameResizeSlider:SetValue(BANANA_BUTTON_SCALE);
end

function Banana_PlayError()
    PlaySoundFile("Interface\\AddOns\\Banana\\Sound\\BananaNo.mp3");
end
function Banana_PlayRemove1()
    PlaySoundFile("Interface\\AddOns\\Banana\\Sound\\BananaPlop1.mp3");
end
function Banana_PlayRemoveAll()
    PlaySoundFile("Interface\\AddOns\\Banana\\Sound\\BananaPlop8.mp3");
end

function Banana_PlaySetSymbol()
    PlaySoundFile("Interface\\AddOns\\Banana\\Sound\\BananaSetSymbol.mp3");
end

function Banana_GetSymbol(unit)
    local result = GetRaidTargetIndex(unit);
    if (not result) or (result==0) then 
        if UnitDebuff(unit,1) == snipershot then
            result = 9;
        elseif UnitDebuff(unit,2) == snipershot then
            result = 9;
        elseif UnitDebuff(unit,3) == snipershot then
            result = 9;
        elseif UnitDebuff(unit,4) == snipershot then
            result = 9;
        elseif UnitDebuff(unit,5) == snipershot then
            result = 9;
        elseif UnitDebuff(unit,6) == snipershot then
            result = 9;
        elseif UnitDebuff(unit,7) == snipershot then
            result = 9;
        elseif UnitDebuff(unit,8) == snipershot then
            result = 9;
        elseif UnitDebuff(unit,9) == snipershot then
            result = 9;
        elseif UnitDebuff(unit,10) == snipershot then
            result = 9;
        elseif UnitDebuff(unit,11) == snipershot then
            result = 9;
        elseif UnitDebuff(unit,12) == snipershot then
            result = 9;
        elseif UnitDebuff(unit,13) == snipershot then
            result = 9;
        elseif UnitDebuff(unit,14) == snipershot then
            result = 9;
        elseif UnitDebuff(unit,15) == snipershot then
            result = 9;
        elseif UnitDebuff(unit,16) == snipershot then
            result = 9;
        end
    end;
    return result;
end

function Banana_SetSymbol(unit,index)
    if index == 0 then
        if Banana_CanSetSymbols() then
            SetRaidTarget(unit,index);
		end
        return;
    elseif index <= 8 then
        if Banana_CanSetSymbols() then
            SetRaidTarget(unit,index);
            Banana_PlaySetSymbol();
		else
            Banana_PlayError();
			Banana_Print("Raid targets can only be used if you are in raid or party."); 
			Banana_Print("Type /bb, /bbr or /bananabar to open config window and hide unused buttons.");
		end
        return;
    elseif index == 9 then
        Banana_SpellHuntersmark();
        Banana_PlaySetSymbol();

    end
end

Banana_BABA = 0;

function Banana_OnUpdateDebug(unit)
if Banana_BABA == 0 then
	Banana_OnUpdateDebug2("target")
	Banana_OnUpdateDebug2("player")
	Banana_OnUpdateDebug2("raid1")
	Banana_OnUpdateDebug2("raid2")
	Banana_OnUpdateDebug2("raid3")
	Banana_OnUpdateDebug2("raid4")
	Banana_OnUpdateDebug2("raid5")
	Banana_OnUpdateDebug2("raid6")
	Banana_OnUpdateDebug2("raid7")
end
if Banana_BABA == 1 then
	Banana_OnUpdateDebug2("raid8")
	Banana_OnUpdateDebug2("raid9")
	Banana_OnUpdateDebug2("raid10")
	Banana_OnUpdateDebug2("raid11")
	Banana_OnUpdateDebug2("raid12")
	Banana_OnUpdateDebug2("raid13")
	Banana_OnUpdateDebug2("raid14")
	Banana_OnUpdateDebug2("raid15")
end
if Banana_BABA == 2 then
	Banana_OnUpdateDebug2("raid16")
	Banana_OnUpdateDebug2("raid17")
	Banana_OnUpdateDebug2("raid18")
	Banana_OnUpdateDebug2("raid19")
	Banana_OnUpdateDebug2("raid20")
	Banana_OnUpdateDebug2("raid21")
	Banana_OnUpdateDebug2("raid22")
	Banana_OnUpdateDebug2("raid23")
	Banana_OnUpdateDebug2("raid24")
	Banana_OnUpdateDebug2("raid25")
end
if Banana_BABA == 3 then
	Banana_OnUpdateDebug2("raid26")
	Banana_OnUpdateDebug2("raid27")
	Banana_OnUpdateDebug2("raid28")
	Banana_OnUpdateDebug2("raid29")
	Banana_OnUpdateDebug2("raid30")
	Banana_OnUpdateDebug2("raid31")
	Banana_OnUpdateDebug2("raid32")
	Banana_OnUpdateDebug2("raid33")
	Banana_OnUpdateDebug2("raid34")
	Banana_OnUpdateDebug2("raid35")
	Banana_OnUpdateDebug2("raid36")
	Banana_OnUpdateDebug2("raid37")
end
if Banana_BABA == 4 then
	Banana_OnUpdateDebug2("raid38")
	Banana_OnUpdateDebug2("raid39")
	Banana_OnUpdateDebug2("raid40")
	Banana_OnUpdateDebug2("raid1target")
	Banana_OnUpdateDebug2("raid2target")
	Banana_OnUpdateDebug2("raid3target")
	Banana_OnUpdateDebug2("raid4target")
	Banana_OnUpdateDebug2("raid5target")
	Banana_OnUpdateDebug2("raid6target")
	Banana_OnUpdateDebug2("raid7target")
	Banana_OnUpdateDebug2("raid8target")
	Banana_OnUpdateDebug2("raid9target")
	Banana_OnUpdateDebug2("raid10target")
	Banana_OnUpdateDebug2("raid11target")
end
if Banana_BABA == 5 then
	Banana_OnUpdateDebug2("raid12target")
	Banana_OnUpdateDebug2("raid13target")
	Banana_OnUpdateDebug2("raid14target")
	Banana_OnUpdateDebug2("raid15target")
	Banana_OnUpdateDebug2("raid16target")
	Banana_OnUpdateDebug2("raid17target")
	Banana_OnUpdateDebug2("raid18target")
	Banana_OnUpdateDebug2("raid19target")
	Banana_OnUpdateDebug2("raid20target")
	Banana_OnUpdateDebug2("raid21target")
	Banana_OnUpdateDebug2("raid22target")
	Banana_OnUpdateDebug2("raid23target")
	Banana_OnUpdateDebug2("raid24target")
	Banana_OnUpdateDebug2("raid25target")
	Banana_OnUpdateDebug2("raid26target")
	Banana_OnUpdateDebug2("raid27target")
end
if Banana_BABA == 6 then
	Banana_OnUpdateDebug2("raid28target")
	Banana_OnUpdateDebug2("raid29target")
	Banana_OnUpdateDebug2("raid30target")
	Banana_OnUpdateDebug2("raid31target")
	Banana_OnUpdateDebug2("raid32target")
	Banana_OnUpdateDebug2("raid33target")
	Banana_OnUpdateDebug2("raid34target")
	Banana_OnUpdateDebug2("raid35target")
	Banana_OnUpdateDebug2("raid36target")
	Banana_OnUpdateDebug2("raid37target")
	Banana_OnUpdateDebug2("raid38target")
	Banana_OnUpdateDebug2("raid39target")
	Banana_OnUpdateDebug2("raid40target")
	Banana_OnUpdateDebug3("target")
	Banana_OnUpdateDebug3("player")
end
if Banana_BABA == 7 then
	Banana_OnUpdateDebug3("raid1")
	Banana_OnUpdateDebug3("raid2")
	Banana_OnUpdateDebug3("raid3")
	Banana_OnUpdateDebug3("raid4")
	Banana_OnUpdateDebug3("raid5")
	Banana_OnUpdateDebug3("raid6")
	Banana_OnUpdateDebug3("raid7")
	Banana_OnUpdateDebug3("raid8")
	Banana_OnUpdateDebug3("raid9")
	Banana_OnUpdateDebug3("raid10")
	Banana_OnUpdateDebug3("raid11")
	Banana_OnUpdateDebug3("raid12")
	Banana_OnUpdateDebug3("raid13")
	Banana_OnUpdateDebug3("raid14")
	Banana_OnUpdateDebug3("raid15")
	Banana_OnUpdateDebug3("raid16")
end
if Banana_BABA == 8 then
	Banana_OnUpdateDebug3("raid17")
	Banana_OnUpdateDebug3("raid18")
	Banana_OnUpdateDebug3("raid19")
	Banana_OnUpdateDebug3("raid20")
	Banana_OnUpdateDebug3("raid21")
	Banana_OnUpdateDebug3("raid22")
	Banana_OnUpdateDebug3("raid23")
	Banana_OnUpdateDebug3("raid24")
	Banana_OnUpdateDebug3("raid25")
	Banana_OnUpdateDebug3("raid26")
	Banana_OnUpdateDebug3("raid27")
	Banana_OnUpdateDebug3("raid28")
	Banana_OnUpdateDebug3("raid29")
	Banana_OnUpdateDebug3("raid30")
end
if Banana_BABA == 9 then
	Banana_OnUpdateDebug3("raid31")
	Banana_OnUpdateDebug3("raid32")
	Banana_OnUpdateDebug3("raid33")
	Banana_OnUpdateDebug3("raid34")
	Banana_OnUpdateDebug3("raid35")
	Banana_OnUpdateDebug3("raid36")
	Banana_OnUpdateDebug3("raid37")
	Banana_OnUpdateDebug3("raid38")
	Banana_OnUpdateDebug3("raid39")
	Banana_OnUpdateDebug3("raid40")
	Banana_OnUpdateDebug3("raid1target")
	Banana_OnUpdateDebug3("raid2target")
	Banana_OnUpdateDebug3("raid3target")
	Banana_OnUpdateDebug3("raid4target")
end
if Banana_BABA == 10 then
	Banana_OnUpdateDebug3("raid5target")
	Banana_OnUpdateDebug3("raid6target")
	Banana_OnUpdateDebug3("raid7target")
	Banana_OnUpdateDebug3("raid8target")
	Banana_OnUpdateDebug3("raid9target")
	Banana_OnUpdateDebug3("raid10target")
	Banana_OnUpdateDebug3("raid11target")
	Banana_OnUpdateDebug3("raid12target")
	Banana_OnUpdateDebug3("raid13target")
	Banana_OnUpdateDebug3("raid14target")
	Banana_OnUpdateDebug3("raid15target")
	Banana_OnUpdateDebug3("raid16target")
	Banana_OnUpdateDebug3("raid17target")
	Banana_OnUpdateDebug3("raid18target")
	Banana_OnUpdateDebug3("raid19target")
	Banana_OnUpdateDebug3("raid20target")
end
if Banana_BABA == 11 then
	Banana_OnUpdateDebug3("raid21target")
	Banana_OnUpdateDebug3("raid22target")
	Banana_OnUpdateDebug3("raid23target")
	Banana_OnUpdateDebug3("raid24target")
	Banana_OnUpdateDebug3("raid25target")
	Banana_OnUpdateDebug3("raid26target")
	Banana_OnUpdateDebug3("raid27target")
	Banana_OnUpdateDebug3("raid28target")
	Banana_OnUpdateDebug3("raid29target")
	Banana_OnUpdateDebug3("raid30target")
	Banana_OnUpdateDebug3("raid31target")
	Banana_OnUpdateDebug3("raid32target")
	Banana_OnUpdateDebug3("raid33target")
	Banana_OnUpdateDebug3("raid34target")
	Banana_OnUpdateDebug3("raid35target")
	Banana_OnUpdateDebug3("raid36target")
	Banana_OnUpdateDebug3("raid37target")
	Banana_OnUpdateDebug3("raid38target")
	Banana_OnUpdateDebug3("raid39target")
	Banana_OnUpdateDebug3("raid40target")
	Banana_BABA = 0;
else	
	Banana_BABA = Banana_BABA+1;
end
end


function Banana_ResetTooltip()
	for index=1, 10 do
		local text = getglobal("BananaTooltipTextLeft"..index);
		text:SetText(nil);
		text = getglobal("BananaTooltipTextRight"..index);
		text:SetText(nil);
	end
	BananaTooltip:Hide();
	BananaTooltip:SetOwner(UIParent, "ANCHOR_NONE"); 
end

function Banana_OnUpdateDebug2(unit)
        if not BANANA_DEBUG then
		BANANA_DEBUG = {};
	end

        if not BANANA_DEBUG["debuff"] then
		BANANA_DEBUG["debuff"] = {};
	end
	
	local index = 1;
	while UnitDebuff(unit, index) do
		local un = UnitName(unit);
		Banana_ResetTooltip();
		BananaTooltip:SetUnitDebuff(unit, index);
		local debuffTexture, debuffApplications, debuffDispelType = UnitDebuff(unit, index);
		local DebuffName = BananaTooltipTextLeft1:GetText() or "<noname>";


	        if not BANANA_DEBUG["debuff"][debuffTexture] then
			BANANA_DEBUG["debuff"][debuffTexture] = {};
		end
	        if not BANANA_DEBUG["debuff"][debuffTexture][(debuffDispelType or "none")] then
			BANANA_DEBUG["debuff"][debuffTexture][(debuffDispelType or "none")] = {};
		end
	        if not BANANA_DEBUG["debuff"][debuffTexture][(debuffDispelType or "none")][DebuffName] then
			BANANA_DEBUG["debuff"][debuffTexture][(debuffDispelType or "none")][DebuffName] = {};
		end
	        if not BANANA_DEBUG["debuff"][debuffTexture][(debuffDispelType or "none")][DebuffName][(debuffApplications or "*")..":"..(BananaTooltipTextLeft2:GetText() or "<nodesc>")] then
			BANANA_DEBUG["debuff"][debuffTexture][(debuffDispelType or "none")][DebuffName][(debuffApplications or "*")..":"..(BananaTooltipTextLeft2:GetText() or "<nodesc>")] = un;
			Banana_Print("Log: "..DebuffName.." "..(debuffApplications or "*"));
		end
		index = index+1;
	end
end


function Banana_OnUpdateDebug3(unit)
        if not BANANA_DEBUG then
		BANANA_DEBUG = {};
	end

        if not BANANA_DEBUG["buff"] then
		BANANA_DEBUG["buff"] = {};
	end
	
	local index = 1;
	while UnitBuff(unit, index) do
		local un = UnitName(unit);
		Banana_ResetTooltip();
		BananaTooltip:SetUnitBuff(unit, index);
		local debuffTexture, debuffApplications = UnitBuff(unit, index);
		local DebuffName = BananaTooltipTextLeft1:GetText() or "<noname>";


	        if not BANANA_DEBUG["buff"][debuffTexture] then
			BANANA_DEBUG["buff"][debuffTexture] = {};
		end
	        if not BANANA_DEBUG["buff"][debuffTexture][DebuffName] then
			BANANA_DEBUG["buff"][debuffTexture][DebuffName] = {};
		end
	        if not BANANA_DEBUG["buff"][debuffTexture][DebuffName][(debuffApplications or "*")..":"..(BananaTooltipTextLeft2:GetText() or "<nodesc>")] then
			BANANA_DEBUG["buff"][debuffTexture][DebuffName][(debuffApplications or "*")..":"..(BananaTooltipTextLeft2:GetText() or "<nodesc>")] = un;
			Banana_Print("BuffLog: "..DebuffName.." "..(debuffApplications or "*"));
		end
		index = index+1;
	end
end

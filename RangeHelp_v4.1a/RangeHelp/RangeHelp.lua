RangeHelp_curVer = "4.1";
RangeHelp_playerID = "";

RangeHelp_BackDropDirectory = "Interface\\AddOns\\RangeHelp\\Custom\\";

-- command parameters
local UICOM = "ui";
local SPELLCOM = "spell";

local MAX_BAR = 120;
local MAX_BUFF = 30;

local index = "notarg ui";		-- store current range state
local TargetFrameState = 0;
local OldTargetFrameStat = 0;
local mouse_x;
local mouse_y;

local KeyBindSpell = {};

function RangeHelp_OnLoad()
	SlashCmdList["RANGEHELP"] = RangeHelp_SlashCommand;
	SLASH_RANGEHELP1 = "/rangehelp";
	SLASH_RANGEHELP2 = "/rh";
	
	RangeHelp_playerID = UnitName("player") .. " of " .. GetCVar("realmName");
	this:RegisterEvent("VARIABLES_LOADED");
	TargetFrameState = 0;
	OldTargetFrameState = 0;
end

function RangeHelp_OnEvent(event)
	if(event == "VARIABLES_LOADED") then
		if (not RangeConfig) then
			RangeConfig = {};
			RangeConfig["Version"] = RangeHelp_curVer;
		end
		if(not RangeConfig["Version"]) then
			RangeConfig["Version"] = "2.1";
			RangeConfig["hide rangeinfo"] = 0;
		end
		if(RangeConfig["Version"] == "2.1") then
			newRangeConfig = {};
			newRangeConfig[RangeHelp_playerID] = {};
			CopyTable(RangeConfig, newRangeConfig[RangeHelp_playerID]);
			RangeConfig = newRangeConfig;
			RangeConfig[RangeHelp_playerID]["enable rangehelp"] = 1;
			RangeConfig["Version"] = "2.2";
		end
		if(RangeConfig["Version"] == "2.2") then
			foreach(RangeConfig, function (k,v) if(type(v) == "table") then v["enable barswitch"] = 1 end end)
			RangeConfig["Version"] = "2.3";
		end
		if(RangeConfig["Version"] == "2.3" or RangeConfig["Version"] == "2.4") then
		 	RangeConfig[RangeHelp_playerID]["switch at deadzone"] = 0;
		 	RangeConfig[RangeHelp_playerID]["melee name"] = RH_MELEESPELL[1];
		 	RangeConfig[RangeHelp_playerID]["range name"] = RH_RANGESPELL[1];
		 	RangeConfig["Version"] = "3.0";
		end
		RangeConfig["Version"] = RangeHelp_curVer;		
		if(not RangeConfig[RangeHelp_playerID]) then
			RangeConfig[RangeHelp_playerID] = {};
			RangeConfig[RangeHelp_playerID]["melee name"] = RH_MELEESPELL[1];
			RangeConfig[RangeHelp_playerID]["melee slot"] = -1;
			RangeConfig[RangeHelp_playerID]["range name"] = RH_RANGESPELL[1];
			RangeConfig[RangeHelp_playerID]["range slot"] = -1;
			RangeConfig[RangeHelp_playerID]["melee page"] = 2;
			RangeConfig[RangeHelp_playerID]["range page"] = 1;
			RangeConfig[RangeHelp_playerID]["lock"] = 1;
			RangeConfig[RangeHelp_playerID]["hide rangeinfo"] = 0;
			RangeConfig[RangeHelp_playerID]["enable barswitch"] = 1;
			RangeConfig[RangeHelp_playerID]["switch at deadzone"] = 0;
			local playerClass, englishClass = UnitClass("player");
			if(englishClass == "HUNTER") then
				RangeConfig[RangeHelp_playerID]["enable rangehelp"] = 1;
			else
				RangeConfig[RangeHelp_playerID]["enable rangehelp"] = 0;
			end
		end
		
		if(RangeConfig[RangeHelp_playerID]["enable rangehelp"] == 1) then
			this:RegisterEvent("ACTIONBAR_SLOT_CHANGED");
		end
	elseif(event == "ACTIONBAR_SLOT_CHANGED") then
		RangeHelpUpdateSlot();         	
	end
end

function RangeHelp_SlashCommand(msg)
	msg = string.lower(msg);
	
	cmd = strsub(msg, 1, 5);
	if(cmd == UICOM) then
		ShowUIPanel(RangeHelpUISetup);
	elseif(cmd == SPELLCOM) then
		ShowUIPanel(RangeHelpKeySpellSetup);
	else
		ShowUIPanel(RangeHelpSetup);
	end
end

function RangeHelp_OnUpdate()
	if(RangeConfig[RangeHelp_playerID]["enable rangehelp"] == 0) then
		return;
	end
	if(UnitExists("target") and (not UnitIsDead("target")) and UnitCanAttack("player", "target")) then
		if(RangeConfig[RangeHelp_playerID]["hide rangeinfo"] == 0 and (not TargetRangeInfo:IsVisible())) then
			TargetRangeInfo:Show();
			RangeInfoFontFrame:SetScale(RangeHelpOption[RangeHelp_playerID]["font height"]);
		end
		if(RangeConfig[RangeHelp_playerID]["melee slot"] == -1) then
			text = "melee not set";
			TargetRangeInfo:SetBackdropColor(1.0,1.0,1.0);
			TargetRangeInfo:SetBackdropBorderColor(1.0,1.0,1.0);
			TargetRange:SetTextColor(0.5,0.5,0.5);
			TargetRange:SetText(text);
		elseif(RangeConfig[RangeHelp_playerID]["range slot"] == -1) then
			text = "range not set";
			TargetRangeInfo:SetBackdropColor(1.0,1.0,1.0);
			TargetRangeInfo:SetBackdropBorderColor(1.0,1.0,1.0);
			TargetRange:SetTextColor(0.5,0.5,0.5);
			TargetRange:SetText(text);
		elseif(IsActionInRange(RangeConfig[RangeHelp_playerID]["melee slot"]) == 1) then
			if(RangeConfig[RangeHelp_playerID]["enable barswitch"] == 1) then
				if(TargetFrameState ~= 1 or RangeConfig[RangeHelp_playerID]["lock"] == 1) then
					if(CURRENT_ACTIONBAR_PAGE ~= RangeConfig[RangeHelp_playerID]["melee page"]) then
						CURRENT_ACTIONBAR_PAGE = RangeConfig[RangeHelp_playerID]["melee page"];
						ChangeActionBarPage();
					end
				end
			end
			if(TargetFrameState ~= 1) then
				index = "melee ui";
				TargetFrameState = 1;
			end
		else
			local prevTargetFrameState = TargetFrameState;
			if(IsActionInRange(RangeConfig[RangeHelp_playerID]["range slot"]) == 1) then
				if(TargetFrameState ~= 2) then
					index = "range ui";
					TargetFrameState = 2;
				end
			elseif(CheckInteractDistance("target", 4)) then
				if(TargetFrameState ~= 3) then
					index = "dead ui";
					TargetFrameState = 3;
				end
			else
				if(TargetFrameState ~= 4) then
					index = "oorange ui";
					TargetFrameState = 4;
				end
			end
			
			if(RangeConfig[RangeHelp_playerID]["enable barswitch"] == 1) then
				if(prevTargetFrameState < 2 or RangeConfig[RangeHelp_playerID]["lock"] == 1) then
					local page = "range page";
					if(TargetFrameState == 3 and RangeConfig[RangeHelp_playerID]["switch at deadzone"] == 1) then
						page = "melee page";
					end
					if(CURRENT_ACTIONBAR_PAGE ~= RangeConfig[RangeHelp_playerID][page]) then
						CURRENT_ACTIONBAR_PAGE = RangeConfig[RangeHelp_playerID][page];
						ChangeActionBarPage();
					end	
				elseif(RangeConfig[RangeHelp_playerID]["switch at deadzone"] == 1) then
				    if(prevTargetFrameState == 3 and (TargetFrameState == 2 or TargetFrameState == 4)) then
						CURRENT_ACTIONBAR_PAGE = RangeConfig[RangeHelp_playerID]["range page"];
						ChangeActionBarPage();
					elseif((prevTargetFrameState == 2 or prevTargetFrameState == 4) and TargetFrameState == 3) then
						CURRENT_ACTIONBAR_PAGE = RangeConfig[RangeHelp_playerID]["melee page"];
						ChangeActionBarPage();
					end
				end
			end
		end
		if(TargetFrameState ~= OldTargetFrameState) then
			TargetRangeInfo:SetBackdropColor(RangeHelpOption[RangeHelp_playerID][index].BGColor.r,
												RangeHelpOption[RangeHelp_playerID][index].BGColor.g,
												RangeHelpOption[RangeHelp_playerID][index].BGColor.b, 
												RangeHelpOption[RangeHelp_playerID][index].BGColor.alpha);
			TargetRangeInfo:SetBackdropBorderColor(RangeHelpOption[RangeHelp_playerID][index].BorColor.r,
													RangeHelpOption[RangeHelp_playerID][index].BorColor.g,
													RangeHelpOption[RangeHelp_playerID][index].BorColor.b,
													RangeHelpOption[RangeHelp_playerID][index].BorColor.alpha);
			TargetRange:SetTextColor(RangeHelpOption[RangeHelp_playerID][index].FontColor.r,
										RangeHelpOption[RangeHelp_playerID][index].FontColor.g,
										RangeHelpOption[RangeHelp_playerID][index].FontColor.b);
			TargetRange:SetText(RangeHelpOption[RangeHelp_playerID][index].Text);
			OldTargetFrameState = TargetFrameState;
		end
	else
		index = "notarg ui";
		if(TargetRangeInfo:IsVisible() and RangeHelp_UISetup == 0) then
			TargetRangeInfo:Hide();
			if(RangeConfig[RangeHelp_playerID]["enable barswitch"] == 1) then
				if(CURRENT_ACTIONBAR_PAGE ~= RangeConfig[RangeHelp_playerID]["range page"]) then
					CURRENT_ACTIONBAR_PAGE = RangeConfig[RangeHelp_playerID]["range page"];
					ChangeActionBarPage();
				end
			end
			TargetFrameState = 0;
			OldTargetFrameState = 0;
		end
	end
end

function RangeHelpUpdateSlot()
	melee = 0;
	range = 0;
	local mname = "";
	local rname = "";

	RangeHelpActionTip:SetOwner(this,"ANCHOR_NONE");
	RangeHelpActionTip:SetAction(RangeConfig[RangeHelp_playerID]["melee slot"]);
	local name = RangeHelpActionTipTextLeft1:GetText();
	if(name ~= nil) then
		name = string.lower(name);
		if(name ~= string.lower(RangeConfig[RangeHelp_playerID]["melee name"])) then
			RangeConfig[RangeHelp_playerID]["melee slot"] = -1;
		else
			melee = 1;
		end
	else
		RangeConfig[RangeHelp_playerID]["melee slot"] = -1;
	end

	RangeHelpActionTip:SetOwner(this,"ANCHOR_NONE");	
	RangeHelpActionTip:SetAction(RangeConfig[RangeHelp_playerID]["range slot"]);
	name = RangeHelpActionTipTextLeft1:GetText();
	if(name ~= nil) then
		name = string.lower(name);
		if(name ~= string.lower(RangeConfig[RangeHelp_playerID]["range name"])) then
			RangeConfig[RangeHelp_playerID]["range slot"] = -1;
		else
			range = 1;
		end
	else
		RangeConfig[RangeHelp_playerID]["range slot"] = -1;
	end
	
	if(RangeConfig[RangeHelp_playerID]["melee slot"] == -1) then
		mname = string.lower(RangeConfig[RangeHelp_playerID]["melee name"]);
	end
	if(RangeConfig[RangeHelp_playerID]["range slot"] == -1) then
		rname = string.lower(RangeConfig[RangeHelp_playerID]["range name"]);
	end
	if(mname ~= "" or rname ~= "") then
		local fin = 0;
		local melee_ind = 0;
		local range_ind = 0;
		while fin == 0 do
			for slot=1, MAX_BAR do
				RangeHelpActionTip:SetOwner(this,"ANCHOR_NONE");
				RangeHelpActionTip:SetAction(slot);
				name = RangeHelpActionTipTextLeft1:GetText();
				if(name ~= nil) then
					name = string.lower(name);
					if(name == mname and melee == 0) then
						RangeConfig[RangeHelp_playerID]["melee name"] = RangeHelpActionTipTextLeft1:GetText();
						RangeConfig[RangeHelp_playerID]["melee slot"] = slot;
						melee = 1;
					elseif(name == rname and range == 0) then
						RangeConfig[RangeHelp_playerID]["range name"] = RangeHelpActionTipTextLeft1:GetText();
						RangeConfig[RangeHelp_playerID]["range slot"] = slot;
						range = 1;
					end
				end
			end
			
			if(melee == 0) then
				melee_ind = melee_ind + 1;
				if(melee_ind <= 2) then
					mname = RH_MELEESPELL[melee_ind];
				else
					melee = 1;
				end
			end
			
			if(range == 0) then
				range_ind = range_ind + 1;
				if(range_ind <= 5) then
					rname = RH_RANGESPELL[range_ind];
				else
					range = 1;
				end
			end
			
			if(range == 1 and melee == 1) then
				fin = 1;
			end
		end
	end
end

function RangeHelp_Echo(msg)
	DEFAULT_CHAT_FRAME:AddMessage(msg);
end

function RangeHelp_OnDragStart()
	if(RangeHelpOption[RangeHelp_playerID]["resize"] == 1) then
		local hotleft = TargetRangeInfo:GetLeft()*UIParent:GetScale() + 7;
		local hottop = TargetRangeInfo:GetTop()*UIParent:GetScale() - 7;
		local hotbottom = TargetRangeInfo:GetBottom()*UIParent:GetScale() + 7;
		local hotright = TargetRangeInfo:GetRight()*UIParent:GetScale() - 7;
		if(mouse_x < hotleft and mouse_y > hottop) then
			TargetRangeInfo:StartSizing("TOPLEFT");
		elseif(mouse_x > hotright and mouse_y > hottop) then
			TargetRangeInfo:StartSizing("TOPRIGHT");
		elseif(mouse_x > hotright and mouse_y < hotbottom) then
			TargetRangeInfo:StartSizing("BOTTOMRIGHT");
		elseif(mouse_x < hotleft and mouse_y < hotbottom) then
			TargetRangeInfo:StartSizing("BOTTOMLEFT");
		elseif(mouse_x > hotright) then
			TargetRangeInfo:StartSizing("RIGHT");
		elseif(mouse_x < hotleft) then
			TargetRangeInfo:StartSizing("LEFT");
		elseif(mouse_y > hottop) then
			TargetRangeInfo:StartSizing("TOP");
		elseif(mouse_y < hotbottom) then
			TargetRangeInfo:StartSizing("BOTTOM");
		elseif(RangeHelpOption[RangeHelp_playerID]["move"] == 1) then
			TargetRangeInfo:StartMoving();
		end
	elseif(RangeHelpOption[RangeHelp_playerID]["move"] == 1) then
		TargetRangeInfo:StartMoving();
	end
end

function RangeHelp_OnDragStop()
	TargetRangeInfo:StopMovingOrSizing();
end

function RangeHelp_OnMouseDown()
	mouse_x, mouse_y = GetCursorPosition();
end

function RangeHelp_SetupKeyBinding()
	local si, sv;
	for si, sv in RangeHelpSpellSetup[RangeHelp_playerID] do
		local si2, sv2;
		KeyBindSpell[si] = {};		
		for si2, sv2 in sv do
			if(sv2.Type == "Spell") then
				KeyBindSpell[si][si2] = {};
				KeyBindSpell[si][si2].func = RangeHelp_CastSpell;
				KeyBindSpell[si][si2].param = { id=sv2.SpellID, booktype=sv2.BookType };
				KeyBindSpell[si][si2].check = sv2.Check;
				KeyBindSpell[si][si2].texture = sv2.Texture;
			elseif(sv2.Type == "Macro") then
				--local name, iconTextureID, body = GetMacroInfo(sv2.MacroID);
				KeyBindSpell[si][si2] = {};
				KeyBindSpell[si][si2].func = RangeHelp_CastMacro;
				KeyBindSpell[si][si2].param = sv2.MacroID;
				KeyBindSpell[si][si2].check = sv2.Check;
				KeyBindSpell[si][si2].texture = sv2.Texture;
			end
		end
	end
end

function RangeHelp_CastSpell(param)
	CastSpell(param.id, param.booktype);
end

function RangeHelp_CastMacro(param)
	local name, iconTextureID, body = GetMacroInfo(param);
	local cmd;
	
	for cmd in string.gfind(body, "[^\n]*") do
		DummyEditBox:SetText(cmd);
		ChatEdit_SendText(DummyEditBox, 0);
	end
end

function RangeHelp_KeyBindFunc(key)
	if(KeyBindSpell[key]) then
		if(KeyBindSpell[key][index]) then
			if(KeyBindSpell[key][index].check) then
				if(RangeHelp_BuffCheck(KeyBindSpell[key][index].texture) == 0) then
					KeyBindSpell[key][index].func(KeyBindSpell[key][index].param);
				end
			else
				KeyBindSpell[key][index].func(KeyBindSpell[key][index].param);
			end
		end
	end
end

function RangeHelp_BuffCheck(texture)
  	local retVal = 0;
  	local i;
	for i=0,MAX_BUFF do
		local bufftexture = GetPlayerBuffTexture(i);
		if(bufftexture) then
			if(bufftexture == texture) then
				retVal = 1;
				break;
			end
		end
	end
	return retVal;
end
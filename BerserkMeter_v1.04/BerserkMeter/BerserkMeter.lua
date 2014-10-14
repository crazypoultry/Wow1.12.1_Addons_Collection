-- Left-Click Activation Toggle modification implemented by NightHawk The Sane (1.04)

BINDING_HEADER_BERSERKMETER_TITLE = "BerserkMeter"
local currentHealth = nil;
local maxHealth = nil;
local percentHealth = nil;
local berserkValue = nil;
local berserkValueString = nil;
local berserkToggle = nil;
local berserkText = nil;
local berserkTooltip = nil;
local textColor = nil;
local tooltipTextColor = nil;

--Function for formatting text colors.
--Written by Anavar (http://www.curse-gaming.com/mod.php?addid=2077)
function RS_BCC(r, g, b)
	return string.format("|cff%02x%02x%02x", (r*255), (g*255), (b*255));
end

local RT = RS_BCC(1, 0, 0);
local YT = RS_BCC(1, 1, 0);
local GT = RS_BCC(0, 1, 0);
local DT = RS_BCC(0.5, 0.5, 0.5);
local WT = RS_BCC(1, 1, 1);
local BOFF = RS_BCC(0.6, 0.5, 0);
local BON = RS_BCC(1, 0.8, 0);

--Internal function that returns the SpellID of the highest ranking spell for SpellName
--Written by Andrew Young(andrew@inmyroom.org)
function GetSpellID(SpellName)
	local SpellCount = 0;
	local ReturnName;
	while (SpellName ~= ReturnName) do
		SpellCount = SpellCount + 1;
		ReturnName = GetSpellName(SpellCount, BOOKTYPE_SPELL);
	end
	while (SpellName == ReturnName) do
		SpellID = SpellCount;
		SpellCount = SpellCount + 1;
		ReturnName = GetSpellName(SpellCount, BOOKTYPE_SPELL);
		if (SpellName ~= ReturnName) then
			break;
		end
	end
	return SpellID;
end

function TitanPanelBerserkMeterPlugin_OnLoad()
	this.registry = {
		id = "BerserkMeter",
		version = "1.04",
		category = "Combat",
		menuText = "BerserkMeter",
		tooltipTitle = "BerserkMeter Weapon Speeds",
		tooltipTextFunction = "BerserkMeter_GetTooltipText",
		buttonTextFunction = "TitanPanelBerserkMeterPlugin_GetButtonText",
		savedVariables = {
			ClickToActivate = 1, -- Default to On
		}
	};
end

function TitanPanelBerserkMeterPlugin_GetButtonText()
	if(berserkText ~= nil) then
		return berserkText;
	end
end

function TitanPanelRightClickMenu_PrepareBerserkMeterMenu()
  TitanPanelRightClickMenu_AddTitle(TitanPlugins["BerserkMeter"].menuText);

	local info = {};
	info.text = "Left click activates Berserking"
	info.func = TitanPanelBerserkMeterPlugin_ToggleClickToActivate
	info.checked = TitanGetVar("BerserkMeter", "ClickToActivate")
	info.keepShownOnClick = 1
	UIDropDownMenu_AddButton(info)

  TitanPanelRightClickMenu_AddSpacer();
  TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, "BerserkMeter", TITAN_PANEL_MENU_FUNC_HIDE);
end

function TitanPanelBerserkMeterPlugin_ToggleClickToActivate()
	TitanToggleVar("BerserkMeter", "ClickToActivate")
	TitanPanelButton_UpdateButton("BerserkMeter")
end

function BerserkMeter_OnLoad()
	this:RegisterEvent("ADDON_LOADED");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS");
	this:RegisterEvent("CHAT_MSG_SPELL_AURA_GONE_SELF");
	this:RegisterEvent("PLAYER_DEAD");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("UNIT_HEALTH");
	this:RegisterEvent("VARIABLES_LOADED");

	SLASH_BERSERKMETER1 = "/berserkmeter";
	SLASH_BERSERKMETER2 = "/bmeter";
	SlashCmdList["BERSERKMETER"] = BerserkMeter_Command;
end

function TitanPanelBerserkMeterButton_OnEvent()
	TitanPanelButton_UpdateTooltip();
end

function TitanPanelBerserkMeterButton_OnClick(arg1)
	if(arg1 == "LeftButton" and TitanGetVar("BerserkMeter", "ClickToActivate") == 1) then
		CastSpellByName("Berserking");
	end
end

function BerserkMeter_OnEvent(event,arg1)
	if(event == "VARIABLES_LOADED") then
		local race, raceEn = UnitRace("player");
		if(race ~= "Troll") then
			this:UnregisterEvent("ADDON_LOADED");
			this:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS");
			this:UnregisterEvent("CHAT_MSG_SPELL_AURA_GONE_SELF");
			this:UnregisterEvent("PLAYER_DEAD");
			this:UnregisterEvent("PLAYER_ENTERING_WORLD");
			this:UnregisterEvent("UNIT_HEALTH");
			this:UnregisterEvent("VARIABLES_LOADED");
			berserkText = DT.."BerserkMeter (OFF)";
			BerserkMeter_Text:SetText(berserkText);
			BerserkMeter_Frame:Hide();
		end
	end
	if(event == "ADDON_LOADED" and (arg1 == "BerserkMeter")) then
		if(not BerserkMeter_State) then
			BerserkMeter_State = {};
			BerserkMeter_State.Locked = 0;
			BerserkMeter_State.BGVisible = 1;
			BerserkMeter_State.Tooltip = 1;
			BerserkMeter_State.Visible = 1;
			BerserkMeter_State.TitanVisible = 0;
			BerserkMeter_State.ClickToActivate = 1;
		end
		if(BerserkMeter_State.Locked == nil) then
			BerserkMeter_State.Locked = 0;
		end
		if(BerserkMeter_State.BGVisible == nil) then
			BerserkMeter_State.BGVisible = 1;
		end
		if(BerserkMeter_State.Tooltip == nil) then
			BerserkMeter_State.Tooltip = 1;
		end
		if(BerserkMeter_State.Visible == nil) then
			BerserkMeter_State.Visible = 1;
		end
		if(BerserkMeter_State.TitanVisible == nil) then
			BerserkMeter_State.TitanVisible = 0;
		end
		if(BerserkMeter_State.ClickToActivate == nil) then
			BerserkMeter_State.ClickToActivate = 1;
		end
	end
	if(event == "PLAYER_DEAD") then
		berserkToggle = 1;
		BerserkMeter_UpdateMeter();
	end
	if(event == "PLAYER_ENTERING_WORLD") then
		BerserkMeter_Start();
	end
	if(event == "UNIT_HEALTH") then
		BerserkMeter_UpdateMeter();
	end
	if(event == "CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS") then
		if(arg1 == "You gain Berserking.") then
			BerserkMeter_Activated();
		end
	end
	if(event == "CHAT_MSG_SPELL_AURA_GONE_SELF") then
		if(arg1 == "Berserking fades from you.") then
			berserkToggle = 1;
			BerserkMeter_UpdateMeter();
		end
	end
end

function BerserkMeter_Start()
	berserkToggle = 1;
	if(BerserkMeter_State.BGVisible == 0) then
		BerserkMeter_Frame:SetBackdropColor(TOOLTIP_DEFAULT_BACKGROUND_COLOR.r, TOOLTIP_DEFAULT_BACKGROUND_COLOR.g, TOOLTIP_DEFAULT_BACKGROUND_COLOR.b, 0);
		BerserkMeter_Frame:SetBackdropBorderColor(TOOLTIP_DEFAULT_COLOR.r, TOOLTIP_DEFAULT_COLOR.g, TOOLTIP_DEFAULT_COLOR.b, 0);
	end
	if(BerserkMeter_State.Visible == 0) then
		BerserkMeter_Frame:Hide();
	end
	if((TitanPanelBarButton ~= nil) and (BerserkMeter_State.TitanVisible == 0)) then
		BerserkMeter_Frame:Hide();
	end
	BerserkMeter_UpdateMeter();
end

function BerserkMeter_UpdateMeter()
	if(berserkToggle == 1) then
		currentHealth = UnitHealth("player");
		maxHealth = UnitHealthMax("player");
		percentHealth = (currentHealth / maxHealth) * 100;
		if(percentHealth >= 40) then
			berserkValue = (130/3) - ((1/3) * percentHealth);
		elseif((percentHealth <= 0) or (currentHealth == 1)) then
			berserkValue = 0;
		else
			berserkValue = 30;
		end
		if((berserkValue < 16) and (berserkValue > 0)) then
			textColor = GT;
		elseif((berserkValue >= 16) and (berserkValue < 26)) then
			textColor = YT;
		elseif(berserkValue >= 26) then
			textColor = RT;
		elseif(berserkValue == 0) then
			textColor = DT;
		end
		berserkValueString = format("%i", berserkValue);
		berserkText = BOFF.."Berserking (OFF): "..textColor..berserkValueString.."%";
		BerserkMeter_Text:SetText(berserkText);
		if(TitanPanelBarButton~=nil) then
			TitanPanelButton_UpdateButton("BerserkMeter");
		end
	end
end

function BerserkMeter_Activated()
	berserkToggle = 0;
	currentHealth = UnitHealth("player");
	maxHealth = UnitHealthMax("player");
	percentHealth = (currentHealth / maxHealth) * 100;
	if(percentHealth >= 40) then
		berserkValue = (130/3) - ((1/3) * percentHealth);
	elseif(percentHealth <= 0) then
		berserkValue = 0;
	else
		berserkValue = 30;
	end
	if((berserkValue <= 15) and (berserkValue > 0)) then
		textColor = GT;
	elseif((berserkValue > 15) and (berserkValue <= 25)) then
		textColor = YT;
	elseif(berserkValue > 25) then
		textColor = RT;
	elseif(berserkValue == 0) then
		textColor = DT;
	end
	berserkValueString = format("%i", berserkValue);
	berserkText = "Berserking (ON): "..textColor..berserkValueString.."%";
	BerserkMeter_Text:SetText(berserkText);
	if(TitanPanelBarButton~=nil) then
		TitanPanelButton_UpdateButton("BerserkMeter");
	end
end

function BerserkMeter_OnMouseDown(arg1)
	if(arg1 == "RightButton" and BerserkMeter_State.Locked == 0) then
		BerserkMeter_Frame:StartMoving();
	end
end

function BerserkMeter_OnMouseUp(arg1)
	if(arg1 == "RightButton") then
		BerserkMeter_Frame:StopMovingOrSizing();
	end
end

function BerserkMeter_OnClick()
	if(BerserkMeter_State.ClickToActivate == 1) then
		CastSpellByName("Berserking");
	end
end

function BerserkMeter_OnEnter()
	if(BerserkMeter_State.Tooltip == 1) then
		GameTooltip:SetOwner(this,"ANCHOR_CURSOR")
		GameTooltip:AddLine("BerserkMeter Weapon Speeds:");
		GameTooltip:AddLine(BerserkMeter_GetTooltipText());
		GameTooltip:Show();
	end
end

function BerserkMeter_GetTooltipText()
	local mainHandSpeed, offHandSpeed = UnitAttackSpeed("player");
	local rangedSpeed, lowDmg, hiDmg = UnitRangedDamage("player");
	local tooltipHelpText = nil;
	mainHandSpeed = format("%.2f", mainHandSpeed);
	if(offHandSpeed == nil) then
		offHandSpeed = "--";
	else
		offHandSpeed = format("%.2f", offHandSpeed);
	end
	if(rangedSpeed == 0) then
		rangedSpeed = "--";
	else
		rangedSpeed = format("%.2f", rangedSpeed);
	end
	if(berserkToggle == 0) then
		tooltipTextColor = GT;
		tooltipHelpText = BON.."Berserking activated!";
	else
		tooltipTextColor = WT;
		if(BerserkMeter_State.ClickToActivate == 1) then
			tooltipHelpText = BON.."Click here to activate Berserking.";
		else 
			tooltipHelpText = BON.."Left click activation disabled.";
		end
	end
	berserkTooltip = YT.."MH: "..tooltipTextColor..mainHandSpeed..YT.."     OH: "..tooltipTextColor..offHandSpeed..YT.."     R: "..tooltipTextColor..rangedSpeed.."\n"..tooltipHelpText;
	return berserkTooltip;
end

function BerserkMeter_Command(msg)
	if((not msg) or (strlen(msg) <= 0)) then
		DEFAULT_CHAT_FRAME:AddMessage("BerserkMeter Commands: /berserkmeter or /bmeter");
		DEFAULT_CHAT_FRAME:AddMessage("/berserkmeter lock | unlock");
		DEFAULT_CHAT_FRAME:AddMessage("/berserkmeter show | hide");
		DEFAULT_CHAT_FRAME:AddMessage("/berserkmeter background <on | off>");
		DEFAULT_CHAT_FRAME:AddMessage("/berserkmeter tooltip <on | off>");
		DEFAULT_CHAT_FRAME:AddMessage("/berserkmeter click <on | off>");
	elseif(msg) then
		msg = string.lower(msg);
		local words = split(msg)
		local cmd, state = words[1], words[2];

		if(cmd == "lock") then
			BerserkMeter_State.Locked = 1;
			DEFAULT_CHAT_FRAME:AddMessage("BerserkMeter: Locked.");
		elseif(cmd == "unlock") then
			BerserkMeter_State.Locked = 0;
			DEFAULT_CHAT_FRAME:AddMessage("BerserkMeter: Unlocked. Right-Click to drag.");
		elseif(cmd == "show") then
			if(TitanPanelBarButton ~= nil) then
				BerserkMeter_State.TitanVisible = 1;
			else
				BerserkMeter_State.Visible = 1;
			end
			BerserkMeter_Frame:Show();
			DEFAULT_CHAT_FRAME:AddMessage("BerserkMeter: Shown.");
		elseif(cmd == "hide") then
			if(TitanPanelBarButton ~= nil) then
				BerserkMeter_State.TitanVisible = 0;
			else
				BerserkMeter_State.Visible = 0;
			end
			BerserkMeter_Frame:Hide();
			DEFAULT_CHAT_FRAME:AddMessage("BerserkMeter: Hidden.");
		elseif(cmd == "background") then
			if(state == "off") then
				BerserkMeter_Frame:SetBackdropColor(TOOLTIP_DEFAULT_BACKGROUND_COLOR.r, TOOLTIP_DEFAULT_BACKGROUND_COLOR.g, TOOLTIP_DEFAULT_BACKGROUND_COLOR.b, 0);
				BerserkMeter_Frame:SetBackdropBorderColor(TOOLTIP_DEFAULT_COLOR.r, TOOLTIP_DEFAULT_COLOR.g, TOOLTIP_DEFAULT_COLOR.b, 0);
				BerserkMeter_State.BGVisible = 0;
				DEFAULT_CHAT_FRAME:AddMessage("BerserkMeter: Hiding Background");
			elseif(state == "on") then
				BerserkMeter_Frame:SetBackdropColor(TOOLTIP_DEFAULT_BACKGROUND_COLOR.r, TOOLTIP_DEFAULT_BACKGROUND_COLOR.g, TOOLTIP_DEFAULT_BACKGROUND_COLOR.b, 100);
				BerserkMeter_Frame:SetBackdropBorderColor(TOOLTIP_DEFAULT_COLOR.r, TOOLTIP_DEFAULT_COLOR.g, TOOLTIP_DEFAULT_COLOR.b, 100);
				BerserkMeter_State.BGVisible = 1;
				DEFAULT_CHAT_FRAME:AddMessage("BerserkMeter: Showing Background");
			end
		elseif(cmd == "tooltip") then
			if(state == "on") then
				BerserkMeter_State.Tooltip = 1;
				DEFAULT_CHAT_FRAME:AddMessage("BerserkMeter: Weapon Speed Tooltip Display On");
			elseif(state == "off") then
				BerserkMeter_State.Tooltip = 0;
				DEFAULT_CHAT_FRAME:AddMessage("BerserkMeter: Weapon Speed Tooltip Display Off");
			end
		elseif(cmd == "click") then
			if(state == "on") then
				BerserkMeter_State.ClickToActivate = 1;
				DEFAULT_CHAT_FRAME:AddMessage("BerserkMeter: Left-Click Activation On");
			elseif(state == "off") then
				BerserkMeter_State.ClickToActivate = 0;
				DEFAULT_CHAT_FRAME:AddMessage("BerserkMeter: Left-Click Activation Off");
			end
		end
	end
end

function split(str)
	local t = {};
	string.gsub(str, "%S+",function(word) table.insert(t, word) end);
	return t;
end

function castBerserk(value)
	local SpellName = "Berserking";
	local SpellID = GetSpellID(SpellName);
	if(GetSpellCooldown(SpellID, 0) > 0) then
		return false;
	elseif((berserkToggle == 1) and (value == nil) and (GetSpellCooldown(SpellID, 0) == 0)) then
		CastSpellByName("Berserking");
		return true;
	elseif((berserkToggle == 1) and ((berserkValue >= value) or (berserkValue > value + 1)) and (GetSpellCooldown(SpellID, 0) == 0)) then
		CastSpellByName("Berserking");
		return true;
	else
		return false;
	end
end

function isBerserk(value)
	local SpellName = "Berserking";
	local SpellID = GetSpellID(SpellName);
	if(GetSpellCooldown(SpellID, 0) > 0) then
		return false;
	elseif((berserkToggle == 1) and (value == nil) and (GetSpellCooldown(SpellID, 0) == 0)) then
		return true;
	elseif((berserkToggle == 1) and ((berserkValue >= value) or (berserkValue > value + 1)) and (GetSpellCooldown(SpellID, 0) == 0)) then
		return true;
	else
		return false;
	end
end
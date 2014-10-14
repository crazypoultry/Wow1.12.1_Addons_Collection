BINDING_HEADER_DMSB = "Discord Mini Spellbook v1.0";
BINDING_NAME_DMSB_TOGGLE = "Toggle Spellbook";

DMSB_TEXT = {
	Action = "Action",
	Actions = "ACTIONS",
	Ranks = "Ranks:",
	SpellID = "Spell ID:",
	Book = "Booktype:",
	ScaleSet = "Discord Mini Spellbook scale set to $n.",
	Reset = "Discord Mini Spellbook location reset.",
	ReplaceOn = "Discord Mini Spellbook is set to replace the default spellbook.",
	ReplaceOff = "Discord Mini Spellbook is no longer set to replace the default spellbook.",
	SelfCastOn = "Discord Mini Spellbook is set to self-cast spells by default.",
	SelfCastOff = "Discord Mini Spellbook is no longer set to self-cast spells by default.",
	DragLocked = "Discord Mini Spellbook dragging locked.",
	DragUnlocked = "Discord Mini Spellbook dragging unlocked.",
	All = "ALL",
	Pet = "PET",
	Macro = "Macro",
	Macros = "MACROS",
	MacroID = "Macro ID:",
};

DMSB_HELPTEXT = {
	"DISCORD MINI SPELLBOOK v1.0",
	"--------------------------------------------------",
	"/dmsb - toggle the spellbook",
	"/dmsb scale # - set the spellbook's scale, 1-200",
	"/dmsb reset - reset the spellbook to the middle of the screen",
	"/dmsb replace - replace the default spellbook",
	"/dmsb selfcast - set spells to self-cast by default from the spellbook",
	"/dmsb tabs - toggle display of the tabs",
	"/dmsb drag - toggles the ability to drag the frame"
};

function DMSB_OnEvent(event)
	if (event == "PLAYER_ENTERING_WORLD") then
		DMSB_ENTERING_WORLD = true;
		if (DMSB_VARIABLES_LOADED) then
			DMSB_Initialize();
		end
	elseif (event == "VARIABLES_LOADED") then
		DMSB_VARIABLES_LOADED = true;
		if (DMSB_ENTERING_WORLD) then
			DMSB_Initialize();
		end
	elseif (event == "PET_BAR_UPDATE" or event == "SPELLS_CHANGED") then
		this.updateSpells = true;
		if (this:IsVisible()) then
			DMSB_OnShow();
		end
	elseif ( event == "CURRENT_SPELL_CAST_CHANGED" or event == "CRAFT_SHOW" or event == "CRAFT_CLOSE" or event == "TRADE_SKILL_SHOW" or event == "TRADE_SKILL_CLOSE" ) then
		if (this:IsVisible()) then
			DMSB_ScrollFrame_Update();
		end
	end
end

function DMSB_Hook_ToggleSpellbook()
	if (DMSB_Old_ToggleSpellBook) then return; end
	DMSB_Old_ToggleSpellBook = ToggleSpellBook;
	ToggleSpellBook = DMSB_Toggle_Spellbook;
end

function DMSB_Unhook_ToggleSpellbook()
	if (not DMSB_Old_ToggleSpellBook) then return; end
	ToggleSpellBook = DMSB_Old_ToggleSpellBook;
	DMSB_Old_ToggleSpellBook = nil;
end

function DMSB_Initialize()
	if (DMSB_INITIALIZED) then return; end
	if (not DMSB_Settings) then
		DMSB_Settings = {scale = 1};
	end
	tinsert(UISpecialFrames,"DiscordMiniSpellbookFrame");
	DiscordMiniSpellbookFrame.selectedTab = 0;
	DiscordMiniSpellbookFrame:SetScale(DMSB_Settings.scale);
	DiscordMiniSpellbookFrame_SelectedTab:SetText(DMSB_TEXT.All);
	if (DMSB_Settings.replace) then
		DMSB_Hook_ToggleSpellbook();
	end
	if (DMSB_Settings.hideTabs) then
		DMSB_ToggleTabsButton:SetText(">");
	else
		DMSB_ToggleTabsButton:SetText("<");
	end

	for b=1,10 do
		local button = "DMSB_ScrollButton_"..b;
		for r=2,12 do
			local prev = r - 1;
			getglobal(button.."_Rank"..r):SetPoint("LEFT", button.."_Rank"..prev, "RIGHT", 2, 0);
		end
	end

	DMSB_INITIALIZED = true;
end

function DMSB_Toggle_Tabs()
	if (DMSB_Settings.hideTabs) then
		DMSB_Settings.hideTabs = nil;
		DMSB_ToggleTabsButton:SetText("<");
	else
		DMSB_Settings.hideTabs = 1;
		DMSB_ToggleTabsButton:SetText(">");
	end
	DMSB_Update_Tabs();
end

function DMSB_OnLoad()
	this:RegisterEvent("PET_BAR_UPDATE");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("SPELLS_CHANGED");
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("CURRENT_SPELL_CAST_CHANGED");
	this:RegisterEvent("CRAFT_SHOW");
	this:RegisterEvent("CRAFT_CLOSE");
	this:RegisterEvent("TRADE_SKILL_SHOW");
	this:RegisterEvent("TRADE_SKILL_CLOSE");
	this:SetBackdropColor(0, 0, 0, 1);
	this:SetBackdropBorderColor(1, 0, 0, 1);
	this:RegisterForDrag("LeftButton");
	this.updateSpells = true;

	SlashCmdList["DMSB"] = DMSB_Slash_Handler;
	SLASH_DMSB1 = "/dmsb";
	SLASH_DMSB2 = "/discordminispellbook";
end

function DMSB_OnShow()
	if (this.updateSpells) then
		DMSB_Update_SpellList();
		DMSB_Update_Tabs();
		this.updateSpells = nil;
	end
	DMSB_ScrollFrame_Update();
end

function DMSB_ScrollFrame_Update()
	local numOptions = table.getn(DMSB_SPELL_LIST);
	local offset = FauxScrollFrame_GetOffset(DMSB_ScrollFrame);
	local index, button, buttontext, texture, icon, checkbutton;

	for i=1, 10 do
		button = getglobal("DMSB_ScrollButton_"..i);
		buttontext = getglobal("DMSB_ScrollButton_"..i.."_Text");
		checkbutton = getglobal("DMSB_ScrollButton_"..i.."_SpellButton");
		icon = getglobal("DMSB_ScrollButton_"..i.."_SpellButton_Icon");
		index = offset + i;
		if ( DMSB_SPELL_LIST[index] ) then
			buttontext:SetText(DMSB_SPELL_LIST[index].name);
			local texture;
			if (DMSB_SPELL_LIST[index].bookType == DMSB_TEXT.Macro) then
				_, texture = GetMacroInfo(DMSB_SPELL_LIST[index].ranks[1]);
			elseif (DMSB_SPELL_LIST[index].bookType == DMSB_TEXT.Action) then
				if (HasAction(DMSB_SPELL_LIST[index].action)) then
					texture = GetActionTexture(DMSB_SPELL_LIST[index].action);
				else
					texture = "Interface\\AddOns\\DiscordMiniSpellbook\\EmptyButton";
				end
			else
				texture = GetSpellTexture(DMSB_SPELL_LIST[index].ranks[1], DMSB_SPELL_LIST[index].bookType);
			end
			icon:SetTexture(texture);
			button:Show();
			local highrank;
			checkbutton.bookType = DMSB_SPELL_LIST[index].bookType;
			checkbutton.action = DMSB_SPELL_LIST[index].action;
			if (DMSB_SPELL_LIST[index].ranks) then
				highrank = table.getn(DMSB_SPELL_LIST[index].ranks);
				checkbutton.spellID = DMSB_SPELL_LIST[index].ranks[highrank];
				checkbutton.rankText = DMSB_SPELL_LIST[index].rankText[highrank];
			end
			DMSB_SpellButton_UpdateCooldown(checkbutton);
			if (DMSB_SPELL_LIST[index].bookType == DMSB_TEXT.Macro or DMSB_SPELL_LIST[index].bookType == DMSB_TEXT.Action) then
				checkbutton:SetChecked(0);
			elseif ( IsCurrentCast(checkbutton.spellID,  checkbutton.bookType) ) then
				checkbutton:SetChecked(1);
			else
				checkbutton:SetChecked(0);
			end
			if (DMSB_SPELL_LIST[index].action) then
				getglobal("DMSB_ScrollButton_"..i.."_TabText"):SetText(DMSB_SPELL_LIST[index].tab.." "..DMSB_SPELL_LIST[index].action);
			else
				getglobal("DMSB_ScrollButton_"..i.."_TabText"):SetText(DMSB_SPELL_LIST[index].tab);
			end
			local autoCastableTexture = getglobal("DMSB_ScrollButton_"..i.."_SpellButtonAutoCastable");
			local autoCastModel = getglobal("DMSB_ScrollButton_"..i.."_SpellButtonAutoCast");
			if (DMSB_SPELL_LIST[index].bookType == DMSB_TEXT.Macro or DMSB_SPELL_LIST[index].bookType == DMSB_TEXT.Action) then
				autoCastableTexture:Hide();
				autoCastModel:Hide();
			else
				local autoCastAllowed, autoCastEnabled = GetSpellAutocast(checkbutton.spellID, checkbutton.bookType);
				if ( autoCastAllowed ) then
					autoCastableTexture:Show();
				else
					autoCastableTexture:Hide();
				end
				if ( autoCastEnabled ) then
					autoCastModel:Show();
				else
					autoCastModel:Hide();
				end
			end
			if (DMSB_SPELL_LIST[index].ranks) then
				for r=1,12 do
					local rank = getglobal("DMSB_ScrollButton_"..i.."_Rank"..r);
					if (DMSB_SPELL_LIST[index].ranks[r]) then
						rank:Show();
						getglobal("DMSB_ScrollButton_"..i.."_Rank"..r.."_Text"):SetText(r);
						rank.spellID = DMSB_SPELL_LIST[index].ranks[r];
						rank.bookType = DMSB_SPELL_LIST[index].bookType;
						rank.rankText = DMSB_SPELL_LIST[index].rankText[r];
					else
						rank:Hide();
					end
				end
				if (DMSB_SPELL_LIST[index].ranks[2]) then
					getglobal("DMSB_ScrollButton_"..i.."_RankText"):SetText(DMSB_TEXT.Ranks);
				else
					getglobal("DMSB_ScrollButton_"..i.."_Rank1"):Hide();
					getglobal("DMSB_ScrollButton_"..i.."_RankText"):SetText(DMSB_SPELL_LIST[index].rankText[1]);
				end
			else
				getglobal("DMSB_ScrollButton_"..i.."_Rank1"):Hide();
				getglobal("DMSB_ScrollButton_"..i.."_RankText"):SetText("");
			end
		else
			button:Hide();
		end
	end
	
	FauxScrollFrame_Update(DMSB_ScrollFrame, numOptions, 10, 30);
end

function DMSB_Stop_Moving()
	this:StopMovingOrSizing();
	if (this.moving) then
		DMSB_Update_Tabs();
	end
	this.moving = nil;
end

function DMSB_Slash_Handler(msg)
	if (msg == "") then
		DMSB_Toggle_Spellbook();
	elseif (msg == "replace") then
		if (DMSB_Settings.replace) then
			DMSB_Settings.replace = nil;
			DMSB_Unhook_ToggleSpellbook();
			DEFAULT_CHAT_FRAME:AddMessage(DMSB_TEXT.ReplaceOff, 1, 1, 0);
		else
			DMSB_Settings.replace = 1;
			DMSB_Hook_ToggleSpellbook();
			DEFAULT_CHAT_FRAME:AddMessage(DMSB_TEXT.ReplaceOn, 1, 1, 0);
		end
	elseif (string.find(msg, "scale")) then
		local _,_,scale = string.find(msg, ' (%d*)');
		scale = tonumber(scale);
		if (scale and scale >=1 and scale <= 200) then
			DMSB_Settings.scale = scale / 100;
			DiscordMiniSpellbookFrame:SetScale(DMSB_Settings.scale);
			local text = string.gsub(DMSB_TEXT.ScaleSet, "$n", scale);
			DEFAULT_CHAT_FRAME:AddMessage(text, 1, 1, 0);
		else
			for _, line in DMSB_HELPTEXT do
				DEFAULT_CHAT_FRAME:AddMessage(line, 1, 1, 0);
			end
		end
	elseif (msg == "drag") then
		if (DMSB_Settings.locked) then
			DMSB_Settings.locked = nil;
			DEFAULT_CHAT_FRAME:AddMessage(DMSB_TEXT.DragUnlocked, 1, 1, 0);
		else
			DMSB_Settings.locked = 1;
			DEFAULT_CHAT_FRAME:AddMessage(DMSB_TEXT.DragLocked, 1, 1, 0);
		end
	elseif (msg == "reset") then
		DiscordMiniSpellbookFrame:ClearAllPoints();
		DiscordMiniSpellbookFrame:SetPoint("CENTER", UIParent, "CENTER", 0, 0);
		DEFAULT_CHAT_FRAME:AddMessage(DMSB_TEXT.Reset, 1, 1, 0);
		DMSB_Update_Tabs();
	elseif (msg == "selfcast") then
		if (DMSB_Settings.selfcast) then
			DMSB_Settings.selfcast = nil;
			DEFAULT_CHAT_FRAME:AddMessage(DMSB_TEXT.SelfCastOff, 1, 1, 0);
		else
			DMSB_Settings.selfcast = 1;
			DEFAULT_CHAT_FRAME:AddMessage(DMSB_TEXT.SelfCastOn, 1, 1, 0);
		end
	elseif (msg == "tabs") then
		DMSB_Toggle_Tabs();
	else
		for _, line in DMSB_HELPTEXT do
			DEFAULT_CHAT_FRAME:AddMessage(line, 1, 1, 0);
		end
	end
end

function DMSB_SpellButton_OnClick(button, spellID, bookType)
	if (this.action) then
		PickupAction(this.action);
		DMSB_Update_SpellList();
		DMSB_ScrollFrame_Update();
		return;
	end
	if (bookType == DMSB_TEXT.Macro) then
		PickupMacro(spellID);
		return;
	end

	local old_SpellBook_GetSpellID = SpellBook_GetSpellID;
	SpellBook_GetSpellID = function(id) return id; end;
	local old_SpellButton_UpdateSelection = SpellButton_UpdateSelection;
	SpellButton_UpdateSelection = function() end;
	this:SetID(spellID);
	SpellBookFrame.bookType = bookType;
	local drag;
	if (button == "drag") then
		drag = 1;
	end
	SpellButton_OnClick(drag);

	SpellButton_UpdateSelection = old_SpellButton_UpdateSelection;
	SpellBook_GetSpellID = old_SpellBook_GetSpellID;

	if (DMSB_Settings.selfcast) then
		if (SpellIsTargeting()) then
			SpellTargetUnit("player");
		end
	end
	DMSB_ScrollFrame_Update();
end

function DMSB_SpellButton_OnEnter()
	GameTooltip:SetOwner(this:GetParent(), "ANCHOR_RIGHT");
	if (this.bookType == DMSB_TEXT.Macro) then
		local name, _, body = GetMacroInfo(this.spellID);
		local text = "|cFF00FF00"..name.."\n\n|cFFFFFFFF"..body;
		GameTooltip:SetText(text, 1, 1, 1, 1, 1);
		GameTooltip:AddLine("\n");
		GameTooltip:AddLine(DMSB_TEXT.MacroID.." "..this.spellID, .6, .6, .6);
		GameTooltip:SetHeight(GameTooltip:GetHeight() + 40);
		GameTooltip:Show();
	elseif (this.action) then
		if ( GetCVar("UberTooltips") == "1" ) then
			GameTooltip_SetDefaultAnchor(GameTooltip, this);
		else
			GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
		end
		if (GameTooltip:SetAction(this.action) ) then
			this.updateTooltip = TOOLTIP_UPDATE_TIME;
		else
			this.updateTooltip = nil;
		end
		GameTooltip:AddLine("\n");
		GameTooltip:AddLine("Action ID: "..this.action, .6, .6, .6);
		GameTooltip:SetHeight(GameTooltip:GetHeight() + 30);
	else
		if ( GameTooltip:SetSpell(this.spellID, this.bookType) ) then
			this.updateTooltip = TOOLTIP_UPDATE_TIME;
		else
			this.updateTooltip = nil;
		end
		GameTooltip:AddLine("\n");
		GameTooltip:AddLine(DMSB_TEXT.Book.." "..this.bookType, .6, .6, .6);
		GameTooltip:AddLine(DMSB_TEXT.SpellID.." "..this.spellID, .6, .6, .6);
		GameTooltipTextRight1:SetText(this.rankText);
		GameTooltipTextRight1:ClearAllPoints();
		GameTooltipTextRight1:SetPoint("TOPRIGHT", GameTooltip, "TOPRIGHT", -10, -10);
		GameTooltipTextRight1:SetTextColor(.6, .6, .6);
		GameTooltipTextRight1:Show();
		GameTooltip:SetHeight(GameTooltip:GetHeight() + 40);
	end
end

function DMSB_SpellButton_OnEvent(event)
	if (not DMSB_INITIALIZED) then return; end
	if (event == "SPELL_UPDATE_COOLDOWN") then
		DMSB_SpellButton_UpdateCooldown(this);
	end
end

function DMSB_SpellButton_OnUpdate(elapsed)
	if (not DMSB_INITIALIZED) then return; end
	if (this.cooldowncount) then
		this.cooldowncount = this.cooldowncount - elapsed;
		if (this.cooldowncount > 0) then
			local sec = math.ceil(this.cooldowncount);
			if (sec > 60) then
				sec = math.ceil(this.cooldowncount / 60).."m";
			end
			getglobal(this:GetName().."_CooldownCount"):SetText(sec);
		else
			this.cooldowncount = nil;
			getglobal(this:GetName().."_CooldownCount"):SetText("");
		end
	end
	if ( not this.updateTooltip ) then
		return;
	end
	this.updateTooltip = this.updateTooltip - elapsed;
	if ( this.updateTooltip > 0 ) then
		return;
	end
	if ( GameTooltip:IsOwned(this) ) then
		DMSB_SpellButton_OnEnter();
	else
		this.updateTooltip = nil;
	end
end

function DMSB_SpellButton_UpdateCooldown(button)
	if (not button.spellID) then return; end
	local start, duration, enable;
	if (button.bookType == DMSB_TEXT.Macro) then
		button.cooldowncount = 0;
		CooldownFrame_SetTimer(getglobal(button:GetName().."_Cooldown"), GetTime(), 0, 0);
		return;
	elseif (button.action) then
		start, duration, enable = GetActionCooldown(button.action);
	else
		start, duration, enable = GetSpellCooldown(button.spellID, button.bookType);
	end
	CooldownFrame_SetTimer(getglobal(button:GetName().."_Cooldown"), start, duration, enable);
	if (start and start > 0) then
		button.cooldowncount = duration - (GetTime() - start);
	else
		button.cooldowncount = 0;
	end
end

function DMSB_Toggle_Spellbook()
	if (DiscordMiniSpellbookFrame:IsVisible()) then
		DiscordMiniSpellbookFrame:Hide();
	else
		DiscordMiniSpellbookFrame:Show();
	end
end

function DMSB_TabButton_OnClick(tab)
	getglobal("DMSB_TabButton_"..DiscordMiniSpellbookFrame.selectedTab):SetBackdropColor(0, 0, 0);
	getglobal("DMSB_TabButton_"..DiscordMiniSpellbookFrame.selectedTab.."_Name"):SetTextColor(1, 1, 0);
	DiscordMiniSpellbookFrame.selectedTab = tab;
	if (tab == 0) then
		DiscordMiniSpellbookFrame_SelectedTab:SetText(DMSB_TEXT.All);
	elseif (tab == 5) then
		DiscordMiniSpellbookFrame_SelectedTab:SetText(DMSB_TEXT.Pet);
	elseif (tab == 6) then
		DiscordMiniSpellbookFrame_SelectedTab:SetText(DMSB_TEXT.Macros);
	elseif (tab == 7) then
		DiscordMiniSpellbookFrame_SelectedTab:SetText(DMSB_TEXT.Actions);
	else
		DiscordMiniSpellbookFrame_SelectedTab:SetText(GetSpellTabInfo(tab));
	end
	DMSB_Update_SpellList();
	DMSB_ScrollFrame_Update();
	this:SetBackdropColor(1, 1, 0);
	getglobal(this:GetName().."_Name"):SetTextColor(1, 0, 0);
end

function DMSB_Update_SpellList()
	DiscordMiniSpellbookFrame.updateSpells = nil;
	DMSB_SPELL_LIST = {};

	local start, finish = 1, GetNumSpellTabs();
	if (DiscordMiniSpellbookFrame.selectedTab > 0) then
		start, finish = DiscordMiniSpellbookFrame.selectedTab, DiscordMiniSpellbookFrame.selectedTab;
	end

	if (DiscordMiniSpellbookFrame.selectedTab < 7) then
		for tab=start, finish do
			local tabName, _, offset, numSpells = GetSpellTabInfo(tab);
			for spellID=offset + 1, offset + numSpells do
				local spellName, spellRank = GetSpellName(spellID, BOOKTYPE_SPELL);
				local found;
				for num, val in DMSB_SPELL_LIST do
					if (val.name == spellName) then
						found = num;
						break;
					end
				end
				if (found) then
					local index = table.getn(DMSB_SPELL_LIST[found].ranks) + 1;
					DMSB_SPELL_LIST[found].ranks[index] = spellID;
					DMSB_SPELL_LIST[found].rankText[index] = spellRank;
				else
					local index = table.getn(DMSB_SPELL_LIST) + 1;
					DMSB_SPELL_LIST[index] = { name=spellName, ranks={}, rankText={spellRank}, bookType=BOOKTYPE_SPELL, tab=tabName };
					DMSB_SPELL_LIST[index].ranks[1] = spellID;
				end
			end
		end
	end

	if (DiscordMiniSpellbookFrame.selectedTab == 0 or DiscordMiniSpellbookFrame.selectedTab == 5) then
		local hasPetSpells, petToken = HasPetSpells();
		if (hasPetSpells) then
			local tabName = getglobal("PET_TYPE_"..petToken);
			local spellID = 0;
			while (true) do
				spellID = spellID + 1;
				local spellName, spellRank = GetSpellName(spellID, BOOKTYPE_PET);
				if (not spellName) then
					break;
				end
				local found;
				for num, val in DMSB_SPELL_LIST do
					if (val.name == spellName) then
						found = num;
						break;
					end
				end
				if (found) then
					local index = table.getn(DMSB_SPELL_LIST[found].ranks) + 1;
					DMSB_SPELL_LIST[found].ranks[index] = spellID;
				else
					local index = table.getn(DMSB_SPELL_LIST) + 1;
					DMSB_SPELL_LIST[index] = { name=spellName, ranks={}, rankText={spellRank}, bookType=BOOKTYPE_PET, tab=tabName };
					DMSB_SPELL_LIST[index].ranks[1] = spellID;
				end
			end
		end
	end

	if (DiscordMiniSpellbookFrame.selectedTab == 0 or DiscordMiniSpellbookFrame.selectedTab == 6) then
		local base, character = GetNumMacros();
		for i=1, base do
			local index = table.getn(DMSB_SPELL_LIST) + 1;
			DMSB_SPELL_LIST[index] = { name=GetMacroInfo(i), ranks={}, rankText={""}, bookType=DMSB_TEXT.Macro, tab=DMSB_TEXT.Macro };
			DMSB_SPELL_LIST[index].ranks[1] = i;
		end
		for i=19, 18 + character do
			local index = table.getn(DMSB_SPELL_LIST) + 1;
			DMSB_SPELL_LIST[index] = { name=GetMacroInfo(i), ranks={}, rankText={""}, bookType=DMSB_TEXT.Macro, tab=DMSB_TEXT.Macro };
			DMSB_SPELL_LIST[index].ranks[1] = i;
		end
	end

	if (DiscordMiniSpellbookFrame.selectedTab == 7) then
		for i=1,120 do
			local name = DMP_Get_ActionName(i);
			if (name == "") then
				name = "|cFF999999< No Action >";
			end
			DMSB_SPELL_LIST[i] = { name=name, bookType=DMSB_TEXT.Action, tab=DMSB_TEXT.Action, action=i };
		end
	end

	if (DiscordMiniSpellbookFrame.selectedTab == 0) then
		DMSB_SPELL_LIST = DMP_Sort(DMSB_SPELL_LIST, "name");
	end
end

function DMSB_Update_Tabs()
	local tabBase = "DMSB_TabButton_";
	local numTabs = GetNumSpellTabs();
	local tabButton;
	local highWidth = 40;
	for tab=1, 4 do
		tabButton = getglobal(tabBase..tab);
		if (tab <= numTabs) then
			tabButton:Show();
			tabButton:ClearAllPoints();
			tabButton:SetPoint("TOP", tabBase..(tab - 1), "BOTTOM", 0, 15);
			local tabName, texture = GetSpellTabInfo(tab);
			local height = 70;
			if (string.find(tabName, " ")) then
				tabName = string.gsub(tabName, " ", "\n");
				height = 80;
			end
			tabButton:SetHeight(height);
			getglobal(tabBase..tab.."_Icon"):SetTexture(texture);
			getglobal(tabBase..tab.."_Name"):SetText(tabName);
			local width = getglobal(tabBase..tab.."_Name"):GetWidth();
			if (width > highWidth) then
				highWidth = width;
			end
		else
			tabButton:Hide();
		end
	end
	for tab=0,7 do
		getglobal(tabBase..tab):SetWidth(highWidth + 20);
	end
	if (HasPetSpells()) then
		DMSB_TabButton_5:Show();
		DMSB_TabButton_5:ClearAllPoints();
		DMSB_TabButton_5:SetPoint("TOP", tabBase..numTabs, "BOTTOM", 0, 15);
	else
		DMSB_TabButton_5:Hide();
	end
	if (DMSB_Settings.hideTabs) then
		for tab = 0, 7 do
			getglobal("DMSB_TabButton_"..tab):Hide();
		end
	else
		DMSB_TabButton_0:Show();
		DMSB_TabButton_6:Show();
		DMSB_TabButton_7:Show();
		local center = UIParent:GetCenter();
		local loc = DiscordMiniSpellbookFrame:GetCenter();
		if (loc / DiscordMiniSpellbookFrame:GetScale() * UIParent:GetScale() <= center) then
			DMSB_TabButton_0:ClearAllPoints();
			DMSB_TabButton_0:SetPoint("TOPLEFT", DiscordMiniSpellbookFrame, "TOPRIGHT", -15, 0);
		else
			DMSB_TabButton_0:ClearAllPoints();
			DMSB_TabButton_0:SetPoint("TOPRIGHT", DiscordMiniSpellbookFrame, "TOPLEFT", 15, 0);
		end
		DMSB_TabButton_6:ClearAllPoints();
		if (HasPetSpells()) then
			DMSB_TabButton_6:SetPoint("TOP", DMSB_TabButton_5, "BOTTOM", 0, 15);
		else
			DMSB_TabButton_6:SetPoint("TOP", tabBase..numTabs, "BOTTOM", 0, 15);
		end
		DMSB_TabButton_7:ClearAllPoints();
		DMSB_TabButton_7:SetPoint("TOP", DMSB_TabButton_6, "BOTTOM", 0, 15);
	end
end
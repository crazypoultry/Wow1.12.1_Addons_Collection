EDB_VERSION = "2.2.2";
EDB_ItemTypeList = {"All", "Boots", "Bracer", "Chest", "Cloak", "Gloves", "Shield", "Weapon", "2H Weapon", "Oil", "Wand", "Rod", "Other"};
EDB_BonusTypeList = {"All", "Agility", "Intelligence", "Spirit", "Stamina", "Strength", "Damage", "Resistance", "Stats", "Proc", "Item", "Other"};
EDB_LearnedFrom = {"Trainer", "Vendor", "Drop"};

-- Color matrix
EDB_Colors = { };
EDB_Colors.Highlight = { 1.00, 1.00, 1.00 };
EDB_Colors.Normal    = { 1.00, 0.82, 0.00 };
EDB_Colors.Red       = { 1.00, 0.00, 0.00 };
EDB_Colors.Orange    = { 1.00, 0.50, 0.25 };
EDB_Colors.Yellow    = { 1.00, 1.00, 0.00 };
EDB_Colors.Green     = { 0.25, 0.75, 0.25 };
EDB_Colors.Grey      = { 0.50, 0.50, 0.50 };
EDB_Colors.Pink		 = { 1.00, 0.00, 1.00 };
EDB_Colors.difficulty = {[-1] = EDB_Colors.Pink,
						  [0] = EDB_Colors.Grey,
						  [1] = EDB_Colors.Green,
						  [2] = EDB_Colors.Yellow,
						  [3] = EDB_Colors.Orange,
						  [4] = EDB_Colors.Red};

EDB_Colors.Money = { };
EDB_Colors.Money.Gold   = { 0.80, 0.70, 0.25 };
EDB_Colors.Money.Silver = { 0.90, 0.90, 1.00 };
EDB_Colors.Money.Copper = { 0.70, 0.45, 0.20 };

--------------[[ GLOBAL FUNCTIONS ]]--------------

function EDB_OnLoad()

	SlashCmdList["ENCHANTINGDB"] = EDB_Command;
	SLASH_ENCHANTINGDB1 = "/enchantingdb";
	SLASH_ENCHANTINGDB2 = "/edb";

	-- Register for events
	EDB_Core:RegisterEvent("VARIABLES_LOADED");
	EDB_Core:RegisterEvent("BANKFRAME_OPENED");
	EDB_Core:RegisterEvent("BANKFRAME_CLOSED");
	EDB_Core:RegisterEvent("BAG_UPDATE");

	EDB_Formula_Setup();
	EDB_ReagentIcon_Build();

	-- Set up variables
	EDB_Core.updateFreq = 2;
	EDB_Core.timeSinceUpdate = 0;

end

function EDB_OnEvent()

	if ( event == "VARIABLES_LOADED" ) then
	
		EDB_Config_Build();
		EDB_Frame_Enchant_EnchantList_Build();
		EDB_Frame_Enchant_EnchantList_Update();
		EDB_Frame_Reagent_ReagentList_Update();
		EDB_MinimapButton:SetPoint("CENTER", "Minimap", "CENTER", EDB_Config.minimapbuttonx or 0, EDB_Config.minimapbuttony or -80);
		if EDB_Config.showMinimapButton then
			EDB_MinimapButton:Show();
		else
			EDB_MinimapButton:Hide();
		end
		
	end

	if ( event == "BAG_UPDATE" ) then
		EDB_Core.bagUpdate = true;
	end

	if ( event == "BANKFRAME_OPENED" ) then
		EDB_Core.bankOpen = true;
		EDB_Core.bankUpdate = true;
	end

	if ( event == "BANKFRAME_CLOSED" ) then
		EDB_Core.bankOpen = false;
		EDB_Core.bankUpdate = nil;
	end

end

function EDB_OnUpdate(elapsed)

	EDB_Core.timeSinceUpdate = EDB_Core.timeSinceUpdate + elapsed;

	if ( EDB_Core.timeSinceUpdate > EDB_Core.updateFreq ) then

		EDB_Core.timeSinceUpdate = 0;

		if ( EDB_Core.bankUpdate ) then

			EDB_Core.bankUpdate = nil;

			EDB_UpdateItemCountInBank();
			
			EDB_Frame_Reagent_ReagentList_Update();

		end

		if ( EDB_Core.bagUpdate ) then

			EDB_Core.bagUpdate = nil;

			EDB_UpdateItemCountInBags();

			if ( EDB_Core.bankOpen ) then
				EDB_UpdateItemCountInBank();
			end

			EDB_Frame_Enchant_EnchantList_CountUpdate();
			EDB_Frame_Enchant_EnchantList_Update();
			EDB_Frame_Enchant_ReagentList_Build();
			EDB_Frame_Enchant_ReagentList_Update();
			EDB_Frame_Enchant_EnchantButton_Update();
			EDB_Frame_Reagent_ReagentList_Update();

		end

	end

end

function EDB_Command(cmd)

	if ( not cmd ) or ( cmd == "" ) then
		EDB_Toggle();
	end

	cmd = strlower(cmd);

	if ( cmd == "show" ) then
		EDB_Show();
	elseif ( cmd == "hide" ) then
		EDB_Hide();
	elseif ( cmd == "toggle" ) then
		EDB_Toggle();
	else
		local _, _, com, arg = string.find(cmd, "(.+) (.+)");
		if ( com == "link" ) then
			local id = GetTradeSkillSelectionIndex();
			SendChatMessage("Mats for "..GetTradeSkillItemLink(id)..":", "WHISPER", GetDefaultLanguage("player"), arg);
			for i = 1, GetTradeSkillNumReagents(id) do
				local _, _, count = GetTradeSkillReagentInfo(id, i);
				local link = GetTradeSkillReagentItemLink(id, i);
				SendChatMessage(count.."x"..link, "WHISPER", GetDefaultLanguage("player"), arg);
			end
		end
	end

end

function EDB_Config_Build()

	if ( not EDB_Config ) then
		EDB_Config = {};
	end

	-- If true will add a [n] in front of enchant names you have mats for
	if ( not EDB_Config.countTag ) then
		EDB_Config.countTag = true;
	end

	-- If true will count banked reagents for enchants you can do
	if ( not EDB_Config.countBank ) then
		EDB_Config.countBank = false;
	end

	-- If true will get value info from auction addons
	if ( not EDB_Config.useAuctionAddons ) then
		EDB_Config.useAuctionAddons = true;
	end
	
	-- Set the markup to apply to enchants
	if ( not EDB_Config.markup ) then
		EDB_Config.markup = 0.2;
	end

end

--------------[[ UI FUNCTIONS ]]--------------

function EDB_Show()
	if ( not EDB_Frame:IsVisible() ) then
		ShowUIPanel(EDB_Frame);
	end
end

function EDB_Hide()
	if ( EDB_Frame:IsVisible() ) then
		HideUIPanel(EDB_Frame);
	end
end

function EDB_Toggle()
	if ( EDB_Frame:IsVisible() ) then
		HideUIPanel(EDB_Frame);
	else
		ShowUIPanel(EDB_Frame);
	end
end

function EDB_MinimapButton_OnUpdate()

	if this.isMoving then
		local mouseX, mouseY = GetCursorPosition();
		local centerX, centerY = Minimap:GetCenter();
		local scale = Minimap:GetEffectiveScale();
		mouseX = mouseX / scale;
		mouseY = mouseY / scale;
		local radius = (Minimap:GetWidth()/2) + (this:GetWidth()/3);
		local x = math.abs(mouseX - centerX);
		local y = math.abs(mouseY - centerY);
		local xSign = 1;
		local ySign = 1;
		if not (mouseX >= centerX) then
			xSign = -1;
		end
		if not (mouseY >= centerY) then
			ySign = -1;
		end
		local angle = math.atan(x/y);
		x = math.sin(angle)*radius;
		y = math.cos(angle)*radius;
		this.x = xSign*x;
		this.y = ySign*y;
		this:SetPoint("CENTER", "Minimap", "CENTER", this.x, this.y);
	end

end

function EDB_Money_SetText(name, value)

	local gold, silver, copper;
	local gstr, sstr, cstr
	local frame = getglobal(name);

	if ( value ) then
		frame.value = value;
	end

	gold = floor( frame.value / 10000 );
	silver = floor( (frame.value - (gold * 10000)) / 100 );
	copper = frame.value - (gold * 10000) - (silver * 100);

	gstr = ""..gold;
	sstr = ""..silver;
	cstr = ""..copper;

	if ( gold > 0 ) then

		if ( silver < 10 ) then
			sstr = "0"..sstr;
		end

		if ( copper < 10 ) then
			cstr = "0"..cstr;
		end

	else

		gstr = "";

		if ( silver > 0 ) then

			if ( copper < 10 ) then
				cstr = "0"..cstr;
			end

		else

			sstr = "";

		end

	end

	getglobal(name.."_Gold"):SetText(gstr);
	getglobal(name.."_Silver"):SetText(sstr);
	getglobal(name.."_Copper"):SetText(cstr);

end

--[[-------------------------------------------------------------
Addon to allow use and summoning of mana gems from titan panel.
Developer: Patrick Wall
-------------------------------------------------------------]]--

-- Variables
local RubyLoc = {nil,nil};
local CitrineLoc = {nil,nil};
local JadeLoc = {nil,nil};
local AgateLoc = {nil,nil};
local CurrentGems={0,0,0,0};

-- Constructor
function TitanPanelmanaGemMenuButton_OnLoad()
	SLASH_MANAGEM1 = "/managem";
	SlashCmdList["MANAGEM"] = ManaGemCommand;
	
	ManaGemFindGems();
	
	--Create Titan Object
	this.registry = {
		id = TITAN_MANAGEM_ID,
		menuText = TITAN_MANAGEM_MENUTEXT,
		icon = TITAN_MANAGEM_ICON,
		iconWidth = 16,
		buttonTextFunction = "TitanPanelManaGemMenuButton_GetButtonText",
		tooltipTitle = TITAN_MANAGEM_TOOLTIPTITLE,
		tooltipTextFunction = "TitanPanelManaGemMenuButton_GetTooltipText",
		frequency = 1,
		savedVariables = {
			ShowLabel = 1,
			ShowIcon = 1,
		}
	};
end

-- slash commands
function ManaGemCommand(cmd)
	local gem = "";
	
	if (cmd == TITAN_MANAGEM_HELPCOMMAND or cmd == "") then
		ManaGemOutput(TITAN_MANAGEM_HELP1);
		ManaGemOutput(TITAN_MANAGEM_HELP2);
		ManaGemOutput(TITAN_MANAGEM_HELP3);
		ManaGemOutput(TITAN_MANAGEM_HELP4);
	elseif (cmd == TITAN_MANAGEM_SUMMONCOMMAND) then
		gem = ManaGemSummonGem()
		if (gem ~= nil) then
			ManaGemOutput(TITAN_MANAGEM_SUMMONGEM .. gem);
		else
			ManaGemOutput(TITAN_MANAGEM_SUMMONGEMFAIL);
		end
	elseif (cmd == TITAN_MANAGEM_USECOMMAND) then
		gem = ManaGemUseGem()
		if (gem ~= nil) then
			ManaGemOutput(TITAN_MANAGEM_USEGEM .. gem);
		else
			ManaGemOutput(TITAN_MANAGEM_USEGEMFAIL);
		end
	end
end

-- Menu text
function TitanPanelManaGemMenuButton_GetButtonText(id)
	ManaGemFindGems();
	return CurrentGems[0] .. "/" .. CurrentGems[1] .. "/" .. CurrentGems[2] .. "/"..CurrentGems[3];
end

-- click catcher
function TitanPanelManaGemButton_OnClick(button)
	if (IsShiftKeyDown() and button == "LeftButton") then
		ManaGemSummonGem();
	elseif (button == "LeftButton") then
		ManaGemUseGem();
	end
end

-- right click
function TitanPanelRightClickMenu_PrepareManaGemMenuMenu()
	TitanPanelRightClickMenu_AddTitle(TITAN_MANAGEM_MENUTEXT);
	TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, "ManaGemMenu", TITAN_PANEL_MENU_FUNC_HIDE);
end

-- Find all the Gems and put in a list
function ManaGemFindGems()
	CurrentGems[0] = 0;
	CurrentGems[1] = 0;
	CurrentGems[2] = 0;
	CurrentGems[3] = 0;
	
	for bag = 0, NUM_BAG_FRAMES do
		for slot = 1, GetContainerNumSlots(bag) do
			itemLink = GetContainerItemLink(bag, slot)
			if (itemLink) then
				if (string.find(itemLink, TITAN_MANAGEM_RUBY)) then
					RubyLoc[0] = bag
					RubyLoc[1] = slot;
					CurrentGems[0] = 1;
				elseif (string.find(itemLink, TITAN_MANAGEM_CITRINE)) then
					CitrineLoc[0] = bag
					CitrineLoc[1] = slot;
					CurrentGems[1] = 1;
				elseif (string.find(itemLink, TITAN_MANAGEM_JADE)) then
					JadeLoc[0] = bag
					JadeLoc[1] = slot;
					CurrentGems[2] = 1;
				elseif (string.find(itemLink, TITAN_MANAGEM_AGATE)) then
					AgateLoc[0] = bag
					AgateLoc[1] = slot;
					CurrentGems[3] = 1;
				end
			end
		end
	end
end

-- Summon a Gem
function ManaGemSummonGem()
	ManaGemFindGems();
	
	if (CurrentGems[0] == 0 and HasSpell(TITAN_MANAGEM_SUMMONRUBY)) then
		CastSpellByName(TITAN_MANAGEM_SUMMONRUBY);
		return TITAN_MANAGEM_RUBY;
	elseif (CurrentGems[1] == 0 and HasSpell(TITAN_MANAGEM_SUMMONCITRINE)) then
		CastSpellByName(TITAN_MANAGEM_SUMMONCITRINE);
		return TITAN_MANAGEM_CITRINE;
	elseif (CurrentGems[2] == 0 and HasSpell(TITAN_MANAGEM_SUMMONJADE)) then
		CastSpellByName(TITAN_MANAGEM_SUMMONJADE);
		return TITAN_MANAGEM_JADE;
	elseif (CurrentGems[3] == 0 and HasSpell(TITAN_MANAGEM_SUMMONAGATE)) then
		CastSpellByName(TITAN_MANAGEM_SUMMONAGATE);
		return TITAN_MANAGEM_AGATE;
	end
end

-- Use a Gem
function ManaGemUseGem()
	ManaGemFindGems();
	
	if (CurrentGems[0] == 1) then
		UseContainerItem(RubyLoc[0], RubyLoc[1]);
		return TITAN_MANAGEM_RUBY;
	elseif (CurrentGems[1] == 1) then
		UseContainerItem(CitrineLoc[0], CitrineLoc[1]);
		return TITAN_MANAGEM_CITRINE;
	elseif (CurrentGems[2] == 1) then
		UseContainerItem(JadeLoc[0], JadeLoc[1]);
		return TITAN_MANAGEM_JADE;
	elseif (CurrentGems[3] == 1) then
		UseContainerItem(AgateLoc[0], AgateLoc[1]);
		return TITAN_MANAGEM_AGATE;
	end
end

-- Standard Output
function ManaGemOutput(message)
	local r, g, b, a = DEFAULT_CHAT_FRAME:GetTextColor();
	
	DEFAULT_CHAT_FRAME:SetTextColor(TITAN_MANAGEM_RED, TITAN_MANAGEM_GREEN, TITAN_MANAGEM_BLUE, TITAN_MANAGEM_ALPHA);
	DEFAULT_CHAT_FRAME:AddMessage(TITAN_MANAGEM_MENUTEXT .. ": " .. message);
	
	-- reset font color
	DEFAULT_CHAT_FRAME:SetTextColor(r, g, b, a);
end

--  Check if player has a spell, taken from ManaGems Addon
function HasSpell(name)
	local i = 1;
	while true do
		local spellName, spellRank = GetSpellName(i, BOOKTYPE_SPELL);
		if not spellName then
			do break; end
		end
		if(spellName == name) then
			return true;
		end
		i = i + 1;
	end
	return false;
end
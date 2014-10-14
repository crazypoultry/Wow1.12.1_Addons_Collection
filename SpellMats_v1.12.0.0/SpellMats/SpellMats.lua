--------------------------------------------------------------------------
-- SpellMats.lua
--------------------------------------------------------------------------
--[[
SpellMats

author: <zespri@mail.ru>

-- Displays on action bar how many times a spell that requires reagents can be cast before reagents run out.

--]]--

-- Persistent addon data
SpellMats_Data = {};
-- The list of reagents used for spell along with their respective thresholds when it's displayed in yellow or red
SpellMats_Data.Reagents = {};

-- Is reagen count enabled?
SpellMats_Data.enabled = true;

-- Is fast update mode enabled?
SpellMats_Data.fastUpdate = false;

SpellMats_UpdateEnabled = false;

-- This table contians individual bar mods registrations, that are supported
SpellMats_Bars = {};

-- This table contians buttons that have spell requiring a reagent
SpellMats_ActiveButtons = {};

-- Register certain bar mod support
function SpellMats_RegisterBarSupport(name, hookUnhookFunction, refreshCountButtonsFunction)
	SpellMats_Bars[name] = {};
	SpellMats_Bars[name].HookUnhook = hookUnhookFunction;
	SpellMats_Bars[name].RefreshCountButtons = refreshCountButtonsFunction;
end

-- Default thresholds before user configured them manualy
local SpellMats_YellowDefault = 10;
local SpellMats_RedDefault = 5;

function SpellMats_OnLoad()
	-- When the number of reafent in the bags changes BAG_UPDATE event fires
	this:RegisterEvent("BAG_UPDATE");
	this:RegisterEvent("PLAYER_LOGIN");

	-- After 10.1 blizzard started spamming events while zoning
	-- to spead up zoning time we stop processing events while we are zoning
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("PLAYER_LEAVING_WORLD");

	if (Khaos and SpellMats_Register_Khaos) then
		SpellMats_Register_Khaos()
	end

	SpellMats_RegisterChatCommands();
end

function SpellMats_OnEvent()
	if event == "PLAYER_LOGIN" then
		SpellMats_Toggle(SpellMats_Data.enabled);
	end

	if event == "PLAYER_ENTERING_WORLD" then
		SpellMats_UpdateEnabled = true;
	end

	if event == "PLAYER_LEAVING_WORLD" then
		SpellMats_UpdateEnabled = false;
	end

	if not SpellMats_UpdateEnabled then
		return;
	end

	if event == "BAG_UPDATE" then
		-- in fast update mode we only update several buttons that
		-- we know have reagant counts on them. This is to reduce
		-- stutter. However FastUpdate mode doesn't keep track of
		-- dragged spells. Please read reasme.txt for a fuller
		-- discussion
		if (SpellMats_Data.fastUpdate) then
			SpellMats_FastRefreshCountButtons();
		else
			SpellMats_RefreshCountButtons();
		end
	end
end

function SpellMats_Toggle(enable)
	-- Hook/unhook functions for every bar mod
	for _, barSupport in pairs(SpellMats_Bars) do
		if barSupport.HookUnhook then
			barSupport.HookUnhook(enable);
		end
	end

	-- Update UI
	SpellMats_RefreshCountButtons();
end

-- please read readme.txt for informnation on how fast update option works
function SpellMats_ToggleFastUpdate(enable)
	if (enable) then
		SpellMats_Data.fastUpdate = true;
	else
		SpellMats_Data.fastUpdate = false;
	end;
	SpellMats_RefreshCountButtons();
end

function SpellMats_HookUnhook(enable)
	-- When it's hidden no event's are coming, so we don't use processor time when we don't have to
	-- The hooks are there so that standart code that writes numbers in the bottom left corner of an action
	-- button doesn't overwrite what we have written there.
	if (enable) then
		Sea.util.hook("ActionButton_UpdateCount", "SpellMats_ActionButton_UpdateCount", "after");
		SpellMats_Data.enabled = true;
		this:Show();
	else
		Sea.util.unhook("ActionButton_UpdateCount", "SpellMats_ActionButton_UpdateCount", "after");
		SpellMats_Data.enabled = false;
		this:Hide();
	end;
end

-- This hook makes sure that if standard Blizzard UI overwrites our counts we write them back
function SpellMats_ActionButton_UpdateCount()
	SpellMats_UpdateCountAfterHandler(getglobal(this:GetName().."Count"), ActionButton_GetPagedID(this));
end

-- Given counter control and pagedId of the button check if this button is elidgible for
-- displaying our counter, and if so, display one. Note: this is only called in hooks to
-- different sort of CountUpdate handlers
function SpellMats_UpdateCountAfterHandler(text, pagedId)
	if (not text:GetText()) then
		local count, reagent = SpellMats_GetActionCount(pagedId);
		if ( reagent ) then
			SpellMats_SetReagentCount(text, count, reagent);
		end
	end
end

-- This function return reagent count and reagen name for a given button. If a button doean't contain spell,
-- which dpends on a reagent it returns 0, nil. The function goes through tooltip for the action button
-- and looks if the action requires a reagent. If yes, the functions check begs to find out the total
-- number of this reagent availiable and reutns result.
function SpellMats_GetActionCount(pagedid)

	-- Sometimes this function failed on load because SpellMatsTooltip wasn't initialized yet
	if (not SpellMatsTooltip) then
		return 0;
	end;


	-- I have no idea I but DAB seem somehow to screw up 'this' piointer when reacting on the
	-- SetAction event. I don't really understand the nature of this occurance, nor I have time
	-- to investigate why it's happening. So I just preserve the value before, and then restore it
	-- after
	local oldThis = this;
	SpellMatsTooltip:SetOwner(SpellMatsTooltip, "ANCHOR_NONE");
	SpellMatsTooltip:SetAction(pagedid);
	this = oldThis;

	-- for all tooltip lines
	for index = 1, 30, 1 do
		field = getglobal("SpellMatsTooltipTextLeft"..index);
		if( field ) then
			text = field:GetText();
			if( text ) then
				-- this is supposed to be locale independent
				if (string.sub(text, 1, string.len(SPELL_REAGENTS)) == SPELL_REAGENTS) then

					local iStart, iEnd, reagent;
					local result = nil;
					local index = 0;
					local reagentsString = "," .. string.sub(text,string.len(SPELL_REAGENTS),string.len(text));
					local resultReagent;

					-- Intention of this loop is to select reagent with minimum count if a spell require
					-- more then one reagent. In reality there are no spells that require more then one
					-- reagen as of now, so it's kind of useless
					repeat
						-- more precise regex not always work for specal caracters such as
						-- umlauts and accents. this one seems to work fine always
						iStart, iEnd, reagent = string.find(reagentsString,",%s*(.*)",index);
						if (iEnd) then
							-- If player ran out of the reagaent it will be displayed in red,
							-- so we need to strip out the colour codes
							_,_,reagent_ = string.find(reagent,"|c%x+(.*)|r",index);
							reagent = reagent_ or reagent;

							index = iEnd + 1;

							-- Here if we don't have a record for the reagent yet, we create one
							if (not SpellMats_Data.Reagents[reagent]) then
								SpellMats_Data.Reagents[reagent] = {};
								SpellMats_Data.Reagents[reagent].yellow = SpellMats_YellowDefault;
								SpellMats_Data.Reagents[reagent].red = SpellMats_RedDefault;
							end

			                                -- Get reagent count from bags
			                                local count = SpellMats_GetReagentCount(reagent);

							-- Select minimum value
							if ((not result) or (count < result)) then
								resultReagent = reagent;
								result = count;
							end;
						end;
					until not reagent;

					if (not result) then
						result = 0;
					end;

					return result, resultReagent;
				end
			end
		end
	end
	return 0;
end

-- Returns name of the item that is resides in given bag at given slot.
function SpellMats_GetItemName(bag, slot)
	local linktext  = GetContainerItemLink(bag, slot);

	if linktext then
		local _,_,name = string.find(linktext, "^.*%[(.*)%].*$");
		return name;
	end;
	return "";
end;

-- Iterates through the bags and counts how many copies of a given item we have
function SpellMats_GetReagentCount(reagent)
	local result = 0;

	for bag = 0, 4, 1 do
		for slot = 1, GetContainerNumSlots(bag), 1 do
			local name = SpellMats_GetItemName(bag, slot);
			if (name == reagent) then
				local _, itemCount = GetContainerItemInfo(bag, slot);
				result = result + itemCount;
			end
		end
	end

	return result;
end


-- The code below is to refresh counters on all buttons

-- Here is the list of all buttons we know about
SpellMats_Buttons =
{
  {name = "ActionButton"; start = 1; stop = 12;};
  {name = "BonusActionButton"; start = 1; stop = 12;};
  {name = "MultiBarBottomLeftButton"; start = 1; stop = 12;};
  {name = "MultiBarBottomRightButton"; start = 1; stop = 12;};
  {name = "MultiBarRightButton"; start = 1; stop = 12;};
  {name = "MultiBarLeftButton"; start = 1; stop = 12;};
}

-- Update counters for each supported bar mod
function SpellMats_RefreshCountButtons()
	SpellMats_ActiveButtons = {};
	for _, barSupport in pairs(SpellMats_Bars) do
		if barSupport.RefreshCountButtons then
			barSupport.RefreshCountButtons();
		end
	end
end

-- Update only those buttons that were updated the last full update
function SpellMats_FastRefreshCountButtons()
	for text, pagedid in pairs(SpellMats_ActiveButtons) do
		SpellMats_UpdateCountButton(text, pagedid)
	end
end

-- Update standard Blizzard bars
function SpellMats_Standard_RefreshCountButtons()
	SpellMats_IterateButtonTable(SpellMats_Buttons, SpellMats_GetUpdateCountButtonArguments);
end

-- Iterate thtough all the buttons and update counters values
function SpellMats_IterateButtonTable(buttonTable, getUpdateCountButtonArguments)
	for _, value in pairs(buttonTable) do
		for index = value.start, value.stop, 1 do
			SpellMats_UpdateCountButton(getUpdateCountButtonArguments(value.name..index));
		end
	end
end

-- This function retrieve arguments for subsequent SpellMats_UpdateCountButton call
-- for standard Blizzard bars
function SpellMats_GetUpdateCountButtonArguments(buttonName)
	local text = getglobal(buttonName.."Count");
	local button = getglobal(buttonName);
	local pagedId = ActionButton_GetPagedID(button);
	return text, pagedId;
end

-- Update reagent count on a certain button
function SpellMats_UpdateCountButton(text, pagedId)

	if not text or not pagedId then
		return;
	end

	-- This is for 'normal' counts such as standard consumable item counts
	local count = GetActionCount(pagedId);
	if ( count > 1 ) then
		-- This is executed when there is count for 'normal' item
		text:SetText(count);
	else
		if (SpellMats_Data.enabled) then
			-- Check for spell reagents
			local count, reagent = SpellMats_GetActionCount(pagedId);
			-- Update if found
			if ( reagent ) then
				SpellMats_SetReagentCount(text, count, reagent);
				SpellMats_ActiveButtons[text] = pagedId;
			else
				text:SetText("");
			end
		else
			-- if the addon turned off just display nothing if it's not a 'normal' item
			text:SetText("");
		end
	end
end


-- This function print color coded reagent count on the button
function SpellMats_SetReagentCount(control, count, reagent)
	local red = RED_FONT_COLOR_CODE;
	local yel = LIGHTYELLOW_FONT_COLOR_CODE;
	local fin = FONT_COLOR_CODE_CLOSE;
	local reagentData = SpellMats_Data.Reagents[reagent];
	if (reagentData and (count <= reagentData.yellow or count <= reagentData.red)) then
		if (count <= reagentData.red) then
			control:SetText(red .. count .. fin);
		else
			control:SetText(yel .. count .. fin);
		end
	else
		control:SetText(count);
	end
end

SpellMats_RegisterBarSupport("Standard", SpellMats_HookUnhook, SpellMats_Standard_RefreshCountButtons);

----------------------------------------------
--Here goes the command-line interface support

function SpellMats_RegisterChatCommands()
	SLASH_SPELLMATS_HELP1 = "/spellmats";
	SLASH_SPELLMATS_HELP2 = "/sm";

	SlashCmdList["SPELLMATS_HELP"] = function(msg)
		SpellMats_PrintChatCommandHelp();
	end

	SLASH_SPELLMATS_TOGGLE1 = "/smt";
	SLASH_SPELLMATS_TOGGLE2 = "/smtoggle";

	SlashCmdList["SPELLMATS_TOGGLE"] = function(msg)
		SpellMats_SlashToggle(msg);
	end

	SLASH_SPELLMATS_LIMITS1 = "/sml";
	SLASH_SPELLMATS_LIMITS2 = "/smlimits";

	SlashCmdList["SPELLMATS_LIMITS"] = function(msg)
		SpellMats_SlashLimits(msg);
	end

	SLASH_SPELLMATS_FASTUPDATE1 = "/smf";
	SLASH_SPELLMATS_FASTUPDATE2 = "/smfastupdate";

	SlashCmdList["SPELLMATS_FASTUPDATE"] = function(msg)
		SpellMats_SlashFastUpdate(msg);
	end
end

function SpellMats_SlashToggle(msg)
	if string.lower(msg) == "on" then
		SpellMats_Toggle(true);
	end
	if string.lower(msg) == "off" then
		SpellMats_Toggle(false);
	end
	-- syncronize with khaos options
	if (Khaos) then
		Khaos.setSetEnabled("SpellMats", SpellMats_Data.enabled);
		Khaos.refresh();
	end
	SpellMats_PrintStatus(SPELLMATS_CONFIG_HEADER, SpellMats_Data.enabled);
end

function SpellMats_SlashLimits(msg)
	if (not msg or msg == "") then
		SpellMats_DumpLimits();
		return
	end
	local _ , index, reagent = string.find(msg, "%[(.-)%]");
	if (not index or not reagent) then
		SpellMats_PrintChatCommandHelp();
		return;
	end

	if (not SpellMats_Data.Reagents[reagent]) then
		SpellMats_ReagentNotFoundMessage(reagent);
		return;
	end

	local tokens = Sea.util.split(string.sub(msg, index)," ");

	if not tokens[2] then
		SpellMats_ReagentLimitsMessage(reagent,SpellMats_Data.Reagents[reagent].yellow,SpellMats_Data.Reagents[reagent].red);
		return;
	end

	local newYellow	= tonumber(tokens[2]);
	local newRed = newYellow;

	if tokens[3] then
		newRed = tonumber(tokens[3]);
	end

	if not newYellow or not newRed then
		SpellMats_PrintChatCommandHelp();
		return;
	end

	SpellMats_Data.Reagents[reagent].yellow = newYellow;
	SpellMats_Data.Reagents[reagent].red = newRed;

	SpellMats_ReagentLimitsMessage(reagent,SpellMats_Data.Reagents[reagent].yellow,SpellMats_Data.Reagents[reagent].red);

end

function SpellMats_SlashFastUpdate(msg)
	if string.lower(msg) == "on" then
		SpellMats_ToggleFastUpdate(true);
	end
	if string.lower(msg) == "off" then
		SpellMats_ToggleFastUpdate(false);
	end
	-- syncronize with khaos options
	if (Khaos) then
		Khaos.setSetKeyParameter("SpellMats", "EnableFastUpdate", "checked", SpellMats_Data.fastUpdate);
		Khaos.refresh();
	end
	SpellMats_PrintStatus(SPELLMATS_FASTUPDATE, SpellMats_Data.fastUpdate);
end

function SpellMats_DumpLimits()
	for reagent, _ in SpellMats_Data.Reagents do
		SpellMats_ReagentLimitsMessage(reagent,SpellMats_Data.Reagents[reagent].yellow,SpellMats_Data.Reagents[reagent].red);
	end
end

--[[
	Auctioneer Addon for World of Warcraft(tm).
	Version: 3.9.0.1063 (Kangaroo)
	Revision: $Id: AucAskPrice.lua 1031 2006-10-04 04:15:38Z mentalpower $

	Auctioneer AskPrice created by Mikezter and merged into Auctioneer by MentalPower.
	Functions responsible for AskPrice's operation..

	License:
		This program is free software; you can redistribute it and/or
		modify it under the terms of the GNU General Public License
		as published by the Free Software Foundation; either version 2
		of the License, or (at your option) any later version.

		This program is distributed in the hope that it will be useful,
		but WITHOUT ANY WARRANTY; without even the implied warranty of
		MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
		GNU General Public License for more details.

		You should have received a copy of the GNU General Public License
		along with this program(see GPL.txt); if not, write to the Free Software
		Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
--]]

--Local function prototypes
local init, askpriceFrame, commandHandler, chatPrintHelp, onOff, setTrigger, genVarSet, setCustomSmartWords, setKhaosSetKeyValue, eventHandler, sendWhisper, onEventHook

local whisperList = {}

function init()
	askPriceFrame = CreateFrame("Frame")

	askPriceFrame:RegisterEvent("CHAT_MSG_RAID_LEADER")
	askPriceFrame:RegisterEvent("CHAT_MSG_WHISPER")
	askPriceFrame:RegisterEvent("CHAT_MSG_OFFICER")
	askPriceFrame:RegisterEvent("CHAT_MSG_PARTY")
	askPriceFrame:RegisterEvent("CHAT_MSG_GUILD")
	askPriceFrame:RegisterEvent("CHAT_MSG_RAID")

	askPriceFrame:SetScript("OnEvent", function () Auctioneer.AskPrice.EventHandler(event, arg1, arg2) end)

	Auctioneer.AskPrice.Language = GetDefaultLanguage("player");

	Stubby.RegisterFunctionHook("ChatFrame_OnEvent", -200, Auctioneer.AskPrice.OnEventHook);
end

function commandHandler(command, source)

	--To print or not to print, that is the question...
	local chatprint = nil;

	if (source == "GUI") then
		chatprint = false;

	else
		chatprint = true;
	end;

	--Divide the large command into smaller logical sections (Shameless copy from the original function)
	local i,j, cmd, param = string.find(command, "^([^ ]+) (.+)$");

	if (not cmd) then cmd = command; end
	if (not cmd) then cmd = ""; end
	if (not param) then	param = ""; end
	cmd = Auctioneer.Util.DelocalizeCommand(cmd);

	--Now for the real Command handling

	--/auctioneer askprice help
	if ((cmd == "") or (cmd == "help")) then
		chatPrintHelp();

	--/auctioneer askprice (on|off|toggle)
	elseif (cmd == 'on' or cmd == 'off' or cmd == 'toggle') then
		onOff(cmd, chatprint);

	--/auctioneer askprice trigger (char)
	elseif (cmd == 'trigger') then
		setTrigger(param, chatprint)

	--/auctioneer askprice (party|guild|smart|ad|whispers) (on|off|toggle)
	elseif (
		cmd == 'vendor'	or cmd == 'party'	or cmd == 'guild' or
		cmd == 'smart'	or cmd == 'ad'		or cmd == 'whispers'
	) then
		genVarSet(cmd, param, chatprint);

	--/auctioneer askprice word # (customSmartWord)
	elseif (cmd == 'word') then
		setCustomSmartWords(param, nil, nil, chatprint);

	--Command not recognized
	else
		if (chatprint) then
			Auctioneer.Util.ChatPrint(string.format(_AUCT('FrmtActUnknown'), command));
		end
	end
end

function chatPrintHelp()
	local onOffToggle = " (".._AUCT('CmdOn').."|".._AUCT('CmdOff').."|".._AUCT('CmdToggle')..")";
	local lineFormat = "  |cffffffff/auctioneer askprice %s"..onOffToggle.."|r |cff2040ff[%s]|r\n          %s\n\n";

	Auctioneer.Util.ChatPrint("  |cffffffff/auctioneer askprice"..onOffToggle.."|r |cff2040ff["..Auctioneer.Util.GetLocalizedFilterVal('askprice').."]|r\n          " .. _AUCT('HelpAskPrice') .. "\n\n");

	Auctioneer.Util.ChatPrint(string.format(lineFormat, _AUCT('CmdAskPriceWhispers'),	Auctioneer.Util.GetLocalizedFilterVal('askprice-whispers'),	_AUCT('HelpAskPriceWhispers')));
	Auctioneer.Util.ChatPrint(string.format(lineFormat, _AUCT('CmdAskPriceVendor'),		Auctioneer.Util.GetLocalizedFilterVal('askprice-vendor'),	_AUCT('HelpAskPriceVendor')));
	Auctioneer.Util.ChatPrint(string.format(lineFormat, _AUCT('CmdAskPriceParty'),		Auctioneer.Util.GetLocalizedFilterVal('askprice-party'),	_AUCT('HelpAskPriceParty')));
	Auctioneer.Util.ChatPrint(string.format(lineFormat, _AUCT('CmdAskPriceGuild'),		Auctioneer.Util.GetLocalizedFilterVal('askprice-guild'),	_AUCT('HelpAskPriceGuild')));
	Auctioneer.Util.ChatPrint(string.format(lineFormat, _AUCT('CmdAskPriceSmart'),		Auctioneer.Util.GetLocalizedFilterVal('askprice-smart'),	_AUCT('HelpAskPriceSmart')));
	Auctioneer.Util.ChatPrint(string.format(lineFormat, _AUCT('CmdAskPriceAd'),			Auctioneer.Util.GetLocalizedFilterVal('askprice-ad'),		_AUCT('HelpAskPriceAd')));

	lineFormat = "  |cffffffff/auctioneer askprice %s|r |cff2040ff[%s]|r\n          %s\n\n";
	Auctioneer.Util.ChatPrint(string.format(lineFormat, _AUCT('CmdAskPriceTrigger'),	Auctioneer.Command.GetFilterVal('askprice-trigger'),		_AUCT('HelpAskPriceTrigger')));

	lineFormat = "  |cffffffff/auctioneer askprice %s %d|r |cff2040ff[%s]|r\n          %s\n\n";
	Auctioneer.Util.ChatPrint(string.format(lineFormat, _AUCT('CmdAskPriceWord'), 1,	Auctioneer.Command.GetFilterVal('askprice-word1'),			_AUCT('HelpAskPriceWord')));
	Auctioneer.Util.ChatPrint(string.format(lineFormat, _AUCT('CmdAskPriceWord'), 2,	Auctioneer.Command.GetFilterVal('askprice-word2'),			_AUCT('HelpAskPriceWord')));
end

--[[
	The onOff(state, chatprint) function handles AskPrice's state (whether it is currently on or off)
	If "on" or "off" is specified in the first argument then AskPrice's state is changed to that value,
	If "toggle" is specified then it will toggle AskPrice's state (if currently on then it will be turned off and vice-versa)

	If a boolean (or nil) value is passed as the first argument the conversion is as follows:
	"true" is the same as "on"
	"false" is the same as "off"
	"nil" is the same as "toggle"

	If chatprint is "true" then the state will also be printed to the user.
]]
function onOff(state, chatprint)
	if (type(state) == "string") then
		state = Auctioneer.Util.DelocalizeFilterVal(state);

	elseif (state == true) then
		state = 'on'

	elseif (state == false) then
		state = 'off'

	elseif (state == nil) then
		state = 'toggle'
	end

	if (state == 'on' or state == 'off') then
		Auctioneer.Command.SetFilter('askprice', state);
	elseif (state == 'toggle') then
		Auctioneer.Command.SetFilter('askprice', not Auctioneer.Command.GetFilter('askprice'));
	end

	--Print the change and alert the GUI if the command came from slash commands. Do nothing if they came from the GUI.
	if (chatprint) then
		state = Auctioneer.Command.GetFilter('askprice')
		setKhaosSetKeyValue("askprice", state)

		if (state) then
			Auctioneer.Util.ChatPrint(_AUCT('StatAskPriceOn'));

		else
			Auctioneer.Util.ChatPrint(_AUCT('StatAskPriceOff'));
		end
	end
end

function setTrigger(param, chatprint)
	if (not (type(param) == 'string')) then
		return
	end

	param = string.sub(param, 1, 1)
	Auctioneer.Command.SetFilter('askprice-trigger', param)

	if (chatprint) then
		Auctioneer.Util.ChatPrint(string.format(_AUCT('FrmtActSet'), "askprice ".._AUCT('CmdAskPriceTrigger'), param));
		setKhaosSetKeyValue('askprice-trigger', param)
	end
end

function genVarSet(variable, param, chatprint)
	if (type(param) == "string") then
		param = Auctioneer.Util.DelocalizeFilterVal(param);
	end

	local var = "askprice-"..variable

	if (param == "on" or param == "off" or type(param) == "boolean") then
		Auctioneer.Command.SetFilter(var, param);

	elseif (param == "toggle" or param == nil or param == "") then
		param = Auctioneer.Command.SetFilter(var, not Auctioneer.Command.GetFilter(var));
	end

	if (chatprint) then
		if (Auctioneer.Command.GetFilter(var)) then
			Auctioneer.Util.ChatPrint(string.format(_AUCT('FrmtAskPriceEnable'), Auctioneer.Util.LocalizeCommand(variable)));
			setKhaosSetKeyValue(var, true)
		else
			Auctioneer.Util.ChatPrint(string.format(_AUCT('FrmtAskPriceDisable'), Auctioneer.Util.LocalizeCommand(variable)));
			setKhaosSetKeyValue(var, false)
		end
	end
end

--Function for users to add/modify smartWords (written by Kandoko, integrated into AskPrice by MentalPower)
function setCustomSmartWords(param, number, word, chatprint)

	--Only parse the param if the pre-parsed components are not present.
	if (not (number and word)) then
		--Divide the large command into smaller logical sections (Shameless copy from the original function)
		_, _, number, word = string.find(param, "^([^ ]+) (.+)$");

		if (not number) then number = param; end
		if (not number) then number = ""; end
		if (not word) then	word = ""; end
	end

	number = tonumber(number)

	if (not (((type(param) == 'string') or (type(word) == 'string'))and number)) then
		Auctioneer.Util.ChatPrint(string.format(_AUCT('FrmtUnknownArg'), param or word, "askprice ".._AUCT('CmdAskPriceWord')));
		return
	end

	word = string.lower(word)

	--Save choosen words.
	if (number == 1) then
		Auctioneer.Command.SetFilter('askprice-word1', word)

	elseif (number == 2) then
		Auctioneer.Command.SetFilter('askprice-word2', word)
	else
		Auctioneer.Util.ChatPrint(string.format(_AUCT('FrmtUnknownArg'), param, "askprice ".._AUCT('CmdAskPriceWord')));
		return;
	end

	if (chatprint) then
		Auctioneer.Util.ChatPrint(string.format(_AUCT('FrmtActSet'), "askprice ".._AUCT('CmdAskPriceWord').." "..number, Auctioneer.Command.GetFilterVal('askprice-word'..number)));
		setKhaosSetKeyValue('askprice-word'..number, word)
	end
end

function setKhaosSetKeyValue(key, value)
	if (Auctioneer_Khaos_Registered) then
		local kKey = Khaos.getSetKey("Auctioneer", key)

		if (not kKey) then
			EnhTooltip.DebugPrint("setKhaosSetKeyParameter(): key " .. key .. " does not exist")
		elseif (kKey.checked ~= nil) then
			if (type(value) == "string") then value = (value == "on"); end
			Khaos.setSetKeyParameter("Auctioneer", key, "checked", value)
		elseif (kKey.value ~= nil) then
			Khaos.setSetKeyParameter("Auctioneer", key, "value", value)
		else
			EnhTooltip.DebugPrint("setKhaosSetKeyValue(): don't know how to update key ", key)
		end
	end
end

function eventHandler(event, text, player)
	--Nothing to do if askprice is disabled
	if (not Auctioneer.Command.GetFilter('askprice')) then
		return;
	end

	--Make sure that we recieve the proper events and that our settings allow a response
	if (not ((event == "CHAT_MSG_WHISPER")
		or (((event == "CHAT_MSG_GUILD") or (event == "CHAT_MSG_OFFICER")) and Auctioneer.Command.GetFilter('askprice-guild'))
		or (((event == "CHAT_MSG_PARTY") or (event == "CHAT_MSG_RAID") or (event == "CHAT_MSG_RAID_LEADER")) and Auctioneer.Command.GetFilter('askprice-party')))) then
		return;
	end

	local aCount, historicalMedian, snapshotMedian, vendorSell, eachstring, askedCount, items, usedStack, multipleItems;

	-- Check for marker (trigger char or "smart" words)
	if (not (string.sub(text, 1, 1) == Auctioneer.Command.GetFilterVal('askprice-trigger'))) then

		--If the trigger char was not found scan the text for SmartWords (if the feature has been enabled)
		if (Auctioneer.Command.GetFilter('askprice-smart')) then
			if (not (string.find(string.lower(text), _AUCT('CmdAskPricSmartWord1')) and string.find(string.lower(text), _AUCT('CmdAskPriceSmartWord2')))) then

				--Check if the custom SmartWords are present in the chat message
				local customSmartWord1, customSmartWord2 = Auctioneer.Command.GetFilterVal('askprice-word1'), Auctioneer.Command.GetFilterVal('askprice-word1');
				if (not ((string.find(string.lower(text), customSmartWord1)) and string.find(string.lower(text), customSmartWord2)))  then
					return;
				end
			end
		else
			return;
		end
	end

	-- Check for itemlink after trigger
	if (not (string.find(text, "|Hitem:"))) then
		return;
	end

	--Parse the text and separate out the different links
	items = getItems(text)
	for key, link in ipairs(items) do
		--
		aCount, historicalMedian, snapshotMedian, vendorSell = getData(link[1]);
		local askedCount;

		--If there are multiple items send a separator line (since we can't send \n's as those would cause DC's)
		if (multipleItems) then
			Auctioneer.AskPrice.SendWhisper("    ", player);
		end

		--If the stackSize is grater than one, add the unit price to the message
		if (link[2] > 1) then
			eachstring = string.format(_AUCT('FrmtAskPriceEach'), EnhTooltip.GetTextGSC(historicalMedian, nil, true));
		else
			eachstring = "";
		end

		if (aCount > 0) then
			Auctioneer.AskPrice.SendWhisper(link[1]..": "..string.format(_AUCT('FrmtInfoSeen'), aCount), player);
			Auctioneer.AskPrice.SendWhisper(string.format(_AUCT('FrmtAskPriceBuyoutMedianHistorical'), "    ", EnhTooltip.GetTextGSC(historicalMedian*link[2], nil, true), eachstring), player);
			Auctioneer.AskPrice.SendWhisper(string.format(_AUCT('FrmtAskPriceBuyoutMedianSnapshot'), "    ", EnhTooltip.GetTextGSC(snapshotMedian*link[2], nil, true), eachstring), player);
		else
			Auctioneer.AskPrice.SendWhisper(link[1]..": "..string.format(_AUCT('FrmtInfoNever'), Auctioneer.Util.GetAuctionKey()), player);
		end

		--Send out vendor info if we have it
		if (Auctioneer.Command.GetFilter('askprice-vendor') and (vendorSell > 0)) then

			--Again if the stackSize is grater than one, add the unit price to the message
			if (link[2] > 1) then
				eachstring = string.format(_AUCT('FrmtAskPriceEach'), EnhTooltip.GetTextGSC(vendorSell, nil, true));
			else
				eachstring = "";
			end

			Auctioneer.AskPrice.SendWhisper(string.format(_AUCT('FrmtAskPriceVendorPrice'), "    ",EnhTooltip.GetTextGSC(vendorSell * link[2], nil, true), eachstring), player);
		end

		if (link[2] > 1) then
			usedStack = link[2]
		end
		multipleItems = true;
	end

	--Once we're done sending out the itemInfo, check if the person used the stack size feature, if not send them the ad message.
	if ((not usedStack) and (Auctioneer.Command.GetFilter('askprice-ad'))) then
		Auctioneer.AskPrice.SendWhisper(string.format(_AUCT('AskPriceAd'), Auctioneer.Command.GetFilterVal('askprice-trigger')), player)
	end
end

function getData(itemLink)
	local auctKey = Auctioneer.Util.GetAuctionKey();
	local itemKey = Auctioneer.ItemDB.CreateItemKeyFromLink(itemLink);
	local itemID = Auctioneer.ItemDB.BreakItemKey(itemKey);

	local itemTotals = Auctioneer.HistoryDB.GetItemTotals(itemKey, auctKey);
	local historicalMedian, historicalMedCount = Auctioneer.Statistic.GetItemHistoricalMedianBuyout(itemKey, auctKey);
	local snapshotMedian, snapshotMedCount = Auctioneer.Statistic.GetItemSnapshotMedianBuyout(itemKey, auctKey);
	local vendorSell = Auctioneer.API.GetVendorSellPrice(itemID)
	
	local seenCount
	if (itemTotals) then
		seenCount = itemTotals.seenCount
	end

	return seenCount or 0, historicalMedian or 0, snapshotMedian or 0, vendorSell or 0;
end

--Many thanks to the guys at irc://chat.freenode.net/wowi-lounge for their help in creating this function
function getItems(str)
	if (not str) then return nil end
	local itemList = {};

	for number, color, item, name in string.gfind(str, "(%d*)|c(%x+)|Hitem:(%d+:%d+:%d+:%d+)|h%[(.-)%]|h|r") do
		table.insert(itemList, {"|c"..color.."|Hitem:"..item.."|h["..name.."]|h|r", tonumber(number) or 1})
	end
	return itemList;
end

function sendWhisper(text, player)
	whisperList[text] = true
	SendChatMessage(text, "WHISPER", Auctioneer.AskPrice.Language, player)
end

function onEventHook()
	if (Auctioneer.Command.GetFilter('askprice-whisper')) then
		if ((event == "CHAT_MSG_WHISPER_INFORM") and (whisperList[arg1])) then
			return "killorig"
		end
	end
end

Auctioneer.AskPrice = {
	Init = init,
	CommandHandler = commandHandler,
	ChatPrintHelp = chatPrintHelp,
	OnOff = onOff,
	SetTrigger = setTrigger,
	GenVarSet = genVarSet,
	SetCustomSmartWords = setCustomSmartWords,
	EventHandler = eventHandler,
	SendWhisper = sendWhisper,
	OnEventHook = onEventHook,
}

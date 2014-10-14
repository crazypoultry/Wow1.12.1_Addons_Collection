--[[
	Auctioneer Addon for World of Warcraft(tm).
	Version: 3.9.0.1063 (Kangaroo)
	Revision: $Id: AucUtil.lua 1034 2006-10-04 05:18:29Z mentalpower $

	Auctioneer utility functions.
	Functions to maniuplate items keys, signatures etc

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
local storePlayerFaction, getTimeLeftString, getSecondsLeftString, unpackSeconds, getGSC, getTextGSC, nilSafeString, colorTextWhite, getWarnColor, nullSafe, sanifyAHSnapshot, getAuctionKey, getOppositeKey, getNeutralKey, getHomeKey, isValidAlso, split, getItemLinks, getItems, getItemHyperlinks, chatPrint, setFilterDefaults, protectAuctionFrame, priceForOne, round, delocalizeFilterVal, localizeFilterVal, getLocalizedFilterVal, delocalizeCommand, localizeCommand, findEmptySlot

function storePlayerFaction()
	Auctioneer.Core.Constants.PlayerFaction = (Auctioneer.Core.Constants.PlayerFaction or UnitFactionGroup("player") or "Alliance");
end

-- return the string representation of the given timeLeft constant
function getTimeLeftString(timeLeft)
	local timeLeftString = "";

	if timeLeft == Auctioneer.Core.Constants.TimeLeft.Short then
		timeLeftString = _AUCT('TimeShort');

	elseif timeLeft == Auctioneer.Core.Constants.TimeLeft.Medium then
		timeLeftString = _AUCT('TimeMed');

	elseif timeLeft == Auctioneer.Core.Constants.TimeLeft.Long then
		timeLeftString = _AUCT('TimeLong');

	elseif timeLeft == Auctioneer.Core.Constants.TimeLeft.VeryLong then
		timeLeftString = _AUCT('TimeVlong');
	end

	return timeLeftString;
end

function getSecondsLeftString(secondsLeft)
	local timeLeft = nil;

	for i = table.getn(Auctioneer.Core.Constants.TimeLeft.Seconds), 1, -1 do

		if (secondsLeft >= Auctioneer.Core.Constants.TimeLeft.Seconds[i]) then
			timeLeft = i;
			break
		end
	end

	return getTimeLeftString(timeLeft);
end

function unpackSeconds(seconds)
	seconds = tonumber(seconds)
	if (not seconds) then
		return
	end

	local weeks
	local days
	local hours
	local minutes

	seconds = math.floor(seconds)

	if (seconds > 604800) then
		weeks = math.floor(seconds / 604800)
		seconds = math.floor(seconds - (weeks * 604800))
	end
	if (seconds > 86400) then
		days = math.floor(seconds / 86400)
		seconds = math.floor(seconds - (days * 86400))
	end
	if (seconds > 3600) then
		hours = math.floor(seconds / 3600)
		seconds = math.floor(seconds - (hours * 3600))
	end
	if (seconds >= 60) then
		minutes = math.floor(seconds / 60)
		seconds = math.floor(seconds - (minutes * 60))
	end

	return (weeks or 0), (days or 0), (hours or 0), (minutes or 0), (seconds or 0)
end

function getGSC(money)
	local g,s,c = EnhTooltip.GetGSC(money);
	return g,s,c;
end

function getTextGSC(money)
	return EnhTooltip.GetGSC(money);
end

-- return an empty string if str is nil
function nilSafeString(str)
	return str or "";
end

function colorTextWhite(text)
	if (not text) then text = ""; end

	local COLORING_START = "|cff%s%s|r";
	local WHITE_COLOR = "e6e6e6";

	return string.format(COLORING_START, WHITE_COLOR, ""..text);
end

function getWarnColor(warn)
	--Make "warn" a required parameter and verify that its a string
	if (not (type(warn) == "string")) then
		return nil
	end

	local cHex, cRed, cGreen, cBlue;

	if (Auctioneer.Command.GetFilter('warn-color')) then
		local FrmtWarnAbovemkt, FrmtWarnUndercut, FrmtWarnNocomp, FrmtWarnAbovemkt, FrmtWarnMarkup, FrmtWarnUser, FrmtWarnNodata, FrmtWarnMyprice

		FrmtWarnToolow = _AUCT('FrmtWarnToolow');
		FrmtWarnNocomp = _AUCT('FrmtWarnNocomp');
		FrmtWarnAbovemkt = _AUCT('FrmtWarnAbovemkt');
		FrmtWarnUser = _AUCT('FrmtWarnUser');
		FrmtWarnNodata = _AUCT('FrmtWarnNodata');
		FrmtWarnMyprice = _AUCT('FrmtWarnMyprice');

		FrmtWarnUndercut = string.format(_AUCT('FrmtWarnUndercut'), tonumber(Auctioneer.Command.GetFilterVal('pct-underlow')));
		FrmtWarnMarkup = string.format(_AUCT('FrmtWarnMarkup'), tonumber(Auctioneer.Command.GetFilterVal('pct-markup')));

		if (warn == FrmtWarnToolow) then
			--Color Red
			cHex = "ffff0000";
			cRed = 1.0;
			cGreen = 0.0;
			cBlue = 0.0;

		elseif (warn == FrmtWarnUndercut) then
			--Color Yellow
			cHex = "ffffff00";
			cRed = 1.0;
			cGreen = 1.0;
			cBlue = 0.0;

		elseif ((warn == FrmtWarnNocomp) or (warn == FrmtWarnAbovemkt)) then
			--Color Green
			cHex = "ff00ff00";
			cRed = 0.0;
			cGreen = 1.0;
			cBlue = 0.0;

		elseif ((warn == FrmtWarnMarkup) or (warn == FrmtWarnUser) or (warn == FrmtWarnNodata) or (warn == FrmtWarnMyprice)) then
			--Color Gray
			cHex = "ff999999";
			cRed = 0.6;
			cGreen = 0.6;
			cBlue = 0.6;
		end

	else
		--Color Orange
		cHex = "ffe66600";
		cRed = 0.9;
		cGreen = 0.4;
		cBlue = 0.0;
	end

	return cHex, cRed, cGreen, cBlue
end

-- Used to convert variables that should be numbers but are nil to 0
function nullSafe(val)
	return tonumber(val) or 0;
end

-- Returns the current faction's auction signature, depending on location
function getAuctionKey()
	local serverName = GetCVar("realmName");
	local currentZone = GetMinimapZoneText();
	local factionGroup;

	--Added the ability to record Neutral AH auctions in its own tables.
	if ((currentZone == "Gadgetzan") or (currentZone == "Everlook") or (currentZone == "Booty Bay")) then
		factionGroup = "Neutral"

	else
		factionGroup = Auctioneer.Core.Constants.PlayerFaction;
	end
	return string.lower(serverName).."-"..string.lower(factionGroup);
end

-- Returns the current faction's opposing faction's auction signature
function getOppositeKey()
	local serverName = GetCVar("realmName");
	local factionGroup = Auctioneer.Core.Constants.PlayerFaction;

	if (factionGroup == "Alliance") then factionGroup="Horde"; else factionGroup="Alliance"; end
	return string.lower(serverName).."-"..string.lower(factionGroup);
end

-- Returns the current server's neutral auction signature
function getNeutralKey()
	local serverName = GetCVar("realmName");

	return string.lower(serverName).."-neutral";
end

-- Returns the current faction's auction signature
function getHomeKey()
	local serverName = GetCVar("realmName");
	local factionGroup = Auctioneer.Core.Constants.PlayerFaction;

	return string.lower(serverName).."-"..string.lower(factionGroup);
end

-- function returns true, if the given parameter is a valid option for the also command, false otherwise
function isValidAlso(also)
	if (type(also) ~= "string") then
		return false
	end

	if ((also == 'opposite') or (also == 'off') or (also == 'neutral') or (also == 'home')) then
		return true		-- allow special keywords
	end

	-- check if string matches: "[realm]-[faction]"
	local s, e, r, f = string.find(also, "^(.+)-(.+)$")
	if (s == nil) then
		return false	-- invalid string
	end

	-- check if faction = "Horde" or "Alliance"
	if (f == 'horde') or (f == 'alliance')or (f == 'neutral') then
		return true
	end

	return true
end

function split(str, at)
	local splut = {};

	if (type(str) ~= "string") then return nil end
	if (not str) then str = "" end

	if (not at)
		then table.insert(splut, str)

	else
		for n, c in string.gfind(str, '([^%'..at..']*)(%'..at..'?)') do
			table.insert(splut, n);

			if (c == '') then break end
		end
	end
	return splut;
end

function getItemLinks(str)
	if (not (type(str) == "string")) then
		return
	end
	local itemList = {};

	for link, item in string.gfind(str, "|Hitem:([^|]+)|h[[]([^]]+)[]]|h") do
		table.insert(itemList, item.." = "..link)
	end
	return itemList;
end

function getItems(str)
	if (not (type(str) == "string")) then
		return
	end
	local itemList = {};
	local itemKey;

	for itemID, randomProp, enchant, uniqID in string.gfind(str, "|Hitem:(%d+):(%d+):(%d+):(%d+)|h") do
		itemKey = itemID..":"..randomProp..":"..enchant;
		table.insert(itemList, itemKey)
	end
	return itemList;
end

--Many thanks to the guys at irc://irc.datavertex.com/cosmostesters for their help in creating this function
function getItemHyperlinks(str)
	if (not (type(str) == "string")) then
		return
	end
	local itemList = {};

	for color, item, name in string.gfind(str, "|c(%x+)|Hitem:(%d+:%d+:%d+:%d+)|h%[(.-)%]|h|r") do
		table.insert(itemList, "|c"..color.."|Hitem:"..item.."|h["..name.."]|h|r")
	end
	return itemList;
end

function chatPrint(text, cRed, cGreen, cBlue, cAlpha, holdTime)
	local frameIndex = Auctioneer.Command.GetFrameIndex();

	if (cRed and cGreen and cBlue) then
		if getglobal("ChatFrame"..frameIndex) then
			getglobal("ChatFrame"..frameIndex):AddMessage(text, cRed, cGreen, cBlue, cAlpha, holdTime);

		elseif (DEFAULT_CHAT_FRAME) then
			DEFAULT_CHAT_FRAME:AddMessage(text, cRed, cGreen, cBlue, cAlpha, holdTime);
		end

	else
		if getglobal("ChatFrame"..frameIndex) then
			getglobal("ChatFrame"..frameIndex):AddMessage(text, 0.0, 1.0, 0.25);

		elseif (DEFAULT_CHAT_FRAME) then
			DEFAULT_CHAT_FRAME:AddMessage(text, 0.0, 1.0, 0.25);
		end
	end
end

function setFilterDefaults()
	if (not AuctionConfig.filters) then
		AuctionConfig.filters = {};
	end

	for k,v in ipairs(Auctioneer.Core.Constants.FilterDefaults) do
		if (AuctionConfig.filters[k] == nil) then
			AuctionConfig.filters[k] = v;
		end
	end
end

-- Pass true to protect the Auction Frame from being undesireably closed, not true to disable this
function protectAuctionFrame(enable)
	--Make sure we have an AuctionFrame before doing anything
	if (AuctionFrame) then
		--Handle enabling of protection

		if (enable and not Auctioneer_ProtectionEnabled and AuctionFrame:IsShown()) then
			--Remember that we are now protecting the frame
			Auctioneer_ProtectionEnabled = true;
			--If the frame is the current doublewide frame, then clear the doublewide

			if ( GetDoublewideFrame() == AuctionFrame ) then
				SetDoublewideFrame(nil)
			end
			--Remove the frame from the UI frame handling system
			UIPanelWindows["AuctionFrame"] = nil
			--If mobile frames is around, then remove AuctionFrame from Mobile Frames handling system

			if (MobileFrames_UIPanelWindowBackup) then
				MobileFrames_UIPanelWindowBackup.AuctionFrame = nil;
			end

			if (MobileFrames_UIPanelsVisible) then
				MobileFrames_UIPanelsVisible.AuctionFrame = nil;
			end
			--Hook the function to show the WorldMap, WorldMap has internal code that forces all these frames to close
			--so for it, we have to prevent it from showing at all

			if (not Auctioneer_ToggleWorldMap) then
				Auctioneer_ToggleWorldMap = ToggleWorldMap;
			end
			ToggleWorldMap = function ()

				if ( ( not Auctioneer_ProtectionEnabled ) or ( not ( AuctionFrame and AuctionFrame:IsVisible() ) ) ) then
					Auctioneer_ToggleWorldMap();

				else
					UIErrorsFrame:AddMessage(_AUCT('GuiNoWorldMap'), 0, 1, 0, 1.0, UIERRORS_HOLD_TIME)
				end
			end

		elseif (Auctioneer_ProtectionEnabled) then
			--Handle disabling of protection
			Auctioneer_ProtectionEnabled = nil;
			--If Mobile Frames is around, then put the frame back under its control if it is proper to do so

			if ( MobileFrames_UIPanelWindowBackup and MobileFrames_MasterEnableList and MobileFrames_MasterEnableList["AuctionFrame"] ) then
				MobileFrames_UIPanelWindowBackup.AuctionFrame = { area = "doublewide", pushable = 0 };

				if ( MobileFrames_UIPanelsVisible and AuctionFrame:IsVisible() ) then
					MobileFrames_UIPanelsVisible.AuctionFrame = 0;
				end

			else
				--Put the frame back into the UI frame handling system
				UIPanelWindows["AuctionFrame"] = { area = "doublewide", pushable = 0 };

				if ( AuctionFrame:IsVisible() ) then
					SetDoublewideFrame(AuctionFrame)
				end
			end
		end
	end
end

function priceForOne(price, count)
	price = nullSafe(price)
	count = math.max(nullSafe(count), 1)
	return math.ceil(price / count)
end

function round(x)
	local y = math.floor(x);

	if (x - y >= 0.5) then
		return y + 1;
	end
	return y;
end

-------------------------------------------------------------------------------
-- Localization functions
-------------------------------------------------------------------------------

--Auctioneer.Command.CommandMap = nil;
--Auctioneer.Command.CommandMapRev = nil;

function delocalizeFilterVal(value)
	if (value == _AUCT('CmdOn')) then
		return 'on';

	elseif (value == _AUCT('CmdOff')) then
		return 'off';

	elseif (value == _AUCT('CmdDefault')) then
		return 'default';

	elseif (value == _AUCT('CmdToggle')) then
		return 'toggle';

	else
		return value;
	end
end

function localizeFilterVal(value)
	local result

	if (value == 'on') then
		result = _AUCT('CmdOn');

	elseif (value == 'off') then
		result = _AUCT('CmdOff');

	elseif (value == 'default') then
		result = _AUCT('CmdDefault');

	elseif (value == 'toggle') then
		result = _AUCT('CmdToggle');
	end

	if (result) then return result; else return value; end
end

function getLocalizedFilterVal(key)
	return localizeFilterVal(Auctioneer.Command.GetFilterVal(key))
end

-- Turns a localized slash command into the generic English version of the command
function delocalizeCommand(cmd)
	if (not Auctioneer.Command.CommandMap) then Auctioneer.Command.BuildCommandMap();end
	local result = Auctioneer.Command.CommandMap[cmd];

	if (result) then return result; else return cmd; end
end

-- Translate a generic English slash command to the localized version, if available
function localizeCommand(cmd)
	if (not Auctioneer.Command.CommandMapRev) then Auctioneer.Command.BuildCommandMap(); end
	local result = Auctioneer.Command.CommandMapRev[cmd];

	if (result) then return result; else return cmd; end
end

-------------------------------------------------------------------------------
-- Inventory modifying functions
-------------------------------------------------------------------------------

function findEmptySlot()
	local name, i
	for bag = 0, 4 do
		name = GetBagName(bag)
		i = string.find(name, '(Quiver|Ammo|Bandolier)')
		if not i then
			for slot = 1, GetContainerNumSlots(bag),1 do
				if not (GetContainerItemInfo(bag,slot)) then
					return bag, slot;
				end
			end
		end
	end
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function debugPrint(message)
	EnhTooltip.DebugPrint("[Auc.Util] "..message);
end

--=============================================================================
-- Initialization
--=============================================================================
if (Auctioneer.Util ~= nil) then return end;
debugPrint("AucUtil.lua loaded");

Auctioneer.Util =
{
	StorePlayerFaction = storePlayerFaction,
	GetTimeLeftString = getTimeLeftString,
	GetSecondsLeftString = getSecondsLeftString,
	UnpackSeconds = unpackSeconds,
	GetGSC = getGSC,
	GetTextGSC = getTextGSC,
	NilSafeString = nilSafeString,
	ColorTextWhite = colorTextWhite,
	GetWarnColor = getWarnColor,
	NullSafe = nullSafe,
	SanifyAHSnapshot = sanifyAHSnapshot,
	GetAuctionKey = getAuctionKey,
	GetOppositeKey = getOppositeKey,
	GetNeutralKey = getNeutralKey,
	GetHomeKey = getHomeKey,
	IsValidAlso = isValidAlso,
	Split = split,
	GetItemLinks = getItemLinks,
	GetItems = getItems,
	GetItemHyperlinks = getItemHyperlinks,
	ChatPrint = chatPrint,
	SetFilterDefaults = setFilterDefaults,
	ProtectAuctionFrame = protectAuctionFrame,
	PriceForOne = priceForOne,
	Round = round,
	DelocalizeFilterVal = delocalizeFilterVal,
	LocalizeFilterVal = localizeFilterVal,
	GetLocalizedFilterVal = getLocalizedFilterVal,
	DelocalizeCommand = delocalizeCommand,
	LocalizeCommand = localizeCommand,
	FindEmptySlot = findEmptySlot,
}

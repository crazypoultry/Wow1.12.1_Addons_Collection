--[[
	Auctioneer Addon for World of Warcraft(tm).
	Version: <%version%> (<%codename%>)
	Revision: $Id: AuctionFrameBrowse.lua 1047 2006-10-06 07:47:26Z vindicator $

	Auctioneer Browse tab

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

-------------------------------------------------------------------------------
-- Function Prototypes
-------------------------------------------------------------------------------
local load;
local postFilterButtonSetTypeHook;
local postAuctionFrameFiltersUpdateClassesHook;
local queryForItemByName;
local debugPrint;

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function load()
	debugPrint("Loading");

	BrowseScanButton:SetText(_AUCT('TextScan'));
	BrowseScanButton:SetParent("AuctionFrameBrowse");
	BrowseScanButton:SetPoint("LEFT", "AuctionFrameMoneyFrame", "RIGHT", 5,0);
	BrowseScanButton:Show();

	-- Register for events and hook methods.
	Stubby.RegisterFunctionHook("FilterButton_SetType", 200, postFilterButtonSetTypeHook);
	Stubby.RegisterFunctionHook("AuctionFrameFilters_UpdateClasses", 200, postAuctionFrameFiltersUpdateClassesHook);

	AuctionFrameFilters_UpdateClasses();
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function postFilterButtonSetTypeHook(_, _, button, type, text, isLast)
	--debugPrint("Setting button", button:GetName(), type, text, isLast);

	local buttonName = button:GetName();
	local i,j, buttonID = string.find(buttonName, "(%d+)$");
	buttonID = tonumber(buttonID);

	local checkbox = getglobal(button:GetName().."Checkbox");
	if checkbox then
		if (type == "class") then
			local classid, maxid = Auctioneer.Command.FindFilterClass(text);
			if (classid > 0) then
				Auctioneer.Command.FilterSetFilter(checkbox, "scan-class"..classid);
				if (classid == maxid) and (buttonID < 15) then
					for i=buttonID+1, 15 do
						getglobal("AuctionFilterButton"..i):Hide();
					end
				end
			else
				checkbox:Hide();
			end
		else
			checkbox:Hide();
		end
	end
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function postAuctionFrameFiltersUpdateClassesHook()
	local obj
	for i=1, 15 do
		obj = getglobal("AuctionFilterButton"..i.."Checkbox")
		if (obj) then
			obj:SetParent("AuctionFilterButton"..i)
			obj:SetPoint("RIGHT", "AuctionFilterButton"..i, "RIGHT", -5,0)
		end
	end
end

-------------------------------------------------------------------------------
-- The OnClick handler for the BrowseScanButton.
-------------------------------------------------------------------------------
function BrowseScanButton_OnClick()
	Auctioneer.ScanManager.Scan();
end

-------------------------------------------------------------------------------
-- Queries the auction house for the specified item name.
-------------------------------------------------------------------------------
function queryForItemByName(itemName)
	if (CanSendAuctionQuery()) then
		-- Search for the item and switch to the Browse tab.
		BrowseName:SetText(itemName)
		BrowseMinLevel:SetText("")
		BrowseMaxLevel:SetText("")
		AuctionFrameBrowse.selectedInvtype = nil
		AuctionFrameBrowse.selectedInvtypeIndex = nil
		AuctionFrameBrowse.selectedClass = nil
		AuctionFrameBrowse.selectedClassIndex = nil
		AuctionFrameBrowse.selectedSubclass = nil
		AuctionFrameBrowse.selectedSubclassIndex = nil
		AuctionFrameFilters_Update()
		IsUsableCheckButton:SetChecked(0)
		UIDropDownMenu_SetSelectedValue(BrowseDropDown, -1)
		AuctionFrameBrowse_Search()
	end
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function debugPrint(message)
	EnhTooltip.DebugPrint("[Auc.BrowseTab] "..message);
end

--=============================================================================
-- Initialization
--=============================================================================
if (Auctioneer.UI.BrowseTab ~= nil) then return end;
debugPrint("AuctioneerFrameBrowse.lua loaded");

-------------------------------------------------------------------------------
-- Public API
-------------------------------------------------------------------------------
Auctioneer.UI.BrowseTab = 
{
	Load = load;
	QueryForItemByName = queryForItemByName;
};

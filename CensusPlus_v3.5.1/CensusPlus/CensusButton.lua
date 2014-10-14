--[[
	CensusPlus for World of Warcraft(tm).
	
	Copyright 2005 - 2006 Cooper Sellers and WarcraftRealms.com

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
		along with this program(see GLP.txt); if not, write to the Free Software
		Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
]]


local init = false;

function CensusButton_OnClick()
	CensusPlus_Toggle();
end

function CensusButton_Init()
	if(CensusPlus_Database["Info"]["CensusButtonShown"] == 1 ) then
		CensusButtonFrame:Show();
	else
		CensusButtonFrame:Hide();
	end
	
	init = true;	
end

function CensusButton_Toggle()
	if(CensusButtonFrame:IsVisible()) then
		CensusButtonFrame:Hide();
		CensusPlus_Database["Info"]["CensusButtonShown"] = false;
	else
		CensusButtonFrame:Show();
		CensusPlus_Database["Info"]["CensusButtonShown"] = true;
	end
end

function CensusButton_UpdatePosition()
	CensusButtonFrame:SetPoint(
		"TOPLEFT",
		"Minimap",
		"TOPLEFT",
		54 - (78 * cos(CensusPlus_Database["Info"]["CensusButtonPosition"])),
		(78 * sin(CensusPlus_Database["Info"]["CensusButtonPosition"])) - 55
	);
end

function CensusButton_OnUpdate()
	if( init ) then
		CensusPlus_OnUpdate();
	end
end

function CensusPlusButton_OnClick( arg1 )
	if ( arg1 == "LeftButton" ) then
		CensusButton_OnClick();
	else
        ToggleDropDownMenu( 1, nil, CP_ButtonDropDown, "CensusButtonFrame", 20, 20 ); 					
	end

end

function CensusPlus_ButtonDropDown_Initialize()
		
		local info;

		if (g_IsCensusPlusInProgress == true) then
			if( g_CensusPlusManuallyPaused == true ) then
				info = {
					text = CENSUSPlus_UNPAUSE;
					func = CensusPlus_Take_OnClick;
				};
			else
				info = {
					text = CENSUSPlus_PAUSE;
					func = CensusPlus_Take_OnClick;
				};
			end
		else
			info = {
				text = CENSUSPlus_TAKE;
				func = CensusPlus_Take_OnClick;
			};
		end
		UIDropDownMenu_AddButton(info);

		info = {
			text = CENSUSPlus_STOP;
			func = CensusPlus_StopCensus;
		};
		UIDropDownMenu_AddButton(info);
		
		info = {
			text = CENSUSPlus_CANCEL;
			func = CloseDropDownMenus;
		};
		UIDropDownMenu_AddButton(info);		
		
end

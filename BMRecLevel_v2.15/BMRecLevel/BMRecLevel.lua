local BMRECLEVEL_ID = "bmreclevel_"
function BMRecLevel_OnLoad()
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("UNIT_NAME_UPDATE");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("MINIMAP_ZONE_CHANGED");
	this:RegisterEvent("ZONE_CHANGED_NEW_AREA");
	this:RegisterEvent("PLAYER_LEVEL_UP");
	
	--[[if (BHALDIEINFOBAR_LOADED ~= nil) then
		PLUG_IN_FRAME = "BMRecLevel";
		PLUG_IN_NAME = "BM Level Recommend";
		BM_ICON_SIZE = 0;
		BMRecLevelFrame:Hide();
		BM_Plugin(PLUG_IN_FRAME, PLUG_IN_NAME, BM_ICON_SIZE,BMRECLEVEL_ID);
	end]]

end

function BMRecLevel_OnEvent()
	
	if (event == "VARIABLES_LOADED") then			
		BMRecLevel_initialize();
		--BRL_UI_initialize();
	end

	if (event == "MINIMAP_ZONE_CHANGED" or event == "ZONE_CHANGED_NEW_AREA" or event == "PLAYER_LEVEL_UP") then
		BMRecLevel_Update_Text();
	end

end

function BMRecLevel_initialize()
	-- add the realm to the "player's name" for the config settings
	if (BHALDIEINFOBAR_LOADED == nil or BHALDIEMOVEIT_LOADED == nil) then
		BM_PLAYERNAME_REALM = GetCVar("realmName") .. "|" .. UnitName("player");
	end
	
	-- Make sure BM_CONFIG is ready
	if (not BRL_CONFIG) then
		BRL_CONFIG = { };
	end

	if (not BRL_CONFIG[BM_PLAYERNAME_REALM]) then
		BRL_CONFIG[BM_PLAYERNAME_REALM] = { };
	end
	
	-- Zone Info Box Show/Hide
	if (BRL_CONFIG[BM_PLAYERNAME_REALM].zone_info_enable == nil) then
		BRL_CONFIG[BM_PLAYERNAME_REALM].zone_info_enable = DEFAULT_BRL_ZONE_INFO_ENABLE;
	end
	-- Tooltip Show/Hide
	if (BRL_CONFIG[BM_PLAYERNAME_REALM].tooltip_enable == nil) then
		BRL_CONFIG[BM_PLAYERNAME_REALM].tooltip_enable = DEFAULT_BRL_TOOLTIP_ENABLE;
	end
	-- Map Text Show/Hide
	if (BRL_CONFIG[BM_PLAYERNAME_REALM].map_text_enable == nil) then
		BRL_CONFIG[BM_PLAYERNAME_REALM].map_text_enable = DEFAULT_BRL_MAP_TEXT_ENABLE;
	end
	-- Tooltip Offset Left/Right
	if (BRL_CONFIG[BM_PLAYERNAME_REALM].tooltip_offset_left == nil) then
		BRL_CONFIG[BM_PLAYERNAME_REALM].tooltip_offset_left = DEFAULT_BRL_TOOLTIP_OFFSET_LEFT;
	end
	-- Tooltip Offset Bottom/Top
	if (BRL_CONFIG[BM_PLAYERNAME_REALM].tooltip_offset_bottom == nil) then
		BRL_CONFIG[BM_PLAYERNAME_REALM].tooltip_offset_bottom = DEFAULT_BRL_TOOLTIP_OFFSET_BOTTOM;
	end
	-- Alpha of border
	if (BRL_CONFIG[BM_PLAYERNAME_REALM].border_alpha == nil) then
		BRL_CONFIG[BM_PLAYERNAME_REALM].border_alpha = DEFAULT_BRL_BORDER_ALPHASLIDER;
	end
	-- Tooltip Hide/Show Faction
	if ( BRL_CONFIG[BM_PLAYERNAME_REALM].show_tooltip_faction == nil ) then
		BRL_CONFIG[BM_PLAYERNAME_REALM].show_tooltip_faction = false;
	end
	-- Tooltip Hide/Show Instances
	if ( BRL_CONFIG[BM_PLAYERNAME_REALM].show_tooltip_instance == nil ) then
		BRL_CONFIG[BM_PLAYERNAME_REALM].show_tooltip_instance = false;
	end
	-- Hide/Show Zone
	if ( BRL_CONFIG[BM_PLAYERNAME_REALM].show_zone == nil ) then
		BRL_CONFIG[BM_PLAYERNAME_REALM].show_zone = DEFAULT_BRL_SHOW_ZONE;
	end
	-- Tooltip Hide/Show Continent
	if ( BRL_CONFIG[BM_PLAYERNAME_REALM].show_tooltip_continent == nil ) then
		BRL_CONFIG[BM_PLAYERNAME_REALM].show_tooltip_continent = false;
	end
	-- Tooltip Hide/Show Instances
	if ( BRL_CONFIG[BM_PLAYERNAME_REALM].show_rec_instances == nil ) then
		BRL_CONFIG[BM_PLAYERNAME_REALM].show_rec_instances = true;
	end
	-- Tooltip Hide/Show Battlegrounds
	if ( BRL_CONFIG[BM_PLAYERNAME_REALM].show_rec_battlegrounds == nil ) then
		BRL_CONFIG[BM_PLAYERNAME_REALM].show_rec_battlegrounds = true;
	end
	--Floating Frame Hide/Show
	if ( BRL_CONFIG[BM_PLAYERNAME_REALM].show_moveable_frame == nil ) then
		BRL_CONFIG[BM_PLAYERNAME_REALM].show_moveable_frame = true;
	end
	
	--[[
	if (BRL_CONFIG[BM_PLAYERNAME_REALM].zone_info_enable == false) then
		BMRecLevelFrame:Hide();
		BMRecLevel:Hide();
	else
		BMRecLevelFrame:Show();
		BMRecLevel:Show();
	end
	]]
	if (BRL_CONFIG[BM_PLAYERNAME_REALM].map_text_enable == false) then
		BMRecLevelWorldMap:Hide();
	else
		BMRecLevelWorldMap:Show();
	end
	
	if (BRL_CONFIG[BM_PLAYERNAME_REALM].tooltip_offset_bottom == false) then
		BRL_SET_BOTTOM_TOP = "TOP";
	else
		BRL_SET_BOTTOM_TOP = "BOTTOM";
	end
	
	if (BRL_CONFIG[BM_PLAYERNAME_REALM].tooltip_offset_left == false) then
		BRL_SET_LEFT_RIGHT = "RIGHT";
	else
		BRL_SET_LEFT_RIGHT = "LEFT";
	end

	BMRecLevelFrame:SetAlpha(BRL_CONFIG[BM_PLAYERNAME_REALM].border_alpha);

	if (IsAddOnLoaded("BhaldieInfoBar") or IsAddOnLoaded("Titan")) then
		--[[if (BRL_CONFIG[BM_PLAYERNAME_REALM].show_moveable_frame == false or BRL_CONFIG[BM_PLAYERNAME_REALM].zone_info_enable == false) then
			BMRecLevelFrame:Hide();
			BMRecLevel:Hide();]]
		if (BRL_CONFIG[BM_PLAYERNAME_REALM].show_moveable_frame == true and BRL_CONFIG[BM_PLAYERNAME_REALM].zone_info_enable == true) then
			BMRecLevel:ClearAllPoints();
			BMRecLevel:SetPoint("CENTER", "BMRecLevelFrame", "CENTER", 0, 0);
			BMRecLevelFrame:Show();
			BMRecLevel:Show();
		else
			BMRecLevel:ClearAllPoints();
			BMRecLevel:SetPoint("CENTER", "BMRecLevelFrame", "CENTER", 0, 0);
			BMRecLevelFrame:Hide();
			BMRecLevel:Hide();
		end
	else
		if (BRL_CONFIG[BM_PLAYERNAME_REALM].zone_info_enable == true) then
			BMRecLevel:ClearAllPoints();
			BMRecLevel:SetPoint("CENTER", "BMRecLevelFrame", "CENTER", 0, 0);
			BMRecLevelFrame:Show();
			BMRecLevel:Show();
		else
			BMRecLevel:ClearAllPoints();
			BMRecLevel:SetPoint("CENTER", "BMRecLevelFrame", "CENTER", 0, 0);
			BMRecLevelFrame:Hide();
			BMRecLevel:Hide();
		end
	end

	if (DEFAULT_CHAT_FRAME and not IsAddOnLoaded("BhaldieInfoBar") and not IsAddOnLoaded("Titan")) then
		UIErrorsFrame:AddMessage(BMRECLEVEL_LOADED, 1.0, 1.0, 1.0, 1.0, UIERRORS_HOLD_TIME);
		DEFAULT_CHAT_FRAME:AddMessage(BMRECLEVEL_LOADED .. BM_GREEN .. "\nRecommended Level UI Menu is ACTIVE\nYou can type /brlconfig in the chat window to bring up the UI Menu." .. BM_FONT_OFF);
	else
		UIErrorsFrame:AddMessage(BMRECLEVEL_LOADED, 1.0, 1.0, 1.0, 1.0, UIERRORS_HOLD_TIME);
		if (BRL_CONFIG[BM_PLAYERNAME_REALM].show_moveable_frame == true) then
			DEFAULT_CHAT_FRAME:AddMessage(BMRECLEVEL_LOADED .. "\n" .. BRL_ACTIVE_INFO);
		else
			DEFAULT_CHAT_FRAME:AddMessage(BMRECLEVEL_LOADED .. "\n" .. BRL_DISABLED_INFO);
		end
	end
end

function BMRecLevel_Update_Text()	
  local player_level = UnitLevel("player");
  local czone = "";
  BM_REC_LEVEL_BUTTON_TEXT = "";
	for i = 0, table.getn(BM_RECOMMEND), 1 do
		if (string.find(BM_RECOMMEND[i].zone, GetZoneText())) then
			BMRecLevel_Update_Tooltip_Text(i);
			czone = BM_RECOMMEND[i].zone;
			if (BM_RECOMMEND[i].player_faction ~= BRL_CITY) then
				if (player_level <= (BM_RECOMMEND[i].low_level-4)) then
					BM_REC_LEVEL_BUTTON_TEXT = format(RECOMMEND_TEXT_RED, BM_RECOMMEND[i].low_level, BM_RECOMMEND[i].high_level);
				elseif (player_level < BM_RECOMMEND[i].low_level and player_level >= (BM_RECOMMEND[i].low_level-3)) then
					BM_REC_LEVEL_BUTTON_TEXT = format(RECOMMEND_TEXT_YELLOW, BM_RECOMMEND[i].low_level, BM_RECOMMEND[i].high_level);
				elseif (player_level >= BM_RECOMMEND[i].low_level and player_level <= (BM_RECOMMEND[i].high_level)) then
					BM_REC_LEVEL_BUTTON_TEXT = format(RECOMMEND_TEXT_GREEN, BM_RECOMMEND[i].low_level, BM_RECOMMEND[i].high_level);
				else
					BM_REC_LEVEL_BUTTON_TEXT = format(RECOMMEND_TEXT_GRAY, BM_RECOMMEND[i].low_level, BM_RECOMMEND[i].high_level);
				end
			else
				BM_REC_LEVEL_BUTTON_TEXT = format(RECOMMEND_TEXT_WHITE, BM_RECOMMEND[i].player_faction);
			end
			
		end
	end
	if (BRL_CONFIG[BM_PLAYERNAME_REALM].show_zone == true ) then
		BMRecLevelText:SetText(czone .. ": " .. BM_REC_LEVEL_BUTTON_TEXT);
		BMRecLevel:SetWidth(BMRecLevelText:GetWidth());
		BMRecLevelFrame:SetWidth(BMRecLevel:GetWidth()+20);
		return czone, BM_REC_LEVEL_BUTTON_TEXT
	else
		BMRecLevelText:SetText(BRL_ZONE_RANGE .. BM_REC_LEVEL_BUTTON_TEXT);
		BMRecLevel:SetWidth(BMRecLevelText:GetWidth());
		BMRecLevelFrame:SetWidth(140);
		return BRL_ZONE_RANGE, BM_REC_LEVEL_BUTTON_TEXT
	end
end

function  BMRecLevel_Update_Tooltip_Text(BM_TEMP)	
	local player_level = UnitLevel("player");
	BM_REC_LEVEL_TOOLTIP_TEXT = "";
	if (BM_RECOMMEND[BM_TEMP].player_faction == BRL_CITY) then
		BM_REC_LEVEL_TOOLTIP_TEXT =  BM_REC_LEVEL_TOOLTIP_TEXT .. BM_GREEN .. BRL_TOOLTIP_CZONE .. BM_FONT_OFF .. BM_WHITE .. "\t" .. GetZoneText() .. " " .. BRL_CITY .. BM_FONT_OFF .. "\n";
	else
		BM_REC_LEVEL_TOOLTIP_TEXT =  BM_REC_LEVEL_TOOLTIP_TEXT .. BM_GREEN .. BRL_TOOLTIP_CZONE .. BM_FONT_OFF .. BM_WHITE .. "\t" .. GetZoneText() .. " " .. "(" .. BM_RECOMMEND[BM_TEMP].low_level .. "-" .. BM_RECOMMEND[BM_TEMP].high_level .. ")" ..BM_FONT_OFF .. "\n";
	end
	--BM_GREEN .. BRL_TOOLTIP_CZONE .. BM_FONT_OFF .. BM_WHITE .. "\t" .. GetZoneText() .. BM_FONT_OFF .. "\n";
	if (BRL_CONFIG[BM_PLAYERNAME_REALM].show_tooltip_instance) then
		BM_REC_LEVEL_TOOLTIP_TEXT = BM_REC_LEVEL_TOOLTIP_TEXT .. LIGHTYELLOW_FONT_COLOR_CODE .. BRL_TOOLTIP_RINSTANCES  .. BM_FONT_OFF .. "\n";
		for key, value in BM_RECOMMEND[BM_TEMP].instances do
			if (value.instance ~= BRL_NONE) then
				BM_REC_LEVEL_TOOLTIP_TEXT = BM_REC_LEVEL_TOOLTIP_TEXT .. value.instance .. "(" .. value.low_level .. "+ " .. BRL_RECOMMEND_TO ..  "  " .. value.high_level .. "+)" .. "\n";
			end
		end
	end

	BM_REC_LEVEL_TOOLTIP_TEXT = BM_REC_LEVEL_TOOLTIP_TEXT .. "\n" .. BM_WHITE .. BRL_TOOLTIP_RECOMMEND .. "\n" .. BM_FONT_OFF;
	for i = 0, table.getn(BM_RECOMMEND), 1 do
		if ( BM_RECOMMEND[i].high_level - player_level <= BM_RECOMMEND[i].range_level and 
		     BM_RECOMMEND[i].high_level - player_level >= 0 ) then	
			if (UnitFactionGroup("player") == BM_RECOMMEND[i].player_faction or BM_RECOMMEND[i].player_faction == BRL_CONTESTED) then
				-- Add zone name and level range.
				BM_TEMP_TEXT =	BM_GREEN .. BRL_TOOLTIP_RZONE .. BM_FONT_OFF .. BM_WHITE .. BM_RECOMMEND[i].zone .. " " .. BM_FONT_OFF ..
									BM_WHITE .. "(" .. BM_RECOMMEND[i].low_level .. "-" .. BM_RECOMMEND[i].high_level .. ")" .. "\n" .. BM_FONT_OFF;
				--Show Continent
				if ( BRL_CONFIG[BM_PLAYERNAME_REALM].show_tooltip_continent ) then
					BM_TEMP_TEXT = BM_TEMP_TEXT .. BM_GRAY .. BRL_TOOLTIP_RCONTINENT .. BM_FONT_OFF ..  BM_WHITE .. BM_RECOMMEND[i].continent .. BM_FONT_OFF .. "\n";
				end
				-- Show faction
				if ( BRL_CONFIG[BM_PLAYERNAME_REALM].show_tooltip_faction ) then
					BM_TEMP_TEXT = BM_TEMP_TEXT .. BM_GRAY .. BRL_TOOLTIP_RFACTION .. BM_FONT_OFF .. BM_WHITE .. BM_RECOMMEND[i].player_faction .. "\n" .. BM_FONT_OFF;
				end
				-- add any instances
				if (BRL_CONFIG[BM_PLAYERNAME_REALM].show_tooltip_instance) then
					local instancelist = "";
					--BM_TEMP_TEXT = BM_TEMP_TEXT .. LIGHTYELLOW_FONT_COLOR_CODE .. BRL_TOOLTIP_RINSTANCES  .. BM_FONT_OFF .. "\n";
					for key, value in BM_RECOMMEND[i].instances do
						if (value.itype == "instance") then
							instancelist = instancelist .. value.instance .. "(" .. value.low_level .. "+ " .. BRL_RECOMMEND_TO ..  "  " .. value.high_level .. "+)" .. "\n";
						elseif (value.itype == "battlegrounds") then
							instancelist = instancelist .. value.instance .. "(" .. value.low_level .. "+ " .. BRL_TOOLTIP_BG .. ")" .. "\n";
						end
					end
					if (instancelist ~= "") then
						BM_TEMP_TEXT = BM_TEMP_TEXT .. LIGHTYELLOW_FONT_COLOR_CODE .. BRL_TOOLTIP_RINSTANCES  .. BM_FONT_OFF .. "\n" .. instancelist;
					end
				end
				--[[
				if ( (BM_RECOMMEND[i].instances ~= BRL_NONE) and (BRL_CONFIG[BM_PLAYERNAME_REALM].show_tooltip_instance) ) then
					BM_TEMP_TEXT = BM_TEMP_TEXT .. BRL_TOOLTIP_RINSTANCES .. BM_WHITE .. BM_RECOMMEND[i].instances .. "\n" .. BM_FONT_OFF;
				end]]
				if (BRL_CONFIG[BM_PLAYERNAME_REALM].show_tooltip_faction or BRL_CONFIG[BM_PLAYERNAME_REALM].show_tooltip_instance) then
					BM_TEMP_TEXT = BM_TEMP_TEXT .. "\n";
				end
				BM_REC_LEVEL_TOOLTIP_TEXT = BM_REC_LEVEL_TOOLTIP_TEXT .. BM_TEMP_TEXT;
			end
		end
	end
	local temp_instance = "";
	local temp_battleground = "";
	for i = 0, table.getn(BM_RECOMMEND), 1 do
		for key, value in BM_RECOMMEND[i].instances do
			if (value.instance ~= BRL_NONE) then
				local range = value.high_level - value.low_level;
				if (value.itype == "instance" and not string.find(temp_instance, value.instance)) then
					if (value.faction == UnitFactionGroup("player") or value.faction == BRL_NONE) then
						if ( value.high_level - player_level <= range and value.high_level - player_level >= 0 ) then
							temp_instance = temp_instance .. BM_GREEN .. value.instance .. " (" .. value.low_level .. "+ " .. BRL_RECOMMEND_TO .. value.high_level .. "+)" .. BM_FONT_OFF .. "\n";
						end
					end
				elseif (value.itype == "battlegrounds" and not string.find(temp_battleground, value.instance)) then
					if (value.faction == UnitFactionGroup("player") or value.faction == BRL_NONE) then
						if ( value.high_level - player_level <= range and value.high_level - player_level >= 0 ) then
							temp_battleground = temp_battleground .. BM_GREEN .. value.instance  .. "(" .. value.low_level .. BRL_RECOMMEND_AND_UP .. ")" ..  BM_FONT_OFF .. "\n";
						end
					end
				end
			end
		end
	end

	if (BRL_CONFIG[BM_PLAYERNAME_REALM].show_rec_instances) then
		if (temp_instance ~= "") then
			BM_REC_LEVEL_TOOLTIP_TEXT = BM_REC_LEVEL_TOOLTIP_TEXT .. "\n" .. BM_WHITE .. BRL_RECOMMEND_INSTANCES .. BM_FONT_OFF.. "\n" .. temp_instance;
		end
	end
	if (BRL_CONFIG[BM_PLAYERNAME_REALM].show_rec_battlegrounds) then
		BM_REC_LEVEL_TOOLTIP_TEXT = BM_REC_LEVEL_TOOLTIP_TEXT .. "\n" .. BM_WHITE .. BRL_RECOMMEND_BATTLEGROUNDS .. BM_FONT_OFF .. "\n" .. temp_battleground;
	end
	
	--[[if (TITAN_INFO ~= nil) then
		return BM_REC_LEVEL_TOOLTIP_TEXT;
	end]]
end

-- when the mouse goes over the main frame, this gets called
function BMRecLevel_OnEnter()
	if (BRL_CONFIG[BM_PLAYERNAME_REALM].tooltip_enable) then
		if (BRL_SET_BOTTOM_TOP == "BOTTOM") then
			GameTooltip:SetOwner(this, "ANCHOR_NONE");
			GameTooltip:SetPoint("TOP" .. BRL_SET_LEFT_RIGHT, this, "BOTTOM" .. BRL_SET_LEFT_RIGHT, 0, 0);
			-- set the tool tip text
			GameTooltip:SetText(BRL_TOOPTIP_TITLE);
			GameTooltip:AddLine(BM_REC_LEVEL_TOOLTIP_TEXT);
			GameTooltip:Show();
		elseif (BRL_SET_BOTTOM_TOP == "TOP") then
			GameTooltip:SetOwner(this, "ANCHOR_NONE");
			GameTooltip:SetPoint("BOTTOM" .. BRL_SET_LEFT_RIGHT, this, "TOP" .. BRL_SET_LEFT_RIGHT, 0, 0);
			-- set the tool tip text
			GameTooltip:SetText(BRL_TOOPTIP_TITLE);
			GameTooltip:AddLine(BM_REC_LEVEL_TOOLTIP_TEXT);
			GameTooltip:Show();
		end
	end
end

function BMRecLevel_OnLeave()
	if (BRL_CONFIG[BM_PLAYERNAME_REALM].tooltip_enable == true) then
		-- put the tool tip in the default position
		GameTooltip_SetDefaultAnchor(GameTooltip, UIParent);
		GameTooltip:Hide();
	end
end

function BMRecLevelWorldMapButton_OnUpdate()
	local player_level = UnitLevel("player");
	local maptext = "";
	local temp_instance = "";
	local temp_battleground = "";
	 if (WorldMapFrame.areaName ~= nil) then 	
		 maptext = "";
		 for i = 0, table.getn(BM_RECOMMEND), 1 do
			if (string.find(BM_RECOMMEND[i].zone, WorldMapFrame.areaName)) then
				if (player_level <= (BM_RECOMMEND[i].low_level-4)) then
					maptext = format(REC_WORLDMAP_TEXT_RED, BM_RECOMMEND[i].low_level, BM_RECOMMEND[i].high_level) .. "\n";
					for key, value in BM_RECOMMEND[i].instances do
						if (value.instance ~= BRL_NONE) then
							if (value.itype == "instance") then
								temp_instance = temp_instance .. BM_WHITE .. value.instance .. " (" .. value.low_level .. "+ " .. BRL_RECOMMEND_TO .. value.high_level .. "+)" .. BM_FONT_OFF .. "\n";
							elseif (value.itype == "battlegrounds") then
								temp_battleground = temp_battleground .. BM_WHITE .. value.instance  .. "(" .. value.low_level .. BRL_RECOMMEND_AND_UP .. ")" ..  BM_FONT_OFF .. "\n";
							end
						end
					end
					if (temp_instance ~= "" or temp_battleground ~= "") then
						maptext = maptext .. BM_YELLOW .. BRL_TOOLTIP_RINSTANCES .. "\n" ..  temp_instance .. temp_battleground;
					end
				elseif (player_level < BM_RECOMMEND[i].low_level and player_level >= (BM_RECOMMEND[i].low_level-3)) then
					maptext = format(REC_WORLDMAP_TEXT_YELLOW, BM_RECOMMEND[i].low_level, BM_RECOMMEND[i].high_level) .. "\n";
					for key, value in BM_RECOMMEND[i].instances do
						if (value.instance ~= BRL_NONE) then
							if (value.itype == "instance") then
								temp_instance = temp_instance .. BM_WHITE .. value.instance .. " (" .. value.low_level .. "+ " .. BRL_RECOMMEND_TO .. value.high_level .. "+)" .. BM_FONT_OFF .. "\n";
							elseif (value.itype == "battlegrounds") then
								temp_battleground = temp_battleground .. BM_WHITE .. value.instance  .. "(" .. value.low_level .. BRL_RECOMMEND_AND_UP .. ")" ..  BM_FONT_OFF .. "\n";
							end
						end
					end
					if (temp_instance ~= "" or temp_battleground ~= "") then
						maptext = maptext .. BM_YELLOW .. BRL_TOOLTIP_RINSTANCES .. "\n" ..  temp_instance .. temp_battleground;
					end
				elseif (player_level >= BM_RECOMMEND[i].low_level and player_level <= (BM_RECOMMEND[i].high_level)) then
					maptext = format(REC_WORLDMAP_TEXT_GREEN, BM_RECOMMEND[i].low_level, BM_RECOMMEND[i].high_level) .. "\n";
					for key, value in BM_RECOMMEND[i].instances do
						if (value.instance ~= BRL_NONE) then
							if (value.itype == "instance") then
								temp_instance = temp_instance .. BM_WHITE .. value.instance .. " (" .. value.low_level .. "+ " .. BRL_RECOMMEND_TO .. value.high_level .. "+)" .. BM_FONT_OFF .. "\n";
							elseif (value.itype == "battlegrounds") then
								temp_battleground = temp_battleground .. BM_WHITE .. value.instance  .. "(" .. value.low_level .. BRL_RECOMMEND_AND_UP .. ")" ..  BM_FONT_OFF .. "\n";
							end
						end
					end
					if (temp_instance ~= "" or temp_battleground ~= "") then
						maptext = maptext .. BM_YELLOW .. BRL_TOOLTIP_RINSTANCES .. "\n" ..  temp_instance .. temp_battleground;
					end
				else
					maptext = format(REC_WORLDMAP_TEXT_GRAY, BM_RECOMMEND[i].low_level, BM_RECOMMEND[i].high_level) .. "\n";
					for key, value in BM_RECOMMEND[i].instances do
						if (value.instance ~= BRL_NONE) then
							if (value.itype == "instance") then
								temp_instance = temp_instance .. BM_WHITE .. value.instance .. " (" .. value.low_level .. "+ " .. BRL_RECOMMEND_TO .. value.high_level .. "+)" .. BM_FONT_OFF .. "\n";
							elseif (value.itype == "battlegrounds") then
								temp_battleground = temp_battleground .. BM_WHITE .. value.instance  .. "(" .. value.low_level .. BRL_RECOMMEND_AND_UP .. ")" ..  BM_FONT_OFF .. "\n";
							end
						end
					end
					if (temp_instance ~= "" or temp_battleground ~= "") then
						maptext = maptext .. BM_YELLOW .. BRL_TOOLTIP_RINSTANCES .. "\n" ..  temp_instance .. temp_battleground;
					end
				end
			end
		end
	else
		maptext = "";
	end

	if (WorldMapFrame.poiHighlight == 1) then
		maptext = "";
		for i = 0, table.getn(BM_RECOMMEND), 1 do
			if (string.find(BM_RECOMMEND[i].zone, WorldMapFrameAreaLabel:GetText())) then
				maptext = format(REC_WORLDMAP_TEXT, BM_RECOMMEND[i].player_faction) .. "\n";
				for key, value in BM_RECOMMEND[i].instances do
					if (value.instance ~= BRL_NONE) then
						if (value.itype == "instance") then
							temp_instance = BM_WHITE .. value.instance .. " (" .. value.low_level .. "+ " .. BRL_RECOMMEND_TO .. value.high_level .. "+)" .. BM_FONT_OFF .. "\n";
						elseif (value.itype == "battlegrounds") then
							temp_battleground = BM_WHITE .. value.instance  .. "(" .. value.low_level .. BRL_RECOMMEND_AND_UP .. ")" ..  BM_FONT_OFF .. "\n";
						end
					end
				end
				if (temp_instance ~= "" or temp_battleground ~= "") then
					maptext = maptext .. BM_YELLOW .. BRL_TOOLTIP_RINSTANCES .. "\n" ..  temp_instance .. temp_battleground;
				end
			end
		end
	end
	BMRecLevelWorldMapText:SetText(maptext);
end

function BRL_Zone_Info_Enable(msg)
	if (msg == false) then
		BRL_CONFIG[BM_PLAYERNAME_REALM].zone_info_enable = false;
		BMRecLevelFrame:Hide();
		BMRecLevel:Hide();
	else
		BRL_CONFIG[BM_PLAYERNAME_REALM].zone_info_enable = true;
		BMRecLevelFrame:Show();
		BMRecLevel:Show();
	end	
end

function BRL_Tooltip_Enable(msg)
	if (msg == false) then
		BRL_CONFIG[BM_PLAYERNAME_REALM].tooltip_enable = false;
	else
		BRL_CONFIG[BM_PLAYERNAME_REALM].tooltip_enable = true;
	end	
end

function BRL_Map_Text_Enable(msg)
	if (msg == false) then
		BRL_CONFIG[BM_PLAYERNAME_REALM].map_text_enable = false;
		BMRecLevelWorldMap:Hide();
	else
		BRL_CONFIG[BM_PLAYERNAME_REALM].map_text_enable = true;
		BMRecLevelWorldMap:Show();
	end	
end

function BRL_Tooltip_Offset_Left(msg)
	if (msg == false) then
		BRL_CONFIG[BM_PLAYERNAME_REALM].tooltip_offset_left = false;
		BRL_SET_LEFT_RIGHT = "RIGHT";
	else
		BRL_CONFIG[BM_PLAYERNAME_REALM].tooltip_offset_left = true;
		BRL_SET_LEFT_RIGHT = "LEFT";
	end	
end

function BRL_Tooltip_Offset_Bottom(msg)
	if (msg == false) then
		BRL_CONFIG[BM_PLAYERNAME_REALM].tooltip_offset_bottom = false;
		BRL_SET_BOTTOM_TOP = "TOP";
	else
		BRL_CONFIG[BM_PLAYERNAME_REALM].tooltip_offset_bottom = true;
		BRL_SET_BOTTOM_TOP = "BOTTOM";
	end	
end

function BRL_Show_Tooltip_Faction(msg)
	if (msg == false) then
		BRL_CONFIG[BM_PLAYERNAME_REALM].show_tooltip_faction = false;
	else
		BRL_CONFIG[BM_PLAYERNAME_REALM].show_tooltip_faction = true;
	end	
	BMRecLevel_Update_Text();
end

function BRL_Show_Tooltip_Instance(msg)
	if (msg == false) then
		BRL_CONFIG[BM_PLAYERNAME_REALM].show_tooltip_instance = false;
	else
		BRL_CONFIG[BM_PLAYERNAME_REALM].show_tooltip_instance = true;
	end	
	BMRecLevel_Update_Text();
end
	
function BRL_Border_Alpha(msg)
	if (msg < 0 or msg > 1) then
		UIErrorsFrame:AddMessage(BRL_ERROR_MESSAGE_1, 1.0, 0.0, 0.0, 1.0, UIERRORS_HOLD_TIME);
	else
		BRL_CONFIG[BM_PLAYERNAME_REALM].border_alpha = msg;
		BMRecLevelFrame:SetAlpha(BRL_CONFIG[BM_PLAYERNAME_REALM].border_alpha);
	end
end

function  BRL_Show_Zone(msg)
	BRL_CONFIG[BM_PLAYERNAME_REALM].show_zone = msg;
	BMRecLevel_Update_Text();
end

function  BRL_Reset_SlashHandler()
	StaticPopup_Show("BRL_RESET_ALL");
end

function BRL_Reset_Everything()
	BRL_CONFIG[BM_PLAYERNAME_REALM].zone_info_enable = DEFAULT_BRL_ZONE_INFO_ENABLE;
	BRL_CONFIG[BM_PLAYERNAME_REALM].tooltip_enable = DEFAULT_BRL_TOOLTIP_ENABLE;
	BRL_CONFIG[BM_PLAYERNAME_REALM].map_text_enable = DEFAULT_BRL_MAP_TEXT_ENABLE;
	BRL_CONFIG[BM_PLAYERNAME_REALM].tooltip_offset_left = DEFAULT_BRL_TOOLTIP_OFFSET_LEFT;
	BRL_CONFIG[BM_PLAYERNAME_REALM].tooltip_offset_bottom = DEFAULT_BRL_TOOLTIP_OFFSET_BOTTOM;
	BRL_CONFIG[BM_PLAYERNAME_REALM].show_tooltip_faction = DEFAULT_BRL_SHOW_TOOLTIP_FACTION;
	BRL_CONFIG[BM_PLAYERNAME_REALM].show_tooltip_instance = DEFAULT_BRL_SHOW_TOOLTIP_INSTANCE;
	BRL_CONFIG[BM_PLAYERNAME_REALM].border_alpha = DEFAULT_BRL_BORDER_ALPHASLIDER;
	BRL_CONFIG[BM_PLAYERNAME_REALM].show_zone = false;
	BRL_CONFIG[BM_PLAYERNAME_REALM].show_rec_instances = true;
	BRL_CONFIG[BM_PLAYERNAME_REALM].show_rec_battlegrounds = true;
	BRL_CONFIG[BM_PLAYERNAME_REALM].show_tooltip_continent = false;

	BMRecLevelFrame:ClearAllPoints();
	BMRecLevelFrame:SetPoint("CENTER", "UIParent", "CENTER", 0, 0);
	BMRecLevelFrame:Show();
	BMRecLevel:Show();
	BRL_SET_BOTTOM_TOP = "BOTTOM";
	BRL_SET_LEFT_RIGHT = "LEFT";
end

function BRL_Toogle_RecInstances(msg)
	BRL_CONFIG[BM_PLAYERNAME_REALM].show_rec_instances =  msg;
	BMRecLevel_Update_Text();
end

function BRL_Toogle_RecBattlegrounds(msg)
	BRL_CONFIG[BM_PLAYERNAME_REALM].show_rec_battlegrounds = msg;
	BMRecLevel_Update_Text();
end

function BRL_Show_Tooltip_Continent(msg)
	BRL_CONFIG[BM_PLAYERNAME_REALM].show_tooltip_continent = msg;
	BMRecLevel_Update_Text();
end

function BRL_Show_Moveable_Frame(msg)
	BRL_CONFIG[BM_PLAYERNAME_REALM].show_moveable_frame = msg;
	if (msg == true and BRL_CONFIG[BM_PLAYERNAME_REALM].zone_info_enable == true) then
		BMRecLevel:ClearAllPoints();
		BMRecLevel:SetPoint("CENTER", "BMRecLevelFrame", "CENTER", 0, 0);
		BMRecLevelFrame:Show();
		BMRecLevel:Show();
	else
		BMRecLevelFrame:Hide();
		BMRecLevel:Hide();
	end
	if (msg == true) then
		DEFAULT_CHAT_FRAME:AddMessage(BM_GREEN .. BRL_ACTIVE_INFO);
	else
		DEFAULT_CHAT_FRAME:AddMessage(BM_GREEN .. BRL_DISABLED_INFO);
	end
	BMRecLevel_Update_Text();
end
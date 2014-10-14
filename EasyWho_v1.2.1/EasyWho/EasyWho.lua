--------------------------------------------------------------------------------------------------
-- Globals
--------------------------------------------------------------------------------------------------

EW_VERSION = "v1.2.1";

local EW_UpdateRate = 0.33;
local EW_LastUpdate = 0.0;
local EW_Faction = nil;

--------------------------------------------------------------------------------------------------
-- Event functions
--------------------------------------------------------------------------------------------------
function EW_OnClick(request)
	local BGrequest = false;
	local BGalterac = false;
	
	-- Request for Battleground ?
	if (request == EW_ARATHI or request == EW_WARSONG or request == EW_ALTERAC) then
		BGrequest = true;
	end
			
	----------------------------------------
	-- v1.2.1
	-- Is Alterac Valley request?
	if (request == EW_ALTERAC) then
		BGalterac = true;
	end
	----------------------------------------
	
	-- Request is nil or Battleground ?
	if (request ~= nil) then
		if (BGrequest == true) then
			request = 'z-"' .. request .. '"';
		else
			request = 'c-"' .. request .. '"';
		end
	else
		request = "";
	end
	
	-- Current Zone and not Battleground 
	if (CheckButton_PlayerZone:GetChecked() and BGrequest == false) then
		local ZoneName = GetRealZoneText();
		request = request .. ' z-"' .. ZoneName .. '"';
	end

	-- Looking for Player's Level Player
	if (CheckButton_PlayerLevel:GetChecked()) then
		local level = UnitLevel("player");
		local minlevel = 0;
		local maxlevel = 0;
		
		-- Request for Battleground ?
		if (BGrequest == true) then
			if (level < 10) then
				minlevel = 1;
				maxlevel = 9;
			elseif (level < 20) then
				minlevel = 10;
				maxlevel = 19;
			elseif (level < 30) then
				minlevel = 20;
				maxlevel = 29;
			elseif (level < 40) then
				minlevel = 30;
				maxlevel = 39;
			elseif (level < 50) then
				minlevel = 40;
				maxlevel = 49;
			elseif (level < 60) then
				minlevel = 50;
				maxlevel = 59;
			else
				minlevel = 60;
				maxlevel = 60;
			end
			
			----------------------------------------
			-- v1.2.1
			-- Is Alterac Valley request?
			
			if (BGalterac == true) then
				if (level < 11) then
					minlevel = 1;
					maxlevel = 10;
				elseif (level < 21) then
					minlevel = 11;
					maxlevel = 20;
				elseif (level < 31) then
					minlevel = 21;
					maxlevel = 30;
				elseif (level < 41) then
					minlevel = 31;
					maxlevel = 40;
				elseif (level < 51) then
					minlevel = 41;
					maxlevel = 50;
				else
					minlevel = 51;
					maxlevel = 60;
				end
			end
			----------------------------------------
		else
			minlevel = level - 3;
			if (minlevel < 1) then
				minlevel = 1;
			end
		
			maxlevel = level + 3;
			if (maxlevel > 60) then
				maxlevel = 60;
			end
		end
		
		request = request .. " " .. minlevel .. "-" .. maxlevel;
	end
	DEFAULT_CHAT_FRAME:AddMessage("WhoRequest: " .. request, 0, 1, 1);
	SendWho(request);
end

function EW_OnLoad()
	DEFAULT_CHAT_FRAME:AddMessage("EasyWho " .. EW_VERSION .. " " .. EW_LOADED, 0, 1, 1);
	DEFAULT_CHAT_FRAME:AddMessage("by Lugh@BootyBay.de", 0, 1, 1);
	
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
end

function EW_OnEvent()
	if (event == "PLAYER_ENTERING_WORLD") then
		EW_Faction = UnitFactionGroup("player");
	end
end

function EW_OnUpdate()
	EW_LastUpdate = EW_LastUpdate + arg1;
	if (EW_LastUpdate > EW_UpdateRate) then
		EW_Show();
		EW_LastUpdate = 0.0;
	end
end

--------------------------------------------------------------------------------------------------
-- UserInterface functions
--------------------------------------------------------------------------------------------------
function EW_Show()
	if (WhoFrame:IsVisible()) then
		Button_Mage:Show();
		Button_Warlock:Show();
		if (EW_Faction == "Horde") then
			Button_Shaman:Show();
			Button_Paladin:Hide();
		else
			Button_Shaman:Hide();
			Button_Paladin:Show();
		end
		Button_Warrior:Show();
		Button_Hunter:Show();
		Button_Rogue:Show();
		Button_Druid:Show();
		Button_Priest:Show();
		Button_Arathi:Show();
		Button_Warsong:Show();
		Button_Alterac:Show();
		Button_All:Show();
		CheckButton_PlayerLevel:Show();
		CheckButton_PlayerZone:Show();
	else
		Button_Mage:Hide();
		Button_Warlock:Hide();
		Button_Shaman:Hide();
		Button_Paladin:Hide();
		Button_Warrior:Hide();
		Button_Hunter:Hide();
		Button_Rogue:Hide();
		Button_Druid:Hide();
		Button_Priest:Hide();
		Button_Arathi:Hide();
		Button_Warsong:Hide();
		Button_Alterac:Hide();
		Button_All:Hide();
		CheckButton_PlayerLevel:Hide();
		CheckButton_PlayerZone:Hide();
	end
end
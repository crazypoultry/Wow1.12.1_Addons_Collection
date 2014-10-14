
local realmName;
local playerName;

STATCOMPARE_DEFAULT_MINIMAP_POSITION = 45;

StatCompare_OPTIONS = {
	["ShowSTR"] = {
		["default"] = 1 },
	["ShowAGI"] = {
		["default"] = 1 },
	["ShowSTA"] = {
		["default"] = 1 },
	["ShowINT"] = {
		["default"] = 1 },
	["ShowSPI"] = {
		["default"] = 1 },
	["ShowArmor"] = {
		["default"] = 1 },
	["ShowEnArmor"] = {
		["default"] = 1 },
	["ShowDR"] = {
		["default"] = 1 },
	["ShowArcaneRes"] = {
		["default"] = 1 },
	["ShowFireRes"] = {
		["default"] = 1 },
	["ShowNatureRes"] = {
		["default"] = 1 },
	["ShowFrostRes"] = {
		["default"] = 1 },
	["ShowShadowRes"] = {
		["default"] = 1 },
	["ShowDetarRes"] = {
		["default"] = 1 },
	["MinimapButtonVisible"] = {
		["default"] = 1 },
	["ShowFishing"] = {
		["default"] = 1 },
	["ShowMining"] = {
		["default"] = 1 },
	["ShowHerbalism"] = {
		["default"] = 1 },
	["ShowSkinning"] = {
		["default"] = 1 },
	["ShowDefense"] = {
		["default"] = 1 },
	["ShowBlock"] = {
		["default"] = 1 },
	["ShowToBlock"] = {
		["default"] = 1 },
	["ShowDodge"] = {
		["default"] = 1 },
	["ShowParry"] = {
		["default"] = 1 },
	["ShowAP"] = {
		["default"] = 1 },
	["ShowCrit"] = {
		["default"] = 1 },
	["ShowRAP"] = {
		["default"] = 1 },
	["ShowRCrit"] = {
		["default"] = 1 },
	["ShowToHit"] = {
		["default"] = 1 },
	["ShowHealthRegen"] = {
		["default"] = 1 },
	["ShowHealth"] = {
		["default"] = 1 },
	["ShowManaRegen"] = {
		["default"] = 1 },
	["ShowManaRegenSPI"] = {
		["default"] = 1 },
	["ShowMana"] = {
		["default"] = 1 },
	["MinimapButtonPosition"] = {
		["default"] = STATCOMPARE_DEFAULT_MINIMAP_POSITION },
	["ShowMinimapIcon"] = {
		["default"] = 1 },
	["ShowSelfFrame"] = {
		["default"] = 1	},
	["ShowBuffBonus"] = {
		["default"] = 0	},
}

function StatCompare_Toggle()
	if(not StatCompareOptFrame) then
		return
	end
	if(StatCompareOptFrame:IsVisible()) then
		StatCompareOptFrame:Hide();
	else
		StatCompareOptFrame:Show();
		for i=1,2 do
			getglobal("StatCompareOptTab"..i):UnlockHighlight();
			getglobal("StatCompareOptSubFrame"..i):Hide();
		end
		getglobal("StatCompareOptTab"..1):LockHighlight();
		getglobal("StatCompareOptSubFrame"..1):Show();
		if(StatCompare_Player and StatCompare_Player["Settings"]) then
			for k,v in StatCompare_Player["Settings"] do
				if(getglobal(k)) then
					if(v == 1) then
						getglobal(k):SetChecked(1);
					else
						getglobal(k):SetChecked(0);
					end
				end
			end
		end
		local value=StatCompare_GetSetting("ShowMinimapIcon", value);
		if(value == 0) then
			getglobal("StatCompareShowMinimapOpt"):SetChecked(0);
		else
			getglobal("StatCompareShowMinimapOpt"):SetChecked(1);
		end
		local value=StatCompare_GetSetting("ShowSelfFrame", value);
		if(value == 0) then
			getglobal("StatCompareShowSelfFrameOpt"):SetChecked(0);
		else
			getglobal("StatCompareShowSelfFrameOpt"):SetChecked(1);
		end
		local value=StatCompare_GetSetting("ShowBuffBonus", value);
		if(value == 0) then
			getglobal("StatCompareShowBuffBonusOpt"):SetChecked(0);
		else
			getglobal("StatCompareShowBuffBonusOpt"):SetChecked(1);
		end
	end
end

function StatCompareMinimapButton_UpdatePosition()
	local showIcon = StatCompare_GetSetting("ShowMinimapIcon");
	if(showIcon == 1) then
		local where = StatCompare_GetSetting("MinimapButtonPosition");
		StatCompareMinimapFrame:ClearAllPoints();
		StatCompareMinimapFrame:SetPoint("TOPLEFT", "Minimap", "TOPLEFT",
					 52 - (80 * cos(where)),
					 (80 * sin(where)) - 52);
	end
end

function StatCompareOptCheck_OnClick()
	local value = 0;

	if(this:GetChecked()) then
		value = 1;
	end
	StatCompare_SetSetting(this:GetName(), value);
end

function StatCompareOptTab_OnClick()
	local id,i = this:GetID()
	PlaySound("GAMEGENERICBUTTONPRESS")

	if id and id>0 then
		for i=1,2 do
			getglobal("StatCompareOptTab"..i):UnlockHighlight();
			getglobal("StatCompareOptSubFrame"..i):Hide();
		end
		getglobal("StatCompareOptTab"..id):LockHighlight();
		getglobal("StatCompareOptSubFrame"..id):Show();
		if(id == 1 and StatCompare_Player and StatCompare_Player["Settings"]) then
			for k,v in StatCompare_Player["Settings"] do
				if(getglobal(k)) then
					if(v == 1) then
						getglobal(k):SetChecked(1);
					else
						getglobal(k):SetChecked(0);
					end
				end
			end
		end

	end
end

function StatCompareOptFrame_Hide()
	StatCompare_SaveConfigInfo();
	StatCompareOptFrame:Hide();
end

function StatCompare_CheckPlayerInfo()
	local tabs = { "Settings" };

	if ( not StatCompare_Player ) then
		StatCompare_Player = {};
		for _,tab in tabs do
			StatCompare_Player[tab] = { };
		end

		if ( StatCompare_Info[realmName] and
			StatCompare_Info[realmName]["Settings"] and
			StatCompare_Info[realmName]["Settings"][playerName] ) then
			for _,tab in tabs do
				if ( StatCompare_Info[realmName][tab] and
					StatCompare_Info[realmName][tab][playerName] ) then
					for k,v in StatCompare_Info[realmName][tab][playerName] do
						StatCompare_Player[tab][k] = v;
					end
				end
			end
		end
	elseif ( StatCompare_Info[realmName] and StatCompare_Info[realmName]["Settings"] ) then
		-- the saved information is there, kill the old stuff
		for _,tab in tabs do
			if ( StatCompare_Info[realmName][tab] ) then
				StatCompare_Info[realmName][tab][playerName] = nil;
				if ( next(StatCompare_Info[realmName][tab]) == nil ) then
					StatCompare_Info[realmName][tab] = nil;
				end
			end
		end
		if ( next(StatCompare_Info[realmName]) == nil ) then
			StatCompare_Info[realmName] = nil;
		end
	end
end

-- Fill in the player name and realm
function StatCompare_SetupNameInfo()
	playerName = UnitName("player");
	realmName = GetRealmName();
	return playerName, realmName;
end

function StatCompare_SetSetting(setting, value)
	if ( StatCompare_Player and setting ) then
		local val = StatCompare_GetDefault(setting);
		if ( val == value ) then
			StatCompare_Player["Settings"][setting] = nil;
		else
			StatCompare_Player["Settings"][setting] = value;
		end
	end
end

function StatCompare_GetSetting(setting)
	if ( not StatCompare_Player or not StatCompare_Player["Settings"] ) then
		return;
	end
	local val = StatCompare_Player["Settings"][setting];
	if ( val == nil ) then
		val = StatCompare_GetDefault(setting);
	end
	return val;
end

function StatCompare_GetDefault(setting)
	local opt = StatCompare_OPTIONS[setting];
	if ( opt ) then
		if ( opt.check and opt.checkfail ) then
			if ( not opt.check() ) then
				return opt.checkfail;
			end
		end
		return opt.default;
	end
end

function StatCompare_SaveConfigInfo()
	if ( StatCompare_Info[realmName] and
		StatCompare_Info[realmName]["Settings"] and
		StatCompare_Info[realmName]["Settings"][playerName] ) then
		local tabs = { "Settings" };
		for _,tab in tabs do
			for k,v in StatCompare_Player[tab] do
				StatCompare_Info[realmName][tab][playerName][k] = v;
			end
		end
	end
end

function StatCompare_InitConfig()
	playerName, realmName = StatCompare_SetupNameInfo();
	if( not StatCompare_Info ) then
		StatCompare_Info = { };
	end
	
	-- global stuff
	StatCompare_CheckRealm();
	StatCompare_CheckPlayerInfo();
	
	-- per user stuff
	if ( not StatCompare_Player["Settings"] ) then
		StatCompare_Player["Settings"] = { };
	end
	if(StatCompareMinimapFrame) then
		StatCompareMinimapButton_UpdatePosition();
	end
end

function StatCompare_CheckRealm()
	if ( StatCompare_Info["Settings"] ) then
		local old = StatCompare_Info["Settings"][playerName];
			
		if ( old ) then
			if ( not StatCompare_Info[realmName] ) then
				StatCompare_Info[realmName] = { };
				for _,tab in tabs do
					StatCompare_Info[realmName][tab] = { };
				end
			end
				
			StatCompare_Info[realmName][tab][playerName] = { };
			for k, v in old do
				StatCompare_Info[realmName][tab][playerName][k] = v;
			end
			StatCompare_Info[tab][playerName] = nil;
		end
			
		-- clean out cruft, if we have some
		StatCompare_Info["Settings"][UNKNOWNOBJECT] = nil;
		StatCompare_Info["Settings"][UKNOWNBEING] = nil;
		
		-- Duh, table.getn doesn't work because there
		-- aren't any integer keys in this table
		if ( next(StatCompare_Info["Settings"]) == nil ) then
			StatCompare_Info["Settings"] = nil;
		end
	end
end

function StatCompareShowMinimapOpt_OnClick()
	local value = 0;

	if(this:GetChecked()) then
		value = 1;
	end
	StatCompare_SetSetting("ShowMinimapIcon", value);
	if(value == 0 and StatCompareMinimapFrame:IsVisible()) then
		StatCompareMinimapFrame:Hide();
	elseif(value == 1 and not StatCompareMinimapFrame:IsVisible()) then
		StatCompareMinimapFrame:Show();
		StatCompareMinimapButton_UpdatePosition()
	end
end

function StatCompareShowSelfFrameOpt_OnClick()
	local value = 0;

	if(this:GetChecked()) then
		value = 1;
	end
	StatCompare_SetSetting("ShowSelfFrame", value);	
end

function StatCompareShowBuffBonusOpt_OnClick()
	local value = 0;

	if(this:GetChecked()) then
		value = 1;
	end
	StatCompare_SetSetting("ShowBuffBonus", value);	
end

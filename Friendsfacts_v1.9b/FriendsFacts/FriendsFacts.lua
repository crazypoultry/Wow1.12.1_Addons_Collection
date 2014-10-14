--------------------------------------------------------------------------
-- FriendsFacts.lua 
--------------------------------------------------------------------------
--[[
FriendsFacts

author: AnduinLothar    <karlkfi@cosmosui.org>

Replaces and builds on an old Cosmos FrameXML/FriendsFrame.lua Hack.

Records and displays friend level, class, location, pvpname, sex, race, and guild. 
TODO: check how old the data is and not display it if older than some arbitrary value
		
Change Log:
v1.9 (8/19/06)
-Removed Localization dependancy
v1.8 (7/14/06)
-Fixed UnitSex usage for 1.11
v1.7 (4/4/06)
-Converted the event frame to a lua alternative
-Optimized code by removing old hooking code
-Now uses the Localization addon for localized text
-ToDo: localize the friends display text - FRIENDS_LIST_TEMPLATE, FRIENDS_LIST_OFFLINE_TEMPLATE and perhaps PVPName, area, and status
v1.6 (1/26/06)
-Embedded SeaHooks to fix some dependancy issues.
v1.51 (1/3/06)
-Fixed format bug and added AFK status
v1.5 (1/1/06)
-Who Searches of friends now update their FriendFacts info.
-Auto-Update of FriendsFrame if open while info is updated.
v1.4 (11/29/05)
-Added storing of player data for use on alts on the same server.
-Added optional Sea hook usage for good measure.
-Updated TOC to 10900
v1.31 (9/19/05)
-Fixed FriendsFacts_Data nil error
v1.3 (9/6/05)
-Added Khaos Options for FriendsFacts_Enabled and FriendsFacts_PVPName booleans
-To disable PVPName manually use "/script FriendsFacts_PVPName=nil"
v1.2 (8/17/05)
-Added Mouseover Data to Friends List.
If you've ever seen a tooltip of that player it will record and show their pvpname, sex, race, and guild.
-Made Friend List Realm Specific (Warning! All old friend data will be lost).
If you are planning on moving from one faction to another you should clear the list for that realm:
/script FriendsFacts_Data[GetRealmName()] = {};
-Added auto-truncation for strings that would extend past the edge of the frame.
v1.1 (4/29/05)
-Friend info now stored for all friends and not just the ones you look at.
-nil index bug fixed.
v1.0 (2/19/05)
-Rerelease in addon form.
-Modified Width for offline overflow with long location names.

]]--

FriendsFacts_Enabled = true;
FriendsFacts_PVPName = true;
FriendsFacts_Data = {};

--Localization.SetAddonDefault("FriendsFacts", "enUS");
--local function TEXT(key) return Localization.GetString("FriendsFacts", key) end
local function TEXT(key) return getglobal(key) end

function FriendsFacts_OnEvent()
	if ( event == "VARIABLES_LOADED" ) then
		if ( FriendsFacts_Enabled ) then
			if ( not FriendsFacts_Data ) then
				FriendsFacts_Data = {};
			end
			if (not FriendsFacts_Data[GetRealmName()]) then
				FriendsFacts_Data[GetRealmName()] = {};
			end
		end
	elseif ( event == "CHAT_MSG_SYSTEM" ) and ( strfind(arg1, WHO_NUM_RESULTS) ) then
		local numWhos, totalCount = GetNumWhoResults();
		local name, guild, level, race, class, zone, group;
		for i=1, numWhos do
			name, guild, level, race, class, zone, group = GetWhoInfo(i);
		end
	end
end


function FriendsFacts_FriendsList_Update()
	if ( FriendsFacts_Enabled ) then
		local nameLocationText, infoText, friendIndex;
		local friendOffset = FauxScrollFrame_GetOffset(FriendsFrameFriendsScrollFrame);
		local numFriends = GetNumFriends();
		local realm = GetRealmName();
		
		--Update Player data
		local name = UnitName("player")
		if ( not FriendsFacts_Data[realm][name] ) then
			FriendsFacts_Data[realm][name] = {};
		end
		FriendsFacts_Data[realm][name].level = UnitLevel("player");
		FriendsFacts_Data[realm][name].class = UnitClass("player");
		FriendsFacts_Data[realm][name].area = GetRealZoneText();
					
		--Update Friend data
		for i=1, numFriends do
			local name, level, class, area, connected, status = GetFriendInfo(i);
			local PVPName, race, sex, guild;
			if (name) then
				if (connected) then
					if ( not FriendsFacts_Data[realm][name] ) then
						FriendsFacts_Data[realm][name] = {};
					end
					FriendsFacts_Data[realm][name].level = level;
					FriendsFacts_Data[realm][name].class = class;
					FriendsFacts_Data[realm][name].area = area;
				end
				if (i > friendOffset) and (i <= friendOffset+FRIENDS_TO_DISPLAY) and (FriendsFacts_Data[realm][name]) then
				
					nameLocationText = getglobal("FriendsFrameFriendButton"..(i-friendOffset).."ButtonTextNameLocation");
					infoText = getglobal("FriendsFrameFriendButton"..(i-friendOffset).."ButtonTextInfo");
					
					if (area == UNKNOWN) then 
						area = FriendsFacts_Data[realm][name].area;
					end
					--if ( not area ) then area = UNKNOWN; end
					PVPName = FriendsFacts_Data[realm][name].PVPName;
					
					if (connected) then
						if (PVPName) and (FriendsFacts_PVPName) then
							nameLocationText:SetText(format(FRIENDS_LIST_TEMPLATE, PVPName, area, status));
						else
							nameLocationText:SetText(format(FRIENDS_LIST_TEMPLATE, name, area, status));
						end
					else
						if (PVPName) and (FriendsFacts_PVPName) then
							nameLocationText:SetText(format(FRIENDS_LIST_OFFLINE_TEMPLATE, PVPName.." - "..area));
						else
							nameLocationText:SetText(format(FRIENDS_LIST_OFFLINE_TEMPLATE, name.." - "..area));
						end
					end
					
					if ( nameLocationText:GetWidth() > 275 ) then
						--Auto-truncate long strings
						nameLocationText:SetJustifyH("LEFT");
						nameLocationText:SetWidth(275);
						nameLocationText:SetHeight(14);
					end
					
					if (level == 0) and (FriendsFacts_Data[realm][name].level) then
						level = FriendsFacts_Data[realm][name].level;
					end
					if (class == UNKNOWN) and (FriendsFacts_Data[realm][name].class) then 
						class = FriendsFacts_Data[realm][name].class;
					end
					race = FriendsFacts_Data[realm][name].race;
					if (race) then class = race.." "..class; end
					sex = FriendsFacts_Data[realm][name].sex;
					if (sex) then class = sex.." "..class; end
					guild = FriendsFacts_Data[realm][name].guild;
					if (guild) then class = class.." <"..guild..">"; end
					
					infoText:SetText(format(FRIENDS_LEVEL_TEMPLATE, level, class));
					
					if ( infoText:GetWidth() > 275 ) then
						--Auto-truncate long strings
						infoText:SetJustifyH("LEFT");
						infoText:SetWidth(275);
						infoText:SetHeight(10);
					end
				end
			end
		end
	end
end


function FriendsFacts_SetUnit(self, unit)
	if (type(unit) ~= "string") then
		return;
	end
	if ( UnitIsPlayer(unit) ) then
		local realm = GetRealmName();
		local name = UnitName(unit);
		if (not FriendsFacts_Data[realm][name]) then
			return;
		end

		FriendsFacts_Data[realm][name].PVPName = UnitPVPName(unit);
		FriendsFacts_Data[realm][name].race = UnitRace(unit);
		if (UnitSex(unit) == 3) then
			FriendsFacts_Data[realm][name].sex = FEMALE;
		else
			FriendsFacts_Data[realm][name].sex = MALE;
		end
		FriendsFacts_Data[realm][name].guild, FriendsFacts_Data[realm][name].guildRankName = GetGuildInfo(unit);
		if (FriendsFrame:IsVisible() and FriendsFrame.selectedTab == 1) then
			FriendsList_Update();
		end
	end
end

function FriendsFacts_GetWhoInfo(i)
	local name, guild, level, race, class, zone, group = Sea.util.getReturnArgs();
	
	local realm = GetRealmName();
	local thisCharacter = FriendsFacts_Data[realm][name];
	if (thisCharacter) then
		if (guild ~= "") then
			thisCharacter.guild = guild;
		end
		thisCharacter.level = level;
		thisCharacter.race = race;
		thisCharacter.class = class;
		thisCharacter.zone = zone;
		if (FriendsFrame:IsVisible() and FriendsFrame.selectedTab == 1) then
			FriendsList_Update();
		end
	end
end

function FriendsFacts_Register_Khaos()
	local optionSet = {
		id="FriendsFacts";
		text=function() return TEXT("FRIENDSFACTS_CONFIG_HEADER") end;
		helptext=function() return TEXT("FRIENDSFACTS_CONFIG_HEADER_INFO") end;
		difficulty=1;
		default={checked=true};
		options={
			{
				id="Header";
				text=function() return TEXT("FRIENDSFACTS_CONFIG_HEADER") end;
				helptext=function() return TEXT("FRIENDSFACTS_CONFIG_HEADER_INFO") end;
				type=K_HEADER;
				difficulty=1;
			};
			{
				id="FriendsFactsEnable";
				type=K_TEXT;
				text=function() return TEXT("FRIENDSFACTS_ENABLED") end;
				helptext=function() return TEXT("FRIENDSFACTS_ENABLED_INFO") end;
				callback=function(state)
					if (state.checked) then
						FriendsFacts_Enabled = true;
					else
						FriendsFacts_Enabled = nil;
					end
				end;
				feedback=function(state) return TEXT("FRIENDSFACTS_ENABLED_INFO"); end;
				check=true;
				default={checked=true};
				disabled={checked=false};
			};
			{
				id="FriendsFactsPVPName";
				type=K_TEXT;
				text=function() return TEXT("FRIENDSFACTS_PVPNAME") end;
				helptext=function() return TEXT("FRIENDSFACTS_PVPNAME_INFO") end;
				callback=function(state)
					if (state.checked) then
						FriendsFacts_PVPName = true;
					else
						FriendsFacts_PVPName = nil;
					end
				end;
				feedback=function(state) return TEXT("FRIENDSFACTS_PVPNAME_INFO"); end;
				check=true;
				default={checked=false};
				disabled={checked=false};
			};
		};
	};
	Khaos.registerOptionSet(
		"other",
		optionSet
	);
end


-- Event Driver

local eventDriver = CreateFrame("Frame", "FriendsFactsFrame");
eventDriver:RegisterEvent("VARIABLES_LOADED")
eventDriver:RegisterEvent("CHAT_MSG_SYSTEM");
eventDriver:SetScript("OnEvent", FriendsFacts_OnEvent)


-- Direct Execution

-- Hook the FriendsList_Update handler
Sea.util.hook("FriendsList_Update", "FriendsFacts_FriendsList_Update", "after");
-- Hook GameTooltip.SetUnit to gather friend info whenever the tooltip is updated
Sea.util.hook("GameTooltip.SetUnit", "FriendsFacts_SetUnit", "after");
-- Hook GetWhoInfo to gather friend info whenever the who list is updated
Sea.util.hook("GetWhoInfo", "FriendsFacts_GetWhoInfo", "after");

if (Khaos) then
	FriendsFacts_Register_Khaos();
end



local L = AceLibrary("AceLocale-2.0"):new("devnull")
local Z = AceLibrary("Babble-Zone-2.0")
local T = AceLibrary("Tourist-2.0")

local nullCities = {
	[Z["Stormwind City"]] = true,
	[Z["Ironforge"]] = true,
	[Z["Darnassus"]] = true,
	[Z["Orgrimmar"]] = true,
	[Z["Undercity"]] = true,
	[Z["Thunder Bluff"]] = true,
}
local nullTowns = {
	[Z["Booty Bay"]] = true, 
	[Z["Gadgetzan"]] = true,
	[Z["Everlook"]] = true,

}
-- Steamwheedle Cartel Zones
local swcZones = {
    [Z["Stranglethorn Vale"]] = true, 
    [Z["Tanaris"]] = true,
    [Z["Winterspring"]] = true,
}
local checkEvent = {
    ["ZONE_CHANGED_NEW_AREA"] = true,
    ["AceEvent_FullyInitialized"] = true,
}

-- if the Debug library is available then use it
if AceLibrary:HasInstance("AceDebug-2.0") then
	devnull = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceDB-2.0", "AceConsole-2.0", "AceHook-2.0", "AceDebug-2.0")
    -- turn on Debug mode
    --devnull:SetDebugging(true)
    -- set level of debug messages
    devnull:SetDebugLevel(2)
else
	devnull = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceDB-2.0", "AceConsole-2.0", "AceHook-2.0")
	function devnull:LevelDebug() end
end

-- specify where debug messages go
devnull.debugFrame = ChatFrame5
-- setup database for saved variables
devnull:RegisterDB("devnullDB", "devnullDBPerChar")
devnull:RegisterDefaults('profile', {
	CHAT_MSG_YELL = true,
	CHAT_MSG_MONSTER_YELL = true,
	CHAT_MSG_MONSTER_SAY = true,
	CHAT_MSG_TEXT_EMOTE = true,
	CHAT_MSG_MONSTER_EMOTE = true,
	CHAT_MSG_SPELL_TRADESKILLS = false,
	noDuel = true,
	noDrunk = true,
	chatback = true,
	inInstance = false,
	-- ChatFrame1 channel settings
	cf1Channels = {
	   [L["General"]] = false,
	   [L["Trade"]] = false,
	   [L["LocalDefense"]] = false,
	   [L["WorldDefense"]] = false,
	   [L["LookingForGroup"]] = false,
	   [L["GuildRecruitment"]] = false,
    },
   -- Instance channel settings
	iChannels = {
	   [L["General"]] = true,
	   [L["LocalDefense"]] = true,
	   [L["WorldDefense"]] = true,
	   [L["LookingForGroup"]] = true,
    },
})

devnull:RegisterChatCommand({ "/devnull", "/null", "/dn" }, {
	type = 'group',
	args = {
		chat = {
			type = 'toggle',
			name = L["CHAT_NAME"],
			desc = L["CHAT_DESC"],
			get = function() return devnull.db.profile.chatback end,
			set = function(v) devnull.db.profile.chatback = v end,
		},
		yell = {
			type = 'toggle',
			name = L["YELL_NAME"],
			desc = L["YELL_DESC"],
			get = function() return devnull.db.profile.CHAT_MSG_YELL end,
			set = function(v) devnull.db.profile.CHAT_MSG_YELL = v devnull.db.profile.CHAT_MSG_MONSTER_YELL = v end,
		},
		npc = {
			type = 'toggle',
			name = L["NPC_NAME"],
			desc = L["NPC_DESC"],
			get = function() return devnull.db.profile.CHAT_MSG_MONSTER_SAY end,
			set = function(v) devnull.db.profile.CHAT_MSG_MONSTER_SAY = v end,
		},
		duel = {
			type = 'toggle',
			name = L["DUEL_NAME"],
			desc = L["DUEL_DESC"],
			get = function() return devnull.db.profile.noDuel end,
			set = function(v) devnull.db.profile.noDuel = v end,
		},
		drunk = {
			type = 'toggle',
			name = L["DRUNK_NAME"],
			desc = L["DRUNK_DESC"],
			get = function() return devnull.db.profile.noDrunk end,
			set = function(v) devnull.db.profile.noDrunk = v end,
		},
		emote = {
			type = 'toggle',
			name = L["EMOTE_NAME"],
			desc = L["EMOTE_DESC"],
			get = function() return devnull.db.profile.CHAT_MSG_TEXT_EMOTE end,
			set = function(v) devnull.db.profile.CHAT_MSG_TEXT_EMOTE = v devnull.db.profile.CHAT_MSG_MONSTER_EMOTE = v end,
        },
        ts = {
			type = 'toggle',
    		name = L["TS_NAME"],
        	desc = L["TS_DESC"],
    		get = function() return devnull.db.profile.CHAT_MSG_SPELL_TRADESKILLS end,
			set = function(v) devnull.db.profile.CHAT_MSG_SPELL_TRADESKILLS = v end,
        },
        iGen = {
			type = 'toggle',
    		name = L["IGEN_NAME"],
        	desc = L["IGEN_DESC"],
    		get = function() return devnull.db.profile.iChannels[L["General"]] end,
			set = function(v) devnull.db.profile.iChannels[L["General"]] = v end,
        },
        iLFG = {
			type = 'toggle',
    		name = L["ILFG_NAME"],
        	desc = L["ILFG_DESC"],
    		get = function() return devnull.db.profile.iChannels[L["LookingForGroup"]] end,
			set = function(v) devnull.db.profile.iChannels[L["LookingForGroup"]] = v end,
        }
	}
})


function devnull:OnInitialize()

    if AceLibrary:HasInstance("AceDebug-2.0") then
		self:LevelDebug(1, "OnInitialize")
    end

end


function devnull:OnEnable()
	self:LevelDebug(1, "OnEnable")

	-- Initial setup when starting, reloading or zoning
	self:RegisterEvent("AceEvent_FullyInitialized", "Addon_FullyInitialized")
	
	-- when addon taken out of standby
	if AceLibrary("AceEvent-2.0"):IsFullyInitialized() then
		self:Addon_FullyInitialized("sAFI")
	end

end


function devnull:OnDisable()
	self:LevelDebug(1, "OnDisable")
	
	-- turn channels back on
    for channel, on in pairs(self.db.profile.cf1Channels) do
        if on then ChatFrame_AddChannel(ChatFrame1, channel) end
    end
	
end


function devnull:Addon_FullyInitialized(...)
	self:LevelDebug(1, "Addon_FullyInitialized: [%s]", unpack(arg))

	self:RegisterEvent("ZONE_CHANGED_NEW_AREA", "CheckZone")

	self:CheckZone(unpack(arg))
	
end


function devnull:CheckZone(...)
	self:LevelDebug(1, "CheckZone: [%s]", event or unpack(arg))
    self:LevelDebug(2,"You Are Here: [%s:%s]", GetRealZoneText() or "???", GetSubZoneText() or "???")
 
    --> Pre Event Handler <--
    -- if entering a new area or just been loaded or come out of standby
    if checkEvent[event] or unpack(arg) == "sAFI" then
        -- if in a zone with a Steamwheedle Cartel town in it then track the ZONE_CHANGED event 
        if swcZones[GetRealZoneText()]then
            self:RegisterEvent("ZONE_CHANGED", "CheckZone")
        -- if we had been in an Instance\Battleground then continue
        elseif self.db.profile.inInstance then
            self.db.profile.inInstance = false
        else
        -- otherwise save the current channel settings for Chat Frame 1
            for key, _ in pairs(self.db.profile.cf1Channels) do
                self.db.profile.cf1Channels[key] = false
            end
            local cwc = {GetChatWindowChannels(1)}
            for  i = 1, table.getn(cwc), 2 do
	           self:LevelDebug(3, "cwc: [%s]", cwc[i])
	           self.db.profile.cf1Channels[cwc[i]] = true
            end
        end
    else
        -- if event already registered, unregister it
        if self:IsEventRegistered("ZONE_CHANGED") then
            self:UnregisterEvent("ZONE_CHANGED")
        end
    end

    --> Event Handler <--    
	if nullCities[GetRealZoneText()] or nullTowns[GetSubZoneText()] then
		if not self:IsHooked("ChatFrame_OnEvent") then
		  self:Hook("ChatFrame_OnEvent")
		  if self.db.profile.chatback then self:Print(L["enabled"]) end
        end
	else
		if self:IsHooked("ChatFrame_OnEvent") then
			self:Unhook("ChatFrame_OnEvent")
			if self.db.profile.chatback then self:Print(L["disabled"]) end
		end
	end

    -- are we in a Battleground ? (Must do before Instance check)
    if T:IsBattleground(GetRealZoneText()) then
        if self.db.profile.chatback then self:Print(L["battleground"]) end
        self.db.profile.inInstance = true
    -- are we in an Instance ?
    elseif T:IsInstance(GetRealZoneText()) then
        if self.db.profile.chatback then self:Print(L["instance"]) end
        self.db.profile.inInstance = true
    end
    
    --> Post Event Handler <--
    -- if entering a new area or just been loaded or come out of standby
    if checkEvent[event]  or unpack(arg) == "sAFI" then
        -- Mute chat in Instances\Battlegrounds
        if self.db.profile.inInstance then
            for channel, off in pairs(self.db.profile.iChannels) do
                if off then ChatFrame_RemoveChannel(ChatFrame1, channel) end
            end
        else
            for channel, on in pairs(self.db.profile.cf1Channels) do
                if on then ChatFrame_AddChannel(ChatFrame1, channel) end
            end
        end
    end
    
end


function devnull:ChatFrame_OnEvent(event)
	self:LevelDebug(1, "ChatFrame_OnEvent:[%s]", event or "???")
	self:LevelDebug(3, "CF_OE:[%s:%s]", arg2 or "???", arg1 or "???")

	if self.db.profile[event] then return end

	if event == "CHAT_MSG_SYSTEM" then
		if self.db.profile.noDuel and string.find(arg1, L["in a duel"]) then return end
		if self.db.profile.noDrunk and (
			string.find(arg1, L["tipsy"]) or string.find(arg1, L["drunk"])
			or string.find(arg1, L["smashed"]) or string.find(arg1, L["sober"])) then return end
	end

	self.hooks.ChatFrame_OnEvent.orig(event)
	
end

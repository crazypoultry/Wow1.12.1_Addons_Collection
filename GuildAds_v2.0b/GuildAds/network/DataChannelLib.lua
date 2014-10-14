---------------------------------------------------------------------------
-- You MUST update the major version whenever you make an incompatible
-- change
---------------------------------------------------------------------------
-- You MUST update the minor version whenever you make a compatible
-- change (And check LibActivate is still valid!)
---------------------------------------------------------------------------

local vmajor, vminor = "1", 1
local stubvarname = "DataChannelLibStub"
local libvarname = "DataChannelLib"

-- Check to see if an update is needed
-- if not then just return out now before we do anything
local libobj = getglobal(libvarname)
if libobj and not libobj:NeedsUpgraded(vmajor, vminor) then return end

---------------------------------------------------------------------------
-- Embedded Library Registration Stub
-- Written by Iriel <iriel@vigilance-committee.org>
-- Version 0.1 - 2006-03-05
-- Modified by Tekkub <tekkub@gmail.com>
---------------------------------------------------------------------------

local stubobj = getglobal(stubvarname)
if not stubobj then
    stubobj = {}
    setglobal(stubvarname, stubobj)


    -- Instance replacement method, replace contents of old with that of new
    function stubobj:ReplaceInstance(old, new)
         for k,v in pairs(old) do old[k]=nil end
         for k,v in pairs(new) do old[k]=v end
    end


    -- Get a new copy of the stub
    function stubobj:NewStub(name)
        local newStub = {}
        self:ReplaceInstance(newStub, self)
        newStub.libName = name
        newStub.lastVersion = ''
        newStub.versions = {}
        return newStub
    end


    -- Get instance version
    function stubobj:NeedsUpgraded(vmajor, vminor)
        local versionData = self.versions[vmajor]
        if not versionData or versionData.minor < vminor then return true end
    end


    -- Get instance version
    function stubobj:GetInstance(version)
        if not version then version = self.lastVersion end
        local versionData = self.versions[version]
        if not versionData then print(string.format("<%s> Cannot find library version: %s", self.libName, version or "")) return end
        return versionData.instance
    end


    -- Register new instance
    function stubobj:Register(newInstance)
         local version,minor = newInstance:GetLibraryVersion()
         self.lastVersion = version
         local versionData = self.versions[version]
         if not versionData then
                -- This one is new!
                versionData = {
                    instance = newInstance,
                    minor = minor,
                    old = {},
                }
                self.versions[version] = versionData
                newInstance:LibActivate(self)
                return newInstance
         end
         -- This is an update
         local oldInstance = versionData.instance
         local oldList = versionData.old
         versionData.instance = newInstance
         versionData.minor = minor
         local skipCopy = newInstance:LibActivate(self, oldInstance, oldList)
         table.insert(oldList, oldInstance)
         if not skipCopy then
                for i, old in ipairs(oldList) do self:ReplaceInstance(old, newInstance) end
         end
         return newInstance
    end
end


---------------------------------------------------------------------------
-- Embedded Library
---------------------------------------------------------------------------

if not libobj then
    libobj = stubobj:NewStub(libvarname)
    setglobal(libvarname, libobj)
end

local lib = {}

-- Return the library's current version
function lib:GetLibraryVersion()
    return vmajor, vminor
end

-- Callbacks
lib.YOU_JOINED			= "YOU_JOINED";			-- (event, channelName, channelId)
lib.YOU_LEFT			= "YOU_LEFT";			-- (event, channelName)
lib.TOO_MANY_CHANNELS	= "TOO_MANY_CHANNELS";	-- (event, channelName)
lib.WRONG_NAME			= "WRONG_NAME";			-- (event, channelName)
lib.WRONG_PASSWORD		= "WRONG_PASSWORD";		-- (event, channelName)
lib.PASSWORD_CHANGED	= "PASSWORD_CHANGED";	-- (event, channelName, newPassword)

local callback = function(addonNameFilter, event, channelName, a1,a2,a3,a4,a5,a6,a7,a8,a9,a10)
	if addonNameFilter then
		if lib.Callbacks[addonNameFilter] then
			lib.Callbacks[addonNameFilter](event, channelName, a1,a2,a3,a4,a5,a6,a7,a8,a9,a10);
		end
	else
		for addonName in pairs(lib.Channels[channelName].Addons) do
			if lib.Callbacks[addonName] then
				lib.Callbacks[addonName](event, channelName, a1,a2,a3,a4,a5,a6,a7,a8,a9,a10);
			end
		end
	end
end

-- Join all waiting channels after the General channel is joined
local joinWaitingChannels = function()
	if lib.WaitingChannels then
		for _, channelName in lib.WaitingChannels do
			if lib.Channels[channelName] and not lib.Channels[channelName].ID then
				JoinChannelByName(channelName, lib.Channels[channelName].Password, lib.Channels[channelName].ChatFrame and lib.Channels[channelName].ChatFrame:GetID());
			end
		end
		lib.WaitingChannels = nil;
	end
end

-- onEvent
local onEvent = function()
	if event=="CHAT_MSG_CHANNEL_NOTICE" then
		local channelName = strlower(arg9);
		if lib.Channels[channelName] then
			if arg1=="YOU_JOINED" then
				lib.Channels[channelName].expectedJoin = nil;
				lib.Channels[channelName].ID = arg8;
				-- callback about join
				callback(nil, lib.YOU_JOINED, channelName, arg8);
			elseif arg1=="YOU_LEFT" then
				-- remove the channel from the chat frame ? perhaps already done
				if lib.Channels[channelName].ChatFrame then
					ChatFrame_RemoveChannel(lib.Channels[channelName].ChatFrame, channelName)
				end
				-- callback about leave
				callback(nil, lib.YOU_LEFT, channelName, lib.Channels[channelName].ID);
				-- delete info about the addons
				lib.Channels[channelName] = nil
			elseif arg1=="WRONG_PASSWORD" then
				-- callback about wrong password
				callback(nil, lib.WRONG_PASSWORD, channelName, lib.Channels[channelName].ID);
				-- delete info about the addons
				lib.Channels[channelName] = nil
			elseif arg1=="YOU_CHANGED" then
				-- Id has changed according to the Sky addon.
				self.Channels[channelName].ID = GetChannelName(channelName);
			end
		elseif arg1=="YOU_JOINED" and arg8==1 then
			joinWaitingChannels();
		end
	elseif event=="CHAT_MSG_SYSTEM" then
		if arg1==ERR_TOO_MANY_CHAT_CHANNELS then
			lib.gotTooManyChannelsMessage = true;
		end
	end
end

-- Activate a new instance of this library
function lib:LibActivate(stub, oldLib, oldList)
    local maj, min = self:GetLibraryVersion()
	
	-- Channel : fields : ID, Password, Addon, ChatFrame
	-- Callbacks : join, leave, failed to joined (too many channel, wrong channel name, wrong password), password changed
    if oldLib then
        local omaj, omin = oldLib:GetLibraryVersion()
		
		self.Frame = oldLib.Frame;
		self.Channels = oldLib.Channels or {};
		self.Callbacks = oldLib.Callbacks or {};
		self.WaitingChannels = oldLib.WaitingChannels or {};
	else
		self.Frame = CreateFrame("Frame", nil, UIParent);
		self.Channels = {};
		self.Callbacks = {};
		self.WaitingChannels = {};
	end
	self.Frame:SetScript("OnEvent", onEvent);
	self.Frame:UnregisterAllEvents();
	self.Frame:RegisterEvent("CHAT_MSG_CHANNEL_NOTICE");
	self.Frame:RegisterEvent("CHAT_MSG_SYSTEM");
	self.Frame:Show();
	
	if GetChannelList()==1 then
		joinWaitingChannels();
	end
    -- nil return makes stub do object copy
end

-- Register the callback of an addon
function lib:RegisterAddon(addonName, callbackFunction)
	self.Callbacks[addonName] = callbackFunction;
end

-- Open a channel
function lib:OpenChannel(addonName, channelName, password, chatFrame)
	if not(addonName and channelName) then
		return
	end

	local normalChannelName = channelName;
	channelName = strlower(channelName);
	
	local addChannelToChatFrame;
	if self.Channels[channelName] then
		-- the lib knows the channel
		if self.Channels[channelName].ChatFrame then
			chatFrame = self.Channels[channelName].ChatFrame;
		end
	else
		-- the lib does not know the channel
		local channelId = GetChannelName(channelName);
		if channelId == 0 then
			-- channelName is not joined
			channelId = nil;
		else
			-- channelName is already joined : the password must be wrong
		end
		self.Channels[channelName] = {
			Addons = {},
			ID = channelId;
		}
		addChannelToChatFrame = chatFrame and true;
	end
	
	-- add the addon
	self.Channels[channelName].Addons[addonName] = true;
	
	if self.Channels[channelName].ID then
		-- the channel is already joined
		
		-- callback about join
		callback(addonName, self.YOU_JOINED, channelName, self.Channels[channelName].ID);
		
		-- if the password changed, set the password
		if self.Channels[channelName].Password~=password then
			self.Channels[channelName].Password = password;
			SetChannelPassword(channelName, password)
			-- callback about password
			callback(nil, self.PASSWORD_CHANGED, channelName, password);
		end
	else
		-- the channel is not joined
		if self.Channels[channelName].Password~=password then
			-- joining with a different password ...
		end
		
		if self.WaitingChannels then
			tinsert(self.WaitingChannels, normalChannelName);
		else
			self.gotTooManyChannelsMessage = nil;
			if not JoinChannelByName(normalChannelName, password, chatFrame and chatFrame:GetID()) then
				-- not joined : wrong name
				self.Channels[channelName] = nil;
				-- callback about wrong name
				callback(nil, self.WRONG_NAME, channelName);
				-- 
				return false;
			end
			-- in case there is already 10 channels opened : the event CHAT_MSG_SYSTEM was triggered
			if self.gotTooManyChannelsMessage then
				-- not joined : delete channel from the lib
				self.Channels[channelName] = nil
				-- callback about too many channels
				callback(addonName, self.TOO_MANY_CHANNELS, channelName);
				--
				return false;
			end
		end
	end
	
	-- add the channel to chatFrame
	if addChannelToChatFrame then
		-- BUG si la chatframe est differente
		ChatFrame_AddChannel(chatFrame, channelName);
		self.Channels[channelName].ChatFrame = chatFrame;
	end
	
	self.Channels[channelName].Password = password;
	self.Channels[channelName].Addons[addonName] = true;
	
	return true;
end

-- Close a channel
function lib:CloseChannel(addonName, channelName)
	if not(addonName and channelName) then
		return
	end
	
	channelName = strlower(channelName);
	if self.Channels[channelName] and self.Channels[channelName].Addons[addonName] then
		if next(self.Channels[channelName].Addons, next(self.Channels[channelName].Addons)) then
			callback(addonName, self.YOU_LEFT, channelName, lib.Channels[channelName].ID);
			self.Channels[channelName].Addons[addonName] = nil;
		else
			self.Channels[channelName].ID = nil
			LeaveChannelByName(channelName)
		end
		return true;
	end
end

-- Get the current password of a channel
function lib:GetPasswordChannel(channelName)
	return self.Channels[channelName] and self.Channels[channelName].Password;
end

--------------------------------
--      Load this bitch!      --
--------------------------------
libobj:Register(lib)

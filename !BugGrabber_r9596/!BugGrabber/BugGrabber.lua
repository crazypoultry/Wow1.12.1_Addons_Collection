--
-- $Id: BugGrabber.lua 6441 2006-08-01 09:38:54Z fritti $
--

-- Create our event registering frame
local f = CreateFrame("Frame", "BugGrabber")

-- State variables
BugGrabber.loaded = false
BugGrabber.loadErrors = {}
BugGrabber.bugsackErrors = {}
BugGrabber.errors = {}
BugGrabber.previous = ""
BugGrabber.repeats = 0
BugGrabber.timeout = 30			-- timeout in secs for logging repeated events
BugGrabber.timeoutStarted = false
BugGrabber.lastUpdate = 0

-- Our persistent error database
BugGrabberDB = {}
BugGrabberDB.session = 0
BugGrabberDB.save = true
BugGrabberDB.limit = 100
BugGrabberDB.errors = {}

-- Determine the proper DB and return it
function BugGrabber.GetDB()
	if not BugGrabber.loaded then
		return BugGrabber.loadErrors
	end
	if not BugGrabberDB.save then
		return BugGrabber.errors
	end
	return BugGrabberDB.errors
end

-- OnUpdate handler to ensure that repeats will be logged after a timeout
function BugGrabber.CheckTimeout()
	BugGrabber.lastUpdate = BugGrabber.lastUpdate + arg1

	if (BugGrabber.lastUpdate > BugGrabber.timeout) then
		BugGrabber.LogRepeats()
	end
end

-- Log the nr of repeats and stop the timeout
function BugGrabber.LogRepeats()
	BugGrabber.SaveError(string.format("last message repeated %d times", BugGrabber.repeats))
	f:SetScript("OnUpdate", nil)
	BugGrabber.repeats = 0
	BugGrabber.timeoutStarted = false
end

-- Error handler
function BugGrabber.GrabError(_, err)
	-- Get the full backtrace
	err = err .. "\n" .. debugstack(4)

	-- Check to see if this is a repeat
	if err == BugGrabber.previous then
		-- If the timeout is not started yet, start it now
		if not BugGrabber.timeoutStarted then
			BugGrabber.timeoutStarted = true
			BugGrabber.lastUpdate = 0
			f:SetScript("OnUpdate", BugGrabber.CheckTimeout)
		end

		-- Count the repeat, but don't do anything else
		BugGrabber.repeats = BugGrabber.repeats + 1
		return
	end

	-- Log the repeat count of the previous error if any
	if BugGrabber.repeats > 0 then
		BugGrabber.LogRepeats()
	end

	-- Save the exact error message for comparison later
	BugGrabber.previous = err
	BugGrabber.repeats = 0

	-- Normalize the full paths into last directory component and filename.
	local errmsg = ""
	local looping = false
	for trace in string.gfind(err, "(.-)\n") do
		local match, found, path, file, line, msg
		found = false

		-- First detect an endless loop so as to abort it below
		if string.find(trace, "BugGrabber") then
			looping = true
		end

		-- "path\to\file.lua:linenum:message"
		if not found then
			match, _, path, file, line, msg = string.find(trace, "^.-([^\\]+\\)([^\\]-)(:%d+):(.*)$")
			if match then
				found = true
			end
		end

		-- "[string \"path\\to\\file.lua:<foo>\":linenum:message"
		if not found then
			match, _, path, file, line, msg = string.find(trace, "^%[string \".-([^\\]+\\)([^\\]-)\"%](:%d+):(.*)$")
			if match then
				found = true
			end
		end

		-- "[string \"FOO\":linenum:message"
		if not found then
			match, _, file, line, msg = string.find(trace, "^%[string (\".-\")%](:%d+):(.*)$")
			if match then
				found = true
				path = '<string>:'
			end
		end

		-- "[C]:message"
		if not found then
			match, _, msg = string.find(trace, "^%[C%]:(.*)$")
			if match then
				found = true
				path = '<in C code>'
				file = ''
				line = ''
			end
		end

		-- Anything else
		if not found then
			path = '<unknown>'
			file = ''
			line = ''
			msg = line
		end

		-- Add it to the formatted error
		errmsg = errmsg .. path .. file .. line .. ":" .. msg .. "\n"
	end

	-- Now store the error
	BugGrabber.SaveError(errmsg)
end

function BugGrabber.SaveError(message)
	-- Start with the date, time and session
	local oe = {}
	oe.session = BugGrabberDB.session
	oe.time = date("%Y/%m/%d %H:%M:%S")
	oe.message = "[" .. oe.time .. "-" .. oe.session .. "]: " .. message .. "\n  ---"

	-- WoW crashes when strings > 983 characters are stored in the
	-- SavedVariables file, so make sure we don't exceed that limit.
	-- For lack of a better thing to do, just truncate the error :-/
	if string.len(oe.message) > 980 then
		oe.message = string.sub(oe.message, 1, 980)
	end

	-- Insert the error into the correct database
	local db = BugGrabber.GetDB()
	table.insert(db, oe)

	-- Also insert it into the temporary capture database that we maintain
	-- to silence loading errors while we wait for BugSack to load
	if BugGrabber.bugsackErrors and type(BugGrabber.bugsackErrors) == "table" then
		table.insert(BugGrabber.bugsackErrors, oe)
	end

	-- Save only the last <limit> errors (otherwise the SV gets too big)
	if table.getn(db) > BugGrabberDB.limit then
		table.remove(db, 1)
	end

	-- Now trigger an event if someone's listening. If not, just print
	-- it to the chat frame so it doesn't get lost.
	if not looping and not BugGrabber.bugsackErrors and
	  AceLibrary and AceLibrary:HasInstance("AceEvent-2.0") and
	  AceLibrary("AceEvent-2.0"):IsEventRegistered("BugGrabber_BugGrabbed") then
		AceLibrary("AceEvent-2.0"):TriggerEvent("BugGrabber_BugGrabbed", oe)
	else
		if not BugGrabber.bugsackErrors then
			DEFAULT_CHAT_FRAME:AddMessage("BugGrabber captured an error:\n" ..
			  oe.message)
		end
	end
end

-- Event handlers
function BugGrabber.AddonLoaded()
	BugGrabber.loaded = true

	-- Persist defaults and make sure we have sane SavedVariables
	if not BugGrabberDB or type(BugGrabberDB) ~= "table" then
		BugGrabberDB = {}
	end
	if not BugGrabberDB.session or type(BugGrabberDB.session) ~= "number" then
		BugGrabberDB.session = 0
	end
	if not BugGrabberDB.errors or type(BugGrabberDB.errors) ~= "table" then
		BugGrabberDB.errors = {}
	end
	if not BugGrabberDB.limit or type(BugGrabberDB.limit) ~= "number" then
		BugGrabberDB.limit = 100
	end
	if BugGrabberDB.save == nil or type(BugGrabberDB.save) ~= "boolean" then
		BugGrabberDB.save = true
	end

	-- From now on we can persist errors. Create a new session.
	BugGrabberDB.session = BugGrabberDB.session + 1

	-- Determine the correct database
	local db = BugGrabber.GetDB()

	-- Cut down on the nr of errors if it is over 100
	while table.getn(db) + table.getn(BugGrabber.loadErrors) > BugGrabberDB.limit do
		table.remove(db, 1)
	end

	-- Save the errors that occurred while our variables were loading
	-- in the correct database.
	for _,err in pairs(BugGrabber.loadErrors) do
		err.session = BugGrabberDB.session
		table.insert(db, err)
	end

	-- Now do away with the temporary database
	BugGrabber.loadErrors = nil
end

function BugGrabber.PlayerLogin()
	-- On player login, check to see whether we had load time errors and
	-- display them in the chat frame if we can't find BugSack. We cheat
	-- by letting BugSack reset BugGrabber.bugsackErrors so we can just
	-- check that.
	local err = BugGrabber.bugsackErrors
	if err and type(err) == "table" and table.getn(err) > 0 then
		DEFAULT_CHAT_FRAME:AddMessage("There were " ..
			tostring(table.getn(err)) .. " startup errors:")
		for k,e in ipairs(err) do
			DEFAULT_CHAT_FRAME:AddMessage(tostring(k) .. ". " .. e.message)
		end
	end

	-- No need to wait for BugSack to load anymore
	BugGrabber.bugsackErrors = nil
end

function BugGrabber.OnEvent()
	if event == "ADDON_LOADED" and arg1 == "!BugGrabber" then
		BugGrabber.AddonLoaded()
	elseif event == "PLAYER_LOGIN" then
		BugGrabber.PlayerLogin()
	end
end

-- Simple setters/getters for settings, meant to be accessed by BugSack
function BugGrabber.GetSave()
	return BugGrabberDB.save
end

function BugGrabber.ToggleSave()
	BugGrabberDB.save = not BugGrabberDB.save
	if BugGrabberDB.save then
		BugGrabberDB.errors = BugGrabber.errors
		BugGrabber.errors = {}
	else
		BugGrabber.errors = BugGrabberDB.errors
		BugGrabberDB.errors = {}
	end
end

function BugGrabber.GetLimit()
	return BugGrabberDB.limit
end

function BugGrabber.SetLimit(l)
	if not l or type(l) ~= "number" or l < 10 or l > 100 then
		return
	end

	BugGrabberDB.limit = math.floor(l)

	local db = BugGrabber.GetDB()
	while table.getn(db) > l do
		table.remove(db, 1)
	end
end

-- Save the old handlers in case someone wants to restore them
BugGrabber.oldset = ScriptErrors_Message.SetText
BugGrabber.oldshow = ScriptErrors.Show

-- Set up the new handlers
ScriptErrors_Message.SetText = BugGrabber.GrabError
ScriptErrors.Show = function() end

-- Now register for our needed events
f:RegisterEvent("ADDON_LOADED")
f:RegisterEvent("PLAYER_LOGIN")
f:SetScript("OnEvent", BugGrabber.OnEvent)

-- vim:set ts=4:

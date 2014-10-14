KIC_DEFAULT_OPTIONS = {
	screen  = TRUE,
	chat    = TRUE,
	sound   = TRUE,
	across  = TRUE,
	startup = TRUE,
	time    = "remaining"
}
--[[--------------------------------------------------------------------------------
	Class Setup
-----------------------------------------------------------------------------------]]

KeepItCool = AceAddon:new({
	name          = KIC.NAME,
	description   = KIC.DESCRIPTION,
	version       = "1.4.0",
	releaseDate   = "05-07-2006",
	aceCompatible = 103,
	author        = "Stylpe",
	email         = "mikalhh@hotmail.com",
	website       = "http://www.pixelus.net",
	category      = "professions",
	db            = AceDatabase:new("kicDB"),
	defaults      = KIC_DEFAULT_OPTIONS,
	cmd           = AceChatCmd:new(KIC.COMMANDS, KIC.CMD_OPTIONS)
})

local tablet, dewdrop, compost, metro
if FuBar then
	tablet  = TabletLib:GetInstance('1.0')
	dewdrop = DewdropLib:GetInstance('1.0')
	compost = CompostLib:GetInstance('compost-1')
	metro   = Metrognome:GetInstance('1')

	KeepItCoolFu = FuBarPlugin:GetInstance("1.2"):new({
		name          = KIC.NAME .. "Fu",
		description   = KIC.DESCRIPTION,
		version       = "1.3.1",
		releaseDate   = "05-07-2006",
		aceCompatible = 103,
		author        = "Stylpe",
		email         = "mikalhh@hotmail.com",
		website       = "http://www.pixelus.net",
		category      = "professions",
		db            = AceDatabase:new("kicFuDB"),
		updateTime    = 1.0,
		numReady      = 0,
		numCooling    = 0,
		profileCode   = true
	})
end

function KeepItCool:Initialize()
	self.Msg    = function(...) self.cmd:result(format(unpack(arg))) end
	self.GetC   = function() return self.db:get("Cooldowns") end
	self.SetC   = function(key, val) return self.db:set({"Cooldowns"}, key, val) end
	self.ResetC = function() return self.db:set("Cooldowns", {}) end
	self.GetP   = function(var) return self.db:get(self.profilePath, var) end
	self.SetP   = function(var, val) return self.db:set(self.profilePath, var, val) end
	self.TogP   = function(var) return self.db:toggle(self.profilePath, var, val) end

	if not self.GetC() then self.ResetC() end

	-- Upgrade DB from old versions
	local ver = self.db:get("DBVer")
	if not ver then -- Upgrade from before DBVer was implemented
		for k, v in self.db:get({"Global"}, "cooldowns") or {} do self.SetC(k, v) end
		self.db:set("Global")
		self.db:set("DBVer", 1)
	elseif ver == "1" then
		self.db:set("DBVer", 1)
	end
end


--[[--------------------------------------------------------------------------------
	Addon Enabling/Disabling
-----------------------------------------------------------------------------------]]

function KeepItCool:StartTimers(s)
	local start
	for k, v in self.GetC() do
		if (string.find(k, ace.char.id) or self.GetP("across")) then 
			if  v == 0 then 
				if FuBar then KeepItCoolFu.numReady = KeepItCoolFu.numReady + 1 KeepItCoolFu:UpdateText() end
				if s and self.GetP("startup") then
					self:Remind(k, TRUE)
					start = TRUE
				end
			else
				if FuBar then KeepItCoolFu.numCooling = KeepItCoolFu.numCooling + 1 KeepItCoolFu:UpdateText() end
				Timex:AddSchedule("kic." .. k, v - time(), FALSE, 1, KeepItCool["Remind"], KeepItCool, k)
			end
		end
	end
	if start then
		if self.GetP("screen") then self.PrintOverheadText({1.0,1.0,1.0,5}, KIC.REAGENT) end
		if self.GetP("chat") then self.cmd:msg(KIC.REAGENT) end
		if self.GetP("sound") then PlaySound("LEVELUP") end
	end
end

function KeepItCool:StopTimers()
	for k in self.GetC() do Timex:DeleteSchedule("kic." .. k) end
end

function KeepItCool:Enable()
	self:RegisterEvent("CHAT_MSG_LOOT", "CheckIt")
	self:RegisterEvent("CHAT_MSG_SYSTEM", "CheckUnlearned")
	

	
	self:StartTimers(TRUE)
end

function KeepItCool:Disable()
	self:StopTimers()
end


--[[--------------------------------------------------------------------------------
	Main Processing
-----------------------------------------------------------------------------------]]

function KeepItCool:CheckIt(s)
--	local _, _, item = string.find(s or arg1, KIC.SEARCHFILTER1)
--	if not item then _, _, item = string.find(s or arg1, KIC.SEARCHFILTER2) end
  local item, item1, item2
	local _, _, item1 = string.find(s or arg1, KIC.SEARCHFILTER1)
	if not item1 then _, _, item1 = string.find(s or arg1, KIC.SEARCHFILTER3) end
	if not item1 then _, _, item2 = string.find(s or arg1, KIC.SEARCHFILTER2) end
	if item2 and KIC.ITEMS[item2] then
    if KIC.ITEMS[item2].c == 1 then
 	    return
    end
	end
	if item1 then item = item1 end
	if item2 then item = item2 end
	if item and KIC.ITEMS[item] then
		local i, t = KIC.ITEMS[item].i, KIC.ITEMS[item].t
		local cat = KIC.CAT[i]
		key = ace.char.id .. "#" .. i
		if FuBar then
			local prev = self.GetC()[key]
			if not prev then 
				KeepItCoolFu.numCooling = KeepItCoolFu.numCooling + 1 
			elseif prev == 0 then 
				KeepItCoolFu.numReady = KeepItCoolFu.numReady - 1 
				KeepItCoolFu.numCooling = KeepItCoolFu.numCooling + 1
			end
			KeepItCoolFu:UpdateText()
		end
		self.SetC(key, time() + t)
		Timex:AddSchedule("kic." .. key, t, FALSE, 1, KeepItCool["Remind"], KeepItCool, key)
		self.Msg(KIC.ADD, cat, self.StoDHMS(t, TRUE))
	end
end

function KeepItCool:CheckUnlearned()
	local _, _, prof = string.find(arg1, KIC.UNLEARNFILTER)
	local id = prof and KIC.PROF[prof]
	if id then 
		local key = ace.char.id .. "#" .. id
		Timex:DeleteSchedule("kic." .. key)
		if FuBar then
			local prev = self.GetC()[key] or -1
			if prev == 0 then KeepItCoolFu.numReady = KeepItCoolFu.numReady - 1
			elseif prev > 0 then KeepItCoolFu.numCooling = KeepItCoolFu.numCooling - 1
			end
			KeepItCoolFu:UpdateText()
		end
		self.SetC(key)
	end
end

function KeepItCool:Remind(key, start)
	local  _, _, id, name, realm, i, msg = string.find(key, "((.-) "..ACE_TEXT_OF.." (.*))#(%d)")
	i = tonumber(i)
	if not start then 
		self.SetC(key, 0)
		if FuBar then 
			KeepItCoolFu.numCooling = KeepItCoolFu.numCooling - 1
			KeepItCoolFu.numReady = KeepItCoolFu.numReady + 1
			KeepItCoolFu:UpdateText()
		end
	end
	if self.GetP("chat") or self.GetP("screen") then
		if id == ace.char.id then
			msg = format(KIC.REMIND, KIC.CAT[i])
		else
			msg = format(KIC.REMOTEREMIND, KIC.CAT[i], id)
		end
		if not start then msg = msg .. "\n" .. KIC.REAGENT end
		if self.GetP("screen") then self.PrintOverheadText({1.0,1.0,1.0,5}, msg) end
		if self.GetP("chat") then self.cmd:msg(msg) end
	end
	if self.GetP("sound") then PlaySound("LEVELUP") end
end

function KeepItCool:GetOffset()
	if not self.Offset then
		local serverHour, serverMinute = GetGameTime()
		local localHour = tonumber(date("%H"))
		local localMinute = tonumber(date("%M"))
		local utcHour = tonumber(date("!%H"))
		local utcMinute = tonumber(date("!%M"))
		local ser = serverHour + serverMinute / 60
		local loc = localHour + localMinute / 60
		local utc = utcHour + utcMinute / 60
		local serOff = floor((ser - utc) * 2 + 0.5) / 2
		if serOff >= 12 then
			serOff = serOff - 24
		elseif serOff < -12 then
			serOff = serOff + 24
		end
		local locOff = floor((loc - utc) * 2 + 0.5) / 2
		if locOff >= 12 then
			locOff = locOff - 24
		elseif locOff < 12 then
			locOff = locOff + 24
		end
		self.Offset = serOff - locOff
	end
	return self.Offset
end

--[[---------------------------------------------------------------------------------
	Chat Handlers
------------------------------------------------------------------------------------]]

function KeepItCool:ReportData()
	local _, id, i, found, msg
	self.cmd:msg(KIC.DATAREPORT)
	for k, v in self.GetC() do
		found = TRUE
		_, _, id, i = string.find(k, "(.*)#(%d)")
		i = tonumber(i)
		msg = id .. ", " .. KIC.CAT[i] .. ": "
		if v == 0 then
			msg = msg .. "|cff00ff00" .. KIC.READY
		else
			msg = msg .. "|cffffe000" 
			local t = self.GetP("time")
			if t == "remaining" then
			    msg = msg .. self.StoDHMS(v - time()) .. "|r" .. KIC.REMAINING
			elseif t == "game" then
				msg = msg .. date(nil, v + self.GetOffset()) .. "|r"
			else -- t == "local"
				msg = msg .. date(nil, v) .. "|r"
			end
		end
		ace:print(msg)
	end
	if not found then ace:print(KIC.EMPTYDB) end
end

function KeepItCool:Reset()
	self.cmd:msg(KIC.RESETASK)
end

function KeepItCool:ReallyReset()
	self.ResetC()
	if FuBar then
		KeepItCoolFu.numReady      = 0
		KeepItCoolFu.numCooling    = 0
		KeepItCoolFu:UpdateText()
	end
	self.cmd:msg(KIC.RESET)
end

function KeepItCool:Report()
	local tmpdb = {}
	for k, v in KIC.REPORT do
		tinsert(tmpdb, {text=v, val=self.GetP(k), map=ACEG_MAP_ONOFF})
	end
	tinsert(tmpdb, {text=KIC.TIMEREPORT, val=KIC.TIMEOPTS[self.GetP("time")]})
	self.cmd:report(tmpdb)
end


function KeepItCool:SetOpt(i)
	i = string.lower(i)
	local _, _, k, v = string.find(i, "(%a+)%s*(%a*)")
	if KIC.REPORT[k] then
		if v == KIC.ON then
			self.SetP(k, TRUE)
		elseif v == KIC.OFF then
			self.SetP(k, FALSE)
		elseif v == KIC.TOG then
			self.TogP(k)
		elseif v ~= "" then
			self.cmd:msg(format(KIC.ERR_INPUT, KIC.SETSYN))
			return
		end
		self.cmd:report({{text=KIC.REPORT[k], val=self.GetP(k), map=ACEG_MAP_ONOFF}})
		if k == "across" then self:StopTimers() self:StartTimers() end
	else
		self.cmd:msg(format(KIC.ERR_INPUT, KIC.SETSYN))
	end
end

function KeepItCool:SetTime(mode)
	if mode ~= "" then
		mode = string.lower(mode)
		if KIC.TIMEOPTS[mode] then
			self.SetP("time", mode)
		else
			self.cmd:msg(format(KIC.ERR_INPUT, KIC.TIMESYN))
			return
		end
	end
	self.cmd:report({{text=KIC.TIMEREPORT, val=KIC.TIMEOPTS[self.GetP("time")]}})
end

--[[--------------------------------------------------------------------------------
	FuBar Functionality
-----------------------------------------------------------------------------------]]
if FuBar then

function KeepItCoolFu:Enable()
	metro:Register(self.name, self.UpdateTooltip, 1, self)
	metro:Start(self.name)
end

function KeepItCoolFu:Disable()
	metro:Unregister(self.name)
end

function KeepItCoolFu:OnUpdate()
	KeepItCoolFu:Update()
end

function KeepItCoolFu:UpdateText()
	self:SetText("KIC: C:|cffd0d0ff" .. self.numCooling ..
	             "|r R:|cff00ff00" .. self.numReady .. "|r")
end

function KeepItCoolFu:UpdateTooltip()
	local C = KeepItCool.GetC()
	local ts, x = KeepItCool.GetP("time")
	local cats = compost:GetTable()
	for k, v in C do
		local _, _, name, realm, i = string.find(k, "(.-) "..ACE_TEXT_OF.." (.*)#(%d)")
		i = tonumber(i)
		if v == 0 then
			x = "|cff00ff00"..KIC.READY.."|r"
		else
			if ts == "remaining" then x = KeepItCool.StoDHMS(v - time()) .. KIC.REMAINING
			elseif ts == "game" then x = date(nil, v + KeepItCool:GetOffset())
			else x = date(nil, v) end
			x = "|cffd0d0ff"..x.."|r"
		end
		if not cats[realm] then
			cats[realm] = tablet:AddCategory(
				'columns', 2,
				'text', realm
			)
		end
		
		if not cats[realm..name] then
			cats[realm..name] = cats[realm]:AddCategory(
				'text', "|cffffaa00"..name.."|r",
				'indentation', 5,
				'hideBlankLine', true
			) 
		end
		
		cats[realm..name]:AddLine(
			'text', KIC.CAT[i],
			'text2', x,
			'indentation', 10
		)
	end
	compost:Reclaim(cats)
end

function KeepItCoolFu:MenuSettings(level, value)
	if level == 1 then
		dewdrop:AddLine(
			'text', KIC.MENUSET,
			'hasArrow', true,
			'value', "set"
		)
		dewdrop:AddLine(
			'text', KIC.MENUTIME,
			'hasArrow', true,
			'value', "time"
		)
	elseif level == 2 then
		if value == "set" then 
			for k, v in KIC.MENU do
				local x = k
				dewdrop:AddLine(
					'text', v,
					'func', KeepItCool.TogP,
					'arg1', k,
					'checked', KeepItCool.GetP(k)
				)
			end
		elseif value == "time" then 
			for k, v in KIC.TIMEOPTS do
				local x = k
				dewdrop:AddLine(
					'text', v,
					'func', KeepItCool.SetP,
					'arg1', "time",
					'arg2', k,
					'checked', KeepItCool.GetP("time") == k,
					'isRadio', true
				)
			end
		end
	end
end


end

--[[--------------------------------------------------------------------------------
	Register the Addon
-----------------------------------------------------------------------------------]]

KeepItCool:RegisterForLoad()
if FuBar then KeepItCoolFu:RegisterForLoad() end

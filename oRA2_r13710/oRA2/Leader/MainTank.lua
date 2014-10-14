assert( oRA, "oRA not found!")

------------------------------
--      Are you local?      --
------------------------------

local L = AceLibrary("AceLocale-2.0"):new("oRALMainTank")

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	["maintank"] = true,
	["MainTank"] = true,
	["maintankleader"] = true,
	["mt"] = true,
	["Options for the maintanks."] = true,
	["set"] = true,
	["Set Maintank"] = true,
	["Set a maintank."]= true,
	["<nr> <name>"] = true,
	["<nr>"] = true,
	["<name>"] = true,
	["Remove Maintank"] = true,
	["remove"] = true,
	["Remove a maintank."] = true,
	["Removed maintank: "] = true,
	["Set maintank: "] = true,
	["Leader/MainTank"] = true,
	["Broadcast"] = true,
	["Broadcast Maintanks"] = true,
	["Send the raid your maintanks."] = true,

	["(%S+)%s*(.*)"] = true,
} end )

L:RegisterTranslations("koKR", function() return {
--	["maintank"] = "메인탱커",
--	["maintankleader"] = "메인탱커설정",
--	["mt"] = "메인탱커",
--	["set"] = "지정",
--	["remove"] = "삭제",

	["MainTank"] = "메인탱커",
	["Options for the maintanks."] = "메인탱커 설정",
	["Set Maintank"] = "메인탱커 지정",
	["Set a maintank."]= "메인탱커로 지정합니다",
	["<nr> <name>"] = "<번호> <이름>",
	["<nr>"] = "<번호>",
	["<name>"] = "<이름>",
	["Remove Maintank"] = "메인탱커 삭제",
	["Remove a maintank."] = "메인탱커에서 삭제합니다.",
	["Removed maintank: "] = "메인탱커 삭제: ",
	["Set maintank: "] = "메인탱커 설정: ",
	["Leader/MainTank"] = "공격대장/메인탱커",
	["Broadcast"] = "알림",
	["Broadcast Maintanks"] = "메인탱커 알림",
	["Send the raid your maintanks."] = "메인탱커를 공격대에 알립니다.",

	["(%S+)%s*(.*)"] = "(%d+)%s*(.*)",
} end )

L:RegisterTranslations("zhCN", function() return {
	["maintank"] = "主MT",
	["MainTank"] = "主MT",
	["maintankleader"] = "maintankleader",
	["mt"] = "MT",
	["Options for the maintanks."] = "MT选项",
	["set"] = "设置",
	["Set Maintank"] = "设定MT",
	["Set a maintank."]= "设定一个MT",
--	["<nr> <name>"] = ["<nr> <name>"],
--	["<nr>"] = ["<nr>"],
--	["<name>"] = ["<name>"],
	["Remove Maintank"] = "移除MT",
	["remove"] = "移除",
	["Remove a maintank."] = "移除一个MT",
	["Removed maintank: "] = "移除MT",
	["Set maintank: "] = "设定MT",
	["Leader/MainTank"] = "Leader/MainTank",
	["Broadcast"] = "广播",
	["Broadcast Maintanks"] = "广播MT",
	["Send the raid your maintanks."] = "向团队广播MT",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

oRALMainTank = oRA:NewModule(L["maintankleader"])
oRALMainTank.defaults = {
}
oRALMainTank.leader = true
oRALMainTank.name = L["Leader/MainTank"]
oRALMainTank.consoleCmd = L["mt"]
oRALMainTank.consoleOptions = {
	type = "group",
	desc = L["Options for the maintanks."],
	name = L["MainTank"],
	args = {
		[L["Broadcast"]] = {
			name = L["Broadcast Maintanks"], type = "execute",
			desc = L["Send the raid your maintanks."],
			func = function() oRALMainTank:Broadcast() end,
			disabled = function() return not oRALMainTank:IsValidRequest() end,
		},
		[L["set"]] = {
			name = L["Set Maintank"], type = "group",
			desc = L["Set a maintank."],
			disabled = function() return not oRALMainTank:IsValidRequest() end,
			args = {
				["1"] = {
					name = "1.", type = "text", desc = L["Set Maintank"].." 1",
					get = function() 
						if oRALMainTank.core.maintanktable[1] then return oRALMainTank.core.maintanktable[1]
						else return "" end
					end,
					set = function(v) oRALMainTank:Set("1 "..v) end,
					validate = function(v) return string.find(v, "^(%S+)$") end,
					usage = L["<name>"],
					order = 1,
				},
				["2"] = {
					name = "2.", type = "text", desc = L["Set Maintank"].." 2",
					get = function() 
						if oRALMainTank.core.maintanktable[2] then return oRALMainTank.core.maintanktable[2]
						else return "" end
					end,
					set = function(v) oRALMainTank:Set("2 "..v) end,
					validate = function(v) return string.find(v, "^(%S+)$") end,
					usage = L["<name>"],
					order = 2,
				},
				["3"] = {
					name = "3.", type = "text", desc = L["Set Maintank"].." 3",
					get = function() 
						if oRALMainTank.core.maintanktable[3] then return oRALMainTank.core.maintanktable[3]
						else return "" end
					end,
					set = function(v) oRALMainTank:Set("3 "..v) end,
					validate = function(v) return string.find(v, "^(%S+)$") end,
					usage = L["<name>"],
					order = 3,
				},
				["4"] = {
					name = "4.", type = "text", desc = L["Set Maintank"].." 4",
					get = function() 
						if oRALMainTank.core.maintanktable[4] then return oRALMainTank.core.maintanktable[4]
						else return "" end
					end,
					set = function(v) oRALMainTank:Set("4 "..v) end,
					validate = function(v) return string.find(v, "^(%S+)$") end,
					usage = L["<name>"],
					order = 4,
				},
				["5"] = {
					name = "5.", type = "text", desc = L["Set Maintank"].." 5",
					get = function() 
						if oRALMainTank.core.maintanktable[5] then return oRALMainTank.core.maintanktable[5]
						else return "" end
					end,
					set = function(v) oRALMainTank:Set("5 "..v) end,
					validate = function(v) return string.find(v, "^(%S+)$") end,
					usage = L["<name>"],
					order = 5,
				},
				["6"] = {
					name = "6.", type = "text", desc = L["Set Maintank"].." 6",
					get = function() 
						if oRALMainTank.core.maintanktable[6] then return oRALMainTank.core.maintanktable[6]
						else return "" end
					end,
					set = function(v) oRALMainTank:Set("6 "..v) end,
					validate = function(v) return string.find(v, "^(%S+)$") end,
					usage = L["<name>"],
					order = 6,
				},
				["7"] = {
					name = "7.", type = "text", desc = L["Set Maintank"].." 7",
					get = function() 
						if oRALMainTank.core.maintanktable[7] then return oRALMainTank.core.maintanktable[7]
						else return "" end
					end,
					set = function(v) oRALMainTank:Set("7 "..v) end,
					validate = function(v) return string.find(v, "^(%S+)$") end,
					usage = L["<name>"],
					order = 7,
				},
				["8"] = {
					name = "8.", type = "text", desc = L["Set Maintank"].." 8",
					get = function() 
						if oRALMainTank.core.maintanktable[8] then return oRALMainTank.core.maintanktable[8]
						else return "" end
					end,
					set = function(v) oRALMainTank:Set("8 "..v) end,
					validate = function(v) return string.find(v, "^(%S+)$") end,
					usage = L["<name>"],
					order = 8,
				},
				["9"] = {
					name = "9.", type = "text", desc = L["Set Maintank"].." 9",
					get = function() 
						if oRALMainTank.core.maintanktable[9] then return oRALMainTank.core.maintanktable[9]
						else return "" end
					end,
					set = function(v) oRALMainTank:Set("9 "..v) end,
					validate = function(v) return string.find(v, "^(%S+)$") end,
					usage = L["<name>"],
					order = 9,
				},
				["10"] = {
					name = "10.", type = "text", desc = L["Set Maintank"].." 10",
					get = function() 
						if oRALMainTank.core.maintanktable[10] then return oRALMainTank.core.maintanktable[10]
						else return "" end
					end,
					set = function(v) oRALMainTank:Set("10 "..v) end,
					validate = function(v) return string.find(v, "^(%S+)$") end,
					usage = L["<name>"],
					order = 10,
				},
			}
		},
		[L["remove"]] = {
			name = L["Remove Maintank"], type = "group",
			desc = L["Remove a maintank."],
			disabled = function() return not oRALMainTank:IsValidRequest() end,
			args = {
				["1"] = {
					name = "1.", type = "execute", desc = L["Remove Maintank"].." 1",
					func = function() oRALMainTank:Remove("1") end,
					disabled = function() return not oRALMainTank.core.maintanktable[1] end,
					order = 1,
				},				
				["2"] = {
					name = "2.", type = "execute", desc = L["Remove Maintank"].." 2",
					func = function() oRALMainTank:Remove("2") end,
					disabled = function() return not oRALMainTank.core.maintanktable[2] end,
					order = 2,
				},
				["3"] = {
					name = "3.", type = "execute", desc = L["Remove Maintank"].." 3",
					func = function() oRALMainTank:Remove("3") end,
					disabled = function() return not oRALMainTank.core.maintanktable[3] end,
					order = 3,
				},
				["4"] = {
					name = "4.", type = "execute", desc = L["Remove Maintank"].." 4",
					func = function() oRALMainTank:Remove("4") end,
					disabled = function() return not oRALMainTank.core.maintanktable[4] end,
					order = 4,
				},
				["5"] = {
					name = "5.", type = "execute", desc = L["Remove Maintank"].." 5",
					func = function() oRALMainTank:Remove("5") end,
					disabled = function() return not oRALMainTank.core.maintanktable[5] end,
					order = 5,
				},
				["6"] = {
					name = "6.", type = "execute", desc = L["Remove Maintank"].." 6",
					func = function() oRALMainTank:Remove("6") end,
					disabled = function() return not oRALMainTank.core.maintanktable[6] end,
					order = 6,
				},
				["7"] = {
					name = "7.", type = "execute", desc = L["Remove Maintank"].." 7",
					func = function() oRALMainTank:Remove("7") end,
					disabled = function() return not oRALMainTank.core.maintanktable[7] end,
					order = 7,
				},
				["8"] = {
					name = "8.", type = "execute", desc = L["Remove Maintank"].." 8",
					func = function() oRALMainTank:Remove("8") end,
					disabled = function() return not oRALMainTank.core.maintanktable[8] end,
					order = 8,
				},
				["9"] = {
					name = "9.", type = "execute", desc = L["Remove Maintank"].." 9",
					func = function() oRALMainTank:Remove("9") end,
					disabled = function() return not oRALMainTank.core.maintanktable[9] end,
					order = 9,
				},
				["10"] = {
					name = "10.", type = "execute", desc = L["Remove Maintank"].." 10",
					func = function() oRALMainTank:Remove("10") end,
					disabled = function() return not oRALMainTank.core.maintanktable[10] end,
					order = 10,
				},
			}
		}
	}
}


------------------------------
--      Initialization      --
------------------------------

function oRALMainTank:OnInitialize()
	self.debugFrame = ChatFrame5
end

function oRALMainTank:OnEnable()
	if not self.core.maintanktable then 
		self.core.maintanktable = self.core.db.profile.maintanktable or {}
	end
	self:RegisterEvent("oRA_SendVersion")
	self:RegisterEvent("oRA_MainTankUpdate")
	self:RegisterEvent("oRA_JoinedRaid", "oRA_MainTankUpdate")
	self:RegisterEvent("RosterLib_RosterChanged", function() self:oRA_MainTankUpdate() end)	
end

function oRALMainTank:OnDisable()
	self:UnregisterAllEvents()
end

-------------------------------
--       Event Handlers      --
-------------------------------

function oRALMainTank:oRA_SendVersion()
	if (not IsRaidLeader()) then return end
	self:Broadcast()
end

function oRALMainTank:oRA_MainTankUpdate( maintanktable )
	if not maintanktable then maintanktable = self.core.maintanktable end
	for k = 1, 10, 1 do
				self.core.consoleOptions.args[L["mt"]].args[L["remove"]].args[tostring(k)].name = tostring(k).."."
				self.core.consoleOptions.args[L["mt"]].args[L["set"]].args[tostring(k)].name = tostring(k).."."
	end
	for k,v in pairs(maintanktable) do
		if self:IsValidRequest(v,true) then
				self.core.consoleOptions.args[L["mt"]].args[L["remove"]].args[tostring(k)].name = tostring(k)..". "..v
				self.core.consoleOptions.args[L["mt"]].args[L["set"]].args[tostring(k)].name = tostring(k)..". "..v
		end
	end
end

-------------------------------
--      Command Handlers     --
-------------------------------

function oRALMainTank:Set( text )
	if not self:IsPromoted() then return end
	if not text or text == "" then return end
	local _, _, num, name = string.find(text, L["(%S+)%s*(.*)"]) -- split locals
	if not num then return end

	num = tonumber(num)
	if not name or name == "" then name = UnitName("target") end
	
	-- lower the name and upper the first letter, not for chinese and korean though
	if GetLocale() ~= "zhCN" and GetLocale() ~= "koKR" then
		name = string.upper(string.sub(name, 1, 1)) .. string.lower(string.sub(name, 2))
	end

	if not self:IsValidRequest(name, true) then return end
	
	self:SendMessage( "SET " .. num .. " " .. name )
	self:Print(L["Set maintank: "] .. num .. " " .. name )
end

function oRALMainTank:Remove( num )
	if not self:IsPromoted() then return end
	if not num then return end
	num = tonumber(num)
	local name = self.core.maintanktable[num]
	if not name then return end
	self:SendMessage( "R "..name )
	self:Print(L["Removed maintank: "] .. num .." "..name )
end


function oRALMainTank:Broadcast()
	for k,v in pairs(self.core.maintanktable) do
		if self:IsValidRequest(v,true) then self:SendMessage("SET "..k.." "..v) end
	end
end
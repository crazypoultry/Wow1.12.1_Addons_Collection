local L = AceLibrary("AceLocale-2.2"):new("ag_UnitFrames")

function aUF:LoadStringFormats()
	for order,unit in ipairs(self.wowClasses) do
		self:SetStringFormats(unit)
	end
end

function aUF:SetStringFormats(type)
	local db = self.db.profile[type]
	local strings = {"Health","Mana","Name","Class"}
	if not aUF.HelperFunctions[type] then
		aUF.HelperFunctions[type] = {}
	end

	for k,v in pairs(strings) do
		local format
		if db[v.."Style"] == "Custom" then
				format = db[v.."Format"]
		else
			format = self.formats[v][db[v.."Style"]]
		end
		aUF.HelperFunctions[type][v.."Text"] = self:Parse(format)
	end
end


-- Clads code-- Clads code-- Clads code-- Clads code
-- Clads code-- Clads code-- Clads code-- Clads code

-- Code Begins here
local work = {}
local strgsub, strsub, strgfind, strformat, strfind = string.gsub, string.sub, string.gfind, string.format, string.find

function aUF:Parse(format)
	if not format then
		return nil
	end

	local formatArgs, formatString = {}

	for s,data,e in strgfind(format, "()(%b[])()") do
		local tag = strsub(data, 2, -2)
		local func = aUF:GetTagFunction(tag)
		if func then
			table.insert(formatArgs, func)
		else
			error(strformat("\"%s\" is not a valid format tag.", data))
		end
	end

	formatString = strgsub(format, "%%", "%%%%")
	formatString = strgsub(formatString, "%b[]", "%%s")

	-- Lets avoid unpacking extra results
	local num = table.getn(formatArgs)
	local tmp = work[num]
	if not tmp then
		tmp = {}
		work[num] = tmp
	end

	if num == 0 then
		return function(unit, fontstring)
			fontstring:SetText(formatString)
		end
	else
		return function(unit, fontstring)
			for i,func in ipairs(formatArgs) do 
				work[i] = func(unit)
			end
			fontstring:SetText(strformat(formatString, unpack(work)))
		end
	end
end

local helpers = {}

function aUF:GetTagFunction(tag)
	-- Check if this is just a unit tag
	if aUF.UnitInformation[tag] then return aUF.UnitInformation[tag] end

	local s,e,tag,args = strfind(tag, "^(%a+)%s+(.*)$")
	if not tag then
		-- Not a pattern we can recognize
		return nil
	end

	-- Bind the unit function to a local for closure purposes
	local func = aUF.UnitInformation[tag]
	if not func then
		-- Not a tag we support
		return nil
	end
	local _,_,width = strfind(args, "^(%d+)$")
	if width then
		local id = strformat("%s-%d", tag, width)
		local hFunc = helpers[id]
		if not hFunc then
			hFunc = function(unit)
				return strsub(func(unit), 1, width)
			end
			helpers[id] = hFunc
		end
		return hFunc
	end

	local _,_,oc,ec = strfind(args, "^(.)(.)$")
	if oc then
		local id = strformat("%s-%s%s", tag, oc, ec)
		local hFunc = helpers[id]
		if not hFunc then
			hFunc = function(unit)
				local t = func(unit)
				if t ~= "" then return
					strformat("%s%s%s",oc,t,ec)
				else
					return t
				end
			end
			helpers[id] = hFunc
		end
		return hFunc
	end
end

function aUF:Tag_agmana(unit,flag)
	local currValue,maxValue = UnitMana(unit),UnitManaMax(unit)
	if maxValue == 0 then
		return ""
	end
	local perc = currValue/maxValue * 100
	local manaDiff = maxValue - currValue
	local text = ""
	
	if ( not UnitExists(unit) or UnitIsDead(unit) or UnitIsGhost(unit) or not UnitIsConnected(unit) ) then
		return ""
	end
	
	if currValue > maxValue then
		maxValue = currValue
	end
	
	if flag == 1 then
		return string.format("%.0f%%", perc)
	elseif flag == 2 then
		return self:formatLargeValue(currValue).."|cffff7f7f-".. self:formatLargeValue(manaDiff) .."|r"
	elseif flag == 3 then
		return self:formatLargeValue(currValue)
	else
		return self:formatLargeValue(currValue).."/"..self:formatLargeValue(maxValue)
	end
	
	return text
end
	
function aUF:Tag_aghp(unit,flag)
	local currValue,maxValue = UnitHealth(unit),UnitHealthMax(unit)
	if maxValue == 0 then
		return ""
	end
	local perc = currValue/maxValue * 100
	local text = ""
	local MHfound = false
	if ( UnitIsDead(unit) ) then
		return L["dead"]
	elseif ( UnitIsGhost(unit) ) then
		return L["ghost"]
	elseif ( not UnitIsConnected(unit) or maxValue == 1 ) then
		return L["disc"]
	end
	if (MobHealth3 and not UnitIsFriend("player", unit) ) then
		currValue,maxValue,MHfound = MobHealth3:GetUnitHealth(unit, currValue,maxValue)
	end
	if currValue > maxValue then
		maxValue = currValue
	end
	
	local hpDiff = maxValue - currValue

	if not flag and MHfound and not UnitIsFriend("player", unit) then
		return self:formatLargeValue(currValue) .." (".. perc .."%)"
	end
	
	if not (flag == 1) and (MHfound or unit == "pet" or unit == "player" or UnitInParty(unit) or UnitInRaid(unit)) then
		if flag == 2 then
			if hpDiff > 0 then
				return self:formatLargeValue(currValue).."|cffff7f7f-".. self:formatLargeValue(hpDiff) .."|r"
			else
				return self:formatLargeValue(currValue)
			end
		elseif flag == 3 and hpDiff > 0 then
			return "|cffff7f7f-"..self:formatLargeValue(hpDiff).."|r"
		elseif flag == 3 then
			return ""
		else
			return self:formatLargeValue(currValue).."/"..self:formatLargeValue(maxValue)
		end
	else
		return string.format("%.0f%%", perc)
	end
	return text
end

--[[
	missing LOCALE_koKR and whatever the new spanish version will be
	Turning this off for english versions currently does almost no harm
	
	for DE there is a lot of crap captures and for FR it's totally killed
	
	not sure about ZH
	
	For addon devs: If you generate your regEx from global vars it is best just to make SW_Stats (and not this)
	an optional Dep in your toc
	## OptionalDeps: SW_Stats
--]]


if LOCALE_deDE then
	function SW_FixLogStrings(str)
		--problematic strings
		-- %ss 
		-- a string capture directly followd by a letter followed by a space
		return string.gsub(str, "(%%%d?$?s)(%a%s)", "%1%'%2");
	end
elseif LOCALE_frFR then
	function SW_FixLogStrings(str)
		-- de is the main seperator
		local tmpStr = string.gsub(str, "(%%%d?$?s) de (%%%d?$?s)", "%1 DE %2");
		return string.gsub(tmpStr, "|2", "DE");
	end
elseif LOCALE_zhCN or LOCALE_zhTW then
	function SW_FixLogStrings(str)
		-- jinsongzhao
		if string.find(str,"的%%s") or string.find(str,"对%%s") or string.find(str,"击中%%s") or string.find(str,"對%%s") or string.find(str,"擊中%%s") then
			str = string.gsub(str, "(%%%d?$?s)([^%s+].)", "%1 %2");
			str = string.gsub(str, "(.[^%s+])(%%%d?$?s)", "%1 %2");
			str = string.gsub(str, "(.[^%s+])(%%%d?$?d)", "%1 %2");
			return string.gsub(str, "(%%%d?$?d)([^%s+].)", "%1 %2");
		end
		return str;	
	end
else
	function SW_FixLogStrings(str)
		--problematic strings
		-- %s's 
		--Twilight's Hammer Ambassador's Flame Shock hits you for 1234 fire damage.
		-- or fictional: Twilight's Hammer Ambassador's Nature's Grasp ...
		return string.gsub(str, "(%%%d?$?s)('s)", "%1% %2");
	end
end
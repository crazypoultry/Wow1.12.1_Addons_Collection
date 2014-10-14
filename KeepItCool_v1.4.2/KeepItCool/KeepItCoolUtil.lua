KIC_DAY_OA = DAYS_ABBR
KIC_HOUR_OA = HOURS_ABBR
KIC_MINUTE_OA = MINUTES_ABBR
KIC_SECOND_OA = SECONDS_ABBR

ace:RegisterFunctions(KeepItCool, {

version = 1.01,


--[[---------------------------------------------------------------------------------
  Chat Processing
------------------------------------------------------------------------------------]]

PrintOverheadText = function(...)
	if( type(arg[1])=="table" ) then
		local p=tremove(arg,1)
		ace:print({(p[1] or 1.0),(p[2] or 1.0),(p[3] or 0),UIErrorsFrame,p[4]},unpack(arg))
	else
		ace:print(unpack(arg))
	end
end,

--[[---------------------------------------------------------------------------------
  Time Conversion
------------------------------------------------------------------------------------]]

StoDHMS = function(i, l)
    i = tonumber(i)
    local n = i < 0
    i = math.abs(i)

	local d, h, m, s = math.floor(i/(60*60*24)),
	                   math.mod(math.floor(i/(60*60)), 24),
	                   math.mod(math.floor(i/60), 60),
	                   math.mod(i, 60)
	
    d = d ~= 0 and (n and "-" or "") .. d .. (l and (" " .. (d > 1 and DAYS_P1 or DAYS)) or KIC_DAY_OA) or nil
    h = h ~= 0 and (n and "-" or "") .. h .. (l and (" " .. (h > 1 and HOURS_P1 or HOURS)) or KIC_HOUR_OA) or nil
    m = m ~= 0 and (n and "-" or "") .. m .. (l and (" " .. (m > 1 and MINUTES_P1 or MINUTES)) or KIC_MINUTE_OA) or nil
    s = s ~= 0 and (n and "-" or "") .. s .. (l and (" " .. (s > 1 and SECONDS_P1 or SECONDS)) or KIC_SECOND_OA) or nil

    return (d and d .. ((h or m or s) and ", " or "") or "") ..
	       (h and h .. ((m or s) and ", " or "") or "") ..
	       (m and m .. (s and ", " or "") or "")  ..
	       (s or "")
end

})

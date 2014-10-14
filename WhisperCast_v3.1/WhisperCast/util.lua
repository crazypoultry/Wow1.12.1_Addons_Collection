
WhisperCastUtil_cycleElapsedTime = {}

function WhisperCastUtil_GetCyclePercent( timerName, timeSinceLastUpdate, cycleLength )

    local elapsedCycleTime = 0

    if ( WhisperCastUtil_cycleElapsedTime[timerName] ) then
        elapsedCycleTime = WhisperCastUtil_cycleElapsedTime[timerName]
    end

    elapsedCycleTime = elapsedCycleTime + timeSinceLastUpdate

    WhisperCastUtil_cycleElapsedTime[timerName] = elapsedCycleTime

    local cycleMod = math.mod(elapsedCycleTime, cycleLength)

    if ( cycleMod > cycleLength/2 ) then
        cycleMod = -cycleMod + cycleLength
    end

    local cyclePercent = cycleMod * 2 / cycleLength

    if ( cyclePercent < 0 ) then
        return 0
    elseif ( cyclePercent > 1 ) then
        return 1
    end

    return cyclePercent
end

function WhisperCastUtil_copyTable( src )
    local copy = {}
    for k1,v1 in src do
        if ( type(v1) == "table" ) then
            copy[k1]=WhisperCastUtil_copyTable(v1)
        else
            copy[k1]=v1
        end
    end
    
    return copy
end

function WhisperCastUtil_nvl(value,ifNilValue)
    if ( not value ) then
        return ifNilValue
    else
        return value
    end
end

function wc_minmax(tab)
    local min,max=nil,nil
    for k,v in tab do
        local k_num = tonumber(k)
        if ( k_num ) then
            if ( not min or k_num < min ) then
                min = k_num
            end
            if ( not max or k_num > max ) then
                max = k_num
            end
        end
    end
    return min,max
end

function wc_insert(tab,a1,a2)
    if ( a2 ) then
        tab[a1]=a2
    else
        wc_append(tab,{ a1 })
    end
end

function wc_isempty(tab)
    for k,v in tab do
        return false
    end
    return true
end

function wc_getn(tab)
    local i=0
    for k,v in tab do
        i=i+1
    end
    return i
end

function wc_append( inArray, appendArray )
    local j=0
    for k,v in inArray do
        if ( tonumber(k) and (j == 0 or j<k) ) then
            j=tonumber(k)
        end
    end
    for i,value in appendArray do
        j=j+1
        inArray[j] = value
    end
end

function wc_first(tab)
    local min = wc_minmax(tab)
    if ( min ) then
        return min,tab[min]
    else
        for k,v in tab do
            return k,v
        end
    end
    return nil,nil
end

function wc_contains(tab,value)
    for _,v in tab do
        if ( v == value ) then
            return true
        end
    end
    return false
end

function wc_prepend(tab,new)
    local n_min,n_max=wc_minmax(new)
    if ( n_min and n_max ) then
        local s_min,s_max=wc_minmax(tab)
        if ( s_min and s_max ) then
            -- move the existing entries
            local offset=n_max-n_min-s_min+2
            if ( offset > 0 ) then
                for i=s_max,s_min,-1 do
                    tab[i+offset]=tab[i]
                    tab[i]=nil
                end
            elseif ( offset < 0 ) then
                for i=s_min,s_max,1 do
                    tab[i+offset]=tab[i]
                    tab[i]=nil
                end
            end
        end
        for k,v in new do
            local k_num=tonumber(k)
            if ( k_num ) then
                tab[k_num-n_min+1]=new[k_num]
            else
                tab[k]=new[k]
            end
        end
    end
end

--[[
-- locale debug
function GetLocale()
    return "deDE"
end
]]
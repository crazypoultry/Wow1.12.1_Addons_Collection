-- From Ephemeral

-- [ ordered dict implementation ] --

--[[
dict = {}

function dict.create()
    local dictionary = { keys = {}, values = {} }
    return dictionary
end

function dict.count( dictionary )
    return table.getn( dictionary.keys )
end

function dict.insert( dictionary, key, value )
    local low, mid, high = 1, nil, table.getn( dictionary.keys ) + 1
    while low < high do
        mid = math.floor( ( low + high ) / 2 )
        if key < dictionary.keys[ mid ] then
            high = mid
        else
            low = mid + 1
        end
    end
    table.insert( dictionary.keys, low, key )
    table.insert( dictionary.values, low, value )
    return dictionary
end

function dict.peek( dictionary, position )
    position = position or 1
    return dictionary.values[ position ]
end

function dict.process( dictionary, delta )
    return function()
        if dictionary.keys[ 1 ] and dictionary.keys[ 1 ] <= delta then
            return dict.shift( dictionary )
        end
    end
end

function dict.shift( dictionary, position )
    position = position or 1
    table.remove( dictionary.keys, position )
    return table.remove( dictionary.values, position )
end
--]]

-- [ table operations ] --

-- deletes the specified value from the specified table
function table.delete( list, target )
    for i, item in ipairs( list ) do
        if item == target then
            table.remove( list, i )
        end
    end
end

-- identifies the presence and position of the specified target in the list
function table.has( list, target )
    for i, item in ipairs( list ) do
        if item == target then
            return true, i
        end
    end
    return false, nil
end

function table.inject( list, item )
    local id = 1
    while list[ id ] do
        id = id + 1
    end
    list[ id ] = item
    return id
end

function table.merge( target, addition )
    for key, value in pairs( addition ) do
        target[ key ] = value
    end
end

-- [ string operations ] --

-- trims all leading whitespace from the text
function string.ltrim( text )
    return string.sub( text, "%s*(.-)$", "%1", 1 )
end

-- trims all trailing whitespace from the text
function string.rtrim( text )
    return string.gsub( text, "(.-)%s*$", "%1", 1 )
end

-- splits the specified text into an array on the specified separator
function string.split( text, separator, limit )
    local parts, position, length, last, jump, count = {}, 1, string.len( text ), nil, string.len( separator ), 0
    while true do
        last = string.find( text, separator, position, true )
        if last and ( not limit or count < limit ) then
            table.insert( parts, string.sub( text, position, last - 1 ) )
            position, count = last + jump, count + 1
        else
            table.insert( parts, string.sub( text, position ) )
            break
        end
    end
    --return unpack( parts )
    return parts;
end

-- renders the given word in titlecase
function string.titlecase( text )
    return string.upper( string.sub( text, 1, 1 ) ) .. string.lower( string.sub( text, 2, -1 ) )
end

-- trims all leading and trailing whitespace from the text
function string.trim( text )
    return string.gsub( text, "%s*(.-)%s*$", "%1", 1 )
end

-- wraps specified text to specified line width
function string.wrap( text, limit )
    local wrapped, position, length, last, char = "", 1, string.len( text ), nil, nil
    while position < length do
        if length - position > limit then
            last = position + limit
            char = string.sub( text, last, last )
            while char ~= " " do
                last = last - 1
                char = string.sub( text, last, last )
            end
            wrapped = wrapped .. string.sub( text, position, last ) .. "\n"
            position = last + 1
        else
            wrapped = wrapped .. string.sub( text, position, -1 )
            break
        end
    end
    return wrapped
end
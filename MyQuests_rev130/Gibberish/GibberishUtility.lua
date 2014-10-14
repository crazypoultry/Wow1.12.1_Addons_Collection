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

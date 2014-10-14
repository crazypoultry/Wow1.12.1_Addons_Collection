--[[
--
--	Sea.string
--
--	String manipulation functions
--
--	$LastChangedBy: Sinaloit $
--	$Rev: 2025 $
--	$Date: 2005-07-02 16:51:34 -0700 (Sat, 02 Jul 2005) $
--]]

Sea.string = {

	--
	-- byte(string)
	--
	--	Converts a character to its bytecode
	--
	-- Args:
	-- 	string - the string
	--
	-- Returns:
	-- 	(string)
	-- 	string - the string in byte code with format <##>
	--
	byte = function(c)
		return string.format("<%02X>",string.byte(c));
	end;

	--
	--	byteSum (string s)
	--		returns the bytecode sum for s
	--
	-- Args:
	-- 	s - the string
	--
	-- Returns:
	-- 	(number)
	-- 	number - the value of the string with all of its
	-- 	chars summed together. 
	--		
	byteSum = function(s)
		local sum = 0;
		while ( string.len(s) > 0 ) do
			local char = string.sub(s,1,1);
			s = string.sub(s,2);

			sum = sum + string.byte(char);
		end

		return sum;
	end;

	--
	-- toInt (string s)
	--
	-- 	Converts the specified string to an int
	--
	-- Returns: 
	-- 	(Number int)
	-- 	int - the string S as a number
	--
	toInt = function (str)
		local remain = str;
		local amount = 0;
		while ( (remain ~= "") and (remain) ) do
			amount = amount * 10;
			amount = amount + (string.byte(string.sub(remain, 1, 1)) - string.byte("0"));
			remain = string.sub(remain, 2);
		end
		return amount;		
	end;

	-- 
	-- fromTime(Number time, Number decimalplaces)
	--
	-- 	Creates a readable time from a number time in WoW
	-- 	Decimal places gives the number of .### to display
	--
	-- Returns:
	-- 	(String timeString)
	-- 	timeString - the time
	-- 	
	fromTime = function (time, decimalplaces)
		if (time < 0)	then
			time = 0;
		end
		if ( not decimalplaces ) then 
			decimalplaces = 0;
		end
		
		local size = math.pow(10,decimalplaces);
		local seconds = math.mod(math.floor(time*size), 60*size);
		seconds = seconds / size;

		if (seconds < 10)
			then
			seconds = "0"..seconds;
		end
		local minutes = math.mod(math.floor(time/60), 60);
		local hours = math.floor(time/(60*60));
		
		local timeString;
		if (hours > 0)
			then
			if (minutes < 10)
				then
				minutes = "0"..minutes;
			end
			timeString = hours..":"..minutes..":"..seconds;
		else
			timeString = minutes..":"..seconds;
		end
		return timeString;
	end;

	--getglobal("ARCANEBAR_"..types[i].."COLOR_SET");
	-- capitalizeWords(String phrase)
	--
	--	Takes a string like "hello world" and turns 
	--	it into "Hello World". 
	--
	-- Returns:
	-- 	(String capitalizedPhrase)
	-- 
	
	capitalizeWords = function ( phrase )
		if (not phrase) then
			return phrase;
		end
		local words = Sea.util.split(phrase, " ");
		local capitalizedPhrase = "";

		for i=1,table.getn(words) do 
			local v = words[i];
			if ( i ~= 1 ) then
				capitalizedPhrase = capitalizedPhrase.." ";
			end
			capitalizedPhrase = capitalizedPhrase..string.upper(string.sub(v,1,1))..string.lower(string.sub(v,2));
		end

		return capitalizedPhrase;
	end;


	--
	-- objectToString( value, [name] )
	--
	-- 	Converts a value to a serialized string. 
	-- 	Cannot serialize functions.
	-- 	
	-- returns:
	--	A string which represents the object, 
	--	minus functions. 
	-- 	
	-- 
	objectToString = function( value, name ) 
		local output = "";

		if ( name == nil ) then name = ""; 
		else
			-- Serialize the name
			name = Sea.string.objectToString(name);
			-- Remove the <>
			name = string.gsub(name, "<(.*)>", "%1");
		end
		
		if (type(value) == "nil" ) then 
			output = name.."<".."nil:nil"..">";
		elseif ( type(value) == "string" ) then
			value = string.gsub(value, "<", "&lt;");
			value = string.gsub(value, ">", "&gt;");
			output = name.."<".."s:"..value..">";
		elseif ( type(value) == "number" ) then
			output = name.."<".."n:"..value..">";
		elseif ( type(value) == "boolean" ) then
			if ( value ) then 
				output = name.."<".."b:".."true"..">";
			else
				output = name.."<".."b:".."false"..">";
			end
		elseif ( type(value) == "function" ) then
			output = name.."<".."func:".."*invalid*"..">";
		elseif ( type(value) == "table" ) then
			output = name.."<".."t:";
			for k,v in value do 
				output = output.." "..Sea.string.objectToString(v,k);
			end
			output = output .. ">";
		end

		return output;
	end;

	--
	-- stringToObject(string)
	--
	-- 	Turns a string serialized by objectToString into 
	-- 	and object. 
	--
	-- returns:
	-- 	nil or number or string or boolean or table
	--
	--
	stringToObject = function ( str ) 
		-- check for the format "keytype:keyvalue<valuetype:value>"
		-- take the stuff in <>
		typevalue = string.gsub(str, "%s*(%w*:?%w*)%s*(<.*>)","%2");
	
		local value = nil;
		local typeString = string.gsub(typevalue, "<%s*(%w*):(.*)>","%1");
		local valueString = string.gsub(typevalue, "<%s*(%w*):(.*)>","%2");

		
		--print("str: ", str, " typevalue: ", typevalue);
		--print("valueString: (", valueString, ") typeString: (", typeString,")");

		-- Error!
		if ( typeString == typevalue ) then 
			Sea.io.error ( "Unparsable string passed to stringToObject: ", str );
			return nil;
		end
	
		-- Maybe no error!
		if ( typeString == "nil" ) then 
			value = nil;
		
		elseif ( typeString == "n" ) then 
			value = tonumber(valueString);
	
		elseif ( typeString == "b" ) then 
			if ( valueString == "true" ) then
				value = true;
			else
				value = false;
			end
		
		elseif ( typeString == "s" ) then 
			value = valueString;
			-- Parse the <> back in
			value = string.gsub(value, "&lt;", "<");
			value = string.gsub(value, "&gt;", ">");

		elseif ( typeString == "f" ) then
			-- Functions are not supported, but if they were..

			-- ...this is how it should work
			-- value = getglobal(typeString);
			value = Sea.io.error;
		
		elseif ( typeString == "t" ) then 
			-- Here's the hard part
			-- I have to extract each set of <>
			-- which might have nested tables!
			-- 
			-- So I start off by tracking < until I get 0
			--
			value = {};

			local left = 1;
			local right = 1;

			local count = 0;
			
			while ( valueString and valueString ~= "" ) do
				local object = nil;
				local key = nil;

				-- Extract the key and convert it
				key = string.gsub(valueString, "%s*(%w*:?.-)<.*>", "%1" );
				key = Sea.string.stringToObject("<"..key..">");

			
				left = string.find(valueString, "<", 1 );
				right = string.find(valueString, ">", 1 );

				if ( left < right ) then 
					nextleft = string.find(valueString, "<", left+1 );
					while ( nextleft and nextleft < right ) do
						nextleft = string.find(valueString, "<", nextleft+1 );
						right = string.find(valueString, ">", right+1 );
					end
				else
					--error ( "we all die." );
				end

				objectString = string.sub(valueString, left, right);
			
				-- Create the object
				object = Sea.string.stringToObject(objectString);

				-- Add it to the table
				value[key] = object;

				-- See if there's another entry
				valueString = string.sub(valueString, right+1);
			end
		end

		return value;
	end;
	
	--
	-- startsWith(String s, String prefix)
	--
	--	Looks for 'prefix' at the beginning of 's' 
	--
	-- Returns:
	-- 	boolean
	-- 
	
	startsWith = function ( s, prefix )
		local isAtBeginning = false;
		if (type(s) == "string") and (type(prefix) == "string") then
			if (s == prefix) then
				isAtBeginning = true;
			elseif ( string.len(s) > string.len(prefix) ) then
				if( string.sub(s, 1, string.len(prefix)) == prefix ) then
					isAtBeginning = true;
				end
			end
		end
		return isAtBeginning;
	end;
	
	--
	-- endsWith(String s, String suffix)
	--
	--	Looks for 'suffix' at the end of 's' 
	--
	-- Returns:
	-- 	boolean
	-- 
	
	endsWith = function ( s, suffix )
		local isAtEnd = false;
		if (type(s) == "string") and (type(suffix) == "string") then
			local sLen = string.len(s);
			local suffixLen = string.len(suffix);
			if (s == suffix) then
				isAtEnd = true;
			elseif ( sLen > suffixLen ) then
				if( string.sub(s, sLen+1-suffixLen) == suffix ) then
					isAtEnd = true;
				end
			end
		end
		return isAtEnd;
	end;

	--
	-- colorToString(Table{r,g,b,a})
	--
	--	Converts a table to a Blizzard color code
	--
	-- Returns:
	-- 	string 
	-- 		The blizzard color code AARRGGBB
	-- 
	--
	colorToString = function ( color )
		if ( not color ) then 
			return "FFFFFFFF";
		end
		local rString =  Sea.math.hexFromInt(math.floor(255*color.r));
		local gString =  Sea.math.hexFromInt(math.floor(255*color.g));
		local bString =  Sea.math.hexFromInt(math.floor(255*color.b));
		local aString;
	
		if ( color.a ) then 
			aString = Sea.math.hexFromInt(math.floor(255*color.a));
		elseif ( color.opacity ) then 
			aString = Sea.math.hexFromInt(math.floor(255*color.opacity));
		end
	
		if ( aString ) then
			return aString..rString..gString..bString;
		else
			return rString..gString..bString;
		end;
	end;

	-- stringToColor(String colorCode)
	--
	--	Converts a Blizzard color code to a table
	--
	-- Returns:
	-- 	table{r,g,b,a,opacity}
	--
	-- 	a & opacity are the same thing here (this could change)
	-- 
	stringToColor = function ( colorCode ) 
		local red, blue, green, alpha = Sea.math.rgbaFromHex( colorCode );

		if ( not alpha ) then alpha = 255 end;

		alpha = alpha / 255;
		red = red / 255;
		green = green / 255;
		blue = blue / 255;
		
		return { r = red; g = green; b = blue; a = alpha; opacity = alpha };
	end;
};

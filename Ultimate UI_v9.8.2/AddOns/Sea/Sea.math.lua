--[[
--
--	Sea.math
--
--	Useful math constants and values
--
--	$LastChangedBy: Sinaloit $
--	$Rev: 2025 $
--	$Date: 2005-07-02 16:51:34 -0700 (Sat, 02 Jul 2005) $
--]]

Sea.math = {
	
	-- Traditional pi
	pi = math.pi;

	--
	-- rgbaFromHex(string hex)
	--	
	--	Convert a hex string "AARRGGBB" into floats
	--
	-- Args:
	-- 	(string hex)
	-- 	hex - the string in hexidecimal
	--
	-- Returns:
	-- 	(Number red, number blue, number green, number alpha)
	-- 
	rgbaFromHex = function (hexColor)
		local alpha = 255;
		-- Handle short strings
		if ( string.len(hexColor) > 6 ) then
			alpha = Sea.math.intFromHex(string.sub(hexColor, 1, 2));
		end
			
		local red = Sea.math.intFromHex(string.sub(hexColor, 3, 4));
		local green = Sea.math.intFromHex(string.sub(hexColor, 5, 6));
		local blue = Sea.math.intFromHex(string.sub(hexColor, 7, 8));

		alpha = alpha / 255;
		red = red / 255;
		green = green / 255;
		blue = blue / 255;
		
		return red, green, blue, alpha;
	end;

	--
	-- intFromHex(string hex)
	--
	-- 	Convert a hex string into an integer.
	--
	-- Args:
	-- 	(string hex)
	-- 	hex - the string in hexidecimal
	--
	-- Returns:
	-- 	(number value)
	-- 	value - the number as an integer
	intFromHex = function ( hexCode )
		local remain = hexCode;
		local amount = 0;
		while (remain and remain ~= "") do
			amount = amount * 16;
			local byteVal = string.byte(string.upper(string.sub(remain, 1, 1)));
			if (byteVal >= string.byte("0") and byteVal <= string.byte("9"))
			then
				amount = amount + (byteVal - string.byte("0"));
			elseif (byteVal >= string.byte("A") and byteVal <= string.byte("F"))
			then
				amount = amount + 10 + (byteVal - string.byte("A"));
			end
			remain = string.sub(remain, 2);
		end
		return amount;
	end;

	--
	-- hexFromInt(Num int [, minlength])
	--
	--	Converts a decimal to hex string
	--	
	-- Args:
	-- 	(Number int)
	-- 	int - the value in decimal
	-- 	minlength - the zero padding 
	--
	-- Returns:
	-- 	(String hex)
	-- 	hex - the value in hex
	--
	hexFromInt = function (intval, minlength)
		if ( minlength == nil )	then 
			minlength = "2";
		end
		return string.format("%"..minlength.."x", intval );
	end;


	-- 
	-- convertBase(string input, int original, int outputBase)
	-----------------------------------------------------------
	--               Function made by KaTTaNa !              -- 
	--               --------------------------              --
	--   http://www.wc3sear.ch/index.php?p=JASS&ID=37&sid=   --
	--               --------------------------              --
	--               Converted in LUA by vjeux               --
	--                                                       --
	-- Usage : BaseConversion(255, 10, 16)                   --
	-- => Return "ff"                                        --
	--                                                       --
	-- Usage : BaseConversion("ff", 16, 10)                  --
	-- => Return "255"                                        --
	-----------------------------------------------------------
	-- 
	convertBase = function (input, inputBase, outputBase)
		local charMap = "0123456789abcdefghijklmnopqrstuvwxyz~!@#$%^&*()_+-=[]";
		local s;
		local result = "";
		local val = 0;
		local i;
		local p = 0;
		local pow = 1;
		local sign = "";
		
		if ( inputBase < 2 or inputBase > string.len(charMap) or outputBase < 2 or outputBase > string.len(charMap) ) then
			-- Bases are invalid or out of bounds
			return "Invalid bases given";
		end
		if ( string.sub(input, 1, 1) == "-" ) then
			sign = "-";
			input = string.sub(input, 1, string.len(input));
		end
		i = string.len(input);
		-- Get the integer value of input
		while (i > 0) do
			s = string.sub(input, i, i);
			p = 0;
			local bool = false;
			while (bool == false) do
				if ( p >= inputBase ) then
					-- Input cannot match base
					return "Input does not match base!\n P = "..p;
				end
				if ( s == string.sub(charMap, p+1, p+1) ) then
					val = val + pow * p;
					pow = pow * inputBase;
					bool = true;
				end
				p = p + 1;
			end
			i = i - 1;
		end
		while (val > 0) do
			p = math.mod(val, outputBase);
			result = string.sub(charMap, p+1, p+1)..result;
			val = val / outputBase;
		end
		
		for i = 1, string.len(result), 1 do
			if (string.sub(result, 1, 1) == "0") then
				result = string.sub(result, 2, string.len(result));
			else
				return sign..result
			end
		end
		
		if (string.len(sign..result) == 0) then 
			return "0";
		else
			return sign..result.."-"..string.len(sign..result);
		end
	end;	


	-- round(float x)
	--
	-- 	Rounds a float value to the "closest" integer.
	--
	-- Args:
	-- 	(float x)
	-- 	x - the value to round
	--
	-- Returns:
	-- 	(number value)
	-- 	value - the number as an integer (the closest integer to x)
	round = function (x)
		if(x - math.floor(x) > 0.5) then
			x = x + 0.5;
		end
		return math.floor(x);
	end

};

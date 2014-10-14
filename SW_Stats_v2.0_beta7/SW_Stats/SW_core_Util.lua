
--[[
	DO NOT LOCALIZE ANYTHING HERE
	The dump functions are only for development and 2.0.0
	There WILL be other ways do get to the data in the future
--]]


-- there may only be ONE instance of this
-- its done like this for easy save load
-- w/o wasting space for the reverse list
SW_C_StringTable = {
	
	new = function (self, o)
		local initSub = false;
		if o then
			initSub = true;
		else
			o = {}
		end
		setmetatable(o, self);
		self.__index = self;
		
		self.rvl = {};
		if initSub then
			for i,v in ipairs(o) do
				self.rvl[v] = i;
			end
		end
		return o;
	end,
	getID = function(self, str)
		local tmp = self.rvl[str];
		if tmp == nil then
			table.insert(self, str);
			tmp = table.getn(self);
			self.rvl[str] = tmp;
		end
		return tmp;
	end,
	hasID = function(self, str)
		return self.rvl[str];
	end,
	getStr = function(self, id)
		return self[id];
	end,
};




function SW_EncTest(checkPerf, decoderOnly)
	
	local totalRuns = 1000;
	local enc = {};
	local dec = {};
	local ms =0;
	local mem =0;
	local totalInts = 0;
	local tmpTable;
	local tmpSize;
	local encStr = {};
	local lenNormal = 0;
	local lenEnc = 0;
	
	for i=1, totalRuns do
		enc[i] = {};
		for n=1, math.random(20) do
			table.insert(enc[i], math.random(SW_3BBound-1));
			totalInts = totalInts + 1;
		end	
	end
	
	if checkPerf then
		if decoderOnly then
			for i=1, totalRuns do
				SW_IntTblAscii85:encode(enc[i]);
				encStr[i] = table.concat(SW_IntTblAscii85.outBuff);
			end
			mem = gcinfo();
			debugprofilestart(); 
			for i=1, totalRuns do
				tmpTable, tmpSize = SW_IntTblAscii85:decode(encStr[i]);
			end
			ms = debugprofilestop();
			mem = gcinfo() - mem;
			SW_printStr(ms.." meminc:"..mem.." AmountOfInts:"..totalInts.." #Tables:"..totalRuns);
			
		else
			mem = gcinfo();
			debugprofilestart(); 
			for i=1, totalRuns do
				SW_IntTblAscii85:encode(enc[i]);
				tmpTable, tmpSize = SW_IntTblAscii85:decode(table.concat(SW_IntTblAscii85.outBuff));
			end
			ms = debugprofilestop();
			mem = gcinfo() - mem;
			SW_printStr(ms.." meminc:"..mem.." AmountOfInts:"..totalInts.." #Tables:"..totalRuns);
		end
	else
		for i=1, totalRuns do
			dec[i] = {};
			SW_IntTblAscii85:encode(enc[i]);
			lenNormal = lenNormal + string.len(table.concat(enc[i], ","));
			lenEnc = lenEnc + string.len(table.concat(SW_IntTblAscii85.outBuff));
			tmpTable, tmpSize = SW_IntTblAscii85:decode(table.concat(SW_IntTblAscii85.outBuff));
			for n=1, tmpSize do
				table.insert(dec[i], tmpTable[n]);
			end
		end
		SW_printStr("NormalLen:"..lenNormal.."  EncodedLen"..lenEnc);
		for i=1, table.getn(enc) do
			for n=1, table.getn(enc[i]) do
				if enc[i][n] ~= dec[i][n] then
					--SW_printStr(" n:"..n);
					--SW_DumpTable(enc[i]);
					--SW_printStr("decoded");
					--SW_DumpTable(dec[i]);
					error("Housten we have a problem");
				end
				
			end
		end
		for i=1, table.getn(dec) do
			for n=1, table.getn(dec[i]) do
				assert( dec[i][n] == enc[i][n], "Housten we have ANOTHER problem");
			end
		end
		SW_printStr("TEST-OK");
	end
	
end


--[[
	The whole point of this is to encode/decode tables of positive integers
	the resulting string is in average about 50% smaller than table.concat with a seperator on the int table
	This is used for syncing where we have table->int->string -> int -> table overhead anyways
	2.0 beta.4 "\" will be replaced with "~" had a bug report about invalid escape code in sync.. this must be the cause
	
	The wrapper isn't all to clean for various reasons, its always a 2 step process for encodeing
	its not a general ascii85 encoder and doesn't adhere to some standards (mainly start<~ and end ~> flags)
	
	Encoding has quite some gc involved but sending stuff is a lot less than recieving stuff
	gc for decoding is minimal (but the buffer will stay at max size)
	use SW_IntTblAscii85:releaseBuffers(); if you encoded an extreamly large table and following encodes will be smaller
	
	Encoding
	SW_IntTblAscii85:encode(tableOInts [,sizeOfTable]);
	myAscii85Str = table.concat(SW_IntTblAscii85.outBuff);
	
	Decoding
	myIntTable, numInts = SW_IntTblAscii85:decode(myAscii85Str);
	Important myIntTable may have MORE ints stored than numInts BUT
	all values after numInts are invalid.
	any following call to decode will invalidate data you may have in myIntTable so
	be sure to do a deep copy of results before you decode again.
	
	AND YES I WANT THIS - unless some blizz dev tells me.. dude we compress them anyways
	Blizzard has enough to do with lag issues and sw stats has grown to be popular so for this small portion ill rather
	offload it to your machine then to blizzards chat servers
--]]

SW_1BBound = 256;
SW_2BBound = 65536;
SW_3BBound = 16777216;
SW_4BBound = 4294967296;

SW_4B = 4278190080; -- ff000000
SW_3B = 16711680; -- ff0000
SW_2B = 65280; -- ff00
SW_1B = 255; -- ff

SW_IntTblAscii85 = {

	byteBuff = {0,0,0,0},
	lastSize = 1,
	dataBuff = {},
	insertPos = 0,
	outBuff = {},
	asc85Buff = {0,0,0,0,0},
	pow85 = {85^4, 85^3, 85^2, 85, 1},
	lastDecode = {},
	
	createBin = function (self, num)
		--SW_printStr(num);
		if num < SW_4BBound then
			--[[
			self.byteBuff[1] = bit.rshift(bit.band(num,SW_4B), 24);
			self.byteBuff[2] = bit.rshift(bit.band(num,SW_3B), 16);
			self.byteBuff[3] = bit.rshift(bit.band(num,SW_2B), 8);
			self.byteBuff[4] = bit.band(num,SW_1B);
			--]]
			self.byteBuff[1] = bit.band(bit.rshift(num, 24),SW_1B);
			self.byteBuff[2] = bit.band(bit.rshift(num, 16),SW_1B);
			self.byteBuff[3] = bit.band(bit.rshift(num, 8),SW_1B);
			self.byteBuff[4] = bit.band(num,SW_1B);
			--[[
			for i=1,4 do
				SW_printStr(string.format("%x", self.byteBuff[i]));
			end
			--]]
			--SW_DumpTable(self.byteBuff);
			if self.byteBuff[1] > 0 then
				self.lastSize = 4;
				return 4;
			elseif self.byteBuff[2] > 0 then
				self.lastSize = 3;
				return 3;
			elseif self.byteBuff[3] > 0 then
				self.lastSize = 2;
				return 2;
			else
				self.lastSize = 1;
				return 1;
			end
		
		else 
			-- "gracefull" exit now
			SW_printStr("SW_IntTblAscii85:createBin "..num.." value to large");
			return -1;
			--error("SW_IntTblAscii85:createBin "..num.." value to large");
		end
		 
	end,
	
	--[[ encodes a table of ints to a table of "byte ints"
		
		bb[b][b][b]b[b..max(n/4)]b[b..n]
	--]]
	encode = function (self, tInt, size)
		
		local ts = size or table.getn(tInt);
		--SW_printStr("Table:");
		--SW_DumpTable(tInt);
		self.dataBuff.n = 0;
		-- in theory this will work up to SW_4B-1, but thats just insane
		if ts > SW_1B then
			return false;
		end
		local ddtLen = math.ceil(ts / 4); -- 2 bits per number to store byte length per number
		
		local numBytes = self:createBin(ts);
		if numBytes == -1 then
			return false;
		end
		self.insertPos = 1;
		
		self:insertData(numBytes);
		self:appendLast();
		
		local ddtStart = numBytes + 2;
		local dataStart = ddtStart + ddtLen + 1;
		local ddtIndex = 0;
		local ddtSubIndex = 0;
		local typeBits = 0;
		
		-- set all flag bytes to 0
		for i=1, ddtLen do
			self:insertData(0);
		end
		
		for i=1, ts do
			-- round any floats (i need this to sync in fight times)
			numBytes = self:createBin(math.floor(tInt[i] + 0.5)); 
			if numBytes == -1 then
				return false;
			end
			ddtIndex = (math.floor ( (i-1) / 4) + ddtStart);
			ddtSubIndex = bit.mod (i, 4);
			if ddtSubIndex < 0 then
				SW_printStr(ddtSubIndex);
				ddtSubIndex = 4 + ddtSubIndex + 1;
			end
			--SW_printStr("ddtIndex:"..ddtIndex.." ddtSubIndex:"..ddtSubIndex);
			typeBits = numBytes - 1;
			if ddtSubIndex == 1 then
				self.dataBuff[ddtIndex] = self.dataBuff[ddtIndex] + (bit.lshift(typeBits, 6))
			elseif ddtSubIndex == 2 then
				self.dataBuff[ddtIndex] = self.dataBuff[ddtIndex] + (bit.lshift(typeBits, 4))
			elseif ddtSubIndex == 3 then
				self.dataBuff[ddtIndex] = self.dataBuff[ddtIndex] + (bit.lshift(typeBits, 2))
			elseif ddtSubIndex == 0 then
				self.dataBuff[ddtIndex] = self.dataBuff[ddtIndex] + typeBits
			else
				error("SW_IntTblAscii85:encode invalid ddtSubIndex:"..ddtSubIndex);
			end
			self:appendLast();
		end
		self:encAscii85();
		return true;
	end,
	
	mod = function (num, div)
		--[[ bit.mod returns negative results sometimes??
			bit.mod(2548950517, 85) => -74  (12 correct)

			bit.mod(3429306062, 85) correct is 17 we get -69
			.... greater 31 bit....
		--]]
		return num - (math.floor(num/div) * div);
		
	end,
	getCharNum = function (self, num, index)
		
		local ret;
		
		if index == 5 then
			ret = (num - (math.floor(num/85) * 85)) + 33;
		else
			local tmp = math.floor(num/self.pow85[index]);
			ret = (tmp - (math.floor( tmp /85) * 85)) + 33;
		end
		
		--92 = \  resulted it to trying to escape something in the string 
		-- if sent through chat (126= ~)
		if ret == 92 then ret = 126; end
		return ret;
		
	end,
	--[[
		I'm not adhering to the standard here for the last block
		because i want to use the ~ in syncing
		im not using any start and end markers
		revisited: well i wont be using ~ but wth, it works
		2.0.beta.4 ~ will now replace a \ 
	--]]
	
	encAscii85 = function(self)
		local blockPos = 1;
		local tmpInt = 0;
		local lastIndex = self.insertPos -1;
		local tmpMod =0;
		
		
		self.outBuff.n = 0;
		
	
		while blockPos + 4 <= lastIndex do
			
			tmpInt = bit.lshift(self.dataBuff[blockPos], 24);
			tmpInt = tmpInt + bit.lshift(self.dataBuff[blockPos + 1], 16);
			tmpInt = tmpInt + bit.lshift(self.dataBuff[blockPos + 2], 8);
			tmpInt = tmpInt + self.dataBuff[blockPos + 3];
			
			--[[SW_printStr("oneblock");
			local mul = 3;
			for i=0,3 do
				SW_printStr(string.format("%x", self.dataBuff[blockPos + i]));
				SW_printStr(string.format("%x", bit.lshift(self.dataBuff[blockPos + i], mul * 8)));
				mul = mul -1;
			end
			SW_printStr(tmpInt);
			SW_printStr(string.format("%x", tmpInt));
			--]]
			if tmpInt == 0 then
				table.insert(self.outBuff, "z");	
			else
				
				for i=1, 5 do
					--[[
					tmpMod = bit.mod(math.floor(tmpInt/self.pow85[i]), 85);
					-- wtf? but it happens 
					if tmpMod < 0 then
						tmpMod = 85 + tmpMod + 1;
					end
						screw it i just made a function getCharNum
					--]]
					--self.asc85Buff[i] = tmpMod + 33;
					self.asc85Buff[i] = self:getCharNum(tmpInt, i);
					--SW_printStr(i.."] "..math.floor(tmpInt/self.pow85[i]));
					--SW_printStr(i.." mod85] "..bit.mod(tmpInt/self.pow85[i], 85));
				end
				--SW_DumpTable(self.asc85Buff);
				table.insert(self.outBuff,string.char(unpack(self.asc85Buff)));
			
			end
			blockPos = blockPos + 4;	
		end
		--now handle the last block
		if blockPos == lastIndex then -- 1 byte left
			tmpInt = bit.lshift(self.dataBuff[blockPos], 24);
		elseif blockPos + 1 == lastIndex then -- 2 bytes left
			tmpInt = bit.lshift(self.dataBuff[blockPos], 24);
			tmpInt = tmpInt + bit.lshift(self.dataBuff[blockPos + 1], 16);
		elseif blockPos + 2 == lastIndex then -- 3 bytes left
			tmpInt = bit.lshift(self.dataBuff[blockPos], 24);
			tmpInt = tmpInt + bit.lshift(self.dataBuff[blockPos + 1], 16);
			tmpInt = tmpInt + bit.lshift(self.dataBuff[blockPos + 2], 8);
		else -- exact boundary, 4 bytes left
			tmpInt = bit.lshift(self.dataBuff[blockPos], 24);
			tmpInt = tmpInt + bit.lshift(self.dataBuff[blockPos + 1], 16);
			tmpInt = tmpInt + bit.lshift(self.dataBuff[blockPos + 2], 8);
			tmpInt = tmpInt + self.dataBuff[blockPos + 3];
		end
		
		for i=1, 5 do
			--[[
			tmpMod = bit.mod(tmpInt/self.pow85[i], 85);
			--[[
			if tmpMod < 0 then
				SW_printStr(tmpInt/self.pow85[i].."=>"..tmpMod);
			end
			--]]
			-- wtf? but it happens 
			if tmpMod < 0 then
				tmpMod = 85 + tmpMod + 1;
			end screw this
			--]]
			self.asc85Buff[i] = self:getCharNum(tmpInt, i);
		end
		
		if blockPos == lastIndex then -- 1 byte left
			table.insert(self.outBuff,string.char(self.asc85Buff[1],self.asc85Buff[2]));
		elseif blockPos + 1 == lastIndex then -- 2 bytes left
			table.insert(self.outBuff,string.char(self.asc85Buff[1],self.asc85Buff[2], self.asc85Buff[3]));
		elseif blockPos + 2 == lastIndex then -- 3 bytes left
			table.insert(self.outBuff,string.char(self.asc85Buff[1],self.asc85Buff[2], self.asc85Buff[3], self.asc85Buff[4]));
		else -- exact boundary, 4 bytes left
			table.insert(self.outBuff,string.char(unpack(self.asc85Buff)));
		end
			
	end,
	-- not doing any error checking here atm, as said its not a general enc/decoder
	decode = function (self, str)
		self.insertPos = 1;
		local pos = 1;
		local tmp = 0;
		local lastValid = 0;
		local decNum = 0;
		if not str then
			str = self.decodeThis;
		end
		repeat
			lastValid = 0;
			tmp = string.byte(str,pos);
			if tmp == 122 then -- 122 == z
				lastValid = 5;
				self.dataBuff[self.insertPos] = 0;
				self.dataBuff[self.insertPos + 1] = 0;
				self.dataBuff[self.insertPos + 2] = 0;
				self.dataBuff[self.insertPos + 3] = 0;
				self.insertPos = self.insertPos +4;
				pos = pos + 1;
			else
				for i=1,5 do
					tmp = string.byte(str,(pos + i -1 ));
					--92 = \  resulted it to trying to escape something in the string 126= ~
					if tmp == 126 then tmp = 92; end
					if tmp then
						self.asc85Buff[i] = tmp - 33;
						lastValid = i;
					else
						self.asc85Buff[i] = 0;
					end
				end
				if lastValid > 0 then
					
					decNum = 0;
					for i=1,lastValid do
						decNum = decNum + self.asc85Buff[i] * self.pow85[i];
					end
					if lastValid ~=5 then
						decNum = decNum + self.pow85[lastValid]
					end
					if lastValid == 5 then
						--[[[
						self.dataBuff[self.insertPos] = bit.rshift(bit.band(decNum,SW_4B), 24);
						self.dataBuff[self.insertPos + 1] = bit.rshift(bit.band(decNum,SW_3B), 16);
						self.dataBuff[self.insertPos + 2] = bit.rshift(bit.band(decNum,SW_2B), 8);
						self.dataBuff[self.insertPos + 3] = bit.band(decNum,SW_1B);
						--]]
						self.dataBuff[self.insertPos] = bit.band(bit.rshift(decNum, 24),SW_1B);
						self.dataBuff[self.insertPos + 1] = bit.band(bit.rshift(decNum, 16),SW_1B);
						self.dataBuff[self.insertPos + 2] = bit.band(bit.rshift(decNum, 8),SW_1B);
						self.dataBuff[self.insertPos + 3] = bit.band(decNum,SW_1B);
						self.insertPos = self.insertPos + 4;
					elseif lastValid == 2 then
						--self.dataBuff[self.insertPos] = bit.rshift(bit.band(decNum,SW_4B), 24);
						self.dataBuff[self.insertPos] = bit.band(bit.rshift(decNum, 24),SW_1B);
						self.insertPos = self.insertPos + 1;
					elseif lastValid == 3 then
						--[[
						self.dataBuff[self.insertPos] = bit.rshift(bit.band(decNum,SW_4B), 24);
						self.dataBuff[self.insertPos + 1] = bit.rshift(bit.band(decNum,SW_3B), 16);
						--]]
						self.dataBuff[self.insertPos] = bit.band(bit.rshift(decNum, 24),SW_1B);
						self.dataBuff[self.insertPos + 1] = bit.band(bit.rshift(decNum, 16),SW_1B);
						self.insertPos = self.insertPos + 2;
					elseif lastValid == 4 then
						--[[
						self.dataBuff[self.insertPos] = bit.rshift(bit.band(decNum,SW_4B), 24);
						self.dataBuff[self.insertPos + 1] = bit.rshift(bit.band(decNum,SW_3B), 16);
						self.dataBuff[self.insertPos + 2] = bit.rshift(bit.band(decNum,SW_2B), 8);
						--]]
						self.dataBuff[self.insertPos] = bit.band(bit.rshift(decNum, 24),SW_1B);
						self.dataBuff[self.insertPos + 1] = bit.band(bit.rshift(decNum, 16),SW_1B);
						self.dataBuff[self.insertPos + 2] = bit.band(bit.rshift(decNum, 8),SW_1B);
						self.insertPos = self.insertPos + 3;
					end
					pos = pos + 5;
				end
			end
			
		until lastValid ~= 5
		-- now  the data buff is filled with the "binary" data
		
		local ddtStart = 2 + self.dataBuff[1];
		-- self.dataBuff[1]  header length
		local totalNumbers = self:getNumber(2, self.dataBuff[1]);
		local ddtLen = math.ceil(totalNumbers / 4 ); -- 2 bits per number
		local readPos = ddtStart + ddtLen;
		local currentNumber = 1;
		local ddtIndex = 0;
		local ddtSubIndex = 0;
		local numBytes = 0;
		local typeBits = 0;
		--self.lastDecode = {};
		
		
		for i=1, totalNumbers do
			ddtIndex = (math.floor ( (i-1) / 4) + ddtStart);
			typeBits = self.dataBuff[ddtIndex]
			ddtSubIndex = bit.mod (i, 4);
			if ddtSubIndex < 0 then
				SW_printStr(ddtSubIndex);
				ddtSubIndex = 4 + ddtSubIndex + 1;
			end
			if ddtSubIndex == 1 then
				numBytes = bit.band(bit.rshift(typeBits, 6), 3) + 1;
			elseif ddtSubIndex == 2 then
				numBytes = bit.band(bit.rshift(typeBits, 4), 3) + 1;
			elseif ddtSubIndex == 3 then
				numBytes = bit.band(bit.rshift(typeBits, 2), 3) + 1;
			elseif ddtSubIndex == 0 then
				numBytes = bit.band(typeBits, 3) + 1;
			end
			self.lastDecode[i] = self:getNumber(readPos, numBytes);
			readPos = readPos + numBytes;
		end
		self.lastDecode.n = totalNumbers;
		return self.lastDecode, totalNumbers;
	end,
	getNumber = function(self, startIndex, numBytes)
		local num = 0;
		
		if numBytes == 1 then
			return self.dataBuff[startIndex];
		elseif numBytes == 2 then
			num = bit.lshift(self.dataBuff[startIndex], 8);
			num = num + self.dataBuff[startIndex + 1];
		elseif numBytes == 3 then
			num = bit.lshift(self.dataBuff[startIndex], 16);
			num = num + bit.lshift(self.dataBuff[startIndex + 1], 8);
			num = num + self.dataBuff[startIndex + 2];
		elseif numBytes == 4 then
			num = bit.lshift(self.dataBuff[startIndex], 24);
			num = num + bit.lshift(self.dataBuff[startIndex + 1], 16);
			num = num + bit.lshift(self.dataBuff[startIndex + 2], 8);
			num = num + self.dataBuff[startIndex + 3];
		end
		return num;
	end,

	-- the dataBuffers are reused, but if you have used it for a huge array
	-- and you know the next arrays will always be small, use this to release the old buffer
	releaseBuffers = function(self)
		self.dataBuff = {};
		self.insertPos = 0;
		self.lastDecode = {};
		self.outBuff = {};
	end,
	appendLast = function(self)
		local start = 5 - self.lastSize;
		for i=start, 4 do
			self.dataBuff[self.insertPos] = self.byteBuff[i];
			self.insertPos = self.insertPos + 1;
		end
	end,
	insertData = function(self, numB)
		if numB >= SW_1B then
			error("SW_IntTblAscii85:insertData:"..numB.." > 255");
		end
		self.dataBuff[self.insertPos] = numB;
		self.insertPos = self.insertPos + 1;
	end,
	
	dump = function(self)
		SW_printStr("---");
		for i=1, self.insertPos - 1 do
			SW_printStr (self.dataBuff[i]);
		end
	end,	
}

--[[ a little bit crude but does what I need rather simple
	Point is a LOT of data will be 0, so lets not waste space on a per instance basis
	we will always access data through xxx[1] xxx[2] etc. 
	
	it also has the default add method
--]]
SW_C_ZeroTable = {
	new = function (self, o, n)
		o = o or {};
		setmetatable(o, self);
		self.__index = self;
		
		if not n then n=5; end
		if not self.nc or self.nc < n then
			self.nc = n;
			--self.binBuff = {};
			for i=1,n do
				self[i] = 0;
				--self.binBuff[i] = "";
			end
		end
		return o;
	end,
	
	nullify = function (self)
		for i=1, table.getn(self.dataLookup) do
			if self[i] > 0 then
				self[i] = nil;
			end
		end
	end,
	add = function(self, toAdd)
		for i=1,table.getn(self.dataLookup) do
			if toAdd[i] > 0 then
				-- i know this isn't clean ...
				-- don't add on Max, MaxDamage is handeled by school add
				if self.dataLookup[i] == "MaxValue" then
					if toAdd[i] > self[i] then
						self[i] = toAdd[i];
					end
				else
					self[i] = self[i] + toAdd[i];
				end
			end
		end
	end,
	
	ps = function(self, id)
		SW_printStr(self[id]);
	end
}

SW_C_SchoolData = {
	dataLookup = {
		"Damage",
		"MaxDamage",
		"Ticks",
		"Crits",
		"DOTTicks",
		"DOT",
		
		--[[ as a reminder
		"TotalResists" = 20,
		"PartialResists" = 30,
		--]]
	},
	revLookup = {
		["Damage"] = 1,
		["MaxDamage"] = 2,
		["Ticks"] = 3,
		["Crits"] = 4,
		["DOTTicks"] = 5,
		["DOT"] = 6,
	},
	new = function(self, o)
		o = o or {};
		setmetatable(o, self);
		self.__index = self;
		if o[20] then
			o[20] = SW_C_NullDamgeInfo:new(o[20]);
		end
		if o[30] then
			o[30] = SW_C_PartialDamageInfo:new(o[30]);
		end
		return o;
	end,
	
	nullify = function (self)
		for i=1, 6 do
			if self[i] > 0 then
				self[i] = 0;
			end
		end
		if self[20] then
			self[20]:nullify();
		end
		if self[30] then
			self[30]:nullify();
		end
	end,
	getResistRating = function (self)
		if not self then return 0; end
		
		
		local mr = self:getMandR();
		local zd = self:getOtherZeroDmg();
		
		local pr = self:getPartialResists();
		local dmg = self:getDmg();
		local ticks = self:getTicks();
		
		
		if ticks == 0 then
			-- only start displaying 100 resist with at least 5 total resists
			-- (this isn't synced atm and you might just see one total resist scewing this)
			-- normally this isn't really a problem
			-- hmm put it back to 1.. 1 is enough for a twin to get pissy
			if (mr + zd) > 1 then
				return 100;
			else
				return 0;
			end
		end
		-- have to add the avg partial resists aswell, to get the dmg one would resist on full resist
		local avgDmg = (dmg/ticks) + (pr/ticks); 
		
		local dmgGuess = (mr + zd) * avgDmg; -- a guess of the dmg we resisted totally
		local ret = math.floor(((pr + dmgGuess)/(dmgGuess + dmg + pr)) * 1000 + 0.5 ) / 10; 
		if ret < 0.1 then return 0; end
		
		return ret;
	end,
	getDmg = function (self)
		return self[1] + self[6];
	end,
	getMandR = function (self)
		local nd = self[20];
		if not nd then return 0; end
		return nd[2] + nd[3];
	end,
	getOtherZeroDmg = function (self)
		local nd = self[20];
		if not nd then return 0; end
		return nd[1] - nd[2] - nd[3];
	end,
	getPartialResists = function (self)
		local pd = self[30];
		if not pd then return 0; end
		return pd:getPartialTotal();
	end,
	getTicks = function (self)
		return self[3] + self[5];
	end,
	addBD = function(self, oBD)
		local tmpIndex = 0;
		
		if oBD.Damage > self[2] then self[2] = oBD.Damage; end
		
		if oBD.IsPeriodic then
			self[6] = self[6] + oBD.Damage
			self[5] = self[5] + 1;
		else
			self[1] = self[1] + oBD.Damage
			self[3] = self[3] + 1;
			if oBD.IsCrit then self[4] = self[4] + 1; end
		end
		
		if oBD.Trailer then 
			if not self[30] then self[30] = SW_C_PartialDamageInfo:new(); end
			self[30]:addTrailer (oBD.Trailer);
		end
	end,
	addNullDmg = function (self, oMsg)
		if not self[20] then self[20] = SW_C_NullDamgeInfo:new(); end
		self[20]:addNullDmg(oMsg);
	end,
	-- don't use the default add here we have 2 extra entries
	add = function (self, toAdd)
		for i=1,6 do
			if toAdd[i] > 0 then
				if i == 2 then -- max damage
					if toAdd[i] > self[i] then
						self[i] = toAdd[i];
					end
				else
					self[i] = self[i] + toAdd[i];
				end
			end
		end
		if toAdd[20] then
			if not self[20] then
				self[20] = SW_C_NullDamgeInfo:new();
			end
			self[20]:add(toAdd[20]);
		end
		if toAdd[30] then
			if not self[30] then
				self[30] = SW_C_PartialDamageInfo:new();
			end
			self[30]:add(toAdd[30]);
		end
	end,
	dump = function(self)
		for k,v in pairs(self) do 
			if self.dataLookup[k] then
				SW_printStr("            ["..self.dataLookup[k].."] = "..v);
			elseif k == 20 then
				SW_printStr("               Resists:");
				self[20]:dump();
			elseif k == 30 then
				SW_printStr("               Trailers:");
				self[30]:dump();
			else
				SW_printStr("            ["..k.."] = "..v);
			end
		end
		
	end,
}
SW_C_SchoolData = SW_C_ZeroTable:new(SW_C_SchoolData, 6);

SW_C_SchoolList = {
	new = function (self, o)
		local initSubO = false;
		if o then
			initSubO = true;
		else
			o = {};
		end
		setmetatable(o, self);
		self.__index = self;
		
		if initSubO then
			for k,v in pairs(o) do 
				o[k] = SW_C_SchoolData:new(v);
			end
		end
		return o;
	end,
	addBD = function(self, oBD, oMsg)
		if oBD.SchoolID then
			if not self[oBD.SchoolID] then
				self[oBD.SchoolID] = SW_C_SchoolData:new();
			end
			if oMsg then
				self[oBD.SchoolID]:addNullDmg(oMsg);
			else
				self[oBD.SchoolID]:addBD(oBD);
			end
		end
	end,
	getResistRating = function (self, schoolID)
		if not (self and self[schoolID]) then return 0; end
		return self[schoolID]:getResistRating();
	end,
	add = function (self, toAdd)
		for k,v in pairs(toAdd) do
			if not self[k] then
				self[k] = SW_C_SchoolData:new();
			end
			self[k]:add(v);
		end
	end,
	nullify = function (self)
		for k,v in pairs(self) do
			v:nullify();
		end
	end,
	dump = function(self)
		for k,v in pairs(self) do 
			SW_printStr("         School:"..SW_Schools:getStr(k));
			v:dump();
		end
	end,
}
SW_C_TargetList = {
	new = function (self, o)
		local initSubO = false;
		if o then
			initSubO = true;
		else
			o = {};
		end
		setmetatable(o, self);
		self.__index = self;
		
		if initSubO then
			for k,v in pairs(o) do 
				o[k] = SW_C_BasicUnitData:new(v);
			end
		end
		return o;
	end,
	
	addBD = function(self, oBD)
		if not self[oBD.SW_ED.tID] then
			self[oBD.SW_ED.tID] = SW_C_BasicUnitData:new();
		end
		self[oBD.SW_ED.tID]:addBD(oBD);
	end,
	add = function (self, toAdd)
		for k,v in pairs(toAdd) do 
			if not self[k] then
				self[k] = SW_C_BasicUnitData:new();
			end
			self[k]:add(v);
		end
	end,
	dump = function(self)
		for k,v in pairs(self) do 
			SW_printStr("         ToTarget:"..SW_StrTable:getStr(k));
			v:dump();
		end
	end,
}

SW_C_SkillList = {
	new = function (self, o)
		local initSubO = false;
		if o then
			initSubO = true;
		else
			o = {};
		end
		setmetatable(o, self);
		self.__index = self;
		
		if initSubO then
			for k,v in pairs(o) do 
				if v[1] then -- dmg
					o[k][1] = SW_C_BasicSkillData:new(v[1]);
				end
				if v[2] then -- heal
					o[k][2] = SW_C_BasicSkillData:new(v[2]);
				end
				if v[3] then -- OtherNumbers, e.g extra attacks
					o[k][3] = SW_C_BasicSkillData:new(v[3]);
				end
				if v[4] then -- dmgNullify (total resist blocks immune etc)
					o[k][4] = SW_C_NullDamgeInfo:new(v[4]);
				end
				if v[5] then -- partial resists block glancing etc
					o[k][5] = SW_C_PartialDamageInfo:new(v[5]);
				end
				if v[6] then -- Cast Track and Mana info (only for self)
					o[k][6] = SW_C_BasicSkillData:new(v[6]);
				end
			end
		end
		return o;
	end,
	
	addBD = function(self, oBD, oMsg)
		local skillIndex = oBD.SW_ED.skillID;
		if not self[skillIndex] then
			if oMsg and oMsg.IsDmgNullify then
				-- don't add resists if we don't have skill data already
				-- currently this also helps with a problem i think that has to do with 
				-- the extraattack watch stuff
				return false; 
			else
				self[skillIndex] = {};
			end
		end
		if oMsg then -- oMsg is only passed on special stuff
			if oMsg.IsDmgNullify then
				if not self[skillIndex][4] then
					self[skillIndex][4] = SW_C_NullDamgeInfo:new();
				end
				self[skillIndex][4]:addNullDmg(oMsg);
			else --extra attacks etc.
				if not self[skillIndex][3] then
					self[skillIndex][3] = SW_C_BasicSkillData:new();
				end
				self[skillIndex][3]:addBD(oBD, false, oMsg);
			end
		else
			if oBD.Damage then
				if not self[skillIndex][1] then
					self[skillIndex][1] = SW_C_BasicSkillData:new();
				end
				self[skillIndex][1]:addBD(oBD, true);
				if oBD.Trailer then 
					if not self[skillIndex][5] then 
						self[skillIndex][5] = SW_C_PartialDamageInfo:new(); 
					end
					self[skillIndex][5]:addTrailer(oBD.Trailer);
				end
			end
			if oBD.Heal then
				if not self[skillIndex][2] then
					self[skillIndex][2] = SW_C_BasicSkillData:new();
				end
				self[skillIndex][2]:addBD(oBD);
			end
		end
		return true;
	end,
	add = function (self, toAdd)
		local dt;
		
		for k, v in pairs(toAdd) do
			if not self[k] then -- k is a skillID
				self[k] = {};
			end
			dt = self[k];
			
			if v[1] then -- dmg
				if not dt[1] then
					dt[1] = SW_C_BasicSkillData:new();
				end
				dt[1]:add(v[1]);
			end
			if v[2] then -- heal
				if not dt[2] then
					dt[2] = SW_C_BasicSkillData:new();
				end
				dt[2]:add(v[2]);
			end
			if v[3] then -- OtherNumbers, e.g extra attacks
				if not dt[3] then
					dt[3] = SW_C_BasicSkillData:new();
				end
				dt[3]:add(v[3]);
			end
			if v[4] then -- dmgNullify (total resist blocks immune etc)
				if not dt[4] then
					dt[4] = SW_C_NullDamgeInfo:new();
				end
				dt[4]:add(v[4]);
			end
			if v[5] then -- partial resists block glancing etc
				if not dt[5] then
					dt[5] = SW_C_PartialDamageInfo:new();
				end
				dt[5]:add(v[5]);
			end
			if v[6] then -- cast track and mana info
				if not dt[6] then
					dt[6] = SW_C_BasicSkillData:new();
				end
				dt[6]:add(v[6]);
			end
		end
	end,
	addCT = function(self, name, mana)
		local skillIndex = SW_StrTable:getID(name);
		if not self[skillIndex] then
			self[skillIndex] = {};
		end
		if not self[skillIndex][6] then
			self[skillIndex][6] = SW_C_BasicSkillData:new();
		end
		local addTo = self[skillIndex][6];
		addTo[9] = addTo[9] + 1;
		if mana > 0 then
			addTo[10] = addTo[10] + mana;
		end
	end,
	getManaUsed = function (self)
		if not (self and self[6]) then return 0; end
		return self[6][10];
	end,
	getTotalDmg = function(self)
		if not (self and self[1]) then return 0; end
		return self[1][1] + self[1][8];
	end,
	getTotalHeal = function(self)
		if not (self and self[2]) then return 0; end
		return self[2][1] + self[2][8];
	end,
	getAvgDmg = function(self)
		if not (self and self[1]) then return 0; end
		local dmg = self[1][1] + self[1][8];
		if self[1][3] > 0 then -- normal spells (maybe with dot)
			return math.floor((dmg / self[1][3]) * 10 + 0.5) / 10
		else
			-- dot only spells
			return math.floor((dmg / self[1][7]) * 10 + 0.5) / 10
		end
	end,
	getAvgHeal = function(self)
		if not (self and self[2]) then return 0; end
		local heal = self[2][1] + self[2][8];
		if self[2][3] > 0 then -- normal spells (maybe with dot)
			return math.floor((heal / self[2][3]) * 10 + 0.5) / 10
		else
			-- dot only spells
			return math.floor((heal / self[2][7]) * 10 + 0.5) / 10
		end
	end,
	getHits = function(self)
		if not self then return 0; end
		if self[1] then
			return self[1]:getHits();
		elseif self[2] then
			return self[2]:getHits();
		else
			return 0;
		end
	end,
	
	getTicks = function(self)
		if not self then return 0; end
		if self[1] then
			return self[1]:getTicks();
		elseif self[2] then
			return self[2]:getTicks();
		else
			return 0;
		end
	end,
	getMisses = function(self)
		if not self then return 0; end
		if self[4] then
			return self[4][3];
		else
			return 0;
		end
	end,
	getResists = function(self)
		if not self then return 0; end
		if self[4] then
			return self[4][2];
		else
			return 0;
		end
	end,
	getAllNullDmg = function(self)
		if not self then return 0; end
		if self[4] then
			return self[4][1];
		else
			return 0;
		end
	end,
	getCrits = function(self)
		if not self then return 0; end
		if self[1] then
			return self[1][4];
		elseif self[2] then
			return self[2][4];
		else
			return 0;
		end
	end,
	getGlancing = function(self)
		if not self then return 0; end
		if self[5] then
			return self[5][4];
		else
			return 0;
		end
	end,
	getCrushing = function(self)
		if not self then return 0; end
		if self[5] then
			return self[5][3];
		else
			return 0;
		end
	end,
	getPartialTotal = function(self)
		if not self then return 0; end
		if self[5] then
			return self[5]:getPartialTotal();
		else
			return 0;
		end
	end,
	getMax = function (self)
		if not self then return 0; end
		if self[1] then
			return self[1][2];
		elseif self[2] then
			return self[2][2];
		else
			return 0;
		end
	end,
	getMaxDmgAllSkills = function (self)
		local max = 0;
		for k,v in pairs(self) do
			if type(k) == "number" then
				if v[1] and v[1][2] > max then
					max = v[1][2];
				end
			end
		end
		return max;
	end,
	getMaxHealAllSkills = function (self)
		local max = 0;
		for k,v in pairs(self) do
			if type(k) == "number" then
				if v[2] and v[2][2] > max then
					max = v[2][2];
				end
			end
		end
		return max;
	end,
	dump = function(self)
		for k,v in pairs(self) do 
			SW_printStr("         Skill:"..SW_StrTable:getStr(k));
			if v[1] then
				SW_printStr("            Damage:");
				v[1]:dump();
			end
			if v[2] then
				SW_printStr("            Heal:");
				v[2]:dump();
			end
			if v[3] then
				SW_printStr("            Other:");
				v[3]:dump();
			end
			if v[4] then
				SW_printStr("            Resists:");
				v[4]:dump();
			end
			if v[5] then
				SW_printStr("            Trailers:");
				v[5]:dump();
			end
			if v[6] then
				SW_printStr("            CastTrack:");
				v[6]:dump();
			end
		end
	end,
}
-- partial resists blocks glancing etc
SW_C_PartialDamageInfo = {
	dataLookup = {
		"Absorb",
		"Block",
		"Crushing",
		"Glancing",
		"Resist",
		"UnknownTrailer",
	},
	revLookup = {
		["Absorb"] = 1,
		["Block"] = 2,
		["Crushing"] = 3,
		["Glancing"] = 4,
		["Resist"] = 5,
		["UnknownTrailer"] = 6,
	},	
	new = function(self, o)
		o = o or {};
		setmetatable(o, self);
		self.__index = self;
		
		return o;
	end,
	addTrailer = function (self, trailer)
		local tmpIndex = 0;
		for k,v in pairs(trailer) do
			if v > 0 then
				tmpIndex = self.revLookup[k] or self.revLookup["UnknownTrailer"];
				self[tmpIndex] = self[tmpIndex] + v;
			end
		end
	end,
	getPartialTotal = function (self)
		return self[1] + self[2] + self[5];
	end,
	nullify = function(self)
		for i=1, table.getn(self.dataLookup) do
			if self[i] > 0 then
				self[i] = 0;
			end
		end
	end,
	dump = function(self)
		for k,v in pairs(self) do 
			if self.dataLookup[k] then
				SW_printStr("                ["..self.dataLookup[k].."] = "..v);
			else
				SW_printStr("                ["..k.."] = "..v);
			end
		end
	end,
}
SW_C_PartialDamageInfo = SW_C_ZeroTable:new(SW_C_PartialDamageInfo, 6);

SW_C_BasicSkillData = {

	dataLookup = {
		"Value",
		"MaxValue",
		"Ticks",
		"Crits",
		"OverHeal",
		"OverHealInFight",
		"DOTTicks",
		"DOT",
		"CastTrackAmout",
		"CTManaUsed",
		--"DOTCrits",
	},
	revLookup = {
		["Value"] = 1,
		["MaxValue"] = 2,
		["Ticks"] = 3,
		["Crits"] = 4,
		["OverHeal"] = 5,
		["OverHealInFight"] = 6,
		["DOTTicks"] = 7,
		["DOT"] = 8,
		["CastTrackAmout"] = 9,
		["CTManaUsed"] = 10,
		--["DOTCrits"] = 11,
	},
	
	new = function(self, o)
		o = o or {};
		setmetatable(o, self);
		self.__index = self;
		
		return o;
	end,
	getHits = function (self)
		if self[3] > 0 then
			return self[3];
		else
			return self[7];
		end
	end,
	getTicks = function (self)
		return self[3] + self[7];
	end,
	addBD = function (self, oBD, doDmg, oMsg)
		local extA = 0;
		--local isLowDmg = false;
		--local addDmg = 0;
		if oMsg then
			if oMsg.IsExtraAttack then
				extA = oMsg:getData(SW_Types.Number.Attacks);
				if extA then
					--SW_DBG("ExtraAttacks for "..oBD.Target..": "..extA.." through "..oBD.Skill );
					-- note to self this might be inited twice, but thats ok
					-- (when using auto end markers)
					SW_ExtraAttackWatch[oBD.SW_ED.tID] = {["inited"] = false, ["amount"] = extA, skillID = oBD.SW_ED.skillID};
					-- this will count # of extra attacks
					-- the second pass will count dmg done through these attacks 
					self[1] = self[1] + extA;
					if extA > self[2] then self[2] = extA; end
					self[3] = self[3] + 1;
				else
					return;
				end
			end
		else
			if doDmg then
				--[[
				-- attempt to seperate high dmg and dot tick (e.g. fireballs, flamestrike)
				-- add partial "resist" info though eg somebody absored 750 from 800 dmg and only 50 dmg left
				-- -->this was not the dot
				if self[1] > 0 and self[3] > 0 then
					if oBD.Trailer then 
						addDmg = addDmg + oBD.Trailer.Absorb;
						addDmg = addDmg + oBD.Trailer.Block;
						addDmg = addDmg + oBD.Trailer.Resist;
					end
					
					if (oBD.Damage + addDmg ) < ((self[1] / self[3]) * 0.25) then
						-- this is smaller than 25% of your average "normal" damage
						-- had to go this high for flamestrike, might remove this again
						-- so assuming its the dot part (although this does not have to be correct)
						-- eg in bwl, fighting the vulnerable/resistant mobs
						isLowDmg = true;
					end
				end
				
				if isLowDmg then 
				DOH this is so much easier added a periodic indicator		--]]
				if oBD.IsPeriodic then
					self[8] = self[8] + oBD.Damage;
					self[7] = self[7] + 1;
					if oBD.Damage > self[2] then self[2] = oBD.Damage; end
					-- dots cant crit
					--if oBD.IsCrit then self[9] = self[9] + 1; end
				else
					self[1] = self[1] + oBD.Damage;
					if oBD.Damage > self[2] then self[2] = oBD.Damage; end
					self[3] = self[3] + 1;
					if oBD.IsCrit then self[4] = self[4] + 1; end
				end
			else
				self[1] = self[1] + oBD.Heal;
				if oBD.Heal > self[2] then self[2] = oBD.Heal; end
				
				if oBD.Overheal > 0 then 
					if oBD.inF then
						self[6] = self[6] + oBD.Overheal; 
					else
						self[5] = self[5] + oBD.Overheal; 
					end
				end
				self[3] = self[3] + 1;
				if oBD.IsCrit then self[4] = self[4] + 1; end
			end	
		end
	end,
	
	dump = function(self)
		for k,v in pairs(self) do 
			if self.dataLookup[k] then
				SW_printStr("            ["..self.dataLookup[k].."] = "..v);
			else
				SW_printStr("            ["..k.."] = "..v);
			end
		end
	end,
}
SW_C_BasicSkillData = SW_C_ZeroTable:new(SW_C_BasicSkillData, 10);


SW_C_NullDamgeInfo = {
	dataLookup = {
		"TotalNullDmgTick",
		"Resist",
		"Missed",
		"Block",
		"Absorb",
		"Dodge",
		"Parry",
		"Immune",
		"Deflect",
		"Reflect",
		"Evade",
		"UnknownNullDmg",	
	},
	new = function(self, o)
		o = o or {};
		setmetatable(o, self);
		self.__index = self;
		
		return o;
	end,
	
	addNullDmg = function (self, oMsg)
		self[1] = self[1] + 1;
		if oMsg.IsResist then
			self[2] = self[2] + 1;
		elseif oMsg.IsMiss then
			self[3] = self[3] + 1;
		elseif oMsg.IsBlock then
			self[4] = self[4] + 1;
		elseif oMsg.IsAbsorb then
			self[5] = self[5] + 1;
		elseif oMsg.IsDodge then
			self[6] = self[6] + 1;
		elseif oMsg.IsParry then
			self[7] = self[7] + 1;
		elseif oMsg.IsImmune then
			self[8] = self[8] + 1;
		elseif oMsg.IsDeflect then
			self[9] = self[9] + 1;
		elseif oMsg.IsReflect then
			self[10] = self[10] + 1;
		elseif oMsg.IsEvade then
			self[11] = self[11] + 1;
		else
			self[12] = self[12] + 1;
		end
	end,
	dump = function(self)
		for k,v in pairs(self) do 
			if self.dataLookup[k] then
				SW_printStr("                 ["..self.dataLookup[k].."] = "..v);
			else
				SW_printStr("                 ["..k.."] = "..v);
			end
		end
	end,
	nullify = function(self)
		for i=1, table.getn(self.dataLookup) do
			if self[i] > 0 then
				self[i] = 0;
			end
		end
	end,
}
SW_C_NullDamgeInfo = SW_C_ZeroTable:new(SW_C_NullDamgeInfo, 12);

function testlt()
	local x = SW_C_BasicUnitData:new();
	local y = SW_C_BasicUnitData:new();
	x[1] = 10;
	y[1] = 110;
	x[4] = 1;
	SW_printStr((x < y));
	--SW_DumpTable ();
end

-- note to self: in step 1 of new sync just make these objects syncable
-- gives full done, recieved and target to target info
SW_C_BasicUnitData = {
	dataLookup = {
		"Damage",
		"Heal",
		"Deaths",
		"Decurse",
		"TotalDmgTicks",
		"OverHeal",
		"HealInFight",
		"OverHealInFight",
		"DOTTicks",
		"DOTValue",
		"TotalFightTime", 
	},
	outBuff = {};
	new = function(self, o)
		o = o or {};
		setmetatable(o, self);
		self.__index = self;
		
		return o;
	end,
	
	addBD = function (self, oBD, source)
		if oBD.Damage then
			if oBD.IsPeriodic then
				self[10] = self[10] + oBD.Damage
				self[9] = self[9] + 1;
			else
				self[1] = self[1] + oBD.Damage
				self[5] = self[5] + 1;
			end
		end
		if oBD.Heal then
		
			if oBD.inF then
				self[7] = self[7] + oBD.Heal
				if oBD.Overheal > 0 then
					self[8] = self[8] + oBD.Overheal
				end
			else
				self[2] = self[2] + oBD.Heal
				if oBD.Overheal > 0 then
					self[6] = self[6] + oBD.Overheal
				end
			end
		end
		if oBD.IsDecurse then
			--SW_printStr("DecurseCheck SW_C_BasicUnitData:addBD IsDecurse - this should show up at least 3 times 5 times if in a group\r\n"..debugstack(2,1,0));
			self[4] = self[4] + 1;
		end
	end,
	-- used to see if we need to sync
	__lt = function(lh, rh)
		for i=1,table.getn(lh.dataLookup) do
			if lh[i] < rh[i] then
				return true;
			end
		end
		return false;
	end,
	serialize = function (self)
		--[[
		local ret = SW_IntTblAscii85:encode(self, table.getn(self.dataLookup));
		if ret then
			return table.concat(SW_IntTblAscii85.outBuff);
		end
		--]]
		-- 2.0 beta.6 FFS im turning this off atm to see if the rare large numbers come through this
		for i=1, table.getn(self.dataLookup) do
			self.outBuff[i] = math.ceil(self[i]);
		end
		self.outBuff.n = table.getn(self.dataLookup);
		return table.concat(self.outBuff, ",");
		
	end,
	setToDelta = function (self, lh, rh)
		self.hasDeltaVals = false;
		for i=1, table.getn(self.dataLookup) do
			if lh[i] < rh [i] then
				self.hasDeltaVals = true;
				self[i] = rh[i]-lh[i];
			else
				self[i] = 0;
			end
		end
	end,
	setMax = function (self, tbl)
		for i=1, table.getn(self.dataLookup) do
			if self[i] < tbl[i] then
				self[i] = tbl[i];
			end
		end
	end,
	addDeath = function (self)
		self[3] = self[3] + 1;
	end,
	addTFT = function (self, secs)
		self[11] = self[11] + secs;
	end,
	getDamage = function (self)
		return self[1] + self[10];
	end,
	getRawHeal = function (self)
		return self[2] +  self[7];	
	end,
	getInFHeal = function (self)
		return self[7];
	end,
	getEffectiveInFHeal = function (self)
		return self[7] - self[8];
	end,
	getEffectiveHeal = function (self)
		return self[2] +  self[7] - self[8] - self[6];
	end,
	getOH = function (self)
		return self[6] + self[8];
	end,
	getOHInF = function (self)
		return self[8];
	end,
	getInFOHP = function (self)
		if self[7] == 0 then return 0; end
		
		return math.floor((self[8] / self[7]) * 1000 + 0.5) / 10;
	end,
	dump = function(self)
		for k,v in pairs(self) do 
			if self.dataLookup[k] then
				SW_printStr("         ["..self.dataLookup[k].."] = "..v);
			else
				SW_printStr("         ["..k.."] = "..v);
			end
		end
	end,
	
}
SW_C_BasicUnitData = SW_C_ZeroTable:new(SW_C_BasicUnitData, 11);

--[[
	on friends add total fight sec after the fight is over
	doing indiv DPS theck ttfs + SW_RPS
	this way people joining the raid late will have fair dps hps/values
	
	if the unit is in the raid he should be doing something
		
--]]
SW_C_UnitData = {
	new = function (self, o)
		local initSubO = false;
		if o then
			initSubO = true;
		else
			o = {};
		end
		setmetatable(o, self);
		self.__index = self;
		
		if initSubO then
			for k,v in pairs(o) do 
				if k == 1 then -- done
					if o[1][1] then
						o[1][1] = SW_C_BasicUnitData:new(v[1]); 
					end
					if o[1][2] then
						o[1][2] = SW_C_SchoolList:new(v[2]); 
					end
					if o[1][3] then
						o[1][3] = SW_C_SkillList:new(v[3]); 
					end
				elseif k == 2 then --recieved
					if o[2][1] then
						o[2][1] = SW_C_BasicUnitData:new(v[1]); 
					end
					if o[2][2] then
						o[2][2] = SW_C_SchoolList:new(v[2]); 
					end
					if o[2][3] then
						o[2][3] = SW_C_SkillList:new(v[3]); 
					end
				elseif k == 3 then --source to target info
					o[3] = SW_C_TargetList:new(v); 
				end
			end
		end
		return o;
	end,
	--[[
	getBasicData = function (self, recieved)
		if recieved then
			if not not self[2] then return nil; end
		else
			if not not self[1] then return nil; end
		end
	end,
	--]]
	assureSource = function (self)
		if not self[1] then 
			self[1] = {};
			self[1][1] = SW_C_BasicUnitData:new();
			self[1][2] = SW_C_SchoolList:new();
			self[1][3] = SW_C_SkillList:new(); 
		end
	end,
	assureRecieved = function (self)
		if not self[2] then 
			self[2] = {};
			self[2][1] = SW_C_BasicUnitData:new();
			self[2][2] = SW_C_SchoolList:new();
			--self[2][3] = SW_C_SkillList:new();
		end
	end,
	addMsg = function(self, oMsg, oBD, source)
		if source then
			--handle msg if the unit did something
			self:assureSource();
			
			if oMsg.IsExtraAttack then
				self[1][3]:addBD(oBD, oMsg);
			elseif oMsg.IsDmgNullify then
				-- only add school resists if skill resist was added
				if self[1][3]:addBD(oBD, oMsg) then
					self[1][2]:addBD(oBD, oMsg);
				end
			else
				if not oBD.ScrapDamage then
					self[1][1]:addBD(oBD, true);
					if oBD.Damage then
						self[1][2]:addBD(oBD);
					end
					if not oBD.IsDecurse then -- decurse would add empty skill infos
						self[1][3]:addBD(oBD);
					end
				end
				-- detail "who to whom list"
				if not self[3] then 
					self[3] = SW_C_TargetList:new(); 
				end
				self[3]:addBD(oBD);  -- dont check scrap dmg here, the unit is hurting himself and it should be added
			end
		else
			--handle msg if the unit recieved something
			self:assureRecieved();
			
			self[2][1]:addBD(oBD);
			
			if oMsg.IsDmgNullify then
				self[2][2]:addBD(oBD, oMsg);
			elseif oBD.Damage then -- dont check scrap dmg here, the unit is hurting himself
				self[2][2]:addBD(oBD);
			end
			--[[ on EVERY mob this is just to much info 
			 it's kind of interesting for other scenarios but here...
			 in a "boss fight" we have 40 people that might just use a skill once 
			 on every mob this adds a TON of data in a raid or group
			 as this is simple to implement i might add an option to turn on "deep analysis"
			--]]
			--self[2][3]:addBD(oBD);
		end
	end,
	-- currently only basic unit data done and recieved
	-- next order of business is the unit to target list
	addMsgForSync = function (self, oMsg, oBD, source)
		if source then
			--handle msg if the unit did something
			self:assureSource();
			if not oBD.ScrapDamage then
				self[1][1]:addBD(oBD, true);
			end
		else
			--handle msg if the unit recieved something
			-- for sync only basic data atm
			self:assureRecieved();
			self[2][1]:addBD(oBD);
		end
	end,
	addCT = function (self, name, mana)
		self:assureSource();
		self[1][3]:addCT(name, mana);
	end,
	addDeath = function (self)
		self:assureRecieved();
		self[2][1]:addDeath();
	end,
	
	addTFT = function (self, secs)
		self:assureSource();
		self[1][1]:addTFT(secs);
	end,
	
	-- there is no check unit == unit
	-- potentially we could add together any units (pets n owners maybe ??)
	addUnit = function (self, toAdd)
		if toAdd[1] then
			self:assureSource();
			self[1][1]:add( toAdd[1][1] );-- SW_C_BasicUnitData;
			self[1][2]:add( toAdd[1][2] )  -- SW_C_SchoolList;
			self[1][3]:add( toAdd[1][3] )  -- SW_C_SkillList; 
		end
		if toAdd[2] then
			self:assureRecieved();
			self[2][1]:add( toAdd[2][1] );-- SW_C_BasicUnitData;
			self[2][2]:add( toAdd[2][2] )  -- SW_C_SchoolList;
			-- self[2][3]:add( toAdd[2][3] )  -- SW_C_SkillList; 
		end
		if toAdd[3] then
			if not self[3] then 
				self[3] = SW_C_TargetList:new(); 
			end
			self[3]:add(toAdd[3]);
		end
	end,
	getBasicDataDone = function (self, create)
		if not self then return; end
		
		if create then
			self:assureSource();
		end
		
		if self[1] then
			return self[1][1];
		end
	end,
	getBasicDataRecieved = function (self, create)
		if not self then return; end
		
		if create then
			self:assureRecieved();
		end
		
		if self[2] then
			return self[2][1];
		end
	end,
	dump = function(self)
		for k,v in pairs(self) do 
			if k == 1 then
				SW_printStr("   Done");
				v[1]:dump();
				v[2]:dump();
				v[3]:dump();
			elseif k == 2 then
				SW_printStr("   Recieved");
				v[1]:dump();
				v[2]:dump();
				--v[3]:dump();
			elseif k == 3 then
				SW_printStr("   TargetInfo");
				v:dump();
			end
			
		end
	end,
	dumpDR = function(self)
		for k,v in pairs(self) do 
			if k == 1 then
				SW_printStr("   Done");
				v[1]:dump();
				v[2]:dump();
				v[3]:dump();
			elseif k == 2 then
				SW_printStr("   Recieved");
				v[1]:dump();
				v[2]:dump();
				--v[3]:dump();
			end
		end
	end,

	-- all accesors for getting a certain value
	getDeaths = function (self)
		if not (self and self[2]) then return 0; end
		return self[2][1][3];
	end,
	getDecurseDone = function(self)
		if not (self and self[1]) then return 0; end
		return self[1][1][4];
	end,
	getDecurseRecieved = function(self)
		if not (self and self[2]) then return 0; end
		return self[2][1][4];
	end,
	getHealCrit = function (self)
		if not (self and self[1]) then return 0; end
		local hits = 0
		local crits = 0;
		for k,v in pairs(self[1][3]) do
			if v[2] and v[2][4] > 0 then -- only add if we have at least one crit
				hits = hits + v[2][3];
				crits = crits + v[2][4];
			end
		end 
		if hits > 0 and crits > 0 then
			return math.floor((crits / hits) * 1000 + 0.5) / 10;
		else
			return 0;
		end
	end,
	getDmgCrit = function (self)
		if not (self and self[1]) then return 0; end
		local hits = 0
		local crits = 0;
		
		for k,v in pairs(self[1][3]) do
			-- only add if we have at least one crit
			-- to filter out not critable ticks
			if v[1] and v[1][4] > 0 then 
				hits = hits + v[1][3];
				crits = crits + v[1][4];
				--SW_printStr(SW_StrTable:getStr(k).." "..v[1][3].." ".. v[1][4]);
			end
		end
		if hits > 0 and crits > 0 then
			return math.floor((crits / hits) * 1000 + 0.5) / 10;
		else
			return 0;
		end
	end,
	getDPS = function (self)
		if not self then return 0; end
		local dmg = self:getDmgDone();
		if dmg < 1 then 
			return 0;
		end
		local secs = self:getTFT();
		if secs < 1 then
			return 0;
		end
		return math.floor((dmg/secs) * 10 + 0.5) / 10;
	end,
	getDPSRecieved = function (self)
		if not self then return 0; end
		local dmg = self:getDmgRecieved();
		if dmg < 1 then 
			return 0;
		end
		local secs = self:getTFT();
		if secs < 1 then
			return 0;
		end
		return math.floor((dmg/secs) * 10 + 0.5) / 10;
	end,
	getHPS = function (self)
		if not self then return 0; end
		local heal = self:getEffectiveInFHealDone();
		if heal < 1 then 
			return 0;
		end
		local secs = self:getTFT();
		if secs < 1 then
			return 0;
		end
		return math.floor((heal/secs) * 10 + 0.5) / 10;
	end,
	getDmgDone = function (self)
		if not self then return 0; end
		if self[1] then
			return self[1][1]:getDamage();
		else 
			return 0;
		end
	end,
	
	getDmgRecieved = function (self)
		if not self then return 0; end
		if self[2] then
			return self[2][1]:getDamage();
		else 
			return 0;
		end
	end,
	getSkillList = function (self)
		if not (self and self[1]) then return; end
		return self[1][3];
	end,
	getSchoolDone = function (self)
		if not (self and self[1]) then return; end
		return self[1][2];
	end,
	getSchoolRecieved = function (self)
		if not (self and self[2]) then return; end
		return self[2][2];
	end,
	getRawHealDone = function (self)
		if not self then return 0; end
		if self[1] then
			return self[1][1]:getRawHeal();
		else
			return 0;
		end
	end,
	getRawHealRecieved = function (self)
		if not self then return 0; end
		if self[2] then
			return self[2][1]:getRawHeal();
		else
			return 0;
		end
	end,
	getInFHealDone = function (self)
		if not self then return 0; end
		if self[1] then
			return self[1][1]:getInFHeal();
		else
			return 0;
		end
	end,
	getInFHealRecieved = function (self)
		if not self then return 0; end
		if self[2] then
			return self[2][1]:getInFHeal();
		else
			return 0;
		end
	end,
	getEffectiveInFHealDone = function (self)
		if not self then return 0; end
		if self[1] then
			return self[1][1]:getEffectiveInFHeal();
		else
			return 0;
		end
	end,
	getEffectiveInFHealRecieved = function (self)
		if not self then return 0; end
		if self[2] then
			return self[2][1]:getEffectiveInFHeal();
		else
			return 0;
		end
	end,
	getEffectiveHealDone = function (self)
		if not self then return 0; end
		if self[1] then
			return self[1][1]:getEffectiveHeal();
		else
			return 0;
		end
	end,
	getEffectiveHealRecieved = function (self)
		if not self then return 0; end
		if self[2] then
			return self[2][1]:getEffectiveHeal();
		else
			return 0;
		end
	end,
	getOHDone = function (self)
		if not self then return 0; end
		if self[1] then
			return self[1][1]:getOH();
		else
			return 0;
		end
	end,
	getOHRecieved = function (self)
		if not self then return 0; end
		if self[2] then
			return self[2][1]:getOH();
		else
			return 0;
		end
	end,
	getOHInFDone = function (self)
		if not self then return 0; end
		if self[1] then
			return self[1][1]:getOHInF();
		else
			return 0;
		end
	end,
	getOHInFRecieved = function (self)
		if not self then return 0; end
		if self[2] then
			return self[2][1]:getOHInF();
		else
			return 0;
		end
	end,
	getOHInFPercentDone = function(self)
		if not self then return 0; end
		if self[1] then
			return self[1][1]:getInFOHP();
		else
			return 0;
		end
	end,
	getOHInFPercentRecieved = function(self)
		if not self then return 0; end
		if self[2] then
			return self[2][1]:getInFOHP();
		else
			return 0;
		end
	end,
	getMaxHitDone = function (self)
		if not self then return 0; end
		if self[1] then
			return self[1][3]:getMaxDmgAllSkills();
		else
			return 0;
		end
	end,
	getMaxHealDone = function (self)
		if not self then return 0; end
		if self[1] then
			return self[1][3]:getMaxHealAllSkills();
		else
			return 0;
		end
	end,
	getResistRating = function (self, ID)
		if not (self and self[2]) then return 0; end
		return self[2][2]:getResistRating(ID);
	end,
	getTargetUnitBasics = function (self, ID)
		--if not self then return; end
		if self[3] and self[3][ID] then
			return self[3][ID];
		else
			return nil;
		end
	end,
	getTargetBasics = function (self)
		--if not self then return; end
		return self[3];
	end,
	
	getTFT = function (self)
		local curr = 0;
		if SW_RPS.isRunning then
			curr = SW_RPS.currentSecs;
		end
		if self[1] then
			return self[1][1][11] + curr;
		else 
			return curr;
		end
	end,
	
	setTFT = function (self, val)
		self:assureSource();
		self[1][1][11] = val;
	end,	 
	
	get = function (self, funcName)
		return self[funcName](self);
	end,
}

--[[
	The data segments are only valid with the corresponding string list
	this is done to avoid having the same string hundreds of time in memory
	-> Clearing the string table invalidates all collected data...Keep that in mind
	Nr 2 to remember each client will have it's own ids eg "Fred" for one might be 23
	for somebody else it might be 2 -> they are not usefull in the sync channel
	
--]]
SW_C_DataSegment = {
	new = function (self, o)
		local initSubO = false;
		if o then
			initSubO = true;
		else
			o = {};
			o.initTS = SW_C_Timer:new();
			
		end
		setmetatable(o, self);
		self.__index = self;
		
		if initSubO then
			for k,v in pairs(o) do 
				if type(k) == "number" then
					o[k] = SW_C_UnitData:new(v);
				elseif k == "initTS" then
					o[k] = SW_C_Timer:new(v);
				end
			end
		end
		return o;
	end,
	
	
	addMsg = function(self, oMsg, v)
		
		if oMsg.IsHeal or v.Damage or oMsg.IsDmgNullify or v.IsDecurse then
			if not oMsg.IsEnviro then
				if not self[v.SW_ED.sID] then
					self[v.SW_ED.sID] = SW_C_UnitData:new();
				end
				self[v.SW_ED.sID]:addMsg(oMsg, v, true);
			end
			if not self[v.SW_ED.tID] then
				self[v.SW_ED.tID] = SW_C_UnitData:new();
			end
			self[v.SW_ED.tID]:addMsg(oMsg, v);
		elseif oMsg.IsExtraAttack then
			-- on extra attacks the target is to be used as "source"
			-- because the source is world, and the target gains the extra attacks
			if not self[v.SW_ED.tID] then
				self[v.SW_ED.tID] = SW_C_UnitData:new();
			end
			self[v.SW_ED.tID]:addMsg(oMsg, v, true);	
		elseif oMsg.IsDeath then
			if not self[v.SW_ED.tID] then
				self[v.SW_ED.tID] = SW_C_UnitData:new();
			end
			self[v.SW_ED.tID]:addDeath();
		end
		--SW_dumpTable(v);
	end,
	addMsgForSync = function(self, oMsg, v)
		if oMsg.IsHeal or v.Damage or v.IsDecurse then
			if not oMsg.IsEnviro then
				if not self[v.SW_ED.sID] then
					self[v.SW_ED.sID] = SW_C_UnitData:new();
				end
				self[v.SW_ED.sID]:addMsgForSync(oMsg, v, true);
			end
			if not self[v.SW_ED.tID] then
				self[v.SW_ED.tID] = SW_C_UnitData:new();
			end
			self[v.SW_ED.tID]:addMsgForSync(oMsg, v);	
		elseif oMsg.IsDeath then
			if not self[v.SW_ED.tID] then
				self[v.SW_ED.tID] = SW_C_UnitData:new();
			end
			self[v.SW_ED.tID]:addDeath();
		end
	end,
	addTFT = function (self, ID, secs)
		if self[ID] then
			self[ID]:addTFT(secs);
		end
	end,
	
	isEmpty = function (self)
		for k,v in pairs(self) do 
			if type(k) == "number" then
				return false;
			end
		end
		return true;
	end,
	
	-- explicitly not using __add metamethod, don't want to have a new object on every + operation
	-- and want to reserve that in case i need it later
	addDS = function (self, toAdd)
		for k,v in pairs(toAdd) do 
			if type(k) == "number" then
				if not self[k] then
					self[k] = SW_C_UnitData:new();
				end
				self[k]:addUnit(v);
			end
		end
	end,
	addCT = function (self, name, mana)
		local uID = SW_StrTable:getID(SW_SELF_STRING);
		if not self[uID] then
			self[uID] = SW_C_UnitData:new();
		end
		self[uID]:addCT(name, mana);
	end,
	-- creates a deep copy of self
	getDC = function (self)
		local dc = SW_C_DataSegment:new();
		dc:addDS(self);
		return dc;
	end,
	dump = function(self)
		SW_printStr("~~~ DUMPING Data Segment~~~");
		for k,v in pairs(self) do 
			if type(k) == "number" then
				SW_printStr(SW_StrTable:getStr(k));
				v:dump();
			end
		end
	end,
	
	dumpOne = function(self, name)
		
		local ID = SW_StrTable:hasID(name);
		if ID and self[ID] then
			SW_printStr("~~~ DUMPING "..name.."~~~");
			self[ID]:dump();
		else
			SW_printStr("~~~ NO DATA FOR "..name.."~~~");
		end
	end,
	
	dumpID = function(self, ID)
		if self[ID] then
			self[ID]:dump();
		end
	end,
	dumpDR_ID = function(self, ID)
		if self[ID] then
			self[ID]:dumpDR();
		end
	end,

}

--[[
	Virtual groups
	The basic idea here is to group different units together 
--]]
SW_C_VirtualGroups = {

}

--[[
	Used to hold meta info about units
	this isnt really needed atm as a class
	its more for "documentation"
--]]
SW_C_UnitMeta = {
	allPets = nil; --{}, -- current and previous pets IDs
	petID = nil; -- current petID
	unitType = nil,
	unitID = nil, -- this is the WOW id like "player" "party1" etc
	class = nil,
	classE = nil,
	everGroup = nil,
	stringID = nil, -- the internal string id, also used in the data collection
	--currentGroup = nil,
	level = nil,
	type = nil, -- PC or NPC
	-- pet specific meta info
	isPetData = nil;
	origName = nil;
	new = function (self, o)
		o = o or {};
		
		setmetatable(o, self);
		self.__index = self;
		
		return o;
	end,
}

--[[
	Replaces the old Firends and pet system
	there may only be ONE object of this type
	
	it might make sense not adding this to the data collection and
	just storing it seperatly 
--]]
SW_C_DCMeta = {
	currentGroup = {},
	everGroup = {},
	currentPets = {},
	
	new = function (self, o)
		local initSubO = false;
		if o then
			initSubO = true;
		else
			o = {};
		end
		setmetatable(o, self);
		self.__index = self;
		
		if initSubO then
			for k,v in pairs(o) do 
				o[k] = SW_C_UnitMeta:new(v);
				if v.everGroup then
					self.everGroup[k] = true;
				end
			end
		end
		
		return o;
	end,
	
	-- maybe rework this reusing some of tables
	-- but its not like this happens 100's of times per minute
	-- 2.0 beta.6 slightly changed this 
	updateGroupRaid = function (self)
		--SW_printStr("updateGroupRaid");
		local name, rank,sg,lev, tmpUID;
		local ID = SW_StrTable:getID(SW_SELF_STRING);
			
		SW_C_DCMeta.currentGroup = { [SW_SELF_STRING] = {["uID"] = "player", ["sID"] = ID } };
		SW_C_DCMeta.everGroup[ID] = true;
		-- holds currently valid pets of the raid
		-- is updated in doOneUnit
		SW_C_DCMeta.currentPets = {}; 
		
		local oneMeta = self:doOneUnit(SW_SELF_STRING, "player");
		oneMeta.type = "PC";
		oneMeta.everGroup = true;
		-- check self as party leader
		if IsPartyLeader() or IsRaidLeader() then
			oneMeta.rank = 2;
		elseif IsRaidOfficer() then
			oneMeta.rank = 1;
		else
			oneMeta.rank = 0;
		end
		--oneMeta.unitID = "player";
		
		if GetNumRaidMembers() > 0 then
			for i=1, 40 do
				--name, rank, subgroup, level, class, fileName, zone, online, isDead = GetRaidRosterInfo(i)
				name, rank,sg,lev = GetRaidRosterInfo(i);
				if name and name ~= SW_SELF_STRING then
					tmpUID = "raid"..i;
					oneMeta = self:doOneUnit(name, tmpUID);
					oneMeta.everGroup = true;
					oneMeta.rank = rank;
					oneMeta.type = "PC";
					--oneMeta.unitID = tmpUID;
					oneMeta.raidIndex = i;
					SW_C_DCMeta.currentGroup[name] = {["uID"] = tmpUID, ["sID"] = oneMeta.stringID};
					SW_C_DCMeta.everGroup[oneMeta.stringID] = true;
				end
			end
		elseif GetNumPartyMembers() > 0 then
			for i=1, 4 do
				name = UnitName("party"..i);
				if name then
					tmpUID = "party"..i;
					oneMeta = self:doOneUnit(name, tmpUID);
					oneMeta.everGroup = true;
					oneMeta.raidIndex = nil;
					if UnitIsPartyLeader(tmpUID) then
						oneMeta.rank = 2;
					else
						oneMeta.rank = 0;
					end
					oneMeta.type = "PC";
					--oneMeta.unitID = "party"..i;
					SW_C_DCMeta.currentGroup[name] = {["uID"] = tmpUID, ["sID"] = oneMeta.stringID};
					SW_C_DCMeta.everGroup[oneMeta.stringID] = true;
				end
			end
		end
		-- i have no clue how this can happen, but sometimes it does.
		for k,v in pairs(SW_C_DCMeta.everGroup) do
			if SW_DataCollection.meta[k] and SW_DataCollection.meta[k].type ~= "PC" then
				SW_C_DCMeta.everGroup[k] = nil;
			end
		end
	end,
	
	-- basic unitMeta stuff
	doOneUnit = function (self, unitName, unitID)
		
		local unitClass, englishClass = UnitClass(unitID);
		local ID = SW_StrTable:getID(unitName);
		local classAvailable = false;
		local unitMeta;
		local unitPetName, unitPetID, petMeta;
		
		if englishClass ~= nil and unitClass ~= nil then
			-- once we collected all classes no need to keep assigning
			if not SW_ClassNames.done then
				SW_ClassNames[englishClass] = unitClass;
				SW_ClassNames.done = true
				for k,v in pairs(SW_ClassNames) do
					if type(v) == "string" and v == "" then
						SW_ClassNames.done = false;
						break;
					end
				end
			end
			classAvailable = true;
		end
		
		if self[ID] then
			unitMeta = self[ID];
		else
			unitMeta = SW_C_UnitMeta:new();
			self[ID] = unitMeta;
		end
		unitMeta.origName = unitName;
		unitMeta.stringID = ID;
		unitMeta.level = UnitLevel(unitID);
		
		if classAvailable then
			--unitMeta.class = unitClass; -- no need to have both, use SW_ClassNames for localized classes
			unitMeta.classE = englishClass;
		end
		
		-- there are tons of conditions when UnitPlayerControlled can return nil
		-- and would make somebody an npc
		-- once we had a unit as pc.. keep it that way
		-- hmm wait a sec what about mind controlled pets .. UnitIsCharmed works
		if unitMeta.type ~= "PC" then
			if UnitPlayerControlled(unitID) then
				if not UnitIsCharmed(unitID) then
					unitMeta.type = "PC";
				end
			else
				unitMeta.type = "NPC";
			end
		end
		
		-- the rest here handles pets
		unitMeta.petID = nil;
		-- "translate" target and mouseover if we can
		if unitID == "target" or unitID == "mouseover" then 
			if self.currentGroup[unitName] and UnitIsUnit(self.currentGroup[unitName].uID, unitID) then
				unitID = self.currentGroup[unitName].uID;
			end 
		end
		
		if unitID == "player" then
			--SW_printStr("doOneUnit:player");
			--unitMeta.type = "PC";
			unitPetID = "pet";
		elseif string.find(unitID, "^party%d-") then
			--SW_printStr("doOneUnit:party:"..unitID);
			--unitMeta.type = "PC";
			unitPetID = string.gsub(unitID, "party", "partypet");
		elseif string.find(unitID, "^raid%d-") then
			--SW_printStr("doOneUnit:raid:"..unitID);
			--unitMeta.type = "PC";
			unitPetID =  string.gsub(unitID, "raid", "raidpet");
		else
			return unitMeta;
		end
		
		unitPetName = UnitName(unitPetID);
		if unitPetName == nil then
			-- remove released and dead pets
			for k,v in pairs(self.currentPets) do
				if v == unitPetID then
					unitPetName = k;
					break;
				end
			end
			if unitPetName then
				self.currentPets[unitPetName] = nil;
			end
			return unitMeta;
		elseif unitPetName == UNKNOWNOBJECT then
			SW_Timed_Calls.retryUnknownObject = true;
			return unitMeta;
		elseif unitName == unitPetName then
			-- a hunter named his pet after himself
			-- can't handle these pets as the combatlog only has the name
			return unitMeta;
		end
		
		-- for lookup if this is currently a valid pet in the raid / group
		SW_C_DCMeta.currentPets[unitPetName] = unitPetID;
		
		-- the current pet needs the prefix for mind control enslave etc.
		-- we dont want to mix data the unit did before, with data while the unit is a pet
		ID = SW_StrTable:getID(SW_PET..unitPetName);
		if self[ID] then
			petMeta = self[ID];
		else
			petMeta = SW_C_UnitMeta:new();
			petMeta.stringID = ID;
			self[ID] = petMeta;
		end
		-- for petData these are the only MetaInfos we are tracking
		petMeta.isPetData = true; 
		petMeta.origName = unitPetName;
		_, englishClass = UnitClass(unitPetID);
		if englishClass then
			petMeta.classE = englishClass;
		end
		
		unitMeta.petID = ID; -- set current pet of the owner
		if not unitMeta.allPets then
			unitMeta.allPets = {};
		end
		unitMeta.allPets[ID] = true;
		
		return unitMeta;
	end,
	
	updateMeta = function (self, unitID)
		local unitName = UnitName(unitID);
		
		if unitName and SW_StrTable:hasID(unitName) then	
			--SW_printStr(unitName);
			self:doOneUnit(unitName, unitID);
		end
	end,
	
	-- only works for people/pets currently in the group
	getUnitID = function (self, name)
		if self.currentGroup[name] then
			return self.currentGroup[name].uID;
		elseif self.currentPets[name] then
			return self.currentPets[name];
		else
			return nil;
		end
	end,
	
	--[[
	-- add total fight time
	-- called when the raids switches from "in fight"
	-- to "out of fight"
	addTFT = function (self, secs)
		for k,v in pairs(self.currentGroup) do
			
		end
	end,
	--]]
}

function SW_OnFightEnd(secs)
	SW_DataCollection:addFightDur(secs);
end
--[[
	there may only be ONE instance of this
	its done like this for easy save load
	This holds all relevent data
]]--

SW_C_DataCollection = {
	
	onMarkersChanged = {},
	-- special data segment for syncing;
	syncDS = nil,
	syncCompareDS = nil,
	
	new = function (self, o)
		local initSubO = false;
		if o then
			initSubO = true;
		else
			o = {};
		end
		setmetatable(o, self);
		self.__index = self;
		
		self.applicableUnits = {};
		self.applicableUnits.data = {};
		self.applicableUnits.meta = {};
		
		self.VPR = {};
		--self.VPRMeta = {isPetData = true, origName = SW_STR_VPR, VPR = true}
		
		self.involvedInFight = {};
		self.selectedSegments = {};
		
		self.trashDummy = { trashMe = true };
		
		o.meta = SW_C_DCMeta:new(o.meta);
		
		if initSubO then
			for k,v in ipairs(o.data) do 
				o.data[k] = SW_C_DataSegment:new(v);
			end
			if not o.settings.activeOnly then
				o:updateSum();
			end
		else
			-- default for markers is active only, this uses less memory and is faster
			o.settings = {};
			o.data = {};
			table.insert(o.data, SW_C_DataSegment:new());
			o.data[1]["Name"] = SW_DS_START;
			o.settings.startMarker = 1;
			o.settings.endMarker = 1;
			o.settings.activeOnly = true;
			o.settings.lastZone = "";
			o.settings.isInGroup = false;
			o.settings.isInRaid = false;
			self.calcedDS = {};
		end
		o.settings.smallestSelect = 0;
		o.settings.biggestSelect = 0;
			
		local n = table.getn(o.data);
		self.activeSegment = o.data[n];	
		
		return o;
	end,
	
	addMsg = function (self, oMsg)
		local v = oMsg:getBasicData();
		if not (v and v.Source) then return end;
		-- not clean .. hmm maybe make string lookup a core part of the parser itself?
		-- at least add the prefix to it
		if not v.SW_ED then v.SW_ED = SW_ED; end
		
		if oMsg.IsCast and (not v.IsDecurse) then
			-- only handeling decurse
			-- might check general cast msgs in the future
			-- note to self check SW_C_SkillList:addBD and SW_C_UnitData:addMsg when adding support for general skills
			-- right now resists are (partially) filtered out there to avoid junk
			return;
		end
		
		-- the pet prefix is mainly used not to mix data
		-- of enslaved and mc'd "while pet" with normal data
		if self.meta.currentPets[v.Source] then
			v.SW_ED.sID = SW_StrTable:getID(SW_PET..v.Source);
		else
			v.SW_ED.sID = SW_StrTable:getID(v.Source);
		end 
		if self.meta.currentPets[v.Target] then
			v.SW_ED.tID = SW_StrTable:getID(SW_PET..v.Target);
		else
			v.SW_ED.tID = SW_StrTable:getID(v.Target);
		end 
		
		
		local tmp = SW_ExtraAttackWatch[v.SW_ED.sID];
		if tmp then
			if tmp.inited then
				if oMsg.IsDmgNullify then
					tmp.amount = tmp.amount - 1;
					if tmp.amount == 0 then
						SW_ExtraAttackWatch[v.SW_ED.sID] = nil;
					end
				elseif v.Damage then
					if v.Skill then
						--SW_DBG("WARNING: Skill usage '"..v.Skill.."' while checking extra attacks for "..v.Source);
						v.SW_ED.skillID = SW_StrTable:getID(v.Skill);
					else
						--use the skill ID that started the extra attacks
						v.SW_ED.skillID = tmp.skillID;
						--SW_DBG(SW_StrTable:getStr(v.SW_ED.sID).." EADMG: "..v.Damage.." through "..SW_StrTable:getStr(tmp.skillID));
						tmp.amount = tmp.amount - 1;
						if tmp.amount == 0 then
							SW_ExtraAttackWatch[v.SW_ED.sID] = nil;
						end
					end
				end
			else
				if v.Damage then
					tmp.inited = true;
					if v.Skill then
						v.SW_ED.skillID = SW_StrTable:getID(v.Skill);
					else
						v.SW_ED.skillID = SW_StrTable:getID(SW_PRINT_ITEM_NORMAL);
					end
				end
			end
		else
			if v.Skill then
				v.SW_ED.skillID = SW_StrTable:getID(v.Skill);
			else
				v.SW_ED.skillID = SW_StrTable:getID(SW_PRINT_ITEM_NORMAL);
			end
		end
		
		if v.inF then
			SW_C_DataCollection.involvedInFight[v.SW_ED.sID] = true;
			SW_C_DataCollection.involvedInFight[v.SW_ED.tID] = true;
		end
		--updates meta we selected, had no data for it and something happened to it
		if not self.meta[v.SW_ED.tID] then
			if (UnitName("target")) == v.Target then
				SW_DataCollection.meta:updateMeta("target");
			end
		end
		
		if SW_CORE_SYNC_ONLY then
			if self.syncCompareDS then
				-- toned down version
				self.syncCompareDS:addMsgForSync(oMsg, v);
			end
		else
			self.activeSegment:addMsg(oMsg, v);
			if self.settings.autoEndMarker then
				self.calcedDS:addMsg(oMsg, v);
			end
			if self.syncCompareDS then
				-- toned down version
				self.syncCompareDS:addMsgForSync(oMsg, v);
			end
		end
	end,
	addCT = function (self, name, mana)
		self.activeSegment:addCT(name, mana);
		if self.settings.autoEndMarker then
			self.calcedDS:addCT(name, mana);
		end
	end,
	addFightDur = function (self, secs)
		--SW_printStr("FE: "..secs);
		for k,v in pairs(SW_C_DataCollection.involvedInFight) do
			self.activeSegment:addTFT(k, secs);
			if self.settings.autoEndMarker then
				self.calcedDS:addTFT(k, secs);
			end
			-- dont add here just set it to local val
			if self.syncCompareDS and self.syncCompareDS[k] and self.activeSegment[k] then
				self.syncCompareDS[k]:setTFT(self.activeSegment[k]:getTFT());
			end
			SW_C_DataCollection.involvedInFight[k] = nil;
		end
		--SW_C_DataCollection.involvedInFight = {};
	end,
	
	getSkillList = function(self, inf, bSet)
		if inf.varType == "TEXT" then
			if not bSet.TV then return; end
			return self:getUnitSkillList(SW_StrTable:hasID(bSet.TV), bSet);
		elseif inf.varType == "SELF" then
			return self:getUnitSkillList(SW_StrTable:hasID(SW_SELF_STRING), bSet);
		else
			return;
		end
		
	end,
	getUnitSkillList = function(self, ID, bSet)
		if not ID then return; end
		local unit = self:getDS()[ID];
		if not unit then return; end
		
		if bSet then
			return unit:getSkillList(), ID, bSet.TV;
		else
			return unit:getSkillList();
		end
	end,
	
	getSchoolDone = function(self, inf, bSet)
		if inf.varType ~= "TEXT" or not bSet.TV then return; end
		local ID = SW_StrTable:hasID(bSet.TV);
		if not ID then return; end
		local unit = self:getDS()[ID];
		if not unit then return; end
		return unit:getSchoolDone(), ID, bSet.TV;
	end,
	getSchoolRecieved = function(self, inf, bSet)
		if inf.varType ~= "TEXT" or not bSet.TV then return; end
		local ID = SW_StrTable:hasID(bSet.TV);
		if not ID then return; end
		local unit = self:getDS()[ID];
		if not unit then return; end
		return unit:getSchoolRecieved(), ID, bSet.TV;
	end,
	getUnitSchoolDone = function(self, ID)
		if not ID then return; end
		local unit = self:getDS()[ID];
		if not unit then return; end
		return unit:getSchoolDone();
	end,
	getUnitSchoolRecieved = function(self, ID)
		if not ID then return; end
		local unit = self:getDS()[ID];
		if not unit then return; end
		return unit:getSchoolRecieved();
	end,
	-- the entire 2.0 filtering system
	-- never ever change data in the tables returned by this
	getApplicableUnits = function (self, inf, bSet) 
		local petFil = nil;
		local selFil;
		local charFil;
		local ret = self.applicableUnits;
		local eg = self.meta.everGroup;
		local cg = self.meta.currentGroup;
		local unitData;
		local index = 1;
		local ds = self:getDS();
		local tmpMeta;
		
		for i=1, table.getn(ret.data) do 
			table.remove(ret.data);
		end
		for k,_ in pairs(self.VPR) do 
			self.VPR[k] = nil;
		end
		
		if inf.hasPF and bSet and bSet.PF then
			petFil = getglobal(bSet.PF).petFil;
		else
			petFil = SW_PF_Inactive.petFil;
		end
		if bSet and bSet.SF then
			selFil = getglobal(bSet.SF).SW_Filter;
		else
			selFil = SW_Filter_None.SW_Filter;
		end
		
		if bSet and bSet.CF and bSet.CF > 1 then
			charFil =  SW_ClassFilters[bSet.CF];
		else
			charFil =  nil;
		end
		
		if inf.varType == "TEXT" then
			-- one single unit
		elseif inf.varType == "TARGETTEXT" then
			
			if not bSet.TV then return; end
			local targetUnitID = SW_StrTable:hasID(bSet.TV);
			if not targetUnitID then return; end
			local tmpUnit;
			
			for k,v in pairs(ds) do
				if type(k) == "number" then
					tmpUnit = v:getTargetUnitBasics(targetUnitID);
				else 
					tmpUnit = nil;
				end
				if tmpUnit then
					-- here the unit v did something to tmpUnit
					-- use v's meta but add the tmpUnit (info what did v unit do to the specified target)
					tmpMeta = self.meta[k];
					
					if tmpMeta and tmpMeta.isPetData then
						-- there is no merging here on a pet level atm
						-- just not important enough atm.
						table.insert(ret.data, tmpUnit);
						ret.meta[index] = tmpMeta;
						index = index + 1;
					else
						table.insert(ret.data, tmpUnit);
						if tmpMeta then
							ret.meta[index] = tmpMeta;
						else
							ret.meta[index] = k;
						end
						index = index + 1;
					end
				end
				
			end
		elseif inf.varType == "TEXTTARGET" then
			-- returns all units ONE unit did something to
			if not bSet.TV then return; end
			local targetUnitID = SW_StrTable:hasID(bSet.TV);
			if not (targetUnitID and ds[targetUnitID])then return; end
			
			local units = ds[targetUnitID]:getTargetBasics(targetUnitID);
			if units then
				for k,v in pairs(units) do
					if type(k) == "number" then
						tmpMeta = self.meta[k];
						table.insert(ret.data, v);
						if tmpMeta then
							ret.meta[index] = tmpMeta;
						else
							ret.meta[index] = k;
						end
						index = index + 1;
					end
				end
			end
		elseif inf.varType == "SELF" then
			-- self
		elseif inf.varType == "PETONLY" then
			
		else
			--vals = inf["f"](bSet["SF"], bSet["CF"], bSet["PF"], bSet);
			--"NONE", "PC", "NPC", "GROUP", "EGROUP"
			if selFil == "GROUP" then
				for k, v in pairs(cg) do
					unitData = ds[v.sID];
					tmpMeta = self.meta[v.sID];
					
					if unitData  and (not charFil or ( tmpMeta and tmpMeta.classE == charFil) )then
						if tmpMeta and tmpMeta.allPets then
							-- this unit has or at least had pets
							index = self:handlePetholder(petFil, unitData, tmpMeta, ret);
						else
							table.insert(ret.data, unitData);
							ret.meta[index] = tmpMeta;
							index = index + 1;
						end
					end
				end
			elseif selFil == "EGROUP" then
				for k,v in pairs(eg) do
					unitData = ds[k];
					tmpMeta = self.meta[k];
					if unitData  and (not charFil or ( tmpMeta and tmpMeta.classE == charFil) )then
						if tmpMeta and tmpMeta.allPets then
							-- this unit has or at least had pets
							index = self:handlePetholder(petFil, unitData, tmpMeta, ret);
						else
							table.insert(ret.data, unitData);
							ret.meta[index] = tmpMeta;
							index = index + 1;
						end
					end
					
				end
			elseif selFil == "PC" then
				for k,v in pairs(ds) do
					if type(k) == "number" then
						tmpMeta = self.meta[k];
						
						if tmpMeta and tmpMeta.type == "PC" and (not charFil or tmpMeta.classE == charFil ) then
							if tmpMeta.allPets then
								-- this unit has or at least had pets
								index = self:handlePetholder(petFil, v, tmpMeta, ret);
							else
								table.insert(ret.data, v);
								ret.meta[index] = tmpMeta;
								index = index + 1;
							end
						end
					end
				end
			elseif selFil == "NPC" then
				for k,v in pairs(ds) do
					tmpMeta = self.meta[k];
					if type(k) == "number" then
						if tmpMeta and tmpMeta.type == "NPC" and (not charFil or tmpMeta.classE == charFil ) then
							if tmpMeta.allPets then
								-- this unit has or at least had pets
								index = self:handlePetholder(petFil, v, tmpMeta, ret);
							else
								table.insert(ret.data, v);
								ret.meta[index] = tmpMeta;
								index = index + 1;
							end
						end
					end
				end
			else
				for k,v in pairs(ds) do
					if type(k) == "number" then
						tmpMeta = self.meta[k];
						if not charFil or ( tmpMeta and tmpMeta.classE == charFil) then
							if tmpMeta and tmpMeta.allPets then
								-- this unit has or at least had pets
								index = self:handlePetholder(petFil, v, tmpMeta, ret);
							elseif tmpMeta and tmpMeta.isPetData then
								-- skip pets
							else
								table.insert(ret.data, v);
								if tmpMeta then
									ret.meta[index] = tmpMeta;
								else
									ret.meta[index] = k;
								end
								index = index + 1;
							end
						end
					end
				end
				
			end
		end
		-- maybe rethink all pet mergin on a view level to avoid some gc,
		-- the pet tables dont tend to be as big though
		--[[ moved to view level
		if petFil.VPR then
			local mergedPet = SW_C_UnitData:new();
			for k, _ in pairs(self.VPR) do
				mergedPet:addUnit(ds[k]);
			end
			if mergedPet:getDmgDone() > 0 then
				table.insert(ret.data, mergedPet);
				ret.meta[index] = self.VPRMeta;
				index = index + 1;
			end
		end
		--]]
		--SW_printStr(table.getn(ret.data));
		return ret, bSet, petFil;
	end,
	handlePetholder = function (self, petFil, unitData, unitMeta, addTo)
		
		local mergedUnit;
		local index = table.getn(addTo.data) + 1;
		local ds = self:getDS();
		
		-- to match old behavoiur inactive would have to add the pet data to the unit data
		-- not going to do that though, in 2.0 the only diff is the prefix
		if petFil.Inactive or petFil.Active then
			table.insert(addTo.data, unitData);
			addTo.meta[index] = unitMeta;
			index = index + 1;
			for k, _ in pairs(unitMeta.allPets) do
				if ds[k] and (not self.VPR[k]) then
					table.insert(addTo.data, ds[k]);
					addTo.meta[index] = self.meta[k];
					self.VPR[k] = true; -- avoid having the same MC'd pet in there for each that MC'd it. kind of an ugly reuse of VPR
					index = index + 1;
				end
			end
		elseif petFil.Current then
			table.insert(addTo.data, unitData);
			addTo.meta[index] = unitMeta;
			index = index + 1;
			if unitMeta.petID then
				-- unit currently has a pet
				if ds[unitMeta.petID] then
					table.insert(addTo.data, ds[unitMeta.petID]);
					addTo.meta[index] = self.meta[unitMeta.petID];
					index = index + 1;
				end
			end
		--[[ GC on this wasn't acceptable merge this data on the view level
		elseif petFil.MM or petFil.MR or petFil.MB then
			-- 2.0 only has compleate merge
			mergedUnit = SW_C_UnitData:new();
			mergedUnit:addUnit(unitData);
						
			for k, _ in pairs(unitMeta.allPets) do
				if ds[k] then
					mergedUnit:addUnit(ds[k]);
				end
			end
			mergedUnit:setTFT(unitData:getTFT());
			table.insert(addTo.data, mergedUnit);
			addTo.meta[index] = unitMeta;
			index = index + 1;
		--]]
		--[[elseif petFil.MM or petFil.MR or petFil.MB or petFil.VPP or petFil.VPR then
			table.insert(addTo.data, unitData);
			addTo.meta[index] = unitMeta;
			index = index + 1;
		 elseif petFil.VPP then -- moved to view level
			
			mergedUnit = SW_C_UnitData:new(); -- view level ?
			for k, _ in pairs(unitMeta.allPets) do
				if ds[k] then
					mergedUnit:addUnit(ds[k]);
				end
			end
			table.insert(addTo.data, unitData);
			addTo.meta[index] = unitMeta;
			index = index + 1;
			
			table.insert(addTo.data, mergedUnit);
			addTo.meta[index] = {isPetData = true, origName = SW_STR_VPP_PREFIX..SW_StrTable:getStr(unitMeta.stringID), classE = unitMeta.classE, VPP = true};
			index = index + 1; --]]
		
		
		--[[elseif petFil.VPR then -- moved to vie level
			table.insert(addTo.data, unitData);
			addTo.meta[index] = unitMeta;
			index = index + 1;
			
			for k, _ in pairs(unitMeta.allPets) do
				if ds[k] then
					self.VPR[k] = true;
				end
			end
			--]]
		else --if petFil.Ignore then
			table.insert(addTo.data, unitData);
			addTo.meta[index] = unitMeta;
			index = index + 1;
		end
		return index;
	end,
	collectGarbage = function (self)
		-- not done but here as stub to remind me
		-- idea is that this will trash any data of units that aren't in the "top 40"
		-- of a basicdata list
		-- (the data you got from running by somebody hitting things you arent really interested in)
		-- dont trash current group, and self data
		
	end,
	raiseMarkerChanged = function(self)
		for i,f in ipairs(self.onMarkersChanged) do
			f();
		end
	end,
	
	deleteSegment = function(self, ID)
		if self:isActiveSegment(ID) then
			return;
		end
		
		if ID < self.settings.startMarker then
			table.remove(self.data,ID)
			self.settings.startMarker = self.settings.startMarker-1;
			self.settings.endMarker = self.settings.endMarker-1;
		elseif ID >= self.settings.startMarker and ID <= self.settings.endMarker then
			table.remove(self.data,ID)
			self.settings.endMarker = self.settings.endMarker-1;
			self:updateSum();
		else
			table.remove(self.data,ID)
		end
		
		self:clearSelected();
		--self:raiseMarkerChanged();
	end,
	-- always keep the most recent segment
	autoDelete = function (self, timeThreshH)
		local n = table.getn(self.data);
		if n == 1 then return; end
		if not timeThreshH then 
			timeThreshH = SW_TL_AUTO_THRESH;
		end
		local secs = timeThreshH * 3600;
		
		for i=n-1, 1, -1 do
			if self.data[i].initTS:elapsed() > secs then
				self:deleteSegment(i);
			end
		end
		self:raiseMarkerChanged();
	end,
	mergeSelected = function (self)
		if self.settings.smallestSelect == self.settings.biggestSelect then
			return;
		end
		
		local lastDS = self.data[self.settings.biggestSelect]
		
		local tmpDS = SW_C_DataSegment:new();
		
		for i,_ in pairs (self.selectedSegments) do
			tmpDS:addDS(self.data[i]);
			self.data[i] = self.trashDummy;
		end
		tmpDS.Name = SW_DS_MERGED;
		
		if self.activeSegment == lastDS then
			-- we merged the active segment
			SW_C_DataCollection.activeSegment = tmpDS;
		end
		-- move from "top" to "bottom" on deleting
		-- to avoid index "shuffle"
		self.data[self.settings.biggestSelect] = tmpDS;
		for i=self.settings.biggestSelect -1, self.settings.smallestSelect, -1 do
			if self.data[i].trashMe then
				table.remove(self.data, i);
			end
			self.selectedSegments[i] = nil;
		end
		self.selectedSegments[self.settings.biggestSelect] = nil;
		self.settings.smallestSelect = 0;
		self.settings.biggestSelect = 0;
		
		-- easiest way to get around a ton of conditions and potential problems
		self:setToActiveOnly();
	end,
	clearSelected = function (self)
		for i,_ in pairs(self.selectedSegments) do
			self.selectedSegments[i] = nil;
		end
		self.settings.smallestSelect = 0;
		self.settings.biggestSelect = 0;
		self:raiseMarkerChanged();
	end,
	-- could use it switching from single to block select
	-- clearing the selection seems more intuitive
	fillSelectedRange = function (self)
		if self.settings.smallestSelect > 0 then
			for i=self.settings.smallestSelect, self.settings.biggestSelect do
				self.selectedSegments[i] = true;
			end
		end
	end,
	amountSelected = function (self)
		if self.settings.smallestSelect == 0 then
			return 0;
		end
		local selCount = 0;
		for i,_ in pairs(self.selectedSegments) do
			selCount = selCount + 1;
		end
		return selCount;
	end,
	useSelected = function (self)
		--if SW_Settings.TL_SingleSelect then return; end
		
		self:setFromTo(self.settings.smallestSelect, self.settings.biggestSelect);
		self:clearSelected();
	end,
	
	-- added the selected "state" of data segments
	-- used when the user plays around with the timeline
	setSelected = function (self, n)
	
		if SW_Settings.TL_SingleSelect then
			if self.selectedSegments[n] then
				self.selectedSegments[n] = nil;
			else
				self.selectedSegments[n] = true;
			end
			self.settings.smallestSelect = 10000;
			self.settings.biggestSelect = 0;
			for i,_ in pairs(self.selectedSegments) do -- not using ipairs on purpouse
				if i < self.settings.smallestSelect then
					self.settings.smallestSelect = i;
				end
				if i > self.settings.biggestSelect then
					self.settings.biggestSelect = i;
				end
			end
			if self.settings.smallestSelect == 10000 then
				self.settings.smallestSelect = 0;
			end
			return;
		end
		-- creating first selection
		if self.settings.smallestSelect == 0 then
			self.settings.smallestSelect = n;
			self.settings.biggestSelect = n;
			self.selectedSegments[n] = true;
			return;
		end
		-- removing last selection
		if self.settings.smallestSelect == self.settings.biggestSelect and n == self.settings.smallestSelect then
			self.settings.smallestSelect = 0;
			self.settings.biggestSelect = 0;
			self.selectedSegments[n] = nil;
			return;
		end
		-- set to one item selected (smallest)
		if n == self.settings.smallestSelect then
			for i=n+1, self.settings.biggestSelect do
				self.selectedSegments[i] = nil;
			end
			self.settings.biggestSelect = n;
			return;
		end
		-- set to one item selected (biggest)
		if n == self.settings.biggestSelect then
			for i= self.settings.smallestSelect,n-1 do
				self.selectedSegments[i] = nil;
			end
			self.settings.smallestSelect = n;
			return;
		end
		-- selecting a smaller segment
		if n < self.settings.smallestSelect then
			for i=n, self.settings.smallestSelect do
				self.selectedSegments[i] = true;
			end
			self.settings.smallestSelect = n;
			return;
		end
		-- selecting a later segment
		if n > self.settings.biggestSelect then
			for i= self.settings.biggestSelect, n do
				self.selectedSegments[i] = true;
			end
			self.settings.biggestSelect = n;
			return;
		end
		-- if we get here its in between
		if n < self.settings.smallestSelect + (self.settings.biggestSelect - self.settings.smallestSelect) / 2 then
			-- move up smallest select
			for i= self.settings.smallestSelect, n-1  do
				self.selectedSegments[i] = nil;
			end
			self.settings.smallestSelect = n;
		else
			-- move down biggest select
			for i=n+1,self.settings.biggestSelect do
				self.selectedSegments[i] = nil;
			end
			self.settings.biggestSelect = n;
		end
	end,
	
	isActiveSegment = function (self, ID) 
		return (ID == table.getn(self.data));
	end,
	--[[
		note to self:
		Never ever modify data returned by this, this may or may not be a "pointer"
		to data currently beeing used 
	--]]
	getDS = function (self)
		if self.settings.activeOnly then
			return self.activeSegment;
		else
			return self.calcedDS;
		end
	end,
	-- dont save this (use SW_C_DataCollection.xxx)
	getSyncDS = function (self)
		if not SW_C_DataCollection.syncDS then
			SW_C_DataCollection.syncDS = SW_C_DataSegment:new();
		end
		if not SW_C_DataCollection.syncCompareDS then
			SW_C_DataCollection.syncCompareDS = SW_C_DataSegment:new();
		end
		return self.syncDS, self.syncCompareDS;
	end,
	setToActiveOnly = function (self)
		local n = table.getn(self.data);
		self.settings.startMarker = n;
		self.settings.endMarker = n;
		SW_C_DataCollection.calcedDS = {};
		self.settings.autoEndMarker = false;
		self.settings.activeOnly = true;
		self:raiseMarkerChanged();
	end,
	-- esentially this doubles memory usage and effort of adding to the data collection
	-- but calcing the sum every time would add a ton to gc
	-- coming back reading this, it only doubels memory usage if we have very few segments
	setToAll = function (self)
		if self.settings.startMarker == 1 and
			self.settings.activeOnly == false and
			self.settings.autoEndMarker == true
		then return; end
		
		self.settings.startMarker = 1;
		self.settings.endMarker = table.getn(self.data);
		self.settings.activeOnly = false;
		self.settings.autoEndMarker = true;
		self:updateSum();
		self:raiseMarkerChanged();
	end,
	
	setFromTo = function (self, startM, endM)
		local n = table.getn(self.data);
		local tmp = endM;
		if startM > endM then
			endM = startM;
			startM = tmp;
		end
		if startM < 1 then startM = 1; end
		if endM > n then endM = n; end
		
		if startM == self.settings.startMarker and endM == self.settings.endMarker then
			-- nothing to change
			return;
		end
		
		self.settings.autoEndMarker = false;
		self.settings.activeOnly = false;
		if endM == n then
			if startM == n then
				self.settings.activeOnly = true;
			else
				self.settings.autoEndMarker = true;
			end	
		end
		self.settings.startMarker = startM;
		self.settings.endMarker = endM;
		self:updateSum();
		self:raiseMarkerChanged();
	end,
	
	createNewSegment = function (self, sName)
		local n = table.getn(self.data);
		local reactivateTimer = false;
		
		-- check if the active segment is empty, no need to create empty junk
		-- so just update the current empty segment
		if self.activeSegment:isEmpty() then 
			if sName then
				self.data[n].Name = sName;
			end
			self.data[n].initTS:setToNow();
			self:raiseMarkerChanged();
			return;
		end
		
		-- check if we are in a fight
		if SW_RPS.isRunning then
			-- add the current secs to the old data segment
			self:addFightDur(SW_RPS.startTimer:elapsed());
			-- restart the timer
			SW_RPS = SW_C_RPS:new();
			reactivateTimer = true;
		else
			SW_RPS = SW_C_RPS:new();
		end
		
		table.insert(self.data, SW_C_DataSegment:new());
		n = n + 1;
		
		SW_C_DataCollection.activeSegment = self.data[n];
		if sName then
			self.data[n].Name = sName;
		end
		if self.settings.activeOnly then
			self.settings.startMarker = n;
			self.settings.endMarker = n;
		elseif self.settings.autoEndMarker then
			self.settings.endMarker = n;
		end
		if reactivateTimer then
			SW_RPS:validEvent();
		end
		self:raiseMarkerChanged();
	end,
	isInDS = function (self, n)
		if n >= self.settings.startMarker and n<= self.settings.endMarker then
			return true;
		end
		return false;
	end,
	isSelected = function (self, n)
		return self.selectedSegments[n];
	end,
	
	registerMarkersChanged = function(self, func)
		assert(type(func) == "function", "registerMarkersChanged func is not a function");
		table.insert(self.onMarkersChanged, func);
	end,
	--[[ this is pretty bad gc wise if called often
		normally just used if the user plays around with markers or on startup
	--]]
	updateSum = function (self)
		if self.settings.activeOnly then
			SW_C_DataCollection.calcedDS = SW_C_DataCollection.activeSegment
			return;
		end
		
		-- this would also work for activeOnly, for now I want to be explicit though
		if self.settings.startMarker == self.settings.endMarker then
			SW_C_DataCollection.calcedDS = self.data[self.settings.endMarker]; -- nothing to add up it's just one segment to look at
			return;
		end
		
		local tmpDS = SW_C_DataSegment:new();
		for i=self.settings.startMarker, self.settings.endMarker do
			tmpDS:addDS(self.data[i]);
		end
		SW_C_DataCollection.calcedDS = tmpDS;
	end,
	
	--[[
		Used to autocreate a new data segment when zoning
	--]]
	checkZone = function (self, zoneName)
		if self.settings.lastZone ~= zoneName then
			self.settings.lastZone = zoneName;
			self:createNewSegment(string.format(SW_DS_ZONED,zoneName));
		end
	end,
	
	--[[
		Used to autocreate a new data segment when joining&leaving groups/raids
		check the battleground auto raid stuff, might need a flag here aswell
		for the new addon msg and syncing
	--]]
	checkGroup = function (self)
		local changed = false;
		if GetNumRaidMembers() > 0 then
			if not self.settings.isInRaid then
				self.settings.isInRaid = true;
				self.settings.isInGroup = false; -- switch from group to raid
				self:createNewSegment(SW_DS_JOINED_RAID);
				SW_SYNC_TO_USE = "RAID";
				changed = true;
			end
		elseif GetNumPartyMembers() > 0 then
			if not self.settings.isInGroup then
				self.settings.isInRaid = false;
				self.settings.isInGroup = true;
				self:createNewSegment(SW_DS_JOINED_GROUP);
				SW_SYNC_TO_USE = "PARTY";
				changed = true;
			end
		else
			if self.settings.isInRaid then
				self.settings.isInRaid = false;
				--self.settings.isInGroup = false;
				self:createNewSegment(SW_DS_LEFT_RAID);
				SW_SYNC_TO_USE = nil;
				changed = true;
			elseif self.settings.isInGroup then
				--self.settings.isInRaid = false;
				self.settings.isInGroup = false;
				self:createNewSegment(SW_DS_LEFT_GROUP);
				SW_SYNC_TO_USE = nil;
				changed = true;
			end
		end
		if changed then
			SW_SYNC_SESSION = 1;
			if SW_SYNC_DO and SW_SYNC_TO_USE then
				--[[
					moved to initForSync (called from sync handshaking)
				SW_C_DataCollection.syncDS = SW_C_DataSegment:new();
				SW_C_DataCollection.syncCompareDS = SW_C_DataSegment:new();
				--]]
				
				SW_SyncState:reset();
			else
				SW_C_DataCollection.syncDS = nil;
				SW_C_DataCollection.syncCompareDS = nil;
			end
		end
		if SW_SYNC_DO and not SW_SYNC_TO_USE then
			if GetNumRaidMembers() > 0 then
				SW_SYNC_TO_USE = "RAID";
			elseif GetNumPartyMembers() > 0 then
				SW_SYNC_TO_USE = "PARTY";
			end
		end
		if not SW_SYNC_TO_USE then
			SW_BarFrame1_Title_SyncIcon:Hide();
		end
		SW_ToggleRunning(SW_Settings.IsRunning);
	end,
	
	initForSync = function (self, name)
		if name then
			self:createNewSegment(name);
		else
			self:createNewSegment(SW_DS_SYNC_INIT);
		end
		SW_C_DataCollection.syncDS = SW_C_DataSegment:new();
		SW_C_DataCollection.syncCompareDS = SW_C_DataSegment:new();
	end,
}


SW_C_SlidingWindow = {
	new = function (self, o, secs)
		if not  o then
			o = {};
			o.val = 0;
		end
		
		setmetatable(o, self);
		self.__index = self;
		
		o.window = {};
		
		for i=1,secs do
			o.window[i] = 0;
		end
		o.ci = 1;
		o.elapsed = 0;
		o.border = secs;
		o.funcs = {};
		
		return o;
	end,
	
	inc = function(self, val)
		if self.inactive then return; end
		self.window[self.ci] = self.window[self.ci] + val;
		self.recalc = true;
	end,
	
	register = function(self, func)
		assert(type(func) == "function", "SW_C_SlidingWindow:register argument is not a function");
		table.insert(self.funcs, func);
	end,
	update = function (self, elapsed)
		if self.inactive then return; end
		local ni;
		self.elapsed = self.elapsed + elapsed;
		
		if self.elapsed > self.border then
			self.elapsed = self.elapsed - self.border;
		end
		ni = math.floor(self.elapsed) + 1;
		if ni ~= self.ci then
			local nv = self:getValPerSecond();
			for i,f in ipairs(self.funcs) do
				f(nv);
			end
			self.window[ni] = 0;
			self.ci = ni;
			self.recalc = true;
		end
	end,
	
	getValPerSecond = function (self)
		if self.recalc then
			self.val = 0;
			for i=1, self.border do
				self.val = self.val + self.window[i];
			end
			self.val = math.floor(((self.val / self.border) * 10 + 0.5) / 10 );
			self.recalc = false;
		end
		return self.val;
	end,
}

SW_ED = {
	sID = 0,
	tID = 0,
	skillID = 0,
}

--[[
	the basic idea is this:
	First we get the extra attack msg
	then the "low" attack that procced the extra attack
	then all extra attack msgs
	
	through extra testing found that the "POWERGAIN" msg comes in last after all is actually "done"
	maybe could use this as a sort of "stop marker"
	
--]]
SW_ExtraAttackWatch = {};



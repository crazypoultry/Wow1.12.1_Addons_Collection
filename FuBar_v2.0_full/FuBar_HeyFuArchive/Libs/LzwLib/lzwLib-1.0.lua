--[[

* Copyright (c) 2006, Lucas Alonso & Ben Golus
* All rights reserved.
* Redistribution and use in source and binary forms, with or without
* modification, are permitted provided that the following conditions are met:
*
*     * Redistributions of source code must retain the above copyright
*       notice, this list of conditions and the following disclaimer.
*     * Redistributions in binary form must reproduce the above copyright
*       notice, this list of conditions and the following disclaimer in the
*       documentation and/or other materials provided with the distribution.
*     * The names of the authors may not be used to endorse or promote products
*       derived from this software without specific prior written permission.
*
* THIS SOFTWARE IS PROVIDED BY THE AUTHORS ``AS IS'' AND ANY
* EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
* WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
* DISCLAIMED. IN NO EVENT SHALL THE REGENTS AND CONTRIBUTORS BE LIABLE FOR ANY
* DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
* (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
* LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
* ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
* (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
* SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

luke@secretlevel.com
ben@secretlevel.com

]]--

--[[

A simple lua LZW compression library.

----

Syntax:

lzw:compress("string"[,chatsafe][,CompressTable,TableSize]);
returns compressed string

lzw:decompress("string"[,chatsafe][,CompressTable,TableSize]);
returns decompressed string

----

Typical usage:

----

local compressed = lzw:compress("Some text or arbitrary data in a string");
local decompressed = lzw:decompress(compressed);

----

Optimal compression can be achieved by creating code tables for specific input sets. For example:

----

local DecompressTable = {};
local CompressTable = {};
local TableSize;

lzw:begin_analyze();

for all input strings...
	lzw:analyze_string( Str );
...

TableSize = lzw:end_analyze(DecompressTable, CompressTable);

local compressed = lzw:compress("Some data to compress", nil, CompressTable, TableSize);
local decompressed = lzw:decompress(compressed, nil, DecompressTable, TableSize);

----

Note that the decompression table and table size must be stored to be able to decompress data at a later point in time.

----

The resulting compressed string can optionally be output in a chat safe format.

----

local compressed = lzw:compress( Str, true );
local decompressed = lzw:decompress( Str, true );

----

Note that a string that has been compressed using the chat safe flag must be decompressed with the flag or the decompressed
string may become garbled.

]]--

local version = 1;

local lib = {
	version = version;
	RB_TempStream = "";
	WB_TempStream = "";
	WB_Used = 0;
	WB_Curr = 0;
	WB_Max = 8;
	RB_Curr = 0;
	RB_Loaded = 0;
	RB_StreamPos = 0;
	RB_StreamLen = 0;
	RB_ByteTable = {};
	AnalyzeCharacters = {};
};

local function CopyTable(var)
	if ( not var ) then return; end

	if ( type(var) == "table" ) then
		local ret = {};
		for k, v in var do
			ret[k] = CopyTable(v);
		end
		return ret;
	else
		return var;
	end
end

local function GetRequiredBitDepth( TableSize )
	if( TableSize >= 256 ) then
		return 9;
	elseif( TableSize >= 128 ) then
		return 8;
	elseif( TableSize >= 64 ) then
		return 7;
	elseif( TableSize >= 32 ) then
		return 6;
	elseif( TableSize >= 16 ) then
		return 5;
	elseif( TableSize >= 8 ) then
		return 4;
	elseif( TableSize >= 4 ) then
		return 3;
	elseif( TableSize >= 2 ) then
		return 2;
	elseif( TableSize >= 1 ) then
		return 1;
	end
end

function lib:init()
	if ( self.DefaultLZWTableSize ) then return; end

	local QMask = bit.lshift( 1, 30 )-1;
	local MaxSize = bit.lshift( 1, 30 );
	local MaxMask = MaxSize-1;

	self.MaskTable = {};
	for i=0, 30 do
		local TempMask = bit.band( bit.lshift( MaxSize-1, i ), QMask );
		self.MaskTable[i] = bit.band( bit.bnot(TempMask), MaxMask );
	end

	self.DefaultLZWTable = {};
	self.DefaultLZWReverseTable = {};
	self.DefaultLZWTableSize = 1;
	-- Initialize the reverse code table (Code Index -> String array).
	for i=1, 255 do
		tinsert( self.DefaultLZWReverseTable, string.char(i));
		self.DefaultLZWTableSize = self.DefaultLZWTableSize + 1;
	end

	-- Our initial code table is the ASCII character set, codes 1-255.
	-- String -> Code Index
	for i, char in ipairs(self.DefaultLZWReverseTable) do
		self.DefaultLZWTable[char] = i;
	end
end

function lib:readbits( Bits, Stream )
	if( Stream ) then
		self.RB_TempStream = Stream;
		self.RB_StreamPos = 1;
		self.RB_StreamLen = string.len(Stream);
		self.RB_Curr = 0;
		self.RB_Loaded = 0;
		for i=1, self.RB_StreamLen do
			self.RB_ByteTable[i] = string.byte( string.sub( self.RB_TempStream, i, i) );
		end
	end
	local Val = 0;
	local BitsRead = 0;

	while( BitsRead < Bits ) do
		if( self.RB_Loaded <= 0 ) then
			if( self.RB_StreamPos == self.RB_StreamLen+1 ) then
				return -1;
			end
			self.RB_Curr = self.RB_ByteTable[self.RB_StreamPos];
			self.RB_StreamPos = self.RB_StreamPos + 1;
			self.RB_Loaded = self.WB_Max;
		end

		local Avail = self.RB_Loaded;
		local NumRead = Bits - BitsRead;

		if( NumRead > Avail ) then
			NumRead = Avail;
		end

		local CurrMask = bit.band( self.RB_Curr, self.MaskTable[NumRead] );
		if( BitsRead > 0 ) then
			CurrMask = bit.lshift( CurrMask, BitsRead );
		end
		Val = bit.bor( Val, CurrMask );

		self.RB_Loaded = self.RB_Loaded - NumRead;
		BitsRead = BitsRead + NumRead;
		if( self.RB_Loaded > 0 ) then
			self.RB_Curr = bit.rshift( self.RB_Curr, NumRead );
		end
	end
	return Val;
end

function lib:writebits( Val, Bits )
	if( Val < 0 ) then
		if( self.WB_Used > 0 ) then
			self.WB_TempStream = self.WB_TempStream .. string.char( self.WB_Curr );
		end
		self.WB_Used = 0;
		self.WB_Curr = 0;
		local StreamQ = self.WB_TempStream;
		self.WB_TempStream = "";
		return( StreamQ );
	end
	while( Bits > 0 ) do
		local NumWrite = self.WB_Max - self.WB_Used;
		if( NumWrite > Bits ) then
			NumWrite = Bits;
		end
		local Over = Bits - NumWrite;
		self.WB_Curr = bit.bor( self.WB_Curr, bit.lshift( bit.band( Val, self.MaskTable[NumWrite] ), self.WB_Used ) );
		self.WB_Used = self.WB_Used + NumWrite;
		if( self.WB_Used == self.WB_Max ) then
			self.WB_TempStream = self.WB_TempStream .. string.char( self.WB_Curr );
			self.WB_Curr = 0;
			self.WB_Used = 0;
		end
		Bits = Over;
		Val = bit.rshift( Val, NumWrite );
	end
end

local tab =  string.char(9);
local newline = string.char(10);
local percent = string.char(37);
local percentpercent = percent..percent;
local pipe = string.char(124);
local special = string.char(255);

local specialtab = special..string.char(1);
local specialnewline = special..string.char(2);
local specialpercent = special..string.char(3);
local specialpipe = special..string.char(4);
local specials = special..string.char(5);
local specialS = special..string.char(6);
local specialspecial = special..special;

function lib:makesafe( Input )
	Input = string.gsub(Input, "s", specials);
	Input = string.gsub(Input, "S", specialS);
	Input = string.gsub(Input, special, specialspecial);
	Input = string.gsub(Input, tab, specialtab);
	Input = string.gsub(Input, newline, specialnewline);
	Input = string.gsub(Input, percentpercent, specialpercent);
	Input = string.gsub(Input, pipe, specialpipe);
	return Input;
end

function lib:unsafe( Input )
	Input = string.gsub(Input, specials, "s");
	Input = string.gsub(Input, specialS, "S");
	Input = string.gsub(Input, specialspecial, special);
	Input = string.gsub(Input, specialtab, tab);
	Input = string.gsub(Input, specialnewline, newline);
	Input = string.gsub(Input, specialpercent, percent);
	Input = string.gsub(Input, specialpipe, pipe);
	return Input;
end

function lib:compress( Input, Safe, LZWTable, LZWTableSize )

	if( not LZWTable ) then
		LZWTable = self.DefaultLZWTable;
		LZWTableSize = self.DefaultLZWTableSize;
	end

	local TableSize = LZWTableSize;
	local CodeTable = CopyTable( LZWTable );
	local StreamPos = 1;
	local StreamLen = string.len(Input);
	local CodeBits = GetRequiredBitDepth( LZWTableSize );
	local MaxCode = 2 ^ CodeBits;

	-- Grab the first character out of Input into Work.
	local Work = string.sub( Input, StreamPos, StreamPos );
	StreamPos = StreamPos + 1;

	-- Compress the input string.
	while( StreamPos <= StreamLen ) do
		-- Chop next character off input.
		local Char = string.sub( Input, StreamPos, StreamPos );
		StreamPos = StreamPos + 1;
		-- Lookup string in the code table.
		if( CodeTable[Work..Char] ) then
			-- If it's in the code table, do nothing.
			Work = Work .. Char;
		else
			if( TableSize == MaxCode ) then
				CodeBits = CodeBits + 1;
				MaxCode = MaxCode * 2;
			end
			-- If the string is NOT in the code table, output the previous
			-- string, which WAS in the code table (see above).
			self:writebits( CodeTable[Work], CodeBits );

			-- Add this new string to the code table.
			CodeTable[Work..Char] = TableSize;
			TableSize = TableSize + 1;

			-- Reset and start again.
			Work = Char;
		end
	end

	-- Ran out of new characters, so just output whatever we had at the end.
	self:writebits( CodeTable[Work], CodeBits );

	-- Finally get result stream.
	if ( Safe ) then
		-- Format safe for sending over chat
		return self:makesafe(self:writebits( -1 ));
	else
		return self:writebits( -1 );
	end
end

function lib:decompress( Input, Safe, LZWReverseTable, LZWTableSize )

	if ( Safe ) then
		-- Decode chat safe string
		Input = self:unsafe(Input);
	end

	if( not LZWReverseTable ) then
		LZWReverseTable = self.DefaultLZWReverseTable;
		LZWTableSize = self.DefaultLZWTableSize;
	end

	local Table = CopyTable( LZWReverseTable );
	local TableSize = LZWTableSize;
	local CodeBits = GetRequiredBitDepth( TableSize );
	local MaxCode = 2 ^ CodeBits;

	if( TableSize == MaxCode ) then
		CodeBits = CodeBits + 1;
		MaxCode = MaxCode * 2;
	end

	-- Grab first code.
	local LastCode = self:readbits( CodeBits, Input );

	local Code = 0;
	-- Result string, starts out with a simple ascii character from the first code.
	local Result = Table[LastCode];
	local LastChar = Result;

	Code = self:readbits( CodeBits );

	while( Code > 0 ) do
		local CodeString;
		if( Table[Code] ) then
			CodeString = Table[Code];
		else
			CodeString = Table[LastCode] .. LastChar;
		end

		Result = Result .. CodeString;
		LastChar = string.sub( CodeString, 1, 1 );

		-- Create a new code based on the string from the last code, and the first character of this one.
		Table[TableSize] = Table[LastCode] .. LastChar;
		TableSize = TableSize + 1;

		if( TableSize+1 == MaxCode ) then
			CodeBits = CodeBits + 1;
			MaxCode = MaxCode * 2;
		end

		LastCode = Code;

		Code = self:readbits( CodeBits );
	end
	return Result;
end

function lib:begin_analyze()
	self.AnalyzeCharacters = {};
end

function lib:end_analyze( OutTable ,OutReverseTable )
	local OutTableSize = 1;
	OutTable[0] = nil;
	for k, v in self.AnalyzeCharacters do
		OutReverseTable[k] = OutTableSize;
		OutTableSize = OutTableSize + 1;
	end

	for k, v in OutReverseTable do
		OutTable[v] = k;
	end
	self.AnalyzeCharacters = {};
	return OutTableSize;
end

function lib:analyze_string( String )
	local ClearLen = string.len( String );
	for i=1, ClearLen do
		local c = string.sub( String, i, i );
		self.AnalyzeCharacters[c] = 1;
	end
end

if ( not lzw or lzw.version < lzw.version ) then
	lzw = lib;
	lib:init();
end

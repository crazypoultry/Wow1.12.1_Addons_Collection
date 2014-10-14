----------------------------------------------------------------------------------
--
-- GuildAdsCodecs.lua
--
-- Author: Zarkan, Fkaï of European Ner'zhul (Horde)
-- URL : http://guildads.sourceforge.net
-- Email : guildads@gmail.com
-- Licence: GPL version 2 (General Public License)
----------------------------------------------------------------------------------

GuildAdsCodecs = {}

-------------------------------------------
GuildAdsCodec = {};

function GuildAdsCodec:new(o, id, version)
	o = o or {};
	o.version = version;
	self.__index = self;
	setmetatable(o, self);
	if GuildAdsCodecs[id] then
		if tonumber(version or 0)>GuildAdsCodecs[id].version then
			GuildAdsCodecs[id] = o;
		end
	else
		GuildAdsCodecs[id] = o;
	end
	return o;
end

function GuildAdsCodec.encode(o)
	error("call to an undefined codec", 2);
end;

function GuildAdsCodec.decode(s)
	error("call to an undefined codec", 2);
end;

-------------------------------------------
GuildAdsCodecRaw = GuildAdsCodec:new({}, "Raw", 1);

function GuildAdsCodecRaw.encode(obj)
	return obj;
end

function GuildAdsCodecRaw.decode(obj)
	return obj;
end

-------------------------------------------
GuildAdsCodecTable = GuildAdsCodec:new({}, "Table", 1);

function GuildAdsCodecTable:new(o, id, version)
	local codec = GuildAdsCodec.new(self, o, id, version);
	
	codec.t = {};
	table.setn(codec.t, table.getn(codec.schema));
	
	codec.encode = function(o)
		local t = codec.t;
		local l;
		for i, d in ipairs(codec.schema) do
			t[i] = GuildAdsCodecs[d.codec].encode(o[d.key]);
			if t[i] ~= "" then
				l = i;
			end
		end
		if l then
			return table.concat(t, "/", 1, l);
		else
			return "";
		end
	end
	
	codec.decode = function(o)
		local i=1;
		local t;
		
		o = o.."/";
		for str in string.gfind(o, "([^\/]*)/") do
			t = t or {};
			local d = codec.schema[i];
			if d then
				t[d.key] = GuildAdsCodecs[d.codec].decode(str);
			end
			
			i = i + 1;
		end
		
		return t;
	end
	
	return codec;
end

-------------------------------------------
GuildAdsCodecGeneric = GuildAdsCodec:new({}, "Generic", 1);

function GuildAdsCodecGeneric.encode(obj)
	if obj == nil then 
		return "";
	elseif ( type(obj) == "string" ) then
		return "s"..GuildAdsCodecString.encode(str);
	elseif ( type(obj) == "number" ) then
		return "n"..obj;
	elseif ( type(obj) == "boolean" ) then
		if (value) then
			return "1";
		else
			return "0";
		end
	elseif ( type(obj) == "function" ) then
		return ""; -- nil
	elseif ( type(obj) == "table" ) then
		return ""; -- nil
	end
	return "";
end

function GuildAdsCodecGeneric.decode(str)
	if (str == "") then
		return nil;
	else
		typeString = string.sub(str, 0, 1);
		valueString = string.sub(str, 2);
		if (typeString == "s") then
			return GuildAdsCodecString.decode(str);
		elseif (typeString == "n") then
			return tonumber(valueString);
		elseif (typeString == "1") then
			return true;
		elseif (typeString == "0") then
			return false;
		else
			GuildAds_ChatDebug(GA_DEBUG_PROTOCOL,"GuildAds_Unserialize: Type non reconnu:"..str);
			return nil;
		end
	end
end

-------------------------------------------
GuildAdsCodecInteger = GuildAdsCodec:new({}, "Integer", 1);

function GuildAdsCodecInteger.encode(obj)
	if obj then
		return tostring(obj)
	end
	return "";
end

function GuildAdsCodecInteger.decode(str)
	if str then
		return tonumber(str);
	end
end

-------------------------------------------
-- BigInteger : convert integer to base 64
GuildAdsCodecBigInteger = GuildAdsCodec:new({}, "BigInteger", 1);

GuildAdsCodecBigInteger.e = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ+-";
GuildAdsCodecBigInteger.d = {};

for i=1, string.len(GuildAdsCodecBigInteger.e), 1 do
	GuildAdsCodecBigInteger.d[string.byte(GuildAdsCodecBigInteger.e, i )] = i-1;
end

function GuildAdsCodecBigInteger.encode(obj)
	if obj then
		value = "";
		while (obj ~= 0) do
			value = string.char(string.byte(GuildAdsCodecBigInteger.e, bit.band(obj, 63)+1 ))..value;
			obj = bit.rshift(obj, 6);
		end
		if value=="" then
			return "0"
		else
			return value;
		end
	end
	return "";
end

function GuildAdsCodecBigInteger.decode(str)
	if str == "" then
		return nil;
	else
		number = 0;
		for i=1, string.len(str),1  do
			number = bit.lshift(number, 6) + GuildAdsCodecBigInteger.d[string.byte(str, i)];
		end
		return number;
	end
end

-------------------------------------------
GuildAdsCodecString = GuildAdsCodec:new({}, "String", 1);

GuildAdsCodecString.SpecialChars = "|>/\31\n";

GuildAdsCodecString.SpecialCharMap =
{
	b = "|",		-- item link
	gt = ">",		-- separator for serialized command
	s = "/",		-- separator for serialized table
	ei = "\31",		-- \31 for nil value
	n = "\n",		-- \n forbidden in chat
};

function GuildAdsCodecString.encode(pString)
	if pString then
		return string.gsub(
						pString,
						"(["..GuildAdsCodecString.SpecialChars.."])",
						function (pField)
							for vName, vChar in GuildAdsCodecString.SpecialCharMap do
								if vChar == pField then
									return "&"..vName..";";
								end
							end
							
							return "";
						end);
	end
	return "\31";
end

function GuildAdsCodecString.decode(pString)
	if pString ~= "\31" then
		return string.gsub(
						pString,
						"&(%w+);", 
						function (pField)
							local	vChar = GuildAdsCodecString.SpecialCharMap[pField];
							
							if vChar ~= nil then
								return vChar;
							else
								return pField;
							end
						end);
	end
end

-------------------------------------------
GuildAdsCodecTexture = GuildAdsCodec:new({}, "Texture", 1);

function GuildAdsCodecTexture.encode(str)
	if obj == nil then
		return "";
	else
		return string.gsub(obj, "Interface\\Icons\\", "\@");
	end
end

function GuildAdsCodecTexture.decode(str)
	if str == "" then
		return nil;
	else
		return string.gsub(str, "\@", "Interface\\Icons\\");
	end
end

-------------------------------------------
GuildAdsCodecItemRef = GuildAdsCodec:new({}, "ItemRef", 1);

function GuildAdsCodecItemRef.encode(obj)
	if obj then
		--[[ TODO 
			- nombre en base 64
			- @ 	pour 	item:
			- ?? 	pour 	enchant:
			- *		pour	:0:0:0 
		]]
		return string.gsub(string.gsub(obj, "item\:", "\@"), ":0:0:0", "\*");
	end
	return "";
end

function GuildAdsCodecItemRef.decode(str)
	if str == "" then
		return nil;
	else
		return string.gsub(string.gsub(str, "\@", "item\:"), "\*", ":0:0:0");
	end
end

-------------------------------------------
GuildAdsCodecColor = GuildAdsCodec:new({}, "Color", 1);

GuildAdsCodecColor.SerializeColorData = {
	["ffa335ee"]="E";
	["ff0070dd"]="R";
	["ff1eff00"]="U";
	["ffffffff"]="C";
	["ff9d9d9d"]="P";
};

GuildAdsCodecColor.UnserializeColorData = {
	["E"]="ffa335ee";
	["R"]="ff0070dd";
	["U"]="ff1eff00";
	["C"]="ffffffff";
	["P"]="ff9d9d9d";
};

GuildAdsCodecColor.ColorMetaTable = {
	__index = function(t, i)
		return i;
	end;
};
setmetatable(GuildAdsCodecColor.SerializeColorData, GuildAdsCodecColor.ColorMetaTable);
setmetatable(GuildAdsCodecColor.UnserializeColorData, GuildAdsCodecColor.ColorMetaTable);

function GuildAdsCodecColor.encode(obj)
	if obj then
		return GuildAdsCodecColor.SerializeColorData[obj];
	end
	return "";
end

function GuildAdsCodecColor.decode(str)
	if str then
		return GuildAdsCodecColor.UnserializeColorData[str];
	end
end

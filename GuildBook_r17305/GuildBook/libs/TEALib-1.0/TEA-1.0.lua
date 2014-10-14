
--[[
Name: TEA-1.0
Revision: $Rev: 15095 $
Author(s): Usz
SVN: http://svn.wowace.com/root/trunk/TEALib/TEA-1.0
Description: Tiny Encryption Algorythm implementation
Dependencies: AceLibrary, MD5Lib
]]

local major, minor = "TEA-1.0", "$Revision: 15095 $"

if not AceLibrary then error(major .. " requires AceLibrary.") end
if not AceLibrary:IsNewVersion(major, minor) then return end

if not AceLibrary:HasInstance("MD5-1.0") then error(major .. " requires MD5-1.0") end

local md5 = AceLibrary("MD5-1.0")

local lib = {}

local function StringToIntArray(text)
	local array = {}

	for i = 1, string.len(text), 4 do
		local acc = 0

		if (string.len(text) >= i + 3) then acc = acc + string.byte(text, i + 3) end
		if (string.len(text) >= i + 2) then acc = acc + string.byte(text, i + 2) * 256 end
		if (string.len(text) >= i + 1) then acc = acc + string.byte(text, i + 1) * 65536 end
		if (string.len(text) >= i + 0) then acc = acc + string.byte(text, i + 0) * 16777216 end

		table.insert(array, acc)
	end

	if (bit.mod(table.getn(array), 2) == 1) then
		table.insert(array, 0)
	end

	return array
end

local function IntArrayToString(array)
	local ret = ""

	for i = 1, table.getn(array) do
		for j = 3, 0, -1 do
			local b = bit.band(bit.rshift(array[i], j * 8), 255)

			if (b == 0) then
				break
			end

			ret = ret .. string.char(b)
		end
	end

	return ret
end

function lib:GenerateKey(key)
	return md5:MD5AsTable(key)
end

function lib:Encrypt(text, key)
	local a, b, c, d = key[1], key[2], key[3], key[4]
	local ia = StringToIntArray(text)

	local maxint = tonumber('ffffffff', 16)
	local delta = 2654435769
	local oa = {}

	for i = 1, table.getn(ia), 2 do
		local y, z = ia[i + 0], ia[i + 1]
		local sum, n = 0, 32

		while (n > 0) do
			sum = bit.band(sum + delta, maxint)
			y = bit.band(y + bit.bxor(bit.lshift(z, 4) + a, z + sum, bit.rshift(z, 5) + b), maxint)
			z = bit.band(z + bit.bxor(bit.lshift(y, 4) + c, y + sum, bit.rshift(y, 5) + d), maxint)
			n = n - 1
		end

		table.insert(oa, y)
		table.insert(oa, z)
	end

	return oa
end

function lib:Decrypt(ia, key)
	local a, b, c, d = key[1], key[2], key[3], key[4]

	local maxint = tonumber('ffffffff', 16)
	local delta = 2654435769
	local oa = {}

	for i = 1, table.getn(ia), 2 do
		local y, z = ia[i + 0], ia[i + 1]
		local sum, n = 3337565984, 32

		while (n > 0) do
			z = bit.band(z - bit.bxor(bit.lshift(y, 4) + c, y + sum, bit.rshift(y, 5) + d), maxint)
			y = bit.band(y - bit.bxor(bit.lshift(z, 4) + a, z + sum, bit.rshift(z, 5) + b), maxint)
			sum = bit.band(sum - delta, maxint)
			n = n - 1
		end

		table.insert(oa, y)
		table.insert(oa, z)
	end

	return IntArrayToString(oa)
end

do
	local s0 = 'message digest'
	local s1 = 'abcdefghijklmnopqrstuvwxyz'
	local s2 = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'
	local s3 = '12345678901234567890123456789012345678901234567890123456789012345678901234567890'

	local k0 = lib:GenerateKey(s0)
	local k1 = lib:GenerateKey(s1)
	local k2 = lib:GenerateKey(s2)
	local k3 = lib:GenerateKey(s3)

	assert(lib:Decrypt(lib:Encrypt(s0, k3), k3) == s0)
	assert(lib:Decrypt(lib:Encrypt(s1, k2), k2) == s1)
	assert(lib:Decrypt(lib:Encrypt(s2, k1), k1) == s2)
	assert(lib:Decrypt(lib:Encrypt(s3, k0), k0) == s3)
end

AceLibrary:Register(lib, major, minor)

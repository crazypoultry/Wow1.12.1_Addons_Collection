--[[
	linkerator.lua
		Linkerator functionality for adapted for Ludwig
		This version differs slightly from the normal linkerator in that Ludwig will give the best match if an exact one cannot be found.
--]]

local function LinkifyName(head, text, tail)
	if not(tonumber(text) or head == "|h" or tail == "|h") then
		local list = Ludwig_GetItemsNamedLike(text)
		if list and list[1] then 
			return Ludwig_GetHyperLink(list[1])
		end
	end
	return head .. "[" .. text .. "]" .. tail
end

local function ParseChatMessage(text)
	return string.gsub(text, "([|]?[h]?)%[(.-)%]([|]?[h]?)", LinkifyName)
end

-- Hooks
local Orig_ChatEdit_OnTextChanged = ChatEdit_OnTextChanged;
ChatEdit_OnTextChanged = function()
    local text = this:GetText()
	if not(text == "" or string.sub(text, 1, 1) == "/") then
	    text = ParseChatMessage(text)
		this:SetText(text)
	end
	Orig_ChatEdit_OnTextChanged(this)
end
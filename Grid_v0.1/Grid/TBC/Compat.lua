-- fake frame:GetAttribute and frame:SetAttribute
--

-- don't do this if we're actually running WoW 2.0
if not string.find(GetBuildInfo(), "^2%.") then
	local orig_Frame_meta = __framescript_meta.__index

	local attributeCache = {}
	local onAttributeChangedScript = {}

	local function Frame_GetAttribute(frame, name)
		return attributeCache[frame][name]
	end

	local function Frame_SetAttribute(frame, name, value)
		if not attributeCache[frame] then
			attributeCache[frame] = {}
		end

		attributeCache[frame][name] = value
		
		local OnAttributeChanged = frame:GetScript("OnAttributeChanged")
		if OnAttributeChanged then
			OnAttributeChanged(frame, name, value)
		end
	end

	local function Frame_AllowAttributeChanges(frame)
	end

	local function Frame_GetScript(frame, handler)
		if handler == "OnAttributeChanged" then
			return onAttributeChangedScript[frame]
		else
			return orig_Frame_meta(frame, "GetScript")(frame, handler)
		end
	end

	local function Frame_SetScript(frame, handler, script)
		if handler == "OnAttributeChanged" then
			onAttributeChangedScript[frame] = script
		else
			return orig_Frame_meta(frame, "SetScript")(frame, handler, script)
		end
	end

	local function Frame_RegisterEvent(frame, event)
		if event == "PLAYER_FOCUS_CHANGED" then
			return
		else
			return orig_Frame_meta(frame, "RegisterEvent")(frame, event)
		end
	end

	__framescript_meta.__index = function (t, k)
		if k == "GetAttribute" then
			return Frame_GetAttribute
		elseif k == "SetAttribute" then
			return Frame_SetAttribute
		elseif k == "GetScript" then
			return Frame_GetScript
		elseif k == "SetScript" then
			return Frame_SetScript
		elseif k == "RegisterEvent" then
			return Frame_RegisterEvent
		elseif k == "AllowAttributeChanges" then
			return Frame_AllowAttributeChanges
		else
			return orig_Frame_meta(t, k)
		end
	end

	function select (index, ...)
		local tbl = arg
		if type(arg[1]) == "table" and arg[2] == nil then
			tbl = arg[1]
		end
		if index == "#" then
			return tbl and table.getn(tbl) or 0
		else
			return tbl and tbl[index]
		end
	end

	function strsplit (sep, str)
		local result = {}
		for w in string.gfind(str, "([^"..sep.."]+)"..sep.."?") do
			table.insert(result, w)
		end
		return unpack(result)
	end

end

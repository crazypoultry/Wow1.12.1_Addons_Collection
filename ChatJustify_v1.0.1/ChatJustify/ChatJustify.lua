local ChatOptions = {
	desc = "Addon to change chat justification",
	name = "ChatJustify",
	type = "group",
	args = {
		Frame1 = {
			name = "ChatFrame1",
	    		type = "toggle",
	    		desc = "Justify ChatFrame1",
	    		get = function()
	        		return ChatJustify:ReadSetting(1)
	    		end,
	    		set = function(v)
	        		ChatJustify:ToggleSetting(1,v)
	    		end,
	    		map = { [false] = "Disabled", [true] = "Enabled" }
		},
		Frame2 = {
			name = "ChatFrame2",
	    		type = "toggle",
	    		desc = "Justify ChatFrame2",
	    		get = function()
	        		return ChatJustify:ReadSetting(2)
	    		end,
	    		set = function(v)
	        		ChatJustify:ToggleSetting(2,v)
	    		end,
	    		map = { [false] = "Disabled", [true] = "Enabled" }
		},
		Frame3 = {
			name = "ChatFrame3",
	    		type = "toggle",
	    		desc = "Justify ChatFrame3",
	    		get = function()
	        		return ChatJustify:ReadSetting(3)
	    		end,
	    		set = function(v)
	        		ChatJustify:ToggleSetting(3,v)
	    		end,
	    		map = { [false] = "Disabled", [true] = "Enabled" }
		},
		Frame4 = {
			name = "ChatFrame4",
	    		type = "toggle",
	    		desc = "Justify ChatFrame4",
	    		get = function()
	        		return ChatJustify:ReadSetting(4)
	    		end,
	    		set = function(v)
	        		ChatJustify:ToggleSetting(4,v)
	    		end,
	    		map = { [false] = "Disabled", [true] = "Enabled" }
		},
		Frame5 = {
			name = "ChatFrame5",
	    		type = "toggle",
	    		desc = "Justify ChatFrame5",
	    		get = function()
	        		return ChatJustify:ReadSetting(5)
	    		end,
	    		set = function(v)
	        		ChatJustify:ToggleSetting(5,v)
	    		end,
	    		map = { [false] = "Disabled", [true] = "Enabled" }
		},
		Frame6 = {
			name = "ChatFrame6",
	    		type = "toggle",
	    		desc = "Justify ChatFrame6",
	    		get = function()
	        		return ChatJustify:ReadSetting(6)
	    		end,
	    		set = function(v)
	        		ChatJustify:ToggleSetting(6,v)
	    		end,
	    		map = { [false] = "Disabled", [true] = "Enabled" }
		},
		Frame7 = {
			name = "ChatFrame7",
	    		type = "toggle",
	    		desc = "Justify ChatFrame7",
	    		get = function()
	        		return ChatJustify:ReadSetting(7)
	    		end,
	    		set = function(v)
	        		ChatJustify:ToggleSetting(7,v)
	    		end,
	    		map = { [false] = "Disabled", [true] = "Enabled" }
		}

	}
}

ChatJustify = AceLibrary("AceAddon-2.0"):new("AceDB-2.0", "AceConsole-2.0")
ChatJustify:RegisterChatCommand({"/ChatJustify", "/CaJU" }, ChatOptions)
ChatJustify:RegisterDB("ChatJustifyDB", "ChatJustifyDBPerChar")

ChatJustify:RegisterDefaults('realm', {
    chars = {
        ['*'] = {}
    }
})

function ChatJustify:OnEnable()
	self:Justify()
end

function ChatJustify:Justify()
	for FrameN,Value in self.db.realm.chars[UnitName("player")] do
		local TFrame = getglobal("ChatFrame"..FrameN)
		if(Value and TFrame) then
			TFrame:SetJustifyH("RIGHT")
		else
			TFrame:SetJustifyH("LEFT")
		end
	end

end

function ChatJustify:ToggleSetting(FrameN,Value)
 	self.db.realm.chars[UnitName("player")][FrameN] = Value
 	self:Justify()
end

function ChatJustify:ReadSetting(FrameN)
	return self.db.realm.chars[UnitName("player")][FrameN]
end
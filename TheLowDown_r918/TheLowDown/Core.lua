

TheLowDown = AceAddon:new({
	name          = "TheLowDown",
	description   = "Never forget to scroll a chatframe to the bottom again!",
	version       = tonumber(string.sub("$Revision: 918 $", 12, -3)),
	releaseDate   = string.sub("$Date: 2006-04-26 02:56:57 -0500 (Wed, 26 Apr 2006) $", 8, 17),
	aceCompatible = 102,
	author        = "Tekkub Stoutwrithe",
	email 		    = "tekkub@gmail.com",
	website       = "http://tekkub.wowinterface.com",
	cmd           = AceChatCmd:new({}, {}),
})


local metro = Metrognome:GetInstance("1")
local chatframes = {}
local delay = 20  -- Change this value if you want a different delay between your last scroll
	                -- and the time the frame resets.  This value is in seconds.

function TheLowDown:Initialize()
	local g = getfenv(0)
	local funcs = {"ScrollUp", "ScrollDown", "ScrollToTop", "PageUp", "PageDown"}

	for i=1,7 do
		local n = "ChatFrame"..i
		chatframes[n] = g[n]
		metro:Register(n.."DownTimeout", self.ResetFrame, delay, n)
		metro:Register(n.."DownTick", self.ScrollOnce, 0.1, n)
		for _,func in pairs(funcs) do
			local func = func
			local frame = g[n]
			local f = function()
				metro:Stop(n.."DownTick")
				metro:Start(n.."DownTimeout")
				self.Hooks[frame][func].orig(frame)
			end
			self:Hook(frame, func, f)
		end
	end
end


function TheLowDown:Disable()
	for i=1,7 do
		local name = "ChatFrame"..i
		metro:Stop(name.."DownTimeout")
		metro:Stop(name.."DownTick")
	end
end


function TheLowDown.ResetFrame(name)
	local frame = chatframes[name]
	metro:Stop(name.."DownTimeout")
	metro:Start(name.."DownTick")
end


function TheLowDown.ScrollOnce(name)
	local frame = chatframes[name]
	if frame:AtBottom() then metro:Stop(name.."DownTick")
	else TheLowDown.Hooks[frame].ScrollDown.orig(frame) end
end


--------------------------------
--      Load this bitch!      --
--------------------------------
TheLowDown:RegisterForLoad()

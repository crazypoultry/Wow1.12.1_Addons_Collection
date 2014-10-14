EnhancedLootFrames	= AceAddonClass:new({
	name			= "EnhancedLootFrames",
	description		= "Enhances the grouploot-frames.",
	version			= "0.5",
	aceCompatible	= "103",
	author			= "Silverwind",
	website			= "http://silverwind.wowinterface.com/",
	cmd				= AceChatCmdClass:new({"/elf","/enhancedlootframes"},
		{
			{
				option = "lock", desc = "Lock the frames", method  = "LockFrames"
			},
			{
				option = "unlock", desc = "Unlock the frames", method  = "UnlockFrames"
			},
		}
	)
})

local numFrames = 4
local idTable = {}

function EnhancedLootFrames:Enable()
	self:Hook("GroupLootFrame_OpenNewFrame","OpenNewFrame")
	self:RegisterEvent("CHAT_MSG_LOOT")
	for i = 1, numFrames do getglobal("EnhancedLootFrames_MoverFrame"..i.."Name"):SetText("Drag Frame"..i) end
end

function EnhancedLootFrames:CHAT_MSG_LOOT()
	local itemName, choice = self:ParseChat(arg1)
	if itemName and choice and idTable[itemName] then 
		local i = 1
		while getglobal("EnhancedLootFrames_GroupLootFrame"..i) do
			if getglobal("EnhancedLootFrames_GroupLootFrame"..i).rollID == idTable[itemName] then
				if choice == 1 then
					local s = getglobal("EnhancedLootFrames_GroupLootFrame"..i.."Need"):GetText()
					getglobal("EnhancedLootFrames_GroupLootFrame"..i.."Need"):SetText("Need: "..tonumber(string.sub(s,7, string.len(s))) +1)
					return
				elseif choice == 2 then
					local s = getglobal("EnhancedLootFrames_GroupLootFrame"..i.."Greed"):GetText()
					getglobal("EnhancedLootFrames_GroupLootFrame"..i.."Greed"):SetText("Greed: "..tonumber(string.sub(s,8, string.len(s))) +1)
					return
				elseif choice == 0 then
					local s = getglobal("EnhancedLootFrames_GroupLootFrame"..i.."Pass"):GetText()
					getglobal("EnhancedLootFrames_GroupLootFrame"..i.."Pass"):SetText("Pass: "..tonumber(string.sub(s,7, string.len(s))) +1)
					return
				end
			end
			i = i + 1
		end
	end
end

function EnhancedLootFrames:ParseChat(msg)
	for item, name in string.gfind(msg, "|Hitem:(%d+:%d+:%d+:%d+)|h%[(.-)%]|h") do
		if string.find(msg,"passed on:") then if name then return name, 0 end end
		if string.find(msg,"selected Greed for:") then if name then return name, 2 end end
		if string.find(msg,"selected Need for:") then if name then return name, 1 end end
	end
end

function EnhancedLootFrames:LockFrames()
	for i = 1, numFrames do getglobal("EnhancedLootFrames_MoverFrame"..i):Hide() end
end

function EnhancedLootFrames:UnlockFrames()
	for i = 1, numFrames do getglobal("EnhancedLootFrames_MoverFrame"..i):Show() end
end

function EnhancedLootFrames:OpenNewFrame(id)
	for i=1, numFrames do
		local f = getglobal("EnhancedLootFrames_GroupLootFrame"..i)
		if not f:IsVisible() then
			f.rollID = id
			f:Show()
			return
		end
	end
end

function EnhancedLootFrames:FrameOnShow()
	local texture, name, _, quality = GetLootRollItemInfo(this.rollID)
	if name then idTable[name] = this.rollID end
	getglobal(this:GetName().."IconFrameIcon"):SetTexture(texture)
	getglobal(this:GetName().."Name"):SetText(name)
	getglobal(this:GetName().."Need"):SetText("Need: 0")
	getglobal(this:GetName().."Greed"):SetText("Greed: 0")
	getglobal(this:GetName().."Pass"):SetText("Pass : 0")
	local color = ITEM_QUALITY_COLORS[quality]
	getglobal(this:GetName()):SetBackdropColor(color.r,color.g,color.b,0.7)
	getglobal(this:GetName()):SetBackdropBorderColor(color.r,color.g,color.b, 1)
end

EnhancedLootFrames:RegisterForLoad()
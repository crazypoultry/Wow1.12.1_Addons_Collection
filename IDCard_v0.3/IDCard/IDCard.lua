IDCard = AceAddon:new{
	name = "IDCard",
	description	= "Adds Item Inventory icons next to item links",
	releaseDate = "2006-01-17",
	version = "0.3",
	aceCompatible = "103",
	catagory = "inventory",
	author = "tard",

	button = IDCardIcon,

	cmd = AceChatCmd:new({"/idcard"},{}),
	db = AceDatabase:new("IDCardDB"),
	
	ItemColors = {[0] = "ff9d9d9d","ffffffff","ff1eff00","ff0070dd","ffa335ee","ffff8000","ffe6cc80"},

}

IDCard:RegisterForLoad()

function IDCard:Enable()
	self:Hook(ItemRefTooltip,"SetHyperlink")
end

function IDCard:SetHyperlink(itemID)
	if(not itemID) then return end

	local _,_,_,_,_,_,_,_,texture = GetItemInfo(itemID)
	self.id = itemID
	if(not texture) then
		debugprofilestart()
 		self:HookScript(ItemRefTooltip,"OnSizeChanged","TooltipUpdate")
		
	end

	self.button:SetNormalTexture(texture)
	self.Hooks[ItemRefTooltip].SetHyperlink.orig(ItemRefTooltip,itemID)
end


function IDCard:InsertLink()
	local name,item,quality = GetItemInfo(self.id)
	if not name then return end
	ChatFrameEditBox:Insert("|c"..self.ItemColors[quality].."|H"..item.."|h["..name.."]|h|r")
end

function IDCard:TooltipUpdate()
	local _,_,_,_,_,_,_,_,texture = GetItemInfo(self.id)
 	if(texture) then
	 	self:UnhookScript(this,"OnSizeChanged")
		self:debug(debugprofilestop())
		self.button:SetNormalTexture(texture)
	end
end
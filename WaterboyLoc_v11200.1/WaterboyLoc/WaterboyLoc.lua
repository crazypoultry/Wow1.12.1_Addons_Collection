--[[

	Waterboy 11200.1 20/10/2006

	This is a tool to help mages hand out summoned water/food.

	Left-click the bucket to toggle the window
	Right-click the bucket to pull up options

	In the window:
	Left-click stuff on the left to summon
	Right-click stuff on the left to drink/eat

	Useage:
	Drag (or shift+click) items on the left to the trade slots on the right.
	These will be the food/water that you give when you hit Trade.

	You can also give food/water by right-clicking a friendly player's
	portrait and choosing 'Waterboy'

	Minimized:
	When 'Keep On Screen' is checked, the window will minimize when you
	hit ESC or the bucket.  While minimized, a 'Make' button will
	summon food/water until you have enough to fill the handout.  When
	out of mana, the 'Make' button will drink the best drink you have.

	Macro/slash commands (entirely optional):
	Waterboy_Toggle()			/waterboy			/wb		: Toggles window
	Waterboy_LoadDefaults()		/waterboy reset		/wb reset	: Restores defaults
	Waterboy_Trade()			/waterboy trade		/wb trade	: Gives food/water
	Waterboy_Summon()			/waterboy make		/wb make	: Summons food/water

	If you want to make a Titan or Infobar plugin, Waterboy will attemp to call

		Waterboy_UpdatePlugins(qty,hasempty)

	when it has need to update the information.

	qty = the amount of food/drink ready to serve as seen in minimized view,
	hasempty = true if any stacks are empty, the red background in minimized view
	
	If you display either of those values (or others you grab from Waterboy.TradeList)
	you may want to periodically call Waterboy_FillOrder().  It will scan inventory
	to update them.  It doesn't do it when the window is hidden since there's no
	need.  Waterboy_FillOrder() calls Waterboy_UpdatePlugins() at its end.

	--> changed qty and hasempty to global variables, because of the way titan is updated --Nihihi
		
	Also note: keep in mind BAG_UPDATE happens *A LOT*, so it's best not to react
	to all 200-300 of them when you zone unless you're prepared for the huge
	performance hit.  You're welcome to take this mod's BAG_UPDATE code for your plugin.
	It sets a flag when BAG_UPDATE occurs, and then waits for .75 seconds of no
	BAG_UPDATE events before acting on it. (Waterboy.UpdateTimer if you'd like to
	tweak it and experiment)

]]

-- WaterboyOptions are the only parts saved to SavedVariables
WaterboyOptions = { ["Reset"] =		{ type="Check",  value=false },
					["Auto"] =		{ type="Check",  value=false },
					["IconPos"] =	{ type="Slider", value=256 },
					["Alpha"] =		{ type="Slider", value=100 },
					["Minimized"] = { type="Flag",   value=false },
					["OnScreen"] =	{ type="Check",  value=false },
					["Anchor"] =	{ type="Check",  value=false },
					["ShowIcon"] =	{ type="Check",  value=true },
					["Lock"] =		{ type="Check",  value=false },
					["Scale"] =		{ type="Slider", value=100 },
					["Drink"] =		{ type="Check",  value=false },
					["ManaGem"] =	{ type="Check",  value=false }}
					
WaterboyOptions.TradeSlots = { 0, 0, 0, 0, 0, 0 }


Waterboy = {}
Waterboy.Version = "11200.1"
Waterboy.Loaded = false -- whether we've passed PLAYER_ENTERING_WORLD
Waterboy.TradingNow = false -- whether we've initiated a trade
Waterboy.HitAccept = false -- true if we want to hit accept in a bit
Waterboy.IsTradeOn = false; -- true if there's an open trade window
Waterboy.HitAcceptTime = 0 -- time since an accept was initiated
Waterboy.AcceptTimer = 1.5 -- static time in seconds before accepting the trade
						
Waterboy.TradeList = { {tap=0,bag=0,slot=0,count=0}, {tap=0,bag=0,slot=0,count=0}, {tap=0,bag=0,slot=0,count=0}, 
					   {tap=0,bag=0,slot=0,count=0}, {tap=0,bag=0,slot=0,count=0}, {tap=0,bag=0,slot=0,count=0} }

Waterboy.Choice = 0 -- which item was picked up
Waterboy.Destination = 0 -- which trade slot was item dropped on

Waterboy.BagsUpdating = false -- true if BAG_UPDATE event happened
Waterboy.BagsUpdatedTime = 0 -- time since the last BAG_UPDATE event happened
Waterboy.UpdateTimer = 1 -- static time in seconds after last BAG_UPDATE before reacting, don't change that, lower values might cause bugs
Waterboy.BagList = {} -- holding list for consolidating items in bags
Waterboy.BagListSize = 1 -- size of list + 1
Waterboy.ConsolidateList = {} -- table.insert item names here to put them on consolidate queue


Waterboy.IconTextures = {		["eau1"]="Interface\\AddOns\\WaterboyLoc\\Artwork\\eau1",
						["eau2"]="Interface\\AddOns\\WaterboyLoc\\Artwork\\eau2",
						["eau3"]="Interface\\AddOns\\WaterboyLoc\\Artwork\\eau3",
						["eau4"]="Interface\\AddOns\\WaterboyLoc\\Artwork\\eau4",
						["eau5"]="Interface\\AddOns\\WaterboyLoc\\Artwork\\eau5",
						["eau6"]="Interface\\AddOns\\WaterboyLoc\\Artwork\\eau6",
						["eau7"]="Interface\\AddOns\\WaterboyLoc\\Artwork\\eau7",
						["gem1"]="Interface\\AddOns\\WaterboyLoc\\Artwork\\gem1",
						["gem2"]="Interface\\AddOns\\WaterboyLoc\\Artwork\\gem2",
						["gem3"]="Interface\\AddOns\\WaterboyLoc\\Artwork\\gem3",
						["gem4"]="Interface\\AddOns\\WaterboyLoc\\Artwork\\gem4",
						["pain"]="Interface\\AddOns\\WaterboyLoc\\Artwork\\pain"}

WaterboyDetails = {
		name = "WaterboyLoc",
		description = "Automates summoning and giving water",
		version = Waterboy.Version,
		releaseDate = "October 20, 2006",
		author = "WalleniuM, Nihihi, coded by Gello",
		category = MYADDONS_CATEGORY_CLASS,
		frame = "WaterboyFrame",
		optionsframe = "WaterboyOptFrame"
	};

	
BINDING_HEADER_WATERBOY = "Waterboy"

function Waterboy_OnLoad()
	this:RegisterEvent("PLAYER_ENTERING_WORLD")
	WaterboyBack:SetVertexColor(.15,.3,.5) -- .5 .1 .1 (red)
end

local function Waterboy_IsInConsolidateQueue(arg1)

	local i,found

	for i=1,table.getn(Waterboy.ConsolidateList) do
		if Waterboy.ConsolidateList[i]==arg1 then
			found = true
		end
	end
	return found
end

local function Waterboy_AddToConsolidateQueue(arg1)

	if not Waterboy_IsInConsolidateQueue(arg1) then
		table.insert(Waterboy.ConsolidateList,arg1)
	end
end

function Waterboy_UpdatePlugins(qty,hasempty)
	if Waterboy_UpdateTitan then
		Waterboy_UpdateTitan(qty,hasempty)
	end	
end

function Waterboy_ConsolidateItems(arg1)

	local max,i,j,k,itemlink,itemname,swapped

	if arg1 then -- check if arg1 is already in queue to process
		for i=1,table.getn(Waterboy.ConsolidateList) do
			if Waterboy.ConsolidateList[i] == arg1 then
				j = true
			end
		end
		if not j then -- not in queue, add it
			table.insert(Waterboy.ConsolidateList,arg1)
		end
	end

	arg1 = Waterboy.ConsolidateList[1] -- go back to first in queue

	if arg1 and not CursorHasSpell() and not CursorHasItem() and not CursorHasMoney() then

		Waterboy.BagListSize = 1

		for i=0,4 do
			for j=1,GetContainerNumSlots(i) do
				itemlink = GetContainerItemLink(i,j)
				if itemlink then
					_,_,itemname = string.find(itemlink,"^.*%[(.*)%].*$")
					if itemname==arg1 then
						_,count = GetContainerItemInfo(i,j)
						if not Waterboy.BagList[Waterboy.BagListSize] then
							Waterboy.BagList[Waterboy.BagListSize] = {}
						end
						Waterboy.BagList[Waterboy.BagListSize] = { bag=i, slot=j, count=count }
						Waterboy.BagListSize = Waterboy.BagListSize + 1
					end
				end
			end
		end

		if Waterboy.BagListSize>2 and not CursorHasItem() then
			for i=1,Waterboy.BagListSize-2 do
				if Waterboy.BagList[i].count<20 then
					PickupContainerItem(Waterboy.BagList[i+1].bag,Waterboy.BagList[i+1].slot)
					PickupContainerItem(Waterboy.BagList[i].bag,Waterboy.BagList[i].slot)
					i = Waterboy.BagListSize
					swapped = true
				end
			end
		end

		if not swapped then -- done with this item, remove from queue
			table.remove(Waterboy.ConsolidateList,1)
			Waterboy_ConsolidateItems() -- run through again for next sequence
		end

	end
	
end

local function Waterboy_TakeInventory()

	local i,j,k,itemlink,itemname,total,count
	local start, duration, enable
	for k=1,14 do
		if Waterboy.OnTap[k] then
			total = 0
			for i=0,4 do
				for j=1,GetContainerNumSlots(i) do
					itemlink = GetContainerItemLink(i,j)
					if itemlink then
						_,_,itemname = string.find(itemlink,"^.*%[(.*)%].*$")
						if itemname==Waterboy.OnTap[k].name then
							_,count = GetContainerItemInfo(i,j)
							total = total + count
						end
					end
				end
			end
			Waterboy.OnTap[k].amount = total
			getglobal("WaterboyMenu"..k.."Count"):SetText(total)
		end
	end
	for k=1,4 do
		if Waterboy.GemsStats[k].spellid then
			Waterboy.GemsStats[k].present = false
			Waterboy.GemsStats[k].OnCoolDown = false
			getglobal("WaterboyGem"..k.."CD"):SetText("")
			for i=0,4 do
				for j=1,GetContainerNumSlots(i) do
					itemlink = GetContainerItemLink(i,j)
					if itemlink then
						_,_,itemname = string.find(itemlink,"^.*%[(.*)%].*$")
						if string.lower(itemname)==string.lower(Waterboy.GemsStats[k].name) then
							Waterboy.GemsStats[k].present = true
							start, duration, enable = GetContainerItemCooldown(i,j)
							j=GetContainerNumSlots(i)+1
							i=5
						end
					end
				end
			end
			if Waterboy.GemsStats[k].present == false then
				getglobal("WaterboyGem"..k.."Texture"):SetVertexColor(.3,.3,.3)
			else
				getglobal("WaterboyGem"..k.."Texture"):SetVertexColor(1,1,1)
			end

			if start and duration and  ceil(( start + duration ) - GetTime())>5 then
				getglobal("WaterboyGem"..k.."CD"):SetText( ceil(( start + duration ) - GetTime()))
				Waterboy.GemsStats[k].OnCoolDown = true
			end
		
		end
	end
	Waterboy_SetIconTexture()

end

-- goes through inventory and fills .TradeList with item locations and counts
function Waterboy_FillOrder()

	local qty, qtymax, hasempty = 0,0

	for i=1,6 do -- reset TradeList
		Waterboy.TradeList[i].tap = 0
		Waterboy.TradeList[i].count = 0
	end

-- Senti: Changed function so that a list of the items is created first and then full stacks
-- are preferred
--	for k=1,14 do
--		if Waterboy.OnTap[k] then
--			total = 0
--			for i=0,4 do
--				for j=1,GetContainerNumSlots(i) do
--					itemlink = GetContainerItemLink(i,j)
--					if itemlink then
--						_,_,itemname = string.find(itemlink,"^.*%[(.*)%].*$")
--						if itemname==Waterboy.OnTap[k].name then
--							_,count = GetContainerItemInfo(i,j)
--							total = total + count
--							for l=1,6 do
--								if Waterboy.TradeList[l].tap==0 and WaterboyOptions.TradeSlots[l]==k then
--									Waterboy.TradeList[l].tap = k
--									Waterboy.TradeList[l].bag = i
--									Waterboy.TradeList[l].slot = j
--									Waterboy.TradeList[l].count = count
--									l = 7
--								end
--							end
--						end
--					end
--				end
--			end
--			Waterboy.OnTap[k].amount = total
--		end
--	end

-- BEGIN OF CHANGE BY Senti
  local itemStacks={};
  local itemID,stack,item;
  
	for k=1,14 do
	  itemStacks[k]={};
		if Waterboy.OnTap[k] then
			total = 0
			for i=0,4 do
				for j=1,GetContainerNumSlots(i) do
					itemlink = GetContainerItemLink(i,j)
					if itemlink then
						_,_,itemname = string.find(itemlink,"^.*%[(.*)%].*$")
						if itemname==Waterboy.OnTap[k].name then
							_,count = GetContainerItemInfo(i,j)
	             itemID = string.gsub(itemlink,".*item:(%d+):(%d+):(%d+)", "item:%1:%2:%3");
	            _,_,_,_,_,_,stack = GetItemInfo(itemID);
	            itemStacks[k][table.getn(itemStacks[k])+1]={ Count=count, Stack=stack, BagID=i, Slot=j};
							total = total + count
						end
					end
				end
			end
			Waterboy.OnTap[k].amount = total
		end
		if itemStacks[k] then
		 table.sort(itemStacks[k],WaterBoy_StackSort);
		end
	end

-- Now fill in the trade slots
  for k=1,14 do
	 for l=1,6 do
    if Waterboy.TradeList[l].tap==0 and WaterboyOptions.TradeSlots[l]==k and table.getn(itemStacks[k])>0 then
     item=itemStacks[k][1];
     Waterboy.TradeList[l].tap = k
		 Waterboy.TradeList[l].bag = item.BagID;
		 Waterboy.TradeList[l].slot = item.Slot
		 Waterboy.TradeList[l].count = item.Count;
		 table.remove(itemStacks[k],1);
	  end
	 end
  end
-- END OF CHANGE BY Senti

	for i=1,6 do
		if Waterboy.TradeList[i].tap>0 then
			getglobal("WaterboySlot"..i.."Count"):SetText(Waterboy.TradeList[i].count)
			getglobal("WaterboySlot"..i.."Texture"):SetTexture(Waterboy.OnTap[Waterboy.TradeList[i].tap].texture)
			getglobal("WaterboySlot"..i.."Texture"):SetVertexColor(1,1,1)
			qty = qty + Waterboy.TradeList[i].count
			qtymax = qtymax + 20
		elseif WaterboyOptions.TradeSlots[i]==0 then
			getglobal("WaterboySlot"..i.."Count"):SetText(" ")
			getglobal("WaterboySlot"..i.."Texture"):SetTexture("Interface\\AddOns\\WaterboyLoc\\Artwork\\EmptySlot")
			getglobal("WaterboySlot"..i.."Texture"):SetVertexColor(1,1,1)
		elseif WaterboyOptions.TradeSlots[i] and Waterboy.OnTap[WaterboyOptions.TradeSlots[i]] then
			getglobal("WaterboySlot"..i.."Count"):SetText("0")
			getglobal("WaterboySlot"..i.."Texture"):SetTexture(Waterboy.OnTap[WaterboyOptions.TradeSlots[i]].texture)
			getglobal("WaterboySlot"..i.."Texture"):SetVertexColor(1,.5,.5)
			qtymax = qtymax + 20
			hasempty = true
		end
	end

	WaterboyQty:SetText(qty)
	if hasempty and WaterboyOptions.Minimized.value then
		WaterboyBack:SetVertexColor(.5,.1,.1)
	else
		WaterboyBack:SetVertexColor(.15,.3,.5)
	end

	if qty==qtymax or qtymax==0 or not WaterboyOptions.Minimized.value then
		WaterboyGauge:Hide()
	elseif qtymax>0 then
		WaterboyGauge:SetWidth(28-28*(qty/qtymax))
		WaterboyGauge:Show()
	end

	if Waterboy_UpdatePlugins then
	Waterboy_UpdatePlugins(qty,hasempty)
	end

end

function WaterBoy_StackSort(a,b)
 return (a.Count > b.Count);
end

local function Waterboy_StockOnTap()

	local i,spellname,spellrank = 1,"begin"
	local xwater,ywater = 76,-24
	local xfood,yfood = 44,-24
	local xgem,ygem = 12,-24
	local gem = nil
	
	Waterboy.OnTap = {}
	while spellname do
		spellname,spellrank = GetSpellName(i,BOOKTYPE_SPELL)
		if spellname==WB_CONJUREWATER then
			table.insert(Waterboy.OnTap, { rank=spellrank, spellid=i, amount=0, name=Waterboy.WaterStats[spellrank].name,
										   level=Waterboy.WaterStats[spellrank].level, mana=Waterboy.WaterStats[spellrank].mana,
										   texture=GetSpellTexture(i,BOOKTYPE_SPELL), type="water", cost=Waterboy.WaterStats[spellrank].cost } )
		elseif spellname==WB_CONJUREFOOD then
			table.insert(Waterboy.OnTap, { rank=spellrank, spellid=i, amount=0, name=Waterboy.FoodStats[spellrank].name,
										   level=Waterboy.FoodStats[spellrank].level, hp=Waterboy.FoodStats[spellrank].hp,
										   texture=GetSpellTexture(i,BOOKTYPE_SPELL), type="food", cost=Waterboy.FoodStats[spellrank].cost } )
		elseif spellname and string.find(spellname,WB_GEM_PATTERN) then
			_,_,gem = string.find(spellname,WB_GEM_PATTERN)
			for j=1,4 do
				if gem == Waterboy.GemsStats[j].name then
					Waterboy.GemsStats[j].spellid = i
					Waterboy.GemsStats[j].texture = GetSpellTexture(i,BOOKTYPE_SPELL)
				end
			end
		end
		i = i + 1
	end
	table.sort(Waterboy.OnTap,function(e1,e2) if e1 and e2 and ( e1.rank > e2.rank ) then return true else return false end end)
	
	if mod(table.getn(Waterboy.OnTap),2) == 1 then
		yfood = yfood-32
	end
	
	for i=1,14 do
		if Waterboy.OnTap[i] then
			getglobal("WaterboyMenu"..i):ClearAllPoints()
			if Waterboy.OnTap[i].type=="water" then
				getglobal("WaterboyMenu"..i):SetPoint("TOPLEFT","WaterboyFrame","TOPLEFT",xwater,ywater)
				ywater = ywater - 32
			else
				getglobal("WaterboyMenu"..i):SetPoint("TOPLEFT","WaterboyFrame","TOPLEFT",xfood,yfood)
				yfood = yfood - 32
			end
			getglobal("WaterboyMenu"..i.."Texture"):SetTexture(Waterboy.OnTap[i].texture)
			if not WaterboyOptions.Minimized.value then
				getglobal("WaterboyMenu"..i):Show()
			end
		else
			getglobal("WaterboyMenu"..i):Hide()
		end
	end
	for i=4,1,-1 do 
		if Waterboy.GemsStats[i].spellid then
			getglobal("WaterboyGem"..i):ClearAllPoints()
			getglobal("WaterboyGem"..i):SetPoint("TOPLEFT","WaterboyFrame","TOPLEFT",xgem,ygem)
			getglobal("WaterboyGem"..i.."Texture"):SetTexture(Waterboy.GemsStats[i].texture)
			ygem = ygem - 32
			if not WaterboyOptions.Minimized.value then
				getglobal("WaterboyGem"..i):Show()
			end
		else
			getglobal("WaterboyGem"..i):Hide()
		end
	end

	Waterboy_TakeInventory()
	Waterboy_FillOrder()
end


-- this function is the cause for the FPS Drops.... 
-- i must have a look at it!
function Waterboy_OnUpdate(arg1)
	--Waterboy_TakeInventory() (i think it should speed up a bit if i comment this out)
	if Waterboy.HitAccept then
		Waterboy.HitAcceptTime = Waterboy.HitAcceptTime + arg1
		if Waterboy.HitAcceptTime > Waterboy.AcceptTimer then
			Waterboy.HitAccept = false
			if WaterboyOptions.Auto.value then
				AcceptTrade()
			end
		end
	end
end

-- moves the minimap icon to current WaterboyOptions.IconPosition setting
function Waterboy_MoveIcon(arg1)
	if arg1 then
		WaterboyOptions.IconPos.value = arg1
	end
	WaterboyIcon:SetPoint("TOPLEFT","Minimap","TOPLEFT",52-(80*cos(WaterboyOptions.IconPos.value)),(80*sin(WaterboyOptions.IconPos.value))-52)
end

local function Waterboy_InitializeOptions()

	-- go through and set initial options
	for i in WaterboyOptInfo do
		if not WaterboyOptions[WaterboyOptInfo[i].opt] then
			WaterboyOptions[WaterboyOptInfo[i].opt] = { type=WaterboyOptInfo[i].type, value=WaterboyOptInfo[i].default }
		end
		if WaterboyOptInfo[i].type=="Check" then
			getglobal(i):SetChecked(WaterboyOptions[WaterboyOptInfo[i].opt].value)
		end
		if WaterboyOptInfo[i].type=="Slider" then
			getglobal(i):SetMinMaxValues(WaterboyOptInfo[i].min,WaterboyOptInfo[i].max)
			getglobal(i):SetValueStep(WaterboyOptInfo[i].step)
			getglobal(i):SetValue(WaterboyOptions[WaterboyOptInfo[i].opt].value)
		end
		if WaterboyOptInfo[i].text then
			getglobal(i.."Text"):SetText(WaterboyOptInfo[i].text)
		end
	end

	WaterboyFrame:SetAlpha(WaterboyOptions.Alpha.value/100)
	WaterboyFrame:SetScale(WaterboyOptions.Scale.value/100)
	Waterboy_MoveIcon() -- adjust minimap icon position

	if WaterboyOptions.OnScreen.value then
		WaterboyAnchor:Enable()
		WaterboyAnchorText:SetTextColor(1,1,1)
	else
		WaterboyAnchor:Disable()
		WaterboyAnchorText:SetTextColor(.5,.5,.5)
	end

	if WaterboyOptions.ShowIcon.value then
		WaterboyIcon:Show()
	end
	Waterboy_MoveAnchor()
end

function Waterboy_OnEvent(event)

	local i

	-- Check if myAddOns is loaded
		if(myAddOnsFrame_Register) then
			-- Register the addon in myAddOns
			myAddOnsFrame_Register(WaterboyDetails);
		end

	if event=="PLAYER_ENTERING_WORLD" then

		WaterboyFrame:UnregisterEvent("PLAYER_ENTERING_WORLD")

		if UnitClass("player")==WB_CLASS_MAGE and not Waterboy.Loaded then

			this:RegisterEvent("TRADE_SHOW")
			this:RegisterEvent("TRADE_CLOSED")
			this:RegisterEvent("TRADE_ACCEPT_UPDATE")
			this:RegisterEvent("BAG_UPDATE")
			this:RegisterEvent("LEARNED_SPELL_IN_TAB")
			this:RegisterEvent("BAG_UPDATE_COOLDOWN")

			if WaterboyFrame:GetBottom() and not WaterboyOptions.Bottom then
				WaterboyOptions.Bottom = WaterboyFrame:GetBottom()
			end

			if WaterboyOptions.IconPosition then
				WaterboyOptions.IconPosition = nil
				Waterboy_LoadDefaults()
			end
			Waterboy_InitializeOptions()
			Waterboy_StockOnTap()

			-- add /waterboy (or /wb) slash command to toggle the window
			SlashCmdList["WaterboyCOMMAND"] = Waterboy_SlashHandler
			SLASH_WaterboyCOMMAND1 = "/waterboy"
			SLASH_WaterboyCOMMAND2 = "/wb"

			-- add Waterboy to the right-click UnitPopup menus
			table.insert(UnitPopupMenus["PARTY"],"WATERBOY")
			table.insert(UnitPopupMenus["PLAYER"],"WATERBOY")
			table.insert(UnitPopupMenus["RAID"],"WATERBOY")
			UnitPopupButtons["WATERBOY"] = { text = "Waterboy", dist = 2 }
			oldWaterboy_UnitPopup_OnClick = UnitPopup_OnClick
			UnitPopup_OnClick = function() if UnitPopupMenus[this.owner][this.value]=="WATERBOY" then TargetUnit(getglobal(UIDROPDOWNMENU_INIT_MENU).unit) Waterboy_Trade() end oldWaterboy_UnitPopup_OnClick() end

			-- make WaterboyFrame hidable with ESC
			Waterboy_ESCable(1)

			Waterboy.Loaded = true

			if WaterboyOptions.OnScreen.value then
				Waterboy_Maximize()
				Waterboy_Minimize()
			end
		end
		return;
	end
	if event=="PLAYER_AURAS_CHANGED" then
		for i=1,16 do
			if string.sub(UnitBuff("player",i) or "",1,25)=="Interface\\Icons\\INV_Drink" then
				if Waterboy.OnTap[WaterboyOptions.TradeSlots[i]] and Waterboy.OnTap[WaterboyOptions.TradeSlots[i]].type=="water" then
					Waterboy_AddToConsolidateQueue(Waterboy.OnTap[WaterboyOptions.TradeSlots[i]].name)
				end
			elseif UnitBuff("player",i)=="Interface\\Icons\\INV_Misc_Fork&Knife" then
				if Waterboy.OnTap[WaterboyOptions.TradeSlots[i]] and Waterboy.OnTap[WaterboyOptions.TradeSlots[i]].type=="food" then
					Waterboy_AddToConsolidateQueue(Waterboy.OnTap[WaterboyOptions.TradeSlots[i]].name)
				end
			end
		end
		return;
	end
	if event=="BAG_UPDATE" then
		if time() > Waterboy.BagsUpdatedTime then
			Waterboy.BagsUpdatedTime = time()
			Waterboy.BagsUpdating = false
			
			Waterboy_TakeInventory() -- count number of items for OnTap display
			Waterboy_ConsolidateItems() -- Do a consolidate pass if a queue exists
			Waterboy_FillOrder() -- count number of items for TradeList display
		end
		return;
	end
	if event=="BAG_UPDATE_COOLDOWN" then
		Waterboy_TakeInventory()
        return;
    end
    -- test
    if event=="TRADE_SHOW" and not Waterboy.TradingNow then
    	TargetUnit("NPC");
        local name = UnitName("target");
        TargetByName(name);
        Waterboy.IsTradeOn = true;
        --ChatFrame1:AddMessage("Trade: "..name);
        return;
    end  
    if event=="TRADE_SHOW" and Waterboy.TradingNow then
		Waterboy_FillOrder()
		for i=1,6 do
			if Waterboy.TradeList[i].tap>0 then
				PickupContainerItem(Waterboy.TradeList[i].bag,Waterboy.TradeList[i].slot)
				DropItemOnUnit("target")
			end
		end
		Waterboy.HitAcceptTime = 0
		Waterboy.HitAccept = true
		return;
	end
    if event=="TRADE_CLOSED" and Waterboy.TradingNow then
		Waterboy.TradingNow = false
		Waterboy.IsTradeOn = false;
		if WaterboyOptions.Reset.value then
			for i=1,6 do
				WaterboyOptions.TradeSlots[i] = 0
				getglobal("WaterboySlot"..i.."Texture"):SetTexture("Interface\\AddOns\\WaterboyLoc\\Artwork\\EmptySlot")
			end
			Waterboy_FillOrder()
		end
		return;
	end
    if event=="TRADE_ACCEPT_UPDATE" and Waterboy.TradingNow and arg1==0 and arg2==1 then
		Waterboy.TradingNow = false
		if WaterboyOptions.Auto.value then
			AcceptTrade()
		end
		return;
	end
    if event=="LEARNED_SPELL_IN_TAB" then
		local oldTradeSlotsByName = {0,0,0,0,0,0}
		-- OnTap indexes are about to change, backup current TradeSlots and then restore
		for i=1,6 do
			if WaterboyOptions.TradeSlots[i]>0 then
				oldTradeSlotsByName[i] = Waterboy.OnTap[WaterboyOptions.TradeSlots[i]].name
				WaterboyOptions.TradeSlots[i] = 0
			end
		end
		Waterboy_StockOnTap()
		for i=1,6 do
			for j=1,table.getn(Waterboy.OnTap) do
				if Waterboy.OnTap[j].name == oldTradeSlotsByName[i] then
					WaterboyOptions.TradeSlots[i] = j
				end
			end
		end
		Waterboy_FillOrder()
		return;
	end
end

function Waterboy_SlashHandler(arg1)

	if not string.find(arg1,".+") then
		Waterboy_Toggle()
	elseif string.lower(arg1)=="reset" then
		Waterboy_LoadDefaults()
	elseif string.lower(arg1)=="trade" then
		Waterboy_Trade()
	elseif string.lower(arg1)=="make" then
		Waterboy_Summon()
	else
		DEFAULT_CHAT_FRAME:AddMessage("|cffffff00"..WB_MSG_SLASHCOMMANDS)
		DEFAULT_CHAT_FRAME:AddMessage("/waterboy : "..WB_MSG_TOGGLEWINDOW)
		DEFAULT_CHAT_FRAME:AddMessage("/waterboy reset : "..WB_MSG_RESET)
		DEFAULT_CHAT_FRAME:AddMessage("/waterboy trade : "..WB_MSG_TRADE)
		DEFAULT_CHAT_FRAME:AddMessage("/waterboy make : "..WB_MSG_SUMMON)
		DEFAULT_CHAT_FRAME:AddMessage("*"..WB_MSG_SUMMON2)
	end
end

function Waterboy_Tooltip(arg1,arg2)

	arg1 = (arg1~=" " and arg1) or "Minimap Button" -- hack for minimap check without a label

	GameTooltip_SetDefaultAnchor(GameTooltip,this)
	GameTooltip:AddLine(arg1)
	GameTooltip:AddLine(arg2,.8,.8,.8,1)
	GameTooltip:Show()
end

local function Waterboy_Item_Tooltip(id)
	
	GameTooltip_SetDefaultAnchor(GameTooltip,this)
	if Waterboy.OnTap[id] then
		local action = WB_ACTION_DRINK

		
		GameTooltip:AddLine(Waterboy.OnTap[id].name)
		GameTooltip:AddLine(WB_MSG_REQLEVEL..(Waterboy.OnTap[id].level),1,1,1)
		if Waterboy.OnTap[id].mana then
			GameTooltip:AddLine(WB_MSG_RESTORES..(Waterboy.OnTap[id].mana)..WB_MSG_MANA,0,1,0)
		else
			GameTooltip:AddLine(WB_MSG_RESTORES..(Waterboy.OnTap[id].hp)..WB_MSG_HP,0,1,0)
			action = WB_ACTION_EAT
		end
		if UnitExists("target") and UnitIsFriend("player","target") and UnitLevel("target")<Waterboy.OnTap[id].level then
			GameTooltip:AddLine(UnitName("target")..WB_MSG_CANT..action..WB_MSG_THIS,1,0,0)
		end
	elseif Waterboy.GemsStats[id].spellid then
		GameTooltip:AddLine(Waterboy.GemsStats[id].name)
		GameTooltip:AddLine(WB_MSG_REQLEVEL..(Waterboy.GemsStats[id].level),1,1,1)
		GameTooltip:AddLine(WB_MSG_RESTORES..(Waterboy.GemsStats[id].mana)..WB_MSG_MANA,0,1,0)
	end
	GameTooltip:Show()
end

local function Waterboy_Gem_Tooltip(id)
	
	GameTooltip_SetDefaultAnchor(GameTooltip,this)
	if Waterboy.GemsStats[id].spellid then
		GameTooltip:AddLine(Waterboy.GemsStats[id].name)
		GameTooltip:AddLine(WB_MSG_REQLEVEL..(Waterboy.GemsStats[id].level),1,1,1)
		GameTooltip:AddLine(WB_MSG_RESTORES..(Waterboy.GemsStats[id].mana)..WB_MSG_MANA,0,1,0)
	end
	GameTooltip:Show()
end



function Waterboy_OnTap_OnEnter()--Bad and dirty way : 

	local id = this:GetID()
	if Waterboy.OnTap[id] then
		Waterboy_Item_Tooltip(id)
	end
end

local function Waterboy_Consume(arg1)

	local i,j,itemlink,itemname,usebag,useslot

	Waterboy_AddToConsolidateQueue(arg1)
	for i=0,4 do
		for j=1,GetContainerNumSlots(i) do
			itemlink = GetContainerItemLink(i,j)
			if itemlink then
				_,_,itemname = string.find(itemlink,"^.*%[(.*)%].*$")
				if itemname==arg1 then
					usebag,useslot = i,j
				end
			end
		end
	end
	if usebag and useslot then
		UseContainerItem(usebag,useslot)
	end
end


function Waterboy_OnTap_OnClick(arg1)

	local id,i,usebag,useslot = this:GetID()

	if arg1=="RightButton" and Waterboy.OnTap[id] then
		Waterboy_ConsolidateItems(Waterboy.OnTap[id].name)
		for i=0,4 do -- go to last of this item in bags and consume it
			for j=1,GetContainerNumSlots(i) do
				itemlink = GetContainerItemLink(i,j)
				if itemlink then
					_,_,itemname = string.find(itemlink,"^.*%[(.*)%].*$")
					if itemname==Waterboy.OnTap[id].name then
						usebag,useslot = i,j
					end
				end
			end
		end
		if usebag and useslot then
			UseContainerItem(usebag,useslot)
		end
	elseif arg1=="LeftButton" and IsShiftKeyDown() and Waterboy.OnTap[id] then
		Waterboy_ConsolidateItems(Waterboy.OnTap[id].name)
		for i=1,6 do
			if WaterboyOptions.TradeSlots[i]==0 then
				WaterboyOptions.TradeSlots[i] = id
				getglobal("WaterboySlot"..i.."Texture"):SetTexture(Waterboy.OnTap[id].texture)
				Waterboy_FillOrder()
				i = 7
			end
		end
	elseif arg1=="LeftButton" and Waterboy.OnTap[id] then
		Waterboy_ConsolidateItems(Waterboy.OnTap[id].name)
		CastSpell(Waterboy.OnTap[id].spellid,BOOKTYPE_SPELL)
	end
	
	
end

function Waterboy_Gem_OnEnter()--Bad and dirty way : 

	local id = this:GetID()
	if Waterboy.GemsStats[id].spellid then
		Waterboy_Gem_Tooltip(id)
	end
end

function Waterboy_Gems_OnClick(arg1)

	local id,i,usebag,useslot = this:GetID()

	if arg1=="LeftButton" and Waterboy.GemsStats[id].present then
		for i=0,4 do -- go to last of this item in bags and consume it
			for j=1,GetContainerNumSlots(i) do
				itemlink = GetContainerItemLink(i,j)
				if itemlink then
					_,_,itemname = string.find(itemlink,"^.*%[(.*)%].*$")
					if string.lower(itemname)==string.lower(Waterboy.GemsStats[id].name) then
						UseContainerItem(i,j)
						j=GetContainerNumSlots(i)+1
						i=5
						Waterboy.GemsStats[id].present = false
					end
				end
			end
		end
	elseif arg1=="LeftButton" and not Waterboy.GemsStats[id].present then
		CastSpell(Waterboy.GemsStats[id].spellid,BOOKTYPE_SPELL)
		Waterboy.GemsStats[id].present = true
	end
	
	
end

function Waterboy_TradeSlots_OnMouseUp()

	local id = this:GetID()

	if CursorHasSpell() and Waterboy.Choice~=0 then
--		PickupSpell(Waterboy.OnTap[Waterboy.Choice].spellid,BOOKTYPE_SPELL) -- drop cursor
		WaterboyOptions.TradeSlots[id] = Waterboy.Choice
		Waterboy.Choice = 0
		getglobal("WaterboySlot"..id.."Texture"):SetTexture(Waterboy.OnTap[WaterboyOptions.TradeSlots[id]].texture)
	elseif not CursorHasSpell() and WaterboyOptions.TradeSlots[id]~=0 then
		PickupSpell(Waterboy.OnTap[WaterboyOptions.TradeSlots[id]].spellid,BOOKTYPE_SPELL)
		Waterboy.Choice = WaterboyOptions.TradeSlots[id]
		getglobal("WaterboySlot"..id.."Texture"):SetTexture("Interface\\AddOns\\WaterboyLoc\\Artwork\\EmptySlot")
		WaterboyOptions.TradeSlots[id] = 0
	end

end

function Waterboy_OnTap_OnDragStart(arg1)

	local id = this:GetID()
	PickupSpell(Waterboy.OnTap[id].spellid,BOOKTYPE_SPELL)
	Waterboy.Choice = id
end

function Waterboy_OnTap_OnDragStop(arg1)

	local id = this:GetID()
	PickupSpell(Waterboy.OnTap[id].spellid,BOOKTYPE_SPELL)

	if Waterboy.Destination>0 then
		WaterboyOptions.TradeSlots[Waterboy.Destination] = Waterboy.Choice
		getglobal("WaterboySlot"..Waterboy.Destination.."Texture"):SetTexture(Waterboy.OnTap[Waterboy.Choice].texture)
		Waterboy_FillOrder()
	end
end

function Waterboy_TradeSlots_OnClick()

	local id = this:GetID()

	WaterboyOptions.TradeSlots[id] = 0
	getglobal("WaterboySlot"..id.."Texture"):SetTexture("Interface\\AddOns\\WaterboyLoc\\Artwork\\EmptySlot")
	getglobal("WaterboySlot"..id.."Count"):SetText(" ")
	GameTooltip:Hide()
	Waterboy_FillOrder()
end

function Waterboy_BestDrink()
local best,itemlink,itemname,bag,slot,name = 0
for i=0,4 do
				for j=1,GetContainerNumSlots(i) do
					itemlink = GetContainerItemLink(i,j)
					if itemlink then
						_,_,itemname = string.find(itemlink,"^.*%[(.*)%].*$")
						if itemname then
							for k=1,table.getn(Waterboy.OnTap) do
								if Waterboy.OnTap[k].name==itemname and Waterboy.OnTap[k].mana and Waterboy.OnTap[k].mana>best then
									bag = i
									slot = j
									name = itemname
									best = Waterboy.OnTap[k].mana
								end
							end
						end
					end
				end
			end
		return name
end

function Waterboy_BestMeal()
local best,itemlink,itemname,bag,slot,name = 0
for i=0,4 do
				for j=1,GetContainerNumSlots(i) do
					itemlink = GetContainerItemLink(i,j)
					if itemlink then
						_,_,itemname = string.find(itemlink,"^.*%[(.*)%].*$")
						if itemname then
							for k=1,table.getn(Waterboy.OnTap) do
								if Waterboy.OnTap[k].name==itemname and Waterboy.OnTap[k].mana and Waterboy.OnTap[k].mana>best then
									bag = i
									slot = j
									name = itemname
									best = Waterboy.OnTap[k].mana
								end
							end
						end
					end
				end
			end
		return name
end

function Waterboy_Summon()

	local have,need,i = 0
	local best,itemlink,itemname,bag,slot,name = 0

	-- check if every TradeSlot has 20, mark first one (need) that needs attention
	for i=1,6 do
		have = have + WaterboyOptions.TradeSlots[i]
		if WaterboyOptions.TradeSlots[i]>0 and Waterboy.OnTap[WaterboyOptions.TradeSlots[i]] and Waterboy.TradeList[i].count<20 then
			need = WaterboyOptions.TradeSlots[i]
			i = 6
		end
	end
	if have==0 then
		DEFAULT_CHAT_FRAME:AddMessage(WB_MSG_SLOT_LL)
	elseif not need then
		DEFAULT_CHAT_FRAME:AddMessage(WB_MSG_ENOUGH)
	else
		if UnitMana("player")>=Waterboy.OnTap[need].cost then
			CastSpell(Waterboy.OnTap[need].spellid,BOOKTYPE_SPELL)
			Waterboy_AddToConsolidateQueue(Waterboy.OnTap[need].name)
		else
			--[[ find the best drink in our bags
			for i=0,4 do
				for j=1,GetContainerNumSlots(i) do
					itemlink = GetContainerItemLink(i,j)
					if itemlink then
						_,_,itemname = string.find(itemlink,"^.*%[(.*)%].*$")
						if itemname then
							for k=1,table.getn(Waterboy.OnTap) do
								if Waterboy.OnTap[k].name==itemname and Waterboy.OnTap[k].mana and Waterboy.OnTap[k].mana>best then
									bag = i
									slot = j
									name = itemname
									best = Waterboy.OnTap[k].mana
								end
							end
						end
					end
				end
			end ]]
			name = Waterboy_BestDrink();
			DEFAULT_CHAT_FRAME:AddMessage(name);
			if name then
				Waterboy_Consume(name)
			else
				DEFAULT_CHAT_FRAME:AddMessage(WB_MSG_NODRINK)
			end
		end
	end
end

function Waterboy_Trade()
	if UnitExists("target") and UnitIsFriend("player","target") and UnitIsPlayer("target") and not UnitIsUnit("player","target") then
		        
        if CheckInteractDistance("target",2) then
			local total = 0
			for i=1,6 do
				if Waterboy.TradeList[i].tap>0 then
					total = total + Waterboy.TradeList[i].count
				end
			end
			if total > 0 then
			    Waterboy.TradingNow = true
				Waterboy_FillOrder()
			-- check if Tradewindow is on
				if Waterboy.IsTradeOn then
				-- start filling
				    Waterboy_FillOrder()
		              for i=1,6 do
			             if Waterboy.TradeList[i].tap>0 then
				            PickupContainerItem(Waterboy.TradeList[i].bag,Waterboy.TradeList[i].slot)
				            DropItemOnUnit("target")
			             end
		              end
		          Waterboy.HitAcceptTime = 0
		          Waterboy.HitAccept = true
				-- end filling
				else
				    InitiateTrade("target")
				end
			else
				UIErrorsFrame:AddMessage(WB_MSG_CANTTRADE..UnitName("target")..WB_MSG_NOTHING,1,.1,.1,1,UIERRORS_HOLD_TIME)
			end
		else
			UIErrorsFrame:AddMessage(WB_MSG_CANTTRADE..UnitName("target")..WB_MSG_TOOFAR,1,.1,.1,1,UIERRORS_HOLD_TIME)
		end
	else
		UIErrorsFrame:AddMessage(WB_MSG_CANTTRADE..(UnitExists("target") and UnitName("target") or WB_MSG_NOTARFET),1,.1,.1,1,UIERRORS_HOLD_TIME)
	end
end

function Waterboy_ResetButton_OnClick()

	for i=1,6 do
		WaterboyOptions.TradeSlots[i] = 0
	end
	Waterboy_FillOrder()
end

function Waterboy_TradeSlots_OnEnter()

	Waterboy.Destination = this:GetID()

	if WaterboyOptions.TradeSlots[Waterboy.Destination]>0 then
		Waterboy_Item_Tooltip(WaterboyOptions.TradeSlots[Waterboy.Destination])
	else
		Waterboy_Tooltip(WB_HELP_TRADESLOTHEADER, WB_HELP_TRADESLOTMSG)
	end
end

function Waterboy_TradeSlots_OnLeave()

	Waterboy.Destination = 0
	GameTooltip:Hide()
end

-- LeftButton = main window, RightButton = options window
function Waterboy_Toggle(arg1)

	arg1 = arg1 or "LeftButton"

	if arg1=="RightButton" then
		if WaterboyOptFrame:IsVisible() then
			WaterboyOptFrame:Hide()
		else
			WaterboyOptFrame:Show()
		end
	elseif arg1=="LeftButton" then
		if WaterboyOptions.OnScreen.value then
			WaterboyOptions.Minimized.value = not WaterboyOptions.Minimized.value
			if WaterboyOptions.Minimized.value then
				Waterboy_Minimize()
			else
				Waterboy_Maximize()
			end
		else
			if WaterboyFrame:IsVisible() then
				WaterboyFrame:Hide()
			else
				WaterboyFrame:Show()
			end
		end
	end
end

function Waterboy_Minimize()
	local i
	local xpos,ypos = WaterboyFrame:GetLeft(), WaterboyFrame:GetBottom()

	WaterboyOptions.Minimized.value = true
	Waterboy_ESCable(0) -- remove ESCable

	if WaterboyFrame:GetHeight() and WaterboyFrame:GetHeight()>50 and Waterboy.Loaded then
		for i=1,14 do
			getglobal("WaterboyMenu"..i):Hide()
		end
		for i=1,6 do
			getglobal("WaterboySlot"..i):Hide()
		end
		for i=1,4 do 
			getglobal("WaterboyGem"..i):Hide()
		end
		WaterboyArrow:Hide()
		WaterboyTitle:Hide()
		WaterboyQty:Show()
		WaterboyResetButton:Hide()
		WaterboyTradeButton:ClearAllPoints()
		WaterboyTradeButton:SetPoint("TOPRIGHT","WaterboyFrame","TOPRIGHT",-4,-4)
		WaterboyTradeButton:SetHeight(19)
		WaterboyTradeButton:SetWidth(50)
		WaterboyMakeButton:Show()
		if xpos and WaterboyOptions.Anchor.value then
			WaterboyFrame:SetPoint("TOPLEFT","UIParent","BOTTOMLEFT",xpos,(WaterboyOptions.Bottom or ypos)+28)
		end
		WaterboyFrame:SetHeight(28)
		WaterboyFrame:SetWidth(150)
		if not WaterboyFrame:IsVisible() then
			WaterboyFrame:Show()
		end
		Waterboy_FillOrder()
	end
end

function Waterboy_Maximize()
	local i
	local xpos,ypos = WaterboyFrame:GetLeft(), WaterboyFrame:GetBottom()

	WaterboyOptions.Minimized.value = false
	Waterboy_ESCable(1) -- make ESCable

	if Waterboy.Loaded then
		for i=1,14 do
			if Waterboy.OnTap[i] then
				getglobal("WaterboyMenu"..i):Show()
			end
		end
		for i=1,6 do
			getglobal("WaterboySlot"..i):Show()
		end
		for i=1,4 do 
			getglobal("WaterboyGem"..i):Show()
		end
		WaterboyArrow:Show()
		WaterboyTitle:Show()
		WaterboyQty:Hide()
		WaterboyResetButton:Show()
		WaterboyTradeButton:ClearAllPoints()
		WaterboyTradeButton:SetPoint("TOPLEFT","WaterboySlot6","BOTTOMLEFT",-6,-2)
		WaterboyTradeButton:SetHeight(24)
		WaterboyTradeButton:SetWidth(40)
		WaterboyMakeButton:Hide()
		if xpos and WaterboyOptions.Anchor.value and WaterboyFrame:GetHeight()<50 then
			WaterboyFrame:SetPoint("TOPLEFT","UIParent","BOTTOMLEFT",xpos,(WaterboyOptions.Bottom or ypos)+252)
		end
		WaterboyFrame:SetHeight(252)
		WaterboyFrame:SetWidth(170)
		WaterboyBack:SetVertexColor(.15,.3,.5)
		WaterboyGauge:Hide()
		if not WaterboyFrame:IsVisible() then
			WaterboyFrame:Show()
		end
	end
end

-- pass 0 to remove ESC, 1 to enable ESC
function Waterboy_ESCable(arg1)

	local found, i

	for i=1,table.getn(UISpecialFrames) do
		if UISpecialFrames[i]=="WaterboyFrame" then
			found = i
		end
	end

	if arg1==1 and not found then
		table.insert(UISpecialFrames,"WaterboyFrame")
	elseif arg1==0 and found then
		i = table.remove(UISpecialFrames,found)
		if i~="WaterboyFrame" then
			DEFAULT_CHAT_FRAME:AddMessage("Waterboy error: Frame "..i.." removed from UISpecialFrames.")
		end
	end

end

function Waterboy_OnMouseDown(arg1)
	if arg1=="LeftButton" and not WaterboyOptions.Lock.value then
		WaterboyFrame:StartMoving()
	end
end

function Waterboy_OnMouseUp(arg1)
	if arg1=="LeftButton" and not WaterboyOptions.Lock.value then
		WaterboyFrame:StopMovingOrSizing()
		WaterboyOptions.Bottom = WaterboyFrame:GetBottom()
	end
end

function Waterboy_Qty_OnEnter()
	local i,r,g,b
	GameTooltip_SetDefaultAnchor(GameTooltip,this)
	GameTooltip:AddDoubleLine(WB_MSG_READY,WaterboyQty:GetText())
	for i=1,6 do
		if Waterboy.TradeList[i].tap>0 then
			r,g,b = 0,1,0
			GameTooltip:AddDoubleLine(Waterboy.OnTap[Waterboy.TradeList[i].tap].name,Waterboy.TradeList[i].count,r,g,b,r,g,b)
		elseif WaterboyOptions.TradeSlots[i] and Waterboy.OnTap[WaterboyOptions.TradeSlots[i]] then
			r,g,b = 1,0,0
			GameTooltip:AddDoubleLine(Waterboy.OnTap[WaterboyOptions.TradeSlots[i]].name,0,r,g,b,r,g,b)
		end
	end
	GameTooltip:Show()
end

function Waterboy_MoveAnchor()

	if WaterboyOptions.Anchor.value then
		WaterboyCloseButton:ClearAllPoints()
		WaterboyCloseButton:SetPoint("BOTTOMLEFT","WaterboyFrame","BOTTOMLEFT",-4,-4)
	else
		WaterboyCloseButton:ClearAllPoints()
		WaterboyCloseButton:SetPoint("TOPLEFT","WaterboyFrame","TOPLEFT",-4,4)
	end
end

-- restores settings/tradeslots to default
function Waterboy_LoadDefaults()

	local i
	for i=1,6 do
		WaterboyOptions.TradeSlots[i] = 0
	end
	for i in WaterboyOptInfo do
		WaterboyOptions[WaterboyOptInfo[i].opt] = { type=WaterboyOptInfo[i].type, value=WaterboyOptInfo[i].default }
	end
	Waterboy_Maximize()
	WaterboyFrame:ClearAllPoints()
	WaterboyFrame:SetPoint("TOPLEFT","UIParent","BOTTOMLEFT",300,500)
	Waterboy_InitializeOptions()
end


function Waterboy_EatnDrink()
	local MaxFoodnDrink,index, name = Waterboy_GetEatnDrink()
	
	for k,index in pairs({"Food","Water"}) do 
		if (index=="Food" and UnitHealth("player")<UnitHealthMax("player")) or(index=="Water" and UnitMana("player")<UnitManaMax("player"))  then
			if MaxFoodnDrink[index].OnTapIndex then 
				name = Waterboy.OnTap[MaxFoodnDrink[index].OnTapIndex].name
				Waterboy_ConsolidateItems(name)
				for i=0,4 do -- go to last of this item in bags and consume it
					for j=1,GetContainerNumSlots(i) do
						itemlink = GetContainerItemLink(i,j)
						if itemlink then
							_,_,itemname = string.find(itemlink,"^.*%[(.*)%].*$")	
							if itemname==name then
								usebag,useslot = i,j
							end	
						end
					end
				end
				if usebag and useslot then
					UseContainerItem(usebag,useslot)
				end
			end 
		end
	end
	
end

function Waterboy_GetEatnDrink()
	local MaxFoodnDrink = {Food = {OnTapIndex = nil,Hp = 0}, Water = {OnTapIndex = nil,Mana = 0}}
--Get the name of the higest lvl food/drink avalaible
	for i=1,13 do
		if Waterboy.OnTap[i] then
			if Waterboy.OnTap[i].type == "food" and Waterboy.OnTap[i].amount>0 and Waterboy.OnTap[i].hp > MaxFoodnDrink.Food.Hp then
				MaxFoodnDrink.Food.OnTapIndex = i
				MaxFoodnDrink.Food.Hp = Waterboy.OnTap[i].hp
			elseif Waterboy.OnTap[i].type == "water" and Waterboy.OnTap[i].amount>0 and Waterboy.OnTap[i].mana > MaxFoodnDrink.Water.Mana then
				MaxFoodnDrink.Water.OnTapIndex = i
				MaxFoodnDrink.Water.Mana = Waterboy.OnTap[i].mana
			end
		end
	end
	return MaxFoodnDrink
end

function Waterboy_UseGem()
		
	for k=1,4 do
		if Waterboy.GemsStats[k].present then
			for i=0,4 do -- go to last of this item in bags and consume it
				for j=1,GetContainerNumSlots(i) do
					itemlink = GetContainerItemLink(i,j)
					if itemlink then
						_,_,itemname = string.find(itemlink,"^.*%[(.*)%].*$")	
						if string.lower(itemname)==string.lower(Waterboy.GemsStats[k].name) then
							usebag,useslot = i,j
						end	
					end
				end
			end
		end	
	end	
	if usebag and useslot then
		UseContainerItem(usebag,useslot)
	end

end

function Waterboy_SetIconTexture()
	local gemfound,MaxFoodnDrink = false
	if WaterboyOptions.ShowIcon.value then
		if WaterboyOptions.Drink.value then
			MaxFoodnDrink = Waterboy_GetEatnDrink()
			
			if MaxFoodnDrink.Water.OnTapIndex then
				local k = floor((Waterboy.OnTap[MaxFoodnDrink.Water.OnTapIndex].level+6)/10)+1
				getglobal("WaterboyIconNTexture"):SetTexture(Waterboy.IconTextures["eau"..k])
				getglobal("WaterboyIconNTexture"):SetVertexColor(1,1,1)
			elseif Waterboy.OnTap[1] then
				getglobal("WaterboyIconNTexture"):SetTexture(Waterboy.IconTextures.pain)
				getglobal("WaterboyIconNTexture"):SetVertexColor(.3,.3,.3)
			else
				getglobal("WaterboyIconNTexture"):SetTexture("Interface\\AddOns\\WaterboyLoc\\Artwork\\WaterboyIcon-Up")
				getglobal("WaterboyIconNTexture"):SetVertexColor(1,0.1,0.1)
			end
		
		elseif WaterboyOptions.ManaGem.value then
			for k=1,4 do
				if Waterboy.GemsStats[k].spellid and Waterboy.GemsStats[k].present then
					gemfound = true
					getglobal("WaterboyIconNTexture"):SetTexture(Waterboy.IconTextures["gem"..k])
					if Waterboy.GemsStats[k].OnCoolDown then
						getglobal("WaterboyIconNTexture"):SetVertexColor(1,0.1,0.1)
					else
						getglobal("WaterboyIconNTexture"):SetVertexColor(1,1,1)
					end
				elseif not gemfound then
					getglobal("WaterboyIconNTexture"):SetVertexColor(.3,.3,.3)
				end
			end
		else
			getglobal("WaterboyIconNTexture"):SetTexture("Interface\\AddOns\\WaterboyLoc\\Artwork\\WaterboyIcon-Up")
			getglobal("WaterboyIconNTexture"):SetVertexColor(1,1,1)
		end
	end
	


end
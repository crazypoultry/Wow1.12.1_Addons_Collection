function ReagentCount_OnLoad()
	DEFAULT_CHAT_FRAME:AddMessage("ReagentCount Enabled")
--	Wrapper functions for IsConsumableAction and GetActionCount
	oldIsConsumableAction = IsConsumableAction
	IsConsumableAction = IsConsumableActionWrapper
	oldGetActionCount = GetActionCount
	GetActionCount = GetActionCountWrapper
	oldActionButton_OnEvent = ActionButton_OnEvent
	ActionButton_OnEvent = ActionButton_OnEventWrapper
end

function ActionButton_OnEventWrapper()
	if(event == "BAG_UPDATE" and arg1<5) then
		ActionButton_Update()
	end
	oldActionButton_OnEvent(event)
end

function GetActionCountWrapper(slot)
	local count = oldGetActionCount(slot)
	if (HasAction(slot)) then
		local reagent = Reagent_Check(slot)
		if (reagent ~= nil) then
			if (reagent ~= "") then
				count = Item_Check(reagent)
				this:RegisterEvent("BAG_UPDATE")
			else
				if (this ~= nil) then
					this:UnregisterEvent("BAG_UPDATE")
				end
			end
		end
	end
	return count
end

function IsConsumableActionWrapper(slot)
	local consumable = oldIsConsumableAction(slot)
	if (HasAction(slot)) then
		local reagent = Reagent_Check(slot)
		if (reagent ~= nil) then
			if (reagent ~= "") then
				consumable = 1
			end
		end
	end
	return consumable
end

function Reagent_Check(slot)
	local oldThis = this
	ReagentCount_Tooltip:SetAction(slot)
	local exists
	local reagent
	if (ReagentCount_Tooltip:NumLines() ~=0) then
		reagent = ""
		for i=1,ReagentCount_Tooltip:NumLines() do
			local line = getglobal("ReagentCount_TooltipTextLeft" .. i)
			if (line ~= nil) then
				line = line:GetText()
				_, start = strfind(line,reagentText,1)
				if (start ~= nil) then
					reagent = strsub(line,start+1)
				end
			end
		end
	end
	this = oldThis
	return reagent
end

function Item_Check(name)
	Count = 0
	for bag = 4, 0, -1 do
		local size = GetContainerNumSlots(bag);

		if (size > 0) then
			-- for each slot in the bag

			for slot = 1, size do
				local texture, itemCount = GetContainerItemInfo(bag, slot);

				if (itemCount) then
					local itemLink = GetContainerItemLink(bag,slot)
					local _, _, itemCode = strfind(itemLink, "(%d+):")
					local itemName, _, _, _, _, _ = GetItemInfo(itemCode)

					-- if the item has a name
					if (itemName ~= "" and itemName ~= nil) then
						if (itemName == name) then
							Count = Count + itemCount;
						end
					end
				end
			end
		end
	end
	return Count;
end
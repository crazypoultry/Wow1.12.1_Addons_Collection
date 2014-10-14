
function BS_OnLoad()
	this:RegisterEvent("BAG_UPDATE")
	this:RegisterEvent("PLAYER_LOGIN")
end

function BS_OnEvent()
	local count = 0
	for bag = 0, 4 do
		for slot = 1, GetContainerNumSlots(bag) do
			if(GetContainerItemLink(bag, slot) == nil) then
				count = count + 1
			end
		end
	end
	BS_Frame_Text:SetText(count)
	if(count == 0) then
		BS_Frame_Text:SetTextColor(1.0, 0.1, 0.1)
	elseif(count > 0 and count <= 10) then
		BS_Frame_Text:SetTextColor(1.0, 0.82, 0)
	else
		BS_Frame_Text:SetTextColor(0.1, 1.0, 0.1)
	end
end

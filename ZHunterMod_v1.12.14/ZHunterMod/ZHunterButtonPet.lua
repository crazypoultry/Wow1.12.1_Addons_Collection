ZHunterMod_Saved["ZHunterButtonPet"] = {}
ZHunterMod_Saved["ZHunterButtonPet"]["pet"] = {}
ZHunterMod_Saved["ZHunterButtonPet"]["pet"]["happiness"] = nil
ZHunterMod_Saved["ZHunterButtonPet"]["pet"]["status"] = nil
ZHunterMod_Saved["ZHunterButtonPet"]["pet"]["dead"] = nil
ZHunterMod_Saved["ZHunterButtonPet"]["spells"] = {1, 2, 3, 4, 5, 6, 7, 8, 9}
ZHunterMod_Saved["ZHunterButtonPet"]["rows"] = 1
ZHunterMod_Saved["ZHunterButtonPet"]["count"] = 9
ZHunterMod_Saved["ZHunterButtonPet"]["horizontal"] = nil
ZHunterMod_Saved["ZHunterButtonPet"]["vertical"] = nil
ZHunterMod_Saved["ZHunterButtonPet"]["firstbutton"] = "RIGHT"
ZHunterMod_Saved["ZHunterButtonPet"]["tooltip"] = 1
ZHunterMod_Saved["ZHunterButtonPet"]["parent"] = {}
ZHunterMod_Saved["ZHunterButtonPet"]["parent"]["size"] = 36
ZHunterMod_Saved["ZHunterButtonPet"]["parent"]["hide"] = nil
ZHunterMod_Saved["ZHunterButtonPet"]["parent"]["circle"] = 1
ZHunterMod_Saved["ZHunterButtonPet"]["children"] = {}
ZHunterMod_Saved["ZHunterButtonPet"]["children"]["size"] = 36
ZHunterMod_Saved["ZHunterButtonPet"]["children"]["hideonclick"] = 1
ZHunterMod_Saved["ZHunterButtonPet"]["food"] = {}

ZHunterMod_Pet_Spells = {
	ZHUNTER_PET_EYES,
	ZHUNTER_PET_DISMISS,
	ZHUNTER_PET_MEND,
	ZHUNTER_PET_FEED,
	ZHUNTER_PET_CALL,
	ZHUNTER_PET_REVIVE,
	ZHUNTER_PET_LORE,
	ZHUNTER_PET_TRAINING,
	ZHUNTER_PET_TAMING
}

function ZHunterButtonPet_OnLoad()
	this:RegisterEvent("VARIABLES_LOADED")
end

function ZHunterButtonPet_OnEvent()
	if event == "VARIABLES_LOADED" then
		if UnitClass("player") ~= ZHUNTER_HUNTER then
			ZHunterButtonPet:UnregisterAllEvents()
			ZHunterButtonPet:Hide()
			return
		end
		ZHunterButtonPet_CreateButtons()
		ZHunterButtonPet.options = ZHunterButtonPetOptions
		ZHunterButtonPet.beforeclick = ZHunterButtonPetAdjustment_BeforeClick
		ZHunterButtonPetAdjustment = CreateFrame("Frame", "ZHunterButtonPetAdjustment")
		ZHunterButtonPetAdjustment:RegisterEvent("UNIT_HEALTH")
		ZHunterButtonPetAdjustment:RegisterEvent("UNIT_HAPPINESS")
		ZHunterButtonPetAdjustment:RegisterEvent("UNIT_PET")
		ZHunterButtonPetAdjustment:RegisterEvent("PLAYER_ENTERING_WORLD")
		ZHunterButtonPetAdjustment:SetScript("OnEvent", ZHunterButtonPetAdjustment_OnEvent)
		ZHunterButtonPet_Tooltip = CreateFrame("GameTooltip", "ZHunterButtonPet_Tooltip", nil, "GameTooltipTemplate")
		ZHunterButtonPet_SetupOptions()
		ZHunterButtonPet_SetupSizeAndPosition()
	end
end

function ZHunterButtonPet_CreateButtons()
	ZSpellButton_CreateChildren(ZHunterButtonPet, "ZHunterButtonPet", 9)
	local info = {}
	for i=1, table.getn(ZHunterMod_Pet_Spells) do
		if not tonumber(ZHunterMod_Saved["ZHunterButtonPet"]["spells"][i]) then
			info = ZHunterMod_Pet_Spells
			ZHunterMod_Saved["ZHunterButtonPet"]["spells"] = {1, 2, 3, 4, 5, 6, 7, 8, 9}
			break
		end
		info[i] = ZHunterMod_Pet_Spells[ZHunterMod_Saved["ZHunterButtonPet"]["spells"][i]]
	end
	ZHunterButtonPet.found = ZSpellButton_SetButtons(ZHunterButtonPet, info)
	if ZHunterButtonPet.found > 0 and ZHunterButtonPet.found < ZHunterMod_Saved["ZHunterButtonPet"]["count"] then
		ZHunterMod_Saved["ZHunterButtonPet"]["count"] = ZHunterButtonPet.found
	end
end

function ZHunterButtonPet_SetupSizeAndPosition()
	ZSpellButton_SetSize(ZHunterButtonPet, ZHunterMod_Saved["ZHunterButtonPet"]["parent"]["size"])
	ZSpellButton_SetSize(ZHunterButtonPet, ZHunterMod_Saved["ZHunterButtonPet"]["children"]["size"], 1)
	ZSpellButton_SetExpandDirection(ZHunterButtonPet, ZHunterMod_Saved["ZHunterButtonPet"]["firstbutton"])
	ZSpellButton_ArrangeChildren(ZHunterButtonPet, ZHunterMod_Saved["ZHunterButtonPet"]["rows"], 
		ZHunterMod_Saved["ZHunterButtonPet"]["count"], ZHunterMod_Saved["ZHunterButtonPet"]["horizontal"],
		ZHunterMod_Saved["ZHunterButtonPet"]["vertical"])
end

function ZHunterButtonPet_Reset()
	ZHunterMod_Saved["ZHunterButtonPet"] = {}
	ZHunterMod_Saved["ZHunterButtonPet"]["pet"] = {}
	ZHunterMod_Saved["ZHunterButtonPet"]["pet"]["happiness"] = nil
	ZHunterMod_Saved["ZHunterButtonPet"]["pet"]["status"] = nil
	ZHunterMod_Saved["ZHunterButtonPet"]["pet"]["dead"] = nil
	ZHunterMod_Saved["ZHunterButtonPet"]["spells"] = {1, 2, 3, 4, 5, 6, 7, 8, 9}
	ZHunterMod_Saved["ZHunterButtonPet"]["rows"] = 1
	ZHunterMod_Saved["ZHunterButtonPet"]["count"] = 9
	ZHunterMod_Saved["ZHunterButtonPet"]["horizontal"] = nil
	ZHunterMod_Saved["ZHunterButtonPet"]["vertical"] = nil
	ZHunterMod_Saved["ZHunterButtonPet"]["firstbutton"] = "RIGHT"
	ZHunterMod_Saved["ZHunterButtonPet"]["tooltip"] = 1
	ZHunterMod_Saved["ZHunterButtonPet"]["parent"] = {}
	ZHunterMod_Saved["ZHunterButtonPet"]["parent"]["size"] = 36
	ZHunterMod_Saved["ZHunterButtonPet"]["parent"]["hide"] = nil
	ZHunterMod_Saved["ZHunterButtonPet"]["parent"]["circle"] = 1
	ZHunterMod_Saved["ZHunterButtonPet"]["children"] = {}
	ZHunterMod_Saved["ZHunterButtonPet"]["children"]["size"] = 36
	ZHunterMod_Saved["ZHunterButtonPet"]["children"]["hideonclick"] = 1
end

function IsPetDead()
	return ZHunterMod_Saved["ZHunterButtonPet"]["pet"]["dead"]
end

function ZHunterButtonPetAdjustment_BeforeClick()
	if CursorHasItem() then
		DropItemOnUnit("pet")
		return 1
	end
end

function ZHunterButtonPetAdjustment_OnEvent()
	local health, happiness, status, dead
	if arg1 == "pet" then
		if event == "UNIT_HAPPINESS" then
			happiness = GetPetHappiness()
			if happiness == ZHunterMod_Saved["ZHunterButtonPet"]["pet"]["happiness"] then
				return
			end
			ZHunterMod_Saved["ZHunterButtonPet"]["pet"]["happiness"] = happiness
		elseif event == "UNIT_HEALTH" then
			health = UnitHealth("pet")
			ZHunterMod_Saved["ZHunterButtonPet"]["pet"]["dead"] = nil
			if health == 0 then
				ZHunterMod_Saved["ZHunterButtonPet"]["pet"]["dead"] = 1
			elseif health / UnitHealthMax("pet") > 0.75 then
				ZHunterMod_Saved["ZHunterButtonPet"]["pet"]["status"] = 2
			else
				ZHunterMod_Saved["ZHunterButtonPet"]["pet"]["status"] = 1
			end
			
		end
	elseif event == "UNIT_PET" and arg1 == "player" then
		if not UnitExists("pet") then
			ZHunterMod_Saved["ZHunterButtonPet"]["pet"]["status"] = nil
		else
			ZHunterMod_Saved["ZHunterButtonPet"]["pet"]["status"] = 2
			if UnitHealth("pet") > 0 then
				ZHunterMod_Saved["ZHunterButtonPet"]["pet"]["dead"] = nil
			end
		end
	end
	local spells = {}
	local name
	local choice
	for i=1, ZHunterButtonPet.count do
		local button
		button = getglobal(ZHunterButtonPet.name..i)
		if button.id then
			name = GetSpellName(button.id, "spell")
			spells[name] = button
			if not choice and (name == ZHUNTER_PET_DISMISS or name == ZHUNTER_PET_EYES) then
				choice = button
			end
		end
	end
	status = ZHunterMod_Saved["ZHunterButtonPet"]["pet"]["status"]
	happiness = ZHunterMod_Saved["ZHunterButtonPet"]["pet"]["happiness"]
	dead = ZHunterMod_Saved["ZHunterButtonPet"]["pet"]["dead"]
	local id = ZHunterButtonPet.id
	name = nil
	if dead then
		name = ZHUNTER_PET_REVIVE
	elseif not status then
		name = ZHUNTER_PET_CALL
	elseif status == 1 then
		name = ZHUNTER_PET_MEND
	elseif happiness ~= 3 then
		name = ZHUNTER_PET_FEED
	elseif choice then
		id = choice.id
	end
	if name and spells[name] then
		id = spells[name].id
	end
	ZHunterButtonPet.id = id
	ZSpellButton_UpdateButton(ZHunterButtonPet)
	ZSpellButton_UpdateCooldown(ZHunterButtonPet)
	if GameTooltip:IsOwned(ZHunterButtonPet) then
		ZSpellButtonParent_OnEnter(ZHunterButtonPet)
	end
end

function ZHunterButtonPet_KeyBinding(index)
	local button
	if index then
		button = getglobal("ZHunterButtonPet"..index)
	else
		button = ZHunterButtonPet
	end
	if button.id then
		CastSpell(button.id, "spell")
		if ZHunterButtonPet.hideonclick then
			ZHunterButtonPet.children:Hide()
		end
	end
end

function ZHunterButtonPet_FeedPet()

end

SLASH_ZHunterButtonPet1 = "/ZPet"
SlashCmdList["ZHunterButtonPet"] = function(msg)
	if msg == "reset" then
		ZHunterButtonPet_Reset()
		ZHunterButtonPet:ClearAllPoints()
		ZHunterButtonPet:SetPoint("CENTER", UIParent, "CENTER", 0, 60)
	elseif msg == "options" then
		ZHunterButtonPet.options:Show()
	else
		DEFAULT_CHAT_FRAME:AddMessage("Possible Commands: \"options\", \"reset\"", 0, 1, 1)
	end
end
MM_Container_Epic_Mounts = {"Reins of the Winterspring Frostsaber","Great Gray Kodo","Great Brown Kodo","Great White Kodo","Swift Blue Raptor","Swift Brown Ram","Swift Brown Steed","Horn of the Swift Brown Wolf","Reins of the Swift Frostsaber","Swift Gray Ram","Horn of the Swift Gray Wolf","Swift Green Mechanostrider","Reins of the Swift Mistsaber","Swift Olive Raptor","Swift Orange Raptor","Swift Palomino","Swift Razzashi Raptor","Reins of the Swift Stormsaber","Horn of the Swift Timber Wolf","Swift White Mechanostrider","Swift White Ram","Swift White Steed","Swift Yellow Mechanostrider","Swift Zulian Tiger","Whistle of the Ivory Raptor","Whistle of the Mottled Red Raptor","Horn of the Arctic Wolf","Horn of the Red Wolf","Palomino Bridle","White Stallion Bridle","Reins of the Nightsaber","Reins of the Frostsaber","Icy Blue Mechanostrider Mod A","White Mechanostrider Mod A","Frost Ram","Black Ram","Green Kodo","Teal Kodo","Deathcharger's Reins","Purple Skeletal Warhorse","Green Skeletal Warhorse","Black War Ram","Black Battlestrider","Reins of the Black War Tiger","Black War Steed Bridle","Red Skeletal Warhorse","Whistle of the Black War Raptor","Horn of the Black War Wolf","Black War Kodo","Black Qiraji Resonating Crystal","Stormpike Battle Charger","Horn of the Frostwolf Howler"}

MM_Container_Normal_Mounts = {"Black Stallion Bridle","Whistle of the Violet Raptor","Whistle of the Turquoise Raptor","Whistle of the Emerald Raptor","Horn of the Brown Wolf","Horn of the Dire Wolf","Horn of the Timber Wolf","Brown Horse Bridle","Chestnut Mare Bridle","Pinto Bridle","Reins of the Spotted Frostsaber","Reins of the Striped Frostsaber","Reins of the Striped Nightsaber","Unpainted Mechanostrider","Green Mechanostrider","Blue Mechanostrider","Red Mechanostrider","White Ram","Brown Ram","Gray Ram","Gray Kodo","Brown Kodo","Brown Skeletal Horse","Blue Skeletal Horse","Red Skeletal Horse"}

MM_Container_AQ_Mounts = {"Black Qiraji Resonating Crystal","Yellow Qiraji Resonating Crystal","Blue Qiraji Resonating Crystal","Red Qiraji Resonating Crystal","Green Qiraji Resonating Crystal"}

MM_Spell_Epic_Mounts = {"Summon Dreadsteed","Summon Charger"}

MM_Spell_Normal_Mounts = {"Summon Felsteed","Summon Warhorse"}

MM_Player_Spell_Mounts= {}
MM_Player_AQ_Mounts = {}
MM_Player_Mounts = {}

BINDING_HEADER_MOUNTMASTER = "MountMaster"

NumAQMounts=0
NumMounts=0
MMUseSpellMount=true

function MM_Player_Has_Spell(spell)
	local count = 1
	while (GetSpellName(count, BOOKTYPE_SPELL)) do
		spellName = GetSpellName(count, BOOKTYPE_SPELL)
		if (spellName == spell) then
			return true
		end
		count = count + 1
	end
end

function MM_GetMountBagSlot(itemName)
	for bag=0,4 do
		for slot=1,GetContainerNumSlots(bag) do
			link=GetContainerItemLink(bag,slot)
			if link and strfind(link,itemName) then
				return bag,slot
			end
		end
	end
end

function MM_Mount()
	mountIndex = MM_Player_Is_Mounted()
	if mountIndex then
		CancelPlayerBuff(mountIndex)
	else
		MM_Populate_Mounts()
		if NumAQMounts>0 and GetMinimapZoneText() == "Ahn'Qiraj" then
			x = math.random(1,NumAQMounts)
			UseContainerItem(MM_Player_AQ_Mounts[x].bag,MM_Player_AQ_Mounts[x].slot)
		elseif NumMounts>0 then
			x = math.random(1,NumMounts)
			if x > getn(MM_Player_Mounts) then
				CastSpellByName(MM_Player_Spell_Mounts[x-getn(MM_Player_Mounts)].spell)
			else
				UseContainerItem(MM_Player_Mounts[x].bag,MM_Player_Mounts[x].slot)
			end
		else
			print("MountMaster:  No mounts found in inventory.")
		end
	end
end

function MM_Init()
	SLASH_MOUNTMASTER1 = "/mm"
	SLASH_MOUNTMASTER2 = "/MM"
	SLASH_MOUNTMASTER3 = "/MountMaster"
	SLASH_MOUNTMASTER4 = "/mountmaster"
	SlashCmdList["MOUNTMASTER"] = function(msg)
		MM_Mount()
	end
	SLASH_MOUNTMASTERSPELLTOGGLE1 = "/mmspelltoggle"
	SlashCmdList["MOUNTMASTERSPELLTOGGLE"] = function(msg)
		if MMUseSpellMount then
			MMUseSpellMount = false
			print("MountMaster:  Spell mounts will only be used if it is the only mount you have")
		else
			MMUseSpellMount = true
			print("MountMaster:  Spell mounts will now be used even if you have other mounts")
		end
	end
	SLASH_MOUNTMASTERHELP1 = "/mmhelp"
	SlashCmdList["MOUNTMASTERHELP"] = function(msg)
		print("MountMaster:  To mount/dismount put /mm or /mountmaster in a macro and use the macro, or bind it to a key in the Key Bindings menu")
		print("To toggle spell mounts (for paladins and warlocks) type /mmspelltoggle")
		print("With spell mounts toggled off, MountMaster will only use your summoned mount if there are no other mounts in your inventory.")
	end 
end

function MountMaster_OnLoad()
	print("Mount Master Loaded")
	print("   For usage type /mmhelp")
end

function MM_Populate_Mounts()
	
	MM_Player_Mounts = {}
	NumAQMounts=0
	NumMounts=0
	
	local i=1;
	for _,AQMountName in MM_Container_AQ_Mounts do
		b,s=MM_GetMountBagSlot(AQMountName)
		if b and s then
			MM_Player_AQ_Mounts[i] = {bag=b,slot=s}
			i=i+1
			NumAQMounts=NumAQMounts+1
		end
	end
	
	i=1
	for _,mountName in MM_Container_Epic_Mounts do
		b,s=MM_GetMountBagSlot(mountName)
		if b and s then
			MM_Player_Mounts[i] = {bag=b,slot=s}
			NumMounts=NumMounts+1
			i=i+1
		end
	end
	
	i=1
	if MMUseSpellMount or NumMounts==0 then
		for _,Mount_Spell in MM_Spell_Epic_Mounts do
			if MM_Player_Has_Spell(Mount_Spell) then
				MM_Player_Spell_Mounts[i] = {spell=Mount_Spell}
				NumMounts=NumMounts+1
				i=i+1
			end
		end
	end

	if NumMounts==0 then
		i=1
		for _,mountName in MM_Container_Normal_Mounts do
			b,s=MM_GetMountBagSlot(mountName)
			if b and s then
				MM_Player_Mounts[i] = {bag=b,slot=s}
				NumMounts=NumMounts+1
				i=i+1
			end
		end
		
		i=1
		if MMUseSpellMount or NumMounts==0 then
			for _,Mount_Spell in MM_Spell_Normal_Mounts do
				if MM_Player_Has_Spell(Mount_Spell) then
					MM_Player_Spell_Mounts[i] = {spell=Mount_Spell}
					NumMounts=NumMounts+1
					i=i+1
				end
			end
		end
	end
end

function MM_Player_Is_Mounted()
	local i=0
	if not MountMasterTooltip:IsOwned(WorldFrame) then 
		MountMasterTooltip:SetOwner(WorldFrame, "ANCHOR_NONE")
	end
	while GetPlayerBuff(i, "HELPFUL")~=-1 do 
		MountMasterTooltip:ClearLines()
		local newI = GetPlayerBuff(i, "HELPFUL")
		MountMasterTooltip:SetPlayerBuff(newI)
		if strfind(MountMasterTooltipTextLeft2:GetText() or "", "Increases speed by") then
			return newI
		end
		i=i+1
	end
end

function print(msg)
	DEFAULT_CHAT_FRAME:AddMessage(msg)
end
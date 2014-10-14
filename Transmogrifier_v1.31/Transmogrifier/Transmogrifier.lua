--[[ Transmogrifier 1.31 ]]

Transmogrifier = {

	Before = {			-- the "Before" icon
		name = nil,
		texture = nil
	},
	After = nil,		-- the "After" icon

	used=nil,			-- whether the transmogrifier frame has been shown or not
	realTexture = nil,	-- the original texture of an item

	numIcons = 0,		-- number of icons in the .Icons table
	Icons = {},			-- numerically indexed list of icons to choose from

	numBnA = 0,			-- number of "before and after"s to list
	BnA = {},			-- numerically indexed list of before and after icons

	more = nil,			-- whether to show more or less icons

}

-- SavedVariables: all Transmogrified items are stored here
Transmogrified = {
	enabled = nil -- 1 if there's stuff to transmogrify
}

function Transmogrifier.Toggle()
	local frame = TransmogrifierFrame

	if frame:IsVisible() then
		frame:Hide()
	else
		frame:Show()
	end
end

function Transmogrifier.OnShow()

	if not Transmogrifier.used then
		Transmogrifier.used = 1
		table.insert(UISpecialFrames,"TransmogrifierFrame") -- nor any need to live in UISpecialFrames until used
		StaticPopupDialogs["TRANSMOGRIFIERRELOAD"] = { -- reload static popup if we need it
			text = "Reload the UI now?\n\nThis will make all icon changes consistent across the UI.",
			button1 = "Yes", button2 = "No", OnAccept = function() ReloadUI() end, timeout = 0, whileDead = 1 }

		Transmogrifier.LoadAllIcons()
	end
	Transmogrifier.more = nil -- start out always showing less icons
	Transmogrifier.DefineBefore()
	Transmogrifier.DefineAfter()
	Transmogrifier.ValidateTransmogrify()
	Transmogrifier.CreateBnA()
	TransmogrifierBnAScrollFrameScrollBar:SetValue(0)
end

function Transmogrifier.OnLoad()

	SlashCmdList["TransmogrifierCOMMAND"] = Transmogrifier.Toggle
	SLASH_TransmogrifierCOMMAND1 = "/transmogrifier"
	SLASH_TransmogrifierCOMMAND2 = "/trans"
	SLASH_TransmogrifierCOMMAND3 = "/tmr"

	Transmogrifier.oldGetInventoryItemTexture = GetInventoryItemTexture
	GetInventoryItemTexture = Transmogrifier.newGetInventoryItemTexture

	Transmogrifier.oldGetContainerItemInfo = GetContainerItemInfo
	GetContainerItemInfo = Transmogrifier.newGetContainerItemInfo

	Transmogrifier.oldGetActionTexture = GetActionTexture
	GetActionTexture = Transmogrifier.newGetActionTexture

	Transmogrifier.oldGetItemInfo = GetItemInfo
	GetItemInfo = Transmogrifier.newGetItemInfo

	TransmogrifierFrame:SetBackdropColor(1,1,1,.55)
	TransmogrifierFrame:SetBackdropBorderColor(.5,.5,.5,1)
end

-- scroll frame update for the list on the left (before and after--saved changes)
function Transmogrifier.BnAUpdate()

	local frame = TransmogrifierBnAScrollFrame

	local i, item, texture, idx
	local offset = FauxScrollFrame_GetOffset(frame) or 0

	for i=1,5 do
		item = getglobal("TransmogrifierBnA"..i)
		idx = offset + i
		if idx<=Transmogrifier.numBnA then
			getglobal("TransmogrifierBnA"..i.."Before"):SetTexture(Transmogrifier.BnA[idx].before)
			getglobal("TransmogrifierBnA"..i.."After"):SetTexture(Transmogrifier.BnA[idx].after)
			item:Show()
			if Transmogrifier.BnA[idx].name==Transmogrifier.selectedBnA then
				item:LockHighlight()
			else
				item:UnlockHighlight()
			end
		else
			item:Hide()
		end
	end

	FauxScrollFrame_Update(frame, Transmogrifier.numBnA , 5, 28 )

end

-- scroll frame update for the list on the right (icon choices)
function Transmogrifier.ChoiceUpdate()

	local frame = TransmogrifierChoiceScrollFrame
	local i, item, texture, idx
	local offset = FauxScrollFrame_GetOffset(frame) or 0

	for i=1,15 do
		item = getglobal("TransmogrifierChoice"..i)
		idx = (offset*3) + i
		if idx<=Transmogrifier.numIcons then
			getglobal("TransmogrifierChoice"..i.."Icon"):SetTexture(Transmogrifier.Icons[idx])
			item:Show()
		else
			item:Hide()
		end
		if Transmogrifier.Icons[idx]==Transmogrifier.After then
			item:LockHighlight()
		else
			item:UnlockHighlight()
		end
	end
	FauxScrollFrame_Update(frame, ceil(Transmogrifier.numIcons/3) , 5, 28 )
end

function Transmogrifier.ValidateTransmogrify()

	local before = Transmogrifier.Before

	if not before.texture or not Transmogrifier.After then
		Transmogrify:Disable()
	elseif before.texture ~= Transmogrifier.After then
		Transmogrify:Enable()
		Transmogrify:SetText("Transmogrify")
	elseif before.texture and (not Transmogrified[before.texture] or (Transmogrified[before.texture] and not Transmogrified[before.texture][before.name])) then
		Transmogrify:Disable()
	elseif Transmogrifier.Before.texture == Transmogrifier.After then
		Transmogrify:Enable()
		Transmogrify:SetText("Untransmogrify")
	end

	if before.texture then
		TransmogrifierMore:Enable()
	else
		TransmogrifierMore:Disable()
	end
	TransmogrifierMore:SetText(Transmogrifier.more and "Less..." or "More...")
end

function Transmogrifier.OnClick(where)

	if where=="Before" then
		local texture,name = Transmogrifier.GetCursor()
		if name then
			Transmogrifier.DefineBefore(name,texture)
			Transmogrifier.ClearCursor()
		elseif Transmogrifier.Before.name then
			Transmogrifier.DefineBefore()
		end
		Transmogrifier.Tooltip("Before")
	elseif where=="Choice" then
		local idx = (FauxScrollFrame_GetOffset(TransmogrifierChoiceScrollFrame) or 0)*3 + this:GetID()
		Transmogrifier.DefineAfter(Transmogrifier.Icons[idx])
		Transmogrifier.ChoiceUpdate()
	elseif where=="After" then
		Transmogrifier.DefineAfter(Transmogrifier.GetCursor())
		Transmogrifier.ClearCursor()
		Transmogrifier.ChoiceUpdate()
	elseif where=="BnA" then
		local idx = (FauxScrollFrame_GetOffset(TransmogrifierBnAScrollFrame) or 0) + this:GetID()
		if Transmogrifier.selectedBnA~=Transmogrifier.BnA[idx].name then
			Transmogrifier.selectedBnA = Transmogrifier.BnA[idx].name
			Transmogrifier.DefineBefore(Transmogrifier.BnA[idx].name,Transmogrifier.BnA[idx].before)
		else
			Transmogrifier.selectedBnA = ""
			Transmogrifier.DefineBefore()
			Transmogrifier.DefineAfter()
		end
		Transmogrifier.BnAUpdate()
	elseif where=="More" then
		Transmogrifier.more = not Transmogrifier.more
		Transmogrifier.DefineBefore(Transmogrifier.Before.name,Transmogrifier.Before.texture)
	elseif where=="Reload" then
		StaticPopup_Show("TRANSMOGRIFIERRELOAD")
	end
	Transmogrifier.ValidateTransmogrify()
end

function Transmogrifier.Tooltip(v1,v2)

	local function shortened(text)
		return string.gsub(text,"Interface\\Icons\\","")
	end

	if v1=="Before" then
		if Transmogrifier.Before.name then
			Transmogrifier.Tooltip("Transmogrify From:",shortened(Transmogrifier.Before.texture))
		else
			Transmogrifier.Tooltip("Drop An Item Here","To change an item's icon,\ndrop it here and choose\na new icon.")
		end
	elseif v1=="BnA" then
		local idx = (FauxScrollFrame_GetOffset(TransmogrifierBnAScrollFrame) or 0) + this:GetID()
		Transmogrifier.Tooltip(Transmogrifier.BnA[idx].name,shortened(Transmogrifier.BnA[idx].before).."\n"..shortened(Transmogrifier.BnA[idx].after))
	elseif v1=="After" then
		if Transmogrifier.After then
			Transmogrifier.Tooltip("Transmogrify To:",shortened(Transmogrifier.After))
		end
	elseif v1=="More" then
		Transmogrifier.Tooltip(Transmogrifier.more and "Show Less Icons" or "Show More Icons")
	else
		GameTooltip_SetDefaultAnchor(GameTooltip,UIParent)
		GameTooltip:AddLine(v1)
		GameTooltip:AddLine(v2,.85,.85,.85)
		GameTooltip:Show()
	end
end

-- defines the Before variable and sets the texture to the item or a red ?
-- to wipe it, pass no parameters
function Transmogrifier.DefineBefore(name,texture)

	local before = Transmogrifier.Before

	before.name = name
	before.texture = texture

	if Transmogrified[before.texture] then
		Transmogrifier.DefineAfter(Transmogrified[before.texture][before.name])
	end

	if before.name then
		TransmogrifierBeforeIcon:SetTexture(before.texture)
		TransmogrifierBeforeName:SetText(before.name)
		Transmogrifier.CreateIcons()
	else
		TransmogrifierBeforeIcon:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")
		TransmogrifierBeforeName:SetText("")
		Transmogrifier.numIcons = 0
	end
	Transmogrifier.selectedBnA = ""
	for i=1,Transmogrifier.numBnA do
		if Transmogrifier.BnA[i].name==before.name then
			Transmogrifier.selectedBnA = before.name
		end
	end
	Transmogrifier.BnAUpdate()
	Transmogrifier.ChoiceUpdate()
	TransmogrifierChoiceScrollFrameScrollBar:SetValue(0)
end

function Transmogrifier.DefineAfter(texture)

	Transmogrifier.After = texture
	TransmogrifierAfterIcon:SetTexture(texture and texture or "Interface\\Icons\\INV_Misc_QuestionMark")
end

-- populates .Icons with texture names, starting with the default icon
function Transmogrifier.CreateIcons()

	if Transmogrifier.Before.texture then

		local idx,i,j,done,found = 1
		local prefix -- "Interface\\Icons\\Everything_Before_Number"
		local series -- "01" "02" .. "99"
		local attempt -- "Interface\\Icons\\Entire_Attempted_Texture_01"

		-- first choice is the original icon
		Transmogrifier.Icons[idx] = Transmogrifier.Before.texture
		idx = idx + 1

		if not Transmogrifier.more then
			-- add icons that have the same beginning
			_,_,prefix = string.find(Transmogrifier.Before.texture,".+INV_(%w+)_")
			if prefix then
				for i=1,table.getn(Transmogrifier.AllIcons) do
					if Transmogrifier.Before.texture~=Transmogrifier.AllIcons[i] and string.find(Transmogrifier.AllIcons[i],".+INV_"..prefix) then
						Transmogrifier.Icons[idx] = Transmogrifier.AllIcons[i]
						idx = idx + 1
					end
				end
			end
		else
			for i=1,table.getn(Transmogrifier.AllIcons) do
				if Transmogrifier.Before.texture~=Transmogrifier.AllIcons[i] then
					Transmogrifier.Icons[idx] = Transmogrifier.AllIcons[i]
					idx = idx + 1
				end
			end
		end

		-- if on 1.9 client, add icons not already in the list that are in the series
		if UIParent.GetEffectiveScale then
			-- next choices are the rest of the icons in the series (ie Boots_01 to Boots_52)
			_,_,prefix,series = string.find(Transmogrifier.Before.texture,"(.+)(%d%d)$")
			if prefix and series then
				i = 1
				local textureApplied
				while not done do
					done = 1
					attempt = string.format("%s%02d",prefix,i)
					textureApplied = TransmogrifierChoice1Icon:SetTexture(attempt)
					if (CreateFrame and textureApplied) or (not CreateFrame and TransmogrifierChoice1Icon:GetTexture()~="Solid Texture") then
						found = nil
						for j=1,idx-1 do
							-- see if this icon was already added
							if attempt==Transmogrifier.Icons[j] then
								found = 1 -- this icon was already used
								j = idx -- whimpy break
							end
						end
						if not found then
							-- an actual texture was drawn that hasn't been added, add it to the list
							Transmogrifier.Icons[idx] = attempt
							idx = idx + 1
						end
						if idx<100 then
							-- possibly more, we're not done
							done = nil
							i = i + 1
						end
					end
				end
			end
		end
		Transmogrifier.numIcons = idx-1
	end
end

function Transmogrifier.Transmogrify()
	-- turn Before into After
	local before = Transmogrifier.Before
	local count,i = 0

	Transmogrified.enabled = 1

	if before.texture==Transmogrifier.After then
		-- Untransmogrify!
		if Transmogrified[before.texture] and Transmogrified[before.texture][before.name] then
			Transmogrified[before.texture][before.name] = nil
			for i in Transmogrified[before.texture] do
				count=count+1
			end
			if count==0 then
				-- no more transmogrified versions of this texture?
				Transmogrified[before.texture] = nil
				for i in Transmogrified do
					count = count + 1
				end
				if count==1 then
					-- no more transmogrified textures at all? (.enabled counts as one)
					Transmogrified.enabled = nil
				end
			end
		end
	else
		-- Transmogrify!
		if not Transmogrified[before.texture] then
			Transmogrified[before.texture] = {}
		end
		Transmogrified[before.texture][before.name] = Transmogrifier.After
	end
	Transmogrifier.CreateBnA()
end

--[[ Texture hooks -- here is where the textures are swapped ]]

-- receives name and original texture of an item, returns the texture that should be returned
function Transmogrifier.TransmogrifyThis(name,texture)

	Transmogrifier.realTexture = nil

	if name and texture and Transmogrified[texture] and Transmogrified[texture][name] then
		Transmogrifier.realTexture = texture
		texture = Transmogrified[texture][name]
	end
	return texture
end

-- hook for GetInventoryItemTexture
function Transmogrifier.newGetInventoryItemTexture(player,slot)

	local texture = Transmogrifier.oldGetInventoryItemTexture(player,slot)

	if Transmogrified.enabled then
		local _,_,name = string.find(GetInventoryItemLink(player,slot) or "","%[(.+)%]")
		texture = Transmogrifier.TransmogrifyThis(name,texture)
	end

	return texture
end

-- hook for GetContainerItemInfo
function Transmogrifier.newGetContainerItemInfo(bag,slot)

	local texture,itemCount,locked,quality,readable = Transmogrifier.oldGetContainerItemInfo(bag,slot)
	
	if Transmogrified.enabled then
		local _,_,name = string.find(GetContainerItemLink(bag,slot) or "","%[(.+)%]")
		texture = Transmogrifier.TransmogrifyThis(name,texture)
	end

	return texture,itemCount,locked,quality,readable
end

-- hook for GetActionTexture
function Transmogrifier.newGetActionTexture(slot)

	local texture = Transmogrifier.oldGetActionTexture(slot)

	if Transmogrified.enabled and texture then
		if Transmogrified[texture] then
			-- have to do a tooltip scan, so only run at dire need (when texture potentially needs swapped)
			TransmogrifierScan:SetAction(slot)
			local name = TransmogrifierScanTextLeft1:GetText()
			texture = Transmogrifier.TransmogrifyThis(name,texture)
		end
	end

	return texture
end

-- hook for GetItemInfo 9th return
function Transmogrifier.newGetItemInfo(v1,v2,v3,v4,v5,v6,v7,v8,v9)

	v1,v2,v3,v4,v5,v6,v7,v8,v9 = Transmogrifier.oldGetItemInfo(v1,v2,v3,v4,v5,v6,v7,v8,v9)

	if Transmogrified.enabled then
		v9 = Transmogrifier.TransmogrifyThis(v1,v9)
	end

	return v1,v2,v3,v4,v5,v6,v7,v8,v9
end


function Transmogrifier.CreateBnA()

	local idx,i,j = 1

	for i in Transmogrified do
		if i~="enabled" then
			for j in Transmogrified[i] do
				Transmogrifier.BnA[idx] = Transmogrifier.BnA[idx] or {} -- create if needed
				Transmogrifier.BnA[idx].name = j
				Transmogrifier.BnA[idx].before = i
				Transmogrifier.BnA[idx].after = Transmogrified[i][j]
				idx = idx + 1
			end
		end
	end
	Transmogrifier.BnA[idx] = nil
	Transmogrifier.numBnA = idx-1

	table.sort(Transmogrifier.BnA,function(e1,e2) if e1 and e2 and (e1.name<e2.name) then return true else return false end end)

	Transmogrifier.BnAUpdate()
end

function Transmogrifier.LoadAllIcons()

	-- only do this if we haven't before
	if not Transmogrifier.AllIcons then

		-- this is a representation of all 1500+ INV icons in the default interface.  This function
		-- expands this compressed list to a full list of icons.  The list will only be
		-- expanded when the user opens the transmogrify window, which will be pretty rare.
		local icons = {
			"0102Ammo_Arrow_","0103Ammo_Bullet_","Ammo_FireTar","Ammo_Snowball","0124Axe_","0103Banner_",
			"0102Battery_","0135Belt_","0109Boots_","Boots_Fabric_01","0109Boots_Plate_","Boots_Wolf",
			"0113Boots_Chain_","0116Boots_Cloth_",
			"0104Box_","Box_Birdcage_01","Box_PetCarrier_01","0119Bracer_","0104Cask_","Chest_Chain",
			"0317Chest_Chain_","0159Chest_Cloth_","Chest_Fur","0110Chest_Leather_","0116Chest_Plate",
			"Chest_Samurai","Chest_Wolf","0106Crate_","0102Crown_","0119Drink_","0105Drink_Milk_",
			"0105Egg_","Enchant_DustDream","Enchant_DustIllusion","Enchant_DustSoul","Enchant_DustStrange",
			"Enchant_DustVision","Enchant_EssenceAstralLarge","Enchant_EssenceAstralSmall",
			"Enchant_EssenceEternalLarge","Enchant_EssenceEternalSmall","Enchant_EssenceMagicLarge",
			"Enchant_EssenceMagicSmall","Enchant_EssenceMysticalLarge","Enchant_EssenceMysticalSmall",
			"Enchant_EssenceNetherLarge","Enchant_EssenceNetherSmall","Enchant_ShardBrilliantLarge",
			"Enchant_ShardBrilliantSmall","Enchant_ShardGlimmeringLarge","Enchant_ShardGlimmeringSmall",
			"Enchant_ShardGlowingLarge","Enchant_ShardGlowingSmall","Enchant_ShardRadientLarge",
			"Enchant_ShardRadientSmall","Fabric_FelRag","0103Fabric_Linen_","0103Fabric_Mageweave_",
			"0102Fabric_MoonRag_","0102Fabric_Purple_","0102Fabric_PurpleFire_","0103Fabric_Silk_",
			"0103Fabric_Wool_","0116Feather_","0102Fishingpole_","0132Gauntlets_","0109Gizmo_",
			"Gizmo_BronzeFramework_01","Gizmo_GoblinBoomBox_01","0102Gizmo_MithrilCasing_","0104Gizmo_Pipe_",
			"Gizmo_RocketBoot_01","Gizmo_RocketBoot_Destroyed_02","0125Hammer_","0174Helmet_","0108Ingot_",
			"Ingot_Bronze","Ingot_Eternium","Ingot_Iron","Ingot_Mithril","Ingot_Steel","Ingot_Thorium",
			"0107Jewelry_Amulet_","0126Jewelry_Necklace_","0147Jewelry_Ring_","0114Jewelry_Talisman_",
			"0117Letter_","0124Mace_","0102Mask_","Misc_Ammo_Bullet_01","0106Misc_Ammo_Gunpowder_",
			"0307Misc_ammo_Gunpowder_","0112Misc_ArmorKit_","1420Misc_ArmorKit_","0122Misc_Bag_",
			"Misc_Bag_07_Black","Misc_Bag_07_Blue","Misc_Bag_07_Green","Misc_Bag_07_Red","Misc_Bag_09_Black",
			"Misc_Bag_09_Blue","Misc_Bag_09_Green","Misc_Bag_09_Red","Misc_Bag_10_Black","Misc_Bag_10_Blue",
			"Misc_Bag_10_Green","Misc_Bag_10_Red","0120Misc_Bandage_","Misc_Bandana_01","Misc_Bandana_03",
			"Misc_Bell_01","0102Misc_Birdbeck_","0109Misc_Bomb_","0110Misc_Bone_","Misc_Bone_DwarfSkull_01",
			"Misc_Bone_ElfSkull_01","Misc_Bone_HumanSkull_01","Misc_Bone_OrcSkull_01",
			"Misc_Bone_TaurenSkull_01","0111Misc_Book_","Misc_Bowl_01","Misc_Branch_01","0103Misc_Candle_",
			"0122Misc_Cape_","0115Misc_Coin_","0102Misc_Comb_","0102Misc_Drum_","0102Misc_Dust_",
			"0102Misc_Ear_Human_","0102Misc_Ear_NightElf_","0116Misc_EngGizmos_","Misc_Eye_01","0133Misc_Fish_",
			"0103Misc_Fish_Turtle_","0104Misc_Flower_","Misc_Flute_01","0172Misc_Food_",
			"0102Misc_Food_Wheat_","Misc_Foot_Centaur","Misc_Foot_Kodo","Misc_Fork&Knife","0108Misc_Gear_",
			"0103Misc_Gem_","0103Misc_Gem_Amethyst_","0103Misc_Gem_Bloodstone_","0103Misc_Gem_Crystal_",
			"0103Misc_Gem_Diamond_","0103Misc_Gem_Emerald_","0103Misc_Gem_Opal_","0106Misc_Gem_Pearl_",
			"0103Misc_Gem_Ruby_","0103Misc_Gem_Sapphire_","Misc_Gem_Stone_01","0103Misc_Gem_Topaz_",
			"0102Misc_Gem_Variety_","0105Misc_Gift_","0103Misc_GiftWrap_","Misc_Head_02",
			"Misc_Head_Centaur_01","Misc_Head_Dragon_01","Misc_Head_Dragon_Black","Misc_Head_Dragon_Blue",
			"Misc_Head_Dragon_Green","0102Misc_Head_Dwarf_","0102Misc_Head_Elf_",
			"Misc_Head_Gnoll_01","0102Misc_Head_Gnome_","0102Misc_Head_Human_","Misc_Head_Kobold_01",
			"Misc_Head_Murloc_01","0102Misc_Head_Orc_","Misc_Head_Quillboar_01","Misc_Head_Scourge_01",
			"0102Misc_Head_Tauren_","Misc_Head_Tiger_01","0102Misc_Head_Troll_","0102Misc_Head_Undead_",
			"0119Misc_Herb_","Misc_Herb_BlackLotus","Misc_Herb_DreamFoil","Misc_Herb_IceCap",
			"Misc_Herb_MountainSilverSage","Misc_Herb_PlagueBloom","Misc_Herb_SansamRoot","0103Misc_Horn_",
			"0103Misc_Idol_","0114Misc_Key_","Misc_Lantern_01","0108Misc_LeatherScrap_","Misc_Map_01",
			"0104Misc_MonsterClaw_","Misc_MonsterFang_01","0104Misc_MonsterHead_","0118Misc_MonsterScales_",
			"Misc_MonsterSpiderCarapace_01","0103Misc_MonsterTail_","Misc_Net_01","0106Misc_Note_",
			"0105Misc_Orb_","0106Misc_Organ_","Misc_OrnateBox","0106Misc_Pelt_","0103Misc_Pelt_Bear_",
			"0105Misc_Pelt_Bear_Ruin_","0102Misc_Pelt_Boar_","0103Misc_Pelt_Boar_Ruin_",
			"0102Misc_Pelt_Wolf_","0104Misc_Pelt_Wolf_Ruin_","Misc_Pipe_01","Misc_Platnumdisks",
			"0103Misc_PocketWatch_","Misc_QuestionMark","0110Misc_Quiver_","0102Misc_Root_",
			"0108Misc_Rune_","0102Misc_ScrewDriver_","Misc_ShadowEgg","0104Misc_Shell_","0102Misc_Shovel_",
			"Misc_Slime_01","0103Misc_Spyglass_","0111Misc_StoneTablet_","Misc_TheGoldenCheep",
			"Misc_Ticket_Darkmoon_01","Misc_Ticket_Tarot_Beasts_01","Misc_Ticket_Tarot_BlueDragon_01",
			"Misc_Urn_01","0102Misc_Wrench_","0113Mushroom_","0104Musket_","0102Ore_Arcanite_",
			"Ore_Copper_01","Ore_Iron_01","0102Ore_Mithril_","0102Ore_Thorium_","Ore_Tin_01",
			"Ore_TrueSilver_01","0114Pants_","0121Pants_Plate_","Pants_Wolf","0103Pick_","Pick_05","Poison_MindNumbing",
			"0197Potion_","0110Scroll_","0121Shield_","0117Shirt_","Shirt_Black_01","Shirt_Blue_01",
			"Shirt_Green_01","Shirt_Grey_01","Shirt_GuildTabard_01","Shirt_Orange_01",
			"Shirt_Purple_01","Shirt_Red_01","Shirt_White_01","Shirt_Yellow_01","0131Shoulder_",
			"0108Spear_","0132Staff_","Staff_Goldfeathered_01","0116Stone_","0105Stone_GrindingStone_",
			"0105Stone_SharpeningStone_","0105Stone_WeightStone_","0148Sword_","0106ThrowingAxe_",
			"0105ThrowingKnife_","Torch_Lit","Torch_Unlit","0103TradeskillItem_","0112Wand_",
			"0112Weapon_Bow_","0110Weapon_Crossbow_","0211Weapon_Halberd_","0109Weapon_Rifle_",
			"0127Weapon_ShortBlade_"
		}

		local i,j,iStart,iEnd

		Transmogrifier.AllIcons = {}

		-- unpack the icons into a numerically-indexed table
		for i=1,table.getn(icons) do
			_,_,iStart,iEnd,series = string.find(icons[i],"^(%d%d)(%d%d)(.+)$")
			if iStart then
				-- this icon is in a series, add that series
				for j=iStart,iEnd do
					table.insert(Transmogrifier.AllIcons,"Interface\\Icons\\INV_"..string.format("%s%02d",series,j))
				end
			else
				-- this icon is not in a series, add the plain icon
				table.insert(Transmogrifier.AllIcons,"Interface\\Icons\\INV_"..icons[i])
			end
		end

		for i=1,GetNumMacroIcons() do
			table.insert(Transmogrifier.AllIcons,GetMacroIconInfo(i))
		end

	end
end


-- returns the texture and name of whatever is on cursor, method by Danile on wow forums
function Transmogrifier.GetCursor()
	local inv,bag,slot = Transmogrifier.FindLockedItem()
	local link = (inv and GetInventoryItemLink("player",inv)) or (bag and GetContainerItemLink(bag,slot))
	_,_,link = string.find(link or "","(item:%d+:%d+:%d+:%d+)")
	local name,_,_,_,_,_,_,_,texture = GetItemInfo(link or "")
	if name then
		return texture,name
	end
end

-- returns inv,bag,slot of the first locked item it finds
function Transmogrifier.FindLockedItem()

	if not CursorHasItem() then
		return -- no item is on the cursor
	end

	local isLocked
	for i=0,23 do
		if IsInventoryItemLocked(i) then
			return i,nil,nil
		end
	end

	local bagStart, bagEnd = 0,4
	if BankFrame:IsVisible() then
		-- bank open, expand search to bank too
		bagStart, bagEnd = -1, 10
	end

	for bag=bagStart,bagEnd do
		for slot=1,GetContainerNumSlots(bag) do
			_,_,isLocked = GetContainerItemInfo(bag,slot)
			if isLocked then
				return nil,bag,slot
			end
		end
	end
end

-- drops whatever is on cursor by dropping it onto an empty spell slot
function Transmogrifier.ClearCursor()
	if CursorHasItem() then
		local i,spell=1,1
		while spell do
			spell = GetSpellName(i,BOOKTYPE_SPELL)
			i=i+1
		end
		PickupSpell(i,BOOKTYPE_SPELL)
	end
end

collectgarbage() -- remove
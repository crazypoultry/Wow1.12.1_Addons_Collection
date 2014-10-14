--Profession_Helper.lua
global_mat_table = {}
global_num_table = {}

function Profession_Helper_OnLoad()
	SlashCmdList["PROFESSIONHELPER"] = Profession_Helper_SlashCommand
	SLASH_PROFESSIONHELPER1 = "/profession_helper"
	SLASH_PROFESSIONHELPER2 = "/ph"
	this:RegisterForDrag("LeftButton")
	Profession_HelperWordItemName:SetText("Nothing Selected Yet")
	--Bad hack to get my buttont looking good
	Profession_HelperRefreshButton:SetTextFontObject("GameFontHighlightSmall")
	Profession_HelperRefreshButton:SetHighlightFontObject("GameFontHighlightSmall")
	Profession_HelperRefreshButton:SetTextColor(1.0, .82, 0)
	--End of bad hack
	DEFAULT_CHAT_FRAME:AddMessage("Profession Helper loaded. Use /ph to display it.")
end

function Profession_Helper_SlashCommand(msg)
	Profession_Helper_Toggle()
end

function Profession_HelperSendDropDown_OnLoad()
	UIDropDownMenu_Initialize(this, Profession_HelperSendDropDown_Initialize)
end

function Profession_HelperSendDropDown_OnShow()
	UIDropDownMenu_Initialize(this, Profession_HelperSendDropDown_Initialize)
	UIDropDownMenu_SetSelectedID(Profession_HelperSendDropDown, 1)
	UIDropDownMenu_SetSelectedValue(Profession_HelperSendDropDown, PH_GUILD)
end

function Profession_HelperSendDropDown_Initialize()
	info       = {}
	info.text  = PH_GUILD
	info.value = PH_GUILD
	info.func  = Profession_HelperSendDropDown_OnClick
	UIDropDownMenu_AddButton(info)

	info       = {}
	info.text  = PH_PARTY
	info.value = PH_PARTY
	info.func  = Profession_HelperSendDropDown_OnClick
	UIDropDownMenu_AddButton(info)

	info       = {}
	info.text  = PH_RAID
	info.value = PH_RAID
	info.func  = Profession_HelperSendDropDown_OnClick
	UIDropDownMenu_AddButton(info)

	info       = {}
	info.text  = PH_PLAYER
	info.value = PH_PLAYER
	info.func  = Profession_HelperSendDropDown_OnClick
	UIDropDownMenu_AddButton(info)

	info       = {}
	info.text  = PH_CHANNEL
	info.value = PH_CHANNEL
	info.func  = Profession_HelperSendDropDown_OnClick
	UIDropDownMenu_AddButton(info)
end

function Profession_HelperSendDropDown_OnClick()
	UIDropDownMenu_SetSelectedID(Profession_HelperSendDropDown, this:GetID())
	UIDropDownMenu_SetSelectedValue(Profession_HelperSendDropDown, this:GetText())
end

function Profession_Helper_Toggle()
	if(Profession_HelperFrame:IsVisible()) then
		Profession_HelperFrame:Hide()
	else
		Profession_HelperFrame:Show()
	end
end

function getMats()
	matTable = {}
	numTable = {}
	formatTable = {}


	if(GetCraftName() == PH_ENCHANTING) then
		i = GetCraftSelectionIndex()
		if(i == 0) then
			return
		end
		item_link = GetCraftItemLink(i)
		item_name = GetCraftInfo(i)
		tinsert(matTable, item_link)
		tinsert(numTable, 1)
		reagent_num = GetCraftNumReagents(i)
		for j = 1, reagent_num, 1 do
			reagentName, a2, reagentCount, playerReagentCount = GetCraftReagentInfo(i, j)
			reagent_link = GetCraftReagentItemLink(i, j)
			tinsert(matTable, reagent_link)
			tinsert(numTable, reagentCount)
		end
	else
		i=GetTradeSkillSelectionIndex()
		if(i == 0) then
			return
		end
		item_link = GetTradeSkillItemLink(i)
		item_name = GetTradeSkillInfo(i)
		tinsert(matTable, item_link)
		item_min, item_max = GetTradeSkillNumMade(i)
		if(item_min == item_max) then
			tinsert(numTable, item_min)
		else
			item_min = item_min .. "-" .. item_max
			tinsert(numTable, item_min)
		end
		reagent_num = GetTradeSkillNumReagents(i)
		for j = 1, reagent_num, 1 do
			reagentName, a2, reagentCount, playerReagentCount = GetTradeSkillReagentInfo(i, j)
			reagent_link = GetTradeSkillReagentItemLink(i, j)
			tinsert(matTable, reagent_link)
			tinsert(numTable, reagentCount)
		end
	end
	global_num_table = numTable
	global_mat_table = matTable
	Profession_HelperWordItemName:SetText(item_name)
end

function tellMats(type, lang, who)
	numTable = global_num_table
	matTable = global_mat_table
	lang = nil

	if (Profession_HelperWordItemName:GetText() == "Nothing Selected Yet") then
		message("Choose a craftable item, then press 'Set'.")
		return
	end

	numToMake = Profession_HelperWordAmountNumber:GetText()
	formatTable = {}

	for j in matTable do
		if (j == 1) then
			number = numTable[j] * numToMake
			toSend = PH_BUILD_GETMAT_SENTENCE_START .. number
			toSend = toSend .. "x" ..  matTable[j] .. PH_BUILD_GETMAT_SENTENCE_END
		else
			number = numTable[j] * numToMake
			toSend = number .. "x" .. matTable[j]
		end
		tinsert(formatTable, toSend)
	end

	if(UIDropDownMenu_GetSelectedValue(Profession_HelperSendDropDown) == PH_GUILD) then
		type = "GUILD"
		who = nil
	end
	if(UIDropDownMenu_GetSelectedValue(Profession_HelperSendDropDown) == PH_RAID) then
		type = "RAID"
		who = nil
	end
	if(UIDropDownMenu_GetSelectedValue(Profession_HelperSendDropDown) == PH_PARTY) then
		type = "PARTY"
		who = nil
	end
	if(UIDropDownMenu_GetSelectedValue(Profession_HelperSendDropDown) == PH_PLAYER) then
		type = "WHISPER"
		who = Profession_HelperNameBox:GetText()
		if(who == "") then
			message("Please enter a player name in the box.")
			return
		end
	end
	if(UIDropDownMenu_GetSelectedValue(Profession_HelperSendDropDown) == PH_CHANNEL) then
		type = "CHANNEL"
		who = Profession_HelperNameBox:GetText()
		if(who == "") then
			message("Please enter a channel number in the box.")
			return
		end
	end

	for i in formatTable do
		SendChatMessage(formatTable[i], type, lang, who)
	end
end

function Profession_Helper_OnDragStart()
   Profession_HelperFrame:StartMoving()
end

function Profession_Helper_OnDragStop()
   Profession_HelperFrame:StopMovingOrSizing()
end

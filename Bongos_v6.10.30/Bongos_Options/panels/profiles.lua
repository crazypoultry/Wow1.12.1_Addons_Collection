StaticPopupDialogs["BONGOS_OPTIONS_SAVE_PROFILE"] = {
	text = TEXT(BONGOS_OPTIONS_PROFILE_ENTER_NAME),
	button1 = TEXT(ACCEPT),
	button2 = TEXT(CANCEL),
	hasEditBox = 1,
	maxLetters = 24,
	OnAccept = function()
		local text = getglobal(this:GetParent():GetName().."EditBox"):GetText()
		if text ~= "" then
			BProfile.Save(text)
			BOptionsProfilesScrollBar_Update()
		end
	end,
	EditBoxOnEnterPressed = function()
		local text = getglobal(this:GetParent():GetName().."EditBox"):GetText()
		if text ~= "" then
			BProfile.Save(text)
			BOptionsProfilesScrollBar_Update()
		end
	end,
	OnShow = function()
		getglobal(this:GetName().."EditBox"):SetFocus()
		getglobal(this:GetName().."EditBox"):SetText(UnitName("player"))
		getglobal(this:GetName().."EditBox"):HighlightText()
	end,
	OnHide = function()
		if ChatFrameEditBox:IsVisible() then
			ChatFrameEditBox:SetFocus()
		end
		getglobal(this:GetName().."EditBox"):SetText("")
	end,
	timeout = 0,
	exclusive = 1,
	hideOnEscape = 1
}


local listSize = 14
local selectedButton

--[[ Profile Button ]]--

function BOptionsProfileButton_OnClick(clickedButton)
	for i = 1, listSize do
		local button = getglobal("BongosOptionsPanelProfiles".. i)
		if clickedButton ~= button then
			button:UnlockHighlight()
		else
			button:LockHighlight()
		end
	end
	selectedButton = clickedButton
end

function BOptionsProfilesButton_OnMousewheel(scrollframe, direction)
	local scrollbar = getglobal(scrollframe:GetName() .. "ScrollBar")
	scrollbar:SetValue(scrollbar:GetValue() - direction * (scrollbar:GetHeight() / 2))
	BOptionsProfilesScrollBar_Update()
end

--[[ Profile Actions ]]--
function BOptionsProfiles_SaveProfile()
	StaticPopup_Show("BONGOS_OPTIONS_SAVE_PROFILE")
end

function BOptionsProfiles_LoadProfile()
	if selectedButton then
		BProfile.Load(selectedButton:GetText())
		BOptionsProfilesScrollBar_Update()
	end
end

--delete
function BOptionsProfiles_DeleteProfile()
	if selectedButton then
		BProfile.Delete(selectedButton:GetText())
		BOptionsProfilesScrollBar_Update()
	end
end

--set default
function BOptionsProfiles_SetDefaultProfile()
	if selectedButton then
		BProfile.SetDefault(selectedButton:GetText())
		BOptionsProfilesScrollBar_Update()
	end
end

--[[ Scroll Bar Functions ]]--
function BOptionsProfiles_OnLoad()
	local thisName = this:GetName()
	local i = 1
	local size = 19

	local button = CreateFrame("Button", thisName .. i, this, "BongosOptionsProfileButton")
	button:SetPoint("TOPLEFT", this, "TOPLEFT", 4, -4)
	button:SetPoint("BOTTOMRIGHT", thisName .. "ScrollFrame", "TOPLEFT", -24, -20)
	button:SetID(i)

	for i = 2, listSize do
		button = CreateFrame("Button", thisName .. i, this, "BongosOptionsProfileButton")
		button:SetPoint("TOPLEFT", thisName .. i-1, "BOTTOMLEFT", 0, -1)
		button:SetPoint("BOTTOMRIGHT", thisName .. i-1, "BOTTOMRIGHT", 0, -size)
		button:SetID(i)
	end
end

function BOptionsProfiles_OnShow()
	BOptionsProfilesScrollBar_Update()
end

function BOptionsProfilesScrollBar_Update(parentName)
	--update list if there are changes
	local list = {}
	if BongosProfiles then
		for name in pairs(BongosProfiles) do
			if name ~= "default" then
				table.insert(list, name)
			end
		end
	end
	table.sort(list)

	local size = table.getn(list)
	local offset = BongosOptionsPanelProfilesScrollFrame.offset
	local defaultName = BProfile.GetDefault()

	FauxScrollFrame_Update(BongosOptionsPanelProfilesScrollFrame, size, listSize, listSize)

	for index = 1, listSize do
		local rIndex = index + offset
		local button = getglobal("BongosOptionsPanelProfiles".. index)

		if rIndex <= size then
			button:SetText(list[rIndex])
			if defaultName == list[rIndex] then
				button:SetTextColor(0, 1, 0)
			else
				button:SetTextColor(1, 0.82, 0)
			end
			button:Show()
		else
			button:Hide()
		end
	end
end
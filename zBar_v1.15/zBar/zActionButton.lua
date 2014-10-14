--~ zBar Button OnX
function zActionButton_OnLoad()
	ActionButton_OnLoad()
	this.isZButton = 1
end
function zActionButton_OnEvent()
	if this:IsVisible() or event == "UPDATE_BINDINGS" 
		or (not this.hide and event == "ACTIONBAR_SLOT_CHANGED")
		or event == "ACTIONBAR_SHOWGRID"
		or event == "ACTIONBAR_HIDEGRID" then
		ActionButton_OnEvent(event)
		if this.isBonus then
			BonusActionButton_OnEvent(event)
		end
	end
end
function zActionButton_OnEnter()
	zBar_SetAlpha(1,this:GetParent())
	ActionButton_SetTooltip()
end
function zActionButton_OnLeave()
	zBar_SetAlpha(0.3,this:GetParent())
	this.updateTooltip = nil
	GameTooltip:Hide()
end

--[[ Overridens ]]
function zActionButton() -- override when load up

--~ id
local zOld_ActionButton_GetPagedID = ActionButton_GetPagedID
function ActionButton_GetPagedID(button)
	-- switch zBar2 with Main bar for warrior class
	if ZBAR_IS_WARRIOR and button:GetParent() == zBar2 then
		return button:GetID()
	end
	-- id for zBar buttons
	if ( button.isZButton ) then
		return (button:GetID() + ((10 - button:GetParent():GetID()) * NUM_ACTIONBAR_BUTTONS))
	end
	-- other buttons
	return zOld_ActionButton_GetPagedID(button)
end

-- grid
function ActionButton_ShowGrid(button)
	if ( not button ) then
		button = this
	end
	button.showgrid = 1
	getglobal(button:GetName().."NormalTexture"):SetVertexColor(1.0, 1.0, 1.0, 0.5)
	
	if button.hide == 1 then
		button:Hide()
		return
	end
	
	button:Show()
end
function ActionButton_HideGrid(button)
	if (ALWAYS_SHOW_MULTIBARS == "1" or ALWAYS_SHOW_MULTIBARS == 1) then return end
	if ( not button ) then
		button = this
	end
	button.showgrid = 0
	
	if button.hide == 1 then
		button:Hide()
		return
	end
		
	if ( not HasAction(ActionButton_GetPagedID(button)) ) then
		button:Hide()
	elseif not button:IsVisible() then
		button:Show()
	end
end
function zBar_SetAllGrids(showGrid)
	for id in zBar.Bars do
		if id < 11 then zBar_UpdateButtons(getglobal(ZBARS[id]),nil,nil,showGrid) end
	end
end
local zOld_MultiActionBar_ShowAllGrids = MultiActionBar_ShowAllGrids
local zOld_MultiActionBar_HideAllGrids = MultiActionBar_HideAllGrids
function MultiActionBar_ShowAllGrids()
	zOld_MultiActionBar_ShowAllGrids()
	zBar_SetAllGrids(1)
end
function MultiActionBar_HideAllGrids()
	zOld_MultiActionBar_HideAllGrids()
	zBar_SetAllGrids(0)
end

--~ hotkeys
local zOld_GetBindingKey = GetBindingKey
function GetBindingKey(action)
	if (this.isZButton) then action = "ACTIONBUTTON"..ActionButton_GetPagedID(this) end
	return zOld_GetBindingKey(action)
end

--~ bindings
function zBar_OnHotkey(barid,id)
	if ( keystate == "down" ) then
		MultiActionButtonDown("zBar"..barid, id)
	else
		MultiActionButtonUp("zBar"..barid, id, onSelf)
	end
end
end -- zActionButton
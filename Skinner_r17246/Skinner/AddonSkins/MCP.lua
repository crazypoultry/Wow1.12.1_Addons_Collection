
function Skinner:MCP()
	if self.initialized.MCP then return end
	self.initialized.MCP = true

	if not self:isVersion("MCP", { "2006.07.22", "2006.08.28", "2006.09.06" }, MCP_VERSION) then return end
	
	if _G["MCPAddonSetDropDown"] then 
		-- Rophy's version on the SVN
		self:hookDDScript(MCPAddonSetDropDownButton)
		self:keepRegions(_G["MCPAddonSetDropDown"], {4}) -- N.B. region 4 is text
		self:moveObject(_G["MCPAddonSetDropDown"], nil, nil, "-", 13)
		self:moveObject(_G["MCP_AddonListDisableAll"], nil, nil, nil, nil)
		self:moveObject(_G["MCP_AddonListEnableAll"], nil, nil, nil, nil)
		self:moveObject(_G["MCP_AddonListSaveSet"], nil, nil, "-", 10)
		self:moveObject(_G["MCP_AddonList_ReloadUI"], nil, nil, "-", 10)
	else
		-- standard version from Curse
		self:hookDDScript(MCP_AddonList_ProfileSelectionButton)	
		self:keepRegions(_G["MCP_AddonList_ProfileSelection"], {4}) -- N.B. region 4 is text
		self:moveObject(_G["MCP_AddonList_ProfileSelection"], nil, nil, "-", 13)
		self:moveObject(_G["MCP_AddonList_EnableAll"], "+", 30, "+", 5)
		self:moveObject(_G["MCP_AddonList_DisableAll"], "+", 30, "+", 5)
		self:moveObject(_G["MCP_AddonList_SaveProfile"], "+", 40, "-", 10)
		self:moveObject(_G["MCP_AddonList_DeleteProfile"], "+", 40, "-", 10)
		self:moveObject(_G["MCP_AddonList_ReloadUI"], "+", 30, "+", 5)
	end
	
	-- change the scale to match other frames
	_G["MCP_AddonList"]:SetScale(_G["GameMenuFrame"]:GetEffectiveScale())
	
	self:keepRegions(_G["MCP_AddonList"], {8}) -- N.B. region 8 is the title
	_G["MCP_AddonList"]:SetWidth(_G["MCP_AddonList"]:GetWidth() * FxMult)
	_G["MCP_AddonList"]:SetHeight(_G["MCP_AddonList"]:GetHeight() * FyMult)

	-- resize the frame's children to match the frame size
	for k, v in pairs({ _G["MCP_AddonList"]:GetChildren() }) do
		v:SetWidth(v:GetWidth() * FxMult)
		v:SetHeight(v:GetHeight() * FyMult)
	end
	
	self:moveObject(_G["MCP_AddonListCloseButton"], "+", 40, nil, nil)
	self:moveObject(_G["MCP_AddonListEntry1"], nil, nil, "+", 10)
	self:removeRegions(_G["MCP_AddonList_ScrollFrame"])
	self:moveObject(_G["MCP_AddonList_ScrollFrame"], "+", 26, "+", 7)
	_G["MCP_AddonList_ScrollFrame"]:SetHeight(_G["MCP_AddonList_ScrollFrame"]:GetHeight() + 10)
	self:skinScrollBar(_G["MCP_AddonList_ScrollFrame"])
	
	self:applySkin(_G["MCP_AddonList"], true)
		
end

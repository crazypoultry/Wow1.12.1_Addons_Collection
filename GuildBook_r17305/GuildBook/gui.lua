
if (not GuildBook) then GuildBook = {} end

local _currentPath = nil
local _currentNode = nil
local _resetForward = false
local _backPath = {}
local _forwardPath = {}
local _tmpPath = {}
local _defaultNode = {
	['name'] = 'Set Name',
	['tagline'] = 'Set tagline',
	['content'] = '<H1>Set Content</H1>',
}
local _roots = {}
StaticPopupDialogs["GUILDBOOKCONFIRM"] = { 
	text = "Delete this page?", 
	button1 = "Yes", 
	button2 = "No", 
	timeout = 0, 
	whileDead = 1, 
	OnAccept = function() 
		GuildBook.RemData(_currentNode)
		-- change to the previous location
		_currentPath = table.remove(_backPath)
		_currentNode = GuildBook.TraverseTreePath(_currentPath)
		GuildBook.UpdateHTMLFrame()
	end
}

function GuildBook.Tooltip()
	local which = this:GetName()
	if (GuildBook.Buttons and GuildBook.Buttons[which]) then
		GameTooltip_SetDefaultAnchor(GameTooltip,UIParent)
		GameTooltip:AddLine(GuildBook.Buttons[which][1])
		GameTooltip:AddLine(GuildBook.Buttons[which][2],.85,.85,.85,1)
		GameTooltip:Show()
	end
end

-- Titlebar button clicks
function GuildBook.OnClick()

	local which = this:GetName()

	if which=="GuildBookNew" then
		GuildBook.EditNode()
	elseif which=="GuildBookDelete" then
		if not IsShiftKeyDown() then
			StaticPopup_Show("GUILDBOOKCONFIRM")
		else
			GuildBook.RemData(_currentNode) -- delete empty pages without confirmation
			-- change to the previous location
			_currentPath = table.remove(_backPath)
			_currentNode = GuildBook.TraverseTreePath(_currentPath)
		end
		GuildBook.UpdateHTMLFrame()
	elseif which == "GuildBookEdit" then
		GuildBook.EditNode(_currentNode)
	elseif which == 'GuildBookEditClose' then
		GuildBookFrameEditFrame:Hide()
	elseif which == 'GuildBookUndo' then
		GuildBook.EditNode(_currentNode)
	elseif which == 'GuildBookSave' then
		if (not GuildBookEditBox.name) then -- we added a new node
			GuildBook.AddData(GuildBookFrameNameBox:GetText(),GuildBookFrameTaglineBox:GetText(),GuildBookEditBox:GetText(),_currentNode)
			table.insert(_backPath,_currentPath)
			_currentPath = _currentPath..'>'..GuildBookFrameNameBox:GetText()
		elseif (GuildBook.ValidateContent(GuildBookEditBox:GetText())) then
			if (GuildBookEditBox.name ~= GuildBookFrameNameBox:GetText()) then
				GuildBook.ModifyData(_currentNode,GuildBookFrameNameBox:GetText(),GuildBookFrameTaglineBox:GetText(),GuildBookEditBox:GetText(),UnitName('player'),time())
				_currentPath = string.gsub(_currentPath,'(.+>)'..GuildBookEditBox.name,'%1'..GuildBookFrameNameBox:GetText())
				_currentNode = GuildBook.TraverseTreePath(_currentPath)
			else
				GuildBook.ModifyData(_currentNode,nil,GuildBookFrameTaglineBox:GetText(),GuildBookEditBox:GetText(),UnitName('player'),time())
			end
		end
		if (_resetForward) then
			for k,vi in pairs(_forwardPath) do
				_forwardPath[k] = nil
			end
			--table.setn(_forwardPath,0)
			_resetForward = false
		end
		GuildBookFrameEditFrame:Hide()
		GuildBook.UpdateHTMLFrame()
	elseif which=="GuildBookClose" then
		GuildBookFrame:Hide()
	elseif which=="GuildBookFramePin" then
		GuildBookFrame.lock = not GuildBookFrame.lock
		GuildBook.UpdateLock()
	elseif which=="GuildBookFont" then
		GuildBookOptions['frame'].Font = GuildBookSettings.Font+1
		GuildBook.UpdateFont()
	elseif which=='GuildBookBackButton' then
		_tmpPath = table.remove(_backPath)
		if (GuildBook.TraverseTreePath(_tmpPath)) then
			table.insert(_forwardPath,_currentPath)
			_currentPath = _tmpPath
			GuildBook.UpdateHTMLFrame()
		end
	elseif which == "GuildBookUpButton" then
		table.insert(_backPath,_currentPath)
		_,_,_currentPath = string.find(_currentPath,'^(.+)>.-$')
		GuildBook.UpdateHTMLFrame()
	elseif which=='GuildBookForwardButton' then
		_tmpPath = table.remove(_forwardPath)
		if (GuildBook.TraverseTreePath(_tmpPath)) then
			table.insert(_backPath,_currentPath)
			_currentPath = _tmpPath
			GuildBook.UpdateHTMLFrame()
		end
	end
end

function GuildBook.EditNode(node)
	GuildBookEditBox.content = (node and node['content']) or '<H1>Set Content</H1>'
	GuildBookEditBox.name = (node and node['name']) or nil
	GuildBookEditBox.tagline = (node and node['tagline']) or nil
	if (not node) then 
		node = _defaultNode 
		_resetForward = true
	end
	GuildBookEditBox:SetText(node['content'] or '<H1>Set Content</H1>')
	GuildBookFrameNameBox:SetText(node['name'] or 'Set Name')
	GuildBookFrameTaglineBox:SetText(node['tagline'] or 'Set Tagline')
	GuildBookUndo:Disable()
	SetDesaturation(GuildBookUndo:GetNormalTexture(),true)
	GuildBookUndo:SetAlpha(0.5)
	GuildBookFrameEditFrame:Show()
	GuildBookEditBox:SetWidth(GuildBookFrameEditFrame:GetWidth()-50)
	GuildBookFrameTaglineBoxFrame:SetWidth(GuildBookFrameEditFrame:GetWidth()-175)
	GuildBookFrameTaglineBox:SetWidth(GuildBookFrameEditFrame:GetWidth()-185)
end

function GuildBook.OnShow()
	if (GuildBook.canEdit) then
		GuildBookNew:Show()
		GuildBookDelete:Show()
	else
		GuildBookNew:Hide()
		GuildBookDelete:Hide()
	end
	GuildBookHTMLContent:SetWidth(GuildBookFrame:GetWidth()-50)
	GuildBook.UpdateHTMLFrame()
end

function GuildBook.UpdateHTMLFrame()
	_currentNode = GuildBook.TraverseTreePath(_currentPath)
	if (not _currentNode) then GuildBook.Error('UpdateHTMLFrame','Couldn\'t find the current node, aborting') return end
	if (not _currentPath) then _currentPath = GuildBook.GetTreePath(_currentNode) end
	local text = GuildBook.GetContent(_currentNode)
	GuildBookKB.currentPath = _currentPath
	GuildBookHTMLContent:SetText(text)
	GuildBookFramePath:SetText(_currentPath)
	if (table.getn(_backPath) > 0) then
		if (not GuildBookBackButton.isEnabled) then 
			GuildBookBackButton:Enable() 
			SetDesaturation(GuildBookBackButton:GetNormalTexture(),false)
			GuildBookBackButton:SetAlpha(1)
			GuildBookBackButton.isEnabled = true
		end
	else 
		GuildBookBackButton:Disable() 
		SetDesaturation(GuildBookBackButton:GetNormalTexture(),true)
		GuildBookBackButton:SetAlpha(.5)
		GuildBookBackButton.isEnabled = false
	end
	if (table.getn(_forwardPath) > 0) then
		if (not GuildBookForwardButton.isEnabled) then 
			GuildBookForwardButton:Enable() 
			SetDesaturation(GuildBookForwardButton:GetNormalTexture(),false)
			GuildBookForwardButton:SetAlpha(1)
			GuildBookForwardButton.isEnabled = true
		end
	else 
		GuildBookForwardButton:Disable() 
		SetDesaturation(GuildBookForwardButton:GetNormalTexture(),true)
		GuildBookForwardButton:SetAlpha(.5)
		GuildBookForwardButton.isEnabled = false
	end
	if (_currentPath ~= "GuildBookKB") then
		if (not GuildBookUpButton.isEnabled) then
			GuildBookUpButton:Enable() 
			SetDesaturation(GuildBookUpButton:GetNormalTexture(),false)
			GuildBookUpButton:SetAlpha(1)
			GuildBookUpButton.isEnabled = true
		end
	else
		if (GuildBookUpButton.isEnabled) then 
			GuildBookUpButton:Disable() 
			GuildBookUpButton.isEnabled = false
			SetDesaturation(GuildBookUpButton:GetNormalTexture(),true)
			GuildBookUpButton:SetAlpha(.5)
		end
	end

	GuildBookHTMLContent:GetParent():UpdateScrollChildRect()
	local scrollBar = getglobal(GuildBookHTMLContent:GetParent():GetName().."ScrollBar")
	local min, max = scrollBar:GetMinMaxValues()
	if ( max > 0 and (this.max ~= max) ) then
		this.max = max
		scrollBar:SetValue(max)
	end
	if (not GuildBook.NameCanDelete(GuildBook.playerName,_currentNode)) then GuildBookDelete:Hide() else GuildBookDelete:Show() end
	if (not GuildBook.NameCanEdit(GuildBook.playerName,_currentNode)) then 
		GuildBookNew:Hide()
		GuildBookEdit:Hide()
	else 
		GuildBookEdit:Show()
		GuildBookNew:Show()
	end
end

function GuildBook.HyperLinkClicked(linkID)
	table.insert(_backPath,_currentPath)
	if (not string.find(linkID,'^GuildBookKB>')) then
		_currentPath = _currentPath..'>'..linkID
	else
		_currentPath = linkID
	end
	-- reset the forward links on a hyperlink click
	for k,vi in pairs(_forwardPath) do
		_forwardPath[k] = nil
	end
	--table.setn(_forwardPath,0)
	GuildBook.UpdateHTMLFrame()
end

-- changes border and resize grip depending on lock status
function GuildBook.UpdateLock()
	if GuildBookFrame.lock then
		GuildBookFramePin:SetNormalTexture("Interface/Addons/GuildBook/buttons/pinned.tga")
		GuildBookFrame:SetBackdropBorderColor(0,0,0,1)
		GuildBookFrameResizeGrip:Hide()
	else
		GuildBookFramePin:SetNormalTexture("Interface/Addons/GuildBook/buttons/pin.tga")
		GuildBookFrame:SetBackdropBorderColor(1,1,1,1)
		GuildBookFrameResizeGrip:Show()
	end
end

function GuildBook.OnTextChanged()
	if (this:GetName() == "GulidBookEditBox") then
		local scrollBar = getglobal(this:GetParent():GetName().."ScrollBar")
		this:GetParent():UpdateScrollChildRect()
		local min, max = scrollBar:GetMinMaxValues()
		if ( max > 0 and (this.max ~= max) ) then
			this.max = max
			scrollBar:SetValue(max)
		end
	end
	 if (GuildBookEditBox:GetText() ~= GuildBookEditBox.content or 
		 GuildBookFrameNameBox:GetText() ~= GuildBookEditBox.name or
		 GuildBookFrameTaglineBox:GetText() ~= GuildBookEditBox.tagline) then
		SetDesaturation(GuildBookUndo:GetNormalTexture(),false)
		GuildBookUndo:Enable()
		GuildBookUndo:SetAlpha(1)
	 else
		GuildBookUndo:Disable()
		SetDesaturation(GuildBookUndo:GetNormalTexture(),true)
		GuildBookUndo:SetAlpha(0.5)
	 end
end

function GuildBook.ResetRoot()
	_currentNode = GuildBookKB
	_backPath = {}
	_forwardPath = {}
	GuildBook.UpdateHTMLFrame()
end

function GuildBook.RestoreCurrentPath(path)
	_currentPath = path
	GuildBook.UpdateHTMLFrame()
end

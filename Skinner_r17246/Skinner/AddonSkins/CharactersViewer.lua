
function Skinner:CharactersViewer()
	if not self.db.profile.CharacterFrames then return end

	if not self:isVersion("CharactersViewer", { 103, 273 }, CharactersViewer.version.number) then return end
	                                       
	if CharactersViewer.version.number == 103 then
-->>-- version 1.03
		self:hookDDScript(_G["CharactersViewerDropDownButton"])
		self:hookDDScript(_G["CharactersViewerDropDown2Button"])

		self:keepRegions(_G["CharactersViewerDropDown"], {4}) -- N.B. region 4 is text
		self:keepRegions(_G["CharactersViewerDropDown2"], {4}) -- N.B. region 4 is text
		self:moveObject(_G["CharactersViewerDropDown2"], "-", 10, "-", 14)
		self:removeRegions(_G["CharactersViewer_Frame"], {1, 2, 3, 4, 5}) -- N.B. other regions are text
		_G["CharactersViewer_Frame"]:SetWidth(_G["CharactersViewer_Frame"]:GetWidth() * FxMult)
		_G["CharactersViewer_Frame"]:SetHeight(_G["CharactersViewer_Frame"]:GetHeight() * FyMult)
		self:moveObject(_G["CharactersViewer_FrameTitleText"], nil, nil, "-", 30)
		self:moveObject(_G["CharactersViewer_RestedFrame"], "-", 20, "+", 30)
		self:moveObject(_G["CharactersViewer_FrameDetailTitle0"], "-", 10, nil, nil)
		self:moveObject(_G["CharactersViewer_FrameDetailText0"], "-", 30, nil, nil)
		self:moveObject(_G["CharactersViewer_FrameStatsTitle1"], "-", 10, "+", 20)
		self:moveObject(_G["CharactersViewer_CloseButton"], "+", 28, "+", 8)
		self:moveObject(_G["CharactersViewer_FrameItem1"], "-", 8, "+", 20)
		self:moveObject(_G["CharactersViewer_FrameItem10"], "+", 30, "+", 20)
		self:moveObject(_G["CharactersViewer_FrameItem16"], "-", 10, nil, nil)
		self:moveObject(_G["CharactersViewerResistanceFrame"], "-", 10, "+", 20)
		self:moveObject(_G["CharactersViewerDropDown"], "-", 10, "-", 14)
		self:moveObject(_G["CharactersViewer_MoneyFrame"], "+", 30, "-", 80)
		self:applySkin(_G["CharactersViewer_Frame"])

		for i = 0, 4 do
			bagName = _G["CharactersViewer_ContainerFrame"..i]
			self:keepRegions(bagName, {6}) -- N.B. region 6 is text
			self:moveObject(_G[bagName:GetName().."Name"], "-", 10, nil, nil)
			_G[bagName:GetName().."Name"]:SetTextColor(1, 1, 1)
			self:applySkin(bagName)
			self:HookScript(bagName, "OnShow", function()
				-- self:Debug(this:GetName().." - OnShow")
				self.hooks[this].OnShow()
				self:shrinkBag(this)
				end)
		end

		keyringName = _G["CharactersViewer_KeyringContainerFrame"]
		self:keepRegions(keyringName, {6}) -- N.B. region 6 is text
		self:moveObject(_G[keyringName:GetName().."Name"], "-", 10, nil, nil)
		_G[keyringName:GetName().."Name"]:SetTextColor(1, .7, 0)
		self:applySkin(keyringName)
		self:HookScript(keyringName, "OnShow", function()
			-- self:Debug(this:GetName().." - OnShow")
			self.hooks[this].OnShow()
			self:shrinkBag(this)
	    	end)
	
		-- Bank Frame
		self:hookDDScript(_G["CharactersViewerDropDown3Button"])
		self:keepRegions(_G["CharactersViewerDropDown3"], {4}) -- N.B. region 4 is text
		self:removeRegions(_G["CharactersViewerBankFrame"], {1, 2}) -- N.B. other regions are text
		_G["CharactersViewerBankFrame"]:SetWidth(_G["CharactersViewerBankFrame"]:GetWidth() * FxMult)
		_G["CharactersViewerBankFrame"]:SetHeight(_G["CharactersViewerBankFrame"]:GetHeight() * FyMult - 40)
		self:moveObject(_G["CharactersViewerBankItems_TitleText"], nil, nil, "-", 50)
		self:moveObject(self:getRegion(_G["CharactersViewerBankFrame"], 4), "+", 10, "-", 30)
		self:moveObject(self:getRegion(_G["CharactersViewerBankFrame"], 5), "+", 10, "-", 30)
		self:moveObject(_G["CharactersViewerBankMoney1"], "-", 120, "-", 80)
		self:moveObject(_G["CharactersViewerBankItems_MoneyFrameTotal1"], "-", 120, "-", 80)
		self:moveObject(_G["CharactersViewerBankItems_CloseButton"], "+", 28, "+", 8)
		self:moveObject(_G["CharactersViewerBankItem_Item1"], "-", 10, "+", 25)
		self:moveObject(_G["CharactersViewerDropDown3"], "+", 180, "-", 50)
		self:applySkin(_G["CharactersViewerBankFrame"])
	
		for i = 5, 10 do
			bankBagName = _G["CharactersViewer_BankItemsContainerFrame"..i]
			self:keepRegions(bankBagName, {6}) -- N.B. region 6 is text
			self:moveObject(_G[bankBagName:GetName().."Name"], "-", 10, nil, nil)
			_G[bankBagName:GetName().."Name"]:SetTextColor(.3, .3, 1)
			self:applySkin(bankBagName)
			self:HookScript(bankBagName, "OnShow", function()
				-- self:Debug(this:GetName().." - OnShow")
				self.hooks[this].OnShow()
				self:shrinkBag(this)
				end)
		end
	    
	else
-->-- version 2.73	

		self:SetDebugging(true)
	                 
		-- Character Frame
		-- self:Hook(CharactersViewer.CharacterFrame, "CharacterFrame_ShowSubFrame", function(frameName)
		-- 	self:Debug("CV.CF.CF_SSF")
		-- 	self.hooks[CharactersViewer.CharacterFrame].CharacterFrame_ShowSubFrame(frameName)
		-- 	
		-- 	end)
	   	self:hookDDScript(CVPaperDollFrameDropDown2Button)

		CVCharacterFrame:SetWidth(CVCharacterFrame:GetWidth() * FxMult + 20)
		CVCharacterFrame:SetHeight(CVCharacterFrame:GetHeight() * FyMult)

		self:moveObject(_G["CVCharacterNameText"], nil, nil, "-", 30)
		self:moveObject(_G["CVCharacterFrameCloseButton"], "+", 28, "+", 8)
		self:moveObject(_G["CVCharacterHeadSlot"], nil, nil, "+", 20)
		self:moveObject(_G["CVCharacterHandsSlot"], nil, nil, "+", 20)
		self:moveObject(_G["CVCharacterMainHandSlot"], nil, nil, "-", 75)
		self:moveObject(_G["CVCharacterResistanceFrame"], nil, nil, "+", 20)
		self:moveObject(_G["CVCharacterHealth"], nil, nil, "+", 20)
		self:moveObject(_G["CVPaperDollFrameDropDown2"], "-", 10, "-", 14)

		self:keepRegions(CVSkillFrame, {5})
		self:applySkin(CVSkillFrame, nil)
		self:keepRegions(CVOptionFrame, {})
		self:applySkin(CVOptionFrame, nil)
		self:keepRegions(CVReportFrame, {})
		self:applySkin(CVReportFrame, nil)
   		self:keepRegions(CVPaperDollFrameDropDown2, {4})
    	self:keepRegions(CVPaperDollFrame, {5,6,7})
		self:applySkin(CVPaperDollFrame, nil)
		self:keepRegions(CVReputationFrame, {5})
		self:applySkin(CVReputationFrame, nil)
		self:keepRegions(CVCharacterNameFrame, {1})
		self:applySkin(CVCharacterNameFrame, nil)
		-- Character Frame tabs
		for i = 1, 7 do
			local tabName = _G["CVCharacterFrameTab"..i]
			self:keepRegions(tabName, {7,8})
			if self.db.profile.TexturedTab then self:applySkin(tabName, nil, 0)
			else self:applySkin(tabName) end
			if i == 1 then self:moveObject(tabName, nil, nil, "-", 72) end
			self:HookScript(tabName, "OnShow", function()
				-- self:Debug("%s - %s", this:GetName(), "OnShow")
				self.hooks[this].OnShow()
 				this:SetWidth(this:GetWidth() * 0.80)
				local _, _, _, xOfs, _ = this:GetPoint()
				-- don't move the first tab
				if math.floor(xOfs) == -18 or math.floor(xOfs) == 0 then self:moveObject(this, "+", 15, nil, nil) end
   			end)
		end
		-- Report Frame Tabs
		for i = 1, 3 do
			local tabName = _G["CVReportFrameToggleTab"..i]
			self:keepRegions(tabName, {7,8})
			if self.db.profile.TexturedTab then self:applySkin(tabName, nil, 0)
			else self:applySkin(tabName) end
			self:moveObject(_G[tabName:GetName().."Text"], nil, nil, "+", 6)
			local tabHL = getglobal(tabName:GetName().."HighlightTexture") 
 			self:moveObject(tabHL, nil, nil, "+", 8)
   	end
		self:keepRegions(CVCharacterFrame, {})
		self:applySkin(CVCharacterFrame, nil)
		-- Bags
		for i = 1, 6 do
			bagName = _G["CVContainerFrame"..i]
			self:keepRegions(bagName, {6}) -- N.B. region 6 is text
			self:moveObject(_G[bagName:GetName().."Name"], "-", 10, nil, nil)
			_G[bagName:GetName().."Name"]:SetTextColor(1, 1, 1)
			self:applySkin(bagName)
			self:HookScript(bagName, "OnShow", function()
				-- self:Debug(this:GetName().." - OnShow")
				self.hooks[this].OnShow()
				self:shrinkBag(this, true)
				end)
		end

   	-- Bank Frame
		self:hookDDScript(CVPaperDollFrameDropDown3Button)

		CVBankFrame:SetWidth(CVBankFrame:GetWidth() * FxMult + 20)
		CVBankFrame:SetHeight(CVBankFrame:GetHeight() * FyMult)

		self:moveObject(_G["CVBankFrameTitleText"], nil, nil, "-", 30)
		self:moveObject(_G["CVBankFrameTimestamp"], nil, nil, "+", 20)
		self:moveObject(_G["CVBankFrameItemSlotText"], nil, nil, "-", 40)
		self:moveObject(self:getRegion(_G["CVBankFrame"], 5), nil, nil, "-", 40)
		self:moveObject(_G["CVBankFrameMoney1"], nil, nil, "-", 80)
		self:moveObject(_G["CVBankFrameMoneyFrame1"], nil, nil, "-", 80)
		self:moveObject(_G["CVBankCloseButton"], "+", 28, "+", 8)
		self:moveObject(_G["CVPaperDollFrameDropDown3"], "-", 10, "-", 100)
		self:keepRegions(CVPaperDollFrameDropDown3, {4})
		self:keepRegions(CVBankFrame, {3,4,5,6,7,8,9})
		self:applySkin(CVBankFrame, nil)
		
		for i = 7, 12 do
			bankBagName = _G["CVContainerFrame"..i]
			self:keepRegions(bankBagName, {6}) -- N.B. region 6 is text
			self:moveObject(_G[bankBagName:GetName().."Name"], "-", 10, nil, nil)
			_G[bankBagName:GetName().."Name"]:SetTextColor(.3, .3, 1)
			self:applySkin(bankBagName)
			self:HookScript(bankBagName, "OnShow", function()
				-- self:Debug(this:GetName().." - OnShow")
				self.hooks[this].OnShow()
				self:shrinkBag(this)
				end)
		end
		
	end
	
end

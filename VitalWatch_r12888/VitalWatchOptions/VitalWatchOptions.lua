--[[
-- Name: VitalWatchOptions
-- Author: Thrae of Maelstrom (aka "Matthew Carras")
-- Release Date: 9-2-06
--
-- These functions allow you to change options via a
-- Dewdrop GUI. Loaded on demand by VitalWatch.
--
-- This part does NOT need to be localized, look in
-- VitalWatchOptionsLocale_xxXX.lua.
--]]

local _G = getfenv(0)
local dewdrop = _G.AceLibrary:GetInstance("Dewdrop-2.0")
local VitalWatch = _G.VitalWatch
local VitalWatchLocale = _G.VitalWatchLocale

local NilOutDefault = {
					["ThresholdLowHealth"] 	= 0.2,
					["ThresholdCritHealth"] = 0.4,
					["ThresholdLowMana"] 		= 0.2,
					["ThresholdCritMana"] 	= 0.4,
					["ColourLowHealthR"] 	= 1,
					["ColourLowHealthG"] 	= 1,
					["ColourLowHealthB"] 	= 0,
					["ColourCritHealthR"] = 1,
					["ColourCritHealthG"] = 0,
					["ColourCritHealthB"] = 0,
					["ColourLowManaR"] 		= 0,
					["ColourLowManaG"] 		= 1,
					["ColourLowManaB"] 		= 1,
					["ColourCritManaR"] 	= 0,
					["ColourCritManaG"] 	= 0,
					["ColourCritManaB"] 	= 1,
					["ColourLowHealthOtherR"] 		= 1,
					["ColourLowHealthOtherG"] 		= 1,
					["ColourLowHealthOtherB"] 		= 0,
					["ColourCritHealthOtherR"] 		= 1,
					["ColourCritHealthOtherG"] 		= 1,
					["ColourCritHealthOtherB"] 		= 0,
					["ColourLowManaOtherR"] 			= 0,
					["ColourLowManaOtherG"] 			= 1,
					["ColourLowManaOtherB"] 			= 1,
					["ColourCritManaOtherR"] 			= 0,
					["ColourCritManaOtherG"] 			= 0,
					["ColourCritManaOtherB"] 			= 1,
					["ColourAggroR"] 							= 1,
					["ColourAggroG"] 							= 1,
					["ColourAggroB"] 							= 1,
					["ColourAggroOtherR"] 				= 0.8,
					["ColourAggroOtherG"] 				= 0.8,
					["ColourAggroOtherB"] 				= 0.8,
					["MsgRate"]							= 0.2,
					["AggroWatchRate"]			= 3,
					["AggroWatchOtherRate"]	= 5,
					["MsgChan"]							= "PARTY",
					["MsgChanOther"]				= "PARTY",
					["MsgAggroChan"]				= "PARTY",
					["MsgAggroChanOther"]		= "PARTY",
					["MsgCritHealth"]				= VitalWatchLocale.DEFAULT_MsgCritHealth,
					["MsgAggroChan"]				= "PARTY",
					["MsgAggroChanOther"]		= "PARTY",
					["EmoteCritMana"]				= VitalWatchLocale.DEFAULT_EmoteCritMana,
					["SoundLowHealth"]			= "blip5",	
					["SoundCritHealth"]			= "phasers3",
					["SoundLowHealthOther"]		= "blip5",	
					["SoundCritHealthOther"]	= "phasers3",
					["MessageLogFade"]			= 15,
					["MaxMessages"]					= 6
}

function VitalWatch:ToggleDB(k)
	self.db.profile[k] = not self.db.profile[k]
	self:ReInitialize()
end

function VitalWatch:ToggleTableDB(k,k2)
	if not self.db.profile[k] then self.db.profile[k] = {} end
	self.db.profile[k][k2] = not self.db.profile[k][k2]
	if next(self.db.profile[k]) == nil then
		self.db.profile[k] = nil
	end
end

function VitalWatch:SetTableDB(k,k2,v2)
	if not self.db.profile[k] then self.db.profile[k] = {} end
	self.db.profile[k][k2] = v2
	if next(self.db.profile[k]) == nil then
		self.db.profile[k] = nil
	end
end

function VitalWatch:SetDB(k,v)
	if NilOutDefault[k] and NilOutDefault[k] == v then
		self.db.profile[k] = nil
	else
		self.db.profile[k] = v
	end
	self:ReInitialize()
end

function VitalWatch:SetDBNum(k,v)
	v = tonumber(v)
	if NilOutDefault[k] and NilOutDefault[k] == v then
		self.db.profile[k] = nil
	else
		self.db.profile[k] = v
	end
	self:ReInitialize()
end

function VitalWatch:SetEditBoxWithDisabled(k,v)
	if not v then v = "DISABLED" end
	if NilOutDefault[k] and NilOutDefault[k] == v then
		self.db.profile[k] = nil
	else
		self.db.profile[k] = v
	end
end

function VitalWatch:SetDBColour(k,r,g,b)
	local CR,CG,CB = k .. "R", k .. "G", k .. "B"
	v = tonumber(v)
	if NilOutDefault[CR] and NilOutDefault[CR] == r then
		self.db.profile[CR] = nil
	else
		self.db.profile[CR] = r
	end
	if NilOutDefault[CG] and NilOutDefault[CG] == g then
		self.db.profile[CG] = nil
	else
		self.db.profile[CG] = g
	end
	if NilOutDefault[CB] and NilOutDefault[CB] == b then
		self.db.profile[CB] = nil
	else
		self.db.profile[CB] = b
	end
end

function VitalWatch:DDAddArrow(opt)
	dewdrop:AddLine( 'text', VitalWatchLocale[opt .. "_Opt"],
									 'hasArrow', true,
									 'value', opt,
									 'tooltipTitle', self.name,
									 'tooltipText', VitalWatchLocale[opt .. "_Desc"]
								  )
end

function VitalWatch:DDAddChecked(opt, func)
	dewdrop:AddLine( 'text', VitalWatchLocale[opt .. "_Opt"],
									 'checked', self.db.profile[opt],
									 'func', func or self.ToggleDB,
									 'arg1', self,
									 'arg2', opt,
									 'tooltipTitle', self.name,
									 'tooltipText', VitalWatchLocale[opt .. "_Desc"]
								  )
end

function VitalWatch:DDAddEditBox(opt, func, default)
	dewdrop:AddLine( 'text', VitalWatchLocale[opt .. "_Opt"],
									 'hasArrow', true,
									 'hasEditBox', true,
									 'editBoxText', (self.db.profile[ opt ] ~= "DISABLED" and self.db.profile[ opt ]) or NilOutDefault[opt] or default,
									 'editBoxFunc', func or self.SetDB,
									 'editBoxArg1', self,
									 'editBoxArg2', opt,
									 'tooltipTitle', self.name,
									 'tooltipText', VitalWatchLocale[opt .. "_Desc"]
								  )
end

function VitalWatch:DDAddRadioBoxes(opt, map, func, default)
			dewdrop:AddLine('text', default or VitalWatchLocale.Default,
											'isRadio', true,
											'checked', not self.db.profile[opt],
											'func', func or self.SetDBNum,
											'arg1', self,
											'arg2', opt )
			for k,v in map do
				dewdrop:AddLine('text', v,
												'isRadio', true,
												'checked', self.db.profile[opt] == k,
												'func', func or self.SetDBNum,
												'arg1', self,
												'arg2', opt,
												'arg3', k )
			end
end

function VitalWatch:DDAddScale(opt, func, default)
			dewdrop:AddLine( 'text', VitalWatchLocale[opt .. "_Opt"],
									 'hasArrow', true,
									 'hasSlider', true,
									 'sliderMin', 0.0,
									 'sliderMax', 1.0,
									 'sliderIsPercent', true,
									 'sliderValue', self.db.profile[opt] or NilOutDefault[opt] or default or 1.0,
									 'sliderFunc', func or self.SetDBNum,
									 'sliderArg1', self,
									 'sliderArg2', opt,
									 'tooltipTitle', self.name,
									 'tooltipText', VitalWatchLocale[opt .. "_Desc"] )
end

function VitalWatch:DDAddColourSwatch(opt, func, dR, dG, dB)
			dewdrop:AddLine( 'text', VitalWatchLocale[opt .. "_Opt"],
									 'hasColorSwatch', true,
									 'r', self.db.profile[opt .. "R"] or NilOutDefault[opt .. "R"] or dR or 1.0,
									 'g', self.db.profile[opt .. "G"] or NilOutDefault[opt .. "G"] or dG or 1.0,
									 'b', self.db.profile[opt .. "B"] or NilOutDefault[opt .. "B"] or dB or 1.0,
									 'sliderFunc', func or self.SetDBColour,
									 'colorArg1', self,
									 'colorArg2', opt,
									 'tooltipTitle', self.name,
									 'tooltipText', VitalWatchLocale[opt .. "_Desc"] )
end

function VitalWatch:DDCreateNoWatchClassList(opt, map)
	if not map then map = VitalWatchLocale.ClassMap end
	for k,v in map do
		dewdrop:AddLine( 'text', v,
									 	 'checked', self.db.profile[opt] and self.db.profile[opt][k],
									 	 'func', self.ToggleTableDB,
									 	 'arg1', self,
									 	 'arg2', opt,
										 'arg3', k
								  	)
	end
end

function VitalWatch:DDCreateNoWatchNameList(opt, level)
		if not level then
			dewdrop:AddLine( 'text', VitalWatchLocale.AddName,
									 		 'hasArrow', true,
									 		 'hasEditBox', true,
									 		 'editBoxText', nil,
									 		 'editBoxFunc', func or self.SetDB,
									 		 'editBoxArg1', self,
									 		 'editBoxArg2', opt,
											 'editBoxArg3', true
										 )
		end
		local k,i
		if self.db.profile[opt] then
			i = 0
			k = next(self.db.profile[opt])
			while i < 10 and k do
				dewdrop:AddLine( 'text', k,
									 	 		 'func', self.SetTableDB,
									 	 		 'arg1', self,
									 	 		 'arg2', opt,
										 		 'arg3', k
								   		 )
				k = next(self.db.profile[opt])
				i = i + 1
			end
		end
		if i and i == 10 and k then
			dewdrop:AddLine( 'text', VitalWatchLocale.More,
									 		 'hasArrow', true,
									 		 'value', opt
								  	 )
		end
end

function VitalWatch:DDCreateChanList(opt)
	self:DDAddRadioBoxes(opt, VitalWatchLocale.ChannelMap, nil, VitalWatchLocale.PARTY)
	dewdrop:AddLine( 'text', VitalWatchLocale.AddCustomChannel_Opt,
									 'hasArrow', true,
									 'hasEditBox', true,
									 'editBoxText', NilOutDefault[opt] or "PARTY",
									 'editBoxFunc', self.SetDB,
									 'editBoxArg1', self,
									 'editBoxArg2', opt,
									 'tooltipTitle', self.name,
									 'tooltipText', VitalWatchLocale.AddCustomChannel_Desc
								  )
end

function VitalWatch:CreateDDMenu(level,value)
	if level == 1 then
		self:DDAddArrow("Main_Health")
		self:DDAddArrow("Main_Mana")
		self:DDAddArrow("Main_Aggro")
		self:DDAddArrow("Main_Messages")
		
		dewdrop:AddLine()

		dewdrop:AddLine('text', VitalWatchLocale.Main_Default_Opt,
										'textR', 1, 'textG', 0.4, 'textB', 0.4,
										'func', self.ResetDB,
										'tooltipTitle', self.name,
										'tooltipText', VitalWatchLocale.Main_Default_Desc,
										'arg1', self,
										'arg2', "profile" )

		dewdrop:AddLine()
	elseif level == 2 then
		if value == "Main_Health" then
			self:DDAddScale("ThresholdLowHealth")
			self:DDAddScale("ThresholdCritHealth")
			self:DDAddColourSwatch("ColourLowHealth")
			self:DDAddColourSwatch("ColourCritHealth")

			dewdrop:AddLine()

			self:DDAddArrow("HealthWatch")
			self:DDAddArrow("PetHealthWatch")
			self:DDAddArrow("HealthNoWatchClass")
			self:DDAddArrow("HealthNoWatchName")

			dewdrop:AddLine()

			self:DDAddEditBox("MsgLowHealth", nil, VitalWatchLocale.DEFAULT_MsgLowHealth)
			self:DDAddEditBox("MsgCritHealth", self.SetEditBoxWithDisabled, VitalWatchLocale.DEFAULT_MsgCritHealth)
			self:DDAddEditBox("MsgOtherLowHealth", nil, VitalWatchLocale.Floating_Message_LowHealth)
			self:DDAddEditBox("MsgOtherCritHealth", nil, VitalWatchLocale.Floating_Message_CritHealth)
			self:DDAddEditBox("EmoteLowHealth", nil, VitalWatchLocale.DEFAULT_EmoteLowHealth)
			self:DDAddEditBox("EmoteCritHealth", nil, VitalWatchLocale.DEFAULT_EmoteCritHealth)
			self:DDAddEditBox("SoundLowHealth", self.SetEditBoxWithDisabled, "blip5")
			self:DDAddEditBox("SoundCritHealth", self.SetEditBoxWithDisabled, "phasers3")
			self:DDAddEditBox("SoundLowHealthOther", self.SetEditBoxWithDisabled, "blip5")
			self:DDAddEditBox("SoundCritHealthOther", self.SetEditBoxWithDisabled, "phasers3")

			dewdrop:AddLine()

			self:DDAddChecked("DisableMessageFrameHealth")
			self:DDAddChecked("Heartbeat")
			self:DDAddChecked("FlashFrameHealth")
		elseif value == "Main_Mana" then
			self:DDAddScale("ThresholdLowMana")
			self:DDAddScale("ThresholdCritMana")
			self:DDAddColourSwatch("ColourLowMana")
			self:DDAddColourSwatch("ColourCritMana")

			dewdrop:AddLine()

			self:DDAddArrow("ManaWatch")
			self:DDAddArrow("ManaNoWatchClass", VitalWatchLocale.ManaClassMap)
			self:DDAddArrow("ManaNoWatchName")

			dewdrop:AddLine()

			self:DDAddEditBox("MsgLowMana", nil, VitalWatchLocale.DEFAULT_MsgLowMana)
			self:DDAddEditBox("MsgCritMana", nil, VitalWatchLocale.DEFAULT_MsgCritMana)
			self:DDAddEditBox("MsgOtherLowMana", nil, VitalWatchLocale.Floating_Message_LowMana)
			self:DDAddEditBox("MsgOtherCritMana", nil, VitalWatchLocale.Floating_Message_CritMana)
			self:DDAddEditBox("EmoteLowMana", nil, VitalWatchLocale.DEFAULT_EmoteLowMana)
			self:DDAddEditBox("EmoteCritMana", self.SetEditBoxWithDisabled, VitalWatchLocale.DEFAULT_EmoteCritMana)
			self:DDAddEditBox("SoundLowMana")
			self:DDAddEditBox("SoundCritMana")
			self:DDAddEditBox("SoundLowManaOther")
			self:DDAddEditBox("SoundCritManaOther")

			dewdrop:AddLine()

			self:DDAddChecked("DisableMessageFrameMana")
		elseif value == "Main_Aggro" then
			self:DDAddColourSwatch("ColourAggro")
			self:DDAddColourSwatch("ColourAggroOther")
			
			dewdrop:AddLine()

			self:DDAddArrow("AggroTargetWatch")
			self:DDAddArrow("AggroLogWatch")
			self:DDAddArrow("AggroNoWatchClass")
			self:DDAddArrow("AggroNoWatchName")

			dewdrop:AddLine()

			self:DDAddEditBox("AggroWatchRate", self.SetDBNum, 1)
			self:DDAddEditBox("AggroWatchRateOther", self.SetDBNum, 5)

			dewdrop:AddLine()

			self:DDAddEditBox("MsgAggro", nil, VitalWatchLocale.DEFAULT_MsgAggro)
			self:DDAddEditBox("MsgAggroOther", nil, VitalWatchLocale.DEFAULT_MsgAggroOther)
			self:DDAddEditBox("SoundAggro")
			self:DDAddEditBox("SoundAggroOther")

			dewdrop:AddLine()
			self:DDAddChecked("EnableMessageFrameAggro")
		elseif value == "Main_Messages" then
			self:DDAddEditBox("MessageLogFade", self.SetDBNum, 15)
			self:DDAddEditBox("MaxMessages", self.SetDBNum, 6)

			dewdrop:AddLine()

			self:DDAddEditBox("MsgRate", self.SetDBNum, 0.2)
			self:DDAddArrow("MsgChan")
			self:DDAddArrow("MsgChanOther")
			self:DDAddArrow("MsgAggroChan")
			self:DDAddArrow("MsgAggroChanOther")

			dewdrop:AddLine()

			self:DDAddChecked("EnableInBGs")
			self:DDAddChecked("DisableMsg")
		end
	elseif level == 3 then
		if value == "HealthWatch" then
			self:DDAddRadioBoxes("HealthWatch", VitalWatchLocale.PlayerMap, nil, VitalWatchLocale.PlayerOnly)
		elseif value == "PetHealthWatch" then
			self:DDAddRadioBoxes("PetHealthWatch", VitalWatchLocale.PetMap, nil, VitalWatchLocale.YourPet)
		elseif value == "HealthNoWatchClass" then
			self:DDCreateNoWatchClassList("HealthNoWatchClass")
		elseif value == "HealthNoWatchName" then
			self:DDCreateNoWatchNameList("HealthNoWatchName")
		elseif value == "ManaWatch" then
			self:DDAddRadioBoxes("ManaWatch", VitalWatchLocale.PlayerMap, nil, VitalWatchLocale.PlayerOnly)
		elseif value == "ManaNoWatchClass" then
			self:DDCreateNoWatchClassList("ManaNoWatchClass")
		elseif value == "ManaNoWatchName" then
			self:DDCreateNoWatchNameList("ManaNoWatchName")
		elseif value == "AggroTargetWatch" then
			self:DDAddRadioBoxes("AggroTargetWatch", VitalWatchLocale.AggroMap, nil, VitalWatchLocale.Disabled)
		elseif value == "AggroLogWatch" then
			self:DDAddRadioBoxes("AggroLogWatch", VitalWatchLocale.AggroMap, nil, VitalWatchLocale.Disabled)
		elseif value == "AggroNoWatchClass" then
			self:DDCreateNoWatchClassList("AggroNoWatchClass")
		elseif value == "AggroNoWatchName" then
			self:DDCreateNoWatchNameList("AggroNoWatchName")
		elseif value == "MsgChan" then
			self:DDCreateChanList("MsgChan")
		elseif value == "MsgChanOther" then
			self:DDCreateChanList("MsgChanOther")
		elseif value == "MsgAggroChan" then
			self:DDCreateChanList("MsgAggroChan")
		elseif value == "MsgAggroChanOther" then
			self:DDCreateChanList("MsgAggroChanOther")
		end
	elseif value == "HealthNoWatchName" then
			self:DDCreateNoWatchNameList("HealthNoWatchName", level)
	elseif value == "ManaNoWatchName" then
			self:DDCreateNoWatchNameList("ManaNoWatchName", level)
	elseif value == "AggroNoWatchName" then
			self:DDCreateNoWatchNameList("AggroNoWatchName", level)
	end
end

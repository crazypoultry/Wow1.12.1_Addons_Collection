--[[
-- Name: VitalWatch
-- Author: Thrae of Maelstrom (aka "Matthew Carras")
-- Release Date: 8-25-06
--
-- Original concept by Sean Kennedy (HealthWatch), then modified by Nikolas Davis (VitalWatch).
-- This is a complete recode of the original VitalWatch, with a lot of new features.
--
-- Thanks to #wowace and #wowi-lounge on Freenode as always for
-- optimization assistance.
--]]

local _G = getfenv(0)
local strfind = string.find

local UnitExists, UnitIsUnit, UnitCanAttack, UnitIsPlayer, UnitName, UnitInRaid, UnitInParty, UnitLevel = _G.UnitExists, _G.UnitIsUnit, _G.UnitCanAttack, _G.UnitIsPlayer, _G.UnitName, _G.UnitInRaid, _G.UnitInParty, _G.UnitLevel

local GetTime = _G.GetTime

_G.VitalWatch = _G.AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceDB-2.0", "FuBarPlugin-2.0")
local VitalWatch = _G.VitalWatch
local VitalWatchLocale = _G.VitalWatchLocale
local parser
local roster
local tablet = _G.AceLibrary("Tablet-2.0")

-- stuff for FuBar / Tablet
--VitalWatch.name = "VitalWatch"  -- should be auto provided if using AceAddon-2.0
--VitalWatch.hasIcon = true
VitalWatch.title = VitalWatchLocale.LogTitle
VitalWatch.defaultPosition = "LEFT"
VitalWatch.defaultMinimapPosition = 150
VitalWatch.cannotDetachTooltip = false
VitalWatch.hideWithoutStandby = true
VitalWatch.clickableTooltip = true -- XXX now do what?
VitalWatch.independentProfile = true
--VitalWatch.tooltipHiddenWhenEmpty = true
VitalWatch.showTitleWhenDetached = true

local db, tmp, _

-- These are frames from the default UI
local LowHealthFrame 		= _G.LowHealthFrame
local OutOfControlFrame = _G.OutOfControlFrame

local LastPercentageHealth 
local LastPercentageMana 
local MessageLog 
local NumMessageLog = 0

-- How long the message is held on the frame.
local MessageFrameHoldTime = 3

local MessageFrameMessageAlpha = 1

-- hopefully this won't need to be localized
local SoundPath = "Interface\\AddOns\\VitalWatch\\sounds\\"
local HeartbeatSound = SoundPath .. "Heartbeat.wav"

local NextQueuedMessage, NextQueuedMessageChan, NextQueuedMessagePriority, NextQueuedEmote, NextQueuedDoEmote

local DEFAULT_ThresholdCritHealth = 0.2
local DEFAULT_ThresholdLowHealth = 0.4
local DEFAULT_ThresholdCritMana = 0.2
local DEFAULT_ThresholdLowMana = 0.4
local DEFAULT_SoundCritHealth = SoundPath .. "phasers3.wav"
local DEFAULT_SoundLowHealth = SoundPath .. "blip5.wav"
local DEFAULT_MsgRate = 0.2
local DEFAULT_AggroWatchRate = 3
local DEFAULT_AggroWatchOtherRate = 5

local ClassColors = {}
for k,v in pairs(_G.RAID_CLASS_COLORS) do
	ClassColors[k] = string.format("%2x%2x%2x", v.r*255, v.g*255, v.b*255)
end

-- Print out a message, probably to ChatFrame1
function VitalWatch:Msg(msg)
	_G.DEFAULT_CHAT_FRAME:AddMessage("|cFFFFCC00VitalWatch:|r " .. msg )
end

-- Enable a LoadOnDemand addon and optionally run one of its functions.
-- If the addon is already loaded, then just run the function or do
-- nothing.
function VitalWatch:LoDRun(addon,sfunc,arg1,arg2,arg3,arg4,arg5,arg6)
	if not self[sfunc] then
		local loaded, reason = _G.LoadAddOn(addon)
		if loaded then
			if self[sfunc] and type( self[sfunc] ) == "function" then
				self[sfunc](self,arg1,arg2,arg3,arg4,arg5,arg6)
			end
		else
			self:Msg( addon .. " Addon LoadOnDemand Error - " .. reason )
			return reason
		end
	elseif type( self[sfunc] ) == "function" then
			self[sfunc](self,arg1,arg2,arg3,arg4,arg5,arg6)
	end
end

local MessageFrame, MessageFrame_AddMessage
function VitalWatch:CreateMessageFrame()
	if not MessageFrame then
		MessageFrame = _G.CreateFrame("MessageFrame", "VitalWatchMessageFrame", _G.UIParent )
		MessageFrame:SetWidth(512)
		MessageFrame:SetHeight(60)
		MessageFrame:SetPoint("CENTER", 0, 250)
		MessageFrame:SetInsertMode("TOP")
		MessageFrame:SetToplevel(true)
		MessageFrame:SetFontObject(_G.NumberFontNormalHuge)
		MessageFrame:SetJustifyH("CENTER")
		MessageFrame:Show()
		MessageFrame_AddMessage = MessageFrame.AddMessage
	end
end

-- Thanks to TNE_LowHealthWarning for this.
local function AdjustFlashRate(frame,rate)
	if rate < 1 then
    if _G.UIFrameIsFlashing(frame) then
      frame.flashDuration = frame.flashDuration + rate + 1
      if (rate < 1) then
        frame.fadeInTime = rate * 0.15
        frame.fadeOutTime = rate * 0.85
        frame.flashInHoldTime = 0
      else
        frame.fadeInTime = 0.2
        frame.fadeOutTime = 0.8
        frame.flashInHoldTime = rate - 1
      end
    else
      _G.UIFrameFlash(frame, 0.2, 0.8, 10, nil, rate -1, 0)
    end
  end
end

function VitalWatch:PlayHeartbeatSound()
	_G.PlaySoundFile( HeartbeatSound )
end

local playerInBG
function VitalWatch:PLAYER_ENTERING_WORLD()
	local z = _G.GetRealZoneText()
	playerInBG = (z == VitalWatchLocale.AlteracValley or z == VitalWatchLocale.ArathiBasin or z == VitalWatchLocale.WarsongGulch)
end

function VitalWatch:ProcessUnitHealthOther(unit, name, class, petTag)
	local percentage = _G.UnitHealth(unit) / _G.UnitHealthMax(unit)
	if percentage < (db["ThresholdCritHealth"] or DEFAULT_ThresholdCritHealth) and 
		 (not LastPercentageHealth[unit] or 
		 LastPercentageHealth[unit] >= (db["ThresholdCritHealth"] or DEFAULT_ThresholdCritHealth)) then
				if class and ClassColors[class] then
			 		self:MessageLogUpdate("|cFF" .. ClassColors[class] .. name .. "|r" ..
										 	 				 VitalWatchLocale.Floating_Message_CritHealth,
	 										 	 			 db["ColourCritHealthOtherR"] or 1,
												 			 db["ColourCritHealthOtherG"] or 0,
												 			 db["ColourCritHealthOtherB"] or 0,
												 			 name,
												 			 unit)
				else
			 		self:MessageLogUpdate(name .. VitalWatchLocale.Floating_Message_CritHealth .. (petTag or ""),
	 										 	 			 db["ColourCritHealthOtherR"] or 1,
												 			 db["ColourCritHealthOtherG"] or 0,
												 			 db["ColourCritHealthOtherB"] or 0,
												 			 name,
												 			 unit)
				end
		if not db["DisableMessageFrameHealth"] then
					MessageFrame_AddMessage(MessageFrame, 
																	MessageLog[NumMessageLog].text,
																	MessageLog[NumMessageLog].r,
																	MessageLog[NumMessageLog].g,
																	MessageLog[NumMessageLog].b,
																	MessageFrameMessageAlpha,
																	MessageFrameHoldTime)
		end
		tmp = db["SoundCritHealth"]
		if tmp ~= "DISABLED" then
			_G.PlaySoundFile( (tmp ~= nil and (SoundPath .. tmp .. ".wav") ) or DEFAULT_SoundCritHealth)
		end	
		tmp = db["MsgChanOther"]
		if not db["DisableMsg"] and 
			(not NextQueuedMessagePriority or (NextQueuedMessagePriority < 3 and 
			 not petTag)) and db["MsgCritHealth"] and not playerInBG and 
			 ((tmp and tmp ~= "PARTY" and tmp ~= "RAID") or 
			 (tmp == "PARTY" and _G.GetNumPartyMembers() > 0) or 
			 (tmp == "RAID" and _G.GetNumRaidMembers() > 0)) then
					-------
					NextQueuedMessage = "<< " ..
															name .. 
															db["MsgOtherCritHealth"] ..
															(petTag or (" (" .. UnitClass(unit) .. ") ")) ..
															" >>"
					NextQueuedMessageChan = db["MsgChanOther"]
					NextQueuedMessagePriority = (petTag and 1) or 2
					--------
		end
	elseif percentage < (db["ThresholdLowHealth"] or DEFAULT_ThresholdLowHealth) and 
		(not LastPercentageHealth[unit] or 
		LastPercentageHealth[unit] >= (db["ThresholdLowHealth"] or DEFAULT_ThresholdLowHealth)) then
				if class and ClassColors[class] then
			 		self:MessageLogUpdate("|cFF" .. ClassColors[class] .. name .. "|r" ..
										 	 				 VitalWatchLocale.Floating_Message_LowHealth,
	 										 	 			 db["ColourLowHealthOtherR"] or 1,
												 			 db["ColourLowHealthOtherG"] or 0,
												 			 db["ColourLowHealthOtherB"] or 0,
												 			 name,
												 			 unit)
				else
			 		self:MessageLogUpdate(name .. VitalWatchLocale.Floating_Message_LowHealth .. (petTag or ""),
	 										 	 			 db["ColourLowHealthOtherR"] or 1,
												 			 db["ColourLowHealthOtherG"] or 0,
												 			 db["ColourLowHealthOtherB"] or 0,
												 			 name,
												 			 unit)
				end
		if not db["DisableMessageFrameHealth"] then
					MessageFrame_AddMessage(MessageFrame, 
																	MessageLog[NumMessageLog].text,
																	MessageLog[NumMessageLog].r,
																	MessageLog[NumMessageLog].g,
																	MessageLog[NumMessageLog].b,
																	MessageFrameMessageAlpha,
																	MessageFrameHoldTime)
		end
		tmp = db["SoundLowHealthOther"]
		if tmp ~= "DISABLED" then
			_G.PlaySoundFile( (tmp ~= nil and (SoundPath .. tmp .. ".wav") ) or DEFAULT_SoundLowHealth)
		end	
		tmp = db["MsgChanOther"]
		if not db["DisableMsg"] and 
			(not NextQueuedMessagePriority or (NextQueuedMessagePriority < 2 and 
			 not petTag)) and db["MsgCritHealth"] and not playerInBG and 
			 db["MsgOtherLowHealth"] and not playerInBG and 
			 ((tmp and tmp ~= "PARTY" and tmp ~= "RAID") or 
			  (tmp == "PARTY" and _G.GetNumPartyMembers() > 0) or 
				(tmp == "RAID" and _G.GetNumRaidMembers() > 0)) then
					-------
					NextQueuedMessage = "<< " ..
															name .. 
															db["MsgOtherLowHealth"] ..
															(petTag or (" (" .. UnitClass(unit) .. ")")) ..
															" >>"
					NextQueuedMessageChan = db["MsgChanOther"]
					NextQueuedMessagePriority = (not petTag and 1) or nil
					--------
		end
	end
	LastPercentageHealth[unit] = percentage	
end

function VitalWatch:UNIT_HEALTH(unit)
	if unit and unit ~= "target" and _G.UnitAffectingCombat(unit) and 
		 _G.UnitHealth(unit) > 0 and not _G.UnitIsDeadOrGhost(unit) then
			if unit == "player" then
				local flashRestart
				local percentage = _G.UnitHealth(unit) / _G.UnitHealthMax(unit)
				if percentage < (db["ThresholdCritHealth"] or DEFAULT_ThresholdCritHealth) and 
						(not LastPercentageHealth[unit] or 
						 LastPercentageHealth[unit] >= (db["ThresholdCritHealth"] or DEFAULT_ThresholdCritHealth)) then
					if db["FlashFrameHealth"] then
						AdjustFlashRate(LowHealthFrame, (2.0 * percentage) + 0.5)
						flashRestart = true
					end
					if db["Heartbeat"] then
						self:ScheduleRepeatingEvent( "Heartbeat", PlayHeartbeatSound, (2.0 * percentage) + 0.5 )
					end
					self:MessageLogUpdate(VitalWatchLocale.Floating_Message_Self_CritHealth,
																db["ColourCritHealthR"] or 1,
																db["ColourCritHealthG"] or 0,
																db["ColourCritHealthB"] or 0,
																nil,
																unit)
					if not db["DisableMessageFrameHealth"] then
						MessageFrame_AddMessage(MessageFrame, 
																		MessageLog[NumMessageLog].text,
																		MessageLog[NumMessageLog].r,
																		MessageLog[NumMessageLog].g,
																		MessageLog[NumMessageLog].b,
																		MessageFrameMessageAlpha,
																		MessageFrameHoldTime)
					end
					local skipsound
					tmp = db["EmoteCritHealth"]
	    		if tmp and not playerInBG then
						local doEmote
						_,_,doEmote = strfind(tmp, "^/(.+)")
						if doEmote then
							_,_,NextQueuedDoEmote = doEmote
							skipsound = true
						else
							NextQueuedEmote = tmp
						end
					end
					tmp = db["SoundCritHealth"]
					if not skipsound and tmp ~= "DISABLED" then
						_G.PlaySoundFile( (tmp ~= nil and (SoundPath .. tmp .. ".wav") ) or DEFAULT_SoundCritHealth)
					end	
					tmp = db["MsgChan"]
					if not db["DisableMsg"] and 
					 db["MsgCritHealth"] ~= "DISABLED" and not playerInBG and 
					 ((tmp and tmp ~= "PARTY" and tmp ~= "RAID") or 
					  ((not tmp or tmp == "PARTY") and _G.GetNumPartyMembers() > 0) or 
						(tmp == "RAID" and _G.GetNumRaidMembers() > 0)) then
							-------
					 		NextQueuedMessage =  "<< " ..
																	 (db["MsgCritHealth"] or VitalWatchLocale.DEFAULT_MsgCritHealth) ..
																	 " >>"
							NextQueuedMessageChan = db["MsgChan"] or "PARTY"
							NextQueuedMessagePriority = 4
							--------
					end
				elseif percentage < (db["ThresholdLowHealth"] or DEFAULT_ThresholdLowHealth) and 
						(not LastPercentageHealth[unit] or 
						 LastPercentageHealth[unit] >= (db["ThresholdLowHealth"] or DEFAULT_ThresholdLowHealth)) then
					if db["FlashFrameHealth"] then
						AdjustFlashRate(LowHealthFrame, (2.0 * percentage) + 0.5)
						flashRestart = true
					end
					if db["Heartbeat"] then
						self:ScheduleRepeatingEvent( "Heartbeat", PlayHeartbeatSound, (2.0 * percentage) + 0.5 )
					end
					self:MessageLogUpdate(VitalWatchLocale.Floating_Message_Self_LowHealth,
																db["ColourLowHealthR"] or 1,
																db["ColourLowHealthG"] or 0,
																db["ColourLowHealthB"] or 0,
																nil,
																unit)
					if not db["DisableMessageFrameHealth"] then
						MessageFrame_AddMessage(MessageFrame, 
																		MessageLog[NumMessageLog].text,
																		MessageLog[NumMessageLog].r,
																		MessageLog[NumMessageLog].g,
																		MessageLog[NumMessageLog].b,
																		MessageFrameMessageAlpha,
																		MessageFrameHoldTime)
					end
					local skipsound
					tmp = db["EmoteLowHealth"]
		    	if tmp and not playerInBG then
						local doEmote
						_,_,doEmote = strfind(tmp, "^/(.+)")
						if doEmote then
							_,_,NextQueuedDoEmote = doEmote
							skipsound = true
						else
							NextQueuedEmote = tmp
						end
					end
					tmp = db["SoundLowHealth"]
					if not skipsound and tmp ~= "DISABLED" then
						_G.PlaySoundFile( (tmp ~= nil and (SoundPath .. tmp .. ".wav") ) or DEFAULT_SoundLowHealth)
					end	
					tmp = db["MsgChan"] 
					if not db["DisableMsg"] and NextQueuedPriority == nil and 
					 db["MsgLowHealth"] and not playerInBG and 
					 ((tmp and tmp ~= "PARTY" and tmp ~= "RAID") or 
					  ((not tmp or tmp == "PARTY") and _G.GetNumPartyMembers() > 0) or 
						(tmp == "RAID" and _G.GetNumRaidMembers() > 0)) then
							-----
					 		NextQueuedMessage =  "<< " ..
																	 db["MsgLowHealth"] ..
																	 " >>"
							NextQueuedMessageChan = db["MsgChan"] or "PARTY"
							NextQueuedMessagePriority = 3
							-----
					end
				end
				if db["FlashFrameHealth"] and not flashRestart then
					_G.UIFrameFlashRemoveFrame(LowHealthFrame)
					_G.UIFrameFadeRemoveFrame(LowHealthFrame)
					if LowHealthFrame:IsVisible() then LowHealthFrame:Hide() end
				end
				LastPercentageHealth[unit] = percentage	
			elseif UnitIsPlayer(unit) then 
				local _,c = _G.UnitClass(unit)
				local name = (UnitName(unit)) or "Name Unknown"
				if ((db["HealthWatch"] and db["HealthWatch"] > 1 and _G.UnitInParty(unit)) or 
						(db["HealthWatch"] == 3 and _G.UnitInRaid(unit))) and 
					 (not db["HealthNoWatchClass"] or not db["HealthNoWatchClass"][c]) and 
					 (not db["HealthNoWatchName"] or not db["HealthNoWatchName"][name]) then
					 		-------
 							self:ProcessUnitHealthOther(unit, name, class)
							-------
				end
			elseif db["PetHealthWatch"] ~= 1 and unit == "pet" then
				self:ProcessUnitHealthOther(unit, (UnitName(unit)) or "Name Unknown", nil, VitalWatchLocale.MyPetTag)
			elseif (db["PetHealthWatch"] and db["PetHealthWatch"] > 1 and _G.UnitPlayerOrPetInParty(unit)) or
						 (db["PetHealthWatch"] == 3 and _G.UnitPlayerOrPetInRaid(unit)) then
				self:ProcessUnitHealthOther(unit, (UnitName(unit)) or "Name Unknown", nil, VitalWatchLocale.PetTag)
			end
		end
end

function VitalWatch:UNIT_MANA(unit)
	if unit and unit ~= "target" and _G.UnitAffectingCombat(unit) and 
		 _G.UnitMana(unit) > 0 and not _G.UnitIsDeadOrGhost(unit) and _G.UnitPowerType(unit) == 0 then
			if unit == "player" then
				local flashRestart
				local percentage = _G.UnitMana(unit) / UnitManaMax(unit)
				if percentage < (db["ThresholdCritMana"] or DEFAULT_ThresholdCritMana) and 
					(not LastPercentageMana[unit] or 
					LastPercentageMana[unit] >= (db["ThresholdCritMana"] or DEFAULT_ThresholdCritMana)) then
					if db["FlashFrameMana"] then
						AdjustFlashRate(OutOfControlFrame, (2.0 * percentage) + 0.5)
						flashRestart = true
					end
					self:MessageLogUpdate(VitalWatchLocale.Floating_Message_Self_CritMana,
																db["ColourCritManaR"] or 1,
																db["ColourCritManaG"] or 0,
																db["ColourCritManaB"] or 0,
																nil,
																unit)
					if not db["DisableMessageFrameMana"] then
						MessageFrame_AddMessage(MessageFrame, 
																		MessageLog[NumMessageLog].text,
																		MessageLog[NumMessageLog].r,
																		MessageLog[NumMessageLog].g,
																		MessageLog[NumMessageLog].b,
																		MessageFrameMessageAlpha,
																		MessageFrameHoldTime)
					end
					local skipsound
					tmp = db["EmoteCritMana"]
	    		if tmp ~= "DISABLED" and not playerInBG then
						local doEmote
            _,_,doEmote = strfind(tmp or VitalWatchLocale.DEFAULT_EmoteCritMana, "^/(.+)") end
						if doEmote then
							NextQueuedDoEmote = doEmote 
							skipsound = true
						else
							NextQueuedEmote = tmp
						end
					end
					tmp = db["SoundCritMana"]
					if not skipsound and tmp then
						_G.PlaySoundFile( SoundPath .. tmp .. ".wav" )
					end	
					tmp = db["MsgChan"]
					if not db["DisableMsg"] and db["MsgCritMana"] and not playerInBG and 
					 ((tmp and tmp ~= "PARTY" and tmp ~= "RAID") or 
					  ((not tmp or tmp == "PARTY") and _G.GetNumPartyMembers() > 0) or 
						(tmp == "RAID" and _G.GetNumRaidMembers() > 0)) then
							-------
					 		NextQueuedMessage =  "<< " ..
																	 db["MsgCritMana"] ..
																	 " >>"
							NextQueuedMessageChan = db["MsgChan"] or "PARTY"
							NextQueuedMessagePriority = 3
							--------
					end
				elseif percentage < (db["ThresholdLowMana"] or DEFAULT_ThresholdLowMana) and 
						(not LastPercentageMana[unit] or 
						 LastPercentageMana[unit] >= (db["ThresholdLowMana"] or DEFAULT_ThresholdLowMana)) then
					if db["FlashFrameMana"] then
						AdjustFlashRate(OutOfControlFrame, (2.0 * percentage) + 0.5)
						flashRestart = true
					end
					self:MessageLogUpdate(VitalWatchLocale.Floating_Message_Self_LowMana,
																db["ColourLowManaR"] or 1,
																db["ColourLowManaG"] or 0,
																db["ColourLowManaB"] or 0,
																nil,
																unit)
					if not db["DisableMessageFrameMana"] then
						MessageFrame_AddMessage(MessageFrame, 
																		MessageLog[NumMessageLog].text,
																		MessageLog[NumMessageLog].r,
																		MessageLog[NumMessageLog].g,
																		MessageLog[NumMessageLog].b,
																		MessageFrameMessageAlpha,
																		MessageFrameHoldTime)
					end
					local skipsound
					tmp = db["EmoteLowMana"]
		    	if tmp and not playerInBG then
						local doEmote
						_,_,doEmote = strfind(tmp, "^/(.+)")
						if doEmote then
							_,_,NextQueuedDoEmote = doEmote
							skipsound = true
						else
							NextQueuedEmote = tmp
						end
					end
					tmp = db["SoundLowMana"]
					if not skipsound and tmp then
						_G.PlaySoundFile( SoundPath .. tmp .. ".wav" )
					end	
					tmp = db["MsgChan"] 
					if not db["DisableMsg"] and 
						(not NextQueuedMessagePriority or NextQueuedMessagePriority < 3) and
						db["MsgLowMana"] and not playerInBG and 
					 ((tmp and tmp ~= "PARTY" and tmp ~= "RAID") or 
					  ((not tmp or tmp == "PARTY") and _G.GetNumPartyMembers() > 0) or 
						(tmp == "RAID" and _G.GetNumRaidMembers() > 0)) then
							-----
					 		NextQueuedMessage =  "<< " ..
																	 db["MsgLowMana"] ..
																	 " >>"
							NextQueuedMessageChan = db["MsgChan"] or "PARTY"
							NextQueuedMessagePriority = 2
							-----
					end
				end
				if db["FlashFrameMana"] and not flashRestart then
					_G.UIFrameFlashRemoveFrame(OutOfControlFrame)
					_G.UIFrameFadeRemoveFrame(OutOfControlFrame)
					if OutOfControlFrame:IsVisible() then OutOfControlFrame:Hide() end
				end
				LastPercentageMana[unit] = percentage	
			elseif UnitIsPlayer(unit) then 
				local _,c = _G.UnitClass(unit)
				local name = (UnitName(unit)) or "Name Unknown"
				if ((db["ManaWatch"] and db["ManaWatch"] > 1 and _G.UnitInParty(unit)) or 
						(db["ManaWatch"] == 3 and _G.UnitInRaid(unit))) and 
					 (not db["ManaNoWatchClass"] or not db["ManaNoWatchClass"][c]) and 
					 (not db["ManaNoWatchName"] or not db["ManaNoWatchName"][name]) then
							local percentage = _G.UnitMana(unit) / UnitManaMax(unit)
							if percentage < (db["ThresholdCritMana"] or DEFAULT_ThresholdCritMana) and 
		 					(not LastPercentageMana[unit] or 
		 					 LastPercentageMana[unit] >= (db["ThresholdCritMana"] or DEFAULT_ThresholdCritMana)) then
									if c and ClassColors[c] then
										self:MessageLogUpdate("|cFF" .. ClassColors[class] .. name .. "|r" ..
				  																VitalWatchLocale.Floating_Message_CritMana,
																					db["ColourCritManaOtherR"] or 0,
																					db["ColourCritManaOtherG"] or 0,
																					db["ColourCritManaOtherB"] or 1,
																					name,
																					unit)
									else
										self:MessageLogUpdate(name .. VitalWatchLocale.Floating_Message_CritMana,
																					db["ColourCritManaOtherR"] or 0,
																					db["ColourCritManaOtherG"] or 0,
																					db["ColourCritManaOtherB"] or 1,
																					name,
																					unit)
									end
									if not db["DisableMessageFrameMana"] then
										MessageFrame_AddMessage(MessageFrame, 
																						MessageLog[NumMessageLog].text,
																						MessageLog[NumMessageLog].r,
																						MessageLog[NumMessageLog].g,
																						MessageLog[NumMessageLog].b,
																						MessageFrameMessageAlpha,
																						MessageFrameHoldTime)
									end
									tmp = db["SoundCritManaOther"]
									if not skipsound and tmp then
										_G.PlaySoundFile( SoundPath .. tmp .. ".wav" )
									end	
									tmp = db["MsgChanOther"]
									if not db["DisableMsg"] and 
									 (not NextQueuedMessagePriority or NextQueuedMessagePriority < 3) and 
									 db["MsgOtherCritMana"] and not playerInBG and 
									 ((tmp and tmp ~= "PARTY" and tmp ~= "RAID") or 
									 ((not tmp or tmp == "PARTY") and _G.GetNumPartyMembers() > 0) or 
									 (tmp == "RAID" and _G.GetNumRaidMembers() > 0)) then
					 						-------
											NextQueuedMessage = "<< " ..
																					name .. 
																					db["MsgOtherCritMana"] ..
																					" (" .. UnitClass(unit) ..
																					") >>"
											NextQueuedMessageChan = db["MsgChanOther"] or "PARTY"
											NextQueuedMessagePriority = 2
											--------
									end
							elseif percentage < (db["ThresholdLowMana"] or DEFAULT_ThresholdLowMana) and 
								(not LastPercentageMana[unit] or 
								LastPercentageMana[unit] >= (db["ThresholdLowMana"] or DEFAULT_ThresholdLowMana)) then
										if c and ClassColors[c] then
											self:MessageLogUpdate("|cFF" .. ClassColors[class] .. name .. "|r" ..
				  																	VitalWatchLocale.Floating_Message_LowMana,
																						db["ColourLowManaOtherR"] or 0,
																						db["ColourLowManaOtherG"] or 0,
																						db["ColourLowManaOtherB"] or 1,
																						nil,
																						unit)
										else
											self:MessageLogUpdate(name .. VitalWatchLocale.Floating_Message_LowMana,
																						db["ColourLowManaOtherR"] or 0,
																						db["ColourLowManaOtherG"] or 0,
																						db["ColourLowManaOtherB"] or 1,
																						nil,
																						unit)
										end
										if not db["DisableMessageFrameMana"] then
											MessageFrame_AddMessage(MessageFrame, 
																							MessageLog[NumMessageLog].text,
																							MessageLog[NumMessageLog].r,
																							MessageLog[NumMessageLog].g,
																							MessageLog[NumMessageLog].b,
																							MessageFrameMessageAlpha,
																							MessageFrameHoldTime)
										end
										tmp = db["SoundLowManaOther"]
										if not skipsound and tmp then
											_G.PlaySoundFile( SoundPath .. tmp .. ".wav" )
										end	
										tmp = db["MsgChanOther"]
										if not db["DisableMsg"] and NextQueuedMessagePriority == nil and 
										 db["MsgOtherLowMana"] and not playerInBG and 
										 ((tmp and tmp ~= "PARTY" and tmp ~= "RAID") or 
										  ((not tmp or tmp == "PARTY") and _G.GetNumPartyMembers() > 0) or 
											(tmp == "RAID" and _G.GetNumRaidMembers() > 0)) then
												-------
												NextQueuedMessage = "<< " ..
																						name .. 
																						db["MsgOtherLowMana"] ..
																						" (" .. UnitClass(unit) ..
																						") >>"
												NextQueuedMessageChan = db["MsgChanOther"] or "PARTY"
												NextQueuedMessagePriority = nil
												--------
										end
							end
							LastPercentageMana[unit] = percentage	
					end -- big-ass if statement
		end
end

function VitalWatch:RegisterAggro(victimId, atkrId, pnum, rnum)
	if not victimId or not atkrId then return end

	local name = UnitName(victimId)
	local ru = roster:GetUnitObjectFromName(name)
	local atkrName = (UnitName(atkrId)) or "Name Unknown"
	local atkrKey = atkrName .. " (" .. ((UnitLevel(atkrId)) or 0) .. ")"
	local rate = ((UnitIsUnit("player", victimId) and (db["AggroWatchRate"] or DEFAULT_AggroWatchRate)) or (db["AggroWatchOtherRate"] or DEFAULT_AggroWatchOtherRate))
	local time = GetTime()
	if ru and (UnitIsUnit("player", victimId) or 
		 not db["AggroNoWatchClass"] or not db["AggroNoWatchClass"][ru.class]) and 
		 (not db["AggroNoWatchName"] or not db["AggroNoWatchName"][name]) and
		 (not ru.lastAggroCheck or (time > ru.lastAggroCheck + rate and (not ru.aggroTable or not ru.aggroTable[atkrName] or (ru.aggroLevelTable and not ru.aggroLevelTable[atkrKey]) or time > ru.lastAggroCheck + (rate * 2) ))) then
		 				-----------
						if not ru.aggroTable then ru.aggroTable = {} end
						if not ru.aggroLevelTable then ru.aggroLevelTable = {} end
						if ru.lastAggroCheck and time > ru.lastAggroCheck + (rate * 2) then 
							ru.aggroCount = 0
							for k in ru.aggroTable do
								ru.aggroTable[k] = nil
							end
							for k in ru.aggroLevelTable do
								ru.aggroLevelTable[k] = nil
							end
						end
						if not ru.aggroTable[atkrName] then ru.aggroTable[atkrName] = true end
						if not ru.aggroLevelTable[atkrKey] then ru.aggroLevelTable[atkrKey] = true end
						ru.aggroCount = (ru.aggroCount or 0) + 1
						ru.lastAggroCheck = time
						ru.hasAggro = true
						if UnitIsUnit("player", victimId) then
							VitalWatch:MessageLogUpdate(VitalWatchLocale.Floating_Message_AggroGained .. 
																		" (" ..
																		ru.aggroCount ..
																		")",
																		db["ColourAggroR"] or 1,
																		db["ColourAggroG"] or 1,
																		db["ColourAggroB"] or 1,
																		atkrName,
																		atkrId)
							if db["EnableMessageFrameAggro"] then
								MessageFrame_AddMessage(MessageFrame, 
																				MessageLog[NumMessageLog].text,
																				MessageLog[NumMessageLog].r,
																				MessageLog[NumMessageLog].g,
																				MessageLog[NumMessageLog].b,
																				MessageFrameMessageAlpha,
																				MessageFrameHoldTime)
							end
							local skipsound
							tmp = db["EmoteAggro"]
		 				 	if tmp and not playerInBG then
								local doEmote
								_,_,doEmote = strfind(tmp, "^/(.+)")
								if doEmote then
									_,_,NextQueuedDoEmote = doEmote
									skipsound = true
								else
									NextQueuedEmote = tmp
								end
							end
							tmp = db["MsgAggroChan"] 
							if not db["DisableMsg"] and 
								(NextQueuedMessagePriority == nil or ru.aggroCount > 1) and db["MsgAggro"] and not playerInBG and 
				 				((tmp and tmp ~= "PARTY" and tmp ~= "RAID") or 
				  	 		((not tmp or tmp == "PARTY") and pnum > 0) or 
						 		(tmp == "RAID" and rnum > 0)) then
						 				NextQueuedMessage = "<< " .. 
																		 		db["MsgAggro"] ..
																				" " ..
																				atkrKey ..
																				" >> (" ..
																				UnitClass(ru.unitid) ..
																				", " ..
																				VitalWatchLocale.aggrocount .. 
																				ru.aggroCount ..
																				")"
							      NextQueuedMessageChan = db["MsgAggroChan"] or "PARTY"
										NextQueuedMessagePriority = true
							end
							if not skipsound and db["SoundAggro"] then
								_G.PlaySoundFile( SoundPath .. db["SoundAggro"] .. ".wav" )
							end
						else -- other players
							VitalWatch:MessageLogUpdate("|cFF" ..
																		ClassColors[ru.class] ..
																		name .. 
																		"|r" ..
																		VitalWatchLocale.Floating_Message_AggroGainedOther ..
																		" (" ..
																		ru.aggroCount ..
																		")",
																		db["ColourAggroOtherR"] or 0.8,
																		db["ColourAggroOtherG"] or 0.8,
																		db["ColourAggroOtherB"] or 0.8,
																		atkrName,
																		atkrId)
							if db["EnableMessageFrameAggro"] then
								MessageFrame_AddMessage(MessageFrame, 
																				MessageLog[NumMessageLog].text,
																				MessageLog[NumMessageLog].r,
																				MessageLog[NumMessageLog].g,
																				MessageLog[NumMessageLog].b,
																				MessageFrameMessageAlpha,
																				MessageFrameHoldTime)
							end
							tmp = db["MsgAggroChanOther"]
							if not db["DisableMsg"] and db["MsgAggroOther"] and not playerInBG and 
								(NextQueuedMessagePriority == nil or ru.aggroCount > 1) and
				 				((tmp and tmp ~= "PARTY" and tmp ~= "RAID") or 
				  			 ((not tmp or tmp == "PARTY") and pnum > 0) or 
								 (tmp == "RAID" and rnum > 0)) then
										NextQueuedMessage = "<< " ..
																				name ..
																		 		db["MsgAggroOther"] ..
																				" " ..
																				atkrKey ..
																				" >> (" ..
																				UnitClass(ru.unitid) ..
																				", " ..
																				VitalWatchLocale.aggrocount .. 
																				ru.aggroCount ..
																				")"
																				
										NextQueuedMessageChan = db["MsgAggroChanOther"] or "PARTY"
										NextQueuedMessagePriority = nil
							end
							if db["SoundAggroOther"] then
								_G.PlaySoundFile( SoundPath .. db["SoundAggroOther"] .. ".wav" )
							end
		end
	end
end

function VitalWatch:IterateAggroTargets()
	if db["AggroTargetWatch"] and roster and roster.roster then
		local victimId, atkrId, tuid, ttuid, ru,name,attkrName,rate,time
		local pnum,rnum = _G.GetNumPartyMembers(), _G.GetNumRaidMembers()
		for i in roster.roster do
			ru = roster.roster[i]
			tuid = ru.unitid .. "target"
			ttuid = ru.unitid .. "targettarget"
			victimId, atkrId = nil, nil
			if ru and ru.unitid and UnitExists(ru.unitid) and UnitExists(tuid) and UnitExists(ttuid) then
				if UnitCanAttack(tuid, ttuid) and (UnitIsUnit("player", ttuid) or 
			  	 (db["AggroTargetWatch"] > 1 and UnitInParty(ttuid)) or (db["AggroTargetWatch"] == 3 and 
					 UnitInRaid(ttuid))) then 
								victimId = ttuid 
								atkrId = tuid
				elseif UnitCanAttack(ttuid, tuid) and (UnitIsUnit("player", tuid) or 
			   		(db["AggroTargetWatch"] > 1 and UnitInParty(tuid)) or (db["AggroTargetWatch"] == 3 and 
				 		UnitInRaid(tuid))) then 
								victimId = tuid 
								atkrId = ttuid
				end
			end
			if victimId and atkrId and _G.UnitAffectingCombat(atkrId) and _G.UnitAffectingCombat(victimId) then
				self:RegisterAggro(victimId, atkrId, pnum, rnum)
			end
		end
	end
end

function VitalWatch:CheckAggroToT()
	local unitid
	if _G.event == "PLAYER_TARGET_CHANGED" then unitid = "target"
	else unitid = "mouseover" end
	local victimId, atkrId, tuid, ttuid, ru,c,name,attkrName,rate,time
	local pnum,rnum = _G.GetNumPartyMembers(), _G.GetNumRaidMembers()
	tuid = unitid .. "target"
	ttuid = unitid .. "targettarget"
	if unitid and UnitExists(unitid) and UnitExists(tuid) then
		if UnitCanAttack(unitid, tuid) and (UnitIsUnit("player", tuid) or (db["AggroTargetWatch"] > 1 and 
			 UnitInParty(tuid)) or (db["AggroTargetWatch"] == 3 and UnitInRaid(tuid))) then 
			 		victimId = tuid 
			 		atkrId = unitid
		elseif UnitExists(ttuid) then
			if UnitCanAttack(tuid, ttuid) and (UnitIsUnit("player", ttuid) or 
			   (db["AggroTargetWatch"] > 1 and UnitInParty(ttuid)) or (db["AggroTargetWatch"] == 3 and 
				 UnitInRaid(ttuid))) then 
						victimId = ttuid 
						atkrId = tuid
			elseif UnitCanAttack(ttuid, tuid) and (UnitIsUnit("player", tuid) or 
			   (db["AggroTargetWatch"] > 1 and UnitInParty(tuid)) or (db["AggroTargetWatch"] == 3 and 
				 UnitInRaid(tuid))) then 
						victimId = tuid 
						atkrId = ttuid
			end
		end
	end
	if victimId and atkrId and _G.UnitAffectingCombat(atkrId) and _G.UnitAffectingCombat(victimId) then
		self:RegisterAggro(victimId, atkrId, pnum, rnum)
	end
end

function VitalWatch:CheckAggroLog(event, info)
	if db["AggroLogWatch"] and info and info.victim and info.source then 
		local ru = roster:GetUnitObjectFromName((info.victim == _G.ParserLib_SELF and (UnitName("player"))) or info.victim)
		local rate, time
		if ru and (UnitIsUnit("player", ru.unitid) or (db["AggroLogWatch"] > 1 and UnitInParty(ru.unitid)) or 
			 (db["AggroLogWatch"] == 3 and UnitInRaid(ru.unitid))) then
			rate = ((UnitIsUnit("player", ru.unitid) and (db["AggroWatchRate"] or 1)) or (db["AggroWatchOtherRate"] or 5))
			time = GetTime()
			if (UnitIsUnit("player", ru.unitid) or 
					not db["AggroNoWatchClass"] or not db["AggroNoWatchClass"][ru.class]) and 
					(not db["AggroNoWatchName"] or not db["AggroNoWatchName"][ru.name]) and
					(not ru.lastAggroCheck or (time > ru.lastAggroCheck + rate and (not ru.aggroTable or not ru.aggroTable[info.source] or time > ru.lastAggroCheck + (rate * 2) ))) then
					if not ru.aggroTable then ru.aggroTable = {} end
					if ru.lastAggroCheck and time > ru.lastAggroCheck + (rate * 2) then 
						ru.aggroCount = 0
						for k in ru.aggroTable do
							ru.aggroTable[k] = nil
						end
						for k in ru.aggroLevelTable do
							ru.aggroLevelTable[k] = nil
						end
					end
					if not ru.aggroTable[info.source] then ru.aggroTable[info.source] = true end
					ru.aggroCount = (ru.aggroCount or 0) + 1
					ru.lastAggroCheck = time
					ru.hasAggro = true
					if UnitIsUnit("player", ru.unitid) then
						VitalWatch:MessageLogUpdate(VitalWatchLocale.AGGRO ..
																	_G.arg1 ..
																	" << " .. ru.aggroCount .. " >>",
																	db["ColourAggroR"] or 1,
																	db["ColourAggroG"] or 1,
																	db["ColourAggroB"] or 1,
																	info.source)
						if db["EnableMessageFrameAggro"] then
							MessageFrame_AddMessage(MessageFrame, 
																			MessageLog[NumMessageLog].text,
																			MessageLog[NumMessageLog].r,
																			MessageLog[NumMessageLog].g,
																			MessageLog[NumMessageLog].b,
																			MessageFrameMessageAlpha,
																			MessageFrameHoldTime)
						end
						local skipsound
						tmp = db["EmoteAggro"]
		   			if tmp and not playerInBG then
							local doEmote
							_,_,doEmote = strfind(tmp, "^/(.+)")
							if doEmote then
								_,_,NextQueuedDoEmote = doEmote
								skipsound = true
							else
								NextQueuedEmote = tmp
							end
						end
						tmp = db["MsgAggroChan"] 
						if not db["DisableMsg"] and 
							(NextQueuedMessagePriority == nil or 
							 NextQueuedMessagePriority == 1 or ru.aggroCount > 1) and 
							db["MsgAggro"] and not playerInBG and 
					 		((tmp and tmp ~= "PARTY" and tmp ~= "RAID") or 
					  		((not tmp or tmp == "PARTY") and _G.GetNumPartyMembers() > 0) or 
								(tmp == "RAID" and _G.GetNumRaidMembers() > 0)) then
										NextQueuedMessage = "<< " ..
																				VitalWatchLocale.AGGRO ..
																				_G.arg1 ..
																				" >> (" ..
																				UnitClass(ru.unitid) ..
																				", " ..
																				VitalWatchLocale.aggrocount .. 
																				ru.aggroCount ..
																				")"

								    NextQueuedMessageChan = db["MsgAggroChan"] or "PARTY"
										NextQueuedMessagePriority = 1
						end
						if not skipsound and db["SoundAggro"] then
							_G.PlaySoundFile( SoundPath .. db["SoundAggro"] .. ".wav" )
						end
					elseif ru.class and ru.class ~= "PET" then
						VitalWatch:MessageLogUpdate(VitalWatchLocale.AGGRO ..
																	string.gsub(_G.arg1, ru.name, 
																	"|cFF" .. (ClassColors[ru.class] or "FFFFFF") .. 
																	ru.name .. "|r", 1) ..
																	" << " .. ru.aggroCount .. " >>",
																	db["ColourAggroOtherR"] or 0.8,
																	db["ColourAggroOtherG"] or 0.8,
																	db["ColourAggroOtherB"] or 0.8,
																	info.source)
						if db["EnableMessageFrameAggro"] then
							MessageFrame_AddMessage(MessageFrame, 
																			MessageLog[NumMessageLog].text,
																			MessageLog[NumMessageLog].r,
																			MessageLog[NumMessageLog].g,
																			MessageLog[NumMessageLog].b,
																			MessageFrameMessageAlpha,
																			MessageFrameHoldTime)
						end
						tmp = db["MsgAggroChanOther"] 
						if not db["DisableMsg"] and 
							(NextQueuedMessagePriority == nil or ru.aggroCount > 1) and 
							db["MsgAggroOther"] and not playerInBG and 
					 		((tmp and tmp ~= "PARTY" and tmp ~= "RAID") or 
					  		((not tmp or tmp == "PARTY") and _G.GetNumPartyMembers() > 0) or 
								(tmp == "RAID" and _G.GetNumRaidMembers() > 0)) then
										NextQueuedMessage = "<< " ..
																				VitalWatchLocale.AGGRO ..
																				_G.arg1 ..
																				" >> (" ..
																				UnitClass(ru.unitid) ..
																				", " ..
																				VitalWatchLocale.aggrocount .. 
																				ru.aggroCount ..
																				")"

								    NextQueuedMessageChan = db["MsgAggroChanOther"] or "PARTY"
						end
						if db["SoundAggroOther"] then
							_G.PlaySoundFile( SoundPath .. db["SoundAggroOther"] .. ".wav" )
						end
					end -- player or others check
			end -- no watch and rate check
		end -- watch check
	end -- sanity checks
end

function VitalWatch:SendQueuedMessages()
	if NextQueuedMessage and NextQueuedMessageChan then
		_G.SendChatMessage( NextQueuedMessage, NextQueuedMessageChan) 
		NextQueuedMessage = nil
		NextQueuedMessageChan = nil
		NextQueuedMessagePriority = nil
	end
	if NextQueuedEmote then
		_G.SendChatMessage( NextQueuedEmote, "EMOTE" )
		NextQueuedEmote = nil
	end
	if NextQueuedDoEmote then
		_G.DoEmote( NextQueuedDoEmote )
		NextQueuedDoEmote = nil
	end
end

function VitalWatch:StopTimers()
	NextQueuedMessage = nil
	NextQueuedEmote = nil
	NextQueuedDoEmote = nil
	NextQueuedMessageChan = nil
	NextQueuedMessagePriority = nil
	if db["FlashFrameHealth"] then
		_G.UIFrameFlashRemoveFrame(LowHealthFrame)
		_G.UIFrameFadeRemoveFrame(LowHealthFrame)
		if LowHealthFrame:IsVisible() then LowHealthFrame:Hide() end
	end
	if db["FlashFrameMana"] then
		_G.UIFrameFlashRemoveFrame(OutOfControlFrame)
		_G.UIFrameFadeRemoveFrame(OutOfControlFrame)
		if OutOfControlFrame:IsVisible() then OutOfControlFrame:Hide() end
	end
	self:CancelScheduledEvent("Heartbeat")
end

function VitalWatch:TargetByMessageLog(i)
	if MessageLog[i] then
		if MessageLog[i].id and UnitExists(MessageLog[i].id) and 
		 (not MessageLog[i].name or (_G.UnitName(id)) == MessageLog[i].name) then
			_G.TargetUnit(MessageLog[i].id)
		elseif MessageLog[i].name then
			_G.TargetUnitByName(MessageLog[i].name)
		end
	end
end

function VitalWatch:FadeOldMessagesInLog()
	if NumMessageLog > 0 then
		local numRecent = 0
		local currTime = _G.GetTime()
		local fadeTime = db["MessageLogFade"] or 15
		for i = 1,NumMessageLog do
			if currTime < MessageLog[i].time + fadeTime then
				numRecent = numRecent + 1
			end
		end
		if numRecent ~= NumMessageLog then
			local oldi
			for i = 1,numRecent do
				oldi = NumMessageLog - numRecent + i
				MessageLog[i].text = MessageLog[oldi].text
				MessageLog[i].ftext = MessageLog[oldi].ftext
				MessageLog[i].r = MessageLog[oldi].r
				MessageLog[i].g = MessageLog[oldi].g
				MessageLog[i].b = MessageLog[oldi].b
				MessageLog[i].name = MessageLog[oldi].name
				MessageLog[i].id = MessageLog[oldi].id
				MessageLog[i].time = MessageLog[oldi].time
			end
			NumMessageLog = numRecent
			self:UpdateText()
			self:UpdateTooltip()
		end
	end
end

function VitalWatch:OnTooltipUpdate()
	local cat = tablet:AddCategory("columns", 1, "showWithoutChildren", true, "hideBlankLine", false)
	if MessageLog and NumMessageLog > 0 then
		for i = 1,NumMessageLog do
			cat:AddLine('text',  MessageLog[i].ftext, 
									'textR', MessageLog[i].r,
									'textG', MessageLog[i].g,
									'textB', MessageLog[i].b,
								  'wrap', false,
									'func', self.TargetByMessageLog,
									'arg1', i)
		end
	end
end

function VitalWatch:OnTextUpdate()
	if NumMessageLog > 0 then
		self:SetText( "VW: " .. MessageLog[NumMessageLog].text )
	else
		self:SetText( "VitalWatch" )
	end
end

function VitalWatch:OnMenuRequest(level, value)
	self:LoDRun( "VitalWatchOptions", "CreateDDMenu", level, value)
end

function VitalWatch:MessageLogUpdate(text, r, g, b, name, id)
	local max = (db["MaxMessages"] or 6)
	if NumMessageLog == max then
		for i = max,2,-1 do
			MessageLog[i-1].text = MessageLog[i].text
			MessageLog[i-1].ftext = MessageLog[i].ftext
			MessageLog[i-1].r = MessageLog[i].r
			MessageLog[i-1].g = MessageLog[i].g
			MessageLog[i-1].b = MessageLog[i].b
			MessageLog[i-1].name = MessageLog[i].name
			MessageLog[i-1].id = MessageLog[i].id
			MessageLog[i-1].time = MessageLog[i].time
		end
		MessageLog[max].text = text
		MessageLog[max].r = r
		MessageLog[max].g = g
		MessageLog[max].b = b
		MessageLog[max].name = name or nil
		MessageLog[max].id = id or nil
		MessageLog[max].time = _G.GetTime()
		MessageLog[max].ftext = "[" .. _G.date('*t').sec .. "s] " .. text
	else
		NumMessageLog = NumMessageLog + 1
		if not MessageLog[NumMessageLog] then MessageLog[NumMessageLog] = {} end
		MessageLog[NumMessageLog].text = text
		MessageLog[NumMessageLog].r = r
		MessageLog[NumMessageLog].g = g
		MessageLog[NumMessageLog].b = b
		MessageLog[NumMessageLog].name = name or nil
		MessageLog[NumMessageLog].id = id or nil
		MessageLog[NumMessageLog].time = _G.GetTime()
		MessageLog[NumMessageLog].ftext = "[" .. _G.date('*t').sec .. "s] " .. text
	end
	self:UpdateTooltip()
	self:UpdateText()
end

----------------------------------------------------------------
-- Ace2 / WoW functions

function VitalWatch:OnInitialize()
	self:RegisterDB("VitalWatchDB", "VitalWatchCharDB")
	db = self.db.profile
end

function VitalWatch:OnDataUpdate()
	db = self.db.profile
end

function VitalWatch:OnEnable()
	LastPercentageHealth = {}
	LastPercentageMana = {}
	MessageLog = {}
	self:ReInitialize()
end

function VitalWatch:ReInitialize()
	self:UnregisterAllEvents()
	self:CancelAllScheduledEvents()
	db = self.db.profile
	if not roster then 
		roster = _G.AceLibrary("RosterLib-2.0")
		roster:Enable()
	end
	if parser then 
		parser:UnregisterAllEvents("VitalWatch")
		parser = nil
	end
	if db["HealthWatch"] ~= 1 then
		self:RegisterEvent("UNIT_HEALTH")
	end
	if db["ManaWatch"] ~= 1 then
		self:RegisterEvent("UNIT_MANA")
	end

	if db["FlashHealth"] or db["FlashMana"] or db["Heartbeat"] then
		self:RegisterEvent("PLAYER_DEAD", "StopTimers")
		self:RegisterEvent("PLAYER_ALIVE", "StopTimers")
		self:RegisterEvent("PLAYER_UNGHOST", "StopTimers")
	end
	if not db["DisableMessageFrameHealth"] or not db["DisableMessageFrameMana"] or db["EnableMessageFrameAggro"] then
		self:CreateMessageFrame()
	end
	if not db["EnableInBGs"] then
		self:RegisterEvent("PLAYER_ENTERING_WORLD")
	end
	if db["AggroTargetWatch"] then
		self:ScheduleRepeatingEvent("AggroTargetWatch", self.IterateAggroTargets, 0.2, self)
		self:RegisterEvent("PLAYER_TARGET_CHANGED", "CheckAggroToT")
		self:RegisterEvent("UPDATE_MOUSEOVER_UNIT", "CheckAggroToT")
	end
	if db["AggroLogWatch"] and not parser then
		parser = _G.ParserLib:GetInstance("1.1")
		parser:RegisterEvent("VitalWatch", "CHAT_MSG_COMBAT_CREATURE_VS_SELF_HITS", self.CheckAggroLog)
		parser:RegisterEvent("VitalWatch", "CHAT_MSG_COMBAT_CREATURE_VS_SELF_MISSES", self.CheckAggroLog)
		parser:RegisterEvent("VitalWatch", "CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE", self.CheckAggroLog)
		if db["AggroLogWatch"] > 1 then
			parser:RegisterEvent("VitalWatch", "CHAT_MSG_COMBAT_CREATURE_VS_CREATURE_HITS", self.CheckAggroLog)
			parser:RegisterEvent("VitalWatch", "CHAT_MSG_COMBAT_CREATURE_VS_CREATURE_MISSES", self.CheckAggroLog)
			parser:RegisterEvent("VitalWatch", "CHAT_MSG_COMBAT_CREATURE_VS_PARTY_HITS", self.CheckAggroLog)
			parser:RegisterEvent("VitalWatch", "CHAT_MSG_COMBAT_CREATURE_VS_PARTY_MISSES", self.CheckAggroLog)

			parser:RegisterEvent("VitalWatch", "CHAT_MSG_COMBAT_HOSTILEPLAYER_HITS", self.CheckAggroLog)
			parser:RegisterEvent("VitalWatch", "CHAT_MSG_COMBAT_HOSTILEPLAYER_MISSES", self.CheckAggroLog)
			parser:RegisterEvent("VitalWatch", "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE", self.CheckAggroLog)
			parser:RegisterEvent("VitalWatch", "CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE", self.CheckAggroLog)
			parser:RegisterEvent("VitalWatch", "CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE", self.CheckAggroLog)
		end
	end
	self:ScheduleRepeatingEvent("QueuedMessages", self.SendQueuedMessages, db["MsgRate"] or 0.2, self)
	self:ScheduleRepeatingEvent("FadeOldMessagesInLog", self.FadeOldMessagesInLog, db["MessageLogFade"] or 5, self)
end

function VitalWatch:OnDisable()
	self:UnregisterAllEvents()
	self:CancelAllScheduledEvents()
	roster:Disable()
	roster = nil
	parser:UnregisterAllEvents("VitalWatch")
	parser = nil
	playerInBG = nil
	LastHealthPercentage = nil
	LastManaPercentage = nil
	NumMessageLog = 0
	MessageLog = nil
end

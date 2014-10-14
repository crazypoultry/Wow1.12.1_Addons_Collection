--[[
Name: WeaponRebuff (Redux2) - 2.1
Revision: $Rev: 2000 $
Author(s): Vincent (vincent@silverdaggers.net)
Website: http://www.curse-gaming.com/en/wow/addons-3711-1-weaponrebuff-redux.html
Documentation: http://www.curse-gaming.com/en/wow/addons-3711-1-weaponrebuff-redux.html
Description: Monitors and simplifies the tedius act of reapplying buffs to weapons
	(Original Weapon Rebuff by thomas kriegel - opt)
Optional Dependencies: Ace2
]]

WeaponRebuffInfo = {
	VERSION = "2.1",
	CURRENTVERSION = 2100.0,
	NAME = "Weapon Rebuff (Redux2)",
	wrPositionLocked = 1
};


--[[ ACE2isms -------------------------------------------------------------- ]]
WeaponRebuff = AceLibrary("AceAddon-2.0"):new("AceDB-2.0", "AceEvent-2.0")
local T = AceLibrary("AceLocale-2.0"):new("WeaponRebuff")
local compost = AceLibrary("Compost-2.0")

wr = compost:Acquire()
local subtbl  = compost:Acquire()
	wr["alarm"] = subtbl
		subtbl.AlarmState16   = "Sleeping"
		subtbl.AlarmState17   = "Sleeping"

subtbl = compost:Acquire()
	wr["wepchg"] = subtbl
		subtbl.SuppressAlarm16 = nil;
		subtbl.SuppressAlarm17 = nil;
		
subtbl = compost:Acquire()
	wr["WepChargeWarning"] = subtbl
		subtbl.Supplied16 = 0;
		subtbl.Supplied17 = 0;


function WeaponRebuff:OnInitialize()	
	self:OnLoad()

	self:RegisterDB("WeaponRebuffDB")	
	self:RegisterDefaults('profile', {
    wrEnableShowText = 1,									  -- Show/Hide WR text
    wrInvisibleAddon = 0,										-- Show/Hide WR interface
    wrDisableOffhandButton = 0,							-- hides offhand button
    wrDisableRememberBuffText = 0,          -- disables buff remembering
		wrSkipReplacePopup = 1,                 -- dodges the 'you sure you want to...' dialog when a buff is active
		RememberBuffMainhandName = "-none-",    -- buff on MH
		RememberBuffOffhandName = "-none-",		  -- buff on OH
		RememberBuffMainhandType = 0,						-- type of MH buff
		RememberBuffOffhandType = 0,						-- type of OH buff
  	wrSoundAlarms = 1,										  -- sound alarms
  	wrTextAlarms = 1,  											-- text alarms
		wrChargeAlarms = 1,											-- alarms for charges
  	wrSoundAlarms_ChargeRemaining = 1,  	  -- remaining charges sound alarm
  	wrTextAlarms_ChargeRemaining = 1,  	    -- remaining charges text alarm
  	wrUseCustomSounds = 0,								  -- use custom sounds
  	wrButtonSize = 16,											-- wize of wr buttons
  	wrWarnThreshold_Charges = 5,						-- warning threshold for charges
  	wrWarnThreshold_BuffItems = 5,				  -- warking threshold for buffing items
  	wrWarnThreshold_inSeconds = 60,         -- warbing threshold in seconds
  	wrSoundIndex_BuffWarning = 3,						-- buff warning sound index
  	wrSoundIndex_BuffLost = 1,              -- bufflost warning sound index
  	wrSoundIndex_ChargeWarning = 4,         -- charge warning sound index
  	wrEnableSideBySide = 0,                 -- turns off text and displays icons side-by-side
  	wrFrameStrata = 2       								-- Framestrata HIGH, MEDIUM, LOW
})

	if not self.db.char.notFirstTime then 
		self.db.char.notFirstTime = true
		self:SetProfile('char')
	end
	
	WeaponRebuff.ChatPrintClean("|caaff0000"..WeaponRebuffInfo.NAME.."|r (ver |caa00ff00"..WeaponRebuffInfo.VERSION.."|r) "..T"WEAPONREBUFF_HELPMSG_CMDLINETEXT");

	-- [[ Register Events ]] --
	self:RegisterEvent("UNIT_INVENTORY_CHANGED", "InventoryChange")
  
  -- [[ Register Timers ]] --
  wrUpdateButtons = self:ScheduleRepeatingEvent(WeaponRebuff.ItemBuffButton_OnUpdate, 1, self)
end

function WeaponRebuff:ItemBuffButton_OnUpdate()
		self:ItemBuff_UpdateText(16);
		if self.db.profile.wrDisableOffhandButton == 0 then
			self:ItemBuff_UpdateText(17);
		end 
end

function WeaponRebuff:OnEnable()
	self:ResizeButton(self.db.profile.wrButtonSize);
	self:SetFrameStata(self.db.profile.wrFrameStrata)
	self:UpdateTextures();

  RememberBuff[16].BuffName =  self.db.profile.RememberBuffMainhandName;
	RememberBuff[17].BuffName =  self.db.profile.RememberBuffOffhandName;
	RememberBuff[16].BuffType =  self.db.profile.RememberBuffMainhandType; 
	RememberBuff[17].BuffType =  self.db.profile.RememberBuffOffhandType;    
end

function WeaponRebuff:SaveVariables()
	self.db.profile.RememberBuffMainhandName = RememberBuff[16].BuffName;
	self.db.profile.RememberBuffOffhandName  = RememberBuff[17].BuffName;
	self.db.profile.RememberBuffMainhandType = RememberBuff[16].BuffType;
	self.db.profile.RememberBuffOffhandType  = RememberBuff[17].BuffType;
end

function WeaponRebuff:OnProfileDisable()
  -- this is called every time your profile changes (before the change)
	-- intentionally left blank
end

function WeaponRebuff:OnProfileEnable()
  -- this is called every time your profile changes (after the change)
	-- intentionally left blank
end

function WeaponRebuff:OnDisable()
	-- [[ UnRegister Events ]] --
	self:UnregisterEvent("UNIT_INVENTORY_CHANGED")
  
  -- [[ UnRegister Timers ]] --
	self:CancelScheduledEvent(wrUpdateButtons)	
end


--[[ Options Window -------------------------------------------------------------- ]]
function WeaponRebuff:ShowOptions()
	wrOptions:Show();

	if self.db.profile.wrInvisibleAddon == 1 then
		wrInvisibleAddonCheckbutton:SetChecked(true);
	end
	if self.db.profile.wrDisableOffhandButton == 1 then
		wrDisableOffhandCheckbutton:SetChecked(true);
	end
	if self.db.profile.wrDisableRememberBuffText == 1 then
		wrRebuffDisableRememberBuffTextCheckbutton:SetChecked(true);
	end
	if self.db.profile.wrSkipReplacePopup == 1 then
		wrSkipReplacePopupCheckbutton:SetChecked(true);
	end
	if self.db.profile.wrSoundAlarms == 1 then
		wrSoundAlarmsCheckbutton:SetChecked(true)
	end
	if self.db.profile.wrTextAlarms == 1 then
		wrTextAlarmsCheckbutton:SetChecked(true)
	end
	if self.db.profile.wrSoundAlarms_ChargeRemaining == 1 then
		wrSoundChargeAlarmsCheckbutton:SetChecked(true)
	end
	if self.db.profile.wrTextAlarms_ChargeRemaining == 1 then
		wrTextChargeAlarmsCheckbutton:SetChecked(true)
	end
	if self.db.profile.wrChargeAlarms == 1 then
		wrLowChargeAlarmsCheckbutton:SetChecked(true)
	end
	if self.db.profile.wrEnableShowText == 1 then
		wrEnableShowTextCheckButton:SetChecked(true)	
	end
	if self.db.profile.wrUseCustomSounds == 1 then
		wrUseCustomSoundsCheckButton:SetChecked(true)	
	end
	if self.db.profile.wrEnableSideBySide == 1 then
		wrEnableSideBySideCheckButton:SetChecked(true)	
	end	

end

function WeaponRebuff:SaveAndExit_Onclick()
--	self:SaveVariables()
	wrOptions:Hide();
end

function WeaponRebuff:GetItemName(bag, slot)
 -- Courtesy Capnbry @ capnbry.net/wow
  local linktext = nil;
  
  if (bag == -1) then
  	linktext = GetInventoryItemLink("player", slot);
  else
  	linktext = GetContainerItemLink(bag, slot);
  end

  if linktext then
    local _,_,name = string.find(linktext, "^.*%[(.*)%].*$");
    return name;
  else
    return "";
  end;
end;



--[[ Plugin Helper Functions -------------------------------------------------------------- ]]
function WeaponRebuff:SetPluginData_fmSlot(slot, TimeRemaining, wrSuffix, wrColor, text)
	-- 	"|caaaaddff".."|r"
	
	if ( slot == 16 ) then	
		wr_forPlugin_TimeLeftMain = wrColor..TimeRemaining..wrSuffix.."|r"
		wr_forPlugin_Tooltip_Main = wrColor..text.."|r"
	elseif ( slot == 17 ) then
		wr_forPlugin_TimeLeftOff = wrColor..TimeRemaining..wrSuffix.."|r"
		wr_forPlugin_Tooltip_Off = wrColor..text.."|r"
	end
		
	if self.db.profile.wrDisableOffhandButton == 1 or not GetInventoryItemTexture("player", 17) then
		wr_forPlugin_DisableOffhand = 1
		wr_PlugIn_Caption = "m"..wr_forPlugin_TimeLeftMain
		wr_PlugIn_Tooltip	= "Main Hand".."\t"..wr_forPlugin_Tooltip_Main
	else 
		wr_forPlugin_DisableOffhand = 0
		wr_PlugIn_Caption =  "m"..wr_forPlugin_TimeLeftMain.." / ".."o"..wr_forPlugin_TimeLeftOff
		wr_PlugIn_Tooltip	=  "Main Hand".."\t"..wr_forPlugin_Tooltip_Main.."\n".. "Off Hand".."\t"..wr_forPlugin_Tooltip_Off;
	end	
end

--[[ Print Messages -------------------------------------------------------------- ]]

WeaponRebuff.ChatPrint = function( msgKey, msgHighlight, msgAdditional, r, g, b )
    local msgOutput = DEFAULT_CHAT_FRAME;
    if msgKey				 == "" then return; end;
    if msgHighlight  == nil or msgHighlight  == "" then msgHighlight  = " "; end;
    if msgAdditional == nil or msgAdditional == "" then msgAdditional = " "; end;
    if( msgOutput ) then
        msgOutput:AddMessage( "|caaff0000WeaponRebuff|r|caaffff00>|r "..msgKey.." |caaaaddff"..msgHighlight.."|r"..msgAdditional, r, g, b );
    end
end;

WeaponRebuff.ChatPrintShort = function( msgKey, msgHighlight, msgAdditional, r, g, b )
    local msgOutput = DEFAULT_CHAT_FRAME;
    if msgKey				 == "" then return; end;
    if msgHighlight  == nil or msgHighlight  == "" then msgHighlight  = " "; end;
    if msgAdditional == nil or msgAdditional == "" then msgAdditional = " "; end;
    if( msgOutput ) then
        msgOutput:AddMessage( "|caaff0000WR|r|caaffff00>|r "..msgKey.." |caaaaddff"..msgHighlight.."|r"..msgAdditional, r, g, b );
    end
end;

WeaponRebuff.ChatPrintClean = function( msgKey )
    local msgOutput = DEFAULT_CHAT_FRAME;
    if msgKey == "" then return; end;
    if( msgOutput ) then
        msgOutput:AddMessage( msgKey );
    end
end;

--[[ Alarm Suppressors ---------------------------------------------------------- ]]

function WeaponRebuff:ToggleOff_SuppressAlarm(slotAlarmSuppress, slot)
	if ( slot == 16 ) then
		wr.wepchg.SuppressAlarm16 = slotAlarmSuppress
	elseif ( slot == 17 ) then
		wr.wepchg.SuppressAlarm17 = slotAlarmSuppress
	end
end

function WeaponRebuff:InventoryChange()
	wr.wepchg.SuppressAlarm16 = "TRUE";
	wr.wepchg.SuppressAlarm17 = "TRUE";
	self:UpdateTextures();
	self:ItemBuffButton_OnUpdate() -- Speeds up the text matching the icons (under 1sec)
end


--[[ Loding/Saving and Controls--------------------------------------------------- ]]

function WeaponRebuff:OnLoad()
-- Setup:

wrColor = compost:AcquireHash(
	'red',      "|caaff0000",
	'yellow',   "|caaffff00",
	'green',    "|caa00ff00",
	'copper',   "|caaeda55f",
	'lte_blue', "|caaaaddff",
	'orange',   "|caaff7f00",
	'white', 	  "|caaffffff",
 	'silver', 	"|caac7c7cf",
	'gold', 		"|caaffd700"	
)

-- Init ---
RememberBuff = compost:Acquire()
RememberBuff[16]={BuffName='',BuffType=1}
RememberBuff[17]={BuffName='',BuffType=1}


-- since these are used by the plugins, I'm loathed ---
--   to have to re-synch the version again 
wr_forPlugin_Tooltip_Main = "";
wr_forPlugin_TimeLeftMain = wrColor.red.."-";
wr_forPlugin_Tooltip_Off  = "";
wr_forPlugin_TimeLeftOff  = wrColor.red.."-";
wr_forPlugin_DisableOffhand = 0
--------------------------------------------------------

-- WeaponRebuff_AlarmState16 = "Sleeping";
-- WeaponRebuff_AlarmState17 = "Sleeping";

-- wr_WepChg_SuppressAlarm16 = nil;
-- wr_WepChg_SuppressAlarm17 = nil;

-- wr_WepChargeWarning_Supplied16 = 0;
-- wr_WepChargeWarning_Supplied17 = 0;


	SlashCmdList["WEAPONREBUFF"] = function(...)
		if(arg[1] == "lock") then
			WeaponRebuffInfo.wrPositionLocked = 1
			WeaponRebuff.ChatPrint(T"WEAPONREBUFF_HELPMSG_LOCKED");
			WeaponBuffBar:StopMovingOrSizing();
			self:SavePosition();
		
		elseif(arg[1] == "unlock") then
			WeaponRebuffInfo.wrPositionLocked = 0
			WeaponRebuff.ChatPrint(T"WEAPONREBUFF_HELPMSG_UNLOCKED");
		
		elseif(arg[1] == "reset") then
			self:ResizeButton(16) -- default
			WeaponBuffBar:ClearAllPoints();
			WeaponBuffBar:SetPoint("CENTER", "UIParent", "CENTER", 0, 0);
			WeaponRebuff.ChatPrint(T"WEAPONREBUFF_HELPMSG_POSRESET");			
			
		elseif(string.find(arg[1], "charges")) then
			self.db.profile.wrWarnThreshold_Charges = self:GetFirstNumber(arg[1]);
			self:SaveVariables();
			WeaponRebuff.ChatPrint(T"WEAPONREBUFF_SHOWMSG_UPDATEDCHARGETHRESHOLD", self.db.profile.wrWarnThreshold_Charges);
			
		elseif(string.find(arg[1], "buffitems")) then
			self.db.profile.wrWarnThreshold_BuffItems = self:GetFirstNumber(arg[1]);
			self:SaveVariables();	  	
			WeaponRebuff.ChatPrint(T"WEAPONREBUFF_SHOWMSG_UPDATEDBUFFITEMTHRESHOLD", self.db.profile.wrWarnThreshold_BuffItems);			

		elseif(string.find(arg[1], "setseconds")) then
			self.db.profile.wrWarnThreshold_inSeconds = self:GetFirstNumber(arg[1]);
			self:SaveVariables();	  	
			WeaponRebuff.ChatPrint(T"WEAPONREBUFF_UPDATEDTHRESHOLD_INSECONDS", self.db.profile.wrWarnThreshold_inSeconds);

		elseif(string.find(arg[1], "size")) then
			self:ResizeButton(self:GetFirstNumber(arg[1]))
			
		elseif(arg[1] == "config") then
			self:ShowOptions()
		
		elseif(arg[1] == "help") then					
			self:ShowHelp()
			
		elseif(arg[1] == "debug") then 
			self:ShowDebugInfo()

		else
			self:ShowQuickHelp()
		end
	end
	SLASH_WEAPONREBUFF1 = "/weaponrebuff";
	SLASH_WEAPONREBUFF2 = "/wr";

end

--[[ Help -------------------------------------------------------------- ]]
function WeaponRebuff:ShowQuickHelp()
			WeaponRebuff.ChatPrintClean("|caaff0000"..WeaponRebuffInfo.NAME.."|r (ver |caa00ff00"..WeaponRebuffInfo.VERSION.."|r) ")
			WeaponRebuff.ChatPrint(T"WEAPONREBUFF_SHOWMSG_DESCRIBEHELP");
			WeaponRebuff.ChatPrint(T"WEAPONREBUFF_SHOWMSG_DESCRIBECONFIG");
end

function WeaponRebuff:ShowHelp()
			WeaponRebuff.ChatPrintClean("|caaff0000"..WeaponRebuffInfo.NAME.."|r (ver |caa00ff00"..WeaponRebuffInfo.VERSION.."|r)".." Command Line Help");
			WeaponRebuff.ChatPrintShort(T"WEAPONREBUFF_SHOWMSG_LOCKED");
			WeaponRebuff.ChatPrintShort(T"WEAPONREBUFF_SHOWMSG_UNLOCKED");
			WeaponRebuff.ChatPrintShort(T"WEAPONREBUFF_SHOWMSG_POSRESET");
			
			WeaponRebuff.ChatPrintShort(T"WEAPONREBUFF_SHOWMSG_SETSIZE")
			WeaponRebuff.ChatPrintShort(wrColor.yellow..T"WEAPONREBUFF_SHOWMSG_BUTTONSIZE"..wrColor.green.." ["..self.db.profile.wrButtonSize.."]|r"              );

			WeaponRebuff.ChatPrintShort(T"WEAPONREBUFF_SHOWMSG_BUFFITEMTHRESHOLD")
			WeaponRebuff.ChatPrintShort(wrColor.yellow..T"WEAPONREBUFF_SHOWMSG_BUFFITEMTHRESHOLD_CUR"..wrColor.green.." ["..self.db.profile.wrWarnThreshold_BuffItems.."]|r" );
			
			WeaponRebuff.ChatPrintShort(T"WEAPONREBUFF_SHOWMSG_CHARGETHRESHOLD")
			WeaponRebuff.ChatPrintShort(wrColor.yellow..T"WEAPONREBUFF_SHOWMSG_CHARGETHRESHOLD_CUR"..wrColor.green.." ["..self.db.profile.wrWarnThreshold_Charges.."]|r"   );
			
			WeaponRebuff.ChatPrintShort(T"WEAPONREBUFF_SHOWMSG_UPDATEDTHRESHOLD_INSECONDS")
			WeaponRebuff.ChatPrintShort(wrColor.yellow..T"WEAPONREBUFF_SHOWMSG_WARNINSECONDS"..wrColor.green.." ["..self.db.profile.wrWarnThreshold_inSeconds.."]|r" );

end

function WeaponRebuff:ShowDebugInfo()
			WeaponRebuff.ChatPrint("wrEnableShowText ", 				 		 self.db.profile.wrEnableShowText);
			WeaponRebuff.ChatPrint("wrInvisibleAddon ", 				 		 self.db.profile.wrInvisibleAddon);
			WeaponRebuff.ChatPrint("wrDisableOffhandButton ", 	 		 self.db.profile.wrDisableOffhandButton);
			WeaponRebuff.ChatPrint("wrDisableRememberBuffText ", 		 self.db.profile.wrDisableRememberBuffText);
			WeaponRebuff.ChatPrint("wrSkipReplacePopup ", 			 		 self.db.profile.wrSkipReplacePopup);
			WeaponRebuff.ChatPrint("RememberBuff[16].BuffName ", 		 RememberBuff[16].BuffName);
			WeaponRebuff.ChatPrint("RememberBuff[16].BuffType ", 		 RememberBuff[16].BuffType);
			WeaponRebuff.ChatPrint("RememberBuff[17].BuffName ", 		 RememberBuff[17].BuffName);
			WeaponRebuff.ChatPrint("RememberBuff[17].BuffType ", 		 RememberBuff[17].BuffType);
			WeaponRebuff.ChatPrint("wrSoundAlarms ", 						 		 self.db.profile.wrSoundAlarms);           		  
			WeaponRebuff.ChatPrint("wrTextAlarms ",						 	 		 self.db.profile.wrTextAlarms);             		 
			WeaponRebuff.ChatPrint("wrSoundAlarms_ChargeRemaining ", self.db.profile.wrSoundAlarms_ChargeRemaining); 
			WeaponRebuff.ChatPrint("wrTextAlarms_ChargeRemaining ",	 self.db.profile.wrTextAlarms_ChargeRemaining);  
			WeaponRebuff.ChatPrint("wrChargeAlarms ",						 		 self.db.profile.wrChargeAlarms);           		 
			WeaponRebuff.ChatPrint("wrButtonSize ",						 	 		 self.db.profile.wrButtonSize);             		 
			WeaponRebuff.ChatPrint("wrWarnThreshold_Charges ",			 self.db.profile.wrWarnThreshold_Charges);       
			WeaponRebuff.ChatPrint("wrWarnThreshold_BuffItems ",		 self.db.profile.wrWarnThreshold_BuffItems);     
			WeaponRebuff.ChatPrint("wrUseCustomSounds ",						 self.db.profile.wrUseCustomSounds);
			WeaponRebuff.ChatPrint("wrWarnThreshold_inSeconds ",		 self.db.profile.wrWarnThreshold_inSeconds);
			WeaponRebuff.ChatPrint("wrEnableSideBySide ",		 				 self.db.profile.wrEnableSideBySide);			
			WeaponRebuff.ChatPrint("wrFrameStrata ",		 				     self.db.profile.wrFrameStrata);			
			
end

--[[ Alarms -------------------------------------------------------------- ]]

function WeaponRebuff:GetChargeAlarmState_fmSlot(slot)
	local rc = ( slot == 16 and wr.WepChargeWarning.Supplied16 or wr.WepChargeWarning.Supplied17)
  return rc

--	if ( slot == 16 ) then
--		return wr_WepChargeWarning_Supplied16
--	elseif ( slot == 17 ) then
--		return wr_WepChargeWarning_Supplied17
--	end
end

function WeaponRebuff:SetChargeAlarmState_fmSlot(slotAlarmState, slot)
	if ( slot == 16 ) then
		wr.WepChargeWarning.Supplied16 = slotAlarmState
	elseif ( slot == 17 ) then
		wr.WepChargeWarning.Supplied17 = slotAlarmState
	end
end

function WeaponRebuff:SetAlarmState_fmSlot(slotAlarmState, slot)
	if ( slot == 16 ) then
		wr.alarm.AlarmState16 = slotAlarmState
	elseif ( slot == 17 ) then
		wr.alarm.AlarmState17 = slotAlarmState
	end
end

function WeaponRebuff:AnnounceMsg(msg, R, B, G)	
	WeaponRebuff_InfodumpFrame:AddMessage(msg, R, B, G, 1, UIERRORS_HOLD_TIME);
end	

function WeaponRebuff:PlaySound(id)
	local soundTable = compost:Acquire(
		"Sound\\Doodad\\BellTollHorde.wav",
		"Sound\\Doodad\\BellTollAlliance.wav",
		"Sound\\Doodad\\BellTollNightElf.wav",
		"Sound\\Spells\\AntiHoly.wav",
		"Sound\\interface\\iTellMessage.wav",
		"Sound\\interface\\AuctionWindowOpen.wav",
		"Sound\\interface\\FriendJoin.wav",
		"Sound\\Creature\\Murloc\\mMurlocAggroOld.wav",		
		"Interface\\AddOns\\WeaponRebuff\\warning.wav",
		"Interface\\AddOns\\WeaponRebuff\\lost.wav"
	);
	PlaySoundFile(soundTable[id]);
	compost:Reclaim(soundTable);
end

--[[ UI Controls -------------------------------------------------------------- ]]

function WeaponRebuff:SetFrameStata(strata)
	self.db.profile.wrFrameStrata = strata
  if strata == 1 then	WeaponBuffBar:SetFrameStrata("HIGH") end;
	if strata == 2 then	WeaponBuffBar:SetFrameStrata("MEDIUM") end;
	if strata == 3 then	WeaponBuffBar:SetFrameStrata("LOW") end;
end

function WeaponRebuff:ResizeButton(size)
	if size == "" or size == 0 then size = 16; end;

	
	if self.db.profile.wrEnableSideBySide == 1 then
	  -- With SidebySide, put text under buttons to avoid potential problems
		WeaponBuffBar:SetWidth(size*2);
		WeaponBuffBar:SetHeight(size);
		
		wrMainhandButton:SetWidth(size);
		wrMainhandButton:SetHeight(size);
		
		wrOffhandButton:SetWidth(size);
		wrOffhandButton:SetHeight(size);
		
		wrOffhandButton:ClearAllPoints();
		wrOffhandButton:SetPoint("LEFT", wrMainhandButton, "RIGHT", 1, 0);
		
		wrMainhandButtonText:ClearAllPoints();
		wrMainhandButtonText:SetPoint("TOPLEFT", wrMainhandButton, "BOTTOMLEFT", 0, -2);	

		wrOffhandButtonText:ClearAllPoints();
		wrOffhandButtonText:SetPoint("TOPLEFT", wrMainhandButtonText, "BOTTOMLEFT", 0, -2);
	
	else
	
		WeaponBuffBar:SetWidth(size);
		WeaponBuffBar:SetHeight(size*2);
		
		wrOffhandButtonText:ClearAllPoints();
		wrOffhandButtonText:SetPoint("LEFT", wrOffhandButton, "LEFT", size+2, 2);

		wrOffhandButton:SetWidth(size);
		wrOffhandButton:SetHeight(size);		
		
		wrMainhandButtonText:ClearAllPoints();
		wrMainhandButtonText:SetPoint("LEFT", wrMainhandButton, "LEFT", size + 2, 2);	
		
		wrMainhandButton:SetWidth(size);
		wrMainhandButton:SetHeight(size);
		
		wrOffhandButton:ClearAllPoints();
		wrOffhandButton:SetPoint("TOPLEFT", wrMainhandButton, "BOTTOMLEFT", 0, -2);
					
	end
	
	self.db.profile.wrButtonSize = size;
		
	
end

--[[ End Weapon Rebuff (Redux2) -------------------------------------------------------------- ]]
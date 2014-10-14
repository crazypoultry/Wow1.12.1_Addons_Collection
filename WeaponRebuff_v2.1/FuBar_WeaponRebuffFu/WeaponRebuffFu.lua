--[[
Name: WeaponRebuffFu  - .9 Ace2 Beta
Revision: $Rev: 900 $
Author(s): Vincent (vincent@silverdaggers.net)
Website: http://www.curse-gaming.com/en/wow/addons-3711-1-weaponrebuff-redux.html
Documentation: http://www.curse-gaming.com/en/wow/addons-3711-1-weaponrebuff-redux.html
Description: FuBar-2.x Plugin for WeaponRebuff (Redux2)
Optional Dependencies: Ace2, Tabletlib-2.0, Dewdrop-2.0
]]

WeaponRebuffFuInfo = {
	VERSION = "2.0",
	CURRENTVERSION = 2000.0,
	NAME = "Fubar - WeaponRebuffFu"
};


WeaponRebuffFu = AceLibrary("AceAddon-2.0"):new("FuBarPlugin-2.0", "AceDB-2.0", "AceEvent-2.0")
local tablet = AceLibrary("Tablet-2.0")
local dewdrop = AceLibrary("Dewdrop-2.0")
local db 
WeaponRebuffFu:RegisterDB("WeaponRebuffFuDB")
WeaponRebuffFu:RegisterDefaults('profile', { WeaponRebuffFu = true })

local wrT = AceLibrary("AceLocale-2.0"):new("WeaponRebuff")
local chargeNames = wrT:GetTable("chargeNames");
local spellNames  = wrT:GetTable("spellNames");

local T = AceLibrary("AceLocale-2.0"):new("WeaponRebuffFu");
T:RegisterTranslations("enUS", function() return {
	["NAME"] = "FuBar - WeaponRebuff",
	["TITLE2"] = "for WeaponRebuff (Redux)",
	["DESCRIPTION"] = "Plugin Controller for WeaponRebuff (Redux)",
	["FWR_PLUGIN_LABEL"] = "WR",
	["FWR_MENU_MAINHAND_SETBUFF"]    = "Set New MainHand Buff",
	["FWR_MENU_MAINHAND_APPLYBUFF1"] = "Apply ",
	["FWR_MENU_MAINHAND_APPLYBUFF2"] = " to Main-Hand",
	["FWR_MENU_OFFHAND_SETBUFF"]     = "Set New OffHand Buff",
	["FWR_MENU_OFFHAND_APPLYBUFF1"]  = "Apply ",
	["FWR_MENU_OFFHAND_APPLYBUFF2"]  = " to Off-Hand ",
	["FWR_MENU_CONFIG"] 						 = "Configuration Menu",
	["FWR_MENU_OPTIONS"] 						 = "/Slash Command Options",	
	["FWR_TOOLTIP_HINT"] 					   = "Click to rebuff Main-Hand\nShift-Click to rebuff Off-Hand\n\nRight-Click to set weapon buffs",
	["FWR_TOOLTIP_CATEGORY"] 			   = "BUFFS",
	["FWR_TOOLTIP_PREFIX_OFFHAND"]   = "Off-hand",
	["FWR_TOOLTIP_PREFIX_MAINHAND"]  = "Main-hand",
	["FWR_HOOKING"] 							   = "Hooking to WR version:"
} end);

T:RegisterTranslations("koKR", function() return {
	["NAME"] = "FuBar - WeaponRebuff",
	["TITLE2"] = "for WeaponRebuff (Redux)",
	["DESCRIPTION"] = "WeaponRebuff 애드온 Fubar 컨트롤러",
	["FWR_PLUGIN_LABEL"] = "WR",
	["FWR_MENU_MAINHAND_SETBUFF"]    = "새로운 주무기 버프 설정",
	["FWR_MENU_MAINHAND_APPLYBUFF1"] = "설정 ",
	["FWR_MENU_MAINHAND_APPLYBUFF2"] = " 주무기로",
	["FWR_MENU_OFFHAND_SETBUFF"]     = "새로운 보조무기 버프 설정",
	["FWR_MENU_OFFHAND_APPLYBUFF1"]  = "설정 ",
	["FWR_MENU_OFFHAND_APPLYBUFF2"]  = " 보조무기로",
	["FWR_MENU_CONFIG"] 						 = "환경설정 메뉴",
	["FWR_MENU_OPTIONS"] 						 = "/슬래쉬 명령어 옵션",	
	["FWR_TOOLTIP_HINT"] 					   = "\n클릭: 주무기 재버프 \n쉬프트 클릭: 보조무기 재버프 \n\n오른쪽 클릭: 무기 버프 선택",
	["FWR_TOOLTIP_CATEGORY"] 			   = "BUFFS",
	["FWR_TOOLTIP_PREFIX_OFFHAND"]   = "보조무기",
	["FWR_TOOLTIP_PREFIX_MAINHAND"]  = "주무기",
	["FWR_HOOKING"] 							   = "연결된 WeaponRebuff 버젼:"
} end);


function WeaponRebuffFu:OnInitialize()
  db = self.db.profile

	self.hasIcon = true
	self.hasNoText = false
	self.defaultPosition = 'CENTER'
	self.clickableTooltip = true -- nothing clickable on it but it always annoys me when it disappers so easily
	self.cannotDetachTooltip = false -- allows detaching

	self:SetIcon(true) -- default of icon.tga

end


function WeaponRebuffFu:OnProfileEnable()
  db = self.db.profile -- update shortcut to db now that it's changed
end


local L = { -- L for Locals!
		FWR_SLOT_MAINHAND = 16,
		FWR_SLOT_OFFHAND  = 17,
		timerID
}


-- [[ Enable / Disable ]] ----------------------------------------------
function WeaponRebuffFu:OnEnable()
	self:SetText("WR (loading)") -- preliminary text
  L.timerID = self:ScheduleRepeatingEvent(self.Update, 1, self)
	
    -- :UpdateData()
    -- :UpdateText()
    -- :UpdateTooltip()
end

function WeaponRebuffFu:OnDisable()
    self:CancelScheduledEvent(L.timerID)
end



-- [[ :UpdateData()  :UpdateText()  :UpdateTooltip() ]] -----------------

function WeaponRebuffFu:UpdateData()
	-- No innards to update
end

function WeaponRebuffFu:UpdateText()
	-- Update PlugIn Text
	if wr_PlugIn_Caption == nil then -- waiting for WeaponRebuff (Redux) to update
		self:SetText("WR "..wrColor.lte_blue.."(loading)")
	else
		self:SetText("WR "..wr_PlugIn_Caption)
	end

end

function WeaponRebuffFu:OnTooltipUpdate()
	local cat = tablet:AddCategory('columns', 2)
	
	cat:AddLine(
		'text',  wrColor.lte_blue..T"FWR_HOOKING".."|r", 
		'text2', wrColor.lte_blue..WeaponRebuffInfo.VERSION.."|r"
	)
	
	cat:AddLine('text', "")

	cat:AddLine(
		'text' , T"FWR_TOOLTIP_PREFIX_MAINHAND",
		'text2', wr_forPlugin_Tooltip_Main
	)

	if wr_forPlugin_DisableOffhand == 0 then
		cat:AddLine(
			'text' , T"FWR_TOOLTIP_PREFIX_OFFHAND",
			'text2', wr_forPlugin_Tooltip_Off
		)
	end

	tablet:SetHint(T"FWR_TOOLTIP_HINT");
	
end


-- [[ DropDown Menu ]] ---------------------------------------------------------------------

function WeaponRebuffFu:Menu_AddSpacer(level)
	dewdrop:AddLine('text', "",
		'notClickable', true,
		'level', level
	)
end

function WeaponRebuffFu:OnMenuRequest(level, value)

	-- [[ level 1 ]] --
	if(level == 1) then

		-- [[ Title ]] ---------
		dewdrop:AddLine(
			'text', T"TITLE2",			
			'isTitle', true,
		  'textR', 1,
    	'textG', 1,
    	'textB', .5,
			'level', 1    	
		)
		
		-- [[ SPACE ]] ---------
		self:Menu_AddSpacer(1)
		-- ---------------------

		-- [[ Refresh Buffs ]] ---------
		dewdrop:AddLine(
			'text', wrColor.green..T"FWR_MENU_MAINHAND_APPLYBUFF1".."|r"..wrColor.red..RememberBuff[16].BuffName.."|r"..wrColor.green..T"FWR_MENU_MAINHAND_APPLYBUFF2".."|r",
			'func', function()
					self:RebuffMainHand()
				end,
			'level', 1
		)		

		dewdrop:AddLine(
			'text', wrColor.yellow..T"FWR_MENU_OFFHAND_APPLYBUFF1".."|r"..wrColor.red..RememberBuff[17].BuffName.."|r"..wrColor.yellow..T"FWR_MENU_OFFHAND_APPLYBUFF2".."|r",
			'func', function()
					self:RebuffOffHand()
				end,
			'level', 1
		)		

		-- [[ SPACE ]] ---------
		self:Menu_AddSpacer(1)
		-- ---------------------

		-- [[ Select New Buffs ]] ---------
		dewdrop:AddLine(
			'text', T"FWR_MENU_MAINHAND_SETBUFF",
			'hasArrow', true,
			'value', "wrFu_SetBuff_MH",
			'level', 1
		)				
		
		dewdrop:AddLine(
			'text', T"FWR_MENU_OFFHAND_SETBUFF",
			'hasArrow', true,
			'value', "wrFu_SetBuff_OH",
			'level', 1
		)								
		
		-- [[ SPACE ]] ---------
		self:Menu_AddSpacer(1)
		-- ---------------------
				
		dewdrop:AddLine(
			'text', wrColor.copper..T"FWR_MENU_OPTIONS".."|r",
			'func', function()
					WeaponRebuff:ShowHelp()
				end,
			'level', 1
		)						
		
		dewdrop:AddLine(
			'text', wrColor.copper..T"FWR_MENU_CONFIG".."|r",
			'func', function()
					WeaponRebuff:ShowOptions()
				end,
			'level', 1
		)		

		-- [[ SPACE ]] ---------
		self:Menu_AddSpacer(1)
		-- ---------------------


	-- [[ level 2 ]] --
	elseif(level == 2) then
	
		if(value == "wrFu_SetBuff_MH") then	
			self:UpdateChargesSubmenu(L.FWR_SLOT_MAINHAND, level)
		elseif(value == "wrFu_SetBuff_OH") then
		  self:UpdateChargesSubmenu(L.FWR_SLOT_OFFHAND, level)
		end
		
	end	

end

function WeaponRebuffFu:UpdateChargesSubmenu(slot, level)
	-- note to self: level should always be 2
		
	-- [[ Title ]] ---------
	if slot == 16 then
		dewdrop:AddLine(
			'text', T"FWR_MENU_MAINHAND_SETBUFF",			
			'isTitle', true,
		  'textR', 1,
	   	'textG', 1,
	   	'textB', .5,
			'level', level
		)		
	elseif slot == 17 then
		dewdrop:AddLine(
			'text', T"FWR_MENU_OFFHAND_SETBUFF",			
			'isTitle', true,
		  'textR', 1,
	   	'textG', 1,
	   	'textB', .5,
			'level', level
		)
	end
		
	-- [[ SPACE ]] ---------
	self:Menu_AddSpacer(level)
	-- ---------------------	
			
	-- [[ Add Consumables ]] -- 
	for i=1, table.getn(chargeNames), 1 do
		local _,_,count = WeaponRebuff:GetBagInfo(chargeNames[i]);
		if ( count > 0 ) then

			dewdrop:AddLine(
			'text', count.."x "..chargeNames[i],
			'arg1', chargeNames[i],			
			'level', level,
			'func', function(arg1)										
					WeaponRebuff:Apply(arg1, 1, slot)
				end
			)
		
		end
	end

	-- [[ Add Spells ]] -- 
	for i=1, table.getn(spellNames), 1 do
		if ( WeaponRebuff:GetSpellId(spellNames[i]) > 0) then		

			dewdrop:AddLine(
				'text', spellNames[i],
				'arg1', spellNames[i],
				'level', level,				
				'func', function(arg1)					
						WeaponRebuff:Apply(arg1, 2, slot)
				end
			)
			
		end
	end			

	-- [[ SPACE ]] ---------
	self:Menu_AddSpacer(level)
	-- ---------------------	
	
end


function WeaponRebuffFu:RebuffMainHand()
	WeaponRebuff:Rebuff(16)
end

function WeaponRebuffFu:RebuffOffHand()
	WeaponRebuff:Rebuff(17)
end
	
function WeaponRebuffFu:OnClick()
	if(IsShiftKeyDown()) then
		-- buff offhand
		self:RebuffOffHand()
	else
		-- buff mainhand
		self:RebuffMainHand()
	end
end



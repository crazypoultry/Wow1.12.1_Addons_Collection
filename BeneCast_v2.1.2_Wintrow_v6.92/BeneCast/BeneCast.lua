-- BeneCast by Skurel
-- v 2.1.2
-- Code heavily referenced from Danboo's Healomatic/CastParty. Thank you Danboo!
-- Makes clickable buttons that casts beneficial spells on party members and the current target

-- *****************************************************************************
-- BeneCast Constants
-- *****************************************************************************
-- Maximum number of buttons in a BeneCast Panel
BENECAST_MAX_NUMBER_OF_BUTTONS = 20;
-- This is used to reset the configuration if severely outdated
BENECAST_VERSION = 2.0;

-- *****************************************************************************
-- BeneCast Raid Tables
-- *****************************************************************************
BENECAST_RAID_LIST = {};
BENECAST_RAID_SUBGROUPS = { 0, 0, 0, 0, 0, 0, 0, 0 };
BENECAST_RAID_ROSTER = {}; -- Raid Roster Cache
BENECAST_RAID_ROSTER2 = {}; -- Raid Roster Cache, lookup unit by name
BENECAST_RAID_PANELS = {}; -- panel pool, index = parentframename, value = panelid
BENECAST_RAID_PANELS2 = {}; -- panel pool, index = panelid, value = { unitid = unit, parentframe = parentframename }
BENECAST_RAID_PANELS3 = {}; -- panel pool, index = unitid, value = table of parentframenames

-- BeneCast will hook into CT_RA's Update function to update raid-panels AFTER CT_RA
BC_Old_CTRA_UpdateFunction = nil;

-- BeneCast will only update raidpanels-positions every 5 seconds
BC_UpdateRaid = nil;
BC_Last_UpdateRaid_Done = nil;

-- *****************************************************************************
-- BeneCast UI Tables
-- *****************************************************************************

-- Table to hold all the OptionCheckButton information
-- table value: Text of the checkbutton label
-- index: ID of the checkbutton
-- cvar: Option modified in BeneCastConfig
-- tooltipText: Text for the tooltip of the checkbutton
local BeneCastOptionFrameCheckButtons = {};
BeneCastOptionFrameCheckButtons['TEXT_DAMAGE_BASED_HEALS'] = { index = 1, cvar = 'DmgBasedHeal', tooltipText = 'TEXT_DAMAGE_BASED_HEALS_TOOLTIP' };
BeneCastOptionFrameCheckButtons['TEXT_OVERHEAL'] = { index = 2, cvar = 'Overheal', tooltipText = 'TEXT_OVERHEAL_TOOLTIP' };
BeneCastOptionFrameCheckButtons['TEXT_SHOWALLBUFFS'] = { index = 3, cvar = 'ShowAllBuffs', tooltipText = 'TEXT_SHOWALLBUFFS_TOOLTIP' };
BeneCastOptionFrameCheckButtons['TEXT_HIDE_MINIMAP_BUTTON'] = { index = 4, cvar = 'HideMinimap', tooltipText = 'TEXT_HIDE_MINIMAP_BUTTON_TOOLTIP' };
BeneCastOptionFrameCheckButtons['TEXT_TOOLTIPS'] = { index = 5, cvar = 'ShowTooltips', tooltipText = 'TEXT_TOOLTIPS_TOOLTIP' };
BeneCastOptionFrameCheckButtons['TEXT_TOOLTIPS_NAME'] = { index = 6, cvar = 'ShowTooltipsName', tooltipText = 'TEXT_TOOLTIPS_NAME_TOOLTIP' };
BeneCastOptionFrameCheckButtons['TEXT_UNLOCK_BUTTONS'] = { index = 7, cvar = 'Unlock', tooltipText = 'TEXT_UNLOCK_BUTTONS_TOOLTIP' };
BeneCastOptionFrameCheckButtons['TEXT_NOTIFICATION'] = { index = 8, cvar = 'Notification', tooltipText = 'TEXT_PARTY_NOTIFICATION_TOOLTIP' };
BeneCastOptionFrameCheckButtons['TEXT_SELF_CHANNEL'] = { index = 9, cvar = 'SelfNotify', tooltipText = 'TEXT_SELF_CHANNEL_TOOLTIP' };
BeneCastOptionFrameCheckButtons['TEXT_PARTY_CHANNEL'] = { index = 10, cvar = 'PartyNotify', tooltipText = 'TEXT_PARTY_CHANNEL_TOOLTIP' };
BeneCastOptionFrameCheckButtons['TEXT_RAID_CHANNEL'] = { index = 11, cvar = 'RaidNotify', tooltipText = 'TEXT_RAID_CHANNEL_TOOLTIP' };
BeneCastOptionFrameCheckButtons['TEXT_WHISPER_TARGET'] = { index = 12, cvar = 'TargetNotify', tooltipText = 'TEXT_WHISPER_TARGET_TOOLTIP' };
BeneCastOptionFrameCheckButtons['TEXT_NOTIFY_SELF_CASTS'] = { index = 13, cvar = 'SelfCasts', tooltipText = 'TEXT_NOTIFY_SELF_CASTS_TOOLTIP' };
BeneCastOptionFrameCheckButtons['TEXT_NOTIFY_RANK'] = { index = 14, cvar = 'NotifyRank', tooltipText = 'TEXT_NOTIFY_RANK_TOOLTIP' };
BeneCastOptionFrameCheckButtons['TEXT_NOTIFY_TIME'] = { index = 15, cvar = 'NotifyTime', tooltipText = 'TEXT_NOTIFY_TIME_TOOLTIP' };
BeneCastOptionFrameCheckButtons['TEXT_NOTIFY_HEALS'] = { index = 16, cvar = 'NotifyHeal', tooltipText = 'TEXT_NOTIFY_HEALS_TOOLTIP' };
BeneCastOptionFrameCheckButtons['TEXT_NOTIFY_MAX_HEALS'] = { index = 17, cvar = 'NotifyMaxHeal', tooltipText = 'TEXT_NOTIFY_MAX_HEALS_TOOLTIP' };
BeneCastOptionFrameCheckButtons['TEXT_NOTIFY_CURES'] = { index = 18, cvar = 'NotifyCure', tooltipText = 'TEXT_NOTIFY_CURES_TOOLTIP' };
BeneCastOptionFrameCheckButtons['TEXT_NOTIFY_BUFFS'] = { index = 19, cvar = 'NotifyBuff', tooltipText = 'TEXT_NOTIFY_BUFFS_TOOLTIP' };
BeneCastOptionFrameCheckButtons['TEXT_NOTIFY_USER_CHANNEL'] = { index = 20, cvar = 'UserNotify', tooltipText = 'TEXT_NOTIFY_USER_CHANNEL_TOOLTIP' };
BeneCastOptionFrameCheckButtons['TEXT_NOTIFY_RES'] = { index = 21, cvar = 'NotifyRes', tooltipText = 'TEXT_NOTIFY_RES_TOOLTIP' };
BeneCastOptionFrameCheckButtons['TEXT_PLAYER_AS_DEFAULT'] = { index = 22, cvar = 'PlayerAsDefault', tooltipText = 'TEXT_PLAYER_AS_DEFAULT_TOOLTIP' };
BeneCastOptionFrameCheckButtons['TEXT_SHOW_PETS'] = { index = 23, cvar = 'ShowPets', tooltipText = 'TEXT_SHOW_PETS_TOOLTIP' };
BeneCastOptionFrameCheckButtons['TEXT_SHOW_RAID'] = { index = 24, cvar = 'ShowRaid', tooltipText = 'TEXT_SHOW_RAID_TOOLTIP' };
BeneCastOptionFrameCheckButtons['TEXT_SHOW_RAID_PETS'] = { index = 25, cvar = 'ShowRaidPets', tooltipText = 'TEXT_SHOW_RAID_PETS_TOOLTIP' };
BeneCastOptionFrameCheckButtons['TEXT_REVERSE_HOTS'] = { index = 26, cvar = 'ReverseHoTs', tooltipText = 'TEXT_REVERSE_HOTS_TOOLTIP' };
BeneCastOptionFrameCheckButtons['TEXT_MANA_BASED_HEALS'] = { index = 27, cvar = 'ManaBasedHeal', tooltipText = 'TEXT_MANA_BASED_HEALS_TOOLTIP' };
BeneCastOptionFrameCheckButtons['TEXT_FLASH_AS_FADE'] = { index = 28, cvar = 'FlashAsFade', tooltipText = 'TEXT_FLASH_AS_FADE_TOOLTIP' };
BeneCastOptionFrameCheckButtons['TEXT_SAY_CHANNEL'] = { index = 29, cvar = 'SayNotify', tooltipText = 'TEXT_SAY_CHANNEL_TOOLTIP' };
BeneCastOptionFrameCheckButtons['TEXT_CHECK_RANGE'] = { index = 30, cvar = 'CheckRange', tooltipText = 'TEXT_CHECK_RANGE_TOOLTIP' };
BeneCastOptionFrameCheckButtons['TEXT_TARGET_OF_TARGET'] = { index = 31, cvar = 'ShowTargetTarget', tooltipText = 'TEXT_TARGET_OF_TARGET_TOOLTIP' };
BeneCastOptionFrameCheckButtons['TEXT_EMOTE_CHANNEL'] = { index = 32, cvar = 'EmoteNotify', tooltipText = 'TEXT_EMOTE_CHANNEL_TOOLTIP' };


-- Table to hold all the OptionCheckButton information
-- text: Text of the slider label
-- index: ID of the slider
-- cvar: Option modified in BeneCastConfig
-- minValue: Minimum value of the slider
-- maxValue: Maximum value of the slider
-- valueStep: Step value of the slider when being changed
-- tooltipText: Text for the tooltip of the checkbutton
local BeneCastOptionFrameSliders = {
	{ index = 1, text = 'TEXT_BUTTON_SIZE', cvar = 'ButtonSize', minValue = 8, maxValue = 36, valueStep = 1, tooltipText = 'TEXT_BUTTONSIZESLIDER_TOOLTIP' },
	{ index = 2, text = 'TEXT_RANKS_TO_OVERHEAL', cvar = 'OverhealSlider', minValue = 0, maxValue = 10, valueStep = 1, tooltipText = 'TEXT_OVERHEALSLIDER_TOOLTIP' },
	{ index = 3, text = 'TEXT_BUTTON_NUMBER', cvar = 'ButtonNumber', minValue = 1, maxValue = 20, valueStep = 1, tooltipText = 'TEXT_BUTTONNUMBERSLIDER_TOOLTIP' },
};

-- Table to hold the different subframe names in the BeneCastOptions frame
local BeneCastOptionFrameSubframes = {'BeneCastPlayerFrame', 'BeneCastClass1Frame', 'BeneCastClass2Frame', 'BeneCastClass3Frame', 'BeneCastClass4Frame', 'BeneCastClass5Frame', 'BeneCastClass6Frame', 'BeneCastClass7Frame', 'BeneCastClass8Frame', 'BeneCastSetupFrame', 'BeneCastNotificationFrame', 'BeneCastRaidFrame', 'BeneCastSnapToFrame', };

-- *****************************************************************************
-- Global variables
-- *****************************************************************************

-- Array to hold possible targets
local BC_targets = {'player', 'party1', 'party2', 'party3', 'party4', 'raid1', 'raid2', 'raid3', 'raid4', 'raid5', 'raid6', 'raid7', 'raid8', 'raid9', 'raid10', 'raid11', 'raid12', 'raid13', 'raid14', 'raid15', 'raid16', 'raid17', 'raid18', 'raid19', 'raid20', 'raid21', 'raid22', 'raid23', 'raid24', 'raid25', 'raid26', 'raid27', 'raid28', 'raid29', 'raid30', 'raid31', 'raid32', 'raid33', 'raid34', 'raid35', 'raid36', 'raid37', 'raid38', 'raid39', 'raid40', 'pet', 'partypet1', 'partypet2', 'partypet3', 'partypet4', 'raidpet1', 'raidpet2', 'raidpet3', 'raidpet4', 'raidpet5', 'raidpet6', 'raidpet7', 'raidpet8', 'raidpet9', 'raidpet10', 'raidpet11', 'raidpet12', 'raidpet13', 'raidpet14', 'raidpet15', 'raidpet16', 'raidpet17', 'raidpet18', 'raidpet19', 'raidpet20', 'raidpet21', 'raidpet22', 'raidpet23', 'raidpet24', 'raidpet25', 'raidpet26', 'raidpet27', 'raidpet28', 'raidpet29', 'raidpet30', 'raidpet31', 'raidpet32', 'raidpet33', 'raidpet34', 'raidpet35', 'raidpet36', 'raidpet37', 'raidpet38', 'raidpet39', 'raidpet40', 'target', 'targettarget' };

--WINTROW.6 Array to hold possible endings for EditBoxes
local BCW_components = { 'Frame', 'Point', 'RelativePoint', 'X', 'Y', };

-- Array to assign id numbers based on class
local BC_classes = {
	[BENECAST_STRINGS.CLASS_DRUID]		= 2,
	[BENECAST_STRINGS.CLASS_MAGE]		= 4,
	[BENECAST_STRINGS.CLASS_HUNTER]		= 3,
	[BENECAST_STRINGS.CLASS_PRIEST]		= 5,
	[BENECAST_STRINGS.CLASS_ROGUE]		= 6,
	[BENECAST_STRINGS.CLASS_WARLOCK]	= 7,
	[BENECAST_STRINGS.CLASS_WARRIOR]	= 8,
	[BENECAST_STRINGS.CLASS_SHAMAN]		= 9,
	[BENECAST_STRINGS.CLASS_PALADIN]	= 9,
}

-- Table used to sort spelltypes
local BC_spellsort = {
	'res', 'efficient', 'efficient2', 'efficient3', 'emergency', 'instant', 'instant2', 'loh', 'group', 'group2',
	'poison', 'disease', 'disease2', 'magic', 'curse', 'buff1', 'buff2', 'buff3', 'buff4', 'partybuff1', 'buff5',
	'buff6', 'buff7', 'buff8', 'buff9', 'buff10', 'groupbuff1', 'groupbuff2', 'groupbuff3', 'buffparty1g',
	'buffparty2g', 'buffparty3g', 'buffparty4g', 'buffparty5g', 'buffparty6g', 'buffparty7g', 'buffparty8g',
	'buffparty9g', 'selfbuff1', 'selfbuff2', 'selfbuff3', 'selfbuff4', 'selfbuff5', 'selfbuff6', 'selfbuff7',
	'selfbuff8', 'selfbuff9', 'selfbuff10', 'selfbuff11', 'selfbuff12', 'selfbuff13', 'weaponenchant1',
	'weaponenchant2', 'weaponenchant3', 'weaponenchant4', 'partybuff2', 'partybuff3', 'partybuff4',
	'partybuff5', 'partybuff6', 'partybuff7', 'partybuff8', 'partybuff9', 'partybuff10'
};

-- Table used to determine the buffs in effect in UpdateButtons
local BC_buffs_in_effect = {};
BC_buffs_in_effect[1] = { ineffect = nil, fade = nil, name = 'buff1', notabuff = false };
BC_buffs_in_effect[2] = { ineffect = nil, fade = nil, name = 'buff2', notabuff = false };
BC_buffs_in_effect[3] = { ineffect = nil, fade = nil, name = 'buff3', notabuff = false };
BC_buffs_in_effect[4] = { ineffect = nil, fade = nil, name = 'buff4', notabuff = false };
BC_buffs_in_effect[5] = { ineffect = nil, fade = nil, name = 'buff5', notabuff = false };
BC_buffs_in_effect[6] = { ineffect = nil, fade = nil, name = 'buff6', notabuff = false };
BC_buffs_in_effect[7] = { ineffect = nil, fade = nil, name = 'groupbuff1', notabuff = false };
BC_buffs_in_effect[8] = { ineffect = nil, fade = nil, name = 'buffparty1g', notabuff = false };
BC_buffs_in_effect[9] = { ineffect = nil, fade = nil, name = 'buffparty2g', notabuff = false };
BC_buffs_in_effect[10] = { ineffect = nil, fade = nil, name = 'buffparty3g', notabuff = false };
BC_buffs_in_effect[11] = { ineffect = nil, fade = nil, name = 'buffparty4g', notabuff = false };
BC_buffs_in_effect[12] = { ineffect = nil, fade = nil, name = 'buffparty5g', notabuff = false };
BC_buffs_in_effect[13] = { ineffect = nil, fade = nil, name = 'buffparty6g', notabuff = false };
BC_buffs_in_effect[14] = { ineffect = nil, fade = nil, name = 'buffparty7g', notabuff = false };
BC_buffs_in_effect[15] = { ineffect = nil, fade = nil, name = 'buffparty8g', notabuff = false };
BC_buffs_in_effect[16] = { ineffect = nil, fade = nil, name = 'buffparty9g', notabuff = false };
BC_buffs_in_effect[17] = { ineffect = nil, fade = nil, name = 'selfbuff1', notabuff = false };
BC_buffs_in_effect[18] = { ineffect = nil, fade = nil, name = 'selfbuff2', notabuff = false };
BC_buffs_in_effect[19] = { ineffect = nil, fade = nil, name = 'selfbuff3', notabuff = false };
BC_buffs_in_effect[20] = { ineffect = nil, fade = nil, name = 'selfbuff4', notabuff = false };
BC_buffs_in_effect[21] = { ineffect = nil, fade = nil, name = 'selfbuff5', notabuff = false };
BC_buffs_in_effect[22] = { ineffect = nil, fade = nil, name = 'selfbuff6', notabuff = false };
BC_buffs_in_effect[23] = { ineffect = nil, fade = nil, name = 'selfbuff7', notabuff = false };
BC_buffs_in_effect[24] = { ineffect = nil, fade = nil, name = 'selfbuff8', notabuff = false };
BC_buffs_in_effect[25] = { ineffect = nil, fade = nil, name = 'selfbuff9', notabuff = false };
BC_buffs_in_effect[26] = { ineffect = nil, fade = nil, name = 'selfbuff10', notabuff = false };
BC_buffs_in_effect[27] = { ineffect = nil, fade = nil, name = 'selfbuff11', notabuff = false };
BC_buffs_in_effect[28] = { ineffect = nil, fade = nil, name = 'selfbuff12', notabuff = false };
BC_buffs_in_effect[29] = { ineffect = nil, fade = nil, name = 'selfbuff13', notabuff = false };
BC_buffs_in_effect[30] = { ineffect = nil, fade = nil, name = 'groupbuff2', notabuff = false };
BC_buffs_in_effect[31] = { ineffect = nil, fade = nil, name = 'groupbuff3', notabuff = false };
BC_buffs_in_effect[32] = { ineffect = nil, fade = nil, name = 'buff7', notabuff = false };
BC_buffs_in_effect[33] = { ineffect = nil, fade = nil, name = 'buff8', notabuff = false };
BC_buffs_in_effect[34] = { ineffect = nil, fade = nil, name = 'buff9', notabuff = false };
BC_buffs_in_effect[35] = { ineffect = nil, fade = nil, name = 'buff10', notabuff = false };
BC_buffs_in_effect[36] = { ineffect = nil, fade = nil, name = 'partybuff1', notabuff = false };
BC_buffs_in_effect[37] = { ineffect = nil, fade = nil, name = 'partybuff2', notabuff = false };
BC_buffs_in_effect[38] = { ineffect = nil, fade = nil, name = 'partybuff3', notabuff = false };
BC_buffs_in_effect[39] = { ineffect = nil, fade = nil, name = 'partybuff4', notabuff = false };
BC_buffs_in_effect[40] = { ineffect = nil, fade = nil, name = 'partybuff5', notabuff = false };
BC_buffs_in_effect[41] = { ineffect = nil, fade = nil, name = 'partybuff6', notabuff = false };
BC_buffs_in_effect[42] = { ineffect = nil, fade = nil, name = 'partybuff7', notabuff = false };
BC_buffs_in_effect[43] = { ineffect = nil, fade = nil, name = 'partybuff8', notabuff = false };
BC_buffs_in_effect[44] = { ineffect = nil, fade = nil, name = 'partybuff9', notabuff = false };
BC_buffs_in_effect[45] = { ineffect = nil, fade = nil, name = 'partybuff10', notabuff = false };
BC_buffs_in_effect[46] = { ineffect = nil, fade = nil, name = 'instant', notabuff = true };
BC_buffs_in_effect[47] = { ineffect = nil, fade = nil, name = 'emergency', notabuff = true };
BC_buffs_in_effect[48] = { ineffect = nil, fade = nil, name = 'poison', notabuff = true };

local BC_buffs_in_effect_by_name = {
	['buff1'] = 1,
	['buff2'] = 2,
	['buff3'] = 3,
	['buff4'] = 4,
	['buff5'] = 5,
	['buff6'] = 6,
	['groupbuff1'] = 7,
	['buffparty1g'] = 8,
	['buffparty2g'] = 9,
	['buffparty3g'] = 10,
	['buffparty4g'] = 11,
	['buffparty5g'] = 12,
	['buffparty6g'] = 13,
	['buffparty7g'] = 14,
	['buffparty8g'] = 15,
	['buffparty9g'] = 16,
	['selfbuff1'] = 17,
	['selfbuff2'] = 18,
	['selfbuff3'] = 19,
	['selfbuff4'] = 20,
	['selfbuff5'] = 21,
	['selfbuff6'] = 22,
	['selfbuff7'] = 23,
	['selfbuff8'] = 24,
	['selfbuff9'] = 25,
	['selfbuff10'] = 26,
	['selfbuff11'] = 27,
	['selfbuff12'] = 28,
	['selfbuff13'] = 29,
	['groupbuff2'] = 30,
	['groupbuff3'] = 31,
	['buff7'] = 32,
	['buff8'] = 33,
	['buff9'] = 34,
	['buff10'] = 35,
	['partybuff1'] = 36,
	['partybuff2'] = 37,
	['partybuff3'] = 38,
	['partybuff4'] = 39,
	['partybuff5'] = 40,
	['partybuff6'] = 41,
	['partybuff7'] = 42,
	['partybuff8'] = 43,
	['partybuff9'] = 44,
	['partybuff10'] = 45,
	['instant'] = 46,
	['emergency'] = 47,
	['poison'] = 48
};

-- Table to hold buttons by spelltype
BC_buttons_by_spell = {};
BC_buttons_that_flash = {};
BC_actionslot_by_spell = {};
BC_actionslot_by_slot = {};
BC_LastRangeCheck = nil;

-- Healing threshold from max
local BC_threshold = 1;

-- Class of the player
local BC_class;

-- Party notification stuff
local BC_spellbeingcast = nil;
local BC_spelltarget = nil;
local BC_spellismax = nil;
local BC_spellstarted = nil;
local BC_spellstopped = nil;
local BC_sentmessage = nil;

-- Weapon Enchant status
local BC_weaponenchant = nil;

-- Statusses of current player
local BC_clearcasting = nil;
local BC_spirit_of_redemption = nil;
local BC_innerfocus = nil;

local BC_AttachPartyFramesOnTargetChange = nil;
local BC_MarkedTCTable = nil;
local BC_LastTCCheck = nil;

local BC_BonusScanner_HookFunction = nil;

-- Plus Healing modifier
local BC_plusheal = 0;

-- Table of equipment to scan for Plus Healing modifiers
local BC_equipslots = {
	"Head",
	"Neck",
	"Shoulder",
	"Shirt",
	"Chest",
	"Waist",
	"Legs",
	"Feet",
	"Wrist",
	"Hands",
	"Finger0",
	"Finger1",
	"Trinket0",
	"Trinket1",
	"Back",
	"MainHand",
	"SecondaryHand",
	"Ranged",
	"Tabard",
};

-- String for checking if a line in an equipment slot is part of a set
local BC_setstring = '^(.*) %(%d/%d%)$';

-- Tables for interpolating health of targets outside the group
local BC_class_health = {
	[BENECAST_STRINGS.CLASS_DRUID]	= { ['1'] = 30, ['60'] = 3000 },
	[BENECAST_STRINGS.CLASS_MAGE]	= { ['1'] = 30, ['60'] = 3000 },
	[BENECAST_STRINGS.CLASS_HUNTER]	= { ['1'] = 30, ['60'] = 4000 },
	[BENECAST_STRINGS.CLASS_PALADIN]= { ['1'] = 30, ['60'] = 4500 },
	[BENECAST_STRINGS.CLASS_PRIEST]	= { ['1'] = 30, ['60'] = 3000 },
	[BENECAST_STRINGS.CLASS_ROGUE]	= { ['1'] = 30, ['60'] = 3500 },
	[BENECAST_STRINGS.CLASS_SHAMAN]	= { ['1'] = 30, ['60'] = 4000 },
	[BENECAST_STRINGS.CLASS_WARLOCK]= { ['1'] = 30, ['60'] = 4000 },
	[BENECAST_STRINGS.CLASS_WARRIOR]= { ['1'] = 30, ['60'] = 5000 },
};

-- Storage for spell data
local BC_spell_data = {};

-- Table to hold data of the Target of Target
local BC_TargetTarget = {};

-- *****************************************************************************
-- BeneCast Helper functions
-- *****************************************************************************

-- Function to clear the table given as the parameter
function BeneCast_ClearTable(Table)

	-- Removes every element of the table starting at the end
	while table.getn(Table) > 0 do
		table.remove(Table);
	end
	
end

-- *****************************************************************************
-- BeneCast Option Helper functions
-- *****************************************************************************

-- Function to set orientation of buttons
function BeneCast_OrientButtons(id)
	
	if id == nil then
		PutDebugMsg('BeneCast_OrientButtons(): id is nil');
		return;
	end
	
	if not BeneCastConfig['BeneCastPanel' .. id] then
		BeneCastConfig['BeneCastPanel' .. id] = {};
	end
	
	if not BeneCastConfig['BeneCastPanel' .. id]['Orientation'] then
		BeneCastConfig['BeneCastPanel' .. id]['Orientation'] = 'right';
	end
	
	local previousbutton = getglobal('BeneCastPanel' .. id .. 'Button1');
	local lastvisiblebutton = 0;
	
	if previousbutton:IsVisible() then
		lastvisiblebutton = 1;
	end
	
	for j = 2, BENECAST_MAX_NUMBER_OF_BUTTONS do
		-- The first button is fine where it is
		local button = getglobal('BeneCastPanel' .. id .. 'Button' .. j);
		
		button:ClearAllPoints();
		if BeneCastConfig['BeneCastPanel' .. id]['Orientation'] == 'down' then
			button:SetPoint('TOPLEFT',previousbutton,'BOTTOMLEFT',0,-3);
		else
			button:SetPoint('TOPLEFT',previousbutton,'TOPRIGHT',3,0);
		end
		
		if button:IsVisible() then
			lastvisiblebutton = j;
		end
		
		previousbutton = button;
	end
	
	BeneCast_ResizeButtonsFor(id);
	--[[
	if lastvisiblebutton > 0 then
		local buttonsize = BeneCastConfig.ButtonSize;
		frame = getglobal('BeneCastPanel' .. id);
		if BeneCastConfig['BeneCastPanel' .. id]['Orientation'] == 'down' then
			--Formula = dimension of each button (buttonsize) + borders (11) + space between each button (3)
			frame:SetHeight(buttonsize * lastvisiblebutton + 11 + (3 * (lastvisiblebutton - 1)));
			frame:SetWidth(buttonsize + 11);
		else
			frame:SetWidth(buttonsize * lastvisiblebutton + 11 + (3 * (lastvisiblebutton - 1)));
			frame:SetHeight(buttonsize + 11);
		end
	end
	]]

end

-- Function to resize the buttons of one panel
function BeneCast_ResizeButtonsFor(i)

	local buttonsize = BeneCastConfig.ButtonSize;
	local button, buttonborder, buttoncooldown, buttonfade, frame;

	-- Resize the buttons based on the saved size for every button in a panel
	for j = 1,BENECAST_MAX_NUMBER_OF_BUTTONS do
		button = getglobal('BeneCastPanel' .. i .. 'Button' .. j);
		-- Set Button height and width to buttonsize
		button:SetHeight(buttonsize);
		button:SetWidth(buttonsize);
		buttonborder = getglobal('BeneCastPanel' .. i .. 'Button' .. j .. 'NormalTexture');
		-- Set the Button border to fit around the button
		buttonborder:SetHeight(buttonsize * 2 - (buttonsize/36) * 10);
		buttonborder:SetWidth(buttonsize * 2 - (buttonsize/36) * 10);
		buttoncooldown = getglobal('BeneCastPanel' .. i .. 'Button' .. j .. 'Cooldown');
		-- Set Cooldown size
		buttoncooldown:SetScale((buttonsize / 36));
		buttoncooldown:SetPoint('CENTER', button, 'CENTER');
		buttonfade = getglobal('BeneCastPanel' .. i .. 'Button' .. j .. 'Fade');
		-- Set Fade size
		buttonfade:SetHeight(buttonsize * 2 - (buttonsize/36) * 10);
		buttonfade:SetWidth(buttonsize * 2 - (buttonsize/36) * 10);
		-- Resize the BeneCastPanelFrame based on the number of buttons shown
		if ( button:IsVisible() ) then
			if not BeneCastConfig['BeneCastPanel' .. i] then
				BeneCastConfig['BeneCastPanel' .. i] = {};
			end
			frame = getglobal('BeneCastPanel' .. i);
			if BeneCastConfig['BeneCastPanel' .. i]['Orientation'] == 'down' then
				frame:SetHeight(buttonsize * j + 11 + (3 * (j - 1)));
				frame:SetWidth(buttonsize + 11);
			else
				frame:SetWidth(buttonsize * j + 11 + (3 * (j - 1)));
				frame:SetHeight(buttonsize + 11);
			end
		end
	end

end

-- Function to resize the buttons
function BeneCast_ResizeButtons()

	-- Resize the buttons for every unit in BC_targets
	-- i is the number associated with each unit	
	for i in BC_targets do		
		BeneCast_ResizeButtonsFor(i);
	end
	
end


-- Function to load up the saved values in BeneCastConfig
function BeneCast_LoadOptions()

	-- Load the String Data and saved value into the check buttons
	local button;
	local string;
	local checked;
	for index, value in BeneCastOptionFrameCheckButtons do
		button = getglobal('BeneCastOptionCheckButton'..value.index);
		string = getglobal('BeneCastOptionCheckButton'..value.index..'Text');
		checked = BeneCastConfig[value.cvar];
		button:SetChecked(checked);
		string:SetText(BENECAST_STRINGS[index]);
		button.tooltipText = BENECAST_STRINGS[value.tooltipText];
		-- If this is the tooltip option check to see if it's enabled
		-- If not disable the tooltip name option checkbutton
		if ( value.index == 5 and not checked ) then
			getglobal('BeneCastOptionCheckButton6'):Disable();
		-- If this is the notification option check to see if it's enabled
		-- If not disable all sub notification options
		elseif ( value.index == 8 and not checked ) then
			getglobal('BeneCastOptionCheckButton9'):Disable();
			getglobal('BeneCastOptionCheckButton10'):Disable();
			getglobal('BeneCastOptionCheckButton11'):Disable();
			getglobal('BeneCastOptionCheckButton12'):Disable();
			getglobal('BeneCastOptionCheckButton20'):Disable();
			getglobal('BeneCastOptionCheckButton13'):Disable();
			getglobal('BeneCastOptionCheckButton14'):Disable();
			getglobal('BeneCastOptionCheckButton15'):Disable();
			getglobal('BeneCastOptionCheckButton16'):Disable();
			getglobal('BeneCastOptionCheckButton17'):Disable();
			getglobal('BeneCastOptionCheckButton18'):Disable();
			getglobal('BeneCastOptionCheckButton19'):Disable();
			getglobal('BeneCastOptionCheckButton21'):Disable();
		-- If this is the heal notification option check to see if it's enabled
		-- If not disable all heal max notification
		elseif ( value.index == 16 and not checked ) then
			getglobal('BeneCastOptionCheckButton17'):Disable();
		end
	end

	local slider;
	local string;
	local curvalue;
	-- Load the String Data and saved value into the sliders
	for index, value in BeneCastOptionFrameSliders do
		slider = getglobal('BeneCastOptionSlider'..value.index);
		string = getglobal('BeneCastOptionSlider'..value.index..'Text');
		curvalue = getglobal('BeneCastOptionSlider'..value.index..'Value');
		slider:SetMinMaxValues(value.minValue, value.maxValue);
		slider:SetValueStep(value.valueStep);
		slider:SetValue(BeneCastConfig[value.cvar]);
		curvalue:SetText(BeneCastConfig[value.cvar]);
		string:SetText(BENECAST_STRINGS[value.text]);
		slider.tooltipText = BENECAST_STRINGS[value.tooltipText];
	end
	
	-- Load the user defined chat channel
	if ( BeneCastConfig['UserChannel'] ) then
		getglobal('BeneCastChannelEditBox'):SetText(BeneCastConfig['UserChannel']);
	end
	
	BeneCastUpdateCustomEditBoxes();
end

function BeneCastUpdateCustomEditBoxes()
	for i in BC_targets do
		for j, component in BCW_components do
			local editboxframe = getglobal('BeneCastPanel' .. i .. component);
			if editboxframe then
				if BeneCastConfig['BeneCastPanel' .. i] then
					if BeneCastConfig['BeneCastPanel' .. i][component] ~= nil then
						editboxframe:SetText(BeneCastConfig['BeneCastPanel' .. i][component]);
					else
						editboxframe:SetText('nil');
					end
				end
			end
		end				
	end
end

-- Loads the data into the spell check buttons
function BeneCast_LoadSpellConfig()

	-- Position of the current checkbuttons to label
	local i = 1;
	
	-- Name of the spell to make a checkbutton for
	local spellname;
	
	-- Assist checkbutton
	for j = 2,9 do
		getglobal( BeneCastOptionFrameSubframes[j] .. 'Button' .. i .. 'Text' ):SetText(BENECAST_STRINGS.TEXT_ASSIST);
		getglobal( BeneCastOptionFrameSubframes[j] .. 'Button' .. i ):Show();
		getglobal( BeneCastOptionFrameSubframes[j] .. 'Button' .. i ):SetChecked(BeneCastConfig[j]['assist']);
	end
	
	i = i + 1;
	
	-- Load up the spell buttons in the order in BC_spellsort
	for j, spelltype in BC_spellsort do
		-- If this class can cast this spelltype continue
		if BC_spell_data[spelltype] then
			local k = table.getn(BeneCast_SpellTypes_Sorting[BC_class][spelltype]);
			if k == nil then
				PutMsg('Can not find ' .. spelltype .. ' for class ' .. BC_class .. ' in Sortingtable !');
			else
				spellname = BeneCast_SpellTypes_Sorting[BC_class][spelltype][k];
				-- If this is a selfbuff only add it to the player frame
				local selfbuff = nil;
				if string.find(spelltype, 'self') then
					selfbuff = true;
				elseif ( ( BC_class == BENECAST_STRINGS.CLASS_HUNTER ) or ( BC_class == BENECAST_STRINGS.CLASS_WARLOCK ) and
				         spelltype == 'efficient' ) then
					selfbuff = true;
				elseif string.find(spelltype, 'weapon') then
					selfbuff = true;
				end
				if selfbuff then
					getglobal( BeneCastOptionFrameSubframes[1] .. 'Button' .. i .. 'Text' ):SetText(spellname);
					getglobal( BeneCastOptionFrameSubframes[1] .. 'Button' .. i ):Show();
					getglobal( BeneCastOptionFrameSubframes[1] .. 'Button' .. i ):SetChecked(BeneCastConfig[1][spelltype]);
				-- Otherwise add it to every spell subframe
				else
					for k = 1,9 do
						getglobal( BeneCastOptionFrameSubframes[k] .. 'Button' .. i .. 'Text' ):SetText(spellname);
						getglobal( BeneCastOptionFrameSubframes[k] .. 'Button' .. i ):Show();
						getglobal( BeneCastOptionFrameSubframes[k] .. 'Button' .. i ):SetChecked(BeneCastConfig[k][spelltype]);
					end
				end
				-- Increment i if a spell was added to the subframes
				i = i + 1;
			end
		end
	end
end

-- Resets data tables
function BeneCast_ResetData()

	-- Clear the BC_spell_data table
	for type in BC_spell_data do
		BeneCast_ClearTable(BC_spell_data[type]['spells']);
	end
	
	-- Reload the spell data
	BeneCast_LoadSpellData();
	
	-- Reload the spell checkbuttons
	BeneCast_LoadSpellConfig();
	
end

-- *****************************************************************************
-- BeneCast Frame Attachment Helper functions
-- *****************************************************************************

--Function to do several attaches at once
function BeneCast_AttachPartyPanelsFromVar()

	--players
	for x = 1, 5 do
		BeneCast_AttachPanelsFromVar(x);
	end
	--pets
	for x = 46, 50 do
		BeneCast_AttachPanelsFromVar(x);
	end
	--target
	BeneCast_AttachPanelsFromVar(91);
	--targettarget
	BeneCast_AttachPanelsFromVar(92);
	
end

-- Function to attach BeneCast panels to unit frames
-- Not raid frames, raid frames are handled with BeneCast_AttachRaidPanels
function BeneCast_SnapPanels(AddOnFrames) 

	if ( not AddOnFrames ) then
		PutDebugMsg('AddOnFrames is nil');
		return;
	end
	
	PutDebugMsg('BeneCast_SnapPanels(' .. AddOnFrames .. ')');
	
	local snapto_option = nil;
	
	for temp_i in BeneCast_SnapTo do
		if ( BeneCast_SnapTo[temp_i].AddOn == AddOnFrames ) then
			PutDebugMsg('Found match for ' .. temp_i);
			snapto_option = temp_i;
			break;
		else
			PutDebugMsg('No match for ' .. temp_i);
		end
	end
	
	if snapto_option then
		PutDebugMsg('Ended up with ' .. snapto_option);
	else
		PutDebugMsg('Nothing found');
		return;
	end;
	
	if ( BeneCastConfig.SnapTo ) then
		if snapto_option ~= BeneCastConfig.SnapTo then
			PutDebugMsg(snapto_option .. ' ~= Current SnapTo option ' .. BeneCastConfig.SnapTo);
			return;
		end
	else
		PutDebugMsg('CheckOptionValue is true and BeneCastConfig.SnapTo is nil');
		return;
	end
	
	for framename, frametable in BeneCast_SnapTo[snapto_option] do
		if ( frametable and framename ~= 'AddOn' and framename ~= '' ) then
			PutDebugMsg('Reading config for BeneCast_SnapTo[' .. snapto_option .. '][' .. framename .. '] = ' .. frametable.frame);
			if BeneCastConfig[framename] == nil then
				BeneCastConfig[framename] = {};
			end;
			BeneCastConfig[framename].Moved = false;
			BeneCastConfig[framename].Frame = frametable.frame;
			BeneCastConfig[framename].Point = frametable.point;
			BeneCastConfig[framename].RelativePoint = frametable.relativePoint;
			BeneCastConfig[framename].X = frametable.x;
			BeneCastConfig[framename].Y = frametable.y;
			BeneCastConfig[framename].Orientation = frametable.orientation;
		end
	end
	
	--PutDebugMsg('Attaching panels 1-5, 46-50 and 91');
	--BeneCast_AttachPartyPanelsFromVar();
	
	PutDebugMsg('Updating Config Controls');
	
	BeneCastUpdateCustomEditBoxes();
end

function BeneCast_AttachPanelsFromVar(id)
	PutDebugMsg('BeneCast_AttachPanelsFromVar(), entered function');
	if ( not id ) then
		PutDebugMsg('BeneCast_AttachPanelsFromVar(), id is nil');
		return;
	end
	if ( id < 1 ) or ( id > 92 ) then
		PutDebugMsg('BeneCast_AttachPanelsFromVar(), id is out of range (' .. id .. ')');
		return;
	end
	local framename = 'BeneCastPanel' .. id;
	local panel = getglobal(framename);
	if BeneCastConfig[framename] == nil then
		BeneCastConfig[framename] = {
			['Frame'] = '',
			['Point'] = '',
			['RelativePoint'] = '',
			['X'] = 0,
			['Y'] = 0,
			['Moved'] = false,
			['Orientation'] = 'right',
		};
	end
	if ( BeneCastConfig[framename]['Frame'] == nil ) or ( BeneCastConfig[framename]['Frame'] == '' ) then
		PutDebugMsg('BeneCast_AttachPanelsFromVar(), config-frame is nil or empty for Panel ' .. id);
		return;
	end
	local parent = getglobal(BeneCastConfig[framename]['Frame']);
	if ( not parent ) then
		PutDebugMsg('BeneCast_AttachPanelsFromVar(), frame ' .. BeneCastConfig[framename]['Frame'] .. ' not found');
		panel:Hide();
		return;
	end

	if ( not BeneCastConfig[framename]['Point'] ) or (BeneCastConfig[framename]['Point'] == '' ) then
		BeneCastConfig[framename]['Point'] = 'TOPLEFT';
	end
	if ( not BeneCastConfig[framename]['RelativePoint'] ) or ( BeneCastConfig[framename]['RelativePoint'] == '' ) then
		BeneCastConfig[framename]['RelativePoint'] = 'TOPRIGHT';
	end
	if ( not BeneCastConfig[framename]['X'] ) then
		BeneCastConfig[framename]['X'] = 0;
	end
	if ( not BeneCastConfig[framename]['Y'] ) then
		BeneCastConfig[framename]['Y'] = 0;
	end
	-- Make sure we got nice rounded numbers
	BeneCastConfig[framename]['X'] = math.floor(BeneCastConfig[framename]['X'] + 0.5);
	BeneCastConfig[framename]['Y'] = math.floor(BeneCastConfig[framename]['Y'] + 0.5);
	panel:SetParent(parent);
	panel:ClearAllPoints();
	local scaled_x = BeneCastConfig[framename]['X'] / panel:GetEffectiveScale();
	local scaled_y = BeneCastConfig[framename]['Y'] / panel:GetEffectiveScale();
	panel:SetPoint(BeneCastConfig[framename]['Point'], parent, BeneCastConfig[framename]['RelativePoint'],
	               scaled_x, scaled_y);
	panel:SetFrameStrata(parent:GetFrameStrata());
	panel:SetFrameLevel(parent:GetFrameLevel() + 1);
	-- Set up the correct level for the buttons on the panel
	for x = 1, BENECAST_MAX_NUMBER_OF_BUTTONS do
		getglobal(framename .. 'Button' .. x):SetFrameLevel(panel:GetFrameLevel() + 1);
		getglobal(framename .. 'Button' .. x .. 'Cooldown'):SetFrameLevel(panel:GetFrameLevel() + 2);
	end
	PutDebugMsg('Hanged Panel ' .. framename .. '-s ' .. BeneCastConfig[framename]['Point'] .. '  to ' .. BeneCastConfig[framename]['Frame'] ..
	  '-s ' .. BeneCastConfig[framename]['RelativePoint']);
	
	BeneCast_OrientButtons(id);
end

--Hook function to intercept updates to CT_RA's update function
function BC_UpdateRaidGroup(updateType)
	--First make CT_RA update it's own frames by calling it's own function
	if BC_Old_CTRA_UpdateFunction ~= nil then
		BC_Old_CTRA_UpdateFunction(updateType);
	end
	--Then call our own update-function
	if updateType == 0 or updateType == 3 then
		BC_UpdateRaid = true;
	end
end

--Function to attach BeneCast panels to raid unit frames
function BeneCast_AttachRaidPanels(snapto)

	local name, rank, subgroup, level, class, fileName, zone, online, isDead;
	
	-- If Raid buttons are not being shown don't spend time attaching frames
	if not BeneCastConfig.ShowRaid then
		PutDebugMsg('BeneCast_AttachRaidPanels(): return because Show Raid is disabled');
		return;
	end
	
	if not snapto then
		PutDebugMsg('BeneCast_AttachRaidPanels(): return because snapto is nil/false');
		return;
	end
	
	if not BeneCast_RaidSnapTo[snapto] then
		PutDebugMsg('BeneCast_AttachRaidPanels(): return because BeneCast_RaidSnapTo[' .. snapto .. '] is nil/false');
		return;
	end
	
	if not BeneCast_RaidSnapTo[snapto]['Funct'] then
		PutDebugMsg('BeneCast_AttachRaidPanels(): return because BeneCast_RaidSnapTo[' .. snapto .. '].Func is nil/false');
		return;
	end
	
	-- Only call function once, it will now do it all in one loop, no parameters needed anymore
	BeneCast_RaidSnapTo[snapto]['Funct']();

end

-- *****************************************************************************
-- BeneCast Raid Helper functions
-- *****************************************************************************

function BeneCast_ClearRaid()

	-- Reset all the buttons
	for i = 1, MAX_RAID_MEMBERS do
		getglobal('BeneCastRaidButton' .. i):SetChecked('false');
		getglobal('BeneCastRaidButton' .. i):Disable();
		getglobal('BeneCastRaidButton' .. i .. 'Empty'):SetText(BENECAST_STRINGS.TEXT_EMPTY);
		getglobal('BeneCastRaidButton' .. i .. 'Empty'):SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
		getglobal('BeneCastRaidButton' .. i .. 'Name'):SetText('');
		getglobal('BeneCastRaidButton' .. i .. 'Level'):SetText('');
		getglobal('BeneCastRaidButton' .. i .. 'Class'):SetText('');
	end
	
	--Reset Panel Pool too
	BENECAST_RAID_PANELS = {}; 
	BENECAST_RAID_PANELS2 = {};
	BENECAST_RAID_PANELS3 = {};
	
	for i = 6, 45 do
		local panel = getglobal('BeneCastPanel' .. i);
		if panel then
			panel:Hide();
		end
	end
	for i = 51, 90 do
		local panel = getglobal('BeneCastPanel' .. i);
		if panel then
			panel:Hide();
		end
	end
end

function BeneCast_UpdateRaid()

	if not BeneCastConfig.ShowRaid then
		local testtext = getglobal('BeneCastRaidButton1Name'):GetText();
		if testtext ~= nil and testtext ~= '' then
			BeneCast_ClearRaid();
		end
		return;
	end;

	local name, rank, subgroup, level, class, fileName, zone, online, isDead;
	local newRaidRoster = {};
	local newRaidRoster2 = {};
	
	-- Reset the Subgroups table
	for i = 1, NUM_RAID_GROUPS do
		BENECAST_RAID_SUBGROUPS[i] = 0;
	end
	
	-- Reset all the buttons
	BeneCast_ClearRaid();
	
	-- Set up all the buttons
	for i = 1, GetNumRaidMembers() do
		name, rank, subgroup, level, class, fileName, zone, online, isDead = GetRaidRosterInfo(i);
		if ( name ) then
			BENECAST_RAID_SUBGROUPS[subgroup] = BENECAST_RAID_SUBGROUPS[subgroup]+1;
			newRaidRoster['raid' .. i] = {
				name = name,
				rank = rank,
				subgroup = subgroup,
				level = level,
				class = class,
				fileName = fileName,
				zone = zone,
				online = online,
				isDead = isDead,
			};
			newRaidRoster2[name] = 'raid' .. i;
			local raidbutton = 'BeneCastRaidButton' .. ((subgroup-1)*MEMBERS_PER_RAID_GROUP + BENECAST_RAID_SUBGROUPS[subgroup]);
			local color_r = RAID_CLASS_COLORS[fileName].r;
			local color_g = RAID_CLASS_COLORS[fileName].g;
			local color_b = RAID_CLASS_COLORS[fileName].b;
			if ( BENECAST_RAID_LIST[name] ) then
				getglobal(raidbutton):SetChecked('true');
			end
			getglobal(raidbutton):Enable();
			getglobal(raidbutton .. 'Empty'):SetText(nil);
			getglobal(raidbutton .. 'Empty'):SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
			getglobal(raidbutton .. 'Name'):SetText(name);
			getglobal(raidbutton .. 'Name'):SetTextColor(color_r, color_g, color_b);
			getglobal(raidbutton .. 'Level'):SetText(level);
			getglobal(raidbutton .. 'Level'):SetTextColor(color_r, color_g, color_b);
			getglobal(raidbutton .. 'Class'):SetText(class);
			getglobal(raidbutton .. 'Class'):SetTextColor(color_r, color_g, color_b);		
			
			if UnitExists('raidpet' .. i) then
				local punit = 'raidpet' .. i;
				newRaidRoster[punit] = {};
				local petname = UnitName(punit);
				newRaidRoster[punit].name = newRaidRoster['raid' .. i].name .. '|' .. petname;
				newRaidRoster2[newRaidRoster[punit].name] = punit;
				newRaidRoster[punit].rank = rank;
				newRaidRoster[punit].subgroup = subgroup;
				newRaidRoster[punit].level = UnitLevel(punit);
				newRaidRoster[punit].class = UnitClass(punit);
				newRaidRoster[punit].zone = zone;
				newRaidRoster[punit].online = online;
				newRaidRoster[punit].isDead = false;
			end
		end
	end
			
	-- Replace old raid-roster with new
	BENECAST_RAID_ROSTER = newRaidRoster;
	BENECAST_RAID_ROSTER2 = newRaidRoster2;
	
	-- Attach the Raid Panels to the correct frames
	BeneCast_AttachRaidPanels(BeneCastConfig.RaidSnapTo);
	
	-- Redraw the buttons for the raid
	for i = 6,45 do
		BeneCast_UpdateButtons(i);
	end
	for i = 51,90 do
		BeneCast_UpdateButtons(i);
	end

end

-- *****************************************************************************
-- BeneCast Unit Helper functions
-- *****************************************************************************

-- Function to determine if a unit is in your raid group
function BeneCast_UnitInRaid(unit)

	return UnitPlayerOrPetInRaid(unit);
	
end

-- Function to determine if a unitid is 'raid'..x
function BeneCast_UnitIsRaidID(unit)

	if string.find(unit,'raid') and not string.find(unit,'raidpet') then
		return true;
	end
	return nil;
	
end

-- Function to determine if a unitid is x..'pet'..y
function BeneCast_UnitIsPetID(unit)

	return string.find(unit, 'pet');
	
end

-- Function to determine if a unitid is 'raidpet'..x
function BeneCast_UnitIsRaidPetID(unit)

	return string.find(unit, 'raidpet');
	
end


-- Function to determine if a unit is a party pet
function BeneCast_UnitIsPartyPet(unit)

	return not UnitIsPlayer(unit) and UnitPlayerOrPetInParty(unit);
	
end

-- Function to determine if a unit is a raid pet
function BeneCast_UnitIsRaidPet(unit)

	return not UnitIsPlayer(unit) and UnitPlayerOrPetInRaid(unit);
	
end

-- Function to determine the BeneCastPanel number(s) of a UnitId
-- might return >1 number if it's a raidid
function BeneCast_UnitID(unit)

	if ( unit ) then
		if string.find(unit,'raid') then
			if BENECAST_RAID_PANELS3[unit] then
				local resultval = { };
				for i, parentframe in BENECAST_RAID_PANELS3[unit] do
					table.insert(resultval,BENECAST_RAID_PANELS[parentframe]);
				end
				return resultval;
			end
		end
		for i in BC_targets do
			if unit == BC_targets[i] then
				return i;
			end
		end
	end
	return nil;

end

-- *****************************************************************************
-- BeneCast Equipment Scanning functions
-- *****************************************************************************

function BeneCast_UpdateHealingBonuses()

	BC_plusheal = 0;
	if BonusScanner then
		if BonusScanner.active and ( BeneCastConfig.DmgBasedHeal or 
	                                     ( not BeneCastConfig.DmgBasedHeal and BeneCastConfig.ReverseHoTs ) ) then
			BC_plusheal = BonusScanner.bonuses['HEAL'];
			if BeneCastConfig.Debug then
				local ph;
				if BC_plusheal then
					ph = '+' .. BC_plusheal;
				else
					ph = 'nil';
				end
				PutDebugMsg('Plusheal is now ' .. ph);
			end
		end
	end
	--Call the next hook
	if BC_BonusScanner_HookFunction ~= nil then
		BC_BonusScanner_HookFunction();
	end

end

-- *****************************************************************************
-- BeneCast tooltip parsing functions
-- *****************************************************************************

-- Functions for parsing healing info from tooltip. Thanks Danboo!
local function parse_integer(text, index)

	if ( not text ) then
		return 0;
	end
	
	local i = 1;
	-- Replace ',' with '.', needed for German client. Thanks Auric!
	text = string.gsub(text, ',', '.');
	for integer in string.gfind(text, '%d+%.?%d*') do
		if ( i == index ) then
			return tonumber(integer);
		end
		i = i + 1;
	end

end

-- Pull the first integer
local function pi_first(text)
	return parse_integer(text, 1);
end

-- Pull the second integer
local function pi_second(text)
	return parse_integer(text, 2);
end

-- Pull the second integer
local function pi_third(text)
	return parse_integer(text, 3);
end

-- Pull the second integer
local function pi_fourth(text)
	return parse_integer(text, 4);
end

-- Mapping of healing spell lines to heal amount parsers. Thanks Danboo!
-- Spell parsing is slightly different in the German client
local BC_spell_parsers = {}
if ( GetLocale() == 'deDE' ) then
	BC_spell_parsers = {
		[BENECAST_STRINGS.CLASS_SHAMAN] = {
				[BENECAST_STRINGS.HEAL_HEALING_WAVE] = pi_second,
				[BENECAST_STRINGS.HEAL_LESSER_HEALING_WAVE] = pi_second,
				[BENECAST_STRINGS.HEAL_CHAIN_HEAL] = pi_second,
		},
		[BENECAST_STRINGS.CLASS_PRIEST] = {
				[BENECAST_STRINGS.HEAL_LESSER_HEAL] = pi_second,
				[BENECAST_STRINGS.HEAL_HEAL] = pi_second,
				[BENECAST_STRINGS.HEAL_GREATER_HEAL] = pi_second,
				[BENECAST_STRINGS.HEAL_FLASH_HEAL] = pi_second,
				[BENECAST_STRINGS.HEAL_RENEW] = pi_second,
				[BENECAST_STRINGS.HEAL_PRAYER_OF_HEALING] = pi_second,
		},
		[BENECAST_STRINGS.CLASS_DRUID] = {
				[BENECAST_STRINGS.HEAL_HEALING_TOUCH] = pi_second,
				[BENECAST_STRINGS.HEAL_REJUVENATION] = pi_second,
				[BENECAST_STRINGS.HEAL_REGROWTH] = pi_second,
				[BENECAST_STRINGS.HEAL_TRANQUILITY] = pi_third,
		},
		[BENECAST_STRINGS.CLASS_PALADIN] = {
				[BENECAST_STRINGS.HEAL_HOLY_LIGHT] = pi_second,
				[BENECAST_STRINGS.HEAL_FLASH_OF_LIGHT] = pi_second,
				[BENECAST_STRINGS.HEAL_LAY_ON_HANDS] = pi_second,
				[BENECAST_STRINGS.HEAL_HOLY_SHOCK] = pi_fourth,
		},
		[BENECAST_STRINGS.CLASS_HUNTER] = {
				[BENECAST_STRINGS.HEAL_MEND_PET] = pi_first,
		},
		[BENECAST_STRINGS.CLASS_WARLOCK] = {
				[BENECAST_STRINGS.HEAL_HEALTH_FUNNEL] = pi_first,
		},
	};
else
	BC_spell_parsers = {
		[BENECAST_STRINGS.CLASS_SHAMAN] = {
			[BENECAST_STRINGS.HEAL_HEALING_WAVE] = pi_second,
			[BENECAST_STRINGS.HEAL_LESSER_HEALING_WAVE] = pi_second,
			[BENECAST_STRINGS.HEAL_CHAIN_HEAL] = pi_second,
		},
		[BENECAST_STRINGS.CLASS_PRIEST] = {
			[BENECAST_STRINGS.HEAL_LESSER_HEAL] = pi_second,
			[BENECAST_STRINGS.HEAL_HEAL] = pi_second,
			[BENECAST_STRINGS.HEAL_GREATER_HEAL] = pi_second,
			[BENECAST_STRINGS.HEAL_FLASH_HEAL] = pi_second,
			[BENECAST_STRINGS.HEAL_RENEW] = pi_first,
			[BENECAST_STRINGS.HEAL_PRAYER_OF_HEALING] = pi_second,
		},
		[BENECAST_STRINGS.CLASS_DRUID] = {
			[BENECAST_STRINGS.HEAL_HEALING_TOUCH] = pi_second,
			[BENECAST_STRINGS.HEAL_REJUVENATION] = pi_first,
			[BENECAST_STRINGS.HEAL_REGROWTH] = pi_second,
			[BENECAST_STRINGS.HEAL_TRANQUILITY] = pi_first,
		},
		[BENECAST_STRINGS.CLASS_PALADIN] = {
			[BENECAST_STRINGS.HEAL_HOLY_LIGHT] = pi_second,
			[BENECAST_STRINGS.HEAL_FLASH_OF_LIGHT] = pi_second,
			[BENECAST_STRINGS.HEAL_LAY_ON_HANDS] = pi_second,
			[BENECAST_STRINGS.HEAL_HOLY_SHOCK] = pi_fourth,
		},
		[BENECAST_STRINGS.CLASS_HUNTER] = {
				[BENECAST_STRINGS.HEAL_MEND_PET] = pi_first,
		},
		[BENECAST_STRINGS.CLASS_WARLOCK] = {
				[BENECAST_STRINGS.HEAL_HEALTH_FUNNEL] = pi_first,
		},
	};
end

-- *****************************************************************************
-- BeneCast Spell Loading function
-- *****************************************************************************

function BeneCast_SwitchPriestHeals()
 	if BeneCastConfig['DmgBasedHeal'] then
		BeneCast_SpellTypes[BENECAST_STRINGS.CLASS_PRIEST][BENECAST_STRINGS.HEAL_LESSER_HEAL] = 'efficient';
		BeneCast_SpellTypes[BENECAST_STRINGS.CLASS_PRIEST][BENECAST_STRINGS.HEAL_HEAL] = 'efficient';
		BeneCast_SpellTypes[BENECAST_STRINGS.CLASS_PRIEST][BENECAST_STRINGS.HEAL_GREATER_HEAL] = 'efficient';
		BeneCast_SpellTypes_Sorting[BENECAST_STRINGS.CLASS_PRIEST]['efficient'] =
			{ BENECAST_STRINGS.HEAL_LESSER_HEAL,
		          BENECAST_STRINGS.HEAL_HEAL,
		          BENECAST_STRINGS.HEAL_GREATER_HEAL };
	else
		BeneCast_SpellTypes[BENECAST_STRINGS.CLASS_PRIEST][BENECAST_STRINGS.HEAL_LESSER_HEAL] = 'efficient';
		BeneCast_SpellTypes[BENECAST_STRINGS.CLASS_PRIEST][BENECAST_STRINGS.HEAL_HEAL] = 'efficient2';
		BeneCast_SpellTypes[BENECAST_STRINGS.CLASS_PRIEST][BENECAST_STRINGS.HEAL_GREATER_HEAL] = 'efficient3';
		BeneCast_SpellTypes_Sorting[BENECAST_STRINGS.CLASS_PRIEST]['efficient'] =
			{ BENECAST_STRINGS.HEAL_LESSER_HEAL };
		BeneCast_SpellTypes_Sorting[BENECAST_STRINGS.CLASS_PRIEST]['efficient2'] =
			{ BENECAST_STRINGS.HEAL_HEAL };
		BeneCast_SpellTypes_Sorting[BENECAST_STRINGS.CLASS_PRIEST]['efficient3'] =
			{ BENECAST_STRINGS.HEAL_GREATER_HEAL };
	end
end

--Sort two spells by order in BeneCast_SpellTypes_Sorting
function BeneCast_GetSpellPos(spelltype, spellname)
	local pos = 0;
	for i, spellname2 in BeneCast_SpellTypes_Sorting[BC_class][spelltype] do
		if spellname2 == spellname then
			pos = i;
			break;
		end
	end
	return pos;
end

function BeneCast_SortTwoSpells(a,b)
	if (a.name ~= b.name) then
		return BeneCast_GetSpellPos(a.spelltype,a.name) < BeneCast_GetSpellPos(b.spelltype,b.name);
	else
		return a.mana < b.mana
	end
end

-- Fill in the BC_spell_data table by iterating over spells in spellbook
-- and parsing tool tips for info. Thanks Danboo!
function BeneCast_LoadSpellData()
	PutDebugMsg('Parsing Spell Data from spellbook');
	
	BeneCast_SwitchPriestHeals();
	BC_spell_data = {}; 
	
	-- Iterator to move through the spellbook
	local i = 1;

	while true do
		
		-- Spell at position i in the player's spellbook
		local spell_name, spell_rank = GetSpellName(i, SpellBookFrame.bookType);
		
		-- If there is no spell at i, break out of the loop
		if not spell_name then
			do break end
		end
		
		-- Load up the spell_type based on the spell name and player class
		local spell_type = BeneCast_SpellTypes[BC_class][spell_name];

		-- If the spell_type exists do stuff
		if ( spell_type ) then
						
			-- Set BeneCast_Tooltip to the spell info
			-- Be sure to clear it first
			BeneCast_Tooltip:ClearLines();
			BeneCast_Tooltip:SetSpell(i, SpellBookFrame.bookType);
			
			local mana_cost, heal_amount, dot_duration;
			local useTC = false;
			--[[
			if TheoryCraft_GetSpellDataByFrame then
				local spelldata = TheoryCraft_GetSpellDataByFrame(BeneCast_Tooltip);
				if spelldata then
					mana_cost = spelldata.manacost;
					heal_amount = spelldata.averagehealnocrit;
					dot_duration = spelldata.dotduration;
					useTC = true;
				end
			end
			]]
			if not useTC then
				-- If this spell has a set mana cost set mana_cost to it
				if ( not mana_cost ) and ( BeneCast_TooltipTextLeft2:GetText() ) then
					if ( string.find(BeneCast_TooltipTextLeft2:GetText(), '^(%d+) Mana') ) then
						_,_,mana_cost = string.find(BeneCast_TooltipTextLeft2:GetText(), '^(%d+) Mana');
					end
				end			
			
				-- If the spell_type is a heal spell then set heal_amount to the amount this spell heals
				if ( string.find(spell_type,'efficient') or 
				     spell_type == 'emergency' or 
				     string.find(spell_type,'instant') or 
				     spell_type == 'group' or spell_type == 'group2' ) then
					if BC_spell_parsers[BC_class][spell_name] ~= nil then
						if ( BeneCast_TooltipTextLeft5:GetText() ) then
							heal_amount = BC_spell_parsers[BC_class][spell_name](BeneCast_TooltipTextLeft5:GetText());
						elseif ( BeneCast_TooltipTextLeft4:GetText() ) then
							heal_amount = BC_spell_parsers[BC_class][spell_name](BeneCast_TooltipTextLeft4:GetText());
						else
							heal_amount = BC_spell_parsers[BC_class][spell_name](BeneCast_TooltipTextLeft3:GetText());
						end
					end
				end
			end
			-- If this spell does not have a set mana cost, but does have a rank set mana_cost to the rank
			-- This is to ensure correct spell ordering
			if ( not mana_cost ) and ( spell_rank ~= '' ) then
				_, _, mana_cost = string.find(spell_rank, '%d+');
			end
			-- If this spell does not have a set mana cost or rank, set mana_cost to zero
			-- I'm guessing there is no need to order a spell type if it has no ranks
			if ( not mana_cost ) then
				mana_cost = 0;
			end

			-- If the player class is Paladin and the spell is Lay on Hands set heal_amount to zero
			-- This is to ensure that the highest rank is always used
			if BC_class == BENECAST_STRINGS.CLASS_PALADIN and spell_type == 'loh' then
				heal_amount = 0;
			end
			if not heal_amount then
				heal_amount = 0;
			end
							
			-- If there isn't anything in BC_spell_data[spell_type] yet then create a table for it
			if ( not BC_spell_data[spell_type] ) then
				BC_spell_data[spell_type] = {};
				BC_spell_data[spell_type]['spells'] = {};
			end
			
			local entry;
			-- If the entry type is a heal spell be sure to include rank and max_heal information
			if ( string.find(spell_type,'efficient') or 
			     spell_type == 'emergency' or 
			     string.find(spell_type,'instant') or 
			     spell_type == 'group' or spell_type == 'group2' ) then
				entry = { name = (spell_name),
					rank = (spell_rank),
					max_heal = tonumber(heal_amount),
					mana = tonumber(mana_cost),
					spelltype = spell_type, 
					duration = dot_duration,
					id = i };
			-- If the entry is a cure you don't need the rank
			elseif ( spelltype == 'poison' or spelltype == 'disease' or spelltype == 'magic' or spelltype == 'curse' ) then
				entry = {name = (spell_name),
					mana = tonumber(mana_cost),
					spelltype = spell_type, 
					duration = dot_duration,
					id = i };
			-- Otherwise it's a buff and include the spell rank if you can
			elseif ( spell_rank ~= '' ) then
				entry = {name = (spell_name),
					rank = (spell_rank),
					mana = tonumber(mana_cost),
					spelltype = spell_type,
					duration = dot_duration,
					id = i };
			-- If there is no rank, don't put a spell rank into the entry
			else
				entry = {name = (spell_name),
					mana = tonumber(mana_cost),
					spelltype = spell_type,
					duration = dot_duration,
					id = i };
			end
			
			-- Insert the entry into the appropriate table
			table.insert(BC_spell_data[spell_type]['spells'], entry);

		end

		i = i + 1;

	end
	
	-- Sort the spells by mana cost within each spell type
	for type in BC_spell_data do
		table.sort(BC_spell_data[type]['spells'], BeneCast_SortTwoSpells);
	end
	
	-- If the spell_type does not have a texture associated with it set it
	for type in BC_spell_data do
		local texture;
		-- Make sure the texture is for the last entry in the table
		local i = table.getn(BC_spell_data[type]['spells']);
		texture = GetSpellTexture(BC_spell_data[type]['spells'][i].id, SpellBookFrame.bookType);
		BC_spell_data[type].texture = texture;
		BC_spell_data[type].type = type;
	end
	
end

--[[
function BeneCast_UpdateSpellsFromTC()

	for spell_type in BC_spell_data do
		for i in BC_spell_data[spell_type]['spells'] do
			BeneCast_Tooltip:ClearLines();
			BeneCast_Tooltip:SetSpell(BC_spell_data[spell_type]['spells'][i].id, SpellBookFrame.bookType);
			local spelldata = TheoryCraft_GetSpellDataByFrame(BeneCast_Tooltip);
			if spelldata then
				BC_spell_data[spell_type]['spells'][i].mana = spelldata.manacost;
				BC_spell_data[spell_type]['spells'][i].max_heal = tonumber(spelldata.averagehealnocrit);
				BC_spell_data[spell_type]['spells'][i].duration = spelldata.dotduration;
			end
		end
	end
			
end
]]

-- *****************************************************************************
-- BeneCast spell choose functions
-- *****************************************************************************

-- Interpolates the health of the given unit (used for those outside the party). Thanks Danboo!
-- Returns an estimated health for a target outside the party
function BeneCast_UnitInterpolateHealth(unit, health_percent)
	
	local class      = UnitClass(unit);
	if class == nil then
		class = BENECAST_STRINGS.CLASS_WARRIOR;
	end
	local level      = UnitLevel(unit);
	local slope      = ( BC_class_health[class]['60'] - BC_class_health[class]['1'] ) / 59;
	local health_max = level * slope + BC_class_health[class]['1'];
	local health     = health_max * health_percent / 100;
	return floor(health), floor(health_max);
	
end

-- Function to Choose the appropriate spell to cast. Thanks Danboo!
-- Returns the spell to be cast
function BeneCast_ChooseSpell(type, target, forcemax, forceoverheal)

	-- Determine if the max heal has been forced with the shift key
	local usemaxspell;
	if forcemax then
		usemaxspell = true;
	else
		usemaxspell = not BeneCastConfig.DmgBasedHeal;
		-- If maxheal is not true then reverse the functionality of forcemax
		if IsShiftKeyDown() then
			usemaxspell = not usemaxspell;
			PutDebugMsg('Shift Key down, reversing DmgBasedHealing');
		end
		--HoT's are always max-rank if DBH and ReverseHoTs is enabled or both are disabled
		if ( BC_class == BENECAST_STRINGS.CLASS_PRIEST and type == 'instant' ) or
		   ( BC_class == BENECAST_STRINGS.CLASS_DRUID and ( type == 'instant' or type == 'emergency' ) ) then
			if BeneCastConfig.ReverseHoTs then
				usemaxspell = not usemaxspell;
			end
		end
	end
	
	local allowoverheal;
	if forceoverheal then
		allowoverheal = true;
	else
		allowoverheal = BeneCastConfig.Overheal;
		if IsControlKeyDown() then
			allowoverheal = not allowoverheal;
			PutDebugMsg('Ctrl Key down, reversing Overheal');
		end
	end
	
	--WINTROW.6 START
	--[[
	if BeneCastConfig.Debug then
		local msg = 'Finding spell for ';
		if type then
			msg = msg .. 'type=' .. type;
		else
			msg = msg .. 'type=nil';
		end
		if target then
			msg = msg .. ', target=' .. target;
		else
			msg = msg .. ', target=nil';
		end
		if usemaxspell ~= nil then
			if usemaxspell then
				msg = msg .. ', usemaxspell=true';
			else
				msg = msg .. ', usemaxspell=false';
			end
		else
			msg = msg .. ', usemaxspell=nil';
		end
		if allowoverheal ~= nil then
			if allowoverheal then
				msg = msg .. ', allowoverheal=true';
			else
				msg = msg .. ', allowoverheal=false';
			end
		else
			msg = msg .. ', allowoverheal=nil';
		end
		PutDebugMsg(msg);
	end
	]]
	--WINTROW.6 STOP

	
	if ( type == 'assist' ) then
		return;
	end
	
	if not BC_plusheal then
		BC_plusheal = 0;
	end

	local mana = UnitMana('player');	
	local maxhealth = 0;
	local health = 0;
	-- If the type is group then calculate the total party damage percentage
	if ( type == 'group' or type == 'group2' ) then
		for i = 1,5 do
			maxhealth = maxhealth + UnitHealthMax(BC_targets[i]);
			health = health + UnitHealth(BC_targets[i]);
		end
		maxhealth = maxhealth * BC_threshold;
	-- Else calculate the damage percentage of the target
	else
		maxhealth = UnitHealthMax(target) * BC_threshold;
		health = UnitHealth(target);
	end
	-- If the target is not in the party/raid use UnitInterpolateHealth to determine health
	if not (UnitIsUnit(target,'player') or UnitInParty(target) or BeneCast_UnitInRaid(target) ) then
		health, maxhealth = BeneCast_UnitInterpolateHealth(target, health);
	end
	
	-- overhealamount is the number of ranks to overheal from the targets current hp
	local overhealamount = 0;
	if ( allowoverheal ) then
		overhealamount = BeneCastConfig.OverhealSlider;
	end
	
	local spell = nil;
	
	-- Redid the spell-choosing, more generic code
	local checkdmgbasedhealing, checklevel, checkmana;
	if ( string.find(type,'efficient') or type == 'emergency' or string.find(type,'instant') or 
	     type == 'group' or type == 'group2' ) then
		checkdmgbasedhealing = true;
		checklevel = true;
		checkmana = true;
	-- If type is a cure effect then always cast the best cure, since they all take the same mana
	elseif ( type == 'poison' or type == 'disease' or type == 'magic' or type == 'curse' ) then
		checkdmgbasedhealing = false;
		checklevel = true;
		checkmana = true;
	-- Else the spell being cast is a buff, cast the highest one possible
	else
		checkdmgbasedhealing = false;
		checklevel = true;
		checkmana = false;
	end
	
	-- If forcemax, you want the biggest heal you got
	if usemaxspell then
		checkdmgbasedhealing = false;
	end
	
	if not BeneCastConfig.ManaBasedHeal then
		checkmana = false;
	end
	
	if BC_clearcasting then
		checkmana = false;
		PutDebugMsg('Not checking mana due to Clearcasting');
	end
	
	if BC_spirit_of_redemption then
		checkmana = false;
		PutDebugMsg('Not checking mana due to Spirit of Redemption');
	end
	
	-- If Inner Focus is active, spells are free!
	if BC_innerfocus then
		checkmana = false;
		PutDebugMsg('Not checking mana due to Inner Focus');
	end
	
	--pet-heals don't care about dmg based healing
	if ( BC_class == BENECAST_STRINGS.CLASS_HUNTER and type == 'efficient' ) then
		checkdmgbasedhealing = false;
	elseif ( BC_class == BENECAST_STRINGS.CLASS_WARLOCK and type == 'efficient' ) then
		checkdmgbasedhealing = false;
	end
	
	local i = table.getn(BC_spell_data[type]['spells']);
	local problem = nil;
	while ( i > 0 and spell == nil ) do
		problem = nil;
		-- Check for sufficient mana
		if ( problem == nil and checkmana ) then
			if BC_spell_data[type]['spells'][i].mana > mana then
				problem = 'mana';
			end
		end
		-- Check for sufficient level
		if ( problem == nil and checklevel ) then
			if UnitLevel(target) < (BeneCast_SpellLevel[BC_class][type][i] - 10) then
				problem = 'level';
			end
		end
		-- Check for overheal
		if ( problem == nil and checkdmgbasedhealing ) then
			-- Artificially lower rank used for check by what's on the overheal-slider
			local k = i - overhealamount;
			if k <= 0 then
				k = 1;
			end
			if (BC_spell_data[type]['spells'][k].max_heal + BC_plusheal + health) > maxhealth then
				problem = 'overheal';
			end
		end
		if ( problem == nil ) then
			spell = BC_spell_data[type]['spells'][i];
		end			
		i = i - 1;
	end
	-- Set the spell to the lowest possible cast if spell is not set. Used to announce 'Out of Mana' and for tooltips
	if ( spell == nil and not ( problem == 'overheal' and not allowoverheal ) ) then
		spell = BC_spell_data[type]['spells'][1];
	elseif ( spell == nil and ( problem == 'overheal' and not allowoverheal ) ) then
		PutMsg('Casting cancelled to prevent overheal');
	end
		
	-- Return the spell to be cast
	return spell;

end

-- *****************************************************************************
-- BeneCast Slash Command Handler
-- *****************************************************************************

-- Slash command handler
-- The only slash command is to show the config GUI
function BeneCast_SlashCommandHandler(msg)

	if string.find(msg,'debug') then
		if BeneCastConfig['Debug'] then
			BeneCastConfig['Debug'] = false;
			PutMsg('command : ' .. msg .. ' , debug is now off');
		else
			BeneCastConfig['Debug'] = true;
			PutMsg('command : ' .. msg .. ' , debug is now on');
		end
	elseif string.find(msg,'peekb (.+)') then
		local varname;
		_, _, varname = string.find(msg,'peekb (.+)');
		if varname then
			if BeneCastConfig[varname] ~= nil then
				if ( BeneCastConfig[varname] == true ) or ( BeneCastConfig[varname] == 1 ) then
					PutMsg('command : ' .. msg .. ' , BeneCastConfig[' .. varname .. '] = true');
				else
					PutMsg('command : ' .. msg .. ' , BeneCastConfig[' .. varname .. '] = false');
				end
			else
				PutMsg('command : ' .. msg .. ' , BeneCastConfig[' .. varname .. '] = nil or not found');
			end
		else
			PutMsg('command : ' .. msg .. ' , invalid parameter');
		end
	elseif string.find(msg,'peek (.+) (.+)') then
		local varname, varname2;
		_, _, varname, varname2 = string.find(msg,'peek (.+) (.+)');
		if varname and varname2 then
			if BeneCastConfig[varname][varname2] then
				PutMsg('command : ' .. msg ..
				  ' , BeneCastConfig[' .. varname .. '][' .. varname2 .. '] = ' ..
				  BeneCastConfig[varname][varname2]);
			else
				PutMsg('command : ' .. msg ..
				  ' , BeneCastConfig[' .. varname .. '][' .. varname2 .. '] = nil or not found');
			end
		else
			PutMsg('command : ' .. msg .. ' , invalid parameter');
		end
	elseif string.find(msg,'peek (.+)') then
		local varname;
		_, _, varname = string.find(msg,'peek (.+)');
		if varname then
			if BeneCastConfig[varname] then
				PutMsg('command : ' .. msg .. ' , BeneCastConfig[' .. varname ..
				  '] = ' .. BeneCastConfig[varname]);
			else
				PutMsg('command : ' .. msg .. ' , BeneCastConfig[' .. varname .. 
				  '] = nil or not found');
			end
		else
			PutMsg('command : ' .. msg .. ' , invalid parameter');
		end
	elseif string.find(msg,'snapto2 (.+)') then
		local addonpar;
		_, _, addonpar = string.find(msg,'snapto2 (.+)');
		if addonpar then
			PutMsg('trying to snapto ' .. addonpar);
			SetBeneCastSnapTo2(addonpar);
		else
			PutMsg('snapto2 had no value after it');
		end
	elseif string.find(msg,'snapto (.+)') then
		local addonname = nil;
		_, _, addonname = string.find(msg,'snapto (.+)');
		if addonname then
			PutMsg('trying to snapto ' .. addonname);
			SetBeneCastSnapTo(addonname);
		else
			PutMsg('snapto had no addonname after it');
		end
	else
		BeneCastOptionFrameToggle('LeftButton');
	end
	
end

-- *****************************************************************************
-- BeneCast Key Binding functions
-- *****************************************************************************

-- Function to toggle showing of all buffs
function BeneCast_ToggleBuffs()
	
	-- Toggle showallbuffs
	BeneCastConfig.ShowAllBuffs = not BeneCastConfig.ShowAllBuffs;
	
	for i in BC_targets do
		BeneCast_UpdateButtons(i);
	end

end

-- Function to cast spells through a binding
function BeneCast_BindingCast(id)

	-- The default target for the spell is the player
	local target = 'player';
	
	-- If there is a target and it's friendly choose the target as the target for the spell
	if ( UnitExists('target') and not UnitCanAttack('player', 'target') ) then
		target = 'target';
	end
	
	local spell;
	local spelltype;
	
	if ( target == 'player' ) then
		if ( not getglobal('BeneCastPanel1Button' .. id):IsVisible() ) then
			return;
		end
		spelltype = getglobal('BeneCastPanel1Button' .. id).spelltype;
	else
		if ( not getglobal('BeneCastPanel91Button' .. id):IsVisible() ) then
			return;
		end
		spelltype = getglobal('BeneCastPanel91Button' .. id).spelltype;
	end
	
	-- If a spell is already targeting stop targeting
	if ( SpellIsTargeting() ) then
		SpellStopTargeting();
	end
	
	-- Always take care of items on cursor with left clicks
	if ( button == 'LeftButton' and CursorHasItem() ) then
		if ( unit == 'player' ) then
			AutoEquipCursorItem();
		else
			DropItemOnUnit(target);
		end
		return;
	end
	
	local forcemax, forceoverheal;
	-- Cast Nature's Swiftness before casting the a Druid or Shaman heal if the Alt key is held down
	if ( IsAltKeyDown() and ( BC_class == BENECAST_STRINGS.CLASS_DRUID or BC_class == BENECAST_STRINGS.CLASS_SHAMAN ) and ( spelltype == 'efficient' or spelltype == 'emergency' ) and BC_spell_data['selfbuff1'] ) then
		local natureswiftness = BC_spell_data['selfbuff1']['spells'][1];
		CastSpell(natureswiftness.id, SpellBookFrame.bookType);
		SpellStopCasting();
		forcemax = true;
	end

	spell = BeneCast_ChooseSpell(spelltype, target, forcemax, forceoverheal);
	
	-- In case you're targeting an enemy and cast Dispel Magic
	local retarget_enemy = nil;
	
	-- Try casting the spell if it exists
	if ( spell ) then
		-- Dispel Magic can be used offensively, always target the intended target
		if ( (BC_class == BENECAST_STRINGS.CLASS_PRIEST and spelltype == 'magic') or 
		     (BC_class == BENECAST_STRINGS.CLASS_PALADIN and spelltype == 'instant') ) and 
		   UnitCanAttack('player', 'target')  then
			retarget_enemy = UnitCanAttack('player', 'target');
			--WINTROW.6 TargetUnit(target);
			ClearTarget(); --WINTROW.6
		end
		-- Cast the spell
		CastSpell(spell.id, SpellBookFrame.bookType);
		BC_spellbeingcast = spell;
		BC_spelltarget = target;
		BC_spellismax = forcemax;
		SpellTargetUnit(target);
	end
	
	-- Re-target the last enemy if you changed targets due to Dispel Magic
	if ( retarget_enemy ) then
		TargetLastEnemy();
	end
	
end

-- *****************************************************************************
-- BeneCast Party Notification functions
-- *****************************************************************************

-- Function for Party Notification
-- Modified SpeakSpell by Danboo. Thanks Danboo!
-- Returns true if a notification message was sent
function BeneCast_PartyNotify(target, spell, ismax, duration)

	-- If there is no duration, give a duration of 0
	if ( not duration ) then
		duration = 0;
	end
		
	if ( not BeneCastConfig.Notification ) then
		return nil;
	end
	
	-- Don't show time if notifytime is nil or duration is 0
	local time = nil;
	if ( duration > 0 and BeneCastConfig.NotifyTime ) then
		time = true;
	end
	
	-- Don't show rank if spell.rank is nil
	local rank = nil;
	if ( spell.rank and spell.rank ~= 'Rank 0' ) then
		rank = true;
	else
		spell.rank = 'Rank 0';
	end
	
	-- If the spell is targeting the player and not allowing self casts then return
	if ( not BeneCastConfig.SelfCasts and target == 'player' ) then
		return nil;
	end
	
	-- Figure out the spelltype for display purposes
	local type = BeneCast_SpellTypes[BC_class][spell.name];
	
	if type == nil then 
		PutDebugMsg('Unknown spell class ' .. BC_class .. ', spell ' .. spell.name);
		return nil;
	end
	
	local healamount_text = '';
	
	-- If the type is a heal and if notification for heals is false then return
	if ( string.find(type,'efficient') or type == 'emergency' or string.find(type,'instant') or 
	     type == 'group' or type == 'group2' ) then
		if ( not BeneCastConfig.NotifyHeal ) then
			return nil;
		-- else if notification for only max heals and not a max heal then return
		elseif ( BeneCastConfig.NotifyMaxHeal and not ismax ) then
			return nil;
		end
		if BeneCastConfig.SelfNotify then
			healamount_text = ' (';
			if spell.max_heal then
				healamount_text = healamount_text .. spell.max_heal;
			else
				healamount_text = healamount_text .. '???';
			end
			if BC_plusheal then
				if BC_plusheal ~= 0 then
					healamount_text = healamount_text .. '+' .. BC_plusheal .. ')';
				else
					healamount_text = healamount_text .. ')';
				end
			else
				healamount_text = healamount_text .. ')';
			end
		end
	-- If the type is a cure and if notification for cures is false then return
	elseif ( type == 'poison' or type == 'disease' or type == 'disease2' or type == 'magic' or type == 'curse' ) then
		if ( not BeneCastConfig.NotifyCure ) then
			return nil;
		end
	-- If the type is a res and if notification for res' is false then return
	elseif ( type == 'res' ) then
		if ( not BeneCastConfig.NotifyRes ) then
			return nil;
		end
	-- The type is a buff and if notification for buffs is false then return
	else
		if ( not BeneCastConfig.NotifyBuff ) then
			return nil;
		end
	end

	duration = string.format('%.1f', duration / 1000);

	local message_text;
	
	-- Set the message text based on what options are checked
	if ( rank and BeneCastConfig.NotifyRank and time ) then
		message_text = BENECAST_STRINGS.NOTIFY_ALL;
	elseif ( rank and BeneCastConfig.NotifyRank ) then
		message_text = BENECAST_STRINGS.NOTIFY_RANK;
	elseif ( time ) then
		message_text = BENECAST_STRINGS.NOTIFY_TIME;
	else
		message_text = BENECAST_STRINGS.NOTIFY;
	end
	
	message_text = string.gsub(message_text, '%%s', spell.name);
	-- If notifying the target, address them as 'you'
	if ( BeneCastConfig.TargetNotify ) then
		message_text = string.gsub(message_text, '%%t', BENECAST_STRINGS.NOTIFY_YOU);
	-- In laggy environments if the player's target was deselected while casting it does not have a name
	elseif ( UnitExists(target) ) then
		local name = UnitName(target);
		message_text = string.gsub(message_text, '%%t', name);
	else
		message_text = string.gsub(message_text, '%%t', BENECAST_STRINGS.NOTIFY_UNKNOWN_ENTITY);
	end
	message_text = string.gsub(message_text, '%%d', duration);
	message_text = string.gsub(message_text, '%%r', spell.rank);
	message_text = message_text .. healamount_text; --WINTROW.6
	
	-- Send the message on the appropriate channel
	if ( BeneCastConfig.SelfNotify ) then
		PutMsg(message_text);
	elseif ( BeneCastConfig.PartyNotify and UnitExists('party1') ) then
		SendChatMessage(message_text, 'PARTY');
	elseif ( BeneCastConfig.SayNotify ) then
		SendChatMessage(message_text, 'SAY');
	elseif ( BeneCastConfig.RaidNotify and UnitExists('raid1') ) then
		SendChatMessage(message_text, 'RAID');
	elseif ( BeneCastConfig.TargetNotify and target ~= 'player' and UnitIsPlayer(target) ) then
		local name = UnitName(target);
		SendChatMessage(message_text, 'WHISPER', nil, name);
	elseif ( BeneCastConfig.UserNotify ) then
		SendChatMessage(message_text, 'CHANNEL', nil, GetChannelName(BeneCastConfig.UserChannel));
	-- Thnx to Shimavak for the emote-code
	elseif ( BeneCastConfig.EmoteNotify ) then 
		SendChatMessage(BENECAST_STRINGS.NOTIFY_EMOTE_PRE .. string.sub(message_text,2), 'EMOTE');
	else
		return nil;
	end
	
	-- Message sent, return true
	return true;

end

-- Function for Party Notification on failures and interruptions
-- Modified SpeakSpell by Danboo. Thanks Danboo!
function BeneCast_PartyNotifyFail(event)

	local message_text;
	
	-- Set the message text based on what event called PartyNotifyFail
	-- SPELLCAST_CANCELED is really SPELLCAST_INTERRUPTED if the interruption was caused by the player
	-- To know if interruptions are caused by the player, SPELLCAST_STOP is called just before SPELLCAST_INTERRUPTED
	if event == 'SPELLCAST_FAILED' then
		message_text = BENECAST_STRINGS.NOTIFY_FAILED;
	elseif event == 'SPELLCAST_INTERRUPTED' then
		message_text = BENECAST_STRINGS.NOTIFY_INTERRUPTED;
	elseif event == 'SPELLCAST_CANCELED' then
		message_text = BENECAST_STRINGS.NOTIFY_CANCELED;
	end

	-- Send the message on the appropriate channel
	if ( BeneCastConfig.SelfNotify ) then
		PutMsg(message_text);
	elseif ( BeneCastConfig.PartyNotify and UnitExists('party1') ) then
		SendChatMessage(message_text, 'PARTY');
	elseif ( BeneCastConfig.SayNotify ) then
		SendChatMessage(message_text, 'SAY');
	elseif ( BeneCastConfig.RaidNotify and UnitExists('party1') ) then
		SendChatMessage(message_text, 'RAID');
	elseif ( BeneCastConfig.TargetNotify and target ~= 'player' and UnitIsPlayer(target) ) then
		local name = UnitName(target);
		SendChatMessage(message_text, 'WHISPER', nil, name);
	elseif ( BeneCastConfig.UserNotify ) then
		SendChatMessage(message_text, 'CHANNEL', nil, GetChannelName(BeneCastConfig.UserChannel));
	-- Thnx to Shimavak for the emote-code
	elseif ( BeneCastConfig.EmoteNotify ) then 
		SendChatMessage(message_text, 'EMOTE');
	end

end

-- *****************************************************************************
-- BeneCastButton functions
-- *****************************************************************************

function BeneCast_GetUnitIDFromPanelID(id)
	local target = nil;
	if ( id >= 6 and id <= 45 ) or ( id >= 51 and id <= 90 ) then
		if BENECAST_RAID_PANELS2[id] then
			target = BENECAST_RAID_PANELS2[id]['unitid'];
		end
	else
		target = BC_targets[id];
	end
	return target;
end

-- Cast a spell when a BeneCastButton is clicked on
function BeneCastButton_OnClick()

	local id = this:GetParent():GetID();
	local target;
	if id ~= 92 then
		target = BeneCast_GetUnitIDFromPanelID(id);
	else
		-- Try to find a better unitid instead of targettarget
		for i, unit in BC_targets do
			if unit ~= 'targettarget' and UnitIsUnit(unit,'targettarget') then
				target = unit;
				PutDebugMsg('Casting on ' .. unit .. ' instead of targettarget');
				do break end;
			end
		end
		if target == nil then
			target = 'targettarget';
		end
	end
	if target == nil then
		PutDebugMsg('Couldnt find the unitid for panel ' .. id);
		return;
	end
	-- In case you switch targets because you're targeting a friendly
	local retarget_friend = nil;
	
	if ( not UnitExists(target) ) then
		if target then
			PutDebugMsg(target .. ' is not an existing Unit');
		else
			PutDebugMsg('var target is nil');
		end
		return;
	end
	
	local spell;
	local spelltype = this.spelltype;
	
	if ( spelltype == 'assist' ) then
		AssistUnit(target);
		return;
	end
	
	-- Target the intended target if the current target is friendly but not the intended target
	if ( not UnitCanAttack('player', 'target') and not UnitIsUnit('target', target) and not string.find(spelltype, 'selfbuff') and UnitExists('target') ) then
		retarget_friend = true;
		if BeneCastConfig.Debug then
			local currtarget = UnitName('target');
			PutDebugMsg('Stopping targetting the friendly target named ' .. currtarget);
		end	
		--WINTROW.6 TargetUnit(target);
		ClearTarget(); --WINTROW.6
	end
	
	-- If a spell is already targeting stop targeting
	if ( SpellIsTargeting() ) then
		SpellStopTargeting();
	end
	
	-- Always take care of items on cursor with left clicks
	if ( button == 'LeftButton' and CursorHasItem() ) then
		if ( unit == 'player' ) then
			AutoEquipCursorItem();
		else
			DropItemOnUnit(target);
		end
		PutDebugMsg('Cursor had item');
		return;
	end

	local forcemax, forceoverheal;
	-- Cast Nature's Swiftness before casting the a Druid or Shaman heal if the Alt key is held down
	if ( IsAltKeyDown() and ( BC_class == BENECAST_STRINGS.CLASS_DRUID or BC_class == BENECAST_STRINGS.CLASS_SHAMAN ) and ( spelltype == 'efficient' or spelltype == 'emergency' ) and BC_spell_data['selfbuff1'] ) then
		local natureswiftness = BC_spell_data['selfbuff1']['spells'][1];
		CastSpell(natureswiftness.id, SpellBookFrame.bookType);
		SpellStopCasting();
		forcemax = true;
	end
	
	spell = BeneCast_ChooseSpell(spelltype, target, forcemax, forceoverheal);
	
	-- In case you're targeting an enemy and cast make sure that you'll cast on the intended target
	local retarget_enemy = nil;
	
	-- Try casting the spell if it exists
	if ( spell ) then
		-- Dispel Magic can be used offensively, always target the intended target
		if ( (BC_class == BENECAST_STRINGS.CLASS_PRIEST and spelltype == 'magic') or
		     (BC_class == BENECAST_STRINGS.CLASS_PALADIN and spelltype == 'instant') ) and 
		   UnitCanAttack('player', 'target') then
			retarget_enemy = true;
			if BeneCastConfig.Debug then
				local currtarget = UnitName('target');
				PutDebugMsg('Stopping targetting the enemy target named ' .. currtarget);
			end
			--WINTROW.6 TargetUnit(target);
			ClearTarget(); --WINTROW.6
		end
		-- Cast the spell
		CastSpell(spell.id, SpellBookFrame.bookType);
		BC_spellbeingcast = spell;
		BC_spelltarget = target;
		BC_spellismax = forcemax;
		SpellTargetUnit(target);
	elseif BeneCastConfig.Debug then
		local msg = 'No spell found for ';
		if spelltype then
			msg = msg .. 'spelltype=' .. spelltype;
		else
			msg = msg .. 'spelltype=nil';
		end
		if target then
			msg = msg .. ', target=' .. target;
		else
			msg = msg .. ', target=nil';
		end
		if forcemax ~= nil then
			if forcemax then
				msg = msg .. ', forcemax=true';
			else
				msg = msg .. ', forcemax=false';
			end
		else
			msg = msg .. ', forcemax=nil';
		end
		if forceoverheal ~= nil then
			if forceoverheal then
				msg = msg .. ', forceoverheal=true';
			else
				msg = msg .. ', forceoverheal=false';
			end
		else
			msg = msg .. ', forceoverheal=nil';
		end
		PutDebugMsg(msg);
	end
	
	-- Re-target the last enemy if you changed targets due to Dispel Magic/Holy Shock
	if ( retarget_enemy or retarget_friend ) then
		local currtarget = UnitName('target');
		TargetLastTarget();
		if BeneCastConfig.Debug then
			if not currtarget then
				currtarget = 'no target';
			end
			local currtarget2 = UnitName('target');
			if not currtarget2 then
				currtarget2 = 'nil';
			end
			PutDebugMsg('Switching back from ' .. currtarget .. ' to ' .. currtarget2);
		end
	end

end

-- Make a tooltip for the BeneCastButton based on the options set
function BeneCastButton_OnEnter()

	if ( this.spelltype == 'assist' ) then
		GameTooltip:SetOwner(this, 'ANCHOR_BOTTOMRIGHT');
		GameTooltip:SetText(BENECAST_STRINGS.TEXT_ASSIST);
		return;
	end
	local spell = BeneCast_ChooseSpell(this.spelltype, 'player', true, nil);
	if ( BeneCastConfig.ShowTooltips ) then
		GameTooltip:SetOwner(this, 'ANCHOR_BOTTOMRIGHT');
		GameTooltip:SetSpell(spell.id, SpellBookFrame.bookType);
	end
	if ( BeneCastConfig.ShowTooltips and BeneCastConfig.ShowTooltipsName ) then
		GameTooltip:SetOwner(this, 'ANCHOR_BOTTOMRIGHT');
		GameTooltip:SetText(spell.name);
	end

end

-- Update the cooldown for a button on events
function BeneCastButton_UpdateCooldown()

	-- If the unit for this button does not exist return
	if ( not UnitExists(BC_targets[this:GetParent():GetID()]) ) then
		this:GetParent():Hide();
		return;
	end
	
	-- No need to update for a hidden button
	if ( not this:IsVisible() ) then
		return;
	end
	
	local spell;
	-- Figure out this button's spelltype
	local spelltype = this.spelltype;
	-- Find an associated spell based on the spelltype
	spell = BeneCast_ChooseSpell(spelltype, 'player', true, nil);
	-- If there is no spell associated with the spelltype return
	if ( not spell ) then
		return;
	end
	
	-- Cooldown stuff that I'm not quite sure how exactly it all works
	local cooldown = getglobal(this:GetName()..'Cooldown');
	local iconTexture = getglobal(this:GetName()..'Icon');
	local start, duration, enable = GetSpellCooldown(spell.id, SpellBookFrame.bookType);
	CooldownFrame_SetTimer(cooldown, start, duration, enable);
	if ( enable == 1 ) then
		iconTexture:SetVertexColor(1.0, 1.0, 1.0);
	else
		iconTexture:SetVertexColor(0.4, 0.4, 0.4);
	end

end

-- Register events for BeneCastButtons
function BeneCastButton_OnLoad()

	this:RegisterEvent('SPELL_UPDATE_COOLDOWN');

end

-- *****************************************************************************
-- BeneCast Button Drawing/Updating Functions
-- *****************************************************************************

-- Function used to show a BeneCast button
-- Parameters spell_type, and the first free button available
-- 'Free' buttons are buttons that are not being used
-- Returns true if a button was created
function BeneCast_ShowButton(type, freebutton, id, member) --WINTROW.6 'member' is a parameter now

	local made_button = nil;
	-- Figure out who this button belongs too
	--WINTROW.6 local member = BC_targets[id]; --Is parameter now
	local class = UnitClass(member);
	if not class then
		class = BENECAST_STRINGS.CLASS_WARRIOR;
	end
	local classnum = BC_classes[class];
	
	--Only if a hunter/warlock is targetting his pet show the petheal
	if ( BC_class == BENECAST_STRINGS.CLASS_WARLOCK or BC_class == BENECAST_STRINGS.CLASS_HUNTER ) then
		if ( ( member ~= 'player' and not ( member == 'target' and UnitIsUnit('pet','target') ) ) and type == 'efficient' ) then
			return nil;
		end
	end
	
	-- If the player has the spell, wants it shown, and freebutton is <= BeneCastConfig.ButtonNumber then continue
	if ( BC_spell_data[type] and 
	     ( ( member ~= 'player' and BeneCastConfig[classnum][type] ) or
	       ( member == 'player' and BeneCastConfig[1][type] ) ) and 
	     freebutton <= BeneCastConfig.ButtonNumber
	   ) then
		local button = getglobal('BeneCastPanel' .. id .. 'Button' .. freebutton);
		-- Set made_button to true
		made_button = true;
		-- Set up the texture for the button
		local icon = getglobal('BeneCastPanel' .. id .. 'Button' .. freebutton .. 'Icon');
		icon:SetTexture(BC_spell_data[type].texture);
		button.spelltype = type;
		button:Show();
		button:SetAlpha(1); --reset alpha
		if not BC_buttons_by_spell[member] then
			BC_buttons_by_spell[member] = {};
		end
		BC_buttons_by_spell[member][type] = button:GetName();
	end

	return made_button;
	
end

-- Function to hide temporary buttons if they're not to be shown
function BeneCast_HideButton(buttonnum, id, member)

	local fadeicon = getglobal('BeneCastPanel' .. id .. 'Button' .. buttonnum .. 'Fade');
	if ( fadeicon:IsShown() ) then
		fadeicon:Hide();
	end
	local rangeicon = getglobal('BeneCastPanel' .. id .. 'Button' .. buttonnum .. 'Range');
	if ( rangeicon:IsShown() ) then
		rangeicon:Hide();
	end
	local button = getglobal('BeneCastPanel' .. id .. 'Button' .. buttonnum);
	if ( button:IsShown() ) then
		button:Hide();
	end
	if button.spelltype then
		if BC_buttons_by_spell[member] then
			BC_buttons_by_spell[member][button.spelltype] = nil;
		end
	end

end

--WINTROW.6 START
-- Function used to update buttons for a unitid
function BeneCast_UpdateButtonsForUnit(unitid)
	local panelids;
	panelids = BeneCast_UnitID(unitid);
	if panelids then
		if type(panelids) == 'table' then
			for i, id in panelids do
				BeneCast_UpdateButtons(id);
			end
		else
			BeneCast_UpdateButtons(panelids);
		end
	end
end
--WINTROW.6 STOP

-- Function used to update buttons for all possible targets
function BeneCast_UpdateButtons(id)

	-- Sometimes the id is nil
	if not id then
		PutDebugMsg('BeneCast_UpdateButtons(): parameter id is nil');
		return;
	end
	
	if ( id == 92 and not BeneCastConfig.ShowTargetTarget ) then
		getglobal('BeneCastPanel' .. id):Hide();
		return;
	end
	
	if getglobal('BeneCastPanel' .. id) == nil then
		PutDebugMsg('Panel BeneCastPanel' .. id .. ' not found');
		return;
	end
	
	-- Figure out who this frame belongs too
	local member = BeneCast_GetUnitIDFromPanelID(id);
	if member == nil then
		getglobal('BeneCastPanel' .. id):Hide();
		--PutDebugMsg('id ' .. id .. ' not found in targets/raid-table');
		return;
	end
		
	-- If the player is dead then hide this panel and return
	if ( UnitIsDeadOrGhost('player') ) then
		getglobal('BeneCastPanel' .. id):Hide();
		return;
	end

	-- Hide this BeneCastPanel frame and return if this member is not valid
	if ( not UnitExists(member) or UnitIsGhost(member) or not UnitIsConnected(member) ) then
		getglobal('BeneCastPanel' .. id):Hide();
		return;
	end

	-- Hide this BeneCastPanel frame if member is not friendly/mindcontrolled
	if UnitIsCharmed(member) then
		-- Show dispell if it's a mindcontrolled unit
		if ( BC_spell_data['magic'] ) then
			if ( BeneCast_ShowButton('magic', 1, id, member) ) then
				getglobal('BeneCastPanel' .. id):Show();
				-- Resize the BeneCastPanelFrame since there's only 1 button
				local frame = getglobal('BeneCastPanel' .. id);
				local buttonsize = BeneCastConfig.ButtonSize;
				frame:SetWidth(buttonsize * (1) + 11);
				frame:SetHeight(buttonsize + 11);
				-- Hide the rest of the buttons in the panel
				for x = 2, BENECAST_MAX_NUMBER_OF_BUTTONS do
					BeneCast_HideButton(x, id, member);
				end
			else
				getglobal('BeneCastPanel' .. id):Hide();
			end
		else
			getglobal('BeneCastPanel' .. id):Hide();
		end
		return;
	end
	
	-- Hide this BeneCastPanel frame if member is not friendly
	if ( not UnitIsFriend('player', member) ) then
		getglobal('BeneCastPanel' .. id):Hide();
		return;
	end
	
	-- Hide this BeneCastPanel frame and return if this member is a raidid that is not being shown
	local raidenabled = nil;
	if UnitExists(member) then
		local name = UnitName(member);
		raidenabled = BENECAST_RAID_LIST[name];
	end
	if ( BeneCast_UnitIsRaidID(member) and ( not raidenabled or not BeneCastConfig.ShowRaid ) ) then
		getglobal('BeneCastPanel' .. id):Hide();
		return;
	end
	
	-- Hide this BeneCastPanel frame and return if this member is a pet and ShowPets is not enabled
	-- Except if the player is directly targetting the pet
	if member ~= 'target' then
		if ( ( BeneCast_UnitIsPetID(member) or BeneCast_UnitIsPartyPet(member) ) and not BeneCastConfig.ShowPets ) then
			getglobal('BeneCastPanel' .. id):Hide();
			return;
		end
	end
	
	-- If the player can ressurect this member then show the res button and return
	if ( ( UnitIsDead(member) or UnitIsGhost(member) ) and not UnitBuff(member, 1) ) then
		if ( BC_spell_data['res'] ) then
			if ( BeneCast_ShowButton('res', 1, id, member) ) then
				getglobal('BeneCastPanel' .. id):Show();
				-- Resize the BeneCastPanelFrame since there's only 1 button
				local frame = getglobal('BeneCastPanel' .. id);
				local buttonsize = BeneCastConfig.ButtonSize;
				frame:SetWidth(buttonsize * (1) + 11);
				frame:SetHeight(buttonsize + 11);
				-- Hide the rest of the buttons in the panel
				for x = 2, BENECAST_MAX_NUMBER_OF_BUTTONS do
					BeneCast_HideButton(x, id, member);
				end
			else
				getglobal('BeneCastPanel' .. id):Hide();
			end
		else
			getglobal('BeneCastPanel' .. id):Hide();
		end
		return;
	end
	
	local activeshapeshiftid = 0;
	-- If player is a Druid and is shapeshifted hide all buttons
	if ( BC_class == BENECAST_STRINGS.CLASS_DRUID ) then
		-- Check all shapeshift forms to see if they're active
		local shapeshiftnum = GetNumShapeshiftForms();
		local icon, name, active;
		local is_shapeshifted = nil;
		for i = 1,shapeshiftnum do
			icon, name, active = GetShapeshiftFormInfo(i);
			if ( active ) then
				is_shapeshifted = true;
				activeshapeshiftid = i; --WINTROW.2
				do break end
			end
		end
	end
	
	-- Otherwise show the buttons. Show the BeneCastPanel frame first
	getglobal('BeneCastPanel' .. id):Show();
	
	-- firstfreebutton determines the first button that is not used
	local firstfreebutton = 1;
	
	-- Hide all buttons before redrawing them
	for x = firstfreebutton, BENECAST_MAX_NUMBER_OF_BUTTONS do
		BeneCast_HideButton(x, id, member);
	end
	
	-- If there is no class, set it to warrior
	local class = UnitClass(member);
	if not class then
		class = BENECAST_STRINGS.CLASS_WARRIOR;
	end
	
	-- Show the assist button if it is wanted
	if ( BeneCastConfig[BC_classes[class]]['assist'] and firstfreebutton <= BeneCastConfig.ButtonNumber and not UnitIsUnit(member,'player') and UnitIsPlayer(member) ) then
		local button = getglobal('BeneCastPanel' .. id .. 'Button' .. firstfreebutton);
		-- Set up the texture for the button
		local icon = getglobal('BeneCastPanel' .. id .. 'Button' .. firstfreebutton .. 'Icon');
		icon:SetTexture('Interface\\Icons\\Ability_Marksmanship');
		button.spelltype = 'assist';
		button:Show();
		if not BC_buttons_by_spell[member] then
			BC_buttons_by_spell[member] = {};
		end
		BC_buttons_by_spell[member]['assist'] = button:GetName();
		local buttonfade = getglobal('BeneCastPanel' .. id .. 'Button' .. firstfreebutton .. 'Fade');
		buttonfade:Hide();
		firstfreebutton = firstfreebutton +1;
	end
	
	-- Show Heal buttons as persistant buttons
	if activeshapeshiftid == 0 then --WINTROW.2
		if ( BeneCast_ShowButton('efficient', firstfreebutton, id, member) ) then
			firstfreebutton = firstfreebutton +1;
		end
		if ( BeneCast_ShowButton('efficient2', firstfreebutton, id, member) ) then
			firstfreebutton = firstfreebutton +1;
		end
		if ( BeneCast_ShowButton('efficient3', firstfreebutton, id, member) ) then
			firstfreebutton = firstfreebutton +1;
		end
		if BeneCast_ShowButton('emergency', firstfreebutton, id, member) then
			firstfreebutton = firstfreebutton +1;
		end
		if ( BeneCast_ShowButton('instant', firstfreebutton, id, member) ) then
			firstfreebutton = firstfreebutton +1;
		end
	end
	-- Paladin's Lay on Hands spell
	if ( BeneCast_ShowButton('loh', firstfreebutton, id, member) ) then
		firstfreebutton = firstfreebutton +1;
	end

	-- Group heals are handled differently than other heals
	-- Only on the Shaman Group heal does targeting matter
	-- Show up only on player unless class is Shaman
	if activeshapeshiftid == 0 then
		if ( BC_class == BENECAST_STRINGS.CLASS_SHAMAN or member == 'player' ) then
			if ( BeneCast_ShowButton('group', firstfreebutton, id, member) ) then
				firstfreebutton = firstfreebutton + 1;
			end
		end
		if ( BeneCast_ShowButton('group2', firstfreebutton, id, member) ) then
			firstfreebutton = firstfreebutton + 1;
		end
	end
	
	-- Check to see if the member can be cured of a harmful effect
	-- Do this before showing buffs so Weakened Soul is detected before drawing buffs
	-- Iterator for debuffs
	local i = 1;
	
	-- Variables to determine if cures should be shown
	-- This is done in case there are multiples of one kind of effect
	local poisonshow = nil;
	local diseaseshow = nil;
	local magicshow = nil;
	local curseshow = nil;
	
	local weakenedsoul = nil;
	BC_spirit_of_redemption = nil;
	
	-- Cycle through the Units Debuffs to find removable effects
	while ( UnitDebuff(member, i) ) do

		-- Set BeneCast_Tooltip to the debuff at iterator i, be sure to clear the relevant text first
		BeneCast_TooltipTextRight1:SetText('');
		BeneCast_TooltipTextLeft1:SetText('');
		BeneCast_Tooltip:SetUnitDebuff(member, i);
		-- Check to see if this debuff is Weakened Soul and save it for when you get to the buffs
		if ( BeneCast_TooltipTextLeft1:GetText() == BENECAST_STRINGS.AILMENT_WEAKENED_SOUL ) then
			weakenedsoul = true;
		end
		--WINTROW.6 START
		if ( BeneCast_TooltipTextLeft1:GetText() == BENECAST_STRINGS.AILMENT_SPIRIT_OF_REDEMPTION ) then
			BC_spirit_of_redemption = true;
		end
		--WINTROW.6 STOP
		-- If the Tooltip has text on the Right1 it may be removable
		if ( BeneCast_TooltipTextRight1:GetText() ) then
			local effect = BeneCast_TooltipTextRight1:GetText();
			if effect == BENECAST_STRINGS.AILMENT_POISON then
				poisonshow = true;
			elseif ( effect == BENECAST_STRINGS.AILMENT_DISEASE ) then
				-- Paladins can cure diseases but don't have a spell with the 'disease' spelltype
				-- The Paladin spell that cures poisons also cures diseases
				if ( BC_class == BENECAST_STRINGS.CLASS_PALADIN ) then
					poisonshow = true;
				else
					diseaseshow = true;
				end
			elseif ( effect == BENECAST_STRINGS.AILMENT_MAGIC ) then
				-- Paladins can cure magic with Cleanse which is of the 'poison' spelltype
				-- If the Paladin has Cleanse have it show Cleanse
				--WINTROW.6 START
				--if ( BC_class == BENECAST_STRINGS.CLASS_PALADIN and BC_spell_data['poison']['spells'][2] ) then
				if ( BC_class == BENECAST_STRINGS.CLASS_PALADIN and BC_spell_data['poison'] ) then
					if BC_spell_data['poison']['spells'][2] then
				--WINTROW.6 STOP
						poisonshow = true;
					--WINTROW.6 START
					else
						magicshow = true;
					end
					--WINTROW.6 STOP
				else
					magicshow = true;
				end
			elseif ( effect == BENECAST_STRINGS.AILMENT_CURSE ) then
				curseshow = true;
			end
		end
		i = i + 1;
	end
	
	-- Show Buff buttons as temporary buttons
	
	-- See if the groupbuff is on the intended target
	local groupbuffsshown = {};
	local groupblessingsshown = {};
	
	-- See if a mage's ward is on the player
	local wardshown = nil;
	
	-- See if a paladin's greater blessing is on the target
	-- Thanks to Hiroko of Argent Dawn(EU)
	local gmightshown = nil;
	local gwisdomshown = nil;
	local gkingsshown = nil;
	local gsalvshown = nil;
	local glightshown = nil;
	local gsanctshown = nil;
		
	-- Check to see if this member does not have castable buffs
	
	-- Reset the iterator for buffs
	i = 1;
	
	-- Clear all entries in BC_buffs_in_effect
	for j in BC_buffs_in_effect do
		BC_buffs_in_effect[j].fade = false;
		BC_buffs_in_effect[j].ineffect = false;
	end
	
	if UnitIsUnit(member,'player') then
		-- Set clearcasting state to nil
		BC_clearcasting = nil;
		local old_innerfocus = BC_innerfocus; --WINTROW.6
		BC_innerfocus = nil; --WINTROW.6
	end
	
	-- Cycle through the Units Buffs to find if the effect is on the unit
	while ( UnitBuff(member, i) ) do
				
		-- Set BeneCast_Tooltip to the buff at iterator i, be sure to clear the relevant text first
		BeneCast_TooltipTextLeft1:SetText('');
		BeneCast_Tooltip:SetUnitBuff(member, i);
		-- If the Tooltip has text on the Left1 it may be a buff player can cast
		if ( BeneCast_TooltipTextLeft1:GetText() ) then
			-- Make a local for the text (Thnx Shimavak)
			local lefttext = BeneCast_TooltipTextLeft1:GetText();
			-- Only check these buffs if we're checking out the player ! (Thnx Shimavak)
			if UnitIsUnit(member,'player') then
				-- If the buff is Clearcasting then set clearcasting state to true 
				if ( lefttext == BENECAST_STRINGS.BUFF_CLEARCASTING ) then
					BC_clearcasting = true;
				end
				if ( lefttext == BENECAST_STRINGS.SELFBUFF_INNER_FOCUS ) then
					BC_innerfocus = true;
				end
				if ( lefttext == BENECAST_STRINGS.AILMENT_SPIRIT_OF_REDEMPTION ) then
					BC_spirit_of_redemption = true;
				end
			-- Now, if the buff is one of the uninteractable ones, we'll turn off the whole set of buttons				
			elseif ( lefttext == BENECAST_STRINGS.BUFF_PHASE_SHIFT or lefttext == BENECAST_STRINGS.PARTYBUFF_DIVINE_INTERVENTION ) then
				getglobal('BeneCastPanel' .. id):Hide();
				return;
			end
			
			local effect = BeneCast_SpellTypes[BC_class][lefttext];
			-- If the effect is a groupbuff set showgroupbuff to true
			if ( effect ) then
				if ( ( BC_class == BENECAST_STRINGS.CLASS_PRIEST or 
				       BC_class == BENECAST_STRINGS.CLASS_DRUID or 
				       BC_class == BENECAST_STRINGS.CLASS_MAGE ) and string.find(effect,'groupbuff(.+)') ) then
				        local tmp;
				        _, _, tmp = string.find(effect,'groupbuff(.+)');
					table.insert(groupbuffsshown,tmp);
				elseif ( BC_class == BENECAST_STRINGS.CLASS_PALADIN and string.find(effect,'buffparty(.+)g') ) then
					local tmp;
					_, _, tmp = string.find(effect,'buffparty(.+)g');
					table.insert(groupblessingsshown,tmp);
				-- If the effect is a mage ward set wardshown to true
				elseif ( BC_class == BENECAST_STRINGS.CLASS_MAGE and ( effect == 'selfbuff12' or effect == 'selfbuff13' ) ) then
					wardshown = true;
				end 
			end 
			
			--[[
			-- If the effect is a paladin greater blessing
			if ( BC_class == BENECAST_STRINGS.CLASS_PALADIN ) then
				if (effect == 'buffparty1g') then
					gmightshown = true;
				elseif (effect == 'buffparty5g') then
					gwisdomshown = true;
				elseif (effect == 'buffparty6g') then
					gkingsshown = true;
				elseif (effect == 'buffparty8g') then
					gsalvshown = true;
				elseif (effect == 'buffparty3g') then
					glightshown = true;
				elseif (effect == 'buffparty4g') then
					gsanctshown = true;
				end
			end
			]]
			
			if ( effect ~= nil ) then
				--if BeneCastConfig.Debug and effect == 'instant' then
				--	PutDebugMsg('"instant" detected');
				--end
				if ( BC_buffs_in_effect_by_name[effect] ) then
					local j = BC_buffs_in_effect_by_name[effect];
					-- Set ineffect or fade for the BC_buffs_in_effect entry to true depending on ShowAllBuffs
					if ( BeneCastConfig.ShowAllBuffs ) then
						-- Set fade for the type to true
						BC_buffs_in_effect[j].fade = true;
					else
						-- Set ineffect for the type to true
						BC_buffs_in_effect[j].ineffect = true;
					end
				else
					PutDebugMsg('Buff ' .. effect .. ' not found in BC_buffs_in_effect_by_name-table');
				end
			end
		end
		i = i + 1;
		
	end
	
	--WINTROW.6 START
	if BeneCastConfig.Debug then
		if BC_innerfocus and not old_innerfocus then
			PutDebugMsg('Detected Inner Focus');
		end
	end
	--WINTROW.6 STOP
	
	-- A little optimisation, thnx Shimavak
	local buff_attrib;
	if ( BeneCastConfig.ShowAllBuffs ) then
		buff_attrib = 'fade';
	else
		buff_attrib = 'ineffect';
	end
	
	-- Make _buff_shown for PW:F, AI, or MotW on the intended target true if they have the groupbuff on them
	-- Set fade to true if ShowAllBuffs, else set shown to true
	if ( ( BC_class == BENECAST_STRINGS.CLASS_PRIEST or 
	       BC_class == BENECAST_STRINGS.CLASS_DRUID or 
	       BC_class == BENECAST_STRINGS.CLASS_MAGE ) and table.getn(groupbuffsshown) > 0 ) then 
		for k, buffno in groupbuffsshown do
			local effect = 'buff' .. buffno;
			local j = nil;
			if ( BC_buffs_in_effect_by_name[effect] ) then
				j = BC_buffs_in_effect_by_name[effect];
			end
			if j ~= nil then
				BC_buffs_in_effect[j][buff_attrib] = true;
			end
		end  
	elseif ( BC_class == BENECAST_STRINGS.CLASS_PALADIN and table.getn(groupblessingsshown) > 0 ) then
		for k, blessingno in groupblessingsshown do 
			local effect = 'buff' .. blessingno;
			local j = nil;
			if ( BC_buffs_in_effect_by_name[effect] ) then
				j = BC_buffs_in_effect_by_name[effect];
			else
				effect = 'partybuff' .. blessingno;
				if ( BC_buffs_in_effect_by_name[effect] ) then
					j = BC_buffs_in_effect_by_name[effect];
				end
			end
			if j ~= nil then
				BC_buffs_in_effect[j][buff_attrib] = true;
			end
		end  
	elseif ( BC_class == BENECAST_STRINGS.CLASS_MAGE and wardshown ) then
		if ( BC_buffs_in_effect_by_name['selfbuff12'] ) then
			local j = BC_buffs_in_effect_by_name['selfbuff12'];
			BC_buffs_in_effect[j][buff_attrib] = true;
		end
		if ( BC_buffs_in_effect_by_name['selfbuff13'] ) then
			local j = BC_buffs_in_effect_by_name['selfbuff13'];
			BC_buffs_in_effect[j][buff_attrib] = true;
		end
	end
	
	--Show Swiftmend if applicable
	if ( BC_class == BENECAST_STRINGS.CLASS_DRUID and activeshapeshiftid == 0 ) then
		if BC_buffs_in_effect[46][buff_attrib] or BC_buffs_in_effect[47][buff_attrib] then
			if BeneCast_ShowButton('instant2', firstfreebutton, id, member) then
				firstfreebutton = firstfreebutton +1;
			end
		end
	end
	
	-- Show buff buttons of buffs not in effect if possible
	for j in BC_buffs_in_effect do
		-- Some buttons should not show on others
		-- Selfbuffs on others and buffparty on those outside of the party/raid
		-- Groupbuffs such as Prayer of Fortitude should only be shown on the target/player
		if not BC_buffs_in_effect[j].notabuff then
			if ( string.find(BC_buffs_in_effect[j].name, 'groupbuff') and
			     not ( member == 'target' or member == 'player' ) ) then
				-- Do nothing
			elseif ( string.find(BC_buffs_in_effect[j].name, 'self') and member ~= 'player' ) then
				-- Do nothing
			elseif ( string.find(BC_buffs_in_effect[j].name, 'party') and
			          not ( UnitIsUnit(member,'player') or UnitInParty(member) or 
				        BeneCast_UnitInRaid(member) or BeneCast_UnitIsPartyPet(member) or 
					BeneCast_UnitIsRaidPet(member) ) ) then
				-- Do nothing
			else
	 			local balancebuff = false;
				if BC_class == BENECAST_STRINGS.CLASS_DRUID then
					if ( BC_buffs_in_effect[j].name == 'selfbuff2' ) then
						balancebuff = true;
					end
					if ( BC_buffs_in_effect[j].name == 'selfbuff3' ) then
						balancebuff = true;
					end
					if ( BC_buffs_in_effect[j].name == 'selfbuff4' ) then
						balancebuff = true;
					end
					if ( BC_buffs_in_effect[j].name == 'buff2' ) then
						balancebuff = true;
					end
				end
				if ( activeshapeshiftid == 0 ) or ( ( activeshapeshiftid == 5 ) and balancebuff ) then --WINTROW.2 & 4
					-- If the buff isn't present then show the button for that buff
					if ( not BC_buffs_in_effect[j].ineffect ) then
						if ( BeneCast_ShowButton(BC_buffs_in_effect[j].name, firstfreebutton, id, member) ) then
							-- Make this button hide if it is for PW:S and the effect Weakened Soul is on the target
							if ( BC_class == BENECAST_STRINGS.CLASS_PRIEST and BC_buffs_in_effect[j].name == 'partybuff1' and weakenedsoul and not BeneCastConfig.ShowAllBuffs ) then
								getglobal('BeneCastPanel' .. id .. 'Button' .. firstfreebutton):Hide()
								firstfreebutton = firstfreebutton - 1;
							end
							-- Make the button shaded gray if the effect is on the intended target
							if ( BC_buffs_in_effect[j].fade ) then
								getglobal('BeneCastPanel' .. id .. 'Button' .. firstfreebutton .. 'Fade'):Show();
							else
								getglobal('BeneCastPanel' .. id .. 'Button' .. firstfreebutton .. 'Fade'):Hide();
							end
							firstfreebutton = firstfreebutton + 1;
						end
					end
				end 
			end
		else
			--if BC_buffs_in_effect[j].name == 'instant' then
			--	PutDebugMsg('Skipping "instant" as a buff-button');
			--end
		end
	end
	
	-- Show Weapon Enchants for Shaman and Priests
	if ( member == 'player') then
		if ( BC_class == BENECAST_STRINGS.CLASS_SHAMAN ) then
			if ( BC_weaponenchant ~= BENECAST_STRINGS.WEAPONENCHANT_ROCKBITER ) then 
				if ( BeneCast_ShowButton('weaponenchant1', firstfreebutton, id, member) ) then
					firstfreebutton = firstfreebutton+1;
				end
			end
			if ( BC_weaponenchant ~= BENECAST_STRINGS.WEAPONENCHANT_FLAMETONGUE ) then
				if ( BeneCast_ShowButton('weaponenchant2', firstfreebutton, id, member) ) then
					firstfreebutton = firstfreebutton+1;
				end
			end
			if ( BC_weaponenchant ~= BENECAST_STRINGS.WEAPONENCHANT_FROSTBRAND ) then
				if ( BeneCast_ShowButton('weaponenchant3', firstfreebutton, id, member) ) then
					firstfreebutton = firstfreebutton+1;
				end
			end
			if ( BC_weaponenchant ~= BENECAST_STRINGS.WEAPONENCHANT_WINDFURY ) then
				if ( BeneCast_ShowButton('weaponenchant4', firstfreebutton, id, member) ) then
					firstfreebutton = firstfreebutton+1;
				end
			end
		end
		if ( BC_class == BENECAST_STRINGS.CLASS_PRIEST ) then
			if ( BC_weaponenchant ~= BENECAST_STRINGS.WEAPONENCHANT_FEEDBACK ) then
				if ( BeneCast_ShowButton('weaponenchant1', firstfreebutton, id, member) ) then
					firstfreebutton = firstfreebutton+1;
				end
			end
		end
	end
	
	-- Show Cure buttons as temporary buttons
	
	if ( BC_buffs_in_effect[48].ineffect ) then
		poisonshow = true; --for flashing
	end
		
	-- Show buttons for effects that are removable once
	if ( poisonshow ) then
		if ( BeneCast_ShowButton('poison', firstfreebutton, id, member) ) then
			if activeshapeshiftid ~= 0 then
				getglobal('BeneCastPanel' .. id .. 'Button' .. firstfreebutton .. 'Fade'):Show();
			else
				getglobal('BeneCastPanel' .. id .. 'Button' .. firstfreebutton .. 'Fade'):Hide();
			end
			firstfreebutton = firstfreebutton+1;
		end
	end
	if ( diseaseshow ) then
		if ( BeneCast_ShowButton('disease', firstfreebutton, id, member) ) then
			firstfreebutton = firstfreebutton+1;
		end
	end
	--WINTROW.6 START
	--Priest's Abolish Disease is different manacost -> different button
	if ( diseaseshow ) then
		if ( BeneCast_ShowButton('disease2', firstfreebutton, id, member) ) then
			firstfreebutton = firstfreebutton+1;
		end
	end
	--WINTROW.6 STOP
	if ( magicshow ) then
		if ( BeneCast_ShowButton('magic', firstfreebutton, id, member) ) then
			firstfreebutton = firstfreebutton+1;
		end
	end
	if ( curseshow ) then
		if ( BeneCast_ShowButton('curse', firstfreebutton, id, member) ) then
			if activeshapeshiftid ~= 0 then
				getglobal('BeneCastPanel' .. id .. 'Button' .. firstfreebutton .. 'Fade'):Show();
			else
				getglobal('BeneCastPanel' .. id .. 'Button' .. firstfreebutton .. 'Fade'):Hide();
			end
			firstfreebutton = firstfreebutton+1;
		end
	end
	
	--WINTROW.6 START
	--Check for flashing
	local iterator = 1; -- First clean out the flash-buttons of this panel, ready to be re-added if still active
	while iterator <= table.getn(BC_buttons_that_flash) do
		if string.find(BC_buttons_that_flash[iterator],'BeneCastPanel' .. id .. 'Button') then
			table.remove(BC_buttons_that_flash,iterator);
		else
			iterator = iterator + 1;
		end
	end
	if BC_buttons_by_spell[member] then
		if ( BC_class == BENECAST_STRINGS.CLASS_PRIEST ) then
			if BC_buffs_in_effect[46].ineffect or BC_buffs_in_effect[46].fade then
				PutDebugMsg('"instant" is in effect');
				if BC_buttons_by_spell[member]['instant'] then
					if BeneCastConfig.FlashAsFade then
						getglobal(BC_buttons_by_spell[member]['instant'] .. 'Fade'):Show();
					else
						table.insert(BC_buttons_that_flash,BC_buttons_by_spell[member]['instant']);
					end
				else
					PutDebugMsg('BC_buttons_by_spell[' .. member .. '][instant] is nil');
				end
			end
		end
		if ( BC_class == BENECAST_STRINGS.CLASS_DRUID ) then
			if BC_buffs_in_effect[46].ineffect or BC_buffs_in_effect[46].fade then
				PutDebugMsg('"instant" is in effect');				
				if BC_buttons_by_spell[member]['instant'] then
					if BeneCastConfig.FlashAsFade then
						getglobal(BC_buttons_by_spell[member]['instant'] .. 'Fade'):Show();
					else
						table.insert(BC_buttons_that_flash,BC_buttons_by_spell[member]['instant']);
					end
				else
					PutDebugMsg('BC_buttons_by_spell[' .. member .. '][instant] is nil');
				end
			end
			if BC_buffs_in_effect[47].ineffect or BC_buffs_in_effect[47].fade then
				PutDebugMsg('"emergency" is in effect');
				if BC_buttons_by_spell[member]['emergency'] then
					if BeneCastConfig.FlashAsFade then
						getglobal(BC_buttons_by_spell[member]['emergency'] .. 'Fade'):Show();
					else
						table.insert(BC_buttons_that_flash,BC_buttons_by_spell[member]['emergency']);
					end
				else
					PutDebugMsg('BC_buttons_by_spell[' .. member .. '][emergency] is nil');
				end
			end
			if BC_buffs_in_effect[48].ineffect or BC_buffs_in_effect[48].fade then
				PutDebugMsg('"poison" is in effect');
				if BC_buttons_by_spell[member]['poison'] then
					if BeneCastConfig.FlashAsFade then
						getglobal(BC_buttons_by_spell[member]['poison'] .. 'Fade'):Show();
					else
						table.insert(BC_buttons_that_flash,BC_buttons_by_spell[member]['poison']);
					end
				else
					PutDebugMsg('BC_buttons_by_spell[' .. member .. '][poison] is nil');
				end
			end
		end
		if ( BC_class == BENECAST_STRINGS.CLASS_SHAMAN ) then
			if BC_buffs_in_effect[48].ineffect or BC_buffs_in_effect[48].fade then
				PutDebugMsg('"poison" is in effect');
				if BC_buttons_by_spell[member]['poison'] then
					if BeneCastConfig.FlashAsFade then
						getglobal(BC_buttons_by_spell[member]['poison'] .. 'Fade'):Show();
					else
						table.insert(BC_buttons_that_flash,BC_buttons_by_spell[member]['poison']);
					end
				else
					PutDebugMsg('BC_buttons_by_spell[' .. member .. '][poison] is nil');
				end
			end
		end
	end
	--WINTROW.6 STOP

	-- Hide all buttons that shouldn't be shown
	for x = firstfreebutton, BeneCastConfig.ButtonNumber do
		BeneCast_HideButton(x, id, member);
	end
	
	-- If there are no buttons to be shown, hide the frame
	if ( firstfreebutton == 1 ) then
		getglobal('BeneCastPanel' .. id):Hide();
	end
	
	-- Resize the BeneCastPanelFrame based on the number of buttons
	BeneCast_ResizeButtonsFor(id);
	--[[
	local frame = getglobal('BeneCastPanel' .. id);
	local buttonsize = BeneCastConfig.ButtonSize;
	frame:SetWidth(buttonsize * (firstfreebutton - 1) + 11 + (3 * (firstfreebutton - 2)));
	frame:SetHeight(buttonsize + 11);
	]]
		
end


-- *****************************************************************************
-- BeneCastPanelMenu functions
-- *****************************************************************************

function BeneCastPanelDropDown_Initialize()
	
	local info;
	-- Add Title Button
	info = {};
	if ( UnitExists(BC_targets[this:GetID()]) ) then
		info.text = UnitName(BC_targets[this:GetID()]);
	else
		info.text = BENECAST_STRINGS.TEXT_UNKNOWN
	end
	info.isTitle = 1;
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	
	-- Add Lock Button
	info = {};
	info.text = BENECAST_STRINGS.TEXT_LOCKED;
	info.value = this:GetID();
	info.checked = this.locked;
	info.func = BeneCastPanel_SetLock;
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	
	-- Add Orientation Button
	info = {};
	info.text = 'Change Orientation';
	info.value = this:GetID() .. 'orient';
	info.func = BeneCastPanel_SetOrientation;
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

end

function BeneCastPanel_SetLock() 

	local frame = getglobal('BeneCastPanel' .. this.value);
	frame.locked = not frame.locked;
	
end

function BeneCastPanel_SetOrientation()

	local id = nil;
	_, _, id = string.find(this.value,'(.+)orient');
	PutDebugMsg('BeneCast_SetOrientation() called');
	if not BeneCastConfig['BeneCastPanel' .. id] then
		BeneCastConfig['BeneCastPanel' .. id] = {};
	end
	if BeneCastConfig['BeneCastPanel' .. id]['Orientation'] == 'down' then
		BeneCastConfig['BeneCastPanel' .. id]['Orientation'] = 'right';
	else
		BeneCastConfig['BeneCastPanel' .. id]['Orientation'] = 'down';
	end
	PutDebugMsg("New value BeneCastConfig['BeneCastPanel' .. id]['Orientation'] = " ..
	            BeneCastConfig['BeneCastPanel' .. id]['Orientation']);
	BeneCast_OrientButtons(id);

end

function BeneCastPanelMenu_OnLoad()

	UIDropDownMenu_Initialize(this, BeneCastPanelDropDown_Initialize, 'MENU');

end

-- *****************************************************************************
-- BeneCastPanel functions
-- *****************************************************************************

function BeneCastPanel_OnLoad()

	-- set our default colors
	this:SetBackdropBorderColor(TOOLTIP_DEFAULT_COLOR.r, TOOLTIP_DEFAULT_COLOR.g, TOOLTIP_DEFAULT_COLOR.b);
	this:SetBackdropColor(TOOLTIP_DEFAULT_BACKGROUND_COLOR.r, TOOLTIP_DEFAULT_BACKGROUND_COLOR.g, TOOLTIP_DEFAULT_BACKGROUND_COLOR.b);
	this.locked = 1;

end

function BeneCastPanel_OnMouseDown()

	if ( ( ( not this.locked ) or ( this.locked == 0 ) or BeneCastConfig.Unlock ) and ( arg1 == 'LeftButton' ) ) then
		this:StartMoving();
		this.isMoving = true;
	end
	
end

--WINTROW.6 START
--Moved this from the XML-code so I can add code to save the panel's locations
function BeneCastPanel_OnMouseUp()

	if ( this.isMoving ) then
		this:StopMovingOrSizing();
		this.isMoving = false;
		local framename = 'BeneCastPanel' .. this:GetID();
		if not BeneCastConfig[framename] then
			BeneCastConfig[framename] = {
				['Y'] = 0,
				['X'] = 0,
				['Point'] = 'TOPLEFT',
				['RelativePoint'] = 'TOPLEFT',
				['Frame'] = '',
				['Moved'] = true,
			};
		else
			BeneCastConfig[framename]['Point'] = 'TOPLEFT';
			BeneCastConfig[framename]['RelativePoint'] = 'TOPLEFT';
		end
		local parent = this:GetParent();
		BeneCastConfig[framename]['Frame'] = parent:GetName();
		-- The values stored are unscaled values (real pixels)
		-- When being applied they will need to be adjusted to the scale between the frame and his parent
		BeneCastConfig[framename]['X'] = ( this:GetLeft() * this:GetEffectiveScale() ) - 
						 ( parent:GetLeft() * parent:GetEffectiveScale() ) + 0.5;
		BeneCastConfig[framename]['X'] = math.floor(BeneCastConfig[framename]['X']);
		BeneCastConfig[framename]['Y'] = ( this:GetTop() * this:GetEffectiveScale() ) -
						 ( parent:GetTop() * parent:GetEffectiveScale() ) + 0.5;
		BeneCastConfig[framename]['Y'] = math.floor(BeneCastConfig[framename]['Y']);
		BeneCastConfig.SnapTo = 'CUSTOM';
		BeneCastConfig[framename]['Moved'] = true;
		UIDropDownMenu_SetSelectedValue(BeneCastSnapToMenu, BeneCastConfig.SnapTo);
		-- Make sure BeneCast does all the moving around here... Thanks Snidely!
		if this:IsUserPlaced() then
			this:SetUserPlaced(false);
		end
		BeneCast_AttachPanelsFromVar(this:GetID());
		BeneCastUpdateCustomEditBoxes();
	end
	
end

function BeneCastPanel_OnEnter()
	if BeneCastConfig.Debug then
		local id, unitname, target, framename;
		id = this:GetID();
		framename = this:GetName();
		if not id then
			local idstr;
			_, _, idstr = string.find(framename,'BeneCastPanel(.+)');
			id = tonumber(idstr);
		end
		if id then
			target = BeneCast_GetUnitIDFromPanelID(id);
			if target then
				unitname = UnitName(target);
			end
		end
		if not target then
			target = 'nil';
		end
		if not unitname then
			unitname = 'nil';
		end
		if not id then
			id = '?';
		end
		PutDebugMsg('Mousing over ' .. framename .. ', targetid = ' .. target .. ', name is ' .. unitname);
	end
end
--WINTROW.6 STOP

-- *****************************************************************************
-- BeneCastOptionFrameTab functions
-- *****************************************************************************

function BeneCastOptionFrameTab_OnClick()

	-- Show the correct subframe based on which tab was clicked
	-- Hide all subframes that do not have matching ID numbers, show the matching subframe
	for subframe, subframename in BeneCastOptionFrameSubframes do
		if this:GetID() == getglobal(subframename):GetID() then
			getglobal(subframename):Show();
		else
			getglobal(subframename):Hide();
		end
	end
	
	-- Play a sound for player feedback
	PlaySound('igCharacterInfoTab');
	
	-- Set the glowing checked status for the correct tab
	for x in BeneCastOptionFrameSubframes do
		if ( x == this:GetID() ) then
			this:Disable()
			this:SetChecked(1);
		else
			getglobal('BeneCastOptionFrameTab' .. x):Enable();
			getglobal('BeneCastOptionFrameTab' .. x):SetChecked(nil);
		end
	end
	
end

-- *****************************************************************************
-- BeneCastOptionsCheckButton functions
-- *****************************************************************************

function BeneCastOptionsCheckButton_OnClick()

	local dontredraw = nil;

	-- Set the BeneCastConfig for the option to take on the value of the checkbutton
	for index, value in BeneCastOptionFrameCheckButtons do
		if ( value.index == this:GetID() ) then
			BeneCastConfig[value.cvar] = this:GetChecked();
			-- If this is the tooltip option check to see if it's enabled
			-- If not disable the tooltip name option checkbutton
			if ( value.index == 5 ) then
				if ( this:GetChecked() ) then
					getglobal('BeneCastOptionCheckButton6'):Enable();
				else
					getglobal('BeneCastOptionCheckButton6'):Disable();
				end
			-- If this is the notification option check to see if it's enabled
			-- If not disable all sub notification options
			elseif ( value.index == 8 ) then
				if ( this:GetChecked() ) then
					getglobal('BeneCastOptionCheckButton9'):Enable();
					getglobal('BeneCastOptionCheckButton10'):Enable();
					getglobal('BeneCastOptionCheckButton11'):Enable();
					getglobal('BeneCastOptionCheckButton12'):Enable();
					getglobal('BeneCastOptionCheckButton20'):Enable();
					getglobal('BeneCastOptionCheckButton29'):Enable();
					getglobal('BeneCastOptionCheckButton13'):Enable();
					getglobal('BeneCastOptionCheckButton14'):Enable();
					getglobal('BeneCastOptionCheckButton15'):Enable();
					getglobal('BeneCastOptionCheckButton16'):Enable();
					getglobal('BeneCastOptionCheckButton17'):Enable();
					getglobal('BeneCastOptionCheckButton18'):Enable();
					getglobal('BeneCastOptionCheckButton19'):Enable();
					getglobal('BeneCastOptionCheckButton21'):Enable();
				else
					getglobal('BeneCastOptionCheckButton9'):Disable();
					getglobal('BeneCastOptionCheckButton10'):Disable();
					getglobal('BeneCastOptionCheckButton11'):Disable();
					getglobal('BeneCastOptionCheckButton12'):Disable();
					getglobal('BeneCastOptionCheckButton20'):Disable();
					getglobal('BeneCastOptionCheckButton29'):Disable();
					getglobal('BeneCastOptionCheckButton13'):Disable();
					getglobal('BeneCastOptionCheckButton14'):Disable();
					getglobal('BeneCastOptionCheckButton15'):Disable();
					getglobal('BeneCastOptionCheckButton16'):Disable();
					getglobal('BeneCastOptionCheckButton17'):Disable();
					getglobal('BeneCastOptionCheckButton18'):Disable();
					getglobal('BeneCastOptionCheckButton19'):Disable();
					getglobal('BeneCastOptionCheckButton21'):Disable();
				end
			-- If this is the heal notification option check to see if it's enabled
			-- If not disable all heal max notification
			elseif ( value.index == 16 ) then
				if ( this:GetChecked() ) then
					getglobal('BeneCastOptionCheckButton17'):Enable();
				else
					getglobal('BeneCastOptionCheckButton17'):Disable();
				end
			-- If this is the hide minimap button option check to see if it's enabled
			-- If so then hide the minimap button
			elseif ( value.index == 4 ) then
				if ( this:GetChecked() ) then
					getglobal('BeneCastMinimapButton'):Hide();
				else
					getglobal('BeneCastMinimapButton'):Show();
				end	
			-- If this is a notification channel option check to see if it's enabled
			-- If so disable all other notification channel options
			-- Notifcation channel options should act like radio buttons
			elseif ( value.index == 9 or 
			         value.index == 10 or 
				 value.index == 11 or 
				 value.index == 12 or 
				 value.index == 29 or
				 value.index == 20 ) then
				if ( this:GetChecked() ) then
					-- Uncheck all other buttons
					getglobal('BeneCastOptionCheckButton9'):SetChecked(0);
					getglobal('BeneCastOptionCheckButton10'):SetChecked(0);
					getglobal('BeneCastOptionCheckButton11'):SetChecked(0);
					getglobal('BeneCastOptionCheckButton12'):SetChecked(0);
					getglobal('BeneCastOptionCheckButton20'):SetChecked(0);
					getglobal('BeneCastOptionCheckButton29'):SetChecked(0);
					-- Check this button
					getglobal('BeneCastOptionCheckButton'..value.index):SetChecked(1)
					-- Set all the variables to the correct values
					-- Set all the channels to false
					BeneCastConfig['SelfNotify'] = false;
					BeneCastConfig['PartyNotify'] = false;
					BeneCastConfig['SayNotify'] = false;
					BeneCastConfig['RaidNotify'] = false;
					BeneCastConfig['TargetNotify'] = false;
					BeneCastConfig['UserNotify'] = false;
					-- Set the correct channel to true
					BeneCastConfig[value.cvar] = 1;
				else
					-- Don't let the user uncheck a button by clicking on it
					-- It will be unchecked if another channel is set
					-- As such, the config setting must still be set to 1
					BeneCastConfig[value.cvar] = 1;
					getglobal('BeneCastOptionCheckButton'..value.index):SetChecked(1)
				end
			--WINTROW.6 START
			--If Damage Based Healing is turned off --> Priest Heals are seperated
			--If Damage Based Healing is turned on  --> Priest Heals are consolidated
			elseif ( value.index == 1 ) then
				-- Reset most of the tables for reloading of spells and reload the spell data
				-- This will split the Priest Heal buttons
				BeneCast_ResetData();
				BeneCast_UpdateHealingBonuses(); --Recalc healingbonuses
			--Allow Raidpets to be clicked only if Raidmembers is checked
			elseif ( value.index == 24 ) then
				local cbutton = getglobal('BeneCastOptionCheckButton25');
				if ( this:GetChecked() ) then
					cbutton:Enable();
				else
					BeneCastConfig.ShowRaidPets = false;
					cbutton:SetChecked(BeneCastConfig.ShowRaidPets);
					cbutton:Disable();
				end
				BC_UpdateRaid = true;
				dontredraw = true;
			--Redraw raidbuttons to show/hide raidpets
			elseif ( value.index == 25 ) then
				BC_UpdateRaid = true;
				dontredraw = true;
			--Recalc healingbonuses
			elseif ( value.index == 26 ) then
				BeneCast_UpdateHealingBonuses();
			--WINTROW.6 STOP
			end
		end
	end
	-- Play a sound for player feedback
	if ( this:GetChecked() ) then
		PlaySound('igMainMenuOptionCheckBoxOff');
	else
		PlaySound('igMainMenuOptionCheckBoxOn');
	end
	
	-- Redraw everyone's buttons
	if not dontredraw then
		for i in BC_targets do
			BeneCast_UpdateButtons(i);
		end
	end

end


-- *****************************************************************************
-- BeneCastSpellCheckButton functions
-- *****************************************************************************

function BeneCastSpellCheckButton_OnClick()

	-- Put some things in a local in the beginning for efficiency (thnx Shimavak)
	local spellname = getglobal( this:GetName() .. 'Text' ):GetText();
	local parentid = this:GetParent():GetID();
	-- Set the BeneCastConfig for the option to take on the value of the checkbutton
	if ( spellname == BENECAST_STRINGS.TEXT_ASSIST ) then
		BeneCastConfig[parentid]['assist'] = this:GetChecked();
	else
		local spelltype = BeneCast_SpellTypes[BC_class][spellname];
		if ( BeneCastConfig['PlayerAsDefault'] and parentid == 1 ) then
			for i = 1, 9 do
				BeneCastConfig[i][spelltype] = this:GetChecked();
				getglobal(BeneCastOptionFrameSubframes[i] .. 'Button' .. this:GetID()):SetChecked(this:GetChecked());
			end
		else
			BeneCastConfig[parentid][spelltype] = this:GetChecked();
		end
	end
	-- Play a sound for player feedback
	if ( this:GetChecked() ) then
		PlaySound('igMainMenuOptionCheckBoxOff');
	else
		PlaySound('igMainMenuOptionCheckBoxOn');
	end
	
	-- Redraw everyone's buttons
	for i in BC_targets do
		BeneCast_UpdateButtons(i);
	end

end

-- *****************************************************************************
-- BeneCastRaidCheckButton functions
-- *****************************************************************************

function BeneCastRaidCheckButton_OnClick()

	-- If this raid checkbutton has a name
	if ( getglobal(this:GetName() .. 'Name'):GetText() ~= '' ) then
		-- Set the RaidID of this member to on or off
		local name = getglobal(this:GetName() .. 'Name'):GetText();
		local unitid = BENECAST_RAID_ROSTER2[name];
		local idnum;
		_, _, idnum = string.find(unitid,'raid(.+)');
		BENECAST_RAID_LIST[name] = this:GetChecked();
		
		BeneCast_AttachRaidPanels(BeneCastConfig.RaidSnapTo);
		
		-- Update the buttons associated with the raid member and their pets
		BeneCast_UpdateButtonsForUnit('raid' .. idnum);
		BeneCast_UpdateButtonsForUnit('raidpet' .. idnum);
	end

end

function BeneCastRaidCheckButton_OnEnter()

	GameTooltip:SetOwner(this, 'ANCHOR_BOTTOMRIGHT');
	GameTooltip:SetText(BENECAST_STRINGS.TEXT_RAID_CHECKBUTTON_TOOLTIP, nil, nil, nil, nil, 1)

end

-- *****************************************************************************
-- BeneCastRaidGroup functions
-- *****************************************************************************

function BeneCastRaidGroup_OnClick()

	local name, rank, subgroup, level, class, fileName, zone, online, isDead;
	
	-- For all raid members/ids
	for i = 1, GetNumRaidMembers() do
		name, rank, subgroup, level, class, fileName, zone, online, isDead = GetRaidRosterInfo(i);
		-- Check this raid member to if their subgroup is the same as this subgroup
		if ( subgroup == this:GetID() ) then
			if ( name ) then
				-- Set the RaidID of this group member to on
				BENECAST_RAID_LIST[name] = true;
								
				--[[ -- I can't understand why this is here, inside the loop
				-- Check all the buttons in this group
				getglobal('BeneCastRaidButton' .. ((subgroup - 1) * 5) + 1 ):SetChecked(true);
				getglobal('BeneCastRaidButton' .. ((subgroup - 1) * 5) + 2 ):SetChecked(true);
				getglobal('BeneCastRaidButton' .. ((subgroup - 1) * 5) + 3 ):SetChecked(true);
				getglobal('BeneCastRaidButton' .. ((subgroup - 1) * 5) + 4 ):SetChecked(true);
				getglobal('BeneCastRaidButton' .. ((subgroup - 1) * 5) + 5 ):SetChecked(true);
				]]
			end
		end
	end
	
	BC_UpdateRaid = true;

end

function BeneCastRaidGroup_OnLoad()

	getglobal(this:GetName() .. 'Name'):SetText(BENECAST_STRINGS.TEXT_RAID_GROUP .. this:GetID());

end

function BeneCastRaidGroup_OnEnter()

	GameTooltip:SetOwner(this, 'ANCHOR_BOTTOMRIGHT');
	GameTooltip:SetText(BENECAST_STRINGS.TEXT_RAID_GROUP_TOOLTIP, nil, nil, nil, nil, 1)

end

-- *****************************************************************************
-- BeneCastOptionsSlider functions
-- *****************************************************************************

function BeneCastOptionsSlider_OnValueChanged()

	-- Set the BeneCastConfig for the option to take on the value of the checkbutton
	for index, value in BeneCastOptionFrameSliders do
		if ( value.index == this:GetID() ) then
			BeneCastConfig[value.cvar] = this:GetValue();
			getglobal('BeneCastOptionSlider'..value.index..'Value'):SetText(this:GetValue());
		end
		-- If the slider being changed is the buttonsize slider then resize the buttons
		if ( value.index == 1 ) then
			BeneCast_ResizeButtons();
		end
		-- If the slider being changed is the buttonnumber slider then redraw all buttons
		if ( value.index == 3 ) then
			for i in BC_targets do
				BeneCast_UpdateButtons(i);
			end
		end
	end

end


-- *****************************************************************************
-- BeneCastPanelManager functions
-- *****************************************************************************

function BeneCastPanelManager_OnLoad()

	-- Set BC_class to the player's class
	BC_class = UnitClass('player');
	
	-- Register for Events
	this:RegisterEvent('ADDON_LOADED');
	this:RegisterEvent('SPELLS_CHANGED');
	this:RegisterEvent('SPELLCAST_FAILED');
	this:RegisterEvent('SPELLCAST_INTERRUPTED');
	this:RegisterEvent('SPELLCAST_STOP');
	this:RegisterEvent('SPELLCAST_START');
	this:RegisterEvent('PARTY_MEMBERS_CHANGED');
	this:RegisterEvent('PLAYER_TARGET_CHANGED');
	this:RegisterEvent('UNIT_AURA');
	this:RegisterEvent('PLAYER_AURAS_CHANGED');
	this:RegisterEvent('UNIT_AURASTATE');
	this:RegisterEvent('UPDATE_SHAPESHIFT_FORMS');
	this:RegisterEvent('PLAYER_ALIVE');
	this:RegisterEvent('PLAYER_DEAD');
	this:RegisterEvent('PLAYER_UNGHOST');
	this:RegisterEvent('RAID_ROSTER_UPDATE');
	this:RegisterEvent('UNIT_HEALTH');
	--WINTROW.6 this:RegisterEvent('UNIT_INVENTORY_CHANGED');
	--WINTROW.6 START
	this:RegisterEvent('PLAYER_ENTERING_WORLD');
	this:RegisterEvent('PLAYER_LEAVING_WORLD');
	this:RegisterEvent('VARIABLES_LOADED');
	this:RegisterEvent('UNIT_PET');
	--WINTROW.6 STOP

end

function BeneCastPanelManager_OnEvent()

	if ( event == 'ADDON_LOADED' and arg1 == 'BeneCast' ) then
		-- Reset the data if there BeneCast is severly outdated
		if ( not BeneCastConfig or not BeneCastConfig.Version or BeneCastConfig.Version < BENECAST_VERSION ) then
			BeneCast_ResetConfig();
		end
		-- Load up spell data once AddOn has been loaded
		BeneCast_ResetData();
		
		-- In older versions there was no right/bottom
		if ( BeneCastConfig.RaidSnapTo == 'CT_RAID' ) then
			BeneCastConfig.RaidSnapTo = 'CT_RAIDRIGHT';
		end
		
		--Code from BeneCastOptionFrame
		BeneCast_LoadOptions();
		BeneCast_ResizeButtons();
		BeneCast_ClearRaid();
		
		BENECAST_RAID_LIST = {};
		
		BeneCast_SnapPanels('BeneCast');
		
		--If BonusScanner was loaded before BeneCast
		if IsAddOnLoaded('BonusScanner') then
			if BC_BonusScanner_HookFunction == nil then
				BeneCast_UpdateHealingBonuses();
				BC_BonusScanner_HookFunction = BonusScanner_Update;
				BonusScanner_Update = BeneCast_UpdateHealingBonuses;
			end
		end
		
		BeneCast_ScanActionSlots();
	
	elseif ( event == 'ADDON_LOADED' and ( arg1 == 'Blizzard Raid UI' or arg1 == 'CT_RaidAssist' ) ) then
		if arg1 == 'CT_RaidAssist' then
			--Hook into CT_RA's update function
			if BC_Old_CTRA_UpdateFunction == nil then
				BC_Old_CTRA_UpdateFunction = CT_RA_UpdateRaidGroup;
				CT_RA_UpdateRaidGroup = BC_UpdateRaidGroup;
			end
		end
			
		BC_UpdateRaid = true;
	
	--Hook into BonusScanner's Update-function
	elseif ( event == 'ADDON_LOADED' and arg1 == 'BonusScanner' ) then
		if BC_BonusScanner_HookFunction == nil then
			BeneCast_UpdateHealingBonuses();
			BC_BonusScanner_HookFunction = BonusScanner_Update;
			BonusScanner_Update = BeneCast_UpdateHealingBonuses;
		end
	
	--[[
	elseif ( event == 'ADDON_LOADED' and arg1 == 'TheoryCraft' ) then
		if TheoryCraft_UpdatedButtons then
			TheoryCraft_UpdatedButtons.BeneCast = 'Cough';
			BC_MarkedTCTable = true;
			BeneCast_UpdateSpellsFromTC();			
		end
	]]
	
	elseif ( event == 'ADDON_LOADED' ) then
		-- Load up the variables for the snapping if empty
		if BeneCastConfig.SnapTo ~= 'CUSTOM' then
			BeneCast_SnapPanels(arg1);
		end
		
	elseif ( event == 'VARIABLES_LOADED' ) then
		-- Wait with the snapping till everything is loaded
		BC_AttachPartyFrames = true;
	
	-- The following is really, really confusing
	-- If SPELLCAST_FAILED then a BeneCast spell may have failed
	elseif ( event == 'SPELLCAST_FAILED' ) then
		-- A BeneCast spell failed if a BC_spellstarted and BC_sentmessage
		if ( BC_spellstarted and BC_sentmessage ) then
			BeneCast_PartyNotifyFail('SPELLCAST_FAILED');
		end
		-- Clear out everything used for party notification just in case
		BC_spellstarted = nil;
		BC_spellstopped = nil;
		BC_spelltarget = nil;
		BC_spellbeingcast = nil;
		BC_spellismax = nil;
		BC_sentmessage = nil;
		
	-- If SPELLCAST_INTERRUPTED then a BeneCast spell may have been interrupted
	elseif ( event == 'SPELLCAST_INTERRUPTED' ) then
		-- A BeneCast spell was interrupted by the player if BC_spellstopped and BC_sentmessage
		if ( BC_spellstopped and BC_sentmessage ) then
			BeneCast_PartyNotifyFail('SPELLCAST_CANCELED');
		end
		-- A BeneCast spell was interrupted by something else if BC_spellstarted and BC_sentmessage
		if ( BC_spellstarted and BC_sentmessage ) then
			BeneCast_PartyNotifyFail('SPELLCAST_INTERRUPTED');
		end
		-- Clear out everything just in case
		BC_spellstarted = nil;
		BC_spellstopped = nil;
		BC_spelltarget = nil;
		BC_spellbeingcast = nil;
		BC_spellismax = nil;
		BC_sentmessage = nil;
		
	elseif ( event == 'SPELLCAST_STOP' ) then
		-- If BC_spellbeingcast and notification is on then this is an instant spell and you should do notification
		if ( BC_spellbeingcast and BeneCastConfig.Notification ) then
			-- BC_sentmessage will be set to true of BeneCast_PartyNotify sends a message
			BC_sentmessage = BeneCast_PartyNotify(BC_spelltarget, BC_spellbeingcast, BC_spellismax, 0);
		-- Otherwise set _setmessage to false
		else
			BC_sentmessage = nil
		end
		-- If BC_spellstarted, then a BeneCast spell was started and you should set BC_sentmessage and BC_spellstopped to true to indicate that the spell was interrupted by the user
		if ( BC_spellstarted ) then
			BC_sentmessage = true;
			BC_spellstopped = true;
			BC_spellstarted = nil;
		else
			-- Clear this, just in case
			BC_spellstopped = nil;
		end
		-- Clear these out just in case
		BC_spelltarget = nil;
		BC_spellbeingcast = nil;
		BC_spellismax = nil;
		
	elseif ( event == 'SPELLCAST_START' ) then
		-- If the spell being cast exists in BeneCast_SpellTypes, notification is on, and there is a BC_spellbeingcast then do notification
		if ( BeneCast_SpellTypes[BC_class][arg1] and BeneCastConfig.Notification and BC_spellbeingcast ) then
			-- Set BC_sentmessage to true of BeneCast_PartyNotify sent a message
			BC_sentmessage = BeneCast_PartyNotify(BC_spelltarget, BC_spellbeingcast, BC_spellismax, arg2);
			-- Clear out BC_spelltarget, BC_spellbeingcast, and BC_spellismax so it isn't used by SPELLCAST_STOP
			BC_spelltarget = nil;
			BC_spellbeingcast = nil;
			BC_spellismax = nil;
			-- If you sent a message then BC_spellstarted to indicate failures/interruptions should send notifications
			if ( BC_sentmessage ) then
				BC_spellstarted = true;
			end
		else
			-- Clear out everything just in case
			BC_spellstarted = nil;
			BC_spellstopped = nil;
			BC_spelltarget = nil;
			BC_spellbeingcast = nil;
			BC_spellismax = nil;
			BC_sentmessage = nil;
		end
	
	-- We only want spell changes after entering the world
	elseif ( event == 'SPELLS_CHANGED' and arg1 == nil) then -- don't fire when user only browses spellbook
		
		-- Reset most of the tables for reloading of spells and reload the spell data
		BeneCast_ResetData();
		-- Redraw all the buttons on everyone
		for i in BC_targets do
			BeneCast_UpdateButtons(i);
		end
	
	-- Don't bother with UNIT_AURA if the player can attack the unit
	elseif ( ( event == 'UNIT_AURA' or event == 'UNIT_AURASTATE' ) and not UnitCanAttack('player', arg1) ) then
		if BC_AttachPartyFrames then
			BeneCast_AttachPartyPanelsFromVar();
			BC_AttachPartyFrames = nil;
		end
		-- Redraw the buttons for the UnitID in arg1
		if BeneCastConfig.Debug then
			local msg = arg1;
			if not msg then
				msg = 'nil';
			end
			PutDebugMsg(event .. ' for ' .. msg);
		end
		BeneCast_UpdateButtonsForUnit(arg1);
		
	elseif ( event == 'PLAYER_AURAS_CHANGED' ) then
		if BC_AttachPartyFrames then
			BeneCast_AttachPartyPanelsFromVar();
			BC_AttachPartyFrames = nil;
		end
		BeneCast_UpdateButtonsForUnit('player');
	
	elseif ( event == 'PARTY_MEMBERS_CHANGED' ) then
		-- Redraw the buttons for all partymembers
		for i = 2,5 do
			BeneCast_UpdateButtons(i);
		end
		--Party pets too
		for i = 47,50 do
			BeneCast_UpdateButtons(i);
		end
	
	-- Fired when the pet of a unit changes
	elseif ( event == 'UNIT_PET' ) then
		if arg1 == 'player' then
			BeneCast_UpdateButtonsForUnit('pet');
		elseif string.find(arg1,'party') then
			local num;
			_, _, num = string.find(arg1,'party(.+)');
			if num then
				BeneCast_UpdateButtonsForUnit('partypet' .. num);
			end
		elseif string.find(arg1,'raid') then
			if BeneCastConfig.ShowRaidPets then
				BC_UpdateRaid = true;
			else
				local num;
				_, _, num = string.find(arg1,'raid(.+)');
				if num then
					BeneCast_UpdateButtonsForUnit('raidpet' .. num);
				end
			end
		end
		
	elseif ( event == 'ACTIONBAR_SLOT_CHANGED' ) then
		BeneCast_ScanActionSlot(arg1);
		
	elseif ( event == 'PLAYER_TARGET_CHANGED' ) then
		if BC_AttachPartyFrames then
			BeneCast_AttachPartyPanelsFromVar();
			BC_AttachPartyFrames = nil;
		end
		-- Redraw the buttons for the target
		BeneCast_UpdateButtonsForUnit('target');
		
	elseif ( event == 'RAID_ROSTER_UPDATE' ) then
		PutDebugMsg('RAID_ROSTER_UPDATE event received');
		if BeneCastConfig.RaidSnapTo == 'STANDARDBOTTOM' or BeneCastConfig.RaidSnapTo == 'STANDARDRIGHT' then
			BC_UpdateRaid = true;
		end
				
	elseif ( event == 'PLAYER_ALIVE' ) then
		-- Redraw everyone's buttons
		for i in BC_targets do
			BeneCast_UpdateButtons(i);
		end
		
	elseif ( event == 'PLAYER_DEAD' ) then
		-- Redraw everyone's buttons
		for i in BC_targets do
			BeneCast_UpdateButtons(i);
		end
		
	elseif ( event == 'PLAYER_UNGHOST' ) then
		-- Redraw everyone's buttons
		for i in BC_targets do
			BeneCast_UpdateButtons(i);
		end
		
	elseif ( event == 'UNIT_HEALTH' ) then
		-- Redraw a member's panel if they're dead
		if ( UnitHealth(arg1) <= 0 and UnitIsConnected(arg1) ) then
			BeneCast_UpdateButtonsForUnit(arg1);
		end
		
	elseif ( event == 'UPDATE_SHAPESHIFT_FORMS' ) then
		-- Redraw everyone's buttons
		for i in BC_targets do
			BeneCast_UpdateButtons(i);
		end
		
	--[[ -- Now uses BonusScanner for +healing
	elseif ( event == 'UNIT_INVENTORY_CHANGED' and arg1 == 'player' ) then
		-- Scan Equipment for + healing
		BeneCast_ScanEquipment();
	]]
		
	elseif ( event == 'PLAYER_ENTERING_WORLD' ) then
		BeneCast_AttachPartyPanelsFromVar();
		this:RegisterEvent('SPELLS_CHANGED');
		this:RegisterEvent('UNIT_AURA');
		this:RegisterEvent('PLAYER_AURAS_CHANGED');
		this:RegisterEvent('UNIT_AURASTATE');
		this:RegisterEvent('UPDATE_SHAPESHIFT_FORMS');
		this:RegisterEvent('UNIT_HEALTH');
		this:RegisterEvent('ACTIONBAR_SLOT_CHANGED');
		--this:RegisterEvent('UNIT_INVENTORY_CHANGED');
	
	elseif ( event == 'PLAYER_LEAVING_WORLD' ) then
		this:UnregisterEvent('SPELLS_CHANGED');
		this:UnregisterEvent('UNIT_AURA');
		this:UnregisterEvent('PLAYER_AURAS_CHANGED');
		this:UnregisterEvent('UNIT_AURASTATE');
		this:UnregisterEvent('UPDATE_SHAPESHIFT_FORMS');
		this:UnregisterEvent('UNIT_HEALTH');
		this:UnregisterEvent('ACTIONBAR_SLOT_CHANGED');
		--this:UnregisterEvent('UNIT_INVENTORY_CHANGED');	
		
	end

end

function BeneCastPanelManager_OnUpdate()

	local hasMainHandEnchant, mainHandExpiration, mainHandCharges, hasOffHandEnchant, offHandExpiration, offHandCharges;
	
	hasMainHandEnchant, mainHandExpiration, mainHandCharges, hasOffHandEnchant, offHandExpiration, offHandCharges = GetWeaponEnchantInfo();
	
	if ( hasMainHandEnchant ) then
		local slotId, textureName;
	
		slotId, textureName = GetInventorySlotInfo('MainHandSlot');
	
		BeneCast_Tooltip:ClearLines();
		BeneCast_Tooltip:SetInventoryItem('player', slotId);
		
		for i = 1, BeneCast_Tooltip:NumLines() do
			if getglobal('BeneCast_TooltipTextLeft' .. i):GetText() then
				local line = getglobal('BeneCast_TooltipTextLeft' .. i):GetText();
				if ( BC_weaponenchant ~= BENECAST_STRINGS.WEAPONENCHANT_ROCKBITER and string.find(line, BENECAST_STRINGS.WEAPONENCHANT_ROCKBITER) ) then
					BC_weaponenchant = BENECAST_STRINGS.WEAPONENCHANT_ROCKBITER;
					BeneCast_UpdateButtons(1);
					do break end; --WINTROW.6, break for efficiency
				end
				if ( BC_weaponenchant ~= BENECAST_STRINGS.WEAPONENCHANT_FLAMETONGUE and string.find(line, BENECAST_STRINGS.WEAPONENCHANT_FLAMETONGUE) ) then
					BC_weaponenchant = BENECAST_STRINGS.WEAPONENCHANT_FLAMETONGUE;
					BeneCast_UpdateButtons(1);
					do break end; --WINTROW.6, break for efficiency
				end
				if ( BC_weaponenchant ~= BENECAST_STRINGS.WEAPONENCHANT_FROSTBRAND and string.find(line, BENECAST_STRINGS.WEAPONENCHANT_FROSTBRAND) ) then
					BC_weaponenchant = BENECAST_STRINGS.WEAPONENCHANT_FROSTBRAND;
					BeneCast_UpdateButtons(1);
					do break end; --WINTROW.6, break for efficiency
				end
				if ( BC_weaponenchant ~= BENECAST_STRINGS.WEAPONENCHANT_WINDFURY and string.find(line, BENECAST_STRINGS.WEAPONENCHANT_WINDFURY) ) then
					BC_weaponenchant = BENECAST_STRINGS.WEAPONENCHANT_WINDFURY;
					BeneCast_UpdateButtons(1);
					do break end; --WINTROW.6, break for efficiency
				end
				if ( BC_weaponenchant ~= BENECAST_STRINGS.WEAPONENCHANT_FEEDBACK and string.find(line, BENECAST_STRINGS.WEAPONENCHANT_FEEDBACK) ) then
					BC_weaponenchant = BENECAST_STRINGS.WEAPONENCHANT_FEEDBACK;
					BeneCast_UpdateButtons(1);
					do break end; --WINTROW.6, break for efficiency
				end
			end
		end
	else
		if ( BC_weaponenchant ) then
			BC_weaponenchant = nil;
			BeneCast_UpdateButtons(1);
		end
		BC_weaponenchant = nil;
	end

	-- Update all button-flashing at once
	local buffAlphaValue = nil;
	for i, buttonname in BC_buttons_that_flash do
		local button = getglobal(buttonname);
		if button then
			if buffAlphaValue == nil then --this way it only has to be calculated once
				if ( BuffFrameFlashState == 1 ) then
					buffAlphaValue = (BUFF_FLASH_TIME_ON - BuffFrameFlashTime) / BUFF_FLASH_TIME_ON;
					buffAlphaValue = buffAlphaValue * (1 - BUFF_MIN_ALPHA) + BUFF_MIN_ALPHA;
				else
					buffAlphaValue = BuffFrameFlashTime / BUFF_FLASH_TIME_ON;
					buffAlphaValue = (buffAlphaValue * (1 - BUFF_MIN_ALPHA)) + BUFF_MIN_ALPHA;
					--this:SetAlpha(BuffFrameFlashTime / BUFF_FLASH_TIME_ON);
				end
			end
			button:SetAlpha(buffAlphaValue);
		end
	end
	
	--[[
	-- Check if TheoryCraft is updated
	if TheoryCraft_UpdatedButtons and BC_MarkedTCTable then
		if (BC_LastTCCheck == nil) or (BC_LastTCCheck - GetTime()) > 1 then --Reduce number of checks
			BC_LastTCCheck = GetTime();
			if TheoryCraft_UpdatedButtons.BeneCast == nil then
				BeneCast_UpdateSpellsFromTC();
				TheoryCraft_UpdatedButtons.BeneCast = 'Cough';
			end
		end
	end
	]]
	
	if BeneCastConfig.ShowRaid then
		local docheck = false;
		if BC_UpdateRaid then
			if BC_Last_UpdateRaid_Done == nil then
				docheck = true;
			elseif (GetTime() - BC_Last_UpdateRaid_Done) >= 5 then
				docheck = true;
			end
		--[[
		-- Always do an update every minute
		elseif (GetTime() - BC_Last_UpdateRaid_Done) >= 60 then
			docheck = true;
		]]
		end
		if docheck then
			BC_Last_UpdateRaid_Done = GetTime();
			BC_UpdateRaid = nil;
			BeneCast_UpdateRaid();
		end
	end
		
	-- Check if sth changed for the target of target
	local ttinuse = false;
	-- First see if the user wants it
	if BeneCastConfig.ShowTargetTarget then
		-- Then see if the panel is attached to something
		if BeneCastConfig.BeneCastPanel92 then
			if BeneCastConfig.BeneCastPanel92.Frame then
				ttinuse = true;
			end
		end
	end
	if ttinuse then
		local docheck = false;
		if BC_TargetTarget.lastcheck == nil then
			docheck = true;
		elseif (GetTime() - BC_TargetTarget.lastcheck) >= 1 then --Only once per second
			docheck = true;
		end
		if docheck then
			BC_TargetTarget.lastcheck = GetTime();
			local new_info = {};
			if UnitExists('targettarget') then
				new_info.exists = true;
				new_info.name = UnitName('targettarget');
				local i = 1;
				while UnitBuff('targettarget',i,true) do
					-- Only count buffs the player can cast
					i = i + 1;
				end
				new_info.noofbuffs = i;
				i = 1;
				while UnitDebuff('targettarget',i,true) do
					-- Only count debuffs the player can cure
					i = i + 1;
				end
				new_info.noofdebuffs = i;
			else
				new_info.exists = false;
				new_info.name = nil;
				new_info.noofbuffs = 0;
				new_info.noofdebuffs = 0;
			end
			local changed = false;
			if new_info.exists ~= BC_TargetTarget.exists then
				changed = true;
			elseif new_info.name ~= BC_TargetTarget.name then
				changed = true;
			elseif new_info.noofbuffs ~= BC_TargetTarget.noofbuffs then
				changed = true;
			elseif new_info.noofdebuffs ~= BC_TargetTarget.noofdebuffs then
				changed = true;
			end
			if changed then
				BC_TargetTarget.exists = new_info.exists;
				BC_TargetTarget.name = new_info.name;
				BC_TargetTarget.noofbuffs = new_info.noofbuffs;
				BC_TargetTarget.noofdebuffs = new_info.noofdebuffs;
				BeneCast_UpdateButtons(92);
			end
		end
	end
	
	-- Check for buttons if they are within range
	if BeneCastConfig.CheckRange then
		local docheck = false;
		if ( BC_LastRangeCheck == nil ) or
		   ( (GetTime() - BC_LastRangeCheck) > 1 ) then -- Every 1 second
		   	docheck = true;
		end
		if docheck then
			BC_LastRangeCheck = GetTime();
			if getglobal('BeneCastPanel91'):IsVisible() and UnitExists('target') then
				for i = 1, BENECAST_MAX_NUMBER_OF_BUTTONS do
					local buttonname = 'BeneCastPanel91Button' .. i;
					local button = getglobal(buttonname);
					if button:IsVisible() then
						local spelltype = button.spelltype;
						if BC_actionslot_by_spell[spelltype] then
							if not IsActionInRange(BC_actionslot_by_spell[spelltype]) then
								getglobal(buttonname .. 'Range'):Show();
							else
								getglobal(buttonname .. 'Range'):Hide();
							end
						end
					end
				end
			end
		end
	end

end

-- *****************************************************************************
-- BeneCastResetButton functions
-- *****************************************************************************

function BeneCast_ResetTooltip()

	GameTooltip:SetOwner(this, 'ANCHOR_RIGHT');
	GameTooltip:SetText(BENECAST_STRINGS['TEXT_RESET_BUTTON_TOOLTIP'], nil, nil, nil, nil, 1);

end

function BeneCast_ResetConfig()
	-- Reset the BeneCastConfig table
	BeneCastConfig = {};
	
	BeneCastConfig[1] = {};
	BeneCastConfig[2] = {};
	BeneCastConfig[3] = {};
	BeneCastConfig[4] = {};
	BeneCastConfig[5] = {};
	BeneCastConfig[6] = {};
	BeneCastConfig[7] = {};
	BeneCastConfig[8] = {};
	BeneCastConfig[9] = {};

	for i = 1,9 do
		for type in BeneCast_SpellLevel[BC_class] do
			BeneCastConfig[i][type] = false;
		end
	end
	
	BeneCastConfig['DmgBasedHeal'] = true;
	BeneCastConfig['ManaBasedHeal'] = true;
	BeneCastConfig['ReverseHoTs'] = false; 
	BeneCastConfig['Overheal'] = false;
	BeneCastConfig['ShowAllBuffs'] = false;
	BeneCastConfig['FlashAsFade'] = false;
	BeneCastConfig['HideMinimap'] = false;
	BeneCastConfig['ShowTooltips'] = true;
	BeneCastConfig['ShowTooltipsName'] = false;
	BeneCastConfig['Unlock'] = false;
	BeneCastConfig['Notification'] = false;
	BeneCastConfig['SelfNotify'] = true;
	BeneCastConfig['PartyNotify'] = false;
	BeneCastConfig['SayNotify'] = false;
	BeneCastConfig['RaidNotify'] = false;
	BeneCastConfig['TargetNotify'] = false;
	BeneCastConfig['UserNotify'] = false;
	BeneCastConfig['SelfCasts'] = true;
	BeneCastConfig['NotifyRank'] = true;
	BeneCastConfig['NotifyTime'] = true;
	BeneCastConfig['NotifyHeal'] = true;
	BeneCastConfig['NotifyMaxHeal'] = false;
	BeneCastConfig['NotifyCure'] = true;
	BeneCastConfig['NotifyBuff'] = true;
	BeneCastConfig['NotifyRes'] = true;
	BeneCastConfig['PlayerAsDefault'] = true;
	BeneCastConfig['ShowPets'] = false;
	BeneCastConfig['ShowRaid'] = false;
	BeneCastConfig['ShowRaidPets'] = false; 
	BeneCastConfig['CheckRange'] = false; 
	BeneCastConfig['ShowTargetTarget'] = true; 
	
	BeneCastConfig['ButtonSize'] = 36;
	BeneCastConfig['OverhealSlider'] = 1;
	BeneCastConfig['ButtonNumber'] = 5;
	
	BeneCastConfig['UserChannel'] = nil;
	
	BeneCastConfig['SnapTo'] = 'STANDARD';
	BeneCastConfig['RaidSnapTo'] = 'STANDARDRIGHT';
	
	BeneCastConfig['Debug'] = false;
	
	BeneCast_ResetData();
	BeneCast_LoadOptions();
	-- Place the panels in the correct place
	BeneCast_SnapPanels('BeneCast');
	BeneCast_AttachPartyPanelsFromVar();
	BeneCastConfig['Version'] = BENECAST_VERSION;
	
	-- Reset the SnapTo selections (Raid too, thnx Shimavak)
	UIDropDownMenu_SetSelectedValue(BeneCastSnapToMenu, BeneCastConfig.SnapTo);
	UIDropDownMenu_SetSelectedValue(BeneCastRaidSnapToMenu, BeneCastConfig.RaidSnapTo);
	-- Redraw everyone's panels
	for i in BC_targets do
		BeneCast_OrientButtons(i);
		BeneCast_UpdateButtons(i);
	end

end

-- *****************************************************************************
-- BeneCastUserChannel functions
-- *****************************************************************************

function BeneCastUserChannel_OnTextChange()

	BeneCastConfig['UserChannel'] = this:GetText();

end

-- *****************************************************************************
-- BeneCastEditBox functions
-- *****************************************************************************

function BeneCastEditBox_ApplyChange()
	if this:GetName() then
		PutDebugMsg('boxname = ' .. this:GetName());
	else
		PutDebugMsg('boxname is nil');
		return;
	end
	for nr, comp in BCW_components do
		local found = nil;
		local targetno;
		if string.find(this:GetName(),'BeneCastPanel(.+)' .. comp) then
			_, _, targetno = string.find(this:GetName(),'BeneCastPanel(.+)' .. comp);
			if string.find(targetno,'Relative') then
				found = nil;
			else
				found = true;
			end
		end
		if found then
			local framename = 'BeneCastPanel' .. targetno;
			if BeneCastConfig.Debug then
				local msg = 'Updating BeneCastConfig[';
				if framename then
					msg = msg .. framename .. '][';
				else
					msg = msg .. 'nil][';
				end
				if comp then
					msg = msg .. comp .. ']';
				else
					msg = msg .. 'nil]';
				end
				PutDebugMsg(msg);
			end
			boxvalue = this:GetText();
			if boxvalue ~= BeneCastConfig[framename][comp] then
				BeneCastConfig['SnapTo'] = 'CUSTOM';
				UIDropDownMenu_SetSelectedValue(BeneCastSnapToMenu, 'CUSTOM');
				BeneCastConfig[framename][comp] = boxvalue;
				BeneCastConfig[framename]['Moved'] = false;
			end
			PutDebugMsg('Updating Panel ' .. targetno);
			BeneCast_AttachPanelsFromVar(tonumber(targetno));
			do break end;
		end
	end
end

-- *****************************************************************************
-- BeneCastSnapToMenu functions
-- *****************************************************************************

function BeneCastSnapToMenu_Initialize()
	
	local info;
	-- Add SnapTo options
	for snapto in BeneCast_SnapTo do
		if IsAddOnLoaded(BeneCast_SnapTo[snapto].AddOn) or snapto == 'CUSTOM' then
			info = {};
			if ( BeneCast_SnapTo[snapto].AddOn == 'BeneCast' ) then
				info.text = BENECAST_STRINGS.TEXT_STANDARD;
			elseif ( BeneCast_SnapTo[snapto].AddOn == 'Perl_Target' ) then
				info.text = BENECAST_STRINGS.TEXT_PERLCLASSIC;
			elseif ( snapto == 'CUSTOM' ) then
				info.text = 'Custom';
			else
				info.text = BeneCast_SnapTo[snapto].AddOn;
			end
			
			info.value = snapto;
			if ( BeneCastConfig.SnapTo == snapto ) then
				info.checked = true;
			else
				info.checked = false;
			end
			info.func = BeneCastSnapToMenu_SetSnap;
			UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
		end
	end

end

function SetBeneCastSnapTo(snapto_option)
	local found;
	for snaptoval in BeneCast_SnapTo do
		if BeneCast_SnapTo[snaptoval].AddOn == snapto_option then
			found = true;
			BeneCastConfig.SnapTo = snaptoval;
			BeneCast_SnapPanels(snapto_option);
			BeneCast_AttachPartyPanelsFromVar(); --WINTROW.6
			UIDropDownMenu_SetSelectedValue(BeneCastSnapToMenu, snaptoval);
			for i in BC_targets do
				BeneCast_UpdateButtons(i);
			end
			do break end;
		end
	end
	if not found then
		PutDebugMsg(snapto_option .. ' not found in predefined unit frames');
	end
end

function SetBeneCastSnapTo2(snapto_option)
	if ( not BeneCast_SnapTo[snapto_option] ) then
		PutDebugMsg(snapto_option .. ' not found in predefined unit frames');
		return;
	end
	BeneCastConfig.SnapTo = snapto_option;
	BeneCast_SnapPanels(BeneCast_SnapTo[snapto_option].AddOn);
	BeneCast_AttachPartyPanelsFromVar(); --WINTROW.6
	UIDropDownMenu_SetSelectedValue(BeneCastSnapToMenu, snapto_option);
	for i in BC_targets do
		BeneCast_UpdateButtons(i);
	end
end

function PutDebugMsg(msg)
	if ( BeneCastConfig['Debug'] and DEFAULT_CHAT_FRAME ) then
		DEFAULT_CHAT_FRAME:AddMessage('Debug: ' .. msg);
	end
end

function PutMsg(msg)
	if ( DEFAULT_CHAT_FRAME ) then
		DEFAULT_CHAT_FRAME:AddMessage(msg);
	end
end

function BeneCastSnapToMenu_SetSnap()

	if ( not this.value ) then
		return;
	end
	PutDebugMsg('Entered BeneCastSnapToMenu_SetSnap'); --WINTROW.6
	BeneCastConfig.SnapTo = this.value;
	PutDebugMsg('SnapTo = ' .. this.value); --WINTROW.6
	BeneCast_SnapPanels(BeneCast_SnapTo[this.value].AddOn);
	BeneCast_AttachPartyPanelsFromVar(); --WINTROW.6
	UIDropDownMenu_SetSelectedValue(BeneCastSnapToMenu, this.value);
	for i in BC_targets do
		BeneCast_UpdateButtons(i);
	end
	PutDebugMsg('Updated buttons'); --WINTROW.6

end

function BeneCastSnapToMenu_Load()

	UIDropDownMenu_Initialize(this, BeneCastSnapToMenu_Initialize);
	UIDropDownMenu_SetSelectedValue(this, BeneCastConfig.SnapTo);
	getglobal('BeneCastSnapToMenuLabel'):SetText(BENECAST_STRINGS.TEXT_SNAP_TO);
	BeneCastSnapToMenu.tooltip = BENECAST_STRINGS.TEXT_SNAP_TO_TOOLTIP;
	UIDropDownMenu_SetWidth(110, BeneCastSnapToMenu);

end

-- *****************************************************************************
-- BeneCastRaidSnapToMenu functions
-- *****************************************************************************

function BeneCastRaidSnapToMenu_Initialize()
	
	local info;
	-- Add SnapTo options
	for snapto in BeneCast_RaidSnapTo do
		if ( IsAddOnLoaded(BeneCast_RaidSnapTo[snapto].AddOn) ) then
			info = {};
			if ( BeneCast_RaidSnapTo[snapto].AddOn == 'BeneCast' ) then
				info.text = BENECAST_STRINGS.TEXT_STANDARD;
			else
				info.text = BeneCast_RaidSnapTo[snapto].AddOn;
			end
			-- Determine the position for BeneCast panels to snap to
			if ( string.find(snapto, 'BOTTOM') ) then
				info.text = info.text .. BENECAST_STRINGS.TEXT_BOTTOM;
			elseif ( string.find(snapto, 'LEFT') ) then
				info.text = info.text .. BENECAST_STRINGS.TEXT_LEFT;
			elseif ( string.find(snapto, 'RIGHT') ) then
				info.text = info.text .. BENECAST_STRINGS.TEXT_RIGHT;
			elseif ( string.find(snapto, 'TOP') ) then
				info.text = info.text .. BENECAST_STRINGS.TEXT_TOP;
			end
			
			info.value = snapto;
			if ( BeneCastConfig.RaidSnapTo == snapto ) then
				info.checked = true;
			else
				info.checked = false;
			end
			info.func = BeneCastRaidSnapToMenu_SetSnap;
			UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
		end
	end

end

function BeneCastRaidSnapToMenu_SetSnap()

	BeneCastConfig.RaidSnapTo = this.value;
	UIDropDownMenu_SetSelectedValue(BeneCastRaidSnapToMenu, this.value);
	BC_UpdateRaid = true;
	
end

function BeneCastRaidSnapToMenu_Load()

	UIDropDownMenu_Initialize(this, BeneCastRaidSnapToMenu_Initialize);
	UIDropDownMenu_SetSelectedValue(this, BeneCastConfig.RaidSnapTo);
	getglobal('BeneCastRaidSnapToMenuLabel'):SetText(BENECAST_STRINGS.TEXT_RAID_SNAP_TO);
	BeneCastRaidSnapToMenu.tooltip = BENECAST_STRINGS.TEXT_RAID_SNAP_TO_TOOLTIP;

end

-- *****************************************************************************
-- BeneCastOptionFrame functions
-- *****************************************************************************

function BeneCastOptionFrame_OnLoad()
	
	-- Binding labels
	BINDING_HEADER_BENECAST = 'BeneCast';
	BINDING_NAME_BENECAST_OPTIONS = BENECAST_STRINGS.TEXT_BENECAST_OPTIONS;
	BINDING_NAME_BENECAST_TOGGLE_BUFFS = BENECAST_STRINGS.TEXT_BENECAST_TOGGLE_BUFFS;
	BINDING_NAME_BENECAST_BUTTON1 = BENECAST_STRINGS.TEXT_BENECAST_BUTTON1;
	BINDING_NAME_BENECAST_BUTTON2 = BENECAST_STRINGS.TEXT_BENECAST_BUTTON2;
	BINDING_NAME_BENECAST_BUTTON3 = BENECAST_STRINGS.TEXT_BENECAST_BUTTON3;
	BINDING_NAME_BENECAST_BUTTON4 = BENECAST_STRINGS.TEXT_BENECAST_BUTTON4;
	BINDING_NAME_BENECAST_BUTTON5 = BENECAST_STRINGS.TEXT_BENECAST_BUTTON5;
	BINDING_NAME_BENECAST_BUTTON6 = BENECAST_STRINGS.TEXT_BENECAST_BUTTON6;
	BINDING_NAME_BENECAST_BUTTON7 = BENECAST_STRINGS.TEXT_BENECAST_BUTTON7;
	BINDING_NAME_BENECAST_BUTTON8 = BENECAST_STRINGS.TEXT_BENECAST_BUTTON8;
	BINDING_NAME_BENECAST_BUTTON9 = BENECAST_STRINGS.TEXT_BENECAST_BUTTON9;
	BINDING_NAME_BENECAST_BUTTON10 = BENECAST_STRINGS.TEXT_BENECAST_BUTTON10;
	SLASH_BENECAST1 = '/benecast';
	SLASH_BENECAST2 = '/bc';
	
	-- Setup the BeneCast Slash Command Handler
	SlashCmdList['BENECAST'] = function(msg)
		BeneCast_SlashCommandHandler(msg);
	end
	
	-- Set up the title in the option frame
	getglobal('BeneCastTitleText'):SetText(BENECAST_STRINGS.TEXT_TITLE);

	-- Check Tab 1 and show the Player spell selection subframe
	getglobal('BeneCastPlayerFrame'):Show();
	getglobal('BeneCastOptionFrameTab1'):SetChecked(1);
	getglobal('BeneCastOptionFrameTab1'):Disable();
	
	-- Setup Tab Text and Graphics
	getglobal('BeneCastOptionFrameTab1NormalTexture'):SetTexture('Interface\\Icons\\Spell_Nature_WispSplode');
	getglobal('BeneCastOptionFrameTab1').tooltipText = UnitName('player');
	
	getglobal('BeneCastOptionFrameTab2NormalTexture'):SetTexture('Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes');
	getglobal('BeneCastOptionFrameTab2NormalTexture'):SetTexCoord(0.7421875, 0.98828125, 0, 0.25);
	getglobal('BeneCastOptionFrameTab2').tooltipText = BENECAST_STRINGS.CLASS_DRUID;
	
	getglobal('BeneCastOptionFrameTab3NormalTexture'):SetTexture('Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes');
	getglobal('BeneCastOptionFrameTab3NormalTexture'):SetTexCoord(0, 0.25, 0.25, 0.5);
	getglobal('BeneCastOptionFrameTab3').tooltipText = BENECAST_STRINGS.CLASS_HUNTER;
	
	getglobal('BeneCastOptionFrameTab4NormalTexture'):SetTexture('Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes');
	getglobal('BeneCastOptionFrameTab4NormalTexture'):SetTexCoord(0.25, 0.49609375, 0, 0.25);
	getglobal('BeneCastOptionFrameTab4').tooltipText = BENECAST_STRINGS.CLASS_MAGE;
	
	getglobal('BeneCastOptionFrameTab5NormalTexture'):SetTexture('Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes');
	getglobal('BeneCastOptionFrameTab5NormalTexture'):SetTexCoord(0.49609375, 0.7421875, 0.25, 0.5);
	getglobal('BeneCastOptionFrameTab5').tooltipText = BENECAST_STRINGS.CLASS_PRIEST;
	
	getglobal('BeneCastOptionFrameTab6NormalTexture'):SetTexture('Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes');
	getglobal('BeneCastOptionFrameTab6NormalTexture'):SetTexCoord(0.49609375, 0.7421875, 0, 0.25);
	getglobal('BeneCastOptionFrameTab6').tooltipText = BENECAST_STRINGS.CLASS_ROGUE;
	
	getglobal('BeneCastOptionFrameTab7NormalTexture'):SetTexture('Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes');
	getglobal('BeneCastOptionFrameTab7NormalTexture'):SetTexCoord(0.7421875, 0.98828125, 0.25, 0.5);
	getglobal('BeneCastOptionFrameTab7').tooltipText = BENECAST_STRINGS.CLASS_WARLOCK;
	
	getglobal('BeneCastOptionFrameTab8NormalTexture'):SetTexture('Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes');
	getglobal('BeneCastOptionFrameTab8NormalTexture'):SetTexCoord(0, 0.25, 0, 0.25);
	getglobal('BeneCastOptionFrameTab8').tooltipText = BENECAST_STRINGS.CLASS_WARRIOR;
	
	local race, raceEn = UnitRace('player');
	
	if ( raceEn == 'Human' or raceEn == 'NightElf' or raceEn == 'Gnome' or raceEn == 'Dwarf' ) then
		getglobal('BeneCastOptionFrameTab9NormalTexture'):SetTexture('Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes');
		getglobal('BeneCastOptionFrameTab9NormalTexture'):SetTexCoord(0.0, 0.25, 0.5, 0.75);
		getglobal('BeneCastOptionFrameTab9').tooltipText = BENECAST_STRINGS.CLASS_PALADIN;
		getglobal('BeneCastOptionFrameTab12NormalTexture'):SetTexture('Interface\\Icons\\INV_Banner_02');
	else
		getglobal('BeneCastOptionFrameTab9NormalTexture'):SetTexture('Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes');
		getglobal('BeneCastOptionFrameTab9NormalTexture'):SetTexCoord(0.25, 0.49609375, 0.25, 0.5);
		getglobal('BeneCastOptionFrameTab9').tooltipText = BENECAST_STRINGS.CLASS_SHAMAN;
		getglobal('BeneCastOptionFrameTab12NormalTexture'):SetTexture('Interface\\Icons\\INV_Banner_03');
	end
	
	getglobal('BeneCastOptionFrameTab10NormalTexture'):SetTexture('Interface\\Icons\\INV_Misc_Wrench_01');
	getglobal('BeneCastOptionFrameTab10').tooltipText = BENECAST_STRINGS.TEXT_SETUP;
	
	getglobal('BeneCastOptionFrameTab11NormalTexture'):SetTexture('Interface\\Icons\\INV_Letter_08');
	getglobal('BeneCastOptionFrameTab11').tooltipText = BENECAST_STRINGS.TEXT_NOTIFICATION;
	
	getglobal('BeneCastOptionFrameTab12NormalTexture'):SetTexture('Interface\\Icons\\INV_Misc_Head_Dragon_01');
	getglobal('BeneCastOptionFrameTab12').tooltipText = BENECAST_STRINGS.TEXT_RAID;

	getglobal('BeneCastOptionFrameTab13NormalTexture'):SetTexture('Interface\\Icons\\INV_Misc_Wrench_02');
	getglobal('BeneCastOptionFrameTab13').tooltipText = 'Unit Frames';

end

-- *****************************************************************************
-- BeneCastMiniMapButton Game Event Handlers
-- *****************************************************************************

-- Clicks on the BeneCast button do different things
function BeneCastOptionFrameToggle(mouseButton)

	-- If the mouseButton is the left button toggle BeneCastFrame's visibility
	if ( mouseButton == 'LeftButton' ) then
		local frame = getglobal('BeneCastOptionFrame');
		if ( frame:IsVisible() ) then
			frame:Hide();
		else
			frame:Show();
		end
	end
	
end

function BeneCastMiniMap_OnMouseDown()

	if ( ( BeneCastConfig.Unlock ) and ( arg1 == 'LeftButton' ) ) then
		this:StartMoving();
		this.isMoving = true;
	end

end

function BeneCastMiniMap_OnLoad()

	this:RegisterEvent('ADDON_LOADED');

end

function BeneCastMiniMap_OnEvent()

	if ( event == 'ADDON_LOADED' and arg1 == 'BeneCast' ) then
		if ( BeneCastConfig.HideMinimap ) then
			getglobal('BeneCastMinimapButton'):Hide();
		end
	end

end

-- *****************************************************************************
-- BeneCast Action Slot scanning functions
-- *****************************************************************************

function BeneCast_ScanActionSlots()
	BC_actionslot_by_spell = {};
	BC_actionslot_by_slot = {};
	for slot = 1, 120 do
		BeneCast_ScanActionSlot(slot);
	end
end

function BeneCast_ScanActionSlot(slot)
	if slot ~= nil then
		-- First clean out old value
		if BC_actionslot_by_slot[slot] then
			local oldspelltype = BC_actionslot_by_slot[slot];
			BC_actionslot_by_slot[slot] = nil;
			if oldspelltype then
				BC_actionslot_by_spell[oldspelltype] = nil;
			end
		end
		-- Then detect new contents (if any)
		if GetActionTexture(slot) then
			-- use a tooltip
			BeneCast_Tooltip:ClearLines();
			BeneCast_Tooltip:SetAction(slot);
			local spelltype = nil;
			if BeneCast_TooltipTextLeft1:GetText() then
				if BeneCast_SpellTypes[BC_class][BeneCast_TooltipTextLeft1:GetText()] then
					spelltype = BeneCast_SpellTypes[BC_class][BeneCast_TooltipTextLeft1:GetText()];
				end
			end
			if spelltype then
				-- If it's a known spell, first clear out the old slot-value
				if BC_actionslot_by_spell[spelltype] then
					local oldslot = BC_actionslot_by_spell[spelltype];
					BC_actionslot_by_spell[spelltype] = nil;
					if oldslot then
						BC_actionslot_by_slot[oldslot] = nil;
					end
				end
				-- then insert new values
				BC_actionslot_by_slot[slot] = spelltype;
				BC_actionslot_by_spell[spelltype] = slot;
			end
		end
	end
end

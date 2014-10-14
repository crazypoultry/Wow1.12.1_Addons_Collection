--[[

IsCasting
	Library that tracks your casting details.

By Karl Isenberg (AnduinLothar)

Change Log:
v1.32
-Fixed SeaSpellbook registration error
v1.31
- fixed nil compare error
v1.3
- Fixed GetSpellCastTime, GetSpellCastStartTime, and GetSpellCastEndTime to all be in seconds and not milliseconds as they were incorrectly labled.
- Added IsCasting.RegisterForEvent(frame) for ''SPELLCAST_SUCCESS'' event emulation
- Added IsCasting.UnregisterForEvent(frame)
v1.2
- Fixed CastSpellByName hook spell name parsing
- Updated SeaSpellbook to 1.6
- Added SeaSpellbook scholar registration to ensure up to date data
v1.1
- Removed SeaPrint, since it was only used for debug
v1.0
- Initial Release

	$Id: IsCasting.lua 3705 2006-06-26 08:15:29Z karlkfi $
	$Rev: 3705 $
	$LastChangedBy: karlkfi $
	$Date: 2006-06-26 03:15:29 -0500 (Mon, 26 Jun 2006) $
	
--]]

local ISCASTING_NAME 			= "IsCasting"
local ISCASTING_VERSION 		= 1.32
local ISCASTING_LAST_UPDATED	= "August 7, 2006"
local ISCASTING_AUTHOR 			= "AnduinLothar"
local ISCASTING_EMAIL			= "karlkfi@cosmosui.org"
local ISCASTING_WEBSITE			= "http://www.wowwiki.com/IsCasting"

------------------------------------------------------------------------------
--[[ Embedded Sub-Library Load Algorithm ]]--
------------------------------------------------------------------------------

if (not IsCasting) then
	IsCasting = {};
end
local isBetterInstanceLoaded = ( IsCasting.version and IsCasting.version >= ISCASTING_VERSION );

if (not isBetterInstanceLoaded) then
	
	IsCasting.version = ISCASTING_VERSION;
	
	------------------------------------------------------------------------------
	--[[ Globals ]]--
	------------------------------------------------------------------------------
	
	IsCasting.DEBUG = false;
	IsCasting.DEBUG_CAST = false;
	
	IsCasting.CORPSE_TOOLTIP_REGEX = gsub(format(CORPSE_TOOLTIP, "0"), "(.*)0(.*)", "%1(.*)%2");
	IsCasting.SPELL_CAST_TIME_SEC_REGEX = gsub(format(SPELL_CAST_TIME_SEC, 0), "(.*)0(.*)", "%1(.*)%2");
	IsCasting.SPELL_RANGE_REGEX = gsub(format(SPELL_RANGE, 0), "(.*)0(.*)", "%1%%d%2");
	
	if (not IsCasting.SpellCompletionFrames) then
		IsCasting.SpellCompletionFrames = {};
	end
	
	------------------------------------------------------------------------------
	--[[ User Functions ]]--
	------------------------------------------------------------------------------
	
	-- 
	-- IsCasting.RegisterForEvent(frame)
	--
	--	Registers a frame for a emulated "SPELLCAST_SUCCESS" event. 
	--	The same as frame:RegisterEvent("SPELLCAST_SUCCESS") if it were a real WoW event.
	--	When calling the OnEvent function, arg1 = Spell Name, arg2 = Cast Time, arg3 = Target Name (nil for 'no target').
	--
	--	EX: IsCasting.RegisterForEvent(MyAddonFrame)
	--
	-- Args: 
	-- 	(table frame)
	--	frame - a WoW xml frame object
	-- 
	function IsCasting.RegisterForEvent(frame)
		local name = frame:GetName();
		IsCasting.SpellCompletionFrames[name] = true;
		IsCasting.SpellCompletion = true;
	end
	
	-- 
	-- IsCasting.UnregisterForEvent(frame)
	--
	--	Unregisters a frame for a emulated "SPELLCAST_SUCCESS" event. 
	--	The same as frame:UnregisterEvent("SPELLCAST_SUCCESS") if it were a real WoW event.
	--
	--	EX: IsCasting.UnregisterForEvent(MyAddonFrame)
	--
	-- Args: 
	-- 	(table frame)
	--	frame - a WoW xml frame object
	-- 
	function IsCasting.UnregisterForEvent(frame)
		local name = frame:GetName();
		IsCasting.SpellCompletionFrames[name] = nil;
		IsCasting.SpellCompletion = nil;
		for frameName, value in IsCasting.SpellCompletionFrames do
			IsCasting.SpellCompletion = true;
			break
		end
	end
	
	-- 
	-- PlayerIsCasting()
	--
	--	EX: if PlayerIsCasting() then doSomething(); end
	--
	-- Returns: 
	-- 	(Boolean isCasting)
	--	isCasting - 1 if casting, else nil
	-- 
	function PlayerIsCasting()
		return (IsCasting.isCasting and 1);
	end
	
	-- 
	-- IsCasting.GetTimeLeft()
	--
	--	EX: if (IsCasting.GetTimeLeft() > 2000) then doSomething(); end
	--
	-- Returns: 
	-- 	(Number timeLeft)
	--	timeLeft - time (in seconds) left if casting, else nil
	-- 
	function IsCasting.GetTimeLeft()
		if (PlayerIsCasting()) then		
			return IsCasting.spellCastEndTime - GetTime();
		end
	end
	
	-- 
	-- IsCasting.GetSpellCastTime()
	--
	--	EX: if (IsCasting.GetSpellCastTime() > 2000) then doSomething(); end
	--
	-- Returns: 
	-- 	(Number timeLeft)
	--	timeLeft - cast durration (in seconds) of current or last cast, nil if nothing has been cast yet
	-- 
	function IsCasting.GetSpellCastTime()
		return IsCasting.spellTime;
	end
	
	-- 
	-- IsCasting.GetReadableSpellCastTime()
	--
	--	EX: message(IsCasting.GetReadableSpellCastTime().."s Cast")
	--
	-- Returns: 
	-- 	(String timeLeft)
	--	timeLeft - readable cast durration (in seconds) of current or last cast, empty string if nothing has been cast yet
	-- 
	function IsCasting.GetReadableSpellCastTime()
		if (not IsCasting.spellTime) then
			return "";
		end
		return format(IsCasting.spellTime/1000, "%.1f");
	end
	
	-- 
	-- IsCasting.GetSpellCastStartTime()
	--
	--	EX: if (IsCasting.GetSpellCastStartTime() > (GetTime() - 5) ) then doSomething(); end
	--
	-- Returns: 
	-- 	(Number timeStarted)
	--	timeStarted -  time (according to GetTime()) when the current or last spell started casting, nil if nothing has been cast yet
	-- 
	function IsCasting.GetSpellCastStartTime()
		return IsCasting.spellCastStartTime;
	end
	
	-- 
	-- IsCasting.GetSpellCastEndTime()
	--
	--	EX: if (IsCasting.GetSpellCastEndTime() > (GetTime() - 5) ) then doSomething(); end
	--
	-- Returns: 
	-- 	(Number timeEnded)
	--	timeEnded -  time (according to GetTime()) when the last spell stopped casting, nil if nothing has been cast yet
	-- 
	function IsCasting.GetSpellCastEndTime()
		return IsCasting.spellCastEndTime;
	end
	
	-- 
	-- IsCasting.GetSpellName()
	--
	--	EX: message(IsCasting.GetSpellName())
	--
	-- Returns: 
	-- 	(String spellName)
	--	spellName - name of current or last spell cast, nil if nothing has been cast yet
	--
	-- Note:
	--	Can Be used in Sea.wow.spellbook.GetSpellIDByName to get more spell data if the spell is in your spellbook.
	--	EX: local id = Sea.wow.spellbook.GetSpellIDByName( IsCasting.GetSpellName(), BOOKTYPE_SPELL,  IsCasting.GetSpellRank() )
	-- 
	function IsCasting.GetSpellName()
		return IsCasting.spellName;
	end
	
	-- 
	-- IsCasting.GetSpellRank()
	--
	--	EX: message("("..RANK.." "..IsCasting.GetSpellRank()..")")
	--
	-- Returns: 
	-- 	(String spellRank)
	--	spellRank - rank of current or last spell cast, nil if nothing has been cast yet
	--
	function IsCasting.GetSpellRank()
		return IsCasting.spellRank;
	end
	-- 
	-- IsCasting.GetSpellTargetName()
	--
	--	EX: message(IsCasting.GetSpellTargetName())
	--
	-- Returns: 
	-- 	(String targetName)
	--	targetName - name of the target of the current or last spell, empty string if 'no target cast', nil if nothing has been cast yet
	-- 
	function IsCasting.GetSpellTargetName()
		return IsCasting.spellTargetName;
	end
	
	-- 
	-- IsCasting.GetSpellTexture()
	--
	--	EX: textureFrame:SetTexture( IsCasting.GetSpellTexture() )
	--
	-- Returns: 
	-- 	(String texturePath)
	--	texturePath - path of the texture of the current or last spell, nil if nothing has been cast yet
	-- 
	function IsCasting.GetSpellTexture()
		return IsCasting.spellTexture;
	end
	
	------------------------------------------------------------------------------
	--[[ Utility Functions ]]--
	------------------------------------------------------------------------------
	
	local function DebugPrint(var, ...)
		if (var) then
			table.foreachi(arg, function(k,v) arg[k] = tostring(v) end);
			DEFAULT_CHAT_FRAME:AddMessage(table.concat(arg), RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b);
		end
	end
	
	IsCasting.PVPRanks = {};
	for i=1, 19 do
		local rank = getglobal("PVP_RANK_"..i.."_0");
		IsCasting.PVPRanks[rank] = 1;
		rank = getglobal("PVP_RANK_"..i.."_0_FEMALE");
		IsCasting.PVPRanks[rank] = 1;
		rank = getglobal("PVP_RANK_"..i.."_1");
		IsCasting.PVPRanks[rank] = 1;
		rank = getglobal("PVP_RANK_"..i.."_1_FEMALE");
		IsCasting.PVPRanks[rank] = 1;
	end
	
	function IsCasting.StripPVPRank(name)
		local rank, shortName = string.gfind(name, "(.*) (%w+)")();
		if (rank and IsCasting.PVPRanks[rank]) then
			return shortName;
		else
			return name;
		end
	end
	
	
	function IsCasting.Register()
		local frame = IsCastingFrame;
		frame:RegisterEvent("SPELLCAST_START");
		frame:RegisterEvent("SPELLCAST_STOP");
		frame:RegisterEvent("SPELLCAST_FAILED");
		frame:RegisterEvent("SPELLCAST_INTERRUPTED");
		frame:RegisterEvent("SPELLCAST_DELAYED");
		frame:RegisterEvent("SPELLCAST_CHANNEL_START");
		frame:RegisterEvent("SPELLCAST_CHANNEL_UPDATE");
		frame:RegisterEvent("PLAYER_TARGET_CHANGED");
		Sea.util.hook("UseContainerItem", "IsCasting.UseContainerItem_Hook", "before");
		Sea.util.hook("CastSpell", "IsCasting.CastSpell_Hook", "before");
		Sea.util.hook("CastSpellByName", "IsCasting.CastSpellByName_Hook", "before");
		Sea.util.hook("UseAction", "IsCasting.UseAction_Hook", "before");
		Sea.util.hook("WorldFrame","IsCasting.CameraOrSelectOrMoveStop_Hook","before", "OnMouseUp");
		Sea.util.hook("SpellTargetUnit","IsCasting.TargetUnit_Hook", "before");
		Sea.util.hook("TargetUnit","IsCasting.TargetUnit_Hook", "before");
		Sea.util.hook("TargetByName","IsCasting.TargetByName_Hook", "before");
		Sea.util.hook("TargetLastTarget","IsCasting.TargetLastTarget_Hook", "before");
		if (CastOptions) and (CastOptions.CastAtUnit) then
			Sea.util.hook("CastOptions.CastAtUnit","IsCasting.TargetUnit_Hook", "after");
		end
		Sea.util.hook("TargetNearestFriend","IsCasting.TargetUnknown_Hook", "before");
		Sea.util.hook("TargetNearestPartyMember","IsCasting.TargetUnknown_Hook", "before");
		Sea.util.hook("TargetNearestRaidMember","IsCasting.TargetUnknown_Hook", "before");
		
		Sea.wow.spellbook.RegisterScholar( {id="IsCasting"} );
	end
	
	function IsCasting.Unregister()
		local frame = IsCastingFrame;
		frame:UnregisterEvent("SPELLCAST_START");
		frame:UnregisterEvent("SPELLCAST_STOP");
		frame:UnregisterEvent("SPELLCAST_FAILED");
		frame:UnregisterEvent("SPELLCAST_INTERRUPTED");
		frame:UnregisterEvent("SPELLCAST_DELAYED");
		frame:UnregisterEvent("SPELLCAST_CHANNEL_START");
		frame:UnregisterEvent("SPELLCAST_CHANNEL_UPDATE");
		frame:UnregisterEvent("PLAYER_TARGET_CHANGED");
		Sea.util.unhook("UseContainerItem", "IsCasting.UseContainerItem_Hook", "before");
		Sea.util.unhook("CastSpell", "IsCasting.CastSpell_Hook", "before");
		Sea.util.unhook("CastSpellByName", "IsCasting.CastSpellByName_Hook", "before");
		Sea.util.unhook("UseAction", "IsCasting.UseAction_Hook", "before");
		Sea.util.unhook("WorldFrame","IsCasting.CameraOrSelectOrMoveStop_Hook","before", "OnMouseUp");
		Sea.util.unhook("SpellTargetUnit","IsCasting.TargetUnit_Hook", "before");
		Sea.util.unhook("TargetUnit","IsCasting.TargetUnit_Hook", "before");
		Sea.util.unhook("TargetByName","IsCasting.TargetByName_Hook", "before");
		Sea.util.unhook("TargetLastTarget","IsCasting.TargetLastTarget_Hook", "before");
		if (CastOptions) and (CastOptions.CastAtUnit) then
			Sea.util.unhook("CastOptions.CastAtUnit","IsCasting.TargetUnit_Hook", "after");
		end
		Sea.util.unhook("TargetNearestFriend","IsCasting.TargetUnknown_Hook", "before");
		Sea.util.unhook("TargetNearestPartyMember","IsCasting.TargetUnknown_Hook", "before");
		Sea.util.unhook("TargetNearestRaidMember","IsCasting.TargetUnknown_Hook", "before");
		
		Sea.wow.spellbook.UnregisterScholar("IsCasting");
	end
	
	--------------------------------------------------
	-- Hook Functions For Recording Target
	--------------------------------------------------
	
	IsCasting.NoTarget = {};
	IsCasting.SelfCast = {
		----------------------------------------------------------------------
		-- Spells that should be cast on player if there is no friendly target
		----------------------------------------------------------------------
		--Set any of the options to a true value to set it
		--h - this spell heals
		--n - this spell boosts mana
		--b - this spell has a buff(including heal spells that do heal over time
		--p - this spell cures poison
		--c - this spell removes curses
		--d - this spell cures disease
		--m - this spell removes magic effects
		--r - this spell must have a range specifier in the tooltip to match
		--g - this spell can only be cast on group members
		--f - this spell is a first aid spell that channels
		--l - this spell is a blessing
		--t - the texture of the buff, if it is different from the spell
		DRUID = {
			["Interface\\Icons\\Spell_Nature_NullifyPoison_02"] = {p=1;b=1;};			--Abolish Poison
			["Interface\\Icons\\Spell_Nature_NullifyPoison"] = {p=1;};						--Cure Poison
			["Interface\\Icons\\Spell_Nature_HealingTouch"] = {h=1;};							--Healing Touch
			["Interface\\Icons\\Spell_Nature_Lightning"] = {b=1;n=1;};						--Innervate
			["Interface\\Icons\\Spell_Nature_Regeneration"] = {b=1;};							--Mark of the Wild
			["Interface\\Icons\\Spell_Nature_ResistNature"] = {h=1;b=1;};					--Regrowth
			["Interface\\Icons\\Spell_Nature_Rejuvenation"] = {h=1;b=1;};					--Rejuvenation
			["Interface\\Icons\\Spell_Holy_RemoveCurse"] = {c=1;r=1};							--Remove Curse
			["Interface\\Icons\\Spell_Nature_Thorns"] = {b=1;};										--Thorns
		};
		HUNTER = {
			--["Interface\\Icons\\"] = 0;	--
		};
		MAGE = {
			["Interface\\Icons\\Spell_Holy_FlashHeal"] = {b=1;g=1;};							--Amplify Magic
			["Interface\\Icons\\Spell_Holy_MagicalSentry"] = {b=1;};							--Arcane Intellect
			["Interface\\Icons\\Spell_Nature_AbolishMagic"] = {b=1;g=1;};					--Dampen Magic
			["Interface\\Icons\\Spell_Nature_RemoveCurse"] = {c=1;};							--Remove Lesser Curse
		};
		PALADIN = {
			["Interface\\Icons\\Spell_Holy_SealOfValor"] = {b=1;};								--Blessing of Freedom
			["Interface\\Icons\\Spell_Magic_MageArmor"] = {b=1;l=1;};							--Blessing of Kings
			["Interface\\Icons\\Spell_Holy_PrayerOfHealing02"] = {b=1;l=1;};			--Blessing of Light
			["Interface\\Icons\\Spell_Holy_FistOfJustice"] = {b=1;l=1;};					--Blessing of Might
			["Interface\\Icons\\Spell_Holy_SealOfProtection"] = {b=1;g=1;l=1;};		--Blessing of Protection
			["Interface\\Icons\\Spell_Holy_SealOfSacrifice"] = {b=1;r=1;l=1;};		--Blessing of Sacrifice
			["Interface\\Icons\\Spell_Holy_SealOfSalvation"] = {b=1;g=1;l=1;};		--Blessing of Salvation
			["Interface\\Icons\\Spell_Nature_LightningShield"] = {b=1;l=1;};			--Blessing of Sanctuary
			["Interface\\Icons\\Spell_Holy_SealOfWisdom"] = {b=1;n=1;l=1;};				--Blessing of Wisdom
			["Interface\\Icons\\Spell_Holy_Renew"] = {p=1;d=1;m=1;};							--Cleanse
			["Interface\\Icons\\Spell_Nature_TimeStop"] = {b=1;g=1;};							--Divine Intervention
			["Interface\\Icons\\Spell_Holy_FlashHeal"] = {h=1;};									--Flash of Light
			["Interface\\Icons\\Spell_Holy_HolyBolt"] = {h=1;};										--Holy Light
			["Interface\\Icons\\Spell_Holy_LayOnHands"] = {h=1;};									--Lay on Hands
			["Interface\\Icons\\Spell_Holy_Purify"] = {p=1;d=1;};									--Purify
		};
		PRIEST = {
			["Interface\\Icons\\Spell_Nature_NullifyDisease"] = {p=1;b=1;};				--Abolish Disease
			["Interface\\Icons\\Spell_Holy_NullifyDisease"] = {d=1;};							--Cure Disease
			["Interface\\Icons\\Spell_Holy_DispelMagic"] = {m=1;};								--Dispel Magic (neutral)
			["Interface\\Icons\\Spell_Holy_HolyProtection"] = {b=1;};							--Divine Spirit
			["Interface\\Icons\\Spell_Holy_Excorcism"] = {b=1;};									--Fear Ward
			["Interface\\Icons\\Spell_Holy_FlashHeal"] = {h=1;};									--Flash Heal
			["Interface\\Icons\\Spell_Holy_GreaterHeal"] = {h=1;};								--Greater Heal
			["Interface\\Icons\\Spell_Holy_Heal"] = {h=1;};												--Heal
			["Interface\\Icons\\Spell_Holy_Heal02"] = {h=1;};											--Heal
			["Interface\\Icons\\Spell_Holy_LesserHeal"] = {h=1;};									--Lesser Heal
			["Interface\\Icons\\Spell_Holy_LesserHeal02"] = {h=1;};								--Lesser Heal
			["Interface\\Icons\\Spell_Holy_WordFortitude"] = {b=1;};							--Power Word: Fortitude
			["Interface\\Icons\\Spell_Holy_PowerWordShield"] = {b=1;g=1;};				--Power Word: Shield
			["Interface\\Icons\\Spell_Holy_PrayerOfFortitude"] = {b=1;};					--Prayer of Fortitude
			["Interface\\Icons\\Spell_Holy_Renew"] = {h=1;};											--Renew
			["Interface\\Icons\\Spell_Shadow_AntiShadow"] = {b=1;};								--Shadow Protection
		};
		ROGUE = {
			--["Interface\\Icons\\"] = 0;	--
		};
		SHAMAN = {
			["Interface\\Icons\\Spell_Nature_HealingWaveGreater"] = {h=1;};				--Chain Heal
			["Interface\\Icons\\Spell_Nature_RemoveDisease"] = {d=1;};						--Cure Disease
			["Interface\\Icons\\Spell_Nature_NullifyPoison"] = {p=1;};						--Cure Poison
			["Interface\\Icons\\Spell_Nature_MagicImmunity"] = {h=1;};						--Healing Wave
			["Interface\\Icons\\Spell_Nature_HealingWaveLesser"] = {h=1;};				--Lesser Healing Wave
			["Interface\\Icons\\Spell_Shadow_DemonBreath"] = {b=1;};							--Water Breathing
			["Interface\\Icons\\Spell_Frost_WindWalkOn"] = {b=1;};								--Water Walking
		};
		WARLOCK = {
			["Interface\\Icons\\Spell_Shadow_DetectInvisibility"] = {b=1;};				--Detect Invisibility and Greater Invisibility
			["Interface\\Icons\\Spell_Shadow_DetectLesserInvisibility"] = {b=1;};	--Detect Lesser Invisibility
			["Interface\\Icons\\Spell_Shadow_DemonBreath"] = {b=1;};							--Unending Breath
		};
		WARRIOR = {
			--["Interface\\Icons\\"] = 0;	--
		};
		--List of any container items that should be self cast
		Container = {
			--First Aid
			["Interface\\Icons\\INV_Misc_Bandage_15"] = {h=1;f=1;};								--Linen Bandage
			["Interface\\Icons\\INV_Misc_Bandage_18"] = {h=1;f=1;};								--Heavy Linen Bandage
			["Interface\\Icons\\INV_Misc_Bandage_14"] = {h=1;f=1;};								--Wool Bandage
			["Interface\\Icons\\INV_Misc_Bandage_17"] = {h=1;f=1;};								--Heavy Wool Bandage
			["Interface\\Icons\\INV_Misc_Bandage_01"] = {h=1;f=1;};								--Silk Bandage
			["Interface\\Icons\\INV_Misc_Bandage_02"] = {h=1;f=1;};								--Heavy Silk Bandage
			["Interface\\Icons\\INV_Misc_Bandage_19"] = {h=1;f=1;};								--Mageweave Bandage
			["Interface\\Icons\\INV_Misc_Bandage_20"] = {h=1;f=1;};								--Heavy Mageweave Bandage
			["Interface\\Icons\\INV_Misc_Bandage_11"] = {h=1;f=1;};								--Runecloth Bandage
			["Interface\\Icons\\INV_Misc_Bandage_12"] = {h=1;f=1;};								--Heavy Runecloth Bandage
			["Interface\\Icons\\INV_Misc_Slime_01"] = {p=1;};											--Anti-Venom and Strong Anti-Venom
			--Scrolls
			--Prolly too indecisive to use
			--["Interface\\Icons\\INV_Scroll_01"] = {b=1;};													--Scroll of Spirit/Intellect
			--["Interface\\Icons\\INV_Scroll_02"] = {b=1;};													--Scroll of Agility/Strength
			--["Interface\\Icons\\INV_Scroll_0t"] = {b=1;};													--Scroll of Protection/Stamina
			--Misc
			["Interface\\Icons\\INV_Misc_Herb_04"] = {h=1;};											--Sprouted Frond
		};
	};
	
	
	function IsCasting.ScanTooltip(id, texture, container, book)
		if (container) then
			IsCastingTooltip:SetBagItem(container, id);			--set tooltip to container item
		elseif (book) then
			IsCastingTooltip:SetSpell(id, book);			--set our tooltip to the spellbook item
		else
			IsCastingTooltip:SetAction(id);				--set our tooltip to action bar item
		end
		
		local name = IsCastingTooltipTextLeft1:GetText();
		if (name) then		--Check for nil values in the spell name
			DebugPrint(IsCasting.DEBUG, "Scanning Tooltip...");
			IsCasting.spellName = name;		--Set spellName(Global) from the tooltip 
			IsCasting.spellTime = -1;		--Set spellTime(Global) = "nil" so we dont have a non string
			local castTime = IsCastingTooltipTextLeft2:GetText();
			local manaCost = IsCastingTooltipTextLeft3:GetText();
			local rank, tempTime, _;
			if (IsCastingTooltipTextRight1:IsShown()) then
				rank = IsCastingTooltipTextRight1:GetText();
				rank = string.gfind(rank, RANK.." (%d+)")();
			end
			IsCasting.spellRank = rank;
			if (castTime) then
				if (castTime == SPELL_CAST_TIME_INSTANT_NO_MANA or castTime == SPELL_CAST_TIME_INSTANT) then
					IsCasting.spellTime = 0;
				else
					_, _, tempTime = strfind(castTime, IsCasting.SPELL_CAST_TIME_SEC_REGEX)
					if (tempTime) then
						IsCasting.spellTime = tonumber(tempTime);
					end
				end
			end
			if (manaCost) and (IsCasting.spellTime == -1) then
				if (manaCost == SPELL_CAST_TIME_INSTANT_NO_MANA or manaCost == SPELL_CAST_TIME_INSTANT) then
					IsCasting.spellTime = 0;
				else
					_, _, tempTime = strfind(manaCost, IsCasting.SPELL_CAST_TIME_SEC_REGEX)
					if (tempTime) then
						IsCasting.spellTime = tonumber(tempTime);
					end
				end
			end
			DebugPrint(IsCasting.DEBUG, "Scan Result - spellName: ", IsCasting.spellName, " spellRank: ", IsCasting.spellRank, " spellTime: ", IsCasting.spellTime);
			--check if there is range on the spell otherwise it wont take a target.
			local range;
			if (IsCastingTooltipTextRight2:IsShown()) then
				range = IsCastingTooltipTextRight2:GetText();
			end
			if (range and strfind(range, IsCasting.SPELL_RANGE_REGEX)) then
				IsCasting.NoTarget[IsCasting.spellName] = nil;
				DebugPrint(IsCasting.DEBUG, "Scan Result - Requires Target - ", range);
			elseif (castTime and strfind(castTime, IsCasting.SPELL_RANGE_REGEX)) then
				IsCasting.NoTarget[IsCasting.spellName] = nil;
				DebugPrint(IsCasting.DEBUG, "Scan Result - Requires Target - ", castTime);
			elseif (not container) and (not book) and (GetActionText(id)) then
				--Slot is a macro
				IsCasting.NoTarget[IsCasting.spellName] = nil;
				DebugPrint(IsCasting.DEBUG, "Scan Result - '", IsCasting.spellName, "' is Macro ");
			elseif (IsCasting.SelfCast["Container"][texture]) then
				IsCasting.NoTarget[IsCasting.spellName] = nil;
				DebugPrint(IsCasting.DEBUG, "Scan Result - Requires Target - Inventory Cast");
			else
				IsCasting.NoTarget[IsCasting.spellName] = 1;
				DebugPrint(IsCasting.DEBUG, "Scan Result - No target ");
			end
			
			IsCastingTooltip:ClearLines()
			--Scan Successful.
			return true;
		end
	end
	
	function IsCasting.UnitFinder(texture, spellName, spellTime)
		DebugPrint(IsCasting.DEBUG, "UnitFinder : ", texture, spellName, spellTime);
		if (not spellName) then
			spellName=IsCasting.spellName;
		else
			IsCasting.spellName=spellName;
		end
		if (not spellTime) then
			spellTime = IsCasting.spellTime;
		elseif (spellTime == "1") then
			spellTime = SPELL_CAST_TIME_INSTANT_NO_MANA;
		else
			spellTime = -1;
		end
		IsCasting.isSpellInQueue = 1;
		IsCasting.SavedTarget = nil;
		if (IsCasting.NoTarget[spellName]) then
			IsCasting.isNoTargetCast = 1;
			return;
		else
			IsCasting.isNoTargetCast = nil;
		end
		
		local _, playerClass = UnitClass("player");
		
		--this handles anyspell when the player has a target and the spell already target someone
		if (not SpellIsTargeting()) then
			if (UnitExists("target")) then
				--casting on a friend
				if (UnitIsFriend("target","player")) then	
					DebugPrint(IsCasting.DEBUG, "Instacast fired friend");
					IsCasting.SavedTarget = UnitName("target");
				else
					DebugPrint(IsCasting.DEBUG, "Instacast fired nonfriend");
					if (IsCasting.SelfCast[playerClass][texture]) then
						--A healing spell is being cast on a enemy? The player must have selfCast
						IsCasting.SavedTarget = UnitName("player");
					else
						--A non heal must be on that target then
						IsCasting.SavedTarget = UnitName("target");
					end
				end
			elseif (spellTime == SPELL_CAST_TIME_INSTANT_NO_MANA or spellTime == SPELL_CAST_TIME_INSTANT) then
				--instant casts dont need to check for when the spell casts
				if (IsCasting.SelfCast[playerClass][texture]) then
					--the spell can be cast on the player
					IsCasting.SavedTarget = nil;
				end
			end
		else
			--SpellIsTargeting and then a different Spell is cast
			IsCasting.SavedTarget = UnitName("target");
		end
	end
	
	function IsCasting.UseContainerItem_Hook(container, id)
		DebugPrint(IsCasting.DEBUG, "UseContainerItem triped! container: ", container, " id: ", id);
		local texture = GetContainerItemInfo(container, id);
		IsCasting.spellTexture = texture;
		if (IsCasting.ScanTooltip(id, texture, container)) then
			IsCasting.UnitFinder(texture);
		end
	end
	
	function IsCasting.CastSpell_Hook(id, book)
		local spell, rank = GetSpellName(id, book);
		DebugPrint(IsCasting.DEBUG, "CastSpell = ", spell, " Rank = ", rank); 
		IsCasting.spellName = spell;
		IsCasting.spellTime = -1;
		IsCasting.spellRank = rank;
		local texture = GetSpellTexture(id, book);
		IsCasting.spellTexture = texture;
		if (IsCasting.ScanTooltip(id, texture, nil, book)) then
			IsCasting.UnitFinder(texture);
		end
	end
	
	function IsCasting.CastSpellByName_Hook(spell, onSelf)
		local _, tempSpell, rank;
		DebugPrint(IsCasting.DEBUG, "CastSpellByName:  ", spell, " onSelf = ", onSelf); 
		--Trim off any trailing semicolons and/or white space
		_, _, spell = strfind(spell, "^(.*);?%s*$");
		--Trim off any trailing ()
		while ( string.sub( spell, -2 ) == "()" ) do
			spell = string.sub( spell, 1, -3 );
		end
		--Get rid of any leading white space
		_, _, spell = strfind(spell, "^%s*(.*)$");
		-- Find the rank
		_, _, tempSpell, rank = strfind(spell, "(.*)%("..RANK.." (%d)%)$");
		if (tempSpell and rank) then
			spell = tempSpell;
			rank = tonumber(rank);
		else
			rank = 0;
		end
		local book = BOOKTYPE_SPELL;
		DebugPrint(IsCasting.DEBUG, "Getting Spell ID By Name:  name = \'", spell, "\' rank = \'", rank, "\'"); 
		local id = Sea.wow.spellbook.GetSpellIDByName(spell, book, rank);
		if (not id) then
			DebugPrint(IsCasting.DEBUG, "Spell ID By Name Not Found:  name = ", spell, " rank = ", rank); 
			return;
		end
		local spell, rank = GetSpellName(id, book);
		DebugPrint(IsCasting.DEBUG, "CastSpellByName = ", spell, " Rank = ", rank); 
		IsCasting.spellName = spell;
		IsCasting.spellTime = -1;
		IsCasting.spellRank = rank;
		local texture = GetSpellTexture(id, book);
		IsCasting.spellTexture = texture;
		if (onSelf) then
			IsCasting.SavedTarget = UnitName("player")
		else
			if (IsCasting.ScanTooltip(id, texture, nil, book)) then
				IsCasting.UnitFinder(texture);
			end
		end
	end
	
	function IsCasting.UseAction_Hook(id, number, onSelf)
		DebugPrint(IsCasting.DEBUG, "UseAction triped! id: ", id);
		local texture = GetActionTexture(id);
		IsCasting.spellTexture = texture;
		if (IsCasting.ScanTooltip(id, texture)) then
			IsCasting.UnitFinder(texture);
		end
		if (onSelf) then
			IsCasting.SavedTarget = UnitName("player");
		end
	end
	
	function IsCasting.CameraOrSelectOrMoveStop_Hook()
		-- trying to parse out name... (remember: corpse of ...)
		--if (SpellIsTargeting() and GameTooltip:IsShown() ) then
		if ( GameTooltip:IsShown() ) then
			local field = getglobal("GameTooltipTextLeft1");
			if( field and field:IsShown() ) then
				local name = field:GetText()
				-- Remove player rank
				name = IsCasting.StripPVPRank(name)
				 -- remove "Corpse of " from name...
				local tempName = gsub(name, IsCasting.CORPSE_TOOLTIP_REGEX, "%1");
				if (tempName) then
					-- casting on a corpse...
					name = tempName;
				end
				DebugPrint(IsCasting.DEBUG, "Cameraorselectormovestop name= "..name);
				IsCasting.SavedTarget = name;
			end
		end
	end
	
	--Used to hook TargetUnit, SpellTargetUnit and CastOptions.CastAtUnit
	function IsCasting.TargetUnit_Hook(unit)
		if (unit) then 
			DebugPrint(IsCasting.DEBUG, "Hooked target unit = ", unit);
			IsCasting.SavedTarget = UnitName(unit);
		else 
			DebugPrint(IsCasting.DEBUG, "Hooked target unit but no unit!?!"); 
		end
	end
	
	function IsCasting.TargetByName_Hook(name)
		if (name) then 
			DebugPrint(IsCasting.DEBUG, "Hooked TargetByName = ", name);
			IsCasting.SavedTarget = name;
		else 
			DebugPrint(IsCasting.DEBUG, "Hooked TargetByName but no name!?!"); 
		end
	end
	
	function IsCasting.TargetLastTarget_Hook()
		if (IsCasting.lastTarget) then
			DebugPrint(IsCasting.DEBUG, "Hooked TargetLastTarget = ", IsCasting.lastTarget);
			IsCasting.SavedTarget = IsCasting.lastTarget;
		end
	end
	
	--Used to hook TargetNearestFriend, TargetNearestPartyMember, TargetNearestRaidMember 
	function IsCasting.TargetUnknown_Hook()
		DebugPrint(IsCasting.DEBUG, "Hooked TargetUnknown");
		IsCasting.SavedTarget = nil;
	end

	
	------------------------------------------------------------------------------
	--[[ SPELLCAST_SUCCESS event emulation ]]--
	------------------------------------------------------------------------------
	
	function IsCasting.SimulateSpellcastSuccessEvent()
		if (IsCasting.SpellCompletion) then
			local func, frame;
			local eventtemp = event;
			local arg1temp = arg1;
			local arg2temp = arg2;
			local arg3temp = arg3;
			event = "SPELLCAST_SUCCESS";
			arg1 = IsCasting.spellName;
			arg2 = IsCasting.spellTime;
			arg3 = IsCasting.spellTargetName;
			
			for frameName, value in IsCasting.SpellCompletionFrames do
				frame = getglobal(frameName);
				func = frame:GetScript("OnEvent");
				func();
			end
			
			arg1 = arg1temp;
			arg2 = arg2temp;
			arg3 = arg3temp;
		end
	end
	
	
	------------------------------------------------------------------------------
	--[[ Frame Script Assignment ]]--
	------------------------------------------------------------------------------
	
	function IsCasting.OnEvent()
		if ( event == "SPELLCAST_START" ) then
			--arg1: Name
			--arg2: cast time
			DebugPrint(IsCasting.DEBUG, "SPELLCAST_START isNoTargetCast: ", IsCasting.isNoTargetCast, " SavedTarget: ", IsCasting.SavedTarget, " isSpellInQueue: ", IsCasting.isSpellInQueue);
			local target;
			if (IsCasting.isNoTargetCast) then
				target = "";
				IsCasting.isNoTargetCast = nil;
			elseif (IsCasting.SavedTarget) then 
				target = IsCasting.SavedTarget;
				IsCasting.SavedTarget = nil;
			else
				target = UnitName("player"); 
			end
			
			local rank = "";
			if (IsCasting.spellRank) then
				rank = " ("..RANK.." "..IsCasting.spellRank..")";
			end
			DebugPrint(IsCasting.DEBUG_CAST, "Casting: ", arg1, rank, " (", arg2, "ms) on \"", target, "\". Texture: ", IsCasting.spellTexture );
			IsCasting.spellTargetName = target;
			IsCasting.spellName = arg1;
			IsCasting.spellTime = arg2;
			
			local time = GetTime()
			IsCasting.spellCastStartTime = time;
			IsCasting.spellCastEndTime = time + arg2/1000;
			IsCasting.isCasting = true;
			
			IsCasting.isSpellInQueue = nil;
			--IsCasting.spellTexture = nil;
			
		elseif ( event == "SPELLCAST_STOP" ) then
			if (IsCasting.isSpellInQueue) and (IsCasting.spellTime == 0) then
				local target;
				if (IsCasting.isNoTargetCast) then
					target = "";
					IsCasting.isNoTargetCast = nil;
				elseif (IsCasting.SavedTarget) then 
					target = IsCasting.SavedTarget;
					IsCasting.SavedTarget = nil;
				else
					target = UnitName("player");
				end
				
				local rank = "";
				if (IsCasting.spellRank) then
					rank = " ("..RANK.." "..IsCasting.spellRank..")";
				end
				DebugPrint(IsCasting.DEBUG_CAST, "Casting: ", IsCasting.spellName, rank, " (Instant) on \"", target, "\". Texture: ", IsCasting.spellTexture );
				IsCasting.spellTargetName = target;
				local time = GetTime();
				IsCasting.spellCastStartTime = time;
				IsCasting.spellCastEndTime = time;
				
				IsCasting.SimulateSpellcastSuccessEvent();
				
			elseif (IsCasting.spellCastEndTime and IsCasting.spellCastEndTime <= GetTime()) then
				IsCasting.SimulateSpellcastSuccessEvent();
				
			end
			
			--IsCasting.spellTargetName = nil;
			--IsCasting.spellCastStartTime = nil;
			--IsCasting.spellCastEndTime = nil;
			IsCasting.isCasting = nil;
			IsCasting.SavedTarget = nil; 
			IsCasting.isSpellInQueue = nil;
			
		elseif ( event == "SPELLCAST_FAILED" or event == "SPELLCAST_INTERRUPTED" ) then
			IsCasting.isSpellInQueue = nil;
			--IsCasting.SavedTarget = nil;
			--IsCasting.spellCastStartTime = nil;
			IsCasting.spellCastEndTime = GetTime();
			--IsCasting.spellTargetName = nil;
			IsCasting.isCasting = nil;
			
		elseif ( event == "SPELLCAST_DELAYED" ) then
			--arg1: delayed time
			IsCasting.spellCastEndTime = IsCasting.spellCastEndTime + arg1/1000;
			
		elseif ( event == "SPELLCAST_CHANNEL_START" ) then
			--arg1: cast time
			--arg2: "Channeling"
			DebugPrint(IsCasting.DEBUG, "SPELLCAST_CHANNEL_START isNoTargetCast: ", IsCasting.isNoTargetCast, " SavedTarget: ", IsCasting.SavedTarget, " isSpellInQueue: ", IsCasting.isSpellInQueue);
			local target;
			if (IsCasting.isNoTargetCast) then
				target = "";
				IsCasting.isNoTargetCast = nil;
			elseif (IsCasting.SavedTarget) then 
				target = IsCasting.SavedTarget;
				IsCasting.SavedTarget = nil;
			else
				target = UnitName("player"); 
			end
			
			local rank = "";
			if (IsCasting.spellRank) then
				rank = " ("..RANK.." "..IsCasting.spellRank..")";
			end
			DebugPrint(IsCasting.DEBUG_CAST, "Channeling: ", IsCasting.spellName, rank, " (", arg1, "ms) on \"", target, "\". Texture: ", IsCasting.spellTexture );
			IsCasting.spellTargetName = target;
			IsCasting.spellTime = arg1;
			
			local time = GetTime()
			IsCasting.spellCastStartTime = time;
			IsCasting.spellCastEndTime = time + arg1/1000;
			IsCasting.isCasting = true;
			
			IsCasting.isSpellInQueue = nil;
			--IsCasting.spellTexture = nil;
			
		elseif ( event == "SPELLCAST_CHANNEL_UPDATE" ) then
			--arg1: delayed time
			IsCasting.spellCastEndTime = IsCasting.spellCastEndTime + arg1/1000;
			
		elseif ( event == "PLAYER_TARGET_CHANGED" ) then
			IsCasting.isSpellInQueue = nil;
			if (IsCasting.currentTarget) and (IsCasting.currentTarget ~= UnitName("target")) then
				IsCasting.lastTarget = IsCasting.currentTarget;
			elseif (not IsCasting.lastTarget) then
				IsCasting.lastTarget = UnitName("target");
			end
			IsCasting.currentTarget = UnitName("target");
			
		end
	end
	
	--Event Driver
	if (not IsCastingFrame) then
		CreateFrame("Frame", "IsCastingFrame");
	end
	IsCastingFrame:Hide();
	--Frame Scripts
	IsCastingFrame:SetScript("OnEvent", IsCasting.OnEvent);
	
	--Enable (Mask 'this')
	local tempThis = this;
	this = IsCastingFrame;
	IsCasting.Register();
	this = tempThis
	
	--Mining Tooltip
	local tooltip = CreateFrame("GameTooltip", "IsCastingTooltip", nil, "GameTooltipTemplate");
	tooltip:SetOwner(tooltip, "ANCHOR_NONE");
	
end

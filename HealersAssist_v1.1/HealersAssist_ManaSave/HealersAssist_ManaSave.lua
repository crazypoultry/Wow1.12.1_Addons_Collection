--[[
  Healers Assist Plugin by Alason aka Freddy
  -= Mana Save =-
]]

--------------- Saved variables ---------------

--------------- Shared Constantes ---------------

HA_MS_NAME = "Mana Save";
HA_MS_MODE_DISABLED = 0;
HA_MS_MODE_RELATIVE = 1;
HA_MS_MODE_ABSOLUTE = 2;

--------------- Local Constantes ---------------

--------------- Local variables ---------------

--------------- Internal functions ---------------

local function _HA_MS_Plugin_OnEvent(event,params)
	if(event == HA_EVENT_PLUGIN_LOAD)
	then
		if(not HA_Config.Plugins[HA_MS_NAME])
		then
			HA_Config.Plugins[HA_MS_NAME] = {};
		end
		if(not HA_Config.Plugins[HA_MS_NAME].Spells)
		then
			HA_Config.Plugins[HA_MS_NAME].Spells = {};
		end
		if(HA_MyselfRaider)
		then
			_HA_MS_ScanForMissingSpells()
		end
	elseif(event == HA_EVENT_RAIDER_JOINED)
	then
		if(params[1] == HA_PlayerName)
		then
			_HA_MS_ScanForMissingSpells()
		end
  elseif(event == HA_EVENT_USE_ACTION)
  then
  	HA_MS_DoManaSave();
  elseif(event == HA_EVENT_CAST_SPELL)
  then
  	HA_MS_DoManaSave();
  elseif(event == HA_EVENT_CAST_SPELL_BY_NAME)
  then
  	HA_MS_DoManaSave();
  end
end

function _HA_MS_ScanForMissingSpells()
	HA_ChatDebug(HA_DEBUG_GLOBAL,"ManaSave: Scanning for new spells");
	for spellname, tab in HA_Spells do
		if(not HA_Config.Plugins[HA_MS_NAME].Spells[tab.iname] and not tab.nonheal and not tab.group and HA_IsSpellClass(tab.iname, HA_MyselfRaider.class))
		then
			HA_Config.Plugins[HA_MS_NAME].Spells[tab.iname] = {};
			HA_Config.Plugins[HA_MS_NAME].Spells[tab.iname].relative = 20;
			HA_Config.Plugins[HA_MS_NAME].Spells[tab.iname].absolute = floor(HA_SpellRanks[tab.iname][getn(HA_SpellRanks[tab.iname])].base * 0.8);
			HA_Config.Plugins[HA_MS_NAME].Spells[tab.iname].mintime = 0.5;
			HA_Config.Plugins[HA_MS_NAME].Spells[tab.iname].mode = HA_MS_MODE_RELATIVE;
		end
	end
end

local function _HA_MS_Plugin_OnConfigure()
	HA_MS_ConfFrame:Show();
end

--------------- Plugin structure ---------------

HA_MS_Plugin = {
  Name = HA_MS_NAME;
  OnEvent = _HA_MS_Plugin_OnEvent;
  OnConfigure = _HA_MS_Plugin_OnConfigure;
};  

--------------- XML functions ---------------

function HA_MS_Config_OnShow()
	for i=1, 10 do
		getglobal("HA_MS_ConfFrameSpellListSpell"..i):Hide();
		getglobal("HA_MS_ConfFrameSpellListSpell"..i).ISpell = nil;
	end
	local index = 1;
	for ISpell, tab in HA_Config.Plugins[HA_MS_NAME].Spells do
		local frame = "HA_MS_ConfFrameSpellListSpell"..index;
		getglobal(frame).ISpell = ISpell;
		getglobal(frame.."SpellName"):SetText(HA_GetLocalName(ISpell));
		getglobal(frame.."MinTimeEB"):SetText(tab.mintime or 0.5);
		getglobal(frame.."MinTimeEB").last = tab.mintime or 0.5;
		getglobal(frame.."RelativeEB"):SetNumber(tab.relative or 0);
		getglobal(frame.."RelativeCB"):SetChecked(0);
		getglobal(frame.."AbsoluteEB"):SetNumber(tab.absolute or 0);
		getglobal(frame.."AbsoluteCB"):SetChecked(0);
		
		if(tab.mode == HA_MS_MODE_RELATIVE)
		then
			getglobal(frame.."RelativeCB"):SetChecked(1);
		elseif(tab.mode == HA_MS_MODE_ABSOLUTE)
		then
			getglobal(frame.."AbsoluteCB"):SetChecked(1);
		end
		getglobal(frame):Show();
		index = index + 1;
	end
	HA_MS_ConfFrameSpellList:SetHeight(40+16*(index-1));
	HA_MS_ConfFrame:SetHeight(105+16*(index-1));
end

function HA_MS_Config_Save()
	for i=1, 10 do
		local frame = "HA_MS_ConfFrameSpellListSpell"..i;
		local ISpell = getglobal(frame).ISpell;
		if(ISpell)
		then
			local mintime = getglobal(frame.."MinTimeEB"):GetText();
			if(mintime == "")
			then
				mintime = 0;
			end
			local mintime = tonumber(mintime);
			local tab = HA_Config.Plugins[HA_MS_NAME].Spells[ISpell];
			tab.mintime = mintime or 0.5;
			tab.relative = getglobal(frame.."RelativeEB"):GetNumber();
			tab.absolute = getglobal(frame.."AbsoluteEB"):GetNumber();
			if(getglobal(frame.."RelativeCB"):GetChecked())
			then
				tab.mode = HA_MS_MODE_RELATIVE;
			elseif(getglobal(frame.."AbsoluteCB"):GetChecked())
			then
				tab.mode = HA_MS_MODE_ABSOLUTE;
			else
				tab.mode = HA_MS_MODE_DISABLED;
			end
		end
	end
end

--------------- Init functions ---------------

function HA_MS_OnLoad()
  HA_RegisterPlugin(HA_MS_Plugin);
end

--------------- Shared functions ---------------

-- returns the current casting time or 0 if you're not casting
function HA_MS_GetMyCastingTime()
	if(not HA_MyselfHealer or HA_MyselfHealer.State ~= HA_STATE_CASTING or not HA_MyselfHealer.StartTime or not HA_MyselfHealer.CastTime) then
		return 0;
	else
		local casttime = HA_CurrentTime - HA_MyselfHealer.StartTime;
		return casttime;
	end
end

-- returns 0 if no mana save was done or 1 if spell was aborted
function HA_MS_DoManaSave()
	if(HA_MyselfHealer.State == HA_STATE_CASTING and HA_MyselfHealer.SpellCode and HA_MyselfHealer.TargetName and not HA_MyselfHealer.NonHeal and not HA_MyselfHealer.GroupHeal)
	then
		local targetname = HA_MyselfHealer.TargetName;
		local spell = HA_Config.Plugins[HA_MS_NAME].Spells[HA_MyselfHealer.SpellCode];
		if(spell.mode ~= HA_MS_MODE_DISABLED and HA_Raiders[targetname] and HA_MS_GetMyCastingTime() > spell.mintime)
		then
			local abort = false;
			if(spell.mode == HA_MS_MODE_RELATIVE)
			then
				if(HA_MyselfHealer.OverHealPercent > spell.relative)
				then
					abort = true;
					HA_ChatDebug(HA_DEBUG_GLOBAL,"ManaSave aborted: Mode=RELATIVE, Target="..tostring(targetname)..", EstimatedOverheal="..tostring(HA_MyselfHealer.OverHealPercent)..", MaxAllowed="..tostring(spell.relative));
				end
			elseif(spell.mode == HA_MS_MODE_ABSOLUTE)
			then
				local hpdiff = HA_Raiders[targetname].hpmax - HA_Raiders[targetname].hp;
				if(spell.absolute > hpdiff)
				then
					abort = true;
					HA_ChatDebug(HA_DEBUG_GLOBAL,"ManaSave aborted: Mode=ABSOLUTE, Target="..tostring(targetname)..", HPDiff="..tostring(hpdiff)..", MinDiffNeeded="..tostring(spell.absolute));
				end
			end
			if(abort)
			then
				SpellStopCasting();
				return 1;
			end
		end
	end
	return 0;
end

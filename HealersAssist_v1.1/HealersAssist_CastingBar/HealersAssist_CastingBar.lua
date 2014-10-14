
--[[
  Healers Assist Plugin by Alason aka Freddy
  -= CastingBar =-
]]

--------------- Local Constantes ---------------

HA_CB_NAME = "CastingBar";

--------------- Local variables ---------------

local HA_CB_Old_eCastingBar_OnUpdate;
local HA_CB_Old_CastingBarFrame_OnUpdate;
local HA_CB_Old_StatRingsCasting_OnUpdate;
local HA_CB_Old_CastingBarFrame_OnUpdate;

--------------- Internal functions -------------

local function _HA_CB_Plugin_OnConfigure()
	local frame = "HealersAssist_CastingBar_Options";
	getglobal(frame.."Pattern"):SetText(HA_Config.Plugins[HA_CB_NAME].CastingBarText);
	getglobal(frame.."Color_Status"):SetChecked(HA_Config.Plugins[HA_CB_NAME].Colors.Status or 0);
	getglobal(frame.."Color_OverhealTexture"):SetTexture("Interface\\TargetingFrame\\UI-StatusBar");
	getglobal(frame.."Color_OverhealTexture"):SetVertexColor(unpack(HA_Config.Plugins[HA_CB_NAME].Colors["overheal"]));
	getglobal(frame.."Color_NormalTexture"):SetTexture("Interface\\TargetingFrame\\UI-StatusBar");
	getglobal(frame.."Color_NormalTexture"):SetVertexColor(unpack(HA_Config.Plugins[HA_CB_NAME].Colors["normal"]));
	getglobal(frame):Show();
end

local function HA_CB_eCastingBar_OnUpdate(frame)
	HA_CB_Old_eCastingBar_OnUpdate(frame);
	if(this.casting)
	then
		HA_CB_UpdateCastingBarText("eCastingBarText");
		HA_CB_UpdateCastingBarColor("eCastingBarStatusBar");
	end
end

local function HA_CB_CastingBarFrame_OnUpdate()
	HA_CB_Old_CastingBarFrame_OnUpdate();
	if(this.casting)
	then
		HA_CB_UpdateCastingBarText("CastingBarText");
		HA_CB_UpdateCastingBarColor("CastingBarFrame");
	end
end

local function HA_CB_StatRingsCasting_OnUpdate(arg1)
	HA_CB_Old_StatRingsCasting_OnUpdate(arg1);
	if(sm_UnitFramesConfig and sm_UnitFramesConfig["showcastingtext"] and (sm_UnitFramesConfig["showcastingtext"] == "yes") and this.casting)
	then
		HA_CB_UpdateCastingBarText("smUnitFrameCasting");
	end
end

local function _HA_CB_Plugin_OnEvent(event,params)
  if(event == HA_EVENT_PLUGIN_LOAD)
  then
  	if(not HA_Config.Plugins[HA_CB_NAME])
  	then
  		HA_Config.Plugins[HA_CB_NAME] = {};
  	end
  	if(not HA_Config.Plugins[HA_CB_NAME].CastingBarText)
		then
			HA_Config.Plugins[HA_CB_NAME].CastingBarText = (HA_CB_CastingBarText or "@shortspellname > @target (@estimated)"); -- try to load pattern from old variable
		end
		if(not HA_Config.Plugins[HA_CB_NAME].Colors)
		then
			HA_Config.Plugins[HA_CB_NAME].Colors = {["status"] = true, ["normal"] = {0,1,0,1}, ["overheal"] = {1,0,0,1}};
		end
  
  	if(not HA_CB_Old_eCastingBar_OnUpdate and eCastingBar_OnUpdate)
		then
			HA_CB_Old_eCastingBar_OnUpdate = eCastingBar_OnUpdate;
		end
		if(not HA_CB_Old_CastingBarFrame_OnUpdate and CastingBarFrame_OnUpdate)
		then
			HA_CB_Old_CastingBarFrame_OnUpdate = CastingBarFrame_OnUpdate;
		end
		if(not HA_CB_Old_StatRingsCasting_OnUpdate and StatRingsCasting)
		then
			HA_CB_Old_StatRingsCasting_OnUpdate = StatRingsCasting:GetScript("OnUpdate");
		end
		
  	CastingBarFrame_OnUpdate = HA_CB_CastingBarFrame_OnUpdate;
  	if(eCastingBar_OnUpdate)
  	then
  		eCastingBar_OnUpdate = HA_CB_eCastingBar_OnUpdate;
  	end
  	if(StatRingsCasting)
  	then
			StatRingsCasting:SetScript("OnUpdate", HA_CB_StatRingsCasting_OnUpdate); 
  	end
  	
  elseif(event == HA_EVENT_PLUGIN_UNLOAD)
  then
  	CastingBarFrame_OnUpdate = HA_CB_Old_CastingBarFrame_OnUpdate;
  	if(HealersAssist_CastingBar_OnUpdate)
  	then
  		HealersAssist_CastingBar_OnUpdate = HA_CB_Old_eCastingBar_OnUpdate;
  	end
  	if(StatRingsCasting)
  	then
  		StatRingsCasting:SetScript("OnUpdate", HA_CB_Old_StatRingsCasting_OnUpdate); 
  	end
  end
end

--------------- Plugin structure ---------------

HA_CB_Plugin = {
  Name = HA_CB_NAME;
  OnConfigure = _HA_CB_Plugin_OnConfigure;
  OnEvent = _HA_CB_Plugin_OnEvent;
};

--------------- XML functions ---------------

function HealersAssist_CastingBar_Options_Save()
	local pattern = HealersAssist_CastingBar_OptionsPattern:GetText();
	local colorstatus = HealersAssist_CastingBar_OptionsColor_Status:GetChecked();
	HA_Config.Plugins[HA_CB_NAME].CastingBarText = pattern;
	HA_Config.Plugins[HA_CB_NAME].Colors.Status = colorstatus;
	HA_ChatDebug(HA_DEBUG_GLOBAL,"HealersAssist_CastingBar_Options_Save NewPattern="..tostring(pattern).." NewColorStatus="..tostring(colorstatus));
end

function HealersAssist_CastingBar_ColorPicker_OnClick()
	if (ColorPickerFrame:IsShown()) then
		HealersAssist_CastingBar_ColorPicker_Cancelled(ColorPickerFrame.previousValues);
		ColorPickerFrame:Hide();
  else
    local Red, Green, Blue, Alpha = unpack(HA_Config.Plugins[HA_CB_NAME].Colors[this.colorkey]);
		ColorPickerFrame.previousValues = {Red, Green, Blue, Alpha};
		ColorPickerFrame.cancelFunc = HealersAssist_CastingBar_ColorPicker_Cancelled;
		ColorPickerFrame.opacityFunc = HealersAssist_CastingBar_ColorPicker_OpacityChanged;
		ColorPickerFrame.func = HealersAssist_CastingBar_ColorPicker_ColorChanged;
		ColorPickerFrame.index = this:GetName().."Texture";
		ColorPickerFrame.colorkey = this.colorkey;
		ColorPickerFrame.hasOpacity = true;
		ColorPickerFrame.opacity = Alpha;
		ColorPickerFrame:SetColorRGB(Red, Green, Blue);
		ColorPickerFrame:ClearAllPoints();
		local x = HealersAssist_CastingBar_Options:GetCenter();
		if (x < UIParent:GetWidth() / 2)
		then
			ColorPickerFrame:SetPoint("TOP", "HealersAssist_CastingBar_Options", "BOTTOM", -15, 0);
		else
			ColorPickerFrame:SetPoint("RIGHT", "HealersAssist_CastingBar_Options", "LEFT", 0, 0);
		end
    ColorPickerFrame:Show()
  end
end

function HealersAssist_CastingBar_ColorPicker_Cancelled(color)
	HA_Config.Plugins[HA_CB_NAME].Colors[ColorPickerFrame.colorkey] = color;
  getglobal(ColorPickerFrame.index):SetVertexColor(unpack(color));
end

function HealersAssist_CastingBar_ColorPicker_OpacityChanged()
	local r, g, b = ColorPickerFrame:GetColorRGB();
	local a = OpacitySliderFrame:GetValue();
	getglobal(ColorPickerFrame.index):SetVertexColor(r, g, b, a);
end

function HealersAssist_CastingBar_ColorPicker_ColorChanged()
	local r, g, b = ColorPickerFrame:GetColorRGB();
	local a = OpacitySliderFrame:GetValue();
	getglobal(ColorPickerFrame.index):SetVertexColor(r,g,b,a);
	if(not ColorPickerFrame:IsShown())
	then
		HA_Config.Plugins[HA_CB_NAME].Colors[ColorPickerFrame.colorkey] = {r,g,b,a};
	end
end

--------------- Init functions ---------------

function HA_CB_OnLoad()
  HA_RegisterPlugin(HA_CB_Plugin);
end

--------------- Shared functions ---------------

function HA_CB_UpdateCastingBarText(TextFrame)
	if(TextFrame and HA_MyselfHealer and HA_MyselfHealer.State == HA_STATE_CASTING)
	then
		local target; 
		if(HA_MyselfHealer.GroupHeal) -- it's a group heal
		then
			target = PARTY;
		else
			target = HA_MyselfHealer.TargetName;
		end
		local raider = HA_Raiders[target] or {};
		local totalestimatedheal = 0;
		for ehealer, evalue in raider.estimates or {}
		do
			totalestimatedheal = totalestimatedheal + (tonumber(evalue) * (raider.estimate_ratio or 1));
		end
		local estimate_ratio = 100;
		if(raider.estimate_ratio)
		then
			estimate_ratio = raider.estimate_ratio * 100
		end
		local text = HA_Config.Plugins[HA_CB_NAME].CastingBarText;
		text = gsub(text, "@rank", HA_MyselfHealer.SpellRank or "0");
		text = gsub(text, "@spellname", HA_MyselfHealer.SpellName or "-");
		text = gsub(text, "@shortspellname", HA_MyselfHealer.ShortSpellName or "-");
		text = gsub(text, "@casttime", HA_MyselfHealer.CastTime or "0.0");
		text = gsub(text, "@estimated", floor((HA_MyselfHealer.Estimate or 0) * (raider.estimate_ratio or 1)));
		text = gsub(text, "@target", target or "");
		text = gsub(text, "@overhealpercent", format("%d", HA_MyselfHealer.OverHealPercent or 0));
		text = gsub(text, "@hpmax", raider.hpmax or 0);
		text = gsub(text, "@hpdiff", ((raider.hpmax or 0) - (raider.hp or 0)));
		text = gsub(text, "@hp", (raider.hp or 0));
		text = gsub(text, "@healcount", raider.count or 0);
		text = gsub(text, "@estimateratio", estimate_ratio);
		text = gsub(text, "@totalestimatedheal", totalestimatedheal);
		text = gsub(text, "@n", "\n");
		getglobal(TextFrame):SetText(text);
	end
end

function HA_CB_UpdateCastingBarColor(StatusBarFrame)
	if(not HA_MS_NAME or not HA_Config.Plugins[HA_MS_NAME] or not HA_Config.Plugins[HA_CB_NAME].Colors.Status) then
		return;
	end
	if(HA_MyselfHealer.State == HA_STATE_CASTING and HA_MyselfHealer.SpellCode and HA_MyselfHealer.TargetName and not HA_MyselfHealer.NonHeal and not HA_MyselfHealer.GroupHeal)
	then
		local targetname = HA_MyselfHealer.TargetName;
		local spell = HA_Config.Plugins[HA_MS_NAME].Spells[HA_MyselfHealer.SpellCode];
		if(spell and spell.mode ~= HA_MS_MODE_DISABLED and HA_Raiders[targetname])
		then
			local overheal = false;
			if(spell.mode == HA_MS_MODE_RELATIVE)
			then
				if(HA_MyselfHealer.OverHealPercent > spell.relative)
				then
					overheal = true;
				end
			elseif(spell.mode == HA_MS_MODE_ABSOLUTE)
			then
				local hpdiff = HA_Raiders[targetname].hpmax - HA_Raiders[targetname].hp;
				if(spell.absolute > hpdiff)
				then
					overheal = true;
				end
			end
			if(overheal)
			then
				getglobal(StatusBarFrame):SetStatusBarColor(unpack(HA_Config.Plugins[HA_CB_NAME].Colors["overheal"]));
				return true;
			else
				getglobal(StatusBarFrame):SetStatusBarColor(unpack(HA_Config.Plugins[HA_CB_NAME].Colors["normal"]));
				return false;
			end
		end
	end
end


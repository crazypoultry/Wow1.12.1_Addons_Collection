local function debug(...)
   local msg = ''
   for k,v in ipairs(arg) do
      msg = msg .. tostring(v) .. ' : '
   end
   DEFAULT_CHAT_FRAME:AddMessage(msg)
end

local DebuffID = { [1]="Magic",[2]="Poison",[3]="Disease",[4]="Curse",[5]="None" };

MGDropDown = {};
MGDropDown_mt = { __index = MGDropDown };

-- dropdown is the name of the xml control frame (*.xml)
-- option is the table of option text strings (localization.lua)
-- var is the variable used for reference in lua (for checking settings, etc.)
-- dep is the id of the checkbox that the dropdown enable state is dependent on
function MGDropDown:new(dropdown, option, var, dep)
	if (not dropdown) then
		return nil;
	end
	
	local new_dropdown = {};
	setmetatable(new_dropdown, MGDropDown_mt);
	
	new_dropdown.dropdown = dropdown;
	new_dropdown.button_list = {};
	new_dropdown.option = option;
	new_dropdown.text = option.TEXT;
	new_dropdown.tip = option.TIP;
	new_dropdown.var = var;
	new_dropdown.dep = dep;
	new_dropdown:Initialize();
	
	return new_dropdown;
end

function MGDropDown:Initialize()
	local dropdown = self.dropdown
	UIDropDownMenu_Initialize(dropdown, function()
			for i = 1, self.option.OPTIONS do --why doesn't table.getn(self.option) work?
				self:addbutton(i, self.option["OPTION"..i.."_TEXT"], self.option["OPTION"..i.."_TIP"]);
			end
		end
	);
	self.selectedValue = UIDropDownMenu_GetSelectedValue(dropdown);
	UIDropDownMenu_SetSelectedValue(self.dropdown, MiniGroup2.GetOpt(self.var));
	UIDropDownMenu_SetWidth(130, dropdown);
	if (self.text) then
		getglobal(dropdown:GetName().."Label"):SetText(self.text);
	end
end

function MGDropDown:Save()
	MiniGroup2.SetOpt(self.var, UIDropDownMenu_GetSelectedValue(self.dropdown));
end
	
function MGDropDown:addbutton(i, text, tip)
	local selectedValue = UIDropDownMenu_GetSelectedValue(self.dropdown);
	local info;
	info = {};
	info.text = text;
	info.tooltipTitle = info.text;
	info.tooltipText = tip;
	info.value = i;
--	info.func = self:OnClick()
	info.func = function() 
		UIDropDownMenu_SetSelectedValue(self.dropdown, info.value);
		self.dropdown.tooltipText = tip; 
	end;
	if ( selectedValue == info.value ) then
		info.checked = i;
		self.dropdown.tooltipText = tip;
	else
		info.checked = nil;
	end
	UIDropDownMenu_AddButton(info);

	return true;
end

MGCheckbox = {};
MGCheckbox_mt = { __index = MGCheckbox };

-- checkbox is the name of the xml control frame (*.xml)
-- option is the table of option text strings (localization.lua)
-- var is the variable used for reference in lua (for checking settings, etc.)
-- cat is the category of options
-- dep is the id of the checkbox that the dropdown enable state is dependent on
function MGCheckbox:new(checkbox, option, cat, var, dep)
--	debug("new checkbox", "cat = "..cat, "var = "..var)
--	if (not checkbox) then
--		return nil;
--	end
	
	local new_checkbox = {};
	setmetatable(new_checkbox, MGCheckbox_mt);
	
--	if ( getglobal(checkbox) ) then
		new_checkbox.checkbox = checkbox;
--	else
--		debug("Error: checkbox does not exist", checkbox);
--	end
	new_checkbox.checked = 0;
--	if ( option and option ~= "" ) then
		new_checkbox.text = getglobal(option.."_TEXT");
		new_checkbox.tip = getglobal(option.."_TIP");
--	end
	if (cat and cat ~= "" ) then
		new_checkbox.cat = cat
	end
	if (var and var ~="" ) then
		new_checkbox.var = var;
	end
	new_checkbox.dep = dep;
	new_checkbox:Initialize();
	return new_checkbox;
end

function MGCheckbox:Initialize()
--	local checkbox = getglobal(self.checkbox);
	local checkbox = self.checkbox;
	local checked;
	if ( not checkbox ) then
		return nil;
	end
	local table;
	
	getglobal(checkbox:GetName()).tooltipText = self.tip;
	getglobal(checkbox:GetName().."Text"):SetText(self.text);
	if ( self.cat ) then
		if not MiniGroup2.GetOpt(self.cat) then
			return;
		end
		table = MiniGroup2.GetOpt(self.cat);
		if ( self.var ) then	
			if (table[self.var] == 1 ) then
				checked = 1;
			else
				checked = nil;
			end
		end
	elseif ( self.var ) then
		if ( MiniGroup2.GetOpt(self.var) == 1 ) then
			checked = 1;
		else
			checked = nil;
		end
	end
	checkbox:SetChecked(checked);
end

function MGCheckbox:IsChecked()
	return self.checked
end

function MGCheckbox:Save()
	local checkbox = self.checkbox;
	local checked = checkbox:GetChecked();
	self.checked = checked;
	if checked then
		checked = 1;
	else
		checked = 0; --this would be nil if we didn't explicitly set to 0
	end
	

	if ( self.cat ) then
		if not MiniGroup2.GetOpt(self.cat) then
			return;
		end
		local table = MiniGroup2.GetOpt(self.cat);
		table[self.var] = checked
		if ( self.var ) then
			MiniGroup2.SetOpt(self.cat,table);
		end
	elseif ( self.var ) then
		MiniGroup2.SetOpt(self.var,checked);
	end
	return self.checked;
end

--[[	********************************************************
		Option functions
		********************************************************]]

local MGOptions_Tabs = {
	[1] = MG_OPTIONS_TABS_GENERAL,
	[2] = MG_OPTIONS_TABS_PLAYER,
	[3] = MG_OPTIONS_TABS_PET,
	[4] = MG_OPTIONS_TABS_PARTY,
	[5] = MG_OPTIONS_TABS_PARTYPETS,
	[6] = MG_OPTIONS_TABS_RAID,
	[7] = MG_OPTIONS_TABS_RAIDPETS,
	[8] = MG_OPTIONS_TABS_TARGET,
	[9] = MG_OPTIONS_TABS_OTHERS,	
--	[10] = MG_OPTIONS_TABS_DEBUFF,
};
local MGOptions_CheckButtons = {};
local MGOptions_Sliders = {};
local MGOptions_Dropdowns = {};
local MGOptions_DebuffOrder = {};
local MGOptions_DebuffColors = {};
local MGOptions_BuffPos = {
	[1] = { x = 0, y = -40 },
	[2] = { x = 0, y = -62 },
	[3] = { x = 0, y = -84 },
	[4] = { x = 0, y = -106 },
	[5] = { x = 0, y = -128 }};
local MGOptions_SetColorFunc = {
	["Magic"] = function() MGOptions_SetColor("Magic") end,
	["Poison"] = function() MGOptions_SetColor("Poison") end,
	["Disease"] = function() MGOptions_SetColor("Disease") end,
	["Curse"] = function() MGOptions_SetColor("Curse") end,
	["None"] = function() MGOptions_SetColor("None") end};

-- General Options (1-20)

MGOptions_Sliders["MGScale"] = { idx = 1, text = MG_OPTIONS_SLIDE1_TEXT, minValue = 0.5, maxValue = 1.5, valueStep = 0.05, tip = MG_OPTIONS_SLIDE1_TIP, cat = "Scaling", var = "MGScale", dep = 11};
MGOptions_Sliders["RaidScale"] = { idx = 3, text = MG_OPTIONS_SLIDE3_TEXT, minValue = 0.5, maxValue = 1.5, valueStep = 0.05, tip = MG_OPTIONS_SLIDE3_TIP, cat = "Scaling", var = "RaidScale", dep = 107};

function MiniGroup2:OptionsInit()

	MGOptions_Checkboxes = {
		[1] = MGCheckbox:new(MGOptionsFrame_CheckButton1, "MG_OPTIONS_CB1", "ShowBlizFrames", "PlayerFrame"),
--		[2] = MGCheckbox:new(MGOptionsFrame_CheckButton2, "MG_OPTIONS_CB1", "ShowBlizFrames", "PetFrame"),
		[3] = MGCheckbox:new(MGOptionsFrame_CheckButton3, "MG_OPTIONS_CB1", "ShowBlizFrames", "TargetFrame"),
		[4] = MGCheckbox:new(MGOptionsFrame_CheckButton4, "MG_OPTIONS_CB1", "ShowBlizFrames", "PartyFrame"),
		[5] = MGCheckbox:new(MGOptionsFrame_CheckButton5, "MG_OPTIONS_CB5", nil, "PartyGrouping"),
	--	[6] = MGCheckbox:new(MGOptionsFrame_CheckButton6, "MG_OPTIONS_CB6", nil, "MGplayer"),
	--	[7] = MGCheckbox:new(MGOptionsFrame_CheckButton7, "MG_OPTIONS_CB7", nil, "MGtarget"),
	--	[8] = MGCheckbox:new(MGOptionsFrame_CheckButton8, "MG_OPTIONS_CB8", nil, "MGparty"),
	--	[9] = MGCheckbox:new(MGOptionsFrame_CheckButton9, "MG_OPTIONS_CB9", nil, "StatusTextStyle"),
		[10] = MGCheckbox:new(MGOptionsFrame_CheckButton10, "MG_OPTIONS_CB10", nil, "SmoothHealthBars"),
		[11] = MGCheckbox:new(MGOptionsFrame_CheckButton11, "MG_OPTIONS_CB11", "Scaling", "UseMGScale"),

	--	[21] = MGCheckbox:new(MGOptionsFrame_CheckButton21, "MG_OPTIONS_CB12", nil, "ShowplayerText"),
	--	[22] = MGCheckbox:new(MGOptionsFrame_CheckButton22, "MG_OPTIONS_CB13", nil, "ShowpetText"),
		[23] = MGCheckbox:new(MGOptionsFrame_CheckButton23, "MG_OPTIONS_CB14", nil, "ShowPlayerXP"),
		[24] = MGCheckbox:new(MGOptionsFrame_CheckButton24, "MG_OPTIONS_CB15", nil, "ShowPetXP"),
        [25] = MGCheckbox:new(MGOptionsFrame_CheckButton25, "MG_OPTIONS_CB16", nil, "HidePetHappy"),
		[69] = MGCheckbox:new(MGOptionsFrame_CheckButton69, "MG_OPTIONS_CB35", nil, "ShowPlayerCombat"),
		[70] = MGCheckbox:new(MGOptionsFrame_CheckButton70, "MG_OPTIONS_CB36", nil, "ShowPetCombat"),
	--	[73] = MGCheckbox:new(MGOptionsFrame_CheckButton73, "MG_OPTIONS_CB39", nil, "ShowplayerTextDiff"),
	--	[74] = MGCheckbox:new(MGOptionsFrame_CheckButton74, "MG_OPTIONS_CB40", nil, "ShowpetTextDiff"),
		[76] = MGCheckbox:new(MGOptionsFrame_CheckButton76, "MG_OPTIONS_CB42", nil, "PlayerGrouping"),
		[77] = MGCheckbox:new(MGOptionsFrame_CheckButton77, "MG_OPTIONS_CB43", nil, "FlashRestIndicator"),
		[78] = MGCheckbox:new(MGOptionsFrame_CheckButton78, "MG_OPTIONS_CB44", nil, "FlashCombatIndicator"),
		[79] = MGCheckbox:new(MGOptionsFrame_CheckButton79, "MG_OPTIONS_CB45", nil, "FlashAggroIndicator"),

	--	[41] = MGCheckbox:new(MGOptionsFrame_CheckButton41, "MG_OPTIONS_CB16", nil, "ShowpartyText"),
	--	[42] = MGCheckbox:new(MGOptionsFrame_CheckButton42, "MG_OPTIONS_CB17", nil, "ShowClassText"),
	--	[43] = MGCheckbox:new(MGOptionsFrame_CheckButton43, "MG_OPTIONS_CB18", nil, "ShowPartyAuras"),
		[44] = MGCheckbox:new(MGOptionsFrame_CheckButton44, "MG_OPTIONS_CB19", nil, "ShowKeyBindings"),
		[45] = MGCheckbox:new(MGOptionsFrame_CheckButton45, "MG_OPTIONS_CB20", nil, "UsePartyRaidColors"),
		[46] = MGCheckbox:new(MGOptionsFrame_CheckButton46, "MG_OPTIONS_CB33", nil, "HighlightSelected"),
	--	[72] = MGCheckbox:new(MGOptionsFrame_CheckButton72, "MG_OPTIONS_CB38", nil, "ShowpartyTextDiff"),
	--	[47] = MGCheckbox:new(MGOptionsFrame_CheckButton47, "MG_OPTIONS_CB22", nil, "UseTargetRaidColors"),
	--	[48] = MGCheckbox:new(MGOptionsFrame_CheckButton48, "MG_OPTIONS_CB23", nil, "ShowtargetText"),
	--	[49] = MGCheckbox:new(MGOptionsFrame_CheckButton49, "MG_OPTIONS_CB25", nil, "ShowTargetAuras"),
	--	[75] = MGCheckbox:new(MGOptionsFrame_CheckButton75, "MG_OPTIONS_CB41", nil, "ShowtargetTextDiff"),
		[81] = MGCheckbox:new(MGOptionsFrame_CheckButton81, "MG_OPTIONS_CB47", nil, "CastPartyEnabled"),
--		[82] = MGCheckbox:new(MGOptionsFrame_CheckButton82, "MG_OPTIONS_CB48", nil, "ShowCastParty"),

--		[61] = MGCheckbox:new(MGOptionsFrame_CheckButton61, "MG_OPTIONS_CB26", nil, "UsePlayerDBColors"),
--		[62] = MGCheckbox:new(MGOptionsFrame_CheckButton62, "MG_OPTIONS_CB27", nil, "UsePlayerDBColorBlind"),
--		[63] = MGCheckbox:new(MGOptionsFrame_CheckButton63, "MG_OPTIONS_CB28", nil, "UsePartyDBColors"),
--		[64] = MGCheckbox:new(MGOptionsFrame_CheckButton64, "MG_OPTIONS_CB29", nil, "UsePartyDBColorBlind"),
--		[65] = MGCheckbox:new(MGOptionsFrame_CheckButton65, "MG_OPTIONS_CB30", nil, "UseTargetDBColors"),
--		[66] = MGCheckbox:new(MGOptionsFrame_CheckButton66, "MG_OPTIONS_CB31", nil, "UseTargetDBColorBlind"),
--		[67] = MGCheckbox:new(MGOptionsFrame_CheckButton67, "MG_OPTIONS_CB32", nil, "UseGlobalDBSettings"),
--		[68] = MGCheckbox:new(MGOptionsFrame_CheckButton68, "MG_OPTIONS_CB34", nil, "ShowAllDebuffs"),

--		[37] = MGCheckbox:new(MGOptionsFrame_CheckButton37, "MG_OPTIONS_CB37", nil, "FrameGrowth"),
		[80] = MGCheckbox:new(MGOptionsFrame_CheckButton80, "MG_OPTIONS_CB46", nil, "ShowEndcaps"),
		[83] = MGCheckbox:new(MGOptionsFrame_CheckButton83, "MG_OPTIONS_CB49", nil, "AlwaysShowParty"),
		[84] = MGCheckbox:new(MGOptionsFrame_CheckButton84, "MG_OPTIONS_CB50", nil, "AlwaysShowPet"),
--		[85] = MGCheckbox:new(MGOptionsFrame_CheckButton85, "MG_OPTIONS_CB51", nil, "UseGlobalConfig"),
		[86] = MGCheckbox:new(MGOptionsFrame_CheckButton86, "MG_OPTIONS_CB52", nil, "CastPartyTargetEnabled"),
--		[87] = MGCheckbox:new(MGOptionsFrame_CheckButton87, "MG_OPTIONS_CB53", nil, "CastPartyOverride"),
		[88] = MGCheckbox:new(MGOptionsFrame_CheckButton88, "MG_OPTIONS_CB54", nil, "CastPartyOverrideAlt"),
		[89] = MGCheckbox:new(MGOptionsFrame_CheckButton89, "MG_OPTIONS_CB55", nil, "CastPartyOverrideCtrl"),
		[90] = MGCheckbox:new(MGOptionsFrame_CheckButton90, "MG_OPTIONS_CB56", nil, "CastPartyOverrideShift"),
		[91] = MGCheckbox:new(MGOptionsFrame_CheckButton91, "MG_OPTIONS_CB57", nil, "ShowMapButton"),
		[92] = MGCheckbox:new(MGOptionsFrame_CheckButton92, "MG_OPTIONS_CB58", nil, "RaidHideEverything"),
		[93] = MGCheckbox:new(MGOptionsFrame_CheckButton93, "MG_OPTIONS_CB59", nil, "RaidHideParty"),

		[95] = MGCheckbox:new(MGOptionsFrame_CheckButton95, "MG_OPTIONS_CB60", nil, "AlwaysShowPartyPets"),
		[96] = MGCheckbox:new(MGOptionsFrame_CheckButton96, "MG_OPTIONS_CB61", nil, "HideGroupIcons"),
		[97] = MGCheckbox:new(MGOptionsFrame_CheckButton97, "MG_OPTIONS_CB62", nil, "HidePvPIcon"),
		
	--	[98] = MGCheckbox:new(MGOptionsFrame_CheckButton98, "MG_OPTIONS_CB65", nil, "RaidGrouping"),
		[99] = MGCheckbox:new(MGOptionsFrame_CheckButton99, "MG_OPTIONS_CB63", nil, "AlwaysShowRaid"),
		[100] = MGCheckbox:new(MGOptionsFrame_CheckButton100, "MG_OPTIONS_CB64", nil, "AlwaysShowRaidPets"),

		[101] = MGCheckbox:new(MGOptionsFrame_CheckButton101, "MG_OPTIONS_CB66", nil, "ShowPartyCombat"),
		[102] = MGCheckbox:new(MGOptionsFrame_CheckButton102, "MG_OPTIONS_CB67", nil, "ShowPartyPetCombat"),
		[103] = MGCheckbox:new(MGOptionsFrame_CheckButton103, "MG_OPTIONS_CB68", nil, "ShowRaidCombat"),
		[104] = MGCheckbox:new(MGOptionsFrame_CheckButton104, "MG_OPTIONS_CB69", nil, "ShowRaidPetCombat"),
		[105] = MGCheckbox:new(MGOptionsFrame_CheckButton105, "MG_OPTIONS_CB70", nil, "ShowTargetCombat"),
		[106] = MGCheckbox:new(MGOptionsFrame_CheckButton106, "MG_OPTIONS_CB71", nil, "ShowTargettargetCombat"),
		[107] = MGCheckbox:new(MGOptionsFrame_CheckButton107, "MG_OPTIONS_CB72", "Scaling", "UseRaidScale"),
		[108] = MGCheckbox:new(MGOptionsFrame_CheckButton108, "MG_OPTIONS_CB73", nil, "RaidByClass"),
		[109] = MGCheckbox:new(MGOptionsFrame_CheckButton109, "MG_OPTIONS_CB74", nil, "ShowAnchors"),
		[110] = MGCheckbox:new(MGOptionsFrame_CheckButton110, "MG_OPTIONS_CB75", nil, "HideAnchorBackgrounds"),		
		[111] = MGCheckbox:new(MGOptionsFrame_CheckButton111, "MG_OPTIONS_CB76", nil, "RaidColorName"),	

		[112] = MGCheckbox:new(MGOptionsFrame_CheckButton112, "MG_OPTIONS_CB77", nil, "PlayerAuraFilter"),
		[113] = MGCheckbox:new(MGOptionsFrame_CheckButton113, "MG_OPTIONS_CB77", nil, "PetAuraFilter"),
		[114] = MGCheckbox:new(MGOptionsFrame_CheckButton114, "MG_OPTIONS_CB77", nil, "PartyAuraFilter"),
		[115] = MGCheckbox:new(MGOptionsFrame_CheckButton115, "MG_OPTIONS_CB77", nil, "PartyPetAuraFilter"),
		[116] = MGCheckbox:new(MGOptionsFrame_CheckButton116, "MG_OPTIONS_CB77", nil, "RaidAuraFilter"),
		[117] = MGCheckbox:new(MGOptionsFrame_CheckButton117, "MG_OPTIONS_CB77", nil, "RaidPetAuraFilter"),
		[118] = MGCheckbox:new(MGOptionsFrame_CheckButton118, "MG_OPTIONS_CB77", nil, "TargetAuraFilter"),
		[119] = MGCheckbox:new(MGOptionsFrame_CheckButton119, "MG_OPTIONS_CB77", nil, "TargettargetAuraFilter"),

		[120] = MGCheckbox:new(MGOptionsFrame_CheckButton120, "MG_OPTIONS_CB78", nil, "PlayerAuraDebuffC"),
		[121] = MGCheckbox:new(MGOptionsFrame_CheckButton121, "MG_OPTIONS_CB78", nil, "PetAuraDebuffC"),
		[122] = MGCheckbox:new(MGOptionsFrame_CheckButton122, "MG_OPTIONS_CB78", nil, "PartyAuraDebuffC"),
		[123] = MGCheckbox:new(MGOptionsFrame_CheckButton123, "MG_OPTIONS_CB78", nil, "PartyPetAuraDebuffC"),
		[124] = MGCheckbox:new(MGOptionsFrame_CheckButton124, "MG_OPTIONS_CB78", nil, "RaidAuraDebuffC"),
		[125] = MGCheckbox:new(MGOptionsFrame_CheckButton125, "MG_OPTIONS_CB78", nil, "RaidPetAuraDebuffC"),
		[126] = MGCheckbox:new(MGOptionsFrame_CheckButton126, "MG_OPTIONS_CB78", nil, "TargetAuraDebuffC"),
		[127] = MGCheckbox:new(MGOptionsFrame_CheckButton127, "MG_OPTIONS_CB78", nil, "TargettargetAuraDebuffC"),
		[128] = MGCheckbox:new(MGOptionsFrame_CheckButton128, "MG_OPTIONS_CB79", nil, "TargetShowHostile"),
		
		[130] = MGCheckbox:new(MGOptionsFrame_CheckButton130, "MG_OPTIONS_CB80", nil, "PlayerHideMana"),
		[131] = MGCheckbox:new(MGOptionsFrame_CheckButton131, "MG_OPTIONS_CB94", nil, "PetHideMana"),
		[132] = MGCheckbox:new(MGOptionsFrame_CheckButton132, "MG_OPTIONS_CB82", nil, "PartyHideMana"),
		[133] = MGCheckbox:new(MGOptionsFrame_CheckButton133, "MG_OPTIONS_CB84", nil, "PartyPetHideMana"),
		[134] = MGCheckbox:new(MGOptionsFrame_CheckButton134, "MG_OPTIONS_CB86", nil, "RaidHideMana"),
		[135] = MGCheckbox:new(MGOptionsFrame_CheckButton135, "MG_OPTIONS_CB88", nil, "RaidPetHideMana"),
		[136] = MGCheckbox:new(MGOptionsFrame_CheckButton136, "MG_OPTIONS_CB90", nil, "TargetHideMana"),
		[137] = MGCheckbox:new(MGOptionsFrame_CheckButton137, "MG_OPTIONS_CB92", nil, "TargettargetHideMana"),

		[140] = MGCheckbox:new(MGOptionsFrame_CheckButton140, "MG_OPTIONS_CB81", nil, "PlayerHideFrame"),
		[141] = MGCheckbox:new(MGOptionsFrame_CheckButton141, "MG_OPTIONS_CB95", nil, "PetHideFrame"),
		[142] = MGCheckbox:new(MGOptionsFrame_CheckButton142, "MG_OPTIONS_CB83", nil, "PartyHideFrame"),
		[143] = MGCheckbox:new(MGOptionsFrame_CheckButton143, "MG_OPTIONS_CB85", nil, "PartyPetHideFrame"),
		[144] = MGCheckbox:new(MGOptionsFrame_CheckButton144, "MG_OPTIONS_CB87", nil, "RaidHideFrame"),
		[145] = MGCheckbox:new(MGOptionsFrame_CheckButton145, "MG_OPTIONS_CB89", nil, "RaidPetHideFrame"),
		[146] = MGCheckbox:new(MGOptionsFrame_CheckButton146, "MG_OPTIONS_CB91", nil, "TargetHideFrame"),
		[147] = MGCheckbox:new(MGOptionsFrame_CheckButton147, "MG_OPTIONS_CB93", nil, "TargettargetHideFrame"),		

		[148] = MGCheckbox:new(MGOptionsFrame_CheckButton150, "MG_OPTIONS_CB150", nil, "HideCastBars"),		
		[149] = MGCheckbox:new(MGOptionsFrame_CheckButton151, "MG_OPTIONS_CB151", nil, "HideOORAlerts"),		
		[150] = MGCheckbox:new(MGOptionsFrame_CheckButton152, "MG_OPTIONS_CB152", nil, "HideNotHereAlerts"),		
		[151] = MGCheckbox:new(MGOptionsFrame_CheckButton153, "MG_OPTIONS_CB153", nil, "ShowBuffTimes"),		
		[152] = MGCheckbox:new(MGOptionsFrame_CheckButton154, "MG_OPTIONS_CB154", nil, "HideNotHereAlertsOffline"),		
		[153] = MGCheckbox:new(MGOptionsFrame_CheckButton155, "MG_OPTIONS_CB155", nil, "UseBigHealthFonts"),
		[154] = MGCheckbox:new(MGOptionsFrame_CheckButton156, "MG_OPTIONS_CB156", nil, "HideFSR"),
		[155] = MGCheckbox:new(MGOptionsFrame_CheckButton157, "MG_OPTIONS_CB157", nil, "HideOOFSR"),		
	};

	MGOptions_Dropdowns = {
		[1] = MGDropDown:new(MGOptionsFrame_Dropdown1, MG_OPTIONS_DD1, "PartyAuraStyle", 43),
		[2] = MGDropDown:new(MGOptionsFrame_Dropdown2, MG_OPTIONS_DD1, "TargetAuraStyle", 49),
		[3] = MGDropDown:new(MGOptionsFrame_Dropdown3, MG_OPTIONS_DD3, "PartyAuraTipStyle"),
		[4] = MGDropDown:new(MGOptionsFrame_Dropdown4, MG_OPTIONS_DD3, "TargetAuraTipStyle"),
		[5] = MGDropDown:new(MGOptionsFrame_Dropdown5, MG_OPTIONS_DD5, "TargetAuraPos", 49),

		[6] = MGDropDown:new(MGOptionsFrame_Dropdown6, MG_OPTIONS_DD6, "RestIndicator"),
		[7] = MGDropDown:new(MGOptionsFrame_Dropdown7, MG_OPTIONS_DD7, "CombatIndicator"),
		[8] = MGDropDown:new(MGOptionsFrame_Dropdown8, MG_OPTIONS_DD8, "AggroIndicator"),

		[9] = MGDropDown:new(MGOptionsFrame_Dropdown9, MG_OPTIONS_DD9, "PlayerFrameStyle"),
		[10] = MGDropDown:new(MGOptionsFrame_Dropdown10, MG_OPTIONS_DD9, "PetFrameStyle"),
		[11] = MGDropDown:new(MGOptionsFrame_Dropdown11, MG_OPTIONS_DD9, "PartyFrameStyle"),
		[12] = MGDropDown:new(MGOptionsFrame_Dropdown12, MG_OPTIONS_DD9, "TargetFrameStyle"),

		[13] = MGDropDown:new(MGOptionsFrame_Dropdown13, MG_OPTIONS_DD13, "PlayerStatusTextStyle"),
		[14] = MGDropDown:new(MGOptionsFrame_Dropdown14, MG_OPTIONS_DD13, "PetStatusTextStyle"),
		[15] = MGDropDown:new(MGOptionsFrame_Dropdown15, MG_OPTIONS_DD13, "PartyStatusTextStyle"),
		[16] = MGDropDown:new(MGOptionsFrame_Dropdown16, MG_OPTIONS_DD13, "TargetStatusTextStyle"),

		[17] = MGDropDown:new(MGOptionsFrame_Dropdown17, MG_OPTIONS_DD1, "PlayerAuraStyle"),
		[18] = MGDropDown:new(MGOptionsFrame_Dropdown18, MG_OPTIONS_DD3, "PlayerAuraTipStyle"),
		[19] = MGDropDown:new(MGOptionsFrame_Dropdown19, MG_OPTIONS_DD5, "PlayerAuraPos"),
		[20] = MGDropDown:new(MGOptionsFrame_Dropdown20, MG_OPTIONS_DD1, "PetAuraStyle"),
		[21] = MGDropDown:new(MGOptionsFrame_Dropdown21, MG_OPTIONS_DD3, "PetAuraTipStyle"),
		[22] = MGDropDown:new(MGOptionsFrame_Dropdown22, MG_OPTIONS_DD5, "PetAuraPos"),
		[23] = MGDropDown:new(MGOptionsFrame_Dropdown23, MG_OPTIONS_DD5, "PartyAuraPos"),
		[24] = MGDropDown:new(MGOptionsFrame_Dropdown24, MG_OPTIONS_DD14, "PetGrouping"),
		[25] = MGDropDown:new(MGOptionsFrame_Dropdown25, MG_OPTIONS_DD15, "FrameGrowth"),
		[26] = MGDropDown:new(MGOptionsFrame_Dropdown26, MG_OPTIONS_DD16, "CastPartyOverrideMouse"),

		[27] = MGDropDown:new(MGOptionsFrame_Dropdown27, MG_OPTIONS_DD9,  "PartyPetFrameStyle"),
		[28] = MGDropDown:new(MGOptionsFrame_Dropdown28, MG_OPTIONS_DD13, "PartyPetStatusTextStyle"),
		[29] = MGDropDown:new(MGOptionsFrame_Dropdown29, MG_OPTIONS_DD1,  "PartyPetAuraStyle"),
		[30] = MGDropDown:new(MGOptionsFrame_Dropdown30, MG_OPTIONS_DD5,  "PartyPetAuraPos"),
		[31] = MGDropDown:new(MGOptionsFrame_Dropdown31, MG_OPTIONS_DD14, "PartyPetGrouping"),
		[32] = MGDropDown:new(MGOptionsFrame_Dropdown32, MG_OPTIONS_DD3,  "PartyPetAuraTipStyle"),
		
		[33] = MGDropDown:new(MGOptionsFrame_Dropdown33, MG_OPTIONS_DD17, "PlayerBarTextStyle"),
		[34] = MGDropDown:new(MGOptionsFrame_Dropdown34, MG_OPTIONS_DD17, "PetBarTextStyle"),
		[35] = MGDropDown:new(MGOptionsFrame_Dropdown35, MG_OPTIONS_DD17, "PartyBarTextStyle"),
		[36] = MGDropDown:new(MGOptionsFrame_Dropdown36, MG_OPTIONS_DD17, "TargetBarTextStyle"),
		[37] = MGDropDown:new(MGOptionsFrame_Dropdown37, MG_OPTIONS_DD17, "PartyPetBarTextStyle"),
		
		[38] = MGDropDown:new(MGOptionsFrame_Dropdown38, MG_OPTIONS_DD9, "RaidFrameStyle"),
		[39] = MGDropDown:new(MGOptionsFrame_Dropdown39, MG_OPTIONS_DD13, "RaidStatusTextStyle"),
		[40] = MGDropDown:new(MGOptionsFrame_Dropdown40, MG_OPTIONS_DD17, "RaidBarTextStyle"),
		[41] = MGDropDown:new(MGOptionsFrame_Dropdown41, MG_OPTIONS_DD1, "RaidAuraStyle"),
		[42] = MGDropDown:new(MGOptionsFrame_Dropdown42, MG_OPTIONS_DD5,  "RaidAuraPos"),
		[43] = MGDropDown:new(MGOptionsFrame_Dropdown43, MG_OPTIONS_DD3,  "RaidAuraTipStyle"),
		
		[44] = MGDropDown:new(MGOptionsFrame_Dropdown44, MG_OPTIONS_DD9,  "RaidPetFrameStyle"),
		[45] = MGDropDown:new(MGOptionsFrame_Dropdown45, MG_OPTIONS_DD13, "RaidPetStatusTextStyle"),
		[46] = MGDropDown:new(MGOptionsFrame_Dropdown46, MG_OPTIONS_DD1,  "RaidPetAuraStyle"),
		[47] = MGDropDown:new(MGOptionsFrame_Dropdown47, MG_OPTIONS_DD5,  "RaidPetAuraPos"),
--		[48] = MGDropDown:new(MGOptionsFrame_Dropdown48, MG_OPTIONS_DD14, "RaidPetGrouping"),
		[49] = MGDropDown:new(MGOptionsFrame_Dropdown49, MG_OPTIONS_DD3,  "RaidPetAuraTipStyle"),
		[50] = MGDropDown:new(MGOptionsFrame_Dropdown50, MG_OPTIONS_DD17, "PartyPetBarTextStyle"),	
		
		[51] = MGDropDown:new(MGOptionsFrame_Dropdown51, MG_OPTIONS_DD9, "TargettargetFrameStyle"),
		[52] = MGDropDown:new(MGOptionsFrame_Dropdown52, MG_OPTIONS_DD13, "TargettargetStatusTextStyle"),
		[53] = MGDropDown:new(MGOptionsFrame_Dropdown53, MG_OPTIONS_DD17, "TargettargetBarTextStyle"),
		[54] = MGDropDown:new(MGOptionsFrame_Dropdown54, MG_OPTIONS_DD1, "TargettargetAuraStyle"),
		[55] = MGDropDown:new(MGOptionsFrame_Dropdown55, MG_OPTIONS_DD3, "TargettargetAuraTipStyle"),
		[56] = MGDropDown:new(MGOptionsFrame_Dropdown56, MG_OPTIONS_DD5, "TargettargetAuraPos"),
		[57] = MGDropDown:new(MGOptionsFrame_Dropdown57, MG_OPTIONS_DD18, "BorderStyle"),
		[58] = MGDropDown:new(MGOptionsFrame_Dropdown58, MG_OPTIONS_DD19, "BarStyle"),
			
	};
	
	for key,val in MGOptions_Tabs do
		getglobal("MGOptions_Tab"..key):SetText(val);
	end
	for num = 1, 29 do
		if getglobal("MGOptions_SubFrame"..num) then
			getglobal("MGOptions_SubFrame"..num.."Title"):SetText(getglobal("MG_OPTIONS_SUBFRAME"..num));
			getglobal("MGOptions_SubFrame"..num):SetBackdropBorderColor(0.4, 0.4, 0.4);
			getglobal("MGOptions_SubFrame"..num):SetBackdropColor(0.15, 0.15, 0.15);
		end
	end

	MGOptionsFrame_CastBarColorLabel:SetText(MG_OPTIONS_COLOR1_TEXT);

	for key,val in MGOptions_Sliders do
		--OptionsFrame_EnableSlider(getglobal("MGOptionsFrame_Slider"..val.idx));
		getglobal("MGOptionsFrame_Slider"..val.idx):SetMinMaxValues(val.minValue, val.maxValue);
		getglobal("MGOptionsFrame_Slider"..val.idx):SetValueStep(val.valueStep);
		getglobal("MGOptionsFrame_Slider"..val.idx):SetValue(1);
		getglobal("MGOptionsFrame_Slider"..val.idx.."Text"):SetText(val.text);
		getglobal("MGOptionsFrame_Slider"..val.idx.."Low"):SetText(val.minValue);
		getglobal("MGOptionsFrame_Slider"..val.idx.."High"):SetText(val.maxValue);
		getglobal("MGOptionsFrame_Slider"..val.idx).tooltipText = val.tooltipText;
	end

--	for key,val in DebuffID do
--		getglobal("MGOptionsFrame_"..val.."_TextBoxLabel"):SetText(MG_DEBUFFS[val]);
--	end

	if ( not this.selectedTab ) then
		this.selectedTab = 1;
	end
	MiniGroup2:OptionsSelectTab(this.selectedTab);
end

function MiniGroup2:OptionsOnShow()
	MGOptionsFrame.prevStyle = self.GetOpt("PartyGrouping");
	MGOptionsFrame.prevScale = self.GetOpt("Scaling").MGScale;
	MGOptionsFrame.prevDoScale = self.GetOpt("Scaling").UseMGScale;
	self:MGOptionsSetSliders();
	self:MGOptionsUpdateDependencies();
	self:MGOptionsSetDebuffStuff();
	self:MGOptionsDebuffOrderRefresh();
	--adjust CastParty click buttons so they mouseover properly
	MGOptionsFrame_CheckButton89:SetFrameLevel( MGOptionsFrame_CheckButton88:GetFrameLevel() + 1);
	MGOptionsFrame_CheckButton90:SetFrameLevel( MGOptionsFrame_CheckButton89:GetFrameLevel() + 1);
	MGOptionsFrame_CastBarColorSwatchBg:SetTexture(MiniGroup2.CastBarR,MiniGroup2.CastBarG,MiniGroup2.CastBarB);
	return;
end

function MiniGroup2:OptionsSave()
	MiniGroup2:MGOptionsSaveChecks();
	MiniGroup2:MGOptionsSaveSliders();
	MiniGroup2:MGOptionsSaveDropdowns();
	MiniGroup2:MGOptionsSaveDebuffStuff();

	local playerName = UnitName("player").." of "..MiniGroup2:Trim(GetCVar("realmName"));

	if ( (self.GetOpt("Scaling").UseMGScale ~= MGOptionsFrame.prevDoScale) or (self.GetOpt("Scaling").UseMGScale == 1 and (self.GetOpt("Scaling").MGScale ~= MGOptionsFrame.prevScale)) ) then
		local scale;
		if ( self.GetOpt("Scaling").UseMGScale == 0 ) then
			scale = tonumber(GetCVar("uiscale"));
			if ( GetCVar("useUiScale") == "1" ) then
				scale = tonumber(GetCVar("uiscale"));
			else
				scale = 1;
			end
		else
			scale = self.GetOpt("Scaling").MGScale;
		end
		
	end
	MiniGroup2:ApplySettings();
end

function MiniGroup2:MGOptionsSetChecks()
	for key in MGOptions_Checkboxes do
		MGOptions_Checkboxes[key]:Initialize();
	end
end

function MiniGroup2:MGOptionsSliderChanged(arg1)
	if ( arg1 and MGOptionsFrame_Slider1.tip ) then
		local num = tonumber(arg1);
		local dShift = 10 ^ 2;
		local disp = ""..floor(num * dShift + 0.5)  / dShift;

		disp = NORMAL_FONT_COLOR_CODE.."MiniGroup Scale:"..FONT_COLOR_CODE_CLOSE.."\n"..disp;
		GameTooltip_SetDefaultAnchor(GameTooltip, this);
		GameTooltip:SetText(disp,1.0,1.0,1.0);
	end
end

function MiniGroup2:MGOptionsSliderChanged3(arg1)
	if ( arg1 and MGOptionsFrame_Slider3.tip ) then
		local num = tonumber(arg1);
		local dShift = 10 ^ 2;
		local disp = ""..floor(num * dShift + 0.5)  / dShift;

		disp = NORMAL_FONT_COLOR_CODE.."MiniGroup Scale:"..FONT_COLOR_CODE_CLOSE.."\n"..disp;
		GameTooltip_SetDefaultAnchor(GameTooltip, this);
		GameTooltip:SetText(disp,1.0,1.0,1.0);
	end
end

function MiniGroup2:MGOptionsUpdateDependencies()
	for key, val in MGOptions_Sliders do
		if ( val.dep ) then
			if ( getglobal("MGOptionsFrame_CheckButton"..val.dep):GetChecked() ) then
				OptionsFrame_EnableSlider(getglobal("MGOptionsFrame_Slider"..val.idx));
			else
				OptionsFrame_DisableSlider(getglobal("MGOptionsFrame_Slider"..val.idx));
			end
		end
	end

	MiniGroup2:MGOptionsSetDebuffStuff();
end

function MiniGroup2:MGOptionsSaveDropdowns()
	for key in MGOptions_Dropdowns do
		local dropdown = MGOptions_Dropdowns[key];
		dropdown:Save();
		if ( dropdown.var == "PlayerFrameStyle"
		or   dropdown.var == "PetFrameStyle"   
		or   dropdown.var == "PartyFrameStyle"  
		or   dropdown.var == "TargetFrameStyle" ) then
			local blizframe = string.gsub(dropdown.var,"(Style)","");
			local MGframe = string.gsub(dropdown.var,"(FrameStyle)","");
			MGframe = "MG"..string.lower(MGframe);
		end
	end
end

function MiniGroup2:MGOptionsSetSliders()
	for key,val in MGOptions_Sliders do
		if ( val.cat ) then
			local table = MiniGroup2.GetOpt(val.cat);
			getglobal("MGOptionsFrame_Slider"..val.idx):SetValue(table[val.var]);
		else
			getglobal("MGOptionsFrame_Slider"..val.idx):SetValue(self.GetOpt(val.var));
		end
	end
end

function MiniGroup2:MGOptionsSaveSliders()
	local table;
	for key,val in MGOptions_Sliders do
		if ( val.cat ) then
			table = MiniGroup2.GetOpt(val.cat);
			if ( val.idx == 1 ) then
				local num = tonumber(getglobal("MGOptionsFrame_Slider"..val.idx):GetValue());
				local dShift = 10 ^ 2;
				local disp = floor(num * dShift + 0.5)  / dShift;
--				self.SetOpt(val.var, disp, val.cat);
				table[val.var] = disp
				MiniGroup2.SetOpt(val.cat,table);		
			elseif ( val.idx == 3 ) then
				local num = tonumber(getglobal("MGOptionsFrame_Slider"..val.idx):GetValue());
				local dShift = 10 ^ 2;
				local disp = floor(num * dShift + 0.5)  / dShift;
--				self.SetOpt(val.var, disp, val.cat);
				table[val.var] = disp
				MiniGroup2.SetOpt(val.cat,table);			
			else
--				self.SetOpt(val.var, getglobal("MGOptionsFrame_Slider"..val.idx):GetValue(), val.cat);
				table[self.var] = tonumber(getglobal("MGOptionsFrame_Slider"..val.idx):GetValue());
				MiniGroup2.SetOpt(val.cat,table);	
			end
		else
			self.SetOpt(val.var, getglobal("MGOptionsFrame_Slider"..val.idx):GetValue());
		end
	end
end

function MiniGroup2:MGOptionsSaveChecks()
	local checked;

	for key,val in MGOptions_Checkboxes do
		checked = MGOptions_Checkboxes[key]:Save();
	end
end

function MiniGroup2:MGOptionsSetDebuffStuff()
--[[	local frame,swatch,text,sRed,sGreen,sBlue,sCB;
	MGOptions_DebuffOrder = {};
	MGOptions_DebuffColors = {};

	if ( MGOptionsFrame_CheckButton67:GetChecked() ) then
		for key, val in MG_Cfg["DebuffOrder"] do
			MGOptions_DebuffOrder[key] = val;
		end
		for key, val in MG_Cfg["DebuffColors"] do
			MGOptions_DebuffColors[key] = {};
			for nK,nV in val do
				MGOptions_DebuffColors[key][nK] = nV;
			end
		end
	else
		for key, val in self.GetOpt("DebuffOrder") do
			MGOptions_DebuffOrder[key] = val;
		end
		for key, val in self.GetOpt("DebuffColors") do
			MGOptions_DebuffColors[key] = {};
			for nK,nV in val do
				MGOptions_DebuffColors[key][nK] = nV;
			end
		end
	end

	for key,value in DebuffID do
		frame = getglobal("MGOptionsFrame_"..value);
		swatch = getglobal("MGOptionsFrame_"..value.."_ColorSwatchNormalTexture");
		text = getglobal("MGOptionsFrame_"..value.."_TextBox");

		sRed = MGOptions_DebuffColors[value].r;
		sGreen = MGOptions_DebuffColors[value].g;
		sBlue = MGOptions_DebuffColors[value].b;
		sCB = MGOptions_DebuffColors[value].c;

		frame.r = sRed;
		frame.g = sGreen;
		frame.b = sBlue;
		frame.swatchFunc = MGOptions_SetColorFunc[value];
		swatch:SetVertexColor(sRed,sGreen,sBlue);
		text:SetText(sCB);
	end]]
end

function MiniGroup2:MGOptionsSortBuffOnClick(buttonID,dir)
	local cPos,debuff;

	debuff = DebuffID[buttonID];
	for key,val in MGOptions_DebuffOrder do
		if ( val == debuff ) then
			cPos = key;
			break;
		end
	end

	if ( not cPos or (cPos == 5 and dir == "Down") or (cPos == 1 and dir == "Up") ) then
		return;
	end

	if ( dir == "Up" ) then
		MG_ReOrder(MGOptions_DebuffOrder, debuff, (cPos-1));
	else
		MG_ReOrder(MGOptions_DebuffOrder, debuff, (cPos+1));
	end
	MiniGroup2:MGOptionsDebuffOrderRefresh();
end

function MiniGroup2:MGOptionsDebuffOrderRefresh()
	local frame;

	for key, value in MGOptions_DebuffOrder do
		frame = getglobal("MGOptionsFrame_"..value);
		MiniGroup2:MGOptionsSortBuffBtn(frame,key);
	end
end

function MiniGroup2:MGOptionsSortBuffBtn(frame,pos)
--	frame:ClearAllPoints();
--	frame:SetPoint("TOP","MGOptions_SubFrame9","TOP",MGOptions_BuffPos[pos].x,MGOptions_BuffPos[pos].y);
end

function MiniGroup2:MGOptionsUpdateDebuffText()
	for key, val in DebuffID do
		MGOptions_DebuffColors[val].c = getglobal("MGOptionsFrame_"..val.."_TextBox"):GetText();
	end
end

function MiniGroup2:MGOptionsSaveDebuffStuff()
--[[	if ( getglobal("MGOptionsFrame_CheckButton67"):GetChecked() ) then
		for key, val in MGOptions_DebuffOrder do
			MG_Cfg["DebuffOrder"][key] = val;
		end
		for key, val in MGOptions_DebuffColors do
			MG_Cfg["DebuffColors"][key] = val;
		end
	else
		self.SetOpt("DebuffOrder",MGOptions_DebuffOrder);
		self.SetOpt("DebuffColors",MGOptions_DebuffColors);
	end]]
end

function MiniGroup2:MGOptionsSetColor(key)
	local r,g,b = ColorPickerFrame:GetColorRGB();
	local swatch,frame;
	swatch = getglobal("MGOptionsFrame_"..key.."_ColorSwatchNormalTexture");
	frame = getglobal("MGOptionsFrame_"..key);
	swatch:SetVertexColor(r,g,b);
	frame.r = r;
	frame.g = g;
	frame.b = b;
	MGOptions_DebuffColors[key].r = r;
	MGOptions_DebuffColors[key].g = g;
	MGOptions_DebuffColors[key].b = b;
end

function MiniGroup2:MGOptionsCheckButtonOnClick()
	MiniGroup2:MGOptionsUpdateDependencies();
	if ( this:GetName() == "MGOptionsFrame_CheckButton67" ) then
		MiniGroup2:MGOptionsSetDebuffStuff();
		MiniGroup2:MGOptionsDebuffOrderRefresh();
	end
end

function MiniGroup2:OptionsSelectTab(page)
	for key,val in MGOptions_Tabs do
		if ( page == key ) then
			MGOptionsFrame.selectedTab = key;
			getglobal("MGOptionsFrame_Page"..key):Show();
			getglobal("MGOptions_Tab"..key):Disable();
		else
			getglobal("MGOptionsFrame_Page"..key):Hide();
			getglobal("MGOptions_Tab"..key):Enable();
		end
	end
end

function MiniGroup2:Trim(s)
	return (string.gsub(s, "^%s*(.-)%s*$", "%1"));
end

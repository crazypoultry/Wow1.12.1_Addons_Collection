--[[

PanzaDCB.lua
Panza Default Class Blessing (DCB) Dialog
Revision 4.0

10-01-06 "for in pairs()" completed for BC
--]]

function PA:SetupDCB()
	PA.DCB_IndexClass = {"WARRIOR", PA["HybridClass"], "ROGUE", "HUNTER", "WARLOCK", "DRUID", "MAGE", "PRIEST", "SELF"};
end
----------------------------------
-- Dialog Headers
----------------------------------
local PA_DCB_Headers = {};
PA_DCB_Headers[1] = PANZA_PBM_HEAD_SOLO;
PA_DCB_Headers[2] = PANZA_PBM_HEAD_PARTY;
PA_DCB_Headers[3] = PANZA_PBM_HEAD_RAID;
PA_DCB_Headers[4] = PANZA_PBM_HEAD_BG;

----------------------------------
-- States
----------------------------------
local PA_DCB_States = {};
PA_DCB_States[1] = {Short='solo',	Long='(Solo)'};
PA_DCB_States[2] = {Short='party',	Long='(Party)'};
PA_DCB_States[3] = {Short='raid',	Long='(Raid)'};
PA_DCB_States[4] = {Short='bg',		Long='(BG)'};

---------
-- Colors
---------
local PA_DCB_COLORS = {};
PA_DCB_COLORS[0] = {Normal={}, Current={r=20/255, g=240/255, b=20/255}};
PA_DCB_COLORS[1] = {Normal={r=80/255, g=80/255, b=240/255}, Current={r=20/255, g=240/255, b=20/255}};
PA_DCB_COLORS[2] = {Normal={r=80/255, g=80/255, b=220/255}, Current={r=20/255, g=240/255, b=20/255}};
PA_DCB_COLORS[3] = {Normal={r=80/255, g=80/255, b=200/255}, Current={r=20/255, g=240/255, b=20/255}};

PA.DCBLevel = 0;
local CurrentSet = {};

StaticPopupDialogs["ADD_PANZA_DCBSAVESET"] = {
	text = TEXT(PANZA_ADD_SAVESET_LABEL),
	button1 = TEXT(ACCEPT),
	button2 = TEXT(CANCEL),
	hasEditBox = 1,
	maxLetters = 16,
	OnAccept = function()
		local editBox = getglobal(this:GetParent():GetName().."EditBox");
		PA:DCB_CreateNewSaveSet(editBox:GetText());
	end,
	OnShow = function()
		getglobal(this:GetName().."EditBox"):SetFocus();
	end,
	OnHide = function()
		if ( ChatFrameEditBox:IsVisible() ) then
			ChatFrameEditBox:SetFocus();
		end
		getglobal(this:GetName().."EditBox"):SetText("");
	end,
	EditBoxOnEnterPressed = function()
		local editBox = getglobal(this:GetParent():GetName().."EditBox");
		PA:DCB_CreateNewSaveSet(editBox:GetText());
		this:GetParent():Hide();
	end,
	EditBoxOnEscapePressed = function()
		this:GetParent():Hide();
	end,
	timeout = 0,
	exclusive = 1,
	whileDead = 1,
	hideOnEscape = 1
};

function PA:DCB_OnLoad()
	PA.GUIFrames[this:GetName()] = this;
	UIPanelWindows[this:GetName()] = {area = "center", pushable = 0};
end

function PA:DCB_SetValues()
	txtDCBClassAll:SetText(string.upper(PANZA_SETALL));
	txtDCBClassWarrior:SetText(PA:Capitalize(PANZA_WARRIOR));
	txtDCBClassHybrid:SetText(PA:Capitalize(PANZA_HYBRID));
	txtDCBClassRogue:SetText(PA:Capitalize(PANZA_ROGUE));
	txtDCBClassHunter:SetText(PA:Capitalize(PANZA_HUNTER));
	txtDCBClassWarlock:SetText(PA:Capitalize(PANZA_WARLOCK));
	txtDCBClassDruid:SetText(PA:Capitalize(PANZA_DRUID));
	txtDCBClassMage:SetText(PA:Capitalize(PANZA_MAGE));
	txtDCBClassPriest:SetText(PA:Capitalize(PANZA_PRIEST));
	txtDCBClassPlayer:SetText(PA:Capitalize(PANZA_SELF));
	txtDCBSaveSets:SetText(PANZA_SAVESETS);

	txtDCBHeader1:SetText(PA_DCB_Headers[1]);
	txtDCBHeader2:SetText(PA_DCB_Headers[2]);
	txtDCBHeader3:SetText(PA_DCB_Headers[3]);
	txtDCBHeader4:SetText(PA_DCB_Headers[4]);

	-------------------------------------
	-- Restore DCB Table if it is missing
	-------------------------------------
	if (PASettings["DCB"]==nil) then
		PA:InitializeDCB("DCB");
	end
	PA.DCBLevel = 0;
	PA:SpellSelectDropDown_InitAllDropDowns();

end

function PA:GetCurrentSet()
	if (PASettings.DCBUseSaved==0 or PASettings.DCBSaved[PASettings.DCBUseSaved]==nil) then
		return PA:CopyTable(PASettings.DCB);
	end
	return PA:CopyTable(PASettings.DCBSaved[PASettings.DCBUseSaved]);
end

function PA:DCB_OnShow()
	PA:Reposition(PanzaDCBFrame, "UIParent", true);
	PanzaDCBFrame:SetAlpha(PASettings.Alpha);
	CurrentSet = PA:GetCurrentSet();
	PA:DCB_SetValues();
end

function PA:DCB_OnHide()
	-- place holder
end

function PA:SaveChanges()
	if (PASettings.DCBUseSaved==0) then
		PASettings.DCB = PA:CopyTable(CurrentSet);
	else
		PASettings.DCBSaved[PASettings.DCBUseSaved] = PA:CopyTable(CurrentSet);
	end
	-- PA:ShowText("CheckDCB ", "PA:SaveChanges");
	--PA:CheckDCB(PASettings.DCBUseSaved);
	--PA:GetCurrentSet();
end
-----------------------------------
-- Save changes when we press Apply
-----------------------------------
function PanzaDCB_btnApply_OnClick()
	PA:SaveChanges();
end

----------------------------------
-- Save changes when we press done
----------------------------------
function PanzaDCB_btnDone_OnClick()
	PA:SaveChanges();
	PA:FrameToggle(PanzaDCBFrame);
end

-- Checks all DCB settings and resets any unknown ones to default
-------------------------------------------------------------
function PA:CheckAllDCB()
	PA:CheckDCB();
	if (PASettings.DCBSaved~=nil) then
		for SetId, _ in pairs(PASettings.DCBSaved) do
			PA:CheckDCB(SetId);
		end
	end
end

-- Checks DCB settings and resets any unknown ones to default
-------------------------------------------------------------
function PA:CheckDCB(set)
	if (PASettings["DCB"]==nil or PASettings["DCB"]=={} or PASettings.DCB["solo"]==nil or PASettings.DCB["party"]==nil) then
		if (PA:CheckMessageLevel("Bless", 2)) then
			PA:Message4("Panza: Resetting DCB Table.");
		end
		PA:InitializeDCB("DCB");
	else
		PA:InitializeDCB("Default");
		local General = (set==0 or set==nil or PASettings.DCBSaved[set]==nil);
		for StateId, StateInfo in pairs(PA_DCB_States) do
			for ClassId, Class in pairs(PA.DCB_IndexClass) do
				local State = StateInfo.Short;
				local Spell;
				if (General) then
					Spell = PASettings.DCB[State][Class];
				else
					Spell = PASettings.DCBSaved[set][State][Class];
				end
				if (Spell~=nil and Spell~="SKIP" and not PA:SpellInSpellBook(Spell)) then
					local ResetSpell = PASettings.Default[State][Class];
					if (ResetSpell==nil or not PA:SpellInSpellBook(PA.DefaultBuff)) then
						ResetSpell = "SKIP";
					end
					if (PA:CheckMessageLevel("Bless", 1)) then
						PA:Message4("You do not have "..Spell.." in your spellbook, resetting DCB["..State.."]["..Class.."] to "..ResetSpell);
					end
					if (General) then
						PASettings.DCB[State][Class] = ResetSpell;
					else
						PASettings.DCBSaved[set][State][Class] = ResetSpell;
					end
				end
			end
		end
		PASettings.Default = nil;
	end
end

-- Reset to default values
function PA:DCB_ResetValues()
	PA:InitializeDCB("Default");
	for StateId, StateInfo in pairs(PA_DCB_States) do
		for ClassId, Class in pairs(PA.DCB_IndexClass) do
			for Level = 0, 4 do
				if (Level==0) then
					CurrentSet[StateInfo.Short][Class] = PASettings.Default[StateInfo.Short][Class];
				elseif (CurrentSet[Level]~=nil) then
					if (PASettings.Default[Level]==nil or PASettings.Default[Level][StateInfo.Short]==nil) then
						CurrentSet[Level][StateInfo.Short][Class] = nil;
					else
						CurrentSet[Level][StateInfo.Short][Class] = PASettings.Default[Level][StateInfo.Short][Class];
					end
				end
			end
		end
	end
	PASettings.Default = nil;
	PA:SpellSelectDropDown_InitAllDropDowns();
end

------------------------------------------------------------------
-- Find what state we are in Solo, Party, Raid, Battleground (1-4)
------------------------------------------------------------------
function PA:DCB_GetState()
	if (PA:IsInBG()) then
		return 4;
	elseif (PA:IsInRaid()) then
		return 3;
	elseif (PA:IsInParty()) then
		return 2;
	else
		return 1;
	end
end

-------------------------------------------------------------------
-- Find what state we are in Solo, Party, Raid, Battleground (text)
-------------------------------------------------------------------
function PA:DCB_GetStateText()
	local StateId = PA:DCB_GetState();
	if (State==3 and PASettings.Switches.IgnorePartyInRaid.enabled==false) then
		State = 2;
	end
	return PA_DCB_States[StateId].Short;
end

-----------------------------------------------------------------------------------------------------------------
-- dropdown functions
-----------------------------------------------------------------------------------------------------------------
function PA:GetDCBColors(level, current)
	local ColorSet = PA_DCB_COLORS[level];
	if (ColorSet~=nil) then
		if (current==true) then
			return ColorSet.Current;
		else
			return ColorSet.Normal;
		end
	end
	return {};
end

function PA:SpellSelectDropDown_InitAllDropDowns()
	PA:CheckDCB(PASettings.DCBUseSaved);
	-- Initialize Set All drop-downs
	for StateId, StateInfo in pairs(PA_DCB_States) do
		local DropDown = getglobal("PA_SpellSetAllDropDown"..StateId);
		UIDropDownMenu_Initialize(DropDown, getglobal("PA_SpellSetAllDropDown_Initialize"..StateId));
		--PA:ShowText("State=", StateInfo.Short);
		local Current = PA:IsCurrentBuffSet(StateInfo.Short);

		PA:EnableDropDown(DropDown, PA:GetDCBColors(PA.DCBLevel, Current));

		for ClassId, Class in pairs(PA.DCB_IndexClass) do
			local DropId = ClassId + (StateId - 1) * 9;
			--PA:ShowText("Class=", Class, " DropId=", DropId);
			DropDown = getglobal("PA_SpellSelectDropDown"..DropId)
			PA:EnableDropDown(DropDown, PA:GetDCBColors(PA.DCBLevel, Current));
		end
	end
	-- Initialize normal drop-downs
	for i = 1, 36 do
		UIDropDownMenu_Initialize(getglobal("PA_SpellSelectDropDown"..i), getglobal("PA_SpellSelectDropDown_Initialize"..i));
	end
	-- Initialize Save Set controls
	UIDropDownMenu_Initialize(PA_DCBSelectSaveSet, PA_DCBSelectSaveSet_Initialize);
	local Current = 0;
	if (PASettings.DCBUseSaved~=0 and PA:TableSize(PASettings.DCBSaved)>0) then
		if (PASettings.DCBSaved[PASettings.DCBUseSaved]~=nil) then
			Current = PASettings.DCBUseSaved;
		end
	end
	UIDropDownMenu_SetSelectedValue(PA_DCBSelectSaveSet, Current);
	if (Current==0) then
		btnPanzaDCBDelete:Disable();
	else
		btnPanzaDCBDelete:Enable();
	end
	if (PA:TableSize(PASettings.DCBSaved)==0) then
		btnPanzaDCBDelAll:Disable();
	else
		btnPanzaDCBDelAll:Enable();
	end
	-- Initialize Level controls
	for i = 0, 3 do
		local Backup = getglobal("cbxPanzaBackup"..i);
		Backup:SetChecked((i==PA.DCBLevel));
	end
end

-----------------------------------------------------------------------------------------------------------------

function PA_DCBSelectSaveSet_Initialize()
	local info = {};
	info.text = PANZA_CURRENT;
	info.func = PA_DCBSelectSaveSet_OnClick;
	info.value = 0;
	UIDropDownMenu_AddButton(info);
	for Index, Set in pairs(PASettings.DCBSaved) do
		info = {};
		info.text = Set.Name;
		info.func = PA_DCBSelectSaveSet_OnClick;
		info.value = Index;
		UIDropDownMenu_AddButton(info);
	end
end

function PA:SpellSelectDropDown_AddEntry(buff, text, index, current, notCheckable)
	if (PA:CheckMessageLevel("UI", 5)) then
		PA:Message4(" text = "..text.." buff="..buff.." index="..index);
	end
	local info = {};
	info.text = text;
	info.value = buff;
	info.func = PA_SpellSelectDropDown_OnClick;
	info.arg1 = index;
	info.notCheckable = notCheckable;
	if (current==true) then
		--PA:ShowText("index=", index," current=", current);
		info.textR = 0.1;	--  Red color value of the button text
		info.textG = 0.8;	--  Green color value of the button text
		info.textB = 0.1;	--  Blue color value of the button text
	end
	UIDropDownMenu_AddButton(info);
end

function PA_SpellSetAllDropDown_Initialize1()
	PA:SpellSelectDropDown_Initialize(101);
end

function PA_SpellSetAllDropDown_Initialize2()
	PA:SpellSelectDropDown_Initialize(102);
end

function PA_SpellSetAllDropDown_Initialize3()
	PA:SpellSelectDropDown_Initialize(103);
end

function PA_SpellSetAllDropDown_Initialize4()
	PA:SpellSelectDropDown_Initialize(104);
end

function PA_SpellSelectDropDown_Initialize1()
	PA:SpellSelectDropDown_Initialize(1);
end

function PA_SpellSelectDropDown_Initialize2()
	PA:SpellSelectDropDown_Initialize(2);
end

function PA_SpellSelectDropDown_Initialize3()
	PA:SpellSelectDropDown_Initialize(3);
end

function PA_SpellSelectDropDown_Initialize4()
	PA:SpellSelectDropDown_Initialize(4);
end

function PA_SpellSelectDropDown_Initialize5()
	PA:SpellSelectDropDown_Initialize(5);
end

function PA_SpellSelectDropDown_Initialize6()
	PA:SpellSelectDropDown_Initialize(6);
end

function PA_SpellSelectDropDown_Initialize7()
	PA:SpellSelectDropDown_Initialize(7);
end

function PA_SpellSelectDropDown_Initialize8()
	PA:SpellSelectDropDown_Initialize(8);
end

function PA_SpellSelectDropDown_Initialize9()
	PA:SpellSelectDropDown_Initialize(9);
end

function PA_SpellSelectDropDown_Initialize10()
	PA:SpellSelectDropDown_Initialize(10);
end

function PA_SpellSelectDropDown_Initialize11()
	PA:SpellSelectDropDown_Initialize(11);
end

function PA_SpellSelectDropDown_Initialize12()
	PA:SpellSelectDropDown_Initialize(12);
end

function PA_SpellSelectDropDown_Initialize13()
	PA:SpellSelectDropDown_Initialize(13);
end

function PA_SpellSelectDropDown_Initialize14()
	PA:SpellSelectDropDown_Initialize(14);
end

function PA_SpellSelectDropDown_Initialize15()
	PA:SpellSelectDropDown_Initialize(15);
end

function PA_SpellSelectDropDown_Initialize16()
	PA:SpellSelectDropDown_Initialize(16);
end

function PA_SpellSelectDropDown_Initialize17()
	PA:SpellSelectDropDown_Initialize(17);
end

function PA_SpellSelectDropDown_Initialize18()
	PA:SpellSelectDropDown_Initialize(18);
end

function PA_SpellSelectDropDown_Initialize19()
	PA:SpellSelectDropDown_Initialize(19);
end

function PA_SpellSelectDropDown_Initialize20()
	PA:SpellSelectDropDown_Initialize(20);
end

function PA_SpellSelectDropDown_Initialize21()
	PA:SpellSelectDropDown_Initialize(21);
end

function PA_SpellSelectDropDown_Initialize22()
	PA:SpellSelectDropDown_Initialize(22);
end

function PA_SpellSelectDropDown_Initialize23()
	PA:SpellSelectDropDown_Initialize(23);
end

function PA_SpellSelectDropDown_Initialize24()
	PA:SpellSelectDropDown_Initialize(24);
end

function PA_SpellSelectDropDown_Initialize25()
	PA:SpellSelectDropDown_Initialize(25);
end

function PA_SpellSelectDropDown_Initialize26()
	PA:SpellSelectDropDown_Initialize(26);
end

function PA_SpellSelectDropDown_Initialize27()
	PA:SpellSelectDropDown_Initialize(27);
end

function PA_SpellSelectDropDown_Initialize28()
	PA:SpellSelectDropDown_Initialize(28);
end

function PA_SpellSelectDropDown_Initialize29()
	PA:SpellSelectDropDown_Initialize(29);
end

function PA_SpellSelectDropDown_Initialize30()
	PA:SpellSelectDropDown_Initialize(30);
end

function PA_SpellSelectDropDown_Initialize31()
	PA:SpellSelectDropDown_Initialize(31);
end

function PA_SpellSelectDropDown_Initialize32()
	PA:SpellSelectDropDown_Initialize(32);
end

function PA_SpellSelectDropDown_Initialize33()
	PA:SpellSelectDropDown_Initialize(33);
end

function PA_SpellSelectDropDown_Initialize34()
	PA:SpellSelectDropDown_Initialize(34);
end

function PA_SpellSelectDropDown_Initialize35()
	PA:SpellSelectDropDown_Initialize(35);
end

function PA_SpellSelectDropDown_Initialize36()
	PA:SpellSelectDropDown_Initialize(36);
end

function PA:GetStateClassFromIndex(index)
	local StateId = math.floor((index-1)/9);
	return PA_DCB_States[StateId + 1].Short, PA.DCB_IndexClass[index - StateId*9];
end

function PA:IsCurrentBuffSet(state)
	local InBG = PA:IsInBG();
	local InRaid = PA:IsInRaid();
	local InParty = PA:IsInParty();
	if (InBG==true or InRaid==true) then
		if (state=="party" and PASettings.Switches.IgnorePartyInRaid.enabled~=true) then
			return true;
		end
		if (InRaid==true) then
			return (state=="raid");
		else
			return (state=="bg");
		end
	elseif (InParty==true) then
		return (state=="party");
	else
		return (state=="solo");
	end
end

-- Determines if a buff should be included in a drop-down list
function PA:SuitableBuff(set, buff, state, class, index, level)
	if (buff=="SKIP") then
		return true;
	end
	--PA:ShowText(buff, " Duration=", PA.SpellBook[buff].Duration, " state=", state);
	if (PA.SpellBook[buff].Duration~=nil
	and PA.SpellBook[buff].Duration>=100
	and PANZA_BUFF_DISPLAY[buff]~=nil) then
		-- Self only buffs have no range
		--PA:ShowText("class=", class, " Range=", PA.SpellBook[buff].Range);
		if (class~="SELF" and PA.SpellBook[buff].Range==nil) then
			return false, false;
		end
		--PA:ShowText("Target=", PA.SpellBook[buff].Target);
		if (PA.SpellBook[buff].Target~=nil) then
			local PartyFlag = (string.find(PA.SpellBook[buff].Target, "P")~=nil);
			local RaidFlag = (string.find(PA.SpellBook[buff].Target, "R")~=nil);
			if (PartyFlag or RaidFlag) then
				if (PartyFlag and RaidFlag) then
					if (state~="solo") then
						return false, false;
					end
				else
					if (PartyFlag and state=="party") then
						return false, false;
					end
					if (RaidFlag and state~="raid" and state~="bg") then
						return false, false;
					end
				end
			end
		end
		if (index>100) then
			return true, false; -- Set-all drop-down
		end
		if (level==0) then
			return true, false; -- Top level
		end
		-- Exclude buff if it is already present in a previous level
		--PA:ShowText("level=", level, " set=", set);
		for HigherLevel=level - 1, 0, -1 do
			local ExistingBuff = PA:GetDCBBlessing(set, state, class, HigherLevel);
			--PA:ShowText("level=", level, " ExistingBuff=", ExistingBuff);
			if (ExistingBuff=="SKIP") then
				return false, true;
			end
			if (ExistingBuff==buff) then
				return false, false;
			end
		end
		return true, false;
	end
	return false, false;
end

-----------------------------------------
-- Populate the dropdown list with Spells
-----------------------------------------
function PA:SpellSelectDropDown_Initialize(index)
    if (PA:CheckMessageLevel('UI', 5)) then
	    PA:Message4('DCB:Initialize() index='..index);
	   end
	--PA:ShowText("Initialise dd index=", index);

	local State, Class, StateId, NotCheckable, Dd;
	if (index<100) then
		State, Class = PA:GetStateClassFromIndex(index);
		Dd = getglobal("PA_SpellSelectDropDown"..index);
	else
		StateId = index - 100;
		State = PA_DCB_States[StateId].Short;
		NotCheckable = 1;
		Dd = getglobal("PA_SpellSetAllDropDown"..StateId);
	end

	local Current = PA:IsCurrentBuffSet(State);
	--PA:ShowText("index=", index, " Current State=", PA_DCB_States[PA:DCB_GetState()].Short, " State=", State, " Current=", Current);

	local Include, Disable = true, false;
    for Buff, _ in pairs(PA.SpellBook.Buffs) do
    	--------------------------------------
    	-- Only populate with relevant spells.
    	--------------------------------------
    	Include, Disable = PA:SuitableBuff(CurrentSet, Buff, State, Class, index, PA.DCBLevel);
		--PA:ShowText(Buff, " Include=", Include, " Disable=", Disable);
    	if (Include==true) then
			PA:SpellSelectDropDown_AddEntry(Buff, PANZA_BUFF_DISPLAY[Buff].Short, index, Current, NotCheckable);
		elseif (Disable==true) then
			break;
		end
    end
    -- There should alway be a nothing entry
	PA:SpellSelectDropDown_AddEntry("SKIP", "-Nothing-", index, Current, NotCheckable);

	-- Show relevant entry
	if (index<100) then
		if (Disable==true) then
			UIDropDownMenu_SetSelectedValue(Dd, "SKIP");
			PA:DisableDropDown(Dd, PA:GetDCBColors(PA.DCBLevel, Current));
		else
			local State, Class = PA:GetStateClassFromIndex(index);
			local Value = PA:GetDCBBlessing(CurrentSet, State, Class, PA.DCBLevel);
			--PA:ShowText("  Setting Dd=", Dd, " to ", Value);
			UIDropDownMenu_SetSelectedValue(Dd, Value);
		end
	else
		UIDropDownMenu_SetText("-Select to Set All-", Dd);
	end
end

function PA:GetDCBBlessing(set, state, class, level)
	if (level==0) then
		return set[state][class];
	end
	PA:CreateDCBLevelIfMissing(set, state, class, level);
	return set[level][state][class];
end

function PA:CreateDCBLevelIfMissing(set, state, class, level)
	if (set[level]==nil or set[level][state]==nil or set[level][state][class]==nil) then
		set[level] = {};
		for StateId, StateInfo in pairs(PA_DCB_States) do
			set[level][StateInfo.Short] = {};
			for ClassId, Class in pairs(PA.DCB_IndexClass) do
				set[level][StateInfo.Short][Class] = "SKIP";
			end
		end
	end
end

function PA_SpellSelectDropDown_OnClick(index)
	if (index==nil or this.value==nil) then
		return;
	end
	if (PA:CheckMessageLevel("UI", 5 )) then
		PA:Message4("DCB:Dropdown Buff: "..this.value.." index: "..index);
	end
	--PA:ShowText("PA_SpellSelectDropDown_OnClick this.value=", this.value, " index=", index);
	if (index<100) then
		-- Normal drop-down
		UIDropDownMenu_SetSelectedValue(getglobal("PA_SpellSelectDropDown"..index), this.value);
		State, Class = PA:GetStateClassFromIndex(index);
		if (PA.DCBLevel==0) then
			CurrentSet[State][Class] = this.value;
		else
			CurrentSet[PA.DCBLevel][State][Class] = this.value;
		end
	else
		-- Set-all drop-down
		local StateId = index - 100;
		local State = PA_DCB_States[StateId].Short;
		for ClassId, Class in pairs(PA.DCB_IndexClass) do
			local DropId = ClassId + (StateId - 1) * 9;
			if (PA:SuitableBuff(CurrentSet, this.value, State, Class, DropId, PA.DCBLevel)) then
				Buff = this.value
			else
				Buff = "SKIP";
			end
			--PA:ShowText(Class, " ", Buff);
			local Dd = getglobal("PA_SpellSelectDropDown"..DropId.."Button");
			if (Dd:IsEnabled()) then
				if (PA.DCBLevel==0) then
					CurrentSet[State][Class] = Buff;
				else
					CurrentSet[PA.DCBLevel][State][Class] = Buff;
				end
			end
		end
		PA:SpellSelectDropDown_InitAllDropDowns();
	end
end

function PA_DCBSelectSaveSet_OnClick()
	PASettings.DCBUseSaved = this.value;
	PA.DCBLevel = 0;
	CurrentSet = PA:GetCurrentSet();
	PA:SpellSelectDropDown_InitAllDropDowns();
end

function PA:DCB_CreateNewSaveSet(name)
	if (name==nil) then
		if (PA:CheckMessageLevel("Bless", 1 )) then
			PA:Message4("DCB Save Set invalid name");
		end
		return;
	end
	name = PA:Trim(name);
	if (string.len(name)==0) then
		if (PA:CheckMessageLevel("Bless", 1 )) then
			PA:Message4("DCB Save Set invalid name");
		end
		return;
	end
	for Index, Set in pairs(PASettings.DCBSaved) do
		if (string.lower(Set.Name)==string.lower(name)) then
			if (PA:CheckMessageLevel("Bless", 1 )) then
				PA:Message4("DCB Save Set "..name.." already exists");
			end
			return;
		end
	end
	PASettings.DCBUseSaved = PASettings.DCBSavedIndex;
	CurrentSet.Name = name;
	PASettings.DCBSaved[PASettings.DCBUseSaved] = PA:CopyTable(CurrentSet);
	if (PA:CheckMessageLevel("Bless", 1 )) then
		PA:Message4("New DCB Save Set "..name.." ("..PASettings.DCBUseSaved..") created");
	end
	PASettings.DCBSavedIndex = PASettings.DCBSavedIndex + 1;
	PA.DCBLevel = 0;
	PA:SpellSelectDropDown_InitAllDropDowns();
end

function PA:DCB_DeleteAllSaved()
	PASettings.DCBSaved = {};
	PASettings.DCBSavedIndex = 1;
	PASettings.DCBUseSaved = 0;
	PA.DCBLevel = 0;
	PA:SpellSelectDropDown_InitAllDropDowns();
end

function PA:DCB_DeleteSaved()
	if (PASettings.DCBUseSaved~=nil and PASettings.DCBSaved[PASettings.DCBUseSaved]~=nil) then
		PASettings.DCBSaved[PASettings.DCBUseSaved] = nil;
	end
	PASettings.DCBUseSaved = 0;
	PA.DCBLevel = 0;
	PA:SpellSelectDropDown_InitAllDropDowns();
end

-----------------------------------------------------------------------------------------------------------------

function PA:SetDefaultBuff(dcbSet, state, class, index, level)
	PA:CreateDCBLevelIfMissing(PASettings[dcbSet], state, class, level);
	local HighestPriority = 999;
	local Buff = "SKIP";
	local ActualClass = class;
	if (class=="SELF") then
		ActualClass = PA.PlayerClass;
	end
    --PA:Debug("state=", state, " level=", level, " class=", class);
    for CheckBuff, _ in pairs(PA.SpellBook.Buffs) do
    	--PA:Debug("Buff=", CheckBuff);
    	if (PA:SuitableBuff(PASettings[dcbSet], CheckBuff, state, class, index, level)==true) then
    		local SpellInfo = PA.SpellBook[CheckBuff];
    		if (SpellInfo~=nil) then
    			-- Check Excluded
    			if (SpellInfo.Exclude==nil or SpellInfo.Exclude[ActualClass]==nil) then
					-- Get Priority
					local Priority = 0;
					if (SpellInfo.Priority~=nil) then
						Priority = SpellInfo.Priority[state];
						if (SpellInfo.Priority.Special~=nil) then
							local Special = SpellInfo.Priority.Special[ActualClass];
							if (Special~=nil and Special[state]~=nil) then
								Priority = Special[state];
							end
						end
					end
					-- Update if Priority Higher
	    			--PA:Debug("  Priority=", Priority);
					if (Priority~=nil and Priority~=0 and Priority<HighestPriority) then
						HighestPriority = Priority;
						Buff = CheckBuff;
	    				--PA:Debug("  NEW HIGHEST!");
					end
				else
	    			--PA:Debug("  Class Excluded");
    			end
    		end
    	else
	    	--PA:Debug("  Unsuitable");
		end
    end
	--PA:Debug("  ", Buff, " chosen");
	if (level==0) then
		PASettings[dcbSet][state][class] = Buff;
	else
		PASettings[dcbSet][level][state][class] = Buff;
	end
end

-----------------------------------------------
-- Default DCB settings depending on spell book
-----------------------------------------------
function PA:InitializeDCB(dcbSet)
	PASettings[dcbSet] = {};
	for StateId, StateInfo in pairs(PA_DCB_States) do
		local State = StateInfo.Short;
		PASettings[dcbSet][State] = {All="SKIP"};
		for ClassId, Class in pairs(PA.DCB_IndexClass) do
			local Index = ClassId + (StateId - 1) * 9;
			for Level=0, 4 do
				PA:SetDefaultBuff(dcbSet, State, Class, Index, Level);
			end
		end
	end
end

function PA:GetComponentCount(groupBuff)
	local Component = PA.SpellBook.GroupBuffs[groupBuff];
	if (Component==nil) then
		return;
	end

	local ComponentTotals = PA:SymbolCount();
	if (type(Component)=="table") then
		local MaxRank = PA:GetSpellProperty(groupBuff, "MaxRank");
		if (MaxRank==nil) then
			MaxRank = 1;
		end
		Component = Component[MaxRank];
		if (Component==nil) then
			return nil;
		end
	end
	return ComponentTotals[Component], Component;
end
-----------------------------------------------------------------------
-- DCBlessing returns shortname buff for class and state from DCB table
-- Arguments:	class ("WARRIOR", "PALADIN", etc)
-- 		state ('solo', 'party', 'raid', or 'bg')
-----------------------------------------------------------------------
function PA:DCBlessing(classEn, state, unit, name)
	PA:Debug("DCBlessing");
	local gbstate, buffindex = "None", {};
	local SpellState, LastSpell, Expires, BuffId, CanBless;

	if (classEn==nil or state==nil) then
		return;
	end

	local StateText;
	-------------------------------------------------
	-- PVP flag, may want to force using BG blessings
	-------------------------------------------------
	if (unit~=nil and PASettings.Switches.PVPUseBG.enabled and UnitIsPVP(unit)) then
		state 		= "bg";
		StateText	= "(PVP)";
	end

	------------------------------------------------------
	-- Calculate what buff to use based on state and class
	------------------------------------------------------
	local shortname;
	local AllText = "";

	PA:Debug("classEn=", classEn, " unit=", unit, " state=", state);

	local gtState = state;
	------------------------------------------------
	-- Do not use party greater blessing for raid/bg
	------------------------------------------------
	local InBG = PA:IsInBG();
	local InRaid = PA:IsInRaid();
	if (state=="party" and (InBG or InRaid)) then
		if (InBG) then
			gtState = "bg";
		else
			gtState = "raid";
		end
		if (PASettings.Switches.IgnorePartyInRaid.enabled==true) then
			state = gtState;
		end
	end

	if (name==nil) then
		name = PA:UnitName(unit);
		local Owner = PA:GetUnitsOwner(unit);
		if (Owner~=nil) then
			name = Owner.."_"..name;
		end
	end

	local Group = false;

	--PA:Debug("GreaterBlessings["..string.upper(gtState).."]=", PASettings.Switches.GreaterBlessings[string.upper(gtState)]);
	--PA:Debug("PA:IsInParty()=", PA:IsInParty(), " UnitInParty(", unit, ")=", UnitInParty(unit));
	--PA:Debug("InRaid=", InRaid, " UnitInRaid(", unit, ")=", UnitInRaid(unit));
	--PA:Debug("GreaterBlessings.SOLO=", PASettings.Switches.GreaterBlessings.SOLO);
	if (PASettings.Switches.GreaterBlessings[string.upper(gtState)]==true and
	   ((PA:IsInParty() and (UnitInParty(unit) or UnitIsUnit('player', unit))) or (InRaid and UnitInRaid(unit)) or
	   (classEn=="SELF" and PASettings.Switches.GreaterBlessings.SOLO==true))) then

		if (PA:CheckMessageLevel("Bless", 5)) then
			PA:Message4("Using Group Buffs if possible.");
		end
		PA:Debug("Using Group Buffs if possible.");

		-----------------------------------------------------------------
		-- Do not use self group buffs in raid/bg/party
		-----------------------------------------------------------------
		local GTClass = classEn;
		if (state~="solo" and classEn=="SELF") then
			GTClass = PA.PlayerClass;
		end

		GroupBuff, AllText, SpellState, LastSpell, Expires, BuffId = PA:GetLevelBestBuff(unit, name, gtState, GTClass, true);
		PA:Debug("GT-Bless: SpellState=", SpellState, " LastSpell=", LastSpell, " Expires=", Expires, " BuffId=", BuffId);
		if (GroupBuff~=nil and GroupBuff~="SKIP" and GroupBuff~="NOREQ") then

			local ComponentCount, ComponentName = PA:GetComponentCount(GroupBuff)

			--PA:Debug("ComponentCount=", ComponentCount);
			if (ComponentCount~=0) then
				if (PA:CheckMessageLevel("Bless", 4)) then
					PA:Message4("Group Buff is "..tostring(GroupBuff));
				end
				shortname = GroupBuff;
				Group = true;
			elseif (ComponentCount==0) then
				if (PA:CheckMessageLevel("Bless", 1)) then
					PA:Message4("Not enough "..ComponentName.. " to cast "..PA:GetSpellProperty(GroupBuff, "Name"));
				end
			end
		end
	end

	--PA:Debug("shortname(gt)=", shortname);
	if (shortname==nil) then
		shortname, AllText, SpellState, LastSpell, Expires, BuffId = PA:GetLevelBestBuff(unit, name, state, classEn, false);
		Group = false;
	end

	if (StateText==nil) then
		if (string.len(state)>2) then
			StateText = PA:Capitalize(state);
		else
			StateText = string.upper(state);
		end
	end
	--PA:Debug("shortname=", shortname);
	--PA:Debug("StateText=", StateText);
	return shortname, "("..StateText..AllText..")", SpellState, LastSpell, Expires, BuffId;
end

function PA:GetLevelBestBuff(unit, name, state, class, group)
	local Short, AllText;
	local Level = 0;
	local Set;
	local SetBuffs = {};
	local SpellState, LastSpell, Expires, BuffId, CanBuff, BuffExpires;
	local HadValid = false;
	local MaxLevel = 3;
	PA:Debug("==GetLevelBestBuff==");
	PA:Debug("  unit=", unit, " name=", name, " state=", state, " class=", class);
	while (Level<=MaxLevel) do
		PA:Debug("  Level=", Level);
		if (PASettings.DCBUseSaved==0) then
			Set = PASettings.DCB;
			AllText = "";
		else
			Set = PASettings.DCBSaved[PASettings.DCBUseSaved];
			AllText = "-"..Set.Name;
		end
		if (Level==0) then
			Short = Set[state][class];
		else
			if (Set[Level]==nil) then
				if (HadValid==true) then
					Short = "NOREQ";
				else
					Short="SKIP";
				end
				PA:Debug("    EXIT (LAST)");
				break; -- no more levels defined
			end
			Short = Set[Level][state][class];
		end
		if (Short=="SKIP") then
			if (HadValid==true) then
				Short = "NOREQ";
			end
			PA:Debug("    EXIT (SKIP)");
			break;
		end
		local ShortSaved = Short;
		if (group==true) then
			Short = PA.SingleToGroup[Short]
		end
		if (Short~=nil) then
			PA:Debug("    Buff for this level=", Short);
			local BuffId = PA:GetSpellProperty(Short, "BuffId");
			PA:Debug("    BuffId=", BuffId, " SetBuffs[BuffId]=", SetBuffs[BuffId]);
			if (BuffId==nil or SetBuffs[BuffId]==nil) then
				SpellState, LastSpell, BuffExpires, BuffId, CanBuff = PA:GetSpellState(unit, name, Short);
				if (SpellState~=nil) then
					HadValid = true;
				end
				if (BuffExpires~=nil and (Expires==nil or BuffExpires<Expires)) then -- Get expiry for soonest to expire buff
					Expires = BuffExpires;
				end
				PA:Debug("  SpellState=", SpellState, " LastSpell=", LastSpell, " Expires=", Expires, " BuffId=", BuffId, " CanBuff=", CanBuff);
				if (CanBuff) then
					break;
				end
				if ((SpellState==PA_SPELL_SET or group==true) and BuffId~=nil) then
					SetBuffs[BuffId] = true;
				end
			else
				PA:Debug("    Can't buff with this, buff with Id="..BuffId.." already set");
			end
		else
			PA:Debug("    Can't buff with this, ", ShortSaved ," has no group equivalent");
		end
		Level = Level + 1;
	end
	if (Level>MaxLevel) then
		Short = "NOREQ";
	end
	if (Level>0) then
		AllText = AllText.." Level "..Level;
	end
	return Short, AllText, SpellState, LastSpell, Expires;
end


-- Get the state of a given buff on a named player
-- Returns State, LastSpell and ExpiryTime
function PA:GetSpellState(unit, name, short)
	PA:Debug("GetSpellState unit=", unit, " name=", name, " short=", short);
	--Target Level check
	local CurUnitLevel = UnitLevel(unit);
	if (PA.Spells.Levels~=nil) then
		PA:Debug("  Levels[short]=", PA.Spells.Levels[short]);
	else
		PA:Debug("  PA.Spells.Levels is nil");
	end
	if (CurUnitLevel~=nil and PA.Spells.Levels~=nil and PA.Spells.Levels[short]~=nil and CurUnitLevel < PA.Spells.Levels[short][1] - 10) then
		PA:Debug("  UnitLevel(unit)=", CurUnitLevel, " [1]=", PA.Spells.Levels[short][1]);
		PA:Debug("  unit level too low");
		return nil, nil, nil, nil, false;
	end
	if (name~=nil) then
		local HasBuff, IsGroup = PA:UnitHasBlessing(unit, short, true);
		PA:Debug("  HasBuff=", HasBuff, " IsGroup=", IsGroup);
		local LastSpellSet = PACurrentSpells.Indi[name];
		local Id = PA:GetSpellProperty(short, "BuffId");
		PA:Debug("  Id=", Id);
		if (Id~=nil) then
			PA:Debug("  LastSpellSet=", LastSpellSet);
			if (LastSpellSet~=nil) then
				local LastSpell = PACurrentSpells.Indi[name][Id];
				PA:Debug("  LastSpell=", LastSpell);
				if (LastSpell~=nil) then
					local LastShort = LastSpell.Short;
					PA:Debug("  LastShort=", LastShort);
					if (LastShort~=nil and PA.SpellBook[LastShort].Duration~=nil) then
						local ExpiresIn = PA.SpellBook[LastShort].Duration - GetTime() + LastSpell.Time
						PA:Debug("  Duration=", PA.SpellBook[LastShort].Duration, " Time=", GetTime(), " LastSpell=", LastSpell.Time, " ExpiresIn=", ExpiresIn);
						-- Do not overwrite short duration buffs
						if (PA.SpellBook[LastShort].Duration<300 and ExpiresIn>0) then
							PA:Debug("  "..LastShort.." is a short duration spell, do not overwrite");
							return PA_SPELL_SET, LastSpell, ExpiresIn, Id, false;
						end
						-- Single buffs can't overwrite group buffs
						PA:Debug("  HasBuff=", HasBuff, " short=", short, " shortGroup=", PA.SingleToGroup[short]);
						if (PA.SingleToGroup[short]~=nil) then
							PA:Debug("  IsGroup=", IsGroup, " LastShort=", LastShort, " shortGroup=", PA.SingleToGroup[short], " LastSpellGreater=", (PA.SpellBook.GroupBuffs[LastShort]~=nil));
							if ((HasBuff and (IsGroup==true or PA.SingleToGroup[short]==LastShort)) or PA.SpellBook.GroupBuffs[LastShort]~=nil) then
								return PA_SPELL_SET, LastSpell, ExpiresIn, Id, false;
							end
						end
						if (HasBuff) then
							if (LastShort==short) then
								local CanBless = false;
								PA:Debug("  LastSpell.Reset=", LastSpell.Reset);
								if (LastSpell.Reset==true) then
									ExpiresIn = -1000;
									CanBless = true;
								elseif (ExpiresIn<PASettings.Switches.Rebless) then
									CanBless = true
								end
								return PA_SPELL_SET, LastSpell, ExpiresIn, Id, CanBless;
							end
							return PA_SPELL_DIFFERENT, LastSpell, ExpiresIn, Id, true;
						end
					end
				end
			end
		end
		if (HasBuff) then
			-- External
			PA:Debug("  Buff ", short, " externally set");
			return PA_SPELL_EXTERNAL, nil, nil, Id, false;
		end
	end
	return PA_SPELL_FREE, nil, -1000, nil, true;
end

--------------------------------------
-- Generic Tooltip Function
--------------------------------------
function PA:DCB_ShowTooltip(item)
	GameTooltip:SetOwner( getglobal(item:GetName()), "ANCHOR_TOP" );
	GameTooltip:ClearLines();
	GameTooltip:ClearAllPoints();
	GameTooltip:SetPoint("TOPLEFT", item:GetName(), "BOTTOMLEFT", 0, -2);
	GameTooltip:AddLine( PA.DCB_Tooltips[item:GetName()].tooltip1 );
	GameTooltip:AddLine( PA.DCB_Tooltips[item:GetName()].tooltip2, 1, 1, 1, 1, 1 );
	GameTooltip:Show();
end

--[[

PanzaPAMCustom.lua
Panza Custom Message Settings Dialog
Revision 4.0

10-01-06 "for in pairs()" completed for BC
--]]

local CurDamageSpell;

PA.DamageMessageDefaults = {};
PA.DamageMessageDefaults["HitMessage"]	= "%1$s's %2$s splats %3$s for %4$d damage";
PA.DamageMessageDefaults["CritMessage"]	= "%1$s's %2$s double splats %3$s for %4$d damage";
if (UnitSex("player")==3) then
	PA.DamageMessageDefaults["HitEmote"]	= "splats %3$s for %4$d damage with her %2$s";
	PA.DamageMessageDefaults["CritEmote"]	= "double splats %3$s for %4$d damage with her %2$s";
elseif  (UnitSex("player")==2) then
	PA.DamageMessageDefaults["HitEmote"]	= "splats %3$s for %4$d damage with his %2$s";
	PA.DamageMessageDefaults["CritEmote"]	= "double splats %3$s for %4$d damage with his %2$s";
else
	PA.DamageMessageDefaults["HitEmote"]	= "splats %3$s for %4$d damage with its %2$s";
	PA.DamageMessageDefaults["CritEmote"]	= "double splats %3$s for %4$d damage with its %2$s";
end


function PA:PAMCustom_OnLoad()
	PA.GUIFrames[this:GetName()] = this;
	UIPanelWindows[this:GetName()] = {area = "center", pushable = 0};
end

function PA:PAMCustom_SetValues()
	PA_ResurrectEditBox:SetText(PASettings.RezMessage);

	if (CurDamageSpell~=nil and PASettings.Damage[CurDamageSpell]~=nil) then
		cbxPanzaPAMXDamageEnable:SetChecked(PASettings.Damage[CurDamageSpell].Enabled==true);
		cbxPanzaPAMXDamageParty:SetChecked(PASettings.Damage[CurDamageSpell].Party==true);
		cbxPanzaPAMXDamageRaid:SetChecked(PASettings.Damage[CurDamageSpell].Raid==true);
		cbxPanzaPAMXDamageSay:SetChecked(PASettings.Damage[CurDamageSpell].Say==true);
		cbxPanzaPAMXDamageEM:SetChecked(PASettings.Damage[CurDamageSpell].EM==true);

		cbxPanzaPAMXDamageHitMessage:SetChecked(PASettings.Damage[CurDamageSpell].Hit==true);
		cbxPanzaPAMXDamageCritMessage:SetChecked(PASettings.Damage[CurDamageSpell].Crit==true);

		edtPanzaPAMXDamageHitMessage:SetText(PASettings.Damage[CurDamageSpell].HitMessage);
		edtPanzaPAMXDamageHitEmote:SetText(PASettings.Damage[CurDamageSpell].HitEmote);
		edtPanzaPAMXDamageCritMessage:SetText(PASettings.Damage[CurDamageSpell].CritMessage);
		edtPanzaPAMXDamageCritEmote:SetText(PASettings.Damage[CurDamageSpell].CritEmote);
	end

end

function PA:PAMCustom_OnShow()
	PA:Reposition(PanzaPAMCustomFrame, "UIParent", true);
	PanzaPAMCustomFrame:SetAlpha(PASettings.Alpha);
	PA:PAMCustom_SetValues();
	PanzaPAMCustomFrame:Raise();
	UIDropDownMenu_Initialize(DamageSpellSelect, PA_PAMX_DamageSpells_Initialize);
end

function PA:PAMCustom_OnHide()
	-- place holder
end

function PA:PAMCustom_btnDone_OnClick()
	PA:SetRezMessage(PA_ResurrectEditBox:GetText());
	PA:SetAllDamageMessages();

	HideUIPanel(PanzaPAMCustomFrame);
end

function PA:SetAllDamageMessages()
	PASettings.Damage[CurDamageSpell].Hit  =	(cbxPanzaPAMXDamageHitMessage:GetChecked()==1);
	PASettings.Damage[CurDamageSpell].Crit =	(cbxPanzaPAMXDamageCritMessage:GetChecked()==1);

	PASettings.Damage[CurDamageSpell].Enabled =	(cbxPanzaPAMXDamageEnable:GetChecked()==1);
	PASettings.Damage[CurDamageSpell].Party =	(cbxPanzaPAMXDamageParty:GetChecked()==1);
	PASettings.Damage[CurDamageSpell].Raid =	(cbxPanzaPAMXDamageRaid:GetChecked()==1);
	PASettings.Damage[CurDamageSpell].Say =		(cbxPanzaPAMXDamageSay:GetChecked()==1);
	PASettings.Damage[CurDamageSpell].EM =		(cbxPanzaPAMXDamageEM:GetChecked()==1);
	PA:SetDamageMessage("HitMessage", edtPanzaPAMXDamageHitMessage:GetText());
	PA:SetDamageMessage("CritMessage", edtPanzaPAMXDamageCritMessage:GetText());
	PA:SetDamageMessage("HitEmote", edtPanzaPAMXDamageHitEmote:GetText());
	PA:SetDamageMessage("CritEmote", edtPanzaPAMXDamageCritEmote:GetText());
end

function PA_PAMX_DamageSpells_Initialize()
	local Index = 1;
	local Set = false;
	for Spell, Short in pairs(PA.SpellBook.Damage) do
		if (Index==1 and CurDamageSpell==nil) then
		 	CurDamageSpell = Short;
		 	Set = true;
		end
		PA:PAMX_DamageSpells_AddEntry(Short, Short, Spell, Index);
		Index = Index + 1;
	end
	UIDropDownMenu_SetSelectedValue(DamageSpellSelect, CurDamageSpell);
	if (Set==true) then
		PA:PAMCustom_SetValues();
	end
end

function PA:PAMX_DamageSpells_AddEntry(ddID, short, text, index)
	if (PA:CheckMessageLevel("UI", 5)) then
		PA:Message4(" text = "..text.." short="..short.." index="..index);
	end
	local info = {};
	info.text = text;
	info.value = short;
	info.func = PA_SpellDamageDropDown_OnClick;
	info.arg1 = index;
	UIDropDownMenu_AddButton(info);
end

function PA_SpellDamageDropDown_OnClick(index)
	if (index==nil or this.value==nil or CurDamageSpell==this.value) then
		return;
	end
	PA:SetAllDamageMessages();
	CurDamageSpell = this.value;
	UIDropDownMenu_SetSelectedValue(DamageSpellSelect, this.value);
	PA:PAMCustom_SetValues();
end

--------------------------------------
-- Generic Tooltip Function
--------------------------------------
function PA:PAMCustom_ShowTooltip(item, damageType, rez)
	GameTooltip:SetOwner(item, "ANCHOR_TOPRIGHT");
	GameTooltip:ClearLines();
	--GameTooltip:ClearAllPoints();
	--GameTooltip:SetPoint("CENTER", item, "CENTER");
	--GameTooltip:AddLine(PA.PAMCustom_Tooltips[item:GetName()].tooltip1);
	local TipIndex = 1;
	local TipLine = PA.PAMCustom_Tooltips[item:GetName()]["tooltip"..TipIndex];
	while (TipLine~=nil) do
		if (item~=btnPanzaPAMXDamageHelp and item~=btnPanzaPAMXRezHelp) then
			TipLine = format(TipLine, PA:GetSpellProperty(CurDamageSpell, "Name"));
		end	
		if (TipIndex==1) then
			GameTooltip:AddLine(TipLine);
		else
			GameTooltip:AddLine(TipLine, 1, 1, 1, 1, 1);
		end
		TipIndex = TipIndex + 1;
		TipLine = PA.PAMCustom_Tooltips[item:GetName()]["tooltip"..TipIndex];
	end
	if (damageType~=nil) then
		PA:SetDamageMessage(damageType, item:GetText());
		local Prefix = "";
		if (string.find(damageType, "Emote")~=nil) then
			Prefix = PA_ORANGE..PA.PlayerName.." ";
		end
		GameTooltip:AddLine(Prefix..format(PASettings.Damage[CurDamageSpell][damageType], PA.PlayerName, PA.SpellBook[CurDamageSpell].Name, "Onyxia", 987, "Holy"));
	elseif (rez==true) then
		PA:SetRezMessage(item:GetText());
		GameTooltip:AddLine(format(PASettings["RezMessage"], "Lazarus", 10, PA.PlayerName));
	end
	GameTooltip:Show();
end

function PA_RezMessageCheck(pattern)
    if unexpected_condition then error() end
	local dummy = format(pattern, "Name", 12, "Name");
end

function PA:SetRezMessage(text)
	if (text~=PASettings["RezMessage"]) then
		--PA:ShowText("Checking text=", text);
		if (pcall(PA_RezMessageCheck, text)) then
			if (PA:CheckMessageLevel("Core", 4)) then
				PA:Message4("Resurrection message valid");
			end
		else
			if (PA:CheckMessageLevel("Core", 1)) then
				PA:Message4("Invalid resurrection message: "..text);
				PA:Message4("Resetting message to "..PANZA_MSG_RESURRECTING);
			end
			text = PANZA_MSG_RESURRECTING;
		end
		PASettings["RezMessage"] = text;
		PA_ResurrectEditBox:SetText(PASettings.RezMessage);
	end
end

function PA_DamageMessageCheck(pattern)
    if unexpected_condition then error() end
	local dummy = format(pattern, "Name", "Spell", "Target", 123, "School");
end

function PA:SetDamageMessage(damageType, text)
	if (text~=PASettings.Damage[CurDamageSpell][damageType]) then
		--PA:ShowText("Checking text=", text);
		if (pcall(PA_DamageMessageCheck, text)) then
			if (PA:CheckMessageLevel("Core", 4)) then
				PA:Message4("Damage "..damageType.." message valid");
			end
			PA.DamageLastGood[damageType] = text;
		else
			if (PA:CheckMessageLevel("Core", 1)) then
				PA:Message4("Invalid Damage "..damageType.." message: "..text);
			end
			if (PA.DamageLastGood[damageType]~=nil) then
				text = PA.DamageLastGood[damageType];
			else
				text = PA.DamageMessageDefaults[damageType];
			end
			if (PA:CheckMessageLevel("Core", 1)) then
				PA:Message4("Resetting message to "..text);
			end
		end
		PASettings.Damage[CurDamageSpell][damageType] = text;
		local TextBox = getglobal("edtPanzaPAMXDamage"..damageType)
		TextBox:SetText(text);
	end
end

function PA:PAMCustom_Defaults()
	PASettings["RezMessage"] = PANZA_MSG_RESURRECTING;
	PA:PAMCustom_DamageDefaults();
end

function PA:PAMCustom_DamageDefaults()
	PA.DamageLastGood = {}
	for key, value in pairs(PA.DamageMessageDefaults) do
		PA.DamageLastGood[key]	= value;
	end
	PASettings.Damage = {};
	if (PA.SpellBook~=nil and PA.SpellBook.Damage~=nil) then
		for Spell, Short in pairs(PA.SpellBook.Damage) do
			PA:ResetDamageSpell(Short);
		end
	end
end

function PA:ResetDamageSpell(short)
	PASettings.Damage[short] = {
		Hit		= false,
		Crit	= false,
		Enabled	= false,
		Party	= false,
		Raid	= false,
		Whisper	= false,
		Say		= false,
		EM		= false
	};
	for MessageType, MessagePattern in pairs(PA.DamageMessageDefaults) do
		PASettings.Damage[short][MessageType] = MessagePattern;
	end
end

--[[

PaanzSTA.lua
Panza Advanced Status and About Box
Revision 4.0

--]]


function PA:STA_OnLoad()
	PA.OptionsMenuTree[2] = {Title="Status", Frame=this, Tooltip="Status"};
	PA.GUIFrames[this:GetName()] = this;
	UIPanelWindows[this:GetName()] = {area = "center", pushable = 0};
end

function PA:STA_SetValues()
	local txt;


	-- txtPanzaSTALx:SetText(txt);

	if (PASettings.Switches.EnableWarn == true) then
		txt = PANZA_WARNINGS;
	else
		txt = PANZA_NOWARNINGS;
	end
	txtPanzaSTAL1:SetText(txt);

	if (PASettings.Switches.EnableSelf == true) then
		txt = PANZA_SELFBLESSING_ENABLED;
	else
		txt = PANZA_SELFBLESSING_DISABLED;
	end
	txtPanzaSTAL2:SetText(txt);

	if (PASettings.Switches.EnableSave == true) then
		txt = PANZA_SAVEBLESSING_ENABLED;
	else
		txt = PANZA_SAVEBLESSING_DISABLED;
	end
	txtPanzaSTAL3:SetText(txt);

	txt = format(PANZA_PET_THRESHOLD,(PASettings.Heal.PetTH * 100).."%")
	txtPanzaSTAL4:SetText(txt);

	txt = format(PANZA_MINHEALTH_THRESHOLD,(PASettings.Heal.MinTH * 100).."%");
	txtPanzaSTAL5:SetText(txt);

	txt = format(PANZA_FOL_HEALTH_THRESHOLD,(PASettings.Heal.Flash * 100).."%");
	txtPanzaSTAL6:SetText(txt);

	txt = format(PANZA_FOL_MANA_THRESHOLD,(PASettings.Heal.FolTH * 100).."%");
	txtPanzaSTAL7:SetText(txt);

	if (PASettings.Switches.AutoList == true) then
		txt = PANZA_AUTOLIST_ENABLED;
		txtPanzaSTAL8:SetText(txt);
	else
		txt = PANZA_AUTOLIST_DISABLED;
		txtPanzaSTAL8:SetText(txt);
	end

	txt = format(PANZA_SAVELIST, PA:TableSize(PASettings.BlessList));
	txtPanzaSTAL10:SetText(txt);

	txtPanzaSTAL10:SetText(PA:MapLibrary("STATUS"));

	___, txt = PA:HealingBonus("STATUS");
	txtPanzaSTAL11:SetText(txt);

	if (PASettings.Switches.UseActionRange.Heal==true
	 or PASettings.Switches.UseActionRange.Bless==true
	 or PASettings.Switches.UseActionRange.Cure==true
	 or PASettings.Switches.UseActionRange.Free==true) then
		if (PA:ActionInRange(20)~=nil) then
			txtPanzaSTAL12:SetText(format(SPELL_RANGE, "20").." ("..ACTIONBAR_LABEL..") "..OKAY);
		else
			txtPanzaSTAL12:SetText(format(SPELL_RANGE, "20").." ("..ACTIONBAR_LABEL..") "..ADDON_MISSING);
		end
		if (PA:ActionInRange(30)~=nil) then
			txtPanzaSTAL13:SetText(format(SPELL_RANGE, "30").." ("..ACTIONBAR_LABEL..") "..OKAY);
		else
			txtPanzaSTAL13:SetText(format(SPELL_RANGE, "30").." ("..ACTIONBAR_LABEL..") "..ADDON_MISSING);
		end
		if (PA:ActionInRange(40)~=nil) then
			txtPanzaSTAL14:SetText(format(SPELL_RANGE, "40").." ("..ACTIONBAR_LABEL..") "..OKAY);
		else
			txtPanzaSTAL14:SetText(format(SPELL_RANGE, "40").." ("..ACTIONBAR_LABEL..") "..ADDON_MISSING);
		end
	else
		txtPanzaSTAL12:SetText(format(SPELL_RANGE, "20").." ("..ACTIONBAR_LABEL..") "..ADDON_DISABLED);
		txtPanzaSTAL13:SetText(format(SPELL_RANGE, "30").." ("..ACTIONBAR_LABEL..") "..ADDON_DISABLED);
		txtPanzaSTAL14:SetText(format(SPELL_RANGE, "40").." ("..ACTIONBAR_LABEL..") "..ADDON_DISABLED);
	end

	PA:UpdateComponents();
	if (PA.PlayerClass=="PALADIN") then
		-- Show the Symbol Counters
		txtPanzaSTAL15:SetText(format(PANZA_KINGSCOUNT, PA:Components("kings"), PANZA_KINGSCOUNT_ITEMNAME));
		if (PA.SpellBook.di~=nil and PA.SpellBook.di.Name~=nil) then
			txtPanzaSTAL16:SetText(format(PANZA_DIVINITYCOUNT, PA:Components("divinity"), PANZA_DIVINITYCOUNT_ITEMNAME, PA.SpellBook.di.Name));
		end
	elseif (PA.PlayerClass=="PRIEST") then
		txtPanzaSTAL15:SetText(format(PANZA_FEATHERCOUNT, PA:Components("feathers"), PANZA_FEATHERCOUNT_ITEMNAME));
		txtPanzaSTAL16:SetText(format(PANZA_CANDLECOUNT, PA:Components("holycandles"), PANZA_HOLYCANCOUNT_SHORTNAME, PA:Components("sacredcandles"), PANZA_SACREDCANCOUNT_SHORTNAME));
	
	elseif (PA.PlayerClass=="MAGE") then	
		txtPanzaSTAL15:SetText(format(PANZA_MAGE_FEATHERCOUNT, PA:Components("feathers"), PANZA_FEATHERCOUNT_ITEMNAME));
	end
end


function PA:STA_OnShow()
	PA:Reposition(PanzaSTAFrame, "UIParent", true);
	PanzaSTAFrame:SetAlpha(PASettings.Alpha);
	PA:STA_SetValues();
end

function PA:STA_OnHide()
	-- place holder
end

function PA:STA_btnDone_OnClick()
	PA:FrameToggle(PanzaSTAFrame);
end



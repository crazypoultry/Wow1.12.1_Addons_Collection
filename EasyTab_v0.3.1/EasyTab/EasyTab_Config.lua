local myRealm = GetCVar("realmName");
local myChar = UnitName("player");

function EasyTab_Config_OnShow()
	if ( not EasyTab_variablesLoaded ) then
		this:Hide();
		return;
	end
	
	getglobal(this:GetName().."Text_Title"):SetText("EasyTab " .. EASYTAB_VERSION);
	getglobal(this:GetName().."Slider_blDuration"):SetValue( EasyTab_Config[myRealm][myChar].blDuration );
	getglobal(this:GetName().."Slider_blDurationText"):SetText("Blacklist Duration ("..EasyTab_Config[myRealm][myChar].blDuration.." sec.)");
	getglobal(this:GetName().."Check_IgnorePets"):SetChecked( EasyTab_Config[myRealm][myChar].ignorePets );
	getglobal(this:GetName().."Check_IgnoreMinions"):SetChecked( EasyTab_Config[myRealm][myChar].ignoreMinions );
	getglobal(this:GetName().."Check_IgnoreCC"):SetChecked( EasyTab_Config[myRealm][myChar].ignoreCC );
	getglobal(this:GetName().."Check_IgnoreTapped"):SetChecked( EasyTab_Config[myRealm][myChar].ignoreTapped );
end

function EasyTab_Config_OnClick()
	if ( not EasyTab_variablesLoaded ) then
		this:GetParent():Hide();
		return
	end
	
	if ( this:GetName() == (this:GetParent():GetName().."Slider_blDuration") ) then
		EasyTab_Config[myRealm][myChar].blDuration = this:GetValue();
		getglobal(this:GetName().."Text"):SetText("Blacklist Duration ("..this:GetValue().." sec.)");
	elseif ( this:GetName() == (this:GetParent():GetName().."Check_IgnorePets") ) then
		EasyTab_Config[myRealm][myChar].ignorePets = this:GetChecked();
	elseif ( this:GetName() == (this:GetParent():GetName().."Check_IgnoreMinions") ) then
		EasyTab_Config[myRealm][myChar].ignoreMinions = this:GetChecked();
	elseif ( this:GetName() == (this:GetParent():GetName().."Check_IgnoreCC") ) then
		EasyTab_Config[myRealm][myChar].ignoreCC = this:GetChecked();
	elseif ( this:GetName() == (this:GetParent():GetName().."Check_IgnoreTapped") ) then
		EasyTab_Config[myRealm][myChar].ignoreTapped = this:GetChecked();
	end
end
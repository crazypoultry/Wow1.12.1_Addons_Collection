TotemKeys_Version = "1.0";

local TotemKeys_CurrentMenu = "";

function TotemKeys_OnLoad()
	this:RegisterEvent("UPDATE_BINDINGS");
	this:RegisterEvent("VARIABLES_LOADED");
end

function TotemKeys_OnEvent()
	if(event == "UPDATE_BINDINGS") then
		TotemKeys_UpdateBindings();
	elseif(event == "VARIABLES_LOADED") then
		TotemKeys_UpdateBindings();
	end
end

function TotemKeys_Button_OnLoad()
	getglobal(this:GetName().."HotKey"):SetText("test");
	getglobal(this:GetName().."HotKey"):SetTextColor(255,255,255);
	local parent = this:GetParent();
	parent:SetScript("OnEnter", TotemKeys_OnEnterTotemButton);
	parent:SetScript("OnLeave", TotemKeys_OnLeaveTotemButton);
end

function TotemKeys_Button_OnUpdate()
	local parent = this:GetParent();
	if(not parent) then
		DEFAULT_CHAT_FRAME:AddMessage("noparent "..this:GetName());
		return;
	end
	if(parent:IsVisible()) then
		this:Show();
	else
		this:Hide();
	end
	TotemKeys_UpdateElementMenu("Fire");
	TotemKeys_UpdateElementMenu("Earth");
	TotemKeys_UpdateElementMenu("Water");
	TotemKeys_UpdateElementMenu("Air");
end

function TotemKeys_UpdateElementMenu(element)
	local elementframe = getglobal("COE"..element.."Frame");
	if(elementframe.Expanded == true and TotemKeys_CurrentMenu==element) then
		getglobal("TotemKeys"..element.."1Border"):Show();
		getglobal("TotemKeys"..element.."1HotKey"):SetText(TotemKeys_GetBindingKey("TOTEMKEYS_TOTEM1"));
	else
		getglobal("TotemKeys"..element.."1Border"):Hide();
		getglobal("TotemKeys"..element.."1HotKey"):SetText(TotemKeys_GetBindingKey("TOTEMKEYS_"..string.upper(element).."MENU"));
	end
end

function TotemKeys_UpdateBindings()
	-- Fire
	TotemKeysFireHotKey:SetText(TotemKeys_GetBindingKey("TOTEMKEYS_FIREMENU"));
	TotemKeysFire1HotKey:SetText(TotemKeys_GetBindingKey("TOTEMKEYS_TOTEM1"));
	TotemKeysFire2HotKey:SetText(TotemKeys_GetBindingKey("TOTEMKEYS_TOTEM2"));
	TotemKeysFire3HotKey:SetText(TotemKeys_GetBindingKey("TOTEMKEYS_TOTEM3"));
	TotemKeysFire4HotKey:SetText(TotemKeys_GetBindingKey("TOTEMKEYS_TOTEM4"));
	TotemKeysFire5HotKey:SetText(TotemKeys_GetBindingKey("TOTEMKEYS_TOTEM5"));
	
	-- Water
	TotemKeysWaterHotKey:SetText(TotemKeys_GetBindingKey("TOTEMKEYS_WATERMENU"));
	TotemKeysWater1HotKey:SetText(TotemKeys_GetBindingKey("TOTEMKEYS_TOTEM1"));
	TotemKeysWater2HotKey:SetText(TotemKeys_GetBindingKey("TOTEMKEYS_TOTEM2"));
	TotemKeysWater3HotKey:SetText(TotemKeys_GetBindingKey("TOTEMKEYS_TOTEM3"));
	TotemKeysWater4HotKey:SetText(TotemKeys_GetBindingKey("TOTEMKEYS_TOTEM4"));
	TotemKeysWater5HotKey:SetText(TotemKeys_GetBindingKey("TOTEMKEYS_TOTEM5"));
	TotemKeysWater6HotKey:SetText(TotemKeys_GetBindingKey("TOTEMKEYS_TOTEM6"));
	
	-- Air
	TotemKeysAirHotKey:SetText(TotemKeys_GetBindingKey("TOTEMKEYS_AIRMENU"));
	TotemKeysAir1HotKey:SetText(TotemKeys_GetBindingKey("TOTEMKEYS_TOTEM1"));
	TotemKeysAir2HotKey:SetText(TotemKeys_GetBindingKey("TOTEMKEYS_TOTEM2"));
	TotemKeysAir3HotKey:SetText(TotemKeys_GetBindingKey("TOTEMKEYS_TOTEM3"));
	TotemKeysAir4HotKey:SetText(TotemKeys_GetBindingKey("TOTEMKEYS_TOTEM4"));
	TotemKeysAir5HotKey:SetText(TotemKeys_GetBindingKey("TOTEMKEYS_TOTEM5"));
	TotemKeysAir6HotKey:SetText(TotemKeys_GetBindingKey("TOTEMKEYS_TOTEM6"));
	TotemKeysAir7HotKey:SetText(TotemKeys_GetBindingKey("TOTEMKEYS_TOTEM7"));
	
	-- Earth
	TotemKeysEarthHotKey:SetText(TotemKeys_GetBindingKey("TOTEMKEYS_EARTHMENU"));
	TotemKeysEarth1HotKey:SetText(TotemKeys_GetBindingKey("TOTEMKEYS_TOTEM1"));
	TotemKeysEarth2HotKey:SetText(TotemKeys_GetBindingKey("TOTEMKEYS_TOTEM2"));
	TotemKeysEarth3HotKey:SetText(TotemKeys_GetBindingKey("TOTEMKEYS_TOTEM3"));
	TotemKeysEarth4HotKey:SetText(TotemKeys_GetBindingKey("TOTEMKEYS_TOTEM4"));
	TotemKeysEarth5HotKey:SetText(TotemKeys_GetBindingKey("TOTEMKEYS_TOTEM5"));
end

function TotemKeys_GetBindingKey(key)
	key = GetBindingKey(key);
	if(not key) then
		return "";
	end
	return string.gsub(key, "CTRL", "C");
end

function TotemKeys_SetMenu(menu, dontEnter)	
	this = getglobal("COETotem"..menu.."1");
	if(this:IsVisible()) then		
		if(TotemKeys_CurrentMenu~="") then
			this = getglobal("COETotem"..TotemKeys_CurrentMenu.."1");
			COE_Totem:OnLeaveTotemButton();
		end
		TotemKeys_CurrentMenu = menu;
		
		if(not dontEnter or (dontEnter and dontEnter<1)) then
			this = getglobal("COETotem"..menu.."1");
			COE_Totem:OnEnterTotemButton();
			GameTooltip:Hide();
		end
	else
		element = getglobal("TOTEMKEYS_ELEMENT_"..string.upper(menu));
		DEFAULT_CHAT_FRAME:AddMessage(string.format(TOTEMKEYS_NOT_THIS_ELEMENT, element));
	end
end

function TotemKeys_ThrowTotem(index)
	if(TotemKeys_CurrentMenu=="") then
		DEFAULT_CHAT_FRAME:AddMessage(TOTEMKEYS_NO_MENU);
		return;
	end
	this = getglobal("COETotem"..TotemKeys_CurrentMenu..index);
	if(this and this:IsVisible()) then
		COE_Totem:OnTotemButtonClick();
	else
		DEFAULT_CHAT_FRAME:AddMessage(string.format(TOTEMKEYS_NO_TOTEM, getglobal("TOTEMKEYS_ELEMENT_"..string.upper(TotemKeys_CurrentMenu)),index));
	end
end

function TotemKeys_DeselectMenu()
	if(TotemKeys_CurrentMenu~="") then
		this = getglobal("COETotem"..TotemKeys_CurrentMenu.."1");
		COE_Totem:OnLeaveTotemButton();
		TotemKeys_CurrentMenu = "";
	end
end

function TotemKeys_OnEnterTotemButton()
	local name = this:GetName();
	if(not string.find(name,"%d")) then
		return;
	end
	local element = string.sub(name, 9, -2);
	savedthis = this;
	TotemKeys_SetMenu(element, 1);
	this = savedthis;
	COE_Totem:OnEnterTotemButton();
end

function TotemKeys_OnLeaveTotemButton()
	local name = this:GetName();
	if(not string.find(name,"%d")) then
		return;
	end
	TotemKeys_CurrentMenu = "";
	COE_Totem:OnLeaveTotemButton();
end

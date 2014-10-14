--[[
	Totem Menu v0.01


	This AddOn will display a frame for totems.

]]

local TotemNames = {}; 

if ( GetLocale() == "frFR" ) then
	
	TotemNames["FIRE_SEARING_TOTEM"] = "Totem incendiaire";
	TotemNames["FIRE_MAGMA_TOTEM"] = "Totem de Magma";
	TotemNames["FIRE_NOVA_TOTEM"] = "Totem Nova de feu";
	TotemNames["FIRE_FLAMETONGUE_TOTEM"] = "Totem Langue de feu";
	TotemNames["FIRE_FROST_RESISTANCE_TOTEM"] = "Totem de r\195\169sistance au Givre";

	TotemNames["EARTH_STONESKIN_TOTEM"] = "Totem de Peau de pierre" ;
	TotemNames["EARTH_STRENGTH_TOTEM"] = "Totem de Force de la Terre" ;
	TotemNames["EARTH_BIND_TOTEM"] = "Totem de lien terrestre" ;
	TotemNames["EARTH_STONECLAW_TOTEM"] = "Totem de Griffes de pierre" ;
	TotemNames["EARTH_TREMOR_TOTEM"] = "Totem de S\195\169isme" ;
	TotemNames["AIR_TRANQUIL_AIR_TOTEM"] = "Totem de Tranquillit\195\169 de l\'air" ;

	TotemNames["AIR_GRACE_TOTEM"] = "Totem de Gr\195\162ce a\195\169rienne" ;
	TotemNames["AIR_GROUNDING_TOTEM"] = "Totem de Gl\195\168be" ;
	TotemNames["AIR_WINDWALL_TOTEM"] = "Totem de Mur des vents" ;
	TotemNames["AIR_SENTRY_TOTEM"] = "Totem Sentinelle" ;
	TotemNames["AIR_WINDFURY_TOTEM"] = "Totem Furie-des-vents" ;
	TotemNames["AIR_NATURE_RESISTANCE_TOTEM"] = "Totem de r\195\169sistance \195\160 la Nature" ;

	TotemNames["WATER_HEALING_TOTEM"] = "Totem gu\195\169risseur" ;
	TotemNames["WATER_MANA_TOTEM"] = "Totem Fontaine de mana" ;
	TotemNames["WATER_FIRE_RESISTANCE_TOTEM"] = "Totem de r\195\169sistance au feu" ;
	TotemNames["WATER_DISEASE_TOTEM"] = "Totem de Purification des maladies" ;
	TotemNames["WATER_POISON_TOTEM"] = "Totem de Purification du poison" ;



end

if ( GetLocale() == "enGB" ) or ( GetLocale() == "enUS" ) then
	
	TotemNames["FIRE_SEARING_TOTEM"] = "Searing totem"; 
	TotemNames["FIRE_MAGMA_TOTEM"] = "Magma Totem"; 
	TotemNames["FIRE_NOVA_TOTEM"] = "Fire Nova Totem"; 
	TotemNames["FIRE_FLAMETONGUE_TOTEM"] = "Flametongue Totem"; 
	TotemNames["FIRE_FROST_RESISTANCE_TOTEM"] = "Frost Resistance Totem"; 
	
	TotemNames["EARTH_STONESKIN_TOTEM"] = "Stoneskin Totem" ;
	TotemNames["EARTH_STRENGTH_TOTEM"] = "Strength of Earth Totem" ;
	TotemNames["EARTH_BIND_TOTEM"] = "Earthbind Totem" ;
	TotemNames["EARTH_STONECLAW_TOTEM"] = "Stoneclaw Totem" ;
	TotemNames["EARTH_TREMOR_TOTEM"] = "Tremor Totem" ;
	TotemNames["AIR_TRANQUIL_AIR_TOTEM"] = "Tranquil Air Totem" ;
	
	TotemNames["AIR_GRACE_TOTEM"] = "Grace of Air Totem" ;
	TotemNames["AIR_GROUNDING_TOTEM"] = "Grounding Totem" ;
	TotemNames["AIR_WINDWALL_TOTEM"] = "Windwall Totem" ;
	TotemNames["AIR_SENTRY_TOTEM"] = "Sentry Totem" ;
	TotemNames["AIR_WINDFURY_TOTEM"] = "Windfury Totem" ;
	TotemNames["AIR_NATURE_RESISTANCE_TOTEM"] = "Nature Resistance Totem" ;
	
	TotemNames["WATER_HEALING_TOTEM"] = "Healing Stream Totem" ;
	TotemNames["WATER_MANA_TOTEM"] = "Mana Spring Totem" ;
	TotemNames["WATER_FIRE_RESISTANCE_TOTEM"] = "Fire Resistance Totem" ;
	TotemNames["WATER_DISEASE_TOTEM"] = "Disease Cleansing Totem" ;
	TotemNames["WATER_POISON_TOTEM"] = "Poison Cleansing Totem" ;
	TotemNames["WATER_MANA_TIDE_TOTEM"] = "Mana Tide Totem" ;


end


if ( GetLocale() == "deDE" ) then
	
	TotemNames["FIRE_SEARING_TOTEM"] = "Totem der Verbrennung"; 
	TotemNames["FIRE_MAGMA_TOTEM"] = "Totem der gl\195\188henden Magma"; 
	TotemNames["FIRE_NOVA_TOTEM"] = "Totem der Feuernova"; 
	TotemNames["FIRE_FLAMETONGUE_TOTEM"] = "Totem der Flammenzunge"; 
	TotemNames["FIRE_FROST_RESISTANCE_TOTEM"] = "Totem des Frostwiderstands"; 
	
	TotemNames["EARTH_STONESKIN_TOTEM"] = "Totem der Steinhaut" ;
	TotemNames["EARTH_STRENGTH_TOTEM"] = "Totem der Erdst\195\164rke" ;
	TotemNames["EARTH_BIND_TOTEM"] = "Totem der Erdbindung" ;
	TotemNames["EARTH_STONECLAW_TOTEM"] = "Totem der Steinklaue" ;
	TotemNames["EARTH_TREMOR_TOTEM"] = "Totem des Erdsto\195\159es" ;
	TotemNames["AIR_TRANQUIL_AIR_TOTEM"] = "Totem der beruhigenden Winde" ;
	
	TotemNames["AIR_GRACE_TOTEM"] = "Totem der luftgleichen Anmut" ;
	TotemNames["AIR_GROUNDING_TOTEM"] = "Totem der Erdung" ;
	TotemNames["AIR_WINDWALL_TOTEM"] = "Totem der Windmauer" ;
	TotemNames["AIR_SENTRY_TOTEM"] = "Totem des Wachens" ;
	TotemNames["AIR_WINDFURY_TOTEM"] = "Totem des Windzorns" ;
	TotemNames["AIR_NATURE_RESISTANCE_TOTEM"] = "Totem des Naturwiderstands" ;
	
	TotemNames["WATER_HEALING_TOTEM"] = "Totem des heilenden Flusses" ;
	TotemNames["WATER_MANA_TOTEM"] = "Totem der Manaquelle" ;
	TotemNames["WATER_FIRE_RESISTANCE_TOTEM"] = "Totem des Feuerwiderstands" ;
	TotemNames["WATER_DISEASE_TOTEM"] = "Totem der Krankheitsreinigung" ;
	TotemNames["WATER_POISON_TOTEM"] = "Totem der Giftreinigung" ;
	TotemNames["WATER_MANA_TIDE_TOTEM"] = "Totem der Manaflut" ;

	
	

end


--[[ Variables saved to SavedVariables.lua ]]

TotemMenuOpt = {
	State = 1, 		-- 0=off, 1=on, 2=locked
	Visibility = 1,		-- 0=hidden, 1=visible
	IconPos = -900,		-- angle of initial minimap icon position
	MainScale = 1,		-- scaling of main window
	XPos = 0,
	YPos = 400
}

--[[ Local Variables]]

TotemMenuVar = {
	ScalingWidth = 0, 	-- width of the frame being scaled
	ScalingTime = 0, 	-- time since last scaling OnUpdate
	ScalingUpdateTimer = .1 -- frequency (in seconds) of scaling OnUpdates
}

--[[ Window movement functions ]]

function TotemMenu_OnMouseDown(arg1)
    if (arg1=="LeftButton") and (TotemMenuOpt.State~=2) then
	TotemMenuFrame:StartMoving();
    elseif (arg1=="RightButton") and (TotemMenuOpt.State~=2) then
	-- TotemMenuEquipped_ToggleView();
    end
end

function TotemMenu_OnMouseUp(arg1)
    if (arg1=="LeftButton") and (TotemMenuOpt.State~=2) then
	TotemMenuFrame:StopMovingOrSizing();
	TotemMenuOpt.XPos = TotemMenuFrame:GetLeft();
	TotemMenuOpt.YPos = TotemMenuFrame:GetTop();
    end
end

function TotemMenu_ForceUI()
	TotemMenuFrame:SetScale(TotemMenuOpt.MainScale)
	TotemMenuFrame:SetPoint("TOPLEFT","UIParent","BOTTOMLEFT", TotemMenuOpt.XPos, TotemMenuOpt.YPos);
	TotemMenu_IconFrame:SetPoint("TOPLEFT","Minimap","TOPLEFT",52-(80*cos(TotemMenuOpt.IconPos or 0)),(80*sin(TotemMenuOpt.IconPos or 0))-52);
	
	if TotemMenuOpt.Visibility == 1 then
		TotemMenuFrame:Show();
	else
		TotemMenuFrame:Hide();
	end
end

--[[ Dialog control functions ]]

function Totem_OnClick(arg1, totemName)

    this:SetChecked(0)

    if (arg1=="LeftButton") then
    	--DEFAULT_CHAT_FRAME:AddMessage("totemName : " .. TotemNames[totemName] .. ".");
	CastSpellByName(TotemNames[totemName]);
    else
	--[[ future use of the right mouse button ]]
    end

    GameTooltip:Show();
end


--[[ MainFrame Scaling ]]

function TotemMenu_StartScaling(arg1)
	if arg1=="LeftButton" then
		this:LockHighlight();
		TotemMenuVar.ScalingWidth = this:GetParent():GetWidth();
		TotemMenu_ScalingFrame:Show();
	end
end

function TotemMenu_StopScaling(arg1)
	TotemMenu_ScalingFrame:Hide();
	this:UnlockHighlight();
end

function TotemMenu_ScaleFrame(scale)
	local oldscale = TotemMenuFrame:GetScale() or 1;
	local framex = (TotemMenuFrame:GetLeft() or TotemMenuOpt.XPos)* oldscale;
	local framey = (TotemMenuFrame:GetTop() or TotemMenuOpt.YPos)* oldscale;

	TotemMenuFrame:SetScale(scale);
	TotemMenuFrame:SetPoint("TOPLEFT","UIParent","BOTTOMLEFT",framex/scale,framey/scale);
	TotemMenuFrame:StartMoving();
	TotemMenuFrame:StopMovingOrSizing();
	TotemMenuOpt.MainScale = TotemMenuFrame:GetScale();
	TotemMenuOpt.XPos = TotemMenuFrame:GetLeft();
	TotemMenuOpt.YPos = TotemMenuFrame:GetTop();
end

function TotemMenu_ScalingFrame_OnUpdate(arg1)
	local oldscale = TotemMenuFrame:GetScale();
	local framex, framey, cursorx, cursory = TotemMenuFrame:GetLeft()*oldscale, TotemMenuFrame:GetTop()*oldscale, GetCursorPosition();

	if (cursorx-framex)>32 then
		local newscale = (cursorx-framex)/TotemMenuVar.ScalingWidth;
		TotemMenu_ScaleFrame(newscale);
	end
end

--[[ Minimap Icon ]]--

function TotemMenu_IconDraggingFrame_OnUpdate(arg1)
	local xpos,ypos = GetCursorPosition()
	local xmin,ymin = Minimap:GetLeft(), Minimap:GetBottom()

	xpos = xmin-xpos/UIParent:GetScale()+70
	ypos = ypos/UIParent:GetScale()-ymin-70

	TotemMenuOpt.IconPos = math.deg(math.atan2(ypos,xpos))
	TotemMenu_IconFrame:SetPoint("TOPLEFT","Minimap","TOPLEFT",52-(80*cos(TotemMenuOpt.IconPos or 0)),(80*sin(TotemMenuOpt.IconPos or 0))-52)
end

function TotemMenu_Toggle()

	if TotemMenuFrame:IsVisible() then
		TotemMenuFrame:Hide()
		TotemMenuOpt.Visibility = 0;
	else
		TotemMenuFrame:Show()
		TotemMenuOpt.Visibility = 1;
	end
end

function TotemMenu_IconFrame_OnClick(arg1)

	if arg1=="LeftButton" then
		TotemMenu_Toggle();
	else
		-- TotemMenuFrame:SetScale(TotemMenuOpt.MainScale)
		DEFAULT_CHAT_FRAME:AddMessage("Saved menuscale: ")
		DEFAULT_CHAT_FRAME:AddMessage(TotemMenuOpt.MainScale)
		DEFAULT_CHAT_FRAME:AddMessage("Current menuscale: ")
		DEFAULT_CHAT_FRAME:AddMessage(TotemMenuFrame:GetScale())
	end
end

function TotemMenu_OnEvent(event)


	if event=="CVAR_UPDATE" then
		if (arg1=="USE_UISCALE" or arg1=="WINDOWED_MODE") and TotemtMenuOpt.XPos then
			TotemMenu_ForceUI()
		end

	elseif event=="PLAYER_ENTERING_WORLD" then
		this:UnregisterEvent("PLAYER_ENTERING_WORLD")
		TotemMenu_ForceUI()
	end
end


function TotemMenu_OnLoad()

	this:RegisterEvent("PLAYER_ENTERING_WORLD")
	this:RegisterEvent("CVAR_UPDATE")

end

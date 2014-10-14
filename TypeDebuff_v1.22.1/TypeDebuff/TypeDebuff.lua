--[[

	Type Debuff: Shows the type of the debuff of the player.
	
	Made by: Edswor
	
	Commands: none

]]

--------------------------------------------------------------------------------------------------
-- OnLoad, Initialize
--------------------------------------------------------------------------------------------------

function TypeDebuff_OnLoad()
	
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("ADDON_LOADED");
	this:RegisterEvent("PLAYER_AURAS_CHANGED");
	
	SLASH_TYPEDEBUFF1 = "/typedebuff";
	SLASH_TYPEDEBUFF2 = "/td";
	SlashCmdList["TYPEDEBUFF"] = TypeDebuff_ShowOptions;
		
	for i=0, 7 do
		getglobal("TypeDebuff"..i):ClearAllPoints();
		getglobal("TypeDebuff"..i):SetPoint("TOP", "BuffButton"..(i+16), "TOP", 0, 0);
	end
end

function TypeDebuff_Initialize()
		
	if ( TypeDebuff_Save == nil or TypeDebuff_Save["Version"] == nil or TypeDebuff_Save["Version"] ~= TYPEDEBUFF_VERSION) then
		TypeDebuff_Save = {};
		
		TypeDebuff_Save = {
		["Version"] = TYPEDEBUFF_VERSION,
		["Enabled"] = 1,
		["Text"] = 1,
		["Icon"] = 0,
		["Poison"] = {
			["Enabled"] = 1,
			["Text"] = "P",
			["PositionH"] = -4,
			["PositionV"] = 6,
			["Font"] = 4,
			["Size"] = 22,
			["Color"] = {r = 0.0, g = 1.0, b = 0.0}	
			},
		["Disease"] = {
			["Enabled"] = 1,
			["Text"] = "D",
			["PositionH"] = -4,
			["PositionV"] = 6,
			["Font"] = 4,
			["Size"] = 22,
			["Color"] = {r = 1.0, g = 0.0, b = 1.0}	
			},
		["Curse"] = {
			["Enabled"] = 1,
			["Text"] = "C",
			["PositionH"] = -4,
			["PositionV"] = 6,
			["Font"] = 4,
			["Size"] = 22,
			["Color"] = {r = 0.0, g = 0.0, b = 1.0}	
			},
		["Magic"] = {
			["Enabled"] = 1,
			["Text"] = "M",
			["PositionH"] = -4,
			["PositionV"] = 6,
			["Font"] = 4,
			["Size"] = 22,
			["Color"] = {r = 1.0, g = 0.0, b = 0.0}	
			}
		};
	end
end

--------------------------------------------------------------------------------------------------
-- OnEvent
--------------------------------------------------------------------------------------------------


function TypeDebuff_OnEvent()
	if( event == "VARIABLES_LOADED" ) then
		TypeDebuff_Initialize();

		if( DEFAULT_CHAT_FRAME ) then
			DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00TypeDebuff|r, made by: |cffff3300Edswor|r, Version: |cffffff00"..TYPEDEBUFF_VERSION.."|r, loaded.");
		end
		return;
	elseif( event == "ADDON_LOADED") then
		if(myAddOnsFrame_Register) then
			TypeDebuffDetails = {
				name = "TypeDebuff",
				version = TYPEDEBUFF_VERSION,
				releaseDate = TYPEDEBUFF_RELEASE,
				author = "Edswor",
				email = "edsowr@hotmail.com",
				website = "http://edswor.iespana.es",
				category = MYADDONS_CATEGORY_OTHERS,
				optionsframe = "TypeDebuffOptionsFrame"
			};
			myAddOnsFrame_Register(TypeDebuffDetails, TypeDebuffHelp);
		end
		return;
	elseif( event == "PLAYER_AURAS_CHANGED" ) then
		if (TypeDebuff_Get("Enabled") == 1  and TypeDebuff_Get("Text") == 1 ) then
			local buffButton, buffIndex, untilCancelled;
			local frame, text, type;
			
			for i=0, 7 do			
				buffButton=getglobal("BuffButton"..(i+16));
				buffIndex, untilCancelled = GetPlayerBuff(buffButton:GetID(), buffButton.buffFilter);
				text = getglobal("TypeDebuff"..i.."TypeText");
				frame = getglobal("TypeDebuff"..i);		
				getglobal("TypeDebuffTooltipTextRight1"):SetText("");	
				frame:SetFrameLevel(buffButton:GetFrameLevel()+2);
				ShowUIPanel(frame);
				
				if ( buffIndex < 0 ) then
						HideUIPanel(frame);
				else
					TypeDebuffTooltip:SetPlayerBuff(buffIndex);	
					type = getglobal("TypeDebuffTooltipTextRight1"):GetText();
					if ( type ~= nil ) then
						if ( type == TYPEDEBUFF_POISON and TypeDebuff_Get2("Poison", "Enabled") == 1 ) then
							text:SetText( TypeDebuff_Get2("Poison", "Text") );
							text:SetTextColor( TypeDebuff_Get2("Poison", "Color").r, TypeDebuff_Get2("Poison", "Color").g, TypeDebuff_Get2("Poison", "Color").b );
							if ( TypeDebuff_Get2("Poison", "Font") == 1 ) then
								text:SetFont("Fonts\\ARIALN.TTF", TypeDebuff_Get2("Poison", "Size") );
							elseif ( TypeDebuff_Get2("Poison", "Font") == 2 ) then
								text:SetFont("Fonts\\FRIZQT__.TTF", TypeDebuff_Get2("Poison", "Size") );
							elseif ( TypeDebuff_Get2("Poison", "Font") == 3 ) then
								text:SetFont("Fonts\\MORPHEUS.TTF", TypeDebuff_Get2("Poison", "Size") );
							elseif ( TypeDebuff_Get2("Poison", "Font") == 4 ) then
								text:SetFont("Fonts\\SKURRI.TTF", TypeDebuff_Get2("Poison", "Size") );
							end
							frame:ClearAllPoints();
							frame:SetPoint("TOP", buffButton, "CENTER", TypeDebuff_Get2("Poison", "PositionH"), TypeDebuff_Get2("Poison", "PositionV") );
						elseif ( type == TYPEDEBUFF_DISEASE and TypeDebuff_Get2("Disease", "Enabled") == 1 ) then
							text:SetText( TypeDebuff_Get2("Disease", "Text") );
							text:SetTextColor( TypeDebuff_Get2("Disease", "Color").r, TypeDebuff_Get2("Disease", "Color").g, TypeDebuff_Get2("Disease", "Color").b );
							if ( TypeDebuff_Get2("Disease", "Font") == 1 ) then
								text:SetFont("Fonts\\ARIALN.TTF", TypeDebuff_Get2("Disease", "Size") );
							elseif ( TypeDebuff_Get2("Disease", "Font") == 2 ) then
								text:SetFont("Fonts\\FRIZQT__.TTF", TypeDebuff_Get2("Disease", "Size") );
							elseif ( TypeDebuff_Get2("Disease", "Font") == 3 ) then
								text:SetFont("Fonts\\MORPHEUS.TTF", TypeDebuff_Get2("Disease", "Size") );
							elseif ( TypeDebuff_Get2("Disease", "Font") == 4 ) then
								text:SetFont("Fonts\\SKURRI.TTF", TypeDebuff_Get2("Disease", "Size") );
							end
							frame:ClearAllPoints();
							frame:SetPoint("TOP", buffButton, "CENTER", TypeDebuff_Get2("Disease", "PositionH"), TypeDebuff_Get2("Disease", "PositionV") );
						elseif ( type == TYPEDEBUFF_CURSE and TypeDebuff_Get2("Curse", "Enabled") == 1 ) then
							text:SetText( TypeDebuff_Get2("Curse", "Text") );
							text:SetTextColor( TypeDebuff_Get2("Curse", "Color").r, TypeDebuff_Get2("Curse", "Color").g, TypeDebuff_Get2("Curse", "Color").b );
							if ( TypeDebuff_Get2("Curse", "Font") == 1 ) then
								text:SetFont("Fonts\\ARIALN.TTF", TypeDebuff_Get2("Curse", "Size") );
							elseif ( TypeDebuff_Get2("Curse", "Font") == 2 ) then
								text:SetFont("Fonts\\FRIZQT__.TTF", TypeDebuff_Get2("Curse", "Size") );
							elseif ( TypeDebuff_Get2("Curse", "Font") == 3 ) then
								text:SetFont("Fonts\\MORPHEUS.TTF", TypeDebuff_Get2("Curse", "Size") );
							elseif ( TypeDebuff_Get2("Curse", "Font") == 4 ) then
								text:SetFont("Fonts\\SKURRI.TTF", TypeDebuff_Get2("Curse", "Size") );
							end
							frame:ClearAllPoints();
							frame:SetPoint("TOP", buffButton, "CENTER", TypeDebuff_Get2("Curse", "PositionH"), TypeDebuff_Get2("Curse", "PositionV") );
						elseif ( type == TYPEDEBUFF_MAGIC and TypeDebuff_Get2("Magic", "Enabled") == 1 ) then
							text:SetText( TypeDebuff_Get2("Magic", "Text") );
							text:SetTextColor( TypeDebuff_Get2("Magic", "Color").r, TypeDebuff_Get2("Magic", "Color").g, TypeDebuff_Get2("Magic", "Color").b );
							if ( TypeDebuff_Get2("Magic", "Font") == 1 ) then
								text:SetFont("Fonts\\ARIALN.TTF", TypeDebuff_Get2("Magic", "Size") );
							elseif ( TypeDebuff_Get2("Magic", "Font") == 2 ) then
								text:SetFont("Fonts\\FRIZQT__.TTF", TypeDebuff_Get2("Magic", "Size") );
							elseif ( TypeDebuff_Get2("Magic", "Font") == 3 ) then
								text:SetFont("Fonts\\MORPHEUS.TTF", TypeDebuff_Get2("Magic", "Size") );
							elseif ( TypeDebuff_Get2("Magic", "Font") == 4 ) then
								text:SetFont("Fonts\\SKURRI.TTF", TypeDebuff_Get2("Magic", "Size") );
							end
							frame:ClearAllPoints();
							frame:SetPoint("TOP", buffButton, "CENTER", TypeDebuff_Get2("Magic", "PositionH"), TypeDebuff_Get2("Magic", "PositionV") );
						else
							HideUIPanel(frame);
						end
					else
						HideUIPanel(frame);
					end
				end
							
			end
		end
		return;
	end
end

--------------------------------------------------------------------------------------------------
-- HideText
--------------------------------------------------------------------------------------------------

function TypeDebuff_HideText()
	local frame;	
	for i=0, 7 do			
		frame = getglobal("TypeDebuff"..i);		
		HideUIPanel(frame);
	end
end

--------------------------------------------------------------------------------------------------
-- ShowOptions, HideOptions, Toggle, ResetOptions
--------------------------------------------------------------------------------------------------

function TypeDebuff_ShowOptions()
	ShowUIPanel(TypeDebuffOptionsFrame);
end

function TypeDebuff_HideOptions()
	HideUIPanel(TypeDebuffOptionsFrame);
end

function TypeDebuff_Toggle()
	if(TypeDebuffOptionsFrame:IsVisible()) then
		HideUIPanel(TypeDebuffOptionsFrame);
	else
		ShowUIPanel(TypeDebuffOptionsFrame);
	end
end

function  TypeDebuff_ResetOptions()
	TypeDebuff_Save = nil;
	TypeDebuff_Initialize();
end

--------------------------------------------------------------------------------------------------
-- Set, Get, GetColor, SetColor
--------------------------------------------------------------------------------------------------

function TypeDebuff_Get(option)
	if ( TypeDebuff_Save[option] ~= nil ) then
		return TypeDebuff_Save[option];
	end
end

function TypeDebuff_Set(option, val)
	if ( TypeDebuff_Save ~= nil ) then
		TypeDebuff_Save[option] = val;
	end
end

function TypeDebuff_Get2(option1, option2)
	if ( TypeDebuff_Save[option1][option2] ~= nil ) then
		return TypeDebuff_Save[option1][option2];
	end
end

function TypeDebuff_Set2(option1, option2, val)
	if ( type(TypeDebuff_Save[option1]) == "table" ) then
		TypeDebuff_Save[option1][option2] = val;
	end
end

function TypeDebuff_GetColor(key)
	local color = {r = 1.0, g = 1.0, b = 1.0};
	
	if ( type(TypeDebuff_Save[key]) == "table" and TypeDebuff_Save[key]["Color"] ~= nil) then
		color.r = TypeDebuff_Save[key]["Color"].r;
		color.g = TypeDebuff_Save[key]["Color"].g;
		color.b = TypeDebuff_Save[key]["Color"].b;
		return color;
	end
end

function TypeDebuff_SetColor(key, r, g, b)
	if ( type(TypeDebuff_Save[key]) == "table" and TypeDebuff_Save[key]["Color"] ~= nil) then
		TypeDebuff_Save[key]["Color"].r = r;
		TypeDebuff_Save[key]["Color"].g = g;
		TypeDebuff_Save[key]["Color"].b = b;
	end
end

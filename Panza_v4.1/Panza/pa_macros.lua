--[[

pa_macros.lua
Panza functions to create/update macros.
Revison 4.0

10-01-06 "for in pairs()" completed for BC
--]]

-------------------------------------
-- Variables used in macros
-------------------------------------
PA.Macros = {};
PA.MacroIndex = 0;

PANZA_ASHEALMACRO 		= "Interface\\Icons\\Spell_Holy_GreaterHeal";
PANZA_BESTHEALMACRO 	= "Interface\\Icons\\Ability_Druid_CatFormAttack";
PANZA_CYCLENEARMACRO 	= "Interface\\Icons\\Spell_Frost_Stun";
PANZA_ASCUREMACRO 		= "Interface\\Icons\\Spell_Nature_SlowingTotem";
PANZA_CYCLEBLESSMACRO	= "Interface\\Icons\\Spell_Holy_MindVision";
PANZA_ASBLESSMACRO 		= "Interface\\Icons\\Spell_Fire_FlameTounge";
PANZA_ASFREEMACRO 		= "Interface\\Icons\\Spell_Holy_SealOfValor";
PANZA_ASREZMACRO 		= "Interface\\Icons\\Spell_Holy_Resurrection";
PANZA_PANICMACRO 		= "Interface\\Icons\\Ability_Creature_Cursed_02";

-----------------------------------------------
-- Functions to create macros
----------------------------------------------

----------------------------------------------
-- Adds/Updates a macro using optional texture
----------------------------------------------
function PA:AddMacro(name, body, spell, cooldownSpell, macroTexture, localGlobal, update)
	if (name and body) then
		local Fullbody = "/script --PA_ID=>"..name.."<\n";
		if (cooldownSpell~="NONE" ) then
			--PA:ShowText("name=", name);
			--PA:ShowText("cooldownSpell=", cooldownSpell);
			if (PA:SpellInSpellBook(cooldownSpell)) then
				--PA:ShowText("Name=", PA.SpellBook[cooldownSpell].Name);
				--PA:ShowText("MaxRank=", PA.SpellBook[cooldownSpell].MaxRank);
				Fullbody = Fullbody..'/script --CastSpellByName("'..PA:CombineSpell(PA.SpellBook[cooldownSpell].Name, PA.SpellBook[cooldownSpell].MaxRank)..'")\n';

				-- Remember macros as they can be used in Action Bar range checking
				local Range = PA.SpellBook[cooldownSpell].Range;
				if (Range~=nil and PA.SpellBook.Range[Range]~=nil and PA.SpellBook.Range[Range][cooldownSpell]~=nil) then
					if (PA.MacroRanges[Range]==nil) then
						PA.MacroRanges[Range] = {};
					end
					PA.MacroRanges[Range][name] = true;
				end
				if (Range~=nil and PA.SpellBook.ORange[Range]~=nil and PA.SpellBook.ORange[Range][cooldownSpell]~=nil) then
					if (PA.MacroORanges[Range]==nil) then
						PA.MacroORanges[Range] = {};
					end
					PA.MacroORanges[Range][name] = true;
				end
				if (PA.SpellBook.SRange[cooldownSpell]~=nil) then
					if (PA.MacroSpecials[cooldownSpell]==nil) then
						PA.MacroSpecials[cooldownSpell] = {};
					end
					PA.MacroSpecials[cooldownSpell][name] = true;					
				end

			elseif (not update) then
				return;
			end
		end
		local MacroId = GetMacroIndexByName(name);
		Fullbody = Fullbody..body;
		if (update==true) then
			if (MacroId~=nil and MacroId>0) then
				if (PA:CheckMessageLevel("Core", 4)) then
					PA:Message4("Updating existing macro "..name.." for "..spell);
				end
				EditMacro(MacroId, nil, nil, Fullbody, nil);
			end
		else
			if (MacroId~=nil and MacroId>0) then
				if (PA:CheckMessageLevel("Core", 1)) then
					PA:Message4("Updating existing macro "..name.." for "..spell);
				end
				EditMacro(MacroId, nil, nil, Fullbody, nil);
			else
				if (PA:CheckMessageLevel("Core", 1)) then
					PA:Message4("Creating new macro "..name.." for "..spell);
				end
				CreateMacro(name, 1, Fullbody, 1, localGlobal);
			end
			PA.MacroIndex = PA.MacroIndex + 1;
			PA.Macros[PA.MacroIndex] = {Name=name, Spell=spell, Texture=macroTexture};
		end
	end
end

----------------------------------------------------
-- Adds/Updates a macro using texture from spellbook
----------------------------------------------------
function PA:AddPanzaMacro(spell, update)
	if (spell==nil) then return; end

	if (PA:SpellInSpellBook(spell)) then

		PA:AddMacro(PA:PanzaMacroName(spell), "/pa "..spell, PA.SpellBook[spell].Name, spell, PA.SpellBook[spell].Texture, 1, update);
	elseif (update~=true) then
		if (PA:CheckMessageLevel("Core", 2)) then
			PA:Message4("Ignoring macro for "..spell.." because not in SpellBook");
		end
	end
end

function PA:PanzaMacroName(spell)
	local SpellCase;
	if (not PANZA_BUFF_DISPLAY[spell]) then
		SpellCase = string.upper(spell);
	else
		SpellCase = PANZA_BUFF_DISPLAY[spell].Abbr;
	end
	return SpellCase;
end

------------------------
-- Deletes all PA macros
------------------------
function PA:DeleteMacros()
	for MacroId = 36, 1, -1 do
	    local Name, IconTexture, Body = GetMacroInfo(MacroId);
	    if (Name~=nil and Body~=nil) then
			local _, _, PaId = string.find(Body, "PA_ID=>(%w+)<");
			if (PaId~=nil) then
				if (PA:CheckMessageLevel("Core", 1)) then
					PA:Message4("Deleting Macro "..Name);
				end
				DeleteMacro(MacroId);
			end
		end
	end
end

-------------------------
-- Deletes named PA macro
-------------------------
function PA:DeleteMacro(paid)
	for MacroId = 36, 1, -1 do
	    local Name, IconTexture, Body = GetMacroInfo(MacroId);
	    if (Name~=nil and Body~=nil) then
			local _, _, PaId = string.find(Body, "PA_ID=>(%w+)<");
			if (PaId==paid) then
				if (PA:CheckMessageLevel("Core", 1)) then
					PA:Message4("Deleting Macro "..Name);
				end
				DeleteMacro(MacroId);
			end
		end
	end
end

---------------------------------
-- Set the textures for macro set
---------------------------------
function PA:SetMacroIconTextures()
	-- Create dummy macro's until we get the right textures....yuk
	local MacroId = GetMacroIndexByName("PADUMMY");
	if (not MacroId or MacroId==0) then
		CreateMacro("PADUMMY", 1, "/dummy", 1);
		MacroId = GetMacroIndexByName("PADUMMY");
	end
	local MacroDoneCount = 0;
	for MacroIconId = 1, GetNumMacroIcons() do
		EditMacro(MacroId, nil, MacroIconId, nil, nil);
		local dName, IconTexture = GetMacroInfo(MacroId);
		for i = 1, PA.MacroIndex do
			if PA.Macros[i].Texture==IconTexture then
				if (PA:CheckMessageLevel("Core",5)) then
					PA:Message4("Changing macro Texture="..PA.Macros[i].Spell.." to "..MacroIconId);
				end
				EditMacro(GetMacroIndexByName(PA.Macros[i].Name), nil, MacroIconId, nil, nil);
				MacroDoneCount = MacroDoneCount +1;
			end
		end
		if MacroDoneCount==PA.MacroIndex then
			break; -- all done
		end
	end
	DeleteMacro(MacroId); --remove dummy macro
	for i = 1, PA.MacroIndex do
		if PA.Macros[i].Texture==nil then
			DeleteMacro(i); -- not in the player's spell book
		end
	end
	return nil;
end
-------------------------------------------------
-- Create set of macros with appropriate textures
-------------------------------------------------
function PA:CreateMacros(update)
	if (update~=true) then
		if (PA:CheckMessageLevel("Core", 1)) then
			PA:Message4("Creating PA Macros...");
		end
		if (not IsAddOnLoaded("Blizzard_MacroUI")) then
			LoadAddOn("Blizzard_MacroUI");
		end
	end
	PA.MacroRanges = {};
	PA.MacroORanges = {};
	PA.MacroSpecials = {};
	PA.MacroIndex = 0;
	for buff, _ in pairs(PA.SpellBook.Buffs) do
		if (PA:GetSpellProperty(buff, "Duration")~=nil) then
			PA:AddPanzaMacro(buff, update);
		end
	end
	-- Delete any erroneous df macros
	PA:DeleteMacro(PA:PanzaMacroName("df"));

	PA:AddPanzaMacro("di", update);

	PA:AddMacro("HEAL",  "/pa asheal",		PANZA_HELP_ASHEAL, 						PA.HealBuff,									PANZA_ASHEALMACRO,		0, update);
	PA:AddMacro("CURE",  "/pa ascure",		PANZA_HELP_ASCURE, 						PA:TableFirstKey(PA.SpellBook.DeDebuffs),	PANZA_ASCUREMACRO,		0, update);
	PA:AddMacro("BLESS", "/pa asbless",		PANZA_HELP_ASBLESS, 					PA.DefaultBuff,							PANZA_ASBLESSMACRO,		0, update);
	PA:AddMacro("CYCLE", "/pa cyclebless",	"CycleBless "..PANZA_HELP_CYCLEBLESS, 	PA.CycleBuff,							PANZA_CYCLEBLESSMACRO,	1, update);
	PA:AddMacro("NEAR",  "/pa cyclenear",	"CycleNear "..PANZA_HELP_CYCLENEAR, 	PA.NearBuff,							PANZA_CYCLENEARMACRO,	1, update);
	PA:AddMacro("BEST",  "/pa bestheal",	PANZA_HELP_BESTHEAL, 					PA.HealBuff,							PANZA_BESTHEALMACRO,	0, update);
	PA:AddMacro("FREE",  "/pa asfree",		"Auto Free", 							"bof",									PANZA_ASFREEMACRO,		1, update);
	PA:AddMacro("REZ",   "/pa asrez",		"Auto Resurrect", 						"rez",									PANZA_ASREZMACRO,		0, update);
	PA:AddMacro("PANIC", "/pa panic",		"Panic", 								"NONE",									PANZA_PANICMACRO,		0, update);
	PA:AddMacro("HOW",   "/pa ashow",		"Auto HoW", 							"how",									PA:GetSpellProperty("how", "Texture"),		1, update);

	if (update~=true) then
		PA:SetMacroIconTextures();
		MacroFrame:Show();
		MacroFrame:Raise();
	end
end


-----------
-- Tooltips
-----------
PA.OldActionButton_SetTooltip = ActionButton_SetTooltip;

function ActionButton_SetTooltip()
	PA.OldActionButton_SetTooltip();
	local MacroName = getglobal(this:GetName().."Name"):GetText();
	local Id = nil;
	local Discription = nil;
	local Title = nil;
	local Cast = nil;
	local ExtraLine = false;
	if (MacroName~=nil) then
		--PA:ShowText("Macro Name=", MacroName);
	    local _, _, Body = GetMacroInfo(GetMacroIndexByName(MacroName));
	    if (Body~=nil) then
			local _, _, PaId = string.find(Body, "PA_ID=>(%w+)<");
			if (PaId~=nil) then
				--PA:ShowText("PaId=", PaId);
				for key, value in pairs(PANZA_BUFF_DISPLAY) do
					--PA:ShowText("  Abbr=", value.Abbr)
					if (value.Abbr==PaId) then
						--PA:ShowText("Found buff=", key);
						Id = PA:GetSpellProperty(key, "Index");
						break;
					end
				end
				if (Id==nil) then
					if (PaId=="HEAL") then
						Id = PA:GetSpellProperty(PA.HealBuff, "Index");
						Title = PANZA_TITLE_ASHEAL;
						Discription = string.sub(PANZA_HELP_AUTOHEAL, 2);
						Cast = "1.5-3.0 sec cast";
					elseif (PaId=="CURE") then
						for key, _ in pairs(PA.SpellBook.DeDebuffs) do
							Id = PA:GetSpellProperty(key, "Index");
							if (Id~=nil) then
								Title = PANZA_TITLE_ASCURE;
								Discription = string.sub(PANZA_HELP_AUTOCURE, 2);
								break;
							end
						end
					elseif (PaId=="DI") then
						Id = PA:GetSpellProperty("di", "Index");
						Title = PANZA_TITLE_DI;
						Discription = string.sub(PANZA_HELP_DI, 2);
						ExtraLine = true;
					elseif (PaId=="CYCLE") then
						Id = PA:GetSpellProperty(PA.CycleBuff, "Index");
						Title = PANZA_TITLE_CYCLEBLESS;
						Discription = string.sub(PANZA_HELP_CYCLEBLESS, 2);
					elseif (PaId=="NEAR") then
						Id = PA:GetSpellProperty(PA.CycleBuff, "Index");
						Title = PANZA_TITLE_CYCLENEAR;
						Discription = string.sub(PANZA_HELP_CYCLENEAR, 2);
					elseif (PaId=="BEST") then
						Id = PA:GetSpellProperty(PA.HealBuff, "Index");
						Title = PANZA_TITLE_BESTHEAL;
						Discription = string.sub(PANZA_HELP_BESTHEAL, 2);
						Cast = "1.5-3.0 sec cast";
					elseif (PaId=="BLESS") then
						Id = PA:GetSpellProperty(PA.DefaultBuff, "Index");
						Title = PANZA_TITLE_ASBLESS;
						Discription = string.sub(PANZA_HELP_AUTOBLESS, 2);
					elseif (PaId=="FREE") then
						Id = PA:GetSpellProperty("bof", "Index");
						Title = PANZA_TITLE_ASFREE;
						Discription = string.sub(PANZA_HELP_ASFREE, 2);
					elseif (PaId=="REZ") then
						Id = PA:GetSpellProperty("rez", "Index");
						Title = PANZA_TITLE_ASREZ;
						Discription = string.sub(PANZA_HELP_ASREZ, 2);
					elseif (PaId=="HOW") then
						Id = PA:GetSpellProperty("how", "Index");
						Title = PANZA_TITLE_ASHOW;
						Discription = string.sub(PANZA_HELP_ASHOW, 2);
					elseif (PaId=="PANIC") then
						Id = PA:GetSpellProperty(PA.HealBuff, "Index");
						Title = PANZA_TITLE_PANIC;
						if (PA.ShieldSpell=="bop") then
							Discription = string.sub(PANZA_HELP_PANIC, 2);
						else
							Discription = string.sub(PANZA_HELP_PANIC2, 2);
						end
						Cast = "Instant/1.5-3.0 sec cast";
					end
				end
				if (Id~=nil and Id>0) then
					--PA:ShowText("Id=", Id);
					GameTooltip:SetSpell(Id, BOOKTYPE_SPELL);
					if (Title~=nil) then
						GameTooltipTextLeft1:SetText(Title);
					end
					GameTooltipTextRight1:SetText("PA Auto");
					GameTooltipTextRight1:SetTextColor(0.20, 0.20, 0.20);
					GameTooltipTextLeft2:SetText("PA Auto");
					GameTooltipTextLeft2:SetTextColor(0.57, 0.80, 0.20);
					if (Cast~=nil) then
						GameTooltipTextLeft3:SetText(Cast);
					end
					if (Discription~=nil) then
						if (ExtraLine) then
							GameTooltipTextLeft5:SetText(Discription);
							GameTooltip:SetHeight(GameTooltipTextLeft5:GetHeight() + 83);
						else
							GameTooltipTextLeft4:SetText(Discription);
							GameTooltip:SetHeight(GameTooltipTextLeft4:GetHeight() + 63);
						end
					end
				end
			end
		end
    end
end

PA.ActionButton_SetTooltip = ActionButton_SetTooltip;

-----------------------------------------------------------------------------
-- Called from addons like FlexBars 
-- Arguments - MacroName
-- Pass the actiontext for the button.
-- In FlexBars this is:
-- Panza_ActionButton_SetTooltip(GetActionText(FlexBarButton_GetID(button)));
-----------------------------------------------------------------------------
function Panza_ActionButton_SetTooltip(MacroName)
	PA.OldActionButton_SetTooltip();
	local Id = nil;
	local Discription = nil;
	local Title = nil;
	local Cast = nil;
	local ExtraLine = false;
	if (MacroName~=nil) then
		--PA:ShowText("Macro Name=", MacroName);
	    local _, _, Body = GetMacroInfo(GetMacroIndexByName(MacroName));
	    if (Body~=nil) then
			local _, _, PaId = string.find(Body, "PA_ID=>(%w+)<");
			if (PaId~=nil) then
				--PA:ShowText("PaId=", PaId);
				for key, value in pairs(PANZA_BUFF_DISPLAY) do
					--PA:ShowText("  Abbr=", value.Abbr)
					if (value.Abbr==PaId) then
						--PA:ShowText("Found buff=", key);
						Id = PA:GetSpellProperty(key, "Index");
						break;
					end
				end
				if (Id==nil) then
					if (PaId=="HEAL") then
						Id = PA:GetSpellProperty(PA.HealBuff, "Index");
						Title = PANZA_TITLE_ASHEAL;
						Discription = string.sub(PANZA_HELP_AUTOHEAL, 2);
						Cast = "1.5-3.0 sec cast";
					elseif (PaId=="CURE") then
						for key, _ in pairs(PA.SpellBook.DeDebuffs) do
							Id = PA:GetSpellProperty(key, "Index");
							if (Id~=nil) then
								Title = PANZA_TITLE_ASCURE;
								Discription = string.sub(PANZA_HELP_AUTOCURE, 2);
								break;
							end
						end
					elseif (PaId=="DI") then
						Id = PA:GetSpellProperty("di", "Index");
						Title = PANZA_TITLE_DI;
						Discription = string.sub(PANZA_HELP_DI, 2);
						ExtraLine = true;
					elseif (PaId=="CYCLE") then
						Id = PA:GetSpellProperty(PA.CycleBuff, "Index");
						Title = PANZA_TITLE_CYCLEBLESS;
						Discription = string.sub(PANZA_HELP_CYCLEBLESS, 2);
					elseif (PaId=="NEAR") then
						Id = PA:GetSpellProperty(PA.CycleBuff, "Index");
						Title = PANZA_TITLE_CYCLENEAR;
						Discription = string.sub(PANZA_HELP_CYCLENEAR, 2);
					elseif (PaId=="BEST") then
						Id = PA:GetSpellProperty(PA.HealBuff, "Index");
						Title = PANZA_TITLE_BESTHEAL;
						Discription = string.sub(PANZA_HELP_BESTHEAL, 2);
						Cast = "1.5-3.0 sec cast";
					elseif (PaId=="BLESS") then
						Id = PA:GetSpellProperty(PA.DefaultBuff, "Index");
						Title = PANZA_TITLE_ASBLESS;
						Discription = string.sub(PANZA_HELP_AUTOBLESS, 2);
					elseif (PaId=="FREE") then
						Id = PA:GetSpellProperty("bof", "Index");
						Title = PANZA_TITLE_ASFREE;
						Discription = string.sub(PANZA_HELP_ASFREE, 2);
					elseif (PaId=="REZ") then
						Id = PA:GetSpellProperty("rez", "Index");
						Title = PANZA_TITLE_ASREZ;
						Discription = string.sub(PANZA_HELP_ASREZ, 2);
					elseif (PaId=="HOW") then
						Id = PA:GetSpellProperty("how", "Index");
						Title = PANZA_TITLE_ASHOW;
						Discription = string.sub(PANZA_HELP_ASHOW, 2);
					elseif (PaId=="PANIC") then
						Id = PA:GetSpellProperty(PA.HealBuff, "Index");
						Title = PANZA_TITLE_PANIC;
						if (PA.ShieldSpell=="bop") then
							Discription = string.sub(PANZA_HELP_PANIC, 2);
						else
							Discription = string.sub(PANZA_HELP_PANIC2, 2);
						end
						Cast = "Instant/1.5-3.0 sec cast";
					end
				end
				if (Id~=nil and Id>0) then
					--PA:ShowText("Id=", Id);
					GameTooltip:SetSpell(Id, BOOKTYPE_SPELL);
					if (Title~=nil) then
						GameTooltipTextLeft1:SetText(Title);
					end
					GameTooltipTextRight1:SetText("PA Auto");
					GameTooltipTextRight1:SetTextColor(0.20, 0.20, 0.20);
					GameTooltipTextLeft2:SetText("PA Auto");
					GameTooltipTextLeft2:SetTextColor(0.57, 0.80, 0.20);
					if (Cast~=nil) then
						GameTooltipTextLeft3:SetText(Cast);
					end
					if (Discription~=nil) then
						if (ExtraLine) then
							GameTooltipTextLeft5:SetText(Discription);
							GameTooltip:SetHeight(GameTooltipTextLeft5:GetHeight() + 83);
						else
							GameTooltipTextLeft4:SetText(Discription);
							GameTooltip:SetHeight(GameTooltipTextLeft4:GetHeight() + 63);
						end
					end
				end
			end
		end
    end
end


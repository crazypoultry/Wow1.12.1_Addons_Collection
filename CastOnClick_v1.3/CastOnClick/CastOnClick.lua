CastOnClickFastSpellTable = {};
CastOnClickEfficientSpellTable = {};

CASTONCLICK_SPELL_LEFT = nil;
CASTONCLICK_SPELL_ALTLEFT = nil;
CASTONCLICK_SPELL_SHIFTLEFT = nil;
CASTONCLICK_SPELL_CTRLLEFT = nil;

CASTONCLICK_SPELL_RIGHT = nil;
CASTONCLICK_SPELL_ALTRIGHT = nil;
CASTONCLICK_SPELL_SHIFTRIGHT = nil;
CASTONCLICK_SPELL_CTRLRIGHT = nil;

CASTONCLICK_SPELL_MIDDLE = nil;
CASTONCLICK_SPELL_BUTTON4 = nil;
CASTONCLICK_SPELL_BUTTON5 = nil;

NATURE_CHECK = nil;
RETARGET_CHECK = nil;

ICONPOSITION = nil;

function CastOnClick_OnLoad()

	this:RegisterForDrag("LeftButton");
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	
		
	SlashCmdList["CASTONCLICK"] = CastOnClick_OnSlash;
	SLASH_CASTONCLICK1 = "/castonclick";
	
end

function CastOnClick_OnSlash ()

	if (CastOnClick_Settings:IsVisible()) then
		
		CastOnClick_Settings:Hide();
		
	else
		
		CastOnClick_Settings:Show();
		
	end
	

end

function CastOnClick (button, targetName )

	TargetUnit( targetName );
	
		if (button == "LeftButton") then
	
			if ( IsShiftKeyDown() ) then
				if (CASTONCLICK_SPELL_SHIFTLEFT) then
					if (CASTONCLICK_SPELL_SHIFTLEFT == "Efficient" or CASTONCLICK_SPELL_SHIFTLEFT == "Fast" ) then
						CastOnClickHealFinder(CASTONCLICK_SPELL_SHIFTLEFT,targetName);
					else
						CastSpellByName(CASTONCLICK_SPELL_SHIFTLEFT);
					end
				else
					return false;
				end					
			elseif( IsControlKeyDown() ) then
				
				if (CASTONCLICK_SPELL_CTRLLEFT) then
					if (CASTONCLICK_SPELL_CTRLLEFT == "Efficient" or CASTONCLICK_SPELL_CTRLLEFT == "Fast") then
						CastOnClickHealFinder(CASTONCLICK_SPELL_CTRLLEFT,targetName);
					else
						CastSpellByName(CASTONCLICK_SPELL_CTRLLEFT);
					end 
				else
					return false;
				end
								
			elseif ( IsAltKeyDown()  ) then
				
				if (CASTONCLICK_SPELL_ALTLEFT) then
								
					if (CASTONCLICK_SPELL_ALTLEFT == "Efficient" or CASTONCLICK_SPELL_ALTLEFT == "Fast") then
						CastOnClickHealFinder(CASTONCLICK_SPELL_ALTLEFT,targetName);
					else
						CastSpellByName(CASTONCLICK_SPELL_ALTLEFT);
					end
				else 
					return false;
				end
										
			else
				if (CASTONCLICK_SPELL_LEFT) then
					if (CASTONCLICK_SPELL_LEFT == "Efficient" or CASTONCLICK_SPELL_LEFT == "Fast" ) then
						CastOnClickHealFinder(CASTONCLICK_SPELL_LEFT,targetName);
					else
						CastSpellByName(CASTONCLICK_SPELL_LEFT);
					end
				else
					return false;
				end
							
			end
		
		
		elseif (button == "RightButton")then
			
			if ( IsShiftKeyDown() ) then
				if (CASTONCLICK_SPELL_SHIFTRIGHT) then
					if (CASTONCLICK_SPELL_SHIFTRIGHT == "Efficient" or CASTONCLICK_SPELL_SHIFTRIGHT == "Fast" ) then
						CastOnClickHealFinder(CASTONCLICK_SPELL_SHIFTRIGHT,targetName);
					else
						CastSpellByName(CASTONCLICK_SPELL_SHIFTRIGHT);
					end
				else
					return false;
				end					
			elseif( IsControlKeyDown() ) then
				
				if (CASTONCLICK_SPELL_CTRLRIGHT) then
					
					if (NATURE_CHECK == 1) then
						CastSpellByName("Nature's Swiftness");
						SpellStopCasting();
						if (CASTONCLICK_SPELL_CTRLRIGHT == "Efficient" or CASTONCLICK_SPELL_CTRLRIGHT == "Fast") then
							CastOnClickHealFinder(CASTONCLICK_SPELL_CTRLRIGHT,targetName);
						else
							CastSpellByName(CASTONCLICK_SPELL_CTRLRIGHT);
						end
					
					else
					
						if (CASTONCLICK_SPELL_CTRLRIGHT == "Efficient" or CASTONCLICK_SPELL_CTRLRIGHT == "Fast") then
							CastOnClickHealFinder(CASTONCLICK_SPELL_CTRLRIGHT,targetName);
						else
							CastSpellByName(CASTONCLICK_SPELL_CTRLRIGHT);
						end 
					
					end
								
					else
						return false;
				end
				
				
			elseif ( IsAltKeyDown() ) then
			
				if (CASTONCLICK_SPELL_ALTRIGHT) then
					
					if (CASTONCLICK_SPELL_ALTRIGHT == "Efficient" or CASTONCLICK_SPELL_ALTRIGHT == "Fast") then
						CastOnClickHealFinder(CASTONCLICK_SPELL_ALTRIGHT,targetName);
					else
						CastSpellByName(CASTONCLICK_SPELL_ALTRIGHT);
					end
												
				else 
					return false;
				end
			
			else
				if (CASTONCLICK_SPELL_RIGHT) then
					if (CASTONCLICK_SPELL_RIGHT == "Efficient" or CASTONCLICK_SPELL_RIGHT == "Fast") then
						CastOnClickHealFinder(CASTONCLICK_SPELL_RIGHT,targetName);
					else
						CastSpellByName(CASTONCLICK_SPELL_RIGHT);
					end
				else
					return false;
				end
							
			end
		
		elseif (button == "MiddleButton") then
			if (CASTONCLICK_SPELL_MIDDLE) then
				
				if (CASTONCLICK_SPELL_MIDDLE == "Efficient" or CASTONCLICK_SPELL_MIDDLE == "Fast") then
					CastOnClickHealFinder(CASTONCLICK_SPELL_MIDDLE,targetName);
				else
					CastSpellByName(CASTONCLICK_SPELL_MIDDLE);
				end
			else
				return false;
			end	
		
		elseif (button == "Button4") then
			if (CASTONCLICK_SPELL_BUTTON4) then
				if (CASTONCLICK_SPELL_BUTTON4 == "Fast" or CASTONCLICK_SPELL_BUTTON4 == "Efficient") then
					CastOnClickHealFinder(CASTONCLICK_SPELL_BUTTON4,targetName);
				else
					CastSpellByName(CASTONCLICK_SPELL_BUTTON4);
				end
			else
				return false;
			end	
		
		elseif (button == "Button5") then
			if (CASTONCLICK_SPELL_BUTTON5) then
				if (CASTONCLICK_SPELL_BUTTON5 == "Efficient" or CASTONCLICK_SPELL_BUTTON5 == "Fast") then
					CastOnClickHealFinder(CASTONCLICK_SPELL_BUTTON5,targetName);
				else
					CastSpellByName(CASTONCLICK_SPELL_BUTTON5);
				end
			else
				return false;
			end							
		
		end
	
	if (RETARGET_CHECK == 1) then
		TargetLastTarget();
	end
	
	return true;
	
end

function CastOnClick_OnUpdate(event)

	if (event == "VARIABLES_LOADED" or event == nil ) then
		
		if (event ~= nil) then
			
			DEFAULT_CHAT_FRAME:AddMessage("CastOnClick 1.3 by Fandolo loaded, type /castonclick to open settings window");
		 	CastOnClick_Minimap:SetPoint("TOPLEFT","Minimap","TOPLEFT",52-(80*cos(ICONPOSITION or 45)),(80*sin(ICONPOSITION or 45))-52);
		end
		
		if (CASTONCLICK_SPELL_LEFT == "") then
			CASTONCLICK_SPELL_LEFT = nil;
		elseif (CASTONCLICK_SPELL_LEFT ~= nil) then
			CastOnClick_spell_left:SetText(CASTONCLICK_SPELL_LEFT);
		end
		
		if (CASTONCLICK_SPELL_ALTLEFT == "") then
			CASTONCLICK_SPELL_ALTLEFT = nil;
		elseif (CASTONCLICK_SPELL_ALTLEFT ~= nil) then
			CastOnClick_spell_alt_left:SetText(CASTONCLICK_SPELL_ALTLEFT);
		end
		
		if (CASTONCLICK_SPELL_SHIFTLEFT == "") then
			CASTONCLICK_SPELL_SHIFTLEFT = nil;
		elseif (CASTONCLICK_SPELL_SHIFTLEFT ~= nil) then
			CastOnClick_spell_shift_left:SetText(CASTONCLICK_SPELL_SHIFTLEFT);
		end
		
		if (CASTONCLICK_SPELL_CTRLLEFT == "") then
			CASTONCLICK_SPELL_CTRLLEFT = nil;
		elseif (CASTONCLICK_SPELL_CTRLLEFT ~= nil) then
			CastOnClick_spell_ctrl_left:SetText(CASTONCLICK_SPELL_CTRLLEFT);
		end
		
		if (CASTONCLICK_SPELL_RIGHT == "") then
			CASTONCLICK_SPELL_RIGHT = nil;
		elseif (CASTONCLICK_SPELL_RIGHT ~= nil) then
			CastOnClick_spell_right:SetText(CASTONCLICK_SPELL_RIGHT);
		end
		
		if (CASTONCLICK_SPELL_ALTRIGHT == "") then
			CASTONCLICK_SPELL_ALTRIGHT = nil;
		elseif (CASTONCLICK_SPELL_ALTRIGHT ~= nil) then
			CastOnClick_spell_alt_right:SetText(CASTONCLICK_SPELL_ALTRIGHT);
		end
		
		if (CASTONCLICK_SPELL_SHIFTRIGHT == "") then
			CASTONCLICK_SPELL_SHIFTRIGHT = nil;
		elseif (CASTONCLICK_SPELL_SHIFTRIGHT ~= nil) then
			CastOnClick_spell_shift_right:SetText(CASTONCLICK_SPELL_SHIFTRIGHT);
		end
		
		if (CASTONCLICK_SPELL_CTRLRIGHT == "") then
			CASTONCLICK_SPELL_CTRLRIGHT = nil;
		elseif (CASTONCLICK_SPELL_CTRLRIGHT ~= nil) then
			CastOnClick_spell_ctrl_right:SetText(CASTONCLICK_SPELL_CTRLRIGHT);
		end
		
		if (CASTONCLICK_SPELL_MIDDLE == "") then
			CASTONCLICK_SPELL_MIDDLE = nil;
		elseif (CASTONCLICK_SPELL_MIDDLE ~= nil) then
			CastOnClick_spell_middle:SetText(CASTONCLICK_SPELL_MIDDLE);
		end
		
		if (CASTONCLICK_SPELL_BUTTON4 == "") then
			CASTONCLICK_SPELL_BUTTON4 = nil;
		elseif (CASTONCLICK_SPELL_BUTTON4 ~= nil) then
			CastOnClick_spell_button4:SetText(CASTONCLICK_SPELL_BUTTON4);
		end
		
		if (CASTONCLICK_SPELL_BUTTON5 == "") then
			CASTONCLICK_SPELL_BUTTON5 = nil;
		elseif (CASTONCLICK_SPELL_BUTTON5 ~= nil) then
			CastOnClick_spell_button5:SetText(CASTONCLICK_SPELL_BUTTON5);
		end
		
	end
	
	if event == "PLAYER_ENTERING_WORLD" then
		CastOnClickScanSpells();
	end
	
	
	
	
end

function CastOnClick_IconDragging_OnUpdate(arg1)
	local xpos,ypos = GetCursorPosition()
	local xmin,ymin = Minimap:GetLeft(), Minimap:GetBottom()

	xpos = xmin-xpos/Minimap:GetEffectiveScale()+70
	ypos = ypos/Minimap:GetEffectiveScale()-ymin-70

	ICONPOSITION = math.deg(math.atan2(ypos,xpos))
	CastOnClick_Minimap:SetPoint("TOPLEFT","Minimap","TOPLEFT",52-(80*cos(ICONPOSITION or 45)),(80*sin(ICONPOSITION or 45))-52)
end

function CastOnClick_IconFrame_OnClick(arg1)

	if arg1=="LeftButton" then
				
		if (CastOnClick_Settings:IsVisible()) then
			
			CastOnClick_Settings:Hide();
		
		else
			
			CastOnClick_Settings:Show();
		end
		
	end

end

function CastOnClickHealFinder (spellType, targetName )
	
	local spellTable = {};
	
	if targetName then
	
		if spellType == "Fast" then
		 	spellTable = CastOnClickFastSpellTable;	
		elseif spellType == "Efficient" then
			spellTable = CastOnClickEfficientSpellTable;
		else
			return
		end
		
		local auxTable = {};
		local healAmount = UnitHealthMax( targetName ) - UnitHealth( targetName );
		local j=1;
		local spell, plusheal = 0;
		local temp = 0;
		
		if (BonusScanner) then
			plusheal = BonusScanner:GetBonus("HEAL");
		end
		
			
		for i = table.getn( spellTable ), 1, -1 do
			
			if (BonusScanner) then
				temp = plusheal * spellTable[i].castingTime / 3.5;
			end	
			spell = spellTable[i];
			
			if( (spellTable[i].avgHeal + temp) <= healAmount ) then
				
				auxTable[j] = spellTable[i];
				j = j+1;
							
			end
		
		end
		
		table.sort(auxTable , function(a,b	) return a.avgHeal>b.avgHeal end ) 
		local pos = 1;
		if auxTable[pos] then
			while UnitMana("player") < auxTable[pos].mana and auxTable[pos+1] do
				pos = pos +1
			end
		CastSpell(auxTable[pos].id, BOOKTYPE_SPELL);
			
		end
	
	
	end
	
		
end
	



CT_RA_CustomOnClickFunction = CastOnClick;


function CastOnClickScanSpells()
	
	local i = 1;
	local j = 1;
	local k = 1;
	
	while true do
	
		local spell, rank = GetSpellName( i, BOOKTYPE_SPELL );
		local validSpell = { name="", rank="", minHeal=0, maxHeal=0, mana=0, avgHeal=0, id=0, castingTime=0};
		
		if not spell then
			do break end;
		end
		
		if( spell and string.find(spell, "Chain") == nil and string.find(spell, "Totem") == nil and string.find(spell, "Prayer")== nil
			 and string.find( spell, "Heal" ) ~= nil or string.find( spell, "Regrowth" ) ~= nil or string.find( spell, "Holy" ) ~= nil 
			 or string.find( spell, "Flash" ) ~= nil)then
			
			validSpell.name = spell;
			validSpell.rank = rank;
			validSpell.id = i;
			
			if string.find(spell, "Lesser") ~= nil or string.find(spell, "Flash")  then
				validSpell.castingTime = 1.5;
			elseif string.find(spell,"Wave") ~= nil and string.find(spell,"Lesser")== nil then	
				if rank == "Rank 1" then
					validSpell.castingTime = 1.5;
				elseif rank == "Rank 2" then
					validSpell.castingTime = 2;
				elseif rank == "Rank 3" then
					validSpell.castingTime = 2.5;
				else
					validSpell.castingTime = 3;
				end
			elseif string.find(spell,"Healing Touch")then
				if rank == "Rank 1" then
					validSpell.castingTime = 1.5;
				elseif rank == "Rank 2" then
					validSpell.castingTime = 2;
				elseif rank == "Rank 3" then
					validSpell.castingTime = 2.5;
				elseif rank == "Rank 4" then
					validSpell.castingTime = 3;
				else 
					validSpell.castingTime = 3.5;
				end
				
			elseif string.find(spell,"Greater Heal") or string.find(spell,"Heal")then
			
				validSpell.castingTime = 3;
					
			
			elseif string.find(spell,"Regrowth") then
				validSpell.castingTime = 2;
			
			elseif string.find(spell,"Holy Light") then
				validSpell.castingTime = 2.5;	
			end
			
					
			CastOnClickTooltip:SetSpell( i, BOOKTYPE_SPELL );
			
			local text = CastOnClickTooltipTextLeft2:GetText();
			local _,_,value = string.find( text, "(%d*) Mana" );
			if( value ) then
				validSpell.mana = tonumber( value );
			end			
			
			text = CastOnClickTooltipTextLeft4:GetText();
			
			_,_,value = string.find( text, "(%d*) to" );
			if( value ) then
				validSpell.minHeal = tonumber( value );
			end
			
			
			_,_,value = string.find( text, "to (%d*)" );
			if( value ) then
				validSpell.maxHeal = tonumber( value );
			end
			
			
			validSpell.avgHeal = (validSpell.maxHeal + validSpell.minHeal)/2;
						
			if (string.find(validSpell.name, "Lesser") ~= nil or string.find(spell, "Flash") or string.find(spell, "Regrowth")) then 
				CastOnClickFastSpellTable[j] = validSpell;
				j = j + 1;
			else 
				CastOnClickEfficientSpellTable[k] = validSpell;
				k = k + 1;
			end
			
			
		end
		
		i= i+1;
	end
	
	
	
end	
			
		
	
	
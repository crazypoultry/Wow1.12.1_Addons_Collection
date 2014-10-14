local spell_ranks = {
	[WATCHDOG.BUFF_PWF]            	= {1,12,24,36,48,60},
	[WATCHDOG.BUFF_PWS]            	= {6,12,18,24,30,36,42,48,54,60},
	[WATCHDOG.BUFF_SP]             	= {30,42,56},
	[WATCHDOG.BUFF_DS]             	= {30,40,50,60},
	[WATCHDOG.BUFF_RENEW]          	= {8,14,20,26,32,38,44,50,56,60},   
	[WATCHDOG.BUFF_MOTW]           	= {1,10,20,30,40,50,60},
	[WATCHDOG.BUFF_THORNS]         	= {6,14,24,34,44,54},
	[WATCHDOG.BUFF_REJUVENATION]   	= {4,10,16,22,28,34,40,46,52,58,60},
	[WATCHDOG.BUFF_REGROWTH]       	= {12,18,24,30,36,42,48,54,60},
	[WATCHDOG.BUFF_AI]             	= {1,14,28,42,56},
	[WATCHDOG.BUFF_DM]             	= {12,24,34,48,60},
	[WATCHDOG.BUFF_AM]             	= {18,30,42,54},
	[WATCHDOG.BUFF_BOM]            	= {4,12,22,32,42,52,60},
	[WATCHDOG.BUFF_BOP]            	= {10,24,38},
	[WATCHDOG.BUFF_BOW]            	= {14,24,34,44,54,60},
	[WATCHDOG.BUFF_BOS]            	= {20,30,40,50,60},
	[WATCHDOG.BUFF_BOL]            	= {40,50,60},
	[WATCHDOG.BUFF_BOSFC]          	= {46,54},
}

function WD_BestRank(spellname,unit)
   local current_id = wd_spells[spellname] or tonumber(spellname)
   if not current_id then return nil end
   
   local s,e = string.find(spellname,WATCHDOG.RANK)
   if s then
      spellname = string.sub(spellname,1,s-2)
   end

   local ranklist = spell_ranks[spellname]
   if not ranklist then return current_id,unit end
   
   local unitlevel = UnitLevel(unit)   

   for i=(current_id - wd_spells[(spellname.."("..WATCHDOG.RANK.." 1)")] + 1),1,-1 do
      if (unitlevel >= (ranklist[i]-10)) then
         return wd_spells[(spellname.."("..WATCHDOG.RANK.." "..i..")")],unit
      end
   end

   return nil
end



function WD_Bandage(unit)
   local mytarget = UnitName("target")
   
   if ( UnitIsFriend("player","target") and (not UnitIsUnit(this.unit,"target")) ) then                     
         ClearTarget();
   else mytarget=nil; end
   
   UseContainerItem(0,1);
   
   if SpellIsTargeting() then SpellTargetUnit(unit) end
   
   if mytarget then TargetByName(mytarget) end
end

function WD_CureAny(unit)
   if UnitCanAttack("player",unit) then return end
   for i=1,8 do
      WorldMapTooltipTextRight1:SetText(nil)
      WorldMapTooltip:SetUnitDebuff(unit,i)
      local type = WorldMapTooltipTextRight1:GetText()   
   
      local spell = wd_cures[type]      
      
      if spell then
		-- If Dispel Magic
         if spell==WATCHDOG.CURE_MAGIC_1 then   
            if UnitCanAttack("player","target") then
               TargetUnit(unit) WatchDog_CastSpell(spell,unit) TargetLastEnemy()
            else
               WatchDog_CastSpell(spell,unit)               
            end            
         else
            if (spell==WATCHDOG.CURE_DISEASE_1 and wd_spells[WATCHDOG.CURE_DISEASE_2]) then spell=WATCHDOG.CURE_DISEASE_2 end
            if (spell==WATCHDOG.CURE_POISON_1 and wd_spells[WATCHDOG.CURE_POISON_2]) then spell=WATCHDOG.CURE_POISON_2 end
            if (spell==WATCHDOG.CURE_PURIFY_1 and wd_spells[WATCHDOG.CURE_CLEANSE_1]) then spell=WATCHDOG.CURE_CLEANSE_1 end
            WatchDog_CastSpell(spell,unit)
         end
         break
      end
         
   end      
end

function WD_Menu(unit)

   local type,x = nil,nil

   if unit == "player" then
      type = PlayerFrameDropDown 
   elseif unit == "target" then      
      type = TargetFrameDropDown
   elseif unit == "pet" then
      type = PetFrameDropDown   
   elseif string.find(unit,"party") then
      _,_,x = string.find(unit,"(%d+)")         
      type = getglobal("PartyMemberFrame"..x.."DropDown")
   end   
   
   if x then this:SetID(x) end
   
   if type then
      type.unit = unit
      type.name = UnitName(unit)
      ToggleDropDownMenu(1, nil, type,"cursor")
   end
end 
--[[
	***********************************************

	GLOCK Localization Instructions and variables and functions in this file
	direct questions to

	***********************************************


Instructions for localization:
in the first global if statement, all of the variables must be set into their equivalent forms in the other language

in the FUNCTION, GLOCK_DmgParse(), you must do the following things.

The arg1 variable looks something like this (in english):

"Your Shadow Bolt hits Ragnaros for 1000 Shadow damage."
or
"Your Shadow Bolt hits Ragnaros for 500 Shadow damage. (500 resisted)"
or
"Your Shadow Bolt was resisted by Ragnaros."
or
"Your Shadow Bolt was evaded by Ragnaros."
or
"Your Shadow Bolt is absorbed by Ragnaros."
or
"Your Shadow Bolt hits Ragnaros for 300 Shadow damage. (500 resisted) (200 absorbed)."
or
"Your Shadow Bolt is reflected by Ragnaros."
or
"Your Shadow Bolt failed. Ragnaros is immune."
or
"Your Shadow Bolt hits Ragnaros for 1500 Shadow damage. (+500 vulnerability)
Etc...

I am not sure about the EXACT formulation of the above phrases as I write this guide, so do some testing for yourself if things don't work out.
But i'm pretty sure this is solid.

Your version of this function needs to do the following tasks:
1) Drop out if the target is a player and you have PVP turned off (i.e. GLOCK_Config["PVP"]==0
2) Drop out (return) if your current target's name can't be found in your arg1 string or if you have no target
3) Call the function GLOCK_DecipherShool(arg1) to determine which spell school was just cast (drop out if GLOCK_cast_school==nil after this call)


Your version of the function needs to return (stop) if any of the following conditions are met:
-Totally Absorbed
-evade
-reflected

You need to extract the following things from your localized chat text (and save to the corresponding variables):
-Immunity
		If a mob is immune to a school then MobResistDB[GLOCK_dbindex.."immune"]=1;
		if the mob is not immune now, but was recorded as immune before then MobResistDB[GLOCK_dbindex.."immune"]=nil;

-Vulnerability
		if a mob is vulnerable then set the following:
			MobResistDB[GLOCK_dbindex.."vuln"]=1;
			MobResistDB[GLOCK_dbindex]=nil;

-DAMAGE DEALT
		store the amount of damage dealt to the mob in the variable gdamage

-DAMAGE RESISTED
		store the amount of damage resisted to the variable gresist
		if the spell is totally resisted, the varible gmitigated should be set to 100 when you leave the function

-DAMAGE ABSORBED
		if part of the spell was absorbed by your target, store the amount absorbed to the variable gabsorbed

-DAMAGE BONUS FROM VULN
		if the total damage was increased by a vulnerability bonus, store the extra damage to the variable gvuln
		return from the function if vuln was detected

then,

--Calculate the variable gmitigated 
		if the spell was totally resisted, gmitigated=100
		else, gmitigated=100*gresist/(gresist+gabsorbed+gdamage)
		

	then call the function GLOCK_ResistCalc() 


Use my english function as a template here to make yours work



]]


--DECLARE TEXT STRING VARIABLES HERE
if (GetLocale()=="deDE") then

elseif (GetLocale()=="frFR") then



		GLOCK_schools={"Arcane","Fire","Frost","Nature","Shadow"};
		GLMAGE="mage"

	--THESE ARE THE ONLY SPELLS THIS MOD WILL RESPOND TO
		GLOCK_Arcane={"Projectile des arcanes","Projectiles des arcanes","Eclat lunaire","Feu stellaire"}
		GLOCK_Fire={"Immolation","Douleur br\195\187lante","Conflagration","Feu de l'\195\162me","Trait de feu","Boule de feu","Explosion pyrotechnique","Br\195\187lure","Horion de feu"}
		GLOCK_Frost={"Eclair de givre","Horion de givre"}
		GLOCK_Nature={"Col\195\168re","Horion de terre","Eclair","Cha\195\174ne d'\195\169clairs"}
		GLOCK_Shadow={"Trait de l'ombre","Attaque mentale","Fouet mental","Br\195\187lure de mana"}

	--FOR SET BONUSES
		GLARCANIST="Tenue de parade d'arcaniste"
		GLZANZIL="Concentration de Zanzil"

	--SPECIFIC TEXT ON ITEMS
		GLEQUIP_PENETRATION="Equip\195\169 : Diminue les r\195\169sistances magiques des cibles de vos sorts de "
		GLEQUIP_HIT="Equip\195\169 : Augmente vos chances de toucher avec des sorts de "
		GLMAGE_ZGHIT="Chances de toucher des sorts"

	--SPELL NAMES AND SPELL NAMES WITH RANK
		GL_COS="Mal\195\169diction de l'ombre"
		GL_COE="Mal\195\169diction des \195\169l\195\169ments"
		GL_COR="Mal\195\169diction de t\195\169m\195\169rit\195\169"
		GL_TF="Lame-tonnerre"

		GL_COSr="Mal\195\169diction de l'ombre(rang 2)"
		GL_COEr="Mal\195\169diction des \195\169l\195\169ments(rang 3)"
		GL_CORr="Mal\195\169diction de t\195\169m\195\169rit\195\169(rang 4)"
		GL_COAr="Mal\195\169diction d'agonie(rang 6)"

		GL_Eye="Clairvoyance d'obsidienne"  --This is the buff for the Eye of Moam
	
	--WAND STUFF	
		GLWANDACTION="Tir"
		GL_WAND_TEXT={"D\195\169g\195\162ts %(Arcane%)","D\195\169g\195\162ts %(Feu%)","D\195\169g\195\162ts %(Givre%)","D\195\169g\195\162ts %(Nature%)","D\195\169g\195\162ts %(Ombre%)"}


else --ENGLISH

		GLOCK_schools={"Arcane","Fire","Frost","Nature","Shadow"};
		GLMAGE="mage"

	--BWL VULN STUFF
		GLChromaggus="Chromaggus"
		GLChromEmote="flinches as its skin shimmers."
		GLDTW="Death Talon Wyrmguard"
		GLDTO="Death Talon Overseer"

		GLWeaveTip="Increases Shadow damage taken by"
		GLImpBoltTip="Shadow damage increased by"

	--THESE ARE THE ONLY SPELLS THIS MOD WILL RESPOND TO
		GLOCK_Arcane={"Arcane Explosion","Arcane Missile","Moonfire","Starfire"}
		GLOCK_Fire={"Hellfire","Immolate","Searing Pain","Conflagrate","Soul Fire","Fire Blast","Fireball","Pyroblast","Scorch","Flame Shock"}
		GLOCK_Frost={"Frostbolt","Frost Shock"}
		GLOCK_Nature={"Wrath","Earth Shock","Lightning Bolt","Chain Lightning"}
		GLOCK_Shadow={"Shadow Bolt","Mind Blast","Mind Flay","Mana Burn"}

		GLOCK_vulns={"Curse of Shadow","Curse of the Elements","Spell Vulnerability",
			" ignore me ","Shadow Vulnerability","Arcane Weakness","Fire Weakness","Frost Weakness",
			"Nature Weakness","Shadow Weakness","Stormstrike","Fire Vulnerability","Deaden Magic"}

	--FOR SET BONUSES
		GLARCANIST="Arcanist Regalia"
		GLZANZIL="Zanzil's Concentration"

	--SPECIFIC TEXT ON ITEMS
		GLEQUIP_PENETRATION="Equip: Decreases the magical resistances of your spell targets by "
		GLEQUIP_HIT="Equip: Improves your chance to hit with spells by "
		GLMAGE_ZGHIT="Spell Hit"

	--SPELL NAMES AND SPELL NAMES WITH RANK
		GL_COS="Curse of Shadow"
		GL_COE="Curse of the Elements"
		GL_COR="Curse of Recklessness"
		GL_TF="Thunderfury"
		
		GL_Weaving="Shadow Weaving"
		GL_impBolt="Shadow Vulnerability"

		GL_COSr="Curse of Shadow(rank 2)"
		GL_COEr="Curse of the Elements(rank 3)"
		GL_CORr="Curse of Recklessness(rank 4)"
		GL_COAr="Curse of Agony(rank 6)"

		GL_Eye="Obsidian Insight"  --This is the buff for the Eye of Moam

	--WAND STUFF	
		GLWANDACTION="Shoot"
		GL_WAND_TEXT={"Arcane Damage","Fire Damage","Frost Damage","Nature Damage","Shadow Damage"}

end

-------------------------
--This function parses the direct damage chat message
function GLOCK_DmgParse()


if  (GetLocale()=="deDE") then

elseif (GetLocale()=="frFR") then

	
	--Under several situations, resistance is not calculable
		if string.find(arg1,"est absorb\195\169") then return end
		if string.find(arg1,"est renvoy\195\169") then return end
		if string.find(arg1,"esquive") then return end

		if ( not GLOCK_Config["PVP"] )  then
			if (UnitIsPlayer("Target") and UnitIsEnemy("Target","Player")) then return end
		end

	--This part drops from the calculation if target changes 
	--(note that this can't determine if you're targeting a new mob of the same name but a different level)	
		GLTName=UnitName("Target");
		if GLTName==nil then return end
		if string.find(arg1,GLTName)==nil then return end  --The user may change targets before the spell hits (fail)
		arg1=string.gsub(arg1,GLTName,"Target");
	
	--DETERMINE if it's one of our supported spells
		GLOCK_DecipherSchool(arg1)
		if GLOCK_cast_school==nil then return end
		gpenetration=(getglobal("GLD"..string.lower(GLOCK_cast_school))+GLnegresist)/4;
	
		GLOCK_dbindex=GLOCK_Target_Name.."/"..GLOCK_Target_Level.."/"..GLOCK_cast_school
	
	--respond to immunity
		if (MobResistDB[GLOCK_dbindex]==nil and string.find(arg1,"insensible")) then 
			MobResistDB[GLOCK_dbindex.."immune"]=1;
			return
		elseif MobResistDB[GLOCK_dbindex.."immune"]==1 then
			 MobResistDB[GLOCK_dbindex.."immune"]=nil;
		end
	
	--EXTRACT DAMAGE DEALT
		i=string.find(arg1,"inflige")
		if i==nil then gdamage=0;
		else
			j,k=string.find(arg1,"%d+");
			gdamage=tonumber(string.sub(arg1,j,k));
		end
	
	--EXTRACT DAMAGE RESISTED
		
		if (string.find(arg1,"r\195\169siste") and (not string.find(arg1,"mais"))) then
			--i=string.find(arg1,"r\195\169siste")
			j,k=string.find(arg1,"%(%d+")
			gresist=tonumber(string.sub(arg1,j+1,k));
		else
			gresist=0;
		end
	
	--EXTRACT AMOUNT ABSORBED
		if (string.find(arg1,"absorb\195\169") and (not string.find(arg1,"par"))) then
			i=string.find(arg1,"absorb\195\169"); 
			j,k=string.find(arg1,"%(%d+",i-7); gabsorbed=tonumber(string.sub(arg1,j+1,k))			 	
		else	gabsorbed=0; end
	
	--EXTRACT DAMAGE FROM VULNERABILITY BONUS (have not implemented a negative resist calculation yet)
		i=string.find(arg1,"vulnerabilit\195\169")
		if i==nil then gvuln=0;
		else
			j=string.find(arg1,"+",i-7)
			gvuln=tonumber(string.sub(arg1,j+1,i-2))
		end
	
	--TRACK VULNERABILITIES
		if gvuln>0 then
			MobResistDB[GLOCK_dbindex.."vuln"]=1;
			MobResistDB[GLOCK_dbindex]=nil;
			return
		end
		if MobResistDB[GLOCK_dbindex.."vuln"]==1 then return end
	
		if string.find(arg1,"mais .+ r\195\169siste") then gmitigated=100;
		else gmitigated=100*gresist/(gresist+gabsorbed+gdamage); end
	
		GLOCK_ResistCalc()  --Split the function here because different versions of this chat parse function need localization


else --ENGLISH

		if (GLOCK_Config["PVP"]==0 and UnitIsPlayer("Target")) then return end
		GLTempArg1=arg1;

	--Under several situations, resistance is not calculable
		if string.find(GLTempArg1,"is absorbed") then return end
		if string.find(GLTempArg1,"is reflected") then return end
		if string.find(GLTempArg1,"evade") then return end



	--This part drops from the calculation if target changes 
	--(note that this can't determine if you're targeting a new mob of the same name but a different level)	
		GLTName=UnitName("Target");
		if GLTName==nil then return end
		if string.find(GLTempArg1,GLTName)==nil then return end  --The user may change targets before the spell hits (fail)
		GLTempArg1=string.gsub(GLTempArg1,GLTName,"Target");
		if GLOCK_Target_Name==nil then return end

	--DETERMINE if it's one of our supported spells
		GLOCK_DecipherSchool(GLTempArg1)
		if GLOCK_cast_school==nil then return end
		gpenetration=(getglobal("GLD"..string.lower(GLOCK_cast_school))+GLnegresist)/4;
	
		GLOCK_dbindex=GLOCK_Target_Name.."/"..GLOCK_Target_Level.."/"..GLOCK_cast_school
	
	--respond to immunity
		if string.find(GLTempArg1,"immune") then 
			MobResistDB[GLOCK_dbindex.."immune"]=1;
			GLOCK_UpdateGUI()
			return
		elseif MobResistDB[GLOCK_dbindex.."immune"] then  MobResistDB[GLOCK_dbindex.."immune"]=nil
		end
	
	--EXTRACT DAMAGE DEALT
		i=string.find(GLTempArg1,"for")
		if i==nil then gdamage=0;
		else
			j=string.find(GLTempArg1," ",i+4);
			gdamage=tonumber(string.sub(GLTempArg1,i+4,j));
		end
	
	--EXTRACT DAMAGE RESISTED
		
		if (string.find(GLTempArg1,"resisted") and (not string.find(GLTempArg1,"was resisted"))) then
			i=string.find(GLTempArg1,"resisted")
			j=string.find(GLTempArg1," ",i-9)
			gresist=tonumber(string.sub(GLTempArg1,j+2,i-2))			 	
		else
			gresist=0;
		end
	
	--EXTRACT AMOUNT ABSORBED
		if string.find(GLTempArg1,"absorbed") then
			i=string.find(GLTempArg1,"absorbed"); j=string.find(GLTempArg1," ",i-9); gabsorbed=tonumber(string.sub(GLTempArg1,j+2,i-2))			 	
		else	gabsorbed=0; end
	
	--EXTRACT DAMAGE FROM VULNERABILITY BONUS (have not implemented a negative resist calculation yet)
		i=string.find(GLTempArg1,"vulnerability")
		if i==nil then gvuln=0;
		else
			j=string.find(GLTempArg1,"+",i-7)
			gvuln=tonumber(string.sub(GLTempArg1,j+1,i-2))
		end
	
	--TRACK VULNERABILITIES
		if gvuln>0 then
			MobResistDB[GLOCK_dbindex.."vuln"]=1;
			MobResistDB[GLOCK_dbindex]=nil;
			GLOCK_UpdateGUI()
			return
		end
		if MobResistDB[GLOCK_dbindex.."vuln"]==1 then return end
	
		if string.find(GLTempArg1,"was resisted") then gmitigated=100; gdamage=0 gresist=0
		else gmitigated=100*gresist/(gresist+gabsorbed+gdamage); end
	
		GLOCK_ResistCalc()  --Split the function here because different versions of this chat parse function need localization
end  --locale if
end  --function

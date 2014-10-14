--[[
  ****************************************************************
	GLock
	
	A Suite of Warlock Utilities including a Mob resistance calculator
	v3.2 - Added Graphical recent resist history
	
	v3.0 - Retooled resist calculation to track average penetration and average hit % on the target. (corresponds w/ 1.11 wow release)	

	v2.5 - Added Eye of Moam Support, GLOCKLOCK function to lock UI, and set up for possibal localization
	
	v2.0 - Added configuration menu and an ability to search the database

	v1.3 - Added wand support.  Auto-chat channel joining.  Cleaner UI.  Minimize UI mode
	
	v1.2 - Added common chat channel for multi-user database contribution.  More bug fixes and tweaks to the calculation algorithm
	
	v1.1 - First Overhaul.  Added school detection for total resists, cleaner calculations, more data per mob and Binary Frost resist calculations
	
	v1.0 - Initial Release.  Only smart raid curse and resist calculator available

	Written by Ogdin of the Deathreaver Legion.  Shadow Moon
	Contact via posts at http://www.atlantic-orcs.org/

-- TODO
-- AUTO-detect leaving sync channel and clear GLOCK_Config["CHATCHANNEL"]
-- 

	
	****************************************************************]]


function GLOCK_version()

GLOCK_Config["VER"]="4.1"
DEFAULT_CHAT_FRAME:AddMessage("GLOCK version "..GLOCK_Config["VER"].." Loaded (type /glockhelp for a list of commands)")

end

function GLOCK_test(a)
--/gltest  --I put this here to test arbitrary code from in game as i'm learning

end

-----------------------------------------------------------------
--OnUpdate Event for several UI objects
function GLOCK_chatStatus()

		--Reset net status indicator to red every 1 second
		if (math.floor(GLOCK_TIME)<math.floor(GetTime())) then 
			GMaxActivity:SetVertexColor(1,0,0);
			GMinActivity:SetVertexColor(1,0,0);
		end
		
		if GLOCK_vulnbars:IsVisible() then
			GLOCK_scanVuln()
			GGArcaneTxT:SetText(GLOCK_round(GLVULNArcane*100))
			GGFireTxT:SetText(GLOCK_round(GLVULNFire*100))
			GGFrostTxT:SetText(GLOCK_round(GLVULNFrost*100))
			GGNatureTxT:SetText(GLOCK_round(GLVULNNature*100))
			GGShadowTxT:SetText(GLOCK_round(GLVULNShadow*100))

			GGArcane:SetHeight(GLVULNArcane*65/2)
			GGFire:SetHeight(GLVULNFire*65/2)
			GGFrost:SetHeight(GLVULNFrost*65/2)
			GGNature:SetHeight(GLVULNNature*65/2)
			GGShadow:SetHeight(GLVULNShadow*65/2)

			for iii=1,5 do
				if getglobal("GMin"..GLOCK_UIschools[iii].."TxT"):GetText()=="Imm" then 
					getglobal("GG"..GLOCK_UIschools[iii]):SetHeight(.05) 
					getglobal("GG"..GLOCK_UIschools[iii].."TxT"):SetText("0") end
			end
		end

		if GLOCK_graph:IsVisible() then
			--Draws the new data on the screen
			for ii=1,85 do getglobal("GG"..ii):SetHeight(36*(GLData1[ii])+1)  getglobal("GG"..ii.."_Background"):SetVertexColor(SchoolsR[GLData2[ii]],SchoolsG[GLData2[ii]],SchoolsB[GLData2[ii]]) end
		end

		--Execute command w/ period = GLt seconds
		if math.floor(GLOCK_TIME/GLt)<math.floor(GetTime()/GLt) then end

		GLOCK_TIME=GetTime();
end

function GLOCK_scanVuln()

--GLOCK_vulns={"Curse of Shadow","Curse of the Elements","Spell Vulnerability",
--	" jjj ","Shadow Vulnerability","Arcane Weakness","Fire Weakness","Frost Weakness",
--	"Nature Weakness","Shadow Weakness","Stormstrike","Fire Vulnerability","Deaden Magic"}

	GLVULNArcane=1
	GLVULNFire=1
	GLVULNFrost=1
	GLVULNNature=1
	GLVULNShadow=1

	for ji=1,16 do 
		GLTooltip:ClearLines();	
		GLTooltip:SetUnitDebuff("Target",ji);
		GSCALEID=0
		
		for k=1,13 do if GLTooltipTextLeft1:GetText()==GLOCK_vulns[k] then GSCALEID=k; end end

		if GSCALEID==1 then GLVULNArcane=GLVULNArcane*1.1 GLVULNShadow=GLVULNShadow*1.1 end
		if GSCALEID==2 then GLVULNFire=GLVULNFire*1.1 GLVULNFrost=GLVULNFrost*1.1 end
		if GSCALEID==3 then GLVULNShadow=GLVULNShadow*1.15 GLVULNArcane=GLVULNArcane*1.15 GLVULNFire=GLVULNFire*1.15 GLVULNFrost=GLVULNFrost*1.15 GLVULNNature=GLVULNNature*1.15 end
		if GSCALEID==5 then 
			_, ndebuffs, _=UnitDebuff("Target",ji)
			tTipAmp=GLTooltipTextLeft2:GetText()
			if string.find(tTipAmp,GLWeaveTip) then GLVULNShadow=GLVULNShadow*(1+.03*ndebuffs) end  --Priest Shadow Weaving
			if string.find(tTipAmp,GLImpBoltTip) then GLVULNShadow=GLVULNShadow*1.2 end   --Warlock Improved bolt talent
		end
		if GSCALEID==6 then GLVULNArcane=GLVULNArcane*2 end
		if GSCALEID==7 then GLVULNFire=GLVULNFire*2 end
		if GSCALEID==8 then GLVULNFrost=GLVULNFrost*2 end
		if GSCALEID==9 then GLVULNNature=GLVULNNature*2 end
		if GSCALEID==10 then GLVULNShadow=GLVULNShadow*2 end
		if GSCALEID==11 then GLVULNNature=GLVULNNature*1.2 end
		if GSCALEID==12 then _, ndebuffs, _=UnitDebuff("Target",ji) GLVULNFire=GLVULNFire*(1+.03*ndebuffs) end
			
		GLTooltip:ClearLines();
	end

	for ji=1,16 do 
		GLTooltip:ClearLines();	
		GLTooltip:SetUnitBuff("Target",ji);
		GSCALEID=0
		for k=1,13 do if GLTooltipTextLeft1:GetText()==GLOCK_vulns[k] then GLSCALEID=k; end end
		if GSCALEID==13 then GLVULNShadow=GLVULNShadow*0.5 GLVULNArcane=GLVULNArcane*0.5 GLVULNFire=GLVULNFire*0.5 GLVULNFrost=GLVULNFrost*0.5 GLVULNNature=GLVULNNature*0.5 end
		GLTooltip:ClearLines();
	end

	if UnitName("Target")==GLDTO or UnitName("Target")==GLDTW or UnitName("Target")==GLChromaggus then 
		GLVULNShadow=GLVULNShadow/3 GLVULNArcane=GLVULNArcane/3 GLVULNFire=GLVULNFire/3 
		GLVULNFrost=GLVULNFrost/3 GLVULNNature=GLVULNNature/3 
			GBWLVuln() end

end

-------------------------------
--This Function Handles Modification of Target Resists Based on determined resists from raid.
-------------------------------
function GBWLVuln()

	--Handle Chromaggus as GLRaidTargets[1]
	if UnitName("Target")==GLChromaggus then 
		if GLRaidTargets[1]==1 then GLVULNArcane=GLVULNArcane*9 end
		if GLRaidTargets[1]==2 then GLVULNFire=GLVULNFire*9 end
		if GLRaidTargets[1]==3 then GLVULNFrost=GLVULNFrost*9 end
		if GLRaidTargets[1]==4 then GLVULNNature=GLVULNNature*9 end
		if GLRaidTargets[1]==5 then GLVULNShadow=GLVULNShadow*9 end
	return end

	GLRaidID=GetRaidTargetIndex("Target");
	if GLRaidID==nil then return end
	
	if GLRaidTargets[GLRaidID]==1 then GLVULNArcane=GLVULNArcane*9 end
	if GLRaidTargets[GLRaidID]==2 then GLVULNFire=GLVULNFire*9 end
	if GLRaidTargets[GLRaidID]==3 then GLVULNFrost=GLVULNFrost*9 end
	if GLRaidTargets[GLRaidID]==4 then GLVULNNature=GLVULNNature*9 end
	if GLRaidTargets[GLRaidID]==5 then GLVULNShadow=GLVULNShadow*9 end

end

--This Will track damage dealt from your spells to see if it's larger than it should be and determine if the mob is vuln to your spell school

function GBWLSpotVuln()
--[[
This is called right after damage is parsed from combat log
Will need to send a chat message if the school is not known (or is different) in GLRaidTargets[] for this mob
<GLOCKBWL> header

--]]

	GLBaseDmg=0

	for index,value in ipairs(GLOCK_Arcane) do if string.find(GLTempArg1,value) then GLBaseDmg=GLOCK_ArcaneD[index] end end
	for index,value in ipairs(GLOCK_Fire) do if string.find(GLTempArg1,value) then GLBaseDmg=GLOCK_FireD[index] end end
	for index,value in ipairs(GLOCK_Frost) do if string.find(GLTempArg1,value) then GLBaseDmg=GLOCK_FrostD[index] end end
	for index,value in ipairs(GLOCK_Nature) do if string.find(GLTempArg1,value) then GLBaseDmg=GLOCK_NatureD[index] end end
	for index,value in ipairs(GLOCK_Shadow) do if string.find(GLTempArg1,value) then GLBaseDmg=GLOCK_ShadowD[index] end end
	

	if string.find(GLTempArg1,GLWANDACTION) then
			GLTooltip:SetInventoryItem("Player", 18);
			lines = GLTooltip:NumLines();		
			for i=2, lines do
				tmpText = getglobal("GLTooltipTextLeft"..i);
				tmpStr=tmpText:GetText()
				if (tmpStr) then
					if string.find(tmpStr,"-") then 
						GLOCK_temp1=string.find(tmpStr,"-")
						GLOCK_temp2=string.find(tmpStr," ",GLOCK_temp1+2)
					GLBaseDmg=(tonumber(string.sub(tmpStr,1,GLOCK_temp1-2))+tonumber(string.sub(tmpStr,GLOCK_temp1+2,GLOCK_temp2-1)))/2
					end
				end
					
			end
	end

	GLBaseDmg=GLBaseDmg*2  --Ballpark base damage w/ gear and talent and debuff bonuses and crits	
		
	GLRaidID=GetRaidTargetIndex("Target");
	if UnitName("Target")==GLChromaggus then GLRaidID=1 end
	if GLRaidID==nil then return end
	
	for i=1,5 do if GLOCK_cast_school==GLOCK_schools[i] then GTempSchoolID=i end end
	
	if (gdamage+gresist)>GLBaseDmg then 
		GLRaidTargets[GLRaidID]=GTempSchoolID
		if GLOCK_Config["CHATCHANNEL"] then
			SendChatMessage("<GLOCKBWL>"..GLRaidID..GLRaidTargets[GLRaidID],"CHANNEL",nil,GetChannelName(GLOCK_Config["CHATCHANNEL"]))
		end
	end
end

function GBWLChatCatch(arg1)
	--DEFAULT_CHAT_FRAME:AddMessage(arg1)
	arg1=string.gsub(arg1,"<GLOCKBWL>","")
	GLRaidTargets[tonumber(string.sub(arg1,1,1))]=tonumber(string.sub(arg1,2,2))
end

function GLOCK_help()

DEFAULT_CHAT_FRAME:AddMessage("/gljoin <channel> - links GLOCK to a common channel")
DEFAULT_CHAT_FRAME:AddMessage("/glocklock - toggles locking the GLOCK UI in place")
DEFAULT_CHAT_FRAME:AddMessage("/glock - bring up the config/search panel")
DEFAULT_CHAT_FRAME:AddMessage("/glraidcurse - Smart Raid Curse script")

end


function GLOCK_lock()
--toggles lock status
	if GLOCK_frame:GetScript("OnMouseDown")==nil then
		GLOCK_frame:SetScript("OnMouseDown",glocklockmax)
		GLOCK_minimize:SetScript("OnMouseDown",glocklockmin)
		DEFAULT_CHAT_FRAME:AddMessage("GLOCK Unlocked.")
		GLOCK_Config["LOCKED"]=0
	else
		GLOCK_frame:SetScript("OnMouseDown",nil)
		GLOCK_minimize:SetScript("OnMouseDown",nil)
		DEFAULT_CHAT_FRAME:AddMessage("GLOCK locked.")
		GLOCK_Config["LOCKED"]=1
	end

end

function glocklockmax() GLOCK_frame:StartMoving() end
function glocklockmin() GLOCK_minimize:StartMoving() end
function glconfig() GLOCK_config:Show() end

function GLSliderAction()
	GLOCK_Config["UISCALE"]=this:GetValue()/100
	GLOCK_frame:SetScale(this:GetValue()/100)
end


----------------------
-- Event Handler
-- this function parses events
function GLOCK_OnEvent()
	
	if event=="CHAT_MSG_SPELL_SELF_DAMAGE" then GLOCK_DmgParse() end
	if event=="UNIT_INVENTORY_CHANGED" then GLOCK_scanGear() end
	if event=="UNIT_AURA" then GLOCK_scanTarget() end
	if event=="UNIT_AURASTATE" then GLOCK_scanTarget() end
	if event=="PLAYER_TARGET_CHANGED" then GLOCK_scanTarget() end
	if event=="CHAT_MSG_CHANNEL" then GLOCK_chatHandle() end
	if event=="CHAT_MSG_RAID" then GLOCK_syncChanRaid() end
	if event=="VARIABLES_LOADED" then GLOCK_Initialize() end

	if event=="PLAYER_REGEN_ENABLED" then for i=1,16 do GLRaidTargets[i]=0; end end
	if event=="RAID_TARGET_UPDATE" then for i=1,16 do GLRaidTargets[i]=0; end end
	if event=="CHAT_MSG_MONSTER_EMOTE" and string.find(arg1,GLChromEmote) then for i=1,16 do GLRaidTargets[i]=0; end end
	
end





-----------------------------------------------------------------------------------------------------------
--Handles graphics updates for the data on screen
-----------------------------------------------------------------------------------------------------------
function GLOCK_UpdateGUI()

	if GLOCK_Config["VISIBLE"]==nil then GLOCK_frame:Hide() GLOCK_minimize:Hide() return end
	if GLOCK_Target_Name==nil then return end
	if GLOCK_Target_Level==nil then return end

	jj=0;

--COLOR LEVEL DIFFERENCE
	GLOCK_Tlvl:SetText(GLOCK_Target_Level)
	GLOCK_TName:SetText(GLOCK_Target_Name)
	if GLOCK_Target_Level>=0 then GLOCK_Tlvl:SetTextColor(.5,.5,.5) end
	if GLOCK_Target_Level>=48 then GLOCK_Tlvl:SetTextColor(.2,.9,.2) end
	if (GLOCK_Target_Level>=58 and GLOCK_Target_Level<=62) then GLOCK_Tlvl:SetTextColor(1,1,0) end
	if (GLOCK_Target_Level==63) then GLOCK_Tlvl:SetTextColor(.9,.5,.4) end
	if (GLOCK_Target_Level>63) then GLOCK_Tlvl:SetTextColor(1,.2,.2) end
	if (GLOCK_Target_Level==-1) then GLOCK_Tlvl:SetTextColor(1,.2,.2); GLOCK_Tlvl:SetText("Boss") end


	for i=1,5 do
		GLOCK_dbindex=GLOCK_Target_Name.."/"..GLOCK_Target_Level.."/"..GLOCK_schools[i]
		getglobal("GLOCK_"..GLOCK_UIschools[i].."VulnT"):Hide()
		getglobal("GLOCK_"..GLOCK_UIschools[i].."Vuln"):Hide()
		getglobal("GLOCK_"..GLOCK_UIschools[i].."H"):Hide()
		getglobal("GLOCK_"..GLOCK_UIschools[i].."R"):Hide()
		getglobal("GLOCK_"..GLOCK_UIschools[i].."M"):Hide()

	--If There is a database entry and mob is not immune or vulnerable
		if (MobResistDB[GLOCK_dbindex]~=nil and (not(MobResistDB[GLOCK_dbindex.."immune"]==1 or MobResistDB[GLOCK_dbindex.."vuln"]==1))) then 
			a=MobResistDB[GLOCK_dbindex];
			GLOCK_temp1=string.find(a,"/");	GLOCK_temp2=string.find(a,"_");	GLOCK_temp3=string.find(a,"A");	GLOCK_temp4=string.find(a,"|");
			
			GLOCK_DBMiti=tonumber(string.sub(a,1,GLOCK_temp1-1));			
			GLOCK_DBHits=tonumber(string.sub(a,GLOCK_temp1+1,GLOCK_temp2-1))
			GLOCK_DBMiss=tonumber(string.sub(a,GLOCK_temp2+1,GLOCK_temp3-1))	
			GLOCK_DBMinR=tonumber(string.sub(a,GLOCK_temp3+1,GLOCK_temp4-1))	
			GLOCK_DBi=tonumber(string.sub(a,GLOCK_temp4+1))				
			
		--CHECK FOR ERRORS
			if GLOCK_DBMiti==nil or GLOCK_DBHits==nil or GLOCK_DBMiss==nil then GLOCK_DBMiti=0; MobResistDB[GLOCK_dbindex]=nil; return end
			if GLOCK_DBMiti<0 then GLOCK_DBMiti=0; end    --Sometimes Frost resist scores appear negative in the calculation

		--Display Resist Approximations
			GTxT=tostring(GLOCK_round(4*GLOCK_DBMiti));
			getglobal("GMin"..GLOCK_UIschools[i].."TxT"):SetText(GTxT)
			getglobal("GLOCK_"..GLOCK_UIschools[i].."R"):SetText(GTxT)
			
		--Display #Casts
			getglobal("GLOCK_"..GLOCK_UIschools[i].."H"):SetText(GLOCK_round(GLOCK_DBHits+GLOCK_DBMiss))

		--Display %Hit (avg +hit%)  (i.e. 86(3)% )
			GTxT=string.format("%.0f(%.0f)",GLOCK_round(100*GLOCK_DBHits/(GLOCK_DBMiss+GLOCK_DBHits)),GLOCK_DBi)
			getglobal("GLOCK_"..GLOCK_UIschools[i].."M"):SetText(GTxT)

		--Display Current Penetration (avg Penetration) (i.e. 75(60) )
			GTxT=string.format("%.0f(%.0f)",getglobal("GLD"..string.lower(GLOCK_UIschools[i]))+GLnegresist,GLOCK_DBMinR)
			getglobal("GLOCK_"..GLOCK_UIschools[i].."Vuln"):SetText(GTxT)
			jj=jj+1;

	--If the mob is recorded as immune or vulnerable
		elseif (MobResistDB[GLOCK_dbindex.."immune"]==1 or MobResistDB[GLOCK_dbindex.."vuln"]==1) then 
			if MobResistDB[GLOCK_dbindex.."immune"]==1 then GLSpecial="Imm" end
			if MobResistDB[GLOCK_dbindex.."vuln"]==1 then GLSpecial="Vul" end
			getglobal("GLOCK_"..GLOCK_UIschools[i].."R"):SetText(GLSpecial) 
			getglobal("GMin"..GLOCK_UIschools[i].."TxT"):SetText(GLSpecial)
			getglobal("GLOCK_"..GLOCK_UIschools[i].."H"):SetText("0")
			getglobal("GLOCK_"..GLOCK_UIschools[i].."M"):SetText("0")
			jj=jj+1;

	--If there is no data for this mob
		elseif ((not MobResistDB[GLOCK_dbindex]) and (not MobResistDB[GLOCK_dbindex.."immune"]) and (not MobResistDB[GLOCK_dbindex.."vuln"])) then
			getglobal("GMin"..GLOCK_UIschools[i].."TxT"):SetText("")
		end

	--If there is data for this mob, display the text object in the maximized window
		if MobResistDB[GLOCK_dbindex] or MobResistDB[GLOCK_dbindex.."immune"] or MobResistDB[GLOCK_dbindex.."vuln"] then
			getglobal("GLOCK_"..GLOCK_UIschools[i].."VulnT"):Show()
			getglobal("GLOCK_"..GLOCK_UIschools[i].."Vuln"):Show()
			getglobal("GLOCK_"..GLOCK_UIschools[i].."H"):Show()
			getglobal("GLOCK_"..GLOCK_UIschools[i].."R"):Show()
			getglobal("GLOCK_"..GLOCK_UIschools[i].."M"):Show()

			getglobal("GLOCK_"..GLOCK_UIschools[i].."VulnT"):SetPoint("TOPLEFT",5,-45-10*(jj-1));
			getglobal("GLOCK_"..GLOCK_UIschools[i].."Vuln"):SetPoint("TOPLEFT",25,-45-10*(jj-1));
			getglobal("GLOCK_"..GLOCK_UIschools[i].."H"):SetPoint("TOPLEFT",70,-45-10*(jj-1));
			getglobal("GLOCK_"..GLOCK_UIschools[i].."M"):SetPoint("TOPLEFT",110,-45-10*(jj-1));
			getglobal("GLOCK_"..GLOCK_UIschools[i].."R"):SetPoint("TOPLEFT",160,-45-10*(jj-1));
		end
	end

	


	if MobResistDB["UISTATE"]=="MAXIMIZED" then
		GLOCK_frame:Show()
		GLOCK_minimize:Hide()
	else
		GLOCK_frame:Hide()
		GLOCK_minimize:Show()
	end

end




-----------------------------------------------------------------------------------------------------------
--Determine the debuffs on the target or buffs on the player that add to penetration
-----------------------------------------------------------------------------------------------------------
function GLOCK_scanTarget()

	GLDshadow=0;
	GLDarcane=0;
	GLDfrost=0;
	GLDfire=0;
	GLDnature=0;

	
	--if unit is a friendly NPC, then hide glock
	if ((UnitIsFriend("Target","Player")) and (not UnitIsPlayer("Target"))) then GLOCK_frame:Hide(); GLOCK_minimize:Hide() return; end
	
	--If the unit is friendly PC and pvp is off, then hide glock
	if ((not UnitIsEnemy("Target","Player")) and (not GLOCK_Config["PVP"]) and UnitIsPlayer("Target")) then GLOCK_frame:Hide(); GLOCK_minimize:Hide() return; end

	--If PvP is off and the target is an enemy player, then hide glock		
	if ( not GLOCK_Config["PVP"] )  then
		if (UnitIsPlayer("Target") and UnitIsEnemy("Target","Player")) then GLOCK_frame:Hide(); GLOCK_minimize:Hide() return; end
	end

--ScanTarget for Resist debuffs


	GLOCK_Target_Name=UnitName("Target");
	if UnitIsPlayer("Target") then GLOCK_Target_Name="*"..UnitName("Target").."*" end
	GLOCK_Target_Level=UnitLevel("Target");
	GLOCK_YourHitT:SetTextColor(1,1,0)
	
	if not GLOCK_Target_Name then 
		GLOCK_frame:Hide();
		GLOCK_minimize:Hide()
		GLOCK_confirm:Hide()
		for i=1,5 do getglobal("GLOCK_confirm_"..GLOCK_UIschools[i]):SetChecked(1) end
		return;
	end
		

--	GLTargetModel:SetUnit("Target")

		TFury=0;

--DEBUFF SCANNING
	for i=1,16 do
		GLTooltip:ClearLines();	
		GLTooltip:SetUnitDebuff("Target",i);
		if (GLTooltipTextLeft1:GetText()==GL_COS) then GLDshadow=GLDshadow+75; GLDarcane=GLDarcane+75 end
		if (GLTooltipTextLeft1:GetText()==GL_COE) then GLDfrost=GLDfrost+75; GLDfire=GLDfire+75 end
		if (GLTooltipTextLeft1:GetText()==GL_TF and TFury==0) then GLDnature=GLDnature+25; TFury=1; end
	end


--EYE OF MOAM BUFF ON PLAYER
	for i=1,16 do
		GLTooltip:ClearLines();
		GLTooltip:SetUnitBuff("Player",i);
		if GLTooltipTextLeft1:GetText()==GL_Eye then 
			GLDshadow=GLDshadow+100
			GLDarcane=GLDarcane+100
			GLDfrost=GLDfrost+100
			GLDfire=GLDfire+100
			GLDnature=GLDnature+100
		end
	end

	GLOCK_UpdateGUI()


end

-----------------------------------------------------------------------------------------------------------
--Keep track of penetration and hit chance from gear you have equipped
-----------------------------------------------------------------------------------------------------------
function GLOCK_scanGear()

--DETERMINE HOW MUCH -RESIST and +HIT gear player has on

	GLnegresist=0;
	GLhit=0;
	GLARCANISTSet=0;
	GLZANZILSet=0

	for i=1,18 do
		hasItem = GLTooltip:SetInventoryItem("player", i);
		if ( not hasItem ) then
			GLTooltip:ClearLines()
		else
			itemName = GLTooltipTextLeft1:GetText();

			lines = GLTooltip:NumLines();

			for i=2, lines do
				tmpText = getglobal("GLTooltipTextLeft"..i);
				if (tmpText:GetText()) then
					tmpStr = tmpText:GetText();

					if string.find(tmpStr,GLEQUIP_PENETRATION) then
						tmpStr=string.gsub(tmpStr,GLEQUIP_PENETRATION,"")
						tmpStr=string.sub(tmpStr,1,-2)
						GLnegresist=GLnegresist+tonumber(tmpStr);
					end
					if string.find(tmpStr,GLEQUIP_HIT) then
						tmpStr=string.gsub(tmpStr,GLEQUIP_HIT,"")
						tmpStr=string.sub(tmpStr,1,1)
						GLhit=GLhit+tonumber(tmpStr);
					elseif string.find(tmpStr,GLMAGE_ZGHIT) then    ---Mage helm/leg ZG enchant
						GLhit=GLhit+1;
					elseif string.find(tmpStr,GLARCANIST) then
						GLARCANISTSet=GLARCANISTSet+1;
					elseif string.find(tmpStr,GLZANZIL) then
						GLZANZILSet=GLZANZILSet+1;
					end
				end
			end
		end
	end	
		if GLARCANISTSet>=5 then GLnegresist=GLnegresist+10; end
		if GLZANZILSet==2 then GLhit=GLhit+1 end

--This Elemental Precision and Arcane Subtlety talent scan was written by Aelian of Theorycraft
	local _, class = UnitClass("player")
	if string.lower(class) == GLMAGE then
		_, _, _, _, GLElemPrec = GetTalentInfo(3, 3)
		GLhit = GLhit + GLElemPrec*2
		local _, _, _, _, currank = GetTalentInfo(1, 1)
		GLnegresist = GLnegresist + currank*5
	end
	

	if ((not GLDshadow) or (not GLDarcane) or (not GLDfrost) or (not GLDfire) or (not GLDnature)) then GLOCK_scanTarget() end

	GLOCK_HitP:SetText(GLhit.."% Hit")
	GLOCK_ShadowVuln:SetText(GLDshadow+GLnegresist)
	GLOCK_ArcaneVuln:SetText(GLDarcane+GLnegresist)
	GLOCK_FrostVuln:SetText(GLDfrost+GLnegresist)
	GLOCK_FireVuln:SetText(GLDfire+GLnegresist)
	GLOCK_NatureVuln:SetText(GLDnature+GLnegresist)
	GLOCK_scanTarget()

end




---------------------------------------------------------------
-- This mod is a smart curse application to make sure that CoS, CoE and CoR are up on the mob in that order.
function GLOCK_raidCurse()

if UnitName("target")==nil then return; end
if UnitIsPlayer("target") then CastSpellByName(GL_COSr); return; end

GLc0s=0; GLc0e=0; GLc0r=0;
for i=1,16 do
	GLTooltip:ClearLines();	GLTooltip:SetUnitDebuff("Target",i);
	if (GLTooltipTextLeft1:GetText()==GL_COS) then GLc0s=1; end
	if (GLTooltipTextLeft1:GetText()==GL_COE) then GLc0e=1; end
	if (GLTooltipTextLeft1:GetText()==GL_COR) then GLC0R=1; end
end

if GLc0s==0 then CastSpellByName(GL_COSr)
elseif (GLc0s==1 and GLc0e==0) then CastSpellByName(GL_COEr)
elseif (GLc0s==1 and GLc0e==1 and GLc0r==0) then CastSpellByName(GL_CORr)
elseif (GLc0s==1 and GLc0e==1 and GLc0r==1) then CastSpellByName(GL_COAr) end

end











----------------------
--Set the global player config
function GLOCK_Initialize()

	GLVULNArcane=1
	GLVULNFire=1
	GLVULNFrost=1
	GLVULNNature=1
	GLVULNShadow=1

	GLFACTORS={.3, .2, .1, .05, .025, .01, .008, .005}
	GLCUSPS={0,30,40,60,100,150,200,500}
	SchoolsR={.9, .9, 1, .9, .4, 0}
	SchoolsG={.7, .9, 1, .5,  1, 0}
	SchoolsB={.9, .7, 1, .4, .4, 0}
	GLNewColor="Arcane";

			--Ballpark figures for base damage
		GLOCK_ArcaneD={250,230,200,540}
		GLOCK_FireD={210,280,220,500,800,480,680,850,250,300}
		GLOCK_FrostD={525,500}
		GLOCK_NatureD={250,530,430,500}
		GLOCK_ShadowD={550,520,520,200,300}
		GLOCK_WandDmin=0
		GLOCK_WandDmax=0

	GLOCK_factor=GLFACTORS[1]

	GLData1={}
	GLData2={}
	for i=1,85 do GLData1[i]=.01 GLData2[i]=6 end
	for ii=1,85 do getglobal("GG"..ii):SetPoint("BOTTOMLEFT",GLOCK_graph,"BOTTOMLEFT",(ii-1)*2+5,7) end
	GLGraphicsFlag=0
	GLNewData=0
	GLt=.001

	GLRaidTargets={}
	for i=1,16 do GLRaidTargets[i]=0; end

	GLOCK_MINTIP="";
	GLOCK_TIME=0;


	GLOCK_UIschools={"Arcane","Fire","Frost","Nature","Shadow"};	--FOR UI COMPONENT INDEXING (must stay in english)


	GLOCK_frame:Hide();
		
	if not MobResistDB then
		MobResistDB	= {	}
	end

	
	for i=1,9 do getglobal("GLOCKSearch_B"..i):Hide() end

	-- Add Slash Commands

	SlashCmdList["GLRAIDCURSE"] = GLOCK_raidCurse;
	SLASH_GLRAIDCURSE1 = "/glraidcurse";

	SlashCmdList["GLOCKVER"] = GLOCK_version;
	SLASH_GLOCKVER1 = "/glockver";
	
	SlashCmdList["GLJOIN"] = gljoin;
	SLASH_GLJOIN1 = "/gljoin";

	SlashCmdList["GLOCKHELP"] = GLOCK_help;
	SLASH_GLOCKHELP1 = "/glockhelp";

	SlashCmdList["GLOCK"] = glconfig;
	SLASH_GLOCK1 = "/glock";

	SlashCmdList["GLTEST"] = GLOCK_test;
	SLASH_GLTEST1 = "/gltest";

	SlashCmdList["GLOCKLOCK"] = GLOCK_lock;
	SLASH_GLOCKLOCK1 = "/glocklock";

	GLElemPrec=0
	GLHit=0;
	GLDshadow=0;
	GLDarcane=0;
	GLDfrost=0;
	GLDfire=0;
	GLDnature=0;

	GLOCK_Target_Level=0
	GLOCK_Target_Name=""

		GLOCK_frame:Hide()
		GLOCK_minimize:Hide()
		GLOCK_confirm:Hide()

	if not GLOCK_Config then
		GLOCK_Config={ }
		GLOCK_Config["VISIBLE"]=1
		GLOCK_Config["PVP"]=0
		GLOCK_Config["AUTOLINK"]=0
		GLOCK_Config["SEARCHON"]=1
		GLOCK_Config["LOCKED"]=0
	end
		GLOCK_Config["VCHAT1"]=">"
		GLOCK_Config["VCHAT2"]=">"
		GLOCK_Config["VCHAT3"]=">"
		GLOCK_Config["VCHAT4"]=">"

	if GLOCK_Config["UISCALE"]==nil then GLOCK_Config["UISCALE"]=1 end

	GLOCK_frame:SetScale(GLOCK_Config["UISCALE"])
	GLOCK_scaleSlider:SetValue(GLOCK_Config["UISCALE"]*100)
	GLOCK_scaleSlider:SetScript("OnValueChanged",GLSliderAction)

	if GLOCK_Config["LOCKED"]==1 then GLOCK_frame:SetScript("OnMouseDown",nil) GLOCK_minimize:SetScript("OnMouseDown",nil) end

	GLOCK_config_Visible_CheckBox:SetChecked(GLOCK_Config["VISIBLE"])
	GLOCK_config_pvp_CheckBox:SetChecked(GLOCK_Config["PVP"])
	GLOCK_config_LinkOnLoad_CheckBox:SetChecked(GLOCK_Config["AUTOLINK"])
	
	GLOCK_Level_InputBox:Hide()
	GLOCK_Name_InputBox:Hide()
	GLOCK_config_SearchName_Text:Hide()
	GLOCK_config_SearchLevel_Text:Hide()
	GLOCKSearch_ScrollFrame:Hide()
	for i=1,9 do getglobal("GLOCKSearch_B"..i):Hide() end
	for i=1,9 do getglobal("GLOCKSearch_Text"..i):SetText("") end

	for i=1,5 do
		getglobal("GLOCKSEARCH_"..GLOCK_UIschools[i].."VulnT"):Hide()
		getglobal("GLOCKSEARCH_"..GLOCK_UIschools[i].."Vuln"):Hide()
		getglobal("GLOCKSEARCH_"..GLOCK_UIschools[i].."H"):Hide()
		getglobal("GLOCKSEARCH_"..GLOCK_UIschools[i].."R"):Hide()
		getglobal("GLOCKSEARCH_"..GLOCK_UIschools[i].."M"):Hide()
	end
	GLOCKSEARCH_Tlvl:Hide()
	GLOCKSEARCH_TName:Hide()
	GLOCKSEARCH_YourHitT:Hide()
	GLOCKSEARCH_CastT:Hide()
	GLOCKSEARCH_MissT:Hide()
	GLOCKSEARCH_YourRT:Hide()
	GLOCKSEARCH_clear:Hide()

	GLOCK_Name_InputBox:SetAutoFocus(0)
	GLOCK_Level_InputBox:SetAutoFocus(0)


	this:RegisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE");
	this:RegisterEvent("UNIT_INVENTORY_CHANGED");
	this:RegisterEvent("UNIT_AURA");
	this:RegisterEvent("UNIT_AURASTATE");
	this:RegisterEvent("PLAYER_TARGET_CHANGED");
	this:RegisterEvent("CHAT_MSG_RAID");
	this:RegisterEvent("DISPLAY_SIZE_CHANGED");
	this:RegisterEvent("UNIT_MODEL_CHANGED");
	this:RegisterEvent("PLAYER_REGEN_ENABLED");
	this:RegisterEvent("RAID_TARGET_UPDATE");
	this:RegisterEvent("CHAT_MSG_MONSTER_EMOTE");

	if GLOCK_Config["CHATCHANNEL"] and GLOCK_Config["AUTOLINK"] then gljoin(GLOCK_Config["CHATCHANNEL"]) end
	GLOCK_scanGear()
	GLOCK_version()
end

function GLOCK_round(x)

a=x-math.floor(x);
if a>=.5 then y=math.ceil(x) else y=math.floor(x) end
return y

end



--------------------------------------------------------------------------------------------------------
-------------------------------Resist Calculation-------------------------------------------------------
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------------------------
--This is the main function that handles resist calculation for your damage data
-----------------------------------------------------------------------------------------------------------
function GLOCK_ResistCalc()

	if UnitName("Target")==GLDTO or UnitName("Target")==GLDTW or UnitName("Target")==GLChromaggus then GBWLSpotVuln() end

--Correct for rounding error
	if (gmitigated>10 and gmitigated<=35) then gmitigated=25 end
	if (gmitigated>35 and gmitigated<=60) then gmitigated=50 end
	if (gmitigated>60 and gmitigated<=85) then gmitigated=75 end

	GLNewData=(gmitigated)/100;
	GLNewColor=GLOCK_cast_school;
	GLGraphicsFlag=1;

	for i=1,84 do GLData1[i]=GLData1[i+1] GLData2[i]=GLData2[i+1] end
	GLData1[85]=GLNewData;
	if GLNewColor==GLOCK_schools[1] then GLData2[85]=2 end
	if GLNewColor==GLOCK_schools[2] then GLData2[85]=4 end
	if GLNewColor==GLOCK_schools[3] then GLData2[85]=3 end
	if GLNewColor==GLOCK_schools[4] then GLData2[85]=5 end
	if GLNewColor==GLOCK_schools[5] then GLData2[85]=1 end
	
	if not MobResistDB[GLOCK_dbindex] then MobResistDB[GLOCK_dbindex]="0/0_0A0|0"; end

--EXTRACT DATABASE ENTRY
	a=MobResistDB[GLOCK_dbindex];
	GLOCK_temp1=string.find(a,"/");
	GLOCK_temp2=string.find(a,"_");
	GLOCK_temp3=string.find(a,"A");
	GLOCK_temp4=string.find(a,"|");

	GLOCK_DBMiti=tonumber(string.sub(a,1,GLOCK_temp1-1));				--Current Resist Approximation
	GLOCK_DBHits=tonumber(string.sub(a,GLOCK_temp1+1,GLOCK_temp2-1))		--#of spells that have hit
	GLOCK_DBMiss=tonumber(string.sub(a,GLOCK_temp2+1,GLOCK_temp3-1))		--#of 100% resists
	GLOCK_DBMinR=tonumber(string.sub(a,GLOCK_temp3+1,GLOCK_temp4-1))		--Minimum spell penetration that a partial resist has been observed at
	GLOCK_DBi=tonumber(string.sub(a,GLOCK_temp4+1))					--Hit number for first partial resist to start learning

--------------------------------------------------------RESIST CALCULATION STARTS HERE------------------------------------------------
	
--IF SPELL TOTALLY RESISTED
	if gmitigated==100 then 
		--MISS INCREMENT and track average penetration value
		
		GLOCK_DBMiss=GLOCK_DBMiss+1;
		if GLOCK_cast_school==GLOCK_schools[1] then GLOCK_temp1=GLElemPrec*2 else GLOCK_temp1=0 end
		GLOCK_DBi=(GLOCK_DBi*(GLOCK_DBHits+GLOCK_DBMiss-1)+(GLhit-GLOCK_temp1))/(GLOCK_DBHits+GLOCK_DBMiss)


		if (GLOCK_cast_school==GLOCK_schools[3]) then    --100% resists are only relevant in frost calculations currently
			GLHITS=GLOCK_DBMiss+GLOCK_DBHits;
			GLOCK_DBMiti=100-((100-GLOCK_DBMiti)*(GLHITS-1)+(0-gpenetration)/GLOCK_levelMiss(GLOCK_Target_Level))/GLHITS
			GLOCK_DBMinR=GLOCK_DBMinR-(GLOCK_DBMinR-gpenetration*4)*GLOCK_factor
		end

		MobResistDB[GLOCK_dbindex]=string.format("%f/%f_%fA%f|%f",GLOCK_DBMiti,GLOCK_DBHits,GLOCK_DBMiss,GLOCK_DBMinR,GLOCK_DBi);
		if (GLOCK_Config["CHATCHANNEL"]) then
			if GLOCK_cast_school==GLOCK_schools[1] then GLOCK_temp1=GLElemPrec*2 else GLOCK_temp1=0 end
			SendChatMessage("<GLOCK3>"..GLOCK_dbindex..",,"..tostring(100).."++"..gpenetration.."=="..(0).."__"..(GLhit-GLOCK_temp1),"CHANNEL",nil,GetChannelName(GLOCK_Config["CHATCHANNEL"]))
		end

		GLOCK_UpdateGUI()
		return; 
	end

	


--Hit increment
	GLOCK_DBHits=GLOCK_DBHits+1;

	


--GLOCK_factor adapts as you get closer to the target (i.e. more samples available)
	if (GLOCK_DBHits)>GLCUSPS[1] then GLOCK_factor=GLFACTORS[1] end
	if (GLOCK_DBHits)>GLCUSPS[2] then GLOCK_factor=GLFACTORS[2] end
	if (GLOCK_DBHits)>GLCUSPS[3] then GLOCK_factor=GLFACTORS[3] end
	if (GLOCK_DBHits)>GLCUSPS[4] then GLOCK_factor=GLFACTORS[4] end
	if (GLOCK_DBHits)>GLCUSPS[5] then GLOCK_factor=GLFACTORS[5] end
	if (GLOCK_DBHits)>GLCUSPS[6] then GLOCK_factor=GLFACTORS[6] end
	if (GLOCK_DBHits)>GLCUSPS[7] then GLOCK_factor=GLFACTORS[7] end
	if (GLOCK_DBHits)>GLCUSPS[8] then GLOCK_factor=GLFACTORS[8] end
	
--Track Average +hit% on this mob for this school (ignore elemental precision if school is arcane)
	if GLOCK_cast_school==GLOCK_schools[1] then GLOCK_temp1=GLElemPrec*2 else GLOCK_temp1=0 end
	GLOCK_DBi=(GLOCK_DBi*(GLOCK_DBHits+GLOCK_DBMiss-1)+(GLhit-GLOCK_temp1))/(GLOCK_DBHits+GLOCK_DBMiss)
--Track Average penetration on this mob for this school
	GLOCK_DBMinR=GLOCK_DBMinR-(GLOCK_DBMinR-gpenetration*4)*GLOCK_factor

--CALCULATE THE NEW RESIST VALUE
	if GLOCK_cast_school~=GLOCK_schools[3] then
		GLOCK_diff=(gmitigated+gpenetration-GLOCK_DBMiti)*GLOCK_factor;
		GLOCK_DBMiti=GLOCK_DBMiti + GLOCK_diff;
	end

--SPECIFIC CALCULATION FOR BINARY FROST SPELLS (this also works with partially resisted frost spells such as frost wand damage)
	if GLOCK_cast_school==GLOCK_schools[3] then
		GLHITS=GLOCK_DBMiss+GLOCK_DBHits;
		GLOCK_DBMiti=100-((100-GLOCK_DBMiti)*(GLHITS-1)+(100-gmitigated-gpenetration)/GLOCK_levelMiss(GLOCK_Target_Level))/GLHITS
	end

--------------------------------------------------------RESIST CALCULATION ENDS HERE------------------------------------------------

--STORE DATA
	MobResistDB[GLOCK_dbindex]=string.format("%f/%f_%fA%f|%f",GLOCK_DBMiti,GLOCK_DBHits,GLOCK_DBMiss,GLOCK_DBMinR,GLOCK_DBi);

	
	if GLOCK_Config["CHATCHANNEL"] then
		if GLOCK_cast_school==GLOCK_schools[1] then GLOCK_temp1=GLElemPrec*2 else GLOCK_temp1=0 end
		SendChatMessage("<GLOCK3>"..GLOCK_dbindex..",,"..gmitigated.."++"..gpenetration.."=="..(0).."__"..(GLhit-GLOCK_temp1),"CHANNEL",nil,GetChannelName(GLOCK_Config["CHATCHANNEL"]))
	end

	GLOCK_UpdateGUI()
	

end


-----------------------------------------------------------------------------------------------------------
--Determines your hit chance on the target.  As per Tseric's post and assuming 99% max hit chance
-----------------------------------------------------------------------------------------------------------
function GLOCK_levelMiss(GLEVEL)

	TempMiss=99;
	if GLEVEL==UnitLevel("Player") then TempMiss=96;
	elseif GLEVEL==(UnitLevel("Player")+1) then TempMiss=95;
	elseif GLEVEL==(UnitLevel("Player")+2) then TempMiss=94; 
	elseif GLEVEL==(UnitLevel("Player")+3) then TempMiss=83;
	elseif GLEVEL==(UnitLevel("Player")+4) then TempMiss=72;
	elseif GLEVEL==(-1) then TempMiss=83;   --Made the assumption that bosses will be equated to level 63 mobs
	end

	TempMiss=TempMiss+GLhit;
	if TempMiss>99 then TempMiss=99 end

	--base resist value is 1%
	return TempMiss/100

end



function GLOCK_ClearEntry()

	tempStr=GLOCK_CONFTXT:GetText();
	GLOCK_temp1=string.find(tempStr,"-")
	GLOCK_temp2=string.sub(tempStr,1,GLOCK_temp1-2)
	GLOCK_temp3=string.sub(tempStr,GLOCK_temp1+2)

	for i=1,5 do
		if getglobal("GLOCK_confirm_"..GLOCK_UIschools[i]):GetChecked() then
			GLOCK_dbindex=GLOCK_temp3.."/"..GLOCK_temp2.."/"..GLOCK_schools[i]
			MobResistDB[GLOCK_dbindex]=nil
			MobResistDB[GLOCK_dbindex.."immune"]=nil
			MobResistDB[GLOCK_dbindex.."vuln"]=nil
			getglobal("GLOCK_confirm_"..GLOCK_UIschools[i]):SetChecked(1)
		end
	end

	GLOCK_UpdateGUI()
	GLOCK_confirm:Hide()

end


----------------------------------------------------------------
--This function determines the school of magic on a total resist (it doesn't explicity say "for x fire damage", for example)
function GLOCK_DecipherSchool(a)

	GLOCK_cast_school=nil;

	for i=1,table.getn(GLOCK_Fire) do if string.find(a,GLOCK_Fire[i]) then GLOCK_cast_school=GLOCK_schools[2]; end end
	for i=1,table.getn(GLOCK_Shadow) do if string.find(a,GLOCK_Shadow[i]) then GLOCK_cast_school=GLOCK_schools[5]; end end
	for i=1,table.getn(GLOCK_Arcane) do if string.find(a,GLOCK_Arcane[i]) then GLOCK_cast_school=GLOCK_schools[1]; end end
	for i=1,table.getn(GLOCK_Nature) do if string.find(a,GLOCK_Nature[i]) then GLOCK_cast_school=GLOCK_schools[4]; end end
	for i=1,table.getn(GLOCK_Frost) do if string.find(a,GLOCK_Frost[i]) then GLOCK_cast_school=GLOCK_schools[3]; end end

--DETECT WAND SCHOOL
	if string.find(a,GLWANDACTION) then

		--Wand slot is 18
		GLTooltip:SetInventoryItem("Player", 18);
		itemName = GLTooltipTextLeft1:GetText();
		lines = GLTooltip:NumLines();		
			for i=2, lines do
				tmpText = getglobal("GLTooltipTextLeft"..i);
				tmpStr=tmpText:GetText()
				if (tmpStr) then
					if string.find(tmpStr,GL_WAND_TEXT[1]) then GLOCK_cast_school=GLOCK_schools[1]; end
					if string.find(tmpStr,GL_WAND_TEXT[2]) then GLOCK_cast_school=GLOCK_schools[2]; end
					if string.find(tmpStr,GL_WAND_TEXT[3]) then GLOCK_cast_school=GLOCK_schools[3]; end
					if string.find(tmpStr,GL_WAND_TEXT[4]) then GLOCK_cast_school=GLOCK_schools[4]; end
					if string.find(tmpStr,GL_WAND_TEXT[5]) then GLOCK_cast_school=GLOCK_schools[5]; end
				end
					
			end
	end
	
end



--------------------------------------------------------------------------------------------------------
-------------------------------CHAT HANDLING------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
function gljoin(GChanName)
	--CONNECT TO THE DEFAULT CHANNEL
	if (GLOCK_Config["CHATCHANNEL"]~=GChanName and GLOCK_Config["CHATCHANNEL"]~=nil) then LeaveChannelByName(GLOCK_Config["CHATCHANNEL"]); DEFAULT_CHAT_FRAME:AddMessage("<GLOCK> Left: "..GLOCK_Config["CHATCHANNEL"])end
	GLOCK_Config["CHATCHANNEL"]=GChanName
	GLOCK_Config["CHATCHANNEL"]=string.gsub(GLOCK_Config["CHATCHANNEL"]," ","")
	JoinChannelByName(GLOCK_Config["CHATCHANNEL"]);
	DEFAULT_CHAT_FRAME:AddMessage("<GLOCK> Joined Link Channel: "..GLOCK_Config["CHATCHANNEL"])
	GLTooltip:RegisterEvent("CHAT_MSG_CHANNEL");	
end

function GLOCK_syncChanRaid()
	if string.find(arg1,"<CTMod>") and string.find(arg1,"Channel changed to:") and GLOCK_Config["AUTOLINK"]==1 then
		GLOCK_temp1=string.find(arg1,"to:");
		gljoin(string.sub(arg1,GLOCK_temp1+4))
	end
end


-----------------------------------------------------------------------------------------------------------
--Catch Chat events in the GLOCK link channel and parse out the data for calculation
-----------------------------------------------------------------------------------------------------------
function GLOCK_chatHandle()
	if not string.find(arg4,GLOCK_Config["CHATCHANNEL"]) then return end

	if arg2==UnitName("Player") then return end
	if string.find(arg1,"<GLOCKBWL>") then GBWLChatCatch(arg1) return end
	if not string.find(arg1,"<GLOCK3>") then return end



--Set Indicators Green	
	GMaxActivity:SetVertexColor(0,1,0);
	GMinActivity:SetVertexColor(0,1,0);

	tmpStr=string.gsub(arg1,"<GLOCK3>","");
	
	--Parse it
	GLOCK_temp1=string.find(tmpStr,",,")
	GLOCK_temp2=string.find(tmpStr,"++")
	GLOCK_temp3=string.find(tmpStr,"==")
	GLOCK_temp4=string.find(tmpStr,"__")
	if (GLOCK_temp1==nil or GLOCK_temp2==nil or GLOCK_temp3==nil or GLOCK_temp4==nil) then return end
	

	GLOCK_sync_dbindex=string.sub(tmpStr,1,GLOCK_temp1-1);

	Ga=string.find(tmpStr,"/");
	Gb=string.find(tmpStr,"/",Ga+1);
	Gc=string.find(tmpStr,"/",Gb+1);

	GLOCK_sync_Name=string.sub(tmpStr,1,Ga-1);
	GLOCK_sync_Level=tonumber(string.sub(tmpStr,Ga+1,Gb-1))
	GLOCK_sync_school=string.sub(tmpStr,Gb+1,GLOCK_temp1-1)


	GLOCK_sync_gmitigated=tonumber(string.sub(tmpStr,GLOCK_temp1+2,GLOCK_temp2-1))
	GLOCK_sync_gpenetration=tonumber(string.sub(tmpStr,GLOCK_temp2+2,GLOCK_temp3-1))
	GLOCK_sync_DBi=tonumber(string.sub(tmpStr,GLOCK_temp3+2,GLOCK_temp4-1))
	GLOCK_sync_GLhit=tonumber(string.sub(tmpStr,GLOCK_temp4+2))

	--There is some uncaught message that gets parsed wrong and I think it has to do with the mob being immune temporarily or something.. Not sure.
	--For now, just drop out if the data was bad
	if GLOCK_sync_gmitigated==nil then 
		if UnitName("Player")=="Ogdin" then DEFAULT_CHAT_FRAME:AddMessage(arg1) end
	return end

--VERBOSE CHAT IN CONFIG PANNEL
		GLOCK_Config["VCHAT1"]=GLOCK_Config["VCHAT2"]
		GLOCK_Config["VCHAT2"]=GLOCK_Config["VCHAT3"]
		GLOCK_Config["VCHAT3"]=GLOCK_Config["VCHAT4"]
		--GLSpecial=string.find(date()," ")+1
		GLOCK_Config["VCHAT4"]=string.sub(date(),string.find(date()," ")+1)..">  "..arg2.." - "..GLOCK_sync_Name.." - "..GLOCK_sync_school.." - "..GLOCK_sync_gmitigated.."%".." @ -"..(GLOCK_sync_gpenetration*4).." pene, "..GLOCK_sync_GLhit.."% Hit"
	
		GLOCKVCHAT_Text1:SetText(GLOCK_Config["VCHAT1"])	
		GLOCKVCHAT_Text2:SetText(GLOCK_Config["VCHAT2"])
		GLOCKVCHAT_Text3:SetText(GLOCK_Config["VCHAT3"])
		GLOCKVCHAT_Text4:SetText(GLOCK_Config["VCHAT4"])


	if (GLOCK_Config["PVP"]==0 and string.find(GLOCK_sync_Name,"*")) then return end
	--Do Damage calculations
	GLOCK_ChatDmgParse()
	
	
end



-----------------------------------------------------------------------
--Resistance Calculation for data coming over the chat channel
function GLOCK_ChatDmgParse()

		if not GLOCK_sync_dbindex then return end
		if not GLOCK_sync_gmitigated then return end
	
		if not MobResistDB[GLOCK_sync_dbindex] then MobResistDB[GLOCK_sync_dbindex]="0/0_0A0|0"; end

		a=MobResistDB[GLOCK_sync_dbindex];
		GLOCK_temp1=string.find(a,"/");
		GLOCK_temp2=string.find(a,"_");
		GLOCK_temp3=string.find(a,"A");
		GLOCK_temp4=string.find(a,"|");
		
		GLOCK_DBMiti=tonumber(string.sub(a,1,GLOCK_temp1-1));				--Current Approximation
		GLOCK_DBHits=tonumber(string.sub(a,GLOCK_temp1+1,GLOCK_temp2-1))		--#of spells that have hit
		GLOCK_DBMiss=tonumber(string.sub(a,GLOCK_temp2+1,GLOCK_temp3-1))		--#of 100% resists
		GLOCK_DBMinR=tonumber(string.sub(a,GLOCK_temp3+1,GLOCK_temp4-1))		--Minimum spell penetration that a partial resist has been observed at
		GLOCK_DBi=tonumber(string.sub(a,GLOCK_temp4+1))					--Hit number for first partial resist to start learning

	if GLOCK_sync_gmitigated==100 then 
		--Average Penetration, Average Hit%, Miss increment
		GLOCK_DBMiss=GLOCK_DBMiss+1;
		GLOCK_DBi=(GLOCK_DBi*(GLOCK_DBHits+GLOCK_DBMiss-1)+(GLOCK_sync_GLhit))/(GLOCK_DBHits+GLOCK_DBMiss)

		if GLOCK_sync_school==GLOCK_schools[3] then
			GLHITS=GLOCK_DBMiss+GLOCK_DBHits;
			GLOCK_temp1=GLhit;
			GLhit=GLOCK_sync_GLhit;
			GLOCK_DBMiti=100-((100-GLOCK_DBMiti)*(GLHITS-1)+(0-GLOCK_sync_gpenetration)/GLOCK_levelMiss(GLOCK_sync_Level))/GLHITS
			GLhit=GLOCK_temp1;
			GLOCK_DBMinR=GLOCK_DBMinR-(GLOCK_DBMinR-GLOCK_sync_gpenetration*4)*GLOCK_factor
		end

		MobResistDB[GLOCK_sync_dbindex]=string.format("%f/%f_%fA%f|%f",GLOCK_DBMiti,GLOCK_DBHits,GLOCK_DBMiss,GLOCK_DBMinR,GLOCK_DBi);
		if GLOCK_Target_Name==GLOCK_sync_Name then GLOCK_UpdateGUI() end;

		return
	end
	
	if GLOCK_sync_gpenetration==nil then return end

--Average Penetration, Average Hit%, Hit increment
	GLOCK_DBHits=GLOCK_DBHits+1;


--GLOCK_factor adapts as you get closer to the target (i.e. more samples available)
	if (GLOCK_DBHits)>GLCUSPS[1] then GLOCK_factor=GLFACTORS[1] end
	if (GLOCK_DBHits)>GLCUSPS[2] then GLOCK_factor=GLFACTORS[2] end
	if (GLOCK_DBHits)>GLCUSPS[3] then GLOCK_factor=GLFACTORS[3] end
	if (GLOCK_DBHits)>GLCUSPS[4] then GLOCK_factor=GLFACTORS[4] end
	if (GLOCK_DBHits)>GLCUSPS[5] then GLOCK_factor=GLFACTORS[5] end
	if (GLOCK_DBHits)>GLCUSPS[6] then GLOCK_factor=GLFACTORS[6] end
	if (GLOCK_DBHits)>GLCUSPS[7] then GLOCK_factor=GLFACTORS[7] end
	if (GLOCK_DBHits)>GLCUSPS[8] then GLOCK_factor=GLFACTORS[8] end

	GLOCK_DBi=(GLOCK_DBi*(GLOCK_DBHits+GLOCK_DBMiss-1)+(GLOCK_sync_GLhit))/(GLOCK_DBHits+GLOCK_DBMiss)
	GLOCK_DBMinR=GLOCK_DBMinR-(GLOCK_DBMinR-GLOCK_sync_gpenetration*4)*GLOCK_factor
	
--CALCULATE THE NEW RESIST VALUE
	if GLOCK_sync_school~=GLOCK_schools[3] then
		GLOCK_diff=(GLOCK_sync_gmitigated+GLOCK_sync_gpenetration-GLOCK_DBMiti)*GLOCK_factor;
		GLOCK_DBMiti=GLOCK_DBMiti + GLOCK_diff;
	end

--SPECIFIC CALCULATION FOR BINARY FROST SPELLS
	if GLOCK_sync_school==GLOCK_schools[3] then
		GLHITS=GLOCK_DBMiss+GLOCK_DBHits;
		GLOCK_temp1=GLhit;
		GLhit=GLOCK_sync_GLhit;
		GLOCK_DBMiti=100-((100-GLOCK_DBMiti)*(GLHITS-1)+(100-GLOCK_sync_gmitigated-GLOCK_sync_gpenetration)/GLOCK_levelMiss(GLOCK_sync_Level))/GLHITS
		GLhit=GLOCK_temp1;
	end

--STORE DATA
	MobResistDB[GLOCK_sync_dbindex]=string.format("%f/%f_%fA%f|%f",GLOCK_DBMiti,GLOCK_DBHits,GLOCK_DBMiss,GLOCK_DBMinR,GLOCK_DBi);

--UPDATE GUI
	GLOCK_sync_Name=gsub(GLOCK_sync_Name,"*","")
	if UnitName("Target")==GLOCK_sync_Name then GLOCK_UpdateGUI() end;
	
	

end


--------------------------------------------------------------------------------------------------------
-------------------------------DATABASE SEARCH----------------------------------------------------------
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------------
function GLOCK_DBSearch()

	GLOCKSEARCH_continue:Show()

	for i=1,5 do
		getglobal("GLOCKSEARCH_"..GLOCK_UIschools[i].."VulnT"):Hide()
		getglobal("GLOCKSEARCH_"..GLOCK_UIschools[i].."Vuln"):Hide()
		getglobal("GLOCKSEARCH_"..GLOCK_UIschools[i].."H"):Hide()
		getglobal("GLOCKSEARCH_"..GLOCK_UIschools[i].."R"):Hide()
		getglobal("GLOCKSEARCH_"..GLOCK_UIschools[i].."M"):Hide()
	end
	GLOCKSEARCH_Tlvl:Hide()
	GLOCKSEARCH_TName:Hide()
	GLOCKSEARCH_YourHitT:Hide()
	GLOCKSEARCH_CastT:Hide()
	GLOCKSEARCH_MissT:Hide()
	GLOCKSEARCH_YourRT:Hide()
	GLOCKSEARCH_clear:Hide()

jj=1
a=GLOCK_Name_InputBox:GetText()
b=GLOCK_Level_InputBox:GetText()
GLOCK_SearchTemp={}
currentDBindex=0;
	for index,value in pairs(MobResistDB) do
		currentDBindex=currentDBindex+1;

		GLOCK_temp1=string.find(index,"/");
		GLOCK_tmpStr="";
		if GLOCK_temp1 then
			GLOCK_temp2=string.find(index,"/",GLOCK_temp1+1)
			GLOCK_temp3=string.sub(index,1,GLOCK_temp1-1)
			GLOCK_tmpStr=string.sub(index,1,GLOCK_temp2-1)
		end
		if currentDBindex>=GLSinitIndex and (string.find(string.lower(GLOCK_tmpStr),string.lower(a)) and string.find(string.lower(GLOCK_tmpStr),string.lower(b))) then 
			GLOCK_temp1=string.find(index,"/");
			if GLOCK_temp1 then
				GLOCK_temp2=string.find(index,"/",GLOCK_temp1+1)

				GLOCK_temp3=string.sub(index,1,GLOCK_temp1-1)
				GLOCK_temp4=tonumber(string.sub(index,GLOCK_temp1+1,GLOCK_temp2-1))
				if GLOCK_temp4==-1 then GLOCK_temp4="Boss" end
					
				if jj>9 then GLSinitIndex=currentDBindex return end

				GLOCK_temp1=0;
				for indexi, valuei in ipairs(GLOCK_SearchTemp) do if string.sub(index,1,GLOCK_temp2-1)==valuei then GLOCK_temp1=1; end end
				
				if GLOCK_temp1==0 then
					getglobal("GLOCKSearch_B"..jj):Show()
					getglobal("GLOCKSearch_Text"..jj):SetText(GLOCK_temp4.." - "..GLOCK_temp3)
					GLOCK_SearchTemp[jj]=string.sub(index,1,GLOCK_temp2-1)
					jj=jj+1
				end
			end
		 end
		
	end
	if jj<=9 then for i=jj,9 do getglobal("GLOCKSearch_Text"..i):SetText("") getglobal("GLOCKSearch_B"..i):Hide() end GLOCKSEARCH_continue:Hide() end

	if jj==2 then GLOCKSEARCH_continue:Hide() GLOCK_DBSearchDisplay(1) end

end



--------------------------------------------------------------------------------------------
function GLOCK_DBSearchDisplay(a)
	
	if currentDBindex==0 then
		GLOCK_Name_InputBox:ClearFocus()
		GLOCK_Level_InputBox:ClearFocus()
		GLOCKSEARCH_continue:Hide()
	end

	
	for i=1,9 do getglobal("GLOCKSearch_Text"..i):SetText("") getglobal("GLOCKSearch_B"..i):Hide() end
	GLOCKSEARCH_Tlvl:Show()
	GLOCKSEARCH_TName:Show()
	GLOCKSEARCH_YourHitT:Show()
	GLOCKSEARCH_CastT:Show()
	GLOCKSEARCH_MissT:Show()
	GLOCKSEARCH_YourRT:Show()
	GLOCKSEARCH_clear:Show()
	

		GLOCK_temp1=string.find(GLOCK_SearchTemp[a],"/");
		GLOCK_S_Name=string.sub(GLOCK_SearchTemp[a],1,GLOCK_temp1-1)
		GLOCK_S_Level=tonumber(string.sub(GLOCK_SearchTemp[a],GLOCK_temp1+1))

	jj=0;

	for i=1,5 do
		GLOCK_dbindex=GLOCK_S_Name.."/"..GLOCK_S_Level.."/"..GLOCK_schools[i]
		getglobal("GLOCKSEARCH_"..GLOCK_UIschools[i].."VulnT"):Hide()
		getglobal("GLOCKSEARCH_"..GLOCK_UIschools[i].."Vuln"):Hide()
		getglobal("GLOCKSEARCH_"..GLOCK_UIschools[i].."H"):Hide()
		getglobal("GLOCKSEARCH_"..GLOCK_UIschools[i].."R"):Hide()
		getglobal("GLOCKSEARCH_"..GLOCK_UIschools[i].."M"):Hide()


		if MobResistDB[GLOCK_dbindex]~=nil and (not (MobResistDB[GLOCK_dbindex.."immune"]==1 or MobResistDB[GLOCK_dbindex.."vuln"]==1)) then 
			a=MobResistDB[GLOCK_dbindex];
			GLOCK_temp1=string.find(a,"/");
			GLOCK_temp2=string.find(a,"_");
			GLOCK_temp3=string.find(a,"A");
			GLOCK_temp4=string.find(a,"|");
			
			GLOCK_DBMiti=tonumber(string.sub(a,1,GLOCK_temp1-1));			
			GLOCK_DBHits=tonumber(string.sub(a,GLOCK_temp1+1,GLOCK_temp2-1))
			GLOCK_DBMiss=tonumber(string.sub(a,GLOCK_temp2+1,GLOCK_temp3-1))	
			GLOCK_DBMinR=tonumber(string.sub(a,GLOCK_temp3+1,GLOCK_temp4-1))	
			GLOCK_DBi=tonumber(string.sub(a,GLOCK_temp4+1))				
			if GLOCK_DBMiti<0 then GLOCK_DBMiti=0 end
			
		--CHECK FOR ERRORS
			if GLOCK_DBMiti==nil then GLOCK_DBMiti=0; MobResistDB[GLOCK_dbindex]=nil; return end
			if GLOCK_DBHits==nil then GLOCK_DBHits=0; MobResistDB[GLOCK_dbindex]=nil; return end
			if GLOCK_DBMiss==nil then GLOCK_DBMiss=0; MobResistDB[GLOCK_dbindex]=nil; return end
			
		--Update Resist Approximations
			GTxT=tostring(GLOCK_round(4*GLOCK_DBMiti));
			getglobal("GLOCKSEARCH_"..GLOCK_UIschools[i].."R"):SetText(GTxT)
			
		--Display #Casts
			getglobal("GLOCKSEARCH_"..GLOCK_UIschools[i].."H"):SetText(GLOCK_round(GLOCK_DBHits+GLOCK_DBMiss))

		--Display %Hit (avg +hit%)  (i.e. 86(3)% )
			GTxT=string.format("%.0f(%.0f)",GLOCK_round(100*GLOCK_DBHits/(GLOCK_DBMiss+GLOCK_DBHits)),GLOCK_DBi)
			getglobal("GLOCKSEARCH_"..GLOCK_UIschools[i].."M"):SetText(GTxT)

		--Display Current Penetration (avg Penetration) (i.e. 75(60) )
			GTxT=string.format("(%.0f)",GLOCK_round(GLOCK_DBMinR))
			getglobal("GLOCKSEARCH_"..GLOCK_UIschools[i].."Vuln"):SetText(GTxT)
			jj=jj+1;


		elseif (MobResistDB[GLOCK_dbindex.."immune"]==1 or MobResistDB[GLOCK_dbindex.."vuln"]==1) then 
			if MobResistDB[GLOCK_dbindex.."immune"]==1 then GLSpecial="Imm" end
			if MobResistDB[GLOCK_dbindex.."vuln"]==1 then GLSpecial="Vul" end
			getglobal("GLOCKSEARCH_"..GLOCK_UIschools[i].."R"):SetText(GLSpecial) 
			getglobal("GLOCKSEARCH_"..GLOCK_UIschools[i].."H"):SetText("0")
			getglobal("GLOCKSEARCH_"..GLOCK_UIschools[i].."M"):SetText("0")

			jj=jj+1;

		else

		end

		if MobResistDB[GLOCK_dbindex] or MobResistDB[GLOCK_dbindex.."immune"] or MobResistDB[GLOCK_dbindex.."vuln"] then
			getglobal("GLOCKSEARCH_"..GLOCK_UIschools[i].."VulnT"):Show()
			getglobal("GLOCKSEARCH_"..GLOCK_UIschools[i].."Vuln"):Show()
			getglobal("GLOCKSEARCH_"..GLOCK_UIschools[i].."H"):Show()
			getglobal("GLOCKSEARCH_"..GLOCK_UIschools[i].."R"):Show()
			getglobal("GLOCKSEARCH_"..GLOCK_UIschools[i].."M"):Show()

			getglobal("GLOCKSEARCH_"..GLOCK_UIschools[i].."VulnT"):SetPoint("TOPLEFT",5,-45-10*(jj-1));
			getglobal("GLOCKSEARCH_"..GLOCK_UIschools[i].."Vuln"):SetPoint("TOPLEFT",25,-45-10*(jj-1));
			getglobal("GLOCKSEARCH_"..GLOCK_UIschools[i].."H"):SetPoint("TOPLEFT",70,-45-10*(jj-1));
			getglobal("GLOCKSEARCH_"..GLOCK_UIschools[i].."M"):SetPoint("TOPLEFT",120,-45-10*(jj-1));
			getglobal("GLOCKSEARCH_"..GLOCK_UIschools[i].."R"):SetPoint("TOPLEFT",180,-45-10*(jj-1));
		end
	end

		GLOCKSEARCH_Tlvl:SetText(GLOCK_S_Level)
		GLOCKSEARCH_TName:SetText(GLOCK_S_Name)

		if GLOCK_S_Level>=0 then GLOCKSEARCH_Tlvl:SetTextColor(.5,.5,.5) end
		if GLOCK_S_Level>=48 then GLOCKSEARCH_Tlvl:SetTextColor(.2,.9,.2) end
		if (GLOCK_S_Level>=58 and GLOCK_Target_Level<=62) then GLOCKSEARCH_Tlvl:SetTextColor(1,1,0) end
		if (GLOCK_S_Level==63) then GLOCKSEARCH_Tlvl:SetTextColor(.9,.5,.4) end
		if (GLOCK_S_Level>63) then GLOCKSEARCH_Tlvl:SetTextColor(1,.2,.2) end
		if (GLOCK_S_Level==-1) then GLOCKSEARCH_Tlvl:SetTextColor(1,.2,.2); GLOCKSEARCH_Tlvl:SetText("Boss") end


end

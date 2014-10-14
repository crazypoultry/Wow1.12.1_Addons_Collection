--[[
  ****************************************************************
	GLOCK Nightfall - Combat Data for the Nightfall Axe Proc
		
	Written by Ogdin - Contact Via Curse-gaming forums

	--Track Damage dealt by all magical sources while nightfall proc is active
	--If Shaman, track flurry active time and personal physical damage output
	--Track time in melee range that Spell Vulnerability is up relative to not up

	--Click on school icons to switch between graphical and text modes


	****************************************************************]]


function GLOCKNF_Init()

	GLNFTitle:SetFont(GLNFTitle:GetFont(),8)
	GLNFTotalt:SetFont(GLNFTitle:GetFont(),8)
	GLNFTimet:SetFont(GLNFTitle:GetFont(),8)
	GLNFFlurryt:SetFont(GLNFTitle:GetFont(),8)
	GLNFProct:SetFont(GLNFTitle:GetFont(),8)
	GLNFReset:SetFont(GLNFTitle:GetFont(),8)

	GLNFArcaneIcon:SetTexCoord(0,1,.345,.23);
	GLNFFireIcon:SetTexCoord(0,1,.115,0);
	GLNFFrostIcon:SetTexCoord(0,1,.46,.345);
	GLNFNatureIcon:SetTexCoord(0,1,.23,.115);
	GLNFShadowIcon:SetTexCoord(0,1,.575,.46);

	GLNFShadowTotal:SetFont(GLNFTitle:GetFont(),8)
	GLNFFrostTotal:SetFont(GLNFTitle:GetFont(),8)
	GLNFFireTotal:SetFont(GLNFTitle:GetFont(),8)
	GLNFArcaneTotal:SetFont(GLNFTitle:GetFont(),8)
	GLNFNatureTotal:SetFont(GLNFTitle:GetFont(),8)
	GLNFHolyTotal:SetFont(GLNFTitle:GetFont(),8)

	GLNFShadowTotal:SetTextColor(.9,.7,.9)
	GLNFFrostTotal:SetTextColor(1,1,1)
	GLNFFireTotal:SetTextColor(.9,.5,.4)
	GLNFArcaneTotal:SetTextColor(.9,.9,.7)
	GLNFNatureTotal:SetTextColor(.4,1,.4)
	GLNFHolyTotal:SetTextColor(1,1,.4)

	GLNFLocale={}
	GLNFACTIVE=0;
	GLFLACTIVE=0;
	GLNFLocale["NFNAME"]="Spell Vulnerability"
	GLNFLocale["FLNAME"]="Flurry"
	GLNFStoreTime=GetTime();
	GLNFStoreTime2=GetTime();
	GLNFDrawStep=0;
	GLNFRun=0

	--Vars for Save: GLNFFullTotalDamage, GLNFTotalDamage, GLNFRunning, GLNFFlurry, GLNFSpellVuln
	if GLNFFullTotalDamage==nil then GLNFFullTotalDamage=0.01 end
	if GLNFTotalDamage==nil then GLNFTotalDamage={} for i=1,6 do GLNFTotalDamage[i]=0 end end
	if GLNFRunning==nil then GLNFRunning=0.01 end
	if GLNFFlurry==nil then GLNFFlurry=0 end
	if GLNFSpellVuln==nil then GLNFSpellVuln=0 end

	GLNFCurrentDamage={}
	GLNFGUIvMax={}
	for i=1,6 do GLNFCurrentDamage[i]=0; GLNFGUIvMax[i]=0.01; end
	
	
	GLNF_Shadow_Graph_Background:SetVertexColor(.2,.2,.2,1)
	GLNF_Frost_Graph_Background:SetVertexColor(.2,.2,.2,1)
	GLNF_Fire_Graph_Background:SetVertexColor(.2,.2,.2,1)
	GLNF_Arcane_Graph_Background:SetVertexColor(.2,.2,.2,1)
	GLNF_Nature_Graph_Background:SetVertexColor(.2,.2,.2,1)
	GLNF_Holy_Graph_Background:SetVertexColor(.2,.2,.2,1)

	
	--Create Graphics Bars
	GLNFShadowGUI={} GLNFShadowGUIt={}
	GLNFFrostGUI={} GLNFFrostGUIt={}
	GLNFFireGUI={} GLNFFireGUIt={}
	GLNFArcaneGUI={} GLNFArcaneGUIt={}
	GLNFNatureGUI={} GLNFNatureGUIt={}
	GLNFHolyGUI={} GLNFHolyGUIt={}
		GLNFShadowGUIv={}
		GLNFFireGUIv={}
		GLNFFrostGUIv={}
		GLNFArcaneGUIv={}
		GLNFNatureGUIv={}
		GLNFHolyGUIv={}

	for i=0,59 do
		GLNFShadowGUIv[i]=0
		GLNFFireGUIv[i]=0
		GLNFFrostGUIv[i]=0
		GLNFArcaneGUIv[i]=0
		GLNFNatureGUIv[i]=0
		GLNFHolyGUIv[i]=0
		GLNFShadowGUI[i]=CreateFrame("Frame",nil,GLNF_Shadow_Graph);
			GLNFShadowGUI[i]:SetWidth(2)
			GLNFShadowGUI[i]:SetHeight(0.01)
			GLNFShadowGUIt[i]=GLNFShadowGUI[i]:CreateTexture(nil,"BACKGROUND")
			GLNFShadowGUIt[i]:SetTexture(.9,.7,.9)
			GLNFShadowGUIt[i]:SetAllPoints(GLNFShadowGUI[i])
			GLNFShadowGUI[i]:SetPoint("BOTTOMLEFT",i*2,0)
			GLNFShadowGUI[i]:Show()
		GLNFFireGUI[i]=CreateFrame("Frame",nil,GLNF_Fire_Graph);
			GLNFFireGUI[i]:SetWidth(2)
			GLNFFireGUI[i]:SetHeight(0.01)
			GLNFFireGUIt[i]=GLNFFireGUI[i]:CreateTexture(nil,"BACKGROUND")
			GLNFFireGUIt[i]:SetTexture(.9,.5,.4)
			GLNFFireGUIt[i]:SetAllPoints(GLNFFireGUI[i])
			GLNFFireGUI[i]:SetPoint("BOTTOMLEFT",i*2,0)
			GLNFFireGUI[i]:Show()
		GLNFFrostGUI[i]=CreateFrame("Frame",nil,GLNF_Frost_Graph);
			GLNFFrostGUI[i]:SetWidth(2)
			GLNFFrostGUI[i]:SetHeight(0.01)
			GLNFFrostGUIt[i]=GLNFFrostGUI[i]:CreateTexture(nil,"BACKGROUND")
			GLNFFrostGUIt[i]:SetTexture(1,1,1)
			GLNFFrostGUIt[i]:SetAllPoints(GLNFFrostGUI[i])
			GLNFFrostGUI[i]:SetPoint("BOTTOMLEFT",i*2,0)
			GLNFFrostGUI[i]:Show()
		GLNFArcaneGUI[i]=CreateFrame("Frame",nil,GLNF_Arcane_Graph);
			GLNFArcaneGUI[i]:SetWidth(2)
			GLNFArcaneGUI[i]:SetHeight(0.01)
			GLNFArcaneGUIt[i]=GLNFArcaneGUI[i]:CreateTexture(nil,"BACKGROUND")
			GLNFArcaneGUIt[i]:SetTexture(.9,.9,.7)
			GLNFArcaneGUIt[i]:SetAllPoints(GLNFArcaneGUI[i])
			GLNFArcaneGUI[i]:SetPoint("BOTTOMLEFT",i*2,0)
			GLNFArcaneGUI[i]:Show()
		GLNFNatureGUI[i]=CreateFrame("Frame",nil,GLNF_Nature_Graph);
			GLNFNatureGUI[i]:SetWidth(2)
			GLNFNatureGUI[i]:SetHeight(0.01)
			GLNFNatureGUIt[i]=GLNFNatureGUI[i]:CreateTexture(nil,"BACKGROUND")
			GLNFNatureGUIt[i]:SetTexture(.4,1,.4)
			GLNFNatureGUIt[i]:SetAllPoints(GLNFNatureGUI[i])
			GLNFNatureGUI[i]:SetPoint("BOTTOMLEFT",i*2,0)
			GLNFNatureGUI[i]:Show()
		GLNFHolyGUI[i]=CreateFrame("Frame",nil,GLNF_Holy_Graph);
			GLNFHolyGUI[i]:SetWidth(2)
			GLNFHolyGUI[i]:SetHeight(0.01)
			GLNFHolyGUIt[i]=GLNFHolyGUI[i]:CreateTexture(nil,"BACKGROUND")
			GLNFHolyGUIt[i]:SetTexture(1,1,.4)
			GLNFHolyGUIt[i]:SetAllPoints(GLNFHolyGUI[i])
			GLNFHolyGUI[i]:SetPoint("BOTTOMLEFT",i*2,0)
			GLNFHolyGUI[i]:Show()
	end
	
	GLNF_Shadow_Graph:Hide()
	GLNF_Frost_Graph:Hide()
	GLNF_Fire_Graph:Hide()
	GLNF_Arcane_Graph:Hide()
	GLNF_Nature_Graph:Hide()
	GLNF_Holy_Graph:Hide()
	if GLNFGraphic==nil then GLNFGraphic={} for i=1,6 do GLNFGraphic[i]=1 end end
	if GLNFGraphic[1]==1 then GLNF_Shadow_Graph:Show() end
	if GLNFGraphic[2]==1 then GLNF_Frost_Graph:Show() end
	if GLNFGraphic[3]==1 then GLNF_Fire_Graph:Show() end
	if GLNFGraphic[4]==1 then GLNF_Arcane_Graph:Show() end
	if GLNFGraphic[5]==1 then GLNF_Nature_Graph:Show() end
	if GLNFGraphic[6]==1 then GLNF_Holy_Graph:Show() end

	GLOCKNF_UpdateText()

	-- Slash Commands
	SlashCmdList["GLNFSHOW"] = GLNF_showmain;
	SLASH_GLNFSHOW1 = "/glocknf";
	
	-- Events to Register
	this:RegisterEvent("UNIT_COMBAT")
	this:RegisterEvent("UNIT_AURA");
	this:RegisterEvent("UNIT_AURASTATE");
	this:RegisterEvent("PLAYER_TARGET_CHANGED");
	this:RegisterEvent("PLAYER_REGEN_DISABLED");
	this:RegisterEvent("PLAYER_REGEN_ENABLED");
	DEFAULT_CHAT_FRAME:AddMessage("GLOCK Nightfall Axe Statistics Loaded")
end

function GLOCKNF_OnUpdate()
	if UnitIsDead("Player") then GLNFRun=0 return end


--Check For Flurry/NF Proc twice a second (half second resolution) while in combat and in melee range
	if math.floor(GLNFStoreTime2*2)<math.floor(GetTime()*2) and GLNFRun==1 and CheckInteractDistance("Target",1) then 
		if GLFLACTIVE==1 then GLNFFlurry=GLNFFlurry+1/2 end
		if GLNFACTIVE==1 then GLNFSpellVuln=GLNFSpellVuln+1/2 end
		GLNFRunning=GLNFRunning+1/2
		GLNFStoreTime2=GetTime()
	end

--Update Graphics (every one second, take 7 frame updates to process all graphs)
	if math.floor(GLNFStoreTime)==math.floor(GetTime()) and GLNFDrawStep==0 then return end
	if GLNFRun==0 then GLNFDrawStep=0 GLNFStoreTime=GetTime() return end

	if GLNFDrawStep==0 then
		for i=1,6 do GLNFGUIvMax[i]=0.01 end  --Reset Maximum Track
		for i=0,58 do	
		--Track Max Value from Data Set
			if GLNFShadowGUIv[i+1]>GLNFGUIvMax[1] then GLNFGUIvMax[1]=GLNFShadowGUIv[i+1] end
			if GLNFFrostGUIv[i+1]>GLNFGUIvMax[2] then GLNFGUIvMax[2]=GLNFFrostGUIv[i+1] end
			if GLNFFireGUIv[i+1]>GLNFGUIvMax[3] then GLNFGUIvMax[3]=GLNFFireGUIv[i+1] end
			if GLNFArcaneGUIv[i+1]>GLNFGUIvMax[4] then GLNFGUIvMax[4]=GLNFArcaneGUIv[i+1] end
			if GLNFNatureGUIv[i+1]>GLNFGUIvMax[5] then GLNFGUIvMax[5]=GLNFNatureGUIv[i+1] end
			if GLNFHolyGUIv[i+1]>GLNFGUIvMax[6] then GLNFGUIvMax[6]=GLNFHolyGUIv[i+1] end
		--Shift All Data Left One
			GLNFShadowGUIv[i]=GLNFShadowGUIv[i+1] 
			GLNFFrostGUIv[i]=GLNFFrostGUIv[i+1]
			GLNFFireGUIv[i]=GLNFFireGUIv[i+1]
			GLNFArcaneGUIv[i]=GLNFArcaneGUIv[i+1]
			GLNFNatureGUIv[i]=GLNFNatureGUIv[i+1]
			GLNFHolyGUIv[i]=GLNFHolyGUIv[i+1]
		end
	--Add New Data Point, Check if it's larger than other points
		GLNFShadowGUIv[59]=GLNFCurrentDamage[1]
		GLNFFrostGUIv[59]=GLNFCurrentDamage[2]
		GLNFFireGUIv[59]=GLNFCurrentDamage[3]
		GLNFArcaneGUIv[59]=GLNFCurrentDamage[4]
		GLNFNatureGUIv[59]=GLNFCurrentDamage[5]
		GLNFHolyGUIv[59]=GLNFCurrentDamage[6]
		for i=1,6 do if GLNFCurrentDamage[i]>GLNFGUIvMax[i] then GLNFGUIvMax[i]=GLNFCurrentDamage[i] end end
	--Clear Current Data Accumulator
		for i=1,6 do GLNFCurrentDamage[i]=0 end
		
		GLOCKNF_UpdateText()

	elseif GLNFDrawStep==1 then
		for i=0,59 do GLNFShadowGUI[i]:SetHeight(15*GLNFShadowGUIv[i]/GLNFGUIvMax[1]+0.01) end
	elseif GLNFDrawStep==2 then
		for i=0,59 do GLNFFrostGUI[i]:SetHeight(15*GLNFFrostGUIv[i]/GLNFGUIvMax[2]+0.01) end
	elseif GLNFDrawStep==3 then
		for i=0,59 do GLNFFireGUI[i]:SetHeight(15*GLNFFireGUIv[i]/GLNFGUIvMax[3]+0.01) end
	elseif GLNFDrawStep==4 then
		for i=0,59 do GLNFArcaneGUI[i]:SetHeight(15*GLNFArcaneGUIv[i]/GLNFGUIvMax[4]+0.01) end
	elseif GLNFDrawStep==5 then
		for i=0,59 do GLNFNatureGUI[i]:SetHeight(15*GLNFNatureGUIv[i]/GLNFGUIvMax[5]+0.01) end
	elseif GLNFDrawStep==6 then
		for i=0,59 do GLNFHolyGUI[i]:SetHeight(15*GLNFHolyGUIv[i]/GLNFGUIvMax[6]+0.01) end
	end
		GLNFDrawStep=GLNFDrawStep+1

		if GLNFDrawStep==7 then GLNFDrawStep=0 GLNFStoreTime=GetTime() end
end

function GLOCKNF_UpdateText()
		--Vars for Save: GLNFFullTotalDamage, GLNFTotalDamage, GLNFRunning, GLNFFlurry, GLNFSpellVuln
		GLTemp=0; for i=1,6 do GLTemp=GLTemp+GLNFTotalDamage[i]; end
		GLNFTotalt:SetText("Total: "..math.floor(GLTemp+.5).."  ("..math.floor(100*GLTemp/GLNFFullTotalDamage+.5).."%)")

		GLNFHours=math.floor(GLNFRunning/(60*60))
		GLNFMins=math.floor((GLNFRunning-GLNFHours*60*60)/60)
		GLNFSecs=math.floor(GLNFRunning-GLNFHours*60*60-GLNFMins*60)
		GLNFTimet:SetText(string.format("Time: %02d:%02d:%02d",GLNFHours,GLNFMins,GLNFSecs))

		GLNFFlurryt:SetText("Flurry: "..math.floor(100*GLNFFlurry/GLNFRunning).."%")
		GLNFProct:SetText("NFProc: "..math.floor(100*GLNFSpellVuln/GLNFRunning).."%")

		GLNFShadowTotal:SetText(math.floor(GLNFTotalDamage[1]+.5))
		GLNFFrostTotal:SetText(math.floor(GLNFTotalDamage[2]+.5))
		GLNFFireTotal:SetText(math.floor(GLNFTotalDamage[3]+.5))
		GLNFArcaneTotal:SetText(math.floor(GLNFTotalDamage[4]+.5))
		GLNFNatureTotal:SetText(math.floor(GLNFTotalDamage[5]+.5))
		GLNFHolyTotal:SetText(math.floor(GLNFTotalDamage[6]+.5))

end

function GLNF_showmain() GLNF_frame:Show() end

function GLNF_reset()
	for i=1,6 do GLNFTotalDamage[i]=0 end
	GLNFFullTotalDamage=0.01
	GLNFRunning=0.01
	GLNFFlurry=0
	GLNFSpellVuln=0
	GLOCKNF_UpdateText()
	
	for i=0,59 do
		GLNFShadowGUIv[i]=0 
		GLNFFrostGUIv[i]=0
		GLNFFireGUIv[i]=0
		GLNFArcaneGUIv[i]=0
		GLNFNatureGUIv[i]=0
		GLNFHolyGUIv[i]=0
	end

end

----------------------
-- Event Handler
-- this function parses events
function GLOCKNF_OnEvent()
	if event=="UNIT_AURA" or event=="UNIT_AURASTATE" or event=="PLAYER_TARGET_CHANGED" then GLOCKNF_ScanDebuffs() end
	if event=="VARIABLES_LOADED" then GLOCKNF_Init() end
	if event=="UNIT_COMBAT" then GLOCKNF_Combat() end
	if event=="PLAYER_REGEN_DISABLED" then GLNFRun=1 end
	if event=="PLAYER_REGEN_ENABLED" then GLNFRun=0 end

end

function GLOCKNF_ScanDebuffs()
	GLNFACTIVE=0;
	GLFLACTIVE=0;
	for i=1,16 do
		GLNFTooltip:ClearLines();	
		GLNFTooltip:SetUnitDebuff("Target",i);
		if (GLNFTooltipTextLeft1:GetText()==GLNFLocale["NFNAME"]) then	GLNFACTIVE=1 end
	end
	for i=1,32 do
		GLNFTooltip:ClearLines();	
		GLNFTooltip:SetUnitBuff("Player",i);
		if (GLNFTooltipTextLeft1:GetText()==GLNFLocale["FLNAME"]) then	GLFLACTIVE=1 end	
	end
end

function GLOCKNF_Combat()

	if not (arg1=="target") then return end   --If the event is not on the target, return
	if arg4==nil then return end
	if CheckInteractDistance("Target",1) then GLNFFullTotalDamage=GLNFFullTotalDamage+arg4; end
	if arg5==0 then return end		--If the event is physical damage, return
	
	--arg4 is amount of damage (number)
	--arg5 is type of damage (1,2,3,4,5,6)  I think 3 is nature, 0 is physical
	--(0 - physical; 1 - holy; 2 - fire; 4 - frost; 5 - shadow; 6 - arcane)
	--Convert this number from UnitCombat into the number that I use to index my schools
	arg5=arg5+10
	if arg5==11 then arg5=6 end
	if arg5==12 then arg5=3 end
	if arg5==13 then arg5=5 end
	if arg5==14 then arg5=2 end
	if arg5==15 then arg5=1 end
	if arg5==16 then arg5=4 end

	--is nightfall on the mob?
	if GLNFACTIVE==1 then 
		GLNFTotalDamage[arg5]=GLNFTotalDamage[arg5]+arg4*(0.15/1.15); 
		GLNFCurrentDamage[arg5]=GLNFCurrentDamage[arg5]+arg4*(0.15/1.15);
		--DEFAULT_CHAT_FRAME:AddMessage(arg1.." - "..arg5.." - "..arg4)
	end
	
end


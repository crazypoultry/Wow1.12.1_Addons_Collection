UserOptions={
	["Silent_Mode"]=nil,
	["Curse_Alert"]=nil,
	["Poly_Sheep"]=nil,
	["Poly_Pig"]=nil,
	["Poly_Turtle"]=nil
}
Pst=" "
Ppt=" "
Ptt=" "
ls=nil
function Poly(arg1)
	t=UnitCreatureType("TARGET")
	n=UnitName("TARGET") 
	if n~=nil and strfind("HumanoidBeast",t)~=nil and UnitIsEnemy("TARGET","PLAYER")~=nil then 	
		S=""
		if GetNumPartyMembers() ~= 0 then S="PARTY"; end
		if UnitInRaid("PLAYER")~=nil then S="RAID"; end
                	if UserOptions.Silent_Mode=="False" then 
		Pst = ConvTxt(UserOptions.Poly_Sheep)
		Ppt = ConvTxt(UserOptions.Poly_Pig)
		Ptt = ConvTxt(UserOptions.Poly_Turtle)
		
			if arg1==1 and S~="" then SendChatMessage(Pst,S) ;end
			if arg1==2 and S~="" then SendChatMessage(Ppt,S) ;end
			if arg1==3 and S~="" then SendChatMessage(Ptt,S) ;end
		end
	end
end


function ConvTxt(tmp)
tmp = gsub(tmp,"{N}",UnitName("TARGET"))
tmp = gsub(tmp,"{L}","Lvl "..UnitLevel("Target"))	
return tmp
end


function MageEyeoptions()
MageEyeOptions:Show();
end


function FindCurse()
t=UnitName("TARGET")
L=nil
if t~=nil and UnitIsEnemy("TARGET","PLAYER")~=nil then L=1 ; end
e=nil
S=nil
if GetNumPartyMembers()~= 0 then S="PARTY"; end
if UnitInRaid("PLAYER")~=nil then S="RAID"; end
if S==nil and e==nil then 
for ci=1,16 do 
if UnitDebuff("PLAYER",ci,1)~=nil then e=UnitName("PLAYER"); break; end
end
if e~=nil then TargetByName(e);end
end

if S=="PARTY" then 
for i=1,4 do
n=UnitName(S..i)
if n~=nil then 
for ci=1,16 do 
if UnitDebuff(S..i,ci,1)~=nil then e=n; break; end
end
end
if e~=nil then break; end
if e==nil then
for ci=1,16 do 
if UnitDebuff("PLAYER",ci,1)~=nil then e=UnitName("PLAYER"); break; end
end
end	                  
end
if e~=nil then TargetByName(e); end
end

if S=="RAID" then 
for i=1,40 do
n=UnitName(S..i)
if n~=nil then 
for ci=1,16 do 
if UnitDebuff(S..i,ci,1)~=nil then e=n; break; end
end
end
if e~=nil then break; end
if e==nil then
for ci=1,16 do 
if UnitDebuff("PLAYER",ci,1)~=nil then e=UnitName("PLAYER"); break; end
end
end	                  
end	                  
if e~=nil then TargetByName(e); end
end
end

function CurseEnd()
if (SpellIsTargeting()) then SpellStopTargeting();end
if L~=nil then TargetLastEnemy(); end
end

function MageEye_OnLoad()
	SlashCmdList["MageEyeoptions"]=MageEyeoptions;
	SLASH_MageEyeoptions1="/MageEyeoptions"
	SlashCmdList["FindCurse"]=FindCurse;
	SLASH_FindCurse1="/FindCurse";
	SlashCmdList["CurseEnd"]=CurseEnd;
	SLASH_CurseEnd1="/CurseEnd";

	DEFAULT_CHAT_FRAME:AddMessage( "MageEye 1.0 Loaded", .3, .5, 1.0 ); 
	this:RegisterEvent("UNIT_AURA");
	this:RegisterEvent("SPELLCAST_START");
	this:RegisterEvent("SPELLCAST_STOP");
	this:RegisterEvent("VARIABLES_LOADED");
infotext:SetWidth(400)
infotext1:SetWidth(400)

end


function MageEye_OnEvent()
if(event == "VARIABLES_LOADED") then
	if (UserOptions.Silent_Mode == nil) then UserOptions.Silent_Mode = "False";end
	if (UserOptions.Curse_Alert == nil) then UserOptions.Curse_Alert = "False";end
                if (UserOptions.Poly_Sheep == nil) then UserOptions.Poly_Sheep = "Casting Polymorp: Sheep on {L} {N} in 1.5 sec.";end
	if (UserOptions.Poly_Pig == nil) then UserOptions.Poly_Pig = "Casting Polymorp: Pig on {L} {N} in 1.5 sec.";end
	if (UserOptions.Poly_Turtle == nil) then UserOptions.Poly_Turtle = "Casting Polymorp: Turtle on {L} {N} in 1.5 sec.";end

	Silent:SetChecked(UserOptions.Silent_Mode)
	Cursed:SetChecked(UserOptions.Curse_Alert)
	Sheep_Text:SetText(UserOptions.Poly_Sheep)
	Pig_Text:SetText(UserOptions.Poly_Pig)
	Turtle_Text:SetText(UserOptions.Poly_Turtle)
end
if(event == "UNIT_AURA" and UserOptions.Curse_Alert=="True") then
if (strfind(arg1,"player") or strfind(arg1,"party")~=nil or strfind(arg1,"raid")~=nil) then
for ci=1,16 do 
if UnitDebuff(arg1,ci,1)~=nil then PlaySound("igQuestLogAbandonQuest");UIErrorsFrame:AddMessage(UnitName(arg1).." Is Cursed!", 0.0, 1.0, 0.0, 1.0, UIERRORS_HOLD_TIME);break;end
end
end
end

if (event == "SPELLCAST_START") then
if (strfind(arg1,"Polymorph")~=nil and strfind(arg1,"Turtle")==nil and strfind(arg1,"Pig")==nil) then Poly(1);end
if (strfind(arg1,"Polymorph")~=nil and strfind(arg1,"Pig")~=nil) then Poly(2);end
if (strfind(arg1,"Polymorph")~=nil and strfind(arg1,"Turtle")~=nil) then Poly(3);end
end

end














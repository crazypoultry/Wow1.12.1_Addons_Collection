
function combustion(cmd)
		 DEFAULT_CHAT_FRAME:AddMessage("Le compteur de Combustion a ete reinitialise", 0.8, 0, 0);
		 CritNumber=3;
		 Combustion_Update(CritNumber);
end

function CombustionDetect()

CombustionTooltip:SetOwner(UIParent, "ANCHOR_NONE");
local i = 1;

while UnitBuff("player", i) do 
	CombustionTooltip:ClearLines();
	CombustionTooltip:SetUnitBuff("player",i);
		
    	if string.find(CombustionTooltipTextLeft1:GetText() or "", "Combustion") then
      		
      		--DEFAULT_CHAT_FRAME:AddMessage(CombustionTooltipTextLeft1:GetText(), 0.8, 0, 0);
      		return true
    	end;
    i = i + 1;
  end;
  
end


function Combustion_OnDragStart()
CombustionFrame:StartMoving();

end

function Combustion_OnDragStop()
CombustionFrame:StopMovingOrSizing();

end

function CombustionRestore(Crit)

if ( CombustionDetect()==true) then
CombustionFrame:Show();
end

Combustion_Update(Crit);

end

function combustion_OnLoad()

playerClass, englishClass = UnitClass("player");

if ( englishClass == "MAGE" ) then

		CritNumber = CritNumber ;
		rebon=0;
		SLASH_combustion1 = "/combustion";
		SlashCmdList["combustion"] = combustion;
		DEFAULT_CHAT_FRAME:AddMessage("£. Combustion v0.1 Charge tapez /combustion pour reinitialisé le compteur.£", 0.8, 0, 0);
		
		this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS");
		this:RegisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE");
		this:RegisterEvent("CHAT_MSG_SPELL_AURA_GONE_SELF");
		this:RegisterEvent("CHAT_MSG_SPELL_SELF_BUFF");
		this:RegisterEvent("PLAYER_LOGIN");
		SPELL_CRIT = "Votre %s inflige un coup critique à %s (%d points de dégâts).";
		this:RegisterEvent("PLAYER_DEAD");
		this:RegisterEvent("VARIABLES_LOADED");
		CombustionFrame:RegisterForDrag("LeftButton");
		CombustionFrame:Hide();
		CombustionRestore(CritNumber);
else

CombustionFrame:Hide();

end
					
end

function combustion_OnEvent(degat)

if ( englishClass == "MAGE" ) then
if ( event== "PLAYER_LOGIN")then

if ( CritNumber ~= nil ) then

CombustionRestore(CritNumber);

else

DEFAULT_CHAT_FRAME:AddMessage("£. Combustion : Premier lancement détecté,  initialisation du compteur", 0.8, 0, 0);
CritNumber = 3;

end
end

if ( event=="PLAYER_DEAD" ) then

 CombustionFrame:Hide();
 CritNumber=3;

end

if ((event == "CHAT_MSG_SPELL_SELF_BUFF" ) or ( event == "CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS" )) then
--DEFAULT_CHAT_FRAME:AddMessage("evenement : "..event..":"..degat, 0.8, 0, 0);
end

if((event == "CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS") and (CombustionDetect()==true)) then
   
 CombustionFrame:Show();
 Combustion_Update(CritNumber);
     
end

if ((event == "CHAT_MSG_SPELL_SELF_DAMAGE") and (CombustionDetect()==true) )then
if ((string.find(degat, "inflige un coup critique"))and (string.find(degat, "Feu")))then
	
 	if ( CritNumber > 0 ) then
 	
 	CritNumber = CritNumber - 1;
 	DEFAULT_CHAT_FRAME:AddMessage(CritNumber.." critique restant avant expiration de Combustion", 0.8, 0, 0);
 	Combustion_Update(CritNumber);
	
end
end
end


if ( event == "CHAT_MSG_SPELL_AURA_GONE_SELF" ) then

if (string.find(degat, "Combustion vient de se dis")) then

--if (rebond==0) then
	DEFAULT_CHAT_FRAME:AddMessage("Combustion se dissipe", 0.8, 0, 0);
	CritNumber=3;
	Combustion_Update(CritNumber);
  	CombustionFrame:Hide();
--  	rebond=1;
--else
--rebond=0
--end
  	
end
end

end
end


function Combustion_Update(affiche)
CombustionCritCount:SetText(affiche)

if ( affiche == 3 ) then 
CombustionCritCount:SetTextColor(0,1,0)
end

if ( affiche == 2 ) then 
CombustionCritCount:SetTextColor(1,1,0)
end

if ( affiche == 1 ) then 
CombustionCritCount:SetTextColor(1,0,0)
end

end


---------------------------------------------------------------------------		
-- AddOn 				:   Smilie2Emote 
-- Autor(en)		:	  Martin Holc und Marc Bach <mailto:marc@das-anch.de>
-- Copyright	  : 	(c)2005
-- Version 			:		1.4.2
-- Status				:		Alpha
---------------------------------------------------------------------------		


--EMOTE145_TOKEN="a"
--EMOTE145_TOKEN="b"
--EMOTE11_TOKEN ="c"
--EMOTE21_TOKEN ="d"
--EMOTE133_TOKEN="e"
--EMOTE170_TOKEN="f"
--EMOTE120_TOKEN="g"
--EMOTE50_TOKEN ="h"
--EMOTE145_TOKEN="i"
--
--EMOTE23_TOKEN ="a"
--EMOTE46_TOKEN ="b"
--EMOTE61_TOKEN ="c"
--EMOTE112_TOKEN="d"
--EMOTE98_TOKEN ="e"
--EMOTE164_TOKEN="f"
--EMOTE103_TOKEN="g"
--EMOTE56_TOKEN ="h"
--EMOTE111_TOKEN="i"
--EMOTE103_TOKEN="j"
--EMOTE26_TOKEN ="k"
--EMOTE3_TOKEN  ="l"
--EMOTE55_TOKEN ="m"

s2eIn_On  = true;
s2eOut_On = true;

---------------------------------------------------------------------------		
-- Listen generieren
---------------------------------------------------------------------------		
-- smilies 
			s2eListInit = {
											["^^"  ]= EMOTE145_TOKEN ,
											[":)"  ]= EMOTE145_TOKEN ,
  	 						      [";)"  ]= EMOTE11_TOKEN  ,
  	 						      [":D"  ]= EMOTE21_TOKEN  ,
  	 						      [":("  ]= EMOTE133_TOKEN ,
  	 						      [":P"  ]= EMOTE170_TOKEN ,
  	 						      [";P"  ]= EMOTE120_TOKEN ,
  	 						      [":O"  ]= EMOTE50_TOKEN  ,
  	 						      ["*g*" ]= EMOTE145_TOKEN 
  	 						}
  	 						
 	 						
-- akronyme		 
		  ac2e_ListInit = {
											["hihi"		]		= EMOTE23_TOKEN  ,
  	 						      ["haha"		]		= EMOTE46_TOKEN  ,
  	 						      ["lol" 		]		= EMOTE61_TOKEN  ,
  	 						      ["*sniff*"]  	= EMOTE112_TOKEN ,
  	 						      ["thx"		]		= EMOTE98_TOKEN  ,
  	 						      ["mom"		]		= EMOTE164_TOKEN ,
  	 						      ["gern"		]		= EMOTE103_TOKEN ,
  	 						      ["huhu"		]		= EMOTE56_TOKEN  ,
  	 						      ["*heul*"	] 	= EMOTE111_TOKEN ,
  	 						      ["np"			]		= EMOTE103_TOKEN ,
  	 						      ["gz"			]		= EMOTE26_TOKEN  ,
  	 						      ["grml"		]		= EMOTE3_TOKEN   ,
  	 						      ["*freu*"	] 	= EMOTE55_TOKEN  ,
  	 						      ["hi"			]		= EMOTE49_TOKEN
		} 


    
---------------------------------------------------------------------------		
-- Listen erzeugen. Die initialisierung, falls noch keine 
-- Custom-Emotes existieren. 
---------------------------------------------------------------------------  	
function generateLists()
  local tmp = {}
  s2eList 	= {} 
  ac2e_List = {}
  debugMsg("generating Lists\n");
  
  for k, v in pairs(s2eListInit)do 
    tmp["smilie"] = k;
    tmp["token"] = v;
    table.insert(s2eList,tmp);
    tmp = {}
  end
	
	for k, v in pairs(ac2e_ListInit) do 
	  tmp["acronym"] = k;
    tmp["token"] = v;
    table.insert(ac2e_List,tmp);
    tmp = {}
	end 
end

---------------------------------------------------------------------------		
-- bestehenden Smilie neu setzen 
---------------------------------------------------------------------------  
function alterSmilie(smilie, token)
		for i=1, getn(s2eList) do
	  if (s2eList[i].smilie == smilie) then
	  	s2eList[i].token = token;
	  	debugMsg(string.format("%s set to %s\n",smilie,token));
	  	return 
	  end
	end	
end

---------------------------------------------------------------------------		
-- Smilie existiert bereits? 
---------------------------------------------------------------------------  
function smilieExists(smilie)
		for i=1, getn(s2eList) do
	  if (s2eList[i].smilie == smilie) then
			return true;
	  end
	end	
	return false;
end

---------------------------------------------------------------------------		
-- Bestehendes Akronym ändern
---------------------------------------------------------------------------  
function alterAcronym(acronym, token)
		for i=1, getn(ac2e_List) do
	  if (ac2e_List[i].acronym == acronym) then
	  	ac2e_List[i].token = token;
	  	debugMsg(string.format("%s set to %s\n",acronym,token));
	  	return
	  end
	end	
end
---------------------------------------------------------------------------		
-- Liste der Akronyme anzeigen
--------------------------------------------------------------------------- 
function showAcronyms(which)
		local matches = 0;
		for i=1, getn(ac2e_List) do
		  if((ac2e_List[i].acronym == smilie) or (which == "all")) then
		  	matches = matches+1;
	  		debugMsg(string.format("%s set to %s\n",ac2e_List[i].acronym,ac2e_List[i].token));
	  	end
	  end
	  if(matches == 0) then
	  	debugMsg("No match for "..which.."\n");
	  end
end
---------------------------------------------------------------------------		
-- Liste der Smilies anzeigen
--------------------------------------------------------------------------- 
function showSmilies(which)
    local matches = 0;
		for i=1, getn(s2eList) do
			if((s2eList[i].smilie == which) or (which == "all")) then
			  matches = matches +1;
	  		debugMsg(string.format("%s set to %s\n",s2eList[i].smilie,s2eList[i].token));
	  	end
	  end
	  if(matches == 0) then
	  	debugMsg("No match for "..which.."\n");
	  end
end
---------------------------------------------------------------------------		
-- bestehendes Akronym neu zuweisen 
---------------------------------------------------------------------------  
function acroExists(acronym)
		for i=1, getn(ac2e_List) do
	  if (ac2e_List[i].acronym == acronym) then
			return true;
	  end
	end	
	return false;
end
---------------------------------------------------------------------------		
-- Smilie Command Handler setzen
---------------------------------------------------------------------------
function handleSmilies(cmd)
  for command, smilie, token in string.gfind(cmd,"(%w+)%s+([^%s]+)%s*(%w*)") do -- for start
		if(command == "set")then  -- if start 
			if((smilie ~=nil) and (token ~= nil))then -- if start
			   if(smilieExists(smilie)) then
			     alterSmilie(smilie,token);
			     return
			   end
				local tmp ={
				  ["smilie"] = smilie,
				  ["token"] = token
				}
				table.insert(s2eList,tmp);
				debugMsg(string.format("%s as %s added\n",smilie,token));
				return 
			end  --if end
		end -- if end
		
		
		if(command == "rem") then -- rem start
			if(smilie ~=nil) then			
				for i=1, getn(s2eList) do
				  if (s2eList[i].smilie == smilie) then
				  	table.remove(s2eList,i);
				  	debugMsg(string.format("%s removed\n",smilie));
				  	return;
				  end
				end	
			end
		end --rem end
		
		if(command == "show") then
		debugMsg(smilie);
			if(smilie ~= nil) then
			showSmilies(smilie);

			end	
		end
	end -- loop end
end --function end

---------------------------------------------------------------------------		
-- Akronym Command Handler setzen
---------------------------------------------------------------------------
function handleAcronyms(cmd)
  for command, smilie, token in string.gfind(cmd,"(%w+)%s+([^%s]+)%s*(%w*)") do -- for start
		if(command == "set")then  -- if start 
			if((smilie ~=nil) and (token ~= nil))then -- if start
				if(acroExists(smilie))then
				  alterAcronym(smilie,token);
					return;
				end
				local tmp ={
				  ["acronym"] = smilie,
				  ["token"] = token
				}
				table.insert(ac2e_List,tmp);
				debugMsg(string.format("%s as %s added\n",smilie,token));
				return 
			end  --if end
		end -- if end
		
		
		if(command == "rem") then -- rem start
			
			if(smilie ~=nil) then
				
				for i=1, getn(ac2e_List) do
				  if (ac2e_List[i].acronym == smilie) then
				  	table.remove(ac2e_List,i);
				  	debugMsg(string.format("%s removed\n",smilie));
				  end
				end	
			end
		end --rem end
		
		if(command == "show") then
			if(smilie ~= nil) then
				showAcronyms(smilie);
			end 
		end
	end -- loop end

end
---------------------------------------------------------------------------		
-- S2E Status zurückgeben
---------------------------------------------------------------------------
function statusString(status)
  if (status == true) then
  	return "on";
  end
  if(status == false) then
  	return "off";
  end
  return "unknown";
end

---------------------------------------------------------------------------		
-- Statusausgabe
---------------------------------------------------------------------------
function status()
	debugMsg(string.format("Convert incoming: %s\n",statusString(s2eIn_On)));
	debugMsg(string.format("Convert outgoing: %s\n",statusString(s2eOut_On)));
end

---------------------------------------------------------------------------		
-- s2e Ein- und Ausschalten, verfügbare Tokens anzeigen
---------------------------------------------------------------------------
function toggleAddOn(cmd)
   for sys, toggle in string.gfind(cmd,"(%w*)%s*(%w*)") do
    	
     if(toggle == "on") then
       if(sys == "all") then
       	s2eIn_On = true;
       	s2eOut_On = true;
       end
       if(sys == "out") then
       	s2eOut_On = true;
       end
       if(sys == "in") then
       	s2eIn_On = true;
       end
     end
     
     if(toggle == "off") then
     	if(sys == "all") then
       	s2eIn_On = false;
       	s2eOut_On = false;
       end
       if(sys == "out") then
       	s2eOut_On = false;
       end
       if(sys == "in") then
       	s2eIn_On = false;
       end
     end
     
     if(sys == "token") then 
     		showAvailableEmotes(toggle);
     		return
     end  
     status();
   end
end
---------------------------------------------------------------------------		
-- die Original SendChatMessage retten
-- die Original ChatFrame_OnEvent retten
---------------------------------------------------------------------------		
Blizzard_SendChatMessage = SendChatMessage
Blizzard_ChatFrame_OnEvent = ChatFrame_OnEvent
---------------------------------------------------------------------------		
-- Ladezustand registrieren
---------------------------------------------------------------------------		
function s2e_OnLoad()
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("CHAT_MSG_SAY");
	this:RegisterEvent("CHAT_MSG_PARTY");
	
	---------------------------------------------------------------------------		
	-- Slash Commands generieren
	---------------------------------------------------------------------------	
	SLASH_S2ES1 = "/smilie";
	SLASH_S2ES2 = "/sml";
	SLASH_S2EA1 = "/acronym";
	SLASH_S2EA2 = "/acro";
	SLASH_S2ET1 = "/s2e";
	
	SlashCmdList["S2ES"] = handleSmilies;
	SlashCmdList["S2EA"] = handleAcronyms;
	SlashCmdList["S2ET"] = toggleAddOn;
end



---------------------------------------------------------------------------		
-- Ladestatus Anzeigen
---------------------------------------------------------------------------		
function s2e_OnEvent(event)
	if (event == "VARIABLES_LOADED") then
		if(not s2eList) then 
			generateLists();
		end
		debugMsg("sendChatMessage - hooked!\n");
		status();
		-- showAvailableEmotes();
	end
end

---------------------------------------------------------------------------		
-- Funktion SendChatMessage Erzeugen
---------------------------------------------------------------------------		
function SendChatMessage(msg, system, language, channel) --function begin
	local ms = msg
	if(s2eOut_On == true) then
	  if((system == "SAY") or (system == "PARTY") ) then
  		ms = convChatMsg(msg) 														 -- emotes Konvertieren
  	end
  end
	Blizzard_SendChatMessage(ms, system,language,channel); -- originalfunktin aufrufen
end --function end

---------------------------------------------------------------------------		
-- ChatFrame Events abfangen
-- Wird in Zukunft für die Konvertierung eingehender
-- Nachrichten benötigt. Zur Zeit: relativ Nutzlos
---------------------------------------------------------------------------	
function ChatFrame_OnEvent(event)
local msg = arg1;
local plr = arg2;
local ev = event;
  if(s2eIn_On == true) then
	  if ((event == "CHAT_MSG_SAY" or event=="CHAT_MSG_PARTY" or event=="CHAT_MSG_GUILD") ) then
				arg1 = convChatEvent(msg);
				if(string.len(arg1)>0) then
				  Blizzard_ChatFrame_OnEvent(ev)
				  return
				 end
				 return
	  end
  end
  	Blizzard_ChatFrame_OnEvent(ev)   
end

---------------------------------------------------------------------------		
-- Konvertierung eingehender Nachrichten
-- Wird aktuell nicht verwendet
---------------------------------------------------------------------------
function convChatEvent(msg)
	local m = msg
---------------------------------------------------------------------------		
-- smilies konvertieren
---------------------------------------------------------------------------				
		local index = nil		
		local ecmd = nil
		
		for i = 1, getn(s2eList) do 																-- loop begin
		
			if (string.find(m,s2e_escape(s2eList[i].smilie))~= nil) then 							-- if begin		
				emoteMsg(arg2.." "..string.lower(s2eList[i].token))
				m = string.gsub(m,s2e_escape(s2eList[i].smilie),"") 										-- smilie extrahieren
			  end  																										-- if end
		end  																												-- loop end
---------------------------------------------------------------------------		
-- acronyme konvertieren
---------------------------------------------------------------------------		
		local pattern = ""
		m = string.format(" %s ",m)				-- leerzeichen davor und dahinter damit 
																			-- zeilenanfang und Zeilenende ausser
																			-- ach gelassen werden können 
				for i = 1, getn(ac2e_List) do 																			--loop begin
		        pattern =  string.format("[^%%w]+(%s)[^%%w]+",s2e_escape(ac2e_List[i].acronym))	  -- pattern erzeugen
		        index = nil
		        for s in string.gfind(m,pattern) do
				  		index = true
		        end
						if (index~= nil) then 																								-- if begin
							index = nil
							emoteMsg(arg2.." "..string.lower(ac2e_List[i].token))																			--emote abfeuern
							m = string.gsub(m,pattern,"") 																			--smilie extrahieren
			  		end  																																--if end
				end
---------------------------------------------------------------------------		
-- restmeldung konvertieren
---------------------------------------------------------------------------		
		 index = string.gsub(m," ","")																					--leerstring prüfung
		 if(string.len(index) == 0) then
		   m = index
		 end 
		return m; 																															-- nachricht zurückgeben	
end

---------------------------------------------------------------------------		
-- Die Konvertierungsfunktion
---------------------------------------------------------------------------		
function convChatMsg(msg) 	--function begin
local m = msg
---------------------------------------------------------------------------		
-- target ermitteln, wenn vorhanden
---------------------------------------------------------------------------		
		 local target = ""
		 if(UnitIsVisible("target")) then
		   target = UnitName("target")
		 end	 

---------------------------------------------------------------------------		
-- smilies konvertieren
---------------------------------------------------------------------------				
		local index = nil		
		for i = 1, getn(s2eList) do 															-- loop begin 
			if (string.find(m,s2e_escape(s2eList[i].smilie))~= nil) then 							-- if begin
				DoEmote(string.upper(s2eList[i].token),target); 																			--emote abfeuern
				m = string.gsub(m,s2e_escape(s2eList[i].smilie),"") 										-- smilie extrahieren
			  end  																										-- if end
		end  																												-- loop end
---------------------------------------------------------------------------		
-- acronyme konvertieren
---------------------------------------------------------------------------		
		local pattern = ""
		m = string.format(" %s ",m)				-- leerzeichen davor und dahinter damit 
																			-- zeilenanfang und Zeilenende ausser
																			-- ach gelassen werden können
				for i = 1, getn(ac2e_List) do 																			--loop begin
		        pattern =  string.format("[^%%w]+(%s)[^%%w]+",s2e_escape(ac2e_List[i].acronym))	  -- pattern erzeugen
		        index = nil
		        for s in string.gfind(m,pattern) do
				  		index = true
		        end
						if (index~= nil) then 																								-- if begin
							index = nil
							DoEmote(string.upper(ac2e_List[i].token),target); 																									--emote abfeuern
							m = string.gsub(m,pattern,"") 																			--smilie extrahieren
			  		end  																																--if end
				end
---------------------------------------------------------------------------		
-- restmeldung konvertieren
---------------------------------------------------------------------------		
		 index = string.gsub(m," ","")																					--leerstring prüfung
		 if(string.len(index) == 0) then
		   m = index
		 end 
		return m; 																															-- nachricht zurückgeben
end

---------------------------------------------------------------------------		
-- Ausgabefunktion für Meldungen
---------------------------------------------------------------------------		
function debugMsg(msg)
			info = ChatTypeInfo["SAY"]
			DEFAULT_CHAT_FRAME:AddMessage("[smilie2emote]", info.r, info.g, info.b, info.id);
 	    info = ChatTypeInfo["SYSTEM"]
			DEFAULT_CHAT_FRAME:AddMessage(string.format("%s",msg), info.r, info.g, info.b, info.id);
  --print(msg)
end
---------------------------------------------------------------------------		
-- Emote Tokens anzeigen
---------------------------------------------------------------------------		
function showAvailableEmotes(part)
		local i = 1
		while i < 171 do
		  if(string.find(getglobal("EMOTE"..i.."_TOKEN"),"^"..string.upper(part)) ~= nil) then
		  	debugMsg(string.format("%s \n",TEXT(getglobal("EMOTE"..i.."_TOKEN"))));
		  end
		  i=i+1;
		end
end
---------------------------------------------------------------------------		
-- Ausgabefunktion für eingehende Emotes
---------------------------------------------------------------------------	
function emoteMsg(msg)
   info = ChatTypeInfo["EMOTE"]
   DEFAULT_CHAT_FRAME:AddMessage(msg, info.r, info.g, info.b, info.id);
end
---------------------------------------------------------------------------		
-- Hilfsfunktion zum escapen der Magic-Chars 
---------------------------------------------------------------------------		
function s2e_escape(sString)
	local sRet = string.gsub(sString, "([%^%$%(%)%%%.%[%]%*%+%-%?])", "%%%1");
	return sRet;
end

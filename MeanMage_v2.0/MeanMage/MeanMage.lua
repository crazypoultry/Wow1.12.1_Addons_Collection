---------------------------------------
--             [ MeanMage ]
--    [ By Khenan @ (EU)Doomhammer ]
---------------------------------------

---------------------------------------
--         [ Reply Message ]
---------------------------------------

-- Set message for autoreply when asked for water/bread
MeanMage_Reply = "Sorry, I'm busy atm. You'll Have to ask someone else."

-- Set message for autoreply when asked for portals
MeanMage_Reply2 = "Portals cost 2g. If that's too much for you then start walking..."

---------------------------------------
--         [ Search Pattern ] 
---------------------------------------

MeanMage_Pattern1 = "[Ww][Aa][Tt][Ee][Rr]"
MeanMage_Pattern2 = "[Ff][Oo][Oo][Dd]"
MeanMage_Pattern3 = "[Pp][Oo][Rr][Tt][Aa][Ll]"

---------------------------------------
--            [ On Load ] 
---------------------------------------

function MeanMage_OnLoad()
	this:RegisterEvent("CHAT_MSG_WHISPER");
	SlashCmdList["MEANMAGECOMMAND"] = MeanMage_SlashHandler;
	SLASH_MEANMAGECOMMAND1 = "/mm";
	SLASH_MEANMAGECOMMAND2 = "/meanmage";
	if (UnitClass("player") == "Mage") then
		MeanMageSet = "on"
		MeanMage_ChatPrint("MeanMage 1.0 loaded and enabled. To switch it off type: /mm off");
	else
		MeanMageSet = "off"
		MeanMage_ChatPrint("MeanMage 1.0 loaded but disabled. To switch it on type: /mm on");
	end
end

---------------------------------------
--         [ System Messages ] 
---------------------------------------

function MeanMage_ChatPrint(msg)
	DEFAULT_CHAT_FRAME:AddMessage(msg);
end

---------------------------------------
--         [ Slash Commands ] 
---------------------------------------

function MeanMage_SlashHandler(msg)
	if (msg) then
		msg = string.lower(msg);
		if (string.find(msg, "on")) then
			MeanMageSet = "on"
			MeanMage_ChatPrint("MeanMage is now ON. To switch it off type: /mm off");
		elseif (string.find(msg, "off")) then
			MeanMageSet = "off"
			MeanMage_ChatPrint("MeanMage is now OFF. To switch it on type: /mm on");
		else
			MeanMage_ChatPrint("MeanMage Usage: /mm [on/off]");
		end
	end
end

---------------------------------------
--           [ Is Grouped ] 
---------------------------------------

local function NameIsGrouped(name)
  local inGroup
  if GetNumPartyMembers()>0 then
    for i=1,4 do
      inGroup = inGroup or (UnitName("party"..i)==name)
    end
  end
  if not inGroup and GetNumRaidMembers()>0 then
    for i=1,40 do
      inGroup = inGroup or (UnitName("raid"..i)==name)
    end
  end
  return inGroup
end

---------------------------------------
--         [ Main Function ] 
---------------------------------------

function MeanMage_OnEvent(event)
	if MeanMageSet ~= "off" then
	
		if (event == "CHAT_MSG_WHISPER" and (string.find(arg1, MeanMage_Pattern1) or string.find(arg1, MeanMage_Pattern2))) then
			if event=="CHAT_MSG_WHISPER" and NameIsGrouped(arg2 or "") then
				--[[ someone in party/raid in the same guild as you sent you that whisper ]]
			else
				SendChatMessage(MeanMage_Reply, "WHISPER", nil, arg2);
			end
		end
		
		if (event == "CHAT_MSG_WHISPER" and string.find(arg1, MeanMage_Pattern3)) then
			if event=="CHAT_MSG_WHISPER" and NameIsGrouped(arg2 or "") then
				--[[ someone in party/raid in the same guild as you sent you that whisper ]]
			else
				SendChatMessage(MeanMage_Reply2, "WHISPER", nil, arg2);
			end
		end
		
	end
end

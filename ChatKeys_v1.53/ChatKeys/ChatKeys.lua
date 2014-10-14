------------------------------------- VARIABLES ---------------------------------------
CHATKEYSNAME = "ChatKeys";
CHATKEYSVERS = "1.53";
CKSETTINGS = GetCVar("realmName")..UnitName("player");
------- valeurs par defaut
local defBuddyName = "";
local defChannelName = "";
local defSound = 1;
-------
ChatKeysSaved = {};
ChatKeysSaved[CKSETTINGS] = {};
ChatKeysDatas = {};
-------
local interlocuteur = "";
local enTest = false;
local ckr,ckg,ckb; -- couleurs

---------------------------------------------------------------------------------------
-------------------------- CHARGEMENT / COMMANDES /BINDINGS ---------------------------
function chargementChatKeys()
	------------- slash commandes
	SlashCmdList["WHOCHAN"] = infodisque;
		SLASH_WHOCHAN1 = "/infochan";
		SLASH_WHOCHAN2 = "/whochan";
		
	SlashCmdList["WHOSWHISPER"] = whoWhisper;
		SLASH_WHOSWHISPER1 = "/whow";
		SLASH_WHOSWHISPER2 = "/whowhisper";

	SlashCmdList["EASYCHATHELPVERSION"] = echoVersionChat;
		SLASH_EASYCHATHELPVERSION1 = "/chatkeysversion";
		SLASH_EASYCHATHELPVERSION2 = "/chatkeysvers";
		
	SlashCmdList["SHOW_UI"] = ChatKeysOptions;
		SLASH_SHOW_UI1 = "/chatui";
		SLASH_SHOW_UI2 = "/chatopt";
		SLASH_SHOW_UI3 = "/chatoptions";

	-------------- bindings
	BINDING_HEADER_CHATKEYS = CHATKEYSNAME
	
	BINDING_NAME_SAYMESSAGE = BIND_NAME_SAY
	BINDING_NAME_YELLMESSAGE = BIND_NAME_YELL
	BINDING_NAME_PARTYMESSAGE = BIND_NAME_PARTY
	BINDING_NAME_RAIDMESSAGE = BIND_NAME_RAID
	BINDING_NAME_RWRAIDMESSAGE = BIND_NAME_RWRAID
	BINDING_NAME_GUILDMESSAGE = BIND_NAME_GUILD
	BINDING_NAME_GUILDOFFMESSAGE = BIND_NAME_GUILDOFFICER
	
	BINDING_NAME_GENERALMESSAGE = GENERALCHANNELNAME
	BINDING_NAME_TRADEMESSAGE = TRADECHANNELNAME
	BINDING_NAME_DEFENSEMESSAGE = DEFENSECHANNELNAME
	BINDING_NAME_GROUPMESSAGE = GROUPCHANNELNAME

	BINDING_NAME_SHOWCHATUI = BIND_NAME_CHATUI
	BINDING_NAME_CUSTOMMESSAGE = BIND_NAME_CUSTOM
	BINDING_NAME_CUSTOMCHANNEL = BIND_NAME_CHANNEL
	BINDING_NAME_EMOTE = BIND_NAME_EMOTE
	BINDING_NAME_WHISPER = BIND_NAME_WHISPER
	
	BINDING_NAME_INFOCHAN = BIND_NAME_WHOCHAN
	BINDING_NAME_WHOSwho = BIND_NAME_WHO
	
	
	-------------- suite
	ChatKeysDatas = ChatKeysSaved[CKSETTINGS];
	if (ChatKeysDatas == nil) then CKinitDatas(); end;
	if (ChatKeysDatas["sndNotification"] == nil) then ChatKeysDatas["sndNotification"] = defSound; end; -- pour MAJ 1.5
	if (DEFAULT_CHAT_FRAME) then echoVersionChat(true); end;
end

---------------------------------------------------------------------------------------
----------------------------- MISE A JOUR DES MURMURES --------------------------------
function majMurmureRecuChatKeys(arg1,arg2)
	interlocuteur = arg2;
	if (ChatKeysDatas["sndNotification"] == 1) then PlaySound("TellMessage"); end;
end

function majMurmureEnvoiChatKeys(arg1,arg2,arg3)
	if (interlocuteur == "") then interlocuteur = arg2; end;
end

---------------------------------------------------------------------------------------
---------------------------------- CHANNEL CHANGE -------------------------------------
function tapeMessage(prefixe)
	-- tape le debut du message dans la Chat Box pour ouvrir un canal
	if (not ChatFrameEditBox:IsVisible()) then
		ChatFrame_OpenChat(prefixe);
	else
		ChatFrameEditBox:SetText(prefixe);
	end;
	ChatEdit_ParseText(ChatFrame1.editBox,0);
end

function messageCanal(nomCanalVoulu)
	-- commence un msg sur le canal voulu
	local numCanal = chercheCanal(nomCanalVoulu);
	if (enTest) then echo(CHATKEYSNAME.." ===Requested channel="..nomCanalVoulu.."="..numCanal.."===","gray"); end;
	if (numCanal > 0) then
		tapeMessage("/"..numCanal.." ");
	else
		echo(CHATKEYSNAME..": "..NOCHANNEL..nomCanalVoulu,"orange");
	end;
end

function chercheCanal(nomCanalVoulu)
	-- scanne les canaux de 1 a 10 pour trouver le nom du canal voulu
	-- renvoit le numero du canal trouve ou 0
	local i,idCanal,nomCanal;
	for i = 1,10,1 do
		idCanal,nomCanal = GetChannelName(i);
		if (idCanal ~= 0 and nomCanal ~= nil) then
			--if (string.find(nomCanal,nomCanalVoulu,1,true) ~= nil) then return i; end;
			return i;
		end;
	end;
	return 0; -- introuvable
end

function messageParty()
	-- commence un msg sur le canal Party
	if (GetNumPartyMembers() > 0) then
		tapeMessage("/p ");
	else
		echo(CHATKEYSNAME..": "..ERRORPARTY,"orange");
	end;
end

function messageRaid()
	-- commence un msg sur le canal Raid ou DefenseLocale
	if (GetNumRaidMembers() > 0) then
		tapeMessage("/ra ");
	else
		messageCanal(BINDING_NAME_DEFENSEMESSAGE);
	end;
end

function warningRaid()
	-- commence un msg sur le canal Avertissement Raid
	if (GetNumRaidMembers() > 0) then
		tapeMessage("/rw ");
	else
		echo(CHATKEYSNAME..": "..ERRORRAID,"orange");
	end;
end

function messageGuilde()
	-- commence un msg sur le canal Guilde
	if (GetGuildInfo("player") ~= nil) then
		tapeMessage("/g ");
	else
		echo(CHATKEYSNAME..": "..ERRORGUILD,"orange");
	end;
end

function messageGuildeOfficier()
	-- commence un msg sur le canal Guilde en tant qu'officier
	local guildName,guildRankName,guildRankIndex = GetGuildInfo("player");
	if (guildName ~= nil) then
		-- test authorisation -- marche po ?
		--if (guildRankIndex ~=nil and strToInteger(guildRankIndex)<= 2) then
			tapeMessage("/o ");
		--else
		--	echo(CHATKEYSNAME..": "..ERRORGUILDOFFICER,"orange");
		--end;
	else
		echo(CHATKEYSNAME..": "..ERRORGUILD,"orange");
	end;
end

function messagePerso()
	-- commence un murmure au joueur dont le nom est defini dans l'UI d'options
	if (ChatKeysDatas == nil or ChatKeysDatas["buddyName"] == nil or ChatKeysDatas["buddyName"] == "") then
		echo(CHATKEYSNAME..": "..ERRORBUDDY,"orange");
	else
		tapeMessage("/w "..ChatKeysDatas["buddyName"].." ");
	end;
end

function messageCanalPerso()
	-- commence un message dans le canal perso dont le nom est definit dans l'UI d'options
	if (ChatKeysDatas == nil or ChatKeysDatas["channelName"] == nil or ChatKeysDatas["channelName"] == "") then
		echo(CHATKEYSNAME..": "..ERRORCHANNEL,"orange");
	else
		messageCanal(ChatKeysDatas["channelName"]);
	end;
end

function messageCible()
	-- commence un murmure au joueur ami selectionne
	if ((UnitName("target") ~= nil) and (UnitIsPlayer("target")) and (UnitIsFriend("player","target"))) then
		tapeMessage("/w "..UnitName("target").." ");
	else
		echo(CHATKEYSNAME..": "..ERRORTARGET,"orange");
	end;
end

function messageEmote()
	-- commence un emote
	tapeMessage("/em ");
end

---------------------------------------------------------------------------------------
-------------------------------------- LISTE USERS ------------------------------------
function infodisque(numCanal)-- numCanal optionnel
	if (numCanal == nil or numCanal == "") then
		if (ChatKeysDatas == nil or ChatKeysDatas["channelName"] == nil or ChatKeysDatas["channelName"] == "") then
			echo(CHATKEYSNAME..": "..ERRORCHANNEL,"orange");
		else
			ListChannelByName(ChatKeysDatas["channelName"]); -- /infodisc nomCanal
		end;
	else
		local numChan = tonumber(string.gsub(chaine,"\"",""));
		local idChan,nomChan = GetChannelName(myChannel);
		if (idChan > 0 and nomChan ~= nil) then
			ListChannelByName(ChatKeysDatas["channelName"]); -- /infodisc nomCanal
		else
			echo(CHATKEYSNAME..": "..NOCHANNEL..numChan,"orange");
		end;
	end;
end;

---------------------------------------------------------------------------------------
------------------------------------------ WHO ----------------------------------------
function whoWhisper()
	if (interlocuteur ~= "") then
		SendWho(interlocuteur);
	else
		echo(CHATKEYSNAME..": "..ERRORWHISPER,"orange");
	end;
end

---------------------------------------------------------------------------------------
------------------------------------------ UI -----------------------------------------
function ChatKeysOptions()
	if (ChatKeysOptionsFrame:IsVisible()) then
		ChatKeysOptionsFrame:Hide();
	else
		ChatKeysOptionsFrame:Show();
	end;
end

function ChatKeysOptionsDlogApply()
	ChatKeysDatas["buddyName"] = string.gsub(ChatKeysOptName:GetText()," ","");
	ChatKeysDatas["channelName"] = string.gsub(ChatKeysOptChanName:GetText()," ","");
	ChatKeysDatas["sndNotification"] = attribueBinaire(ChatKeysOptCheckSound:GetChecked());
	ChatKeysOptionsFrame:Hide();
	ChatKeysSaved[CKSETTINGS] = ChatKeysDatas;
end

function CKinitDatas()
	ChatKeysDatas = {};
	ChatKeysDatas["buddyName"] = defBuddyName;
	ChatKeysDatas["channelName"] = defChannelName;
	ChatKeysDatas["sndNotification"] = defSound;
	ChatKeysSaved[CKSETTINGS] = ChatKeysDatas;
end

---------------------------------------------------------------------------------------
--------------------------------------- HOOK ------------------------------------------
---- Changing current global strings ----
--CHAT_FLAG_AFK = "[AFK] ";
--CHAT_FLAG_DND = "[DND] ";
--CHAT_FLAG_GM = "[GM] ";

CHAT_GUILD_GET = "%s:\32"; -- Guild message from player %s
CHAT_OFFICER_GET = "[OFF] %s:\32"; -- Officers guild message from officer %s
CHAT_RAID_LEADER_GET = "[LEAD] %s:\32"; -- Raid leader message from raid officer %s
CHAT_RAID_WARNING_GET = "[ATT] %s:\32"; -- Raid alert message from raid officer %s
CHAT_RAID_GET = "%s:\32"; -- Raid message from player %s
CHAT_PARTY_GET = "%s:\32"; -- Party message from player %s
CHAT_WHISPER_GET = MSGFROM.." %s:\32"; -- Whisper from player %s
CHAT_WHISPER_INFORM_GET = MSGTO.." %s:\32"; -- A whisper already sent to player %s

---------------------------------------------------------------------------------------
------------------------------------ FCNS INTERNES ------------------------------------
function echoVersionChat(chargement)
	if (chargement) then
		DEFAULT_CHAT_FRAME:AddMessage(CHATKEYSNAME.." "..CHATKEYSVERS.." loaded",0.1,0.6,0.5);
	else
		echo(CHATKEYSNAME.." version "..CHATKEYSVERS,"blue");
	end; 
end

function echo(chaine,nomCouleur)
	if (DEFAULT_CHAT_FRAME) then
		defCouleurCK(nomCouleur);
		ChatFrame1:AddMessage(chaine,ckr,ckg,ckb);
	end;
end

function strToInteger(chaine)
	local strArg = chaine;
	local strToInt = 0;
	while ((strArg ~= "") and (strArg)) do
		strToInt = strToInt * 10;
		strToInt = strToInt + (string.byte(strsub(strArg, 1, 1)) - string.byte("0"));
		strArg = strsub(strArg, 2);
	end;
	return (strToInt);		
end

function videSiNul(valeur)
	if (valeur == nil) then return ""; else return valeur; end;
end

function nilSiNul(valeur)
	if (valeur == nil) then return "NIL"; else return valeur; end;
end

function inversionValeur(valeur)
	return(abs(valeur - 1));
end

function attribueBinaire(valeur)
	if (valeur == 1) then return (1); else return (0); end;
end

function defCouleurCK(nomCouleur)
	if (nomCouleur == "red") then
		ckr,ckg,ckb = 1,0,0;
	elseif (nomCouleur == "green") then
		ckr,ckg,ckb = 0,1,0;
	elseif (nomCouleur == "blue") then
		ckr,ckg,ckb = 0.3,0.3,0.8;
	elseif (nomCouleur == "orange") then
		ckr,ckg,ckb = 0.8,0.3,0.1;
	elseif (nomCouleur == "yellow") then
		ckr,ckg,ckb = 1,1,0;
	elseif (nomCouleur == "grey" or nomCouleur == "gray") then
		ckr,ckg,ckb = 0.6,0.6,0.6;
	else
		ckr,ckg,ckb = 1,1,1;
	end;
end

---------------------------------------------------------------------------------------
------------------------------------- AIDE ONLINE -------------------------------------

---------------------------------------------------------------------------------------

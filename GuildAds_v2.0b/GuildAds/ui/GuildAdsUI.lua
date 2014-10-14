--[[
Envoyer la demande pour playerName, dataType
	Chacun fixe l opcode "RLR" (request last revision)
	Pas de fils -> envois au parent
	Un/des fils -> 
		Attente
		Les deux sont arrivés 
			- choisir le meilleur : revision puis poids
			- envois au parent
	Déco du perso -> reset
	Pas de parent : envois sur le canal demande de "UPD" (update) au meilleur
	Reception sur le channel
	
Une file d attente pour 
	- le traitement des commandes
	- l envois des messages
	
Probleme : 
	comment avoir la liste des onlines synchro
	
	
GuildAdsComm:SendUpdate
]]

--[[
	Initialiaze
	OnChannelJoin
	OnChannelLeave
	OnConnection
	OnOnline
	OnItemInfoReady
	Register
	
	debug
	
	setConfigValue
	getConfigValue
	setProfileValue
	getProfileValue
	
	
]]

IsOnLine = {
	["Fkaï"]=true;
	["Zarkan"]= true;
	["Dalf"]= false;
	["Darknekro"]= false;
}

crafter = function(a, b)
	local oa = IsOnLine[a];
	local ob = IsOnLine[b];
	if oa~=ob then
		return oa and not ob;
	end
	return a<b;
end;

t = { "Zarkan" };
table.insert(t, "Fkaï");
table.insert(t, "Darknekro");
table.insert(t, "Dalf");

table.sort(t, crafter);
print(table.concat(t, ", "));



--~ s = "GuildAds - ";
--~ print("["..string.gsub(s, "%s%-%s.*", "").."]")

--~ "["..string.gsub("GuildAds - ", "%s%-%s.*", "").."]"
a = false;
b = true;
print(not a and b)
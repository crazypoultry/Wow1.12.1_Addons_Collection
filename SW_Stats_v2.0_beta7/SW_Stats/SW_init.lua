
--[[ 
	1.5 added pausing and unpausing of data collection
	so changed the event definition here and split it into 2 parts
	events that have to be on always, and events that can be switched
	
	2.0 just removed old chat and added CHAT_MSG_ADDON
--]]
SW_EventCollection = {
	SW_EventsMandatory = {
		"PLAYER_TARGET_CHANGED",
		"VARIABLES_LOADED",
		"UNIT_PET",
		"PARTY_MEMBERS_CHANGED",
		"PARTY_LEADER_CHANGED",
		"RAID_ROSTER_UPDATE",
		"PLAYER_ENTERING_WORLD",
		
		-- for sync
		"CHAT_MSG_ADDON",
		
		-- 1.5.beta.2 this better not be off DOH 
		"SPELLS_CHANGED",
	},
	SW_EventsSwitched = {
		--"UNIT_COMBAT", 
		"CHAT_MSG_COMBAT_CREATURE_VS_CREATURE_HITS",
		"CHAT_MSG_COMBAT_CREATURE_VS_CREATURE_MISSES",
		"CHAT_MSG_COMBAT_CREATURE_VS_PARTY_HITS",
		"CHAT_MSG_COMBAT_CREATURE_VS_PARTY_MISSES",
		"CHAT_MSG_COMBAT_CREATURE_VS_SELF_HITS",
		"CHAT_MSG_COMBAT_CREATURE_VS_SELF_MISSES",
		"CHAT_MSG_COMBAT_FRIENDLYPLAYER_HITS",
		"CHAT_MSG_COMBAT_FRIENDLYPLAYER_MISSES",
		"CHAT_MSG_COMBAT_HONOR_GAIN",
		"CHAT_MSG_COMBAT_HOSTILEPLAYER_HITS",
		"CHAT_MSG_COMBAT_HOSTILEPLAYER_MISSES",
		"CHAT_MSG_COMBAT_LOG_ERROR",
		"CHAT_MSG_COMBAT_LOG_MISC_INFO",
		--"CHAT_MSG_COMBAT_MISC_INFO", 2.0 removed didnt want to parse ["CHAT_MSG_COMBAT_MISC_INFO"] = "Your equipped items suffer a 10% durability loss.",
		"CHAT_MSG_COMBAT_PARTY_HITS",
		"CHAT_MSG_COMBAT_PARTY_MISSES",
		"CHAT_MSG_COMBAT_PET_HITS",
		"CHAT_MSG_COMBAT_PET_MISSES",
		"CHAT_MSG_COMBAT_SELF_HITS",
		"CHAT_MSG_COMBAT_SELF_MISSES",
		"CHAT_MSG_SPELL_BREAK_AURA",
		"CHAT_MSG_SPELL_AURA_GONE_SELF",
		"CHAT_MSG_SPELL_AURA_GONE_OTHER",
		"CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF",
		"CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE",
		"CHAT_MSG_SPELL_CREATURE_VS_PARTY_BUFF",
		"CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE",
		"CHAT_MSG_SPELL_CREATURE_VS_SELF_BUFF",
		"CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE",
		"CHAT_MSG_SPELL_DAMAGESHIELDS_ON_OTHERS",
		"CHAT_MSG_SPELL_DAMAGESHIELDS_ON_SELF",
		"CHAT_MSG_SPELL_FRIENDLYPLAYER_BUFF",
		"CHAT_MSG_SPELL_FRIENDLYPLAYER_DAMAGE",
		"CHAT_MSG_SPELL_HOSTILEPLAYER_BUFF",
		"CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE",
		"CHAT_MSG_SPELL_PARTY_BUFF",
		"CHAT_MSG_SPELL_PARTY_DAMAGE",
		"CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS",
		"CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE",
		"CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_BUFFS",
		"CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE",
		"CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_BUFFS",
		"CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE",
		"CHAT_MSG_SPELL_PERIODIC_PARTY_BUFFS",
		"CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE",
		"CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS",
		"CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE",
		"CHAT_MSG_SPELL_PET_BUFF",
		"CHAT_MSG_SPELL_PET_DAMAGE",
		"CHAT_MSG_SPELL_SELF_BUFF",
		"CHAT_MSG_SPELL_SELF_DAMAGE",
		"PLAYER_REGEN_DISABLED",
		"PLAYER_REGEN_ENABLED",
		
		-- added for 1.3.0 to get mana efficiency
		"SPELLCAST_CHANNEL_START",
		"SPELLCAST_STOP",
		"SPELLCAST_FAILED",
		"SPELLCAST_INTERRUPTED",
		 
		-- added 1.4 for death count
		"CHAT_MSG_COMBAT_FRIENDLY_DEATH",
		"CHAT_MSG_COMBAT_HOSTILE_DEATH",
	},
	
}
function SW_UnpauseEvents()
	local coreFrame = getglobal("SW_CoreFrame");
	for i, val in ipairs(SW_EventCollection.SW_EventsSwitched) do
		coreFrame:RegisterEvent(val);
	end
	
end
function SW_PauseEvents()
	local coreFrame = getglobal("SW_CoreFrame");
	for i, val in ipairs(SW_EventCollection.SW_EventsSwitched) do
		coreFrame:UnregisterEvent(val);
	end
end
function SW_RegisterEvents()
	for i, val in ipairs(SW_EventCollection.SW_EventsMandatory) do
		this:RegisterEvent(val);
	end
end

--[[
	A wrapper arround timing
	If added to saved variables (and inited again)
	will retain cross session seconds ( and milliseconds)
	
	to save it accross sessions add myTimer to SavedVariables AND IN
	VARIABLES_LOADED: myTimer = SW_C_Timer:new(myTimer);
	
--]]
SW_C_Timer = {
	-- epoch time at init
	epochInit = time(),
	-- system up time at init
	upTimeInit = GetTime(),
	
	new = function (self, o)
		o = o or {};
		setmetatable(o, self);
		self.__index = self;
		
		if o.epochTS ~= nil then
			o.uTS = (o.epochTS + o.msO) - self.epochInit ;
		else
			self.setToNow(o);
		end
		return o;
	end,
		
	setToNow = function(self)
		self.epochTS = time();
		self.uTS = GetTime() - self.upTimeInit;
		-- store the millisecond offset
		self.msO = self.uTS - (self.epochTS - self.epochInit);
	end,
	
	-- now return value is not to be used cross session (don't save it)
	now = function(self)
		return GetTime() - self.upTimeInit;
	end,
	
	elapsed = function(self)
		return self.msRound((GetTime() - self.upTimeInit) - self.uTS);	
	end,
	
	-- one must be a timer object, the other value may be a number
	-- only numbers recieved through :now() make sense
	__sub = function(lh, rh)
		if type(rh) == "number" then
			return lh.uTS - rh;
		elseif type(lh) == "number" then
			return lh - rh.uTS;
		else
			return lh.msRound(lh.uTS - rh.uTS);
		end
	end,
	
	msRound = function(val)
		return math.floor((val) * 1000 + 0.5)/1000;
	end,
	absDiff = function(self, rh)
		local ret = self - rh;
		if ret < 0 then ret = -ret; end
		return ret; 
	end,
	
	-- seconds since startup
	SSS = function(self)
		return GetTime() - self.upTimeInit;
	end,
	
	dump = function(self)
		SW_DumpTable(self);
	end,
}
-- map this for upcomeing WoW 2.0 change
if string.gmatch then
	SW_gmatch = string.gmatch;
else
	SW_gmatch = string.gfind;
	
end
--------- My fun function so don't complain
SW_RND_Strings = { 
	["CWATER"] = {
		"pinkelt in eine Flasche...",
		"erleichtert sich.",
		"machts euch in Kirschgeschmack.",
		"denkt 'Wasser, ja Wasser wollte Ich schon immer machen.'",
		"macht euch ein POWER drink.",
		"ahhh, besser!",
		"sammelt seine Tr\195\164nen in einer Flasche",
		"macht noch mehr Blubberwasser.",
		"sagt euch da\195\159 Er kein Bier herbeizaubern kann.",
		"machts euch in Pfirsichgeschmack",
		"zieht die Nase hoch...",
		"kriegt ein mulmiges Gefuehl im Magen. BLEARGH",
	},
	["CBREAD"] = {
		"backe backe BROT!",
		"schmei\195\159t euch Brot an den Kopf!",
		"hat einen eigenartigen Gesichtsausdruck.",
		"PLOP!",
		"transmutiert Luft zu Brot.",
		"sucht sich ein B\195\164ckermeister.",
		"hat Teig an den H\195\164nden. (Und Anderes)",
		
	},
};

function SW_GetRndString(baseIndex)
	if SW_RND_Strings[baseIndex] == nil then return; end
	local index = math.random(table.getn(SW_RND_Strings[baseIndex]));
	SendChatMessage(SW_RND_Strings[baseIndex][index], "EMOTE");
end

-- other dev stuff
function SW_DEV_FFN(func)
	if func == nil then return; end
	if type(func) ~= "function" then
		return "Not a function";
	end
	local ret = "??";
	local vars = getfenv();
	for k,v in pairs(vars) do
		if type(v) == "function" then
			if func == v then
				return k;
			end
		end
	end
	return ret;
end
function SW_DEV_FindVar(str, chkVal)
	local vars = getfenv();
	local sLen =string.len(str);
	SW_printStr( "------ "..str.." ------");
	for k,v in pairs(vars) do
		if chkVal then
			if type(v) == "string" then
				if string.find(v, str) then
			
					SW_DBG(k.." ==> "..v);
				end
			end
		else
			
			if string.find(k, str) then
				if type(v) == "string" or type(v) == "number" then
					SW_DBG(k.." ==> "..v);
				else
					SW_printStr(k.." ("..type(v)..")");
				end
			end
		end
	end
end
function SW_SetRangeHuge()
	SetCVar("CombatDeathLogRange" , "150");
	SetCVar("CombatLogRangeCreature" , "150"); 
	SetCVar("CombatLogRangeFriendlyPlayers" , "150");
	SetCVar("CombatLogRangeFriendlyPlayersPets" , "150");
	SetCVar("CombatLogRangeHostilePlayers" , "150");
	SetCVar("CombatLogRangeHostilePlayersPets" , "150");
	SetCVar("CombatLogRangeParty" , "150");
	SetCVar("CombatLogRangePartyPet" , "150");
end
function SW_SetRangeNormal()
	SetCVar("CombatDeathLogRange" , "60");
	SetCVar("CombatLogRangeCreature" , "30"); 
	SetCVar("CombatLogRangeFriendlyPlayers" , "50");
	SetCVar("CombatLogRangeFriendlyPlayersPets" , "50");
	SetCVar("CombatLogRangeHostilePlayers" , "50");
	SetCVar("CombatLogRangeHostilePlayersPets" , "50");
	SetCVar("CombatLogRangeParty" , "50");
	SetCVar("CombatLogRangePartyPet" , "50");
end
-------------------------- Dump Functions mostly for dev --------------------
function SW_CreateMsgList()
	SW_BaseMsgs ={};
	
	for _,v in pairs(SW_C_MessageList.globalMessages) do
		SW_BaseMsgs[v.Message] = 1;
	end
end
function SW_DumpMetaFor(name)
	local sID, sIDPet;
	
	SW_printStr("|cffff0000--All metaInfo for:"..name);
	SW_printStr("|cffffffffStringID in table:");
	sID = SW_StrTable:hasID(name);
	SW_printStr(sID);
	SW_printStr("|cffffffffPet StringID in table:");
	sIDPet = SW_StrTable:hasID(SW_PET..name);
	SW_printStr(sIDPet);
	SW_printStr("|cffffffffcurrentGroup:");
	SW_DumpTable(SW_C_DCMeta.currentGroup[name]);
	SW_printStr("|cffffffffcurrentPets:");
	SW_printStr(SW_C_DCMeta.currentPets[name]);
	
	if sID then
		SW_printStr("|cffffffffrootMeta sID: ");
		SW_DumpTable (SW_DataCollection.meta[sID]);
		SW_printStr("|cffffffffeverGroup lookup sID:");
		SW_printStr(SW_C_DCMeta.everGroup[sID]);
	end
	if sIDPet then
		SW_printStr("|cffffffffrootMeta sIDPet: ");
		SW_DumpTable (SW_DataCollection.meta[sIDPet]);
		SW_printStr("|cffffffffeverGroup lookup sIDPet:");
		SW_printStr(SW_C_DCMeta.everGroup[sIDPet]);
	end
	
	
end
function SW_printStr(str, toChannelNR, store)
	local chNR =1;
	local pre;
	--local store = true;
	if store then
		pre = "["..date("%c").."] "
		--pre = "";
	end
	
	if toChannelNR ~= nil then chNR = toChannelNR; end
	local con = getglobal("SW_FrameConsole_Text"..chNR.."_MsgFrame");
	if con ~= nil then
		if str == nil then
			con:AddMessage("NIL");
			if store then
				table.insert(SW_DBG_Log, pre.."NIL");
			end
		elseif type(str) == "boolean" then
			local v2 = "Bool:false";
			if str then
				v2 = "Bool:true";
			end
			con:AddMessage(v2);
			if store then
				table.insert(SW_DBG_Log, pre..v2);
			end
		else
			con:AddMessage(str);
			if store then
				table.insert(SW_DBG_Log, pre..str);
			end
		end
	end
	
end
function SW_DBG(str)
	SW_printStr(str, 1, SW_DBG_STORE);
end
function SW_DumpKeys(table)
	if table ==nil then return; end
	if type(table) ~= "table" then return; end
	SW_printStr("-- KEYS -- ");
	for k, v in pairs (table) do 
		SW_printStr(k);
		
	end
end
function SW_DumpTable(table, ds, ch, hideKey)
	if ch == nil then ch = 1; end
	if ds == nil then 
		ds="" 
		SW_printStr("----------------------");
	end
	if table ==nil then return "table is nil"; end
	
	for k, v in pairs (table) do 
		if type(v) ~= "table" then
			if v == nil then
				if hideKey then
					SW_printStr (ds.."NIL", ch);
				else
					SW_printStr (ds.."["..k.."]=NIL", ch);
				end
			elseif type(v) == "boolean" then
				local v2 = "Bool:false";
				if v then
					v2 = "Bool:true";
				end
				if hideKey then
					SW_printStr (ds..v2, ch);
				else
					SW_printStr (ds.."["..k.."]="..v2, ch);
				end
			elseif type(v) == "function" then
				if hideKey then
					SW_printStr (ds.."function", ch);
				else
					SW_printStr (ds.."["..k.."]=function", ch);
				end
			else
				if hideKey then
					SW_printStr (ds..v, ch);
				else
					SW_printStr (ds.."["..k.."]="..v, ch);
				end
			end
		else
		
			if not hideKey then
				SW_printStr (ds.."["..k.."]=", ch);
			end 
			SW_DumpTable(v, ds.."       ");
		end
	end
end
function SW_DumpMessageTable(table, ds, ch, hideKey)
	if ch == nil then ch = 1; end
	if table ==nil then return "table is nil"; end
	if ds == nil then 
		ds="" 
		SW_printStr("---------Message-------------");
	end
	local ts,kt,vt;
	
	for k, v in pairs (table) do 
		if type(v) ~= "table" then
			if v == nil then
				if hideKey then
					SW_printStr (ds.."NIL", ch);
				else
					SW_printStr (ds.."["..k.."]=NIL", ch);
				end
			elseif type(v) == "boolean" then
				local v2 = "Bool:false";
				if v then
					v2 = "Bool:true";
				end
				if hideKey then
					SW_printStr (ds..v2, ch);
				else
					SW_printStr (ds.."["..k.."]="..v2, ch);
				end
			elseif type(v) == "function" then
				if hideKey then
					SW_printStr (ds.."function", ch);
				else
					SW_printStr (ds.."["..k.."]=function", ch);
				end
			else
				if hideKey then
					SW_printStr (ds..v, ch);
				else
					ts = SW_Types:getTypeStr(k);
					if ts then kt = ts; else kt = k; end 
					ts = SW_Types:getTypeStr(v);
					if ts then vt = ts; else vt = v; end 
					SW_printStr (ds.."["..kt.."]="..vt, ch);
				end
			end
		else
		
			if not hideKey then
				SW_printStr (ds.."["..k.."]=", ch);
			end 
			SW_DumpMessageTable(v, ds.."       ");
		end
	end
end

function SW_DumpResultList(...)
	local ret = "";
	for i=1, table.getn(arg) do
		if arg[i] == nil then
			ret = ret.."NIL "; 
		else
			ret = ret.."'"..arg[i].."' "; 
		end
	end
	SW_printStr(ret);
end

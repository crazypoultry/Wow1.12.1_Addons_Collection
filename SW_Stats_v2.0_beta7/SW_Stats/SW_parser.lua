
--[[
	Note to self
	Just noticed through the SpellsNSchools lookup
	there are a few mobs like:
	
	Twilight's Hammer Ambassador
	Jeztor's War Rider 
	etc.
	
	These are problematic - 
	
	(Twilight's Hammer Ambassador's Flame Shock hits you for 1234 fire damage.)
	
	easy fix would be using SW_FixLogStrings for enUS to repalce $s's with $s 's
	A maybe better fix is to change the capture from non greedy (.-) to greedy (.+) on Sources
	This would need extensive testing in ALL languages
	
	Hmm what i did atm is just make it greedy in enUS and enGB check: _initRegEx
	
	recheck what about this?
	
	xyz's Winter's Chill ...
	xyz's Nature's Grasp ...
	
	and how wickid would this be
	Twilight's Hammer Ambassador's Nature's Grasp ...
	Then ill rather have it the old way
	only real way is to replace the 's in the log message to something else using SW_FixLogStrings to
	Twilight's Hammer Ambassador 's Nature's Grasp ...
	
	made FixLogStrings a mini addon so the user can decide.
	
--]]

-- filled what message was removed for another
SW_RemoveList = {};
function SW_ParserGetFinalRep ( msg )
	if SW_RemoveList[msg] then
		return SW_ParserGetFinalRep( SW_RemoveList[msg] );
	end
	return msg;
end
SW_IS_BOOT = true;

--[[ NEVER ever use the numbers in code directly
	They might change withought notice, always do a lookup
--]]
SW_C_Types ={
	validIDs = nil,
	
	Number = {
		Multi = 1000,
		Damage = 1001,
		Heal = 1002,
		LeechFrom = 1003,
		LeechTo = 1004,
		Honor = 1005,
		Skill = 1006,
		Happy = 1007,
		Attacks = 1008,
		Drain = 1009,
		EnviroDmg = 1010,
		Gain = 1011,
		StackCount = 1012,
	},
	String ={
		Multi = 2000,
		Target = 2001,
		Source = 2002,
		School = 2003,
		Skill = 2004,
		--LeechFrom = 2005, -- removed this one, this will always be String.Target (the guy beeing leeched)
		LeechTo = 2006,
		LeechFromWhat = 2007,
		LeechToWhat = 2008,
		DrainWhat = 2009,
		GainWhat = 2010,
		PVPRank = 2011,
	},
	Other = {
		Multi = 3000,
		Trailers = 3001,
	},
	Events = {
		-- Note to self: This order also defines event processing order
		-- it's the second order attribute in the dispatcher, prio is first
		
		Core = 10000,
		--[[	not in use atm
		Error = 10110, -- any bad error msgs
		Warning = 10120, -- error msgs that "should be ok" but i have to look at
		Info = 10130, -- general info msgs
		--]]
		-- the following are normal event msgs from a succesfull capture
		All = 11000,
		Dmg = 11100,
		Heal = 11200,
		OtherNumber = 11300, -- any capture with a number but not Dmg Or heal
		OnlyString = 11400, -- Captures without a number
	},
	--[[ Core and SW are in there for a reason, I might use these to preprocces messages
		Please use Extreme and lower for plugins/addons.
		
		Normally this is just dependant on a per addon basis BUT, you could register one function as "Medium"
		Do something in that and register another function at "low" that is dependant on whatever you did in medium
		OR another addon did something in VeryHigh, and your dependent on that, then you can register on High (or lower)
		All in all just do a 
		SW_EventDispatcher:register(SW_Types.Events.WHATINEED,"MY_FUNC");
		and ignore the prios alltogether if you don't have a REALLY good reason to mess with them.
	--]]
	Prio = {
		Core = 29999,
		SW = 28000,
		
		Extreme = 26000,
		VeryHigh = 25000,
		High = 24000,
		Medium = 23000,
		Low = 22000,
		VeryLow = 21000,
	},
	new = function (self, o)
		o = o or {};
		setmetatable(o, self);
		self.__index = self;
		
		
		if not self.validIDs then
			self.validIDs = {};
			for k,v in pairs(self.Number) do
				self.validIDs[v] = "Number."..k;
			end
			for k,v in pairs(self.String) do
				self.validIDs[v] = "String."..k;
			end
			for k,v in pairs(self.Other) do
				self.validIDs[v] = "Other."..k;
			end
			for k,v in pairs(self.Events) do
				self.validIDs[v] = "Events."..k;
			end
			--[[ not using valid IDs on Prios
			for k,v in pairs(self.Prio) do
				self.validIDs[v] = "Prio."..k;
			end
			--]]
		end
		
		
		return o;
	end,
	
	getTypeStr = function(self, ID)
		if ID == nil then
			return nil;
		end
		return self.validIDs[ID];
	end,
	
};
SW_Types = SW_C_Types:new();

--[[ a school ID lookup and masking the global vars of blizz
SPELL_SCHOOL0_CAP = "Physical";
SPELL_SCHOOL0_NAME = "physical";
SPELL_SCHOOL1_CAP = "Holy";
SPELL_SCHOOL1_NAME = "holy";
SPELL_SCHOOL2_CAP = "Fire";
SPELL_SCHOOL2_NAME = "fire";
SPELL_SCHOOL3_CAP = "Nature";
SPELL_SCHOOL3_NAME = "nature";
SPELL_SCHOOL4_CAP = "Frost";
SPELL_SCHOOL4_NAME = "frost";
SPELL_SCHOOL5_CAP = "Shadow";
SPELL_SCHOOL5_NAME = "shadow";
SPELL_SCHOOL6_CAP = "Arcane";
SPELL_SCHOOL6_NAME = "arcane";
SPELL_SCHOOLALL = "all";
SPELL_SCHOOLMAGICAL = "magical";

noticed that "Shoot" with a wand will add a school
and it will be "locked" then in the first school
added an extra check for shoot

--]]
SW_Schools = {
	nameToID = {},
	IDToName = {},
	
	init = function (self)
		local tmpStr
		for i=0, 6 do
			tmpStr = getglobal("SPELL_SCHOOL"..i.."_CAP");
			self.nameToID[tmpStr] = i;
			self.IDToName[i] = tmpStr;
			tmpStr = getglobal("SPELL_SCHOOL"..i.."_NAME");
			self.nameToID[tmpStr] = i;
		end
		-- for completeness probably not going to use these
		-- leave a gap in case blizzard adds other schools
		-- Note to self: using 200 as a dummy for "no school"
		self.nameToID[SPELL_SCHOOLALL] = 100;
		self.IDToName[100] = SPELL_SCHOOLALL;
		self.nameToID[SPELL_SCHOOLMAGICAL] = 101;
		self.IDToName[101] = SPELL_SCHOOLMAGICAL;
		
		self.IDToName[200] = SW_PRINT_ITEM_NON_SCHOOL;
		self.nameToID[SW_PRINT_ITEM_NON_SCHOOL] = 200;
		
		self.IDToName[300] = SW_STR_ENVIRO;
		self.nameToID[SW_STR_ENVIRO] = 300;
	end,	
	
	getID = function (self, str)
		return self.nameToID[str];
	end,
	
	getStr = function(self, ID)
		return self.IDToName[ID];
	end,
}

--[[
	point here is to automatically build a spell->school lookup
	on resist messages you only have the spell but not the school
	on most damage messages you have spell and school
	if the school is missing (but has a skill) its most likely physical damage
	I'm still going to use the old SW_Stats "Other" because e.g. "Rend" and "Deep Wound" Directly use Physical
	Internally the parser will only work with the IDs, although the basicData will return both string and ID
--]]
SW_C_SpellsNSchools = {
	
	revLookup = {},
	
	new = function (self, o)
		local init = false;
		if o then
			init = true;
		else
			o = {};
		end
		
		setmetatable(o, self);
		self.__index = self;
		
		if init then
			for k,v in pairs(o) do
				for i,skill in ipairs(v) do
					self.revLookup[skill] = k;
				end
			end
		end
		
		return o;
	end,
	
	getSchoolID = function (self, skillName)
		return self.revLookup[skillName];
	end,
	
	checkResult = function (self, v)
		local ID;
		local skill = v.Skill;
		
		
		if skill and (skill == SW_MAP_SKILL_DMGSHIELD or skill == SW_CL_SHOOT) then
			if v.School then
				ID = SW_Schools.nameToID[v.School];
			else
				ID = 200; -- 200 is a dummy school for "no school"
			end
			v.SchoolID = ID;
			return;
		end
		
		if skill then
			ID = self.revLookup[skill];
			if ID then
				v.SchoolID = ID;
				return;
			end
		end
		
		if v.School then
			ID = SW_Schools.nameToID[v.School];
		else
			ID = 200; -- 200 is a dummy school for "no school"
		end
		
		if skill and ID and (not v.IsDmgNullify) then
			if not self[ID] then self[ID] = {}; end
			table.insert(self[ID], skill);
			self.revLookup[skill] = ID;
		end
		v.SchoolID = ID;
	end,	
}

SW_EventDispatcher = {
	
	eventHooks = {},
	
	dispatch = function (self, oMsg)
		-- don't dispatch anything during init
		-- the "fix" functions would dispatch odd data otherwise
		if SW_IS_BOOT then return; end
		
		local ev = SW_Types.Events;
		
		for k,t in ipairs(self.eventHooks) do
			if t[2] == ev.Core then
				t[3](oMsg);
			elseif t[2] == ev.All then
				t[3](oMsg);
			elseif t[2] == ev.Dmg then
				if oMsg.IsDmg then
					t[3](oMsg);
				end
			elseif t[2] == ev.Heal then
				if oMsg.IsHeal then
					t[3](oMsg);
				end
			elseif t[2] == ev.OtherNumber then
				if not oMsg.OnlyStrings then
					t[3](oMsg);
				end
			elseif t[2] == ev.OnlyString then
				if oMsg.OnlyStrings then
					t[3](oMsg);
				end
			end
		end
	end,
	
	register = function (self, listenToType, funcName, prio)
		func = getglobal(funcName);
		-- if this happens recheck load order of your addon
		assert(func, "SW_EventDispatcher:register function 'pointer' is invalid\r\n"..debugstack(2,1,0));
		local evSort = function (a,b)
			if a[1] == b[1] then
				return a[2] < b[2];
			end
			return a[1] < b[1];
		end
		if prio == nil then
			prio = SW_Types.Prio.Medium;
		end
		table.insert(self.eventHooks, {prio, listenToType, func} );
		table.sort(self.eventHooks, evSort);
	end,
};

function SW_AddToDC(oMsg)
	SW_DataCollection:addMsg(oMsg);
end
SW_EventDispatcher:register(SW_Types.Events.All,"SW_AddToDC",SW_Types.Prio.SW);

function SW_DoLocalDPS(oMsg)
	local v = oMsg:getBasicData();
	if not (v and v.Source) or v.Source ~= SW_SELF_STRING  or not v.Damage then return end;
	if SW_CombatTimeInfo.awaitingStart then
		SW_CombatTimeInfo.awaitingEnd = true;
		SW_CombatTimeInfo.awaitingStart = false;
	end
	SW_DPS_Dmg = SW_DPS_Dmg + v.Damage;
end
SW_EventDispatcher:register(SW_Types.Events.Dmg,"SW_DoLocalDPS",SW_Types.Prio.SW - 10);


--[[
	could use this "%(%+?(%d*)%s?(.-)%)" in enUS
	as regex and use gfind but it isn't as safe
	the following works in all locales
--]]
SW_C_TrailerInfo = {
	trailersRegEx = {},
	trailersInited = false,
	
	lastData = {
		Absorb = 0,
		Block = 0,
		Crushing = 0,
		Glancing = 0,
		Resist = 0,
		--Vulnerable = 0,
	},
	new = function (self, o)
		o = o or {};
		setmetatable(o, self);
		self.__index = self;
		 
		if not self.trailersInited then
			-- added in order of occurance #
			self:createRegEx("RESIST_TRAILER", "Resist");
			self:createRegEx("GLANCING_TRAILER", "Glancing");
			self:createRegEx("BLOCK_TRAILER", "Block");
			self:createRegEx("ABSORB_TRAILER", "Absorb");
			self:createRegEx("CRUSHING_TRAILER", "Crushing");
			-- is this even used by wow ? had 0 occurances in 16k trailers
			-- I THINK this was for negativ resistances that have been removed a while ago
			--self:createRegEx("VULNERABLE_TRAILER", "Vulnerable");
			self.trailersInited = true;
		end
		
		return o;
	end,
	
	createRegEx = function(self, varName, info)
		local strVar = getglobal(varName);
		if not strVar then return; end
		
		strVar = string.gsub(strVar, "([%.%(%)%+%-%?%[%]%^])", "%%%1");
		local hasNumber = false;
		
		strVar = string.gsub(strVar, '(%%(%d?)$?([sd]))',
			function(all,num,type) -- e.g. %3$s all = %3$s  num=3 type=s
				if type == 's' then
					return '(.-)';
				else
					hasNumber = true;
					return '(%d+)';
				end
			end);
		
		table.insert(self.trailersRegEx,{["hasNumber"] = hasNumber, ["regEx"] = strVar, ["info"] = info, [info] = true});
	end,
	
	checkTrailer = function (self, trailerStr)
		local n1, n2, val;
		local sLen = string.len(trailerStr);
		local ld = self.lastData;
		
		ld.Absorb = 0;
		ld.Block = 0;
		ld.Crushing = 0;
		ld.Glancing = 0;
		ld.Resist = 0;
		--ld.Vulnerable = 0;
		
		for i,v in ipairs(self.trailersRegEx) do
			n1,n2,val = string.find(trailerStr, v.regEx);
			
			if n1 then
				if val then
					ld[v.info] = tonumber(val);
				else
					ld[v.info] = 1;
				end
				--90% of the time we only have one trailer
				if n1 == 1 and n2 == sLen then
					break;
				end
			end
		end
	end,
}

-- do NOT save any objects of this type
-- a reinit on restart is very important
SW_C_Message = {
	famRegExSS = "(.-)SELFSELF",
	famRegExSO = "(.-)SELFOTHER",
	famRegExOS = "(.-)OTHERSELF",
	famRegExOO = "(.-)OTHEROTHER",
	
	lastData = {},
	
	new = function (self, varName, o)
		--local strMsg = getglobal(varName);

		--check if we are trying to work on a global thats not available
		-- don't assert here (eg a new version of WOW removed a message)
		
		-- moved _initRegEx to finalizeInit
		-- only then the types are set
		--[[
		if strMsg == nil then 
			SW_DBG("SW_C_Message varName NIL: "..varName);
			return nil;
		end;
		--]]
		
		o = o or {};
		setmetatable(o, self);
		self.__index = self;
		
		if not self.oTrailer then
			self.oTrailer = SW_C_TrailerInfo:new();	
		end
		if not o.CaptureTypes then
			o.CaptureTypes = {};
			o.Message = varName;
			o.BasicDirty = true;
			
		end
		--o:_initRegEx(strMsg);
		
		return o;
	end,
	_initRegEx = function(self, strMsg)
		assert(self.Message, "_initRegEx Message is NIL");
		--fixes ambiguous strings
		-- SW_FixLogStrings is a localized function
		local strLogString = SW_FixLogStrings(strMsg);
		local index = 0;
		local map = {};
		local needsMap = false;
		local famStr;
		
		--[[
			Might remove the whole family thing, wanted to use it for sorting the
			map at frist.
		--]]
		_,_, famStr = string.find(self.Message, self.famRegExSS);
		if famStr then
			self.fam = famStr;
			self.relation = 5;
		else
			_,_, famStr = string.find(self.Message, self.famRegExSO);
			if famStr then
				self.fam = famStr;
				self.relation = 7;
			else
				_,_, famStr = string.find(self.Message, self.famRegExOS);
				if famStr then
					self.fam = famStr;
					self.relation = 3;
				else
					_,_, famStr = string.find(self.Message, self.famRegExOO);
					if famStr then
						self.fam = famStr;
						self.relation = 4;
					end
				end
			end
		end
		
		if strLogString ~= strMsg then
			setglobal(self.Message, strLogString);
		end
		
		-- first we have to "sanitze" the string  ^()%.[]*+-?  are special chars in a regex (dont escape the $ and %)
		-- so we are escaping these with %
		local sTmp = strLogString;
		strLogString = string.gsub(strLogString, "([%*%.%(%)%+%-%?%[%]%^])", "%%%1");
		
		
		-- the inner function actually does the work
		strLogString = string.gsub(strLogString, '(%%(%d?)$?([sd]))',
			function(all,num,type) -- e.g. %3$s all = %3$s  num=3 type=s
				index = index+1;
				if num == "" then
					num = index;
				end
				map[index] = tonumber(num);
				--this is the actual replacement that makes the regex
				-- use non greedy for strings
				if type == 's' then
					return '(.-)';
				else
					return '(%d+)';
				end
			end);
		
		local ti = 0;
		sTmp = string.gsub(sTmp, '(%%(%d?)$?([sd]))',
			function(all,num,type) -- e.g. %3$s all = %3$s  num=3 type=s
				
				--this is the actual replacement that makes the regex
				-- use non greedy for strings
				if type == 's' then
					ti = ti+1;
					--return (string.rep(string.char(math.random(97,122)), math.random(3,5)));
					return "STRING";
				else
					--return (math.random(1000));
					return 1234;
				end
			end);
		self.testStr = string.gsub(sTmp, "%%%%", "%%");
		
		self.CaptureAmount = index;
		
		for i,v in ipairs(map) do
			if i ~= v then
				needsMap = true;
				break;
			end
		end
		if needsMap then
			self.resortMap = map;
		end
		self.regEx = "^"..strLogString;
	end,
	createIndices = function (self)
		if self.IsDmg then
			self.IndexDmg = self.TypeToCapture[SW_Types.Number.Damage];
		elseif self.IsEnviro then
			self.IndexDmg = self.TypeToCapture[SW_Types.Number.EnviroDmg];
		end
		
		self.IndexHeal = self.TypeToCapture[SW_Types.Number.Heal];
		self.IndexSource = self.TypeToCapture[SW_Types.String.Source];
		self.IndexTarget = self.TypeToCapture[SW_Types.String.Target];
		self.IndexSkill = self.TypeToCapture[SW_Types.String.Skill];
		self.IndexSchool = self.TypeToCapture[SW_Types.String.School];
		
	end,
	addTrailerInfo = function (self)
		self.CanHaveTrailer = false;
		
		if self.IsDmg or self.IsEnviro then
			self.CanHaveTrailer = true;
			
			self.regEx = self.regEx.."(.*)";
			self.CaptureAmount  = self.CaptureAmount + 1;
			table.insert(self.CaptureTypes, SW_Types.Other.Trailers);
			self.TypeToCapture[SW_Types.Other.Trailers] = self.CaptureAmount;
			
			-- shouldn't be needed but why not to be safe
			self.testStr = self.testStr.."TrailerTest";
		end
	end,
	finalizeInit = function(self)
		local strMsg = getglobal(self.Message);

		--check if we are trying to work on a global thats not available
		-- don't assert here (eg a new version of WOW removed a message)
		
		if strMsg == nil then 
			SW_DBG("SW_C_Message:finalizeInit strMsg NIL: "..self.Message);
			return nil;
		end;
		
		self:_initRegEx(strMsg);
		
		if (not self.CaptureAmount) or self.CaptureAmount > 9 then
			return false;
		end
		if table.getn(self.CaptureTypes) ~= self.CaptureAmount then
			return false;
		end
		
		if self.resortMap ~= nil then 
			--[[
			if self.Message == "SPELLPOWERLEECHOTHEROTHER" then
				SW_printStr("----"..self.Message);
				SW_DumpMessageTable(self);
			end
			--]]
			local tmpCap = {};
			for orig, new in ipairs(self.resortMap) do
				tmpCap[orig] = self.CaptureTypes[new];
			end
			self.CaptureTypes = tmpCap;
			self.resortMap = nil;
			--[[
			if self.Message == "SPELLPOWERLEECHOTHEROTHER" then
				SW_printStr("----AFTER SORT");
				SW_DumpMessageTable(self);
			end
			--]]
		end
		
		
		-- dont Nil these
		self.IsDmg = false;
		self.IsHeal = false;
		self.IsDrain = false;
		self.IsLeech = false;
		self.IsEnviro = false;
		self.IsGain = false;
		self.IsExtraAttack = false;
		self.OnlyStrings = true;
		
		self.TypeToCapture = {};
		
		for i,v in ipairs(self.CaptureTypes) do
			if v == SW_Types.Number.Damage then
				self.IsDmg = true;
			elseif v == SW_Types.Number.Heal then
				self.IsHeal = true;
			elseif v == SW_Types.Number.Drain then
				self.IsDrain = true;
			elseif v == SW_Types.Number.LeechFrom then
				self.IsLeech = true;
			elseif v == SW_Types.Number.LeechTo then
				self.IsLeech = true;
			elseif v == SW_Types.Number.EnviroDmg then
				self.IsEnviro = true;
			elseif v == SW_Types.Number.Gain then
				self.IsGain = true;
			elseif v == SW_Types.Number.Attacks then
				self.IsExtraAttack = true;
			end
			if v > 999 and v < 2000 then
				self.OnlyStrings = false;
			end
			self.TypeToCapture[v] = i;
		end
		-- add trailer capture to dmg events eg. (123 resisted)
		self:addTrailerInfo();
		
		if self.CaptureAmount > 9 then
			return false;
		end
		-- afiak this doesn't happen but better to make sure
		-- never know if they forget a "." or something else at the end of a string
		-- replaces a regEx ending in (.-) with (.+)
		self.regEx = (string.gsub(self.regEx, "%(%.%-%)$", "(.+)"));
		
		self:createIndices();
		
		self.LastCapture = {};
		self.LastHadTrailer = false;
		
		if self.CaptureAmount == 0 then
			self.DoStr = self.chk0;
		elseif self.CaptureAmount == 1 then
			self.DoStr = self.chk1;
		elseif self.CaptureAmount == 2 then
			self.DoStr = self.chk2;
		elseif self.CaptureAmount == 3 then
			self.DoStr = self.chk3;
		elseif self.CaptureAmount == 4 then
			self.DoStr = self.chk4;
		elseif self.CaptureAmount == 5 then
			self.DoStr = self.chk5;
		elseif self.CaptureAmount == 6 then
			self.DoStr = self.chk6;
		elseif self.CaptureAmount == 7 then
			self.DoStr = self.chk7;
		elseif self.CaptureAmount == 8 then
			self.DoStr = self.chk8;
		elseif self.CaptureAmount == 9 then
			self.DoStr = self.chk9;
		end
		return true;
	end,
	addCapture = function (self, capType)
		assert(SW_Types:getTypeStr(capType), "addCapture capType is invalid\r\n"..debugstack(2,1,0));
		table.insert(self.CaptureTypes, capType);
	end,
	setCaptures = function(self, ...)
		self.CaptureTypes = {};
		for i,capType in ipairs(arg) do
			assert(SW_Types:getTypeStr(capType), "setCaptures capType is invalid\r\n"..debugstack(2,1,0));
			table.insert(self.CaptureTypes, capType);
		end
	end,
	--[[ this sort is "ok" but not perfect, it will do a "basic" sort
		The "fix" functions do the rest of the work
		It will also put less complex regex first (performance)
	--]]
	__lt = function(lh, rh)
	
		local sl = string.sub(lh.regEx,2,2);
		local sr = string.sub(rh.regEx,2,2);
		
		if sl == "(" and sr == "(" then
			if lh.CaptureAmount == rh.CaptureAmount then
					return (string.len(rh.regEx) < string.len(lh.regEx));
				else
					--if lh.fam and (lh.fam == rh.fam) then
					--[[
					if lh.fam and rh.fam then
						return lh.relation < rh.relation;
					end
					--]]
					return (rh.CaptureAmount > lh.CaptureAmount);
				end
		else
			if sl == "(" then
				return false;
			elseif sr == "(" then
				return true;
			else
				
				if lh.CaptureAmount == rh.CaptureAmount then
					return (string.len(rh.regEx) < string.len(lh.regEx));
				else
					--if lh.fam and (lh.fam == rh.fam) then
					--[[
					if lh.fam and rh.fam then
						return lh.relation < rh.relation;
					end
					--]]
					return (rh.CaptureAmount > lh.CaptureAmount);
				end
			end
		end
	end,

	chk0 = function (self, str)
		self.BasicDirty = true;
		local n1, n2;
		n1, n2 = string.find(str, self.regEx );
		if (n1 == 1) and (n2 == string.len(str)) then
			SW_EventDispatcher:dispatch(self);
			return true;
		end
		return false;
	end,
	
	chk1 = function (self, str)
		self.BasicDirty = true;
		
		local v = self.LastCapture;
		local n1, n2;
		n1, n2 ,v[1] = string.find(str, self.regEx );
		if n1 then
			SW_EventDispatcher:dispatch(self);
			return true;
		else
			return false;
		end
	end,
	chk2 = function (self, str)
		self.BasicDirty = true;
		
		local v = self.LastCapture;
		local n1, n2;
		n1, n2 ,v[1], v[2] = string.find(str, self.regEx );
		if n1 then
			if self.CanHaveTrailer then				
				if v[2] ~= "" then
					self.LastHadTrailer = true;
					self.oTrailer:checkTrailer(v[2]);
				elseif self.LastHadTrailer then
					self.LastHadTrailer = false;
				end
				SW_EventDispatcher:dispatch(self);
				return true;			
			else				
				SW_EventDispatcher:dispatch(self);
				return true;			
			end
		end
		return false;
	end,
	chk3 = function (self, str)
		self.BasicDirty = true;
		
		local v = self.LastCapture;
		local n1, n2;
		n1, n2 ,v[1], v[2], v[3] = string.find(str, self.regEx );
		if n1 then
			if self.CanHaveTrailer then				
				if v[3] ~= "" then
					self.LastHadTrailer = true;
					self.oTrailer:checkTrailer(v[3]);
				elseif self.LastHadTrailer then
					self.LastHadTrailer = false;
				end
				SW_EventDispatcher:dispatch(self);
				return true;				
			else				
				SW_EventDispatcher:dispatch(self);
				return true;				
			end
		end
		return false;
	end,
	chk4 = function (self, str)
		self.BasicDirty = true;
		
		local v = self.LastCapture;
		local n1, n2;
		n1, n2 ,v[1], v[2], v[3], v[4] = string.find(str, self.regEx );
		if n1 then
			if self.CanHaveTrailer then				
				if v[4] ~= "" then
					self.LastHadTrailer = true;
					self.oTrailer:checkTrailer(v[4]);
				elseif self.LastHadTrailer then
					self.LastHadTrailer = false;
				end
				SW_EventDispatcher:dispatch(self);
				return true;			
			else				
				SW_EventDispatcher:dispatch(self);
				return true;			
			end
		end
		return false;
	end,
	chk5 = function (self, str)
		self.BasicDirty = true;
		
		local v = self.LastCapture;
		local n1, n2;
		n1, n2 ,v[1], v[2], v[3], v[4], v[5] = string.find(str, self.regEx );
		if n1 then
			if self.CanHaveTrailer then
				if v[5] ~= "" then
					self.LastHadTrailer = true;
					self.oTrailer:checkTrailer(v[5]);
				elseif self.LastHadTrailer then
					self.LastHadTrailer = false;
				end
				SW_EventDispatcher:dispatch(self);
				return true;
			else
				SW_EventDispatcher:dispatch(self);
				return true;
			end
		end
		return false;
	end,
	chk6 = function (self, str)
		self.BasicDirty = true;
		
		local v = self.LastCapture;
		local n1, n2;
		n1, n2 ,v[1], v[2], v[3], v[4], v[5], v[6] = string.find(str, self.regEx );
		if n1 then
			if self.CanHaveTrailer then
				if v[6] ~= "" then
					self.LastHadTrailer = true;
					self.oTrailer:checkTrailer(v[6]);
				elseif self.LastHadTrailer then
					self.LastHadTrailer = false;
				end
				SW_EventDispatcher:dispatch(self);
				return true;
			else
				SW_EventDispatcher:dispatch(self);
				return true;
			end
		end
		return false;
	end,
	chk7 = function (self, str)
		self.BasicDirty = true;
		
		local v = self.LastCapture;
		local n1, n2;
		n1, n2 ,v[1], v[2], v[3], v[4], v[5], v[6], v[7] = string.find(str, self.regEx );
		if n1 then
			if self.CanHaveTrailer then
				if v[7] ~= "" then
					self.LastHadTrailer = true;
					self.oTrailer:checkTrailer(v[7]);
				elseif self.LastHadTrailer then
					self.LastHadTrailer = false;
				end
				SW_EventDispatcher:dispatch(self);
				return true;
			else
				SW_EventDispatcher:dispatch(self);
				return true;
			end
		end
		return false;
	end,
	chk8 = function (self, str)
		self.BasicDirty = true;
		
		local v = self.LastCapture;
		local n1, n2;
		n1, n2 ,v[1], v[2], v[3], v[4], v[5], v[6], v[7], v[8] = string.find(str, self.regEx );
		if n1 then
			if self.CanHaveTrailer then		
				if v[8] ~= "" then
					self.LastHadTrailer = true;
					self.oTrailer:checkTrailer(v[8]);
				elseif self.LastHadTrailer then
					self.LastHadTrailer = false;
				end
				SW_EventDispatcher:dispatch(self);
				return true;		
			else		
				SW_EventDispatcher:dispatch(self);
				return true;
			end
		end
		return false;
	end,
	chk9 = function (self, str)
		self.BasicDirty = true;
		
		local v = self.LastCapture;
		local n1, n2;
		n1, n2 ,v[1], v[2], v[3], v[4], v[5], v[6], v[7], v[8], v[9] = string.find(str, self.regEx );
		if n1 then
			if self.CanHaveTrailer then			
				if v[9] ~= "" then
					self.LastHadTrailer = true;
					self.oTrailer:checkTrailer(v[9]);
				elseif self.LastHadTrailer then
					self.LastHadTrailer = false;
				end
				SW_EventDispatcher:dispatch(self);
				return true;			
			else			
				SW_EventDispatcher:dispatch(self);
				return true;			
			end
		end
		return false;
	end,
	
	getBasicData = function (self)
		local v = self.lastData;
		
		--[[ i added this dirty flag
			point is just process the first call of getBasicData fully (after a capture)
			on following calls return what we have until its dirty again
			
			Not sure if i want to keep it this way - possible to change the data
			but its simple and fast just to return the data table on multiple calls
			(possible  "fix" add self.retData and always copy lastData ->  retData)
		--]]
		if self.BasicDirty then
			v.Source = self:getSource();
			v.Target = self:getTarget();
			v.Damage = self:getDmg();
			v.Heal = self:getHeal();
			v.Skill = self:getSkill();
			v.School = self:getSchool();
			v.IsCrit = self.IsCrit;
			v.FromSelf = self.FromSelf;
			v.ToSelf = self.ToSelf;
			v.IsDmgNullify = self.IsDmgNullify;
			
			if self.LastHadTrailer then
				v.Trailer = self.oTrailer.lastData;
			else
				v.Trailer = false;
			end
			if v.Damage and (v.Source == v.Target) then
				v.ScrapDamage = true;
			else
				v.ScrapDamage = false;
			end
			
			-- this starts the timer
			if v.Damage and not self.IsEnviro 
				and (SW_DataCollection.meta.currentGroup[v.Source] 
					or SW_DataCollection.meta.currentPets[v.Source]) then
				SW_RPS:validEvent();
			--if we are already in a fight allow Damage taken to reset the timer
			elseif SW_RPS.isRunning and v.Damage 
					and (SW_DataCollection.meta.currentGroup[v.Target] 
						or SW_DataCollection.meta.currentPets[v.Target]) then
				SW_RPS:validEvent();
			end
			
			-- are we in a fight ?
			if SW_RPS.isRunning then
				v.inF = true;
			else
				v.inF = false;
			end
			if v.Heal then
				self:setHealInfo(v);
			else
				v.EffectiveHeal = 0;
				v.Overheal = 0;
			end
			if v.Damage or v.IsDmgNullify then
				if v.Skill or v.School then
					SW_SpellsNSchools:checkResult(v);
				elseif self.IsEnviro then
					v.SchoolID = 300;
				else
					-- potentially wrong if the very first time a skill is found
					-- and it was resisted. absorbed etc In the long run this is so small it's np
					v.SchoolID = 200;
				end
			else
				v.SchoolID = false;
			end
			v.IsDecurse = false;
			if self.IsCast then
				--SW_printStr("DecurseCheck SWParser:getBasicData IsCast");
				--SW_printStr(v.Skill);
				 if SW_SpellIDLookUp[v.Skill] and SW_SpellIDLookUp[v.Skill] < 11 then
					--SW_printStr("DecurseCheck SWParser:getBasicData IsDecurse");
					v.IsDecurse = true;
				 end
			end
			--[[
			if self.IsCast and v.FromSelf then
				
				SW_printStr("SWParser:getBasicData  cast from self "..v.Skill);
				SW_printStr("msg:"..self.Message);
				if event then
					SW_printStr("ev:"..event);
				end
			end
			--]]
			if self.IsPeriodic then
				v.IsPeriodic = true;
			else
				v.IsPeriodic = false;
			end
			
			self.BasicDirty = false;
		end
		return v;
	end,
	setHealInfo = function (self, v, isRetry)
		local uID = SW_DataCollection.meta:getUnitID(v.Target);
		
		if uID then
			if (UnitName(uID)) ~= v.Target then
				if isRetry then
					SW_DBG("This shouldn't happen: setHealInfo "..(UnitName(uID)).." ~= "..v.Target);
					v.Overheal = 0;
					v.EffectiveHeal = v.Heal;
				else
					SW_DBG("Rebuilding Meta info in setHealInfo");
					SW_DataCollection.meta:updateGroupRaid();
					self:setHealInfo(v, true);
				end
			else
				local num = UnitHealthMax(uID) - UnitHealth(uID) - v.Heal;
				if num < 0 then
					num = num * (-1);
					v.Overheal = num;
					v.EffectiveHeal = v.Heal - num;
				else
					v.Overheal = 0;
					v.EffectiveHeal = v.Heal;
				end
			end
		else
			v.Overheal = 0;
			v.EffectiveHeal = v.Heal;
		end
	end,
	
	-- This should only be used for anything but the standard stuff
	-- use getBasicData instead
	getData = function (self, ID)
		local index = self.TypeToCapture[ID];
		
		if index then
			if ID > 999 and ID < 2000 then
				return tonumber(self.LastCapture[index]);
			else
				return self.LastCapture[index];
			end
		end
		return nil;
	end,
	
	getDmg = function (self)
		if self.IndexDmg then
			return tonumber(self.LastCapture[ self.IndexDmg ]);
		end
		return false;
	end,
	getHeal = function (self)
		if self.IsHeal  then 
			return tonumber(self.LastCapture[ self.IndexHeal ]);
		end
		return false;
	end,
	getSource = function (self)
		if self.IndexSource then
			return self.LastCapture[ self.IndexSource ];
		end
		
		if self.FromSelf then
			return SW_SELF_STRING;
		end
		
		return SW_WORLD;
	end,
	getTarget = function (self)
		if self.IndexTarget then
			return self.LastCapture[ self.IndexTarget ];
		end
		
		if self.ToSelf then
			return SW_SELF_STRING;	
		end
		
		return SW_WORLD;
	end,
	getSkill = function (self)
		if self.IndexSkill then
			return self.LastCapture[ self.IndexSkill ];
		elseif self.MapToSkill then
			return self.MapToSkill;
		end
		return false;
	end,
	getSchool = function (self)
		if self.IndexSchool then
			return self.LastCapture[ self.IndexSchool ];
		end
		return false;
	end,
	
	setCrit = function(self, val)
		if val then
			self.IsCrit = true;
		else
			self.IsCrit = nil;
		end
	end,
	getCrit = function(self)
		return self.IsCrit;
	end,
	setLateSort = function(self, val)
		if val then
			self.LateSort = true;
		else
			self.LateSort = nil;
		end
	end,
	getLateSort = function(self)
		return self.LateSort;
	end,
	setFromSelf = function(self, val)
		if val then
			self.FromSelf = true;
		else
			self.FromSelf = nil;
		end
	end,
	getFromSelf = function(self)
		return self.FromSelf;
	end,
	setToSelf = function(self, val)
		if val then
			self.ToSelf = true;
		else
			self.ToSelf = nil;
		end
	end,
	getToSelf = function(self)
		return self.ToSelf;
	end,
	
	dump = function (self)
		SW_DumpTable(self);
	end,
	dumpLastCap = function (self)
		local to = self.CaptureAmount;
		if self.CanHaveTrailer then
			to = to - 1;
		end
		for i=1, to do
			SW_Event_Channel:AddMessage(self.LastCapture[i]);
		end
		if self.CanHaveTrailer and self.LastHadTrailer then
			for k,v in pairs(self.oTrailer.lastData) do
				if v > 0 then
					SW_Event_Channel:AddMessage(k.." "..v);
				end
			end
		end
	end,
};

--[[
	Everything comes together here
	
--]]
SW_C_Parser = {
	
	oMap = {},
	new = function (self, o)
		local createOM = false;
		if o then
			createOM = true;
		else
			o = {};
			o.eventMap = {};
			o.fallbackBlock = {};
		end
		
		setmetatable(o, self);
		self.__index = self;
		
		local potTarget;
		if createOM then
			for k, v in pairs(o.eventMap) do
				self.oMap[k] = SW_C_MessageList:new();
				SW_TESTSWITCH = (k =="CHAT_MSG_COMBAT_PET_HITS");
				--2.0 beta.4 we need to replace items 
				for i= table.getn(v), 1, - 1 do
					if not SW_C_MessageList.masterOrder[ v[i] ] then
						potTarget = SW_ParserGetFinalRep( v[i] );
						if SW_C_MessageList.masterOrder[ potTarget ] then
							v[i] = potTarget;
						else
							table.remove(v,i);
						end
					end
				end
				self.oMap[k]:addList(v, k);
			end
		end
		
		return o;
	end,
	
	--[[
		there is no real reason to use this in live
		it will always use the master list and is thought to be used to 
		create a DefaultParser we need to have all (or close to all)
		messages to avoid collisions in events and unneded blocking
	--]]
	DEVhandleEvent = function(self, eventName, msg)
		local brother = "";
		local foundBrother = false;
		local inMap = false;
		--SW_printStr(msg);
		
		for i,v in ipairs(SW_C_MessageList.masterList) do 
			if v:DoStr(msg) then
				--SW_printStr(v.regEx);
				--SW_DumpTable(v.LastCapture);
				if not self.eventMap[eventName] then
					self.eventMap[eventName] = {};
				end
				
				for n,val in ipairs(self.eventMap[eventName]) do
					if val == v.Message then
						inMap = true;
						break;
					end
				end
				if not inMap then
					table.insert(self.eventMap[eventName], v.Message);
					brother = SW_C_MessageList.brotherList[v.Message];
					if brother then
						for n,val in ipairs(self.eventMap[eventName]) do
							if val == brother then
								foundBrother = true;
								break;
							end
						end
						if not foundBrother then
							table.insert(self.eventMap[eventName], brother);
						end
					end
				end
				if SW_EI_ALLOFF then return; end
				if SW_Settings["EI_ShowEvent"] then
					SW_Event_Channel:AddMessage(GREEN_FONT_COLOR_CODE..eventName.."->"..v.Message);
				end
				if SW_Settings["EI_ShowRegEx"] then
					SW_Event_Channel:AddMessage(LIGHTYELLOW_FONT_COLOR_CODE..v.regEx);
				end
				if SW_Settings["EI_ShowOrigStr"] then
					SW_Event_Channel:AddMessage(msg);
				end
				if SW_Settings["EI_ShowMatch"] then
					v:dumpLastCap();
				end
				return;
			end
		end
	end,
	
	handleEvent = function(self, eventName, msg)
		if self.eventMap[eventName] == nil then
			self.eventMap[eventName] = {};
			self.oMap[eventName] = SW_C_MessageList:new();
			self:handleUnknown(eventName, msg);
			return;
		end 
		local ml = self.oMap[eventName];
		local isUnknown = true;
		
		for i,v in ipairs(ml.localMsgs) do 
			if v:DoStr(msg) then
				isUnknown = false;
				if not SW_EI_ALLOFF then
					if SW_Settings["EI_ShowEvent"] then
						SW_Event_Channel:AddMessage(GREEN_FONT_COLOR_CODE..eventName.."->"..v.Message);
					end
					if SW_Settings["EI_ShowRegEx"] then
						SW_Event_Channel:AddMessage(LIGHTYELLOW_FONT_COLOR_CODE..v.regEx);
					end
					if SW_Settings["EI_ShowOrigStr"] then
						SW_Event_Channel:AddMessage(msg);
					end
					if SW_Settings["EI_ShowMatch"] then
						v:dumpLastCap();
					end
				end
				break;
			end
		end
		if isUnknown then
			SW_printStr(RED_FONT_COLOR_CODE..eventName);
			SW_printStr(RED_FONT_COLOR_CODE.."      "..msg);
			if self.fallbackBlock[eventName] then
				--[[
					An event is producing messages we should be checking but are not
					To prevent going through the entire masterList each time, a block is added in self:handleUnknown
					
				--]]
				SW_printStr(RED_FONT_COLOR_CODE.."      "..SW_FALLBACK_BLOCK_INFO);
				SW_printStr(RED_FONT_COLOR_CODE.."      "..SW_CONSOLE_NOREGEX);
				SW_printStr(RED_FONT_COLOR_CODE.."      SOURCE:"..self.fallbackBlock[eventName]);
			else
				self:handleUnknown(eventName, msg);
			end
		end	
		
	end,
	
	handleUnknown = function(self, eventName, msg)
		local blockMe = true;
		local brother = "";
		local foundBrother = false;
		-- revert to masterList
		-- adding the brothers here is not really necesarry
		-- the MessageList handels it correctly, but lets be thourough
		for i,v in ipairs(SW_C_MessageList.masterList) do 
			if v:DoStr(msg) then
				table.insert(self.eventMap[eventName], v.Message);
				brother = SW_C_MessageList.brotherList[v.Message];
				if brother then
					for i,v in ipairs(self.eventMap[eventName]) do
						if v == brother then
							foundBrother = true;
							break;
						end
					end
					if not foundBrother then
						table.insert(self.eventMap[eventName], brother);
					end
				end
				-- the add will handle the brother itself
				self.oMap[eventName]:add(v.Message);
				blockMe = false;
				SW_printStr(GREEN_FONT_COLOR_CODE.."      "..SW_CONSOLE_FALLBACK);
				break;
			end
		end
		if blockMe then
			SW_printStr(RED_FONT_COLOR_CODE.."      "..SW_CONSOLE_NOREGEX);
			self.fallbackBlock[eventName] = msg;
		end
	end,
	
	getML = function (self, eventName)
		return self.oMap[eventName];
	end,
}

-- dont save lists directly
-- you could but dumps the entire message objects aswell

SW_C_MessageList = {
	globalMessages = {},
	masterOrder = {},
	masterList = {};
	brotherList = {},
	
	new = function (self, o)
		local init = true;
		if o then
			init = false;
		else
			o = {};
		end
		
		setmetatable(o, self);
		self.__index = self;
		
		if init then
			o.localMsgs = {};
		else
			table.sort(o.localMsgs, function (a,b)
					return (self.masterOrder[a.Message] or 0)  < (self.masterOrder[b.Message] or 0);
				end)
		end 
		
		return o;
	end,
	addList = function (self, list, eventName)
		local target;
		local tmpLookup = {};
		
		for i, v in ipairs(list) do
			target = self.globalMessages[v];
			if target ~= nil then
				tmpLookup[v] = true;
				table.insert( self.localMsgs, target );
			end
		end
		-- check if brothers are there
		for i, v in ipairs(list) do
			target = self.globalMessages[v];
			if target ~= nil then
				if self.brotherList[v] then
					if not tmpLookup[ self.brotherList[v] ] then
						-- brother was not in list
						target = self.globalMessages[ self.brotherList[v] ];
						if target ~= nil then
							table.insert( self.localMsgs, target );
						end
					end
				end	
			end
		end
		
		--[[ in the master order there MAY be a message that had to be removed in this locale
			that's why there is the "or 0" in there (it won't be in the master order - it will be nil)
			Essentially this only happens if we have a default map developed eg for US
			and in FR one of the messages had to be removed in the sort. (this is exactly what happened :P)
			
			2.0 beta.4 in theory with the changes done this shouldn't happen anymore
		--]]
		table.sort(self.localMsgs, function (a,b)
				return (self.masterOrder[a.Message] or 0) < (self.masterOrder[b.Message] or 0);
			end)
		--[[
		if SW_TESTSWITCH then
			for i,v in ipairs(self.localMsgs) do
				SW_printStr(i.." "..v.Message);
			end
		end
		--]]
	end,
	
	addMsg = function(self, o)
		assert(o and o.Message, "SW_C_MessageList:add object is nil or invalid\r\n"..debugstack(2,1,0));
		assert(self.globalMessages[o.Message] == nil, "SW_C_MessageList:addMsg "..o.Message.." is already in the 'global' Message list\r\n"..debugstack(2,1,0));
		self.globalMessages[o.Message] = o;
	end,
	
	add = function(self, varName)
		assert(varName, "SW_C_MessageList:add varName is nil\r\n"..debugstack(2,1,0));
		--assert(self.globalMessages[varName] ~= nil, "SW_C_MessageList:add '"..varName.."' is NOT in the 'global' Message list\r\n"..debugstack(2,1,0));
		-- don't assert (e.g. WOW removed a message in a new version)
		local target = self.globalMessages[varName];
		if target ~= nil then
			table.insert( self.localMsgs, target );
			if self.brotherList[varName] and not self:isInLocal( self.brotherList[varName] ) then
				-- found a brother not in the list
				target = self.globalMessages[ self.brotherList[varName] ];
				if target ~= nil then
					table.insert( self.localMsgs, target );
				end
			end
			
			table.sort(self.localMsgs, function (a,b)
					return (self.masterOrder[a.Message] or 0) < (self.masterOrder[b.Message] or 0);
				end)
			return true;
		end
		
		return false;
	end,
	isInLocal = function(self, varName)
		for i,v in ipairs(self.localMsgs) do
			if v.Message == varName then
				return true;
			end
		end	
		return false;
	end,
	--[[
		Setting up messages in 2.0 is a LOT more code, but a LOT more readable and extendable
		(and more efficient after setup)
		The master table will have a brute force sort applied to it to assure there are no
		collisions.
		(removed the lateSort Attribute because of this)
		
	--]]
	
	initMasterTable = function(self)
		self.masterOrder = {};
		local oTmp;
		local tmpList = {};
		
		
		oTmp = SW_C_Message:new("COMBATHITCRITOTHEROTHER"); 
		oTmp:setCaptures(SW_Types.String.Source,SW_Types.String.Target,SW_Types.Number.Damage);
		oTmp:setCrit(true);
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("COMBATHITCRITSCHOOLOTHEROTHER");
		oTmp:setCaptures(SW_Types.String.Source,SW_Types.String.Target,SW_Types.Number.Damage,SW_Types.String.School);
		oTmp:setCrit(true); --oTmp:setLateSort(LOCALE_frFR);
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("COMBATHITCRITOTHERSELF"); 
		oTmp:setCaptures(SW_Types.String.Source,SW_Types.Number.Damage);
		oTmp:setToSelf(true); oTmp:setCrit(true);
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("COMBATHITCRITSCHOOLOTHERSELF"); 
		oTmp:setCaptures(SW_Types.String.Source,SW_Types.Number.Damage,SW_Types.String.School); 
		oTmp:setToSelf(true); oTmp:setCrit(true);
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("COMBATHITCRITSCHOOLSELFOTHER"); 
		oTmp:setCaptures(SW_Types.String.Target,SW_Types.Number.Damage,SW_Types.String.School); 
		oTmp:setFromSelf(true); oTmp:setCrit(true);
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("COMBATHITCRITSELFOTHER"); 
		oTmp:setCaptures(SW_Types.String.Target,SW_Types.Number.Damage); 
		oTmp:setFromSelf(true); oTmp:setCrit(true);
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("COMBATHITOTHEROTHER"); 
		oTmp:setCaptures(SW_Types.String.Source,SW_Types.String.Target,SW_Types.Number.Damage); 
		--oTmp:setLateSort(LOCALE_zhCN or LOCALE_zhTW);
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("COMBATHITSCHOOLOTHEROTHER"); 
		oTmp:setCaptures(SW_Types.String.Source,SW_Types.String.Target,SW_Types.Number.Damage,SW_Types.String.School); 
		--oTmp:setLateSort(LOCALE_zhCN or LOCALE_zhTW);
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("COMBATHITSCHOOLOTHERSELF"); 
		oTmp:setCaptures(SW_Types.String.Source,SW_Types.Number.Damage,SW_Types.String.School); 
		oTmp:setToSelf(true); --oTmp:setLateSort(LOCALE_zhCN or LOCALE_zhTW);
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("COMBATHITOTHERSELF"); 
		oTmp:setCaptures(SW_Types.String.Source,SW_Types.Number.Damage); 
		oTmp:setToSelf(true);
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("COMBATHITSCHOOLSELFOTHER"); 
		oTmp:setCaptures(SW_Types.String.Target,SW_Types.Number.Damage,SW_Types.String.School); 
		oTmp:setFromSelf(true);
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("COMBATHITSELFOTHER"); 
		oTmp:setCaptures(SW_Types.String.Target,SW_Types.Number.Damage); 
		oTmp:setFromSelf(true);
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("DAMAGESHIELDOTHEROTHER"); 
		oTmp:setCaptures(SW_Types.String.Source,SW_Types.Number.Damage,SW_Types.String.School,SW_Types.String.Target);
		oTmp.MapToSkill = SW_MAP_SKILL_DMGSHIELD;
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("DAMAGESHIELDOTHERSELF"); 
		oTmp:setCaptures(SW_Types.String.Source,SW_Types.Number.Damage,SW_Types.String.School); 
		oTmp.MapToSkill = SW_MAP_SKILL_DMGSHIELD;
		oTmp:setToSelf(true);
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("DAMAGESHIELDSELFOTHER"); 
		oTmp:setCaptures(SW_Types.Number.Damage,SW_Types.String.School,SW_Types.String.Target); 
		oTmp.MapToSkill = SW_MAP_SKILL_DMGSHIELD;
		oTmp:setFromSelf(true);
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("ERR_COMBAT_DAMAGE_SSI"); 
		oTmp:setCaptures(SW_Types.String.Source,SW_Types.String.Target,SW_Types.Number.Damage); 
		--oTmp:setLateSort(true);
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("HEALEDCRITOTHEROTHER"); 
		oTmp:setCaptures(SW_Types.String.Source,SW_Types.String.Skill,SW_Types.String.Target,SW_Types.Number.Heal); 
		oTmp:setCrit(true);
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("HEALEDCRITOTHERSELF"); 
		oTmp:setCaptures(SW_Types.String.Source,SW_Types.String.Skill,SW_Types.Number.Heal); 
		oTmp:setToSelf(true); oTmp:setCrit(true);
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("HEALEDCRITSELFOTHER"); 
		oTmp:setCaptures(SW_Types.String.Skill,SW_Types.String.Target,SW_Types.Number.Heal); 
		oTmp:setFromSelf(true); oTmp:setCrit(true);
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("HEALEDCRITSELFSELF"); 
		oTmp:setCaptures(SW_Types.String.Skill,SW_Types.Number.Heal); 
		oTmp:setFromSelf(true); oTmp:setToSelf(true); oTmp:setCrit(true);
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("HEALEDOTHEROTHER"); 
		oTmp:setCaptures(SW_Types.String.Source,SW_Types.String.Skill,SW_Types.String.Target,SW_Types.Number.Heal); 
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("HEALEDOTHERSELF"); 
		oTmp:setCaptures(SW_Types.String.Source,SW_Types.String.Skill,SW_Types.Number.Heal); 
		oTmp:setToSelf(true);
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("HEALEDSELFOTHER"); 
		oTmp:setCaptures(SW_Types.String.Skill,SW_Types.String.Target,SW_Types.Number.Heal); 
		oTmp:setFromSelf(true);
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("HEALEDSELFSELF"); 
		oTmp:setCaptures(SW_Types.String.Skill,SW_Types.Number.Heal); 
		oTmp:setFromSelf(true); oTmp:setToSelf(true);
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("PERIODICAURADAMAGEOTHEROTHER"); 
		oTmp:setCaptures(SW_Types.String.Target,SW_Types.Number.Damage,SW_Types.String.School,SW_Types.String.Source,SW_Types.String.Skill); 
		table.insert(tmpList, oTmp); oTmp.IsPeriodic = true;
		
		oTmp = SW_C_Message:new("PERIODICAURADAMAGEOTHERSELF"); 
		oTmp:setCaptures(SW_Types.Number.Damage,SW_Types.String.School,SW_Types.String.Source,SW_Types.String.Skill); 
		oTmp:setToSelf(true); oTmp.IsPeriodic = true;
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("PERIODICAURADAMAGESELFOTHER"); 
		oTmp:setCaptures(SW_Types.String.Target,SW_Types.Number.Damage,SW_Types.String.School,SW_Types.String.Skill); 
		oTmp:setFromSelf(true); oTmp.IsPeriodic = true;
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("PERIODICAURADAMAGESELFSELF"); 
		oTmp:setCaptures(SW_Types.Number.Damage,SW_Types.String.School,SW_Types.String.Skill); 
		oTmp:setFromSelf(true); oTmp:setToSelf(true); oTmp.IsPeriodic = true;
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("PERIODICAURAHEALOTHEROTHER"); 
		oTmp:setCaptures(SW_Types.String.Target,SW_Types.Number.Heal,SW_Types.String.Source,SW_Types.String.Skill); 
		table.insert(tmpList, oTmp); oTmp.IsPeriodic = true;
		
		oTmp = SW_C_Message:new("PERIODICAURAHEALOTHERSELF"); 
		oTmp:setCaptures(SW_Types.Number.Heal,SW_Types.String.Source,SW_Types.String.Skill); 
		oTmp:setToSelf(true); oTmp.IsPeriodic = true;
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("PERIODICAURAHEALSELFOTHER"); 
		oTmp:setCaptures(SW_Types.String.Target,SW_Types.Number.Heal,SW_Types.String.Skill); 
		oTmp:setFromSelf(true); oTmp.IsPeriodic = true;
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("PERIODICAURAHEALSELFSELF"); 
		oTmp:setCaptures(SW_Types.Number.Heal,SW_Types.String.Skill); 
		oTmp:setFromSelf(true); oTmp:setToSelf(true); oTmp.IsPeriodic = true; --oTmp:setLateSort(LOCALE_enGB or LOCALE_enUS);
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("PET_DAMAGE_PERCENTAGE"); 
		oTmp:setCaptures(SW_Types.Number.Multi);
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("SPELLEXTRAATTACKSOTHER"); 
		oTmp:setCaptures(SW_Types.String.Target,SW_Types.Number.Attacks,SW_Types.String.Skill);
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("SPELLEXTRAATTACKSOTHER_SINGULAR"); 
		oTmp:setCaptures(SW_Types.String.Target,SW_Types.Number.Attacks,SW_Types.String.Skill); 
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("SPELLEXTRAATTACKSSELF"); 
		oTmp:setCaptures(SW_Types.Number.Attacks,SW_Types.String.Skill); 
		oTmp:setToSelf(true);
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("SPELLEXTRAATTACKSSELF_SINGULAR"); 
		oTmp:setCaptures(SW_Types.Number.Attacks, SW_Types.String.Skill); 
		oTmp:setToSelf(true);
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("SPELLHAPPINESSDRAINOTHER"); 
		oTmp:setCaptures(SW_Types.String.Source,SW_Types.String.Target,SW_Types.Number.Happy); 
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("SPELLHAPPINESSDRAINSELF"); 
		oTmp:setCaptures(SW_Types.String.Target,SW_Types.Number.Happy); 
		oTmp:setFromSelf(true);
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("SPELLLOGCRITOTHEROTHER"); 
		oTmp:setCaptures(SW_Types.String.Source,SW_Types.String.Skill,SW_Types.String.Target,SW_Types.Number.Damage); 
		oTmp:setCrit(true);
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("SPELLLOGCRITOTHERSELF"); 
		oTmp:setCaptures(SW_Types.String.Source,SW_Types.String.Skill,SW_Types.Number.Damage); 
		oTmp:setToSelf(true); oTmp:setCrit(true);
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("SPELLLOGCRITSCHOOLOTHEROTHER"); 
		oTmp:setCaptures(SW_Types.String.Source,SW_Types.String.Skill,SW_Types.String.Target,SW_Types.Number.Damage,SW_Types.String.School); 
		oTmp:setCrit(true);
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("SPELLLOGCRITSCHOOLOTHERSELF"); 
		oTmp:setCaptures(SW_Types.String.Source,SW_Types.String.Skill,SW_Types.Number.Damage,SW_Types.String.School); 
		oTmp:setToSelf(true); oTmp:setCrit(true);
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("SPELLLOGCRITSCHOOLSELFOTHER"); 
		oTmp:setCaptures(SW_Types.String.Skill,SW_Types.String.Target,SW_Types.Number.Damage,SW_Types.String.School); 
		oTmp:setFromSelf(true); oTmp:setCrit(true);
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("SPELLLOGCRITSCHOOLSELFSELF"); 
		oTmp:setCaptures(SW_Types.String.Skill,SW_Types.Number.Damage,SW_Types.String.School); 
		oTmp:setFromSelf(true); oTmp:setToSelf(true); oTmp:setCrit(true);
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("SPELLLOGCRITSELFOTHER"); 
		oTmp:setCaptures(SW_Types.String.Skill,SW_Types.String.Target,SW_Types.Number.Damage); 
		oTmp:setFromSelf(true); oTmp:setCrit(true);
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("SPELLLOGCRITSELFSELF"); 
		oTmp:setCaptures(SW_Types.String.Skill,SW_Types.Number.Damage); 
		oTmp:setFromSelf(true); oTmp:setToSelf(true); oTmp:setCrit(true);
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("SPELLLOGOTHEROTHER"); 
		oTmp:setCaptures(SW_Types.String.Source,SW_Types.String.Skill,SW_Types.String.Target,SW_Types.Number.Damage); 
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("SPELLLOGOTHERSELF"); 
		oTmp:setCaptures(SW_Types.String.Source,SW_Types.String.Skill,SW_Types.Number.Damage); 
		oTmp:setToSelf(true);
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("SPELLLOGSCHOOLOTHEROTHER"); 
		oTmp:setCaptures(SW_Types.String.Source,SW_Types.String.Skill,SW_Types.String.Target,SW_Types.Number.Damage,SW_Types.String.School); 
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("SPELLLOGSCHOOLOTHERSELF"); 
		oTmp:setCaptures(SW_Types.String.Source,SW_Types.String.Skill,SW_Types.Number.Damage,SW_Types.String.School); 
		oTmp:setToSelf(true);
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("SPELLLOGSCHOOLSELFOTHER"); 
		oTmp:setCaptures(SW_Types.String.Skill,SW_Types.String.Target,SW_Types.Number.Damage,SW_Types.String.School); 
		oTmp:setFromSelf(true);
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("SPELLLOGSCHOOLSELFSELF"); 
		oTmp:setCaptures(SW_Types.String.Skill,SW_Types.Number.Damage,SW_Types.String.School); 
		oTmp:setFromSelf(true); oTmp:setToSelf(true);
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("SPELLLOGSELFOTHER"); 
		oTmp:setCaptures(SW_Types.String.Skill,SW_Types.String.Target,SW_Types.Number.Damage); 
		oTmp:setFromSelf(true);
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("SPELLLOGSELFSELF"); 
		oTmp:setCaptures(SW_Types.String.Skill,SW_Types.Number.Damage); 
		oTmp:setFromSelf(true); oTmp:setToSelf(true);
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("SPELLPOWERDRAINOTHEROTHER"); 
		oTmp:setCaptures(SW_Types.String.Source,SW_Types.String.Skill,SW_Types.Number.Drain,SW_Types.String.DrainWhat,SW_Types.String.Target); 
		--oTmp:setLateSort(LOCALE_enGB or LOCALE_enUS);
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("SPELLPOWERDRAINOTHERSELF"); 
		oTmp:setCaptures(SW_Types.String.Source,SW_Types.String.Skill,SW_Types.Number.Drain,SW_Types.String.DrainWhat); 
		oTmp:setToSelf(true); --oTmp:setLateSort(LOCALE_enGB or LOCALE_enUS);
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("SPELLPOWERDRAINSELFOTHER"); 
		oTmp:setCaptures(SW_Types.String.Skill,SW_Types.Number.Drain,SW_Types.String.DrainWhat,SW_Types.String.Target); 
		oTmp:setFromSelf(true);
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("SPELLPOWERLEECHOTHEROTHER"); 
		oTmp:setCaptures(SW_Types.String.Source,SW_Types.String.Skill,SW_Types.Number.LeechFrom,SW_Types.String.LeechFromWhat,SW_Types.String.Target,SW_Types.String.LeechTo,SW_Types.Number.LeechTo,SW_Types.String.LeechToWhat); 
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("SPELLPOWERLEECHOTHERSELF"); 
		oTmp:setCaptures(SW_Types.String.Source,SW_Types.String.Skill,SW_Types.Number.LeechFrom,SW_Types.String.LeechFromWhat,SW_Types.String.LeechTo,SW_Types.Number.LeechTo,SW_Types.String.LeechToWhat); 
		oTmp:setToSelf(true);
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("SPELLPOWERLEECHSELFOTHER"); 
		oTmp:setCaptures(SW_Types.String.Skill,SW_Types.Number.LeechFrom,SW_Types.String.LeechFromWhat,SW_Types.String.Target,SW_Types.Number.LeechTo,SW_Types.String.LeechToWhat);  
		oTmp:setFromSelf(true);
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("SPELLSPLITDAMAGEOTHEROTHER"); 
		oTmp:setCaptures(SW_Types.String.Source,SW_Types.String.Skill,SW_Types.String.Target,SW_Types.Number.Damage); 
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("SPELLSPLITDAMAGEOTHERSELF"); 
		oTmp:setCaptures(SW_Types.String.Source,SW_Types.String.Skill,SW_Types.Number.Damage); 
		oTmp:setToSelf(true);
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("SPELLSPLITDAMAGESELFOTHER"); 
		oTmp:setCaptures(SW_Types.String.Source,SW_Types.String.Target,SW_Types.Number.Damage); 
		oTmp:setFromSelf(true);
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("VSENVIRONMENTALDAMAGE_DROWNING_OTHER"); 
		oTmp:setCaptures(SW_Types.String.Target,SW_Types.Number.EnviroDmg); 
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("VSENVIRONMENTALDAMAGE_DROWNING_SELF"); 
		oTmp:setCaptures(SW_Types.Number.EnviroDmg); 
		oTmp:setToSelf(true);
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("VSENVIRONMENTALDAMAGE_FALLING_OTHER"); 
		oTmp:setCaptures(SW_Types.String.Target,SW_Types.Number.EnviroDmg); 
		table.insert(tmpList, oTmp);
		
		
		oTmp = SW_C_Message:new("VSENVIRONMENTALDAMAGE_FALLING_SELF"); 
		oTmp:setCaptures(SW_Types.Number.EnviroDmg); 
		oTmp:setToSelf(true);
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("VSENVIRONMENTALDAMAGE_FATIGUE_OTHER"); 
		oTmp:setCaptures(SW_Types.String.Target,SW_Types.Number.EnviroDmg); 
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("VSENVIRONMENTALDAMAGE_FATIGUE_SELF"); 
		oTmp:setCaptures(SW_Types.Number.EnviroDmg); 
		oTmp:setToSelf(true);
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("VSENVIRONMENTALDAMAGE_FIRE_OTHER"); 
		oTmp:setCaptures(SW_Types.String.Target,SW_Types.Number.EnviroDmg); 
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("VSENVIRONMENTALDAMAGE_FIRE_SELF"); 
		oTmp:setCaptures(SW_Types.Number.EnviroDmg); 
		oTmp:setToSelf(true);
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("VSENVIRONMENTALDAMAGE_LAVA_OTHER"); 
		oTmp:setCaptures(SW_Types.String.Target,SW_Types.Number.EnviroDmg); 
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("VSENVIRONMENTALDAMAGE_LAVA_SELF"); 
		oTmp:setCaptures(SW_Types.Number.EnviroDmg); 
		oTmp:setToSelf(true);
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("VSENVIRONMENTALDAMAGE_SLIME_OTHER"); 
		oTmp:setCaptures(SW_Types.String.Target,SW_Types.Number.EnviroDmg); 
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("VSENVIRONMENTALDAMAGE_SLIME_SELF"); 
		oTmp:setCaptures(SW_Types.Number.EnviroDmg); 
		oTmp:setToSelf(true);
		table.insert(tmpList, oTmp);

		oTmp = SW_C_Message:new("POWERGAINOTHEROTHER"); 
		oTmp:setCaptures(SW_Types.String.Target,SW_Types.Number.Gain,SW_Types.String.GainWhat,SW_Types.String.Source,SW_Types.String.Skill); 
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("POWERGAINOTHERSELF"); 
		oTmp:setCaptures(SW_Types.Number.Gain,SW_Types.String.GainWhat,SW_Types.String.Source,SW_Types.String.Skill); 
		oTmp:setToSelf(true);
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("POWERGAINSELFOTHER"); 
		oTmp:setCaptures(SW_Types.String.Target,SW_Types.Number.Gain,SW_Types.String.GainWhat,SW_Types.String.Skill); 
		oTmp:setFromSelf(true); --oTmp:setLateSort(true);
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("POWERGAINSELFSELF"); 
		oTmp:setCaptures(SW_Types.Number.Gain,SW_Types.String.GainWhat,SW_Types.String.Skill); 
		oTmp:setFromSelf(true); oTmp:setToSelf(true); --oTmp:setLateSort(true);
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("AURAAPPLICATIONADDEDOTHERHARMFUL"); 
		oTmp:setCaptures(SW_Types.String.Target,SW_Types.String.Skill,SW_Types.Number.StackCount); 
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("AURAAPPLICATIONADDEDOTHERHELPFUL"); 
		oTmp:setCaptures(SW_Types.String.Target,SW_Types.String.Skill,SW_Types.Number.StackCount); 
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("AURAAPPLICATIONADDEDSELFHARMFUL"); 
		oTmp:setCaptures(SW_Types.String.Skill,SW_Types.Number.StackCount); 
		oTmp:setToSelf(true);
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("AURAAPPLICATIONADDEDSELFHELPFUL"); 
		oTmp:setCaptures(SW_Types.String.Skill,SW_Types.Number.StackCount); 
		oTmp:setToSelf(true);
		table.insert(tmpList, oTmp);
		
		--AURAADDEDSELFHELPFUL ==> You gain %s.,
		oTmp = SW_C_Message:new("AURAADDEDSELFHELPFUL");
		oTmp:setCaptures(SW_Types.String.Skill);  
		oTmp:setToSelf(true); oTmp.IsEffectGot = true;
		table.insert(tmpList, oTmp);
		
		--AURAADDEDOTHERHELPFUL ==> %s gains %s.
		oTmp = SW_C_Message:new("AURAADDEDOTHERHELPFUL");
		oTmp:setCaptures(SW_Types.String.Target, SW_Types.String.Skill);  
		oTmp.IsEffectGot = true;
		table.insert(tmpList, oTmp);
		
		--AURAREMOVEDSELF ==> %s fades from you.
		oTmp = SW_C_Message:new("AURAREMOVEDSELF");
		oTmp:setCaptures(SW_Types.String.Skill);  
		oTmp:setToSelf(true); oTmp.IsEffectLost = true;
		table.insert(tmpList, oTmp);
		
		--AURAREMOVEDOTHER ==> %s fades from %s.
		oTmp = SW_C_Message:new("AURAREMOVEDOTHER");
		oTmp:setCaptures(SW_Types.String.Skill, SW_Types.String.Target);  
		oTmp.IsEffectLost = true;
		table.insert(tmpList, oTmp);
		
		--AURAADDEDSELFHARMFUL ==> You are afflicted by %s.
		oTmp = SW_C_Message:new("AURAADDEDSELFHARMFUL");
		oTmp:setCaptures(SW_Types.String.Skill);  
		oTmp:setToSelf(true); oTmp.IsEffectGot = true;
		table.insert(tmpList, oTmp);
		
		--AURAADDEDOTHERHARMFUL ==> %s is afflicted by %s.
		oTmp = SW_C_Message:new("AURAADDEDOTHERHARMFUL");
		oTmp:setCaptures(SW_Types.String.Target, SW_Types.String.Skill);  
		oTmp.IsEffectGot = true;
		table.insert(tmpList, oTmp);
		
		-- hmm is this even used? also this would be two skills would have to add another type maybe
		--AURACHANGEDSELF ==> You replace %s with %s.
		--AURACHANGEDOTHER ==> %s replaces %s with %s.
		
		--AURADISPELSELF ==> Your %s is removed.
		oTmp = SW_C_Message:new("AURADISPELSELF");
		oTmp:setCaptures(SW_Types.String.Skill);  
		oTmp:setToSelf(true); oTmp.IsEffectLost = true;
		table.insert(tmpList, oTmp);
		
		--AURADISPELOTHER ==> %s's %s is removed.
		oTmp = SW_C_Message:new("AURADISPELOTHER");
		oTmp:setCaptures(SW_Types.String.Target, SW_Types.String.Skill);  
		oTmp.IsEffectLost = true;
		table.insert(tmpList, oTmp);
		
		--AURASTOLENOTHEROTHER ==> %s steals %s's %s.
		oTmp = SW_C_Message:new("AURASTOLENOTHEROTHER"); 
		oTmp:setCaptures(SW_Types.String.Source,SW_Types.String.Target,SW_Types.String.Skill); 
		oTmp.IsSpellSteal = true;
		table.insert(tmpList, oTmp); 
		
		--AURASTOLENOTHERSELF ==> %s steals your %s.
		oTmp = SW_C_Message:new("AURASTOLENOTHERSELF"); 
		oTmp:setCaptures(SW_Types.String.Source,SW_Types.String.Skill); 
		oTmp:setToSelf(true); oTmp.IsSpellSteal = true;
		table.insert(tmpList, oTmp); 
		
		--AURASTOLENSELFOTHER ==> You steal %s's %s.
		oTmp = SW_C_Message:new("AURASTOLENSELFOTHER"); 
		oTmp:setCaptures(SW_Types.String.Target,SW_Types.String.Skill); 
		oTmp:setFromSelf(true); oTmp.IsSpellSteal = true;
		table.insert(tmpList, oTmp); 
		
		--AURASTOLENSELFSELF ==> You steal your %s.
		oTmp = SW_C_Message:new("AURASTOLENSELFSELF"); 
		oTmp:setCaptures(SW_Types.String.Skill); 
		oTmp:setFromSelf(true); oTmp:setToSelf(true); oTmp.IsSpellSteal = true;
		table.insert(tmpList, oTmp); 
		
		--AURA_END ==> <%s> fades
		oTmp = SW_C_Message:new("AURA_END");
		oTmp:setCaptures(SW_Types.String.Skill);  
		oTmp.IsEffectLost = true;
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("SIMPLECASTOTHEROTHER"); 
		oTmp:setCaptures(SW_Types.String.Source,SW_Types.String.Skill,SW_Types.String.Target); 
		table.insert(tmpList, oTmp); oTmp.IsCast = true;
		
		oTmp = SW_C_Message:new("SIMPLECASTOTHERSELF"); 
		oTmp:setCaptures(SW_Types.String.Source,SW_Types.String.Skill); 
		oTmp:setToSelf(true); oTmp.IsCast = true;
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("SIMPLECASTSELFOTHER"); 
		oTmp:setCaptures(SW_Types.String.Skill,SW_Types.String.Target); 
		oTmp:setFromSelf(true); oTmp.IsCast = true;
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("SIMPLECASTSELFSELF"); 
		oTmp:setCaptures(SW_Types.String.Skill); 
		oTmp:setFromSelf(true); oTmp:setToSelf(true); oTmp.IsCast = true;
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("COMBATLOG_HONORGAIN"); 
		oTmp:setCaptures(SW_Types.String.Source,SW_Types.String.PVPRank,SW_Types.Number.Honor); 
		oTmp:setToSelf(true);
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("COMBATLOG_HONORAWARD"); 
		oTmp:setCaptures(SW_Types.Number.Honor); 
		oTmp:setToSelf(true);
		table.insert(tmpList, oTmp);
		
		-- missed blocked resist etc msgs
		oTmp = SW_C_Message:new("MISSEDSELFOTHER"); 
		oTmp:setCaptures(SW_Types.String.Target); 
		oTmp:setFromSelf(true); oTmp.IsMiss = true; oTmp.IsDmgNullify = true;
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("MISSEDOTHERSELF"); 
		oTmp:setCaptures(SW_Types.String.Source); 
		oTmp:setToSelf(true); oTmp.IsMiss = true; oTmp.IsDmgNullify = true;
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("MISSEDOTHEROTHER"); 
		oTmp:setCaptures(SW_Types.String.Source, SW_Types.String.Target); 
		table.insert(tmpList, oTmp); oTmp.IsMiss = true; oTmp.IsDmgNullify = true;
		
		oTmp = SW_C_Message:new("SPELLMISSSELFSELF"); 
		oTmp:setCaptures(SW_Types.String.Skill); 
		oTmp:setFromSelf(true); oTmp:setToSelf(true);
		table.insert(tmpList, oTmp); oTmp.IsMiss = true; oTmp.IsDmgNullify = true;
		
		oTmp = SW_C_Message:new("SPELLMISSSELFOTHER"); 
		oTmp:setCaptures(SW_Types.String.Skill, SW_Types.String.Target); 
		oTmp:setFromSelf(true); oTmp.IsMiss = true; oTmp.IsDmgNullify = true;
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("SPELLMISSOTHERSELF"); 
		oTmp:setCaptures(SW_Types.String.Source, SW_Types.String.Skill); 
		oTmp:setToSelf(true); oTmp.IsMiss = true; oTmp.IsDmgNullify = true;
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("SPELLMISSOTHEROTHER"); 
		oTmp:setCaptures(SW_Types.String.Source, SW_Types.String.Skill, SW_Types.String.Target); 
		oTmp.IsMiss = true; oTmp.IsDmgNullify = true;
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("VSBLOCKSELFOTHER"); 
		oTmp:setCaptures(SW_Types.String.Target); 
		oTmp:setFromSelf(true); oTmp.IsBlock = true; oTmp.IsDmgNullify = true;
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("VSBLOCKOTHERSELF"); 
		oTmp:setCaptures(SW_Types.String.Source); 
		oTmp:setToSelf(true); oTmp.IsBlock = true; oTmp.IsDmgNullify = true;
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("VSBLOCKOTHEROTHER"); 
		oTmp:setCaptures(SW_Types.String.Source, SW_Types.String.Target); 
		oTmp.IsBlock = true; oTmp.IsDmgNullify = true;
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("SPELLBLOCKEDSELFOTHER"); 
		oTmp:setCaptures(SW_Types.String.Skill, SW_Types.String.Target); 
		oTmp:setFromSelf(true); oTmp.IsBlock = true; oTmp.IsDmgNullify = true;
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("SPELLBLOCKEDOTHERSELF"); 
		oTmp:setCaptures(SW_Types.String.Source, SW_Types.String.Skill); 
		oTmp:setToSelf(true); oTmp.IsBlock = true; oTmp.IsDmgNullify = true;
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("SPELLBLOCKEDOTHEROTHER"); 
		oTmp:setCaptures(SW_Types.String.Source, SW_Types.String.Skill, SW_Types.String.Target); 
		oTmp.IsBlock = true; oTmp.IsDmgNullify = true;
		table.insert(tmpList, oTmp);

		oTmp = SW_C_Message:new("VSPARRYSELFOTHER"); 
		oTmp:setCaptures(SW_Types.String.Target); 
		oTmp:setFromSelf(true); oTmp.IsParry = true; oTmp.IsDmgNullify = true;
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("VSPARRYOTHERSELF"); 
		oTmp:setCaptures(SW_Types.String.Source); 
		oTmp:setToSelf(true); oTmp.IsParry = true; oTmp.IsDmgNullify = true;
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("VSPARRYOTHEROTHER"); 
		oTmp:setCaptures(SW_Types.String.Source, SW_Types.String.Target); 
		oTmp.IsParry = true; oTmp.IsDmgNullify = true;
		table.insert(tmpList, oTmp);
		
		--SPELLPARRIEDOTHEROTHER ==> %s's %s was parried by %s.
		oTmp = SW_C_Message:new("SPELLPARRIEDOTHEROTHER"); 
		oTmp:setCaptures(SW_Types.String.Source, SW_Types.String.Skill, SW_Types.String.Target); 
		oTmp.IsParry = true; oTmp.IsDmgNullify = true;
		table.insert(tmpList, oTmp);
		
		--SPELLPARRIEDOTHERSELF ==> %s's %s was parried.
		oTmp = SW_C_Message:new("SPELLPARRIEDOTHERSELF"); 
		oTmp:setCaptures(SW_Types.String.Source, SW_Types.String.Skill); 
		oTmp:setToSelf(true);
		oTmp.IsParry = true; oTmp.IsDmgNullify = true;
		table.insert(tmpList, oTmp);
		
		--SPELLPARRIEDSELFOTHER ==> Your %s is parried by %s.
		oTmp = SW_C_Message:new("SPELLPARRIEDSELFOTHER"); 
		oTmp:setCaptures(SW_Types.String.Skill, SW_Types.String.Target); 
		oTmp:setFromSelf(true);
		oTmp.IsParry = true; oTmp.IsDmgNullify = true;
		table.insert(tmpList, oTmp);
		
		--SPELLPARRIEDSELFSELF ==> You parried your %s.
		oTmp = SW_C_Message:new("SPELLPARRIEDSELFSELF"); 
		oTmp:setCaptures(SW_Types.String.Skill); 
		oTmp:setFromSelf(true); oTmp:setToSelf(true);
		oTmp.IsParry = true; oTmp.IsDmgNullify = true;
		table.insert(tmpList, oTmp);
		
		--SPELLINTERRUPTOTHEROTHER ==> %s interrupts %s's %s.
		oTmp = SW_C_Message:new("SPELLINTERRUPTOTHEROTHER"); 
		oTmp:setCaptures(SW_Types.String.Source, SW_Types.String.Target, SW_Types.String.Skill); 
		oTmp.IsInterrupt = true;
		table.insert(tmpList, oTmp);
		
		--SPELLINTERRUPTOTHERSELF ==> %s interrupts your %s.
		oTmp = SW_C_Message:new("SPELLINTERRUPTOTHERSELF"); 
		oTmp:setCaptures(SW_Types.String.Source, SW_Types.String.Skill); 
		oTmp:setToSelf(true); oTmp.IsInterrupt = true;
		table.insert(tmpList, oTmp);
		
		--SPELLINTERRUPTSELFOTHER ==> You interrupt %s's %s.
		oTmp = SW_C_Message:new("SPELLINTERRUPTSELFOTHER"); 
		oTmp:setCaptures(SW_Types.String.Target, SW_Types.String.Skill); 
		oTmp:setFromSelf(true); oTmp.IsInterrupt = true;
		table.insert(tmpList, oTmp);
		
		--SPELLEVADEDOTHEROTHER ==> %s's %s was evaded by %s.
		oTmp = SW_C_Message:new("SPELLEVADEDOTHEROTHER"); 
		oTmp:setCaptures(SW_Types.String.Source, SW_Types.String.Skill, SW_Types.String.Target); 
		oTmp.IsEvade = true; oTmp.IsDmgNullify = true;
		table.insert(tmpList, oTmp);
		
		--SPELLEVADEDSELFOTHER ==> Your %s was evaded by %s.
		oTmp = SW_C_Message:new("SPELLEVADEDSELFOTHER"); 
		oTmp:setCaptures(SW_Types.String.Skill, SW_Types.String.Target); 
		oTmp:setFromSelf(true); oTmp.IsEvade = true; oTmp.IsDmgNullify = true;
		table.insert(tmpList, oTmp);
		
		--SPELLEVADEDOTHERSELF ==> %s's %s was evaded.
		oTmp = SW_C_Message:new("SPELLEVADEDOTHERSELF"); 
		oTmp:setCaptures(SW_Types.String.Source, SW_Types.String.Skill); 
		oTmp:setToSelf(true); oTmp.IsEvade = true; oTmp.IsDmgNullify = true;
		table.insert(tmpList, oTmp);
		
		--SPELLEVADEDSELFSELF ==> You evaded your %s.
		oTmp = SW_C_Message:new("SPELLEVADEDSELFSELF"); 
		oTmp:setCaptures(SW_Types.String.Skill); 
		oTmp:setFromSelf(true); oTmp:setToSelf(true); oTmp.IsEvade = true; oTmp.IsDmgNullify = true;
		table.insert(tmpList, oTmp);
		
		--VSEVADEOTHEROTHER ==> %s attacks. %s evades.
		oTmp = SW_C_Message:new("VSEVADEOTHEROTHER"); 
		oTmp:setCaptures(SW_Types.String.Source, SW_Types.String.Target); 
		oTmp.IsEvade = true; oTmp.IsDmgNullify = true;
		table.insert(tmpList, oTmp);
		
		--VSEVADEOTHERSELF ==> %s attacks. You evade.
		oTmp = SW_C_Message:new("VSEVADEOTHERSELF"); 
		oTmp:setCaptures(SW_Types.String.Source); 
		oTmp:setToSelf(true); oTmp.IsEvade = true; oTmp.IsDmgNullify = true;
		table.insert(tmpList, oTmp);
		
		--VSEVADESELFOTHER ==> You attack. %s evades.
		oTmp = SW_C_Message:new("VSEVADESELFOTHER"); 
		oTmp:setCaptures(SW_Types.String.Target); 
		oTmp:setFromSelf(true); oTmp.IsEvade = true; oTmp.IsDmgNullify = true;
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("VSABSORBSELFOTHER"); 
		oTmp:setCaptures(SW_Types.String.Target); 
		oTmp:setFromSelf(true); oTmp.IsAbsorb = true; oTmp.IsDmgNullify = true;
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("VSABSORBOTHERSELF"); 
		oTmp:setCaptures(SW_Types.String.Source); 
		oTmp:setToSelf(true); oTmp.IsAbsorb = true; oTmp.IsDmgNullify = true;
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("VSABSORBOTHEROTHER"); 
		oTmp:setCaptures(SW_Types.String.Source, SW_Types.String.Target); 
		oTmp.IsAbsorb = true; oTmp.IsDmgNullify = true;
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("SPELLLOGABSORBSELFSELF"); 
		oTmp:setCaptures(SW_Types.String.Skill); 
		oTmp:setFromSelf(true); oTmp:setToSelf(true);
		table.insert(tmpList, oTmp); oTmp.IsAbsorb = true; oTmp.IsDmgNullify = true;
		
		oTmp = SW_C_Message:new("SPELLLOGABSORBSELFOTHER"); 
		oTmp:setCaptures(SW_Types.String.Skill, SW_Types.String.Target); 
		oTmp:setFromSelf(true); oTmp.IsAbsorb = true; oTmp.IsDmgNullify = true;
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("SPELLLOGABSORBOTHERSELF"); 
		oTmp:setCaptures(SW_Types.String.Source, SW_Types.String.Skill); 
		oTmp:setToSelf(true); oTmp.IsAbsorb = true; oTmp.IsDmgNullify = true;
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("SPELLLOGABSORBOTHEROTHER"); 
		oTmp:setCaptures(SW_Types.String.Source, SW_Types.String.Skill, SW_Types.String.Target); 
		oTmp.IsAbsorb = true; oTmp.IsDmgNullify = true;
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("VSDODGESELFOTHER"); 
		oTmp:setCaptures(SW_Types.String.Target); 
		oTmp:setFromSelf(true); oTmp.IsDodge = true; oTmp.IsDmgNullify = true;
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("VSDODGEOTHERSELF"); 
		oTmp:setCaptures(SW_Types.String.Source); 
		oTmp:setToSelf(true); oTmp.IsDodge = true; oTmp.IsDmgNullify = true;
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("VSDODGEOTHEROTHER"); 
		oTmp:setCaptures(SW_Types.String.Source, SW_Types.String.Target); 
		oTmp.IsDodge = true; oTmp.IsDmgNullify = true;
		table.insert(tmpList, oTmp);

		oTmp = SW_C_Message:new("SPELLDODGEDSELFSELF"); 
		oTmp:setCaptures(SW_Types.String.Skill); 
		oTmp:setFromSelf(true); oTmp:setToSelf(true);
		table.insert(tmpList, oTmp); oTmp.IsDodge = true; oTmp.IsDmgNullify = true;
		
		oTmp = SW_C_Message:new("SPELLDODGEDSELFOTHER"); 
		oTmp:setCaptures(SW_Types.String.Skill, SW_Types.String.Target); 
		oTmp:setFromSelf(true); oTmp.IsDodge = true; oTmp.IsDmgNullify = true;
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("SPELLDODGEDOTHERSELF"); 
		oTmp:setCaptures(SW_Types.String.Source, SW_Types.String.Skill); 
		oTmp:setToSelf(true); oTmp.IsDodge = true; oTmp.IsDmgNullify = true;
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("SPELLDODGEDOTHEROTHER"); 
		oTmp:setCaptures(SW_Types.String.Source, SW_Types.String.Skill, SW_Types.String.Target); 
		oTmp.IsDodge = true; oTmp.IsDmgNullify = true;
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("VSRESISTSELFOTHER"); 
		oTmp:setCaptures(SW_Types.String.Target); 
		oTmp:setFromSelf(true); oTmp.IsResist = true; oTmp.IsDmgNullify = true;
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("VSRESISTOTHERSELF"); 
		oTmp:setCaptures(SW_Types.String.Source); 
		oTmp:setToSelf(true); oTmp.IsResist = true; oTmp.IsDmgNullify = true;
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("VSRESISTOTHEROTHER"); 
		oTmp:setCaptures(SW_Types.String.Source, SW_Types.String.Target); 
		oTmp.IsResist = true; oTmp.IsDmgNullify = true;
		table.insert(tmpList, oTmp);

		oTmp = SW_C_Message:new("SPELLRESISTSELFSELF"); 
		oTmp:setCaptures(SW_Types.String.Skill); 
		oTmp:setFromSelf(true); oTmp:setToSelf(true);
		table.insert(tmpList, oTmp); oTmp.IsResist = true; oTmp.IsDmgNullify = true;
		
		oTmp = SW_C_Message:new("SPELLRESISTSELFOTHER"); 
		oTmp:setCaptures(SW_Types.String.Skill, SW_Types.String.Target); 
		oTmp:setFromSelf(true); oTmp.IsResist = true; oTmp.IsDmgNullify = true;
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("SPELLRESISTOTHERSELF"); 
		oTmp:setCaptures(SW_Types.String.Source, SW_Types.String.Skill); 
		oTmp:setToSelf(true); oTmp.IsResist = true; oTmp.IsDmgNullify = true;
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("SPELLRESISTOTHEROTHER"); 
		oTmp:setCaptures(SW_Types.String.Source, SW_Types.String.Skill, SW_Types.String.Target); 
		oTmp.IsResist = true; oTmp.IsDmgNullify = true;
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("PROCRESISTSELFSELF"); 
		oTmp:setCaptures(SW_Types.String.Skill); 
		oTmp:setFromSelf(true); oTmp:setToSelf(true);
		table.insert(tmpList, oTmp); oTmp.IsResist = true; oTmp.IsDmgNullify = true;
		
		oTmp = SW_C_Message:new("PROCRESISTSELFOTHER"); 
		oTmp:setCaptures(SW_Types.String.Target, SW_Types.String.Skill); 
		oTmp:setFromSelf(true); oTmp.IsResist = true; oTmp.IsDmgNullify = true;
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("PROCRESISTOTHERSELF"); 
		oTmp:setCaptures(SW_Types.String.Source, SW_Types.String.Skill); 
		oTmp:setToSelf(true); oTmp.IsResist = true; oTmp.IsDmgNullify = true;
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("PROCRESISTOTHEROTHER"); 
		oTmp:setCaptures(SW_Types.String.Target, SW_Types.String.Source, SW_Types.String.Skill); 
		oTmp.IsResist = true; oTmp.IsDmgNullify = true;
		table.insert(tmpList, oTmp);

		oTmp = SW_C_Message:new("SPELLREFLECTSELFSELF"); 
		oTmp:setCaptures(SW_Types.String.Skill); 
		oTmp:setFromSelf(true); oTmp:setToSelf(true);
		table.insert(tmpList, oTmp); oTmp.IsReflect = true; oTmp.IsDmgNullify = true;
		
		oTmp = SW_C_Message:new("SPELLREFLECTSELFOTHER"); 
		oTmp:setCaptures(SW_Types.String.Skill, SW_Types.String.Target); 
		oTmp:setFromSelf(true); oTmp.IsReflect = true; oTmp.IsDmgNullify = true;
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("SPELLREFLECTOTHERSELF"); 
		oTmp:setCaptures(SW_Types.String.Source, SW_Types.String.Skill); 
		oTmp:setToSelf(true); oTmp.IsReflect = true; oTmp.IsDmgNullify = true;
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("SPELLREFLECTOTHEROTHER"); 
		oTmp:setCaptures(SW_Types.String.Source, SW_Types.String.Skill, SW_Types.String.Target); 
		oTmp.IsReflect = true; oTmp.IsDmgNullify = true;
		table.insert(tmpList, oTmp);

		oTmp = SW_C_Message:new("VSDEFLECTSELFOTHER"); 
		oTmp:setCaptures(SW_Types.String.Target); 
		oTmp:setFromSelf(true); oTmp.IsDeflect = true; oTmp.IsDmgNullify = true;
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("VSDEFLECTOTHERSELF"); 
		oTmp:setCaptures(SW_Types.String.Source); 
		oTmp:setToSelf(true); oTmp.IsDeflect = true; oTmp.IsDmgNullify = true;
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("VSDEFLECTOTHEROTHER"); 
		oTmp:setCaptures(SW_Types.String.Source, SW_Types.String.Target); 
		oTmp.IsDeflect = true; oTmp.IsDmgNullify = true;
		table.insert(tmpList, oTmp);

		oTmp = SW_C_Message:new("SPELLDEFLECTEDSELFSELF"); 
		oTmp:setCaptures(SW_Types.String.Skill); 
		oTmp:setFromSelf(true); oTmp:setToSelf(true);
		table.insert(tmpList, oTmp); oTmp.IsDeflect = true; oTmp.IsDmgNullify = true;
		
		oTmp = SW_C_Message:new("SPELLDEFLECTEDSELFOTHER"); 
		oTmp:setCaptures(SW_Types.String.Skill, SW_Types.String.Target); 
		oTmp:setFromSelf(true); oTmp.IsDeflect = true; oTmp.IsDmgNullify = true;
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("SPELLDEFLECTEDOTHERSELF"); 
		oTmp:setCaptures(SW_Types.String.Source, SW_Types.String.Skill); 
		oTmp:setToSelf(true); oTmp.IsDeflect = true; oTmp.IsDmgNullify = true;
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("SPELLDEFLECTEDOTHEROTHER"); 
		oTmp:setCaptures(SW_Types.String.Source, SW_Types.String.Skill, SW_Types.String.Target); 
		oTmp.IsDeflect = true; oTmp.IsDmgNullify = true;
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("VSIMMUNESELFOTHER"); 
		oTmp:setCaptures(SW_Types.String.Target); 
		oTmp:setFromSelf(true); oTmp.IsImmune = true; oTmp.IsDmgNullify = true;
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("VSIMMUNEOTHERSELF"); 
		oTmp:setCaptures(SW_Types.String.Source); 
		oTmp:setToSelf(true); oTmp.IsImmune = true; oTmp.IsDmgNullify = true;
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("VSIMMUNEOTHEROTHER"); 
		oTmp:setCaptures(SW_Types.String.Source, SW_Types.String.Target); 
		oTmp.IsImmune = true; oTmp.IsDmgNullify = true;
		table.insert(tmpList, oTmp);

		oTmp = SW_C_Message:new("SPELLIMMUNESELFSELF"); 
		oTmp:setCaptures(SW_Types.String.Skill); 
		oTmp:setFromSelf(true); oTmp:setToSelf(true);
		table.insert(tmpList, oTmp); oTmp.IsImmune = true; oTmp.IsDmgNullify = true;
		
		oTmp = SW_C_Message:new("SPELLIMMUNESELFOTHER"); 
		oTmp:setCaptures(SW_Types.String.Skill, SW_Types.String.Target); 
		oTmp:setFromSelf(true); oTmp.IsImmune = true; oTmp.IsDmgNullify = true;
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("SPELLIMMUNEOTHERSELF"); 
		oTmp:setCaptures(SW_Types.String.Source, SW_Types.String.Skill); 
		oTmp:setToSelf(true); oTmp.IsImmune = true; oTmp.IsDmgNullify = true;
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("SPELLIMMUNEOTHEROTHER"); 
		oTmp:setCaptures(SW_Types.String.Source, SW_Types.String.Skill, SW_Types.String.Target); 
		oTmp.IsImmune = true; oTmp.IsDmgNullify = true;
		table.insert(tmpList, oTmp);
		
		
		-- death msgs
		oTmp = SW_C_Message:new("UNITDIESSELF");
		oTmp:setToSelf(true); oTmp.IsDeath = true;
		table.insert(tmpList, oTmp);
		
		oTmp = SW_C_Message:new("UNITDIESOTHER"); 
		oTmp:setCaptures(SW_Types.String.Target); 
		oTmp.IsDeath = true;
		table.insert(tmpList, oTmp);
		
		--UNITDESTROYEDOTHER ==> %s is destroyed.
		-- "death" message for totems
		oTmp = SW_C_Message:new("UNITDESTROYEDOTHER"); 
		oTmp:setCaptures(SW_Types.String.Target); 
		oTmp.IsDestruction = true;
		table.insert(tmpList, oTmp);
		
		--ERR_KILLED_BY_S = "%s has slain you.";
		oTmp = SW_C_Message:new("ERR_KILLED_BY_S"); 
		oTmp:setCaptures(SW_Types.String.Source); 
		oTmp:setToSelf(true);
		oTmp.IsSlayInfo = true;
		table.insert(tmpList, oTmp);
		
		--SELFKILLOTHER = "You have slain %s!";
		oTmp = SW_C_Message:new("SELFKILLOTHER"); 
		oTmp:setCaptures(SW_Types.String.Target); 
		oTmp:setFromSelf(true);
		oTmp.IsSlayInfo = true;
		table.insert(tmpList, oTmp);
		
		--PARTYKILLOTHER = "%s is slain by %s!";
		oTmp = SW_C_Message:new("PARTYKILLOTHER"); 
		oTmp:setCaptures(SW_Types.String.Target, SW_Types.String.Source); 
		oTmp.IsSlayInfo = true;
		table.insert(tmpList, oTmp);
		
		--INSTAKILLSELF ==> You are killed by %s.
		oTmp = SW_C_Message:new("INSTAKILLSELF"); 
		oTmp:setCaptures(SW_Types.String.Skill); 
		oTmp:setToSelf(true);
		oTmp.IsSlayInfo = true;
		table.insert(tmpList, oTmp);
		--INSTAKILLOTHER ==> %s is killed by %s.
		oTmp = SW_C_Message:new("INSTAKILLOTHER"); 
		oTmp:setCaptures(SW_Types.String.Target, SW_Types.String.Skill); 
		oTmp.IsSlayInfo = true;
		table.insert(tmpList, oTmp);
		
		--SPELLCASTGOOTHER = "%s casts %s.";
		oTmp = SW_C_Message:new("SPELLCASTGOOTHER"); 
		oTmp:setCaptures(SW_Types.String.Source, SW_Types.String.Skill); 
		oTmp.IsCast = true;
		table.insert(tmpList, oTmp);
		
		--SPELLCASTGOOTHERTARGETTED = "%s casts %s on %s.";
		oTmp = SW_C_Message:new("SPELLCASTGOOTHERTARGETTED"); 
		oTmp:setCaptures(SW_Types.String.Source, SW_Types.String.Skill, SW_Types.String.Target); 
		oTmp.IsCast = true;
		table.insert(tmpList, oTmp);
		
		--SPELLCASTGOSELF = "You cast %s.";
		oTmp = SW_C_Message:new("SPELLCASTGOSELF"); 
		oTmp:setCaptures(SW_Types.String.Skill); 
		oTmp:setFromSelf(true); oTmp.IsCast = true;
		table.insert(tmpList, oTmp);
		
		--SPELLCASTGOSELFTARGETTED = "You cast %s on %s.";
		oTmp = SW_C_Message:new("SPELLCASTGOSELFTARGETTED"); 
		oTmp:setCaptures(SW_Types.String.Skill, SW_Types.String.Target); 
		oTmp:setFromSelf(true); oTmp.IsCast = true;
		table.insert(tmpList, oTmp);
		
		--SPELLCASTOTHERSTART = "%s begins to cast %s.";
		oTmp = SW_C_Message:new("SPELLCASTOTHERSTART"); 
		oTmp:setCaptures(SW_Types.String.Source, SW_Types.String.Skill); 
		oTmp.IsCast = true;
		table.insert(tmpList, oTmp);
		
		--SPELLCASTSELFSTART = "You begin to cast %s.";
		oTmp = SW_C_Message:new("SPELLCASTSELFSTART"); 
		oTmp:setCaptures(SW_Types.String.Skill); 
		oTmp:setFromSelf(true); oTmp.IsCast = true;
		table.insert(tmpList, oTmp);
		
		--SPELLTERSE_OTHER = "%s casts %s.";
		oTmp = SW_C_Message:new("SPELLTERSE_OTHER"); 
		oTmp:setCaptures(SW_Types.String.Source, SW_Types.String.Skill); 
		oTmp.IsCast = true;
		table.insert(tmpList, oTmp);
		
		--SPELLTERSE_SELF = "You cast %s.";
		oTmp = SW_C_Message:new("SPELLTERSE_SELF"); 
		oTmp:setCaptures(SW_Types.String.Skill); 
		oTmp:setFromSelf(true); oTmp.IsCast = true;
		table.insert(tmpList, oTmp);
			
		--SPELLTERSEPERFORM_OTHER = "%s performs %s.";
		oTmp = SW_C_Message:new("SPELLTERSEPERFORM_OTHER"); 
		oTmp:setCaptures(SW_Types.String.Source, SW_Types.String.Skill); 
		oTmp.IsCast = true;
		table.insert(tmpList, oTmp);
		
		--SPELLTERSEPERFORM_SELF = "You perform %s.";
		oTmp = SW_C_Message:new("SPELLTERSEPERFORM_SELF"); 
		oTmp:setCaptures(SW_Types.String.Skill); 
		oTmp:setFromSelf(true); oTmp.IsCast = true;
		table.insert(tmpList, oTmp);
		
		--SIMPLEPERFORMOTHEROTHER = "%s performs %s on %s.";
		oTmp = SW_C_Message:new("SIMPLEPERFORMOTHEROTHER"); 
		oTmp:setCaptures(SW_Types.String.Source, SW_Types.String.Skill, SW_Types.String.Target); 
		oTmp.IsCast = true;
		table.insert(tmpList, oTmp);
		
		--SIMPLEPERFORMOTHERSELF = "%s performs %s on you.";
		oTmp = SW_C_Message:new("SIMPLEPERFORMOTHERSELF"); 
		oTmp:setCaptures(SW_Types.String.Source, SW_Types.String.Skill); 
		oTmp:setToSelf(true); oTmp.IsCast = true;
		table.insert(tmpList, oTmp);
		
		--SIMPLEPERFORMSELFOTHER = "You perform %s on %s.";
		oTmp = SW_C_Message:new("SIMPLEPERFORMSELFOTHER"); 
		oTmp:setCaptures(SW_Types.String.Skill, SW_Types.String.Target); 
		oTmp:setFromSelf(true); oTmp.IsCast = true;
		table.insert(tmpList, oTmp);
		
		--SIMPLEPERFORMSELFSELF = "You perform %s.";
		oTmp = SW_C_Message:new("SIMPLEPERFORMSELFSELF"); 
		oTmp:setCaptures(SW_Types.String.Skill); 
		oTmp:setFromSelf(true); oTmp.IsCast = true;
		table.insert(tmpList, oTmp);
		
		--SPELLPERFORMGOOTHER = "%s performs %s.";
		oTmp = SW_C_Message:new("SPELLPERFORMGOOTHER"); 
		oTmp:setCaptures(SW_Types.String.Source, SW_Types.String.Skill); 
		oTmp.IsCast = true;
		table.insert(tmpList, oTmp);
		
		--SPELLPERFORMGOOTHERTARGETTED = "%s performs %s on %s.";
		oTmp = SW_C_Message:new("SPELLPERFORMGOOTHERTARGETTED"); 
		oTmp:setCaptures(SW_Types.String.Source, SW_Types.String.Skill, SW_Types.String.Target); 
		oTmp.IsCast = true;
		table.insert(tmpList, oTmp);
		
		--SPELLPERFORMGOSELF = "You perform %s.";
		oTmp = SW_C_Message:new("SPELLPERFORMGOSELF"); 
		oTmp:setCaptures(SW_Types.String.Skill); 
		oTmp:setFromSelf(true); oTmp.IsCast = true;
		table.insert(tmpList, oTmp);
		
		--SPELLPERFORMGOSELFTARGETTED = "You perform %s on %s.";
		oTmp = SW_C_Message:new("SPELLPERFORMGOSELFTARGETTED"); 
		oTmp:setCaptures(SW_Types.String.Skill, SW_Types.String.Target); 
		oTmp:setFromSelf(true); oTmp.IsCast = true;
		table.insert(tmpList, oTmp);
		
		--SPELLPERFORMOTHERSTART = "%s begins to perform %s.";
		oTmp = SW_C_Message:new("SPELLPERFORMOTHERSTART"); 
		oTmp:setCaptures(SW_Types.String.Source, SW_Types.String.Skill); 
		oTmp.IsCast = true;
		table.insert(tmpList, oTmp);
		
		--SPELLPERFORMSELFSTART = "You begin to perform %s.";
		oTmp = SW_C_Message:new("SPELLPERFORMSELFSTART"); 
		oTmp:setCaptures(SW_Types.String.Skill); 
		oTmp:setFromSelf(true); oTmp.IsCast = true;
		table.insert(tmpList, oTmp);
		
		--DISPELFAILEDOTHEROTHER ==> %s fails to dispel %s's %s.
		oTmp = SW_C_Message:new("DISPELFAILEDOTHEROTHER"); 
		oTmp:setCaptures(SW_Types.String.Source, SW_Types.String.Target, SW_Types.String.Skill); 
		oTmp.IsFailedDispel = true;
		table.insert(tmpList, oTmp);
		
		--DISPELFAILEDSELFOTHER ==> You fail to dispel %s's %s.
		oTmp = SW_C_Message:new("DISPELFAILEDSELFOTHER"); 
		oTmp:setCaptures(SW_Types.String.Target, SW_Types.String.Skill); 
		oTmp:setFromSelf(true); oTmp.IsFailedDispel = true;
		table.insert(tmpList, oTmp);
		
		--DISPELFAILEDOTHERSELF ==> %s fails to dispel your %s.
		oTmp = SW_C_Message:new("DISPELFAILEDOTHERSELF"); 
		oTmp:setCaptures(SW_Types.String.Source, SW_Types.String.Skill); 
		oTmp:setToSelf(true); oTmp.IsFailedDispel = true;
		table.insert(tmpList, oTmp);
		
		--DISPELFAILEDSELFSELF ==> You fail to dispel your %s.
		oTmp = SW_C_Message:new("DISPELFAILEDSELFSELF"); 
		oTmp:setCaptures(SW_Types.String.Skill); 
		oTmp:setFromSelf(true); oTmp:setToSelf(true); oTmp.IsFailedDispel = true;
		table.insert(tmpList, oTmp);
		
		--IMMUNESPELLSELFSELF ==> You are immune to your %s.",
		oTmp = SW_C_Message:new("IMMUNESPELLSELFSELF"); 
		oTmp:setCaptures(SW_Types.String.Skill); 
		oTmp:setFromSelf(true); oTmp:setToSelf(true);
		table.insert(tmpList, oTmp); oTmp.IsImmune = true; oTmp.IsDmgNullify = true;
		
		--IMMUNESPELLSELFOTHER ==> %s is immune to your %s.",
		oTmp = SW_C_Message:new("IMMUNESPELLSELFOTHER"); 
		oTmp:setCaptures(SW_Types.String.Target, SW_Types.String.Skill); 
		oTmp:setFromSelf(true); oTmp.IsImmune = true; oTmp.IsDmgNullify = true;
		table.insert(tmpList, oTmp);
		
		--IMMUNESPELLOTHERSELF ==> You are immune to %s's %s.",
		oTmp = SW_C_Message:new("IMMUNESPELLOTHERSELF"); 
		oTmp:setCaptures(SW_Types.String.Source, SW_Types.String.Skill); 
		oTmp:setToSelf(true); oTmp.IsImmune = true; oTmp.IsDmgNullify = true;
		table.insert(tmpList, oTmp);
		
		--IMMUNESPELLOTHEROTHER ==> %s is immune to %s's %s.",
		oTmp = SW_C_Message:new("IMMUNESPELLOTHEROTHER"); 
		oTmp:setCaptures(SW_Types.String.Source, SW_Types.String.Target,  SW_Types.String.Skill); 
		oTmp.IsImmune = true; oTmp.IsDmgNullify = true;
		table.insert(tmpList, oTmp);
		
		--IMMUNESELFSELF ==> You hit yourself, but you are immune.",
		oTmp = SW_C_Message:new("IMMUNESELFSELF"); 
		oTmp:setFromSelf(true); oTmp:setToSelf(true);
		table.insert(tmpList, oTmp); oTmp.IsImmune = true; oTmp.IsDmgNullify = true;
		
		--IMMUNESELFOTHER ==> You hit %s, who is immune.",
		oTmp = SW_C_Message:new("IMMUNESELFOTHER"); 
		oTmp:setCaptures(SW_Types.String.Target); 
		oTmp:setFromSelf(true); oTmp.IsImmune = true; oTmp.IsDmgNullify = true;
		table.insert(tmpList, oTmp);
		
		--IMMUNEOTHERSELF ==> %s hits you, but you are immune.",
		oTmp = SW_C_Message:new("IMMUNEOTHERSELF"); 
		oTmp:setCaptures(SW_Types.String.Source); 
		oTmp:setToSelf(true); oTmp.IsImmune = true; oTmp.IsDmgNullify = true;
		table.insert(tmpList, oTmp);
		
		--IMMUNEOTHEROTHER ==> %s hits %s, who is  immune.",
		oTmp = SW_C_Message:new("IMMUNEOTHEROTHER"); 
		oTmp:setCaptures(SW_Types.String.Source, SW_Types.String.Target); 
		oTmp.IsImmune = true; oTmp.IsDmgNullify = true;
		table.insert(tmpList, oTmp);
		
		-- not watched (and known)
		--IMMUNEDAMAGECLASSSELFOTHER ==> %s is immune to your %s damage.",
		--IMMUNEDAMAGECLASSOTHERSELF ==> You are immune to %s's %s damage.",
		--IMMUNEDAMAGECLASSOTHEROTHER ==> %s is immune to %s's %s damage.",
		--SPELLDURABILITYDAMAGEALLOTHERSELF ==> %s casts %s on you: all items damaged.",
		--SPELLDURABILITYDAMAGEALLOTHEROTHER ==> %s casts %s on %s: all items damaged.",
		--SPELLDURABILITYDAMAGEALLSELFOTHER ==> You cast %s on %s: all items damaged.",
		--SPELLDURABILITYDAMAGESELFOTHER ==> You cast %s on %s: %s damaged.",
		--SPELLDURABILITYDAMAGEOTHERSELF ==> %s casts %s on you: %s damaged.",
		--SPELLDURABILITYDAMAGEOTHEROTHER ==> %s casts %s on %s: %s damaged.",
		--ITEMENCHANTMENTADDOTHERSELF ==> %s casts %s on your %s.",
		--ITEMENCHANTMENTREMOVEOTHER ==> %s has faded from %s's %s.",
		--ITEMENCHANTMENTREMOVESELF ==> %s has faded from your %s.",
		--ITEMENCHANTMENTADDOTHEROTHER ==> %s casts %s on %s's %s.",
		--ITEMENCHANTMENTADDSELFSELF ==> You cast %s on your %s.",
		--ITEMENCHANTMENTADDSELFOTHER ==> You cast %s on %s's %s.",
		--OPEN_LOCK_SELF ==> You perform %s on %s.",
		--OPEN_LOCK_OTHER ==> %s performs %s on %s.",
		
		
		for i, o in ipairs(tmpList) do
			--SW_printStr(i.." "..o.regEx);
			if o:finalizeInit() then
				self:addMsg(o);
			else
				SW_DBG("Could not init: "..o.Message);
				SW_DumpMessageTable(o);
			end
			
		end
		-- reset the list and use only items that made it through init
		tmpList = {};
		for _, o in pairs(self.globalMessages ) do
			table.insert(tmpList, o);
		end
		
		
		--local v,b,d = GetBuildInfo();
		--local vc = v..b..d..SW_Settings.LAST_V_RUN;
		
		-- rebuild on any version changes, wow or sw
		--[[ actuall after tweeking the sort somewhat i'll leave it at SW_ALWAYS_MO = true (for now)
		if SW_ALWAYS_MO or not SW_RebuildMO or SW_RebuildMO ~= vc or not SW_MasterOrder then
		--]]
			-- this only works because __lt metamethod is defined in SW_C_Messages
			-- its the first "basic sort"
			table.sort(tmpList);
			
			-- this is the brute force sort that does the rest
			self:fixList(tmpList);
			
			for i, o in ipairs(tmpList) do
				self.masterOrder[o.Message] = i;
			end
			--SW_MasterOrder = self.masterOrder;
			--SW_RebuildMO = vc;
		--[[
		else
			SW_printStr("Reordering with MasterOrder");
			-- use the stored master order to sort
			local sortMO = function (a,b)
				return SW_MasterOrder[a.Message] < SW_MasterOrder[b.Message];
			end
			table.sort(tmpList, sortMO);
			self.masterOrder = SW_MasterOrder;
		end
		--]]
		
		-- setup the "brother" list
		-- when one brother is added to a map the other must be added aswell
		-- this is to avoid collisions where we first add a non crit message to a sublist
		-- this non crit message might capture a crit message that isnt in the sublist yet
		-- and thus will never try to find it in the masterList 
		-- (noticed through HEALDCRITxx and HEALDxx messages)
		
		-- Note to self: for the sake of it think of just using dev mode
		-- I have been running the parser with the old data model + the new data model + dev mode with no serious
		-- performace issues. If the parser maps are compleate this isn't needed, and they should be good by now
		-- but im still thinking about just using dev mode for myself (in the parser)
		-- Revisited: i think not...a faktor of about 15 in performance increase is not to shabby
		local sTmp = "";
		self.brotherList = {};
		
		for i, o in ipairs(tmpList) do
			sTmp = string.gsub(o.Message, "CRIT", "");
			if sTmp ~= o.Message then
				if self.masterOrder[sTmp] then
					self.brotherList[o.Message] = sTmp;
					self.brotherList[sTmp] = o.Message;
				end
			end
		end
		self.masterList = tmpList;		
	end,
	
	fixList = function (self, tmpList)
		local maxIter = 200;
		local fixed = false;
		
		for i=1, maxIter do
			if self:fixOneInList(tmpList) then
				fixed = true;
				SW_printStr("|cff20ff20MAP OK 0 Collisions|r -- ResortIterations:"..i);
				break;
			end
		end
		
		if not fixed then
			SW_printStr("THE ADDON WILL 'SORT OF WORK' BUT PLEASE INFORME ME, A Screenshot of this might help me, make sure to display as much info as possible in this window.");
			SW_printStr("Your data will NOT be synced.");
			SW_DBG("Could NOT resort the table to 0 collisions in "..maxIter.." iterations.");
			SW_SYNC_DO = false;
			--SW_TestAllCol();
		end
	end,	
	
	startFixAt = 1,
	
	fixOneInList = function(self, tmpList)
		local captAT = 0;
		local targetID = 0;
		for i=self.startFixAt, table.getn(tmpList) do
			captAT = self.testOneInList(tmpList, i);
			if captAT ~= i then
				if captAT == 0 then
					SW_printStr("~~~~~~~~~NOCAPTURE for "..i);
					SW_printStr(i..":"..tmpList[i].Message);
				else
					SW_printStr("~~~~~~~~~EARLY CAPTURE "..captAT.." for "..i);
					SW_printStr(captAT..":"..tmpList[captAT].Message);
					SW_printStr(i..":"..tmpList[i].Message);
					targetID = i;
					break;
				end
				
			end
		end
		if targetID ~= 0 then
			-- had 2 exakt same messages in FR
			-- SPELLEXTRAATTACK SELF/OTHER and SPELLEXTRAATTACK SELF/OTHER _SINGULAR
			-- after expanding the parser found a few in US aswell but these might be different in other locales.
			if tmpList[targetID].regEx == tmpList[captAT].regEx then
				SW_printStr("Had to remove: "..tmpList[captAT].Message.."  because: "..tmpList[targetID].Message);
				SW_RemoveList[tmpList[captAT].Message] = tmpList[targetID].Message;
				table.remove(tmpList, captAT);
				self.startFixAt = targetID - 1;
			else
				-- move the early cap behind the target cap
				table.insert(tmpList, targetID + 1, tmpList[captAT]);
				table.remove(tmpList, captAT);
				if targetID > 1 then
					self.startFixAt = targetID - 1;
				else
					self.startFixAt = 1;
				end
				
			end
			return false;
		else
			return true;
		end
	end,
	testOneInList = function(tmpList, ID)
		local o = tmpList[ID];
		local s = o.testStr;
		for i,v in ipairs(tmpList) do 
			if v:DoStr(s) then
				return i;
			end
		end
		return 0;
	end,
	
	dumpML = function(self, str, dumpData)
		for k, o in pairs(self.globalMessages) do
			if string.find(k, str) then
				SW_printStr(k);
				if dumpData then
					SW_DumpMessageTable(o);
				end
			end
		end
	end,
	
	dumpSmall = function(self, key)
		for i, o in ipairs(self.masterList) do
			if key then
				if string.find(o.Message, key) then
					SW_printStr(i.. "  ".. o.regEx.."   "..o.Message);
				end
			else
				SW_printStr(i.. "  ".. o.regEx.."   "..o.Message);
			end
		end
	end,
	dump = function (self)
		if self == SW_C_MessageList then
			SW_printStr("Only dump Objects");
		else
			SW_DumpMessageTable(self);
		end
	end,
};


BRDAMAGETEXT_FADEINTIME = 0.2;
BRDAMAGETEXT_HOLDTIME = 0.7;
BRDAMAGETEXT_FADEOUTTIME = 0.3;

BRDAMAGETEXT_VERSION = "1.55";

BRDAMAGETEXT_DEBUG = false;

local brDamageTextStartTime=0;

brDamageText_Texts = {};
brDamageText_Texts = {
	["COMBATHITSCHOOLSELFOTHER"]		= { ["org"]=""; ["new"]=""; ["style"]=2; ["g"]=0; ["s"]=0; ["d"]=0; ["a"]=0; };
	["COMBATHITSELFOTHER"]				= { ["org"]=""; ["new"]=""; ["style"]=1; ["g"]=0; ["s"]=0; ["d"]=0; ["a"]=0; };
	["COMBATHITCRITSCHOOLSELFOTHER"]	= { ["org"]=""; ["new"]=""; ["style"]=2; ["g"]=0; ["s"]=0; ["d"]=0; ["a"]=0; };
	["COMBATHITCRITSELFOTHER"]			= { ["org"]=""; ["new"]=""; ["style"]=1; ["g"]=0; ["s"]=0; ["d"]=0; ["a"]=0; };
	["PERIODICAURADAMAGESELFOTHER"]		= { ["org"]=""; ["new"]=""; ["style"]=4; ["g"]=0; ["s"]=0; ["d"]=0; ["a"]=0; };
	["SPELLLOGSCHOOLSELFOTHER"]			= { ["org"]=""; ["new"]=""; ["style"]=3; ["g"]=0; ["s"]=0; ["d"]=0; ["a"]=0; };
	["SPELLLOGSELFOTHER"]				= { ["org"]=""; ["new"]=""; ["style"]=3; ["g"]=0; ["s"]=0; ["d"]=0; ["a"]=0; };
	["SPELLLOGCRITSCHOOLSELFOTHER"]		= { ["org"]=""; ["new"]=""; ["style"]=3; ["g"]=0; ["s"]=0; ["d"]=0; ["a"]=0; };
	["SPELLLOGCRITSELFOTHER"]			= { ["org"]=""; ["new"]=""; ["style"]=3; ["g"]=0; ["s"]=0; ["d"]=0; ["a"]=0; };
	["SPELLSPLITDAMAGESELFOTHER"]		= { ["org"]=""; ["new"]=""; ["style"]=3; ["g"]=0; ["s"]=0; ["d"]=0; ["a"]=0; };
	["SPELLLOGABSORBSELFOTHER"]			= { ["org"]=""; ["new"]=""; ["style"]=5; ["g"]=0; ["s"]=0; ["d"]=0; ["a"]=0; };
	["SPELLDEFLECTEDSELFOTHER"]			= { ["org"]=""; ["new"]=""; ["style"]=5; ["g"]=0; ["s"]=0; ["d"]=0; ["a"]=0; };
	["SPELLDODGEDSELFOTHER"]			= { ["org"]=""; ["new"]=""; ["style"]=5; ["g"]=0; ["s"]=0; ["d"]=0; ["a"]=0; };
	["SPELLEVADEDSELFOTHER"]			= { ["org"]=""; ["new"]=""; ["style"]=5; ["g"]=0; ["s"]=0; ["d"]=0; ["a"]=0; };
	["SPELLIMMUNESELFOTHER"]			= { ["org"]=""; ["new"]=""; ["style"]=5; ["g"]=0; ["s"]=0; ["d"]=0; ["a"]=0; };
	["SPELLPARRIEDSELFOTHER"]			= { ["org"]=""; ["new"]=""; ["style"]=5; ["g"]=0; ["s"]=0; ["d"]=0; ["a"]=0; };
	["SPELLREFLECTSELFOTHER"]			= { ["org"]=""; ["new"]=""; ["style"]=5; ["g"]=0; ["s"]=0; ["d"]=0; ["a"]=0; };
	["SPELLRESISTSELFOTHER"]			= { ["org"]=""; ["new"]=""; ["style"]=5; ["g"]=0; ["s"]=0; ["d"]=0; ["a"]=0; };
	["SPELLMISSSELFOTHER"]				= { ["org"]=""; ["new"]=""; ["style"]=5; ["g"]=0; ["s"]=0; ["d"]=0; ["a"]=0; };
	["SPELLINTERRUPTSELFOTHER"]			= { ["org"]=""; ["new"]=""; ["style"]=5; ["g"]=0; ["s"]=0; ["d"]=0; ["a"]=0; };	-- 5 is not really correct, but it should work anyways :)
	["VSABSORBSELFOTHER"]				= { ["org"]=""; ["new"]=""; ["style"]=6; ["g"]=0; ["s"]=0; ["d"]=0; ["a"]=0; };
	["VSBLOCKSELFOTHER"]				= { ["org"]=""; ["new"]=""; ["style"]=6; ["g"]=0; ["s"]=0; ["d"]=0; ["a"]=0; };
	["VSDEFLECTSELFOTHER"]				= { ["org"]=""; ["new"]=""; ["style"]=6; ["g"]=0; ["s"]=0; ["d"]=0; ["a"]=0; };
	["VSDODGESELFOTHER"]				= { ["org"]=""; ["new"]=""; ["style"]=6; ["g"]=0; ["s"]=0; ["d"]=0; ["a"]=0; };
	["VSEVADESELFOTHER"]				= { ["org"]=""; ["new"]=""; ["style"]=6; ["g"]=0; ["s"]=0; ["d"]=0; ["a"]=0; };
	["VSIMMUNESELFOTHER"]				= { ["org"]=""; ["new"]=""; ["style"]=6; ["g"]=0; ["s"]=0; ["d"]=0; ["a"]=0; };
	["VSPARRYSELFOTHER"]				= { ["org"]=""; ["new"]=""; ["style"]=6; ["g"]=0; ["s"]=0; ["d"]=0; ["a"]=0; };
	["VSRESISTSELFOTHER"]				= { ["org"]=""; ["new"]=""; ["style"]=6; ["g"]=0; ["s"]=0; ["d"]=0; ["a"]=0; };
	["MISSEDSELFOTHER"]					= { ["org"]=""; ["new"]=""; ["style"]=6; ["g"]=0; ["s"]=0; ["d"]=0; ["a"]=0; };
	-- healing
	["HEALEDCRITSELFOTHER"]				= { ["org"]=""; ["new"]=""; ["style"]=7; ["g"]=0; ["s"]=0; ["d"]=0; ["a"]=0; };
	["HEALEDCRITSELFSELF"]				= { ["org"]=""; ["new"]=""; ["style"]=8; ["g"]=0; ["s"]=0; ["d"]=0; ["a"]=0; };
	["HEALEDSELFOTHER"]					= { ["org"]=""; ["new"]=""; ["style"]=7; ["g"]=0; ["s"]=0; ["d"]=0; ["a"]=0; };
	["HEALEDSELFSELF"]					= { ["org"]=""; ["new"]=""; ["style"]=8; ["g"]=0; ["s"]=0; ["d"]=0; ["a"]=0; };
};

function brDamageText_OnLoad()

	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("PLAYER_LEAVING_WORLD");
	this:RegisterEvent("VARIABLES_LOADED");

--	this:RegisterEvent("UNIT_COMBAT");
	
	SlashCmdList["BRDMGTXT"] = brDamageText_Options;
	SLASH_BRDMGTXT1 = "/brdamagetext";
  	SLASH_BRDMGTXT2 = "/brdt";
  	SLASH_BRDMGTXT3 = "/brdmgtxt";
end

function brDamageText_Options()
	brDamageTextOptionsFrame:Show();
end

function brDamageText_Init()

	brDamageText_LoadVarsFirstTime();

	brDamageText:SetFont(BRDAMAGETEXT["FontPath"], BRDAMAGETEXT["FontSize"], BRDAMAGETEXT["FontFlags"]);
	
	if (BRDAMAGETEXT_ADDON and BRDAMAGETEXT_ADDON[BRDAMAGETEXT["Frame"]] and BRDAMAGETEXT_ADDON[BRDAMAGETEXT["Frame"]] ~= "") then
		if (not IsAddOnLoaded(BRDAMAGETEXT_ADDON[BRDAMAGETEXT["Frame"]])) then
			ChatFrame1:AddMessage("Addon "..BRDAMAGETEXT_ADDON[BRDAMAGETEXT["Frame"]].." not found, resetting to default!");
			
			BRDAMAGETEXT["Frame"] = 1;
			
			UIDropDownMenu_SetSelectedID(brDamageTextOptionsFrameDropDown, BRDAMAGETEXT["Frame"]);
			UIDropDownMenu_SetText(BRDAMAGETEXT_VALUES_ID[BRDAMAGETEXT["Frame"]], brDamageTextOptionsFrameDropDown)
			brDamageTextOptionsFrameDropDown.tooltip = BRDAMAGETEXT_TOOLTIP_ID[BRDAMAGETEXT["Frame"]];
		end
	end
	
	if (BRDAMAGETEXT_FRAMENAMES[BRDAMAGETEXT["Frame"]] == nil or BRDAMAGETEXT_FRAMENAMES[BRDAMAGETEXT["Frame"]] == "") then
		brDamageText:ClearAllPoints();
		brDamageText:SetPoint("CENTER","brDamageTextFrame","CENTER", 0, 0);
	else
		brDamageText:ClearAllPoints();
		brDamageText:SetPoint("CENTER",BRDAMAGETEXT_FRAMENAMES[BRDAMAGETEXT["Frame"]],"CENTER", 0, 0);
	end
	
	if (BRDAMAGETEXT["Frame"] == 2) then
		brDamageTextOwnFrame:Show();
	else
		brDamageTextOwnFrame:Hide();
	end

	-- ok, that way is totally crap, but it works and I'm too lazy to change it ;)
	table.foreach(brDamageText_Texts,brDamageText_ParseTable);
	
	DEFAULT_CHAT_FRAME:AddMessage(GetAddOnMetadata("brDamageText", "Title").." loaded");
end

function brDamageText_OnEvent()
--	DEFAULT_CHAT_FRAME:AddMessage("event:"..event);
	if (event=="PLAYER_ENTERING_WORLD") then
--		this:RegisterEvent("CHAT_MSG_COMBAT_PET_HITS");									-- melee hits from your/all(?) pet(s)
--		this:RegisterEvent("CHAT_MSG_COMBAT_PET_MISSES");								-- misses from your/all(?) pet(s)
		this:RegisterEvent("CHAT_MSG_COMBAT_SELF_HITS");								-- your melee hits
		this:RegisterEvent("CHAT_MSG_COMBAT_SELF_MISSES");								-- your misses
	
		this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE");					-- for dots
		this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE");				-- for dots on other faction/npc

		this:RegisterEvent("CHAT_MSG_SPELL_HOSTILEPLAYER_BUFF");						--
		this:RegisterEvent("CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE");						--
		this:RegisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE");								-- spelldmg you do
--		this:RegisterEvent("CHAT_MSG_SPELL_PET_BUFF");									--
--		this:RegisterEvent("CHAT_MSG_SPELL_PET_DAMAGE");								-- spelldmg from your/all(?) pet(s)

		this:RegisterEvent("CHAT_MSG_SPELL_SELF_BUFF");									-- you heal somebody

	elseif (event=="PLAYER_LEAVING_WORLD") then

--		this:UnregisterEvent("CHAT_MSG_COMBAT_PET_HITS");								-- dmg from your/all(?) pet(s)
--		this:UnregisterEvent("CHAT_MSG_COMBAT_PET_MISSES");								-- misses from your/all(?) pet(s)
		this:UnregisterEvent("CHAT_MSG_COMBAT_SELF_HITS");								-- your melee hits
		this:UnregisterEvent("CHAT_MSG_COMBAT_SELF_MISSES");							-- your misses

		this:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE");				-- for dots
		this:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE");			-- for dots on other faction/npc

		this:UnregisterEvent("CHAT_MSG_SPELL_HOSTILEPLAYER_BUFF");						--
		this:UnregisterEvent("CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE");					--
		this:UnregisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE");								-- spelldmg you do
--		this:UnregisterEvent("CHAT_MSG_SPELL_PET_BUFF");								--
--		this:UnregisterEvent("CHAT_MSG_SPELL_PET_DAMAGE");								--

		this:UnregisterEvent("CHAT_MSG_SPELL_SELF_BUFF");								-- you heal somebody

	elseif (event=="VARIABLES_LOADED") then
		brDamageText_Init();
	else
		if (BRDAMAGETEXT_DEBUG) then
			ChatFrame1:AddMessage("EVENT =>"..event.."<=");
		end
		if ( strsub(event, 1, 8) == "CHAT_MSG" ) then
			local brtype = strsub(event, 10);
			local brinfo = ChatTypeInfo[brtype];
			if ( strsub(brtype,1,7) == "COMBAT_" ) then
				brDamageText_ParseString("COMBAT",arg1);
				--%1$s = gegner (.+)
				--%2$d = dmg (%d+)
				--%3$s = art (.+)
				--%4$s = spell
			elseif ( strsub(brtype,1,6) == "SPELL_" ) then
				--DEFAULT_CHAT_FRAME:AddMessage(event.." - "..brtype.." - "..arg1);
				brDamageText_ParseString("SPELL",arg1);
				--%1$s = spell (.+)
				--%2$s = gegner (.+)
				--%3$d = dmg (%d+)
				--%4$s = art (.+)
			end
	
		end
	end
end

function brDamageText_ParseTable(k,v)
	brDamageText_FixTable(k,getglobal(k));
end

function brDamageText_FixString(str)
	str = string.gsub(str,"%.","%%.");
	str = string.gsub(str,"%(","%%(");
	str = string.gsub(str,"%)","%%)");
	return str;
end

function brDamageText_FixTable(key, str)
	local cnt=0;
	local i=1;
	brDamageText_Texts[key]["org"] = str;
	str = brDamageText_FixString(str);
	
	if (brDamageText_Texts[key]["style"] == 1) then
		--%1$s = target (.+)
		--%2$d = dmg (%d+)
		if (string.find(str,"%%1$s")) then
			for i=1,string.len(str) do
				if (string.sub(str,i,i) == "%") then
					if (string.sub(str,i,i+3) == "%1$s") then
						str = string.sub(str,1,i-1) .. "(.+)" .. string.sub(str,i+4);
						cnt=cnt+1;
						brDamageText_Texts[key]["g"] = cnt;
					elseif (string.sub(str,i,i+3) == "%2$d") then
						str = string.sub(str,1,i-1) .. "(%d+)" .. string.sub(str,i+4);
						cnt=cnt+1;
						brDamageText_Texts[key]["d"] = cnt;
					end
				end
			end
		else
			i = 1;
			while i < string.len(str) do
				if (string.sub(str,i,i) == "%") then
					if (string.sub(str,i,i+1) == "%s") then
						str = string.sub(str,1,i-1) .. "(.+)" .. string.sub(str,i+2);
						i=i+3;
					elseif (string.sub(str,i,i+1) == "%d" and string.sub(str,i-1,i+3) ~= "(%d+)") then
						str = string.sub(str,1,i-1) .. "(%d+)" .. string.sub(str,i+2);
						i=i+4;
					end
				end
				i=i+1;
			end
			brDamageText_Texts[key]["g"] = 1;
			brDamageText_Texts[key]["d"] = 2;
		end
		brDamageText_Texts[key]["new"] = str;
	elseif (brDamageText_Texts[key]["style"] == 2) then
		--%1$s = target (.+)
		--%2$d = dmg (%d+)
		--%3$s = type (.+)
		if (string.find(str,"%%1$s")) then
			for i=1,string.len(str) do
				if (string.sub(str,i,i) == "%") then
					if (string.sub(str,i,i+3) == "%1$s") then
						str = string.sub(str,1,i-1) .. "(.+)" .. string.sub(str,i+4);
						cnt=cnt+1;
						brDamageText_Texts[key]["g"] = cnt;
					elseif (string.sub(str,i,i+3) == "%2$d") then
						str = string.sub(str,1,i-1) .. "(%d+)" .. string.sub(str,i+4);
						cnt=cnt+1;
						brDamageText_Texts[key]["d"] = cnt;
					elseif (string.sub(str,i,i+3) == "%3$s") then
						str = string.sub(str,1,i-1) .. "(.+)" .. string.sub(str,i+4);
						cnt=cnt+1;
						brDamageText_Texts[key]["a"] = cnt;
					end
				end
			end
		else
			i = 1;
			while i < string.len(str) do
				if (string.sub(str,i,i) == "%") then
					if (string.sub(str,i,i+1) == "%s") then
						str = string.sub(str,1,i-1) .. "(.+)" .. string.sub(str,i+2);
						i=i+3;
					elseif (string.sub(str,i,i+1) == "%d" and string.sub(str,i-1,i+3) ~= "(%d+)") then
						str = string.sub(str,1,i-1) .. "(%d+)" .. string.sub(str,i+2);
						i=i+4;
					end
				end
				i=i+1;
			end
			brDamageText_Texts[key]["g"] = 1;
			brDamageText_Texts[key]["d"] = 2;
			brDamageText_Texts[key]["a"] = 3;
		end
		brDamageText_Texts[key]["new"] = str;
	elseif (brDamageText_Texts[key]["style"] == 3) then
		--%1$s = spell (.+)
		--%2$s = gegner (.+)
		--%3$d = dmg (%d+)
		--%4$s = art (.+)
		if (string.find(str,"%%1$s")) then
			for i=1,string.len(str) do
				if (string.sub(str,i,i) == "%") then
					if (string.sub(str,i,i+3) == "%1$s") then
						str = string.sub(str,1,i-1) .. "(.+)" .. string.sub(str,i+4);
						cnt=cnt+1;
						brDamageText_Texts[key]["s"] = cnt;
					elseif (string.sub(str,i,i+3) == "%2$s") then
						str = string.sub(str,1,i-1) .. "(.+)" .. string.sub(str,i+4);
						cnt=cnt+1;
						brDamageText_Texts[key]["g"] = cnt;
					elseif (string.sub(str,i,i+3) == "%3$d") then
						str = string.sub(str,1,i-1) .. "(%d+)" .. string.sub(str,i+4);
						cnt=cnt+1;
						brDamageText_Texts[key]["d"] = cnt;
					elseif (string.sub(str,i,i+3) == "%4$s") then
						str = string.sub(str,1,i-1) .. "(.+)" .. string.sub(str,i+4);
						cnt=cnt+1;
						brDamageText_Texts[key]["a"] = cnt;
					end
				end
			end
		else
			i = 1;
			while i < string.len(str) do
				if (string.sub(str,i,i) == "%") then
					if (string.sub(str,i,i+1) == "%s") then
						str = string.sub(str,1,i-1) .. "(.+)" .. string.sub(str,i+2);
						i=i+3;
					elseif (string.sub(str,i,i+1) == "%d" and string.sub(str,i-1,i+3) ~= "(%d+)") then
						str = string.sub(str,1,i-1) .. "(%d+)" .. string.sub(str,i+2);
						i=i+4;
					end
				end
				i=i+1;
			end
			brDamageText_Texts[key]["s"] = 1;
			brDamageText_Texts[key]["g"] = 2;
			brDamageText_Texts[key]["d"] = 3;
			brDamageText_Texts[key]["a"] = 4;
		end
		brDamageText_Texts[key]["new"] = str;
	elseif (brDamageText_Texts[key]["style"] == 4) then
		--%1$s = gegner (.+)
		--%2$d = dmg (%d+)
		--%3$s = art (.+)
		--%4$s = spell
		--DEFAULT_CHAT_FRAME:AddMessage(str);
		if (string.find(str,"%%1$s")) then
			for i=1,string.len(str) do
				if (string.sub(str,i,i) == "%") then
					if (string.sub(str,i,i+3) == "%1$s") then
						str = string.sub(str,1,i-1) .. "(.+)" .. string.sub(str,i+4);
						cnt=cnt+1;
						brDamageText_Texts[key]["g"] = cnt;
					elseif (string.sub(str,i,i+3) == "%2$d") then
						str = string.sub(str,1,i-1) .. "(%d+)" .. string.sub(str,i+4);
						cnt=cnt+1;
						brDamageText_Texts[key]["d"] = cnt;
					elseif (string.sub(str,i,i+3) == "%3$s") then
						str = string.sub(str,1,i-1) .. "(.+)" .. string.sub(str,i+4);
						cnt=cnt+1;
						brDamageText_Texts[key]["a"] = cnt;
					elseif (string.sub(str,i,i+3) == "%4$s") then
						str = string.sub(str,1,i-1) .. "(.+)" .. string.sub(str,i+4);
						cnt=cnt+1;
						brDamageText_Texts[key]["s"] = cnt;
					end
				end
			end
		else
			i = 1;
			while i < string.len(str) do
				if (string.sub(str,i,i) == "%") then
					if (string.sub(str,i,i+1) == "%s") then
						str = string.sub(str,1,i-1) .. "(.+)" .. string.sub(str,i+2);
						i=i+3;
					elseif (string.sub(str,i,i+1) == "%d" and string.sub(str,i-1,i+3) ~= "(%d+)") then
						str = string.sub(str,1,i-1) .. "(%d+)" .. string.sub(str,i+2);
						i=i+4;
					end
				end
				i=i+1;
			end
			brDamageText_Texts[key]["g"] = 1;
			brDamageText_Texts[key]["d"] = 2;
			brDamageText_Texts[key]["a"] = 3;
			brDamageText_Texts[key]["s"] = 4;
		end
		--DEFAULT_CHAT_FRAME:AddMessage(str);
		brDamageText_Texts[key]["new"] = str;
	elseif (brDamageText_Texts[key]["style"] == 5) then
		--%1$s = spell (.+)
		--%2$s = gegner (.+)
		if (string.find(str,"%%1$s")) then
			for i=1,string.len(str) do
				if (string.sub(str,i,i) == "%") then
					if (string.sub(str,i,i+3) == "%1$s") then
						str = string.sub(str,1,i-1) .. "(.+)" .. string.sub(str,i+4);
						cnt=cnt+1;
						brDamageText_Texts[key]["s"] = cnt;
					elseif (string.sub(str,i,i+3) == "%2$s") then
						str = string.sub(str,1,i-1) .. "(.+)" .. string.sub(str,i+4);
						cnt=cnt+1;
						brDamageText_Texts[key]["g"] = cnt;
					end
				end
			end
		else
			i = 1;
			while i < string.len(str) do
				if (string.sub(str,i,i) == "%") then
					if (string.sub(str,i,i+1) == "%s") then
						str = string.sub(str,1,i-1) .. "(.+)" .. string.sub(str,i+2);
						i=i+3;
					elseif (string.sub(str,i,i+1) == "%d" and string.sub(str,i-1,i+3) ~= "(%d+)") then
						str = string.sub(str,1,i-1) .. "(%d+)" .. string.sub(str,i+2);
						i=i+4;
					end
				end
				i=i+1;
			end
			brDamageText_Texts[key]["s"] = 1;
			brDamageText_Texts[key]["g"] = 2;
		end
		brDamageText_Texts[key]["new"] = str;
	elseif (brDamageText_Texts[key]["style"] == 6) then
		--%1$s = gegner (.+)
		if (string.find(str,"%%1$s")) then
			for i=1,string.len(str) do
				if (string.sub(str,i,i) == "%") then
					if (string.sub(str,i,i+3) == "%1$s") then
						str = string.sub(str,1,i-1) .. "(.+)" .. string.sub(str,i+4);
						cnt=cnt+1;
						brDamageText_Texts[key]["g"] = cnt;
					end
				end
			end
		else
			i = 1;
			while i < string.len(str) do
				if (string.sub(str,i,i) == "%") then
					if (string.sub(str,i,i+1) == "%s") then
						str = string.sub(str,1,i-1) .. "(.+)" .. string.sub(str,i+2);
						i=i+3;
					end
				end
				i=i+1;
			end
			brDamageText_Texts[key]["g"] = 1;
		end
		brDamageText_Texts[key]["new"] = str;
	elseif (brDamageText_Texts[key]["style"] == 7) then
		--%1$s = spell (.+)
		--%2$s = target (.+)
		--%3$d = amount (%d+)
		--DEFAULT_CHAT_FRAME:AddMessage(str);
		if (string.find(str,"%%1$s")) then
			for i=1,string.len(str) do
				if (string.sub(str,i,i) == "%") then
					if (string.sub(str,i,i+3) == "%1$s") then
						str = string.sub(str,1,i-1) .. "(.+)" .. string.sub(str,i+4);
						cnt=cnt+1;
						brDamageText_Texts[key]["s"] = cnt;
					elseif (string.sub(str,i,i+3) == "%2$s") then
						str = string.sub(str,1,i-1) .. "(.+)" .. string.sub(str,i+4);
						cnt=cnt+1;
						brDamageText_Texts[key]["g"] = cnt;
					elseif (string.sub(str,i,i+3) == "%3$d") then
						str = string.sub(str,1,i-1) .. "(%d+)" .. string.sub(str,i+4);
						cnt=cnt+1;
						brDamageText_Texts[key]["d"] = cnt;
					end
				end
			end
		else
			i = 1;
			while i < string.len(str) do
				if (string.sub(str,i,i) == "%") then
					if (string.sub(str,i,i+1) == "%s") then
						str = string.sub(str,1,i-1) .. "(.+)" .. string.sub(str,i+2);
						i=i+3;
					elseif (string.sub(str,i,i+1) == "%d" and string.sub(str,i-1,i+3) ~= "(%d+)") then
						str = string.sub(str,1,i-1) .. "(%d+)" .. string.sub(str,i+2);
						i=i+4;
					end
				end
				i=i+1;
			end
			brDamageText_Texts[key]["s"] = 1;
			brDamageText_Texts[key]["g"] = 2;
			brDamageText_Texts[key]["d"] = 3;
		end
		--DEFAULT_CHAT_FRAME:AddMessage(str);
		brDamageText_Texts[key]["new"] = str;
	elseif (brDamageText_Texts[key]["style"] == 8) then
		--%1$s = spell (.+)
		--%2$d = amount (%d+)
		--DEFAULT_CHAT_FRAME:AddMessage(str);
		if (string.find(str,"%%1$s")) then
			for i=1,string.len(str) do
				if (string.sub(str,i,i) == "%") then
					if (string.sub(str,i,i+3) == "%1$s") then
						str = string.sub(str,1,i-1) .. "(.+)" .. string.sub(str,i+4);
						cnt=cnt+1;
						brDamageText_Texts[key]["s"] = cnt;
					elseif (string.sub(str,i,i+3) == "%2$d") then
						str = string.sub(str,1,i-1) .. "(%d+)" .. string.sub(str,i+4);
						cnt=cnt+1;
						brDamageText_Texts[key]["d"] = cnt;
					end
				end
			end
		else
			i = 1;
			while i < string.len(str) do
				if (string.sub(str,i,i) == "%") then
					if (string.sub(str,i,i+1) == "%s") then
						str = string.sub(str,1,i-1) .. "(.+)" .. string.sub(str,i+2);
						i=i+3;
					elseif (string.sub(str,i,i+1) == "%d" and string.sub(str,i-1,i+3) ~= "(%d+)") then
						str = string.sub(str,1,i-1) .. "(%d+)" .. string.sub(str,i+2);
						i=i+4;
					end
				end
				i=i+1;
			end
			brDamageText_Texts[key]["s"] = 1;
			brDamageText_Texts[key]["d"] = 2;
		end
		--DEFAULT_CHAT_FRAME:AddMessage(str);
		brDamageText_Texts[key]["new"] = str;
	else
		DEFAULT_CHAT_FRAME:AddMessage("brDamageText: An error occoured while transforming the strings");
	end
end

function brDamageText_ParseString(type, str)
	local tk = "";
	local info = {};
	info.d="";		-- damage
	info.g="";		-- enemy
	info.s="";		-- spellname
	info.a="";		-- spellkind (fire, nature, ...)

	if (BRDAMAGETEXT_DEBUG) then
		ChatFrame1:AddMessage("Typ =>"..type.."<= Str =>"..str.."<=");
	end

	if (type == "COMBAT") then
		for k,v in brDamageText_Texts do
			if (brDamageText_Texts[k]["style"]==1 or brDamageText_Texts[k]["style"]==2 or brDamageText_Texts[k]["style"]==6) then
				if (string.find(str,brDamageText_Texts[k]["new"]) ~= nil) then
					if (BRDAMAGETEXT_DEBUG) then
						DEFAULT_CHAT_FRAME:AddMessage("COMBAT =>"..k.."<==>"..brDamageText_Texts[k]["new"].."<=");
					end
					if (tk == "") then
						tk = k;
					else
						if ( string.find(k, "CRIT") ) then
							tk = k;
						end
					end
				end
			end
		end

		if (tk == "") then
			return;
		end;

		for a,b,c,d in string.gfind( str, brDamageText_Texts[tk]["new"] ) do
			if (brDamageText_Texts[tk]["g"] == 1) then
				info.g = a;
			elseif (brDamageText_Texts[tk]["g"] == 2) then
				info.g = b;
			elseif (brDamageText_Texts[tk]["g"] == 3) then
				info.g = c;
			elseif (brDamageText_Texts[tk]["g"] == 4) then
				info.g = d;
			end
			
			if (brDamageText_Texts[tk]["s"] == 1) then
				info.s = a;
			elseif (brDamageText_Texts[tk]["s"] == 2) then
				info.s = b;
			elseif (brDamageText_Texts[tk]["s"] == 3) then
				info.s = c;
			elseif (brDamageText_Texts[tk]["s"] == 4) then
				info.s = d;
			end
			
			if (brDamageText_Texts[tk]["d"] == 1) then
				info.d = a;
			elseif (brDamageText_Texts[tk]["d"] == 2) then
				info.d = b;
			elseif (brDamageText_Texts[tk]["d"] == 3) then
				info.d = c;
			elseif (brDamageText_Texts[tk]["d"] == 4) then
				info.d = d;
			end

			if (brDamageText_Texts[tk]["a"] == 1) then
				info.a = a;
			elseif (brDamageText_Texts[tk]["a"] == 2) then
				info.a = b;
			elseif (brDamageText_Texts[tk]["a"] == 3) then
				info.a = c;
			elseif (brDamageText_Texts[tk]["a"] == 4) then
				info.a = d;
			end
		end
	elseif (type == "SPELL") then
		--DEFAULT_CHAT_FRAME:AddMessage(str);
		for k,v in brDamageText_Texts do
			if ( brDamageText_Texts[k]["style"]==3 or brDamageText_Texts[k]["style"]==4 or brDamageText_Texts[k]["style"]==5 or
			     brDamageText_Texts[k]["style"]==7 or brDamageText_Texts[k]["style"]==8 or brDamageText_Texts[k]["style"]==9 ) then
				if (string.find(str,brDamageText_Texts[k]["new"]) ~= nil) then
					if (BRDAMAGETEXT_DEBUG) then
						DEFAULT_CHAT_FRAME:AddMessage("SPELL =>"..k.."<==>"..brDamageText_Texts[k]["new"].."<=");
					end
					if (tk == "") then
						tk = k;
					else
						if ( string.find(k, "CRIT") ) then
							tk = k;
						end
					end
				end
			end
		end
		
		if (tk == "") then
			return;
		end;
		
		for a,b,c,d in string.gfind( str, brDamageText_Texts[tk]["new"] ) do
			if (brDamageText_Texts[tk]["g"] == 1) then
				info.g = a;
			elseif (brDamageText_Texts[tk]["g"] == 2) then
				info.g = b;
			elseif (brDamageText_Texts[tk]["g"] == 3) then
				info.g = c;
			elseif (brDamageText_Texts[tk]["g"] == 4) then
				info.g = d;
			end
			
			if (brDamageText_Texts[tk]["s"] == 1) then
				info.s = a;
			elseif (brDamageText_Texts[tk]["s"] == 2) then
				info.s = b;
			elseif (brDamageText_Texts[tk]["s"] == 3) then
				info.s = c;
			elseif (brDamageText_Texts[tk]["s"] == 4) then
				info.s = d;
			end
			
			if (brDamageText_Texts[tk]["d"] == 1) then
				info.d = a;
			elseif (brDamageText_Texts[tk]["d"] == 2) then
				info.d = b;
			elseif (brDamageText_Texts[tk]["d"] == 3) then
				info.d = c;
			elseif (brDamageText_Texts[tk]["d"] == 4) then
				info.d = d;
			end

			if (brDamageText_Texts[tk]["a"] == 1) then
				info.a = a;
			elseif (brDamageText_Texts[tk]["a"] == 2) then
				info.a = b;
			elseif (brDamageText_Texts[tk]["a"] == 3) then
				info.a = c;
			elseif (brDamageText_Texts[tk]["a"] == 4) then
				info.a = d;
			end
		end
	end

	if (BRDAMAGETEXT_DEBUG) then
		ChatFrame1:AddMessage("result =>"..tk.."<= ("..getglobal(tk)..")("..str..")");
	end

	if (brDamageText_CheckValids(tk) and brDamageText_CheckSpellIgnores(info.s)) then
		local target = brDamageText_CheckTarget(info.g);
		--ChatFrame1:AddMessage("WHOOOT =>"..UnitName("target").."=="..target.."<=");
		if (UnitName("target")==target and not UnitIsDead("target")) then
			local brText;
			local brTextHeight;
			local brTextColR = brDamageText_ColSize[tk]["col_r"];
			local brTextColG = brDamageText_ColSize[tk]["col_g"];
			local brTextColB = brDamageText_ColSize[tk]["col_b"];
			if (brDamageText_Texts[tk]["style"] == 5 or brDamageText_Texts[tk]["style"] == 6) then
				if (brDamageText_Vars[tk] ~= nil) then
					brText = brDamageText_Vars[tk];
				end
			else
				brText = info.d;
			end
			brDamageTextStartTime = GetTime();
			if (brDamageText_ColSize[tk]["size"] ~= nil and brDamageText_ColSize[tk]["size"] > 0) then
				brTextHeight = brDamageText_ColSize[tk]["size"];
			else
				brTextHeight = 1;
			end

			if (BRDAMAGETEXT_DEBUG) then
				ChatFrame1:AddMessage("Spell =>"..info.s.."<=");
			end
			if (brDamageText_Special ~= nil and brDamageText_Special[info.s] ~= nil and brDamageText_Special[info.s]["active"]==1) then
				brTextColR   = brDamageText_Special[info.s]["col_r"];
				brTextColG   = brDamageText_Special[info.s]["col_g"];
				brTextColB   = brDamageText_Special[info.s]["col_b"];
			end
			
			brDamageText:SetTextColor(brTextColR, brTextColG, brTextColB);
			brDamageText:SetText(brText);
			brDamageText:SetTextHeight(BRDAMAGETEXT["FontSize"] * brTextHeight);
			brDamageText:SetAlpha(1.0);
			brDamageText:Show();
		end
	end
end

function brDamageText_CheckSpellIgnores(spell)
	local retval = true;
--	ChatFrame1:AddMessage("Spell:"..spell);
	if (brDamageText_SpellIgnores[spell] == true) then
--		ChatFrame1:AddMessage("Spell:"..spell.." resisted");
		retval = false;
	end
	return retval;
end

function brDamageText_CheckTarget(target)
	local retval=target;		-- default is self
	
	if (target and target ~= "") then
		for k,v in BRDAMAGETEXT_SELFTARGET do
			if ( string.lower(BRDAMAGETEXT_SELFTARGET[k]) == string.lower(target) ) then
				retval = UnitName("player");
				break;
			end
		end
	else
		retval = UnitName("player");
	end
	
	return retval;
end

function brDamageText_CheckValids(eventstring)
	-- yes i know, that solution sucks, but that makes it easier vor future changes :)
	local retval=true;
	if (eventstring == "") then
		retval=false;
	else
		if (BRDAMAGETEXT) then
			 if (BRDAMAGETEXT["Dots"]==0) then
			 	if (eventstring=="PERIODICAURADAMAGESELFOTHER") then
		 			retval=false;
			 	end
			 end
			 if (BRDAMAGETEXT["Words"]==0) then
				if (eventstring=="SPELLLOGABSORBSELFOTHER") then
					retval=false;
				elseif (eventstring=="SPELLDEFLECTEDSELFOTHER") then
					retval=false;
				elseif (eventstring=="SPELLDODGEDSELFOTHER") then
					retval=false;
				elseif (eventstring=="SPELLEVADEDSELFOTHER") then
					retval=false;
				elseif (eventstring=="SPELLIMMUNESELFOTHER") then
					retval=false;
				elseif (eventstring=="SPELLPARRIEDSELFOTHER") then
					retval=false;
				elseif (eventstring=="SPELLREFLECTSELFOTHER") then
					retval=false;
				elseif (eventstring=="SPELLRESISTSELFOTHER") then
					retval=false;
				elseif (eventstring=="SPELLMISSSELFOTHER") then
					retval=false;
				elseif (eventstring=="SPELLINTERRUPTSELFOTHER") then
					retval=false;
				elseif (eventstring=="VSABSORBSELFOTHER") then
					retval=false;
				elseif (eventstring=="VSBLOCKSELFOTHER") then
					retval=false;
				elseif (eventstring=="VSDEFLECTSELFOTHER") then
					retval=false;
				elseif (eventstring=="VSDODGESELFOTHER") then
					retval=false;
				elseif (eventstring=="VSEVADESELFOTHER") then
					retval=false;
				elseif (eventstring=="VSIMMUNESELFOTHER") then
					retval=false;
				elseif (eventstring=="VSPARRYSELFOTHER") then
					retval=false;
				elseif (eventstring=="VSRESISTSELFOTHER") then
					retval=false;
				elseif (eventstring=="MISSEDSELFOTHER") then
					retval=false;
				end
			 end
		end
	end
	return retval;
end

function brDamageText_SetTextAlpha()
	local elapsedTime = GetTime() - brDamageTextStartTime;
	local fadeInTime = BRDAMAGETEXT_FADEINTIME;
	if ( elapsedTime < fadeInTime ) then
		local alpha = (elapsedTime / fadeInTime);
		brDamageText:SetAlpha(alpha);
		brDamageText:Show();
		return;
	end
	local holdTime = BRDAMAGETEXT_HOLDTIME;
	if ( elapsedTime < (fadeInTime + holdTime) ) then
		brDamageText:SetAlpha(1.0);
		brDamageText:Show();
		return;
	end
	local fadeOutTime = BRDAMAGETEXT_FADEOUTTIME;
	if ( elapsedTime < (fadeInTime + holdTime + fadeOutTime) ) then
		local alpha = 1.0 - ((elapsedTime - holdTime - fadeInTime) / fadeOutTime);
		brDamageText:SetAlpha(alpha);
		brDamageText:Show();
		return;
	end
	brDamageText:Hide();
end

function brDamageText_OnUpdate(elapsed)
	if (BRDAMAGETEXT and BRDAMAGETEXT["Fade"] and BRDAMAGETEXT["Fade"]==1) then
		brDamageText_SetTextAlpha();
	else
		if (UnitName("target") and not UnitIsDead("target")) then
			brDamageText_SetTextAlpha();
		else
			brDamageText:Hide();
		end
	end
end

function brDamageTextOwnFrame_OnLoad()
	this:RegisterForDrag("LeftButton");
	this:RegisterEvent("VARIABLES_LOADED");
end

function brDamageTextOwnFrame_OnEvent()
	if (event=="VARIABLES_LOADED") then
		this:SetBackdropBorderColor(1,1,1,BRDAMAGETEXT["FrameBorder"]);
		this:SetBackdropColor(1,1,1,BRDAMAGETEXT["FrameBorder"]);
	end
end

function brDamageTextOwnFrame_OnShow()
	if (BRDAMAGETEXT and BRDAMAGETEXT["FrameBorder"]) then
		this:SetBackdropBorderColor(1,1,1,BRDAMAGETEXT["FrameBorder"]);
		this:SetBackdropColor(1,1,1,BRDAMAGETEXT["FrameBorder"]);
	end
end

function brDamageText_LoadVarsFirstTime()
	if (not BRDAMAGETEXT) then
		BRDAMAGETEXT = {};
	end
	if (not BRDAMAGETEXT["Frame"]) then
		BRDAMAGETEXT["Frame"] = 1;
	end
	if (not BRDAMAGETEXT["FrameBorder"]) then
		BRDAMAGETEXT["FrameBorder"] = 1;
	end
	if (not BRDAMAGETEXT["FrameMoveable"]) then
		BRDAMAGETEXT["FrameMoveable"] = 0;
	end
	if (not BRDAMAGETEXT["Dots"]) then
		BRDAMAGETEXT["Dots"] = 1;
	end
	if (not BRDAMAGETEXT["Words"]) then
		BRDAMAGETEXT["Words"] = 1;
	end
	if (not BRDAMAGETEXT["Fade"]) then
		BRDAMAGETEXT["Fade"] = 0;
	end
	if (not BRDAMAGETEXT["FontSize"]) then
		BRDAMAGETEXT["FontSize"] = 32;
	end
	if (not BRDAMAGETEXT["FontName"]) then
		BRDAMAGETEXT["FontName"] = "skurri thickoutline (Default)";
	end
	if (not BRDAMAGETEXT["FontPath"]) then
		BRDAMAGETEXT["FontPath"] = "Fonts\\skurri.ttf";
	end
	if (not BRDAMAGETEXT["FontFlags"]) then
		BRDAMAGETEXT["FontFlags"] = "OUTLINE, THICKOUTLINE";
	end
end
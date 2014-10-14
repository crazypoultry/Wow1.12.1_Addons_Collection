----------------------------------------------------------------------------------------------------
-- Name		: Spell Duration [Library Functions]
----------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------
-- MESSAGES
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
-- Name		: SDSendMsg
-- Comment	: Send a message to the chat
----------------------------------------------------------------------------------------------------
function SDSendMsg(msg, r, g, b, simple)
	if(not r) then r = 1.0; end
	if(not g) then g = 1.0; end
	if(not b) then b = 1.0; end
	if(not msg) then msg = "nil"; end
	if(not simple) then msg = "SD: "..msg; end
	if(DEFAULT_CHAT_FRAME) then DEFAULT_CHAT_FRAME:AddMessage(msg, r, g, b); end
end

----------------------------------------------------------------------------------------------------
-- Name		: SDSendDebugMsg
-- Comment	: Send a debug message to the chat
----------------------------------------------------------------------------------------------------
function SDSendDebugMsg(msg, r, g, b, cmd)
	if(not r) then r = (math.random(100)/100); end
	if(not g) then g = (math.random(100)/100); end
	if(not b) then b = (math.random(100)/100); end
	if(not msg) then msg = "nil"; end
	if(SDGlobal.Debug or not cmd) then SDSendMsg("SD DEBUG[ "..GetTime().." ]: "..msg, r, g, b) end
end

----------------------------------------------------------------------------------------------------
-- STRING
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
-- Name		: SDSetColor
----------------------------------------------------------------------------------------------------
function SDSetColor(color, input)
	local s = "|cff"..color..input.."|r";
	return s;
end

----------------------------------------------------------------------------------------------------
-- Name		: SDBlnToStr
-- Comment	: Only for debug purpose
----------------------------------------------------------------------------------------------------
function SDBlnToStr(input)
	if(input) then return "True" else return "False"; end
end

----------------------------------------------------------------------------------------------------
-- NUMBER
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
-- Name		: SDRound
----------------------------------------------------------------------------------------------------
function SDRound(input, idp)
	if(not idp) then idp = 2; end
	return tonumber(string.format("%."..idp.."f", input));
end

----------------------------------------------------------------------------------------------------
-- Name		: SDIsNumber
----------------------------------------------------------------------------------------------------
function SDIsNumber(input)
	local n = string.gsub(input,"[^0-9]","");
	if(tostring(input) == tostring(n)) then
		return true;
	else
		return false;
	end
end

----------------------------------------------------------------------------------------------------
-- TEXTURE
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
-- Name		: SDPrintDebuffs
-- Comment	: Print the target debuffs texture
-- /script SDPrintDebuffs()
----------------------------------------------------------------------------------------------------
function SDPrintDebuffs()
	local s = "";
	local i = 1;
	while (UnitDebuff("target", i)) do
		s = s..UnitDebuff("target", i).."\n";
		i = i + 1;
	end
	message(s);
end

----------------------------------------------------------------------------------------------------
-- Name		: SDPrintBuffs
-- Comment	: Print the player buff texture
-- /script SDPrintBuffs()
----------------------------------------------------------------------------------------------------
function SDPrintBuffs()
	local s = "";
	local i = 1;
	while (UnitBuff("player", i)) do
		s = s..UnitBuff("player", i).."\n";
		i = i + 1;
	end
	message(s);
end

----------------------------------------------------------------------------------------------------
-- Name		: SDPrintActionTexture
-- Comment	: Print the action bar texture
-- /script SDPrintActionTexture()
----------------------------------------------------------------------------------------------------
function SDPrintActionTexture()
	SpellDurationTooltip:SetOwner(UIParent, "ANCHOR_NONE");
	SpellDurationTooltip:SetAction(1);
	local name =  getglobal("SpellDurationTooltipTextLeft1"):GetText();
	local icon = getglobal("ActionButton1Icon"):GetTexture();
	message(icon);
end

----------------------------------------------------------------------------------------------------
-- Name		: SDPrintTalentTexture
-- Comment	: Print the talents texture
-- /script SDPrintTalentTexture()
----------------------------------------------------------------------------------------------------
function SDPrintTalentTexture(input)
	local tabs = GetNumTalentTabs();
	for t=1, tabs do
		local talents = GetNumTalents(t);
		for i = 1, talents do
			name , iconPath , tier , column , currentRank , maxRank, isExceptional, meetsPrereq = GetTalentInfo(t, i);
			if(name == input) then 
				message(iconPath);
				break;
			end
		end
	end
end
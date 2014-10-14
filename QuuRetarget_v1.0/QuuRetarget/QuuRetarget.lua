-------------------------------------------------------------------------------
-- Quu Retarget
-- A mod that retargets after a fear. Written by Quu
-- Originaly part of "Spell Alert" written by Awen
-------------------------------------------------------------------------------

QRT_TITLE   = "Quu Retarget";
QRT_VERSION = "1.0.0";

local QRT_RetargetName = nil;
local QRT_RetargetClass = nil;
local QRT_RetargetHostile = nil;


-- print simple messages
function QRT_println( Message)
	DEFAULT_CHAT_FRAME:AddMessage("<QRT>"..Message, 1.0, 1.0, 1.0);
end

-- the init
function QRT_Init()
	QRT_println(QRT_TITLE.." "..QRT_VERSION );
end

function QRT_DoReTarget( Reason)
	if (not UnitName("target")) then
		if (QRT_RetargetName) then
			QRT_println(string.gsub( string.gsub( QRT_RETARGET_MSG, "$c", QRT_RetargetName), "$e", Reason));
			TargetLastTarget()
		end
	end
end

function QRT_OnUpdate(arg1)

	-- first thing is to see if we have anybody currently targeted
	local targetName = UnitName("target");
	if (targetName) then
		-- we do... lets save the other information
		_, QRT_RetargetClass = UnitClass("target");
		QRT_RetargetHostile = UnitIsEnemy("player", "target");
	else
		-- we don't... lets check for hunters
		if (QRT_RetargetName and (QRT_RetargetClass == "HUNTER") and QRT_RetargetHostile) then
			-- they are sneeky
			QRT_DoReTarget(QRT_FEIGN_DEATH);
		end
	end
	QRT_RetargetName = targetName;
end

-- this function converts one of the globals into a search string
-- this is important so we don't have to localize them
function QRT_FormatGlobalStrings( globalString)
	local res = globalString;

	-- first reformat the "global" so it can be gsubed
	local i;
	for i = 1, string.len(res) do
		if (string.sub(res, i, i) == "%") then
			if (i == 1) then
				res = "$"..string.sub(res, 2);
			else
				res = string.sub(res, 1, i -1).."$"..string.sub(res, i + 1);
			end
		end
	end
	res = string.gsub(res, "$s", "(.+)");
	res = string.gsub(res, "$d", "(%d)");
	return res;
end

function QRT_Event(arg1)
	for effect in string.gfind(arg1,QRT_FormatGlobalStrings(AURAADDEDSELFHARMFUL)) do
		--AURAADDEDSELFHARMFUL = "You are afflicted by %s."; -- Combat log text for aura events
		if (QRT_ReTarget_Afflictions[effect]) then
			QRT_DoReTarget(effect);
		end
		return;
	end
end


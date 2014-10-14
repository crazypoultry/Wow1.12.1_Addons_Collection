SlashCmdList["HAIL"] = function()
	local string = "Hail";
	local name = UnitName("target");
	if ( name ) then
		string = string .. ", " .. name;
	end
	if ( UnitIsDead("target") or UnitIsCorpse("target") ) then
		string = string .. "'s Corpse";
	end
	SendChatMessage(string, "SAY");
end

SLASH_HAIL1 = "/hail";

BINDING_HEADER_CT_HAILMOD = "CT_HailMod";
BINDING_NAME_CT_HAILMOD_HAIL = "Button Trigger";


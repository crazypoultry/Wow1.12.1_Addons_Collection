-- GLOBAL VARS

frostshoock_lastSpell = nil;
frostshoock_on = false;

frostshoock_oldCastSpell = CastSpell;
function frostshoock_CastSpell(spellId, spellbookTabNum)
	frostshoock_oldCastSpell(spellId, spellbookTabNum);
	frostshoock_lastSpell = GetSpellName(spellId,spellbookTabNum);
end
CastSpell = frostshoock_CastSpell;

frostshoock_oldCastSpellByName = CastSpellByName;
function frostshoock_CastSpellByName(spellName, onSelf)
	frostshoock_oldCastSpellByName(spellName, onSelf);
	frostshoock_lastSpell = spellName;
end
CastSpellByName = frostshoock_CastSpellByName;

frostshoock_oldUseAction = UseAction;
function frostshoock_UseAction(a1, a2, a3)
	frostshoock_oldUseAction(a1, a2, a3);

	frostshoock_ToolTip:SetAction(a1);
	frostshoock_lastSpell = frostshoock_ToolTipTextLeft1:GetText();
	frostshoock_ToolTipTextLeft1:SetText("");
end
UseAction = frostshoock_UseAction;

function frostshoock_OnLoad()
	this:RegisterEvent("SPELLCAST_STOP");

	SLASH_FROSTSHOOCK1 = "/frostshoock";
	SLASH_FROSTSHOOCK2 = "/fs";
	SlashCmdList["FROSTSHOOCK"] = frostshoock_Command;

	frostshoock_on = false;
	DEFAULT_CHAT_FRAME:AddMessage("<FrostShoock> Loaded, Disabled");
	DEFAULT_CHAT_FRAME:AddMessage("<FrostShoock> \"/frostshoock help\" or \"/fs help\" for usage");
end

function frostshoock_OnEvent()
	if event == "SPELLCAST_STOP" then
		if frostshoock_lastSpell then
			if (frostshoock_on and strfind(frostshoock_lastSpell,"Frost Shock") ~= nil) then
				SendChatMessage("FROST SHOOOOOCK!!!!!!","YELL");
			end
		end
		frostshoock_lastSpell = nil;
	end
end

function frostshoock_Command(cmd)
	if cmd and cmd ~= "" then
		DEFAULT_CHAT_FRAME:AddMessage("<FrostShoock> Usage:");
		DEFAULT_CHAT_FRAME:AddMessage("<FrostShoock>   /fs      - toggle yells on/off");
		DEFAULT_CHAT_FRAME:AddMessage("<FrostShoock>   /fs help - Displays this message");
	else
		if frostshoock_on then
			frostshoock_on = false;
			DEFAULT_CHAT_FRAME:AddMessage("<FrostShoock> Disabled");
		else
			frostshoock_on = true;
			DEFAULT_CHAT_FRAME:AddMessage("<FrostShoock> Enabled");
		end
	end
end

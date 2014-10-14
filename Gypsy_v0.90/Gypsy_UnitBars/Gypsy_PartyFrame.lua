--[[
	Gypsy_PartyFrame.lua
	GypsyVersion++2004.11.15++

	This add-on adds a small frame to each party bar that displays party health	in large colored text.
]]

-- ** DEFAULT SETTINGS ** --

-- Color party healty by default
Gypsy_DefaultColorPartyHealth = 1;
-- Do not show health as a percentage by default
Gypsy_DefaultShowPartyPercentage = 0;
-- Show party binding labels by default
Gypsy_DefaultShowPartyBindingLabels = 1;
-- Color party health bars by default
Gypsy_DefaultColorPartyHealthBars = 1;

-- ** GENERAL VARIABLES ** --

-- Max number of buffs to use for our party member buff display
MAX_PARTY_BUFFS = 6;

-- ** PARTY FRAME SETUP FUNCTIONS ** --

-- Event registers
function Gypsy_PartyFrameSetupOnLoad ()
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
end

-- Register Options
function Gypsy_PartyFrameSetupOnEvent (event)
	if (event == "VARIABLES_LOADED") then
		-- Check to see if the party frame is a standalone addon or if the GypsyMod shell is available
		if (GYPSY_SHELL == 1) then
			-- Set defaults if there is no saved value
			if (Gypsy_RetrieveSaved("ColorPartyHealth") == nil) then
				Gypsy_ColorPartyHealth = Gypsy_DefaultColorPartyHealth;
			else
				Gypsy_ColorPartyHealth = Gypsy_RetrieveSaved("ColorPartyHealth");
			end
			if (Gypsy_RetrieveSaved("ShowPartyPercentage") == nil) then
				Gypsy_ShowPartyPercentage = Gypsy_DefaultShowPartyPercentage;
			else
				Gypsy_ShowPartyPercentage = Gypsy_RetrieveSaved("ShowPartyPercentage");
			end
			if (Gypsy_RetrieveSaved("ShowPartyBindingLabels") == nil) then
				Gypsy_ShowPartyBindingLabels = Gypsy_DefaultShowPartyBindingLabels;
			else
				Gypsy_ShowPartyBindingLabels = Gypsy_RetrieveSaved("ShowPartyBindingLabels");
			end
			if (Gypsy_RetrieveSaved("ColorPartyHealthBars") == nil) then
				Gypsy_ColorPartyHealthBars = Gypsy_DefaultColorPartyHealthBars;
			else
				Gypsy_ColorPartyHealthBars = Gypsy_RetrieveSaved("ColorPartyHealthBars");
			end
			--Register with GypsyMod saving
			Gypsy_RegisterOption(220, "header", nil, nil, nil, GYPSY_TEXT_UNITBARS_PARTYHEADERLABEL, GYPSY_TEXT_UNITBARS_PARTYHEADERTOOLTIP);
			Gypsy_RegisterOption(221, "check", Gypsy_ColorPartyHealth, "ColorPartyHealth", nil, GYPSY_TEXT_UNITBARS_COLORPARTYTEXTLABEL, GYPSY_TEXT_UNITBARS_COLORPARTYTEXTTOOLTIP);
			Gypsy_RegisterOption(222, "check", Gypsy_ShowPartyPercentage, "ShowPartyPercentage", nil, GYPSY_TEXT_UNITBARS_PARTYPERCENTLABEL, GYPSY_TEXT_UNITBARS_PARTYPERCENTTOOLTIP);
			Gypsy_RegisterOption(223, "check", Gypsy_ShowPartyBindingLabels, "ShowPartyBindingLabels", Gypsy_UpdatePartyBindingLabels, GYPSY_TEXT_UNITBARS_PARTYBINDINGLABEL, GYPSY_TEXT_UNITBARS_PARTYBINDINGTOOLTIP);
			Gypsy_RegisterOption(224, "check", Gypsy_ColorPartyHealthBars, "ColorPartyHealthBars", nil, GYPSY_TEXT_UNITBARS_COLORPARTYBARLABEL, GYPSY_TEXT_UNITBARS_COLORPARTYBARTOOLTIP);
		else
			-- If our toggles aren't saved, default to on
			if (Gypsy_ColorPartyHealth == nil) then
				Gypsy_ColorPartyHealth = Gypsy_DefaultColorPartyHealth;
			end
			if (Gypsy_ShowPartyPercentage == nil) then
				Gypsy_ShowPartyPercentage = Gypsy_DefaultShowPartyPercentage;
			end
			if (Gypsy_ShowPartyBindingLabels == nil) then
				Gypsy_ShowPartyBindingLabels = Gypsy_DefaultShowPartyBindingLabels;
			end
			if (Gypsy_ColorPartyHealthBars == nil) then
				Gypsy_ColorPartyHealthBars = Gypsy_DefaultColorPartyHealthBars;
			end
			-- Save manually for standalone options
			--RegisterForSave("Gypsy_ColorPartyHealth");
			--RegisterForSave("Gypsy_ShowPartyPercentage");
			--RegisterForSave("Gypsy_ShowPartyBindingLabels");
			--RegisterForSave("Gypsy_ColorPartyHealthBars");
			-- Register slash commands
			SlashCmdList["GYPSY_COLORPARTYHEALTH"] = Gypsy_ColorPartyHealthSlashHandler;
			SLASH_GYPSY_COLORPARTYHEALTH1 = "/unitbarcolorpartyhealth";
			SLASH_GYPSY_COLORPARTYHEALTH2 = "/ubcolorpartyhealth";	
			SlashCmdList["GYPSY_SHOWPARTYPERCENTAGE"] = Gypsy_ShowPartyPercentageSlashHandler;
			SLASH_GYPSY_SHOWPARTYPERCENTAGE1 = "/unitbarpartypercentage";
			SLASH_GYPSY_SHOWPARTYPERCENTAGE2 = "/ubpartypercentage";	
			SlashCmdList["GYPSY_SHOWPARTYBINDINGLABELS"] = Gypsy_ShowPartyBindingLabelsSlashHandler;
			SLASH_GYPSY_SHOWPARTYBINDINGLABELS1 = "/unitbarshowpartybindinglabels";
			SLASH_GYPSY_SHOWPARTYBINDINGLABELS2 = "/ubshowpartybindinglabels";
			SlashCmdList["GYPSY_COLORPARTYHEALTHBARS"] = Gypsy_ColorPartyHealthBarsSlashHandler;
			SLASH_GYPSY_COLORPARTYHEALTHBARS1 = "/unitbarscolorpartyhealthbars";
			SLASH_GYPSY_COLORPARTYHEALTHBARS2 = "/ubcolorpartyhealthbars";
		end
		return;
	end
	if (event == "PLAYER_ENTERING_WORLD") then
		Gypsy_UpdateAllPartyFrames();
	end
end

-- ** PARTY MEMBER FRAME FUNCTIONS ** --

-- OnLoad registrations and scripting for each party frame
function Gypsy_PartyFrameOnLoad ()
	-- Register for member and leader change events for updating the positioning of our graphics and text
	this:RegisterEvent("PARTY_MEMBERS_CHANGED");
	this:RegisterEvent("PARTY_LEADER_CHANGED");
	-- Register for health updates to update our health text, also need to register for mana updates if we use that
	this:RegisterEvent("UNIT_HEALTH");
	this:RegisterEvent("UNIT_MAXHEALTH");
	this:RegisterEvent("PARTY_MEMBER_ENABLE");
	this:RegisterEvent("PARTY_MEMBER_DISABLE");
	this:RegisterEvent("UNIT_AURA");
	-- Register for binding updates for showing the binding above each party frame
	this:RegisterEvent("UPDATE_BINDINGS");
	-- Register for variable loading so we can initialize some settings
	this:RegisterEvent("VARIABLES_LOADED");
	-- Call function to move a default party frame if there are any when you login or reload the UI, and to show our cooresponding additions
	Gypsy_UpdatePartyFrame();
	Gypsy_RefreshBuffs();
end

-- Functions to call when certain events occur for each party frame
function Gypsy_PartyFrameOnEvent (event)
	-- Call our frame update function again whenever leader or members change
	if (event == "PARTY_MEMBERS_CHANGED") then
		Gypsy_UpdatePartyFrame();
		return;
	end
	if (event == "PARTY_LEADER_CHANGED") then
		Gypsy_UpdatePartyFrame();
		return;
	end
	-- If the health changed, update our health numbers
	if (event == "UNIT_HEALTH" or event == "UNIT_MAXHEALTH") then
		Gypsy_ShowPartyText();
		return;
	end
	if ( event == "PARTY_MEMBER_ENABLE" or event == "PARTY_MEMBER_DISABLE" ) then
		if ( arg1 == this:GetID() ) then
			Gypsy_RefreshBuffs();
		end
		return;
	end
	if ( event =="UNIT_AURA" ) then
		local unit = "party"..this:GetID();
		if ( arg1 == unit ) then
			Gypsy_RefreshBuffs();
		end
		return;
	end
	-- Target Party Bar binding label displays
	if ( event == "VARIABLES_LOADED" ) then
		Gypsy_PartyFrameUpdateBindingLabels();
		return;
	end
	if ( event == "UPDATE_BINDINGS" ) then
		Gypsy_PartyFrameUpdateBindingLabels();
		return;
	end
end

function Gypsy_UpdateAllPartyFrames ()
	for i=1, 4 do
		Gypsy_UpdatePartyFrame(i);
	end
end

-- Similar to the UnitUpdatePartyFrame function, but this is called by each party member frame under certain conditions, and actually shows our added frames
function Gypsy_UpdatePartyFrame (id)
	local id = id or this:GetID();
	-- Quick built-in function to check for party member presence
	if (GetPartyMember(id)) then
		-- Show our graphics and text
		this:Show();
		-- Get cooresponding default frame
		local frame = getglobal("PartyMemberFrame" .. id);
		-- Must do this to properly prepare to move the default frame
		frame:ClearAllPoints();
		-- If the frame is the first, move it like so, relative to the target frame...
		if (id == 1) then
			if (Gypsy_InvertUnitFrames == 1) then
				local anchor = Gypsy_InvertCapsulePositions["PartyMember1"];	
				frame:SetPoint(anchor.point, anchor.rel, anchor.relPoint, anchor.x, anchor.y);			
			else
				local anchor = Gypsy_DefaultCapsulePositions["PartyMember1"];
				frame:SetPoint(anchor.point, anchor.rel, anchor.relPoint, anchor.x, anchor.y);			
			end				
		-- else if it's not, anchor it off the previous frame
		else
			local anchorId = id - 1;
			local anchorFrame = "PartyMemberFrame" .. anchorId;
			if (Gypsy_InvertUnitFrames == 1) then
				frame:SetPoint("BOTTOMLEFT", anchorFrame, "TOPLEFT", 0, 20);
			else
				frame:SetPoint("TOPLEFT", anchorFrame, "BOTTOMLEFT", 0, -20);
			end
		end				
		local debuff = getglobal(frame:GetName().."Debuff1");
		debuff:SetPoint("TOPLEFT", frame:GetName(), "TOPLEFT", 48, -50);
		Gypsy_ShowPartyText(id);
	else
		-- Hide our objects when there's no party member
		this:Hide();
	end
end

-- Same code the default debuff display uses, modified for our buff frames
function Gypsy_RefreshBuffs ()
	local texture;
	local idx = 1;
	for i=1, 16 do
		if ( idx <= MAX_PARTY_BUFFS ) then
			texture = UnitBuff("party"..this:GetID(), i);
			if ( texture ) then
				getglobal(this:GetName().."GypsyBuff"..idx.."Icon"):SetTexture(texture);
				getglobal(this:GetName().."GypsyBuff"..idx):SetID(i);
				getglobal(this:GetName().."GypsyBuff"..idx):Show();
				idx = idx + 1;
			end
		end
	end
	for i=idx, MAX_PARTY_BUFFS do
		getglobal(this:GetName().."GypsyBuff"..i):Hide();
	end
end

-- Function to get and show party member frame bindings
function Gypsy_PartyFrameUpdateBindingLabels()
	if (Gypsy_RetrieveOption ~= nil) then
		if (Gypsy_RetrieveOption(223) ~= nil) then
			Gypsy_ShowPartyBindingLabels = Gypsy_RetrieveOption(223)[GYPSY_VALUE];
		end
	end
	local id = this:GetID();
	local label = getglobal("Gypsy_PartyFrame"..id.."BindingLabel");
	local binding = "TARGETPARTYMEMBER"..id;
	if (Gypsy_ShowPartyBindingLabels == 1) then
		label:SetText(GetBindingText(GetBindingKey(binding), "KEY_"));
	else
		label:SetText("");
	end
end
	
-- Function to show our health text
function Gypsy_ShowPartyText(id)
	local id = id or this:GetID();
	if(id == nil or UnitHealth("party"..id) == nil) then
		return;
	end
	
	local text = getglobal("Gypsy_PartyFrame"..id.."MemberHealth");	
	local percent = (UnitHealth("party"..id) / UnitHealthMax("party"..id)) * 100;
	
	if (Gypsy_RetrieveOption) then	
		if (Gypsy_RetrieveOption(222)) then
			Gypsy_ShowPartyPercentage = Gypsy_RetrieveOption(222)[GYPSY_VALUE];
		end
		if (Gypsy_RetrieveOption(221)) then
			Gypsy_ColorPartyHealth = Gypsy_RetrieveOption(221)[GYPSY_VALUE];
		end
		if (Gypsy_RetrieveOption(224)) then
			Gypsy_ColorPartyHealthBars = Gypsy_RetrieveOption(224)[GYPSY_VALUE];
		end
	end
	
	if (Gypsy_ShowPartyPercentage == 1) then
		text:SetText(ceil(percent).."%");
	else
		text:SetText(UnitHealth("party"..id).." / "..UnitHealthMax("party"..id));
	end
	
	if (Gypsy_ColorPartyHealth == 1) then
		if ((percent <= 100) and (percent > 75)) then
			text:SetTextColor(0, 1, 0);
		elseif ((percent <= 75) and (percent > 50)) then
			text:SetTextColor(1, 1, 0);
		elseif ((percent <= 50) and (percent > 25)) then
			text:SetTextColor(1, 0.5, 0);
		else
			text:SetTextColor(1, 0, 0);
		end
	else
		text:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
	end
	
	local bar = getglobal("PartyMemberFrame"..id.."HealthBar");
	
	if (Gypsy_ColorPartyHealthBars == 1) then
		if ((percent <= 100) and (percent > 75)) then
			bar:SetStatusBarColor(0, 1, 0);
		elseif ((percent <= 75) and (percent > 50)) then
			bar:SetStatusBarColor(1, 1, 0);
		elseif ((percent <= 50) and (percent > 25)) then
			bar:SetStatusBarColor(1, 0.5, 0);
		else
			bar:SetStatusBarColor(1, 0, 0);
		end
	else
		bar:SetStatusBarColor(0, 1, 0);
	end
	
	local mana = getglobal("PartyMemberFrame"..id.."ManaBar");
	
	bar:ClearAllPoints();
	bar:SetPoint("TOPLEFT", "PartyMemberFrame"..id, "TOPLEFT", 47, -12);
	mana:ClearAllPoints();
	mana:SetPoint("TOPLEFT", "PartyMemberFrame"..id, "TOPLEFT", 47, -21);
end

-- Update function for party bindings option
function Gypsy_UpdatePartyBindingLabels ()
	if (Gypsy_RetrieveOption ~= nil) then
		if (Gypsy_RetrieveOption(223) ~= nil) then
			Gypsy_ShowPartyBindingLabels = Gypsy_RetrieveOption(223)[GYPSY_VALUE];
		end
	end
	for i=1, 4 do
		if (GetPartyMember(i)) then		
			local label = getglobal("Gypsy_PartyFrame"..i.."BindingLabel");
			local binding = "TARGETPARTYMEMBER"..i;
			if (Gypsy_ShowPartyBindingLabels == 1) then
				label:SetText(GetBindingText(GetBindingKey(binding), "KEY_"));
			else
				label:SetText("");
			end
		end
	end
end

-- * SLASH HANDLER FUNCTIONS * --

function Gypsy_ColorPartyHealthSlashHandler (msg)
	msg = string.lower(msg);
	if (msg == "yes" or msg == "1" or msg == "true") then
		Gypsy_ColorPartyHealth = 1;
		DEFAULT_CHAT_FRAME:AddMessage("Setting party health display text to color according to health percentage.", 1, 1, 1);
	elseif (msg == "no" or msg == "0" or msg == "false") then
		Gypsy_ColorPartyHealth = 0;
		DEFAULT_CHAT_FRAME:AddMessage("Setting party health display text color to default.", 1, 1, 1);
	elseif (msg == "default" or msg == "reset" or msg == "revert") then
		Gypsy_ColorPartyHealth = Gypsy_DefaultColorPartyHealth;
		DEFAULT_CHAT_FRAME:AddMessage("Reverting party health color display state to default.", 1, 1, 1);
	elseif (msg == "help") then
		DEFAULT_CHAT_FRAME:AddMessage("Valid parameters for: /unitbarcolorpartyhealth /unbcolorpartyhealth", 1, 0.89, 0.01);
		DEFAULT_CHAT_FRAME:AddMessage("   help - This listing.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   yes, true, or 1 - Color party health text.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   no, false, or 0 - Do not color party health text.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   default, reset, or revert - Revert to default state.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   blank - Toggle based on current state.", 1, 1, 1);
	elseif (msg == "") then
		if (Gypsy_ColorPartyHealth == 1) then 
			Gypsy_ColorPartyHealth = 0;
			DEFAULT_CHAT_FRAME:AddMessage("Setting party health display text color to default.", 1, 1, 1);
		else 
			Gypsy_ColorPartyHealth = 1; 
			DEFAULT_CHAT_FRAME:AddMessage("Setting party health display text to color according to health percentage.", 1, 1, 1);
		end
	else
		DEFAULT_CHAT_FRAME:AddMessage("Valid parameters for: /unitbarcolorpartyhealth /ubcolorpartyhealth", 1, 0.89, 0.01);
		DEFAULT_CHAT_FRAME:AddMessage("   help - This listing.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   yes, true, or 1 - Color party health text.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   no, false, or 0 - Do not color party health text.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   default, reset, or revert - Revert to default state.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   blank - Toggle based on current state.", 1, 1, 1);
	end
end

function Gypsy_ShowPartyPercentageSlashHandler (msg)
	msg = string.lower(msg);
	if (msg == "show" or msg == "1" or msg == "true") then
		Gypsy_ShowPartyPercentage = 1;
		DEFAULT_CHAT_FRAME:AddMessage("Showing party health text as a percentage.", 1, 1, 1);
	elseif (msg == "hide" or msg == "0" or msg == "false") then
		Gypsy_ShowPartyPercentage = 0;
		DEFAULT_CHAT_FRAME:AddMessage("Showing party health text normally.", 1, 1, 1);
	elseif (msg == "default" or msg == "reset" or msg =="revert") then
		Gypsy_ShowPartyPercentage = Gypsy_DefaultShowPartyPercentage;
		DEFAULT_CHAT_FRAME:AddMessage("Reverting party health text display state to default.", 1, 1, 1);
	elseif (msg == "help") then
		DEFAULT_CHAT_FRAME:AddMessage("Valid parameters for: /unitbarpartypercentage /ubpartypercentage", 1, 0.89, 0.01);
		DEFAULT_CHAT_FRAME:AddMessage("   help - This listing.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   show, true, or 1 - Show party health as a percentage.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   hide, false, or 0 - Do not show party health as a percentage.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   default, reset, or revert - Revert to default state.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   blank - Toggle based on current state.", 1, 1, 1);
	elseif (msg == "") then
		if (Gypsy_ShowPartyPercentage == 1) then 
			Gypsy_ShowPartyPercentage = 0;
			DEFAULT_CHAT_FRAME:AddMessage("Showing party health text normally.", 1, 1, 1);
		else 
			Gypsy_ShowPartyPercentage = 1;
			DEFAULT_CHAT_FRAME:AddMessage("Showing party health as a percentage.", 1, 1, 1);
		end
	else
		DEFAULT_CHAT_FRAME:AddMessage("Valid parameters for: /unitbarpartypercentage /ubpartypercentage", 1, 0.89, 0.01);
		DEFAULT_CHAT_FRAME:AddMessage("   help - This listing.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   show, true, or 1 - Show party health as a percentage.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   hide, false, or 0 - Do not show party health as a percentage.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   default, reset, or revert - Revert to default state.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   blank - Toggle based on current state.", 1, 1, 1);
	end
end

function Gypsy_ShowPartyBindingLabelsSlashHandler(msg)
	msg = string.lower(msg);
	if (msg == "show" or msg == "1" or msg == "true") then
		Gypsy_ShowPartyBindingLabels = 1;
		DEFAULT_CHAT_FRAME:AddMessage("Showing 'Target Party Member' binding labels..", 1, 1, 1);
	elseif (msg == "hide" or msg == "0" or msg == "false") then
		Gypsy_ShowPartyBindingLabels = 0;
		DEFAULT_CHAT_FRAME:AddMessage("Hiding 'Target Party Member' binding labels.", 1, 1, 1);
	elseif (msg == "default" or msg == "reset" or msg == "revert") then
		Gypsy_ShowPartyBindingLabels = Gypsy_DefaultShowPartyBindingLabels;
		DEFAULT_CHAT_FRAME:AddMessage("Reverting target party member binding option state to default.", 1, 1, 1);
	elseif (msg == "help") then
		DEFAULT_CHAT_FRAME:AddMessage("Valid parameters for: /unitbarshowpartybindinglabels /ubshowpartybindinglabels", 1, 0.89, 0.01);
		DEFAULT_CHAT_FRAME:AddMessage("   help - This listing.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   show, true, or 1 - Shows 'Target Party Member' binding labels above the party member bars.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   hide, false, or 0 - Disables showing of binding labels.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   default, reset, or revert - Revert to default state.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   blank - Toggle based on current state.", 1, 1, 1);
	elseif (msg == "") then
		if (Gypsy_ShowPartyBindingLabels == 1) then
			Gypsy_ShowPartyBindingLabels = 0;
			DEFAULT_CHAT_FRAME:AddMessage("Hiding 'Target Party Member' binding labels.", 1, 1, 1);
		else
			Gypsy_ShowPartyBindingLabels = 1;
			DEFAULT_CHAT_FRAME:AddMessage("Showing 'Target Party Member' binding labels.", 1, 1, 1);
		end
	else
		DEFAULT_CHAT_FRAME:AddMessage("Valid parameters for: /unitbarshowpartybindinglabels /ubshowpartybindinglabels", 1, 0.89, 0.01);
		DEFAULT_CHAT_FRAME:AddMessage("   help - This listing.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   show, true, or 1 - Shows 'Target Party Member' binding labels above the party member bars.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   hide, false, or 0 - Disables showing of binding labels.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   default, reset, or revert - Revert to default state.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   blank - Toggle based on current state.", 1, 1, 1);
	end
end

function Gypsy_ColorPartyHealthBarsSlashHandler (msg)
	msg = string.lower(msg);
	if (msg == "yes" or msg == "1" or msg == "true") then
		Gypsy_ColorPartyHealthBars = 1;
		DEFAULT_CHAT_FRAME:AddMessage("Setting party health bar to color according to health percentage.", 1, 1, 1);
	elseif (msg == "no" or msg == "0" or msg == "false") then
		Gypsy_ColorPartyHealthBars = 0;
		DEFAULT_CHAT_FRAME:AddMessage("Setting party health bar color to default.", 1, 1, 1);
	elseif (msg == "default" or msg == "reset" or msg == "revert") then
		Gypsy_ColorPartyHealthBars = Gypsy_DefaultColorPartyHealthBars;
		DEFAULT_CHAT_FRAME:AddMessage("Reverting party health bar color option state to default.", 1, 1, 1);
	elseif (msg == "help") then
		DEFAULT_CHAT_FRAME:AddMessage("Valid parameters for: /unitbarcolorpartyhealthbars /unbcolorpartyhealthbars", 1, 0.89, 0.01);
		DEFAULT_CHAT_FRAME:AddMessage("   help - This listing.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   yes, true, or 1 - Color party health bars progressively.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   no, false, or 0 - Do not color party health bars progressively.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   default, reset, or revert - Revert to default state.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   blank - Toggle based on current state.", 1, 1, 1);
	elseif (msg == "") then
		if (Gypsy_ColorPartyHealthBars == 1) then 
			Gypsy_ColorPartyHealthBars = 0;
			DEFAULT_CHAT_FRAME:AddMessage("Setting party health bar color to default.", 1, 1, 1);
		else 
			Gypsy_ColorPartyHealthBars = 1; 
			DEFAULT_CHAT_FRAME:AddMessage("Setting party health bar to color according to health percentage.", 1, 1, 1);
		end
	else
		DEFAULT_CHAT_FRAME:AddMessage("Valid parameters for: /unitbarcolorpartyhealthbars /unbcolorpartyhealthbars", 1, 0.89, 0.01);
		DEFAULT_CHAT_FRAME:AddMessage("   help - This listing.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   yes, true, or 1 - Color party health bars progressively.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   no, false, or 0 - Do not color party health bars progressively.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   default, reset, or revert - Revert to default state.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   blank - Toggle based on current state.", 1, 1, 1);
	end
end
--  Configuration
PetDefend_Config = { };
PetDefend_Config.Enabled = true;
PetDefend_Config.AssistInCombat = false;
PetDefend_Config.LowHealth = false;
PetDefend_Config.HealthMin = 25;
PetDefend_Config.PetHealth = false;
PetDefend_Config.PetMin = 25;
PetDefend_Config.Growl = true;
PetDefend_Config.GrowlName = "Growl";
PetDefend_Config.Cower = false;
PetDefend_Config.CowerMin = 25;
PetDefend_Config.CowerName = "Cower";
PetDefend_Config.DefendAll = true;
PetDefend_Config.DefendMember = "";
PetDefend_Config.MemberAssisting = "";
PetDefend_Config.Alert = true;
PetDefend_Config.Channel = "PARTY";

-- Variables
PetDefend_Var = { };
PetDefend_Var.InCombat = false;
PetDefend_Var.GrowlToggled = false;
PetDefend_Var.GrowlID = 0;
PetDefend_Var.CowerToggled = false;
PetDefend_Var.CowerID = 0;
PetDefend_Var.IsCowering = false;

function PetDefend_OnLoad()

	-- Register for Events
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("UNIT_COMBAT");
	this:RegisterEvent("PET_ATTACK_START");
	this:RegisterEvent("PET_ATTACK_STOP");

	-- Register Slash Commands
	SLASH_PETDEFEND1 = "/petdefend";
	SLASH_PETDEFEND2 = "/pd";
	SlashCmdList["PETDEFEND"] = function(msg)
		PetDefend_ChatCommandHandler(msg);
	end
	
	ChatMessage("Rauen's PetDefend Loaded.");

end

function PetDefend_ChatCommandHandler(msg)

	-- Check for Pet
	if not ( UnitExists("pet") ) then
		ChatMessage("You do not currently have a pet.");
		return;
	end
	
	-- Assign Variable
	local pet = UnitName("pet");
	
	-- Print Help
	if ( msg == "help" ) or ( msg == "" ) then
		ChatMessage("Rauen's PetDefend:");
		ChatMessage("/petdefend /pd <command>");
		ChatMessage("- help - Print this helplist.");
		ChatMessage("- on|off - Turn PetDefend on or off.");
		ChatMessage("- status - Check current settings.");
		ChatMessage("- reset - Reset to default settings.");
		ChatMessage("- all|<player> - Set pet to defend entire party or member.");
		ChatMessage("- always|idle - Set pet to always defend or only when idle.");
		ChatMessage("- lowhealth <percent> - Toggle the pet defending on low health.");
		ChatMessage("- growl <name> - Toggle forcing Growl when defending.");		
		ChatMessage("- cower <percent> <name> - Toggle Cowering when low health.");
		ChatMessage("- alert - Toggle alerting when defending.");
		ChatMessage("- chan say|party|chat - Set message channel.");
		return;
	end
	
	-- Turn PetDefend On
	if ( msg == "on" ) then
		PetDefend_Config.Enabled = true;
		ChatMessage("PetDefend is enabled.");
		return;
	end
	
	-- Turn PetDefend Off
	if ( msg == "off" ) then
		PetDefend_Config.Enabled = false;
		ChatMessage("PetDefend is disabled.");
		return;
	end
	
	-- Check Status
	if ( msg == "status" ) then
		if not ( PetDefend_Config.Enabled ) then
			ChatMessage("PetDefend is disabled.");
			return;
		end
		if ( PetDefend_Config.DefendAll ) then
			if ( PetDefend_Config.AssistInCombat ) then
				ChatMessage(pet.." is always defending the party.");
			else
				ChatMessage(pet.." is defending the party when idle.");
			end
		else
			if ( PetDefend_Config.AssistInCombat ) then
				ChatMessage(pet.." is always defending "..UnitName(PetDefend_Config.DefendMember)..".");
			else
				ChatMessage(pet.." is defending "..UnitName(PetDefend_Config.DefendMember).." when idle.");
			end
		end
		if ( PetDefend_Config.Growl ) then
			if ( PetDefend_Config.DefendAll ) then
				ChatMessage(pet.." will force "..PetDefend_Config.GrowlName.." when defending the party.");
			else
				ChatMessage(pet.." will force "..PetDefend_Config.GrowlName.." when defending "..UnitName(PetDefend_Config.DefendMember)..".");
			end
		end
		if ( PetDefend_Config.LowHealth ) then
			ChatMessage(pet.." is defending members with under "..PetDefend_Config.HealthMin.."% health.");
		end
		if ( PetDefend_Config.Cower ) then
			ChatMessage(pet.." will "..PetDefend_Config.CowerName.." when under "..PetDefend_Config.CowerMin.."% health.");
		end
		if ( PetDefend_Config.Alert ) then
			ChatMessage("You are speaking in "..PetDefend_Config.Channel.." when "..pet.." defends.");
		end
		return;
	end

	-- Reset Variables
	if ( msg == "reset" ) then
		PetDefend_Config.Enabled = true;
		PetDefend_Config.DefendAll = true;
		PetDefend_Config.AssistInCombat = false;
		PetDefend_Config.Growl = true;
		PetDefend_Config.DefendMember = "";
		PetDefend_Config.MemberAssisting = "";
		PetDefend_Config.LowHealth = false;
		PetDefend_Config.HealthMin = 25;
		PetDefend_Config.Cower = false;
		PetDefend_Config.CowerMin = 25;
		PetDefend_Config.Alert = true;
		PetDefend_Config.Channel = "PARTY";
		PetDefend_Config.CowerName = "Cower";
		PetDefend_Config.GrowlName = "Growl";
		ChatMessage("PetDefend configuration reset.");
		ChatMessage(pet.." is now defending the party when idle.");
		ChatMessage(pet.." will force "..PetDefend_Config.GrowlName.." when defending the party.");
		ChatMessage("You are speaking in "..PetDefend_Config.Channel.." when "..pet.." defends.");
		return;
	end
	
	-- Defend Party
	if ( msg == "all" ) or ( msg == "party" ) then
		PetDefend_Config.DefendAll = true;
		if ( PetDefend_Config.AssistInCombat ) then
			ChatMessage(pet.." is now always defending the party.");
		else
			ChatMessage(pet.." is now defending the party when idle.");
		end
		if ( PetDefend_Config.Alert ) then
			ChannelMessage(pet.." is defending the party.", PetDefend_Config.Channel);
		end
		return;
	end
	
	-- Always Defend
	if ( msg == "always" ) then
		PetDefend_Config.AssistInCombat = true;
		if ( PetDefend_Config.DefendAll ) then
			ChatMessage(pet.." is now always defending the party.");
		else
			ChatMessage(pet.." is now always defending "..UnitName(PetDefend_Config.DefendMember)..".");
		end
		return;
	end
	
	-- Defend When Idle
	if ( msg == "idle" ) then
		PetDefend_Config.AssistInCombat = false;
		if ( PetDefend_Config.DefendAll ) then
			ChatMessage(pet.." is now defending the party when idle.");
		else
			ChatMessage(pet.." is now defending "..UnitName(PetDefend_Config.DefendMember).." when idle.");
		end
		return;
	end
	
	-- Toggle Alert
	if ( msg == "alert" ) then
		if ( PetDefend_Config.Alert ) then
			PetDefend_Config.Alert = false;
			ChatMessage("You will no longer speak in "..PetDefend_Config.Channel.." when "..pet.." defends.");
		else
			PetDefend_Config.Alert = true;
			ChatMessage("You will now speak in "..PetDefend_Config.Channel.." when "..pet.." defends.");
		end
		return;
	end
	
	-- Set Alert Channel
	if ( string.sub(msg, 1, 4) == "chan" ) then
		if not ( string.sub(msg, 6) == nil ) and not ( string.sub(msg, 6) == "" ) then
			if ( string.sub(msg, 6) == "say" ) then
				PetDefend_Config.Channel = "SAY";
			elseif ( string.sub(msg, 6) == "party" ) then
				PetDefend_Config.Channel = "PARTY";
			elseif ( string.sub(msg, 6) == "chat" ) then
				PetDefend_Config.Channel = "CHAT";
			else
				return;
			end
			PetDefend_Config.Alert = true;
			ChatMessage("You will now speak in "..PetDefend_Config.Channel.." when "..pet.." defends.");
			return;
		else
			return;
		end
	end
	
	-- Set LowHealth
	if ( string.sub(msg, 1, 9) == "lowhealth" ) then
		if not ( string.find( msg, "%d%d" ) == nil ) then
			PetDefend_Config.HealthMin = tonumber( string.sub( msg, string.find( msg, "%d%d" ) ) );
		elseif not ( string.find( msg, "%d" ) == nil ) then
			PetDefend_Config.HealthMin = tonumber( string.sub( msg, string.find( msg, "%d" ) ) );
		else
			if ( PetDefend_Config.LowHealth ) then
				PetDefend_Config.LowHealth = false;
				ChatMessage(pet.." will no longer watch party member's health.");
			else
				PetDefend_Config.LowHealth = true;
				ChatMessage(pet.." will now defend members with under "..PetDefend_Config.HealthMin.."% health.");
			end
			return;
		end
		ChatMessage(pet.." will now defend members with under "..PetDefend_Config.HealthMin.."% health.");
		PetDefend_Config.LowHealth = true;
		return;
	end

	-- Toggle Growl
	if ( string.sub(msg, 1, 5) == "growl" ) then
		if ( string.sub( msg, 7 ) == "" ) then
			if ( PetDefend_Config.Growl ) then
				if ( PetDefend_Config.DefendAll ) then
					ChatMessage(pet.." will no longer force "..PetDefend_Config.GrowlName.." when defending the party.");
				else
					ChatMessage(pet.." will no longer force "..PetDefend_Config.GrowlName.." when defending "..UnitName(PetDefend_Config.DefendMember)..".");
				end
				PetDefend_Config.Growl = false;
			else
				if ( PetDefend_Config.DefendAll ) then
					ChatMessage(pet.." will now force "..PetDefend_Config.GrowlName.." when defending the party.");
				else
					ChatMessage(pet.." will now force "..PetDefend_Config.GrowlName.." when defending "..UnitName(PetDefend_Config.DefendMember)..".");
				end
				PetDefend_Config.Growl = true;
			end
			return;
		else
			PetDefend_Config.GrowlName = string.sub( msg, 7 );
			ChatMessage(pet.."'s taunt is set to "..PetDefend_Config.GrowlName..".");
			return;
		end
	end
	
	-- Set Cower
	if ( string.sub(msg, 1, 5) == "cower" ) then
		if not ( string.find( msg, "%d%d" ) == nil ) then
			PetDefend_Config.CowerMin = tonumber( string.sub( msg, string.find( msg, "%d%d" ) ) );
			ChatMessage(pet.." will Cower when under "..PetDefend_Config.CowerMin.."% health.");
			PetDefend_Config.Cower = true;
			return;
			
		elseif not ( string.find( msg, "%d" ) == nil ) then
			PetDefend_Config.CowerMin = tonumber( string.sub( msg, string.find( msg, "%d" ) ) );
			ChatMessage(pet.." will "..PetDefend_Config.CowerName.." when under "..PetDefend_Config.CowerMin.."% health.");
			PetDefend_Config.Cower = true;
			return;
			
		elseif ( string.sub( msg, 7 ) == "" ) then
			if ( PetDefend_Config.Cower ) then
				PetDefend_Config.Cower = false;
				ChatMessage(pet.." will no longer "..PetDefend_Config.CowerName.." when hurt.");
			else
				PetDefend_Config.Cower = true;
				ChatMessage(pet.." will now "..PetDefend_Config.CowerName.." when under "..PetDefend_Config.CowerMin.."% health.");
			end
			return;
			
		else
			PetDefend_Config.CowerName = string.sub( msg, 7 );
			ChatMessage(pet.."'s detaunt is set to "..PetDefend_Config.CowerName..".");
			return;
		end
	end
	
	-- Check for Party Member
	member = "";
	for i=1, 4 do
		if not ( UnitName("party"..i) == nil ) then
			if ( string.upper(UnitName("party"..i)) == string.upper(msg) ) then
				member = "party"..i;
			end
		end
	end
	if ( member == "" ) then
		ChatMessage("Cannot find '"..msg.."' in your party.");
		return;
	end

	-- Defend Party Member
	PetDefend_Config.DefendMember = member;
	PetDefend_Config.DefendAll = false;
	if ( PetDefend_Config.AssistInCombat ) then
		ChatMessage(pet.." is now always defending "..UnitName(PetDefend_Config.DefendMember)..".");
	else
		ChatMessage(pet.." is now defending "..UnitName(PetDefend_Config.DefendMember).." when idle.");
	end
	if ( PetDefend_Config.Alert ) then
		ChannelMessage(pet.." is defending "..UnitName(PetDefend_Config.DefendMember)..".", PetDefend_Config.Channel);
	end

end

function PetDefend_OnEvent(event, arg1, arg2)

	-- Check if Enabled
	if not ( PetDefend_Config.Enabled ) then
		return;
	end
	
	-- Check for Pet
	if not ( UnitExists("pet") ) or ( UnitIsDead("pet") ) then
		return;
	end

	if ( event == "PET_ATTACK_START" ) then

		-- Flag Pet as InCombat
		PetDefend_Var.InCombat = true;

	elseif ( event == "PET_ATTACK_STOP" ) then

		-- Remove Pet's InCombat Flag
		PetDefend_Var.InCombat = false;
		PetDefend_Config.MemberAssisting = "";
		
		-- Reset State
		PetDefend_ResetAutocasts();
		PetDefend_Var.IsCowering = false;

	elseif ( event == "UNIT_COMBAT" ) then

		-- Assign Variables
		local pet = UnitName("pet");
		local member = arg1;
		local damage = arg2;
		
		-- Check Event Type
		if not ( damage == "WOUND" ) then
			return;
		end
		
		-- Check for Defensive Mode
		local name, subtext, texture, isToken, isActive, autoCastAllowed, autoCastEnabled = GetPetActionInfo(9);
		if not ( isActive ) then
			return;
		end
		
		-- Check Cower
		if not ( PetDefend_Var.IsCowering ) then
			if ( member == "pet" ) and ( PetDefend_Config.Cower ) then
				if ( (100*UnitHealth("pet")/UnitHealthMax("pet")) < PetDefend_Config.CowerMin  ) then
					PetDefend_Var.IsCowering = true;
					PetDefend_Cower();
					if ( PetDefend_Config.Alert ) then
						if ( PetDefend_Config.Channel == "CHAT" ) then
							ChatMessage(pet.." is Cowering!");
						elseif not ( ( PetDefend_Config.Channel == "PARTY" ) and ( UnitName("party1") == nil ) ) then
							ChannelMessage(pet.." is Cowering!", PetDefend_Config.Channel);
						end
					end
					return;
				end
			end
		else
			if ( (100*UnitHealth("pet")/UnitHealthMax("pet")) > PetDefend_Config.CowerMin  ) then
				PetDefend_Var.IsCowering = false;
				PetDefend_ResetAutocasts();
				if ( PetDefend_Config.Alert ) then
					if ( PetDefend_Config.Channel == "CHAT" ) then
						ChatMessage(pet.." is no longer Cowering!");
					elseif not ( ( PetDefend_Config.Channel == "PARTY" ) and ( UnitName("party1") == nil ) ) then
						ChannelMessage(pet.." is no longer Cowering!", PetDefend_Config.Channel);
					end
				end
				return;
			end
		end

		-- Check Party Members
		if not ( member == "player" ) and
		  not ( member == "party1" ) and
		  not ( member == "party2" ) and
		  not ( member == "party3" ) and
		  not ( member == "party4" ) then
			return;
		end
		
		-- Check Currently Assisting
		if ( member == PetDefend_Config.MemberAssisting ) then
			return;
		end
		
		-- Check LowHealth
		if ( PetDefend_Config.LowHealth ) then
			if ( member == "player" ) then
				if ( (100*UnitHealth("player")/UnitHealthMax("player")) < PetDefend_Config.HealthMin  ) then
					PetDefend_Attack(pet, "player", "LOW_HEALTH");
				end
				return;
			end
			for i=1, 4 do
				if ( UnitExists("party"..i) ) then
					if ( (100*UnitHealth("party"..i)/UnitHealthMax("party"..i)) < PetDefend_Config.HealthMin  ) then
						PetDefend_Attack(pet, "party"..i, "LOW_HEALTH");
						return;
					end
				end
			end
		end

		-- Check Defend Member
		if ( PetDefend_Config.DefendMember == "" ) or ( UnitName(PetDefend_Config.DefendMember) == nil ) then
			PetDefend_Config.DefendAll = true;
		end
		if not ( PetDefend_Config.DefendAll ) and not ( member == PetDefend_Config.DefendMember ) then
			return;
		end

		-- Check InCombat
		if ( PetDefend_Var.InCombat ) and not ( PetDefend_Config.AssistInCombat ) then
			return;
		end
		
		-- Defend Party Member
		PetDefend_Attack(pet, member, "DEFEND");
		
	end
	
end

function PetDefend_Attack(pet, member, event)

	-- Check Growl
	PetDefend_Growl(event);
	
	-- Pet Defend Player
	if ( member == "player" ) then
		if not ( UnitCanAttack("player", "target") ) then
			return;
		end
		if ( PetDefend_Config.Alert ) then
			ChatMessage(pet.." is assisting you!");
		end
		PetDefend_Config.MemberAssisting = member;
		PetAttack();
		return;
	end

	-- Pet Defend Party Member
	if ( UnitExists("target") ) then
		AssistUnit(member);
		if not ( UnitCanAttack("player", "target") ) then
			return;
		end
		if ( PetDefend_Config.Alert ) then
			if ( PetDefend_Config.Channel == "CHAT" ) then
				ChatMessage(pet.." is assisting "..UnitName(member).."!");
			elseif not ( ( PetDefend_Config.Channel == "PARTY" ) and ( UnitName("party1") == nil ) ) then
				ChannelMessage(pet.." is assisting "..UnitName(member).."!", PetDefend_Config.Channel);
			end
		end
		PetDefend_Config.MemberAssisting = member;
		PetAttack();
		TargetLastEnemy();
	else
		AssistUnit(member);
		if not ( UnitCanAttack("player", "target") ) then
			return;
		end
		if ( PetDefend_Config.Alert ) then
			if ( PetDefend_Config.Channel == "CHAT" ) then
				ChatMessage(pet.." is assisting "..UnitName(member).."!");
			elseif not ( ( PetDefend_Config.Channel == "PARTY" ) and ( UnitName("party1") == nil ) ) then
				ChannelMessage(pet.." is assisting "..UnitName(member).."!", PetDefend_Config.Channel);
			end
		end
		PetDefend_Config.MemberAssisting = member;
		PetAttack();
		ClearTarget();
	end
		
end

-- Growl
function PetDefend_Growl(event)
	for i=1, 10 do
		local name, subtext, texture, isToken, isActive, autoCastAllowed, autoCastEnabled = GetPetActionInfo(i);
		if ( name == PetDefend_Config.GrowlName ) then
			if not ( autoCastEnabled ) then
				if ( PetDefend_Config.Growl ) or ( event == "LOW_HEALTH" )  then
					TogglePetAutocast(i);
					PetDefend_Var.GrowlToggled = true;
					PetDefend_Var.GrowlID = i;
				end
			end
		end
		if ( name == PetDefend_Config.CowerName ) then
			if ( autoCastEnabled ) then
				if ( PetDefend_Config.Growl ) or ( event == "LOW_HEALTH" )  then
					TogglePetAutocast(i);
					PetDefend_Var.CowerToggled = true;
					PetDefend_Var.CowerID = i;
				end
			end
		end
	end
end

-- Cower
function PetDefend_Cower()
	for i=1, 10 do
		local name, subtext, texture, isToken, isActive, autoCastAllowed, autoCastEnabled = GetPetActionInfo(i);
		if ( string.upper(name) == string.upper(PetDefend_Config.CowerName) ) then
			if not ( autoCastEnabled ) then
				TogglePetAutocast(i);
				PetDefend_Var.CowerToggled = true;
				PetDefend_Var.CowerID = i;
			end
		end
		if ( string.upper(name) == string.upper(PetDefend_Config.GrowlName) ) then
			if ( autoCastEnabled ) then
				TogglePetAutocast(i);
				PetDefend_Var.GrowlToggled = true;
				PetDefend_Var.GrowlID = i;
			end
		end
	end
end

-- Reset Growl and Cower
function PetDefend_ResetAutocasts()
	if ( PetDefend_Var.GrowlToggled ) then
		TogglePetAutocast(PetDefend_Var.GrowlID);
		PetDefend_Var.GrowlToggled = false;
		PetDefend_Var.GrowlID = 0;
	end
	if ( PetDefend_Var.CowerToggled ) then
		TogglePetAutocast(PetDefend_Var.CowerID);
		PetDefend_Var.CowerToggled = false;
		PetDefend_Var.CowerID = 0;
	end
end

-- Send Message to Chat Frame
function ChatMessage(message)
	DEFAULT_CHAT_FRAME:AddMessage(message);
end

-- Send Message to Channel
function ChannelMessage(message, channel)
	SendChatMessage(message, channel);
end

-- Send Message to Error Frame
function ErrorMessage(message)
	UIErrorsFrame:AddMessage(message, 1.0, 1.0, 0.0, 1.0, UIERRORS_HOLD_TIME);
end
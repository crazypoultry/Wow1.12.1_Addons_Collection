-- Binding Variables
BINDING_HEADER_PETATTACK_HEADER = "Rauen's PetAttack";
BINDING_NAME_PETATTACK_BINDING = "Attack";

-- Variables
PetAttack_Config = { };
PetAttack_Config.Enabled = true;
PetAttack_Config.Alert = true;
PetAttack_Config.Channel = "SAY";
PetAttack_Config.Cast = false;
PetAttack_Config.Spell = "";
PetAttack_Config.Rank = "Rank 1";

function PetAttack_OnLoad()

	-- Register for Events
	this:RegisterEvent("VARIABLES_LOADED");

	-- Register Slash Commands
	SLASH_PETATTACK1 = "/petattack";
	SLASH_PETATTACK2 = "/pa";
	SlashCmdList["PETATTACK"] = function(msg)
		PetAttack_ChatCommandHandler(msg);
	end

	ChatMessage("Rauen's PetAttack Loaded.");
	
end

function PetAttack_OnEvent()
end

function PetAttack_ChatCommandHandler(msg)

	-- Check for Pet
	if not ( UnitExists("pet") ) then
		ChatMessage("You do not currently have a pet.");
		return;
	end
	
	-- Assign Variables
	local pet = UnitName("pet");

	-- Print Help
	if ( msg == "help" ) or ( msg == "" ) then
		ChatMessage("Rauen's PetAttack:");
		ChatMessage("/petattack /pa <command>");
		ChatMessage("- help - Print this helplist.");
		ChatMessage("- on|off - Turn PetAttack on or off.");
		ChatMessage("- status - Check current settings.");
		ChatMessage("- reset - Reset to default settings.");
		ChatMessage("- alert - Toggle attack messages.");
		ChatMessage("- chan say|party|chat - Set message channel.");
		ChatMessage("- cast- Toggle casting spell before attack.");
		ChatMessage("- spell <spell> - Set spell to cast.");
		ChatMessage("- rank <num> - Set rank of spell to cast.");
		return;
	end
	
	-- Check Status
	if ( msg == "status" ) then
		if not ( PetAttack_Config.Enabled ) then
			ChatMessage("PetAttack is disabled.");
			return;
		end
		if ( PetAttack_Config.Cast ) and not ( PetAttack_Config.Spell == "" ) then
			ChatMessage("You are casting "..PetAttack_Config.Spell.." ("..PetAttack_Config.Rank..") when "..pet.." attacks.");
		else
			ChatMessage("You are sending "..pet.." to attack on command.");
		end
		if ( PetAttack_Config.Alert ) then
			ChatMessage("You are speaking in "..PetAttack_Config.Channel.." when "..pet.." attacks.");
		end
		return;
	end

	-- Turn PetAttack On
	if ( msg == "on" ) then
		PetAttack_Config.Enabled = true;
		ChatMessage("PetAttack is enabled.");
		return;
	end
	
	-- Turn PetAttack Off
	if ( msg == "off" ) then
		PetAttack_Config.Enabled = false;
		ChatMessage("PetAttack is disabled.");
		return;
	end
	
	-- Reset Variables
	if ( msg == "reset" ) then
		PetAttack_Config.Enabled = true;
		PetAttack_Config.Alert = true;
		PetAttack_Config.Channel = "SAY";
		PetAttack_Config.Cast = false;
		PetAttack_Config.Rank = "Rank 1";
		ChatMessage("PetAttack configuration reset.");
		ChatMessage("You are sending "..pet.." to attack on command.");
		ChatMessage("You are speaking in "..PetAttack_Config.Channel.." when "..pet.." attacks.");
		return;
	end
	
	-- Toggle Alert
	if (msg == "alert" ) then
		if ( PetAttack_Config.Alert ) then
			PetAttack_Config.Alert = false;
			ChatMessage("You will no longer speak in "..PetAttack_Config.Channel.." when "..pet.." attacks.");
		else
			PetAttack_Config.Alert = true;
			ChatMessage("You will now speak in "..PetAttack_Config.Channel.." when "..pet.." attacks.");
		end
		return;
	end
	
	-- Set Alert Channel
	if ( string.sub(msg, 1, 4) == "chan" ) then
		if not ( string.sub(msg, 6) == nil ) and not ( string.sub(msg, 6) == "" ) then
			if ( string.sub(msg, 6) == "say" ) then
				PetAttack_Config.Channel = "SAY";
			elseif ( string.sub(msg, 6) == "party" ) then
				PetAttack_Config.Channel = "PARTY";
			elseif ( string.sub(msg, 6) == "chat" ) then
				PetAttack_Config.Channel = "CHAT";
			else
				return;
			end
			PetAttack_Config.Alert = true;
			ChatMessage("You will now speak in "..PetAttack_Config.Channel.." when "..pet.." attacks.");
			return;
		else
			return;
		end
	end
	
	-- Toggle Cast
	if ( msg == "cast" ) then
		if ( PetAttack_Config.Cast ) then
			PetAttack_Config.Cast = false;
			ChatMessage("You will no longer cast "..PetAttack_Config.Spell.." when "..pet.." attacks.");
		else
			if ( PetAttack_Config.Spell == "" ) then
				ChatMessage("You must specify a spell to cast first.");
			else
				PetAttack_Config.Cast = true;
				ChatMessage("You will now cast "..PetAttack_Config.Spell.." ("..PetAttack_Config.Rank..") when "..pet.." attacks.");
			end
		end
		return;
	end
	
	-- Set Spell to Cast
	if ( string.sub(msg, 1, 5) == "spell" ) then
		if not ( string.sub(msg, 7) == nil ) and not ( string.sub(msg, 7) == "" ) then
			if ( PetAttack_SpellExists( string.sub(msg, 7), PetAttack_Config.Rank ) ) then
				PetAttack_Config.Spell = string.sub(msg, 7);
				PetAttack_Config.Cast = true;
				ChatMessage("You will now cast "..PetAttack_Config.Spell.." ("..PetAttack_Config.Rank..") when "..pet.." attacks.");
			else
				ChatMessage("Cannot find "..string.sub(msg, 7).."("..PetAttack_Config.Rank..") in your spellbook.");
			end
		else
			return;
		end
		return;
	end
	
	-- Set Spell Rank to Cast
	if ( string.sub(msg, 1, 4) == "rank" ) then
		if not ( string.find( msg, "%d" ) == nil ) then
			if ( PetAttack_SpellExists( PetAttack_Config.Spell, "Rank "..string.sub( msg, string.find( msg, "%d" )) ) ) then
				PetAttack_Config.Rank = "Rank "..string.sub( msg, string.find( msg, "%d" ) ) ;
				PetAttack_Config.Cast = true;
				ChatMessage("You will now cast "..PetAttack_Config.Spell.." ("..PetAttack_Config.Rank..") when "..pet.." attacks.");
			else
				ChatMessage("Cannot find "..PetAttack_Config.Spell.." (Rank "..string.sub( msg, string.find( msg, "%d" ) )..") in your spellbook.");
			end
		else
			return;
		end
		return;
	end
	
end

function PetAttack_Attack()

	-- Check if Enabled
	if not ( PetAttack_Config.Enabled ) then
		return;
	end

	-- Assign Variables
	local pet = UnitName("pet");
	local target = UnitName("target");

	-- Check if Pet Exists and Target Exists
	if UnitExists("target") and not (pet == nil) and not ( UnitIsDead("pet") ) then

		-- Assist Other
		if  ( UnitIsPlayer("target") ) and ( UnitCanCooperate("player", "target") ) then
			player = target;
			AssistUnit("target");
			target = UnitName("target");
			if (target == nil) then
				return;
			end
			if not ( UnitCanAttack("player", "target") ) then
				return;
			end
			message = SetMessage(pet, target, player, "assist_other");

		elseif ( UnitCanAttack("player", "target") ) then
		
			-- Assist Player
			if UnitIsTappedByPlayer("target") then
				message = SetMessage(pet, target, "me", "assist_me");

			-- Attack Mob
			else
		
				-- Check Cast
				if ( PetAttack_Config.Cast ) then
					CastSpell( PetAttack_GetSpellID( PetAttack_Config.Spell, PetAttack_Config.Rank ), BOOKTYPE_SPELL);
				end
		
				-- Attack
				message = SetMessage(pet, target, "none", "attack");
		
			end
		else
			return;
		end
		
		-- Check Alert
		if ( PetAttack_Config.Alert ) then
			if ( PetAttack_Config.Channel == "CHAT" ) then
				ChatMessage(message);
			elseif not ( ( PetAttack_Config.Channel == "PARTY" ) and ( UnitName("party1") == nil ) ) then
				ChannelMessage(message, PetAttack_Config.Channel);
			end
		end
		
		-- Pet Attack Target
		PetAttack();
		
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

-- Check for Spell
function PetAttack_SpellExists(spell, rank)
	if ( PetAttack_GetSpellID(spell, rank) == 0 ) then
		return false;
	else
		return true;
	end
end

-- Get Spell ID
function PetAttack_GetSpellID(spell, rank)

	local i = 1;
	local spell_book, rank_book = GetSpellName(i, BOOKTYPE_SPELL);
	while spell_book do
		if ( spell_book == spell ) then
			if ( rank_book == rank ) then
				return i;
			end
		end
		i = i + 1;
		spell_book, rank_book = GetSpellName(i, BOOKTYPE_SPELL)
	end
	return 0;
	
end
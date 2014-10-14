-- Set PetAttack Messages
function SetMessage(pet, target, player, type)

	-- Messages to Assist Player
	PetAttack_Messages_AssistMe = {

		pet.."! Assist me!",
		pet.."! Aid me!",
		pet.."! I need your help!"

		};

	-- Messages to Assist Others
	PetAttack_Messages_AssistOther = {

		pet.."! Assist "..player.."!",
		pet.."! Aid "..player.."!",
		pet.."! Help "..player.."!"

		};

	-- Messages to Attack
	PetAttack_Messages_Attack = {

		pet.."! Attack the "..target.."!",
		"Attack the "..target..", "..pet.."!"

		};
	
	-- Check Type and Set Message
	if (type == "assist_me") then
		message = PetAttack_Messages_AssistMe[math.random(table.getn(PetAttack_Messages_AssistMe))];
	elseif (type == "assist_other") then
		message = PetAttack_Messages_AssistOther[math.random(table.getn(PetAttack_Messages_AssistOther))];
	elseif (type == "attack") then
		message = PetAttack_Messages_Attack[math.random(table.getn(PetAttack_Messages_Attack))];
	end
	return message;

end
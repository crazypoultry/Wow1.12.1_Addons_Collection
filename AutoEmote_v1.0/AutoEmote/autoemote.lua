ae_strings = {
	needhug=" needs a hug!";
	burstdance="bursts into dance";
	dancewplayer="dances with you";
	farewelltoplayer="goodbye to you";
	farewelltoall="goodbye to everyone";
	greetgen="hello";
	gplayer="you";
	gall="everyone";
	thx="thanks you";
}

function autoemote_OnEvent(event, arg1)
	if (event == "CHAT_MSG_TEXT_EMOTE") then
		if (arg1 == arg2..ae_strings["needhug"]) then
			DoEmote("hug",arg2);
		end
		if (strfind(arg1,ae_strings["burstdance"]) and strfind(arg1,arg2)) then
			DoEmote("dance",arg2);
		end
		if (strfind(arg1,ae_strings["farewelltoplayer"]) and strfind(arg1,arg2)) then
			DoEmote("bye",arg2);
		end
		if (strfind(arg1,ae_strings["farewelltoall"]) and strfind(arg1,arg2)) then
			DoEmote("bye",arg2);
		end
		if (strfind(arg1,ae_strings["greetgen"])) then
			if (strfind(arg1,ae_strings["gplayer"]) or strfind(arg1,ae_strings["gall"])) then
				DoEmote("hi",arg2);
			end
		end
		if (strfind(arg1,ae_strings["thx"])) then
			DoEmote("welcome",arg2);
		end
		-- SendChatMessage(arg2..ae_strings["greetplayer"].." ;;; "..arg1);
	end
end
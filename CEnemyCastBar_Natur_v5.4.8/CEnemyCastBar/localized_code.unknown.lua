-- Localized Functions for the European Version; I am too lazy to exclude the localizations in a more seperate way!
-- Outsorced functions:
-- _Yell, _Emote, _GFind, _Enter_Combat

if ( not NECB_client_known ) then

	NECB_client_unknown = true;

	function CEnemyCastBar_Yells(arg1, arg2) --Yell
	end
	
	function CEnemyCastBar_Emotes(arg1, arg2) --Emote
	end

	function CEnemyCastBar_Gfind(arg1, event) --Gfind
	end

	function CEnemyCastBar_Player_Enter_Combat_Execute(targetmob) --enter combat execution, called by the enter combat preprocessor in main lua
	end

	function CEnemyCastBar_Player_Enter_Combat_Exception() -- C'Thun exception
	end

end
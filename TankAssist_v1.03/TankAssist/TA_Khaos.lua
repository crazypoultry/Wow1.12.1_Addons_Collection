--=============================================================================
-- File:	TA_Khaos.lua
-- Author:	rudy
-- Description:	The Khaos registration for TankAssist
--=============================================================================

function TA_Khaos_Register()

	if ( not Khaos ) then
		return;
	end

	local optionSet = {
		id="TankAssist";
		text=TANKASSIST_CONFIG_HEADER;
		helptext=TANKASSIST_CONFIG_HEADER_INFO;
		difficulty=1;
		options={
			{
				id="Header";
				text=TANKASSIST_CONFIG_HEADER;
				helptext=TANKASSIST_CONFIG_HEADER_INFO;
				type=K_HEADER;
				difficulty=1;
			},
			{
				id="Assist1Name";
				key="KeyAssist1Name";
				value={TankAssist_assist1Name};
				type=K_EDITBOX;
				text=TANKASSIST_ASSIST_ONE_NAME;
				helptext=TANKASSIST_ASSIST_ONE_NAME_INFO;
				difficulty=1;
				callback=function(state) TA_SetAssist(state.value,1,true); end;
				feedback=function(state) return TANKASSIST_ASSIST_ONE_NAME_INFO; end;
				setup = { callOn = {"enter"}; };
				default = { value = "none"; };
				disabled = { value = "none"; };
			},
			{
				id="Assist1Button";
				key = "KeyAssist1Button";
				text=TANKASSIST_ASSIST_ONE_TARGET;
				helptext=TANKASSIST_ASSIST_ONE_TARGET_INFO;
				type = K_BUTTON;
				callback = function() end;
				feedback = function() TA_SetAssist(nil,1,true); end;
				setup = { buttonText = "Set Tank"; };
			},
			{
				id="Assist2Name";
				key="KeyAssist2Name";
				value={TankAssist_assist2Name};
				type=K_EDITBOX;
				text=TANKASSIST_ASSIST_TWO_NAME;
				helptext=TANKASSIST_ASSIST_TWO_NAME_INFO;
				difficulty=1;
				callback=function(state) TA_SetAssist(state.value,2,true); end;
				feedback=function(state) return TANKASSIST_ASSIST_TWO_NAME_INFO; end;
				setup = { callOn = {"enter"}; };
				default = { value = "none"; };
				disabled = { value = "none"; };
			},
			{
				id="Assist2Button";
				key = "KeyAssist2Button";
				text=TANKASSIST_ASSIST_TWO_TARGET;
				helptext=TANKASSIST_ASSIST_TWO_TARGET_INFO;
				type = K_BUTTON;
				callback = function() end;
				feedback = function() TA_SetAssist(nil,2,true); end;
				setup = { buttonText = "Set Tank"; };
			},
			{
				id="Assist3Name";
				key="KeyAssist3Name";
				value={TankAssist_assist3Name};
				type=K_EDITBOX;
				text=TANKASSIST_ASSIST_THREE_NAME;
				helptext=TANKASSIST_ASSIST_THREE_NAME_INFO;
				difficulty=1;
				callback=function(state) TA_SetAssist(state.value,3,true); end;
				feedback=function(state) return TANKASSIST_ASSIST_THREE_NAME_INFO; end;
				setup = { callOn = {"enter"}; };
				default = { value = "none"; };
				disabled = { value = "none"; };
			},
			{
				id="Assist3Button";
				key = "KeyAssist3Button";
				text=TANKASSIST_ASSIST_THREE_TARGET;
				helptext=TANKASSIST_ASSIST_THREE_TARGET_INFO;
				type = K_BUTTON;
				callback = function() end;
				feedback = function() TA_SetAssist(nil,3,true); end;
				setup = { buttonText = "Set Tank"; };
			},
			{
				id="Assist4Name";
				key="KeyAssist4Name";
				value={TankAssist_assist4Name};
				type=K_EDITBOX;
				text=TANKASSIST_ASSIST_FOUR_NAME;
				helptext=TANKASSIST_ASSIST_FOUR_NAME_INFO;
				difficulty=1;
				callback=function(state) TA_SetAssist(state.value,4,true); end;
				feedback=function(state) return TANKASSIST_ASSIST_FOUR_NAME_INFO; end;
				setup = { callOn = {"enter"}; };
				default = { value = "none"; };
				disabled = { value = "none"; };
			},
			{
				id="Assist4Button";
				key = "KeyAssist4Button";
				text=TANKASSIST_ASSIST_FOUR_TARGET;
				helptext=TANKASSIST_ASSIST_FOUR_TARGET_INFO;
				type = K_BUTTON;
				callback = function() end;
				feedback = function() TA_SetAssist(nil,4,true); end;
				setup = { buttonText = "Set Tank"; };
			},
			{
				id="ShowTarget";
				key = "KeyShowTarget";
				text=TANKASSIST_SHOW_TARGET;
				helptext=TANKASSIST_SHOW_TARGET_INFO;
				type = K_TEXT;
				value = true;
				check = true;
				callback = function(state) TA_ShowTarget(state.checked,true); end;
				feedback = function(state) return TANKASSIST_SHOW_TARGET_INFO; end;
				default = { checked = true; };
       				disabled = { checked = true; };
       				
			},
			{
				id="ResetFrames";
				key = "KeyResetFrames";
				text=TANKASSIST_RESET_FRAMES;
				helptext=TANKASSIST_RESET_FRAMES_INFO;
				type = K_BUTTON;
				callback = function() end;
				feedback = function() TA_ResetFrames(); end;
				setup = { buttonText = "Reset"; };
			}
		}
	};

	Khaos.registerOptionSet( "combat", optionSet );
end

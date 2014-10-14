local ONEHITWONDER_HOOK				= true;
local ONEHITWONDER_HOOK_POSITION	= "after";

ohw_radioOhwPosDefault = {
	value = "after";
};

ohw_radioOhwPosDisabled = {
	value = "after";
};

function ohw_radioOhwPosCallback( state )
	ONEHITWONDER_HOOK_POSITION = state.value;
end

function ohw_radioOhwPosFeedback(state)
	if state.value == "before" then 
		return "Calling OHW before hooked event processing";
	elseif state.value == "after" then
		return "Calling OHW after hooked event processing";
	end
end

ohw_radioOhwPosDeps = {
	["ohw_HookMoreOhw"] = { checked=true; };
};

function OneHitWonder_RegisterInKhaos()
	if (Khaos) then
		OneHitWonder_Print( "OHW: Khaos found, registering", 0, 1, 1 );

		local setOhw = 
		{
			id = "ohw_HookingOptions";
			text = "OHW Hooking";
			helptext = "Manually control OneHitWonder hooking behaviour.";
			difficulty = 3;
			default = false;
			options = 	
			{
				{
 					id="ohw_HookingOptionsHeader";
                   	text="OneHitWonder (OHW) Hooking Options";
                   	helptext="Change OHW hooking options with options below";
	                type = K_HEADER;
				};
				{
 					id="ohw_HookMoreOhw";
					text="Control hooking";
                   	helptext="Check here if you like to precisely control event hooking";
					type=K_TEXT;
					key="ohw_HookMoreOhw";
					check="true";
					callback = function( state )
						ONEHITWONDER_HOOK = state.checked;
					end;
					feedback = function( state )
						if state.checked then 
							return "More hooks will be installed (define them below)";
						else
							return "No additional hooks will be installed";
						end
					end;
					default = {
						checked = true;
					};
					disabled = {
						checked = true;
					};
				};
				{
 					id="ohw_CallOhwPos1";
					text="Before event";
                   	helptext="Call OHW before hooked event process";
					type=K_TEXT;
					key="ohw_CallOhwPos";
					value="before";
					radio=true;
					callback = ohw_radioOhwPosCallback;
					feedback = ohw_radioOhwPosFeedback;
					default = ohw_radioOhwPosDefault;
					disabled = ohw_radioOhwPosDisabled;
					dependencies = ohw_radioOhwPosDeps;
				};
				{
 					id="ohw_CallOhwPos2";
                   	text="After event";
                   	helptext="Call OHW after hooked event process";
					type=K_TEXT;
					key="ohw_CallOhwPos";
					value="after";
					radio=true;
					callback = ohw_radioOhwPosCallback;
					feedback = ohw_radioOhwPosFeedback;
					default = ohw_radioOhwPosDefault;
					disabled = ohw_radioOhwPosDisabled;
					dependencies = ohw_radioOhwPosDeps;
				};
				{
 					id="ohw_HooksHeader";
                   	text="Check Events to hook";
                   	helptext="Checked events will call OHW for processing";
	                type = K_HEADER;
					dependencies = ohw_radioOhwPosDeps;
				};
				{
 					id="ohw_ToggleHooks";
                   	text="Check/Uncheck all events";
                   	helptext="Toggle checking of all events defined below";
					type=K_TEXT;
					key="ohw_ToggleHooks";
					check=true;
					callback = function( state )
						-- we do nothing here
					end;
					feedback = function( state )
						ohw_ChangeAllHooksTo( state.checked );
						if (state.checked) then
							return "All events hooked";
						else
							return "All events unhooked";
						end
					end;
					default = {
						checked = true;
					};
					disabled = {
						checked = true;
					};
					dependencies = ohw_radioOhwPosDeps;
				};
			};
		};

		ohw_HookOhwOptions( setOhw );
		
		Khaos.registerOptionSet( "other", setOhw );
	else
		OneHitWonder_Print( "OHW: Khaos not found, hooking ALL", 0, 1, 1 );
		
		-- hook 'em all !
		ohw_HookAllHooks();
	end
end

function ohw_CallOhw()
	if (OneHitWonder_DoStuffContinuously) ~= nil then
		-- YZLib.dbg.debug2( 3, "Calling OHW!" );
		OneHitWonder_DoStuffContinuously();
	end
end

local ohw_AdditionalHooks = {
	{ "ActionButtonDown",			"ohw_CallOhw",	nil,	nil	},
	{ "ActionButtonUp",				"ohw_CallOhw",	nil,	nil	},
	{ "BonusActionButtonDown",		"ohw_CallOhw",	nil,	nil	},
	{ "BonusActionButtonUp",		"ohw_CallOhw",	nil,	nil	},
	{ "UseAction",					"ohw_CallOhw",	nil,	nil	},
	{ "UseContainerItem",			"ohw_CallOhw",	nil,	nil	},
	{ "CastSpell",					"ohw_CallOhw",	nil,	nil	},
	{ "CastSpellByName",			"ohw_CallOhw",	nil,	nil	},
	{ "AttackTarget",				"ohw_CallOhw",	nil,	nil	},
	{ "PetAttack",					"ohw_CallOhw",	nil,	nil	},
	{ "CastPetAction",				"ohw_CallOhw",	nil,	nil	},
	{ "SpellTargetUnit",			"ohw_CallOhw",	nil,	nil	},
	{ "SpellStopCasting",			"ohw_CallOhw",	nil,	nil	},
	{ "TargetUnit",					"ohw_CallOhw",	nil,	nil	},
	{ "TargetUnitsPets",			"ohw_CallOhw",	nil,	nil	},
	{ "TargetLastTarget",			"ohw_CallOhw",	nil,	nil	},
	{ "TargetNearestEnemy",			"ohw_CallOhw",	nil,	nil	},
	{ "TargetByName",				"ohw_CallOhw",	nil,	nil	},
	{ "TargetLastEnemy",			"ohw_CallOhw",	nil,	nil	},
	{ "TargetNearestFriend",		"ohw_CallOhw",	nil,	nil	},
	{ "TargetNearestPartyMember",	"ohw_CallOhw",	nil,	nil	},
	{ "TargetNearestRaidMember",	"ohw_CallOhw",	nil,	nil	},
	{ "ClearTarget",				"ohw_CallOhw",	nil,	nil	},
	{ "CameraZoomIn",				"ohw_CallOhw",	nil,	nil	},
	{ "CameraZoomOut",				"ohw_CallOhw",	nil,	nil	}
--	{ "WorldFrame",					"ohw_CallOhw",	"before",	"OnMouseDown"	},
--	{ "WorldFrame",					"ohw_CallOhw",	"after",	"OnMouseUp"	},
};

function ohw_choose(a,b)
	if (a) then
		return a;
	else
		return b;
	end
end

function ohw_HookOhwOption( setOhw, v )
	local name = v[1]; local func = v[2]; 
	local pos = v[3]; local scr = v[4];
	local txt = "["..name; if (scr) then txt = txt.."."..scr; end; txt = txt.."]";
	local tid = "ohw_Hook"..name; if (scr) then tid = tid..scr; end;

	local option = 
	{
 		id = tid;
		text = txt;
		helptext="Hook this function to call OHW processing from it";
		type=K_TEXT;
		key="ohw_Hook"..name;
		check="true";
		callback = function( state )
			-- YZLib.dbg.debug2( 2, "hook-"..tostring(state.checked)..": "..name );
			ohw_SetupHookForOhw( state.checked, name, func, pos, scr );
		end;
		feedback = function( state )
			if state.checked then
				return tid.." will be hooked";
			else
				return tid.." will not be hooked";
			end
		end;
		default = {
			checked = true;
		};
		disabled = {
			checked = true;
		};
		dependencies = ohw_radioOhwPosDeps;
	};
	
	table.insert( setOhw.options, option );
end

function ohw_HookOhwOptions( setOhw )
	table.foreach( ohw_AdditionalHooks, function(k,v) ohw_HookOhwOption(setOhw,v); end );
end

function ohw_ChangeAllHooksTo( b )
	if (Sea) then
		-- YZLib.dbg.debug2( 2, "Changing all hooks to "..tostring(b) );
		table.foreach( ohw_AdditionalHooks, function(k,v) ohw_ChangeHookTo( b, v[1], v[4] ); end );
		-- Khaos.refresh();
	else
		-- YZLib.dbg.debug2( 2, "No Sea found..." );
	end
end

function ohw_ChangeHookTo( b, name, scr )
	local tid = "ohw_Hook"..name..ohw_choose(scr,"");
	-- YZLib.dbg.debug2( 2, "Changing "..tid.." hook to "..tostring(b) );
	if (Khaos) then
		Khaos.setSetKeyParameter( "ohw_HookingOptions", tid, "checked", b );
	end
end

function ohw_HookAllHooks()
	-- mark for total hooking
	ONEHITWONDER_HOOK = true; ONEHITWONDER_HOOK_POSITION = "after"; 
	
	if (Sea) then
		-- YZLib.dbg.debug2( 2, "Sea found..." );
		OneHitWonder_Print( "OHW: Hooking all events.", 1, 0, 0 );
		table.foreach( ohw_AdditionalHooks, function(k,v) ohw_SetupHookForOhw( true, v[1], v[2], v[3], v[4] ); end );
	else
		-- YZLib.dbg.debug2( 2, "No Sea found..." );
		OneHitWonder_Print( "OHW: No Sea found - not hooking events.", 1, 0, 0 );
		
		-- setup default hooking options: hook everything
		OneHitWonder_ShouldOverrideBindings = 0;
	end
end

function ohw_SetupHookForOhw( b, name, func, pos, scr )
	-- YZLib.dbg.debug2( 2, "Hooking "..ohw_choose(pos,ONEHITWONDER_HOOK_POSITION).." "..tid );
	if (Sea) then
		if( not b or ONEHITWONDER_HOOK ) then
			-- TODO: unhook both variants ?
			Sea.util.unhook( name, func, "after", scr );
			Sea.util.unhook( name, func, "before", scr );
			if b then
				-- YZLib.dbg.debug2( 2, "Hooking: {"..name..","..func..","..ohw_choose(pos,ONEHITWONDER_HOOK_POSITION)..","..ohw_choose(scr,"").."}" );
				Sea.util.hook( name, func, ohw_choose(pos,ONEHITWONDER_HOOK_POSITION), scr );
			end
		end
	end
end

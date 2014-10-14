SSHonorFu = AceLibrary( "AceAddon-2.0" ):new( "FuBarPlugin-2.0", "AceConsole-2.0" );

local tablet = AceLibrary( "Tablet-2.0" );

function SSHonorFu:OnLoad()
	local menu = {
		type = "group",
		args = {},
	};
	
	for _, config in SlashCommands do
		if( config.type == "toggle" ) then
			menu.args[ config.cmd ] = {};
			
			local var = config.var;
			local func = config.func;
			
			menu.args[ config.cmd ].type = "toggle";
			menu.args[ config.cmd ].set = function()
				SSHonor_Config[ var ] = not SSHonor_Config[ var ];
				
				if( func ) then
					if( type( func ) == "string" ) then
						getglobal( func )();
					elseif( type( func ) == "function" ) then
						func();
					end
				end
			end
			
			menu.args[ config.cmd ].get = function() return SSHonor_Config[ var ]; end

			menu.args[ config.cmd ].name = getglobal( "SSH_" .. config.localization .. "_NAME" );
			menu.args[ config.cmd ].desc = getglobal( "SSH_" .. config.localization .. "_DESC" );
		
		elseif( config.type == "execute" ) then
			menu.args[ config.cmd ] = {};
			menu.args[ config.cmd ].type = "execute";
			menu.args[ config.cmd ].func = config.func;
		
			menu.args[ config.cmd ].name = getglobal( "SSH_" .. config.localization .. "_NAME" );
			menu.args[ config.cmd ].desc = getglobal( "SSH_" .. config.localization .. "_DESC" );
		end
	end
	
	SSHonorFu.OnMenuRequest = menu;	
end

function SSHonorFu:OnTooltipUpdate()
	local cat = tablet:AddCategory( "columns", 1 );
	
	tablet:SetTitle( SSH_TODAYS_HONOR );
	cat:AddLine( "text", SSHonor_CreateTooltip( "today" ) );
end
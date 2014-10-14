--[[ CmdHelp -- Generic command help system.
    Written by Vincent of Blackhand, (copyright (c) 2006 by D.A.Down)
    Version history:
    0.9 - WoW 1.12 update.
    0.8.2 - Added help argument list to most displays.
    0.8.1 - Added 'help' to every argument list.
    0.8 - Initial release.

Usage: CmdHelp(<help table>,<command string>,<argument string> [,<print function>])
	If no print function if given the internal default will be used.
Arguments:
	'help' - lists the commands defined in the <help table>.
	'help?' - describes the commands defined in the <help table>.
	'?' - lists the arguments defined for the command <command string>.
	'<arg>?' - describes the argument <arg> for the command <command string>.
	'??' - describes all arguments for the command <command string>.
Returns: <nil> the the argument isn't a recognized help request, else 1.

]]
local Print
-- Default print function
local function PRINT(msg) SELECTED_CHAT_FRAME:AddMessage(msg) end

-- Iterative function for a sorted table
local function sorted(tb,comp)
	local ix = {}
	for key in tb do
	  tinsert(ix,key)
	end
	sort(ix,comp)
	local iter = function (state,key)
	  state.ky,key = next(state.ix,state.ky)
	  return key,state.tb[key]
	end
	return iter,{ix=ix,tb=tb}
end

local function Help(tbl,cmd,full)
	local pre,list,desc = cmd=='/' and "'/" or "'"
	for name,data in sorted(tbl) do
	  if name=='?' then
	  elseif full=='?' then
	    desc = type(data)=='string' and data or data['?'] or data[''] or '??'
	    Print(format("%s%s - %s.",cmd,name,desc))
	  else list = (list and list..', ' or '')..pre..name.."'"
	  end
	end
	if list then
	  Print((cmd=='/' and 'Commands' or cmd)..': '..list)
	end
end

function CmdHelp(tbl,cmd,arg,print)
	Print = print or PRINT
	if not tbl then
	  Print("Error: Missing help table for CmdHelp().")
	  return 1
	end
	if not cmd then
	  Print("Error: Missing command label for CmdHelp().")
	  return 1
	end
	local name = tbl['?'] or "'/"..cmd.."'"
	if not arg then Print("For "..name.." commands, type '/"..cmd.." help'.") return end
	if arg~='' and arg~='help' and strsub(arg,-1,-1)~='?' then return end
	Print(name.." help by CmdHelp for the request '"..arg.."':")
	local _,_,arg,full = strfind(arg,"^(..-)(%??)$")
	if not tbl[cmd] then
	  Print("Error: Command '"..cmd.."' isn't defined in help table.")
	elseif not arg then
	  Print("'/"..cmd.." help' to list defined commands.")
	  Print("'/<cmd> ?' to list defined arguments for <cmd>.")
	  Print("'/<cmd> <arg>?' to describe <arg> for <cmd>.")
	  return 1
	elseif arg=='help' then Help(tbl,'/',full)
	elseif arg=='?' then
	  tbl[cmd].help = "List the defined commands"
	  Help(tbl[cmd],'/'..cmd..' ',full)
	elseif tbl[cmd][arg] then
	  Print(format("/%s %s - %s.",cmd,arg,tbl[cmd][arg]))
	else Print("Undefined: '/"..cmd..' '..arg.."'.") end
	Print("Help arguments: '?', '??'. 'help' or 'help?'.")
	return 1
end

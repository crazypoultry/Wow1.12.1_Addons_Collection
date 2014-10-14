PanzaComm Communication Library
-------------------------------
PanzaComm was developed to enhance Panza, GuildMap, and other addons with real-time message capability.
Future versions of this addon will include a GUI (Titan/FuBar) for management, and status.

Manual
------
PanzaComm is a communication library for using real time data in Addons. 
PanzaComm has a command line interface, but no real configuration is required. PanzaComm usually operates automatically. 
CLI options are available using /pcom

Operation
---------
PanzaComm may be enabled, and disabled. No configuration is required, and the /pcom cli is simple.

Recommended Configurations
--------------------------
No configuration is required in this version. It's completly automatic.
	
When PanzaComm loads, and Addons register, PanzaComm will wait for messages from the CHAT_MSG_ADDON Event, and try to match Addons registered with the Prefix used in arg1 of the message. PanzaComm will send messages to the destination used when addons register when messages are sent.
  
PanzaComm will not transmit any messages if you are marked AFK (bringing you out of AFK status). 
PanzaComm is not designed to handle very large messages. Short concise data is recommended. See the examples. 
This was intended for large guild/raid use.

PanzaComm API
-------------
Three functions are provided by this addon:

PanzaComm_Register("AddonID", Receiver_Function, Mode, "Destination")
PanzaComm_Message("AddonID", "message");
PanzaComm_ChannelOK("AddonID");

The message format is dependent the addon that registers. The Receiver function must be built into each addon that wishes to use PanzaComm capabilities. 
The addon must register with PanzaComm and provide PanzaComm an "AddonID" and this Receiver Function. 
When PanzaComm receives messages that have a "AddonID" as the first field of the message, PanzaComm will pass this message to the receiver function 
that was registered with that ID. 

PanzaComm wll match the ID to IDs that are registered. Using this method, many Addons may use PanzaComm as the base communication library, each with different message formats.  
Addons must use PanzaCom's PanzaComm_Message() function to send messages out.

The "AddonID" is provided when you use the PanzaComm_Register() function. 
The format is PanzaComm_Register("AddOnID", Receiver_Function, Mode, "Destination"). 
PanzaComm_Register returns true if the addon registered successfully, or false if PanzaComm cannot see the Receiver Function. 
Mode may be passed as 1 or 2. 1 = Send/Receive, 2 = Receive Only. If Mode=nil then PanzaComm will assume Send/Receive.
"Destination" must be "Party","Raid" "Guild", or "BG". If destination is not specified, then "Guild" is used.
Note that multiple registrations for the same "AddOnID" will overwrite previous registrations, and provides the means for an Addon to switch
channels. Reregister with the channel you want to switch to.

The receiver function used in PanzaComm can be a guide on building message support into other addons. The only
requirement is specifying the Addon ID in the sent messages using PanzaComm_Message(). 
The format for sending messages using PanzaComm is PanzaComm_Message("AddonID",message). 
The message argument can be anything you want. 
The receiver function in the Addon using PanzaComm is responsible for decoding the message format. 
The message sent from PanzaComm to the receive function contains two parameters, the sender's id, and the message. 
The Registered App's Receiver function must handle these two parameters. The parent addon does not have to worry
about destination management, all destination management is automatic handled through PanzaComm.

Example: 

Destination="Guild"|"Party"|"Raid"|"BG";

function MyRegister()
	if (not PanzaComm_Register("MyAddon",MyReceiver,1,Destination) then
		-- print out register error
	end
end	

function MyReceiver(sender, message)

	-- dont worry with our own messages received
	if (sender == UnitName("player") then
		return;
	end

	-- Process the message
	if (string.find(message,..<some format>...)) then
		...
	end
end


function mySend(MyAddon, message)
	if (PanzaComm_ChannelOK(MyAddon) then PanzaComm_Message(MyAddon, message);end;
end

See the included GuildMap (a converted addon), and PanzaComm's own internal Receiver for more information.


Version History
---------------
Version 3.03
* "for in pairs()" conversion to be compatible with Burning Crusade

Version 3.02
* Update destination from "Guild" to "Raid" when not in a guild, or left guild.

Version 3.01
* Will update destinations that should be Guild once guild info is available
* Mark destinations that are in use when destinations change.

Version 3.0
* Uses SendAddonMessage from 1.12 API. No longer uses any channels.
* Will automatically switch to Battleground Destination for Addons that Register with Raid or Party. Will switch back also.
* Updated to 1.12 Client

Version 2.01
* Correctly observes AFK 

Version 2.0
* Dual Channel Operation
* Updated cli
* Less join tries when all 10 channels are in use
* Updated to 1.11 Client

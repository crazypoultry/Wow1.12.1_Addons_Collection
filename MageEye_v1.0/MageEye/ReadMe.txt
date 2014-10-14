** Magus 1.0 **  Created by Atravis (Skullcrusher Horde Side)

This add-on gives a mage options for announcing Polymorph spells and Decursing party and raid members.


Magus Options

Silent Polymorph:
	This checkbox turns On/Off the announcement when a polymorph spell is cast.
	The three text boxes allow the mage to customize the text for each polymorph spell.
	Two tags are included to allow quick entry of mob Level & Name. 
	{L} = Level
	{N} = Name



Audio/Text Curse Alert:
	This checkbox turns on/off the audio/text alert when a party or raid member is afflicted with a curse.	
	If Curse alert is one when a party or raid member is cursed a sound is played and a message is 
	displayed with the affected players name. i.e. "Thrall is Cursed!"

	Two slash commands can be used to make a quick decurse macro.	
	The macro should look like this:
				    /FindCurse 
        				    /cast Remove Lesser Curse
				    /CurseEnd		
/FindCurse:	This will search party & raid members and target the first one with a curse.
/CurseEnd:	This will cancel the spell if a curse was not found and if you last target was an enemy it will reselect them.		

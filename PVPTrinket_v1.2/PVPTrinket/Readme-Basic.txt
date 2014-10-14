This is a mod to swap and use trinkets automatically


1) PVE Setup

to set up these trinkets do following commands:
/pt add rotation [use] trinket_link 	 - 'use' optional (use trinket when ready), works only with active trinkets


------------------commands example-------------------------

/pt add rotation use Talisman of Ephemeral Power     - 'use' only if active trinket   
/pt add rotation use Zandalarian Hero Charm   
/pt add rotation Neltharion's Tear

-----------------------------------------------------------

2) PVP Setup 

When u target player mod will equip class defined trinkets (for example before duel),
to set up do following commands:

/pt add class_name slotID [use] trinket_link	 - 'use' optional (use trinket when ready), works only with active trinkets

------------------commands example-------------------------

For example you are a hunter and you need to equip trinkets which are usefull when u fight against mage

/pt add mage slot1 Insignia of Alliance

... and warlock

/pt add warlock slot1 use Arena Grand Master		- 'use' only if active trinket   
/pt add warlock slot2 use Glimmering Mithril Insignia

-----------------------------------------------------------


3) Using trinkets automatically if equipped (only trinkets from PVE/PVP list). 


When you cast offensive spell you can use trinkets automatically, in order to do this u have to create macro. 

/pt launch
/script (your macro with offensive spell)


--------macro example------

/pt launch
/script CastSpellByName("Pyroblast")

--------------------------

4) List of commands


/pt add rotation [use] trinket_link 	- add trinket to PVE list
/pt reset rotation			- reset trinket PVE list

/pt add class_name slotID [use] trinket_link  - add trinket to PVP list, SlotID = {slot1,slot2}
/pt reset class_name 			- reset PVP list

/pt show 	- show trinkets list
/pt help	- dispaly avaliable commands
/pt spam 	- disable/enable spam
/pt lock SlotID - lock/unlock current slot for automatically swapping, SlotID = {slot1,slot2}


SmartRestore v3.7
Created by ScepraX.

"The purpose of this mod is to help people to easily restore their mana and health in and out of combat."
This mod works through commands, macros and keybindings. It has no nice interface or extensions for other mods.

----------------------------------------------------------------
WHY IS THIS MOD SMART?
----------------------------------------------------------------
This mod will try to pick the best suited potion, bandage or food that's suited for the job.
When you press the keybinding, use the macro or type the slashcommand, the mod will determine how much health/mana you need and will try to find the best item and use it on you or your target (in some cases).

Conjured food will be used if available, unless you choose to always use the best food, and some better food is available.
In the progress it will check if you're buffed and will try to use buffing food if you're not buffed. If you're buffed it will smartly try buffing food as last. (This way buffing food is used as efficiently as possible.)
It will also try to find the item with a restore value as close as possible to the needed amount, thus trying to waste as little items as possible. (Now it's usefull to carry some low-level food with you for the small restores.)
When you carry several equal food stacks, the mod will pick the smallest stack and use items from that stack. (This will result in more bagspace. I wish more mods would implement this.)

Also available are several smart ways to restore yourself and several ways to adjust the restore process using slashcommands.
----------------------------------------------------------------
USING THE MOD!
----------------------------------------------------------------
It has 3 ways to replenish health and/or mana out of combat:
 	- Eating: will restore health.
 	- Drinking: will restore mana.
 	- Smartrestore: will restore both health and mana, preferably by means of food that support both, like Smoked Sagefish. 
Any of these three will try to use buff food is no buff is found by default. This is configurable.
There are also commands for the use of cookable food and conjured food.
 
There are 4 ways to restore health and mana in combat:
	- Mana: will use the best mana potion available. If a mana gem is available it will use that. And if no mana potion if available, but a rejuvination potion is, it will use that.
	- Health: will use the best health potion. If a healthstone is available, if will be used instead. If no health potion is available, a rejuvination potion will be used.
	- Smartpotion: Will use a rejuvination potion if available. If none is available if will try to use a healing potion. If that too is not available, it will try to use a mana potion. It's best used when having rejuvination potions.
	- Bandage: This will use the best bandage available on a selected friendly target or the player. It will not deselect your target! Also, if you have a pet active it will try to use a bandage on your pet if it needs it.
		- It's possible to auto-apply anti-venom on the target (if it's poisoned) using one of the commands at the bottom of the page.

There are also some additional functions:
	- Smart: Will use food out of combat, and potions in combat. This will try to replenish your health and mana in any way possible (Except for bandages, because that would be a waste most of the time.)
 	- Buff: Will get the best buffing food out of your inventory and eat it, whether you need health/mana or not. Using the command "buffing" won't disable this but only the use of buff food when normal eating.
	- Anti-Venom: Will try to use the best Anti-Venom on your current target or the player.
	
Hunters:
	- The mod also includes a fully functional petfeed system. This system is automatically called by the smart restore and smart eat functions.
		- Also available are slashcommands and keybindinds.
	- The mod will choose between equal food to use food your pet can't use whenever possible.
		- For instance, assume you have a Meat eating pet and 2 stacks of food: 1 cured ham steak, 1 moon harvest pumpkin.
		- The mod will always choose to use the last when you use this mod to eat, saving the meat for the pet.
		- Off course when only meat is available, meat will be used.
		- Also note that this only works between equal foodstacks. That means that, to continue our example, if you also had a stack of roasted quil and that would heal a better amount of health suited for you, the pumpkins won't be used, but a non-meat stack equal to the roasted quil would. Or if not available, the roasted quil itself. (And not the pumpkins, as they would not heal a sufficient amount.)
	- There are 4 hunter only options to set:
		/sr pethappiness ## - Allows the player to define the pet happiness goal. When set to 0 or 1 petfeeding is disabled. 2 means content is the goal when feeding. 3 is happy.
		/sr petfeedmode - Allows the player to define how to choose food for the pet.  1 means best food will be choosen, 0 the worst available food. 
		/sr petcooking - (Dis)Allow the use of food that could be cooked first for your pet.
		/sr petbuffing - (Dis)Allow the use of food that give bonusses for your pet.  
		/sr autofeed - (Dis)Allow autofeeding of your pet when eating.
	- Note that when feeding the pet occurs triggered by the smartrestore function, it mights be necessary to trigger the function again to start eating.
	- When Fizzwidget Feed-O-Matic (www.fizziwdget.com) or Petfeeder (http://www.curse-gaming.com/en/wow/addons-504-1-pet-feeder.html) is loaded, this will be used instead.

----------------------------------------------------------------
NEED-TO-KNOW COMMANDS!
----------------------------------------------------------------
There are some very handy supporting commands:
	- Maximum Health: This can be set in percent (Default: 90%). This mod will not heal if your health is above this value. So if this is set on 50%, this mod won't do anything unless your health drops below 50% of your max health.
	- Maximum Mana: Same as health, but now for mana.
	- Text: It's possible to turn on and off the text display.	
	- Cooking: By default food that can still be cooked won't be used, but this can be turned on.
	- Buffing: By default food that buffs is used, but this can be turned off if prefferred.
	- Reset: Will reset all saved variables.
	- Bufftime: Allows the user to set the time. Default is 30 seconds.
	- Conjure Last: When activated conjured food will be used after normal food when not using smart mode. This is particularly handy for mages that wish to keep the amount of food in their inventory small. Default is off.
	- Maximum Use: When activated, the mod won't look at the needed health/mana, but will just use the best available item.
	- Food Multiplier: Default is 2. This is a very interesting feature as it changes the way slow food (food that restores over time) is choosen.
		- Basically the amount the food would heal is multiplied with this value before checking for the need. By default therefor the mod assumes slow food heals twice the amount it actually says in their tooltips.
		- If set to high values the worst food always will be used. If set to 1 the food will be chosen that actually heals the neccesary amount (or as close as possible). The last is default functionality for bandages and potions.
		- When using slow food several things matter:
			- The players generates over time.
			- While sitting regenerating is doubled.
			- Often a player doesn't actually wait until the eating buff has finished.
		- This multiplier is an attempt to compensate.
		- If set to 0 the mod will think that slow food doesn't heal at all and will therefor choose stack based.
	
	- Modes: By default this is 0. 
		- In mode 0 the best food will be used picked out of all categories.
		- In mode 1 food will be used per category, first depleting the first category, then the second, then the third. 
		- In mode 2 the best food will be used picked out of all categories based upon their stack amount, and not restore value..

----------------------------------------------------------------
BRIEF OVERVIEW CLASHCOMMANDS
----------------------------------------------------------------	
A brief view on the commands (mainly meant to be used in macros):
/sr or /smartrestore - Display this list with commands.
/sr smart - Triggers the smartrestore function if out combat, or the smartpotion function if in combat, thus always resulting in the best restoration.
/sr smartrestore - Triggers the smartrestore function resulting in drinking and eating simultaneously.
/sr smartpotion - Triggers the rejuvenation function resulting in using the best rejuvenation available.
/sr bandage - Triggers the bandage function resulting in using the best bandage available on a selected friendly player or the player self.
/sr mana - Triggers the mana function resulting in using the best mana potion. or conjured gem if available.
/sr health - Triggers the health function resulting in using the best healing potion or healthstone if available.
/sr eat - Triggers the eat function resulting in using the best food available.
/sr drink - Triggers the drink function resulting in using the best drink available.
/sr buff - Will try to eat the best available buff food.
/sr antivenom - Triggers the Anti-Venom function resulting in trying to use the Anti-Venom inventory items if the target is poisoned.
/sr mode ## - Allows the player to define the way the mod chooses items. In mode 0 the best food out of all categories will be used. In mode 1 the first found item will be used. In mode 2 the item from the smallest stack will be used. (Default is mode 0).
/sr maxhealth ## - Allows the player to define the percentage of health under which potions, food and bandages can be used. (80 would mean that only when current health of the player is below 80% healing will be applied.) Minimum value is 10%. (Default is 90.)
/sr maxmana ## - Allows the player to define the percentage of mana under which potions and drinks can be used. (Default is 70.)
/sr bufftime ## - Allows the player to define the time (in seconds) of the current foodbuff under which buffing food may be used. Minimum value is 0. (Default is 30 seconds.)
/sr minhealth ## - Allows the player to define the minimum amount of health the player should have to allow the use of mana potions through the smartpotion function. (Default is 30.)
/sr foodmultiplier ## - Allows the player to define the multiplier used for power calculation of slow food. (Default is 2.)
/sr text - Display or don't display the messages in the chatframe. (Default is on.)
/sr cooking - (Dis)Allow the use of food that could be cooked first. (Default is off.)
/sr buffing - (Dis)Allow the use of food that give bonusses. (Default is on.)
/sr forcepotion - (Dis)Allow the use of potions out of combat. (Default is off.)
/sr conjuredlast - (Dis)Allow the use of conjured food as last resort. (Default is off.)
/sr maximumuse or /sr maxuse - (Dis)Allow the use of items based upon the need of the player, or just use the best item available. (Default is off.)
/sr antipoisonbeforebandage - (Dis)Allow the forced use of Anti-Venom before applying a bandage. (Default is off.)
/sr debug ## - Activates debug mode number ##. (Default is 0 (deactivated))
/sr status - Prints all saved variables.
/sr default or /sr reset - Resets all saved variables to their default values.
		
----------------------------------------------------------------	
ENJOY!
----------------------------------------------------------------		
Don't forget to open your first aid window before using bandages!
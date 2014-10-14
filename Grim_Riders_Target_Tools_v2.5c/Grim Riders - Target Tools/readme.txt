-- How to Install --

Place the "Grim Riders - Target Tools" folder found in this archive into your "Interface/AddOns/" directory.

-- Notes -----------

::Slash commands

/grtt on 		Enable Grim Riders - Target Tools
/grtt off		Disable Grim Riders - Target Tools
/grtt lock		Lock the UI
/grtt unlock		Unlock the UI
/grtt toggle		Toggle between locked / unlocked UI
/grtt help		Display mini help in chat
/grtt dir		Change the attachment location of menu bar and leader toolbar in Layout 3
/grtt pull #		Change the height of the Pull Progress bar in Layout 4. # must be > 0.

::Target Tools Modes

[Raid Member]

	In [Raid Member] mode, the player is only able to see targets assigned by the [Leader]. When the 
	[Leader] place an Icon on a target, or calls an action on it, the [Raid Member]'s UI will update 
	to reflect that change.

	Actions available to the [Raid Member]:
	
	- Left click on the icon or portrait of a target to select that target

[Leader]

	In [Leader] mode, the player is able to assign targets, place icons, and call actions. You must be 
	a RAID LEADER, ASSIST, or PARTY LEADER to access this mode.

	Actions available to [Leader]:

	----- While Icon is (Minimized): -----

		- Leftclick on Icon	If you have a hostile MOB selected, it will place the icon you 
					selected over it's head. In addition, all [Raid Member]s will also 
					recieve this target.

					If you have a [Raid Member] selected, it will assign 
					that [Raid Member] to the Icon. On the [Leader]'s UI, a red 
					lightning bolt will indicate that you have assigned this icon to a 
					[Raid Member], but have not yet assigned him a target. The 
					[Raid Member] will receive a blue outlining box for his assigned Icon.
		
		- Rightclick on Icon	Will force erase the icon off a SELECTED target.

	----- While Icon is (Maximized): -----

		- Leftclick on Icon	Same functionality as Leftclick on Icon (Minimized).

		- Rightclick on Icon	This will (Minimize) the Icon window and erase the target and 
					target assignments and the assigned Icon.

		- Leftclick on Model	This will {Call DPS} on the target. All [Raid Member]s will receive 
					the {Call DPS} on your selected target.

		- Rightclick on Model	This will {Hold DPS} on the target. All [Raid Member]s will receive 
					the {Hold DPS} on your selected 

		- Middleclick on Model	This will {Clear} any calls on the target. All [Raid Member]s will 
					receive the {Clear} call on your selected target.

		- Leftclick on Horn	This will announce the assignment by whisper to the [Raid Member] 
					who is Assigned the icon. No action if no one is assigned to it.

		- Rightclick on Horn	This will announce the assignment to raid, listing which Icons were 
					assigned to which [Raid Member]s.

:: Other Functions

	The [Leader] has some additional actions he can use:

		- Announce All		This is found bottom right, it does the same function as the Horn, 
					except for ALL Horns simultaneously.

		- Request List		This is found bottom right, it requests a list of users who have 
					Grim Riders - Target Tools installed.

		- Minimize All		This is found top right, it does the same function as Rightclick 
					on Icon (Maximized) but for ALL Icons simultaneously.

		- Simple Mode		This is found bottom right - enabling this will cause all icons to 
					stay minimized.

		- Lock in Combat	This is found bottom right - This will lock icon placement in combat 
					to prevent accidental icon changing.


	Options:
		
		- UI Sounds				Enable and Disable target tools sound effects

		- Clear Icon on Exit Combat		If enabled, all icons will be removed and minimzed 
							on combat end

		- Lock Interface in Place		Prevent UI from being dragged

		- Target By Name as Last Resport 	Use TargetByName() API to try to select a target if
							no one in the raid has it selected. (advanced feature)

		- Fade Menu Bar When Inactive		Fade the menu and toolpannel when it is not used

		- Show GRTT on Join/Leave part		The visibility of GRTT is based on if you are in a
							party or not if this is enabled. If this is turned
							on and you are not in a party, grtt can still be
							braught up using the normal /grtt on method.

		- Display Target Counts			Shows how many [Raid Member]s are targetting a
							specific icon.

		- Display Marked Target HP		Shows HP bars for all icon'd mobs aswell as a bar
							which shows all of their combined hp, known as
							Pull Progression bar.


	Target Tools has 4 Layouts that any mode can use:

		Layout 1 - Default	This is a 4x2 matrix of icons

					===
					x x x x
					x x x x
					   ----

		Layout 2 - Line		This is a 8x1 matrix of icons

					===
					x x x x x x x x
						   ----

		Layout 3 - Column	This is a 1x8 matrix of icons.
					You can change the direction of menu panel and leader tools by 
					typing /grtt on


		Layout 4 - Free		Hold shift and click on a component to drag it.

:: Bugs

	When you have many similar targets marked, (for example, 3 Wild Bores), the mod cannot tell them 
	apart, and sometimes fails to remove the Icon when using Rightclick on Icon (Minimized). Simple 
	select the target that has the Icon you wish to remove, and Rightclick on Icon (Minimized) of 
        that type.

	/grtt dir in Layout 3 is still in beta stages, will be fixed soon.

:: Credits

Developed By:
	Razh @ Demon Soul

Grim Riders Logo: 
	Korlong @ Demon Soul
Testing:
	Chile @ Demon Soul
	Charrfireloc @ Demon Soul
	Aravis @ Demon Soul
	Locien @ Demon Soul
	Orco @ Demon Soul
	Grim Riders Guild @ Demon Soul
	Risingashes
	Frstrm
	Vrondor
	

For comments, suggestions, and information, contact Razh at:

zergen at rogers dot com

This UI Mod is designed for Grim Riders, Demon Soul PvP guild, 

http://www.grimriders.com/index.htm
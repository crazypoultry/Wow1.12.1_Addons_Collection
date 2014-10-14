
KLHManaStorm 4.4
Kenco@Perenolde

KLHManaStorm is a one click raid healing mod with a focus on overheal prevention in high latency. 

In a nutshell, it does
--> automatic target selection, based on priority rules you supply
--> automatic spell selection, based on your gear and talents and parameters you can set
--> a casting bar that shows you when to cancel for overheal, taking into account your latency and fps.

______________________________

	Usage

¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯

To run the mod, make a macro like this:
	
    /script klhms.main.execute()

You can make more advanced macros to specify the spell you want cast, or to only cast on your target. To open the mod's menu, type

    /kms

The menu and options are pretty self explanatory. In the tutorial section there is a "Macros" topic that shows you more advanced forms of the macro.

So you have your macro, and you click it. Then you'll get:

_____________________________________

	Spell and Target Bars

¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯

Two bars will appear in the middle of the screen (yeah, they'll be movable soon). The bottom bar shows the status of the spell - it's essentially an improved casting bar. The bar moves down from right to left as the cast time counts down. It has these sections:

(Right) green section: still casting zone. In this area the spell still has a long time to go. Clicking the macro in this section will do nothing.

(Middle) yellow section: safe overheal zone. In this area, a cancel message will definitely reach the server in time. If you click the macro in this zone, the spell will be cancelled if the heal is going to overheal too much. A new spell will also be cast on your current target.

(Left) red section: speed recast zone. In this area, the spell has already been cast, the message just hasn't come to your computer. If you click the macro in this zone, a new spell will be cast.


Above the spell bar is the target bar. It's like a health bar for your target, but it also shows what effect the heal will have. The left part of the bar show's the target's hit points, colour coded (red for low health, green for full health, etc). On the right of their health bar is a blue bar showing how much health the current heal will contribute. If the spell will overheal, a purple bar extends past the end of the player's health bar.

Around the bars are a few labels. At the top right of the casting bar the name and rank of the spell being cast is shown. Above and to the right of the target bar is the name of the target. On the left of that is the expected efficiency of the spell. If it's in 100%, there will be no overheal, 0% efficiency means the spell will completely overheal. If the value is lower than the overheal threshold, this label will be red, if it's above it will be green.


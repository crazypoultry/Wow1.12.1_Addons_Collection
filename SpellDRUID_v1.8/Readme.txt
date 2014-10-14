--Description-- 
By using this mod you will have access to commands which expand on many of a druid's important spells: Rejuvenation, Faerie Fire, Innervate, Rebirth, and Swiftmend. The nature of these commands is described below. 

The original idea for this mod was drawn from Helindor's "Rejuvenation" addon. His functionality extended to Rejuvenation and Faerie Fire only, and I have since expanded upon and replaced most of his code. Nevertheless, thank you Helindor for getting me started! 

--Instructions-- 
To use this mod, make a macro with **ONE** of the following commands and put the macro button on your hotbar: 
 /re rejuv 
 /re swift 
 /re faerie 
 /re innerv 
 /re rebirth 

All of the commands within this mod require a target to be selected for their full features to work. If you do not have a target selected when casting, none of the checks or whispers will apply but the highest rank of the spell will still cast. If you have an unfriendly target selected when casting a friendly spell, it will start casting the highest rank of the appropriate spell. 

--Commands-- 
"/re rejuv" 
*Cast Rejuvenation on your target, using the highest rank appropriate for their level. The spell will not cast if the target currently has the buff active. If the command is activated without a target, the mod will attempt to cast the highest rank of Rejuv the player has. 

"/re swift" 
Identical to "/re rejuv" but with extra functionality. Should any Rejuvenation buff be active on the target, "Swiftmend" will be cast if the player have the spell. If the buff is not active, the command will act like "/re reju" and cast the appropriate rank of Rejuvenation. This feature allows the quick spamming of one button to cast Swiftmend and Rejuvenation successively. Suggested by a druid named Mallark, a noob. It has actually proven quite useful in duels. 

"/re faerie" 
*Cast Faerie Fire on your target, in both caster and feral forms (should the player have the FF talent). Will not cast if the target currently has the debuff active. 

"/re innerv" 
*Cast Innervate on the target. Whispers the target of the incoming spell as it is cast. Will not allow stacking of the spell unless the player click-selects their target, i.e. casts without a target. If the command is activated when the Innervate cooldown is up, a system message will display giving the time until Innervate is ready to cast again. 
*Known issues: will still whisper even if the player is incapacitated should their target be in range and alive. Will also whisper even if the target is out of line of sight under the same conditions. 

"/re rebirth" 
*Cast the highest rank of Rebirth the player has on the target. Whispers the target of the incoming spell as it is cast. Will only whisper if the target is dead. If the command is activated when the Rebirth cooldown is up, a system message will display giving the time until Rebirth is ready to cast again. 
*Known issues: will still whisper even if the player is incapacitated should their target be in range and alive. Will also whisper even if the target is out of line of sight under the same conditions. Will not whisper if the target is click-selected, including when a spirit-released player is rezzed.
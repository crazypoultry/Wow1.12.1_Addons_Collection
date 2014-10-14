`*******************************************************************

wowChess v2.0

Author: Hexarobi
9/1/2006

*******************************************************************

Description:

Play chess with other people inside World of Warcraft. Moves are validated to make sure they are legal. Castling and En Passant are possible. The rules of check are enforced. Use the "/chess join" command to find other players. Stalemate is possible. Win/Draw/Loss records are kept.

NEW:
-Log of each players movements
-Added clock and timed games
-Localized, ready for translation
-Added stalemate
-Resign and OfferDraw commands
-Win/Draw/Loss recording
-/ch rotate command to spin board around

Use "/wowchess", "/chess", or "/ch" to see full help.
Use "/chess join" to find other players to challenge.
Use "/chess challenge <player> [time]" to initate a game with someone else who has this addon. If time is ommited, the game is untimed, otherwise it should be in the format of TotalMinutesPerPlayer/BonusSecondsPerMove. Example: "/chess challenge smitty 5/3"

Known Problems:
When a player's clock runs into the negative, it should force that player to resign. Due to unreliable clocks between players, the clock simply continues to run into negative. 

Future Features:
Multiple games at once (gunna be tough)
Playable by mail
A nice lobby to find games and watch other's games
battlechess style animations using warcraft2 sprites/sounds

Changelog:

v2.0
-Added move log
-Added clock and timed games
-Changed standard board color to green
-Moved strings into localization.lua for translating
-Translated localization.lua into german, if anyone wants to translate into other languages, drop me a line at hexarobi@gmail.com

v1.10
-Added stalemate check
-Added code to stop hilighting moves that would put king into check
-Added ack return, to keep games synced incase of crash
-Added version check to challenge, to prevent version mismatches late in the game
-Added resign and draw commands
-Added win/draw/loss record
-Updated interface version to 11200
-Added /ch join
-Changed En Passant code to follow real rules
-Fixed skin changing bug under 11200
-Added /ch mute to stop sound effects
-Re-joined playerbar toggles to be together instead of seperate
-Added /ch rotate command to flip board around

v1.9
-Sliding pieces animation
-Yellow last-move highlighting
-Added current turn and incheck indicators
-Independant playerbar toggling
-Fixed saved game turn bug
-Added copy command to copy games from one opponent to another
-Removed undo command

v1.8
-Added portrait bar toggle to save screen space
-Added a scale command to adjust scale of board
-Fixed no board showing up bug
-Removed wowChess channel auto-join

v1.7
-Added Portraits and Captured Pieces counters
-Fixed checkmate not being sent to opponent bug
-Changed highlighting slightly to do a mouseover on green spaces
-Fixed crashing when zoning with full channel list and cTRA

v1.4-1.6
-Quick bug fixes

v1.3
-Fixed castling bug
-Changed highlight graphics
-Added checkmate check
-Fixed pawn hopping
-Added more black pawn sounds

v1.2
-Added missing white king sounds.
-Added legal destination highlighting
-Fixed wowchess channel autojoin

v1.1
-Added Sounds to Warcraft2 skin. Zugg-Zugg!
-Added pawn promotion.

v1.0 - Initial Public Release

Acknowledgments:
Warcraft2 sprites ripped by krka


*******************************************************************
Send comments/suggestions/bugs to hexarobi@gmail.com
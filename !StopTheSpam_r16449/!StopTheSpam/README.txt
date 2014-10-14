StopTheSpam

Copyright (c) 2006, Tyler Riti
All rights reserved.

--------------------------------------------------------------------------

Install the !StopTheSpam folder into "World Of Warcraft\Interface\AddOns" 
just like you did for the hundreds of other addons that you have. If have 
never installed any other addons, then I guess you really don't need this 
one, mm? Make sure that the folder name retains the '!' character at the 
beginning so that it loads before any of your other addons. There's 
nothing to configure for this addon -- it just does its work silently 
(after all, it has no choice). To disable it, go to the Character Select 
screen, click on the AddOns button at the bottom, and uncheck "Stop The 
Spam" in the list. 

Oh, if you're an addon author and you're examining my code to get around 
the filter (it really isn't hard), don't. Think of the users. If they 
installed my addon, they probably installed it for a reason. 


Release Notes:
--------------

2.00.11200 - Rewritten using Ace2 embedded libraries. AceHook-2.1 is 
	used to hook the chat frames, AceDebug-2.0 for debug messages, and 
	AceEvent-2.0 to stop the filter. Filter rules have been moved to 
	their own file. The rule for BugSack/BugGrabber has been rewritten 
	and re-enabled.

1.02.11200 - Ace2 and SCT filters removed. If you still see Ace2 addon 
	load spam update your addons to get the latest Ace2 embedded (or 
	standalone) libraries.

1.01.11200 - Updated interface version.

1.01.11100 - Removed the BugSack rule as it wasn't working reliably. 
    Added a rule to filter out DKPTable and the upcoming Ace2 version of 
	Scrolling Combat Text. Fixed a typo in the unload code. Minor change 
	to the filter code. Extended the amount of time the filter runs to 
	catch some really late loading addons. Updated interface version.

1.00.10900 - Filter routine rewritten to be more flexible to allow for
	future expansion. Allow/deny rules are now supported, rules can be
	reordered, expired, invalidated, disabled, and deleted. It's so
	complicated that even I can't understand it anymore! BugSack and
	Warmup are no longer filtered. Filter code now tries to safely unhook
	itself if possible. Impact on the global namespace has been minimized
	if not eliminated. Updated interface version. Also, the marketing
	department says bigger version numbers are better. I agree.

0.05.1700  - Improved the filter routine to capture more of the spam
	without triggering false positives. Added code to block AuctionIt and
	the played time messages that get triggered by experience calculating
	addons.

0.04.1700  - Fixed a bug that blocked more than just the spam after a user
	interface reload. Added special case code to block the Ace loading
	messages.

0.03.1700  - Another rewrite because I felt like it. No more icky timer.
	Updated interface version.

0.02.1600  - Rewrite and general cleanup of code. Changed timer value to 3
	seconds to catch ShardTracker. Updated interface version.

0.01.1500  - Initial release.


License:
--------

Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:

    * Redistributions of source code must retain the above copyright notice,
      this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright notice,
      this list of conditions and the following disclaimer in the documentation
      and/or other materials provided with the distribution.
    * Neither the name of the author nor the names of the contributors may be
      used to endorse or promote products derived from this software without
      specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
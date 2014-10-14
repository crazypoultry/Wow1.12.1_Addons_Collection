--[[ ---------------------------------------------------------------------------

StopTheSpam, by Malreth of Silver Hand

Copyright (c) 2006, Tyler Riti
All Rights Reserved

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

----------------------------------------------------------------------------- ]]

local ALLOW = 1
local DENY  = 0

assert(StopTheSpam)
assert(type(StopTheSpam) == "table")

StopTheSpam.ruleset = {}

--[[ ------------------------------------------------------------------------ ]]

-- Yes, the order matters.
StopTheSpam.ruleset.order = {
	-- Allowed addons.
	"warmup",
	"buggrabber",
	-- Global deny.
	"msgid",
	-- Denied addons.
	-- Late loading denied addons.
	"ace",
	"dkptable",
	-- Uncommon denies.
	"timeplayed",
	-- Default fallthrough.
	"default"
}

-- The order of the rules here does not matter.
StopTheSpam.ruleset.rules = {
	["warmup"] = {
		test = function (msg, id, frame) return WarmupFrame and frame == WarmupFrame end,
		invalidate = true,
		action = ALLOW
	},
	["buggrabber"] = {
		test = function (msg, id, frame) return BugGrabber and frame == BugGrabber end,
		invalidate = true,
		action = ALLOW
	},
	["msgid"] = {
		test = function (msg, id, frame) return not id or id > ChatTypeInfo.CHANNEL10.id end,
		action = DENY
	},
	["ace"] = {
		test = function (msg, id, frame) return AceEventFrame and frame == AceEventFrame end,
		invalidate = true,
		action = DENY
	},
	["dkptable"] = {
		test = function (msg, id, frame) return DKPT_Main_Frame and frame == DKPT_Main_Frame end,
		expire = 1,
		action = DENY
	},
	["timeplayed"] = {
		test = function (msg, id, frame) return string.find(string.lower(msg), string.lower(TIME_PLAYED_MSG)) end,
		action = DENY
	},
	["default"] = {
		action = ALLOW
	}
}

--[[ ------------------------------------------------------------------------ ]]
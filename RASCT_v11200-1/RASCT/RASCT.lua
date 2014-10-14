--[[
RASCT
Author:	BarryJ (Eugorym of Perenolde)
Version:	11200-1

Description :
Absorbs CT_RaidAssist messages and warnings (and now /rw messages) and display them with SCT 5.0
Requires Ace, SCT 5.0, and CT_RaidAssist.

/rasct messages -- Toggle on/off absorbing messages.
/rasct warnings -- Toggle on/off absorbing warnings.
/rasct raidwarnings -- Toggle on/off absorbing /rw messages.
/rasct raidwarnings -- Resizes the SCT Message frame to a larger size.

Changes :
11200-1:
Now requires SCT 5.0
Add /rasct resize option
11100-1:
Adding absorbing of /rw messages
11000-2:
Bug Fixes
11000-1:
Initial Release
]]

RASCT = {ACEUTIL_VERSION = 1.01}
RASCT.NAME				 = "RASCT"
RASCT.COMMANDS			 = {"/RASCT"}

RASCT.CMD_OPTIONS = {
	{
		option	= "messages",
		desc	= "Toggle on/off absorbing messages.",
		method	= "MessagesToggle",
	},
	{
		option	= "warnings",
		desc	= "Toggle on/off absorbing warnings.",
		method	= "WarningsToggle",
	},
	{
		option	= "raidwarnings",
		desc	= "Toggle on/off absorbing /rw messages.",
		method	= "RaidWarningsToggle",
	},
	{
		option	= "resize",
		desc	= "Resize the SCT Message Frame to a larger size.",
		method	= "ResizeToggle",
	}
}

local DEFAULT_OPTIONS = {
	msgs = TRUE,
	warns = TRUE,
	raidwarns = TRUE,
	resize = TRUE
}

RASCT = AceAddon:new({
	name		  = RASCT.NAME,
	version		  = "11200-1",
	releaseDate   = "8-23-2006",
	aceCompatible = "102",
	author		  = "BarryJ (Eugorym of Perenolde)",
	email		  = "wow@barryjacobsen.imap.cc",
	website		  = "none",
	category	  = "other",
	db			  = AceDatabase:new("RASCTDB"),
	defaults	  = DEFAULT_OPTIONS,
	cmd			  = AceChatCmd:new(RASCT.COMMANDS, RASCT.CMD_OPTIONS),
})

function RASCT:Initialize()
	if ( not SCT ) then
		return;
	end	
	
	self.GetOpt = function(var) local v=self.db:get(self.profilePath,var) return v end
	self.SetOpt = function(var,val) self.db:set(self.profilePath,var,val)	end
	self.TogOpt = function(var) return self.db:toggle(self.profilePath,var) end

	self.cmd:msg("RASCT Loaded");
	
	if (self.GetOpt("raidwarns") == nil) then self.TogOpt("raidwarns") end;
	if (self.GetOpt("resize") == nil) then self.TogOpt("resize") end;
	
	
	-- Increase the size of the frame to allow more messages.
	if (self.GetOpt("resize")) then
		SCT_MSG_FRAME:SetHeight(200);
	end
	
	self:Hook(SCT_MSG_FRAME, "SetHeight", "SCTMSGSetHeight")

	
	self:Hook(CT_RAMessageFrame, "AddMessage", "RAMessage")
	self:Hook(CT_RA_WarningFrame, "AddMessage", "RAWarn")
	self:Hook(RaidWarningFrame, "AddMessage", "RaidWarn")
end

function RASCT:SCTMSGSetHeight(x)
	--ChatFrame1:AddMessage("sct msg height set to "..x)
	if (self.GetOpt("resize")) then
		self:CallHook(SCT_MSG_FRAME, "SetHeight", 200);
	else
		self:CallHook(SCT_MSG_FRAME, "SetHeight", x);
	end
end

function RASCT:RAMessage(msg, red, green, blue, a, z)
	if (self.GetOpt("msgs")) then
		color = {r = red, g = green, b = blue};
		SCT:DisplayMessage(msg, color);
	else
		self:CallHook(CT_RAMessageFrame, "AddMessage", msg, red, green, blue, a, z);
	end
end

function RASCT:RAWarn(msg, red, green, blue, a, z)
	if (self.GetOpt("warns")) then
		color = {r = red, g = green, b = blue};
		SCT:DisplayMessage(msg, color);
	else
		self:CallHook(CT_RA_WarningFrame, "AddMessage", msg, red, green, blue, a, z);
	end
end

function RASCT:RaidWarn(msg, red, green, blue, a, z)
	if (self.GetOpt("raidwarns")) then
		color = {r = red, g = green, b = blue};
		SCT:DisplayMessage(msg, color);
	else
		self:CallHook(RaidWarningFrame, "AddMessage", msg, red, green, blue, a, z);
	end
end

function RASCT:MessagesToggle()
	self.cmd:status("Messages", self.TogOpt("msgs"), ACEG_MAP_ONOFF);
end

function RASCT:WarningsToggle()
	self.cmd:status("Warnings", self.TogOpt("warns"), ACEG_MAP_ONOFF);
end

function RASCT:RaidWarningsToggle()
	self.cmd:status("RaidWarnings", self.TogOpt("raidwarns"), ACEG_MAP_ONOFF);
end

function RASCT:ResizeToggle()
	self.cmd:status("Resize", self.TogOpt("resize"), ACEG_MAP_ONOFF);
	if (self.GetOpt("resize")) then
		SCT_MSG_FRAME:SetHeight(200);
	end
end

function RASCT:Report()
	self.cmd:report({
		{text="Messages", val=self.GetOpt("msgs"), map=ACEG_MAP_ONOFF},
		{text="RaidWarnings", val=self.GetOpt("raidwarns"), map=ACEG_MAP_ONOFF},
		{text="Warnings", val=self.GetOpt("warns"), map=ACEG_MAP_ONOFF},
		{text="Resize", val=self.GetOpt("resize"), map=ACEG_MAP_ONOFF}
	})
end

RASCT:RegisterForLoad()
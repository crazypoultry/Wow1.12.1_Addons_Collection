-- 
-- Critastic Addon
-- By Gearshaft
-- 

local version = '0.4'
local colorCode_Var = "|c0000ff00"
local CRITASTIC_REGULAR_CRIT = "regular attack"
-- CritasticOptions = {}

local function InitializeSetup()
	if(CritasticOptions == nil)					then CritasticOptions = {} end
	if(CritasticOptions.Status == nil)			then CritasticOptions.Status = 1 end
	if(CritasticOptions.CurrentCritType == nil)	then CritasticOptions.CurrentCritType = "D" end
	-- These are depreciated. gg forward thinking...
	-- Get the fuck rid of these stupid things soon...
	if(CritasticOptions.Emote == nil)			then CritasticOptions.Emote = "crits %t with a %s for %c!" end
	if(CritasticOptions.Threshold == nil)		then CritasticOptions.Threshold = 2500 end
	if(CritasticOptions.LastCrit == nil)		then CritasticOptions.LastCrit = 0 end
	if(CritasticOptions.LastTarget == nil)		then CritasticOptions.LastTarget = "" end
	if(CritasticOptions.LastSpell == nil)		then CritasticOptions.LastSpell = "" end
	if(CritasticOptions.HighestCrit == nil)		then CritasticOptions.HighestCrit = 0 end
	if(CritasticOptions.HighestTarget == nil)	then CritasticOptions.HighestTarget = "" end
	if(CritasticOptions.HighestSpell == nil)	then CritasticOptions.HighestSpell = "" end
	
	-- D = Damage; H = Healing
	-- The damage ones import all the crap from above from old people's settings and whatever.
	if(CritasticOptions.D == nil)				then CritasticOptions.D = {} end
	if(CritasticOptions.H == nil)				then CritasticOptions.H = {} end
	if(CritasticOptions.D.Emote == nil)			then CritasticOptions.D.Emote = CritasticOptions.Emote end
	if(CritasticOptions.H.Emote == nil)			then CritasticOptions.H.Emote = "crits %t with a %s for %c!" end
	if(CritasticOptions.D.Threshold == nil)		then CritasticOptions.D.Threshold = CritasticOptions.Threshold end
	if(CritasticOptions.H.Threshold == nil)		then CritasticOptions.H.Threshold = 2500 end
	if(CritasticOptions.D.Threshold == nil)		then CritasticOptions.D.ThresholdIsPercent = 0 end
	if(CritasticOptions.H.Threshold == nil)		then CritasticOptions.H.ThresholdIsPercent = 0 end
	if(CritasticOptions.D.LastCrit == nil)		then CritasticOptions.D.LastCrit = CritasticOptions.LastCrit end
	if(CritasticOptions.H.LastCrit == nil)		then CritasticOptions.H.LastCrit = 0 end
	if(CritasticOptions.D.LastTarget == nil)	then CritasticOptions.D.LastTarget = CritasticOptions.LastTarget end
	if(CritasticOptions.H.LastTarget == nil)	then CritasticOptions.H.LastTarget = "" end
	if(CritasticOptions.D.LastSpell == nil)		then CritasticOptions.D.LastSpell = CritasticOptions.LastSpell end
	if(CritasticOptions.H.LastSpell == nil)		then CritasticOptions.H.LastSpell = "" end
	if(CritasticOptions.D.HighestCrit == nil)	then CritasticOptions.D.HighestCrit = CritasticOptions.HighestCrit end
	if(CritasticOptions.H.HighestCrit == nil)	then CritasticOptions.H.HighestCrit = 0 end
	if(CritasticOptions.D.HighestTarget == nil)	then CritasticOptions.D.HighestTarget = CritasticOptions.HighestTarget end
	if(CritasticOptions.H.HighestTarget == nil)	then CritasticOptions.H.HighestTarget = "" end
	if(CritasticOptions.D.HighestSpell == nil)	then CritasticOptions.D.HighestSpell = CritasticOptions.HighestSpell end
	if(CritasticOptions.H.HighestSpell == nil)	then CritasticOptions.H.HighestSpell = "" end
	
	-- Added to convert old settings in version 0.1
	CritasticOptions.Threshold = tonumber(CritasticOptions.Threshold)
end

local function DisplayBool(setting)
	if ( setting == "1" or setting == 1 ) then
		return "On"
	elseif ( setting == "0" or setting == 0 ) then
		return "Off"
	end
	return setting
end

function Critastic_OnLoad()
	this:RegisterEvent("CHAT_MSG_COMBAT_SELF_HITS")
	this:RegisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE")
	this:RegisterEvent("CHAT_MSG_SPELL_SELF_BUFF")
	this:RegisterEvent("VARIABLES_LOADED")
	
 	InitializeSetup()

	SlashCmdList["Critastic"] = Critastic_SlashCommmandoCrit
	SLASH_Critastic1 = "/Critastic"
	SLASH_Critastic2 = "/crit"
		
	SlashCmdList["CritasticHeal"] = Critastic_SlashCommmandoCritHeal
	SLASH_CritasticHeal1 = "/critheal"
	
	DEFAULT_CHAT_FRAME:AddMessage("Critastic v. " .. version .. " loaded. /Critastic or /crit for help.")
	DEFAULT_CHAT_FRAME:AddMessage("Critastic set to " .. colorCode_Var .. CritasticOptions.Status .. "|r.")
end

function Critastic_OnEvent(event)
	if ( event == "VARIABLES_LOADED" ) then
		this:UnregisterEvent(event)
		InitializeSetup()
		return
	elseif (event == "CHAT_MSG_COMBAT_SELF_HITS") then
		-- Standard hit-crits
		local i,j,target,crit = string.find(arg1, "You crit (.+) for (%d+)\.")
		CritasticOptions.CurrentCritType = "D"
		Critastic_CritHappened( CRITASTIC_REGULAR_CRIT, target, crit )
	elseif (event == "CHAT_MSG_SPELL_SELF_DAMAGE") then
		-- Crits with spells
		local i,j,spell,target,crit = string.find(arg1, "Your (.+) crits (.+) for (%d+)\.")
		CritasticOptions.CurrentCritType = "D"
		Critastic_CritHappened( spell, target, crit )
	elseif (event == "CHAT_MSG_SPELL_SELF_BUFF") then
		-- Crit heals
		local i,j,spell,target,crit = string.find(arg1, "Your (.+) critically heals (.+) for (%d+)\.")
		CritasticOptions.CurrentCritType = "H"
		Critastic_CritHappened( spell, target, crit )
	end
	-- Nothing else left to do...
	return
end

function Critastic_CritHappened(spell,target,crit)
	local T = CritasticOptions.CurrentCritType
	if (crit) then
		crit = tonumber(crit)
		CritasticOptions[T].LastCrit = crit
		CritasticOptions[T].LastTarget = target
		CritasticOptions[T].LastSpell = spell
		if (
			(CritasticOptions[T].ThresholdIsPercent == 0 and crit >= CritasticOptions[T].Threshold) or
			(CritasticOptions[T].ThresholdIsPercent == 1 and crit >= ((CritasticOptions[T].Threshold / 100) * CritasticOptions[T].HighestCrit) )
			) then
			SendChatMessage(Critastic_FormulateMessage(CritasticOptions[T].Emote), "EMOTE")
		end
		if ( crit >= CritasticOptions[T].HighestCrit ) then
			CritasticOptions[T].HighestCrit = crit
			CritasticOptions[T].HighestTarget = target
			CritasticOptions[T].HighestSpell = spell
			DEFAULT_CHAT_FRAME:AddMessage("Critastic! " .. colorCode_Var .. CritasticOptions[T].HighestCrit .. "|r a new high crit!")
		end
		return 1
	end
	-- DEFAULT_CHAT_FRAME:AddMessage("Your damn right you just critted!")
	return
end

function Critastic_FormulateMessage(message)
	return string.gsub(message, "%%(%w+)", Critastic_TokenReplacer)
end

function Critastic_TokenReplacer(token)
	local t = string.lower(token)
	-- local t = token;
	local T = CritasticOptions.CurrentCritType
	if( t == "c" ) then
		return CritasticOptions[T].LastCrit
	elseif (t == "t" ) then
		return CritasticOptions[T].LastTarget
	elseif (t == "s" ) then
		return CritasticOptions[T].LastSpell
	elseif( t == "hc" ) then
		return CritasticOptions[T].HighestCrit
	elseif( t == "ht" ) then
		return CritasticOptions[T].HighestTarget
	elseif( t == "hs" ) then
		return CritasticOptions[T].HighestSpell
	elseif (t == "p" ) then
		return UnitName("player")
	end
	return token
end
-- /crit em just owned %t with %s, critting for %c. Bam!

function Critastic_SlashCommmandoCrit(msg)
	Critastic_SlashCommmando("D",msg)
end

function Critastic_SlashCommmandoCritHeal(msg)
	Critastic_SlashCommmando("H",msg)
end

function Critastic_SlashCommmando(T, msg)
	local slashcmd = "/crit"
	local title = "Damage Crit"
	if ( T == "H" )	then slashcmd = "/critheal"; title = "Healing Crit" end
	
	-- InitializeSetup()
	-- DEFAULT_CHAT_FRAME:AddMessage("Critastic set to " .. CritasticOptions.Status .. " and is now ready.")
	-- if ( msg ~= "" ) then msg = string.lower(msg) end
	local f,u, cmd, param = string.find(msg, "^([^ ]+) (.+)$")
	if ( not cmd ) then
		cmd = msg
		param = ""
	end
	cmd = string.lower(cmd)
	DEFAULT_CHAT_FRAME:AddMessage("Critastic |c00ffff00" .. title .. "|r mode.")
	if(cmd == "" or cmd == "status") then
		DEFAULT_CHAT_FRAME:AddMessage("Critastic status: " .. colorCode_Var .. DisplayBool(CritasticOptions.Status) .. "|r (change with " .. slashcmd .. " on | off) This affects both damage and healing.")
		if ( CritasticOptions[T].ThresholdIsPercent == 1 ) then
			DEFAULT_CHAT_FRAME:AddMessage("Current Emote Threshold: " .. colorCode_Var .. CritasticOptions[T].Threshold .. "% of " .. CritasticOptions[T].HighestCrit .. "|r (change with " .. slashcmd .. " # OR " .. slashcmd .. " #%)")
		else
			DEFAULT_CHAT_FRAME:AddMessage("Current Emote Threshold: " .. colorCode_Var .. CritasticOptions[T].Threshold .. "|r (change with " .. slashcmd .. " # OR " .. slashcmd .. " #%)")
		end
		DEFAULT_CHAT_FRAME:AddMessage(colorCode_Var .. slashcmd .. " em|r  -  See emote text options")
		DEFAULT_CHAT_FRAME:AddMessage(colorCode_Var .. slashcmd .. " highest|r  -  Shows your highest " .. title .. " info")
		DEFAULT_CHAT_FRAME:AddMessage(colorCode_Var .. slashcmd .. " resetall|r  -  Reset all settings")
		DEFAULT_CHAT_FRAME:AddMessage(colorCode_Var .. slashcmd .. " resethighest|r  -  Reset your highest " .. title .. "")
	elseif(cmd == "on") then
		CritasticOptions.Status = 1
		InitializeSetup()
		DEFAULT_CHAT_FRAME:AddMessage("Critastic: " .. colorCode_Var .. DisplayBool(CritasticOptions.Status) .. "|r")
	elseif(cmd == "off") then
		CritasticOptions.Status = 0
		this:UnregisterAllEvents()
		DEFAULT_CHAT_FRAME:AddMessage("Critastic: " .. colorCode_Var .. DisplayBool(CritasticOptions.Status) .. "|r")
	elseif(cmd == "em") then
		if (param ~= "") then
			CritasticOptions[T].Emote = param
		end
		DEFAULT_CHAT_FRAME:AddMessage("Critastic emote set to: \"" .. colorCode_Var .. CritasticOptions[T].Emote .. "|r\"")
		DEFAULT_CHAT_FRAME:AddMessage("Emote example: |c00ff7733" .. UnitName("player") .. " " .. Critastic_FormulateMessage(CritasticOptions[T].Emote) .. "|r")
		DEFAULT_CHAT_FRAME:AddMessage(colorCode_Var .. "%c|r = last crit; " .. colorCode_Var .. "%t|r = last crit target; " .. colorCode_Var .. "%s|r = last crit spell; " .. colorCode_Var .. "%hc|r = highest crit; " .. colorCode_Var .. "%ht|r = highest crit target; " .. colorCode_Var .. "%hs|r = highest crit spell; " .. colorCode_Var .. "%p|r = your name; ")
	elseif(string.find(cmd, "^%d+$")) then
		CritasticOptions[T].Threshold = tonumber(cmd)
		CritasticOptions[T].ThresholdIsPercent = 0
		DEFAULT_CHAT_FRAME:AddMessage("Critastic high " .. title .. " emote threshold: " .. colorCode_Var .. CritasticOptions[T].Threshold .. "|r You will not emote unless the crit is equal to or grater than this.")
	elseif(string.find(cmd, "^%d+%%$")) then
		local i,j,numbercleaner = string.find(cmd, "(%d+)")
		CritasticOptions[T].Threshold = tonumber(numbercleaner)
		-- message(cmd)
		CritasticOptions[T].ThresholdIsPercent = 1
		DEFAULT_CHAT_FRAME:AddMessage("Critastic high " .. title .. " emote threshold: " .. colorCode_Var .. CritasticOptions[T].Threshold .. "% of " .. CritasticOptions[T].HighestCrit .. "|r. You will not emote unless the crit is equal to or grater than " .. ( (CritasticOptions[T].Threshold / 100) * CritasticOptions[T].HighestCrit ) .. ".")
	elseif(cmd == "highest") then
		if (CritasticOptions[T].HighestCrit > 0) then
			DEFAULT_CHAT_FRAME:AddMessage("Your highest " .. title .. " was on " .. CritasticOptions[T].HighestTarget .. " with " .. CritasticOptions[T].HighestSpell .. " for " .. CritasticOptions[T].HighestCrit .. ".")
		else
			DEFAULT_CHAT_FRAME:AddMessage("There are no logged " .. title .. "s. Sorry.")
		end
	elseif(cmd == "resetall") then
		CritasticOptions = {}
		InitializeSetup()
		DEFAULT_CHAT_FRAME:AddMessage("Critastic: All your settings have been reset.")
	elseif(cmd == "resethighest") then
		CritasticOptions[T].HighestCrit = 0
		CritasticOptions[T].HighestTarget = ""
		DEFAULT_CHAT_FRAME:AddMessage("Critastic: Your highest " .. title .. " has been reset.")
	elseif(cmd == "reset") then
		DEFAULT_CHAT_FRAME:AddMessage("These are your reset options:")
		DEFAULT_CHAT_FRAME:AddMessage(slashcmd .. " resetall  -  Reset all the settings.")
		DEFAULT_CHAT_FRAME:AddMessage(slashcmd .. " resethighest  -  Reset just your highest logged " .. title .. ".")
	else 
		DEFAULT_CHAT_FRAME:AddMessage("Critastic: unknown command: " .. colorCode_Var .. cmd .. "|r")
	end
end

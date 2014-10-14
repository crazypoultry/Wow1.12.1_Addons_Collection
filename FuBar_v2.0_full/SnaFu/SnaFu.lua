--[[SnaFu version 1.83 $Revision: 12281 $]]--
local bclass = AceLibrary("Babble-Class-2.0")
local crayon = AceLibrary("Crayon-2.0")
local dewdrop = AceLibrary("Dewdrop-2.0")
local L = AceLibrary("AceLocale-2.0"):new("SnaFu")
local metro = AceLibrary("Metrognome-2.0")
local rosterlib = AceLibrary("RosterLib-2.0")
local tablet = AceLibrary("Tablet-2.0")

SnaFu = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceConsole-2.0", "AceDB-2.0", "FuBarPlugin-2.0")

SnaFu:RegisterDB("SnaFuDB")
SnaFu:RegisterDefaults('profile',{
        InfoTrack = "ns",
        OST = -1,
        OSO = "no one",
        FelhunterSpell = "Devour Magic",
        ImpAttack = true,
        Audio = {
            Splash = true,
            StoneGain = "PVPTHROUGHQUEUE",
            StoneLoss = "PVPENTERQUEUE",
        },
        Chat = true,
    }
)
--Some FuBar settings
SnaFu.commPrefix = "SnaFu"
SnaFu.hasIcon = "Interface\\Icons\\Spell_Shadow_SoulGem"
SnaFu.independentProfile = true
SnaFu.overrideMenu = true
SnaFu.tooltipHiddenWhenEmpty = true

BINDING_HEADER_SNAFU = "SnaFu"
BINDING_NAME_SNAFUPETFUNC = L["Demon Pet Tricks"]

function SnaFu:OnInitialize()
    local commands = {
        type = 'group',
        args = {
            TogFHSpell = {
                type = 'execute',
                name = L["Toggle FH spell"],
                desc = L["Switch from Devour Magic to Spell Lock"],
                func = "FelhunterToggleSpell"
            },
            TogImpSpell = {
                type = 'toggle',
                name = L["Toggle Imp"],
                desc = L["Toggle whether the keybinding sets the imp to attack your current target"],
                get = function()
                    return self.db.profile.ImpAttack
                end,
                set = function()
                    self.db.profile.ImpAttack = not self.db.profile.ImpAttack
                end,
                map = {[true] = L["Attack"], [false] = L["Don't Attack"]},
            },
            ToggleNoise = {
                type = 'toggle',
                name = L["Toggle Audio"],
                desc = L["Click to toggle audio notifications"],
                get = function()
                    return self.db.profile.Audio.Splash
                end,
                set = function()
                    self.db.profile.Audio.Splash = not self.db.profile.Audio.Splash
                end,
                map = {[true] = L["Yes"], [false] = L["no"]},
                --guiNameIsMap = true,
            },
            Chat = {
                type = 'text',
                name = L["Chat!"],
                desc = L["Send a chat message through SnaFu"],
                get = false,
                usage = L["<msg>"],
                set = function(v)
                    self:DataChat(v)
                end,
            },
            ToggleChat = {
                type = 'toggle',
                name = L["Toggle Chat"],
                desc = L["Turn the chat channel on or off"],
                get = function()
                    return self.db.profile.Chat
                end,
                set = function()
                    self.db.profile.Chat = not self.db.profile.Chat
                end,
                map = {[true] = L["Yes"], [false] = L["no"]},
            },
        }
    }
    self.SoulstoneID = {
        [5232] = 1,
        [16892] = 1,
        [16893] = 1,
        [16895] = 1,
        [16896] = 1,
    }
	self.ssBuffIcon = "Spell_Shadow_SoulGem"
	self.StonedPeople = {}
    self.TrackedSS = {}
    self.toggles = {
        TrackedSS = false,
        IAmStoned = false
    }
    self.DataSent = {
        SSCoolDown = -1,
        TimeLeft = 0,
    }
	self.PeopleList = {}
    self.fubarText = "initial"
    self.SeductionCastAt = -1
	self.defaultPosition = 'RIGHT'
	metro:Register(self.name,self.Update,1.0,self)
    metro:Register("SnaFu Spam",self.DataSpam,15.0,self)
    self:RegisterChatCommand({"/snafu"}, commands)
    self.OnMenuRequest = commands
    self:RegisterChatCommand({"/snc"}, {
            type = 'text',
            name = L["Chat!"],
            desc = L["Send a chat message through SnaFu"],
            get = false,
            usage = L["<msg>"],
            set = function(v)
                self:DataChat(v)
            end,
        }
    )
end

function SnaFu:OnEnable()
	metro:Start(self.name)
    metro:Start("SnaFu Spam")
	self:RegisterEvent("RosterLib_RosterChanged")
    self:RegisterEvent("CHAT_MSG_ADDON")
end

function SnaFu:OnDisable()
    metro:Stop(self.name)
    metro:Stop("SnaFu Spam")
end

function SnaFu:OnClick()
    self:ToggleInfo()
end

function SnaFu:OnTextUpdate()
    self:SetText(self.fubarText)
end

function SnaFu:OnTooltipUpdate()
	local category = tablet:AddCategory(
		--"text", "Think of a good title to put here",
		"columns", 2,
		'child_textR', 1,
		'child_textG', 1,
		'child_textB', 0,
		'child_text2R', 1,
		'child_text2G', 1,
		'child_text2B', 1
	)
    local _, ec = UnitClass("player")
	if ec == "WARLOCK" then
		category:AddLine('text', crayon:Purple(L["Got Stones?"]), 'text2', self.ssFlag)
        category:AddLine('text', crayon:Purple(L["Felhunter"]), 'text2', self.db.profile.FelhunterSpell)
	end
    if self.db.profile.OST < 7200 then
        category:AddLine('text', L["Stoned?"], 'text2', L["ETE"])
        for name in pairs(self.StonedPeople) do
            local cr, cg, cb = bclass:GetColor(self.PeopleList[name].class)
            category:AddLine('text', name, 'textR', cr, 'textG', cg, 'textB', cb, 'text2', self.StonedPeople[name].PrettyTimeLeft)
        end
    end
    if self.toggles.TrackedSS then
        category:AddLine('text', L["Cooldown"], 'text2', L["ETE"])
        for name in pairs(self.TrackedSS) do
            if self.TrackedSS[name].TimeLeft == 0 then
                category:AddLine('text', crayon:Green(name), 'text2', L["Ready"])
            elseif self.TrackedSS[name].TimeLeft < 90 then
                category:AddLine('text', crayon:White(name), 'text2', self.TrackedSS[name].PrettyTimeLeft)
            else
                category:AddLine('text', crayon:Purple(name), 'text2', self.TrackedSS[name].PrettyTimeLeft)
            end
        end
    end
    if FuBar then
        tablet:SetHint(L["Click to toggle display"])
    end
end

function SnaFu:RosterLib_RosterChanged(tbl)
    for name in pairs(tbl) do
        if (tbl[name].unitid and not tbl[name].oldunitid and tbl[name].class ~= "PET") then
            self.PeopleList[name] = rosterlib.roster[name]
        end
        if not tbl[name].unitid and tbl[name].oldunitid and self.PeopleList[name] then
            self.PeopleList[name] = nil
        end
    end
end

function SnaFu:OnDataUpdate()
    --[[Metrognome calls this every second (read this from the OnInitialize statement)
        This is where I update all the persistant variables like timers and stuff.
    ]]--
    local _, ec = UnitClass("player")
    if ec == "WARLOCK" then
        self.toggles.ssFlag = self:LookInBags()
        if self.toggles.ssFlag then
            self.ssFlag = L["Yes"]
        else
            self.ssFlag = L["no"]
        end
    end
    self.StonesInPlace = self:CheckForStone()
	if self.StonesInPlace > 0 then
		self:CypherStonesTimeLeft()
	end
    self.fubarText = self:ShowText(self.db.profile.InfoTrack)
    self.db.profile.OSO, self.db.profile.OST = self:CypherStonesTimeOldest()
    self.DataSent.TimeLeft = self:CypherStonesTimeSelf(self.toggles.IAmStoned)
    if not next(self.TrackedSS) then
        self.toggles.TrackedSS = false
    else
        self.toggles.TrackedSS = true
    end
end
-- after here are the nonAPI provided modules
function SnaFu:CheckForStone()
    --[[parses everyone in the raid and checks to see if anyone has a soulstone.
        return number of stones in place
        Also provides notifications.  (Hrm.  maybe I should strip that into it's own function, also.)
    ]]--
	local nofstones
	local templist
	templist = {}
	nofstones = 0
	for name in pairs(self.PeopleList) do
        if self:GotStone(rosterlib:GetUnitIDFromName(name)) then
            if self.StonedPeople[name] == nil then
                templist[name] = {}
                templist[name].TimeCast = GetTime()
                self:Splash(1, name, self.db.profile.Audio.Splash)
            else
                templist[name] = self.StonedPeople[name]
            end
            if (name == UnitName("player") and not self.toggles.IAmStoned) then
                self.toggles.IAmStoned = true
            end
            nofstones = nofstones + 1
        end
	end
	for name in pairs(self.StonedPeople) do
		if templist[name] == nil then
            self:Splash(2, name, true)
            if (name == UnitName("player") and self.toggles.IAmStoned) then
                self.toggles.IAmStoned = false
            end
		end
	end
    self.StonedPeople = templist
	return nofstones
end

function SnaFu:CypherStonesTimeOldest()
    --[[Parses the list of people with a soulstone and (based on CypherStonesTimeLeft()'s
        guess, decides who's stone will expire first
        return name of person with oldest stone and the time left (to save a lookup later)
    ]]--
    local sn = "no one"
    local st = 7201  -- I don't know if any buffs longer than 2 hours, so this should be good.
    for name in pairs(self.StonedPeople) do
        self.StonedPeople[name].TimeLeft = self.StonedPeople[name].TimeLeft or {}
        if self.StonedPeople[name].TimeLeft < st then
            sn = name
            st = self.StonedPeople[name].TimeLeft
        end
    end
    return sn, st   
end

function SnaFu:CypherStonesTimeLeft()
    --[[Parses the list of people with a soulstone and makes an educated guess on how much time is left on
        the stones.
        Note that this data will be incorrect in the following cases:
            --  person joins group with a soulstone in place
            --  Player logs in with a soulstone in place
            --  Player joins a grouping where a stone is already in place
            --  Player reloads console
        In these cases, SnaFu will assume that the soulstones are new, and set their timers to 30 minutes.
        I do not currently have a work around short of setting up addon communication, which I don't wish to do
        at this time.
    ]]--            
	for name in pairs(self.StonedPeople) do
		local dur
		self.StonedPeople[name].TimeLeft = {}
		self.StonedPeople[name].PrettyTimeLeft = {}
		dur = math.floor(1800 - GetTime() + self.StonedPeople[name].TimeCast)
		self.StonedPeople[name].TimeLeft = dur
		self.StonedPeople[name].PrettyTimeLeft = self:PrettyTime(dur)
	end
end

function SnaFu:CypherStonesTimeSelf(boolean)
    --[[James Brown is my bitch!  Do you know who I am?!
        Assumed called when UnitID("player") has a stone, as determined by SnaFu.toggle.IAmStoned = true
        return time left on the player's soulstone.
        Note, the reason this is called as a separate function, is to make it easier to send data later.
    ]]--
    local timeleft = -1
    if boolean then
        local i = 0
        while(GetPlayerBuffTexture(i)) do
            if (string.find(GetPlayerBuffTexture(i), self.ssBuffIcon)) then
                timeleft = GetPlayerBuffTimeLeft(i)
            end
            i = i + 1
        end
        if timeleft > 0 then
            self.StonedPeople[UnitName("player")].TimeCast = GetTime() + timeleft - 1800
        end
        return timeleft
    end
end

function SnaFu:GotStone(guytocheck)
    --[[Checks the person with UnitID of guytocheck for a soulstone
        return boolean
    ]]--
    local i = 1
    while (UnitBuff(guytocheck, i)) do
    if (string.find((UnitBuff(guytocheck, i)), self.ssBuffIcon)) then
      return true
    end
    i = i + 1
    end
    return false
end

function SnaFu:LookInBags()
    --[[Parses the player's inventory for a soulstone.
        return boolean
        This code was, er... "adapted" from ShardAce.
    ]]--
	for bag = 4, 0, -1 do
		local size = GetContainerNumSlots(bag)
		if (size > 0) then
			for slot=1, size, 1 do
				local _,_,itemID = string.find(GetContainerItemLink(bag,slot) or "", "item:(%d+):%d+:%d+:%d+")
				itemID = tonumber(itemID)
				if (itemID) then
					if self.SoulstoneID[itemID] then
                        local a, _, _ = GetContainerItemCooldown(bag,slot)
                        self.DataSent.SSCoolDown = 1800 + math.floor(a - GetTime())
                            if self.DataSent.SSCoolDown < 0 then
                                self.DataSent.SSCoolDown = 0
                            end
						return true
					end
				end
			end
		end
	end
    self.DataSent.SSCoolDown = -1
	return false
end

function SnaFu:PrettyTime(time)
    --[[Takes as it's argument a number, assumed to be in seconds, and formats it reasonably.
        return "mm:ss", a string of minutes and seconds
        probably not going to adapt this for larger units of time.
    ]]--
	local minutes
	local seconds
	local workingtime = time
	local pretty
	minutes = math.floor(workingtime/60)
	seconds = workingtime - ( minutes * 60 )
	if seconds < 10 then
		seconds = "0" .. seconds
	end
	pretty = minutes .. ":" .. seconds
	return pretty
end	

function SnaFu:Splash(type, name, sound)
    --[[Provides mechanism to provide notifications to the user.
        type is an integer
            1 - stone gained
            2 - stone lost
        name is a string with the name of the person to whom the message refers
        sound is an optional boolean.  If false or nil, no sound is made.  Sounds are tied to event type.
    ]]--
    if type == 1 then
        self:Print(crayon:Gold(name) .. L[" is SnaFu'd!"])
        if sound then
            PlaySound(self.db.profile.Audio.StoneGain)
        end
    elseif type == 2 then
		self:Print(crayon:Red(name) .. L[" has no soul!"])
		UIErrorsFrame:AddMessage(crayon:Red(name) .. L[" has no soul!"])
        if sound then
            PlaySound(self.db.profile.Audio.StoneLoss)
        end
    else
        self:Print(" tried to call an illegal message type.  Please tell Theondry.")
    end 
end

function SnaFu:ToggleInfo()
    --[[Toggles the type of information the addon should track for display.
        Does not affect what calculations are made or variables are updated.
        Current values are:
        --  "ns" : number of stones
        --  "timers" : time left on shortest stone.
    ]]--
	if self.db.profile.InfoTrack == "ns" then
        self.db.profile.InfoTrack = "timers"
    else
        self.db.profile.InfoTrack = "ns"
    end
end

function SnaFu:ShowText(kind)
    --[[Called by OnDataUpdate() to set the output text for the FuBar plug-in
        Output is contingent on kind
            "ns" is number of stones
            "timers" is time left on oldest stone.
    ]]--
    local outtext
    if kind == "ns" then
        if self.StonesInPlace ~= 0 then
            outtext = crayon:Green(self.StonesInPlace)
        else
            outtext = crayon:Purple(L["no"])
        end
    elseif kind == "timers" then
        if self.db.profile.OSO == "no one" then
            outtext = crayon:White("--")
        else
            if self.db.profile.OST > 90 then
                outtext = crayon:Green(self:PrettyTime(self.db.profile.OST))
            else
                outtext = crayon:Red(self.db.profile.OST .. "s")
            end
        end
    end
    return outtext
end

--[[pets]]--
function SnaFu:PetKeyBinding()
	--[[Voidwalker is the one that's "done".
		Felhunter *should* work, but I haven't tested it.  Need to learn stuff about targeting so I don't switch targets.
		Succubus just casts seduction on current target.  Need to learn how to store targets and stuff.
		Not sure that there's anything for the imp to do...
	]]--
    local _, ec = UnitClass("player")
    local pet = UnitCreatureFamily("pet")
    if ec ~= "WARLOCK" then return end
	if pet ~= nil then
		if pet == L["Succubus"] then
			self:SuccubusFunction()
		elseif pet == L["Felhunter"] then
			self:FelhunterFunction(self.db.profile.FelhunterSpell)
		elseif pet == L["Voidwalker"] then
			self:VoidWalkerFunction()
		elseif pet == L["Imp"] then
			self:ImpFunction()
        elseif pet == L["Fel Guard"] then
            self:FelGuardFunction()
		end
	end
end

function SnaFu:SuccubusFunction()
	--[[The only function I'm planning on adding here is to store your Succubus'
		seduction target and then allow you to reseduce that target without changing
		your own target.
    ]]--
    if (GetTime() - self.SeductionCastAt) > 45 then
        self.SeductionCastAt = 0
    end
	if self.SeductionCastAt ~= 0 then
		ClearTarget()
		CastSpellByName(L["Seduction"])
		TargetLastTarget()
	else
        if UnitCreatureType("target") == L["Humanoid"] then
            PetAttack()
            CastSpellByName(L["Seduction"])
            self.SeductionCastAt = GetTime()
        end
	end
end

function SnaFu:FelhunterFunction(spl)
	--[[The only function I'm planning on adding here is to Devour Magic on your target
		if you have one.  If you don't, then on yourself, and then on the felhunter.]]--
	CastSpellByName(spl)
    if spl == L["Devour Magic"] then
        CastSpellByName(spl,1)
    end
end

function SnaFu:FelhunterToggleSpell()
    if self.db.profile.FelhunterSpell == L["Devour Magic"] then
        self.db.profile.FelhunterSpell = L["Spell Lock"]
    else
        self.db.profile.FelhunterSpell = L["Devour Magic"]
    end
end

function SnaFu:VoidWalkerFunction()
	--[[The only Function I'm planning on adding here is to sacrifice the VW if he's at low health
        I don't think I want any "extraordinary" logic here.  Just a "is one of us about to die" thing.
    ]]--
	if (UnitHealth("pet")/UnitHealthMax("pet") < 0.11) then
		CastSpellByName(L["Sacrifice"])
	end
    if (UnitHealth("player")/UnitHealthMax("player") < 0.11) then
        CastSpellByName(L["Sacrifice"])
    end
end

function SnaFu:ImpFunction()
	--[[I decided that setting the imp to attack is worthwhile.  I'm leaving in the sound, though.  :)
        TODO
            Figure out how to determine if the Imp is attacking something.
                My current plan is to grab the Imp's target and, if it exists, assume it's
                attacking something.  I can't figure out how to grab the target without
                switching the player's target to the Imp, which I'd rather not do.
    ]]--
	PlaySound("PVPTHROUGHQUEUE")
    if self.db.profile.ImpAttack then
        if UnitExists("pettarget") then
            PetStopAttack()
        elseif UnitCanAttack("pet","target") then
            PetAttack()
        end
    end
end

function SnaFu:FelGuardFunction()
    --[[Yes, this addon lets you summon and control the Fel Guard, even if BC hasn't come out, yet.
        It also hacks Blizzard's server to pay your bill for you every month.
    ]]--
    CastSpellByName(L["Intercept"])
end

--[[comms]]--

function SnaFu:BaseChange(bsid,base,source)
    --[[bsid is decimal number as a string
        base is a numeric base to convert to (defaults to hex if not listed)
        source is the numeric base bsid is sent in (defaults to base 10)
        returns the number in base as a string and the string reversed
    ]]--
    local boolean = true
    local xeh = ""
    local hex = ""
    local digits = {
        "0","1","2","3","4","5","6","7","8","9",
        "A","B","C","D","E","F","G","H",
        "I","J","K","L","M","N","O","P",
        "Q","R","S","T","U","V","W","X","Y","Z"
    }
    testdigits = {
        [0]="0",[1]="1",[2]="2",[3]="3",[4]="4",[5]="5",[6]="6",[7]="7",[8]="8",[9]="9",
        [10]="A",[11]="B",[12]="C",[13]="D",[14]="E",[15]="F",[16]="G",[17]="H",
        [18]="I",[19]="J",[20]="K",[21]="L",[22]="M",[23]="N",[24]="O",[25]="P",
        [26]="Q",[27]="R",[28]="S",[29]="T",[30]="U",[31]="V",[32]="W",[33]="X",
        [34]="Y",[35]="Z"
    }
    if not base then
        base = 16
    end
    if not source then
        source = 10
    elseif source ~= 10 then
        self:BaseChange(bsid, 10, source)
    end
    while boolean do
        local r,a
        a = math.floor(tonumber(bsid)/base)
        r = tonumber(bsid) - (a * base)
        xeh = xeh .. digits[(r+1)]
        bsid = a
        if bsid < 1 then
            boolean = false
        end
    end
    for loop = string.len(xeh), 1, -1 do
        hex = hex .. string.sub(xeh, loop, loop)
    end
    return hex, xeh
end

function SnaFu:DataChat(message)
    SendAddonMessage("SnaFuChat",message,"RAID")
    --self:Print("You're saying, '" .. message)
end

function SnaFu:DataDecode(codedmessage)
    --[[name is who is stoned or who has a stone
        coded message is an integer encoded into a string by the sender's :DataEncode().
        By sending the data back as a table, this function should be fairly forward compatible.
        Returns
            errorcode (0 is good, 1 is bad message, 999 is who knows?
            tag - binary string so I know what's what for use
            pull - table indexed by integers with the various bits of info:
                index 1 is time left until the soulstone cooldown is over.
                index 2 is time left on SS buff.
    ]]--
    local tag
    local pull = {}
    local i = string.len(codedmessage)/4
    local junk
    if (math.ceil(i) == i and i > 1) then
        tag = string.sub(codedmessage, 1, 4)
        _, binarytag = self:BaseChange(tag,2,10)  -- to maintain forward compatibility, I must use the reversed tag.
        for loop = 1, (i-1) do
            pull[loop] = tonumber(string.sub(codedmessage, (1+loop*4), (4+loop*4)))
        end
        errorcode = 0
    elseif (math.ceil(i) == 1) then
        errorcode = 1
    else
        errorcode = 999
    end
    return errorcode, binarytag, pull
end

function SnaFu:DataEncode()
    --[[Since each number is guarenteed to be less than 4 digits, I will use a
            simple Base-10 encoding with all numbers being positive (it's assumed that I'll
            know how to decode the info on the other side).  nnnnxxxxyyy, where xxxx is push[1],
            zzzz is push[2], etc., and nnn is a binary number in Base-10 which conveys the
            number of pieces being sent.  (No one will need more than 640k memory!)
        Future versions of SnaFu should only need to tack on extra bits to the encoded string.
            As it stands, by using 4 digit encoding, I'm limited to sending only 13 pieces of data
            (Sum[2^i,{i,0,13}]=8191), unless I move to sending things as Hex strings, which gives
            me 16 (Sum[2^i,{i,0,16}]=FFFF) pieces of info, which still fits safely within the limit
            of a single message (comm prefix + tag + 16 * message < 100).
        Perhaps in the far distant future, I'll screw version compatibility (again) and move to
            sending data in blocks of 7 characters, which gives me 28 bits of info to send.
            The tag would be encoded in Hex for this, and 28 would be the most info I could send,
            at one time.
            No, I'm not going to do it now.  (mostly because I don't want to code a hex->bin thingie.)
            Please note that 7 is prime, and 28 is perfect.  Again, I am made happy.
        index 1 is time left until the soulstone cooldown is over.
        index 2 is time left on SS buff.
        index 3 is the version number, which I will deliberately ignore on the other side
        Note that a side result of sending the version number means that I will always be sending data.
        Returns:
            a boolean deciding if data should be sent
            the encoded data string
    ]]--
    local codedmessage = ""
    local push = {}
    local tag = 0
    if self.toggles.ssFlag then
        push[1] = tostring(self.DataSent.SSCoolDown)
        while string.len(push[1]) < 4 do
            push[1] = "0" .. push[1]
        end
        tag = tag + 1
    else
        push[1] = "0000"
    end
    if self.StonedPeople[UnitName("player")] then
        push[2] = tostring(math.floor(self.StonedPeople[UnitName("player")].TimeCast + 1800 - GetTime()))
        while string.len(push[2]) < 4 do
            push[2] = "0" .. push[2]
        end
        tag = tag + 2
    else
        push[2] = "0000"
    end
    push[3] = self.version
    while string.len(push[3]) < 4 do
        push[3] = "0" .. push[3]
    end
    tag = tag + 4  --Note that 4 is the next binary digit place after 2.  the next one would use 8, 16, etc.
    if tag > 0 then
        tag = tostring(tag)
        while string.len(tag) < 4 do
            tag = "0" .. tag
        end
        for loop = 1,2 do
            tag = tag .. push[loop]
        end
        codedmessage = tag
        return true, codedmessage
    else
        return false
    end
end

function SnaFu:DataReceived(name, codedmessage)
    --[[name is the person who sent the data, codedmessage is an integer string with the data to decode.
        This function interprets the result of the decodedmessage and processes it.
        I wonder if I should put the processing into it's own function also.
        data structure:
            data[1] = Cooldown left (in seconds) on name's soulstone.
            data[2] = Time remaining on name's soulstone.
    ]]--
    local errorcode, tag, data = self:DataDecode(codedmessage)
    if errorcode == 0 then
        if string.sub(tag, 1, 1) == "1" then
            self.TrackedSS[name] = self.TrackedSS[name] or {}
            self.TrackedSS[name].TimeLeft = data[1]
            self.TrackedSS[name].PrettyTimeLeft = self:PrettyTime(data[1])
        elseif string.sub(tag, 1, 1) == "0" then
            self.TrackedSS[name] = nil
        end
        if string.sub(tag, 2, 2) == "1" then
            self.StonedPeople[name] = self.StonedPeople[name] or {}
            self.StonedPeople[name].TimeCast = self.StonedPeople[name].TimeCast or {}
            self.StonedPeople[name].TimeCast = GetTime() + data[2] - 1800
        end
    elseif errorcode == 1 then
        self:Print(name .. L["BadDataSent"])
    else
        self:Print(L["Received odd information from "] .. name)
        self:Print(L["Please make sure you are both running the latest version of SnaFu."])
    end
end

function SnaFu:DataSpam()
    --[[Called every so often (defined during :OnInitialize, above)
        If the player is stoned, it will send data.
        If the player has a soulstone conjured, it will do a send data.
            To differentiate between the two pieces of information, I will
            encode the two numbers in some intelligent fashion.
            (shut up...  I don't care if a table is better!  I'm a mathematician,
                and I must be difficult about this!)
    ]]--
    local boolean
    local codedmessage
    boolean, codedmessage = self:DataEncode()
    if boolean then
        SendAddonMessage(self.commPrefix, codedmessage, "RAID")
    end
end

function SnaFu:CHAT_MSG_ADDON(prefix, message, d_, sender)
    if prefix == self.commPrefix then
        if sender ~= UnitName("player") then
            self:DataReceived(sender, message)
        end
    elseif prefix == "SnaFuChat" then
        if self.db.profile.Chat == true then
            self:Print(crayon:Silver(sender) .. crayon:Silver(L[" says, `"])  .. message .. crayon:Silver(L["'"]))
        end
    else
        return
    end
end
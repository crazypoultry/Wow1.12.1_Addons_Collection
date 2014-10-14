SpellRankCheck = AceLibrary("AceAddon-2.0"):new("AceConsole-2.0", "AceDB-2.0")

local options = { 
    type='group',
    args = {
        check = {
			type = "execute",
            name = "check",
            desc = "Check your spellbook versus your action bar.",
			func = "runcheck"
        },
		blacklist = {
			type = "execute",
			name = "blacklist",
			desc = "Check your spelbook versus your action bar and puts the current differences in a blacklist, so they don't show up the next time.",
			func = "bllist"
		},
		reset = {
			type = "execute",
			name = "reset",
			desc = "Reset your blacklist to empty.",
			func = "reset"
		},
		list = {
			type = "execute",
			name = "list",
			desc = "List your blacklist.",
			func = "list"
		}
    }
}

local blacklist
local notfoundspells

SpellRankCheck:RegisterChatCommand({"/spellrankcheck", "/src"}, options)

SpellRankCheck:RegisterDB("SpellRankCheckDB", "SpellRankCheckDBPC")

function SpellRankCheck:bllist()
	SpellRankCheck:runcheck('bl')
end

function SpellRankCheck:reset()
	self:Print('**** Empty blacklist ****')
	self.db.char.blacklist = {}
	self:Print('**** END ****')
end

function SpellRankCheck:list()
	
	self:Print('**** Displaying blacklist ****')
	if self.db.char.blacklist then
		for k,v in pairs(self.db.char.blacklist) do
			self:Print('Spell %s - %s is blacklisted.',k,v)
		end
	end
	self:Print('**** END ****')
end


function SpellRankCheck:OnInitialize()
    -- Called when the addon is loaded
end

function SpellRankCheck:OnEnable()
end

function SpellRankCheck:OnDisable()
    blacklist = NIL
	notfoundspells = NIL
end

function SpellRankCheck:runcheck(outputmethod)
local i = 1
local prev_spellName
local prev_spellRank
local found

books={BOOKTYPE_SPELL,BOOKTYPE_PET }
notfoundspells = {}
if outputmethod == 'bl' then
	blacklist = {}
else
	blacklist = self.db.char.blacklist
	if not blacklist then blacklist = {} end
end
for k,v in pairs(books) do
	prev_spellName='first'
	while true do
		local spellName, spellRank = GetSpellName(i, BOOKTYPE_SPELL)
		if not spellName then
			do break end
		else
			if not spellRank then spellRank='' end
			if prev_spellName ~= spellName and prev_spellName ~= 'first' then
				if blacklist[prev_spellName] ~= prev_spellRank then
					found = SpellRankCheck:search(prev_spellName,prev_spellRank,v)
					if not found and not string.find(prev_spellRank,'Passive') then
						notfoundspells[prev_spellName]=prev_spellRank
					end
				end
			end
		end	
		prev_spellName = spellName
		prev_spellRank = spellRank
		i = i + 1
	end
	if prev_spellName ~= spellName and prev_spellName ~= 'first' then
		if blacklist[prev_spellName] ~= prev_spellRank then
			found = SpellRankCheck:search(prev_spellName,prev_spellRank,v)
			if not found and not string.find(prev_spellRank,'Passive') then
				notfoundspells[prev_spellName]=prev_spellRank
			end
		end
	end
end
if outputmethod == 'bl' then
	self:Print('**** Creating blacklist ****')
else
	self:Print('**** Displaying missing spells ****')
end
for k,v in pairs(notfoundspells) do
	if outputmethod == 'bl' then
		blacklist[k] = v
		self:Print('Adding %s - %s to blacklist.',k,v)
	else
		self:Print('Spell %s - %s not found.',k,v)
	end
end
	self:Print('**** END ****')

if outputmethod == 'bl' then self.db.char.blacklist = blacklist end
end

function SpellRankCheck:search(spell,rank,booktype)
local found
if spell then
	found = SpellRankCheck:searchActionbar(spell,rank,booktype)
end
return found
end


function SpellRankCheck:searchActionbar(spell,rank,booktype)
local g = AceLibrary("Gratuity-2.0")

local lActionSlot = 1
local found
local actionname
local actionrank
local maxslot

if booktype == BOOKTYPE_SPELL then maxslot = 120 end
if booktype == BOOKTYPE_PET then maxslot = NUM_PET_ACTION_SLOTS end
if spell and maxslot then
	if not rank then rank = '' end

	while not found do
		if booktype == BOOKTYPE_SPELL then g:SetAction(lActionSlot) end
		if booktype == BOOKTYPE_PET then g:SetPetAction(lActionSlot) end
		
		actionname = g:GetLine(1)
		actionrank = g:GetLine(1,true)
		if not actionrank then actionrank = '' end
		if actionname then
			if actionname == spell and actionrank == rank then
				found = true
			end
		end
		lActionSlot = lActionSlot  + 1
		if lActionSlot > maxslot and not found then found = 'out of range' end
	end
	if found == 'out of range' then found=NIL end
end
return found
end
--[[

  Title: Stacker
  Author: Pixel <pixel@nobis-crew.org>
  Version : 1.2.2
  Notes: Permits to stack automagically items.
  Comments: Very first standalone addon of my own.
  $Id: Stacker.lua,v 1.8 2006/09/13 10:08:19 pixel Exp $

  About
  -----

  This very simple addon maximises the stacks in your inventory and your bank.
  Just type /stack and all the stackable items will get stacked at the most
  possible value. /stacker stack bank will only stack items that are located
  in your bank bags. /stacker autostack will toggle a boolean to enable or
  disable autostacking when you open your bags.

  You can also use a provided keybinding.

  Changelog
  ---------

   2005/12/20: very first version - 1.0.0
   2005/12/21: slightly code cleanup - adding comments
               fixed a weired bug about concurrancy, rewriting some bits of
                 the stacking algorithm
               added the /stacker bank command so that it stacks in the bank
                 bags only
               fixed an ordering bug causing objects to go OUT of the bank
                 TO the inventory bags.
               tagging as version 1.1.0
   2006/01/24: trying to be nice with the wow engine, and lower the number
                 of calls to onUpdate().
               tagging as version 1.1.1
   2006/04/05: complete rewriting using Ace: http://www.wowace.com
               adding keybindings
               tagging as version 1.2
   2006/08/25: fixing a typo and updating TOC to version 1.12
               tagging as version 1.2.1
   2006/09/13: per request, adding verbosity output
               tagging as version 1.2.2

  Algorithm
  ---------

  The idea is quite simple. When you run the /stack command, the function
  Stacking gets called. It'll try to stack items by picking them up and
  putting them back where an incomplete stack is. The initial algorithm is
  using an hash-table, indexed on the itemId, so that when a collision occurs,
  we know that we should maybe stack.

  However, there's a small problem to this: since World of Warcraft is a
  server/client system, when picking up an object and putting it somewhere,
  the swapping is done by sending a command to the server, and on client side,
  the call is not blocking. So, until the stacking is done, you can't pick
  that object up again. To solve that, when the algorithm wants to stack two
  objets, it'll just put that command in "queue" so that it's called from the
  OnUpdate call.

  As soon as the OnUpdate event managed to finally stack the object it has in
  hand, it'll call Stacking back. This has the drawback of restarting the
  algorithm from scratch, but this is not so much of a trouble since it's
  O(n) and is quite fast to perform (much faster than the Blizzard's
  server/client handshaking anyway).

  Note: this algorithm runs more loops than necessary, only for me to be sure
  the job is done (I never trust my algorithm so I always add extra checking
  loops) and could be slightly faster. Also, one could save the hash table when
  exitting the Stacking loop, and restart where we got interrupted to be faster.
  But to me, since WoW is a very versatile system, with lots of interactions,
  I'd prefer not assume things are consistants, and that objects may disappear
  or reappear from time to time within the inventory, if not from a user's
  self-will action.
  
  Also, this algorith isn't maybe the best one, in term of number of swapping
  done, but, well, it's an easy and working one.

]]--

local DEFAULT_OPTIONS = {
    autostack = false,
    verbose = false,
}

Stacker = AceAddon:new {
    name          = STACKER.NAME,
    description   = STACKER.DESCRIPTION,
    version       = "1.2.2",
    releaseDate   = "05-04-2006",
    aceCompatible = "103",
    author        = "Pixel",
    email         = "pixel@nobis-crew.org",
    website       = "http://www.nobis-crew.org",
    category      = ACE_CATEGORY_INVENTORY,
    db            = AceDatabase:new "StackerDB",
    defaults      = DEFAULT_OPTIONS,
    cmd           = AceChatCmd:new(STACKER.COMMANDS, STACKER.CMD_OPTIONS)
}

function Stacker:Initialize()
    self.BAGSLIST_DEFAULT = { -1, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 0, 1, 2, 3, 4 }
    self.BAGSLIST_BANK    = { -1, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 }

    self.stacking = false
    self.bagslist = self.BAGSLIST_DEFAULT

    self.open_bags = { [0] = false, [1] = false, [2] = false, [3] = false, [4] = false }
    self.swap_sequence = 0

    self.GetOpt = function(var) return self.db:get(self.profilePath,var)    end
    self.SetOpt = function(var,val) self.db:set(self.profilePath,var,val)   end
    self.TogOpt = function(var) return self.db:toggle(self.profilePath,var) end
    self.TogMsg = function(text, val) self.cmd:status(text, val, ACEG_MAP_ONOFF) end

    SlashCmdList.STACKER_STACK_CMD = function() if not self.disabled then self:Stack() end end
    SLASH_STACKER_STACK_CMD1       = STACKER.CMD_COMMAND_STACK
end

function Stacker:Enable()
    self:RegisterEvent("BAG_UPDATE",    "BagUpdate")
    self:RegisterEvent("CURSOR_UPDATE", "CursorUpdate")

    self:Hook "ToggleBag"
end

function Stacker:AutoStackToggle()
    self.TogMsg(STACKER.TEXT_AUTOSTACK, self.TogOpt "autostack")
end

function Stacker:VerboseToggle()
    self.TogMsg(STACKER.TEXT_AUTOSTACK, self.TogOpt "verbose")
end

function Stacker:Stack()
    self.bagslist = self.BAGSLIST_DEFAULT
    self:Stacking()
end

function Stacker:BankStack()
    self.bagslist = self.BAGSLIST_BANK
    self:Stacking()
end

function Stacker:ToggleBag(bag)
    if (self.open_bags[bag]) then
        self.open_bags[bag] = false
    else
        self.open_bags[bag] = true
        if (self.GetOpt "autostack") then
            self:Stacking()
        end
    end
    return self.Hooks.ToggleBag.orig(bag)
end

function Stacker:Report()
    self.cmd:report{
        { text = STACKER.TEXT_AUTOSTACK, val = self.GetOpt "autostack", map = ACEG_MAP_ONOFF },
        { text = STACKER.TEXT_VERBOSE, val = self.GetOpt "verbose", map = ACEG_MAP_ONOFF },
    }
end

function Stacker:GetItem(bag, slot)
    local link = GetContainerItemLink(bag, slot)
    if (link == nil) then return nil end
    local _, iItemId = self.SplitString(link, ':', 3)
    local sName, sLink, iQuality, iLevel, sType, sSubType, iStack = GetItemInfo(iItemId)
    local texture, iCount = GetContainerItemInfo(bag, slot)

    local dataItem = {
        name = sName,
        link = sLink,
        quality = iQuality,
        level = iLevel,
        type = sType,
        subtype = sSubType,
        stack = iStack,
        count = iCount,
        itemId = iItemId,
    }

    return dataItem
end

function Stacker:BagName(bag)
    if ((bag >= 0) and (bag <= 4)) then
	return "bags"
    else
	return "bank"
    end
end

function Stacker:ColorFromQuality(quality)
    local QL_Colors = {
	[0] = "ff9d9d9d",
	[1] = "ffffffff",
	[2] = "ff1eff00",
	[3] = "ff0070dd",
	[4] = "ffa335ee",
	[5] = "ffff8000",
	[6] = "ffffcc9d",
    }

    return QL_Colors[quality]
end

function Stacker:Stacking()
    local bag, slot, items, itemData, id, i, v, _    
    
    -- We can't start the algorithm if we have something in hand.
    if (CursorHasItem()) then
        ace:print "Please hand over the item you have in hand."
        self.stacking = false
        return false
    end

    items = {}

    for _, bag in ipairs(self.bagslist) do
        for slot = 1, GetContainerNumSlots(bag) do
            itemData = self:GetItem(bag, slot)
            if (itemData ~= nil) then
                -- subData is our temporary hash value which will be stored
                -- in the hash when the stacking is done.
                subData = { bag = bag, slot = slot, count = itemData.count, stack = itemData.stack }
                id = itemData.itemId
                -- "id" is our hash key. If we never saw any object of this kind, let's create the hash entry.
                if (items[id] == nil) then
                    items[id] = { subData }
                else
                    -- We already matched that kind of object, but before going on,
                    -- let's see if the object is stackable, and still has room.
                    if (itemData.count ~= itemData.stack) then
                        -- Let's loop on all the objects previously matched in the hash, to find
                        -- something stackable.
                        for i,v in ipairs(items[id]) do
                            if (v.count ~= v.stack) then
                                -- The object's pair are both incomplete. Let's schedule them for stacking.
                                self:debug("Scheduling " .. bag .. "," .. slot .. " to " .. v.bag .. "," .. v.slot)
                                self.sourcebag = bag
                                self.sourceslot = slot
                                self.targetbag = v.bag
                                self.targetslot = v.slot
                                self.swap_sequence = 1
                                self.stacking = true
                                self:Hook "WorldFrame_OnUpdate"
				if (self.GetOpt "verbose") then
				    ace:print("|cffffd700Stacking|r |cffffff00" .. itemData.count .. "|rx|c" ..
                                               self:ColorFromQuality(itemData.quality) .. "|H" .. itemData.link ..
                                               "|h[" .. itemData.name .. "]|h|r |cffffd700from|r |cffffff00" ..
                                               self:BagName(bag) .. "|r |cffffd700onto|r |cffffff00" .. v.count ..
                                               "|r |cffffd700in|r |cffffff00" .. self:BagName(v.bag) .. "|r")
				end
                                return true
                            end
                        end
                    end
                    
                    -- Let's update the hash table with the current object, if it hasn't been emptied.
                    table.insert(items[id], subData)
                end
            end
        end
    end
    
    self.stacking = false
    self:Unhook "WorldFrame_OnUpdate"
    return false
end

function Stacker:BagUpdate()
    if (not self.stacking) then return end
    if (self.swap_sequence == 5) then
        self:debug("Item is beeing dropped down, let's advance the sequence.")
        self.swap_sequence = 6
    elseif (self.swap_sequence == 6) then
        self:debug("Item is dropped down, let's finish the sequence.")
        self.swap_sequence = 7
    end
end

function Stacker:CursorUpdate()
    if (not self.stacking) then return end
    if (self.swap_sequence == 2) then
        self:debug("Item is beeing picked up, let's advance the sequence.")
        self.swap_sequence = 3
    elseif (self.swap_sequence == 3) then
        self:debug("Item is picked up, let's advance the sequence.")
        self.swap_sequence = 4  
    end
end

function Stacker:WorldFrame_OnUpdate(...)
    if (not self.stacking) then
        return self.Hooks.WorldFrame_OnUpdate.orig(unpack(arg))
    end

    local o = self.Hooks.WorldFrame_OnUpdate.orig

    if (self.swap_sequence == 1) then
        self:debug("Picking up source item " .. self.sourcebag .. "," .. self.sourceslot)
        self.swap_sequence = 2
        PickupContainerItem(self.sourcebag, self.sourceslot)
    elseif (self.swap_sequence == 4) then
        if (CursorHasItem()) then
            self:debug("We have item in hand, putting it to target item " .. self.targetbag .. "," .. self.targetslot)
            self.swap_sequence = 5
            PickupContainerItem(self.targetbag, self.targetslot)
        end
    elseif (self.swap_sequence == 7) then
        if (not CursorHasItem()) then
            self:debug("Restarting stacker")
            self.swap_sequence = 0
            self:Stacking(true)
        end
    end

    return o(unpack(arg))
end

Stacker:RegisterForLoad()

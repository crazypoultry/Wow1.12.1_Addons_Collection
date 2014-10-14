--[[--------------------------------------------------------------------------------------------

MozzEasyMail.lua
MozzPack version 1.07 released 20051012

This AddOn fills in last mail recipient and subject fields automatically.
- As long as you don't edit the subject field, it will update automatically as you add/remove
  items and money from the message you are composing, or toggle the COD setting.
- The standard UI now includes auto-completion of guild members, so I have removed that code
  from MozzEasyMail.

- TODO: unfinished feature:
  Also with a fast-looting feature for the inbox.  Shift-clicking on a message with *no body*
  and *one or less attachments* will loot the item (if any) and delete the message.

--]]--------------------------------------------------------------------------------------------

MozzEasyMail_LastMailed = "";
local lastAutoSubject = "";

------------------------------------------------------------------------------------------------

-- TODO: this needs a rewrite to not interfere with the regular inbox functions.

-- TODO: In this version you have to shift-click MULTIPLE TIMES because it turns out that you
-- can only do one of (TakeInboxMoney, TakeInboxItem, DeleteInboxItem) at a time.  Or perhaps
-- only one of them in response to a mouse-click.  Further investigation is needed (try some
-- sort of hack that schedules events into the future?)

-- local lOriginal_InboxFrame_OnClick = InboxFrame_OnClick
-- function InboxFrame_OnClick(index)
--     if (IsShiftKeyDown()) then
--         -- can we simply loot-and-delete this item?
--         InboxFrame.openMailID = index;
--         OpenMail_Update();
--         local body = OpenMailBodyText:GetText()
--
--         -- if it has no body text and no COD payment, try to loot-and-delete it.
--         if ((not body) or (body == "") then
--             local packageIcon,stationeryIcon,sender,subject,money,CODAmount,daysLeft,itemID,
--                 wasRead,wasReturned,textCreated = GetInboxHeaderInfo(InboxFrame.openMailID);
--             if (not itemID) or (not CODAmount) then
--                 --echo("Loot-and-delete!")
--                 TakeInboxMoney(InboxFrame.openMailID)
--                 TakeInboxItem(InboxFrame.openMailID)
--
--                 StaticPopup_Hide("DELETE_MAIL");
--
--                 -- If mail contains no items, then delete it!
--                 local packageIcon,stationeryIcon,sender,subject,money,CODAmount,daysLeft,itemID,
--                     wasRead,wasReturned,textCreated = GetInboxHeaderInfo(InboxFrame.openMailID);
--                 if (money==0 and CODAmount==0 and not itemID) then
--                     DeleteInboxItem(InboxFrame.openMailID);
--                     InboxFrame.openMailID = nil;
--                     HideUIPanel(OpenMailFrame);
--                     return
--                 end
--                 -- don't open/close window if it was at least eligible.
--                 return
--             end
--         end
--         -- unsuccessful.  Finish opening it (or closing it!) in the normal fashion.
--     end
--     lOriginal_InboxFrame_OnClick(index)
-- end

------------------------------------------------------------------------------------------------

local lOriginal_SendMailFrame_Reset = SendMailFrame_Reset
function SendMailFrame_Reset()
    lOriginal_SendMailFrame_Reset()
    SendMailNameEditBox:SetText(MozzEasyMail_LastMailed);
end

local lOriginal_SendMailFrame_SendMail = SendMailFrame_SendMail
function SendMailFrame_SendMail()
    MozzEasyMail_LastMailed = SendMailNameEditBox:GetText();
    lOriginal_SendMailFrame_SendMail()
end

------------------------------------------------------------------------------------------------

local function calculateSubject()
    local subject = ""
    local sep = ""

    local itemName,texture,count = GetSendMailItem();
    if itemName then
        subject = "["..itemName.."]";
        if (count and count>1) then subject = count.." "..subject end
        if (SendMailSendMoneyButton:GetChecked()) then sep=" + " else sep=" for " end
    end

    local money = MoneyInputFrame_GetCopper(SendMailMoney)
    if money~=0 then
        local copper = math.mod(money,100); money = math.floor(money/100)
        local silver = math.mod(money,100); money = math.floor(money/100)
        local gold = money

        if gold~=0 then subject = subject..sep..gold.."g"; sep=" " end
        if silver~=0 then subject = subject..sep..silver.."s"; sep=" " end
        if copper~=0 then subject = subject..sep..copper.."c"; sep=" " end
    end
    return subject
end

------------------------------------------------------------------------------------------------

function updateSubject(force)
    local autoSubject = calculateSubject()
    if (autoSubject ~= lastAutoSubject) then
        local subject = SendMailSubjectEditBox:GetText();

        if subject == lastAutoSubject then
            SendMailSubjectEditBox:SetText(autoSubject);
        end
        lastAutoSubject = autoSubject;
    end
end

------------------------------------------------------------------------------------------------

-- hack to work around Blizzard
local IGNORE_SET_TEXT = nil
local lOriginal_SendMailSubjectEditBox_SetText = SendMailSubjectEditBox.SetText
function SendMailSubjectEditBox.SetText(self,text)
    if not IGNORE_SET_TEXT then return lOriginal_SendMailSubjectEditBox_SetText(self,text) end
end

------------------------------------------------------------------------------------------------

local lOriginal_SendMailFrame_Update = SendMailFrame_Update;
function SendMailFrame_Update()
    IGNORE_SET_TEXT = 1
    lOriginal_SendMailFrame_Update()
    IGNORE_SET_TEXT = nil
    updateSubject(1)
end

------------------------------------------------------------------------------------------------

function MozzEasyMailFrame_OnUpdate(elapsed)
    updateSubject(nil)
end

------------------------------------------------------------------------------------------------

-- end of file

-- English text strings

-- Binding Configuration
BINDING_HEADER_MAILTO   = "MailTo"
BINDING_NAME_MAILTOLOG  = "Display MailTo log"
BINDING_NAME_MAILTOEX   = "Display Inbox expirations"
BINDING_NAME_MAILTOMAIL = "Toggle MailTo Inbox window"

-- MailTo option list with text
MAILTO_OPTION = { alert=  {flag='noalert', name="Delivery alert"},
                  auction={flag='noauction', name="Auction click"},
                  chat=   {flag='nochat',  name="Chat click"},
                  coin=   {flag='nocoin',  name="Coin letters"},
                  ding=   {flag='noding',  name="Ding sound"},
                  click=  {flag='noclick', name="Inventory"},
                  login=  {flag='nologin', name="Login notice"},
                  shift=  {flag='noshift', name="Shift-click"},
                  trade=  {flag='notrade', name="Trade click"},
                }
MAILTO_DAYS = {icon=28, long=3, new=7, short=1, soon=3, warn=2}

-- Message text
MAILTO_ON =         "%s has been turned on."
MAILTO_OFF =        "%s has been turned off."
MAILTO_TIME =       "The time for '%s' expiration has been set to %s"
MAILTO_TOOLTIP =    "Click to select recipient."
MAILTO_CLEARED =    "The MailTo list has been cleared!"
MAILTO_LISTEMPTY =  "Empty list."
MAILTO_LISTFULL =   "Warning: List is full!"
MAILTO_ADDED =      " added to MailTo list."
MAILTO_REMOVED =    " removed from MailTo list."
MAILTO_F_ADD =      "(Add %s)"
MAILTO_F_REMOVE =   "(Remove %s)"
MAILTO_YOU =        "you"
MAILTO_DELIVERED =  "delivered."
MAILTO_DUE =        "due in %d min."
MAILTO_SENT =       "%s sent to %s by %s is %s"
MAILTO_RETURNLIST = "Returnable inbox items:"
MAILTO_RETURN =     "|cffffffff%s|r sent to %s"
MAILTO_NORETURN =   "No returnable items found."
MAILTO_NEW =        "%s%s from %s delivered to %s"
MAILTO_NONEW =      "No new mail items found."
MAILTO_NEWMAIL =    "(possible new mail)"
MAILTO_LOGEMPTY =   "The mail log is empty."
MAILTO_NODATA =     "No inbox data."
MAILTO_NOITEMS =    "No items in inbox."
MAILTO_NOTFOUND =   "No items found."
MAILTO_INBOX =      "#%d, %s, from %s"
MAILTO_EXPIRES =    " expires in "
MAILTO_EXPIRED =    " has expired!"
MAILTO_UNDEFINED =  "Undefined command, "
MAILTO_RECEIVED =   "Received %s from %s, %s"
MAILTO_SALE =       "%s bought %s for %s (net=%s)."
MAILTO_WON =        "You bought %s from %s for %s."
MAILTO_NONAME =     "Missing name."
MAILTO_NODESC =     "Missing description."
MAILTO_MAILOPEN =   "Mailbox is open."
MAILTO_MAILCHECK =  "Mailbox not checked."
MAILTO_TITLE =      "MailTo  Inbox"
MAILTO_STACK =		"(Stack of %d)"
MAILTO_DATE =       "Date Rcvd: "
MAILTO_SELECT =     "Select:"
MAILTO_SERVER =     "Server"
MAILTO_SERVERTIP =  "Check to select characters on other servers"
MAILTO_FROM =       "From: "
MAILTO_EXPIRES2 =   "Expires in "
MAILTO_RETURNED =   "Returned in "
MAILTO_DELETED =    "Deleted in "
MAILTO_EXPIRED2 =   "Has expired!"
MAILTO_RETURNED2 =  "Has been returned!"
MAILTO_DELETED2 =   "Has been deleted!"
MAILTO_LOCATE =     "Locating items matching '%s':"
MAILTO_REMOVE2 =    "Removed %s of %s."
MAILTO_BACKPACK =   "No empty backpack slot for split."
MAILTO_EMPTYNEW =   "You may have new mail..."
MAILTO_MAIL =       "Mail"
MAILTO_INV =        "Inv"
MAILTO_BANK =       "Bank"
MAILTO_SOLD =       "Auction successful"
MAILTO_OUTBID =     "Outbid"
MAILTO_CANCEL =     "Auction cancelled"
MAILTO_CASH =       "Received cash: Total=%s, Sales=%s, Refunds=%s, Other=%s"

-- Help text
MT_Help = { ['?'] = 'MailTo';
	inbox = { ['?'] = "Manage your inbox window",
		  [''] = "Toggle the inbox viewer window",
		  ['return'] = "List returnable sent items",
		  ['<name>'] = "View the inbox for <name>", };
	mf = { ['?'] = "Add a mail log item",
		  ['<name> <item>'] = "Add a mail log entry for an item being sent to you", };
	mt = { ['?'] = "The main chat command",
		  [''] = "List mail log entries for the current character",
		  alert = "Toggles whether delivery messages are sent immediately",
		  auction = "Toggles whether the inventory right-click is ignored for auctions",
		  chat = "Toggles whether the chat link right-click is ignored",
		  clear = "Clears the Send Mail menu list",
		  click = "Toggles whether the inventory right-click is completely ignored",
		  coin = "Toggles whether the money display includes the coin letter",
		  ding = "Toggles the delivered mail sound on or off",
		  list = "List the Send Mail menu names",
		  login = "Toggles whether expiring and pending items will be listed at login",
		  pos = "Moves the Send Mail menu position",
		  shift = "Toggles whether the shift key is ignored on inventory right-click",
		  trade = "Toggles whether the inventory right-click is ignored for trades", };
	mtex = { ['?'] = "Manage exiring messages",
		  [''] = "List the next inbox item to expire for the current character",
		  active = "List the next inbox item to expire for all non-empty mailboxes",
		  all = "List the next inbox item to expire for all non-empty mailboxes",
		  active = "List the next inbox item to expire for all characters",
		  icon = "Set exp. days for inbox potential mail icon (def=28)",
		  long = "Set days for long exp. color of yellow (def=7)",
		  new = "Set days for potential new mail exp. listing (def=3)",
		  short = "Set days for short exp. color of red (def=1)",
		  server = "List the next inbox item to expire for all characters on this server",
		  soon = "List the inbox items to expire soon, normally in 3 days",
		  warn = "Set exp. days for login warning message (def=2)", };
	mtl = { ['?'] = "Locate inbox items",
		  ['<name>'] = "Locate all inbox and CharactersViewer items matching <name>", };
	mtn = { ['?'] = "Display newly delivered items",
		  [''] = "Display newly delivered items on this server ",
		  all = "Display newly delivered items on all servers", };
	}
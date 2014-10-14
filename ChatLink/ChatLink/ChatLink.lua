--[[
ChatLink.lua
by Yrys - Hellscream <yrysremove at twparemove dot net>

This addon enables linking items and enchants in private chat channels, a feature I've found sorely lacking since it was removed in beta.  ChatLink is disabled by default in public channels to prevent spam.

Version history:
- 1.1.2.11200 (2006-09-29): Re-added compatibility with links before 1.1.0, and added future compatibility as well.
- 1.1.0.11200 (2006-09-27): Updated for 1.12 patch, and added enchant link support.
- 1.0.4.11100 (2006-07-24): Updated for 1.11 patch.
- 1.0.4.11000 (2006-03-17): Updated for 1.10 patch.
- 1.0.4.10900 (2005-12-02): Updated for 1.9 patch.
- 1.0.4.1800  (2005-09-30): Updated for 1.8 patch; now with French localization!  Thanks Viny!
- 1.0.3.1700  (2005-09-07): Updated for 1.7 patch; added German localization. Thanks Getch!
- 1.0.2.1600  (2005-07-12): Updated for 1.6 patch.
- 1.0.2.1500  (2005-06-07): Updated for 1.5 patch.
- 1.0.2.1300  (2005-04-14): Fixed a bug with nil strings in AddMessage.
- 1.0.1.1300  (2005-04-06): Added support for links in other chat windows.
- 1.0.0.1300  (2005-04-05): Initial release.
]]

-- Variables.
CHATLINK_VER = "1.1.2.11200"
local AddMessage1_Original = nil
local AddMessage2_Original = nil
local AddMessage3_Original = nil
local AddMessage4_Original = nil
local AddMessage5_Original = nil
local AddMessage6_Original = nil
local AddMessage7_Original = nil
local SendChatMessage_Original = nil



function ChatLink_OnLoad()
	-- Hook functions.
	if DEFAULT_CHAT_FRAME.AddMessage ~= ChatLink_AddMessage1 then
		AddMessage1_Original = DEFAULT_CHAT_FRAME.AddMessage
		DEFAULT_CHAT_FRAME.AddMessage = ChatLink_AddMessage1
	end
	if ChatFrame2 and ChatFrame2.AddMessage ~= ChatLink_AddMessage2 then
		AddMessage2_Original = ChatFrame2.AddMessage
		ChatFrame2.AddMessage = ChatLink_AddMessage2
	end
	if ChatFrame3 and ChatFrame3.AddMessage ~= ChatLink_AddMessage3 then
		AddMessage3_Original = ChatFrame3.AddMessage
		ChatFrame3.AddMessage = ChatLink_AddMessage3
	end
	if ChatFrame4 and ChatFrame4.AddMessage ~= ChatLink_AddMessage4 then
		AddMessage4_Original = ChatFrame4.AddMessage
		ChatFrame4.AddMessage = ChatLink_AddMessage4
	end
	if ChatFrame5 and ChatFrame5.AddMessage ~= ChatLink_AddMessage5 then
		AddMessage5_Original = ChatFrame5.AddMessage
		ChatFrame5.AddMessage = ChatLink_AddMessage5
	end
	if ChatFrame6 and ChatFrame6.AddMessage ~= ChatLink_AddMessage6 then
		AddMessage6_Original = ChatFrame6.AddMessage
		ChatFrame6.AddMessage = ChatLink_AddMessage6
	end
	if ChatFrame7 and ChatFrame7.AddMessage ~= ChatLink_AddMessage7 then
		AddMessage7_Original = ChatFrame7.AddMessage
		ChatFrame7.AddMessage = ChatLink_AddMessage7
	end
	if SendChatMessage ~= ChatLink_SendChatMessage then
		SendChatMessage_Original = SendChatMessage
		SendChatMessage = ChatLink_SendChatMessage
	end
	
	-- Show loaded message.
	DEFAULT_CHAT_FRAME:AddMessage (string.format (STR_CHATLINK_LOADED, CHATLINK_VER))
end



--[[ function ChatLink_OnEvent (event)
	if event == "VARIABLES_LOADED" then
	end
end ]]



-- Turn CLINKs into normal item and enchant links.
function ChatLink_Decompose (chatstring)
	if chatstring then
		chatstring = string.gsub (chatstring, "{CLINK:item:(%x+):(%d-):(%d-):(%d-):(%d-):([^}]-)}", "|c%1|Hitem:%2:%3:%4:%5|h[%6]|h|r")
		chatstring = string.gsub (chatstring, "{CLINK:enchant:(%x+):(%d-):([^}]-)}", "|c%1|Henchant:%2|h[%3]|h|r")
		-- For backward compatibility (yeah, I should have done it before...).
		chatstring = string.gsub (chatstring, "{CLINK:(%x+):(%d-):(%d-):(%d-):(%d-):([^}]-)}", "|c%1|Hitem:%2:%3:%4:%5|h[%6]|h|r")

		-- Forward compatibility, for future clink structure changes.
		chatstring = string.gsub (chatstring, "{CLINK(%d):%[?([^:}%]]-)%]?:([^:}]-)[^}]-}", "%2")
	end
	return chatstring
end



-- Turn item and enchant links into CLINKs.
function ChatLink_Compose (chatstring)
	if chatstring then
--		1.10 item links: to possibly be reactivated in a future version.
--		chatstring = string.gsub (chatstring, "|c(%x+)|H(item):(%d-):(%d-):(%d-):(%d-)|h%[([^%]]-)%]|h|r", "{CLINK:%2:%1:%3:%4:%5:%6:%7}")
--		Old item links: backward compatibility.
		chatstring = string.gsub (chatstring, "|c(%x+)|Hitem:(%d-):(%d-):(%d-):(%d-)|h%[([^%]]-)%]|h|r", "{CLINK:%1:%2:%3:%4:%5:%6}")
		chatstring = string.gsub (chatstring, "|c(%x+)|H(enchant):(%d-)|h%[([^%]]-)%]|h|r", "{CLINK:%2:%1:%3:%4}")
	end
	return chatstring
end



-- Translate CLINKs back into normal text on incoming messages.
function ChatLink_AddMessage1(t, s, ...)
	-- Debug: Show untranslated message.
--	AddMessage_Original (t, "|c5050ffffBefore: |r" .. s, unpack (arg))
	s = ChatLink_Decompose (s)

	-- Debug: Show raw links.
--	s = string.gsub (s, "|", "PIPE")

	-- Pass along to original function.
	AddMessage1_Original (t, s, unpack (arg))
end



-- Translate CLINKs back into normal text on incoming messages.
function ChatLink_AddMessage2(t, s, ...)
	-- Debug: Show untranslated message.
--	AddMessage_Original (t, "|c5050ffffBefore: |r" .. s, unpack (arg))
	s = ChatLink_Decompose (s)

	-- Pass along to original function.
	AddMessage2_Original (t, s, unpack (arg))
end



-- Translate CLINKs back into normal text on incoming messages.
function ChatLink_AddMessage3(t, s, ...)
	-- Debug: Show untranslated message.
--	AddMessage_Original (t, "|c5050ffffBefore: |r" .. s, unpack (arg))
	s = ChatLink_Decompose (s)

	-- Pass along to original function.
	AddMessage3_Original (t, s, unpack (arg))
end



-- Translate CLINKs back into normal text on incoming messages.
function ChatLink_AddMessage4(t, s, ...)
	-- Debug: Show untranslated message.
--	AddMessage_Original (t, "|c5050ffffBefore: |r" .. s, unpack (arg))
	s = ChatLink_Decompose (s)

	-- Pass along to original function.
	AddMessage4_Original (t, s, unpack (arg))
end



-- Translate CLINKs back into normal text on incoming messages.
function ChatLink_AddMessage5(t, s, ...)
	-- Debug: Show untranslated message.
--	AddMessage_Original (t, "|c5050ffffBefore: |r" .. s, unpack (arg))
	s = ChatLink_Decompose (s)

	-- Pass along to original function.
	AddMessage5_Original (t, s, unpack (arg))
end



-- Translate CLINKs back into normal text on incoming messages.
function ChatLink_AddMessage6(t, s, ...)
	-- Debug: Show untranslated message.
--	AddMessage_Original (t, "|c5050ffffBefore: |r" .. s, unpack (arg))
	s = ChatLink_Decompose (s)

	-- Pass along to original function.
	AddMessage6_Original (t, s, unpack (arg))
end



-- Translate CLINKs back into normal text on incoming messages.
function ChatLink_AddMessage7(t, s, ...)
	-- Debug: Show untranslated message.
--	AddMessage_Original (t, "|c5050ffffBefore: |r" .. s, unpack (arg))
	s = ChatLink_Decompose (s)

	-- Pass along to original function.
	AddMessage7_Original (t, s, unpack (arg))
end



-- Translate item links into CLINKs on outgoing non-system channel messages.
function ChatLink_SendChatMessage (msg, ...)
	local chan_num, chan_name = nil
	system, language, channel = unpack (arg)

	if system == "CHANNEL" then
		chan_num, chan_name = GetChannelName (channel)
		if chan_name and
		not string.find (chan_name, STR_GENERAL) and
		not string.find (chan_name, STR_TRADE) and
		not string.find (chan_name, STR_LFG) and
		not string.find (chan_name, STR_LOCALDEF) and
		not string.find (chan_name, STR_WORLDDEF) then
			msg = ChatLink_Compose (msg)
		end
	end

	-- Pass along to original function.
	SendChatMessage_Original (msg, unpack (arg))
end

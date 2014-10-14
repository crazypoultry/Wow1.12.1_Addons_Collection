----------------------------------------------------------------------------------------------------
-- Name		: Spell Duration [Foo Functions]
-- Author	: Hunteryal & Mavet
-- EMail	: hunteryal@walla.com
----------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------
-- Name		: SDSendMsg
-- Comment	: Send a message to the chat
----------------------------------------------------------------------------------------------------
function SDSendMsg(msg, r, g, b, simple)
	if(not r) then r = 1.0; end
	if(not g) then g = 1.0; end
	if(not b) then b = 1.0; end
	if(not msg) then msg = "nil"; end
	if(not simple) then msg = "SD: "..msg; end
	if(DEFAULT_CHAT_FRAME) then DEFAULT_CHAT_FRAME:AddMessage(msg, r, g, b); end
end

----------------------------------------------------------------------------------------------------
-- Name		: SDSendMsgDebug
-- Comment	: Send a debug message to the chat
----------------------------------------------------------------------------------------------------
function SDSendMsgDebug(msg, r, g, b)
	if(not r) then r = 0.0; end
	if(not g) then g = 1.0; end
	if(not b) then b = 0.0; end
	if(not msg) then msg = "nil"; end
	if(SDGlobal.Debug) then SDSendMsg("SD DEBUG: "..msg, r, g, b) end
end

----------------------------------------------------------------------------------------------------
-- Name		: SDSendMsgVerbose
-- Comment	: Send a debug verbose message to the chat
----------------------------------------------------------------------------------------------------
function SDSendMsgVerbose(msg)
	if(SDGlobal.Verbose) then SDSendMsg("SD DEBUG (Verbose): "..msg, 1.0, 1.0, 0.0) end
end

----------------------------------------------------------------------------------------------------
-- Name		: SDBlnToStr
-- Comment	: Only for debug purpose
----------------------------------------------------------------------------------------------------
function SDBlnToStr(value)
	if(value) then return "True" else return "False"; end
end
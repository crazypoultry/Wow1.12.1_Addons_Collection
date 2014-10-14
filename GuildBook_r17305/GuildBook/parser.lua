-- file to convert html to php code and vice versa
--
local tokens = {
	['<'] = string.byte('<'),
	['>'] = string.byte('>'),
	['"'] = string.byte('"'),
	["'"] = string.byte("'"),
	['/'] = string.byte('/'),
}
local html = '<HTML><BODY><H1 align="center">Center</H1><H2 align="right">Right</H2><H3 align="left">Left</H3></BODY></HTML>'
local code = '[center]Center[/center][right]Right[/right][left]Left[/left]'
local code2 = '[center][color="red"]Red Center[/center][/color]Blah'
local html2 = '<HTML><BODY><H1 align="center">|cFFFF0000Red Center</H1>|r</BODY></HTML>'

local HTML_ESCAPES = {
   ['<'] = '&lt;',
   ['>'] = '&gt;',
   ['&'] = '&amp;',
   ['\n'] = '<br/>'
};

local HTML_PATTERS = {
	['align="center"'] = '[center]',
}

local function HTMLReplace(x)
   return HTML_ESCAPES[x] or '?';
end

function toHTML(text)
	if (not text) then
		return nil
	end
	text = string.gsub(text, "[<>&\n]", HTMLReplace);
	return text
end

function fromHTML(text)
end

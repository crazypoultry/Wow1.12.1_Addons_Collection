-- Here we go
--
--
--
-- for speedups
local _
local pairs = pairs

local _now -- for time stamps
local _version = '0.4-11200'
local _rank = {}
local _playerName = UnitName('player')

if (not GuildBook) then GuildBook = {} end
if (not GuildBook.crc) then GuildBook.crcs = {} end
if (not print) then print = function(msg) DEFAULT_CHAT_FRAME:AddMessage(msg) end end
if (not UnitName) then UnitName = function(unit) return 'Hamarian' end end
if (not time) then time = os.time end
GuildBook.timeDiff = 0

local GuildBookHelp = {
	['shortDescription'] = 'Information organization mod',
	['description'] = '<H1 align="center">Guild Book</H1><p>A mod to make storage of information easily organized in game</p>',
	['topics'] = {
		['Content'] = {
			['tagline'] = 'How to make your content pretty, by example',
			['content'] = '<p>blah</p>',
		},
		['commands'] = {
			['content'] = '<p>|cFF00FFFFshow|r: Show the GuildBook frame<br/>\
|cFF00FFFFhide|r: Hide the GuildBook frame<br/>\
|cFF00FFFFresetkb|r: Reset the GuildBookKB to the defaults. |cFFFF0000Warning!|r.  This act is irreversible.<br/>\
|cFF00FFFFversion|r: Output the GuildBook version.<br/></p>',
			['tagline'] = 'GuildBook commands',
		},
	},
	['author'] = 'JoshBorke',
	['name'] = 'GuildBook',
	['version'] = _version,
}

local function _copyTbl(src,dst)
	dst['content'] = src['content']
	dst['tagline'] = src['tagline']
	dst['author'] = src['author']
	dst['timestamp'] = src['timestamp']
end

function GuildBook.Error(func,msg)
	DEFAULT_CHAT_FRAME:AddMessage(string.format('GB Error (%s): %s',func,GuildBook.localise(msg)))
end

function GuildBook.localise(msg)
	return ((msg and GuildBook.localisation[msg]) or msg or 'no msg passed to localise')
end

function GuildBook.GetTime()
	return time() + GuildBook.timeDiff
end

function GuildBook.AddData(name,tagline,content,parent,author,timestamp,editors,deleters,perms,key)
	_now = GuildBook.GetTime()
	if (not name) then
		GuildBook.Error('AddData','No name passed')
		return false
	end
	if (not parent) then parent = getglobal('GuildBookKB') end
	if (parent and parent['objects'] and parent['objects'][name]) then
		GuildBook.ModifyData(parent['objects'][name],name,tagline,contente,author,timestamp)
		return
	end
	local tbl = {
		['content'] = content or tagline or name,
		['tagline'] = tagline or summary or name,
		['author'] = author or UnitName('player'),
		['parent'] = parent or getglobal('GuildBookKB'),
		['synch'] = parent['synch'],
		['name'] = name,
	}
	if (tbl['synch']) then
		tbl['timestamp'] = timestamp or _now
		tbl['timeUpdate'] = timestamp or _now
		tbl['hash1'] = GuildBookSynch and GuildBookSynch:ComputeHash(tbl)
		tbl['hash2'] = key
		tbl['editors'] = editors or parent['editors']
		tbl['deleters'] = deleters or parent['deleters']
	end
	if (not parent['objects']) then parent['objects'] = {} end
	parent['objects'][name] = tbl
	if (tbl['synch']) then
		while (parent and parent['synch']) do
			parent['timeUpdate'] = math.max(_now,parent['timeUpdate'])
			parent = parent['parent']
		end
		if (tbl['synch']) then GuildBookSynch:AddData(tbl,GuildBook.GetTreePath(tbl.parent)) end
	end
	return tbl
end

function GuildBook.ModifyData(node,name,tagline,content,author,timestamp,editors,deleters,perms,key)
	if (not node) then
		GuildBook.Error('ModifyData','Node not passed')
		return
	end
	node['content'] = content or node['content']
	node['tagline'] = tagline or node['tagline']
	node['author'] = author or node['author']
	if (node['synch']) then
		node['timestamp'] = timestamp or node['timestamp']
		node['timeUpdate'] = math.max(node['timeUpdate'] or 0,node['timestamp'] or 0)
	end
	node['editors'] = editors or node['editors']
	node['deleters'] = deleters or node['deleters']
	if (name and node.name ~= name) then
		node['parent']['objects'][name] = node['parent']['objects'][node['name']]
		node['parent']['objects'][node['name']] = nil
		node['name'] = name or node['name']
	end
	local parent = node['parent']
	while (parent and parent['synch']) do
		parent['timeUpdate'] = math.max(parent['timeUpdate'],node['timestamp'])
		parent = parent['parent']
	end
	if (node['synch'] and author == _playerName) then GuildBookSynch:ModifyData(node) end
end

function GuildBook.RemData(nameOrNode,parent)
	local name = nameOrNode
	if (type(nameOrNode) == 'table') then
		parent = nameOrNode['parent']
		name = nameOrNode['name']
	end
	if (not parent) then
		GuildBook.Error('RemData','No parent passed')
		return false
	elseif (not parent['objects']) then
		GuildBook.Error('RemData','Invalid parent passed')
		return false
	end
	local tbl = parent['objects'][name]
	tbl['deleted'] = time()
	--tbl.parent = nil -- don't remove the reference
	--parent['objects'][name] = nil -- don't remove the reference
	if (tbl.objects) then
		for obj,_ in pairs(tbl.objects) do
			GuildBook.DelData(obj,tbl)
		end
	end
	if (tbl.synch) then GuildBookSynch:RemData(tbl) end
end

function GuildBook.DelData(nameOrNode,parent)
	local name = nameOrNode
	if (type(nameOrNode) == 'table') then
		parent = nameOrNode['parent']
		name = nameOrNode['name']
	end
	if (not parent) then
		GuildBook.Error('RemData','No parent passed')
		return false
	elseif (not parent['objects']) then
		GuildBook.Error('RemData','Invalid parent passed')
		return false
	end
	local tbl = parent['objects'][name]
	tbl.parent = nil
	parent['objects'][name] = nil
	if (tbl.objects) then
		for obj,_ in pairs(tbl.objects) do
			GuildBook.RemData(obj,tbl)
		end
	end
end

function GuildBook.RestoreParents(node)
	if (not node) then return end
	if (node and type(node) == 'table' and node['objects']) then
		for name,tbl in pairs(node['objects']) do
			GuildBook.RestoreParents(tbl)
			tbl['parent'] = node
		end
	end
end

function GuildBook.SetKey(node,key)
	node.key = key
end

function GuildBook.CheckKey(node,key)
	return GuildBookSynch:ComputeHash(key) == node.hash2
end

function GuildBook.DumpNode(node)
	print(GuildBook.GetTreePath(node))
	for k,v in pairs(node) do
		if (type(v) ~= 'table') then
			print(string.format('%s: %s',k,v))
		end
	end
end

function GuildBook.GetNode(name,root)
	return root['objects'][name]
end

function GuildBook.GetTreePath(node)
	if (not node) then
		GuildBook.Error('GetTreePath','No node passed')
		return
	end
	local path = tostring(node.name)
	while (node.parent) do
		path = node.parent.name..'>'..path
		node = node.parent
	end
	return path
end

function GuildBook.TraverseTreePath(path)
	local newPath
	if (not path) then
		return GuildBookKB
	end
	if (not string.find(path,'>')) then return getglobal(path) end
	local _,_,stopName = string.find(path,'^.+>(.-)$')
	local _,_,nodeName,path = string.find(path,'^(.-)>(.+)$')
	local node = getglobal(nodeName)
	if (node and node['objects']) then
		_,_,nodeName,newPath = string.find(path,'^(.-)>(.+)$')
		if (newPath) then path = newPath end
		while (node['objects'] and node['objects'][nodeName] and newPath) do
			node = node['objects'][nodeName]
			_,_,nodeName,newPath = string.find(path,'^(.-)>(.+)$')
			if (newPath) then path = newPath end
		end
		if (node and node['objects'] and node['objects'][path] and node['objects'][path]['name'] == stopName) then 
			return node['objects'][path] 
		end
	end
	return nil
end

function GuildBook.GetContent(node)
	if (not node) then return '' end
	local str= string.format('<HTML><BODY>%s<p align="right">By %s</p>',node['content'],node['author']) or ''
	if (node['objects']) then
		str= string.format('%s<p align="left">-------<br/>',str)
		for name,tbl in pairs(node['objects']) do
			if (name and type(tbl) == 'table' and tbl.tagline and not tbl['deleted']) then
				str= string.format('%s<A href="%s">%s</A>: %s<BR/>',str,name,name,tbl.tagline)
			end
		end
		str= string.format('%s</p>',str)
	end
	str = string.format('%s</BODY></HTML>',str)
	return str
end

function GuildBook.ValidateContent(text)
	-- jump out for now, eventually i'll actually do something here
	return true
end

function GuildBook.CommandHandler(msg)
	msg = string.lower(msg)
	if (msg == 'show') then
		GuildBookFrame:Show()
	elseif (msg == 'hide') then
		GuildBookFrame:Hide()
	elseif (msg == 'resetkb') then
		GuildBook.ResetKB()
	elseif (msg == 'resetsync') then
		GuildBook.ResetSync()
	elseif (msg == 'version') then
		DEFAULT_CHAT_FRAME:AddMessage(string.format('|cFFFFFF00GuildBook|r: version %s',_version))
	elseif (msg == '' or not msg) then
		if (GuildBookFrame:IsVisible()) then
			GuildBookFrame:Hide()
		else
			GuildBookFrame:Show()
		end
	elseif (msg == 'sync') then
		if (GuildBookSynch:IsEnabled()) then
			GuildBookSynch:Disable()
			GuildBookOptions.sync.enabled = false
			DEFAULT_CHAT_FRAME:AddMessage(string.format('|cFFFFFF00GuildBook|r: Synchronization is now |cFFFF0000disabled|r.'))
		else
			DEFAULT_CHAT_FRAME:AddMessage(string.format('|cFFFFFF00GuildBook|r: Synchronization is now |cFF00FF00enabled|r.'))
			GuildBookOptions.sync.enabled = true
			GuildBookSynch:Enable()
		end
	elseif (msg == 'help') then
		DEFAULT_CHAT_FRAME:AddMessage(string.format('|cFFFFFF00GuildBook|r (show/hide): Show/hide the GuildBook window'))
		DEFAULT_CHAT_FRAME:AddMessage(string.format('|cFFFFFF00GuildBook|r (sync): Enable/Disable synchronization'))
		DEFAULT_CHAT_FRAME:AddMessage(string.format('|cFFFFFF00GuildBook|r (version): Display the GuildBook version.'))
		DEFAULT_CHAT_FRAME:AddMessage(string.format('|cFFFFFF00GuildBook|r (resetkb): Reset the GuildBook knowledge base.  |cFFFF0000WARNING IRREVERSIBLE YOU LOSE ALL SAVED DATA|r.'))
		DEFAULT_CHAT_FRAME:AddMessage(string.format('|cFFFFFF00GuildBook|r (resetsync): Reset the GuildBook synchronized knowledge base.  |cFFFF0000WARNING IRREVERSIBLE YOU LOSE ALL SAVED DATA|r.'))
	else
		DEFAULT_CHAT_FRAME:AddMessage(string.format('|cFFFFFF00GuildBook|r Invalid command (|cFFFF0000%s|r).  Please type /guildbook help',msg))
	end
end

function GuildBook.OnLoad()
	-- set minimum resize
	this:SetMinResize(236,96)
	GuildBookFrameEditFrame:SetMinResize(236,96)
	SLASH_GUILDBOOK1 = '/guildbook'
	SLASH_GUILDBOOK2 = '/gb'
	SlashCmdList['GUILDBOOK'] = GuildBook.CommandHandler
	GuildBookFrame:RegisterForDrag('LeftButton')
	GuildBookFrameEditFrame:RegisterForDrag('LeftButton')
	table.insert(UISpecialFrames,'GuildBookFrame')
	table.insert(UISpecialFrames,'GuildBookFrameEditFrame')
	GuildBookHTMLContent.SetText2 = GuildBookHTMLContent.SetText
	GuildBookHTMLContent.SetText = function(self,text)
		GuildBookHTMLContent.text = text
		GuildBookHTMLContent:SetText2(text)
	end
	GuildBookHTMLContent.GetText = function(self,text)
		return GuildBookHTMLContent.text
	end
	GuildBook.canEdit = true
	-- set the path into the right place
	GuildBookFramePath:ClearAllPoints()
	GuildBookFramePath:SetPoint('LEFT','GuildBookForwardButton','RIGHT',2,0)
	GuildBookFramePath:SetWidth(GuildBookFrame:GetWidth()-170)
	GuildBookFrameNameBoxFrame:SetPoint('TOPLEFT','GuildBookUndo','TOPRIGHT',2,0)
	GuildBookFrameTaglineBoxFrame:SetPoint('TOPLEFT','GuildBookFrameNameBoxFrame','TOPRIGHT',2,0)
	GuildBookFrame:RegisterEvent('VARIABLES_LOADED')
	GuildBookFrame:RegisterEvent('GUILD_ROSTER_UPDATE')
	if (IsInGuild()) then GuildRoster() end
end

function GuildBook.SetDisplayOptions()
	if (not GuildBookOptions) then GuildBookOptions = {} end
	if (not GuildBookOptions.display) then GuildBookOptions.display = {} end
	if (not GuildBookOptions.display.links) then GuildBookOptions.display.links = '00FFFF' end
	local tbl = {'h1','h2','h3'}
	for _,label in ipairs(tbl) do
		if (not GuildBookOptions.display[label]) then GuildBookOptions.display[label] = {} end
	end
	if (not GuildBookOptions.display.h1.size) then GuildBookOptions.display.h1.size = 10 end
	if (not GuildBookOptions.display.h2.size) then GuildBookOptions.display.h2.size = 5 end
	if (not GuildBookOptions.display.h3.size) then GuildBookOptions.display.h3.size = -2 end
	local font,height,flags = GuildBookHTMLContent:GetFont()
	for _,label in ipairs(tbl) do
		if (GuildBookOptions.display[label]['font']) then
			font = GuildBookOptions.display[label]['font']
		end
		GuildBookHTMLContent:SetFont(string.upper(label),font,height+GuildBookOptions.display[label]['size'],flags)
	end
	GuildBookHTMLContent:SetHyperlinkFormat('\124H%s\124h\124cFF'..GuildBookOptions.display.links..'%s\124r\124h')
end

function GuildBook.ParseMiscOptions()
	if (not GuildBookOptions) then GuildBookOptions = {} end
	if (not GuildBookOptions.sync) then GuildBookOptions.sync = {} end
	if (GuildBookOptions.sync.enabled) then GuildBookSynch:Enable() end
end

-- event handlers
function GuildBook.OnEvent(event,arg1)
	if (GuildBook[event] and type(GuildBook[event]) == 'function') then
		local func = GuildBook[event]
		func(arg1)
	end
end

function GuildBook.GUILD_ROSTER_UPDATE()
	local name,rankIndex
	for i=1,GetNumGuildMembers(true) do
		name,_,rankIndex = GetGuildRosterInfo(i)
		_rank[name] = rankIndex
	end
end

function GuildBook.VARIABLES_LOADED()
	-- populate the default information
	if (not GuildBookKB) then GuildBook.ResetKB() end
	if (not GuildBookOptions) then
		GuildBookOptions = {
		}
	end
	if (not GuildBookPerms) then
		GuildBookPerms = {}
	end
	GuildBook.SetDisplayOptions()
	GuildBook.ParseMiscOptions()
	-- hack to get around parent references not being restored
	GuildBook.RestoreParents(GuildBookKB)
	DEFAULT_CHAT_FRAME:AddMessage(string.format('|cFFFFFF00GuildBook|r v%s loaded.  Type |cFF0000FF/guildbook|r or |cFF0000FF/gb|r to open the window',_version))
	GuildBook.playerName = UnitName('player')
	--GuildBook.RestoreCurrentPath(GuildBookKB.currentPath)
	GuildBook.RegisterAddon('GuildBook',GuildBookHelp)
end

function GuildBook.ResetKB()
	local now = time()
	GuildBookKB = {
		['name'] = 'GuildBookKB',
		['author'] = 'JoshBorke',
		['deleters'] = '',
		['editors'] = nil,
		['content'] = '<H1 align="center">Guild Book</H1><H2>Overview:</H2><p>Guild Book is a mod I wrote to solve a problem that I encountered in my guild.\
		We had tons of information stored on our websites that lots of guild members had taken time to write.  But it was only those members who wrote it that ever really read it. \
		So I decided to create a mod that would allow my guild to store the information in game so that no one ever has to alt-tab out to read the information.  \
		Out of that decision, Guild Book was born.<br/>	 At its heart, GuildBook is a n-ary tree that stores information.  It was made flexible enough to store any \
		information that could be conceived.  Please do not store anything malicious :-P.</p><H2>Content details</H2><p>The content frame (this one) is a SimpleHTML object \
		in WoW.  What this means is it gives you (the user) the ability to see information in a somewhat pretty manner.  Text can be 4 different sizes, lots of different colors \
		and can be left/right/center aligned.  The first few versions are going to be very difficult to edit.  I hope to create functions that will allow me to make the editing \
		more like bbCode.  But in the meantime, I have included some of the basic formatting on this page.</p>',
		['objects'] = {
			['local'] = {	
				['name'] = 'local',
				['author'] = 'JoshBorke',
				['tagline'] = 'For storing your private information',
				['deleters'] = nil,
				['editors'] = nil,
				['content'] = '<H1 align="center">Change me!</H1>',
			},
			['sync'] = {
				['name'] = 'sync',
				['author'] = 'JoshBorke',
				['tagline'] = 'For synchronized information.  Not yet implemented',
				['deleters'] = '',
				['synch'] = true,
				['timeUpdate'] = now,
				['timestamp'] = now,
				['content'] = '<H1 align="center">Guild Book</H1><H2>Overview:</H2><p>This is the synchronized table.</p>',
			},
			['addons'] = {
				['name'] = 'addons',
				['author'] = 'JoshBorke',
				['deleters'] = '',
				['editors'] = '',
				['tagline'] = 'For addon help',
				['content'] = '<H1 align="center">Guild Book</H1><H2>Addons:</H2><p>This is the root for addons to register to.</p>',
			},
		}
	}
	GuildBook.ResetRoot()
	GuildBook.RestoreParents(GuildBookKB)
end

function GuildBook.ResetSync()
	local now = time()
	local tbl = GuildBookKB.objects['sync'] or {}
	tbl['name'] = 'sync'
	tbl['author'] = 'JoshBorke'
	tbl['tagline'] = 'For synchronized information.  Not yet implemented'
	tbl['deleters'] = nil
	tbl['synch'] = true
	tbl['timeUpdate'] = now
	tbl['timestamp'] = now
	tbl['content'] = '<H1 align="center">Guild Book</H1><H2>Overview:</H2><p>This is the synchronized table.</p>'
	GuildBookKB.objects['sync'] = tbl
	GuildBookOptions.sync.enabled = true
end

--[[ For permission management ]]--
function GuildBook.NameCanEdit(name,node)
	if (not name) then return false end
	if (not node['editors'] or string.find(node['editors'],':'..name..':') or (_rank and _rank[name] and string.find(node['editors'],':'.._rank[name]..':'))) then
		return true
	end
end

function GuildBook.NameCanDelete(name,node)
	if (not name) then return false end
	if (not node['deleters'] or string.find(node['deleters'],':'..name..':') or (_rank and _rank[name] and string.find(node['deleters'],':'.._rank[name]..':'))) then
		return true
	end
end

--[[ for addons to register stuff ]]--
function GuildBook.RegisterAddon(addon,information)
	local _root = GuildBookKB['objects']['addons']
	_root = GuildBook.AddData(addon,information.shortDescription,information.description,_root,information.author)
	if (_root and information.topics) then
		for cmd,info in pairs(information.topics) do
			GuildBook.AddData(cmd,info.tagline,info.content,_root,information.author)
		end
	end
end

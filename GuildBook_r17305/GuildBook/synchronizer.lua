-- here's the fun part
--
--[[ comm protocol attempt
	<Ham>'Hi', 'Main modified at <time>', 'Main timeUpdate <time>', 'time()'
	<Everyone>'Hello', 'Main modified at <time>', 'Main timeUpdate <time>', 'time()'
	< choose someone to sync with >
	<Ham>'Poke Bob'
	<Bob>'Prod Ham, main <update>, data = { ['<topic 1>'] = <stuff> }'
	< process information, <topic 1> in sync, <topic 2> is newer, <topic 3> is older >
	<Ham>'step to <topic 2>'
	<Bob>'stepped, <topic 2> <update>, data = { ['<topic 1>'] = <stuff> }'
	< process information, >
	
--]]--
--
-- for speedy lookups
local string = string
local pairs = pairs
local tremove = table.remove
local tinsert = table.insert
local tsetn = table.setn
local tgetn = table.getn
local _debug = nil

local _updatingMe
local _updatingOther
local _eventFrame
local _timeOffsets = {}
local _cmds = { 
	['add'] = 1,
	['modify'] = 2, 
	['delete'] = 3,
	['login'] = 4,
	['loginresponse'] = 5,
	['syncStart'] = 6,
	['syncNode'] = 7,
	['syncNodeResp'] = 8,
	['stepDown'] = 9,
	['stepDownResp'] = 10,
	['stepUp'] = 11,
	['synchComplete'] = 12,
}

local _metro
local _tea
local _md5sum

local _cmdQue = {}
local _kbVersion = {}
local _peerPaths = {}
local _fullSynch = {}
local GuildBook = GuildBook
local _syncNode = nil
local _syncNodeExists = true
local _playerName = UnitName('player')

local _cmdTblStack = {} -- for keeping cmd tables in que
local _syncQue = {} -- for processing synchronization commands
local _queQue = {} -- for keeping track of tree traversal ques
local _treeSyncQue -- for immediate tree traversal ques
local _processNextTreeSync = false
local _tableStack = {}
local _isEnabled

GuildBookSynch = AceLibrary('AceAddon-2.0'):new('AceComm-2.0')

local function _free(tbl)
	for k,v in pairs(tbl) do
		tbl[k] = nil
	end
	tinsert(_tableStack,tbl)
	tsetn(tbl,0)
end

local function _getTbl() 
	return tremove(_tableStack) or {}
end

local function _cpyTbl(tbl)
	if (not tbl) then return end
	local nTbl = _getTbl()
	for k,v in pairs(tbl) do
		nTbl[k] = v
	end
	return nTbl
end

local function prepForSend(node,orig)
	local data = _getTbl()
	if (orig) then
		if (orig.name ~= node.name) then data.name = node.name end
		if (orig.tagline ~= node.tagline) then data.tagline = node.tagline end
		if (orig.content ~= node.content) then data.content = node.content end
		if (orig.editors ~= node.editors) then data.editors = node.editors end
		if (orig.hash2 ~= node.hash2) then data.hash2 = node.hash2 end
		if (orig.deleters ~= node.deleters) then data.deleters = node.deleters end
		if (orig.perms ~= node.perms) then data.perms = node.perms end
		if (orig.author ~= node.author) then data.author = node.author end
	else
		data.name = node.name
		data.tagline = node.tagline
		data.content = node.content
		data.viewers = node.viewers
		data.editors = node.editors
		data.deleters = node.deleters
		data.perms = node.perms
		data.author = node.author
		data.hash2 = node.hash2
	end
	data.path = node.path
	data.timestamp = node.timestamp
	data.timeUpdate = node.timeUpdate
	return data
end

function GuildBookSynch:OnInitialize()
	_metro = AceLibrary('Metrognome-2.0')
	_tea = AceLibrary('TEA-1.0')
	_md5sum = AceLibrary('MD5-1.0')
	self:SetCommPrefix("GBS")
	-- receive guild messages sent from other players with this addon
	_syncNode = GuildBook.TraverseTreePath('GuildBookKB>sync')
	_metro:Register('GuildBookSynch',GuildBookSynch.ProcessQue,0.1)
	self:RegisterComm(self.commPrefix,'GUILD','OnCommReceive')
	self:SetDefaultCommPriority('BULK')
	if (not _syncNode) then DEFAULT_CHAT_FRAME:AddMessage('No sync node') end
end

function GuildBookSynch:IsEnabled() return _isEnabled end

function GuildBookSynch:Disable() 
	_isEnabled = false 
	_metro:Stop('GuildBookSynch')
end

function GuildBookSynch:Enable() self.OnEnable(self) end

function GuildBookSynch:OnEnable()
	if (GuildBookOptions and GuildBookOptions.sync and GuildBookOptions.sync.enabled) then
		GuildBookSynch:SendPrioritizedCommMessage('ALERT','GUILD',_cmds['login'],time())
		DEFAULT_CHAT_FRAME:AddMessage("GuildBook Synchronizer enabled")
		_metro:Start('GuildBookSynch')
		_isEnabled = true
	end
end

function GuildBookSynch:OnCommReceive(prefix,sender,distribution,cmd,dest,path,data)
	--if (sender == _playerName) then return end -- jump out if its me
	if (_debug) then DEFAULT_CHAT_FRAME:AddMessage(string.format('c=%s d=%s p=%s %s',cmd,dest or 'dest',tostring(path) or 'path',tostring(data) or 'data')) end
	if (cmd == _cmds['add']) then
		local oData = data
		data = _cpyTbl(oData)
		data.cmd = 'AddData'
		data.path = path
		data.sender = sender
		data.timestamp = data.timestamp - (_timeOffsets[sender] or 0)
		tinsert(_cmdQue,data)
	elseif (cmd == _cmds['delete']) then
		local oData = data
		data = _cpyTbl(data)
		data.cmd = 'RemData'
		data.sender = sender
		data.path = path
		data.timestamp = data.timestamp - (_timeOffsets[sender] or 0)
		tinsert(_cmdQue,data)
	elseif (cmd == _cmds['modify']) then
		if (_debug) then DEFAULT_CHAT_FRAME:AddMessage("Added something to the cmdQue") end
		local oData = data
		data = _cpyTbl(data)
		data.cmd ='ModData'
		data.sender = sender
		data.path = path
		data.timestamp = data.timestamp - (_timeOffsets[sender] or 0)
		tinsert(_cmdQue,data)
	elseif (cmd == _cmds['login']) then
		_timeOffsets[sender] = dest - time()
		GuildBookSynch:SendPrioritizedCommMessage('ALERT','GUILD',_cmds['loginresponse'],sender,time(),GuildBookKB['objects']['sync']['timeUpdate'] or time())
		--GuildBookSynch:SendCommMessage('GUILD',_cmds['loginresponse'],'',time(),GuildBookKB['objects']['sync']['timeUpdate'] or time())
	elseif (cmd == _cmds['loginresponse']) then
		_timeOffsets[sender] = path - time()
		data = data - (_timeOffsets[sender] or 0)
		if (GuildBookKB['objects'] and GuildBookKB['objects']['sync']) then
			if (data ~= GuildBookKB['objects']['sync']['timeUpdate']) then
				-- we have different data
				GuildBookSynch:SendCommMessage('GUILD',_cmds['syncStart'])
			else
				-- we have the same data
				GuildBookSynch:SendCommMessage('GUILD',_cmds['synchComplete'])
				_fullSynch[UnitName('player')] = true
			end
		end
	elseif (cmd == _cmds['syncStart']) then
		--if (not _fullSynch[_playerName]) then return end -- don't respond if we don't have the most up to date info
		_peerPaths[sender] = "GuildBookKB>sync"
		local node = GuildBook.TraverseTreePath(_peerPaths[sender])
		local data = _getTbl()
		if (node['objects']) then
			for name,tbl in pairs(node['objects']) do
				data[string.format("GB%s",name)] = tbl['timeUpdate']
			end
		end
		data['timestamp'] = node['timestamp']
		data['timeUpdate'] = node['timeUpdate']
		data['process'] = true
		data['dest'] = sender
		data['resppath'] = _peerPaths[sender]
		data['cmd'] = 'stepDownResp'
		_syncQue[sender] = data
	elseif (cmd == _cmds['syncNode']) then
		local node = GuildBook.TraverseTreePath(path)
		if (not data or data['timestamp'] < node['timestamp']) then
			data = prepForSend(node,data)
			data['dest'] = sender
			data['process'] = true
			data['cmd'] = 'syncNodeResp'
			data['resppath'] = path
			if (_syncQue[sender]) then _free(_syncQue[sender]) end
			_syncQue[sender] = data
		else
			if (data['timestamp'] > node['timestamp']) then
				GuildBookSynch:ModifyNode(path,data)
			end
			data = _syncQue[sender] or _getTbl()
			data['dest'] = sender
			data['process'] = true
			data['cmd'] = 'syncNodeResp'
			data['resppath'] = path
			_syncQue[sender] = data
		end
	elseif (cmd == _cmds['syncNodeResp']) then
		if (_syncQue[dest]) then _syncQue[dest]['process'] = false end
		if (dest == _playerName) then
			local node = GuildBook.TraverseTreePath(path)
			if (data and data['timestamp'] and ((node and node.timestamp and data['timestamp'] > node['timestamp']) or not node)) then
				GuildBookSynch:ModifyNode(path,data)
			end
			_processNextTreeSync = true
		end
	elseif (cmd == _cmds['stepDown']) then
		if (not _fullSynch[_playerName]) then return end -- don't respond if we don't have the most up to date info
		_peerPaths[sender] = _peerPaths[sender]..'>'..dest
		local node = GuildBook.TraverseTreePath(_peerPaths[sender])
		local data = _getTbl()
		if (node['objects']) then
			for name,tbl in pairs(node['objects']) do
				data[string.format("GB%s",name)] = tbl['timeUpdate']
			end
		end
		data['timestamp'] = node['timestamp']
		data['process'] = true
		data['dest'] = sender
		data['cmd'] = 'stepDownResp'
		_syncQue[sender] = data
	elseif (cmd == _cmds['stepDownResp']) then
		if (_syncQue[dest]) then _syncQue[dest]['process'] = false end
		if (dest == _playerName) then
			local path = GuildBook.GetTreePath(_syncNode)
			local tmpQue,delNodeQue,addNodeQue
			if (_debug) then DEFAULT_CHAT_FRAME:AddMessage(string.format('stepDownResp: %s',tostring(data))) end
			for k,v in pairs(data) do
				if (_debug) then DEFAULT_CHAT_FRAME:AddMessage(string.format('stepDownResp: %s',tostring(k))) end
				_,_,name = string.find(k,"^GB(.+)$")
				if (name) then -- we found a node
					if (not _syncNode['objects'] or not _syncNode['objects'][name]) then
						addNodeQue = addNodeQue or _getTbl()
						tinsert(addNodeQue,string.format("%s>%s",path,name))
					elseif (data[k] ~= _syncNode['objects'][name]['timeUpdate']) then
						tmpQue = tmpQue or _getTbl()
						tinsert(tmpQue,name)
					end
				end
			end
			if (_syncNodeExists and _syncNode and _syncNode['objects']) then
				for k,v in pairs(_syncNode['objects']) do
					if (not data[string.format("GB%s",k)]) then
						delNodeQue = delNodeQue or _getTbl()
						tinsert(delNodeQue,string.format("%s>%s",path,k))
					end
				end
			end
			if (tmpQue) then
				tinsert(_queQue,_treeSyncQue)
				_treeSyncQue = tmpQue
				_treeSyncQue.cmd = 'stepDown'
				_processNextTreeSync = true
			else
				if (tgetn(_queQue) == 0) then -- if there are no more steps, we must be in sync.
					GuildBookSynch:SendCommMessage('GUILD',_cmds['synchComplete'])
					_processNextTreeSync = false
				else -- we're not in sync, keep syncing
					GuildBookSynch:SendCommMessage('GUILD',_cmds['stepUp'])
					_treeSyncQue = table.remove(_queQue)
					_processNextTreeSync = true
				end
			end
			if (not _syncNode['timestamp']) then
				_processNextTreeSync = false
				GuildBookSynch:SendCommMessage('GUILD',_cmds['syncNode'],path,nil)
			elseif (not data['timestamp']) then
				_processNextTreeSync = false
				local tmpNode = prepForSend(_syncNode)
				GuildBookSynch:SendCommMessage('GUILD',_cmds['syncNode'],path,tmpNode)
				_free(tmpNode)
			elseif (_syncNode['timestamp'] < data['timestamp']) then
				GuildBookSynch:SendCommMessage('GUILD',_cmds['syncNode'],path,nil)
			elseif (_syncNode['timestamp'] > data['timestamp']) then
				local tmpNode = prepForSend(_syncNode)
				GuildBookSynch:SendCommMessage('GUILD',_cmds['syncNode'],path,tmpNode)
				_free(tmpNode)
			end
			if (delNodeQue) then
				tinsert(_queQue,_treeSyncQue)
				_treeSyncQue = delNodeQue
				_treeSyncQue.cmd = ''
			end
		end
	elseif (cmd == _cmds['stepUp']) then
		_,_,_peerPaths[sender] = string.find(_peerPaths[sender],"^(.-)>.+$")
	elseif (cmd == _cmds['synchComplete']) then
		_fullSynch[sender] = true
	end
end

function GuildBookSynch:AddData(node,path)
	local data = prepForSend(node)
	data.path = path
	if (_debug) then
		DEFAULT_CHAT_FRAME:AddMessage(string.format("Path is: %s",tostring(path)))
	end
	GuildBookSynch:SendCommMessage('GUILD',_cmds['add'],'',path,data)
	_free(data)
end

function GuildBookSynch:ModifyData(node)
	local path = GuildBook.GetTreePath(node)
	local node = prepForSend(node)
	GuildBookSynch:SendCommMessage('GUILD',_cmds['modify'],'',path,node)
	_free(node)
end

function GuildBookSynch:ModifyNode(path,data)
	local node = GuildBook.GetTreePath(path)
	if (not node) then -- we don't have this node
		_,_,path = string.find(path,'^(.+)>.-$') -- get the parent node
		node = GuildBook.GetTreePath(path)
		GuildBook.AddData(data.name,data.tagline,data.content,node,data.author,data.timestamp - _timeOffsets[data['sender']],
							data.editors,data.deleters,data.perms)
	else
		node.content = data.content or node.content
		node.tagline = data.tagline or node.tagline
		node.editors = data.editors or node.editors
		node.deleters = data.deleters or node.deleters
		node.timestamp = data.timestamp - _timeOffsets[data['sender']]
		node.author = data.author or node.author
		node.perms = data.perms or node.perms
	end
	local parent = node.parent
	while (parent and parent['synch']) do
		parent['timeUpdate'] = math.max(node.timestamp,parent['timeUpdate'])
		parent = parent['parent']
	end
end

function GuildBookSynch:RemData(node)
	local path = GuildBook.GetTreePath(node)
	GuildBookSynch:SendCommMessage('GUILD',_cmds['delete'],'',path)
end

function GuildBookSynch:ProcessQue()
	local data,cmd,fnc,resp
	if (tgetn(_cmdQue) > 0) then
	-- process 5 items
		for i=1,5 do
			data = tremove(_cmdQue)
			cmd = data.cmd
			if (_debug) then DEFAULT_CHAT_FRAME:AddMessage(string.format('ProcessQue: %s %s %s',tostring(data.cmd),tostring(data.sender),tostring(data))) 
				if (DevTools_Dump) then DevTools_Dump(data) end
			end
			if (cmd == 'AddData') then
				-- data is all the stuff we need, check to see if the player can see this data, and that the sender can create it
		--function GuildBook.AddData(name,tagline,content,parent,author,timestamp,viewers,editors,deleters)
					local parent = GuildBook.TraverseTreePath(data.path)
					GuildBook.AddData(data.name,data.tagline,data.content,parent,data.author,data.timestamp,data.editors,data.deleters)
			elseif (cmd == 'RemData') then
				local node = GuildBook.TraverseTreePath(data.path)
				-- make sure the sender can delete
				if (GuildBook.NameCanDelete(data.sender,node)) then
					GuildBook.RemData(node)
				end
			elseif (cmd == 'ModData') then
				if (_debug) then DEFAULT_CHAT_FRAME:AddMessage(string.format('ModData: %s %s %s',data.cmd,tostring(data.sender),tostring(data))) end
				local node = GuildBook.TraverseTreePath(data.path)
				-- make sure the sender can edit
				if (GuildBook.NameCanEdit(data.sender,node)) then
					GuildBook.ModifyData(node,data.name,data.tagline,data.content,data.author,data.timestamp,data.editors,data.deleters)
				end
			end
			_free(data)
			if (tgetn(_cmdQue) < 1) then 
				break
			end
		end
	end
	for dest,data  in pairs(_syncQue) do
		if (data['process']) then
			resp = data
			break
		end
	end
	if (resp) then
		if (_debug) then DEFAULT_CHAT_FRAME:AddMessage(string.format('Sending: %s %s %s %s',resp['cmd'],resp['dest'] or 'dest',resp['resppath'] or 'resppath',type(resp))) end
		GuildBookSynch:SendCommMessage('GUILD',_cmds[resp['cmd']],resp['dest'],resp['resppath'],resp)
		_free(resp)
		resp = nil
	end
	if (_treeSyncQue and _processNextTreeSync) then
		_processNextTreeSync = false
		local tNode = tremove(_treeSyncQue)
		if (_syncNode['objects'] and _syncNode['objects'][tNode]) then
			_syncNode = _syncNode['objects'][tNode]
			GuildBookSynch:SendCommMessage('GUILD',_cmds['stepDown'],tNode)
		else -- new node doesn't exist...
			local path = GuildBook.GetTreePath(_syncNode)
			path = path..">"..tNode
			tinsert(_treeSyncQue,1,tNode)
			GuildBookSynch:SendCommMessage('GUILD',_cmds['syncNode'],'',path,nil)
		end
	end
end

function GuildBookSynch:ComputeHash(nodeOrString)
	if (not nodeOrString) then return end
	if (type(nodeOrString) == 'string') then return _md5sum:MD5(nodeOrString) end
	if (type(nodeOrString) == 'table') then return _md5sum:MD5(string.format('%s%s%s',node.content or '',node.tagline or '',node.author or '')) end
end

--[[
Notes by Andersen, Silvermoon
use /notes to show the GUI

]]--

--[[
Table of Contents:
A) Variables
B) Notes Selection Functions
C) Notes Note Functions
D) LUA Functions
E) UI Update Functions
F) UI Functions
G) Sync Functions
H) Notes Sorting Functions
I) General Tools Functions
J) Dropdown UI Functions
K) Book UI Functions
]]--

--function p(m) Notes_Print(m) end
--function t(m) return Notes_DataToString(m) end
 
------------------------------------------
-- A) Variables

Notes_Notes = {}
Notes_Import = {}

Notes_Selected = nil
Notes_MultiSelect = {}

local Notes_Undo = {}
local Notes_SelectedAtLastUpdate = nil
local Notes_MultiSelectCountAtLastUpdate = 0
local Notes_LoadID = nil
local Notes_BookID = nil
local Notes_BookPages = {}
local Notes_BookPage = 0
local Notes_TotalPages = 0
local Notes_TOCPageData = {};

local Notes_LastUpdateTime = nil
local Notes_PrintMinLength=15
local Notes_PrintMaxLength=180
local Notes_PrintMaxChunkLength=220

local Notes_PrintMinInterval=1
Notes_PrintMaxInterval=12
local Notes_PrintInterval = Notes_PrintMaxInterval


local Notes_PrintCache = {}
local Notes_CacheIndex = 1
local Notes_Listening = {}
local Notes_ListenStack = {}
local Notes_ListenBook = {}

local Notes_LUASetupNote = {"LUA - Start Up","--Notes LUA Setup READ ME.\n\n--[[Notes can organize and execute multiple LUA scripts.  This setup file should help a new Notes user take advantage of Notes's LUA functionality.  Keep in mind that you must press the Run LUA button on this note when you start WoW and every time you make a change if you want to use the LUA functions defined here.  Unlock this note to modify it.\n\nEntering LUA mode: type /lua or /noteslua\nRunning LUA notes in macros: In LUA mode, any selected note will display text that you can copy and paste into a macro.  This uses the RunNote() function.]]--\n\n--[[OnEvent commands: Uncomment the following function and register some events to run OnEvent commands. ]]--\n\n\n--NotesEvents:RegisterEvent('CHAT_MSG_WHISPER')\n--Notes_OnEvent = function()\n--	doEventStuff()\n--end\n\n\n--[[OnUpdate commands: Uncomment the following function and register some events to run OnEvent commands. ]]--\n\n\n--Notes_OnUpdate = function()\n--	doUpdateStuff()\n--end\n\n"}

local Notes_TitleLen = 25
local Notes_DescrLen = 25
local Notes_TOCTitleLen = 30
local Notes_ColorNormal = {1,.82,0}
local Notes_ColorSync = {.7,1,.3}
local Notes_ColorLocked = {.52,.52,.52}
local Notes_ColorSyncLocked = {.4,.5,.7}
local Notes_ColorBook = {1,.5,.1}
local Notes_ColorBookSync = {1,.1,0}
local Notes_ColorBookLocked = {.52,.52,.52}
local Notes_ColorBookSyncLocked = {.6,0,.4}

Notes_IconDrag = false
Notes_IconPos = {nil,nil}

Notes_CommMode = false
Notes_CommSpeedMode = false
Notes_LUAMode = false
Notes_ExportMode = false
Notes_ShowIcon = 1
Notes_SelectedComm = 1
Notes_SelectedChan = 1

Notes_ChanList = {}
local Notes_CommModes = {
	{"Guild",	function(msg) ChatThrottleLib:SendChatMessage("NORMAL","",msg,"GUILD") end, 
			function() return Notes_InGuild() end,
			"GUILD",
			function() return "Guild" end,
			function(sender) return Notes_InGuild(sender) end},
			
	{"Party",	function(msg) ChatThrottleLib:SendChatMessage("NORMAL","",msg,"PARTY") end, 
			function() return (Notes_InParty() and not Notes_InRaid()) or (Notes_InRaid() and (IsRaidLeader() or IsRaidOfficer())) end,
			"PARTY",
			function() return "Party" end,
			function(sender) return Notes_InParty(sender) end},

	{"Raid",	function(msg) Notes_RaidPrint(msg) end, 
			function() return Notes_InRaid() and (IsRaidLeader() or IsRaidOfficer()) end,
			"RAID",
			function() return "Raid" end,
			function(sender) return Notes_InRaid(sender) end},

	{"RaidWarning",	function (msg) ChatThrottleLib:SendChatMessage("NORMAL","",msg,"RAID_WARNING") end, 
			function() return Notes_InRaid() and (IsRaidLeader() or IsRaidOfficer()) end,
			"RAID",
			function() return "RaidWarning" end,
			function(sender) return Notes_InRaid(sender) end},

	{"Battleground",function(msg) ChatThrottleLib:SendChatMessage("NORMAL","",msg,"BATTLEGROUND") end, 
			function() return Notes_InBattlefield() end,
			"RAID",
			function() return "Battleground" end,
			function(sender) return Notes_InRaid(sender) end},

	{"Say",		function(msg) ChatThrottleLib:SendChatMessage("NORMAL","",msg,"SAY") end, 
			function() return true end,
			nil,
			function() return "Say" end,
			function() return nil end},
			
	{"Self",	function(msg) Notes_Print(msg) end, 
			function() UnitName("target") return true end,
			nil,
			function() return "Self" end,
			function() return nil end},
			
	{"Target",	function(msg) ChatThrottleLib:SendChatMessage("NORMAL","",msg,"WHISPER",GetDefaultLanguage("player"),UnitName("target")) end, 
			function() return UnitName("target") and UnitIsPlayer("target") end,
			"WHISPER",
			function() return UnitName("target") end,
			function(tar) return Notes_InGuild(sender) or Notes_InRaid(sender) end},
			
	{"Whisper",	function(msg,tar) ChatThrottleLib:SendChatMessage("NORMAL","",msg,"WHISPER",GetDefaultLanguage("player"),tar) end, 
			function() local text=NotesWhisperEditBox:GetText() return text and strlen(text)>0 end,
			"WHISPER",
			function() local text=NotesWhisperEditBox:GetText() if strlen(text)>0 then return text end end,
			function(sender,tar) return (Notes_InGuild(sender) or Notes_InRaid(sender)) and tar==strlower(UnitName("player")) end},
			
	{"Channel",	function(msg,chan) 
			if not chan then return end
			local index = GetChannelName(chan) 
			if index ~= nil and index ~= 0 then 
				ChatThrottleLib:SendChatMessage("NORMAL","",msg,"CHANNEL",GetDefaultLanguage("player"),index)
			end end, 
			function() return true end,"CHANNEL",
			function() if Notes_ChanList[Notes_SelectedChan] then return Notes_ChanList[Notes_SelectedChan][2] end end,
			function(sender,chan) return (Notes_InGuild(sender) or Notes_InRaid(sender)) and Notes_InTable(Notes_ChanList,chan,3) end}
	}
	
-- Binding Variables
BINDING_HEADER_NOTESHEADER = "Notes";
BINDING_NAME_NOTESTOGGLE = "Toggle Notes";
BINDING_NAME_NOTESICONTOGGLE = "Toggle Notes Map Icon";
	
------------------------------------------
-- B) Notes Selection Functions
--[[
Notes_ToggleSelected - Register that we've selected a new note
Notes_SortAndReselect - Wrapper for Notes_SortNotes that fixes the selection after sorting
Notes_SortNotes - Alphabetize the notes
]]--
function Notes_ToggleSelected(button)
	local dirtyflag = nil
	
	if button ~= nil then
		local num = button
		if getglobal(button) then
			num = tonumber(strsub(button,-1))
		end
		local toselect = num + FauxScrollFrame_GetOffset(NotesNoteScrollBar)		
		
		if Notes_Selected and type(Notes_Notes[Notes_Selected]["book"])~="string" and IsShiftKeyDown() then
			local idx = Notes_InTable(Notes_MultiSelect,toselect)
			if toselect == Notes_Selected and getn(Notes_MultiSelect) > 0 then
				Notes_Selected = Notes_MultiSelect[getn(Notes_MultiSelect)]
				table.remove(Notes_MultiSelect,getn(Notes_MultiSelect))
				
			elseif idx then
				table.remove(Notes_MultiSelect,idx)
				dirtyflag = true
				
			else
				local tar = num + FauxScrollFrame_GetOffset(NotesNoteScrollBar)
				local start,finish
				if Notes_Selected <= tar then
					start = Notes_Selected
					finish = tar-1
				else
					start = tar+1
					finish = Notes_Selected
				end
				
				for i=start,finish do
					if not Notes_InTable(Notes_MultiSelect,i) then
						table.insert(Notes_MultiSelect,i)
					end
				end
				Notes_Selected = num + FauxScrollFrame_GetOffset(NotesNoteScrollBar)
			end
			
		elseif Notes_Selected and type(Notes_Notes[Notes_Selected]["book"])~="string" and IsControlKeyDown() then
			local idx = Notes_InTable(Notes_MultiSelect,toselect)
			if toselect == Notes_Selected and getn(Notes_MultiSelect) > 0 then
				Notes_Selected = Notes_MultiSelect[getn(Notes_MultiSelect)]
				table.remove(Notes_MultiSelect,getn(Notes_MultiSelect))
				
			elseif idx then
				table.remove(Notes_MultiSelect,idx)
				dirtyflag = true
				
			else
				table.insert(Notes_MultiSelect,Notes_Selected)
				Notes_Selected = num + FauxScrollFrame_GetOffset(NotesNoteScrollBar)
			end
		
		else
			Notes_MultiSelect = {}
			Notes_Selected = toselect
		end		
	else
		Notes_MultiSelect = {}
		Notes_Selected = nil
		Notes_LoadID = nil
		Notes_BookID = nil
		Notes_BookPages = {}
		Notes_BookPage = 0
		Notes_SelectedAtLastUpdate = nil			
	end
	
	Notes_LoadSelected()
	Notes_ScrollBarUpdate(dirtyflag)
end

function Notes_SortAndReselect(mids)
	Notes_FixHiddenPages()
	Notes_SortNotes()
	
	if mids and getn(mids) > 0 then
		Notes_MultiSelect = {}
		for i=1,getn(mids) do
			midx = Notes_GetNoteIndex(mids[i])
			if midx then
				table.insert(Notes_MultiSelect,midx)
			end
		end	
	end
	
	Notes_Selected = Notes_GetNoteIndex(Notes_LoadID)
	
	if Notes_Selected and Notes_BookPage == 0 then
		local tarscroll = (tonumber(Notes_Selected)-1)*16
		local minscroll = (0+FauxScrollFrame_GetOffset(NotesNoteScrollBar))*16
		local maxscroll = (4+FauxScrollFrame_GetOffset(NotesNoteScrollBar))*16
		local offset = nil
		
		if tarscroll < minscroll then
			offset = -2
		elseif tarscroll > maxscroll then
			offset = -4
		end		
		
		if offset then
			NotesNoteScrollBarScrollBar:SetValue((tonumber(Notes_Selected)+offset)*16)
		end
	end
end

function Notes_SortNotes()
	table.sort(Notes_Notes,Notes_HashNatTitleSort)
	Notes_ScrollBarUpdate()
end

------------------------------------------
-- C) Notes Note Functions
--[[
Notes_MakeNoteID - Make a new random ID
Notes_NewNote - Create a new note
Notes_SaveNote - Save new data entered in the UI to the table
Notes_CopySelected - Duplicate the selected
Notes_LoadSelected - Load the selected note into the edit buffer
Notes_LoadEmpty - Empty the edit buffer
Notes_DeleteSelected - wrapper for Notes_DeleteAndRebuild
Notes_DeleteAndRebuild - Remove a note from the table
Notes_RevertSelected - Revert changes to the selected note to the last time the UI was shown
Notes_PrepUndo - Populate the undo table with the correct data.
Notes_SyncSelected - Mark the selected note as sync for syncing purposes
Notes_LockedSelected - Lock the selected note
Notes_CompileOrExtractSelected - Master control switch for compiling/extracting from notebooks
Notes_CompileSelected - Compile the selected notes into a book/add notes into an existing book
Notes_ExtractSelected - Extract a page from a book and rebuild the book's index
]]--

function Notes_MakeNoteID()
	return time()..random(1000)
end

function Notes_NewNote(title,text,sync,locked,id,book,bookname,overwrite,syncoverwrite)
	if title == nil or title == "" then title = Notes_FindNextInSequence("New Note #1") end
	if text == nil then text = "" end
	if id == nil then id = Notes_MakeNoteID() end
	if sync == nil then sync = false end
	if locked == nil then locked = false end
	if book == nil or (type(book)~="string" and type(book)~="table") then book = false end
	if overwrite == nil then overwrite = false end
	if syncoverwrite == nil then syncoverwrite = false end
	
	local newNote = {}
	newNote["title"] = title
	newNote["text"] = text
	newNote["id"] = id
	newNote["sync"] = sync
	newNote["locked"] = locked
	newNote["book"] = book
	
	local newUndoNote = {}
	newUndoNote["title"] = title
	newUndoNote["text"] = text
	newUndoNote["id"] = id
	newUndoNote["sync"] = sync
	newUndoNote["locked"] = locked
	newUndoNote["book"] = book
	newUndoNote["undo"] = false
		
	local oldidx = Notes_GetNoteIndex(id)
	if oldidx then
		if not overwrite then return 2-- Print "tried to overwrite existing note?"
		else
		
			if Notes_Notes[oldidx]["locked"] then
				return 2
				
			elseif syncoverwrite and not Notes_Notes[oldidx]["sync"] then
				return 1
			
			else
				Notes_Notes[oldidx]["title"] = newNote["title"]
				Notes_Notes[oldidx]["text"] = newNote["text"]
				Notes_Notes[oldidx]["sync"] = newNote["sync"]
				Notes_Notes[oldidx]["locked"] = newNote["locked"]
				Notes_Notes[oldidx]["book"] = newNote["book"]
				if Notes_Selected == oldidx then
					Notes_LoadSelected()
				end
			end
		end
	else
		table.insert(Notes_Notes,newNote)
	end
	
	Notes_Undo[newNote["id"]] = newUndoNote
		
	if not overwrite then 
		Notes_Selected = Notes_GetNoteIndex(newNote["id"])
		Notes_MultiSelect = {}
		Notes_LoadSelected()
	end
		
	local bookidx = nil
	if type(book) == "string" then 
		bookidx = Notes_GetNoteIndex(book)
		if not bookidx then
			if not bookname then bookname = Notes_FindNextInSequence("New Book #1") end				
			Notes_NewNote(bookname,"",false,false,book,{id})
		else
			table.insert(Notes_Notes[bookidx]["book"],id)
			Notes_MultiSelect = {}
			Notes_LoadSelected(bookidx)
		end
	end	
	
	Notes_SortAndReselect()
	Notes_ScrollBarUpdate()
	return 0
end

function Notes_SaveNote()
	local title = NotesTitleEditBox:GetText()
	local text = NotesTextEditBox:GetText()
		
	if not Notes_Selected then
		if strlen(title) > 0 or strlen(text) > 0 then 
			Notes_NewNote(title,text)
			return
			
		elseif strlen(title) == 0 and strlen(text) == 0 then
			return
		end
	end
	
	local isbook = type(Notes_Notes[Notes_Selected]["book"]) == "table"
	local bookidx = Notes_GetNoteIndex(Notes_BookID)
	local booklock = not isbook and bookidx and Notes_Notes[bookidx]["locked"]
	
	if Notes_Notes[Notes_Selected]["locked"] or booklock then
		NotesTitleEditBox:SetText(Notes_Notes[Notes_Selected]["title"])
		
		if isbook then Notes_CreateIndexPage() --NotesTextEditBox:SetText(Notes_CreateIndexPage(text))
		else NotesTextEditBox:SetText(Notes_Notes[Notes_Selected]["text"]) end
		return		
	end
	
	Notes_Notes[Notes_Selected]["title"] = title
	if isbook then Notes_CreateIndexPage() --NotesTextEditBox:SetText(Notes_CreateIndexPage(text))
	else Notes_Notes[Notes_Selected]["text"] = text end
	
	if Notes_Undo[Notes_LoadID]["undo"] == false then	
	   if(strlen(Notes_Undo[Notes_LoadID]["title"]) ~= strlen(Notes_Notes[Notes_Selected]["title"]) or
	    strlen(Notes_Undo[Notes_LoadID]["text"]) ~= strlen(Notes_Notes[Notes_Selected]["text"])) then
	    	Notes_Undo[Notes_LoadID]["undo"] = true
	end end	
	
	Notes_ScrollBarUpdate()
end

function Notes_CopySelected(idx,midx)
	local index = Notes_Selected
	local mindex = Notes_MultiSelect
	if idx then index = idx end	
	if midx then mindex = midx end
	
	if not index or not Notes_Notes[index] then return end

	local mids = {}
	if not idx then
		for i=1,getn(mindex) do
			table.insert(mids,Notes_Notes[mindex[i]]["id"])
		end
	end
	
	if type(Notes_Notes[index]["book"]) ~= "table" then		
		local copyNote = {}
		copyNote["title"] = Notes_FindNextInSequence(Notes_Notes[index]["title"].." Copy #1")
		copyNote["text"] = Notes_Notes[index]["text"]
		copyNote["id"] = Notes_MakeNoteID()
		copyNote["sync"] = Notes_Notes[index]["sync"]
		copyNote["locked"] = Notes_Notes[index]["locked"]
		
		for i=1,getn(Notes_Notes) do
			if Notes_Notes[i]["id"] == copyNote["id"] then
				return
			end
		end
	
		table.insert(Notes_Notes,copyNote)
	
		Notes_Undo[copyNote["id"]] = copyNote
		Notes_Undo[copyNote["id"]]["undo"] = false
	end
	
	if not idx then
	
		if getn(mindex) > 0 then
			for i=1,getn(mindex) do
				Notes_CopySelected(mindex[i])
			end
		end
		
		Notes_SortAndReselect(mids)
		Notes_ScrollBarUpdate()
	end
end

function Notes_LoadSelected(idx)
	local index = Notes_Selected
	if idx then index = idx end
	
	if not index or not Notes_Notes[index] then return Notes_LoadEmpty() end
		
	if type(Notes_Notes[index]["book"])=="table" then
		Notes_BookID = Notes_Notes[index]["id"]
		Notes_BookPages = Notes_Notes[index]["book"]
		Notes_BookPage = 0
				
		Notes_CreateIndexPage()
		NotesTitleEditBox:SetText(Notes_Notes[index]["title"])
		Notes_LoadID = Notes_Notes[index]["id"]		
	else
		NotesTextEditBox:SetText(Notes_Notes[index]["text"])
		NotesTitleEditBox:SetText(Notes_Notes[index]["title"])
		Notes_LoadID = Notes_Notes[index]["id"]
	
		if type(Notes_Notes[index]["book"])~="string" then
			Notes_BookID = nil
			Notes_BookPage = 0		
			Notes_BookPages = {}
		else
			Notes_MultiSelect = {}
		end
	end
		
	Notes_SortAndReselect()
	Notes_ScrollBarUpdate()
end

function Notes_LoadEmpty()
	Notes_MultiSelect = {}
	Notes_Selected = nil
	Notes_LoadID = nil
	Notes_BookID = nil
	Notes_BookPages = {}
	Notes_BookPage = 0
	Notes_SelectedAtLastUpdate = nil
	
	NotesTextEditBox:SetText("")
	NotesTitleEditBox:SetText("")
	
	NotesTOC:Hide()
	NotesText:Show()
	
	Notes_SortAndReselect()
	Notes_ScrollBarUpdate()
end

function Notes_RevertSelected()
	if Notes_Selected and Notes_Undo[Notes_LoadID]["undo"] == true then
	
		Notes_Notes[Notes_Selected]["title"] = Notes_Undo[Notes_LoadID]["title"]
		Notes_Notes[Notes_Selected]["text"] = Notes_Undo[Notes_LoadID]["text"]
		Notes_Notes[Notes_Selected]["sync"] = Notes_Undo[Notes_LoadID]["sync"]
		Notes_Notes[Notes_Selected]["locked"] = Notes_Undo[Notes_LoadID]["locked"]
		Notes_Notes[Notes_Selected]["book"] = Notes_Undo[Notes_LoadID]["book"]
		Notes_Undo[Notes_LoadID]["undo"] = false
		
		Notes_LoadSelected()
		
		Notes_SortAndReselect()
		Notes_ScrollBarUpdate()		
	end
end

function Notes_PrepUndo()
	Notes_TotalPages = 0
	Notes_Undo = {}
	for i=1,getn(Notes_Notes) do
		Notes_Undo[Notes_Notes[i]["id"]]={}
		Notes_Undo[Notes_Notes[i]["id"]]["id"] = Notes_Notes[i]["id"]
		Notes_Undo[Notes_Notes[i]["id"]]["title"] = Notes_Notes[i]["title"]
		Notes_Undo[Notes_Notes[i]["id"]]["text"] = Notes_Notes[i]["text"]
		Notes_Undo[Notes_Notes[i]["id"]]["sync"] = Notes_Notes[i]["sync"]
		Notes_Undo[Notes_Notes[i]["id"]]["locked"] = Notes_Notes[i]["locked"]
		Notes_Undo[Notes_Notes[i]["id"]]["book"] = Notes_Notes[i]["book"]
		Notes_Undo[Notes_Notes[i]["id"]]["undo"] = false			
	end
end

function Notes_FixHiddenPages()
	Notes_TotalPages = 0
	for i=1,getn(Notes_Notes) do		
		if type(Notes_Notes[i]["book"]) == "string" then
			Notes_TotalPages = Notes_TotalPages + 1
		end		
	end
end

function Notes_SyncSelected(idx,midx)
	local index = Notes_Selected
	local mindex = Notes_MultiSelect
	if idx then index = idx end	
	if midx then mindex = midx end

	if not index or not Notes_Notes[index] then return end

	local ispage = type(Notes_Notes[index]["book"]) == "string"
	local bookidx = Notes_GetNoteIndex(Notes_BookID)
	local booksync = ispage and bookidx and Notes_Notes[bookidx]["sync"]
	local booklock = ispage and bookidx and Notes_Notes[bookidx]["locked"]
	
	if booksync and not Notes_Notes[index]["sync"] then
		Notes_Notes[index]["sync"] = 1
	else
		Notes_Notes[index]["sync"] = NotesSyncCheckButton:GetChecked()
	end
		
	if not idx then
		if getn(mindex) > 0 then
			for i=1,getn(mindex) do
				Notes_SyncSelected(mindex[i])
			end
		end		
		Notes_ScrollBarUpdate(1)
	end
end

function Notes_LockedSelected(idx,midx)
	local index = Notes_Selected
	local mindex = Notes_MultiSelect
	if idx then index = idx end	
	if midx then mindex = midx end
	
	if not index or not Notes_Notes[index] then return end

	local ispage = type(Notes_Notes[index]["book"]) == "string"
	local bookidx = Notes_GetNoteIndex(Notes_BookID)
	local booklock = ispage and bookidx and Notes_Notes[bookidx]["locked"]
	
	if booklock then
		NotesLockedCheckButton:SetChecked(1) --SetChecked(Notes_Notes[index]["locked"])
	else
		Notes_Notes[index]["locked"] = NotesLockedCheckButton:GetChecked()
	end
	
	if not idx then
		if not booklock and getn(mindex) > 0 then
			for i=1,getn(mindex) do
				Notes_LockedSelected(mindex[i])
			end
		end
		Notes_ScrollBarUpdate(1)
	end
end

function Notes_DeleteSelected(idx,midx)
	return Notes_DeleteAndRebuild(idx,midx)
end

function Notes_DeleteAndRebuild(idx,midx)
	local index = Notes_Selected
	local mindex = Notes_MultiSelect
	if idx then index = idx end	
	if midx then mindex = midx end
		
	if not index or not Notes_Notes[index] then return end
	
	local newmid = nil
	
	local deletestack = {}
	local selectstack = {}
	local newNotes_Notes = {}
	
	if not Notes_Notes[index]["locked"] then
		table.insert(selectstack,index)	
	end
	if getn(mindex) > 0 then
		for i=1,getn(mindex) do
			if not Notes_Notes[mindex[i]]["locked"] then
				table.insert(selectstack,mindex[i])
			end
		end
	end
	
	for i=1,getn(selectstack) do
		if type(Notes_Notes[selectstack[i]]["book"])=="table" then
			if getn(Notes_Notes[selectstack[i]]["book"]) > 0 then
				for j=1,getn(Notes_Notes[selectstack[i]]["book"]) do
					local pageidx = Notes_GetNoteIndex(Notes_Notes[selectstack[i]]["book"][j])
					if pageidx then
						if not Notes_Notes[pageidx]["locked"] then 
							table.insert(deletestack,pageidx) 
							Notes_TotalPages = Notes_TotalPages - 1
						else
							Notes_Notes[pageidx]["book"] = false
							
							if not newmid or type(newmid) == "string" then newmid = {} end
							table.insert(newmid,Notes_Notes[pageidx]["id"])
						end
					end
				end
			end			
			table.insert(deletestack,selectstack[i])
		
		elseif type(Notes_Notes[selectstack[i]]["book"])=="string" then
			local curidx, newidx = Notes_ExtractSelected(selectstack[i])
			if newidx and not newmid then
				newmid = Notes_Notes[newidx]["id"]
			end
			table.insert(deletestack,curidx)
		else
			table.insert(deletestack,selectstack[i])	
		end
	end
		
	for i=1,getn(Notes_Notes) do
		if not Notes_InTable(deletestack,i) then
			table.insert(newNotes_Notes,Notes_Notes[i])
		end	
	end

	Notes_Notes = newNotes_Notes
	
	if type(newmid)=="string" then
		local lid = Notes_GetNoteIndex(newmid)
		if lid then
			Notes_LoadSelected(lid)
		else
			Notes_LoadEmpty()
		end
		
	elseif type(newmid)=="table" then

		Notes_LoadSelected(Notes_GetNoteIndex(newmid[1]))
		if getn(newmid) > 1 then
			Notes_MultiSelect = {}
			for i=2,getn(newmid) do
				local mulidx = Notes_GetNoteIndex(newmid[i])
				if mulidx then table.insert(Notes_MultiSelect,mulidx) end
			end
		end
	else
		Notes_LoadEmpty()
	end
	Notes_ScrollBarUpdate(1)
end

function Notes_CompileOrExtractSelected(idx,midx)
	local index = Notes_Selected
	local mindex = Notes_MultiSelect
	if idx then index = idx end	
	if midx then mindex = midx end
	
	if not index then return end
	
	local selectstack = {}

	if type(Notes_Notes[index]["book"])=="table" and getn(mindex) == 0 then
		for i=getn(Notes_Notes[index]["book"]),1,-1 do
			local page = Notes_GetNoteIndex(Notes_Notes[index]["book"][i])
			table.insert(selectstack,Notes_Notes[page]["id"])
			if page then Notes_ExtractSelected(page) end
		end

		if getn(selectstack) > 0 then
			if getn(selectstack) > 1 then
				for i=2,getn(selectstack) do
					local page = Notes_GetNoteIndex(selectstack[i])
					table.insert(Notes_MultiSelect,page)
				end
			end
			Notes_LoadSelected(Notes_GetNoteIndex(selectstack[1]))
		end
		
	elseif type(Notes_Notes[index]["book"])=="string" then
		Notes_LoadSelected(Notes_ExtractSelected())
	else
		Notes_CompileSelected()
	end
	

	Notes_SortAndReselect()
	Notes_ScrollBarUpdate(1)
end

function Notes_CompileSelected(idx,midx)
	local index = Notes_Selected
	local mindex = Notes_MultiSelect
	if idx then index = idx end	
	if midx then mindex = midx end
	
	if not index then return end	

	local selectstack = {}
	local pagestack = {}
	local idstack = {}
	
	local targetbook = nil
	local deletebooks = {}
	
	table.insert(selectstack,index)	
	if getn(mindex) > 0 then
		for i=1,getn(mindex) do
			table.insert(selectstack,mindex[i])
		end
	end
		
	table.sort(selectstack,Notes_HashNatNotesTitleSort)	
	
	for i=1,getn(selectstack) do
		if type(Notes_Notes[selectstack[i]]["book"])=="table" and getn(Notes_Notes[selectstack[i]]["book"]) > 0 then
			for j=1,getn(Notes_Notes[selectstack[i]]["book"]) do
				local pageidx = Notes_GetNoteIndex(Notes_Notes[selectstack[i]]["book"][j])
				if pageidx then 
					table.insert(pagestack,pageidx)
					table.insert(idstack,Notes_Notes[pageidx]["id"])
				end
			end
			if targetbook == nil and getn(deletebooks) == 0 then
				targetbook = Notes_Notes[selectstack[i]]["id"]
				
			else
				if targetbook ~= nil then
					table.insert(deletebooks,targetbook)
					targetbook = nil
				end
				table.insert(deletebooks,Notes_Notes[selectstack[i]]["id"])
			end
		
		elseif type(Notes_Notes[selectstack[i]]["book"])~="string" then
			table.insert(pagestack,selectstack[i])	
			table.insert(idstack,Notes_Notes[selectstack[i]]["id"])
		end
	end
	
	
	if targetbook then
		local bookidx = Notes_GetNoteIndex(targetbook)
		if bookidx then 
			for i=1,getn(selectstack) do
				local booktype = type(Notes_Notes[selectstack[i]]["book"])
				Notes_Notes[selectstack[i]]["book"] = Notes_Notes[bookidx]["id"]
			end			
			
			Notes_Notes[bookidx]["book"] = idstack
			Notes_Selected = bookidx
			Notes_LoadSelected()
			Notes_MultiSelect = {}
			return
		end
	end
	
	local bookid = Notes_MakeNoteID()
	
	for i=1,getn(selectstack) do
		Notes_Notes[selectstack[i]]["book"] = bookid
	end

	Notes_MultiSelect = {}
	if getn(deletebooks) > 0 then
		for i=1,getn(deletebooks) do
			local bookidx = Notes_GetNoteIndex(deletebooks[i])
			if bookidx then
				Notes_Notes[bookidx]["book"] = false
				Notes_Notes[bookidx]["locked"] = false
				Notes_DeleteAndRebuild(bookidx)
			end
		end
	end	
	Notes_NewNote(Notes_FindNextInSequence("New Book #1"),"",false,false,bookid,idstack)
end

function Notes_ExtractSelected(idx)
	local index = Notes_Selected
	if idx then index = idx end
		
	if not index then return end	

	local loadid = Notes_LoadID
	local bookidx = Notes_GetNoteIndex(Notes_BookID)
	Notes_Notes[index]["book"] = false
	
	if bookidx then
		local contents = {}
		for i=1,getn(Notes_Notes[bookidx]["book"]) do
			if Notes_Notes[bookidx]["book"][i] ~= Notes_Notes[index]["id"] then
				table.insert(contents,Notes_Notes[bookidx]["book"][i])
			else
				Notes_TotalPages = Notes_TotalPages - 1
			end
		end

		if getn(contents) > 0 then
			Notes_Notes[bookidx]["book"] = contents
			if Notes_BookPage > getn(contents) then
				Notes_BookPage = Notes_BookPage - 1 
			end

			return Notes_GetNoteIndex(loadid), Notes_GetNoteIndex(contents[Notes_BookPage])			
		else
			Notes_Notes[bookidx]["book"] = false
			Notes_Notes[bookidx]["locked"] = false
			Notes_DeleteAndRebuild(bookidx)
			return Notes_GetNoteIndex(loadid)
		end
	end
end

------------------------------------------
-- D) LUA Functions
--[[
Notes_ExecuteSelected - Execute the selected LUA script note
RunNote - wrapper for Notes_RunNote
Notes_RunNote - Execute a LUA script note by passing a note id
Notes_AddLUASetupNote - Add the default LUA setup note
]]--

function Notes_ExecuteSelected(idx)
	local index = Notes_Selected
	if idx then index = idx end
		
	if not index then return end
	
	RunScript(Notes_Notes[index]["text"])
end

function RunNote(noteid)
	return Notes_RunNote(noteid)
end

function Notes_RunNote(noteid)
	local idx = Notes_GetNoteIndex(tostring(noteid))
	if idx ~= nil then Notes_ExecuteSelected(idx) else
	Notes_ErrorPrint("Note ID ["..noteid.."] not found") end
end

function Notes_AddLUASetupNote()
	Notes_NewNote(Notes_LUASetupNote[1],Notes_LUASetupNote[2],false,false,"1","2","Notes LUA Book")
end

------------------------------------------
-- E) UI Update Functions
--[[
Notes_SetButtonState - Update the Button UI status
Notes_ScrollBarUpdate - Update the graphics for the notes navigation system
Notes_GetColor - Get the proper color for a note's title
]]--

function Notes_SetButtonState(fullupdate)
	if not NotesFrame:IsVisible() then return end

	if Notes_Selected and Notes_Notes[Notes_Selected] then
		if Notes_Selected ~= Notes_SelectedAtLastUpdate or 
		   Notes_MultiSelectCountAtLastUpdate ~= getn(Notes_MultiSelect) or fullupdate then
			Notes_SelectedAtLastUpdate = Notes_Selected
			Notes_MultiSelectCountAtLastUpdate = getn(Notes_MultiSelect)
		
			NotesLockedCheckButton:SetChecked(Notes_Notes[Notes_Selected]["locked"])
			NotesCompileButton:Enable()
			NotesExecuteButton:Enable()		
			NotesSyncCheckButton:Enable()
			NotesSyncCheckButtonText:SetText("Sync")											
			NotesSyncCheckButton:SetCheckedTexture("Interface/Buttons/UI-CheckBox-Check")
			NotesSyncCheckButton:SetChecked(Notes_Notes[Notes_Selected]["sync"])		
			NotesLockedCheckButtonText:SetText("Locked")											
			NotesLockedCheckButton:Enable()
			NotesLockedCheckButtonText:SetTextColor(Notes_ColorNormal[1],Notes_ColorNormal[2],Notes_ColorNormal[3])
			NotesCommSendButton:SetText("Print Note")								
			NotesGoPageButton:SetText("Index")								
				
			NotesTOC:Hide()
			NotesText:Show()			
			
			local isbook = type(Notes_Notes[Notes_Selected]["book"]) == "table"
			local bookidx = Notes_GetNoteIndex(Notes_BookID)
			local booksync = not isbook and bookidx and Notes_Notes[bookidx]["sync"]			
			local booklock = not isbook and bookidx and Notes_Notes[bookidx]["locked"]
						
			local unlockcount = 0
			local notecount = 0
						
			if not Notes_Notes[Notes_Selected]["locked"] then
				unlockcount = unlockcount + 1
			end
			if type(Notes_Notes[Notes_Selected]["book"]) ~= "table" then
				notecount = notecount + 1
			end
			for i=1,getn(Notes_MultiSelect) do
				if not Notes_Notes[Notes_MultiSelect[i]]["locked"] then
					unlockcount = unlockcount + 1
				end
				if type(Notes_Notes[Notes_MultiSelect[i]]["book"]) ~= "table" then
					notecount = notecount + 1
				end
			end			
						
			if isbook then 
				Notes_BookUIToggle("show")
				NotesSyncCheckButton:Enable()
				NotesSyncCheckButtonText:SetTextColor(Notes_ColorBookSync[1],Notes_ColorBookSync[2],Notes_ColorBookSync[3])
				NotesLockedCheckButton:Enable()
				NotesReorderPageButton:Disable()
				NotesCurPageNumText:Show()
				NotesCurPageNumText:SetText(Notes_BookPage)
				NotesPageSlash:Show()
				NotesPageLabel:Show()
				NotesMaxPageNumText:Show()
				NotesMaxPageNumText:SetText(getn(Notes_Notes[bookidx]["book"]))	
				NotesCommSendButton:SetText("Print Book")				
				NotesGoPageButton:SetText("Go to")
												
				NotesTOC:Show()
				NotesText:Hide()
				
				NotesPrevPageButton:Disable()
				NotesNextPageButton:Enable()
				NotesPrevPageButtonText:SetTextColor(Notes_ColorLocked[1],Notes_ColorLocked[2],Notes_ColorLocked[3])	
				NotesNextPageButtonText:SetTextColor(Notes_ColorNormal[1],Notes_ColorNormal[2],Notes_ColorNormal[3])
				
				if getn(Notes_MultiSelect) > 0 then					
					NotesCompileButton:SetText("Compile")
				else
					NotesCompileButton:SetText("Extract All")
					if Notes_Notes[Notes_Selected]["locked"] then NotesCompileButton:Disable() end
				end									
			else
				if not Notes_Notes[Notes_Selected]["sync"] and booksync then
					NotesSyncCheckButton:SetChecked(1)
					NotesSyncCheckButton:SetCheckedTexture("Interface/Buttons/UI-CheckBox-Check-Disabled")
					NotesSyncCheckButtonText:SetText("Book Sync")
				end
											
				if Notes_BookID and type(Notes_Notes[Notes_Selected]["book"]) == "string" then
					Notes_BookPages = Notes_Notes[bookidx]["book"]

					local pages = getn(Notes_BookPages)
					Notes_BookUIToggle("show")
					NotesCompileButton:SetText("Extract")
					NotesReorderPageButton:Enable()
					NotesCurPageNumText:Show()
					NotesCurPageNumText:SetText(Notes_BookPage)
					NotesPageSlash:Show()
					NotesPageLabel:Show()
					NotesMaxPageNumText:Show()
					NotesMaxPageNumText:SetText(pages)
	
					if Notes_BookPage <= 0 then
						NotesPrevPageButton:Disable()
						NotesNextPageButton:Enable()
						NotesPrevPageButtonText:SetTextColor(Notes_ColorLocked[1],Notes_ColorLocked[2],Notes_ColorLocked[3])	
						NotesNextPageButtonText:SetTextColor(Notes_ColorNormal[1],Notes_ColorNormal[2],Notes_ColorNormal[3])	
						
					elseif Notes_BookPage >= pages then
						NotesPrevPageButton:Enable()
						NotesNextPageButton:Disable()
						NotesPrevPageButtonText:SetTextColor(Notes_ColorNormal[1],Notes_ColorNormal[2],Notes_ColorNormal[3])	
						NotesNextPageButtonText:SetTextColor(Notes_ColorLocked[1],Notes_ColorLocked[2],Notes_ColorLocked[3])
					else						
						NotesPrevPageButton:Enable()
						NotesNextPageButton:Enable()
						NotesPrevPageButtonText:SetTextColor(Notes_ColorNormal[1],Notes_ColorNormal[2],Notes_ColorNormal[3])	
						NotesNextPageButtonText:SetTextColor(Notes_ColorNormal[1],Notes_ColorNormal[2],Notes_ColorNormal[3])	
					end
				else 
					Notes_BookUIToggle("hide")
					NotesCompileButton:SetText("Compile")
				end
			end			
			
			if notecount > 0 then NotesDuplicateButton:Enable()
			else NotesDuplicateButton:Disable() end

			local synccolor = Notes_ColorSync
			local synclockcolor = Notes_ColorSyncLocked						
			if type(Notes_Notes[Notes_Selected]["book"]) == "table" then
				synccolor = Notes_ColorBookSync
				synclockcolor = Notes_ColorBookSyncLocked
			end
			
			if notecount > 0 then NotesDuplicateButton:Enable() end
						
			if unlockcount == 0 or booklock then								
				NotesSyncCheckButtonText:SetTextColor(synclockcolor[1],synclockcolor[2],synclockcolor[3])				
				NotesDeleteButton:Disable()
				if booklock then
					NotesLockedCheckButton:SetChecked(1)
					NotesLockedCheckButton:Disable()
					NotesLockedCheckButtonText:SetText("Book Locked")
					NotesLockedCheckButtonText:SetTextColor(Notes_ColorLocked[1],Notes_ColorLocked[2],Notes_ColorLocked[3])				
				end
				if not Notes_Notes[Notes_Selected]["sync"] and booksync then
					NotesSyncCheckButtonText:SetText("Book Broadcast Only")
				else
					NotesSyncCheckButtonText:SetText("Broadcast Only")
				end
			else 
				NotesSyncCheckButton:Enable()
				NotesSyncCheckButtonText:SetTextColor(synccolor[1],synccolor[2],synccolor[3])
				NotesDeleteButton:Enable()
			end
				
			if Notes_CommModes[Notes_SelectedComm][3]() then NotesCommSendButton:Enable()
			else NotesCommSendButton:Disable() end
		end
	else
		NotesCompileButton:Disable()
		NotesDeleteButton:Disable()
		NotesDuplicateButton:Disable()	
		NotesExecuteButton:Disable()
		NotesMacroEditBox:SetText("")
		NotesMacroEditBox:Hide()
		NotesPrintMacroEditBox:SetText("")
		NotesPrintMacroEditBox:Hide()
		NotesSyncCheckButton:Disable()
		NotesSyncCheckButton:SetChecked(false)
		NotesSyncCheckButtonText:SetTextColor(Notes_ColorLocked[1],Notes_ColorLocked[2],Notes_ColorLocked[3])
		NotesLockedCheckButton:Disable()
		NotesLockedCheckButton:SetChecked(false)
		NotesLockedCheckButtonText:SetTextColor(Notes_ColorLocked[1],Notes_ColorLocked[2],Notes_ColorLocked[3])	
		NotesCommSendButton:Disable()				
		NotesTOC:Hide()
		NotesText:Show()			
		Notes_BookUIToggle("hide")
	end
	
	if getn(Notes_PrintCache) > 0 then NotesStopPrintButton:Enable()
	else NotesStopPrintButton:Disable() end
	
	if Notes_LoadID and Notes_Undo[Notes_LoadID] and Notes_Undo[Notes_LoadID]["undo"] == true and 
	   Notes_Selected and Notes_Notes[Notes_Selected] and not Notes_Notes[Notes_Selected]["locked"] then 
	   	NotesUndoButton:Enable()
	else NotesUndoButton:Disable()end
	
	if fullupdate then
		if Notes_CommMode then
			NotesCommButton:SetNormalTexture("Interface/ChatFrame/UI-ChatIcon-Chat-Down")
			ShowUIPanel(NotesCommFrame)
		
			NotesLuaFrame:ClearAllPoints()
			NotesLuaFrame:SetPoint("TOP",NotesCommFrame,"BOTTOM",0,4)
			
			UIDropDownMenu_SetSelectedValue(NotesCommDropDown, Notes_SelectedComm)
			UIDropDownMenu_SetSelectedValue(NotesChanSelectDropDown, Notes_SelectedChan)
			if Notes_CommModes[Notes_SelectedComm][1] == "Whisper" then 
				NotesWhisperEditBox:Show() 
			else 
				NotesWhisperEditBox:Hide() 
			end
			
			if Notes_CommModes[Notes_SelectedComm][1] == "Channel" then 
				UIDropDownMenu_Initialize(NotesChanSelectDropDown, Notes_ChanSelectDropDownInitialize)
				UIDropDownMenu_SetSelectedValue(NotesChanSelectDropDown, Notes_SelectedChan)
				NotesChanSelectDropDown:Show() 
			else 
				NotesChanSelectDropDown:Hide() 
			end
			
			if Notes_CommSpeedMode then
				NotesCommSpeedCheckButton:SetChecked(1)
				NotesCommFrame:SetHeight(70)
				NotesCommSpeedSlider:Show()
				NotesCommSpeedSlider:SetValue(Notes_PrintMaxInterval)
				
				if Notes_PrintMaxInterval == 0 then
					NotesCommSpeedLabel:SetText("Max Delay: [Off]")						
				elseif Notes_PrintMaxInterval == 4 then
					NotesCommSpeedLabel:SetText("Max Delay: [Very Short]")							
				elseif Notes_PrintMaxInterval == 8 then
					NotesCommSpeedLabel:SetText("Max Delay: [Short]")						
				elseif Notes_PrintMaxInterval == 12 then
					NotesCommSpeedLabel:SetText("Max Delay: [Medium]")						
				elseif Notes_PrintMaxInterval == 16 then
					NotesCommSpeedLabel:SetText("Max Delay: [Long]")						
				elseif Notes_PrintMaxInterval == 20 then
					NotesCommSpeedLabel:SetText("Max Delay: [Very Long]")
				end
			else
				NotesCommSpeedCheckButton:SetChecked(0)
				NotesCommFrame:SetHeight(50)
				NotesCommSpeedSlider:Hide()
			end
		else
			NotesCommButton:SetNormalTexture("Interface/ChatFrame/UI-ChatIcon-Chat-Up")
			HideUIPanel(NotesCommFrame)
			
			NotesLuaFrame:ClearAllPoints()
			NotesLuaFrame:SetPoint("TOP",NotesCommFrame,"TOP",0,0)
		end
	end
	
	if Notes_CommMode then
		if Notes_Selected then
			local target = Notes_CommModes[Notes_SelectedComm][5]()
			local str = "/PrintNote "..Notes_Notes[Notes_Selected]["id"]
			if target then str = str.." "..target end
			NotesPrintMacroEditBox:SetText(str)
			NotesPrintMacroEditBox:Show()
		end
	end		
		
	if Notes_LUAMode then
		NotesLUACheckButton:SetChecked(1)
		ShowUIPanel(NotesLuaFrame)
		
		if Notes_GetNoteIndex("1") then NotesLUASetupButton:Disable()
		else NotesLUASetupButton:Enable() end
		
		

		if Notes_Selected then
			NotesMacroEditBox:SetText("/RunNote "..Notes_Notes[Notes_Selected]["id"])
			NotesMacroEditBox:Show()
		end
	else
		NotesLUACheckButton:SetChecked(nil)
		HideUIPanel(NotesLuaFrame)
	end
	
	if getglobal("NotesExportFrame") then 
		if Notes_LUAMode then
			NotesExportFrame:ClearAllPoints()
			NotesExportFrame:SetPoint("TOP",NotesLuaFrame,"BOTTOM",0,4)
		else
			NotesExportFrame:ClearAllPoints()
			NotesExportFrame:SetPoint("TOP",NotesLuaFrame,"TOP",0,0)		
		end
	
		if Notes_ExportMode then			
			NotesExportCheckButton:SetChecked(1)
			ShowUIPanel(NotesExportFrame)
			
			NotesImportButton:SetText("Import ["..getn(Notes_Import).."] Notes")
			if getn(Notes_Import) == 0 then NotesImportButton:Disable()
			else NotesImportButton:Enable()	end
	
			if Notes_Selected then NotesExportButton:Enable()
			else NotesExportButton:Disable() end
		else
			NotesExportCheckButton:SetChecked(nil)
			NotesExportFrame:Hide()
			HideUIPanel(NotesExportFrame)
		end
	end
	
	if Notes_ShowIcon then
		NotesIconCheckButton:SetChecked(1)
		ShowUIPanel(NotesIconFrame)
	else
		NotesIconCheckButton:SetChecked(nil)
		HideUIPanel(NotesIconFrame)
	end
end

function Notes_ScrollBarUpdate(fullupdate)
	local line -- 1 through 5 of our window to scroll
  	local lineplusoffset -- an index into our data calculated from the scroll offset

	FauxScrollFrame_Update(NotesNoteScrollBar,getn(Notes_Notes)-Notes_TotalPages,5,16)
  	for line=1,5 do
    		lineplusoffset = line + FauxScrollFrame_GetOffset(NotesNoteScrollBar)
    		if lineplusoffset <= getn(Notes_Notes) then
			local title = Notes_Notes[lineplusoffset]["title"]
			local descr = ""
			
			if type(Notes_Notes[lineplusoffset]["book"]) == "table" then
				local pages = getn(Notes_Notes[lineplusoffset]["book"])
				getglobal("NotesNote"..line.."_BookIcon"):Show()
				getglobal("NotesNote"..line.."_BookIcon"):SetTexture("Interface/Icons/INV_Misc_Book_0"..(mod(Notes_Notes[lineplusoffset]["id"],8)+1))
				title = "     "..title
				descr = pages.." Page"
				if pages ~= 1 then descr = descr.."s" end
			else
				getglobal("NotesNote"..line.."_BookIcon"):Hide()
				descr = string.gsub(gsub(Notes_Notes[lineplusoffset]["text"],"\n"," "),"%s+"," ")
				local olddescr = descr
				if descr ~= nil then
					descr = strsub(descr,0,Notes_DescrLen)
			  		if strlen(olddescr) > Notes_DescrLen then
						descr = descr.."..."
					end
				end				
			end
			
			local oldtitle = title
			if title ~= nil then
				title = strsub(title,0,Notes_TitleLen)
			  	if strlen(oldtitle) > Notes_TitleLen then
					title = title.."..."
				end
			end			
			
			if Notes_Selected == lineplusoffset then
				getglobal("NotesNote"..line.."NTex"):SetDesaturated(0)
				getglobal("NotesNote"..line.."NTex"):SetAlpha(1)
			elseif getn(Notes_MultiSelect) > 0 and Notes_InTable(Notes_MultiSelect,lineplusoffset) then
				getglobal("NotesNote"..line.."NTex"):SetDesaturated(0)
				getglobal("NotesNote"..line.."NTex"):SetAlpha(.4)
			elseif Notes_BookID and Notes_GetNoteIndex(Notes_BookID) == lineplusoffset then
				getglobal("NotesNote"..line.."NTex"):SetDesaturated(1)
				getglobal("NotesNote"..line.."NTex"):SetAlpha(1)
			else
				getglobal("NotesNote"..line.."NTex"):SetDesaturated(0)
				getglobal("NotesNote"..line.."NTex"):SetAlpha(0)
			end
			
			if type(Notes_Notes[lineplusoffset]["book"]) == "string" then
				getglobal("NotesNote"..line):Hide()
			else
				local textcolor = Notes_GetColor(lineplusoffset)
			
				getglobal("NotesNote"..line.."_Text"):SetTextColor(textcolor[1],textcolor[2],textcolor[3])
      				getglobal("NotesNote"..line.."_Text"):SetText(title)
      				getglobal("NotesNote"..line.."_Description"):SetText(descr)
      				getglobal("NotesNote"..line):Show()
			end
    		else
      			getglobal("NotesNote"..line):Hide()
    		end
  	end
	Notes_SetButtonState(fullupdate)
end

function Notes_GetColor(index)
	if type(index) == "string" then
		local num = index
		if getglobal(index) then
			num = tonumber(strsub(index,-1))
			index = num + FauxScrollFrame_GetOffset(NotesNoteScrollBar)		 
		end		
	end
	
	local color = Notes_ColorNormal
	if Notes_Notes[index] then
		if Notes_Notes[index]["sync"] then
			color = Notes_ColorSync
		end
		if Notes_Notes[index]["locked"] then
			color = Notes_ColorLocked
		end
		if Notes_Notes[index]["sync"] and Notes_Notes[index]["locked"] then
			color = Notes_ColorSyncLocked
		end
		
		if type(Notes_Notes[index]["book"]) == "table" then
			color = Notes_ColorBook
			if Notes_Notes[index]["sync"] then
				color = Notes_ColorBookSync
			end
			if Notes_Notes[index]["locked"] then
				color = Notes_ColorBookLocked
			end
			if Notes_Notes[index]["sync"] and Notes_Notes[index]["locked"] then
				color = Notes_ColorBookSyncLocked
			end
		end
		
		if type(Notes_Notes[index]["book"]) == "string" then
			color = Notes_ColorLocked
		end
	end
	return color
end

------------------------------------------
-- F) UI Functions
--[[
Notes_OnLoad - Register Notes with the system
Notes_OnUpdate - This function's body is defined dynamically
Notes_OnEvent - This function's body is defined dynamically
Notes_UIToggle - Hide or show Notes
Notes_HideNotes - Clear the selection when Notes is hidden
Notes_BookUIToggle - Hide or show the book navigation panel
Notes_CommUIToggle - Hide or show the communications panel
Notes_LUAUIToggle - Hide or show the LUA panel
Notes_IconDragging - Drag the minimap button
]]--

function Notes_OnLoad()
	SlashCmdList["NOTES"] = Notes_UIToggle
	SLASH_NOTES1 = "/notes"
	SLASH_NOTES2 = "/note"
	
	SlashCmdList["RUNNOTES"] = Notes_RunNote
	SLASH_RUNNOTES1 = "/runnotes"
	SLASH_RUNNOTES2 = "/runnote"
	
	SlashCmdList["PRINTNOTES"] = Notes_PrintNote
	SLASH_PRINTNOTES1 = "/printnotes"
	SLASH_PRINTNOTES2 = "/printnote"
	SLASH_PRINTNOTES3 = "/print"
	
	SlashCmdList["STOPNOTES"] = Notes_StopPrinting
	SLASH_STOPNOTES1 = "/stopnotes"
	SLASH_STOPNOTES2 = "/stopnote"
	SLASH_STOPNOTES3 = "/stop"
	
	SlashCmdList["NOTESICONTOGGLE"] = Notes_IconToggle
	SLASH_NOTESICONTOGGLE1 = "/notesicon"
	
	SlashCmdList["NOTESDEBUG"] = Notes_Debug
	SLASH_NOTESDEBUG1 = "/notesdebug"

	NotesEvents:RegisterEvent('VARIABLES_LOADED')
	NotesEvents:RegisterEvent('RAID_ROSTER_UPDATE')
	NotesEvents:RegisterEvent('PLAYER_TARGET_CHANGED')

	NotesEvents:RegisterEvent('CHAT_MSG_ADDON')
	NotesEvents:RegisterEvent('CHAT_MSG_RAID')
	NotesEvents:RegisterEvent('CHAT_MSG_RAID_LEADER')
	NotesEvents:RegisterEvent('CHAT_MSG_PARTY')
	NotesEvents:RegisterEvent('CHAT_MSG_GUILD')
	NotesEvents:RegisterEvent('CHAT_MSG_WHISPER')
	NotesEvents:RegisterEvent('CHAT_MSG_CHANNEL')
	NotesEvents:RegisterEvent('CHAT_MSG_CHANNEL_LEAVE')
	
	Notes_Import = Notes_Export
end

function Notes_OnUpdate()
-- This function's body is defined dynamically
end

function Notes_OnEvent()
-- This function's body is defined dynamically
end

function Notes_Debug()
	RunScript("Notes_OnEvent = function() if arg1 == 'Notes' then Notes_Print(arg2) end end Notes_WarningPrint('Now printing sync debug info')")
end

function Notes_UIToggle(mode)
	if mode==nil or mode=="" then mode = "toggle" end

	if mode == "hide" or (mode=="toggle" and NotesFrame:IsVisible()) then
		Notes_HideNotes()
		
	elseif mode == "show" or mode=="toggle" then
		ShowUIPanel(NotesFrame)
		Notes_SetButtonState(1)
	end
end

function Notes_HideNotes()
	Notes_LoadEmpty()
	NotesFrame:Hide()
end

function Notes_BookUIToggle(mode)
	if mode==nil or mode=="" then mode = "toggle" end
	
	if mode == "hide" or (mode=="toggle" and NotesBookFrame:IsVisible()) then		
		NotesBookFrame:Hide()

		NotesCommFrame:ClearAllPoints()
		NotesCommFrame:SetPoint("TOP",NotesBookFrame,"TOP",0,0)
		
	elseif mode == "show" or mode=="toggle" then		
		NotesBookFrame:Show()

		NotesCommFrame:ClearAllPoints()
		NotesCommFrame:SetPoint("TOP",NotesBookFrame,"BOTTOM",0,4)
	end
end

function Notes_CommUIToggle(mode)
	if mode==nil or mode=="" then mode = "toggle" end
	
	if mode == "hide" or (mode=="toggle" and NotesCommFrame:IsVisible()) then
		Notes_CommMode = false
		Notes_SetButtonState(1)
		
		NotesLuaFrame:ClearAllPoints()
		NotesLuaFrame:SetPoint("TOP",NotesCommFrame,"TOP",0,0)
		
	elseif mode == "show" or mode=="toggle" then
		Notes_CommMode = true
		Notes_SetButtonState(1)		

		NotesLuaFrame:ClearAllPoints()
		NotesLuaFrame:SetPoint("TOP",NotesCommFrame,"BOTTOM",0,4)
	end	
end

function Notes_CommSpeedUIToggle(mode)
	if mode==nil or mode=="" then mode = "toggle" end
	
	if mode == "hide" or (mode=="toggle" and Notes_CommSpeedMode == true) then
		Notes_CommSpeedMode = false
		Notes_SetButtonState(1)
		
	elseif mode == "show" or mode=="toggle" then
		Notes_CommSpeedMode = true
		Notes_SetButtonState(1)
	end
end


function Notes_LUAUIToggle(mode)
	if mode==nil or mode=="" then mode = "toggle" end
	
	if mode == "hide" or (mode=="toggle" and NotesLuaFrame:IsVisible()) then
		Notes_LUAMode = false
		Notes_SetButtonState()	

		if getglobal("NotesExportFrame") then
			NotesExportFrame:ClearAllPoints()
			NotesExportFrame:SetPoint("TOP",NotesLuaFrame,"TOP",0,0)
		end
		
	elseif mode == "show" or mode=="toggle" then
		Notes_LUAMode = true
		Notes_SetButtonState()		

		if getglobal("NotesExportFrame") then
			NotesExportFrame:ClearAllPoints()
			NotesExportFrame:SetPoint("TOP",NotesLuaFrame,"BOTTOM",0,4)
		end
	end
end

function Notes_IconToggle(mode)
	if mode==nil or mode=="" then mode = "toggle" end
	
	if mode == "hide" or (mode=="toggle" and NotesIconFrame:IsVisible()) then
		Notes_ShowIcon = false
		Notes_SetButtonState()
		
	elseif mode == "show" or mode=="toggle" then
		Notes_ShowIcon = true
		Notes_SetButtonState()
	end
end

function Notes_IconMove(iconpos)
	if not Notes_IconDrag and not iconpos then return end
	
	local xpos,ypos
	if iconpos then 
		xpos = iconpos[1]
		ypos = iconpos[2]
	end
	
	if not xpos and not ypos then
		xpos,ypos = GetCursorPosition()
		local xmin,ymin = Minimap:GetLeft(), Minimap:GetBottom()

		xpos = xmin-xpos/Minimap:GetEffectiveScale()+70
		ypos = ypos/Minimap:GetEffectiveScale()-ymin-70

		local angle = math.deg(math.atan2(ypos,xpos)) or 0

		xpos = 80*cos(angle)
		ypos = 80*sin(angle)
		
		Notes_IconPos = {xpos,ypos}
	end
	
	NotesIconFrame:SetPoint("TOPLEFT","Minimap","TOPLEFT",52-xpos,ypos-52)
end

------------------------------------------
-- G) Sync Functions
--[[
Notes_PrintSelected - Load a note into the print cache for later parsing
Notes_AddToCache - Add a message chunk in to the print cache
Notes_SendNote - Do the actual printing of a message chunk
Notes_StopPrinting - Clear the current print cache and notify other clients to stop syncing
Notes_ParseCache - Stagger printing from the messages in the print cache
Notes_ListenEvent - Listen to raid chat for synchronizing notes
Notes_InitChannelList - Initialize the list of channels for syncing
]]--

function Notes_PrintNote(cmd)
	local args = Notes_Split(cmd," ")
	local idx = Notes_GetNoteIndex(tostring(args[1]))
	
	if not args[2] then args[2] = "Self" end
	
	if idx ~= nil then Notes_PrintSelected(idx,nil,args[2]) else
	Notes_ErrorPrint("Note ID ["..args[1].."] not found") end
end

function Notes_PrintSelected(idx,midx,chatmethod)
	local index = Notes_Selected
	local mindex = Notes_MultiSelect
	local method = Notes_SelectedComm
	if idx then index = idx end	
	if midx then mindex = midx end
	if chatmethod then method = chatmethod end
		
	if not index or not Notes_Notes[index] then return end
	
	local selectstack = {}	
	local printstack = {}	
	
	table.insert(selectstack,index)	
	if getn(mindex) > 0 then
		for i=1,getn(mindex) do
			table.insert(selectstack,mindex[i])
		end
	end
	
	for i=1,getn(selectstack) do
		if type(Notes_Notes[selectstack[i]]["book"])=="table" and getn(Notes_Notes[selectstack[i]]["book"]) > 0 then			
			
			table.insert(printstack,selectstack[i])
			for j=1,getn(Notes_Notes[selectstack[i]]["book"]) do
				local pageidx = Notes_GetNoteIndex(Notes_Notes[selectstack[i]]["book"][j])
				if pageidx then	table.insert(printstack,pageidx) end
			end
		
		elseif type(Notes_Notes[selectstack[i]]["book"])=="string" then
			table.insert(printstack,selectstack[i])
		else
			table.insert(printstack,selectstack[i])	
		end
	end	

	local curbookid = "nil"
	local curbookidx = nil
	local booksync = false
	local bookpages = 0
	local bookpage = 0
			
	for k=1,getn(printstack) do

		if type(Notes_Notes[printstack[k]]["book"]) == "table" then
			booksync = Notes_Notes[printstack[k]]["sync"]
			curbooktitle = Notes_Notes[printstack[k]]["title"]
			curbookid = Notes_Notes[printstack[k]]["id"]
			curbookidx = printstack[k]
			
			if booksync then
				bookpage = 0
				bookpages = getn(Notes_Notes[printstack[k]]["book"],",")
			end						
		else		
			local note = Notes_Notes[printstack[k]]["text"]
			local title = Notes_Notes[printstack[k]]["title"]
			local notelength = strlen(note)
			
			local notebits = Notes_Split(note,"\n")
			local startloc = getn(Notes_PrintCache)+1
			local curbooksync = false
			
			if type(Notes_Notes[printstack[k]]["book"]) == "string" then
				curbookid = Notes_Notes[printstack[k]]["book"]
				curbookidx = Notes_GetNoteIndex(Notes_Notes[printstack[k]]["book"])
				curbooktitle = Notes_Notes[curbookidx]["title"]
				curbooksync = Notes_Notes[curbookidx]["sync"]
			else
				curbookid = "nil"
				curbookidx = nil
				curbooktitle = nil
				curbooksync = nil
			end
			
			local sync = Notes_Notes[printstack[k]]["sync"] or curbooksync		

			if sync then
				Notes_AddToCache("<NOTE::"..title.."::"..Notes_Notes[printstack[k]]["id"].."::"..notelength.."::"..Notes_DataToString(curbookid).."::"..Notes_DataToString(curbooktitle),sync,nil,method,title)
				if booksync then
					if Notes_InTable(Notes_Notes[curbookidx]["book"],Notes_Notes[printstack[k]]["id"]) then
						bookpage = bookpage + 1 
					else
						Notes_ErrorPrint("Added the wrong page to the queue")
						Notes_StopPrinting()
					end
				end
			end
			
			for i=1,getn(notebits) do
				if notebits[i] == "" then 
					notebits[i] = " "
					notelength = notelength + 1
					if sync then
						Notes_AddToCache("<NOTE::"..title.."::"..Notes_Notes[printstack[k]]["id"].."::"..notelength.."::"..Notes_DataToString(curbookid).."::"..Notes_DataToString(curbooktitle),sync,startloc,method,title)
					end
				end
				
				if strlen(notebits[i]) <= Notes_PrintMaxChunkLength then
					Notes_AddToCache(notebits[i],sync,nil,method,title)
				else
					local notebitswords = Notes_Split(notebits[i]," ")
					local notebitsword = ""
					
					for j=1,getn(notebitswords) do
						local testword = notebitsword.." "..notebitswords[j]
						if strlen(testword) < Notes_PrintMaxChunkLength then
							notebitsword = testword
						else
							Notes_AddToCache(notebitsword,sync,nil,method,title)
							notebitsword = notebitswords[j]
		
							notelength = notelength + 1
							
							if sync then
								Notes_AddToCache("<NOTE::"..title.."::"..Notes_Notes[printstack[k]]["id"].."::"..notelength.."::"..Notes_DataToString(curbookid).."::"..Notes_DataToString(curbooktitle),sync,startloc,method,title)
							end
						end
					end
					Notes_AddToCache(notebitsword,sync,nil,method,title)
				end
			end
			
			if sync then
				Notes_AddToCache("<NOTE::END",sync,nil,method,title)
			end	
			
			if booksync then
				if bookpage >= bookpages then
					curbookid = "nil"
					curbookidx = nil
					curbooktitle = nil
					booksync = false
					bookpages = 0
					bookpage = 0				
				end
			end	
		end
	end
	Notes_SetButtonState()
end

function Notes_AddToCache(msg,sync,loc,chatmethod,title)
	local method = Notes_SelectedComm
	if not sync then sync = false end
	if chatmethod then method = chatmethod end
		
	local target = nil
	if type(method) == "string" then
		for i=1,getn(Notes_CommModes) do
			if strlower(Notes_CommModes[i][1]) == strlower(method) then 
				target = method
				method = i 
				break 
			end
		end
		if type(method) == "string" then
			target = method
			local index = GetChannelName(method)		
			if index ~= nil and index ~= 0 then method = 10
			else method = 9 end		
		end
	
	else
		if Notes_CommModes[method][1] == "Target" then 
			target = UnitName("target")
		end

		if Notes_CommModes[method][1] == "Whisper" then
			target = NotesWhisperEditBox:GetText()
		end
		
		if Notes_CommModes[method][1] == "Channel" then 
			target = Notes_ChanList[Notes_SelectedChan][2]
		end
	end	
	
	if not Notes_CommModes[method][3]() then return end
	
	if not loc then
		table.insert(Notes_PrintCache,{msg,method,target,sync,title})
	else
		Notes_PrintCache[loc] = {msg,method,target,sync,title}
	end
end

function Notes_SendNote(msg,method,target)
	if not method then method = 7 end	-- DEFAULT TO SELF
	
	if strsub(msg,1,7) == "<NOTE::" then
		msg = msg.."::"..method.."::"..Notes_DataToString(target)..">"
		if Notes_InGuild() then 
			ChatThrottleLib:SendAddonMessage("NORMAL","Notes",msg,"GUILD") 
		end
		if (Notes_InParty() and not Notes_InRaid()) or (Notes_InRaid() and (IsRaidLeader() or IsRaidOfficer())) then
			ChatThrottleLib:SendAddonMessage("NORMAL","Notes",msg,"RAID") 
		end
		if (Notes_InBattlefield()) then
			ChatThrottleLib:SendAddonMessage("NORMAL","Notes",msg,"BATTLEFIELD") 
		end
	else
		Notes_CommModes[method][2](msg,target)
	end
end

function Notes_StopPrinting()
	if Notes_PrintCache[Notes_CacheIndex][4] then
		Notes_SendNote("<NOTE::STOP",Notes_PrintCache[Notes_CacheIndex][2],Notes_PrintCache[Notes_CacheIndex][3])
	end

	Notes_WarningPrint("Printing halted for ["..Notes_PrintCache[Notes_CacheIndex][5].."]")

	Notes_PrintCache = {}
	Notes_CacheIndex = 1
	Notes_LastUpdateTime = nil
	Notes_PrintInterval = Notes_PrintMaxInterval
		
	Notes_SetButtonState()
end

function Notes_ParseCache()
	if getn(Notes_PrintCache) > 0 then	
		if not Notes_LastUpdateTime then
			Notes_LastUpdateTime = 0
		end
		
		local curtime = GetTime()
		if curtime-Notes_LastUpdateTime > Notes_PrintInterval then			
			if Notes_PrintCache[Notes_CacheIndex] ~= nil then
				Notes_SendNote(Notes_PrintCache[Notes_CacheIndex][1],Notes_PrintCache[Notes_CacheIndex][2],Notes_PrintCache[Notes_CacheIndex][3])
								
				if strsub(Notes_PrintCache[Notes_CacheIndex][1],1,7) == "<NOTE::" then
					Notes_PrintInterval=1 
				else
					Notes_PrintInterval=((Notes_PrintMaxInterval-Notes_PrintMinInterval)*
					  (strlen(Notes_PrintCache[Notes_CacheIndex][1])-Notes_PrintMinLength)/
					  (Notes_PrintMaxLength-Notes_PrintMinLength))+Notes_PrintMinInterval
				end
				  
				if Notes_PrintInterval < Notes_PrintMinInterval then Notes_PrintInterval = Notes_PrintMinInterval end
				if Notes_PrintInterval > Notes_PrintMaxInterval then Notes_PrintInterval = Notes_PrintMaxInterval end
				
				if not Notes_PrintCache[Notes_CacheIndex+1] or 
				   (Notes_PrintCache[Notes_CacheIndex+1] and Notes_PrintCache[Notes_CacheIndex+1][5] and 
				    Notes_PrintCache[Notes_CacheIndex+1][5] ~= Notes_PrintCache[Notes_CacheIndex][5]) then
					Notes_SuccessPrint("Printing finished for ["..Notes_PrintCache[Notes_CacheIndex][5].."]")
				end

				Notes_CacheIndex = Notes_CacheIndex + 1				
				Notes_LastUpdateTime = curtime				
			else

				Notes_PrintCache = {}
				Notes_CacheIndex = 1
				Notes_LastUpdateTime = nil
				Notes_PrintInterval = Notes_PrintMaxInterval
				Notes_SetButtonState()
			end
		end
	end
end

function Notes_ListenEvent()
	if event == "VARIABLES_LOADED" then
		Notes_InitChannelList()
		Notes_ChanSelectDropDownOnLoad()
		Notes_CommDropDownOnLoad()
		Notes_IconMove(Notes_IconPos)
		Notes_ScrollBarUpdate(1)
		
		if Notes_GetNoteIndex("1") then Notes_RunNote("1") end
	end
	
	if (event=="PLAYER_TARGET_CHANGED" or event == "RAID_ROSTER_UPDATE") then 
		Notes_SetButtonState(1)
	end
	
	if event == "CHAT_MSG_ADDON" and arg1 == "Notes" then
		parsebits = Notes_Split(strsub(arg2,0,-2),"::")
		
		if Notes_ListenStack[arg4] and parsebits[2] == "END" then
			if tonumber(strlen(strsub(Notes_ListenStack[arg4]["text"],0,-2))) == tonumber(Notes_ListenStack[arg4]["length"]) then
				local success = Notes_NewNote(Notes_ListenStack[arg4]["title"],strsub(Notes_ListenStack[arg4]["text"],0,-2),1,false,Notes_ListenStack[arg4]["id"],Notes_ListenStack[arg4]["bookid"],Notes_ListenStack[arg4]["bookname"],true,true)
				if success == 0 then 
					Notes_SuccessPrint("Sync successful for ["..Notes_ListenStack[arg4]["title"].."]")
				end
				
				Notes_SortAndReselect()
				Notes_ScrollBarUpdate()
			else
				Notes_ErrorPrint("Sync failed for ["..Notes_ListenStack[arg4]["title"].."]")
			end
			Notes_ListenStack[arg4] = nil
			
		elseif Notes_ListenStack[arg4] and parsebits[2] == "STOP" then
			Notes_ErrorPrint("Sync halted for ["..Notes_ListenStack[arg4]["title"].."] at request of "..arg4)
			Notes_ListenStack[arg4] = nil
		else
			if not Notes_ListenStack[arg4] and arg4 ~= UnitName("player") then
				if not tonumber(parsebits[7]) then return end

				local commtype = Notes_CommModes[tonumber(parsebits[7])][4]
				local commtarget = nil
				if parsebits[8] ~= "nil" then commtarget = strlower(parsebits[8]) end

				if commtype and Notes_CommModes[tonumber(parsebits[7])][6](arg4,commtarget) then
					Notes_ListenStack[arg4] = {}
					Notes_ListenStack[arg4]["title"] = parsebits[2]
					Notes_ListenStack[arg4]["id"] = parsebits[3]
					Notes_ListenStack[arg4]["length"] = parsebits[4]
					if parsebits[5] ~= "nil" and parsebits[6] ~= "nil" then
						Notes_ListenStack[arg4]["bookid"] = parsebits[5]
						Notes_ListenStack[arg4]["bookname"] = parsebits[6]
					end
					Notes_ListenStack[arg4]["commtype"] = commtype
					Notes_ListenStack[arg4]["commtarget"] = commtarget				
					Notes_ListenStack[arg4]["text"] = ""
				end
			end
		end
	end

	if strsub(event,1,9) == "CHAT_MSG_" and Notes_ListenStack[arg2] then
		local commtype = Notes_ListenStack[arg2]["commtype"]
		local commtarget = Notes_ListenStack[arg2]["commtarget"]
		
		local subevent = strsub(event,10)		
		if subevent == "RAID_LEADER" then subevent = "RAID" end
				
		if commtype == subevent then
			if (commtype ~= "CHANNEL" and commtype ~= "WHISPER") or 
			   (commtype == "CHANNEL" and commtarget and commtarget == strlower(arg9)) or
			   (commtype == "WHISPER" and commtarget and commtarget == strlower(UnitName("player"))) then			   	
				Notes_ListenStack[arg2]["text"] = Notes_ListenStack[arg2]["text"]..arg1.."\n"
			end
		
			if tonumber(strlen(strsub(Notes_ListenStack[arg2]["text"],0,-2))) > tonumber(Notes_ListenStack[arg2]["length"]) then				
				Notes_ErrorPrint("Sync failed for ["..Notes_ListenStack[arg2]["title"].."]")
				Notes_ListenStack[arg2] = nil
			end
		end
	end
end

function Notes_InitChannelList()
	Notes_ChanList = {}
	for i=1,10 do
		local id, name = GetChannelName(i)
		if id and id ~= 0 and name ~= nil then
			table.insert(Notes_ChanList,{id,name,strlower(name)})
		end
	end
end

------------------------------------------
-- H) Notes Sorting Functions
--[[
Notes_HashNatSort - Natural sorting for numbers that appear after the last # of the value
Notes_HashNatTitleSort - Natural sorting for numbers that appear after the last # of the value's title
Notes_FindNextInSequence - Find the next value in a sequence
Notes_FindLast - Reverse string search
]]--

function Notes_HashNatSort(a,b)
	local hashloca = Notes_FindLast(a,"#")
	local hashlocb = Notes_FindLast(b,"#")

	if not hashloca or not hashlocb then return a < b end

	local astr = strsub(a,0,hashloca)
	local bstr = strsub(b,0,hashlocb)

	if astr ~= bstr then return a < b end

	local anum = tonumber(strsub(a,hashloca+1))
	local bnum = tonumber(strsub(b,hashlocb+1))

	if not anum or not bnum then return a < b end

	return anum < bnum
end

function Notes_HashNatTitleSort(a,b)
	if type(a["book"]) == "table" and type(b["book"]) ~= "table" then return true end
	if not a["book"] and type(b["book"]) == "string" then return true end
	if type(b["book"]) == "table" and type(a["book"]) ~= "table" then return false end
	if not b["book"] and type(a["book"]) == "string" then return false end

	if a["title"] == b["title"] then return a["id"] < b["id"] end

	local hashloca = Notes_FindLast(a["title"],"#")
	local hashlocb = Notes_FindLast(b["title"],"#")

	if not hashloca or not hashlocb then return a["title"] < b["title"] end

	local astr = strsub(a["title"],0,hashloca)
	local bstr = strsub(b["title"],0,hashlocb)

	if astr ~= bstr then return a["title"] < b["title"] end

	local anum = tonumber(strsub(a["title"],hashloca+1))
	local bnum = tonumber(strsub(b["title"],hashlocb+1))

	if not anum or not bnum then return a["title"] < b["title"] end

	return anum < bnum
end

function Notes_HashNatNotesTitleSort(a,b)
	if type(Notes_Notes[a]["book"]) == "table" and type(Notes_Notes[b]["book"]) ~= "table" then return true end
	if not Notes_Notes[a]["book"] and type(Notes_Notes[b]["book"]) == "string" then return true end
	if type(Notes_Notes[b]["book"]) == "table" and type(Notes_Notes[a]["book"]) ~= "table" then return false end
	if not Notes_Notes[b]["book"] and type(Notes_Notes[a]["book"]) == "string" then return false end

	if Notes_Notes[a]["title"] == Notes_Notes[b]["title"] then return Notes_Notes[a]["id"] < Notes_Notes[b]["id"] end

	local hashloca = Notes_FindLast(Notes_Notes[a]["title"],"#")
	local hashlocb = Notes_FindLast(Notes_Notes[b]["title"],"#")

	if not hashloca or not hashlocb then return Notes_Notes[a]["title"] < Notes_Notes[b]["title"] end

	local astr = strsub(Notes_Notes[a]["title"],0,hashloca)
	local bstr = strsub(Notes_Notes[b]["title"],0,hashlocb)

	if astr ~= bstr then return Notes_Notes[a]["title"] < Notes_Notes[b]["title"] end

	local anum = tonumber(strsub(Notes_Notes[a]["title"],hashloca+1))
	local bnum = tonumber(strsub(Notes_Notes[b]["title"],hashlocb+1))

	if not anum or not bnum then return Notes_Notes[a]["title"] < Notes_Notes[b]["title"] end

	return anum < bnum
end

function Notes_FindNextInSequence(title) -- requires to be in the format: "TITLE #<num>"
	local titles = {}	
	local hashloc = Notes_FindLast(title,"#")
		
	local prefix = strsub(title,0,hashloc)
	local num = tonumber(strsub(title,hashloc+1))
		
	title = prefix..num
	
	for i=1,getn(Notes_Notes) do
		table.insert(titles,Notes_Notes[i]["title"])
	end
	table.sort(titles,Notes_HashNatSort)

	for i=1,getn(titles) do
		if titles[i] == title then
			num = num + 1
			title = prefix..num
		end
	end
	return title
end

function Notes_FindLast(haystack,needle)
	local loc = string.find(haystack,needle)
	i=1
	while loc do
		local testloc = string.find(haystack,needle,loc+1)
		if testloc then loc = testloc 
		else break end
	end
	return loc
end

------------------------------------------
-- I) General Tools Functions
--[[
Notes_InTable - Check to see if an item is in an array
Notes_Split - Split a string into an array via a delimeter
Notes_Join - Join an array into a string via a delimeter
Notes_Merge - Merge two arrays into one
Notes_RaidPrint - Do your best to print to raid chat
Notes_Print - General purpose print function.  Better than the default.
Notes_DataToString - Format data into a string for printing
Notes_StringToID - Create a number from a string
Notes_SuccessPrint - Print a success message
Notes_WarningPrint - Print a warning message
Notes_ErrorPrint - Print an error message
Notes_InParty - Am I in a party?
Notes_InRaid - Am I in a raid?
]]--

function Notes_InTable(haystack,needle,id,id2)
	for key,hay in haystack do
		if id then hay = hay[id] end
		if id2 then hay = hay[id2] end
		if needle == hay then return key end		
	end	
	return nil
end

function Notes_GetNoteIndex(id)
	if id == nil then return nil end
	return Notes_InTable(Notes_Notes,id,"id")
end

function Notes_Split(text, delimiter)
	local list = {}
	local pos = 1
	if strfind("", delimiter, 1) then -- this would result in endless loops
		return text
	end
	while 1 do
		local first, last = strfind(text, delimiter, pos)
		if first then
			tinsert(list, strsub(text, pos, first-1))
			pos = last+1
		else
			tinsert(list, strsub(text, pos))
			break
		end
	end
	return list
end

function Notes_Join(list, delimiter)
	local len = getn(list)
	if len == 0 then return "" end
	
	local string = list[1]
	for i = 2, len do 
		string = string..delimiter..list[i] 
	end
	return string
end

function Notes_Merge (table1, table2, start1, start2, end1, end2)
	if not start1 then start1 = 1 end
	if not start2 then start2 = 1 end
	if not end1 then end1 = 10000 end
	if not end2 then end2 = 10000 end

	local mtable = {}
	if type(table1) == "table" then
		for i=max(1,start1),min(getn(table1),end1) do
			table.insert(mtable,table1[i])
		end
	elseif type(table1) == "string" then
		table.insert(mtable,table1)
	end
	
	if type(table2) == "table" then
		for i=max(1,start2),min(getn(table2),end2) do
			table.insert(mtable,table2[i])
		end
	elseif type(table2) == "string" then
		table.insert(mtable,table2)
	end
	
	return mtable
end

function Notes_RaidPrint (msg)
	local index = nil
	
	if Notes_InRaid() then
		ChatThrottleLib:SendChatMessage("NORMAL","",msg, "RAID")
		
        elseif Notes_InParty() then
		ChatThrottleLib:SendChatMessage("NORMAL","",msg, "PARTY")		
	else
        	Notes_Print(msg)
        end
end

function Notes_Print(msg,prefix)
	if prefix == nil then prefix = "" end

	if msg == nil then 
		DEFAULT_CHAT_FRAME:AddMessage(prefix.."nil",.8,.8,.8)
	
	elseif type(msg) == "number" then
		DEFAULT_CHAT_FRAME:AddMessage(prefix..msg,.8,.8,1)
		
	elseif type(msg) == "string" then
		DEFAULT_CHAT_FRAME:AddMessage(prefix..msg,1,.9,.8)
		
	elseif type(msg) == "boolean" and msg==false then
		DEFAULT_CHAT_FRAME:AddMessage(prefix.."false",1,.8,.8)
		
	elseif type(msg) == "boolean" and msg==true then
		DEFAULT_CHAT_FRAME:AddMessage(prefix.."true",.8,1,.8)
	
	elseif type(msg) == "table" then
		for index,item in msg do
			if type(item) == "table" then
				if getn(item) > 0 then
					DEFAULT_CHAT_FRAME:AddMessage(prefix..index.."  --TABLE--")
					Notes_Print(item,prefix..">  ")
				end
			else
				Notes_Print(item,prefix..index.."  ")
			end
		end
	end
end

function Notes_DataToString(msg,prefix)
	local str = ""

	if prefix == nil then prefix = "" end

	if msg == nil then 
		str = str..prefix.."nil\n"
	
	elseif type(msg) == "number" then
		str = str..prefix..msg.."\n"
		
	elseif type(msg) == "string" then
		str = str..prefix..msg.."\n"
		
	elseif type(msg) == "boolean" and msg==false then
		str = str..prefix.."false\n"
		
	elseif type(msg) == "boolean" and msg==true then
		str = str..prefix.."true\n"
	
	elseif type(msg) == "table" then
		for index,item in msg do
			if type(item) == "table" then
				str = str..prefix..index.."  --TABLE--\n"
				str = str..Notes_DataToString(item,prefix..">  ")
			else
				str = str..Notes_DataToString(item,prefix..index.."  \n")
			end
		end
	end
	return strsub(str,0,-2)
end

function Notes_StringToID(msg)
	local id = 0
	for i=1,strlen(msg) do
		local val = strsub(msg,i,i)		
		if tonumber(val) then id = id + tonumber(val)*i end
		if val=="a" or val=="A" then id = id + 1*i*10 end
		if val=="b" or val=="B" then id = id + 2*i*10 end
		if val=="c" or val=="C" then id = id + 3*i*10 end
		if val=="d" or val=="D" then id = id + 4*i*10 end
		if val=="e" or val=="E" then id = id + 5*i*10 end
		if val=="f" or val=="F" then id = id + 6*i*10 end
		if val=="g" or val=="G" then id = id + 7*i*10 end
		if val=="h" or val=="H" then id = id + 8*i*10 end
		if val=="i" or val=="I" then id = id + 9*i*10 end
		if val=="j" or val=="J" then id = id + 10*i*10 end
		if val=="k" or val=="K" then id = id + 11*i*10 end
		if val=="l" or val=="L" then id = id + 12*i*10 end
		if val=="m" or val=="M" then id = id + 13*i*10 end
		if val=="n" or val=="N" then id = id + 14*i*10 end
		if val=="o" or val=="O" then id = id + 15*i*10 end
		if val=="p" or val=="P" then id = id + 16*i*10 end
		if val=="q" or val=="Q" then id = id + 17*i*10 end
		if val=="r" or val=="R" then id = id + 18*i*10 end
		if val=="s" or val=="S" then id = id + 19*i*10 end
		if val=="t" or val=="T" then id = id + 20*i*10 end
		if val=="u" or val=="U" then id = id + 21*i*10 end
		if val=="v" or val=="V" then id = id + 22*i*10 end
		if val=="w" or val=="W" then id = id + 23*i*10 end
		if val=="x" or val=="X" then id = id + 24*i*10 end
		if val=="y" or val=="Y" then id = id + 25*i*10 end
		if val=="z" or val=="Z" then id = id + 26*i*10 end
    	end
	return id
end

function Notes_SuccessPrint(msg)
	DEFAULT_CHAT_FRAME:AddMessage("<<Notes: "..msg..">>",.6,1,.3)
end

function Notes_WarningPrint(msg)
	DEFAULT_CHAT_FRAME:AddMessage("<<Notes Warning: "..msg..">>",1,.8,0)
end

function Notes_ErrorPrint(msg)
	DEFAULT_CHAT_FRAME:AddMessage("<<Notes Error: "..msg..">>",1,0,0)
end

function Notes_InParty(player)
	if player then
		player = strlower(player)
		for i=1,4 do
			local name = UnitName("party"..i)
			if name and strlower(name) == player then 
				return 1
			end
		end
	else
		return GetPartyMember(1)
	end
	return nil
end

function Notes_InRaid(player)
	if player then
		player = strlower(player)
		for i=1,GetNumRaidMembers() do
			local name = GetRaidRosterInfo(i)
			if name and strlower(name) == player then 
				return 1
			end
		end
	else
		return UnitInRaid("player")
	end
	return nil
end

function Notes_InGuild(player)
	if player then
		player = strlower(player)
		for i=1,GetNumGuildMembers() do
			local name = GetGuildRosterInfo(i)
			if name and strlower(name) == player then 
				return 1
			end
		end
	else
		return IsInGuild()
	end
	return nil
end

function Notes_InBattlefield()
	for i=1,3 do 
		if GetBattlefieldStatus(i)=="active" then 
			return true 
		end 
	end 
end

------------------------------------------
-- J) Dropdown UI Functions
--[[
Notes_CommDropDownOnLoad - Set the width of the communications drop down and set starting value
Notes_CommDropDownOnClick - Set the communications method
Notes_CommDropDownInitialize - Prepare the communications drop down
Notes_ChanSelectDropDownOnLoad - Set the width of the communications channel drop down
Notes_ChanSelectDropDownOnClick - Set the communications channel
Notes_ChanSelectDropDownInitialize - Prepare the communications channel drop down
]]--

function Notes_CommDropDownOnLoad()
	UIDropDownMenu_Initialize(NotesCommDropDown, Notes_CommDropDownInitialize)
	UIDropDownMenu_SetSelectedValue(NotesCommDropDown, Notes_SelectedComm)
	UIDropDownMenu_SetWidth(70, NotesCommDropDown)
end

function Notes_CommDropDownOnClick()
	UIDropDownMenu_SetSelectedValue(NotesCommDropDown, this.value)
	Notes_SelectedComm = this.value
	Notes_SetButtonState(1)
end

function Notes_CommDropDownInitialize()
	local selectedValue = UIDropDownMenu_GetSelectedValue(NotesCommDropDown)
	
	for i=1,getn(Notes_CommModes) do
		local info = {}
		info.text = Notes_CommModes[i][1]
		info.func = Notes_CommDropDownOnClick
		info.value = i
		info.checked = nil
		if ( info.value == selectedValue ) then
			info.checked = 1
		end
		UIDropDownMenu_AddButton(info)
	end
end

function Notes_ChanSelectDropDownOnLoad()
	UIDropDownMenu_SetWidth(115, NotesChanSelectDropDown)
end

function Notes_ChanSelectDropDownOnClick()
	UIDropDownMenu_SetSelectedValue(NotesChanSelectDropDown, this.value)
	Notes_SelectedChan = this.value
	Notes_SetButtonState(1)
end

function Notes_ChanSelectDropDownInitialize()
	local selectedValue = UIDropDownMenu_GetSelectedValue(NotesChanSelectDropDown)
	
	Notes_InitChannelList()
	
	for i=1,getn(Notes_ChanList) do
		if Notes_ChanList[i][2] ~= nil then
			local info = {}
			info.text = Notes_ChanList[i][1]..". "..Notes_ChanList[i][2]
			info.func = Notes_ChanSelectDropDownOnClick
			info.value = i
			info.checked = nil
			if ( info.value == selectedValue ) then
				info.checked = 1
			end
			UIDropDownMenu_AddButton(info)
		end
	end
end

------------------------------------------
-- K) Book UI Functions
--[[
Notes_CreateIndexPage - Create a table of contents for a book
Notes_TOCScrollBarUpdate - Update the scrolling table of contents on vertical scroll
Notes_ToggleTOCSelected - Load the new book page from the index page
Notes_LoadPrevPage - Load the previous book page
Notes_LoadNextPage - Load the next book page
Notes_GoToPage - Go to some random book page
Notes_ReorderPage - Move the current page to your target page
]]--
function Notes_CreateIndexPage(bookid)
	local id = Notes_BookID
	if bookid then id = bookid end
	
	local index = Notes_GetNoteIndex(id)
	if not index then return end	
	
	NotesTOCTitle_Text:SetText("["..Notes_Notes[index]["title"].."] Table of Contents")
	
	Notes_TOCPageData = {}
	for i=1,getn(Notes_BookPages) do
		local idx = Notes_GetNoteIndex(Notes_BookPages[i])
		if idx then
			Notes_TOCPageData[i] = "Page "..i..") "

			if Notes_Notes[idx]["sync"] then
				Notes_TOCPageData[i] = Notes_TOCPageData[i].."[S]"
			end

			if Notes_Notes[idx]["locked"] then
				Notes_TOCPageData[i] = Notes_TOCPageData[i].."[L]"
			end
			if Notes_Notes[idx]["sync"] or Notes_Notes[idx]["locked"] then
				Notes_TOCPageData[i] = Notes_TOCPageData[i].." "
			end
			
			local title = Notes_Notes[idx]["title"]
			local oldtitle = Notes_Notes[idx]["title"]
			if title ~= nil then
				title = strsub(title,0,Notes_TOCTitleLen)
			  	if strlen(oldtitle) > Notes_TOCTitleLen then
					title = title.."..."
				end
			end
			
			Notes_TOCPageData[i] = Notes_TOCPageData[i]..title
		end
	end
	Notes_TOCScrollBarUpdate()
end

function Notes_TOCScrollBarUpdate()
   	local line; -- 1 through 5 of our window to scroll
   	local lineplusoffset; -- an index into our data calculated from the scroll offset	
	
	if getn(Notes_TOCPageData) == 0 then return end
	
   	FauxScrollFrame_Update(NotesTOCScrollBar,getn(Notes_TOCPageData),16,16);
   	for line=1,16 do
    		lineplusoffset = line + FauxScrollFrame_GetOffset(NotesTOCScrollBar);
     		if lineplusoffset <= getn(Notes_TOCPageData) then
       			getglobal("NotesTOC"..line.."_Text"):SetText(Notes_TOCPageData[lineplusoffset]);
       			getglobal("NotesTOC"..line):Show();
     		else
       			getglobal("NotesTOC"..line):Hide();
     		end
   	end
end

function Notes_ToggleTOCSelected(button)	
	if button ~= nil then
		local num = button

		if getglobal(button) then
			for i=2,1,-1 do
				num = tonumber(strsub(button,-1*i))
				if num ~= nil then break end
			end
		end
		local toselect = num + FauxScrollFrame_GetOffset(NotesTOCScrollBar)
		
		Notes_GoToPage(toselect)			
	end
end

function Notes_LoadPrevPage()
	return Notes_GoToPage(Notes_BookPage - 1)
end

function Notes_LoadNextPage()
	return Notes_GoToPage(Notes_BookPage + 1)
end

function Notes_GoToPage(pagenum)
	if pagenum < 0 or pagenum > getn(Notes_BookPages) then 
		Notes_ErrorPrint("Page out of range (0-"..getn(Notes_BookPages)..")")
		return Notes_SetButtonState(1)
	end

	Notes_MultiSelected = {}

	Notes_BookPage = pagenum
	Notes_LoadSelected(Notes_GetNoteIndex(Notes_BookPages[Notes_BookPage]))
	if Notes_BookPage == 0 then
		Notes_LoadSelected(Notes_GetNoteIndex(Notes_BookID))
		
	elseif Notes_BookPage >= 1 and Notes_BookPage <= getn(Notes_BookPages) then
		local idx = Notes_GetNoteIndex(Notes_BookPages[Notes_BookPage])
		if idx then Notes_LoadSelected(idx) end
	end
end

function Notes_ReorderPage(targetpage)
	if not Notes_BookID or not Notes_Selected or not Notes_Notes[Notes_Selected] then return end
	if targetpage < 1 or targetpage > getn(Notes_BookPages) then 
		Notes_ErrorPrint("Page out of range (1-"..getn(Notes_BookPages)..")")
		return Notes_SetButtonState(1)
	end
	
	local bookidx = Notes_GetNoteIndex(Notes_BookID)
	if not bookidx then return end
	
	local pages = Notes_Notes[bookidx]["book"]
	local curid = Notes_Notes[Notes_Selected]["id"]
	local newpages = {}
	local newpage = 1
	local oldpage = 1
	
	if targetpage == 1 then
		table.insert(newpages,Notes_Notes[Notes_Selected]["id"])
		newpage = newpage + 1			
	end

	while true do
		if pages[oldpage] ~= Notes_Notes[Notes_Selected]["id"] then
			table.insert(newpages,pages[oldpage])
			newpage = newpage + 1
		end
			
		if newpage == targetpage then
			table.insert(newpages,Notes_Notes[Notes_Selected]["id"])
			newpage = newpage + 1			
		end
		
		oldpage = oldpage + 1
		if not pages[oldpage] then break end
	end
	
	if getn(pages) == getn(newpages) then
		Notes_Notes[bookidx]["book"] = newpages
		Notes_GoToPage(targetpage)
	end
end

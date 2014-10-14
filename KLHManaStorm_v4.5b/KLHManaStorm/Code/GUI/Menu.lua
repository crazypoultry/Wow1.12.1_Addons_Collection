
-- module setup
local me = { name = "menu"}
local mod = thismod
mod[me.name] = me

--[[
Menu.lua

This module is the core component of the mod's Main Menu, the window when you customise the mod's behaviour. There are many separate sections to the menu, and this module helps organise them in a heirarchical manner. 

Imagine a tree structure, where the top node represents the entire Menu. Each node has a section where the user can do something, and it may also have a series of child sections that deal with more specific issues. On the screen, the Menu module will create a list of each section's children on the left, and in the centre ths sections' Frame is displayed. 
]]

-- Special OnLoad method called from Core.lua.
me.onload = function()
	
	-- this is the "Home / Parent / Up" button on the top left of the bar.
	me.button.parent = me.createsidebarbutton(0)
	
	-- this is the current section
	me.button.current = me.createsidebarbutton(-1)
	
	-- setup Slash Commands
	setglobal(string.format("SLASH_%s1", mod.global.name), mod.global.slash.short)
	setglobal(string.format("SLASH_%s2", mod.global.name), mod.global.slash.medium)
	setglobal(string.format("SLASH_%s3", mod.global.name), mod.global.slash.long)
	
	SlashCmdList[mod.global.name] = me.show
	
end

--[[
-----------------------------------------------------------------------------
				(OnLoad) Adding Sections to the Help Menu
-----------------------------------------------------------------------------
]]

--[[
me.sections is a key-value list. The key is the name of the section. The value is a table with properties
.name				string; name of the section
.description	string; a brief description
.parent			string; name of the parent section
.frame			Frame; what to show when the section is active. Optionally, the Frame can have a .setup() method, that will be run immediately before it is shown.
.children		array of section objects.
]]
me.sections = { }

--[[
mod.menu.registersection(name, parent, description, frame)
	Adds a topic to the list of topics. This method is called from the <me.onload()> method of this and other modules. All the topic will be dumped into <me.sections>. They are only ordered in <me.onloadcomplete()>. Optionally, the Frame can have a .setup() method, that will be run immediately before it is shown.
	
<name>		string; identifier of this section
<parent>		string; the <name> property of this topic's parent, or <nil> if this is a top level section.
<description> string; localised brief description of the topic
<frame>		Frame; the window that has this topic's content
]]
me.registersection = function(name, parent, description, frame)
	
	-- warn if this is an overwrite
	if me.sections[name] then
		if mod.trace.check("warning", me, "setup") then
			mod.trace.print(string.format(mod.string.get("trace", "menu", "sectionoverwrite"), name))
			
			-- don't allow overwrites
			return
		end
	end
	
	-- default parent is top
	if parent == nil then
		parent = "top"
	end

	me.sections[name] = 
	{
		["parent"] = parent,
		["name"] = name,
		["description"] = description,
		["frame"] = frame,
		["children"] = { },
	}
	
end

--[[
Special OnLoadComplete() method called from Core.lua.
	The sections in <me.sections> are connected - a node <x> is added to the <.children> set of it's parent node.
]]
me.onloadcomplete = function()

	local parentname, parentnode

	for name, data in me.sections do
		
		parentname = data.parent
		
		-- check for parent not existing
		if me.sections[parentname] == nil then
			if mod.trace.check("warning", me, "setup") then
				mod.trace.print(string.format(mod.string.get("trace", me.name, "parentnotfound"), tostring(parentname), tostring(name)))
			end
			
		else -- link it
				
			-- don't make root node a child of itself (because it is already its own parent)
			if name ~= "top" then
				parentnode = me.sections[parentname]
				table.insert(parentnode.children, data)
			end
		end
	end
	
end

--[[
-----------------------------------------------------------------------------
				(RunTime) Changing the Section Being Displayed
-----------------------------------------------------------------------------
]]

--[[
mod.menu.show()
	Shows the Menu window. It will start at the Home page.
]]
me.show = function()
	
	me.showsection("top")
	
end

--[[
mod.menu.hide()
	Closes the Menu window. All we do is close every frame that might be shown
]]
me.hide = function()
	
	if me.currentsection then
		me.currentsection.frame:Hide()
		
		for x = 1, table.getn(me.button) do
			me.button[x]:Hide()
		end
		
		me.button.parent:Hide()
		me.button.current:Hide()
	end
	
end

--[[
me.showsection(sectionname)
	Shows the specified topic in the menu window. Updates the menu bar buttons to point to the child nodes of the specified topic.
	
<sectionname>	string; the name of the section to be displayed. 
]]
me.showsection = function(sectionname)
	
	-- hide old section if there is one
	if me.currentsection then
		me.currentsection.frame:Hide()
	end
	
	-- get and set the new section
	local section = me.sections[sectionname]
	me.currentsection = section
	
	-- show and potision frame
	if section.frame.setup then
		section.frame.setup()
	end
	
	section.frame:Show()
	section.frame:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", GetScreenWidth() * 0.25, GetScreenHeight() * 0.85)
	
	-- Sidebar buttons
	
	-- parent bar. Show / anchor only needs to be done once, but it won't hurt. The text for this one is in yellow to differentiate it from the child links
	me.button.parent:Show()
	me.button.parent:SetPoint("TOPRIGHT", section.frame, "TOPLEFT", mod.gui.border, 0)
	me.button.parent.label:SetText("|cffffff00" .. me.sections[section.parent].description)
	
	-- current bar
	me.button.current:Show()
	me.button.current:SetPoint("BOTTOM", section.frame, "TOP", 0, - mod.gui.border)
	me.button.current.label:SetText(section.description)
	
	-- hide old ones
	for x = 1, table.getn(me.button) do
		me.getsidebarbutton(x):Hide()
	end
	
	-- show new ones. There's a 20 pixel gap between the child buttons and the parent button.
	for x = 1, table.getn(section.children) do
		childsection = section.children[x]
		
		me.getsidebarbutton(x).label:SetText(childsection.description)
		me.getsidebarbutton(x):SetPoint("TOPRIGHT", section.frame, "TOPLEFT", mod.gui.border, -20 + x * (mod.gui.border - me.button.height))
		me.getsidebarbutton(x):Show()
	end
	
end

--[[
-----------------------------------------------------------------------------
					Managing the Navigation Boxes
-----------------------------------------------------------------------------
]]

--[[
me.button holds the set of buttons we have created in numerical indices, and assorted properties as keys.
]]
me.button = 
{
	width = 150,
	height = 50,
}

--[[
me.getsidebarbutton(index)
	Gets the nth button on the menu sidebar. Creates it if it doesn't exist already.

<index>	integer; 1-based index.

Return: Frame; one of the items in <me.button>
]]
me.getsidebarbutton = function(index)

	if me.button[index] == nil then
		me.button[index] = me.createsidebarbutton(index)
	end
	
	return me.button[index]
	
end

--[[
me.createsidebarbutton(index)
	Creates a new side bar button. The button has will respond to mouse clicks my calling <me.menubuttonclick> with its index.
	
<index>	integer; 1-based index identifying the button

Return:	a Frame
]]
me.createsidebarbutton = function(index)
	
	local frame = mod.gui.createframe(me.button.width, me.button.height)
		
	-- label
	local label = mod.gui.createfontstring(frame, 15)
	label:SetAllPoints()
	
	-- click handler
	local callback = 
		function()
			me.menubuttonclick(index)
		end
		
	frame:SetScript("OnMouseDown", callback)
	
	-- attack label to frame
	frame.label = label
	
	-- make clickable
	frame:EnableMouse(true)
	
	-- hide by default
	frame:Hide()
	
	-- return
	return frame
	
end

--[[
me.menubuttonclick(index)
Handles a mouseevent on the side bar.

<index>	integer; identifies the button that was pressed. 0 for the parent button up the top; 1, 2, 3 etc for child buttons.
]]
me.menubuttonclick = function(index)

	if index == 0 then
		-- show parent frame
		me.showsection(me.currentsection.parent)
		
	elseif index == -1 then
		-- ignore clicks on current frame
		
	else
		-- show child frame
		me.showsection(me.currentsection.children[index].name)
	end
	
end

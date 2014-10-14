--[[---------------------------------------------------------------------------
SwiftShift 1.7
By Trimble Epic

See the README.TXT file for introduction and usage.

For a druid, viable names are 'Bear Form', ,'Dire Bear Form', 'Cat Form', 'Aquatic Form',
and 'Travel Form'

To shift to humanoid form, you may use 'Humanoid Form', 'Night Elf Form', or 'Tauren Form'

When used in other macros or scripts, the function SwiftShift() will return TRUE
if you are already in the desired form, and FALSE if it caused you to shift.

Still to do:
localization
find more ways to detect swimming in advance
automatic weapon swapping?  just learn what weapons we hold when in bear form and remember them
	if that same weapon if found when we shapeshift, then autoswap, otherwise don't.
add some macro helpers:
	find buff(make this public for use to find nature's swiftness, etc)
	check cooldown(this is needed for fast sequencing of complex macros that will trample themselves)
	getcurrentform(just return current form by name without shifting us - dont remember why)


Revision History:
1.7
	Update TOC to 11000 for compatibility with 1.10 verion of the game.
	Update tooltip usage to not loose parent over time.
	Added keybinding for Moonkin form
1.5.2
	Update TOC to 1500
	fixed a bug that caused paladins to cancel their auras when mis-using swiftshift.
1.5.1
	BUGfix!
		The change to auto aquatic form can stick you if you don't have travel form.  Fixed.
1.5 Mar 17 2005
	Added slash commands /ss and /SwiftShift
		currently, the only arguments used are 'talktome' and 'debug'
	Added feedback system, '/ss talktome'
	Beginning of Travel/Aquatic form combining
1.4 Feb 26 2005
	revised initialization sequence
1.3 Feb 22 2005
	Updated TOC file to 4216
1.2 Feb 15 2005
	Tested to work with game client version 4211
	Updated TOC file to conform to (and work with) 4211
1.1 Multiple fixes
	SwiftShift() now returns true if it didn't have to cast a shapeshift.
		this makes creating macros easier because it saves the macro space
		previously used by 'not '.  A macro such as:
		if not SwiftShift('Humanoid Form') then CastSpellByName('Regrowth(Rank 1)') end
		would read as "if I don't have to shift to humanoid form, then I shall cast
		regrowth".  With this update, the same macro would look like:
		if SwiftShift('Humanoid Form') then CastSpellByName('Regrowth(Rank 1)') end
		this version is shorter (macro space is at a premium), and reads easier as:
		"if I'm in human form, then cast regrowth" (with the assumption that if I'm
		not in human form, I'll shift instead, and the macro will work on the next run)
	SwiftShift now checks to see if Dire Bear Form is a valid form.  If Dire Bear is
		available, and the user calls SwiftShift('Bear Form'), then the desired form
		is converted to SwiftShift('Dire Bear Form') automatically.
	SwiftShift now uses a private tooltip, and as such will not (seemingly) randomly
		change the tooltip that you are trying to view.
1.0 Initial version
	SwiftShift


-----------------------------------------------------------------------------]]

--Local declarations

local _version = '1.7'
local _class
local _OnEvent = {}
local _ShapeShiftForms = {}
local _Swimming = false
local _testing  = false
local _Feedback = false

--Global declarations

BINDING_HEADER_SwiftShift            = 'SwiftShift'
BINDING_NAME_SwiftShift_HumanoidForm = 'Humanoid Form'
BINDING_NAME_SwiftShift_BearForm     = 'Bear Form'
BINDING_NAME_SwiftShift_CatForm      = 'Cat Form'
BINDING_NAME_SwiftShift_AquaticForm  = 'Aquatic Form'
BINDING_NAME_SwiftShift_TravelForm   = 'Travel Form'
BINDING_NAME_SwiftShift_MoonkinForm  = 'Moonkin Form'

--[[---------------------------------------------------------------------------
Misc functions
-----------------------------------------------------------------------------]]

local function Print(msg)
	
	if not DEFAULT_CHAT_FRAME then return end
	
	DEFAULT_CHAT_FRAME:AddMessage(msg)
	
end

local function Say(...)
	
	if not _Feedback then return end
	
	local msg = 'SwiftShift: '
	
	for k,v in ipairs(arg) do
		
		msg = msg .. tostring(v)
		
	end
	
	Print(msg)
	
end

local function Debug(...)
	
	if not _testing then return end
	
	local msg = 'SwiftShift Debug: '
	
	for k,v in ipairs(arg) do
		
		msg = msg .. tostring(v)
		
	end
	
	Print(msg)
	
end

local function SwiftShift_debug()
	
	_testing = not _testing
	Print('toggle testing')
	
end

local function SwiftShift_talktome()
	
	_Feedback = not _Feedback
	Print('toggle feedback')
	
end

--[[---------------------------------------------------------------------------
My Functions SwiftShift
-----------------------------------------------------------------------------]]

local function Load_ShapeShiftForms()
	
	local i = 1
	local _form_name
	local _data
	
	_ShapeShiftForms = {}
	
	if _class ~= 'Druid' then return end
	
	SwiftShiftTooltip:SetOwner(UIParent, "ANCHOR_NONE")
	
	while true do
		
		
		SwiftShiftTooltip:SetShapeshift(i)
		_data  = SwiftShiftTooltipTextLeft1:GetText()
		
		if _data == _form_name then break end
		
		_form_name = _data
		_ShapeShiftForms[_form_name] = i
		i = i + 1
		
	end
	
	if _ShapeShiftForms['Dire Bear Form'] then
		
		Say('Shapeshift forms loaded: ',i-1,' (Dire Bear detected)')
		
	else
		
		Say('Shapeshift forms loaded: ',i-1)
		
	end
	
end

local function SwiftShift_FindBuff(_buff_to_find, unit)
	
	local i = 1
	
	SwiftShiftTooltip:SetOwner(UIParent, "ANCHOR_NONE")
	
	while UnitBuff(unit, i) do
		
		SwiftShiftTooltip:SetUnitBuff(unit,i)
		
		Debug('FindBuff: ',unit,' index: ',i,' bufftofind: ',_buff_to_find,' tooltiptext: ',SwiftShiftTooltipTextLeft1:GetText())
		
		if SwiftShiftTooltipTextLeft1:GetText() == _buff_to_find then return true end
		
		i = i + 1
		
	end
	
end

function SwiftShift(_desired_form)
	
	if _class ~= 'Druid' then return true end
	
	local _current_form = 'Humanoid Form'
	
	for i in _ShapeShiftForms do
		
		if SwiftShift_FindBuff(i, 'player') then
			
			_current_form = i
			
		end
		
	end
	
	Say('Current Form: ', _current_form, " / Desired Form: ",_desired_form)
	
	if _desired_form == 'Bear Form'
	and _ShapeShiftForms['Dire Bear Form'] then
		
		Say('Adjusting Desired Form from Bear Form to Dire Bear Form')
		_desired_form = 'Dire Bear Form'
		
	end
	
	if _desired_form == 'Travel Form'
	and _Swimming 
	and _ShapeShiftForms['Aquatic Form'] then
		
		Say('Adjusting Desired Form from Travel Form to Aquatic Form')
		_desired_form = 'Aquatic Form'
		
	end
	
	if _desired_form == 'Aquatic Form'
	and not _Swimming 
	and _ShapeShiftForms['Travel Form'] then
		
		Say('Adjusting Desired Form from Aquatic Form to Travel Form')
		_desired_form = 'Travel Form'
		
	end
	
	if _current_form == _desired_form then
		
		Say('Already in desired form, no shift required')
		return true
		
	end
	
	if _ShapeShiftForms[_desired_form] then
		
		if _current_form == 'Humanoid Form' then
			
			Say('Shifting to ',_desired_form)
			CastShapeshiftForm(_ShapeShiftForms[_desired_form])
			return false
			
		else
			
			Say('Can not shift to ',_desired_form,', shifting to Humanoid Form first')
			_desired_form = 'Humanoid Form'
			
		end
		
	end
	
	if (_desired_form == 'Humanoid Form' 
	or  _desired_form == 'Tauren Form'
	or  _desired_form == 'Night Elf Form' )
	and _ShapeShiftForms[_current_form] then
		
		Say('Shifting to Humanoid Form')
		CastShapeshiftForm(_ShapeShiftForms[_current_form])
		return false
		
	end
	
	if _class == 'Druid' then
		
		UIErrorsFrame:AddMessage('SwiftShift: Desired form "'.._desired_form..'" is not a valid form', 1.0, 1.0, 1.0, 1.0, UIERRORS_HOLD_TIME)
		return true
		
	else
		
		UIErrorsFrame:AddMessage('SwiftShift: You are not a Druid.', 1.0, 1.0, 1.0, 1.0, UIERRORS_HOLD_TIME)
		return true
		
	end
	
end

--[[---------------------------------------------------------------------------
Event handler system
-----------------------------------------------------------------------------]]

--Event handle variables
local _variables_loaded
local _init_complete

local function Init()
	
	_class = UnitClass('player')
	Load_ShapeShiftForms()
	
	_init_complete = true
	
	Say('SwiftShift initialized')
	
end

local function TryInit()
	
	if _init_complete
	or (not _variables_loaded) then return end
	
	local name = UnitName('player')
	
	if  (name ~= nil            )
	and (name ~= 'UNKNOWNOBJECT')
	and (name ~= 'UKNOWNBEING'  ) then
		
		Init()
		
	end
	
end

function _OnEvent.VARIABLES_LOADED()
	
	_variables_loaded = true
	
	TryInit()
	
end

function _OnEvent.PLAYER_ENTERING_WORLD()
	
	TryInit()
	
end

function _OnEvent.UNIT_NAME_UPDATE()
	
	TryInit()
	
end

function _OnEvent.SPELLS_CHANGED()
	
	if not _class then return end
	
	Load_ShapeShiftForms()
	
end

function _OnEvent.UI_ERROR_MESSAGE()
	
	if string.find(arg1, 'Cannot use while swimming') then
		
		_Swimming = true
		Debug('swimming detected / time:',_Swimming)
		
	end
	
	if string.find(arg1, 'Can only use while swimming') then
		
		_Swimming = false
		Debug('need to be swimming detected / time:',_Swimming)
		
	end
	
	if string.find(arg1, 'Cannot use while mounted') then
		
		_Swimming = false
		Debug('ability not ready detected / time:',_Swimming)
		
	end
	
end

function SwiftShift_OnEvent()
	
	_OnEvent[event]()
	
end

function SwiftShift_OnLoad()
	
	SwiftShiftFrame:RegisterEvent('PLAYER_ENTERING_WORLD')
	SwiftShiftFrame:RegisterEvent('VARIABLES_LOADED')
	SwiftShiftFrame:RegisterEvent('UNIT_NAME_UPDATE')
	SwiftShiftFrame:RegisterEvent('SPELLS_CHANGED')
	SwiftShiftFrame:RegisterEvent("UI_ERROR_MESSAGE")
	
	SlashCmdList["SWIFTSHIFT"] = SwiftShift_SlashHandler;
	SLASH_SWIFTSHIFT1 = "/SwiftShift";
	SLASH_SWIFTSHIFT2 = "/ss";
	
	Print('You gain SwiftShift AddOn!')
	
end

function SwiftShift_SlashHandler(msg)
	
	Debug('Slash: ',msg)
	if msg == 'talktome' then SwiftShift_talktome() end
	if msg == 'debug' then SwiftShift_debug() end
	
end

--[[---------------------------------------------------------------------------
                               DRUIDS RAWK !!!
-----------------------------------------------------------------------------]]

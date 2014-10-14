-------------------------------------------------------------------------------
-- simplified tab management code
-------------------------------------------------------------------------------

SA_SUBFRAMES = { "SABasicOptionsFrame", "SAListOptionsFrame", "SAMessageOptionsFrame", "SAAdvancedOptionsFrame", "SmartActionsOptionsFrame" };

function SA_ShowSubFrame(frameName)
	for index, value in SA_SUBFRAMES do
		if ( value == frameName ) then
			getglobal(value):Show();
			PanelTemplates_SetTab(SAOptionsFrame, index);
		else
			getglobal(value):Hide();	
		end	
	end 
end

function SA_Tab_OnClick()
	local id = this:GetID();
	local tab = SA_SUBFRAMES[id];
	local subFrame = getglobal(tab);
	SA_ShowSubFrame(tab);
	PlaySound("igCharacterInfoTab");
end

-------------------------------------------------------------------------------
-- spell & action drag hookups
-------------------------------------------------------------------------------

SA_DRAGSPELL = nil;
SA_DRAGSLOT = nil;
SA_DRAGNAME = nil;

function SA_ClearDragData()
	SA_DRAGSPELL = nil;
	SA_DRAGSLOT = nil;
	SA_DRAGNAME = nil;
end
 
-- hook to spellbook pickup routine
local SA_BasePickupSpell = PickupSpell;
function PickupSpell(id, bookType)
	SA_ClearDragData();
	local result = SA_BasePickupSpell(id, bookType);
	if (CursorHasSpell()) then
		local name, rank = GetSpellName(id, bookType);
		local texture = GetSpellTexture(id, bookType);
		SA_Debug("picked up spell id="..id.." bookType="..bookType.." name="..tostring(name), 1);
		SA_DRAGSPELL = {};
		SA_DRAGSPELL.Id = id;
		SA_DRAGSPELL.Texture = texture;
		SA_DRAGSPELL.Name = name;
		SA_DRAGSPELL.BookType = bookType;
		SA_DRAGNAME = name;
	end
	return result;
end

local SA_BasePickupAction = PickupAction;
function PickupAction(slot)
	SA_ClearDragData();
	SA_Debug("picked up spell from slot "..slot);
	-- set drag slot
	SA_DRAGSLOT = slot;
	SA_DRAGNAME = SA_GetSlotName(slot);
	SA_Debug("SA_DRAGNAME="..tostring(SA_DRAGNAME));
	return SA_BasePickupAction(slot);
end

-------------------------------------------------------------------------------
-- smart assist configuration dialog
-------------------------------------------------------------------------------

function SA_Options_Init()
end

function SA_Options_OnHide()
end

function SA_Options_OnLoad()
	tinsert(UISpecialFrames, "SAOptionsFrame");
	-- Tab Handling code
	PanelTemplates_SetNumTabs(this, 5);
end
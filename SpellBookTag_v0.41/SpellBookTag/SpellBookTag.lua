-- **************************************************************************
-- * Spell Book Tag 0.41
-- * by evil.oz
-- *
-- *************************************************************************

local SpellBookTagActionButtonList={}
local SpellBookTag_DebugEnabled=false

-- *************************************************************************
-- INITIALIZATION
-- *************************************************************************
function SpellBookTag_OnLoad() 

	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("SPELLS_CHANGED");
	this:RegisterEvent("ACTIONBAR_SLOT_CHANGED");

        
end

-- *************************************************************************
-- EVENT HANDLER (init after var loads for now)
-- *************************************************************************
function SpellBookTag_OnEvent(event)

	if (event == "VARIABLES_LOADED") then
	        SpellBookTag_Printout("Spell Bok Tag 0.41 by evil.oz");
	end

	if (event == "SPELLS_CHANGED") then
		SpellBookTag_SpellsChanged()
	end

	if (event == "ACTIONBAR_SLOT_CHANGED") and SpellBookFrame:IsVisible() then
		SpellBookTag_SpellsChanged()
	end

end

-- *************************************************************************
-- SpellBook opened
-- *************************************************************************
function SpellBookTag_SpellsChanged()

	SpellBookTag_UpdateActionButtonList()
	SpellBookTag_ShowBorders()

end

-- *************************************************************************
-- Load all spells from actionbars in array
-- *************************************************************************
function SpellBookTag_UpdateActionButtonList()

	SpellBookTag_Debug("scanning spells");
	SpellBookTagActionButtonList={}
	local id,name,rank,spellname

	for id=1,108 do
		if ( HasAction(id) ) then
			SpellBookTagToolTip:SetAction(id);
			name = SpellBookTagToolTipTextLeft1:GetText();
			if ( name and name ~= "" ) then

				if ( SpellBookTagToolTipTextRight1:IsShown() ) then
			 		rank = SpellBookTag_RankConvert(SpellBookTagToolTipTextRight1:GetText())
				else
					rank = ""
				end

				spellname=name..rank
				SpellBookTag_Debug("adding "..spellname.." (id="..id..")");
				table.insert(SpellBookTagActionButtonList,spellname)
			end
		end
	end

	SpellBookTag_Debug("found "..table.getn(SpellBookTagActionButtonList).." spells");
end

-- *************************************************************************
-- highlight spells contained in array
-- *************************************************************************
function SpellBookTag_ShowBorders()

	SpellBookTag_Debug("showing borders");

	local spelltab=SpellBookFrame.selectedSkillLine
	local page=SpellBook_GetCurrentPage()
	local spelltabname,spelltabtexture,offset,numSpells=GetSpellTabInfo(spelltab)

	local startspell, endspell, spellpos, spellName,spellRank, found

	startspell=offset+12*(page-1)
	endspell=startspell+12

	if endspell > (offset+numSpells) then
		endspell=offset+numSpells
	end

	spellpos=1

	for spellId=startspell+1,endspell,1 do
		spellName,spellRank=GetSpellName( spellId,BOOKTYPE_SPELL );

		spellRank = SpellBookTag_RankConvert(spellRank)

		--SpellBookTag_Debug("looking for: "..spellName..spellRank.." in slot "..spellpos);

		found=false
		for n=1, table.getn(SpellBookTagActionButtonList) do
 			if SpellBookTagActionButtonList[n]== spellName..spellRank then
				SpellBookTag_Debug("found: "..SpellBookTagActionButtonList[n]);
				found=true
				do break end
			end
		end

		--SpellBookTag_Debug("Slot (linear) n. "..spellpos);
		--SpellBookTag_Debug("slot (real)   n. "..SpellBookTag_SlotConvert(spellpos));

		if found then	
			getglobal("SpellButton"..SpellBookTag_SlotConvert(spellpos).."SpellName"):SetTextColor(1,0,0)
		else
			getglobal("SpellButton"..SpellBookTag_SlotConvert(spellpos).."SpellName"):SetTextColor(1.0, 0.82, 0)
		end
		spellpos=spellpos+1

		
	
	
	end

	-- reset unused buttons color (prob useless)
	for n=spellpos, 12 do
		getglobal("SpellButton"..SpellBookTag_SlotConvert(n).."SpellName"):SetTextColor(1.0, 0.82, 0)
	end

end

-- *************************************************************************
-- spells are saved in columns (in spellbook) but spellbookframe is row based
-- *************************************************************************
function SpellBookTag_SlotConvert(slot)

	local value=0, sbtmod

	value=math.floor(slot/2)
	sbtmod=slot - (value*2)

	if slot > 6 then 
		value=(slot-6)*2
	else
		value=(slot*2)-1
	end

	return value
end

-- *************************************************************************
-- strip all non-numerical
-- *************************************************************************
function SpellBookTag_RankConvert(rankstring)

	local value=""
	if rankstring~=nil then
		for i in string.gfind( rankstring, "%d+" ) do 
			return tonumber(i);
		end
	end
	return value
end

-- *************************************************************************
-- stuff
-- ************************************************************************


function SpellBookTag_Printout(msg)
	DEFAULT_CHAT_FRAME:AddMessage("[Spell Book Tag] "..msg, 1.0, 1.0, 0.0);
end

function SpellBookTag_Debug(msg)

	if SpellBookTag_DebugEnabled then
		DEFAULT_CHAT_FRAME:AddMessage("[Spell Book Tag] "..msg, 1.0, 0, 1.0);
	end
end

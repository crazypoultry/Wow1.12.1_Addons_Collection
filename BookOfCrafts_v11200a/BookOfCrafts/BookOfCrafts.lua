--[[
   Author            : B.Legangneux
   Version           : 1.12a

   Please read "ReadMe.txt" and "ChangeNotes.txt" for more information
--]]



-- General data (Saved data)

BookOfCrafts_Data = {}

	--[[
		.Version                   : Data version

		.Options                   : All configuration options
		   .SameFaction            : If 'true', only characters from currently played faction will be displayed
		   .ShowSkillRank          : If 'true', skill ranks will be shown with alts names
		   .ShowChatMsg            : If 'true', more informative chat messages will be displayed (verbose mode)
		   .ShowCurPlayer          : If 'true', currently played character is also listed in results
		   .UseSideTooltip         : If 'true', results are displayed in a side tooltip
		   .Colors                 : Colors used for result display
		      .Tooltips            : Background color
		      .TooltipsKnownBy     : Text color for characters who already know recipe
		      .TooltipsMayLearn    : Text color for characters who may learn recipe
		      .TooltipsRankTooHigh : Text color for characters who cannot still learn recipe

		.Characters                : Indexed table of characters
		   [i]                     : Acces to i-th character
		      .Name                : Character name
		      .Realm               : Character realm
		      .Faction             : Character faction
		      .Specials            : list of known specializations
			  .Skills              : Known skills table
			    [tradeskill]       : Rank in "tradeskill"

		[tradeskill]               : Contains all known craft objects for "tradeskill" (tailor, alchemy, ...)
		   [crafted_object]        : Data for specific "crafted_object"
		      .Level               : Level required to learn this object crafting (only for crafting items, not from trainers teachings )
		      .LearntBy[i]         : index in ".Characters" of i-th character who knows this tradeskills

	]]--


-- Current player data

local BC_char_index        = nil     -- Character index in BookOfCrafts_Data 
local BC_char_realm        = nil     -- Copy of realm,
local BC_char_faction      = nil     -- ... faction
local BC_char_name         = nil     -- ... and name information

local BC_skills_data       = {}      -- A copy of selected character skills for UI


-- Flags

local BC_variables_loaded  = false   -- If 'true', SavedVariables.lua is loaded
local BC_data_checked      = false   -- If 'true', BookOfCrafts_Data is initalized correctly
local BC_player_name_known = false   -- If 'true', Player name is known
local BC_analysing_tooltip = nil     -- If 'true', tooltips analyse is in progress


-- Other values

local BC_timer             = 0       -- Timer to handle global elapsed time (OnUpdate)
local BC_timer_confirm     = 0       -- If >0, delete confirmation is needed (until countdown expires)


-- Last result for recipe analysis
local BC_last_recipe     = nil       -- Last succesfully analysed object (recipe) name from linked tooltip
local BC_table_learntby  = {}
local BC_table_maylearn  = {}
local BC_table_willlearn = {}


--[[
	Variables added to 'BCTooltip' frame

		BCTooltip.NbLines
		BCTooltip.LineWidth
		BCTooltip.LinkedTooltip  -- Linked tooltip frame, used when shown for attachment
--]]


-- Constants

BC_TIMER_CONFIRM           = 5.0     -- time duration for confirm button display
BC_COOLDOWN_DELAY          = 0.1     -- delay until next event acceptance

BC_BUTTONNAME_HEADER       = "BCUI_CheckButton_(.+)"

BC_COLOR_TOOLTIPS          = {r = 0.2, g = 0.2, b = 0.2 }
BC_COLOR_TOOLTIPS_KNOWNBY  = {r = 0.0, g = 0.7, b = 0.0 }
BC_COLOR_TOOLTIPS_MAYLEARN = {r = 0.0, g = 1.0, b = 0.0 }
BC_COLOR_TOOLTIPS_TOOHIGH  = {r = 0.7, g = 0.5, b = 0.0 }


-- Events to register

local BC_events_to_register =
{
	"ADDON_LOADED",           -- Watch addons loaded state, to hook with their functions
	"VARIABLES_LOADED",
	"CHAT_MSG_SKILL",
	"CHAT_MSG_SYSTEM",
	"CRAFT_SHOW",
	"CRAFT_UPDATE",
	"TRADE_SKILL_SHOW",
	"TRADE_SKILL_UPDATE",
	"UNIT_NAME_UPDATE",
	"PLAYER_ENTERING_WORLD",
	"LEARNED_SPELL_IN_TAB"
}


-- List of different craft plan/formula/manual/... headers

local BC_craft_headers =
{
	BC_SKILL_MANUAL,
	BC_SKILL_FORMULA,
	BC_SKILL_PATTERN,
	BC_SKILL_PLANS,
	BC_SKILL_RECIPE,
	BC_SKILL_SCHEMATIC
}


-- myAddOns information

local BC_myAddOnsDetails =
{
	name         = BC_ADDON_NAME,
	description  = BC_ADDON_DESC,
	version      = BC_VERSION,
	category     = MYADDONS_CATEGORY_PROFESSIONS,
	frame        = "BC_MainFrame",
	author       = "B. Legangneux",
	website      = "http://lostpapers.free.fr",
	optionsframe = "BCUI"
}

local BC_myAddOnsHelp =
{
	BC_MSG_USAGE,
}


-- Color Swatch functions

BCUI_SwatchFunc_SetColor =
{
	 ["Tooltips"]            = function(x) BCUI_SetColor_Tooltips( "Tooltips" ) end,
	 ["TooltipsKnownBy"]     = function(x) BCUI_SetColor_Tooltips( "TooltipsKnownBy" ) end,
	 ["TooltipsMayLearn"]    = function(x) BCUI_SetColor_Tooltips( "TooltipsMayLearn" ) end,
	 ["TooltipsRankTooHigh"] = function(x) BCUI_SetColor_Tooltips( "TooltipsRankTooHigh" ) end,
}

BCUI_SwatchFunc_CancelColor =
{
	 ["Tooltips"]            = function(x) BCUI_CancelColor_Tooltips( "Tooltips", x ) end,
	 ["TooltipsKnownBy"]     = function(x) BCUI_CancelColor_Tooltips( "TooltipsKnownBy", x ) end,
	 ["TooltipsMayLearn"]    = function(x) BCUI_CancelColor_Tooltips( "TooltipsMayLearn", x ) end,
	 ["TooltipsRankTooHigh"] = function(x) BCUI_CancelColor_Tooltips( "TooltipsRankTooHigh", x ) end,
}


-- Hooking

BookOfCrafts_Original = {}
BookOfCrafts_Hooks = {}

local Original = BookOfCrafts_Original
local Hooks = BookOfCrafts_Hooks

local dbg_AuctionFrameItem_calls = 0
local dbg_AuctionFrameItem_msg = nil

--[[
function BoC_HookFunction( function_name )

	local internal_name = string.gsub( function_name, ".", "_" )
	local hook_name = "hookBOC_"..internal_name
	if( not Original[internal_name] and getglobal( hook_name ) ) then
		Original[internal_name] = getglobal( function_name )
		setglobal( function_name, getglobal( hook_name ) )
		return true
	else
		BoC_ChatMsg( "Cannot hook to "..function_name )
		return false
	end

end
--]]


-------------------------------------------------------------------------------
-- Feedback functions
-------------------------------------------------------------------------------

function BoC_ChatMsg( msg, verbose_only )

	if( BC_variables_loaded and 
	    DEFAULT_CHAT_FRAME and 
		( verbose_only==nil or verbose_only==false or BookOfCrafts_Data.Options.ShowChatMsg) ) then

		DEFAULT_CHAT_FRAME:AddMessage( "[BoC] "..msg, 0.0, 1.0, 0.0 )

	end

end



-------------------------------------------------------------------------------
-- OnLoad
-------------------------------------------------------------------------------

function BoC_OnLoad()

	-- Register configuration frame
	UIPanelWindows["BCUI"] = { area = "center", pushable = 0 }

	-- Register events
	for index, event in BC_events_to_register do
		this:RegisterEvent( event )
	end

	-- Slash Commands
	SlashCmdList["BookOfCrafts"] = BoC_SlashHandler
	SLASH_BookOfCrafts1 = "/boc"
	SLASH_BookOfCrafts2 = "/bookofcrafts"

	-- Check loaded addons
	if( IsAddOnLoaded( "Blizzard_AuctionUI" ) ) then
		BoC_HookAddOn( "Blizzard_AuctionUI" )
	end

	if( IsAddOnLoaded( "AllInOneInventory" ) ) then
		BoC_HookAddOn( "AllInOneInventory" )
	end

	if( IsAddOnLoaded( "BankItems" ) ) then
		BoC_HookAddOn( "BankItems" )
	end

	if( IsAddOnLoaded( "Blizzard_AuctionUI" ) ) then
		BoC_HookAddOn( "Blizzard_AuctionUI" )
	end

	if( IsAddOnLoaded( "myAddOns" ) ) then
		BoC_HookAddOn( "myAddOns" )
	end


	-- Save original functions
	--BoC_HookFunction( "GameTooltip.SetAuctionSellItem" )
	--BoC_HookFunction( "GameTooltip.SetCraftItem" )
	--BoC_HookFunction( "GameTooltip.SetTradeSkillItem" )
	--BoC_HookFunction( "GameTooltip.SetInventoryItem" )
	--BoC_HookFunction( "GameTooltip.SetLootItem" )
	--BoC_HookFunction( "GameTooltip.SetMerchantItem" )
	--BoC_HookFunction( "GameTooltip.SetQuestItem" )
	--BoC_HookFunction( "GameTooltip.SetQuestLogItem" )
	--BoC_HookFunction( "GameTooltip_OnHide" )
	--BoC_HookFunction( "ChatFrame_OnHyperlinkShow" )
	--BoC_HookFunction( "AbandonSkill" )

	Original.GameTooltip_SetAuctionSellItem    = GameTooltip.SetAuctionSellItem
	Original.GameTooltip_SetAuctionItem        = GameTooltip.SetAuctionItem
	Original.GameTooltip_SetBagItem            = GameTooltip.SetBagItem
	Original.GameTooltip_SetCraftItem          = GameTooltip.SetCraftItem
	Original.GameTooltip_SetTradeSkillItem     = GameTooltip.SetTradeSkillItem
	Original.GameTooltip_SetInventoryItem      = GameTooltip.SetInventoryItem
	Original.GameTooltip_SetLootItem           = GameTooltip.SetLootItem
	Original.GameTooltip_SetMerchantItem       = GameTooltip.SetMerchantItem
	Original.GameTooltip_SetQuestItem          = GameTooltip.SetQuestItem
	Original.GameTooltip_SetQuestLogItem       = GameTooltip.SetQuestLogItem
	Original.GameTooltip_OnHide                = GameTooltip_OnHide
	Original.ChatFrame_OnHyperlinkShow         = ChatFrame_OnHyperlinkShow
	Original.AbandonSkill                      = AbandonSkill


	-- Hook to functions
	GameTooltip.SetAuctionSellItem    = hookBOC_GameTooltip_SetAuctionSellItem
	GameTooltip.SetAuctionItem        = hookBOC_GameTooltip_SetAuctionItem
	GameTooltip.SetBagItem            = hookBOC_GameTooltip_SetBagItem
	GameTooltip.SetCraftItem          = hookBOC_GameTooltip_SetCraftItem
	GameTooltip.SetTradeSkillItem     = hookBOC_GameTooltip_SetTradeSkillItem
	GameTooltip.SetInventoryItem      = hookBOC_GameTooltip_SetInventoryItem
	GameTooltip.SetLootItem           = hookBOC_GameTooltip_SetLootItem
	GameTooltip.SetMerchantItem       = hookBOC_GameTooltip_SetMerchantItem
	GameTooltip.SetQuestItem          = hookBOC_GameTooltip_SetQuestItem
	GameTooltip.SetQuestLogItem       = hookBOC_GameTooltip_SetQuestLogItem
	GameTooltip_OnHide                = hookBOC_GameTooltip_OnHide
	ChatFrame_OnHyperlinkShow         = hookBOC_ChatFrame_OnHyperlinkShow
	AbandonSkill                      = hookBOC_AbandonSkill


	-- Tooltip is hidden on load
	BoC_TooltipHide()
	BoC_ResetData()

end



-------------------------------------------------------------------------------
-- Hooking to specific addons
-------------------------------------------------------------------------------

function BoC_HookAddOn( addon_name )
	if( addon_name ) then

		-- Hook to Auction item display
		--if( addon_name=="Blizzard_AuctionUI" ) then
			--BoC_HookFunction( "AuctionFrameItem_OnEnter" )
			--Original.AuctionFrameItem_OnEnter = AuctionFrameItem_OnEnter
			--AuctionFrameItem_OnEnter = hookBOC_AuctionFrameItem_OnEnter
			--BoC_ChatMsg( "Hooked to Blizzard Auction addon.", true )
		--else
		
		
		if( addon_name=="AllInOneInventory" ) then

			--BoC_HookFunction( "AllInOneInventory_ModifyItemTooltip" )
			Original.AIOI_ModifyItemTooltip = AllInOneInventory_ModifyItemTooltip
			AllInOneInventory_ModifyItemTooltip = hookBOC_AllInOneInventory_ModifyItemTooltip
			BoC_ChatMsg( "Hooked to AllInOneInventory addon.", true )

		elseif( addon_name=="BankItems" ) then 
		
			--BoC_HookFunction( "BankItems_BagItem_OnEnter" )
			--BoC_HookFunction( "BankItems_Button_OnEnter" )
			Original.BankItems_BagItem_OnEnter = BankItems_BagItem_OnEnter
			BankItems_BagItem_OnEnter = hookBOC_BankItems_BagItem_OnEnter
			Original.BankItems_Button_OnEnter = BankItems_Button_OnEnter
			BankItems_Button_OnEnter = hookBOC_BankItems_Button_OnEnter
			BoC_ChatMsg( "Hooked to BankItems addon.", true )

		elseif( addon_name=="myAddOns" ) then

			myAddOnsFrame_Register( BC_myAddOnsDetails, BC_myAddOnsHelp )

		end
	end
end



-------------------------------------------------------------------------------
-- <OnEvent> handling
-------------------------------------------------------------------------------

function BoC_OnEvent( event, arg1 )

	if( event=="CHAT_MSG_SKILL" ) then

		BoC_UpdateSkillLevels( arg1 )

	elseif( event=="CHAT_MSG_SYSTEM" ) then

		BoC_UpdateKnownRecipes( arg1 )

	elseif( (event=="TRADE_SKILL_SHOW") or (event=="TRADE_SKILL_UPDATE") ) then

		BoC_TradeSkillUpdate()

	elseif( (event=="CRAFT_SHOW") or (event=="CRAFT_UPDATE") ) then

		BoC_CraftUpdate()

	elseif( event=="LEARNED_SPELL_IN_TAB" and BC_variables_loaded ) then

		-- Fired when a new spell/ability is added to the spellbook.
		-- (e.g. When training a new or a higher level spell/ability) 
		-- arg1 - Number of the tab which the spell/ability is added to
		BoC_ScanSpecials()

	elseif( event=="ADDON_LOADED" ) then

		BoC_HookAddOn( arg1 )

	elseif( event=="VARIABLES_LOADED" ) then

		BC_variables_loaded = true
		BoC_InitData()

	elseif( ((event=="UNIT_NAME_UPDATE") and (arg1=="player")) or (event=="PLAYER_ENTERING_WORLD") ) then

		local char_name = UnitName( "player" )
		if( (char_name~=nil) and (char_name~="") and (char_name~=UNKNOWNOBJECT) and (char_name~=UNKNOWNBEING) ) then
			BC_player_name_known = true
			BoC_InitData()
		end

	end


	--[[ SPELLS_CHANGED 
		Fired when :
		 - Learning new stuff that goes in the spellbook
		 - Opening the spellbook
		 - Changing/Equiping weapons. (Changes the Attack icon) 

		arg1 = nil --> when the char learns stuff. Also when changing weapons and shapeshifting. In addition it seems to be called on regular intervals for no apparent reason. 
		arg1 = #   --> when the user opens the spellbook. 
		arg1 = 'LeftButton' when using the mouse to open the spellbook or to browse through the pages and tabs of the open spellbook. 
	--]]
end



-------------------------------------------------------------------------------
--                             SLASH CMD HANDLING                            --
-------------------------------------------------------------------------------

function BoC_SlashHandler( msg_cmd )
	local msg_table = {}
	local cmd_ok = nil
	
	if( msg_cmd ) then

		for msg in string.gfind( msg_cmd, "(%a+)" ) do
			table.insert( msg_table, string.lower(msg) )
		end


		if( msg_table[1]==nil or msg_table[1]=="config" or msg_table[1]=="option" ) then
			-- Show config ---
			BCUI:Show()
			cmd_ok = true
		elseif( msg_table[1]=="delete" ) then
			-- Delete character data --
			BoC_DeleteCharacter( msg_table[2] )
			cmd_ok = true
		end

		-- Show usage if not a valid command
		if( cmd_ok==nil and DEFAULT_CHAT_FRAME ) then
			DEFAULT_CHAT_FRAME:AddMessage( BC_MSG_USAGE, 0.0, 1.0, 0.0 )
		end
	end
end



-------------------------------------------------------------------------------
--                             MAIN DATA HANDLING                            --
-------------------------------------------------------------------------------

function BoC_InitData()
	if( (BC_player_name_known) and (BC_variables_loaded) and (not BC_data_checked) ) then

		BC_char_name    = UnitName( "player" )  -- character name
		BC_char_realm   = GetCVar( "realmName" )  -- character realm
		BC_char_faction = UnitFactionGroup( "player" )  -- character faction


		-- Init general data

		if( not BookOfCrafts_Data.Characters ) then
			BookOfCrafts_Data.Characters = {}
		end

		if( not BookOfCrafts_Data.Options ) then
			BookOfCrafts_Data.Options     = {}
			BookOfCrafts_Data.Options.SameFaction = true
			BookOfCrafts_Data.Options.ShowSkillRank = true
			BookOfCrafts_Data.Options.ShowCurPlayer = true
		end

		if( not BookOfCrafts_Data.Version ) then
			BookOfCrafts_Data.Version = 0
		end

		if( not BookOfCrafts_Data.Options.Colors or tonumber(BookOfCrafts_Data.Version)==0.5 ) then
			BookOfCrafts_Data.Options.Colors = nil
			BookOfCrafts_Data.Options.Colors = {}
			BookOfCrafts_Data.Options.Colors.Tooltips = BC_COLOR_TOOLTIPS
			BookOfCrafts_Data.Options.Colors.TooltipsKnownBy = BC_COLOR_TOOLTIPS_KNOWNBY
			BookOfCrafts_Data.Options.Colors.TooltipsMayLearn = BC_COLOR_TOOLTIPS_MAYLEARN
			BookOfCrafts_Data.Options.Colors.TooltipsRankTooHigh = BC_COLOR_TOOLTIPS_TOOHIGH
		end


		-- Version upgrade

		if( tonumber(BookOfCrafts_Data.Version)<=0.6 ) then
			if( BookOfCrafts_Data.Options.CheckSkillRank ) then
				BookOfCrafts_Data.Options.CheckSkillRank = nil
			end
			BookOfCrafts_Data.Options.ShowSkillRank = true
		end
		
		if( tonumber(BookOfCrafts_Data.Version)<0.75 ) then
			BookOfCrafts_Data.Options.Colors.TooltipsKnownBy = BC_COLOR_TOOLTIPS_KNOWNBY
			BookOfCrafts_Data.Options.Colors.TooltipsMayLearn = BC_COLOR_TOOLTIPS_MAYLEARN
			BookOfCrafts_Data.Options.Colors.TooltipsRankTooHigh = BC_COLOR_TOOLTIPS_TOOHIGH
		end
		
		if( tonumber(BookOfCrafts_Data.Version)<0.76 ) then
			for index, character in BookOfCrafts_Data.Characters do
				character.Skills = {}
				for tradeskill, rank in character do
					if( tradeskill~="Name" and tradeskill~="Realm" and tradeskill~="Faction" and tradeskill~="Skills" and tradeskill~="Specials" ) then
						character.Skills[tradeskill] = rank
						character[tradeskill] = nil
					end
				end
			end
		end

		if( tonumber(BookOfCrafts_Data.Version)<0.80 ) then
			BoC_ChatMsg( "Converting to version 0.80" )
			for tradeskill, data in BookOfCrafts_Data do
				if( tradeskill~="Version" and tradeskill~="Options" and tradeskill~="Characters" ) then
					for object, object_info in data do
						local new_object = BoC_HandleCraftExceptions(string.lower(object))
					
						if( new_object~=object ) then
							--BoC_ChatMsg( object .. " -> " ..  new_object, true )
							BookOfCrafts_Data[tradeskill][new_object] = object_info
							BookOfCrafts_Data[tradeskill][object] = nil;
						end
					end
				end
			end
		end

		BookOfCrafts_Data.Version = BC_VERSION_DATA

		-- Find character name

		local nb_chars = table.getn( BookOfCrafts_Data.Characters )
		BC_char_index = nil

		for i = 1, nb_chars do
			if( (BookOfCrafts_Data.Characters[i].Name==BC_char_name) and
			    (BookOfCrafts_Data.Characters[i].Realm==BC_char_realm) and
			    (BookOfCrafts_Data.Characters[i].Faction==BC_char_faction) ) then
			    BC_char_index = i
			    break
			end
		end


		-- if not found, register new character
		if( BC_char_index==nil ) then
			BC_char_index = nb_chars+1
			BookOfCrafts_Data.Characters[BC_char_index] = {}
			BookOfCrafts_Data.Characters[BC_char_index].Skills  = {}
			BookOfCrafts_Data.Characters[BC_char_index].Name    = BC_char_name
			BookOfCrafts_Data.Characters[BC_char_index].Realm   = BC_char_realm
			BookOfCrafts_Data.Characters[BC_char_index].Faction = BC_char_faction
		end

		-- BC_SKILL_SPECIALS is formated without any space and with lower cases
		BC_SKILL_SPECIALS = string.gsub( string.lower( BC_SKILL_SPECIALS ), " ", "" )

		-- Scan for specials skills
		BoC_ScanSpecials()

		-- Data checked
		BC_data_checked = true

		-- Inform player
		BoC_ChatMsg( BC_MSG_INITIALIZED )
	
		--BoC_ChatMsg( BC_ERR_LEARN_RECIPE )
		--BoC_ChatMsg( BC_ERR_SKILL_UP )

	end

end



-------------------------------------------------------------------------------
--                           CRAFT SPECIALISATIONS                           --
-------------------------------------------------------------------------------

function BoC_ScanSpecials()
	local specials_table = {}
	local i = 1

	--[[
		API GetSpellName
		Retrieves the spell name and spell rank for a spell in the player's spellbook. 

		spellName, spellRank = GetSpellName( spellId, bookType )

		Arguments 
		spellId 
		Integer - Spell ID. Valid values are 1 through total number of spells in the spellbook on all pages and all tabs, ignoring empty slots. 
		bookType 
		String - Either BOOKTYPE_SPELL ("spell") or BOOKTYPE_PET ("pet"). 

		Returns 
		spellName 
		String - Name of the spell as it appears in the spellbook, eg. "Lesser Heal" 
		spellRank 
		String - The spell rank or type, eg. "Rank 3", "Racial Passive". This can be an empty string. Note: for the Enchanting trade skill at rank Apprentice, the returned string contains a trailing space, ie. "Apprentice ". This might be the case for other trade skills and ranks also. 
	]]--

	while true do
		local spellName, spellRank = GetSpellName( i, BOOKTYPE_SPELL )
		if not spellName then
			do break end
		end

		-- BC_SKILL_SPECIALS contains all known specialisations names, in lower case, each name enclosed by 2 '|'
		spellName = string.gsub( string.lower(spellName), " ", "" )
		if( string.find( BC_SKILL_SPECIALS, "|"..spellName.."|" ) ) then
			table.insert( specials_table, spellName )
		end

		i = i + 1
	end
	
	if( table.getn( specials_table )>0 ) then
		-- Best method to build a string without too much garbage: table.concat
		BookOfCrafts_Data.Characters[BC_char_index].Specials = table.concat( specials_table, "|" )
	else
		BookOfCrafts_Data.Characters[BC_char_index].Specials = nil
	end
end



-------------------------------------------------------------------------------
--                              CHARACTER DELETE                             --
-------------------------------------------------------------------------------

function BoC_DeleteCharacter( name )
	local char_index_delete = nil
	local char_info_delete = nil

	name = string.lower( name )

	-- Find right character index (given name, same realm as current one) --
	for key, char_info_delete in BookOfCrafts_Data.Characters do
		if( string.lower(char_info_delete.Name)==name and char_info_delete.Realm==BC_char_realm ) then
			char_index_delete = key
			break
		end
	end

	-- If character found, delete data
	if( char_index_delete ) then
		char_info_delete = BookOfCrafts_Data.Characters[char_index_delete]

		-- If deletion of current player, reset BC_char_index
		if( BC_char_index==char_index_delete ) then
			BC_char_index = nil
		end

		-- Remove all references to character in tradeskills table
		for skill_name, skill_rank in char_info_delete.Skills do
			if( skill_name and BookOfCrafts_Data[skill_name] ) then
				for crafted_object, object_data in BookOfCrafts_Data[skill_name] do
					for key, char_index in object_data.LearntBy do
						if( char_index==char_index_delete ) then
							table.remove( object_data.LearntBy, key )
							break
						end
					end
				end
			end
		end
		
		-- If char index to delete is not last index in character table,
		-- last character data will be moved to replace its data.
		-- Else, if it is last character data, it is simply deleted from table

		local nb_chars = table.getn( BookOfCrafts_Data.Characters )

		if( char_index_delete~=nb_chars ) then
			local char_info_move = BookOfCrafts_Data.Characters[nb_chars]

			-- Re-index all references to moved character in tradeskills
			for skill_name, skill_rank in char_info_move.Skills do
				if( skill_name and BookOfCrafts_Data[skill_name] ) then
					for crafted_object, object_data in BookOfCrafts_Data[skill_name] do
						for key, char_index in object_data.LearntBy do
							if( char_index==nb_chars ) then
								object_data.LearntBy[key] = char_index_delete
							end
						end
					end
				end
			end

			BookOfCrafts_Data.Characters[char_index_delete] = BookOfCrafts_Data.Characters[nb_chars]

			-- Update current char index if it was the index moved
			if( BC_char_index==nb_chars ) then
				BC_char_index = char_index_delete
			end
		end 

		-- Remove deleted/moved character info
		table.remove( BookOfCrafts_Data.Characters, nb_chars )

		-- If deleted data is current data, create an new empty data slot
		if( BC_char_index==nil ) then
			BC_char_index = table.getn( BookOfCrafts_Data.Characters )+1
			BookOfCrafts_Data.Characters[BC_char_index] = {}
			BookOfCrafts_Data.Characters[BC_char_index].Skills  = {}
			BookOfCrafts_Data.Characters[BC_char_index].Name    = BC_char_name
			BookOfCrafts_Data.Characters[BC_char_index].Realm   = BC_char_realm
			BookOfCrafts_Data.Characters[BC_char_index].Faction = BC_char_faction
			BoC_ScanSpecials()
		end

		BoC_ResetData()

		BoC_ChatMsg( char_info_delete.Name.." data deleted" )
	end
end



-------------------------------------------------------------------------------
--                                DATA UPDATE                                --
-------------------------------------------------------------------------------

-- Called when CHAT_MSG_SKILL occurs.
-- "chat_text" is the text line from chat window.

function BoC_UpdateSkillLevels( chat_text )

	if( chat_text ) then

		local character = BookOfCrafts_Data.Characters[BC_char_index]

		if( character ) then


			local _, _, tradeskill, new_rank = string.find( chat_text, BC_ERR_SKILL_UP )

			if( tradeskill and character.Skills[tradeskill] and new_rank ) then

				new_rank = tonumber(new_rank)

				if( new_rank and character.Skills[tradeskill]<new_rank ) then

					character.Skills[tradeskill] = new_rank
					BoC_ResetData()
					--BoC_ChatMsg( "New rank in "..tradeskill.." : "..new_rank, true )
				end

			end

		end

	end

end



-- Called when CHAT_MSG_SYSTEM occurs
-- "chat_text" is the text line from chat window.

function BoC_UpdateKnownRecipes( chat_text )

	local _, _, recipe_name =  string.find( chat_text, BC_ERR_LEARN_RECIPE )

	if( recipe_name ) then
		BoC_ChatMsg( "Please open your tradeskill/craft to update data" )
	end
end



function BoC_TradeSkillUpdate()

	if( BC_char_index ) then

		-- Get trade skill information
		local tradeskill, trade_rank = GetTradeSkillLine()

		if( tradeskill ) then

			local character = BookOfCrafts_Data.Characters[BC_char_index]

			-- Update character skill rank
			if( trade_rank and (character.Skills[tradeskill]==nil or character.Skills[tradeskill]<trade_rank) ) then
				character.Skills[tradeskill] = trade_rank
				BoC_ChatMsg( "New rank in "..tradeskill.." : "..trade_rank, true )
			end

			-- Initialize data with new tradeskill if needed
			if( BookOfCrafts_Data[tradeskill]==nil ) then
				BookOfCrafts_Data[tradeskill] = {}
			end

			-- Record all trade skills with BC_char_index information.
			-- If skill was already registered, add BC_char_index to list

			for i=1, GetNumTradeSkills() do
			
				local crafted_object, skill_type = GetTradeSkillInfo( i )

				if( (skill_type~="header") and crafted_object ) then
					local found = nil
					
					crafted_object = BoC_HandleCraftExceptions( crafted_object )

					if( BookOfCrafts_Data[tradeskill][crafted_object]==nil ) then
						BookOfCrafts_Data[tradeskill][crafted_object] = {}
						BookOfCrafts_Data[tradeskill][crafted_object].LearntBy = {}
					else
						for key, char_index in BookOfCrafts_Data[tradeskill][crafted_object].LearntBy do
							if( char_index==BC_char_index ) then
								found = true
								break
							end
						end
					end

					if( found==nil ) then
						-- this adds character index to skill info
						table.insert( BookOfCrafts_Data[tradeskill][crafted_object].LearntBy, BC_char_index )
						BoC_ResetData()
					end

					-- Add Created item name to database, if it exists
					local item_name = BoC_ExtractNameFromLink( GetTradeSkillItemLink( i ) )
					if( item_name ) then
						BookOfCrafts_Data[tradeskill][crafted_object].Item = item_name
					end

				end
			end
		end
	end
end



function BoC_CraftUpdate()

	if( BC_char_index ) then

		-- Get trade skill information
		local tradeskill, trade_rank = GetCraftDisplaySkillLine()

		if( tradeskill ) then

			local character = BookOfCrafts_Data.Characters[BC_char_index]

			-- Update character skill rank
			if( trade_rank and (character.Skills[tradeskill]==nil or character.Skills[tradeskill]<trade_rank) ) then
				character.Skills[tradeskill] = trade_rank
				BoC_ChatMsg( "New rank in "..tradeskill.." : "..trade_rank, true )
			end

			-- Initialize data with new tradeskill table if needed
			if( BookOfCrafts_Data[tradeskill]==nil ) then
				BookOfCrafts_Data[tradeskill] = {}
			end

			-- Register all crafts to data with BC_char_index information.
			-- If skill was already registered, just add BC_char_index to list
			for i=1, GetNumCrafts() do
				local crafted_object, skill_type = GetCraftInfo( i )

				if( (skill_type~="header") and crafted_object ) then
					
					local found = nil

					crafted_object = BoC_HandleCraftExceptions( crafted_object )

					if( BookOfCrafts_Data[tradeskill][crafted_object]==nil ) then
						BookOfCrafts_Data[tradeskill][crafted_object] = {}
						BookOfCrafts_Data[tradeskill][crafted_object].LearntBy = {}
					else
						for key, char_index in BookOfCrafts_Data[tradeskill][crafted_object].LearntBy do
							if( char_index==BC_char_index ) then
								found = true
								break
							end
						end
					end

					if( not found ) then
						-- this adds character index to skill info
						table.insert( BookOfCrafts_Data[tradeskill][crafted_object].LearntBy, BC_char_index )
						BoC_ResetData()
					end

					-- Add Created item name to database, if it exists
					local object_from_link = BoC_ExtractNameFromLink( GetCraftItemLink( i ) )
					if( object_from_link ) then
						BookOfCrafts_Data[tradeskill][crafted_object].Item = object_from_link
					end

				end
			end
		end
	end
end



-------------------------------------------------------------------------------
--                          CONFIGURATION INTERFACE                          --
-------------------------------------------------------------------------------


-- Toggle display of config frame

function BoC_ToggleConfigFrame()

	if( BCUI:IsVisible() ) then

		HideUIPanel( BCUI )

		 -- Check if the options frame was opened by myAddOns
		if( MYADDONS_ACTIVE_OPTIONSFRAME==BCUI ) then
			ShowUIPanel( myAddOnsFrame )
		end

	else
		ShowUIPanel( BCUI )
	end
end



function BCUI_CheckButtonTemplate_OnShow()

	local button_name = this:GetName()
	
	if( button_name ) then
		
		
		local option_name = string.gsub( button_name, BC_BUTTONNAME_HEADER, "%1" )
		if( option_name ) then
			-- Set state
			local state = BookOfCrafts_Data.Options[option_name]
			
			if( not state ) then
				state = 0
			end
			
			this:SetChecked( state )

			-- Set Label Text
			getglobal( button_name.."Text" ):SetText( getglobal(button_name.."_Label") )
		end

	end

end



function BCUI_CheckButtonTemplate_OnClick()

	local button_name = this:GetName()
	
	if( button_name ) then
		local option_name = string.gsub( button_name, BC_BUTTONNAME_HEADER, "%1" )
		if( option_name ) then
			BookOfCrafts_Data.Options[option_name] = this:GetChecked()

			BoC_ChatMsg( option_name.." changed.", true )

			if( option_name=="UseSideTooltip" ) then
				BCTooltip.LinkedTooltip = nil
				ItemRefTooltip.bocDone = nil
				GameTooltip.bocDone = nil
			end
		end
	end

end



function BCUI_SetInfo( text )

	if( text=="help" ) then
		BCUI_InfoText:SetText( getglobal( this:GetName().."_Help" ) )
	else
		BCUI_InfoText:SetText( "" )
	end

end



function BCUI_OnShow()

	-- Tab Handling code
	PanelTemplates_SetNumTabs( this, 2 )
	PanelTemplates_SetTab( BCUI, 1 )

	BCUI_Data:Hide()
	BCUI_Options:Show()

	-- Init Tooltips Color Swatch
	for color_name, color_value in BookOfCrafts_Data.Options.Colors do

		BCUI_ColorTemplate_SetColor( color_name, color_value.r, color_value.g, color_value.b )

		local color_swatch = getglobal( "BCUI_Color_"..color_name.."_ColorSwatch" )
		color_swatch.swatchFunc = BCUI_SwatchFunc_SetColor[color_name]
		color_swatch.cancelFunc = BCUI_SwatchFunc_CancelColor[color_name]
		
		local label  = getglobal( "BCUI_Color_"..color_name.."_ColorSwatchText" )
		label:SetText( getglobal( "BCUI_Color_"..color_name.."_Label" ) )

	end

	-- Initialize tradeskills list

	FauxScrollFrame_SetOffset( BCUI_Data_ScrollFrame, 0 )
	BCUI_Data_OnScroll()

end



-- Called by "BCUI_ColorTemplate" OnClick event

function BCUI_OpenColorPicker()

	CloseMenus()

	local color_swatch = this

	ColorPickerFrame.func           = color_swatch.swatchFunc
	ColorPickerFrame.cancelFunc     = color_swatch.cancelFunc
	ColorPickerFrame.previousValues = { r = color_swatch.r, g = color_swatch.g, b = color_swatch.b }

	ColorPickerFrame:SetColorRGB( color_swatch.r, color_swatch.g, color_swatch.b )
	ColorPickerFrame:Show()

end



function BCUI_SetColor_Tooltips( color_name )

	local set_red, set_green, set_blue = ColorPickerFrame:GetColorRGB()

	BCUI_ColorTemplate_SetColor( color_name, set_red, set_green, set_blue )

end



function BCUI_CancelColor_Tooltips( color_name, prev )

	BCUI_ColorTemplate_SetColor( color_name, prev.r, prev.g, prev.b )

end



function BCUI_ColorTemplate_SetColor( color_name, set_red, set_green, set_blue )

	local swatch_bg = getglobal( "BCUI_Color_"..color_name.."_ColorSwatchNormalTexture" )
	swatch_bg:SetVertexColor( set_red, set_green, set_blue )

	local color_swatch  = getglobal( "BCUI_Color_"..color_name.."_ColorSwatch" )
	color_swatch.r = set_red
	color_swatch.g = set_green
	color_swatch.b = set_blue

	BookOfCrafts_Data.Options.Colors[color_name] = {r = set_red, g = set_green, b = set_blue}

end


-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

function BCUI_DropDownCharacters_OnShow()
	UIDropDownMenu_Initialize( this, BCUI_DropDownCharacters_Initialize )
	if( BookOfCrafts_Data.Characters and BookOfCrafts_Data.Characters[1] ) then
		UIDropDownMenu_SetSelectedID( this, 1 )
--		UIDropDownMenu_SetText( BookOfCrafts_Data.Characters[1].Name, BCUI_DropDownCharacters )
		local text = getglobal( "BCUI_DropDownCharactersText" )
		if( text ) then
			text:SetText( BookOfCrafts_Data.Characters[1].Name )
		end
	end
end



-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

function BCUI_DropDownCharacters_Initialize()

	local info = {}
	local characters = BookOfCrafts_Data.Characters
	local nb_characters = table.getn(characters)

	info.func  = BCUI_DropDownCharacters_OnClick

	for i=1, nb_characters do
		info.text  = characters[i].Name
		info.value = i
		UIDropDownMenu_AddButton( info )
	end

	if( nb_characters>0 ) then
		UIDropDownMenu_SetSelectedID( BCUI_DropDownCharacters, 1 )
	end
end



function BCUI_DropDownCharacters_OnClick()

	--UIDropDownMenu_SetSelectedID( this, this:GetID() )
     UIDropDownMenu_SetSelectedValue( BCUI_DropDownCharacters, this.value )

	local id = UIDropDownMenu_GetSelectedID( BCUI_DropDownCharacters )

	--if( id ) then
	--	BoC_ChatMsg( "Selected "..id )
	--else
	--	BoC_ChatMsg( "Selection (no id)" )
	--end
end



function BCUI_ButtonDelete_OnClick()

	local id = UIDropDownMenu_GetSelectedID( BCUI_DropDownCharacters )

	BCUI_ButtonConfirm:Show()
	BC_timer_confirm = BC_TIMER_CONFIRM + BC_timer

end



function BCUI_ButtonConfirm_OnClick()

	local id = UIDropDownMenu_GetSelectedID( BCUI_DropDownCharacters )

	if( id ) then
		BoC_DeleteCharacter( BookOfCrafts_Data.Characters[id].Name )
		BC_timer_confirm = 0
		BCUI_ButtonConfirm:Hide()
	end
end



function BCUI_TabTemplate_OnClick( index )

	if ( not index ) then
		index = this:GetID()
	end
	
	PanelTemplates_SetTab( BCUI, index )
	
	if( index==1 ) then
		BCUI_Data:Hide()
		BCUI_Options:Show()
	else
		BCUI_Options:Hide()
		BCUI_Data:Show()
	end

	PlaySound("igCharacterInfoTab")
end




-------------------------------------------------------------------------------
--                         OBJECT ANALYSIS FUNCTIONS                         --
-------------------------------------------------------------------------------

function BoC_GetCraftedObjectFromHeader( header )

	if( header ) then
		-- Optim: If no ':', it cannot be a craft item
		if( string.find( header, ":" ) ) then 
			-- Look for each possible header
			for index=1, table.getn(BC_craft_headers) do
				local _, _, skill = string.find( header, BC_craft_headers[index].."(.+)" )
				if( skill ) then
					return string.lower(skill)
				end
			end
		end
	end

	return nil
end



function BoC_CharKnowsCraftedObject( char_index, tradeskill, crafted_object )

	if( BookOfCrafts_Data[tradeskill]~=nil and BookOfCrafts_Data[tradeskill][crafted_object]~=nil ) then
		for key, value in BookOfCrafts_Data[tradeskill][crafted_object].LearntBy do
			if( value==char_index ) then
				return true
			end
		end
	end
	
	return false
end



-- Returns list of alts who : know skill, may learn skill, will be able to learn skill

function BoC_GetAltsInfo( tradeskill, crafted_object, skill_requirement, special_requirement )

	local BC_table_learntby = {}
	local BC_table_maylearn = {}
	local BC_table_willlearn = {}

	if( special_requirement ) then
		special_requirement = string.gsub( string.lower( special_requirement ), " ", "" )
	end

	if( tradeskill and crafted_object ) then

		-- Find Alts who knowns this craft already

		if( BookOfCrafts_Data[tradeskill]~=nil and BookOfCrafts_Data[tradeskill][crafted_object]~=nil ) then

			-- BookOfCrafts_Data[tradeskill][crafted_object].LearntBy is evaluated only once

			for key, char_index in BookOfCrafts_Data[tradeskill][crafted_object].LearntBy do
				if( (BookOfCrafts_Data.Options.ShowCurPlayer~=nil) or (char_index~=BC_char_index) ) then
					local char_info = BookOfCrafts_Data.Characters[char_index]
					if( (char_info.Realm==BC_char_realm) and
					    ((BookOfCrafts_Data.Options.SameFaction==nil) or (char_info.Faction==BC_char_faction)) ) then
						table.insert( BC_table_learntby, char_info.Name )
					end
				end						
			end
		end



		-- Find Alts who may learn this craft

		local tip_text


		for char_index, char_info in BookOfCrafts_Data.Characters do
			-- Check if...
			--    (optional) Char is an alt AND                   
			--    Char is from current realm AND       
			--    (optional) Char faction is ok AND
			--    Char knows this craft AND       
			--    Char does not already know the skill AND

			if( ((BookOfCrafts_Data.Options.ShowCurPlayer~=nil) or (char_index~=BC_char_index)) and                                    
				(char_info.Realm==BC_char_realm) and                          
				((BookOfCrafts_Data.Options.SameFaction==nil) or (char_info.Faction==BC_char_faction)) and
				(char_info.Skills[tradeskill]~=nil) and
				(BoC_CharKnowsCraftedObject( char_index, tradeskill, crafted_object )==false)
			  ) then
				-- Skill rank has to be displayed
				if( BookOfCrafts_Data.Options.ShowSkillRank ) then
					tip_text = char_info.Name.." ("..char_info.Skills[tradeskill]..")"
				else
					tip_text = char_info.Name
				end

				if( special_requirement==nil or (char_info.Specials and string.find( char_info.Specials, special_requirement )) ) then
					if( char_info.Skills[tradeskill]>=skill_requirement) then
						table.insert( BC_table_maylearn, tip_text )
					else
						table.insert( BC_table_willlearn, tip_text )
					end
				end
		
			end
			
		end
	end

	return BC_table_learntby, BC_table_maylearn, BC_table_willlearn
end



-------------------------------------------------------------------------------
-- TOOLTIP HANDLING
-------------------------------------------------------------------------------


-- Clear tooltip content

function BoC_TooltipClear()

	BoC_TooltipHide()

	for i=1, 12 do
		local line = getglobal("BCTooltipText"..i)
		line:Hide()
		line:SetTextColor( 1.0, 1.0, 1.0 )
		line:SetFont( "Fonts\\FRIZQT__.TTF", 10 )
	end

	BCTooltip.NbLines   = 0
	BCTooltip.LineWidth = 0

end



-------------------------------------------------------------------------------
-- Tooltip functions
-------------------------------------------------------------------------------

function BoC_TooltipAddLine( text, r, g, b )
	if( BCTooltip.NbLines<12 ) then
		local line_num = BCTooltip.NbLines + 1
		local line = getglobal( "BCTooltipText"..line_num )

		if( text==nil or text=="" ) then
			text = " "
		end

		line:SetTextColor( r, g, b )
		line:SetText( text )
		line:Show()

		if( text~=" ") then
			local line_width = line:GetWidth() + 20

			if( line_width > BCTooltip.LineWidth ) then
				BCTooltip.LineWidth = line_width
			end
		end

		BCTooltip.NbLines = line_num
	end
end


-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

function BoC_ExtractNameFromLink( link )

	local name = nil

	if( link ) then
		_, _, name = string.find( link, "|c%x+|Hitem:%d+:%d+:%d+:%d+|h%[(.-)%]|h|r" )
	end

	return name

end





-------------------------------------------------------------------------------
-- Hooks
-------------------------------------------------------------------------------

function hookBOC_AbandonSkill( index )
	--   Hook to AbandonSkill, to clean database from removed skill
	--   index : index of skill in character skill list

	Original.AbandonSkill( index )

	local character = BookOfCrafts_Data.Characters[BC_char_index]
	local tradeskill, header = GetSkillLineInfo( index )
	
	if( not header ) then

		tradeskill = BoC_HandleCraftExceptions( tradeskill )

		if( character.Skills[tradeskill] ) then
			character.Skills[tradeskill] = nil
		end

		BoC_ChatMsg( "Forgetting skill "..tradeskill..".", true )
		if( BookOfCrafts_Data[tradeskill] ) then
			for crafted_object, object_data in BookOfCrafts_Data[tradeskill] do
				for key, char_index in object_data.LearntBy do
					if( char_index==BC_char_index ) then
						table.remove( object_data.LearntBy, key )
						BoC_ResetData()
						break
					end
				end
			end
		end
	end
end



function hookBOC_BankItems_BagItem_OnEnter()
	Original.BankItems_BagItem_OnEnter()
	BoC_AnalyseTooltip( GameTooltip )
end

function hookBOC_BankItems_Button_OnEnter()
	Original.BankItems_Button_OnEnter()
	BoC_AnalyseTooltip( GameTooltip )
end

-- HOOK TO: Quest description - Useful when a quest loot is a recipe
function hookBOC_GameTooltip_SetQuestItem( this, quest_type, slot )
	Original.GameTooltip_SetQuestItem( this, quest_type, slot )
	BoC_AnalyseTooltip( GameTooltip )
end

-- HOOK TO: GameTooltip for quest log
function hookBOC_GameTooltip_SetQuestLogItem( this, quest_type, slot )
	Original.GameTooltip_SetQuestLogItem( this, quest_type, slot )
	BoC_AnalyseTooltip( GameTooltip )
end

-- HOOK TO: GameTooltip for auction sold item
function hookBOC_GameTooltip_SetAuctionSellItem( this )
	Original.GameTooltip_SetAuctionSellItem( this )
	BoC_AnalyseTooltip( GameTooltip )
end

-- HOOK TO: GameTooltip for auction sold item
function hookBOC_GameTooltip_SetAuctionItem( this, type, index )
	Original.GameTooltip_SetAuctionItem( this, type, index )
	BoC_AnalyseTooltip( GameTooltip )
end

-- HOOK TO: GameTooltip for bag item
function hookBOC_GameTooltip_SetBagItem( this, bagId, itemId )
	local hasCooldown, repairCost = Original.GameTooltip_SetBagItem( this, bagId, itemId )	
	BoC_AnalyseTooltip( GameTooltip )
	return hasCooldown, repairCost
end

-- HOOK TO: GameTooltip for loot
function hookBOC_GameTooltip_SetLootItem( this, slot )
	Original.GameTooltip_SetLootItem( this, slot )
	BoC_AnalyseTooltip( GameTooltip )
end

-- HOOK TO: GameTooltip Bag item display
--    cf 'GameTooltip:SetInventoryItem' notes
--    cf 'GetContainerItemLink' notes
function hookBOC_GameTooltip_SetInventoryItem( this, bagId, itemId )
	local hasCooldown, repairCost = Original.GameTooltip_SetInventoryItem( this, bagId, itemId )
	BoC_AnalyseTooltip( GameTooltip )
	return hasCooldown, repairCost
end


-- HOOK TO: Auction item display
--[[
function hookBOC_AuctionFrameItem_OnEnter( type, index )

	-- Avoid stack overflow
	if( dbg_AuctionFrameItem_calls==0 ) then

		dbg_AuctionFrameItem_calls = 1
		Original.AuctionFrameItem_OnEnter( type, index )
		dbg_AuctionFrameItem_calls = 0
		BoC_AnalyseTooltip( GameTooltip )

	elseif( not dbg_AuctionFrameItem_msg ) then

		dbg_AuctionFrameItem_msg = true
		BoC_ChatMsg( "Recursive call to AuctionFrameItem_OnEnter detected. An addon seems to be wrongly hooked to this function", true )

	end
end
--]]

function hookBOC_AllInOneInventory_ModifyItemTooltip( bag, slot, tooltipName )
	Original.AIOI_ModifyItemTooltip( bag, slot, tooltipName )

	if ( not InRepairMode() and tooltipName=="GameTooltip" ) then
		BoC_AnalyseTooltip( GameTooltip )
	end
end

function hookBOC_ChatFrame_OnHyperlinkShow( reference, link, button )
	Original.ChatFrame_OnHyperlinkShow( reference, link, button )
	BoC_AnalyseTooltip( ItemRefTooltip )
end

-- HOOK TO: GameTooltip for merchant item
function hookBOC_GameTooltip_SetMerchantItem( this, slot )
	Original.GameTooltip_SetMerchantItem( this, slot )
	BoC_AnalyseTooltip( GameTooltip )
end

function hookBOC_GameTooltip_SetCraftItem(this, skill, slot)
	Original.GameTooltip_SetCraftItem( this, skill, slot )
	BoC_AnalyseTooltip( GameTooltip )
end

function hookBOC_GameTooltip_SetTradeSkillItem(this, skill, slot)
	Original.GameTooltip_SetTradeSkillItem( this, skill, slot )
	BoC_AnalyseTooltip( GameTooltip )
end

function hookBOC_GameTooltip_OnHide()

	-- Different behavior if using embedded results or not
	if( BC_data_checked ) then
		if( BookOfCrafts_Data.Options.UseSideTooltip ) then
			-- Check if linked tooltip is the one hidden
			if( BCTooltip.LinkedTooltip and this:GetName()==BCTooltip.LinkedTooltip:GetName() ) then

				-- Hide BoC results
				BoC_TooltipHide()

				-- Unlink
				BCTooltip.LinkedTooltip = nil
			end
		else
			this.bocDone = nil
		end
	end

	-- Call original function
	if( Original.GameTooltip_OnHide ) then
		Original.GameTooltip_OnHide()
	end

end

--function hookBOC_ContainerFrame_Update( frame )
--	Original.ContainerFrame_Update( frame )
--	BoC_AnalyseTooltip( GameTooltip )
--end

--function hookBOC_ContainerFrameItemButton_OnEnter()
--	Original.ContainerFrameItemButton_OnEnter()
--	if( not InRepairMode() ) then
--		BoC_AnalyseTooltip( GameTooltip )
--	end
--end

--function hookBOC_ContainerFrameItemButton_OnUpdate( elapsed_time )
--	Original.ContainerFrameItemButton_OnUpdate( elapsed_time )
--	BoC_AnalyseTooltip( GameTooltip )
--end

--function hookBOC_BankFrameItemButton_OnUpdate()
--	Original.BankFrameItemButton_OnUpdate()
--	BoC_AnalyseTooltip( GameTooltip )
--end


-------------------------------------------------------------------------------
-- <OnUpdate> event handling
-------------------------------------------------------------------------------

function BoC_OnUpdate( time_elapsed )

	-- Count elapsed time
	BC_timer = BC_timer + time_elapsed

	-- Check 'Confirm' button status if countdown in progress
	-- and set back to 'Delete' when countdown reached
	if( BC_timer_confirm>0 and BC_timer>BC_timer_confirm ) then
		BC_timer_confirm = 0
		BCUI_ButtonConfirm:Hide()
	end


	-- Check visible tooltips
	if( not BookOfCrafts_Data.Options.UseSideTooltip or not BCTooltip.LinkedTooltip ) then

		if( ItemRefTooltip and ItemRefTooltip:IsVisible() ) then
			BoC_AnalyseTooltip( ItemRefTooltip )
		end
		
		if( GameTooltip and GameTooltip:IsVisible() ) then
			BoC_AnalyseTooltip( GameTooltip )
		end
	end

	return BC_timer

end



-------------------------------------------------------------------------------
-- Reset check mechanism: Call it when tradeskill data has changed, to update
-- BoC results
-------------------------------------------------------------------------------

function BoC_ResetData()
	-- Mark stored results as obsolete
	BC_last_recipe = nil

	-- Unlink side tooltip
	BCTooltip.LinkedTooltip = nil

	-- Update tooltip display on next update
--	BC_check_tooltips = true
end


-------------------------------------------------------------------------------
-- Various recipe patterns are not named accordingly to their skill name.
-- This function fixes those names.
-------------------------------------------------------------------------------

function BoC_HandleCraftExceptions( skill_name )
	if( skill_name ) then

		skill_name = string.lower( skill_name )

		if( BookOfCrafts_Exceptions[skill_name] ) then
			skill_name = BookOfCrafts_Exceptions[skill_name]

		--BoC_ChatMsg( "Exception fix --> "..skill_name, true )
		--elseif( GetLocale=="frFR" ) then
		--	result_name = string.gsub( item_name, " Enchantement d", " Ench. d" )
		--else
		--	result_name = string.gsub( item_name, " Transmute ", " Transmute: " )
		end
	end

	return skill_name
end

-------------------------------------------------------------------------------
-- This function displays BoC results, according to provided tooltip content.
--
-- PARAMETERS
--    tooltip - Tooltip frame, generally "GameTooltip" or "ItemRefTooltip"
--
-- RETURN
--    none
-------------------------------------------------------------------------------

function BoC_AnalyseTooltip( tooltip )

	if( tooltip and not tooltip.bocDone and not BC_analysing_tooltip ) then

		-- Mark tooltip update in progress
		BC_analysing_tooltip = true

		-- Get tooltip frame name
		local tooltip_name = tooltip:GetName()

		-- Get first lines of tooltip and possible recipe name
		local item_name = getglobal( tooltip_name.."TextLeft1" ):GetText()
		local item_req  = getglobal( tooltip_name.."TextLeft2" ):GetText()

		-- If item_name is registered as an exception, use variant name
		-- item_name = BoC_HandleRecipeExceptions( item_name )

		-- Extract crafted object name
		local crafted_object = BoC_GetCraftedObjectFromHeader( item_name )

		-- Analyse tooltip data if we are dealing with a tradeskill/craft object
		if( crafted_object and item_req ) then 

			-- Local results only needs an update if it is not the same object than last one analysed
			if( BC_last_recipe~=item_name ) then

				-- Record recipe name
				BC_last_recipe = item_name

				-- Get craft/tradeskill information from object tooltip title, if tooltip
				-- shows a recipe

				local tradeskill = nil
				local skill_requirement = nil
				_, _, tradeskill, skill_requirement = string.find( item_req, BC_SKILL_REQUISITE )

				if( tradeskill and skill_requirement ) then

					-- Check for a special requirement
					local special_requirement = nil
					local tooltip_text = getglobal( tooltip_name.."TextLeft3" ):GetText()

					if( tooltip_text and string.find( tooltip_text, BC_SKILL_REQUIRE_SPECIAL ) ) then
						special_requirement = string.gsub( tooltip_text, BC_SKILL_REQUIRE_SPECIAL, "" )
					end
					
					-- Update stored data with skill (if new) and rank
					if( BookOfCrafts_Data[tradeskill]==nil ) then
						BookOfCrafts_Data[tradeskill] = {}
					end

					if( BookOfCrafts_Data[tradeskill][crafted_object]==nil ) then
						BookOfCrafts_Data[tradeskill][crafted_object] = {}
						BookOfCrafts_Data[tradeskill][crafted_object].LearntBy = {}
					end

					BookOfCrafts_Data[tradeskill][crafted_object].Rank  = skill_requirement

					-- Get characters lists
					BC_table_learntby, BC_table_maylearn, BC_table_willlearn = BoC_GetAltsInfo( tradeskill, crafted_object, tonumber(skill_requirement), special_requirement )

				else

					BC_table_learntby  = {}
					BC_table_maylearn  = {}
					BC_table_willlearn = {}

				end

			end

		else

			-- Record that no object is analysed
			BC_last_recipe = nil
			BC_table_learntby  = {}
			BC_table_maylearn  = {}
			BC_table_willlearn = {}

		end

		-- Display Results
		BoC_ShowResults( tooltip )

		-- Tooltip update is finished
		BC_analysing_tooltip	= nil
	end
end



function BoC_ShowResults( tooltip )

	-- Display results

	local color_tooltip_knownby = BookOfCrafts_Data.Options.Colors.TooltipsKnownBy
	local color_tooltip_maylearn = BookOfCrafts_Data.Options.Colors.TooltipsMayLearn
	local color_tooltip_ranktoohigh = BookOfCrafts_Data.Options.Colors.TooltipsRankTooHigh

	local found_alts = nil

	if( BookOfCrafts_Data.Options.UseSideTooltip ) then

		if( BC_last_recipe ) then

			-- Clear tooltip content
			BoC_TooltipClear()

			-- Fill side tooltip 

			if( table.getn( BC_table_learntby )>0 ) then
				BoC_TooltipAddLine( BC_SKILL_KNOWN, color_tooltip_knownby.r, color_tooltip_knownby.g, color_tooltip_knownby.b )
				for i=1, table.getn( BC_table_learntby ) do
					BoC_TooltipAddLine( "  "..BC_table_learntby[i], color_tooltip_knownby.r, color_tooltip_knownby.g, color_tooltip_knownby.b )
				end
				found_alts = true
			end

			if( table.getn( BC_table_maylearn )>0 ) then
				BoC_TooltipAddLine( BC_SKILL_MAYLEARN, color_tooltip_maylearn.r, color_tooltip_maylearn.g, color_tooltip_maylearn.b )
				for i=1, table.getn( BC_table_maylearn ) do
					BoC_TooltipAddLine( "  "..BC_table_maylearn[i], color_tooltip_maylearn.r, color_tooltip_maylearn.g, color_tooltip_maylearn.b )
				end
				found_alts = true
			end

			if( table.getn( BC_table_willlearn )>0 ) then
				BoC_TooltipAddLine( BC_SKILL_WILLLEARN, color_tooltip_ranktoohigh.r, color_tooltip_ranktoohigh.g, color_tooltip_ranktoohigh.b )
				for i=1, table.getn( BC_table_willlearn ) do
					BoC_TooltipAddLine( "  "..BC_table_willlearn[i], color_tooltip_ranktoohigh.r, color_tooltip_ranktoohigh.g, color_tooltip_ranktoohigh.b )
				end
				found_alts = true
			end
			
			if( not found_alts ) then
				BoC_TooltipAddLine( BC_SKILL_UNKNOWN_UNLEARNABLE, 1.0, 1.0, 1.0 )
			end

			BoC_TooltipShow( tooltip )

		else

			-- No recipe data, so hide side tooltip
			BoC_TooltipHide()

		end

	else

		-- Mark tooltip as analysed
		tooltip.bocDone = true

		if( BC_last_recipe ) then

			local learntby  = nil
			local maylearn  = nil
			local willlearn = nil

			-- Because of garbage collector mechanism, concatenation of string should
			-- be made through table.concat(). It is NOT recommended to do
			-- "alt_list = alt_list .. text" in loop

			if( table.getn( BC_table_learntby )>0 ) then
				learntby = BC_SKILL_KNOWN..table.concat( BC_table_learntby, ", " )
			end

			if( table.getn( BC_table_maylearn )>0 ) then
				maylearn = BC_SKILL_MAYLEARN .. table.concat( BC_table_maylearn, ", " )
			end

			if( table.getn( BC_table_willlearn )>0 ) then
				willlearn = BC_SKILL_WILLLEARN .. table.concat( BC_table_willlearn, ", " )
			end
			
			
			-- Embed into given tooltip

			tooltip:AddLine( " ", 0, 0, 0 )
			tooltip:SetHeight( tooltip:GetHeight() + 14 )

			if( learntby ) then
				tooltip:AddLine( learntby, color_tooltip_knownby.r, color_tooltip_knownby.g, color_tooltip_knownby.b )
				tooltip:SetHeight( tooltip:GetHeight() + 14 )
				found_alts = true
			end

			if( maylearn ) then
				tooltip:AddLine( maylearn, color_tooltip_maylearn.r, color_tooltip_maylearn.g, color_tooltip_maylearn.b )
				tooltip:SetHeight( tooltip:GetHeight() + 14 )
				found_alts = true
			end

			if( willlearn ) then
				tooltip:AddLine( willlearn, color_tooltip_ranktoohigh.r, color_tooltip_ranktoohigh.g, color_tooltip_ranktoohigh.b )
				tooltip:SetHeight( tooltip:GetHeight() + 14 )
				found_alts = true
			end

			if( not found_alts ) then
				tooltip:AddLine( BC_SKILL_UNKNOWN_UNLEARNABLE, color_tooltip_knownby.r, color_tooltip_knownby.g, color_tooltip_knownby.b )
				tooltip:SetHeight( tooltip:GetHeight() + 14 )
			end

		end

	end

end



-------------------------------------------------------------------------------
-- Show BoC extra tooltip with aposiiton relative to given tooltip frame
-------------------------------------------------------------------------------

function BoC_TooltipShow( frame )

	local nb_lines = BCTooltip.NbLines

	if( nb_lines>0 and frame ) then

		local line_width = BCTooltip.LineWidth

		-- Set height and width
		--local height = 20 
		--currentLine = getglobal( "BCTooltipText"..nb_lines )
		--height = height + currentLine:GetBottom() + 1

		-- Set height and width
		local height = 20 
		for i = 1, nb_lines do
			local currentLine = getglobal("BCTooltipText"..i)
			height = height + currentLine:GetHeight() + 2
		end

		BCTooltip:SetHeight( height )
		BCTooltip:SetWidth( line_width )

		-- Position tooltip relatively to linked tooltip
		BCTooltip:ClearAllPoints()

		local frame_left = (frame:GetLeft() or 0) - line_width
		local frame_right = GetScreenWidth() - (frame:GetRight() or 0) - line_width

		if( frame_left<frame_right ) then
			BCTooltip:SetPoint( "TOPLEFT", frame:GetName(), "TOPRIGHT", 5, 0 )
		else
			BCTooltip:SetPoint( "TOPRIGHT", frame:GetName(), "TOPLEFT", -5, 0 )
		end

		-- Show
		local color_tooltip = BookOfCrafts_Data.Options.Colors.Tooltips
		BCTooltip:SetBackdropColor( color_tooltip.r, color_tooltip.g, color_tooltip.b )
		BCTooltip:Show()

	else
		-- Hide tooltip as there is no text to display or no frame to attach too
		BoC_TooltipHide()
	end

	-- Record linked tooltip (for side tooltip)
	BCTooltip.LinkedTooltip = frame

end



-------------------------------------------------------------------------------
-- Hide tooltips
-------------------------------------------------------------------------------

function BoC_TooltipHide()
	BCTooltip:Hide()
end


-------------------------------------------------------------------------------
-- Tradeskills list handling 
-------------------------------------------------------------------------------

function BCUI_Data_OnScroll()

	-- 20 = table.getn( BC_skills_data )

	-- FauxScrollFrame_Update( frame, numItems, numToDisplay, valueStep )

	local offset = FauxScrollFrame_GetOffset( BCUI_Data_ScrollFrame )

	FauxScrollFrame_Update( BCUI_Data_ScrollFrame, 20, 12, 16 )

	for line = 1, 12 do
		if( (line+offset) < 20 ) then
			getglobal( "BCUI_Data_Line"..line.."Text" ):SetText( "BCUI_Data_Line "..(line+offset) )
			getglobal( "BCUI_Data_Line"..line):Show()
		else
			getglobal( "BCUI_Data_Line"..line):Hide()
		end
	end
end

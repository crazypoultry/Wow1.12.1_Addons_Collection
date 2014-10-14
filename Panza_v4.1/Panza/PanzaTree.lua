----------------------------------
-- PanzaTree.lua
-- Version 4.0
-- for in pairs() completed for BC
----------------------------------

function PA:Tree_OnLoad()
	PA.GUIFrames[this:GetName()] = this;
	UIPanelWindows[this:GetName()] = {area = "center", pushable = 0};
	--local ebf = getglobal(this:GetName().."Tree".."ExpandButtonFrame");
	--ebf:SetPoint("TOPLEFT", ebf:GetParent():GetName(), "TOPLEFT", 50, 1); 
 
end


-- Displays child attached to right-hand side of parent
function PA:FrameAttach(parent, child, id)
	if (PA.LastOptFrame~=nil and PA.LastOptFrame~=child and PA.LastOptFrame:IsVisible()) then
		--PA:ShowText("close old frame ", child:GetName());
		PA.LastOptFrame:Hide();
	end
	if (child:IsVisible()) then
		--PA:ShowText("hide same frame ", child:GetName());
		child:Hide();
		PA.LastOptFrame = nil;
	else
		--PA:ShowText("show frame ", child:GetName());
		child:ClearAllPoints();
		child:SetPoint("TOPLEFT", parent, "TOPRIGHT", 0, 0);
		child:Show();
		PA.LastOptFrame = child;
		PA.LastOptId = id;
	end
	GameTooltip:Hide();
end

function PA:AddBranch(tree, info)

	local Entry = {};
	Entry.title = info.Title;
	if (info.Frame~=nil) then
		Entry.value = info.Frame;
		Entry.onClick = function (frame, id) PA:FrameAttach(PanzaTreeFrame, frame, id) end;
	end
	--Entry.tooltip = tooltip;
	Entry.collapsed = true;
	Entry.noTextIndent = false;
	if (info.Check~=nil) then
		Entry.check = false; --true;  
		Entry.checked = info.Check;
		Entry.children = {};
	end

	table.insert(tree, Entry);	
	return Entry;

end

---------------------------
-- Build Options Menu Tree
---------------------------
function PA:BuildOptionsMenuTree()
	
	local ModuleTree = {};
	--PA:ShowText("ESCable #Frames=", (PA:TableSize(PA.GUIFrames)));
	for _, Entry in pairs(PA.OptionsMenuTree) do
		local OkToAdd = true;
		if (Entry.Filter~=nil) then
			if (Entry.Filter.Spell~=nil) then
				local Spell = PA.Spells.Default[Entry.Filter.Spell];
				--PA:ShowText("Filter.Spell=", Entry.Filter.Spell, " Spell=", Spell);
				if (Spell==nil) then
					Spell = Entry.Filter.Spell;
				end
				OkToAdd = PA:SpellInSpellBook(Spell);
				--PA:ShowText("Spell=", Spell, " OK=", OkToAdd);
			end
			if (OkToAdd==true and Entry.Filter.Class~=nil) then
				OkToAdd = (PA.PlayerClass==Entry.Filter.Class);
				--PA:ShowText("Class=", Entry.Filter.Class, " OK=", OkToAdd);
			end
		end
		if (OkToAdd) then
			local NewEntry = PA:AddBranch(ModuleTree, Entry);
			if (Entry.Sub~=nil) then
				for _, SubEntry in pairs(Entry.Sub) do
					PA:AddBranch(NewEntry.children, SubEntry);
				end
			end
		end
	end
	--ModuleTree = {{title="t1", right="r1"}, {title="t2", right="r2"}};
	PanzaTree_LoadEnhanced(PanzaTreeFrameTree, ModuleTree);
	--PanzaTree_LoadTable(PanzaTreeFrameTree, {"a", "b", "c", {"d", "e"}});
	PanzaTree_UpdateFrame(PanzaTreeFrameTree); 
end

--		Each enhanced table entry may contain the following:
--
--		{
--			prefix - Extra field in front of title
--			prefixColor - Colour of field in front of title
--			title - the title text
--			titleColor - the color of the title 
--			right - the text bound to the right side
--			rightColor - the color of the right text
--
--			disabled - true if the text cannot be clicked.
--			
--			check - true if a checkbox exists, false if not
--			checked - true if the checkbox is checked, false if not
--			checkDisabled - true if the checkbox is disable, false if not
--
--			radio - uses radio artwork instead of checkbox artwork
--			radioSelected - true if the radio is active, false if not
--			radioDisabled - true if the radio button is disabled
--
--			onClick - function called when the text is clicked
--			onCheck - function called when the checkbox is checked or unchecked
--			onRadio - function called when the radio button is clicked
--
--			tooltip - tooltip text when the text is moused-over
--			checkTooltip - tooltip text when the checkbox is moused-over
--			radioTooltip - tooltip text when the radiobox is moused-over
--			expandTooltip - tooltip text when the expandbox is moused-over
--			
--			noTextIndent - the item will not indent children an extra amount 
--
--			children - a table of enhanced entrys
--			childrenOverride - true if the + should show up even if there are 0 children
--			collapsed - true if the child elements are collapsed(hidden)
--		}
--[[
--
--	Panza (was Earth) Tree
--
--		An easy way of rendering structured data.
--
--		by Alexander Brazie
--		Shamelessly borrowed by the Panza team
--
--]]
 
PANZATREE_MAXTITLE_COUNT = 30;
PANZATREE_TITLE_HEIGHT = 16;
PANZATREE_EXPAND_INDENT = 16;
PANZATREE_COLOR_NUMBER = NORMAL_FONT_COLOR;
PANZATREE_COLOR_STRING = NORMAL_FONT_COLOR;
PANZATREE_COLOR_BOOLEAN = GRAY_FONT_COLOR;
PANZATREE_COLOR_NIL = RED_FONT_COLOR;
PANZATREE_COLOR_TABLE = RED_FONT_COLOR;
PANZATREE_COLOR_FUNCTION = GREEN_FONT_COLOR;
PANZATREE_COLOR_UNKNOWN = GRAY_FONT_COLOR;
PANZATREE_DEFAULT_FONT = ChatFontNormal;
PANZATREE_DEFAULT_HIGHLIGHT_COLOR = HIGHLIGHT_FONT_COLOR;

--[[
--
--	Using PanzaTree
--
--	Create a Frame which uses PanzaTreeTemplate. 
--
--	Usage:
--		Call either PanzaTree_LoadTable or PanzaTree_LoadEnhanced, 
--		Then call PanzaTree_UpdateFrame to draw to the screen.
--
--
--	Load a normal Lua table using
--	
--	PanzaTree_LoadTable(
--		getglobal("YourFrameName"), 
--		tableOfData,
--		functionTable,
--		keyOrder
--		);
--
--	functionTable may contain:
--		onClick - function called when the text is clicked
--			arguments to onClick are:
--				arg1 - table showing the parent hierarchy of the clicked item
--		onCheck - function called when the checkbox is checked or unchecked
--			arguments to onCheck are:
--				arg1 - check state (value or nil)
--				arg2 - table showing the parent hierarchy of the clicked item
--
--			returns:
--				true - the checkbox will be set
--				false - the checkbox will be unset
--				nil - set to whatever state was sent to it.
--
--	Load an enhanced (customized) table using:
--
--	PanzaTree_LoadEnhanced(
--		getglobal("YourFrameName"),
--		enhancedTable
--		);
--
--	enhancedTable is a table of numerically indexed elements. 
--		Each enhanced table entry may contain the following:
--
--		{
--			prefix - Extra field in front of title
--			prefixColor - Colour of field in front of title
--			title - the title text
--			titleColor - the color of the title 
--			right - the text bound to the right side
--			rightColor - the color of the right text
--
--			disabled - true if the text cannot be clicked.
--			
--			check - true if a checkbox exists, false if not
--			checked - true if the checkbox is checked, false if not
--			checkDisabled - true if the checkbox is disable, false if not
--
--			radio - uses radio artwork instead of checkbox artwork
--			radioSelected - true if the radio is active, false if not
--			radioDisabled - true if the radio button is disabled
--
--			onClick - function called when the text is clicked
--			onCheck - function called when the checkbox is checked or unchecked
--			onRadio - function called when the radio button is clicked
--
--			tooltip - tooltip text when the text is moused-over
--			checkTooltip - tooltip text when the checkbox is moused-over
--			radioTooltip - tooltip text when the radiobox is moused-over
--			expandTooltip - tooltip text when the expandbox is moused-over
--			
--			noTextIndent - the item will not indent children an extra amount 
--
--			children - a table of enhanced entrys
--			childrenOverride - true if the + should show up even if there are 0 children
--			collapsed - true if the child elements are collapsed(hidden)
--		}
--
--	Each PanzaTreeFrame has the following modifiable properties:
--		titleCount - the number of title(rows) shown in the tree
--		highlight - true if the frame will highlight the last clicked item
--		highlightSize - "long" or "short" (short is buggy)
--		
--		tooltip - a string which represents the name of the tooltip used
--		tooltipPlacement - "cursor","button" or "frame"
--		tooltipAnchor - a string which is any valid tooltip anchor
--
--		activeTable - the frame's activeTable
--		
--		collapseAllButton - true if the collapseAll button is shown
--
--		keyOrder is a list of keys to use, in the order you want to use them.
--]]

--[[ Load a generic table for the Frame ]]--
function PanzaTree_LoadTable(frame, data, funcTable, keyOrder, maxDepth)
	local newEnhancedTable = {};

	if (PA:CheckMessageLevel("Core", 0)) then
		if ( not data ) then PA:Message4("Attempt to send nil data to "..frame:GetName().." from "..this:GetName()); end
	end
	if ( not funcTable ) then funcTable = {}; end
	
	-- Since we can only load 2 levels of depth
	-- We simply parse the first set of keys/values
	if ( type(keyOrder) ~= "table" ) then 
		for k,v in pairs(data) do 
			local entry = PanzaTree_CreateEntry(k,v,funcTable);

			-- Set the tooltip
			entry.tooltip = nil; -- No tooltip!

			table.insert(newEnhancedTable, entry);
		end
	else
		for k,v in pairs(keyOrder) do 
			local entry = PanzaTree_CreateEntry(v,data[v],funcTable,nil,{data},maxDepth);

			-- Set the tooltip
			entry.tooltip = nil; -- No tooltip!

			table.insert(newEnhancedTable, entry);
		end
	end

	--[[ Load it ]]--
	PanzaTree_LoadEnhanced(frame, newEnhancedTable);
end

--[[ Loads an Enhanced (Complex) Table for the Frame ]]--
function PanzaTree_LoadEnhanced(frame, earthTable)
	if ( PanzaTree_CheckFrame(frame) and PanzaTree_CheckTable(earthTable) ) then
		frame.activeTable = earthTable;
		return true;
	else
		if (PA:CheckMessageLevel("Core", 0)) then
			PA:Message4("Invalid data in LoadEnhanced");
		end
		return nil;
	end
	
end

--[[ Retrieves an Enhanced (Complex) Table from the Frame ]]--
function PanzaTree_GetEnhanced(frame)
	if (frame.activeTable) then 
		return frame.activeTable;
	end	
end


--[[ Updates the frame with values from the frame.activeTable object ]]--
function PanzaTree_UpdateFrame(frame)
	local flat = {};
	if ( not frame ) then 
		return;
	end

	-- Hide the highlight frame
	if ( getglobal(frame:GetName().."HighlightFrame") ) then
		getglobal(frame:GetName().."HighlightFrame"):Hide();
	end

	-- Check if there's a table
	if ( frame.activeTable ) then
		flat = PanzaTree_MakeFlatTable(frame.activeTable);
		local index = 0;
		
		if (frame.titleCount > PANZATREE_MAXTITLE_COUNT) then
			PA:DisplayText(frame.titleCount, " exceeds PANZATREE_MAXTITLE_COUNT (",PANZATREE_MAXTITLE_COUNT,")");
			frame.titleCount = PANZATREE_MAXTITLE_COUNT;
		end
		
		for id=1, frame.titleCount do 
			index = FauxScrollFrame_GetOffset(getglobal(frame:GetName().."ListScrollFrame")) + id;
			local value = flat[index];

			if ( value ) then 
				PanzaTree_AddItem(frame,value,id);
			else
				PanzaTree_ClearItem(frame,id);
			end

		end
		for id=frame.titleCount+1, PANZATREE_MAXTITLE_COUNT do 
			PanzaTree_ClearItem(frame,id);
		end
		PA:Debug(index, ",", frame.titleCount);
		
	end

	-- Toggles the collapseAllButton
	if ( frame.collapseAllButton ) then
		if ( getglobal(frame:GetName().."Expand") ) then
			getglobal(frame:GetName().."Expand"):Show();
		end		

		-- Shows or hides the artwork
		if ( frame.collapseAllArtwork ) then
			--getglobal(frame:GetName().."ExpandCollapseAllTabLeft"):SetTexture("Interface\\QuestFrame\\UI-QuestLogSortTab-Left");
			--getglobal(frame:GetName().."ExpandCollapseAllTabMiddle"):SetTexture("Interface\\QuestFrame\\UI-QuestLogSortTab-Middle");
			--getglobal(frame:GetName().."ExpandCollapseAllTabRight"):SetTexture("Interface\\QuestFrame\\UI-QuestLogSortTab-Right");
		else
			--getglobal(frame:GetName().."ExpandCollapseAllTabLeft"):SetTexture();
			--getglobal(frame:GetName().."ExpandCollapseAllTabMiddle"):SetTexture();
			--getglobal(frame:GetName().."ExpandCollapseAllTabRight"):SetTexture();
		end
	else
		if ( getglobal(frame:GetName().."Expand") ) then
			getglobal(frame:GetName().."Expand"):Hide();
		end
	end

	-- ScrollFrame update
	FauxScrollFrame_Update(getglobal(frame:GetName().."ListScrollFrame"), table.getn(flat), frame.titleCount, PANZATREE_TITLE_HEIGHT, nil, nil, nil, getglobal(frame:GetName().."HighlightFrame"), getglobal(frame:GetName().."HighlightFrame"):GetWidth(), getglobal(frame:GetName().."HighlightFrame"):GetHeight() );

end

--[[ Obtains an item from a GUI index ]]--
function PanzaTree_GetItemByID( frame, id ) 
	local nth = id + FauxScrollFrame_GetOffset(getglobal(frame:GetName().."ListScrollFrame"));
	local tableD = PanzaTree_MakeFlatTable(frame.activeTable);

	return tableD[nth];
end

--[[
--	Obtains a tooltip for a specific frame/id
--
--]]
function PanzaTree_GetTooltipText(frame, id, ttype)
	local item = PanzaTree_GetItemByID(frame,id);
	if ( item ) then
		local tooltip = "";
		if ( type(item.tooltip) == "function" ) then 
			tooltip = item.tooltip(item.value, ttype);
		else
			tooltip = item.tooltip;
		end

		if ( ttype == "CHECK" ) then 
			if ( type(item.checkTooltip) == "function" ) then 
				tooltip = item.checkTooltip(item.value, ttype);
			elseif ( type (item.checkTooltip) ~= "nil" ) then
				tooltip = item.checkTooltip;
			end
		elseif ( ttype == "RADIO" ) then 
			if ( type(item.radioTooltip) == "function" ) then 
				tooltip = item.radioTooltip(item.value, ttype);
			elseif ( type (item.radioTooltip) ~= "nil" ) then
				tooltip = item.radioTooltip;
			end
		end
		
		return tooltip;
	else
		return nil;
	end
end


--[[
--
--	Functions beyond this point are tool function and not meant for general use.
--
--	-Alex
--
--]]



--[[
--
--	PanzaTree_AddItem(
--		frame - the frame to add the item
--		item - the table containing the item values
--		i - the current index to be updated
--		depth - the number of recursions performed
--		)
--
--	Returns: 
--		i, total
--		i - the new i
--		total - the new total of non-collapsed tree items
--
--]]
function PanzaTree_AddItem(frame, item, i, depth) 
	if ( not i ) then i = 1; end
	if ( not depth ) then depth = 0; end

	if ( i > frame.titleCount ) then 
		-- Do nothing
		-- and PanzaTree_CheckItem(item)
	elseif ( PanzaTree_CheckFrame(frame) ) then
	
		-- If an item exits
		if ( item ) then
			local ldepth = item.depth-1;
			local pdepth = 0;
			local title = item.title; 

			local titleColor = nil;
			if ( type ( title ) == "function" ) then 
				title, titleColor = title();
			end
			if ( not titleColor ) then titleColor = item.titleColor; end
						
			PA:Debug(frame:GetName(), ": ", i, " ", title);

			if ( item.disabled ) then 
				getglobal(frame:GetName().."Title"..i.."Button"):Disable();
				getglobal(frame:GetName().."Title"..i.."Button"):SetDisabledTextColor(titleColor.r, titleColor.g, titleColor.b);
			else
				getglobal(frame:GetName().."Title"..i.."Button"):Enable();
			end
			
			-- Title
			if ( title ) then 
				getglobal(frame:GetName().."Title"..i):Show();
				if ( titleColor ) then 
					getglobal(frame:GetName().."Title"..i.."Button"):SetText(title);
					-- Inset																	
					getglobal(frame:GetName().."Title"..i.."Button"):SetTextColor(titleColor.r, titleColor.g, titleColor.b);
					
					getglobal(frame:GetName().."Title"..i.."Button").r = titleColor.r;
					getglobal(frame:GetName().."Title"..i.."Button").g = titleColor.g;
					getglobal(frame:GetName().."Title"..i.."Button").b = titleColor.b;
				else							
					getglobal(frame:GetName().."Title"..i.."Button"):SetText(title);
					getglobal(frame:GetName().."Title"..i.."Button"):SetTextColor(PANZATREE_COLOR_NUMBER.r,PANZATREE_COLOR_NUMBER.g,PANZATREE_COLOR_NUMBER.b);

					getglobal(frame:GetName().."Title"..i.."Button").r = PANZATREE_COLOR_NUMBER.r;
					getglobal(frame:GetName().."Title"..i.."Button").g = PANZATREE_COLOR_NUMBER.g;
					getglobal(frame:GetName().."Title"..i.."Button").b = PANZATREE_COLOR_NUMBER.b;
				end
				--PA:ShowText("Setting ", frame:GetName(), "Title", i, " from", getglobal(frame:GetName().."Title"..i):GetParent():GetName(), " width ", getglobal(frame:GetName().."Title"..i):GetParent():GetWidth()-20);
				getglobal(frame:GetName().."Title"..i):SetWidth(getglobal(frame:GetName().."Title"..i):GetParent():GetWidth()-40);

				
			else
				getglobal(frame:GetName().."Title"..i.."Button"):Hide();	
			end

			-- Tag
			local rightText = item.right;
			local rightColor = nil;
			
			if ( type ( rightText ) == "function" ) then 
				rightText, rightColor = rightText();
			end			
			if ( not rightColor ) then rightColor = item.rightColor; end
			
			PA:Debug(frame:GetName(),": ",i," ",rightText);
			
			if ( rightText ) then 				
				getglobal(frame:GetName().."Title"..i.."Tag"):Show();
				if ( rightColor ) then 
					getglobal(frame:GetName().."Title"..i.."Tag"):SetText(rightText);
					getglobal(frame:GetName().."Title"..i.."Tag"):SetTextColor(rightColor.r, rightColor.g, rightColor.b);
					
					getglobal(frame:GetName().."Title"..i.."Tag").r = rightColor.r;
					getglobal(frame:GetName().."Title"..i.."Tag").g = rightColor.g;
					getglobal(frame:GetName().."Title"..i.."Tag").b = rightColor.b;
				else			
					getglobal(frame:GetName().."Title"..i.."Tag"):SetText(rightText);
					getglobal(frame:GetName().."Title"..i.."Tag"):SetTextColor(PANZATREE_COLOR_STRING.r,PANZATREE_COLOR_STRING.g,PANZATREE_COLOR_STRING.b);
					
					getglobal(frame:GetName().."Title"..i.."Tag").r = PANZATREE_COLOR_STRING.r;
					getglobal(frame:GetName().."Title"..i.."Tag").g = PANZATREE_COLOR_STRING.g;
					getglobal(frame:GetName().."Title"..i.."Tag").b = PANZATREE_COLOR_STRING.b;
				end

			else
				getglobal(frame:GetName().."Title"..i.."Tag"):Hide();
			end

			-- Title Prefix
			local prefix = item.prefix;
			local prefixColor = nil;

			if ( type ( prefix ) == "function" ) then 
				prefix, prefixColor = prefix();
			else
				prefixColor = item.prefixColor; 
			end

			if ( prefix ) then
				getglobal(frame:GetName().."Title"..i.."ButtonPrefix"):Show();

				if ( prefixColor ) then
					getglobal(frame:GetName().."Title"..i.."ButtonPrefix"):SetText(prefix);
					getglobal(frame:GetName().."Title"..i.."ButtonPrefix"):SetTextColor(prefixColor.r, prefixColor.g, prefixColor.b);
					
					getglobal(frame:GetName().."Title"..i.."ButtonPrefix").r = prefixColor.r;
					getglobal(frame:GetName().."Title"..i.."ButtonPrefix").g = prefixColor.g;
					getglobal(frame:GetName().."Title"..i.."ButtonPrefix").b = prefixColor.b;
				else			
					getglobal(frame:GetName().."Title"..i.."ButtonPrefix"):SetText(prefix);
					getglobal(frame:GetName().."Title"..i.."ButtonPrefix"):SetTextColor(PANZATREE_COLOR_STRING.r,PANZATREE_COLOR_STRING.g,PANZATREE_COLOR_STRING.b);
					
					getglobal(frame:GetName().."Title"..i.."ButtonPrefix").r = PANZATREE_COLOR_STRING.r;
					getglobal(frame:GetName().."Title"..i.."ButtonPrefix").g = PANZATREE_COLOR_STRING.g;
					getglobal(frame:GetName().."Title"..i.."ButtonPrefix").b = PANZATREE_COLOR_STRING.b;
				end
				-- use a FontString object to get the size of our prefix text in pixel.
				getglobal(frame:GetName().."Title"..i.."PrefixSize"):SetText( prefix )
				getglobal(frame:GetName().."Title"..i.."ButtonPrefix"):SetWidth(getglobal(frame:GetName().."Title"..i.."PrefixSize"):GetStringWidth());
				getglobal(frame:GetName().."Title"..i.."PrefixSize"):SetText("")
			else
				getglobal(frame:GetName().."Title"..i.."ButtonPrefix"):Hide();
			end

			-- Checkbox Text?
			if ( item.check ) then 
				-- Indent the check symbol
				getglobal(frame:GetName().."Title"..i.."Check"):SetPoint("LEFT",frame:GetName().."Title"..i,"LEFT",PANZATREE_EXPAND_INDENT*(ldepth)-2, 2 );

				getglobal(frame:GetName().."Title"..i.."Check"):Show();

				-- If might be checked...
				if ( item.checked ) then 
					getglobal(frame:GetName().."Title"..i.."Check"):SetChecked(1);
				else
					getglobal(frame:GetName().."Title"..i.."Check"):SetChecked(nil);
				end

				-- If its disabled...
				if ( item.checkDisabled ) then
					getglobal(frame:GetName().."Title"..i.."Check"):Disable();
				else
					getglobal(frame:GetName().."Title"..i.."Check"):Enable();
				end

				-- Indent
				ldepth = ldepth + 1;

			else
				getglobal(frame:GetName().."Title"..i.."Check"):Hide();
			end

			-- Radio Box?
			if ( item.radio ) then 
				-- Indent the check symbol
				getglobal(frame:GetName().."Title"..i.."Radio"):SetPoint("LEFT",frame:GetName().."Title"..i,"LEFT",PANZATREE_EXPAND_INDENT*(ldepth)-2, 2 );

				getglobal(frame:GetName().."Title"..i.."Radio"):Show();

				-- If might be checked...
				if ( item.radioSelected ) then 
					getglobal(frame:GetName().."Title"..i.."Radio"):SetChecked(1);
				else
					getglobal(frame:GetName().."Title"..i.."Radio"):SetChecked(nil);
				end

				-- If its disabled...
				if ( item.radioDisabled ) then
					getglobal(frame:GetName().."Title"..i.."Radio"):Disable();
				else
					getglobal(frame:GetName().."Title"..i.."Radio"):Enable();
				end

				-- Indent
				ldepth = ldepth + 1;

			else
				getglobal(frame:GetName().."Title"..i.."Radio"):Hide();
			end

			-- display the highlight
			if ( frame.highlight ) then
				-- Check if its the selected item
				if ( PanzaTree_GetSelected(frame) == item ) then 
					--- Highlight Sizes
					local HLFrame = getglobal(frame:GetName().."HighlightFrame");
					if ( frame.highlightSize == "short" ) then 						
						HLFrame:ClearAllPoints();
						HLFrame:SetPoint("TOPLEFT", frame:GetName().."Title"..i, "TOPLEFT", PANZATREE_EXPAND_INDENT*(ldepth), -1);
					else
						--PA:ShowText(frame:GetName().."Title"..i.." Width =", getglobal(frame:GetName().."Title"..i):GetWidth());
						HLFrame:SetAllPoints(frame:GetName().."Title"..i);
						--PA:ShowText("HighlightFrame Width =", HLFrame:GetWidth());

					end
					
					-- If there's a highlight color
					if ( frame.highlightColor ) then
						getglobal(frame:GetName().."HighlightFrameHighlight"):SetVertexColor(frame.highlightColor.r,frame.highlightColor.g,frame.highlightColor.b);
					else
						getglobal(frame:GetName().."HighlightFrameHighlight"):SetVertexColor(PANZATREE_DEFAULT_HIGHLIGHT_COLOR.r,PANZATREE_DEFAULT_HIGHLIGHT_COLOR.g,PANZATREE_DEFAULT_HIGHLIGHT_COLOR.b);
					end

					-- Render the highlight
					getglobal(frame:GetName().."HighlightFrame"):Show();
				end					
			end

			-- all children items
			if ( item.children and (table.getn(item.children) > 0 or item.childrenOverride) ) then
				-- Indent the + symbol
				getglobal(frame:GetName().."Title"..i.."Expand"):SetPoint("TOPLEFT",frame:GetName().."Title"..i,"TOPLEFT",PANZATREE_EXPAND_INDENT*(ldepth) -2, 2 );
				getglobal(frame:GetName().."Title"..i.."Expand"):Enable(); 
				getglobal(frame:GetName().."Title"..i.."Expand"):Show(); 
				
				-- Ignore collapsed items
				if ( item.collapsed ) then 
					getglobal(frame:GetName().."Title"..i.."Expand"):SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up");
				else
					getglobal(frame:GetName().."Title"..i.."Expand"):SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up"); 
					getglobal(frame:GetName().."Title"..i.."Expand".."Highlight"):SetTexture("Interface\\Buttons\\UI-PlusButton-Hilight");
					
				end
			else
				getglobal(frame:GetName().."Title"..i.."Expand"):Hide(); 
				getglobal(frame:GetName().."Title"..i.."Expand"):Disable(); 
				getglobal(frame:GetName().."Title"..i.."Expand"):SetNormalTexture(""); 
				getglobal(frame:GetName().."Title"..i.."Expand".."Highlight"):SetTexture("");		
			end

			-- Indent the text further if its marked as indented
			if ( not item.noTextIndent ) then 
				ldepth = ldepth + 1;
			end

			-- Indent Prefix
			if ( item.prefix ) then
				getglobal(frame:GetName().."Title"..i.."ButtonPrefix"):SetPoint("TOPLEFT",frame:GetName().."Title"..i,"TOPLEFT",( 8 + PANZATREE_EXPAND_INDENT * ldepth ), 0 );
				pdepth = 8 + getglobal(frame:GetName().."Title"..i.."ButtonPrefix"):GetWidth();
			end

			-- Indent the text
			local titleIndent = (ldepth * PANZATREE_EXPAND_INDENT) + pdepth;
			getglobal(frame:GetName().."Title"..i.."Button"):SetPoint("TOPLEFT",frame:GetName().."Title"..i,"TOPLEFT", titleIndent, 0 );
			getglobal(frame:GetName().."Title"..i.."Button"):SetWidth( getglobal(frame:GetName().."Title"..i):GetWidth() - titleIndent );
			
			-- Set the text width
			if ( item.right ) then
				local newWidth =  getglobal(frame:GetName().."Title"..i):GetWidth() - getglobal(frame:GetName().."Title"..i.."Tag"):GetStringWidth() - ldepth * PANZATREE_EXPAND_INDENT - 2;
				-- Ideally this should be changed so frame scrolls left/right, needs looking at.
				if (newWidth < 1) then
					newWidth = 1;
				end
				getglobal(frame:GetName().."Title"..i.."ButtonText"):SetWidth( newWidth );
			else
				local newWidth = getglobal(frame:GetName().."Title"..i):GetWidth() - ldepth * PANZATREE_EXPAND_INDENT - 2;
				-- Ideally this should be changed so frame scrolls left/right, needs looking at.
				if (newWidth < 1) then
					newWidth = 1;
				end
				getglobal(frame:GetName().."Title"..i.."ButtonText"):SetWidth( newWidth );
			end
		end
	end
	
	return i;
end

--[[ Clear's a Tree's Item ]]--
function PanzaTree_ClearItem(frame, i ) 
	if ( i > 0  and i <= PANZATREE_MAXTITLE_COUNT ) then
		getglobal(frame:GetName().."Title"..i):Hide();
		getglobal(frame:GetName().."Title"..i.."Tag"):Hide();
		getglobal(frame:GetName().."Title"..i.."Check"):Hide();
		getglobal(frame:GetName().."Title"..i.."Expand"):Disable(); 
		getglobal(frame:GetName().."Title"..i.."Expand"):SetNormalTexture(""); 
		getglobal(frame:GetName().."Title"..i.."Expand".."Highlight"):SetTexture("");		
	end
end


--[[ Makes a flat tree from the activeTable, skipping collapsed trees according to setting ]]--

function PanzaTree_MakeFlatTable(theTable, depth, ignoreCollapsed)
	if ( not depth ) then depth = 0; end
	if ( ignoreCollapsed == nil ) then ignoreCollapsed = true; end
	local flatTable = {};
	local myTable = theTable;
	local i = 0;

	-- If the table doesnt exist, then the flat table is empty
	if ( myTable == nil ) then 
		return {};
	end

	for k,v in pairs(myTable) do
		v.depth = depth;
		table.insert(flatTable, v);

		if ( v.children and (not v.collapsed or ignoreCollapsed == false ) ) then 
			local flatChildren = PanzaTree_MakeFlatTable(v.children, depth + 1, ignoreCollapsed);

			for k2,v2 in pairs(flatChildren) do
				table.insert(flatTable,v2);
			end		
		end
	end

	return flatTable;
end

--[[ Collapses a Tree ]]--
function PanzaTree_SetItemCollapsed( frame, id, state ) 
	local count = 0;
	local nth = id+FauxScrollFrame_GetOffset(getglobal(frame:GetName().."ListScrollFrame"));
	local myTable = PanzaTree_MakeFlatTable(frame.activeTable);

	if ( myTable[nth] ) then
		myTable[nth].collapsed = state;
	end

	PanzaTree_UpdateFrame(frame);
end

--[[ Set the selected ID ]]--
function PanzaTree_SetSelectedByID(frame,id)
	local nth = id+FauxScrollFrame_GetOffset(getglobal(frame:GetName().."ListScrollFrame"));
	local flat = PanzaTree_MakeFlatTable(frame.activeTable, nil, true);

	if ( flat[nth] ) then 
		frame.selected = flat[nth];
	else
		frame.selected = nil;
	end
end

--[[ Get the selected object or nil ]]--
function PanzaTree_GetSelected(frame)
	if ( frame.selected ) then 
		return frame.selected;
	end
	return nil;
end

--[[
--	Returns the number of nodes in a table counting .children tables
--]]
function PanzaTree_GetNodeCount( tableD, ignoreCollapsed )
	local count = 0;

	if ( tableD.children ) then 
		if ( ignoreCollapsed and tableD.collapsed ) then 
		else
			count = count + table.getn(tableD.children);
			for k,v in pairs(tableD.children) do 
				if ( v.children ) then 
					count = count + PanzaTree_GetNodeCount(v, ignoreCollapsed);
				end
			end
		end
	end

	return count;
end


--[[
--	Returns the number of nodes in a table counting .children tables
--]]
function PanzaTree_GetFullCount( tableD, ignoreCollapsed )
	local count = table.getn( tableD );

	for k,v in pairs(tableD) do 
		if ( v.children ) then 
			if ( v.collapsed and ignoreCollapsed ) then 
			else
				count = count + table.getn(v.children);
				for k2,v2 in pairs(v.children) do 
					if ( v2.children ) then 
						count = count + PanzaTree_GetNodeCount(v2, ignoreCollapsed);
					end
				end
			end
		end
	end

	return count;
end


--[[ Validates a Frame ]]--
function PanzaTree_CheckFrame(frame)
	if ( frame ) then 
		return true;	
	else
		if (PA:CheckMessageLevel("Core", 0)) then
			PA:Message4("Invalid frame passed to PanzaTree_CheckFrame");
		end
		return nil;
	end
end

--[[ Validates a Table ]]--
function PanzaTree_CheckTable(data)
	if ( not data ) then 
		if (PA:CheckMessageLevel("Core", 0)) then
			PA:Message4("Data sent to PanzaTree is nil! Name:"..this:GetName() );
		end
		return false;
	end

	if ( type(data) ~= "table" ) then 
		if (PA:CheckMessageLevel("Core", 0)) then
			PA:Message4("Data sent to PanzaTree is not a table! Name:"..this:GetName() );
		end
		return false;
	end

	for k,v in pairs(data) do 
		--Something
		if ( type(k) ~= "number" ) then 
			if (PA:CheckMessageLevel("Core", 0)) then
				PA:Message4("Invalid index in data: "..this:GetName() );
			end
			return false;
		end
	
		if ( PanzaTree_CheckItem(v) == false ) then
			if (PA:CheckMessageLevel("Core", 0)) then
				PA:Message4("Invalid item: "..k);
			end
			return false;
		end
	end

	return true;
end

--[[ Validates a Table Item ]]--
function PanzaTree_CheckItem(item)
	if ( not item.title and not item.right ) then 
		if (PA:CheckMessageLevel("Core", 0)) then
			PA:Message4("No title or subtext provided: "..this:GetName() );
		end
		return false;
	end

	-- Now subfunctioned, this may never be used.
	if ( not item.titleColor ) then 
		item.titleColor = PANZATREE_COLOR_STRING;
	end
		
	if ( not item.rightColor ) then 
		item.rightColor = PANZATREE_COLOR_STRING;
	end

	if ( item.children ) then 
		return PanzaTree_CheckTable(item.children);
	end
end	

--[[ Creates an Entry out of a Standard Table ]]--
function PanzaTree_CreateEntry(k,v,funcTable,parents,parentValues,maxDepth)
	local entry = {};

	-- Create the parent chain
	if ( not parents ) then
		parents = {};
	end

	-- Set the title portion
	if ( type(k) == "table" ) then 
		entry.title = PANZATREE_KEYWORD_TABLE;
		entry.titleColor = PANZATREE_COLOR_STRING;
	elseif ( type(k) == "function" ) then
		entry.title = PANZATREE_KEYWORD_FUNCTION;
		entry.titleColor = PANZATREE_COLOR_STRING;
	elseif ( type(k) == "nil" ) then 
		entry.title = PANZATREE_KEYWORD_NIL;
		entry.titleColor = PANZATREE_COLOR_NUMBER;
	elseif ( type(k) == "number" ) then 
		entry.title = "["..k.."]";
		entry.titleColor = PANZATREE_COLOR_NUMBER;
	elseif ( type(k) == "boolean" ) then 
		if ( k ) then 
			entry.title = "|".."true".."|";
		else
			entry.title = "|".."false".."|";
		end
		entry.titleColor = PANZATREE_COLOR_BOOLEAN;		
		
	elseif ( type(k) == "string" ) then 
		entry.title = k;
		entry.titleColor = PANZATREE_COLOR_STRING;
	else
		entry.title = PANZATREE_KEYWORD_UNKNOWN;
		entry.titleColor = PANZATREE_COLOR_UNKNOWN;
	end

	-- Set the secondary value
	if ( type(v) == "table" ) then
		--Check to make sure this isn't a recursively embedded table of one of its parents
		local recursiveTable;
		if ( not parentValues ) then
			parentValues = {};
		else
			for k2,v2 in pairs(parentValues) do 
				if (v2 == v) then
					recursiveTable = k2;
				end
			end
		end
		if (recursiveTable) then --or (table.getn(parents) >= 4) then
			-- Recursively embedded table, print the table trace from the top most table
			local parentString = PANZATREE_KEYWORD_RECURSIVE_TABLE;
			for k2,v2 in pairs(parents) do
				if k2 >= recursiveTable then
					break;
				end
				parentString = parentString.."."..v2;
			end
			--entry.right = PANZATREE_KEYWORD_RECURSIVE_TABLE;
			entry.right = parentString;
			entry.rightColor = PANZATREE_COLOR_TABLE;
		elseif (type(maxDepth) == "number") and (table.getn(parents) >= maxDepth) then
			-- Reached max tree depth, 
			entry.right = PANZATREE_KEYWORD_DEEP_TABLE;
			entry.rightColor = PANZATREE_COLOR_TABLE;
		else
			-- Normal table, evaluate its children
			entry.right = PANZATREE_KEYWORD_TABLE;
			entry.rightColor = PANZATREE_COLOR_TABLE;
			
			entry.children = {};
			-- Ooh, its a table! Parse its children.
			for k2,v2 in pairs(v) do 
				-- Create the parent hierarchy!
				local newParent = {};
				for k3,v3 in pairs(parents) do 
					table.insert(newParent, v3);
				end
				
				-- Add the current parent
				table.insert(newParent, k);
				table.insert(parentValues, v);
				
				-- Add kids
				local kid = PanzaTree_CreateEntry(k2,v2,funcTable,newParent,parentValues,maxDepth);
				table.insert(entry.children, kid);
			end
	
			entry.expandTooltip = "Children: "..PanzaTree_GetNodeCount( entry );
		end
		
	elseif ( type(v) == "function" ) then
		entry.right = PANZATREE_KEYWORD_FUNCTION;
		entry.rightColor = PANZATREE_COLOR_FUNCTION;
	elseif ( type(v) == "nil" ) then 
		entry.right = PANZATREE_KEYWORD_NIL;
		entry.rightColor = PANZATREE_COLOR_NIL;
	elseif ( type(v) == "number" ) then 
		entry.right = v;
		entry.rightColor = PANZATREE_COLOR_NUMBER;
	elseif ( type(v) == "string" ) then 
		entry.right = '"'..v..'"';
		entry.rightColor = PANZATREE_COLOR_STRING;
	elseif ( type(v) == "boolean" ) then 
		if ( v ) then 
			entry.right = "true";
		else
			entry.right = "false";
		end
		entry.rightColor = PANZATREE_COLOR_BOOLEAN;
	else
		entry.right = PANZATREE_KEYWORD_UNKNOWN;
		entry.rightColor = PANZATREE_COLOR_UNKNOWN;
	end

	-- Set the functions
	if ( funcTable.onClick ) then
		entry.onClick = funcTable.onClick;
	end
	if ( funcTable.onCollapseClick ) then
		entry.onCollapseClick = funcTable.onCollapseClick;
	end
	if ( funcTable.onDoubleClick ) then
		entry.onDoubleClick = funcTable.onDoubleClick;
	end
	if ( funcTable.onCheck ) then
		entry.onCheck = funcTable.onCheck;
	end


	-- Set the value passed back to the function
	entry.value = {key=k,value=v,parent=parents};

	return entry;
end

--[[
--	HandleAction
--
--	Delegates particular actions to events
--
--]]
function PanzaTree_HandleAction (frame, id, action, a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20)
	PA:Debug( frame:GetName(),": ",id," [",action,"]");
	
	local update = true;
	if ( action == "CLICK_EXPAND" or action == "CLICK_COLLAPSE") then 
		if ( id > 0 ) then 
			local item = PanzaTree_GetItemByID(frame,id);
			local collapse = false;
			if ( not item.collapsed ) then 
				collapse = true;
			end		
			if ( item ) then 
				if ( item.onCollapseClick ) then
					local newCollapse = nil;
					newCollapse = item.onCollapseClick(collapse, item.value);
					
					if ( newCollapse ~= nil ) then 
						collapse = newCollapse;
					end
				end
			end

			PanzaTree_SetItemCollapsed(frame,id, collapse);
		else
			PanzaTree_CollapseAllToggle(frame);
		end
	elseif ( action == "CLICK_TEXT" ) then 
		if ( id > 0 ) then 
			local item = PanzaTree_GetItemByID(frame,id);
			if ( item ) then 
				if ( item.onClick ) then 
					item.onClick(item.value, id);
				end
			end
			
			-- Set the selection
			PanzaTree_SetSelectedByID(frame,id);
		end	
	elseif ( action == "DOUBLECLICK_TEXT" ) then 
		if ( id > 0 ) then 
			local item = PanzaTree_GetItemByID(frame,id);
			if ( item ) then 
				if ( item.onDoubleClick ) then 
					item.onDoubleClick(item.value);
				end
			end
			
			-- Set the selection
			PanzaTree_SetSelectedByID(frame,id);
		end	
	elseif ( action == "CLICK_CHECK" ) then 
		if ( id > 0 ) then 
			local item = PanzaTree_GetItemByID(frame,id);
			if ( item ) then
				local checked = nil;
				if ( item.onCheck ) then 
					checked = item.onCheck(a1, item.value);
				end

				if ( checked == nil ) then 
					-- Set the checkbox state.
					item.checked = a1;
				else
					item.checked = checked;
				end
			end
		end
	elseif ( action == "CLICK_RADIO" ) then 
		if ( id > 0 ) then 
			local item = PanzaTree_GetItemByID(frame,id);
			if ( item ) then 
				if ( item.onRadio ) then 
					item.onRadio(a1, item.value);
				end

				-- Set the checkbox state.
				item.radioSelected = a1;
			end
		end
	elseif ( action == "ENTER_TEXT" ) then 
		local tooltipText = PanzaTree_GetTooltipText(frame,id);
		PanzaTree_SetTooltip(frame, tooltipText);	
		update = false;
	elseif ( action == "ENTER_CHECK" ) then
		local tooltipText = PanzaTree_GetTooltipText(frame,id, "CHECK");
		PanzaTree_SetTooltip(frame, tooltipText);
		update = false;
	elseif ( action == "ENTER_RADIO" ) then
		local tooltipText = PanzaTree_GetTooltipText(frame,id, "RADIO");
		PanzaTree_SetTooltip(frame, tooltipText);
		update = false;
	elseif ( action == "ENTER_EXPAND" ) then 
		local tooltipText = PanzaTree_GetTooltipText(frame,id, "EXPAND");
		PanzaTree_SetTooltip(frame, tooltipText);
		update = false;
	elseif ( action == "LEAVE_TEXT" or action == "LEAVE_CHECK" or action == "LEAVE_EXPAND" ) then
		PanzaTree_HideTooltip(frame);
		update = false;
	end

	-- Prevent unnessecary re-draws
	if ( update ) then
		-- Update the gui
		PanzaTree_UpdateFrame( frame );
	end
end


--
--	Sets the location of the Tooltip
--
function PanzaTree_SetTooltip(frame, tooltipText) 

	if ( frame.tooltip ) then 
		local tooltip = getglobal(frame.tooltip);
		if ( tooltipText ) then 	
			-- Set the location of the tooltip
			if ( frame.tooltipPlacement == "cursor" ) then
				tooltip:SetOwner(UIParent,"ANCHOR_CURSOR");	
			elseif ( frame.tooltipPlacement == "button" ) then
				tooltip:SetOwner(this,frame.tooltipAnchor);	
			else
				tooltip:SetOwner(frame,frame.tooltipAnchor);				
			end

			tooltip:SetText(tooltipText, 0.8, 0.8, 1.0);
			tooltip:Show();
		end
	end

end

--
--	Hides the location of the Tooltip
--
function PanzaTree_HideTooltip(frame)
	if ( frame.tooltip ) then 		
		getglobal(frame.tooltip):Hide();
		--getglobal(frame.tooltip):SetOwner(UIParent, "ANCHOR_RIGHT");
	end
end

--[[
--	All Object Event Handlers are Below
--
--]]

--[[ MouseWheel Events ]]
function PanzaTree_OnMouseWheel(frameName, delta)
	local offset = FauxScrollFrame_GetOffset(getglobal(frameName.."ListScrollFrame"));
	local maxOffset = PanzaTree_GetFullCount( getglobal(frameName).activeTable, true) - getglobal(frameName).titleCount;
	local scrollbar = getglobal(frameName.."ListScrollFrameScrollBar")
	local min,max = scrollbar:GetMinMaxValues();

	if ( type(offset) == "number" ) then 
		local newVal = offset - delta;
		if ( newVal >= 0 and newVal <= maxOffset ) then
			scrollbar:SetValue(newVal/maxOffset*max);
			FauxScrollFrame_SetOffset(getglobal(frameName.."ListScrollFrame"), newVal );
			PanzaTree_UpdateFrame(getglobal(frameName));
		elseif ( newVal > maxOffset ) then 
			if ( maxOffset < 0 ) then 
				offset = 0;
				maxOffset = 1;
			else
				offset = maxOffset;
			end
			scrollbar:SetValue(offset/maxOffset*max);
			
			FauxScrollFrame_SetOffset(getglobal(frameName.."ListScrollFrame"), offset);
			PanzaTree_UpdateFrame(getglobal(frameName));
		end
	end
end

--[[ CheckButton Events ]]--
function PanzaTree_CheckButton_OnLoad()
	--this:RegisterForClicks("LeftButtonDown", "LeftButtonUp", "RightButtonDown", "RightButtonUp");
	this:RegisterForClicks("LeftButtonDown", "RightButtonDown");

	this.onEnter = PanzaTree_CheckButton_OnEnter;
	this.onLeave = PanzaTree_CheckButton_OnLeave;
	this.onClick = PanzaTree_CheckButton_OnClick;
	this.onMouseWheel = PanzaTree_ExpandButton_OnMouseWheel;
	
end	
function PanzaTree_CheckButton_OnEnter()
	PanzaTree_HandleAction(this:GetParent():GetParent(),this:GetParent():GetID(),"ENTER_CHECK", this:GetChecked());
end
function PanzaTree_CheckButton_OnLeave()
	PanzaTree_HandleAction(this:GetParent():GetParent(),this:GetParent():GetID(),"LEAVE_CHECK", this:GetChecked());
end
function PanzaTree_CheckButton_OnClick()
	PanzaTree_HandleAction(this:GetParent():GetParent(),this:GetParent():GetID(),"CLICK_CHECK", this:GetChecked());
end


--[[ CheckButton Events ]]--
function PanzaTree_RadioButton_OnLoad()
	--this:RegisterForClicks("LeftButtonDown", "LeftButtonUp", "RightButtonDown", "RightButtonUp");
	this:RegisterForClicks("LeftButtonDown", "RightButtonDown");

	this.onEnter = PanzaTree_RadioButton_OnEnter;
	this.onLeave = PanzaTree_RadioButton_OnLeave;
	this.onClick = PanzaTree_RadioButton_OnClick;
	this.onMouseWheel = PanzaTree_ExpandButton_OnMouseWheel;
	
end	
function PanzaTree_RadioButton_OnEnter()
	PanzaTree_HandleAction(this:GetParent():GetParent(),this:GetParent():GetID(),"ENTER_RADIO", this:GetChecked());
end
function PanzaTree_RadioButton_OnLeave()
	PanzaTree_HandleAction(this:GetParent():GetParent(),this:GetParent():GetID(),"LEAVE_RADIO", this:GetChecked());
end
function PanzaTree_RadioButton_OnClick()
	PanzaTree_HandleAction(this:GetParent():GetParent(),this:GetParent():GetID(),"CLICK_RADIO", this:GetChecked());
end

--[[ Expand Button Event Handlers ]]--
function PanzaTree_ExpandButton_OnLoad()
	--this:RegisterForClicks("LeftButtonDown", "LeftButtonUp", "RightButtonDown", "RightButtonUp");
	this:RegisterForClicks("LeftButtonDown", "RightButtonDown");

	this.onEnter = PanzaTree_ExpandButton_OnEnter;
	this.onClick = PanzaTree_ExpandButton_OnClick;
	this.onLeave = PanzaTree_ExpandButton_OnLeave;	
	this.onMouseWheel = PanzaTree_ExpandButton_OnMouseWheel;

end

function PanzaTree_ExpandButton_OnEnter()
	PanzaTree_HandleAction(this:GetParent():GetParent(),this:GetParent():GetID(),"ENTER_EXPAND");
end

function PanzaTree_ExpandButton_OnClick()
	PanzaTree_HandleAction(this:GetParent():GetParent(),this:GetParent():GetID(),"CLICK_EXPAND");
end

function PanzaTree_ExpandButton_OnLeave()
	PanzaTree_HandleAction(this:GetParent():GetParent(),this:GetParent():GetID(),"LEAVE_EXPAND");
end
function PanzaTree_ExpandButton_OnMouseWheel(delta)
	local frameName = this:GetParent():GetParent():GetName();
	PanzaTree_OnMouseWheel(frameName, delta);
end

--[[ Clicking on Text Event Handlers ]]--
function PanzaTree_ButtonFrame_OnLoad()
	this.onEnter = PanzaTree_Text_OnEnter;
	this.onClick = PanzaTree_Text_OnClick;
	this.onLeave = PanzaTree_Text_OnLeave;	
	this.onDoubleClick = PanzaTree_Text_OnDoubleClick;
	this.onMouseWheel = PanzaTree_ButtonFrame_OnMouseWheel;
end

function PanzaTree_Text_OnLoad()
	--this:RegisterForClicks("LeftButtonDown", "LeftButtonUp", "RightButtonDown", "RightButtonUp");
	this:RegisterForClicks("LeftButtonDown", "RightButtonDown");

	this.onEnter = PanzaTree_Text_OnEnter;
	this.onClick = PanzaTree_Text_OnClick;
	this.onLeave = PanzaTree_Text_OnLeave;	
	this.onDoubleClick = PanzaTree_Text_OnDoubleClick;
	this.onMouseWheel = PanzaTree_Text_OnMouseWheel;
end

function PanzaTree_Text_OnEnter()
	-- Highlights the 2ndary text on mouseover
	getglobal(this:GetParent():GetName().."Tag"):SetTextColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);

	PanzaTree_HandleAction(this:GetParent():GetParent(),this:GetParent():GetID(),"ENTER_TEXT");
	GameTooltip:Hide();

end

function PanzaTree_Text_OnClick()
	PanzaTree_HandleAction(this:GetParent():GetParent(),this:GetParent():GetID(),"CLICK_TEXT");
end

function PanzaTree_Text_OnDoubleClick()
	PanzaTree_HandleAction(this:GetParent():GetParent(),this:GetParent():GetID(),"DOUBLECLICK_TEXT");
end

function PanzaTree_ButtonFrame_OnMouseWheel(delta)
	local frameName = this:GetParent():GetName();
	PanzaTree_OnMouseWheel(frameName, delta);
end

function PanzaTree_Text_OnMouseWheel(delta)
	local frameName = this:GetParent():GetParent():GetName();
	PanzaTree_OnMouseWheel(frameName, delta);
end
function PanzaTree_Text_OnLeave()
	if (this:GetParent():GetID() ~= this:GetParent():GetParent().selectedId) then
		local button = getglobal(this:GetName());
		button:SetTextColor(button.r, button.g,button.b);
		local check = getglobal(this:GetParent():GetName().."Check");
		check:SetTextColor(check.r, check.g, check.b);
		local tag = getglobal(this:GetParent():GetName().."Tag");
		tag:SetTextColor(tag.r, tag.g,tag.b);
	end
	
	-- Hides the parent tooltip
	PanzaTree_HideTooltip(this:GetParent():GetParent());
end

--[[ Collapse All Button Event Handlers ]]--
function PanzaTree_CollapseAllButton_OnLoad()
	--this:RegisterForClicks("LeftButtonDown", "LeftButtonUp", "RightButtonDown", "RightButtonUp");
	getglobal(this:GetName().."Button"):RegisterForClicks("LeftButtonDown", "RightButtonDown");
	getglobal(this:GetName().."Button"):SetText(ALL);
	getglobal(this:GetName().."Button"):SetWidth(this:GetWidth());
	getglobal(this:GetName().."Button"):SetPoint("TOPLEFT", this:GetName(), "TOPLEFT", PANZATREE_EXPAND_INDENT, -2);

	this.onClick = PanzaTree_CollapseAllButton_OnClick;
	this.onEnter = PanzaTree_CollapseAllButton_OnEnter;
	this.onLeave = PanzaTree_CollapseAllButton_OnLeave;
	getglobal(this:GetName().."Button").onClick = PanzaTree_CollapseAllButton_OnClick;
	getglobal(this:GetName().."Expand").onClick = PanzaTree_CollapseAllButton_Icon_OnClick;
	getglobal(this:GetName().."Button").onEnter = PanzaTree_CollapseAllButton_OnEnter;
	getglobal(this:GetName().."Expand").onEnter = PanzaTree_CollapseAllButton_Icon_OnEnter;
	getglobal(this:GetName().."Button").onLeave = PanzaTree_CollapseAllButton_OnLeave;
	getglobal(this:GetName().."Expand").onLeave = PanzaTree_CollapseAllButton_Icon_OnLeave;
end


function PanzaTree_CollapseAllButton_Icon_OnClick()
	PanzaTree_HandleAction(this:GetParent():GetParent():GetParent(),0,"CLICK_COLLAPSE");

end
function PanzaTree_CollapseAllButton_OnClick()
	PanzaTree_HandleAction(this:GetParent():GetParent():GetParent(),0,"CLICK_COLLAPSE");

end
function PanzaTree_CollapseAllButton_OnEnter()
end
function PanzaTree_CollapseAllButton_Icon_OnEnter()
end
function PanzaTree_CollapseAllButton_OnLeave()
end
function PanzaTree_CollapseAllButton_Icon_OnLeave()
end

--[[
--	Toggles the collapsed state of all trees.
--]]
function PanzaTree_CollapseAllToggle(frame)
	local count = 0;
	local myTable = PanzaTree_MakeFlatTable(frame.activeTable, nil, false);

	-- Check if they are all collapsed
	for k,v in pairs(myTable) do 
	   -- Count collapsed and entries without a collapsed state.
		if ( v.collapsed or v.collapsed == nil ) then 
			count = count + 1;
		end
	end

	-- If they are all collapsed
	if ( count == table.getn(myTable) ) then 
		-- Expand them all
		for k,v in pairs(myTable) do 
			myTable[k].collapsed = false;
			if ( myTable[k].onCollapseClick ~= nil ) then
			   myTable[k].onCollapseClick( false, myTable[k].value );
			end
		end
		
		getglobal(frame:GetName().."Expand".."CollapseAllExpand"):SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up"); 		
	else
		-- Collapse them all
		for k,v in pairs(myTable) do
			myTable[k].collapsed = true;
			if ( myTable[k].onCollapseClick ~= nil ) then
			   myTable[k].onCollapseClick( true, myTable[k].value );
			end
		end

		getglobal(frame:GetName().."Expand".."CollapseAllExpand"):SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up");
	end

	PanzaTree_UpdateFrame(frame);
end


--[[ Frame Event handlers ]]--
function PanzaTree_Frame_OnLoad()
	this.onClick = PanzaTree_Frame_OnClick;
	this.onShow = PanzaTree_Frame_OnShow;
	this.onEvent = PanzaTree_Frame_OnEvent;
	this.onMouseWheel = PanzaTree_Frame_OnMouseWheel;
	
	--
	-- Sets the default object values
	-- 
	this.titleCount = PANZATREE_MAXTITLE_COUNT;
	this.highlight = true;
	this.highlightSize = "long"; 	-- Can also be "short" [Buggy]
	this.extraIndent = true; -- Indents child nodes once all the of the time

	-- Use any tooltip you'd like. I use my own
	this.tooltip = "PanzaTooltip";
	
	--
	-- Can be "button", "frame", "cursor"
	-- 
	this.tooltipPlacement = "cursor"; 	
	this.tooltipAnchor = "ANCHOR_RIGHT"; -- Can be any valid tooltip anchor
	this.activeTable = {};

	--
	-- Shows or hides the expand all button
	--
	this.collapseAllButton = false;
	this.collapseAllArtwork = false;

	-- Hide all buttons once
	for i=1,this.titleCount do
		getglobal(this:GetName().."Title"..i):Show();
	end
	for i=this.titleCount+1, PANZATREE_MAXTITLE_COUNT do
		getglobal(this:GetName().."Title"..i):Hide();
	end
end

function PanzaTree_Frame_OnShow()
	PanzaTree_UpdateFrame(this);
end

function PanzaTree_Frame_OnClick()
end

function PanzaTree_Frame_OnEvent()
end

function PanzaTree_Frame_OnMouseWheel(delta)
	local frameName = this:GetName();
	PanzaTree_OnMouseWheel(frameName, delta);
end


--[[
--
--	Earth Tree Demo Code
--
--
--
--
function dt()
	local tree = {
		a = "a";
		b = "b";
		c = "c";
		d = "d";
		e = "e";
		f = {
			1,2,3,4,5,6,7,8;
			a={
				11,22,33,44,55;
			};
			b={
				66,77,88,99,110;
			};
		};

	};
	local eTree = { 
		{
			title="a";
			right="b";
			tooltip="Hail!";
			onClick = function(a) Sea.io.print(a); end;
			children = {
				{
					title="a's child";
					right="(some thing)";
					onClick = function(a) Sea.io.error(a); end;
					children = {
						{
							title="a's first grandkid";
							check=true;
							checked=true;
							onCheck = function(check) Sea.io.print(check) end;
							onClick = function( a ) Sea.io.print(a); end;
							children = {
								{
									check=true;
									checked=1;
									title="great grandkid";
									onClick = function( a ) Sea.io.error(a,"!") end;
								}
							};
						};
						{
							title="a's second grandkid";
							check=true;
							checked=true;
							checkDisabled=true;
							onCheck = function(check) Sea.io.print(check) end;
							onClick = function( a ) Sea.io.print(a); end;
							children = {
								{
									check=true;
									checked=1;
									title="great grandkid";
									onClick = function( a ) Sea.io.error(a,"!") end;
								}
							};
						};
					};
				};
				{
					title="a's child 2";
					right="(some other thing)";
					tooltip="Simon";
					onClick = function(a) Sea.io.error(a); end;
				};
				{
					title="a's child 3";
					right="(some other2 thing)";
					tooltip="Alvin";
					onClick = function(a) Sea.io.error(a); end;
				}
			};
		};
		{
			title="two";
			right="5";
			onClick = function(a) Sea.io.print(a); end;
			children = {
				{
					title="two's child";
					tooltip="Theodore";
					right="(some OTHER)";
					rightColor={r=1.0,g=.24,b=0};
					onClick = function(a) Sea.io.print(a); end;
				}
			};
		};
		
		{
			title="three";
			right="99 Bottles";
			onClick = function(a) Sea.io.print(a); end;
			children = {
				{
					title="three's child";
					right="(some third thing)";
					rightColor={r=1.0,g=.24,b=0};
					onClick = function(a) Sea.io.print(a); end;
				}
			};
		};
		
	};
	PanzaTree_LoadTable(
		getglobal("PanzaTree"), 
		tree,
		{
			onClick = function(a) Sea.io.printTable(a); end;
		},
		);
	PanzaTree_LoadEnhanced(
		getglobal("PanzaTree"), 
		eTree
		);
	PanzaTree_UpdateFrame(
		getglobal("PanzaTree")
		); 
end
]]

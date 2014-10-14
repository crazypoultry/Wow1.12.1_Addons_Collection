--[[
	Contains language specific functions succeptible to contains raw unicode characters
	Version: <%version%>
	Revision: $Id: GathererUI_Lang.lua,v 1.3 2005/09/22 20:22:59 islorgris Exp $
]]--

function GathererUI_FixItemName(itemName)
	local newItemName = itemName;
	
	if ( GetLocale() == "frFR" ) then
	-- add name correction
		newItemName = string.gsub(itemName , "’", '\'');
		newItemName = string.gsub(newItemName , "argent v\195\169ritable", ORE_TRUESILVER);
		newItemName = string.gsub(newItemName , "vrai argent", ORE_TRUESILVER);
		newItemName = string.gsub(newItemName , "petite veine", "petit filon");
		newItemName = string.gsub(newItemName , "veine", ORE_CLASS_LORE);
		if ( itemName ~= newItemName ) then
			fixedItemCount = fixedItemCount + 1;
		end
	end
	if ( GetLocale() == "deDE" ) then
		newItemName = string.gsub(itemName , "dreamfoil", HERB_DREAMFOIL);
		if ( itemName ~= newItemName ) then
			fixedItemCount = fixedItemCount + 1;
		end
	end

	return newItemName;
end


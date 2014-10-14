--[[
	Bagnon Forever Localization file
		This provides a way to translate Bagnon_Forever into different languages.
--]]

--[[
	French   by   Ferroginus
--]]

if ( GetLocale() == "esES" ) then
	--[[ Slash Commands ]]--

	BAGNON_FOREVER_COMMAND_DELETE_CHARACTER = "delete"

	--[[ Messages from the slash commands ]]--

	--/bgn help
	BAGNON_FOREVER_HELP_DELETE_CHARACTER = "/bgn " .. BAGNON_FOREVER_COMMAND_DELETE_CHARACTER .. 
		" <character> <realm> - Elimina los datos del inventario y del banco del personaje .";

	--/bgn delete <character> <realm>
	BAGNON_FOREVER_CHARACTER_DELETED = "Elimina los datos de %s de %s.";

	--[[ System Messages ]]--

	--Bagnon Forever version update
	BAGNON_FOREVER_UPDATED = "Opciones de Bagnon Forever actualizadas a v" .. BAGNON_FOREVER_VERSION .. ".";

	--[[ Tooltips ]]--

	--Title tooltip
	--BAGNON_TITLE_FOREVERTOOLTIP = "<Doble-Click> para cambiar de personaje.";

	--Total gold on realm
	BAGNON_FOREVER_MONEY_ON_REALM = "Dinero total de %s";
	return;
end
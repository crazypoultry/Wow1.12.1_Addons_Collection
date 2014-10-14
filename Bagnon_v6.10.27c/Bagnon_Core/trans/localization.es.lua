--[[
	Bagnon Localization file

	TODO:
		Add some frame strings and other things
		I could probably Babelfish the translation, but most likely it would insult someone's
			mother or something.
--]]

--[[
	Spanish  by   Ferroginus
--]]

if ( GetLocale() == "esES" ) then

--[[ Keybindings ]]--

BINDING_HEADER_BAGNON = "Bagnon"
BINDING_NAME_BAGNON_TOGGLE = "Activar Bagnon"
BINDING_NAME_BANKNON_TOGGLE = "Activar Banknon"

--[[ Slash Commands ]]--

BAGNON_COMMAND_HELP = "help"
BAGNON_COMMAND_SHOWBAGS = "bags"
BAGNON_COMMAND_SHOWBANK = "bank"
BAGNON_COMMAND_REVERSE = "reverse"
BAGNON_COMMAND_OVERRIDE_BANK = "overridebank"
BAGNON_COMMAND_TOGGLE_TOOLTIPS = "tooltips"
BAGNON_COMMAND_DEBUG_ON = "debug"
BAGNON_COMMAND_DEBUG_OFF = "nodebug"

--[[ Messages from the slash commands ]]--

--/bgn help
BAGNON_HELP_TITLE = "Bagnon commands:"
BAGNON_HELP_SHOWBAGS = "/bgn " .. BAGNON_COMMAND_SHOWBAGS .. " - Muestra/Oculta Bagnon."
BAGNON_HELP_SHOWBANK = "/bgn " .. BAGNON_COMMAND_SHOWBANK .. " - Muestra/Oculta Banknon."
BAGNON_HELP_HELP = "/bgn " .. BAGNON_COMMAND_HELP .. " - Mostrar commandos."

--/bgn debug
BAGNON_DEBUG_ENABLED = "Modo depuración activo."

--/bgn nodebug
BAGNON_DEBUG_DISABLED = "Modo depuración inactivo."

--[[ System Messages ]]--

BAGNON_INITIALIZED = "Bagnon inicializado. Teclee /bagnon o /bgn para los comandos"
BAGNON_UPDATED = "Opciones de Bagnon actualizadas a v%s. Teclee /bagnon o /bgn para los comandos"

--[[ UI Text ]]--

--Titles

--These should probably read Inventory of <player> and Bank of <player> in other versions I guess
BAGNON_INVENTORY_TITLE = "Inventario de %s"
BAGNON_BANK_TITLE = "Banco de %s"

--Bag Button
BAGNON_SHOWBAGS = "Mostrar Bolsas"
BAGNON_HIDEBAGS = "Ocultar Bolsas"

--General Options Menu
BAGNON_MAINOPTIONS_TITLE = "Opciones de Bagnon"
BAGNON_MAINOPTIONS_SHOW = "Mostrar"

--Right Click Menu
BAGNON_OPTIONS_TITLE = "Opciones de %s"
BAGNON_OPTIONS_LOCK = "Bloquear posición"
BAGNON_OPTIONS_BACKGROUND = "Fondo"
BAGNON_OPTIONS_REVERSE = "Ordenar las bolsas inversamente"
BAGNON_OPTIONS_COLUMNS = "Columnas"
BAGNON_OPTIONS_SPACING = "Espaciado"
BAGNON_OPTIONS_SCALE = "Escala"
BAGNON_OPTIONS_OPACITY = "Opacidad"
BAGNON_OPTIONS_STRATA = "Capa"
BAGNON_OPTIONS_STAY_ON_SCREEN = "Permanecer en pantalla"

--[[ Tooltips ]]--

--Title tooltip
BAGNON_TITLE_TOOLTIP = "<Botón DER> para menú de opciones."

--Bag Tooltips
BAGNON_BAGS_HIDE = "<Mayusculas + Botón IZQ> para esconder."
BAGNON_BAGS_SHOW = "<Mayusculas + Botón IZQ> para mostrar."

BAGNON_SPOT_TOOLTIP = "<Doble-Click> para buscar."

--[[ Other ]]--

--fifth return for GetItemInfo(id)
BAGNON_ITEMTYPE_CONTAINER = "Contenedor"
BAGNON_ITEMTYPE_QUIVER = "Carcaj"

--sixth return for GetItemInfo(id)
BAGNON_SUBTYPE_SOULBAG = "Bolsa de Gemas"
BAGNON_SUBTYPE_BAG = "Bolsa"

end
if GetLocale() == "frFR" then
	Location = "France"
elseif GetLocale() == "esES" then
	Location = "Spain"
elseif GetLocale() == "deDE" then
	Location = "Germany"
else
	Location = ""
end

-- Arrays --
sm_resheep = {}				-- 3 messages.
sm_polymorph = {}			-- 5 messages.
sm_resisted = {}			-- 3 messages.
sm_list = {}				-- 6 sentences.
sm_defaults = {};			-- 3 special types.
sm_defaults["DisallowedZones"] = {};	-- 5 zones.
sm_defaults["DisallowedMobs"] = {};	-- 1 or 4 mobs.
sm_defaults["StickyMobs"] = {};		-- 1 mob.
sm_special_names = {};			-- 5 names.

-- Non-operative words, which are not capitalised --
sm_lowercase = "[English], A, The, Of, And, [French], De, Des, Le, La, Les, Du, Au, Un, Une, En, Et, Dans, [Spanish], Los, El, Del, Al, Uno, Una, Al, Y, [German], Von, Der, Des, Und"

-- Names with capitals partway through --
sm_special_names[1] = "Un'Goro"
sm_special_names[2] = "Ahn'Qiraj"
sm_special_names[3] = "Zul'Gurub"
sm_special_names[4] = "Zul'Farrak"
sm_special_names[5] = "Atal'Hakkar"


-- English localization --

-- Defaults --
sm_defaults["DisallowedZones"][1] = "Molten Core"
sm_defaults["DisallowedZones"][2] = "Blackwing Lair"
sm_defaults["DisallowedZones"][3] = "Ahn'Qiraj"
sm_defaults["DisallowedZones"][4] = "Ruins of Ahn'Qiraj"
sm_defaults["DisallowedZones"][5] = "Naxxramas"
sm_defaults["DisallowedMobs"][1] = "Razzashi Raptor"
sm_defaults["DisallowedMobs"][2] = "Chimaerok"
sm_defaults["DisallowedMobs"][3] = "Chimaerok Devourer"
sm_defaults["DisallowedMobs"][4] = "Arcane Chimaerok"
sm_defaults["StickyMobs"][1] = "Master Elemental Shaper Krixix"

-- Polymorphing --
sm_mc_poly = "Polymorphing |cffffff00%s|r, because %s's mind controlled.%s"
sm_pvp_warning = "|cffff0000Warning:|r Polymorphing %s will flag you for PvP."

-- Errors --
sm_target_empty = "<no target>"
sm_not_mage = "You are not a mage."
sm_no_spell_at_all = "You do not know Polymorph."
sm_duplicate_found = "Duplicate entry found."
sm_no_command = "Type |c00ffff00/sheep help|r for a list of commands."

-- Miscellaneous --
sm_language = "English"
sm_english = "English"
sm_string_special = "special"
sm_string_message = "message"
sm_mod_loaded = "Turkeyii's sheeping mod loaded. Type |c00ffff00/sheep help|r for more information."
sm_set_defaults = "Setting default values for Turkeyii's Sheeping Mod."
sm_version_update = "Updating your settings to the latest version of SheepMod."
sm_buffdur_none = "Buff %s has no duration."
sm_buffdur_secs = "Buff %s has %s seconds remaining."
sm_buffdur_mins = "Buff %s has %s minutes and %s seconds remaining."
sm_buffdur_hours = "Buff %s has %s hours, %s minutes and %s seconds remaining."
sm_buffdur_days = "Buff %s has %s days, %s hours, %s minutes and %s seconds remaining."

-- Bindings --
BINDING_HEADER_SHEEPMOD = "Turkeyii's Sheep Mod"
BINDING_NAME_SHEEPMODCAST = "Polymorph your target"
BINDING_NAME_SHEEPMODOPTIONS = "Open the options"

-- Nefarian --
sm_string_blizzard = "Blizzard"
sm_string_flamestrike = "Flamestrike"
sm_string_ae = "Arcane Explosion"
sm_nef = "You will cast                             on the Drakonids in the Nefarian fight."
sm_nefarians_lair = "Nefarian"..string.char(239, 191, 189).."s Lair"	-- Blizzard are idiots.
sm_string_bwl = "Blackwing Lair"

-- Combat Messages -- 
sm_you_cast = "You cast "
sm_string_on = " on "
sm_fades_from = "%s fades from %s."
sm_is_removed = "%s's %s is removed."
sm_unit_dies = "%s dies."
sm_string_resisted = "Your %s was resisted by %s."

-- Help --
sm_helpframe_intro = "|cff00ff00Welcome to Turkeyii's Sheep Mod!|r"
sm_helpframe_version = "You are currently using SheepMod version %s."
sm_helpframe_text1 = "In order to polymorph your targets, you must have a macro with the following two lines in:%sBe warned that the second line is case-sensitive. Also, either the macro must have a Polymorph icon, or its name must have the word \"poly\" or \"sheep\" in."
sm_helpframe_text2 = "|cffffff00General Commands:|r\nTo show the options menu, type |cffffff00/sheep|r.\nTo change \"special\" zones and units, type |cffffff00/sheep special|r.\nTo say that you are polymorphing a target, type |c00ffff00/sheep message|r. This will not cast anything."
sm_helpframe_text3 = "|cffffff00Miscellaneous Commands:|r\nTo be told how long is remaining on a buff, type |c00ffff00/sheep buff [index]|r."

-- Short phrases --
sm_string_sheep = "sheep"
sm_string_pig = "pig"
sm_string_turtle = "turtle"
sm_string_cow = "cow"
sm_string_polymorph = "Polymorph"
sm_string_humanoid = "Humanoid"
sm_string_beast = "Beast"
sm_string_critter = "Critter"
sm_string_random_animal = "random animal"
sm_string_rank = "Rank "
sm_string_any = " any "
sm_string_the_same = " the same "
sm_string_colon = ": "

-- UI Objects' text --
--Check Boxes--
sm_button_enable = "Enable all emoting"
sm_button_timerbox = "Show polymorph duration timer"
sm_button_resheep = "Emote when re-polymorphing a target"
sm_button_resheep_animal = "Always re-polymorph to the same animal"
sm_button_players = "Emote when polymorphing enemy players"
sm_button_ffapvp = "Emote when polymorphing free-for-all-PvP-enabled players"
sm_button_mc= "Automatically polymorph all valid Mind Controlled players"
sm_button_mcandname= "Automatically polymorph Mind Controlled player: |cffffff00%s|r"
sm_button_mcwarning = "Warning when automatically polymorphing a Mind Controlled player"
sm_button_mcemote = "Emote when polymorphing a Mind Controlled player"
sm_button_mcignorezone = "Skip zone checks when polymorphing Mind Controlled players"
sm_button_mcrank = "Always use Polymorph (Sheep) Rank                on Mind Controlled players"
sm_button_pvpwarning = "Warning when you are about to enable PvP by polymorphing a player"
sm_button_resist = "Automatically emote when your Polymorph is resisted"
sm_button_resistzone = "Ignore zone checks when warning of a resisted Polymorph"
sm_button_timed = "Never emote for                             target more than once every                 seconds"
sm_button_stopcasting = "Stop your casting when polymorphing"
--General strings--
sm_list["DisallowedZones"] = "The polymorph warning message will |c00ff0000never|r be displayed in the following %s zones:"
sm_list["DisallowedZones1"] = "The polymorph warning message will |c00ff0000never|r be displayed in the following zone:"
sm_list["DisallowedMobs"] = "The polymorph warning message will |c00ff0000never|r be displayed for the following %s units:"
sm_list["DisallowedMobs1"] = "The polymorph warning message will |c00ff0000never|r be displayed for the following unit:"
sm_list["StickyMobs"] = "The polymorph warning message will |c0000ff00always|r be displayed for these %s units, regardless of zone:"
sm_list["StickyMobs1"] = "The polymorph warning message will |c0000ff00always|r be displayed for this unit, regardless of zone:"
sm_string_language = "When Polymorphing a target, your emotes will be sent in                            ."
sm_type = "When polymorphing, your target will be turned into a                            ."
sm_macro_summary_misc = "Your Polymorph macro |c00ffff00%s|r is on action bar %s, slot %s."
sm_macro_summary_12 = "Your Polymorph macro |c00ffff00%s|r is on action bar %s, slot 12."
sm_spell_summary_misc = "Your Polymorph spell is on action bar %s, slot %s."
sm_spell_summary_12 = "Your Polymorph spell is on action bar %s, slot 12."
sm_no_macro_ui_line1 = "|cffff0000You have no Polymorph macro on any action bar. As such,|r"
sm_no_macro_ui_line2 = "|cffff0000cooldown checks will not occur when you attempt to polymorph.|r"
sm_no_macro_ui_line3 = "|cffff0000Your macro |r|cffff6666%s|r|cffff0000 does not contain the following line:|r"
sm_no_macro_ui_line4 = "|cffff6666/script --CastSpellByName(\"Polymorph\");|r|cffff0000 As such,|r"	-- the ; is optional.
sm_timer_rightclick = "Right-click to target |cffffff00%s|r."
--Buttons--
sm_string_up = "Up"
sm_string_down = "Down"
sm_string_add = "Add"
sm_string_edit = "Edit"
sm_string_confirm = "Confirm"
sm_string_cancel = "Cancel"
sm_string_set_player = "Set a player"
sm_string_change = "Change"
sm_string_refresh = "Refresh"
sm_string_set_defaults = "Set Defaults"
sm_string_help = "Help"
sm_string_gotospecials = "Edit special zones and units"
sm_string_gotomain = "Return to main options"

if Location == "France" then

		-- Defaults --
	sm_defaults["DisallowedZones"][1] = "Cœur du Magma"
	sm_defaults["DisallowedZones"][2] = "Repaire de l'Aile Noire"
	sm_defaults["DisallowedZones"][3] = "Ahn'Qiraj"
	sm_defaults["DisallowedZones"][4] = "Ruines d'Ahn'Qiraj"
	sm_defaults["DisallowedZones"][5] = "Naxxramas"
	sm_defaults["DisallowedMobs"][1] = "Raptor Razzashi"
	sm_defaults["DisallowedMobs"][2] = "Chimaerok"
	sm_defaults["DisallowedMobs"][3] = "Chimaerok des Arcanes"
	sm_defaults["DisallowedMobs"][4] = "Dévoreur Chimaerok"
	sm_defaults["StickyMobs"][1] = "Maître élémentaire Krixix le Sculpteur"

		-- Polymorphing --
	sm_mc_poly = "Moutonnage de |cffffff00%s|r, car %s est contrôlé%s mentalement."
	sm_pvp_warning = "|cffff0000Attention:|r Lancer Métamorphose sur %s va vous faire passer en mode JcJ."
	-- The emotes are set below.

		-- Errors --
	sm_not_mage = "Vous n'êtes pas un mage."
	sm_target_empty = "<pas de cible>"
	sm_no_spell_at_all = "Vous ne connaissez pas Métamorphose."
	sm_no_command = "Tapez |c00ffff00/mouton aide|r pour une liste des commandes."
	sm_duplicate_found = "Entrée déjà trouvée."
	
		-- Miscellaneous --
	sm_language = "Français"
	sm_english = "Anglais"
	sm_string_special = "special"
	sm_string_message = "message"
	sm_mod_loaded = "Turkeyii's sheeping mod chargé. Tapez |c00ffff00/mouton aide|r pour plus d'informations."
	sm_set_defaults = "Retour aux réglages de bases de Turkeyii's Sheeping Mod."
	sm_version_update = "Mets vos réglages à jour pour la dernière version de SheepMod."
	sm_buffdur_none =  "Le sort %s n'a pas de durée."
	sm_buffdur_secs =  "Le sort %s a %s secondes restantes."
	sm_buffdur_mins =  "Le sort %s a %s minute(s) et %s secondes restantes."
	sm_buffdur_hours = "Le sort %s a %s heure(s), %s minutes et %s secondes restantes."
	sm_buffdur_days =  "Le sort %s a %s jour(s), %s heures, %s minutes et %s secondes restantes."

		-- Bindings --
	BINDING_NAME_SHEEPMODCAST = "Lancer Métamorphose sur votre cible"
	BINDING_NAME_SHEEPMODOPTIONS = "Ouvrir les réglages"

		-- Nefarian --
	sm_string_blizzard = "Blizzard"
	sm_string_flamestrike = "Choc de flammes"
	sm_string_ae = "Explosion des arcanes"
	sm_nef = "Vous lancerez                             sur les Drakonids durant le combat contre Nefarian."
	sm_nefarians_lair = "Antre de Nefarian"

		-- Combat Messages --
	sm_fades_from = "%s sur %s vient de se dissiper."
	sm_is_removed = "%s n'est plus sous l'influence de %s."
	sm_unit_dies = "%s meurt."
	sm_you_cast = "Vous lancez "	-- Vous lancez Métamorphose : cochon sur Géoseigneur du crépuscule.
	sm_string_on = " sur "
	sm_string_resisted = "Vous utilisez %s, mais %s résiste."	-- Vous utilisez Métamorphose, mais Vengeur du crépuscule résiste.

		-- Help --
	sm_helpframe_intro = "|cff00ff00Bienvenue dans Turkeyii's Sheep Mod!|r"
	sm_helpframe_version = "Vous utilisez SheepMod version %s."
	sm_helpframe_text1 = "Pour metamorphoser vos cibles, il vous faut faut une macro avec les 2 lignes suivantes dans:%sLa seconde ligne prens la casse en conpte. Donc la macro doit avoir soit un icon métamorphose ou le nom doit contenir un des mots \"poly\", \"métamorphose\" ou \"mouton\"."
	sm_helpframe_text2 = "|cffffff00Commandes générales:|r\nPour voir le menu des options, tapez |cffffff00/mouton|r.\nPour changer les zones \"speciales\" et les unités, tapez |cffffff00/mouton special|r.\nPour dire que vous métamorphosez une cible, tapez |c00ffff00/mouton message|r. Cela ne lancera rien."
	sm_helpframe_text3 = "|cffffff00Commandes diverses:|r\nPour savoir le temps restant sur un sort, tapez |c00ffff00/mouton buff [index]|r."

		-- Single words & short phrases --
	sm_string_sheep = "mouton"
	sm_string_pig = "cochon"
	sm_string_turtle = "tortue"
	sm_string_polymorph = "Métamorphose"
	sm_string_humanoid = "Humanoïde"
	sm_string_beast = "Bête"
	sm_string_critter = "Bestiole"
	sm_string_random_animal = "animal quelconque"	-- "animal au hasard" also possible.
	sm_string_rank = "Rang "
	sm_string_any = " n'importe quelle "
	sm_string_the_same = " la même "
	sm_string_colon = " : "

		-- UI Objects' text --
	--Check Boxes--
	sm_button_enable = "Autoriser toutes les emotes"
	sm_button_timerbox = "Afficher le timer pour le métamorphose"
	sm_button_stopcasting = "Interrompt votre invocation lorsque vous lancez Métamorphose"
	sm_button_resheep = "Affiche une emote si vous retransformez la même cible"
	sm_button_resheep_animal = "Toujours re-métamorphoser en le même animal"
	sm_button_players = "Affiche une emote si vous transformez un joueur ennemi"
	sm_button_ffapvp = "Emote lorsque vous transformez un joueur flaggé JcJ chacun pour soi"
	sm_button_mc= "Métamorphose automatiquement les joueurs mentalement contrôlés"
	sm_button_mcandname= "Métamorphose automatiquement le joueur: |cffffff00%s|r"
	sm_button_mcwarning = "Avertissement lorsque vous transformez un joueur mentalement contrôlé"		-- une cible contrôlée mentalement
	sm_button_mcemote = "Emote en transformant un joueur mentalement contrôlé"
	sm_button_mcignorezone = "Ne pas considerer les tests de zones lors d'un transformage sur un de ces joueurs"
	sm_button_mcrank = "Toujours utiliser Métamorphose (Mouton) rang                sur un de ces joueurs"
	sm_button_pvpwarning = "Avertissement lorsqu'un métamorphose va déclencher le JcJ"
	sm_button_timed = "Ne jamais faire d'emote pour                             cible plus d'une fois toutes les                  sec."
	sm_button_resist = "Emote automatiquement quand ta métamorphose n'a pas de succès"
	sm_button_resistzone = "Ignorer les tests de zone lorsqu'une métamorphose est resistée"
	--General strings--
	sm_list["DisallowedZones"] = "Le message d'avertissement du transformage ne sera |c00ff0000jamais|r affiché dans ces %s zones:"
	sm_list["DisallowedZones1"] = "Le message d'avertissement du transformage ne sera |c00ff0000jamais|r affiché dans le zone:"
	sm_list["DisallowedMobs"] = "Le message d'avertissement du transformage ne sera |c00ff0000jamais|r affiché pour ces %s unités:"
	sm_list["DisallowedMobs1"] = "Le message d'avertissement du transformage ne sera |c00ff0000jamais|r affiché pour cette unité:"
	sm_list["StickyMobs"] = "Le message du transformage sera |c0000ff00toujours|r affiché pour ces %s unités, peu importe la zone:"
	sm_list["StickyMobs1"] = "Le message du transformage sera |c0000ff00toujours|r affiché pour cette unité, peu importe la zone:"
	sm_string_language = "Le message d'avertissement du transformage sera affliché en                            ."
	sm_type = "Quand vous lancerez métamorphose, votre cible se transformera en                            ."
	sm_macro_summary_misc = "Votre macro Métamorphose |c00ffff00%s|r est sur la barre d'action %s, slot %s."
	sm_macro_summary_12 = "Votre macro métamorphose |c00ffff00%s|r est sur la barre d'action %s, slot 12."
	sm_spell_summary_misc = "Votre sort métamorphose est sur la barre d'action %s, slot %s."
	sm_spell_summary_12 = "Votre sort métamorphose est sur la barre d'action %s, slot 12."
	sm_no_macro_ui_line1 = "|cffff0000Vous n'avez pas de macro métamorphose. Donc les tests|r"
	sm_no_macro_ui_line2 = "|cffff0000de cooldown ne seront pas vérifiés quand vous lancerez ce sort.|r"
	sm_no_macro_ui_line3 = "|cffff0000Votre macro |r|cffff6666%s|r|cffff0000 ne contient pas la ligne suivante:|r"
	sm_no_macro_ui_line4 = "|cffff6666/script --CastSpellByName(\"Métamorphose\");|r|cffff0000 Donc la porté et les tests|r"	-- the ; is optional.
	sm_timer_rightclick = "Clic droit pour cibler |cffffff00%s|r."
	--Buttons--
	sm_string_up = "En Haut"
	sm_string_down = "En Bas"
	sm_string_add = "Ajouter"
	sm_string_edit = "Editer"
	sm_string_confirm = "Valider"
	sm_string_cancel = "Annuler"
	sm_string_set_player = "Assigne joueur"
	sm_string_change = "Change"
	sm_string_refresh = "Rafraichir"
	sm_string_set_defaults = "Remise à zéro"
	sm_string_help = "Aide"
	sm_string_gotospecials = "Edition de zones et unités spéciales"
	sm_string_gotomain = "Retour au menu principal"

elseif Location == "Spain" then

		-- Defaults --
	sm_defaults["DisallowedZones"][1] = "Núcleo de Magma"
	sm_defaults["DisallowedZones"][2] = "Guarida Alanegra"
	sm_defaults["DisallowedZones"][3] = "Ahn'Qiraj"
	sm_defaults["DisallowedZones"][4] = "Ruinas de Ahn'Qiraj"
	sm_defaults["DisallowedZones"][5] = "Naxxramas"
	sm_defaults["DisallowedMobs"][1] = "Raptor Razzashi"
	sm_defaults["DisallowedMobs"][2] = "Quimerok"
	sm_defaults["DisallowedMobs"][3] = "Quimera Arcana"
	sm_defaults["DisallowedMobs"][4] = "Devorador Quimerok"
	sm_defaults["StickyMobs"][1] = "Maestro de los Elementos Formacio Krixix"

		-- Polymorphing --
	sm_mc_poly = "Transformando |cffffff00%s|r, porque %s%s ha sido controlad%s mentalmente." -- Controlado (M); controlada (F)
	sm_pvp_warning = "|cffff0000Advertencia:|r Transformar a %s te hará activar el JcJ."

		-- Errors --
	sm_target_empty = "<sin objetivo>"
	sm_not_mage = "No eres un mago."
	sm_no_spell_at_all = "No conoces el hechizo Polimorfia."
	sm_no_command = "Teclea |c00ffff00/oveja ayuda|r para obtener una lista de comandos."
	sm_duplicate_found = "Entrada ya encontrada."

		-- Miscellaneous --
	sm_language = "Español"
	sm_english = "Inglés"
	sm_string_special = "special"
	sm_string_message = "message"
	sm_mod_loaded = "Modo de oveja de Turkeyii cargado. Teclea |c00ffff00/oveja ayuda|r para más información."
	sm_set_defaults = "Estableciendo los valores de raíz para Turkeyii's Sheep Mod."
	sm_version_update = "Actualizando tus ajustes a versión más reciente de SheepMod."
	sm_buffdur_none = "Buff %s no tiene duración."
	sm_buffdur_secs = "Buff %s tiene %s segundos hasta acabarse."
	sm_buffdur_mins = "Buff %s tiene %s minutos y %s segundos hasta acabarse."
	sm_buffdur_hours = "Buff %s tiene %s horas, %s minutos y %s segundos hasta acabarse."
	sm_buffdur_days = "Buff %s tiene %s días, %s horas, %s minutos y %s segundos hasta acabarse."

		-- Bindings --
	BINDING_NAME_SHEEPMODCAST = "Transforma tu objetivo"
	BINDING_NAME_SHEEPMODOPTIONS = "Abre las opciones"

		-- Nefarian --
	sm_string_blizzard = "Ventisca"
	sm_string_flamestrike = "Fogonazo"
	sm_string_ae = "Deflagración Arcana"
	sm_nef = "Lanzarás el hechizo                             a los Dracónidos en la lucha contra Nefarian."
	sm_nefarians_lair = "Guarida de Nefarian"
	sm_string_bwl = "Guarida Alanegra"

		-- Combat Messages -- 
	sm_you_cast = "Lanzas "
	sm_string_on = " a "
	sm_fades_from = "%s desparece de %s."
	sm_is_removed = "se ha quitado %s de %s."
	sm_unit_dies = "%s muere."
	sm_string_resisted = "%s ha resistido tu %s."

		-- Help --
	sm_helpframe_intro = "|cff00ff00Bienvenid%s a Turkeyii's Sheep Mod!|r" -- Bienvenido (M); bienvenida (F)
	sm_helpframe_version = "Estás actualmente usando la versión %s de SheepMod."
	sm_helpframe_text1 = "Para transformar a tus objetivos, debes tener un macro que incluya las dos siguientes líneas:%sRecuerda que la segunda línea puede cambiar por el caso. Además, Bien el macro debe tener el icono de Polimorfia, bien su nombre debe contener las siglas \"poly\", \"polimorfia\" o \"oveja\"."
	sm_helpframe_text2 = "|cffffff00Instrucciones generales:|r\nPara llegar al menú de opciones, teclea |cffffff00/oveja|r.\nPara cambiar \"special\" zonas y unidades, teclea |cffffff00/oveja special|r.\nPara decir que estás transformando a un objetivo, teclea |c00ffff00/oveja message|r."
	sm_helpframe_text3 = "|cffffff00Instrucciones variadas:|r\nPara saber cuánto le queda a un buff, teclea |c00ffff00/oveja buff [index]|r."

		-- Short phrases --
	sm_string_sheep = "oveja"
	sm_string_pig = "cerdo"
	sm_string_turtle = "tortuga"
	sm_string_polymorph = "Polimorfia"
	sm_string_humanoid = "Humanoide"
	sm_string_beast = "Bestia"
	sm_string_critter = "Alimaña"
	sm_string_random_animal = "animal al azar"	-- Should "Animal" have a capital?
	sm_string_rank = "Rango "
	sm_string_any = " ningún "
	sm_string_the_same = " el mismo "
	sm_string_colon = ": "

		-- UI Objects' text --
	--Check Boxes--
	sm_button_enable = "Activa todos los gestos"
	sm_button_timerbox = "Muestra el marcador de tiempo de la Polimorfia"
	sm_button_stopcasting = "Detén el lanzamiento de hechizos al transformar"
	sm_button_resheep = "Haz un gesto cuando vuelvas a transformar"
	sm_button_resheep_animal = "Siempre retransformar en el mismo animal"
	sm_button_players = "Haz un gesto al transformar jugadores inimigos"
	sm_button_ffapvp = "Haz un gesto al transformar jugadores que activen su libre para todos JcJ"
	sm_button_mc= "Transforma automáticamente los jugadores controlados mentalmente"	-- "todos los jugadores válidos" is too long.
	sm_button_mcandname= "Transforma al jugador controlado mentalmente: |cffffff00%s|r"
	sm_button_mcwarning = "Advertencia al transformar automáticamente un jugador controlado mentalmente"
	sm_button_mcemote = "Haz un gesto al transformar un jugador controlado mentalmente"
	sm_button_mcignorezone = "Ignorar pruebas de zona al transformar un jugador controlado mentalmente"
	sm_button_mcrank = "Usa siempre Polimorfia rango                en jugadores controlados mentalmente"
	sm_button_pvpwarning = "Advertencia cuando estás a punto de activar el JcJ por transformar a un jugador"
	sm_button_timed = "No hacer gestos para                             objectivo más de una vez cada                  segundos"
	sm_button_resist = "Haz un gesto automáticamente cuando tu polimorfia es resistida"
	sm_button_resistzone = "Ignorar comprobación de zona al avisar de una transformación resistida"
	--General strings--
	sm_list["DisallowedZones"] = "El mensaje de advertencia de la polimorfia |c00ff0000nunca|r aparecerá en las siguientes %s zonas:"
	sm_list["DisallowedZones1"] = "El mensaje de advertencia de la polimorfia |c00ff0000nunca|r aparecerá en las siguiente zona:"
	sm_list["DisallowedMobs"] = "El mensaje de advertencia de la polimorfia |c00ff0000nunca|r aparecerá para las siguientes %s unidades:"
	sm_list["DisallowedMobs1"] = "El mensaje de advertencia de la polimorfia |c00ff0000nunca|r aparecerá para la siguiente unidad:"
	sm_list["StickyMobs"] = "La advertencia de la polimorfia |c0000ff00siempre|r aparecerá para estas %s unidades, sin contar la zona:"
	sm_list["StickyMobs1"] = "La advertencia de la polimorfia |c0000ff00siempre|r aparecerá para esta unidad, sin contar la zona:"	--	", con independencia de la zona:" is too long.
	sm_string_language = "Al transformar un objetivo, tus gestos serán enviados en                            ."
	sm_type = "Al transformar, tu objetivo será transformado en                            ."
	sm_macro_summary_misc = "Tu macro de Polimorfia |c00ffff00%s|r está en la barra %s, posición %s."
	sm_macro_summary_12 = "Tu macro de Polimorfia |c00ffff00%s|r está en la barra %s, posición 12."
	sm_spell_summary_misc = "Tu hechizo de polimorfia está en la barra de hechizos %s, posición %s."
	sm_spell_summary_12 = "Tu hechizo de polimorfia está en la barra de hechizos %s, posición 12."	
	sm_no_macro_ui_line1 = "|cffff0000No tienes ningún macro de polimorfia en ninguna barra. Como tal,|r"
	sm_no_macro_ui_line2 = "|cffff0000Pruebas de cooldown no ocurrirán cuando intentes la polimorfia.|r"
	sm_no_macro_ui_line3 = "|cffff0000Tu macro |r|cffff6666%s|r|cffff0000 no contiene la siguiente línea:|r"
	sm_no_macro_ui_line4 = "|cffff6666/script --CastSpellByName(\"Polimorfia\");|r|cffff0000 Como tal,|r"
	sm_timer_rightclick = "Click con el derecho para seleccionar |cffffff00%s|r."
	--Buttons--
	sm_string_up = "Subir"
	sm_string_down = "Bajar"
	sm_string_add = "Añadir"
	sm_string_edit = "Editar"
	sm_string_confirm = "Ratificar"	-- "Confirmar" also possible.
	sm_string_cancel = "Cancelar"
	sm_string_set_player = "Elegir un jugador"
	sm_string_change = "Cambiar"
	sm_string_refresh = "Actualizar"
	sm_string_set_defaults = "Valores base"
	sm_string_help = "Ayuda"
	sm_string_gotospecials = "Editar zonas y unidades especiales"
	sm_string_gotomain = "Opciones principales"	-- "Volver a las opciones principales" is a little long.

elseif Location == "Germany" then

		-- Defaults --
	sm_defaults["DisallowedZones"][1] = "Geschmolzener Kern"
	sm_defaults["DisallowedZones"][2] = "Pechschwingenhort"
	sm_defaults["DisallowedZones"][3] = "Ahn'Qiraj"
	sm_defaults["DisallowedZones"][4] = "Tore von Ahn'Qiraj"
	sm_defaults["DisallowedZones"][5] = "Naxxramas"
	sm_defaults["DisallowedMobs"][1] = "Razzashiraptor"
	sm_defaults["DisallowedMobs"][2] = "Chimaerok"
	sm_defaults["DisallowedMobs"][3] = "Arkaner Chimaerok"
	sm_defaults["DisallowedMobs"][4] = "Chimaerok-Verschlinger"
	sm_defaults["StickyMobs"][1] = "Meisterelementarformer Krixix"

		-- Polymorphing --
	sm_mc_poly = "Verwandle |cffffff00%s|r, weil %s übernommen wurde."
	sm_pvp_warning = "|cffff0000Achtung:|r Das Verwandeln von %s wird dich für den PvP Kampf markieren."

		-- Errors --
	sm_target_empty = "<kein Ziel>"
	sm_not_mage = "Du bist kein Magier."
	sm_no_spell_at_all = "Du kennst den Zauber Verwandlung nicht."
	sm_duplicate_found = "Duplizierten Eintrag gefunden."
	sm_no_command = "Schreibe |c00ffff00/sheep hilfe|r für eine Liste von Befehlen."

		-- Miscellaneous --
	sm_language = "Deutsch"
	sm_english = "Englisch"
	sm_string_special = "spezial"
	sm_string_message = "nachricht"
	sm_mod_loaded = "Turkeyii's sheeping mod geladen. Schreibe |c00ffff00/schaf hilfe|r für weitere Informationen."
	sm_set_defaults = "Standardeinstellungen werden gesetzt für Turkeyii's Sheeping Mod."
	sm_version_update = "Deine Einstellungen werden für die aktuelle Version von SheepMod konvertiert."
	sm_buffdur_none = "Der Buff %s ist unbegrenzt."
	sm_buffdur_secs = "Der Buff %s hält noch %s Sekunden an."
	sm_buffdur_mins = "Der Buff %s hält noch %s Minuten und %s Sekunden an."
	sm_buffdur_hours = "Der Buff %s hält noch %s Stunden, %s Minuten und %s Sekunden an."
	sm_buffdur_days = "Der Buff %s hält noch %s Tage, %s Stunden, %s Minuten und %s Sekunden an."

		-- Bindings --
	BINDING_NAME_SHEEPMODCAST = "Verwandle dein Ziel"
	BINDING_NAME_SHEEPMODOPTIONS = "Öffne das Optionsmenü"

		-- Nefarian --
	sm_string_blizzard = "Blizzard"
	sm_string_flamestrike = "Flammenstoß"
	sm_string_ae = "Arkane Explosion"
	sm_nef = "Du zauberst                             auf die Drachkins im Nefarian-Kampf."
	sm_nefarians_lair = "Nefarians Unterschlupf"
	sm_string_bwl = "Pechschwingenhort"

		-- Combat Messages -- 
	sm_you_cast = "Ihr wirkt "
	sm_string_on = " auf "
	sm_fades_from = "%s schwindet von %s."
	sm_is_removed = "'%s' von %s wurde entfernt."
	sm_unit_dies = "%s stirbt."
	sm_string_resisted = "Ihr habt es mit %s versucht, aber %s hat widerstanden."

		-- Help --
	sm_helpframe_intro = "|cff00ff00Willkommen zu Turkeyii's Sheep Mod!|r"
	sm_helpframe_version = "Du benutzt SheepMod Version %s."
	sm_helpframe_text1 = "Um deine Ziele zu verwandeln brauchst du ein Makro mit diesen beiden Zeilen:%sAchtung! Die zweite Zeile ist case-sensitive. Zusätzlich muss das Makro das verwandlung Symbol haben oder \"schaf\" heißen."
	sm_helpframe_text2 = "|cffffff00Allgemeine Befehle:|r\nUm das Einstellungsmenü zu öffnen schreibe |cffffff00/schaf|r.\nUm \"spezielle\" Gebiete und Einheiten zu ändern, schreibe |cffffff00/schaf spezial|r.\nUm zu sagen, dass du ein Ziel verwandelst, schreibe |c00ffff00/sheep nachricht|r. "
	sm_helpframe_text3 = "|cffffff00Verschiedene Befehle:|r\nUm abzufragen wie lange ein Buff noch läuft schreibe |c00ffff00/schaf buff [index]|r."

		-- Short phrases --
	sm_string_sheep = "schaf"
	sm_string_pig = "schwein"
	sm_string_turtle = "schildkröte"
	sm_string_polymorph = "Verwandlung"
	sm_string_humanoid = "Humanoid"
	sm_string_beast = "Wildtier"
	sm_string_critter = "Tier"
	sm_string_random_animal = "zufälliges Tier"
	sm_string_rank = "Rang "
	sm_string_any = " jedes "
	sm_string_the_same = " das Gleiche "
	sm_string_colon = ": "

		-- UI Objects' text --
	--Check Boxes--
	sm_button_enable = "Aktivere alle Emotes"
	sm_button_timerbox = "Zeige Verwandlungsdauer"
	sm_button_resheep = "Emote beim neu-Verwandeln eines Ziels"
	sm_button_resheep_animal = "Beim neu-Verwandeln immer das Gleiche Tier verwenden"
	sm_button_players = "Emote beim Verwandeln eines feindlichen Spielers"
	sm_button_ffapvp = "Emote beim Verwandeln eines für den Jeder-gegen-Jeden-PvP"	--  Kampf markierten Spielers?
	sm_button_mc= "Automatisches verwandeln von übernommenen Spielern"
	sm_button_mcandname= "Automatisches Verwandeln des übernommenen Spielers: |cffffff00%s|r"
	sm_button_mcwarning = "Warnen beim automatischen Verwandeln eines übernommenen Spielers"
	sm_button_mcemote = "Emote beim Verwandeln eines übernommenen Spielers"
	sm_button_mcignorezone = "Überspringe Gebiets Überprüfung beim Verwandeln eines übernommenen Spielers"
	sm_button_mcrank = "Benutze immer Verwandlung Rang                auf übernommene Spieler"
	sm_button_pvpwarning = "Warnen wenn du dich durch Verwandeln eines Spielers für den PvP Kampf markierst"
	sm_button_resist = "Automatisches Emote, wenn die Verwandlung widerstanden wurde"
	sm_button_resistzone = "Ignoriere Zonen Überprüfung, wenn vor einer widerstandenen Verwandlung gewarnt wird"
	sm_button_timed = "Emote nie für                              Ziel öfter als alle                 Sekunden"
	sm_button_stopcasting = "Breche andere Zaubercasts ab, wenn Verwandlung gezaubert wird"
	--General strings--
	sm_list["DisallowedZones"] = "Das Emote wird |c00ff0000nie|r in den folgenden %s Gebieten angezeigt:"
	sm_list["DisallowedZones1"] = "Das Emote wird |c00ff0000nie|r in dem folgenden %s Gebiet angezeigt:"
	sm_list["DisallowedMobs"] = "Das Emote wird |c00ff0000nie|r für die folgenden %s Einheiten angezeigt:"
	sm_list["DisallowedMobs1"] = "Das Emote wird |c00ff0000nie|r für die folgende Einheit angezeigt:"
	sm_list["StickyMobs"] = "Das Emote wird |c00ff0000nie|r für die folgenden %s Einheiten angezeigt, unabhängig des Gebiets:"
	sm_list["StickyMobs1"] = "Das Emote wird |c00ff0000nie|r für die folgende Einheit angezeigt, unabhängig des Gebiets:"
	sm_string_language = "Wenn ein Ziel verwandelt wird, werden deine Emotes in                             gesendet."
	sm_type = "Wenn du verwandelst, wird dein Ziel dazu                            ."
	sm_macro_summary_misc = "Dein Verwandlungsmakro |c00ffff00%s|r ist in der Aktionsleiste %s, auf Platz %s."
	sm_macro_summary_12 = "Dein Verwandlungsmakro |c00ffff00%s|r ist in der Aktionsleiste %s, auf Platz 12."
	sm_spell_summary_misc = "Dein Verwandlungszauber ist in der Aktionsleiste %s, auf Platz %s."
	sm_spell_summary_12 = "Dein Verwandlungszauber ist in der Aktionsleiste %s, auf Platz 12."
	sm_no_macro_ui_line1 = "|cffff0000Du hast kein Verwandlungsmakro auf einer Aktionsleiste. Deshalb,|r"
	sm_no_macro_ui_line2 = "|cffff0000siehst du keinen Cooldown, wenn du versuchst zu verwandeln.|r"
	sm_no_macro_ui_line3 = "|cffff0000Dein Makro |r|cffff6666%s|r|cffff0000 enthält folgende Zeile nicht:|r"
	sm_no_macro_ui_line4 = "|cffff6666/script --CastSpellByName(\"Verwandlung\");|r|cffff0000 Deshalb,|r"
	sm_timer_rightclick = "Rechtsklicken zum anvisieren |cffffff00%s|r."
	--Buttons--
	sm_string_up = "Auf"
	sm_string_down = "Ab"
	sm_string_add = "Neu"
	sm_string_edit = "Editieren"
	sm_string_confirm = "OK"
	sm_string_cancel = "Abbrechen"
	sm_string_set_player = "Spieler festlegen"
	sm_string_change = "Wechseln"
	sm_string_refresh = "Aktualisieren"
	sm_string_set_defaults = "Zurücksetzen"
	sm_string_help = "Hilfe"
	sm_string_gotospecials = "Spezielle Gebiete und Einheiten"
	sm_string_gotomain = "Zurück zum Hauptmenü"
end

function SheepMod.Set_Emotes()
	if Location == "France" and SheepModOptions[Realm][Player].Language == sm_language then
		sm_resheep[1]		= "est en train de relancer métamorphose sur %s."
		sm_resheep[2]		= "va laisser à %s encore un peu de temps pour brouter tranquillement."
		sm_resheep[3]		= "trouve que %s fait un%s %s très bon%s, allez hop encore une fois."
		sm_polymorph["mouton1"]	= "transforme %s en joli mouton – trop mignon pour taper dessus."
		sm_polymorph["cochon1"]	= "vous ordonne de regarder %s la cochon brouter de l'herbe. Bas les pattes !"
		sm_polymorph["tortue1"]	= "vous ordonne de regarder %s la belle tortue gambader dans l'herbe."
		sm_polymorph["vache1"]	= "vous ordonne de regarder %s brouter de l'herbe en tant que vache, pas touche !"
		sm_polymorph["mouton2"]	= "vous ordonne de regarder %s brouter de l'herbe en tant que mouton. Bas les pattes !"
		sm_polymorph["mouton2"]	= "vous ordonne de regarder %s le mouton brouter de l'herbe. Bas les pattes !"
		sm_polymorph["cochon2"]	= "vous ordonne de regarder %s le cochon brouter de l'herbe. Pas touche !"
		sm_polymorph["tortue2"]	= "vous ordonne de regarder %s la belle tortue gambader dans l'herbe."
		sm_polymorph["vache2"]	= "vous ordonne de regarder %s la vache brouter de l'herbe !"
		sm_polymorph["Other1"]	= "transforme %s en joli %s – trop mignon pour taper dessus."
		sm_polymorph["Other2"]	= "vous ordonne de regarder %s le %s brouter de l'herbe. Pas touche !"
		sm_polymorph[3]		= "propose à %s de prendre des forces en mangeant un peu de verdure."
		sm_polymorph[4]		= "suggère à %s d'aller gambader tranquillement et de laisser faire les grandes personnes."
		sm_polymorph[5]		= "moutonne %s; pas d'AoE à proximité ni lancez les DoTs sur lui."
		sm_resisted[1]		= "n'a pas eu de succès en polymorphant sa cible, %s !"
		sm_resisted[2]		= "devrait practiquer plus avant de jouer avec la magie ! %s a été raté par sa transformation !"
		sm_resisted[3]		= "echoué dans la transformation de %s ! Où a-t-il obtenu son diplôme de mage ?"
	elseif Location == "Spain" and SheepModOptions[Realm][Player].Language == sm_language then
		sm_resheep[1]		= "está transformando de nuevo a %s."
		sm_resheep[2]		= "ha concedido más tiempo a %s para relajarse sobre la hierba."
		sm_resheep[3]		= "está demasiado encandilada con %s %s %s como para dejar%s volver a su forma anterior."	-- dejarle for “cerdo”, dejarla for both “oveja” and “tortuga”.
		sm_polymorph["oveja1"]	= "está transformando a %s en una oveja tan adorable – demasiado maja para ser atacada."
		sm_polymorph["cerdo1"]	= "está transformando a %s en un simpático cerdito – demasiado majo para ser atacado."
		sm_polymorph["tortuga1"]= "está transformando a %s en una inofensiva tortuga – no la ataques, ella no lo haría."
		sm_polymorph["oveja2"]	= "os invita a observar cómo %s pasta apaciblemente en su forma de oveja."
		sm_polymorph["cerdo2"]	= "os invita a observar cómo %s se revuelca en el barro en su forma de cerdo."
		sm_polymorph["tortuga2"]= "os invita a observar cómo %s vaga con lentitud en su forma de tortuga."
		sm_polymorph["Other1"]	= "está transformando a %s en – no lo/la ataques, él/ella no lo haría."
		sm_polymorph["Other2"]	= "os invita a observar cómo %s pasta apaciblemente en su forma de %s."
		sm_polymorph[3] 	= "os invita a contemplar a %s, que pronto será una %s."
		sm_polymorph[4] 	= "propone a %s tomarse %s de hierba en su%s forma de %s."
		sm_polymorph[5] 	= "está transformando a %s. No %s ataques, ni uses DoTs o AoE en %s."
		sm_resisted[1]		= "no ha tenido éxito al transformar a su objetivo, %s."
		sm_resisted[2]		= "debería practicar antes de lanzar conjuros, la transformación de %s ha fallado."
		sm_resisted[3]		= "ha fracasado en la transformación de %s. Y se hace llamar maga…"
		sm_breakfast = "un buen desayuno"
		sm_lunch = "una buena comida"
		sm_dinner = "una buena cena"
	elseif Location == "Germany" and SheepModOptions[Realm][Player].Language == sm_language then
		sm_resheep[1]		= "verwandelt %s erneut."
		sm_resheep[2]		= "ist dabei %s etwas mehr Zeit zum Gras fressen zu geben."
		sm_resheep[3]		= "ist zu fasziniert von %s um sich jetzt schon davon zu trennen."
		sm_polymorph["schaf1"]			= "verwandelt %s in ein nettes fluffiges Schaf – viel zu knuddelig um es anzugreifen."
		sm_polymorph["schwein1"]		= "verwandelt %s in ein nettes Schwein mit Ringelschwanz – viel zu knuddelig um es anzugreifen."
		sm_polymorph["schildkröte1"]		= "verwandelt %s in eine nette freundliche Schildkröte – viel zu knuddelig um sie anzugreifen."
		sm_polymorph["cow1"]			= "verwandelt %s in eine nette milchgebende Kuh – viel zu knuddelig um sie anzugreifen."
		sm_polymorph["schaf2"]			= "sagt euch %s zu beobachten wie %s als Schaf Mengen an Gras vertilgt als ob es kein Morgen gäbe."
		sm_polymorph["schwein2"]		= "ermahnt euch die Finger vom Speck des %ss zu lassen!"
		sm_polymorph["schildkröte2"]		= "sagt euch %s zu beobachten wie %s als Schildkröte seeehr laaaaaangsam umherwandert."
		sm_polymorph["cow2"]			= "sagt euch %s zu beobachten wie %s als Kuh Futter wiederkäut als ob es kein Morgen gäbe."
		sm_polymorph["Other1"]			= "verwandelt %s in ein(e)(n) nette(s/n) freundliche(s/n) %s – viel zu knuddelig um %s anzugreifen."
		sm_polymorph["Other2"]			= "sagt euch das Gras auf der Wiese zu beobachten wie es von %s als %s verschlungen wird als ob es kein Morgen gäbe."
		sm_polymorph[3] 	= "sagt euch die Finger von %s, %s in spe, zu lassen."
		sm_polymorph[4] 	= "lässt %s ein leckeres %s an Gras fressen, während %s %s ist."	-- ein/eine is part of the second %s.
		sm_polymorph[5] 	= "verwandelt %s, also greife %s weder an noch DoTe %s%s%s, oder benutze AoE in der Nähe."
		sm_resisted[1]		= "s Ziel, %s, mag süße knuddelige Tiere so wenig, dass %s widerstanden hat in eins verwandelt zu werden!"
		sm_resisted[2]		= "hat versagt %s in ein allerliebstes freundliches Tier zu verwandeln; %s hat den Zauber widerstanden!"
		sm_resisted[3]		= "hat versucht %s etwas knuddeliger zu machen… aber %s hat die Verwandlung widerstanden!"
		sm_breakfast = "Frühstück"
		sm_lunch = "Mittagessen"
		sm_dinner = "Abendbrot"
	else
		sm_resheep[1]		= "is resheeping %s."
		sm_resheep[2]		= "is about to give %s some more time to gorge %sself on grass."
		sm_resheep[3]		= "is too fascinated by %s the %s%s to let %s%s turn back."
		sm_polymorph["sheep1"]	= "is turning %s into a nice fluffy sheep – much too cuddly to attack."
		sm_polymorph["pig1"]	= "is turning %s into a nice curly-tailed pig – much too cuddly to attack."
		sm_polymorph["turtle1"]	= "is turning %s into a nice friendly turtle – much too cuddly to attack."
		sm_polymorph["cow1"]	= "is turning %s into a nice milky cow – much too cuddly to attack."
		sm_polymorph["sheep2"]	= "tells you to watch %s guzzling that grass like there's no tomorrow, as a sheep."
		sm_polymorph["pig2"]	= "warns you not to save %s's bacon!"
		sm_polymorph["turtle2"]	= "tells you to watch %s wandering around veeerrryyy sloooooowly, as a turtle."
		sm_polymorph["cow2"]	= "tells you to watch %s chewing that cud like there's no tomorrow, as a cow."
		sm_polymorph["Other1"]	= "is turning %s into a nice friendly %s – much too cuddly to attack."
		sm_polymorph["Other2"]	= "tells you to watch %s guzzling that grass like there's no tomorrow, as a %s."
		sm_polymorph[3] 	= "tells you to leave %s, the nice soon-to-be %s, alone."
		sm_polymorph[4] 	= "urges %s to get a nice %s of grass, while %s's a %s."	-- "…to get a nice <breakfast/lunch/dinner> of…"
		sm_polymorph[5] 	= "is polymorphing %s, so don't attack or DoT %s, or AoE nearby."
		sm_resisted[1]		= "'s target, %s, so dislikes cute cuddly animals that %s resisted being turned into one!"
		sm_resisted[2]		= "failed to turn %s into a lovely friendly animal; %s resisted the spell!"
		sm_resisted[3]		= "tried to make %s a little more cuddly… but %s resisted being polymorphed!"
		sm_breakfast = "breakfast"
		sm_lunch = "lunch"
		sm_dinner = "dinner"
	end
end
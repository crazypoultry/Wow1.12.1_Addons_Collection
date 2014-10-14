-- ## Vendetta boss mod Temple d'ahnQiraj ##
--   ## Traduction fr by Elfik/cr0k ##


if (GetLocale() == "frFR") then
--1. Skeram
LVBM_SKERAM_NAME			= "Le Proph\195\168te Skeram";
LVBM_SKERAM_DESCRIPTION			= "Annonces explosion des arcanes et control mentale.";

LVBM_SKERAM_AE				= "** EXPLOSION DES ARCANES - COUP DE PIED **";
LVBM_SKERAM_MC				= "** %s EST SOUS CONTROLE MENTAL **";

LVBM_SKERAM_CAST_SPELL_AE		= "Le Proph\195\168te Skeram commence \195\160 lancer Explosion des arcanes.";
LVBM_SKERAM_MIND_CONTROL_TEXTURE	= "Spell_Shadow_Charm";
LVBM_SKERAM_MIND_CONTROL_DEBUFF		= "Accomplissement v\195\169ritable";

-- 2. Three Bugs (Vem & Co)
LVBM_THREEBUGS_NAME			= "Three Bugs - Vem, Yauj et Kri";
LVBM_THREEBUGS_VEM			= "Vem";
LVBM_THREEBUGS_YAUJ			= "Princesse Yauj";
LVBM_THREEBUGS_KRI			= "Seigneur Kri";
LVBM_THREEBUGS_VEM			= "Vem";
LVBM_THREEBUGS_REAL_NAME		= "Three Bugs";
LVBM_THREEBUGS_FEAR_EXPR		= "(.+) (.+) est Fear.";
LVBM_THREEBUGS_FEAR_ANNOUNCE		= "*** Yauj Fear dans %d sec ***";
LVBM_THREEBUGS_CASTHEAL_EXPR		= "Yauj va se heal.";
LVBM_THREEBUGS_CASTHEAL_ANNOUNCE	= "*** Yauj se heal, coupez la ! ***";


-- 3. Battleguard Sartura
LVBM_SARTURA_NAME			= "Garde de guerre Sartura"
LVBM_SARTURA_DESCRIPTION		= "Vous alerte lorsque Garde de guerre Sartura gagne Tourbillon.";

LVBM_SARTURA_ANNOUNCE_WHIRLWIND		= "*** TOURBILLON - 25 sec avant prochain ***";
LVBM_SARTURA_WHIRLWIND_FADED		= "*** TOURBILLON FINI - ASSOMMEZ-LE ! ***";

LVBM_SARTURA_GAIN_WHIRLWIND		= "Garde de guerre Sartura gagne Tourbillon.";
LVBM_SARTURA_WHIRLWIND_FADES		= "Tourbillon sur Garde de guerre Sartura vient de se dissiper.";
LVBM_SARTURA_ENRAGE			= "%s devient fou furieux !";
LVBM_SARTURA_SARTURA			= "Garde de guerre Sartura";


-- 4. Fankriss
LVBM_FANKRISS_NAME			= "Fankriss l'Inflexible"
LVBM_FANKRISS_DESCRIPTION		= "Alerte lorsque Frankriss invoque un ver";

LVBM_FANKRISS_SPAWN_WARNING		= "*** INVOCATION D'UN VER ***";

LVBM_FANKRISS_WORM_SPAWNED		= "Fankriss l'Inflexible lance Invocation d'un ver.";


-- 5. Huhuran
LVBM_HUHURAN_NAME			= "Princesse Huhuran";
LVBM_HUHURAN_DESCRIPTION		= "Alerte lorsque Princesse Huhuran est pris de fr\195\169n\195\169sie et Piq\195\187re de wyverne";
LVBM_HUHURAN_ANNOUNCE_FRENZY		= "Alerte de fr\195\169n\195\169sie";

LVBM_HUHURAN_WYVERN_WARNING		= "** Piq\195\187re de wyverne dans moins de 5 sec **";

LVBM_HUHURAN_WYVERN_REGEXP		= "(%w+) subbit les effets de Piq\195\187re de wyverne%.";
LVBM_HUHURAN_FRENZY			= "%s entre dans une rage d\195\169mente !";
LVBM_HUHURAN_HUHURAN			= "Princesse Huhuran";


-- Anubisat Defenders
LVBM_DEFENDER_NAME			= "D\195\169fenseur Anubisath";
LVBM_DEFENDER_DESCRIPTION		= "Annonce de l'explosion et de la peste";
LVBM_DEFENDER_WHISPER			= "Envoie un message aux joueurs qui ont la Peste.";
LVBM_DEFENDER_PLAGUE			= "Annoncer la peste";

LVBM_DEFENDER_ANNOUNCE_EXPLODE		= "*** EXPLOSION IMMINENTE ***";
LVBM_DEFENDER_ANNOUNCE_PLAGUE		= "*** %s LA PESTE ***";
LVBM_DEFENDER_WHISPER_PLAGUE		= "TU AS LA PESTE !";
LVBM_DEFENDER_PLAGUE_WARNING		= "Peste";

LVBM_DEFENDER_GAIN_EXPLODE		= "D\195\169fenseur Anubisath gagne Exploser.";
LVBM_DEFENDER_PLAGUE_REGEXP		= "([^%s]+) (%w+) les effets de Peste%.$";



-- 6. Twin Emperors
LVBM_TWINEMPS_NAME			= "Empereurs jumeaux";
LVBM_TWINEMPS_DESCRIPTION		= "Afficher les annonces pour le combat contre les Empereurs jumeaux";
LVBM_TWINEMPS_REAL_NAME		= "Empereurs jumeaux";

LVBM_TWINEMPS_TELEPORT_WARNING		= "*** Teleportation dans %s sec ***";
LVBM_TWINEMPS_ENRAGE_WARNING		= "*** Enrager dans %s %s ***";

LVBM_TWINEMPS_TELEPORT_ANNOUNCE		= "T\195\169l\195\169portation";

LVBM_TWINEMPS_CAST_SPELL_1		= "Empereur Vek'lor lance T\195\169l\195\169portation des jumeaux.";
LVBM_TWINEMPS_CAST_SPELL_2		= "Empereur Vek'nilash lance T\195\169l\195\169portation des jumeaux.";
LVBM_TWINEMPS_VEKNILASH			= "Empereur Vek'nilash";
LVBM_TWINEMPS_VEKLOR			= "Empereur Vek'lor";

LVBM_TWINEMPS_EXPLODE_EXPR 		= "gagne Explosion de l'insecte";
LVBM_TWINEMPS_EXPLODE_ANNOUNCE 		= "Un insecte va exploser - BOUGEZ !";


-- 7. Ouro
LVBM_OURO_NAME				= "Ouro";
LVBM_OURO_DESCRIPTION			= "Provides a timer for Ouro's submerge.";

LVBM_OURO_SWEEP_SOON_WARNING		= "*** BALAYAGE dans 5 sec ***";
LVBM_OURO_BLAST_SOON_WARNING		= "*** EXPLOSION DE SABLE dans 5 sec ***";
LVBM_OURO_SWEEP_WARNING			= "*** balayage dans 1.5sec ***";
LVBM_OURO_BLAST_WARNING			= "*** EXPLOSION DE SABLE dans 2 sec ***";
LVBM_OURO_SUBMERGED_WARNING		= "*** OURO DISPARAIT pour 30 sec ***";
LVBM_OURO_EMERGE_SOON_WARNING		= "*** OURO REAPPARAIT DANS 5SEC ***";
LVBM_OURO_EMERGED_WARNING		= "*** OURO APPARAIT ***";
LVBM_OURO_POSSIBLE_SUBMERGE_WARNING	= "*** Possible disparition de ouro dans 10 sec ***";
LVBM_OURO_SUBMERGE_WARNING		= "*** %s secondes avant que Ouro n'apparaisse ***";

LVBM_OURO_CAST_SWEEP			= "Ouro commence \195\160 lancer Balayer.";
LVBM_OURO_CAST_SAND_BLAST		= "Ouro commence \195\160 ex\195\169cuter Explosion de sable.";
LVBM_OURO_DIRT_MOUND_QUAKE		= "Ouro lance Invocation de Monticules d'Ouro.";
LVBM_OURO_ENRAGE			      = "%s entre dans une rage d\195\169mente !";
LVBM_OURO_OURO				= "Ouro";



-- 8. CThun
LVBM_CTHUN_NAME				= "C'Thun"
LVBM_CTHUN_DESCRIPTION			= "Alertes de pop des Tentacules oculaires et de son \195\169tat affaibli en phase 2."
LVBM_CTHUN_SLASHHELP1			=  "/cthun start - Lancer les timers";
LVBM_CTHUN_SEND_WHISPER			= "Send whisper";
LVBM_CTHUN_SET_ICON			= "Set icon";
LVBM_CTHUN_RANGE_CHECK			= "Range check";
LVBM_CTHUN_RANGE_CHECK_PHASE2		= "Show Range Frame during phase 2";

LVBM_CTHUN_SMALL_EYE_WARNING		= "*** Tentacules oculaires dans %s sec ***";
LVBM_CTHUN_DARK_GLARE_WARNING		= "*** Regard noir dans %s sec ***";
LVBM_CTHUN_DARK_GLARE_ON_GROUP	= "*** Regard noir sur le groupe ";
LVBM_CTHUN_DARK_GLARE_ON_YOU		= "Regard noir sur toi !";
LVBM_CTHUN_DARK_GLARE_TIMER_FAILED	= "Ajustement du timer Regard noir \195\169chou\195\169.";
LVBM_CTHUN_DARK_GLARE_END_WARNING	= "*** 5 sec avant fin du Regard noir ***";
LVBM_CTHUN_GIANT_CLAW_WARNING		= "*** Geante Oculaire dans 10 sec ***";
LVBM_CTHUN_GIANT_AND_EYES_WARNING	= "*** Geante %s et Tentacules Oculaires dans 10 sec ***";
LVBM_CTHUN_WEAKENED_WARNING		= "*** C'THUN EST AFFAIBLI POUR 45 SEC ***";
LVBM_CTHUN_WEAKENED_ENDS_WARNING	= "*** %s sec restant ***";
LVBM_CTHUN_DARK_GLARE			= "Regard noir";
LVBM_CTHUN_EYE_BEAM			= "Tentacule oculaire";

LVBM_CTHUN_EYE_OF_CTHUN			= "Œil de C'thun";
LVBM_CTHUN_CLAW				= "Occulaire";
LVBM_CTHUN_EYE				= "Oeil";
LVBM_CTHUN_DIES				= "Eye of C'Thun dies.";
LVBM_CTHUN_WEAKENED			= "%s est afaibli !";



--Traduction fr incoming
--Viscidus
LVBM_VISCIDUS_NAME			= "Viscidus";
LVBM_VISCIDUS_DESCRIPTION		= "Counts frost and melee hits on Viscidus.";
LVBM_VISCIDUS_SEND_WHISPER		= "Send whisper";
LVBM_VISCIDUS_SLASHHELP1		= "/Viscidus mt name - sets a main tank to prevent toxin warning spam";
LVBM_VISCIDUS_MT_SET			= "Main tank set to: ";
LVBM_VISCIDUS_MT_NOT_SET1 		= "Main tank not set! Toxin warning will whisper your main tank every 15 seconds!";
LVBM_VISCIDUS_MT_NOT_SET2		= "Type '/vis mt name' to set your main tank.";

LVBM_VISCIDUS_TOXIN_ON			= "*** Toxin on ";
LVBM_VISCIDUS_TOXIN_ON_YOU		= "Toxin on you!";
LVBM_VISCIDUS_FREEZE_WARNING		= "*** Freeze %s/3 ***";
LVBM_VISCIDUS_FROZEN_WARNING		= "*** Freeze 3/3 - frozen for 15 sec ***";
LVBM_VISCIDUS_SHATTER_WARNING		= "*** Shatter %s/3 ***";
LVBM_VISCIDUS_FROZEN_LEFT_WARNING	= "*** %s seconds left ***";
LVBM_VISCIDUS_FROST_HITS		= "Frost hits: ";
LVBM_VISCIDUS_FROST_HITS_WARNING	= "*** %s frost hits ***";
LVBM_VISCIDUS_MELEE_HITS		= "Melee hits: ";
LVBM_VISCIDUS_MELEE_HITS_WARNING	= "*** %s melee hits ***";

LVBM_VISCIDUS_SLOW_1			= "begins to slow!";
LVBM_VISCIDUS_SLOW_2			= "is freezing up!";
LVBM_VISCIDUS_SLOW_3			= "is frozen solid!";
LVBM_VISCIDUS_SHATTER_1			= "begins to crack!";
LVBM_VISCIDUS_SHATTER_2			= "looks ready to shatter!";
LVBM_VISCIDUS_VISCIDUS			= "Viscidus";

end



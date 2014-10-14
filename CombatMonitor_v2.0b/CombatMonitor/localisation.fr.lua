if (GetLocale() == "frFR") then
                        ---------------------------------------------------------------------------------------------------------------
                        -- Symboles particuliers utilisés en francais    (voir WoWkiki)                                               -
                        ---------------------------------------------------------------------------------------------------------------
                        -- \195\169 = é
                        -- \195\162 = â
                        -- \195\170 = ê
                        -- \195\160 = à
                        -- \195\167 = ç
                        -- \195\187 = û
                        
                        ---------------------------------------------------------------------------------------------------------------
                        -- Variables définissant le contenu des fenêtres dans l'interface du jeu                                      -
                        ---------------------------------------------------------------------------------------------------------------
                        
		        CMON_ALL_OPPONENTS = "Tous vos adversaires";
			CMON_ENVIRONMENTAL = "Environnement";
			CMON_ENABLEBUTTON = "Activer CombatMonitor";
			CMON_ENVIRONMENTBUTTON = "Activer les d\195\169g\195\162ts environnementaux";
			CMON_DUMPCHANNEL = "Envoyer vers le canal:";
			CMON_NEWMOBS = "Enregistrer les nouveaux adversaires";
			CMON_NONELITE = "Enregistrer les monstres non-195\169lite";
			CMON_WORLDBOSS= "Enregistrer les World Bosses";
			CMON_SHOWDPS = "Montrer les DPS instantan\195\169s"
			CMON_DPSBANNER = "DPS instantan\195\169s";
			CMON_SHOWPERCENT = "En pourcent"
			CMON_INSTANTANEOUS = "Inst:";
			CMON_AVERAGE = "Moy:";
			CMON_PEAK = "Pic:";
			CMON_VERSION = "CombatMonitor |cff00ff00";
			CMON_OPTIONS = "Options";
			CMON_DUMP = "Envoyer";
			CMON_COPY = "Copier";
			CMON_DEBUG_EVENT = "Event: source = ";
			CMON_ENABLED = "CombatMonitor Enabled";
			CMON_DISABLED = "CombatMonitor Disabled";
			CMON_RESET = "CombatMonitor Reset";
			CMON_NEWPLAYER = "CombatMonitor new player: ";
			CMON_PERCENT = "%2.2f%%";
			CMON_ENABLINGPERIODIC = "CombatMontitor requires that the Periodic Damage interface option be enabled for proper operation - enabling it now";
			CMON_MELEEHEADER = "D\195\169g\195\162ts de m\195\170l\195\169e"
			CMON_SPELLHEADER = "D\195\169g\195\162ts de sort"
			CMON_RESET_CURRENT = "Effacer la s\195\169lection";
			
			CMON_ON = "on"
			CMON_OFF = "off"
			CMON_RESET = "reset";
			CMON_VER = "version";
			CMON_CENTER = "center";
			CMON_USAGE = "Usage: /combatmonitor on | off | center | reset | version";
			
			CMON_CLEARALLERR = "CombatMonitor: Cannot clear the All Opponents category";
			CMON_VERSIONERROR1 = "CombatMonitor v";
			CMON_VERSIONERROR2 = " requires all old data to be cleared - sorry!";
			CMON_UPDATING = "CombatMonitor updating to version";
			
			CMON_ENVIRONMENTTOOLTIP = "Record environmental damage taken.  This damage is never tracked in the All Opponents category";
			
			CMON_TOTALATTACKSLABEL = "Attaques re\195\167ues:";
			CMON_MISSESLABEL = "Rat\195\169 (du monstre):";
			
			-- This string no longer occurs could be removed (I think this string was used in a previous version) ?
			CMON_WOULDHITLABEL = "Would Hit:";
			
			CMON_DODGESLABEL = "Esquives:";
			CMON_PARRIESLABEL = "Parades:";
			CMON_BLOCKSLABEL = "Blocages:";
			CMON_FULLBLOCKSLABEL = "Blocages totaux:";
			CMON_DAMAGEBLOCKEDLABEL = "D\195\169g\195\162ts bloqu\195\169s:";
			CMON_BLOCKMITIGATIONLABEL = "Taux de blocage:";
			CMON_HITSLABEL = "Coups re\195\167us:";
			CMON_CRITICALHITSLABEL = "Coups critiques:";
			CMON_CRUSHINGBLOWSLABEL = "Coups \195\169crasants:";
			CMON_PHYSICALDAMAGELABEL = "Physiques:";
			CMON_AVERAGEHITLABEL = "Average Hit:"; 
			CMON_DAMAGEAVOIDEDLABEL = "D\195\169g\195\162ts \195\169vit\195\169s:";
			CMON_DOUBLECRITICALSLABEL = "Double coup critique:";
			CMON_TRIPLECRITICALSLABEL = "Triple coup critique:";
			CMON_HOLYDAMAGELABEL = "Sacr\195\169:";
			CMON_FIREDAMAGELABEL = "Feu:";
			CMON_NATUREDAMAGELABEL = "Nature:";
			CMON_FROSTDAMAGELABEL = "Givre:";
			CMON_SHADOWDAMAGELABEL = "Ombre:";
			CMON_ARCANEDAMAGELABEL = "Arcane:";
			CMON_SPELLRESISTSLABEL = "R\195\169sistances compl\195\168tes:";
			CMON_TOTALDAMAGELABEL = "D\195\169g\195\162ts totaux:";
			CMON_TAKENEKEY = "Re\195\167us";
			CMON_RESISTEDKEY = "R\195\169sist\195\169s";
			CMON_HITSKEY = "Touch\195\169s";
			CMON_AVERAGEKEY = "Moyenne";
			CMON_MELEE = "|cff00ff00M\195\170l\195\169e|r";
			CMON_SPELL = "|cff00ff00Sort|r";
			
			---------------------------------------------------------------------------------------------------------------
			-- Chaînes de caractères pour CombatMonitorEvent.lua                                                          -
			-- Input string in CombatMonitorEvent.lua                                                                     -
			---------------------------------------------------------------------------------------------------------------
			
			---------------------------------------------------------------------------------------------------------------
			-- Traitement des dégats physiques                                                                            -
			-- melee damages other than spell                                                                             -
			---------------------------------------------------------------------------------------------------------------
			
			SEARCH_CRUSHING = "(\195\169crase)";
			SEARCH_CRITICAL = "vous inflige un coup critique";
			
			-- Dégâts physiques
			SEARCH_HIT = "(.+) vous inflige (%d+) points de d\195\169g\195\162ts"; 
			
			-- Dégâts physique, d'arcane, d'ombre, de nature, de feu....
			-- Nouvelle chaine par rapport au code anglais
			SEARCH_HIT1 = "(.+) vous touche et vous inflige (%d+) points de d\195\169g\195\162ts";
						
			SEARCH_CRIT = "(.+) vous inflige un coup critique pour (%d+) points de d\195\169g\195\162ts";
			
			SEARCH_BLOCK = "((%d+) bloqu\195\169)";
			SEARCH_RESISTED = "((%d+) r\195\169siste)";
			SEARCH_ABSORB = "((%d+) absorb\195\169)";
			SEARCH_DEFLECT = "(.+) attaque, mais vous d\195\169viez le coup";
			SEARCH_DODGE = "(.+) attaque et vous esquivez";
			
			SEARCH_PARRY = "(.+) attaque, mais vous parez le coup";
			SEARCH_FULL_BLOCK = "(.+) attaque, mais vous bloquez le coup";
			SEARCH_FULL_ABSORB = "(.+) attaque. Vous absorbez tous les d\195\169g\195\162ts";
			SEARCH_MISS = "(.+) vous rate";
			
			---------------------------------------------------------------------------------------------------------------
			-- Traitement des sorts                                                                                       -
			-- Spell treatment                                                                                            -
			---------------------------------------------------------------------------------------------------------------
			
                        -- Sort infligeant des dégats physiques (fracasser armure, revers....) ou autres (feu pour des élémentaires..)

			-- A list of regular expression prefixes that are used with the SEARCH_SPELL, SEARCH_CRIT_SPELL, etc. for 
			-- correctly getting the 
			SPELL_PREFIXES = {
				"(.+ des? [a-z].+) de (.+ des? .+)",
				"(.+ des? [a-z].+) de (.+)",
				"(.+) de (.+ des? .+)",
				"(.+) de (.+)",
			}
			
			-- SEARCH_SPELL = "(.+) de (.+) vous inflige (%d+) points de d\195\169g\195\162ts";
			SEARCH_SPELL = " vous inflige (%d+) points de d\195\169g\195\162ts"

			-- SEARCH_CRIT_SPELL = "(.+) de (.+) vous inflige un coup critique pour (%d+) points de d\195\169g\195\162ts";
			SEARCH_CRIT_SPELL = " vous inflige un coup critique pour (%d+) points de d\195\169g\195\162ts"

			-- Nouvelle chaine par rapport à la version anglaise
			SEARCH_SPELL1 = "(.+) lance (.+) et vous inflige (%d+) points de d\195\169g\195\162ts"; 
			
			-- SEARCH_SPELL_MISS = "(.+) de (.+) vous rate";
			SEARCH_SPELL_MISS = " vous rate";
			
			SEARCH_SPELL_RESIST = "(.+) utilise (.+), mais cela n'a aucun effet";
			SEARCH_SPELL_DODGE = "(.+) utilise (.+), mais son adversaire esquive";
			-- SEARCH_SPELL_PARRY = "(.+) de (.+) : par\195\169";
			SEARCH_SPELL_PARRY = " : par\195\169";
			SEARCH_SPELL_FULL_BLOCK = "(.+) utilise (.+), mais son adversaire bloque";
			
			
			---------------------------------------------------------------------------------------------------------------
			-- Traitement des dots recus                                                                                  -
			-- Dot treatment                                                                                              -
			---------------------------------------------------------------------------------------------------------------
			-- SEARCH_PERIODIC = "(.+) de (.+) vous inflige (%d+) points de d\195\169g\195\162ts |2 (.+)";
			SEARCH_PERIODIC = " vous inflige (%d+) points de d\195\169g\195\162ts |2 (.+)%.";
			-- SEARCH_TYPE_DAMAGE = "(.+) de (.+) vous inflige (%d+) points de d\195\169g\195\162ts"; 
			SEARCH_TYPE_DAMAGE = " vous inflige (%d+) points de d\195\169g\195\162ts"; 
			
				
			---------------------------------------------------------------------------------------------------------------
			-- Type de dégats                                                                                             -
			-- Damage type                                                                                                -
			---------------------------------------------------------------------------------------------------------------
			-- Patch 1.10 "de" est changé en "|2". C'est bizarre je vérifierais à la prochaine MAJ
			-- I'll check in the next update if such an oddity remains
			
			SEARCH_TYPE_ARCANE = "d\195\169g\195\162ts |2 Arcane";
			SEARCH_TYPE_FIRE = "d\195\169g\195\162ts |2 Feu";
			SEARCH_TYPE_FROST = "d\195\169g\195\162ts |2 Givre";
			SEARCH_TYPE_HOLY = "d\195\169g\195\162ts |2 Sacr\195\169";
			SEARCH_TYPE_NATURE = "d\195\169g\195\162ts |2 Nature";
			SEARCH_TYPE_SHADOW = "d\195\169g\195\162ts |2 Ombre";
			
			SEARCH_TYPE_SHORT_ARCANE = "arcane";
			SEARCH_TYPE_SHORT_FIRE = "feu";
			SEARCH_TYPE_SHORT_FROST = "givre";
			SEARCH_TYPE_SHORT_HOLY = "sacr\195\169";
			SEARCH_TYPE_SHORT_NATURE = "nature";
			SEARCH_TYPE_SHORT_SHADOW = "ombre";

			---------------------------------------------------------------------------------------------------------------
			-- Dégats dûs à l'environnement                                                                               -                                         -
			-- Environmental damages                                                                                      -
			---------------------------------------------------------------------------------------------------------------
			-- Les traductions des chaines suivantes se trouvent dans le fichier interface.mpq FrameXml\Globalstring.lua
			-- Changement de traduction avec le patch 1.10
			
			-- VSENVIRONMENTALDAMAGE_DROWNING_SELF 
			-- VSENVIRONMENTALDAMAGE_FALLING_SELF 
			-- VSENVIRONMENTALDAMAGE_FATIGUE_SELF 
			-- VSENVIRONMENTALDAMAGE_FIRE_SELF 
			-- VSENVIRONMENTALDAMAGE_LAVA_SELF 
			-- VSENVIRONMENTALDAMAGE_SLIME_SELF 
			
			ENVIRONMENTAL_DROWNING = "Vous vous noyez et perdez (%d+) points de vie.";
			ENVIRONMENTAL_FALLING = "Vous faites une chute et perdez (%d+) points de vie.";
			ENVIRONMENTAL_FATIGUE = "Vous \195\170tes \195\169puis\195\169 et perdez (%d+) points de vie.";
			ENVIRONMENTAL_FIRE = "Vous perdez (%d+) points de vie \195\160 cause du feu.";
			ENVIRONMENTAL_LAVA = "Vous perdez (%d+) points de vie en vous br\195\187lant dans la lave.";
	                ENVIRONMENTAL_SLIME  = "Vous perdez (%d+) points de vie en nageant dans la vase.";
	                
                        ---------------------------------------------------------------------------------------------------------------
			-- Chaines de charactères non utilisés dans CombatMonitorEvent donc pas de traduction                         -
			-- Not used in CombatMonitorEvent or used but not in a function, thus no translation for the time being       -
			---------------------------------------------------------------------------------------------------------------
			SEARCH_DAMAGESHIELD = "(.+) vous renvoie (%d+) points de d\195\169g\195\162ts de (.+)";
			SEARCH_SPELL_AFFLICTED = "You are afflicted by (.+)";
			SEARCH_SPELL_PERFORM = "(.+) performs (.+) on you";
			SEARCH_SELF_TYPE_DAMAGE = "You suffer (%d+) (.+) damage from your (.+)";
			SEARCH_IMMUNE = "(.+) attacks but you are immune";
			SEARCH_SELF_PERIODIC_ABSORB = "You suffer (%d+) (.+) damage from your (.+) ((%d+) absorbed)";
			SEARCH_PERIODIC_ABSORB = "You suffer (%d+) (.+) damage from (.+)'s (.+) ((%d+) absorbed)";
			SEARCH_SELF_SPELL = "Your (.+) hits you for (%d+)";
			SEARCH_SELF_CRIT_SPELL = "Your (.+) crits you for (%d+)";
			SEARCH_SELF_SPELL_ABSORB = "Your (.+) hits you for (%d+) ((%d+) absorbed)";
			SEARCH_SPELL_DEFLECT = "(.+)'s (.+) was deflected";
			SEARCH_SPELL_REFLECT = "You reflect (.+)'s (.+)";
			SEARCH_SPELL_FULL_ABSORB = "You absorb (.+)'s (.+)";
			SEARCH_SPELL_DRAIN = "(.+) drains (%d+) (.+) from you";
			SEARCH_SPELL_DRAIN_BUFF = "(.+) drains (%d+) (.+) from you and gains (.+)";

			SEARCH_STRIKE = "frappe"
			SEARCH_CLEAVE = "encha\195\174nement"
end
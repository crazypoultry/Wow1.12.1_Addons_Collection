if ( GetLocale() == "deDE" ) then

--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
-- Read "How to Customize.txt" to learn how to use this file.
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
-- ä = \195\164 (z.B. Jäger = J\195\164ger)
-- Ä = \195\132 (z.B. Ärger = \195\132rger)
-- ö = \195\182 (z.B. schön = sch\195\182n)
-- Ö = \195\150 (z.B. Ödipus = \195\150dipus)
-- ü = \195\188 (z.B. Rüstung = R\195\188stung)
-- Ü = \195\156 (z.B. Übung = \195\156bung)
-- ß = \195\159 (z.B. Straße = Stra\195\159e)
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
-- Read "How to Customize.txt" to learn how to use this file.
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--

--=====================================================================--
-- When you ENTER COMBAT (when the crossed swords cover your level #)
--=====================================================================--
RPWORDLIST.entercombat.UNDEAD = {"Meine Ehre gebietet es mir, euch vom Antliz dieser Welt zu tilgen!", "Ich befreie euch von der Last des lebens!", "Euer tot ist gewiss!", "Ich werde euch im tot willkommen hei\195\159en!", "Wenn ich euch erledigt habe, werde ich euer Gehirn fressen!", "Hei\195\159t den Tod wilkommen!", "Es ist Zeit den Tod zu verbreiten!", "Ich habe Hunger, also auf in den Kampf!", "Es ist Zeit euch in der Familie der Untoten willkommen zu heissen!", "Den Tod kann keiner besiegen!", "Ich liebe den Geruch des Todes... und ihr habt ihn an euch!", "Ich bin schon tot und nun werdet ihr sterben!", "Nicht mal der Tod kann mich besiegen... da seid ihr nur ein Kinderspiel!", }
RPWORDLIST.entercombat.UNDEAD.emote = {}                  
RPWORDLIST.entercombat.UNDEAD.customemote = {}
RPWORDLIST.entercombat.UNDEAD.random = {}
--=====================================================================--
-- When you LEAVE COMBAT (when the crossed swords leave your level #)
--=====================================================================--
RPWORDLIST.leavecombat.UNDEAD = {"Kluge Leute lernen auch von ihren Feinden! Ich hoffe ihr habt eure Lektion gelernt.", "Erfahrung ist eine n\195\188tzliche Sache... leider machen einige sie zu sp\195\164t.", "Man soll keine Dummheit zweimal begehen, die Auswahl ist schlie\195\159lich gro\195\159 genug!", "Und wieder ein Familienneuzugang.", "Wilkommen in der Familie der Untoten.", "Na wie f\195\188hlt man sich wenn man tot ist?", "Tot f\195\188hlt man sich besser oder?", "Wieder einer tot. Nun ist es Zeit seinen Hunger zu stillen.", }
RPWORDLIST.leavecombat.UNDEAD.emote = {}
RPWORDLIST.leavecombat.UNDEAD.customemote = {}
RPWORDLIST.leavecombat.UNDEAD.random = {}
--=====================================================================--
--  HURT: when you get HIT & you have LESS HEALTH than the last time you got hit
--=====================================================================--
RPWORDLIST.hurt.UNDEAD = {"RINSULT", "Kein Untoter f\195\188rchtet den Tod! Warum auch?", 
  "Dieser K\195\182rper ist schon lange nicht mehr am leben! ALso weshalb versucht ihr ihn weiter zu verletzen?",
  "Totem Fleisch kann man nichts mehr anhaben! Versucht es ruhig weiter...",
  "Wisst ihr was es f\195\188r eine Arbeit ist die L\195\182cher in diesem K\195\182rper wieder zu stopfen?",
  "Versucht es ruhig weiter. Irgendwann werdet ihr noch merken das ich schon lange tot bin.",
  "Wenn ich noch am Leben w\195\164re, dann h\195\164tte ich nun das Zeitliche gesegnet.",
  "Es ist so belustigend zu sehen wie sich baldige Neuzug\195\164nge der Familie der Untoten wehren!",
  "Diesem K\195\182rper kann man nichts mehr anhaben... euren hingegen schon!.",
  "Aua das tat weh! Hmmm, eigentlich nicht aber wenn ich noch am Leben gewesen w\195\164re, dann h\195\164tte es wehgetan!",
  "Naja... ich sch\195\164tze das kann ich wieder zusammenn\195\164hen...",
  "Und wenn schon, das war nur ein Finger... den stecke ich sp\195\164ter wieder an.",
  "Wisst ihr... verlorene Lebensenergie hole ich mir von frischen Leichen zur\195\188ck. Ihr seht \195\188brigens sehr appetitlich aus!",
  "Tja ich bin schon lange nicht mehr lebendig... also spare ich mir irgendwelche peinlichen Schmerzensschreie.",
  "Ich finde es peinlich das ihr versucht die W\195\188rmer in meinem K\195\182rper zu qu\195\164len!",
  "Findet ihr es nicht absurd gegen eine Leiche zu k\195\164mpfen? Also h\195\182rt auf damit, sonst muss ich eventuelle fehlende Glieder mit euren ersetzen!",
  "Schnipp schnapp wieder ein Finger ab! Naja, bei Toten wachsen sie ja wieder nach.",
  "Hihihi, das kitzelt!",
  "Niemand f\195\188gt Untoten ungestraft schaden zu!",
  "Keiner verletzt Untote ungestraft!",
  "Ist Leichen sch\195\164nden euer Hobby oder weshalb versucht ihr meinen K\195\182rper zu zerst\195\182ren?",
  "Ich denke ihr solltet aufgeben! Dann haben wir es beide hinter uns.",
  "Und wieder ein erb\195\164rmlicher versuch eine Leiche davon zu \195\188berzeugen ins Grab zur\195\188ckzukehren!",
  "Glaubt ihr wirklich, dass ich Angst vor dem Tode habe?",
  "Ich denke ich kann diesen kleinen Kratzer locker verkraften!",
  "Ich habe keine Angst! Die Dunkelheit wird mich besch\195\188tzen!",
  "Ich f\195\188rchte mich nicht, denn ich bin schon vor sehr langer Zeit gestorben!", }
RPWORDLIST.hurt.UNDEAD.emote = {}       
RPWORDLIST.hurt.UNDEAD.customemote = {}
RPWORDLIST.hurt.UNDEAD.random = {}       
--=====================================================================--
-- ABSORB: Creature or hostile player attacks but you absorb the damage.
-- For example: when a priest shields you.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.absorb.UNDEAD = {"Der Versuch eine Leiche umzubringen ist in etwa so erfolgsversprechend wie eine Steinmauer niederzubr\195\188llen.", "Der Tot hat mich unverwundbar gemacht... gebt auf!", "Ich sch\195\164tze das war wohl nichts!", "Versucht es n\195\164chstesmal mit Weihwasser!", "Weder kalter Stahl noch irgendwelcher Hokuspokus kann mir noch etwas anhaben!", }
RPWORDLIST.absorb.UNDEAD.emote = {}
RPWORDLIST.absorb.UNDEAD.customemote = {}
RPWORDLIST.absorb.UNDEAD.random = {}
--=====================================================================--
-- BLOCK: Creature or hostile player attacks. You block.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.block.UNDEAD = {"Knochen sind stabiler als jedes Schild!", "Ich blocke jede Attacke! Es ist hoffnungslos f\195\188er euch!", }
RPWORDLIST.block.UNDEAD.emote = {} 
RPWORDLIST.block.UNDEAD.customemote = {}
RPWORDLIST.block.UNDEAD.random = {}
--=====================================================================--
-- DODGE: Creature or hostile player attacks. You dodge.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.dodge.UNDEAD = {"Selbst Zombies sind zu schnell f\195\188r euch! Gebt auf!", "Har Har... ihr werdet mich niemals erwischen.", }
RPWORDLIST.dodge.UNDEAD.emote = {}
RPWORDLIST.dodge.UNDEAD.customemote = {}
RPWORDLIST.dodge.UNDEAD.random = {}
--=====================================================================--
-- MISS: Creature or hostile player attacks but misses you.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.miss.UNDEAD = {"Glaubt mir... sterben wird f\195\188r euch einfacher sein als mich zu erwischen!", }
RPWORDLIST.miss.UNDEAD.emote = {} 
RPWORDLIST.miss.UNDEAD.customemote = {}
RPWORDLIST.miss.UNDEAD.random = {}
--=====================================================================--
-- PARRY: Creature or hostile player attacks. You parry.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.parry.UNDEAD = {"War das alles was ihr k\195\182nnt?", "Tja getroffen... aber da ich tot bin macht mir das nichts aus. Wollt ihr es nochmal versuchen?", "Meine Verteidigung ist un\195\188berwindlich f\195\188r euch.", }
RPWORDLIST.parry.UNDEAD.emote = {}
RPWORDLIST.parry.UNDEAD.customemote = {}
RPWORDLIST.parry.UNDEAD.random = {}
--=====================================================================--
-- CRIT: You crit damage with a physical attack
--=====================================================================--
RPWORDLIST.youcrit.UNDEAD = {"Bald werdet ihr die Armee der Untoten beitreten!", "Es ist doch langweilig am Leben zu sein, also gebt auf!", "Untersch\195\164tzt niemals die St\195\164rke von toten!", }
RPWORDLIST.youcrit.UNDEAD.emote = {}
RPWORDLIST.youcrit.UNDEAD.customemote = {}
RPWORDLIST.youcrit.UNDEAD.random = {}
--=====================================================================--
-- CRIT (SPELL): You crit damage with a spell attack
--=====================================================================--
RPWORDLIST.youcritspell.UNDEAD = {"Nicht mehr lange und ihr werdet die Legionen der Untoten unterst\195\188zen!", "Sp\195\188rt ihr die Macht des Todes?", "Sp\195\188rt ihr wie euch das Leben verl\195\164sst?", }
RPWORDLIST.youcritspell.UNDEAD.emote = {}
RPWORDLIST.youcritspell.UNDEAD.customemote = {}
RPWORDLIST.youcritspell.UNDEAD.random = {}
---=====================================================================--
-- HEAL: You heal someone else
--=====================================================================--
RPWORDLIST.youheal.UNDEAD = {}
RPWORDLIST.youheal.UNDEAD.emote = {}
RPWORDLIST.youheal.UNDEAD.customemote = {}
RPWORDLIST.youheal.UNDEAD.random = {}
--=====================================================================--
-- CRIT HEAL: You critically heal someone else
--=====================================================================--
RPWORDLIST.youcritheal.UNDEAD = {}
RPWORDLIST.youcritheal.UNDEAD.emote = {}
RPWORDLIST.youcritheal.UNDEAD.customemote = {}
RPWORDLIST.youcritheal.UNDEAD.random = {}
--=====================================================================--
-- When your PET STARTS ATTACKING.
	-- PNAME = Pet's Name	
	-- PTNAME = Pet's target's name                           
	-- PTSP = Pet's target's subject pronoun 	(He/She/It)
	-- PTOP = Pet's target's object pronoun 	(him/her/it)
	-- PTPP = Pet's target's possessive pronoun (his/her/its)
--=====================================================================--
RPWORDLIST.petattackstart.UNDEAD = {"Los PNAME! Ich habe Hunger!", "Macht endlich PNAME! Die Reihen der Untoten brauchen zuwachs!", }
RPWORDLIST.petattackstart.UNDEAD.emote = {}
RPWORDLIST.petattackstart.UNDEAD.customemote = {}
RPWORDLIST.petattackstart.UNDEAD.random = {}
--=====================================================================--
-- When your PET STOPS ATTACKING.
	-- PNAME = Pet's Name
		-- Your pet no longer has a target.
--=====================================================================--
RPWORDLIST.petattackstop.UNDEAD = {}
RPWORDLIST.petattackstop.UNDEAD.emote = {} 
RPWORDLIST.petattackstop.UNDEAD.customemote = {}
RPWORDLIST.petattackstop.UNDEAD.random = {}
--=====================================================================--
-- When your PET DIES.
	-- PNAME = Pet's Name
--=====================================================================--
RPWORDLIST.petdies.UNDEAD = {"Keine Angst, PNAME. Tot sein ist eine Verbesserung.", "PNAME. Willkommen in den reihen der Untoten.", }
RPWORDLIST.petdies.UNDEAD.emote = {}                                        
RPWORDLIST.petdies.UNDEAD.customemote = {}
RPWORDLIST.petdies.UNDEAD.random = {}
--=====================================================================--
--  Friendly NPC talks
	-- Usage                                    Example
	-- -----                                    -------
	-- TEXT = The text message sent by the NPC.	TEXT = Now to find an unsuspecting Harpy!
	-- NPC 	= The NPC saying it.        		NPC  = Mogg
	-- LANG = The Language              		LANG = Orcish
--=====================================================================--
RPWORDLIST.npctalksfriend.UNDEAD = {
	"Ruhig, NPC. Last mich in frieden umherwandeln.",
	"Du musst lauter sprechen NPC.  Meine Ohren sind leider verrotet.",
	"Bitte wiederhole es NPC. Ich hatte gerade eine Made im Ohr.", }
RPWORDLIST.npctalksfriend.UNDEAD.emote = {}
RPWORDLIST.npctalksfriend.UNDEAD.customemote = {}
RPWORDLIST.npctalksfriend.UNDEAD.random = {}
--=====================================================================--
--  Enemy NPC talks
	-- Usage                                    Example
	-- -----                                    -------
	-- TEXT = The text message sent by the NPC.	TEXT = Now to find an unsuspecting Harpy!
	-- NPC 	= The NPC saying it.        		NPC  = Mogg
	-- LANG = The Language              		LANG = Orcish
--=====================================================================--
RPWORDLIST.npctalksenemy.UNDEAD = {
	"Halt die Klappe, NPC.",
	"Wenn ihr wisst was gut f\195\188r euch ist seit ihr nun ruhig, NPC.",
	"Mal sehen wie Gespr\195\164chig du nach dem entfernen deiner Zunge bist.",
	"Ruhe! Meine Ohren faulen schon ab NPC! RINSULT",
	"Klappe! RINSULT",
	"TEXT Haha!", }
RPWORDLIST.npctalksenemy.UNDEAD.emote = {}
RPWORDLIST.npctalksenemy.UNDEAD.customemote = {}
RPWORDLIST.npctalksenemy.UNDEAD.random = {}
--=====================================================================--
--  RESURRECT:  When you resurrect
	-- If you are dead when the UI (User Interface) loads, you will not RP.
--=====================================================================--
RPWORDLIST.resurrect.UNDEAD = {"Wieder mal am leben!.... naja mehr oder weniger...",
	"Nichts ist so dauerhaft wie der Tod!",
	"Nicht mal der Tod kann mich aufhalten!",
	"H\195\182rt das denn nie auf? Wann begreifen die das man Untote nicht umbringen kann? Wir kommen immer wieder!",
	"Ich bin Untot! Keine Verletzung kann mich dauerhaft au\195\159er Gefecht setzen!",
	"Ha! Man wollte den Tod aufhalten... aber ich komme immer wieder!",
	"Ich bin wieder am Leben!... naja nicht das erste mal Heute.",
	"Niemand wird mich ewig aufhalten k\195\182nnen. Der Tod hat sehr viel Zeit!",
	"Har Har... Das B\195\182se weilt nun wieder unter den Lebenden!",
	"Nun zeige ich anderen wie es ist Untot zu sein. Harr Harr Harr!",
	"Erfahrung ist eine n\195\188tzliche Sache... leider macht man sie immer erst kurz nachdem man sie braucht.",
	"Zeit jemand anderen in der Familie der Untoten willkommen zu heisen....kommt nur her Allianzler",
	"Gerade haben die W\195\188rmer noch mit mir gespielt und nun spiele ich mit den W\195\188rmern....kommt nur her...",
	"Ich bin kein lebender und ich geh\195\182re euch nicht in diese Welt. Lasst mich endlich ruhen!",
	"Ich bin schon ein paar mal gestorben. Da pflegt man nicht zu \195\188berleben! ",
	"Kommt zu den Untoten haben sie gesagt.... sterbt nie mehr haben sie gesagt... GRML!",
	"Man sah das ich b\195\182se war, nun bin ich wieder da!", }
RPWORDLIST.resurrect.UNDEAD.emote = {} 
RPWORDLIST.resurrect.UNDEAD.customemote = {}
RPWORDLIST.resurrect.UNDEAD.random = {}

end
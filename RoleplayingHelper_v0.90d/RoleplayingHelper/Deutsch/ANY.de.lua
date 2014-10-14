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
--=====================================================================--
-- When you ENTER COMBAT (when the crossed swords cover your level #)
--=====================================================================--
RPWORDLIST.entercombat.ANY = {"Ich werde unsere Feinde hinwegfegen!", "Eure Zeit ist gekommen!", "Eure Zeit ist abgelaufen!", "Macht euch bereit zu sterben!", "Na, dann in den Kampf!", "Sterbt!", "Das ist euer Ende!", "Zeit zu sterben!", "Auf in den Kampf!", "Keine Gnade!", "Sp\195\188rt meine Waffen",}
RPWORDLIST.entercombat.ANY.emote = {"CHARGE","ROAR","ANGRY","ANSTARREN","CRACK","GEMEIN","WICKED","WICKEDLY",}
RPWORDLIST.entercombat.ANY.customemote = {"versucht seine Feinde niederzumetzeln!",}
RPWORDLIST.entercombat.ANY.random = {}
--=====================================================================--
-- When you LEAVE COMBAT (when the crossed swords leave your level #)
--=====================================================================--
RPWORDLIST.leavecombat.ANY = {
"Mit mir h\195\164ttet ihr euch nicht anlegen sollen!",
"Hehe, das wars dann f\195\188r euch!",
"So, wer war nun der St\195\164rkere?",
"Und einer weniger...",
"Und ich dachte ihr seid eine Bedrohung...",
"Ich habe auch schon gegen echte Gegner gek\195\164mpft.",
"Das wars dann...",
"Keiner wird mich besiegen...",
"Ich wusste das ihr kein echter Gegner wart.",
"Das war schon alles?",
"Wo war jetzt die Herausforderung?",
"Was, schon am Ende?",
"Welch ein tragischer Irrtum, f\195\188r eine Sache zu sterben, anstatt f\195\188r sie zu leben...",
"Ich habe mehr von euch erwartet.",
"Das war schon alles?",
}
RPWORDLIST.leavecombat.ANY.emote = {"GLOAT","SIEG","CHEER",}
RPWORDLIST.leavecombat.ANY.customemote = {}
RPWORDLIST.leavecombat.ANY.random = {}
--=====================================================================--
--  HURT: when you get HIT & you have LESS HEALTH than the last time you got hit
--=====================================================================--
RPWORDLIST.hurt.ANY = {"RINSULT",
  "Ihr habt Mundgeruch, ihr solltet mich anhauchen statt zu k\195\164mpfen!", 
  "Wie langweilig!",
  "Wie l\195\164cherlich!",
  "Mehr habt ihr nicht drauf?",
  "Das hat auch schon fast wehgetan",
  "Das ist alles?",
  "Ha ha! Ihr wirkt so l\195\164cherlich wenn ihr versucht zu k\195\164mpfen!",
  "Ich suche eine Herausforderung und kein Opfer.",
  "Ihr seid wirklich kein ernsthafter Gegner.",
  "Wie? Das ist alles?",
  "Meine G\195\188te. Ich k\195\164mpfe ja mit einem Anf\195\164ger.",
  "Na los, k\195\164mpft doch mal!",
  "He, seid ihr m\195\188de oder warum seid ihr so langsam?",
  "Das wird nichts mehr mit Euch!",
  "Ok, ihr hattet eure Chance und nun werdet ihr sterben!",
  "Zeigt mir endlich was ihr k\195\182nnt!",
  "G\195\164hn",
  "Das ist nur eine Fleischwunde!",
  "Ich sollte euch mal einen Vorsprung gew\195\164hren!",
  "Haha! Man k\195\182nnte meinen ihr seid auf einem Picknick!",
  "Nun k\195\164mpft doch auch einmal!",
  "Argh! Lasst das!",
  "Au! Das tat ja weh!",
  "Das ist nur ein Kratzer!",
  "Ich hatte schon schlimmere Wunden.",
  "Ich glaube das wird eine Narbe hinterlassen.",
}
RPWORDLIST.hurt.ANY.emote = {"GLARE","INSULT","MOON","ROAR","SIEG","TAUNT","WACKELN","WICKED",}
RPWORDLIST.hurt.ANY.customemote = {}
RPWORDLIST.hurt.ANY.random = {}
--=====================================================================--
-- ABSORB: Creature or hostile player attacks but you absorb the damage.
-- For example: when a priest shields you.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.absorb.ANY = {
	"Das gab nicht mal einen Kratzer!",
	"Ihr k\195\164mpft wie meine Gro\195\159mutter!",
	"Ha! Komplett absorbiert!",
	"Meine Wunden heilen schneller als ihr mir Schaden zuf\195\188gen k\195\182nnt!",
	"Ha! Ich wiederstehe all euren Attacken!",
	"Ihr seid zu schwach um mir irgendetwas anzuhaben!",
	"Habt ihr getroffen? Ich merke nichts!",
	"Ich habe schon Wesen gegen\195\188bergestanden, die Ihr Euch nicht einmal vorstellen k\195\182nnt! Ich glaube nicht, da\195\159 Ihr die Ehre verdient, mit mir zu k\195\164mpfen!",
	"L\195\164cherlich! Ihr m\195\188sst schon heftiger angreifen wenn ihr mich beindrucken wollt.",
	"War es das? Ich habe nicht mal etwas gesp\195\188rt!",
	"Oh, das wahr wie der Stich einer M\195\188cke, haha!",
	"Das halte ich aus, da m\195\188sst Ihr mehr aufbieten!",
	"Habt ihr nicht mehr drauf?",
	"L\195\164cherlich!",
	}
RPWORDLIST.absorb.ANY.emote = {"BLEED","ANSTARREN","CALM","DROHEN","SPIT",}
RPWORDLIST.absorb.ANY.customemote = {}
RPWORDLIST.absorb.ANY.random = {}
--=====================================================================--
-- BLOCK: Creature or hostile player attacks. You block.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.block.ANY = {
	"Ha! Geblockt",
	"Sch\195\182nes Schutzschild, nicht wahr?",
	"Wie schmeckt mein Schild?",
	"Mein Schild wird alle von euren l\195\164cherlichen Angriffen blocken.",
	"Haha! Meine Verteidigung ist st\195\164rker als euer l\195\164cherlicher Angriff!",	
	"Ein Angriff ist zwecklos!",
	"Und geblockt!",
	"K\195\164mpft ihr mit meinem Schild oder mit mir?",
        "Mein Schild ist wirklich Gold wert!",
  	"Versucht ihr immernoch mein Schild zu treffen?",
  	}
RPWORDLIST.block.ANY.emote = {}
RPWORDLIST.block.ANY.customemote = {}
RPWORDLIST.block.ANY.random = {}
--=====================================================================--
-- DODGE: Creature or hostile player attacks. You dodge.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.dodge.ANY = {
	"Ich bin schneller als Ihr!",
	"Haha! Ausgewichen!",
	"Ich bin einfach zu schnell f\195\188r euch...gebt auf solange ihr noch k\195\182nnt!",
	"Treffen ist nicht eure St\195\164rke was?",
	"Wo haut ihr denn hin? Hier stehe ich!",
	"Treffen m\195\188sst ihr schon!",
	"Ein Kinderspiel!",
	"Keine Chance! Ihr werdet mich niemals erwischen!",
	"Ich bin sehr gut im Ausweichen. Ihr m\195\188sst schon schneller sein!",
	"Bin ich zu schnell f\195\188r euch?",
	"Wollt ihr es nochmal Versuchen?",
	"Ha! Das schafft ihr nie!",
	}
RPWORDLIST.dodge.ANY.emote = {"SPIT",}
RPWORDLIST.dodge.ANY.customemote = {}
RPWORDLIST.dodge.ANY.random = {}
--=====================================================================--
-- MISS: Creature or hostile player attacks but misses you.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.miss.ANY = {
	"Haha! Ihr habt verfehlt!",
	"Treffen will gelernt sein!",
	"Selbst ein Blinder trifft besser als ihr!",
	"Knapp daneben!",
	"Na? Fehlt noch ein bischen \195\156bung oder ?",
	"Ha! Daneben.",
	"Wo schlagt ihr hin? Hier bin ich!.",
	"Wenn ihr angreift, dann solltet ihr wenigstens auch treffen!",
	"Hier, Hier bin ich!",
	"Mit wem k\195\164mpft ihr eigentlich?",
  "Sch\195\182n, voll daneben!",
  "Daneben",
  "Voll vorbei!",
  "Tztz, was macht Ihr da eigentlich?",
	}
RPWORDLIST.miss.ANY.emote = {"LAUGH","SPIT",}
RPWORDLIST.miss.ANY.customemote = {}
RPWORDLIST.miss.ANY.random = {}
--=====================================================================--
-- PARRY: Creature or hostile player attacks. You parry.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.parry.ANY = {
	"Haha! Pariert, zu einfach!",
	"Na, wie war das?",
	"Seid ihr zu schwach bin ich zu stark. Gebt auf!",
	"Das war knapp!",
	"Das ist schon fast zu einfach!",
	"Mehr habt ihr nicht zu bieten?",
	"Ha! Ihr k\195\182nnt es sicher besser!",
	"K\195\164mpft ihr mit mir oder mit euch selbst?",
	"Treffen! Ihr m\195\188sst treffen!",
	"Na wie war das? RINSULT",
	"Wieder einmal Pariert... zu einfach!",
	}
RPWORDLIST.parry.ANY.emote = {"LAUGH","SPIT",}
RPWORDLIST.parry.ANY.customemote = {}
RPWORDLIST.parry.ANY.random = {}
--=====================================================================--
-- CRIT: You crit damage with a physical attack
--=====================================================================--
RPWORDLIST.youcrit.ANY = {"Das muss wehgetan haben.", "Na, wie war das?", "Na, tat das weh?", "Ich werde euren treiben ein Ende bereiten! RINSULT",}
RPWORDLIST.youcrit.ANY.emote = {"WICKED","WICKEDLY",}
RPWORDLIST.youcrit.ANY.customemote = {"erfreut sich an der tiefen Wunde seines Feindes.",}
RPWORDLIST.youcrit.ANY.random = {}
--=====================================================================--
-- CRIT (SPELL): You crit damage with a spell attack
--=====================================================================--
RPWORDLIST.youcritspell.ANY = {"W\195\182rter sind m\195\164chtiger als Klingen!.", "Ich sp\195\188re wie die Macht in mir erstarkt!.", "Dies war ein sehr m\195\164chtiger Zauber!.", }
RPWORDLIST.youcritspell.ANY.emote = {"WICKED","WICKEDLY",}
RPWORDLIST.youcritspell.ANY.customemote = {}
RPWORDLIST.youcritspell.ANY.random = {}
--=====================================================================--
-- HEAL: You heal someone else
--=====================================================================--
RPWORDLIST.youheal.ANY = {}
RPWORDLIST.youheal.ANY.emote = {}
RPWORDLIST.youheal.ANY.customemote = {"versorgt die Wunden seiner Kameraden.",}
RPWORDLIST.youheal.ANY.random = {}
--=====================================================================--
-- CRIT HEAL: You critically heal someone else
--=====================================================================--
RPWORDLIST.youcritheal.ANY = {}
RPWORDLIST.youcritheal.ANY.emote = {}
RPWORDLIST.youcritheal.ANY.customemote = {"versorgt eine klaffende Wunde.", "hat wieder einmal ein Leben gerettet.",}
RPWORDLIST.youcritheal.ANY.random = {}
--=====================================================================--
-- When your PET STARTS ATTACKING.
	-- PNAME = Pet's Name	
	-- PTNAME = Pet's target's name                           
	-- PTSP = Pet's target's subject pronoun 	(Er/Sie/Es)
	-- PTOP = Pet's target's object pronoun 	(ihn/sie/es)
	-- PTPP = Pet's target's personal pronoun 	(ihm/ihr/dem Ding)
--=====================================================================--
RPWORDLIST.petattackstart.ANY = {
	"Los PNAME!",	
	"PNAME du weist was zu tun ist!",	
	"Los PNAME! Zeige PTPP was wahre Schmerzen sind.",
	"Los schnapp PTOP dir, PNAME!", 
	"Mach PTOP fertig, PNAME.",
	"T\195\182te PTOP, PNAME! T\195\182te PTOP f\195\188r mich!",
	"Greif PTOP an, PNAME.",
	"Vernichte PTOP f\195\188r mich, PNAME.",
	"Verst\195\188mmle PTOP, PNAME. Verst\195\188mmle PTOP zu tode!",
	"Keine Gnade, PNAME.",
	"Verschone PTOP nicht, PNAME.",
	"Hilf mir mal, PNAME",
	"PTSP muss sterben, PNAME.",
	"PTSP ist uns im Weg, PNAME.",
	"PNAME! Zeige PTPP das wir uns vor niemanden f\195\188rchten.",
	"PNAME! Zeige PTPP wie schnell man sterben kann.",
	"PNAME! Mach PTOP fertig.",
	"PNAME! Schnapp PTOP dir.",
	"PNAME! T\195\182te PTOP.",
	"PNAME! Los hol PTOP dir.",
	"PTSP soll nun zur H\195\182lle fahren! PNAME.",
	"PTSP hat lange genug gelebt, PNAME.",
	"PNAME! Zeige keine Gnade.",
	"PTSP ist kein Gegner f\195\188r PNAME.",
	}
RPWORDLIST.petattackstart.ANY.emote = {}
RPWORDLIST.petattackstart.ANY.customemote = {}
RPWORDLIST.petattackstart.ANY.random = {}
--=====================================================================--
-- When your PET STOPS ATTACKING.
	-- PNAME = Pet's Name
		-- Your pet no longer has a target.
--=====================================================================--
RPWORDLIST.petattackstop.ANY = {
	"Gut gemacht PNAME.",
	"Sehr gut PNAME.",
	"PNAME, das war beindruckend.",
	"Wieder mal gut gemacht PNAME.",
	"Bleib in meiner N\195\164he PNAME.",
	"Wie immer perfekt, PNAME.",
	"Weiter so, PNAME.",
	"Das war sehr gut, PNAME.",
	"Sei n\195\164chstesmal etwas schneller PNAME. Wir haben nicht ewig Zeit.",
	"Hast du Spa\195\159 gehabt PNAME?",
	"PNAME, das hast gut gemacht.",
	}
RPWORDLIST.petattackstop.ANY.emote = {}
RPWORDLIST.petattackstop.ANY.customemote = {}
RPWORDLIST.petattackstop.ANY.random = {}
--=====================================================================--
-- When your PET DIES.
	-- PNAME = Pet's Name
--=====================================================================--
RPWORDLIST.petdies.ANY = {
	"Neeeiiiiiin!",
	"Verdammt.  PNAME hat es erwischt.",
	"PNAME! Oh nein!",
	"PNAME!",
	"Oh nein... nicht PNAME!",
	"Du hast PNAME get\195\182tet! Du Bastard!",
	}
RPWORDLIST.petdies.ANY.emote = {}
RPWORDLIST.petdies.ANY.customemote = {"betrauert den Tot seines treuen Begleiters.",}
RPWORDLIST.petdies.ANY.random = {}
--=====================================================================--
--  Friendly NPC talks
	-- Usage                                    Example
	-- -----                                    -------
	-- TEXT = The text message sent by the NPC.	TEXT = Now to find an unsuspecting Harpy!
	-- NPC 	= The NPC saying it.        		NPC  = Mogg
	-- LANG = The Language              		LANG = Orcish
--=====================================================================--
RPWORDLIST.npctalksfriend.ANY = {"Nun macht schon, tr\195\182delt nicht!", "Ich habe nicht ewig Zeit!", "Macht schneller!", }
RPWORDLIST.npctalksfriend.ANY.emote = {}
RPWORDLIST.npctalksfriend.ANY.customemote = {"lauscht gebannt den Worten.",}
RPWORDLIST.npctalksfriend.ANY.random = {}
--=====================================================================--
--  Enemy NPC talks
	-- Usage                                    Example
	-- -----                                    -------
	-- TEXT = The text message sent by the NPC.	TEXT = Now to find an unsuspecting Harpy!
	-- NPC 	= The NPC saying it.        		NPC  = Mogg
	-- LANG = The Language              		LANG = Orcish
--=====================================================================--
RPWORDLIST.npctalksenemy.ANY = {"Er spricht in R\195\164tseln.", }
RPWORDLIST.npctalksenemy.ANY.emote = {}
RPWORDLIST.npctalksenemy.ANY.customemote = {"versteht kein Wort.",}
RPWORDLIST.npctalksenemy.ANY.random = {}
--=====================================================================--
--  RESURRECT:  When you resurrect
	-- If you are dead when the UI (User Interface) loads, you will not RP.
--=====================================================================--
RPWORDLIST.resurrect.ANY = {
	"Ich lebe!",
	"Ich dachte, ich habe die Situation unter Kontrolle...",
	"Zeit f\195\188r Rache!",
	"Wo bin ich?",
	"Ich bin am leben!",
	"Ein helles Licht! Uh.... doch nicht...",
	"Was war das? Ich lebe wieder!",
	"Was ist passiert! Warum lebe ich wieder?",
	"Na warte...  Ich bin wieder unter den Lebenden!",
	"Zeit, dass jetzt Jemand anderes stirbt!",
	"Hm, wie bin ich hierher gelangt?",
	"Keiner haut mich ungestraft um!",
	"Der Verlust des Lebens ist unersetzlich! Pah, ich bin wieder da!",
	"Tja, wieder mal Alles gegeben und doch gestorben.",
	"Der Beweis von Heldentum liegt nicht im Gewinnen einer Schlacht, sondern im Ertragen einer Niederlage!",
	}
RPWORDLIST.resurrect.ANY.emote = {"VERDATTERT","PRAISE","GAZE","COMFORT","CONFUSED","BLUTEN","AUFSTEHEN",}
RPWORDLIST.resurrect.ANY.customemote = {"schaut sich verwirrt um.",}
RPWORDLIST.resurrect.ANY.random = {}

end

------------------------------------------------------------------------------------------------------
-- Serenity
--
-- Based on Necrosis LdC by Lomig and Nyx (http://necrosis.larmes-cenarius.net)
-- Original Necrosis Idea : Infernal (http://www.revolvus.com/games/interface/necrosis/)
-- Serenity Maintainer : Kaeldra of Aegwynn
--
-- Contact : darklyte@gmail.com
-- Send me in-game mail!  Yersinia on Aegwynn, Horde side.
-- Guild: <Working as Intended>
-- Version Date: 07.14.2006
------------------------------------------------------------------------------------------------------



-- Text for speeches by the mage
--------------------------------------
-- Here are some random speeches for your mage.  You can add more to fit your
-- magey-way-of-thinking a little more!
-- Need some help ? :)
-- Correct syntax is "Blah blah blah" SelectedPlayer "Blah blah blah"
-- If you want to write "In few seconds 'Player's name' will be able to help us"
-- The target's name is replaced by <target>, but CASE SENSITIVE!
-- you need to add before the } :
-- "In few seconds <target> will be able to help us",
-- 
-- The same thing is available for all messages.  If you need any help at all, 
-- Don't hesitate to e-mail me at darklyte@gmail.com :)


-------------------------------------
--  ENGLISH VERSION --
-------------------------------------

function Serenity_Localization_Speech_En()


	SERENITY_RES_MESSAGE = {
		[1] = "Granddaddy always said laughter was the best medicine. I guess it wasn't strong enough to keep <target> alive.",
		[2] = "Okay, <target>, nap time is over! Back to work!",
		[3] = "Ressing <target>, can I get an Amen!",
		[4] = "<target>, your subscription to Life(tm) has expired. Do you wish to renew?",
		[5] = "YAY! I always wanted my very own <target>-zombie!",
		[6] = "It just so happens that <target> is only MOSTLY dead. There's a big difference between mostly dead and all dead. Mostly dead is slightly alive.",
		[7] = "<target> has failed at life, i'm giving him a second chance. That's right, not God, ME!!",
		[8] = "Cool, I received 42 silver, 32 copper from Corpse of <target>",
		[9] = "GAME OVER, <target>. To continue press up, up, down, down, left, right, left, right, B, A, B, A, Select + Start",
		[10] = "<target>, It's more mana efficient just to resurrect you.  Haha, I'm just kidding!",
		[11] = "Well, <target>, if you had higher faction with <player>, you might have gotten a heal.  How do you raise it?  1g donation = 15 rep.",
		[12] = "Okay, <target>.  Stop being dead.",
		[13] = "If you are reading this message, <target> is already dead.",
		[14] = "Don't rush me <target>. You rush a miracle worker, you get rotten miracles.",
		[15] = "Death comes for you <target>! With large, pointy teeth!",
		[16] = "Resurrecting <target>. Side effects may include: nausea, explosive bowels, a craving for brains, and erectile dysfunction. Resurrection is not for everyone. Please consult healer before dying.",
		[17] = "Dammit <target>, I'm a doctor! Not a priest! .... Wait a second.... Nevermind. Ressing <target>",
		[18] = "Dying makes me sad, <target>.",
		[19] = "<target> stop worshipping the ground I walk on and get up." ,
		[20] = "Hey <target>, can you check to see if Elvis is really dead?...and can he fill your spot in the party?",
		[21] = "Giving <target> another chance to noob it up. ",
		[22] = "Dammit, <target>, did you get my PERMISSION before dying?!",
		[23] = "...death defying feats are clearly not your strong point, <target>",
		[24] = "Walk it off, <target>.",
		[25] = "<target>, by accepting this resurrection you hereby accept that you must forfeit your immortal soul to <player>. Please click 'Accept' to continue.",
		[26] = "<target>, this better not be another attempt to get me to give you mouth-to-mouth.",
		[27] = "Arise <target>, and fear death no more; or at least until the next pull.",
		[28] = "Stop slacking, <target>. You can sleep when you're . . . Oh. . . Um, ressing <target>",
		[29] = "We can rebuild <target>, we can make him stronger, faster, but we can't make him any smarter.",
		[30] = "<target> has fallen and can't get up!",
		[31] = "Bring out your dead! *throws <target> on the cart*",
		[32] = "Hey <target>, say hello to Feathers for me, will ya?",
		[33] = "<target>, quit hitting on the Spirit Healer and come kill something!",
		[34] = "<target> I *warned* you, but did you listen to me? Oh, no, you *knew*, didn't you? Oh, it's just a harmless little *bunny*, isn't it?",
		[35] = "<target>, please! This is supposed to be a happy occasion. Let's not bicker and argue over who killed who.",
		[36] = "Today's category on Final Jeopardy: Spells that end in 'esurrection'. <target>, ready?",
		[37] = "There are worse things then death, <target>. Have you ever grouped with... oh, wait. We aren't supposed to mention that in front of you.",
		[38] = "Did you run into some snakes on a plane or something, <target>? 'Cause you're dead.",
		[39] = "Wee-ooo! Wee-ooo! Wee-ooo! Wee-ooo! Wee-ooo! Wee-ooo... that's the best ambulance imperssion I can do, <target>.",
		[40] = "Tsk tsk, <target>. See, I told you to sacrifice that virgin to the Volcano God.",
		[41] = "<target> gets a Mulligan.",
		[42] = "Hey <target>, do you know what you call a physician that was last in his class?  Doctor.",
		[43] = "Eww!  What's that smell!  It smells like something died in here!  Hey, where is <target>?... Oh.",
		[44] = "Unfortunatly, <target>, you have to be at least Revered with Dwarven Female Priests to be rezzed. Sucks to be you.",  
		[45] = "You don't deserve a cute rez macro, <target>. You deserve to die. But you already did, so, um... yeah.",
		[46] = "<target>, you have been weighed, you have been measured, and you have been found wanting.",
		[47] = "Well <target>, you tried your best. And apparently failed miserably. Good job.", 
		[48] = "Did it hurt, <target>, when you fell from Heaven? Oh, wait. You're dead. I don't know where I was going with that. Nevermind.", 
		[49] = "Gah, <target>, dead again? You probably want a rez, don't you? What do you think I am, a prie... oh. Fair enough.",
		[50] = "<target> have you heard of Nethaera?  Yeah, she's really cool.  Why do I bring it up?  No reason.",
	};
	SERENITY_SHACKLE_MESSAGE = {
		[1] = "THE POWER OF "..string.upper(UnitName("player")).." COMPELS YOU!!",
		[2] = "Shackling <target>!  Stay away from the bling!",
		[3] = "I hope you brought the gag <target>, I got the shackles!",
		[4] = "Believe it or not, <target>, I am into bondage.",
		[5] = "Shackling <target>! Drop what you're doing and break it! ",
		[6] = "Shackling <target>. Everytime you break it, I'll kill a kitten.",
		[7] = "Shackling <target>!  You break it, you tank it.",
		[8] = "<target> is my corpse. There are many others like it but this one is mine.",
		[9] = "Shackling <target> because corpses can't say no.",
		[10] = "Go to your cage, <target>!",
		[11] = "All I ever hear from you is 'brains this' and 'brains that', <target>.  No more!",
		[12] = "You fought the law and the law won, <target>.",
		[13] = "<target>, go to jail.  Go directly to jail.  Do not pass go.  Do not collect 200g",
		[14] = "That which was never meant to move, <target>, be still once more!" ,

	};
	SERENITY_STEED_MESSAGE = {
		[1] = "If it wasn't for my <mount>, I wouldn't have spent that year in college.",
		[2] = "The directions said to just add water and... WHOA a <mount>!",
		[3] = "If it wasn't for my <mount>, I'd be walking.",
		[4] = "I'd love to hang around, but my <mount> needs exercise.",
		[5] = "Alright <mount>, I'm ready to ride!",
		[6] = "Fasten your seat belts, it's going to be a bouncy ride.",
		[7] = "Hi-ho <mount>...Away!!!",
		[8] = "You should see my other mount... but it's in the shop getting fixed.",
		[9] = "Shotgun!",
		[10] = "Hm, somethings growing out of my butt!",
		[11] = "Ah, now for some good old fashioned <mount> riding.",
		[12] = "Does this look like a <mount> to you? Oh, I guess it really is. Nevermind.",
		[13] = "Ok, mounting my <mount> now. Wait... that didn't come out right.",
	};
	SERENITY_FREEZE_MESSAGE = {
		[1] = "I enjoy my <target>s on the rocks",
		[2] = "Looks like <target> needs to get a sweater!",
		[3] = "<3 Freezing Band",
		[4] = "Take a shadow pill, <target>",
		[5] = "That's just cold, <target>.  Just plain cold",
		[6] = "And thats how I killed the dinosaurs",
		[7] = "Why so blue, <target>?",
		[8] = "Enjoy your 'You can't do that while frozen' messages",
		[9] = "Iceberg! Dead ahead!",
		[10] = "I don't know how we're gonna get <target> thawed!",
	};
	SERENITY_SHORT_MESSAGES = {
		[1] = "Resurrecting ==> <target>",
		[2] = "Shackle Undead ==> <target>",
	};

end

-------------------------------------
--  VERSION FRANCAISE --
-------------------------------------

function Serenity_Localization_Speech_Fr()

	SERENITY_RES_MESSAGE = {
		[1] = "Grand-p\195\168re disait toujours que le rire \195\169tait la meilleure m\195\169decine. Ce n'\195\169tait peut \195\170tre pas suffisant pour tenir <target> en vie.",
		[2] = "Okay, <target>, la sieste est finie! Au travail!",
		[3] = "R\195\169surrection de <target>, donnez moi un Alleluia!",
		[4] = "<target>, v\195\180tre souscription \195\160 Life Enterprise est expir\195\169. Voulez-vous la renouveler ?",
		[5] = "OUAIS! J'ai toujours voulu avoir un <target>-zombie pour moi!",
		[6] = "Ce qui est arriv\195\169 \195\160 <target> fait qu'il est VRAISSEMBLABLEMENT mort. Il y a une grande diff\195\169rence entre vraissemblablement mort et totalement mort. Vraissemblablement mort est l\195\169g\195\168rement vivant.",
		[7] = "<target> a \195\169chou\195\169 dans sa vie, je lui offre une seconde chance. Exactement, pas Dieu, MOI!!",
		[8] = "Cool, j'ai loot\195\169 1po 23pa sur le corps de <target>",
		[9] = "GAME OVER, <target>. Pour continuer appuyez sur haut, haut, bas, bas, gauche, droite, gauche, droite, B, A, B, A, Select + Start",
		[10] = "<target>, c'est plus rentable en mana de te laisser creuver et de te rez apr\195\168s. Haha, je d\195\169conne!",
		[11] = "Et bien, <target>, si seulement tu avais farm\195\169 ta r\195\169putation aupr\195\168s de <player>, tu aurais peut \195\170tre eu un heal. Comment calculer ? 1po de donation = 15 r\195\169putation.",
		[12] = "Okay, <target>. Arrete de faire le mort.",
		[13] = "Si vous pouvez lire ce message, c'est que <target> est d\195\169j\195\160 mort.",
		[14] = "Hola, me presse pas <target>. Si tu presses un faiseur de miracle, tu auras des miracles pourris.",
		[15] = "La mort vient pour toi <target>! Avec des dents longues et pointues!",
		[16] = "R\195\169surrection de <target>. Les effets peuvent inclure: naus\195\169es, entrailles explosives, trous dans le cerveau, et probl\195\168mes d'\195\169rection. R\195\169surrection n'est pas pour tout le monde. Merci de consulter un healer avant de mourir.",
		[17] = "Bon sang <target>, je suis un docteur! Pas un pr\195\170tre! .... Attend une seconde ...Oublis \195\167a. R\195\169ssurection de <target>.",
		[18] = "Mourir me rend tr\195\168\195\168\195\168\195\168\195\168\195\168\195\168s triste. <target>.",
		[19] = "<target> arrete de d\195\169gueulasser le sol sur lequel je marche et l\195\168ve toi!" ,
		[20] = "Hey <target>, tu peux v\195\169rifier si Elvis est vraiment mort ?... Et s'il peut prendre ta place dans le groupe ?",
		[21] = "J'offre une autre chance \195\160 <target> de refaire le noob.",
		[22] = "Bordel, <target>, est-ce que je t'ai AUTORISE \195\160 mourir ??!",
		[23] = "... D\195\169fier la mort n'est franchement pas ton fort, <target>.",
		[24] = "L\195\168ve-toi et marche, <target>.",
		[25] = "<target>, par l'acceptation de cette r\195\169surrection, vous vendez v\195\180tre \195\162me \195\160 <player>. Merci de cliquer sur 'Accepter' pour continuer.",
		[26] = "<target>, il serait pr\195\169f\195\169rable de ne pas recommencer ou je serais forc\195\169 d'entamer le bouche-\195\160-bouche.",
		[27] = "Rel\195\168ve toi de terre <target> et ne craint plus la mort; au moins jusqu'au prochain pull.",
		[28] = "Debout, <target>, esp\195\168ce de feignasse. Tu pourras pioncer quand tu ... Oh... Um, rez de <target> en cours.",
		[29] = "Nous pouvons reconstituer <target>, nous pouvons le rendre plus fort, plus rapide, NOUS AVONS LA TECHNOLOGIE! Mais pas pour le rendre plus malin h\195\169las.",
		[30] = "<target> est tomb\195\169 et ne peut pas se relever!",
		[31] = "Rel\195\168ve toi d'entre les morts! *balance <target> sur son caddie*",
		[32] = "Hey <target>, dit bonjour aux anges pour moi, tu veux ?",
		[33] = "<target>! arr\195\170te de taper sur le PJ qui te rez et viens cogner du monstre!",
		[34] = "<target>, je *t'avais pr\195\169venu*, mais m'as-tu \195\169cout\195\169 ? Noooooon, tu SAVAIS, n'est ce pas! Oh, *c'est juste un petit lapin tout nase* hein !",
		[35] = "<target>, s'il vous plait! C'est cens\195\169 \195\170tre une sortie heureuse! Arretez de vous taper dessus.",
		[36] = "Aujourd'hui dans Question pour un champion : les sorts qui se terminent par '\195\169ssurection. <target>, vous etes prets ?",
		[37] = "Il y a des choses bien pire que la mort, <target>. Imagine si tu \195\169tais group\195\169 avec... Heu, attend. Je ne devrais pas t'en parler.",
		[38] = "Tu as travers\195\169 un nid de serpents dans un avion ou quoi, <target> ? Parce que tu es mort!",
		[39] = "Pin-pon! Pin-pon! Pin-pon! Pin-pon! Pin-pon! Pin-pon ... c'est ma meilleure imitation d'ambulance possible, <target>.",
		[40] = "Tsk tsk, <target>. Tu vois, je t'avais dit de sacrifier cette vierge au crat\195\168re d'Un goro.",
		[41] = "Ne passez pas par la case Roxxor <target>, ne touchez pas un full set T3.",
		[42] = "Hey <target>, tu sais comment on appel un physicien dernier de sa classe ? Un m\195\169decin.",
		[43] = "Wow! Ca pue! C'est comme si quelqu'un avait creuv\195\169 la gueule ouverte! Hey, ou est <target> ?... Oh.",
		[44] = "Malheureusement, <target>, vous devez \195\170tre au moins R\195\169v\195\169r\195\169 avec les Pr\195\170tresses naines pour \195\170tre rez. Dommage d'\195\170tre vous meme.",
		[45] = "Vous ne meritez pas une belle macro de rez, <target>. Vous m\195\169ritez de mourir. Mais tu l'es d\195\170j\195\160 donc tant qu'\195\160 faire. Hum... voila.",
		[46] = "<target>, vous avez \195\169t\195\169 pes\195\169, mesur\195\169, et ressucit\195\169.",
		[47] = "Et bien <target>, tu as fais ce que tu pouvais et tu as \195\169chou\195\169 lamentablement. Bien jou\195\169.",
		[48] = "Ca a fait mal, <target>, quand tu es tomb\195\169 du Paradis? Oh, attend. Tu es mort. Je ne sais pas \195\160 quoi je pensais en disant \195\167a. Laisse tomber.",
		[49] = "Gah, <target>, encore mort? Tu veux probablement que l'on te rez, non? Tu crois que je suis quoi, un pretr... Oh. Ok \195\167a va.",
		[50] = "<target> tu as entendu parler de Nethera? Ouais, elle est trop cool. Pourquoi je t'en parle ? Aucune raison.",
		[51]="Crois moi <target>, ca me fais plus de mal qu'\195\160 toi ... Quoique non.",
		[52]="Hum, la formule est \195\160 revoir. Debout disciple <target> ou vous aurez un Blam",
	};
	
	SERENITY_SHACKLE_MESSAGE = {
		[1] = "LA TOUTE PUISSANCE DE TON SEIGNEUR "..string.upper(UnitName("player")).." T'Y CONTRAINDRA!!",
		[2] = " <target> entrav\195\169! Reste loin de mes co\195\169quipiers!",
		[3] = "J'esp\195\168re que tu as pris la tenue de cuir, <target>, moi j'ai d\195\170j\195\160 de quoi te sangler!",
		[4] = "Croyez le ou non, <target>, j'adore le bondage.",
		[5] = "<target> entrav\195\169! Laissez tomber tout ce que vous faites et petez-lui la tronche! ",
		[6] = "<target> entrav\195\169. Chaque fois que vous brisez cette entrave, Dieu tue un chaton. ",
		[7] = "<target> entrav\195\169 ! Tu le casses, tu le tank, c'est ton probl\195\168me.",
		[8] = "<target> est pour moi ... Vous en aurez d'autre mais celui-ci, je me le r\195\169serve.",
		[9] = "<target> entrav\195\169 car l'esprit dit non, mais je vois bien que le corps soupire le contraire.",
		[10] = "Aller, retourne dans ta cage, <target>!",
		[11] = "J'en ai assez de ces discussions sans fin avec toi <target>! Toujours la meme chose: 'manger cerveau' par ici, 'manger cerveau' par l\195\160 !",
		[12] = "Vous avez brav\195\169 la Loi et la Loi a gagn\195\169, <target>.",
		[13] = "<target>, allez en prison, ne passez pas par la case d\195\169part, ne touchez pas 20 000 po.",
	};
	SERENITY_SHACKLEWARN_MESSAGE = {
		[1] = "L'ennemi va sortir de sa prison, pr\195\169parez-vous \195\160 l'attaquer!",
		[2] = "Le Mort-vivant tente de s'enfuir, massacrez-le !",
	};
	
	SERENITY_STEED_MESSAGE = {
		[1] = "Mmmphhhh, je suis en retard! Invoquons vite un <mount> qui rox!",
		[2] = "J'invoque un <mount> sorti tout droit du plus grand haras!",
		[3] = "Donner un coup de pied sur l'arri\195\168re train de mon <mount> et je foncerai \195\160 toute allure.",
		[4] = "J'ai un superbe <mount>. En voiture Simone...",
	};
	
	SERENITY_SHORT_MESSAGES = {
		[1] = "R\195\169ssuscite ==> <target>.",
		[2] = "Entrave ==> <target>.",
	};
end


-------------------------------------
--  VERSION GERMAN -
--
--  � = \195\164   � = \195\132   � = \195\182   � = \195\150   � = \195\188   � = \195\156   � = \195\159
--
-------------------------------------

function Serenity_Localization_Speech_De()

	SERENITY_RES_MESSAGE = {
		[1] = "Gro\195\159vater hat immer gesagt, Lachen ist die beste Medizin.  Aber sie war wohl nicht gut genug um <target> am Leben zu halten.",
		[2] = "Okay, <target>, Mittagspause vorbei! Zur\195\188ck an die Arbeit!",
		[3] = "<target>, Ihr Abonnement auf Leben ist abgelaufen. M\195\182chtet Ihr es erneuern?",
		[4] = "Jaa! Ich wollte schon immer meinen eigenen <target>-Zombie!",
		[5] = "So wie es aussieht, ist <target> gr\195\182\195\159tenteils tot. Es gibt einen gro\195\159en Unterschied zwischen gr\195\182\195\159tenteils tot und ganz tot. Gr\195\182\195\159tenteils tot ist immer noch leicht am Leben.",
		[6] = "<target> hat im Leben versagt und ich gebe ihm eine zweite Chance.",
		[7] = "GAME OVER, <target>. To continue press up, up, down, down, left, right, left, right, B, A, B, A, Select + Start",
		[8] = "<target>, Dich wiederzubeleben ist einfach mana effektiver.",
		[9] = "Nun, <target>, Wenn Dein Ruf bei <player> etwas besser gewesen w\195\164re, h\195\164ttest Du vielleicht Heilung bekommen. Wie farmt man diesen Ruf? Einfach: 1g Spende = 15 Ruf",
		[10] = "Okay, <target>.  H\195\182r auf tot zu sein.",
		[11] = "Wenn Ihr diese Nachricht lest, ist <target> bereits tot.",
		[12] = "Hetz mich nicht <target>. Wenn man einen Wunderwirker hetzt bekommt man sch\195\164bige Wunder.",
		[13] = "Belebe <target> wieder. M\195\182gliche Nebenwirkungen sind: \195\156belkeit, Kopfschmerzen, Explodierende Eingeweide, Hei\195\159hunger auf Hirn und Erektionsst\195\182rungen. Bitte konsultieren Sie Ihren Heiler vor dem Sterben.",
		[14] = "Verdammt <target>, Ich bin Arzt kein Priester! .... Warte.... Schon gut. Belebe <target>",
		[15] = "Sterben macht mich traurig, <target>.",
		[16] = "<target> h\195\182r auf den Boden anzubeten auf dem ich gehe und steh auf." ,
		[17] = "Hey <target>, ist Elvis wirklich tot?... und kann er Deinen Platz in der Gruppe einnehmen?",
		[18] = "Verdammt, <target>, Hast du Dir meine ERLAUBNIS eingeholt bevor Du gestorben bist?",
		[19] = "Dem Tode trotzende Eigenschaften sich offensichtlich nicht deine St\195\164rke, <target>",
		[20] = "<target>, Indem Sie diese Wiederbelebung annehmen, verpf\195\164nden Sie ihre unsterbliche Seele an <player>. Bitte klicken Sie 'Annehmen' um die Nutzungsbedingungen zu akzeptieren.",
		[21] = "<target>, Ich hoffe dass dies kein weiterer armseliger Versuch ist, Deinen Mund auf meinen zu pressen.",
		[22] = "Steh auf <target>, und f\195\188rchte den Tod nie mehr; oder wenigstens bis zum n\195\164chsten Pull.",
		[23] = "H\195\182r auf zu faulenzen <target>. Du kannst schlafen, wenn Du . . . Oh. . . Ehm, belebe <target>",
		[24] = "Wir k\195\182nnen <target> neu erschaffen, wir k\195\182nnen ihn st\195\164rker, schneller, besser machen.... aber nicht kl\195\188ger.",
		[25] = "<target> ist hingefallen und kann alleine nicht mehr aufstehen!",
		[26] = "Bringt eure Toten raus! *schmei\195\159t <target> auf die Karre*",
		[27] = "<target>, h\195\182r auf den Geistheiler anzubaggern und komm her und t\195\182te irgendwas.",
		[28] = "<target> Ich hatte Dich gewarnt. Aber hast Du zugeh\195\182rt? Oh nein, Du wusstest es besser. Nur ein kleines harmloses *Kaninchen*, nicht wahr?",
		[29] = "Bitte, <target>! Dies soll doch ein fr\195\182hliches Ereignis sein. Lass und nicht streiten, wer wen get\195\182tet hat.",
		[30] = "Es gibt schlimmeres als den Tod, <target>. Warst Du jemals in einer Gruppe mit... oh, warte, wir sollten dar\195\188ber ja vor Dir nicht reden.",
		[31] = "Tss tss, <target>. I hab Dir doch gesagt Du h\195\164ttest die Jungfrau dem Vulkangott opfern sollen...",
		[32] = "<target> bekommt nen Mulligan.",
		[33] = "Hey <target>, wei\195\159t Du wie man den schlechtesten Absolventen der medizinischen Fakult\195\164t nennt? Doktor.",
		[34] = "Ieee!  Was riecht hier so?  Das riecht ja, als wenn hier drin was gestorben w\195\164re!  He, wo ist <target>?... Oh.",
		[35] = "Leider, <target>, musst Du f\195\188r eine Wiederbelebung mindestens *respektvoll* bei den Priestern sein. Pech f\195\188r Dich.",  
		[36] = "Nun <target>, Du hast Dein Bestes gegeben. Und offensichtlich kl\195\164glich versagt. Gute Arbeit.", 
		[37] = "Ach, <target>, schon wieder tot? Und nun willst Du vermutlich wiederbelebt werden? Was denkst Du das ich bin, ein Pries...oh...Na gut.",
		[38] = "<target> hast Du von Nethaera geh\195\182rt?  Ja, sie ist wirklich cool.  Warum ich das erw\195\164hne?  Kein besonderer Grund.",
		
	};
	SERENITY_SHACKLE_MESSAGE = {
		[1] = "DIE MACHT VON "..string.upper(UnitName("player")).." FESSELT DICH!!",
		[2] = "Fessle <target>!  Bleibt von den Ketten weg!",
		[3] = "Ich hoffe Du hast den Knebel mitgebracht <target>, denn ich habe die Ketten!",
		[4] = "Ob Du's glaubst oder nicht, <target>, ich steh auf Fesselspiele.",
		[5] = "Fessle <target>! Lass alles stehen und befrei es! ",
		[6] = "Fessle <target>. Jedes Mal wenn Du die Fesseln brichst, stirbt ein K\195\164tzchen.",
		[7] = "Fessle <target>!  Du befreist es, Du tankst es.",
		[8] = "<target> ist mein Untoter. Es gibt viele wie ihn, aber dieser ist meiner.",
		[9] = "Fessle <target> weil Untote nicht Nein sagen k\195\182nnen.",
		[10] = "In Deinen K\195\164fig, <target>!",
		[11] = "Alles was ich von Dir h\195\182re, ist 'Gehirne dies' und 'Gehirne das', <target>.  Nie wieder!",
		[12] = "Du hast mit dem Gesetz gek\195\164mpft... und verloren, <target>.",
		[13] = "<target>, gehe ins Gef\195\164ngnis. Gehe direkt dorthin. Gehe nicht \195\188ber Los, Ziehe nicht 200g ein.",
		[14] = "Das was sich niemals h\195\164tte bewegen sollen, <target>, steh noch einmal still!" ,

	};
	SERENITY_STEED_MESSAGE = {
		[1] = "Wenn's nicht f\195\188r mein <mount> gewesen w\195\164re, h\195\164tte ich nie das Jahr an der Uni verbracht.",
		[2] = "Die Anweisungen lauteten, einfach Wasser hinzugeben und.... WHOA ein <mount>!",
	};
	SERENITY_FREEZE_MESSAGE = {
		[1] = "Ich mag meine <target>s auf Eis",
		[2] = "Sieht aus als br\195\164uchte <target> nen Pullover!",
		[3] = "<3 Band der Eisesk\195\164lte",
		[4] = "Nimm ne Schatten-Tablette, <target>",
		[5] = "Das ist einfach kalt, <target>.  Nur kalt.",
		[6] = "Und das ist, wie ich die Dinosaurier get\195\182tet habe.",
		[7] = "Warum so k\195\188hl, <target>?",
		[8] = "Viel Spa\195\159 mit den 'Ihr k\195\182nnt das jetzt nicht tun' Nachrichten",
		[9] = "Eisberg! Genau voraus!",
		[10] = "Ich wei\195\159 nicht wie wir <target> jemals auftauen sollen!",
	};
	SERENITY_SHORT_MESSAGES = {
		[1] = "Belebe ==> <target>",
		[2] = "Fessle ==> <target>",
	};

end




---------------------------------
-- TRADITIONAL CHINESE VERSION -- 感謝 巴哈 winky, adolyes 提供翻譯
---------------------------------

function Serenity_Localization_Speech_Tw()

	SERENITY_RES_MESSAGE = {
		[1] = "<target>！你為什麼要代替你爹～",
		[2] = "<target>，這就是人蔘啊！",
		[3] = "啟動：陷阱卡－墳場呼喚的聲音，將 <target> 召喚回來！",
		[4] = "復活吧！<target>，我賜與你生命，然後再趴一次吧！",
		[5] = "該死的 <target>，還不快按接受！",
		[6] = "重生吧 <target>！我召喚你回來，為我而活吧！",
		[7] = "好了，<target>，休息時間已經過了！快起來工作！",
		[8] = "正在復活 <target>，給我一點禱告的時間...",
		[9] = "耶！我經常夢想著一具 <target> 牌僵屍！",
		[10] = "爽，我從 <target> 的屍體撿到了42s32c！",
		[11] = "遊戲結束，<target>。 要繼續請按上上下下左右左右AB選擇+開始。",
		[12] = "<target> 你又不是獵人，別裝死了！",
		[13] = "如果你看到這段訊息，那代表 <target> 已經死了。",
		[14] = "正在給 <target> 再次投胎的機會。 ",
		[15] = "該死的 <target>！你死之前有經過我允許嗎！？",
		[16] = "站起來，<target>。",
		[17] = "<target>，接受復活代表你允許你的靈魂被<player>沒收。 請按確定繼續。",
		[18] = "我們可以改造 <target>，讓他更強更敏捷，只可惜不能讓他不再那麼蠢。",
		[19] = "嘿，<target>，復活前別忘了替我跟天使打聲招呼啊。",
		[20] = "<target>，不要再煩靈魂醫者了，快起來打怪。",
		[21] = "嘖！什麼鬼東西這麼難聞？好像有股屍臭味？...原來是 <target> 的屍體？讓我來處理一下...",
		[22] = "<target> 復活吧！！我的勇士",
		[23] = "<target> 剛在OGC，所以趴掉了，大家快笑他！",
		[24] = "我知道我是宇宙霹靂無敵的大好人！！<target> 覺得是的話，請按『接受』",
		[25] = "正在復活===<target>=== 地板冷冷快起床>.<",
	};
	SERENITY_SHACKLE_MESSAGE = {
		[1] = "以<player>吃奶的力量束縛你！！",
		[2] = "正在束縛 <target>！遠離它吧！",
		[3] = "我把<target>鎖住了！打到自己負責喔～",
		[4] = "進去你的籠子吧<target>！",
		[5] = "<target>，坐牢吧！",
		[6] = "以<player>之力束縛你！！",
	};
	SERENITY_STEED_MESSAGE = {
		[1] = "如果不是為了這個<mount>，我就不會在大學多呆一年了。",
		[2] = "旅遊指南說要帶上水、麵包和什麼來著？哦，<mount>！",
		[3] = "我的<mount>又吃光了我的麵包！只好在多要拗點了……",
	};
	SERENITY_FREEZE_MESSAGE = {
		[1] = "我較喜歡我的 <target>們 被固定在石上",
		[2] = "看來 <target> 好像需要一件毛線衣！",
		[3] = "<target> 退熱帶",
		[4] = "服一粒暗影藥丸，<target>",
		[5] = "那只是寒冷，<target>‧只是一般的寒冷",
		[6] = "我就是這樣殺死一隻恐龍的",
		[7] = "為什麼面色發藍，<target>？",
		[8] = "好好享受這句「你被冰凍時不能那麼做」的說話吧",
		[9] = "冰山啊！死亡正在迫近！",
		[10] = "我不知道怎能幫 <target> 解凍！",
	};
	SERENITY_SHORT_MESSAGES = {
		[1] = "正在復活 ==> <target>",
		[2] = "束縛目標 ==> <target>",
	};

end



--------------------------------
-- SIMPLIFIED CHINESE VERSION --
--------------------------------

function Serenity_Localization_Speech_Cn()

	SERENITY_RES_MESSAGE = {
		[1] = "用怀疑的目光打量了一下<target>的尸体，冷冷的说：你在装死是不是？",
		[2] = "感谢CCTV，MTV，TVB，上海文广，星空卫视，湖南卫视。。。和一直支持，热爱我的FANS给我这次复活<target>T的机会。<target>~以至高无上滴偶的名义，站起来，为偶战斗吧！",
		[3] = "复活吧，我的勇士！                                                                                                                                                                                [<target>]说： 为你而战，我的女士！",
		[4] = "<target>表泡神仙JJ鸟……快起来吧……",
		[5] = "请求<target>为我冲值点卡，愿意的请点接受",
		[6] = "<target>请注意~~收费复活~~~5G一次~~~谢谢惠顾~~~",
		[7] = "打雷啦，下雨啦，<target>T你丫快起来收衣服啦!",
		[8] = "以魔神的名义，用我10000毫秒的生命为代价，让<target>的身体作为你强大力量的容器，出来吧，虚空中最强大的恶魔......",
		[9] = "正在为<target>做法事，闲杂人等勿近......",
		[10] = "开始对  <target>  回收！猪头猪头回收再造！！！",
		[11] = "你想要复活啊？<target>，你要是想要复活的话你就说话嘛，你不说我怎么知道你想要复活呢，虽然你很有诚意地看着我，可是你还是要跟我说你想要复活的。你真的想要复活吗？那你就活过来吧！你不是真的想要吧？难道你真的想要吗？……",
		[12] = "亲爱的<target>，是否需要……终极关怀？",
		[13] = "尘归尘,土归土,<target>,你安心的去吧,来人,把他拉出去埋了.......... ",
		[14] = "<target>现在很虚弱，我正在对他进行急救，9.9秒后护士瑟拉德丝小姐将会赶来对他进行人工呼吸",
		[15] = "<target>，不准偷懒！快起来干活！",
		[16] = "可怜的<target>,暴雪不理你，9c忽悠你，还得俺救你～～～～～",
		[17] = "你们打死了<target>，你们要为此付出代价！",
		[18] = "小强!小强你怎么了小强?小强你不能死呀!我跟你相依为命,同甘共苦,一直把你当成亲生骨肉教你养你,想不到今天,白发人送黑发人",
		[19] = "看着<target>的尸体在想:当年我当猎人的时候,就是这样复活宠物的~~" ,
		[20] = "作弊码：上上下下左右左右BABA Start+Select输入正确！验证完毕！赋予<target>最后一条命！",
		[21] = "原谅我，<target>，你的死亡只是增加了我的失败！",
		[22] = "挖了个坑，在胸前画了个十字，把<target>埋了，阿门",
		[23] = "挖个坑，埋点土，数个12345。<target>再不起来把你变没咯～",
		[24] = "现在听说很多牧师复活的时候喜欢用宏，jjyy说一大堆话，实在是影响聊天和浏览，<target>你来评评理，像我这种低调沉默的牧师，现在还有没有了~~你说是不是，还有RL，你也不批评一下他们，以我做榜样，光做事，不说话........",
		[25] = "<target>快起来！不起来我啃你尸体！",
		[26] = "为了防止世界被破坏,为了维护世界的和平,坚持爱和真实的罪恶,最有魅力的... 哎哟，谁扔的鸡蛋？好吧好吧，<target> 我现在就给你复活......",
		[27] = "<target> 别装了,快起来!不然我要用剥皮术了。",
		[28] = "地球是很危险D <target> 快回火星去把。 点接受返回地球，点拒绝回火星",
		[29] = "背着扫把的清洁工来了~~~~,10秒后>>>><target>这只猪<<<<将进入环保箱!!",
		[30] = "水30升，碳20千克，氨4升，石灰1.5千克，磷800克，盐250克，硝石100克，硫磺80克，氟7.5克，铁5克，硅3克，还有其余15种微量元素————<target>够炼你不？",
	};
	SERENITY_SHACKLE_MESSAGE = {
		[1] = "以 "..string.upper(UnitName("player")).." 吃奶的力量束缚你！！",
		[2] = "正在束缚 <target>！远离它吧！",
		[3] = "我把<target>锁住了！打到自己负责喔～"
		[4] = "进去你的笼子吧<target>！",
		[5] = "<target>，坐牢吧！"
	};
	SERENITY_STEED_MESSAGE = {
		[1] = "如果不是为了这个<mount>，我就不会在大学多呆一年了。",
		[2] = "旅游指南说要带上水、面包和什么来着？哦，<mount>！",
		[3] = "我的<mount>又吃光了我的面包！只好在多要拗点了……",
	};
	SERENITY_FREEZE_MESSAGE = {
		[1] = "我较喜欢我的 <target>们 被固定在石上",
		[2] = "看来 <target> 好像需要一件毛线衣！",
		[3] = "<target> 退热带",
		[4] = "服一粒暗影药丸，<target>",
		[5] = "那只是寒冷，<target>·只是一般的寒冷",
		[6] = "我就是这样杀死一只恐龙的",
		[7] = "为什么面色发蓝，<target>？",
		[8] = "好好享受这句“你被冰冻时不能那么做”的说话吧",
		[9] = "冰山啊！死亡正在迫近！",
		[10] = "我不知道怎能帮 <target> 解冻！",
	};
	SERENITY_SHORT_MESSAGES = {
		[1] = "正在复活 ==> <target>",
		[2] = "束缚目标 ==> <target>",
	};

end

-- Pour les caract鳥s spꤩaux :
-- Besondere Zeichen :
-- 頽 \195\169 ---- 蠽 \195\168
-- ࠽ \195\160 ---- ⠽ \195\162
-- \195\164�� \195\180 ---- ꠽ \195\170
-- 렽 \195\187 ---- \195\164�� \195\164
-- \195\132�= \195\132 ---- 栽 \195\182
-- \195\150�= \195\150 ---- 젽 \195\188
-- \195\156�= \195\156 ---- \195\159�= \195\159
-- 砽 \195\167 ----  \195\174


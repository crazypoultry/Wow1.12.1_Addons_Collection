-- é = \195\169
-- è = \195\168
-- ê = \195\170
-- à = \195\160 
-- ç = \195\167
-- î = \195\170
-- ô = \195\180

if ( GetLocale() == "frFR" ) then

AUTO_INVITE_COMPLETELIST="Liste Complete (%d)";

AUTO_INVITE_CLASS = {
   DRUID	= "Druide",
   HUNTER	= "Chasseur",
   MAGE		= "Mage",
   PALADIN	= "Paladin",
   SHAMAN	= "Chaman",
   PRIEST	= "Pr\195\170tre",
   ROGUE	= "Voleur",
   WARRIOR	= "Guerrier",
   WARLOCK	= "D\195\169moniste"
};

BINDING_HEADER_AUTOINVITE="Invitation automatique";
BINDING_NAME_AISHOW="Afficher et cacher l'ecran de configuration";
BINDING_NAME_AIINVITE="Inviter les personnes";
BINDING_NAME_AIADD="Ajouter la cible \195\160 la liste";

AUTO_INVITE_DECLINES_YOUR_INVITATION     ="%a+ refuse votre invitation \195\160 rejoindre le groupe.";
AUTO_INVITE_DECLINES_YOUR_INVITATION_FIND="^(.+) refuse votre invitation \195\160 rejoindre le groupe.";
AUTO_INVITE_IGNORES_YOUR_INVITATION="%a+ ignore vos messages.";
AUTO_INVITE_IGNORES_YOUR_INVITATION_FIND="^(.+) ignore vos messages.";

AUTO_INVITE_IS_ALREADY_IN_GROUP="%a+ est d\195\169j\195\160 dans un groupe.";
AUTO_INVITE_IS_ALREADY_IN_GROUP_FIND="^(.+) est d\195\169j\195\160 dans un groupe.";
AUTO_INVITE_SEND_MESSAGE_ALREADY_IN_GROUP="Vous \195\170tes d\195\169j\195\160 dans un groupe. Quittez le s'il vous plait.";

AUTO_INVITE_GROUP_LEAVE="%a+ a quitt\195\169 le groupe.";
AUTO_INVITE_GROUP_LEAVE_FIND="(.+) a quitt\195\169 le groupe.";
AUTO_INVITE_RAID_LEAVE="%a+ a quitt\195\169 le groupe de raid";
AUTO_INVITE_RAID_LEAVE_FIND="(.+) a quitt\195\169 le groupe de raid";

AUTO_INVITE_INVITED="Vous avez invit\195\169 %w+ \195\160 rejoindre votre groupe.";
AUTO_INVITE_INVITED_FIND="Vous avez invit\195\169 (.+) \195\160 rejoindre votre groupe.";
AUTO_INVITE_GROUP_DISBANDED="Le groupe n'existe plus.";
AUTO_INVITE_GROUP_DISBANDED2="Vous quittez le groupe.";
AUTO_INVITE_RAID_DISBANDED="Vous avez quitt\195\169 le groupe de raid";

AUTO_INVITE_GONE_OFFLINE="%a+ vient de se d\195\169connecter.";
AUTO_INVITE_IS_OFFLINE="Impossible de trouver '%a+'.";
AUTO_INVITE_IS_OFFLINE_FIND="Impossible de trouver '(.+)'.";

AUTO_INVITE_ADDMEMBER_LABEL="Nom \195\160 ajouter \195\160 la liste complete:";
AUTO_INVITE_SAVEDESCRPTION_LABEL="Description de votre configuration de groupe courante";
AUTO_INVITE_LOADCSV_LABEL="Inserer votre liste CVS en appuyant sur CTRL+v";

AUTO_INVITE_UNKNOWN_ENTITY="Entit\195\169e Inconnue"
end

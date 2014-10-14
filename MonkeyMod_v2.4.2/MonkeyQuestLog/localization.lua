--[[

	MonkeyQuestLog:
	A QuestLog replacement with enhanced features.

	Website:	http://toctastic.net/
	Author:		Trentin (trentin@toctastic.net)
	
	
	German Translation:	JimBim

--]]

-- if you'd like to submit a translation please email it to trentin@toctastic.net

-- Not translations, just constants
MkQL_MAX_REWARDS						= 10;

-- English, the default
MONKEYQUESTLOG_TITLE					= "MonkeyQuestLog Beta";
MONKEYQUESTLOG_VERSION					= "0.4.2";
MONKEYQUESTLOG_TITLE_VERSION			= MONKEYQUESTLOG_TITLE .. " v" .. MONKEYQUESTLOG_VERSION;
MONKEYQUESTLOG_DESCRIPTION				= "Displays the full quest description for MonkeyQuest";
MONKEYQUESTLOG_INFO_COLOUR				= "|cffffff00";
MONKEYQUESTLOG_LOADED_MSG				= MONKEYQUESTLOG_INFO_COLOUR .. MONKEYQUESTLOG_TITLE .. " v" .. MONKEYQUESTLOG_VERSION .. " loaded";

MONKEYQUESTLOG_DESC_HEADER				= "Description";
MONKEYQUESTLOG_REWARDS_HEADER			= "Rewards";
MkQL_REWARDSCHOOSE_TXT					= "Choose one of:";
MkQL_REWARDSRECEIVE_TXT					= "Receive all of:";
MkQL_SHARE_TXT							= "Share";
MkQL_ABANDON_TXT						= "Abandon";


if (GetLocale() == "deDE") then

	MONKEYQUESTLOG_DESCRIPTION				= "Zeigt die volle Quest Beschreibung für MonkeyQuest an";
	MONKEYQUESTLOG_LOADED_MSG				= MONKEYQUESTLOG_INFO_COLOUR .. MONKEYQUESTLOG_TITLE .. " v" .. MONKEYQUESTLOG_VERSION .. " geladen";
	
	MONKEYQUESTLOG_DESC_HEADER				= "Beschreibung";
	MONKEYQUESTLOG_REWARDS_HEADER			= "Belohnungen";
	MkQL_REWARDSCHOOSE_TXT					= "Auf Euch wartet eine dieser Belohnungen:";
	MkQL_REWARDSRECEIVE_TXT					= "Ihr bekommt:";
	MkQL_SHARE_TXT							= "Teilen";
	MkQL_ABANDON_TXT						= "Abbrechen";

end

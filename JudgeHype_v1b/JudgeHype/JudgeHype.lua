-- Pour le bon fonctionnement de l'addon, merci de ne pas modifier le code
-- Sharas, le 25 aout 2006 - http://worldofwarcraft.judgehype.com

JUDGEHYPE_VERSION = "Version 1b";
local JH_Loaded = false;

function JH_OnLoad()
	SLASH_JHCOMMAND1 = "/jh";
	SlashCmdList["JHCOMMAND"] = function()
		JHM_OnClick();
	end
	SLASH_JHPROFIL1 = "/jhprofil";
	SlashCmdList["JHPROFIL"] = function(msg)
		JHprofiler_doprofil(msg);
	end
	this:RegisterEvent("VARIABLES_LOADED");
end

function JH_OnEvent(event)
   	if (event == "VARIABLES_LOADED") then
		if (JH_Loaded==false) then
			JH_Loaded = true;
			JH_Init();
			JH_Greeting();
		end
	end 
end

function JH_Init()
	if (not JH_Main) then
		JH_Main = {};
		JH_Main.Calerte = 0;
		JH_Main.Profiler = 0;
		JH_Main.Tracker = 0;
		JH_Main.Position = 0;
		JH_Main.Minimap = 1;
		JH_Main.Accueil = 1;
		JH_Main.Collector = 1;
		JH_Main.CollectorMetier = 0;
		JH_Main.ServeurList = {};
		JH_GetDate();
		JH_Main.cc = {}
		JH_Main.cc.pnjs = 0;
		JH_Main.cc.monstres = 0;
		JH_Main.cc.objets = 0;
		JH_Main.cc.quetes = 0;
		JH_Main.cc.containers = 0;
		JH_Main.cc.vendu = 0;
		JH_Main.cc.ts = 0;
		JH_Main.cc.trainers = 0;
		JH_Main.cc.locs = 0;
		JH_Main.ccn = {}
		JH_Main.ccn.pnjs = "";
		JH_Main.ccn.monstres = "";
		JH_Main.ccn.objets = "";
		JH_Main.ccn.quetes = "";
		JH_Main.ccn.containers = "";
		JH_Main.ccn.vendu = "";
		JH_Main.ccn.ts = "";
		JH_Main.ccn.trainers = "";
		JH_Main.ccn.locs = "";
	end
	if (not JH_Collector) then
		JH_Collector = {};
		JH_Collector.objets = {};
		JH_Collector.pnjs = {};
		JH_Collector.monstres = {};
		JH_Collector.quetes = {};
		JH_Collector.box = {};
		JH_Collector.foundin = {};
		JH_Collector.dis = {};
		JH_Collector.vendu = {};
		JH_Collector.ts = {};
		JH_Collector.trainers = {};
		JH_Collector.fishing = {};
		JH_Collector.selling = {};
	end
	if (not JH_Profiler) then
		JH_Profiler = {};
	end
	JH_Main.ProfilerPage = 1;
	JH_Main.TrackerTimer = 0;
	JH_Main.TrackerPage = 1;
	JH_Main.TrackerZone = "";
	JH_Main.TrackZone = "";
	JH_Main.TrackPnj = "";
	JH_Main.TrackLoc = "";
	
	if not (GetLocale()=="frFR") then
		JH_Main.Collector = 0;
		JH_Main.CollectorMetier = 0;
		JHO_CollectorButton2:Disable();
	end
	
	JHM_Init();
	JHM_UpdatePosition();
	JHO_Init();
	JHP_Init();
	JHT_Init();
	JHO_ProfilerList();
	JHC_Init();
	
	if (not JH_Main.AddonVersion) then
		JH_Main.AddonVersion = JUDGEHYPE_VERSION;
	else
		if (JH_Main.AddonVersion ~= JUDGEHYPE_VERSION) then
			DEFAULT_CHAT_FRAME:AddMessage("|cffffff00Addon JudgeHype|r : Nouvelle version d\195\169tect\195\169e "..JH_Main.AddonVersion.." vers "..JUDGEHYPE_VERSION);
			JH_Profiler = {};
			JH_ResetAddon();
		end
	end
	
end

function JH_Greeting()
	if (JH_Main.Accueil == 1) then
		DEFAULT_CHAT_FRAME:AddMessage("|cffffff00Addon JudgeHype|r : "..JUDGEHYPE_VERSION.." charg\195\169e.");
	end
end

function JH_ResetAddon()
	DEFAULT_CHAT_FRAME:AddMessage("|cffffff00Addon JudgeHype|r : Remise \195\160 z\195\169ro des donn\195\169es.");
	JH_Main.AddonVersion = JUDGEHYPE_VERSION;
	JH_GetDate();
	JH_Main.ServeurList = {};
	JH_Collector = {};
	JH_Collector.objets = {};
	JH_Collector.pnjs = {};
	JH_Collector.monstres = {};
	JH_Collector.quetes = {};
	JH_Collector.box = {};
	JH_Collector.foundin = {};
	JH_Collector.dis = {};
	JH_Collector.vendu = {};
	JH_Collector.ts = {};
	JH_Collector.trainers = {};
	JH_Collector.fishing = {};
	JH_Collector.selling = {};
	JH_Main.cc = {}
	JH_Main.cc.pnjs = 0;
	JH_Main.cc.monstres = 0;
	JH_Main.cc.objets = 0;
	JH_Main.cc.quetes = 0;
	JH_Main.cc.containers = 0;
	JH_Main.cc.vendu = 0;
	JH_Main.cc.ts = 0;
	JH_Main.cc.trainers = 0;
	JH_Main.cc.locs = 0;
	JH_Main.ccn = {}
	JH_Main.ccn.pnjs = "";
	JH_Main.ccn.monstres = "";
	JH_Main.ccn.objets = "";
	JH_Main.ccn.quetes = "";
	JH_Main.ccn.containers = "";
	JH_Main.ccn.vendu = "";
	JH_Main.ccn.ts = "";
	JH_Main.ccn.trainers = "";
	JH_Main.ccn.locs = "";
	JH_Init();
end

function JH_CleanIt(toclean)
	if ( toclean == nil ) then
		toclean = "";
		return toclean;
	else
		return string.gsub(string.gsub(string.gsub(toclean, "\n", "|n|"), "\r", ""),"\"","dbquote");
	end
end

function JH_GetDate()
	local fullmois;
	local mois = date("%m");
	if (mois == "01") then fullmois = "janvier"; end
	if (mois == "02") then fullmois = "fevrier"; end
	if (mois == "03") then fullmois = "mars"; end
	if (mois == "04") then fullmois = "avril"; end
	if (mois == "05") then fullmois = "mai"; end
	if (mois == "06") then fullmois = "juin"; end
	if (mois == "07") then fullmois = "juillet"; end
	if (mois == "08") then fullmois = "aout"; end
	if (mois == "09") then fullmois = "septembre"; end
	if (mois == "10") then fullmois = "octobre"; end
	if (mois == "11") then fullmois = "novembre"; end
	if (mois == "12") then fullmois = "decembre"; end
	JH_Main.DerPurge = date("%d").." "..fullmois.." "..date("%Y %Hh%M");
end

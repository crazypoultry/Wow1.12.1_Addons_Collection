--[[

pa_config.lua
Panza Configuration Settings
Revision 4.0

--]]

-------------------------------------------------------------------------------------
-- function to reset saved variables setting
-------------------------------------------------------------------------------------

function PA:Reset(skipDCB, skipMessage)

	--------------------------------------------------------------------------
	-- Dont let the timer functions fail because we remove varaibles they use.
	-- Disable them for a few
	--------------------------------------------------------------------------
	if (_Paladin_is_Ready==true) then
		_Paladin_is_Ready = false;
		_Paladin_State_Change = true;
	end

	if (not skipMessage) then
		PA:Message(PANZA_MSG_NEW);
	end

	PAVersion									= {Release=PANZA_VERSION};
	PASettings									= {};
	PACurrentSpells								= {Indi={}, Group={}, LastTime=GetTime()};

	PASettings["Valid"]	 						= true;
	PASettings["ButtonPosition"] 				= 340;
	PASettings["Button"] 						= 1;
	PASettings["Alpha"]							= 0.7;
	PASettings["BuffExpire"]					= 60;
	PASettings["BoWManaLimit"]  				= 10;  -- Percentage of target's mana below which BoW will be cast.

	PASettings["Switches"]						= {};
	PASettings.Switches["MsgLevel"]				= {Heal=1,Bless=1,Cure=1,Core=1,Rez=1,UI=1,Coop=1,Offen=1};
	PASettings.Switches["AutoList"]				= false;
	PASettings.Switches["EnableSelf"]			= true;
	PASettings.Switches["EnableSave"]			= true;
	PASettings.Switches["EnableGroup"]			= true;
	PASettings.Switches["EnableMLS"]			= true;  -- MapLibrary Support. Enabled by default.
	PASettings.Switches["EnableTIB"]			= {enabled=true};  -- Titan Item Bonus Support. Enabled by default.
	PASettings.Switches["Button"]				= true;  -- MiniMap Button
	PASettings.Switches["UseRGS"]				= {enabled=true};
	PASettings.Switches["NoPVP"]				= {enabled=true};
	PASettings.Switches["CycleAnnc"]			= {enabled=false,raid=false,party=false};
	PASettings.Switches["ShieldAnnc"]			= {enabled=false,raid=false,party=false,solo=false,say=false,whisper=false,emote=false};
	PASettings.Switches["ShowRanks"]			= {enabled=true}; -- Show spell ranks.
	PASettings.Switches["ShowBlessingProgress"] = {enabled=true}; -- Show blessing progress on each blessing
	PASettings.Switches["UseActionRange"] 		= {Heal=true, Cure=true, Bless=true, Free=true, Offense=true}; -- Try to use action bars for range checking
	PASettings.Switches["Whisper"] 				= {enabled=false, feedback=true, rgs=true, match="any"};
	PASettings.Switches["clickmode"]			= {enabled=false};
	PASettings.Switches["CastBar"]				= {enabled=true};
	PASettings.Switches["UseIgnore"]			= {enabled=false}; -- Use Ignore List, will skip all actions on player (Heal, buff, Cure, Free, Rez)
	PASettings.Switches.QuietOnNotRequired 		= false; -- Used to suppress not required messages
	PASettings.Switches["GreaterBlessings"]		= {SELF=false,SOLO=false,PARTY=false,RAID=true,BG=false,Threshold=0.8,Warn=true, FillIn=true}; -- When to use Group Blessings

	PA:PAM_Defaults();
	PA:PBM_Defaults();
	PA:PHM_Defaults();
	PA:PPM_Defaults();
	PA:PFM_Defaults();
	PA:PAW_Defaults();
	PA:PCS_Defaults();
	PA:POM_Defaults();
	PA:PCM_Defaults();
	PA:PMM_Defaults();

	if (not skipDCB) then
		PA:InitializeDCB("DCB");
	end

	PA:PAMCustom_Defaults();

	---------------------------------------------------------------
	-- 1.31 : Raid Settings
	-- Default : everyone is blessed
	-- Individual settings
	-- true : blessed
	-- false : not blessed
	-------------------------------------------------------------
	PASettings["Raid"] = {};
	for i = 1, PANZA_MAX_RAID do
		PASettings.Raid[i] = true;
	end

	---------------------------------------
	-- Raid Group Settings (RGS)
	---------------------------------------
	PASettings["RaidGrp"]			= {};
	for i = 1, PANZA_MAX_RAID/PANZA_MAX_PARTY do
		PASettings.RaidGrp[i]		= {Enabled=true,Heal=true,Bless=true,Cure=true,Free=true,Panic=true};
	end

	if (PA.PlayerName==nil) then
		PA.PlayerName = UnitName("player");
	end

	PASettings["BlessList"]				= {};
	PASettings.BlessList[PA.PlayerName]	= {Spell=PA.DefaultBuff};
	PASettings.BlessIndex				= {};
	PASettings.BlessIndex[1]			= {Name=PA.PlayerName};

	----------------------------------------------------------------------
	-- All Done. If we were ready to process events before, re-enable them
	-----------------------------------------------------------------------
	if (_Paladin_State_Change == true and _Paladin_is_Ready == false) then
		_Paladin_is_Ready = true;
	end

	----------------------------------------------------
	-- Update All open Panels with the info just created
	----------------------------------------------------
	if (PanzaSTAFrame:IsVisible() == true) then
		PA:STA_SetValues();
	end

	if (PanzaOptsFrame:IsVisible() == true) then
		PA:Opts_SetValues();
	end

	if (PanzaPAMFrame:IsVisible() == true) then
		PA:PAM_SetValues();
	end

	if (PanzaDCBFrame:IsVisible() == true) then
		PA:DCB_SetValues();
	end

	if (PanzaRGSFrame:IsVisible() == true) then
		PA:RGS_SetValues();
	end

	if (PanzaPBMFrame:IsVisible() == true) then
		PA:PBM_SetValues();
	end

	if (PanzaPBMGroupFrame:IsVisible() == true) then
		PA:PBMGroup_SetValues();
	end

	if (PanzaPHMFrame:IsVisible() == true) then
		PA:PHM_SetValues();
	end

	if (PanzaPHMAdvancedFrame:IsVisible() == true) then
		PA:PHMAdvanced_SetValues();
	end

	PA:SetIfMissing();
end


--------------------------------------------------------------------------
-- Function to verify correct variables are saved/restored for a character
--------------------------------------------------------------------------
function PA:CheckConfig()

	-- Settings Missing
	if (PASettings==nil) then
		return false;
	end

	if (not PASettings["Valid"]) then
		PA:Message("Missing Valid Key");
		return false;
	elseif (not PASettings["ButtonPosition"]) then
		PA:Message("Missing Position Field");
		return false;
	elseif (not PASettings["Alpha"]) then
		PA:Message("Missing Alpha");
		return false;
	elseif (not PASettings["BuffExpire"]) then
		PA:Message("Missing BUFFEXpire");
		return false;
	elseif (not PASettings["Switches"]) then
		PA:Message("Missing Switches Key");
		return false;
	elseif (not PASettings.Switches["MsgGroup"]) then
		PA:Message("Missing MsgGroup Key");
		return false;
	elseif (not PASettings.Switches["MsgLevel"]) then
		PA:Message("Missing MsgLevel Key");
		return false;
	elseif (not PASettings["Heal"]) then
		PA:Message("Missing Heal Key");
		return false;
	elseif (not PASettings.Heal["Sense"]) then
		PA:Message("Missing Heal Sense Key");
		return false;
	elseif (not PASettings.Heal["Abort"]) then
		PA:Message("Missing Heal Abort Key");
		return false;
	elseif (PASettings.Heal["LowFlash"]==nil) then
		PA:Message("Missing Heal Low Flash Key");
		return false;
	elseif (not PASettings["RaidGrp"]) then
		PA:Message("Missing RGS Key");
		return false;
	elseif (not PASettings.Switches["Rebless"]) then
		PA:Message("Missing Cycle Rebless Threshold");
		return false;
	elseif (not PASettings.Switches["NearRestart"]) then
		PA:Message("Missing CycleNear List Timeout Threshold");
		return false;
	elseif (not PASettings["DCB"]) then
		PA:Message("Missing DCB Table.");
		return flase;
	elseif (not PASettings.Switches["Pets"]) then
		PA:Message("Missing Pets Enable Key");
		return false;
	elseif (not PASettings.Switches["IgnorePartyInRaid"]) then
		PA:Message("Missing Ignore Party In Raid Key");
		return false;
	elseif (not PASettings.Switches["ShowRanks"]) then
		PA:Message("Missing Display Rank setting");
		return false;
	elseif (not PASettings.Switches["UseRGS"]) then
		PA:Message("Missing RGS Enable Key");
		return false;
	elseif (PASettings.Switches["NoPVP"]==nil) then
		PA:Message("Missing PVP Enable Key");
		return false;
	elseif (not PASettings.Switches["CycleAnnc"]) then
		PA:Message("Missing Blessing Announcement Key");
		return false;
	elseif (not PASettings.Heal["IB"]) then
		PA:Message("Missing Healing Item Bonus Key");
		return false;
	elseif (not PASettings.Switches["BlessBowOnLowMana"]) then
		PA:Message("Missing Bless BoW on low mana switch");
		return false;
	elseif (not PASettings.BoWManaLimit) then
		PA:Message("Missing Bless BoW low mana limit");
		return false;
	elseif (not PASettings.Switches["PVPUseBG"]) then
		PA:Message("Missing Use BG on PVP flag");
		return false;
	elseif (PASettings.Switches["ClassSelect"]==nil) then
		PA:Message("Missing Class Selection settings.");
		PA:PCS_Defaults();
	elseif (not PASettings.NotBlessedCount) then
		PA:Message("Missing No Bless Count setting");
		return false;
	elseif (not PASettings.Switches["ShowBlessingProgress"]) then
		PA:Message("Missing Blessing Progress switch");
		return false;
	end
	PA:SetIfMissing();
	return true;
end

-- Set any missing settings
function PA:SetIfMissing()

	--PA:ShowText("SetIfMissing");

	if (PASettings.Switches["Whisper"]==nil) then
		PASettings.Switches["Whisper"] = {enabled=false,feedback=true,rgs=true,match="any"};
	end

	if (PASettings.Heal.PartyBias==nil) then
		PASettings.Heal.PartyBias = 0.25;
	end

	if (PASettings.Heal.MainTankBias==nil) then
		PASettings.Heal.MainTankBias = 0.0;
	end

	if (PASettings.Heal.MTTTBias==nil) then
		PASettings.Heal.MTTTBias = 0.0;
	end

	if (PASettings.Heal.SelfBias==nil) then
		PASettings.Heal.SelfBias = 0.0;
	end

	if (PASettings["RezMessage"]==nil) then
		PASettings["RezMessage"] = PANZA_MSG_RESURRECTING;
	end
	if (PASettings.Switches["GreaterBlessings"]==nil) then
		PA:Message("Setting default values for Group Blessing use.");
		PASettings.Switches["GreaterBlessings"] = {SELF=false,SOLO=false,PARTY=false,RAID=true,BG=false,Threshold=0.8,Warn=true, FillIn=true}; -- When to use Group Blessings
	end
	if (PASettings.Switches.GreaterBlessings["Threshold"]==nil) then
		PASettings.Switches.GreaterBlessings["Threshold"] = 0.8;
	end
	if (PASettings.Switches.GreaterBlessings["Warn"]==nil) then
		PASettings.Switches.GreaterBlessings["Warn"] = true;
	end
	if (PASettings.Switches.GreaterBlessings["SELF"]==nil) then
		PASettings.Switches.GreaterBlessings["SELF"] = false;
	end
	if (PASettings.Switches.GreaterBlessings["FillIn"]==nil) then
		PASettings.Switches.GreaterBlessings["FillIn"] = true;
	end
	if (PASettings.Switches["clickmode"]==nil) then
		PASettings.Switches["clickmode"] = {enabled=false};
		PA:PMM_Defaults();
	end
	if (PASettings["clickmods"]==nil or PASettings["PMM"]==nil) then
		PA:Message("Setting Default values for Panza Mouse Module (PMM)");
		PA:PMM_Defaults();
	end
	if (PASettings.Switches.MsgLevel["Coop"]==nil) then
		PASettings.Switches.MsgLevel["Coop"] = 1;
	end
	if (PASettings.Switches.MsgLevel["Offen"]==nil) then
		PASettings.Switches.MsgLevel["Offen"] = 1;
	end
	if (PASettings.Heal["Coop"] == nil) then
		PA:Message("Setting default values for Coorporative Healing.");
		PASettings.Heal["Coop"] = {enabled=true, timer=2, Channel="Raid"};
	end
	if (PASettings.Heal["ManaBuffer"] == nil) then
		PA:Message("Setting Heal Mana Buffer value to default value of 1. range 0-5.");
		PASettings.Heal["ManaBuffer"] = 1;
	end
	if (PASettings.Heal.Coop["enabled"]==nil) then
		PASettings.Heal["Coop"] = {enabled=true, timer=2};
	end
	if (PASettings.Heal.Coop["timer"]==nil) then
		PASettings.Heal["Coop"] = {enabled=true, timer=2};
	end
	if (PASettings.Heal.Coop["Channel"]==nil) then
		PASettings.Heal["Coop"]["Channel"]="Raid";
	end
	if (PASettings.Heal.Coop["Channel"]~="Raid" and PASettings.Heal.Coop["Channel"]~="Guild") then
		PA:Message("Setting CoOp Msg Destination to Raid Addon Messaging");
		PASettings.Heal["Coop"]["Channel"]="Raid";
	end	
	if (PASettings.Heal["Bars"] == nil) then
		PASettings.Heal["Bars"] = {enabled=true, OwnBars=true, OtherBars=false};
	end
	if (PASettings.Heal.Bars["OwnBars"]==nil) then
		PASettings.Heal.Bars["OwnBars"]=true;
	end
	if (PASettings.Heal.Bars["OtherBars"]==nil) then
		PASettings.Heal.Bars["OtherBars"]=false;
	end
	if (PASettings.Heal["OverHeal"]==nil) then
		PASettings.Heal["OverHeal"]=1.20;
	end
	if (PASettings.Heal["UseDF"]==nil) then
		PASettings.Heal["UseDF"] = true;
	end
	if (PASettings.Heal["UseDFOOC"]==nil) then
		PASettings.Heal["UseDFOOC"] = true;
	end
	if (PASettings.Heal["MinCritRank"]==nil) then
		PASettings.Heal["MinCritRank"] = 0;
	end
	if (PASettings.Heal["BarsLocked"]==nil) then
		PASettings.Heal["BarsLocked"] = 0;
	end
	if (PASettings.Heal["MidHealth"]==nil) then
		PASettings.Heal["MidHealth"] = 0.5;
	end
	if (PASettings.Heal.Trinket==nil) then
		PASettings.Heal.Trinket = {OnDF=false, OnFlash=false, OnHeal=true};
	end
	if (PASettings.Switches["ShieldAnnc"]==nil) then
		PASettings.Switches["ShieldAnnc"]	= {enabled=false,raid=false,party=false,solo=false,say=false,whisper=false,emote=false};
	end
	if (PASettings.Switches["BEWS"]==nil) then
		PASettings.Switches["BEWS"]	= {raid=false, party=false, all=false};
	end
	if (PASettings.Switches["BoSafOnPVP"]==nil) then
		PASettings.Switches["BoSafOnPVP"] = true;
	end
	if (PASettings.Switches["EnableGroup"]==nil) then
		PASettings.Switches["EnableGroup"] = true;
	end
	if (PASettings["PFMWeight"]==nil) then
		PA:PFM_Defaults();
	end

	if (PASettings["CurePriority"]==nil
		or PASettings.CurePriority["Magic"]==nil
		or PASettings.CurePriority["Poison"]==nil
		or PASettings.CurePriority["Disease"]==nil
		or PASettings.CurePriority["Curse"]==nil) then
		PA:PCM_Defaults();
	end

	if (PASettings["PanicClass"]==nil
		or PASettings.Switches["PanicStages"]==nil
		or PASettings.Switches.PanicStages[6]==nil
		or PASettings.PanicMinHealth==nil
		or PASettings.PanicMinHealth.MAGE==nil) then
		PA:Message("Missing Panic Settings");
		PA:PPM_Defaults();
	end

	if (PASettings.Switches["UseActionRange"]==nil) then
		PASettings.Switches["UseActionRange"] 	= {Heal=true, Cure=true, Bless=true, Free=true, Offense=true, Rez=true}; -- Try to use action bars for range checking
	else
		if (PASettings.Switches.UseActionRange.enabled~=nil) then
			PASettings.Switches.UseActionRange["Heal"] = PASettings.Switches.UseActionRange.enabled;
			PASettings.Switches.UseActionRange["Cure"] = PASettings.Switches.UseActionRange.enabled;
			PASettings.Switches.UseActionRange["Bless"] = PASettings.Switches.UseActionRange.enabled;
			PASettings.Switches.UseActionRange["Free"] = PASettings.Switches.UseActionRange.enabled;
			PASettings.Switches.UseActionRange["Offense"] = PASettings.Switches.UseActionRange.enabled;
			PASettings.Switches.UseActionRange["Rez"] = PASettings.Switches.UseActionRange.enabled;
			PASettings.Switches.UseActionRange.enabled = nil;
		end
	end

	if (PASettings.Switches.UseActionRange.Offense==nil) then
		PASettings.Switches.UseActionRange.Offense=true;
	end

	if (PASettings.Switches.UseActionRange.Rez==nil) then
		PASettings.Switches.UseActionRange.Rez=true;
	end

	if (PASettings.Heal["IgnoreRange"]==nil) then
		PASettings.Heal["IgnoreRange"] = false;
	end

	if (PASettings.Heal.OOCHealing==nil) then
		PASettings.Heal.OOCHealing = true;
	end

	if (PASettings.Heal.UseHoTs==nil) then
		PASettings.Heal.UseHoTs = true;
	end

	if (PASettings.Heal.UseRegrowth==nil) then
		PASettings.Heal.UseRegrowth = true;
	end

	if (PASettings.Heal.HoTOnMove==nil) then
		PASettings.Heal.HoTOnMove = true;
	end

	if (PASettings.Damage==nil) then
		PASettings.Damage={};
	end

	if (PASettings["DCBSaved"]==nil) then
		PASettings["DCBSaved"] = {};
	end

	if (PASettings["DCBUseSaved"]==nil) then
		PASettings["DCBUseSaved"] = 0;
	end

	if (PASettings["DCBSavedIndex"]==nil) then
		PASettings["DCBSavedIndex"] = 1;
	end

	if (PASettings.Switches["Offense"]==nil) then
		PA:POM_Defaults();
	end

	if (PASettings.Switches.Offense["HSAlwaysOnDF"]==nil) then
		PASettings.Switches.Offense["HSAlwaysOnDF"]=false;
	end

	if (PASettings.Switches.Offense["Auto"]==nil) then
		PASettings.Switches.Offense["Auto"] = {Seal1="sow", Seal2="soc"};
	end

	if (PASettings.Switches.Offense["AutoPVP"]==nil) then
		PASettings.Switches.Offense["AutoPVP"] = {Seal1="soc", Seal2="soc"};
	end

	if (PASettings.Switches.Offense["soc"]==nil) then
		PASettings.Switches.Offense["soc"] = true;
	end

	if (PASettings.Switches.Offense["stunned"]==nil) then
		PASettings.Switches.Offense["stunned"] = true;
	end

	if (PASettings.Switches.Offense["sor"]==nil) then
		PASettings.Switches.Offense["sor"] = true;
	end

	if (PASettings.Switches.Offense["offall"]==nil) then
		PASettings.Switches.Offense["offall"] = false;
	end

	if (PASettings.Switches.Offense.MaxThreat==nil) then
		PASettings.Switches.Offense.MaxThreat = false;
	end

	if (PASettings["SealMenu"]==nil) then
		if (PA:CheckMessageLevel("Core", 2)) then
			PA:Message4("Setting Seal Menu Defaults");
		end
		PA:SealMenu_Defaults();
	end

	if (PASettings.SealMenu["IgnorePvP"]==nil) then
		PASettings.SealMenu["IgnorePvP"] = false;
	end

	if (PASettings.SealMenu["Tooltips"]==nil) then
		PASettings.SealMenu["Tooltips"] = true;
	end

	------------------------------
	-- Check RGS table for group 1
	------------------------------
	if (PASettings.RaidGrp==nil) then
		PA:RGS_Defaults();
	end
	if (not PASettings.RaidGrp[1]) then
		PA:RGS_Defaults();
	end
	if (not PASettings.RaidGrp[1]["Enabled"]) then
		PA:RGS_Defaults();
	end

	if (not PASettings.RaidGrp[1]["Heal"]) then
		PA:RGS_Defaults();
	end

	if (not PASettings.RaidGrp[1]["Bless"]) then
		PA:RGS_Defaults();
	end

	if (not PASettings.RaidGrp[1]["Cure"]) then
		PA:RGS_Defaults();
	end

	if (not PASettings.RaidGrp[1]["Free"]) then
		PA:RGS_Defaults();
	end

	if (not PASettings.RaidGrp[1]["Panic"]) then
		PA:RGS_Defaults();
	end

	if (PAVersion["Release"] ~= PANZA_VERSION) then
		PA:Message(format(PANZA_MSG_UPDATE, PAVersion["Release"], PANZA_VERSION));
		PAVersion["Release"]= PANZA_VERSION;
	end

	if (PASettings.PHMBiasClass==nil or PASettings.PHMBiasWeight==nil) then
		PA:PHMBias_Defaults();
	end

	if (PASettings.Heal.UseDFAll==nil) then
		PASettings.Heal.UseDFAll = PASettings.Heal.UseDF;
	end

	if (PASettings.SealMenu.Text==nil) then
		PASettings.SealMenu.Text = "top";
	end

	if (PASettings.Heal.GroupLimit==nil) then
		PASettings.Heal.GroupLimit = 3;
	end

	if (PASettings.PFMWeight.WARRIOR>10) then
		PA:PFM_Defaults();
	end

	if (PASettings.Button==nil) then
		PASettings.Button = 1;
	end

	if (PASettings.Heal.ZoneSteps==nil) then
		PA:DefaultHealZoneSteps();
	end
	
	if (PASettings.Switches["CastBar"]==nil) then
		PASettings.Switches["CastBar"] = {enabled = true};
	end
	
	if (PASettings.Switches["UseIgnore"]==nil) then
		PASettings.Switches["UseIgnore"] = {enabled = false};
	end	
	
	if (PASettings.Switches.QuietOnNotRequired==nil) then
		PASettings.Switches.QuietOnNotRequired = false;
	end
	
	if (PASettings.Switches.PanicOnHeal==nil) then
		PASettings.Switches.PanicOnHeal = false;
	end
end

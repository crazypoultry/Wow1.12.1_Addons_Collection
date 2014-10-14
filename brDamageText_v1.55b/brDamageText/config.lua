--[[ -------------------------- Config File -------------------------- ]]--
--[[ ----------------------------- Texts ----------------------------- ]]--
brDamageText_Vars = {};
brDamageText_Vars["SPELLLOGABSORBSELFOTHER"] = TEXT(ABSORB);
brDamageText_Vars["SPELLDEFLECTEDSELFOTHER"] = TEXT(DEFLECT);
brDamageText_Vars["SPELLDODGEDSELFOTHER"] = TEXT(DODGE);
brDamageText_Vars["SPELLEVADEDSELFOTHER"] = TEXT(EVADE);
brDamageText_Vars["SPELLIMMUNESELFOTHER"] = TEXT(IMMUNE);
brDamageText_Vars["SPELLPARRIEDSELFOTHER"] = TEXT(PARRY);
brDamageText_Vars["SPELLREFLECTSELFOTHER"] = TEXT(REFLECT);
brDamageText_Vars["SPELLRESISTSELFOTHER"] = TEXT(RESIST);
brDamageText_Vars["SPELLMISSSELFOTHER"] = TEXT(MISS);
brDamageText_Vars["SPELLINTERRUPTSELFOTHER"] = TEXT(INTERRUPT);
brDamageText_Vars["VSABSORBSELFOTHER"] = TEXT(ABSORB);
brDamageText_Vars["VSBLOCKSELFOTHER"] = TEXT(BLOCK);
brDamageText_Vars["VSDEFLECTSELFOTHER"] = TEXT(DEFLECT);
brDamageText_Vars["VSDODGESELFOTHER"] = TEXT(DODGE);
brDamageText_Vars["VSEVADESELFOTHER"] = TEXT(EVADE);
brDamageText_Vars["VSIMMUNESELFOTHER"] = TEXT(IMMUNE);
brDamageText_Vars["VSPARRYSELFOTHER"] = TEXT(PARRY);
brDamageText_Vars["VSRESISTSELFOTHER"] = TEXT(RESIST);
brDamageText_Vars["MISSEDSELFOTHER"] = TEXT(MISS);
--[[ ------------------------- Ignore Spells ------------------------- ]]--
brDamageText_SpellIgnores = {};
brDamageText_SpellIgnores = {
	[BRDAMAGETEXT_SPELLIGNORE.IMPROVEDSHADOWBOLT]		= true;
	[BRDAMAGETEXT_SPELLIGNORE.WINTERCHILL]			= true;
	[BRDAMAGETEXT_SPELLIGNORE.SHADOWVULNERABILITY]		= true;
};

--[[ ---------------------- Special Spell COlor ---------------------- ]]--
brDamageText_Special = {};
brDamageText_Special = {
	["Shadow Bolt"]				= { ["active"]=0;  ["col_r"]=1.0; ["col_g"]=0.0; ["col_b"]=0.0; };
};

--[[ ------------------------- Colors & Size ------------------------- ]]--
brDamageText_ColSize = {};
brDamageText_ColSize = {
	["COMBATHITCRITSCHOOLSELFOTHER"]	= { ["size"]=1.5;  ["col_r"]=1.0; ["col_g"]=1.0; ["col_b"]=1.0; };
	["COMBATHITCRITSELFOTHER"]			= { ["size"]=1.5;  ["col_r"]=1.0; ["col_g"]=1.0; ["col_b"]=1.0; };
	["COMBATHITSCHOOLSELFOTHER"]		= { ["size"]=1;    ["col_r"]=1.0; ["col_g"]=1.0; ["col_b"]=1.0; };
	["COMBATHITSELFOTHER"]				= { ["size"]=1;    ["col_r"]=1.0; ["col_g"]=1.0; ["col_b"]=1.0; };
	["PERIODICAURADAMAGESELFOTHER"]		= { ["size"]=1;    ["col_r"]=1.0; ["col_g"]=1.0; ["col_b"]=0.0; };
	["SPELLLOGCRITSCHOOLSELFOTHER"]		= { ["size"]=1.5;  ["col_r"]=1.0; ["col_g"]=1.0; ["col_b"]=1.0; };
	["SPELLLOGCRITSELFOTHER"]			= { ["size"]=1.5;  ["col_r"]=1.0; ["col_g"]=1.0; ["col_b"]=1.0; };
	["SPELLLOGSCHOOLSELFOTHER"]			= { ["size"]=1;    ["col_r"]=1.0; ["col_g"]=1.0; ["col_b"]=1.0; };
	["SPELLLOGSELFOTHER"]				= { ["size"]=1;    ["col_r"]=1.0; ["col_g"]=1.0; ["col_b"]=1.0; };
	["SPELLSPLITDAMAGESELFOTHER"]		= { ["size"]=1;    ["col_r"]=1.0; ["col_g"]=1.0; ["col_b"]=1.0; };
	["SPELLLOGABSORBSELFOTHER"]			= { ["size"]=0.75; ["col_r"]=1.0; ["col_g"]=1.0; ["col_b"]=1.0; };
	["SPELLDEFLECTEDSELFOTHER"]			= { ["size"]=0.75; ["col_r"]=1.0; ["col_g"]=1.0; ["col_b"]=1.0; };
	["SPELLDODGEDSELFOTHER"]			= { ["size"]=0.75; ["col_r"]=1.0; ["col_g"]=1.0; ["col_b"]=1.0; };
	["SPELLEVADEDSELFOTHER"]			= { ["size"]=0.75; ["col_r"]=1.0; ["col_g"]=1.0; ["col_b"]=1.0; };
	["SPELLIMMUNESELFOTHER"]			= { ["size"]=0.5;  ["col_r"]=1.0; ["col_g"]=1.0; ["col_b"]=1.0; };
	["SPELLPARRIEDSELFOTHER"]			= { ["size"]=0.75; ["col_r"]=1.0; ["col_g"]=1.0; ["col_b"]=1.0; };
	["SPELLREFLECTSELFOTHER"]			= { ["size"]=0.75; ["col_r"]=1.0; ["col_g"]=1.0; ["col_b"]=1.0; };
	["SPELLRESISTSELFOTHER"]			= { ["size"]=0.75; ["col_r"]=1.0; ["col_g"]=1.0; ["col_b"]=1.0; };
	["SPELLMISSSELFOTHER"]				= { ["size"]=0.75; ["col_r"]=1.0; ["col_g"]=1.0; ["col_b"]=1.0; };
	["SPELLINTERRUPTSELFOTHER"]			= { ["size"]=0.75; ["col_r"]=1.0; ["col_g"]=1.0; ["col_b"]=1.0; };
	["VSABSORBSELFOTHER"]				= { ["size"]=0.75; ["col_r"]=1.0; ["col_g"]=1.0; ["col_b"]=1.0; };
	["VSBLOCKSELFOTHER"]				= { ["size"]=0.75; ["col_r"]=1.0; ["col_g"]=1.0; ["col_b"]=1.0; };
	["VSDEFLECTSELFOTHER"]				= { ["size"]=0.75; ["col_r"]=1.0; ["col_g"]=1.0; ["col_b"]=1.0; };
	["VSDODGESELFOTHER"]				= { ["size"]=0.75; ["col_r"]=1.0; ["col_g"]=1.0; ["col_b"]=1.0; };
	["VSEVADESELFOTHER"]				= { ["size"]=0.75; ["col_r"]=1.0; ["col_g"]=1.0; ["col_b"]=1.0; };
	["VSIMMUNESELFOTHER"]				= { ["size"]=0.5;  ["col_r"]=1.0; ["col_g"]=1.0; ["col_b"]=1.0; };
	["VSPARRYSELFOTHER"]				= { ["size"]=0.75; ["col_r"]=1.0; ["col_g"]=1.0; ["col_b"]=1.0; };
	["VSRESISTSELFOTHER"]				= { ["size"]=0.75; ["col_r"]=1.0; ["col_g"]=1.0; ["col_b"]=1.0; };
	["MISSEDSELFOTHER"]					= { ["size"]=0.75; ["col_r"]=1.0; ["col_g"]=1.0; ["col_b"]=1.0; };
	-- healing
	["HEALEDCRITSELFOTHER"]				= { ["size"]=1.5;  ["col_r"]=0.0; ["col_g"]=1.0; ["col_b"]=0.0; };
	["HEALEDCRITSELFSELF"]				= { ["size"]=1.5;  ["col_r"]=0.0; ["col_g"]=1.0; ["col_b"]=0.0; };
	["HEALEDSELFOTHER"]					= { ["size"]=1;    ["col_r"]=0.0; ["col_g"]=1.0; ["col_b"]=0.0; };
	["HEALEDSELFSELF"]					= { ["size"]=1;    ["col_r"]=0.0; ["col_g"]=1.0; ["col_b"]=0.0; };
};
BRDAMAGETEXT_FONTHEIGHT = 30;
BRDAMAGETEXT_MINIGROUP_FONTHEIGHT = 16;
BRDAMAGETEXT_NURFEDUNITFRAMES_FONTHEIGHT = 16;
--[[ ------------------- Compatibility with AddOns ------------------- ]]--
BRDAMAGETEXT_VALUES_ID = {};
BRDAMAGETEXT_VALUES_ID[1] = "TargetFramePortrait";
BRDAMAGETEXT_VALUES_ID[2] = "Own Frame";
BRDAMAGETEXT_VALUES_ID[3] = "Perl Classic Target (Portrait)";
BRDAMAGETEXT_VALUES_ID[4] = "Nurfed TargetFrame";
BRDAMAGETEXT_VALUES_ID[5] = "Discord UnitFrame (Portrait)";
BRDAMAGETEXT_FRAMENAMES = {};
BRDAMAGETEXT_FRAMENAMES[1] = "TargetPortrait";
BRDAMAGETEXT_FRAMENAMES[2] = "brDamageTextOwnFrame";
BRDAMAGETEXT_FRAMENAMES[3] = "Perl_Target_PortraitFrame";
BRDAMAGETEXT_FRAMENAMES[4] = "Nurfed_targetHealthBar";
BRDAMAGETEXT_FRAMENAMES[5] = "DUF_TargetFrame_Portrait";
BRDAMAGETEXT_ADDON = {};
BRDAMAGETEXT_ADDON[1] = "";
BRDAMAGETEXT_ADDON[2] = "";
BRDAMAGETEXT_ADDON[3] = "Perl_Target";
BRDAMAGETEXT_ADDON[4] = "Nurfed_UnitFrames";
BRDAMAGETEXT_ADDON[5] = "DiscordUnitFrames";
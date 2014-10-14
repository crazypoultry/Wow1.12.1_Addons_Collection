----------------------------------------------------------------------------------
--
-- GuildAdsSkillFrame.lua
--
-- Author: Zarkan, Fkaï of European Ner'zhul (Horde)
-- URL : http://guildads.sourceforge.net
-- Email : guildads@gmail.com
-- Licence: GPL version 2 (General Public License)
----------------------------------------------------------------------------------

GUILDADSSKILL_TAB_PROFESSION = 1;
GUILDADSSKILL_TAB_SKILL = 2;

GUILDADSSKILL_VALUE = 1;
GUILDADSSKILL_ITEM = 2;
 
local GUILDADS_NUM_GLOBAL_AD_BUTTONS = 21;
local GUILDADS_NUM_MY_AD_BUTTONS = 13;

local g_currentTab = GUILDADSSKILL_TAB_PROFESSION;

--- Index of the ad currently selected
local g_GlobalAdSelectedId, g_GlobalAdSelectedType;

--- Index of the title currently selected
local g_GlobalTitleSelectedId, g_GlobalTitleSelectedType;						
local skilldisplaymode = GUILDADSSKILL_VALUE;
--- Index of my ad currently selected

--- Local copy of TradeSkillTypeColor (available at load without Blizzard addon)
local TradeSkillTypeColor = { };
TradeSkillTypeColor["optimal"]	= { r = 1.00, g = 0.50, b = 0.25 };
TradeSkillTypeColor["medium"]	= { r = 1.00, g = 1.00, b = 0.00 };
TradeSkillTypeColor["easy"]		= { r = 0.25, g = 0.75, b = 0.25 };
TradeSkillTypeColor["trivial"]	= { r = 0.50, g = 0.50, b = 0.50 };
TradeSkillTypeColor["header"]	= { r = 1.00, g = 0.82, b = 0 };

local PROFESSION_ARRAY = {
	[1] = { 
		[1] = {["texture"]="Interface\\Icons\\Trade_Herbalism",["id"]=1,["selected"]=true},
		[2] = {["texture"]="Interface\\Icons\\Trade_Fishing",["id"]=10,["selected"]=true},
		[3] = {["texture"]="Interface\\Icons\\INV_Misc_Pelt_Wolf_01",["id"]=3,["selected"]=true}
		  },
	[2] = {	
		[1] = {["texture"]="Interface\\Icons\\Trade_Alchemy",["id"]=4,["selected"]=true},
		[2] = {},
		[3] = {["texture"]="Interface\\Icons\\Trade_LeatherWorking",["id"]=7,["selected"]=true}
		  },
	[3] = {	
		[1] = {},
		[2] = {["texture"]="Interface\\Icons\\INV_Misc_Food_15",["id"]=12,["selected"]=true},
		[3] = {}
		  },
	[4] = {	
		[1] = {["texture"]="Interface\\Icons\\Trade_Mining",["id"]=2,["selected"]=true},
		[2] = {},
		[3] = {["texture"]="Interface\\Icons\\Trade_Tailoring",["id"]=8,["selected"]=true}},
	[5] = {	
		[1] = {["texture"]="Interface\\Icons\\Trade_BlackSmithing",["id"]=5,["selected"]=true},
		[2] = {["texture"]="Interface\\Icons\\Trade_Engineering",["id"]=6,["selected"]=true},
		[3] = {}},
	[6] = { 
		[1] = {["texture"]="Interface\\Icons\\Trade_Engraving",["id"]=9,["selected"]=true},
		[2] = {["texture"]="Interface\\Icons\\Spell_Holy_SealOfSacrifice",["id"]=11,["selected"]=true},
		[3] = {["texture"]="Interface\\Icons\\INV_Misc_Key_03",["id"]=13,["selected"]=true}}
}
	
local SKILL_ARRAY = {
	[1] = { 
		[1] = {["texture"]="Interface\\Icons\\Trade_Herbalism",["id"]=20,["selected"]=true},
		[2] = {},
		[3] = {}
		  },
	[2] = {	
		[1] = {["texture"]="Interface\\Icons\\INV_Sword_04",["id"]=22,["selected"]=true},
		[2] = {["texture"]="Interface\\Icons\\INV_Sword_04",["id"]=23,["selected"]=true},
		[3] = {["texture"]="Interface\\Icons\\INV_Weapon_Rifle_01",["id"]=31,["selected"]=true}
		  },
	[3] = {	
		[1] = {["texture"]="Interface\\Icons\\INV_Mace_04",["id"]=24,["selected"]=true},
		[2] = {["texture"]="Interface\\Icons\\INV_Mace_04",["id"]=25,["selected"]=true},
		[3] = {["texture"]="Interface\\Icons\\INV_Weapon_Bow_01",["id"]=32,["selected"]=true}
		  },
	[4] = {	
		[1] = {["texture"]="Interface\\Icons\\INV_Axe_04",["id"]=26,["selected"]=true},
		[2] = {["texture"]="Interface\\Icons\\INV_Axe_04",["id"]=27,["selected"]=true},
		[3] = {["texture"]="Interface\\Icons\\INV_Weapon_Crossbow_01",["id"]=33,["selected"]=true}},
	[5] = {	
		[1] = {["texture"]="Interface\\Icons\\INV_Weapon_ShortBlade_01",["id"]=21,["selected"]=true},
		[2] = {["texture"]="Interface\\Icons\\INV_Weapon_Halbard_01",["id"]=28,["selected"]=true},
		[3] = {["texture"]="Interface\\Icons\\INV_ThrowingKnife_02",["id"]=30,["selected"]=true}},
	[6] = { 
		[1] = {},
		[2] = {["texture"]="Interface\\Icons\\INV_Staff_04",["id"]=29,["selected"]=true},
		[3] = {["texture"]="Interface\\Icons\\INV_Wand_04",["id"]=34,["selected"]=true}
}}

	
GuildAdsSkill = {
	metaInformations = { 
		name = "Skill",
        guildadsCompatible = 100,
		ui = {
			main = {
				frame = "GuildAdsSkillFrame",
				tab = "GuildAdsSkillTab",
				tooltip = "Skill tab",
				priority = 2
			}
		}
	};
	
	GUILDADS_ADBUTTONSIZEY = 16;
	
	onInit = function()
		if not GuildAdsSkill.getProfileValue(nil, "Filters") then
			GuildAdsSkill.setProfileValue(nil, "Filters",  
				{
					[4] = true, [5] = true, [6] = true,   
					[7] = true,  [8] = true, [9] = true,
					[13] = true
				}
			);
		end
		
		GuildAdsDB.profile.Skill:registerEvent(GuildAdsSkill.onDBUpdate);
	end;
	
	onDBUpdate = function(dataType, playerName, id)
		GuildAdsSkill_UpdateGlobalAdButtons(true);
	end;
	
	onShow = function()
		if (g_currentTab == GUILDADSSKILL_TAB_PROFESSION) then
			PrepareProfessionTab();
		elseif (g_currentTab == GUILADSSKILL_TAB_SKILL) then
			PrepareSkillTab();
		end
		GuildAdsSkill_update();
	end;
	
	data = {
	
		cache = nil;
		
		resetCache = function()
			GuildAdsSkill.data.cache = nil;
		end;
		
		get = function(updateData)	
			if not GuildAdsSkill.data.cache or updateData then
				GuildAdsSkill.debug("reset cache");
				local between;
				
				GuildAdsSkill.data.cache = {};

				-- for each skill
				for id, name in pairs(GUILDADS_SKILLS) do
					if between then
						tinsert(GuildAdsSkill.data.cache, {i=id} );
						between = nil;
					end
					if GuildAdsSkill.getProfileValue("Filters", id) then
						-- for each player
						for playerName, _, data in GuildAdsSkillDataType:iterator(nil, id) do
							tinsert(GuildAdsSkill.data.cache, {i=id, p=playerName, v=data.v, m=data.m });
							between = true;
						end
					end
				end
				
				GuildAdsSkill.sortData.doIt(GuildAdsSkill.data.cache);
			end
			return GuildAdsSkill.data.cache;
		end;
	
	};
	
	
	tradedata = {
	
		cache = nil;
		
		resetCache = function()
			GuildAdsSkill.tradedata.cache = nil;
		end;
		
		get = function(updateData)	
			if not GuildAdsSkill.tradedata.cache or updateData then
				GuildAdsSkill.debug("reset cache");
				local between;
--~ 				GuildAdsDB.profile.dataType;
				GuildAdsSkill.tradedata.cache = {};
				
				for id, name in pairs(GUILDADS_SKILLS) do
					if between then
						tinsert(GuildAdsSkill.tradedata.cache, {i=id} );
						between = nil;
					end
					if GuildAdsSkill.getProfileValue("Filters", id) then
						-- for each player
						GuildAdsSkill.debug("current Filter"..id);
						for playerName, _, data in GuildAdsDB.profile.TradeSkill:iterator(nil,id) do
							tinsert(GuildAdsSkill.tradedata.cache, {i=id, p=playerName});
							between = true;
						end
					end
				end
				
				
				
				-- for each skill
--~ 				for id, name in pairs(GUILDADS_SKILLS) do
--~ 					GuildAdsSkill.debug("salut");
--~ 					if between then
--~ 						tinsert(GuildAdsSkill.tradedata.cache, {i=id} );
--~ 						between = nil;
--~ 					end
--~ 					
--~ 					if GuildAdsSkill.getProfileValue("Filters", id) then
--~ 						GuildAdsSkill.debug("toi"..id);
--~ 						-- for each player
--~ 						for playerName, _, data in GuildAdsTradeSkillDataType:iterator(nil, id) do
--~ 							tinsert(GuildAdsSkill.tradedata.cache, {i=id, p=playerName});
--~ 							between = true;
--~ 						end
--~ 					end
--~ 				end
				
--~ 				GuildAdsSkill.sorttradeData.doIt(GuildAdsSkill.tradedata.cache);
			end
			return GuildAdsSkill.tradedata.cache;
		end;
	
	};
	
	
	sortData = {
		doIt = function(adTable)
 			table.sort(adTable, GuildAdsSkill.sortData.predicate);
		end;
		
		predicate = function(a, b)
			--
			-- nil references are always less than
			--
			if (a == nil) then
				if (b == nil) then
					-- a==nil, b==nil
					return false;
				else
					-- a==nil, b~=nil
					return true;
				end
			elseif (b == nil) then
				-- a~=nil, b==nil
				return false;
			end
			
			if a==false or b==false then
				return false;
			end
		
			if a.i and b.i then
				--
				-- Sort by skill name (ie id)
				--
				if (a.i < b.i) then
					return true;
				elseif (a.i > b.i) then
					return false;
				end
			end
			
			if (a.v and b.v) then
				--
				-- Sort by skill rank
				--		
				if (a.v < b.v) then
					return false;
				elseif (a.v > b.v) then
					return true;
				end
			else
				if not a.v and b.v then
					return false;
				elseif a.v and not b.v then
					return true;
				end
			end
	
			--
			-- Sort by owner next
			--
			aowner = a.p or "";
			bowner = b.p or "";
		
			if (aowner < bowner) then
				return true;
			elseif (aowner > bowner) then
				return false;
			end

			-- These ads are identical
			return false;
		end;
	};
	
	
	sorttradeData = {
		doIt = function(adTable)
 			table.sort(adTable, GuildAdsSkill.sorttradeData.predicate);
		end;
		
		predicate = function(a, b)
			--
			-- nil references are always less than
			--
			if (a == nil) then
				if (b == nil) then
					-- a==nil, b==nil
					return false;
				else
					-- a==nil, b~=nil
					return true;
				end
			elseif (b == nil) then
				-- a~=nil, b==nil
				return false;
			end
			
			if a==false or b==false then
				return false;
			end
		
			if a.i and b.i then
				--
				-- Sort by skill name (ie id)
				--
				if (a.i < b.i) then
					return true;
				elseif (a.i > b.i) then
					return false;
				end
			end
			
			if (a.v and b.v) then
				--
				-- Sort by skill rank
				--		
				if (a.v < b.v) then
					return false;
				elseif (a.v > b.v) then
					return true;
				end
			else
				if not a.v and b.v then
					return false;
				elseif a.v and not b.v then
					return true;
				end
			end
	
			--
			-- Sort by owner next
			--
			aowner = a.p or "";
			bowner = b.p or "";
		
			if (aowner < bowner) then
				return true;
			elseif (aowner > bowner) then
				return false;
			end

			-- These ads are identical
			return false;
		end;
	};
	
}

---------------------------------------------------------------------------------
--
-- Init
--
---------------------------------------------------------------------------------
function GuildAdsSkillFrame_Init()
	-- No selection
	g_GlobalAdSelectedId = 0;
	g_GlobalAdSelectedType = 0;
	g_GlobalTitleSelectedId = 0;
	g_GlobalTitleSelectedType = 0;

	g_currentTab = GUILDADSSKILL_TAB_PROFESSION;
	PanelTemplates_SelectTab(GuildAds_MySkillTab1);
	PanelTemplates_DeselectTab(GuildAds_MySkillTab2);
	PrepareProfessionTab();
	GuildListAdProfessionListFrame:Show();
end

---------------------------------------------------------------------------------
--
-- Select a tab (ask / have / my)
--
---------------------------------------------------------------------------------	
function GuildAdsSkill_update() 
	GuildAdsSkill_UpdateGlobalAdButtons(true);
end

function SetProfessionButtonLocation(button, tier, column)
	column = ((column - 1) * 63) + 50;
	tier = -((tier - 1) * 63) - 100;
	button:SetPoint("TOPLEFT", "GuildAdsMainWindowFrame", "TOPLEFT", column, tier);
end

function SetItemProfessionButtonTexture(button, texture)
	if ( not button ) then
		return;
	end
	if ( texture ) then
		getglobal(button:GetName().."IconTexture"):Show();
	else
		getglobal(button:GetName().."IconTexture"):Hide();
	end
	getglobal(button:GetName().."IconTexture"):SetTexture(texture);
end
 local textureIndex = 1;
function ProfessionFrame_SetBranchTexture(tier, column, texCoords, xOffset, yOffset)
	local branchTexture = ProfessionFrame_GetBranchTexture();
	branchTexture:SetTexCoord(texCoords[1], texCoords[2], texCoords[3], texCoords[4]);
	branchTexture:SetPoint("TOPLEFT", "GuildAdsMainWindowFrame", "TOPLEFT", xOffset, yOffset);
end
function ProfessionFrame_GetBranchTexture()
	local branchTexture = getglobal("ProfessionFrameBranch"..textureIndex);
	textureIndex = textureIndex + 1;
	if ( not branchTexture ) then
		_ERRORMESSAGE("Not enough branch textures");
	else
		branchTexture:Show();
		return branchTexture;
	end
end

function GuildAdsSkill_ProfessionAdButton_OnEnter(myProfessionID) 


local indice = 1;
	for i =1, 6 do
		for j=1, 3 do
		button = getglobal("GuildAdsProfessionButton"..indice);
		if (g_currentTab == GUILDADSSKILL_TAB_PROFESSION) then
	       node = PROFESSION_ARRAY[i][j]; 
		elseif (g_currentTab == GUILDADSSKILL_TAB_SKILL) then
		   node = SKILL_ARRAY[i][j]; 
		end
		if (node["texture"]) then
			if (indice == myProfessionID) then
				if (node["id"]) then
					GameTooltip:SetOwner(button,"ANCHOR_BOTTOMRIGHT");
					GameTooltip:AddLine(GUILDADS_SKILLS[node["id"]], 1.0, 1.0, 1.0);
					GameTooltip:Show();
				end
			end
		end
		indice = indice + 1;
		end
	end

end

function GuildAdsSkill_Clear_OnClick() 
	local indice = 1;
	for i =1, 6 do
		for j=1, 3 do
		button = getglobal("GuildAdsProfessionButton"..indice);
		if (g_currentTab == GUILDADSSKILL_TAB_PROFESSION) then
	       node = PROFESSION_ARRAY[i][j]; 
		elseif (g_currentTab == GUILDADSSKILL_TAB_SKILL) then
		   node = SKILL_ARRAY[i][j]; 
		end
		slot = getglobal("GuildAdsProfessionButton"..indice.."Slot");
		if (node["texture"]) then
				GuildAdsSkill.setProfileValue("Filters", node["id"], nil);
				SetItemButtonDesaturated(button, 1, 0.4, 0.4, 0.4);
				slot:SetVertexColor(0.4, 0.4, 0.4);
				node["selected"] = false;
		end
		indice = indice + 1;
		end
	end
	GuildAdsSkill_UpdateGlobalAdButtons(true);
end


function GuildAdsSkill_All_OnClick() 
	local indice = 1;
	for i =1, 6 do
		for j=1, 3 do
		button = getglobal("GuildAdsProfessionButton"..indice);
		if (g_currentTab == GUILDADSSKILL_TAB_PROFESSION) then
	       node = PROFESSION_ARRAY[i][j]; 
		elseif (g_currentTab == GUILDADSSKILL_TAB_SKILL) then
		   node = SKILL_ARRAY[i][j]; 
		end
		slot = getglobal("GuildAdsProfessionButton"..indice.."Slot");
		if (node["texture"]) then
		    	GuildAdsSkill.setProfileValue("Filters", node["id"], true);
				SetItemButtonDesaturated(button, nil);
				slot:SetVertexColor(1.0, 0.82, 0);
				node["selected"] = true;
		end
		indice = indice + 1;
		end
	end
	GuildAdsSkill_UpdateGlobalAdButtons(true);
end


function GuildAdsSkill_ProfessionAdButton_OnClick(myProfessionID) 
	local indice = 1;
	for i =1, 6 do
		for j=1, 3 do
		button = getglobal("GuildAdsProfessionButton"..indice);
		if (g_currentTab == GUILDADSSKILL_TAB_PROFESSION) then
	       node = PROFESSION_ARRAY[i][j]; 
		elseif (g_currentTab == GUILDADSSKILL_TAB_SKILL) then
		   node = SKILL_ARRAY[i][j]; 
		end
		slot = getglobal("GuildAdsProfessionButton"..indice.."Slot");
		if (node["texture"]) then
		    if (indice == myProfessionID) then
				if (node["selected"]) then
					GuildAdsSkill.setProfileValue("Filters", node["id"], nil);
					SetItemButtonDesaturated(button, 1, 0.4, 0.4, 0.4);
					slot:SetVertexColor(0.4, 0.4, 0.4);
					node["selected"] = false;
				else
					GuildAdsSkill.setProfileValue("Filters", node["id"], true);
					SetItemButtonDesaturated(button, nil);
					slot:SetVertexColor(1.0, 0.82, 0);
					node["selected"] = true;
				end
			else 
--~ 				if (not IsControlKeyDown()) then
--~ 					GuildAdsSkill.setProfileValue("Filters", node["id"], nil);
--~ 					SetItemButtonDesaturated(button, 1, 0.4, 0.4, 0.4);
--~ 					slot:SetVertexColor(0.4, 0.4, 0.4);
--~ 					node["selected"]= false;
--~ 				end
			end
		end
		indice = indice + 1;
		end
	end
	GuildAdsSkill_UpdateGlobalAdButtons(true);
end

function PrepareProfessionTab() 
	for i = 20 , 34 do
		GuildAdsSkill.setProfileValue("Filters", i, nil);
	end
	local indice = 1;
	textureIndex = 1;
	local test = 1;
	   for i =1, 6 do
		for j=1, 3 do
			node = PROFESSION_ARRAY[i][j];
	    	button = getglobal("GuildAdsProfessionButton"..indice);
			slot = getglobal("GuildAdsProfessionButton"..indice.."Slot");
			if (node["texture"]) then
				SetProfessionButtonLocation(button,i,j);
				SetItemProfessionButtonTexture(button,node["texture"]);
				if (node["selected"]==true) then
					GuildAdsSkill.setProfileValue("Filters", node["id"], true);
					slot:SetVertexColor(1.0, 0.82, 0);
					SetItemButtonDesaturated(button, nil);
				else
					GuildAdsSkill.setProfileValue("Filters", node["id"], nil);
					slot:SetVertexColor(0.4, 0.4, 0.4);
					SetItemButtonDesaturated(button, 1, 0.4, 0.4, 0.4);
					
				end
				button:Show();
			else 
			button:Hide();
			end
			indice = indice + 1;
		end
	end
	if (skilldisplaymode==GUILDADSSKILL_VALUE) then
		GuildAdsSkill_UpdateGlobalAdButtons(true);
	else
		GuildAdsSkill_UpdateGlobalAdTradeSkillButtons(true);
	end
end

function PrepareSkillTab() 
	for i = 1 , 19 do
		GuildAdsSkill.setProfileValue("Filters", i, nil);
	end
	local indice = 1;
	textureIndex = 1;
	local test = 1;
	   for i =1, 6 do
		for j=1, 3 do
			node = SKILL_ARRAY[i][j];
	    	button = getglobal("GuildAdsProfessionButton"..indice);
			slot = getglobal("GuildAdsProfessionButton"..indice.."Slot");
			if (node["texture"]) then
				if (node["selected"]==true) then
					GuildAdsSkill.setProfileValue("Filters", node["id"], true);
					SetItemButtonDesaturated(button, nil);
					slot:SetVertexColor(1.0, 0.82, 0);
				else
					GuildAdsSkill.setProfileValue("Filters", node["id"], nil);
					SetItemButtonDesaturated(button, 1, 0.4, 0.4, 0.4);
					slot:SetVertexColor(0.4, 0.4, 0.4);
					
				end
				SetProfessionButtonLocation(button,i,j);
				SetItemProfessionButtonTexture(button,node["texture"]);
				button:Show();
			else 
			button:Hide();
			end
			indice = indice + 1;
		end
	end
	GuildAdsSkill_UpdateGlobalAdButtons(true);
end

function GuildSkillToggleButton_OnClick() 
	if (skilldisplaymode==GUILDADSSKILL_VALUE) then
		skilldisplaymode = GUILDADSSKILL_ITEM;
		GuildAdsSkill_UpdateGlobalAdTradeSkillButtons(true);
	else
		skilldisplaymode = GUILDADSSKILL_VALUE;
		GuildAdsSkill_UpdateGlobalAdButtons(true);
	end
	
end

function GuildAdsSkillFrame_SelectTab(tab)
	g_currentTab = tab;
	if (tab == GUILDADSSKILL_TAB_PROFESSION) then
		PanelTemplates_SelectTab(GuildAds_MySkillTab1);
		PanelTemplates_DeselectTab(GuildAds_MySkillTab2);
		PrepareProfessionTab();
		GuildListAdProfessionListFrame:Show();
--~ 		GuildAdsSkillAdToggleButton:Show();
	elseif (tab == GUILDADSSKILL_TAB_SKILL) then 
		PanelTemplates_SelectTab(GuildAds_MySkillTab2);
		PanelTemplates_DeselectTab(GuildAds_MySkillTab1);
		PrepareSkillTab();
		GuildListAdProfessionListFrame:Show();
--~ 		GuildAdsSkillAdToggleButton:Hide();
	
	end
	g_GlobalAdSelected = 0;
	g_GlobalTitleSelectedId = 0;
	g_GlobalTitleSelectedType = 0;
end

---------------------------------------------------------------------------------
--
-- Filter
--
---------------------------------------------------------------------------------


---------------------------------------------------------------------------------
--
-- Update one global ad button
--
---------------------------------------------------------------------------------

function GuildAdsSkillFrame_UpdateGlobalAdButton(button, selected, info)
	-- paranoia
	if (not button) then
		GuildAdsSkill.debug("GuildAds_UpdateAdButtonForAd: button is nil");
		error("GuildAds_UpdateAdButtonForAd: button is nil", 2);
		return;
	end

	local buttonName= button:GetName();
	local ownerColor = GuildAdsUITools.onlineColor[GuildAdsComm:IsOnLine(info.p)];

	local ownerField = buttonName.."Owner";
	local skillBar = buttonName.."SkillBar";
	local skillName = skillBar.."SkillName";
	local skillRank = skillBar.."SkillRank";
	
	getglobal(ownerField):SetText(info.p);
	getglobal(ownerField):SetTextColor(ownerColor["r"], ownerColor["g"], ownerColor["b"]);
	getglobal(skillName):SetText(GuildAdsSkillDataType:getNameFromId(info.i));
	
	if (info.v) then
			
		if (info.m == 300 ) then 
			getglobal(skillBar):SetStatusBarColor(TradeSkillTypeColor["optimal"].r,TradeSkillTypeColor["optimal"].g,TradeSkillTypeColor["optimal"].b);
		else
			if (info.m >= 225 ) then 
				getglobal(skillBar):SetStatusBarColor(TradeSkillTypeColor["medium"].r,TradeSkillTypeColor["medium"].g,TradeSkillTypeColor["medium"].b);
			else
				if (info.m >= 150) then
					getglobal(skillBar):SetStatusBarColor(TradeSkillTypeColor["easy"].r,TradeSkillTypeColor["easy"].g,TradeSkillTypeColor["easy"].b);
				else
					if (info.m >= 75) then
						getglobal(skillBar):SetStatusBarColor(TradeSkillTypeColor["trivial"].r,TradeSkillTypeColor["trivial"].g,TradeSkillTypeColor["trivial"].b);
					end
				end 
			end
		end
		
		getglobal(skillBar):SetValue(info.v);
		getglobal(skillRank):SetText(info.v.."/"..info.m);
	else
		getglobal(skillBar):SetValue(1);
		getglobal(skillRank):SetText("");
	end

	getglobal(ownerField):Show();
	getglobal(skillBar):Show();
end

function GuildAdsSkillFrame_UpdateAdButtonForTitle(button, selected, info)
	local buttonName = button:GetName();
		
	local ownerField = buttonName.."Owner";
	local skillBar = buttonName.."SkillBar";
	
	getglobal(ownerField):Hide();
	getglobal(skillBar):Hide();
	button:UnlockHighlight();
end

---------------------------------------------------------------------------------
--
-- Update global ad buttons in the UI
-- 
---------------------------------------------------------------------------------
function GuildAdsSkill_UpdateGlobalAdButtons(updateData)
	if GuildAdsSkillFrame:IsVisible() then
		local offset = FauxScrollFrame_GetOffset(GuildAdsSkillAdScrollFrame);
		
		local linear = GuildAdsSkill.data.get(updateData);
		local linearSize = table.getn(linear);
	
		-- init
		local i = 1;
		local j = i + offset;
		GuildAdsSkill.debug("GuildAdsSkill_UpdateGlobalAdButtons");
		-- for each buttons
		while (i <= GUILDADS_NUM_GLOBAL_AD_BUTTONS) do
			local button = getglobal("GuildAdsSkillAdButton"..i);
			
			if (j <= linearSize) then
				if (linear[j].p) then
					-- update internal data
					button.player = linear[j].p;
					button.id = linear[j].i;
					
					-- create a ads
					GuildAdsSkillFrame_UpdateGlobalAdButton(button, g_GlobalAdSelectedId==linear[j].i, linear[j]);
				else
					-- update internal data
					button.player = nil;
					button.id = nil;
					
					-- empty line
					GuildAdsSkillFrame_UpdateAdButtonForTitle(button, false , linear[j]);
				end
				button:Show();
				j = j+1;
			else
				button:Hide();
			end
		
			i = i+1;
		end
	
		FauxScrollFrame_Update(GuildAdsSkillAdScrollFrame, linearSize, GUILDADS_NUM_GLOBAL_AD_BUTTONS, GuildAdsSkill.GUILDADS_ADBUTTONSIZEY);
	else
		-- update another tab than the visible one
		if updateData then
			-- but data needs to be reset
			GuildAdsSkill.data.resetCache();
		end
	end
end

function GuildAdsSkill_UpdateGlobalAdTradeSkillButtons(updateData)
	if GuildAdsSkillFrame:IsVisible() then
		local offset = FauxScrollFrame_GetOffset(GuildAdsSkillAdScrollFrame);
		
		local linear = GuildAdsSkill.tradedata.get(updateData);
		local linearSize = table.getn(linear);
	
		-- init
		local i = 1;
		local j = i + offset;
		GuildAdsSkill.debug("GuildAdsSkill_UpdateGlobalAdButtons");
		-- for each buttons
		while (i <= GUILDADS_NUM_GLOBAL_AD_BUTTONS) do
			local button = getglobal("GuildAdsSkillAdButton"..i);
			
			if (j <= linearSize) then
				if (linear[j].p) then
					-- update internal data
					button.player = linear[j].p;
					button.id = linear[j].i;
					
					-- create a ads
					GuildAdsSkillFrame_UpdateGlobalAdButton(button, g_GlobalAdSelectedId==linear[j].i, linear[j]);
				else
					-- update internal data
					button.player = nil;
					button.id = nil;
					
					-- empty line
					GuildAdsSkillFrame_UpdateAdButtonForTitle(button, false , linear[j]);
				end
				button:Show();
				j = j+1;
			else
				button:Hide();
			end
		
			i = i+1;
		end
	
		FauxScrollFrame_Update(GuildAdsSkillAdScrollFrame, linearSize, GUILDADS_NUM_GLOBAL_AD_BUTTONS, GuildAdsSkill.GUILDADS_ADBUTTONSIZEY);
	else
		-- update another tab than the visible one
		if updateData then
			-- but data needs to be reset
			GuildAdsSkill.data.resetCache();
		end
	end
end

---------------------------------------------------------------------------------
--
-- Called when a global ad is clicked
-- 
---------------------------------------------------------------------------------
function GuildAdsSkill_GlobalAdButton_OnClick(button)
	if this.idAd then
		-- an ad was clicked
		local newSelectedId = this.idAd;
		if this.idAd~=g_GlobalAdSelectedId or this.adType~=g_GlobalAdSelectedType then
			g_GlobalAdSelectedId = this.idAd;
			g_GlobalAdSelectedType = this.adType;
			
			g_GlobalTitleSelectedId = 0;
			g_GlobalTitleSelectedType = 0;
			GuildAdsSkill_UpdateGlobalAdButtons();
		end
	end
	if button == "RightButton" then
		GuildAdsFromAdsMenu.groupId = this.groupId;
		GuildAdsFromAdsMenu.idAd = this.idAd;
		GuildAdsFromAdsMenu.adType = this.adType;
		ToggleDropDownMenu(1, nil, GuildAdsFromAdsMenu, "cursor");
	end
end

---------------------------------------------------------------------------------
--
-- Register plugin
-- 
---------------------------------------------------------------------------------
GuildAdsPlugin.UIregister(GuildAdsSkill);
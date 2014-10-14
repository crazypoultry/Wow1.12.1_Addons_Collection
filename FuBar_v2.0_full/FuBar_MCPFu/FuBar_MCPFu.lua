local dewdrop = AceLibrary("Dewdrop-2.0")
local tablet = AceLibrary("Tablet-2.0")
local L = AceLibrary("AceLocale-2.0"):new("MCPFu")

ADDON_LOADED = L["LOADED"];
ADDON_WILL_NOT_LOAD = L["WILL_NOT_LOAD"];
ADDON_REFUSE_TO_LOAD = L["DISABLED_IN_MCP"];

local optionsTable = {
	type = 'group',	
	args = {
		showEnabled = {
			order = 8,
			type = 'toggle',
			name = L["OPT_SHOW_ENABLED"],
			desc = L["OPT_SHOW_ENABLED_DESC"],
			get = function()
				return MCPFu.db.profile.showEnabled
			end,
			set = function(value)
				MCPFu.db.profile.showEnabled = value;				
				MCPFu:UpdateText();
			end,
			disabled = function()
				if MCPFu.db.profile.showText then
					return false;
				else
					return true;
				end
			end						
		},						
		showSecurity = {
			order = 9,
			type = 'toggle',
			name = L["OPT_SHOW_SECURITY"],
			desc = L["OPT_SHOW_SECURITY_DESC"],
			get = function()
				return MCPFu.db.profile.showSecurity
			end,
			set = function(value)
				MCPFu.db.profile.showSecurity = value;				
			end
		},				
		showNotes = {
			order = 10,
			type = 'toggle',
			name = L["OPT_SHOW_NOTES"],
			desc = L["OPT_SHOW_NOTES_DESC"],
			get = function()
				return MCPFu.db.profile.showNotes
			end,
			set = function(value)
				MCPFu.db.profile.showNotes = value;				
			end
		},		
		maxNoteLength = {
			type = 'range',
			name = L["OPT_NOTE_LEN"],
			desc = L["OPT_NOTE_LEN_DESC"],
			get = function()
				return MCPFu.db.profile.maxChars;
			end,
			set = function(v)
				MCPFu.db.profile.maxChars = v
			end,
			disabled = function()
				if MCPFu.db.profile.showNotes then
					return false;
				else
					return true;
				end
			end,			
			min = 20,
			max = 100,
			step = 5,
			order = 11
		},		
	}	
}

MCPFu = AceLibrary("AceAddon-2.0"):new("FuBarPlugin-2.0", "AceEvent-2.0", "AceConsole-2.0", "AceDB-2.0", "AceHook-2.0")
MCPFu.hasIcon = true
MCPFu.clickableTooltip = true

MCPFu.OnMenuRequest = optionsTable
MCPFu:RegisterChatCommand( { "/MCPFu" }, optionsTable )

MCPFu:RegisterDB("MCPFuDB")
MCPFu:RegisterDefaults('profile', {
	showNotes = false,
	maxChars = 20,
	showSecurity = nil,
	showEnabled = 1,
	addonConfig = {},
	blizzard_addons = { 
	"Blizzard_AuctionUI",
	"Blizzard_BattlefieldMinimap",
	"Blizzard_BindingUI",
	"Blizzard_CraftUI",
	"Blizzard_InspectUI",
	"Blizzard_MacroUI",
	"Blizzard_RaidUI",
	"Blizzard_TalentUI",
	"Blizzard_TradeSkillUI",
	"Blizzard_TrainerUI",
	};
	blizzard_addons_titles = { 
	"Blizzard: Auction",
	"Blizzard: Battlefield Minimap",
	"Blizzard: Binding",
	"Blizzard: Craft",
	"Blizzard: Inspect",
	"Blizzard: Macro",
	"Blizzard: Raid",
	"Blizzard: Talent",
	"Blizzard: Trade Skill",
	"Blizzard: Trainer",
	};	
})

-- Methods
function MCPFu:OnInitialize()
end
	
function MCPFu:OnEnable()
  self:Hook("LoadAddOn");  
end

function MCPFu:LoadAddOn(name)
	if (not IsAddOnLoaded(name) and self.db.profile.addonConfig and self.db.profile.addonConfig[name]) then
		--DEFAULT_CHAT_FRAME:AddMessage("MCPFu : Refusing to load : "..name)
		return nil, "REFUSE_TO_LOAD";
	else
		--DEFAULT_CHAT_FRAME:AddMessage("MCPFu : Allowing to load : "..name)
		return self.hooks.LoadAddOn.orig(name);
	end
end


function MCPFu:OnDisable()
	-- you do not need to unregister the event here, all events/hooks are unregistered on disable implicitly.
end
	
function MCPFu:OnTextUpdate()
	self:SetText("MCP");
	
	if (not self.db.profile.showEnabled) or (not self.db.profile.showText) then
		return;
	end
	
	local numEnabled = 0;
	local numAddons = GetNumAddOns();
	local origNumAddons = numAddons;
	numAddons = numAddons + table.getn(self.db.profile.blizzard_addons);
	
	for i = 1, numAddons, 1 do		
		
		local name, enabled;
		if (i > origNumAddons) then
			name = self.db.profile.blizzard_addons[(i-origNumAddons)];
			if (self.db.profile.addonConfig and self.db.profile.addonConfig[name]) then
			else
				numEnabled = numEnabled + 1;
			end
		else
			name, title, notes, enabled, loadable, reason, security = GetAddOnInfo(i);
		end
						
		if (enabled) then
			numEnabled = numEnabled + 1;
		end	
	end
	self:SetText(numEnabled.."/"..numAddons);
end

function MCPFu:OnItemClick(index,enabled)
	--DEFAULT_CHAT_FRAME:AddMessage("Checking : "..index)
	if (IsShiftKeyDown()) then
		UIParentLoadAddOn(index);
		return;
	end
	
	if (type(index) == "number") then
		--DEFAULT_CHAT_FRAME:AddMessage("Addon : "..index);
		if (not enabled) then
			EnableAddOn(index)
		else
			DisableAddOn(index)
		end
	else
		--DEFAULT_CHAT_FRAME:AddMessage("Blizzard 1 : "..index)
		if (not enabled) then
			if (self.db.profile.addonConfig) then
				self.db.profile.addonConfig[index] = nil;
			end
		else
			--DEFAULT_CHAT_FRAME:AddMessage("Blizzard 2 : "..index)
			if (not self.db.profile.addonConfig) then self.db.profile.addonConfig = {}; end
			self.db.profile.addonConfig[index] = true;
		end
	end
end

function MCPFu:OnTooltipUpdate()
	
	local cat = tablet:AddCategory(
		'columns', 4,
		'child_textR', 1,
		'child_textG', 1,
		'child_textB', 1
	)
	
	local numAddons = GetNumAddOns();
	local origNumAddons = numAddons;
	numAddons = numAddons + table.getn(self.db.profile.blizzard_addons);
	
	for i = 1, numAddons, 1 do		
		local line = {};	
			
		line['func'] = 'OnItemClick'
		line['arg1'] = self			
		line['arg2'] = i												
		
		local name, title, notes, enabled, loadable, reason, security;
		if (i > origNumAddons) then
			name = self.db.profile.blizzard_addons[(i-origNumAddons)];
			title = self.db.profile.blizzard_addons_titles[(i-origNumAddons)];
			notes = "";
			line['arg2'] = name
			if (self.db.profile.addonConfig and self.db.profile.addonConfig[name]) then
				--DEFAULT_CHAT_FRAME:AddMessage("Blizzard : "..name)
				enabled = nil;
				loadable = nil;
				reason = "WILL_NOT_LOAD";
			else
				enabled = 1;
				loadable = 1;
			end
			if (IsAddOnLoaded(name)) then
				reason = "LOADED";
				loadable = 1;
			end
			security = "SECURE";
		else
			name, title, notes, enabled, loadable, reason, security = GetAddOnInfo(i);
		end
		
		--if title and notes then
			--DEFAULT_CHAT_FRAME:AddMessage("Adding : "..title.." - "..notes)
		--end
		local loaded = IsAddOnLoaded(name);
		local ondemand = IsAddOnLoadOnDemand(name);
		if (loadable) then
			line['textR'] = 1;
			line['textG'] = 0.78;
			line['textB'] = 0;								
		elseif (enabled and reason ~= "DEP_DISABLED") then
			line['textR'] = 1;
			line['textG'] = 0.1;
			line['textB'] = 0.1;								
		else
			line['textR'] = 0.5;
			line['textG'] = 0.5;
			line['textB'] = 0.5;								
		end
		if (title) then
			line['text'] = title;
		else
			line['text'] = name;
		end
		if (title == "FuBar - |cffffffffMCP|r|cff00ff00Fu|r") then
			line['hasCheck'] = false							
		else
			line['hasCheck'] = true										
		end
		if (enabled) then
			line['checked'] = true			
		else
			line['checked'] = false
		end
		if (title == "FuBar - |cffffffffMCP|r|cff00ff00Fu|r") then
			line['hasCheck'] = false							
			line['checked'] = false -- make sure it cant be clicked off
		else
			line['hasCheck'] = true										
		end		
		if (self.db.profile.showSecurity) then
			if (security == "SECURE") then
				line['text3'] = L["SECURE"];				
			elseif (security == "INSECURE") then
				line['text3'] = L["INSECURE"];				
			elseif (security == "BANNED") then -- wtf?
				line['text3'] = L["BANNED"];				
			end
		end
		if (self.db.profile.showNotes) and notes then
			if (string.len(notes) > self.db.profile.maxChars) then
				line['text2'] = string.sub(notes,1,self.db.profile.maxChars-2).."..";				
			else
				line['text2'] = notes;				
			end
		end
		if (reason) then			
			line['text4'] = TEXT(getglobal("ADDON_"..reason));				
			if (reason == "DISABLED") or (reason == "WILL_NOT_LOAD") then
				line['checked'] = false				
--			else
	--			DEFAULT_CHAT_FRAME:AddMessage("Adding : "..title.." - "..reason)
			end			
		elseif (loaded) then
			line['text4'] = TEXT(ADDON_LOADED);				
		elseif (ondemand) then
			line['text4'] = L["ONDEMAND"];								
			line['text4R'] = 0;
			line['text4G'] = 1;
			line['text4B'] = 0;											
		else
			line['text4'] = "";												
		end
		if (not loaded and enabled and ondemand) then
			--loadnow:Show();
		else
			--loadnow:Hide();
		end
		line['arg3'] = line['checked']
		cat:AddLine(line)					
	end
	cat:AddLine(
		'text', ""
	)	
	
	cat:AddLine(
		'text', ""
	)			

	tablet:SetHint(L["HINT"])
end
	
function MCPFu:OnClick()
	if (IsAltKeyDown()) then
		ReloadUI();		
	end
end
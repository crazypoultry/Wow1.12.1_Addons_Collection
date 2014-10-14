local L = AceLibrary("AceLocale-2.2"):new("ReagentTracker")
local C = AceLibrary("Crayon-2.0");
local Co = AceLibrary("Compost-2.0");
ReagentTracker = AceLibrary("AceAddon-2.0"):new("AceConsole-2.0", "AceEvent-2.0", "AceDB-2.0", "FuBarPlugin-2.0");
ReagentTracker.alrdyW1 = false;
ReagentTracker.alrdyW2 = false;
ReagentTracker.alrdyW3 = false;
ReagentTracker.alrdyW4 = false;
ReagentTracker.alrdyW5 = false;
ReagentTracker.inited = false;
ReagentTracker.bagUcounts = 0;
ReagentTracker.iwvmax = 1000;
ReagentTracker.item1Count = 0;
ReagentTracker.item2Count = 0;
ReagentTracker.item3Count = 0;
ReagentTracker.item4Count = 0;
ReagentTracker.item5Count = 0;
ReagentTracker.version = "1.0";


ReagentTracker.options = { 
    type='group',
    args = {
	item1 = {
	    type = 'group',
	    name= "Item 1",
	    desc = L["OPT_ITEM1G_DESC"],
	    order = 1,
	    args = {
		item = {
            	    type = 'text',
            	    name = L["OPT_ITEM1_NAME"],
            	    desc = L["OPT_ITEM1_DESC"],
            	    usage = L["OPT_ITEM1_USAGE"],
            	    get = "GetItem1",
            	    set = "SetItem1",
		    order = 1,
        	}, --end item
		iwv = {
            	    type = 'range',
	   	     min = -1,
	  	     max = ReagentTracker.iwvmax,
		    step = 1,
          	     name = L["OPT_I1WV_NAME"],
		    order = 2,
            	    desc = L["OPT_I1WV_DESC"],
            	    usage = L["OPT_I1WV_USAGE"],
            	    get = function()
			    return ReagentTracker.db.char.item1.iwv
			end,
            	    set = function(newI1WV)
			    ReagentTracker.db.char.item1.iwv = newI1WV
			    ReagentTracker:UpdateItems();
			    ReagentTracker:UpdateText();
			end,
        	}, --end iwv
	    }, --end args
	}, --end item1
	item2 = {
	    type = 'group',
	    name= "Item 2",
	    desc = L["OPT_ITEM2G_DESC"],
	    order = 2,
	    args = {
		item = {
            	    type = 'text',
            	    name = L["OPT_ITEM2_NAME"],
            	    desc = L["OPT_ITEM2_DESC"],
            	    usage = L["OPT_ITEM2_USAGE"],
            	    get = "GetItem2",
            	    set = "SetItem2",
		    order = 1,
        	},
		iwv = {
            	    type = 'range',
	   	     min = -1,
	  	     max = ReagentTracker.iwvmax,
		    step = 1,
          	     name = L["OPT_I2WV_NAME"],
		    order = 2,
            	    desc = L["OPT_I2WV_DESC"],
            	    usage = L["OPT_I2WV_USAGE"],
            	    get = function()
			    return ReagentTracker.db.char.item2.iwv
			end,
            	    set = function(newI2WV)
			    ReagentTracker.db.char.item2.iwv = newI2WV
			    ReagentTracker:UpdateItems();
			    ReagentTracker:UpdateText();
			end,
        	},
	    },
	},
	item3 = {
	    type = 'group',
	    name= "Item 3",
	    desc = L["OPT_ITEM3G_DESC"],
	    order = 3,
	    args = {
		item = {
            	    type = 'text',
            	    name = L["OPT_ITEM3_NAME"],
            	    desc = L["OPT_ITEM3_DESC"],
            	    usage = L["OPT_ITEM3_USAGE"],
            	    get = "GetItem3",
            	    set = "SetItem3",
		    order = 1,
        	}, --end item
		iwv = {
            	    type = 'range',
	   	     min = -1,
	  	     max = ReagentTracker.iwvmax,
		    step = 1,
          	     name = L["OPT_I3WV_NAME"],
		    order = 2,
            	    desc = L["OPT_I3WV_DESC"],
            	    usage = L["OPT_I3WV_USAGE"],
            	    get = function()
			    return ReagentTracker.db.char.item3.iwv
			end,
            	    set = function(newI3WV)
			    ReagentTracker.db.char.item3.iwv = newI3WV
			    ReagentTracker:UpdateItems();
			    ReagentTracker:UpdateText();
			end,
        	}, --end iwv
	    }, --end args
	}, --end item3
	item4 = {
	    type = 'group',
	    name= "Item 4",
	    desc = L["OPT_ITEM4G_DESC"],
	    order = 4,
	    args = {
		item = {
            	    type = 'text',
            	    name = L["OPT_ITEM4_NAME"],
            	    desc = L["OPT_ITEM4_DESC"],
            	    usage = L["OPT_ITEM4_USAGE"],
            	    get = "GetItem4",
            	    set = "SetItem4",
		    order = 1,
        	}, --end item
		iwv = {
            	    type = 'range',
	   	     min = -1,
	  	     max = ReagentTracker.iwvmax,
		    step = 1,
          	     name = L["OPT_I4WV_NAME"],
		    order = 2,
            	    desc = L["OPT_I4WV_DESC"],
            	    usage = L["OPT_I4WV_USAGE"],
            	    get = function()
			    return ReagentTracker.db.char.item4.iwv
			end,
            	    set = function(newI4WV)
			    ReagentTracker.db.char.item4.iwv = newI4WV
			    ReagentTracker:UpdateItems();
			    ReagentTracker:UpdateText();
			end,
        	}, --end iwv
	    }, --end args
	}, --end item4
	item5 = {
	    type = 'group',
	    name= "Item 5",
	    desc = L["OPT_ITEM5G_DESC"],
	    order = 5,
	    args = {
		item = {
            	    type = 'text',
            	    name = L["OPT_ITEM5_NAME"],
            	    desc = L["OPT_ITEM5_DESC"],
            	    usage = L["OPT_ITEM5_USAGE"],
            	    get = "GetItem5",
            	    set = "SetItem5",
		    order = 1,
        	}, --end item
		iwv = {
            	    type = 'range',
	   	     min = -1,
	  	     max = ReagentTracker.iwvmax,
		    step = 1,
          	     name = L["OPT_I5WV_NAME"],
		    order = 2,
            	    desc = L["OPT_I5WV_DESC"],
            	    usage = L["OPT_I5WV_USAGE"],
            	    get = function()
			    return ReagentTracker.db.char.item5.iwv
			end,
            	    set = function(newI5WV)
			    ReagentTracker.db.char.item5.iwv = newI5WV
			    ReagentTracker:UpdateItems();
			    ReagentTracker:UpdateText();
			end,
        	}, --end iwv
	    }, --end args
	}, --end item5
	warnchat = {
	    type = 'toggle',
	    name = L["OPT_WARNCHAT_NAME"],
	    desc = L["OPT_WARNCHAT_DESC"],
	    order = 6,
	    get = function()
		    return ReagentTracker.db.char.warnchat
		end,
	    set = function()
		    ReagentTracker.db.char.warnchat = not ReagentTracker.db.char.warnchat
		    ReagentTracker:UpdateItems();
		    ReagentTracker:UpdateText();
		end,
	}, --end warnchat
	warnsct = {
	    type = 'toggle',
	    name = L["OPT_WARNSCT_NAME"],
	    desc = L["OPT_WARNSCT_DESC"],
	    order = 7,
	    get = function()
		    return ReagentTracker.db.char.warnsct
		end,
	    set = function()
		    ReagentTracker.db.char.warnsct = not ReagentTracker.db.char.warnsct
		    ReagentTracker:UpdateItems();
		    ReagentTracker:UpdateText();
		end,
	}, --end warnsct
	warnuie = {
	    type = 'toggle',
	    name = L["OPT_WARNUIE_NAME"],
	    desc = L["OPT_WARNUIE_DESC"],
	    order = 8,
	    get = function()
		    return ReagentTracker.db.char.warnuie
		end,
	    set = function()
		    ReagentTracker.db.char.warnuie = not ReagentTracker.db.char.warnuie
		    ReagentTracker:UpdateItems();
		    ReagentTracker:UpdateText();
		end,
	}, --end warnuie
	text = {
	    type = 'group',
	    name = 'Text',
	    desc = L["TEXT_DESC"],
	    order = 9,
	    args = {
		textrt = {
		    type = 'toggle',
		    name = L["TEXT_RT_NAME"],
		    desc = L["TEXT_RT_DESC"],
		    order = 1,
		    get = function()
			return ReagentTracker.db.char.text.textrt
		    end,
		    set = function()
			ReagentTracker.db.char.text.textrt = not ReagentTracker.db.char.text.textrt
			ReagentTracker.db.char.text.textfa = not ReagentTracker.db.char.text.textfa
			ReagentTracker:UpdateItems();
			ReagentTracker:UpdateText();
		    end,
		}, --end textrt
		textfa = {
		    type = 'toggle',
		    name = L["TEXT_FA_NAME"],
		    desc = L["TEXT_FA_DESC"],
		    order = 2,
		    get = function()
			return ReagentTracker.db.char.text.textfa
		    end,
		    set = function()
			ReagentTracker.db.char.text.textrt = not ReagentTracker.db.char.text.textrt
			ReagentTracker.db.char.text.textfa = not ReagentTracker.db.char.text.textfa
			ReagentTracker:UpdateItems();
			ReagentTracker:UpdateText();
		    end,
		}, --end textrt
	    }, --end args
	}, --end text
	itemnumber = {
	    type = 'range',
	    name = L["OPT_ITEMS_NAME"],
	    desc = L["OPT_ITEMS_DESC"],
	    order = 10,
	    min = 1,
	    max = 5,
	    step = 1,
	    get = function()
		    return ReagentTracker.db.char.itemnumber
		end,
	    set = function(newItems)
		    ReagentTracker:UpdateItems();
		    ReagentTracker.db.char.itemnumber = newItems
		    ReagentTracker:UpdateText();
		end,
	}, --end items
	predef = opt_predefitems,
	debug = {
	    type = 'toggle',
	    name = L["DEBUG_NAME"],
	    desc = L["DEBUG_DESC"],
	    order = 12,
	    get = function()
		return ReagentTracker.db.char.debug
	    end,
	    set = function()
		ReagentTracker.db.char.debug = not ReagentTracker.db.char.debug
		ReagentTracker:UpdateItems();
		ReagentTracker:UpdateText();
	    end,
	}, --end debug
    }, --end args
} --end tablet

ReagentTracker:RegisterChatCommand({L["SLASHCMD_LONG"], L["SLASHCMD_SHORT"]}, ReagentTracker.options);
ReagentTracker.OnMenuRequest = ReagentTracker.options;
ReagentTracker.hasIcon = "Interface\\Icons\\INV_Misc_Rune_06";
ReagentTracker:RegisterDB("ReagentTrackerDB", "ReagentTrackerDBPC");
ReagentTracker:RegisterDefaults("char", {
    item1 = { item = "Heavy Runecloth Bandage",
    	iwv = 5,},
    item2 = { item = "Runecloth",
    	iwv = 5,},
    item3 = { item = "Conjured Crystal Water",
    	iwv = 5,},
    item4 = { item = "Encrypted Twilight Text",
    	iwv = 5,},
    item5 = { item = "Nexus Crystal",
    	iwv = 5,},
    warnchat = false,
    warnsct = true,
    warnuie = false,
    text = { textrt = true,
    	textfa = false,},
    itemnumber = 5,
    debug = false,
} )
local tablet = AceLibrary("Tablet-2.0");

function ReagentTracker:OnEnable()
    self:RegisterEvent("BAG_UPDATE");
    self:RegisterEvent("BAG_OPEN");
    self:RegisterEvent("BAG_CLOSE");
    self:RegisterEvent("CHAT_MSG_COMBAT_FACTION_CHANGE");
    self:RegisterEvent("CHAT_MSG_ADDON");
    ra_items = Co:Acquire();
    ra_names = Co:Acquire();
end

function ReagentTracker:BAG_UPDATE()
    self:UpdateItems();
    self:UpdateText();
    ReagentTracker:Warn();
    if (self.bagUcounts < 3) then self.bagUcounts = self.bagUcounts + 1; else self.inited = true; end
end

function ReagentTracker:BAG_OPEN()
    self:UpdateItems();
    self:UpdateText();
    ReagentTracker:Warn();
end

function ReagentTracker:BAG_CLOSE()
    self:UpdateItems();
    self:UpdateText();
    ReagentTracker:Warn();
end

function ReagentTracker:CHAT_MSG_COMBAT_FACTION_CHANGE()
    self:UpdateItems();
    self:UpdateText();
    ReagentTracker:Warn();
end

function ReagentTracker:CHAT_MSG_ADDON(pref,msg,typ,sender)
	if (typ == "GUILD" or typ == "RAID") then
	if (pref == "RT") then
		if (msg == "getitems") then
			SendAddonMessage("RT",self.db.char.item1.item,typ);
		else
			ra_items[sender] = msg
		end
	end
	end
end

function ReagentTracker:SearchInvForItem(item)
 if ( not item ) then return; end
    item = string.lower(self:ItemLinkToName(item));
    local link, count, texture;
    local totalcount = 0;
    for i = 0,NUM_BAG_FRAMES do
        for j = 1,MAX_CONTAINER_ITEMS do
            link = GetContainerItemLink(i,j);
            if ( link ) then
                if ( item == string.lower(self:ItemLinkToName(link))) then
                    texture, count = GetContainerItemInfo(i,j);
                    totalcount = totalcount + count;
                end
            end
        end
    end
	if (self.db.char.debug == true) then
		self:Print("self:SearchInvForItem()..Done!");
	end
    return totalcount;
end

function ReagentTracker:ItemLinkToName(link)
	return gsub(link,"^.*%[(.*)%].*$","%1");
end

function ReagentTracker:GetItem1()
    return self.db.char.item1.item
end

function ReagentTracker:SetItem1(newItem1)
    self.db.char.item1.item = newItem1
    self:UpdateItems();
    self:UpdateText();
end

function ReagentTracker:GetItem2()
    return self.db.char.item2.item
end

function ReagentTracker:SetItem2(newItem2)
    self.db.char.item2.item = newItem2
    self:UpdateItems();
    self:UpdateText();
end

function ReagentTracker:GetItem3()
    return self.db.char.item3.item
end

function ReagentTracker:SetItem3(newItem3)
    self.db.char.item3.item = newItem3
    self:UpdateItems();
    self:UpdateText();
end

function ReagentTracker:GetItem4()
    return self.db.char.item4.item
end

function ReagentTracker:SetItem4(newItem4)
    self.db.char.item4.item = newItem4
    self:UpdateItems();
    self:UpdateText();
end

function ReagentTracker:GetItem5()
    return self.db.char.item5.item
end

function ReagentTracker:SetItem5(newItem5)
    self.db.char.item5.item = newItem5
    self:UpdateItems();
    self:UpdateText();
end

function ReagentTracker:OnTextUpdate()
    if (self.db.char.text.textrt == true) then

    msg = "RT: ";

    if (self.db.char.itemnumber >= 1) then
	if (self.db.char.item1.iwv == -1) then
	msg = msg .. "|cFFFFFFFF";
	else
	msg = msg .. "|cFF" .. C:GetThresholdHexColor(self.item1Count , 0, self.db.char.item1.iwv * 0.5, self.db.char.item1.iwv, self.db.char.item1.iwv * 1.5, self.db.char.item1.iwv * 2);
	end
	msg = msg..self.item1Count;    
    end
    if (self.db.char.itemnumber > 1) then msg = msg.."|cFFFFFF00/"; end


    if (self.db.char.itemnumber >= 2) then
	if (self.db.char.item2.iwv == -1) then
	msg = msg .. "|cFFFFFFFF";
	else
	msg = msg .. "|cFF" .. C:GetThresholdHexColor(self.item2Count , 0, self.db.char.item2.iwv * 0.5, self.db.char.item2.iwv, self.db.char.item2.iwv * 1.5, self.db.char.item2.iwv * 2);
	end	
	msg = msg..self.item2Count;    
    end
    if (self.db.char.itemnumber > 2) then msg = msg.."|cFFFFFF00/"; end


    if (self.db.char.itemnumber >= 3) then
	if (self.db.char.item3.iwv == -1) then
	msg = msg .. "|cFFFFFFFF";
	else
	msg = msg .. "|cFF" .. C:GetThresholdHexColor(self.item3Count , 0, self.db.char.item3.iwv * 0.5, self.db.char.item3.iwv, self.db.char.item3.iwv * 1.5, self.db.char.item3.iwv * 2);
	end
	msg = msg..self.item3Count;    
    end
    if (self.db.char.itemnumber > 3) then msg = msg.."|cFFFFFF00/"; end


    if (self.db.char.itemnumber >= 4) then
	if (self.db.char.item4.iwv == -1) then
	msg = msg .. "|cFFFFFFFF";
	else
	msg = msg .. "|cFF" .. C:GetThresholdHexColor(self.item4Count , 0, self.db.char.item4.iwv * 0.5, self.db.char.item4.iwv, self.db.char.item4.iwv * 1.5, self.db.char.item4.iwv * 2);
	end
	msg = msg..self.item4Count;    
    end
    if (self.db.char.itemnumber > 4) then msg = msg.."|cFFFFFF00/"; end


    if (self.db.char.itemnumber >= 5) then
	if (self.db.char.item5.iwv == -1) then
	msg = msg .. "|cFFFFFFFF";
	else
	msg = msg .. "|cFF" .. C:GetThresholdHexColor(self.item5Count , 0, self.db.char.item5.iwv * 0.5, self.db.char.item5.iwv, self.db.char.item5.iwv * 1.5, self.db.char.item5.iwv * 2);
	end
	msg = msg..self.item5Count;    
    end


    self:SetText(msg);

    elseif (self.db.char.text.textfa == true) then
	local name, standing, min, max, value = GetWatchedFactionInfo()
	msg = "FT:"
	local left = (max-value)
	local max = (max-min)
	local min = (value-min)
	local pc = (min/max)
	--[[local pC = pc * 100
	local nG = 0
	local nR = 0
	local ra = 20
	for i = 1, 20 do
		if ((pc/ra)+((100/ra)*i) < pC) then nG = nG + 1; else nR = nR + 1; end
	end
	for i = 1, nG do
		msg = msg .. "|cFF00FF00#";
	end
	for i = 1, nR do
		msg = msg .. "|cFFFF0000#";
	end]]
	FTC = "|cFF" .. C:GetThresholdHexColor(pc);
	FTSC= "|cFF" .. C:GetThresholdHexColor(standing, 1,2.5,4,5.5,8);
	msg = msg .. " " .. name .. " (" .. string.format(FTC.."%.0f%%|r", pc * 100) .. " " .. FTSC .. L["FACTION_REPNAME_"..standing] .. "|r)";
	self:SetText(msg);
    end
    	self:Warn();
	if (self.db.char.debug == true) then
		self:Print("self:OnTextUpdate()..Done!");
	end
end

function ReagentTracker:OnTooltipUpdate()
local cat = tablet:AddCategory(
		'columns', 2,
		'child_textR', 1,
		'child_textG', 1,
		'child_textB', 0,
		'child_text2R', 1,
		'child_text2G', 1,
		'child_text2B', 1
	)
	if (self.db.char.item1["iwv"] == -1) then
	cat:AddLine(
		'text', self.db.char.item1["item"]..":",
		'text2', self.item1Count.." ("..L["IWV_OFF"]..")"
	); else 
	CHC = "|cFF" .. C:GetThresholdHexColor(self.item1Count , 0, self.db.char.item1.iwv * 0.5, self.db.char.item1.iwv, self.db.char.item1.iwv * 1.5, self.db.char.item1.iwv * 2);
	cat:AddLine(
		'text', self.db.char.item1["item"]..":",
		'text2', CHC..self.item1Count.."|r ("..self.db.char.item1["iwv"]..")"
	); end
	if (self.db.char.itemnumber >= 2) then
	if (self.db.char.item2["iwv"] == -1) then
	cat:AddLine(
		'text', self.db.char.item2["item"]..":",
		'text2', self.item2Count.." ("..L["IWV_OFF"]..")"
	); else 
	CHC = "|cFF" .. C:GetThresholdHexColor(self.item2Count , 0, self.db.char.item2.iwv * 0.5, self.db.char.item2.iwv, self.db.char.item2.iwv * 1.5, self.db.char.item2.iwv * 2);
	cat:AddLine(
		'text', self.db.char.item2["item"]..":",
		'text2', CHC..self.item2Count.."|r ("..self.db.char.item2["iwv"]..")"
	); end
	end
	if (self.db.char.itemnumber >= 3) then
	if (self.db.char.item3["iwv"] == -1) then
	cat:AddLine(
		'text', self.db.char.item3["item"]..":",
		'text2', self.item3Count.." ("..L["IWV_OFF"]..")"
	); else 
	CHC = "|cFF" .. C:GetThresholdHexColor(self.item3Count , 0, self.db.char.item3.iwv * 0.5, self.db.char.item3.iwv, self.db.char.item3.iwv * 1.5, self.db.char.item3.iwv * 2);
	cat:AddLine(
		'text', self.db.char.item3["item"]..":",
		'text2', CHC..self.item3Count.."|r ("..self.db.char.item3["iwv"]..")"
	); end
	end
	if (self.db.char.itemnumber >= 4) then
	if (self.db.char.item4["iwv"] == -1) then
	cat:AddLine(
		'text', self.db.char.item4["item"]..":",
		'text2', self.item4Count.." ("..L["IWV_OFF"]..")"
	); else 
	CHC = "|cFF" .. C:GetThresholdHexColor(self.item4Count , 0, self.db.char.item4.iwv * 0.5, self.db.char.item4.iwv, self.db.char.item4.iwv * 1.5, self.db.char.item4.iwv * 2);
	cat:AddLine(
		'text', self.db.char.item4["item"]..":",
		'text2', CHC..self.item4Count.."|r ("..self.db.char.item4["iwv"]..")"
	); end
	end
	if (self.db.char.itemnumber >= 5) then
	if (self.db.char.item5["iwv"] == -1) then
	cat:AddLine(
		'text', self.db.char.item5["item"]..":",
		'text2', self.item5Count.." ("..L["IWV_OFF"]..")"
	); else 
	CHC = "|cFF" .. C:GetThresholdHexColor(self.item5Count , 0, self.db.char.item5.iwv * 0.5, self.db.char.item5.iwv, self.db.char.item5.iwv * 1.5, self.db.char.item5.iwv * 2);
	cat:AddLine(
		'text', self.db.char.item5["item"]..":",
		'text2', CHC..self.item5Count.."|r ("..self.db.char.item5["iwv"]..")"
	); end
	end
	cat:AddLine()
	cat:AddLine()
	cat:AddLine()
	local name, standing, min, max, value = GetWatchedFactionInfo()
		cat:AddLine(
			'text', L["FACTION_STANDINGS"]
		)
		cat:AddLine(
			'text2', name
		)
		local left = (max-value)
		local max = (max-min)
		local min = (value-min)
		local pc = (min/max)
		cat:AddLine(
			'text', "|cFFFFFFFF"..min.."|r/|cFFFFFFFF"..max,
			'text2', left.." |cFFFFFF00"..L["FACTION_LEFT"]
		)
		cat:AddLine(
			'text2', string.format("%.0f%%", pc * 100).." |cFFFFFF00"..L["FACTION_REPNAME_"..standing]
		)

	if (name == L["FACTION_CENARION"]) then
		cat:AddLine(
			'text2', (left/10) .." "..L["FACTION_CENARION_LEFT_TEXT"]
		)
		cat:AddLine(
			'text2', (left/50*3) .." "..L["FACTION_CENARION_LEFT_CREST"]
		)
	end

	if (name == L["FACTION_ZANDALAR"]) then
		cat:AddLine(
			'text2', (left/75) .." "..L["FACTION_ZANDALAR_BIJOU_DESTROY"]
		)
	end


	self:UpdateItems();
	self:UpdateText();
	self:Warn();
	if (self.db.char.debug == true) then
		self:Print("self:OnTooltipUpdate()..Done!");
	end
end

function ReagentTracker:Warn()
    if (self.inited == true) then

	if (ReagentTracker.item1Count < ReagentTracker.db.char.item1.iwv and self.alrdyW1 == false) then
	    if (ReagentTracker.db.char.warnchat == true) then
		ReagentTracker:Print("|cFFFF0000"..L["WARNINGVALUE1"]..ReagentTracker.db.char.item1["item"].."|cFFFF0000! ("..ReagentTracker.item1Count.." < "..ReagentTracker.db.char.item1["iwv"]..")");
		self.alrdyW1 = true;
	    end
	    if (ReagentTracker.db.char.warnsct == true and SCT and SCT_MSG_FRAME) then
		SCT_MSG_FRAME:AddMessage( "|cFFFF0000"..L["WARNINGVALUE1"]..ReagentTracker.db.char.item1["item"].."|cFFFF0000! ("..ReagentTracker.item1Count.." < "..ReagentTracker.db.char.item1["iwv"]..")", 1, 0, 0, 5)
		self.alrdyW1 = true;
	    end
	    if (ReagentTracker.db.char.warnuie == true) then
		UIErrorsFrame:AddMessage("|cFFFF0000"..L["WARNINGVALUE1"]..ReagentTracker.db.char.item1["item"].."|cFFFF0000! ("..ReagentTracker.item1Count.." < "..ReagentTracker.db.char.item1["iwv"]..")",1,0,0,1,5);
		self.alrdyW1 = true;
	    end
	end
	if (ReagentTracker.item1Count > ReagentTracker.db.char.item1.iwv and self.alrdyW1 == true) then self.alrdyW1 = false; end
	--end item1 warnmethod
	if (ReagentTracker.db.char.itemnumber >= 2) then
	if (ReagentTracker.item2Count < ReagentTracker.db.char.item2.iwv and self.alrdyW2 == false) then
	    if (ReagentTracker.db.char.warnchat == true) then
		ReagentTracker:Print("|cFFFF0000"..L["WARNINGVALUE1"]..ReagentTracker.db.char.item2["item"].."|cFFFF0000! ("..ReagentTracker.item2Count.." < "..ReagentTracker.db.char.item2["iwv"]..")");
		self.alrdyW2 = true;
	    end
	    if (ReagentTracker.db.char.warnsct == true and SCT and SCT_MSG_FRAME) then
		SCT_MSG_FRAME:AddMessage( "|cFFFF0000"..L["WARNINGVALUE1"]..ReagentTracker.db.char.item2["item"].."|cFFFF0000! ("..ReagentTracker.item2Count.." < "..ReagentTracker.db.char.item2["iwv"]..")", 1, 0, 0, 5)
		self.alrdyW2 = true;
	    end
	    if (ReagentTracker.db.char.warnuie == true) then
		UIErrorsFrame:AddMessage("|cFFFF0000"..L["WARNINGVALUE1"]..ReagentTracker.db.char.item2["item"].."|cFFFF0000! ("..ReagentTracker.item2Count.." < "..ReagentTracker.db.char.item2["iwv"]..")",1,0,0,1,5);
		self.alrdyW2 = true;
	    end
	end
	if (ReagentTracker.item2Count > ReagentTracker.db.char.item2.iwv and self.alrdyW2 == true) then self.alrdyW2 = false; end
	end
	--end item2 warnmethod
	if (ReagentTracker.db.char.itemnumber >= 3) then
	if (ReagentTracker.item3Count < ReagentTracker.db.char.item3.iwv and self.alrdyW3 == false) then
	    if (ReagentTracker.db.char.warnchat == true) then
		ReagentTracker:Print("|cFFFF0000"..L["WARNINGVALUE1"]..ReagentTracker.db.char.item3["item"].."|cFFFF0000! ("..ReagentTracker.item3Count.." < "..ReagentTracker.db.char.item3["iwv"]..")");
		self.alrdyW3 = true;
	    end
	    if (ReagentTracker.db.char.warnsct == true and SCT and SCT_MSG_FRAME) then
		SCT_MSG_FRAME:AddMessage( "|cFFFF0000"..L["WARNINGVALUE1"]..ReagentTracker.db.char.item3["item"].."|cFFFF0000! ("..ReagentTracker.item3Count.." < "..ReagentTracker.db.char.item3["iwv"]..")", 1, 0, 0, 5)
		self.alrdyW3 = true;
	    end
	    if (ReagentTracker.db.char.warnuie == true) then
		UIErrorsFrame:AddMessage("|cFFFF0000"..L["WARNINGVALUE1"]..ReagentTracker.db.char.item3["item"].."|cFFFF0000! ("..ReagentTracker.item3Count.." < "..ReagentTracker.db.char.item3["iwv"]..")",1,0,0,1,5);
		self.alrdyW3 = true;
	    end
	end
	if (ReagentTracker.item3Count >= ReagentTracker.db.char.item3.iwv and self.alrdyW3 == true) then self.alrdyW3 = false; end
	end
	--end item3 warnmethod
	if (ReagentTracker.db.char.itemnumber >= 4) then
	if (ReagentTracker.item4Count < ReagentTracker.db.char.item4.iwv and self.alrdyW4 == false) then
	    if (ReagentTracker.db.char.warnchat == true) then
		ReagentTracker:Print("|cFFFF0000"..L["WARNINGVALUE1"]..ReagentTracker.db.char.item4["item"].."|cFFFF0000! ("..ReagentTracker.item4Count.." < "..ReagentTracker.db.char.item4["iwv"]..")");
		self.alrdyW4 = true;
	    end
	    if (ReagentTracker.db.char.warnsct == true and SCT and SCT_MSG_FRAME) then
		SCT_MSG_FRAME:AddMessage( "|cFFFF0000"..L["WARNINGVALUE1"]..ReagentTracker.db.char.item4["item"].."|cFFFF0000! ("..ReagentTracker.item4Count.." < "..ReagentTracker.db.char.item4["iwv"]..")", 1, 0, 0, 5)
		self.alrdyW4 = true;
	    end
	    if (ReagentTracker.db.char.warnuie == true) then
		UIErrorsFrame:AddMessage("|cFFFF0000"..L["WARNINGVALUE1"]..ReagentTracker.db.char.item4["item"].."|cFFFF0000! ("..ReagentTracker.item4Count.." < "..ReagentTracker.db.char.item4["iwv"]..")",1,0,0,1,5);
		self.alrdyW4 = true;
	    end
	end
	if (ReagentTracker.item4Count >= ReagentTracker.db.char.item4.iwv and self.alrdyW4 == true) then self.alrdyW4 = false; end
	end
	--end item4 warnmethod
	if (ReagentTracker.db.char.itemnumber >= 5) then
	if (ReagentTracker.item5Count < ReagentTracker.db.char.item5.iwv and self.alrdyW5 == false) then
	    if (ReagentTracker.db.char.warnchat == true) then
		ReagentTracker:Print("|cFFFF0000"..L["WARNINGVALUE1"]..ReagentTracker.db.char.item5["item"].."|cFFFF0000! ("..ReagentTracker.item5Count.." < "..ReagentTracker.db.char.item5["iwv"]..")");
		self.alrdyW5 = true;
	    end
	    if (ReagentTracker.db.char.warnsct == true and SCT and SCT_MSG_FRAME) then
		SCT_MSG_FRAME:AddMessage( "|cFFFF0000"..L["WARNINGVALUE1"]..ReagentTracker.db.char.item5["item"].."|cFFFF0000! ("..ReagentTracker.item5Count.." < "..ReagentTracker.db.char.item5["iwv"]..")", 1, 0, 0, 5)
		self.alrdyW5 = true;
	    end
	    if (ReagentTracker.db.char.warnuie == true) then
		UIErrorsFrame:AddMessage("|cFFFF0000"..L["WARNINGVALUE1"]..ReagentTracker.db.char.item5["item"].."|cFFFF0000! ("..ReagentTracker.item5Count.." < "..ReagentTracker.db.char.item5["iwv"]..")",1,0,0,1,5);
		self.alrdyW5 = true;
	    end
	end
	if (ReagentTracker.item5Count >= ReagentTracker.db.char.item5.iwv and self.alrdyW5 == true) then self.alrdyW5 = false; end
	end
if (self.db.char.debug == true) then
	self:Print("self:Warn()..Done!");
end
end
end


function ReagentTracker:UpdateItems()
	self.item1Count = self:SearchInvForItem(self.db.char.item1["item"]);
	if (self.db.char.itemnumber >= 2) then self.item2Count = self:SearchInvForItem(self.db.char.item2["item"]) else self.item2Count = 0; end
	if (self.db.char.itemnumber >= 3) then self.item3Count = self:SearchInvForItem(self.db.char.item3["item"]) else self.item3Count = 0; end
	if (self.db.char.itemnumber >= 4) then self.item4Count = self:SearchInvForItem(self.db.char.item4["item"]) else self.item4Count = 0; end
	if (self.db.char.itemnumber >= 5) then self.item5Count = self:SearchInvForItem(self.db.char.item5["item"]) else self.item5Count = 0; end
	if (self.db.char.debug == true) then
		self:PrintComma("CrayonInfoItem1: ", self.item1Count , 0, self.db.char.item1.iwv * 0.5, self.db.char.item1.iwv, self.db.char.item1.iwv * 1.5, self.db.char.item1.iwv * 2);
		self:PrintComma("CrayonInfoItem2: ", self.item2Count , 0, self.db.char.item2.iwv * 0.5, self.db.char.item2.iwv, self.db.char.item2.iwv * 1.5, self.db.char.item2.iwv * 2);
		self:PrintComma("CrayonInfoItem3: ", self.item3Count , 0, self.db.char.item3.iwv * 0.5, self.db.char.item3.iwv, self.db.char.item3.iwv * 1.5, self.db.char.item3.iwv * 2);
		self:PrintComma("CrayonInfoItem4: ", self.item4Count , 0, self.db.char.item4.iwv * 0.5, self.db.char.item4.iwv, self.db.char.item4.iwv * 1.5, self.db.char.item4.iwv * 2);
		self:PrintComma("CrayonInfoItem5: ", self.item5Count , 0, self.db.char.item5.iwv * 0.5, self.db.char.item5.iwv, self.db.char.item5.iwv * 1.5, self.db.char.item5.iwv * 2);
		self:Print("self:UpdateItems()..Done!");
	end
	self:Warn();
end
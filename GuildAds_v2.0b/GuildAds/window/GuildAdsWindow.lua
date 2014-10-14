----------------------------------------------------------------------------------
--
-- GuildAdsWindow.lua
--
-- Author: Zarkan, Fkaï of European Ner'zhul (Horde)
-- URL : http://guildads.sourceforge.net
-- Email : guildads@gmail.com
-- Licence: GPL version 2 (General Public License)
----------------------------------------------------------------------------------

GuildAdsWindow = AceModule:new();

--------------------------------------------------------------------------------
--
-- New
-- 
--------------------------------------------------------------------------------
function GuildAdsWindow:new(t)
	-- Call parent new method
	local o = AceModule.new(self,t)
	-- Register this new window into GuildAds object
	if o.name then
		GuildAds.windows[o.name] = o;
	else
		tinsert(GuildAds.windows, o)
	end
	-- return new object
	return o;
end;

--------------------------------------------------------------------------------
--
-- Create (called by GuildAds)
-- 
--------------------------------------------------------------------------------
function GuildAdsWindow:Create()
	-- Escape hide the window
	tinsert(UISpecialFrames,self.frame);

	-- Initialize tabs
	self:InitializeTabs();
end

---------------------------------------------------------------------------------
--
-- Choose a tab (Available, Request, Event, ...)
-- 
---------------------------------------------------------------------------------
function GuildAdsWindow:InitializeTabs()
	local currTab, previousTab;
	
	self.tabDescription = GuildAdsPlugin_GetUI(self.name);

	for id, info in self.tabDescription do
		currTab = getglobal(info.tab);

		if info.tooltip then
			currTab.tooltip = info.tooltip;
		end
		currTab.window = self;		
		self:InitializeTab(currTab, id, info, previousTab);
		
		previousTab = currTab;
	end
end

function GuildAdsWindow:InitializeTab(currTab, id, info, previousTab)
	currTab:SetID(id);
	currTab:ClearAllPoints();
	currTab:SetParent(self.frame);
	if (previousTab == nil) then
		currTab:SetPoint("CENTER", self.frame, "BOTTOMLEFT", 65, -13);
		getglobal(info.frame):Show();
		self:SelectTab(currTab);
	else
		currTab:SetPoint("LEFT", previousTab:GetName(), "RIGHT", -13, 0);
		getglobal(info.frame):Hide()
		self:DeselectTab(currTab);
	end
end

function GuildAdsWindow:TabOnClick(tab)	
    for id, info in self.tabDescription do
		if id == tab then
			getglobal(info.frame):Show();
			self:SelectTab(getglobal(info.tab));
		else
			getglobal(info.frame):Hide();
			self:DeselectTab(getglobal(info.tab));
		end
	end
end

function GuildAdsWindow:SelectTab(tab)
	local name = tab:GetName();
	getglobal(name.."Left"):Hide();
	getglobal(name.."Middle"):Hide();
	getglobal(name.."Right"):Hide();
	--tab:LockHighlight();
	tab:Disable();
	getglobal(name.."LeftDisabled"):Show();
	getglobal(name.."MiddleDisabled"):Show();
	getglobal(name.."RightDisabled"):Show();
	
	if ( GameTooltip:IsOwned(tab) ) then
		GameTooltip:Hide();
	end
end

function GuildAdsWindow:DeselectTab(tab)
	local name = tab:GetName();
	getglobal(name.."Left"):Show();
	getglobal(name.."Middle"):Show();
	getglobal(name.."Right"):Show();
	--tab:UnlockHighlight();
	tab:Enable();
	getglobal(name.."LeftDisabled"):Hide();
	getglobal(name.."MiddleDisabled"):Hide();
	getglobal(name.."RightDisabled"):Hide();
end

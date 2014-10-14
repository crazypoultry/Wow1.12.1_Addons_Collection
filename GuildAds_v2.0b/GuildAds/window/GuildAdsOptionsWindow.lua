----------------------------------------------------------------------------------
--
-- GuildAdsOptionsWindow.lua
--
-- Author: Zarkan, Fkaï of European Ner'zhul (Horde)
-- URL : http://guildads.sourceforge.net
-- Email : guildads@gmail.com
-- Licence: GPL version 2 (General Public License)
----------------------------------------------------------------------------------

GuildAdsOptionsWindow = GuildAdsWindow:new({ name="options", frame = "GuildAdsOptionsWindowFrame" });

function GuildAdsOptionsWindow:GetPluginInWindow()
	if not self.pluginInWindow then
		self.pluginInWindow = {};
		for pluginName, plugin in GuildAdsPlugin.PluginsList do
			if plugin.metaInformations and plugin.metaInformations.ui and plugin.metaInformations.ui[self.name] then
				self.pluginInWindow[pluginName] = plugin;
			end
		end
	end
	return self.pluginInWindow;
end

function GuildAdsOptionsWindow:Save()
	for pluginName, plugin in self:GetPluginInWindow() do
		if plugin.saveOptions then
			plugin.saveOptions();
		end
	end
	getglobal(self.frame):Hide();
end

-- TODO : restaure defaults option only for current tab
function GuildAdsOptionsWindow:Defaults()
	for pluginName, plugin in self:GetPluginInWindow() do
		if plugin.defaultsOptions then
			plugin.defaultsOptions();
		end
	end
end

function GuildAdsOptionsWindow:InitializeTab(currTab, id, info, previousTab)
	currTab:SetID(id);
	currTab:ClearAllPoints();
	currTab:SetParent(self.frame);
	if (previousTab == nil) then
		currTab:SetPoint("CENTER", self.frame, "BOTTOMLEFT", 65, -10);
		getglobal(info.frame):Show();
		self:SelectTab(currTab);
	else
		currTab:SetPoint("LEFT", previousTab:GetName(), "RIGHT", -10, 0);
		getglobal(info.frame):Hide()
		self:DeselectTab(currTab);
	end
end


-- Register only when Gatherer is loaded
if(Gatherer_OnLoad ~= nil) then

	-- List of all gatherer settings
	MM_GATHERER_SETTINGS = {
		-- command = "variable name"
		dist	= "maxDist",
		num		= "number",
		fdist	= "fadeDist",
		fperc	= "fadePerc",
		idist	= "miniIconDist"
	};

	-- Sets the value
	local function GathererSet(varname, cmd, value)
		value = tonumber(value);
		if(value == nil) then return; end
		if(GatherConfig[varname] ~= value) then
			Gatherer_Command(format("%s %d", cmd, value));
		end
	end

	-- Defines a set up dialog
	local function DefDialog(cmd, varname)
		local which = string.upper(cmd);

		StaticPopupDialogs["GATHERER_SETTING_"..which] = {
			text = getglobal("MM_GATHERER_"..which),
			button1 = TEXT(ACCEPT),
			button2 = TEXT(CANCEL),
			hasEditBox = 1,
			maxLetters = 4,
			OnAccept = function()
				local text = getglobal(this:GetParent():GetName().."EditBox"):GetText();
				GathererSet(varname, cmd, text);
			end,
			EditBoxOnEnterPressed = function()
				local text = getglobal(this:GetParent():GetName().."EditBox"):GetText();
				GathererSet(varname, cmd, text);
			end,
			OnShow = function()
				getglobal(this:GetName().."EditBox"):SetFocus();
				local text = GatherConfig[varname];
				if(not text) then text = ""; end
				getglobal(this:GetName().."EditBox"):SetText(text);
			end,
			timeout = 0,
			exclusive = 1
		};

	end

	-- Register a dialog box for each setting
	for cmd,varname in pairs(MM_GATHERER_SETTINGS) do
		DefDialog(cmd, varname);
	end

end
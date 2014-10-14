TITAN_MACROMENU_ID       = "MacroMenu";
TITAN_MACROMENURIGHT_ID  = "MacroMenuRight";
TITAN_MACROMENU_NAME     = "TitanMacroMenu";
TITAN_MACROMENU_VERSION  = "11200-0.05f";
TITAN_MACROMENU_ICON     = "Interface\\Icons\\INV_Battery_02";
TITAN_MACROMENU_CATEGORY = "Information";
TITAN_MACROMENU_AUTHOR   = "Travesor";
TITAN_MACROMENU_DATE     = "September 2, 2006";
TITAN_MACROMENU_EMAIL    = "";
TITAN_MACROMENU_URL      = "http://ui.worldofwar.net/ui.php?id=2246";
TITAN_MACROMENURIGHT_ID  = "MacroMenuRight";

--[[
TitanMacroMenu
by Travesor of Shadow Moon


«-CHANGES-»

v11200-0.05f 2006-09-02
- Mod: Updated TOC version to v1.12

v11100-0.05f 2006-06-22
- Mod: Updated TOC version to v1.11

v11000-0.05e 2006-03-31
- Mod: Updated TOC version to v1.10

v10900-0.05d 2006-03-28
- New: Added Titan Panel systray icon
- Mod: Changed icon to INV_Battery_02

v10900-0.05c 2006-03-18
- New: Added category definition for Titan Panel "Information" (SkunkWerks)

v10900-0.05b 2006-03-17
- Fixed bug #001: MAX_MACROS not defined on line 173 (Grizzly UK)
- Fixed Bug #002: Macros would not execute without SuperMacro (Grizzly UK)
- New: Added myAddons support

v10900-0.05a 2006-03-16
- Initial release

--]]

TMM_MAX_MACROS = 18;

TITAN_MACROMENU_TYPES = {
	[0] = "Account",
	[1] = "Character",
	[2] = "SuperMacro"
};

TITAN_MACROMENU_MACROS = {
  [0] = {},
  [1] = {},
  [2] = {}
};

TITAN_MACROMENU_MYADDONS_DETAILS = {
  name =         TITAN_MACROMENU_NAME,
	version =      TITAN_MACROMENU_VERSION,
	releaseDate =  TITAN_MACROMENU_DATE,
	author =       TITAN_MACROMENU_AUTHOR,
	email =        TITAN_MACROMENU_EMAIL,
	website =      TITAN_MACROMENU_URL,
	category =     MYADDONS_CATEGORY_PLUGINS,
	optionsframe = ""
};


--------------------------------------------
--              onFunctions               --
--------------------------------------------

function TPMacroMenu_Debug(msg, line)
  if (TITAN_MACROMENU_DEBUG) then
    if (line) then
      msg = msg.." ["..line.."]";
    end;
    DEFAULT_CHAT_FRAME:AddMessage("Debug: "..msg);
  end;
end;

--------------------------------------------
--              onFunctions               --
--------------------------------------------

function TitanPanelMacroMenuButton_OnLoad()
	this.registry = {
		id                 = TITAN_MACROMENU_ID,
		menuText           = TITAN_MACROMENU_MENU_TEXT,
		version            = TITAN_MACROMENU_VERSION,
		category           = TITAN_MACROMENU_CATEGORY,
		buttonTextFunction = "TitanPanelMacroMenuButton_GetButtonText",
		icon               = TITAN_MACROMENU_ICON,
		iconWidth          = 16,
		savedVariables = {
			ShowIcon      = 1,
			ShowLabelText = 1
		}
	};

	this:RegisterEvent("ADDON_LOADED");

	TITAN_MACROMENU_TYPES[0] = TITAN_MACROMENU_CAT_ACCOUNT;
	TITAN_MACROMENU_TYPES[1] = TITAN_MACROMENU_CAT_CHAR;
	TITAN_MACROMENU_TYPES[2] = TITAN_MACROMENU_CAT_SUPER;
end;

function TitanPanelMacroMenuButton_OnEvent()
  if (event == "ADDON_LOADED" and arg1 == TITAN_MACROMENU_NAME) then
    if(myAddOnsFrame_Register) then
		  myAddOnsFrame_Register(TITAN_MACROMENU_MYADDONS_DETAILS);
	  end;
	  this:UnregisterEvent("ADDON_LOADED");
  end;
end;

function TitanPanelMacroMenuRightButton_OnLoad()
	this.registry = {
		id                  = TITAN_MACROMENURIGHT_ID,
		menuText            = TITAN_MACROMENU_MENURIGHT_TEXT,
		version             = TITAN_MACROMENU_VERSION,
		category            = TITAN_MACROMENU_CATEGORY,
		buttonTextFunction  = "TitanPanelMacroMenuButton_GetButtonText",
		tooltipTitle        = TITAN_MACROMENU_MENU_TEXT,
		tooltipTextFunction = "TitanPanelMacroMenuButton_GetTooltipText",
		icon                = TITAN_MACROMENU_ICON,
		iconWidth           = 16,
		savedVariables = {
			ShowIcon      = 1,
			ShowLabelText = 1
		}
	};
end;

--------------------------------------------
--             Mod Functions              --
--------------------------------------------

function TitanPanelMacroMenuButton_GetTooltipText()
	return TITAN_MACROMENU_TOOLTIP_TEXT.."\n"..TitanUtils_GetGreenText(TITAN_MACROMENU_TOOLTIP_HINT);
end;

function TitanPanelMacroMenu_ToggleFrame(f)
	local fram = getglobal(f);
	if (not fram) then fram = getglobal(this.value); end;
	DropDownList1:Hide();
	if (fram:IsVisible()) then
		HideUIPanel(fram, true);
	else
		ShowUIPanel(fram, true);
	end;
end;

function TitanPanelMacroMenu_CallFunction(f)
	local funct = f;
	if (not funct) then funct = this.value; end;
	DropDownList1:Hide();
	local func = getglobal(funct);
	func();
end;

function TitanPanelMacroMenu_RegisterMenu(addon, infoarray)
	TitanMacroMenu_MenuItems[addon] = infoarray;
end;

--------------------------------------------
--            Titan Functions             --
--------------------------------------------

function TitanPanelMacroMenuButton_GetButtonText(id)
	return TITAN_MACROMENU_MENU_BARTEXT, "";
end;

function TitanPanelMacroMenu_ToggleIconText()
	if (TitanGetVar(TITAN_MACROMENU_ID, "ShowIcon") == TitanGetVar(TITAN_MACROMENU_ID, "ShowLabelText")) then
			TitanToggleVar(TITAN_MACROMENU_ID, "ShowLabelText");
	else
		TitanToggleVar(TITAN_MACROMENU_ID, "ShowIcon");
		TitanToggleVar(TITAN_MACROMENU_ID, "ShowLabelText");
	end;
	TitanPanelButton_UpdateButton(TITAN_MACROMENU_ID, 1);
end;

function TitanPanelMacroMenu_ToggleIcon()
	if ((TitanGetVar(TITAN_MACROMENU_ID, "ShowIcon")) and (not TitanGetVar(TITAN_MACROMENU_ID, "ShowLabelText"))) then
		TitanToggleVar(TITAN_MACROMENU_ID, "ShowLabelText");
	end;
	TitanToggleVar(TITAN_MACROMENU_ID, "ShowIcon");
	TitanPanelButton_UpdateButton(TITAN_MACROMENU_ID, 1);
end;

function TitanPanelMacroMenu_ToggleText()
	if ((not TitanGetVar(TITAN_MACROMENU_ID, "ShowIcon")) and (TitanGetVar(TITAN_MACROMENU_ID, "ShowLabelText"))) then
		TitanToggleVar(TITAN_MACROMENU_ID, "ShowIcon");
	end;
	TitanToggleVar(TITAN_MACROMENU_ID, "ShowLabelText");
	TitanPanelButton_UpdateButton(TITAN_MACROMENU_ID, 1);
end;

function TitanPanelMacroMenu_Hide()
	TitanPanel_RemoveButton(TITAN_MACROMENU_ID);
end;

function TitanPanelMacroMenuRight_Hide()
  TitanPanel_RemoveButton(TITAN_MACROMENURIGHT_ID);
end;

function TitanPanelRightClickMenu_PrepareMacroMenuMenu(level)
	if (level == 1) then
		TitanPanelMacroMenu_BuildRootMenu();
	end;
	if (level == 2) then
	  TitanPanelMacroMenu_GetMacros();
		TitanPanelMacroMenu_BuildCatMenu();
	end;
end;

function TitanPanelRightClickMenu_PrepareMacroMenuRightMenu(level)
	if (level == 1) then
		TitanPanelMacroMenu_BuildRootMenu();
	end;
	if (level == 2) then
	  TitanPanelMacroMenu_GetMacros();
		TitanPanelMacroMenu_BuildCatMenu();
	end;
end;

function TitanPanelMacroMenu_GetMacros()
	-- Clear Table
	TITAN_MACROMENU_MACROS = {};

	local mType, numMacros;
  local numAccountMacros, numCharacterMacros = GetNumMacros();
  local name, texture, body;

  for j = 0, TMM_MAX_MACROS, TMM_MAX_MACROS do
		if (j == 0) then
			numMacros = numAccountMacros;
			mType = 0;
		else
			numMacros = numCharacterMacros;
			mType = 1;
		end;
		for i = 1, TMM_MAX_MACROS do
			local macroID = i + j;

			if ( i <= numMacros ) then
			  name, _, body, _ = GetMacroInfo(macroID);

			  if (strlen(body) > 0) then
					local info = {};
			    info.name = name;
			    info.type = mType;
			    info.id = macroID;

			    tinsert(TITAN_MACROMENU_MACROS, info);
			  end;
			end;
    end;
  end;

  if (IsAddOnLoaded("SuperMacro")) then
    mType = 2; -- SuperMacro
    numMacros = GetNumSuperMacros();

    for i = 1, numMacros, 1 do
      name, texture, body = GetOrderedSuperMacroInfo(i);

      if (strlen(body) > 0) then
        local info = {};
        info.name = name;
        info.type = mType;
        info.id = name;

        tinsert(TITAN_MACROMENU_MACROS, info);
      end;

    end;
  end;
end;

function TitanPanelMacroMenu_BuildRootMenu()
	local level = 1;

	TitanPanelRightClickMenu_AddTitle(TitanPlugins[TITAN_MACROMENU_ID].menuText, level);
	TitanPanelRightClickMenu_AddSpacer(level);

	for key, value in TITAN_MACROMENU_TYPES do
		if (key <= 1) or (IsAddOnLoaded(value)) then
      local info = {};
  	  info.text = value;
  	  info.value = key;
	    info.hasArrow = 1;
  	  UIDropDownMenu_AddButton(info, level);
	  end;
	end;
end;

function TitanPanelMacroMenu_BuildCatMenu()
	local level = 2;
	local mType = UIDROPDOWNMENU_MENU_VALUE;

	for key, value in TITAN_MACROMENU_MACROS do
		if (value.type == mType) then
		  local info = {};

		  info.text = value.name;
		  info.value = {};
		  info.value.id = value.id;
		  info.value.type = value.type;
		  info.func = TitanPanelMacroMenu_HandleModClick;

		  UIDropDownMenu_AddButton(info, level);
		end;
	end;
end;

if (not IsAddOnLoaded("SuperMacro")) then
--
  function RunMacro(index)
  	-- close edit boxes, then enter body line by line
  	if (MacroFrame_SaveMacro) then
  		MacroFrame_SaveMacro();
  	end;
  	local body;
  	if (type(index) == "number") then
  		_, _, body, _ = GetMacroInfo(index);
  	elseif (type(index) == "string") then
  		_, _, body, _ = GetMacroInfo(GetMacroIndexByName(index));
  	end;
  	if (not body) then return; end;

  	if (ChatFrameEditBox:IsVisible()) then
  		ChatEdit_OnEscapePressed(ChatFrameEditBox);
  	end
  	if (ReplaceAlias and ASFOptions.aliasOn) then
  		-- correct aliases
  		body = ReplaceAlias(body);
  	end;
  	while (strlen(body) > 0) do
  		local block, line;
  		body, block, line = FindBlock(body);
  		if (block) then
  			RunScript(block);
  		else
  			RunLine(line);
  		end;
  	end;
  end;
--
  function FindBlock(body)
  	local a, b, block = strfind(body, "^/script (%-%-%-%-%[%[.-%-%-%-%-%]%])[\n]*");
  	if (block) then
  		body = strsub(body, b+1);
  		return body, block;
  	end;
  	local a, b, line = strfind(body, "^([^\n]*)[\n]*");
  	if (line) then
  		body = strsub(body,b+1);
  		return body, nil, line;
  	end;
  end;
--
  function RunBody(text)
  	local body=text;
  	local length = strlen(body);
  	for w in string.gfind(body, "[^\n]+") do
  		RunLine(w);
  	end;
  end;
--
  function RunLine(...)
  -- execute a line in a macro
  -- if script or cast, then rectify and RunScript
  -- else send to chat edit box
    for k = 1, arg.n do
    	local text = arg[k];
    	if (ReplaceAlias and ASFOptions.aliasOn) then
    		-- correct aliases
    		text = ReplaceAlias(text);
    	end;
    	if (string.find(text, "^/cast") ) then
    		local i, book = SM_FindSpell(gsub(text, "^%s*/cast%s*(%w.*[%w%)])%s*$", "%1"));
    		if (i) then
    			CastSpell(i, book);
    		end
    	else
    		if (string.find(text, "^/script ")) then
    			RunScript(gsub(text, "^/script ", ""));
    		else
    			text = gsub(text, "\n", ""); -- cannot send newlines, will disconnect
    			ChatFrameEditBox:SetText(text);
    			ChatEdit_SendText(ChatFrameEditBox);
    		end;
    	end;
    end; -- for
  end; -- RunLine()
--
  function SM_FindSpell(spell)
  	local s = gsub(spell, "%s*(.-)%s*%(.*","%1");
  	local r;
  	local num = tonumber(gsub(spell, "%D*(%d+)%D*", "%1"), 10);
  	if (string.find(spell, "%(%s*[Rr]acial")) then
  		r = "racial";
  	elseif (string.find(spell, "%(%s*[Ss]ummon")) then
  		r = "summon";
  	elseif (string.find(spell, "%(%s*[Aa]pprentice")) then
  		r = "apprentice";
  	elseif (string.find(spell, "%(%s*[Jj]ourneyman")) then
  		r = "journeyman";
  	elseif (string.find(spell, "%(%s*[Ee]xpert")) then
  		r = "expert";
  	elseif (string.find(spell, "%(%s*[Aa]rtisan")) then
  		r = "artisan";
  	elseif (string.find(spell, "%(%s*[Mm]aster")) then
  		r = "master";
  	elseif (string.find(spell, "[Rr]ank%s*%d+") and num and num > 0) then
  		r = gsub(spell, ".*%(.*[Rr]ank%s*(%d+).*", "Rank "..num);
  	else
  		r = ""
  	end;
  	return FindSpell(s,r);
  end;
--
  function FindSpell(spell, rank)
  	local i = 1;
  	local booktype = { "spell", "pet", };
  	--local booktype = "spell";
  	local s,r;
  	local ys, yr;
  	for k, book in booktype do
  		while spell do
  		s, r = GetSpellName(i,book);
  		if ( not s ) then
  			i = 1;
  			break;
  		end;
  		if ( string.lower(s) == string.lower(spell)) then ys=true; end;
  		if ( (r == rank) or (r and rank and string.lower(r) == string.lower(rank))) then yr=true; end;
  		if ( rank=='' and ys and (not GetSpellName(i+1, book) or string.lower(GetSpellName(i+1, book)) ~= string.lower(spell) )) then
  			yr = true; -- use highest spell rank if omitted
  		end;
  		if ( ys and yr ) then
  			return i,book;
  		end;
  		i=i+1;
  		ys = nil;
  		yr = nil;
  		end;
  	end;
  	return;
  end;
--
end; -- if (not IsAddOnLoaded("SuperMacro"))

function TitanPanelMacroMenu_HandleModClick()
	if (this.value) then
  	if (this.value.type == 2) then
      RunSuperMacro(this.value.id);
	  else
	    RunMacro(this.value.id);
  	end;
  end;
end;

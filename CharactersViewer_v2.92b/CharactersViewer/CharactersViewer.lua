--[[ Characters Viewer: View equipment and inventory of alternate characters.
	 
	Author: Flisher
		Contributor:	Vincent of Blackhand
					Galmok
					Sinaloit
					Legorol	

    Version: 2.58 (Cosmos Revision : $Rev: 3761 $)
    Last Changed by: $LastChangedBy: Flisher $
    Date: $Date: 2006-07-06 10:52:10 -0400 (jeu., 06 juil. 2006) $

    Official Distribution site: http://www.curse-gaming.com/mod.php?addid=490
    Also packaged in Cosmos: http://www.cosmosui.org

]]--

-- Initialize the variables

local Server = GetRealmName();
CharactersViewerConfig = {};

function cvprint(msg) SELECTED_CHAT_FRAME:AddMessage("CV: "..msg); end

CharactersViewer = {};

CharactersViewer.version =
{  db = 200;
	text = "2.69 Beta";
	number = 269;
	date = "September 14th, 2006";
};
CharactersViewer.Onload = function()
	CharactersViewer.register.slashcmd();
	CharactersViewer.register.event()
	-- Registering with other addons --
	CharactersViewer.register.cosmos();
	
	CharactersViewer.register.myaddon();
	CharactersViewer.register.ctmod();
   
end

function CharactersViewer.OnEvent(event)
	if ( event == "PLAYER_ENTERING_WORLD" ) then
		if ( CharactersViewer.rpgoInit ~= nil) then
			CharactersViewer.rpgoInit();
		end
	end
	if ( event == "VARIABLES_LOADED" ) then
			CharactersViewer.Init = true;			
			if ( Khaos ) then
				CharactersViewer.register.Khaos();			-- The register.Khaos handle Khaos presence of not
				-- Defaulting is handled by Khaos
				-- Applying is handled by Khaos callback
			else
				-- Prepare the OptionFrame
				CharactersViewer.OptionFrame.Default();  	-- Apply default to config that are new
				CharactersViewer.OptionFrame.Apply(); 		-- (use callback)
				CharactersViewer.OptionFrame.ReDraw();		-- Draw the Option frame with loaded option
	
			end
	end
end

CharactersViewer.register = {};
function CharactersViewer.register.event()
	CVCharacterFrame:RegisterEvent("PLAYER_ENTERING_WORLD");
	CVCharacterFrame:RegisterEvent("VARIABLES_LOADED");
	
end

CharactersViewer.register.cosmos = function ()                                        -- Cosmos Button Support --
	if( EarthFeature_AddButton ) then
		EarthFeature_AddButton (
			{
				id = "CharactersViewer";
				name = BINDING_HEADER_CHARACTERSVIEWER;
				subtext = CHARACTERSVIEWER_SHORT_DESC;
				tooltip = CHARACTERSVIEWER_DESCRIPTION;
				icon = CHARACTERSVIEWER_ICON;
				callback = CharactersViewer.Toggle;
				test = nil;
			}
		);
	elseif(Cosmos_RegisterButton) then
		Cosmos_RegisterButton (
			BINDING_HEADER_CHARACTERSVIEWER,
			CHARACTERSVIEWER_SHORT_DESC,
			CHARACTERSVIEWER_DESCRIPTION,
			CHARACTERSVIEWER_ICON,
			CharactersViewer.Toggle
		);
	end
end;

function CharactersViewer.register.Khaos()
	if (Khaos) then
		Khaos.registerOptionSet (
			"inventory",
			{
				id="CharactersViewer";
				text=function() return TEXT(BINDING_HEADER_CHARACTERSVIEWER) end;
				helptext=function() return TEXT(CHARACTERSVIEWER_HELP) end;
				--callback=function(state) Wardrobe.Toggle(state and 1); end;
				--feedback=function(state) return state and TEXT("TXT_ENABLED") or TEXT("TXT_DISABLED") end;
				difficulty=1;
				--default={checked=true};
				default={checked=true};
				options={
					{
						id = "Header";
						text = function() return TEXT(BINDING_HEADER_CHARACTERSVIEWER .. " " .. CharactersViewer.version.text) end;
						helptext = function() return TEXT("cv help") end;
						type = K_HEADER;
					};
					{
						id = "Scaling";
						text = function() return TEXT(CHARACTERSVIEWER_OPTIONS.Scaling.TEXT) end;
						helptext = function() return TEXT(CHARACTERSVIEWER_OPTIONS.Scaling.TEXT) end;
						feedback = function(state) 
							if (state.checked) then
								return TEXT(CHARACTERSVIEWER_OPTIONS.Scaling.FEEDBACK1);
							else
								return TEXT(CHARACTERSVIEWER_OPTIONS.Scaling.FEEDBACK2);
							end
						end;
						callback = function(state)
							CharactersViewer.Api.SetConfig( "Scaling", state.checked );
							--getglobal(CHARACTERSVIEWER_OPTIONS.Scaling.CALLBACK)() 
							end;
						check = true;
						type = K_CHECKBOX;
						default = {
							checked = CHARACTERSVIEWER_OPTIONS.Scaling.DEFAULT;
						};
						disabled = {
							checked = false;
						};
					};
					{
						id = "MovableBankFrame";
						text = function() return TEXT(CHARACTERSVIEWER_OPTIONS.MovableBankFrame.TEXT) end;
						helptext = function() return TEXT(CHARACTERSVIEWER_OPTIONS.MovableBankFrame.TEXT) end;
						feedback = function(state) 
							if (state.checked) then
								return TEXT(CHARACTERSVIEWER_OPTIONS.MovableBankFrame.FEEDBACK1);
							else
								return TEXT(CHARACTERSVIEWER_OPTIONS.MovableBankFrame.FEEDBACK2);
							end
						end;
						callback = function(state)
							CharactersViewer.Api.SetConfig( "MovableBankFrame", state.checked );
							getglobal(CHARACTERSVIEWER_OPTIONS.MovableBankFrame.CALLBACK)() 
							end;
						check = true;
						type = K_CHECKBOX;
						default = {
							checked = CHARACTERSVIEWER_OPTIONS.MovableBankFrame.DEFAULT;
						};
						disabled = {
							checked = false;
						};
					};
					{
						id = "MovableMainFrame";
						text = function() return TEXT(CHARACTERSVIEWER_OPTIONS.MovableMainFrame.TEXT) end;
						helptext = function() return TEXT(CHARACTERSVIEWER_OPTIONS.MovableMainFrame.TEXT) end;
						feedback = function(state) 
							if (state.checked) then
								return TEXT(CHARACTERSVIEWER_OPTIONS.MovableMainFrame.FEEDBACK1);
							else
								return TEXT(CHARACTERSVIEWER_OPTIONS.MovableMainFrame.FEEDBACK2);
							end
						end;
						callback = function(state)
							CharactersViewer.Api.SetConfig( "MovableMainFrame", state.checked );
							getglobal(CHARACTERSVIEWER_OPTIONS.MovableMainFrame.CALLBACK)() 
							end;
						check = true;
						type = K_CHECKBOX;
						default = {
							checked = CHARACTERSVIEWER_OPTIONS.MovableMainFrame.DEFAULT;
						};
						disabled = {
							checked = false;
						};
					};
				}
			}
		)
	end
end

CharactersViewer.register.myaddon = function ()                                       -- Interoperability MyAddOns --
	if(myAddOnsFrame_Register) then
		temp =
			{	name = 'CharactersViewer',
				version = CharactersViewer.version.number,
				releaseDate = CharactersViewer.version.date,
				author = 'Flisher',
				email = 'flisher@gmail.com',
				website = 'http://www.curse-gaming.com/mod.php?addid=490',
				category = MYADDONS_CATEGORY_INVENTORY,
				optionsframe = ''
			};
		myAddOnsFrame_Register(temp, CHARACTERSVIEWER_USAGE_SUBCMD);
	end
end;

CharactersViewer.register.ctmod = function()
	if(CT_RegisterMod) then
		CT_RegisterMod(BINDING_HEADER_CHARACTERSVIEWER, CHARACTERSVIEWER_SHORT_DESC, 4, "Interface\\Buttons\\Button-Backpack-Up", CHARACTERSVIEWER_DESCRIPTION, "switch", "", CharactersViewer.Toggle);
	end
end;

CharactersViewer.register.slashcmd = function ()
	-- Register the SlashCommand in the system
	--! todo: Regster thing with cosmos slashcmd
	SlashCmdList["CHARACTERSVIEWER"] = function(msg)
		CharactersViewer.SlashCmd(msg);
	end
end;

CharactersViewer.Toggle = function()
        if(CVCharacterFrame:IsVisible()) then
            CharactersViewer.Hide();
        else
            CharactersViewer.Show();
        end
    end;

CharactersViewer.SlashCmd = function(msg)    -- CharactersViewer.SlashCmd()
	-- get the parameter from the ShashCmd
	param = CharactersViewer.Api.splitstring(msg);

	if( param[0] and strlen(param[0]) > 0 ) then
		param[0] = strlower(param[0]);
	end
	if( msg and strlen(msg) > 0 ) then
		msg = strlower(msg);
	end

	if(msg == CHARACTERSVIEWER_SUBCMD_SHOW) then
		CharactersViewer.Show();
	
	elseif(msg == CHARACTERSVIEWER_SUBCMD_PREVIOUS) then
		CharactersViewer.Api.Switch(-1);

	elseif(msg == CHARACTERSVIEWER_SUBCMD_NEXT) then
		CharactersViewer.Api.Switch(1);
	
	elseif(msg == "") then
		CharactersViewer.Toggle();

	elseif(param[0] == CHARACTERSVIEWER_SUBCMD_SWITCH) then
		if(not param[1] ) then
		param[1] = UnitName("player");  --! todo: use the new blizzard function
		end
		CharactersViewer.Api.Switch(param[1]);
	elseif(msg == CHARACTERSVIEWER_SUBCMD_BANK) then
		CharactersViewer.BankFrame.Toggle(-1);
	elseif(msg == CHARACTERSVIEWER_SUBCMD_BAGS) then
		CharactersViewer_Bags();
	elseif(msg == CHARACTERSVIEWER_SUBCMD_BAGUSE) then
		CharactersViewer_Bags('use');
	else
		cvprint(CHARACTERSVIEWER_USAGE);
		local index, subcmdUsage;
		for index, subcmdUsage in CHARACTERSVIEWER_USAGE_SUBCMD do
			if(subcmdUsage) then
				cvprint(subcmdUsage);
			end
		end
	end
end;

function CharactersViewer.Hide ()
	CVCharacterFrame:Hide();
	--PlaySound("igMainMenuClose");
end;

function CharactersViewer.SaveScale(param)
	if (param == nil) then
		if (CharactersViewer.Api.GetConfig("Scaling") == true ) then
			param = floor (0.64 * 1 / UIParent:GetScale() *100) /100;
		else
			param = 1;
		end
	end
	CharactersViewer.Api.SetConfig("Scale", param);
end

function CharactersViewer.SetScale()
	CharactersViewer.SaveScale();	
	CVCharacterFrame:SetScale(CharactersViewerConfig.Scale);
	CVBankFrame:SetScale(CharactersViewerConfig.Scale);
end

function CharactersViewer.Show()
	-- Rescan modified thing
	if (rpgoCP_EventHandler ~= nil ) then
		rpgoCP_EventHandler('RPGOCP_SCAN');
	end

	CharactersViewer.SetScale();
	
	if(CVCharacterFrame:IsVisible()) then
		HideUIPanel(CVCharacterFrame);
		ShowUIPanel(CVCharacterFrame);
	else
		ShowUIPanel(CVCharacterFrame);
	end
	CharactersViewer.BankFrame.Toggle(CharactersViewerConfig.ShowBank);
	
	CharactersViewer.xml.DropDown_SetText();
end;


-- Legacy Support
CHARACTERSVIEWER_VERSION = CharactersViewer.version.number;

CharactersViewer.constant = {};
CharactersViewer.constant.inventorySlot = {};
CharactersViewer.constant.inventorySlot.Name =
	{  	
		[0] = AMMOSLOT, 				-- 0
		[1] = HEADSLOT,				-- 1
		[2] = NECKSLOT,				-- 2
		[3] = SHOULDERSLOT,			-- 3
		[4] = SHIRTSLOT,				-- 4
		[5] = CHESTSLOT,				-- 5
		[6] = WAISTSLOT,				-- 6
		[7] = LEGSSLOT,				-- 7
		[8] = FEETSLOT,				-- 8
		[9] = WRISTSLOT,				-- 9
		[10] = HANDSSLOT,				-- 10
		[11] = FINGER0SLOT,			-- 11
		[12] = FINGER1SLOT,			-- 12
		[13] = TRINKET0SLOT,			-- 13
		[14] = TRINKET1SLOT,			-- 14
		[15] = BACKSLOT,				-- 15
		[16] = MAINHANDSLOT,			-- 16
		[17] = SECONDARYHANDSLOT, 	-- 17
		[18] = RANGEDSLOT,			-- 18
		[19] = TABARDSLOT,			-- 19
	};

CharactersViewer.constant.inventorySlot.Texture =
	{  
		[0] = ({GetInventorySlotInfo("AMMOSLOT")})[2],             -- 0
		[1] = ({GetInventorySlotInfo("HEADSLOT")})[2],            -- 1
		[2] = ({GetInventorySlotInfo("NECKSLOT")})[2],            -- 2
		[3] = ({GetInventorySlotInfo("SHOULDERSLOT")})[2],       -- 3
		[4] = ({GetInventorySlotInfo("SHIRTSLOT")})[2],          -- 4
		[5] = ({GetInventorySlotInfo("CHESTSLOT")})[2],          -- 5
		[6] = ({GetInventorySlotInfo("WAISTSLOT")})[2],          -- 6
		[7] = ({GetInventorySlotInfo("LEGSSLOT")})[2],            -- 7
		[8] = ({GetInventorySlotInfo("FEETSLOT")})[2],            -- 8
		[9] = ({GetInventorySlotInfo("WRISTSLOT")})[2],          -- 9
		[10] = ({GetInventorySlotInfo("HANDSSLOT")})[2],             -- 10
		[11] = ({GetInventorySlotInfo("FINGER0SLOT")})[2],        -- 11
		[12] = ({GetInventorySlotInfo("FINGER1SLOT")})[2],        -- 12
		[13] = ({GetInventorySlotInfo("TRINKET0SLOT")})[2],      -- 13
		[14] = ({GetInventorySlotInfo("TRINKET1SLOT")})[2],      -- 14
		[15] = ({GetInventorySlotInfo("BACKSLOT")})[2],           -- 15
		[16] = ({GetInventorySlotInfo("MAINHANDSLOT")})[2],      -- 16
		[17] = ({GetInventorySlotInfo("SECONDARYHANDSLOT")})[2],  -- 17
		[18] = ({GetInventorySlotInfo("RANGEDSLOT")})[2],           -- 18
		[19] = ({GetInventorySlotInfo("TABARDSLOT")})[2],           -- 19
	};


if (CharactersViewer.xml  == nil ) then	
	CharactersViewer.xml = {};
end

function CharactersViewer.xml.DropDown_Initialize()
	if ( CharactersViewer.index ~= nil ) then
		local info = {};
		if ( CharactersViewerConfig == nil or CharactersViewerConfig.MultipleServer == nil or CharactersViewerConfig.MultipleServer == false) then
			CharactersViewerConfig.MultipleServer = false;
		else
			CharactersViewerConfig.MultipleServer = true;
		end
	 
		local playerlist = CharactersViewer.Api.GetCharactersList(CharactersViewerConfig.MultipleServer);
		for index, charactername in playerlist do
			info.text = charactername;
			--info.value = charactername;
			info.func = CharactersViewer.xml.DropDown_OnClick;
			--info.notCheckable = nil;
			--info.keepShownOnClick = nil;
			UIDropDownMenu_AddButton(info);
		end
	end
end

function CharactersViewer.xml.DropDown_SetText()
	-- Reinitialize Dropdown text:
	UIDropDownMenu_SetText(CHARACTERSVIEWER_SELPLAYER, getglobal("CVPaperDollFrameDropDown1"));
	if ( CharactersViewer.index ~= nil) then
		UIDropDownMenu_SetText(CharactersViewer.index, getglobal("CVPaperDollFrameDropDown2") );
		UIDropDownMenu_SetText(CharactersViewer.index, getglobal("CVPaperDollFrameDropDown3") );
	else
		UIDropDownMenu_SetText(CHARACTERSVIEWER_SELPLAYER, getglobal("CVPaperDollFrameDropDown2"));
		UIDropDownMenu_SetText(CHARACTERSVIEWER_SELPLAYER, getglobal("CVPaperDollFrameDropDown3"));
	end
end

function CharactersViewer.xml.DropDown_OnClick()
   CharactersViewer.Api.Switch(this.value);
	if ( CVCharacterFrame:IsVisible() ~= 1) then
		CharactersViewer.Show();
	end
	
end

function CharactersViewer.xml.DropDown_OnLoad(param)                      -- Checked by Flisher 2005-05-31
    --! enable/disable checkup on this
	UIDropDownMenu_Initialize(this, CharactersViewer.xml.DropDown_Initialize);
	UIDropDownMenu_SetWidth(80, this);
end

if ( CharactersViewer.Api == nil ) then
	CharactersViewer.Api = {};
end

function CharactersViewer.Api.GetCharactersList(option)
	local temp = {};
	local i = 0;
	if ( CharactersViewer.indexServer ~= nil and myProfile ~= nil ) then
		if (option ~= true) then
			for index, item in myProfile[CharactersViewer.indexServer] do
				if ( index ~= "Guild") then
					temp[i] = index;
					i = i +1;
				end
			end
		else
			---- todo: add servers
		end
	end
	return temp;
end

CharactersViewer.Api.Switch = function (character,server)
	if(character == nil) then
		character = UnitName("player");
	end

	if(server == nil) then
		server = GetRealmName();
	end
	
	if(character == -1 or character == 1 and myProfile ~= nil and myProfile[server] ~= nil) then
		local current = 0;
		local i = 0;
		local temp = {};
		for j, name in myProfile[server] do
			i = i + 1;
			temp[i] = j;
			if(j == CharactersViewer.index ) then
				current = i;
			end
		end
		current = current + character;
		if(current <= 0) then
			 character = temp[i];
		elseif(current > i) then
			 character = temp[1];
		else
			 character = temp[current];
		end
	end

	-- Switch the current characterviwer character
	local choice2 = string.upper(string.sub(character, 1,1)) .. string.lower(string.sub(character , 2));  -- Make the first character upper, all the other lowercase.
	if( myProfile[server] ~= nil and myProfile[server][character] ~= nil) then
		CharactersViewer.index = character;
		CharactersViewer.indexServer = server;
		CharactersViewerCurrentIndex = CharactersViewer.index;        -- Backward compatibility
	elseif( myProfile[server] ~= nil and myProfile[server][choice2] ~= nil) then
		CharactersViewer.index = choice2;
		CharactersViewer.indexServer = server;
		CharactersViewerCurrentIndex = CharactersViewer.index;        -- Backward compatibility
	else
		cvprint(CHARACTERSVIEWER_NOT_FOUND .. server .. character);
		CharactersViewer.Hide();
	end

	if(CVCharacterFrame ~= nil and CVCharacterFrame:IsVisible() ) then
		CharactersViewer.Show();
	end
	
	if( CVBankFrame ~= nil and CVBankFrame:IsVisible() == 1) then
		-- CharactersViewer.BankFrame.DrawMainBag();
		CharactersViewer.BankFrame.Show();
	end

 end;
	
function CharactersViewer.rpgoInit()
	if ( CharactersViewer.Initialized == nil ) then
		rpgoCP_EventHandler('RPGOCP_SCAN');	
		CharactersViewer.Api.Switch();
		CharactersViewer.xml.DropDown_Initialize()
		CharactersViewer.xml.DropDown_SetText()	
		CharactersViewer.Initialized = true;
	end
end




local locClass,engClass = UnitClass("player");

if ( engClass == "ROGUE" or engClass == "DRUID" ) then

	timeTick = nil;
	debugTick = 0;

	Tick_Status = {
		["tick"] = 2,
		["tickstart"] = 0,
		["tickend"] = 0,
		["currEnergy"] = 0,
		["currPoints"] = 0,
	};

	function Tick_CPClick()
		if ( ColorPickerFrame:IsShown() ) then
			ColorPickerFrame:Hide()
		else
			local currRed,currGreen,currBlue = unpack(Tick_Opts[this.whenindex]);
			ColorPickerFrame.whenindex = this.whenindex;
			ColorPickerFrame.func = Tick_CPColorChanged
			ColorPickerFrame.cancelFunc = ColorPickerFrame:Hide()
			ColorPickerFrame:SetColorRGB(currRed, currGreen, currBlue)
			ColorPickerFrame:Show();
		end
	end

	function Tick_CPColorChanged()
		local red,green,blue = ColorPickerFrame:GetColorRGB()
		if ( ColorPickerFrame:IsShown() ) then
			return;
		else
			Tick_Opts[ColorPickerFrame.whenindex][1] =  red;
			Tick_Opts[ColorPickerFrame.whenindex][2] =  green;
			Tick_Opts[ColorPickerFrame.whenindex][3] =  blue;
			Tick_SetColors();
		end
	end

	function Tick_SetColors()
		TickStatusBar:SetStatusBarColor(Tick_Opts["barColor"][1],Tick_Opts["barColor"][2],Tick_Opts["barColor"][3]);
		TickExampleStatusBar:SetStatusBarColor(Tick_Opts["barColor"][1],Tick_Opts["barColor"][2],Tick_Opts["barColor"][3]);
		getglobal("TickBarText"):SetTextColor(Tick_Opts["textColor"][1],Tick_Opts["textColor"][2],Tick_Opts["textColor"][3]);
		if ( Tick_CheckOpts[20].enabled == 1 ) then
			getglobal("TickBarText"):SetShadowColor(0,0,0,0);
		else
			getglobal("TickBarText"):SetShadowColor(Tick_Opts["textShadowColor"][1],Tick_Opts["textShadowColor"][2],Tick_Opts["textShadowColor"][3]);
		end
	end

	function Tick_ChangeScale(int)
		if ( not int or type(int) ~= "number" ) then
			return;
		else
			local newscale = int;
			local oldscale = TickBar:GetScale();
			local sizeY = TickBar:GetTop() * oldscale;
			local sizeX = TickBar:GetLeft() * oldscale;
			getglobal(this:GetName().."Text"):SetText(TICK_BAR_SCALE_HEADER.." "..newscale);
			Tick_Opts.barScale = newscale;
			TickBar:SetScale(newscale);
			TickBar:ClearAllPoints();
			TickBar:SetPoint("TOPLEFT","UIParent","BOTTOMLEFT",sizeX/newscale,sizeY/newscale);
		end
	end

	function Tick_ChangeFontSize(int)
		if ( not int or type(int) ~= "number" ) then
			return;
		else
			local newsize = int;
			getglobal(this:GetName().."Text"):SetText(TICK_BAR_FONT_SIZE_HEADER.." "..newsize);
			Tick_Opts.textSize = newsize;
			getglobal("TickBarText"):SetFont(TickBarText:GetFont(),newsize);
		end
	end

	function Tick_ChangeBarTexture(int)
		if ( not int or type(int) ~= "number" ) then
			return;
		else
			local texture = int;
			getglobal(this:GetName().."Text"):SetText(TICK_BAR_TEXTURE_HEADER.." "..texture);
			Tick_Opts.useTexture = texture;
			TickStatusBar:SetStatusBarTexture(Tick_TextureArr[Tick_Opts.useTexture]);
			TickExampleStatusBar:SetStatusBarTexture(Tick_TextureArr[Tick_Opts.useTexture]);
		end
	end

	function Tick_ChangeBarOpacity(int)
		if ( not int or type(int) ~= "number" ) then
			return;
		else
			local newopac = int
			getglobal(this:GetName().."Text"):SetText(TICK_BAR_OPACITY_HEADER.." "..newopac);
			Tick_Opts.barOpacity = newopac;
			TickBar:SetAlpha((newopac/100));
		end
	end

	function Tick_ChangeDimensions(h,w)
		local height = tonumber(h);
		local width = tonumber(w);
		if ( type(height) == "number" and type(width) == "number" ) then
			if ( height >= 0 and width >= 0 ) then
				TickBar:SetHeight(22+height);
				TickBar:SetWidth(116+width);
				TickStatusBar:SetHeight(14+height);
				TickStatusBar:SetWidth(106+width);
				TickSpark:SetHeight(38+height);
				TickTextureStatusBarBackground:SetHeight(24+height);
				TickTextureStatusBarBackground:SetWidth(116+width);
				TickBarText:SetHeight(22+height);
				TickBarText:SetWidth(116+width);
				TickBarEnergy:SetHeight(22+h);
				TickBarEnergy:SetWidth(100+w);
				TickStatusBarEnergy:SetHeight(9+h);
				TickStatusBarEnergy:SetWidth(91+w);
				TickTextureStatusBarEnergyBackground:SetHeight(19+height);
				TickTextureStatusBarEnergyBackground:SetWidth(102+width);
			end
		end
	end

	function Tick_UpdateText(str)
		if ( Tick_CheckOpts[4].enabled == 1 ) then
			local newtext;

			if ( UnitPowerType("player") ~= 3 ) then
				newtext = TICK_MISC_NOT_IN_CATFORM;
			else
				newtext = Tick_Opts.barText;
				newtext,_ = string.gsub(newtext,"&e", Tick_Status.currEnergy, 1);
				newtext,_ = string.gsub(newtext,"&c", Tick_Status.currPoints, 1);
				newtext,_ = string.gsub(newtext,"&m", UnitManaMax("player"), 1);
				newtext,_ = string.gsub(newtext,"&h", UnitHealth("player"), 1);
				newtext,_ = string.gsub(newtext,"&o", UnitHealthMax("player"), 1);
				if ( UnitName("target") ) then
					if ( Tick_CheckOpts[26].enabled == 1 ) then
						local tType = Tick_CheckTarget();
						if ( tType == 1 or tType == 3 ) then
							newtext,_ = string.gsub(newtext,"&u", "|cffDD0000"..UnitName("target").."|r", 1);
						elseif ( tType == 2 or tType == 4 ) then
							newtext,_ = string.gsub(newtext,"&u", "|cff00DD00"..UnitName("target").."|r", 1);
						end
					else
						newtext,_ = string.gsub(newtext,"&u", UnitName("target"), 1);
					end
				else
					newtext,_ = string.gsub(newtext,"&u", "No Target", 1);
				end
				if ( timeTick ~= nil ) then
					newtext,_ = string.gsub(newtext,"&t", timeTick, 1);
				end
			end

			if ( Tick_CheckOpts[6].enabled == 1 ) then
				getglobal("TickBarText"):SetText(newtext);			
			elseif ( str == "force" and Tick_CheckOpts[5].enabled == 1 ) then
				getglobal("TickBarText"):SetText(newtext);
			elseif ( Tick_CheckOpts[16].enabled == 1 ) then
				if ( Tick_Opts.engaged == 1 ) then
					getglobal("TickBarText"):SetText(newtext);
				else
					getglobal("TickBarText"):SetText("");
				end
			elseif ( Tick_CheckOpts[15].enabled == 1 ) then
				if ( Tick_CheckTarget() ~= nil ) then
					getglobal("TickBarText"):SetText(newtext);
				else
					getglobal("TickBarText"):SetText("");
				end
			end
		end
		Tick_SetColors();
	end

	function Tick_ChangeTab(int)
		if ( not int  or type(int) ~= "number" ) then
			return;
		else
			local currTab = Tick_Opts.lastTab;
			getglobal("TickOptsTabFrame"..(currTab)):Hide();
			getglobal("TickOptsTabFrame"..(currTab + int)):Show();
			Tick_Opts.lastTab = currTab + int;
			if ( getglobal("TickOptsTabFrame"..(Tick_Opts.lastTab+1)) ) then
				getglobal("TickOptionsPageUp"):Enable();
			else
				getglobal("TickOptionsPageUp"):Disable();
			end
			if ( getglobal("TickOptsTabFrame"..(Tick_Opts.lastTab-1)) ) then
				getglobal("TickOptionsPageDown"):Enable();
			else
				getglobal("TickOptionsPageDown"):Disable();
			end
		end
	end

	function Tick_CheckOnShow()
		local boxid = this:GetID();
		getglobal("TickButton"..boxid.."Text"):SetText(Tick_CheckOpts[boxid].name);
		if ( Tick_CheckOpts[boxid].enabled == 1 ) then
			this:SetChecked(1);
		else
			this:SetChecked(0);
		end
	end

	function Tick_SwitchStateLoad()
		if ( Tick_CheckOpts[14].enabled == 1 ) then
			Tick_CheckOpts[1].enabled = 0;
			Tick_CheckOpts[14].enabled = 1;
			Tick_CheckOpts[9].enabled = 0;
			TickButton1:SetChecked(0);
			TickButton14:SetChecked(1);
			TickButton9:SetChecked(0);
			Tick_Children("hide",2,10,11,12,13);			
		elseif ( Tick_CheckOpts[1].enabled == 1 ) then
			Tick_CheckOpts[1].enabled = 1;
			Tick_CheckOpts[14].enabled = 0;
			Tick_CheckOpts[9].enabled = 0;
			TickButton1:SetChecked(1);
			TickButton14:SetChecked(0);
			TickButton9:SetChecked(0);
			Tick_Children("show",2);
			Tick_Children("hide",10,11,12,13);
		elseif ( Tick_CheckOpts[9].enabled == 1 ) then
			Tick_CheckOpts[1].enabled = 0;
			Tick_CheckOpts[14].enabled = 0;
			Tick_CheckOpts[9].enabled = 1;
			TickButton1:SetChecked(0);
			TickButton14:SetChecked(0);
			TickButton9:SetChecked(1);
			Tick_Children("hide",2);
			Tick_Children("show",10,11,12,13);
		end


		if ( Tick_CheckOpts[5].enabled == 1 ) then
			Tick_CheckOpts[5].enabled = 1;
			Tick_CheckOpts[6].enabled = 0;
			Tick_CheckOpts[15].enabled = 0;
			Tick_CheckOpts[16].enabled = 0;
			TickButton5:SetChecked(1);
			TickButton6:SetChecked(0);
			TickButton15:SetChecked(0);
			TickButton16:SetChecked(0);
		elseif ( Tick_CheckOpts[6].enabled == 1 ) then
			Tick_CheckOpts[5].enabled = 0;
			Tick_CheckOpts[6].enabled = 1;
			Tick_CheckOpts[15].enabled = 0;
			Tick_CheckOpts[16].enabled = 0;
			TickButton5:SetChecked(0);
			TickButton6:SetChecked(1);
			TickButton15:SetChecked(0);
			TickButton16:SetChecked(0);
		elseif ( Tick_CheckOpts[15].enabled == 1 ) then
			Tick_CheckOpts[5].enabled = 0;
			Tick_CheckOpts[6].enabled = 0;
			Tick_CheckOpts[15].enabled =1;
			Tick_CheckOpts[16].enabled = 0;
			TickButton5:SetChecked(0);
			TickButton6:SetChecked(0);
			TickButton15:SetChecked(1);
			TickButton16:SetChecked(0);
		elseif ( Tick_CheckOpts[16].enabled == 1 ) then
			Tick_CheckOpts[5].enabled = 0;
			Tick_CheckOpts[6].enabled = 0;
			Tick_CheckOpts[15].enabled = 0;
			Tick_CheckOpts[16].enabled = 1;
			TickButton5:SetChecked(0);
			TickButton6:SetChecked(0);
			TickButton15:SetChecked(0);
			TickButton16:SetChecked(1);
		end

		if ( Tick_CheckOpts[23].enabled == 1 ) then
			Tick_CheckOpts[22].enabled = 0;
			Tick_CheckOpts[23].enabled = 1;
			TickButton22:SetChecked(0);
			TickButton23:SetChecked(1);
		elseif ( Tick_CheckOpts[22].enabled == 1 ) then
			Tick_CheckOpts[22].enabled = 1;
			Tick_CheckOpts[23].enabled = 0;
			TickButton22:SetChecked(1);
			TickButton23:SetChecked(0);
		end
	end

	function Tick_SwitchState()
		local boxid = this:GetID();
		getglobal("TickButton"..boxid.."Text"):SetText(Tick_CheckOpts[boxid].name);
		if ( boxid == 14 ) then
			if ( Tick_CheckOpts[14].enabled == 1 ) then
				Tick_CheckOpts[1].enabled = 1;
				Tick_CheckOpts[14].enabled = 0;
				Tick_CheckOpts[9].enabled = 0;
				TickButton1:SetChecked(1);
				TickButton14:SetChecked(0);
				TickButton9:SetChecked(0);
				Tick_Children("show",2);
				Tick_Children("hide",10,11,12,13);
			elseif ( Tick_CheckOpts[14].enabled == 0 ) then
				Tick_CheckOpts[1].enabled = 0;
				Tick_CheckOpts[14].enabled = 1;
				Tick_CheckOpts[9].enabled = 0;
				TickButton1:SetChecked(0);
				TickButton14:SetChecked(1);
				TickButton9:SetChecked(0);
				Tick_Children("hide",2,10,11,12,13);
			end
		elseif ( boxid == 1 ) then
			if ( Tick_CheckOpts[1].enabled == 1 ) then
				Tick_CheckOpts[1].enabled = 0;
				Tick_CheckOpts[14].enabled = 1;
				Tick_CheckOpts[9].enabled = 0;
				TickButton1:SetChecked(0);
				TickButton14:SetChecked(1);
				TickButton9:SetChecked(0);
				Tick_Children("hide",2,10,11,12,13);
			elseif ( Tick_CheckOpts[1].enabled == 0 ) then
				Tick_CheckOpts[1].enabled = 1;
				Tick_CheckOpts[14].enabled = 0;
				Tick_CheckOpts[9].enabled = 0;
				TickButton1:SetChecked(1);
				TickButton14:SetChecked(0);
				TickButton9:SetChecked(0);
				Tick_Children("show",2);
				Tick_Children("hide",10,11,12,13);
			end
		elseif ( boxid == 9 ) then
			if ( Tick_CheckOpts[9].enabled == 1 ) then
				Tick_CheckOpts[1].enabled = 1;
				Tick_CheckOpts[14].enabled = 0;
				Tick_CheckOpts[9].enabled = 0;
				TickButton1:SetChecked(1);
				TickButton14:SetChecked(0);
				TickButton9:SetChecked(0);
				Tick_Children("show",2);
				Tick_Children("hide",10,11,12,13);
			elseif ( Tick_CheckOpts[9].enabled == 0 ) then
				Tick_CheckOpts[1].enabled = 0;
				Tick_CheckOpts[14].enabled = 0;
				Tick_CheckOpts[9].enabled = 1;
				TickButton1:SetChecked(0);
				TickButton14:SetChecked(0);
				TickButton9:SetChecked(1);
				Tick_Children("hide",2);
				Tick_Children("show",10,11,12,13);
			end
		elseif ( boxid == 5 ) then
			if ( Tick_CheckOpts[5].enabled == 1 ) then
				Tick_CheckOpts[15].enabled = 0;
				Tick_CheckOpts[16].enabled = 0;
				Tick_CheckOpts[6].enabled = 1;
				Tick_CheckOpts[5].enabled = 0;
				TickButton15:SetChecked(0);
				TickButton16:SetChecked(0);
				TickButton6:SetChecked(1);
				TickButton5:SetChecked(0);
			elseif ( Tick_CheckOpts[5].enabled == 0 ) then
				Tick_CheckOpts[6].enabled = 0;
				Tick_CheckOpts[15].enabled = 0;
				Tick_CheckOpts[16].enabled = 0;
				Tick_CheckOpts[5].enabled = 1;
				TickButton16:SetChecked(0);
				TickButton6:SetChecked(0);
				TickButton15:SetChecked(0);
				TickButton5:SetChecked(1);
				getglobal("TickBarText"):SetText("");
			end
		elseif ( boxid == 6 ) then
			if ( Tick_CheckOpts[6].enabled == 1 ) then
				Tick_CheckOpts[15].enabled = 1;
				Tick_CheckOpts[16].enabled = 0;
				Tick_CheckOpts[5].enabled = 0;
				Tick_CheckOpts[6].enabled = 0;
				TickButton6:SetChecked(0);
				TickButton16:SetChecked(0);
				TickButton5:SetChecked(0);
				TickButton15:SetChecked(1);
				getglobal("TickBarText"):SetText("");
			elseif ( Tick_CheckOpts[6].enabled == 0 ) then
				Tick_CheckOpts[15].enabled = 0;
				Tick_CheckOpts[16].enabled = 0;
				Tick_CheckOpts[5].enabled = 0;
				Tick_CheckOpts[6].enabled = 1;
				TickButton6:SetChecked(1);
				TickButton5:SetChecked(0);
				TickButton16:SetChecked(0);
				TickButton15:SetChecked(0);
			end
		elseif ( boxid == 15 ) then
			if ( Tick_CheckOpts[15].enabled == 1 ) then
				Tick_CheckOpts[15].enabled = 0;
				Tick_CheckOpts[6].enabled = 1;
				Tick_CheckOpts[5].enabled = 0;
				Tick_CheckOpts[16].enabled = 0;
				TickButton6:SetChecked(1);
				TickButton16:SetChecked(0);
				TickButton5:SetChecked(0);
				TickButton15:SetChecked(0);
			elseif ( Tick_CheckOpts[15].enabled == 0 ) then
				Tick_CheckOpts[15].enabled = 1;
				Tick_CheckOpts[6].enabled = 0;
				Tick_CheckOpts[5].enabled = 0;
				Tick_CheckOpts[16].enabled = 0;
				TickButton15:SetChecked(1);
				TickButton6:SetChecked(0);
				TickButton16:SetChecked(0);
				TickButton5:SetChecked(0);
			end
		elseif ( boxid == 16 ) then
			if ( Tick_CheckOpts[16].enabled == 1 ) then
				Tick_CheckOpts[15].enabled = 0;
				Tick_CheckOpts[6].enabled = 1;
				Tick_CheckOpts[5].enabled = 0;
				Tick_CheckOpts[16].enabled = 0;
				TickButton6:SetChecked(1);
				TickButton16:SetChecked(0);
				TickButton5:SetChecked(0);
				TickButton15:SetChecked(0);
			elseif ( Tick_CheckOpts[16].enabled == 0 ) then
				Tick_CheckOpts[15].enabled = 0;
				Tick_CheckOpts[6].enabled = 0;
				Tick_CheckOpts[5].enabled = 0;
				Tick_CheckOpts[16].enabled = 1;
				TickButton6:SetChecked(0);
				TickButton16:SetChecked(1);
				TickButton5:SetChecked(0);
				TickButton15:SetChecked(0);
			end
		elseif ( boxid == 22 ) then
			if ( Tick_CheckOpts[22].enabled == 1 ) then
				Tick_CheckOpts[22].enabled = 0;
				Tick_CheckOpts[23].enabled = 1;
				TickButton22:SetChecked(0);
				TickButton23:SetChecked(1);
			elseif ( Tick_CheckOpts[22].enabled == 0 ) then
				Tick_CheckOpts[22].enabled = 1;
				Tick_CheckOpts[23].enabled = 0;
				TickButton22:SetChecked(1);
				TickButton23:SetChecked(0);
			end
		elseif ( boxid == 23 ) then
			if ( Tick_CheckOpts[23].enabled == 1 ) then
				Tick_CheckOpts[22].enabled = 1;
				Tick_CheckOpts[23].enabled = 0;
				TickButton22:SetChecked(1);
				TickButton23:SetChecked(0);
			elseif ( Tick_CheckOpts[23].enabled == 0 ) then
				Tick_CheckOpts[22].enabled = 0;
				Tick_CheckOpts[23].enabled = 1;
				TickButton22:SetChecked(0);
				TickButton23:SetChecked(1);
			end
		end
	end

	function Tick_CheckOnClick()
		local boxid = this:GetID();
		if ( Tick_CheckOpts[boxid].enabled == 1 ) then
			Tick_CheckOpts[boxid].enabled = 0;
		else
			Tick_CheckOpts[boxid].enabled = 1;
		end
	end

	function Tick_Children(type,id1,id2,id3,id4,id5,id6,id7)
		local Tick_ChildArr = {
			[1] = id1,
			[2] = id2,
			[3] = id3,
			[4] = id4,
			[5] = id5,
			[6] = id6,
			[7] = id7,
		};
		if ( not id1 or not type ) then
			return;
		else
			local parentbox = this:GetID();
			for i=1,table.getn(Tick_ChildArr),1 do
				if ( getglobal("TickButton"..Tick_ChildArr[i]) ) then
					if ( type == "hide" ) then
						getglobal("TickButton"..Tick_ChildArr[i]):Disable();
						getglobal("TickButton"..Tick_ChildArr[i].."Text"):SetTextColor(0.5,0.5,0.5);
					elseif ( type == "show" ) then
						getglobal("TickButton"..Tick_ChildArr[i]):Enable();
						getglobal("TickButton"..Tick_ChildArr[i].."Text"):SetTextColor(1,0.81,0);
					else
						return;
					end
				end
			end
		end
	end

	function Tick_UpdateVer()
		if ( not Tick_Opts or Tick_Opts.version ~= 1.3 ) then
			Tick_Opts = {
				["version"] = 1.3,
				["enabled"] = 1,
				["engaged"] = 0,
				["stealthed"] = 0,
				["useTexture"] = 1,
				["locked"] = 0,
				["textColor"] = { 1,1,0 },
				["textShadowColor"] = { 0,0,0 },
				["barColor"] = { 0,0.5,1 },
				["useSound"] = 2,
				["barScale"] = 1,
				["barWidth"] = 0,
				["barHeight"] = 0,
				["barOpacity"] = 100,
				["barText"] = "&c \\ &e",
				["textSize"] = 10,
				["lastTab"] = 1,
				["logoText"] = "|cffFFFF00Tick|r - v1.3",
			};
			local TICK_MISC_SHOW_ON_HIDDEN;
			if ( engClass == "DRUID" ) then
				TICK_MISC_SHOW_ON_HIDDEN = TICK_MISC_SHOW_ON_PROWL;
			else
				TICK_MISC_SHOW_ON_HIDDEN = TICK_MISC_SHOW_ON_STEALTH;
			end
			Tick_CheckOpts = {
				[1] = { name = TICK_MISC_COMBAT_FLAGS, enabled = 0 },
				[2] = { name = TICK_MISC_SHOW_ON_HIDDEN, enabled = 0 },
				[3] = { name = TICK_MISC_LOCK_POSITION, enabled = 0 },
				[4] = { name = TICK_TEXT_ENABLE, enabled = 1 },
				[5] = { name = TICK_TEXT_MOUSEOVER_BAR, enabled = 0 },
				[6] = { name = TICK_TEXT_ALWAYS_SHOW, enabled = 1 },
				[7] = { name = TICK_BAR_HIDE_SPARK, enabled = 0 },
				[8] = { name = TICK_MISC_CAT_FORM_ONLY, enabled = 0 },
				[9] = { name = TICK_MISC_USE_TARGET, enabled = 0 },
				[10] = { name = TICK_MISC_HOSITLE_NPC, enabled = 0 },
				[11] = { name = TICK_MISC_FRIENDLY_NPC, enabled = 0 },
				[12] = { name = TICK_MISC_HOSTILE_PLAYER, enabled = 0 },
				[13] = { name = TICK_MISC_FRIENDLY_PLAYER, enabled = 0 },
				[14] = { name = TICK_MISC_ALWAYS_SHOW_BAR, enabled = 1 },
				[15] = { name = TICK_TEXT_ON_TARGET, enabled = 0 },
				[16] = { name = TICK_TEXT_ON_COMBAT, enabled = 0 },
				[18] = { name = TICK_BAR_REVERSE_BAR, enabled = 0 },
				[20] = { name = TICK_TEXT_HIDE_SHADOW, enabled = 0 },
				[21] = { name = TICK_MISC_USE_SCREEN_FLASH, enabled = 0 },
				[22] = { name = TICK_MISC_SCREEN_FLASH_RED, enabled = 0 },
				[23] = { name = TICK_MISC_SCREEN_FLASH_BLUE, enabled = 1 },
				[24] = { name = TICK_MISC_NOT_MAX_ENERGY, enabled = 1 },
				[25] = { name = TICK_MISC_NOT_MAX_ENERGY, enabled = 1 },
				[26] = { name = TICK_TEXT_USE_COLOR_CODES, enabled = 1 },
				[27] = { name = TICK_BAR_USE_MINI_ENERGY, enabled = 0 },
			};
		end
	end		

	function Tick_OnLoad()
		Tick_UpdateVer();
		this:RegisterEvent("PLAYER_REGEN_ENABLED");
		this:RegisterEvent("PLAYER_REGEN_DISABLED");
		this:RegisterEvent("PLAYER_AURAS_CHANGED");
		this:RegisterEvent("PLAYER_COMBO_POINTS");
		this:RegisterEvent("PLAYER_TARGET_CHANGED");
		this:RegisterEvent("CHAT_MSG_SPELL_AURA_GONE_SELF");
		this:RegisterEvent("VARIABLES_LOADED");
		this:RegisterEvent("PLAYER_LEAVING_WORLD");
		SLASH_TICK1 = "/tick";
		SlashCmdList["TICK"] = function(msg)
			Tick_Handler(msg);
		end
	end

	function Tick_ProcessVars()
		Tick_UpdateText();
		TickSoundPicker:SetMinMaxValues(0,table.getn(Tick_SoundArr));
		TickTexturePicker:SetMinMaxValues(0,table.getn(Tick_TextureArr));
		if ( Tick_CheckOpts[1].enabled == 1 and Tick_CheckOpts[2].enabled == 1 ) then
			HideUIPanel(TickBar);
		end
		TickBar:SetScale(Tick_Opts.barScale)
		TickBar:SetAlpha((Tick_Opts.barOpacity/100));
		Tick_ChangeDimensions(Tick_Opts.barHeight,Tick_Opts.barWidth);
		for i=1,10,1 do
			if ( getglobal("TickOptsTabFrame"..i) ) then
				getglobal("TickOptsTabFrame"..i):Hide();
			else
				break;
			end
		end
		getglobal("TickOptsTabFrame"..Tick_Opts.lastTab):Show();
		if ( getglobal("TickOptsTabFrame"..(Tick_Opts.lastTab+1)) ) then
			getglobal("TickOptionsPageUp"):Enable();
		else
			getglobal("TickOptionsPageUp"):Disable();
		end
		if ( getglobal("TickOptsTabFrame"..(Tick_Opts.lastTab-1)) ) then
			getglobal("TickOptionsPageDown"):Enable();
		else
			getglobal("TickOptionsPageDown"):Disable();
		end
		if ( Tick_Opts.enabled == 0 ) then
			Tick_AddMsg("Loaded (v"..Tick_Opts.version..") current state is |cffFF0000off|r.",1);
			HideUIPanel(TickBar);
		elseif ( Tick_Opts.enabled == 1 ) then
			Tick_AddMsg("Loaded (v"..Tick_Opts.version..") current state is |cff00FF00on|r.",1);
		end
		if ( Tick_CheckOpts[7].enabled == 1 ) then
			TickSpark:Hide();
		else
			TickSpark:Show();
		end
		getglobal("TickBarText"):SetFont(TickBarText:GetFont(),Tick_Opts.textSize);
		if ( Tick_TextureArr[Tick_Opts.useTexture] == nil ) then
			Tick_Opts.useTexture = 0;
			TickStatusBar:SetStatusBarTexture(Tick_TextureArr[0]);
			TickExampleStatusBar:SetStatusBarTexture(Tick_TextureArr[0]);
		else
			TickStatusBar:SetStatusBarTexture(Tick_TextureArr[Tick_Opts.useTexture]);
			TickExampleStatusBar:SetStatusBarTexture(Tick_TextureArr[Tick_Opts.useTexture]);
		end
		Tick_SwitchStateLoad();
		Tick_MiscOptions();
		if ( engClass == "DRUID" ) then
			Tick_CheckOpts[2].name = TICK_MISC_SHOW_ON_PROWL;
			Tick_CheckOpts[8].name = TICK_MISC_CAT_FORM_ONLY;
		else
			TickButton8:Hide();
			Tick_CheckOpts[2].name = TICK_MISC_SHOW_ON_STEALTH;
			Tick_CheckOpts[8].name = "";
		end
		if ( Tick_CheckOpts[3].enabled == 1 ) then
			TickBar:EnableMouse(0);
		else
			TickBar:EnableMouse(1);
		end
		if ( Tick_CheckOpts[27].enabled == 1 ) then
			TickBarEnergy:Show();
		else
			TickBarEnergy:Hide();
		end
		Tick_CheckOpts[1].name = TICK_MISC_COMBAT_FLAGS;
		Tick_CheckOpts[3].name = TICK_MISC_LOCK_POSITION;
		Tick_CheckOpts[4].name = TICK_TEXT_ENABLE;
		Tick_CheckOpts[5].name = TICK_TEXT_MOUSEOVER_BAR;
		Tick_CheckOpts[6].name = TICK_TEXT_ALWAYS_SHOW;
		Tick_CheckOpts[7].name = TICK_BAR_HIDE_SPARK;
		Tick_CheckOpts[8].name = TICK_MISC_CAT_FORM_ONLY;
		Tick_CheckOpts[9].name = TICK_MISC_USE_TARGET;
		Tick_CheckOpts[10].name = TICK_MISC_HOSITLE_NPC;
		Tick_CheckOpts[11].name = TICK_MISC_FRIENDLY_NPC;
		Tick_CheckOpts[12].name = TICK_MISC_HOSTILE_PLAYER;
		Tick_CheckOpts[13].name = TICK_MISC_FRIENDLY_PLAYER;
		Tick_CheckOpts[14].name = TICK_MISC_ALWAYS_SHOW_BAR;
		Tick_CheckOpts[15].name = TICK_TEXT_ON_TARGET;
		Tick_CheckOpts[16].name = TICK_TEXT_ON_COMBAT;
		Tick_CheckOpts[18].name = TICK_BAR_REVERSE_BAR;
		Tick_CheckOpts[20].name = TICK_TEXT_HIDE_SHADOW;
		Tick_CheckOpts[21].name = TICK_MISC_USE_SCREEN_FLASH;
		Tick_CheckOpts[22].name = TICK_MISC_SCREEN_FLASH_RED;
		Tick_CheckOpts[23].name = TICK_MISC_SCREEN_FLASH_BLUE;
		Tick_CheckOpts[24].name = TICK_MISC_NOT_MAX_ENERGY;
		Tick_CheckOpts[25].name = TICK_MISC_NOT_MAX_ENERGY;
		Tick_CheckOpts[26].name = TICK_TEXT_USE_COLOR_CODES;
		Tick_CheckOpts[27].name = TICK_BAR_USE_MINI_ENERGY;
	end

	function Tick_Handler(msg)
		if ( not msg or type(msg) ~= "string" ) then
			return;
		else
			msg = string.lower(msg);
			if ( (msg == "options" or msg == "opts") and Tick_Opts.enabled == 1 ) then
				Tick_ShowHideOptions();
			elseif ( msg == "on" and Tick_Opts.enabled == 0 ) then
				Tick_AddMsg("Mod is now |cff00FF00on|r.",1);
				ShowUIPanel(TickBar);
				Tick_Opts.enabled = 1;
			elseif ( msg == "off" and Tick_Opts.enabled == 1 ) then
				Tick_AddMsg("Mod is now |cffFF0000off|r.",1);
				HideUIPanel(TickOptionsFrame);
				HideUIPanel(TickBar);
				Tick_Opts.enabled = 0;
			elseif ( msg == "rpos" or msg == "resetpos" ) then
				TickBar:ClearAllPoints();
				TickBar:SetPoint("CENTER","UIParent","CENTER",0,0);
				TickOptionsFrame:ClearAllPoints();
				TickOptionsFrame:SetPoint("CENTER","UIParent","CENTER",0,TickOptionsFrame:GetHeight()*0.6);
			elseif ( msg == "debug" ) then
				if ( debugTick == 1 ) then
					debugTick = 0;
					Tick_AddMsg("Debug |cffFF0000off|r",1);
					getglobal("TickBarTestText"):SetText("");
				elseif ( debugTick == 0 ) then
					debugTick = 1;
					Tick_AddMsg("Debug |cff00FF00on|r",1);
				end
			else
				Tick_AddMsg("--------------------------");
				Tick_AddMsg("v"..Tick_Opts.version,1);
				Tick_AddMsg("--------------------------");
				if ( Tick_Opts.enabled == 0 ) then
					Tick_AddMsg("|cffFFFF00on|r - Turns the mod on.");
				end
				if ( Tick_Opts.enabled == 1 ) then
					Tick_AddMsg("|cffFFFF00off|r - Turns the mod off.");
					Tick_AddMsg("|cffFFFF00options|r - Opens the options window.");
					Tick_AddMsg("|cffFFFF00rpos|r - Places Tick at the centre of the screen");
				end
				Tick_AddMsg("--------------------------");
			end
		end
	end

	function Tick_OnEvent()
		if ( event == "VARIABLES_LOADED" ) then
			Tick_UpdateVer();
			Tick_ProcessVars();
		elseif ( event == "PLAYER_LEAVING_WORLD" ) then
			Tick_Opts.engaged = 0;
			Tick_Opts.stealthed = 0;
		elseif ( event == "PLAYER_COMBO_POINTS" ) then
			Tick_Status.currPoints = GetComboPoints();
		elseif ( event == "PLAYER_REGEN_ENABLED" ) then
			Tick_Opts.engaged = 0;
			if ( Tick_CheckOpts[1].enabled == 1 ) then
				HideUIPanel(TickBar);
			end
		elseif ( event == "PLAYER_REGEN_DISABLED" ) then
			Tick_Opts.engaged = 1;
			Tick_MiscOptions();
		elseif ( event == "PLAYER_AURAS_CHANGED" ) then
			if ( Tick_Opts.enabled == 1 ) then
				local buff;
				if ( engClass == "DRUID" ) then
					buff = TICK_STEALTH_BUFF_NAME_DRUID;
				else
					buff = TICK_STEALTH_BUFF_NAME_ROGUE;
				end
	
				if ( Tick_CheckBuff(buff) == 1 ) then
					Tick_Opts.stealthed = 1;
					if ( Tick_CheckOpts[2].enabled == 1 and Tick_CheckOpts[1].enabled == 1 ) then
						ShowUIPanel(TickBar);
					end
				end
				if ( engClass == "DRUID" ) then
					if ( Tick_CheckOpts[8].enabled == 1 and Tick_CheckBuff(TICK_DRUID_CAT_FORM) == 0 )then
						HideUIPanel(TickBar);
					elseif ( Tick_CheckOpts[8].enabled == 1 and Tick_CheckBuff(TICK_DRUID_CAT_FORM) == 1 ) then
						ShowUIPanel(TickBar);
						Tick_MiscOptions();
					end
				end
			end
		elseif ( event == "PLAYER_TARGET_CHANGED" ) then
			Tick_MiscOptions();
		elseif ( event == "CHAT_MSG_SPELL_AURA_GONE_SELF" ) then
			local str;
			if ( engClass == "DRUID" ) then
				str = TICK_STEALTH_LOST_DRUID;
			else
				str = TICK_STEALTH_LOST_ROGUE;
			end

			if ( string.find(arg1,str) ) then
				Tick_Opts.stealthed = 0;
				if ( Tick_CheckOpts[2].enabled == 1 and Tick_CheckOpts[1].enabled == 1 ) then
					if ( Tick_Opts.engaged ~= 1 ) then
						HideUIPanel(TickBar);
					end
				end
			end					
		end
	end

	function Tick_CheckTarget()
		if ( UnitName("target") ) then
			if ( not UnitPlayerControlled("target") ) then
				if ( UnitCanAttack("player","target") ) then
					return 1;
				elseif ( not UnitCanAttack("player","target") ) then
					return 2;
				end
			elseif ( UnitPlayerControlled("target") ) then
				if ( UnitCanAttack("player", "target") ) then
					return 3;
				elseif ( not UnitCanAttack("player","target") ) then
					return 4;
				end
			end
		end
	end

	function Tick_CheckBuff(buff)
		for i=0,15,1 do
			if ( GetPlayerBuff(i) >= 0 ) then
				TickBuffTooltip:ClearLines();
				TickBuffTooltip:SetPlayerBuff(i);
				if ( TickBuffTooltipTextLeft1:GetText() == buff ) then
					return 1;
				end
			else
				return 0;
			end
		end
	end

	function Tick_MiscOptions()
		if ( Tick_Opts.enabled == 1 ) then
			if ( engClass == "DRUID" and Tick_CheckOpts[8].enabled == 1 ) then
				if ( UnitPowerType("player") ~= 3 ) then
					HideUIPanel(TickBar);
					return;
				end
			end
			if ( Tick_CheckOpts[9].enabled == 1 ) then
				if ( ((Tick_CheckOpts[10].enabled == 1 and Tick_CheckTarget() == 1) or 
				(Tick_CheckOpts[11].enabled == 1 and Tick_CheckTarget() == 2) or 
				(Tick_CheckOpts[12].enabled == 1 and Tick_CheckTarget() == 3) or 
				(Tick_CheckOpts[13].enabled == 1 and Tick_CheckTarget() == 4))
				and UnitName("target") ) then
					ShowUIPanel(TickBar);
				else
					HideUIPanel(TickBar);
				end
			elseif ( Tick_CheckOpts[14].enabled == 1 ) then
				ShowUIPanel(TickBar);
			elseif ( Tick_CheckOpts[1].enabled == 1 ) then
				if ( Tick_CheckOpts[2].enabled == 1 ) then
					if ( Tick_Opts.stealthed == 1 ) then
						ShowUIPanel(TickBar);
					else
						if ( Tick_Opts.engaged == 1 ) then
							ShowUIPanel(TickBar)
						else
							HideUIPanel(TickBar);
						end
					end
				else
					if ( Tick_Opts.engaged == 1 ) then
						ShowUIPanel(TickBar)
					else
						HideUIPanel(TickBar);
					end
				end
			end
		else
			HideUIPanel(TickBar);
		end
	end

	function Tick_OnUpdate(etc)
		if ( Tick_Opts.enabled == 1 ) then
			local energy = UnitMana("player");
			local currTime = GetTime();

			elapsed = elapsed + etc;

			if ( Tick_CheckOpts[27].enabled == 1 ) then
				TickStatusBarEnergy:SetMinMaxValues(0,UnitManaMax("player"));
				TickStatusBarEnergy:SetValue(energy);
			end

			if ( (energy > Tick_Status.currEnergy) and debugTick == 1 ) then
				if ( (elapsed < 1.9) or (elapsed > 2.1) ) then
					getglobal("TickBarTestText"):SetTextColor(0.7,0,0);
				else
					getglobal("TickBarTestText"):SetTextColor(0,0.7,0);
				end
				getglobal("TickBarTestText"):SetText("Last Tick: "..string.sub(elapsed,1,5).." secs");
				elapsed = 0;
			elseif ( energy == UnitManaMax("player") and debugTick == 1 ) then
				elapsed = 0;
			end

			if ( engClass == "DRUID" ) then
				if ( UnitPowerType("player") ~= 3 ) then
					energy = 0;
				end
			end

			if ( currTime > Tick_Status.tickend ) then
				if ( energy >= Tick_Status.currEnergy ) then
					Tick_Status.currEnergy = energy;
					Tick_Status.tickstart = currTime;
					Tick_Status.tickend = currTime + Tick_Status.tick;
				end

				if ( TickBar:IsVisible() ) then
					if ( (Tick_CheckOpts[25].enabled == 1 and energy < UnitManaMax("player")) or (Tick_CheckOpts[25].enabled == 0) ) then
						if ( string.sub(Tick_SoundArr[Tick_Opts.useSound],1,10) == "Interface\\" ) then
							PlaySoundFile(Tick_SoundArr[Tick_Opts.useSound]);
						else
							PlaySound(Tick_SoundArr[Tick_Opts.useSound]);
						end
					end
					if ( Tick_CheckOpts[21].enabled == 1 ) then
						local colorFrame;
						if ( (Tick_CheckOpts[24].enabled == 1 and energy < UnitManaMax("player")) or (Tick_CheckOpts[24].enabled == 0) ) then
							if ( Tick_CheckOpts[22].enabled == 1 ) then
								colorFrame = LowHealthFrame;
							elseif ( Tick_CheckOpts[23].enabled == 1 ) then
								colorFrame = OutOfControlFrame;
							end
							if ( colorFrame ~= nil ) then
								UIFrameFlash(colorFrame, 0.1, 0.3, 0.4)
							end
						end
					end
				end
			else
				if ( energy > Tick_Status.currEnergy ) then
					Tick_Status.tickend = 0;
				end
			end

			Tick_Status.currEnergy = energy;
			TickStatusBar:SetMinMaxValues(Tick_Status.tickstart,Tick_Status.tickend);

			if ( Tick_CheckOpts[18].enabled == 1 ) then
				TickSpark:SetPoint("CENTER", "TickStatusBar", "LEFT", math.floor(TickStatusBar:GetWidth()-((currTime - Tick_Status.tickstart)/(Tick_Status.tickend - Tick_Status.tickstart)*TickStatusBar:GetWidth())), -1);
				TickStatusBar:SetValue((Tick_Status.tickstart+Tick_Status.tickend)-currTime);
			else
				TickSpark:SetPoint("CENTER", "TickStatusBar", "LEFT", math.floor(((currTime - Tick_Status.tickstart)/(Tick_Status.tickend - Tick_Status.tickstart)*TickStatusBar:GetWidth())), -1);
				TickStatusBar:SetValue(currTime);
			end

			timeTick = string.sub(((currTime - Tick_Status.tickstart)/(Tick_Status.tickend - Tick_Status.tickstart)*2)+0.1,0,3);
			Tick_UpdateText();
		end
	end

	function Tick_AddMsg(msg,header)
		if ( header == 1 ) then
			DEFAULT_CHAT_FRAME:AddMessage("|cffFFFF00Tick - |r"..msg,1,1,1);
		elseif ( header ==  0 or not header ) then
			DEFAULT_CHAT_FRAME:AddMessage(msg,1,1,1);
		elseif ( type(header) ~= "number" ) then
			return;
		end
	end

	function Tick_ChangeSound(int)
		if ( not int or type(int) ~= "number" ) then
			return;
		else
			Tick_Opts.useSound = int;
			local newText = string.lower(Tick_SoundArr[Tick_Opts.useSound]);

			if ( string.len(Tick_SoundArr[Tick_Opts.useSound]) > 11 ) then
				newText = string.sub(string.lower(Tick_SoundArr[Tick_Opts.useSound]),1,10).."...";
			end

			if ( newText == "" ) then
				getglobal(this:GetName().."Text"):SetText(TICK_NOSOUND_HEADER);
			else
				getglobal(this:GetName().."Text"):SetText(TICK_SOUND_HEADER.." "..int);
			end
	
		end
	end

	function Tick_ShowHideOptions()
		if ( TickOptionsFrame:IsVisible()) then
			HideUIPanel(TickOptionsFrame);
		else
			ShowUIPanel(TickOptionsFrame);
		end
	end
else
	Tick_Opts = {};
	Tick_CheckOpts = {};
	Tick_Status = {};
	function Tick_OnLoad() 
		DEFAULT_CHAT_FRAME:AddMessage("|cffFFFF00Tick - |rAddon not loaded, player not a Rogue or Druid.");
	end
	function Tick_OnEvent() return; end
	function Tick_OnUpdate() 
		if ( TickBar:IsVisible() ) then
			HideUIPanel(TickBar);
		end
		if ( TickOptionsFrame:IsVisible()) then
			HideUIPanel(TickOptionsFrame);
		end
	end
	function Tick_UpdateText() return; end
	HideUIPanel(TickBar);
end
--[[
	Forecast by Xiven
	This mod would not have been possible without CT_RaidAssist. It seems like every mod I 
	write gets a little more dependant on it. Hopefully they see that as a form of flattery?
	
	Also thanks to CarnivalEnemyCastBar. It saved me some time.
]]

forecast_newVersion = "131";

function tellPlayer(msg, name)
	SendChatMessage(msg, "WHISPER", HF_COMMON, name);
end

function forecast_checkVersion(name)
	tellPlayer("I'm running Forecast " .. fcast["version"] .. ", by Xiven", name);
end

function forecast_whisper (arg1, name)
	if (not arg1) then
		return;
	end

	if (not name) then
		return;
	end

	arg1 = strlower(arg1);
	if (arg1 == "version") then
		forecast_checkVersion(name);
		return;
	end
end

function forecast_hideText()
	local name = fc_currentMenu:GetName();
	fcast["hideText" .. name ] = true;

	forecast_hideTextFrame ( name );
	displayOfficialText("Type " .. XIVENCASTWATCH_MACRO_COMMAND .. " to unhide title bar text.");
	fc_hideOptions();
end

function forecast_hideTextFrame( name )
	local frame = getglobal( name .. "Text");
	frame:Hide();
end

function debugMessage(msg)
	if (not debugger == true) then
		return;
	end;
	displayText(msg);
end

function displayText(msg, op_r, op_g, op_b)
	local r = pl_cr;
	local g = pl_cg;
	local b = pl_cb;
	if (op_r) then
		r = op_r;
	end
	if (op_g) then
		g = op_g;
	end
	if (op_b) then
		b = op_b;
	end
	
	DEFAULT_CHAT_FRAME:AddMessage(msg, r, g, b);
end

function displayOfficialText(msg, op_r, op_g, op_b)
	local r = pl_cr;
	local g = pl_cg;
	local b = pl_cb;
	if (op_r) then
		r = op_r;
	end
	if (op_g) then
		g = op_g;
	end
	if (op_b) then
		b = op_b;
	end
	
	DEFAULT_CHAT_FRAME:AddMessage(msg, r, g, b);
end

function dt(msg, op_r, op_g, op_b)
	local r = pl_cr;
	local g = pl_cg;
	local b = pl_cb;
	if (op_r) then
		r = op_r;
	end
	if (op_g) then
		g = op_g;
	end
	if (op_b) then
		b = op_b;
	end
	
	
	DEFAULT_CHAT_FRAME:AddMessage(msg, r, g, b);
end

function displayTextc(msg, op_r, op_g, op_b)
	local r = pl_cr;
	local g = pl_cg;
	local b = pl_cb;
	if (op_r) then
		r = op_r;
	end
	if (op_g) then
		g = op_g;
	end
	if (op_b) then
		b = op_b;
	end
	
	
	DEFAULT_CHAT_FRAME:AddMessage(msg, r, g, b);
end

function forecast_window_OnDragStart()
	this:StartMoving();
end

function forecast_window_OnDragStop()
	this:StopMovingOrSizing();
end

function forecast_parent_OnDragStart()
	this:GetParent():StartMoving();
end

function fc_showAllCastBars()
	getglobal("forecast_targetBars_base_bars"):Show();
	getglobal("forecast_selfBars_base_bars"):Show();
end

function forecast_parent_OnDragStop()
	if (arg1 == "RightButton") then
--		forecast_close();
		
		fc_showAllCastBars();
		
		if (fc_currentMenu == this) then
			fc_hideOptions();
		else
			getglobal(this:GetName() .. "_bars"):Hide();
			forecast_options();
		end
		return;
	end

	this:GetParent():StopMovingOrSizing();
end

-- open options
function forecast_options()
	fc_currentMenu = this;

	local type = fc_getType();
	fc_setAboveBelowText(type);
	fc_castMenu:Show();
	
	local scaleFrame = getglobal("fc_castMenu_scaleSlider");
	local min = fc_getMin();
	local max = fc_getMax();
	local value = ((fcast["scale"][type] - min)) * (100/(max-min));
	scaleFrame:SetValue(value);
	
	local colors = {};
	colors[1] = "red";
	colors[2] = "green";
	colors[3] = "blue";
	
	for i=1, 3 do
		local frame = getglobal("fc_castMenu_" .. colors[i] .. "Slider");
		frame:SetValue(fcast["color"][colors[i]] * 100);
	end

	local frame = getglobal("fc_castMenu_opacitySlider");
	frame:SetValue(fcast["opacity"][fc_currentMenu:GetName() .. "_bars_castBar"] * 100);

	fc_setOptionsTextColor();
	
	local frame = getglobal("fc_castMenu_versionText");
	if (fc_checkRank()) then
		frame:SetTextColor(1,1,1);
	else
		frame:SetTextColor(0.5, 0.5, 0.5);
	end
	
	local frame = getglobal("fc_castMenu_lockText");
	if (fc_currentMenu:GetName() == "forecast_selfBars_base") then
		frame:SetTextColor(0.5, 0.5, 0.5);
	else
		frame:SetTextColor(1,1,1);
	end
	
end

function fc_colorSlider(color)
	fcast["color"][color] = this:GetValue() * 0.01;
	fc_setOptionsTextColor();	
end

function fc_setOptionsTextColor()
	getglobal("fc_castMenu_redSliderText"):SetTextColor(fcast["color"]["red"], fcast["color"]["green"], fcast["color"]["blue"]);
end

function fc_opacitySlider()
	fcast["opacity"][fc_currentMenu:GetName() .. "_bars_castBar"] = this:GetValue() * 0.01;
end

function fc_getType()
	local type = "target";
	if (fc_currentMenu:GetParent() == forecast_selfBars) then
		type = "self";
	end
	return type;
end


function forecast_close()
	this:GetParent():Hide();
	fc_currentMenu:GetParent():Hide();
	fcast[fc_currentMenu:GetParent():GetName() .. "_closed"] = true;
	displayOfficialText("Type " .. XIVENCASTWATCH_MACRO_COMMAND .. " to reopen Forecast.");
end


function forecast_init()

	XIVENCASTWATCH_MACRO_COMMAND = "/fc";
	SLASH_XIVENCASTWATCH1 = XIVENCASTWATCH_MACRO_COMMAND;
	SlashCmdList["XIVENCASTWATCH"] = function(msg, msg2)
		forecast_commands(msg);
	end

	XIVENCASTWATCH_VERSION_COMMAND = "/fcver";
	SLASH_XIVENCASTWATCH_VERSION1 = XIVENCASTWATCH_VERSION_COMMAND;
	SlashCmdList["XIVENCASTWATCH_VERSION"] = function(msg, msg2)
		forecast_version();
	end
	
	playerName = UnitName("player");
	fc_updateFunction = fc_handleFaction;
	fc_paladinOrShaman = HF_PALADIN;
	if (UnitFactionGroup("player")) then
		if (UnitFactionGroup("player") == "Horde") then
			fc_paladinOrShaman = HF_SHAMAN;
		end
	else
		fc_faction = true;
	end
	
	fc_colors = {};
	fc_colors = fc_setColor( fc_colors, HF_WARRIOR, 0.78, 0.61, 0.43 );
	fc_colors = fc_setColor( fc_colors, HF_DRUID, 1.0, 0.49, 0.04 );
	fc_colors = fc_setColor( fc_colors, HF_MAGE, 0.41, 0.8, 0.94 );
	fc_colors = fc_setColor( fc_colors, HF_WARLOCK, 0.58, 0.51, 0.79 );
	fc_colors = fc_setColor( fc_colors, HF_ROGUE, 1.0, 0.96, 0.41 );
	fc_colors = fc_setColor( fc_colors, HF_HUNTER, 0.67, 0.83, 0.45 );
	fc_colors = fc_setColor( fc_colors, HF_PRIEST, 1.0, 1.0, 1.0 );
	fc_colors = fc_setColor( fc_colors, HF_SHAMAN, 0.96, 0.55, 0.73 );
	fc_colors = fc_setColor( fc_colors, HF_PALADIN, 0.96, 0.55, 0.73 );

	--[[
	fcasterClass = {};
	fcasterClass[HF_WARRIOR] = false;
	fcasterClass[HF_DRUID] = true;
	fcasterClass[HF_MAGE] = false;
	fcasterClass[HF_WARLOCK] = false;
	fcasterClass[HF_ROGUE] = false;
	fcasterClass[HF_HUNTER] = false;
	fcasterClass[HF_PRIEST] = true;
	fcasterClass[HF_PALADIN] = true;
	fcasterClass[HF_SHAMAN] = true;
	]]

	if (fcast and fcast["version"] ~= forecast_newVersion) then
		displayOfficialText("forecast is updating to " .. forecast_newVersion * 0.01 .. ".");

--		fcast = nil;
		-- stored so we can do special stuff on a version change if we want to.
	end


	if (fcast == nil) then
		fcast = {};
		fcast["version"] = forecast_newVersion;
		fcast["spells"] = {};
	end

	fcast["version"] = forecast_newVersion;
	
	fcast_casts = {};
	-- setup  the casts for the MT boxes
	for i=1, 10 do
		fcast_casts[i] = {};
	end
	for i=1, 8 do
		fcast_casts["icon" .. i] = {};
	end
	
	fc_castStopTime = 0;
	fc_removeTime = 0.8;
	fc_cancelTime = 1.5;
	fc_instantTime = 250;
	fc_RaidChange();
	
	fc_setTargetText();
	fc_updateBarVisibility();
	

	displayOfficialText("Forecast version " .. fcast["version"] * 0.01 .. ", by Xiven.");
	
	pl_cr = 0.5;
	pl_cg = 0.9;
	pl_cb = 1;
	
	local lastFrame = -1;
	if (not fcast["scale"]) then
		fcast["scale"] = {};
		fcast["scale"]["self"] = 1.0;
		fcast["scale"]["target"] = 1.0;
	end	
	
	if (fcast["above"] == nil) then
		fcast["above"] = {};
		fcast["above"]["target"] = false;
		fcast["above"]["self"] = false;
	end
	
	if (fcast["color"] == nil) then
		fcast["color"] = {};
		fcast["color"]["red"] = 0;
		fcast["color"]["green"] = 0.1;
		fcast["color"]["blue"] = 1;
	end
	
	if (not fcast["opacity"]) then
		fcast["opacity"] = {};
		fcast["opacity"]["forecast_targetBars_base_bars_castBar"] = 0.25;
		fcast["opacity"]["forecast_selfBars_base_bars_castBar"] = 0.25;
	end

	if (not fcast["playerCast"]) then
		-- this is so we can lower the opacity of bars that cast after the player
		fcast["playerCast"] = {};
	end
	fcast["playerCast"]["names"] = {};
	fcast["playerCast"]["timer"] = 0;

	
	fc_setBarAboveOrBelow();
	fc_setScale();
	
	fc_updatePlayerMTStatus();
	
	fc_tryHiding_titleText( "forecast_selfBars_base" );
	fc_tryHiding_titleText( "forecast_targetBars_base" );
	
end

function fc_tryHiding_titleText( name )
	if ( not fcast["hideText" .. name] ) then
		return;
	end
	
	forecast_hideTextFrame ( name );
end

function forecast_aboveBelowToggle()
	local type = "target";
	if (fc_currentMenu:GetParent() == forecast_selfBars) then
		type = "self";
	end
	if (fcast["above"][type]) then
		fcast["above"][type] = false;
	else
		fcast["above"][type] = true;
	end

	fc_setAboveBelowText(type);
	fc_setBarAboveOrBelow();
end

function fc_setAboveBelowText(type)
	local frame = getglobal("fc_castMenu_above" .. "Text");
	if (fcast["above"][type]) then
		frame:SetText("Casts appear above");
	else
		frame:SetText("Casts appear below");
	end	

	fc_castMenu:ClearAllPoints();

	if (fcast["above"][type]) then
		fc_castMenu:SetPoint("BOTTOMLEFT", fc_currentMenu, "TOPLEFT", -5, 0);
	else
		fc_castMenu:SetPoint("TOPLEFT", fc_currentMenu, "BOTTOMLEFT", -5, 0);
	end

end

function fc_setBarAboveOrBelow()
	for p=1, 2 do	
		local msg = "forecast_targetBars_base_bars_castBar";
		local parentFrame = getglobal("forecast_targetBars");
		local type = "target";
		
		if (p == 2) then
			msg = "forecast_selfBars_base_bars_castBar";
			parentFrame = getglobal("forecast_selfBars");
			type = "self";
		end

		for i=1, 20 do
			local frame = getglobal(msg .. i);
			frame:ClearAllPoints();
		end
	end

	for p=1, 2 do	
		local msg = "forecast_targetBars_base_bars_castBar";
		local parentFrame = getglobal("forecast_targetBars");
		local type = "target";
		
		if (p == 2) then
			msg = "forecast_selfBars_base_bars_castBar";
			parentFrame = getglobal("forecast_selfBars");
			type = "self";
		end

		for i=1, 20 do
			local frame = getglobal(msg .. i);
			if (fcast["above"][type]) then
				if (i == 1) then
					frame:SetPoint("BOTTOMLEFT", parentFrame, "BOTTOMLEFT", -5, 12);
				else
					frame:SetPoint("BOTTOMLEFT", lastFrame, "TOPLEFT", 0, -6);
				end
			else
				if (i == 1) then
					frame:SetPoint("TOPLEFT", parentFrame, "TOPLEFT", -5, -22);
				else
					frame:SetPoint("TOPLEFT", lastFrame, "BOTTOMLEFT", 0, 6);
				end
			end
			lastFrame = frame;
		end
	end
end


function fc_setColor (colors, class, r, g, b)
	colors[class] = {};
	colors[class][1] = r;
	colors[class][2] = g;
	colors[class][3] = b;
	return colors;
end



--[[
	if (forecast_raidOpen == nil) then
		forecast_raidOpen = true;
	end
	if (not forecast_raidOpen) then
 		xivenRaid:Hide();
	end
]]	

function fc_updateBarVisibility()
	if (fcast["forecast_selfBars_closed"]) then
		forecast_selfBars:Hide();
	else
		forecast_selfBars:Show();
	end
	
	if (fcast["forecast_targetBars_closed"]) then
		forecast_targetBars:Hide();
	else
		forecast_targetBars:Show();
	end
end

function fc_RaidChange()
	local raidCount = GetNumRaidMembers();
	fc_raidCheck = nil;
	fcast_raiders = {};
	
	
	local lockName = fcast["lockTarget"];
	local foundLockName = false;
	-- check to see who is new and add them to the classes list
	for i = 1, raidCount do
		local name, rank, subgroup, level, class, fileName, zone, online, isDead = GetRaidRosterInfo(i);
		if (not name) then
			fc_raidCheck = true;
		else
			if (name == lockName) then
				foundLockName = true;
			end
			
			fcast_raiders[name] = {};
			fcast_raiders[name]["class"] = class;
			fcast_raiders[name]["id"] = i;
			if (not fcast_casts[name]) then
				fcast_casts[name] = {};
			end
		end
	end
	
	if (not foundLockName) then
		if (type(fcast["lockTarget"]) ~= "string") then
			if (CT_RA_MainTanks and CT_RA_MainTanks[fcast["lockTarget"]]) then
				-- if its a MT target that still exists then let it go
				return;
			end
		end
		-- change back to no target lock if that player leaves the raid
		fcast["lockTarget"] = nil;
		fc_setTargetText();
	end
	
	-- remove stats recording in battlehistory for players that have left the raid
	if ( fcast["stats"] ) then
		for name in fcast["stats"] do
			if ( not fcast_raiders[ name ] ) then
				fcast["stats"][ name ] = nil;
			end
		end
	end
end

function fc_checkRank()
	return fc_getPlayersRank(playerName) > 0;
end


function forecast_commands(msg)
	fcast["forecast_selfBars_closed"] = nil;
	fcast["forecast_targetBars_closed"] = nil;
	fc_updateBarVisibility();
	
	fc_show_titleText( "forecast_selfBars_base" );
	fc_show_titleText( "forecast_targetBars_base" );
end

function fc_show_titleText( name )
	fcast["hideText" .. name ] = nil;

	local frame = getglobal( name .. "Text");
	frame:Show();
end


function fc_updatePlayerMTStatus()
	fcast["playerMT"] = nil;
	if (not CT_RA_MainTanks) then
		return;
	end
	for key, val in CT_RA_MainTanks do
		if (val == playerName) then
			fcast["playerMT"] = key;
		end
	end
end


fc_lastHealer = "";
fc_timer = 0;
function forecast_window_OnUpdate()
	
	fc_elapsedTime = arg1;
	fc_timer = fc_timer + fc_elapsedTime;
	
	fc_updateFunction();
	if (fc_raidCheck) then
		playerName = UnitName("player");
		fc_updatePlayerMTStatus();
		fc_RaidChange();
		return;
	end
	
 	local inRaid = GetNumRaidMembers() > 0;

	if (fc_inRaid == nil) then
		fc_inRaid = inRaid;
		if (fc_inRaid) then
			fc_updateBarVisibility();
		else
			forecast_selfBars:Hide();
			forecast_targetBars:Hide();
		end
	else
		if (fc_inRaid) then
		 	if (not inRaid) then
				forecast_selfBars:Hide();
				forecast_targetBars:Hide();
				fc_inRaid = false;
			end
		else
		 	if (inRaid) then
				fc_updateBarVisibility();
				fc_inRaid = true;
			end
		end
	end

	if (inRaid) then	
		fc_drawCasts();
	end
end

function fc_redrawBars( msgFrame, targetName)
	if (fcast["lockTarget"] and msgFrame == "forecast_targetBars_base_bars") then
		if (not fc_MTLock2name and fcast["lockTarget"] ~= targetName) then	
			-- fc_MTLock2name is the translated name from the MT's target to a player name
			return;
		end
	end

	msgFrame = msgFrame .. "_castBar";
	local playerCastFinishTime = fc_getplayerCastFinishTime(targetName);
	for i=1, 20 do
		fc_redrawIndividualBar( msgFrame, targetName, i, playerCastFinishTime);
	end
end

function fc_getplayerCastFinishTime(targetName)
	-- returns the time that the player will finish casting a spell on this target
	
	if (fc_isInArray(targetName, fcast["playerCast"]["names"]) and fcast["playerCast"]["timer"] > fc_timer) then
		return fcast["playerCast"]["timer"];
	else
		return fc_timer + 5000;
	end
end

function fc_isInArray(value, array)
	for key, val in array do
		if (val == value) then
			return true;
		end
	end	
end

	
function fc_redrawIndividualBar( msgFrame, targetName, i, playerCastFinishTime)

	local frame = getglobal(msgFrame .. i);
	if (fcast_casts[targetName][i]) then
		frame:Show();

		local text = getglobal (msgFrame .. i .. "_Text");
		local spell = fcast_casts[targetName][i]["spell"];
		local caster = fcast_casts[targetName][i]["caster"];
		text:SetText(spell .. " - " .. caster);
		if (not fcast_raiders[caster]) then
			-- not sure how this can ever be the case, but it happens sometimes
			frame:Hide();
			return;
		end
		
		local class = fcast_raiders[caster]["class"];
		local bar = getglobal (msgFrame .. i .. "_StatusBar");
		
		local alpha = 1;
		if (fcast_casts[targetName][i]["timer"] > playerCastFinishTime) then
			-- lower the alpha because this cast finishes after our cast
			alpha = fcast["opacity"][msgFrame];
		end
		
		text:SetTextColor(1,1,1,alpha);		
		local texture = getglobal (msgFrame .. i .. "_texture");
		texture:SetAlpha(alpha);

		local spark = getglobal (msgFrame .. i .. "_StatusBar_Spark");
		spark:SetAlpha(alpha);
		
		if (playerName == caster) then
			bar:SetStatusBarColor(fcast["color"]["red"],fcast["color"]["green"], fcast["color"]["blue"], alpha);
		else
			bar:SetStatusBarColor(fc_colors[class][1], fc_colors[class][2], fc_colors[class][3], alpha );
		end
		bar:SetMinMaxValues(fcast_casts[targetName][i]["startTimer"], fcast_casts[targetName][i]["timer"]);
		bar:SetValue(fc_timer);
	else
		frame:Hide();
	end
end

function fc_updateBars(barType, targetName)
	local playerCastFinishTime = fc_getplayerCastFinishTime(targetName);
	for i=1, 20 do
		if (fcast_casts[targetName][i]) then
			if (fcast_casts[targetName][i]["cancelTime"]) then
				
				-- cast was cancelled
				
				local alpha = 1;
				if (fcast_casts[targetName][i]["timer"] > playerCastFinishTime) then
					-- lower the alpha because this cast finishes after our cast
					alpha = fcast["opacity"][barType .. "_castBar"];
				end

				local remainder = fc_timer - fcast_casts[targetName][i]["cancelTime"];
				remainder = remainder / fc_cancelTime;
				remainder = 1 - remainder;
				remainder = remainder * 2;
				if (remainder > 1) then
					remainder = 1;
				end
				alpha = alpha * remainder;
				local text = getglobal (barType .. "_castBar" .. i .. "_Text");
				text:SetTextColor(1,1,1,alpha);		
				text:SetText("Cancelled");
				local texture = getglobal (barType .. "_castBar" .. i .. "_texture");
				texture:SetAlpha(alpha);

				local spark = getglobal (barType .. "_castBar" .. i .. "_StatusBar_Spark");
				spark:SetAlpha(alpha);

				local bar = getglobal (barType .. "_castBar"  .. i .. "_StatusBar");
				bar:SetStatusBarColor(1, 0, 0, alpha );
			
				if (fc_timer > fcast_casts[targetName][i]["cancelTime"] + fc_cancelTime) then
					-- spell has elapsed
					local frame = getglobal(barType .. "_castBar" .. i);
					frame:Hide();
					
					if (barType == "forecast_targetBars_base_bars" or UnitName("target") ~= playerName) then
						fcast_casts[targetName][i] = nil;
					end
				end
			else			
				if (fc_timer < fcast_casts[targetName][i]["timer"]) then
				
					-- cast is progressing normally 
					
					local bar = getglobal (barType .. "_castBar" .. i .. "_StatusBar");
					bar:SetValue(fc_timer);		

					-- update spark position, courtesy Carnival_EnemyCastBar
					
					local startTime = fcast_casts[targetName][i]["startTimer"];
					local endTime = fcast_casts[targetName][i]["timer"];
					local remains = startTime - fc_timer;
					local sparkPos = ((fc_timer - startTime) / (endTime - startTime)) * 195;
					
					local spark = getglobal (barType .. "_castBar" .. i .. "_StatusBar_Spark");
					spark:SetPoint("CENTER", bar, "LEFT", sparkPos, 0);
				else

					-- cast is expired (or cancelled in the old versoin)
					local alpha = 1;
					if (fcast_casts[targetName][i]["timer"] > playerCastFinishTime) then
						-- lower the alpha because this cast finishes after our cast
						alpha = fcast["opacity"][barType .. "_castBar"];
					end
	
					local remainder = fc_timer - fcast_casts[targetName][i]["timer"];
					remainder = remainder / fc_removeTime;
					remainder = 1 - remainder;
					alpha = alpha * remainder;
					local text = getglobal (barType .. "_castBar" .. i .. "_Text");
					
					text:SetTextColor(1,1,1,alpha);		
					local texture = getglobal (barType .. "_castBar" .. i .. "_texture");
					texture:SetAlpha(alpha);

					local bar = getglobal (barType .. "_castBar"  .. i .. "_StatusBar");
--					bar:SetValue(fc_timer);		

					local spark = getglobal (barType .. "_castBar" .. i .. "_StatusBar_Spark");
--					local sparkPos = ((fc_timer - startTime) / (endTime - startTime)) * 195;
					spark:SetAlpha(alpha);
--					spark:SetPoint("CENTER", bar, "LEFT", 195, 0);

	
					local caster = fcast_casts[targetName][i]["caster"];
					--[[
					local class = fcast_raiders[caster]["class"];
					if (caster == playerName) then
						bar:SetStatusBarColor(fcast["color"]["red"],fcast["color"]["green"], fcast["color"]["blue"], alpha);
					else
						bar:SetStatusBarColor(fc_colors[class][1], fc_colors[class][2], fc_colors[class][3], alpha );
					end
					]]
					local r, g, b, a = bar:GetStatusBarColor() ;
					bar:SetStatusBarColor(r, g, b, alpha );
				
					if (fc_timer > fcast_casts[targetName][i]["timer"] + fc_removeTime) then
						-- spell has elapsed
						local frame = getglobal(barType .. "_castBar" .. i);
						frame:Hide();
						
						if (barType == "forecast_targetBars_base_bars" or UnitName("target") ~= playerName) then
							fcast_casts[targetName][i] = nil;
						end
					end
				end
			end
		end
	end
end

function fc_getTarget()
	-- returns the fcast_casts string index of the current target
	if (fcast["lockTarget"]) then
		return fcast["lockTarget"];
	end
	
	if (not fcast["playerMT"] and fc_lastTargetMT and UnitIsUnit("target", "raid" .. fc_lastTargetID .. "target")) then
		return fc_lastTargetMT;
	end
	fc_lastTargetMT = nil;
	
	if (UnitIsPlayer("target")) then
		return UnitName("target");
	end
	
	local icon = GetRaidTargetIndex( "target" );
	if ( icon ) then
		return "icon" .. icon;
	end
		
	if (not CT_RA_MainTanks) then
		return;
	end

--	return fc_getMTnumber();
	if (fcast["playerMT"]) then
		if (UnitName("target")) then
			return fcast["playerMT"];
		else
			return nil;
		end
	end
	
	local array = fc_getMTarray();
	if (array) then
--		displayText("target is from mt " .. array["mt"] .. " name " .. array["name"]);
		fc_lastTargetMT = array["mt"];
		fc_lastTargetID = fcast_raiders[array["name"]]["id"];
		return fc_lastTargetMT;
	end
end

function fc_lockedMT()
	if (not CT_RA_MainTanks) then
		return false;
	end
	
	if (not fcast["lockTarget"]) then
		return false;
	end
	if (type(fcast["lockTarget"]) == "string") then	
		return false;
	end
	
	if (not CT_RA_MainTanks[fcast["lockTarget"]]) then
		return false;
	end
	
	if (not fcast_raiders[CT_RA_MainTanks[fcast["lockTarget"]]]) then
		return false;
	end
	
	return true;
end

function fc_drawCasts()

	local barType = "forecast_selfBars_base_bars";
	local target = playerName;
	if (not target) then
		return;
	end
	if (not fcast_casts[target]) then
		fc_RaidChange();
		return;
	end
	
	-- update spark/alpha on the player
	fc_updateBars(barType, playerName);

	fc_currentTarget = fc_getTarget();
	fc_MTLock2name = nil;
	if (fc_lockedMT()) then
		-- locked on an MT target so we have to check to see if its locked on a player
		local name = UnitName("raid" .. fcast_raiders[CT_RA_MainTanks[fcast["lockTarget"]]]["id"] .. "target");
		if (name) then
			if (fcast_raiders[name]) then
				fc_currentTarget = name;
				fc_MTLock2name = name;
			end
		end		
	end
	
	if (fc_currentTarget) then
		getglobal("fc_castTargetText"):SetText(fc_currentTarget);
	else
		getglobal("fc_castTargetText"):SetText("");
	end

	if (fc_currentTarget and not fcast_casts[fc_currentTarget]) then
--		displayText(" no fcasts on target " .. fc_currentTarget);
		return;
	end
	
	barType = "forecast_targetBars_base_bars";

	if (fcast_lastTarget ~= fc_currentTarget) then
		-- changed target, so hide or redraw bars depending on if the new target has casts
		fcast_lastTarget = fc_currentTarget;
		
		if (not fc_currentTarget or not fcast_casts[fc_currentTarget]) then
			for i=1, 20 do
				local frame = getglobal(barType .. "_castBar" .. i);
				frame:Hide();
			end
			return;
		end

		-- hide dead bars
		for i = 1, 20 do
			if (fcast_casts[fc_currentTarget][i]) then
				if (fc_timer > fcast_casts[fc_currentTarget][i]["timer"] + fc_cancelTime) then
					fcast_casts[fc_currentTarget][i] = nil;
					local frame = getglobal(barType .. "_castBar" .. i);
					frame:Hide();
				end
			end
		end

		if (fcast["playerMT"] and CT_RA_MainTanks) then
			-- the player is an MT so lets see if the target he picked is the target of some other MT so we can acquire the bars for it
			for raiderMT, name in CT_RA_MainTanks do
				if (name ~= playerName and fcast_raiders[name]) then
					if (UnitIsUnit("raid" .. fcast_raiders[name]["id"] .. "target", "target")) then
						fcast_casts[fcast["playerMT"]] = {};
						
						local count = getn(fcast_casts[raiderMT]);
						for i=1, count do
							fcast_casts[fcast["playerMT"]][i] = {};
							fcast_casts[fcast["playerMT"]][i]["spell"]			= fcast_casts[raiderMT][i]["spell"];
							fcast_casts[fcast["playerMT"]][i]["startTimer"]		= fcast_casts[raiderMT][i]["startTimer"];
							fcast_casts[fcast["playerMT"]][i]["timer"]			= fcast_casts[raiderMT][i]["timer"];
							fcast_casts[fcast["playerMT"]][i]["cancelTime"]		= fcast_casts[raiderMT][i]["cancelTime"];
							fcast_casts[fcast["playerMT"]][i]["caster"]			= fcast_casts[raiderMT][i]["caster"];
						end

						for playerkey, val in fcast_casts do
							-- copy the MTs in the current targets
							if (type(playerkey) == "string") then
								if (fcast_casts[playerkey]["currentTargets"]) then
									if (fc_valueOneIsInArray_and_valueTwoIsNotInArray(fcast_casts[playerkey]["currentTargets"], raiderMT, fcast["playerMT"])) then
										count = getn(fcast_casts[playerkey]["currentTargets"]);
										fcast_casts[playerkey]["currentTargets"][count+1] = fcast["playerMT"];
									end
								end
							end
						end
					end
				end
			end
		end
		
		fc_redrawBars( barType, fc_currentTarget);
	else
		if (not fc_currentTarget) then
			return;
		end
	end

	if (not fcast_casts[fc_currentTarget]) then
		return;
	end
	
	-- update spark/alpha on the target
	fc_updateBars(barType, fc_currentTarget);
end

function fc_valueOneIsInArray_and_valueTwoIsNotInArray( array, val1, val2 )
	local foundVal1 = false;
	local foundVal2 = false;
	for key, val in array do
		if (val == val1) then
			foundVal1 = true;
		else		
			if (val == val2) then
				return false;
			end
		end
	end
	return foundVal1;
end

function empty()
end

function fc_handleFaction()
	if ( not fc_faction ) then
		fc_updateFunction = empty;
		return;
	end
	
	if (not UnitFactionGroup("player")) then
		return;
	end

	fc_faction = nil;

	if (UnitFactionGroup("player") ~= "Horde") then
		return;
	end
	
	fc_paladinOrShaman = HF_SHAMAN;
end

function fc_getPlayersGroup(player)
	local raidCount = GetNumRaidMembers();
	for i = 1, raidCount, 1 do
		local name, rank, subgroup, level, class, fileName, zone, online, isDead = GetRaidRosterInfo(i);
		if (name and name == player) then
--			displayText("player " .. name .. " is in group " .. subgroup);
			return subgroup;
		end
	end
end

function fc_getPlayersClass(player)
	local raidCount = GetNumRaidMembers();
	for i = 1, raidCount, 1 do
		local name, rank, subgroup, level, class, fileName, zone, online, isDead = GetRaidRosterInfo(i);
		if (name and name == player) then
			return class;
		end
	end
end

function fc_getPlayersRank(player)
	local raidCount = GetNumRaidMembers();
	for i = 1, raidCount, 1 do
		local name, rank, subgroup, level, class, fileName, zone, online, isDead = GetRaidRosterInfo(i);
		if (name and name == player) then
			return rank;
		end
	end
	return 0;
end


function fc_spellCast(spellname, casttime)
	fc_spellIsCasting = true;

	if (not fc_SpellCast or not fc_SpellCast[2]) then
		return;
	end
	local unit = fc_SpellCast[2];

	if (not fcast["spells"][spellname]) then
		fcast["spells"][spellname] = spellname;
	end
	local message = fcast["spells"][spellname];
	
	if (not fcast_raiders[unit]) then
		local icon = GetRaidTargetIndex( "target" );
		if ( icon ) then
			fc_sendMessage("KCIC" .. message .. "*"  .. casttime .. "*" .. "icon" .. icon);
			return;
		end
	
		if ( CT_RA_MainTanks ) then
			local mt = fc_getMTstring();
			if (mt) then
	--			displayText("added cast on MT " .. mt);
				fc_sendMessage("KCTG" .. message .. "*"  .. casttime .. "*" .. mt);
			else
				fc_sendMessage("KCOH" .. message .. "*"  .. unit .. "*" .. casttime);
			end
			return;
		end
	end
	fc_castStopTime = fc_timer + casttime * 0.001;
	fc_sendMessage("KCOH" .. message .. "*"  .. unit .. "*" .. casttime);
end

function fc_getMTnumber()
	for key, val in CT_RA_MainTanks do
		if (fcast_raiders[val]) then
			local tankID = fcast_raiders[val]["id"];
			
			if (UnitIsUnit("target", "raid" .. tankID .. "target")) then
				return key;
			end
		end
	end
end

function fc_getMTarray()
	for key, val in CT_RA_MainTanks do
		if (fcast_raiders[val]) then
			local tankID = fcast_raiders[val]["id"];
			
			if (UnitIsUnit("target", "raid" .. tankID .. "target")) then
				array = {};
				array["name"] = val;
				array["mt"] = key;
				return array;
			end
		end
	end
end

function fc_getMTstring()
	local msg = "";
	for key, val in CT_RA_MainTanks do
		if (fcast_raiders[val]) then
			local tankID = fcast_raiders[val]["id"];
			
			if (UnitIsUnit("target", "raid" .. tankID .. "target")) then
				msg = msg .. key .. "*";
			end
		end
	end
	if (msg ~= "") then
		return msg;
	end
end

function fc_stopChannel()
	fc_sendMessage("KCNO");
end

function fc_stopCast()
	if (not fc_spellIsCasting) then
--		fc_sendMessage("KCIN");
		local unit = UnitName("target");
		if (CT_RA_SpellCast and CT_RA_SpellCast[2]) then
			unit = CT_RA_SpellCast[2];
		end			
		if (unit) then
			fc_sendMessage("KCOH" .. "Instant" .. "*"  .. unit .. "*" .. fc_instantTime);
		else
			fc_sendMessage("KCOH" .. "Instant" .. "*"  .. "unknown" .. "*" .. fc_instantTime);
		end
	end
	fc_spellIsCasting = nil;
end

function fc_interruptCast()
	fc_sendMessage("KCCN");
end

function fc_chatEvent(event)
--	if (not CT_RA_Channel) then
--		return;
--	end
	if not (event) then
		return;
	end
	
	if (type(event) ~= "string" ) then
		return;
	end

--	if (not arg9) then
--		return;
--	end
	
--	if (strlower(arg9) ~= strlower(CT_RA_Channel)) then
--		return;
--	end
	if (not fcast_raiders[arg4]) then	
		--displayText("not in raid");
		return;
	end

	while (true) do
		local space = string.find(event, "#");
		if (not space) then
			fc_processEvent(event);
			return;
		end
		
		local msg = strsub(event, 1, space-1);
		if (not msg) then
			fc_processEvent(msg);
			return;
		end
		
		event = strsub(event, space+1);
		if (not event) then
			return;
		end
	end
end

function fc_processEvent(event)

	event = string.gsub(event, "%$", "s");
	event = string.gsub(event, "§", "S");
	local root = strsub(event, 1, 4);
	if (root == "SET ") then	
		msg = strsub(event, 5);
		local mtNumber = tonumber(strsub(msg, 1, 2));
		local name = strsub(msg, 3);
		if (name == playerName) then
			fcast["playerMT"] = mtNumber;
		end
		return;
	end
	
	if (root == "KCOH") then	
		if (fcast["forecast_targetBars_closed"] and fcast["forecast_selfBars_closed"]) then
			return;
		end
		local msg = strsub(event, 5);
		
		local space = string.find(msg, "*");
		if (not space) then
			return;
		end
		local spell = strsub(msg, 1, space-1);
		if (not spell) then
			return;
		end
		
		msg = strsub(msg, space+1);
		if (not msg) then
			return;
		end

		space = string.find(msg, "*");
		if (not space) then
			return;
		end

		local targetName = strsub(msg, 1, space-1);
		if (not targetName) then
			return;
		end

		local timer = strsub(msg, space+1);
		if (not timer) then
			return;
		end
		timer = tonumber(timer);
		if (not timer) then
			return;
		end
	
		fc_addCast(arg4, targetName, spell, timer);
		return;
	end

	if (root == "KCTG") then
		if (not CT_RA_MainTanks) then
			return;
		end
		if (fcast["forecast_targetBars_closed"]) then
			return;
		end
		local msg = strsub(event, 5);
		
		local space = string.find(msg, "*");
		if (not space) then
			return;
		end
		local spell = strsub(msg, 1, space-1);
		if (not spell) then
			return;
		end
		
		msg = strsub(msg, space+1);
		if (not msg) then
			return;
		end

		space = string.find(msg, "*");
		if (not space) then
			return;
		end

		local timer = strsub(msg, 1, space-1);
		if (not timer) then
			return;
		end

		timer = tonumber(timer);
		if (not timer) then
			return;
		end
		
		if (timer <= 0) then
			timer = fc_instantTime;
		end

		local targetArray = fc_getStringArray(strsub(msg, space+1), "*");
		if (not targetArray) then
			return;
		end

		fc_addMTTargetCast(arg4, targetArray, spell, timer);
		return;
	end

	if (root == "KCIC") then
		-- cast against an enemy with an icon
		fc_castAgainstIconTarget( arg4, event );
		return;
	end

	if (root == "KCCN") then	
		if (fcast["forecast_targetBars_closed"] and fcast["forecast_selfBars_closed"]) then
			return;
		end
		-- spell was cancelled prematurely
		local raidCount = GetNumRaidMembers();
		if (arg4 == playerName) then
			-- was this a self-cancel?
			fcast["playerCast"]["timer"] = fc_timer;
			fc_redrawBarsIfPlayerCastChanged( UnitName("target"));
		end;
--		displayText("cancel from " .. arg4);
		
		-- cancel the spell bars for this player
		if (fcast_casts[arg4]["currentTargets"]) then
			for key, val in fcast_casts[arg4]["currentTargets"] do
				fc_addHistoryItem("castCancel", arg4, "irrelevant", val, fc_timer, fc_timer);
				if (fcast_casts[val]) then
					for i=1, 20 do
						if (fcast_casts[val][i] and not fcast_casts[val][i]["cancelTime"]) then
							if (fcast_casts[val][i]["caster"] == arg4) then
								fcast_casts[val][i]["cancelTime"] = fc_timer;
							end
						end
					end
				end
			end
		end
		return;
	end

	if (root == "KCNO") then
		if (fcast["forecast_targetBars_closed"] and fcast["forecast_selfBars_closed"]) then
			return;
		end
		-- spell was cancelled in a previous version of forecast
		local raidCount = GetNumRaidMembers();
		if (arg4 == playerName) then
			-- was this a self-cancel?
			fcast["playerCast"]["timer"] = fc_timer;
			fc_redrawBarsIfPlayerCastChanged( UnitName("target"));
		end;
		
		-- cancel the spell bars for this player
		if (fcast_casts[arg4]["currentTargets"]) then
			for key, val in fcast_casts[arg4]["currentTargets"] do
				fc_addHistoryItem("castStop", arg4, "irrelevant", val, fc_timer, fc_timer);
				if (fcast_casts[val]) then
					for i=1, 20 do
						if (fcast_casts[val][i]) then
							if (fcast_casts[val][i]["caster"] == arg4 and fcast_casts[val][i]["timer"] > fc_timer) then
								fcast_casts[val][i]["timer"] = fc_timer;
							end
						end
					end
				end
			end
		end
		return;
	end

	if (root == "KCVR") then	
		local msg = strsub(event, 5);
		if (msg == "request") then
			-- version request
			if (fc_getPlayersRank(arg4) < 1) then
				-- dont have to listen to non promoted raiders
				return;
			end
			fc_sendMessage("KCVR" .. fcast["version"]);
		else
			if (fc_viewingVersions) then
				fc_updatePlayersVersion(arg4, tonumber(msg));
			end
		end
		return;
	end
	
	if ( strsub(event, 1, 2) == "R " ) then
		if (strsub(event, 3) == playerName) then
			fcast["playerMT"] = nil;
		end
	end
end

function fc_castAgainstIconTarget( caster, event )
	local msg = strsub(event, 5);
	
	local space = string.find(msg, "*");
	if (not space) then
		return;
	end
	local spell = strsub(msg, 1, space-1);
	if (not spell) then
		return;
	end
	
	msg = strsub(msg, space+1);
	if (not msg) then
		return;
	end

	space = string.find(msg, "*");
	if (not space) then
		return;
	end

	local timer = strsub(msg, 1, space-1);
	if (not timer) then
		return;
	end

	timer = tonumber(timer);
	if (not timer) then
		return;
	end
	
	if (timer <= 0) then
		timer = fc_instantTime;
	end

	space = string.find(msg, "*");
	local target = strsub(msg, space+1);
	if (not target) then
		return;
	end

	fc_addIconTargetCast(caster, target, spell, timer);
end

function fc_getStringArray(msg, seperator)
	local array = {};
	while (1) do
		local space = string.find(msg, seperator);
		if (not space) then
			return array;
		end

		local entree = strsub(msg, 1, space-1);
		if (not entree) then
			return array;
		end
		local index = getn(array) + 1;
		array[index] = entree;
		msg = strsub(msg, space+1);
	end
end

function fc_addCast(caster, targetName, spell, timer)
--	displayText(caster .. " cast " .. spell .. " on " .. targetName .. " at time " .. timer);
	local endTime = fc_timer + (timer * 0.001);
	fc_addHistoryItem("castStart", caster, spell, targetName, endTime, fc_timer);
	-- players can only cast spells on one target at a time in WoW, which makes for a useful optimization
	fcast_casts[caster]["currentTargets"] = {};
	fcast_casts[caster]["currentTargets"][1] = targetName;

	if (not fcast_casts[targetName]) then
		return;
	end
	if (not fcast_casts[caster]) then
		return;
	end
	
	
	local index = 0;
	for i = 1, 21 do
		index = index + 1;
		if (not fcast_casts[targetName][index]) then
			break;
		end
		if (fc_timer > fcast_casts[targetName][index]["timer"] + fc_cancelTime) then
			break;
		end
	end
	
	if (index > 20) then
		return;
	end

	fcast_casts[targetName][index] = {};
	fcast_casts[targetName][index]["spell"] = spell;
	fcast_casts[targetName][index]["startTimer"] = fc_timer;
	fcast_casts[targetName][index]["timer"] = endTime;
	fcast_casts[targetName][index]["cancelTime"] = nil;
	fcast_casts[targetName][index]["caster"] = caster;
--	displayText("Adding spell at time " .. fc_timer .. " with end time " .. fcast_casts[targetName][index]["timer"]);

	if (caster == playerName) then
		fcast["playerCast"]["timer"] = fcast_casts[targetName][index]["timer"];
		fcast["playerCast"]["names"] = {};
		fcast["playerCast"]["names"][1] = targetName;

		fc_redrawBarsIfPlayerCastChanged( targetName);
	end

	local playerCastFinishTime = fc_getplayerCastFinishTime(targetName);
	
	if (targetName == playerName) then
--		displayText("checking for casting on " .. target .. " index " .. index);
		fc_redrawIndividualBar( "forecast_selfBars_base_bars_castBar", targetName, index, playerCastFinishTime);
	end

	

	-- determine if this cast effects our target or our locked target. If it does, then redraw the necessary bar.
	local target = "";
	if (fcast["lockTarget"]) then
		target = fcast["lockTarget"];
	else
		target = UnitName("target");
	end
	
	if (not target) then
		return;
	end
	
	if (target ~= targetName) then
		return;
	end
	
	fc_redrawIndividualBar( "forecast_targetBars_base_bars_castBar", target, index, playerCastFinishTime);
end

function fc_addHistoryItem(type, caster, spell, targetName, endTime, startTime)
	if (not fcast["history"]) then
		return;
	end

--	displayText("added history type " .. type .. " by caster " .. caster .. " of spell " .. spell .. " on target " .. targetName);
	local index = fc_historyIndex();
	fcast["history"][index] = {};
	fcast["history"][index]["caster"] = caster;
	fcast["history"][index]["spell"] = spell;
	fcast["history"][index]["timer"] = endTime;
	fcast["history"][index]["startTimer"] = fc_timer;
	fcast["history"][index]["target"] = targetName;
	fcast["history"][index]["type"] = type;
end

function fc_historyIndex()
	return (getn(fcast["history"]) + 1);
end

function testz()
	local blah = {};
	blah["3"] = "C";
	blah["11"] = "A";
	blah["5"] = "E";
	for key, val in blah do
		displayText("key is " .. key);
		displayText("val is " .. val);
	end
end

function fc_addMTTargetCast(caster, targetArray, spell, timer)
	local endTime = fc_timer + (timer * 0.001);
	
	-- this get sends the name of that players target
	fc_addHistoryItem("castStart", caster, spell, getglobal("CT_RAMTGroupMember" .. targetArray[1] .. "Name"):GetText(), endTime, fc_timer);
--[[
	if (endTime == fc_timer) then
		displayText("spell " .. spell .. " had zero cast time");
	end
]]
	
	array = {};
	array["spell"] = spell;
	array["startTimer"] = fc_timer;
	array["timer"] = endTime;
	array["cancelTime"] = nil;
	array["caster"] = caster;

	for key, val in targetArray do
		targetArray[key] = tonumber(val);
	end

	if (caster == playerName) then
		fcast["playerCast"]["names"] = {};
		fcast["playerCast"]["timer"] = endTime;
		for key, val in targetArray do
			fcast["playerCast"]["names"][key] = val;
			fc_redrawBarsIfPlayerCastChanged( val );
		end
	end

	fcast_casts[caster]["currentTargets"] = {};
	for key, val in targetArray do
		fcast_casts[caster]["currentTargets"][key] = val;
		fc_addIndividualMTTargetCast(val, array);
	end
end

function fc_addIconTargetCast(caster, icon, spell, timer)
	local endTime = fc_timer + (timer * 0.001);
	fc_addHistoryItem("castStart", caster, spell, UnitName("target"), endTime, fc_timer);
	
--[[
	if (endTime == fc_timer) then
		displayText("spell " .. spell .. " had zero cast time");
	end
]]
	
	array = {};
	array["spell"] = spell;
	array["startTimer"] = fc_timer;
	array["timer"] = endTime;
	array["cancelTime"] = nil;
	array["caster"] = caster;

	if (fcast["forecast_targetBars_closed"]) then
		return;
	end

	if (caster == playerName) then
		fcast["playerCast"]["names"] = {};
		fcast["playerCast"]["timer"] = endTime;
		fcast["playerCast"]["names"][1] = icon;
		fc_redrawBarsIfPlayerCastChanged( val );
	end

	fcast_casts[caster]["currentTargets"] = {};
	fcast_casts[caster]["currentTargets"][1] = icon;
	fc_addIndividualIconTargetCast(icon, array);
end

function fc_addIndividualMTTargetCast(mtNumber, array)
	if (not CT_RA_MainTanks[mtNumber]) then
		-- this tank does not exist, this is from a desync in CTRA between players?
		return;
	end
--	displayText("Added cast against mt target " .. mtNumber);

	-- players can only cast spells on one target at a time in WoW, which makes for a useful optimization
	
	local index = 0;
	for i = 1, 21 do
		index = index + 1;
		if (not fcast_casts[mtNumber][index]) then
--			displayText(" no cast on " .. i);
			break;
		end
		if (fc_timer > fcast_casts[mtNumber][index]["timer"] + fc_cancelTime) then
--			displayText("timer expired on  " .. i);
			break;
		end
	end
	
	if (index > 20) then
		return;
	end
	
--[[
	for key, val in CT_RA_MainTanks do
		if (fcast_raiders[val]) then
			local tankID = fcast_raiders[val]["id"];
			
			if (UnitIsUnit("target", "raid" .. tankID .. "target")) then
				return key;
			end
		end
	end
]]

	fcast_casts[mtNumber][index] = array;
--	displayText("Adding spell at time " .. fc_timer .. " with end time " .. fcast_casts[mtNumber][index]["timer"]);

--	local playerCastFinishTime = fc_getplayerCastFinishTime(mtNumber);
	-- no alpha out for mt target casts
	local playerCastFinishTime = fc_timer + 1500;


	-- determine if this cast effects our target or our locked target. If it does, then redraw the necessary bar.
	local target = "";
	if (fcast["lockTarget"]) then
		target = fcast["lockTarget"];
		if (type(target) ~= type (mtNumber)) then
			return;
		end
		
		if (target ~= mtNumber) then
			return;
		end
	else
		target = mtNumber;
		if (target ~= fc_currentTarget) then
			return;
		end
--[[		
		if (not CT_RA_MainTanks) then
			return;
		end
		
		if (not UnitIsUnit("target", "raid" .. fcast_raiders[ CT_RA_MainTanks[mtNumber] ]["id"] .. "target")) then
			return;
		end
]]		
	end
	
	fc_redrawIndividualBar( "forecast_targetBars_base_bars_castBar", target, index, playerCastFinishTime);
end

function fc_addIndividualIconTargetCast(iconNumber, array)
	-- players can only cast spells on one target at a time in WoW, which makes for a useful optimization
	local index = 0;
	for i = 1, 21 do
		index = index + 1;
		if (not fcast_casts[iconNumber][index]) then
--			displayText(" no cast on " .. i);
			break;
		end
		if (fc_timer > fcast_casts[iconNumber][index]["timer"] + fc_cancelTime) then
--			displayText("timer expired on  " .. i);
			break;
		end
	end
	
	if (index > 20) then
		return;
	end
	
--[[
	for key, val in CT_RA_MainTanks do
		if (fcast_raiders[val]) then
			local tankID = fcast_raiders[val]["id"];
			
			if (UnitIsUnit("target", "raid" .. tankID .. "target")) then
				return key;
			end
		end
	end
]]

	fcast_casts[iconNumber][index] = array;
--	displayText("Adding spell at time " .. fc_timer .. " with end time " .. fcast_casts[iconNumber][index]["timer"]);

	-- no alpha out for mt target casts
	local playerCastFinishTime = fc_timer + 1500;


	-- determine if this cast effects our target or our locked target. If it does, then redraw the necessary bar.
	local target = "";
	if (fcast["lockTarget"]) then
		target = fcast["lockTarget"];
		if (target ~= iconNumber) then
			return;
		end
	else
		target = iconNumber;
		if (target ~= fc_currentTarget) then
			return;
		end
	end
	
	fc_redrawIndividualBar( "forecast_targetBars_base_bars_castBar", target, index, playerCastFinishTime);
end

function fc_redrawBarsIfPlayerCastChanged(targetName)
	if (not fcast_casts[targetName]) then
		return;
	end;
	if (targetName == UnitName("target")) then
		fc_redrawBars("forecast_targetBars_base_bars", targetName);
	end
	if (targetName == playerName) then
		fc_redrawBars("forecast_selfBars_base_bars", targetName);
	end
end

--[[
fc_oldUseAction = UseAction;
function fc_newUseAction(a1, a2, a3)
	fc_oldUseAction(a1, a2, a3);
end
UseAction = fc_newUseAction;

fc_oldTargetUnit = TargetUnit;
function fc_newTargetUnit(unit)
	fc_SpellTarget = UnitName(unit);
	fc_oldTargetUnit(unit);
end
TargetUnit = fc_newTargetUnit;
]]

function forecast_version()
 	if (GetNumRaidMembers() <= 0) then
 		displayOfficialText("Not in a raid");
 		return;
 	end
	
	if ( not CT_RA_Level or CT_RA_Level == 0 ) then
		displayOfficialText("You must be promoted or leader to do that!");
		return;
	end

	fc_viewingVersions = true;
	fcast_version = {};
	local count = 0;
	local numEntries = GetNumRaidMembers();	

	for i = 1, 40 do
		fcast_version[i] = {};
		fcast_version[i]["name"] = "";
		fcast_version[i]["version"] = 0;
		fcast_version[i]["class"] = HF_WARRIOR;
	end
		
	for i = 1, numEntries do
		local name, rank, subgroup, level, class, fileName, zone, online, isDead = GetRaidRosterInfo(i);
		if (name) then
			count = count + 1;
			fcast_version[count] = {};
			fcast_version[count]["name"] = name;
			fcast_version[count]["version"] = 0;
			fcast_version[count]["class"] = class;
			if (online) then
				fcast_version[count]["online"] = true;
			end
		end
	end
	
	fc_hideOptions();

	fc_sendMessage("KCVRrequest");
	fc_version_scroll();
	fc_versionFrame:Show();
end

function fc_updatePlayersVersion(name, version)
	if (not fc_viewingVersions) then
		return;
	end

	if (not fcast_version) then
		return;
	end
		
	local count = getn(fcast_version);
	for i = 1, count do
		if (name == fcast_version[i]["name"]) then
			fcast_version[i]["version"] = version;
		end
	end
	
	fc_version_scroll();
end

function fc_version_scroll()

	local numEntries = GetNumRaidMembers();	
	if ( numEntries <= 0) then
		return;
	end

	fc_sortVersionArray();	
	
	FauxScrollFrame_Update(fc_versionFrameScrollFrame, numEntries, 19, 20);

	for i = 1, 19, 1 do
		local button = getglobal("fc_versionFramePlayer" .. i);
		local index = i + FauxScrollFrame_GetOffset(fc_versionFrameScrollFrame);
		if ( index <= numEntries ) then
			if ( numEntries <= 19 ) then
				button:SetWidth(275);
			else
				button:SetWidth(253);
			end

			fc_versionFrameScrollFrame:SetPoint("TOPLEFT", "fc_versionFrame", "TOPLEFT", 19, -32);
			fc_versionFrameNameTab:SetWidth(118);

			button:Show();
			getglobal(button:GetName() .. "Name"):SetText(fcast_version[index]["name"]);
			local class = fcast_version[index]["class"];
			
			getglobal(button:GetName() .. "Name"):SetTextColor(fc_colors[class][1], fc_colors[class][2], fc_colors[class][3]);
			local version = fcast_version[index]["version"];
			if (version == 0) then
				if (fcast_version[index]["online"]) then
					getglobal(button:GetName() .. "Info"):SetText("None");
				else
					getglobal(button:GetName() .. "Info"):SetText("Offline");
				end
			else
				local ver = version;
				if (ver > 100) then
					ver = ver - 100;
					ver = "1." .. ver;
				end
				getglobal(button:GetName() .. "Info"):SetText(ver);
			end
		else
			button:Hide();
		end
	end
end

function fc_sortVersionArray()
	local count = getn(fcast_version);
	while (true) do
		movedEntree = nil;			
		for i = 1, (count-1) do
			if (fcast_version[i]["version"] < fcast_version[i+1]["version"]) then
				movedEntree = true;
				local tempEntree = fcast_version[i];
				fcast_version[i] = fcast_version[i+1];
				fcast_version[i+1] = tempEntree;
			end
		end
		
		if (not movedEntree) then
			return;
		end
	end
end

function fc_setScale()
	getglobal("forecast_targetBars_base"):SetScale(fcast["scale"]["target"]);
	getglobal("forecast_selfBars_base"):SetScale(fcast["scale"]["self"]);
end

function fc_getMin()
	return 0.6;
end

function fc_getMax()
	return 1.3;
end

function fc_scaleSlider()
	local min = fc_getMin();
	local max = fc_getMax();
	local type = fc_getType();
	fcast["scale"][type] = ((this:GetValue() * (max-min)) / 100) + min;
	fc_currentMenu:SetScale(fcast["scale"][type]);
end

function forecast_unlock()
	displayOfficialText("Unlocked target");
	fcast["lockTarget"] = nil;
	fc_hideOptions();
	fc_setTargetText();
end

function forecast_lock()
	if (fc_currentMenu:GetName() == "forecast_selfBars_base") then
		return;
	end
	
	fc_currentTarget = fc_getTarget();
	if (fc_currentTarget) then
		if (not fcast_casts[fc_currentTarget]) then
			displayOfficialText("That is either not a member or it's not an MT box or target symbol");
			return;
		end
		fcast["lockTarget"] = fc_currentTarget;
		if (type(fc_currentTarget) == "string") then
			displayOfficialText("Locked on to " .. fc_currentTarget);
		else
			displayOfficialText("Locked on to MT box or symbol " .. fc_currentTarget);
		end
	else
		fcast["lockTarget"] = nil;
	end
	fc_hideOptions();
	
	fc_setTargetText();
end

function fc_setTargetText()
	local frame = getglobal("forecast_targetBars_baseText");
	if (fcast["lockTarget"]) then
		if (type(fcast["lockTarget"]) ~= "string") then
			frame:SetText("Incoming Casts on MT" .. fcast["lockTarget"] .. "'s target");
			--[[
			local name = UnitName("raid" .. fcast_raiders[CT_RA_MainTanks[fcast["lockTarget"]}}["id"] .. "target");
			if (name) then
				frame:SetText("Incoming Casts on " .. name);
			else
			end
			]]
		else
			frame:SetText("Incoming Casts on " .. fcast["lockTarget"]);
		end
	else
		frame:SetText("Incoming Casts on Target");
	end
end

function fc_hideOptions()
	fc_showAllCastBars();
	fc_castMenu:Hide();
	fc_currentMenu = nil;
end

function displayArgs()
	if (arg1) then
		displayText("arg1 " .. arg1);
	end
	if (arg2) then
		displayText("arg2 " .. arg2);
	end
	if (arg3) then
		displayText("arg3 " .. arg3);
	end
	if (arg4) then
		displayText("arg4 " .. arg4);
	end
	if (arg5) then
		displayText("arg5 " .. arg5);
	end
	if (arg6) then
		displayText("arg6 " .. arg6);
	end
	if (arg7) then
		displayText("arg7 " .. arg7);
	end
	if (arg8) then
		displayText("arg8 " .. arg8);
	end
	if (arg9) then
		displayText("arg9 " .. arg9);
	end
end

function fc_sendMessage( msg )
	if ( GetNumRaidMembers() == 0 ) then 
		-- Mod should be disabled if not in raid
		return; 
	end; 
	
	SendAddonMessage("FORECAST", msg, "RAID");
end


-- This section is, well, its straight out of CT_Raidassist. The only way I could remove depency on CT_RA and keep the functionality of
-- acquiring the target of the mouse and all the other weird situations where the game doesnt acquire the proper spell target was to either
-- require CT_RA or copy the code or write it on my own. Personally I think this stuff should be more readily available to the scripts so
-- you don't have to do this wrapper stuff, but anyway, I chose the path of least resistence even though it is not my personal preference
-- to copy others code. So consider this little section of text an attribution to the wonderful CT_RaidAssist team, without whom the
-- target acquisition section of Forecast would not exist.

fc_SpellSpell = nil;
fc_SpellCast = nil;

fc_oldCastSpell = CastSpell;
function fc_newCastSpell(spellId, spellbookTabNum)
   -- Call the original function so there's no delay while we process
   fc_oldCastSpell(spellId, spellbookTabNum);
       
   -- Load the tooltip with the spell information
   FC_DST:SetSpell(spellId, spellbookTabNum);
   
   local spellName = FC_DSTTextLeft1:GetText();
       
   if ( SpellIsTargeting() ) then 
       -- Spell is waiting for a target
       fc_SpellSpell = spellName;
   elseif ( UnitExists("target") ) then
       -- Spell is being cast on the current target.  
       -- If ClearTarget() had been called, we'd be waiting target
	   fc_ProcessSpellCast(spellName, UnitName("target"));
   end
end
CastSpell = fc_newCastSpell;

fc_oldCastSpellByName = CastSpellByName;
function fc_newCastSpellByName(spellName, onSelf)
	-- Call the original function
	fc_oldCastSpellByName(spellName, onSelf)
	local _, _, spellName = string.find(spellName, "^([^%(]+)");
	if ( spellName ) then
		if ( SpellIsTargeting() ) then
			fc_SpellSpell = spellName;
		else
			fc_ProcessSpellCast(spellName, UnitName("target"));
		end
	end
end
CastSpellByName = fc_newCastSpellByName;

fc_oldWorldFrameOnMouseDown = WorldFrame:GetScript("OnMouseDown");
WorldFrame:SetScript("OnMouseDown", function()
	-- If we're waiting to target
	local targetName;
	
	if ( fc_SpellSpell and UnitName("mouseover") ) then
		targetName = UnitName("mouseover");
	elseif ( fc_SpellSpell and GameTooltipTextLeft1:IsVisible() ) then
		local _, _, name = string.find(GameTooltipTextLeft1:GetText(), "^Corpse of (.+)$");
		if ( name ) then
			targetName = name;
		end
	end
	if ( fc_oldWorldFrameOnMouseDown ) then
		fc_oldWorldFrameOnMouseDown();
	end
	if ( fc_SpellSpell and targetName ) then
		fc_ProcessSpellCast(fc_SpellSpell, targetName);
	end
end);

fc_oldUseAction = UseAction;
function fc_newUseAction(a1, a2, a3)
	
	FC_DST:SetAction(a1);
	local spellName = FC_DSTTextLeft1:GetText();
	fc_SpellSpell = spellName;
	
	-- Call the original function
	fc_oldUseAction(a1, a2, a3);
	
	-- Test to see if this is a macro
	if ( GetActionText(a1) or not fc_SpellSpell ) then
		return;
	end
	
	if ( SpellIsTargeting() ) then
		-- Spell is waiting for a target
		return;
	elseif ( a3 ) then
		-- Spell is being cast on the player
		fc_ProcessSpellCast(spellName, UnitName("player"));
	elseif ( UnitExists("target") ) then
		-- Spell is being cast on the current target
		fc_ProcessSpellCast(spellName, UnitName("target"));
	end
end
UseAction = fc_newUseAction;

fc_oldSpellTargetUnit = SpellTargetUnit;
function fc_newSpellTargetUnit(unit)
	-- Call the original function
	local shallTargetUnit;
	if ( SpellIsTargeting() ) then
		shallTargetUnit = true;
	end
	fc_oldSpellTargetUnit(unit);
	if ( shallTargetUnit and fc_SpellSpell and not SpellIsTargeting() ) then
		fc_ProcessSpellCast(fc_SpellSpell, UnitName(unit));
		fc_SpellSpell = nil;
	end
end
SpellTargetUnit = fc_newSpellTargetUnit;

fc_oldSpellStopTargeting = SpellStopTargeting;
function fc_newSpellStopTargeting()
	fc_oldSpellStopTargeting();
	fc_SpellSpell = nil;
end
SpellStopTargeting = fc_newSpellStopTargeting;

fc_oldTargetUnit = TargetUnit;
function fc_newTargetUnit(unit)
	-- Call the original function
	fc_oldTargetUnit(unit);
	
	-- Look to see if we're currently waiting for a target internally
	-- If we are, then well glean the target info here.
	
	if ( fc_SpellSpell and UnitExists(unit) ) then
		fc_ProcessSpellCast(fc_SpellSpell, UnitName(unit));
	end
end
TargetUnit = fc_newTargetUnit;

function fc_ProcessSpellCast(spellName, targetName)
	if ( spellName and targetName ) then
		fc_SpellCast = { spellName, targetName };
	end
end

function fc_DetectSpells_OnEvent(event)
	if ( event == "SPELLCAST_START" ) then
		if ( fc_SpellCast and fc_SpellCast[1] == arg1 ) then
			fc_SpellStartCast(fc_SpellCast);
		end
	elseif ( event == "SPELLCAST_INTERRUPTED" or event == "SPELLCAST_STOP" or event == "SPELLCAST_FAILED" ) then

		fc_SpellEndCast();
		fc_SpellCast =  nil;
		fc_SpellSpell =  nil;
	end
end
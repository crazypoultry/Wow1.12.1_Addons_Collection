MBB_Version = "0.312";
MBB_DebugFlag = 0;
MBB_DragFlag = 0;
MBB_ShowTimeout = -1;
MBB_Buttons = {};
MBB_Exclude = {};
MBB_DefaultOptions = {
	["ButtonPos"] = {-18, -100},
	["AttachToMinimap"] = 1,
	["CollapseTimeout"] = 1,
	["ExpandDirection"] = 1
};

MBB_Include = {
	[1] = "WIM_IconFrame"
};

MBB_Ignore = {
	[1] = "MiniMapTrackingFrame",
	[2] = "MiniMapMeetingStoneFrame",
	[3] = "MiniMapMailFrame",
	[4] = "MiniMapBattlefieldFrame",
	[5] = "MiniMapPing",
	[6] = "MinimapBackdrop",
	[7] = "MinimapZoomIn",
	[8] = "MinimapZoomOut",
	[9] = "BookOfTracksFrame",
	[10] = "GatherNote",
	[11] = "FishingExtravaganzaMini",
	[12] = "MiniNotePOI",
	[13] = "RecipeRadarMinimapIcon",
	[14] = "FWGMinimapPOI",
	[15] = "MBB_MinimapButtonFrame"
};

function MBB_OnLoad()
	this:RegisterEvent("VARIABLES_LOADED");
	SLASH_MBB1 = "/mbb";
	SlashCmdList["MBB"] = MBB_SlashHandler;
end

function MBB_SlashHandler(cmd)
	if( cmd == "buttons" ) then
		MBB_Print("MBB Buttons:");
		for i,name in ipairs(MBB_Buttons) do
			MBB_Print("  " .. name);
		end
	elseif( string.sub(cmd, 1, 6) == "debug " ) then
		local iStart, iEnd, sFrame = string.find(cmd, "debug (.+)");
		
		local hasClick, hasMouseUp, hasMouseDown, hasEnter, hasLeave = MBB_TestFrame(sFrame);
		
		MBB_Debug("Frame: " .. sFrame);
		if( hasClick ) then
			MBB_Debug("  has OnClick script");
		else
			MBB_Debug("  has no OnClick script");
		end
		if( hasMouseUp ) then
			MBB_Debug("  has OnMouseUp script");
		else
			MBB_Debug("  has no OnMouseUp script");
		end
		if( hasMouseDown ) then
			MBB_Debug("  has OnMouseDown script");
		else
			MBB_Debug("  has no OnMouseDown script");
		end
		if( hasEnter ) then
			MBB_Debug("  has OnEnter script");
		else
			MBB_Debug("  has no OnEnter script");
		end
		if( hasLeave ) then
			MBB_Debug("  has OnLeave script");
		else
			MBB_Debug("  has no OnLeave script");
		end
	elseif( cmd == "reset position" ) then
		MBB_Options.AttachToMinimap = MBB_DefaultOptions.AttachToMinimap;
		MBB_Options.ButtonPos = MBB_DefaultOptions.ButtonPos;
		MBB_SetButtonPosition();
	elseif( cmd == "reset all" ) then
		MBB_Options = MBB_DefaultOptions;
		for i=1,table.getn(MBB_Exclude) do
			MBB_AddButton(MBB_Exclude[1]);
		end
		MBB_SetPositions();
		MBB_SetButtonPosition();
	else
		MBB_Print("MBB v" .. MBB_Version .. ":");
		MBB_Print(MBB_HELP1);
		MBB_Print(MBB_HELP2);
		MBB_Print(MBB_HELP3);
		MBB_Print(MBB_HELP4);
	end
end

function MBB_TestFrame(name)
	local hasClick = false;
	local hasMouseUp = false;
	local hasMouseDown = false;
	local hasEnter = false;
	local hasLeave = false;
	local frame = getglobal(name);
	
	if( frame ) then
		if( frame:HasScript("OnClick") ) then
			local test = frame:GetScript("OnClick");
			if( test ) then
				hasClick = true;
			end
		end
		if( frame:HasScript("OnMouseUp") ) then
			local test = frame:GetScript("OnMouseUp");
			if( test ) then
				hasMouseUp = true;
			end
		end
		if( frame:HasScript("OnMouseDown") ) then
			local test = frame:GetScript("OnMouseDown");
			if( test ) then
				hasMouseDown = true;
			end
		end
		if( frame:HasScript("OnEnter") ) then
			local test = frame:GetScript("OnEnter");
			if( test ) then
				hasEnter = true;
			end
		end
		if( frame:HasScript("OnLeave") ) then
			local test = frame:GetScript("OnLeave");
			if( test ) then
				hasLeave = true;
			end
		end
	end
	
	return hasClick, hasMouseUp, hasMouseDown, hasEnter, hasLeave;
end

function MBB_OnEvent()
	if ( event == "VARIABLES_LOADED" ) then
		if( MBB_Options ) then
			for opt,val in pairs(MBB_DefaultOptions) do
				if( not MBB_Options[opt] ) then
					MBB_Debug(opt .. " option set to default: " .. tostring(val));
					MBB_Options[opt] = val;
				else
					MBB_Debug(opt .. " option exists: " .. tostring(MBB_Options[opt]));
				end
			end
		else
			MBB_Options = MBB_DefaultOptions;
		end
		
		MBB_SetButtonPosition();
		
		local children = {Minimap:GetChildren()};
		local additional = {MinimapBackdrop:GetChildren()};
		for _,child in ipairs(additional) do
			table.insert(children, child);
		end
		for _,child in ipairs(MBB_Include) do
			local frame = getglobal(child);
			if( frame ) then
				table.insert(children, frame);
			end
		end
		
		for _,child in ipairs(children) do
			if( child:GetName() ) then
				local ignore = false;
				local exclude = false;
				for i,needle in ipairs(MBB_Ignore) do
					if( string.find(child:GetName(), needle) ) then
						ignore = true;
					end
				end
				if( not ignore ) then
					if( not child:HasScript("OnClick") ) then
						for _,subchild in ipairs({child:GetChildren()}) do
							if( subchild:HasScript("OnClick") ) then
								child = subchild;
								break;
							end
						end
					end
					
					local hasClick, hasMouseUp, hasMouseDown, hasEnter, hasLeave = MBB_TestFrame(child:GetName());
					
					if( hasClick or hasMouseUp or hasMouseDown ) then
						local name = child:GetName();
						
						MBB_PrepareButton(name);
						if( not MBB_IsExcluded(name) ) then
							if( child:IsVisible() ) then
								MBB_Debug("Button is visible: " .. name);
							else
								MBB_Debug("Button is not visible: " .. name);
							end
							MBB_Debug("Button added: " .. name);
							MBB_AddButton(name);
						else
							MBB_Debug("Button excluded: " .. name);
						end
					else
						MBB_Debug("Frame is no button: " .. child:GetName());
					end
				else
					MBB_Debug("Frame ignored: " .. child:GetName());
				end
			end
		end
		
		MBB_SetPositions();
	end
end

function MBB_PrepareButton(name)
	local frame = getglobal(name);
	
	if( frame ) then
		if( frame.RegisterForClicks ) then
			frame:RegisterForClicks("LeftButtonDown","RightButtonDown");
		end
		
		frame.isvisible = frame:IsVisible();
		frame.oshow = frame.Show;
		frame.Show = function(frame)
			frame.isvisible = true;
			MBB_Debug("Showing frame: " .. frame:GetName());
			if( not MBB_IsExcluded(frame:GetName()) ) then
				MBB_SetPositions();
			end
			if( MBB_IsExcluded(frame:GetName()) or (MBB_Buttons[1] and MBB_Buttons[1] ~= frame:GetName() and getglobal(MBB_Buttons[1]):IsVisible()) ) then
				frame.oshow(frame);
			end
		end
		frame.ohide = frame.Hide;
		frame.Hide = function(frame)
			frame.isvisible = false;
			MBB_Debug("Hiding frame: " .. frame:GetName());
			frame.ohide(frame);
			if( not MBB_IsExcluded(frame:GetName()) ) then
				MBB_SetPositions();
			end
		end
		
		if( frame:HasScript("OnClick") ) then
			frame.oclick = frame:GetScript("OnClick");
			frame:SetScript("OnClick", function()
				if( arg1 and arg1 == "RightButton" and IsControlKeyDown() ) then
					local name = this:GetName();
					if( MBB_IsExcluded(name) ) then
						MBB_AddButton(name);
					else
						MBB_RestoreButton(name);
					end
					MBB_SetPositions();
				elseif( this.oclick ) then
					this.oclick();
				end
			end);
		elseif( frame:HasScript("OnMouseUp") ) then
			frame.omouseup = frame:GetScript("OnMouseUp");
			frame:SetScript("OnMouseUp", function()
				if( arg1 and arg1 == "RightButton" and IsControlKeyDown() ) then
					local name = this:GetName();
					if( MBB_IsExcluded(name) ) then
						MBB_AddButton(name);
					else
						MBB_RestoreButton(name);
					end
					MBB_SetPositions();
				elseif( this.omouseup ) then
					this.omouseup();
				end
			end);
		elseif( frame:HasScript("OnMouseDown") ) then
			frame.omousedown = frame:GetScript("OnMouseDown");
			frame:SetScript("OnMouseDown", function()
				if( arg1 and arg1 == "RightButton" and IsControlKeyDown() ) then
					local name = this:GetName();
					if( MBB_IsExcluded(name) ) then
						MBB_AddButton(name);
					else
						MBB_RestoreButton(name);
					end
					MBB_SetPositions();
				elseif( this.omousedown ) then
					this.omousedown();
				end
			end);
		end
		if( frame:HasScript("OnEnter") ) then
			frame.oenter = frame:GetScript("OnEnter");
			frame:SetScript("OnEnter", function()
				if( not MBB_IsExcluded(this:GetName()) ) then
					MBB_ShowTimeout = -1;
				end
				if( this.oenter ) then
					this.oenter();
				end
			end);
		end
		if( frame:HasScript("OnLeave") ) then
			frame.oleave = frame:GetScript("OnLeave");
			frame:SetScript("OnLeave", function()
				if( not MBB_IsExcluded(this:GetName()) ) then
					MBB_ShowTimeout = 0;
				end
				if( this.oleave ) then
					this.oleave();
				end
			end);
		end
	end
end

function MBB_AddButton(name)
	local show = false;
	local child = getglobal(name);
	
	if( MBB_Buttons[1] and MBB_Buttons[1] ~= name and getglobal(MBB_Buttons[1]):IsVisible() ) then
		show = true;
	end
	
	child.opoint = {child:GetPoint()};
	if( not child.opoint[1] ) then
		child.opoint = {"TOP", Minimap, "BOTTOM", 0, 0};
	end
	child.osize = {child:GetHeight(),child:GetWidth()};
	child.oclearallpoints = child.ClearAllPoints;
	child.ClearAllPoints = function() end;
	child.osetpoint = child.SetPoint;
	child.SetPoint = function() end;
	if( not show ) then
		child.ohide(child);
	end
	table.insert(MBB_Buttons, name);
	for i,exname in ipairs(MBB_Exclude) do
		if( name == exname ) then
			table.remove(MBB_Exclude, i);
			break;
		end
	end
end

function MBB_IsExcluded(name)
	for i,needle in ipairs(MBB_Exclude) do
		if( needle == name ) then
			return true;
		end
	end
	return false;
end

function MBB_RestoreButton(name)
	local button = getglobal(name);
	
	button.oclearallpoints(button);
	button.osetpoint(button, button.opoint[1], button.opoint[2], button.opoint[3], button.opoint[4], button.opoint[5]);
	button:SetHeight(button.osize[1]);
	button:SetWidth(button.osize[1]);
	button.ClearAllPoints = button.oclearallpoints;
	button.SetPoint = button.osetpoint;
	button.oshow(button);
	
	table.insert(MBB_Exclude, name);
	for i,name in ipairs(MBB_Buttons) do
		if( name == button:GetName() ) then
			table.remove(MBB_Buttons, i);
			break;
		end
	end
end

function MBB_SetPositions()
	local directions = {
		[1] = {"RIGHT", "LEFT"},
		[2] = {"BOTTOM", "TOP"},
		[3] = {"LEFT", "RIGHT"},
		[4] = {"TOP", "BOTTOM"}
	};
	
	local parentid = 0;
	for i,name in ipairs(MBB_Buttons) do
		local frame = getglobal(name);
		if( frame.isvisible ) then
			local parent;
			if( parentid==0 ) then
				parent = MBB_MinimapButtonFrame;
			else
				parent = getglobal(MBB_Buttons[parentid]);
			end
			
			frame:SetHeight(33);
			frame:SetWidth(33);
			frame.oclearallpoints(frame);
			frame.osetpoint(frame, directions[MBB_Options.ExpandDirection][1], parent, directions[MBB_Options.ExpandDirection][2], 0, 0);
			
			parentid = i;
		end
	end
end

function MBB_OnClick(arg1)
	if( arg1 and arg1 == "RightButton" and IsControlKeyDown() ) then
		if( MBB_Options.AttachToMinimap == 1 ) then
			local xpos,ypos = GetCursorPosition();
			local scale = GetCVar("uiScale");
			MBB_Options.AttachToMinimap = 0;
			MBB_Options.ButtonPos = {(xpos/scale)-10, (ypos/scale)-10};
			MBB_SetButtonPosition();
		else
			MBB_Options.AttachToMinimap = 1;
			MBB_Options.ButtonPos = MBB_DefaultOptions.ButtonPos;
			MBB_SetButtonPosition();
		end
	elseif( arg1 and arg1 == "RightButton" ) then
		MBB_OptionsFrame:Show();
	else
		if( MBB_Buttons[1] and getglobal(MBB_Buttons[1]):IsVisible() ) then
			MBB_HideButtons();
		else
			for i,name in ipairs(MBB_Buttons) do
				local frame = getglobal(name);
				frame.oshow(frame);
			end
			--MBB_ShowTimeout = 0;
		end
	end
end

function MBB_HideButtons()
	MBB_ShowTimeout = -1;
	for i,name in ipairs(MBB_Buttons) do
		local frame = getglobal(name);
		frame.ohide(frame);
	end
end

function MBB_OnUpdate(elapsed)
	if( MBB_DragFlag == 1 and MBB_Options.AttachToMinimap == 1 ) then
		local xpos,ypos = GetCursorPosition();
		local xmin,ymin = Minimap:GetLeft(), Minimap:GetBottom();

		xpos = xmin-xpos/Minimap:GetEffectiveScale()+70;
		ypos = ypos/Minimap:GetEffectiveScale()-ymin-70;

		local angle = math.deg(math.atan2(ypos,xpos));
		
		MBB_MinimapButtonFrame:SetPoint("TOPLEFT", Minimap, "TOPLEFT", 53-(cos(angle)*81), -55+(sin(angle)*81));
	end
	
	if( MBB_Options.CollapseTimeout and MBB_Options.CollapseTimeout ~= 0 ) then
		if( MBB_Buttons[1] ) then
			if( MBB_ShowTimeout >= MBB_Options.CollapseTimeout and getglobal(MBB_Buttons[1]):IsVisible() ) then
				MBB_HideButtons();
			end
		end
		if( MBB_ShowTimeout ~= -1 ) then
			MBB_ShowTimeout = MBB_ShowTimeout + elapsed;
		end
	end
end

function MBB_ResetPosition()
	MBB_Options.ButtonPos = MBB_DefaultOptions.ButtonPos;
	MBB_Options.AttachToMinimap = MBB_DefaultOptions.AttachToMinimap;
	
	MBB_SetButtonPosition();
end

function MBB_SetButtonPosition()
	if( MBB_Options.AttachToMinimap == 1 ) then
		MBB_MinimapButtonFrame:ClearAllPoints();
		MBB_MinimapButtonFrame:SetPoint("TOPLEFT", Minimap, "TOPLEFT", MBB_Options.ButtonPos[1], MBB_Options.ButtonPos[2]);
	else
		MBB_MinimapButtonFrame:ClearAllPoints();
		MBB_MinimapButtonFrame:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", MBB_Options.ButtonPos[1], MBB_Options.ButtonPos[2]);
	end
end

function MBB_RadioButton_OnClick(id)
	local buttons = {
		[1] = "Left",
		[2] = "Top",
		[3] = "Right",
		[4] = "Bottom"
	};
	
	for i,name in ipairs(buttons) do
		if( i == id ) then
			getglobal("MBB_OptionsFrame_" .. name .. "Radio"):SetChecked(true);
		else
			getglobal("MBB_OptionsFrame_" .. name .. "Radio"):SetChecked(nil);
		end
	end
end

function MBB_Debug(msg)
	if (MBB_DebugFlag == 1) then
		MBB_Print("MBB Debug : " .. msg);
	end
end

function MBB_Print(msg)
	DEFAULT_CHAT_FRAME:AddMessage(msg, 0.2, 0.8, 0.8);
end
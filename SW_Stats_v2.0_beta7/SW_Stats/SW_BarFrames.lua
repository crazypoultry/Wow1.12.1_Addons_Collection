
-- array holding bars
SW_Bars = {};

SW_BARSEPX = 5;
SW_BARSEPY = 3;

function SW_LayoutMainWinButtons()
	anchorTo = "SW_BarFrame1_Title_Report";
	if SW_Settings.OPT_ShowConsoleB then
		SW_BarFrame1_Title_Console:SetPoint("TOPRIGHT", anchorTo, "TOPLEFT", -3, 0 );
		anchorTo = "SW_BarFrame1_Title_Console";
	end
	if SW_Settings.OPT_ShowSyncB then
		SW_BarFrame1_Title_Sync:SetPoint("TOPRIGHT", anchorTo, "TOPLEFT", -3, 0 );
		anchorTo = "SW_BarFrame1_Title_Sync";
	end
	if SW_Settings.OPT_ShowTLB then
		SW_BarFrame1_Title_TimeLine:SetPoint("TOPRIGHT", anchorTo, "TOPLEFT", -3, 0 );
		anchorTo = "SW_BarFrame1_Title_TimeLine";
	end
end
function SW_BarRegister(oB)

	local pName = oB:GetParent():GetName();
	
	if SW_Bars[pName] == nil then SW_Bars[pName] = {}; end
	
	table.insert(SW_Bars[pName], oB);
end

function SW_SelOpt(optButton)
	local wasShown = false;
	if SW_BarSettingsFrameV2:IsVisible() then
		wasShown= true;
		SW_BarSettingsFrameV2:Hide();
		if ColorPickerFrame:IsVisible() then 
			ColorPickerFrame:Hide();
		end
	end
	local cont = optButton:GetParent():GetParent():GetName();
	
	SW_Settings["BarFrames"][cont]["Selected"] = optButton.optID;
	SW_OptUpdateText(cont);
	SW_BarsLayout(cont, true);
	if wasShown then
		getglobal("SW_BarSettingsFrameV2"):Show();
	end
	if SW_BarFrame1:IsVisible() then
		SW_UpdateBars();
	end
end
function SW_ToggleReport(frameP)
	if SW_BarReportFrame:IsVisible() then
		SW_BarReportFrame:Hide();
	else
		SW_BarReportFrame.caller = frameP;
		SW_BarReportFrame:Show();
	end
end
function SW_ToggleSync()
	if SW_BarSyncFrame:IsVisible() then
		SW_BarSyncFrame:Hide();
	else
		SW_BarSyncFrame:Show();
	end
end
function SW_ToggleTL()
	if SW_TimeLine:IsVisible() then
		SW_TimeLine:Hide();
	else
		SW_TimeLine:Show();
	end
end
function SW_UpdateSyncChanText(newChan)
	if tonumber(newChan) then
		StaticPopup_Show("SW_InvalidChan");
	end
end

function SW_OptUpdateText(pName)
	local selOpt =  SW_Settings["BarFrames"][pName]["Selected"];
	local bSet = SW_GetBarSettings(pName);
	local b = getglobal(pName.."_Selector_Opt"..selOpt);
	local txtOpt = "";
	local txtFrame = "";
	if bSet["OT"] == nil then
		txtOpt = selOpt;
	else
		txtOpt = bSet["OT"];
	end
	b.NormalText:SetText(txtOpt);
	b.HighlightText:SetText(txtOpt);
	if bSet["OTF"] == nil then
		txtFrame = selOpt;
	else
		txtFrame = bSet["OTF"];
	end
	getglobal(pName.."_Title_Text"):SetText(txtFrame);
end
function SW_SetOptTxt(opt)
	local bS = SW_Settings["InfoSettings"][opt.optID];
	if bS == nil then return; end
	local oc = bS["OC"];
	local txt = "";
	if bS == nil or bS["OT"] == nil then
		txt = opt.optID;
	else
		txt = bS["OT"];
	end
	opt.NormalText:SetText(txt);
	opt.HighlightText:SetText(txt);
	--old version check
	if oc == nil or (oc[1] == 1 and oc[2] == 0 and oc[3] == 0 and oc[4] == 1) then
		oc = SW_Settings["Colors"]["TitleBars"]
	end
	
	opt.NormalT:SetVertexColor(unpack(oc));
	opt.HighlightT:SetVertexColor(unpack(oc));
	
end

function SW_GetBarSettings(pName)
	if SW_Settings["BarFrames"] == nil then
		SW_Settings["BarFrames"] = {};
	end
	
	if SW_Settings["BarFrames"][pName] == nil then
		SW_Settings["BarFrames"][pName] = {};
		SW_Settings["BarFrames"][pName]["Selected"] = 1;
		SW_Settings["BarFrames"][pName]["Docked"] = {1};
	end
	-- older version stored other stuff here
	if SW_Settings["BarFrames"][pName]["Selected"] == nil then
		SW_Settings["BarFrames"][pName] = {};
		SW_Settings["BarFrames"][pName]["Selected"] = 1;
		SW_Settings["BarFrames"][pName]["Docked"] = {1};
	end
	return SW_GetInfoSettings(SW_Settings["BarFrames"][pName]["Selected"]);
end
function SW_UpdateOptVis(reset)
	local nShow = SW_Settings["QuickOptCount"];
	local pre = "SW_BarFrame1_Selector_Opt";
	local toSelect = 1;
	if reset ~= nil then
		if nShow > 0 then
			if SW_Settings["BarFrames"] ~= nil and SW_Settings["BarFrames"]["SW_BarFrame1"] ~= nil then
				toSelect = SW_Settings["BarFrames"]["SW_BarFrame1"]["Selected"];
				if toSelect == nil then
					toSelect = 1;
				end
			end
			if toSelect > nShow then
				SW_SelOpt(getglobal(pre..nShow));
			end
		else
			SW_SelOpt(getglobal(pre.."1"));
		end
	end
	for i= 1, SW_OPT_COUNT do
		if i <= nShow then
			getglobal(pre..i):Show();
		else
			getglobal(pre..i):Hide();
		end
	end
end
function SW_SelectFilter(fName)
	getglobal("SW_Filter_NPC"):SetChecked(0);
	getglobal("SW_Filter_PC"):SetChecked(0);
	getglobal("SW_Filter_Group"):SetChecked(0);
	getglobal("SW_Filter_EverGroup"):SetChecked(0);
	getglobal("SW_Filter_None"):SetChecked(0);
	getglobal(fName):SetChecked(1);
end
function SW_GetInfoSettings(infoNr)
	if SW_Settings["InfoSettings"] == nil then
		SW_Settings["InfoSettings"] = {}
	end
	local iS = SW_Settings["InfoSettings"][infoNr];
	
	
	if iS == nil then
		SW_Settings["InfoSettings"][infoNr] = {}
		iS = SW_Settings["InfoSettings"][infoNr];
		for k,v in pairs(SW_DefaultBar) do 
			if type(v) ~= "table" then
				iS[k] = v;
			else
				iS[k] = {};
				for si, sv in ipairs(v) do
					table.insert(iS[k], sv);
				end
			end
		end
	else
		-- 1.4.2 merging removed bar width and adden colum count
		if iS["COLC"] == nil then
			iS["BW"] = nil;
			iS["COLC"] = 1;
		end
	end
	return iS;
end
-- 1.5 added pausing of data collection
function SW_ToggleRunning(doCollection)
	if SW_SYNC_DO and SW_SYNC_TO_USE and table.getn(SW_SyncState.peerInfo) > 1 then
		doCollection = true;
	end
	
	local chkRunnig = getglobal("SW_OptChk_Running");
	local stateChanged = (doCollection ~= SW_Settings["IsRunning"]);
	
	
	if doCollection then
		chkRunnig:SetChecked(1);
		SW_Settings["IsRunning"] = true;
	else
		chkRunnig:SetChecked(0);
		SW_Settings["IsRunning"] = false;
	end
	
	if stateChanged then
		if (doCollection) then
			-- turn on stuff
			SW_UnpauseEvents();
		else
			-- turn off stuff
			SW_PauseEvents();
			-- stop CastTrack Pending
			SW_Timed_Calls:StopPending();
			-- stop DPS timer
			SW_CombatTimeInfo.awaitingStart = false;
			SW_CombatTimeInfo.awaitingEnd = false;
		end
	end
end
function SW_UpdateColor(pName)
	local bs = SW_Bars[pName];
	local barSettings = SW_GetBarSettings(pName);
	local bc = barSettings["BC"];
	local bfc = barSettings["BFC"];
	local oc = barSettings["OC"];
	
	local selOpt =  SW_Settings["BarFrames"][pName]["Selected"];
	local b = getglobal(pName.."_Selector_Opt"..selOpt);
	-- old version check
	
	if oc == nil or (oc[1] == 1 and oc[2] == 0 and oc[3] == 0 and oc[4] == 1) then
		oc = SW_Settings["Colors"]["TitleBars"]
	end
	b.NormalT:SetVertexColor(unpack(oc));
	b.HighlightT:SetVertexColor(unpack(oc));
	
	for i,b in ipairs(bs) do
		getglobal(b:GetName().."_Texture"):SetVertexColor(bc[1],bc[2],bc[3],bc[4]);
		getglobal(b:GetName().."_Text"):SetVertexColor(bfc[1],bfc[2],bfc[3],bfc[4]);
		getglobal(b:GetName().."_TextVal"):SetVertexColor(bfc[1],bfc[2],bfc[3],bfc[4]);
	end
end
function SW_BarsLayout(pName, changeAll)
	local bs = SW_Bars[pName];
	if bs == nil then return; end
	
	local bSet = SW_GetBarSettings(pName);
	local startX, startY, fWidth, fHeight;
	local bHeight, bWidth, fontSize;
	local colPos=1; local rowPos=1;
	local colCount=bSet["COLC"];
	local oTmp;
	local posX = 0;
	local posY = 0;
	local oP = getglobal(pName);
	
	
	local changeWidth = false;
	local changeHeight = false;
	local changeFont = false;
	
	startX = oP.swoBarX;
	startY = oP.swoBarY;
	fWidth = oP:GetWidth();
	fHeight = oP:GetHeight();
	
	bAutoWidth = math.floor(((fWidth - 10 - ((colCount - 1) * SW_BARSEPX))  / colCount));
	for i,b in ipairs(bs) do
		if oP.lastTexture == nil or oP.lastTexture ~= bSet["BT"] or changeAll then
			b:SetStatusBarTexture("Interface\\AddOns\\SW_Stats\\images\\b"..bSet["BT"]);
		end
		if i == 1 then
			fontSize = b:GetFontSize();
			if fontSize ~= bSet["BFS"] or changeAll then
				fontSize = bSet["BFS"];
				b:SetFontSize(fontSize);
				changeFont = true;
			end
			bHeight = b:GetHeight();
			if bHeight ~= bSet["BH"] or changeAll then
				bHeight = bSet["BH"];
				b:SetHeight(bHeight);
				changeHeight = true;
			end
			bWidth = b:GetWidth();
			if bWidth ~= bAutoWidth or changeAll then
				bWidth = bAutoWidth;
				b:SetWidth(bWidth);
				changeWidth = true;
			end
			
			b:Show();
			b:SetPoint("TOPLEFT",pName,"TOPLEFT",startX,startY);
			--colCount = math.floor(((fWidth - 10)  / (SW_BARSEPX + bWidth)));
			rowCount = math.floor(((fHeight - 30) / (SW_BARSEPY + bHeight)));
			rowPos = rowPos + 1;
			b.canBeSeen = true;
		else
			if rowPos > rowCount then
				rowPos = 1;
				colPos = colPos + 1;	
			end
			posX =  ((colPos -1) * SW_BARSEPX) + startX + ((colPos -1) * bWidth);
			posY =  startY -(((rowPos -1) * SW_BARSEPY) + ((rowPos -1) * bHeight));
			-- update
			if changeWidth then
				b:SetWidth(bWidth);
			end
			if changeHeight then
				b:SetHeight(bHeight);
			end
			if changeFont then
				b:SetFontSize(fontSize);
			end
			b:SetPoint("TOPLEFT",pName,"TOPLEFT",posX,posY);
			
			rowPos = rowPos + 1;
			if posX + bWidth > fWidth then
				b:Hide();
				b.canBeSeen = false;
			else
				b:Show();
				b.canBeSeen = true;
			end
			
		end
	end
	
	if changeAll then
		SW_UpdateColor(pName);
	end
	--this forces the ui to create new font objects -> text is clear
	if changeFont then
		local tmpScale = oP:GetScale();
		oP:SetScale(tmpScale + 0.01);
		oP:SetScale(tmpScale);
	end
	
	oP.lastTexture = bSet["BT"];
	
end
function SW_OptKey(num)
	if not getglobal("SW_BarFrame1"):IsVisible() then
		getglobal("SW_BarFrame1"):Show()
	end
	SW_SelOpt(getglobal("SW_BarFrame1_Selector_Opt"..num));
end

function SW_BarLayoutRegisterd()
	for f,_ in pairs(SW_Bars) do
		SW_BarsLayout(f);
		SW_UpdateColor(f);
		SW_OptUpdateText(f);
	end
end
function SW_BarLayoutRegisterdOnResize()
	for f,_ in pairs(SW_Bars) do 
		if getglobal(f).isResizing then
			SW_BarsLayout(f);
		end
	end
end
function SW_InitBarFrameBar(b)
	local scTarget = b:GetName().."_Texture";
	getglobal(scTarget):SetVertexColor(0,0.8,0,1);
	b:SetMinMaxValues(0,100); 
	b:SetValue(100);
	SW_BarRegister(this);
	b.LText = getglobal(b:GetName().."_Text");
	b.RText = getglobal(b:GetName().."_TextVal");
	b.canBeSeen = false;
	function b:SetBarText(text)
		if text == nil then
			self.LText:SetText(" ");
			self:Hide();
		else
			self.LText:SetText(text);
			self:Show();
		end
	end
	function b:SetValText(text)
		self.RText:SetText(text);
	end
	function b:GetFontSize()
		return math.floor(self.LText:GetHeight() + 0.5);
	end
	function b:SetFontSize(h)
		-- this distorts text check SW_BarsLayout() for fix
		self.LText:SetTextHeight(h);
		self.RText:SetTextHeight(h);
	end
end

function SW_SetBarColor(what)
	local R,G,B = ColorPickerFrame:GetColorRGB();
	local A = 1 - OpacitySliderFrame:GetValue();
	local bfc;
	
	if what == "DIRECT" then
		bfc = ColorPickerFrame.SWColorTable
	else
		local barSettings = SW_GetBarSettings(ColorPickerFrame.SWBarFrame);
		bfc = barSettings[what];
	end 
	
	
	bfc[1] = R; bfc[2] = G; bfc[3] = B; bfc[4] = A;
	
	if what == "DIRECT" then
		if ColorPickerFrame.SWCallOnUpdate then
			ColorPickerFrame.SWCallOnUpdate(bfc);
		end
	else
		SW_UpdateColor(ColorPickerFrame.SWBarFrame);
	end
	if ColorPickerFrame.SWCSName ~= nil then
		getglobal(ColorPickerFrame.SWCSName):SetColor(bfc);
	end
end
function SW_CancelBarColor(oldVals, what)
	local bfc;
	
	if what == "DIRECT" then
		bfc = ColorPickerFrame.SWColorTable
	else
		local barSettings = SW_GetBarSettings(ColorPickerFrame.SWBarFrame);
		bfc = barSettings[what];
	end 
	
	bfc[1] = oldVals[1]; bfc[2] = oldVals[2];
	bfc[3] = oldVals[3]; bfc[4] = oldVals[4];
	if what == "DIRECT" then
		if ColorPickerFrame.SWCallOnUpdate then
			ColorPickerFrame.SWCallOnUpdate(bfc);
		end
	else
		SW_UpdateColor(ColorPickerFrame.SWBarFrame);
	end
	if ColorPickerFrame.SWCSName ~= nil then
		getglobal(ColorPickerFrame.SWCSName):SetColor(bfc);
	end
end
-- 1.5.3 TODO Low Prio I should redo this sometime the color picker thing is getting messy
-- probably could just reduce it to "DIRECT" color and callOnUpdate
function SW_DoColorPicker(targetFrame, what, csName, callOnUpdate)
	if ColorPickerFrame:IsVisible() then return; end
	local bfc;
	
	if what == "DIRECT" then
		bfc = targetFrame;
		ColorPickerFrame.SWBarFrame = "SW_BarFrame1";
		ColorPickerFrame.SWColorTable = targetFrame;
		ColorPickerFrame.SWCallOnUpdate = callOnUpdate;
		
	else
		
		local barSettings = SW_GetBarSettings(targetFrame);

		bfc = barSettings[what];
		if bfc == nil then
			barSettings[what] = {1,0,0,1};
			bfc = barSettings[what];
		end
		
		
		if bfc[1]==1 and bfc[2]==0 and bfc[3]==0 and bfc[4]==1 then
			bfc = SW_Settings["Colors"]["TitleBars"];
			
		end
		
		ColorPickerFrame.SWBarFrame = targetFrame;
		ColorPickerFrame.SWColorTable = nil;
	end
	
	ColorPickerFrame.SWCSName = csName;
	ColorPickerFrame.opacityFunc = function() SW_SetBarColor(what); end
	ColorPickerFrame.func = function() SW_SetBarColor(what); end
	ColorPickerFrame.cancelFunc = function(oldVals) SW_CancelBarColor(oldVals, what); end
	ColorPickerFrame.hasOpacity = true;
	ColorPickerFrame.opacity = 1 - bfc[4];
	ColorPickerFrame.previousValues = {bfc[1], bfc[2], bfc[3], bfc[4]};
	ColorPickerFrame:SetColorRGB(bfc[1], bfc[2], bfc[3]);
	ColorPickerFrame:Show();
end
function SW_UpdateClassColorAlpha(newColor)
	local alpha = newColor[4];
	SW_Settings["Colors"]["DRUID"][4] = alpha;
	SW_Settings["Colors"]["HUNTER"][4] = alpha;
	SW_Settings["Colors"]["MAGE"][4] = alpha;
	SW_Settings["Colors"]["PALADIN"][4] = alpha;
	SW_Settings["Colors"]["PRIEST"][4] = alpha;
	SW_Settings["Colors"]["ROGUE"][4] = alpha;
	SW_Settings["Colors"]["SHAMAN"][4] = alpha;
	SW_Settings["Colors"]["WARLOCK"][4] = alpha;
	SW_Settings["Colors"]["WARRIOR"][4] = alpha;
end
function SW_UpdateFrameBackdrops(newColor)
	local tmpTarget;
	for i, k in ipairs(SW_Registerd_BF_Titles) do
		tmpTarget = getglobal(k):GetParent();
		tmpTarget:SetBackdropBorderColor(unpack(newColor));
	end
	local tmpCol = {unpack(newColor)};
	tmpCol[4] = 1;
	
	--for SW_TabbedFrameInfo[pName][oTab:GetName()]
	for k, v in pairs(SW_TabbedFrameInfo) do
		for k2, v2 in pairs(v) do
			tmpTarget = getglobal(k2);
			if tmpTarget.IsSelectedTab then
				tmpTarget:SetBackdropBorderColor(unpack(tmpCol));
				getglobal(k2.."_Text"):SetTextColor(unpack(tmpCol));
			end
		end
	end	
end
function SW_LockFrames(isLocked)
	if isLocked then
		SW_Settings["BFLocked"] = true;
	else
		SW_Settings["BFLocked"] = nil;
	end
	for i, k in ipairs(SW_Registerd_BF_Titles) do
		getglobal(k):GetParent().isLocked = isLocked;
	end
end
function SW_UpdateMainWinBack(newColor)
	SW_BarFrame1:SetBackdropColor(unpack(SW_Settings["Colors"]["MainWinBack"])) 
end
function SW_UpdateTitleColor(newColor)
	local tmpTarget;
	local regEx = "SW_BarFrame1_Selector_Opt(%d+)"
	local oc;
	
	for i, k in ipairs(SW_Registerd_BF_Titles) do
		tmpTarget = getglobal(k .. "_Texture");
		tmpTarget:SetVertexColor(unpack(newColor));
	end
	
	for i, k in ipairs(SW_Registered_BF_TitleButtons) do
		s,e, id = string.find(k, regEx);
		oc = nil;
		if id ~= nil then
			id = tonumber(id);
			
			if SW_Settings["InfoSettings"] and SW_Settings["InfoSettings"][id] then
				oc = SW_Settings["InfoSettings"][id]["OC"];	
			end
			if not oc or (oc[1] == 1 and oc[2] == 0 and oc[3] == 0 and oc[4] == 1) then
				--oc = SW_Settings["Colors"]["TitleBars"]
				tmpTarget = getglobal(k);
				tmpTarget.NormalT:SetVertexColor(unpack(newColor));
				tmpTarget.HighlightT:SetVertexColor(unpack(newColor));
			end
		else
			tmpTarget = getglobal(k);
			tmpTarget.NormalT:SetVertexColor(unpack(newColor));
			tmpTarget.HighlightT:SetVertexColor(unpack(newColor));
		end
		
		
	end
	
	
end
function SW_UpdateTitleTextColor(newColor)
	local tmpTarget;
	local regEx = "SW_BarFrame1_Selector_Opt(%d+)"
	local id = 0;
	for i, k in ipairs(SW_Registerd_BF_Titles) do
		tmpTarget = getglobal(k .. "_Text");
		tmpTarget:SetVertexColor(unpack(newColor));
	end
	local barSettings = SW_GetBarSettings("SW_BarFrame1");
	
	for i, k in ipairs(SW_Registered_BF_TitleButtons) do
		s,e, id = string.find(k, regEx)
		if not id then
			tmpTarget = getglobal(k);
			tmpTarget.NormalText:SetVertexColor(unpack(newColor));
			tmpTarget.NormalText:SetVertexColor(unpack(newColor));
		end
	end

end

-- just a basic view, enhance later
function SW_SyncList_ScrollUpdate()
	local line; 
	local lineplusoffset; -- an index into our data calculated from the scroll offset
	local tmpLine;
	local tmpTxt;
	local tmpData;
	
	FauxScrollFrame_Update(SW_SyncList,table.getn(SW_SyncState.peerInfo),10,20);
	for line=1,10 do
		tmpLine = getglobal("SW_BarSyncFrame_Item"..line);
		lineplusoffset = line + FauxScrollFrame_GetOffset(SW_SyncList);
		if lineplusoffset <= table.getn(SW_SyncState.peerInfo) then
			tmpData = SW_SyncState.peerInfo[lineplusoffset];
			tmpTxt = getglobal("SW_BarSyncFrame_Item"..line.."_Text");
			-- TODO checking all should just be a temp fix (only checked locale at first.
			-- check why locale could be set and name isn't (nil error for name)
			if tmpData.name and tmpData.version and tmpData.locale then
				tmpTxt:SetText(tmpData.name.."   "..tmpData.version.."   "..tmpData.locale);
				tmpLine:Show();
			else
				--SW_DumpTable(tmpData);
				tmpLine:Hide();
			end
			
		else
			tmpLine:Hide();
		end
	end
end
--[[ TODO redo these for 2.0

function SW_GetTopHealDelta()
	return SW_GetTopDelta("TOPDELTAH");
end
function SW_GetTopDmgDelta()
	return SW_GetTopDelta("TOPDELTAD");
end

function SW_GetTopDelta(what)
	local vals = {};
	for k, v in pairs (SW_Sync_MsgTrack) do
		if v[what] > 0 then
			table.insert(vals, {k, v[what]});
		end
	end
	table.sort(vals, 
			function(a,b)
				return a[2] > b[2];
			end);	
	return vals;
end
--]]

function SW_UpdateBars()
	local f = SW_BarFrame1;
	if not f:IsVisible() then
		return;
	end
	
	local bSet = SW_GetBarSettings("SW_BarFrame1");
	if not bSet.IN then bSet.IN = 1; end

	local inf = SW_InfoTypes[bSet.IN];
	local selOpt =  SW_Settings["BarFrames"]["SW_BarFrame1"]["Selected"];
	local tmpPerCent = 0;
	local valText = "";
	local unitID;
	
	if SW_Settings.OPT_ShowMainWinDPS and SW_DPS_Dmg > 0 and SW_CombatTime > 5 then
		local dps = math.floor( (SW_DPS_Dmg / SW_CombatTime) * 10 + 0.5) / 10;
		if bSet.OTF then
			SW_BarFrame1_Title_Text:SetText(bSet.OTF.." (DPS:"..dps..")");
		else
			SW_BarFrame1_Title_Text:SetText(selOpt.." (DPS:"..dps..")");
		end
	else
		if bSet.OTF then
			SW_BarFrame1_Title_Text:SetText(bSet.OTF);
		else
			SW_BarFrame1_Title_Text:SetText(selOpt);
		end
	end
	
	-- update the view buffer, unitID is only returned on summeries per unit/per school
	unitID = inf.f(inf, bSet);
	
	local data = SW_ViewBuffer.data;
	local lastSortIndex = data[1].sortOrder;
	
	if lastSortIndex == 100 then
		-- no data to display
		for i, v in ipairs(SW_Bars["SW_BarFrame1"]) do
			if v.canBeSeen then
				v:SetValText(" ");
				v:SetValue(100);
				v:SetBarText();
			end
		end
		return; 
	end
	local oneEntry;
	local p1 = data[1].val / 100; 
	local datan = table.getn(data);
	for i, v in ipairs(SW_Bars["SW_BarFrame1"]) do
		
		if v.canBeSeen then
			oneEntry = data[i];
			
			if not oneEntry or i > datan or oneEntry.sortOrder == 100 or oneEntry.val == 0 then 
				
				v:SetBarText();
			else
				v.displayType = inf.displayType;
				-- needed infos for mouse over
				if inf.displayType == 1 then
					v.unitName = oneEntry.txt;
					v.unitID = oneEntry.unitID;
				elseif inf.displayType == 2 then
					v.unitID = unitID;
					v.skillID = SW_StrTable:hasID(oneEntry.txt);
				elseif inf.displayType == 3 or inf.displayType == 4 then
					v.unitID = unitID;
					v.schoolID = SW_Schools:getID(oneEntry.txt);
				else
					
				end
				
				if bSet.ShowRank then
					v:SetBarText(i.."   "..oneEntry.txt);
				else
					v:SetBarText(oneEntry.txt);
				end
				if bSet.ShowNumber then
					valText = oneEntry.val;
				else
					valText = "";
				end
				if bSet.ShowPercent then
					v:SetValText(valText.." ("..(math.floor((oneEntry.val/SW_ViewBuffer.sums[oneEntry.sortOrder]) *1000 + 0.5)/10).."%)");
				else
					v:SetValText(valText);
				end
				
				if oneEntry.sortOrder ~= lastSortIndex then
					lastSortIndex = oneEntry.sortOrder;
					p1 = oneEntry.val / 100;
				end
				
				v:SetValue( oneEntry.val /p1);
				if oneEntry.color then
					getglobal(v:GetName().."_Texture"):SetVertexColor(unpack(oneEntry.color));
				end
			end
		end
	end
end

function SW_SendRepLine(outStr, sVar)
	local sTarget = getglobal(SW_Settings["RepTarget"]).SW_TargetChat;
	if sTarget == "WHISPER" or sTarget == "CHANNEL" then
		if sVar == nil or sVar == "" then return; end
		if sTarget == "CHANNEL" then
			sVar = GetChannelName(sVar);
		end
		SendChatMessage(outStr, sTarget, nil, sVar);
	elseif sTarget == "CLIP" then
		local outWin = getglobal("SW_TextWindow");
		if outWin.txtBuffer == nil then
			outWin.txtBuffer = "";
		end
		outWin.txtBuffer = outWin.txtBuffer.."\r\n"..outStr;
	else
		SendChatMessage(outStr, sTarget);
	end
end


function SW_BuildTextReportData(caller)
	local bSet = SW_GetBarSettings(caller);
	local tw = SW_TextWindow;
	tw.repMeta = {};
	tw.repData = {};
	
	local outData = tw.repData;
	local metaData = tw.repMeta;
	
	if not bSet.IN then bSet.IN = 1; end

	local inf = SW_InfoTypes[bSet.IN];
	local unitID = inf.f(inf, bSet);
	
	local data = SW_ViewBuffer.data;
	local oneEntry = data[1];
	
	if not oneEntry or oneEntry.sortOrder == 100 or oneEntry.val == 0 then 
		-- nothing to display
		return false; 
	end
	
	
	metaData.InfoTypeString = inf.t;
	metaData.InfoTypeNum = bSet.IN;
	
	if bSet.SF then
		metaData.SelectedFilter = getglobal(bSet.SF).SW_Filter;
	else
		metaData.SelectedFilter = SW_Filter_None.SW_Filter;
	end
	
	local classF;
	if bSet.CF then
		classF = SW_ClassFilters[ bSet.CF ];
	else
		classF = SW_ClassFilters[1];
	end
	
	metaData.ClassFilter = classF;
	
	metaData.ClassFilterLocalized = SW_ClassNames[classF];
	if metaData.ClassFilterLocalized == "" then 
		metaData.ClassFilterLocalized = classF;
	end
	
	
	if bSet.ShowPercent then
		metaData.ShowPercent = true;
	else
		metaData.ShowPercent = false;
	end
	if bSet.ShowRank then
		metaData.ShowRank = true;
	else
		metaData.ShowRank = false;
	end
	if bSet.ShowNumber then
		metaData.ShowNumber = true;
	else
		metaData.ShowNumber = false;
	end
	if SW_DataCollection.settings.activeOnly then
		metaData.ActiveOnly = true;
	else
		metaData.ActiveOnly = false;
	end
	metaData.ReportAmount = SW_Settings.ReportAmount;
	
	local datan = table.getn(data);
	
	for i=1, SW_Settings.ReportAmount do
		oneEntry = data[i];
		if not oneEntry or i > datan or oneEntry.sortOrder == 100 or oneEntry.val == 0 then 
			break;
		else
			-- mask old behaviour
			table.insert(outData, {oneEntry.txt, oneEntry.val, oneEntry.color, oneEntry.sortOrder
				, math.floor((oneEntry.val/SW_ViewBuffer.sums[oneEntry.sortOrder]) *1000 + 0.5)/10 } );
		end
	end
	return true;
end


function SW_SendReport(caller, sVar)
	if SW_Settings.RepTarget == nil then return; end
	
	if getglobal(SW_Settings.RepTarget).SW_TargetChat == "CLIP" then 
		if SW_BuildTextReportData(caller) then
			SW_TextWindow:Show();
		end
		return;
	end
	if not SW_PostCheck(getglobal(SW_Settings.RepTarget).SW_TargetChat) then
		StaticPopup_Show("SW_PostFail");
		return;
	end
	
	local useMultiLines = false
	if SW_Settings["RE_Multiline"] ~= nil then
		useMultiLines = true;
	end

	local bSet = SW_GetBarSettings("SW_BarFrame1");
	if not bSet.IN then bSet.IN = 1; end

	local inf = SW_InfoTypes[bSet.IN];
	local unitID = inf.f(inf, bSet);
	
	local data = SW_ViewBuffer.data;
	local oneEntry = data[1];
	
	if not oneEntry or oneEntry.sortOrder == 100 or oneEntry.val == 0 then 
		-- nothing to display
		return; 
	end
	
	local outStr=" -------- "..inf.t.." ";
	if inf.varType == "TEXT" or inf.varType == "TEXTTARGET" or inf.varType == "TARGETTEXT" then
		outStr = outStr..":: "..bSet.TV.." ";
	end
	
	if bSet.CF and bSet.CF > 1 then
		outStr = outStr..SW_ClassNames[ SW_ClassFilters[ bSet.CF ] ].." ";
	end
	if SW_DataCollection.settings.activeOnly then
		outStr = outStr..string.format(SW_REP_ACTIVE_SEGMENT, YES);
	else
		outStr = outStr..string.format(SW_REP_ACTIVE_SEGMENT, NO);
	end
	
	
	local tmpLen =string.len(outStr);
	local tmpStr ="";
	
	if useMultiLines then
		SW_SendRepLine(outStr, sVar);
		outStr = "";
	end
	
	local datan = table.getn(data);
	for i=1, SW_Settings.ReportAmount do
		oneEntry = data[i];
		if not oneEntry or i > datan or oneEntry.sortOrder == 100 or oneEntry.val == 0 then 
			break;
		else
			if i < 10 then
				tmpStr = "  #0"..i..":  ";
			else
				tmpStr = "  #"..i..":  ";
			end

			tmpStr = tmpStr..oneEntry.txt;
			
			if bSet.ShowNumber then
				tmpStr = tmpStr.."  -  "..oneEntry.val;
			end
			if bSet.ShowPercent then
				tmpStr = tmpStr.."  -  ".." ("..(math.floor((oneEntry.val/SW_ViewBuffer.sums[oneEntry.sortOrder]) *1000 + 0.5)/10).."%)";
			end
		end
		if useMultiLines then
			SW_SendRepLine(tmpStr, sVar);
		else
			tmpLen = tmpLen + string.len(tmpStr);
			if tmpLen < 256 then
				outStr = outStr..tmpStr;
			else
				break;
			end
		end
	end
	
	if not useMultiLines then
		SW_SendRepLine(outStr, sVar);
	end
	
end
function SW_SchoolDropDown_Initialize()
	UIDropDownMenu_AddButton(
			{	text = SW_Schools:getStr(200);
				func = SW_SchoolDropDown_OnClick,
				arg1 = 200, -- school id
			}
		);
	for i=0,6 do
		UIDropDownMenu_AddButton(
			{	text = SW_Schools:getStr(i);
				func = SW_SchoolDropDown_OnClick,
				arg1 = i, -- school id
			}
		);
	end
	
	SW_SchoolDropDown.SWInited = true;
end
function SW_SchoolDropDown_OnClick(cf)
	if cf == 200 then
		UIDropDownMenu_SetSelectedID(SW_SchoolDropDown, 1);
	else
		UIDropDownMenu_SetSelectedID(SW_SchoolDropDown, cf + 2);
	end
	local barSettings = SW_GetBarSettings(SW_SchoolDropDown.SWCaller);
	barSettings.selSchool = cf;
	
	--SW_ClassFilterDropDown:SetText(cString);
	UIDropDownMenu_SetText(SW_Schools:getStr(cf), SW_SchoolDropDown);
	SW_UpdateBars();
end
function SW_ClassFilterDropDown_Initialize()
	local cString;
	for i, cE in ipairs(SW_ClassFilters) do
		if i == 1 then
			cString = NONE;
		else
			if SW_ClassNames[cE] == "" then
				cString = cE;
			else
				cString = SW_ClassNames[cE];
			end
		end
		
			UIDropDownMenu_AddButton(
				{	text = cString, 
					func = SW_ClassFilterDropDown_OnClick,
					arg1 = i, -- classFilter
				}
			);
		
	end
	SW_ClassFilterDropDown.SWInited = true;
	UIDropDownMenu_SetWidth(205, SW_ClassFilterDropDown);
end
function SW_ClassFilterDropDown_OnClick(cf)
	local cString;
	
	UIDropDownMenu_SetSelectedID(SW_ClassFilterDropDown, cf);
	local barSettings = SW_GetBarSettings(SW_ClassFilterDropDown:GetParent():GetParent().caller);
	barSettings.CF = cf;
	if cf == 1 then
		cString = NONE;
	else
		if SW_ClassNames[ SW_ClassFilters[cf] ] == "" then
			cString = SW_ClassFilters[cf];
		else
			cString = SW_ClassNames[ SW_ClassFilters[cf] ];
		end
	end
	--SW_ClassFilterDropDown:SetText(cString);
	UIDropDownMenu_SetText(cString, SW_ClassFilterDropDown);
	SW_UpdateBars();
end
function SW_InfoTypeDropDown_Initialize()
    for i, o in ipairs(SW_InfoTypes) do
		if o.t then
			UIDropDownMenu_AddButton(
				{	text = o.t, 
					tooltipTitle = o.t,
					tooltipText = o.d,
					func = SW_InfoTypeDropDown_OnClick,
					arg1 = i, -- infoNumber
				}
			);
		end
	end
	SW_InfoTypeDropDown.SWInited = true;
	UIDropDownMenu_SetWidth(205, SW_InfoTypeDropDown);
end

function SW_InfoTypeDropDown_OnClick(infoNumber)
	local type = SW_InfoTypes[infoNumber];
	local bs = SW_GetBarSettings(SW_InfoTypeDropDown.SWCaller);
	bs.IN = infoNumber;
	SW_InfoLbl:SetText(type.d);
	UIDropDownMenu_SetSelectedID(SW_InfoTypeDropDown, infoNumber);
	
	
	local oP = SW_InfoTypeDropDown:GetParent();
    if type["varType"] == nil then
		getglobal(oP:GetName().."_VarText"):Hide();
		getglobal(oP:GetName().."_Filters"):Show();
	else
		getglobal(oP:GetName().."_Filters"):Hide();
		if type["varType"] == "TEXT" or type["varType"] == "TEXTTARGET" or type["varType"] == "TARGETTEXT" then
			getglobal(oP:GetName().."_Filters"):Hide();
			getglobal(oP:GetName().."_VarText"):Show();
		elseif type["varType"] == "SELF" then
			getglobal(oP:GetName().."_Filters"):Hide();
			getglobal(oP:GetName().."_VarText"):Hide();
		elseif type["varType"] == "NONE" then
			getglobal(oP:GetName().."_Filters"):Hide();
			getglobal(oP:GetName().."_VarText"):Hide();
		elseif type["varType"] == "PETONLY" then
			getglobal(oP:GetName().."_Filters"):Hide();
			getglobal(oP:GetName().."_VarText"):Hide();
		end
	end
	if type.isHeal then
		getglobal(oP:GetName().."_HealChecks"):Show();
	else
		getglobal(oP:GetName().."_HealChecks"):Hide();
	end
	if type.hasSchoolDD then
		SW_SchoolDropDown:Show();
		if bs.selSchool then
			SW_SchoolDropDown_OnClick(bs.selSchool);
		else
			SW_SchoolDropDown_OnClick(0);
		end
	else
		SW_SchoolDropDown:Hide();
	end
	--SW_InfoTypeDropDown:SetText(type.t);
	UIDropDownMenu_SetText(type.t, SW_InfoTypeDropDown);
	--SW_UpdateColor(oP.caller);
	SW_UpdateBars();
end
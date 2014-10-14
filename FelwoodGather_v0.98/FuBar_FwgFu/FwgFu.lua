local dewdrop = DewdropLib:GetInstance('1.0')
local tablet = TabletLib:GetInstance('1.0')
local metro = Metrognome:GetInstance('1')

FwgFu = FuBarPlugin:GetInstance("1.2"):new({
	name          = FwgFuLocals.NAME,
	description   = FwgFuLocals.DESCRIPTION,
	version       = FwgFuLocals.VERSION,
	aceCompatible = 103,
	author        = "nor3",
	email         = "",
	website       = "",
	category      = "map",
	db            = AceDatabase:new("FwgFuDB"),
	defaults      = {
		showTimer = true,
		showSubzone = true,
		showCoords = false,
	},
	cmd           = AceChatCmd:new(FwgFuLocals.COMMANDS, FwgFuLocals.CMD_OPTIONS),
	loc           = FwgFuLocals,
	hasIcon       = FwgFuLocals.ICON_TEXTURE,
	cannotDetachTooltip = TRUE,
})
	-- Methods
function FwgFu:IsShowTimer()
	return self.data.showTimer
end

function FwgFu:ToggleshowTimer(loud)
	self.data.showTimer = not self.data.showTimer
	if loud then
		self.cmd:status(self.loc.ARGUMENT_TIMER, self.data.showTimer and 1 or 0, FuBarLocals.MAP_ONOFF)
	end
	self:Update()
	return self.data.showTimer
end

function FwgFu:IsShowSubzone()
	return self.data.showSubzone
end

function FwgFu:ToggleShowSubzone(loud)
	self.data.showSubzone = not self.data.showSubzone
	if loud then
		self.cmd:status(self.loc.ARGUMENT_SUBZONE, self.data.showSubzone and 1 or 0, FuBarLocals.MAP_ONOFF)
	end
	self:Update()
	return self.data.showSubzone
end

function FwgFu:IsShowCoords()
	return self.data.showCoords
end

function FwgFu:ToggleShowCoords(loud)
	self.data.showCoords = not self.data.showCoords
	if loud then
		self.cmd:status(self.loc.ARGUMENT_COORDS, self.data.showCoords and 1 or 0, FuBarLocals.MAP_ONOFF)
	end
	self:Update()
	return self.data.showCoords
end

function FwgFu:Announce()
	Objs = FelwoodGather_GetLatestObject();
	if ( (Objs ~= nil) and (Objs.timer ~= 0) ) then
		local eta = (Objs.timer + 1500) - GetTime();
		FelwoodGather_NotifyEstimate(Objs, eta, true);
	end
	dewdrop:Close();
end

function FwgFu:ShareTimer() 
	FelwoodGather_ShareTimer();
	dewdrop:Close();
end

function FwgFu:ToggleConfig()
	FelwoodGather_ToggleConfigWindow();
	dewdrop:Close();
end

function FwgFu:ToggleMinimap()
	FelwoodGatherMap_ToggleMapWindow();
	dewdrop:Close();
end

function FwgFu:Count()
	FelwoodGather_PickupCountDown(true);
	dewdrop:Close();
end

function FwgFu:Enable()
	metro:Register(self.name, self.OnUpdate, 1, self)
	metro:Start(self.name)
end

function FwgFu:Disable()
	metro:Unregister(self.name)
end

function FwgFu:OnUpdate(difference)
	self:Update();
end

function FwgFu:MenuSettings(level, value)
	if level == 1 then
		dewdrop:AddLine(
			'text', self.loc.MENU_ANNOUNCE,
			'arg1', self,
			'func', "Announce"
		)

		dewdrop:AddLine(
			'text', self.loc.MENU_SHARE,
			'arg1', self,
			'func', "ShareTimer"
		)
		dewdrop:AddLine(
			'text', self.loc.MENU_COUNT,
			'arg1', self,
			'func', "Count"
		)
		
		dewdrop:AddLine()

		dewdrop:AddLine(
			'text', self.loc.MENU_SHOW_TIMER,
			'arg1', self,
			'func', "ToggleshowTimer",
			'checked', self:IsShowTimer()
		)
		
		dewdrop:AddLine(
			'text', self.loc.MENU_SHOW_SUBZONE,
			'arg1', self,
			'func', "ToggleShowSubzone",
			'checked', self:IsShowSubzone()
		)

		dewdrop:AddLine(
			'text', self.loc.MENU_SHOW_COORDS,
			'arg1', self,
			'func', "ToggleShowCoords",
			'checked', self:IsShowCoords()
		)

		dewdrop:AddLine()

		dewdrop:AddLine(
			'text', self.loc.MENU_MINIMAP,
			'arg1', self,
			'func', "ToggleMinimap"
		)
		dewdrop:AddLine(
			'text', self.loc.MENU_CONFIG,
			'arg1', self,
			'func', "ToggleConfig"
		)

	end
end

function FwgFu:UpdateText()
	local etatext;
	local text = "";
	Obj = FelwoodGather_GetLatestObject();
	if (Obj ~= nil ) then
		self:SetIcon(Obj.texture);

		eta = (Obj.timer + 1500 ) - GetTime();
		d, h, m, s = ChatFrame_TimeBreakDown(eta);
		etatext = format("%02d:%02d ", m, s);
	else
		etatext = FwgFuLocals.NO_TIMER;
	end;
	if( self:IsShowTimer() ) then 
		text = text .. etatext;
	end

	if ( (Obj ~= nil) and self:IsShowSubzone() ) then
		text = text .. Obj.location;
	end
	if ( (Obj ~= nil) and self:IsShowCoords() ) then
		text = text .. format("(%d, %d)", Obj.x, Obj.y);
	end

	local color;
	if ( Obj ~= nil ) then
		if (Obj.status == 2 ) then
			color = "ffff0000";
		elseif (Obj.status == 1 ) then
			color = "ffffff00";
		else
			color = "ff00ff00";
		end
	else 
			color = "ffffffff";
	end
	self:SetText(format("|c%s%s|r", color, text));
	end

function FwgFu:TipsLine(Objs, eta)
	local Tip = {};
	Tip.eta = eta;
	d, h, m, s = ChatFrame_TimeBreakDown(eta);
	if (Objs.status == 2 ) then
		color = "|cffff0000";
	elseif (Objs.status == 1 ) then
		color = "|cffffff00";
	else
		color = "|cff00ff00";
	end
	Tip.text = string.format("%s%s - %s(%d, %d)|r", color, Objs.item, Objs.location, Objs.x, Objs.y)
	Tip.time = string.format("%s%02d:%02d|r",color, m, s);
	return Tip;
end

function sortFunc(a,b)
	return a.eta < b.eta;
end

function FwgFu:UpdateTooltip()
	local text = "";
	Obj = FelwoodGather_GetLatestObject();
	local Tips = {};
	curTime = GetTime();
	for n, Objs in FelwoodGather_WorldObjs do
		if ((Objs.timer ~= 0) and (Objs.timer + 1500 > curTime )) then
			eta = Objs.timer + 1500 - curTime;
			local Tip = self:TipsLine(Objs, eta);
			table.insert(Tips, Tip);
		end
	end

	local cat = tablet:AddCategory(
		'columns', 2,
		'child_textR', 1,
		'child_textG', 1,
		'child_textB', 0,
		'child_text2R', 1,
		'child_text2G', 1,
		'child_text2B', 1
	)
	
	if(table.getn(Tips)> 0) then
		table.sort(Tips, sortFunc);

		for n, tip in Tips do
			cat:AddLine(
				'text', tip.time,
				'text2', tip.text
			)
		end
	else
	end
end

function FwgFu:OnClick()
	if IsShiftKeyDown() then
		if ChatFrameEditBox:IsVisible() then
			Objs = FelwoodGather_GetLatestObject();
			if ( Objs ~= nil ) then
				local eta = (Objs.timer + 1500) - GetTime();
				local d, h, m, s = ChatFrame_TimeBreakDown(eta);
				local message = format(TFWG_NOTIFY_MESSAGE, Objs.item, m, s, Objs.location);
				ChatFrameEditBox:Insert(message);
			end
		end
	end
end

FwgFu:RegisterForLoad()

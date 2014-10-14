AceBidHelper = AceAddon:new({
        name          = AceBidHelperLocals.NAME,
        description   = AceBidHelperLocals.DESCRIPTION,
        version       = "0.2",
        releaseDate   = "04-17-2006",
        aceCompatible = "103",
        author        = "hshh",
        email         = "hunreal@gmail.com",
        website       = "http://www.hshh.org",
        category      = "others",
        db            = AceDatabase:new("AceBidHelperDB"),
        cmd           = AceChatCmd:new(AceBidHelperLocals.COMMANDS, AceBidHelperLocals.CMD_OPTIONS),
		keepRecords   = 60*60*12,
		registerEvent = "CHAT_MSG_SYSTEM",
		pos           = 10,
})


function AceBidHelper:Initialize()
	local curtime = GetTime();
	local success=self.db:get({"records"}, "success");
	if (success) then
		for k, v in success do
			if (curtime > tonumber(k) + self.keepRecords) then
				self.db:set({"records", "success"}, k, nil);
			end
		end
	end
	local failed=self.db:get({"records"}, "failed");
	if (failed) then
		for k, v in failed do
			if (curtime > tonumber(k) + self.keepRecords) then
				self.db:set({"records", "failed"}, k, nil);
			end
		end
	end
end

function AceBidHelper:Enable()
	self:RegisterEvent(self.registerEvent, "TrackMSG");
	self.SUCCESSFUL_MESSAGES=self:ReFormatMSG(AceBidHelperLocals.SUCCESSFUL_MESSAGES);
	self.FAILED_MESSAGES=self:ReFormatMSG(AceBidHelperLocals.FAILED_MESSAGES);
	self:MinimapLoc(self.db:get("pos"));
end

function AceBidHelper:Disable()
	self:UnregisterEvent(self.registerEvent);
end

function AceBidHelper:ReFormatMSG(GlobalStrings)
	local validStrings = {};
	local validFormatStrings = {};
	for k, v in GlobalStrings do
		table.insert(validFormatStrings, v);
	end
	for k, v in validFormatStrings do
		str = v;
		index = string.find(str, "%%s");
		if ( index ) then
			str = string.gsub(str, "%%s", "%(%.%+%)");
		end
		validStrings[k] = str;
	end
	return validStrings;
end

function AceBidHelper:TrackMSG()
	local msg = arg1
	for k, v in self.SUCCESSFUL_MESSAGES do
		local _,_,c = string.find(msg, v);
		if c then
			local hour, minute = GetGameTime();
			local datetime = date("*t")
			local logDate = format(TEXT("%02d-%02d %02d:%02d"), datetime.month, datetime.day, hour, minute);
			self.db:set({"records", "success"}, GetTime(), {["name"]=ace.char.name, ["record"]=msg, ["time"]=logDate});
			return "success";
		end
	end
	for k, v in self.FAILED_MESSAGES do
		local _,_,c = string.find(msg, v);
		if c then
			local hour, minute = GetGameTime();
			local datetime = date("*t")
			local logDate = format(TEXT("%02d-%02d %02d:%02d"), datetime.month, datetime.day, hour, minute);
			self.db:set({"records", "failed"}, GetTime(), {["name"]=ace.char.name, ["record"]=msg, ["time"]=logDate});
			return "failed";
		end
	end
end

function AceBidHelper:ListAll()
	self:ListSuccessful();
	self:ListFailed();
end

function AceBidHelper:ListSuccessful()
	local success=self.db:get({"records"}, "success");
	if (success) then
		self.cmd:msg(AceBidHelperLocals.TEXT.successful_records)
		for k, v in success do
			self.cmd:msg("["..v.time.."]"..v.name..": "..v.record)
		end
	end
end

function AceBidHelper:ListFailed()
	local failed=self.db:get({"records"}, "failed");
	if (failed) then
		self.cmd:msg(AceBidHelperLocals.TEXT.failed_records)
		for k, v in failed do
			self.cmd:msg("["..v.time.."]"..v.name..": "..v.record)
		end
	end
end

function AceBidHelper:MinimapButton_OnEnter()
	GameTooltip:SetOwner(this, "ANCHOR_LEFT");
	GameTooltip:SetText(self.name);
	local success=self.db:get({"records"}, "success");
	if (success) then
		for k, v in success do
			GameTooltip:AddLine(TEXT(v.time.." "..v.record));
		end
	end
	local failed=self.db:get({"records"}, "failed");
	if (failed) then
		for k, v in failed do
			GameTooltip:AddLine(TEXT(v.time.." "..v.record));
		end
	end
	GameTooltip:Show();
end

function AceBidHelper:MinimapButton_OnLeave()
	if ( GameTooltip:IsOwned(this) ) then
		GameTooltip:Hide();
	end
end

function AceBidHelper:MinimapLoc(pos)
	pos = tonumber(pos);
	if (not pos or pos > 360 or pos < 0) then
		pos = self.pos;
	end
	AceBidHelperMinimapButton:SetPoint(
		"TOPLEFT",
		"Minimap",
		"TOPLEFT",
		54 - (78 * cos(pos)),
		(78 * sin(pos)) - 55
	);
	self.db:set("pos", pos);
end

function AceBidHelper:Reset()
	self:MinimapLoc(nil);
	self.db:set("records", nil);
end

AceBidHelper:RegisterForLoad()

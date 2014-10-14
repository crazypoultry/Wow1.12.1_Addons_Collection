
BFC_Waypoints = {};


function BFC_Waypoints.Init()
	BFC_Comms.RegisterMessage("WAYPOINT", "SHOW", BFC_Waypoints.PlaceIcon);
	BFC_Comms.RegisterMessage("WAYPOINT", "HIDE", BFC_Waypoints.HideIcon);
end


function BFC_Waypoints.HideIcon(player, args)
	local id = args[1];
	
	local frame = getglobal("BFC_Waypoints_Icon" .. id);
	frame:ClearAllPoints();
	frame:SetParent("BFC_Waypoints_Frame");
	frame:SetPoint("TOPLEFT", "BFC_Waypoints_Frame", "TOPLEFT", 6, (-16*id)+10);
end


function BFC_Waypoints.Icon_Onload()
	this:SetFrameLevel(this:GetFrameLevel()+3);
	getglobal(this:GetName() .. "Texture"):SetTexture("Interface\\Addons\\BattlefieldCommander2\\images\\waypoint" .. this:GetID());
	this:RegisterForDrag("LeftButton");
	BFC_Waypoints.HideIcon(nil, {this:GetID()});
end


function BFC_Waypoints.Frame_OnLoad()

end


function BFC_Waypoints.OnDragStop()
	local x, y = GetCursorPosition();
	x = BFC_Map.GetFractionalX(x, BFC_Options.get("narrow"));
	y = BFC_Map.GetFractionalY(y);
	id = this:GetID();
	
	this:SetUserPlaced(false);
	
	--BFC.Log(BFC.LOG_DEBUG, "Id " .. id .. " got X " .. x .. ", got y " .. y);
	
	if(x < 0 or x > 1 or y < 0 or y > 1) then
		BFC_Comms.SendMessage("WAYPOINT", "HIDE", id);
		return;
	end
	
	BFC_Comms.SendMessage("WAYPOINT", "SHOW", {id, x, y});
end


function BFC_Waypoints.PlaceIcon(player, args)
	local id = args[1];
	local x = args[2];
	local y = args[3];
	
	local frame = getglobal("BFC_Waypoints_Icon" .. id);
	frame:ClearAllPoints();
	frame:SetParent("BFC_Map_Frame");
	frame:SetPoint("CENTER", "BFC_Map_Frame", "TOPLEFT", BFC_Map.GetScaledX(x, BFC_Options.get("narrow")), -y * BFC_Map_Frame:GetHeight());
end


function BFC_Waypoints.Icon_OnEnter()
	-- TODO: tooltip this
end
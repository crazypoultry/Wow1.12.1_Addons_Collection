-- Title: ImproveDressingRoom v1.5o
-- Author: TotalPackage
-- Date: 11/06/2006

function ImproveAHDressingRoomModel_Load()
	AuctionDressUpModelRotateRightButton:Hide();
	AuctionDressUpModelRotateLeftButton:Hide();
	AuctionDressUpModel:SetHeight(370);
	if oSkin then
		AuctionDressUpModel:SetPoint("BOTTOM", "AuctionDressUpFrame", "BOTTOM", 0, 0);
	else
		AuctionDressUpModel:SetPoint("BOTTOM", "AuctionDressUpFrame", "BOTTOM", 0, 10);
	end
	AuctionDressUpFrameResetButton:SetPoint("BOTTOM", "AuctionDressUpFrame", "BOTTOM", 0, 15);
	AuctionDressUpModel:EnableMouse(true);
	AuctionDressUpModel:EnableMouseWheel(true);
	
	AuctionDressUpModel:SetScript("OnMouseDown", function()
		ImproveDressingRoom_OnMouseDown();
	end)
	AuctionDressUpModel:SetScript("OnMouseUp", function()
		ImproveDressingRoom_OnMouseUp();
	end)
	AuctionDressUpModel:SetScript("OnMouseWheel", function()
		ImproveDressingRoom_OnMouseWheel();
	end)
	AuctionDressUpModel:SetScript("OnUpdate", function()
		ImproveDressingRoom_OnUpdate();
	end)
	
	ImproveDressingRoom_ToggleBackground(true)
end


-- script handlers

function ImproveDressingRoom_OnMouseDown()
	if (arg1 == "LeftButton") then
		this.ismoving = 1;
		this.previousx, this.previousy = GetCursorPosition();
	end
	if (arg1 == "RightButton") then
		this.ispaning = 1;
		this.previousx, this.previousy = GetCursorPosition();
	end
end

function ImproveDressingRoom_OnMouseUp()
	if (arg1 == "LeftButton") then
		this.ismoving = nil;
		if IsControlKeyDown() then
			ImproveDressingRoom_ToggleBackground()
		end
	end
	if (arg1 == "RightButton") then
		this.ispaning = nil;
	end
end

function ImproveDressingRoom_OnMouseWheel()
	local cz, cx, cy = this:GetPosition();
	if ( arg1 > 0 ) then
		this.zoom = cz + 0.75;
	else
		this.zoom = cz - 0.75;
	end
	this:SetPosition(this.zoom, cx, cy);
end

function ImproveDressingRoom_OnUpdate()
	if ( this.ismoving ) then
		local currentx, currenty = GetCursorPosition();
		this.rotation = this:GetFacing() + ((currentx - this.previousx)/50);
		this:SetFacing(this.rotation);
		this.previousx, this.previousy = GetCursorPosition();
	elseif ( this.ispaning ) then
		local currentx, currenty = GetCursorPosition();
		local cz, cx, cy = this:GetPosition();
		this.positionx = cx + ((currentx - this.previousx)/50);
		this.positiony = cy + ((currenty - this.previousy)/50);
		this:SetPosition(cz, this.positionx, this.positiony);
		this.previousx, this.previousy = GetCursorPosition();
	end
end


-- someone wanted the feature to hide the backgrounds
function ImproveDressingRoom_ToggleBackground(init)
	if not init then
		IDR = not IDR
	end
	if IDR then
		DressUpBackgroundTopLeft:Show();
		DressUpBackgroundTopRight:Show();
		DressUpBackgroundBotLeft:Show();
		DressUpBackgroundBotRight:Show();
		if AuctionDressUpBackgroundTop then
			AuctionDressUpBackgroundTop:Show();
			AuctionDressUpBackgroundBot:Show();
		end
	else
		DressUpBackgroundTopLeft:Hide();
		DressUpBackgroundTopRight:Hide();
		DressUpBackgroundBotLeft:Hide();
		DressUpBackgroundBotRight:Hide();
		if AuctionDressUpBackgroundTop then
			AuctionDressUpBackgroundTop:Hide();
			AuctionDressUpBackgroundBot:Hide();
		end
	end
end

-- Mod the main dressup frame w/o XML!
DressUpModelRotateRightButton:Hide();
DressUpModelRotateLeftButton:Hide();
DressUpModel:SetHeight(332);
DressUpModel:SetPoint("BOTTOM", "DressUpFrame", "BOTTOM", -11, 104);
DressUpModel:EnableMouse(true);
DressUpModel:EnableMouseWheel(true);

-- I love the new SetScript funcs
DressUpFrame:SetScript("OnShow", function()
	SetPortraitTexture(DressUpFramePortrait, "player");
	PlaySound("igCharacterInfoOpen");
	ImproveDressingRoom_ToggleBackground(true);
end)
DressUpModel:SetScript("OnMouseDown", function()
	ImproveDressingRoom_OnMouseDown();
end)
DressUpModel:SetScript("OnMouseUp", function()
	ImproveDressingRoom_OnMouseUp();
end)
DressUpModel:SetScript("OnMouseWheel", function()
	ImproveDressingRoom_OnMouseWheel();
end)
DressUpModel:SetScript("OnUpdate", function()
	ImproveDressingRoom_OnUpdate();
end)

if oSkin then
	oSkin:Hook(oSkin, "makeMFRotatable", function(object, frame)
		if frame ~= DressUpModel and frame ~= AuctionDressUpModel then
			oSkin.hooks[object].makeMFRotatable(object, frame)
		end
	end)
	oSkin:Hook(oSkin, "moveObject", function(object, objName, xAdj, xDiff, yAdj, yDiff, relTo)
		if objName == DressUpModel then
			oSkin.hooks[object].moveObject(object, objName, "+", 11, "-", 70, relTo)
		else
			oSkin.hooks[object].moveObject(object, objName, xAdj, xDiff, yAdj, yDiff, relTo)
		end
	end)
end

-- Auction UI is LoadOnDemand, so need to do some extra work
if not AuctionDressUpModel then
	local f = CreateFrame("Frame", "ImproveDressingRoomEventFrame")
	f:RegisterEvent("ADDON_LOADED")
	f:SetScript("OnEvent", function()
		if arg1 == "Blizzard_AuctionUI" then
			this:UnregisterEvent("ADDON_LOADED");
			ImproveAHDressingRoomModel_Load()
		end
	end)
else
	ImproveAHDressingRoomModel_Load()
end

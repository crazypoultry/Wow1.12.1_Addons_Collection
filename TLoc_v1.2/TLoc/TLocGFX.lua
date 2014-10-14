TLocGFX_PATH = "Interface\\AddOns\\TLoc"
TLoc_GFX_IMAGE_FOLDER = "IMAGE"

function TLocGFX_OnLoad()
	this:RegisterForDrag("LeftButton")
	TLocGFXFrame:Hide()
	TLocGFX_SetTexture()
end

function TLocGFX_SetTexture()
	local texturePath
	if (not tdir) then
		texturePath = 0
	else
		texturePath = tdir/15 + 1
		if (texturePath - math.floor(texturePath) < 0.5) then
			texturePath = math.floor(texturePath)
		else
			texturePath = math.ceil(texturePath)
		end
		if (texturePath > 24) then
			texturePath = 1
		end
	end
	if (texturePath) then
		local texture = string.format("%s\\%s\\%s",
		TLocGFX_PATH, TLoc_GFX_IMAGE_FOLDER, texturePath)
		TLocGFXImage:SetTexture(texture)				
	end
end

function TLocGFX_OnDragStart()
	TLocGFXFrame:StartMoving()
end

function TLocGFX_OnDragStop()
	TLocGFXFrame:StopMovingOrSizing()
end
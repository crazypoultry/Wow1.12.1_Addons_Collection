--[[

	Atlas, a World of Warcraft instance map browser
	Copyright 2005, 2006 Dan Gilbert
	Email me at loglow@gmail.com

	This file is part of Atlas.

	Atlas is free software; you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation; either version 2 of the License, or
	(at your option) any later version.

	Atlas is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with Atlas; if not, write to the Free Software
	Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

--]]

function AtlasOptions_Toggle()
	if(AtlasOptionsFrame:IsVisible()) then
		AtlasOptionsFrame:Hide();
	else
		AtlasOptionsFrame:Show();
	end
end

function AtlasOptions_AutoSelectToggle()
	if(AtlasOptions.AtlasAutoSelect) then
		AtlasOptions.AtlasAutoSelect = false;
	else
		AtlasOptions.AtlasAutoSelect = true;
	end
	AtlasOptions_Init();
end

function AtlasOptions_ReplaceWorldMapToggle()
	if(AtlasOptions.AtlasReplaceWorldMap) then
		AtlasOptions.AtlasReplaceWorldMap = false;
	else
		AtlasOptions.AtlasReplaceWorldMap = true;
	end
	AtlasOptions_Init();
end

function AtlasOptions_RightClickToggle()
	if(AtlasOptions.AtlasRightClick) then
		AtlasOptions.AtlasRightClick = false;
	else
		AtlasOptions.AtlasRightClick = true;
	end
	AtlasOptions_Init();
end

function AtlasOptions_MapNameToggle()
	if(AtlasOptions.AtlasMapName) then
		AtlasOptions.AtlasMapName = false;
	else
		AtlasOptions.AtlasMapName = true;
	end
end

function AtlasOptions_AcronymsToggle()
	if(AtlasOptions.AtlasAcronyms) then
		AtlasOptions.AtlasAcronyms = false;
	else
		AtlasOptions.AtlasAcronyms = true;
	end
	AtlasOptions_Init();
	Atlas_Refresh();
end

function AtlasOptions_ClampedToggle()
	if(AtlasOptions.AtlasClamped) then
		AtlasOptions.AtlasClamped = false;
	else
		AtlasOptions.AtlasClamped = true;
	end
	AtlasFrame:SetClampedToScreen(AtlasOptions.AtlasClamped);
	AtlasOptions_Init();
	Atlas_Refresh();
end

function AtlasOptions_OnLoad()
	UIPanelWindows['AtlasOptionsFrame'] = {area = 'center', pushable = 0};
end

function AtlasOptions_Init()
	AtlasOptionsFrameToggleButton:SetChecked(AtlasOptions.AtlasButtonShown);
	AtlasOptionsFrameAutoSelect:SetChecked(AtlasOptions.AtlasAutoSelect);
	AtlasOptionsFrameReplaceWorldMap:SetChecked(AtlasOptions.AtlasReplaceWorldMap);
	AtlasOptionsFrameRightClick:SetChecked(AtlasOptions.AtlasRightClick);
	AtlasOptionsFrameAcronyms:SetChecked(AtlasOptions.AtlasAcronyms);
	AtlasOptionsFrameClamped:SetChecked(AtlasOptions.AtlasClamped);
	AtlasOptionsFrameSliderButtonPos:SetValue(AtlasOptions.AtlasButtonPosition);
	AtlasOptionsFrameSliderButtonRad:SetValue(AtlasOptions.AtlasButtonRadius);
	AtlasOptionsFrameSliderAlpha:SetValue(AtlasOptions.AtlasAlpha);
	AtlasOptionsFrameSliderScale:SetValue(AtlasOptions.AtlasScale);
end

function AtlasOptions_ResetPosition()
	AtlasFrame:SetPoint("TOPLEFT", 0, -104);
end

function AtlasOptions_SetupSlider(text, mymin, mymax, step)
	getglobal(this:GetName().."Text"):SetText(text);
	this:SetMinMaxValues(mymin, mymax);
	getglobal(this:GetName().."Low"):SetText(mymin);
	getglobal(this:GetName().."High"):SetText(mymax);
	this:SetValueStep(step);
end

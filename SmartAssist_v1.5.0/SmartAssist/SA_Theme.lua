--[[---------------------------------------------------------------------------

  All code related to Target List appearance / theme system

---------------------------------------------------------------------------]]--

function SA_Theme_ChangeTheme(name)
	SA_OPTIONS["Theme"] = name
	SA_List_ApplyDefaults()
	SA_List_ApplyTheme()
end

function SA_List_ApplyDefaults()
	-- apply defaults, without no theme
	SA_OPTIONS.ListSpacing = 0
	SA_OPTIONS.ClassIconMode = 1
	SA_OPTIONS.TargetIconMode = 1
	SA_OPTIONS.HuntersMarkIconMode = 1
	SA_OPTIONS.ListScale = 1
	SA_OPTIONS.ListWidth = 150
	
	local theme = SA_THEME[SA_OPTIONS.Theme]
	if (not theme.defaults) then return end
	
	-- apply default list spacing
	if (theme.defaults.spacing) then
		SA_OPTIONS.ListSpacing = theme.defaults.spacing
	end
	
	if (theme.defaults.widthSlider) then
		SA_OPTIONS.ListWidth=theme.defaults.widthSlider.value
	end
	
	if (theme.defaults.scaling) then
		SA_OPTIONS.ListScale = theme.defaults.scaling
	end
	
	-- apply default locations if specified in theme
	if (theme.defaults.icons) then
		if (theme.defaults.icons.mobClass) then
			SA_OPTIONS.ClassIconMode = theme.defaults.icons.mobClass
		end
		if (theme.defaults.icons.raidTarget) then
			SA_OPTIONS.TargetIconMode = theme.defaults.icons.raidTarget
		end
		if (theme.defaults.icons.huntersMark) then
			SA_OPTIONS.HuntersMarkIconMode = theme.defaults.icons.huntersMark
		end
	end
end

function SA_List_GetFrameGap()
	local gap = 0
	local theme = SA_THEME[SA_OPTIONS.Theme]
	local function maxgap(i)
		if (not theme.icons.positions[i].gap) then return end
		if (theme.icons.positions[i].gap > gap) then
			gap = theme.icons.positions[i].gap
		end
	end
	maxgap(SA_OPTIONS.ClassIconMode)
	maxgap(SA_OPTIONS.TargetIconMode)
	maxgap(SA_OPTIONS.HuntersMarkIconMode)
	return gap
end

function SA_List_UpdateAppearance()
	-- 7.10.2006 : refactored and removed hard coded constants. Only -1 remains which is neccessary to allow zero spacing when list is grown upwards.
	local width = SA_OPTIONS.ListWidth
	local theme = SA_THEME[SA_OPTIONS.Theme]
	
	local x,y = 0,0
	if (SA_OPTIONS.ListHorizontal) then
		-- horizontal
		local gap = SA_List_GetFrameGap()
		if (SA_OPTIONS.ListSpacing > 0) then
			x = width + gap + SA_OPTIONS.ListSpacing-1 -- -1 to allow zero padding on negative side
		else
			x = - (width + gap - SA_OPTIONS.ListSpacing)
		end
	else
		-- vertical
		local height = ceil(Target1:GetHeight())
		if (SA_OPTIONS.ListSpacing > 0) then
			y = height + SA_OPTIONS.ListSpacing-1 -- -1 to allow zero padding on negative side
		else
			y = - (height-SA_OPTIONS.ListSpacing)
		end
	end
	
	SAListFrame:SetWidth(width)
	SAListTitleButton:SetWidth(width)
	
	local anchor = "TOPLEFT"
	for i,tf in pairs(SA_TARGET_FRAMES) do
		tf.frame:ClearAllPoints()
		if (i==1) then
			-- first frame is ancored to title
			if (y<=0) then
				tf.frame:SetPoint("TOPLEFT", "SAListTitleButton", "BOTTOMLEFT", 0, -theme.title.gap)
			else
				tf.frame:SetPoint("BOTTOMLEFT", "SAListTitleButton", "TOPLEFT", 0, theme.title.gap)
			end
		elseif (i==6 and SA_OPTIONS.ListTwoRow) then
			-- two rows
			if (SA_OPTIONS.ListHorizontal) then
				local gap = SA_OPTIONS.ListSpacing
				if (gap>0) then
					gap = -gap+1 -- +1 to allow zero padding on negative side
				end
				tf.frame:SetPoint(anchor, "Target1", "BOTTOMLEFT", 0, gap)
			else
				local gap = SA_OPTIONS.ListSpacing
				if (gap<0) then
					gap = -gap
				end
				gap = gap + SA_List_GetFrameGap()
				tf.frame:SetPoint(anchor, "Target1", "TOPRIGHT", gap, 0)
			end
		else
			-- rest are anchored to previous frame
			tf.frame:SetPoint(anchor, "Target"..i-1, anchor, x, y)
		end
		
		tf.frame:SetWidth(width)
		
		-- scale inside elements accordingly theme relative width, no scaling if relative width is not present!
		
		if (theme.mobBar.relativeWidth) then
			tf.mobBar:SetWidth(width+theme.mobBar.relativeWidth)
		end
		if (theme.targetBar.relativeWidth) then
			tf.targetBar:SetWidth(width+theme.targetBar.relativeWidth)
		end
		if (theme.mobText.relativeWidth) then
			tf.mobText:SetWidth(width+theme.mobText.relativeWidth)
		end
		if (theme.targetText.relativeWidth) then
			tf.targetText:SetWidth(width+theme.targetText.relativeWidth)
		end
		if (theme.targetOf.relativeWidth) then
			tf.targetOf:SetWidth(width+theme.targetOf.relativeWidth)
		end
		-- update bar backgrounds position and coverage (dynamic so cannot be applied in applytheme)
		local function updateBackground(front, bg, bgtheme)
			if (not bgtheme) then return end
			bg:ClearAllPoints()
			if (not bgtheme.coverage) then
				bgtheme.coverage = 1
			end
			bg:SetWidth(front:GetWidth() * bgtheme.coverage)
			bg:SetHeight(front:GetHeight())
			bg:SetPoint("TOPLEFT", front, "TOPLEFT", 0, 0)
		end
		updateBackground(tf.mobBar, tf.mobBarBg, theme.mobBar.background)
		updateBackground(tf.targetBar, tf.targetBarBg, theme.targetBar.background)
		--[[
		local function updateBackground(front, bg, tf, theme)
			if (not theme.background) then return end
			bg:ClearAllPoints()
			if (not theme.background.coverage) then
				theme.background.coverage = 1
			end
			bg:SetWidth(front:GetWidth() * theme.background.coverage)
			bg:SetHeight(front:GetHeight())
			bg:SetPoint("TOPLEFT", tf, "TOPLEFT", theme.x, theme.y)
		end
		updateBackground(tf.mobBar, tf.mobBarBg, tf.frame, theme.mobBar)
		updateBackground(tf.targetBar, tf.targetBarBg, tf.frame, theme.targetBar)
		--]]
		
		-- set icon positions
		if (SA_OPTIONS.ClassIconMode>1) then
			local icon = theme.icons.positions[SA_OPTIONS.ClassIconMode]
			SA_List_UpdateIconAppearance(tf.classIcon, i, icon)
		else
			tf.classIcon:Hide()
		end
		
		if (SA_OPTIONS.TargetIconMode>1) then
			local icon = theme.icons.positions[SA_OPTIONS.TargetIconMode]
			SA_List_UpdateIconAppearance(tf.targetIcon, i, icon)
		else
			tf.targetIcon:Hide()
		end
		
		if (SA_OPTIONS.HuntersMarkIconMode>1) then
			local icon = theme.icons.positions[SA_OPTIONS.HuntersMarkIconMode]
			SA_List_UpdateIconAppearance(tf.huntersMarkIcon, i, icon)
		else
			tf.huntersMarkIcon:Hide()
		end
		
	end
end

-- helper function, updates icon appearance
function SA_List_UpdateIconAppearance(frame, i, icon)
	frame:ClearAllPoints()
	frame:SetPoint(icon.point, "Target"..i, icon.point, icon.x, icon.y)
	frame:SetWidth(icon.width)
	frame:SetHeight(icon.height)
	frame:Show()
end

function SA_List_ApplyTheme()
	local theme = SA_THEME[SA_OPTIONS.Theme]
	-- apply theme to title button
	SAListTitleButton:SetBackdrop(theme.title.backdrop)
	SA_List_ApplyTitleColors(theme.title.colors.normal)
	-- apply backdrop changes to all targets
	for i,tf in pairs(SA_TARGET_FRAMES) do
		tf.frame:SetBackdrop( theme.backdrop )
		
		SA_List_ApplyFrame(tf.frame, theme.frame)
		
		-- apply default colors to whole target frame
		SA_List_ApplyTargetColors(tf, theme.colors.normal)
		
		-- apply theme to statusbars
		SA_List_ApplyStatusBar(tf.mobBar, tf.mobBarBg, tf.frame, theme.mobBar)
		SA_List_ApplyStatusBar(tf.targetBar, tf.targetBarBg, tf.frame, theme.targetBar)
		
		-- apply theme to fontstrings
		SA_List_ApplyFontString(tf.mobText, tf.frame, theme.mobText)
		SA_List_ApplyFontString(tf.targetText, tf.frame, theme.targetText)
		SA_List_ApplyFontString(tf.targetOf, tf.frame, theme.targetOf)
		
		-- apply texture, if different from current one
		if (theme.myTargetTexture) then
			if (tf.myTargetTexture:GetTexture()~=theme.myTargetTexture) then
				tf.myTargetTexture:SetTexture(theme.myTargetTexture)
			end
		end
		tf.myTargetTexture:Hide()
		
		-- apply default colors
		SA_List_ApplyTargetColors(tf, theme.colors.normal)
	end
	SA_List_UpdateAppearance()
end

-- apply theme to frame
function SA_List_ApplyFrame(frame, theme)
	local height = 55
	if (theme) then
		if (theme.height) then
			height = theme.height
		end
	end
	frame:SetHeight(height)
end

-- applies theme data to statusbar
-- this should be called ONLY when applying theme due heavy performance hit!
function SA_List_ApplyStatusBar(bar, barBg, parent, theme)
	if (theme.hide) then
		bar:Hide()
		barBg:Hide()
		return
	else
		bar:Show()
	end
	bar:ClearAllPoints()
	if (theme.width) then
		bar:SetWidth(theme.width)
	end
	bar:SetHeight(theme.height)
	-- if spark enabled, adjust height to match bar
	if (theme.spark) then
		bar.spark:SetHeight(theme.height+25)
		bar.spark:SetWidth(16)
		bar.spark:SetAlpha(theme.spark.alpha)
	else
		bar.spark:Hide()
	end
	-- helper, apply texture if different from current one
	local function SetBarTexture(frame, texture)
		-- does not have texture initially, check if trying to set to same
		if (frame:GetStatusBarTexture()) then
			if (frame:GetStatusBarTexture():GetTexture()==texture) then
				return
			end
		end
		frame:SetStatusBarTexture(texture)
	end
	
	if (theme.texture) then
		SetBarTexture(bar, theme.texture)
	else
		SetBarTexture(bar, "Interface\\TargetingFrame\\UI-StatusBar")
	end
	bar:SetPoint("TOPLEFT", parent, "TOPLEFT", theme.x, theme.y)
	
	-- set background
	if (theme.background) then
		barBg:Show()
		-- apply texture
		if (theme.background.texture) then
			SetBarTexture(barBg, theme.background.texture)
		else
			SetBarTexture(barBg, "Interface\\TargetingFrame\\UI-StatusBar")
		end
		-- move behind actual bar
		barBg:SetFrameLevel(bar:GetFrameLevel() - 1)
		-- note: update list appearance moves the bar behind the actial front bar
		-- and sets it size to correct!
		if (theme.background.blendMode) then
			barBg:GetStatusBarTexture():SetBlendMode(theme.background.blendMode)
		else
			barBg:GetStatusBarTexture():SetBlendMode("DISABLE")
		end
		if (theme.background.gradient) then
			local gradient = theme.background.gradient
			barBg:GetStatusBarTexture():SetGradientAlpha(
				"HORIZONTAL", 
				gradient.min.r, gradient.min.g, gradient.min.b, gradient.min.alpha,
				gradient.max.r, gradient.max.g, gradient.max.b, gradient.max.alpha
			)
		else
			-- set standard color (clears gradient)
			local c = theme.background.color
			barBg:SetStatusBarColor(c.r, c.g, c.b, c.alpha)
		end
	else
		barBg:Hide()
	end
end

-- this should be called ONLY when applying theme due heavy performance hit!
function SA_List_ApplyFontString(frame, parent, theme)
	if (theme.hide or theme.hidden) then
		frame:Hide()
		return
	else
		frame:Show()
	end
	frame:ClearAllPoints()
	if (theme.width) then
		frame:SetWidth(theme.width)
	end
	frame:SetHeight(theme.height)
	if (not theme.point) then
		theme.point="TOPLEFT"
	end
	if (not theme.relativePoint) then
		theme.relativePoint="TOPLEFT"
	end
	-- font object
	if (theme.gameFont) then
		frame:SetFontObject(getglobal(theme.gameFont))
	elseif (theme.extFont) then
		frame:SetFont(theme.extFont.file, theme.extFont.size, theme.extFont.flags)
	else
		frame:SetFontObject(TextStatusBarText)
	end
	-- color
	if (theme.color) then
		frame:SetTextColor(theme.color.r, theme.color.g, theme.color.b, theme.color.alpha)
	end
	-- alpha
	if (theme.alpha) then
		frame:SetAlpha(theme.alpha)	
	end
	-- shadow
	if (theme.shadow) then
		local c = theme.shadow.color
		frame:SetShadowColor(c.r, c.g, c.b, c.alpha)
		frame:SetShadowOffset(theme.shadow.offset.x, theme.shadow.offset.y)
	else
		frame:SetShadowColor(0,0,0,0)
	end
	-- position & aligment
	frame:SetPoint(theme.point, parent, theme.relativePoint, theme.x, theme.y)
	frame:SetJustifyH(theme.justifyH)
	frame:SetJustifyV(theme.justifyV)
end

--[[---------------------------------------------------------------------------
  applies theme data to whole target frame, should be kept as light as possible!
  tf - target frame wrapper
  theme - color themedata
---------------------------------------------------------------------------]]--
  
function SA_List_ApplyTargetColors(tf, theme)
	if (theme.background) then
		tf.frame:SetBackdropColor(theme.background.r, theme.background.g, theme.background.b, theme.background.alpha)
	end
	if (theme.border) then
		tf.frame:SetBackdropBorderColor(theme.border.r, theme.border.g, theme.border.b, theme.border.alpha)
	end
	if (theme.mobBar) then
		tf.mobBar:SetStatusBarColor(theme.mobBar.r, theme.mobBar.g, theme.mobBar.b)
	end
	if (theme.targetBar) then
		tf.targetBar:SetStatusBarColor(theme.targetBar.r, theme.targetBar.g, theme.targetBar.b)
	end
end

function SA_List_ApplyTitleColors(theme)
	SAListTitleButton:SetBackdropColor(theme.background.r, theme.background.g, theme.background.b, theme.background.alpha)
	SAListTitleButton:SetBackdropBorderColor(theme.border.r, theme.border.g, theme.border.b, theme.border.alpha)
	SAListTitleButton:SetAlpha(theme.alpha)
end

--[[---------------------------------------------------------------------------
  This is used to "sum up" the final theme depending target flags
  ie what is result of normal + marked + non tapped
---------------------------------------------------------------------------]]--

function SA_AddTargetTheme(tc, data)
	for k,v in pairs(data) do
		tc[k] = v
	end
end

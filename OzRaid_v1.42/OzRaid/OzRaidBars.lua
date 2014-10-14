
-------------------------------------------------------------------------
--   PROCESS FUNCTION
--
--   Updaes the bars fromthe roster data, using the specified functions
--
-------------------------------------------------------------------------
function OZ_ProcessBars(n)
--DEFAULT_CHAT_FRAME:AddMessage("|c0033CCFF".."  Process: "..n);
	local i
	local config = OZ_Config[n]			

	-- Step 1, fill bars from input
	getglobal( OZ_InputFunctions[config.input].pFunction ) (n)

	-- Step 2, apply filtering
	OZ_FilterBars(n);
	if(OZ_Input.nBars > 40)then
		OZ_Input.nBars = 40
	end

	-- Now get buffs/debuffs for inputs
	OZ_ShowPlayerBuffs(n)

	if( OZ_Input.nBars > 0)then
		-- Step 3: Sort
		OZ_InitSortTable(OZ_Input.nBars)
		local scale = nil
		if(config.sort1 > 0) then
			getglobal( OZ_SortFunctions[config.sort1].pFunction ) (n)
			scale = 100
		end
		if(config.sort2 > 0) then
			if(scale)then
				-- We have already done one sort.
				-- IF this sort is either 'bar length' or 'status' we must apply the 1st sort
				-- (status & bar length are floats, so simply scaling doesnt work)
				-- Having these as the 2nd sort doesntmakea huge amount of sense anyway,
				-- so we hopefully only sort once per window (if at all)
				-- Note that the doublesort also only works as the merge-sort is a 'stable' sort
				if(config.sort2 <= 2)then
					OZ_DoSort()
					scale = nil
				end
			end
			getglobal( OZ_SortFunctions[config.sort2].pFunction ) (n, scale)
			OZ_DoSort()
		elseif(scale)then
			OZ_DoSort() -- sort1 hasnt been applied and there is no sort2
		end
		OZ_FinaliseSort(n)

		-- Step 4: Format
		getglobal( OZ_ColourFunctions[config.colour].pFunction ) (n)

		-- Step 7: Add Bar Headers
		for i = 1,OZ_Bars[n].nBars do
			OZ_Bars[n].bar[i].header = nil
			OZ_ShowBuffs(n,i)
		end

		if( config.heading[2] > 0 ) then
			getglobal( OZ_HeadingFunctions[config.heading[2]].pFunction ) (n)
		end

		if( config.heading[1] > 0 ) then
			getglobal( OZ_HeadingFunctions[config.heading[1]].pFunction ) (n)
		end
	else
		OZ_Bars[n].nBars = 0
	end
end


-- Function to set up bar size/colours based on the data in OZ_Bars
function OZ_SetBars(n)
	local row
	local a = OZ_Config[n].maxBars
	local h = 0

	if( OZ_Bars[n].nBars < a ) then
		a = OZ_Bars[n].nBars
	end

	local barWidth = OZ_Config[n].width - 10
	local barHeight = OZ_Config[n].barHeight
	
	local config = OZ_Config[n]
	local window = OZ_GetWindowArray(n)

	if( a > 0) then
		for row = 1,a do
			local currBar = OZ_Bars[n].bar[row]
			local currFrame = window.bar[row]
			local unit = currBar.unit
			local p = currBar.roster
			local isClose = 1
			local text, value
			local nr,ng,nb = 1,1,1
			local br,bg,bb = 1,1,1

			if(config.valuePos)then
				if(config.valueType == 1)then
					value = currBar.current
				elseif(config.valueType == 2)then
					value = string.format("%3.0d%%", currBar.value * 100)
				elseif(config.valueType == 3)then
					if(currBar.current < currBar.max)then
						value = "-"..(currBar.max-currBar.current)
					end
				end
			end

			if( config.classNames )then
				nr = OZ_CLASS_COLOURS[currBar.class].r
				ng = OZ_CLASS_COLOURS[currBar.class].g
				nb = OZ_CLASS_COLOURS[currBar.class].b
			end

			-- TODO Add leader & raid target icons here
			currBar.icon = nil
			local aggro = nil

			if( p>0 ) then
				-- This bar is a PLAYER
				local player = OZ_RaidRoster.member[p]
				text = player.name
				isClose = player.range

				if(CT_RA_Stats)then
					local stats = CT_RA_Stats[currBar.name];
					if(stats)then
						if(stats["notready"] == 2)then
							currBar.icon = "Interface\\Buttons\\UI-GroupLoot-Pass-Up"
						elseif(stats["notready"])then
							currBar.icon = "Interface\\Buttons\\UI-GroupLoot-Pass-Highlight"
						end
					end
				end

				if( not player.online )then
					if( config.nameOnStatus )then
						nr = 0.7
						ng = 0.7
						nb = 0.7
					end
					currBar.value = 1.0
					currBar.colour.r = 0.4
					currBar.colour.g = 0.4
					currBar.colour.b = 0.4
					isClose = nil
					value = ""
				elseif( player.isDead )then
					if( config.nameOnStatus )then
						nr = 1
						ng = 0
						nb = 0
					end
					currBar.value = 1.0
					currBar.colour.r=0.3
					currBar.colour.g=0.2
					currBar.colour.b=0.2
					value = ""
				else
					aggro = player.hasAggro
				end
				currBar.icon = player.icon
					
			elseif( currBar.target > 0 ) then

				-- This bar is a mob
				local target = OZ_RaidRoster.target[currBar.target]
				text = target.name
				isClose = target.range
				currBar.icon = target.icon

--				currBar.colour.r=1
--				currBar.colour.g=0.5
--				currBar.colour.b=0.2
			else
				-- Aggregated
				text = currBar.class
				currBar.icon = nil
			end
			currBar.name = text
			if(currBar.debuff)then
				currBar.icon = currBar.debuff
			end

			currFrame.barFrame.unit = unit
			if( (currBar.nameRed ~= nr) or
				(currBar.nameGreen ~= ng) or
				(currBar.nameBlue ~= nb) )then
				currFrame.nameText:SetTextColor( nr,ng,nb )
			end
			if(currFrame.nameVal ~= text)then
				currFrame.nameText:SetText( text )
				currFrame.nameVal = text
			end

			if(currFrame.valueVal ~= value)then
				if(value)then
					if(not currFrame.value:IsVisible())then
						currFrame.value:Show()
					end
					currFrame.valueText:SetText( value )
				else
					if(currFrame.value:IsVisible())then
						currFrame.value:Hide()
					end
				end
				currFrame.valueVal = value
			end

			local w = barWidth*currBar.value
			if( w > barWidth ) then
				w = barWidth
			elseif( w < 0.1 ) then
				w = 0.1
			end
			currFrame.bar:SetWidth( w );
			if(config.barTexture)then
				currFrame.bar:SetTexCoord(0,currBar.value * 0.75,0,1)
			end

			currFrame.bar:SetVertexColor(	currBar.colour.r,
											currBar.colour.g,
											currBar.colour.b );

			if( (config.rangeFade) and (currBar.unit) and (not isClose) )then
				currFrame.bar:SetAlpha(0.40)
			else
				currFrame.bar:SetAlpha(1)
			end
			if( aggro and not config.hideGlow )then
				currFrame.glow:SetAlpha(aggro)
				if(not currFrame.glow:IsVisible())then
					currFrame.glow:Show()
--					currFrame.glow:SetBlendMode("ADD")
				end
			else
				if(currFrame.glow:IsVisible())then
					currFrame.glow:Hide()
				end
			end

			if (currBar.header) then
				if(currFrame.headerVal ~= currBar.header) then
					currFrame.headerVal = currBar.header
					currFrame.frame:SetHeight(barHeight*2)
					currFrame.header:SetHeight(barHeight)
					currFrame.headerText:SetText(currBar.header)
				end
				if(not currFrame.headerText:IsVisible())then
					currFrame.headerText:Show()
					currFrame.header:Show()
				end
				h = h + barHeight*2
			else
				if(currFrame.headerVal)then
					currFrame.headerVal = nil
					currFrame.frame:SetHeight(barHeight)
					if(config.barGap)then
						currFrame.header:SetHeight(config.barGap)
					else
						currFrame.header:SetHeight(0.01)
					end
				end
				if(currFrame.headerText:IsVisible())then
					currFrame.headerText:Hide()
				end
				h = h + barHeight
			end

			if(not currFrame.frame:IsVisible())then
				currFrame.frame:Show()
			end

		end
	end
	if( a < 40 ) then
		for row = a+1,40 do
			currFrame = window.bar[row].frame
			if(currFrame:IsVisible())then
				currFrame:Hide()
			end
		end
	end
	OZ_Bars[n].nBars = a;
	
	if( h<config.barHeight * config.minBars )then
		h = config.barHeight * config.minBars
	end
	h = h + 16
	if(not config.hideTitle)then
		h = h + config.titleHeight
	end
	if( h < 20)then
		h = 20
	end

	window.frame:SetHeight(h)
end



function OZ_FormatRow(n,i)
	local row = "OzRaid_Frame"..n.."TableRow"..i.."BarFrame"
	local config = OZ_Config[n]
	local window = OZ_GetWindowArray(n)
	local currFrame = window.bar[i]
--DEFAULT_CHAT_FRAME:AddMessage("|c0033CCFF".."Formatting: "..row);
	
	-- Setup name & Icon position
	if(config.namePos == 1)then
		-- Names positioned ON the bars
		currFrame.icon:ClearAllPoints()
		currFrame.icon:SetPoint("LEFT",row)
		currFrame.icon:SetHeight(config.buttonSize)
		currFrame.iconVal = 1

		currFrame.name:ClearAllPoints()
		currFrame.name:SetPoint("LEFT", row.."Icon", "RIGHT")
		currFrame.name:SetWidth(config.width - config.buttonSize - 10)
		currFrame.name:SetHeight(config.barHeight)

		currFrame.nameText:SetJustifyH("LEFT")
	elseif(config.namePos == 2)then
		-- Names positioned to the LEFT of the bars
		currFrame.icon:ClearAllPoints()
		currFrame.icon:SetPoint("RIGHT",row,"LEFT", -6, 0)
		currFrame.icon:SetHeight(config.buttonSize)
		currFrame.iconVal = 1

		currFrame.name:ClearAllPoints()
		currFrame.name:SetPoint("RIGHT", row.."Icon", "LEFT", -6, 0)
		currFrame.name:SetWidth(config.width)
		currFrame.name:SetHeight(config.barHeight)

		currFrame.nameText:SetJustifyH("RIGHT")
	elseif(config.namePos == 3)then
		-- Names positioned to the RIGHT of the bars
		currFrame.icon:ClearAllPoints()
		currFrame.icon:SetPoint("LEFT",row,"RIGHT", 4, 0)
		currFrame.icon:SetHeight(config.buttonSize)
		currFrame.iconVal = 1

		currFrame.name:ClearAllPoints()
		currFrame.name:SetPoint("LEFT", row.."Icon", "RIGHT")
		currFrame.name:SetWidth(config.width)
		currFrame.name:SetHeight(config.barHeight)

		currFrame.nameText:SetJustifyH("LEFT")
	else
		-- Names positioned CENTRED ON the bars
		currFrame.icon:ClearAllPoints()
		currFrame.icon:SetPoint("LEFT",row)
		currFrame.icon:SetHeight(config.buttonSize)
		currFrame.iconVal = 1

		currFrame.name:ClearAllPoints()
		currFrame.name:SetPoint("LEFT", row.."Icon", "RIGHT")
		currFrame.name:SetWidth(config.width - config.buttonSize - 10)
		currFrame.name:SetHeight(config.barHeight)

		currFrame.nameText:SetJustifyH("CENTER")
	end

	-- Now setup buff positions
	local size = config.buttonSize
	if(config.buffSize == 1)then
		if(config.buffPos == 1)then
			-- Buffs on the bar, right hand side, tiling left
			currFrame.buff[1]:ClearAllPoints()
			currFrame.buff[1]:SetPoint("RIGHT",row)
			currFrame.buff[1]:SetHeight(config.buttonSize)

			currFrame.buff[2]:ClearAllPoints()
			currFrame.buff[2]:SetPoint("RIGHT", row.."Buff1","LEFT")
			currFrame.buff[2]:SetHeight(config.buttonSize)

			currFrame.buff[3]:ClearAllPoints()
			currFrame.buff[3]:SetPoint("RIGHT", row.."Buff2","LEFT")
			currFrame.buff[3]:SetHeight(config.buttonSize)

			currFrame.buff[4]:ClearAllPoints()
			currFrame.buff[4]:SetPoint("RIGHT", row.."Buff3","LEFT")
			currFrame.buff[4]:SetHeight(config.buttonSize)

		elseif(config.buffPos == 2)then
			-- Buffs to the left of the bar, tiling left
			currFrame.buff[1]:ClearAllPoints()
			currFrame.buff[1]:SetPoint("RIGHT", row,"LEFT", -6, 0)
			currFrame.buff[1]:SetHeight(config.buttonSize)

			currFrame.buff[2]:ClearAllPoints()
			currFrame.buff[2]:SetPoint("RIGHT", row.."Buff1","LEFT")
			currFrame.buff[2]:SetHeight(config.buttonSize)

			currFrame.buff[3]:ClearAllPoints()
			currFrame.buff[3]:SetPoint("RIGHT", row.."Buff2","LEFT")
			currFrame.buff[3]:SetHeight(config.buttonSize)

			currFrame.buff[4]:ClearAllPoints()
			currFrame.buff[4]:SetPoint("RIGHT", row.."Buff3","LEFT")
			currFrame.buff[4]:SetHeight(config.buttonSize)
		else
			-- Buffs to the right of the bar, tiling right
			currFrame.buff[1]:ClearAllPoints()
			currFrame.buff[1]:SetPoint("LEFT", row,"RIGHT",6,0)
			currFrame.buff[1]:SetHeight(config.buttonSize)

			currFrame.buff[2]:ClearAllPoints()
			currFrame.buff[2]:SetPoint("LEFT", row.."Buff1","RIGHT")
			currFrame.buff[2]:SetHeight(config.buttonSize)

			currFrame.buff[3]:ClearAllPoints()
			currFrame.buff[3]:SetPoint("LEFT", row.."Buff2","RIGHT")
			currFrame.buff[3]:SetHeight(config.buttonSize)

			currFrame.buff[4]:ClearAllPoints()
			currFrame.buff[4]:SetPoint("LEFT", row.."Buff3","RIGHT")
			currFrame.buff[4]:SetHeight(config.buttonSize)
		end
	else
		size = config.buttonSize * 0.5
		if(config.buffPos == 1)then
			-- Buffs on the bar, right hand side, Square arrangement
			currFrame.buff[1]:ClearAllPoints()
			currFrame.buff[1]:SetPoint("TOPRIGHT",row)
			currFrame.buff[1]:SetHeight(size)

			currFrame.buff[2]:ClearAllPoints()
			currFrame.buff[2]:SetPoint("BOTTOMRIGHT",row)
			currFrame.buff[2]:SetHeight(size)

			currFrame.buff[3]:ClearAllPoints()
			currFrame.buff[3]:SetPoint("RIGHT", row.."Buff1","LEFT")
			currFrame.buff[3]:SetHeight(size)

			currFrame.buff[4]:ClearAllPoints()
			currFrame.buff[4]:SetPoint("RIGHT", row.."Buff2","LEFT")
			currFrame.buff[4]:SetHeight(size)
		elseif(config.buffPos == 2)then
			-- Buffs to the left of the bar, Square arrangement
			currFrame.buff[1]:ClearAllPoints()
			currFrame.buff[1]:SetPoint("TOPRIGHT", row,"TOPLEFT",-6,0)
			currFrame.buff[1]:SetHeight(size)

			currFrame.buff[2]:ClearAllPoints()
			currFrame.buff[2]:SetPoint("BOTTOMRIGHT", row,"BOTTOMLEFT",-6,0)
			currFrame.buff[2]:SetHeight(size)

			currFrame.buff[3]:ClearAllPoints()
			currFrame.buff[3]:SetPoint("RIGHT", row.."Buff1","LEFT")
			currFrame.buff[3]:SetHeight(size)

			currFrame.buff[4]:ClearAllPoints()
			currFrame.buff[4]:SetPoint("RIGHT", row.."Buff2","LEFT")
			currFrame.buff[4]:SetHeight(size)
		else
			-- Buffs to the right of the bar, Square arrangement
			currFrame.buff[1]:ClearAllPoints()
			currFrame.buff[1]:SetPoint("TOPLEFT", row,"TOPRIGHT", 6, 0)
			currFrame.buff[1]:SetHeight(size)

			currFrame.buff[2]:ClearAllPoints()
			currFrame.buff[2]:SetPoint("BOTTOMLEFT", row,"BOTTOMRIGHT", 6, 0)
			currFrame.buff[2]:SetHeight(size)

			currFrame.buff[3]:ClearAllPoints()
			currFrame.buff[3]:SetPoint("LEFT", row.."Buff1","RIGHT")
			currFrame.buff[3]:SetHeight(size)

			currFrame.buff[4]:ClearAllPoints()
			currFrame.buff[4]:SetPoint("LEFT", row.."Buff2","RIGHT")
			currFrame.buff[4]:SetHeight(size)
		end
	end
	local j
	for j=1,4 do
		currFrame.buff[j]:SetWidth(size)
	end
	
	if(currFrame.headerVal) then
		currFrame.frame:SetHeight(config.barHeight*2)
		currFrame.header:SetHeight(config.barHeight)
	else
		currFrame.frame:SetHeight(config.barHeight)
		if(config.barGap)then
			currFrame.header:SetHeight(config.barGap)
		else
			currFrame.header:SetHeight(0.01)
		end
	end

	-- Now set the number positions
	if(config.valuePos)then
		currFrame.value:ClearAllPoints()
		if(config.valuePos == 1)then
			currFrame.value:SetPoint("RIGHT", row,"LEFT", -16, 0)
			currFrame.valueText:SetJustifyH("RIGHT")
		elseif(config.valuePos == 2)then
			currFrame.value:SetPoint("CENTER", row,"CENTER")
			currFrame.valueText:SetJustifyH("CENTER")
		elseif(config.valuePos == 3)then
			currFrame.value:SetPoint("RIGHT", row,"RIGHT", -6, 0)
			currFrame.valueText:SetJustifyH("RIGHT")
		else
			currFrame.value:SetPoint("LEFT", row,"RIGHT", 6, 0)
			currFrame.valueText:SetJustifyH("LEFT")
		end
		if(config.valueType == 3)then
			-- DEFICIT gets hidden/shown when drawn
			currFrame.value:Hide()
		else
			currFrame.value:Show()
		end
		currFrame.value:SetHeight(16)
		currFrame.value:SetWidth(100)
	else
		currFrame.value:Hide()
	end
	
	-- Set texture
	-- "Interface\\Addons\\OzRaid\\bar10"
	if(config.barTexture)then
		if(currFrame.barTexture ~= currFrame.bar:GetTexture())then
			currFrame.bar:SetTexture(config.barTexture)
		end
	else
		if(currFrame.barTexture ~= "Interface\\TargetingFrame\\UI-StatusBar")then
			currFrame.bar:SetTexture("Interface\\TargetingFrame\\UI-StatusBar")
		end
	end
	--currFrame.bar:SetBlendMode("BLEND")

	window.frame:SetWidth(config.width)
end

function OZ_ShowBuffs(n,i)
	local config = OZ_Config[n]
	local size = OZ_Config[n].buttonSize
	if(OZ_Config[n].buffSize ~= 1)then
		size = size * 0.5
	end
	local window = OZ_GetWindowArray(n)
	local currFrame = window.bar[i]
	local currBar = OZ_Bars[n].bar[i]

	for	j=1,4 do
		local buffPath = currBar.buffs[j]
		if(currFrame.buffVal[j] ~= buffPath)then
			if(buffPath)then
				currFrame.buff[j]:SetWidth(size)
				currFrame.buffTex[j]:SetTexture(buffPath)
				currFrame.buff[j]:Show()
			else
				currFrame.buff[j]:SetWidth(0.1)
				currFrame.buff[j]:Hide()
			end
			currFrame.buffVal[j] = buffPath
		end
	end

	if(OZ_Config[n].hideIcon)then
		currBar.icon = nil
	end

	-- Set debuffed!
	if(currBar.debuff)then
		if( OZ_Config[n].barDebuffCol )then
			currBar.colour.r = 1
			currBar.colour.g = 0
			currBar.colour.b = 1
		end
		if( OZ_Config[n].showDebuffIcon )then
			currBar.icon = currBar.debuff
		end
	end

	if( currBar.icon ~= currFrame.iconVal )then
		if( currBar.icon )then
			currFrame.icon:SetWidth( OZ_Config[n].buttonSize )
			if(currFrame.iconTex:GetTexture() ~= currBar.icon)then
				currFrame.iconTex:SetTexture( currBar.icon )
			end
		else
			currFrame.icon:SetWidth( 0.1 )
		end
		currFrame.iconVal = currBar.icon
	end
end


function OZ_ToolTip()
	local n = this:GetParent():GetParent():GetParent():GetID()
	if(OZ_Config[n].tooltips)then
		local i = this:GetParent():GetID()
		local bar = OZ_Bars[n].bar[i]
		local unit = bar.unit
		local player
		if(bar.roster > 0)then
			-- It is a player...
			player = OZ_RaidRoster.member[bar.roster]

			GameTooltip:SetOwner(this, "ANCHOR_CURSOR");
			GameTooltip:ClearLines()
			GameTooltip:SetUnit(unit)
			if(CT_RA_Stats) then
				local stats = CT_RA_Stats[OZ_Bars[n].bar[i].name];
				if(stats)then
					-- We have CTRaid stats!
					-- This code taken straight from CTRaid
					-- (No sense reinventing the wheel after all)
					local version = stats;
					if ( version ) then
						version = version["Version"];
					end
					if ( not version ) then
						if ( not stats or not stats["Reporting"] ) then
							GameTooltip:AddLine("No CTRA Found", 0.7, 0.7, 0.7);
						else
							GameTooltip:AddLine("CTRA <1.077", 1, 1, 1);
						end
					else
						GameTooltip:AddLine("CTRA " .. version, 1, 1, 1);
					end

					if ( stats and stats["AFK"] ) then
						if ( type(stats["AFK"][1]) == "string" ) then
							GameTooltip:AddLine("AFK: " .. stats["AFK"][1]);
						end
						GameTooltip:AddLine("AFK for " .. CT_RA_FormatTime(stats["AFK"][2]));
					elseif ( CT_RA_Stats[name] and stats["DND"] ) then
						if ( type(stats["DND"][1]) == "string" ) then
							GameTooltip:AddLine("DND: " .. stats["DND"][1]);
						end
						GameTooltip:AddLine("DND for " .. CT_RA_FormatTime(stats["DND"][2]));
					end
					if ( player.offline ) then
						-- Um... do this outside
					elseif ( stats and stats["FD"] ) then
						if ( stats["FD"] < 360 ) then
							GameTooltip:AddLine("Dying in " .. CT_RA_FormatTime(360-stats["FD"]));
						end
					elseif ( stats and stats["Dead"] ) then
						if ( stats["Dead"] < 360 and not UnitIsGhost(unit) ) then
							GameTooltip:AddLine("Releasing in " .. CT_RA_FormatTime(360-stats["Dead"]));
						else
							GameTooltip:AddLine("Dead for " .. CT_RA_FormatTime(stats["Dead"]));
						end
					end
					if ( stats and stats["Rebirth"] and stats["Rebirth"] > 0 ) then
						GameTooltip:AddLine("Rebirth up in: " .. CT_RA_FormatTime(stats["Rebirth"]));
					elseif ( stats and stats["Reincarnation"] and stats["Reincarnation"] > 0 ) then
						GameTooltip:AddLine("Ankh up in: " .. CT_RA_FormatTime(stats["Reincarnation"]));
					elseif ( stats and stats["Soulstone"] and stats["Soulstone"] > 0 ) then
						GameTooltip:AddLine("Soulstone up in: " .. CT_RA_FormatTime(stats["Soulstone"]));
					end
				end
			end
			if(player.offline)then
				local diff = GetTime() - player.offline
				local sec = mod(diff, 60)
				local min = diff * 0.016666
				if(min < 60)then
					GameTooltip:AddLine(string.format("Offline for: %dm %ds",min,sec))
				else
					local hour = diff * 0.000277777
					GameTooltip:AddLine(string.format("Offline for: %dh %dm",hour,min))
				end
			end
			GameTooltip:Show();
		end
	end
end

function OZ_BuffTooltip()
--DEFAULT_CHAT_FRAME:AddMessage("|c0033CCFF".."  Buff Tooltip...");
	GameTooltip:SetOwner(this, "ANCHOR_CURSOR");
	GameTooltip:ClearLines()

	local n = this:GetParent():GetParent():GetParent():GetParent():GetID()
	if(OZ_Config[n].tooltips)then
		local i = this:GetParent():GetParent():GetID()
		local bar = OZ_Bars[n].bar[i]
		local unit = bar.unit
		local id = this:GetID()
		if(unit)then
			-- It is a player...
			local buff = bar.buffs[id]
			if(buff)then
				local buffName = bar.buffNames[id]

				if(CT_RA_Stats)then
					local stats = CT_RA_Stats[bar.name];
					local left,secure
					if(stats)then
						if(not stats["Buffs"][buffName] and (buffName == "Mark of the Wild") )then
							buffName = "Gift of the Wild"
						end
					end

					if ( stats and stats["Buffs"][buffName] and stats["Buffs"][buffName][2] ) then
						left = stats["Buffs"][buffName][2];
						if ( stats["Reporting"] and ( stats["Version"] or 0 ) >= 1.38 ) then
							secure = 1;
						end
					end
					if ( left ) then
						local str;
						if ( left >= 60 ) then
							secs = mod(left, 60);
							mins = (left-secs)/60;
						else
							mins = 0;
							secs = left;
						end
						if ( mins < 0 ) then mins = "00"; elseif ( mins < 10 ) then mins = "0" .. mins; end
						if ( secs < 0 ) then secs = "00"; elseif ( secs < 10 ) then secs = "0" .. secs; end
						if(secure)then
							GameTooltip:SetText(buffName .. " (" .. mins .. ":" .. secs .. ")");
						else
							GameTooltip:SetText(buffName .. " (" .. mins .. ":" .. secs .. "?)");
						end
						GameTooltip:Show();
						return
					end
				end
				if( buffName ) then
					GameTooltip:SetText(buffName);
					GameTooltip:Show();
				end
			end
		end
	end
end
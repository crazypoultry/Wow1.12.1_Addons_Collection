--[[ this comment is contained within brackets
		and can be span across multiple lines]]

-- this comment spans a single line only

function ExampleCode_ReadMe(arg1)
	local read = arg1;
	if (read == ExampleCode_Variable) then 
		ExampleCodeSetting = "on";
	else
		ExampleCodeSetting = "off";
	end
	return ExampleCodeSetting;
end

function GuildMap_CreateNoteObject(noteNumber)
	local button;
	local overlayFrameNumber = math.floor((noteNumber - 1000) / 100 + 1); 
	if(getglobal("GatherMain"..noteNumber)) then
		button = getglobal("GatherMain"..noteNumber);
	else
--Gatherer_Print("DEBUG create id "..noteNumber.." frame ".. overlayFrameNumber);
		button = CreateFrame("Button" ,"GatherMain"..noteNumber, getglobal("GathererMapOverlayFrame"..overlayFrameNumber), "GatherMainTemplate");
		button:SetID(noteNumber);
	end
	
	return button;
end


-- Draw the icons for each member in our list.
function GuildMap_Draw()
	local lastUnused = 1000;
	local maxNotes = 1600;
	local gatherName, gatherData;

	-- prevent the function from running twice at the same time.
	if (GuildMap_UpdateWorldMap == 0 ) then return; end;
	GuildMap_UpdateWorldMap = 0;
	
	if (GuildMap_MapOpen) then
		local mapContinent = GetCurrentMapContinent();
		local mapZone = GetCurrentMapZone();
		if ((mapContinent > 0) and (mapZone > 0) ) then
			for index, values in GuildMap_GUILDIES do
				local gatherType = "Default";
				local specificType = "";
				local allowed = true; 
				local minSetSkillLevel = 0;
				local idx_count=0;
				getglobal("GathererMapOverlayFrame".."1"):Show();
				-- extra filtering options

						if ((gatherInfo.x) and (gatherInfo.y) and (gatherInfo.x>0) and (gatherInfo.y>0) and (lastUnused <= maxNotes)) then
							local mainNote = GuildMap_CreateNoteObject(lastUnused);
--							getglobal("GatherMain"..lastUnused);

							local mnX,mnY;
							mnX = gatherInfo.x / 100 * GuildMap_WorldMapDetailFrameWidth;
							mnY = -gatherInfo.y / 100 * GuildMap_WorldMapDetailFrameHeight;

							if ( GatherConfig and GatherConfig.IconAlpha ~= nil ) then
								mainNote:SetAlpha(GatherConfig.IconAlpha / 100);
							else				
								mainNote:SetAlpha(0.8);
							end
							
							mainNote:SetPoint("CENTER", "GathererMapOverlayFrame", "TOPLEFT", mnX, mnY);
							
							if	( GatherConfig and GatherConfig.ToggleWorldNotes and GatherConfig.ToggleWorldNotes == 1)
							then
								mainNote.toolTip = GuildMap_GetMenuName(gatherName);
							else
								mainNote.toolTip = GuildMap_GetMenuName(specificType);
							end

							if ( type(gatherType) == "number" ) then
								convertedGatherType = Gather_DB_TypeIndex[gatherType];
								numGatherType = gatherType
							else
								convertedGatherType = gatherType;
								numGatherType = Gather_DB_TypeIndex[gatherType];
							end
							
							if (not Gather_IconSet["iconic"][convertedGatherType]) then 
								gatherType = "Default"; 
							else
								gatherType = convertedGatherType;
							end
							if ( type(specificType) == "number" ) then
								specificType = GuildMap_GetDB_IconIndex(specificType, convertedGatherType);
							end
							local texture = Gather_IconSet["iconic"][convertedGatherType][specificType];
							if (not texture) then
								texture = Gather_IconSet["iconic"][gatherType]["default"];
							end

							if ( gatherInfo.gtype == "Default" or gatherInfo.gtype == 3 ) then
								texture = Gather_IconSet["iconic"]["Default"]["default"];
							end
							
							local mainNoteTexture = getglobal("GatherMain"..lastUnused.."Texture");
							mainNoteTexture:SetTexture(texture);
							if ( GatherConfig and GatherConfig.IconSize ~= nil ) then
								mainNote:SetWidth(GatherConfig.IconSize);
								mainNote:SetHeight(GatherConfig.IconSize);
							end
							
							-- setting value for editing
							if (type(gatherInfo.icon) == "string" ) then
								numGatherIcon = Gather_DB_IconIndex[numGatherType];
							else
								numGatherIcon = gatherInfo.icon;
							end

							mainNote.continent = mapContinent;
							mainNote.zoneIndex = mapZone;
							mainNote.gatherName = gatherName;
							mainNote.localIndex = hPos;
							mainNote.gatherType = numGatherType;
							mainNote.gatherIcon = numGatherIcon;

							if ( not mainNote:IsShown() ) then							
								mainNote:Show();
							end
							lastUnused = lastUnused + 1;
						end
					end
				end
			end
		end
	end

	local i=1000;
	for i=lastUnused, maxNotes, 1 do
		-- Delay code to try to work around the delay display problem, pause for 50 ms each 100 items
		local overlayFrameNumber = math.floor((i - 1000) / 100 +1); 

		if ( i < maxNotes and mod(i, 100) == 0 ) 
		then
			getglobal("GathererMapOverlayFrame"..overlayFrameNumber):Hide();
		end

		local mainNote = getglobal("GatherMain"..i);
		if ( mainNote and mainNote:IsShown() ) then
			mainNote:SetPoint("CENTER", "GathererMapOverlayFrame", "TOPLEFT", GuildMap_WorldMapDetailFrameWidth+16, GuildMap_WorldMapDetailFrameHeight+16);
		end
	end

	GuildMap_UpdateWorldMap = -1;
end
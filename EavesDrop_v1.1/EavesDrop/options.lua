local L = AceLibrary("AceLocale-2.1"):GetInstance("EavesDrop", true)

function EavesDrop:SetupOptions()	
	self.options = {
		type = "group",
		args = {
			events = {
				name = L["Events"],
				desc = L["Events"],
				type = "group",
				order = 1,
				args = {
					combat = {
						name = L["ECombat"],
						type = "toggle",
				    desc = L["ECombatD"],
				    order = 1,
				    get = function()
				        return self.db.profile["COMBAT"]
				    end,
				    set = function(v)
				        self.db.profile["COMBAT"] = v;
				        self:UpdateCombatEvents();
				    end
					},
					gains = {
						name = L["EPower"],
						type = "toggle",
				    desc = L["EPowerD"],
				    order = 2,
				    get = function()
				        return self.db.profile["GAIN"]
				    end,
				    set = function(v)
				        self.db.profile["GAIN"] = v;
				    end
					},
					buffs = {
						name = L["EBuffs"],
						type = "toggle",
				    desc = L["EBuffsD"],
				    order = 3,
				    get = function()
				        return self.db.profile["BUFF"]
				    end,
				    set = function(v)
				        self.db.profile["BUFF"] = v;
				    end
					},
					debuffs = {
						name = L["EDebuffs"],
						type = "toggle",
				    desc = L["EDebuffsD"],
				    order = 4,
				    get = function()
				        return self.db.profile["DEBUFF"]
				    end,
				    set = function(v)
				        self.db.profile["DEBUFF"] = v;
				    end
					},
					fades = {
						name = L["EFades"],
						type = "toggle",
				    desc = L["EFadesD"],
				    order = 4,
				    get = function()
				        return self.db.profile["FADE"]
				    end,
				    set = function(v)
				        self.db.profile["FADE"] = v;
				        self:UpdateFadeEvents();
				    end
					},
					exp = {
						name = L["EExperience"],
						type = "toggle",
				    desc = L["EExperienceD"],
				    order = 5,
				    get = function()
				        return self.db.profile["EXP"]
				    end,
				    set = function(v)
				        self.db.profile["EXP"] = v;
				        self:UpdateExpEvents();
				    end
					},
					honor = {
						name = L["EHonor"],
						type = "toggle",
				    desc = L["EHonorD"],
				    order = 6,
				    get = function()
				        return self.db.profile["HONOR"]
				    end,
				    set = function(v)
				        self.db.profile["HONOR"] = v;
				        self:UpdateHonorEvents();
				    end
					},
					rep = {
						name = L["EReputation"],
						type = "toggle",
				    desc = L["EReputationD"],
				    order = 7,
				    get = function()
				        return self.db.profile["REP"]
				    end,
				    set = function(v)
				        self.db.profile["REP"] = v;
				        self:UpdateRepEvents();
				    end
					},
					skill = {
						name = L["ESkill"],
						type = "toggle",
				    desc = L["ESkillD"],
				    order = 8,
				    get = function()
				        return self.db.profile["SKILL"]
				    end,
				    set = function(v)
				        self.db.profile["SKILL"] = v;
				        self:UpdateSkillEvents();
				    end
					},
					pet = {
						name = L["EPet"],
						type = "toggle",
				    desc = L["EPetD"],
				    order = 9,
				    get = function()
				        return self.db.profile["PET"]
				    end,
				    set = function(v)
				        self.db.profile["PET"] = v;
				        self:UpdatePetEvents();
				    end
					},
					spellcolor = {
						name = L["ESpellcolor"],
						type = "toggle",
				    desc = L["ESpellcolorD"],
				    order = 10,
				    get = function()
				        return self.db.profile["SPELLCOLOR"]
				    end,
				    set = function(v)
				        self.db.profile["SPELLCOLOR"] = v;
				        self:UpdateEvents();
				    end
					},
					overheal = {
						name = L["EOverhealing"],
						type = "toggle",
				    desc = L["EOverhealingD"],
				    order = 11,
				    get = function()
				        return self.db.profile["OVERHEAL"]
				    end,
				    set = function(v)
				        self.db.profile["OVERHEAL"] = v;
				    end
					},
					healers = {
						name = L["EHealers"],
						type = "toggle",
				    desc = L["EHealersD"],
				    order = 12,
				    get = function()
				        return self.db.profile["HEALERID"]
				    end,
				    set = function(v)
				        self.db.profile["HEALERID"] = v;
				    end
					},
				},
			},
			
			colors = {
				name = L["Colors"],
				desc = L["Colors"],
				type = "group",
				order = 2,
				args = {			
					icolor = {
						name = L["IColors"],
						desc = L["IColorsD"],
						type = "group",
						order = 1,
						args = {
							phit = {
								name = L["ICHits"],
								type = "color",
						    desc = L["ICHitsD"],
						    order = 1,
						    get = function()
						        return self.db.profile["PHIT"].r, self.db.profile["PHIT"].g, self.db.profile["PHIT"].b
						    end,
						    set = function(r, g, b)
						        self.db.profile["PHIT"].r, self.db.profile["PHIT"].g, self.db.profile["PHIT"].b = r, g, b
						    end
							},
							pmiss = {
								name = L["ICMiss"],
								type = "color",
						    desc = L["ICMissD"],
						    order = 2,
						    get = function()
						        return self.db.profile["PMISS"].r, self.db.profile["PMISS"].g, self.db.profile["PMISS"].b
						    end,
						    set = function(r, g, b)
						        self.db.profile["PMISS"].r, self.db.profile["PMISS"].g, self.db.profile["PMISS"].b = r, g, b
						    end
							},
							pheal = {
								name = L["ICHeals"],
								type = "color",
						    desc = L["ICHealsD"],
						    order = 3,
						    get = function()
						        return self.db.profile["PHEAL"].r, self.db.profile["PHEAL"].g, self.db.profile["PHEAL"].b
						    end,
						    set = function(r, g, b)
						        self.db.profile["PHEAL"].r, self.db.profile["PHEAL"].g, self.db.profile["PHEAL"].b = r, g, b
						    end
							},
							pspell = {
								name = L["ICSpells"],
								type = "color",
						    desc = L["ICSpellsD"],
						    order = 4,
						    get = function()
						        return self.db.profile["PSPELL"].r, self.db.profile["PSPELL"].g, self.db.profile["PSPELL"].b
						    end,
						    set = function(r, g, b)
						        self.db.profile["PSPELL"].r, self.db.profile["PSPELL"].g, self.db.profile["PSPELL"].b = r, g, b
						    end
							},
							pgain= {
								name = L["EPower"],
								type = "color",
						    desc = L["ICGainsD"],
						    order = 5,
						    get = function()
						        return self.db.profile["PGAIN"].r, self.db.profile["PGAIN"].g, self.db.profile["PGAIN"].b
						    end,
						    set = function(r, g, b)
						        self.db.profile["PGAIN"].r, self.db.profile["PGAIN"].g, self.db.profile["PGAIN"].b = r, g, b
						    end
							},
							pbuff= {
								name = L["EBuffs"],
								type = "color",
						    desc = L["ICBuffsD"],
						    order = 6,
						    get = function()
						        return self.db.profile["PBUFF"].r, self.db.profile["PBUFF"].g, self.db.profile["PBUFF"].b
						    end,
						    set = function(r, g, b)
						        self.db.profile["PBUFF"].r, self.db.profile["PBUFF"].g, self.db.profile["PBUFF"].b = r, g, b
						    end
							},
							pdebuff= {
								name = L["EDebuffs"],
								type = "color",
						    desc = L["ICDebuffsD"],
						    order = 7,
						    get = function()
						        return self.db.profile["PDEBUFF"].r, self.db.profile["PDEBUFF"].g, self.db.profile["PDEBUFF"].b
						    end,
						    set = function(r, g, b)
						        self.db.profile["PDEBUFF"].r, self.db.profile["PDEBUFF"].g, self.db.profile["PDEBUFF"].b = r, g, b
						    end
							},
							peti = {
								name = L["EPet"],
								type = "color",
						    desc = L["ICPetD"],
						    order = 8,
						    get = function()
						        return self.db.profile["PETO"].r, self.db.profile["PETO"].g, self.db.profile["PETO"].b
						    end,
						    set = function(r, g, b)
						        self.db.profile["PETO"].r, self.db.profile["PETO"].g, self.db.profile["PETO"].b = r, g, b
						    end
							},
						},
					},
					ocolor = {
						name = L["OColors"],
						desc = L["OColorsD"],
						type = "group",
						order = 2,
						args = {
							tmelee = {
								name = L["ICHits"],
								type = "color",
						    desc = L["OCHitsD"],
						    order = 1,
						    get = function()
						        return self.db.profile["TMELEE"].r, self.db.profile["TMELEE"].g, self.db.profile["TMELEE"].b
						    end,
						    set = function(r, g, b)
						        self.db.profile["TMELEE"].r, self.db.profile["TMELEE"].g, self.db.profile["TMELEE"].b = r, g, b
						    end
							},
							tspell = {
								name = L["ICSpells"],
								type = "color",
						    desc = L["OCSpellsD"],
						    order = 2,
						    get = function()
						        return self.db.profile["TSPELL"].r, self.db.profile["TSPELL"].g, self.db.profile["TSPELL"].b
						    end,
						    set = function(r, g, b)
						        self.db.profile["TSPELL"].r, self.db.profile["TSPELL"].g, self.db.profile["TSPELL"].b = r, g, b
						    end
							},
							theal = {
								name = L["ICHeals"],
								type = "color",
						    desc = L["OCHealsD"],
						    order = 3,
						    get = function()
						        return self.db.profile["THEAL"].r, self.db.profile["THEAL"].g, self.db.profile["THEAL"].b
						    end,
						    set = function(r, g, b)
						        self.db.profile["THEAL"].r, self.db.profile["THEAL"].g, self.db.profile["THEAL"].b = r, g, b
						    end
							},
							peto = {
								name = L["EPet"],
								type = "color",
						    desc = L["OCPetD"],
						    order = 4,
						    get = function()
						        return self.db.profile["PETI"].r, self.db.profile["PETI"].g, self.db.profile["PETI"].b
						    end,
						    set = function(r, g, b)
						        self.db.profile["PETI"].r, self.db.profile["PETI"].g, self.db.profile["PETI"].b = r, g, b
						    end
							},
						},
					},
					mcolor = {
						name = L["MColors"],
						desc = L["MColorsD"],
						type = "group",
						order = 3,
						args = {		
							death = {
								name = L["MCDeath"],
								type = "color",
						    desc = L["MCDeathD"],
						    order = 1,
						    get = function()
						        return self.db.profile["DEATH"].r, self.db.profile["DEATH"].g, self.db.profile["DEATH"].b
						    end,
						    set = function(r, g, b)
						        self.db.profile["DEATH"].r, self.db.profile["DEATH"].g, self.db.profile["DEATH"].b = r, g, b
						    end
							},
							misc = {
								name = L["MCMisc"],
								type = "color",
						    desc = L["MCMiscD"],
						    order = 2,
						    get = function()
						        return self.db.profile["MISC"].r, self.db.profile["MISC"].g, self.db.profile["MISC"].b
						    end,
						    set = function(r, g, b)
						        self.db.profile["MISC"].r, self.db.profile["MISC"].g, self.db.profile["MISC"].b = r, g, b
						    end
							},
							exp = {
								name = L["EExperience"],
								type = "color",
						    desc = L["MCExperienceD"],
						    order = 3,
						    get = function()
						        return self.db.profile["EXPC"].r, self.db.profile["EXPC"].g, self.db.profile["EXPC"].b
						    end,
						    set = function(r, g, b)
						        self.db.profile["EXPC"].r, self.db.profile["EXPC"].g, self.db.profile["EXPC"].b = r, g, b
						    end
							},
							rep = {
								name = L["EReputation"],
								type = "color",
						    desc = L["MCReputationD"],
						    order = 4,
						    get = function()
						        return self.db.profile["REPC"].r, self.db.profile["REPC"].g, self.db.profile["REPC"].b
						    end,
						    set = function(r, g, b)
						        self.db.profile["REPC"].r, self.db.profile["REPC"].g, self.db.profile["REPC"].b = r, g, b
						    end
							},
							honor = {
								name = L["EHonor"],
								type = "color",
						    desc = L["MCHonorD"],
						    order = 5,
						    get = function()
						        return self.db.profile["HONORC"].r, self.db.profile["HONORC"].g, self.db.profile["HONORC"].b
						    end,
						    set = function(r, g, b)
						        self.db.profile["HONORC"].r, self.db.profile["HONORC"].g, self.db.profile["HONORC"].b = r, g, b
						    end
							},
							skill = {
								name = L["ESkill"],
								type = "color",
						    desc = L["MCSkillD"],
						    order = 6,
						    get = function()
						        return self.db.profile["SKILLC"].r, self.db.profile["SKILLC"].g, self.db.profile["SKILLC"].b
						    end,
						    set = function(r, g, b)
						        self.db.profile["SKILLC"].r, self.db.profile["SKILLC"].g, self.db.profile["SKILLC"].b = r, g, b
						    end
							},
						}
					},
					framecolor = {
						name = L["MCFrame"],
						type = "color",
				    desc = L["MCFrameD"],
				    order = 4,
				    get = function()
				        return self.db.profile["FRAME"].r, self.db.profile["FRAME"].g, self.db.profile["FRAME"].b, self.db.profile["FRAME"].a
				    end,
				    set = function(r, g, b, a)
				        self.db.profile["FRAME"].r, self.db.profile["FRAME"].g, self.db.profile["FRAME"].b, self.db.profile["FRAME"].a = r, g, b, a
					 			self:PerformDisplayOptions();
				    end,
				    hasAlpha = true;
					},
					bordercolor = {
						name = L["MCBorder"],
						type = "color",
				    desc = L["MCBorderD"],
				    order = 5,
				    get = function()
				        return self.db.profile["BORDER"].r, self.db.profile["BORDER"].g, self.db.profile["BORDER"].b, self.db.profile["BORDER"].a
				    end,
				    set = function(r, g, b, a)
				        self.db.profile["BORDER"].r, self.db.profile["BORDER"].g, self.db.profile["BORDER"].b, self.db.profile["BORDER"].a = r, g, b, a
				        self:PerformDisplayOptions()
				    end,
				    hasAlpha = true;
					},
					labelcolor = {
						name = L["MCLabel"],
						type = "color",
				    desc = L["MCLabelD"],
				    order = 6,
				    get = function()
				        return self.db.profile["LABELC"].r, self.db.profile["LABELC"].g, self.db.profile["LABELC"].b, self.db.profile["LABELC"].a
				    end,
				    set = function(r, g, b, a)
				        self.db.profile["LABELC"].r, self.db.profile["LABELC"].g, self.db.profile["LABELC"].b, self.db.profile["LABELC"].a = r, g, b, a
				        self:PerformDisplayOptions()
				    end,
				    hasAlpha = true;
					},
				},
			},
			
			frame = {
				name = L["Frame"],
				desc = L["Frame"],
				type = "group",
				order = 3,
				args = {		
					lines = {
						name = L["FNumber"], type = "range",
				    desc = L["FNumberD"],
				    order = 1,
				    get = function()
				        return self.db.profile["NUMLINES"]
				    end,
				    set = function(v)
				        self.db.profile["NUMLINES"] = v;
				        self:PerformDisplayOptions();
				        self:UpdateEvents();
				    end,
				    min = 1,
				    max = 20,
				    step = 1
					},
					lineheight = {
						name = L["FHeight"], type = "range",
				    desc = L["FHeightD"],
				    order = 2,
				    get = function()
				        return self.db.profile["LINEHEIGHT"]
				    end,
				    set = function(v)
				        self.db.profile["LINEHEIGHT"] = v;
				        self:PerformDisplayOptions();
				        self:UpdateEvents();
				    end,
				    min = 10,
				    max = 30,
				    step = 1
					},
					linewidth = {
						name = L["FWidth"], type = "range",
				    desc = L["FWidthD"],
				    order = 3,
				    get = function()
				        return self.db.profile["LINEWIDTH"]
				    end,
				    set = function(v)
				        self.db.profile["LINEWIDTH"] = v;
				        self:PerformDisplayOptions();
				        self:UpdateEvents();
				    end,
				    min = 100,
				    max = 400,
				    step = 10
					},
					textsize = {
						name = L["FText"], type = "range",
				    desc = L["FTextD"],
				    order = 4,
				    get = function()
				        return self.db.profile["TEXTSIZE"]
				    end,
				    set = function(v)
				        self.db.profile["TEXTSIZE"] = v;
				        self:UpdateEvents();
				    end,
				    min = 8,
				    max = 24,
				    step = 1
					},
					fade = {
						name = L["FFade"], type = "range",
				    desc = L["FFadeD"],
				    order = 5,
				    get = function()
				        return self.db.profile["FADETIME"]
				    end,
				    set = function(v)
				        self.db.profile["FADETIME"] = v
				    end,
				    min = 0,
				    max = 60,
				    step = 5
					},
					fadeframe = {
						name = L["FFadeFrame"], type = "toggle",
				    desc = L["FFadeFrameD"],
				    order = 6,
				    get = function()
				        return self.db.profile["FADEFRAME"]
				    end,
				    set = function(v)
				        self.db.profile["FADEFRAME"] = v
				        if v ~= true then
				        	self:HideFrame();
				        else
				        	self:ShowFrame();
				        end
				    end,
					},
					lock = {
						name = L["MLock"], type = "toggle",
				    desc = L["MLockD"],
				    order = 7,
				    get = function()
				        return self.db.profile["LOCKED"]
				    end,
				    set = function(v)
				        self.db.profile["LOCKED"] = v;
				        EavesDropFrame:EnableMouse(not self.db.profile["LOCKED"]);
				    end
					},
				},
			},
			misc = {
				name = L["Misc"],
				desc = L["Misc"],
				type = "group",
				order = 4,
				args = {	
					buttons = {
						name = L["MButtons"] , type = "toggle",
				    desc = L["MButtonsD"] ,
				    order = 1,
				    get = function()
				        return self.db.profile["SCROLLBUTTON"]
				    end,
				    set = function(v)
				        self.db.profile["SCROLLBUTTON"] = v;
				        if (v == true) then
				        	EavesDropFrameDownButton:Hide();
									EavesDropFrameUpButton:Hide();
								end
								self:PerformDisplayOptions();
				    end
					},
					details = {
						name = L["MTooltip"], type = "toggle",
				    desc = L["MTooltipD"],
				    order = 2,
				    get = function()
				        return self.db.profile["TOOLTIPS"]
				    end,
				    set = function(v)
				        self.db.profile["TOOLTIPS"] = v;
				        self:UpdateEvents();
				    end
					},
					timestamp = {
						name = L["MTimestamp"], type = "toggle",
				    desc = L["MTimestampD"],
				    order = 2,
				    get = function()
				        return self.db.profile["TIMESTAMP"]
				    end,
				    set = function(v)
				        self.db.profile["TIMESTAMP"] = v;
				        self:UpdateEvents();
				    end,
				    disabled = function() return not self.db.profile["TOOLTIPS"] end,
					},
					flip = {
						name = L["MFlip"], type = "toggle",
				    desc = L["MFlipD"],
				    order = 3,
				    get = function()
				        return self.db.profile["FLIP"]
				    end,
				    set = function(v)
				        self.db.profile["FLIP"] = v;
				        self:PerformDisplayOptions();
				        self:UpdateEvents();
				    end
					},
					placeholder = {
						name = L["MPlace"], type = "toggle",
				    desc = L["MPlaceD"],
				    order = 4,
				    get = function()
				        return self.db.profile["PLACEHOLDER"]
				    end,
				    set = function(v)
				        self.db.profile["PLACEHOLDER"] = v;
				    end
					},
					hfilter = {
						name = L["MHFilter"], type = "range",
				    desc = L["MHFilterD"],
				    order = 5,
				    get = function()
				        return self.db.profile["HFILTER"]
				    end,
				    set = function(v)
				        self.db.profile["HFILTER"] = v
				    end,
				    min = 0,
				    max = 500,
				    step = 25
					},
					mfilter = {
						name = L["MMFilter"], type = "range",
				    desc = L["MMFilterD"],
				    order = 6,
				    get = function()
				        return self.db.profile["MFILTER"]
				    end,
				    set = function(v)
				        self.db.profile["MFILTER"] = v
				    end,
				    min = 0,
				    max = 500,
				    step = 25
					},
				},
			},
			reset = {
				name = L["MReset"], type = 'execute',
		    desc = L["MResetD"],
		    order = 5,
		    func = function()
		        self:Reset();
    		end
			},
		}
	}
end

function EavesDrop:GetDefaultConfig()
	local default = {
		["PHIT"] =  {r = 1.0, g = 0.0, b = 0.0},
		["PMISS"] =  {r = 0.0, g = 0.0, b = 1.0},
		["PHEAL"] =  {r = 0.0, g = 1.0, b = 0.0},
		["PSPELL"] =  {r = 0.5, g = 0.0, b = 0.5},
		["TSPELL"] = {r = 1.0, g = 1.0, b = 0.0},
		["THEAL"] = {r = 0, g = 0.7, b = 0},
		["TMELEE"] = {r = 1.0, g = 1.0, b = 1.0},
		["DEATH"] = {r = 0.6, g = 0.6, b = 0.6},
		["MISC"] = {r = 1, g = 1, b = 1},
		["EXPC"] = {r = .5, g = .7, b = .5},
		["HONORC"] = {r = 0.7, g = 0.5, b = 0.7},
		["REPC"] = {r = 0.5, g = 0.5, b = 1},
		["SKILLC"] = {r = 0, g = 0, b = 1},
		["FRAME"] = {r = 0, g = 0, b = 0, a = 0.33},
		["BORDER"] = {r = 1, g = 1, b = 1, a = 0.75},
		["LABELC"] = {r = 1, g = 1, b = 0, a = 1},
		["PETO"] =  {r = 0.6, g = 0.6, b = 0.0},
		["PETI"] =  {r = 0.6, g = 0.6, b = 0.0},
		["PGAIN"] =  {r = 1.0, g = 1.0, b = 0.0},
		["PBUFF"] =  {r = 0.7, g = 0.7, b = 0.0},
		["PDEBUFF"] =  {r = 0.0, g = 0.5, b = 0.5},
		["NUMLINES"] = 10,
		["FADETIME"] = 10,
		["LINEHEIGHT"] = 20,
		["LINEWIDTH"] = 160,
		["HFILTER"] = 0,
		["MFILTER"] = 0,
		["SPELLCOLOR"] = true,
		["EXP"] = true,
		["HONOR"] = true,
		["REP"] = true,
		["SKILL"] = false,
		["COMBAT"] = true,
		["GAINS"] = false,
		["BUFFS"] = false,
		["DEBUFFS"] = false,
		["FADE"] = false,
		["PET"] = false,
		["SCROLLBUTTON"] = false,
		["TOOLTIPS"] = true,
		["TIMESTAMP"] = true;
		["LOCKED"] = false,
		["FADEFRAME"] = false,
		["FLIP"] = false,
		["OVERHEAL"] =  false,
		["HEALERID"] = false,
		["PLACEHOLDER"] = false,
		["TEXTSIZE"] = 14,
	}
	return default
end
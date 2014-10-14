--Options Functions

local AsmoMODOptionsButton_BeingDragged = false;

function AsmoMODOptionsButton_OnDragStart()
	if (not AsmoMODOptionsButton_BeingDragged) then
		AsmoMOD_Button:StartMoving();
		AsmoMODOptionsButton_BeingDragged = true;
	end
end

function AsmoMODOptionsButton_OnDragStop()
	if (AsmoMODOptionsButton_BeingDragged) then
		AsmoMOD_Button:StopMovingOrSizing()
		AsmoMODOptionsButton_BeingDragged = false;
	end
end

function AsmoMOD_ToggleDropDown()
	if (AsmoMODOptions:IsVisible()) then
	   AsmoMODOptions:Hide();
	elseif (not AsmoMODOptions:IsVisible()) then
	   AsmoMOD_showMenu();
	end
end

function AsmoMOD_PercentageChanged()
	AsmoMOD_Save.nspercent = this:GetValue();
	AsmoMOD_SavedLoad[AsmoMOD.PROFILE].nspercent = AsmoMOD_Save.nspercent;
	nstext:SetText("NSHeal Percent: ".. AsmoMOD_Save.nspercent .. "%");
end

function AsmoMOD_ConserveChanged()
	AsmoMOD_Save.conservepercent = this:GetValue();
	AsmoMOD_SavedLoad[AsmoMOD.PROFILE].conservepercent = AsmoMOD_Save.conservepercent;
	conservetext:SetText("Conserve Percent: ".. AsmoMOD_Save.conservepercent .. "%");
end

function AsmoMOD_ConserveTimeChanged()
	AsmoMOD_Save.conservedelay = this:GetValue();
	AsmoMOD_SavedLoad[AsmoMOD.PROFILE].conservedelay = AsmoMOD_Save.conservedelay;
	conservetimetext:SetText("Conserve Delay: ".. string.format("%0.1f", AsmoMOD_Save.conservedelay) .. "s");
end

function AsmoMOD_RestimeChanged()
	AsmoMOD_Save.reztime = this:GetValue();
	AsmoMOD_SavedLoad[AsmoMOD.PROFILE].reztime = AsmoMOD_Save.reztime;
	restext:SetText("Ress Delay: ".. AsmoMOD_Save.reztime .. " seconds");
end

function AsmoMOD_SummontimeChanged()
	AsmoMOD_Save.sumtime = this:GetValue();
	AsmoMOD_SavedLoad[AsmoMOD.PROFILE].sumtime = AsmoMOD_Save.sumtime;
	summontext:SetText("Summ Delay: ".. AsmoMOD_Save.sumtime .. " seconds");
end

function AsmoMOD_BGtimeChanged()
	AsmoMOD_Save.bgtime = this:GetValue();
	AsmoMOD_SavedLoad[AsmoMOD.PROFILE].bgtime = AsmoMOD_Save.bgtime;
	bgtext:SetText("BG Delay: ".. AsmoMOD_Save.bgtime .. " seconds");
end

function AsmoMOD_SwiftPercentChanged()
	AsmoMOD_Save.swiftpercent = this:GetValue();
	AsmoMOD_SavedLoad[AsmoMOD.PROFILE].swiftpercent = AsmoMOD_Save.swiftpercent;
	swifttext:SetText("Conserve Percent: ".. AsmoMOD_Save.swiftpercent .. "%");
end

function AsmoMOD_EmerPercentChanged()
	AsmoMOD_Save.emerpercent = this:GetValue();
	AsmoMOD_SavedLoad[AsmoMOD.PROFILE].emerpercent = AsmoMOD_Save.emerpercent;
	emertext:SetText("Emergency Percent: ".. AsmoMOD_Save.emerpercent .. "%");
end

function AsmoMOD_ExecuteRageChanged()
	AsmoMOD_Save.executerage = this:GetValue();
	AsmoMOD_SavedLoad[AsmoMOD.PROFILE].executerage = AsmoMOD_Save.executerage;
	executetext:SetText("Execute Ceiling: ".. AsmoMOD_Save.executerage);
end

-- Various Toggle Functions
function AsmoMOD_RezToggle()
	if ( AsmoMOD_Save.rezenabled ) then
		AsmoMOD_Save.rezenabled = false;
		AsmoMOD_ChatR("Auto Ressurect has been disabled.");
	else
		AsmoMOD_Save.rezenabled = true;
		AsmoMOD_Chat("Auto Ressurect has been enabled.");
	end
	AsmoMOD_SavedLoad[AsmoMOD.PROFILE].rezenabled = AsmoMOD_Save.rezenabled;
end

function AsmoMOD_SummonToggle()
	if ( AsmoMOD_Save.summonenabled ) then
		AsmoMOD_Save.summonenabled = false;
		AsmoMOD_ChatR("Auto Summon has been disabled.");
	else
		AsmoMOD_Save.summonenabled = true;
		AsmoMOD_Chat("Auto Summon has been enabled.");
	end
	AsmoMOD_SavedLoad[AsmoMOD.PROFILE].summonenabled = AsmoMOD_Save.summonenabled;
end

function AsmoMOD_bgreltoggle()
	if ( AsmoMOD_Save.bgrelenabled ) then
		AsmoMOD_Save.bgrelenabled = false;
		AsmoMOD_ChatR("Auto BG Release has been disabled.");
	else
		AsmoMOD_Save.bgrelenabled = true;
		AsmoMOD_Chat("Auto BG Release has been enabled.");
	end
	AsmoMOD_SavedLoad[AsmoMOD.PROFILE].bgrelenabled = AsmoMOD_Save.bgrelenabled;
end


function AsmoMOD_bgjointoggle()
	if ( AsmoMOD_Save.bgjoinenabled ) then
		AsmoMOD_Save.bgjoinenabled = false;
		AsmoMOD_ChatR("Auto BG Join has been disabled.");
	else
		AsmoMOD_Save.bgjoinenabled = true;
		AsmoMOD_Chat("Auto BG Join has been enabled.");
	end
	AsmoMOD_SavedLoad[AsmoMOD.PROFILE].bgjoinenabled = AsmoMOD_Save.bgjoinenabled;
end

function AsmoMOD_repairtoggle()
	if ( AsmoMOD_Save.repairenabled ) then
		AsmoMOD_Save.repairenabled = false;
		AsmoMOD_ChatR("Auto Repair has been disabled.");
	else
		AsmoMOD_Save.repairenabled = true;
		AsmoMOD_Chat("Auto Repair has been enabled.");
	end
	AsmoMOD_SavedLoad[AsmoMOD.PROFILE].repairenabled = AsmoMOD_Save.repairenabled;
end

function AsmoMOD_grouptoggle()
	if ( AsmoMOD_Save.groupenabled ) then
		AsmoMOD_Save.groupenabled = false;
		AsmoMOD_ChatR("Auto-accept invites has been disabled.");
	else
		AsmoMOD_Save.groupenabled = true;
		AsmoMOD_Chat("Auto-accept invites has been enabled.");
	end
	AsmoMOD_SavedLoad[AsmoMOD.PROFILE].groupenabled = AsmoMOD_Save.groupenabled;
end

function AsmoMOD_trinkettoggle()
	if ( AsmoMOD_Save.trinketenabled ) then
		AsmoMOD_Save.trinketenabled = false;
		AsmoMOD_ChatR("Auto-break has been totally disabled.");
	else
		AsmoMOD_Save.trinketenabled = true;
		AsmoMOD_Chat("Auto-break has been enabled.");
	end
	AsmoMOD_SavedLoad[AsmoMOD.PROFILE].trinketenabled = AsmoMOD_Save.trinketenabled;
end

function AsmoMOD_ripostetoggle()
	if ( AsmoMOD_Save.riposteenabled ) then
		AsmoMOD_Save.riposteenabled = false;
		AsmoMOD_ChatR("Auto-use of riposte has been disabled.");
	else
		AsmoMOD_Save.riposteenabled = true;
		AsmoMOD_Chat("Auto-use of riposte has been enabled.");
	end
	AsmoMOD_SavedLoad[AsmoMOD.PROFILE].riposteenabled = AsmoMOD_Save.riposteenabled;
end

function AsmoMOD_executetoggle()
	if ( AsmoMOD_Save.executeenabled ) then
		AsmoMOD_Save.executeenabled = false;
		AsmoMOD_ChatR("Auto-use of execute has been disabled.");
	else
		AsmoMOD_Save.executeenabled = true;
		AsmoMOD_Chat("Auto-use of execute has been enabled.");
	end
	AsmoMOD_SavedLoad[AsmoMOD.PROFILE].executeenabled = AsmoMOD_Save.executeenabled;
end

function AsmoMOD_nshealtoggle()
	if ( AsmoMOD_Save.nsenabled ) then
		AsmoMOD_Save.nsenabled = false;
		AsmoMOD_ChatR("Auto-use of nsheal has been disabled.");
	else
		AsmoMOD_Save.nsenabled = true;
		AsmoMOD_Chat("Auto-use of nsheal has been enabled.");
	end
	AsmoMOD_SavedLoad[AsmoMOD.PROFILE].nsenabled = AsmoMOD_Save.nsenabled;
end

function AsmoMOD_conservetoggle()
	if ( AsmoMOD_Save.conserveenabled ) then
		AsmoMOD_Save.conserveenabled = false;
		AsmoMOD_ChatR("Auto-cancelling of heals has been disabled.");
	else
		AsmoMOD_Save.conserveenabled = true;
		AsmoMOD_Chat("Auto-cancelling of heals has been enabled.");
	end
	AsmoMOD_SavedLoad[AsmoMOD.PROFILE].conserveenabled = AsmoMOD_Save.conserveenabled;
end

function AsmoMOD_herbminetoggle()
	if ( AsmoMOD_Save.herbmineenabled ) then
		AsmoMOD_Save.herbmineenabled = false;
		AsmoMOD_ChatR("Auto-casting of find herbs/minerals has been disabled.");
	else
		AsmoMOD_Save.herbmineenabled = true;
		if(AsmoMOD_Save.findgemenabled) then
			AsmoMOD_Save.findgemenabled = false;
			AsmoMOD_SavedLoad[AsmoMOD.PROFILE].findgemenabled = AsmoMOD_Save.findgemenabled;
			AsmoMOD_ChatR("Auto-casting of Find Treasure is disabled.");
			findgemenabled:SetChecked(0);
		end
		AsmoMOD_Chat("Auto-casting of find herbs/minerals has been enabled.");
		
	end
	AsmoMOD_SavedLoad[AsmoMOD.PROFILE].herbmineenabled = AsmoMOD_Save.herbmineenabled;
end

function AsmoMOD_overpowertoggle()
	if ( AsmoMOD_Save.overpowerenabled ) then
		AsmoMOD_Save.overpowerenabled = false;
		AsmoMOD_ChatR("Auto-casting of overpower has been disabled.");
	else
		AsmoMOD_Save.overpowerenabled = true;
		AsmoMOD_Chat("Auto-casting of overpower has been enabled.");
	end
	AsmoMOD_SavedLoad[AsmoMOD.PROFILE].overpowerenabled = AsmoMOD_Save.overpowerenabled;
end

function AsmoMOD_feartoggle()
	if ( AsmoMOD_Save.fearenabled ) then
		AsmoMOD_Save.fearenabled = false;
		AsmoMOD_ChatR("Auto-casting of break effects when you are feared is disabled.");
	else
		AsmoMOD_Save.fearenabled = true;
		AsmoMOD_Chat("Auto-casting of break effects when you are feared is enabled.");
	end
	AsmoMOD_SavedLoad[AsmoMOD.PROFILE].fearenabled = AsmoMOD_Save.fearenabled;
end

function AsmoMOD_entangletoggle()
	if ( AsmoMOD_Save.entangleenabled ) then
		AsmoMOD_Save.entangleenabled = false;
		AsmoMOD_ChatR("Auto-Break will no longer break out of immobilization effects (Root, Frost Nova, etc.)");
	else
		AsmoMOD_Save.entangleenabled = true;
		AsmoMOD_Chat("Auto-Break will now break out of immobilization effects (Root, Frost Nova, etc.)");
	end
	AsmoMOD_SavedLoad[AsmoMOD.PROFILE].entangleenabled = AsmoMOD_Save.entangleenabled;
end

function AsmoMOD_impairtoggle()
	if ( AsmoMOD_Save.impairenabled ) then
		AsmoMOD_Save.impairenabled = false;
		AsmoMOD_ChatR("Auto-Break will no longer break out of impairment effects (Crippling Poison, Hamstring, etc.)");
	else
		AsmoMOD_Save.impairenabled = true;
		AsmoMOD_Chat("Auto-Break will now break out of impairment effects (Crippling Poison, Hamstring, etc.)");
	end
	AsmoMOD_SavedLoad[AsmoMOD.PROFILE].impairenabled = AsmoMOD_Save.impairenabled;
end

function AsmoMOD_escapetoggle()
	if ( AsmoMOD_Save.escapeenabled ) then
		AsmoMOD_Save.escapeenabled = false;
		AsmoMOD_ChatR("Auto-casting of Escape Artist to break impairment/immobilizing effects is disabled.");
	else
		AsmoMOD_Save.escapeenabled = true;
		AsmoMOD_Chat("Auto-casting of Escape Artist to break impairment/immobilizing effects is enabled.");
	end
	AsmoMOD_SavedLoad[AsmoMOD.PROFILE].escapeenabled = AsmoMOD_Save.escapeenabled;
end

function AsmoMOD_berserktoggle()
	if ( AsmoMOD_Save.zerkenabled ) then
		AsmoMOD_Save.zerkenabled = false;
		AsmoMOD_ChatR("Auto-casting of Berserker Rage to break fear effects is disabled.");
	else
		AsmoMOD_Save.zerkenabled = true;
		AsmoMOD_Chat("Auto-casting of Berserker Rage to break fear effects is enabled.");
	end
	AsmoMOD_SavedLoad[AsmoMOD.PROFILE].zerkenabled = AsmoMOD_Save.zerkenabled;
end

function AsmoMOD_wotftoggle()
	if ( AsmoMOD_Save.wotfenabled ) then
		AsmoMOD_Save.wotfenabled = false;
		AsmoMOD_ChatR("Auto-casting of Wotf to break fear effects is disabled.");
	else
		AsmoMOD_Save.wotfenabled = true;
		AsmoMOD_Chat("Auto-casting of Wotf to break fear effects is enabled.");
	end
	AsmoMOD_SavedLoad[AsmoMOD.PROFILE].wotfenabled = AsmoMOD_Save.wotfenabled;
end

function AsmoMOD_autoswifttoggle()
	if ( AsmoMOD_Save.autoswiftenabled ) then
		AsmoMOD_Save.autoswiftenabled = false;
		AsmoMOD_ChatR("Swiftmend conserve is disabled.");
	else
		AsmoMOD_Save.autoswiftenabled = true;
		AsmoMOD_Chat("Swiftmend conserve is enabled.");
	end
	AsmoMOD_SavedLoad[AsmoMOD.PROFILE].autoswiftenabled = AsmoMOD_Save.autoswiftenabled;
end

function AsmoMOD_emerswifttoggle()
	if ( AsmoMOD_Save.emerswiftenabled ) then
		AsmoMOD_Save.emerswiftenabled = false;
		AsmoMOD_ChatR("Emergency casting of swiftmend if target is below a set hp % is disabled.");
	else
		AsmoMOD_Save.emerswiftenabled = true;
		AsmoMOD_Chat("Emergency casting of swiftmend if target is below a set hp % is enabled.");
	end
	AsmoMOD_SavedLoad[AsmoMOD.PROFILE].emerswiftenabled = AsmoMOD_Save.emerswiftenabled;
end

function AsmoMOD_stonetoggle()
	if ( AsmoMOD_Save.stoneenabled ) then
		AsmoMOD_Save.stoneenabled = false;
		AsmoMOD_ChatR("Auto-casting of Stoneform to break immobilization is disabled.");
	else
		AsmoMOD_Save.stoneenabled = true;
		AsmoMOD_Chat("Auto-casting of Stoneform to break immobilization is enabled.");
	end
	AsmoMOD_SavedLoad[AsmoMOD.PROFILE].stoneenabled = AsmoMOD_Save.stoneenabled;
end


function AsmoMOD_findgemtoggle()
	if ( AsmoMOD_Save.findgemenabled ) then
		AsmoMOD_Save.findgemenabled = false;
		AsmoMOD_ChatR("Auto-casting of Find Treasure is disabled.");
	else
		AsmoMOD_Save.findgemenabled = true;
		if(AsmoMOD_Save.herbmineenabled) then
			AsmoMOD_Save.herbmineenabled = false;
			AsmoMOD_SavedLoad[AsmoMOD.PROFILE].herbmineenabled = AsmoMOD_Save.herbmineenabled;
			AsmoMOD_ChatR("Auto-casting of find herbs/minerals has been disabled.");
			herbmineenabled:SetChecked(0);
		end
		AsmoMOD_Chat("Auto-casting of Find Treasure is enabled.");
	end
	AsmoMOD_SavedLoad[AsmoMOD.PROFILE].findgemenabled = AsmoMOD_Save.findgemenabled;
end


function AsmoMOD_monitortoggle()
	if ( AsmoMOD_Save.monitorenabled ) then
		AsmoMOD_Save.monitorenabled = false;
		AsmoMOD_ChatR("Swiftmend monitor parsing is disabled.");
	else
		AsmoMOD_Save.monitorenabled = true;
		AsmoMOD_Chat("Swiftmend monitor parsing is enabled.");
	end
	AsmoMOD_SavedLoad[AsmoMOD.PROFILE].monitorenabled = AsmoMOD_Save.monitorenabled;
end

function AsmoMOD_playerswfitontoggle()
	if ( AsmoMOD_Save.playerswiftonenabled ) then
		AsmoMOD_Save.playerswiftonenabled = false;
		AsmoMOD_ChatR("Emergency casting of swiftmend on other players is disabled.");
	else
		AsmoMOD_Save.playerswiftonenabled = true;
		AsmoMOD_Chat("Emergency casting of swiftmend on other players is enabled.");
	end
	AsmoMOD_SavedLoad[AsmoMOD.PROFILE].playerswiftonenabled = AsmoMOD_Save.playerswiftonenabled;
end

function AsmoMOD_friendguildtoggle()
	if ( AsmoMOD_Save.groupfriendonly ) then
		AsmoMOD_Save.groupfriendonly = false;
		AsmoMOD_ChatR("Auto group will now accept party invites from anyone.");
	else
		AsmoMOD_Save.groupfriendonly = true;
		AsmoMOD_Chat("Auto group will now only accept party invites from friends or guildmates.");
	end
	AsmoMOD_SavedLoad[AsmoMOD.PROFILE].groupfriendonly = AsmoMOD_Save.groupfriendonly;
end

function AsmoMOD_stuntoggle()
	if ( AsmoMOD_Save.stunenabled ) then
		AsmoMOD_Save.stunenabled = false;
		AsmoMOD_ChatR("Auto-Break will no longer break stun effects (Kidney Shot, Bash, etc).");
	else
		AsmoMOD_Save.stunenabled = true;
		AsmoMOD_Chat("Auto-Break will now  break stun effects (Kidney Shot, Bash, etc).");
	end
	AsmoMOD_SavedLoad[AsmoMOD.PROFILE].stunenabled = AsmoMOD_Save.stunenabled;
end

function AsmoMOD_charmtoggle()
	if ( AsmoMOD_Save.charmenabled ) then
		AsmoMOD_Save.charmenabled = false;
		AsmoMOD_ChatR("Auto-Break will no longer break charm effects (Mind Control, Seduction, etc).");
	else
		AsmoMOD_Save.charmenabled = true;
		AsmoMOD_Chat("Auto-Break will now break charm effects (Mind Control, Seduction, etc).");
	end
	AsmoMOD_SavedLoad[AsmoMOD.PROFILE].charmenabled = AsmoMOD_Save.charmenabled;
end

function AsmoMOD_polymorphtoggle()
	if ( AsmoMOD_Save.polymorphenabled ) then
		AsmoMOD_Save.polymorphenabled = false;
		AsmoMOD_ChatR("Auto-Break will no longer break polymorph effects.");
	else
		AsmoMOD_Save.polymorphenabled = true;
		AsmoMOD_Chat("Auto-Break will now break polymorph effects.");
	end
	AsmoMOD_SavedLoad[AsmoMOD.PROFILE].polymorphenabled = AsmoMOD_Save.polymorphenabled;
end

function AsmoMOD_countertoggle()
	if ( AsmoMOD_Save.counterenabled ) then
		AsmoMOD_Save.counterenabled = false;
		AsmoMOD_ChatR("Auto-casting of Counterattack has been disabled.");
	else
		AsmoMOD_Save.counterenabled = true;
		AsmoMOD_Chat("Auto-casting of Counterattack has been enabled.");
	end
	AsmoMOD_SavedLoad[AsmoMOD.PROFILE].counterenabled = AsmoMOD_Save.counterenabled;
end

function AsmoMOD_nscombattoggle()
	if ( AsmoMOD_Save.nscombatenabled ) then
		AsmoMOD_Save.nscombatenabled = false;
		AsmoMOD_ChatR("Auto-NSheal will now cast out of combat.");
	else
		AsmoMOD_Save.nscombatenabled = true;
		AsmoMOD_Chat("Auto-NSheal will now only cast in combat");
	end
	AsmoMOD_SavedLoad[AsmoMOD.PROFILE].nscombatenabled = AsmoMOD_Save.nscombatenabled;
end


-- Enable or Disable the minimap button
function AsmoMOD_MinimapToggle()
	if(AsmoMOD_Save.minimapenabled) then
		AsmoMOD_SetsFrame:Hide();
		AsmoMOD_Save.minimapenabled = false;
		AsmoMOD_ChatR("Mini-map button disabled, to re-enable type /asmomap or use the options menu");
	else
		AsmoMOD_SetsFrame:Show();
		AsmoMOD_Save.minimapenabled = true;
		AsmoMOD_Chat("Mini-map button enabled.");
	end
	AsmoMOD_SavedLoad[AsmoMOD.PROFILE].minimapenabled = AsmoMOD_Save.minimapenabled;
end
local oldEnergy = 0; --saves the energy from tick to tick
local Update = 0;	--saves the time from update to update
local ET_Target = nil; --global ET_Target

function ET_OnLoad() --Returns VOID: Called on program start
	local _, Class = UnitClass('player'); --get their unregionalized class name
	if (Class == 'ROGUE' or Class == 'DRUID') then
		DEFAULT_CHAT_FRAME:AddMessage('<< EnergyTick by Lelek Loaded! >>'); --shows that et loaded
		if (not ET_Toggle) then ET_Toggle=1; end	--if its the first time running set up our variable
		--Register our Events
		this:RegisterEvent('UNIT_ENERGY');			--its the tick in EnergyTick
		this:RegisterEvent('VARIABLES_LOADED');		--when the variables load it ticks once
		this:RegisterEvent('PLAYER_TARGET_CHANGED'); --awsome for figuring out when to tick and when not to
		--Set up slash commands
		SlashCmdList['ETCHAT'] = function() 
			if (ET_Toggle == 1) then ET_Toggle = 0; DEFAULT_CHAT_FRAME:AddMessage('<<ET is Off!');
			else ET_Toggle = 1; DEFAULT_CHAT_FRAME:AddMessage('<<ET is On!');
			end
		end
		SLASH_ETCHAT1 = '/et'; SLASH_ETCHAT2 = '/energytick'; --two slash commands
	else
		DEFAULT_CHAT_FRAME:AddMessage('<< EnergyTick not loaded! You have no energy! >>'); --shows that et loaded
		HideUIPanel(ET_Update_Frame); this:Hide(); return;
	end
end

function ET_DoTick() --RETURN VOID: Will check all the conditions to tick
	if (ET_Toggle==1 and ET_Target) then
		local _, Class = UnitClass('player');
		if ( (Class=='ROGUE') or (Class=='DRUID' and UnitPowerType('player')==3) ) then
			PlaySoundFile('Interface\\AddOns\\EnergyTick\\Tick.wav');
		end
	end	
end

function ET_OnEvent(event,arg1) --Returns VOID: Called on event
	if (event == 'PLAYER_TARGET_CHANGED') then	--they switched targets see if we should tick
		if (UnitExists('target') and (not UnitIsDead('target')) and UnitCanAttack('player', 'target')) then
			ET_Target = 1;		--We have a target save it in global ET_Target
		else
			ET_Target = nil;	--We dont have a target save it
		end
	else
		if (not oldEnergy) then oldEnergy = UnitMana('player'); end --Instantiate oldEnergy if its not
		if (UnitMana('player') > oldEnergy) then				--If gained energy then it has ticked
			if (UnitMana('player') == UnitManaMax('player')) then	--Energy full use updates
				ET_Update_Frame:Show();						--UseUpdates
			else										--player has < full energy
				ET_Update_Frame:Hide(); Update = 0;		--UNIT_ENERGY will tick us now; Zero out update
			end
			ET_DoTick();				--Tick if we can
		end
		oldEnergy = UnitMana('player');	--set current Energy to the oldEnergy for use next tick
	end
end

function ET_OnUpdate(arg1)	--RETURN VOID: This keeps updateing every 2 sec to tick
	Update = Update + arg1;		--Make time elasped
	if (Update >= 2) then		--Ticks happen every 2 sec
		Update = Update - 2;	--Remaining time left over to ensure even rate
		if (UnitMana('player') == UnitManaMax('player')) then  --if the mana is maxed out
			ET_DoTick(); --tick if we can
		end 
	end
end
-- -------------------------------------------
--            << Power Auras >>
--              Par -Sinsthar-
--    [Ziya/Tiven - serveur Fr - Kirin Tor] 
--
--     Effets visuels autour du personnage 
--     en cas de buff ou de debuff.
-- -------------------------------------------

PowaVersion = "v2.10"

CurrentAura = 1;
CurrentSecondeAura = 0;
MaxAuras = 20;
SecondeAura = MaxAuras + 1;
CurrentTestAura = MaxAuras + 2;

PowaEnabled = 0;
PowaModTest = false; -- on test les effets

Powa_FramesVisibleTime = {}; -- visible ou pas

PowaMisc = {
		disabled = false,
		maxeffects = 100,
		BTimerX = 0,
		BTimerY = 0,
		BTimerA = 1.00,
		BTimerScale = 1.00,
		BCents = true,
		Bdual = false,
		DTimerX = 0,
		DTimerY = 0,
		DTimerA = 1.00,
		DTimerScale = 1.00,
		DCents = true,
		Ddual = false
	   };

PowaGlobal = {maxtextures = 15}

PowaSet = {};
for i = 1, SecondeAura do
	PowaSet[i] = {
		texture = 1,
		icon = "",
		anim1 = 1,
		anim2 = 0,
		speed = 1.00,
		begin = 0,
		finish = 1,
		duration = 0,
		alpha = 0.75,
		size = 0.75,
		torsion = 1,
		symetrie = 0,
		x = 0,
		y = -30,
		buffname = "",
		isdebuff = false,
		isdebufftype = false,
		timer = false,
		inverse = false,
		ignoremaj = true,
		r = 1.0,
		g = 1.0,
		b = 1.0
	};
end

TabBuff = {};        -- liste des buffs en cours
TabDebuff = {};      -- debuffs
TabDebuffType = {};  -- debuff types

-- checks des buffs
DoCheckBuffs = false;

ChecksTimer = 0;  -- [mode lourd]
NextCheck = 0.5; -- {mode lourd] nombre de secondes entre les checks


-- ---------------------------------------------------------------------------------------------

function Powa_OnLoad()

	-- Registering Events -- 
	this:RegisterEvent("PLAYER_AURAS_CHANGED");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("VARIABLES_LOADED");

	Powa_Frames = {};
	Powa_textures = {};

	-- options init
	SlashCmdList["POWA"] = Powa_SlashHandler;
	SLASH_POWA1 = "/powa";
end

function PowaDebug(msg)
	DEFAULT_CHAT_FRAME:AddMessage(msg);
end

function PowaDebug2(msg)
	getglobal("PowaDebugMessagesText"):SetText(msg);
end

-- ----------------------------------------------------------------------------------------------

function Powa_InitTabs()
	for i = 1, CurrentTestAura do
		if (PowaSet[i]) then -- gere les rajout de variables suivant les versions
			if (PowaSet[i].timer == nil) then PowaSet[i].timer = false; end
			if (PowaSet[i].inverse == nil) then PowaSet[i].inverse = false; end
			if (PowaSet[i].ignoremaj == nil) then PowaSet[i].ignoremaj = true; end
			if (PowaSet[i].speed == nil) then PowaSet[i].speed = 1.0; end
			if (PowaSet[i].begin == nil) then PowaSet[i].begin = 0; end
			if (PowaSet[i].finish == nil) then PowaSet[i].finish = 1; end
			if (PowaSet[i].duration == nil) then PowaSet[i].duration = 0; end
			if (PowaSet[i].icon == nil) then PowaSet[i].icon = ""; end
		else    -- pas init
			PowaSet[i] = {
				texture = 1,
				icon = "",
				anim1 = 1,
				anim2 = 0,
				speed = 1.00,
				begin = 0,
				finish = 1,
				duration = 0,
				alpha = 0.75,
				size = 0.75,
				torsion = 1,
				symetrie = 0,
				x = 0,
				y = -30,
				buffname = "",
				isdebuff = false,
				isdebufftype = false,
				timer = false,
				inverse = false,
				ignoremaj = true,
				r = 1.0,
				g = 1.0,
				b = 1.0	}
			Powa_FramesVisibleTime[i] = 0;
		end		
	end
	if (PowaMisc) then
		if (PowaMisc.BTimerX == nil) then PowaMisc.BTimerX = 0; end
		if (PowaMisc.BTimerY == nil) then PowaMisc.BTimerY = 0; end
		if (PowaMisc.BTimerA == nil) then PowaMisc.BTimerA = 1.00; end
		if (PowaMisc.BTimerScale == nil) then PowaMisc.BTimerScale = 1.00; end
		if (PowaMisc.DTimerX == nil) then PowaMisc.DTimerX = 0; end
		if (PowaMisc.DTimerY == nil) then PowaMisc.DTimerY = 0; end
		if (PowaMisc.DTimerA == nil) then PowaMisc.DTimerA = 1.00; end
		if (PowaMisc.DTimerScale == nil) then PowaMisc.DTimerScale = 1.00; end
		if (PowaMisc.BCents == nil) then PowaMisc.BCents = true; end
		if (PowaMisc.DCents == nil) then PowaMisc.DCents = true; end
		if (PowaMisc.Bdual == nil) then PowaMisc.Bdual = false; end
		if (PowaMisc.Ddual == nil) then PowaMisc.Ddual = false; end
		if (PowaMisc.maxeffects == nil) then PowaMisc.maxeffects = 100; end
	else
		PowaMisc.disabled = false;
		PowaMisc.maxeffects = 10;
		PowaMisc.BTimerX = 0;
		PowaMisc.BTimerY = 0;
		PowaMisc.BTimerA = 1.00;
		PowaMisc.BTimerScale = 1.00;
		PowaMisc.DTimerX = 0;
		PowaMisc.DTimerY = 0;
		PowaMisc.DTimerA = 1.00;
		PowaMisc.DTimerScale = 1.00;
		PowaMisc.BCents = true;
		PowaMisc.DCents = true;
		PowaMisc.Bdual = false;
		PowaMisc.Ddual = false;
	end
end

-- -----------------------------------------------------------------------------------------------

function Powa_CreateFrames()

  for i = 1, CurrentTestAura do
    if (Powa_Frames[i]) then
    	-- deja cree, ne fait rien
    else
    	-- Frame -- 
    	Powa_Frames[i] = CreateFrame("Frame","Frame"..i);
    	Powa_Frames[i]:Hide();  

    	-- Texture --
    	Powa_textures[i] = Powa_Frames[i]:CreateTexture(nil,"BACKGROUND");
    	Powa_textures[i]:SetBlendMode("ADD");

    	Powa_textures[i]:SetAllPoints(Powa_Frames[i]); -- attache la texture a la frame
    	Powa_Frames[i].texture = Powa_textures[i];
 	Powa_Frames[i].baseL = 256;
	Powa_Frames[i].baseH = 256;

    	Powa_FramesVisibleTime[i] = 0;
    end
  end
  
end

Powa_Timer = {};
Powa_timertex = {};
Tstep = 0.09765625;

function Powa_CreateTimer()
    for i = 1, 4 do
	if (Powa_Timer[i]) then
	else
		Powa_Timer[i] = CreateFrame("Frame","Timer"..i);
		Powa_Timer[i]:Hide(); 

	    	Powa_timertex[i] = Powa_Timer[i]:CreateTexture(nil,"BACKGROUND");
    		Powa_timertex[i]:SetBlendMode("ADD");

	    	Powa_timertex[i]:SetAllPoints(Powa_Timer[i]); -- attache la texture a la frame
    		Powa_Timer[i].texture = Powa_timertex[i];

		Powa_timertex[i]:SetTexture("Interface\\Addons\\PowerAuras\\timers.tga");
	end
    end
    Powa_UpdateOptionsTimer();
    Powa_UpdateOptionsTimer2();
end

-- ------------------------------------------------------------------------------------ BUFF CHECKS

function Powa_MemorizeBuffs() -- cree un string contenant tous les noms des buffs en cours
	local buffIndex, untilCancelled;
	for i = 1, 24 do
		TabBuff[i] = "xXx";
		buffIndex, untilCancelled = GetPlayerBuff(i-1, "HELPFUL");
		if (buffIndex >= 0) then
			Powa_Tooltip:SetPlayerBuff(buffIndex);
			if (Powa_TooltipTextLeft1:IsShown()) then
				TabBuff[i] = Powa_TooltipTextLeft1:GetText();
			else                                                    
				Powa_Tooltip:SetOwner(UIParent, "ANCHOR_NONE"); -- ERROR !! Ca ne doit jamais arriver ca
				Powa_Tooltip:SetPlayerBuff(buffIndex);
				if (Powa_TooltipTextLeft1:IsShown()) then
					TabBuff[i] = Powa_TooltipTextLeft1:GetText();
				end
			end
		end
	end
	for i = 1, 16 do
		TabDebuff[i] = "xXx";
		TabDebuffType[i] = "xXx";
		buffIndex, untilCancelled = GetPlayerBuff(i-1, "HARMFUL");
		if (buffIndex >= 0) then
			Powa_Tooltip:SetPlayerBuff(buffIndex);
			if (Powa_TooltipTextLeft1:IsShown()) then
				TabDebuff[i] = Powa_TooltipTextLeft1:GetText();
				if (Powa_TooltipTextRight1:IsShown()) then
					TabDebuffType[i] = Powa_TooltipTextRight1:GetText();
				else
					TabDebuffType[i] = PowaText.aucun;
				end
			else                                                    
				Powa_Tooltip:SetOwner(UIParent, "ANCHOR_NONE"); -- ERROR !! Ca ne doit jamais arriver ca
				Powa_Tooltip:SetPlayerBuff(buffIndex);
				if (Powa_TooltipTextLeft1:IsShown()) then
					TabDebuff[i] = Powa_TooltipTextLeft1:GetText();
					if (Powa_TooltipTextRight1:IsShown()) then
						TabDebuffType[i] = Powa_TooltipTextRight1:GetText();
					else
						TabDebuffType[i] = PowaText.aucun;
					end
				end
			end
		end
	end
end

function PowaCompareBuffDebuff(xnum)
	if (PowaSet[xnum].isdebuff) then -- un debuff
		for i = 1, 16 do
			Powa_Frames[xnum].buffindex = 0;
			for pword in string.gfind(PowaSet[xnum].buffname, "[^/]+") do
				if ( (PowaSet[xnum].ignoremaj == true and string.find(string.upper(TabDebuff[i]), string.upper(pword), 1, true)) 
				or   (PowaSet[xnum].ignoremaj == false and string.find(TabDebuff[i], pword, 1, true)) ) then
					Powa_Frames[xnum].buffindex = i-1; -- point vers le debuff qui a le timer
					if (PowaSet[xnum].icon == "") then 
					  PowaSet[xnum].icon = GetPlayerBuffTexture( GetPlayerBuff(Powa_Frames[xnum].buffindex, "HARMFUL") ); 
					end -- icone
					return true;
				end
			end
		end
	elseif (PowaSet[xnum].isdebufftype) then -- type de debuff (cherche a l'inverse)
		for i = 1, 16 do
			if ( (PowaSet[xnum].ignoremaj == true and string.find(string.upper(PowaSet[xnum].buffname), string.upper(TabDebuffType[i]), 1, true))
			or   (PowaSet[xnum].ignoremaj == false and string.find(PowaSet[xnum].buffname, TabDebuffType[i], 1, true)) ) then
				Powa_Frames[xnum].buffindex = i-1; -- point vers le debuff type qui a le timer
				if (PowaSet[xnum].icon == "") then 
				  PowaSet[xnum].icon = GetPlayerBuffTexture( GetPlayerBuff(Powa_Frames[xnum].buffindex, "HARMFUL") ); 
				end -- icone
				return true; 
			end
		end
	else                                    -- un buff
		for i = 1, 24 do
			Powa_Frames[xnum].buffindex = 0;
			for pword in string.gfind(PowaSet[xnum].buffname, "[^/]+") do
				if ( (PowaSet[xnum].ignoremaj == true and string.find(string.upper(TabBuff[i]), string.upper(pword), 1, true)) 
				or   (PowaSet[xnum].ignoremaj == false and string.find(TabBuff[i], pword, 1, true)) ) then
					Powa_Frames[xnum].buffindex = i-1; -- point vers le buff qui a le timer
					if (PowaSet[xnum].icon == "") then 
					  PowaSet[xnum].icon = GetPlayerBuffTexture( GetPlayerBuff(Powa_Frames[xnum].buffindex, "HELPFUL") ); 
					end -- icone
					return true;
				end
			end
		end
	end
	return false;
end

function Powa_NewCheckBuffs() -- compare chaque nom de buff d'activation avec l'ensemble des buffs memorises
     local LastAura;

     Powa_MemorizeBuffs();

     LastAura = 0;
     for j = 1, MaxAuras do
	if (PowaMisc.disabled == true) then -- pas actif on efface tout
		if (Powa_Frames[j]:IsVisible() ) then
			Powa_FramesVisibleTime[j] = 0;
		end
	elseif (PowaSet[j].buffname == "" or PowaSet[j].buffname == " ") then -- ne fait rien si vide
		PowaSet[j].buffname = "";
	elseif (PowaCompareBuffDebuff(j)) then -- buff actif
	    if (PowaSet[j].inverse == true) then
		if (Powa_Frames[j]:IsVisible() ) then
			Powa_FramesVisibleTime[j] = 0;
			if (j == CurrentSecondeAura) then
				Powa_FramesVisibleTime[SecondeAura] = 0;
				if (LastAura > 0) then -- cet effet n'est plus actif mais on affiche l'aura 2 sur le dernier effet
					CurrentSecondeAura = LastAura;
					Powa_DisplayAura(LastAura);
				end
			end
		end
	    else
		Powa_DisplayAura(j);
		LastAura = j;
	    end
	else -- -- perte d'aura, s'il est visible on le cache
	    if (PowaSet[j].inverse == false) then
		if (Powa_Frames[j]:IsVisible() ) then
			Powa_FramesVisibleTime[j] = 0;
			if (j == CurrentSecondeAura) then
				Powa_FramesVisibleTime[SecondeAura] = 0;
				if (LastAura > 0) then -- cet effet n'est plus actif mais on affiche l'aura 2 sur le dernier effet
					CurrentSecondeAura = LastAura;
					Powa_DisplayAura(LastAura);
				end
			end
		end
	    else
		Powa_DisplayAura(j);
		LastAura = j;
	    end
	end
     end -- end for

end

-- ----------------------------------------------------------------------------------------- EVENT

function Powa_OnEvent()  

   if event == "PLAYER_ENTERING_WORLD" then

	Powa_Tooltip:SetOwner(UIParent, "ANCHOR_NONE");

   elseif event == "VARIABLES_LOADED" then
	DEFAULT_CHAT_FRAME:AddMessage("|cffB0A0ff<Power Auras>|r |cffffff00"..PowaVersion.."|r - "..PowaText.welcome);
	-- defini le nombre max d'effets
	if (PowaMisc.maxeffects == nil) then PowaMisc.maxeffects = 100; end
	MaxAuras = PowaMisc.maxeffects;
	SecondeAura = MaxAuras + 1;
	CurrentTestAura = MaxAuras + 2;
	-- verifie en cas de rajout d'effets que tous sont initialises (sinon ca bug :P)
	Powa_InitTabs();
	Powa_CreateFrames();
	-- defini le nombre max de textures
	if (PowaGlobal.maxtextures > 50) then PowaGlobal.maxtextures = 50; 
	elseif (PowaGlobal.maxtextures < 20) then PowaGlobal.maxtextures = 20; end
	getglobal("PowaBarAuraTextureSlider"):SetMinMaxValues(1,PowaGlobal.maxtextures);
	getglobal("PowaBarAuraTextureSliderHigh"):SetText(PowaGlobal.maxtextures);
	PowaEnabled = 1;
	Powa_CreateTimer();

   elseif event == "PLAYER_AURAS_CHANGED" then -- passe les buffs en revue	
	if (PowaModTest == false) then
		DoCheckBuffs = true; -- active les checks
	end
   end
end

-- -----------------------------------------------------------------------------------------------

function Powa_DisplayAura(FNum)

    if (PowaEnabled == 0) then return; end   -- desactived

    if (Powa_FramesVisibleTime[FNum] == 0) then  -- si pas en cours

	Powa_textures[FNum]:SetTexture("Interface\\Addons\\PowerAuras\\aura"..PowaSet[FNum].texture..".tga");
	Powa_textures[FNum]:SetVertexColor(PowaSet[FNum].r,PowaSet[FNum].g,PowaSet[FNum].b);

	    if (PowaSet[FNum].symetrie == 1) then Powa_textures[FNum]:SetTexCoord(1, 0, 0, 1); -- inverse X
	elseif (PowaSet[FNum].symetrie == 2) then Powa_textures[FNum]:SetTexCoord(0, 1, 1, 0); -- inverse Y
	elseif (PowaSet[FNum].symetrie == 3) then Powa_textures[FNum]:SetTexCoord(1, 0, 1, 0); -- inverse XY
	else Powa_textures[FNum]:SetTexCoord(0, 1, 0, 1); end	

	if (PowaSet[FNum].begin > 0) then Powa_Frames[FNum].beginAnim = 1;
	else				  Powa_Frames[FNum].beginAnim = 0; end

	Powa_Frames[FNum].baseL = 256 * PowaSet[FNum].size * PowaSet[FNum].torsion;
	Powa_Frames[FNum].baseH = 256 * PowaSet[FNum].size * (2-PowaSet[FNum].torsion);
	Powa_Frames[FNum]:SetAlpha(PowaSet[FNum].alpha);
	Powa_Frames[FNum]:SetPoint("Center",PowaSet[FNum].x, PowaSet[FNum].y);
	Powa_Frames[FNum]:SetWidth(Powa_Frames[FNum].baseL);
	Powa_Frames[FNum]:SetHeight(Powa_Frames[FNum].baseH);
	Powa_Frames[FNum].statut = 0;
	Powa_Frames[FNum].duree = 0;
	Powa_Frames[FNum]:Show();

	Powa_FramesVisibleTime[FNum] = 1;        -- affiche anim1
	Powa_FramesVisibleTime[SecondeAura] = 0; -- init anim2
    end

    if (Powa_FramesVisibleTime[SecondeAura] == 0) then  -- si pas en cours (Anim 2)
	
	CurrentSecondeAura = FNum; -- 2eme aura en cours
	
	if (PowaSet[FNum].anim2 == 0) then -- pas d'anim
		Powa_Frames[SecondeAura]:Hide();
		return;
	end

	if (PowaSet[FNum].begin > 0) then Powa_Frames[SecondeAura].beginAnim = 2;
	else				  Powa_Frames[SecondeAura].beginAnim = 0; end

	PowaSet[SecondeAura].size = PowaSet[FNum].size;
	PowaSet[SecondeAura].torsion = PowaSet[FNum].torsion;
	PowaSet[SecondeAura].symetrie = PowaSet[FNum].symetrie;
	PowaSet[SecondeAura].alpha = PowaSet[FNum].alpha * 0.5;
	PowaSet[SecondeAura].anim1 = PowaSet[FNum].anim2;
	PowaSet[SecondeAura].speed = PowaSet[FNum].speed - 0.1; -- legerement plus lent
	PowaSet[SecondeAura].duration = PowaSet[FNum].duration;
	PowaSet[SecondeAura].begin = PowaSet[FNum].begin;
	PowaSet[SecondeAura].finish = PowaSet[FNum].finish;
	PowaSet[SecondeAura].x = PowaSet[FNum].x;
	PowaSet[SecondeAura].y = PowaSet[FNum].y;

	Powa_textures[SecondeAura]:SetTexture("Interface\\Addons\\PowerAuras\\aura"..PowaSet[FNum].texture..".tga");
	Powa_textures[SecondeAura]:SetVertexColor(PowaSet[FNum].r,PowaSet[FNum].g,PowaSet[FNum].b);

	    if (PowaSet[FNum].symetrie == 1) then Powa_textures[SecondeAura]:SetTexCoord(1, 0, 0, 1); -- inverse X
	elseif (PowaSet[FNum].symetrie == 2) then Powa_textures[SecondeAura]:SetTexCoord(0, 1, 1, 0); -- inverse Y
	elseif (PowaSet[FNum].symetrie == 3) then Powa_textures[SecondeAura]:SetTexCoord(1, 0, 1, 0); -- inverse XY
	else Powa_textures[SecondeAura]:SetTexCoord(0, 1, 0, 1); end

	Powa_Frames[SecondeAura].baseL = Powa_Frames[FNum].baseL;
	Powa_Frames[SecondeAura].baseH = Powa_Frames[FNum].baseH;
	Powa_Frames[SecondeAura]:SetAlpha(PowaSet[SecondeAura].alpha);
	Powa_Frames[SecondeAura]:SetPoint("Center",PowaSet[FNum].x, PowaSet[FNum].y);
	Powa_Frames[SecondeAura]:SetWidth(Powa_Frames[SecondeAura].baseL);
	Powa_Frames[SecondeAura]:SetHeight(Powa_Frames[SecondeAura].baseH);
	Powa_Frames[SecondeAura].statut = 1;
	Powa_Frames[SecondeAura].duree = Powa_Frames[FNum].duree;

	-- si on doit reafficher une seconde anim, fait gaffe de pas la reafficher si elle est sensee avoir disparu
	if (PowaSet[SecondeAura].duration > 0 and Powa_Frames[SecondeAura].duree > PowaSet[SecondeAura].duration) then return; end

	Powa_Frames[SecondeAura]:Show();

	Powa_FramesVisibleTime[SecondeAura] = 1;
    end
end

-- -------------------------------------------------------------------------------------- TIMERS
PowaActiveTimer = 0;  -- le timer en cours
PowaActiveTimerValue = 0;
PowaActiveTimerSup = 0;  -- le 2eme timer en cours
PowaActiveTimerSupValue = 0;
PowaActiveTimer2 = 0;  -- le timer en cours (debuffs)
PowaActiveTimer2Value = 0;
PowaActiveTimer2Sup = 0;  -- le 2eme timer en cours (debuffs)
PowaActiveTimer2SupValue = 0;

function Powa_UpdateTimer(numi)
	local newvalue;
	
	if (numi > MaxAuras) then -- fin du cycle on arrete
		return;
	elseif (PowaSet[numi].timer == false) then -- cet effet n'affiche pas de timer
		return;
	end

	-- prend le timer
	if (getglobal("PowaBarConfigFrameOptions"):IsVisible()) then -- options des timers, affiche
		PowaActiveTimer2 = numi;
		PowaActiveTimer2Value = random(1,9) + (random(1, 99) / 100);
		PowaActiveTimer = numi;
		PowaActiveTimerValue = random(1,9) + (random(1, 99) / 100);

	elseif (PowaSet[numi].isdebuff or PowaSet[numi].isdebufftype) then
		if (PowaModTest) then
			newvalue = random(1,9) + (random(1, 99) / 100);
		else
			newvalue = GetPlayerBuffTimeLeft( GetPlayerBuff(Powa_Frames[numi].buffindex, "HARMFUL") );
		end
		
		if (newvalue > 0) then -- ok on a un timer a afficher...
			if ((PowaActiveTimer2Value > 0) and (newvalue > PowaActiveTimer2Value)) then
				-- y'a deja un timer dont le nombre est plus petit, verifie le second
				if (PowaMisc.Ddual == true) then
					if ((PowaActiveTimer2SupValue > 0) and (newvalue > PowaActiveTimer2SupValue)) then
						-- le second est pris, tant pis...
						return;
					else
						PowaActiveTimer2Sup = numi;          -- lien vers l'effet
						PowaActiveTimer2SupValue = newvalue; -- retiens la valeur
					end
				else
					return;
				end
			else
				PowaActiveTimer2Sup = PowaActiveTimer2;
				PowaActiveTimer2SupValue = PowaActiveTimer2Value;
				PowaActiveTimer2 = numi;          -- lien vers l'effet
				PowaActiveTimer2Value = newvalue; -- retiens la valeur
			end
		end
	else
		if (PowaModTest) then
			newvalue = random(1,9) + (random(1, 99) / 100);
		else
			newvalue = GetPlayerBuffTimeLeft( GetPlayerBuff(Powa_Frames[numi].buffindex, "HELPFUL") );
		end

		if (newvalue > 0) then -- ok on a un timer a afficher...
			if ((PowaActiveTimerValue > 0) and (newvalue > PowaActiveTimerValue)) then
				-- y'a deja un timer dont le nombre est plus petit, verifie le second
				if (PowaMisc.Bdual == true) then
					if ((PowaActiveTimerSupValue > 0) and (newvalue > PowaActiveTimerSupValue)) then
						-- le second est pris, tant pis...
						return;
					else
						PowaActiveTimerSup = numi;          -- lien vers l'effet
						PowaActiveTimerSupValue = newvalue; -- retiens la valeur
					end
				else
					return;
				end
			else
				PowaActiveTimerSup = PowaActiveTimer;
				PowaActiveTimerSupValue = PowaActiveTimerValue;
				PowaActiveTimer = numi;          -- lien vers l'effet
				PowaActiveTimerValue = newvalue; -- retiens la valeur
			end
		end
	end
end

function Powa_ResetTimers()
	local deci, uni, newvalue;

	if (PowaActiveTimer > 0) then -- timer a un lien
		if (Powa_Frames[PowaActiveTimer]:IsVisible()) then -- l'effet est visible, affiche
			-- timer 1, le gros (secondes)
			Powa_timertex[1]:SetVertexColor(PowaSet[PowaActiveTimer].r,PowaSet[PowaActiveTimer].g,PowaSet[PowaActiveTimer].b);
			-- si le timer est > 60, le transforme en minutes
			newvalue = PowaActiveTimerValue;
			if (newvalue > 60.00) then newvalue = newvalue / 60; end
			newvalue = math.min (99.00, newvalue);
			
			deci = math.floor(newvalue / 10);
			uni  = math.floor(newvalue - (deci*10));
			Powa_timertex[1]:SetTexCoord(Tstep * uni, Tstep * (uni+1), Tstep * deci, Tstep * (deci+1));
			Powa_Timer[1]:Show();
			-- timer 2, le petit (centieme de secondes)
			  -- mode 2eme timer...
			if (PowaMisc.Bdual == true and PowaActiveTimerSupValue > 0) then
				Powa_timertex[2]:SetVertexColor(PowaSet[PowaActiveTimerSup].r,PowaSet[PowaActiveTimerSup].g,PowaSet[PowaActiveTimerSup].b);
				newvalue = PowaActiveTimerSupValue;
				if (newvalue > 60.00) then newvalue = newvalue / 60; end
				newvalue = math.min (99.00, newvalue);
			
				deci = math.floor(newvalue / 10);
				uni  = math.floor(newvalue - (deci*10));
				Powa_timertex[2]:SetTexCoord(Tstep * uni, Tstep * (uni+1), Tstep * deci, Tstep * (deci+1));
				Powa_Timer[2]:Show();
			else -- mode normal (centiemes)
				Powa_timertex[2]:SetVertexColor(PowaSet[PowaActiveTimer].r,PowaSet[PowaActiveTimer].g,PowaSet[PowaActiveTimer].b);

				newvalue = PowaActiveTimerValue;
				if (newvalue > 60.00) then 
					newvalue = math.mod(newvalue,60); 
				else
					newvalue = (newvalue - math.floor(newvalue)) * 100;
				end
				deci = math.floor(newvalue / 10);
				uni  = math.floor(newvalue - (deci*10));
				Powa_timertex[2]:SetTexCoord(Tstep * uni, Tstep * (uni+1), Tstep * deci, Tstep * (deci+1));
				if (PowaMisc.BCents == true) then
					Powa_Timer[2]:Show();
				else
					Powa_Timer[2]:Hide();
				end
			end
		else
			Powa_Timer[1]:Hide(); -- cache les timer
			Powa_Timer[2]:Hide(); -- cache les timer
		end
	else
		Powa_Timer[1]:Hide();
		Powa_Timer[2]:Hide(); -- cache les timer
	end
	PowaActiveTimer = 0;
	PowaActiveTimerValue = 0;
	PowaActiveTimerSup = 0;
	PowaActiveTimerSupValue = 0;

	-- idem pour les debuffs
	if (PowaActiveTimer2 > 0) then -- timer a un lien
		if (Powa_Frames[PowaActiveTimer2]:IsVisible()) then -- l'effet est visible, affiche
			-- timer 1, le gros (secondes)
			Powa_timertex[3]:SetVertexColor(PowaSet[PowaActiveTimer2].r,PowaSet[PowaActiveTimer2].g,PowaSet[PowaActiveTimer2].b);
			-- si le timer est > 60, le transforme en minutes
			newvalue = PowaActiveTimer2Value;
			if (newvalue > 60.00) then newvalue = newvalue / 60; end
			newvalue = math.min (99.00, newvalue);
			
			deci = math.floor(newvalue / 10);
			uni  = math.floor(newvalue - (deci*10));
			Powa_timertex[3]:SetTexCoord(Tstep * uni, Tstep * (uni+1), Tstep * deci, Tstep * (deci+1));
			Powa_Timer[3]:Show();
			-- timer 2, le petit (centieme de secondes)
			  -- mode 2eme timer...
			if (PowaMisc.Ddual == true and PowaActiveTimer2SupValue > 0) then
				Powa_timertex[4]:SetVertexColor(PowaSet[PowaActiveTimer2Sup].r,PowaSet[PowaActiveTimer2Sup].g,PowaSet[PowaActiveTimer2Sup].b);
				newvalue = PowaActiveTimer2SupValue;
				if (newvalue > 60.00) then newvalue = newvalue / 60; end
				newvalue = math.min (99.00, newvalue);
			
				deci = math.floor(newvalue / 10);
				uni  = math.floor(newvalue - (deci*10));
				Powa_timertex[4]:SetTexCoord(Tstep * uni, Tstep * (uni+1), Tstep * deci, Tstep * (deci+1));
				Powa_Timer[4]:Show();
			else -- mode normal (centiemes)
				Powa_timertex[4]:SetVertexColor(PowaSet[PowaActiveTimer2].r,PowaSet[PowaActiveTimer2].g,PowaSet[PowaActiveTimer2].b);

				newvalue = PowaActiveTimer2Value;
				if (newvalue > 60.00) then 
					newvalue = math.mod(newvalue,60); 
				else
					newvalue = (newvalue - math.floor(newvalue)) * 100;
				end
				deci = math.floor(newvalue / 10);
				uni  = math.floor(newvalue - (deci*10));
				Powa_timertex[4]:SetTexCoord(Tstep * uni, Tstep * (uni+1), Tstep * deci, Tstep * (deci+1));
				if (PowaMisc.DCents == true) then
					Powa_Timer[4]:Show();
				else
					Powa_Timer[4]:Hide();
				end
			end
		else
			Powa_Timer[3]:Hide(); -- cache les timer
			Powa_Timer[4]:Hide(); -- cache les timer
		end
	else
		Powa_Timer[3]:Hide();
		Powa_Timer[4]:Hide(); -- cache les timer
	end
	PowaActiveTimer2 = 0;
	PowaActiveTimer2Value = 0;
	PowaActiveTimer2Sup = 0;
	PowaActiveTimer2SupValue = 0;
end

-- -------------------------------------------------------------------------------------- ON UPDATE
minScale = {a=0, w=0, h=0};
maxScale = {a=0, w=0, h=0};
curScale = {a=0, w=0, h=0};
speedScale = 0;

function Powa_OnUpdate(elapsed)

	-- lance les checks (corrige certains soucis)
--	ChecksTimer = ChecksTimer + elapsed

--	if (ChecksTimer > NextCheck) then
--		ChecksTimer = 0;
--		if (PowaModTest == false) then
--			DoCheckBuffs = true;
--		end
--	end

	-- lance les checks (leger)
	if (DoCheckBuffs == true) then
		Powa_NewCheckBuffs();
		DoCheckBuffs = false;
	end

    for i = 1, CurrentTestAura do
    
    	if (PowaEnabled == 0) then return; end   -- desactived

	if (Powa_FramesVisibleTime[i] > 0) then -- si visible seulement

		Powa_UpdateTimer(i); -- met a jour les Timers

		curScale.w = Powa_Frames[i].baseL; -- regle la taille de l'image en pixel
		curScale.h = Powa_Frames[i].baseH;

		-- pas d'anim si l'effet va disparaitre avec duree
		if ((PowaSet[i].duration > 0) and (Powa_Frames[i].duree > PowaSet[i].duration)) then
			-- si visible, baisse l'alpha
			if (Powa_Frames[i]:GetAlpha() > 0) then
				Powa_Frames[i].beginAnim = 0;
				curScale.a = Powa_Frames[i]:GetAlpha() - (elapsed / 2);
				-- si alpha 0, cache
				if (curScale.a <= 0) then
					Powa_Frames[i]:SetAlpha(0);
				else
					Powa_Frames[i]:SetAlpha(curScale.a);
				end
			end
		-- animation de depart active ----------------------------------------------
		elseif (Powa_Frames[i].beginAnim > 0) then
			if (i == SecondeAura) then -- la 2eme aura ne s'affiche pas maintenant
				if (Powa_Frames[CurrentSecondeAura].beginAnim == 0) then -- la premiere a fini
					Powa_Frames[i].beginAnim = 0;
					Powa_Frames[i]:SetAlpha(PowaSet[i].alpha);
				else
					Powa_Frames[i]:SetAlpha(0.0);
				end
			elseif (PowaSet[i].begin == 1) then -- zoom avant
				maxScale.w = curScale.w * 1.5;
				if (Powa_Frames[i].beginAnim == 1) then -- init
					Powa_Frames[i]:SetWidth(maxScale.w);
					Powa_Frames[i]:SetHeight(curScale.h * 1.5);
					Powa_Frames[i].beginAnim = 3;
					Powa_Frames[i]:SetAlpha(0.0);
				end
				Powa_Frames[i]:SetWidth( Powa_Frames[i]:GetWidth() - (elapsed * 150 * PowaSet[i].speed * PowaSet[i].torsion) );
				Powa_Frames[i]:SetHeight( Powa_Frames[i]:GetHeight() - (elapsed * 150 * PowaSet[i].speed * (2-PowaSet[i].torsion)) );
				Powa_Frames[i]:SetAlpha( ((maxScale.w - Powa_Frames[i]:GetWidth()) / (maxScale.w - curScale.w)) * PowaSet[i].alpha );
				if (Powa_Frames[i]:GetWidth() < curScale.w) then
					Powa_Frames[i]:SetWidth(curScale.w);
					Powa_Frames[i]:SetHeight(curScale.h);
					Powa_Frames[i]:SetAlpha(PowaSet[i].alpha);
					Powa_Frames[i].beginAnim = 0;
				end
			elseif (PowaSet[i].begin == 2) then -- zoom arriere
				maxScale.w = curScale.w * 0.5;
				if (Powa_Frames[i].beginAnim == 1) then -- init
					Powa_Frames[i]:SetWidth(maxScale.w);
					Powa_Frames[i]:SetHeight(curScale.h * 0.5);
					Powa_Frames[i].beginAnim = 3;
					Powa_Frames[i]:SetAlpha(0.0);
				end
				Powa_Frames[i]:SetWidth( Powa_Frames[i]:GetWidth() + (elapsed * 150 * PowaSet[i].speed * PowaSet[i].torsion) );
				Powa_Frames[i]:SetHeight( Powa_Frames[i]:GetHeight() + (elapsed * 150 * PowaSet[i].speed * (2-PowaSet[i].torsion)) );
				Powa_Frames[i]:SetAlpha( ((maxScale.w - Powa_Frames[i]:GetWidth()) / (maxScale.w - curScale.w)) * PowaSet[i].alpha );
				if (Powa_Frames[i]:GetWidth() > curScale.w) then
					Powa_Frames[i]:SetWidth(curScale.w);
					Powa_Frames[i]:SetHeight(curScale.h);
					Powa_Frames[i]:SetAlpha(PowaSet[i].alpha);
					Powa_Frames[i].beginAnim = 0;
				end
			elseif (PowaSet[i].begin == 3) then -- transparence
				if (Powa_Frames[i].beginAnim == 1) then -- init
					Powa_Frames[i].beginAnim = 3;
					Powa_Frames[i]:SetAlpha(0.0);
				end
				Powa_Frames[i]:SetAlpha( Powa_Frames[i]:GetAlpha() + (elapsed * 2 * PowaSet[i].speed * PowaSet[i].alpha) );
				if (Powa_Frames[i]:GetAlpha() > PowaSet[i].alpha) then
					Powa_Frames[i]:SetAlpha(PowaSet[i].alpha);
					Powa_Frames[i].beginAnim = 0;
				end
			elseif (PowaSet[i].begin == 4) then -- gauche
				if (Powa_Frames[i].beginAnim == 1) then -- init
					Powa_Frames[i].beginAnimX = PowaSet[i].x - 100;
					Powa_Frames[i].beginAnimY = PowaSet[i].y;
					Powa_Frames[i].beginAnim = 3;
					Powa_Frames[i]:SetAlpha(0.0);
				end
				Powa_Frames[i].beginAnimX = Powa_Frames[i].beginAnimX + (elapsed * 200 * PowaSet[i].speed);
				Powa_Frames[i]:SetAlpha( Powa_Frames[i]:GetAlpha() + (elapsed * 2 * PowaSet[i].speed * PowaSet[i].alpha) );
				if (Powa_Frames[i].beginAnimX > PowaSet[i].x) then
					Powa_Frames[i]:SetPoint("Center",PowaSet[i].x, PowaSet[i].y);
					Powa_Frames[i].beginAnim = 0;
				else
					Powa_Frames[i]:SetPoint("Center",Powa_Frames[i].beginAnimX, Powa_Frames[i].beginAnimY);
				end
			elseif (PowaSet[i].begin == 5) then
				if (Powa_Frames[i].beginAnim == 1) then -- init
					Powa_Frames[i].beginAnimX = PowaSet[i].x - 75;
					Powa_Frames[i].beginAnimY = PowaSet[i].y + 75;
					Powa_Frames[i].beginAnim = 3;
					Powa_Frames[i]:SetAlpha(0.0);
				end
				Powa_Frames[i].beginAnimX = Powa_Frames[i].beginAnimX + (elapsed * 150 * PowaSet[i].speed);
				Powa_Frames[i].beginAnimY = Powa_Frames[i].beginAnimY - (elapsed * 150 * PowaSet[i].speed);
				Powa_Frames[i]:SetAlpha( Powa_Frames[i]:GetAlpha() + (elapsed * 1.5 * PowaSet[i].speed * PowaSet[i].alpha) );
				if (Powa_Frames[i].beginAnimX > PowaSet[i].x) then
					Powa_Frames[i]:SetPoint("Center",PowaSet[i].x, PowaSet[i].y);
					Powa_Frames[i].beginAnim = 0;
				else
					Powa_Frames[i]:SetPoint("Center",Powa_Frames[i].beginAnimX, Powa_Frames[i].beginAnimY);
				end
			elseif (PowaSet[i].begin == 6) then -- haut
				if (Powa_Frames[i].beginAnim == 1) then -- init
					Powa_Frames[i].beginAnimX = PowaSet[i].x;
					Powa_Frames[i].beginAnimY = PowaSet[i].y + 100;
					Powa_Frames[i].beginAnim = 3;
					Powa_Frames[i]:SetAlpha(0.0);
				end
				Powa_Frames[i].beginAnimY = Powa_Frames[i].beginAnimY - (elapsed * 200 * PowaSet[i].speed);
				Powa_Frames[i]:SetAlpha( Powa_Frames[i]:GetAlpha() + (elapsed * 2 * PowaSet[i].speed * PowaSet[i].alpha) );
				if (Powa_Frames[i].beginAnimY < PowaSet[i].y) then
					Powa_Frames[i]:SetPoint("Center",PowaSet[i].x, PowaSet[i].y);
					Powa_Frames[i].beginAnim = 0;
				else
					Powa_Frames[i]:SetPoint("Center",Powa_Frames[i].beginAnimX, Powa_Frames[i].beginAnimY);
				end
			elseif (PowaSet[i].begin == 7) then
				if (Powa_Frames[i].beginAnim == 1) then -- init
					Powa_Frames[i].beginAnimX = PowaSet[i].x + 75;
					Powa_Frames[i].beginAnimY = PowaSet[i].y + 75;
					Powa_Frames[i].beginAnim = 3;
					Powa_Frames[i]:SetAlpha(0.0);
				end
				Powa_Frames[i].beginAnimX = Powa_Frames[i].beginAnimX - (elapsed * 150 * PowaSet[i].speed);
				Powa_Frames[i].beginAnimY = Powa_Frames[i].beginAnimY - (elapsed * 150 * PowaSet[i].speed);
				Powa_Frames[i]:SetAlpha( Powa_Frames[i]:GetAlpha() + (elapsed * 1.5 * PowaSet[i].speed * PowaSet[i].alpha) );
				if (Powa_Frames[i].beginAnimX < PowaSet[i].x) then
					Powa_Frames[i]:SetPoint("Center",PowaSet[i].x, PowaSet[i].y);
					Powa_Frames[i].beginAnim = 0;
				else
					Powa_Frames[i]:SetPoint("Center",Powa_Frames[i].beginAnimX, Powa_Frames[i].beginAnimY);
				end
			elseif (PowaSet[i].begin == 8) then -- droite
				if (Powa_Frames[i].beginAnim == 1) then -- init
					Powa_Frames[i].beginAnimX = PowaSet[i].x + 100;
					Powa_Frames[i].beginAnimY = PowaSet[i].y;
					Powa_Frames[i].beginAnim = 3;
					Powa_Frames[i]:SetAlpha(0.0);
				end
				Powa_Frames[i].beginAnimX = Powa_Frames[i].beginAnimX - (elapsed * 200 * PowaSet[i].speed);
				Powa_Frames[i]:SetAlpha( Powa_Frames[i]:GetAlpha() + (elapsed * 2 * PowaSet[i].speed * PowaSet[i].alpha) );
				if (Powa_Frames[i].beginAnimX < PowaSet[i].x) then
					Powa_Frames[i]:SetPoint("Center",PowaSet[i].x, PowaSet[i].y);
					Powa_Frames[i].beginAnim = 0;
				else
					Powa_Frames[i]:SetPoint("Center",Powa_Frames[i].beginAnimX, Powa_Frames[i].beginAnimY);
				end
			elseif (PowaSet[i].begin == 9) then
				if (Powa_Frames[i].beginAnim == 1) then -- init
					Powa_Frames[i].beginAnimX = PowaSet[i].x + 75;
					Powa_Frames[i].beginAnimY = PowaSet[i].y - 75;
					Powa_Frames[i].beginAnim = 3;
					Powa_Frames[i]:SetAlpha(0.0);
				end
				Powa_Frames[i].beginAnimX = Powa_Frames[i].beginAnimX - (elapsed * 150 * PowaSet[i].speed);
				Powa_Frames[i].beginAnimY = Powa_Frames[i].beginAnimY + (elapsed * 150 * PowaSet[i].speed);
				Powa_Frames[i]:SetAlpha( Powa_Frames[i]:GetAlpha() + (elapsed * 1.5 * PowaSet[i].speed * PowaSet[i].alpha) );
				if (Powa_Frames[i].beginAnimX < PowaSet[i].x) then
					Powa_Frames[i]:SetPoint("Center",PowaSet[i].x, PowaSet[i].y);
					Powa_Frames[i].beginAnim = 0;
				else
					Powa_Frames[i]:SetPoint("Center",Powa_Frames[i].beginAnimX, Powa_Frames[i].beginAnimY);
				end
			elseif (PowaSet[i].begin == 10) then -- haut
				if (Powa_Frames[i].beginAnim == 1) then -- init
					Powa_Frames[i].beginAnimX = PowaSet[i].x;
					Powa_Frames[i].beginAnimY = PowaSet[i].y - 100;
					Powa_Frames[i].beginAnim = 3;
					Powa_Frames[i]:SetAlpha(0.0);
				end
				Powa_Frames[i].beginAnimY = Powa_Frames[i].beginAnimY + (elapsed * 200 * PowaSet[i].speed);
				Powa_Frames[i]:SetAlpha( Powa_Frames[i]:GetAlpha() + (elapsed * 2 * PowaSet[i].speed * PowaSet[i].alpha) );
				if (Powa_Frames[i].beginAnimY > PowaSet[i].y) then
					Powa_Frames[i]:SetPoint("Center",PowaSet[i].x, PowaSet[i].y);
					Powa_Frames[i].beginAnim = 0;
				else
					Powa_Frames[i]:SetPoint("Center",Powa_Frames[i].beginAnimX, Powa_Frames[i].beginAnimY);
				end
			elseif (PowaSet[i].begin == 11) then
				if (Powa_Frames[i].beginAnim == 1) then -- init
					Powa_Frames[i].beginAnimX = PowaSet[i].x - 75;
					Powa_Frames[i].beginAnimY = PowaSet[i].y - 75;
					Powa_Frames[i].beginAnim = 3;
					Powa_Frames[i]:SetAlpha(0.0);
				end
				Powa_Frames[i].beginAnimX = Powa_Frames[i].beginAnimX + (elapsed * 150 * PowaSet[i].speed);
				Powa_Frames[i].beginAnimY = Powa_Frames[i].beginAnimY + (elapsed * 150 * PowaSet[i].speed);
				Powa_Frames[i]:SetAlpha( Powa_Frames[i]:GetAlpha() + (elapsed * 1.5 * PowaSet[i].speed * PowaSet[i].alpha) );
				if (Powa_Frames[i].beginAnimX > PowaSet[i].x) then
					Powa_Frames[i]:SetPoint("Center",PowaSet[i].x, PowaSet[i].y);
					Powa_Frames[i].beginAnim = 0;
				else
					Powa_Frames[i]:SetPoint("Center",Powa_Frames[i].beginAnimX, Powa_Frames[i].beginAnimY);
				end
			end
		-- Animations --------------------------------------------------------------
		-- Animation 1 : aucune
		elseif (PowaSet[i].anim1 == 1) then

		-- Animation 2 : max alpha <-> mi-alpha
		elseif (PowaSet[i].anim1 == 2) then
			minScale.a = PowaSet[i].alpha * 0.5 * PowaSet[i].speed;
			maxScale.a = PowaSet[i].alpha;

			if (Powa_Frames[i].statut == 0) then
				curScale.a = Powa_Frames[i]:GetAlpha() - (elapsed / 2);
				Powa_Frames[i]:SetAlpha( curScale.a )
				if (Powa_Frames[i]:GetAlpha() < minScale.a) then
					Powa_Frames[i]:SetAlpha(minScale.a);
					Powa_Frames[i].statut = 1;
				end
			else
				curScale.a = Powa_Frames[i]:GetAlpha() + (elapsed / 2);
				if (curScale.a > 1.0) then curScale.a = 1.0; end -- pas trop haut non plus
				Powa_Frames[i]:SetAlpha( curScale.a )
				if (Powa_Frames[i]:GetAlpha() >= maxScale.a) then 
					Powa_Frames[i]:SetAlpha(maxScale.a);
					Powa_Frames[i].statut = 0;
				end
			end
		-- Animation 3 : mini-zoom in repetitif + fading
		elseif (PowaSet[i].anim1 == 3) then
			minScale.w = curScale.w * 0.90;
			minScale.h = curScale.h * 0.90;
			maxScale.w = curScale.w * 1.20;
			maxScale.h = curScale.h * 1.20;
			speedScale = (25 * PowaSet[i].speed) * PowaSet[i].size;

			if (Powa_Frames[i].statut == 1) then  -- decale anim 2
				Powa_Frames[i]:SetWidth(curScale.w * 1.15);
				Powa_Frames[i]:SetHeight(curScale.h * 1.15);
				Powa_Frames[i].statut = 0;
			end

			Powa_Frames[i]:SetWidth( Powa_Frames[i]:GetWidth() + (elapsed * speedScale) )
			Powa_Frames[i]:SetHeight( Powa_Frames[i]:GetHeight() + (elapsed * speedScale) )

			Powa_Frames[i]:SetAlpha( ((maxScale.w - Powa_Frames[i]:GetWidth()) / (maxScale.w - minScale.w)) * PowaSet[i].alpha );

			if (Powa_Frames[i]:GetWidth() > maxScale.w) then
				Powa_Frames[i]:SetWidth(minScale.w);
				Powa_Frames[i]:SetHeight(minScale.h);
			end
		-- Animation 4 : mini-zoom in/out
		elseif (PowaSet[i].anim1 == 4) then
			minScale.w = curScale.w * 0.95;
			minScale.h = curScale.h * 0.95;
			maxScale.w = curScale.w * 1.05;
			maxScale.h = curScale.h * 1.05;
			speedScale = (50 * PowaSet[i].speed) * PowaSet[i].size;

			if (Powa_Frames[i].statut == 0) then
				Powa_Frames[i]:SetWidth( Powa_Frames[i]:GetWidth() + (elapsed * speedScale * PowaSet[i].torsion) )
				Powa_Frames[i]:SetHeight( Powa_Frames[i]:GetHeight() + (elapsed * speedScale * (2-PowaSet[i].torsion) ) )				
				if (Powa_Frames[i]:GetWidth() > maxScale.w) then	
					Powa_Frames[i]:SetWidth(maxScale.w);
					Powa_Frames[i]:SetHeight(maxScale.h);
					Powa_Frames[i].statut = 1;
				end
			else
				Powa_Frames[i]:SetWidth( Powa_Frames[i]:GetWidth() - (elapsed * speedScale * PowaSet[i].torsion) )
				Powa_Frames[i]:SetHeight( Powa_Frames[i]:GetHeight() - (elapsed * speedScale * (2-PowaSet[i].torsion) ) )				
				if (Powa_Frames[i]:GetWidth() < minScale.w) then 
					Powa_Frames[i]:SetWidth(minScale.w);
					Powa_Frames[i]:SetHeight(minScale.h);
					Powa_Frames[i].statut = 0;
				end
			end
		-- Animation 5 : effet bulle
		elseif (PowaSet[i].anim1 == 5) then
			minScale.w = curScale.w * 0.95;
			minScale.h = curScale.h * 0.95;
			maxScale.w = curScale.w * 1.05;
			maxScale.h = curScale.h * 1.05;
			speedScale = (50 * PowaSet[i].speed) * PowaSet[i].size;

			if (Powa_Frames[i].statut == 0) then	
				Powa_Frames[i]:SetWidth( Powa_Frames[i]:GetWidth() + (elapsed * speedScale * PowaSet[i].torsion) )
				Powa_Frames[i]:SetHeight( Powa_Frames[i]:GetHeight() - (elapsed * speedScale * (2-PowaSet[i].torsion) ) )
				if (Powa_Frames[i]:GetWidth() > maxScale.w) then
					Powa_Frames[i]:SetWidth(maxScale.w);
					Powa_Frames[i]:SetHeight(minScale.h);
					Powa_Frames[i].statut = 1;
				end
			else
				Powa_Frames[i]:SetWidth( Powa_Frames[i]:GetWidth() - (elapsed * speedScale * PowaSet[i].torsion) )
				Powa_Frames[i]:SetHeight( Powa_Frames[i]:GetHeight() + (elapsed * speedScale * (2-PowaSet[i].torsion) ) )
				if (Powa_Frames[i]:GetHeight() > maxScale.h) then 
					Powa_Frames[i]:SetWidth(minScale.w);
					Powa_Frames[i]:SetHeight(maxScale.h);
					Powa_Frames[i].statut = 0;
				end
			end
		-- position au hasard + zoom in + fade
		elseif (PowaSet[i].anim1 == 6) then
			if (Powa_Frames[i]:GetAlpha() > 0) then
				curScale.a = Powa_Frames[i]:GetAlpha() - (elapsed * PowaSet[i].alpha * 0.5 * PowaSet[i].speed);
				if (curScale.a < 0) then Powa_Frames[i]:SetAlpha(0.0);
				else Powa_Frames[i]:SetAlpha(curScale.a); end
				maxScale.w = Powa_Frames[i]:GetWidth() + (elapsed * 100 * PowaSet[i].speed * PowaSet[i].size);
				maxScale.h = Powa_Frames[i]:GetHeight() + (elapsed * 100 * PowaSet[i].speed * PowaSet[i].size);
				if ( (maxScale.w * 1.5) > Powa_Frames[i]:GetWidth()) then -- evite les lags
					Powa_Frames[i]:SetWidth(maxScale.w)
					Powa_Frames[i]:SetHeight(maxScale.h)
				end
			else
				maxScale.w = (random(0,20) - 10) * PowaSet[i].speed;
				maxScale.h = (random(0,20) - 10) * PowaSet[i].speed;
				Powa_Frames[i]:SetAlpha(PowaSet[i].alpha);
				Powa_Frames[i]:SetWidth(curScale.w * 0.85);
				Powa_Frames[i]:SetHeight(curScale.h * 0.85);
				Powa_Frames[i]:SetPoint("Center",PowaSet[i].x + maxScale.w, PowaSet[i].y + maxScale.h);
			end
		-- static sauf parfois ou la texture est decalee + opaque (type electrique)
		elseif (PowaSet[i].anim1 == 7) then
			if (Powa_Frames[i].statut < 2) then
				Powa_Frames[i]:SetAlpha(PowaSet[i].alpha / 2); -- mi-alpha
				if (random( 210-(PowaSet[i].speed*100) ) == 1) then
					Powa_Frames[i].statut = 2;
					maxScale.w = random(0,10) - 5;
					maxScale.h = random(0,10) - 5;
					Powa_Frames[i]:SetPoint("Center",PowaSet[i].x + maxScale.w, PowaSet[i].y + maxScale.h);
					Powa_Frames[i]:SetAlpha(PowaSet[i].alpha);
				end
			else
				Powa_Frames[i]:SetPoint("Center",PowaSet[i].x, PowaSet[i].y);
				Powa_Frames[i].statut = 0;
			end
		-- zoom out + stop + fade
		elseif (PowaSet[i].anim1 == 8) then
			minScale.w = curScale.w;
			minScale.h = curScale.h;
			maxScale.w = curScale.w * 1.30;
			maxScale.h = curScale.h * 1.30;
			speedScale = (50 * PowaSet[i].speed) * PowaSet[i].size;
			
			if (Powa_Frames[i].statut == 0) then -- demarre le zoom out (max size)
				Powa_Frames[i]:SetWidth(maxScale.w);
				Powa_Frames[i]:SetHeight(maxScale.h);
				Powa_Frames[i]:SetAlpha(0.0);
				Powa_Frames[i].statut = 2;
			elseif (Powa_Frames[i].statut == 2) then -- zoom out + fade in
				Powa_Frames[i]:SetWidth( Powa_Frames[i]:GetWidth() - (elapsed * speedScale * PowaSet[i].torsion) )
				Powa_Frames[i]:SetHeight( Powa_Frames[i]:GetHeight() - (elapsed * speedScale * (2-PowaSet[i].torsion) ) )

				Powa_Frames[i]:SetAlpha( ((maxScale.w - Powa_Frames[i]:GetWidth()) / (maxScale.w - minScale.w)) * PowaSet[i].alpha );

				if (Powa_Frames[i]:GetWidth() < curScale.w) then
					Powa_Frames[i]:SetWidth(curScale.w);
					Powa_Frames[i]:SetHeight(curScale.h);	
					Powa_Frames[i].statut = 1;
				end
			elseif (Powa_Frames[i].statut == 1) then -- demarre le fade-out
				Powa_Frames[i]:SetWidth(curScale.w);
				Powa_Frames[i]:SetHeight(curScale.h);
				Powa_Frames[i]:SetAlpha(PowaSet[i].alpha);
				Powa_Frames[i].statut = 3;

			elseif (Powa_Frames[i].statut == 3) then -- fade-out
				curScale.a = Powa_Frames[i]:GetAlpha() - (elapsed / random(1,2));

				if (curScale.a < 0.0) then
					Powa_Frames[i]:SetAlpha(0.0);
					Powa_Frames[i].statut = 0;
				else
					Powa_Frames[i]:SetAlpha(curScale.a);
				end
			end
		-- deplacement vers le haut + fade-out + reduction
		elseif (PowaSet[i].anim1 == 9) then
			speedScale = (50 * PowaSet[i].speed) * PowaSet[i].size;
			
			if (Powa_Frames[i].statut < 2) then -- debut
				Powa_Frames[i]:SetWidth(curScale.w);
				Powa_Frames[i]:SetHeight(curScale.h);
				Powa_Frames[i]:SetPoint("Center",PowaSet[i].x, PowaSet[i].y);
				Powa_Frames[i]:SetAlpha(PowaSet[i].alpha);
				Powa_Frames[i].statut = 2;
			else
				_,_,_,xOfs,yOfs = Powa_Frames[i]:GetPoint();
				Powa_Frames[i]:SetPoint("Center",xOfs + (random(1,3)-2), yOfs + (elapsed * random(10,20)));
				curScale.a = Powa_Frames[i]:GetAlpha() - ( (elapsed / random(2,4)) * PowaSet[i].alpha);

				Powa_Frames[i]:SetWidth( Powa_Frames[i]:GetWidth() - (elapsed * speedScale * PowaSet[i].torsion) )
				Powa_Frames[i]:SetHeight( Powa_Frames[i]:GetHeight() - (elapsed * speedScale * (2-PowaSet[i].torsion) ) )

				if (curScale.a < 0.0) then
					Powa_Frames[i]:SetAlpha(0.0);
					Powa_Frames[i].statut = 1;
				else
					Powa_Frames[i]:SetAlpha(curScale.a);
				end
			end
		-- rotation autour du centre
		elseif (PowaSet[i].anim1 == 10) then
			maxScale.w = math.max(PowaSet[i].x, -PowaSet[i].x, 5) * 1.0;
			maxScale.h = maxScale.w * (1.6 - PowaSet[i].torsion);
			speedScale = elapsed * 75 * PowaSet[i].speed;
			
			if ((i == SecondeAura) and (PowaSet[CurrentSecondeAura].anim1 == 10)) then
				if (PowaSet[i].symetrie < 2) then
					Powa_Frames[i].statut = Powa_Frames[CurrentSecondeAura].statut + 180;
					if (Powa_Frames[i].statut > 360) then Powa_Frames[i].statut = Powa_Frames[i].statut - 360; end
				else
					Powa_Frames[i].statut = 180-Powa_Frames[CurrentSecondeAura].statut;
					if (Powa_Frames[i].statut < 0) then Powa_Frames[i].statut = Powa_Frames[i].statut + 360; end
				end
			elseif (PowaSet[i].symetrie == 1 or PowaSet[i].symetrie == 3) then
				Powa_Frames[i].statut = Powa_Frames[i].statut - speedScale;
				if (Powa_Frames[i].statut < 0) then Powa_Frames[i].statut = 360; end
			else
				Powa_Frames[i].statut = Powa_Frames[i].statut + speedScale;
				if (Powa_Frames[i].statut > 360) then Powa_Frames[i].statut = 0; end
			end

			-- annule la torsion
			Powa_Frames[i]:SetWidth(curScale.w / PowaSet[i].torsion);
			Powa_Frames[i]:SetHeight(curScale.h / (2-PowaSet[i].torsion));
			-- annule la symetrie
			Powa_textures[i]:SetTexCoord(0, 1, 0, 1);

			-- transparence
			if (Powa_Frames[i].statut < 180) then -- zone de transparence
				if (Powa_Frames[i].statut < 90) then
					Powa_Frames[i]:SetAlpha( (1-(Powa_Frames[i].statut / 90)) * PowaSet[i].alpha );
				else
					Powa_Frames[i]:SetAlpha( ((Powa_Frames[i].statut-90) / 90) * PowaSet[i].alpha );
				end
			else
				Powa_Frames[i]:SetAlpha(PowaSet[i].alpha);
			end

			Powa_Frames[i]:SetPoint("Center",maxScale.w * cos(Powa_Frames[i].statut), (maxScale.h * sin(Powa_Frames[i].statut)) + PowaSet[i].y);
		end

		-- si duration
		if (PowaSet[i].duration > 0) then
			-- ajoute le temps passe
			Powa_Frames[i].duree = Powa_Frames[i].duree + elapsed;
		end

	-- FADE OUT
	elseif Powa_Frames[i]:IsVisible() then

	    if (PowaSet[i].finish > 0) then
		curScale.a = Powa_Frames[i]:GetAlpha() - (elapsed * 2);

		if (curScale.a <= 0) then
			Powa_Frames[i]:Hide();
		else
			if (PowaSet[i].finish == 1) then -- agrandir + fade
				Powa_Frames[i]:SetWidth(Powa_Frames[i]:GetWidth() + (elapsed * 200) );
				Powa_Frames[i]:SetHeight(Powa_Frames[i]:GetHeight() + (elapsed * 200) );
			elseif (PowaSet[i].finish == 2) then -- retrecir + fade
				Powa_Frames[i]:SetWidth( math.max(0, Powa_Frames[i]:GetWidth() - (elapsed * 200)) );
				Powa_Frames[i]:SetHeight( math.max(0, Powa_Frames[i]:GetHeight() - (elapsed * 200)) );
			end
			Powa_Frames[i]:SetAlpha(curScale.a);
		end
	    else
		Powa_Frames[i]:Hide();
	    end
	end

     end

     Powa_ResetTimers(); -- reset Timers

end

-- ----------------------------------------------------------------------------- LIGNE DE COMMANDE

function Powa_SlashHandler(msg)
	msgNumber = 0;

	if (PowaBarConfigFrame:IsVisible()) then
		Powa_OptionClose();
	else
		Powa_OptionHideAll();
		Powa_InitPage();
		PowaModTest = true;
		PowaBarConfigFrame:Show();
		PlaySound("TalentScreenOpen");
	end
end

-- --------------------------------------------------------------------------- GESTION DES OPTIONS

function Powa_InitPage()
	getglobal("PowaDropDownAnim1Text"):SetText(PowaAnim[PowaSet[CurrentAura].anim1]);
	getglobal("PowaDropDownAnim2Text"):SetText(PowaAnim[PowaSet[CurrentAura].anim2]);
	getglobal("PowaDropDownAnimBeginText"):SetText(PowaDisplay[PowaSet[CurrentAura].begin]);
	getglobal("PowaDropDownAnimEndText"):SetText(PowaDisplay[PowaSet[CurrentAura].finish]);

	getglobal("PowaBarAuraTextureSlider"):SetValue(PowaSet[CurrentAura].texture);
	getglobal("PowaBarAuraAlphaSlider"):SetValue(PowaSet[CurrentAura].alpha);
	getglobal("PowaBarAuraSizeSlider"):SetValue(PowaSet[CurrentAura].size);
	getglobal("PowaBarAuraCoordSlider"):SetValue(PowaSet[CurrentAura].y);
	getglobal("PowaBarAuraCoordXSlider"):SetValue(PowaSet[CurrentAura].x);
	getglobal("PowaBarAuraCoordYEdit"):SetText(PowaSet[CurrentAura].y);
	getglobal("PowaBarAuraCoordXEdit"):SetText(PowaSet[CurrentAura].x);
	getglobal("PowaBarAuraAnimSpeedSlider"):SetValue(PowaSet[CurrentAura].speed);
	getglobal("PowaBarAuraDurationSlider"):SetValue(PowaSet[CurrentAura].duration);
	getglobal("PowaBarAuraSymSlider"):SetValue(PowaSet[CurrentAura].symetrie);
	getglobal("PowaBarAuraDeformSlider"):SetValue(PowaSet[CurrentAura].torsion);
	getglobal("PowaBarBuffName"):SetText(PowaSet[CurrentAura].buffname);

	getglobal("AuraTexture"):SetTexture("Interface\\Addons\\PowerAuras\\Aura"..PowaSet[CurrentAura].texture..".tga");
	getglobal("PowaColorNormalTexture"):SetVertexColor(PowaSet[CurrentAura].r,PowaSet[CurrentAura].g,PowaSet[CurrentAura].b);
	getglobal("AuraTexture"):SetVertexColor(PowaSet[CurrentAura].r,PowaSet[CurrentAura].g,PowaSet[CurrentAura].b);

	-- affiche la symetrie
	    if (PowaSet[CurrentAura].symetrie == 1) then getglobal("AuraTexture"):SetTexCoord(1, 0, 0, 1); -- inverse X
	elseif (PowaSet[CurrentAura].symetrie == 2) then getglobal("AuraTexture"):SetTexCoord(0, 1, 1, 0); -- inverse Y
	elseif (PowaSet[CurrentAura].symetrie == 3) then getglobal("AuraTexture"):SetTexCoord(1, 0, 1, 0); -- inverse XY
	else getglobal("AuraTexture"):SetTexCoord(0, 1, 0, 1); end

	-- cherche si le nom de la texture est valide
	for a in string.gfind( getglobal("AuraTexture"):GetTexture(), "(%d+)" ) do
		if (a ~= tostring(PowaSet[CurrentAura].texture)) then
			getglobal("AuraTexture"):SetTexture("Interface\\CharacterFrame\\TempPortrait.tga");
		end
	end

	if (PowaSet[CurrentAura].icon == "") then
		getglobal("PowaIconTexture"):SetTexture("Interface\\InventoryItems\\WowUnknownItem01");
	else
		getglobal("PowaIconTexture"):SetTexture(PowaSet[CurrentAura].icon);
	end

	getglobal("PowaColor_SwatchBg").r = PowaSet[CurrentAura].r;
	getglobal("PowaColor_SwatchBg").g = PowaSet[CurrentAura].g;
	getglobal("PowaColor_SwatchBg").b = PowaSet[CurrentAura].b;

	getglobal("PowaHeader"):SetText("POWER AURAS "..PowaVersion);
	getglobal("powa_Text"):SetText(PowaText.nomTitre.." "..CurrentAura.."/"..MaxAuras);
	getglobal("PowaHideAllButton"):SetText(PowaText.nomHide);
	getglobal("PowaTestButton"):SetText(PowaText.nomTest);
	getglobal("PowaCloseButton"):SetText(PowaText.nomClose);
	getglobal("PowaListButton"):SetText(PowaText.nomListe);

	if (PowaSet[CurrentAura].isdebuff) then 
		getglobal("PowaBuffButton"):SetChecked(false);
		getglobal("PowaDebuffButton"):SetChecked(true);
		getglobal("PowaDebuffTypeButton"):SetChecked(false);
		getglobal("PowaBarBuffNameText"):SetText(PowaText.nomDebuff);
		getglobal("TitreTexture"):SetVertexColor(0.8,0.2,0.2);
		getglobal("PowaBarBuffName").aide = PowaText.aideBuff2;
		
	elseif (PowaSet[CurrentAura].isdebufftype) then
		getglobal("PowaBuffButton"):SetChecked(false);
		getglobal("PowaDebuffTypeButton"):SetChecked(true);
		getglobal("PowaDebuffButton"):SetChecked(false);
		getglobal("PowaBarBuffNameText"):SetText(PowaText.nomDebuffType);
		getglobal("TitreTexture"):SetVertexColor(0.8,0.8,0.2);
		getglobal("PowaBarBuffName").aide = PowaText.aideBuff3;
	else
		getglobal("PowaBuffButton"):SetChecked(true);
		getglobal("PowaDebuffButton"):SetChecked(false);
		getglobal("PowaDebuffTypeButton"):SetChecked(false);
		getglobal("PowaBarBuffNameText"):SetText(PowaText.nomBuff);
		getglobal("TitreTexture"):SetVertexColor(0.2,0.8,0.2);
		getglobal("PowaBarBuffName").aide = PowaText.aideBuff;
	end

	getglobal("PowaShowTimerButton"):SetChecked(PowaSet[CurrentAura].timer);
	getglobal("PowaIgnoreMajButton"):SetChecked(PowaSet[CurrentAura].ignoremaj);
	getglobal("PowaInverseButton"):SetChecked(PowaSet[CurrentAura].inverse);
	if (PowaSet[CurrentAura].inverse) then
		PowaSet[CurrentAura].timer = false;
		getglobal("PowaShowTimerButton"):SetChecked(PowaSet[CurrentAura].timer);
		Powa_DisableCheckBox("PowaShowTimerButton");
	else
		Powa_EnableCheckBox("PowaShowTimerButton");
	end
end

function Powa_ChangePagePrev() -- page precedente
	if (CurrentAura == 1) then 
		CurrentAura = MaxAuras;
	else
		CurrentAura = CurrentAura - 1;
	end
	Powa_InitPage();
end

function Powa_ChangePageNext() -- page suivante
	if (CurrentAura == MaxAuras) then 
		CurrentAura = 1;
	else
		CurrentAura = CurrentAura + 1;
	end
	Powa_InitPage();
end

function Powa_UpdateAura() -- met a jour l'effet apres modification d'options

	if (PowaEnabled == 0) then return; end   -- desactived

	Powa_FramesVisibleTime[CurrentAura] = 0;
	Powa_FramesVisibleTime[SecondeAura] = 0;

	if (Powa_Frames[CurrentAura]:IsVisible()) then -- sinon on affiche seulement si deja visible
		Powa_DisplayAura(CurrentAura);
	end
end

function Powa_OptionClose() -- ferme la fenetre d'option
	PowaModTest = false;
	getglobal("PowaBarConfigFrame"):Hide();
	getglobal("PowaListFrame"):Hide();
	PlaySound("TalentScreenClose");
	-- cache tous les effets en test
	for i = 1, MaxAuras+2 do
		if (PowaSet[i].duration > 0) then
			Powa_Frames[i].duree = 31; -- force affiche et mode transparent
			Powa_Frames[i]:Show();
			Powa_Frames[i]:SetAlpha(0.0);
			Powa_FramesVisibleTime[i] = 1;
		else
			Powa_FramesVisibleTime[i] = 0;
		end
	end
	Powa_NewCheckBuffs(); -- detect les effets en cours
end

function Powa_OptionTest() -- teste ou masque l'effet choisi
	if (Powa_Frames[CurrentAura]:IsVisible()) then -- deja visible, on la cache
		Powa_FramesVisibleTime[CurrentAura] = 0;
		Powa_FramesVisibleTime[SecondeAura] = 0;
	else                                           -- pas visible alors on affiche
		Powa_DisplayAura(CurrentAura);
	end
end

function Powa_OptionHideAll() -- cache tous les effets
	-- cache tous les effets en test
	for i = 1, MaxAuras+2 do
		Powa_FramesVisibleTime[i] = 0;
	end
end

function Powa_ClearEditor()
local a,b,c;

	-- premier passage, on trie les effets
	a = 1;   -- buffs
	b = 101; -- debuffs
	c = 201; -- debuffs type
	for i = 1, 100 do
		if (PowaSet[i]) then -- si l'effet existe
			if (PowaSet[i].buffname ~= "" and PowaSet[i].buffname ~= " ") then -- et si il porte un nom

				if (PowaSet[i].isdebuff) then
					PowaSet[b] = PowaSet[i];       -- alors c bon
					PowaSet[i] = nil;
					b = b+1;
				elseif (PowaSet[i].isdebufftype) then
					PowaSet[c] = PowaSet[i];       -- alors c bon
					PowaSet[i] = nil;
					c = c+1;
				else
					PowaSet[a] = PowaSet[i];       -- alors c bon
					if (i>a) then
						PowaSet[i] = nil;
					end
					a = a+1;
				end
			else
				PowaSet[i] = nil;
			end
		end
	end
	-- second passage, on zappe les vides
	a = 1;
	for i = 1, 300 do
		if (PowaSet[i]) then -- si l'effet existe
			if (PowaSet[i].buffname ~= "" and PowaSet[i].buffname ~= " ") then -- et si il porte un nom
				PowaSet[a] = PowaSet[i];                                   -- alors c bon
				if (i>a) then
					PowaSet[i] = nil;
				end
				a = a+1;
			else
				PowaSet[i] = nil;
			end
		end
	end

	a = a-1;
	if (a < 1) then a = 1; end

	PowaEnabled = 0;          -- desactive temporairement les effets
	Powa_OptionHideAll();       -- cache tout les effets en cours
	MaxAuras = a;	              -- definie le max d'aura
	SecondeAura = MaxAuras + 1;     -- definie la derniere aura
	CurrentTestAura = MaxAuras + 2;  
	PowaMisc.maxeffects = MaxAuras; -- sauve le nombre max d'effet
	Powa_InitTabs();                -- initialise les pages d'effets en plus
	Powa_CreateFrames();          -- cree les textures des effets en plus
	PowaEnabled = 1;            -- reactive les effets
	CurrentAura = 1;          -- defini l'effet en cours 1
	Powa_InitPage();        -- initalise les pages des options
end

function Powa_AddEffect()

	PowaEnabled = 0;          -- desactive temporairement les effets
	Powa_OptionHideAll();       -- cache tout les effets en cours

	MaxAuras = MaxAuras + 1;
	if (MaxAuras > 100) then MaxAuras = 100; end

	SecondeAura = MaxAuras + 1;     -- definie la derniere aura
	CurrentTestAura = MaxAuras + 2;
	PowaSet[MaxAuras] = nil;
	PowaMisc.maxeffects = MaxAuras; -- sauve le nombre max d'effet
	Powa_InitTabs();                -- initialise les pages d'effets en plus
	Powa_CreateFrames();          -- cree les textures des effets en plus
	PowaEnabled = 1;            -- reactive les effets
	CurrentAura = MaxAuras;   -- defini l'effet en cours 1
	Powa_InitPage();        -- initalise les pages des options
end

-- ---------------------------------------------------------------------------------- FENETRE D'OPTION

function PowaBarAuraTextureSliderChanged()
	local SliderValue = getglobal("PowaBarAuraTextureSlider"):GetValue();

	getglobal("PowaBarAuraTextureSliderText"):SetText(PowaText.nomTexture.." : "..SliderValue);
	getglobal("AuraTexture"):SetTexture("Interface\\Addons\\PowerAuras\\Aura"..SliderValue..".tga");
	getglobal("AuraTexture"):SetVertexColor(PowaSet[CurrentAura].r,PowaSet[CurrentAura].g,PowaSet[CurrentAura].b);

	-- cherche si le nom de la texture est valide
	for a in string.gfind( getglobal("AuraTexture"):GetTexture(), "(%d+)" ) do
		if (a ~= tostring(SliderValue)) then
			getglobal("AuraTexture"):SetTexture("Interface\\CharacterFrame\\TempPortrait.tga");
			Powa_textures[CurrentAura]:SetTexture("");
		end
	end

	PowaSet[CurrentAura].texture = SliderValue;
	Powa_UpdateAura();
end

function PowaBarAuraAlphaSliderChanged()
	local SliderValue = getglobal("PowaBarAuraAlphaSlider"):GetValue();

	getglobal("PowaBarAuraAlphaSliderText"):SetText(PowaText.nomAlpha.." : "..format("%.0f",SliderValue*100).."%");

	PowaSet[CurrentAura].alpha = SliderValue;
	Powa_UpdateAura();
end

function PowaBarAuraSizeSliderChanged()
	local SliderValue = getglobal("PowaBarAuraSizeSlider"):GetValue();

	getglobal("PowaBarAuraSizeSliderText"):SetText(PowaText.nomTaille.." : "..format("%.0f",SliderValue*100).."%");

	PowaSet[CurrentAura].size = SliderValue;
	Powa_UpdateAura();
end

function PowaBarAuraCoordSliderChanged()
	local SliderValue = getglobal("PowaBarAuraCoordSlider"):GetValue();

	getglobal("PowaBarAuraCoordSliderText"):SetText(PowaText.nomPos.." Y : "..SliderValue);
	if (getglobal("PowaBarAuraCoordYEdit")) then
		getglobal("PowaBarAuraCoordYEdit"):SetText(SliderValue);
	end

	PowaSet[CurrentAura].y = SliderValue;
	Powa_UpdateAura();
end

function PowaBarAuraCoordXSliderChanged()
	local SliderValue = getglobal("PowaBarAuraCoordXSlider"):GetValue();

	getglobal("PowaBarAuraCoordXSliderText"):SetText(PowaText.nomPos.." X : "..SliderValue);
	if (getglobal("PowaBarAuraCoordXEdit")) then
		getglobal("PowaBarAuraCoordXEdit"):SetText(SliderValue);
	end

	PowaSet[CurrentAura].x = SliderValue;
	Powa_UpdateAura();
end

function PowaBarAuraAnimSpeedSliderChanged()
	local SliderValue = getglobal("PowaBarAuraAnimSpeedSlider"):GetValue();

	getglobal("PowaBarAuraAnimSpeedSliderText"):SetText(PowaText.nomSpeed.." : "..format("%.0f",SliderValue*100).."%");

	PowaSet[CurrentAura].speed = SliderValue;
	Powa_UpdateAura();
end

function PowaBarAuraAnimDurationSliderChanged()
	local SliderValue = getglobal("PowaBarAuraDurationSlider"):GetValue();

	getglobal("PowaBarAuraDurationSliderText"):SetText(PowaText.nomDuration.." : "..SliderValue.." sec");

	PowaSet[CurrentAura].duration = SliderValue;
	Powa_UpdateAura();
end

function PowaBarAuraSymSliderChanged()
	local SliderValue = getglobal("PowaBarAuraSymSlider"):GetValue();

	if (SliderValue == 0) then
		getglobal("PowaBarAuraSymSliderText"):SetText(PowaText.nomSymetrie.." : "..PowaText.aucune);
		getglobal("AuraTexture"):SetTexCoord(0, 1, 0, 1);
	elseif (SliderValue == 1) then
		getglobal("PowaBarAuraSymSliderText"):SetText(PowaText.nomSymetrie.." : X");
		getglobal("AuraTexture"):SetTexCoord(1, 0, 0, 1);
	elseif (SliderValue == 2) then
		getglobal("PowaBarAuraSymSliderText"):SetText(PowaText.nomSymetrie.." : Y");
		getglobal("AuraTexture"):SetTexCoord(0, 1, 1, 0);
	elseif (SliderValue == 3) then
		getglobal("PowaBarAuraSymSliderText"):SetText(PowaText.nomSymetrie.." : XY");
		getglobal("AuraTexture"):SetTexCoord(1, 0, 1, 0);
	end

	PowaSet[CurrentAura].symetrie = SliderValue;
	Powa_UpdateAura();
end

function PowaBarAuraDeformSliderChanged()
	local SliderValue = getglobal("PowaBarAuraDeformSlider"):GetValue();

	getglobal("PowaBarAuraDeformSliderText"):SetText(PowaText.nomDeform.." : "..format("%.2f", SliderValue));

	PowaSet[CurrentAura].torsion = SliderValue;
	Powa_UpdateAura();
end

function PowaMaxTexSliderChanged()
	local SliderValue = getglobal("PowaMaxTexSlider"):GetValue();

	getglobal("PowaMaxTexSliderText"):SetText(PowaText.nomMaxTex.." : "..SliderValue);

	getglobal("PowaBarAuraTextureSlider"):SetMinMaxValues(1,SliderValue);
	getglobal("PowaBarAuraTextureSliderHigh"):SetText(SliderValue);

	PowaGlobal.maxtextures = SliderValue;
end

function PowaTextCoordXChanged()
	local thisText = getglobal("PowaBarAuraCoordXEdit"):GetText();
	local thisNumber = tonumber(thisText);

	if (thisNumber == nil) then
		getglobal("PowaBarAuraCoordXSliderText"):SetText(PowaText.nomPos.." X : "..0);
		getglobal("PowaBarAuraCoordXSlider"):SetValue(0);
		getglobal("PowaBarAuraCoordXEdit"):SetText(0);
		PowaSet[CurrentAura].x = 0;	
	else
		if (thisNumber > 300 or thisNumber < -300) then
			getglobal("PowaBarAuraCoordXEdit"):SetText(thisNumber);
			Powa_DisableSlider("PowaBarAuraCoordXSlider");
		else
			Powa_EnableSlider("PowaBarAuraCoordXSlider");
			getglobal("PowaBarAuraCoordXSliderText"):SetText(PowaText.nomPos.." X : "..thisNumber);
			getglobal("PowaBarAuraCoordXSlider"):SetValue(thisNumber);
		end
		PowaSet[CurrentAura].x = thisNumber;
	end
	Powa_UpdateAura();
end

function PowaTextCoordYChanged()
	local thisText = getglobal("PowaBarAuraCoordYEdit"):GetText();
	local thisNumber = tonumber(thisText);

	if (thisNumber == nil) then
		getglobal("PowaBarAuraCoordSliderText"):SetText(PowaText.nomPos.." Y : "..0);
		getglobal("PowaBarAuraCoordSlider"):SetValue(0);
		getglobal("PowaBarAuraCoordYEdit"):SetText(0);
		PowaSet[CurrentAura].y = 0;	
	else
		if (thisNumber > 300 or thisNumber < -300) then
			getglobal("PowaBarAuraCoordYEdit"):SetText(thisNumber);
			Powa_DisableSlider("PowaBarAuraCoordSlider");
		else
			Powa_EnableSlider("PowaBarAuraCoordSlider");
			getglobal("PowaBarAuraCoordSliderText"):SetText(PowaText.nomPos.." Y : "..thisNumber);
			getglobal("PowaBarAuraCoordSlider"):SetValue(thisNumber);
		end
		PowaSet[CurrentAura].y = thisNumber;
	end
	Powa_UpdateAura();
end

function PowaTextChanged()
	local oldText = getglobal("PowaBarBuffName"):GetText();

	if (oldText == PowaSet[CurrentAura].buffname) then -- meme texte
	else
		PowaSet[CurrentAura].buffname = getglobal("PowaBarBuffName"):GetText();
		PowaSet[CurrentAura].icon = "";
		getglobal("PowaIconTexture"):SetTexture("Interface\\InventoryItems\\WowUnknownItem01");
	end
end

function PowaBuffChecked()
	PowaSet[CurrentAura].isdebuff = false;
	PowaSet[CurrentAura].isdebufftype = false;
	getglobal("PowaBuffButton"):SetChecked(true);
	getglobal("PowaDebuffButton"):SetChecked(false);
	getglobal("PowaDebuffTypeButton"):SetChecked(false);
	getglobal("PowaBarBuffName").aide = PowaText.aideBuff;
	getglobal("PowaBarBuffNameText"):SetText(PowaText.nomBuff);
	getglobal("TitreTexture"):SetVertexColor(0.2,0.8,0.2);
end

function PowaDebuffChecked()
	PowaSet[CurrentAura].isdebuff = true;
	PowaSet[CurrentAura].isdebufftype = false;
	getglobal("PowaBuffButton"):SetChecked(false);
	getglobal("PowaDebuffButton"):SetChecked(true);
	getglobal("PowaDebuffTypeButton"):SetChecked(false);
	getglobal("PowaBarBuffName").aide = PowaText.aideBuff2;
	getglobal("PowaBarBuffNameText"):SetText(PowaText.nomDebuff);
	getglobal("TitreTexture"):SetVertexColor(0.8,0.2,0.2);
end

function PowaDebuffTypeChecked()
	PowaSet[CurrentAura].isdebuff = false;
	PowaSet[CurrentAura].isdebufftype = true;
	getglobal("PowaBuffButton"):SetChecked(false);
	getglobal("PowaDebuffButton"):SetChecked(false);
	getglobal("PowaDebuffTypeButton"):SetChecked(true);
	getglobal("PowaBarBuffName").aide = PowaText.aideBuff3;
	getglobal("PowaBarBuffNameText"):SetText(PowaText.nomDebuffType);
	getglobal("TitreTexture"):SetVertexColor(0.8,0.8,0.2);
end

function PowaShowTimerChecked()
	if (getglobal("PowaShowTimerButton"):GetChecked()) then
		PowaSet[CurrentAura].timer = true;
	else
		PowaSet[CurrentAura].timer = false;
	end
end

function PowaInverseChecked()
	if (getglobal("PowaInverseButton"):GetChecked()) then
		PowaSet[CurrentAura].inverse = true;
		PowaSet[CurrentAura].timer = false;
		getglobal("PowaShowTimerButton"):SetChecked(false);
		Powa_DisableCheckBox("PowaShowTimerButton");
	else
		PowaSet[CurrentAura].inverse = false;
		Powa_EnableCheckBox("PowaShowTimerButton");
	end
end

function PowaIgnoreMajChecked()
	if (getglobal("PowaIgnoreMajButton"):GetChecked()) then
		PowaSet[CurrentAura].ignoremaj = true;
	else
		PowaSet[CurrentAura].ignoremaj = false;
	end
end

function PowaDropDownMenu_Initialize() 
	local info;

	if (this:GetName() == "PowaDropDownAnim1Button" or this:GetName() == "PowaDropDownAnim1") then
		for i = 1, 10 do
			info = {}; 
			info.text = PowaAnim[i]; 
			info.func = PowaDropDownMenu_OnClickAnim1;
			UIDropDownMenu_AddButton(info);
		end
		UIDropDownMenu_SetSelectedValue(PowaDropDownAnim1, PowaAnim[PowaSet[CurrentAura].anim1]);
	elseif (this:GetName() == "PowaDropDownAnim2Button" or this:GetName() == "PowaDropDownAnim2") then
		for i = 0, 10 do
			info = {}; 
			info.text = PowaAnim[i]; 
			info.func = PowaDropDownMenu_OnClickAnim2;
			UIDropDownMenu_AddButton(info);
		end
		UIDropDownMenu_SetSelectedValue(PowaDropDownAnim2, PowaAnim[PowaSet[CurrentAura].anim2]);
	elseif (this:GetName() == "PowaDropDownAnimBeginButton" or this:GetName() == "PowaDropDownAnimBegin") then
		for i = 0, 11 do
			info = {}; 
			info.text = PowaDisplay[i]; 
			info.func = PowaDropDownMenu_OnClickBegin;
			UIDropDownMenu_AddButton(info);
		end
		UIDropDownMenu_SetSelectedValue(PowaDropDownAnimBegin, PowaDisplay[PowaSet[CurrentAura].begin]);
	elseif (this:GetName() == "PowaDropDownAnimEndButton" or this:GetName() == "PowaDropDownAnimEnd") then
		for i = 0, 3 do
			info = {}; 
			info.text = PowaDisplay[i]; 
			info.func = PowaDropDownMenu_OnClickEnd;
			UIDropDownMenu_AddButton(info);
		end
		UIDropDownMenu_SetSelectedValue(PowaDropDownAnimEnd, PowaDisplay[PowaSet[CurrentAura].finish]);
	end
end

function PowaDropDownMenu_OnClickAnim1()
	local optionID = this:GetID();

	UIDropDownMenu_SetSelectedID(PowaDropDownAnim1, optionID); 
	local optionName =  UIDropDownMenu_GetText(PowaDropDownAnim1); 
	UIDropDownMenu_SetSelectedValue(PowaDropDownAnim1, optionName);

	PowaSet[CurrentAura].anim1 = optionID;
	Powa_UpdateAura();
end

function PowaDropDownMenu_OnClickAnim2()
	local optionID = this:GetID();

	UIDropDownMenu_SetSelectedID(PowaDropDownAnim2, optionID); 
	local optionName =  UIDropDownMenu_GetText(PowaDropDownAnim2); 
	UIDropDownMenu_SetSelectedValue(PowaDropDownAnim2, optionName);

	PowaSet[CurrentAura].anim2 = optionID - 1;
	Powa_UpdateAura();
end

function PowaDropDownMenu_OnClickBegin()
	local optionID = this:GetID();

	UIDropDownMenu_SetSelectedID(PowaDropDownAnimBegin, optionID); 
	local optionName =  UIDropDownMenu_GetText(PowaDropDownAnimBegin); 
	UIDropDownMenu_SetSelectedValue(PowaDropDownAnimBegin, optionName);

	PowaSet[CurrentAura].begin = optionID - 1;
	Powa_UpdateAura();
end

function PowaDropDownMenu_OnClickEnd()
	local optionID = this:GetID();

	UIDropDownMenu_SetSelectedID(PowaDropDownAnimEnd, optionID); 
	local optionName =  UIDropDownMenu_GetText(PowaDropDownAnimEnd); 
	UIDropDownMenu_SetSelectedValue(PowaDropDownAnimEnd, optionName);

	PowaSet[CurrentAura].finish = optionID - 1;
	Powa_UpdateAura();
end

function Powa_DisableSlider(slider)
	getglobal(slider):EnableMouse(false);
	getglobal(slider.."Text"):SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
	getglobal(slider.."Low"):SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
	getglobal(slider.."High"):SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
end

function Powa_EnableSlider(slider)
	getglobal(slider):EnableMouse(true);
	getglobal(slider.."Text"):SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
	getglobal(slider.."Low"):SetTextColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	getglobal(slider.."High"):SetTextColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
end

function Powa_DisableCheckBox(checkBox)
	getglobal(checkBox):Disable();
	getglobal(checkBox.."Text"):SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
end

function Powa_EnableCheckBox(checkBox, checked)
	getglobal(checkBox):Enable();
	getglobal(checkBox.."Text"):SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);	
end

-- ---------------------------------------------------------------------------- OPTIONS DEPLACEMENT

function PowaBar_MouseDown( strButton, frmFrame)
	if( strButton == "LeftButton") then
		getglobal( frmFrame ):StartMoving( );
	end
end

function PowaBar_MouseUp( strButton, frmFrame)
	getglobal( frmFrame ):StopMovingOrSizing( );
end

-- ----------------------------------------------------------------------------------- COLOR PICKER

function PowaOptionsFrame_SetColor()
	local r,g,b = ColorPickerFrame:GetColorRGB();
	local swatch,frame;
	swatch = getglobal("PowaColorNormalTexture"); -- juste le visuel
	frame = getglobal("PowaColor_SwatchBg");      -- enregistre la couleur
	swatch:SetVertexColor(r,g,b);
	frame.r = r;
	frame.g = g;
	frame.b = b;

	PowaSet[CurrentAura].r = r;
	PowaSet[CurrentAura].g = g;
	PowaSet[CurrentAura].b = b;

	getglobal("AuraTexture"):SetVertexColor(r,g,b);
	Powa_UpdateAura();
end

function PowaOptionsFrame_CancelColor()
	local r = ColorPickerFrame.previousValues.r;
	local g = ColorPickerFrame.previousValues.g;
	local b = ColorPickerFrame.previousValues.b;
	local swatch,frame;
	swatch = getglobal("PowaColorNormalTexture"); -- juste le visuel
	frame = getglobal("PowaColor_SwatchBg");      -- enregistre la couleur
	swatch:SetVertexColor(r,g,b);
	frame.r = r;
	frame.g = g;
	frame.b = b;

	getglobal("AuraTexture"):SetVertexColor(r,g,b);
end

function Powa_OpenColorPicker()
	CloseMenus();
	
	button = getglobal("PowaColor_SwatchBg");

	ColorPickerFrame.func = PowaOptionsFrame_SetColor -- button.swatchFunc;
	ColorPickerFrame:SetColorRGB(button.r, button.g, button.b);
	ColorPickerFrame.previousValues = {r = button.r, g = button.g, b = button.b, opacity = button.opacity};
	ColorPickerFrame.cancelFunc = PowaOptionsFrame_CancelColor

	ColorPickerFrame:SetPoint("TOPLEFT", "PowaBarConfigFrame", "TOPRIGHT", 0, 0)

	ColorPickerFrame:Show();
end
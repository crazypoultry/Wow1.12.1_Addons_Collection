----------------------------------------------------------
-- Morganti's Buffbars
-- http://ui.worldofwar.net/users.php?id=211554
-- by morganti@cho'gall
----------------------------------------------------------

m_buffbar 			= {};
masterbuff_list = {};
buff_list 			= {};
debuff_list 		= {};
weaponbuff_list	= {};
local playerID,myclass;local last_scan = time();local scan_interval = 1;
local ver = 1.4;
local vver= 1;

function m_buffbar_onload()
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("PLAYER_AURAS_CHANGED");
end

function m_buffbar_onevent(event)
	if (event == "VARIABLES_LOADED") then
		--hide the default buffs
		BuffFrame:Hide();
		TemporaryEnchantFrame:Hide()
		
		--disable dragging my frames off the screen
    m_BuffFrameCapsule:SetClampedToScreen();
    m_DeBuffFrameCapsule:SetClampedToScreen();
    m_WepBuffFrameCapsule:SetClampedToScreen();
    m_options:SetClampedToScreen();

		--color the buff/debuff/weapon buffs for the display guides
		for i=1, 16 do
			local d = "m_BuffButton" .. i;
			local button = getglobal(d);
	    button:SetBackdropBorderColor(0, 0.75, 1);
	    button:SetBackdropColor(0, .78, 1, .85);
		end	
		for i=1, 8 do
			local d = "m_DeBuffButton" .. i;
			local button = getglobal(d);
	    button:SetBackdropBorderColor(1, .12, .12);
	    button:SetBackdropColor(.82, 0, 0, .85);
		end
		m_WepBuffButton1:SetBackdropBorderColor(0.7058824, 0.3215686, 0.9921569);
		m_WepBuffButton1:SetBackdropColor(0.7058824, 0.3215686, 0.9921569, .85);
		m_WepBuffButton2:SetBackdropBorderColor(0.7058824, 0.3215686, 0.9921569);
		m_WepBuffButton2:SetBackdropColor(0.7058824, 0.3215686, 0.9921569, .85);
		
		--setup slash command		
		SlashCmdList["M_SLASHCOMMANDS"] = m_slashcommands;
		SLASH_M_SLASHCOMMANDS1 = "/mb";
		SLASH_M_SLASHCOMMANDS2 = "/morgb";
		

		myclass = UnitClass("player");
		playerID = UnitName("player").." - "..GetRealmName();
		
		if (not m_buffbar[playerID]) then
				m_buffbar[playerID] = {
								version = ver;
								vversion= vver;
                buffs	= {
                    displaymode = 5;
                    downup	= "DOWN";
                    rightleft = 0;
                    flashtime = 30;
                    moveable = 0;
                    size	= 0;
                    icon_side	= 0;
                    scale	= 1;
          	    };
                debuffs	= {
                    displaymode = 0;
                    downup	= "DOWN";
                    rightleft = 1;
                    flashtime = 1;
                    moveable = 0;
                    size	= 1;
                    icon_side	= 1;
                    scale	= 1;                    
          	    };
                wepbuffs = {
                    displaymode = 3;
                    downup = "DOWN";
                    rightleft = 0;
                    flashtime = 90;
                    cflashtime = 10;
                    moveable = 0;
                    size = 0;
                    icon_side = 0;
                    scale	= 1;                    
                };
			};
		end

		m_boptions = m_buffbar[playerID]['buffs'];
		m_doptions = m_buffbar[playerID]['debuffs'];
		m_woptions = m_buffbar[playerID]['wepbuffs'];
		m_moptions = m_buffbar[playerID];

		if (not m_moptions.vversion or m_moptions.vversion < vver) then
			m_printmsg("|cff00ff00[Morganti's Buffbar] new variables have been added to mod, must reset saved settings, sorry.");
			m_reset();
			m_options:Show();
		end
		
		if (m_moptions.version < ver) then m_moptions.version = ver; end
		
		--fill the options menu with the stored settings
    m_updateoptionsmenu();
    --set the buff/debuff/weaponbuff layout according to displaymode
    m_setbufflayout();
    --size the frames around buffs/debuffs/weaponbuffs according to displaymode
    m_sizebuffcapsule();
    --set the scale
    m_setscale();
 
		local msg = "|cff00ff00Morganti's Buffbar|cffffffff loaded. |cff00ff00/mb|cffffffff for options menu. (|cff00ff00shift+left-click|cffffffff) a buff to move it, (|cff00ff00shift+right-click|cffffffff) a buff for options menu.";
		m_printmsg(msg);
		       
	elseif (event == "PLAYER_AURAS_CHANGED") then
		m_scan(); 
	end
end

function m_slashcommands()
	m_options:Show();
end

function m_reset()
				m_buffbar[playerID] = {
								version = ver;
								vversion= vver;
                buffs	= {
                    displaymode = 5;
                    downup	= "DOWN";
                    rightleft = 0;
                    flashtime = 30;
                    moveable = 0;
                    size	= 0;
                    icon_side	= 0;
                    scale	= 1;
          	    };
                debuffs	= {
                    displaymode = 0;
                    downup	= "DOWN";
                    rightleft = 1;
                    flashtime = 1;
                    moveable = 0;
                    size	= 1;
                    icon_side	= 1;
                    scale	= 1;
          	    };
                wepbuffs = {
                    displaymode = 3;
                    downup = "DOWN";
                    rightleft = 0;
                    flashtime = 90;
                    cflashtime = 10;
                    moveable = 0;
                    size = 0;
                    icon_side = 0;
                    scale	= 1;
                };
			};
			
		m_boptions = m_buffbar[playerID]['buffs'];
		m_doptions = m_buffbar[playerID]['debuffs'];
		m_woptions = m_buffbar[playerID]['wepbuffs'];
		m_moptions = m_buffbar[playerID];
		
		m_updateoptionsmenu();
    m_setbufflayout();
    m_sizebuffcapsule();
    m_setscale();
end

function m_setscale()
	m_BuffFrame:SetScale(m_boptions.scale);
	m_BuffFrameCapsule:SetScale(m_boptions.scale);
	m_DeBuffFrame:SetScale(m_doptions.scale);
	m_DeBuffFrameCapsule:SetScale(m_doptions.scale);
	m_WepBuffFrame:SetScale(m_woptions.scale);
	m_WepBuffFrameCapsule:SetScale(m_woptions.scale);	
end

function m_updateoptionsmenu()
    m_changedisplaymode("wtf");
    m_changedebuffdisplaymode("wtf");
    m_changewepbuffdisplaymode("wtf");
    
		if(m_boptions.moveable == 1) then
			if(not m_optionsPanel5Panel2CheckButton1:GetChecked()) then
				m_optionsPanel5Panel2CheckButton1:SetChecked(1);
			end
		else
			m_optionsPanel5Panel2CheckButton1:SetChecked(byrd);
		end
		if(m_doptions.moveable == 1) then
			if(not m_optionsPanel5Panel3Component5:GetChecked()) then
				m_optionsPanel5Panel3Component5:SetChecked(1);
			end
		else
			m_optionsPanel5Panel3Component5:SetChecked(byrd);
		end
		if(m_woptions.moveable == 1) then
			if(not m_optionsPanel5Panel1Container1Component8:GetChecked()) then
				m_optionsPanel5Panel1Container1Component8:SetChecked(1);
			end
		else
			m_optionsPanel5Panel1Container1Component8:SetChecked(byrd);
		end		
            
    m_optionsPanel5Panel1Slider1:SetValue(m_boptions.flashtime);
    m_optionsPanel5Panel1Component2Label:SetText(m_boptions.flashtime);
    
    m_optionsPanel5Panel1Component16:SetValue(m_doptions.flashtime);
    m_optionsPanel5Panel1Component14Label:SetText(m_doptions.flashtime);

    m_optionsPanel5Panel1Component24:SetValue(m_woptions.flashtime);
    m_optionsPanel5Panel1Component22Label:SetText(m_woptions.flashtime);

    m_optionsPanel5Panel1Component28:SetValue(m_woptions.cflashtime);
    m_optionsPanel5Panel1Component26Label:SetText(m_woptions.cflashtime);
  
    m_optionsPanel4:SetBackdropBorderColor(.75,1,0);
    
    m_optionsPanel5Panel1:SetBackdropBorderColor(.75,1,0);
    m_optionsPanel5Panel1:SetBackdropColor(0,0,0, 1);
    
    m_optionsPanel5Panel2:SetBackdropColor(0,.75,1, 1);
    
    m_optionsPanel5Panel3:SetBackdropColor(1,0,0, 1);
    m_optionsPanel5Panel1Container1:SetBackdropColor(0.7058824, 0.3215686, 0.9921569, 1);
    
    m_optionsPanel5Panel1Component29:SetValue(m_boptions.scale);
    m_optionsPanel5Panel1Component31Label:SetText(floor(m_boptions.scale * 100));
    m_optionsPanel5Panel1Component33:SetValue(m_doptions.scale);
    m_optionsPanel5Panel1Component35Label:SetText(floor(m_doptions.scale * 100));
    m_optionsPanel5Panel1Component37:SetValue(m_woptions.scale);
    m_optionsPanel5Panel1Component39Label:SetText(floor(m_woptions.scale * 100));        
end

function m_sizebuffcapsule()
	local buffcount = 0;
	for i=1, 16 do
		local buffbutton = getglobal("m_BuffButton"..i);
		if (buffbutton:IsVisible()) then
			buffcount = buffcount + 1;
		end
	end
	
	if(m_boptions.displaymode >= 0 and m_boptions.displaymode < 4) then
	--------------------------------------------
	-- buffs tiled in columns instead of rows --
	--------------------------------------------
		if(m_boptions.size == 0) then
		--small buffs
			capsuleheight = 382;
			capsulewidth	= 72;
		elseif(m_boptions.size == 1) then
            --large buffs 155,35
            capsuleheight = 35 * buffcount;
            capsulewidth	= 155;
	    end	
	elseif (m_boptions.displaymode >= 4 and m_boptions.displaymode <= 7) then
	-------------------------------------------------------
	-- SCROLL BUFFS LEFT TO RIGHT/RIGHT TO LEFT, IN ROWS --
	-------------------------------------------------------
		if(m_boptions.size == 0) then
		--small buffs
			capsuleheight = 95;
			capsulewidth	= 301;
		elseif(m_boptions.size == 1) then
		--large buffs 155,35
	   	capsuleheight = 35 * buffcount;
	   	capsulewidth	= 155;
	  end			
	elseif (m_boptions.displaymode >= 8 and m_boptions.displaymode <= 9) then
    -- 16 ROWS
		--small buffs
		capsuleheight = 765
		capsulewidth    = floor(72 / 2);
  elseif (m_boptions.displaymode >= 10 and m_boptions.displaymode <= 11) then
    -- 16 Columns
		capsuleheight   = floor(93 / 2);
		capsulewidth    = 606;        
  end
  m_BuffFrameCapsule:SetHeight(capsuleheight);
	m_BuffFrameCapsule:SetWidth(capsulewidth);
	  
  -- WEAPON BUFFS
  if (m_woptions.displaymode < 2) then
  	--SMALL,UP/DOWN
  	m_WepBuffFrameCapsule:SetWidth(35);
  	m_WepBuffFrameCapsule:SetHeight(94);
  elseif (m_woptions.displaymode >= 2 and m_woptions.displaymode < 4) then
  	--SMALL, LEFT/RIGHT
  	m_WepBuffFrameCapsule:SetWidth(72);
  	m_WepBuffFrameCapsule:SetHeight(46);
  elseif (m_woptions.displaymode >= 4 and m_woptions.displaymode <= 7) then
  	--LARGE, UP/DOWN
	  m_WepBuffFrameCapsule:SetWidth(182);
	  m_WepBuffFrameCapsule:SetHeight(64);
  end    

	-- DEBUFFS
	if (m_doptions.size == 1) then    
    m_DeBuffFrameCapsule:SetWidth(180);
    m_DeBuffFrameCapsule:SetHeight(263);
  elseif (m_doptions.size == 0) then
  	if (m_doptions.displaymode > 3 and m_doptions.displaymode < 6) then
	    m_DeBuffFrameCapsule:SetWidth(36);
	    m_DeBuffFrameCapsule:SetHeight(382);
	  elseif (m_doptions.displaymode > 5 and m_doptions.displaymode < 8) then
	  	m_DeBuffFrameCapsule:SetWidth(302);
	    m_DeBuffFrameCapsule:SetHeight(46);
	  end
  end
    
	m_setbufflayout();
end



function m_drawbuff(buttonid)
	local icon,stack,name,btype,bdur,id,dtype,capsuleheight;
	local tempid = buttonid - 1;
	local buffcount = 0;
	
	--set the button id string object
	local d = "m_BuffButton" .. buttonid;
	local u = d .. "a";
	local button = getglobal(d);
	local buttonicon = getglobal(u);
    
  if (buff_list[buttonid]) then
	  
    icon = buff_list[buttonid]['bicon'];
    stack = GetPlayerBuffApplications(buff_list[buttonid]['mid']);
    --name  = buff_list[buttonid]['name'];
    btype = buff_list[buttonid]['btype'];
    
    if(btype ~= 1) then
		--buff has a duration
    	if (m_boptions.size == 0) then
    	--using small buffs so format the duration my way
    		local tmptime = GetPlayerBuffTimeLeft(buff_list[buttonid]['mid']);
    		if (tmptime > 5940) then
    			bdur = "2 h";
    		else	
      		bdur  = m_timestring3(GetPlayerBuffTimeLeft(buff_list[buttonid]['mid']));
      	end
   		else
      	bdur  = m_timestring2(GetPlayerBuffTimeLeft(buff_list[buttonid]['mid']));
    	end
    else
			if (m_boptions.size == 0) then
    		bdur = "--:--";
    	else
    		bdur = "";
    	end
    end
    
    if (stack == 0) then stack = ""; end

    --set the duration object
    local duration = d .. "Duration";
    duration = getglobal(duration);
    --set the icon border object
    local iconborder = d .. "BuffBorder";
    iconborder = getglobal(iconborder);
    --set the buff icon
    local bicon = d .. "Icon";
    bicon = getglobal(bicon);
    --set the buff name object
    local bname = d .. "BuffName";
    bname = getglobal(bname);
    --set the buff stack object
    local bstack = d .. "Stack";
    bstack = getglobal(bstack);
    
    --if(not button:IsVisible()) then
    button:Show();
    buttonicon:Show();
    iconborder:Show();
    --end
    
    if (GetPlayerBuffTimeLeft(buff_list[buttonid]['mid']) <= m_boptions.flashtime and GetPlayerBuffTimeLeft(buff_list[buttonid]['mid'])~= 0 ) then
        local tempdur = GetPlayerBuffTimeLeft(buff_list[buttonid]['mid']);
        local g = string.sub(tempdur, 4, 4);
        if (tempdur > 10) then
            if (tonumber(g)) then
                local f =  1 / g;
                if (f > .275) then
                    button:SetAlpha(f);
                end
            end
        elseif (tempdur < 10 and tempdur >= 1) then
            g = string.sub(tempdur, 3, 3);
            if (tonumber(g)) then
                local f =  1 / g;
                if (f > .175) then
                    button:SetAlpha(f);
                end
            end
        elseif (tempdur < 1) then
        	button:SetAlpha(tempdur);
        end
    else
    		if (GetPlayerBuffTimeLeft(buff_list[buttonid]['mid']) ~= 0 and btype ~= 1) then
        	button:SetAlpha(1);
        elseif (btype == 1) then
        	button:SetAlpha(1);
        end
    end

    --button:SetBackdropBorderColor(0, 0.75, 1);
    --button:SetBackdropColor(0, 0.5, 1, .5);
    --button:SetBackdropColor(0, 0, 0, .8);
    --bname:SetText(name);
    duration:SetText(bdur);
    bicon:SetTexture(icon);
    bstack:SetText(stack);

  else
 	--theres no buff hide the button 
    if(m_boptions.moveable == 1) then
    --display guide is enabled, show buttons and their id
			if (not m_BuffFrameCapsule:IsVisible()) then m_BuffFrameCapsule:Show(); end
  		button:Show();
  		button:SetAlpha(1);
			local bstack = d .. "Stack";
			bstack = getglobal(bstack);
			bstack:SetText(buttonid);
    else
    --display guide disabled, hide buttons
        if (m_BuffFrameCapsule:IsVisible()) then m_BuffFrameCapsule:Hide(); end
        button:Hide();
        buttonicon:Hide();
    end
  end
end


function m_drawdebuff(buttonid)
	local icon,stack,name,btype,mid,dtype,bdur,dtype;
	
	local d = "m_DeBuffButton" .. buttonid;
	local u = d .. "a";
	local button = getglobal(d);
	local buttonicon = getglobal(u);
  
  if (debuff_list[buttonid]) then
    		
        icon = debuff_list[buttonid]['bicon'];
        name  = debuff_list[buttonid]['name'];
        btype = debuff_list[buttonid]['btype'];
        mid		= debuff_list[buttonid]['mid'];
        dtype	= debuff_list[buttonid]['dtype'];
        stack = GetPlayerBuffApplications(mid);
				
        if (btype == 1) then
        	if(m_doptions.size == 1) then
            bdur = "";
          else
          	bdur = "--:--";
          end
        else
        	if (m_doptions.size == 1) then
        		bdur  = m_timestring2(GetPlayerBuffTimeLeft(debuff_list[buttonid]['mid']));
        	elseif (m_doptions.size == 0) then
        		bdur  = m_timestring3(GetPlayerBuffTimeLeft(debuff_list[buttonid]['mid']));
        	end
        end
        
        if (stack == 0) then stack = ""; end
        --set the duration object
        local duration = d .. "Duration";
        duration = getglobal(duration);
        --set the icon border object
        local iconborder = d .. "DeBuffBorder";
        iconborder = getglobal(iconborder);
        --set the buff icon
        local bicon = d .. "Icon";
        bicon = getglobal(bicon);
        --set the buff name object
        local bname = d .. "DeBuffName";
        bname = getglobal(bname);
        bname:SetWidth(148);
        bname:SetHeight(14);
        --set the buff stack object
        local bstack = d .. "Stack";
        bstack = getglobal(bstack);
        local debufftype = d .. "buffTypeText";
        debufftype = getglobal(debufftype);
        
        button:Show();
        buttonicon:Show();
        iconborder:Show();
        --button:SetBackdropBorderColor(1, 0, 0);
        --button:SetBackdropColor(1, 0, 0, .5);

        duration:SetText(bdur);
        duration:ClearAllPoints();
        
        if (m_doptions.size == 1) then
        	bname:SetText(name);
	        if(dtype ~= "") then
	        	duration:SetPoint("TOPLEFT",button,"CENTER",4, -1);       	
	        else
	        	if (GetPlayerBuffTimeLeft(debuff_list[buttonid]['mid']) > 60) then
	        		duration:SetPoint("TOPRIGHT",button,"CENTER",18, -1);   	
	        	elseif (GetPlayerBuffTimeLeft(debuff_list[buttonid]['mid']) < 1) then
	        		duration:SetPoint("TOPRIGHT",button,"CENTER",0, -1);   	
	        	else
	        		duration:SetPoint("TOPRIGHT",button,"CENTER",28, -1);
	        	end
	        end
	      elseif (m_doptions.size == 0) then
	      	bname:SetText("");
	      	duration:SetPoint("CENTER",button,"CENTER",0, 0);
	      end

        bicon:SetTexture(icon);
        bstack:SetText(stack);
        
        if(m_doptions.size == 1) then
        	debufftype:SetText(dtype);
        else
        	debufftype:SetText("");
        end
        
        -- DEBUFF TYPE HIGHLIGHTING
        local can1 = 0;local can2 = 1;local can3 = 0;
				local cant1= 1;local cant2= 0;local cant3 = 0;

				if (myclass == CLASS_PRIEST) then
					if(dtype == "Magic") then
						debufftype:SetTextColor(can1,can2,can3);
					elseif (dtype == "Disease") then
						debufftype:SetTextColor(0,1,0);
					else
						debufftype:SetTextColor(cant1,cant2,cant3);
					end
				elseif (myclass == CLASS_PALADIN) then
					if(dtype == "Magic") then
						debufftype:SetTextColor(0,1,0);
					elseif (dtype == "Disease") then
						debufftype:SetTextColor(0,1,0);
					elseif (dtype == "Poison") then
						debufftype:SetTextColor(0,1,0);
					else
						debufftype:SetTextColor(cant1,cant2,cant3);
					end
				elseif (myclass == CLASS_SHAMAN) then
					if(dtype == "Magic") then
						debufftype:SetTextColor(0,1,0);
					elseif (dtype == "Poison") then
						debufftype:SetTextColor(0,1,0);
					elseif (dtype == "Disease") then
						debufftype:SetTextColor(0,1,0);
					else
						debufftype:SetTextColor(cant1,cant2,cant3);
					end
				elseif (myclass == CLASS_MAGE) then
					if(dtype == "Curse") then
						debufftype:SetTextColor(0,1,0);
					else
						debufftype:SetTextColor(1,0,0);
					end
				elseif (myclass == CLASS_DRUID) then
					if (dtype == "Curse") then
						debufftype:SetTextColor(0,1,0);
					elseif (dtype == "Poison") then
						debufftype:SetTextColor(0,1,0);
					else
						debufftype:SetTextColor(cant1,cant2,cant3);
					end
				elseif (myclass == CLASS_WARLOCK) then
					if(dtype == "Magic") then
						local pettype = UnitCreatureFamily("pet");
						if (pettype ~= nil and pettype == PET_FELHUNTER) then
							debufftype:SetTextColor(0,1,0);
						else
							debufftype:SetTextColor(cant1,cant2,cant3);
						end
					else
						debufftype:SetTextColor(cant1,cant2,cant3);
					end
				else
					debufftype:SetTextColor(cant1,cant2,cant3);
				end

	        
			if (GetPlayerBuffTimeLeft(debuff_list[buttonid]['mid']) <= m_doptions.flashtime and btype ~= 1) then
        local tempdur = GetPlayerBuffTimeLeft(debuff_list[buttonid]['mid']);
        local g = string.sub(tempdur, 4, 4);
        if (tempdur > 10) then
            if (tonumber(g)) then
                local f =  1 / g;
                if (f > .275) then
                    button:SetAlpha(f);
                end
            end
        elseif (tempdur < 10 and tempdur >= 1) then
            g = string.sub(tempdur, 3, 3);
            if (tonumber(g)) then
                local f =  1 / g;
                if (f > .175) then
                    button:SetAlpha(f);
                end
            end
        elseif (tempdur < 1) then
        	button:SetAlpha(tempdur);
        end

    	else
    		if (GetPlayerBuffTimeLeft(debuff_list[buttonid]['mid']) ~= 0) then
        	button:SetAlpha(1);
        elseif (GetPlayerBuffTimeLeft(debuff_list[buttonid]['mid']) == 0 and btype == 1) then
        	button:SetAlpha(1);
        end
    	end
        
    else
        if(m_doptions.moveable == 1) then
            if (not m_DeBuffFrameCapsule:IsVisible()) then m_DeBuffFrameCapsule:Show(); end
            button:Show();
            button:SetAlpha(1);
            local bstack = d .. "Stack";
            local iconborder = d .. "DeBuffBorder";
            iconborder = getglobal(iconborder);
            iconborder:Show();
            bstack = getglobal(bstack);
            bstack:SetText(buttonid);
    
        else
            if (m_DeBuffFrameCapsule:IsVisible()) then m_DeBuffFrameCapsule:Hide(); end
            button:Hide();
            buttonicon:Hide();
        end
    end
end


function m_drawweaponbuffs(buttonid)
	local icon,stack,name,btype,bdur,id,dtype,capsuleheight,timeleft;
	local tempid = buttonid + 1;
	local debuffcount = 0;
	
	local d = "m_WepBuffButton" .. buttonid;
	local u = d .. "a";
	local button = getglobal(d);
	local buttonicon = getglobal(u);
  
    if (weaponbuff_list[buttonid]) then
			local hasMainHandEnchant, mainHandExpiration, mainHandCharges,
				hasOffHandEnchant, offHandExpiration, offHandCharges = GetWeaponEnchantInfo();
			
			if (buttonid == 1 and hasMainHandEnchant == 1) then
				if (m_woptions.displaymode >= 4 and m_woptions.displaymode <= 7) then
					timeleft = m_timestring(mainHandExpiration);
				else
					timeleft = m_timestring4(mainHandExpiration);
				end				
        
        --if (timeleft == "") then button:Hide(); return; end
        
        local charges = mainHandCharges;if (charges == 0) then charges = ""; end 
	 			local name = weaponbuff_list[buttonid]['name'];
	 			local icon = weaponbuff_list[buttonid]['icon'];
				button:Show();
				buttonicon:Show();

				
        --m_WepBuffButton1:SetBackdropColor(.72,.32,.82, .6);
        local wepbufficon = getglobal(d .. "Icon");
        wepbufficon:SetTexture(icon);
        local duration = getglobal(d .. "Duration");
        duration:SetText(timeleft);
        local chargelabel = getglobal(d .."Stack");
        chargelabel:SetText(charges);
        local hand = getglobal(d .. "Hand");
        hand:SetText("M");
        local wname = getglobal(d .. "Name");

        if (m_woptions.displaymode >= 4 and m_woptions.displaymode <= 7) then
        	--large wep buffs
        	wname:SetWidth(148);
        	wname:SetHeight(14);
        	wname:SetText(name);
        else
        	wname:SetText("");
        end

				if ((mainHandExpiration / 1000) <= m_woptions.flashtime or mainHandCharges <= m_woptions.cflashtime and mainHandCharges ~= 0) then
					local e;
					if (mainHandExpiration > 999999 and mainHandExpiration <= 9999999) then
						e = string.sub(mainHandExpiration, 5, 5);
					elseif (mainHandExpiration > 99999 and mainHandExpiration <= 999999) then
						e = string.sub(mainHandExpiration, 4, 4);
					elseif (mainHandExpiration > 9999 and mainHandExpiration <= 99999) then
						e = string.sub(mainHandExpiration, 3, 3);
					elseif (mainHandExpiration > 999 and mainHandExpiration <= 9999) then
						e = string.sub(mainHandExpiration, 2, 2);
					elseif (mainHandExpiration >= 1 and mainHandExpiration <= 999) then
						e = string.sub(mainHandExpiration, 1, 1);
					end
					
					if (tonumber(e)) then
						local f =  e / 10;
						if (f > .01) then
							button:SetAlpha(f);
						end
					end
	    	else
	      	button:SetAlpha(1);
	    	end
	    	
    	elseif (buttonid == 2 and hasOffHandEnchant == 1 and hasMainHandEnchant == 1) then
				button:Show();
				buttonicon:Show();
				if (m_woptions.displaymode >= 4 and m_woptions.displaymode <= 7) then
					timeleft = m_timestring(offHandExpiration);
				else
					timeleft = m_timestring4(offHandExpiration);
				end		
				if (timeleft == "") then button:Hide(); return; end
        local charges = offHandCharges;if (charges == 0) then charges = ""; end     
	 			local name = weaponbuff_list[buttonid]['name'];
	 			local icon = weaponbuff_list[buttonid]['icon'];

        

        --m_WepBuffButton1:SetBackdropColor(.72,.32,.82, .6);
        local wepbufficon = getglobal(d .. "Icon");
        wepbufficon:SetTexture(icon);
        local duration = getglobal(d .. "Duration");
        duration:SetText(timeleft);
        local chargelabel = getglobal(d .."Stack");
        chargelabel:SetText(charges);
        local hand = getglobal(d .. "Hand");
        hand:SetText("O");
        local wname = getglobal(d .. "Name");

        if (m_woptions.displaymode >= 4 and m_woptions.displaymode <= 7) then
        	--large wep buffs
        	wname:SetWidth(148);
        	wname:SetHeight(14);
        	wname:SetText(name);
        else
        	wname:SetText("");
        end
                 
				if ((offHandExpiration / 1000) <= m_woptions.flashtime or offHandCharges <= m_woptions.cflashtime and offHandCharges ~= 0) then
					local e;
					if (offHandExpiration > 999999 and offHandExpiration <= 9999999) then
						e = string.sub(offHandExpiration, 5, 5);
					elseif (offHandExpiration > 99999 and offHandExpiration <= 999999) then
						e = string.sub(offHandExpiration, 4, 4);
					elseif (offHandExpiration > 9999 and offHandExpiration <= 99999) then
						e = string.sub(offHandExpiration, 3, 3);
					elseif (offHandExpiration > 999 and offHandExpiration <= 9999) then
						e = string.sub(offHandExpiration, 2, 2);
					elseif (offHandExpiration >= 1 and offHandExpiration <= 999) then
						e = string.sub(offHandExpiration, 1, 1);
					end
					
					if (tonumber(e)) then
						local f =  e / 10;
						if (f > .01) then
							button:SetAlpha(f);
						end
					end
	    	else
	      	button:SetAlpha(1);
	    	end
	    	
    	elseif (buttonid == 1 and hasOffHandEnchant == 1) then
				button:Show();
				buttonicon:Show();
				if (m_woptions.displaymode >= 4 and m_woptions.displaymode <= 7) then
					timeleft = m_timestring(offHandExpiration);
				else
					timeleft = m_timestring4(offHandExpiration);
				end		
				if (timeleft == "") then button:Hide(); return; end
        local charges = offHandCharges;if (charges == 0) then charges = ""; end     
	 			local name = weaponbuff_list[buttonid]['name'];
	 			local icon = weaponbuff_list[buttonid]['icon'];


        --m_WepBuffButton1:SetBackdropColor(.72,.32,.82, .6);
        local wepbufficon = getglobal(d .. "Icon");
        wepbufficon:SetTexture(icon);
        local duration = getglobal(d .. "Duration");
        duration:SetText(timeleft);
        local chargelabel = getglobal(d .."Stack");
        chargelabel:SetText(charges);
        local hand = getglobal(d .. "Hand");
        hand:SetText("O");
        local wname = getglobal(d .. "Name");

        if (m_woptions.displaymode >= 4 and m_woptions.displaymode <= 7) then
        	--large wep buffs
        	wname:SetWidth(148);
        	wname:SetHeight(14);
        	wname:SetText(name);
        else
        	wname:SetText("");
        end
         
				if ((offHandExpiration / 1000) <= m_woptions.flashtime or offHandCharges <= m_woptions.cflashtime and offHandCharges ~= 0) then
					local e;
					if (offHandExpiration > 999999 and offHandExpiration <= 9999999) then
						e = string.sub(offHandExpiration, 5, 5);
					elseif (offHandExpiration > 99999 and offHandExpiration <= 999999) then
						e = string.sub(offHandExpiration, 4, 4);
					elseif (offHandExpiration > 9999 and offHandExpiration <= 99999) then
						e = string.sub(offHandExpiration, 3, 3);
					elseif (offHandExpiration > 999 and offHandExpiration <= 9999) then
						e = string.sub(offHandExpiration, 2, 2);
					elseif (offHandExpiration >= 1 and offHandExpiration <= 999) then
						e = string.sub(offHandExpiration, 1, 1);
					end
					
					if (tonumber(e)) then
						local f =  e / 10;
						if (f > .01) then
							button:SetAlpha(f);
						end
					end
	    	else
	      	button:SetAlpha(1);
	    	end
	    end
	    
    else
        if(m_woptions.moveable == 1) then
            if (not m_WepBuffFrameCapsule:IsVisible()) then m_WepBuffFrameCapsule:Show(); end
            button:Show();
            button:SetAlpha(1);
            local bstack = d .. "Stack";
            local iconborder = d .. "Border";
            iconborder = getglobal(iconborder);
            iconborder:Show();
            bstack = getglobal(bstack);
            bstack:SetText(buttonid);   
        else
            if (m_WepBuffFrameCapsule:IsVisible()) then m_WepBuffFrameCapsule:Hide(); end
            button:Hide();
            buttonicon:Hide();
        end
    end     
end




-----------------------------------------------
function m_scan(buttonid)
	local i;
  local wtf = 0;
	--local temptime = time() - last_scan;
	
	masterbuff_list = {};
	
	--if (temptime >= scan_interval) then
		--cycle through buff slots
		for i=1, 24 do
			wtf = i - 1;
	        
	    local buffIndex, untilCancelled = GetPlayerBuff(wtf, "HELPFUL|HARMFUL");
	    local spellType = m_GetBuffType(wtf,"HELPFUL|HARMFUL");
	    if (spellType == nil) then spellType = ""; end
	            
			--store buff data in the master buff table
			if (buffIndex ~= -1) then
				masterbuff_list[i] = {
					icon        = GetPlayerBuffTexture(buffIndex);
					name        = m_buffname(buffIndex,"HELPFUL|HARMFUL");
					btype       = untilCancelled;
					isDebuff    = m_isDebuff(buffIndex);
					mid         = buffIndex;
					dtype	    	= spellType;
				};
			end
		end
    
    local y = 0;
    local z = 0;
    buff_list = {};
    debuff_list = {};

    --cycle through all the buffs found, populate the buff/debuff tables
		for buff in masterbuff_list do
	        local bicon,stack,name,btype,bdur,isDebuff,id,dtype;
	        
	        isDebuff = masterbuff_list[buff]['isDebuff'];
	
	        --it's not a debuff, store data in the buff table
	        if (isDebuff == 0) then
	            y = y + 1;
	            buff_list[y] = {
	                bicon   = masterbuff_list[buff]['icon'];
	                name    = masterbuff_list[buff]['name'];
	                btype   = masterbuff_list[buff]['btype'];
	                mid     = masterbuff_list[buff]['mid'];
	            };
	        else
	        --it's a debuff, store data in the debuff table
	            z = z + 1;
	            debuff_list[z] = {
	                bicon   = masterbuff_list[buff]['icon'];
	                name    = masterbuff_list[buff]['name'];
	                btype   = masterbuff_list[buff]['btype'];
	                mid			= masterbuff_list[buff]['mid'];
	                dtype		= masterbuff_list[buff]['dtype'];
	            };
	        end
	  end			
	  --last_scan = time();
	--end    
end

function m_wscan()
	local temptime = time() - last_scan;
	if (temptime >= scan_interval) then
	
		weaponbuff_list = {};
		
		local hasMainHandEnchant, mainHandExpiration, mainHandCharges,
				hasOffHandEnchant, offHandExpiration, offHandCharges = GetWeaponEnchantInfo();
				
			if (hasMainHandEnchant == 1 and hasOffHandEnchant == nil) then
			--mainhand enchant, no offhand enchant
				local tname = m_getenchants(16);
				weaponbuff_list[1] = { 
	 				name = tname;
	 				icon = m_geticon(tname,16);
	 				slot = 16;
	 			};
			elseif (hasMainHandEnchant == nil and hasOffHandEnchant == 1) then
			--offhand enchant, no mainhand enchant
				local tname = m_getenchants(17);
				weaponbuff_list[1] = {
	 				name = tname;
	 				icon = m_geticon(tname,17);
	 				slot = 17;
				};
			
			elseif (hasMainHandEnchant == 1 and hasOffHandEnchant == 1) then
			--both weps have enchants
				local tname1 = m_getenchants(16);
				local tname2 = m_getenchants(17);
				
				weaponbuff_list[1] = { 
	 				name = tname1;
	 				icon = m_geticon(tname1,16);
	 				slot = 16;
	 			};
				weaponbuff_list[2] = { 
	 				name = tname2;
	 				icon = m_geticon(tname2,17);
	 				slot = 17;
	 			};
			end
			last_scan = time();
	end
end
--------------------------------------------------


function m_update(arg1)
  for i=1, 16 do
  	m_drawbuff(i);
	end   	

	for i=1, 8 do
		m_drawdebuff(i);
	end

	m_wscan();
	for i=1, 2 do
  	m_drawweaponbuffs(i);
  end
end

function m_moveablebuffs()
    if(m_optionsPanel5Panel2CheckButton1:GetChecked() == nil) then
        m_boptions.moveable = 0;
    else
        m_boptions.moveable = 1;
    end
end

function m_moveabledebuffs()
    if(m_optionsPanel5Panel3Component5:GetChecked() == nil) then
        m_doptions.moveable = 0;
    else
        m_doptions.moveable = 1;
    end
end

function m_moveablewepbuffs()
    if(m_optionsPanel5Panel1Container1Component8:GetChecked() == nil) then
        m_woptions.moveable = 0;
    else
        m_woptions.moveable = 1;
    end       
end

function m_geticon(name,hand)
	if (name ~= "" and name ~= nil) then

	 			if	(name == INSTANTPOISON1 or name == INSTANTPOISON2 or name == INSTANTPOISON3 or name == INSTANTPOISON4 or
	 								name == INSTANTPOISON5 or name == INSTANTPOISON6) then
	 				icon = "Interface\\Icons\\Ability_Poisonarrow";
	 			elseif 	(name == MINDNUMBING1 or name == MINDNUMBING2 or name == MINDNUMBING3) then
	 				icon = "Interface\\Icons\\spell_nature_nullifydisease";
	 			elseif 	(name == WOUNDPOISON1 or name == WOUNDPOISON2 or name == WOUNDPOISON3 or name == WOUNDPOISON4) then
	 				icon = "Interface\\Icons\\Ability_Poisonsting";
	 			elseif 	(name == DEADLYPOISON1 or name == DEADLYPOISON2 or name == DEADLYPOISON3 or name == DEADLYPOISON4 or
	 								name == DEADLYPOISON5) then
	 				icon = "Interface\\Icons\\Ability_Rogue_DualWeild";
	 			elseif 	(name == CRIPPLINGPOISON1 or name == CRIPPINGPOISON2) then
	 				icon = "interface\\icons\\ability_poisonsting";
	 				
	 			--SHARPENING STONES	
	 			elseif 	(name == CONSECRATED_SHARPSTONE) then
	 				icon = "interface\\icons\\inv_stone_sharpeningstone_02";
	 			elseif 	(name == ELEMENTAL_SHARPSTONE) then
	 				icon = "interface\\icons\\inv_stone_02";
	 			elseif	(name == COARSE_SHARPSTONE) then
	 				icon = "interface\\icons\\inv_stone_sharpeningstone_02";
	 			elseif	(name == DENSE_SHARPSTONE) then
	 				icon = "interface\\icons\\inv_stone_sharpeningstone_05";
				elseif	(name == HEAVY_SHARPSTONE) then
	 				icon = "interface\\icons\\inv_stone_sharpeningstone_03";
				elseif	(name == ROUGH_SHARPSTONE) then
	 				icon = "interface\\icons\\inv_stone_sharpeningstone_01";
	 			elseif	(name == SOLID_SHARPSTONE) then
	 				icon = "interface\\icons\\inv_stone_sharpeningstone_04";
	 				
	 			--OILS
				elseif	(name == MINORWIZARDOIL) then
	 				icon = "interface\\icons\\inv_poison_mindnumbing";
	 			elseif	(name == MINORMANAOIL) then
	 				icon = "interface\\icons\\inv_potion_98";
	 			elseif	(name == LESSERWIZARDOIL) then
	 				icon = "interface\\icons\\inv_potion_103";
	 			elseif	(name == LESSERMANAOIL) then
	 				icon = "interface\\icons\\inv_potion_99";
	 			elseif	(name == WIZARDOIL) then
	 				icon = "interface\\icons\\inv_potion_104";
	 			elseif	(name == BRILLIANTMANAOIL) then
	 				icon = "interface\\icons\\inv_potion_100";
	 			elseif	(name == BRILLIANTWIZARDOIL) then
	 				icon = "interface\\icons\\inv_potion_105";
	 			elseif	(name == BLESSEDWIZARDOIL) then
	 			--BLESSED WIZARD OIL
					icon = "interface\\icons\\inv_potion_26";

				--SHAMAN ENCHANTS
	 			elseif	(name == WINDFURY1 or name == WINDFURY2 or name == WINDFURY3 or name == WINDFURY4) then
	 				icon = "interface\\icons\\spell_nature_windfury";
	 			elseif	(name == FROSTBRAND1 or name == FROSTBRAND2 or name == FROSTBRAND3 or name == FROSTBRAND4 or name == FROSTBRAND5) then
	 				icon = "interface\\icons\\spell_frost_frostbrand";
	 			elseif	(name == FLAMETONGUE1 or name == FLAMETONGUE2 or name == FLAMETONGUE3 or name == FLAMETONGUE4 or
	 								name == FLAMETONGUE5 or name == FLAMETONGUE6) then
	 				icon = "interface\\icons\\spell_fire_flametongue";
	 			elseif	(name == ROCKBITER1 or name == ROCKBITER2 or name == ROCKBITER3 or name == ROCKBITER4 or
	 								name == ROCKBITER5 or name == ROCKBITER6 or name == ROCKBITER7) then
	 				icon = "interface\\icons\\spell_nature_rockbiter";
	 				
	 			--WARLOCK ENCHANTS
	 			elseif (name ==	FIRESTONE1 or name ==  FIRESTONE2 or name == FIRESTONE3 or name == FIRESTONE4) then
	 				icon = "interface\\icons\\inv_misc_gem_bloodstone_02";
	 			else
	 				icon = GetInventoryItemTexture("player", hand);
	 				--icon = "interface\\icons\\inv_misc_questionmark";
	 			end
		return icon;
	end
end



function m_setbufflayout()
if (m_boptions.size == 0) then
-------------------
	-- SMALL BUFFS --
	-----------------
	if(m_boptions.displaymode >= 0 and m_boptions.displaymode <= 3) then
		------------------------------------------------------
		-- BUFFS SCROLLING DOWN/UP INSTEAD OF LEFT TO RIGHT --
		------------------------------------------------------
		if (m_boptions.rightleft == 0) then
			------------------------------
			-- POPULATE RIGHT ROW FIRST ----
			------------------------------
			if (m_boptions.downup == "DOWN") then
				----------------------------
				-- SCROLL BUFFS DOWNWARDS --
				----------------------------
					anchorx = 35;
					anchorx2 = -37;
					anchory	= -28;
					anchory2 = 20;
					paddingv = -28;
					paddingh = 0;
					m_BuffFrame:ClearAllPoints();
					m_BuffButton1:SetPoint("TOPLEFT", "m_BuffFrameCapsule", "TOPLEFT", anchorx, anchory);
					m_BuffButton2:SetPoint("TOPLEFT", "m_BuffButton1", "BOTTOMLEFT", 0, paddingv);
					m_BuffButton3:SetPoint("TOPLEFT", "m_BuffButton2", "BOTTOMLEFT", 0, paddingv);
					m_BuffButton4:SetPoint("TOPLEFT", "m_BuffButton3", "BOTTOMLEFT", 0, paddingv);
					m_BuffButton5:SetPoint("TOPLEFT", "m_BuffButton4", "BOTTOMLEFT", 0, paddingv);
					m_BuffButton6:SetPoint("TOPLEFT", "m_BuffButton5", "BOTTOMLEFT", 0, paddingv);
					m_BuffButton7:SetPoint("TOPLEFT", "m_BuffButton6", "BOTTOMLEFT", 0, paddingv);
					m_BuffButton8:SetPoint("TOPLEFT", "m_BuffButton7", "BOTTOMLEFT", 0, paddingv);
					m_BuffButton9:SetPoint("TOPLEFT", "m_BuffButton1", "BOTTOMLEFT", anchorx2, anchory2);
					m_BuffButton10:SetPoint("TOPLEFT", "m_BuffButton2", "BOTTOMLEFT", anchorx2, anchory2);
					m_BuffButton11:SetPoint("TOPLEFT", "m_BuffButton3", "BOTTOMLEFT", anchorx2, anchory2);
					m_BuffButton12:SetPoint("TOPLEFT", "m_BuffButton4", "BOTTOMLEFT", anchorx2, anchory2);
					m_BuffButton13:SetPoint("TOPLEFT", "m_BuffButton5", "BOTTOMLEFT", anchorx2, anchory2);
					m_BuffButton14:SetPoint("TOPLEFT", "m_BuffButton6", "BOTTOMLEFT", anchorx2, anchory2);
					m_BuffButton15:SetPoint("TOPLEFT", "m_BuffButton7", "BOTTOMLEFT", anchorx2, anchory2);
					m_BuffButton16:SetPoint("TOPLEFT", "m_BuffButton8", "BOTTOMLEFT", anchorx2, anchory2);	
			elseif (m_boptions.downup == "UP") then
				--------------------------
				-- SCROLL BUFFS UPWARDS --
				--------------------------
					anchorx = 35;
					anchorx2 = -37;
					anchory	= -364;
					paddingv = 48;
					paddingh = 0;
					m_BuffFrame:ClearAllPoints();
					m_BuffButton1:SetPoint("TOPLEFT", "m_BuffFrameCapsule", "TOPLEFT", anchorx, anchory);
					m_BuffButton2:SetPoint("TOPLEFT", "m_BuffButton1", "TOPLEFT", 0, paddingv);
					m_BuffButton3:SetPoint("TOPLEFT", "m_BuffButton2", "TOPLEFT", 0, paddingv);
					m_BuffButton4:SetPoint("TOPLEFT", "m_BuffButton3", "TOPLEFT", 0, paddingv);
					m_BuffButton5:SetPoint("TOPLEFT", "m_BuffButton4", "TOPLEFT", 0, paddingv);
					m_BuffButton6:SetPoint("TOPLEFT", "m_BuffButton5", "TOPLEFT", 0, paddingv);
					m_BuffButton7:SetPoint("TOPLEFT", "m_BuffButton6", "TOPLEFT", 0, paddingv);
					m_BuffButton8:SetPoint("TOPLEFT", "m_BuffButton7", "TOPLEFT", 0, paddingv);
					m_BuffButton9:SetPoint("TOPLEFT", "m_BuffButton1", "TOPLEFT", anchorx2, 0);
					m_BuffButton10:SetPoint("TOPLEFT", "m_BuffButton2", "TOPLEFT", anchorx2, 0);
					m_BuffButton11:SetPoint("TOPLEFT", "m_BuffButton3", "TOPLEFT", anchorx2, 0);
					m_BuffButton12:SetPoint("TOPLEFT", "m_BuffButton4", "TOPLEFT", anchorx2, 0);
					m_BuffButton13:SetPoint("TOPLEFT", "m_BuffButton5", "TOPLEFT", anchorx2, 0);
					m_BuffButton14:SetPoint("TOPLEFT", "m_BuffButton6", "TOPLEFT", anchorx2, 0);
					m_BuffButton15:SetPoint("TOPLEFT", "m_BuffButton7", "TOPLEFT", anchorx2, 0);
					m_BuffButton16:SetPoint("TOPLEFT", "m_BuffButton8", "TOPLEFT", anchorx2, 0);
			end


		elseif (m_boptions.rightleft == 1) then
			-----------------------------
			-- POPULATE LEFT ROW FIRST --
			-----------------------------
			if (m_boptions.downup == "DOWN") then
				----------------------------
				-- SCROLL BUFFS DOWNWARDS --
				----------------------------
					anchorx = -2;
					anchorx2 = 37;
					anchory	= -28;
					anchory2 = 20;
					paddingv = -28;
					paddingh = 0;
					m_BuffFrame:ClearAllPoints();
					m_BuffButton1:SetPoint("TOPLEFT", "m_BuffFrameCapsule", "TOPLEFT", anchorx, anchory);
					m_BuffButton2:SetPoint("TOPLEFT", "m_BuffButton1", "BOTTOMLEFT", 0, paddingv);
					m_BuffButton3:SetPoint("TOPLEFT", "m_BuffButton2", "BOTTOMLEFT", 0, paddingv);
					m_BuffButton4:SetPoint("TOPLEFT", "m_BuffButton3", "BOTTOMLEFT", 0, paddingv);
					m_BuffButton5:SetPoint("TOPLEFT", "m_BuffButton4", "BOTTOMLEFT", 0, paddingv);
					m_BuffButton6:SetPoint("TOPLEFT", "m_BuffButton5", "BOTTOMLEFT", 0, paddingv);
					m_BuffButton7:SetPoint("TOPLEFT", "m_BuffButton6", "BOTTOMLEFT", 0, paddingv);
					m_BuffButton8:SetPoint("TOPLEFT", "m_BuffButton7", "BOTTOMLEFT", 0, paddingv);
					m_BuffButton9:SetPoint("TOPLEFT", "m_BuffButton1", "BOTTOMLEFT", anchorx2, anchory2);
					m_BuffButton10:SetPoint("TOPLEFT", "m_BuffButton2", "BOTTOMLEFT", anchorx2, anchory2);
					m_BuffButton11:SetPoint("TOPLEFT", "m_BuffButton3", "BOTTOMLEFT", anchorx2, anchory2);
					m_BuffButton12:SetPoint("TOPLEFT", "m_BuffButton4", "BOTTOMLEFT", anchorx2, anchory2);
					m_BuffButton13:SetPoint("TOPLEFT", "m_BuffButton5", "BOTTOMLEFT", anchorx2, anchory2);
					m_BuffButton14:SetPoint("TOPLEFT", "m_BuffButton6", "BOTTOMLEFT", anchorx2, anchory2);
					m_BuffButton15:SetPoint("TOPLEFT", "m_BuffButton7", "BOTTOMLEFT", anchorx2, anchory2);
					m_BuffButton16:SetPoint("TOPLEFT", "m_BuffButton8", "BOTTOMLEFT", anchorx2, anchory2);					
			elseif (m_boptions.downup == "UP") then
				--------------------------
				-- SCROLL BUFFS UPWARDS --
				--------------------------
					anchorx = -2;
					anchorx2 = 37;
					anchory	= -364;
					paddingv = 48;
					paddingh = 0;
					m_BuffFrame:ClearAllPoints();
					m_BuffButton1:SetPoint("TOPLEFT", "m_BuffFrameCapsule", "TOPLEFT", anchorx, anchory);
					m_BuffButton2:SetPoint("TOPLEFT", "m_BuffButton1", "TOPLEFT", 0, paddingv);
					m_BuffButton3:SetPoint("TOPLEFT", "m_BuffButton2", "TOPLEFT", 0, paddingv);
					m_BuffButton4:SetPoint("TOPLEFT", "m_BuffButton3", "TOPLEFT", 0, paddingv);
					m_BuffButton5:SetPoint("TOPLEFT", "m_BuffButton4", "TOPLEFT", 0, paddingv);
					m_BuffButton6:SetPoint("TOPLEFT", "m_BuffButton5", "TOPLEFT", 0, paddingv);
					m_BuffButton7:SetPoint("TOPLEFT", "m_BuffButton6", "TOPLEFT", 0, paddingv);
					m_BuffButton8:SetPoint("TOPLEFT", "m_BuffButton7", "TOPLEFT", 0, paddingv);
					m_BuffButton9:SetPoint("TOPLEFT", "m_BuffButton1", "TOPLEFT", anchorx2, 0);
					m_BuffButton10:SetPoint("TOPLEFT", "m_BuffButton2", "TOPLEFT", anchorx2, 0);
					m_BuffButton11:SetPoint("TOPLEFT", "m_BuffButton3", "TOPLEFT", anchorx2, 0);
					m_BuffButton12:SetPoint("TOPLEFT", "m_BuffButton4", "TOPLEFT", anchorx2, 0);
					m_BuffButton13:SetPoint("TOPLEFT", "m_BuffButton5", "TOPLEFT", anchorx2, 0);
					m_BuffButton14:SetPoint("TOPLEFT", "m_BuffButton6", "TOPLEFT", anchorx2, 0);
					m_BuffButton15:SetPoint("TOPLEFT", "m_BuffButton7", "TOPLEFT", anchorx2, 0);
					m_BuffButton16:SetPoint("TOPLEFT", "m_BuffButton8", "TOPLEFT", anchorx2, 0);	
			end	
		end
			
	elseif (m_boptions.displaymode >= 4 and m_boptions.displaymode <= 7) then
		----------------------------------------------------------------------
		-- buffs scroll right to left, or left to right, instead of down/up --
		----------------------------------------------------------------------
		if(m_boptions.downup == "DOWN") then
			-------------------
			-- TOP ROW FIRST --
			-------------------
			if (m_boptions.rightleft == 1) then
				----------------------------
				-- SCROLL BUFFS FROM LEFT TO RIGHT --
				----------------------------
					anchorx = -2;
					anchorx2 = 0;
					anchory	= -28;
					anchory2 = -28;
					m_BuffFrame:ClearAllPoints();
					m_BuffButton1:SetPoint("TOPLEFT", "m_BuffFrameCapsule", "TOPLEFT", anchorx, anchory);
					m_BuffButton2:SetPoint("TOPLEFT", "m_BuffButton1", "TOPRIGHT", anchorx, 0);
					m_BuffButton3:SetPoint("TOPLEFT", "m_BuffButton2", "TOPRIGHT", anchorx, 0);
					m_BuffButton4:SetPoint("TOPLEFT", "m_BuffButton3", "TOPRIGHT", anchorx, 0);
					m_BuffButton5:SetPoint("TOPLEFT", "m_BuffButton4", "TOPRIGHT", anchorx, 0);
					m_BuffButton6:SetPoint("TOPLEFT", "m_BuffButton5", "TOPRIGHT", anchorx, 0);
					m_BuffButton7:SetPoint("TOPLEFT", "m_BuffButton6", "TOPRIGHT", anchorx, 0);
					m_BuffButton8:SetPoint("TOPLEFT", "m_BuffButton7", "TOPRIGHT", anchorx, 0);
					m_BuffButton9:SetPoint("TOPLEFT", "m_BuffButton1", "BOTTOMLEFT", anchorx2, anchory2);
					m_BuffButton10:SetPoint("TOPLEFT", "m_BuffButton2", "BOTTOMLEFT", anchorx2, anchory2);
					m_BuffButton11:SetPoint("TOPLEFT", "m_BuffButton3", "BOTTOMLEFT", anchorx2, anchory2);
					m_BuffButton12:SetPoint("TOPLEFT", "m_BuffButton4", "BOTTOMLEFT", anchorx2, anchory2);
					m_BuffButton13:SetPoint("TOPLEFT", "m_BuffButton5", "BOTTOMLEFT", anchorx2, anchory2);
					m_BuffButton14:SetPoint("TOPLEFT", "m_BuffButton6", "BOTTOMLEFT", anchorx2, anchory2);
					m_BuffButton15:SetPoint("TOPLEFT", "m_BuffButton7", "BOTTOMLEFT", anchorx2, anchory2);
					m_BuffButton16:SetPoint("TOPLEFT", "m_BuffButton8", "BOTTOMLEFT", anchorx2, anchory2);
			elseif (m_boptions.rightleft == 0) then
				----------------------------
				-- SCROLL BUFFS FROM RIGHT TO LEFT --
				----------------------------
          anchorx = -38;
					anchorx2 = 0;
					anchory	= -28;
					anchory2 = -28;
					m_BuffFrame:ClearAllPoints();
					m_BuffButton1:SetPoint("TOPLEFT", "m_BuffFrameCapsule", "TOPRIGHT", -37, anchory);
					m_BuffButton2:SetPoint("TOPLEFT", "m_BuffButton1", "TOPLEFT", anchorx, 0);
					m_BuffButton3:SetPoint("TOPLEFT", "m_BuffButton2", "TOPLEFT", anchorx, 0);
					m_BuffButton4:SetPoint("TOPLEFT", "m_BuffButton3", "TOPLEFT", anchorx, 0);
					m_BuffButton5:SetPoint("TOPLEFT", "m_BuffButton4", "TOPLEFT", anchorx, 0);
					m_BuffButton6:SetPoint("TOPLEFT", "m_BuffButton5", "TOPLEFT", anchorx, 0);
					m_BuffButton7:SetPoint("TOPLEFT", "m_BuffButton6", "TOPLEFT", anchorx, 0);
					m_BuffButton8:SetPoint("TOPLEFT", "m_BuffButton7", "TOPLEFT", anchorx, 0);
					m_BuffButton9:SetPoint("TOPLEFT", "m_BuffButton1", "BOTTOMLEFT", anchorx2, anchory2);
					m_BuffButton10:SetPoint("TOPLEFT", "m_BuffButton2", "BOTTOMLEFT", anchorx2, anchory2);
					m_BuffButton11:SetPoint("TOPLEFT", "m_BuffButton3", "BOTTOMLEFT", anchorx2, anchory2);
					m_BuffButton12:SetPoint("TOPLEFT", "m_BuffButton4", "BOTTOMLEFT", anchorx2, anchory2);
					m_BuffButton13:SetPoint("TOPLEFT", "m_BuffButton5", "BOTTOMLEFT", anchorx2, anchory2);
					m_BuffButton14:SetPoint("TOPLEFT", "m_BuffButton6", "BOTTOMLEFT", anchorx2, anchory2);
					m_BuffButton15:SetPoint("TOPLEFT", "m_BuffButton7", "BOTTOMLEFT", anchorx2, anchory2);
					m_BuffButton16:SetPoint("TOPLEFT", "m_BuffButton8", "BOTTOMLEFT", anchorx2, anchory2);
			end
				
		elseif (m_boptions.downup == "UP") then
		----------------------
		-- BOTTOM ROW FIRST --
		----------------------
			if (m_boptions.rightleft == 1) then
				----------------------------
				-- SCROLL BUFFS FROM LEFT TO RIGHT --
				----------------------------
					anchorx = -2;
					anchorx2 = 0;
					anchory	= -76;
					anchory2 = 48;
					m_BuffFrame:ClearAllPoints();
 					m_BuffButton1:SetPoint("TOPLEFT", "m_BuffFrameCapsule", "TOPLEFT", -2, anchory);
					m_BuffButton2:SetPoint("TOPLEFT", "m_BuffButton1", "TOPRIGHT", anchorx, 0);
					m_BuffButton3:SetPoint("TOPLEFT", "m_BuffButton2", "TOPRIGHT", anchorx, 0);
					m_BuffButton4:SetPoint("TOPLEFT", "m_BuffButton3", "TOPRIGHT", anchorx, 0);
					m_BuffButton5:SetPoint("TOPLEFT", "m_BuffButton4", "TOPRIGHT", anchorx, 0);
					m_BuffButton6:SetPoint("TOPLEFT", "m_BuffButton5", "TOPRIGHT", anchorx, 0);
					m_BuffButton7:SetPoint("TOPLEFT", "m_BuffButton6", "TOPRIGHT", anchorx, 0);
					m_BuffButton8:SetPoint("TOPLEFT", "m_BuffButton7", "TOPRIGHT", anchorx, 0);
					m_BuffButton9:SetPoint("TOPLEFT", "m_BuffButton1", "TOPLEFT", anchorx2, anchory2);
					m_BuffButton10:SetPoint("TOPLEFT", "m_BuffButton2", "TOPLEFT", anchorx2, anchory2);
					m_BuffButton11:SetPoint("TOPLEFT", "m_BuffButton3", "TOPLEFT", anchorx2, anchory2);
					m_BuffButton12:SetPoint("TOPLEFT", "m_BuffButton4", "TOPLEFT", anchorx2, anchory2);
					m_BuffButton13:SetPoint("TOPLEFT", "m_BuffButton5", "TOPLEFT", anchorx2, anchory2);
					m_BuffButton14:SetPoint("TOPLEFT", "m_BuffButton6", "TOPLEFT", anchorx2, anchory2);
					m_BuffButton15:SetPoint("TOPLEFT", "m_BuffButton7", "TOPLEFT", anchorx2, anchory2);
					m_BuffButton16:SetPoint("TOPLEFT", "m_BuffButton8", "TOPLEFT", anchorx2, anchory2);
			elseif (m_boptions.rightleft == 0) then
				----------------------------
				-- SCROLL BUFFS FROM RIGHT TO LEFT --
				----------------------------
         	anchorx = -38;
					anchorx2 = 0;
					anchory	= 18;
					anchory2 = 48;
					m_BuffFrame:ClearAllPoints();
					m_BuffButton1:SetPoint("TOPLEFT", "m_BuffFrameCapsule", "BOTTOMRIGHT", -37, 19);
					m_BuffButton2:SetPoint("TOPLEFT", "m_BuffButton1", "TOPLEFT", anchorx, 0);
					m_BuffButton3:SetPoint("TOPLEFT", "m_BuffButton2", "TOPLEFT", anchorx, 0);
					m_BuffButton4:SetPoint("TOPLEFT", "m_BuffButton3", "TOPLEFT", anchorx, 0);
					m_BuffButton5:SetPoint("TOPLEFT", "m_BuffButton4", "TOPLEFT", anchorx, 0);
					m_BuffButton6:SetPoint("TOPLEFT", "m_BuffButton5", "TOPLEFT", anchorx, 0);
					m_BuffButton7:SetPoint("TOPLEFT", "m_BuffButton6", "TOPLEFT", anchorx, 0);
					m_BuffButton8:SetPoint("TOPLEFT", "m_BuffButton7", "TOPLEFT", anchorx, 0);
					m_BuffButton9:SetPoint("TOPLEFT", "m_BuffButton1", "TOPLEFT", anchorx2, anchory2);
					m_BuffButton10:SetPoint("TOPLEFT", "m_BuffButton2", "TOPLEFT", anchorx2, anchory2);
					m_BuffButton11:SetPoint("TOPLEFT", "m_BuffButton3", "TOPLEFT", anchorx2, anchory2);
					m_BuffButton12:SetPoint("TOPLEFT", "m_BuffButton4", "TOPLEFT", anchorx2, anchory2);
					m_BuffButton13:SetPoint("TOPLEFT", "m_BuffButton5", "TOPLEFT", anchorx2, anchory2);
					m_BuffButton14:SetPoint("TOPLEFT", "m_BuffButton6", "TOPLEFT", anchorx2, anchory2);
					m_BuffButton15:SetPoint("TOPLEFT", "m_BuffButton7", "TOPLEFT", anchorx2, anchory2);
					m_BuffButton16:SetPoint("TOPLEFT", "m_BuffButton8", "TOPLEFT", anchorx2, anchory2);
			end                
		end
		
	elseif (m_boptions.displaymode >= 8 and m_boptions.displaymode <= 9) then
        -- 16 ROWS, 1 COLUMN
		if (m_boptions.downup == "DOWN") then
				----------------------------
				-- SCROLL BUFFS DOWNWARDS --
				----------------------------
					anchorx = -2;
					anchorx2 = 0;
					anchory	= -28;
					anchory2 = 20;
					paddingv = -28;
					paddingh = 0;
					m_BuffFrame:ClearAllPoints();
					m_BuffButton1:SetPoint("TOPLEFT", "m_BuffFrameCapsule", "TOPLEFT", anchorx, anchory);
					m_BuffButton2:SetPoint("TOPLEFT", "m_BuffButton1", "BOTTOMLEFT", 0, paddingv);
					m_BuffButton3:SetPoint("TOPLEFT", "m_BuffButton2", "BOTTOMLEFT", 0, paddingv);
					m_BuffButton4:SetPoint("TOPLEFT", "m_BuffButton3", "BOTTOMLEFT", 0, paddingv);
					m_BuffButton5:SetPoint("TOPLEFT", "m_BuffButton4", "BOTTOMLEFT", 0, paddingv);
					m_BuffButton6:SetPoint("TOPLEFT", "m_BuffButton5", "BOTTOMLEFT", 0, paddingv);
					m_BuffButton7:SetPoint("TOPLEFT", "m_BuffButton6", "BOTTOMLEFT", 0, paddingv);
					m_BuffButton8:SetPoint("TOPLEFT", "m_BuffButton7", "BOTTOMLEFT", 0, paddingv);
					m_BuffButton9:SetPoint("TOPLEFT", "m_BuffButton8", "BOTTOMLEFT", anchorx2, paddingv);
					m_BuffButton10:SetPoint("TOPLEFT", "m_BuffButton9", "BOTTOMLEFT", anchorx2, paddingv);
					m_BuffButton11:SetPoint("TOPLEFT", "m_BuffButton10", "BOTTOMLEFT", anchorx2, paddingv);
					m_BuffButton12:SetPoint("TOPLEFT", "m_BuffButton11", "BOTTOMLEFT", anchorx2, paddingv);
					m_BuffButton13:SetPoint("TOPLEFT", "m_BuffButton12", "BOTTOMLEFT", anchorx2, paddingv);
					m_BuffButton14:SetPoint("TOPLEFT", "m_BuffButton13", "BOTTOMLEFT", anchorx2, paddingv);
					m_BuffButton15:SetPoint("TOPLEFT", "m_BuffButton14", "BOTTOMLEFT", anchorx2, paddingv);
					m_BuffButton16:SetPoint("TOPLEFT", "m_BuffButton15", "BOTTOMLEFT", anchorx2, paddingv);
		elseif (m_boptions.downup == "UP") then
				--------------------------
				-- SCROLL BUFFS UPWARDS --
				--------------------------
					anchorx = -2;
					anchorx2 = 37;
					anchory	= -748;
					paddingv = 48;
					paddingh = 0;
					m_BuffFrame:ClearAllPoints();
					m_BuffButton1:SetPoint("TOPLEFT", "m_BuffFrameCapsule", "TOPLEFT", anchorx, anchory);
					m_BuffButton2:SetPoint("TOPLEFT", "m_BuffButton1", "TOPLEFT", 0, paddingv);
					m_BuffButton3:SetPoint("TOPLEFT", "m_BuffButton2", "TOPLEFT", 0, paddingv);
					m_BuffButton4:SetPoint("TOPLEFT", "m_BuffButton3", "TOPLEFT", 0, paddingv);
					m_BuffButton5:SetPoint("TOPLEFT", "m_BuffButton4", "TOPLEFT", 0, paddingv);
					m_BuffButton6:SetPoint("TOPLEFT", "m_BuffButton5", "TOPLEFT", 0, paddingv);
					m_BuffButton7:SetPoint("TOPLEFT", "m_BuffButton6", "TOPLEFT", 0, paddingv);
					m_BuffButton8:SetPoint("TOPLEFT", "m_BuffButton7", "TOPLEFT", 0, paddingv);
					m_BuffButton9:SetPoint("TOPLEFT", "m_BuffButton8", "TOPLEFT", 0, paddingv);
					m_BuffButton10:SetPoint("TOPLEFT", "m_BuffButton9", "TOPLEFT", 0, paddingv);
					m_BuffButton11:SetPoint("TOPLEFT", "m_BuffButton10", "TOPLEFT", 0, paddingv);
					m_BuffButton12:SetPoint("TOPLEFT", "m_BuffButton11", "TOPLEFT", 0, paddingv);
					m_BuffButton13:SetPoint("TOPLEFT", "m_BuffButton12", "TOPLEFT", 0, paddingv);
					m_BuffButton14:SetPoint("TOPLEFT", "m_BuffButton13", "TOPLEFT", 0, paddingv);
					m_BuffButton15:SetPoint("TOPLEFT", "m_BuffButton14", "TOPLEFT", 0, paddingv);
					m_BuffButton16:SetPoint("TOPLEFT", "m_BuffButton15", "TOPLEFT", 0, paddingv);	
		end
		
	elseif (m_boptions.displaymode >= 10 and m_boptions.displaymode <= 11) then
		if (m_boptions.rightleft == 1) then
				----------------------------
				-- SCROLL BUFFS FROM LEFT TO RIGHT --
				----------------------------
					anchorx = -2;
					anchorx2 = 0;
					anchory	= -28;
					anchory2 = -28;
					m_BuffFrame:ClearAllPoints();
					m_BuffButton1:SetPoint("TOPLEFT", "m_BuffFrameCapsule", "TOPLEFT", anchorx, anchory);
					m_BuffButton2:SetPoint("TOPLEFT", "m_BuffButton1", "TOPRIGHT", anchorx, 0);
					m_BuffButton3:SetPoint("TOPLEFT", "m_BuffButton2", "TOPRIGHT", anchorx, 0);
					m_BuffButton4:SetPoint("TOPLEFT", "m_BuffButton3", "TOPRIGHT", anchorx, 0);
					m_BuffButton5:SetPoint("TOPLEFT", "m_BuffButton4", "TOPRIGHT", anchorx, 0);
					m_BuffButton6:SetPoint("TOPLEFT", "m_BuffButton5", "TOPRIGHT", anchorx, 0);
					m_BuffButton7:SetPoint("TOPLEFT", "m_BuffButton6", "TOPRIGHT", anchorx, 0);
					m_BuffButton8:SetPoint("TOPLEFT", "m_BuffButton7", "TOPRIGHT", anchorx, 0);
					m_BuffButton9:SetPoint("TOPLEFT", "m_BuffButton8", "TOPRIGHT", anchorx, 0);
					m_BuffButton10:SetPoint("TOPLEFT", "m_BuffButton9", "TOPRIGHT", anchorx, 0);
					m_BuffButton11:SetPoint("TOPLEFT", "m_BuffButton10", "TOPRIGHT", anchorx, 0);
					m_BuffButton12:SetPoint("TOPLEFT", "m_BuffButton11", "TOPRIGHT", anchorx, 0);
					m_BuffButton13:SetPoint("TOPLEFT", "m_BuffButton12", "TOPRIGHT", anchorx, 0);
					m_BuffButton14:SetPoint("TOPLEFT", "m_BuffButton13", "TOPRIGHT", anchorx, 0);
					m_BuffButton15:SetPoint("TOPLEFT", "m_BuffButton14", "TOPRIGHT", anchorx, 0);
					m_BuffButton16:SetPoint("TOPLEFT", "m_BuffButton15", "TOPRIGHT", anchorx, 0);
		elseif (m_boptions.rightleft == 0) then
				----------------------------
				-- SCROLL BUFFS FROM RIGHT TO LEFT --
				----------------------------
          anchorx = -38;
					anchorx2 = 0;
					anchory	= -28;
					anchory2 = -28;
					m_BuffFrame:ClearAllPoints();
					m_BuffButton1:SetPoint("TOPLEFT", "m_BuffFrameCapsule", "TOPRIGHT", anchorx, anchory);
					m_BuffButton2:SetPoint("TOPLEFT", "m_BuffButton1", "TOPLEFT", anchorx, 0);
					m_BuffButton3:SetPoint("TOPLEFT", "m_BuffButton2", "TOPLEFT", anchorx, 0);
					m_BuffButton4:SetPoint("TOPLEFT", "m_BuffButton3", "TOPLEFT", anchorx, 0);
					m_BuffButton5:SetPoint("TOPLEFT", "m_BuffButton4", "TOPLEFT", anchorx, 0);
					m_BuffButton6:SetPoint("TOPLEFT", "m_BuffButton5", "TOPLEFT", anchorx, 0);
					m_BuffButton7:SetPoint("TOPLEFT", "m_BuffButton6", "TOPLEFT", anchorx, 0);
					m_BuffButton8:SetPoint("TOPLEFT", "m_BuffButton7", "TOPLEFT", anchorx, 0);
					m_BuffButton9:SetPoint("TOPLEFT", "m_BuffButton8", "TOPLEFT", anchorx, 0);
					m_BuffButton10:SetPoint("TOPLEFT", "m_BuffButton9", "TOPLEFT", anchorx, 0);
					m_BuffButton11:SetPoint("TOPLEFT", "m_BuffButton10", "TOPLEFT", anchorx, 0);
					m_BuffButton12:SetPoint("TOPLEFT", "m_BuffButton11", "TOPLEFT", anchorx, 0);
					m_BuffButton13:SetPoint("TOPLEFT", "m_BuffButton12", "TOPLEFT", anchorx, 0);
					m_BuffButton14:SetPoint("TOPLEFT", "m_BuffButton13", "TOPLEFT", anchorx, 0);
					m_BuffButton15:SetPoint("TOPLEFT", "m_BuffButton14", "TOPLEFT", anchorx, 0);
					m_BuffButton16:SetPoint("TOPLEFT", "m_BuffButton15", "TOPLEFT", anchorx, 0);
		end            
	end
	
elseif (m_boptions.size == 1) then
	--LARGE BUFFS
end
    
    -------------
    -- DEBUFFS --
    -------------
    if (m_doptions.size == 1) then
    -- LARGE DEBUFFS
    	if(m_doptions.icon_side == 0) then
    	-- DEBUFF ICON ON LEFT SIDE
        if (m_doptions.downup == "UP") then
        	local anchorx1 = -28;
        	local anchory1 = -3;
					m_DeBuffFrame:ClearAllPoints();
					
					m_DeBuffButton1:ClearAllPoints();
					m_DeBuffButton1Icon:ClearAllPoints();
					m_DeBuffButton1DeBuffBorder:ClearAllPoints();			
					m_DeBuffButton1:SetWidth(155);
					m_DeBuffButton1:SetHeight(36);
					--m_DeBuffButton8Icon:SetPoint("RIGHT", "$parent", "RIGHT", 28, 0);
					--m_DeBuffButton8DeBuffBorder:SetPoint("RIGHT", "$parent", "RIGHT", 29, 0);	
					m_DeBuffButton1:SetPoint("TOPLEFT", "m_DeBuffFrameCapsule", "TOPLEFT", 28, -229);
					m_DeBuffButton1DeBuffBorder:SetPoint("TOPLEFT", "$parent", "TOPLEFT", -29, -2);
					m_DeBuffButton1Icon:SetPoint("TOPLEFT", "$parent", "TOPLEFT", anchorx1, -3);


					m_DeBuffButton2:ClearAllPoints();
					m_DeBuffButton2Icon:ClearAllPoints();
					m_DeBuffButton2DeBuffBorder:ClearAllPoints();			
					m_DeBuffButton2:SetWidth(155);
					m_DeBuffButton2:SetHeight(36);						
					m_DeBuffButton2:SetPoint("TOPLEFT", "m_DeBuffButton1", "TOPLEFT", 0, 33);
					m_DeBuffButton2DeBuffBorder:SetPoint("TOPLEFT", "$parent", "TOPLEFT", -29, -2);
					m_DeBuffButton2Icon:SetPoint("TOPLEFT", "$parent", "TOPLEFT", anchorx1, anchory1);

					m_DeBuffButton3:ClearAllPoints();
					m_DeBuffButton3Icon:ClearAllPoints();
					m_DeBuffButton3DeBuffBorder:ClearAllPoints();			
					m_DeBuffButton3:SetWidth(155);
					m_DeBuffButton3:SetHeight(36);					
					m_DeBuffButton3:SetPoint("TOPLEFT", "m_DeBuffButton2", "TOPLEFT", 0, 33);
					m_DeBuffButton3DeBuffBorder:SetPoint("TOPLEFT", "$parent", "TOPLEFT", -29, -2);
					m_DeBuffButton3Icon:SetPoint("TOPLEFT", "$parent", "TOPLEFT", anchorx1, anchory1);

					m_DeBuffButton4:ClearAllPoints();
					m_DeBuffButton4Icon:ClearAllPoints();
					m_DeBuffButton4DeBuffBorder:ClearAllPoints();			
					m_DeBuffButton4:SetWidth(155);
					m_DeBuffButton4:SetHeight(36);					
					m_DeBuffButton4:SetPoint("TOPLEFT", "m_DeBuffButton3", "TOPLEFT", 0, 33);
					m_DeBuffButton4DeBuffBorder:SetPoint("TOPLEFT", "$parent", "TOPLEFT", -29, -2);
					m_DeBuffButton4Icon:SetPoint("TOPLEFT", "$parent", "TOPLEFT", anchorx1, anchory1);

					m_DeBuffButton5:ClearAllPoints();
					m_DeBuffButton5Icon:ClearAllPoints();
					m_DeBuffButton5DeBuffBorder:ClearAllPoints();			
					m_DeBuffButton5:SetWidth(155);
					m_DeBuffButton5:SetHeight(36);
					m_DeBuffButton5:SetPoint("TOPLEFT", "m_DeBuffButton4", "TOPLEFT", 0, 33);
					m_DeBuffButton5DeBuffBorder:SetPoint("TOPLEFT", "$parent", "TOPLEFT", -29, -2);
					m_DeBuffButton5Icon:SetPoint("TOPLEFT", "$parent", "TOPLEFT", anchorx1, anchory1);

					m_DeBuffButton6:ClearAllPoints();
					m_DeBuffButton6Icon:ClearAllPoints();
					m_DeBuffButton6DeBuffBorder:ClearAllPoints();			
					m_DeBuffButton6:SetWidth(155);
					m_DeBuffButton6:SetHeight(36);
					m_DeBuffButton6:SetPoint("TOPLEFT", "m_DeBuffButton5", "TOPLEFT", 0, 33);
					m_DeBuffButton6DeBuffBorder:SetPoint("TOPLEFT", "$parent", "TOPLEFT", -29, -2);
					m_DeBuffButton6Icon:SetPoint("TOPLEFT", "$parent", "TOPLEFT", anchorx1, anchory1);

					m_DeBuffButton7:ClearAllPoints();
					m_DeBuffButton7Icon:ClearAllPoints();
					m_DeBuffButton7DeBuffBorder:ClearAllPoints();			
					m_DeBuffButton7:SetWidth(155);
					m_DeBuffButton7:SetHeight(36);					
					m_DeBuffButton7:SetPoint("TOPLEFT", "m_DeBuffButton6", "TOPLEFT", 0, 33);
					m_DeBuffButton7DeBuffBorder:SetPoint("TOPLEFT", "$parent", "TOPLEFT", -29, -2);
					m_DeBuffButton7Icon:SetPoint("TOPLEFT", "$parent", "TOPLEFT", anchorx1, anchory1);

					m_DeBuffButton8:ClearAllPoints();
					m_DeBuffButton8Icon:ClearAllPoints();
					m_DeBuffButton8DeBuffBorder:ClearAllPoints();			
					m_DeBuffButton8:SetWidth(155);
					m_DeBuffButton8:SetHeight(36);
					m_DeBuffButton8:SetPoint("TOPLEFT", "m_DeBuffButton7", "TOPLEFT", 0, 33);
					m_DeBuffButton8DeBuffBorder:SetPoint("TOPLEFT", "$parent", "TOPLEFT", -29, -2);
					m_DeBuffButton8Icon:SetPoint("TOPLEFT", "$parent", "TOPLEFT", anchorx1, anchory1);
								
        elseif (m_doptions.downup == "DOWN") then
        	local anchorx1 = -28;
        	local anchory1 = -3;
					m_DeBuffFrame:ClearAllPoints();
					m_DeBuffButton1:ClearAllPoints();
					m_DeBuffButton1Icon:ClearAllPoints();
					m_DeBuffButton1DeBuffBorder:ClearAllPoints();			
					m_DeBuffButton1:SetWidth(155);
					m_DeBuffButton1:SetHeight(36);					
					m_DeBuffButton1:SetPoint("TOPLEFT", "m_DeBuffFrameCapsule", "TOPLEFT", 28, 2);
					m_DeBuffButton1DeBuffBorder:SetPoint("TOPLEFT", "$parent", "TOPLEFT", -29, -2);
					m_DeBuffButton1Icon:SetPoint("TOPLEFT", "$parent", "TOPLEFT", anchorx1, -3);


					m_DeBuffButton2:ClearAllPoints();
					m_DeBuffButton2Icon:ClearAllPoints();
					m_DeBuffButton2DeBuffBorder:ClearAllPoints();			
					m_DeBuffButton2:SetWidth(155);
					m_DeBuffButton2:SetHeight(36);					
					m_DeBuffButton2:SetPoint("TOPLEFT", "m_DeBuffButton1", "TOPLEFT", 0, -33);
					m_DeBuffButton2DeBuffBorder:SetPoint("TOPLEFT", "$parent", "TOPLEFT", -29, -2);
					m_DeBuffButton2Icon:SetPoint("TOPLEFT", "$parent", "TOPLEFT", anchorx1, anchory1);					

					m_DeBuffButton3:ClearAllPoints();
					m_DeBuffButton3Icon:ClearAllPoints();
					m_DeBuffButton3DeBuffBorder:ClearAllPoints();			
					m_DeBuffButton3:SetWidth(155);
					m_DeBuffButton3:SetHeight(36);					
					m_DeBuffButton3:SetPoint("TOPLEFT", "m_DeBuffButton2", "TOPLEFT", 0, -33);
					m_DeBuffButton3DeBuffBorder:SetPoint("TOPLEFT", "$parent", "TOPLEFT", -29, -2);
					m_DeBuffButton3Icon:SetPoint("TOPLEFT", "$parent", "TOPLEFT", anchorx1, anchory1);					

					m_DeBuffButton4:ClearAllPoints();
					m_DeBuffButton4Icon:ClearAllPoints();
					m_DeBuffButton4DeBuffBorder:ClearAllPoints();			
					m_DeBuffButton4:SetWidth(155);
					m_DeBuffButton4:SetHeight(36);					
					m_DeBuffButton4:SetPoint("TOPLEFT", "m_DeBuffButton3", "TOPLEFT", 0, -33);
					m_DeBuffButton4DeBuffBorder:SetPoint("TOPLEFT", "$parent", "TOPLEFT", -29, -2);
					m_DeBuffButton4Icon:SetPoint("TOPLEFT", "$parent", "TOPLEFT", anchorx1, anchory1);					

					m_DeBuffButton5:ClearAllPoints();
					m_DeBuffButton5Icon:ClearAllPoints();
					m_DeBuffButton5DeBuffBorder:ClearAllPoints();			
					m_DeBuffButton5:SetWidth(155);
					m_DeBuffButton5:SetHeight(36);					
					m_DeBuffButton5:SetPoint("TOPLEFT", "m_DeBuffButton4", "TOPLEFT", 0, -33);
					m_DeBuffButton5DeBuffBorder:SetPoint("TOPLEFT", "$parent", "TOPLEFT", -29, -2);
					m_DeBuffButton5Icon:SetPoint("TOPLEFT", "$parent", "TOPLEFT", anchorx1, anchory1);					

					m_DeBuffButton6:ClearAllPoints();
					m_DeBuffButton6Icon:ClearAllPoints();
					m_DeBuffButton6DeBuffBorder:ClearAllPoints();			
					m_DeBuffButton6:SetWidth(155);
					m_DeBuffButton6:SetHeight(36);					
					m_DeBuffButton6:SetPoint("TOPLEFT", "m_DeBuffButton5", "TOPLEFT", 0, -33);
					m_DeBuffButton6DeBuffBorder:SetPoint("TOPLEFT", "$parent", "TOPLEFT", -29, -2);
					m_DeBuffButton6Icon:SetPoint("TOPLEFT", "$parent", "TOPLEFT", anchorx1, anchory1);					

					m_DeBuffButton7:ClearAllPoints();
					m_DeBuffButton7Icon:ClearAllPoints();
					m_DeBuffButton7DeBuffBorder:ClearAllPoints();			
					m_DeBuffButton7:SetWidth(155);
					m_DeBuffButton7:SetHeight(36);					
					m_DeBuffButton7:SetPoint("TOPLEFT", "m_DeBuffButton6", "TOPLEFT", 0, -33);
					m_DeBuffButton7DeBuffBorder:SetPoint("TOPLEFT", "$parent", "TOPLEFT", -29, -2);
					m_DeBuffButton7Icon:SetPoint("TOPLEFT", "$parent", "TOPLEFT", anchorx1, anchory1);					

					m_DeBuffButton8:ClearAllPoints();
					m_DeBuffButton8Icon:ClearAllPoints();
					m_DeBuffButton8DeBuffBorder:ClearAllPoints();			
					m_DeBuffButton8:SetWidth(155);
					m_DeBuffButton8:SetHeight(36);					
					m_DeBuffButton8:SetPoint("TOPLEFT", "m_DeBuffButton7", "TOPLEFT", 0, -33);
					m_DeBuffButton8DeBuffBorder:SetPoint("TOPLEFT", "$parent", "TOPLEFT", -29, -2);
					m_DeBuffButton8Icon:SetPoint("TOPLEFT", "$parent", "TOPLEFT", anchorx1, anchory1);					
					            
        end
			elseif (m_doptions.icon_side == 1) then
			-- DEBUFF ICON ON RIGHT SIDE
        if (m_doptions.downup == "UP") then
        	local anchorx1 = -2;
        	local anchory1 = -3;
					m_DeBuffFrame:ClearAllPoints();


					m_DeBuffButton1:ClearAllPoints();
					m_DeBuffButton1Icon:ClearAllPoints();
					m_DeBuffButton1DeBuffBorder:ClearAllPoints();			
					m_DeBuffButton1:SetWidth(155);
					m_DeBuffButton1:SetHeight(36);
					m_DeBuffButton1Icon:SetPoint("RIGHT", "$parent", "RIGHT", 28, 0);
					m_DeBuffButton1DeBuffBorder:SetPoint("RIGHT", "$parent", "RIGHT", 29, 0);		
					m_DeBuffButton1:SetPoint("TOPLEFT", "m_DeBuffFrameCapsule", "TOPLEFT", -3, -229);
					--m_DeBuffButton1Icon:SetPoint("TOPLEFT", "$parent", "TOPRIGHT", anchorx1, -3);					
					--m_DeBuffButton1DeBuffBorder:SetPoint("TOPLEFT", "$parent", "TOPRIGHT", -3, -2);
					
					m_DeBuffButton2:ClearAllPoints();
					m_DeBuffButton2Icon:ClearAllPoints();
					m_DeBuffButton2DeBuffBorder:ClearAllPoints();			
					m_DeBuffButton2:SetWidth(155);
					m_DeBuffButton2:SetHeight(36);
					m_DeBuffButton2Icon:SetPoint("RIGHT", "$parent", "RIGHT", 28, 0);										
					m_DeBuffButton2DeBuffBorder:SetPoint("RIGHT", "$parent", "RIGHT", 29, 0);	
					m_DeBuffButton2:SetPoint("TOPLEFT", "m_DeBuffButton1", "TOPLEFT", 0, 33);
					--m_DeBuffButton2Icon:SetPoint("TOPLEFT", "$parent", "TOPRIGHT", anchorx1, anchory1);					
					--m_DeBuffButton2DeBuffBorder:SetPoint("TOPLEFT", "$parent", "TOPRIGHT", -3, -2);
					
					m_DeBuffButton3:ClearAllPoints();
					m_DeBuffButton3Icon:ClearAllPoints();
					m_DeBuffButton3DeBuffBorder:ClearAllPoints();			
					m_DeBuffButton3:SetWidth(155);
					m_DeBuffButton3:SetHeight(36);
					m_DeBuffButton3Icon:SetPoint("RIGHT", "$parent", "RIGHT", 28, 0);					
					m_DeBuffButton3DeBuffBorder:SetPoint("RIGHT", "$parent", "RIGHT", 29, 0);	
					m_DeBuffButton3:SetPoint("TOPLEFT", "m_DeBuffButton2", "TOPLEFT", 0, 33);
					--m_DeBuffButton3Icon:SetPoint("TOPLEFT", "$parent", "TOPRIGHT", anchorx1, anchory1);					
					--m_DeBuffButton3DeBuffBorder:SetPoint("TOPLEFT", "$parent", "TOPRIGHT", -3, -2);					

					m_DeBuffButton4:ClearAllPoints();
					m_DeBuffButton4Icon:ClearAllPoints();
					m_DeBuffButton4DeBuffBorder:ClearAllPoints();			
					m_DeBuffButton4:SetWidth(155);
					m_DeBuffButton4:SetHeight(36);
					m_DeBuffButton4Icon:SetPoint("RIGHT", "$parent", "RIGHT", 28, 0);					
					m_DeBuffButton4DeBuffBorder:SetPoint("RIGHT", "$parent", "RIGHT", 29, 0);	
					m_DeBuffButton4:SetPoint("TOPLEFT", "m_DeBuffButton3", "TOPLEFT", 0, 33);
					--m_DeBuffButton4Icon:SetPoint("TOPLEFT", "$parent", "TOPRIGHT", anchorx1, anchory1);					
					--m_DeBuffButton4DeBuffBorder:SetPoint("TOPLEFT", "$parent", "TOPRIGHT", -3, -2);


					m_DeBuffButton5:ClearAllPoints();
					m_DeBuffButton5Icon:ClearAllPoints();
					m_DeBuffButton5DeBuffBorder:ClearAllPoints();			
					m_DeBuffButton5:SetWidth(155);
					m_DeBuffButton5:SetHeight(36);
					m_DeBuffButton5Icon:SetPoint("RIGHT", "$parent", "RIGHT", 28, 0);										
					m_DeBuffButton5DeBuffBorder:SetPoint("RIGHT", "$parent", "RIGHT", 29, 0);	
					m_DeBuffButton5:SetPoint("TOPLEFT", "m_DeBuffButton4", "TOPLEFT", 0, 33);
					--m_DeBuffButton5Icon:SetPoint("TOPLEFT", "$parent", "TOPRIGHT", anchorx1, anchory1);					
					--m_DeBuffButton5DeBuffBorder:SetPoint("TOPLEFT", "$parent", "TOPRIGHT", -3, -2);

					m_DeBuffButton6:ClearAllPoints();
					m_DeBuffButton6Icon:ClearAllPoints();
					m_DeBuffButton6DeBuffBorder:ClearAllPoints();			
					m_DeBuffButton6:SetWidth(155);
					m_DeBuffButton6:SetHeight(36);
					m_DeBuffButton6Icon:SetPoint("RIGHT", "$parent", "RIGHT", 28, 0);
					m_DeBuffButton6DeBuffBorder:SetPoint("RIGHT", "$parent", "RIGHT", 29, 0);																
					m_DeBuffButton6:SetPoint("TOPLEFT", "m_DeBuffButton5", "TOPLEFT", 0, 33);
					--m_DeBuffButton6Icon:SetPoint("TOPLEFT", "$parent", "TOPRIGHT", anchorx1, anchory1);					
					--m_DeBuffButton6DeBuffBorder:SetPoint("TOPLEFT", "$parent", "TOPRIGHT", -3, -2);
										
					m_DeBuffButton7:ClearAllPoints();
					m_DeBuffButton7Icon:ClearAllPoints();
					m_DeBuffButton7DeBuffBorder:ClearAllPoints();			
					m_DeBuffButton7:SetWidth(155);
					m_DeBuffButton7:SetHeight(36);
					m_DeBuffButton7Icon:SetPoint("RIGHT", "$parent", "RIGHT", 28, 0);
					m_DeBuffButton7DeBuffBorder:SetPoint("RIGHT", "$parent", "RIGHT", 29, 0);						
					m_DeBuffButton7:SetPoint("TOPLEFT", "m_DeBuffButton6", "TOPLEFT", 0, 33);
					--m_DeBuffButton7Icon:SetPoint("TOPLEFT", "$parent", "TOPRIGHT", anchorx1, anchory1);					
					--m_DeBuffButton7DeBuffBorder:SetPoint("TOPLEFT", "$parent", "TOPRIGHT", -3, -2);

					m_DeBuffButton8:ClearAllPoints();
					m_DeBuffButton8Icon:ClearAllPoints();
					m_DeBuffButton8DeBuffBorder:ClearAllPoints();			
					m_DeBuffButton8:SetWidth(155);
					m_DeBuffButton8:SetHeight(36);
					m_DeBuffButton8Icon:SetPoint("RIGHT", "$parent", "RIGHT", 28, 0);
					m_DeBuffButton8DeBuffBorder:SetPoint("RIGHT", "$parent", "RIGHT", 29, 0);															
					m_DeBuffButton8:SetPoint("TOPLEFT", "m_DeBuffButton7", "TOPLEFT", 0, 33);
					--m_DeBuffButton8Icon:SetPoint("TOPLEFT", "$parent", "TOPRIGHT", anchorx1, anchory1);					
					--m_DeBuffButton8DeBuffBorder:SetPoint("TOPLEFT", "$parent", "TOPRIGHT", -3, -2);
										
        elseif (m_doptions.downup == "DOWN") then
        	local anchorx1 = -2;
        	local anchory1 = -3;        
					m_DeBuffFrame:ClearAllPoints();
					
					m_DeBuffButton1:ClearAllPoints();
					m_DeBuffButton1Icon:ClearAllPoints();
					m_DeBuffButton1DeBuffBorder:ClearAllPoints();			
					m_DeBuffButton1:SetWidth(155);
					m_DeBuffButton1:SetHeight(36);
					m_DeBuffButton1Icon:SetPoint("RIGHT", "$parent", "RIGHT", 28, 0);
					m_DeBuffButton1DeBuffBorder:SetPoint("RIGHT", "$parent", "RIGHT", 29, 0);						
					m_DeBuffButton1:SetPoint("TOPLEFT", "m_DeBuffFrameCapsule", "TOPLEFT", -3, 2);
					--m_DeBuffButton1Icon:SetPoint("TOPLEFT", "$parent", "TOPRIGHT", anchorx1, -3);					
					--m_DeBuffButton1DeBuffBorder:SetPoint("TOPLEFT", "$parent", "TOPRIGHT", -3, -2);

					m_DeBuffButton2:ClearAllPoints();
					m_DeBuffButton2Icon:ClearAllPoints();
					m_DeBuffButton2DeBuffBorder:ClearAllPoints();			
					m_DeBuffButton2:SetWidth(155);
					m_DeBuffButton2:SetHeight(36);
					m_DeBuffButton2Icon:SetPoint("RIGHT", "$parent", "RIGHT", 28, 0);
					m_DeBuffButton2DeBuffBorder:SetPoint("RIGHT", "$parent", "RIGHT", 29, 0);						
					m_DeBuffButton2:SetPoint("TOPLEFT", "m_DeBuffButton1", "TOPLEFT", 0, -33);
					--m_DeBuffButton2Icon:SetPoint("TOPLEFT", "$parent", "TOPRIGHT", anchorx1, anchory1);					
					--m_DeBuffButton2DeBuffBorder:SetPoint("TOPLEFT", "$parent", "TOPRIGHT", -3, -2);

					m_DeBuffButton3:ClearAllPoints();
					m_DeBuffButton3Icon:ClearAllPoints();
					m_DeBuffButton3DeBuffBorder:ClearAllPoints();			
					m_DeBuffButton3:SetWidth(155);
					m_DeBuffButton3:SetHeight(36);
					m_DeBuffButton3Icon:SetPoint("RIGHT", "$parent", "RIGHT", 28, 0);
					m_DeBuffButton3DeBuffBorder:SetPoint("RIGHT", "$parent", "RIGHT", 29, 0);											
					m_DeBuffButton3:SetPoint("TOPLEFT", "m_DeBuffButton2", "TOPLEFT", 0, -33);
					--m_DeBuffButton3Icon:SetPoint("TOPLEFT", "$parent", "TOPRIGHT", anchorx1, anchory1);					
					--m_DeBuffButton3DeBuffBorder:SetPoint("TOPLEFT", "$parent", "TOPRIGHT", -3, -2);

					m_DeBuffButton4:ClearAllPoints();
					m_DeBuffButton4Icon:ClearAllPoints();
					m_DeBuffButton4DeBuffBorder:ClearAllPoints();			
					m_DeBuffButton4:SetWidth(155);
					m_DeBuffButton4:SetHeight(36);
					m_DeBuffButton4Icon:SetPoint("RIGHT", "$parent", "RIGHT", 28, 0);
					m_DeBuffButton4DeBuffBorder:SetPoint("RIGHT", "$parent", "RIGHT", 29, 0);						
					m_DeBuffButton4:SetPoint("TOPLEFT", "m_DeBuffButton3", "TOPLEFT", 0, -33);
					--m_DeBuffButton4Icon:SetPoint("TOPLEFT", "$parent", "TOPRIGHT", anchorx1, anchory1);					
					--m_DeBuffButton4DeBuffBorder:SetPoint("TOPLEFT", "$parent", "TOPRIGHT", -3, -2);

					m_DeBuffButton5:ClearAllPoints();
					m_DeBuffButton5Icon:ClearAllPoints();
					m_DeBuffButton5DeBuffBorder:ClearAllPoints();			
					m_DeBuffButton5:SetWidth(155);
					m_DeBuffButton5:SetHeight(36);
					m_DeBuffButton5Icon:SetPoint("RIGHT", "$parent", "RIGHT", 28, 0);
					m_DeBuffButton5DeBuffBorder:SetPoint("RIGHT", "$parent", "RIGHT", 29, 0);						
					m_DeBuffButton5:SetPoint("TOPLEFT", "m_DeBuffButton4", "TOPLEFT", 0, -33);
					--m_DeBuffButton5Icon:SetPoint("TOPLEFT", "$parent", "TOPRIGHT", anchorx1, anchory1);					
					--m_DeBuffButton5DeBuffBorder:SetPoint("TOPLEFT", "$parent", "TOPRIGHT", -3, -2);

					m_DeBuffButton6:ClearAllPoints();
					m_DeBuffButton6Icon:ClearAllPoints();
					m_DeBuffButton6DeBuffBorder:ClearAllPoints();			
					m_DeBuffButton6:SetWidth(155);
					m_DeBuffButton6:SetHeight(36);
					m_DeBuffButton6Icon:SetPoint("RIGHT", "$parent", "RIGHT", 28, 0);
					m_DeBuffButton6DeBuffBorder:SetPoint("RIGHT", "$parent", "RIGHT", 29, 0);						
					m_DeBuffButton6:SetPoint("TOPLEFT", "m_DeBuffButton5", "TOPLEFT", 0, -33);
					--m_DeBuffButton6Icon:SetPoint("TOPLEFT", "$parent", "TOPRIGHT", anchorx1, anchory1);					
					--m_DeBuffButton6DeBuffBorder:SetPoint("TOPLEFT", "$parent", "TOPRIGHT", -3, -2);

					m_DeBuffButton7:ClearAllPoints();
					m_DeBuffButton7Icon:ClearAllPoints();
					m_DeBuffButton7DeBuffBorder:ClearAllPoints();			
					m_DeBuffButton7:SetWidth(155);
					m_DeBuffButton7:SetHeight(36);
					m_DeBuffButton7Icon:SetPoint("RIGHT", "$parent", "RIGHT", 28, 0);
					m_DeBuffButton7DeBuffBorder:SetPoint("RIGHT", "$parent", "RIGHT", 29, 0);	
					m_DeBuffButton7:SetPoint("TOPLEFT", "m_DeBuffButton6", "TOPLEFT", 0, -33);
					--m_DeBuffButton7Icon:SetPoint("TOPLEFT", "$parent", "TOPRIGHT", anchorx1, anchory1);					
					--m_DeBuffButton7DeBuffBorder:SetPoint("TOPLEFT", "$parent", "TOPRIGHT", -3, -2);

					m_DeBuffButton8:ClearAllPoints();
					m_DeBuffButton8Icon:ClearAllPoints();
					m_DeBuffButton8DeBuffBorder:ClearAllPoints();			
					m_DeBuffButton8:SetWidth(155);
					m_DeBuffButton8:SetHeight(36);
					m_DeBuffButton8Icon:SetPoint("RIGHT", "$parent", "RIGHT", 28, 0);
					m_DeBuffButton8DeBuffBorder:SetPoint("RIGHT", "$parent", "RIGHT", 29, 0);						
					m_DeBuffButton8:SetPoint("TOPLEFT", "m_DeBuffButton7", "TOPLEFT", 0, -33);
					--m_DeBuffButton8Icon:SetPoint("TOPLEFT", "$parent", "TOPRIGHT", anchorx1, anchory1);					
					--m_DeBuffButton8DeBuffBorder:SetPoint("TOPLEFT", "$parent", "TOPRIGHT", -3, -2);
        end
			end
    elseif (m_doptions.size == 0) then
    --small debuffs
    	if (m_doptions.displaymode > 3 and m_doptions.displaymode < 6) then
    	-----------------------------
    	--8 rows scrolling down or up
    	-----------------------------
				if (m_doptions.downup == "DOWN") then
 				----------------------------
				-- SCROLL DEBUFFS DOWNWARDS --
				----------------------------
					anchorx = -2;
					anchory = -28;
					paddingv = -28;
					paddingh = 0;
					m_DeBuffFrame:ClearAllPoints();
					m_DeBuffButton1:ClearAllPoints();
					m_DeBuffButton1Icon:ClearAllPoints();
					m_DeBuffButton1DeBuffBorder:ClearAllPoints();			
					m_DeBuffButton1:SetWidth(40);
					m_DeBuffButton1:SetHeight(20);
					m_DeBuffButton1Icon:SetPoint("TOP", "$parent", "TOP", 0, 28);
					m_DeBuffButton1DeBuffBorder:SetPoint("TOP", "$parent", "TOP", 0, 29);
					m_DeBuffButton1:SetPoint("TOPLEFT", "m_DeBuffFrameCapsule", "TOPLEFT", anchorx, anchory);

					m_DeBuffFrame:ClearAllPoints();
					m_DeBuffButton2:ClearAllPoints();
					m_DeBuffButton2Icon:ClearAllPoints();
					m_DeBuffButton2DeBuffBorder:ClearAllPoints();			
					m_DeBuffButton2:SetWidth(40);
					m_DeBuffButton2:SetHeight(20);
					m_DeBuffButton2Icon:SetPoint("TOP", "$parent", "TOP", 0, 28);
					m_DeBuffButton2DeBuffBorder:SetPoint("TOP", "$parent", "TOP", 0, 29);					
					m_DeBuffButton2:SetPoint("TOPLEFT", "m_DeBuffButton1", "BOTTOMLEFT", 0, paddingv);

					m_DeBuffFrame:ClearAllPoints();
					m_DeBuffButton3:ClearAllPoints();
					m_DeBuffButton3Icon:ClearAllPoints();
					m_DeBuffButton3DeBuffBorder:ClearAllPoints();			
					m_DeBuffButton3:SetWidth(40);
					m_DeBuffButton3:SetHeight(20);
					m_DeBuffButton3Icon:SetPoint("TOP", "$parent", "TOP", 0, 28);
					m_DeBuffButton3DeBuffBorder:SetPoint("TOP", "$parent", "TOP", 0, 29);						
					m_DeBuffButton3:SetPoint("TOPLEFT", "m_DeBuffButton2", "BOTTOMLEFT", 0, paddingv);
					
					
					m_DeBuffFrame:ClearAllPoints();
					m_DeBuffButton4:ClearAllPoints();
					m_DeBuffButton4Icon:ClearAllPoints();
					m_DeBuffButton4DeBuffBorder:ClearAllPoints();			
					m_DeBuffButton4:SetWidth(40);
					m_DeBuffButton4:SetHeight(20);
					m_DeBuffButton4Icon:SetPoint("TOP", "$parent", "TOP", 0, 28);
					m_DeBuffButton4DeBuffBorder:SetPoint("TOP", "$parent", "TOP", 0, 29);					
					m_DeBuffButton4:SetPoint("TOPLEFT", "m_DeBuffButton3", "BOTTOMLEFT", 0, paddingv);
					
					m_DeBuffFrame:ClearAllPoints();
					m_DeBuffButton5:ClearAllPoints();
					m_DeBuffButton5Icon:ClearAllPoints();
					m_DeBuffButton5DeBuffBorder:ClearAllPoints();			
					m_DeBuffButton5:SetWidth(40);
					m_DeBuffButton5:SetHeight(20);
					m_DeBuffButton5Icon:SetPoint("TOP", "$parent", "TOP", 0, 28);
					m_DeBuffButton5DeBuffBorder:SetPoint("TOP", "$parent", "TOP", 0, 29);						
					m_DeBuffButton5:SetPoint("TOPLEFT", "m_DeBuffButton4", "BOTTOMLEFT", 0, paddingv);
					
					
					m_DeBuffFrame:ClearAllPoints();
					m_DeBuffButton6:ClearAllPoints();
					m_DeBuffButton6Icon:ClearAllPoints();
					m_DeBuffButton6DeBuffBorder:ClearAllPoints();			
					m_DeBuffButton6:SetWidth(40);
					m_DeBuffButton6:SetHeight(20);
					m_DeBuffButton6Icon:SetPoint("TOP", "$parent", "TOP", 0, 28);
					m_DeBuffButton6DeBuffBorder:SetPoint("TOP", "$parent", "TOP", 0, 29);						
					m_DeBuffButton6:SetPoint("TOPLEFT", "m_DeBuffButton5", "BOTTOMLEFT", 0, paddingv);
					
					
					m_DeBuffFrame:ClearAllPoints();
					m_DeBuffButton7:ClearAllPoints();
					m_DeBuffButton7Icon:ClearAllPoints();
					m_DeBuffButton7DeBuffBorder:ClearAllPoints();			
					m_DeBuffButton7:SetWidth(40);
					m_DeBuffButton7:SetHeight(20);
					m_DeBuffButton7Icon:SetPoint("TOP", "$parent", "TOP", 0, 28);
					m_DeBuffButton7DeBuffBorder:SetPoint("TOP", "$parent", "TOP", 0, 29);						
					m_DeBuffButton7:SetPoint("TOPLEFT", "m_DeBuffButton6", "BOTTOMLEFT", 0, paddingv);
					
					m_DeBuffFrame:ClearAllPoints();
					m_DeBuffButton8:ClearAllPoints();
					m_DeBuffButton8Icon:ClearAllPoints();
					m_DeBuffButton8DeBuffBorder:ClearAllPoints();			
					m_DeBuffButton8:SetWidth(40);
					m_DeBuffButton8:SetHeight(20); 
					m_DeBuffButton8Icon:SetPoint("TOP", "$parent", "TOP", 0, 28);
					m_DeBuffButton8DeBuffBorder:SetPoint("TOP", "$parent", "TOP", 0, 29);						
					m_DeBuffButton8:SetPoint("TOPLEFT", "m_DeBuffButton7", "BOTTOMLEFT", 0, paddingv);
				elseif (m_doptions.downup == "UP") then
				--------------------------
				-- SCROLL DEBUFFS UPWARDS --
				--------------------------
					anchorx = -2;
					anchorx2 = 37;
					anchory	= -364;
					paddingv = 48;
					paddingh = 0;
					m_DeBuffFrame:ClearAllPoints();
					m_DeBuffFrame:ClearAllPoints();
					m_DeBuffButton1:ClearAllPoints();
					m_DeBuffButton1Icon:ClearAllPoints();
					m_DeBuffButton1DeBuffBorder:ClearAllPoints();			
					m_DeBuffButton1:SetWidth(40);
					m_DeBuffButton1:SetHeight(20);
					m_DeBuffButton1Icon:SetPoint("TOP", "$parent", "TOP", 0, 28);
					m_DeBuffButton1DeBuffBorder:SetPoint("TOP", "$parent", "TOP", 0, 29);					
					m_DeBuffButton1:SetPoint("TOPLEFT", "m_DeBuffFrameCapsule", "TOPLEFT", anchorx, anchory);
					
					m_DeBuffFrame:ClearAllPoints();
					m_DeBuffButton2:ClearAllPoints();
					m_DeBuffButton2Icon:ClearAllPoints();
					m_DeBuffButton2DeBuffBorder:ClearAllPoints();			
					m_DeBuffButton2:SetWidth(40);
					m_DeBuffButton2:SetHeight(20);
					m_DeBuffButton2Icon:SetPoint("TOP", "$parent", "TOP", 0, 28);
					m_DeBuffButton2DeBuffBorder:SetPoint("TOP", "$parent", "TOP", 0, 29);					
					m_DeBuffButton2:SetPoint("TOPLEFT", "m_DeBuffButton1", "TOPLEFT", 0, paddingv);
					
					
					m_DeBuffFrame:ClearAllPoints();
					m_DeBuffButton3:ClearAllPoints();
					m_DeBuffButton3Icon:ClearAllPoints();
					m_DeBuffButton3DeBuffBorder:ClearAllPoints();			
					m_DeBuffButton3:SetWidth(40);
					m_DeBuffButton3:SetHeight(20);
					m_DeBuffButton3Icon:SetPoint("TOP", "$parent", "TOP", 0, 28);
					m_DeBuffButton3DeBuffBorder:SetPoint("TOP", "$parent", "TOP", 0, 29);					
					m_DeBuffButton3:SetPoint("TOPLEFT", "m_DeBuffButton2", "TOPLEFT", 0, paddingv);
					
					m_DeBuffFrame:ClearAllPoints();
					m_DeBuffButton4:ClearAllPoints();
					m_DeBuffButton4Icon:ClearAllPoints();
					m_DeBuffButton4DeBuffBorder:ClearAllPoints();			
					m_DeBuffButton4:SetWidth(40);
					m_DeBuffButton4:SetHeight(20);
					m_DeBuffButton4Icon:SetPoint("TOP", "$parent", "TOP", 0, 28);
					m_DeBuffButton4DeBuffBorder:SetPoint("TOP", "$parent", "TOP", 0, 29);					
					m_DeBuffButton4:SetPoint("TOPLEFT", "m_DeBuffButton3", "TOPLEFT", 0, paddingv);
					
					m_DeBuffFrame:ClearAllPoints();
					m_DeBuffButton5:ClearAllPoints();
					m_DeBuffButton5Icon:ClearAllPoints();
					m_DeBuffButton5DeBuffBorder:ClearAllPoints();			
					m_DeBuffButton5:SetWidth(40);
					m_DeBuffButton5:SetHeight(20);
					m_DeBuffButton5Icon:SetPoint("TOP", "$parent", "TOP", 0, 28);
					m_DeBuffButton5DeBuffBorder:SetPoint("TOP", "$parent", "TOP", 0, 29);					
					m_DeBuffButton5:SetPoint("TOPLEFT", "m_DeBuffButton4", "TOPLEFT", 0, paddingv);
					
					m_DeBuffFrame:ClearAllPoints();
					m_DeBuffButton6:ClearAllPoints();
					m_DeBuffButton6Icon:ClearAllPoints();
					m_DeBuffButton6DeBuffBorder:ClearAllPoints();			
					m_DeBuffButton6:SetWidth(40);
					m_DeBuffButton6:SetHeight(20);
					m_DeBuffButton6Icon:SetPoint("TOP", "$parent", "TOP", 0, 28);
					m_DeBuffButton6DeBuffBorder:SetPoint("TOP", "$parent", "TOP", 0, 29);					
					m_DeBuffButton6:SetPoint("TOPLEFT", "m_DeBuffButton5", "TOPLEFT", 0, paddingv);
					
					
					m_DeBuffFrame:ClearAllPoints();
					m_DeBuffButton7:ClearAllPoints();
					m_DeBuffButton7Icon:ClearAllPoints();
					m_DeBuffButton7DeBuffBorder:ClearAllPoints();			
					m_DeBuffButton7:SetWidth(40);
					m_DeBuffButton7:SetHeight(20);
					m_DeBuffButton7Icon:SetPoint("TOP", "$parent", "TOP", 0, 28);
					m_DeBuffButton7DeBuffBorder:SetPoint("TOP", "$parent", "TOP", 0, 29);					
					m_DeBuffButton7:SetPoint("TOPLEFT", "m_DeBuffButton6", "TOPLEFT", 0, paddingv);
					
					m_DeBuffFrame:ClearAllPoints();
					m_DeBuffButton8:ClearAllPoints();
					m_DeBuffButton8Icon:ClearAllPoints();
					m_DeBuffButton8DeBuffBorder:ClearAllPoints();			
					m_DeBuffButton8:SetWidth(40);
					m_DeBuffButton8:SetHeight(20);
					m_DeBuffButton8Icon:SetPoint("TOP", "$parent", "TOP", 0, 28);
					m_DeBuffButton8DeBuffBorder:SetPoint("TOP", "$parent", "TOP", 0, 29);					
					m_DeBuffButton8:SetPoint("TOPLEFT", "m_DeBuffButton7", "TOPLEFT", 0, paddingv);
			
				end
				
			elseif (m_doptions.displaymode > 5 and m_doptions.displaymode < 8) then
			--1 ROW, 8 COLUMNS, LEFT TO RIGHT OR RIGHT TO LEFT
				if (m_doptions.rightleft == 1) then
				-- left to right
					anchorx = -2;
					anchorx2 = 0;
					anchory	= -28;
					anchory2 = -28;
					
					m_DeBuffFrame:ClearAllPoints();
					m_DeBuffButton1:ClearAllPoints();
					m_DeBuffButton1Icon:ClearAllPoints();
					m_DeBuffButton1DeBuffBorder:ClearAllPoints();			
					m_DeBuffButton1:SetWidth(40);
					m_DeBuffButton1:SetHeight(20);
					m_DeBuffButton1Icon:SetPoint("TOP", "$parent", "TOP", 0, 28);
					m_DeBuffButton1DeBuffBorder:SetPoint("TOP", "$parent", "TOP", 0, 29);	
					m_DeBuffButton1:SetPoint("TOPLEFT", "m_DeBuffFrameCapsule", "TOPLEFT", anchorx, anchory);
					

					m_DeBuffButton2:ClearAllPoints();
					m_DeBuffButton2Icon:ClearAllPoints();
					m_DeBuffButton2DeBuffBorder:ClearAllPoints();			
					m_DeBuffButton2:SetWidth(40);
					m_DeBuffButton2:SetHeight(20);
					m_DeBuffButton2Icon:SetPoint("TOP", "$parent", "TOP", 0, 28);
					m_DeBuffButton2DeBuffBorder:SetPoint("TOP", "$parent", "TOP", 0, 29);	
					m_DeBuffButton2:SetPoint("TOPLEFT", "m_DeBuffButton1", "TOPRIGHT", anchorx, 0);
					
					m_DeBuffButton3:ClearAllPoints();
					m_DeBuffButton3Icon:ClearAllPoints();
					m_DeBuffButton3DeBuffBorder:ClearAllPoints();			
					m_DeBuffButton3:SetWidth(40);
					m_DeBuffButton3:SetHeight(20);
					m_DeBuffButton3Icon:SetPoint("TOP", "$parent", "TOP", 0, 28);
					m_DeBuffButton3DeBuffBorder:SetPoint("TOP", "$parent", "TOP", 0, 29);						
					m_DeBuffButton3:SetPoint("TOPLEFT", "m_DeBuffButton2", "TOPRIGHT", anchorx, 0);
					
					
					m_DeBuffButton4:ClearAllPoints();
					m_DeBuffButton4Icon:ClearAllPoints();
					m_DeBuffButton4DeBuffBorder:ClearAllPoints();			
					m_DeBuffButton4:SetWidth(40);
					m_DeBuffButton4:SetHeight(20);
					m_DeBuffButton4Icon:SetPoint("TOP", "$parent", "TOP", 0, 28);
					m_DeBuffButton4DeBuffBorder:SetPoint("TOP", "$parent", "TOP", 0, 29);						
					m_DeBuffButton4:SetPoint("TOPLEFT", "m_DeBuffButton3", "TOPRIGHT", anchorx, 0);
					
					
					m_DeBuffButton5:ClearAllPoints();
					m_DeBuffButton5Icon:ClearAllPoints();
					m_DeBuffButton5DeBuffBorder:ClearAllPoints();			
					m_DeBuffButton5:SetWidth(40);
					m_DeBuffButton5:SetHeight(20);
					m_DeBuffButton5Icon:SetPoint("TOP", "$parent", "TOP", 0, 28);
					m_DeBuffButton5DeBuffBorder:SetPoint("TOP", "$parent", "TOP", 0, 29);						
					m_DeBuffButton5:SetPoint("TOPLEFT", "m_DeBuffButton4", "TOPRIGHT", anchorx, 0);
					
					m_DeBuffButton6:ClearAllPoints();
					m_DeBuffButton6Icon:ClearAllPoints();
					m_DeBuffButton6DeBuffBorder:ClearAllPoints();			
					m_DeBuffButton6:SetWidth(40);
					m_DeBuffButton6:SetHeight(20);
					m_DeBuffButton6Icon:SetPoint("TOP", "$parent", "TOP", 0, 28);
					m_DeBuffButton6DeBuffBorder:SetPoint("TOP", "$parent", "TOP", 0, 29);						
					m_DeBuffButton6:SetPoint("TOPLEFT", "m_DeBuffButton5", "TOPRIGHT", anchorx, 0);
					
					m_DeBuffButton7:ClearAllPoints();
					m_DeBuffButton7Icon:ClearAllPoints();
					m_DeBuffButton7DeBuffBorder:ClearAllPoints();			
					m_DeBuffButton7:SetWidth(40);
					m_DeBuffButton7:SetHeight(20);
					m_DeBuffButton7Icon:SetPoint("TOP", "$parent", "TOP", 0, 28);
					m_DeBuffButton7DeBuffBorder:SetPoint("TOP", "$parent", "TOP", 0, 29);						
					m_DeBuffButton7:SetPoint("TOPLEFT", "m_DeBuffButton6", "TOPRIGHT", anchorx, 0);
					
					
					m_DeBuffButton8:ClearAllPoints();
					m_DeBuffButton8Icon:ClearAllPoints();
					m_DeBuffButton8DeBuffBorder:ClearAllPoints();			
					m_DeBuffButton8:SetWidth(40);
					m_DeBuffButton8:SetHeight(20);
					m_DeBuffButton8Icon:SetPoint("TOP", "$parent", "TOP", 0, 28);
					m_DeBuffButton8DeBuffBorder:SetPoint("TOP", "$parent", "TOP", 0, 29);						
					m_DeBuffButton8:SetPoint("TOPLEFT", "m_DeBuffButton7", "TOPRIGHT", anchorx, 0);
						
				elseif (m_doptions.rightleft == 0) then
				
          anchorx = -38;
					anchorx2 = 0;
					anchory	= -28;
					anchory2 = -28;
					m_DeBuffFrame:ClearAllPoints();
					m_DeBuffButton1:ClearAllPoints();
					m_DeBuffButton1Icon:ClearAllPoints();
					m_DeBuffButton1DeBuffBorder:ClearAllPoints();			
					m_DeBuffButton1:SetWidth(40);
					m_DeBuffButton1:SetHeight(20);
					m_DeBuffButton1Icon:SetPoint("TOP", "$parent", "TOP", 0, 28);
					m_DeBuffButton1DeBuffBorder:SetPoint("TOP", "$parent", "TOP", 0, 29);					
					m_DeBuffButton1:SetPoint("TOPLEFT", "m_DeBuffFrameCapsule", "TOPRIGHT", anchorx, anchory);

					m_DeBuffButton2:ClearAllPoints();
					m_DeBuffButton2Icon:ClearAllPoints();
					m_DeBuffButton2DeBuffBorder:ClearAllPoints();			
					m_DeBuffButton2:SetWidth(40);
					m_DeBuffButton2:SetHeight(20);
					m_DeBuffButton2Icon:SetPoint("TOP", "$parent", "TOP", 0, 28);
					m_DeBuffButton2DeBuffBorder:SetPoint("TOP", "$parent", "TOP", 0, 29);
					m_DeBuffButton2:SetPoint("TOPLEFT", "m_DeBuffButton1", "TOPLEFT", anchorx, 0);
					
					m_DeBuffButton3:ClearAllPoints();
					m_DeBuffButton3Icon:ClearAllPoints();
					m_DeBuffButton3DeBuffBorder:ClearAllPoints();			
					m_DeBuffButton3:SetWidth(40);
					m_DeBuffButton3:SetHeight(20);
					m_DeBuffButton3Icon:SetPoint("TOP", "$parent", "TOP", 0, 28);
					m_DeBuffButton3DeBuffBorder:SetPoint("TOP", "$parent", "TOP", 0, 29);				
					m_DeBuffButton3:SetPoint("TOPLEFT", "m_DeBuffButton2", "TOPLEFT", anchorx, 0);
					
					m_DeBuffButton4:ClearAllPoints();
					m_DeBuffButton4Icon:ClearAllPoints();
					m_DeBuffButton4DeBuffBorder:ClearAllPoints();			
					m_DeBuffButton4:SetWidth(40);
					m_DeBuffButton4:SetHeight(20);
					m_DeBuffButton4Icon:SetPoint("TOP", "$parent", "TOP", 0, 28);
					m_DeBuffButton4DeBuffBorder:SetPoint("TOP", "$parent", "TOP", 0, 29);				
					m_DeBuffButton4:SetPoint("TOPLEFT", "m_DeBuffButton3", "TOPLEFT", anchorx, 0);
					
					m_DeBuffButton5:ClearAllPoints();
					m_DeBuffButton5Icon:ClearAllPoints();
					m_DeBuffButton5DeBuffBorder:ClearAllPoints();			
					m_DeBuffButton5:SetWidth(40);
					m_DeBuffButton5:SetHeight(20);
					m_DeBuffButton5Icon:SetPoint("TOP", "$parent", "TOP", 0, 28);
					m_DeBuffButton5DeBuffBorder:SetPoint("TOP", "$parent", "TOP", 0, 29);				
					m_DeBuffButton5:SetPoint("TOPLEFT", "m_DeBuffButton4", "TOPLEFT", anchorx, 0);
					
					m_DeBuffButton6:ClearAllPoints();
					m_DeBuffButton6Icon:ClearAllPoints();
					m_DeBuffButton6DeBuffBorder:ClearAllPoints();			
					m_DeBuffButton6:SetWidth(40);
					m_DeBuffButton6:SetHeight(20);
					m_DeBuffButton6Icon:SetPoint("TOP", "$parent", "TOP", 0, 28);
					m_DeBuffButton6DeBuffBorder:SetPoint("TOP", "$parent", "TOP", 0, 29);
					m_DeBuffButton6:SetPoint("TOPLEFT", "m_DeBuffButton5", "TOPLEFT", anchorx, 0);
					
					m_DeBuffButton7:ClearAllPoints();
					m_DeBuffButton7Icon:ClearAllPoints();
					m_DeBuffButton7DeBuffBorder:ClearAllPoints();			
					m_DeBuffButton7:SetWidth(40);
					m_DeBuffButton7:SetHeight(20);
					m_DeBuffButton7Icon:SetPoint("TOP", "$parent", "TOP", 0, 28);
					m_DeBuffButton7DeBuffBorder:SetPoint("TOP", "$parent", "TOP", 0, 29);	
					m_DeBuffButton7:SetPoint("TOPLEFT", "m_DeBuffButton6", "TOPLEFT", anchorx, 0);
					
					m_DeBuffButton8:ClearAllPoints();
					m_DeBuffButton8Icon:ClearAllPoints();
					m_DeBuffButton8DeBuffBorder:ClearAllPoints();			
					m_DeBuffButton8:SetWidth(40);
					m_DeBuffButton8:SetHeight(20);
					m_DeBuffButton8Icon:SetPoint("TOP", "$parent", "TOP", 0, 28);
					m_DeBuffButton8DeBuffBorder:SetPoint("TOP", "$parent", "TOP", 0, 29);	
					m_DeBuffButton8:SetPoint("TOPLEFT", "m_DeBuffButton7", "TOPLEFT", anchorx, 0);				
				
				end
			
    	end
    end
    
    
	------------------
	-- WEAPON BUFFS --
	------------------
	if (m_woptions.displaymode == 0) then
        
		m_WepBuffFrame:ClearAllPoints();
		m_WepBuffButton1:ClearAllPoints();
		m_WepBuffButton1Icon:ClearAllPoints();
		m_WepBuffButton1Border:ClearAllPoints();			
		m_WepBuffButton1:SetWidth(40);
		m_WepBuffButton1:SetHeight(20);
		m_WepBuffButton2:ClearAllPoints();
		m_WepBuffButton2Icon:ClearAllPoints();
		m_WepBuffButton2Border:ClearAllPoints();			
		m_WepBuffButton2:SetWidth(40);
		m_WepBuffButton2:SetHeight(20);

		m_WepBuffButton1Icon:SetPoint("TOP", "$parent", "TOP", 0, 28);
		m_WepBuffButton1Border:SetPoint("TOP", "$parent", "TOP", 0, 29);			
		m_WepBuffButton1:SetPoint("TOPLEFT", "m_WepBuffFrameCapsule", "TOPLEFT", -2, -28);
		m_WepBuffButton1Duration:SetPoint("CENTER", "$parent", "BOTTOM", 0, 10);
		
		m_WepBuffButton2Icon:SetPoint("TOP", "$parent", "TOP", 0, 28);
		m_WepBuffButton2Border:SetPoint("TOP", "$parent", "TOP", 0, 29);			
		m_WepBuffButton2:SetPoint("TOPLEFT", "m_WepBuffButton1", "BOTTOMLEFT", 0, -28);
		m_WepBuffButton2Duration:SetPoint("CENTER", "$parent", "BOTTOM", 0, 10);
		        
	elseif (m_woptions.displaymode == 1) then        

		m_WepBuffFrame:ClearAllPoints();
		m_WepBuffButton1:ClearAllPoints();
		m_WepBuffButton1Icon:ClearAllPoints();
		m_WepBuffButton1Border:ClearAllPoints();			
		m_WepBuffButton1:SetWidth(40);
		m_WepBuffButton1:SetHeight(20);
		m_WepBuffButton2:ClearAllPoints();
		m_WepBuffButton2Icon:ClearAllPoints();
		m_WepBuffButton2Border:ClearAllPoints();			
		m_WepBuffButton2:SetWidth(40);
		m_WepBuffButton2:SetHeight(20);

		m_WepBuffButton1Icon:SetPoint("TOP", "$parent", "TOP", 0, 28);
		m_WepBuffButton1Border:SetPoint("TOP", "$parent", "TOP", 0, 29);			
		m_WepBuffButton1:SetPoint("TOPLEFT", "m_WepBuffFrameCapsule", "TOPLEFT", -2, -76);
		m_WepBuffButton1Duration:SetPoint("CENTER", "$parent", "BOTTOM", 0, 10);
		
		m_WepBuffButton2Icon:SetPoint("TOP", "$parent", "TOP", 0, 28);
		m_WepBuffButton2Border:SetPoint("TOP", "$parent", "TOP", 0, 29);			
		m_WepBuffButton2:SetPoint("TOPLEFT", "m_WepBuffButton1", "TOPLEFT", 0, 48);
		m_WepBuffButton2Duration:SetPoint("CENTER", "$parent", "BOTTOM", 0, 10);
		        
	elseif (m_woptions.displaymode == 2) then
        
		m_WepBuffFrame:ClearAllPoints();
		m_WepBuffButton1:ClearAllPoints();
		m_WepBuffButton1Icon:ClearAllPoints();
		m_WepBuffButton1Border:ClearAllPoints();			
		m_WepBuffButton1:SetWidth(40);
		m_WepBuffButton1:SetHeight(20);
		m_WepBuffButton2:ClearAllPoints();
		m_WepBuffButton2Icon:ClearAllPoints();
		m_WepBuffButton2Border:ClearAllPoints();			
		m_WepBuffButton2:SetWidth(40);
		m_WepBuffButton2:SetHeight(20);

		m_WepBuffButton1Icon:SetPoint("TOP", "$parent", "TOP", 0, 28);
		m_WepBuffButton1Border:SetPoint("TOP", "$parent", "TOP", 0, 29);		
		m_WepBuffButton1:SetPoint("TOPLEFT", "m_WepBuffFrameCapsule", "TOPLEFT", -2, -28);
		m_WepBuffButton1Duration:SetPoint("CENTER", "$parent", "BOTTOM", 0, 10);

		m_WepBuffButton2Icon:SetPoint("TOP", "$parent", "TOP", 0, 28);
		m_WepBuffButton2Border:SetPoint("TOP", "$parent", "TOP", 0, 29);			
		m_WepBuffButton2:SetPoint("TOPLEFT", "m_WepBuffButton1", "TOPRIGHT", -2, 0);
		m_WepBuffButton2Duration:SetPoint("CENTER", "$parent", "BOTTOM", 0, 10);
		        
	elseif (m_woptions.displaymode == 3) then
        
		m_WepBuffFrame:ClearAllPoints();
		m_WepBuffButton1:ClearAllPoints();
		m_WepBuffButton1Icon:ClearAllPoints();
		m_WepBuffButton1Border:ClearAllPoints();			
		m_WepBuffButton1:SetWidth(40);
		m_WepBuffButton1:SetHeight(20);
		m_WepBuffButton2:ClearAllPoints();
		m_WepBuffButton2Icon:ClearAllPoints();
		m_WepBuffButton2Border:ClearAllPoints();			
		m_WepBuffButton2:SetWidth(40);
		m_WepBuffButton2:SetHeight(20);
		
		m_WepBuffButton1Icon:SetPoint("TOP", "$parent", "TOP", 0, 28);
		m_WepBuffButton1Border:SetPoint("TOP", "$parent", "TOP", 0, 29);	
		m_WepBuffButton1:SetPoint("TOPLEFT", "m_WepBuffFrameCapsule", "TOPLEFT", 36, -28);
		m_WepBuffButton1Duration:SetPoint("CENTER", "$parent", "BOTTOM", 0, 10);
				
		m_WepBuffButton2Icon:SetPoint("TOP", "$parent", "TOP", 0, 28);
		m_WepBuffButton2Border:SetPoint("TOP", "$parent", "TOP", 0, 29);		
		m_WepBuffButton2:SetPoint("TOPLEFT", "m_WepBuffButton1", "TOPLEFT", -38, 0);
		m_WepBuffButton2Duration:SetPoint("CENTER", "$parent", "BOTTOM", 0, 10);
		
	elseif (m_woptions.displaymode == 4) then
	
		m_WepBuffFrame:ClearAllPoints();
		m_WepBuffButton1:ClearAllPoints();
		m_WepBuffButton1Icon:ClearAllPoints();
		m_WepBuffButton1Border:ClearAllPoints();			
		m_WepBuffButton1:SetWidth(155);
		m_WepBuffButton1:SetHeight(36);
		m_WepBuffButton2:ClearAllPoints();
		m_WepBuffButton2Icon:ClearAllPoints();
		m_WepBuffButton2Border:ClearAllPoints();			
		m_WepBuffButton2:SetWidth(155);
		m_WepBuffButton2:SetHeight(36);

		m_WepBuffButton1Icon:SetPoint("LEFT", "$parent", "LEFT", -28, 0);
		m_WepBuffButton1Border:SetPoint("LEFT", "$parent", "LEFT", -29, 0);			
		m_WepBuffButton1:SetPoint("TOPLEFT", "m_WepBuffFrameCapsule", "TOPLEFT", 28, 2);
		m_WepBuffButton1Duration:SetPoint("CENTER", "$parent", "BOTTOM", 0, 12);
		
		m_WepBuffButton2Icon:SetPoint("LEFT", "$parent", "LEFT", -28, 0);
		m_WepBuffButton2Border:SetPoint("LEFT", "$parent", "LEFT", -29, 0);			
		m_WepBuffButton2:SetPoint("TOPLEFT", "m_WepBuffButton1", "BOTTOMLEFT", 0, 3);	
		m_WepBuffButton2Duration:SetPoint("CENTER", "$parent", "BOTTOM", 0, 12);
		
	elseif (m_woptions.displaymode == 5) then
	
		m_WepBuffFrame:ClearAllPoints();
		m_WepBuffButton1:ClearAllPoints();
		m_WepBuffButton1Icon:ClearAllPoints();
		m_WepBuffButton1Border:ClearAllPoints();			
		m_WepBuffButton1:SetWidth(155);
		m_WepBuffButton1:SetHeight(36);
		m_WepBuffButton2:ClearAllPoints();
		m_WepBuffButton2Icon:ClearAllPoints();
		m_WepBuffButton2Border:ClearAllPoints();			
		m_WepBuffButton2:SetWidth(155);
		m_WepBuffButton2:SetHeight(36);
		
		m_WepBuffButton1Icon:SetPoint("LEFT", "$parent", "LEFT", -28, 0);
		m_WepBuffButton1Border:SetPoint("LEFT", "$parent", "LEFT", -29, 0);				
		m_WepBuffButton1:SetPoint("BOTTOMLEFT", "m_WepBuffFrameCapsule", "BOTTOMLEFT", 28, -3);
		m_WepBuffButton1Duration:SetPoint("CENTER", "$parent", "BOTTOM", 0, 12);

		m_WepBuffButton2Icon:SetPoint("LEFT", "$parent", "LEFT", -28, 0);
		m_WepBuffButton2Border:SetPoint("LEFT", "$parent", "LEFT", -29, 0);				
		m_WepBuffButton2:SetPoint("TOPLEFT", "m_WepBuffButton1", "TOPLEFT", 0, 33);
		m_WepBuffButton2Duration:SetPoint("CENTER", "$parent", "BOTTOM", 0, 12);
				
	elseif (m_woptions.displaymode == 6) then
	
		m_WepBuffFrame:ClearAllPoints();
		m_WepBuffButton1:ClearAllPoints();
		m_WepBuffButton1Icon:ClearAllPoints();
		m_WepBuffButton1Border:ClearAllPoints();			
		m_WepBuffButton1:SetWidth(155);
		m_WepBuffButton1:SetHeight(36);
		m_WepBuffButton2:ClearAllPoints();
		m_WepBuffButton2Icon:ClearAllPoints();
		m_WepBuffButton2Border:ClearAllPoints();			
		m_WepBuffButton2:SetWidth(155);
		m_WepBuffButton2:SetHeight(36);

		m_WepBuffButton1Icon:SetPoint("RIGHT", "$parent", "RIGHT", 28, 0);
		m_WepBuffButton1Border:SetPoint("RIGHT", "$parent", "RIGHT", 29, 0);			
		m_WepBuffButton1:SetPoint("TOPLEFT", "m_WepBuffFrameCapsule", "TOPLEFT", -2, 2);
		m_WepBuffButton1Duration:SetPoint("CENTER", "$parent", "BOTTOM", 0, 12);
		
		m_WepBuffButton2Icon:SetPoint("RIGHT", "$parent", "RIGHT", 28, 0);
		m_WepBuffButton2Border:SetPoint("RIGHT", "$parent", "RIGHT", 29, 0);			
		m_WepBuffButton2:SetPoint("TOPLEFT", "m_WepBuffButton1", "BOTTOMLEFT", 0, 3);	
		m_WepBuffButton2Duration:SetPoint("CENTER", "$parent", "BOTTOM", 0, 12);
	elseif (m_woptions.displaymode == 7) then
	
		m_WepBuffFrame:ClearAllPoints();
		m_WepBuffButton1:ClearAllPoints();
		m_WepBuffButton1Icon:ClearAllPoints();
		m_WepBuffButton1Border:ClearAllPoints();			
		m_WepBuffButton1:SetWidth(155);
		m_WepBuffButton1:SetHeight(36);
		m_WepBuffButton2:ClearAllPoints();
		m_WepBuffButton2Icon:ClearAllPoints();
		m_WepBuffButton2Border:ClearAllPoints();			
		m_WepBuffButton2:SetWidth(155);
		m_WepBuffButton2:SetHeight(36);
		
		m_WepBuffButton1Icon:SetPoint("RIGHT", "$parent", "RIGHT", 28, 0);
		m_WepBuffButton1Border:SetPoint("RIGHT", "$parent", "RIGHT", 29, 0);			
		m_WepBuffButton1:SetPoint("BOTTOMLEFT", "m_WepBuffFrameCapsule", "BOTTOMLEFT", -2, -3);
		m_WepBuffButton1Duration:SetPoint("CENTER", "$parent", "BOTTOM", 0, 12);
		
		m_WepBuffButton2Icon:SetPoint("RIGHT", "$parent", "RIGHT", 28, 0);
		m_WepBuffButton2Border:SetPoint("RIGHT", "$parent", "RIGHT", 29, 0);			
		m_WepBuffButton2:SetPoint("TOPLEFT", "m_WepBuffButton1", "TOPLEFT", 0, 33);
		m_WepBuffButton2Duration:SetPoint("CENTER", "$parent", "BOTTOM", 0, 12);				
	end
	
end


----------------------------------------------
----------------------------------------------
----------------------------------------------
function m_changedisplaymode(wtf)
    if (wtf == "ADD") then
        m_boptions.displaymode = m_boptions.displaymode + 1;
        if (m_boptions.displaymode > 11) then m_boptions.displaymode = 0; end
    elseif (wtf == "SUBTRACT") then
        m_boptions.displaymode = m_boptions.displaymode - 1;
        if (m_boptions.displaymode < 0) then m_boptions.displaymode = 11; end  
    end

    if (m_boptions.displaymode == 0) then
        --2 columns, 8 rows,down, fill right column first
        m_boptions.downup = "DOWN";
        m_boptions.rightleft = 0;   
        m_optionsPanel5Panel1Label3Label:SetText("(0)  8 Rows, 2 Columns, Scroll Down, Right Column First");
    elseif (m_boptions.displaymode == 1) then
        --2 columns, 8 rows,up, fill left column first
        m_boptions.downup = "DOWN";
        m_boptions.rightleft = 1;
        m_optionsPanel5Panel1Label3Label:SetText("(1)  8 Rows, 2 Columns, Scroll Down, Left Column First");
    elseif (m_boptions.displaymode == 2) then
        --2 columns, 8 rows,up, fill left column first
        m_boptions.downup = "UP";
        m_boptions.rightleft = 1;
        m_optionsPanel5Panel1Label3Label:SetText("(2)  8 Rows, 2 Columns, Scroll Up, Left Column First");
    elseif (m_boptions.displaymode == 3) then
        --2 columns, 8 rows,up, fill right column first
        m_boptions.downup = "UP";
        m_boptions.rightleft = 0;
        m_optionsPanel5Panel1Label3Label:SetText("(3)  8 Rows, 2 Columns, Scroll Up, Right Column First");        
    elseif (m_boptions.displaymode == 4) then
        --2 rows, 8 columns,down, fill top left column/row first
        m_boptions.downup = "DOWN";
        m_boptions.rightleft = 1;
        m_optionsPanel5Panel1Label3Label:SetText("(4)  Rows, 8 Columns, Scroll Down, Top Left First");                 
    elseif (m_boptions.displaymode == 5) then
        --2 rows, 8 columns,down, fill top right column/row first
        m_boptions.downup = "DOWN";
        m_boptions.rightleft = 0;
        m_optionsPanel5Panel1Label3Label:SetText("(5)  2 Rows, 8 Columns, Scroll Down, Top Right First"); 
    elseif (m_boptions.displaymode == 6) then
        --2 rows, 8 columns,up, fill bottom left column/row first
        m_boptions.downup = "UP";
        m_boptions.rightleft = 1;
        m_optionsPanel5Panel1Label3Label:SetText("(6)  2 Rows, 8 Columns, Scroll Up, Bottom Left First");
    elseif (m_boptions.displaymode == 7) then
        --2 rows, 8 columns,up, fill bottom right column/row first
        m_boptions.downup = "UP";
        m_boptions.rightleft = 0;
        m_optionsPanel5Panel1Label3Label:SetText("(7)  2 Rows, 8 Columns, Scroll Up, Bottom Right First");
    elseif (m_boptions.displaymode == 8) then
        --16 rows, 1 column,Down, top to bottom
        m_boptions.downup = "DOWN";
        m_optionsPanel5Panel1Label3Label:SetText("(8)  16 Rows, 1 Column, Top to Bottom");
    elseif (m_boptions.displaymode == 9) then
        --16 rows, 1 column,up, bottom to top
        m_boptions.downup = "UP";
        m_optionsPanel5Panel1Label3Label:SetText("(9)  16 Rows, 1 Column, Bottom to Top");
    elseif (m_boptions.displaymode == 10) then
        --1 rows, 16 column,Left to right
        m_boptions.rightleft = 1;
        m_optionsPanel5Panel1Label3Label:SetText("(10)  1 Row, 16 Columns, Left to Right");
    elseif (m_boptions.displaymode == 11) then
        --1 rows, 16 column,right to left
        m_boptions.rightleft = 0;
        m_optionsPanel5Panel1Label3Label:SetText("(11)  1 Row, 16 Columns, Right to Left");
    end
    
    m_setbufflayout();
    m_sizebuffcapsule();
end

function m_changedebuffdisplaymode(wtf)
    if (wtf == "ADD") then
        m_doptions.displaymode = m_doptions.displaymode + 1;
        if (m_doptions.displaymode > 7) then m_doptions.displaymode = 0; end
    elseif (wtf == "SUBTRACT") then
        m_doptions.displaymode = m_doptions.displaymode - 1;
        if (m_doptions.displaymode < 0) then m_doptions.displaymode = 7; end  
    end
    
    --debuffs
    if (m_doptions.displaymode == 0) then
				m_doptions.size = 1;
        m_doptions.rightleft = 0;
        m_doptions.downup = "DOWN";
        m_doptions.icon_side = 0;
        m_optionsPanel5Panel1Component10Label:SetText("(0)  Large, 8 Rows, 1 Column, Icon on Left, Top to Bottom");
    elseif (m_doptions.displaymode == 1) then
    		m_doptions.size = 1;
        m_doptions.rightleft = 0;
        m_doptions.downup = "UP";
        m_doptions.icon_side = 0;
        m_optionsPanel5Panel1Component10Label:SetText("(1)  Large, 8 Rows, 1 Column, Icon on Left, Bottom to Top");        
    elseif (m_doptions.displaymode == 2) then
    		m_doptions.size = 1;    
        m_doptions.rightleft = 0;
        m_doptions.downup = "UP";
        m_doptions.icon_side = 1;
        m_optionsPanel5Panel1Component10Label:SetText("(2)  Large, 8 Rows, 1 Column, Icon on Right, Bottom to Top");        
    elseif (m_doptions.displaymode == 3) then
    		m_doptions.size = 1;    
        m_doptions.rightleft = 0;
        m_doptions.downup = "DOWN";
        m_doptions.icon_side = 1;
        m_optionsPanel5Panel1Component10Label:SetText("(3)  Large, 8 Rows, 1 Column, Icon on Right, Top to Bottom");  
    elseif (m_doptions.displaymode == 4) then
    		m_doptions.size		= 0;
        m_doptions.downup = "DOWN";
        m_optionsPanel5Panel1Component10Label:SetText("(4)  Small, 8 Rows, 1 Column, Top to Bottom");  
    elseif (m_doptions.displaymode == 5) then
        m_doptions.size		= 0;
        m_doptions.downup = "UP";
        m_optionsPanel5Panel1Component10Label:SetText("(5)  Small, 8 Rows, 1 Column, Bottom to Top");  
    elseif (m_doptions.displaymode == 6) then
    		m_doptions.size		= 0;
        m_doptions.rightleft = 1;
        m_optionsPanel5Panel1Component10Label:SetText("(6)  Small, 1 Row, 8 Columns, Left to Right");  
    elseif (m_doptions.displaymode == 7) then
        m_doptions.size		= 0;
        m_doptions.rightleft = 0;
        m_optionsPanel5Panel1Component10Label:SetText("(7)  Small, 1 Row, 8 Columns, Right to Left"); 
    end
    
    m_setbufflayout();
    m_sizebuffcapsule();
end

function m_changewepbuffdisplaymode(wtf)
    if (wtf == "ADD") then
        m_woptions.displaymode = m_woptions.displaymode + 1;
        if (m_woptions.displaymode > 7) then m_woptions.displaymode = 0; end
    elseif (wtf == "SUBTRACT") then
        m_woptions.displaymode = m_woptions.displaymode - 1;
        if (m_woptions.displaymode < 0) then m_woptions.displaymode = 7; end  
    end    
    
    if (m_woptions.displaymode == 0) then
    		m_woptions.size = 0;
        m_woptions.rightleft = 0;
        m_woptions.downup = "DOWN";
        m_optionsPanel5Panel1Component18Label:SetText("(0)  Small, Top to Bottom");
    elseif (m_woptions.displaymode == 1) then
    		m_woptions.size = 0;
        m_woptions.rightleft = 0;
        m_woptions.downup = "UP";
        m_optionsPanel5Panel1Component18Label:SetText("(1)  Small, Bottom to Top");        
    elseif (m_woptions.displaymode == 2) then
    		m_woptions.size = 0;
        m_woptions.rightleft = 1;
        m_optionsPanel5Panel1Component18Label:SetText("(2)  Small, Left to Right");        
    elseif (m_woptions.displaymode == 3) then
    		m_woptions.size = 0;
        m_woptions.rightleft = 0;
        m_optionsPanel5Panel1Component18Label:SetText("(3)  Small, Right to Left");
    elseif (m_woptions.displaymode == 4) then
    		m_woptions.size = 1;
    		m_woptions.downup = "DOWN";
				m_optionsPanel5Panel1Component18Label:SetText("(4)  Large, Icon on Left, Top to Bottom");
    elseif (m_woptions.displaymode == 5) then
    		m_woptions.size = 1;
    		m_woptions.downup = "UP";
    		m_woptions.rightleft = 0;
				m_optionsPanel5Panel1Component18Label:SetText("(5)  Large, Icon on Left, Bottom to Top");
    elseif (m_woptions.displaymode == 6) then
    		m_woptions.size = 1;
    		m_woptions.downup = "DOWN";
    		m_woptions.rightleft = 0;
				m_optionsPanel5Panel1Component18Label:SetText("(6)  Large, Icon on Right, Top to Bottom");
    elseif (m_woptions.displaymode == 7) then
    		m_woptions.size = 1;
    		m_woptions.downup = "UP";
    		m_woptions.rightleft = 1;
				m_optionsPanel5Panel1Component18Label:SetText("(7)  Large, Icon on Right, Bottom to Top");							
    end
    
    m_setbufflayout();
    m_sizebuffcapsule();    
end




---------------------------------------------
function m_getBuffID(buff)
    local tempbuff = buff - 1;
    local i;
	for i = 0, 15 do
		local buffIndex, untilCancelled = GetPlayerBuff(i, "HELPFUL");
        if (buffIndex == tempbuff) then
			return buffIndex;
		end
	end
    return 0;
end

function m_getDeBuffID(buff)
    local i;
    local tempnum = 0;
	for i = 1, 8 do
        local debuffTexture, debuffApplications, debuffDispelType = UnitDebuff("player", i, 0);
        if (debuffTexture == buff) then
            if (debuffDispelType == nil) then debuffDispelType = "nil"; end
            tempnum = i - 1;
			return tempnum;
        end
	end
    return 99;
end

function m_getDeBuffType(buff)
	local i;  
	for i = 1, 8 do
		local debuffTexture, debuffApplications, debuffDispelType = UnitDebuff("player", i, 0);
		if (debuffTexture == buff) then
			if (debuffDispelType == nil) then debuffDispelType = "nil"; end
			return debuffDispelType;
		end
	end
	
	return 99;
end

function m_GetBuffType(wtf, filter)
	if (filter == nil) then
		filter = "HELPFUL|HARMFUL";
	end
	
	getglobal("BTooltipTextLeft1"):SetText("");
	getglobal("BTooltipTextRight1"):SetText("");

	local buffIndex, untilCancelled = GetPlayerBuff(wtf, filter);

	if (buffIndex ~= -1) then
		BTooltip:SetOwner(m_BuffFrame,"ANCHOR_NONE");
		BTooltip:SetPlayerBuff(buffIndex);
		
		local toolTipText = getglobal("BTooltipTextRight1");
		if (toolTipText) then
			if ( toolTipText:GetText() ~= nil ) then
				return toolTipText:GetText();
			end
		end
	end
	return nil;
end

function m_timestring(thousanths)
	local duration = "";
  local seconds = (thousanths / 1000);
	local minutes = floor(seconds / 60);
	local secsleft = seconds - (60 * minutes);
	if (seconds >= 60) then
		secsleft = floor(secsleft);
		duration = minutes .."m " .. secsleft .. "s";
	else
		if (secsleft < 1) then
			duration = string.sub(secsleft, 2, 3);
			duration = " ".. duration .. "s";
            if (duration == " s") then duration = ""; end;
			return duration;
		else
			duration = floor(seconds) .. " second";
			if(seconds >= 2) then
				duration = duration .. "s";
			end
		end
	end
	return duration;
end

function m_timestring2(seconds)
	local duration = "";
	local minutes = floor(seconds / 60);
	local secsleft = seconds - (60 * minutes);

	if (seconds >= 60) then
		secsleft = floor(secsleft);
		duration = minutes .."m " .. secsleft .. "s";
	else
		if (secsleft < 1) then
			duration = string.sub(secsleft, 2, 3);
			duration = " ".. duration .. "s";
            if (duration == " s") then duration = ""; end;
			return duration;
		else
			duration = floor(seconds) .. " second";
			if(seconds >= 2) then
				duration = duration .. "s";
			end
		end
	end
	return duration;
end

function m_timestring3(seconds)
	local duration = "";
	local minutes = floor(seconds / 60);
	local secsleft = seconds - (60 * minutes);

	if (seconds >= 60) then
		secsleft = floor(secsleft);
		if (secsleft < 10) then secsleft = "0" .. secsleft; end
		if (minutes < 10) then minutes = "0" .. minutes; end
		duration = minutes ..":" .. secsleft;
	else
		if (secsleft < 1) then
			duration = string.sub(secsleft, 2, 3);
			--duration =  duration;
            if (duration == ":") then duration = ""; end;
			return duration;
		else
			duration = "00:";
			if(seconds < 10) then
				duration = duration .. "0" .. floor(seconds);
			else
				duration = duration .. floor(seconds);
			end
		end
	end
	return duration;
end

function m_timestring4(thousanths)
	local duration = "";
  local seconds = (thousanths / 1000);
	local minutes = floor(seconds / 60);
	local secsleft = seconds - (60 * minutes);

	if (seconds >= 60) then
		secsleft = floor(secsleft);
		if (secsleft < 10) then secsleft = "0" .. secsleft; end
		if (minutes < 10) then minutes = "0" .. minutes; end
		duration = minutes ..":" .. secsleft;
	else
		if (secsleft < 1) then
			duration = string.sub(secsleft, 2, 3);
			--duration =  duration;
      if (duration == ":") then duration = ""; end;
			return duration;
		else
			duration = "00:";
			if(seconds < 10) then
				duration = duration .. "0" .. floor(seconds);
			else
				duration = duration .. floor(seconds);
			end
		end
	end
	return duration;
end

function m_getenchants(id)
	local a,z,temp;
	mbbTooltip2:SetOwner(UIParent,"ANCHOR_NONE");
	temp = mbbTooltip2:SetInventoryItem("player", id);

	if (temp) then
		for i = 1, 15, 1 do
			text = getglobal("mbbTooltip2TextLeft"..i);
			local text = text:GetText();
			if ( strlen(text or "") > 0 )then
				a, z, temp = string.find(text, "([^%(]+) %(%d+.+%)$");
				if (temp) then
					return temp;
				end
			end
		end
	end
	return nil;
end

function m_buffname(i, filter)
	--local i = i - 1;
	local buffIndex, untilCancelled = GetPlayerBuff(i, filter);

	if (buffIndex == -1) then
		--no such buff
		return "nil";
	else

		mbbTooltip1:SetOwner(UIParent,"ANCHOR_NONE");
		mbbTooltip1:SetPlayerBuff(buffIndex);

		local toolTipText = getglobal("mbbTooltip1TextLeft1");
		if (toolTipText) then
			local name = toolTipText:GetText();
			if (name ~= nil) then
					return name;
			end
		end

	end
end

function m_isDebuff(buff)
	local i;
	for i = 0, 23 do
		local debuffIndex, untilCancelled = GetPlayerBuff(i, "HARMFUL");
		if (debuffIndex == -1) then 
			return 0; 
		elseif (debuffIndex == buff) then
			return 1;
		end
	end
	return 0;
end

function m_printmsg(msg)
	DEFAULT_CHAT_FRAME:AddMessage(msg);
end
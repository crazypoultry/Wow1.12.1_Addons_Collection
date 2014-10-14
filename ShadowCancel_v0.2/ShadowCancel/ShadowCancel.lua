        ShadowCancel = AceAddon:new({
        name          = "ShadowCancel",
        description   = "Cancels Shadowform upon trying to cast a Holy spell.",
        version       = "0.2",
        releaseDate   = "06-04-2006",
        aceCompatible = "102",
        author        = "Kepek",
        email         = "",
        category      = "Combat",     
        db            = AceDatabase:new("ShadowCancelDB"),
        defaults      = DEFAULT_OPTIONS,
        cmd           = AceChatCmd:new(SHADOWCANCEL.COMMANDS, SHADOWCANCEL.CMD_OPTIONS),
        })
    
    function ShadowCancel:Initialize()
        self.GetOpt = function(var) return self.db:get(self.profilePath,var) end
        self.SetOpt = function(var,val) self.db:set(self.profilePath,var,val) end
        self.TogOpt = function(var) return self.db:toggle(self.profilePath,var) end
    end
    
    function ShadowCancel:Enable()        
        self:RegisterEvent("UI_ERROR_MESSAGE", "CancelForm")
    end
    
    ShadowCancel:RegisterForLoad()
    
    function ShadowCancel:CancelForm()
        if(string.find(arg1, SPELL_FAILED_NOT_SHAPESHIFT) ) then
		CancelPlayerBuff(self:CPlayerBuff(SHADOWCANCEL.BUFF))
            UIErrorsFrame:AddMessage(SHADOWCANCEL.REMOVED, 1.0, 0.1, 0.1, 1.0, 1)
        end
    end

    function ShadowCancel:CPlayerBuff(buff,a)
	  local i = 0;
	  while not (GetPlayerBuff(i) == -1) do
		if (string.find(GetPlayerBuffTexture(i), buff)) then 
			if (a) and ( DEFAULT_CHAT_FRAME ) then 
				DEFAULT_CHAT_FRAME:AddMessage("CPlayer: "..GetPlayerBuffTexture(i)..", i: "..i, 1, 1, 0.5);
			end
			return GetPlayerBuff(i);
		end
		i = i + 1;
	  end
    end
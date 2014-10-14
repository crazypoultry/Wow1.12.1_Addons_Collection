if (not AceGUI) then
	AceGUIDummy = {};
	function AceGUIDummy:new(o) 
		if( self.__index ~= self ) then self.__index = self end
		return setmetatable(o or {}, self)
	end
	function AceGUIDummy:Show() end
	function AceGUIDummy:Initialize(x,y) KC_AutoRepair.Set(KC_AutoRepair, "prompt", FALSE);	end
end
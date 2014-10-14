--By BrainChild - 2006

function DoubleClickSelfCastUseAction(slot, checkCursor ,onSelf)
   if SpellIsTargeting() then
      if(last_action == slot) then
        TargetUnit("player");
	TargetUnit("Target");
      end
   end
   last_action = slot;
   OldUseAction(slot, checkCursor ,onSelf);
end

function DoubleClickSelfCastEventHandler()
   if (event == "VARIABLES_LOADED") then 
      DoubleClickSelfCast_initialize();   
   end 
end

function DoubleClickSelfCast_initialize()
	--override event driven function
	
	OldUseAction=UseAction;
	UseAction=DoubleClickSelfCastUseAction;
	DEFAULT_CHAT_FRAME:AddMessage("DoubleClickSelfCast by BrainChild is now active");
end


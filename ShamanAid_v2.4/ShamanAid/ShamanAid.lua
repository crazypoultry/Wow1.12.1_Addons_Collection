--[[ 
Shaman Aid
Description:
------------
Rings a bell if weapon buff is not active when entering melee combat or during combat. 
Also puts a message to the Chat  screen. If mana is below 15% of max mana when in
combat no alert occurs. 

A chord sounds and a message appears in Chat when Lightning Shield fades from you.

The sounds can be turned off and on. Type  /said  for a list of commands and a status on sounds being ON or OFF.
The sound settings are saved upon exiting the game.
 ]]--

wbuff = 1
lsbuff = 1

function ShamanAid_OnLoad()
                this:RegisterEvent("CHAT_MSG_COMBAT_SELF_HITS");
	this:RegisterEvent("PLAYER_ENTER_COMBAT");
                this:RegisterEvent("CHAT_MSG_SPELL_AURA_GONE_SELF");
                
                SAIDX = 1
                
                SLASH_ShamanAid1 = "/ShamanAid";
                SLASH_ShamanAid2 = "/said";
                SlashCmdList["ShamanAid"] = ShamanAid_SlashCommand;


	if( DEFAULT_CHAT_FRAME ) then
	DEFAULT_CHAT_FRAME:AddMessage("ShamanAid loaded. Type /said for a command list.",1, 0, 0);
	end
                
end


function ShamanAid_OnEvent()
     
      a = UnitClass("player")
            if a == "Shaman" then
	    if (event == "PLAYER_ENTER_COMBAT") then
                                SAIDX = 1
		a,b,c,d,e,f = GetWeaponEnchantInfo()
		 if a == nil then
                                       if(wbuff == 1) then
                                       PlaySoundFile("Sound\\Doodad\\BellTollHorde.wav");
                                       end
		       DEFAULT_CHAT_FRAME:AddMessage("*** WEAPON NOT BUFFED ***");
                                       
		 end	
	     end
          
                    if (event == "CHAT_MSG_COMBAT_SELF_HITS") then
                          if (SAIDX == nil) then
                          SAIDX = 1
                          end

                           if SAIDX <= 2 then
                           if UnitAffectingCombat("player") then
                           a = UnitManaMax("player")     
                           b = UnitMana("player")
                                if b >= a * .15 then       
                                       a,b,c,d,e,f = GetWeaponEnchantInfo()
		       if a == nil then
                                             if(wbuff == 1) then
                                             PlaySoundFile("Sound\\Doodad\\BellTollHorde.wav");
                                             end
		             DEFAULT_CHAT_FRAME:AddMessage("*** WEAPON NOT BUFFED ***");
                                             SAIDX = (SAIDX + 1)
		       end
                            end	
                            end
                            end
                     end

                     if (event == "CHAT_MSG_SPELL_AURA_GONE_SELF") then
                                  if arg1 == "Lightning Shield fades from you." then
                                       if(lsbuff == 1) then
                                       PlaySound("igQuestFailed");                                       
                                       end
                                  DEFAULT_CHAT_FRAME:AddMessage("*** LIGHTNING SHIELD FADED ***");
                                  end
                     end

             end	
end

function ShamanAid_SlashCommand(msg)
                      if(msg == "soff") then
                              lsbuff = 2
                              DEFAULT_CHAT_FRAME:AddMessage("Lightning Shield chime off.");
                       end
                       if(msg == "son") then
                              lsbuff = 1
                              DEFAULT_CHAT_FRAME:AddMessage("Lightning Shield chime on.");
                       end
                       if(msg == "boff") then
                              wbuff = 2
                              DEFAULT_CHAT_FRAME:AddMessage("Weapon Buff bell off.");
                       end      
                        if(msg == "bon") then
                              wbuff = 1
                              DEFAULT_CHAT_FRAME:AddMessage("Weapon Buff bell on.");
                        end 
                        if(msg == "") then        
                              DEFAULT_CHAT_FRAME:AddMessage("ShamanAid commands list");
                              DEFAULT_CHAT_FRAME:AddMessage("Type  /said soff  - Turns Lightning Shield alert chime off.");
                              DEFAULT_CHAT_FRAME:AddMessage("Type  /said son  - Turns Lightning Shield alert chime on.");
                              DEFAULT_CHAT_FRAME:AddMessage("Type  /said boff  - Turns Weapon Buff alert bell off.");
                              DEFAULT_CHAT_FRAME:AddMessage("Type  /said bon  - Turns Weapon Buff alert bell on.");
                                    if(wbuff == 1) then
                                    DEFAULT_CHAT_FRAME:AddMessage("* Weapon Buffed alert sound is ON.");
                                    end
                                    if(wbuff == 2) then
                                    DEFAULT_CHAT_FRAME:AddMessage("* Weapon Buffed alert sound is OFF.");
                                    end
                                    if(lsbuff == 1) then
                                    DEFAULT_CHAT_FRAME:AddMessage("* Lightning Shield alert sound is ON.");
                                    end
                                    if(lsbuff == 2) then
                                    DEFAULT_CHAT_FRAME:AddMessage("* Lightning Shield alert sound is OFF.");
                                    end
                        end             
end                              



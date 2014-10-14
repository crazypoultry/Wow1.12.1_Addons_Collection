function mp3_MyScript_Play(cmd)
  DEFAULT_CHAT_FRAME:AddMessage("Playing " .. cmd);
 PlayMusic(string.format("Interface\\AddOns\\Mp3Player\\%s",cmd));
end

function mp3_MyScript_StopMp3(cmd)
  DEFAULT_CHAT_FRAME:AddMessage("Stoping...");
StopMusic();
end


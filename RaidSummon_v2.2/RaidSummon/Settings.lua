-- saved variables
rsmSaved= {
  summonsList=  { };
  enabled=      true;
  announce=     true;
  whisper=      true;
  listen=       true;
  minShards=    7;
  interactLang= string.sub(GetLocale(), 1, 2);
  keywords=     { };
  hideRequests= false;
  hideReplies=  true;
  flashAction=  true;
  minDistance=  1500;
}
  
-- public interface
rsmSettings= {
  
  -- enable/disable raidsummon functionality
  ToggleEnable= function(verbose)
    rsmSaved.enabled= not rsmSaved.enabled;
    if (verbose) then
      if (rsmSaved.enabled) then
        rsmUtil.PrintChatMessage(RSM_HEADER..RSM_ADDON_ENABLED);
      else
        rsmUtil.PrintChatMessage(RSM_HEADER..RSM_ADDON_DISABLED);
      end;
    end;
    rsmUtil.UpdateInterfaces();
  end;

  -- enable/disable request processing
  ToggleListen= function(verbose)
    rsmSaved.listen= not rsmSaved.listen;
    if (verbose) then
      if (rsmSaved.listen) then
        rsmUtil.PrintChatMessage(RSM_HEADER..RSM_LISTEN_ENABLED);
      else
        rsmUtil.PrintChatMessage(RSM_HEADER..RSM_LISTEN_DISABLED);
      end;
    end;
    rsmUtil.UpdateInterfaces();
  end;

  -- enable/disable summoning announcements
  ToggleAnnounce= function(verbose)
    rsmSaved.announce= not rsmSaved.announce;
    if (verbose) then
      if (rsmSaved.announce) then
        rsmUtil.PrintChatMessage(RSM_HEADER..RSM_ANNOUNCE_ENABLED);
      else
        rsmUtil.PrintChatMessage(RSM_HEADER..RSM_ANNOUNCE_DISABLED);
      end;
    end;
  end;

  -- enable/disable summoning notification by whisper
  ToggleWhisper= function(verbose)
    rsmSaved.whisper= not rsmSaved.whisper;
    if (verbose) then
      if (rsmSaved.whisper) then
        rsmUtil.PrintChatMessage(RSM_HEADER..RSM_WHISPER_ENABLED);
      else
        rsmUtil.PrintChatMessage(RSM_HEADER..RSM_WHISPER_DISABLED);
      end;
    end;
  end;

  -- enable/disable action-blinking
  ToggleFlashing= function(verbose)
    rsmSaved.flashAction= not rsmSaved.flashAction;
    if (verbose) then
      if (rsmSaved.flashAction) then
        rsmUtil.PrintChatMessage(RSM_HEADER..RSM_BLINKING_ENABLED);
      else
        rsmUtil.PrintChatMessage(RSM_HEADER..RSM_BLINKING_DISABLED);
      end;
    end;
  end;

  -- show/hide requests
  ToggleHideRequests= function(verbose)
    rsmSaved.hideRequests= not rsmSaved.hideRequests;
    if (verbose) then
      if (rsmSaved.hideRequests) then
        rsmUtil.PrintChatMessage(RSM_HEADER..RSM_REQUESTS_HIDDEN);
      else
        rsmUtil.PrintChatMessage(RSM_HEADER..RSM_REQUESTS_SHOWN);
      end;
    end;
  end;

  -- show/hide RaidSummon's replies to request
  ToggleHideReplies= function(verbose)
    rsmSaved.hideReplies= not rsmSaved.hideReplies;
    if (verbose) then
      if (rsmSaved.hideReplies) then
        rsmUtil.PrintChatMessage(RSM_HEADER..RSM_REPLIES_HIDDEN);
      else
        rsmUtil.PrintChatMessage(RSM_HEADER..RSM_REPLIES_SHOWN);
      end;
    end;
  end;

  -- select announcement/whisper language
  SetNotificationLanguage= function(newLang, verbose)
    rsmSaved.interactLang= newLang;
    local langName= rsmUtil.GetLocalized("LANGUAGE");  -- this will also reset language if invalid, so we don't need to check this here

    if (verbose) then
      rsmUtil.PrintChatMessage(RSM_HEADER..RSM_WHISPERLANG..langName.." ("..rsmSaved.interactLang..")");
    end;
  end;

  -- set minimum number of shards required to process requests
  SetShardMinimum= function(num, verbose)
    if (num) then
      num= tonumber(num);
    end;
    if (num and num >= 1) then
      rsmSaved.minShards= num;
    else
      rsmSaved.minShards= 1;
    end;

    if (verbose) then
      local msg= string.gsub(RSM_HEADER..RSM_MINIMUM_SHARDS, "%%n", rsmSaved.minShards);
      rsmUtil.PrintChatMessage(msg);
    end;
  end;
  
  -- set minimum distance for the mass summoning feature
  SetDistanceMinimum= function(num, verbose)
    if (num) then
      num= tonumber(num);
    end;
    if (num and num >= 150) then
      rsmSaved.minDistance= num;
    else
      rsmSaved.minDistance= 150;
    end;

    if (verbose) then
      local msg= string.gsub(RSM_HEADER..RSM_MINIMUM_DISTANCE, "%%n", rsmSaved.minDistance);
      rsmUtil.PrintChatMessage(msg);
    end;
  end;
  
  -- add keyword to list to words that trigger a summon request
  KeywordAdd= function(lang, keyword)
    -- make sure it doesn't already exist, then add it
    rsmSettings.KeywordRemove(lang, keyword);
    if (not rsmSaved.keywords[lang]) then
      rsmSaved.keywords[lang]= { };
    end;
    table.insert(rsmSaved.keywords[lang], keyword);
  end;
  
  -- remove keyword from list
  KeywordRemove= function(lang, keyword)
    if (not rsmSaved.keywords[lang]) then
      return;
    end;
    for index, value in rsmSaved.keywords[lang] do
      if (value == keyword) then
        table.remove(rsmSaved.keywords[lang], index);
        break;
      end;
    end;
  end;
  
  -- reset list of keywords for specified language
  KeywordReset= function(lang)
    rsmSaved.keywords[lang]= {  };
  end;  
}
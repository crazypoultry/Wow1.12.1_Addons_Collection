MusicList={
MinimapPos = 45
}
NewFileNumber=""
NewFileAdresse=""
NewFileName=""
MLSongN=0
RSN=0

function ML_OnLoad()
  this:RegisterEvent("VARIABLES_LOADED")
  SLASH_MusicList1="/musiclist"
  SLASH_MusicList2="/ml"
  SlashCmdList["MusicList"]= ML_SlashHandler
end

function ML_OnEvent()
  MaxFile=27
  ActFile=0
  ML_FN1=MusicList["FN1"]
  ML_FN2=MusicList["FN2"]
  ML_FN3=MusicList["FN3"]
  ML_FN4=MusicList["FN4"]
  ML_FN5=MusicList["FN5"]
  ML_FN6=MusicList["FN6"]
  ML_FN7=MusicList["FN7"]
  ML_FN8=MusicList["FN8"]
  ML_FN9=MusicList["FN9"]
  ML_FN10=MusicList["FN10"]
  ML_FN11=MusicList["FN11"]
  ML_FN12=MusicList["FN12"]
  ML_FN13=MusicList["FN13"]
  ML_FN14=MusicList["FN14"]
  ML_FN15=MusicList["FN15"]
  ML_FN16=MusicList["FN16"]
  ML_FN17=MusicList["FN17"]
  ML_FN18=MusicList["FN18"]
  ML_FN19=MusicList["FN19"]
  ML_FN20=MusicList["FN20"]
  ML_FN21=MusicList["FN21"]
  ML_FN22=MusicList["FN22"]
  ML_FN23=MusicList["FN23"]
  ML_FN24=MusicList["FN24"]
  ML_FN25=MusicList["FN25"]
  ML_FN26=MusicList["FN26"]
  ML_FN27=MusicList["FN27"]
  ML_FS1Text=MusicList["FS1"]
  ML_FS2Text=MusicList["FS2"]
  ML_FS3Text=MusicList["FS3"]
  ML_FS4Text=MusicList["FS4"]
  ML_FS5Text=MusicList["FS5"]
  ML_FS6Text=MusicList["FS6"]
  ML_FS7Text=MusicList["FS7"]
  ML_FS8Text=MusicList["FS8"]
  ML_FS9Text=MusicList["FS9"]
  ML_FS10Text=MusicList["FS10"]
  ML_FS11Text=MusicList["FS11"]
  ML_FS12Text=MusicList["FS12"]
  ML_FS13Text=MusicList["FS13"]
  ML_FS14Text=MusicList["FS14"]
  ML_FS15Text=MusicList["FS15"]
  ML_FS16Text=MusicList["FS16"]
  ML_FS17Text=MusicList["FS17"]
  ML_FS18Text=MusicList["FS18"]
  ML_FS19Text=MusicList["FS19"]
  ML_FS20Text=MusicList["FS20"]
  ML_FS21Text=MusicList["FS21"]
  ML_FS22Text=MusicList["FS22"]
  ML_FS23Text=MusicList["FS23"]
  ML_FS24Text=MusicList["FS24"]
  ML_FS25Text=MusicList["FS25"]
  ML_FS26Text=MusicList["FS26"]
  ML_FS27Text=MusicList["FS27"]  
  ML_FS1:SetText(ML_FS1Text)
  ML_FS2:SetText(ML_FS2Text)
  ML_FS3:SetText(ML_FS3Text)
  ML_FS4:SetText(ML_FS4Text)
  ML_FS5:SetText(ML_FS5Text)
  ML_FS6:SetText(ML_FS6Text)
  ML_FS7:SetText(ML_FS7Text)
  ML_FS8:SetText(ML_FS8Text)
  ML_FS9:SetText(ML_FS9Text)
  ML_FS10:SetText(ML_FS10Text)
  ML_FS11:SetText(ML_FS11Text)
  ML_FS12:SetText(ML_FS12Text)
  ML_FS13:SetText(ML_FS13Text)
  ML_FS14:SetText(ML_FS14Text)
  ML_FS15:SetText(ML_FS15Text)
  ML_FS16:SetText(ML_FS16Text)
  ML_FS17:SetText(ML_FS17Text)
  ML_FS18:SetText(ML_FS18Text)
  ML_FS19:SetText(ML_FS19Text)
  ML_FS20:SetText(ML_FS20Text)
  ML_FS21:SetText(ML_FS21Text)
  ML_FS22:SetText(ML_FS22Text)
  ML_FS23:SetText(ML_FS23Text)
  ML_FS24:SetText(ML_FS24Text)
  ML_FS25:SetText(ML_FS25Text)
  ML_FS26:SetText(ML_FS26Text)
  ML_FS27:SetText(ML_FS27Text)
  if(MusicList["WCV"]~=nil) then
    WCV=MusicList["WCV"]
    if(WCV=="Music") then
      CheckButton_MusicVolume:SetChecked(1)
      CheckButton_MasterVolume:SetChecked(0)
    else
      CheckButton_MusicVolume:SetChecked(0)
      CheckButton_MasterVolume:SetChecked(1)
    end
  else
    WCV="Master"
    CheckButton_MasterVolume:SetChecked(1)
    CheckButton_MusicVolume:SetChecked(0)
  end
  if(MusicList["S1"]=="true") then
    CheckButton_S1:SetChecked(1)
  else
    CheckButton_S1:SetChecked(0)
  end
  while(MaxFile>0) do
    ActFile=ActFile+1
    getglobal("ML_ID"..ActFile):SetText(ActFile)
    if(getglobal("ML_FN"..ActFile)==nil) then
      getglobal("ML_PB"..ActFile):Hide()
    else
      MLSongN=MLSongN+1
      getglobal("ML_PB"..ActFile):Show()
    end
    MaxFile=MaxFile-1
  end
  ML_ONumber:Hide()
end

function ML_SlashHandler()
  ML_MusicChoose:Show()
end

function ML_PlB1()
  if(MusicList["S1"]=="true") then
    PlayMusic("Interface\\AddOns\\MusicList\\Music\\"..MusicList["FN1"]);
  else
    PlaySoundFile("Interface\\AddOns\\MusicList\\Music\\"..MusicList["FN1"]);
  end
end

function ML_PlB2()
  if(MusicList["S2"]=="true") then
    PlayMusic("Interface\\AddOns\\MusicList\\Music\\"..MusicList["FN2"]);
  else
    PlaySoundFile("Interface\\AddOns\\MusicList\\Music\\"..MusicList["FN2"]);
  end
end

function ML_PlB3()
  if(MusicList["S3"]=="true") then
    PlayMusic("Interface\\AddOns\\MusicList\\Music\\"..MusicList["FN3"]);
  else
    PlaySoundFile("Interface\\AddOns\\MusicList\\Music\\"..MusicList["FN3"]);
  end
end

function ML_PlB4()
  if(MusicList["S4"]=="true") then
    PlayMusic("Interface\\AddOns\\MusicList\\Music\\"..MusicList["FN4"]);
  else
    PlaySoundFile("Interface\\AddOns\\MusicList\\Music\\"..MusicList["FN4"]);
  end
end

function ML_PlB5()
  if(MusicList["S5"]=="true") then
    PlayMusic("Interface\\AddOns\\MusicList\\Music\\"..MusicList["FN5"]);
  else
    PlaySoundFile("Interface\\AddOns\\MusicList\\Music\\"..MusicList["FN5"]);
  end
end

function ML_PlB6()
  if(MusicList["S6"]=="true") then
    PlayMusic("Interface\\AddOns\\MusicList\\Music\\"..MusicList["FN6"]);
  else
    PlaySoundFile("Interface\\AddOns\\MusicList\\Music\\"..MusicList["FN6"]);
  end
end

function ML_PlB7()
  if(MusicList["S7"]=="true") then
    PlayMusic("Interface\\AddOns\\MusicList\\Music\\"..MusicList["FN7"]);
  else
    PlaySoundFile("Interface\\AddOns\\MusicList\\Music\\"..MusicList["FN7"]);
  end
end

function ML_PlB8()
  if(MusicList["S8"]=="true") then
    PlayMusic("Interface\\AddOns\\MusicList\\Music\\"..MusicList["FN8"]);
  else
    PlaySoundFile("Interface\\AddOns\\MusicList\\Music\\"..MusicList["FN8"]);
  end
end

function ML_PlB9()
  if(MusicList["S9"]=="true") then
    PlayMusic("Interface\\AddOns\\MusicList\\Music\\"..MusicList["FN9"]);
  else
    PlaySoundFile("Interface\\AddOns\\MusicList\\Music\\"..MusicList["FN9"]);
  end
end

function ML_PlB10()
  if(MusicList["S10"]=="true") then
    PlayMusic("Interface\\AddOns\\MusicList\\Music\\"..MusicList["FN10"]);
  else
    PlaySoundFile("Interface\\AddOns\\MusicList\\Music\\"..MusicList["FN10"]);
  end
end

function ML_PlB11()
  if(MusicList["S11"]=="true") then
    PlayMusic("Interface\\AddOns\\MusicList\\Music\\"..MusicList["FN11"]);
  else
    PlaySoundFile("Interface\\AddOns\\MusicList\\Music\\"..MusicList["FN11"]);
  end
end

function ML_PlB12()
  if(MusicList["S12"]=="true") then
    PlayMusic("Interface\\AddOns\\MusicList\\Music\\"..MusicList["FN12"]);
  else
    PlaySoundFile("Interface\\AddOns\\MusicList\\Music\\"..MusicList["FN12"]);
  end
end

function ML_PlB13()
  if(MusicList["S13"]=="true") then
    PlayMusic("Interface\\AddOns\\MusicList\\Music\\"..MusicList["FN13"]);
  else
    PlaySoundFile("Interface\\AddOns\\MusicList\\Music\\"..MusicList["FN13"]);
  end
end

function ML_PlB14()
  if(MusicList["S14"]=="true") then
    PlayMusic("Interface\\AddOns\\MusicList\\Music\\"..MusicList["FN14"]);
  else
    PlaySoundFile("Interface\\AddOns\\MusicList\\Music\\"..MusicList["FN14"]);
  end
end

function ML_PlB15()
  if(MusicList["S15"]=="true") then
    PlayMusic("Interface\\AddOns\\MusicList\\Music\\"..MusicList["FN15"]);
  else
    PlaySoundFile("Interface\\AddOns\\MusicList\\Music\\"..MusicList["FN15"]);
  end
end

function ML_PlB16()
  if(MusicList["S16"]=="true") then
    PlayMusic("Interface\\AddOns\\MusicList\\Music\\"..MusicList["FN16"]);
  else
    PlaySoundFile("Interface\\AddOns\\MusicList\\Music\\"..MusicList["FN16"]);
  end
end

function ML_PlB17()
  if(MusicList["S17"]=="true") then
    PlayMusic("Interface\\AddOns\\MusicList\\Music\\"..MusicList["FN17"]);
  else
    PlaySoundFile("Interface\\AddOns\\MusicList\\Music\\"..MusicList["FN17"]);
  end
end

function ML_PlB18()
  if(MusicList["S18"]=="true") then
    PlayMusic("Interface\\AddOns\\MusicList\\Music\\"..MusicList["FN18"]);
  else
    PlaySoundFile("Interface\\AddOns\\MusicList\\Music\\"..MusicList["FN18"]);
  end
end

function ML_PlB19()
  if(MusicList["S19"]=="true") then
    PlayMusic("Interface\\AddOns\\MusicList\\Music\\"..MusicList["FN19"]);
  else
    PlaySoundFile("Interface\\AddOns\\MusicList\\Music\\"..MusicList["FN19"]);
  end
end

function ML_PlB20()
  if(MusicList["S20"]=="true") then
    PlayMusic("Interface\\AddOns\\MusicList\\Music\\"..MusicList["FN20"]);
  else
    PlaySoundFile("Interface\\AddOns\\MusicList\\Music\\"..MusicList["FN20"]);
  end
end

function ML_PlB21()
  if(MusicList["S21"]=="true") then
    PlayMusic("Interface\\AddOns\\MusicList\\Music\\"..MusicList["FN21"]);
  else
    PlaySoundFile("Interface\\AddOns\\MusicList\\Music\\"..MusicList["FN21"]);
  end
end

function ML_PlB22()
  if(MusicList["S22"]=="true") then
    PlayMusic("Interface\\AddOns\\MusicList\\Music\\"..MusicList["FN22"]);
  else
    PlaySoundFile("Interface\\AddOns\\MusicList\\Music\\"..MusicList["FN22"]);
  end
end

function ML_PlB23()
  if(MusicList["S23"]=="true") then
    PlayMusic("Interface\\AddOns\\MusicList\\Music\\"..MusicList["FN23"]);
  else
    PlaySoundFile("Interface\\AddOns\\MusicList\\Music\\"..MusicList["FN23"]);
  end
end

function ML_PlB24()
  if(MusicList["S24"]=="true") then
    PlayMusic("Interface\\AddOns\\MusicList\\Music\\"..MusicList["FN24"]);
  else
    PlaySoundFile("Interface\\AddOns\\MusicList\\Music\\"..MusicList["FN24"]);
  end
end

function ML_PlB25()
  if(MusicList["S25"]=="true") then
    PlayMusic("Interface\\AddOns\\MusicList\\Music\\"..MusicList["FN25"]);
  else
    PlaySoundFile("Interface\\AddOns\\MusicList\\Music\\"..MusicList["FN25"]);
  end
end

function ML_PlB26()
  if(MusicList["S26"]=="true") then
    PlayMusic("Interface\\AddOns\\MusicList\\Music\\"..MusicList["FN26"]);
  else
    PlaySoundFile("Interface\\AddOns\\MusicList\\Music\\"..MusicList["FN26"]);
  end
end

function ML_PlB27()
  if(MusicList["S27"]=="true") then
    PlayMusic("Interface\\AddOns\\MusicList\\Music\\"..MusicList["FN27"]);
  else
    PlaySoundFile("Interface\\AddOns\\MusicList\\Music\\"..MusicList["FN27"]);
  end
end

function ML_AddAdresse()
  NewFileAdresse=ML_AdrFile:GetText()
end

function ML_AddName()
  NewFileName=ML_NameFile:GetText()
end

function ML_Adding()
  ML_AddAdresse()
  ML_AddName()
  local ML_NMF=1
  while(ML_NMF<=27) do 
    if(not getglobal("ML_PB"..ML_NMF):IsVisible()) then
      NewFileNumber=ML_NMF MusicList["FN"..NewFileNumber]=NewFileAdresse MusicList["FS"..NewFileNumber]=NewFileName  break
    else
      ML_NMF=ML_NMF+1
    end
  end
  getglobal("ML_FS"..NewFileNumber):SetText(NewFileName)
  if(MusicList["FN"..NewFileNumber]~=nil) then
    getglobal("ML_PB"..NewFileNumber):Show()
    MLSongN=MLSongN+1
  end
end

function ML_StopMusic()
   SetCVar("MasterSoundEffects", 0)
   SetCVar("MasterSoundEffects", 1)
   StopMusic()
end

function ML_ValueChanged()
  MVV=ML_MasterVolumeSlider:GetValue()
  MVV=MVV/100
  SetCVar("MasterVolume", MVV)
end

function ML_MuValueChanged()
  MuVV=ML_MusicVolumeSlider:GetValue()
  MuVV=MuVV/100
  SetCVar("MusicVolume", MuVV)
end

function ML_MuVSLoad()
  MuVL=GetCVar("MusicVolume")
  MuVL=MuVL*100
  this:SetValue(MuVL)
end

function ML_MVSLoad()
  MVL=GetCVar("MasterVolume")
  MVL=MVL*100
  this:SetValue(MVL)
end

function MusicList_MinimapButton_DraggingFrame_OnUpdate()
  local xpos,ypos = GetCursorPosition()
  local xmin,ymin = Minimap:GetLeft(), Minimap:GetBottom()
  xpos = xmin-xpos/UIParent:GetScale()+70
  ypos = ypos/UIParent:GetScale()-ymin-70
  MusicList.MinimapPos = math.deg(math.atan2(ypos,xpos))
  MusicList_MinimapButton_Reposition()
end

function MusicList_MinimapButton_Reposition()
  MusicList_MinimapButton:SetPoint("TOPLEFT","Minimap","TOPLEFT",52-(80*cos(MusicList.MinimapPos)),(80*sin(MusicList.MinimapPos))-52)
end

function MusicList_MinimapButton_OnClick()
  if(arg1=="RightButton") then
    RSN=math.random(MLSongN)
    if(RSN==1) then
      ML_PlB1()
    end
    if(RSN==2) then
      ML_PlB2()
    end
    if(RSN==3) then
      ML_PlB3()
    end
    if(RSN==4) then
      ML_PlB4()
    end
    if(RSN==5) then
      ML_PlB5()
    end
    if(RSN==6) then
      ML_PlB6()
    end
    if(RSN==7) then
      ML_PlB7()
    end
    if(RSN==8) then
      ML_PlB8()
    end
    if(RSN==9) then
      ML_PlB9()
    end
    if(RSN==10) then
      ML_PlB10()
    end
    if(RSN==11) then
      ML_PlB11()
    end
    if(RSN==12) then
      ML_PlB12()
    end
    if(RSN==13) then
      ML_PlB13()
    end
    if(RSN==14) then
      ML_PlB14()
    end
    if(RSN==15) then
      ML_PlB15()
    end
    if(RSN==16) then
      ML_PlB16()
    end
    if(RSN==17) then
      ML_PlB17()
    end
    if(RSN==18) then
      ML_PlB18()
    end
    if(RSN==19) then
      ML_PlB19()
    end
    if(RSN==20) then
      ML_PlB20()
    end
    if(RSN==21) then
      ML_PlB21()
    end
    if(RSN==22) then
      ML_PlB22()
    end
    if(RSN==23) then
      ML_PlB23()
    end
    if(RSN==24) then
      ML_PlB24()
    end
    if(RSN==25) then
      ML_PlB25()
    end
    if(RSN==26) then
      ML_PlB26()
    end
    if(RSN==27) then
      ML_PlB27()
    end
  end
  if(arg1=="LeftButton") then
    if(not ML_MusicChoose:IsVisible()) then
      ML_SlashHandler()
    else
       ML_MusicChoose:Hide()
    end
  end
  if(arg1=="MiddleButton") then
    ML_StopMusic()
  end
end

function ML_MouseWheel(value)
  if(WCV=="Master") then
    if(value>0) then
      ML_MusicUp()
    end
    if(value<0) then
      ML_MusicDown()
    end
  elseif(WCV=="Music") then
    if(value>0) then
      ML_MuMusicUp()
    end
    if(value<0) then
      ML_MuMusicDown()
    end
  end
end
  
function ML_MusicUp()
  MVV=ML_MasterVolumeSlider:GetValue()
  if(MVV<100) then
    MVV=MVV+1
    ML_MasterVolumeSlider:SetValue(MVV)
    ML_ValueChanged()
  end
end

function ML_MuMusicUp()
  MuVV=ML_MusicVolumeSlider:GetValue()
  if(MuVV<100) then
    MuVV=MuVV+1
    ML_MusicVolumeSlider:SetValue(MuVV)
    ML_MuValueChanged()
  end
end

function ML_MusicDown()
  MVV=ML_MasterVolumeSlider:GetValue()
  if(MVV>0) then
    MVV=MVV-1
    ML_MasterVolumeSlider:SetValue(MVV)
    ML_ValueChanged()
  end
end

function ML_MuMusicDown()
  MuVV=ML_MusicVolumeSlider:GetValue()
  if(MuVV>0) then
    MuVV=MuVV-1
    ML_MusicVolumeSlider:SetValue(MuVV)
    ML_MuValueChanged()
  end
end

function ML_CBD()
  if(this:GetChecked()==1 and ML_ONumber:IsVisible()) then
    if(ML_ONumber:GetText()~="") then
      if(not getglobal("ML_PB"..tonumber(ML_ONumber:GetText())+1):IsVisible()) then
        ML_DN=ML_ONumber:GetText()
        getglobal("ML_PB"..ML_DN):Hide()
        getglobal("ML_FS"..ML_DN):SetText("")
        MusicList["FN"..ML_DN]=nil
        MusicList["FS"..ML_DN]=nil
        MLSongN=MLSongN-1
        this:SetChecked(0)
      else
        ML_DN=ML_ONumber:GetText()
        getglobal("ML_PB"..MLSongN):Hide()
        getglobal("ML_FS"..ML_DN):SetText(MusicList["FS"..MLSongN])
        getglobal("ML_FS"..MLSongN):SetText("")
        MusicList["FN"..ML_DN]=MusicList["FN"..MLSongN]
        MusicList["FN"..MLSongN]=nil
        MusicList["FS"..ML_DN]=MusicList["FS"..MLSongN]
        MusicList["FS"..MLSongN]=nil
        MLSongN=MLSongN-1
        this:SetChecked(0)
      end
    elseif(ML_ONumber:GetText()=="" and ML_ONumber:IsVisible()) then
      DEFAULT_CHAT_FRAME:AddMessage("No number entered!")
      ML_ONumber:Hide()
      this:SetChecked(0)
    end
  end
  if(this:GetChecked()==1 and not ML_ONumber:IsVisible()) then
    ML_ONumber:Show()
    this:SetChecked(1)
  end
end

function ML_CBS1()
  if(this:GetChecked()==1) then
    MusicList["S1"]="true"
  else
    MusicList["S1"]="false"
  end
end

function ML_CBS2()
  if(this:GetChecked()==1) then
    MusicList["S2"]="true"
  else
    MusicList["S2"]="false"
  end
end

function ML_CBS3()
  if(this:GetChecked()==1) then
    MusicList["S3"]="true"
  else
    MusicList["S3"]="false"
  end
end

function ML_CBS4()
  if(this:GetChecked()==1) then
    MusicList["S4"]="true"
  else
    MusicList["S4"]="false"
  end
end

function ML_CBS5()
  if(this:GetChecked()==1) then
    MusicList["S5"]="true"
  else
    MusicList["S5"]="false"
  end
end

function ML_CBS6()
  if(this:GetChecked()==1) then
    MusicList["S6"]="true"
  else
    MusicList["S6"]="false"
  end
end

function ML_CBS7()
  if(this:GetChecked()==1) then
    MusicList["S7"]="true"
  else
    MusicList["S7"]="false"
  end
end

function ML_CBS8()
  if(this:GetChecked()==1) then
    MusicList["S8"]="true"
  else
    MusicList["S8"]="false"
  end
end

function ML_CBS9()
  if(this:GetChecked()==1) then
    MusicList["S9"]="true"
  else
    MusicList["S9"]="false"
  end
end

function ML_CBS10()
  if(this:GetChecked()==1) then
    MusicList["S10"]="true"
  else
    MusicList["S10"]="false"
  end
end

function ML_CBS11()
  if(this:GetChecked()==1) then
    MusicList["S11"]="true"
  else
    MusicList["S11"]="false"
  end
end

function ML_CBS12()
  if(this:GetChecked()==1) then
    MusicList["S12"]="true"
  else
    MusicList["S12"]="false"
  end
end

function ML_CBS13()
  if(this:GetChecked()==1) then
    MusicList["S13"]="true"
  else
    MusicList["S13"]="false"
  end
end

function ML_CBS14()
  if(this:GetChecked()==1) then
    MusicList["S14"]="true"
  else
    MusicList["S14"]="false"
  end
end

function ML_CBS15()
  if(this:GetChecked()==1) then
    MusicList["S15"]="true"
  else
    MusicList["S15"]="false"
  end
end

function ML_CBS16()
  if(this:GetChecked()==1) then
    MusicList["S16"]="true"
  else
    MusicList["S16"]="false"
  end
end

function ML_CBS17()
  if(this:GetChecked()==1) then
    MusicList["S17"]="true"
  else
    MusicList["S17"]="false"
  end
end

function ML_CBS18()
  if(this:GetChecked()==1) then
    MusicList["S18"]="true"
  else
    MusicList["S18"]="false"
  end
end

function ML_CBS19()
  if(this:GetChecked()==1) then
    MusicList["S19"]="true"
  else
    MusicList["S19"]="false"
  end
end

function ML_CBS20()
  if(this:GetChecked()==1) then
    MusicList["S20"]="true"
  else
    MusicList["S20"]="false"
  end
end

function ML_CBS21()
  if(this:GetChecked()==1) then
    MusicList["S21"]="true"
  else
    MusicList["S21"]="false"
  end
end

function ML_CBS22()
  if(this:GetChecked()==1) then
    MusicList["S22"]="true"
  else
    MusicList["S22"]="false"
  end
end

function ML_CBS23()
  if(this:GetChecked()==1) then
    MusicList["S23"]="true"
  else
    MusicList["S23"]="false"
  end
end

function ML_CBS24()
  if(this:GetChecked()==1) then
    MusicList["S24"]="true"
  else
    MusicList["S24"]="false"
  end
end

function ML_CBS25()
  if(this:GetChecked()==1) then
    MusicList["S25"]="true"
  else
    MusicList["S25"]="false"
  end
end

function ML_CBS26()
  if(this:GetChecked()==1) then
    MusicList["S26"]="true"
  else
    MusicList["S26"]="false"
  end
end

function ML_CBS27()
  if(this:GetChecked()==1) then
    MusicList["S27"]="true"
  else
    MusicList["S27"]="false"
  end
end

function ML_MasterVolumeChange()
  if(CheckButton_MasterVolume:GetChecked()==1) then
    CheckButton_MasterVolume:SetChecked(1)
    CheckButton_MusicVolume:SetChecked(0)
    WCV="Master"
    MusicList["WCV"]=WCV
  else
    CheckButton_MasterVolume:SetChecked(0)
    CheckButton_MusicVolume:SetChecked(1)
    WCV="Music"
    MusicList["WCV"]=WCV
  end
end

function ML_MusicVolumeChange()
  if(CheckButton_MasterVolume:GetChecked()==1) then
    CheckButton_MasterVolume:SetChecked(0)
    CheckButton_MusicVolume:SetChecked(1)
    WCV="Music"
    MusicList["WCV"]=WCV
  else
    CheckButton_MasterVolume:SetChecked(1)
    CheckButton_MusicVolume:SetChecked(0)
    WCV="Master"
    MusicList["WCV"]=WCV
  end
end
  
    


    

    
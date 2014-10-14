

function UberHealLoadCheckMenu1()

	UIDropDownMenu_Initialize(Spell1SelectionMenu, UberHealInitCheckMenu1);
	UIDropDownMenu_SetWidth(55, Spell1SelectionMenu)
end


function UberHealLoadCheckMenu2()

	UIDropDownMenu_Initialize(Spell2SelectionMenu, UberHealInitCheckMenu2);
	UIDropDownMenu_SetWidth(55, Spell2SelectionMenu)
end


function UberHealLoadCheckMenu3()

	UIDropDownMenu_Initialize(Spell3SelectionMenu, UberHealInitCheckMenu3);
	UIDropDownMenu_SetWidth(55, Spell3SelectionMenu)
end


function UberHealLoadCheckMenu4()

	UIDropDownMenu_Initialize(Spell4SelectionMenu, UberHealInitCheckMenu4);
	UIDropDownMenu_SetWidth(55, Spell4SelectionMenu)
end


function UberHealLoadCheckMenu5()

	UIDropDownMenu_Initialize(Spell5SelectionMenu, UberHealInitCheckMenu5);
	UIDropDownMenu_SetWidth(55, Spell5SelectionMenu)
end


function UberHealInitCheckMenu1()

  local selectedValue = UIDropDownMenu_GetSelectedValue(Spell1SelectionMenu);
  local info;

   if (selectedValue == nil) then
	selectedValue = 1;
   end

   local info = {};
   info.text = "|c00C0C0C0Off|r";
   info.func = UberHealSetMenu1;
   info.value = 1;
   if ( info.value == selectedValue ) then
      info.checked = 1;
   end
   UIDropDownMenu_AddButton(info); 

   info.text = "|c00C0C0C0None|r";
   info.func = UberHealSetMenu1;
   info.value = 2;
   if ( info.value == selectedValue ) then
      info.checked = 2;
   end
   UIDropDownMenu_AddButton(info); 

   info.text = "|c00C0C0C0Ctrl|r";
   info.func = UberHealSetMenu1;
   info.value = 3;
   if ( info.value == selectedValue ) then
      info.checked = 3;
   end
   UIDropDownMenu_AddButton(info); 

   info.text = "|c00C0C0C0Alt|r";
   info.func = UberHealSetMenu1;
   info.value = 4;
   if ( info.value == selectedValue ) then
      info.checked = 4;
   end
   UIDropDownMenu_AddButton(info); 

   info.text = "|c00C0C0C0Shift|r";
   info.func = UberHealSetMenu1;
   info.value = 5;
   if ( info.value == selectedValue ) then
      info.checked = 5;
   end
   UIDropDownMenu_AddButton(info); 



   UIDropDownMenu_SetSelectedValue(Spell1SelectionMenu, selectedValue);


end


function UberHealInitCheckMenu2()

  local selectedValue = UIDropDownMenu_GetSelectedValue(Spell2SelectionMenu);
  local info;

   if (selectedValue == nil) then
	selectedValue = 1;
   end

   local info = {};
   info.text = "|c00C0C0C0Off|r";
   info.func = UberHealSetMenu2;
   info.value = 1;
   if ( info.value == selectedValue ) then
      info.checked = 1;
   end
   UIDropDownMenu_AddButton(info); 

   info.text = "|c00C0C0C0None|r";
   info.func = UberHealSetMenu2;
   info.value = 2;
   if ( info.value == selectedValue ) then
      info.checked = 2;
   end
   UIDropDownMenu_AddButton(info); 

   info.text = "|c00C0C0C0Ctrl|r";
   info.func = UberHealSetMenu2;
   info.value = 3;
   if ( info.value == selectedValue ) then
      info.checked = 3;
   end
   UIDropDownMenu_AddButton(info); 

   info.text = "|c00C0C0C0Alt|r";
   info.func = UberHealSetMenu2;
   info.value = 4;
   if ( info.value == selectedValue ) then
      info.checked = 4;
   end
   UIDropDownMenu_AddButton(info); 

   info.text = "|c00C0C0C0Shift|r";
   info.func = UberHealSetMenu2;
   info.value = 5;
   if ( info.value == selectedValue ) then
      info.checked = 5;
   end
   UIDropDownMenu_AddButton(info); 



   UIDropDownMenu_SetSelectedValue(Spell2SelectionMenu, selectedValue);


end



function UberHealInitCheckMenu3()

  local selectedValue = UIDropDownMenu_GetSelectedValue(Spell3SelectionMenu);
  local info;

   if (selectedValue == nil) then
	selectedValue = 1;
   end

   local info = {};
   info.text = "|c00C0C0C0Off|r";
   info.func = UberHealSetMenu3;
   info.value = 1;
   if ( info.value == selectedValue ) then
      info.checked = 1;
   end
   UIDropDownMenu_AddButton(info); 

   info.text = "|c00C0C0C0None|r";
   info.func = UberHealSetMenu3;
   info.value = 2;
   if ( info.value == selectedValue ) then
      info.checked = 2;
   end
   UIDropDownMenu_AddButton(info); 

   info.text = "|c00C0C0C0Ctrl|r";
   info.func = UberHealSetMenu3;
   info.value = 3;
   if ( info.value == selectedValue ) then
      info.checked = 3;
   end
   UIDropDownMenu_AddButton(info); 

   info.text = "|c00C0C0C0Alt|r";
   info.func = UberHealSetMenu3;
   info.value = 4;
   if ( info.value == selectedValue ) then
      info.checked = 4;
   end
   UIDropDownMenu_AddButton(info); 

   info.text = "|c00C0C0C0Shift|r";
   info.func = UberHealSetMenu3;
   info.value = 5;
   if ( info.value == selectedValue ) then
      info.checked = 5;
   end
   UIDropDownMenu_AddButton(info); 



   UIDropDownMenu_SetSelectedValue(Spell3SelectionMenu, selectedValue);


end


function UberHealInitCheckMenu4()

  local selectedValue = UIDropDownMenu_GetSelectedValue(Spell4SelectionMenu);
  local info;

   if (selectedValue == nil) then
	selectedValue = 1;
   end

   local info = {};
   info.text = "|c00C0C0C0Off|r";
   info.func = UberHealSetMenu4;
   info.value = 1;
   if ( info.value == selectedValue ) then
      info.checked = 1;
   end
   UIDropDownMenu_AddButton(info); 

   info.text = "|c00C0C0C0None|r";
   info.func = UberHealSetMenu4;
   info.value = 2;
   if ( info.value == selectedValue ) then
      info.checked = 2;
   end
   UIDropDownMenu_AddButton(info); 

   info.text = "|c00C0C0C0Ctrl|r";
   info.func = UberHealSetMenu4;
   info.value = 3;
   if ( info.value == selectedValue ) then
      info.checked = 3;
   end
   UIDropDownMenu_AddButton(info); 

   info.text = "|c00C0C0C0Alt|r";
   info.func = UberHealSetMenu4;
   info.value = 4;
   if ( info.value == selectedValue ) then
      info.checked = 4;
   end
   UIDropDownMenu_AddButton(info); 

   info.text = "|c00C0C0C0Shift|r";
   info.func = UberHealSetMenu4;
   info.value = 5;
   if ( info.value == selectedValue ) then
      info.checked = 5;
   end
   UIDropDownMenu_AddButton(info); 



   UIDropDownMenu_SetSelectedValue(Spell4SelectionMenu, selectedValue);


end





function UberHealInitCheckMenu5()

  local selectedValue = UIDropDownMenu_GetSelectedValue(Spell5SelectionMenu);
  local info;

   if (selectedValue == nil) then
	selectedValue = 1;
   end

   local info = {};
   info.text = "|c00C0C0C0Off|r";
   info.func = UberHealSetMenu5;
   info.value = 1;
   if ( info.value == selectedValue ) then
      info.checked = 1;
   end
   UIDropDownMenu_AddButton(info); 

   info.text = "|c00C0C0C0None|r";
   info.func = UberHealSetMenu5;
   info.value = 2;
   if ( info.value == selectedValue ) then
      info.checked = 2;
   end
   UIDropDownMenu_AddButton(info); 

   info.text = "|c00C0C0C0Ctrl|r";
   info.func = UberHealSetMenu5;
   info.value = 3;
   if ( info.value == selectedValue ) then
      info.checked = 3;
   end
   UIDropDownMenu_AddButton(info); 

   info.text = "|c00C0C0C0Alt|r";
   info.func = UberHealSetMenu5;
   info.value = 4;
   if ( info.value == selectedValue ) then
      info.checked = 4;
   end
   UIDropDownMenu_AddButton(info); 

   info.text = "|c00C0C0C0Shift|r";
   info.func = UberHealSetMenu5;
   info.value = 5;
   if ( info.value == selectedValue ) then
      info.checked = 5;
   end
   UIDropDownMenu_AddButton(info); 



   UIDropDownMenu_SetSelectedValue(Spell5SelectionMenu, selectedValue);


end





function UberHealSetMenu1()
UberHealConfig[UBERHEAL_PLAYERID]["Modifier1"] = this.value
   UIDropDownMenu_SetSelectedValue(Spell1SelectionMenu, this.value);
end

function UberHealSetMenu2()
UberHealConfig[UBERHEAL_PLAYERID]["Modifier2"] = this.value

   UIDropDownMenu_SetSelectedValue(Spell2SelectionMenu, this.value);
end

function UberHealSetMenu3()
UberHealConfig[UBERHEAL_PLAYERID]["Modifier3"] = this.value

   UIDropDownMenu_SetSelectedValue(Spell3SelectionMenu, this.value);
end

function UberHealSetMenu4()
UberHealConfig[UBERHEAL_PLAYERID]["Modifier4"] = this.value

   UIDropDownMenu_SetSelectedValue(Spell4SelectionMenu, this.value);
end

function UberHealSetMenu5()
UberHealConfig[UBERHEAL_PLAYERID]["Modifier5"] = this.value

   UIDropDownMenu_SetSelectedValue(Spell5SelectionMenu, this.value);
end








function UberHealLoadCheckButton1()

	UIDropDownMenu_Initialize(Spell1ButtonMenu, UberHealInitCheckButton1);
	UIDropDownMenu_SetWidth(140, Spell1ButtonMenu)
end


function UberHealLoadCheckButton2()

	UIDropDownMenu_Initialize(Spell2ButtonMenu, UberHealInitCheckButton2);
	UIDropDownMenu_SetWidth(140, Spell2ButtonMenu)
end


function UberHealLoadCheckButton3()

	UIDropDownMenu_Initialize(Spell3ButtonMenu, UberHealInitCheckButton3);
	UIDropDownMenu_SetWidth(140, Spell3ButtonMenu)
end


function UberHealLoadCheckButton4()

	UIDropDownMenu_Initialize(Spell4ButtonMenu, UberHealInitCheckButton4);
	UIDropDownMenu_SetWidth(140, Spell4ButtonMenu)
end


function UberHealLoadCheckButton5()

	UIDropDownMenu_Initialize(Spell5ButtonMenu, UberHealInitCheckButton5);
	UIDropDownMenu_SetWidth(140, Spell5ButtonMenu)
end


function UberHealInitCheckButton1()

  local selectedValue = UIDropDownMenu_GetSelectedValue(Spell1ButtonMenu);
  local mymyInfo;

   if (selectedValue == nil) then
	selectedValue = 1;
   end

   local myInfo = {};
   myInfo.text = "|c00C0C0C0Off|r";
   myInfo.func = UberHealSetButton1;
   myInfo.value = -1;
   myInfo.opacity = 0;
   if ( myInfo.value == selectedValue ) then
      myInfo.checked = -1;
   end
   UIDropDownMenu_AddButton(myInfo); 

   myInfo.text = "|c00C0C0C0Left Mouse Button|r";
   myInfo.func = UberHealSetButton1;
   myInfo.value = -2;
   if ( myInfo.value == selectedValue ) then
      myInfo.checked = -2;
   end
   UIDropDownMenu_AddButton(myInfo); 

   myInfo.text = "|c00C0C0C0Middle Mouse Button|r";
   myInfo.func = UberHealSetButton1;
   myInfo.value = -3;
   if ( myInfo.value == selectedValue ) then
      myInfo.checked = -3;
   end
   UIDropDownMenu_AddButton(myInfo); 

   myInfo.text = "|c00C0C0C0Right Mouse Button|r";
   myInfo.func = UberHealSetButton1;
   myInfo.value = -4;
   if ( myInfo.value == selectedValue ) then
      myInfo.checked = -4;
   end
   UIDropDownMenu_AddButton(myInfo); 

   myInfo.text = "|c00C0C0C0Mouse Button 4|r";
   myInfo.func = UberHealSetButton1;
   myInfo.value = -5;
   if ( myInfo.value == selectedValue ) then
      myInfo.checked = -5;
   end
   UIDropDownMenu_AddButton(myInfo); 

   myInfo.text = "|c00C0C0C0Mouse Button 5|r";
   myInfo.func = UberHealSetButton1;
   myInfo.value = -6;
   if ( myInfo.value == selectedValue ) then
      myInfo.checked = -6;
   end
   UIDropDownMenu_AddButton(myInfo); 



   UIDropDownMenu_SetSelectedValue(Spell1ButtonMenu, selectedValue);


end


function UberHealInitCheckButton2()

  local selectedValue = UIDropDownMenu_GetSelectedValue(Spell2ButtonMenu);
  local myInfo;

   if (selectedValue == nil) then
	selectedValue = 1;
   end

   local myInfo = {};
   myInfo.text = "|c00C0C0C0Off|r";
   myInfo.func = UberHealSetButton2;
   myInfo.value = -1;
   if ( myInfo.value == selectedValue ) then
      myInfo.checked = -1;
   end
   UIDropDownMenu_AddButton(myInfo); 

   myInfo.text = "|c00C0C0C0Left Mouse Button|r";
   myInfo.func = UberHealSetButton2;
   myInfo.value = -2;
   if ( myInfo.value == selectedValue ) then
      myInfo.checked = -2;
   end
   UIDropDownMenu_AddButton(myInfo); 

   myInfo.text = "|c00C0C0C0Middle Mouse Button|r";
   myInfo.func = UberHealSetButton2;
   myInfo.value = -3;
   if ( myInfo.value == selectedValue ) then
      myInfo.checked = -3;
   end
   UIDropDownMenu_AddButton(myInfo); 

   myInfo.text = "|c00C0C0C0Right Mouse Button|r";
   myInfo.func = UberHealSetButton2;
   myInfo.value = -4;
   if ( myInfo.value == selectedValue ) then
      myInfo.checked = -4;
   end
   UIDropDownMenu_AddButton(myInfo); 

   myInfo.text = "|c00C0C0C0Mouse Button 4|r";
   myInfo.func = UberHealSetButton2;
   myInfo.value = -5;
   if ( myInfo.value == selectedValue ) then
      myInfo.checked = -5;
   end
   UIDropDownMenu_AddButton(myInfo); 

   myInfo.text = "|c00C0C0C0Mouse Button 5|r";
   myInfo.func = UberHealSetButton2;
   myInfo.value = -6;
   if ( myInfo.value == selectedValue ) then
      myInfo.checked = -6;
   end
   UIDropDownMenu_AddButton(myInfo); 



   UIDropDownMenu_SetSelectedValue(Spell2ButtonMenu, selectedValue);


end



function UberHealInitCheckButton3()

  local selectedValue = UIDropDownMenu_GetSelectedValue(Spell3ButtonMenu);
  local myInfo;

   if (selectedValue == nil) then
	selectedValue = 1;
   end

   local myInfo = {};
   myInfo.text = "|c00C0C0C0Off|r";
   myInfo.func = UberHealSetButton3;
   myInfo.value = -1;
   if ( myInfo.value == selectedValue ) then
      myInfo.checked = -1;
   end
   UIDropDownMenu_AddButton(myInfo); 

   myInfo.text = "|c00C0C0C0Left Mouse Button|r";
   myInfo.func = UberHealSetButton3;
   myInfo.value = -2;
   if ( myInfo.value == selectedValue ) then
      myInfo.checked = -2;
   end
   UIDropDownMenu_AddButton(myInfo); 

   myInfo.text = "|c00C0C0C0Middle Mouse Button|r";
   myInfo.func = UberHealSetButton3;
   myInfo.value = -3;
   if ( myInfo.value == selectedValue ) then
      myInfo.checked = -3;
   end
   UIDropDownMenu_AddButton(myInfo); 

   myInfo.text = "|c00C0C0C0Right Mouse Button|r";
   myInfo.func = UberHealSetButton3;
   myInfo.value = -4;
   if ( myInfo.value == selectedValue ) then
      myInfo.checked = -4;
   end
   UIDropDownMenu_AddButton(myInfo); 

   myInfo.text = "|c00C0C0C0Mouse Button 4|r";
   myInfo.func = UberHealSetButton3;
   myInfo.value = -5;
   if ( myInfo.value == selectedValue ) then
      myInfo.checked = -5;
   end
   UIDropDownMenu_AddButton(myInfo); 

   myInfo.text = "|c00C0C0C0Mouse Button 5|r";
   myInfo.func = UberHealSetButton3;
   myInfo.value = -6;
   if ( myInfo.value == selectedValue ) then
      myInfo.checked = -6;
   end
   UIDropDownMenu_AddButton(myInfo); 


   UIDropDownMenu_SetSelectedValue(Spell3ButtonMenu, selectedValue);


end


function UberHealInitCheckButton4()

  local selectedValue = UIDropDownMenu_GetSelectedValue(Spell4ButtonMenu);
  local myInfo;

   if (selectedValue == nil) then
	selectedValue = 1;
   end

   local myInfo = {};
   myInfo.text = "|c00C0C0C0Off|r";
   myInfo.func = UberHealSetButton4;
   myInfo.value = -1;
   if ( myInfo.value == selectedValue ) then
      myInfo.checked = -1;
   end
   UIDropDownMenu_AddButton(myInfo); 

   myInfo.text = "|c00C0C0C0Left Mouse Button|r";
   myInfo.func = UberHealSetButton4;
   myInfo.value = -2;
   if ( myInfo.value == selectedValue ) then
      myInfo.checked = -2;
   end
   UIDropDownMenu_AddButton(myInfo); 

   myInfo.text = "|c00C0C0C0Middle Mouse Button|r";
   myInfo.func = UberHealSetButton4;
   myInfo.value = -3;
   if ( myInfo.value == selectedValue ) then
      myInfo.checked = -3;
   end
   UIDropDownMenu_AddButton(myInfo); 

   myInfo.text = "|c00C0C0C0Right Mouse Button|r";
   myInfo.func = UberHealSetButton4;
   myInfo.value = -4;
   if ( myInfo.value == selectedValue ) then
      myInfo.checked = -4;
   end
   UIDropDownMenu_AddButton(myInfo); 

   myInfo.text = "|c00C0C0C0Mouse Button 4|r";
   myInfo.func = UberHealSetButton4;
   myInfo.value = -5;
   if ( myInfo.value == selectedValue ) then
      myInfo.checked = -5;
   end
   UIDropDownMenu_AddButton(myInfo); 

   myInfo.text = "|c00C0C0C0Mouse Button 5|r";
   myInfo.func = UberHealSetButton4;
   myInfo.value = -6;
   if ( myInfo.value == selectedValue ) then
      myInfo.checked = -6;
   end
   UIDropDownMenu_AddButton(myInfo); 


   UIDropDownMenu_SetSelectedValue(Spell4ButtonMenu, selectedValue);


end





function UberHealInitCheckButton5()

  local selectedValue = UIDropDownMenu_GetSelectedValue(Spell5ButtonMenu);
  local myInfo;

   if (selectedValue == nil) then
	selectedValue = 1;
   end

   local myInfo = {};
   myInfo.text = "|c00C0C0C0Off|r";
   myInfo.func = UberHealSetButton5;
   myInfo.value = -1;
   if ( myInfo.value == selectedValue ) then
      myInfo.checked = -1;
   end
   UIDropDownMenu_AddButton(myInfo); 

   myInfo.text = "|c00C0C0C0Left Mouse Button|r";
   myInfo.func = UberHealSetButton5;
   myInfo.value = -2;
   if ( myInfo.value == selectedValue ) then
      myInfo.checked = -2;
   end
   UIDropDownMenu_AddButton(myInfo); 

   myInfo.text = "|c00C0C0C0Middle Mouse Button|r";
   myInfo.func = UberHealSetButton5;
   myInfo.value = -3;
   if ( myInfo.value == selectedValue ) then
      myInfo.checked = -3;
   end
   UIDropDownMenu_AddButton(myInfo); 

   myInfo.text = "|c00C0C0C0Right Mouse Button|r";
   myInfo.func = UberHealSetButton5;
   myInfo.value = -4;
   if ( myInfo.value == selectedValue ) then
      myInfo.checked = -4;
   end
   UIDropDownMenu_AddButton(myInfo); 

   myInfo.text = "|c00C0C0C0Mouse Button 4|r";
   myInfo.func = UberHealSetButton5;
   myInfo.value = -5;
   if ( myInfo.value == selectedValue ) then
      myInfo.checked = -5;
   end
   UIDropDownMenu_AddButton(myInfo); 

   myInfo.text = "|c00C0C0C0Mouse Button 5|r";
   myInfo.func = UberHealSetButton5;
   myInfo.value = -6;
   if ( myInfo.value == selectedValue ) then
      myInfo.checked = -6;
   end
   UIDropDownMenu_AddButton(myInfo); 


   UIDropDownMenu_SetSelectedValue(Spell5ButtonMenu, selectedValue);


end





function UberHealSetButton1()
UberHealConfig[UBERHEAL_PLAYERID]["Button1"] = this.value

   UIDropDownMenu_SetSelectedValue(Spell1ButtonMenu, this.value);
end

function UberHealSetButton2()

		DEFAULT_CHAT_FRAME:AddMessage("it says OOOOOO");


UberHealConfig[UBERHEAL_PLAYERID]["Button2"] = this.value

   UIDropDownMenu_SetSelectedValue(Spell2ButtonMenu, this.value);
end

function UberHealSetButton3()
UberHealConfig[UBERHEAL_PLAYERID]["Button3"] = this.value

   UIDropDownMenu_SetSelectedValue(Spell3ButtonMenu, this.value);
end

function UberHealSetButton4()
UberHealConfig[UBERHEAL_PLAYERID]["Button4"] = this.value

   UIDropDownMenu_SetSelectedValue(Spell4ButtonMenu, this.value);
end

function UberHealSetButton5()
UberHealConfig[UBERHEAL_PLAYERID]["Button5"] = this.value

   UIDropDownMenu_SetSelectedValue(Spell5ButtonMenu, this.value);
end


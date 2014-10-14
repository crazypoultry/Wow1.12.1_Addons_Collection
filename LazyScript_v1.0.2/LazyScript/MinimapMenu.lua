lazyScript.metadata:updateRevisionFromKeyword("$Revision: 746 $")

-- Minimap Button Handling

lazyScript.mm = {}


function lazyScript.mm.OnLoad()
   this:SetFrameLevel(this:GetFrameLevel()+1)
   this:RegisterForClicks("LeftButtonDown", "RightButtonDown")
   this:RegisterEvent("VARIABLES_LOADED")
end

function lazyScript.mm.OnClick(button)
   if (button == "LeftButton") then
      -- Toggle menu
      local menu = getglobal("LazyScriptMinimapMenu")
      menu.point = "TOPRIGHT"
      menu.relativePoint = "CENTER"
      ToggleDropDownMenu(1, nil, menu, "LazyScriptMinimapButton", -120, 0)
   end
end

function lazyScript.mm.OnEvent()
   lazyScript.mm.UpdateMinimap()
   if (lazyScript.perPlayerConf.mmIsVisible) then
      this:Show()
      LazyScriptMinimapButton:Show()
   else
      this:Hide()
      LazyScriptMinimapButton:Hide()
   end
end

function lazyScript.mm.OnEnter()
   GameTooltip:SetOwner(this, "ANCHOR_LEFT")
   GameTooltip:SetText(lazyScript.metadata.name)
   local defaultForm = lazyScript.perPlayerConf.defaultForm
   if (not defaultForm) then
      defaultForm = "(none)"
   end
   GameTooltip:AddLine("Current Form: "..defaultForm)
   GameTooltip:AddLine("Left-click to choose your form.")
   GameTooltip:AddLine("Right-click and drag to move this button.")
   GameTooltip:Show()
end

function lazyScript.mm.UpdateMinimap()
   lazyScript.mm.MoveButton()
   if (Minimap:IsVisible()) then
      LazyScriptMinimapButton:EnableMouse(true)
      LazyScriptMinimapButton:Show()
      LazyScriptMinimapFrame:Show()
   else
      LazyScriptMinimapButton:EnableMouse(false)
      LazyScriptMinimapButton:Hide()
      LazyScriptMinimapFrame:Hide()
   end
end

function lazyScript.mm.Menu_Initialize()
   if (not lazyScript.perPlayerConf) then
      -- just loading, skip it for now
      return
   end

   if (UIDROPDOWNMENU_MENU_LEVEL == 1) then

      local formNames = {}
      for form, actions in pairs(lazyScript.perPlayerConf.forms) do
         table.insert(formNames, form)
      end

      table.sort(formNames)

      local info = {}
      info.isTitle = 1
      info.text = lazyScript.metadata:getNameVersionRevisionString()
      UIDropDownMenu_AddButton(info)

      for idx, formName in ipairs(formNames) do
         local actions = lazyScript.perPlayerConf.forms[formName]
         local info = {}
         info.text = formName
         info.value = formName
         info.func = lazyScript.mm.Menu_ClickFunc(formName)
         info.checked = (lazyScript.perPlayerConf.defaultForm and lazyScript.perPlayerConf.defaultForm == formName)
         info.keepShownOnClick = 1
         info.hasArrow = 1
         info.tooltipTitle = formName
         info.tooltipText = ""
         for idx, action in ipairs(actions) do
            info.tooltipText = info.tooltipText.."\n- "..action
         end
         UIDropDownMenu_AddButton(info)
      end

      info = {}
      info.text = "< Create new form >"
      info.func = lazyScript.mm.Menu_ClickSubFunction("New")
      UIDropDownMenu_AddButton(info)

      info = {}
      info.text = "< Options >"
      info.value = "Options"
      info.keepShownOnClick = 1
      info.hasArrow = 1
      UIDropDownMenu_AddButton(info)

      if (lazyScript.CustomMenu ~= nil) then
         lazyScript.CustomMenu()
      end

      info = {}
      info.text = "< Immunity Options >"
      info.value = "ImmunityMenu"
      info.keepShownOnClick = 1
      info.hasArrow = 1
      UIDropDownMenu_AddButton(info)

      info = {}
      info.text = "< Cast Interrupt Options >"
      info.value = "Interrupts"
      info.keepShownOnClick = 1
      info.hasArrow = 1
      UIDropDownMenu_AddButton(info)

      info = {}
      info.text = "< Debugging >"
      info.value = "Debugging"
      info.keepShownOnClick = 1
      info.hasArrow = 1
      UIDropDownMenu_AddButton(info)

      info = {}
      info.text = "< Help >"
      info.func = lazyScript.mm.Menu_ClickSubFunction("Help")
      UIDropDownMenu_AddButton(info)

      info = {}
      info.text = "< About >"
      info.func = lazyScript.mm.Menu_ClickSubFunction("About")
      UIDropDownMenu_AddButton(info)

   elseif (UIDROPDOWNMENU_MENU_LEVEL == 2) then
      if (lazyScript.CustomMenu ~= nil) then
         lazyScript.CustomMenu()
      end

      if (UIDROPDOWNMENU_MENU_VALUE == "Options") then

         local info = {}
         info.isTitle = 1
         info.text = lazyScript.metadata.name.." Options"
         UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)

         local info = {}
         info.text = "Auto-Target"
         if (lazyScript.perPlayerConf.autoTarget) then
            info.checked = true
         end
         info.keepShownOnClick = 1
         info.func = lazyScript.mm.Menu_ClickSubFunction("AutoTarget")
         UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)

         local info = {}
         info.text = "... and initiate Auto-Attack"
         if (lazyScript.perPlayerConf.initiateAutoAttack) then
            info.checked = true
         end
         info.keepShownOnClick = 1
         info.func = lazyScript.mm.Menu_ClickSubFunction("InitiateAutoAttack")
         UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)

         local info = {}
         info.text = "Show Minion"
         if (lazyScript.perPlayerConf.minionIsVisible) then
            info.checked = true
         end
         info.keepShownOnClick = 1
         info.func = lazyScript.mm.Menu_ClickSubFunction("Show Minion")
         UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)

         local info = {}
         info.text = "... Only in combat"
         if (lazyScript.perPlayerConf.minionHidesOutOfCombat) then
            info.checked = true
         end
         info.keepShownOnClick = 1
         info.func = lazyScript.mm.Menu_ClickSubFunction("Show Minion in Combat")
         UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)

         -- Added by lokyst
         local info = {}
         info.text = "... Always show action"
         if (lazyScript.perPlayerConf.showActionAlways) then
            info.checked = true
         end
         info.keepShownOnClick = 1
         info.func = lazyScript.mm.Menu_ClickSubFunction("Always show action")
         UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)

         local info = {}
         info.text = "Show Deathstimator Minion"
         if (lazyScript.perPlayerConf.deathMinionIsVisible) then
            info.checked = true
         end
         info.keepShownOnClick = 1
         info.func = lazyScript.mm.Menu_ClickSubFunction("Show Death Minion")
         UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)

         local info = {}
         info.text = "... Only in combat"
         if (lazyScript.perPlayerConf.deathMinionHidesOutOfCombat) then
            info.checked = true
         end
         info.keepShownOnClick = 1
         info.func = lazyScript.mm.Menu_ClickSubFunction("Show Death Minion in Combat")
         UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)

         local info = {}
         info.isTitle = 1
         info.text = "Deathstimator sample window:"
         UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)

         for idx, i in ipairs({3, 5, 10, 15, 30, 60}) do
            local info = {}
            info.text = "... "..i.."s"
            if (lazyScript.perPlayerConf.healthHistorySize == i) then
               info.checked = true
            end
            info.keepShownOnClick = 1
            info.func = lazyScript.mm.Menu_ClickSubFunction("Deathstimate "..i)
            UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
         end


      elseif (UIDROPDOWNMENU_MENU_VALUE == "ImmunityMenu") then
         local info = {}
         info.isTitle = 1
         info.text = "Immunity Options"
         UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)

         local info = {}
         if (lazyScript.perPlayerConf.useImmunities) then
            info.text = "< Stop Immunity Tracking >"
         else
            info.text = "< Track New Immunities >"
         end
         info.func = lazyScript.mm.Menu_ClickSubFunction("Immunity")
         UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)

         local info = {}
         info.text = "< Edit Imunity Exception Criteria >"
         info.func = lazyScript.mm.Menu_ClickSubFunction("Global Immunity Criteria")
         UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)

      elseif (UIDROPDOWNMENU_MENU_VALUE == "Interrupts") then

         local info = {}
         info.isTitle = 1
         info.text = "Cast Interrupt Options"
         UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)

         local info = {}
         info.text = "< Edit Interrupt Exception Criteria >"
         info.func = lazyScript.mm.Menu_ClickSubFunction("Global Interrupt Criteria")
         UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)

         local info = {}
         info.isTitle = 1
         local lastInterrupted
         if (lazyScript.interrupt.lastSpellInterrupted) then
            lastInterrupted = lazyScript.interrupt.lastSpellInterrupted
         else
            lastInterrupted = "(none)"
         end
         info.text = "Last interrupted: "..lastInterrupted
         UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)

         local info = {}
         info.text = "< ... Don't interrupt it again >"
         info.func = lazyScript.mm.Menu_ClickSubFunction("noLongerInterruptLastInterrupted")
         UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)

      elseif (UIDROPDOWNMENU_MENU_VALUE == "Debugging") then

         local info = {}
         info.isTitle = 1
         info.text = "Debugging Options"
         UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)

         local info = {}
         info.text = "Log when target casts"
         if (lazyScript.perPlayerConf.showTargetCasts) then
            info.checked = true
         end
         info.keepShownOnClick = 1
         info.func = lazyScript.mm.Menu_ClickSubFunction("showTargetCasts")
         UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)

         local info = {}
         info.text = "Show why when -ifTargetCCd is true"
         if (lazyScript.perPlayerConf.showReasonForTargetCCd) then
            info.checked = true
         end
         info.keepShownOnClick = 1
         info.func = lazyScript.mm.Menu_ClickSubFunction("showReasonForTargetCCd")
         UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)

         local info = {}
         info.text = "Display \"Ganked\" info"
         if (lazyScript.perPlayerConf.showGankMessage) then
            info.checked = true
         end
         info.keepShownOnClick = 1
         info.func = lazyScript.mm.Menu_ClickSubFunction("showGankMessage")
         UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)

         local info = {}
         info.text = "< Action History >"
         info.value = "History"
         info.keepShownOnClick = 1
         info.hasArrow = 1
         UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)

         local info = {}
         info.text = "... Clear History after combat"
         if (lazyScript.perPlayerConf.clearHistoryAfterCombat) then
            info.checked = true
         end
         info.keepShownOnClick = 1
         info.func = lazyScript.mm.Menu_ClickSubFunction("clearHistoryAfterCombat")
         UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)

         local info = {}
         info.text = "Internal "..lazyScript.metadata.name.." debugging (noisy)"
         if (lazyScript.perPlayerConf.debug) then
            info.checked = true
         end
         info.keepShownOnClick = 1
         info.func = lazyScript.mm.Menu_ClickSubFunction("debug")
         UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)

      elseif (lazyScript.perPlayerConf.forms[UIDROPDOWNMENU_MENU_VALUE] ~= nil) then
         -- a submenu of a form
         local info = {}
         info.isTitle = 1
         info.text = UIDROPDOWNMENU_MENU_VALUE
         UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)

         for idx, op in ipairs({"Edit", "Copy", "Delete"}) do
            local info = {}
            info.text = "< "..op.." >"
            info.func = lazyScript.mm.Menu_ClickSubFunction(op, UIDROPDOWNMENU_MENU_VALUE)
            UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
         end

         info = {}
         info.text = "< Set Keybinding >"
         info.value = UIDROPDOWNMENU_MENU_VALUE
         info.keepShownOnClick = 1
         info.hasArrow = 1
         UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)

      end

   elseif (UIDROPDOWNMENU_MENU_LEVEL == 3) then
      if (lazyScript.CustomMenu ~= nil) then
         lazyScript.CustomMenu()
      end

      if (UIDROPDOWNMENU_MENU_VALUE == "History") then
         local info = {}
         info.isTitle = 1
         info.text = "Action History"
         UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)

         info = {}
         for idx, action in ipairs(lazyScript.actionHistory) do
            info.text = idx..". "..action
            UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
         end

      elseif (UIDROPDOWNMENU_MENU_VALUE ~= nil) then
         -- a keybinding submenu of a form
         local info = {}
         info.isTitle = 1
         info.text = "Set Keybinding"
         UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)

         info = {}
         for i = 1,10 do
            if lazyScript.perPlayerConf.BoundFormsTable[i] then
               info.text = i..": "..lazyScript.perPlayerConf.BoundFormsTable[i]
            else
               info.text = "Keybinding "..i
            end
            info.func = lazyScript.mm.Menu_SetKeyBindFunction(i, UIDROPDOWNMENU_MENU_VALUE)
            UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
         end
      end
   end


end

function lazyScript.mm.Menu_ClickFunc(form)
   return function()
             lazyScript.SlashCommand("default "..form)
             CloseDropDownMenus()
             LazyScriptMinimapButton:Click()
             -- This is a hack to deal with the code in UIDropDownMenu.lua.
             -- This makes it so if a button was already checked, it remains checked,
             -- which is what I want.
             if (this.checked) then
                this.checked = nil
             end
          end
end

function lazyScript.mm.Menu_SetKeyBindFunction(index, form)
   return function()
      if (not index) or (not form) then
         return
      end
      lazyScript.perPlayerConf.BoundFormsTable[index] = form
      lazyScript.p("Set keybinding "..index.." to form: "..form..".")
   end
end

function lazyScript.mm.Menu_ClickSubFunction(op, form)
   return function()
             if (not form) then
                form = ""
             end
             if (op == "New" or op == "Edit") then
                lazyScript.SlashCommand("edit "..form)
                CloseDropDownMenus()
             elseif (op == "Immunity") then
                lazyScript.SlashCommand("useImmunitiesList")
                CloseDropDownMenus()
                LazyScriptMinimapButton:Click()
             elseif (op == "Copy") then
                local newName
                for i = 1, 10 do
                   newName = form.."-"..i
                   if (not lazyScript.perPlayerConf.forms[newName]) then
                      lazyScript.SlashCommand("copy "..form.." "..newName)
                      break
                   end
                end
                CloseDropDownMenus()
                LazyScriptMinimapButton:Click()
             elseif (op == "Delete") then
                CloseDropDownMenus()
                StaticPopupDialogs["LAZYSCRIPT_DELETE_FORM"] = {
                   -- English is ok if no locale string is found
                   text = lazyScript.getLocaleString("DELETE_FORM", true),
                   button1 = TEXT(OKAY),
                   button2 = TEXT(CANCEL),
                   OnAccept = function()
                      lazyScript.SlashCommand("clear "..form)
                   end,
                   timeout = 0,
                   whileDead = 1,
                   exclusive = 1,
                   hideOnEscape = 1
                };
                StaticPopup_Show("LAZYSCRIPT_DELETE_FORM", form);

             elseif (op == "Help") then
                LazyScriptFormHelp:Show()

             elseif (op == "About") then
                lazyScript.SlashCommand("about")

             elseif (op == "AutoTarget") then
                lazyScript.SlashCommand("autoTarget")
                lazyScript.mm.RefreshMenu2("Options")

             elseif (op == "InitiateAutoAttack") then
                lazyScript.SlashCommand("initiateAutoAttack")
             elseif (op == "Show Minion") then
                if (lazyScript.perPlayerConf.minionIsVisible) then
                   lazyScript.SlashCommand("dismiss")
                else
                   lazyScript.SlashCommand("summon")
                end
             elseif (op == "Show Minion in Combat") then
                lazyScript.SlashCommand("hideMinionOutOfCombat")
             elseif (op == "Show Death Minion") then
                if (lazyScript.perPlayerConf.deathMinionIsVisible) then
                   lazyScript.SlashCommand("dismissDeath")
                else
                   lazyScript.SlashCommand("summonDeath")
                end
             elseif (op == "Always show action") then
                if (lazyScript.perPlayerConf.showActionAlways) then
                   lazyScript.perPlayerConf.showActionAlways = false
                   lazyScript.minion.SetText(lazyScript.perPlayerConf.defaultForm)
                else
                   lazyScript.perPlayerConf.showActionAlways = true
                   lazyScript.minion.OnUpdate()
                end
             elseif (op == "Show Death Minion in Combat") then
                lazyScript.SlashCommand("hideDeathMinionOutOfCombat")
             elseif (op == "Deathstimate 3") then
                lazyScript.perPlayerConf.healthHistorySize = 3
                lazyScript.mm.RefreshMenu("Options")
             elseif (op == "Deathstimate 5") then
                lazyScript.perPlayerConf.healthHistorySize = 5
                lazyScript.mm.RefreshMenu("Options")
             elseif (op == "Deathstimate 10") then
                lazyScript.perPlayerConf.healthHistorySize = 10
                lazyScript.mm.RefreshMenu("Options")
             elseif (op == "Deathstimate 15") then
                lazyScript.perPlayerConf.healthHistorySize = 15
                lazyScript.mm.RefreshMenu("Options")
             elseif (op == "Deathstimate 30") then
                lazyScript.perPlayerConf.healthHistorySize = 30
                lazyScript.mm.RefreshMenu("Options")
             elseif (op == "Deathstimate 60") then
                lazyScript.perPlayerConf.healthHistorySize = 60
                lazyScript.mm.RefreshMenu("Options")

             elseif (op == "Global Immunity Criteria") then
                lazyScript.SlashCommand("immunityExceptionCriteria")
             elseif (op == "Global Interrupt Criteria") then
                lazyScript.SlashCommand("interruptExceptionCriteria")
             elseif (op == "noLongerInterruptLastInterrupted") then
                lazyScript.SlashCommand("noLongerInterruptLastInterrupted")


             elseif (op == "debug") then
                lazyScript.SlashCommand("debug")
             elseif (op == "showTargetCasts") then
                lazyScript.SlashCommand("showTargetCasts")
             elseif (op == "showReasonForTargetCCd") then
                lazyScript.SlashCommand("showReasonForTargetCCd")
             elseif (op == "showGankMessage") then
                lazyScript.SlashCommand("showGankMessage")
             elseif (op == "clearHistoryAfterCombat") then
                lazyScript.SlashCommand("clearHistoryAfterCombat")

             end

          end
end

function lazyScript.mm.RefreshMenu(which)
   UIDropDownMenu_Initialize(LazyScriptMinimapMenu, lazyScript.mm.Menu_Initialize, which)
   -- again, a hack to deal with the code in UIDropDownMenu.lua.
   if (this.checked) then
      this.checked = nil
   end
end

function lazyScript.mm.RefreshMenu2(which)
   UIDropDownMenu_Initialize(LazyScriptMinimapMenu, lazyScript.mm.Menu_Initialize, which)
   -- again, a hack to deal with the code in UIDropDownMenu.lua.
   if (this.checked) then
      this.checked = nil
   else
      this.checked = true
   end
end

-- Thanks to Yatlas for this code
function lazyScript.mm.Button_BeingDragged()
    -- Thanks to Gello for this code
    local xpos,ypos = GetCursorPosition()
    local xmin,ymin = Minimap:GetLeft(), Minimap:GetBottom()

    xpos = xmin-xpos/UIParent:GetScale()+70
    ypos = ypos/UIParent:GetScale()-ymin-70

    lazyScript.mm.Button_SetPosition(math.deg(math.atan2(ypos,xpos)))
end

function lazyScript.mm.Button_SetPosition(v)
    if(v < 0) then
        v = v + 360
    end

    lazyScript.perPlayerConf.minimapButtonPos = v
    lazyScript.mm.MoveButton()
end

function lazyScript.mm.MoveButton()
   local where = lazyScript.perPlayerConf.minimapButtonPos
   LazyScriptMinimapFrame:ClearAllPoints()
   LazyScriptMinimapFrame:SetPoint("TOPLEFT", "Minimap", "TOPLEFT",
                                  52 - (80 * cos(where)),
                                  (80 * sin(where)) - 52)
end


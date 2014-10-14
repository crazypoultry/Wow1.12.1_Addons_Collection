lazyScript.metadata:updateRevisionFromKeyword("$Revision: 700 $")

-- Form Edit Box
lazyScript.formEditBox = {}

lazyScript.formEditBox.currentForm = nil
lazyScript.formEditBox.cancelEdit = false

function lazyScript.formEditBox.OnShow()
   if (not lazyScript.formEditBox.currentForm) then
      lazyScript.formEditBox.currentForm = ""
   end

   LazyScriptFormEditFrameFormName:SetText(lazyScript.formEditBox.currentForm)
   if (lazyScript.formEditBox.currentForm == "") then
      LazyScriptFormEditFrameFormName:SetFocus()
   else
      LazyScriptFormEditFrameForm:SetFocus()
   end

   local actions = lazyScript.perPlayerConf.forms[lazyScript.formEditBox.currentForm]
   local text
   if (actions) then
      text = table.concat(actions, "\n")
   else
      text = ""
   end
   LazyScriptFormEditFrameForm:SetText(text)
end

function lazyScript.formEditBox.OnHide()
   if (lazyScript.formEditBox.cancelEdit) then
      lazyScript.formEditBox.cancelEdit = false
      return
   end

   local name = LazyScriptFormEditFrameFormName:GetText()
   -- convert spaces to underscores
   name = string.gsub(name, "%s+", "_")

   local oldName = lazyScript.formEditBox.currentForm
   local text  = LazyScriptFormEditFrameForm:GetText()

   if (not name or name == "" or not text or text == "") then
      return
   end

   --lazyScript.SlashCommand("set "..name.." "..text)
   -- doing this manually (dup code alert! :-( ) so we can
   -- preserve comments or other goodies
   if (lazyScript.perPlayerConf.forms[name]) then
      verb = "updated"
   else
      verb = "created"
   end
   local lines = {}
   for line in string.gfind(text, "[^\r\n]+") do
      table.insert(lines, line)
   end
   lazyScript.perPlayerConf.forms[name] = lines
   lazyScript.ClearParsedForm(name)
   lazyScript.FindParsedForm(name)
   lazyScript.p("Form "..name.." "..verb..".")

   if (oldName and oldName ~= "" and name ~= oldName) then
      -- user changed the name
      if (lazyScript.perPlayerConf.defaultForm == oldName) then
         lazyScript.SlashCommand("default "..name)
      end
      lazyScript.SlashCommand("clear "..oldName)
   end

   lazyScript.formEditBox.currentForm = nil
end

function lazyScript.formEditBox.testForm()
   local name = LazyScriptFormEditFrameFormName:GetText() or ""
   lazyScript.p("Testing "..name.." form...")
   local text  = LazyScriptFormEditFrameForm:GetText()
   local lines = {}
   for line in string.gfind(text, "[^\r\n]+") do
      table.insert(lines, line)
   end
   lazyScript.ParseForm(name, lines)
   lazyScript.p("Testing completed.")
end



lazyScript.formHelp = {}
lazyScript.formHelp.tabHelpText = {}

function lazyScript.formHelp.OnLoad()
   PanelTemplates_SetNumTabs(LazyScriptFormHelp, 4)
   LazyScriptFormHelp.selectedTab = 1
   PanelTemplates_UpdateTabs(LazyScriptFormHelp)
end

function lazyScript.formHelp.OnTabButtonClick(tabId, tabName)
   --lazyScript.p("OnTabButtonClick "..tabId..": "..tabName)

   -- If help text has not been initialized yet, do so.
   if not lazyScript.formHelp.tabHelpText[tabName] then
      lazyScript.formHelp.SetupHelpText()
   end

   local text = lazyScript.formHelp.tabHelpText[tabName]
   LazyScriptFormHelpScrollFrameScrollChildText.currentText = text -- save it for forcing a relayout when resizing
   LazyScriptFormHelpScrollFrameScrollChildText:SetText(text)
   LazyScriptFormHelpScrollFrameScrollBar:SetValue(0);
   LazyScriptFormHelpScrollFrame:UpdateScrollChildRect()
end

function lazyScript.formHelp.SetupHelpText()
   lazyScript.formHelp.SetupOverview()
   lazyScript.formHelp.SetupActions()
   lazyScript.formHelp.SetupCriteria()
   lazyScript.formHelp.SetupBuffsDebuffs()
end

function lazyScript.formHelp.ColorizeBrackets(text)
   text = string.gsub(text, "{",  "|cffff6060{|r")
   text = string.gsub(text, "}",  "|cffff6060}|r")
   text = string.gsub(text, "%[", "|cff8080ff[|r")
   text = string.gsub(text, "%]", "|cff8080ff]|r")
   return text
end

function lazyScript.formHelp.SetupOverview()
   local text = "<HTML><BODY>"


 text = text..[[
<H1>Overview</H1>
<P>LazyScript is a scripting language for World of Warcraft that is able to execute certain attacks or abilities under conditions that you specify. This is accomplished by writing a "form", which consists of a series of actions and criteria. When the LazyScript macro is run, the LazyScript engine will read through the list of actions from top to bottom until it finds an action that is ready to be used and then executes it.</P>
<BR/>
<P>Any line may be commented out by placing '--', '//', or '#' at the start of the line.</P>
<BR/>
<H1>Tutorial 1: Baby steps</H1>
<P>For example, let us make LazyScript execute Sinister Strike. First, check what the short name is for Sinister Strike in the actions tab. We see that it is "ss". Now choose "Create New Form" from the LazyScript minimap menu. Give your form a name like "MyForm" and type:</P>
<BR/>
<P>|cffff770Css|r</P>
<BR/>
<P>Click on the "Test" button. If everything is okay and there were no typos, a "Testing completed" message will appear in your chat box. If there were errors, a summary of the error will be printed in the chat box instead. If everything is working then click on the "Okay" button. You should now see the form "MyForm" in the LazyScript minimap form list. Click on "MyForm" to set it as the default. A little check mark should appear next to "MyForm" on the minimap menu.</P>
<BR/>
<P>Now create a macro with the command:</P>
<BR/>
<P>|cffff770C/lazyscript|r</P>
<BR/>
<P>and place it on your action bar. Also place the highest rank of "Sinister Strike" on your action bar somewhere. The "Sinister Strike" action need not be visible. Now go out and fight something and hit your LazyScript macro key and LazyScript will automatically execute Sinister Strike.</P>
<BR/>
<H1>Tutorial 2: Now we're getting somewhere</H1>
<P>|cffffaaff"That's not particularly impressive"|r</P>
<P>Well, let us move onto something more interesting then. Let us include an action that we can not execute all the time like "Riposte". We always prefer to execute riposte rather than sinister strike, but riposte is not always usable. Edit "MyForm" and add riposte before sinister strike, like so:</P>
<BR/>
<P>|cffff770Criposte|r</P>
<P>|cffff770Css|r</P>
<BR/>
<P>and place Riposte on your action bar somewhere. Now when you hit the LazyScript macro during combat, LazyScript will execute Sinister Strike until you parry an attack. Once that happens, LazyScript will execute Riposte when you next hit the LazyScript macro button. Most importantly, it will do all this without the "That action is not ready yet" spam that you would normally have to put up with when using a standard macro.</P>
<BR/>
<H1>Tutorial 3: To do or not to do, that is the question</H1>
<P>One of the most useful features of LazyScript is the ability to associate conditions or criteria with a particular action. For example, you only want to kick the target if it is casting a spell. Looking at the criteria tab we notice that there is a condition "-if[Not]TargetIsCasting" plus some other scary looking stuff. Let us ignore the complicated stuff for now and just use "-ifTargetIsCasting". Interrupting a spell is more important than using Riposte, so edit "MyForm" and change it to:</P>
<BR/>
<P>|cffff770Ckick-ifTargetIsCasting|r</P>
<P>|cffff770Criposte|r</P>
<P>|cffff770Css|r</P>
<BR/>
<P>Now LazyScript will only kick if it detects that the target is casting a spell.</P>
<BR/>
<P>|cffffaaff"But what if I only want to interrupt fire spells?"|r</P>
<P>Well that is what the rest of that complicated string is all about. Edit "MyForm" and change the form to:</P>
<BR/>
<P>|cffff770Ckick-ifTargetIsCasting=FIRE|r</P>
<P>|cffff770Criposte|r</P>
<P>|cffff770Css|r</P>
<BR/>
<P>|cffffaaff"What about if I only want to interrupt fire or frost spells? Do I have to type that all out again?"|r</P>
<P>Nope, change "MyForm" to:</P>
<BR/>
<P>|cffff770Ckick-ifTargetIsCasting=FIRE,FROST|r</P>
<P>|cffff770Criposte|r</P>
<P>|cffff770Css|r</P>
<BR/>
<P>|cffffaaff"I'm decked out in MC gear. The only spells I care about interrupting are heals. Darn priests... *mutter*"|r</P>
<P>We have that covered too. Just use the full text string, correctly capitalized with spaces:</P>
<BR/>
<P>|cffff770Ckick-ifTargetIsCasting=Heal,Greater Heal|r</P>
<P>|cffff770Criposte|r</P>
<P>|cffff770Css|r</P>
<BR/>
<H1>Tutorial 4: Why'd you have to go and make things so complicated?</H1>
<P>Probably the most complex criteria you will come across are the buff/debuff checking criteria. They are so complex because they are so flexible. For instance, if you only want to renew your Slice and Dice if you do not already have it running. First check the Buff/Debuff tab and find out what the short buff/debuff name is for Slice and Dice. It is "snd", so add a line to your form that has:</P>
<BR/>
<P>|cffff770Csnd-ifNotPlayerHasBuff=snd|r</P>
<BR/>
<P>If you only want to use Rupture on your target if it does not already have rupture active:</P>
<BR/>
<P>|cffff770Crupture-ifNotTargetHasDebuff=rupture|r</P>
<BR/>
<P>|cffffaaff"Why don't I see buff/debuff xyz in your list?"|r</P>
<P>Although we try to be as thorough as possible with class abilities, if we were to have entries for every single buff in the game it would take up too much memory. If a buff is not in the list of recognised buffs/debuffs it is still possible to search for the title of the buff. Just use the following criteria and type in the full name of the buff or debuff with capitalization and spacing as it appears in the tooltip text:</P>
<BR/>
<P>|cffff770Cecho=w00t-ifPlayerHasBuffTitle=Rallying Cry of the Dragonslayer|r</P>
<BR/>
<P>|cffffaaff"My tanks are boring and they tell me not to start attacking the mob until they've sundered it a few times. Can LazyScript help me?"|r</P>
<P>LazyScript is also able to check how many applications of a buff or debufff there are. After prying out that by "few" they mean "at least 3", you can add something like this to the top of your form:</P>
<BR/>
<P>|cffff770CstopAll-ifTargetHasDebuff&lt;3=sunder|r</P>
<BR/>
<H1>Tutorial 5: Multi-tasking</H1>
<P>By now you may have noticed that some actions on the actions tab are colored green. Hopefully you read the help text and know that this has something to with multiple actions that do not trigger the global cooldown. What it boils down to is that you can chain any number of these actions together in one line along with at most one action that does trigger the global cooldown and LazyScript will execute them in sequence. For example, activate Cold Blood, use Eviscerate and provide a cute parting message:</P>
<BR/>
<P>|cffff770CcoldBlood-evisc-sayInSay=DIE!-ifCbKillShot|r</P>
<BR/>
<P>Here are a few more examples</P>
<BR/>
<P>|cffff770ChuntersMark-petAttack|r</P>
<P>|cffff770Cjudge-sealCommand|r</P>
<P>|cffff770CinnerFocus-greaterHeal|r</P>
<BR/>
<H1>Tutorial 6: Form re-use</H1>
<P>So you've written some forms and they're starting to get a little long and complicated. If they contain sections which are identical, you can separate that section out into another form and use |cffff770CincludeForm|r to include it in the other forms. For example:</P>
<BR/>
<P>Form "Interrupts":</P>
<P>|cffff770Ckick-ifTargetIsCasting-ifNotTargetIs=Stunned|r</P>
<P>|cffff770Cgouge-ifTargetIsCasting-ifNotInFrontAttackJustFailed-ifNotTargetIs=Stunned|r</P>
<P>|cffff770Cks-ifTargetIsCasting=Greater Heal,Prayer of Healing,Healing Touch,Holy Light,Healing Wave,Chain Heal-ifNotTargetIs=Stunned|r</P>
<P>|cffff770Cblind-ifTargetIsCasting=Greater Heal,Prayer of Healing,Healing Touch,Holy Light,Healing Wave,Chain Heal-ifNotTargetIs=Stunned|r</P>
<BR/>
<P>Form "FrontAttack":</P>
<P>|cffff770CincludeForm=Interrupts|r</P>
<P>|cffff770Criposte|r</P>
<P>|cffff770Cevisc-5cp|r</P>
<P>|cffff770Css|r</P>
<BR/>
<P>Form "BehindAttack":</P>
<P>|cffff770CincludeForm=Interrupts|r</P>
<P>|cffff770Cevisc-5cp|r</P>
<P>|cffff770Cbs|r</P>
<BR/>
<P>This will include the Interrupts form at the beginning of both the FrontAttack and BehindAttack forms as if you had copy and pasted it in there. When you change the contents of the Interrupts form, it will automatically update the FrontAttack and BehindAttack forms to include the new version.</P>
<BR/>
<P>|cffffff00Note:|r Be careful that you don't try to include a form into itself, or try to include a form which includes the first form (A includes B includes A). Those will cause a stack overflow error because they're infinite recursion loops.</P>
<BR/>
<P>Now perhaps you have some actions that you only want to perform under certain conditions but don't want the whole list of actions to be checked every time you press your LazyScript button. If we look at the previous example, we can see that ifTargetIsCasting is a criteria common to all of the actions in the Interrupts form. Using callForm we could rewrite the previous example like so:</P>
<BR/>
<P>Form "Interrupts":</P>
<P>|cffff770Ckick|r</P>
<P>|cffff770Cgouge-ifNotInFrontAttackJustFailed|r</P>
<P>|cffff770Cks-ifTargetIsCasting=Greater Heal,Prayer of Healing,Healing Touch,Holy Light,Healing Wave,Chain Heal|r</P>
<P>|cffff770Cblind-ifTargetIsCasting=Greater Heal,Prayer of Healing,Healing Touch,Holy Light,Healing Wave,Chain Heal|r</P>
<BR/>
<P>Form "FrontAttack":</P>
<P>|cffff770CcallForm=Interrupts-ifTargetIsCasting-ifNotTargetIs=Stunned|r</P>
<P>|cffff770Criposte|r</P>
<P>|cffff770Cevisc-5cp|r</P>
<P>|cffff770Css|r</P>
<BR/>
<P>Form "BehindAttack":</P>
<P>|cffff770CcallForm=Interrupts-ifTargetIsCasting-ifNotTargetIs=Stunned|r</P>
<P>|cffff770Cevisc-5cp|r</P>
<P>|cffff770Cbs|r</P>
<BR/>
<P>With these changes, when you execute FrontAttack or BehindAttack, it will call the Interrupts form only if the target is casting and not stunned. So if the target is not casting, it won't even check any of the actions/criteria in the Interrupts form.</P>
<BR/>
</BODY></HTML>]]

--[[

--]]
   text = lazyScript.formHelp.ColorizeBrackets(text)

   lazyScript.formHelp.tabHelpText["Overview"] = text
end

function lazyScript.formHelp.SetupActions()
   local text = "<HTML><BODY>"
   text = text.."<H1>List of known Spells/Actions</H1>"
   text = text.."<BR/><P>A specific spell rank can be directed at a particular unit using the syntax:</P>"
   text = text.."<P>|cffff770Caction|r[|cffff770C(rankXX)|r][|cffff770C@&lt;UnitId&gt;|r]</P>"
   text = text.."<BR/><P>The |cff00ffff&lt;UnitId&gt;|r can be any valid UnitId sequence as described in &lt;|cff8080ffhttp://www.wowwiki.com/UnitId|r&gt;. For example, @player, @pet, @target, @targettarget. Note that the rank of the spell must always appear before the '@' symbol.</P>"
   text = text.."<BR/><P>Actions in |cff40ff40green|r do not trigger the global cooldown. LazyScript is able to perform multiple of these actions on a single line provided that the line has at most one action that triggers the global cooldown.</P><BR/>"
   local actionList = {}
   for actionName, actionObj in pairs(lazyScript.actions) do
      local actionNameText = actionName
      if (actionObj.triggersGlobal == false) then
         actionNameText = "|cff40ff40"..actionNameText.."|r"
      end
      table.insert(actionList, "|cffffffff"..(lazyScript.actions[actionName]["name"]
            or lazyScript.actions[actionName]["code"]).."|r = "..actionNameText)
   end
   table.sort(actionList)
   text = text.."<H2>Full Name = Short Name</H2>"
   text = text.."<P>"..table.concat(actionList, "</P><P>").."</P>"
   text = text.."<BR/>"


   actionList = {}
   for actionName, actionObj in pairs(lazyScript.comboActions) do
      local actionNameText = actionName
      if (actionObj.triggersGlobal == false) then
         actionNameText = "|cff40ff40"..actionNameText.."|r"
      end
      table.insert(actionList, "|cffffffff"..(lazyScript.comboActions[actionName]["name"]
            or lazyScript.comboActions[actionName]["code"]).."|r = "..actionNameText)
   end
   table.sort(actionList)
   if table.getn(actionList) >= 1 then
      text = text.."<H2>Combo Actions</H2>"
      text = text.."<P>"..table.concat(actionList, "</P><P>").."</P>"
      text = text.."<BR/>"
   end

   actionList = {}
   for actionName, actionObj in pairs(lazyScript.shapeshift) do
      local actionNameText = actionName
      if (actionObj.triggersGlobal == false) then
         actionNameText = "|cff40ff40"..actionNameText.."|r"
      end
      table.insert(actionList, "|cffffffff"..(lazyScript.shapeshift[actionName]["name"]
            or lazyScript.shapeshift[actionName]["code"]).."|r = "..actionNameText)
   end
   table.sort(actionList)
   if table.getn(actionList) >= 1 then
      text = text.."<H2>Other Actions</H2>"
      text = text.."<P>"..table.concat(actionList, "</P><P>").."</P>"
      text = text.."<BR/>"
   end

   actionList = {}
   for actionName, actionObj in pairs(lazyScript.pseudoActions) do
      local actionNameText = actionName
      if (actionObj.triggersGlobal == false) then
         actionNameText = "|cff40ff40"..actionNameText.."|r"
      end
      table.insert(actionList, "|cffffffff"..(lazyScript.pseudoActions[actionName]["name"]
            or lazyScript.pseudoActions[actionName]["code"]).."|r = "..actionNameText)
   end
   table.sort(actionList)
   if table.getn(actionList) >= 1 then
      text = text.."<H2>Special Actions</H2>"
      text = text.."<P>"..table.concat(actionList, "</P><P>").."</P>"
      text = text.."<BR/>"
   end

   text = text.."<H2>Actions that take parameters</H2>"
   text = text..[[
<P>|cffffffffUse an action:|r<BR/> action=&lt;action/macro name&gt;</P>
<BR/>
<P>|cffffffffUse an action that does not trigger the global cooldown:|r<BR/> |cff40ff40freeAction|r=&lt;action/macro name&gt;</P>
<BR/>
<P>|cffffffffUse a pet action:|r<BR/> |cff40ff40petAction|r=&lt;action&gt;</P>
<BR/>
<P>|cffffffffUse an item in your equipment or inventory:|r<BR/> use=&lt;itemid/item name&gt;</P>
<BR/>
<P>|cffffffffUse an item only if it is equipped:|r<BR/> useEquipped=&lt;itemid/item name&gt;</P>
<BR/>
<P>|cffffffffUse an item in your equipment or inventory that does not trigger the global cooldown:|r<BR/> useFreeItem=&lt;itemid/item name&gt;</P>
<BR/>
<P>|cffffffffUse an item that does not trigger the global cooldown only if it is equipped:|r<BR/> useFreeEquippedItem=&lt;itemid/item name&gt;</P>
<BR/>
<P>|cffffffffApply an item weapon buff:|r<BR/> apply{MainHand,OffHand}Buff=&lt;itemid/item name&gt;</P>
<BR/>
<P>|cffffffffEquip a weapon in your main hand:|r<BR/> equipMainHand=&lt;itemid/item name&gt;</P>
<BR/>
<P>|cffffffffEquip a weapon in your off hand:|r<BR/> equipOffHand=&lt;itemid/item name&gt;</P>
<BR/>
<P>|cffffffffEcho the message to your chat:|r<BR/> |cff40ff40echo|r=&lt;message&gt;</P>
<BR/>
<P>|cffffffffSay the message in the specified channel:|r<BR/> |cff40ff40sayIn{|cff40ff40Emote, Guild, Minion, Party, Raid, RAID_WARNING, Say, Yell|r}|cff40ff40|r=&lt;message&gt;</P>
<BR/>
<P>|cffffffffWhisper the message to the specified player or unitId:|r<BR/> |cff40ff40whisperTo|r{|cff40ff40playerName, |cff00ffff&lt;UnitId&gt;|r}|cff40ff40|r=&lt;message&gt;</P>
<BR/>
<P>|cffffffffCancel the specified buff:|r<BR/> |cff40ff40cancelBuff|r=&lt;buff&gt;</P>
<BR/>
<P>|cffffffffCancel the specified buff by title:|r<BR/> |cff40ff40cancelBuffTitle|r=&lt;buffTitle&gt;</P>
<BR/>
<P>|cffffffffSet the specified form as the default:|r<BR/> |cff40ff40setForm|r=&lt;form name&gt;</P>
<BR/>
<P>|cffffffffTarget a specific unit:|r<BR/> |cff40ff40targetUnit|r=|cff00ffff&lt;UnitId&gt;|r</P>
<BR/>
<P>|cffffffffCast a spell on a specific unit:|r<BR/> |cff40ff40spellTargetUnit|r=|cff00ffff&lt;UnitId&gt;|r</P>
<BR/>
<P>|cffffffffTarget a player/creature by their exact name:|r<BR/> |cff40ff40targetByName|r=&lt;exact name&gt;</P>
<BR/>
<P>|cffffffffPerform emote (See |cff8080ffhttp://www.wowwiki.com/API_TYPE_Emotes_Token|r|cffffffff):|r<BR/> |cff40ff40doEmote|r=&lt;emoteToken&gt;</P>
<BR/>
<P>|cffffffffPlay sound (See |cff8080ffhttp://www.wowwiki.com/API_PlaySound|r|cffffffff):|r<BR/> |cff40ff40playSound|r=&lt;soundName&gt;</P>
<BR/>
<H2>Meta-Actions</H2>
<P>|cffffffffInclude the contents of the specified form:|r<BR/> includeForm=&lt;form name&gt;<BR/><BR/>
|cffffff00Note:|r This does not accept criteria. It must appear on a line by itself. You cannot include a form in itself,
nor should you include a form which includes another form which includes the first (e.g. form A includes form B includes
form A == BAD).</P><BR/>
<P>|cffffffffCall the specified form:|r<BR/> callForm=&lt;form name&gt;<BR/><BR/>
This will try to find a usable action in the specified form, if the criteria on the callForm action are satisfied.</P>
<BR/>
   ]]

   if (lazyScript.CustomActionHelp) then
      text = text..lazyScript.CustomActionHelp()
   end

   text = text.."<BR/></BODY></HTML>"

   text = lazyScript.formHelp.ColorizeBrackets(text)
   lazyScript.formHelp.tabHelpText["Actions"] = text
end

function lazyScript.formHelp.SetupCriteria()
   local text = "<HTML><BODY>"
   text = text.."<H1>List of recognised criteria</H1>"
   text = text.."<BR/><P>Append zero or more criteria to an action.  All criteria must be true for that action to be used.  List your actions one after another on separate lines.  The first action that matches all criteria is used.</P>"
   text = text.."<BR/><P>Multiple values within curly braces ({}) means choose one or more.  If more than one is chosen, separate them with commas (e.g. ifRace=Human,Gnome) and the criteria will match if any of the choices match.  If a multiple-choice criteria is negated with a \"Not\" (e.g. ifNotRace=Human,Gnome) then the criteria will match only if none of the choices match.  Square brackets ([]) mean the value is optional.  Do NOT leave the curly braces or square brackets in your form.</P>"
   text = text..[[<BR/>
<H2>Action Criteria:</H2>
<P>-everyXXs</P>
<P>-if[Not]{Ctrl,Alt,Shift}Down |cffffff00(see note #1)|r</P>
<P>-if[Not]Cooldown{&lt;,&gt;}XXs={action1,action2,...}</P>
<P>-if[Not]CurrentAction[=action1,action2,...]</P>
<P>-if[Not]GlobalCooldown |cffffff00(see note #8)</P>
<P>-if[Not]History{&lt;,=,&gt;}XX=action</P>
<P>-if[Not]HistoryCount{&lt;,=,&gt;}XX=action</P>
<P>-if[Not]LastAction=action</P>
<P>-if[Not]LastUsed&gt;XXs=action |cffffff00(see note #10)|r</P>
<P>-if[Not]InCooldown={action1,action2,...}</P>
<P>-if[Not]InRange={action1,action2,...} |cffffff00(see note #2)|r</P>
<P>-if[Not]Timer&gt;XXs=action |cffffff00(see note #10)|r</P>
<P>-if[Not]Usable={action1,action2,...} |cffffff00(see note #7)|r</P>
<BR/>
<H2>Attack Criteria:</H2>
<P>-if[Not]BehindAttackJustFailed[X[.Y]s] |cffffff00(see note #3)|r</P>
<P>-if[Not]InFrontAttackJustFailed[X[.Y]s] |cffffff00(see note #3)|r</P>
<P>-if[Not]OutdoorsAttackJustFailed[X[.Y]s] |cffffff00(see note #3)|r</P>
<P>-if[Not]Casting</P>
<P>-if[Not]Channelling</P>
<P>-if[Not]Shooting</P>
<P>-if[Not]Wanding</P>
<BR/>
<H2>Buff/Debuff Criteria:</H2>
<P>-if[Not]{Buff,Debuff}Duration{&lt;,&gt;}XXs={buff1,buff2,...} |cffffff00(player only)|r</P>
<P>-if[Not]{Buff,Debuff}TitleDuration{&lt;,&gt;}XXs={buffTitle1,buffTitle2,...} |cffffff00(see note #4, player only)|r</P>
<P>-if[Not][|cff00ffff&lt;UnitId&gt;|r]Has{Buff,Debuff}[{&lt;,=,&gt;}XX]={buff1,buff2,...} |cffffff00(see notes #5 and #9)|r</P>
<P>-if[Not][|cff00ffff&lt;UnitId&gt;|r]Has{Buff,Debuff}Title[{&lt;,=,&gt;}XX]={buffTitle1,buffTitle2,...} |cffffff00(see notes #4, #5, and #9)|r</P>
<P>-if[Not][|cff00ffff&lt;UnitId&gt;|r]Is={Asleep, Bleeding, CCd, Charmed, Cursed, Diseased, Disoriented, Dotted, Drinking, Eating, Feared, Immobile, Incapacitated, Magicked, Poisoned, Polymorphed, Slowed, Stunned, Stung} |cffffff00(see note #9)|r</P>
<P>-if[Not]{MainHand, OffHand}Buffed</P>
<BR/>
<H2>Item Criteria:</H2>
<P>-if[Not]ItemCooldown{&lt;,&gt;}XXs={item1,item2,...}</P>
<P>-if[Not]ItemInCooldown={item1,item2,...}</P>
<BR/>
<H2>Player Criteria:</H2>
<P>-if[Not]Dueling</P>
<P>-if[Not]Equipped=item</P>
<P>-if[Not]Ganked</P>
<P>-if[Not]InGroup |cffffff00(party or raid)|r</P>
<P>-if[Not]InInstance</P>
<P>-if[Not]InBattleground</P>
<P>-if[Not]InRaid</P>
<P>-if[Not]Mounted</P>
<P>-if[Not]Shadowmelded</P>
<P>-if[Not]Tracking={Herbs, Minerals, Treasure}</P>
<P>-if[{&lt;,=,&gt;}]XAttackers |cffffff00(PvP only)|r</P>
<P>-if[Not]Zone=zonename</P>
<BR/>
<H2>Pet:</H2>
<P>-if[Not]HasPet</P>
<P>-if[Not]PetAlive</P>
<P>-if[Not]Pet{Attacking, Following, Staying, Aggressive, Defensive, Passive}</P>
<P>-if[Not]PetFamily={Bat, Bear, Boar, Carrion Bird, Cat, Crab, Crocolisk, Doomguard, Felhunter, Gorilla, Hyena, Imp, Infernal, Owl, Raptor, Scorpid, Spider, Succubus, Tallstrider, Turtle, Voidwalker, Windserpent, Wolf}</P>
<P>-if[Not]PetName=name</P>
<BR/>
<H2>Player, Pet or Target Criteria:</H2>
<P>-if[Not]{[Player],Target}{Blocked, Dodged, Parried, Resisted}[{&lt;,&gt;}XX.XXs] |cffffff00(defaults to &lt;5s, see note #11)|r</P>
<P>-if[Not]{[Player],Target}FlaggedPVP</P>
<P>-if[Not]{[Player],Target}FlagRunner</P>
<P>-if[Not]{[Player],Pet,Target}InCombat</P>
<P>-if[|cff00ffff&lt;UnitId&gt;|r]{&lt;,=,&gt;}XX[%]{hp,mana/energy/rage/focus}[Deficit] |cffffff00(see note #9)|r</P>
<P>-if[Not]{[Player],Target}Race={Human, Night Elf, Gnome, Dwarf, Orc, Scourge/Undead, Tauren, Troll}</P>
<BR/>
<H2>Target Criteria:</H2>
<P>-if[Not]CanDebuff</P>
<P>-if[Not]HaveTarget</P>
<P>-if[Not]TargetAlive</P>
<P>-if[Not]TargetAttackable</P>
<P>-if[Not]TargetBoss</P>
<P>-if[Not]TargetClass={Druid, Hunter, Mage, Paladin, Priest, Rogue, Shaman, Warlock, Warrior}</P>
<P>-if[Not]TargetElite</P>
<P>-if[Not]TargetEnemy</P>
<P>-if[Not]TargetFleeing |cffffff00(NPC only)|r</P>
<P>-if[Not]TargetFriend</P>
<P>-if[Not]TargetHasTarget</P>
<P>-if[Not]TargetHostile</P>
<P>-if[Not]TargetIsCasting[={name regex,FIRE,FROST,NATURE,SHADOW,ARCANE,HOLY}]</P>
<P>-if[Not]TargetImmune[=action]</P>
<P>-if[Not]TargetInBlindRange |cffffff00(Within 10 yards)|r</P>
<P>-if[Not]TargetInLongRange |cffffff00(Within 28 yards)|r</P>
<P>-if[Not]TargetInMediumRange |cffffff00(Within 10 yards)|r</P>
<P>-if[Not]TargetInMeleeRange |cffffff00(see note #6)|r</P>
<P>-if[Not]TargetLevel{&lt;,=,&gt;}XX |cffffff00(Does not work for bosses)|r</P>
<P>-if[Not]TargetMyLevel{&lt;,=,&gt;}{plus,minus}XX |cffffff00(Does not work for bosses)|r</P>
<P>-if[Not]TargetNamed={regex1,regex2,...}</P>
<P>-if[Not]TargetNPC</P>
<P>-if[Not]TargetOfTarget</P>
<P>-if[Not]TargetOfTargetClass={Druid, Hunter, Mage, Paladin, Priest, Rogue, Shaman, Warlock, Warrior}</P>
<P>-if[Not]TargetTrivial</P>
<P>-if[Not]TargetType={Beast, Critter, Demon, Dragonkin, Elemental, Humanoid, Undead}</P>
<P>-ifTimeToDeath{&lt;,=,&gt;}XXs</P>
<BR/>
]]

   -- Only criteria need special help text
   if (lazyScript.CustomHelp) then
      text = text..lazyScript.CustomHelp()
   end

   text = text..[[<BR/>
<P>|cffffff00Note 1:|r To use -if{Ctrl,Alt,Shift}Down, you MUST remove any existing Ctrl/Alt/Shift key bindings from the Main Menu, Key Bindings. Otherwise the game will intercept the key and LazyScript will not see it.</P>
<BR/>
<P>|cffffff00Note 2:|r Always use with -if[Not]TargetFriend since it will return true if the target is not a valid target for the spell.</P>
<BR/>
<P>|cffffff00Note 3:|r Within X.Y sec, defaults to 0.3.</P>
<BR/>
<P>|cffffff00Note 4:|r The buff/debuff name must be the full name (including capitalization and spaces) of the buff/debuff title as it appears in the tooltip.</P>
<BR/>
<P>|cffffff00Note 5:|r XX refers to the number of buff/debuff applications. e.g. -ifTargetHasDebuff&lt;5=sunder</P>
<BR/>
<P>|cffffff00Note 6:|r As of patch 1.12 this only works on unfriendly targets for Rogue (Sinister Strike), Druid (Growl), Hunter (Wing Clip) and Warrior (Rend).</P>
<BR/>
<P>|cffffff00Note 7:|r The ifUsable criteria checks if the action is valid for use at present as per the Blizzard API call IsUsableAction. This does not include cooldown or range checking.</P>
<BR/>
<P>|cffffff00Note 8:|r The ifGlobalCooldown criteria requires a specific action to be placed on your action bar so that it may be checked for the global cooldown. It does not have to be on a visible action bar. For each class, the actions are as follows:</P>
<BR/>
<P>Rogue: |cffffffffSinister Strike|r<BR/>
Druid: |cffffffffMark of the Wild|r<BR/>
Hunter: |cffffffffTrack Beasts|r<BR/>
Priest: |cffffffffPower Word: Fortitude|r<BR/>
Warrior: |cffffffffBattle Shout|r<BR/>
Mage: |cffffffffFrost Armor|r<BR/>
Warlock: |cffffffffDemon Skin|r<BR/>
Shaman: |cffffffffRockbiter Weapon|r<BR/>
Paladin: |cffffffffSeal of Righteousness|r</P>
<BR/>
<P>|cffffff00Note 9:|r The |cff00ffff&lt;UnitId&gt;|r can be any valid UnitId sequence as described in &lt;|cff8080ffhttp://www.wowwiki.com/UnitId|r&gt;. For example, player, pet, target, targettarget. Capitalization is not important.</P>"
<BR/>
<P>|cffffff00Note 10:|r The ifLastUsed timer will perform the action immediately at the start of combat or if you changed targets if the action is available. The ifTimer criteria will first countdown XX seconds after initiating combat or changing targets before performing the action for the first time.</P>"
<BR/>
<P>|cffffff00Note 11:|r This criteria only detects full blocks and resists. A partial block or resist ("Joe hits you for 10 damage (5 blocked).") either on the player or the target will NOT be detected by this criteria.</P>"
<BR/>
]]
   text = text.."</BODY></HTML>"


   text = lazyScript.formHelp.ColorizeBrackets(text)

   lazyScript.formHelp.tabHelpText["Criteria"] = text
end

function lazyScript.formHelp.SetupBuffsDebuffs()
   local text = "<HTML><BODY>"
   text = text.."<H1>List of known Buffs/Debuffs</H1>"
   text = text.."<BR/><P>Used with \"if[Not]{Player,Pet,Target}Has{Buff,Debuff}\" and \"if[Not]{Buff,Debuff}Duration{&lt;,&gt;}XXs\".</P><BR/>"
   text = text.."<H2>Full Name = Short Name</H2>"
   local buffList = {}
   for buffName in pairs(lazyScript.buffTable) do
      table.insert(buffList, "|cffffffff"..lazyScript.safeString(lazyScript.buffTable[buffName]["name"]).."|r = "..buffName)
   end
   table.sort(buffList)

   text = text.."<P>"..table.concat(buffList, "</P><P>").."</P>"
   text = text.."<BR/></BODY></HTML>"

   lazyScript.formHelp.tabHelpText["Buffs/Debuffs"] = text
end

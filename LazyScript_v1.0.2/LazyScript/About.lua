lazyScript.metadata:updateRevisionFromKeyword("$Revision: 712 $")

lazyScript.about = {}
lazyScript.about.tabText = {}

function lazyScript.about.ScrollFrame_OnSizeChanged()
   this:GetScrollChild():SetWidth(this:GetWidth()+40)
   if this:GetScrollChild().currentText then
     this:GetScrollChild():SetText(this:GetScrollChild().currentText)
     this:UpdateScrollChildRect()
   end
end

function lazyScript.about.OnLoad()
   PanelTemplates_SetNumTabs(LazyScriptAboutFrame, 2)
   LazyScriptAboutFrame.selectedTab = 1
   PanelTemplates_UpdateTabs(LazyScriptAboutFrame)
end

function lazyScript.about.OnShow()
   PanelTemplates_SetTab(LazyScriptAboutFrame, 1)
   lazyScript.about.OnTabButtonClick("LazyScriptAboutFrameTab1", LazyScriptAboutFrameTab1:GetText())
end

function lazyScript.about.OnTabButtonClick(tabId, tabName)
   --lazyScript.p("OnTabButtonClick "..tabId..": "..tabName)

   -- If help text has not been initialized yet, do so.
   if not lazyScript.about.tabText[tabName] then
      lazyScript.about.SetupTabText()
   end

   local text = lazyScript.about.tabText[tabName]
   LazyScriptAboutFrameScrollFrameText.currentText = text -- save it for forcing a relayout when resizing
   LazyScriptAboutFrameScrollFrameText:SetText(text)
   LazyScriptAboutFrameScrollFrameScrollBar:SetValue(0);
   LazyScriptAboutFrameScrollFrame:UpdateScrollChildRect()
end

function lazyScript.about.SetupTabText()
   lazyScript.about.SetupAboutText()
   lazyScript.about.SetupContributorsText()
end

function lazyScript.about.SetupAboutText()
   local text = [[<HTML><BODY><H1 ALIGN="CENTER">${title}</H1>
<H2 ALIGN="CENTER">"All the rope you need..."</H2>
<BR/>
<P ALIGN="CENTER">Brought to you by:<BR/>
lokyst<BR/>
dOxxx<BR/>
Nelar<BR/>
and Ithilyn</P>
<BR/>
<P ALIGN="CENTER">With significant contributions by:<BR/>
FreeSpeech</P>
<BR/>
<P ALIGN="CENTER">To use LazyScript, place a macro with the following on your action bar
and repeatedly hit the macro in battle:</P>
<BR/>
<P ALIGN="CENTER">|cffff8040${slashCmd}|r</P>
<BR/>
<P ALIGN="CENTER">Please see the following websites for documentation, discussion and new releases:<BR/>
<BR/>
|cff6060ff http://www.ithilyn.com/ |r <BR/>
|cff6060ff http://ui.worldofwar.net/ui.php?id=1574 |r <BR/>
|cff6060ff http://code.google.com/p/lazyscript/ |r </P>
</BODY></HTML>
]]

   text = string.gsub(text, "${title}", lazyScript.metadata:getNameVersionRevisionString())
   text = string.gsub(text, "${slashCmd}", SLASH_LAZYSCRIPT1)

   lazyScript.about.tabText["About"] = text
end

function lazyScript.about.SetupContributorsText()
   local contributors = {
      "Tannon",
      "Sketchy",
      "Karl The Pagan",
      "Tragath",
      "LunaEclipse",
      "Highend",
   }
   table.sort(contributors)


   local text = [[<HTML><BODY><H1 ALIGN="CENTER">LazyContributors</H1>
<H2 ALIGN="CENTER">"All the testing we need..."</H2>
<BR/>
<P>
Many thanks to:<BR/>
${contributors}.
</P>
</BODY></HTML>
]]

   text = string.gsub(text, "${contributors}", table.concat(contributors, ", "))
   lazyScript.about.tabText["Contributors"] = text
end

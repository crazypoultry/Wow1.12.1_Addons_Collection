-----------------------------------------------------------------------------
-- BookwormViewFrame.lua
--
-- Author: Daniel Stephens <daniel@vigilance-committee.org>
-- Author: Iriel <iriel@vigilance-committee.org>
--
-- Handler for view frame
---------------------------------------------------------------------------

-- Disable hack for 1.7 since it shouldn't be necessary
local hyperHack = false;

---------------------------------------------------------------------------
-- Frame view implementation

local MATERIAL_CORNERS = {'TopLeft', 'TopRight', 'BotLeft', 'BotRight'};

Bookworm.FrameViewBase = Bookworm.ViewBase:new();
local FrameViewBase = Bookworm.FrameViewBase;

function FrameViewBase:new(frame)
   local newObj = {};
   setmetatable(newObj, { __index = self });
   newObj.frame = frame;
   return newObj;
end

function FrameViewBase:setup()
   local frameName = self.frame:GetName();
   -- Get material frames
   self.mframes = {};
   for k,v in MATERIAL_CORNERS do
      self.mframes[v] = getglobal(frameName .. 'Material' .. v);
   end
   self.titleframe = getglobal(frameName .. 'TitleText');
   self.curpagetext = getglobal(frameName .. 'CurrentPage');
   self.statusbar = getglobal(frameName .. 'StatusBar');
   self.button = {};
   self.button.next = getglobal(frameName .. 'NextPageButton');
   self.button.prev = getglobal(frameName .. 'PrevPageButton');

   local vf = {};
   local sfName = frameName .. "ScrollFrame";
   vf.scroll = getglobal(sfName);
   vf.scrollbar = getglobal(sfName .. "ScrollBar");
   vf.page = getglobal(sfName .. "ScrollChildPageText");
   self.viewframes = vf;

   vf.scroll.scrollBarHideable = 1;
   vf.scrollbar:Hide();
   
   Bookworm.AddListener(self);
end

function FrameViewBase:initView(title)
   self.curTitle = title;
   self.titleframe:SetText(title);
   self.curpagetext:Hide();
   self.statusbar:Hide();
   for k,v in self.button do
      v:Hide();
   end
   local vf = self.viewframes;
   vf.scroll:Hide();
   vf.scrollbar:SetValue(0);
   vf.scroll:UpdateScrollChildRect();
   vf.page:SetText("");
end

function FrameViewBase:setMaterial(material)
   if ( not material ) then
      material = "Parchment";
   elseif (MATERIAL_TEXT_COLOR_TABLE[material] == nil) then
      material = "Parchment";
   end
   local textColor = MATERIAL_TEXT_COLOR_TABLE[material];
   local vf = self.viewframes;
   vf.page:SetTextColor(textColor[1], textColor[2], textColor[3]);
   
   if ( material == "Parchment" ) then
      for k,v in self.mframes do
	 v:Hide();
      end
   else
      for k,v in self.mframes do
	 v:SetTexture("Interface\\ItemTextFrame\\ItemText-"
		      .. material .. "-" .. k);
	 v:Show();
      end
   end
end

local HTML_ESCAPES = {
   ['<'] = '&lt;',
   ['>'] = '&gt;',
   ['&'] = '&amp;',
   ['\n'] = '<br/>'
};

local function HTMLReplace(x)
   return HTML_ESCAPES[x] or '?';
end

-- This nastiness now appears necessary to avoid an irritating formatting
-- problem
local function HTMLify(txt)
   if (string.find(txt, "^<[Hh][Tt][mM][lL]")) then
      return txt;
   end
   if (not string.find(txt, "\124H")) then
      return txt;
   end

   --txt = string.gsub(txt, "[ \t]+\n", "\n");
   --txt = string.gsub(txt, "\n+$", "");
   --txt = string.gsub(txt, "\n\n", "\n|r\n");
   --txt = string.gsub(txt, "\n\n", "\n|r\n");
   txt = string.gsub(txt, "[<>&\n]", HTMLReplace);

   return "<html><body><p>" .. txt .. "</p></body></html>";
end

function FrameViewBase:display()
   local cur = self.content;
   self.missedRefresh = nil;

   if (cur == nil) then
      HideUIPanel(self.frame);
      return;
   end

   if (cur.title ~= self.curTitle) then
      self:initView(cur.title);
   end

   local page = self:getPage();
   
   self:setMaterial(cur:getPageMaterial(page));

   local v = self.viewframes;

   local viewType = "normal";
   -- Pick which frame to make visible
   local plainFont = BookwormBooks[BookwormConstant.PLAIN_FONT_KEY];
   if (plainFont) then 
      v.page:SetFontObject(BookwormPlainFont);
   else
      v.page:SetFontObject(ItemTextFontNormal);
   end;

   -- Disabled nasty left align hack - should be fixed now
   v.page:SetText("<HTML><BODY><P align=\"left\"></P></BODY></HTML>");
   local pgText = cur:getPageContent(page);
   pgText = HTMLify(pgText);
   v.scroll:Hide();
   v.page:SetText(pgText);
   v.scrollbar:SetValue(0);
   v.scroll:UpdateScrollChildRect();
   v.scroll:Show();
   
   local pageLabel = cur:getPageLabel(page);
   if (pageLabel ~= nil) then
      self.curpagetext:SetText(cur:getPageLabel(page));
      self.curpagetext:Show();
   else 
      self.curpagetext:Hide();
   end
		
   if ( page > cur.minPage ) then
      self.button.prev:Show();
   else
      self.button.prev:Hide();
   end
   
   if ( page < cur.maxPage ) then
      self.button.next:Show();
   else
      self.button.next:Hide();
   end

   ShowUIPanel(self.frame);
   Bookworm_ViewHack();
end

function FrameViewBase:refresh()
   if (self.frame:IsVisible()) then
      self:display();
   elseif (self.content ~= nil) then
      self.missedRefresh = true;
   end
end

function FrameViewBase:checkRefresh()
   if (self.frame:IsVisible()) then
      if (self.missedRefresh) then
	 self:display();
      end
   end
end

function FrameViewBase:notify()
   self:refresh();
end

---------------------------------------------------------------------------
-- Page event handlers

function Bookworm_ViewHack_OnUpdate()
   -- This bizzare piece of code appears to be necessary to get hyperlinks
   -- to work, without it they fail the very first time the page is
   -- displayed. I dont know why, so this reloads that page once.
   if (hyperHack and Bookworm.DEFAULT_VIEW:getContent()) then
      Bookworm.DEFAULT_VIEW:display();
      hyperHack = false;
      this:Hide();
   end
end

function Bookworm_ViewHack()
   if (hyperHack) then
      BookwormViewHackFrame:Show();
   end
end

function Bookworm_View_OnLoad()
   -- Register this panel with the UIParent
   UIPanelWindows[this:GetName()] = 
      { area = "left", pushable = 1 };

   local newFrame = Bookworm.FrameViewBase:new(this);
   newFrame:setup();
   this.viewObj = newFrame;

   Bookworm.DEFAULT_VIEW = newFrame;
end

function Bookworm_View_OnHide()
   HideUIPanel(this);
end

function Bookworm_View_OnShow()
   local view = this.viewObj;
   view:checkRefresh();
end

function Bookworm_View_NextPage()
   local view = this:GetParent().viewObj;
   view:setPage(view:getPage() + 1);
end

function Bookworm_View_PrevPage()
   local view = this:GetParent().viewObj;
   view:setPage(view:getPage() - 1);
end

function Bookworm_View_Hyperlink(href)
   -- ScrollChild - ScrollFrame - MainFrame
   local view = this:GetParent():GetParent():GetParent().viewObj;
   if (not view:resolveHref(href)) then
      Bookworm.Notify("UnknownHyperlink", href);
   end
end

function Bookworm_View_Back()
   local view = this:GetParent().viewObj;
   view:back(1);
end

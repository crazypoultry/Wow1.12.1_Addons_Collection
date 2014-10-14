------------------------------------------------------------------------------
-- BookwormView.lua
--
-- Author: Daniel Stephens <daniel@vigilance-committee.org>
-- Author: Iriel <iriel@vigilance-committee.org>
--
-- Basic implementation of bookworm view object
---------------------------------------------------------------------------

Bookworm.ViewBase = {
   page = 0;
};
local ViewBase = Bookworm.ViewBase;

function ViewBase:new()
   -- Construct the new object and give it all of the base methods
   local newObj = {};
   setmetatable(newObj, { __index = self });

   return newObj;
end

function ViewBase:getPage()
   return self.page;
end

function ViewBase:setPage(page)
   local content = self.content;
   if (not content) then
      return;
   end
   page = math.floor(page);
   if (page > content.maxPage) then
      page = content.maxPage;
   end
   if (page < content.minPage) then
      page = content.minPage;
   end
   self.page = page;
   self:display();
end

function ViewBase:getContent(stepsBack,forceRef)
   if ((not stepsBack) or (stepsBack < 1)) then
      if (forceRef and self.contentRef) then
	 return self.contentRef, self.page;
      end
      return self.content, self.page;
   end
   local history = self.history;
   if (not history) then
      return nil,0
   end
   local histSize = table.getn(history);
   if (stepsBack > histSize) then
      return nil,0;
   end
   local histEntry = history[histSize - stepsBack + 1];
   if (histEntry.ref) then
      return histEntry.ref, histEntry.page;
   else
      return histEntry.content, histEntry.page;
   end
end

function ViewBase:show(newContent, newPage, flushStack)
   local newRef;
   if (newContent and newContent.getContent) then
      newRef = newContent;
      newContent = newRef:getContent();
   end
   if (newContent == nil) then
      self:clear();
      return;
   end
   if (flushStack) then
      self.history = {};
   end

   -- If no change in reference/content then fall back to page change/display
   if (((newRef ~= nil) and (newRef == self.contentRef))
       or ((newRef == nil) and (newContent == self.content))) then
      if (newPage) then
	 self:setPage(newPage);
      else
	 self:display();
      end
      return;
   end

   -- If not flushing stack, and there's something to save, update history
   if (self.content and (not flushStack)) then
      local newHist = {};
      newHist.page = self.page;
      if (self.contentRef) then
	 newHist.ref = self.contentRef;
      else
	 newHist.content = self.content;
      end
      if (not self.history) then
	 self.history = {};
      end
      table.insert(self.history, newHist);
   end
   
   -- Update content and then set page
   self.content = newContent;
   self.contentRef = newRef;
   if (newPage) then
      self:setPage(newPage);
   else 
      self:setPage(newContent.minPage);
   end
end

function ViewBase:refresh()
   if (self.content) then
      self:display();
   end
end

function ViewBase:back(steps)
   if (steps == nil) then
      steps = 1;
   end
   if (steps <= 0) then
      return;
   end

   local history = self.history;
   if (not history) then
      self:clear();
      return;
   end

   local histEntry;
   -- Pop entries off the end of the history stack
   while (steps > 0) do
      steps = steps - 1;
      if (table.getn(history) < 1) then
	 self:clear();
	 return;
      end
      histEntry = table.remove(history);
   end

   if (histEntry == nil) then
      self:clear();
      return;
   end

   self.contentRef = histEntry.ref;
   if (self.contentRef) then
      self.content = self.contentRef:getContent();
   else
      self.content = histEntry.content;
   end
   if (not self.content) then
      self:clear();
   else
      self:setPage(histEntry.page);
   end
end

function ViewBase:clear()
   self.history = {};
   self.page = 0;
   self.content = nil;
   self.contentRef = nil;
   self:display();
end

function ViewBase:resolveHref(href)
   local content = self.content;
   if (content and content.resolveHref) then
      if (content:resolveHref(href, self, self.page)) then
	 return true;
      end
   end
   return Bookworm.BaseResolveHref(href, self);
end


function Bookworm.BaseResolveHref(href, view)
   if (strsub(href,1,3) == "bw:") then
      return false;
   end
   SetItemRef(href);
   return true;
end
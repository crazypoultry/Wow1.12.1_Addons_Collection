------------------------------------------------------------------------------
-- BookwormHelp.lua
--
-- Author: Daniel Stephens <daniel@vigilance-committee.org>
-- Author: Iriel <iriel@vigilance-committee.org>
--
-- Help content object (Localization in other files)
---------------------------------------------------------------------------

-- Grab local references to title and page content, supplied by appropriate
-- localized version.
local HELP_TITLE = Bookworm_HelpData.title;
local HELP_PAGES = Bookworm_HelpData.pages;

Bookworm.CONTENT_HELP = {
   title = HELP_TITLE,
   minPage = 1,
   maxPage = table.getn(HELP_PAGES),
   getPageLabel =
      function (self,page) 
	 return page .. "/" .. self.maxPage;
      end,

   getPageContent =
      function (self,page) 
	 return HELP_PAGES[page];
      end,
   
   getPageMaterial = 
      function (self,page) 
	 return nil; 
      end,
}

Bookworm.CONTENT_REF_HELP = {
   getContent = 
      function(self)
	 return Bookworm.CONTENT_HELP;
      end;
}

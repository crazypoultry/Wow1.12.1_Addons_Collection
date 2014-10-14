--[[-------------------------------------------------------------------------
-- Bartender2_Pagemaster - Performs page swaps on bar 1 when you hold shift, ctrl, alt, etc.
--  original version by Khyax and Mikma
--  extended by PProvost to include features from Greywind's Bartender2_Druidbar
--
--  Last Modified: $Date: 2006-10-19 00:39:17 -0400 (Thu, 19 Oct 2006) $
--  Revision: $Revision: 14374 $
--]]-------------------------------------------------------------------------

function BT2Pagemaster:GetOptions()
	local L = AceLibrary("AceLocale-2.2"):new("Bartender_Pagemaster")
	return {
		type = 'group',
		name = 'Pagemaster Options',
		desc = 'Sets the options for the Pagemaster module',
		args = {
			targetFriendlyPage = {
				type = 'range',
				name = L["OPT_TARGETFRIENDLYPAGE_NAME"],
				desc = L["OPT_TARGETFRIENDLYPAGE_DESC"],
				min = 0,
				max = 10,
				step = 1,
				get = function()
					return self.db.profile.targetFriendlyPage
				end,
				set = function(val)
					self.db.profile.targetFriendlyPage = val
				end
			},
			shiftPage = {
				type = 'range',
				name = L["OPT_SHIFTPAGE_NAME"],
				desc = L["OPT_SHIFTPAGE_DESC"],
				min = 0,
				max = 10,
				step = 1,
				get = function()
					return self.db.profile.shiftPage
				end,
				set = function(val)
					self.db.profile.shiftPage = val
				end
			},
			controlPage = {
				type = 'range',
				name = L["OPT_CONTROLPAGE_NAME"],
				desc = L["OPT_CONTROLPAGE_DESC"],
				min = 0,
				max = 10,
				step = 1,
				get = function()
					return self.db.profile.controlPage
				end,
				set = function(val)
					self.db.profile.controlPage = val
				end
			},
			altPage = {
				type = 'range',
				name = L["OPT_ALTPAGE_NAME"],
				desc = L["OPT_ALTPAGE_DESC"],
				min = 0,
				max = 10,
				step = 1,
				get = function()
					return self.db.profile.altPage
				end,
				set = function(val)
					self.db.profile.altPage = val
				end
			},
			prowlPage = {
				type = 'range',
				name = L["OPT_PROWLPAGE_NAME"],
				desc = L["OPT_PROWLPAGE_DESC"],
				min = 0,
				max = 10,
				step = 1,
				get = function()
					return self.db.profile.prowlPage
				end,
				set = function(val)
					self.db.profile.prowlPage = val
				end
			},
			shadowformPage = {
				type = 'range',
				name = L["OPT_SHADOWFORMPAGE_NAME"],
				desc = L["OPT_SHADOWFORMPAGE_DESC"],
				min = 0,
				max = 10,
				step = 1,
				get = function()
					return self.db.profile.shadowformPage
				end,
				set = function(val)
					self.db.profile.shadowformPage = val
				end
			}
		}
	}
end


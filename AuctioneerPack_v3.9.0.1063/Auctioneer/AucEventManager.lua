--[[
	Auctioneer Addon for World of Warcraft(tm).
	Version: 3.9.0.1063 (Kangaroo)
	Revision: $Id: AucEventManager.lua 1031 2006-10-04 04:15:38Z mentalpower $

	AucEventManager - Auctioneer eventing system

	License:
		This program is free software; you can redistribute it and/or
		modify it under the terms of the GNU General Public License
		as published by the Free Software Foundation; either version 2
		of the License, or (at your option) any later version.

		This program is distributed in the hope that it will be useful,
		but WITHOUT ANY WARRANTY; without even the implied warranty of
		MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
		GNU General Public License for more details.

		You should have received a copy of the GNU General Public License
		along with this program(see GPL.txt); if not, write to the Free Software
		Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
--]]

-------------------------------------------------------------------------------
-- Function Imports
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Function Prototypes
-------------------------------------------------------------------------------
local registerEvent;
local unregisterEvent;
local fireEvent;
local getListeners;
local debugPrint;

-------------------------------------------------------------------------------
-- Private Data
-------------------------------------------------------------------------------
local EventListeners = {};

-------------------------------------------------------------------------------
-- Registers for an auctioneer event.
-------------------------------------------------------------------------------
function registerEvent(eventName, callbackFunc)
	local listeners = getListeners(eventName, true);
	table.insert(listeners, callbackFunc);
end

-------------------------------------------------------------------------------
-- Unregisters for an auctioneer event.
-------------------------------------------------------------------------------
function unregisterEvent(eventName, callbackFunc)
	local listeners = getListeners(eventName, false);
	if (listeners ~= nil) then
		for index, thisCallbackFunc in pairs(listeners) do
			if (thisCallbackFunc == callbackFunc) then
				table.remove(listeners, index);
				if (table.getn(listeners) == 0) then
					EventListeners[eventName] = nil;
				end
				break;
			end
		end
	end
end

-------------------------------------------------------------------------------
-- Unregisters for an auctioneer event.
-------------------------------------------------------------------------------
function fireEvent(eventName, arg1, arg2, arg3, arg4, arg5)
	local listeners = getListeners(eventName, false);
	if (listeners ~= nil) then
		--debugPrint("Begin firing event: "..eventName);
		for index, callbackFunc in pairs(listeners) do
			callbackFunc(eventName, arg1, arg2, arg3, arg4, arg5);
		end
		--debugPrint("End firing event: "..eventName);
	end
end

-------------------------------------------------------------------------------
-- Gets the list of registered listeners for the specified event.
-------------------------------------------------------------------------------
function getListeners(eventName, create)
	local listeners = EventListeners[eventName];
	if (listeners == nil and create) then
		listeners = {};
		EventListeners[eventName] = listeners;
	end
	return listeners;
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function debugPrint(message)
	EnhTooltip.DebugPrint("[Auc.EventManager] "..message);
end

-------------------------------------------------------------------------------
-- Public API
-------------------------------------------------------------------------------
Auctioneer.EventManager = {
	RegisterEvent = registerEvent;
	UnregisterEvent = unregisterEvent;
	FireEvent = fireEvent;
}

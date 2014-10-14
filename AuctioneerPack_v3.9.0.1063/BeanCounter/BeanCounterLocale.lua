--[[
	BeanCounter Addon for World of Warcraft(tm).
	Version: 3.9.0.1056 (Kangaroo)
	Revision: $Id: BeanCounterLocale.lua 947 2006-07-13 14:09:47Z mentalpower $

	BeanCounterLocale
	Functions for localizing BeanCounter
	Thanks to Telo for the LootLink code from which this was based.

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

BeanCounter_CustomLocalizations = {
	['MailAllianceAuctionHouse'] = GetLocale(),
	['MailAuctionCancelledSubject'] = GetLocale(),
	['MailAuctionExpiredSubject'] = GetLocale(),
	['MailAuctionSuccessfulSubject'] = GetLocale(),
	['MailAuctionWonSubject'] = GetLocale(),
	['MailHordeAuctionHouse'] = GetLocale(),
	['MailOutbidOnSubject'] = GetLocale(),
}

function _BC(stringKey, locale)
	if (locale) then
		if (type(locale) == "string") then
			return Babylonian.FetchString(BeanCounterLocalizations, locale, stringKey);
		else
			return Babylonian.FetchString(BeanCounterLocalizations, GetLocale(), stringKey);
		end
	elseif (BeanCounter_CustomLocalizations[stringKey]) then
		return Babylonian.FetchString(BeanCounterLocalizations, BeanCounter_CustomLocalizations[stringKey], stringKey)
	else
		local str = Babylonian.GetString(BeanCounterLocalizations, stringKey)
		if (not str) then return stringKey end
		return str
	end
end


--[[
--
--	Sea
--
--	A WoW function library.
--
--	To use a Sea function, just include a Sea dependency,
--	Then use Sea.Library.Function(args);
--
--	This uses a very Java-like organizational system.
--
--	Thanks to:
--		The Cosmos Team (esp. Thott and AlexanderYoshi)
--		CT Mod	(Cide)
--		GypsyMod (Mondinga)
--
--	For all of your creativity and input.
--
--	$Author: Miravlix $
--	$Date: 2006-08-13 23:22:54 -0500 (Sun, 13 Aug 2006) $
--	$Rev: 3877 $
--
--]]

--
-- Sea, mother of all.
--
Sea = {
	-- Version number
	-- This should be incremented for any changes at all, except for TOC changes
	-- Only increment once per release, and only by 0.01
	version = 1.21;

	-- Input/Output Libraries
	IO = {};

	-- Data Lists (Herbs, Ore, Food, Zones, etc)
	data = {};

	-- Mathematical Things
	math = {};

	-- String Modifying Functions
	string = {};

	-- Custom Table Functions
	table = {};

	-- Utility Functions
	util = {};

	-- WoW UI Modifying / Caching Functions
	wow = {};
	
	-- Versioning for comparison with external embedable Mini-Libs
	versions = {};
};

if (not SpellStatusFuLocals) then
    SpellStatusFuLocals = AceLibrary("AceLocale-2.0"):new("SpellStatusFu")
end

SpellStatusFuLocals:RegisterTranslations(
	"enUS", 
	function() 
		return {
			["true"] = true,
			["false"] = true,

			["Combating"] = true,
			["Attacking"] = true,
			["Auto Repeating"] = true,
			["Wanding"] = true,
			
			["Using"] = true,
			["Preparing"] = true,
			["Casting"] = true,
			["Channeling"] = true,
			["Next Meleeing"] = true,
			
			["Active Id"] = true,
			["Active Name"] = true,
			["Active Rank"] = true,
			["Active Full Name"] = true,
			
			["Next Melee Id"] = true,
			["Next Melee Name"] = true,
			["Next Melee Rank"] = true,
			["Next Melee Full Name"] = true,
			
		} 
	end
)

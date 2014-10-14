-- Displayed text formatting
SpellDPS_XPS = {"(%.1f damage per second)", "(%.1f healing per second)"}
SpellDPS_XPM = {"%.2f dpm", "%.2f hpm"}
SpellDPS_TX  = {"%d total damage", "%d total healing"}
SpellDPS_Color = {chat={r=1,g=1,b=1}}

-- Tooltip parsing templates, prelude
SpellDPS_Mana   = "^(%d+) Mana"
SpellDPS_Cast1  = "^(%d+) sec cast"
SpellDPS_Cast2  = "^(%d+)%.(%d) sec cast"
SpellDPS_Weapon = "^Requires %a+ Weapon"
SpellDPS_Totem  = "Tools: Fire Totem"
SpellDPS_Reagents = "Reagents:"

-- Tooltip parsing templates, description
-- {effect index; low#, high#, sec#1, #2, sec#2}
SpellDPS_Desc = {
    {1; {1,2,0,3,4,0}; " (%d+) to (%d+) %a+ damage and .+ (%d+) .+ damage over (%d+) sec"};
    {1; {1,2,3,0,0,0}; " (%d+) to (%d+) %a+ damage over (%d+) sec"};
    {1; {1,1,0,2,3,0}; " (%d+) Fire damage .+ (%d+) Fire damage over (%d+) sec"};
    {1; {0,0,0,1,2,0}; " (%d+) %a+ damage over (%d+) sec"};
    {1; {1,2,3,0,0,1}; " (%d+) to (%d+) %a+ damage each second for (%d+) sec"};
    {1; {1,1,2,0,0,1}; " (%d+) %a+ damage each second for (%d+) sec"};
    {1; {2,2,1,0,0,2}; " for (%d+) sec that causes (%d+) Fire damage"};
    {1; {2,3,1,0,0,2.5}; " for (%d+) sec .+ (%d+) to (%d+) Fire damage"};
    {1; {1,2,0,0,0,0}; " (%d+) to (%d+) %a+ damage"};
    {1; {1,1,2,0,0,1}; "^Transfers (%d+) health every second .+ Lasts (%d+) sec"};
    {1; {1,1,2,0,0,1}; " (%d+) %a+ damage .+ every 1 sec%.  Lasts (%d+) sec"};
    {1; {1,1,2,0,0,3}; " (%d+) health .+ every 3 sec%.  Lasts (%d+) sec"};
    {2; {1,1,2,0,0,1}; " (%d+) health every second .+ Lasts (%d+) sec"};
    {2; {1,2,0,3,4,0}; "^Heals .+ for (%d+) to (%d+) and another (%d+) over (%d+) sec"};
    {2; {1,2,0,0,0,0}; "[Hh]eal.+ for (%d+) to (%d+)"};
    {2; {0,0,0,1,2,0}; "^Heals .+ for (%d+) over (%d+) sec"};
    {2; {0,0,0,1,2,0}; "^Heals .+ of (%d+) damage over (%d+) sec"};
    {1; {0,0,0,1,2,0}; "^Absorbs (%d+) %a+ damage%.  Lasts (%d+) sec"};
    {1; {2,3,0,1,-60,-1}; "Absorbs (%d+) physical damage.+ Drains (%d+)%.(%d) mana"};
    {1; {0,0,0,1,2,0}; " absorbing (%d+) damage.+ for (%d+) sec"};
    {1; {0,0,0,1,0,0}; "^Causes (%d+) %a+ damage"};
    {1; {0,0,0,1,-6,0}; " causes (%d+) %a+ damage"};
    {1; {0,0,0,1,-6,0}; " damage by (%d+)"};
    {1; {0,0,0,1,0,0}; " additional (%d+) damage"};
    {1; {0,0,0,1,-60,0}; " causing (%d+) %a+ damage after 1 min"};
    {1; {1,2,0,0,0,-2}; "^Drains (%d+) to (%d+) mana"};
    }

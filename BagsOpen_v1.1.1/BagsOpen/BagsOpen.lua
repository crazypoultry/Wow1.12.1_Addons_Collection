local backpack = 0;
local bag1 = 0;
local bag2 = 0;
local bag3 = 0;
local bag4 = 0;

function BagsOpen_OnLoad()

  SLASH_BagsOpen1 = "/BagsOpen";
  SlashCmdList["BagsOpen"] = function()
    BagsOpen_DoThing();
  end

  this:RegisterEvent("CLOSE_WORLD_MAP");

  BagsOpen_Orig_ToggleWorldMap = ToggleWorldMap;
  ToggleWorldMap = BagsOpen_ToggleWorldMap;

end

function BagsOpen_OnEvent(event)
  --Map closed with Esc
  if ( event == "CLOSE_WORLD_MAP" ) then
    BagsOpen_MapClose();
  end

end

function BagsOpen_ToggleWorldMap()
  --Map opened/closed with keybinding
  if (WorldMapFrame:IsVisible()) then
    BagsOpen_Orig_ToggleWorldMap();
    BagsOpen_MapClose();
  else
    BagsOpen_MapOpen();
    BagsOpen_Orig_ToggleWorldMap();
  end

end

function BagsOpen_CheckBagsOpen()

  backpack = IsBagOpen(0);
  bag1 = IsBagOpen(1);
  bag2 = IsBagOpen(2);
  bag3 = IsBagOpen(3);
  bag4 = IsBagOpen(4);

  if (backpack == nil) then
    backpack = 0;
  end
  if (bag1== nil) then
    bag1= 0;
  end
  if (bag2== nil) then
    bag2= 0;
  end
  if (bag3== nil) then
    bag3= 0;
  end
  if (bag4== nil) then
    bag4 = 0;
  end

end

function BagsOpen_MapOpen()

  BagsOpen_CheckBagsOpen();

end

function BagsOpen_MapClose()

  if (backpack > 0) then
    ToggleBag(0);
  end
  if (bag1 > 0) then
    ToggleBag(1);
  end
  if (bag2 > 0) then
    ToggleBag(2);
  end
  if (bag3 > 0) then
    ToggleBag(3);
  end
  if (bag4 > 0) then
    ToggleBag(4);
  end

end
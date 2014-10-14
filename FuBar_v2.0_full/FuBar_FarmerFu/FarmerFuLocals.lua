if not ace:LoadTranslation("FarmerFu") then

  FarmerFuLocals = {
    Name        = "FuBar - FarmerFu",
    Description = "Keeps track of what you are farming",
    
    ChatCmd = {"/farmerfu", "/ffu"},

    ChatOpt = {
      {
        option = "add",
        desc   = "Add item to the list.",
        method = "AddItem",
        input  = true,
      },
    },

    Tooltip = {
      Hint = "Shift-Ctrl click items to add to the list.",
    },

    Menu = {
      Remove     = "Remove",
      Monitor    = "Monitor",
      AllItems   = "All Items",
      Sort       = "Sort",
      Field      = "Field",
      Direction  = "Direction",
      ByItem     = "By Item",
      ByCount    = "By Count",
      Ascending  = "Ascending",
      Descending = "Descending",
    },
  }

end
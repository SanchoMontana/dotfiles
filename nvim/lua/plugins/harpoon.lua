return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {},
  keys = function()
    local harpoon = require("harpoon")
    local function jump(i)
      return function() harpoon:list():select(i) end
    end
    return {
      { "<leader>a", function() harpoon:list():add() end, desc = "Harpoon Add File" },
      { "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, desc = "Harpoon Quick Menu" },
      { "<A-1>", jump(1), desc = "Harpoon to File 1" },
      { "<A-2>", jump(2), desc = "Harpoon to File 2" },
      { "<A-3>", jump(3), desc = "Harpoon to File 3" },
      { "<A-4>", jump(4), desc = "Harpoon to File 4" },
    }
  end,
}

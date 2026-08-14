-- Full git UI on top of LazyVim's default gitsigns + lazygit keymaps.
-- <leader>g* is already used for lazygit/log/blame/browse/hunks, so these
-- live on the free gn/gd/gH slots.
return {
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim",
    },
    cmd = "Neogit",
    keys = {
      { "<leader>gn", function() require("neogit").open() end, desc = "Neogit" },
    },
    opts = {
      integrations = { telescope = true, diffview = true },
    },
  },
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Diff View" },
      { "<leader>gH", "<cmd>DiffviewFileHistory<cr>", desc = "File History" },
    },
    opts = {},
  },
}

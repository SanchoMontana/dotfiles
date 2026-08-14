-- Visual glow-up: theme + dashboard extras + animated indent/scroll +
-- fancy notifications, all layered on LazyVim's existing snacks/lualine setup.
return {
  {
    "ellisonleao/gruvbox.nvim",
    opts = {
      contrast = "hard",
    },
  },

  { "LazyVim/LazyVim", opts = { colorscheme = "gruvbox" } },

  {
    "snacks.nvim",
    opts = function(_, opts)
      -- Extra dashboard shortcuts for the tools we just added.
      table.insert(opts.dashboard.preset.keys, 6, {
        icon = " ",
        key = "H",
        desc = "Harpoon",
        action = function()
          require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())
        end,
      })
      table.insert(opts.dashboard.preset.keys, 7, {
        icon = " ",
        key = "G",
        desc = "Neogit",
        action = function()
          require("neogit").open()
        end,
      })

      opts.indent.animate = { enabled = true }
      opts.scroll.animate = { duration = { step = 8, total = 150 }, easing = "linear" }
      opts.notifier.style = "fancy"

      return opts
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      opts.options.theme = "gruvbox"
      opts.options.globalstatus = true
    end,
  },
}

-- The language extras themselves are imported in config/lazy.lua, before
-- the `plugins` import, so LazyVim's import-order check doesn't flag them.
return {
  -- Makefiles have no LazyVim extra; just teach treesitter about them.
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "make" })
    end,
  },
}

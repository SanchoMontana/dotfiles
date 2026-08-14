return {
  {
    "renerocksai/telekasten.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "renerocksai/calendar-vim" },
    cmd = "Telekasten",
    ft = "markdown",
    config = function()
      -- Every subdirectory of `vaults_parent` becomes its own telekasten
      -- vault, keyed by folder name. Add a vault with `mkdir`, nothing else.
      -- ~/maps is the ONLY place zettelkastens live.
      local vaults_parent = vim.fn.expand("~/maps")
      local vaults = {}
      local names = {}
      for _, dir in ipairs(vim.fn.glob(vaults_parent .. "/*", true, true)) do
        if vim.fn.isdirectory(dir) == 1 then
          local name = vim.fn.fnamemodify(dir, ":t")
          vaults[name] = {
            home = dir,
            dailies = dir .. "/daily",
            weeklies = dir .. "/weekly",
            templates = dir .. "/templates",
          }
          table.insert(names, name)
        end
      end
      table.sort(names)

      -- Default vault = whichever one contains the cwd (so `cd`-ing into a
      -- vault before opening nvim makes it active automatically). Falls
      -- back to the first vault alphabetically if cwd isn't inside any of
      -- them. No vault name is ever hardcoded here.
      local cwd = vim.fn.getcwd()
      local default = names[1] and vaults[names[1]]
      for _, v in pairs(vaults) do
        if cwd == v.home or cwd:sub(1, #v.home + 1) == v.home .. "/" then
          default = v
          break
        end
      end

      require("telekasten").setup(vim.tbl_extend("force", { vaults = vaults }, default or {}))

      -- telekasten doesn't bind <CR> to follow_link itself; wire it up for
      -- markdown buffers, including any already open before this plugin
      -- lazy-loaded.
      local function bind_follow_link(buf)
        vim.keymap.set("n", "<cr>", "<cmd>Telekasten follow_link<cr>", { buffer = buf, desc = "Telekasten: Follow Link" })
      end

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        group = vim.api.nvim_create_augroup("telekasten_follow_link", { clear = true }),
        callback = function(ev)
          bind_follow_link(ev.buf)
        end,
      })

      for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].filetype == "markdown" then
          bind_follow_link(buf)
        end
      end

      -- README-suggested highlight groups for [[links]] and #tags
      local function set_telekasten_highlights()
        vim.api.nvim_set_hl(0, "tkLink", { link = "@markup.link", default = true })
        vim.api.nvim_set_hl(0, "tkAliasedLink", { link = "Comment", default = true })
        vim.api.nvim_set_hl(0, "tkBrackets", { link = "Comment", default = true })
        vim.api.nvim_set_hl(0, "tkHighlight", { link = "IncSearch", default = true })
        vim.api.nvim_set_hl(0, "tkTag", { link = "Tag", default = true })
      end
      set_telekasten_highlights()
      vim.api.nvim_create_autocmd("ColorScheme", {
        group = vim.api.nvim_create_augroup("telekasten_highlights", { clear = true }),
        callback = set_telekasten_highlights,
      })
    end,
    keys = {
      -- Command palette: launches if nothing is typed after <leader>z
      { "<leader>z", "<cmd>Telekasten panel<cr>", desc = "Zettelkasten: Panel" },
      { "<leader>zf", "<cmd>Telekasten find_notes<cr>", desc = "Zettelkasten: Find Notes" },
      { "<leader>zg", "<cmd>Telekasten search_notes<cr>", desc = "Zettelkasten: Search" },
      { "<leader>zd", "<cmd>Telekasten goto_today<cr>", desc = "Zettelkasten: Today" },
      { "<leader>zz", "<cmd>Telekasten follow_link<cr>", desc = "Zettelkasten: Follow Link" },
      { "<leader>zn", "<cmd>Telekasten new_note<cr>", desc = "Zettelkasten: New Note" },
      { "<leader>zc", "<cmd>Telekasten show_calendar<cr>", desc = "Zettelkasten: Show Calendar" },
      { "<leader>zb", "<cmd>Telekasten show_backlinks<cr>", desc = "Zettelkasten: Backlinks" },
      { "<leader>zI", "<cmd>Telekasten insert_img_link<cr>", desc = "Zettelkasten: Insert Image Link" },
      { "<leader>zl", "<cmd>Telekasten insert_link<cr>", desc = "Zettelkasten: Insert Link" },
      { "<leader>zv", "<cmd>Telekasten switch_vault<cr>", desc = "Zettelkasten: Switch Vault" },
      { "[[", "<cmd>Telekasten insert_link<cr>", mode = "i", desc = "Zettelkasten: Insert Link" },
    },
  },
}

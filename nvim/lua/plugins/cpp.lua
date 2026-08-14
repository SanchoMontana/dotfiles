-- Extra C/C++ tooling on top of the manual clangd setup in clangd.lua.
-- (Not importing the lang.clangd extra directly: it redefines clangd's
-- `cmd`, which would collide with the custom cmd already set there.)
return {
  -- Inlay hints, AST explorer, type/memory layout views for clangd.
  {
    "p00f/clangd_extensions.nvim",
    ft = { "c", "cpp" },
    opts = { inlay_hints = { inline = false } },
  },

  { "nvim-treesitter/nvim-treesitter", opts = { ensure_installed = { "cpp" } } },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        clangd = {
          keys = {
            { "<leader>ch", "<cmd>LspClangdSwitchSourceHeader<cr>", desc = "Switch Source/Header (C/C++)" },
          },
        },
      },
    },
  },

  -- codelldb debugger for C/C++
  -- (mason-nvim-dap's automatic_installation, enabled by the dap.core extra,
  -- installs codelldb once it sees it referenced below — no need to also
  -- list it under mason's ensure_installed.)
  {
    "mfussenegger/nvim-dap",
    opts = function()
      local dap = require("dap")
      if not dap.adapters.codelldb then
        dap.adapters.codelldb = {
          type = "server",
          host = "localhost",
          port = "${port}",
          executable = { command = "codelldb", args = { "--port", "${port}" } },
        }
      end
      for _, lang in ipairs({ "c", "cpp" }) do
        dap.configurations[lang] = {
          {
            type = "codelldb",
            request = "launch",
            name = "Launch file",
            program = function()
              return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
            end,
            cwd = "${workspaceFolder}",
          },
          {
            type = "codelldb",
            request = "attach",
            name = "Attach to process",
            pid = require("dap.utils").pick_process,
            cwd = "${workspaceFolder}",
          },
        }
      end
    end,
  },
}

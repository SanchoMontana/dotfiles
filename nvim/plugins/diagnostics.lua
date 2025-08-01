return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        underline = {
          severity = { min = vim.diagnostic.severity.ERROR },
        },
        virtual_text = {
          severity = vim.diagnostic.severity.ERROR,
        },
        signs = {
          severity = vim.diagnostic.severity.ERROR,
        },
        float = {
          severity = vim.diagnostic.severity.ERROR,
        },
        severity_sort = true,
      },
    },
  },
}

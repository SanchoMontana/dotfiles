return {
  "echasnovski/mini.map",
  version = false,
  config = function()
    local map = require("mini.map")
    map.setup({
      integrations = {
        map.gen_integration.builtin_search(),
        map.gen_integration.diagnostic(),
        map.gen_integration.gitsigns(),
      },
      symbols = {
        encode = map.gen_encode_symbols.dot("3x2"),
      },
      window = {
        side = "right", -- or "left"
        width = 10,
        winblend = 60,
        show_integration_count = false,
      },
    })

    -- Auto show on file open
    vim.api.nvim_create_autocmd("BufEnter", {
      callback = function()
        map.open()
      end,
    })
  end,
}

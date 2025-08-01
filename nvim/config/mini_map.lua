require("mini.map").setup({
  -- Dot-style symbols, compact and clean
  symbols = {
    encode = require("mini.map").gen_encode_symbols.dot("4x2"),
  },
  -- Window settings
  window = {
    side = "right", -- or 'left'
    width = 10,
    winblend = 25, -- transparency (0 = solid, 100 = invisible)
    show_integration_count = false, -- hide clutter
  },
  -- Integrations with diagnostics and search (optional)
  integrations = {
    require("mini.map").gen_integration.diagnostic(),
    require("mini.map").gen_integration.search(),
  },

  -- Delay for auto update, 0 = instant, higher = smoother on slow systems
  -- Recommended default: 50
  update_delay = 50,
})

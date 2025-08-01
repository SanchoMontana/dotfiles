return {
  {
    "rcarriga/nvim-notify",
    opts = {
      stages = "slide",
      timeout = 2000,
      render = "compact",
    },
    init = function()
      vim.notify = require("notify")
    end,
  },
}

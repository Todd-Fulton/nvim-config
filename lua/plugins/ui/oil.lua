return {
  "stevearc/oil.nvim",
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {},
  cmd = "Oil",
  keys = {
    { "-", "<CMD>Oil<CR>", desc = "Open Oil in Parent Directory" },
  },
  -- Optional dependencies
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
}

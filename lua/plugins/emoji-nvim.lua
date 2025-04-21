return {
  "allaman/emoji.nvim",
  ft = "markdown", -- adjust to your needs
  dependencies = {
    -- util for handling paths
    "nvim-lua/plenary.nvim",
    -- optional for nvim-cmp integration
    "hrsh7th/nvim-cmp",
    -- optional for telescope integration
    "nvim-telescope/telescope.nvim",
  },
  opts = {
    -- default is false
    enable_cmp_integration = true,
  },
  config = function(_, opts)
    require("emoji").setup(opts)
    -- optional for telescope integration
    local ts = require('telescope').load_extension 'emoji'
    vim.keymap.set('n', '<leader>fe', ts.emoji, { desc = '[F]ind [E]moji' })
  end,
}

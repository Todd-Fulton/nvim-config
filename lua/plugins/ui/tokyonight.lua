return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    style = "night",
    transparent = true,
    styles = {
      comments = { italic = true },
      keywords = { italic = true },
      sidebars = "transparent",
      floats = "transparent",
    },
    cache = true,
    dim_inactive = true,
    lualine_bold = true,
    on_colors = function(colors)
      local my_colors = require("user.configs.ui.colors")
      colors.bg = my_colors.transparent
      colors.bg_dark = my_colors.transparent
      colors.bg_highlight = my_colors.bg_highlight
      colors.bg_popup = my_colors.transparent
      colors.bg_search = my_colors.bg_search
      colors.bg_sidebar = my_colors.transparent
      colors.bg_statusline = my_colors.transparent
      colors.bg_visual = my_colors.bg_visual
      colors.border = my_colors.bg_dark
      colors.fg = my_colors.shakespeare
      colors.fg_dark = my_colors.fg_dark
      colors.fg_float = my_colors.fg
      colors.fg_gutter = my_colors.fg_gutter
      colors.fg_sidebar = my_colors.fg_dark
      colors.green1 = my_colors.puerto_rico
      colors.comment = my_colors.dark5
      colors.dark5 = my_colors.shuttle_gray
      return colors
    end,
    ---@param hl tokyonight.Highlights
    ---@param colors ColorScheme
    on_highlights = function(hl, colors)
      hl["LspInlayHint"].bg = colors.bg
      hl["FloatBorder"] = {fg = colors.orange, bg = colors.bg }
      hl["NoiceCmdlinePopupBorderCmdline"] = hl["FloatBorder"]
      hl["NoiceCmdlinePopupBorder"] = hl["FloatBorder"]
      hl["NoicePopupmenuBorder"] = hl["FloatBorder"]
      hl["NeoTreeNormal"] = { bg = "none" }
      hl["NeoTreeNormalNC"] = hl["NeoTreeNormal"]
    end
  },
  config = function(_, opts)
    opts = opts or {}
    require("tokyonight").setup(opts)
    vim.cmd [[colorscheme tokyonight-night]]
  end
}

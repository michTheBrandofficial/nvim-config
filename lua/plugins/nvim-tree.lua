return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("nvim-tree").setup({
      view = {
        side = 'left',
      },
      update_focused_file = {
        enable = true,
        update_cwd = true,
      },
      filters = {
        dotfiles = false,
      },
      diagnostics = {
        enable = true,
      },
      git = {
        enable = true,
        ignore = false,
        timeout = 500,
      },
    })
  end
}
